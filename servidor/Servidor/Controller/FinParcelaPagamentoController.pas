{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [FIN_PARCELA_PAGAMENTO] 
                                                                                
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
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFinParcelaPagamentoController = class(TController)
  protected
  public
    //consultar
    function FinParcelaPagamento(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFinParcelaPagamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFinParcelaPagamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    function UpdateFinParcelaPagamentoCheque(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFinParcelaPagamento(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FinParcelaPagamentoVO, T2TiORM, SA, FinParcelaPagarVO, ChequeVO, FinChequeEmitidoVO;

{ TFinParcelaPagamentoController }

var
  objFinParcelaPagamento: TFinParcelaPagamentoVO;
  Resultado: Boolean;

function TFinParcelaPagamentoController.FinParcelaPagamento(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFinParcelaPagamentoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFinParcelaPagamentoVO>(pFiltro, pPagina, False);
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

function TFinParcelaPagamentoController.AcceptFinParcelaPagamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objFinParcelaPagamento := TFinParcelaPagamentoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFinParcelaPagamento);
      Result := FinParcelaPagamento(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFinParcelaPagamento.Free;
  end;
end;

function TFinParcelaPagamentoController.UpdateFinParcelaPagamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  objFinParcelaPagar: TFinParcelaPagarVO;
  objCheque: TChequeVO;
  objFinChequeEmitido: TFinChequeEmitidoVO;
begin
  objFinParcelaPagar := TFinParcelaPagarVO.Create((pObjeto as TJSONArray).Get(0));
  objFinParcelaPagamento := TFinParcelaPagamentoVO.Create((pObjeto as TJSONArray).Get(1));
  objFinChequeEmitido := TFinChequeEmitidoVO.Create((pObjeto as TJSONArray).Get(2));
  Result := TJSONArray.Create;
  try
    try
      //altera a parcela a pagar
      Resultado := TT2TiORM.Alterar(objFinParcelaPagar);

      //se foi pago com cheque, realiza as devidas persistências e pega o id do cheque emitido
      if objFinChequeEmitido.IdCheque > 0 then
      begin
        UltimoID := TT2TiORM.Inserir(objFinChequeEmitido);

        objFinParcelaPagamento.IdFinChequeEmitido := UltimoID;

        objCheque := TChequeVO.Create;
        objCheque.Id := objFinChequeEmitido.IdCheque;
        objCheque.DataStatus := now;
        objCheque.StatusCheque := 'U';
        Resultado := TT2TiORM.Alterar(objCheque);
      end;

      //insere ou altera a parcela paga
      if objFinParcelaPagamento.Id > 0 then
        Resultado := TT2TiORM.Alterar(objFinParcelaPagamento)
      else
        Resultado := TT2TiORM.Inserir(objFinParcelaPagamento) > 0;

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
    objFinParcelaPagamento.Free;
  end;
end;

function TFinParcelaPagamentoController.UpdateFinParcelaPagamentoCheque(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  objFinParcelaPagar: TFinParcelaPagarVO;
  objCheque: TChequeVO;
  objFinChequeEmitido: TFinChequeEmitidoVO;
  ListaParcelaPagarJson, ListaParcelaPagamentoJson: TJSONValue;
  i: Integer;
begin
  //o primeiro item traz a lista de parcelas a pagar
  ListaParcelaPagarJson := (pObjeto as TJSONArray).Get(0);

  //o segundo item traz a lista de parcelas para pagamento
  ListaParcelaPagamentoJson := (pObjeto as TJSONArray).Get(1);

  //o terceiro item traz a cheque emitido
  objFinChequeEmitido := TFinChequeEmitidoVO.Create((pObjeto as TJSONArray).Get(2));

  Result := TJSONArray.Create;
  try
    try
      //altera a lista de parcelas a pagar
      for i := 0 to (ListaParcelaPagarJson as TJSONArray).Size - 1 do
      begin
        objFinParcelaPagar := TFinParcelaPagarVO.Create((ListaParcelaPagarJson as TJSONArray).Get(i));
        Resultado := TT2TiORM.Alterar(objFinParcelaPagar);
      end;

      //realiza as devidas persistências e pega o id do cheque emitido
      UltimoID := TT2TiORM.Inserir(objFinChequeEmitido);

      //insere ou altera a lista de parcelas pagas
      for i := 0 to (ListaParcelaPagamentoJson as TJSONArray).Size - 1 do
      begin
        objFinParcelaPagamento := TFinParcelaPagamentoVO.Create((ListaParcelaPagamentoJson as TJSONArray).Get(i));
        objFinParcelaPagamento.IdFinChequeEmitido := UltimoID;
        if objFinParcelaPagamento.Id > 0 then
          Resultado := TT2TiORM.Alterar(objFinParcelaPagamento)
        else
          Resultado := TT2TiORM.Inserir(objFinParcelaPagamento) > 0;
      end;

      objCheque := TChequeVO.Create;
      objCheque.Id := objFinChequeEmitido.IdCheque;
      objCheque.DataStatus := now;
      objCheque.StatusCheque := 'U';
      Resultado := TT2TiORM.Alterar(objCheque);
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
    objFinParcelaPagamento.Free;
  end;
end;

function TFinParcelaPagamentoController.CancelFinParcelaPagamento(pSessao: String; pId: Integer): TJSONArray;
begin
  objFinParcelaPagamento := TFinParcelaPagamentoVO.Create;
  Result := TJSONArray.Create;
  try
    objFinParcelaPagamento.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFinParcelaPagamento);
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
    objFinParcelaPagamento.Free;
  end;
end;

end.
