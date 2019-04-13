{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [GED_TIPO_DOCUMENTO] 
                                                                                
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
                                                                                
fernandololiver@gmail.com
@author @author Fernando L Oliveira
@version 1.0                                                                    
*******************************************************************************}
unit GedTipoDocumentoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TGedTipoDocumentoController = class(TController)
  protected
  public
    // consultar
    function GedTipoDocumento(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptGedTipoDocumento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateGedTipoDocumento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelGedTipoDocumento(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  GedTipoDocumentoVO, T2TiORM, SA;

{ TGedTipoDocumentoController }

var
  objGedTipoDocumento: TGedTipoDocumentoVO;
  Resultado: Boolean;

function TGedTipoDocumentoController.GedTipoDocumento(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TGedTipoDocumentoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TGedTipoDocumentoVO>(pFiltro, pPagina, False);
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

function TGedTipoDocumentoController.AcceptGedTipoDocumento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objGedTipoDocumento := TGedTipoDocumentoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objGedTipoDocumento);
      Result := GedTipoDocumento(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objGedTipoDocumento.Free;
  end;
end;

function TGedTipoDocumentoController.UpdateGedTipoDocumento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objGedTipoDocumentoOld: TGedTipoDocumentoVO;
begin
  // Objeto Novo
  objGedTipoDocumento := TGedTipoDocumentoVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objGedTipoDocumentoOld := TGedTipoDocumentoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    // Verifica se houve alterações no objeto principal
    if objGedTipoDocumento.MainObject.ToJSONString <> objGedTipoDocumentoOld.MainObject.ToJSONString then
    begin
    try
      Resultado := TT2TiORM.Alterar(objGedTipoDocumento, objGedTipoDocumentoOld);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
     end;
    end;
  finally
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objGedTipoDocumento.Free;
  end;
end;

function TGedTipoDocumentoController.CancelGedTipoDocumento(pSessao: String; pId: Integer): TJSONArray;
begin
  objGedTipoDocumento := TGedTipoDocumentoVO.Create;
  Result := TJSONArray.Create;
  try
    objGedTipoDocumento.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objGedTipoDocumento);
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
    objGedTipoDocumento.Free;
  end;
end;

end.
