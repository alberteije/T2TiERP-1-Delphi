{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PONTO_MARCACAO] 
                                                                                
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
unit PontoMarcacaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPontoMarcacaoController = class(TController)
  protected
  public
    //consultar
    function PontoMarcacao(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPontoMarcacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    function AcceptPontoMarcacaoLista(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePontoMarcacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPontoMarcacao(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  PontoMarcacaoVO, PontoFechamentoJornadaVO, T2TiORM, SA;

{ TPontoMarcacaoController }

var
  objPontoMarcacao: TPontoMarcacaoVO;
  Resultado: Boolean;

function TPontoMarcacaoController.PontoMarcacao(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TPontoMarcacaoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TPontoMarcacaoVO>(pFiltro, pPagina, False);
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

function TPontoMarcacaoController.AcceptPontoMarcacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objPontoMarcacao := TPontoMarcacaoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPontoMarcacao);
      Result := PontoMarcacao(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPontoMarcacao.Free;
  end;
end;

function TPontoMarcacaoController.AcceptPontoMarcacaoLista(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  i: Integer;
  ListaPontoMarcacaoJson, ListaPontoFechamentoJornadaJson: TJSONValue;
  objPontoFechamentoJornada: TPontoFechamentoJornadaVO;
begin
  // O primeiro item traz a lista de marcações
  ListaPontoMarcacaoJson := (pObjeto as TJSONArray).Get(0);

  // O segundo item traz a lista de fechamento
  ListaPontoFechamentoJornadaJson := (pObjeto as TJSONArray).Get(1);

  Result := TJSONArray.Create;
  try
    try
      // Marcações
      for i := 0 to (ListaPontoMarcacaoJson as TJSONArray).Size - 1 do
      begin
        objPontoMarcacao := TPontoMarcacaoVO.Create((ListaPontoMarcacaoJson as TJSONArray).Get(i));
        TT2TiORM.Inserir(objPontoMarcacao);
      end;

      // Fechamentos
      for i := 0 to (ListaPontoFechamentoJornadaJson as TJSONArray).Size - 1 do
      begin
        objPontoFechamentoJornada := TPontoFechamentoJornadaVO.Create((ListaPontoFechamentoJornadaJson as TJSONArray).Get(i));
        TT2TiORM.Inserir(objPontoFechamentoJornada);
      end;

      Result.AddElement(TJSONTrue.Create);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPontoMarcacao.Free;
  end;
end;

function TPontoMarcacaoController.UpdatePontoMarcacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objPontoMarcacaoOld: TPontoMarcacaoVO;
begin
  //Objeto Novo
  objPontoMarcacao := TPontoMarcacaoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objPontoMarcacaoOld := TPontoMarcacaoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objPontoMarcacao, objPontoMarcacaoOld);
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
    objPontoMarcacao.Free;
  end;
end;

function TPontoMarcacaoController.CancelPontoMarcacao(pSessao: String; pId: Integer): TJSONArray;
begin
  objPontoMarcacao := TPontoMarcacaoVO.Create;
  Result := TJSONArray.Create;
  try
    objPontoMarcacao.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPontoMarcacao);
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
    objPontoMarcacao.Free;
  end;
end;

end.
