{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado à tabela [FIN_PARCELA_PAGAMENTO] 
                                                                                
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
unit FinParcelaPagamentoController;

interface

uses
  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB, Windows, Forms, Controller,
  Rtti, Atributos, FinParcelaPagamentoVO, FinParcelaPagarVO, FinChequeEmitidoVO,
  Generics.Collections;


type
  TFinParcelaPagamentoController = class(TController)
  private
    class var FDataSet: TClientDataSet;
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer);
    class function Insere(pFinParcelaPagamento: TFinParcelaPagamentoVO): Boolean;
    class function Altera(pFinParcelaPagar: TFinParcelaPagarVO; pFinParcelaPagamento: TFinParcelaPagamentoVO; pFinChequeEmitido: TFinChequeEmitidoVO): Boolean; overload;
    class function Altera(pListaParcelaPagar: TObjectList<TFinParcelaPagarVO>; pListaParcelaPagamento: TObjectList<TFinParcelaPagamentoVO>; pFinChequeEmitido: TFinChequeEmitidoVO): Boolean; overload;
    class function Exclui(pId: Integer): Boolean;

    class function GetDataSet: TClientDataSet; override;
    class procedure SetDataSet(pDataSet: TClientDataSet); override;

    class function MethodCtx: String; override;
  end;

implementation

uses UDataModule, Conversor;

class procedure TFinParcelaPagamentoController.Consulta(pFiltro: String; pPagina: Integer);
var
  StreamResposta: TStringStream;
begin
  try
    StreamResposta := TStringStream.Create;
    try
      Get([pFiltro, IntToStr(pPagina)], StreamResposta);
      PopulaGrid<TFinParcelaPagamentoVO>(StreamResposta);
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro durante a consulta. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TFinParcelaPagamentoController.Insere(pFinParcelaPagamento: TFinParcelaPagamentoVO): Boolean;
var
  DataStream: TStringStream;
  StreamResposta: TStringStream;
  jRegistro: TJSONArray;
begin
  Result := False;
  try
    StreamResposta := TStringStream.Create;
    try
      DataStream := TStringStream.Create(pFinParcelaPagamento.ToJSONString);
      try
        Put([], DataStream, StreamResposta);
      finally
        DataStream.Free;
      end;

      jRegistro := TConversor.JSONArrayStreamToJSONArray(StreamResposta);
      try
        if jRegistro.Size > 0 then
        begin
          Result := True;
          PopulaGrid<TFinParcelaPagamentoVO>(StreamResposta);
        end;
      finally
        jRegistro.Free;
      end;
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na inclusão do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TFinParcelaPagamentoController.Altera(pFinParcelaPagar: TFinParcelaPagarVO; pFinParcelaPagamento: TFinParcelaPagamentoVO; pFinChequeEmitido: TFinChequeEmitidoVO): Boolean;
var
  DataStream: TStringStream;
  StreamResposta: TStringStream;
  ObjetosJson: TJSONArray;
begin
  try
    StreamResposta := TStringStream.Create;
    ObjetosJson := TJSONArray.Create;
    ObjetosJson.AddElement(pFinParcelaPagar.ToJSON);
    ObjetosJson.AddElement(pFinParcelaPagamento.ToJSON);
    ObjetosJson.AddElement(pFinChequeEmitido.ToJSON);
    try
      DataStream := TStringStream.Create(ObjetosJson.ToString);
      try
        Post([], DataStream, StreamResposta);
      finally
        DataStream.Free;
        ObjetosJson.Free;
      end;
      Result := TConversor.JSONObjectStreamToBoolean(StreamResposta);
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na alteração do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TFinParcelaPagamentoController.Altera(pListaParcelaPagar: TObjectList<TFinParcelaPagarVO>; pListaParcelaPagamento: TObjectList<TFinParcelaPagamentoVO>; pFinChequeEmitido: TFinChequeEmitidoVO): Boolean;
var
  DataStream: TStringStream;
  StreamResposta: TStringStream;
  ObjetosJson, ListaParcelaPagar, ListaParcelaPagamento: TJSONArray;
  i: Integer;
begin
  try
    StreamResposta := TStringStream.Create;
    ObjetosJson := TJSONArray.Create;
    ListaParcelaPagar := TJSONArray.Create;
    ListaParcelaPagamento := TJSONArray.Create;

    for i := 0 to pListaParcelaPagar.Count - 1 do
    begin
      ListaParcelaPagar.AddElement(pListaParcelaPagar.Items[i].ToJSON);
    end;
    for i := 0 to pListaParcelaPagamento.Count - 1 do
    begin
      ListaParcelaPagamento.AddElement(pListaParcelaPagamento.Items[i].ToJSON);
    end;

    ObjetosJson.AddElement(ListaParcelaPagar);
    ObjetosJson.AddElement(ListaParcelaPagamento);
    ObjetosJson.AddElement(pFinChequeEmitido.ToJSON);
    try
      DataStream := TStringStream.Create(ObjetosJson.ToString);
      try
        Post('TFinParcelaPagamentoController', 'FinParcelaPagamentoCheque', [], DataStream, StreamResposta);
        //Post([], DataStream, StreamResposta);
      finally
        DataStream.Free;
        ObjetosJson.Free;
      end;
      Result := TConversor.JSONObjectStreamToBoolean(StreamResposta);
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na alteração do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TFinParcelaPagamentoController.Exclui(pId: Integer): Boolean;
begin
  try
    Result := TConversor.JSONPairStrToBoolean(Delete([IntToStr(pId)]));
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na exclusão do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TFinParcelaPagamentoController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

class procedure TFinParcelaPagamentoController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class function TFinParcelaPagamentoController.MethodCtx: String;
begin
  Result := 'FinParcelaPagamento';
end;

end.
