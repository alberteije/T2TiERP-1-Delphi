{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [NFE_CABECALHO] 
                                                                                
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
unit NfeCabecalhoLimpaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('NFE_CABECALHO')]
  TNfeCabecalhoLimpaVO = class(TJsonVO)
  private
    FID: Integer;
    FID_TRIBUT_OPERACAO_FISCAL: Integer;
    FID_VENDA_CABECALHO: Integer;
    FID_EMPRESA: Integer;
    FID_FORNECEDOR: Integer;
    FID_CLIENTE: Integer;
    FUF_EMITENTE: Integer;
    FCODIGO_NUMERICO: String;
    FNATUREZA_OPERACAO: String;
    FINDICADOR_FORMA_PAGAMENTO: String;
    FCODIGO_MODELO: String;
    FSERIE: String;
    FNUMERO: String;
    FDATA_EMISSAO: TDateTime;
    FDATA_ENTRADA_SAIDA: TDateTime;
    FHORA_ENTRADA_SAIDA: String;
    FTIPO_OPERACAO: String;
    FCODIGO_MUNICIPIO: Integer;
    FFORMATO_IMPRESSAO_DANFE: String;
    FTIPO_EMISSAO: String;
    FCHAVE_ACESSO: String;
    FDIGITO_CHAVE_ACESSO: String;
    FAMBIENTE: String;
    FFINALIDADE_EMISSAO: String;
    FPROCESSO_EMISSAO: String;
    FVERSAO_PROCESSO_EMISSAO: String;
    FDATA_ENTRADA_CONTINGENCIA: TDateTime;
    FJUSTIFICATIVA_CONTINGENCIA: String;
    FBASE_CALCULO_ICMS: Extended;
    FVALOR_ICMS: Extended;
    FBASE_CALCULO_ICMS_ST: Extended;
    FVALOR_ICMS_ST: Extended;
    FVALOR_TOTAL_PRODUTOS: Extended;
    FVALOR_FRETE: Extended;
    FVALOR_SEGURO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_IMPOSTO_IMPORTACAO: Extended;
    FVALOR_IPI: Extended;
    FVALOR_PIS: Extended;
    FVALOR_COFINS: Extended;
    FVALOR_DESPESAS_ACESSORIAS: Extended;
    FVALOR_TOTAL: Extended;
    FVALOR_SERVICOS: Extended;
    FBASE_CALCULO_ISSQN: Extended;
    FVALOR_ISSQN: Extended;
    FVALOR_PIS_ISSQN: Extended;
    FVALOR_COFINS_ISSQN: Extended;
    FVALOR_RETIDO_PIS: Extended;
    FVALOR_RETIDO_COFINS: Extended;
    FVALOR_RETIDO_CSLL: Extended;
    FBASE_CALCULO_IRRF: Extended;
    FVALOR_RETIDO_IRRF: Extended;
    FBASE_CALCULO_PREVIDENCIA: Extended;
    FVALOR_RETIDO_PREVIDENCIA: Extended;
    FCOMEX_UF_EMBARQUE: String;
    FCOMEX_LOCAL_EMBARQUE: String;
    FCOMPRA_NOTA_EMPENHO: String;
    FCOMPRA_PEDIDO: String;
    FCOMPRA_CONTRATO: String;
    FINFORMACOES_ADD_FISCO: String;
    FINFORMACOES_ADD_CONTRIBUINTE: String;
    FSTATUS_NOTA: String;

  public 
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_TRIBUT_OPERACAO_FISCAL','Id Tribut Operacao Fiscal',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdTributOperacaoFiscal: Integer  read FID_TRIBUT_OPERACAO_FISCAL write FID_TRIBUT_OPERACAO_FISCAL;
    [TColumn('ID_VENDA_CABECALHO','Id Venda Cabecalho',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdVendaCabecalho: Integer  read FID_VENDA_CABECALHO write FID_VENDA_CABECALHO;
    [TColumn('ID_EMPRESA','Id Empresa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('ID_FORNECEDOR','Id Fornecedor',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFornecedor: Integer  read FID_FORNECEDOR write FID_FORNECEDOR;
    [TColumn('ID_CLIENTE','Id Cliente',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdCliente: Integer  read FID_CLIENTE write FID_CLIENTE;
    [TColumn('UF_EMITENTE','Uf Emitente',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property UfEmitente: Integer  read FUF_EMITENTE write FUF_EMITENTE;
    [TColumn('CODIGO_NUMERICO','Codigo Numerico',64,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoNumerico: String  read FCODIGO_NUMERICO write FCODIGO_NUMERICO;
    [TColumn('NATUREZA_OPERACAO','Natureza Operacao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property NaturezaOperacao: String  read FNATUREZA_OPERACAO write FNATUREZA_OPERACAO;
    [TColumn('INDICADOR_FORMA_PAGAMENTO','Indicador Forma Pagamento',8,[ldGrid, ldLookup, ldCombobox], False)]
    property IndicadorFormaPagamento: String  read FINDICADOR_FORMA_PAGAMENTO write FINDICADOR_FORMA_PAGAMENTO;
    [TColumn('CODIGO_MODELO','Codigo Modelo',16,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoModelo: String  read FCODIGO_MODELO write FCODIGO_MODELO;
    [TColumn('SERIE','Serie',24,[ldGrid, ldLookup, ldCombobox], False)]
    property Serie: String  read FSERIE write FSERIE;
    [TColumn('NUMERO','Numero',72,[ldGrid, ldLookup, ldCombobox], False)]
    property Numero: String  read FNUMERO write FNUMERO;
    [TColumn('DATA_EMISSAO','Data Emissao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataEmissao: TDateTime  read FDATA_EMISSAO write FDATA_EMISSAO;
    [TColumn('DATA_ENTRADA_SAIDA','Data Entrada Saida',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataEntradaSaida: TDateTime  read FDATA_ENTRADA_SAIDA write FDATA_ENTRADA_SAIDA;
    [TColumn('HORA_ENTRADA_SAIDA','Hora Entrada Saida',64,[ldGrid, ldLookup, ldCombobox], False)]
    property HoraEntradaSaida: String  read FHORA_ENTRADA_SAIDA write FHORA_ENTRADA_SAIDA;
    [TColumn('TIPO_OPERACAO','Tipo Operacao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property TipoOperacao: String  read FTIPO_OPERACAO write FTIPO_OPERACAO;
    [TColumn('CODIGO_MUNICIPIO','Codigo Municipio',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property CodigoMunicipio: Integer  read FCODIGO_MUNICIPIO write FCODIGO_MUNICIPIO;
    [TColumn('FORMATO_IMPRESSAO_DANFE','Formato Impressao Danfe',8,[ldGrid, ldLookup, ldCombobox], False)]
    property FormatoImpressaoDanfe: String  read FFORMATO_IMPRESSAO_DANFE write FFORMATO_IMPRESSAO_DANFE;
    [TColumn('TIPO_EMISSAO','Tipo Emissao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property TipoEmissao: String  read FTIPO_EMISSAO write FTIPO_EMISSAO;
    [TColumn('CHAVE_ACESSO','Chave Acesso',352,[ldGrid, ldLookup, ldCombobox], False)]
    property ChaveAcesso: String  read FCHAVE_ACESSO write FCHAVE_ACESSO;
    [TColumn('DIGITO_CHAVE_ACESSO','Digito Chave Acesso',8,[ldGrid, ldLookup, ldCombobox], False)]
    property DigitoChaveAcesso: String  read FDIGITO_CHAVE_ACESSO write FDIGITO_CHAVE_ACESSO;
    [TColumn('AMBIENTE','Ambiente',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Ambiente: String  read FAMBIENTE write FAMBIENTE;
    [TColumn('FINALIDADE_EMISSAO','Finalidade Emissao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property FinalidadeEmissao: String  read FFINALIDADE_EMISSAO write FFINALIDADE_EMISSAO;
    [TColumn('PROCESSO_EMISSAO','Processo Emissao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property ProcessoEmissao: String  read FPROCESSO_EMISSAO write FPROCESSO_EMISSAO;
    [TColumn('VERSAO_PROCESSO_EMISSAO','Versao Processo Emissao',160,[ldGrid, ldLookup, ldCombobox], False)]
    property VersaoProcessoEmissao: String  read FVERSAO_PROCESSO_EMISSAO write FVERSAO_PROCESSO_EMISSAO;
    [TColumn('DATA_ENTRADA_CONTINGENCIA','Data Entrada Contingencia',272,[ldGrid, ldLookup, ldCombobox], False)]
    property DataEntradaContingencia: TDateTime  read FDATA_ENTRADA_CONTINGENCIA write FDATA_ENTRADA_CONTINGENCIA;
    [TColumn('JUSTIFICATIVA_CONTINGENCIA','Justificativa Contingencia',450,[ldGrid, ldLookup, ldCombobox], False)]
    property JustificativaContingencia: String  read FJUSTIFICATIVA_CONTINGENCIA write FJUSTIFICATIVA_CONTINGENCIA;
    [TColumn('BASE_CALCULO_ICMS','Base Calculo Icms',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property BaseCalculoIcms: Extended  read FBASE_CALCULO_ICMS write FBASE_CALCULO_ICMS;
    [TColumn('VALOR_ICMS','Valor Icms',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorIcms: Extended  read FVALOR_ICMS write FVALOR_ICMS;
    [TColumn('BASE_CALCULO_ICMS_ST','Base Calculo Icms St',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property BaseCalculoIcmsSt: Extended  read FBASE_CALCULO_ICMS_ST write FBASE_CALCULO_ICMS_ST;
    [TColumn('VALOR_ICMS_ST','Valor Icms St',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorIcmsSt: Extended  read FVALOR_ICMS_ST write FVALOR_ICMS_ST;
    [TColumn('VALOR_TOTAL_PRODUTOS','Valor Total Produtos',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorTotalProdutos: Extended  read FVALOR_TOTAL_PRODUTOS write FVALOR_TOTAL_PRODUTOS;
    [TColumn('VALOR_FRETE','Valor Frete',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorFrete: Extended  read FVALOR_FRETE write FVALOR_FRETE;
    [TColumn('VALOR_SEGURO','Valor Seguro',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorSeguro: Extended  read FVALOR_SEGURO write FVALOR_SEGURO;
    [TColumn('VALOR_DESCONTO','Valor Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('VALOR_IMPOSTO_IMPORTACAO','Valor Imposto Importacao',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorImpostoImportacao: Extended  read FVALOR_IMPOSTO_IMPORTACAO write FVALOR_IMPOSTO_IMPORTACAO;
    [TColumn('VALOR_IPI','Valor Ipi',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorIpi: Extended  read FVALOR_IPI write FVALOR_IPI;
    [TColumn('VALOR_PIS','Valor Pis',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorPis: Extended  read FVALOR_PIS write FVALOR_PIS;
    [TColumn('VALOR_COFINS','Valor Cofins',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorCofins: Extended  read FVALOR_COFINS write FVALOR_COFINS;
    [TColumn('VALOR_DESPESAS_ACESSORIAS','Valor Despesas Acessorias',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorDespesasAcessorias: Extended  read FVALOR_DESPESAS_ACESSORIAS write FVALOR_DESPESAS_ACESSORIAS;
    [TColumn('VALOR_TOTAL','Valor Total',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    [TColumn('VALOR_SERVICOS','Valor Servicos',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorServicos: Extended  read FVALOR_SERVICOS write FVALOR_SERVICOS;
    [TColumn('BASE_CALCULO_ISSQN','Base Calculo Issqn',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property BaseCalculoIssqn: Extended  read FBASE_CALCULO_ISSQN write FBASE_CALCULO_ISSQN;
    [TColumn('VALOR_ISSQN','Valor Issqn',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorIssqn: Extended  read FVALOR_ISSQN write FVALOR_ISSQN;
    [TColumn('VALOR_PIS_ISSQN','Valor Pis Issqn',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorPisIssqn: Extended  read FVALOR_PIS_ISSQN write FVALOR_PIS_ISSQN;
    [TColumn('VALOR_COFINS_ISSQN','Valor Cofins Issqn',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorCofinsIssqn: Extended  read FVALOR_COFINS_ISSQN write FVALOR_COFINS_ISSQN;
    [TColumn('VALOR_RETIDO_PIS','Valor Retido Pis',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorRetidoPis: Extended  read FVALOR_RETIDO_PIS write FVALOR_RETIDO_PIS;
    [TColumn('VALOR_RETIDO_COFINS','Valor Retido Cofins',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorRetidoCofins: Extended  read FVALOR_RETIDO_COFINS write FVALOR_RETIDO_COFINS;
    [TColumn('VALOR_RETIDO_CSLL','Valor Retido Csll',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorRetidoCsll: Extended  read FVALOR_RETIDO_CSLL write FVALOR_RETIDO_CSLL;
    [TColumn('BASE_CALCULO_IRRF','Base Calculo Irrf',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property BaseCalculoIrrf: Extended  read FBASE_CALCULO_IRRF write FBASE_CALCULO_IRRF;
    [TColumn('VALOR_RETIDO_IRRF','Valor Retido Irrf',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorRetidoIrrf: Extended  read FVALOR_RETIDO_IRRF write FVALOR_RETIDO_IRRF;
    [TColumn('BASE_CALCULO_PREVIDENCIA','Base Calculo Previdencia',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property BaseCalculoPrevidencia: Extended  read FBASE_CALCULO_PREVIDENCIA write FBASE_CALCULO_PREVIDENCIA;
    [TColumn('VALOR_RETIDO_PREVIDENCIA','Valor Retido Previdencia',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorRetidoPrevidencia: Extended  read FVALOR_RETIDO_PREVIDENCIA write FVALOR_RETIDO_PREVIDENCIA;
    [TColumn('COMEX_UF_EMBARQUE','Comex Uf Embarque',16,[ldGrid, ldLookup, ldCombobox], False)]
    property ComexUfEmbarque: String  read FCOMEX_UF_EMBARQUE write FCOMEX_UF_EMBARQUE;
    [TColumn('COMEX_LOCAL_EMBARQUE','Comex Local Embarque',450,[ldGrid, ldLookup, ldCombobox], False)]
    property ComexLocalEmbarque: String  read FCOMEX_LOCAL_EMBARQUE write FCOMEX_LOCAL_EMBARQUE;
    [TColumn('COMPRA_NOTA_EMPENHO','Compra Nota Empenho',176,[ldGrid, ldLookup, ldCombobox], False)]
    property CompraNotaEmpenho: String  read FCOMPRA_NOTA_EMPENHO write FCOMPRA_NOTA_EMPENHO;
    [TColumn('COMPRA_PEDIDO','Compra Pedido',450,[ldGrid, ldLookup, ldCombobox], False)]
    property CompraPedido: String  read FCOMPRA_PEDIDO write FCOMPRA_PEDIDO;
    [TColumn('COMPRA_CONTRATO','Compra Contrato',450,[ldGrid, ldLookup, ldCombobox], False)]
    property CompraContrato: String  read FCOMPRA_CONTRATO write FCOMPRA_CONTRATO;
    [TColumn('INFORMACOES_ADD_FISCO','Informacoes Add Fisco',450,[ldGrid, ldLookup, ldCombobox], False)]
    property InformacoesAddFisco: String  read FINFORMACOES_ADD_FISCO write FINFORMACOES_ADD_FISCO;
    [TColumn('INFORMACOES_ADD_CONTRIBUINTE','Informacoes Add Contribuinte',450,[ldGrid, ldLookup, ldCombobox], False)]
    property InformacoesAddContribuinte: String  read FINFORMACOES_ADD_CONTRIBUINTE write FINFORMACOES_ADD_CONTRIBUINTE;
    [TColumn('STATUS_NOTA','Status Nota',8,[ldGrid, ldLookup, ldCombobox], False)]
    property StatusNota: String  read FSTATUS_NOTA write FSTATUS_NOTA;

  end;

implementation



end.
