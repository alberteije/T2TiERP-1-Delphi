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
unit NfeCabecalhoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, NfeReferenciadaVO, NfeLocalRetiradaVO, NfeEmitenteVO, NfeLocalEntregaVO,
  NfeFaturaVO, NfeDuplicataVO, NfeProcessoReferenciadoVO, NfeDestinatarioVO,
  NfeCanaVO, NfeTransporteVO, NfeDetalheVO, NfeNfReferenciadaVO, NfeProdRuralReferenciadaVO,
  NfeCupomFiscalReferenciadoVO, NfeCteReferenciadoVO, NfeTransporteVolumeVO,
  NfeTransporteReboqueVO, NfeTransporteVolumeLacreVO, NfeDeclaracaoImportacaoVO,
  NfeDetEspecificoMedicamentoVO, NfeDetEspecificoArmamentoVO, NfeImportacaoDetalheVO,
  TributOperacaoFiscalVO, FiscalNotaFiscalEntradaVO;

type
  [TEntity]
  [TTable('NFE_CABECALHO')]
  TNfeCabecalhoVO = class(TJsonVO)
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

    FTributOperacaoFiscalDescricao: String;

    FTributOperacaoFiscalVO: TTributOperacaoFiscalVO;

    FFiscalNotaFiscalEntradaVO: TFiscalNotaFiscalEntradaVO; //1:1

    FNfeEmitenteVO: TNfeEmitenteVO; //1:1
    FNfeDestinatarioVO: TNfeDestinatarioVO; //1:1
    FNfeLocalRetiradaVO: TNfeLocalRetiradaVO; //0:1
    FNfeLocalEntregaVO: TNfeLocalEntregaVO; //0:1
    FNfeTransporteVO: TNfeTransporteVO; //1:1
    FNfeFaturaVO: TNfeFaturaVO; //0:1
    FNfeCanaVO: TNfeCanaVO; //0:1

    FListaNfeReferenciadaVO: TObjectList<TNfeReferenciadaVO>; //0:N
    FListaNfeNfReferenciadaVO: TObjectList<TNfeNfReferenciadaVO>; //0:N
    FListaNfeCteReferenciadoVO: TObjectList<TNfeCteReferenciadoVO>; //0:N
    FListaNfeProdRuralReferenciadaVO: TObjectList<TNfeProdRuralReferenciadaVO>; //0:N
    FListaNfeCupomFiscalReferenciadoVO: TObjectList<TNfeCupomFiscalReferenciadoVO>; //0:N

    FListaNfeDetalheVO: TObjectList<TNfeDetalheVO>; //1:990
    FListaNfeDuplicataVO: TObjectList<TNfeDuplicataVO>; //0:120
    FListaNfeProcessoReferenciadoVO: TObjectList<TNfeProcessoReferenciadoVO>; //0:N

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_VENDA_CABECALHO','Id Venda Cabecalho',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdVendaCabecalho: Integer  read FID_VENDA_CABECALHO write FID_VENDA_CABECALHO;

    [TColumn('ID_TRIBUT_OPERACAO_FISCAL','Id Operação Fiscal',80,[ldGrid, ldLookup, ldComboBox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdOperacaoFiscal: Integer  read FID_TRIBUT_OPERACAO_FISCAL write FID_TRIBUT_OPERACAO_FISCAL;
    [TColumn('TRIBUT_OPERACAO_FISCAL.DESCRICAO', 'Descrição Operação Fiscal', 400, [ldGrid, ldLookup, ldComboBox], True, 'TRIBUT_OPERACAO_FISCAL', 'ID_TRIBUT_OPERACAO_FISCAL', 'ID')]
    property TributOperacaoFiscalDescricao: String read FTributOperacaoFiscalDescricao write FTributOperacaoFiscalDescricao;

    [TColumn('ID_EMPRESA','Id Empresa',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('ID_FORNECEDOR','Id Fornecedor',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFornecedor: Integer  read FID_FORNECEDOR write FID_FORNECEDOR;
    [TColumn('ID_CLIENTE','Id Cliente',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdCliente: Integer  read FID_CLIENTE write FID_CLIENTE;
    [TColumn('UF_EMITENTE','Uf Emitente',16,[ldGrid, ldLookup, ldCombobox], False)]
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

    [TAssociation(False,'ID','ID_TRIBUT_OPERACAO_FISCAL','TRIBUT_OPERACAO_FISCAL')]
    property TributOperacaoFiscalVO: TTributOperacaoFiscalVO read FTributOperacaoFiscalVO write FTributOperacaoFiscalVO;

    [TAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property FiscalNotaFiscalEntradaVO: TFiscalNotaFiscalEntradaVO read FFiscalNotaFiscalEntradaVO write FFiscalNotaFiscalEntradaVO;


    [TAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property NfeEmitenteVO: TNfeEmitenteVO read FNfeEmitenteVO write FNfeEmitenteVO;

    [TAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property NfeDestinatarioVO: TNfeDestinatarioVO read FNfeDestinatarioVO write FNfeDestinatarioVO;

    [TAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property NfeLocalRetiradaVO: TNfeLocalRetiradaVO read FNfeLocalRetiradaVO write FNfeLocalRetiradaVO;

    [TAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property NfeLocalEntregaVO: TNfeLocalEntregaVO read FNfeLocalEntregaVO write FNfeLocalEntregaVO;

    [TAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property NfeTransporteVO: TNfeTransporteVO read FNfeTransporteVO write FNfeTransporteVO;

    [TAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property NfeFaturaVO: TNfeFaturaVO read FNfeFaturaVO write FNfeFaturaVO;

    [TAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property NfeCanaVO: TNfeCanaVO read FNfeCanaVO write FNfeCanaVO;

    [TManyValuedAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property ListaNfeReferenciadaVO: TObjectList<TNfeReferenciadaVO>read FListaNfeReferenciadaVO write FListaNfeReferenciadaVO;

    [TManyValuedAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property ListaNfeNfReferenciadaVO: TObjectList<TNfeNfReferenciadaVO>read FListaNfeNfReferenciadaVO write FListaNfeNfReferenciadaVO;

    [TManyValuedAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property ListaNfeCteReferenciadoVO: TObjectList<TNfeCteReferenciadoVO>read FListaNfeCteReferenciadoVO write FListaNfeCteReferenciadoVO;

    [TManyValuedAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property ListaNfeProdRuralReferenciadaVO: TObjectList<TNfeProdRuralReferenciadaVO>read FListaNfeProdRuralReferenciadaVO write FListaNfeProdRuralReferenciadaVO;

    [TManyValuedAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property ListaNfeCupomFiscalReferenciadoVO: TObjectList<TNfeCupomFiscalReferenciadoVO>read FListaNfeCupomFiscalReferenciadoVO write FListaNfeCupomFiscalReferenciadoVO;

    [TManyValuedAssociation(True, 'ID_NFE_CABECALHO','ID')]
    property ListaNfeDetalheVO: TObjectList<TNFeDetalheVO>read FListaNfeDetalheVO write FListaNfeDetalheVO;

    [TManyValuedAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property ListaNfeDuplicataVO: TObjectList<TNfeDuplicataVO>read FListaNfeDuplicataVO write FListaNfeDuplicataVO;

    [TManyValuedAssociation(False, 'ID_NFE_CABECALHO','ID')]
    property ListaNfeProcessoReferenciadoVO: TObjectList<TNfeProcessoReferenciadoVO>read FListaNfeProcessoReferenciadoVO write FListaNfeProcessoReferenciadoVO;

  end;

implementation

constructor TNfeCabecalhoVO.Create;
begin
  inherited;
  FListaNfeReferenciadaVO := TObjectList<TNfeReferenciadaVO>.Create; //0:N
  FListaNfeNfReferenciadaVO := TObjectList<TNfeNfReferenciadaVO>.Create; //0:N
  FListaNfeCteReferenciadoVO := TObjectList<TNfeCteReferenciadoVO>.Create; //0:N
  FListaNfeProdRuralReferenciadaVO := TObjectList<TNfeProdRuralReferenciadaVO>.Create; //0:N
  FListaNfeCupomFiscalReferenciadoVO := TObjectList<TNfeCupomFiscalReferenciadoVO>.Create; //0:N
  FListaNfeDetalheVO := TObjectList<TNfeDetalheVO>.Create; //1:990
  FListaNfeDuplicataVO := TObjectList<TNfeDuplicataVO>.Create; //0:120
  FListaNfeProcessoReferenciadoVO := TObjectList<TNfeProcessoReferenciadoVO>.Create; //0:N
end;

constructor TNfeCabecalhoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Nfe Referenciada
    Deserializa.RegisterReverter(TNfeCabecalhoVO, 'FListaNfeReferenciadaVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeCabecalhoVO(Data).FListaNfeReferenciadaVO) then
        TNfeCabecalhoVO(Data).FListaNfeReferenciadaVO := TObjectList<TNfeReferenciadaVO>.Create;

      for Obj in Args do
      begin
        TNfeCabecalhoVO(Data).FListaNfeReferenciadaVO.Add(TNfeReferenciadaVO(Obj));
      end
    end);

    //Lista Nfe NF Referenciada
    Deserializa.RegisterReverter(TNfeCabecalhoVO, 'FListaNfeNfReferenciadaVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeCabecalhoVO(Data).FListaNfeNfReferenciadaVO) then
        TNfeCabecalhoVO(Data).FListaNfeNfReferenciadaVO := TObjectList<TNfeNfReferenciadaVO>.Create;

      for Obj in Args do
      begin
        TNfeCabecalhoVO(Data).FListaNfeNfReferenciadaVO.Add(TNfeNfReferenciadaVO(Obj));
      end
    end);

    //Lista Nfe CT-e Referenciado
    Deserializa.RegisterReverter(TNfeCabecalhoVO, 'FListaNfeCteReferenciadoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeCabecalhoVO(Data).FListaNfeCteReferenciadoVO) then
        TNfeCabecalhoVO(Data).FListaNfeCteReferenciadoVO := TObjectList<TNfeCteReferenciadoVO>.Create;

      for Obj in Args do
      begin
        TNfeCabecalhoVO(Data).FListaNfeCteReferenciadoVO.Add(TNfeCteReferenciadoVO(Obj));
      end
    end);

    //Lista Nfe Rural Referenciada
    Deserializa.RegisterReverter(TNfeCabecalhoVO, 'FListaNfeProdRuralReferenciadaVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeCabecalhoVO(Data).FListaNfeProdRuralReferenciadaVO) then
        TNfeCabecalhoVO(Data).FListaNfeProdRuralReferenciadaVO := TObjectList<TNfeProdRuralReferenciadaVO>.Create;

      for Obj in Args do
      begin
        TNfeCabecalhoVO(Data).FListaNfeProdRuralReferenciadaVO.Add(TNfeProdRuralReferenciadaVO(Obj));
      end
    end);

    //Lista Nfe Cupom Fiscal Referenciado
    Deserializa.RegisterReverter(TNfeCabecalhoVO, 'FListaNfeCupomFiscalReferenciadoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeCabecalhoVO(Data).FListaNfeCupomFiscalReferenciadoVO) then
        TNfeCabecalhoVO(Data).FListaNfeCupomFiscalReferenciadoVO := TObjectList<TNfeCupomFiscalReferenciadoVO>.Create;

      for Obj in Args do
      begin
        TNfeCabecalhoVO(Data).FListaNfeCupomFiscalReferenciadoVO.Add(TNfeCupomFiscalReferenciadoVO(Obj));
      end
    end);

    //Lista Nfe Detalhe
    Deserializa.RegisterReverter(TNfeCabecalhoVO, 'FListaNfeDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeCabecalhoVO(Data).FListaNfeDetalheVO) then
        TNfeCabecalhoVO(Data).FListaNfeDetalheVO := TObjectList<TNfeDetalheVO>.Create;

      for Obj in Args do
      begin
        TNfeCabecalhoVO(Data).FListaNfeDetalheVO.Add(TNfeDetalheVO(Obj));
      end
    end);

    //Lista Nfe Duplicata
    Deserializa.RegisterReverter(TNfeCabecalhoVO, 'FListaNfeDuplicataVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeCabecalhoVO(Data).FListaNfeDuplicataVO) then
        TNfeCabecalhoVO(Data).FListaNfeDuplicataVO := TObjectList<TNfeDuplicataVO>.Create;

      for Obj in Args do
      begin
        TNfeCabecalhoVO(Data).FListaNfeDuplicataVO.Add(TNfeDuplicataVO(Obj));
      end
    end);

    //Lista Nfe Processo Referenciado
    Deserializa.RegisterReverter(TNfeCabecalhoVO, 'FListaNfeProcessoReferenciadoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeCabecalhoVO(Data).FListaNfeProcessoReferenciadoVO) then
        TNfeCabecalhoVO(Data).FListaNfeProcessoReferenciadoVO := TObjectList<TNfeProcessoReferenciadoVO>.Create;

      for Obj in Args do
      begin
        TNfeCabecalhoVO(Data).FListaNfeProcessoReferenciadoVO.Add(TNfeProcessoReferenciadoVO(Obj));
      end
    end);


    (* Listas dos objetos filhos que devem ser deserializadas *)
    //Lista Transporte Reboque
    Deserializa.RegisterReverter(TNfeTransporteVO, 'FListaNfeTransporteReboqueVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeTransporteVO(Data).ListaNfeTransporteReboqueVO) then
        TNfeTransporteVO(Data).ListaNfeTransporteReboqueVO := TObjectList<TNfeTransporteReboqueVO>.Create;

      for Obj in Args do
      begin
        TNfeTransporteVO(Data).ListaNfeTransporteReboqueVO.Add(TNfeTransporteReboqueVO(Obj));
      end
    end);

    //Lista Transporte Volumes
    Deserializa.RegisterReverter(TNfeTransporteVO, 'FListaNfeTransporteVolumeVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeTransporteVO(Data).ListaNfeTransporteVolumeVO) then
        TNfeTransporteVO(Data).ListaNfeTransporteVolumeVO := TObjectList<TNfeTransporteVolumeVO>.Create;

      for Obj in Args do
      begin
        TNfeTransporteVO(Data).ListaNfeTransporteVolumeVO.Add(TNfeTransporteVolumeVO(Obj));
      end
    end);

    //Lista Lacres
    Deserializa.RegisterReverter(TNfeTransporteVolumeVO, 'FListaNfeTransporteVolumeLacreVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeTransporteVolumeVO(Data).ListaNfeTransporteVolumeLacreVO) then
        TNfeTransporteVolumeVO(Data).ListaNfeTransporteVolumeLacreVO := TObjectList<TNfeTransporteVolumeLacreVO>.Create;

      for Obj in Args do
      begin
        TNfeTransporteVolumeVO(Data).ListaNfeTransporteVolumeLacreVO.Add(TNfeTransporteVolumeLacreVO(Obj));
      end
    end);

    //Lista Nfe Referenciada
    Deserializa.RegisterReverter(TNfeDetalheVO, 'FListaNfeDeclaracaoImportacaoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeDetalheVO(Data).ListaNfeDeclaracaoImportacaoVO) then
        TNfeDetalheVO(Data).ListaNfeDeclaracaoImportacaoVO := TObjectList<TNfeDeclaracaoImportacaoVO>.Create;

      for Obj in Args do
      begin
        TNfeDetalheVO(Data).ListaNfeDeclaracaoImportacaoVO.Add(TNfeDeclaracaoImportacaoVO(Obj));
      end
    end);

    //Lista Nfe Detalhe
    Deserializa.RegisterReverter(TNfeDetalheVO, 'FListaNfeDetEspecificoMedicamentoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeDetalheVO(Data).ListaNfeDetEspecificoMedicamentoVO) then
        TNfeDetalheVO(Data).ListaNfeDetEspecificoMedicamentoVO := TObjectList<TNfeDetEspecificoMedicamentoVO>.Create;

      for Obj in Args do
      begin
        TNfeDetalheVO(Data).ListaNfeDetEspecificoMedicamentoVO.Add(TNfeDetEspecificoMedicamentoVO(Obj));
      end
    end);

    //Lista Nfe Duplicata
    Deserializa.RegisterReverter(TNfeDetalheVO, 'FListaNfeDetEspecificoArmamentoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeDetalheVO(Data).ListaNfeDetEspecificoArmamentoVO) then
        TNfeDetalheVO(Data).ListaNfeDetEspecificoArmamentoVO := TObjectList<TNfeDetEspecificoArmamentoVO>.Create;

      for Obj in Args do
      begin
        TNfeDetalheVO(Data).ListaNfeDetEspecificoArmamentoVO.Add(TNfeDetEspecificoArmamentoVO(Obj));
      end
    end);

    //Lista Adições
    Deserializa.RegisterReverter(TNfeDeclaracaoImportacaoVO, 'FListaNfeImportacaoDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeDeclaracaoImportacaoVO(Data).ListaNfeImportacaoDetalheVO) then
        TNfeDeclaracaoImportacaoVO(Data).ListaNfeImportacaoDetalheVO := TObjectList<TNfeImportacaoDetalheVO>.Create;

      for Obj in Args do
      begin
        TNfeDeclaracaoImportacaoVO(Data).ListaNfeImportacaoDetalheVO.Add(TNfeImportacaoDetalheVO(Obj));
      end
    end);
    (* Fim Listas dos objetos filhos que devem ser deserializadas *)

    Self := Deserializa.Unmarshal(pJsonValue) as TNfeCabecalhoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TNfeCabecalhoVO.Destroy;
begin
  FListaNfeReferenciadaVO.Free;
  FListaNfeNfReferenciadaVO.Free;
  FListaNfeCteReferenciadoVO.Free;
  FListaNfeProdRuralReferenciadaVO.Free;
  FListaNfeCupomFiscalReferenciadoVO.Free;
  FListaNfeDetalheVO.Free;
  FListaNfeDuplicataVO.Free;
  FListaNfeProcessoReferenciadoVO.Free;

  if Assigned(FTributOperacaoFiscalVO) then
    FTributOperacaoFiscalVO.Free;
  if Assigned(FFiscalNotaFiscalEntradaVO) then
    FFiscalNotaFiscalEntradaVO.Free;
  if Assigned(FNfeEmitenteVO) then
    FNfeEmitenteVO.Free;
  if Assigned(FNfeDestinatarioVO) then
    FNfeDestinatarioVO.Free;
  if Assigned(FNfeLocalRetiradaVO) then
    FNfeLocalRetiradaVO.Free;
  if Assigned(FNfeLocalEntregaVO) then
    FNfeLocalEntregaVO.Free;
  if Assigned(FNfeTransporteVO) then
    FNfeTransporteVO.Free;
  if Assigned(FNfeFaturaVO) then
    FNfeFaturaVO.Free;
  if Assigned(FNfeCanaVO) then
    FNfeCanaVO.Free;
  inherited;
end;

function TNfeCabecalhoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    //Lista Nfe Referenciada
    Serializa.RegisterConverter(TNfeCabecalhoVO, 'FListaNfeReferenciadaVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeCabecalhoVO(Data).FListaNfeReferenciadaVO) then
        begin
          SetLength(Result, TNfeCabecalhoVO(Data).FListaNfeReferenciadaVO.Count);
          for I := 0 to TNfeCabecalhoVO(Data).FListaNfeReferenciadaVO.Count - 1 do
          begin
            Result[I] := TNfeCabecalhoVO(Data).FListaNfeReferenciadaVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe NF Referenciada
    Serializa.RegisterConverter(TNfeCabecalhoVO, 'FListaNfeNfReferenciadaVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeCabecalhoVO(Data).FListaNfeNfReferenciadaVO) then
        begin
          SetLength(Result, TNfeCabecalhoVO(Data).FListaNfeNfReferenciadaVO.Count);
          for I := 0 to TNfeCabecalhoVO(Data).FListaNfeNfReferenciadaVO.Count - 1 do
          begin
            Result[I] := TNfeCabecalhoVO(Data).FListaNfeNfReferenciadaVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe CT-e Referenciado
    Serializa.RegisterConverter(TNfeCabecalhoVO, 'FListaNfeCteReferenciadoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeCabecalhoVO(Data).FListaNfeCteReferenciadoVO) then
        begin
          SetLength(Result, TNfeCabecalhoVO(Data).FListaNfeCteReferenciadoVO.Count);
          for I := 0 to TNfeCabecalhoVO(Data).FListaNfeCteReferenciadoVO.Count - 1 do
          begin
            Result[I] := TNfeCabecalhoVO(Data).FListaNfeCteReferenciadoVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe Rural Referenciada
    Serializa.RegisterConverter(TNfeCabecalhoVO, 'FListaNfeProdRuralReferenciadaVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeCabecalhoVO(Data).FListaNfeProdRuralReferenciadaVO) then
        begin
          SetLength(Result, TNfeCabecalhoVO(Data).FListaNfeProdRuralReferenciadaVO.Count);
          for I := 0 to TNfeCabecalhoVO(Data).FListaNfeProdRuralReferenciadaVO.Count - 1 do
          begin
            Result[I] := TNfeCabecalhoVO(Data).FListaNfeProdRuralReferenciadaVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe Cupom Fiscal Referenciado
    Serializa.RegisterConverter(TNfeCabecalhoVO, 'FListaNfeCupomFiscalReferenciadoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeCabecalhoVO(Data).FListaNfeCupomFiscalReferenciadoVO) then
        begin
          SetLength(Result, TNfeCabecalhoVO(Data).FListaNfeCupomFiscalReferenciadoVO.Count);
          for I := 0 to TNfeCabecalhoVO(Data).FListaNfeCupomFiscalReferenciadoVO.Count - 1 do
          begin
            Result[I] := TNfeCabecalhoVO(Data).FListaNfeCupomFiscalReferenciadoVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe Detalhe
    Serializa.RegisterConverter(TNfeCabecalhoVO, 'FListaNfeDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeCabecalhoVO(Data).FListaNfeDetalheVO) then
        begin
          SetLength(Result, TNfeCabecalhoVO(Data).FListaNfeDetalheVO.Count);
          for I := 0 to TNfeCabecalhoVO(Data).FListaNfeDetalheVO.Count - 1 do
          begin
            Result[I] := TNfeCabecalhoVO(Data).FListaNfeDetalheVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe Duplicata
    Serializa.RegisterConverter(TNfeCabecalhoVO, 'FListaNfeDuplicataVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeCabecalhoVO(Data).FListaNfeDuplicataVO) then
        begin
          SetLength(Result, TNfeCabecalhoVO(Data).FListaNfeDuplicataVO.Count);
          for I := 0 to TNfeCabecalhoVO(Data).FListaNfeDuplicataVO.Count - 1 do
          begin
            Result[I] := TNfeCabecalhoVO(Data).FListaNfeDuplicataVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe Processo Referenciado
    Serializa.RegisterConverter(TNfeCabecalhoVO, 'FListaNfeProcessoReferenciadoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeCabecalhoVO(Data).FListaNfeProcessoReferenciadoVO) then
        begin
          SetLength(Result, TNfeCabecalhoVO(Data).FListaNfeProcessoReferenciadoVO.Count);
          for I := 0 to TNfeCabecalhoVO(Data).FListaNfeProcessoReferenciadoVO.Count - 1 do
          begin
            Result[I] := TNfeCabecalhoVO(Data).FListaNfeProcessoReferenciadoVO.Items[I];
          end;
        end;
      end);


    (* Listas dos objetos filhos que devem ser serializadas *)
    //Lista Transporte Reboque
    Serializa.RegisterConverter(TNfeTransporteVO, 'FListaNfeTransporteReboqueVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeTransporteVO(Data).ListaNfeTransporteReboqueVO) then
        begin
          SetLength(Result, TNfeTransporteVO(Data).ListaNfeTransporteReboqueVO.Count);
          for I := 0 to TNfeTransporteVO(Data).ListaNfeTransporteReboqueVO.Count - 1 do
          begin
            Result[I] := TNfeTransporteVO(Data).ListaNfeTransporteReboqueVO.Items[I];
          end;
        end;
      end);

    //Lista Transporte Volumes
    Serializa.RegisterConverter(TNfeTransporteVO, 'FListaNfeTransporteVolumeVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeTransporteVO(Data).ListaNfeTransporteVolumeVO) then
        begin
          SetLength(Result, TNfeTransporteVO(Data).ListaNfeTransporteVolumeVO.Count);
          for I := 0 to TNfeTransporteVO(Data).ListaNfeTransporteVolumeVO.Count - 1 do
          begin
            Result[I] := TNfeTransporteVO(Data).ListaNfeTransporteVolumeVO.Items[I];
          end;
        end;
      end);

    //Lista Lacres
    Serializa.RegisterConverter(TNfeTransporteVolumeVO, 'FListaNfeTransporteVolumeLacreVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeTransporteVolumeVO(Data).ListaNfeTransporteVolumeLacreVO) then
        begin
          SetLength(Result, TNfeTransporteVolumeVO(Data).ListaNfeTransporteVolumeLacreVO.Count);
          for I := 0 to TNfeTransporteVolumeVO(Data).ListaNfeTransporteVolumeLacreVO.Count - 1 do
          begin
            Result[I] := TNfeTransporteVolumeVO(Data).ListaNfeTransporteVolumeLacreVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe Referenciada
    Serializa.RegisterConverter(TNfeDetalheVO, 'FListaNfeDeclaracaoImportacaoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeDetalheVO(Data).ListaNfeDeclaracaoImportacaoVO) then
        begin
          SetLength(Result, TNfeDetalheVO(Data).ListaNfeDeclaracaoImportacaoVO.Count);
          for I := 0 to TNfeDetalheVO(Data).ListaNfeDeclaracaoImportacaoVO.Count - 1 do
          begin
            Result[I] := TNfeDetalheVO(Data).ListaNfeDeclaracaoImportacaoVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe Detalhe
    Serializa.RegisterConverter(TNfeDetalheVO, 'FListaNfeDetEspecificoMedicamentoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeDetalheVO(Data).ListaNfeDetEspecificoMedicamentoVO) then
        begin
          SetLength(Result, TNfeDetalheVO(Data).ListaNfeDetEspecificoMedicamentoVO.Count);
          for I := 0 to TNfeDetalheVO(Data).ListaNfeDetEspecificoMedicamentoVO.Count - 1 do
          begin
            Result[I] := TNfeDetalheVO(Data).ListaNfeDetEspecificoMedicamentoVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe Duplicata
    Serializa.RegisterConverter(TNfeDetalheVO, 'FListaNfeDetEspecificoArmamentoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeDetalheVO(Data).ListaNfeDetEspecificoArmamentoVO) then
        begin
          SetLength(Result, TNfeDetalheVO(Data).ListaNfeDetEspecificoArmamentoVO.Count);
          for I := 0 to TNfeDetalheVO(Data).ListaNfeDetEspecificoArmamentoVO.Count - 1 do
          begin
            Result[I] := TNfeDetalheVO(Data).ListaNfeDetEspecificoArmamentoVO.Items[I];
          end;
        end;
      end);

    //Lista Adições
    Serializa.RegisterConverter(TNfeDeclaracaoImportacaoVO, 'FListaNfeImportacaoDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeDeclaracaoImportacaoVO(Data).ListaNfeImportacaoDetalheVO) then
        begin
          SetLength(Result, TNfeDeclaracaoImportacaoVO(Data).ListaNfeImportacaoDetalheVO.Count);
          for I := 0 to TNfeDeclaracaoImportacaoVO(Data).ListaNfeImportacaoDetalheVO.Count - 1 do
          begin
            Result[I] := TNfeDeclaracaoImportacaoVO(Data).ListaNfeImportacaoDetalheVO.Items[I];
          end;
        end;
      end);
    (* Fim Listas dos objetos filhos que devem ser serializadas *)

    // Campos Transientes
    if Assigned(Self.TributOperacaoFiscalVO) then
      Self.TributOperacaoFiscalDescricao := Self.TributOperacaoFiscalVO.Descricao;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
