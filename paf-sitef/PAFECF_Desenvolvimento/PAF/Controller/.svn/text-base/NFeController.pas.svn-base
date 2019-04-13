{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da NFe para o PAF-ECF.

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

@author Albert Eije (T2Ti.COM) | Clausqueler
@version 1.0
*******************************************************************************}
unit NFeController;

interface

uses
  Classes, SQLExpr, SysUtils, NFeDetalheVO, NFeCabecalhoVO, Generics.Collections,
  DB, NfeCupomFiscalVO;

type
  TNFeController = class
  protected
  public
    class function NfeSPED(pDataInicial, pDataFinal : String): TObjectList<TNfeCabecalhoVO>;
    class function NfeAnaliticoSPED(id : string): TObjectList<TNfeDetalheVO>;
    class function CupomNfeSPED(id : string): TObjectList<TNfeCupomFiscalVO>;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TNFeController.NfeSPED(pDataInicial, pDataFinal: String): TObjectList<TNfeCabecalhoVO>;
var
  ListaNfe: TObjectList<TNfeCabecalhoVO>;
  Nfe: TNfeCabecalhoVO;
  TotalRegistros: Integer;
  DataInicio, DataFim : String ;
begin
  DataInicio := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial)));
  DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal)));
  ConsultaSQL := 'select count(*) as total '+
                 ' from NFE_CABECALHO '+
                 ' where DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection :=  FDataModule.ConexaoBalcao;;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaNfe := TObjectList<TNfeCabecalhoVO>.Create;
        ConsultaSQL := ' select ' +
                       ' ID, ' +
                       ' NATUREZA_OPERACAO, ' +
                       ' TIPO_OPERACAO, ' +
                       ' ID_CLIENTE, ' +
                       ' CODIGO_MODELO, ' +
                       ' SITUACAO_NOTA, ' +
                       ' SERIE, '+
                       ' NUMERO, ' +
                       ' CHAVE_NFE, ' +
                       ' DATA_EMISSAO, ' +
                       ' DATA_ENTRADA_SAIDA, ' +
                       ' VALOR_TOTAL, ' +
                       ' INDICADOR_FORMA_PAGAMENTO, ' +
                       ' VALOR_DESCONTO, '+
                       ' VALOR_TOTAL_PRODUTOS, ' +
                       ' VALOR_FRETE, ' +
                       ' VALOR_SEGURO, ' +
                       ' VALOR_DESPESAS_ACESSORIAS, ' +
                       ' BASE_CALCULO_ICMS, '+
                       ' VALOR_ICMS, ' +
                       ' BASE_CALCULO_ICMS_ST, ' +
                       ' VALOR_ICMS_ST, ' +
                       ' VALOR_IPI, ' +
                       ' VALOR_PIS, ' +
                       ' VALOR_COFINS '+
                       'from ' +
                       ' NFE_CABECALHO '+
                       'where ' +
                       ' DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;

        while not Query.Eof do
        begin
          Nfe := TNfeCabecalhoVO.Create;
          Nfe.Id := Query.FieldByName('ID').AsInteger;
          Nfe.NaturezaOperacao := Query.FieldByName('NATUREZA_OPERACAO').AsString;
          Nfe.TipoOperacao := Query.FieldByName('TIPO_OPERACAO').AsString;
          Nfe.IdCliente := Query.FieldByName('ID_CLIENTE').AsInteger;
          Nfe.CodigoModelo := Query.FieldByName('CODIGO_MODELO').AsString;
          Nfe.SituacaoNota := Query.FieldByName('SITUACAO_NOTA').AsString;
          Nfe.Serie := Query.FieldByName('SERIE').AsString;
          Nfe.Numero := Query.FieldByName('NUMERO').AsString;
          Nfe.ChaveAcesso := Query.FieldByName('CHAVE_ACESSO').AsString;
          Nfe.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
          Nfe.DataEntradaSaida := Query.FieldByName('DATA_ENTRADA_SAIDA').AsString;
          Nfe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
          Nfe.IndicadorFormaPagamento := Query.FieldByName('INDICADOR_FORMA_PAGAMENTO').AsString;
          Nfe.ValorDesconto := Query.FieldByName('VALOR_DESCONTO').AsFloat;
          Nfe.ValorTotalProdutos := Query.FieldByName('VALOR_TOTAL_PRODUTOS').AsFloat;
          Nfe.ValorFrete := Query.FieldByName('VALOR_FRETE').AsFloat;
          Nfe.ValorSeguro := Query.FieldByName('VALOR_SEGURO').AsFloat;
          Nfe.ValorDespesasAcessorias := Query.FieldByName('VALOR_DESPESAS_ACESSORIAS').AsFloat;
          Nfe.BaseCalculoIcms := Query.FieldByName('BASE_CALCULO_ICMS').AsFloat;
          Nfe.ValorIcms := Query.FieldByName('VALOR_ICMS').AsFloat;
          Nfe.BaseCalculoIcmsSt := Query.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat;
          Nfe.ValorIcmsSt := Query.FieldByName('VALOR_ICMS_ST').AsFloat;
          Nfe.ValorIpi := Query.FieldByName('VALOR_IPI').AsFloat;
          Nfe.ValorPis := Query.FieldByName('VALOR_PIS').AsFloat;
          Nfe.ValorCofins := Query.FieldByName('VALOR_COFINS').AsFloat;
          ListaNfe.Add(Nfe);
          Query.next;
        end;//while not Query.Eof do
        result := ListaNfe;
      end;//if TotalRegistros > 0 then
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNFeController.NfeAnaliticoSPED(Id: string): TObjectList<TNfeDetalheVO>;
var
  ListaNfe: TObjectList<TNfeDetalheVO>;
  Nfe: TNfeDetalheVO;
  TotalRegistros: Integer;
  DataInicio, DataFim: String ;
begin
  ConsultaSQL := 'select count(*) as total '+
                 ' from nfe_detalhe '+
                 ' where ID_NFE_CABECALHO='+ID;
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaNfe := TObjectList<TNfeDetalheVO>.Create;
        ConsultaSQL := 'select '+
                       ' CST_A, '+
                       ' CFOP, '+
                       ' ALIQUOTA_ICMS, '+
                       ' sum(VALOR_TOTAL) as VALOR_TOTAL, '+
                       ' sum(BASE_CALCULO_ICMS) as BASE_CALCULO_ICMS, '+
                       '  sum(VALOR_ICMS) as VALOR_ICMS, '+
                       ' sum(BASE_CALCULO_ICMS_ST) as BASE_CALCULO_ICMS_ST, '+
                       ' sum(VALOR_IPI) as VALOR_IPI, '+
                       ' sum(VAL_NAO_TRIBUTADO_BASE_ICMS) as VAL_NAO_TRIBUTADO_BASE_ICMS '+
                       'from '+
                       ' nfe_detalhe '+
                       'where '+
                       ' ID_NFE_CABECALHO='+ID+
                       'group by '+
                       ' CST_A, CFOP, ALIQUOTA_ICMS';

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          Nfe := TNfeDetalheVO.Create;
          Nfe.CstA := Query.FieldByName('CST_A').AsString;
          Nfe.Cfop := Query.FieldByName('CFOP').AsInteger;
          Nfe.AliquotaIcms := Query.FieldByName('ALIQUOTA_ICMS').AsFloat;
          Nfe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
          Nfe.BaseCalculoIcms := Query.FieldByName('BASE_CALCULO_ICMS').AsFloat;
          Nfe.ValorIcms := Query.FieldByName('VALOR_ICMS').AsFloat;
          Nfe.BaseCalculoIcmsSt := Query.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat;
          Nfe.ValorIcmsSt := Query.FieldByName('ALIQUOTA_ICMS_ST').AsFloat;
          Nfe.ValNaoTributadoBaseIcms := Query.FieldByName('VAL_NAO_TRIBUTADO_BASE_ICMS').AsFloat;
          {TODO : verifica necessidade de criar esse campo [VL_RED_BC] )}
          Nfe.ValorIpi := Query.FieldByName('VALOR_IPI').AsFloat;
          ListaNfe.Add(Nfe);
          Query.next;
        end;//while not Query.Eof do
        result := ListaNfe;
      end;//if TotalRegistros > 0 then
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNFeController.CupomNfeSPED(Id: String): TObjectList<TNfeCupomFiscalVO>;
var
  ListaNfe: TObjectList<TNfeCupomFiscalVO>;
  Nfe: TNfeCupomFiscalVO;
  TotalRegistros: Integer;
  DataInicio, DataFim: String ;
begin
  ConsultaSQL := 'select count(*) as total '+
                 ' from nfe_cupom_fiscal '+
                 ' where ID_NFE_CABECALHO='+ID;

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaNfe := TObjectList<TNfeCupomFiscalVO>.Create;
        ConsultaSQL := 'select '+
                       ' modelo_documento_fiscal, '+
                       ' numero_serie_ecf, '+
                       ' numero_caixa, '+
                       ' coo, '+
                       ' data_emissao_cupom '+
                       ' from '+
                       ' nfe_detalhe '+
                       ' where '+
                       ' ID_NFE_CABECALHO='+ID;

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;

        while not Query.Eof do
        begin
          Nfe := TNfeCupomFiscalVO.Create;
          Nfe.ModeloDocumentoFiscal := Query.FieldByName('modelo_documento_fiscal').AsString;
          Nfe.NumeroSerieEcf := Query.FieldByName('numero_serie_ecf').AsString;
          Nfe.NumeroCaixa := Query.FieldByName('numero_caixa').AsInteger;
          Nfe.Coo := Query.FieldByName('coo').AsInteger;
          Nfe.DataEmissaoCupom := Query.FieldByName('data_emissao_cupom').AsString;
          ListaNfe.Add(Nfe);
          Query.next;
        end;
        result := ListaNfe;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
