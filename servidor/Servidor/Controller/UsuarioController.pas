{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [USUARIO] 
                                                                                
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
                                                                                
fabio_thz@yahoo.com.br | t2ti.com@gmail.com | fernandololiver@gmail.com
@author @author Fábio Thomaz | Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0                                                                    
*******************************************************************************}
unit UsuarioController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TUsuarioController = class(TController)
  protected
  public
    // consultar
    function Usuario(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptUsuario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateUsuario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelUsuario(pSessao: String; pId: Integer): TJSONArray;
    // Empresa na Sessao
    function EmpresaNaSessao(pSessao: String; pIdEmpresa: String): TJSONArray;

  end;

implementation

uses
  UsuarioVO, T2TiORM, SA;

{ TUsuarioController }

var
  objUsuario: TUsuarioVO;
  Resultado: Boolean;

function TUsuarioController.Usuario(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if (Pos('ID=', pFiltro) > 0) or (Pos('LOGIN =', pFiltro) > 0) then
      Result := TT2TiORM.Consultar<TUsuarioVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TUsuarioVO>(pFiltro, pPagina, False);
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

function TUsuarioController.AcceptUsuario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objUsuario := TUsuarioVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objUsuario);
      Result := Usuario(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objUsuario.Free;
  end;
end;

function TUsuarioController.UpdateUsuario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objUsuarioOld: TUsuarioVO;
begin
  // Objeto Novo
  objUsuario := TUsuarioVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objUsuarioOld := TUsuarioVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objUsuario, objUsuarioOld);
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
    objUsuario.Free;
  end;
end;

function TUsuarioController.CancelUsuario(pSessao: String; pId: Integer): TJSONArray;
begin
  objUsuario := TUsuarioVO.Create;
  Result := TJSONArray.Create;
  try
    objUsuario.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objUsuario);
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
    objUsuario.Free;
  end;
end;

function TUsuarioController.EmpresaNaSessao(pSessao: String; pIdEmpresa: String): TJSONArray;
begin
  try
    Sessao(pSessao).IdEmpresa := StrToInt(pIdEmpresa);
  except
    on E: Exception do
    begin
      Result := TJSONArray.Create;
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;
  Result := TJSONArray.Create;
  Result.AddElement(TJSONTrue.Create);
end;

end.
