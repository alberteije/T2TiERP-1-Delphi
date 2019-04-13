{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [FISCAL_ESTADUAL_PORTE] 
                                                                                
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
unit FiscalEstadualPorteController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFiscalEstadualPorteController = class(TController)
  protected
  public
    //consultar
    function FiscalEstadualPorte(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFiscalEstadualPorte(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFiscalEstadualPorte(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFiscalEstadualPorte(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FiscalEstadualPorteVO, T2TiORM, SA;

{ TFiscalEstadualPorteController }

var
  objFiscalEstadualPorte: TFiscalEstadualPorteVO;
  Resultado: Boolean;

function TFiscalEstadualPorteController.FiscalEstadualPorte(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFiscalEstadualPorteVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFiscalEstadualPorteVO>(pFiltro, pPagina, False);
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

function TFiscalEstadualPorteController.AcceptFiscalEstadualPorte(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objFiscalEstadualPorte := TFiscalEstadualPorteVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFiscalEstadualPorte);
      Result := FiscalEstadualPorte(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFiscalEstadualPorte.Free;
  end;
end;

function TFiscalEstadualPorteController.UpdateFiscalEstadualPorte(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objFiscalEstadualPorteOld: TFiscalEstadualPorteVO;
begin
 //Objeto Novo
  objFiscalEstadualPorte := TFiscalEstadualPorteVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objFiscalEstadualPorteOld := TFiscalEstadualPorteVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objFiscalEstadualPorte, objFiscalEstadualPorteOld);
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
    objFiscalEstadualPorte.Free;
  end;
end;

function TFiscalEstadualPorteController.CancelFiscalEstadualPorte(pSessao: String; pId: Integer): TJSONArray;
begin
  objFiscalEstadualPorte := TFiscalEstadualPorteVO.Create;
  Result := TJSONArray.Create;
  try
    objFiscalEstadualPorte.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFiscalEstadualPorte);
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
    objFiscalEstadualPorte.Free;
  end;
end;

end.
