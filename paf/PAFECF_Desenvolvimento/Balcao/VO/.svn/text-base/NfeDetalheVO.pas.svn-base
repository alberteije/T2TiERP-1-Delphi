{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [NFE_DETALHE]
                                                                                
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
unit NfeDetalheVO;

interface

type
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
    FQUANTIDADE_COMERCIAL: Extended;
    FVALOR_UNITARIO_COMERCIAL: Extended;
    FVALOR_BRUTO_PRODUTOS: Extended;
    FGTIN_UNIDADE_TRIBUTAVEL: String;
    FUNIDADE_TRIBUTAVEL: String;
    FQUANTIDADE_TRIBUTAVEL: Extended;
    FVALOR_UNITARIO_TRIBUTACAO: Extended;
    FVALOR_FRETE: Extended;
    FVALOR_SEGURO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_OUTRAS_DESPESAS: Extended;
    FENTRA_TOTAL: String;
    FORIGEM_MERCADORIA: String;
    FCST_ICMS: String;
    FCSOSN: String;
    FMODALIDADE_BC_ICMS: String;
    FTAXA_REDUCAO_BC_ICMS: Extended;
    FBASE_CALCULO_ICMS: Extended;
    FALIQUOTA_ICMS: Extended;
    FVALOR_ICMS: Extended;
    FMOTIVO_DESONERACAO_ICMS: String;
    FMODALIDE_BC_ICMS_ST: String;
    FPERCENTUAL_MVA_ICMS_ST: Extended;
    FREDUCAO_BC_ICMS_ST: Extended;
    FBASE_CALCULO_ICMS_ST: Extended;
    FALIQUOTA_ICMS_ST: Extended;
    FVALOR_ICMS_ST: Extended;
    FVALOR_BC_ICMS_ST_RETIDO: Extended;
    FVALOR_ICMS_ST_RETIDO: Extended;
    FALIQUOTA_CREDITO_ICMS_SN: Extended;
    FVALOR_CREDITO_ICMS_SN: Extended;
    FENQUADRAMENTO_IPI: String;
    FCNPJ_PRODUTOR: String;
    FCODIGO_SELO_IPI: String;
    FQUANTIDADE_SELO_IPI: Integer;
    FENQUADRAMENTO_LEGAL_IPI: String;
    FCST_IPI: String;
    FBASE_CALCULO_IPI: Extended;
    FALIQUOTA_IPI: Extended;
    FVALOR_IPI: Extended;
    FVALOR_BC_II: Extended;
    FVALOR_DESPESAS_ADUANEIRAS: Extended;
    FVALOR_IMPOSTO_IMPORTACAO: Extended;
    FVALOR_IOF: Extended;
    FCTS_PIS: String;
    FVALOR_BASE_CALCULO_PIS: Extended;
    FALIQUOTA_PIS_PERCENTUAL: Extended;
    FALIQUOTA_PIS_REAIS: Extended;
    FVALOR_PIS: Extended;
    FCST_COFINS: String;
    FBASE_CALCULO_COFINS: Extended;
    FALIQUOTA_COFINS_PERCENTUAL: Extended;
    FALIQUOTA_COFINS_REAIS: Extended;
    FVALOR_COFINS: Extended;
    FBASE_CALCULO_ISSQN: Extended;
    FALIQUOTA_ISSQN: Extended;
    FVALOR_ISSQN: Extended;
    FMUNICIPIO_ISSQN: Integer;
    FITEM_LISTA_SERVICOS: Integer;
    FTRIBUTACAO_ISSQN: String;
    FVALOR_SUBTOTAL: Extended;
    FVALOR_TOTAL: Extended;
    FINFORMACOES_ADICIONAIS: String;

  public
    property Id: Integer  read FID write FID;
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    property IdNfeCabecalho: Integer  read FID_NFE_CABECALHO write FID_NFE_CABECALHO;
    property NumeroItem: Integer  read FNUMERO_ITEM write FNUMERO_ITEM;
    property CodigoProduto: String  read FCODIGO_PRODUTO write FCODIGO_PRODUTO;
    property Gtin: String  read FGTIN write FGTIN;
    property NomeProduto: String  read FNOME_PRODUTO write FNOME_PRODUTO;
    property Ncm: String  read FNCM write FNCM;
    property ExTipi: Integer  read FEX_TIPI write FEX_TIPI;
    property Cfop: Integer  read FCFOP write FCFOP;
    property UnidadeComercial: String  read FUNIDADE_COMERCIAL write FUNIDADE_COMERCIAL;
    property QuantidadeComercial: Extended  read FQUANTIDADE_COMERCIAL write FQUANTIDADE_COMERCIAL;
    property ValorUnitarioComercial: Extended  read FVALOR_UNITARIO_COMERCIAL write FVALOR_UNITARIO_COMERCIAL;
    property ValorBrutoProdutos: Extended  read FVALOR_BRUTO_PRODUTOS write FVALOR_BRUTO_PRODUTOS;
    property GtinUnidadeTributavel: String  read FGTIN_UNIDADE_TRIBUTAVEL write FGTIN_UNIDADE_TRIBUTAVEL;
    property UnidadeTributavel: String  read FUNIDADE_TRIBUTAVEL write FUNIDADE_TRIBUTAVEL;
    property QuantidadeTributavel: Extended  read FQUANTIDADE_TRIBUTAVEL write FQUANTIDADE_TRIBUTAVEL;
    property ValorUnitarioTributacao: Extended  read FVALOR_UNITARIO_TRIBUTACAO write FVALOR_UNITARIO_TRIBUTACAO;
    property ValorFrete: Extended  read FVALOR_FRETE write FVALOR_FRETE;
    property ValorSeguro: Extended  read FVALOR_SEGURO write FVALOR_SEGURO;
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    property ValorOutrasDespesas: Extended  read FVALOR_OUTRAS_DESPESAS write FVALOR_OUTRAS_DESPESAS;
    property EntraTotal: String  read FENTRA_TOTAL write FENTRA_TOTAL;
    property OrigemMercadoria: String  read FORIGEM_MERCADORIA write FORIGEM_MERCADORIA;
    property CstIcms: String  read FCST_ICMS write FCST_ICMS;
    property Csosn: String  read FCSOSN write FCSOSN;
    property ModalidadeBcIcms: String  read FMODALIDADE_BC_ICMS write FMODALIDADE_BC_ICMS;
    property TaxaReducaoBcIcms: Extended  read FTAXA_REDUCAO_BC_ICMS write FTAXA_REDUCAO_BC_ICMS;
    property BaseCalculoIcms: Extended  read FBASE_CALCULO_ICMS write FBASE_CALCULO_ICMS;
    property AliquotaIcms: Extended  read FALIQUOTA_ICMS write FALIQUOTA_ICMS;
    property ValorIcms: Extended  read FVALOR_ICMS write FVALOR_ICMS;
    property MotivoDesoneracaoIcms: String  read FMOTIVO_DESONERACAO_ICMS write FMOTIVO_DESONERACAO_ICMS;
    property ModalideBcIcmsSt: String  read FMODALIDE_BC_ICMS_ST write FMODALIDE_BC_ICMS_ST;
    property PercentualMvaIcmsSt: Extended  read FPERCENTUAL_MVA_ICMS_ST write FPERCENTUAL_MVA_ICMS_ST;
    property ReducaoBcIcmsSt: Extended  read FREDUCAO_BC_ICMS_ST write FREDUCAO_BC_ICMS_ST;
    property BaseCalculoIcmsSt: Extended  read FBASE_CALCULO_ICMS_ST write FBASE_CALCULO_ICMS_ST;
    property AliquotaIcmsSt: Extended  read FALIQUOTA_ICMS_ST write FALIQUOTA_ICMS_ST;
    property ValorIcmsSt: Extended  read FVALOR_ICMS_ST write FVALOR_ICMS_ST;
    property ValorBcIcmsStRetido: Extended  read FVALOR_BC_ICMS_ST_RETIDO write FVALOR_BC_ICMS_ST_RETIDO;
    property ValorIcmsStRetido: Extended  read FVALOR_ICMS_ST_RETIDO write FVALOR_ICMS_ST_RETIDO;
    property AliquotaCreditoIcmsSn: Extended  read FALIQUOTA_CREDITO_ICMS_SN write FALIQUOTA_CREDITO_ICMS_SN;
    property ValorCreditoIcmsSn: Extended  read FVALOR_CREDITO_ICMS_SN write FVALOR_CREDITO_ICMS_SN;
    property EnquadramentoIpi: String  read FENQUADRAMENTO_IPI write FENQUADRAMENTO_IPI;
    property CnpjProdutor: String  read FCNPJ_PRODUTOR write FCNPJ_PRODUTOR;
    property CodigoSeloIpi: String  read FCODIGO_SELO_IPI write FCODIGO_SELO_IPI;
    property QuantidadeSeloIpi: Integer  read FQUANTIDADE_SELO_IPI write FQUANTIDADE_SELO_IPI;
    property EnquadramentoLegalIpi: String  read FENQUADRAMENTO_LEGAL_IPI write FENQUADRAMENTO_LEGAL_IPI;
    property CstIpi: String  read FCST_IPI write FCST_IPI;
    property BaseCalculoIpi: Extended  read FBASE_CALCULO_IPI write FBASE_CALCULO_IPI;
    property AliquotaIpi: Extended  read FALIQUOTA_IPI write FALIQUOTA_IPI;
    property ValorIpi: Extended  read FVALOR_IPI write FVALOR_IPI;
    property ValorBcIi: Extended  read FVALOR_BC_II write FVALOR_BC_II;
    property ValorDespesasAduaneiras: Extended  read FVALOR_DESPESAS_ADUANEIRAS write FVALOR_DESPESAS_ADUANEIRAS;
    property ValorImpostoImportacao: Extended  read FVALOR_IMPOSTO_IMPORTACAO write FVALOR_IMPOSTO_IMPORTACAO;
    property ValorIof: Extended  read FVALOR_IOF write FVALOR_IOF;
    property CtsPis: String  read FCTS_PIS write FCTS_PIS;
    property ValorBaseCalculoPis: Extended  read FVALOR_BASE_CALCULO_PIS write FVALOR_BASE_CALCULO_PIS;
    property AliquotaPisPercentual: Extended  read FALIQUOTA_PIS_PERCENTUAL write FALIQUOTA_PIS_PERCENTUAL;
    property AliquotaPisReais: Extended  read FALIQUOTA_PIS_REAIS write FALIQUOTA_PIS_REAIS;
    property ValorPis: Extended  read FVALOR_PIS write FVALOR_PIS;
    property CstCofins: String  read FCST_COFINS write FCST_COFINS;
    property BaseCalculoCofins: Extended  read FBASE_CALCULO_COFINS write FBASE_CALCULO_COFINS;
    property AliquotaCofinsPercentual: Extended  read FALIQUOTA_COFINS_PERCENTUAL write FALIQUOTA_COFINS_PERCENTUAL;
    property AliquotaCofinsReais: Extended  read FALIQUOTA_COFINS_REAIS write FALIQUOTA_COFINS_REAIS;
    property ValorCofins: Extended  read FVALOR_COFINS write FVALOR_COFINS;
    property BaseCalculoIssqn: Extended  read FBASE_CALCULO_ISSQN write FBASE_CALCULO_ISSQN;
    property AliquotaIssqn: Extended  read FALIQUOTA_ISSQN write FALIQUOTA_ISSQN;
    property ValorIssqn: Extended  read FVALOR_ISSQN write FVALOR_ISSQN;
    property MunicipioIssqn: Integer  read FMUNICIPIO_ISSQN write FMUNICIPIO_ISSQN;
    property ItemListaServicos: Integer  read FITEM_LISTA_SERVICOS write FITEM_LISTA_SERVICOS;
    property TributacaoIssqn: String  read FTRIBUTACAO_ISSQN write FTRIBUTACAO_ISSQN;
    property ValorSubtotal: Extended  read FVALOR_SUBTOTAL write FVALOR_SUBTOTAL;
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    property InformacoesAdicionais: String  read FINFORMACOES_ADICIONAIS write FINFORMACOES_ADICIONAIS;

  end;

implementation



end.
