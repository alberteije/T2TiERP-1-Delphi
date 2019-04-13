{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [ATIVIDADE_FOR_CLI] 
                                                                                
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
unit AtividadeForCliController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TAtividadeForCliController = class(TController)
  protected
  public
    // consultar
    function AtividadeForCli(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptAtividadeForCli(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateAtividadeForCli(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelAtividadeForCli(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  AtividadeForCliVO, T2TiORM, SA;

{ TAtividadeForCliController }

var
  objAtividadeForCli: TAtividadeForCliVO;
  Resultado: Boolean;

function TAtividadeForCliController.AtividadeForCli(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TAtividadeForCliVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TAtividadeForCliVO>(pFiltro, pPagina, False);
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

function TAtividadeForCliController.AcceptAtividadeForCli(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objAtividadeForCli := TAtividadeForCliVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objAtividadeForCli);
      Result := AtividadeForCli(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objAtividadeForCli.Free;
  end;
end;

function TAtividadeForCliController.UpdateAtividadeForCli(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objAtividadeForCliOld: TAtividadeForCliVO;
begin
  // Objeto Novo
  objAtividadeForCli := TAtividadeForCliVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objAtividadeForCliOld := TAtividadeForCliVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objAtividadeForCli, objAtividadeForCliOld);
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
    objAtividadeForCli.Free;
  end;
end;

function TAtividadeForCliController.CancelAtividadeForCli(pSessao: String; pId: Integer): TJSONArray;
begin
  objAtividadeForCli := TAtividadeForCliVO.Create;
  Result := TJSONArray.Create;
  try
    objAtividadeForCli.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objAtividadeForCli);
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
    objAtividadeForCli.Free;
  end;
end;

end.
