{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [ESTOQUE_REAJUSTE_CABECALHO] 
                                                                                
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
unit EstoqueReajusteCabecalhoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TEstoqueReajusteCabecalhoController = class(TController)
  protected
  public
    //consultar
    function EstoqueReajusteCabecalho(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptEstoqueReajusteCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateEstoqueReajusteCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelEstoqueReajusteCabecalho(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  EstoqueReajusteCabecalhoVO, T2TiORM, SA, EstoqueReajusteDetalheVO, ProdutoVO;

{ TEstoqueReajusteCabecalhoController }

var
  objEstoqueReajusteCabecalho: TEstoqueReajusteCabecalhoVO;
  Resultado: Boolean;

function TEstoqueReajusteCabecalhoController.EstoqueReajusteCabecalho(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TEstoqueReajusteCabecalhoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TEstoqueReajusteCabecalhoVO>(pFiltro, pPagina, False);
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

function TEstoqueReajusteCabecalhoController.AcceptEstoqueReajusteCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  EstoqueReajusteDetalhe: TEstoqueReajusteDetalheVO;
  EstoqueReajusteDetalheEnumerator: TEnumerator<TEstoqueReajusteDetalheVO>;
  Produto: TProdutoVO;
begin
  objEstoqueReajusteCabecalho := TEstoqueReajusteCabecalhoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objEstoqueReajusteCabecalho);

      EstoqueReajusteDetalheEnumerator := objEstoqueReajusteCabecalho.ListaEstoqueReajusteDetalheVO.GetEnumerator;
      try
        with EstoqueReajusteDetalheEnumerator do
        begin
          while MoveNext do
          begin
            EstoqueReajusteDetalhe := Current;
            EstoqueReajusteDetalhe.IdEstoqueReajusteCabecalho := UltimoID;
            TT2TiORM.Inserir(EstoqueReajusteDetalhe);

            // Atualiza Valor do Produto
            Produto := TProdutoVO.Create;
            Produto.Id := Current.IdProduto;
            Produto.ValorVenda := Current.ValorReajuste;
            Resultado := TT2TiORM.Alterar(Produto);
          end;
        end;
      finally
        EstoqueReajusteDetalheEnumerator.Free;
      end;

      Result := EstoqueReajusteCabecalho(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objEstoqueReajusteCabecalho.Free;
  end;
end;

function TEstoqueReajusteCabecalhoController.UpdateEstoqueReajusteCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  EstoqueReajusteDetalheEnumerator: TEnumerator<TEstoqueReajusteDetalheVO>;
  objEstoqueReajusteCabecalhoOld: TEstoqueReajusteCabecalhoVO;
  Produto: TProdutoVO;
begin
 //Objeto Novo
  objEstoqueReajusteCabecalho := TEstoqueReajusteCabecalhoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objEstoqueReajusteCabecalhoOld := TEstoqueReajusteCabecalhoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objEstoqueReajusteCabecalho.MainObject.ToJSONString <> objEstoqueReajusteCabecalhoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objEstoqueReajusteCabecalho, objEstoqueReajusteCabecalhoOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Detalhe
    try
      EstoqueReajusteDetalheEnumerator := objEstoqueReajusteCabecalho.ListaEstoqueReajusteDetalheVO.GetEnumerator;
      with EstoqueReajusteDetalheEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
            Resultado := TT2TiORM.Inserir(Current) > 0;

          // Atualiza Valor do Produto
          Produto := TProdutoVO.Create;
          Produto.Id := Current.IdProduto;
          Produto.ValorVenda := Current.ValorReajuste;
          Resultado := TT2TiORM.Alterar(Produto);
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
    objEstoqueReajusteCabecalho.Free;
    EstoqueReajusteDetalheEnumerator.Free;
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TEstoqueReajusteCabecalhoController.CancelEstoqueReajusteCabecalho(pSessao: String; pId: Integer): TJSONArray;
begin
  objEstoqueReajusteCabecalho := TEstoqueReajusteCabecalhoVO.Create;
  Result := TJSONArray.Create;
  try
    objEstoqueReajusteCabecalho.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objEstoqueReajusteCabecalho);
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
    objEstoqueReajusteCabecalho.Free;
  end;
end;

end.
