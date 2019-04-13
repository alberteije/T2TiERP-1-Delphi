{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PONTO_PARAMETRO] 
                                                                                
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
                                                                                
       t2ti.com@gmail.com
@author Albert Eije
@version 1.0                                                                    
*******************************************************************************}
unit PontoParametroController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPontoParametroController = class(TController)
  protected
  public
    //consultar
    function PontoParametro(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPontoParametro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePontoParametro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPontoParametro(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  PontoParametroVO, T2TiORM, SA;

{ TPontoParametroController }

var
  objPontoParametro: TPontoParametroVO;
  Resultado: Boolean;

function TPontoParametroController.PontoParametro(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    Result := TT2TiORM.Consultar<TPontoParametroVO>(pFiltro, pPagina);
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

function TPontoParametroController.AcceptPontoParametro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objPontoParametro := TPontoParametroVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPontoParametro);
      Result := PontoParametro(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPontoParametro.Free;
  end;
end;

function TPontoParametroController.UpdatePontoParametro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objPontoParametroOld: TPontoParametroVO;
begin
 //Objeto Novo
  objPontoParametro := TPontoParametroVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objPontoParametroOld := TPontoParametroVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objPontoParametro, objPontoParametroOld);
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
    objPontoParametro.Free;
  end;
end;

function TPontoParametroController.CancelPontoParametro(pSessao: String; pId: Integer): TJSONArray;
begin
  objPontoParametro := TPontoParametroVO.Create;
  Result := TJSONArray.Create;
  try
    objPontoParametro.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPontoParametro);
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
    objPontoParametro.Free;
  end;
end;

end.
