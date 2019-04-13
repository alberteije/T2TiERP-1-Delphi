{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PONTO_HORARIO_AUTORIZADO] 
                                                                                
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
unit PontoHorarioAutorizadoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPontoHorarioAutorizadoController = class(TController)
  protected
  public
    //consultar
    function PontoHorarioAutorizado(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPontoHorarioAutorizado(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePontoHorarioAutorizado(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPontoHorarioAutorizado(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  PontoHorarioAutorizadoVO, T2TiORM, SA;

{ TPontoHorarioAutorizadoController }

var
  objPontoHorarioAutorizado: TPontoHorarioAutorizadoVO;
  Resultado: Boolean;

function TPontoHorarioAutorizadoController.PontoHorarioAutorizado(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    Result := TT2TiORM.Consultar<TPontoHorarioAutorizadoVO>(pFiltro, pPagina);
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

function TPontoHorarioAutorizadoController.AcceptPontoHorarioAutorizado(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objPontoHorarioAutorizado := TPontoHorarioAutorizadoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPontoHorarioAutorizado);
      Result := PontoHorarioAutorizado(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPontoHorarioAutorizado.Free;
  end;
end;

function TPontoHorarioAutorizadoController.UpdatePontoHorarioAutorizado(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objPontoHorarioAutorizadoOld: TPontoHorarioAutorizadoVO;
begin
 //Objeto Novo
  objPontoHorarioAutorizado := TPontoHorarioAutorizadoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objPontoHorarioAutorizadoOld := TPontoHorarioAutorizadoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objPontoHorarioAutorizado, objPontoHorarioAutorizadoOld);
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
    objPontoHorarioAutorizado.Free;
  end;
end;

function TPontoHorarioAutorizadoController.CancelPontoHorarioAutorizado(pSessao: String; pId: Integer): TJSONArray;
begin
  objPontoHorarioAutorizado := TPontoHorarioAutorizadoVO.Create;
  Result := TJSONArray.Create;
  try
    objPontoHorarioAutorizado.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPontoHorarioAutorizado);
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
    objPontoHorarioAutorizado.Free;
  end;
end;

end.
