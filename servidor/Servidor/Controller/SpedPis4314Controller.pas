{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [SPED_PIS_4314] 
                                                                                
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
unit SpedPis4314Controller;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TSpedPis4314Controller = class(TController)
  protected
  public
    // consultar
    function SpedPis4314(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptSpedPis4314(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateSpedPis4314(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelSpedPis4314(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  SpedPis4314VO, T2TiORM, SA;

{ TSpedPis4314Controller }

var
  objSpedPis4314: TSpedPis4314VO;
  Resultado: Boolean;

function TSpedPis4314Controller.SpedPis4314(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TSpedPis4314VO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TSpedPis4314VO>(pFiltro, pPagina, False);
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

function TSpedPis4314Controller.AcceptSpedPis4314(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objSpedPis4314 := TSpedPis4314VO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objSpedPis4314);
      Result := SpedPis4314(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objSpedPis4314.Free;
  end;
end;

function TSpedPis4314Controller.UpdateSpedPis4314(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objSpedPis4314Old: TSpedPis4314VO;
begin
  // Objeto Novo
  objSpedPis4314 := TSpedPis4314VO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objSpedPis4314Old := TSpedPis4314VO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objSpedPis4314, objSpedPis4314Old);
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
    objSpedPis4314.Free;
  end;
end;

function TSpedPis4314Controller.CancelSpedPis4314(pSessao: String; pId: Integer): TJSONArray;
begin
  objSpedPis4314 := TSpedPis4314VO.Create;
  Result := TJSONArray.Create;
  try
    objSpedPis4314.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objSpedPis4314);
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
    objSpedPis4314.Free;
  end;
end;

end.
