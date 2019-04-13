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
    class function QuantidadeRegistroTabela: Integer;
  end;

implementation

uses UDataModule, UECF, ACBrTEFD, ACBrTEFDClass, R07VO, RegistroRController;

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

end.
