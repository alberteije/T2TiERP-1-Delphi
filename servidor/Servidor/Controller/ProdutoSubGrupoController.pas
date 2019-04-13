{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PRODUTO_SUB_GRUPO] 
                                                                                
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
unit ProdutoSubGrupoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TProdutoSubGrupoController = class(TController)
  protected
  public
    //consultar
    function ProdutoSubGrupo(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptProdutoSubGrupo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateProdutoSubGrupo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelProdutoSubGrupo(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ProdutoSubGrupoVO, T2TiORM, SA;

{ TProdutoSubGrupoController }

var
  objProdutoSubGrupo: TProdutoSubGrupoVO;
  Resultado: Boolean;

function TProdutoSubGrupoController.ProdutoSubGrupo(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TProdutoSubGrupoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TProdutoSubGrupoVO>(pFiltro, pPagina, False);
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

function TProdutoSubGrupoController.AcceptProdutoSubGrupo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objProdutoSubGrupo := TProdutoSubGrupoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objProdutoSubGrupo);
      Result := ProdutoSubGrupo(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objProdutoSubGrupo.Free;
  end;
end;

function TProdutoSubGrupoController.UpdateProdutoSubGrupo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objProdutoSubGrupoOld: TProdutoSubGrupoVO;
begin
 //Objeto Novo
  objProdutoSubGrupo := TProdutoSubGrupoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objProdutoSubGrupoOld := TProdutoSubGrupoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objProdutoSubGrupo, objProdutoSubGrupoOld);
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
    objProdutoSubGrupo.Free;
  end;
end;

function TProdutoSubGrupoController.CancelProdutoSubGrupo(pSessao: String; pId: Integer): TJSONArray;
begin
  objProdutoSubGrupo := TProdutoSubGrupoVO.Create;
  Result := TJSONArray.Create;
  try
    objProdutoSubGrupo.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objProdutoSubGrupo);
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
    objProdutoSubGrupo.Free;
  end;
end;

end.
