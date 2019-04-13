{ *******************************************************************************
  Title: T2Ti ERP
  Description: Classe de controle do Sped Fiscal.

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
  ******************************************************************************* }
unit SpedFiscalController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, SpedFiscalC390VO, Biblioteca,
  SpedFiscalC321VO, SpedFiscalC370VO, SpedFiscalC425VO, SpedFiscalC490VO, MeiosPagamentoVO, Constantes;

type
  TSpedFiscalController = class
  protected
  public
    class function TabelaC390(Id: Integer): TObjectList<TSpedFiscalC390VO>;
    class function TabelaC321(DataInicio: String; DataFim: String): TObjectList<TSpedFiscalC321VO>;
    class function TabelaC370(Id : Integer): TObjectList<TSpedFiscalC370VO>;
    class function TabelaC425(DataInicio: String; DataFim: String; TotalizadorParcial: String): TObjectList<TSpedFiscalC425VO>;
    class function TabelaC490(DataInicio: String; DataFim: String): TObjectList<TSpedFiscalC490VO>;
    class function TabelaE110(DataInicio: String; DataFim: String): TObjectList<TMeiosPagamentoVO>;
 end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TSpedFiscalController.TabelaC370(Id: Integer): TObjectList<TSpedFiscalC370VO>;
var
  ListaC370: TObjectList<TSpedFiscalC370VO>;
  RegistroC370: TSpedFiscalC370VO;
begin
//  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
//  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select * from VIEW_C370 '+
    'where ID_NF_CABECALHO = ' + IntToStr(Id);
//    'DATA_EMISSAO between '+
//    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim);// +
//    ' and TOTALIZADOR_PARCIAL = ' + QuotedStr(TotalizadorParcial);

  try
    try
      ListaC370 := TObjectList<TSpedFiscalC370VO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC370 := TSpedFiscalC370VO.Create;
//        RegistroC370.IdCabecalho := Query.FieldByName('ID_NF_CABECALHO').AsInteger;
        RegistroC370.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
        RegistroC370.Item := Query.FieldByName('ITEM').AsInteger;
        RegistroC370.IdUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
        RegistroC370.Quantidade := TruncaValor(Query.FieldByName('QUANTIDADE').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC370.Valor := TruncaValor(Query.FieldByName('VALOR_TOTAL').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC370.Valor := TruncaValor(Query.FieldByName('VALOR_TOTAL').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);

        ListaC370.Add(RegistroC370);
        Query.next;
      end;
      result := ListaC370;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;

end;

class function TSpedFiscalController.TabelaC390(Id: Integer): TObjectList<TSpedFiscalC390VO>;
var
  ListaC390: TObjectList<TSpedFiscalC390VO>;
  RegistroC390: TSpedFiscalC390VO;
begin
{  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

{  ConsultaSQL :=
    'select * from VIEW_C390 '+
    'where '+
    'DATA_EMISSAO between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim);
 }
   ConsultaSQL :=
    'select * from VIEW_C390 '+
    'where ID = ' + IntToStr(Id);


  try
    try
      ListaC390 := TObjectList<TSpedFiscalC390VO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC390 := TSpedFiscalC390VO.Create;
        RegistroC390.CST := Query.FieldByName('CST').AsString;
        RegistroC390.CFOP := Query.FieldByName('CFOP').AsInteger;
        RegistroC390.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
        RegistroC390.SomaValor := TruncaValor(Query.FieldByName('SOMA_ITEM').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC390.SomaBaseICMS := TruncaValor(Query.FieldByName('SOMA_BASE_ICMS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC390.SomaICMS := TruncaValor(Query.FieldByName('SOMA_ICMS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC390.SomaICMSOutras := TruncaValor(Query.FieldByName('SOMA_ICMS_OUTRAS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);

        ListaC390.Add(RegistroC390);
        Query.next;
      end;
      result := ListaC390;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaC321(DataInicio: String; DataFim: String): TObjectList<TSpedFiscalC321VO>;
var
  ListaC321: TObjectList<TSpedFiscalC321VO>;
  RegistroC321: TSpedFiscalC321VO;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select * from VIEW_C321 '+
    'where '+
    'DATA_EMISSAO between '+
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim);

  try
    try
      ListaC321 := TObjectList<TSpedFiscalC321VO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC321 := TSpedFiscalC321VO.Create;
        RegistroC321.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
        RegistroC321.SomaQuantidade := TruncaValor(Query.FieldByName('SOMA_QUANTIDADE').AsFloat,Constantes.TConstantes.DECIMAIS_QUANTIDADE);
        RegistroC321.SomaValor := TruncaValor(Query.FieldByName('SOMA_ITEM').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC321.SomaDesconto := TruncaValor(Query.FieldByName('SOMA_DESCONTO').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC321.SomaBaseICMS := TruncaValor(Query.FieldByName('SOMA_BASE_ICMS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC321.SomaICMS := TruncaValor(Query.FieldByName('SOMA_ICMS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC321.SomaPIS := TruncaValor(Query.FieldByName('SOMA_PIS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC321.SomaCOFINS := TruncaValor(Query.FieldByName('SOMA_COFINS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC321.DescricaoUnidade := Query.FieldByName('DESCRICAO_UNIDADE').AsString;

        ListaC321.Add(RegistroC321);
        Query.next;
      end;
      result := ListaC321;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaC425(DataInicio: String; DataFim: String; TotalizadorParcial:String): TObjectList<TSpedFiscalC425VO>;
var
  ListaC425: TObjectList<TSpedFiscalC425VO>;
  RegistroC425: TSpedFiscalC425VO;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select * from VIEW_C425 '+
    'where '+
    'DATA_VENDA between '+
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) +
    ' and TOTALIZADOR_PARCIAL = ' + QuotedStr(TotalizadorParcial);

  try
    try
      ListaC425 := TObjectList<TSpedFiscalC425VO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC425 := TSpedFiscalC425VO.Create;
        RegistroC425.IdProduto := Query.FieldByName('ID_ECF_PRODUTO').AsInteger;
        RegistroC425.idUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
        RegistroC425.SomaQuantidade := TruncaValor(Query.FieldByName('SOMA_QUANTIDADE').AsFloat,Constantes.TConstantes.DECIMAIS_QUANTIDADE);
        RegistroC425.SomaValor := TruncaValor(Query.FieldByName('SOMA_ITEM').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC425.SomaPIS := TruncaValor(Query.FieldByName('SOMA_PIS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC425.SomaCOFINS := TruncaValor(Query.FieldByName('SOMA_COFINS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC425.DescricaoUnidade := Query.FieldByName('DESCRICAO_UNIDADE').AsString;

        ListaC425.Add(RegistroC425);
        Query.next;
      end;
      result := ListaC425;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaC490(DataInicio: String; DataFim: String): TObjectList<TSpedFiscalC490VO>;
var
  ListaC490: TObjectList<TSpedFiscalC490VO>;
  RegistroC490: TSpedFiscalC490VO;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=  'select * from VIEW_C490 '+
    'where '+
    'DATA_VENDA = ' + QuotedStr(DataInicio);

  try
    try
      ListaC490 := TObjectList<TSpedFiscalC490VO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC490 := TSpedFiscalC490VO.Create;
        RegistroC490.CST := Query.FieldByName('CST').AsString;
        RegistroC490.CFOP := Query.FieldByName('CFOP').AsInteger;
        RegistroC490.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
        RegistroC490.SomaValor := TruncaValor(Query.FieldByName('SOMA_ITEM').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC490.SomaBaseICMS := TruncaValor(Query.FieldByName('SOMA_BASE_ICMS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        RegistroC490.SomaICMS := TruncaValor(Query.FieldByName('SOMA_ICMS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);

        ListaC490.Add(RegistroC490);
        Query.next;
      end;
      result := ListaC490;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaE110(DataInicio: String; DataFim: String): TObjectList<TMeiosPagamentoVO>;
var
  ListaE110: TObjectList<TMeiosPagamentoVO>;
  MeiosPagamento: TMeiosPagamentoVO;
begin
      DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
      DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));
      ConsultaSQL :=
                    'select sum(soma_icms) as soma_icms from VIEW_E110 '+
                    'where '+
                    'DATA_EMISSAO between '+
                    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim)+
                    ' group by extract(year from data_emissao), extract(month from data_emissao)' ;

  try
    try
      ListaE110 := TObjectList<TMeiosPagamentoVO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        MeiosPagamento := TMeiosPagamentoVO.Create;
        MeiosPagamento.DataHora :=  copy(DataInicio, 1 ,7);
        MeiosPagamento.Total := Query.FieldByName('SOMA_ICMS').AsFloat;
        ListaE110.Add(MeiosPagamento);
        Query.next;
      end;
      result := ListaE110;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
