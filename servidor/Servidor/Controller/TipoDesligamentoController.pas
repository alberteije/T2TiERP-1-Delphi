{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [TIPO_DESLIGAMENTO] 
                                                                                
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
unit TipoDesligamentoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TTipoDesligamentoController = class(TController)
  protected
  public
    // consultar
    function TipoDesligamento(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptTipoDesligamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateTipoDesligamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelTipoDesligamento(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  TipoDesligamentoVO, T2TiORM, SA;

{ TTipoDesligamentoController }

var
  objTipoDesligamento: TTipoDesligamentoVO;
  Resultado: Boolean;

function TTipoDesligamentoController.TipoDesligamento(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TTipoDesligamentoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TTipoDesligamentoVO>(pFiltro, pPagina, False);
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

function TTipoDesligamentoController.AcceptTipoDesligamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objTipoDesligamento := TTipoDesligamentoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objTipoDesligamento);
      Result := TipoDesligamento(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objTipoDesligamento.Free;
  end;
end;

function TTipoDesligamentoController.UpdateTipoDesligamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objTipoDesligamentoOld: TTipoDesligamentoVO;
begin
  // Objeto Novo
  objTipoDesligamento := TTipoDesligamentoVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objTipoDesligamentoOld := TTipoDesligamentoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objTipoDesligamento, objTipoDesligamentoOld);
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
    objTipoDesligamento.Free;
  end;
end;

function TTipoDesligamentoController.CancelTipoDesligamento(pSessao: String; pId: Integer): TJSONArray;
begin
  objTipoDesligamento := TTipoDesligamentoVO.Create;
  Result := TJSONArray.Create;
  try
    objTipoDesligamento.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objTipoDesligamento);
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
    objTipoDesligamento.Free;
  end;
end;

end.
