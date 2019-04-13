{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 20/08/2009: Caique Rodrigues
|*  - Doação units para geração do Danfe via QuickReport
|* 20/11/2009: Peterson de Cerqueira Matos
|*             E-mail: peterson161@yahoo.com - Tel: (11) 7197-1474 / 8059-4055
|*  - Componente e Units do QuickReport clonados
|*    e transformados em FORTES REPORT
|* 27/01/2010: Peterson de Cerqueira Matos
|*  - Inclusão de comandos na procedure "InitDados" para ajuste da largura da
|*    coluna "Código do Produto" que foi definida no componente "ACBrNFeDANFeRL"
|*  - Em casos de DANFE's com mais de uma página, a partir da segunda o canhoto
|*    nao é mais exibido
|* 05/02/2010: Peterson de Cerqueira Matos
|*  - Alteração da quantidade de casas decimais dos campos 'QUANTIDADE' e
|*    'VALOR UNITÁRIO' para 4 casas, conforme consta no 'MANUAL DE INTEGRAÇÃO
|*    DO CONTRIBUINTE'
|*  - Correção na distribuição dos caracteres entre os 'DADOS ADICIONAIS' e a
|*    'CONTINUAÇÃO DOS DADOS ADICIONAIS'
|*  - Inclusão dos campos 'USUÁRIO' e 'SISTEMA' no rodapé do DANFE (só folha 1)
|*  - Inclusão dos campos 'SITE', 'EMAIL' e 'FAX' no quadro do emitente
|*  - Inclusão do 'RESUMO' da NF-e no canhoto
|* 10/02/2010: Peterson de Cerqueira Matos
|*  - Inserção da função 'BuscaDireita', que auxiliará a correção da
|*    exibição dos 'DADOS ADICIONAIS' para evitar que a última palavra do
|*    quadro fique pela metade devido à limitação da quantidade de caracteres
|*  - Correção da formatação de CPF, no caso de NF-e emitida para pessoa física
|* 13/02/2010: Peterson de Cerqueira Matos
|*  - Alteração da fonte do memo 'rlmObsItem' de ARIAL para COURIER NEW
|* 15/03/2010: Felipe Feltes
|*  - Adequação na seção 'USES' para ser utilizado em CLX
|* 19/03/2010: Peterson de Cerqueira Matos
|*  - Tratamento das propriedades "FormularioContinuo", "ExpandirLogoMarca" e
|*    "MostrarPreview" de "ACBrNFeDANFeClass"
|*  - Tratamento da propriedade "PosCanhoto" de "ACBrNFeDANFeRLClass"
|* 22/03/2010: Peterson de Cerqueira Matos
|*  - Tratamento das margens em "ACBrNFeDANFeClass"
|*  - Tratamento da propriedade "FonteDANFE" de "ACBrNFeDANFeRLClass"
|* 13/04/2010: Peterson de Cerqueira Matos
|*  - Adequação à NF-e 2.0, Manual de Integração do Contribuinte 4.0.1NT2009.006
|*  - Tratamento das propriedades "_vUnCom" e "_qCom"
|*  - Exibição da "hora de saída"
|*  - Ocultação do quadro "FATURA" quando não houver duplicatas
|*  - Correção na exibição das informações complementares
|*  - Correção na exibição do tipo de frete
|*  - Acréscimo da coluna "Valor Desconto"
|*  - Correção na exibição da coluna CST. Quando o emitente for "Simples
|*    Nacional - CRT=1", será exibida a informação CSOSN ao invés do CST
|*  - Alteração no layout do quadro "IDENTIFICAÇÃO DO EMITENTE"
|* 26/04/2010: Peterson de Cerqueira Matos
|*  - Adaptação dos comandos que utilizavam CSOSN string para CSOSN tipificado
|* 19/06/2010: Peterson de Cerqueira Matos
|*  - Admissão de quebra de linha nos dados adicionais do produto (infAdProd).
|*    O Caractere ponto-e-vírgula ';' será considerado quebra de linha
|* 07/07/2010: Peteron de Cerqueira Matos
|*  - Início do DANFe em formato Paisagem
|* 20/07/2010: Peteron de Cerqueira Matos
|*  - Acréscimo do case 0 na configuração das casas decimais da quantidade
|*    e do valor unitário
|* 28/07/2010: Peterson de Cerqueira Matos
|*  - Implementação da quantidade de itens por página
|*  - Admissão de quebra de linha nas informações complementares.
|*    O Caractere ponto-e-vírgula ';' será considerado quebra de linha
|* 10/08/2010: Peterson de Cerqueira Matos
|*  - Tratamento do tamanho da fonte da razão social do emitente
|* 25/11/2010: Peterson de Cerqueira Matos
|*  - Acréscimo da coluna "EAN"
|* 01/03/2011: Fernando Emiliano David Nunes
|*  - Quando DPEC, nao estava imprimindo Data e Motivo da Contingência
|*  - Quando DPEC, nao estava imprimindo o valor FProtocoloNFe
|* 24/03/2011: Fernando Emiliano David Nunes
|*  - Alterei a funcao FormatarFone para tratar casos onde o DDD vem com ZERO somando 3 digitos
|* 18/05/2011: Peterson de Cerqueira Matos
|*  - Correção da exibição das duplicatas. As duplicatas são exibidas da direita
|*    para a esquerda, até o limite de 15 duplicatas. Desta forma a altura do
|*    quadro duplicatas fica variável, de acordo com a quantidade de linhas. O
|*    limite de duplicatas não foi aumentado para preservar o pouco espaço
|*    disponível para os itens da nota
|* 20/05/2011: Peterson de Cerqueira Matos
|*  - Tratamento da propriedade "ExibirResumoCanhoto_Texto"
|* 23/05/2011: Waldir Paim
|*  - Início da preparação para Lazarus: Somente utiliza TClientDataSet quando
|*    estiver no Delphi. Obrigatória a utilização da versão 3.70B ou superior
|*    do Fortes Report. Download disponível em
|*    http://sourceforge.net/projects/fortesreport/files/
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeRLPaisagem;

interface

uses
  SysUtils, Variants, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QExtCtrls, Qt, QStdCtrls,
  {$ELSE}
  Windows, Messages, Graphics, Controls, Forms, Dialogs, ExtCtrls, MaskUtils, StdCtrls,
  {$ENDIF}
  RLReport, RLFilters, RLPDFFilter, XMLIntf, XMLDoc,
  ACBrNFeDANFeRL, pcnConversao, RLBarcode, jpeg, DB, StrUtils;

type
  TfrlDANFeRLPaisagem = class(TfrlDANFeRL)
    rlbEmitente: TRLBand;
    rliEmitente: TRLDraw;
    rliNatOpe: TRLDraw;
    rliChave: TRLDraw;
    rliNatOpe1: TRLDraw;
    RLDraw9: TRLDraw;
    RLDraw10: TRLDraw;
    rllDANFE: TRLLabel;
    rllDocumento1: TRLLabel;
    rllDocumento2: TRLLabel;
    rllTipoEntrada: TRLLabel;
    rllTipoSaida: TRLLabel;
    rliTipoEntrada: TRLDraw;
    rllEntradaSaida: TRLLabel;
    rllNumNF1: TRLLabel;
    rllSERIE1: TRLLabel;
    rliChave2: TRLDraw;
    rliChave3: TRLDraw;
    rlbCodigoBarras: TRLBarcode;
    rlbCabecalhoItens: TRLBand;
    rlbDadosAdicionais: TRLBand;
    RLDraw50: TRLDraw;
    RLDraw51: TRLDraw;
    rllChaveAcesso: TRLLabel;
    rllDadosVariaveis1a: TRLLabel;
    rllDadosVariaveis1b: TRLLabel;
    rllDadosVariaveis3_Descricao: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel77: TRLLabel;
    RLLabel78: TRLLabel;
    rlmEmitente: TRLMemo;
    rlmEndereco: TRLMemo;
    rllFone: TRLLabel;
    rliLogo: TRLImage;
    rllNatOperacao: TRLLabel;
    rllDadosVariaveis3: TRLLabel;
    rllInscricaoEstadual: TRLLabel;
    rllInscrEstSubst: TRLLabel;
    rllCNPJ: TRLLabel;
    rlmDadosAdicionais: TRLMemo;
    rllChave: TRLLabel;
    rllEmitente: TRLLabel;
    rlbCodigoBarrasFS: TRLBarcode;
    rllXmotivo: TRLLabel;
    rlbDestinatario: TRLBand;
    RLLabel32: TRLLabel;
    rllDestNome: TRLLabel;
    RLLabel35: TRLLabel;
    rllDestEndereco: TRLLabel;
    RLLabel39: TRLLabel;
    rllDestCidade: TRLLabel;
    RLLabel40: TRLLabel;
    rllDestFone: TRLLabel;
    RLLabel36: TRLLabel;
    rllDestBairro: TRLLabel;
    RLLabel41: TRLLabel;
    rllDestUF: TRLLabel;
    RLLabel33: TRLLabel;
    rllDestCNPJ: TRLLabel;
    RLLabel37: TRLLabel;
    rllDestCEP: TRLLabel;
    RLLabel42: TRLLabel;
    rllDestIE: TRLLabel;
    RLLabel34: TRLLabel;
    rllEmissao: TRLLabel;
    RLLabel38: TRLLabel;
    rllSaida: TRLLabel;
    RLLabel43: TRLLabel;
    rllHoraSaida: TRLLabel;
    RLDraw16: TRLDraw;
    RLDraw17: TRLDraw;
    RLDraw22: TRLDraw;
    RLDraw23: TRLDraw;
    RLDraw20: TRLDraw;
    RLDraw19: TRLDraw;
    RLDraw24: TRLDraw;
    RLDraw21: TRLDraw;
    RLDraw18: TRLDraw;
    RLDraw15: TRLDraw;
    rlbFatura: TRLBand;
    rllFatNum1: TRLLabel;
    rllFatNum6: TRLLabel;
    rllFatNum11: TRLLabel;
    rllFatData1: TRLLabel;
    rllFatData6: TRLLabel;
    rllFatData11: TRLLabel;
    rllFatValor1: TRLLabel;
    rllFatValor6: TRLLabel;
    rllFatValor11: TRLLabel;
    rllFatNum2: TRLLabel;
    rllFatNum7: TRLLabel;
    rllFatNum12: TRLLabel;
    rllFatData2: TRLLabel;
    rllFatData7: TRLLabel;
    rllFatData12: TRLLabel;
    rllFatValor2: TRLLabel;
    rllFatValor7: TRLLabel;
    rllFatValor12: TRLLabel;
    rllFatNum3: TRLLabel;
    rllFatNum8: TRLLabel;
    rllFatNum13: TRLLabel;
    rllFatData3: TRLLabel;
    rllFatData8: TRLLabel;
    rllFatData13: TRLLabel;
    rllFatValor3: TRLLabel;
    rllFatValor8: TRLLabel;
    rllFatValor13: TRLLabel;
    rllFatNum4: TRLLabel;
    rllFatNum9: TRLLabel;
    rllFatNum14: TRLLabel;
    rllFatData4: TRLLabel;
    rllFatData9: TRLLabel;
    rllFatData14: TRLLabel;
    rllFatValor4: TRLLabel;
    rllFatValor9: TRLLabel;
    rllFatValor14: TRLLabel;
    rliFatura2: TRLDraw;
    rliFatura3: TRLDraw;
    rliFatura4: TRLDraw;
    rliFatura: TRLDraw;
    rlbImposto: TRLBand;
    RLLabel44: TRLLabel;
    rllBaseICMS: TRLLabel;
    RLLabel49: TRLLabel;
    rllValorFrete: TRLLabel;
    RLLabel45: TRLLabel;
    rllValorICMS: TRLLabel;
    RLLabel50: TRLLabel;
    rllValorSeguro: TRLLabel;
    RLLabel51: TRLLabel;
    rllDescontos: TRLLabel;
    RLLabel46: TRLLabel;
    rllBaseICMST: TRLLabel;
    RLLabel52: TRLLabel;
    rllAcessorias: TRLLabel;
    RLLabel47: TRLLabel;
    rllValorICMST: TRLLabel;
    RLLabel53: TRLLabel;
    rllValorIPI: TRLLabel;
    RLLabel48: TRLLabel;
    rllTotalProdutos: TRLLabel;
    RLLabel54: TRLLabel;
    rllTotalNF: TRLLabel;
    RLDraw30: TRLDraw;
    RLDraw32: TRLDraw;
    RLDraw33: TRLDraw;
    RLDraw34: TRLDraw;
    RLDraw35: TRLDraw;
    RLDraw36: TRLDraw;
    RLDraw31: TRLDraw;
    RLDraw29: TRLDraw;
    RLDraw37: TRLDraw;
    rlbTransportadora: TRLBand;
    RLLabel55: TRLLabel;
    rllTransNome: TRLLabel;
    RLLabel63: TRLLabel;
    rllTransEndereco: TRLLabel;
    RLLabel67: TRLLabel;
    rllTransQTDE: TRLLabel;
    RLLabel68: TRLLabel;
    rllTransEspecie: TRLLabel;
    RLLabel69: TRLLabel;
    rllTransMarca: TRLLabel;
    RLLabel56: TRLLabel;
    RLLabel64: TRLLabel;
    rllTransCidade: TRLLabel;
    RLLabel70: TRLLabel;
    rllTransNumeracao: TRLLabel;
    rllTransModFrete: TRLLabel;
    RLLabel59: TRLLabel;
    rllTransCodigoANTT: TRLLabel;
    RLLabel60: TRLLabel;
    rllTransPlaca: TRLLabel;
    RLLabel71: TRLLabel;
    rllTransPesoBruto: TRLLabel;
    RLLabel61: TRLLabel;
    rllTransUFPlaca: TRLLabel;
    RLLabel65: TRLLabel;
    rllTransUF: TRLLabel;
    RLLabel62: TRLLabel;
    rllTransCNPJ: TRLLabel;
    RLLabel66: TRLLabel;
    rllTransIE: TRLLabel;
    RLLabel72: TRLLabel;
    rllTransPesoLiq: TRLLabel;
    RLDraw38: TRLDraw;
    RLDraw39: TRLDraw;
    RLDraw46: TRLDraw;
    RLDraw45: TRLDraw;
    RLDraw41: TRLDraw;
    RLDraw44: TRLDraw;
    RLDraw47: TRLDraw;
    RLDraw48: TRLDraw;
    RLDraw49: TRLDraw;
    RLDraw42: TRLDraw;
    RLDraw40: TRLDraw;
    RLLabel25: TRLLabel;
    rlbItens: TRLBand;
    rlbISSQN: TRLBand;
    RLLabel73: TRLLabel;
    RLLabel74: TRLLabel;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLDraw56: TRLDraw;
    RLDraw57: TRLDraw;
    RLDraw58: TRLDraw;
    RLDraw52: TRLDraw;
    rliMarcaDagua1: TRLImage;
    rllPageNumber: TRLSystemInfo;
    rllLastPage: TRLSystemInfo;
    rlbAvisoContingencia: TRLBand;
    rllAvisoContingencia: TRLLabel;
    rlbContinuacaoInformacoesComplementares: TRLBand;
    RLLabel16: TRLLabel;
    rlmContinuacaoDadosAdicionais: TRLMemo;
    rllHomologacao: TRLLabel;
    LinhaDCSuperior: TRLDraw;
    LinhaDCInferior: TRLDraw;
    LinhaDCEsquerda: TRLDraw;
    LinhaDCDireita: TRLDraw;
    rllCabFatura1: TRLLabel;
    rllCabFatura2: TRLLabel;
    rllCabFatura3: TRLLabel;
    RLDraw69: TRLDraw;
    RLLabel101: TRLLabel;
    rllISSQNValorServicos: TRLLabel;
    rllISSQNBaseCalculo: TRLLabel;
    rllISSQNValorISSQN: TRLLabel;
    rllISSQNInscricao: TRLLabel;
    LinhaFimItens: TRLDraw;
    RLDraw70: TRLDraw;
    RLDraw71: TRLDraw;
    rlmSiteEmail: TRLMemo;
    rllUsuario: TRLLabel;
    rllSistema: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    rllContingencia: TRLLabel;
    RLAngleLabel1: TRLAngleLabel;
    RLAngleLabel2: TRLAngleLabel;
    RLDraw13: TRLDraw;
    rliFatura1: TRLDraw;
    rllFatura: TRLAngleLabel;
    rliFatura5: TRLDraw;
    rllFatNum5: TRLLabel;
    rllFatNum10: TRLLabel;
    rllFatNum15: TRLLabel;
    rllFatData15: TRLLabel;
    rllFatData10: TRLLabel;
    rllFatData5: TRLLabel;
    rllFatValor5: TRLLabel;
    rllFatValor10: TRLLabel;
    rllFatValor15: TRLLabel;
    RLLabel57: TRLLabel;
    RLLabel58: TRLLabel;
    RLLabel79: TRLLabel;
    RLDraw53: TRLDraw;
    RLAngleLabel4: TRLAngleLabel;
    RLAngleLabel5: TRLAngleLabel;
    RLDraw55: TRLDraw;
    RLAngleLabel6: TRLAngleLabel;
    RLAngleLabel7: TRLAngleLabel;
    RLDraw3: TRLDraw;
    RLAngleLabel8: TRLAngleLabel;
    RLDraw5: TRLDraw;
    RLAngleLabel9: TRLAngleLabel;
    rlmDadosAdicionaisAuxiliar: TRLMemo;
    pnlCanhoto: TRLPanel;
    rliCanhoto: TRLDraw;
    rliCanhoto3: TRLDraw;
    rliCanhoto1: TRLDraw;
    rliCanhoto2: TRLDraw;
    rllNFe: TRLAngleLabel;
    rllNumNF0: TRLAngleLabel;
    rllSERIE0: TRLAngleLabel;
    rllIdentificacao: TRLAngleLabel;
    rllDataRecebimento: TRLAngleLabel;
    rllRecebemosDe: TRLAngleLabel;
    rllResumo: TRLAngleLabel;
    pnlDivisao: TRLPanel;
    rliDivisao: TRLDraw;
    pnlCabecalho1: TRLPanel;
    lblDadosDoProduto: TRLLabel;
    rlmCodProd: TRLMemo;
    rlsDivProd1: TRLDraw;
    rlmDescricaoProduto: TRLMemo;
    rllCinza1: TRLLabel;
    rlsRectProdutos1: TRLDraw;
    RLDraw4: TRLDraw;
    pnlDescricao1: TRLPanel;
    txtCodigo: TRLDBText;
    LinhaProd2: TRLDraw;
    LinhaProd1: TRLDraw;
    pnlCabecalho2: TRLPanel;
    rlsRectProdutos2: TRLDraw;
    rllCinza2: TRLLabel;
    rlsDivProd3: TRLDraw;
    rlsDivProd4: TRLDraw;
    rlsDivProd5: TRLDraw;
    rlsDivProd6: TRLDraw;
    rlsDivProd7: TRLDraw;
    rlsDivProd8: TRLDraw;
    RLDraw1: TRLDraw;
    rlsDivProd9: TRLDraw;
    rlsDivProd10: TRLDraw;
    rlsDivProd11: TRLDraw;
    rlsDivProd12: TRLDraw;
    RLLabel82: TRLLabel;
    lblCST: TRLLabel;
    RLLabel84: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel91: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel89: TRLLabel;
    RLLabel90: TRLLabel;
    RLLabel92: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabel96: TRLLabel;
    RLLabel97: TRLLabel;
    RLLabel98: TRLLabel;
    RLDraw54: TRLDraw;
    rlsDivProd13: TRLDraw;
    pnlDescricao2: TRLPanel;
    txtNCM: TRLDBText;
    txtCST: TRLDBText;
    txtCFOP: TRLDBText;
    txtUnidade: TRLDBText;
    txtQuantidade: TRLDBText;
    txtValorUnitario: TRLDBText;
    txtValorTotal: TRLDBText;
    txtValorDesconto: TRLDBText;
    txtBaseICMS: TRLDBText;
    txtValorICMS: TRLDBText;
    txtValorIPI: TRLDBText;
    txtAliqICMS: TRLDBText;
    txtAliqIPI: TRLDBText;
    LinhaProd4: TRLDraw;
    LinhaProd5: TRLDraw;
    LinhaProd6: TRLDraw;
    LinhaProd7: TRLDraw;
    LinhaProd8: TRLDraw;
    LinhaProd9: TRLDraw;
    LinhaProd10: TRLDraw;
    LinhaProd11: TRLDraw;
    LinhaProd12: TRLDraw;
    LinhaProd13: TRLDraw;
    LinhaProd14: TRLDraw;
    LinhaProd15: TRLDraw;
    LinhaProd16: TRLDraw;
    LinhaProd3: TRLDraw;
    rlmDescricao: TRLDBMemo;
    rlbObsItem: TRLBand;
    LinhaFimObsItem: TRLDraw;
    LinhaInicioItem: TRLDraw;
    LinhaObsItemEsquerda: TRLDraw;
    LinhaObsItemDireita: TRLDraw;
    rlmObsItem: TRLMemo;
    RLDraw2: TRLDraw;
    rllEAN: TRLLabel;
    txtEAN: TRLDBText;
    LinhaProdEAN: TRLDraw;
    rlsDivProdEAN: TRLDraw;
    RLLabel12: TRLLabel;
    procedure RLNFeBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbEmitenteBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbItensAfterPrint(Sender: TObject);
    procedure rlbDadosAdicionaisBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbItensBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbDadosAdicionaisAfterPrint(Sender: TObject);
    procedure rlbObsItemBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbEmitenteAfterPrint(Sender: TObject);
  private
    FRecebemoDe : string;
    procedure InitDados;
    procedure Header;
    procedure Emitente;
    procedure Destinatario;
    procedure EnderecoRetirada;
    procedure EnderecoEntrega;
    procedure Imposto;
    procedure Transporte;
    procedure DadosAdicionais;
    procedure Observacoes;
    procedure Itens;
    procedure ISSQN;
    procedure AddFatura;
    function BuscaDireita(Busca, Text: String): Integer;
    function FormatarCEP(AValue: String): String;
    function FormatarFone(AValue: String): String;
    procedure InsereLinhas(sTexto: String; iLimCaracteres: Integer; rMemo: TRLMemo);
    procedure ConfigureDataSource;
  public

  end;

implementation

uses ACBrNFeUtil, pcnNFe;

var iLimiteLinhas: Integer = 12;
iLinhasUtilizadas: Integer = 0;
iLimiteCaracteresLinha: Integer = 142;
iLimiteCaracteresContinuacao: Integer = 204;
q, iQuantItens, iItemAtual: Integer;
sRetirada, sEntrega: WideString;

{$R *.dfm}

function TfrlDANFeRLPaisagem.BuscaDireita(Busca, Text: String): Integer;
{Pesquisa um caractere à direita da string, retornando sua posição}
var n, retorno: integer;
begin
  retorno := 0;
    for n := length(Text) downto 1 do
      begin
        if Copy(Text, n, 1) = Busca then
          begin
            retorno := n;
            break;
         end;
      end;
  Result := retorno;
end;

{Função original de ACBrNFeUtil modificada para exibir em outro formato}
function TfrlDANFeRLPaisagem.FormatarCEP(AValue: String): String;
var i, iZeros: Integer;
sCep: String;
begin
  if Length(AValue) <= 8 then
    begin
      iZeros := 8 - Length(AValue);
      sCep := AValue;
      For i := 1 to iZeros do
        begin
          sCep := '0' + sCep;
        end;
      Result := copy(sCep,1,5) + '-' + copy(sCep,6,3);
    end
  else
    Result := copy(AValue,1,5) + '-' + copy(AValue,6,3);
end;

{Função original de ACBrNFeUtil modificada para exibir em outro formato}
function TfrlDANFeRLPaisagem.FormatarFone(AValue: String): String;
begin
  Result := AValue;
  if NotaUtil.NaoEstaVazio(AValue) then
  begin
    if Length(NotaUtil.LimpaNumero(AValue)) > 10 then AValue := copy(NotaUtil.LimpaNumero(AValue),2,10); //Casos em que o DDD vem com ZERO antes somando 3 digitos

    AValue := NotaUtil.Poem_Zeros(NotaUtil.LimpaNumero(AValue), 10);
    Result := '('+copy(AValue,1,2) + ') ' + copy(AValue,3,4) + '-' + copy(AValue,7,4);
  end;
end;

procedure TfrlDANFeRLPaisagem.InsereLinhas(sTexto: String; iLimCaracteres: Integer;
                                                                 rMemo: TRLMemo);
var iTotalLinhas, iUltimoEspacoLinha, iPosAtual, iQuantCaracteres, i: Integer;
    sLinhaProvisoria, sLinha: String;
begin
  iPosAtual := 1;
  iQuantCaracteres := Length(sTexto);
  if iQuantCaracteres <= iLimiteLinhas then
    iTotalLinhas := 1
  else
    begin
      if (iQuantCaracteres mod iLimCaracteres) > 0 then
        iTotalLinhas := (iQuantCaracteres div iLimCaracteres) + 1
      else
        iTotalLinhas := iQuantCaracteres div iLimCaracteres;
    end;

  for i := 1 to (iTotalLinhas + 10) do
    begin
      sLinhaProvisoria := Copy(sTexto, iPosAtual, iLimCaracteres);
      iUltimoEspacoLinha := BuscaDireita(' ', sLinhaProvisoria);

      if iUltimoEspacoLinha = 0 then
        iUltimoEspacoLinha := iQuantCaracteres;

      if Pos(';', sLinhaProvisoria) = 0 then
        begin
          if (BuscaDireita(' ', sLinhaProvisoria) = iLimCaracteres)  or
             (BuscaDireita(' ', sLinhaProvisoria) = (iLimCaracteres + 1)) then
            sLinha := sLinhaProvisoria
          else
            begin
              if (iQuantCaracteres - iPosAtual) > iLimCaracteres then
                sLinha := Copy(sLinhaProvisoria, 1, iUltimoEspacoLinha)
              else
                begin
                  sLinha := sLinhaProvisoria;
                end;
            end;
          iPosAtual := iPosAtual + Length(sLinha);
        end // if Pos(';', sLinhaProvisoria) = 0
      else
        begin
          sLinha := Copy(sLinhaProvisoria, 1, Pos(';', sLinhaProvisoria));
          iPosAtual := iPosAtual + (Length(sLinha));
        end;

      if sLinha > '' then
        begin
          if LeftStr(sLinha, 1) = ' ' then
            sLinha := Copy(sLinha, 2, (Length(sLinha) - 1))
          else
            sLinha := sLinha;

          rMemo.Lines.Add(sLinha);
        end;

    end;
end;

procedure TfrlDANFeRLPaisagem.RLNFeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  q := 0;
  with RLNFe.Margins do
    begin
      TopMargin := FMargemSuperior * 10;
      BottomMargin := FMargemInferior * 10;
      LeftMargin := FMargemEsquerda * 10;
      RightMargin := FMargemDireita * 10;
    end;

  ConfigureDataSource;
  InitDados;

  if FNFe.Cobr.Dup.Count > 0 then
    rlbFatura.Visible := True
  else
    rlbFatura.Visible := False;

  RLNFe.Title := Copy (FNFe.InfNFe.Id, 4, 44);

end;

procedure TfrlDANFeRLPaisagem.rlbEmitenteBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  rlbCodigoBarras.BringToFront;
  if RLNFe.PageNumber > 1 then
    begin
      rlbISSQN.Visible := False;
      rlbDadosAdicionais.Visible := False;

      if iQuantItens > q then
        begin
          rlbCabecalhoItens.Visible := True;
          lblDadosDoProduto.Caption := 'CONTINUAÇÃO DOS DADOS DO PRODUTO / SERVIÇOS';
          rliMarcaDagua1.Top := 300;
        end
      else
        rlbCabecalhoItens.Visible := False;

    end;
end;

procedure TfrlDANFeRLPaisagem.InitDados;
var i, j, b, h, iAlturaCanhoto: Integer;
begin
  // Carrega logomarca
  if (FLogo <> '') and FileExists (FLogo) then
     rliLogo.Picture.LoadFromFile(FLogo);

  if (FMarcaDagua <> '') and FileExists (FMarcaDagua) then
    begin
      rliMarcaDagua1.Picture.LoadFromFile(FMarcaDagua);
    end;

  // Exibe o resumo da NF-e no canhoto
  if FResumoCanhoto = True then
    begin
      if FResumoCanhoto_Texto <> '' then
        rllResumo.Caption := FResumoCanhoto_Texto
      else
        begin
          rllResumo.Caption := 'EMISSÃO: ' +
                           FormatDateTime('DD/MM/YYYY', FNFe.Ide.dEmi) +
                           '  -  ' +
                           'DEST. / REM.: ' + FNFe.Dest.xNome + '  -  ' +
                           'VALOR TOTAL: R$ ' +
                           NotaUtil.FormatFloat(FNFe.Total.ICMSTot.vNF,
                           '###,###,###,##0.00');
        end; // if FResumoCanhoto_Texto <> ''
      rllResumo.Visible := True;
      iAlturaCanhoto := 25;
    end
  else
    begin
      rllResumo.Visible := False;
      iAlturaCanhoto := 15;
    end;

  rliCanhoto1.Left := iAlturaCanhoto;
  rliCanhoto2.Left := rliCanhoto1.Left;
  rliCanhoto2.Width := (rliCanhoto.Left + rliCanhoto.Width) - rliCanhoto2.Left;
  rllDataRecebimento.Left := rliCanhoto1.Left + 3;
  rllIdentificacao.Left := rliCanhoto1.Left + 3;

  // Exibe o desenvolvedor do sistema
  if FSsitema <> '' then
    begin
      rllSistema.Caption := FSsitema;
      rllSistema.Visible := True;
    end
  else
    rllSistema.Visible := False;

  // Exibe o nome do usuário
  if FUsuario <> '' then
    begin
      rllUsuario.Caption := 'DATA / HORA DA IMPRESSÃO: ' +
                            DateTimeToStr(Now) + ' - ' + FUsuario;
      rllUsuario.Visible := True;
    end
  else
    rllUsuario.Visible := False;

  // Exibe a informação de Ambiente de Homologação
  if FNFe.Ide.tpAmb = taHomologacao then
    begin
      rllHomologacao.Caption := 'AMBIENTE DE HOMOLOGAÇÃO - NF-E SEM VALOR FISCAL';
      rllHomologacao.Visible := True;
    end
  else
    begin
      rllHomologacao.Caption := '';
      rllHomologacao.Visible := False;
    end;

  // Exibe a informação correta no label da chave de acesso
  if FNFe.procNFe.cStat > 0 then
    begin
      if FNFe.procNFe.cStat = 100 then
        begin
          rlbCodigoBarras.Visible := True;
          rllXMotivo.Visible := False;
          rllDadosVariaveis3_Descricao.Caption := 'PROTOCOLO DE AUTORIZAÇÃO DE USO';
          rllDadosVariaveis3_Descricao.Visible := True;
        end;
      if FNFe.procNFe.cStat = 101 then
        begin
          rlbCodigoBarras.Visible := False;
          rllXmotivo.Caption := 'NF-e CANCELADA';
          rllXmotivo.Visible := True;
          rllDadosVariaveis3_Descricao.Caption :=
                                    'PROTOCOLO DE HOMOLOGAÇÃO DE CANCELAMENTO';
          rllDadosVariaveis3_Descricao.Visible := True;
        end;
      if FNFe.procNFe.cStat = 102 then
        begin
          rlbCodigoBarras.Visible := False;
          rllXmotivo.Caption := 'NF-e DENEGADA';
          rllXmotivo.Visible := True;
          rllDadosVariaveis3_Descricao.Caption := 'PROTOCOLO DE DENEGAÇÃO DE USO';
          rllDadosVariaveis3_Descricao.Visible := True;
        end;
      if (FNFe.procNFe.cStat <> 100) and (FNFe.procNFe.cStat <> 101) and
                                               (FNFe.procNFe.cStat <> 103) then
        begin
          rlbCodigoBarras.Visible := False;
          rllXmotivo.Caption := FNFe.procNFe.xMotivo;
          rllXmotivo.Visible := True;
          rllDadosVariaveis3_Descricao.Visible := False;
          rllDadosVariaveis3.Visible := False;
        end;
    end
  else
    begin
      if (FNFe.Ide.tpEmis in [teNormal, teSCAN]) then
        begin
          rlbCodigoBarras.Visible := False;
          rllXmotivo.Caption := 'NF-E NÃO ENVIADA PARA SEFAZ';
          rllXMotivo.Visible := True;
          rllDadosVariaveis3_Descricao.Visible := False;
          rllDadosVariaveis3.Visible := False;
        end;
    end;

  // Ajusta a largura da coluna "Código do Produto"
  txtCodigo.Width := FLarguraCodProd;
  rlmCodProd.Width := FLarguraCodProd;
  rlsDivProd1.Left := FLarguraCodProd + 2;
  LinhaProd2.Left :=  FLarguraCodProd + 2;

  if FExibirEAN = False then
    begin
      rllEAN.Visible := False;
      txtEAN.Visible := False;
      rlsDivProdEAN.Visible := False;
      LinhaProdEAN.Visible := False;
      rlmDescricaoProduto.Left := rlsDivProd1.Left + 2;
      rlmDescricaoProduto.Width := ((rlsRectProdutos1.Left + rlsRectProdutos1.Width) - rlsDivProd1.Left) - 3;
      rlmDescricao.Left := LinhaProd2.Left + 2;
      rlmDescricao.Width := (pnlDescricao1.Width - LinhaProd2.Left) - 24;
    end
  else
    begin
      rllEAN.Visible := True;
      txtEAN.Visible := True;
      rlsDivProdEAN.Visible := True;
      LinhaProdEAN.Visible := True;
      rllEAN.Left := rlsDivProd1.Left + 2;
      txtEAN.Left := LinhaProd2.Left + 2;
      rlsDivProdEAN.Left := (rllEAN.Left + rllEAN.Width) + 2;
      LinhaProdEAN.Left := (txtEAN.Left + txtEAN.Width) + 2;
      rlmDescricaoProduto.Left := (rlsDivProdEAN.Left) + 2;
      rlmDescricaoProduto.Width := ((rlsRectProdutos1.Left + rlsRectProdutos1.Width) - (rlsDivProdEAN.Left)) - 3;
      rlmDescricao.Left := LinhaProdEAN.Left + 2;
      rlmDescricao.Width := (pnlDescricao1.Width - LinhaProdEAN.Left) - 24;
    end;

  rlmDescricaoProduto.Lines.BeginUpdate;
  rlmDescricaoProduto.Lines.Clear;
  rlmCodProd.Lines.BeginUpdate;
  rlmCodProd.Lines.Clear;

  // ajusta a posição do 'código do produto'
  if rlmCodProd.Width > 90 then
    begin
      rlmCodProd.Top := 13;
      rlmCodProd.Height := 7;
    end
  else
    begin
      rlmCodProd.Top := 9;
      rlmCodProd.Height := 14;
    end;

  // Se a largura da coluna 'Código do produto' for suficiente,
  // exibe o título da coluna sem abreviações
  if rlmCodProd.Width > 113 then
    rlmCodProd.Lines.Add('CÓDIGO DO PRODUTO / SERVIÇO')
  else
    rlmCodProd.Lines.Add('CÓDIGO DO PROD. / SERV.');

  // Ajusta a posição da coluna 'Descrição do produto'
  if rlmDescricaoProduto.Width > 128 then
    begin
      rlmDescricaoProduto.Top := 13;
      rlmDescricaoProduto.Height := 7;
    end
  else
    begin
      rlmDescricaoProduto.Top := 9;
      rlmDescricaoProduto.Height := 14;
    end;

  // Se a largura da coluna 'Descrição do produto' for suficiente,
  // exibe o título da coluna sem abreviações
  if rlmDescricaoProduto.Width > 72 then
    rlmDescricaoProduto.Lines.Add('DESCRIÇÃO DO PRODUTO / SERVIÇO')
  else
    rlmDescricaoProduto.Lines.Add('DESCR. PROD. / SERV.');

  rlmCodProd.Lines.EndUpdate;
  rlmDescricaoProduto.Lines.EndUpdate;

  // Posiciona o canhoto do DANFE no cabeçalho ou rodapé
  case FPosCanhoto of
    pcCabecalho:
      begin
        pnlCanhoto.Align := faLeftMost;
        pnlDivisao.Align := faLeftMost;
        pnlCanhoto.Left := 26;
        pnlDivisao.Left := pnlCanhoto.Left + pnlCanhoto.Width;
      end;
    pcRodape:
      begin
        pnlCanhoto.Align := faRightMost;
        pnlDivisao.Align := faRightMost;
        pnlDivisao.Left := 1024;
        pnlCanhoto.Left := pnlDivisao.Left + pnlDivisao.Width;
      end;
  end;

  // Posiciona a Marca D'água
  rliMarcaDagua1.Left := rlbItens.Left + (rlbItens.Width div 2) -
                                                  (rliMarcaDagua1.Width div 2);


  // Oculta alguns itens do DANFE
  if FFormularioContinuo = True then
    begin
      rllRecebemosDe.Visible := False;
      rllResumo.Visible := False;
      rllDataRecebimento.Visible := False;
      rllIdentificacao.Visible := False;
      rllNFe.Visible := False;
      rliCanhoto.Visible := False;
      rliCanhoto1.Visible := False;
      rliCanhoto2.Visible := False;
      rliCanhoto3.Visible := False;
      rliDivisao.Visible := False;
      rliTipoEntrada.Visible := False;
      rllDANFE.Visible := False;
      rllDocumento1.Visible := False;
      rllDocumento2.Visible := False;
      rllTipoEntrada.Visible := False;
      rllTipoSaida.Visible := False;
      rllEmitente.Visible := False;
      rliLogo.Visible := False;
      rlmEmitente.Visible := False;
      rlmEndereco.Visible := False;
      rllFone.Visible := False;
      rlmSiteEmail.Visible := False;
      rliEmitente.Visible := False;
      rllChaveAcesso.Visible := False;
      rliChave.Visible := False;
      rliChave2.Visible := False;
      rliChave3.Visible := False;
    end;

  // Expande a logomarca
  if FExpandirLogoMarca = True then
    begin
      rlmEmitente.Visible := False;
      rlmEndereco.Visible := False;
      rllFone.Visible := False;
      rlmSiteEmail.Visible := False;
      with rliLogo do
        begin
          Width := 450;
          Scaled := False;
          Stretch := True;
        end;
    end;

  DadosAdicionais;
  Header;
  Emitente;
  Destinatario;
  Imposto;
  Itens;
  ISSQN;
  Transporte;
  AddFatura;
  Observacoes;

  // Altera a fonde do DANFE
  case FFonteDANFE of
    fdArial:
      for b := 0 to (RLNFe.ControlCount - 1) do
        for i := 0 to ((TRLBand(RLNFe.Controls[b]).ControlCount) - 1) do
          begin
            for j := 0 to ((TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).ControlCount) - 1) do
              TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Font.Name :=
                                                                                          'Arial';

            if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag
                                                                     <> 20 then
              TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Name :=
                                                                      'Arial';

            if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag = 3 then
              TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size :=
              (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size) - 1;
          end;

    fdCourierNew:
      begin
        for b := 0 to (RLNFe.ControlCount - 1) do
          for i := 0 to ((TRLBand(RLNFe.Controls[b]).ControlCount) - 1) do
            begin
              for j := 0 to ((TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).ControlCount) - 1) do
                begin
                  TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Font.Name :=
                                                                                     'Courier New';

                  if TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Tag = 0 then
                    TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Font.Size :=
                    (TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Font.Size - 1);

                end;

              TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Name :=
                                                                'Courier New';

              if (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag = 0) or
                (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag = 3) then
                TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size :=
               (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size) - 1;

              if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag = 40 then
                TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Top :=
                (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Top) - 1;
            end;

        rllNumNF1.Font.Size := rllNumNF1.Font.Size -2;
        rllNumNF1.Top := rllNumNF1.Top + 1;
      end;

    fdTimesNewRoman:
      for b := 0 to (RLNFe.ControlCount - 1) do
        for i := 0 to ((TRLBand(RLNFe.Controls[b]).ControlCount) - 1) do
          begin
            for j := 0 to ((TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).ControlCount) - 1) do
              TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Font.Name :=
                                                                                'Times New Roman';

            if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag
                                                                     <> 20 then
              TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Name :=
                                                             'Times New Roman';

            if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag = 3 then
              TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size :=
              (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size) - 1;
          end;
  end;

  // Altera a fonte da Razão Social do Emitente
  rlmEmitente.Font.Size := FTamanhoFonte_RazaoSocial;

  // Verifica se será exibida a 'continuação das informações complementares'
  if rlmDadosAdicionaisAuxiliar.Lines.Count > iLimiteLinhas then
    begin
      rlbContinuacaoInformacoesComplementares.Visible := True;
      h := (rlmContinuacaoDadosAdicionais.Top +
            rlmContinuacaoDadosAdicionais.Height) + 2;
      LinhaDCInferior.Top := h;
      h := (h - LinhaDCSuperior.Top) + 1;
      LinhaDCEsquerda.Height := h;
      LinhaDCDireita.Height := h;
    end
  else
    rlbContinuacaoInformacoesComplementares.Visible := False;

  iQuantItens := FNFe.Det.Count;
end;

procedure TfrlDANFeRLPaisagem.Header;
var sChaveContingencia: String;
begin
  with FNFe.InfNFe, FNFe.Ide do
  begin
     rllChave.Caption := NotaUtil.FormatarChaveAcesso (Copy (FNFe.InfNFe.Id, 4, 44));
     rlbCodigoBarras.Caption := Copy (FNFe.InfNFe.Id, 4, 44);
     rllNumNF0.Caption := 'Nº ' + FormatFloat ('000,000,000', nNF);
     rllNumNF1.Caption := 'Nº ' + FormatFloat ('000,000,000', nNF);
     rllSERIE0.Caption := 'SÉRIE ' + IntToStr(Serie);
     rllSERIE1.Caption := 'SÉRIE ' + IntToStr(Serie);
     rllNatOperacao.Caption :=  NatOp;
     if tpNF = tnEntrada then // = entrada
        rllEntradaSaida.Caption := '0'
     else
        rllEntradaSaida.Caption := '1';

    rllEmissao.Caption   := NotaUtil.FormatDate(DateToStr(dEmi));
    rllSaida.Caption     := IfThen(DSaiEnt <> 0,
                                      NotaUtil.FormatDate(DateToStr(dSaiEnt)));
    rllHoraSaida.Caption := IfThen(hSaiEnt <> 0, FormatDateTime('hh:nn:ss', hSaiEnt));

    if FNFe.Ide.tpEmis in [teNormal, teSCAN] then
      begin
        if FNFe.procNFe.cStat > 0 then
          begin
            rllDadosVariaveis1a.Visible := True;
            rllDadosVariaveis1b.Visible := True;
          end
        else
          begin
            rllDadosVariaveis1a.Visible := False;
            rllDadosVariaveis1b.Visible := False;
          end;
        rlbCodigoBarrasFS.Visible := False;
        rllDadosVariaveis3.Caption := FNFe.procNFe.nProt + ' ' +
                                          DateTimeToStr(FNFe.procNFe.dhRecbto);
        rllAvisoContingencia.Visible := False;
        rlbAvisoContingencia.Visible := False;
      end
    else if FNFe.Ide.tpEmis in [teContingencia, teFSDA] then
      begin
        sChaveContingencia := NotaUtil.GerarChaveContingencia(FNFe);
        rllDadosVariaveis1a.Visible := False;
        rllDadosVariaveis1b.Visible := False;
        rlbCodigoBarras.Visible := True;
        rlbCodigoBarrasFS.Caption := sChaveContingencia;
        rlbCodigoBarrasFS.Visible := True;
        rllDadosVariaveis3_Descricao.Caption := 'DADOS DA NF-E';
        rllDadosVariaveis3.Caption :=
                          NotaUtil.FormatarChaveContigencia(sChaveContingencia);
        rllAvisoContingencia.Caption := 'DANFE em Contingência - ' +
                                'Impresso em decorrência de problemas técnicos';
        if (dhCont > 0) and (xJust > '') then
          rllContingencia.Caption :=
                    'Data / Hora da entrada em contingência: ' +
                    FormatDateTime('dd/mm/yyyy hh:nn:ss', dhCont) +
                    '   Motivo: ' + xJust;
        rllAvisoContingencia.Visible := True;
        rlbAvisoContingencia.Visible := True;
      end
    else if FNFe.Ide.tpEmis = teDPEC then
      begin
        rllDadosVariaveis1a.Visible := True;
        rllDadosVariaveis1b.Visible := True;
        rlbCodigoBarras.Visible := True;
        rlbCodigoBarrasFS.Visible := False;
        rllDadosVariaveis3_Descricao.Caption := 'NÚMERO DE REGISTRO DPEC';

        if FProtocoloNFe <> '' then
          rllDadosVariaveis3.Caption := FProtocoloNFe
        else
          rllDadosVariaveis3.Caption := FNFe.procNFe.nProt + ' ' +
                                          DateTimeToStr(FNFe.procNFe.dhRecbto);


        rllAvisoContingencia.Caption := 'DANFE em Contingência - DPEC ' +
                        'regularmente recebida pela Receita Federal do Brasil';

        if (dhCont > 0) and (xJust > '') then
          rllContingencia.Caption :=
                    'Data / Hora da entrada em contingência: ' +
                    FormatDateTime('dd/mm/yyyy hh:nn:ss', dhCont) +
                    '   Motivo: ' + xJust;

        rllAvisoContingencia.Visible := True;
        rlbAvisoContingencia.Visible := True;
      end;
  end;
end;

procedure TfrlDANFeRLPaisagem.Emitente;
begin
  //emit
  with FNFe.Emit do
    begin
      if FRecebemoDe = '' then
        FRecebemoDe := rllRecebemosDe.Caption;

      rllRecebemosDe.Caption := Format (FRecebemoDe, [ XNome ]);
      rllInscricaoEstadual.Caption := IE;
      rllInscrEstSubst.caption := IEST;
      rllCNPJ.Caption := NotaUtil.FormatarCNPJ(CNPJCPF );
      rlmEmitente.Lines.Text   := XNome;
      with EnderEmit do
        begin
          rlmEndereco.Lines.Clear;
          if xCpl > '' then
            rlmEndereco.Lines.add (XLgr + IfThen (Nro = '0', '', ', ' + Nro) +
                                                ' ' + XCpl + ' - ' + XBairro)
          else
            rlmEndereco.Lines.add (XLgr + IfThen (Nro = '0', '', ', ' + Nro) +
                                                              ' - ' + XBairro);

          rlmEndereco.Lines.add ('CEP: ' + FormatarCEP(IntToStr(CEP)) +
                                                    ' - ' + XMun + ' - ' + UF);

        if FFax <> '' then
          begin
            rllFone.Caption := 'TEL: ' + FormatarFone(Fone) +
                                      ' - FAX: ' + FormatarFone(FFax);
          end
        else
          begin
            rllFone.Caption := 'TEL: ' + FormatarFone(Fone);
          end;
      end;
    end;

    if (FSite <> '') or (FEmail <> '') then
      begin
        rlmSiteEmail.Lines.BeginUpdate;
        rlmSiteEmail.Lines.Clear;
        if FSite <> '' then
          rlmSiteEmail.Lines.Add(FSite);
        if FEmail <> '' then
          rlmSiteEmail.Lines.Add(FEmail);
        rlmSiteEmail.Lines.EndUpdate;
        rlmSiteEmail.Visible := True;
        rlmEndereco.Top := 38;
        rllFone.Top := 64;
        rlmSiteEmail.Top := 78;
      end
    else
      begin
        rlmSiteEmail.Visible := False;
        rlmEndereco.Top := 48;
        rllFone.Top := 82;
      end;
end;

procedure TfrlDANFeRLPaisagem.Destinatario;
begin
  // destinatario
  with FNFe.Dest do
    begin
      if Length(CNPJCPF) = 14 then
        rllDestCNPJ.Caption := NotaUtil.FormatarCNPJ(CNPJCPF)
      else
        if Length(CNPJCPF) = 11 then
          rllDestCNPJ.Caption := NotaUtil.FormatarCPF(CNPJCPF)
        else
          rllDestCNPJ.Caption := CNPJCPF;

      rllDestIE.Caption   := IE;
      rllDestNome.Caption := XNome;
      with EnderDest do
        begin
          if xCpl > '' then
            rllDestEndereco.Caption := XLgr + IfThen (Nro = '0', '', ', ' + Nro)
                                                                  + ' ' + xCpl
          else
            rllDestEndereco.Caption := XLgr + IfThen (Nro = '0', '', ', ' + Nro);
          rllDestBairro.Caption := XBairro;
          rllDestCidade.Caption := XMun;
          rllDestUF.Caption := UF;
          rllDestCEP.Caption := FormatarCEP(IntToStr(CEP));
          rllDestFONE.Caption := FormatarFone(Fone);
        end;
    end;
end;

procedure TfrlDANFeRLPaisagem.EnderecoEntrega;
var sEndereco: WideString;
sCNPJ: String;
begin
  if FNFe.Entrega.xLgr > '' then
    begin
      with FNFe.Entrega do
        begin
          if Trim (CNPJCPF) <>  '' then
            sCNPJ := NotaUtil.FormatarCNPJ(CNPJCPF)
          else
            sCNPJ := NotaUtil.FormatarCPF(CNPJCPF);

          if xCpl > '' then
            sEndereco := XLgr + IfThen (Nro = '0', '', ', ' + Nro) + ' - ' + xCpl
          else
            sEndereco := XLgr + IfThen (Nro = '0', '', ', ' + Nro);

          sEntrega := 'LOCAL DE ENTREGA: ' + sEndereco + ' - ' + xBairro +
                      ' - ' + xMun + '-' + UF + '  CNPJ: ' + sCNPJ;
        end;
    end;
end;

procedure TfrlDANFeRLPaisagem.EnderecoRetirada;
var sEndereco: WideString;
sCNPJ: String;
begin
  if FNFe.Retirada.xLgr > '' then
    begin
      with FNFe.Retirada do
        begin
          if Trim (CNPJCPF) <>  '' then
            sCNPJ := NotaUtil.FormatarCNPJ(CNPJCPF)
          else
            sCNPJ := NotaUtil.FormatarCPF(CNPJCPF);

          if xCpl > '' then
            sEndereco := XLgr + IfThen (Nro = '0', '', ', ' + Nro) + ' - ' + xCpl
          else
            sEndereco := XLgr + IfThen (Nro = '0', '', ', ' + Nro);

          sRetirada := 'LOCAL DE RETIRADA: ' + sEndereco + ' - ' + xBairro +
                      ' - ' + xMun + '-' + UF + '  CNPJ: ' + sCNPJ;
        end;
    end;
end;

procedure TfrlDANFeRLPaisagem.Imposto;
begin
  with FNFe.Total.ICMSTot do
  begin
    rllBaseICMS.Caption      := NotaUtil.FormatFloat(VBC, '###,###,###,##0.00');
    rllValorICMS.Caption     := NotaUtil.FormatFloat(VICMS, '###,###,###,##0.00');
    rllBaseICMST.Caption     := NotaUtil.FormatFloat(VBCST, '###,###,###,##0.00');
    rllValorICMST.Caption    := NotaUtil.FormatFloat(VST, '###,###,###,##0.00');
    rllTotalProdutos.Caption := NotaUtil.FormatFloat(VProd, '###,###,###,##0.00');
    rllValorFrete.Caption    := NotaUtil.FormatFloat(VFrete, '###,###,###,##0.00');
    rllValorSeguro.Caption   := NotaUtil.FormatFloat(VSeg, '###,###,###,##0.00');
    rllDescontos.Caption     := NotaUtil.FormatFloat(VDesc, '###,###,###,##0.00');
    rllAcessorias.Caption    := NotaUtil.FormatFloat(VOutro, '###,###,###,##0.00');
    rllValorIPI.Caption      := NotaUtil.FormatFloat(VIPI, '###,###,###,##0.00');
    rllTotalNF.Caption       := NotaUtil.FormatFloat(VNF, '###,###,###,##0.00');
  end;
end;

procedure TfrlDANFeRLPaisagem.Transporte;
begin
  with FNFe.Transp do
    begin
      case modFrete of
        mfContaEmitente: rllTransModFrete.Caption := '0 - EMITENTE';
        mfContaDestinatario: rllTransModFrete.Caption := '1 - DESTINATÁRIO';
        mfContaTerceiros: rllTransModFrete.Caption := '2 - TERCEIROS';
        mfSemFrete: rllTransModFrete.Caption := '9 - SEM FRETE';
      end;

      rllTransCodigoANTT.Caption := '';
      rllTransPlaca.Caption := '';
      rllTransUFPlaca.Caption := '';

      with Transporta do
        begin
          if Trim (CNPJCPF) <> '' then
            begin
              if length(Trim (CNPJCPF)) <= 11 then
                rllTransCNPJ.Caption := NotaUtil.FormatarCPF(CNPJCPF)
              else
                rllTransCNPJ.Caption := NotaUtil.FormatarCNPJ(CNPJCPF);
            end
          else
            rllTransCNPJ.Caption := '';

          rllTransNome.Caption := XNome;
          rllTransIE.Caption := IE;
          rllTransEndereco.Caption := XEnder;
          rllTransCidade.Caption := XMun;
          rllTransUF.Caption := UF;
        end;
    end;

  with FNFe.Transp.VeicTransp do
  begin
    rllTransPlaca.Caption   :=  Placa;
    rllTransUFPlaca.Caption :=  UF;
  end;

  if FNFe.Transp.Vol.Count > 0 then
   begin
     with FNFe.Transp.Vol[0] do
      begin
        if qVol > 0 then
          rllTransQTDE.Caption       :=  IntToStr(QVol);
        rllTransEspecie.Caption    :=  Esp  ;
        rllTransMarca.Caption      :=  Marca;
        rllTransNumeracao.Caption  :=  NVol ;
        if pesoL > 0 then
          rllTransPesoLiq.Caption    :=  NotaUtil.FormatFloat(PesoL,
                                                        '###,###,###,##0.000');
        if pesoB > 0 then
          rllTransPesoBruto.Caption  :=  NotaUtil.FormatFloat(PesoB,
                                                        '###,###,###,##0.000');
      end;
   end
  else
   begin
     rllTransQTDE.Caption       :=  '';
     rllTransEspecie.Caption    :=  '';
     rllTransMarca.Caption      :=  '';
     rllTransNumeracao.Caption  :=  '';
     rllTransPesoLiq.Caption    :=  '';
     rllTransPesoBruto.Caption  :=  '';
   end;
end;

procedure TfrlDANFeRLPaisagem.DadosAdicionais;
var sInfCompl, sInfAdFisco, sInfContr, sObsFisco, sObsProcRef, sInfInteira,
    sProtocolo, sSuframa : WideString;
    sLinhaProvisoria, sLinha, sIndProc: String;
iTotalCaracteres, iTotalLinhas, iUltimoEspacoLinha, i: Integer;
begin
  rlmDadosAdicionaisAuxiliar.Lines.BeginUpdate;
  rlmDadosAdicionaisAuxiliar.Lines.Clear;

  // Protocolo de autorização, nos casos de emissão em contingência
  if (FNFe.Ide.tpEmis in [teContingencia, teFSDA, teDPEC]) and
                                              (FNFe.procNFe.cStat = 100) then
    begin
      sProtocolo := 'PROTOCOLO DE AUTORIZAÇÃO DE USO: ' +
                     FNFe.procNFe.nProt + ' ' + DateTimeToStr(FNFe.procNFe.dhRecbto);
      InsereLinhas(sProtocolo, iLimiteCaracteresLinha, rlmDadosAdicionaisAuxiliar);
    end;

  // Inscrição Suframa
  if FNFe.Dest.ISUF > '' then
    begin
      sSuframa := 'INSCRIÇÃO SUFRAMA: ' + FNFe.Dest.ISUF;
      InsereLinhas(sSuframa, iLimiteCaracteresLinha, rlmDadosAdicionaisAuxiliar);
    end;

  // Endereço de retirada
  if FNFe.Retirada.xLgr > '' then
    begin
      EnderecoRetirada;
      sRetirada := sRetirada;
      InsereLinhas(sRetirada, iLimiteCaracteresLinha, rlmDadosAdicionaisAuxiliar);
    end;

  // Endereço de entrega
  if FNFe.Entrega.xLgr > '' then
    begin
      EnderecoEntrega;
      sEntrega := sEntrega;
      InsereLinhas(sEntrega, iLimiteCaracteresLinha, rlmDadosAdicionaisAuxiliar);
    end;

  // Informações de interesse do fisco
  if FNFe.InfAdic.infAdFisco > '' then
    begin
      if FNFe.InfAdic.infCpl > '' then
        sInfAdFisco := FNFe.InfAdic.infAdFisco + '; '
      else
        sInfAdFisco := FNFe.InfAdic.infAdFisco;
    end
  else
    sInfAdFisco := '';

  // Informações de interesse do contribuinte
  if FNFe.InfAdic.infCpl > '' then
    sInfCompl := FNFe.InfAdic.infCpl
  else
    sInfCompl := '';

  // Informações de uso livre do contribuinte com "xCampo" e "xTexto"
  if FNFe.InfAdic.obsCont.Count > 0 then
    begin
      sInfContr := '';
      for i := 0 to (FNFe.InfAdic.obsCont.Count - 1) do
        begin
          if FNFe.InfAdic.obsCont.Items[i].Index =
                                          (FNFe.InfAdic.obsCont.Count - 1) then
            sInfContr := sInfContr + FNFe.InfAdic.obsCont.Items[i].xCampo +
                              ': ' + FNFe.InfAdic.obsCont.Items[i].xTexto
          else
            sInfContr := sInfContr + FNFe.InfAdic.obsCont.Items[i].xCampo +
                            ': ' + FNFe.InfAdic.obsCont.Items[i].xTexto + '; ';
        end; // for i := 0 to (FNFe.InfAdic.obsCont.Count - 1)
      if (sInfCompl > '') or (sInfAdFisco > '') then
        sInfContr := sInfContr + '; '
    end // if FNFe.InfAdic.obsCont.Count > 0
  else
    sInfContr := '';

  // Informações de uso livre do fisco com "xCampo" e "xTexto"
  if FNFe.InfAdic.obsFisco.Count > 0 then
    begin
      sObsFisco := '';
      for i := 0 to (FNFe.InfAdic.obsFisco.Count - 1) do
        begin
          if FNFe.InfAdic.obsFisco.Items[i].Index =
                                          (FNFe.InfAdic.obsFisco.Count - 1) then
            sObsFisco := sObsFisco + FNFe.InfAdic.obsFisco.Items[i].xCampo +
                              ': ' + FNFe.InfAdic.obsFisco.Items[i].xTexto
          else
            sObsFisco := sObsFisco + FNFe.InfAdic.obsFisco.Items[i].xCampo +
                            ': ' + FNFe.InfAdic.obsFisco.Items[i].xTexto + '; ';
        end; // for i := 0 to (FNFe.InfAdic.obsFisco.Count - 1)
      if (sInfCompl > '') or (sInfAdFisco > '') then
        sObsFisco := sObsFisco + '; '
    end // if FNFe.InfAdic.obsFisco.Count > 0
  else
    sObsFisco := '';

  // Informações do processo referenciado
  if FNFe.InfAdic.procRef.Count > 0 then
    begin
      for i := 0 to (FNFe.InfAdic.procRef.Count - 1) do
        begin
          case FNFe.InfAdic.procRef.Items[i].indProc of
            ipSEFAZ: sIndProc := 'SEFAZ';
            ipJusticaFederal: sIndProc := 'JUSTIÇA FEDERAL';
            ipJusticaEstadual: sIndProc := 'JUSTIÇA ESTADUAL';
            ipSecexRFB: sIndProc := 'SECEX / RFB';
            ipOutros: sIndProc := 'OUTROS';
          end;

          if FNFe.InfAdic.procRef.Items[i].Index =
                                          (FNFe.InfAdic.procRef.Count - 1) then
            sObsProcRef := sObsProcRef + 'PROCESSO OU ATO CONCESSÓRIO Nº: ' +
                           FNFe.InfAdic.procRef.Items[i].nProc + ' - ORIGEM: ' +
                           sIndProc
          else
            sObsProcRef := sObsProcRef + 'PROCESSO OU ATO CONCESSÓRIO Nº: ' +
                           FNFe.InfAdic.procRef.Items[i].nProc + ' - ORIGEM: ' +
                           sIndProc + '; ';
        end; // for i := 0 to (FNFe.InfAdic.procRef.Count - 1)
      if (sInfCompl > '') or (sInfAdFisco > '') then
        sObsProcRef := sObsProcRef + '; '
    end // if FNFe.InfAdic.procRef.Count > 0
  else
    sObsProcRef := '';

  sInfInteira := sInfAdFisco + sObsFisco + sObsProcRef + sInfContr + sInfCompl;
  InsereLinhas(sInfInteira, iLimiteCaracteresLinha, rlmDadosAdicionaisAuxiliar);
  rlmDadosAdicionaisAuxiliar.Lines.EndUpdate;
end;

procedure TfrlDANFeRLPaisagem.Observacoes;
var i, iMaximoLinhas, iRestanteLinhas: Integer;
sTexto: WideString;
begin
  rlmDadosAdicionais.Lines.BeginUpdate;
  rlmDadosAdicionais.Lines.Clear;

  if rlmDadosAdicionaisAuxiliar.Lines.Count > iLimiteLinhas then
    begin
      iMaximoLinhas := iLimiteLinhas;
      iRestanteLinhas := rlmDadosAdicionaisAuxiliar.Lines.Count - iLimiteLinhas;
      rlmContinuacaoDadosAdicionais.Lines.BeginUpdate;
      sTexto := '';
      for i := 0 to (iRestanteLinhas - 1) do
        begin
          sTexto := sTexto +
                  rlmDadosAdicionaisAuxiliar.Lines.Strings[(iMaximoLinhas + i)];
        end;

      InsereLinhas(sTexto, iLimiteCaracteresContinuacao, rlmContinuacaoDadosAdicionais);
      rlmContinuacaoDadosAdicionais.Lines.Text :=
                        StringReplace(rlmContinuacaoDadosAdicionais.Lines.Text,
                        ';', '', [rfReplaceAll, rfIgnoreCase]);
      rlmContinuacaoDadosAdicionais.Lines.EndUpdate;
    end
  else
    iMaximoLinhas := rlmDadosAdicionaisAuxiliar.Lines.Count;

  for i := 0 to (iMaximoLinhas - 1) do
    begin
      rlmDadosAdicionais.Lines.Add(rlmDadosAdicionaisAuxiliar.Lines.Strings[i]);
    end;

  rlmDadosAdicionais.Lines.Text := StringReplace(rlmDadosAdicionais.Lines.Text,
                                   ';', '', [rfReplaceAll, rfIgnoreCase]);

  rlmDadosAdicionais.Lines.EndUpdate;
end;

procedure TfrlDANFeRLPaisagem.Itens;
var nItem : Integer ;
sCST, sBCICMS, sALIQICMS, sVALORICMS, sALIQIPI, sVALORIPI : String ;
begin
 
  for nItem := 0 to (FNFe.Det.Count - 1) do
    begin
      with FNFe.Det.Items[nItem] do
        begin
          with Prod do
            begin
              with Imposto.ICMS do
                begin
                  sALIQIPI   := '0,00' ;
                  sVALORIPI  := '0,00' ;

                  cdsItens.Append ;
                  cdsItens.FieldByName('CODIGO').AsString := CProd;
                  cdsItens.FieldByName('EAN').AsString := cEAN;
                  cdsItens.FieldByName('DESCRICAO').AsString := XProd;
                  cdsItens.FieldByName('NCM').AsString := NCM;
                  cdsItens.FieldByName('CFOP').AsString := CFOP;
                  cdsItens.FieldByName('QTDE').AsString := FormatFloat(format(sDisplayFormat ,[FCasasDecimaisqCom,0]),qCom);
                  cdsItens.FieldByName('VALOR').AsString := FormatFloat(format(sDisplayFormat ,[FCasasDecimaisvUnCom,0]),vUnCom);
                  cdsItens.FieldByName('UNIDADE').AsString := UCom;
                  cdsItens.FieldByName('TOTAL').AsString :=
                                      FormatFloat('###,###,###,##0.00', vProd);
                  cdsItens.FieldByName('VALORDESC').AsString :=
                                      FormatFloat('###,###,###,##0.00', vDesc);

                  if FNFe.Emit.CRT in [crtRegimeNormal] then
                    begin
                      if CSTICMSToStr(CST) > '' then
                        sCST := OrigToStr(orig) + CSTICMSToStr(CST)
                      else
                        sCST := '';
                      sBCICMS    := '0,00';
                      sALIQICMS  := '0,00';
                      sVALORICMS := '0,00';

                      if (CST = cst00) then
                        begin
                          sBCICMS    := FormatFloat('###,###,###,##0.00', VBC);
                          sALIQICMS  := FormatFloat('###,###,###,##0.00', PICMS);
                          sVALORICMS := FormatFloat('###,###,###,##0.00', VICMS);
                        end
                      else if (CST = cst10) then
                        begin
                          sBCICMS    := FormatFloat('###,###,###,##0.00', VBC);
                          sALIQICMS  := FormatFloat('###,###,###,##0.00', PICMS);
                          sVALORICMS := FormatFloat('###,###,###,##0.00', VICMS);
                        end
                      else if (CST = cst20) then
                        begin
                          sBCICMS    := FormatFloat('###,###,###,##0.00', VBC);
                          sALIQICMS  := FormatFloat('###,###,###,##0.00', PICMS);
                          sVALORICMS := FormatFloat('###,###,###,##0.00', VICMS);
                        end
                      else if (CST = cst30) then
                        begin
                          {sBCICMS    := FormatFloat('###,###,###,##0.00', VBCST);
                          sALIQICMS  := FormatFloat('###,###,###,##0.00', PICMSST);
                          sVALORICMS := FormatFloat('###,###,###,##0.00', VICMSST);}
                        end
                      else if (CST = cst40) or (CST = cst41) or (CST = cst50) then
                        begin
                          // Campos vazios
                        end
                      else if (CST = cst51) then
                        begin
                          sBCICMS    := FormatFloat('###,###,###,##0.00', VBC);
                          sALIQICMS  := FormatFloat('###,###,###,##0.00', PICMS);
                          sVALORICMS := FormatFloat('###,###,###,##0.00', VICMS);
                        end
                      else if (CST = cst60) then
                        begin
                          sBCICMS    := FormatFloat('###,###,###,##0.00', VBCST);
                          sVALORICMS := FormatFloat('###,###,###,##0.00', VICMSST);
                        end
                      else if (CST = cst70) then
                        begin
                          sBCICMS    := FormatFloat('###,###,###,##0.00', VBC);
                          sALIQICMS  := FormatFloat('###,###,###,##0.00', PICMS);
                          sVALORICMS := FormatFloat('###,###,###,##0.00', VICMS);
                        end
                      else if (CST = cst90) then
                        begin
                          sBCICMS    := FormatFloat('###,###,###,##0.00', VBC);
                          sALIQICMS  := FormatFloat('###,###,###,##0.00', PICMS);
                          sVALORICMS := FormatFloat('###,###,###,##0.00', VICMS);
                       end;

                      cdsItens.FieldByName('CST').AsString := sCST;
                      cdsItens.FieldByName('BICMS').AsString := sBCICMS;
                      cdsItens.FieldByName('ALIQICMS').AsString := sALIQICMS;
                      cdsItens.FieldByName('VALORICMS').AsString := sVALORICMS;
                      lblCST.Caption := 'CST';
                      lblCST.Font.Size := 5;
                      lblCST.Top := 13;
                      txtCST.DataField := 'CST';
                    end; //FNFe.Emit.CRT = crtRegimeNormal

                  if FNFe.Emit.CRT = crtSimplesNacional then
                    begin
                      if CSOSNIcmsToStr(Imposto.ICMS.CSOSN) > '' then
                        cdsItens.FieldByName('CSOSN').AsString :=
                            OrigToStr(orig) + CSOSNIcmsToStr(Imposto.ICMS.CSOSN)
                      else
                        cdsItens.FieldByName('CSOSN').AsString := '';
                      cdsItens.FieldByName('BICMS').AsString := '0,00';
                      cdsItens.FieldByName('ALIQICMS').AsString := '0,00';
                      cdsItens.FieldByName('VALORICMS').AsString := '0,00';
                      lblCST.Caption := 'CSOSN';
                      lblCST.Font.Size := 4;
                      lblCST.Top := 14;
                      txtCST.DataField := 'CSOSN';
                    end; //FNFe.Emit.CRT = crtSimplesNacional
                end; // with Imposto.ICMS do

              with Imposto.IPI do
                begin
                  if (CST = ipi00) or (CST = ipi49) or
                     (CST = ipi50) or (CST = ipi99) then
                    begin
                      sALIQIPI  := FormatFloat('##0.00', PIPI) ;
                      sVALORIPI := FormatFloat('##0.00', VIPI) ;
                    end
                end;

              cdsItens.FieldByName('ALIQIPI').AsString := sALIQIPI;
              cdsItens.FieldByName('VALORIPI').AsString := sVALORIPI;
              cdsItens.Post ;
            end; // with Prod do
        end; //  with FNFe.Det.Items[nItem] do
    end; //  for nItem := 0 to ( FNFe.Det.Count - 1 ) do

   cdsItens.First ;
end;

procedure TfrlDANFeRLPaisagem.ISSQN;
begin
  with FNFe.Total.ISSQNtot do
    begin
      if FNFe.Emit.IM > '' then
        begin
          rlbISSQN.Visible := True;
          rllISSQNInscricao.Caption := FNFe.Emit.IM;
          rllISSQNValorServicos.Caption :=
                                NotaUtil.FormatFloat(FNFe.Total.ISSQNtot.vServ,
                                '###,###,##0.00');
          rllISSQNBaseCalculo.Caption :=
                                  NotaUtil.FormatFloat(FNFe.Total.ISSQNtot.vBC,
                                  '###,###,##0.00');
          rllISSQNValorISSQN.Caption :=
                                  NotaUtil.FormatFloat(FNFe.Total.ISSQNtot.vISS,
                                  '###,###,##0.00');
        end
      else
        rlbISSQN.Visible := False
    end;
end;

procedure TfrlDANFeRLPaisagem.AddFatura;
var x, iQuantDup, iLinhas, iColunas, iPosQuadro, iAltLinha,
    iAltQuadro1Linha, iAltQuadro, iAltBand, iFolga: Integer;
begin

  //zera
  iQuantDup := 0;
  for x := 1 to 15 do
    begin
      TRLLabel (FindComponent ('rllFatNum'   + intToStr (x))).Caption := '';
      TRLLabel (FindComponent ('rllFatData'  + intToStr (x))).Caption := '';
      TRLLabel (FindComponent ('rllFatValor' + intToStr (x))).Caption := '';
    end;

  if FNFe.Cobr.Dup.Count > 0 then
    begin
      if FNFe.Cobr.Dup.Count > 15 then
        iQuantDup := 15
      else
        iQuantDup := FNFe.Cobr.Dup.Count;

      //adiciona
      for x := 0 to (iQuantDup - 1) do
        with FNFe.Cobr.Dup[ x ] do
         begin
           TRLLabel (FindComponent ('rllFatNum'   + intToStr (x + 1))).Caption :=
                                                                          NDup;
           TRLLabel (FindComponent ('rllFatData'  + intToStr (x + 1))).Caption :=
                                          NotaUtil.FormatDate(DateToStr(DVenc));
           TRLLabel (FindComponent ('rllFatValor' + intToStr (x + 1))).Caption :=
                                                    NotaUtil.FormatFloat(VDup);
         end;

     {=============== Ajusta o tamanho do quadro das faturas ===============}

      iColunas := 5; // Quantidade de colunas
      iAltLinha := 12;  // Altura de cada linha
      iPosQuadro := 0; // Posição (Top) do Quadro
      iAltQuadro1Linha := 27; // Altura do quadro com 1 linha
      iFolga := 1; // Distância entre o final da Band e o final do quadro

      if (iQuantDup mod iColunas) = 0 then // Quantidade de linhas
        iLinhas := iQuantDup div iColunas
      else
        iLinhas := (iQuantDup div iColunas) + 1;

      if iLinhas = 1 then
        iAltQuadro := iAltQuadro1Linha
      else
        iAltQuadro := iAltQuadro1Linha + ((iLinhas - 1) * iAltLinha);

      iAltBand := iPosQuadro + iAltQuadro + iFolga;

      rlbFatura.Height := iAltBand;
      rliFatura.Height := iAltQuadro;
      rliFatura1.Height := iAltQuadro;
      rliFatura2.Height := iAltQuadro;
      rliFatura3.Height := iAltQuadro;
      rliFatura4.Height := iAltQuadro;
      rliFatura5.Height := iAltQuadro;

     {=============== Centraliza o label "FATURA" ===============}
     rllFatura.Top := (rlbFatura.Height - rllFatura.Height) div 2;

    end; // if FNFe.Cobr.Dup.Count > 0
end;

procedure TfrlDANFeRLPaisagem.rlbItensAfterPrint(Sender: TObject);
var h: Integer;
str: WideString;
begin
  q := q + 1;
  if FNFe.Det.Items[q - 1].infAdProd > '' then
    begin
      rlmObsItem.Lines.BeginUpdate;
      rlmObsItem.Lines.Clear;
      str := StringReplace((FNFe.Det.Items[q - 1].infAdProd), ';',
                                          #13#10, [rfReplaceAll, rfIgnoreCase]);
      rlmObsItem.Lines.Add(str);
      rlmObsItem.Lines.EndUpdate;
      rlbObsItem.Visible := True;

      h := (rlmObsItem.Top + rlmObsItem.Height) + 2;
      LinhaFimObsItem.Top := h;
      h := h + 1;
      LinhaObsItemEsquerda.Height := h;
      LinhaObsItemDireita.Height := h;
      if iQuantItens > q then
        LinhaInicioItem.Visible := True
      else
        LinhaInicioItem.Visible := False;
    end
  else
    rlbObsItem.Visible := False;

end;

procedure TfrlDANFeRLPaisagem.rlbDadosAdicionaisBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var iAumento: Integer;
begin
  iAumento := pnlCanhoto.Width + pnlDivisao.Width;
  pnlCanhoto.Visible := False;
  pnlDivisao.Visible := False;
  rliChave.Width := rliChave.Width + iAumento;
  rliChave2.Width := rliChave2.Width + iAumento;
  rliChave3.Width := rliChave3.Width + iAumento;
  rliNatOpe.Width := rliNatOpe.Width + iAumento;
  rliNatOpe1.Width := rliNatOpe1.Width + iAumento;
  rllDadosVariaveis1a.Left := rllDadosVariaveis1a.Left + (iAumento div 2);
  rllDadosVariaveis1b.Left := rllDadosVariaveis1b.Left + (iAumento div 2);
  rlbCodigoBarras.Left := rlbCodigoBarras.Left + (iAumento div 2);
  rllXmotivo.Left := rllXmotivo.Left + (iAumento div 2);
  rlmContinuacaoDadosAdicionais.Width := rlmContinuacaoDadosAdicionais.Width +
                                                                       iAumento;
  LinhaDCDireita.Left := LinhaDCDireita.Left + iAumento;
  LinhaDCSuperior.Width := LinhaDCSuperior.Width + iAumento;
  LinhaDCInferior.Width := LinhaDCInferior.Width + iAumento;
  pnlCabecalho1.Width := pnlCabecalho1.Width + iAumento;
  rllCinza1.Width := rllCinza1.Width + iAumento;
  rlmDescricaoProduto.Width := rlmDescricaoProduto.Width + iAumento;
  pnlCabecalho2.Left := pnlCabecalho2.Left + iAumento;

end;

procedure TfrlDANFeRLPaisagem.rlbItensBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var i, iAumento: Integer;
begin

  // Controla os itens por página
  iItemAtual := iItemAtual + 1;

  if FProdutosPorPagina = 0 then
    rlbItens.PageBreaking := pbNone
  else
    begin
      if iItemAtual = FProdutosPorPagina then
        begin
          if RLNFe.PageNumber = 2 then
            rlbItens.PageBreaking := pbAfterPrint
          else
            rlbItens.PageBreaking := pbBeforePrint;
        end
      else
        rlbItens.PageBreaking := pbNone;
    end; // if FProdutosPorPagina = 0

  for i := 1 to 16 do
    TRLDraw(FindComponent ('LinhaProd' + intToStr(i))).Height :=
                                                        (LinhaFimItens.Top + 1);

  if RLNFe.PageNumber > 1 then
    begin
      iAumento := pnlCanhoto.Width + pnlDivisao.Width;
      pnlDescricao1.Width := pnlDescricao1.Width + iAumento;
      rlmDescricao.Width := rlmDescricao.Width + iAumento;
      LinhaFimItens.Width := LinhaFimItens.Width + iAumento;
      pnlDescricao2.Left := pnlDescricao2.Left + iAumento;
    end;

end;

procedure TfrlDANFeRLPaisagem.rlbDadosAdicionaisAfterPrint(
  Sender: TObject);
var iAumento: Integer;
begin
  iAumento := pnlCanhoto.Width + pnlDivisao.Width;
  case FPosCanhoto of
    pcCabecalho: rlbObsItem.Left := rlbObsItem.Left - iAumento;
    pcRodape: rlbObsItem.Left := rlbObsItem.Left;
  end;
end;

procedure TfrlDANFeRLPaisagem.rlbObsItemBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var iAumento: Integer;
begin
  if RLNFe.PageNumber > 1 then
    begin
      iAumento := pnlCanhoto.Width + pnlDivisao.Width;
      rlbObsItem.Width := rlbObsItem.Width + iAumento;
      LinhaObsItemDireita.Left := LinhaObsItemDireita.Left + iAumento;
      LinhaFimObsItem.Width := LinhaFimObsItem.Width + iAumento;
      LinhaInicioItem.Width := LinhaInicioItem.Width + iAumento;
      rlmObsItem.Width := rlmObsItem.Width + iAumento;
    end;
end;

procedure TfrlDANFeRLPaisagem.rlbEmitenteAfterPrint(Sender: TObject);
begin
  iItemAtual := 0;
end;

procedure TfrlDANFeRLPaisagem.ConfigureDataSource;
begin
  self.rlmDescricao.DataSource := DataSource1;
  self.RLNFe.DataSource := DataSource1;
  txtEAN.DataSource := DataSource1;
  self.txtCodigo.DataSource := DataSource1;
  self.txtNCM.DataSource := DataSource1;
  self.txtCST.DataSource := DataSource1;
  self.txtCFOP.DataSource := DataSource1;
  self.txtUnidade.DataSource := DataSource1;
  self.txtQuantidade.DataSource := DataSource1;
  self.txtValorUnitario.DataSource := DataSource1;
  self.txtValorTotal.DataSource := DataSource1;
  self.txtBaseICMS.DataSource := DataSource1;
  self.txtValorICMS.DataSource := DataSource1;
  self.txtValorIPI.DataSource := DataSource1;
  self.txtAliqICMS.DataSource := DataSource1;
  self.txtAliqIPI.DataSource := DataSource1;
  self.txtValorDesconto.DataSource := DataSource1;
end;

end.
