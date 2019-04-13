{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [TIPO_NOTA_FISCAL] 
                                                                                
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
unit TipoNotaFiscalController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TTipoNotaFiscalController = class(TController)
  protected
  public
    // consultar
    function TipoNotaFiscal(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptTipoNotaFiscal(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateTipoNotaFiscal(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelTipoNotaFiscal(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  TipoNotaFiscalVO, T2TiORM, SA;

{ TTipoNotaFiscalController }

var
  objTipoNotaFiscal: TTipoNotaFiscalVO;
  Resultado: Boolean;

function TTipoNotaFiscalController.TipoNotaFiscal(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TTipoNotaFiscalVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TTipoNotaFiscalVO>(pFiltro, pPagina, False);
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

function TTipoNotaFiscalController.AcceptTipoNotaFiscal(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objTipoNotaFiscal := TTipoNotaFiscalVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objTipoNotaFiscal);
      Result := TipoNotaFiscal(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objTipoNotaFiscal.Free;
  end;
end;

function TTipoNotaFiscalController.UpdateTipoNotaFiscal(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objTipoNotaFiscalOld: TTipoNotaFiscalVO;
begin
  // Objeto Novo
  objTipoNotaFiscal := TTipoNotaFiscalVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objTipoNotaFiscalOld := TTipoNotaFiscalVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objTipoNotaFiscal, objTipoNotaFiscalOld);
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
    objTipoNotaFiscal.Free;
  end;
end;

function TTipoNotaFiscalController.CancelTipoNotaFiscal(pSessao: String; pId: Integer): TJSONArray;
begin
  objTipoNotaFiscal := TTipoNotaFiscalVO.Create;
  Result := TJSONArray.Create;
  try
    objTipoNotaFiscal.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objTipoNotaFiscal);
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
    objTipoNotaFiscal.Free;
  end;
end;

end.
