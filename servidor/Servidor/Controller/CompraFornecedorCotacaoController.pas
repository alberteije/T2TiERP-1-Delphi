{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [COMPRA_FORNECEDOR_COTACAO] 
                                                                                
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
           t2ti.com@gmail.com                                                   

@author Albert Eije (t2ti.com@gmail.com)
@version 1.0
*******************************************************************************}
unit CompraFornecedorCotacaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TCompraFornecedorCotacaoController = class(TController)
  protected
  public
    //consultar
    function CompraFornecedorCotacao(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //alterar
    function UpdateCompraFornecedorCotacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
  end;

implementation

uses
  CompraFornecedorCotacaoVO, CompraConfirmaFornecedorCotacaoVO, CompraCotacaoDetalheVO,
  CompraCotacaoVO, T2TiORM, SA;

{ TCompraFornecedorCotacaoController }

var
  objCompraFornecedorCotacao: TCompraFornecedorCotacaoVO;
  objCompraConfirmaFornecedorCotacao: TCompraConfirmaFornecedorCotacaoVO;
  Resultado: Boolean;

function TCompraFornecedorCotacaoController.CompraFornecedorCotacao(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TCompraFornecedorCotacaoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TCompraFornecedorCotacaoVO>(pFiltro, pPagina, False);
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

function TCompraFornecedorCotacaoController.UpdateCompraFornecedorCotacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  ListaCompraFornecedorCotacaoJson: TJSONValue;
  CompraCotacaoDetalheEnumerator: TEnumerator<TCompraCotacaoDetalheVO>;
  CompraCotacao: TCompraCotacaoVO;
  i: Integer;
begin
  // O primeiro item traz a lista de fornecedores
  ListaCompraFornecedorCotacaoJson := (pObjeto as TJSONArray).Get(0);

  Result := TJSONArray.Create;
  try
    try
      for i := 0 to (ListaCompraFornecedorCotacaoJson as TJSONArray).Size - 1 do
      begin
        objCompraConfirmaFornecedorCotacao := TCompraConfirmaFornecedorCotacaoVO.Create((ListaCompraFornecedorCotacaoJson as TJSONArray).Get(i));
        Resultado := TT2TiORM.Alterar(objCompraConfirmaFornecedorCotacao);

        // Itens de cotação do fornecedor
        CompraCotacaoDetalheEnumerator := objCompraConfirmaFornecedorCotacao.ListaCompraCotacaoDetalheVO.GetEnumerator;
        try
          with CompraCotacaoDetalheEnumerator do
          begin
            while MoveNext do
            begin
              Resultado := TT2TiORM.Alterar(Current);
            end;
          end;
        finally
          CompraCotacaoDetalheEnumerator.Free;
        end;
      end;

      // Atualiza o campo SITUACAO da cotação para C - Confirmada
      CompraCotacao := TCompraCotacaoVO.Create;
      CompraCotacao.Id := objCompraConfirmaFornecedorCotacao.IdCompraCotacao;
      CompraCotacao.Situacao := 'C';
      Resultado := TT2TiORM.Alterar(CompraCotacao);

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
    objCompraFornecedorCotacao.Free;
  end;
end;

end.
