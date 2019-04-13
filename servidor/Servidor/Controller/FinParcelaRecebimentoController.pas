{*******************************************************************************
Title: T2Ti ERP
Description: Controller do lado Servidor relacionado à tabela [FIN_PARCELA_RECEBIMENTO]

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
unit FinParcelaRecebimentoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFinParcelaRecebimentoController = class(TController)
  protected
  public
    //consultar
    function FinParcelaRecebimento(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFinParcelaRecebimento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFinParcelaRecebimento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    function UpdateFinParcelaRecebimentoCheque(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFinParcelaRecebimento(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FinParcelaRecebimentoVO, T2TiORM, SA, FinParcelaReceberVO, ChequeVO, FinChequeRecebidoVO;

{ TFinParcelaRecebimentoController }

var
  objFinParcelaRecebimento: TFinParcelaRecebimentoVO;
  Resultado: Boolean;

function TFinParcelaRecebimentoController.FinParcelaRecebimento(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFinParcelaRecebimentoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFinParcelaRecebimentoVO>(pFiltro, pPagina, False);
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

function TFinParcelaRecebimentoController.AcceptFinParcelaRecebimento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objFinParcelaRecebimento := TFinParcelaRecebimentoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFinParcelaRecebimento);
      Result := FinParcelaRecebimento(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFinParcelaRecebimento.Free;
  end;
end;

function TFinParcelaRecebimentoController.UpdateFinParcelaRecebimento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  objFinParcelaReceber: TFinParcelaReceberVO;
  objCheque: TChequeVO;
  objFinChequeRecebido: TFinChequeRecebidoVO;
begin
  objFinParcelaReceber := TFinParcelaReceberVO.Create((pObjeto as TJSONArray).Get(0));
  objFinParcelaRecebimento := TFinParcelaRecebimentoVO.Create((pObjeto as TJSONArray).Get(1));
  objFinChequeRecebido := TFinChequeRecebidoVO.Create((pObjeto as TJSONArray).Get(2));
  Result := TJSONArray.Create;
  try
    try
      //altera a parcela a Receber
      Resultado := TT2TiORM.Alterar(objFinParcelaReceber);

      //se foi recebido com cheque, realiza as devidas persistências
      if objFinChequeRecebido.Numero > 0 then
      begin
        UltimoID := TT2TiORM.Inserir(objFinChequeRecebido);
        objFinParcelaRecebimento.IdFinChequeRecebido := UltimoID;
      end;

      //insere ou altera a parcela paga
      if objFinParcelaRecebimento.Id > 0 then
        Resultado := TT2TiORM.Alterar(objFinParcelaRecebimento)
      else
        Resultado := TT2TiORM.Inserir(objFinParcelaRecebimento) > 0;

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
    objFinParcelaRecebimento.Free;
  end;
end;

function TFinParcelaRecebimentoController.UpdateFinParcelaRecebimentoCheque(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  objFinParcelaReceber: TFinParcelaReceberVO;
  objCheque: TChequeVO;
  objFinChequeRecebido: TFinChequeRecebidoVO;
  ListaParcelaReceberJson, ListaParcelaRecebimentoJson: TJSONValue;
  i: Integer;
begin
  //o primeiro item traz a lista de parcelas a Receber
  ListaParcelaReceberJson := (pObjeto as TJSONArray).Get(0);

  //o segundo item traz a lista de parcelas para Recebimento
  ListaParcelaRecebimentoJson := (pObjeto as TJSONArray).Get(1);

  //o terceiro item traz a cheque Recebido
  objFinChequeRecebido := TFinChequeRecebidoVO.Create((pObjeto as TJSONArray).Get(2));

  Result := TJSONArray.Create;
  try
    try
      //altera a lista de parcelas a Receber
      for i := 0 to (ListaParcelaReceberJson as TJSONArray).Size - 1 do
      begin
        objFinParcelaReceber := TFinParcelaReceberVO.Create((ListaParcelaReceberJson as TJSONArray).Get(i));
        Resultado := TT2TiORM.Alterar(objFinParcelaReceber);
      end;

      //realiza as devidas persistências e pega o id do cheque Recebido
      UltimoID := TT2TiORM.Inserir(objFinChequeRecebido);

      //insere ou altera a lista de parcelas pagas
      for i := 0 to (ListaParcelaRecebimentoJson as TJSONArray).Size - 1 do
      begin
        objFinParcelaRecebimento := TFinParcelaRecebimentoVO.Create((ListaParcelaRecebimentoJson as TJSONArray).Get(i));
        objFinParcelaRecebimento.IdFinChequeRecebido := UltimoID;
        if objFinParcelaRecebimento.Id > 0 then
          Resultado := TT2TiORM.Alterar(objFinParcelaRecebimento)
        else
          Resultado := TT2TiORM.Inserir(objFinParcelaRecebimento) > 0;
      end;
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
    objFinParcelaRecebimento.Free;
  end;
end;

function TFinParcelaRecebimentoController.CancelFinParcelaRecebimento(pSessao: String; pId: Integer): TJSONArray;
begin
  objFinParcelaRecebimento := TFinParcelaRecebimentoVO.Create;
  Result := TJSONArray.Create;
  try
    objFinParcelaRecebimento.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFinParcelaRecebimento);
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
    objFinParcelaRecebimento.Free;
  end;
end;

end.
