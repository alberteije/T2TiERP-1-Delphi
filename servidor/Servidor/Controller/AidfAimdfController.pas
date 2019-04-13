{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [AIDF_AIMDF] 
                                                                                
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
unit AidfAimdfController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TAidfAimdfController = class(TController)
  protected
  public
    //consultar
    function AidfAimdf(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptAidfAimdf(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateAidfAimdf(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelAidfAimdf(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  AidfAimdfVO, T2TiORM, SA;

{ TAidfAimdfController }

var
  objAidfAimdf: TAidfAimdfVO;
  Resultado: Boolean;

function TAidfAimdfController.AidfAimdf(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TAidfAimdfVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TAidfAimdfVO>(pFiltro, pPagina, False);
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

function TAidfAimdfController.AcceptAidfAimdf(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objAidfAimdf := TAidfAimdfVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objAidfAimdf);
      Result := AidfAimdf(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objAidfAimdf.Free;
  end;
end;

function TAidfAimdfController.UpdateAidfAimdf(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objAidfAimdfOld: TAidfAimdfVO;
begin
 //Objeto Novo
  objAidfAimdf := TAidfAimdfVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objAidfAimdfOld := TAidfAimdfVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objAidfAimdf, objAidfAimdfOld);
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
    objAidfAimdf.Free;
  end;
end;

function TAidfAimdfController.CancelAidfAimdf(pSessao: String; pId: Integer): TJSONArray;
begin
  objAidfAimdf := TAidfAimdfVO.Create;
  Result := TJSONArray.Create;
  try
    objAidfAimdf.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objAidfAimdf);
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
    objAidfAimdf.Free;
  end;
end;

end.
