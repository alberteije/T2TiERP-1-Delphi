{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [ORCAMENTO_FLUXO_CAIXA_PERIODO] 
                                                                                
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
unit OrcamentoFluxoCaixaPeriodoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TOrcamentoFluxoCaixaPeriodoController = class(TController)
  protected
  public
    //consultar
    function OrcamentoFluxoCaixaPeriodo(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptOrcamentoFluxoCaixaPeriodo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateOrcamentoFluxoCaixaPeriodo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelOrcamentoFluxoCaixaPeriodo(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  OrcamentoFluxoCaixaPeriodoVO, T2TiORM, SA;

{ TOrcamentoFluxoCaixaPeriodoController }

var
  objOrcamentoFluxoCaixaPeriodo: TOrcamentoFluxoCaixaPeriodoVO;
  Resultado: Boolean;

function TOrcamentoFluxoCaixaPeriodoController.OrcamentoFluxoCaixaPeriodo(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TOrcamentoFluxoCaixaPeriodoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TOrcamentoFluxoCaixaPeriodoVO>(pFiltro, pPagina, False);
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

function TOrcamentoFluxoCaixaPeriodoController.AcceptOrcamentoFluxoCaixaPeriodo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objOrcamentoFluxoCaixaPeriodo := TOrcamentoFluxoCaixaPeriodoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objOrcamentoFluxoCaixaPeriodo);
      Result := OrcamentoFluxoCaixaPeriodo(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objOrcamentoFluxoCaixaPeriodo.Free;
  end;
end;

function TOrcamentoFluxoCaixaPeriodoController.UpdateOrcamentoFluxoCaixaPeriodo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objOrcamentoFluxoCaixaPeriodoOld: TOrcamentoFluxoCaixaPeriodoVO;
begin
 //Objeto Novo
  objOrcamentoFluxoCaixaPeriodo := TOrcamentoFluxoCaixaPeriodoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objOrcamentoFluxoCaixaPeriodoOld := TOrcamentoFluxoCaixaPeriodoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objOrcamentoFluxoCaixaPeriodo, objOrcamentoFluxoCaixaPeriodoOld);
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
    objOrcamentoFluxoCaixaPeriodo.Free;
  end;
end;

function TOrcamentoFluxoCaixaPeriodoController.CancelOrcamentoFluxoCaixaPeriodo(pSessao: String; pId: Integer): TJSONArray;
begin
  objOrcamentoFluxoCaixaPeriodo := TOrcamentoFluxoCaixaPeriodoVO.Create;
  Result := TJSONArray.Create;
  try
    objOrcamentoFluxoCaixaPeriodo.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objOrcamentoFluxoCaixaPeriodo);
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
    objOrcamentoFluxoCaixaPeriodo.Free;
  end;
end;

end.
