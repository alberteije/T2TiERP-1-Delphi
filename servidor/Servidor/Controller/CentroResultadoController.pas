{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [CENTRO_RESULTADO] 
                                                                                
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
unit CentroResultadoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TCentroResultadoController = class(TController)
  protected
  public
    //consultar
    function CentroResultado(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptCentroResultado(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateCentroResultado(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelCentroResultado(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  CentroResultadoVO, T2TiORM, SA;

{ TCentroResultadoController }

var
  objCentroResultado: TCentroResultadoVO;
  Resultado: Boolean;

function TCentroResultadoController.CentroResultado(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TCentroResultadoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TCentroResultadoVO>(pFiltro, pPagina, False);
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

function TCentroResultadoController.AcceptCentroResultado(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objCentroResultado := TCentroResultadoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objCentroResultado);
      Result := CentroResultado(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objCentroResultado.Free;
  end;
end;

function TCentroResultadoController.UpdateCentroResultado(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objCentroResultadoOld: TCentroResultadoVO;
begin
 //Objeto Novo
  objCentroResultado := TCentroResultadoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objCentroResultadoOld := TCentroResultadoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objCentroResultado, objCentroResultadoOld);
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
    objCentroResultado.Free;
  end;
end;

function TCentroResultadoController.CancelCentroResultado(pSessao: String; pId: Integer): TJSONArray;
begin
  objCentroResultado := TCentroResultadoVO.Create;
  Result := TJSONArray.Create;
  try
    objCentroResultado.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objCentroResultado);
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
    objCentroResultado.Free;
  end;
end;

end.
