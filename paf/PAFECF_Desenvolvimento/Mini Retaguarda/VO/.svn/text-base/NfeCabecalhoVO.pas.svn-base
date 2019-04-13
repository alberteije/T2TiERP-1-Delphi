{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [NFE_CABECALHO]
                                                                                
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
unit NfeCabecalhoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('NFe_Cabecalho')]
  TNfeCabecalhoVO = class
  private
    FID: Integer;
    FID_VENDA_CABECALHO: integer;
    FID_PEDIDO_COMPRA: integer;
    FID_CLIENTE: integer;
    FID_FUNCIONARIO: integer;
    FCODIGO_NUMERICO: string;
    FNATUREZA_OPERACAO: string;
    FINDICADOR_FORMA_PAGAMENTO: string;
    FSERIE: string;
    FCODIGO_MODELO: string;
    FNUMERO: string;
    FDATA_EMISSAO: string;
    FDATA_ENTRADA_SAIDA: string;
    FHORA_ENTRADA_SAIDA: string;
    FTIPO_OPERACAO: string;
    FCODIGO_MUNICIPIO: Integer;
    FFORMATO_IMPRESSAO_DANFE: string;
    FTIPO_EMISSAO: string;
    FCHAVE_ACESSO: string;
    FDIGITO_CHAVE_ACESSO: string;
    FAMBIENTE: string;
    FFINALIDADE_EMISSAO: string;
    FPROCESSO_EMISSAO: string;
    FBASE_CALCULO_ICMS: Double;
    FVERSAO_PROCESSO_EMISSAO: Integer;
    FVALOR_ICMS: Double;
    FBASE_CALCULO_ICMS_ST: double;
    FVALOR_ICMS_ST: Double;
    FVALOR_TOTAL_PRODUTOS: double;
    FVALOR_FRETE: Double;
    FVALOR_SEGURO: Double;
    FVALOR_DESCONTO: double;
    FVALOR_IMPOSTO_IMPORTACAO: Double;
    FVALOR_IPI: Double;
    FVALOR_PIS: Double;
    FVALOR_COFINS: Double;
    FVALOR_DESPESAS_ACESSORIAS: Double;
    FVALOR_SERVICOS: Double;
    FVALOR_TOTAL: Double;
    FBASE_CALCULO_ISSQN: Double;
    FVALOR_ISSQN: Double;
    FVALOR_PIS_ISSQN: Double;
    FVALOR_COFINS_ISSQN: Double;
    FVALOR_RETIDO_PIS: Double;
    FVALOR_RETIDO_COFINS: Double;
    FVALOR_RETIDO_CSLL: Double;
    fBASE_CALCULO_IRRF: Double;
    FVALOR_RETIDO_IRRF: Double;
    FBASE_CALCULO_PREVIDENCIA: Double;
    FVALOR_RETIDO_PREVIDENCIA: Double;
    FUF_EMBARQUE: string;
    FLOCAL_EMBARQUE: string;
    FNOTA_EMPENHO: string;
    FPEDIDO: string;
    FISS_RETIDO: string;
    FINFORMACOES_ADD_FISCO: string;
    FINFORMACOES_COMPLEMENTARES: string;
    FINFORMACOES_ADD_CONTRIBUINTE: string;
    FSITUACAO_NOTA: Integer;

  public

    [Tid('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [Tcolumn('ID_VENDA_CABECALHO','ID Venda',ldGrid, 8)]
    property IdVendaCabecalho: integer read FID_VENDA_CABECALHO write FID_VENDA_CABECALHO;
    [Tcolumn('ID_PEDIDO_COMPRA','ID Pedido',ldGrid,8)]
    property IdPedidoCompra: integer read FID_PEDIDO_COMPRA write FID_PEDIDO_COMPRA;
    [Tcolumn('ID_CLIENTE','ID CLiente',ldGrid,8)]
    property IdCliente: integer read FID_CLIENTE write FID_CLIENTE;
    [Tcolumn('ID_FUNCIONARIO','ID Funcionário',ldGrid,8)]
    property IdFuncionario: integer read FID_FUNCIONARIO write FID_FUNCIONARIO;
    [Tcolumn('CODIGO_NUMERICO','Código Numérico',ldGrid,8)]
    property CodigoNumerico: string read FCODIGO_NUMERICO write FCODIGO_NUMERICO;
    [Tcolumn('NATUREZA_OPERACAO','Natureza',ldGrid,60)]
    property NaturezaOperacao: string read FNATUREZA_OPERACAO write FNATUREZA_OPERACAO;
    [Tcolumn('INDICADOR_FORMA_PAGAMENTO','Forma Pgto',ldGrid,1)]
    property IndicadorFormaPagamento: string read FINDICADOR_FORMA_PAGAMENTO write FINDICADOR_FORMA_PAGAMENTO;
    [Tcolumn('CODIGO_MODELO','Modelo',ldGrid,2)]
    property CodigoModelo: string read FCODIGO_MODELO write FCODIGO_MODELO;
    [Tcolumn('SERIE','Serie',ldGrid,3)]
    property Serie: string read FSERIE write FSERIE;
    [Tcolumn('NUMERO','Numero',ldGrid,9)]
    property Numero: string read FNUMERO write FNUMERO;
    [Tcolumn('DATA_EMISSAO','Data Emissão',ldGrid,12)]
    property DataEmissao: string read FDATA_EMISSAO write FDATA_EMISSAO;
    [Tcolumn('DATA_ENTRADA_SAIDA','Data Entrada/Saída',ldGrid,12)]
    property DataEntradaSaida: string read FDATA_ENTRADA_SAIDA write FDATA_ENTRADA_SAIDA;
    [Tcolumn('HORA_ENTRADA_SAIDA','Hora',ldGrid,8)]
    property HoraEntradaSaida: string read FHORA_ENTRADA_SAIDA write FHORA_ENTRADA_SAIDA;
    [Tcolumn('TIPO_OPERACAO','Operacão',ldGrid,1)]
    property TipoOperacao: string read FTIPO_OPERACAO write FTIPO_OPERACAO;
    [Tcolumn('CODIGO_MUNICIPIO','Operacão',ldGrid,8)]
    property CodigoMunicipio: Integer read FCODIGO_MUNICIPIO write FCODIGO_MUNICIPIO;
    [Tcolumn('FORMATO_IMPRESSAO_DANFE','Formato DANFE',ldGrid,1)]
    property FormatoImpressaoDanfe: string read FFORMATO_IMPRESSAO_DANFE write FFORMATO_IMPRESSAO_DANFE;
    [Tcolumn('TIPO_EMISSAO','Tipo Emissão',ldGrid,1)]
    property TipoEmissao: string read FTIPO_EMISSAO write FTIPO_EMISSAO;
    [Tcolumn('CHAVE_ACESSO','Chave Acesso',ldGrid,44)]
    property ChaveAcesso: string read FCHAVE_ACESSO write FCHAVE_ACESSO;
    [Tcolumn('DIGITO_CHAVE_ACESSO','Digito Chave Acesso',ldGrid,1)]
    property DigitoChaveAcesso: string read FDIGITO_CHAVE_ACESSO write FDIGITO_CHAVE_ACESSO;
    [Tcolumn('AMBIENTE','Ambiente',ldGrid,1)]
    property Ambiente: string read FAMBIENTE write FAMBIENTE;
    [Tcolumn('FINALIDADE_EMISSAO','Finalidade Emissão',ldGrid,1)]
    property FinalidadeEmissao: string read FFINALIDADE_EMISSAO write FFINALIDADE_EMISSAO;
    [Tcolumn('PROCESSO_EMISSAO','Processo Emissão',ldGrid,1)]
    property ProcessoEmissao: string read FPROCESSO_EMISSAO write FPROCESSO_EMISSAO;
    [Tcolumn('VERSAO_PROCESSO_EMISSAO','Versão Processo',ldGrid,8)]
    property VersaoProcessoEmissao: Integer read FVERSAO_PROCESSO_EMISSAO write FVERSAO_PROCESSO_EMISSAO;
    [Tcolumn('BASE_CALCULO_ICMS','Base Cálculo ICMS',ldGrid,10)]
    property BaseCalculoIcms: Double read FBASE_CALCULO_ICMS write FBASE_CALCULO_ICMS;
    [Tcolumn('VALOR_ICMS','Valor ICMS',ldGrid,10)]
    property ValorIcms: Double read FVALOR_ICMS write FVALOR_ICMS;
    [Tcolumn('BASE_CALCULO_ICMS_ST','BC ICMS ST',ldGrid,10)]
    property BaseCalculoIcmsST: double read FBASE_CALCULO_ICMS_ST write FBASE_CALCULO_ICMS_ST;
    [Tcolumn('VALOR_ICMS_ST','Valor ICMS ST',ldGrid,10)]
    property ValorIcmsSt: Double read FVALOR_ICMS_ST write FVALOR_ICMS_ST;
    [Tcolumn('VALOR_TOTAL_PRODUTOS','Total Produtos',ldGrid,10)]
    property ValorTotalProdutos: double read FVALOR_TOTAL_PRODUTOS write FVALOR_TOTAL_PRODUTOS;
    [Tcolumn('VALOR_FRETE','Frete',ldGrid,10)]
    property ValorFrete: Double read FVALOR_FRETE write FVALOR_FRETE;
    [Tcolumn('VALOR_SEGURO','Seguro',ldGrid,10)]
    property ValorSeguro: Double read FVALOR_SEGURO write FVALOR_SEGURO;
    [Tcolumn('VALOR_DESCONTO','Desconto',ldGrid,10)]
    property ValorDesconto: Double read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('VALOR_IMPOSTO_IMPORTACAO','Imposto Importação',ldGrid,10)]
    property ValorImpostoImportacao: Double read FVALOR_IMPOSTO_IMPORTACAO write FVALOR_IMPOSTO_IMPORTACAO;
    [TColumn('VALOR_IPI','Valor IPI',ldGrid,10)]
    property ValorIpi: Double read FVALOR_IPI write FVALOR_IPI;
    [TColumn('VALOR_PIS','Valor PIS',ldGrid,10)]
    property ValorPis: Double read FVALOR_PIS write FVALOR_PIS;
    [TColumn('VALOR_COFINS','Valor COFINS',ldGrid,10)]
    property ValorCofins: Double read FVALOR_COFINS write FVALOR_COFINS;
    [TColumn('VALOR_DESPESAS_ACESSORIAS','Despesas Acessórias',ldGrid,10)]
    property ValorDespesasAcessorias: Double read FVALOR_DESPESAS_ACESSORIAS write FVALOR_DESPESAS_ACESSORIAS;
    [TColumn('VALOR_TOTAL','VALOR TOTAL',ldGrid,10)]
    property ValorTotal: Double read FVALOR_TOTAL write FVALOR_TOTAL;
    [Tcolumn('VALOR_SERVICOS','Valor Serviços',ldGrid,10)]
    property ValorServicos: Double read FVALOR_SERVICOS write FVALOR_SERVICOS;
    [TColumn('BASE_CALCULO_ISSQN','BC ISSQN',ldGrid,10)]
    property BaseCalculoIssqn: Double read FBASE_CALCULO_ISSQN write FBASE_CALCULO_ISSQN;
    [TColumn('VALOR_ISSQN','Valor ISSQN',ldGrid,10)]
    property ValorIssqn: Double read FVALOR_ISSQN write FVALOR_ISSQN;
    [TColumn('VALOR_PIS_ISSQN','Valor PIS ISSQN',ldGrid,10)]
    property ValorPisIssqn: Double read FVALOR_PIS_ISSQN write FVALOR_PIS_ISSQN;
    [TColumn('VALOR_COFINS_ISSQN','Valor COFINS ISSQN',ldGrid,10)]
    property ValorCofinsIssqn: Double read FVALOR_COFINS_ISSQN write FVALOR_COFINS_ISSQN;
    [TColumn('VALOR_RETIDO_PIS','Valor Retido PIS',ldGrid,10)]
    property ValorRetidoPis: Double read FVALOR_RETIDO_PIS write FVALOR_RETIDO_PIS;
    [TColumn('VALOR_RETIDO_COFINS','Valor Retido COFINS',ldGrid,10)]
    property ValorRetidoCofins: Double read FVALOR_RETIDO_COFINS write FVALOR_RETIDO_COFINS;
    [TColumn('VALOR_RETIDO_CSLL','Valor Retido CSLL',ldGrid,10)]
    property ValorRetidoCsll: Double read FVALOR_RETIDO_CSLL write FVALOR_RETIDO_CSLL;
    [TColumn('BASE_CALCULO_IRRF','BC IRRF',ldGrid,10)]
    property BaseCalculoIrrf: Double read fBASE_CALCULO_IRRF write FBASE_CALCULO_IRRF;
    [TColumn('VALOR_RETIDO_IRRF','Valor Retido IRRF',ldGrid,10)]
    property ValorRetidoIrrf: Double read FVALOR_RETIDO_IRRF write FVALOR_RETIDO_IRRF;
    [TColumn('BASE_CALCULO_PREVIDENCIA','BC Previdência',ldGrid,10)]
    property BaseCalculoPrevidencia: Double read FBASE_CALCULO_PREVIDENCIA write FBASE_CALCULO_PREVIDENCIA;
    [TColumn('VALOR_RETIDO_PREVIDENCIA','Valor Retido Previdência')]
    property ValorRetidoPrevidencia: Double read FVALOR_RETIDO_PREVIDENCIA write FVALOR_RETIDO_PREVIDENCIA;
    [TColumn('UF_EMBARQUE','UF Embarque',ldGrid,2)]
    property UfEmbarque: string read FUF_EMBARQUE write FUF_EMBARQUE;
    [TColumn('LOCAL_EMBARQUE','Local Embarque',ldGrid,60)]
    property LocalEmbarque: string read FLOCAL_EMBARQUE write FLOCAL_EMBARQUE;
    [TColumn('NOTA_EMPENHO','Empenho',ldGrid,17)]
    property NotaEmpenho: string read FNOTA_EMPENHO write FNOTA_EMPENHO;
    [TColumn('PEDIDO','Pedido',ldGrid,60)]
    property Pedido: string read FPEDIDO write FPEDIDO;
    [TColumn('ISS_RETIDO','ISS Retido',ldGrid,1)]
    property IssRetido: string read FISS_RETIDO write FISS_RETIDO;
    [TColumn('INFORMACOES_ADD_FISCO','Informações ao Fisco',ldGrid,100)]
    property InformacoesAddFisco: string read FINFORMACOES_ADD_FISCO write FINFORMACOES_ADD_FISCO;
    [TColumn('INFORMACOES_ADD_CONTRIBUINTE','Informações ao Contribuinte',ldGrid,100)]
    property InformacoesAddContribuinte: string read FINFORMACOES_ADD_CONTRIBUINTE write FINFORMACOES_ADD_CONTRIBUINTE;
    [TColumn('INFORMACOES_COMPLEMENTARES','Informações Complementares',ldGrid,100)]
    property InformacoesComplementares: string read FINFORMACOES_COMPLEMENTARES write FINFORMACOES_COMPLEMENTARES;
    [TColumn('SITUACAO_NOTA','Situação',ldGrid,1)]
    property SituacaoNota: Integer read FSITUACAO_NOTA write FSITUACAO_NOTA;

  end;

implementation



end.
