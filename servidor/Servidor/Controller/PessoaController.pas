{ *******************************************************************************
Title: T2Ti ERP
Description: Controller do lado Servidor relacionado à tabela [PESSOA]

The MIT License

Copyright: Copyright (C) 2010 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

The author may be contacted at:
t2ti.com@gmail.com</p>

t2ti.com@gmail.com | fernandololiver@gmail.com
@author Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0
******************************************************************************* }
unit PessoaController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPessoaController = class(TController)
  protected
  public
    // consultar
    function Pessoa(pSessao: string; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptPessoa(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdatePessoa(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelPessoa(pSessao: string; pId: Integer): TJSONArray;
  end;

implementation

uses
  PessoaVO, T2TiORM, Biblioteca, PessoaFisicaVO, PessoaJuridicaVO, ContatoVO, EnderecoVO, sa,
  EmpresaPessoaVO;

{ TPessoaController }

var
  objPessoa: TPessoaVO;
  Resultado: Boolean;

function TPessoaController.Pessoa(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TPessoaVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TPessoaVO>(pFiltro, pPagina, False);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(Result.ToString);
end;

function TPessoaController.AcceptPessoa(pSessao: string; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  EmpresaPessoa: TEmpresaPessoaVO;
  Contato: TContatoVO;
  Endereco: TEnderecoVO;
  ContatosEnumerator: TEnumerator<TContatoVO>;
  EnderecosEnumerator: TEnumerator<TEnderecoVO>;
  TipoPessoa: string;
begin
  objPessoa := TPessoaVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      TipoPessoa := objPessoa.Tipo;
      UltimoID := TT2TiORM.Inserir(objPessoa);

      // Empresa Pessoa - Responsável Legal pode ser incluído por qualquer usuário? A ser definido no segundo ciclo.
      EmpresaPessoa := TEmpresaPessoaVO.Create;
      EmpresaPessoa.IdEmpresa := Sessao(pSessao).IdEmpresa;
      EmpresaPessoa.IdPessoa := UltimoID;
      EmpresaPessoa.ResponsavelLegal := 'N';
      TT2TiORM.Inserir(EmpresaPessoa);

      // Tipo de Pessoa
      if (TipoPessoa = 'F') and (Assigned(objPessoa.PessoaFisicaVO)) then
      begin
        objPessoa.PessoaFisicaVO.IdPessoa := UltimoID;
        TT2TiORM.Inserir(objPessoa.PessoaFisicaVO);
      end
      else if (TipoPessoa = 'J') and (Assigned(objPessoa.PessoaJuridicaVO)) then
      begin
        objPessoa.PessoaJuridicaVO.IdPessoa := UltimoID;
        TT2TiORM.Inserir(objPessoa.PessoaJuridicaVO);
      end;

      // Contatos
      ContatosEnumerator := objPessoa.ListaContatoVO.GetEnumerator;
      try
        with ContatosEnumerator do
        begin
          while MoveNext do
          begin
            Contato := Current;
            Contato.IdPessoa := UltimoID;
            TT2TiORM.Inserir(Contato);
          end;
        end;
      finally
        ContatosEnumerator.Free;
      end;

      // Endereços
      EnderecosEnumerator := objPessoa.ListaEnderecoVO.GetEnumerator;
      try
        with EnderecosEnumerator do
        begin
          while MoveNext do
          begin
            Endereco := Current;
            Endereco.IdPessoa := UltimoID;
            TT2TiORM.Inserir(Endereco);
          end;
        end;
      finally
        EnderecosEnumerator.Free;
      end;

    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

  finally
    objPessoa.Free;
  end;

  Result := Pessoa(pSessao, 'ID=' + IntToStr(UltimoID), 0);
end;

function TPessoaController.UpdatePessoa(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  ContatosEnumerator: TEnumerator<TContatoVO>;
  EnderecosEnumerator: TEnumerator<TEnderecoVO>;
  TipoPessoa: String;
  objPessoaOld: TPessoaVO;
begin
  // Objeto Novo
  objPessoa := TPessoaVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objPessoaOld := TPessoaVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    TipoPessoa := objPessoa.Tipo;

    // Verifica se houve alterações no objeto principal
    if objPessoa.MainObject.ToJSONString <> objPessoaOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objPessoa, objPessoaOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Tipo de Pessoa
    try
      if (TipoPessoa = 'F') and (Assigned(objPessoa.PessoaFisicaVO)) then
      begin
        if objPessoa.PessoaFisicaVO.Id > 0 then
          Resultado := TT2TiORM.Alterar(objPessoa.PessoaFisicaVO)
        else
          Resultado := TT2TiORM.Inserir(objPessoa.PessoaFisicaVO) > 0;
      end
      else if (TipoPessoa = 'J') and (Assigned(objPessoa.PessoaJuridicaVO)) then
      begin
        if objPessoa.PessoaJuridicaVO.Id > 0 then
          Resultado := TT2TiORM.Alterar(objPessoa.PessoaJuridicaVO)
        else
          Resultado := TT2TiORM.Inserir(objPessoa.PessoaJuridicaVO) > 0;
      end;
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

    // Contatos
    try
      ContatosEnumerator := objPessoa.ListaContatoVO.GetEnumerator;
      with ContatosEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
            Resultado := TT2TiORM.Inserir(Current) > 0;
        end;
      end;
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

    // Endereços
    try
      EnderecosEnumerator := objPessoa.ListaEnderecoVO.GetEnumerator;
      with EnderecosEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
            Resultado := TT2TiORM.Inserir(Current) > 0;
        end;
      end;
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

  finally
    EnderecosEnumerator.Free;
    ContatosEnumerator.Free;
    objPessoa.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TPessoaController.CancelPessoa(pSessao: string; pId: Integer): TJSONArray;
begin
  objPessoa := TPessoaVO.Create;
  Result := TJSONArray.Create;
  try
    objPessoa.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPessoa);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objPessoa.Free;
  end;
end;

end.
