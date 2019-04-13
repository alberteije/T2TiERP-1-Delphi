{*******************************************************************************
Title: T2Ti ERP
Description: Controller do lado Servidor relacionado à tabela [COMPRA_COTACAO]

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
*******************************************************************************}
unit CompraCotacaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TCompraCotacaoController = class(TController)
  protected
  public
    // consultar
    function CompraCotacao(pSessao: string; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptCompraCotacao(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateCompraCotacao(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelCompraCotacao(pSessao: string; pId: Integer): TJSONArray;
  end;

implementation

uses
  SA, T2TiORM, Biblioteca, CompraFornecedorCotacaoVO, CompraCotacaoDetalheVO,
  CompraCotacaoVO, CompraReqCotacaoDetalheVO, CompraRequisicaoDetalheVO;

{ TCompraCotacaoController }

var
  objCompraCotacao: TCompraCotacaoVO;
  Resultado: Boolean;

function TCompraCotacaoController.CompraCotacao(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TCompraCotacaoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TCompraCotacaoVO>(pFiltro, pPagina, False);
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

function TCompraCotacaoController.AcceptCompraCotacao(pSessao: string; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID, UltimoIDFornecedorCotacao, UltimoIDCotacaoDetalhe: Integer;
  CompraFornecedorCotacao: TCompraFornecedorCotacaoVO;
  CompraCotacaoDetalhe: TCompraCotacaoDetalheVO;
  CompraReqCotacaoDetalhe: TCompraReqCotacaoDetalheVO;
  CompraRequisicaoDetalhe: TCompraRequisicaoDetalheVO;
  CompraReqCotacaoDetalheEnumerator: TEnumerator<TCompraReqCotacaoDetalheVO>;
  ListaCompraFornecedorCotacaoJson, ListaCompraCotacaoDetalheJson: TJSONValue;
  i, j: Integer;
begin
  // O primeiro item traz a cotação
  objCompraCotacao := TCompraCotacaoVO.Create((pObjeto as TJSONArray).Get(0));

  // O segundo item traz a lista de fornecedores
  ListaCompraFornecedorCotacaoJson := (pObjeto as TJSONArray).Get(1);

  // O terceiro item traz a lista de produtos
  ListaCompraCotacaoDetalheJson := (pObjeto as TJSONArray).Get(2);

  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objCompraCotacao);

      try
        for i := 0 to (ListaCompraFornecedorCotacaoJson as TJSONArray).Size - 1 do
        begin
          CompraFornecedorCotacao := TCompraFornecedorCotacaoVO.Create((ListaCompraFornecedorCotacaoJson as TJSONArray).Get(i));
          CompraFornecedorCotacao.IdCompraCotacao := UltimoID;
          UltimoIDFornecedorCotacao := TT2TiORM.Inserir(CompraFornecedorCotacao);

          for j := 0 to (ListaCompraCotacaoDetalheJson as TJSONArray).Size - 1 do
          begin
            CompraCotacaoDetalhe := TCompraCotacaoDetalheVO.Create((ListaCompraCotacaoDetalheJson as TJSONArray).Get(j));
            CompraCotacaoDetalhe.IdCompraFornecedorCotacao := UltimoIDFornecedorCotacao;
            UltimoIDCotacaoDetalhe := TT2TiORM.Inserir(CompraCotacaoDetalhe);
          end;
        end;
      finally
      end;

      // Lista de itens da requisição que foram utilizados na cotação
      CompraReqCotacaoDetalheEnumerator := objCompraCotacao.ListaCompraReqCotacaoDetalheVO.GetEnumerator;
      try
        CompraRequisicaoDetalhe := TCompraRequisicaoDetalheVO.Create;
        with CompraReqCotacaoDetalheEnumerator do
        begin
          while MoveNext do
          begin
            //insere os items em COMPRA_REQ_COTACAO_DETALHE
            CompraReqCotacaoDetalhe := Current;
            CompraReqCotacaoDetalhe.IdCompraCotacao := UltimoID;
            TT2TiORM.Inserir(CompraReqCotacaoDetalhe);

            //atualiza a quantidade cotada em COMPRA_REQUISICAO_DETALHE
            CompraRequisicaoDetalhe.Id := CompraReqCotacaoDetalhe.IdCompraRequisicaoDetalhe;
            CompraRequisicaoDetalhe.QuantidadeCotada := CompraReqCotacaoDetalhe.QuantidadeCotada;
            TT2TiORM.Alterar(CompraRequisicaoDetalhe);
          end;
        end;
      finally
        CompraReqCotacaoDetalheEnumerator.Free;
      end;
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objCompraCotacao.Free;
  end;

  Result := CompraCotacao(pSessao, 'ID=' + IntToStr(UltimoID), 0);
end;

function TCompraCotacaoController.UpdateCompraCotacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objCompraCotacaoOld: TCompraCotacaoVO;
begin
  // Objeto Novo
  objCompraCotacao := TCompraCotacaoVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objCompraCotacaoOld := TCompraCotacaoVO.Create((pObjeto as TJSONArray).Get(1));

  Result := TJSONArray.Create;
  try
    // Verifica se houve alterações no objeto principal
    if objCompraCotacao.MainObject.ToJSONString <> objCompraCotacaoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objCompraCotacao, objCompraCotacaoOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

  finally
    objCompraCotacao.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TCompraCotacaoController.CancelCompraCotacao(pSessao: string; pId: Integer): TJSONArray;
begin
  objCompraCotacao := TCompraCotacaoVO.Create;
  Result := TJSONArray.Create;
  try
    objCompraCotacao.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objCompraCotacao);
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
    objCompraCotacao.Free;
  end;
end;

end.