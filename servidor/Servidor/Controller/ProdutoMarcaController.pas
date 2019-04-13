{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PRODUTO_MARCA] 
                                                                                
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
unit ProdutoMarcaController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TProdutoMarcaController = class(TController)
  protected
  public
    //consultar
    function ProdutoMarca(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptProdutoMarca(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateProdutoMarca(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelProdutoMarca(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ProdutoMarcaVO, T2TiORM, SA;

{ TProdutoMarcaController }

var
  objProdutoMarca: TProdutoMarcaVO;
  Resultado: Boolean;

function TProdutoMarcaController.ProdutoMarca(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TProdutoMarcaVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TProdutoMarcaVO>(pFiltro, pPagina, False);
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

function TProdutoMarcaController.AcceptProdutoMarca(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objProdutoMarca := TProdutoMarcaVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objProdutoMarca);
      Result := ProdutoMarca(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objProdutoMarca.Free;
  end;
end;

function TProdutoMarcaController.UpdateProdutoMarca(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objProdutoMarcaOld: TProdutoMarcaVO;
begin
 //Objeto Novo
  objProdutoMarca := TProdutoMarcaVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objProdutoMarcaOld := TProdutoMarcaVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objProdutoMarca, objProdutoMarcaOld);
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
    objProdutoMarca.Free;
  end;
end;

function TProdutoMarcaController.CancelProdutoMarca(pSessao: String; pId: Integer): TJSONArray;
begin
  objProdutoMarca := TProdutoMarcaVO.Create;
  Result := TJSONArray.Create;
  try
    objProdutoMarca.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objProdutoMarca);
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
    objProdutoMarca.Free;
  end;
end;

end.
