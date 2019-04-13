{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PONTO_FECHAMENTO_JORNADA] 
                                                                                
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
unit PontoFechamentoJornadaController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPontoFechamentoJornadaController = class(TController)
  protected
  public
    //consultar
    function PontoFechamentoJornada(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPontoFechamentoJornada(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePontoFechamentoJornada(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPontoFechamentoJornada(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  PontoFechamentoJornadaVO, T2TiORM, SA;

{ TPontoFechamentoJornadaController }

var
  objPontoFechamentoJornada: TPontoFechamentoJornadaVO;
  Resultado: Boolean;

function TPontoFechamentoJornadaController.PontoFechamentoJornada(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
var
  ConsultaSQL: String;
begin
  Result := TJSONArray.Create;
  try
    ConsultaSQL :=
      'SELECT PFJ.*, C.PIS_NUMERO, P.NOME AS NOME_COLABORADOR, '+
      'PCJ.CODIGO AS CODIGO_CLASSIFICACAO, PCJ.NOME AS NOME_CLASSIFICACAO '+
      'FROM PONTO_FECHAMENTO_JORNADA PFJ '+
      'INNER JOIN COLABORADOR C ON (PFJ.ID_COLABORADOR = C.ID) '+
      'INNER JOIN PESSOA P ON (C.ID_PESSOA = P.ID) '+
      'INNER JOIN PONTO_CLASSIFICACAO_JORNADA PCJ ON (PFJ.ID_PONTO_CLASSIFICACAO_JORNADA = PCJ.ID)';

    Result := TT2TiORM.Consultar<TPontoFechamentoJornadaVO>(ConsultaSQL, pFiltro, pPagina);
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

function TPontoFechamentoJornadaController.AcceptPontoFechamentoJornada(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objPontoFechamentoJornada := TPontoFechamentoJornadaVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPontoFechamentoJornada);
      Result.AddElement(TJSONTrue.Create);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPontoFechamentoJornada.Free;
  end;
end;

function TPontoFechamentoJornadaController.UpdatePontoFechamentoJornada(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objPontoFechamentoJornadaOld: TPontoFechamentoJornadaVO;
begin
 //Objeto Novo
  objPontoFechamentoJornada := TPontoFechamentoJornadaVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objPontoFechamentoJornadaOld := TPontoFechamentoJornadaVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objPontoFechamentoJornada, objPontoFechamentoJornadaOld);
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
    objPontoFechamentoJornada.Free;
  end;
end;

function TPontoFechamentoJornadaController.CancelPontoFechamentoJornada(pSessao: String; pId: Integer): TJSONArray;
begin
  objPontoFechamentoJornada := TPontoFechamentoJornadaVO.Create;
  Result := TJSONArray.Create;
  try
    objPontoFechamentoJornada.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPontoFechamentoJornada);
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
    objPontoFechamentoJornada.Free;
  end;
end;

end.
