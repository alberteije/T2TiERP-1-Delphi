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
  NfeCupomFiscalVO;

type
  TNfeCabecalhoVO = class
  private
    FID: Integer;
    FID_VENDA_CABECALHO: Integer;
    FID_PEDIDO_COMPRA: Integer;
    FID_CLIENTE: Integer;
    FID_FUNCIONARIO: Integer;
    FCODIGO_NUMERICO: String;
    FNATUREZA_OPERACAO: String;
    FINDICADOR_FORMA_PAGAMENTO: String;
    FCODIGO_MODELO: String;
    FSERIE: String;
    FNUMERO: String;
    FDATA_EMISSAO: String;
    FDATA_ENTRADA_SAIDA: String;
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
    FVERSAO_PROCESSO_EMISSAO: Integer;
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
    FUF_EMBARQUE: String;
    FLOCAL_EMBARQUE: String;
    FNOTA_EMPENHO: String;
    FPEDIDO: String;
    FISS_RETIDO: String;
    FINFORMACOES_ADD_FISCO: String;
    FINFORMACOES_ADD_CONTRIBUINTE: String;
    FINFORMACOES_COMPLEMENTARES: String;

    FCupomVinculado: Boolean;
    FNfeCupomFiscalVO: TNfeCupomFiscalVO;

  public 
    property Id: Integer  read FID write FID;
    property IdVendaCabecalho: Integer  read FID_VENDA_CABECALHO write FID_VENDA_CABECALHO;
    property IdPedidoCompra: Integer  read FID_PEDIDO_COMPRA write FID_PEDIDO_COMPRA;
    property IdCliente: Integer  read FID_CLIENTE write FID_CLIENTE;
    property IdFuncionario: Integer  read FID_FUNCIONARIO write FID_FUNCIONARIO;
    property CodigoNumerico: String  read FCODIGO_NUMERICO write FCODIGO_NUMERICO;
    property NaturezaOperacao: String  read FNATUREZA_OPERACAO write FNATUREZA_OPERACAO;
    property IndicadorFormaPagamento: String  read FINDICADOR_FORMA_PAGAMENTO write FINDICADOR_FORMA_PAGAMENTO;
    property CodigoModelo: String  read FCODIGO_MODELO write FCODIGO_MODELO;
    property Serie: String  read FSERIE write FSERIE;
    property Numero: String  read FNUMERO write FNUMERO;
    property DataEmissao: String  read FDATA_EMISSAO write FDATA_EMISSAO;
    property DataEntradaSaida: String  read FDATA_ENTRADA_SAIDA write FDATA_ENTRADA_SAIDA;
    property HoraEntradaSaida: String  read FHORA_ENTRADA_SAIDA write FHORA_ENTRADA_SAIDA;
    property TipoOperacao: String  read FTIPO_OPERACAO write FTIPO_OPERACAO;
    property CodigoMunicipio: Integer  read FCODIGO_MUNICIPIO write FCODIGO_MUNICIPIO;
    property FormatoImpressaoDanfe: String  read FFORMATO_IMPRESSAO_DANFE write FFORMATO_IMPRESSAO_DANFE;
    property TipoEmissao: String  read FTIPO_EMISSAO write FTIPO_EMISSAO;
    property ChaveAcesso: String  read FCHAVE_ACESSO write FCHAVE_ACESSO;
    property DigitoChaveAcesso: String  read FDIGITO_CHAVE_ACESSO write FDIGITO_CHAVE_ACESSO;
    property Ambiente: String  read FAMBIENTE write FAMBIENTE;
    property FinalidadeEmissao: String  read FFINALIDADE_EMISSAO write FFINALIDADE_EMISSAO;
    property ProcessoEmissao: String  read FPROCESSO_EMISSAO write FPROCESSO_EMISSAO;
    property VersaoProcessoEmissao: Integer  read FVERSAO_PROCESSO_EMISSAO write FVERSAO_PROCESSO_EMISSAO;
    property BaseCalculoIcms: Extended  read FBASE_CALCULO_ICMS write FBASE_CALCULO_ICMS;
    property ValorIcms: Extended  read FVALOR_ICMS write FVALOR_ICMS;
    property BaseCalculoIcmsSt: Extended  read FBASE_CALCULO_ICMS_ST write FBASE_CALCULO_ICMS_ST;
    property ValorIcmsSt: Extended  read FVALOR_ICMS_ST write FVALOR_ICMS_ST;
    property ValorTotalProdutos: Extended  read FVALOR_TOTAL_PRODUTOS write FVALOR_TOTAL_PRODUTOS;
    property ValorFrete: Extended  read FVALOR_FRETE write FVALOR_FRETE;
    property ValorSeguro: Extended  read FVALOR_SEGURO write FVALOR_SEGURO;
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    property ValorImpostoImportacao: Extended  read FVALOR_IMPOSTO_IMPORTACAO write FVALOR_IMPOSTO_IMPORTACAO;
    property ValorIpi: Extended  read FVALOR_IPI write FVALOR_IPI;
    property ValorPis: Extended  read FVALOR_PIS write FVALOR_PIS;
    property ValorCofins: Extended  read FVALOR_COFINS write FVALOR_COFINS;
    property ValorDespesasAcessorias: Extended  read FVALOR_DESPESAS_ACESSORIAS write FVALOR_DESPESAS_ACESSORIAS;
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    property ValorServicos: Extended  read FVALOR_SERVICOS write FVALOR_SERVICOS;
    property BaseCalculoIssqn: Extended  read FBASE_CALCULO_ISSQN write FBASE_CALCULO_ISSQN;
    property ValorIssqn: Extended  read FVALOR_ISSQN write FVALOR_ISSQN;
    property ValorPisIssqn: Extended  read FVALOR_PIS_ISSQN write FVALOR_PIS_ISSQN;
    property ValorCofinsIssqn: Extended  read FVALOR_COFINS_ISSQN write FVALOR_COFINS_ISSQN;
    property ValorRetidoPis: Extended  read FVALOR_RETIDO_PIS write FVALOR_RETIDO_PIS;
    property ValorRetidoCofins: Extended  read FVALOR_RETIDO_COFINS write FVALOR_RETIDO_COFINS;
    property ValorRetidoCsll: Extended  read FVALOR_RETIDO_CSLL write FVALOR_RETIDO_CSLL;
    property BaseCalculoIrrf: Extended  read FBASE_CALCULO_IRRF write FBASE_CALCULO_IRRF;
    property ValorRetidoIrrf: Extended  read FVALOR_RETIDO_IRRF write FVALOR_RETIDO_IRRF;
    property BaseCalculoPrevidencia: Extended  read FBASE_CALCULO_PREVIDENCIA write FBASE_CALCULO_PREVIDENCIA;
    property ValorRetidoPrevidencia: Extended  read FVALOR_RETIDO_PREVIDENCIA write FVALOR_RETIDO_PREVIDENCIA;
    property UfEmbarque: String  read FUF_EMBARQUE write FUF_EMBARQUE;
    property LocalEmbarque: String  read FLOCAL_EMBARQUE write FLOCAL_EMBARQUE;
    property NotaEmpenho: String  read FNOTA_EMPENHO write FNOTA_EMPENHO;
    property Pedido: String  read FPEDIDO write FPEDIDO;
    property IssRetido: String  read FISS_RETIDO write FISS_RETIDO;
    property InformacoesAddFisco: String  read FINFORMACOES_ADD_FISCO write FINFORMACOES_ADD_FISCO;
    property InformacoesAddContribuinte: String  read FINFORMACOES_ADD_CONTRIBUINTE write FINFORMACOES_ADD_CONTRIBUINTE;
    property InformacoesComplementares: String  read FINFORMACOES_COMPLEMENTARES write FINFORMACOES_COMPLEMENTARES;

    property CupomVinculado: Boolean  read FCupomVinculado write FCupomVinculado;
    property NfeCupomFiscalVO: TNfeCupomFiscalVO  read FNfeCupomFiscalVO write FNfeCupomFiscalVO;

  end;

implementation



end.
