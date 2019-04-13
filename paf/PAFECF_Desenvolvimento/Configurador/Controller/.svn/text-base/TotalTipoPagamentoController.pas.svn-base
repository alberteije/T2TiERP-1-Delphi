{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle dos totais de tipos de pagamento.

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

@author Albert Eije (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit TotalTipoPagamentoController;

interface

uses
  Classes, SQLExpr, SysUtils, TipoPagamentoVO, Generics.Collections, TotalTipoPagamentoVO,
  DB, MeiosPagamentoVO;

type
  TTotalTipoPagamentoController = class
  protected
  public
    class Procedure GravaTotaisVenda(ListaTotalTipoPagamento: TObjectList<TTotalTipoPagamentoVO>);
    class Procedure GravaTotalTipoPagamento(TotalTipoPagamento: TTotalTipoPagamentoVO);
    class function MeiosPagamento(DataInicio:String;DataFim:String;IdImpressora:Integer): TObjectList<TMeiosPagamentoVO>;
    class function MeiosPagamentoTotal(DataInicio:String;DataFim:String;IdImpressora:Integer): TObjectList<TMeiosPagamentoVO>;
    class function EncerramentoTotal(IdMovimento:Integer; Tipo : Integer): TObjectList<TMeiosPagamentoVO>;
    class function QuantidadeRegistroTabela: Integer;
    class function RetornaMeiosPagamentoDaUltimaVenda(IdCabecalho:integer): TObjectList<TTotalTipoPagamentoVO>;
  end;

implementation

uses UDataModule, ACBrTEFD, ACBrTEFDClass;

var
  Query: TSQLQuery;
  ConsultaSQL: String;

class Procedure TTotalTipoPagamentoController.GravaTotalTipoPagamento(TotalTipoPagamento: TTotalTipoPagamentoVO);
var
  i: Integer;
begin
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text :=
        'insert into ECF_TOTAL_TIPO_PGTO (ID_ECF_VENDA_CABECALHO,ID_ECF_TIPO_PAGAMENTO,VALOR,NSU,ESTORNO, REDE, CARTAO_DC) '
        + 'values (:pIdVendaCabecalho, :pIdTipoPagamento, :pValor, :pNSU, :pEstorno, :pRede, :pDebitoCredito)';
      Query.ParamByName('pIdVendaCabecalho').AsInteger := TotalTipoPagamento.IdVenda;
      Query.ParamByName('pIdTipoPagamento').AsInteger := TotalTipoPagamento.IdTipoPagamento;
      Query.ParamByName('pValor').AsFloat := TotalTipoPagamento.Valor;
      Query.ParamByName('pEstorno').AsString := TotalTipoPagamento.Estorno;
      //NSU
      if TotalTipoPagamento.NSU <> '' then
        Query.ParamByName('pNSU').AsString := TotalTipoPagamento.NSU
      else
      begin
        Query.ParamByName('pNSU').DataType := ftString;
        Query.ParamByName('pNSU').Clear;
      end;
      //Rede
      if TotalTipoPagamento.Rede <> '' then
        Query.ParamByName('pRede').AsString := TotalTipoPagamento.Rede
      else
      begin
        Query.ParamByName('pNSU').DataType := ftString;
        Query.ParamByName('pNSU').Clear;
      end;
      //debito ou credito
      if TotalTipoPagamento.CartaoDebitoOuCredito <> '' then
        Query.ParamByName('pDebitoCredito').AsString := TotalTipoPagamento.CartaoDebitoOuCredito
      else
      begin
        Query.ParamByName('pDebitoCredito').DataType := ftString;
        Query.ParamByName('pDebitoCredito').Clear;
      end;

      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

class Procedure TTotalTipoPagamentoController.GravaTotaisVenda(ListaTotalTipoPagamento: TObjectList<TTotalTipoPagamentoVO>);
var
  i: Integer;
  TotalTipoPagamento: TTotalTipoPagamentoVO;
begin
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      for i := 0 to ListaTotalTipoPagamento.Count - 1 do
      begin
        TotalTipoPagamento := ListaTotalTipoPagamento.Items[i];
        Query.sql.Text :=
          'insert into ECF_TOTAL_TIPO_PGTO (ID_ECF_VENDA_CABECALHO,ID_ECF_TIPO_PAGAMENTO,VALOR,NSU,ESTORNO, REDE, CARTAO_DC) '
          + 'values (:pIdVendaCabecalho, :pIdTipoPagamento, :pValor, :pNSU, :pEstorno,:pRede, :pDebitoCredito)';
        Query.ParamByName('pIdVendaCabecalho').AsInteger := TotalTipoPagamento.IdVenda;
        Query.ParamByName('pIdTipoPagamento').AsInteger := TotalTipoPagamento.IdTipoPagamento;
        Query.ParamByName('pValor').AsFloat := TotalTipoPagamento.Valor;
        Query.ParamByName('pEstorno').AsString := TotalTipoPagamento.Estorno;
        //NSU
        if TotalTipoPagamento.NSU <> '' then
          Query.ParamByName('pNSU').AsString := TotalTipoPagamento.NSU
        else
        begin
          Query.ParamByName('pNSU').DataType := ftString;
          Query.ParamByName('pNSU').Clear;
        end;
        //Rede
        if TotalTipoPagamento.Rede <> '' then
          Query.ParamByName('pRede').AsString := TotalTipoPagamento.Rede
        else
        begin
          Query.ParamByName('pRede').DataType := ftString;
          Query.ParamByName('pRede').Clear;
        end;
        //debito ou credito
        if TotalTipoPagamento.CartaoDebitoOuCredito <> '' then
          Query.ParamByName('pDebitoCredito').AsString := TotalTipoPagamento.CartaoDebitoOuCredito
        else
        begin
          Query.ParamByName('pDebitoCredito').DataType := ftString;
          Query.ParamByName('pDebitoCredito').Clear;
        end;

        Query.ExecSQL();
      end;
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TTotalTipoPagamentoController.MeiosPagamento(DataInicio:String;DataFim:String;IdImpressora:Integer): TObjectList<TMeiosPagamentoVO>;
var
  ListaMeiosPagamento: TObjectList<TMeiosPagamentoVO>;
  MeiosPagamento: TMeiosPagamentoVO;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'SELECT * from VIEW_MEIOS_PAGAMENTO ' +
    'WHERE '+
    'ID_ECF_IMPRESSORA = '+ IntToStr(idImpressora) + ' AND '+
    '(DATA_ACUMULADO BETWEEN ' + QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) +
    ') order by DATA_ACUMULADO';
  try
    try
      ListaMeiosPagamento := TObjectList<TMeiosPagamentoVO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        MeiosPagamento := TMeiosPagamentoVO.Create;
        MeiosPagamento.Descricao := Query.FieldByName('DESCRICAO').AsString;
        MeiosPagamento.DataHora := Query.FieldByName('DATA_ACUMULADO').AsString;
        MeiosPagamento.Total := Query.FieldByName('TOTAL').AsFloat;
        ListaMeiosPagamento.Add(MeiosPagamento);
        Query.next;
      end;
      result := ListaMeiosPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TTotalTipoPagamentoController.MeiosPagamentoTotal(DataInicio:String;DataFim:String;IdImpressora:Integer): TObjectList<TMeiosPagamentoVO>;
var
  ListaMeiosPagamento: TObjectList<TMeiosPagamentoVO>;
  MeiosPagamento: TMeiosPagamentoVO;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'SELECT * from VIEW_MEIOS_PAGAMENTO_TOTAL ' +
    'WHERE '+
    'ID_ECF_IMPRESSORA = '+ IntToStr(idImpressora) + ' AND '+
    '(DATA_ACUMULADO BETWEEN ' + QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) +
    ') order by DATA_ACUMULADO';
  try
    try
      ListaMeiosPagamento := TObjectList<TMeiosPagamentoVO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        MeiosPagamento := TMeiosPagamentoVO.Create;
        MeiosPagamento.Descricao := Query.FieldByName('DESCRICAO').AsString;
        MeiosPagamento.DataHora := Query.FieldByName('DATA_ACUMULADO').AsString;
        MeiosPagamento.Total := Query.FieldByName('TOTAL').AsFloat;
        ListaMeiosPagamento.Add(MeiosPagamento);
        Query.next;
      end;
      result := ListaMeiosPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TTotalTipoPagamentoController.EncerramentoTotal(IdMovimento:Integer; Tipo : Integer): TObjectList<TMeiosPagamentoVO>;
var
  ListaMeiosPagamento: TObjectList<TMeiosPagamentoVO>;
  MeiosPagamento: TMeiosPagamentoVO;
begin
  if Tipo = 1 then
  ConsultaSQL :=
    'select v.DATA_VENDA AS DATA_ACUMULADO,m.ID_ECF_IMPRESSORA,p.DESCRICAO, '+
    'COALESCE(sum(tp.VALOR),0) AS TOTAL '+
    'from ecf_venda_cabecalho v '+
          'INNER JOIN ecf_movimento m ON (v.ID_ECF_MOVIMENTO = m.ID) '+
          'INNER JOIN ecf_total_tipo_pgto tp ON (v.ID = tp.ID_ECF_VENDA_CABECALHO) '+
          'INNER JOIN ecf_tipo_pagamento p ON (tp.ID_ECF_TIPO_PAGAMENTO = p.ID) '+
    ' WHERE v.ID_ECF_MOVIMENTO = '+IntToStr(IdMovimento)+
    ' GROUP BY p.DESCRICAO,m.ID_ECF_IMPRESSORA,v.DATA_VENDA'
  else
  ConsultaSQL :=
    'SELECT '+QuotedStr('DATA')+' AS DATA_ACUMULADO, TIPO_PAGAMENTO AS DESCRICAO, '+
    ' COALESCE(sum(VALOR),0) AS TOTAL  FROM ECF_FECHAMENTO'+
    ' WHERE ID_ECF_MOVIMENTO = '+IntToStr(IdMovimento)+
    ' GROUP BY TIPO_PAGAMENTO';

  try
    try
      ListaMeiosPagamento := TObjectList<TMeiosPagamentoVO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        MeiosPagamento := TMeiosPagamentoVO.Create;
        MeiosPagamento.Descricao := Query.FieldByName('DESCRICAO').AsString;
        MeiosPagamento.DataHora := Query.FieldByName('DATA_ACUMULADO').AsString;
        MeiosPagamento.Total := Query.FieldByName('TOTAL').AsFloat;
        ListaMeiosPagamento.Add(MeiosPagamento);
        Query.next;
      end;
      result := ListaMeiosPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;


class function TTotalTipoPagamentoController.QuantidadeRegistroTabela: Integer;
begin
  ConsultaSQL :=
    'SELECT count(*) as TOTAL from ecf_total_tipo_pgto';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      result := Query.FieldByName('TOTAL').AsInteger;
    except
      result := 1;
    end;
  finally
    Query.Free;
  end;
end;

class function TTotalTipoPagamentoController.RetornaMeiosPagamentoDaUltimaVenda(IdCabecalho:integer): TObjectList<TTotalTipoPagamentoVO>;
var
  ListaTotalTipoPagamento: TObjectList<TTotalTipoPagamentoVO>;
  TotalTipoPagamento: TTotalTipoPagamentoVO;
begin


ConsultaSQL := 'SELECT T.ID, ' +
               'T.ID_ECF_VENDA_CABECALHO, ' +
               'T.ID_ECF_TIPO_PAGAMENTO, ' +
               'T.VALOR, ' +
               'T.NSU, ' +
               'T.ESTORNO, ' +
               'T.REDE, ' +
               'T.CARTAO_DC, ' +
               'P.DESCRICAO ' +
               'FROM ECF_TIPO_PAGAMENTO  P, ECF_TOTAL_TIPO_PGTO T ' +
               'WHERE (ID_ECF_VENDA_CABECALHO = '+ IntToStr(IdCabecalho) + ')  '+
               ' and (P.ID = T.ID_ECF_TIPO_PAGAMENTO) order by T.ID_ECF_TIPO_PAGAMENTO';


  try
    try
      ListaTotalTipoPagamento := TObjectList<TTotalTipoPagamentoVO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        TotalTipoPagamento := TTotalTipoPagamentoVO.Create;

        TotalTipoPagamento.Id := Query.FieldByName('ID').AsInteger;
        TotalTipoPagamento.IdVenda := Query.FieldByName('ID_ECF_VENDA_CABECALHO').AsInteger;
        TotalTipoPagamento.IdTipoPagamento := Query.FieldByName('ID_ECF_TIPO_PAGAMENTO').AsInteger;
        TotalTipoPagamento.Valor := Query.FieldByName('VALOR').AsFloat;
        TotalTipoPagamento.NSU := Query.FieldByName('NSU').AsString;
        TotalTipoPagamento.Estorno := Query.FieldByName('ESTORNO').AsString;
        TotalTipoPagamento.Rede := Query.FieldByName('REDE').AsString;
        TotalTipoPagamento.CartaoDebitoOuCredito := Query.FieldByName('CARTAO_DC').AsString;
        TotalTipoPagamento.Descricao := Query.FieldByName('DESCRICAO').AsString;

        ListaTotalTipoPagamento.Add(TotalTipoPagamento);

        Query.next;
      end;
      result := ListaTotalTipoPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;


end.
