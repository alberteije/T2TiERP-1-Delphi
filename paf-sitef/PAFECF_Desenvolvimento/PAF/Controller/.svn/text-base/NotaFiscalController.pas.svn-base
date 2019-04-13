{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle das notas fiscais NFVC ou NF2.

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
unit NotaFiscalController;

interface

uses
  Classes, SQLExpr, SysUtils, NotaFiscalDetalheVO, NotaFiscalCabecalhoVO, Generics.Collections, DB, ProdutoVO;

type
  TNotaFiscalController = class
  private
  protected
  public
    class function TabelaNotaFiscalCabecalho(Nota: String): TNotaFiscalCabecalhoVO;
    class function TabelaNotaFiscalDetalhe(Id: Integer): TObjectList<TNotaFiscalDetalheVO>;
    class function InsereNotaFiscal(NotaFiscalCabecalho: TNotaFiscalCabecalhoVO; ListaNotaFiscalDetalhe: TObjectList<TNotaFiscalDetalheVO>): Integer;
    class function ConsultaNFCabecalhoSPED(DataInicio:String; DataFim:String): TObjectList<TNotaFiscalCabecalhoVO>;
    class function ConsultaNFDetalheSPED(Id: Integer): TObjectList<TNotaFiscalDetalheVO>;
    class function ConsultaNFCabecalhoCanceladasSPED(DataInicio:String; DataFim:String): TObjectList<TNotaFiscalCabecalhoVO>;
    class procedure ExcluiNotaFiscal(Nota: String);
  end;

implementation

uses UDataModule, ProdutoController, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TNotaFiscalController.TabelaNotaFiscalCabecalho(Nota: String): TNotaFiscalCabecalhoVO;
var
  NotaFiscalCabecalho: TNotaFiscalCabecalhoVO;
begin
  try
    try
      ConsultaSQL :=
        'select * from NOTA_FISCAL_CABECALHO where ' +
        'NUMERO =' + QuotedStr(Nota);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      NotaFiscalCabecalho := TNotaFiscalCabecalhoVO.Create;
      NotaFiscalCabecalho.Id := 0;
      if not Query.IsEmpty then
      begin
        NotaFiscalCabecalho.Id                          := Query.FieldByName('ID').AsInteger;
        NotaFiscalCabecalho.IdEcfFuncionario            := Query.FieldByName('ID_ECF_FUNCIONARIO').AsInteger;
        NotaFiscalCabecalho.IdCliente                   := Query.FieldByName('ID_CLIENTE').AsInteger;
        NotaFiscalCabecalho.Cfop                        := Query.FieldByName('CFOP').AsInteger;
        NotaFiscalCabecalho.Numero                      := Query.FieldByName('NUMERO').AsString;
        NotaFiscalCabecalho.DataEmissao                 := DataParaTexto(Query.FieldByName('DATA_EMISSAO').AsDateTime);
        NotaFiscalCabecalho.HoraEmissao                 := Query.FieldByName('HORA_EMISSAO').AsString;
        NotaFiscalCabecalho.Serie                       := Query.FieldByName('SERIE').AsString;
        NotaFiscalCabecalho.Subserie                    := Query.FieldByName('SUBSERIE').AsString;
        NotaFiscalCabecalho.TotalProdutos               := Query.FieldByName('TOTAL_PRODUTOS').AsFloat;
        NotaFiscalCabecalho.TotalNf                     := Query.FieldByName('TOTAL_NF').AsFloat;
        NotaFiscalCabecalho.BaseIcms                    := Query.FieldByName('BASE_ICMS').AsFloat;
        NotaFiscalCabecalho.Icms                        := Query.FieldByName('ICMS').AsFloat;
        NotaFiscalCabecalho.IcmsOutras                  := Query.FieldByName('ICMS_OUTRAS').AsFloat;
        NotaFiscalCabecalho.Issqn                       := Query.FieldByName('ISSQN').AsFloat;
        NotaFiscalCabecalho.Pis                         := Query.FieldByName('PIS').AsFloat;
        NotaFiscalCabecalho.Cofins                      := Query.FieldByName('COFINS').AsFloat;
        NotaFiscalCabecalho.Ipi                         := Query.FieldByName('IPI').AsFloat;
        NotaFiscalCabecalho.TaxaAcrescimo               := Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
        NotaFiscalCabecalho.Acrescimo                   := Query.FieldByName('ACRESCIMO').AsFloat;
        NotaFiscalCabecalho.AcrescimoItens              := Query.FieldByName('ACRESCIMO_ITENS').AsFloat;
        NotaFiscalCabecalho.TaxaDesconto                := Query.FieldByName('TAXA_DESCONTO').AsFloat;
        NotaFiscalCabecalho.Desconto                    := Query.FieldByName('DESCONTO').AsFloat;
        NotaFiscalCabecalho.DescontoItens               := Query.FieldByName('DESCONTO_ITENS').AsFloat;
        NotaFiscalCabecalho.Cancelada                   := Query.FieldByName('CANCELADA').AsString;
        NotaFiscalCabecalho.Sincronizado                := Query.FieldByName('SINCRONIZADO').AsString;
        NotaFiscalCabecalho.TipoNota                    := Query.FieldByName('TIPO_NOTA').AsString;
      end;
      result := NotaFiscalCabecalho;

    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNotaFiscalController.TabelaNotaFiscalDetalhe(Id: Integer): TObjectList<TNotaFiscalDetalheVO>;
var
  ListaNotaFiscalDetalhe: TObjectList<TNotaFiscalDetalheVO>;
  NotaFiscalDetalhe: TNotaFiscalDetalheVO;
  TotalRegistros: Integer;
begin
  ConsultaSQL := 'select count(*) AS TOTAL from NOTA_FISCAL_DETALHE where ID_NF_CABECALHO='+IntToStr(Id);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaNotaFiscalDetalhe := TObjectList<TNotaFiscalDetalheVO>.Create;

        ConsultaSQL := 'select * from NOTA_FISCAL_DETALHE where ID_NF_CABECALHO='+IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          NotaFiscalDetalhe := TNotaFiscalDetalheVO.Create;

          NotaFiscalDetalhe.Id := Query.FieldByName('ID').AsInteger;
          NotaFiscalDetalhe.IdNfCabecalho := Query.FieldByName('ID_NF_CABECALHO').AsInteger;
          NotaFiscalDetalhe.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
          NotaFiscalDetalhe.Cfop := Query.FieldByName('CFOP').AsInteger;
          NotaFiscalDetalhe.Item := Query.FieldByName('ITEM').AsInteger;
          NotaFiscalDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsFloat;
          NotaFiscalDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
          NotaFiscalDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
          NotaFiscalDetalhe.BaseIcms := Query.FieldByName('BASE_ICMS').AsFloat;
          NotaFiscalDetalhe.TaxaIcms := Query.FieldByName('TAXA_ICMS').AsFloat;
          NotaFiscalDetalhe.Icms := Query.FieldByName('ICMS').AsFloat;
          NotaFiscalDetalhe.IcmsOutras := Query.FieldByName('ICMS_OUTRAS').AsFloat;
          NotaFiscalDetalhe.IcmsIsento := Query.FieldByName('ICMS_ISENTO').AsFloat;
          NotaFiscalDetalhe.TaxaDesconto := Query.FieldByName('TAXA_DESCONTO').AsFloat;
          NotaFiscalDetalhe.Desconto := Query.FieldByName('DESCONTO').AsFloat;
          NotaFiscalDetalhe.TaxaIssqn := Query.FieldByName('TAXA_ISSQN').AsFloat;
          NotaFiscalDetalhe.Issqn := Query.FieldByName('ISSQN').AsFloat;
          NotaFiscalDetalhe.TaxaPis := Query.FieldByName('TAXA_PIS').AsFloat;
          NotaFiscalDetalhe.Pis := Query.FieldByName('PIS').AsFloat;
          NotaFiscalDetalhe.TaxaCofins := Query.FieldByName('TAXA_COFINS').AsFloat;
          NotaFiscalDetalhe.Cofins := Query.FieldByName('COFINS').AsFloat;
          NotaFiscalDetalhe.TaxaAcrescimo := Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
          NotaFiscalDetalhe.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
          NotaFiscalDetalhe.TaxaIpi := Query.FieldByName('TAXA_IPI').AsFloat;
          NotaFiscalDetalhe.Ipi := Query.FieldByName('IPI').AsFloat;
          NotaFiscalDetalhe.Cancelado := Query.FieldByName('CANCELADO').AsString;
          NotaFiscalDetalhe.Cst := Query.FieldByName('CST').AsString;
          NotaFiscalDetalhe.MovimentaEstoque := Query.FieldByName('MOVIMENTA_ESTOQUE').AsString;
          NotaFiscalDetalhe.Sincronizado := Query.FieldByName('SINCRONIZADO').AsString;

          ListaNotaFiscalDetalhe.Add(NotaFiscalDetalhe);

          Query.next;
        end;
        result := ListaNotaFiscalDetalhe;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNotaFiscalController.InsereNotaFiscal(NotaFiscalCabecalho: TNotaFiscalCabecalhoVO; ListaNotaFiscalDetalhe: TObjectList<TNotaFiscalDetalheVO>): Integer;
var
  i: Integer;
begin
  ExcluiNotaFiscal(NotaFiscalCabecalho.Numero);

  ConsultaSQL :=
      'insert into NOTA_FISCAL_CABECALHO ('+
        'ID_ECF_FUNCIONARIO, '+
        'ID_CLIENTE, '+
        'CFOP, '+
        'NUMERO, '+
        'DATA_EMISSAO, '+
        'HORA_EMISSAO, '+
        'SERIE, '+
        'SUBSERIE, '+
        'TOTAL_PRODUTOS, '+
        'TOTAL_NF, '+
        'BASE_ICMS, '+
        'ICMS, '+
        'ICMS_OUTRAS, '+
        'ISSQN, '+
        'PIS, '+
        'COFINS, '+
        'IPI, '+
        'TAXA_ACRESCIMO, '+
        'ACRESCIMO, '+
        'ACRESCIMO_ITENS, '+
        'TAXA_DESCONTO, '+
        'DESCONTO, '+
        'DESCONTO_ITENS, '+
        'CANCELADA, '+
        'TIPO_NOTA) '+
      'values ('+
        ':pID_ECF_FUNCIONARIO, '+
        ':pID_CLIENTE, '+
        ':pCFOP, '+
        ':pNUMERO, '+
        ':pDATA_EMISSAO, '+
        ':pHORA_EMISSAO, '+
        ':pSERIE, '+
        ':pSUBSERIE, '+
        ':pTOTAL_PRODUTOS, '+
        ':pTOTAL_NF, '+
        ':pBASE_ICMS, '+
        ':pICMS, '+
        ':pICMS_OUTRAS, '+
        ':pISSQN, '+
        ':pPIS, '+
        ':pCOFINS, '+
        ':pIPI, '+
        ':pTAXA_ACRESCIMO, '+
        ':pACRESCIMO, '+
        ':pACRESCIMO_ITENS, '+
        ':pTAXA_DESCONTO, '+
        ':pDESCONTO, '+
        ':pDESCONTO_ITENS, '+
        ':pCANCELADA, '+
        ':pTIPO_NOTA) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID_ECF_FUNCIONARIO').AsInteger := NotaFiscalCabecalho.IdEcfFuncionario;
      Query.ParamByName('pID_CLIENTE').AsInteger := NotaFiscalCabecalho.IdCliente;
      Query.ParamByName('pCFOP').AsInteger := NotaFiscalCabecalho.Cfop;
      Query.ParamByName('pNUMERO').AsString := NotaFiscalCabecalho.Numero;
      Query.ParamByName('pDATA_EMISSAO').AsString := FormatDateTime('yyyy-mm-dd', now);
      Query.ParamByName('pHORA_EMISSAO').AsString := FormatDateTime('hh:nn:ss', now);
      Query.ParamByName('pSERIE').AsString := NotaFiscalCabecalho.Serie;
      Query.ParamByName('pSUBSERIE').AsString := NotaFiscalCabecalho.Subserie;
      Query.ParamByName('pTOTAL_PRODUTOS').AsFloat := NotaFiscalCabecalho.TotalProdutos;
      Query.ParamByName('pTOTAL_NF').AsFloat := NotaFiscalCabecalho.TotalNf;
      Query.ParamByName('pBASE_ICMS').AsFloat := NotaFiscalCabecalho.BaseIcms;
      Query.ParamByName('pICMS').AsFloat := NotaFiscalCabecalho.Icms;
      Query.ParamByName('pICMS_OUTRAS').AsFloat := NotaFiscalCabecalho.IcmsOutras;
      Query.ParamByName('pISSQN').AsFloat := NotaFiscalCabecalho.Issqn;
      Query.ParamByName('pPIS').AsFloat := NotaFiscalCabecalho.Pis;
      Query.ParamByName('pCOFINS').AsFloat := NotaFiscalCabecalho.Cofins;
      Query.ParamByName('pIPI').AsFloat := NotaFiscalCabecalho.Ipi;
      Query.ParamByName('pTAXA_ACRESCIMO').AsFloat := NotaFiscalCabecalho.TaxaAcrescimo;
      Query.ParamByName('pACRESCIMO').AsFloat := NotaFiscalCabecalho.Acrescimo;
      Query.ParamByName('pACRESCIMO_ITENS').AsFloat := NotaFiscalCabecalho.AcrescimoItens;
      Query.ParamByName('pTAXA_DESCONTO').AsFloat := NotaFiscalCabecalho.TaxaDesconto;
      Query.ParamByName('pDESCONTO').AsFloat := NotaFiscalCabecalho.Desconto;
      Query.ParamByName('pDESCONTO_ITENS').AsFloat := NotaFiscalCabecalho.DescontoItens;
      Query.ParamByName('pCANCELADA').AsString := NotaFiscalCabecalho.Cancelada;
      Query.ParamByName('pTIPO_NOTA').AsString := NotaFiscalCabecalho.TipoNota;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from NOTA_FISCAL_CABECALHO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      NotaFiscalCabecalho.Id := Query.FieldByName('ID').AsInteger;
    except
    end;
  finally
    Query.Free;
  end;

  ConsultaSQL :=
    'insert into NOTA_FISCAL_DETALHE ('+
      'ID_NF_CABECALHO, '+
      'ID_PRODUTO, '+
      'CFOP, '+
      'ITEM, '+
      'QUANTIDADE, '+
      'VALOR_UNITARIO, '+
      'VALOR_TOTAL, '+
      'BASE_ICMS, '+
      'TAXA_ICMS, '+
      'ICMS, '+
      'ICMS_OUTRAS, '+
      'ICMS_ISENTO, '+
      'TAXA_DESCONTO, '+
      'DESCONTO, '+
      'TAXA_ISSQN, '+
      'ISSQN, '+
      'TAXA_PIS, '+
      'PIS, '+
      'TAXA_COFINS, '+
      'COFINS, '+
      'TAXA_ACRESCIMO, '+
      'ACRESCIMO, '+
      'TAXA_IPI, '+
      'IPI, '+
      'CANCELADO, '+
      'CST, '+
      'ECF_ICMS_ST,'+
      'MOVIMENTA_ESTOQUE) '+
    'values ('+
      ':pID_NF_CABECALHO, '+
      ':pID_PRODUTO, '+
      ':pCFOP, '+
      ':pITEM, '+
      ':pQUANTIDADE, '+
      ':pVALOR_UNITARIO, '+
      ':pVALOR_TOTAL, '+
      ':pBASE_ICMS, '+
      ':pTAXA_ICMS, '+
      ':pICMS, '+
      ':pICMS_OUTRAS, '+
      ':pICMS_ISENTO, '+
      ':pTAXA_DESCONTO, '+
      ':pDESCONTO, '+
      ':pTAXA_ISSQN, '+
      ':pISSQN, '+
      ':pTAXA_PIS, '+
      ':pPIS, '+
      ':pTAXA_COFINS, '+
      ':pCOFINS, '+
      ':pTAXA_ACRESCIMO, '+
      ':pACRESCIMO, '+
      ':pTAXA_IPI, '+
      ':pIPI, '+
      ':pCANCELADO, '+
      ':pCST, '+
      ':pECFIcmsST, '+
      ':pMOVIMENTA_ESTOQUE)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      for i := 0 to ListaNotaFiscalDetalhe.Count - 1 do
      begin
        Query.ParamByName('pID_NF_CABECALHO').AsInteger := NotaFiscalCabecalho.Id;
        Query.ParamByName('pID_PRODUTO').AsInteger := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).IdProduto;
        Query.ParamByName('pCFOP').AsInteger :=  TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Cfop;
        Query.ParamByName('pITEM').AsInteger := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Item;
        Query.ParamByName('pQUANTIDADE').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Quantidade;
        Query.ParamByName('pVALOR_UNITARIO').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).ValorUnitario;
        Query.ParamByName('pVALOR_TOTAL').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).ValorTotal;
        Query.ParamByName('pBASE_ICMS').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).BaseIcms;
        Query.ParamByName('pTAXA_ICMS').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TaxaIcms;
        Query.ParamByName('pICMS').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Icms;
        Query.ParamByName('pICMS_OUTRAS').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).IcmsOutras;
        Query.ParamByName('pICMS_ISENTO').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).IcmsIsento;
        Query.ParamByName('pTAXA_DESCONTO').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TaxaDesconto;
        Query.ParamByName('pDESCONTO').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Desconto;
        Query.ParamByName('pTAXA_ISSQN').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TaxaIssqn;
        Query.ParamByName('pISSQN').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Issqn;
        Query.ParamByName('pTAXA_PIS').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TaxaPis;
        Query.ParamByName('pPIS').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Pis;
        Query.ParamByName('pTAXA_COFINS').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TaxaCofins;
        Query.ParamByName('pCOFINS').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Cofins;
        Query.ParamByName('pTAXA_ACRESCIMO').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TaxaAcrescimo;
        Query.ParamByName('pACRESCIMO').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Acrescimo;
        Query.ParamByName('pTAXA_IPI').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TaxaIpi;
        Query.ParamByName('pIPI').AsFloat := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Ipi;
        Query.ParamByName('pCANCELADO').AsString := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Cancelado;
        Query.ParamByName('pCST').AsString := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).Cst;
        Query.ParamByName('pMOVIMENTA_ESTOQUE').AsString := TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).MovimentaEstoque;

        if TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TotalizadorParcial = 'N1' then
          Query.ParamByName('pECFIcmsST').AsString := 'N'
        else if TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TotalizadorParcial = 'F1' then
          Query.ParamByName('pECFIcmsST').AsString := 'F'
        else if TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TotalizadorParcial = 'I1' then
          Query.ParamByName('pECFIcmsST').AsString := 'I'
        else
        begin
          if copy(TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TotalizadorParcial,3,1) = 'S' then
             Query.ParamByName('pECFIcmsST').AsString := copy(TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TotalizadorParcial,4,4)
          else
          if copy(TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TotalizadorParcial,3,1) = 'T' then
             Query.ParamByName('pECFIcmsST').AsString := copy(TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TotalizadorParcial,4,4)
          else
          if TNotaFiscalDetalheVO(ListaNotaFiscalDetalhe.Items[i]).TotalizadorParcial = 'Can-T' then
             Query.ParamByName('pECFIcmsST').AsString := 'CANC';
        end;

        Query.ExecSQL();
      end;
    except
    end;
  finally
    Query.Free;
  end;

  result := NotaFiscalCabecalho.Id;
end;

class function TNotaFiscalController.ConsultaNFCabecalhoSPED(DataInicio, DataFim: String): TObjectList<TNotaFiscalCabecalhoVO>;
var
  ListaNFCabecalho: TObjectList<TNotaFiscalCabecalhoVO>;
  NFCabecalho: TNotaFiscalCabecalhoVO;
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));
  ConsultaSQL := 'select count(*) AS TOTAL from NOTA_FISCAL_CABECALHO, CLIENTE where ' +
                  'NOTA_FISCAL_CABECALHO.ID_CLIENTE = CLIENTE.ID and ' +
                  '(DATA_EMISSAO between ' +
                  QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';;
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
      ConsultaSQL :=   ' SELECT (SELECT g.numero FROM NOTA_FISCAL_CABECALHO g WHERE g.id IN (SELECT MIN(b.id) FROM NOTA_FISCAL_CABECALHO b WHERE '+
   ' (b.DATA_EMISSAO BETWEEN '+QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim)+'))) AS minimo, '+
   ' (SELECT F.NUMERO FROM NOTA_FISCAL_CABECALHO F WHERE F.ID IN  (SELECT MAX(s.ID)  FROM NOTA_FISCAL_CABECALHO s '+
   ' WHERE (s.DATA_EMISSAO BETWEEN '+QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim)+'))) AS MAXIMO, N.*, C.* FROM NOTA_FISCAL_CABECALHO N, CLIENTE C WHERE '+
   ' N.ID_CLIENTE = C.ID AND (n.DATA_EMISSAO BETWEEN '+QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim)+')';



      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaNFCabecalho := TObjectList<TNotaFiscalCabecalhoVO>.Create;

      Query.First;
      while not Query.Eof do
      begin
        NFCabecalho := TNotaFiscalCabecalhoVO.Create;
        NFCabecalho.Id := Query.FieldByName('ID').AsInteger;
        NFCabecalho.IdEcfFuncionario := Query.FieldByName('ID_ECF_FUNCIONARIO').AsInteger;
        NFCabecalho.IdCliente := Query.FieldByName('ID_CLIENTE').AsInteger;
        NFCabecalho.CFOP := Query.FieldByName('CFOP').AsInteger;
        NFCabecalho.Numero := Query.FieldByName('NUMERO').AsString;
        NFCabecalho.NumOrdemInicial := Query.FieldByName('MINIMO').AsInteger;
        NFCabecalho.NumOrdemFinal := Query.FieldByName('MAXIMO').AsInteger;
        NFCabecalho.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
        NFCabecalho.HoraEmissao := Query.FieldByName('HORA_EMISSAO').AsString;
        NFCabecalho.Serie := Query.FieldByName('SERIE').AsString;
        NFCabecalho.SubSerie := Query.FieldByName('SUBSERIE').AsString;
        NFCabecalho.TotalProdutos := Query.FieldByName('TOTAL_PRODUTOS').AsFloat;
        NFCabecalho.TotalNF := Query.FieldByName('TOTAL_NF').AsFloat;
        NFCabecalho.BaseICMS := Query.FieldByName('BASE_ICMS').AsFloat;
        NFCabecalho.ICMS := Query.FieldByName('ICMS').AsFloat;
        NFCabecalho.ICMSOutras := Query.FieldByName('ICMS_OUTRAS').AsFloat;
        NFCabecalho.ISSQN := Query.FieldByName('ISSQN').AsFloat;
        NFCabecalho.PIS := Query.FieldByName('PIS').AsFloat;
        NFCabecalho.COFINS := Query.FieldByName('COFINS').AsFloat;
        NFCabecalho.IPI := Query.FieldByName('IPI').AsFloat;
        NFCabecalho.TaxaAcrescimo := Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
        NFCabecalho.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
        NFCabecalho.AcrescimoItens := Query.FieldByName('ACRESCIMO_ITENS').AsFloat;
        NFCabecalho.TaxaDesconto := Query.FieldByName('TAXA_DESCONTO').AsFloat;
        NFCabecalho.Desconto := Query.FieldByName('DESCONTO').AsFloat;
        NFCabecalho.DescontoItens := Query.FieldByName('DESCONTO_ITENS').AsFloat;
        NFCabecalho.Cancelada := Query.FieldByName('CANCELADA').AsString;
        NFCabecalho.CpfCnpjCliente := Query.FieldByName('CPF_CNPJ').AsString;
        ListaNFCabecalho.Add(NFCabecalho);
        Query.next;
      end;
      result := ListaNFCabecalho;
      end
     else
       begin
         result := nil;
       end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNotaFiscalController.ConsultaNFDetalheSPED(Id: Integer): TObjectList<TNotaFiscalDetalheVO>;
var
  ListaNFDetalhe: TObjectList<TNotaFiscalDetalheVO>;
  NFDetalhe: TNotaFiscalDetalheVO;
  TotalRegistros: Integer;
  Produto: TProdutoVO;
begin
  ConsultaSQL := 'select count(*) AS TOTAL from NOTA_FISCAL_DETALHE where ID='+IntToStr(Id);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaNFDetalhe := TObjectList<TNotaFiscalDetalheVO>.Create;

        ConsultaSQL := 'select * from NOTA_FISCAL_DETALHE where ID='+IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          Produto := TProdutoController.ConsultaId(Query.FieldByName('ID_PRODUTO').AsInteger);
          NFDetalhe := TNotaFiscalDetalheVO.Create;
          NFDetalhe.Id := Query.FieldByName('ID').AsInteger;
          NFDetalhe.IdNFCabecalho := Query.FieldByName('ID_NF_CABECALHO').AsInteger;
          NFDetalhe.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
          NFDetalhe.CFOP := Query.FieldByName('CFOP').AsInteger;
          NFDetalhe.Item := Query.FieldByName('ITEM').AsInteger;
          NFDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsFloat;
          NFDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
          NFDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
          NFDetalhe.BaseICMS := Query.FieldByName('BASE_ICMS').AsFloat;
          NFDetalhe.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
          NFDetalhe.ICMS := Query.FieldByName('ICMS').AsFloat;
          NFDetalhe.ICMSOutras := Query.FieldByName('ICMS_OUTRAS').AsFloat;
          NFDetalhe.ICMSIsento := Query.FieldByName('ICMS_ISENTO').AsFloat;
          NFDetalhe.TaxaDesconto := Query.FieldByName('TAXA_DESCONTO').AsFloat;
          NFDetalhe.Desconto := Query.FieldByName('DESCONTO').AsFloat;
          NFDetalhe.TaxaISSQN := Query.FieldByName('TAXA_ISSQN').AsFloat;
          NFDetalhe.ISSQN := Query.FieldByName('ISSQN').AsFloat;
          NFDetalhe.TaxaPIS := Query.FieldByName('TAXA_PIS').AsFloat;
          NFDetalhe.PIS := Query.FieldByName('PIS').AsFloat;
          NFDetalhe.TaxaCOFINS := Query.FieldByName('TAXA_COFINS').AsFloat;
          NFDetalhe.COFINS := Query.FieldByName('COFINS').AsFloat;
          NFDetalhe.TaxaAcrescimo := Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
          NFDetalhe.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
          NFDetalhe.TaxaIPI := Query.FieldByName('TAXA_IPI').AsFloat;
          NFDetalhe.IPI := Query.FieldByName('IPI').AsFloat;
          NFDetalhe.Cancelado := Query.FieldByName('CANCELADO').AsString;
          NFDetalhe.Cst := Query.FieldByName('CST').AsString;
          NFDetalhe.MovimentaEstoque := Query.FieldByName('MOVIMENTA_ESTOQUE').AsString;
          NFDetalhe.DescricaoUnidade := Produto.UnidadeProduto;
          ListaNFDetalhe.Add(NFDetalhe);
          Query.next;
        end;
        result := ListaNFDetalhe;
      end
      // caso não exista a relacao, retorna um ponteiro nulo
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNotaFiscalController.ConsultaNFCabecalhoCanceladasSPED(DataInicio, DataFim: String): TObjectList<TNotaFiscalCabecalhoVO>;
var
  ListaNFCabecalho: TObjectList<TNotaFiscalCabecalhoVO>;
  NFCabecalho: TNotaFiscalCabecalhoVO;
  TotalRegistros : Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));
  ConsultaSQL := 'select count(*) AS TOTAL from NOTA_FISCAL_CABECALHO, CLIENTE where ' +
        'NOTA_FISCAL_CABECALHO.ID_CLIENTE = CLIENTE.ID and CANCELADA=' + QuotedStr('S') + ' and ' +
        '(DATA_EMISSAO between ' +
        QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
      ConsultaSQL :=
        'select * from NOTA_FISCAL_CABECALHO, CLIENTE where ' +
        'NOTA_FISCAL_CABECALHO.ID_CLIENTE = CLIENTE.ID and CANCELADA=' + QuotedStr('S') + ' and ' +
        '(DATA_EMISSAO between ' +
        QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaNFCabecalho := TObjectList<TNotaFiscalCabecalhoVO>.Create;

      Query.First;
      while not Query.Eof do
      begin
        NFCabecalho := TNotaFiscalCabecalhoVO.Create;
        NFCabecalho.Id := Query.FieldByName('ID').AsInteger;
        NFCabecalho.IdEcfFuncionario := Query.FieldByName('ID_ECF_FUNCIONARIO').AsInteger;
        NFCabecalho.IdCliente := Query.FieldByName('ID_CLIENTE').AsInteger;
        NFCabecalho.CFOP := Query.FieldByName('CFOP').AsInteger;
        NFCabecalho.Numero := Query.FieldByName('NUMERO').AsString;
        NFCabecalho.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
        NFCabecalho.HoraEmissao := Query.FieldByName('HORA_EMISSAO').AsString;
        NFCabecalho.Serie := Query.FieldByName('SERIE').AsString;
        NFCabecalho.SubSerie := Query.FieldByName('SUBSERIE').AsString;
        NFCabecalho.TotalProdutos := Query.FieldByName('TOTAL_PRODUTOS').AsFloat;
        NFCabecalho.TotalNF := Query.FieldByName('TOTAL_NF').AsFloat;
        NFCabecalho.BaseICMS := Query.FieldByName('BASE_ICMS').AsFloat;
        NFCabecalho.ICMS := Query.FieldByName('ICMS').AsFloat;
        NFCabecalho.ICMSOutras := Query.FieldByName('ICMS_OUTRAS').AsFloat;
        NFCabecalho.ISSQN := Query.FieldByName('ISSQN').AsFloat;
        NFCabecalho.PIS := Query.FieldByName('PIS').AsFloat;
        NFCabecalho.COFINS := Query.FieldByName('COFINS').AsFloat;
        NFCabecalho.IPI := Query.FieldByName('IPI').AsFloat;
        NFCabecalho.TaxaAcrescimo := Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
        NFCabecalho.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
        NFCabecalho.AcrescimoItens := Query.FieldByName('ACRESCIMO_ITENS').AsFloat;
        NFCabecalho.TaxaDesconto := Query.FieldByName('TAXA_DESCONTO').AsFloat;
        NFCabecalho.Desconto := Query.FieldByName('DESCONTO').AsFloat;
        NFCabecalho.DescontoItens := Query.FieldByName('DESCONTO_ITENS').AsFloat;
        NFCabecalho.Cancelada := Query.FieldByName('CANCELADA').AsString;
        NFCabecalho.CpfCnpjCliente := Query.FieldByName('CPF_CNPJ').AsString;
        ListaNFCabecalho.Add(NFCabecalho);
        Query.next;
      end;
      result := ListaNFCabecalho;
      end
      else
        begin
           result := nil;
        end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class procedure TNotaFiscalController.ExcluiNotaFiscal(Nota: String);
var
  NotaFiscalCabecalho: TNotaFiscalCabecalhoVO;
begin

  NotaFiscalCabecalho := TabelaNotaFiscalCabecalho(nota);
  if NotaFiscalCabecalho.Id > 0 then
  begin

    ConsultaSQL := 'delete from NOTA_FISCAL_DETALHE '+
                   ' where (ID_NF_CABECALHO = :pID)';
    try
      try
        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pID').AsInteger := NotaFiscalCabecalho.Id;
        Query.ExecSQL();
      except
        //
      end;
    finally
      Query.Free;
    end;

    ConsultaSQL := 'delete from NOTA_FISCAL_CABECALHO '+
                   ' where (ID = :pID) ';
    try
      try
        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pID').AsInteger := NotaFiscalCabecalho.Id;
        Query.ExecSQL();
      except
        //
      end;
    finally
      Query.Free;
    end;
  end;
end;

end.
