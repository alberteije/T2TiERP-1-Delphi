{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado � tabela [ESTADO_CIVIL] 
                                                                                
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
unit EstadoCivilController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TEstadoCivilController = class(TController)
  protected
  public
    // consultar
    function EstadoCivil(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptEstadoCivil(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateEstadoCivil(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelEstadoCivil(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  EstadoCivilVO, T2TiORM, SA;

{ TEstadoCivilController }

var
  objEstadoCivil: TEstadoCivilVO;
  Resultado: Boolean;

function TEstadoCivilController.EstadoCivil(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TEstadoCivilVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TEstadoCivilVO>(pFiltro, pPagina, False);
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

function TEstadoCivilController.AcceptEstadoCivil(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objEstadoCivil := TEstadoCivilVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objEstadoCivil);
      Result := EstadoCivil(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objEstadoCivil.Free;
  end;
end;

function TEstadoCivilController.UpdateEstadoCivil(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objEstadoCivilOld: TEstadoCivilVO;
begin
  // Objeto Novo
  objEstadoCivil := TEstadoCivilVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objEstadoCivilOld := TEstadoCivilVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objEstadoCivil, objEstadoCivilOld);
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
    objEstadoCivil.Free;
  end;
end;

function TEstadoCivilController.CancelEstadoCivil(pSessao: String; pId: Integer): TJSONArray;
begin
  objEstadoCivil := TEstadoCivilVO.Create;
  Result := TJSONArray.Create;
  try
    objEstadoCivil.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objEstadoCivil);
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
    objEstadoCivil.Free;
  end;
end;

end.
