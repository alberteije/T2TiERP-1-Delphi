{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [EcfConfiguracao]
                                                                                
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
                                                                                
@author  Marcos Leite
@version 1.0                                                                    
*******************************************************************************}
unit EcfConfiguracaoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('ECF_CONFIGURACAO')]
  TEcfConfiguracaoVO = class
  private
    FID: Integer;
    FNOME_CAIXA: String;
    FID_GERADO_CAIXA: Integer;
    FID_EMPRESA: Integer;
    FID_ECF_IMPRESSORA: Integer;
    FID_ECF_RESOLUCAO: Integer;
    FID_ECF_CAIXA: Integer;
    FID_ECF_EMPRESA: Integer;
    FMENSAGEM_CUPOM: String;
    FPORTA_ECF: String;
    FIP_SERVIDOR: String;
    FIP_SITEF: String;
    FTIPO_TEF: String;
    FTITULO_TELA_CAIXA: String;
    FCAMINHO_IMAGENS_PRODUTOS: String;
    FCAMINHO_IMAGENS_MARKETING: String;
    FCAMINHO_IMAGENS_LAYOUT: String;
    FCOR_JANELAS_INTERNAS: String;
    FMARKETING_ATIVO: String;
    FCFOP_ECF: Integer;
    FCFOP_NF2: Integer;
    FTIMEOUT_ECF: Integer;
    FINTERVALO_ECF: Integer;
    FDESCRICAO_SUPRIMENTO: String;
    FDESCRICAO_SANGRIA: String;
    FTEF_TIPO_GP: Integer;
    FTEF_TEMPO_ESPERA: Integer;
    FTEF_ESPERA_STS: Integer;
    FTEF_NUMERO_VIAS: Integer;
    FDECIMAIS_QUANTIDADE: Integer;
    FDECIMAIS_VALOR: Integer;
    FBITS_POR_SEGUNDO: Integer;
    FQTDE_MAXIMA_CARTOES: Integer;
    FPESQUISA_PARTE: String;
    FCONFIGURACAO_BALANCA: String;
    FPARAMETROS_DIVERSOS: String;
    FULTIMA_EXCLUSAO: Integer;
    FINDICE_GERENCIAL: String;
    FLAUDO: String;
    FDATA_ATUALIZACAO_ESTOQUE: String;
    FDATA_SINCRONIZACAO: String;
    FHORA_SINCRONIZACAO: String;

  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('NOME_CAIXA','Nome Caixa',ldGridLookup ,False)]
    property NomeCaixa: String  read FNOME_CAIXA write FNOME_CAIXA;
    [TColumn('ID_GERADO_CAIXA','Id Gerado Caixa',ldGridLookup ,False)]
    property IdGeradoCaixa: Integer  read FID_GERADO_CAIXA write FID_GERADO_CAIXA;
    [TColumn('ID_EMPRESA','Id Empresa',ldGridLookup ,False)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('ID_ECF_IMPRESSORA','Id Ecf Impressora',ldGridLookup ,False)]
    property IdEcfImpressora: Integer  read FID_ECF_IMPRESSORA write FID_ECF_IMPRESSORA;
    [TColumn('ID_ECF_RESOLUCAO','Id Ecf Resolucao',ldGridLookup ,False)]
    property IdEcfResolucao: Integer  read FID_ECF_RESOLUCAO write FID_ECF_RESOLUCAO;
    [TColumn('ID_ECF_CAIXA','Id Ecf Caixa',ldGridLookup ,False)]
    property IdEcfCaixa: Integer  read FID_ECF_CAIXA write FID_ECF_CAIXA;
    [TColumn('ID_ECF_EMPRESA','Id Ecf Empresa',ldGridLookup ,False)]
    property IdEcfEmpresa: Integer  read FID_ECF_EMPRESA write FID_ECF_EMPRESA;
    [TColumn('MENSAGEM_CUPOM','Mensagem Cupom',ldGridLookup ,False)]
    property MensagemCupom: String  read FMENSAGEM_CUPOM write FMENSAGEM_CUPOM;
    [TColumn('PORTA_ECF','Porta Ecf',ldGridLookup ,False)]
    property PortaEcf: String  read FPORTA_ECF write FPORTA_ECF;
    [TColumn('IP_SERVIDOR','Ip Servidor',ldGridLookup ,False)]
    property IpServidor: String  read FIP_SERVIDOR write FIP_SERVIDOR;
    [TColumn('IP_SITEF','Ip Sitef',ldGridLookup ,False)]
    property IpSitef: String  read FIP_SITEF write FIP_SITEF;
    [TColumn('TIPO_TEF','Tipo Tef',ldGridLookup ,False)]
    property TipoTef: String  read FTIPO_TEF write FTIPO_TEF;
    [TColumn('TITULO_TELA_CAIXA','Titulo Tela Caixa',ldGridLookup ,False)]
    property TituloTelaCaixa: String  read FTITULO_TELA_CAIXA write FTITULO_TELA_CAIXA;
    [TColumn('CAMINHO_IMAGENS_PRODUTOS','Caminho Imagens Produtos',ldGridLookup ,False)]
    property CaminhoImagensProdutos: String  read FCAMINHO_IMAGENS_PRODUTOS write FCAMINHO_IMAGENS_PRODUTOS;
    [TColumn('CAMINHO_IMAGENS_MARKETING','Caminho Imagens Marketing',ldGridLookup ,False)]
    property CaminhoImagensMarketing: String  read FCAMINHO_IMAGENS_MARKETING write FCAMINHO_IMAGENS_MARKETING;
    [TColumn('CAMINHO_IMAGENS_LAYOUT','Caminho Imagens Layout',ldGridLookup ,False)]
    property CaminhoImagensLayout: String  read FCAMINHO_IMAGENS_LAYOUT write FCAMINHO_IMAGENS_LAYOUT;
    [TColumn('COR_JANELAS_INTERNAS','Cor Janelas Internas',ldGridLookup ,False)]
    property CorJanelasInternas: String  read FCOR_JANELAS_INTERNAS write FCOR_JANELAS_INTERNAS;
    [TColumn('MARKETING_ATIVO','Marketing Ativo',ldGridLookup ,False)]
    property MarketingAtivo: String  read FMARKETING_ATIVO write FMARKETING_ATIVO;
    [TColumn('CFOP_ECF','Cfop Ecf',ldGridLookup ,False)]
    property CfopEcf: Integer  read FCFOP_ECF write FCFOP_ECF;
    [TColumn('CFOP_NF2','Cfop Nf2',ldGridLookup ,False)]
    property CfopNf2: Integer  read FCFOP_NF2 write FCFOP_NF2;
    [TColumn('TIMEOUT_ECF','Timeout Ecf',ldGridLookup ,False)]
    property TimeoutEcf: Integer  read FTIMEOUT_ECF write FTIMEOUT_ECF;
    [TColumn('INTERVALO_ECF','Intervalo Ecf',ldGridLookup ,False)]
    property IntervaloEcf: Integer  read FINTERVALO_ECF write FINTERVALO_ECF;
    [TColumn('DESCRICAO_SUPRIMENTO','Descricao Suprimento',ldGridLookup ,False)]
    property DescricaoSuprimento: String  read FDESCRICAO_SUPRIMENTO write FDESCRICAO_SUPRIMENTO;
    [TColumn('DESCRICAO_SANGRIA','Descricao Sangria',ldGridLookup ,False)]
    property DescricaoSangria: String  read FDESCRICAO_SANGRIA write FDESCRICAO_SANGRIA;
    [TColumn('TEF_TIPO_GP','Tef Tipo Gp',ldGridLookup ,False)]
    property TefTipoGp: Integer  read FTEF_TIPO_GP write FTEF_TIPO_GP;
    [TColumn('TEF_TEMPO_ESPERA','Tef Tempo Espera',ldGridLookup ,False)]
    property TefTempoEspera: Integer  read FTEF_TEMPO_ESPERA write FTEF_TEMPO_ESPERA;
    [TColumn('TEF_ESPERA_STS','Tef Espera Sts',ldGridLookup ,False)]
    property TefEsperaSts: Integer  read FTEF_ESPERA_STS write FTEF_ESPERA_STS;
    [TColumn('TEF_NUMERO_VIAS','Tef Numero Vias',ldGridLookup ,False)]
    property TefNumeroVias: Integer  read FTEF_NUMERO_VIAS write FTEF_NUMERO_VIAS;
    [TColumn('DECIMAIS_QUANTIDADE','Decimais Quantidade',ldGridLookup ,False)]
    property DecimaisQuantidade: Integer  read FDECIMAIS_QUANTIDADE write FDECIMAIS_QUANTIDADE;
    [TColumn('DECIMAIS_VALOR','Decimais Valor',ldGridLookup ,False)]
    property DecimaisValor: Integer  read FDECIMAIS_VALOR write FDECIMAIS_VALOR;
    [TColumn('BITS_POR_SEGUNDO','Bits Por Segundo',ldGridLookup ,False)]
    property BitsPorSegundo: Integer  read FBITS_POR_SEGUNDO write FBITS_POR_SEGUNDO;
    [TColumn('QTDE_MAXIMA_CARTOES','Qtde Maxima Cartoes',ldGridLookup ,False)]
    property QtdeMaximaCartoes: Integer  read FQTDE_MAXIMA_CARTOES write FQTDE_MAXIMA_CARTOES;
    [TColumn('PESQUISA_PARTE','Pesquisa Parte',ldGridLookup ,False)]
    property PesquisaParte: String  read FPESQUISA_PARTE write FPESQUISA_PARTE;
    [TColumn('CONFIGURACAO_BALANCA','Configuracao Balanca',ldGridLookup ,False)]
    property ConfiguracaoBalanca: String  read FCONFIGURACAO_BALANCA write FCONFIGURACAO_BALANCA;
    [TColumn('PARAMETROS_DIVERSOS','Parametros Diversos',ldGridLookup ,False)]
    property ParametrosDiversos: String  read FPARAMETROS_DIVERSOS write FPARAMETROS_DIVERSOS;
    [TColumn('ULTIMA_EXCLUSAO','Ultima Exclusao',ldGridLookup ,False)]
    property UltimaExclusao: Integer  read FULTIMA_EXCLUSAO write FULTIMA_EXCLUSAO;
    [TColumn('LAUDO','Laudo',ldGridLookup ,False)]
    property Laudo: String  read FLAUDO write FLAUDO;
    [TColumn('INDICE_GERENCIAL','Indice Gerencial',ldGridLookup ,False)]
    property IndiceGerencial: String  read FINDICE_GERENCIAL write FINDICE_GERENCIAL;
    [TColumn('DATA_ATUALIZACAO_ESTOQUE','Data Atualizacao Estoque',ldGridLookup ,False)]
    property DataAtualizacaoEstoque: String  read FDATA_ATUALIZACAO_ESTOQUE write FDATA_ATUALIZACAO_ESTOQUE;
    [TColumn('DATA_SINCRONIZACAO','Data Sincronizacao',ldGridLookup ,False)]
    property DataSincronizacao: String  read FDATA_SINCRONIZACAO write FDATA_SINCRONIZACAO;
    [TColumn('HORA_SINCRONIZACAO','Hora Sincronizacao',ldGridLookup ,False)]
    property HoraSincronizacao: String  read FHORA_SINCRONIZACAO write FHORA_SINCRONIZACAO;

  end;

implementation



end.
