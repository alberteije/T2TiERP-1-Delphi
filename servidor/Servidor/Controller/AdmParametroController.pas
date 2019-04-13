{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [ADM_PARAMETRO] 
                                                                                
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
unit AdmParametroController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TAdmParametroController = class(TController)
  protected
  public
    //consultar
    function AdmParametro(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptAdmParametro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateAdmParametro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelAdmParametro(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  AdmParametroVO, T2TiORM, SA;

{ TAdmParametroController }

var
  objAdmParametro: TAdmParametroVO;
  Resultado: Boolean;

function TAdmParametroController.AdmParametro(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TAdmParametroVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TAdmParametroVO>(pFiltro, pPagina, False);
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

function TAdmParametroController.AcceptAdmParametro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objAdmParametro := TAdmParametroVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objAdmParametro);
      Result := AdmParametro(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objAdmParametro.Free;
  end;
end;

function TAdmParametroController.UpdateAdmParametro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objAdmParametroOld: TAdmParametroVO;
begin
 //Objeto Novo
  objAdmParametro := TAdmParametroVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objAdmParametroOld := TAdmParametroVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objAdmParametro, objAdmParametroOld);
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
    objAdmParametro.Free;
  end;
end;

function TAdmParametroController.CancelAdmParametro(pSessao: String; pId: Integer): TJSONArray;
begin
  objAdmParametro := TAdmParametroVO.Create;
  Result := TJSONArray.Create;
  try
    objAdmParametro.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objAdmParametro);
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
    objAdmParametro.Free;
  end;
end;

end.
