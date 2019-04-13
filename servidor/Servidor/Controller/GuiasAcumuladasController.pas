{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [GUIAS_ACUMULADAS] 
                                                                                
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
unit GuiasAcumuladasController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TGuiasAcumuladasController = class(TController)
  protected
  public
    //consultar
    function GuiasAcumuladas(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptGuiasAcumuladas(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateGuiasAcumuladas(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelGuiasAcumuladas(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  GuiasAcumuladasVO, T2TiORM, SA;

{ TGuiasAcumuladasController }

var
  objGuiasAcumuladas: TGuiasAcumuladasVO;
  Resultado: Boolean;

function TGuiasAcumuladasController.GuiasAcumuladas(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TGuiasAcumuladasVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TGuiasAcumuladasVO>(pFiltro, pPagina, False);
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

function TGuiasAcumuladasController.AcceptGuiasAcumuladas(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objGuiasAcumuladas := TGuiasAcumuladasVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objGuiasAcumuladas);
      Result := GuiasAcumuladas(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objGuiasAcumuladas.Free;
  end;
end;

function TGuiasAcumuladasController.UpdateGuiasAcumuladas(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objGuiasAcumuladasOld: TGuiasAcumuladasVO;
begin
 //Objeto Novo
  objGuiasAcumuladas := TGuiasAcumuladasVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objGuiasAcumuladasOld := TGuiasAcumuladasVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objGuiasAcumuladas, objGuiasAcumuladasOld);
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
    objGuiasAcumuladas.Free;
  end;
end;

function TGuiasAcumuladasController.CancelGuiasAcumuladas(pSessao: String; pId: Integer): TJSONArray;
begin
  objGuiasAcumuladas := TGuiasAcumuladasVO.Create;
  Result := TJSONArray.Create;
  try
    objGuiasAcumuladas.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objGuiasAcumuladas);
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
    objGuiasAcumuladas.Free;
  end;
end;

end.
