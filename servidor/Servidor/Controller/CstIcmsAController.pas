{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [CST_ICMS_A] 
                                                                                
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
unit CstIcmsAController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TCstIcmsAController = class(TController)
  protected
  public
    // consultar
    function CstIcmsA(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptCstIcmsA(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateCstIcmsA(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelCstIcmsA(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  CstIcmsAVO, T2TiORM, SA;

{ TCstIcmsAController }

var
  objCstIcmsA: TCstIcmsAVO;
  Resultado: Boolean;

function TCstIcmsAController.CstIcmsA(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TCstIcmsAVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TCstIcmsAVO>(pFiltro, pPagina, False);
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

function TCstIcmsAController.AcceptCstIcmsA(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objCstIcmsA := TCstIcmsAVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objCstIcmsA);
      Result := CstIcmsA(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objCstIcmsA.Free;
  end;
end;

function TCstIcmsAController.UpdateCstIcmsA(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objCstIcmsAOld: TCstIcmsAVO;
begin
  // Objeto Novo
  objCstIcmsA := TCstIcmsAVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objCstIcmsAOld := TCstIcmsAVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objCstIcmsA, objCstIcmsAOld);
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
    objCstIcmsA.Free;
  end;
end;

function TCstIcmsAController.CancelCstIcmsA(pSessao: String; pId: Integer): TJSONArray;
begin
  objCstIcmsA := TCstIcmsAVO.Create;
  Result := TJSONArray.Create;
  try
    objCstIcmsA.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objCstIcmsA);
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
    objCstIcmsA.Free;
  end;
end;

end.
