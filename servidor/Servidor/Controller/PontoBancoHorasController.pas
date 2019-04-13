{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PONTO_BANCO_HORAS] 
                                                                                
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
                                                                                
       t2ti.com@gmail.com
@author Albert Eije
@version 1.0                                                                    
*******************************************************************************}
unit PontoBancoHorasController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPontoBancoHorasController = class(TController)
  protected
  public
    //consultar
    function PontoBancoHoras(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPontoBancoHoras(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePontoBancoHoras(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPontoBancoHoras(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  PontoBancoHorasVO, T2TiORM, SA;

{ TPontoBancoHorasController }

var
  objPontoBancoHoras: TPontoBancoHorasVO;
  Resultado: Boolean;

function TPontoBancoHorasController.PontoBancoHoras(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    Result := TT2TiORM.Consultar<TPontoBancoHorasVO>(pFiltro, pPagina);
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

function TPontoBancoHorasController.AcceptPontoBancoHoras(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objPontoBancoHoras := TPontoBancoHorasVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPontoBancoHoras);
      Result := PontoBancoHoras(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPontoBancoHoras.Free;
  end;
end;

function TPontoBancoHorasController.UpdatePontoBancoHoras(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objPontoBancoHorasOld: TPontoBancoHorasVO;
begin
 //Objeto Novo
  objPontoBancoHoras := TPontoBancoHorasVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objPontoBancoHorasOld := TPontoBancoHorasVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objPontoBancoHoras, objPontoBancoHorasOld);
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
    objPontoBancoHoras.Free;
  end;
end;

function TPontoBancoHorasController.CancelPontoBancoHoras(pSessao: String; pId: Integer): TJSONArray;
begin
  objPontoBancoHoras := TPontoBancoHorasVO.Create;
  Result := TJSONArray.Create;
  try
    objPontoBancoHoras.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPontoBancoHoras);
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
    objPontoBancoHoras.Free;
  end;
end;

end.
