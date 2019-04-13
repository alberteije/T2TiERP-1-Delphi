{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PONTO_HORARIO] 
                                                                                
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
unit PontoHorarioController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPontoHorarioController = class(TController)
  protected
  public
    //consultar
    function PontoHorario(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPontoHorario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePontoHorario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPontoHorario(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  PontoHorarioVO, T2TiORM, SA;

{ TPontoHorarioController }

var
  objPontoHorario: TPontoHorarioVO;
  Resultado: Boolean;

function TPontoHorarioController.PontoHorario(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    Result := TT2TiORM.Consultar<TPontoHorarioVO>(pFiltro, pPagina);
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

function TPontoHorarioController.AcceptPontoHorario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objPontoHorario := TPontoHorarioVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPontoHorario);
      Result := PontoHorario(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPontoHorario.Free;
  end;
end;

function TPontoHorarioController.UpdatePontoHorario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objPontoHorarioOld: TPontoHorarioVO;
begin
 //Objeto Novo
  objPontoHorario := TPontoHorarioVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objPontoHorarioOld := TPontoHorarioVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objPontoHorario, objPontoHorarioOld);
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
    objPontoHorario.Free;
  end;
end;

function TPontoHorarioController.CancelPontoHorario(pSessao: String; pId: Integer): TJSONArray;
begin
  objPontoHorario := TPontoHorarioVO.Create;
  Result := TJSONArray.Create;
  try
    objPontoHorario.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPontoHorario);
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
    objPontoHorario.Free;
  end;
end;

end.
