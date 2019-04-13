{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [FOLHA_INSS_SERVICO] 
                                                                                
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
unit FolhaInssServicoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFolhaInssServicoController = class(TController)
  protected
  public
    //consultar
    function FolhaInssServico(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFolhaInssServico(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFolhaInssServico(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFolhaInssServico(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FolhaInssServicoVO, T2TiORM, SA;

{ TFolhaInssServicoController }

var
  objFolhaInssServico: TFolhaInssServicoVO;
  Resultado: Boolean;

function TFolhaInssServicoController.FolhaInssServico(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFolhaInssServicoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFolhaInssServicoVO>(pFiltro, pPagina, False);
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

function TFolhaInssServicoController.AcceptFolhaInssServico(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objFolhaInssServico := TFolhaInssServicoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFolhaInssServico);
      Result := FolhaInssServico(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFolhaInssServico.Free;
  end;
end;

function TFolhaInssServicoController.UpdateFolhaInssServico(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objFolhaInssServicoOld: TFolhaInssServicoVO;
begin
 //Objeto Novo
  objFolhaInssServico := TFolhaInssServicoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objFolhaInssServicoOld := TFolhaInssServicoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objFolhaInssServico, objFolhaInssServicoOld);
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
    objFolhaInssServico.Free;
  end;
end;

function TFolhaInssServicoController.CancelFolhaInssServico(pSessao: String; pId: Integer): TJSONArray;
begin
  objFolhaInssServico := TFolhaInssServicoVO.Create;
  Result := TJSONArray.Create;
  try
    objFolhaInssServico.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFolhaInssServico);
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
    objFolhaInssServico.Free;
  end;
end;

end.
