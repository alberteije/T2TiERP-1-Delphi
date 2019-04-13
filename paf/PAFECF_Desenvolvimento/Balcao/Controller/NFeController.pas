{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da NFe para o sistema de balcão do PAF-ECF.

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
unit NFeController;

interface

uses
  Classes, SQLExpr, SysUtils, NFeDetalheVO, NFeCabecalhoVO, Generics.Collections,
  DB, Biblioteca;

type
  TNFeController = class
  protected
  public
    function InsereNFe(NFeCabecalho:TNFeCabecalhoVO; ListaNFeDetalhe:TObjectList<TNFeDetalheVO>): TNFeCabecalhoVO;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

function TNFeController.InsereNFe(NFeCabecalho:TNFeCabecalhoVO; ListaNFeDetalhe:TObjectList<TNFeDetalheVO>): TNFeCabecalhoVO;
var
  i: Integer;
begin
  ConsultaSQL :=
      'insert into NFE_CABECALHO ('+
        'ID_FUNCIONARIO, '+
        'ID_CLIENTE, '+
        'NATUREZA_OPERACAO, '+
        'INDICADOR_FORMA_PAGAMENTO, '+
        'CODIGO_MODELO, '+
        'SERIE, '+
        'DATA_EMISSAO, '+
        'DATA_ENTRADA_SAIDA, '+
        'HORA_ENTRADA_SAIDA, '+
        'TIPO_OPERACAO, '+
        'CODIGO_MUNICIPIO, '+
        'FORMATO_IMPRESSAO_DANFE, '+
        'TIPO_EMISSAO, '+
        'AMBIENTE, '+
        'FINALIDADE_EMISSAO, '+
        'PROCESSO_EMISSAO, '+
        'VERSAO_PROCESSO_EMISSAO, '+
        'BASE_CALCULO_ICMS, '+
        'VALOR_ICMS, '+
        'VALOR_TOTAL_PRODUTOS, '+
        'VALOR_DESCONTO, '+
        'VALOR_TOTAL) '+
      'values ('+
        ':pID_FUNCIONARIO, '+
        ':pID_CLIENTE, '+
        ':pNATUREZA_OPERACAO, '+
        ':pINDICADOR_FORMA_PAGAMENTO, '+
        ':pCODIGO_MODELO, '+
        ':pSERIE, '+
        ':pDATA_EMISSAO, '+
        ':pDATA_ENTRADA_SAIDA, '+
        ':pHORA_ENTRADA_SAIDA, '+
        ':pTIPO_OPERACAO, '+
        ':pCODIGO_MUNICIPIO, '+
        ':pFORMATO_IMPRESSAO_DANFE, '+
        ':pTIPO_EMISSAO, '+
        ':pAMBIENTE, '+
        ':pFINALIDADE_EMISSAO, '+
        ':pPROCESSO_EMISSAO, '+
        ':pVERSAO_PROCESSO_EMISSAO, '+
        ':pBASE_CALCULO_ICMS, '+
        ':pVALOR_ICMS, '+
        ':pVALOR_TOTAL_PRODUTOS, '+
        ':pVALOR_DESCONTO, '+
        ':pVALOR_TOTAL)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID_FUNCIONARIO').AsInteger := NFeCabecalho.IdFuncionario;
      Query.ParamByName('pID_CLIENTE').AsInteger := NFeCabecalho.IdCliente;
      Query.ParamByName('pNATUREZA_OPERACAO').AsString := NFeCabecalho.NaturezaOperacao;
      Query.ParamByName('pINDICADOR_FORMA_PAGAMENTO').AsString := NFeCabecalho.IndicadorFormaPagamento;
      Query.ParamByName('pCODIGO_MODELO').AsString := NFeCabecalho.CodigoModelo;
      Query.ParamByName('pSERIE').AsString := NFeCabecalho.Serie;
      Query.ParamByName('pDATA_EMISSAO').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(NFeCabecalho.DataEmissao));
      Query.ParamByName('pDATA_ENTRADA_SAIDA').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(NFeCabecalho.DataEntradaSaida));
      Query.ParamByName('pHORA_ENTRADA_SAIDA').AsString := NFeCabecalho.HoraEntradaSaida;
      Query.ParamByName('pTIPO_OPERACAO').AsString := NFeCabecalho.TipoOperacao;
      Query.ParamByName('pCODIGO_MUNICIPIO').AsInteger := NFeCabecalho.CodigoMunicipio;
      Query.ParamByName('pFORMATO_IMPRESSAO_DANFE').AsString := NFeCabecalho.FormatoImpressaoDanfe;
      Query.ParamByName('pTIPO_EMISSAO').AsString := NFeCabecalho.TipoEmissao;
      Query.ParamByName('pAMBIENTE').AsString := NFeCabecalho.Ambiente;
      Query.ParamByName('pFINALIDADE_EMISSAO').AsString := NFeCabecalho.FinalidadeEmissao;
      Query.ParamByName('pPROCESSO_EMISSAO').AsString := NFeCabecalho.ProcessoEmissao;
      Query.ParamByName('pVERSAO_PROCESSO_EMISSAO').AsInteger := NFeCabecalho.VersaoProcessoEmissao;
      Query.ParamByName('pBASE_CALCULO_ICMS').AsFloat := NFeCabecalho.BaseCalculoIcms;
      Query.ParamByName('pVALOR_ICMS').AsFloat := NFeCabecalho.ValorIcms;
      Query.ParamByName('pVALOR_TOTAL_PRODUTOS').AsFloat := NFeCabecalho.ValorTotalProdutos;
      Query.ParamByName('pVALOR_DESCONTO').AsFloat := NFeCabecalho.ValorDesconto;
      Query.ParamByName('pVALOR_TOTAL').AsFloat := NFeCabecalho.ValorTotal;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from NFE_CABECALHO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      NFeCabecalho.Id := Query.FieldByName('ID').AsInteger;
      NFeCabecalho.CodigoNumerico := StringOfChar('0',8-length(IntToStr(NFeCabecalho.Id))) + IntToStr(NFeCabecalho.Id);
      NFeCabecalho.Numero := StringOfChar('0',9-length(IntToStr(NFeCabecalho.Id))) + IntToStr(NFeCabecalho.Id);
      NFeCabecalho.ChaveAcesso := '53' + FormatDateTime('yy', StrToDate(NFeCabecalho.DataEmissao)) + FormatDateTime('mm', StrToDate(NFeCabecalho.DataEmissao)) + '10793118000178' + '55' + '000' + '1' + NFeCabecalho.Numero + NFeCabecalho.CodigoNumerico;
      NFeCabecalho.DigitoChaveAcesso := Modulo11(NFeCabecalho.ChaveAcesso);
      NFeCabecalho.ChaveAcesso := NFeCabecalho.ChaveAcesso + NFeCabecalho.DigitoChaveAcesso;

      ConsultaSQL :=
        'update NFE_CABECALHO set ' +
        'NUMERO=:pNUMERO, '+
        'CODIGO_NUMERICO=:pCODIGO_NUMERICO, '+
        'CHAVE_ACESSO=:pCHAVE_ACESSO, '+
        'DIGITO_CHAVE_ACESSO=:pDIGITO_CHAVE_ACESSO '+
        ' where ID = ' + IntToStr(NFeCabecalho.Id);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pNUMERO').AsString := NFeCabecalho.Numero;
      Query.ParamByName('pCODIGO_NUMERICO').AsString := NFeCabecalho.CodigoNumerico;
      Query.ParamByName('pCHAVE_ACESSO').AsString := NFeCabecalho.ChaveAcesso;
      Query.ParamByName('pDIGITO_CHAVE_ACESSO').AsString := NFeCabecalho.DigitoChaveAcesso;
      Query.ExecSQL();


      if NFeCabecalho.CupomVinculado then
      begin
        ConsultaSQL :=
        'insert into NFE_CUPOM_FISCAL ('+
          'ID_NFE_CABECALHO, '+
          'MODELO_DOCUMENTO_FISCAL, '+
          'DATA_EMISSAO_CUPOM, '+
          'NUMERO_ORDEM_ECF, '+
          'COO, '+
          'NUMERO_CAIXA, '+
          'NUMERO_SERIE_ECF) '+
        'values ('+
          ':pID_NFE_CABECALHO, '+
          ':pMODELO_DOCUMENTO_FISCAL, '+
          ':pDATA_EMISSAO_CUPOM, '+
          ':pNUMERO_ORDEM_ECF, '+
          ':pCOO, '+
          ':pNUMERO_CAIXA, '+
          ':pNUMERO_SERIE_ECF)';

        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pID_NFE_CABECALHO').AsInteger := NFeCabecalho.Id;
        Query.ParamByName('pMODELO_DOCUMENTO_FISCAL').AsString := NFeCabecalho.NfeCupomFiscalVO.ModeloDocumentoFiscal;
        Query.ParamByName('pDATA_EMISSAO_CUPOM').AsString := NFeCabecalho.NfeCupomFiscalVO.DataEmissaoCupom;
        Query.ParamByName('pNUMERO_ORDEM_ECF').AsInteger := NFeCabecalho.NfeCupomFiscalVO.NumeroOrdemEcf;
        Query.ParamByName('pCOO').AsInteger := NFeCabecalho.NfeCupomFiscalVO.Coo;
        Query.ParamByName('pNUMERO_CAIXA').AsInteger := NFeCabecalho.NfeCupomFiscalVO.NumeroCaixa;
        Query.ParamByName('pNUMERO_SERIE_ECF').AsString := NFeCabecalho.NfeCupomFiscalVO.NumeroSerieEcf;
        Query.ExecSQL();
      end;
    except
    end;
  finally
    Query.Free;
  end;

  //insere os dados na tabela de detalhes
  ConsultaSQL :=
    'insert into NFE_DETALHE ('+
      'ID_NFE_CABECALHO, '+
      'ID_PRODUTO, '+
      'NUMERO_ITEM, '+
      'GTIN, '+
      'CODIGO_PRODUTO, '+
      'NOME_PRODUTO, '+
      'NCM, '+
      'CFOP, '+
      'UNIDADE_COMERCIAL, '+
      'QUANTIDADE_COMERCIAL, '+
      'VALOR_UNITARIO_COMERCIAL, '+
      'GTIN_UNIDADE_TRIBUTAVEL, '+
      'UNIDADE_TRIBUTAVEL, '+
      'QUANTIDADE_TRIBUTAVEL, '+
      'VALOR_UNITARIO_TRIBUTACAO, '+
      'ORIGEM_MERCADORIA, '+
      'CST_ICMS, '+
      'CSOSN, '+
      'MODALIDADE_BC_ICMS, '+
      'ALIQUOTA_ICMS, '+
      'VALOR_ICMS, '+
      'VALOR_SUBTOTAL, '+
      'VALOR_TOTAL)'+
    'values ('+
      ':pID_NFE_CABECALHO, '+
      ':pID_PRODUTO, '+
      ':pNUMERO_ITEM, '+
      ':pGTIN, '+
      ':pCODIGO_PRODUTO, '+
      ':pNOME_PRODUTO, '+
      ':pNCM, '+
      ':pCFOP, '+
      ':pUNIDADE_COMERCIAL, '+
      ':pQUANTIDADE_COMERCIAL, '+
      ':pVALOR_UNITARIO_COMERCIAL, '+
      ':pGTIN_UNIDADE_TRIBUTAVEL, '+
      ':pUNIDADE_TRIBUTAVEL, '+
      ':pQUANTIDADE_TRIBUTAVEL, '+
      ':pVALOR_UNITARIO_TRIBUTACAO, '+
      ':pORIGEM_MERCADORIA, '+
      ':pCST_ICMS, '+
      ':pCSOSN, '+
      ':pMODALIDADE_BC_ICMS, '+
      ':pALIQUOTA_ICMS, '+
      ':pVALOR_ICMS, '+
      ':pVALOR_SUBTOTAL, '+
      ':pVALOR_TOTAL)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      for i := 0 to ListaNFeDetalhe.Count - 1 do
      begin
        Query.ParamByName('pID_NFE_CABECALHO').AsInteger := NFeCabecalho.Id;
        Query.ParamByName('pID_PRODUTO').AsInteger := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).IdProduto;
        Query.ParamByName('pNUMERO_ITEM').AsInteger := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).NumeroItem;
        Query.ParamByName('pGTIN').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).Gtin;
        Query.ParamByName('pCODIGO_PRODUTO').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).Gtin;
        Query.ParamByName('pNOME_PRODUTO').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).NomeProduto;
        Query.ParamByName('pNCM').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).Ncm;
        Query.ParamByName('pCFOP').AsInteger := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).Cfop;
        Query.ParamByName('pUNIDADE_COMERCIAL').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).UnidadeComercial;
        Query.ParamByName('pQUANTIDADE_COMERCIAL').AsFloat := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).QuantidadeComercial;
        Query.ParamByName('pVALOR_UNITARIO_COMERCIAL').AsFloat := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorUnitarioComercial;
        Query.ParamByName('pGTIN_UNIDADE_TRIBUTAVEL').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).GtinUnidadeTributavel;
        Query.ParamByName('pUNIDADE_TRIBUTAVEL').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).UnidadeTributavel;
        Query.ParamByName('pQUANTIDADE_TRIBUTAVEL').AsFloat := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).QuantidadeTributavel;
        Query.ParamByName('pVALOR_UNITARIO_TRIBUTACAO').AsFloat := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorUnitarioTributacao;
        Query.ParamByName('pORIGEM_MERCADORIA').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).OrigemMercadoria;
        Query.ParamByName('pCST_ICMS').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).CstIcms;
        Query.ParamByName('pCSOSN').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).Csosn;
        Query.ParamByName('pMODALIDADE_BC_ICMS').AsString := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ModalidadeBcIcms;
        Query.ParamByName('pALIQUOTA_ICMS').AsFloat := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).AliquotaIcms;
        Query.ParamByName('pVALOR_ICMS').AsFloat := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorIcms;
        Query.ParamByName('pVALOR_SUBTOTAL').AsFloat := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorSubtotal;
        Query.ParamByName('pVALOR_TOTAL').AsFloat := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorTotal;

        Query.ExecSQL();
      end;
    except
    end;
  finally
    Query.Free;
  end;

  result := NFeCabecalho;
end;


end.
