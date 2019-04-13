{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [EMPRESA] 
                                                                                
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
                                                                                
       t2ti.com@gmail.com
@author Albert Eije
@version 1.0                                                                    
*******************************************************************************}
unit EmpresaController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon,
  Biblioteca, SWSystem;

type
  TEmpresaController = class(TController)
  private
    procedure ArmazenarImagem;
    procedure ArmazenarDadosPadroes;
  protected
  public
    //consultar
    function Empresa(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    function EmpresaSessao(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptEmpresa(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateEmpresa(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelEmpresa(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  EmpresaVO, EmpresaSessaoVO, T2TiORM, SA, ContatoVO, EnderecoVO;

{ TEmpresaController }

var
  objEmpresa: TEmpresaVO;
  Resultado: Boolean;

function TEmpresaController.Empresa(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TEmpresaVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TEmpresaVO>(pFiltro, pPagina, False);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(result.ToString);
end;

function TEmpresaController.EmpresaSessao(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TEmpresaSessaoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TEmpresaSessaoVO>(pFiltro, pPagina, False);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(result.ToString);
end;

function TEmpresaController.AcceptEmpresa(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  Contato: TContatoVO;
  Endereco: TEnderecoVO;
  ContatosEnumerator: TEnumerator<TContatoVO>;
  EnderecosEnumerator: TEnumerator<TEnderecoVO>;
begin
  objEmpresa := TEmpresaVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objEmpresa);
      objEmpresa.Id := UltimoID;

      // Contatos
      ContatosEnumerator := objEmpresa.ListaContatoVO.GetEnumerator;
      try
        with ContatosEnumerator do
        begin
          while MoveNext do
          begin
            Contato := Current;
            Contato.IdEmpresa := UltimoID;
            TT2TiORM.Inserir(Contato);
          end;
        end;
      finally
        ContatosEnumerator.Free;
      end;

      // Endereços
      EnderecosEnumerator := objEmpresa.ListaEnderecoVO.GetEnumerator;
      try
        with EnderecosEnumerator do
        begin
          while MoveNext do
          begin
            Endereco := Current;
            Endereco.IdEmpresa := UltimoID;
            TT2TiORM.Inserir(Endereco);
          end;
        end;
      finally
        EnderecosEnumerator.Free;
      end;

      ArmazenarDadosPadroes;

    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objEmpresa.Free;
  end;
  Result := Empresa(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
end;

function TEmpresaController.UpdateEmpresa(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  ContatosEnumerator: TEnumerator<TContatoVO>;
  EnderecosEnumerator: TEnumerator<TEnderecoVO>;
  objEmpresaOld: TEmpresaVO;
begin
 //Objeto Novo
  objEmpresa := TEmpresaVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objEmpresaOld := TEmpresaVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Se subiu uma imagem, armazena
    if objEmpresa.Imagem <> '' then
      ArmazenarImagem;

    // Limpa a imagem para saber se há mais alterações para efetuar no banco de dados
    objEmpresa.Imagem := '';
    objEmpresa.TipoImagem := '';

    // Verifica se houve alterações no objeto principal
    if objEmpresa.MainObject.ToJSONString <> objEmpresaOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objEmpresa, objEmpresaOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Contatos
    try
      ContatosEnumerator := objEmpresa.ListaContatoVO.GetEnumerator;
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
      EnderecosEnumerator := objEmpresa.ListaEnderecoVO.GetEnumerator;
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
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    EnderecosEnumerator.Free;
    ContatosEnumerator.Free;
    objEmpresa.Free;
  end;
end;

function TEmpresaController.CancelEmpresa(pSessao: String; pId: Integer): TJSONArray;
begin
  objEmpresa := TEmpresaVO.Create;
  Result := TJSONArray.Create;
  try
    objEmpresa.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objEmpresa);
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
    objEmpresa.Free;
  end;
end;

procedure TEmpresaController.ArmazenarImagem;
var
  ArrayStringsArquivo: TStringList;
  ArquivoBytes: TBytes;
  ArquivoStream: TStringStream;
  i: Integer;
begin
  try
    ArrayStringsArquivo := TStringList.Create;
    Split(',', objEmpresa.Imagem, ArrayStringsArquivo);
    SetLength(ArquivoBytes, ArrayStringsArquivo.Count);
    for i := 0 to ArrayStringsArquivo.Count - 1 do
    begin
      ArquivoBytes[i] := StrToInt(ArrayStringsArquivo[i]);
    end;
    ArquivoStream := TStringStream.Create(ArquivoBytes);
    if not DirectoryExists(gsAppPath + 'Arquivos\Imagens')then
      CreateDir(gsAppPath + 'Arquivos\Imagens');
    if not DirectoryExists(gsAppPath + 'Arquivos\Imagens\Empresa')then
      CreateDir(gsAppPath + 'Arquivos\Imagens\Empresa');
    ArquivoStream.SaveToFile(gsAppPath + 'Arquivos\Imagens\Empresa\' + IntToStr(objEmpresa.Id) + objEmpresa.TipoImagem);
  finally
    ArrayStringsArquivo.Free;
    ArquivoStream.Free;
  end;
end;

procedure TEmpresaController.ArmazenarDadosPadroes;
var
  Res: TResourceStream;
  ListaConsulta, ListaDados: TStringList;
  i: Integer;
  Consulta: String;
begin
  try
    Res := TResourceStream.Create(HInstance, 'T2TiERP_PadraoEmpresa', 'TXTFILE');
    ListaDados := TStringList.Create;
    ListaConsulta := TStringList.Create;
    ListaDados.LoadFromStream(Res);
    //
    for i := 0 to ListaDados.Count - 1 do
    begin
      Split('|', ListaDados[i], ListaConsulta);
      Consulta := 'INSERT INTO ' + ListaConsulta[0] +
                  ' (ID_EMPRESA, ' + ListaConsulta[1] + ', ' + ListaConsulta[2] + ' )' +
                  ' VALUES ' +
                  ' (' + IntToStr(objEmpresa.Id) + ', ' + QuotedStr(ListaConsulta[3]) + ', ' + QuotedStr(ListaConsulta[4]) + ')';

      TT2TiORM.ComandoSQL(Consulta);
    end;

  finally
    Res.Free;
    ListaDados.Free;
    ListaConsulta.Free;
  end;
end;

end.
