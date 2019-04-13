{*******************************************************************************
Title: T2Ti ERP
Description:  VO  relacionado à tabela [NfeDetalhe]

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

@author  ()
@version 1.0
*******************************************************************************}
unit NfeDetalheVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('NFE_DETALHE')]
  TNfeDetalheVO = class
  private
    FID: Integer;
    FID_PRODUTO: Integer;
    FID_NFE_CABECALHO: Integer;
    FNUMERO_ITEM: Integer;
    FCODIGO_PRODUTO: String;
    FGTIN: String;
    FNOME_PRODUTO: String;
    FNCM: String;
    FEX_TIPI: Integer;
    FCFOP: Integer;
    FUNIDADE_COMERCIAL: String;
    FQUANTIDADE_COMERCIAL: Double;
    FVALOR_UNITARIO_COMERCIAL: Double;
    FVALOR_BRUTO_PRODUTOS: Double;
    FGTIN_UNIDADE_TRIBUTAVEL: String;
    FUNIDADE_TRIBUTAVEL: String;
    FQUANTIDADE_TRIBUTAVEL: Double;
    FVALOR_UNITARIO_TRIBUTACAO: Double;
    FVALOR_FRETE: Double;
    FVALOR_SEGURO: Double;
    FVALOR_DESCONTO: Double;
    FVALOR_OUTRAS_DESPESAS: Double;
    FENTRA_TOTAL: String;
    FORIGEM_MERCADORIA: String;
    FCST_ICMS: String;
    FCSOSN: String;
    FMODALIDADE_BC_ICMS: String;
    FTAXA_REDUCAO_BC_ICMS: Double;
    FBASE_CALCULO_ICMS: Double;
    FALIQUOTA_ICMS: Double;
    FVALOR_ICMS: Double;
    FMOTIVO_DESONERACAO_ICMS: String;
    FMODALIDE_BC_ICMS_ST: String;
    FPERCENTUAL_MVA_ICMS_ST: Double;
    FREDUCAO_BC_ICMS_ST: Double;
    FBASE_CALCULO_ICMS_ST: Double;
    FALIQUOTA_ICMS_ST: Double;
    FVALOR_ICMS_ST: Double;
    FVALOR_BC_ICMS_ST_RETIDO: Double;
    FVALOR_ICMS_ST_RETIDO: Double;
    FALIQUOTA_CREDITO_ICMS_SN: Double;
    FVALOR_CREDITO_ICMS_SN: Double;
    FENQUADRAMENTO_IPI: String;
    FCNPJ_PRODUTOR: String;
    FCODIGO_SELO_IPI: String;
    FQUANTIDADE_SELO_IPI: Integer;
    FENQUADRAMENTO_LEGAL_IPI: String;
    FCST_IPI: String;
    FBASE_CALCULO_IPI: Double;
    FALIQUOTA_IPI: Double;
    FVALOR_IPI: Double;
    FVALOR_BC_II: Double;
    FVALOR_DESPESAS_ADUANEIRAS: Double;
    FVALOR_IMPOSTO_IMPORTACAO: Double;
    FVALOR_IOF: Double;
    FCTS_PIS: String;
    FVALOR_BASE_CALCULO_PIS: Double;
    FALIQUOTA_PIS_PERCENTUAL: Double;
    FALIQUOTA_PIS_REAIS: Double;
    FVALOR_PIS: Double;
    FCST_COFINS: String;
    FBASE_CALCULO_COFINS: Double;
    FALIQUOTA_COFINS_PERCENTUAL: Double;
    FALIQUOTA_COFINS_REAIS: Double;
    FVALOR_COFINS: Double;
    FBASE_CALCULO_ISSQN: Double;
    FALIQUOTA_ISSQN: Double;
    FVALOR_ISSQN: Double;
    FMUNICIPIO_ISSQN: Integer;
    FITEM_LISTA_SERVICOS: Integer;
    FTRIBUTACAO_ISSQN: String;
    FVALOR_SUBTOTAL: Double;
    FVALOR_TOTAL: Double;
    FINFORMACOES_ADICIONAIS: String;

  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_PRODUTO','Id Produto',ldGridLookup ,8)]
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    [TColumn('ID_NFE_CABECALHO','Id Nfe Cabecalho',ldGridLookup ,8)]
    property IdNfeCabecalho: Integer  read FID_NFE_CABECALHO write FID_NFE_CABECALHO;
    [TColumn('NUMERO_ITEM','Numero Item',ldGridLookup ,8)]
    property NumeroItem: Integer  read FNUMERO_ITEM write FNUMERO_ITEM;
    [TColumn('CODIGO_PRODUTO','Codigo Produto',ldGridLookup ,8)]
    property CodigoProduto: String  read FCODIGO_PRODUTO write FCODIGO_PRODUTO;
    [TColumn('GTIN','Gtin',ldGridLookup ,14)]
    property Gtin: String  read FGTIN write FGTIN;
    [TColumn('NOME_PRODUTO','Nome Produto',ldGridLookup ,100)]
    property NomeProduto: String  read FNOME_PRODUTO write FNOME_PRODUTO;
    [TColumn('NCM','Ncm',ldGridLookup ,8)]
    property Ncm: String  read FNCM write FNCM;
    [TColumn('EX_TIPI','Ex Tipi',ldGridLookup ,8)]
    property ExTipi: Integer  read FEX_TIPI write FEX_TIPI;
    [TColumn('CFOP','Cfop',ldGridLookup ,8)]
    property Cfop: Integer  read FCFOP write FCFOP;
    [TColumn('UNIDADE_COMERCIAL','Unidade Comercial',ldGridLookup ,6)]
    property UnidadeComercial: String  read FUNIDADE_COMERCIAL write FUNIDADE_COMERCIAL;
    [TColumn('QUANTIDADE_COMERCIAL','Quantidade Comercial',ldGridLookup ,10)]
    property QuantidadeComercial: Double  read FQUANTIDADE_COMERCIAL write FQUANTIDADE_COMERCIAL;
    [TColumn('VALOR_UNITARIO_COMERCIAL','Valor Unitario Comercial',ldGridLookup ,10)]
    property ValorUnitarioComercial: Double  read FVALOR_UNITARIO_COMERCIAL write FVALOR_UNITARIO_COMERCIAL;
    [TColumn('VALOR_BRUTO_PRODUTOS','Valor Bruto Produtos',ldGridLookup ,10)]
    property ValorBrutoProdutos: Double  read FVALOR_BRUTO_PRODUTOS write FVALOR_BRUTO_PRODUTOS;
    [TColumn('GTIN_UNIDADE_TRIBUTAVEL','Gtin Unidade Tributavel',ldGridLookup ,14)]
    property GtinUnidadeTributavel: String  read FGTIN_UNIDADE_TRIBUTAVEL write FGTIN_UNIDADE_TRIBUTAVEL;
    [TColumn('UNIDADE_TRIBUTAVEL','Unidade Tributavel',ldGridLookup ,6)]
    property UnidadeTributavel: String  read FUNIDADE_TRIBUTAVEL write FUNIDADE_TRIBUTAVEL;
    [TColumn('QUANTIDADE_TRIBUTAVEL','Quantidade Tributavel',ldGridLookup ,10)]
    property QuantidadeTributavel: Double  read FQUANTIDADE_TRIBUTAVEL write FQUANTIDADE_TRIBUTAVEL;
    [TColumn('VALOR_UNITARIO_TRIBUTACAO','Valor Unitario Tributacao',ldGridLookup ,10)]
    property ValorUnitarioTributacao: Double  read FVALOR_UNITARIO_TRIBUTACAO write FVALOR_UNITARIO_TRIBUTACAO;
    [TColumn('VALOR_FRETE','Valor Frete',ldGridLookup ,10)]
    property ValorFrete: Double  read FVALOR_FRETE write FVALOR_FRETE;
    [TColumn('VALOR_SEGURO','Valor Seguro',ldGridLookup ,10)]
    property ValorSeguro: Double  read FVALOR_SEGURO write FVALOR_SEGURO;
    [TColumn('VALOR_DESCONTO','Valor Desconto',ldGridLookup ,10)]
    property ValorDesconto: Double  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('VALOR_OUTRAS_DESPESAS','Valor Outras Despesas',ldGridLookup ,10)]
    property ValorOutrasDespesas: Double  read FVALOR_OUTRAS_DESPESAS write FVALOR_OUTRAS_DESPESAS;
    [TColumn('ENTRA_TOTAL','Entra Total',ldGridLookup ,1)]
    property EntraTotal: String  read FENTRA_TOTAL write FENTRA_TOTAL;
    [TColumn('ORIGEM_MERCADORIA','Origem Mercadoria',ldGridLookup ,1)]
    property OrigemMercadoria: String  read FORIGEM_MERCADORIA write FORIGEM_MERCADORIA;
    [TColumn('CST_ICMS','Cst Icms',ldGridLookup ,3)]
    property CstIcms: String  read FCST_ICMS write FCST_ICMS;
    [TColumn('CSOSN','Csosn',ldGridLookup ,4)]
    property Csosn: String  read FCSOSN write FCSOSN;
    [TColumn('MODALIDADE_BC_ICMS','Modalidade Bc Icms',ldGridLookup ,1)]
    property ModalidadeBcIcms: String  read FMODALIDADE_BC_ICMS write FMODALIDADE_BC_ICMS;
    [TColumn('TAXA_REDUCAO_BC_ICMS','Taxa Reducao Bc Icms',ldGridLookup ,10)]
    property TaxaReducaoBcIcms: Double  read FTAXA_REDUCAO_BC_ICMS write FTAXA_REDUCAO_BC_ICMS;
    [TColumn('BASE_CALCULO_ICMS','Base Calculo Icms',ldGridLookup ,10)]
    property BaseCalculoIcms: Double  read FBASE_CALCULO_ICMS write FBASE_CALCULO_ICMS;
    [TColumn('ALIQUOTA_ICMS','Aliquota Icms',ldGridLookup ,10)]
    property AliquotaIcms: Double  read FALIQUOTA_ICMS write FALIQUOTA_ICMS;
    [TColumn('VALOR_ICMS','Valor Icms',ldGridLookup ,10)]
    property ValorIcms: Double  read FVALOR_ICMS write FVALOR_ICMS;
    [TColumn('MOTIVO_DESONERACAO_ICMS','Motivo Desoneracao Icms',ldGridLookup ,1)]
    property MotivoDesoneracaoIcms: String  read FMOTIVO_DESONERACAO_ICMS write FMOTIVO_DESONERACAO_ICMS;
    [TColumn('MODALIDE_BC_ICMS_ST','Modalide Bc Icms St',ldGridLookup ,1)]
    property ModalideBcIcmsSt: String  read FMODALIDE_BC_ICMS_ST write FMODALIDE_BC_ICMS_ST;
    [TColumn('PERCENTUAL_MVA_ICMS_ST','Percentual Mva Icms St',ldGridLookup ,10)]
    property PercentualMvaIcmsSt: Double  read FPERCENTUAL_MVA_ICMS_ST write FPERCENTUAL_MVA_ICMS_ST;
    [TColumn('REDUCAO_BC_ICMS_ST','Reducao Bc Icms St',ldGridLookup ,10)]
    property ReducaoBcIcmsSt: Double  read FREDUCAO_BC_ICMS_ST write FREDUCAO_BC_ICMS_ST;
    [TColumn('BASE_CALCULO_ICMS_ST','Base Calculo Icms St',ldGridLookup ,10)]
    property BaseCalculoIcmsSt: Double  read FBASE_CALCULO_ICMS_ST write FBASE_CALCULO_ICMS_ST;
    [TColumn('ALIQUOTA_ICMS_ST','Aliquota Icms St',ldGridLookup ,10)]
    property AliquotaIcmsSt: Double  read FALIQUOTA_ICMS_ST write FALIQUOTA_ICMS_ST;
    [TColumn('VALOR_ICMS_ST','Valor Icms St',ldGridLookup ,10)]
    property ValorIcmsSt: Double  read FVALOR_ICMS_ST write FVALOR_ICMS_ST;
    [TColumn('VALOR_BC_ICMS_ST_RETIDO','Valor Bc Icms St Retido',ldGridLookup ,10)]
    property ValorBcIcmsStRetido: Double  read FVALOR_BC_ICMS_ST_RETIDO write FVALOR_BC_ICMS_ST_RETIDO;
    [TColumn('VALOR_ICMS_ST_RETIDO','Valor Icms St Retido',ldGridLookup ,10)]
    property ValorIcmsStRetido: Double  read FVALOR_ICMS_ST_RETIDO write FVALOR_ICMS_ST_RETIDO;
    [TColumn('ALIQUOTA_CREDITO_ICMS_SN','Aliquota Credito Icms Sn',ldGridLookup ,10)]
    property AliquotaCreditoIcmsSn: Double  read FALIQUOTA_CREDITO_ICMS_SN write FALIQUOTA_CREDITO_ICMS_SN;
    [TColumn('VALOR_CREDITO_ICMS_SN','Valor Credito Icms Sn',ldGridLookup ,10)]
    property ValorCreditoIcmsSn: Double  read FVALOR_CREDITO_ICMS_SN write FVALOR_CREDITO_ICMS_SN;
    [TColumn('ENQUADRAMENTO_IPI','Enquadramento Ipi',ldGridLookup ,5)]
    property EnquadramentoIpi: String  read FENQUADRAMENTO_IPI write FENQUADRAMENTO_IPI;
    [TColumn('CNPJ_PRODUTOR','Cnpj Produtor',ldGridLookup ,14)]
    property CnpjProdutor: String  read FCNPJ_PRODUTOR write FCNPJ_PRODUTOR;
    [TColumn('CODIGO_SELO_IPI','Codigo Selo Ipi',ldGridLookup ,60)]
    property CodigoSeloIpi: String  read FCODIGO_SELO_IPI write FCODIGO_SELO_IPI;
    [TColumn('QUANTIDADE_SELO_IPI','Quantidade Selo Ipi',ldGridLookup ,8)]
    property QuantidadeSeloIpi: Integer  read FQUANTIDADE_SELO_IPI write FQUANTIDADE_SELO_IPI;
    [TColumn('ENQUADRAMENTO_LEGAL_IPI','Enquadramento Legal Ipi',ldGridLookup ,3)]
    property EnquadramentoLegalIpi: String  read FENQUADRAMENTO_LEGAL_IPI write FENQUADRAMENTO_LEGAL_IPI;
    [TColumn('CST_IPI','Cst Ipi',ldGridLookup ,3)]
    property CstIpi: String  read FCST_IPI write FCST_IPI;
    [TColumn('BASE_CALCULO_IPI','Base Calculo Ipi',ldGridLookup ,10)]
    property BaseCalculoIpi: Double  read FBASE_CALCULO_IPI write FBASE_CALCULO_IPI;
    [TColumn('ALIQUOTA_IPI','Aliquota Ipi',ldGridLookup ,10)]
    property AliquotaIpi: Double  read FALIQUOTA_IPI write FALIQUOTA_IPI;
    [TColumn('VALOR_IPI','Valor Ipi',ldGridLookup ,10)]
    property ValorIpi: Double  read FVALOR_IPI write FVALOR_IPI;
    [TColumn('VALOR_BC_II','Valor Bc Ii',ldGridLookup ,10)]
    property ValorBcIi: Double  read FVALOR_BC_II write FVALOR_BC_II;
    [TColumn('VALOR_DESPESAS_ADUANEIRAS','Valor Despesas Aduaneiras',ldGridLookup ,10)]
    property ValorDespesasAduaneiras: Double  read FVALOR_DESPESAS_ADUANEIRAS write FVALOR_DESPESAS_ADUANEIRAS;
    [TColumn('VALOR_IMPOSTO_IMPORTACAO','Valor Imposto Importacao',ldGridLookup ,10)]
    property ValorImpostoImportacao: Double  read FVALOR_IMPOSTO_IMPORTACAO write FVALOR_IMPOSTO_IMPORTACAO;
    [TColumn('VALOR_IOF','Valor Iof',ldGridLookup ,10)]
    property ValorIof: Double  read FVALOR_IOF write FVALOR_IOF;
    [TColumn('CTS_PIS','Cts Pis',ldGridLookup ,2)]
    property CtsPis: String  read FCTS_PIS write FCTS_PIS;
    [TColumn('VALOR_BASE_CALCULO_PIS','Valor Base Calculo Pis',ldGridLookup ,10)]
    property ValorBaseCalculoPis: Double  read FVALOR_BASE_CALCULO_PIS write FVALOR_BASE_CALCULO_PIS;
    [TColumn('ALIQUOTA_PIS_PERCENTUAL','Aliquota Pis Percentual',ldGridLookup ,10)]
    property AliquotaPisPercentual: Double  read FALIQUOTA_PIS_PERCENTUAL write FALIQUOTA_PIS_PERCENTUAL;
    [TColumn('ALIQUOTA_PIS_REAIS','Aliquota Pis Reais',ldGridLookup ,10)]
    property AliquotaPisReais: Double  read FALIQUOTA_PIS_REAIS write FALIQUOTA_PIS_REAIS;
    [TColumn('VALOR_PIS','Valor Pis',ldGridLookup ,10)]
    property ValorPis: Double  read FVALOR_PIS write FVALOR_PIS;
    [TColumn('CST_COFINS','Cst Cofins',ldGridLookup ,2)]
    property CstCofins: String  read FCST_COFINS write FCST_COFINS;
    [TColumn('BASE_CALCULO_COFINS','Base Calculo Cofins',ldGridLookup ,10)]
    property BaseCalculoCofins: Double  read FBASE_CALCULO_COFINS write FBASE_CALCULO_COFINS;
    [TColumn('ALIQUOTA_COFINS_PERCENTUAL','Aliquota Cofins Percentual',ldGridLookup ,10)]
    property AliquotaCofinsPercentual: Double  read FALIQUOTA_COFINS_PERCENTUAL write FALIQUOTA_COFINS_PERCENTUAL;
    [TColumn('ALIQUOTA_COFINS_REAIS','Aliquota Cofins Reais',ldGridLookup ,10)]
    property AliquotaCofinsReais: Double  read FALIQUOTA_COFINS_REAIS write FALIQUOTA_COFINS_REAIS;
    [TColumn('VALOR_COFINS','Valor Cofins',ldGridLookup ,10)]
    property ValorCofins: Double  read FVALOR_COFINS write FVALOR_COFINS;
    [TColumn('BASE_CALCULO_ISSQN','Base Calculo Issqn',ldGridLookup ,10)]
    property BaseCalculoIssqn: Double  read FBASE_CALCULO_ISSQN write FBASE_CALCULO_ISSQN;
    [TColumn('ALIQUOTA_ISSQN','Aliquota Issqn',ldGridLookup ,10)]
    property AliquotaIssqn: Double  read FALIQUOTA_ISSQN write FALIQUOTA_ISSQN;
    [TColumn('VALOR_ISSQN','Valor Issqn',ldGridLookup ,10)]
    property ValorIssqn: Double  read FVALOR_ISSQN write FVALOR_ISSQN;
    [TColumn('MUNICIPIO_ISSQN','Municipio Issqn',ldGridLookup ,8)]
    property MunicipioIssqn: Integer  read FMUNICIPIO_ISSQN write FMUNICIPIO_ISSQN;
    [TColumn('ITEM_LISTA_SERVICOS','Item Lista Servicos',ldGridLookup ,8)]
    property ItemListaServicos: Integer  read FITEM_LISTA_SERVICOS write FITEM_LISTA_SERVICOS;
    [TColumn('TRIBUTACAO_ISSQN','Tributacao Issqn',ldGridLookup ,1)]
    property TributacaoIssqn: String  read FTRIBUTACAO_ISSQN write FTRIBUTACAO_ISSQN;
    [TColumn('VALOR_SUBTOTAL','Valor Subtotal',ldGridLookup ,10)]
    property ValorSubtotal: Double  read FVALOR_SUBTOTAL write FVALOR_SUBTOTAL;
    [TColumn('VALOR_TOTAL','Valor Total',ldGridLookup ,10)]
    property ValorTotal: Double  read FVALOR_TOTAL write FVALOR_TOTAL;
    [TColumn('INFORMACOES_ADICIONAIS','Informacoes Adicionais',ldGridLookup ,100)]
    property InformacoesAdicionais: String  read FINFORMACOES_ADICIONAIS write FINFORMACOES_ADICIONAIS;

  end;

implementation

end.
