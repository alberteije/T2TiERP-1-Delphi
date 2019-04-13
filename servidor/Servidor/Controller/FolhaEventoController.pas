{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [FOLHA_EVENTO] 
                                                                                
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
unit FolhaEventoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFolhaEventoController = class(TController)
  protected
  public
    //consultar
    function FolhaEvento(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFolhaEvento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFolhaEvento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFolhaEvento(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FolhaEventoVO, T2TiORM, SA;

{ TFolhaEventoController }

var
  objFolhaEvento: TFolhaEventoVO;
  Resultado: Boolean;

function TFolhaEventoController.FolhaEvento(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFolhaEventoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFolhaEventoVO>(pFiltro, pPagina, False);
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

function TFolhaEventoController.AcceptFolhaEvento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objFolhaEvento := TFolhaEventoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFolhaEvento);
      Result := FolhaEvento(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFolhaEvento.Free;
  end;
end;

function TFolhaEventoController.UpdateFolhaEvento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objFolhaEventoOld: TFolhaEventoVO;
begin
 //Objeto Novo
  objFolhaEvento := TFolhaEventoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objFolhaEventoOld := TFolhaEventoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objFolhaEvento, objFolhaEventoOld);
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
    objFolhaEvento.Free;
  end;
end;

function TFolhaEventoController.CancelFolhaEvento(pSessao: String; pId: Integer): TJSONArray;
begin
  objFolhaEvento := TFolhaEventoVO.Create;
  Result := TJSONArray.Create;
  try
    objFolhaEvento.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFolhaEvento);
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
    objFolhaEvento.Free;
  end;
end;

end.
