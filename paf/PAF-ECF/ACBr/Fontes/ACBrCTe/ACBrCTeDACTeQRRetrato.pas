
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

{$I ACBr.inc}

unit ACBrCTeDACTeQRRetrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, XMLIntf, XMLDoc, 
  JPEG, ACBrCTeQRCodeBar, pcnConversao, DB,
  DBClient, ACBrCTeDACTeQR, qrRRect;

type
  TfrmDACTeQRRetrato = class(TfrmDACTeQR)
    qrb_08_Itens: TQRBand;
    qrdbtTpDoc1: TQRDBText;
    cdsDocumentos: TClientDataSet;
    qrdbtCnpjEmitente1: TQRDBText;
    qrdbtDocumento1: TQRDBText;
    qrdbtDocumento2: TQRDBText;
    qrdbtCnpjEmitente2: TQRDBText;
    qrdbtTpDoc2: TQRDBText;
    cdsDocumentosTIPO_1: TStringField;
    cdsDocumentosCNPJCPF_1: TStringField;
    cdsDocumentosDOCUMENTO_1: TStringField;
    cdsDocumentosTIPO_2: TStringField;
    cdsDocumentosCNPJCPF_2: TStringField;
    cdsDocumentosDOCUMENTO_2: TStringField;
    QRShape29: TQRShape;
    qrb_01_Recibo: TQRBand;
    qrsLinhaH03: TQRShape;
    qrmEmitente: TQRMemo;
    qrmDadosEmitente: TQRMemo;
    qriLogo: TQRImage;
    qriBarCode: TQRImage;
    qrlNumCte: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel73: TQRLabel;
    QRLabel74: TQRLabel;
    qrlChave: TQRLabel;
    qrlPageNumber: TQRLabel;
    qrlSerie: TQRLabel;
    qrlModelo: TQRLabel;
    qrlEmissao: TQRLabel;
    qrlModal: TQRLabel;
    qrlProtocolo: TQRLabel;
    qrlTipoCte: TQRLabel;
    qrlDescricao: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel9: TQRLabel;
    qrlTipoServico: TQRLabel;
    QRLabel28: TQRLabel;
    qrlTomaServico: TQRLabel;
    QRLabel78: TQRLabel;
    qrlFormaPagamento: TQRLabel;
    qrlInscSuframa: TQRLabel;
    qrb_07_HeaderItens: TQRBand;
    QRLabel20: TQRLabel;
    QRShape32: TQRShape;
    QRLabel91: TQRLabel;
    QRLabel92: TQRLabel;
    QRLabel96: TQRLabel;
    QRLabel100: TQRLabel;
    QRLabel106: TQRLabel;
    QRLabel109: TQRLabel;
    QRShape34: TQRShape;
    QRShape28: TQRShape;
    QRShape35: TQRShape;
    qrsFimItens: TQRShape;
    qrb_09_Obs: TQRBand;
    qrb_02_Cabecalho: TQRChildBand;
    QRLabel29: TQRLabel;
    qrlNatOperacao: TQRLabel;
    QRLabel12: TQRLabel;
    qrlOrigPrestacao: TQRLabel;
    QRLabel14: TQRLabel;
    qrlDestPrestacao: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel26: TQRLabel;
    qrlRazaoRemet: TQRLabel;
    qrlEnderecoRemet1: TQRLabel;
    qrlEnderecoRemet2: TQRLabel;
    qrlMunRemet: TQRLabel;
    qrlCnpjRemet: TQRLabel;
    qrlPaisRemet: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel79: TQRLabel;
    qrlRazaoDest: TQRLabel;
    qrlEnderecoDest1: TQRLabel;
    qrlEnderecoDest2: TQRLabel;
    QRLabel93: TQRLabel;
    qrlInscEstRemet: TQRLabel;
    QRLabel95: TQRLabel;
    qrlFoneRemet: TQRLabel;
    qrlCEPRemet: TQRLabel;
    QRLabel98: TQRLabel;
    qrlMunDest: TQRLabel;
    qrlPaisDest: TQRLabel;
    qrlCnpjDest: TQRLabel;
    QRLabel114: TQRLabel;
    qrlInscEstDest: TQRLabel;
    QRLabel116: TQRLabel;
    qrlFoneDest: TQRLabel;
    qrlCEPDest: TQRLabel;
    QRLabel119: TQRLabel;
    QRLabel86: TQRLabel;
    QRLabel87: TQRLabel;
    QRLabel88: TQRLabel;
    QRLabel89: TQRLabel;
    QRLabel90: TQRLabel;
    qrlRazaoExped: TQRLabel;
    qrlEnderecoExped1: TQRLabel;
    qrlEnderecoExped2: TQRLabel;
    QRLabel99: TQRLabel;
    QRLabel101: TQRLabel;
    QRLabel102: TQRLabel;
    QRLabel103: TQRLabel;
    QRLabel104: TQRLabel;
    qrlRazaoReceb: TQRLabel;
    qrlEnderecoReceb1: TQRLabel;
    qrlEnderecoReceb2: TQRLabel;
    qrlMunExped: TQRLabel;
    qrlPaisExped: TQRLabel;
    qrlCnpjExped: TQRLabel;
    QRLabel105: TQRLabel;
    qrlInscEstExped: TQRLabel;
    QRLabel107: TQRLabel;
    qrlFoneExped: TQRLabel;
    qrlCEPExped: TQRLabel;
    QRLabel110: TQRLabel;
    qrlMunReceb: TQRLabel;
    qrlPaisReceb: TQRLabel;
    qrlCnpjReceb: TQRLabel;
    QRLabel123: TQRLabel;
    qrlInscEstReceb: TQRLabel;
    QRLabel125: TQRLabel;
    qrlFoneReceb: TQRLabel;
    qrlCEPReceb: TQRLabel;
    QRLabel128: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    QRLabel94: TQRLabel;
    qrlCEPToma: TQRLabel;
    QRLabel97: TQRLabel;
    qrlEnderecoToma: TQRLabel;
    QRLabel82: TQRLabel;
    qrlCnpjToma: TQRLabel;
    QRLabel108: TQRLabel;
    qrlInscEstToma: TQRLabel;
    QRLabel111: TQRLabel;
    qrlFoneToma: TQRLabel;
    qrlRazaoToma: TQRLabel;
    QRLabel113: TQRLabel;
    qrlPaisToma: TQRLabel;
    qrlMunToma: TQRLabel;
    qrb_10_ModRodFracionado: TQRChildBand;
    qrb_11_ModRodLotacao: TQRChildBand;
    QRLabel10: TQRLabel;
    QRShape1: TQRShape;
    qrmObs: TQRMemo;
    qrlTituloLotacao: TQRLabel;
    QRShape24: TQRShape;
    QRLabel11: TQRLabel;
    QRShape36: TQRShape;
    QRShape37: TQRShape;
    QRShape38: TQRShape;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
    QRLabel85: TQRLabel;
    qrlRntrcEmpresa: TQRLabel;
    qrlLotacao: TQRLabel;
    qrlDtPrevEntrega: TQRLabel;
    qrmObsExcEmitente: TQRMemo;
    qrlMsgTeste: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape27: TQRShape;
    qrb_03_DadosDACTe: TQRChildBand;
    QRLabel1: TQRLabel;
    qrlProdPredominante: TQRLabel;
    QRLabel4: TQRLabel;
    qrlOutrasCaracCarga: TQRLabel;
    QRLabel34: TQRLabel;
    qrlVlrTotalMerc: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel5: TQRLabel;
    qrlNomeSeguradora: TQRLabel;
    QRLabel37: TQRLabel;
    qrlRespSeguroMerc: TQRLabel;
    QRLabel39: TQRLabel;
    qrlNroApolice: TQRLabel;
    QRLabel40: TQRLabel;
    qrlNroAverbacao: TQRLabel;
    QRShape8: TQRShape;
    QRShape7: TQRShape;
    qrb_04_DadosNotaFiscal: TQRChildBand;
    qrb_05_Complemento: TQRChildBand;
    QRLabel38: TQRLabel;
    QRLabel44: TQRLabel;
    qrmCompNome1: TQRMemo;
    QRLabel46: TQRLabel;
    qrmCompValor1: TQRMemo;
    QRLabel42: TQRLabel;
    qrmCompNome2: TQRMemo;
    QRLabel45: TQRLabel;
    qrmCompValor2: TQRMemo;
    QRLabel47: TQRLabel;
    qrmCompNome3: TQRMemo;
    QRLabel48: TQRLabel;
    qrmCompValor3: TQRMemo;
    QRLabel49: TQRLabel;
    qrlVlrTotServico: TQRLabel;
    QRLabel50: TQRLabel;
    qrlVlrTotReceber: TQRLabel;
    QRShape18: TQRShape;
    QRShape17: TQRShape;
    QRShape16: TQRShape;
    QRShape15: TQRShape;
    QRShape19: TQRShape;
    QRLabel51: TQRLabel;
    QRLabel52: TQRLabel;
    qrlSitTrib: TQRLabel;
    QRLabel55: TQRLabel;
    qrlBaseCalc: TQRLabel;
    QRLabel56: TQRLabel;
    qrlAliqICMS: TQRLabel;
    QRLabel54: TQRLabel;
    qrlVlrICMS: TQRLabel;
    QRLabel53: TQRLabel;
    qrlRedBaseCalc: TQRLabel;
    QRLabel58: TQRLabel;
    qrlICMS_ST: TQRLabel;
    QRShape26: TQRShape;
    QRShape25: TQRShape;
    QRShape23: TQRShape;
    QRShape22: TQRShape;
    QRShape21: TQRShape;
    QRShape20: TQRShape;
    QRLabel59: TQRLabel;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    qrmComplChave1: TQRMemo;
    qrmComplValor1: TQRMemo;
    qrmComplChave2: TQRMemo;
    qrmComplValor2: TQRMemo;
    qrsQuadro01: TQRShape;
    qrsQuadro02: TQRShape;
    qrsQuadro03: TQRShape;
    qrsQuadro04: TQRShape;
    qrsQuadro05: TQRShape;
    qrsQuadro07: TQRShape;
    qrsQuadro08: TQRShape;
    qrsQuadro09: TQRShape;
    qrsLinhaV10: TQRShape;
    qrsLinhaV04: TQRShape;
    qrsLinhaH01: TQRShape;
    qrsLinhaH02: TQRShape;
    qrsLinhaV09: TQRShape;
    qrsLinhaV08: TQRShape;
    qrsLinhaV06: TQRShape;
    qrsLinhaV05: TQRShape;
    qrsLinhaH04: TQRShape;
    qrsLinhaV07: TQRShape;
    qrsLinhaV03: TQRShape;
    qrsLinhaV02: TQRShape;
    qrsLinhaV01: TQRShape;
    qrsLinhaV11: TQRShape;
    qrsLinhaH06: TQRShape;
    qrsLinhaH07: TQRShape;
    qrsLinhaH05: TQRShape;
    qrsLinhaH08: TQRShape;
    QRShape55: TQRShape;
    QRShape9: TQRShape;
    QRShape56: TQRShape;
    QRShape58: TQRShape;
    QRShape59: TQRShape;
    QRShape60: TQRShape;
    QRShape61: TQRShape;
    QRShape62: TQRShape;
    qrb_17_Sistema: TQRChildBand;
    qrb_18_Recibo: TQRChildBand;
    QRShape10: TQRShape;
    QRLabel65: TQRLabel;
    QRShape2: TQRShape;
    QRLabel66: TQRLabel;
    QRLabel70: TQRLabel;
    QRShape3: TQRShape;
    QRShape53: TQRShape;
    QRLabel69: TQRLabel;
    QRShape4: TQRShape;
    QRShape30: TQRShape;
    QRLabel67: TQRLabel;
    qrlDHChegada: TQRLabel;
    QRLabel68: TQRLabel;
    QRLabel72: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel57: TQRLabel;
    qrlNumCte1: TQRLabel;
    QRLabel60: TQRLabel;
    qrlSerie1: TQRLabel;
    QRShape11: TQRShape;
    QRLabel71: TQRLabel;
    QRShape12: TQRShape;
    QRLabel75: TQRLabel;
    QRShape13: TQRShape;
    QRLabel76: TQRLabel;
    QRLabel112: TQRLabel;
    QRLabel115: TQRLabel;
    QRLabel117: TQRLabel;
    QRShape14: TQRShape;
    QRShape31: TQRShape;
    QRShape33: TQRShape;
    QRLabel118: TQRLabel;
    QRLabel120: TQRLabel;
    QRLabel121: TQRLabel;
    QRShape39: TQRShape;
    QRLabel122: TQRLabel;
    QRLabel124: TQRLabel;
    QRLabel126: TQRLabel;
    QRLabel127: TQRLabel;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRLabel129: TQRLabel;
    QRLabel130: TQRLabel;
    QRLabel131: TQRLabel;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    qrb_16_DadosExcEmitente: TQRChildBand;
    QRLabel15: TQRLabel;
    QRSysData1: TQRSysData;
    qrlblSistema: TQRLabel;
    qrlNomeMotorista: TQRLabel;
    qrlCPFMotorista: TQRLabel;
    qrlNumRegEsp: TQRLabel;
    qrlResponsavel: TQRLabel;
    qrlValorTotal: TQRLabel;
    qrlLacres: TQRLabel;
    qrmTipo: TQRMemo;
    qrmPlaca: TQRMemo;
    qrmUF: TQRMemo;
    qrmRNTRC: TQRMemo;
    qrmEmpresas: TQRMemo;
    qrmVigencias: TQRMemo;
    qrmNumDispositivo: TQRMemo;
    qrmCodTransacao: TQRMemo;
    QRShape45: TQRShape;
    qrmQtdUnidMedida1: TQRMemo;
    qrmQtdUnidMedida2: TQRMemo;
    qrmQtdUnidMedida3: TQRMemo;
    qrmQtdUnidMedida4: TQRMemo;
    qrb_06_ValorPrestacao: TQRChildBand;
    QRShape46: TQRShape;
    QRShape48: TQRShape;
    QRShape49: TQRShape;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel132: TQRLabel;
    QRLabel133: TQRLabel;
    QRLabel134: TQRLabel;
    QRLabel135: TQRLabel;
    QRLabel136: TQRLabel;
    QRLabel137: TQRLabel;
    QRLabel138: TQRLabel;
    QRLabel139: TQRLabel;
    QRLabel140: TQRLabel;
    qrlSerie2: TQRLabel;
    qrlNumCTe2: TQRLabel;
    QRLabel143: TQRLabel;
    qrb_12_ModAereo: TQRChildBand;
    qrb_13_ModAquaviario: TQRChildBand;
    qrb_14_ModFerroviario: TQRChildBand;
    qrb_15_ModDutoviario: TQRChildBand;
    QRShape47: TQRShape;
    QRShape54: TQRShape;
    QRShape63: TQRShape;
    QRShape64: TQRShape;
    QRShape65: TQRShape;
    QRShape66: TQRShape;
    QRShape67: TQRShape;
    QRShape68: TQRShape;
    QRShape69: TQRShape;
    QRLabel141: TQRLabel;
    QRLabel142: TQRLabel;
    QRLabel144: TQRLabel;
    QRLabel145: TQRLabel;
    QRLabel146: TQRLabel;
    QRLabel147: TQRLabel;
    QRLabel148: TQRLabel;
    QRLabel149: TQRLabel;
    QRLabel150: TQRLabel;
    QRLabel153: TQRLabel;
    qrlTrecho: TQRLabel;
    qrlTarifaValor: TQRLabel;
    qrlTarifaCodigo: TQRLabel;
    qrlTarifaCL: TQRLabel;
    qrlMinuta: TQRLabel;
    qrlDadosRetira: TQRLabel;
    qrlAWB: TQRLabel;
    QRLabel154: TQRLabel;
    QRLabel155: TQRLabel;
    qrlCaracAdServico: TQRLabel;
    qrlCaracAdTransporte: TQRLabel;
    QRShape57: TQRShape;
    QRShape72: TQRShape;
    QRLabel156: TQRLabel;
    qrlContaCorrente: TQRLabel;
    QRLabel157: TQRLabel;
    qrlLojaAgenteEmissor: TQRLabel;
    qrlRetira: TQRLabel;
    QRShape70: TQRShape;
    QRShape71: TQRShape;
    QRShape73: TQRShape;
    QRLabel151: TQRLabel;
    QRShape74: TQRShape;
    QRLabel152: TQRLabel;
    qrlPortoEmbarque: TQRLabel;
    QRLabel158: TQRLabel;
    qrlPortoDestino: TQRLabel;
    QRShape75: TQRShape;
    QRLabel159: TQRLabel;
    qrlIndNavioRebocador: TQRLabel;
    QRShape76: TQRShape;
    QRLabel160: TQRLabel;
    qrlIndConteiners: TQRLabel;
    QRShape77: TQRShape;
    QRLabel162: TQRLabel;
    qrlBCAFRMM: TQRLabel;
    QRLabel164: TQRLabel;
    qrlValorAFRMM: TQRLabel;
    QRLabel166: TQRLabel;
    qrlTipoNav: TQRLabel;
    QRLabel168: TQRLabel;
    qrlDirecao: TQRLabel;
    QRShape78: TQRShape;
    QRShape79: TQRShape;
    QRShape80: TQRShape;
    procedure QRCTeBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure qrb_01_ReciboBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_02_CabecalhoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_03_DadosDACTeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_04_DadosNotaFiscalBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_05_ComplementoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_06_ValorPrestacaoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_07_HeaderItensBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_08_ItensBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_09_ObsAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrb_09_ObsBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_10_ModRodFracionadoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_11_ModRodLotacaoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_18_ReciboBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_17_SistemaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_16_DadosExcEmitenteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_12_ModAereoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_13_ModAquaviarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_14_ModFerroviarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_15_ModDutoviarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    FTotalPages: integer;
    procedure Itens;
  public
    procedure ProtocoloCTe(const sProtocolo: string);
  end;

implementation

uses
  StrUtils, ACBrCTeUtil, DateUtils;

{$R *.dfm}

const
  _NUM_ITEMS_PAGE1      = 26; //esse valor eh dobrado por ter 2 NF por linha
  _NUM_ITEMS_OTHERPAGES = 88;

var
  FProtocoloCTe : string;
  nItemControle : Integer;
  Fracionado    : Integer;

procedure TfrmDACTeQRRetrato.Itens;
var
  I, J, K, Item : Integer;
begin
  if QRCTe.PageNumber > 0 then
    exit;

  cdsDocumentos.CreateDataSet;
  cdsDocumentos.Open;
  Item := 0;
  //Varrendo NF comum
  for I := 0 to (FCTe.Rem.InfNF.Count - 1) do
  begin
    with FCTe.Rem.InfNF.Items[I] do
    begin
      if (Item mod 2) = 0 then
      begin
        cdsDocumentos.Append;

        cdsDocumentosTIPO_1.AsString := 'NF';
        cdsDocumentosCNPJCPF_1.AsString := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
        cdsDocumentosDOCUMENTO_1.AsString := serie + '-' + nDoc;
      end
      else
      begin
        cdsDocumentosTIPO_2.AsString := 'NF';
        cdsDocumentosCNPJCPF_2.AsString := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
        cdsDocumentosDOCUMENTO_2.AsString := serie + '-' + nDoc;

        cdsDocumentos.Post;
      end;
      inc(Item);
    end;
  end;
  //Varrendo NFe
  for I := 0 to (FCTe.Rem.InfNFE.Count - 1) do
  begin
    with FCTe.Rem.InfNFE.Items[I] do
    begin
      if (Item mod 2) = 0 then
      begin
        cdsDocumentos.Append;
        cdsDocumentosTIPO_1.AsString := 'NF-E';
        // Alterado por Italo em 17/05/2011
        cdsDocumentosCNPJCPF_1.AsString := CTeUtil.FormatarChaveAcesso(chave, True);
      end
      else
      begin
        cdsDocumentosTIPO_2.AsString := 'NF-E';
        // Alterado por Italo em 17/05/2011
        cdsDocumentosCNPJCPF_2.AsString := CTeUtil.FormatarChaveAcesso(chave, True);
        cdsDocumentos.Post;
      end;
      inc(Item);
    end;
  end;
  //Varrendo Outros
  for I := 0 to (FCTe.Rem.InfOutros.Count - 1) do
  begin
    with FCTe.Rem.InfOutros.Items[I] do
    begin
      if (Item mod 2) = 0 then
      begin
        cdsDocumentos.Append;
        cdsDocumentosTIPO_1.AsString := descOutros;
        cdsDocumentosCNPJCPF_1.AsString := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
        cdsDocumentosDOCUMENTO_1.AsString := nDoc;
      end
      else
      begin
        cdsDocumentosTIPO_2.AsString := descOutros;
        cdsDocumentosCNPJCPF_2.AsString := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
        cdsDocumentosDOCUMENTO_2.AsString := nDoc;
        cdsDocumentos.Post;
      end;
      inc(Item);
    end;
  end;
 //Varrendo Documentos de Transporte anterior
 // Incluido / Alterado por Italo em 13/12/2010
  for I := 0 to (FCTe.infCTeNorm.emiDocAnt.Count - 1) do
  begin
    // Em Papel
    // Alterado por Italo em 27/12/2010
    for J := 0 to (FCTe.infCTeNorm.emiDocAnt.Items[I].idDocAnt.Count - 1) do
    begin
      for K := 0 to (FCTe.infCTeNorm.emiDocAnt.Items[I].idDocAnt.Items[J].idDocAntPap.Count - 1) do
      begin
        with FCTe.infCTeNorm.emiDocAnt.Items[I].idDocAnt.Items[J].idDocAntPap.Items[K] do
        begin
          if (Item mod 2) = 0 then
          begin
            cdsDocumentos.Append;

            case tpDoc of
             daCTRC: cdsDocumentosTIPO_1.AsString := 'CTRC';
             daCTAC: cdsDocumentosTIPO_1.AsString := 'CTAC';
             daACT:  cdsDocumentosTIPO_1.AsString := 'ACT';
             daNF7:  cdsDocumentosTIPO_1.AsString := 'NF M7';
             daNF27: cdsDocumentosTIPO_1.AsString := 'NF M27';
             daCAN:  cdsDocumentosTIPO_1.AsString := 'CAN';
             daCTMC: cdsDocumentosTIPO_1.AsString := 'CTMC';
             daATRE: cdsDocumentosTIPO_1.AsString := 'ATRE';
             daDTA:  cdsDocumentosTIPO_1.AsString := 'DTA';
             daCAI:  cdsDocumentosTIPO_1.AsString := 'CAI';
             daCCPI: cdsDocumentosTIPO_1.AsString := 'CCPI';
             daCA:   cdsDocumentosTIPO_1.AsString := 'CA';
             daTIF:  cdsDocumentosTIPO_1.AsString := 'TIF';
             daOutros: cdsDocumentosTIPO_1.AsString := 'Outros';
            end;
            cdsDocumentosCNPJCPF_1.AsString := CTeUtil.FormatarCNPJ(FCTe.infCTeNorm.emiDocAnt.Items[I].CNPJCPF);
            cdsDocumentosDOCUMENTO_1.AsString := serie + '-' + IntToStr(nDoc);
          end
          else
          begin
            case tpDoc of
             daCTRC: cdsDocumentosTIPO_2.AsString := 'CTRC';
             daCTAC: cdsDocumentosTIPO_2.AsString := 'CTAC';
             daACT:  cdsDocumentosTIPO_2.AsString := 'ACT';
             daNF7:  cdsDocumentosTIPO_2.AsString := 'NF M7';
             daNF27: cdsDocumentosTIPO_2.AsString := 'NF M27';
             daCAN:  cdsDocumentosTIPO_2.AsString := 'CAN';
             daCTMC: cdsDocumentosTIPO_2.AsString := 'CTMC';
             daATRE: cdsDocumentosTIPO_2.AsString := 'ATRE';
             daDTA:  cdsDocumentosTIPO_2.AsString := 'DTA';
             daCAI:  cdsDocumentosTIPO_2.AsString := 'CAI';
             daCCPI: cdsDocumentosTIPO_2.AsString := 'CCPI';
             daCA:   cdsDocumentosTIPO_2.AsString := 'CA';
             daTIF:  cdsDocumentosTIPO_2.AsString := 'TIF';
             daOutros: cdsDocumentosTIPO_2.AsString := 'Outros';
            end;
            cdsDocumentosCNPJCPF_2.AsString := CTeUtil.FormatarCNPJ(FCTe.infCTeNorm.emiDocAnt.Items[I].CNPJCPF);
            cdsDocumentosDOCUMENTO_2.AsString := serie + '-' + IntToStr(nDoc);

            cdsDocumentos.Post;
          end;
          inc(Item);
        end;
      end;
    end;

    // Eletrônico
    // Alterado por Italo em 27/12/2010
    for J := 0 to (FCTe.infCTeNorm.emiDocAnt.Items[I].idDocAnt.Count - 1) do
    begin
      for K := 0 to (FCTe.infCTeNorm.emiDocAnt.Items[I].idDocAnt.Items[J].idDocAntEle.Count - 1) do
      begin
        with FCTe.infCTeNorm.emiDocAnt.Items[I].idDocAnt.Items[J].idDocAntEle.Items[K] do
        begin
          if (Item mod 2) = 0 then
          begin
            cdsDocumentos.Append;

            cdsDocumentosTIPO_1.AsString := 'CT-E';
            // Alterado por Italo em 17/05/2011
            cdsDocumentosCNPJCPF_1.AsString := CTeUtil.FormatarChaveAcesso(chave, True);
          end
          else
          begin
            cdsDocumentosTIPO_2.AsString := 'CT-E';
            // Alterado por Italo em 17/05/2011
            cdsDocumentosCNPJCPF_2.AsString := CTeUtil.FormatarChaveAcesso(chave, True);

            cdsDocumentos.Post;
          end;
          inc(Item);
        end;
      end;
    end;

  end;

  cdsDocumentos.First;
end;

procedure TfrmDACTeQRRetrato.ProtocoloCTe(const sProtocolo: string);
begin
  FProtocoloCTe := sProtocolo;
end;

procedure TfrmDACTeQRRetrato.QRCTeBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  nRestItens, nTotalItens : Integer;
begin
  inherited;
  Itens;
  nItemControle := 0;
  FTotalPages   := 1;
  nTotalItens   := 0;

  // Incluido por Italo em 20/04/2011
  if (FCTe.Rem.InfNF.Count > 0)
   then nTotalItens := FCTe.Rem.InfNF.Count
   else begin
    if (FCTe.Rem.InfNFE.Count > 0)
     then nTotalItens := FCTe.Rem.InfNFE.Count
     else begin
      if (FCTe.Rem.InfOutros.Count > 0)
       then nTotalItens := FCTe.Rem.InfOutros.Count;
     end;
   end;

  // Incluido por Italo em 06/05/2011
  qrb_10_ModRodFracionado.Height := 0;
  qrb_11_ModRodLotacao.Height    := 0;
  qrb_12_ModAereo.Height         := 0;
  qrb_13_ModAquaviario.Height    := 0;
  qrb_14_ModFerroviario.Height   := 0;
  qrb_15_ModDutoviario.Height    := 0;

  case FCTe.Ide.modal of
   mdRodoviario: begin
                  // Incluido por Italo em 26/04/2011
                  if FCTe.Rodo.Lota = ltNao
                   then begin
                    qrb_10_ModRodFracionado.Height := 44;
                    //    qrb_11_ModRodLotacao.Height    := 0;
                    Fracionado                     := 10
                   end
                   else begin
                    qrb_10_ModRodFracionado.Height := 44;
                    qrb_11_ModRodLotacao.Height    := 108;
                    Fracionado                     := 0;
                   end;
                 end;
   mdAereo: begin
             qrb_12_ModAereo.Height := 97;
            end;
   mdAquaviario: begin
                  qrb_13_ModAquaviario.Height    := 0;
                 end;
   mdFerroviario: begin
                   qrb_14_ModFerroviario.Height   := 0;
                  end;
   mdDutoviario: begin
                  qrb_15_ModDutoviario.Height    := 0;
                 end;
  end;

  // Alterado por Italo em 20/04/2011
  if (nTotalItens > (_NUM_ITEMS_PAGE1 + Fracionado)) then
  begin
    nRestItens := nTotalItens - (_NUM_ITEMS_PAGE1 + Fracionado);
    if nRestItens <= (_NUM_ITEMS_OTHERPAGES + Fracionado) then
      Inc(FTotalPages)
    else
    begin
      Inc(FTotalPages, nRestItens div (_NUM_ITEMS_OTHERPAGES + Fracionado));
      if (nRestItens mod (_NUM_ITEMS_OTHERPAGES + Fracionado)) > 0 then
        Inc(FTotalPages)
    end;
  end;

  QRCTe.ReportTitle:='CT-e: ' + FormatFloat( '000,000,000', FCTe.Ide.nCT );

  QRCTe.Page.TopMargin    := FMargemSuperior * 100;
  QRCTe.Page.BottomMargin := FMargemInferior * 100;
  QRCTe.Page.LeftMargin   := FMargemEsquerda * 100;
  QRCTe.Page.RightMargin  := FMargemDireita  * 100;

  // Incluido por Italo em 26/04/2011
//  qrbObs.Height              := 72;
//  qrbRecibo.Height           := 68;
//  qrbSistema.Height          := 16;
//  qrbDadosExcEmitente.Height := 40;
end;

procedure TfrmDACTeQRRetrato.qrb_01_ReciboBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  // Incluido/Alterado por Italo em 20/04/2011 / 27/04/2011
  PrintBand := (QRCTe.PageNumber = 1) and (FPosRecibo = prCabecalho);

  qrlSerie2.Caption := IntToStr(FCTe.Ide.serie);
  qrlNumCte2.Caption := FormatFloat( '000,000,000', FCTe.Ide.nCT );
  // Incluido por Italo em 27/04/2011
  // TpcteTipoCTe = (tcNormal, tcComplemento, tcAnulacao, tcSubstituto);
  qrb_01_Recibo.Enabled:=(FCTe.Ide.tpCTe = tcNormal);
end;

procedure TfrmDACTeQRRetrato.qrb_02_CabecalhoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
 strChaveContingencia: string;
begin
  inherited;
  // Comentado por Italo em 20/04/2011
//  PrintBand := QRCTe.PageNumber = 1;

  if Trim(FLogo) <> '' then
   begin
   qriLogo.Picture.LoadFromFile(FLogo);
    if FExpandirLogoMarca then
     begin
      qriLogo.top:=2;
      qriLogo.Left:=2;
      qriLogo.Height:=145;
      qriLogo.Width:=433;
      qriLogo.Stretch:=true;
     end;
   end;

  qrlModal.Caption := TpModalToStrText(FCTe.Ide.modal);
  qrlModelo.Caption := FCTe.Ide.modelo;
  qrlSerie.Caption := IntToStr(FCTe.Ide.serie);
  qrlSerie1.Caption := IntToStr(FCTe.Ide.serie);
  qrlNumCte.Caption := FormatFloat( '000,000,000', FCTe.Ide.nCT );
  qrlNumCte1.Caption := FormatFloat( '000,000,000', FCTe.Ide.nCT );
  qrlPageNumber.Caption := format('%2.2d', [QRCTe.PageNumber]) + '/' + format('%2.2d', [FTotalPages]);
  qrlEmissao.Caption := CTeUtil.FormatDateTime(DateTimeToStr(FCTe.Ide.dhEmi));
  SetBarCodeImage(Copy(FCTe.InfCTe.Id, 4, 44), qriBarCode);
  qrlChave.Caption := CTeUtil.FormatarChaveAcesso(Copy(FCTe.InfCTe.Id, 4, 44));

  // Emitente
  with FCTe.Emit do
  begin
    qrmEmitente.Lines.Text := XNome;

    qrmDadosEmitente.Lines.Clear;
    with EnderEmit do
    begin
//      qrmDadosEmitente.Lines.Add(XLgr + IfThen(Nro = '0', '', ', ' + Nro) + ' ' + XCpl + ' ' + XBairro);
      // Alterado por Italo em 10/03/2011
      qrmDadosEmitente.Lines.Add(XLgr + IfThen(Nro = '0', '', ', ' + Nro));
      if XCpl<>'' then qrmDadosEmitente.Lines.Add(XCpl);
      if XBairro<>'' then qrmDadosEmitente.Lines.Add(XBairro);
      qrmDadosEmitente.Lines.Add('CEP: ' + CTeUtil.FormatarCEP(FormatFloat( '00000000', CEP )) + ' - ' + XMun + ' - ' + UF);
    end;
//    qrmDadosEmitente.Lines.Add('CNPJ: ' + CTeUtil.FormatarCNPJ(CNPJ) + ' INSCRIÇÃO ESTADUAL: ' + IE);
    // Alterado por Italo em 10/03/2011
    qrmDadosEmitente.Lines.Add('CNPJ: ' + CTeUtil.FormatarCNPJ(CNPJ));
    qrmDadosEmitente.Lines.Add('INSCRIÇÃO ESTADUAL: ' + IE);
    qrmDadosEmitente.Lines.Add('TELEFONE: ' + CTeUtil.FormatarFone(EnderEmit.Fone));

    if Trim(FUrl) <> '' then
      qrmDadosEmitente.Lines.Add(FUrl);
  end;

  qrlTipoCte.Caption := tpCTToStrText(FCTe.Ide.tpCTe);
  qrlTipoServico.Caption := TpServToStrText(FCTe.Ide.tpServ);
  // Alterado por Italo em 30/12/2010
  if FCTe.Ide.Toma4.xNome = ''
   then qrlTomaServico.Caption := TpTomadorToStrText(FCTe.Ide.Toma03.Toma)
   else qrlTomaServico.Caption := TpTomadorToStrText(FCTe.Ide.Toma4.toma);
  qrlFormaPagamento.Caption := tpforPagToStrText(FCTe.Ide.forPag);

  // As Linhas abaixo foram inseridas por Italo em 31/08/2010
  // Normal **************************************************************
  if FCTe.Ide.tpEmis in [teNormal, teSCAN] then
   begin
    if FCTe.procCTe.cStat = 100 then
     begin
      qrlDescricao.Caption:= 'PROTOCOLO DE AUTORIZAÇÃO DE USO';
     end;

    if FCTe.procCTe.cStat = 101 then
     begin
      qrlDescricao.Caption:= 'PROTOCOLO DE HOMOLOGAÇÃO DE CANCELAMENTO';
     end;

    if FCTe.procCTe.cStat = 102 then
     begin
      qrlDescricao.Caption:= 'PROTOCOLO DE DENEGAÇÃO DE USO';
     end;

    if FProtocoloCTE <> ''
     then qrlProtocolo.Caption := FProtocoloCTE
     else qrlProtocolo.Caption :=  FCTe.procCTe.nProt + ' ' +
                                 CTeUtil.SeSenao(FCTe.procCTe.dhRecbto <> 0,
                                      DateTimeToStr(FCTe.procCTe.dhRecbto), '');
   end;

  // As Linhas abaixo foram inseridas por Italo em 28/01/2011
  // Contingencia ********************************************************

  if FCTe.Ide.tpEmis in [teContingencia, teFSDA] then
   begin
    strChaveContingencia := CTeUtil.GerarChaveContingencia(FCTe);
    SetBarCodeImage(strChaveContingencia,qriBarCode);
    qrlDescricao.Caption := 'DADOS DO CT-E';
    qrlProtocolo.Caption := CTeUtil.FormatarChaveContingencia(strChaveContingencia);
   end;
  // DPEC ****************************************************************
  if FCTe.Ide.tpEmis = teDPEC then
   begin
    qrlDescricao.Caption := 'NÚMERO DE REGISTRO DPEC';
    qrlProtocolo.Caption := FProtocoloCTE;
   end;

  qrlInscSuframa.Caption := FCTe.Dest.ISUF;
end;

procedure TfrmDACTeQRRetrato.qrb_03_DadosDACTeBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
 i: Integer;
begin
  inherited;
  // Incluido por Italo em 20/04/2011
  PrintBand := QRCTe.PageNumber = 1;

  qrlNatOperacao.Caption := FormatFloat('0000', FCTe.Ide.CFOP) + ' - ' + FCTe.Ide.natOp;
  qrlOrigPrestacao.Caption := FCTe.Ide.xMunIni + ' - ' + FCTe.Ide.UFIni + ' - ' + FormatFloat('000', FCTe.Ide.cMunIni);
  qrlDestPrestacao.Caption := FCTe.Ide.xMunFim + ' - ' + FCTe.Ide.UFFim + ' - ' + FormatFloat('000', FCTe.Ide.cMunFim);

  //DADOS REMETENTE
  qrlRazaoRemet.Caption := FCTe.Rem.xNome;
  qrlEnderecoRemet1.Caption := FCTe.Rem.EnderReme.xLgr + ', ' + FCTe.Rem.EnderReme.nro;
  qrlEnderecoRemet2.Caption := FCTe.Rem.EnderReme.xCpl + ' - ' + FCTe.Rem.EnderReme.xBairro;
  qrlCEPRemet.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Rem.EnderReme.CEP ));
  qrlMunRemet.Caption := FCTe.Rem.EnderReme.xMun+' - '+FCTe.Rem.EnderReme.UF;
  qrlCnpjRemet.Caption := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
  qrlPaisRemet.Caption := FCTe.Rem.EnderReme.xPais;
  qrlInscEstRemet.Caption := FCTe.Rem.IE;
  qrlFoneRemet.Caption := CTeUtil.FormatarFone(FCTe.Rem.fone);

  //DADOS DESTINATARIO
  qrlRazaoDest.Caption := FCTe.Dest.xNome;
  qrlEnderecoDest1.Caption := FCTe.Dest.EnderDest.xLgr + ', ' + FCTe.Dest.EnderDest.nro;
  qrlEnderecoDest2.Caption := FCTe.Dest.EnderDest.xCpl + ' - ' + FCTe.Dest.EnderDest.xBairro;
  qrlCEPDest.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Dest.EnderDest.CEP));
  qrlMunDest.Caption := FCTe.Dest.EnderDest.xMun+' - '+FCTe.Dest.EnderDest.UF;
  qrlCnpjDest.Caption := CTeUtil.FormatarCNPJ(FCTe.Dest.CNPJCPF);
  qrlPaisDest.Caption := FCTe.Dest.EnderDest.xPais;
  qrlInscEstDest.Caption := FCTe.Dest.IE;
  qrlFoneDest.Caption := CTeUtil.FormatarFone(FCTe.Dest.fone);

  //DADOS EXPEDIDOR
  qrlRazaoExped.Caption := FCTe.Exped.xNome;
  qrlEnderecoExped1.Caption := FCTe.Exped.EnderExped.xLgr + ', ' + FCTe.Exped.EnderExped.nro;
  qrlEnderecoExped2.Caption := FCTe.Exped.EnderExped.xCpl + ' - ' + FCTe.Exped.EnderExped.xBairro;
  qrlCEPExped.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Exped.EnderExped.CEP));
  qrlMunExped.Caption := FCTe.Exped.EnderExped.xMun+' - '+FCTe.Exped.EnderExped.UF;
  qrlCnpjExped.Caption := CTeUtil.FormatarCNPJ(FCTe.Exped.CNPJCPF);
  qrlPaisExped.Caption := FCTe.Exped.EnderExped.xPais;
  qrlInscEstExped.Caption := FCTe.Exped.IE;
  qrlFoneExped.Caption := CTeUtil.FormatarFone(FCTe.Exped.fone);

  //DADOS RECEBEDOR
  qrlRazaoReceb.Caption := FCTe.Receb.xNome;
  qrlEnderecoReceb1.Caption := FCTe.Receb.EnderReceb.xLgr + ', ' + FCTe.Receb.EnderReceb.nro;
  qrlEnderecoReceb2.Caption := FCTe.Receb.EnderReceb.xCpl + ' - ' + FCTe.Receb.EnderReceb.xBairro;
  qrlCEPReceb.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Receb.EnderReceb.CEP));
  qrlMunReceb.Caption := FCTe.Receb.EnderReceb.xMun+' - '+FCTe.Receb.EnderReceb.UF;
  qrlCnpjReceb.Caption := CTeUtil.FormatarCNPJ(FCTe.Receb.CNPJCPF);
  qrlPaisReceb.Caption := FCTe.Receb.EnderReceb.xPais;
  qrlInscEstReceb.Caption := FCTe.Receb.IE;
  qrlFoneReceb.Caption := CTeUtil.FormatarFone(FCTe.Receb.fone);

  if FCTe.Ide.Toma4.xNome = ''
   then begin
    case FCTe.Ide.Toma03.Toma of
    tmRemetente:
      begin
        qrlRazaoToma.Caption := FCTe.Rem.xNome;
        qrlEnderecoToma.Caption := FCTe.Rem.EnderReme.xLgr + ', ' + FCTe.Rem.EnderReme.nro + ' - ' + FCTe.Rem.EnderReme.xCpl + ' - ' + FCTe.Rem.EnderReme.xBairro;
        qrlCEPToma.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Rem.EnderReme.CEP));
        qrlMunToma.Caption := FCTe.Rem.EnderReme.xMun+' - '+FCTe.Rem.EnderReme.UF;
        qrlCnpjToma.Caption := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
        qrlPaisToma.Caption := FCTe.Rem.EnderReme.xPais;
        qrlInscEstToma.Caption := FCTe.Rem.IE;
        qrlFoneToma.Caption := CTeUtil.FormatarFone(FCTe.Rem.fone);
      end;
    tmExpedidor:
      begin
        qrlRazaoToma.Caption := FCTe.Exped.xNome;
        qrlEnderecoToma.Caption := FCTe.Exped.EnderExped.xLgr + ', ' + FCTe.Exped.EnderExped.nro + ' - ' + FCTe.Exped.EnderExped.xCpl + ' - ' + FCTe.Exped.EnderExped.xBairro;
        qrlCEPToma.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Exped.EnderExped.CEP));
        qrlMunToma.Caption := FCTe.Exped.EnderExped.xMun+' - '+FCTe.Exped.EnderExped.UF;
        qrlCnpjToma.Caption := CTeUtil.FormatarCNPJ(FCTe.Exped.CNPJCPF);
        qrlPaisToma.Caption := FCTe.Exped.EnderExped.xPais;
        qrlInscEstToma.Caption := FCTe.Exped.IE;
        qrlFoneToma.Caption := CTeUtil.FormatarFone(FCTe.Exped.fone);
      end;
    tmRecebedor:
      begin
        qrlRazaoToma.Caption := FCTe.Receb.xNome;
        qrlEnderecoToma.Caption := FCTe.Receb.EnderReceb.xLgr + ', ' + FCTe.Receb.EnderReceb.nro + ' - ' + FCTe.Receb.EnderReceb.xCpl + ' - ' + FCTe.Receb.EnderReceb.xBairro;
        qrlCEPToma.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Receb.EnderReceb.CEP));
        qrlMunToma.Caption := FCTe.Receb.EnderReceb.xMun+' - '+FCTe.Receb.EnderReceb.UF;
        qrlCnpjToma.Caption := CTeUtil.FormatarCNPJ(FCTe.Receb.CNPJCPF);
        qrlPaisToma.Caption := FCTe.Receb.EnderReceb.xPais;
        qrlInscEstToma.Caption := FCTe.Receb.IE;
        qrlFoneToma.Caption := CTeUtil.FormatarFone(FCTe.Receb.fone);
      end;
    tmDestinatario:
      begin
        qrlRazaoToma.Caption := FCTe.Dest.xNome;
        qrlEnderecoToma.Caption := FCTe.Dest.EnderDest.xLgr + ', ' + FCTe.Dest.EnderDest.nro + ' - ' + FCTe.Dest.EnderDest.xCpl + ' - ' + FCTe.Dest.EnderDest.xBairro;
        qrlCEPToma.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Dest.EnderDest.CEP));
        qrlMunToma.Caption := FCTe.Dest.EnderDest.xMun+' - '+FCTe.Dest.EnderDest.UF;
        qrlCnpjToma.Caption := CTeUtil.FormatarCNPJ(FCTe.Dest.CNPJCPF);
        qrlPaisToma.Caption := FCTe.Dest.EnderDest.xPais;
        qrlInscEstToma.Caption := FCTe.Dest.IE;
        qrlFoneToma.Caption := CTeUtil.FormatarFone(FCTe.Dest.fone);
      end;
    end;
   end
   else begin
    qrlRazaoToma.Caption := FCTe.Ide.Toma4.xNome;
    qrlEnderecoToma.Caption := FCTe.Ide.Toma4.EnderToma.xLgr + ', ' + FCTe.Ide.Toma4.EnderToma.xNum + ' - ' + FCTe.Ide.Toma4.EnderToma.xCpl + ' - ' + FCTe.Ide.Toma4.EnderToma.xBairro;
    qrlCEPToma.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Ide.Toma4.EnderToma.CEP));
    qrlMunToma.Caption := FCTe.Ide.Toma4.EnderToma.xMun+' - '+FCTe.Ide.Toma4.EnderToma.UF;
    qrlCnpjToma.Caption := CTeUtil.FormatarCNPJ(FCTe.Ide.Toma4.CNPJCPF);
    qrlPaisToma.Caption := FCTe.Ide.Toma4.EnderToma.xPais;
    qrlInscEstToma.Caption := FCTe.Ide.Toma4.IE;
    qrlFoneToma.Caption := CTeUtil.FormatarFone(FCTe.Ide.Toma4.fone);
   end;

  qrlProdPredominante.Caption := FCTe.InfCarga.proPred;
  qrlOutrasCaracCarga.Caption := FCTe.InfCarga.xOutCat;
{$IFDEF PL_103}
  qrlVlrTotalMerc.Caption := CteUtil.FormatarValor(msk15x2, FCTe.InfCarga.vMerc);
{$ENDIF}
{$IFDEF PL_104}
  qrlVlrTotalMerc.Caption := CteUtil.FormatarValor(msk15x2, FCTe.InfCarga.vCarga);
{$ENDIF}

  {
  for i := 1 to 4 do
    TQRLabel(FindComponent('qrlQtdUndMedida' + intToStr(i))).Caption := '';

  for i := 0 to FCTe.InfCarga.InfQ.Count - 1 do
    TQRLabel(FindComponent('qrlQtdUndMedida' + intToStr(i + 1))).Caption :=
      CteUtil.FormatarValor(msk6x3, FCTe.InfCarga.InfQ.Items[i].qCarga) + '/' +
      FCTe.InfCarga.InfQ.Items[i].tpMed;
  }
  // Incluido por Italo em 28/02/2011
  qrmQtdUnidMedida1.Lines.Clear;
  qrmQtdUnidMedida2.Lines.Clear;
  qrmQtdUnidMedida3.Lines.Clear;
  qrmQtdUnidMedida4.Lines.Clear;

  for i := 0 to FCTe.InfCarga.InfQ.Count - 1 do
   begin
    case i of
     0,4,8: qrmQtdUnidMedida1.Lines.Add(CteUtil.FormatarValor(msk6x3,
            FCTe.InfCarga.InfQ.Items[i].qCarga) + '/' + FCTe.InfCarga.InfQ.Items[i].tpMed);
     1,5,9: qrmQtdUnidMedida2.Lines.Add(CteUtil.FormatarValor(msk6x3,
            FCTe.InfCarga.InfQ.Items[i].qCarga) + '/' + FCTe.InfCarga.InfQ.Items[i].tpMed);
     2,6,10: qrmQtdUnidMedida3.Lines.Add(CteUtil.FormatarValor(msk6x3,
             FCTe.InfCarga.InfQ.Items[i].qCarga) + '/' + FCTe.InfCarga.InfQ.Items[i].tpMed);
     3,7,11: qrmQtdUnidMedida4.Lines.Add(CteUtil.FormatarValor(msk6x3,
            FCTe.InfCarga.InfQ.Items[i].qCarga) + '/' + FCTe.InfCarga.InfQ.Items[i].tpMed);
    end;
   end;

  qrlNomeSeguradora.Caption := '';
  qrlRespSeguroMerc.Caption := '';
  qrlNroApolice.Caption := '';
  qrlNroAverbacao.Caption := '';

  if FCTe.InfSeg.Count > 0 then
  begin
    qrlNomeSeguradora.Caption := FCTe.InfSeg.Items[0].xSeg;
    qrlRespSeguroMerc.Caption := TpRspSeguroToStrText(FCTe.InfSeg.Items[0].respSeg);
    qrlNroApolice.Caption := FCTe.InfSeg.Items[0].nApol;
    qrlNroAverbacao.Caption := FCTe.InfSeg.Items[0].nAver;
  end;

  qrmCompNome1.Lines.Clear;
  qrmCompNome2.Lines.Clear;
  qrmCompNome3.Lines.Clear;
  qrmCompValor1.Lines.Clear;
  qrmCompValor2.Lines.Clear;
  qrmCompValor3.Lines.Clear;

  for i := 0 to FCTe.vPrest.comp.Count - 1 do
  begin
    case i of
      0,3,6,9:
        begin
          qrmCompNome1.Lines.Add(FCTe.vPrest.comp[i].xNome);
          qrmCompValor1.Lines.Add(CteUtil.FormatarValor(msk10x2, FCTe.vPrest.comp[i].vComp));
        end;
      1,4,7,10:
        begin
          qrmCompNome2.Lines.Add(FCTe.vPrest.comp[i].xNome);
          qrmCompValor2.Lines.Add(CteUtil.FormatarValor(msk10x2, FCTe.vPrest.comp[i].vComp));
        end;
      2,5,8,11:
        begin
          qrmCompNome3.Lines.Add(FCTe.vPrest.comp[i].xNome);
          qrmCompValor3.Lines.Add(CteUtil.FormatarValor(msk10x2, FCTe.vPrest.comp[i].vComp));
        end;
    end;
  end;

  qrlVlrTotServico.Caption := CteUtil.FormatarValor(msk13x2, FCTe.vPrest.vTPrest);
  qrlVlrTotReceber.Caption := CteUtil.FormatarValor(msk13x2, FCTe.vPrest.vRec);

  qrlSitTrib.Caption := CSTICMSToStr(FCTe.Imp.ICMS.SituTrib)+'-'+
                        CSTICMSToStrTagPosText(FCTe.Imp.ICMS.SituTrib);

  case FCTe.Imp.ICMS.SituTrib of
    cst00:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST00.vBC);
//        qrlAliqICMS.Caption    := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST00.pICMS);
        qrlAliqICMS.Caption    := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST00.pICMS);
        qrlVlrICMS.Caption     := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST00.vICMS);
        qrlICMS_ST.Caption     := '';
      end;
    cst20:
      begin
        qrlRedBaseCalc.Caption := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST20.pRedBC);
        qrlBaseCalc.Caption    := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST20.vBC);
//        qrlAliqICMS.Caption    := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST20.pICMS);
        qrlAliqICMS.Caption    := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST00.pICMS);
        qrlVlrICMS.Caption     := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST20.vICMS);
        qrlICMS_ST.Caption     := '';
        // CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST20.vICMS);
      end;
    cst40:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := '';
        qrlAliqICMS.Caption    := '';
        qrlVlrICMS.Caption     := '';
        qrlICMS_ST.Caption     := '';
      end;
    cst41:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := '';
        qrlAliqICMS.Caption    := '';
        qrlVlrICMS.Caption     := '';
        qrlICMS_ST.Caption     := '';
      end;
    cst45:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := '';
        qrlAliqICMS.Caption    := '';
        qrlVlrICMS.Caption     := '';
        qrlICMS_ST.Caption     := '';
      end;
    cst51:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := '';
        qrlAliqICMS.Caption    := '';
        qrlVlrICMS.Caption     := '';
        qrlICMS_ST.Caption     := '';
      end;
    cst80:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST80.vBC);
//        qrlAliqICMS.Caption    := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST80.pICMS);
        qrlAliqICMS.Caption    := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST80.pICMS);
        qrlVlrICMS.Caption     := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST80.vICMS);
        qrlICMS_ST.Caption     := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST80.vCred);
      end;
    cst81:
      begin
        qrlRedBaseCalc.Caption := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST81.pRedBC);
        qrlBaseCalc.Caption    := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST81.vBC);
//        qrlAliqICMS.Caption    := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST81.pICMS);
        qrlAliqICMS.Caption    := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST81.pICMS);
        qrlVlrICMS.Caption     := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST81.vICMS);
        qrlICMS_ST.Caption     := '';
        // CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST81.vICMS);
      end;
    cst90:
      begin
        qrlRedBaseCalc.Caption := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST90.pRedBC);
        qrlBaseCalc.Caption    := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST90.vBC);
//        qrlAliqICMS.Caption    := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST90.pICMS);
        qrlAliqICMS.Caption    := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST90.pICMS);
        qrlVlrICMS.Caption     := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST90.vICMS);
        qrlICMS_ST.Caption     := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST90.vCred);
      end;
  end;
end;

procedure TfrmDACTeQRRetrato.qrb_04_DadosNotaFiscalBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  // Incluido por Italo em 20/04/2011
  PrintBand := QRCTe.PageNumber = 1;

  // Imprime os dados da da Nota Fiscal se o Tipo de CTe for Normal
  // Incluido / Alterado por Italo e Doni em 24/09/2010
  qrb_04_DadosNotaFiscal.Enabled:=(FCTe.Ide.tpCTe = tcNormal);
end;

procedure TfrmDACTeQRRetrato.qrb_05_ComplementoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
 i: Integer;
begin
  inherited;
  // Incluido por Italo em 20/04/2011
  PrintBand := QRCTe.PageNumber = 1;

  // Imprime a lista dos CT-e Complementados se o Tipo de CTe for Complemento
  // Incluido / Alterado por Italo e Doni em 24/09/2010
  qrmComplChave1.Lines.Clear;
  qrmComplValor1.Lines.Clear;
  qrmComplChave2.Lines.Clear;
  qrmComplValor2.Lines.Clear;
  qrb_05_Complemento.Enabled:=(FCTe.Ide.tpCTe = tcComplemento);

  for i := 0 to FCTe.InfCTeComp.Count - 1 do
  begin
    case i of
      0..4:
        begin
          qrmComplChave1.Lines.Add(FCTe.InfCTeComp[i].Chave);
          qrmComplValor1.Lines.Add(CteUtil.FormatarValor(msk10x2, FCTe.InfCTeComp[i].vPresComp.vTPrest));
        end;
      5..9:
        begin
          qrmComplChave2.Lines.Add(FCTe.InfCTeComp[i].Chave);
          qrmComplValor2.Lines.Add(CteUtil.FormatarValor(msk10x2, FCTe.InfCTeComp[i].vPresComp.vTPrest));
        end;
    end;
  end;
end;

procedure TfrmDACTeQRRetrato.qrb_06_ValorPrestacaoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  // Incluido por Italo em 20/04/2011
  PrintBand := QRCTe.PageNumber = 1;
end;

procedure TfrmDACTeQRRetrato.qrb_07_HeaderItensBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  // Imprime os Documentos Originários se o Tipo de CTe for Normal
  // Incluido / Alterado por Italo e Doni em 24/09/2010
  // qrbHeaderItens.Enabled:=(FCTe.Ide.tpCTe = tcNormal);
end;

procedure TfrmDACTeQRRetrato.qrb_08_ItensBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i : integer;
begin
  inherited;

  // Imprime os Documentos Originários se o Tipo de CTe for Normal
  // Incluido / Alterado por Italo e Doni em 24/09/2010
  // TpcteTipoCTe = (tcNormal, tcComplemento, tcAnulacao, tcSubstituto);
  qrb_08_Itens.Enabled:=(FCTe.Ide.tpCTe = tcNormal);

  for i := 1 to 2 do
    if Trim(cdsDocumentos.FieldByName('DOCUMENTO_' + IntToStr(i)).AsString) = '' then
      TQRDBText(FindComponent('qrdbtCnpjEmitente' + intToStr(i))).Width := 325
    else
      TQRDBText(FindComponent('qrdbtCnpjEmitente' + intToStr(i))).Width := 128;

  Inc(nItemControle);

  if QRCTe.PageNumber = 1 then
    if QRCTe.RecordCount < (_NUM_ITEMS_PAGE1 + Fracionado) then
      qrsFimItens.Enabled := (nItemControle = QRCTe.RecordCount)
    else
      qrsFimItens.Enabled := (nItemControle = (_NUM_ITEMS_PAGE1 + Fracionado))
  else
  begin
    qrsFimItens.Enabled := (nItemControle = (_NUM_ITEMS_OTHERPAGES + Fracionado)) or
      (QRCTe.RecordNumber = QRCTe.RecordCount) or
      (cdsDocumentos.Eof);
  end;

  if qrsFimItens.Enabled then
    nItemControle := 0;
end;

procedure TfrmDACTeQRRetrato.qrb_09_ObsAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;

//  if QRCTe.PageNumber > 1
//   then begin
//    qrbObs.Enabled := False;
//    QRCTe.ResetPageFooterSize;
//   end;
{
    qrbObs.Height              := 72;
//    qrbRecibo.Height           := 68;
//    qrbSistema.Height          := 16;
//    qrbDadosExcEmitente.Height := 40;
   end
   else begin
    qrbObs.Height              := 0;
//    qrbRecibo.Height           := 0;
//    qrbSistema.Height          := 0;
//    qrbDadosExcEmitente.Height := 0;
//    qrbModRodFracionado.Height := 0;
//    qrbLotacaoSim.Height       := 0;
   end;
}
end;

procedure TfrmDACTeQRRetrato.qrb_09_ObsBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
 i: integer;
begin
  inherited;
  // Incluido por Italo em 20/04/2011
  PrintBand := QRCTe.PageNumber = 1;

  qrmObs.Lines.BeginUpdate; // Linha inserida por Italo em 31/08/2010
  qrmObs.Lines.Clear;
  //qrmObs.Lines.Text := FCTe.Compl.xObs;
  //qrmObs.Lines.Add(FCTe.Compl.xObs);

  // Linha abaixo alterada por Italo em 27/08/2010
  // para substituir os ponto e virgula por quebra de linha no quadro Observações
  qrmObs.Lines.Add(StringReplace( FCTe.Compl.xObs, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) );
//  for i := 0 to FCTe.Compl.ObsCont.Count-1 do
//   with FCTe.Compl.ObsCont.Items[i] do
//    begin
//     qrmObs.Lines.Add( StringReplace( xCampo, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] )+': '+
//                       StringReplace( xTexto, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) );
//    end;
  if FCTe.Compl.ObsFisco.Count>0
   then qrmObs.Lines.Add('INFORMAÇÕES ADICIONAIS DE INTERESSE DO FISCO:');
  for i := 0 to FCTe.Compl.ObsFisco.Count-1 do
   with FCTe.Compl.ObsFisco.Items[i] do
    begin
     qrmObs.Lines.Add( StringReplace( xCampo, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] )+': '+
                       StringReplace( xTexto, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) );
    end;

  // Linhas inseridas por Italo em 28/01/2011
  if FCTe.Ide.tpEmis in [teContingencia, teFSDA]
   then qrmObs.Lines.Add('DACTE em Contingência - Impresso em decorrência de problemas técnicos.');
  if FCTe.Ide.tpEmis = teDPEC
   then qrmObs.Lines.Add('DACTE em Contingência - DPEC regularmente recebida pela Receita Federal do Brasil');

  // Linhas inseridas por Italo em 31/08/2010
  qrmObs.Lines.Text:=StringReplace(qrmObs.Lines.Text,';',#13,[rfReplaceAll]);
  qrmObs.Lines.EndUpdate;

  // As Linhas abaixo foram inseridas por Italo em 31/08/2010
  // Mensagem para modo Homologacao.
  qrlMsgTeste.Visible := False;
  qrlMsgTeste.Enabled := False;

  if FCTe.Ide.tpAmb = taHomologacao then
   begin
    qrlMsgTeste.Caption := 'AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL';
    qrlMsgTeste.Visible := True;
    qrlMsgTeste.Enabled := True;
   end else
   begin
    if FCTe.procCTe.cStat > 0 then
     begin
      if FCTe.procCTe.cStat = 101 then
       begin
        qrlMsgTeste.Caption := 'CT-e CANCELADO';
        qrlMsgTeste.Visible := True;
        qrlMsgTeste.Enabled := True;
       end;

      if FCTe.procCTe.cStat = 102 then
       begin
        qrlMsgTeste.Caption := 'CT-e DENEGADO';
        qrlMsgTeste.Visible := True;
        qrlMsgTeste.Enabled := True;
       end;

      if not FCTe.procCTe.cStat in [101, 102, 100] then
       begin
        qrlMsgTeste.Caption := FCTe.procCTe.xMotivo;
        qrlMsgTeste.Visible := True;
        qrlMsgTeste.Enabled := True;
       end;
     end else
     begin
      qrlMsgTeste.Caption := 'CT-E NÃO ENVIADO PARA SEFAZ';
      qrlMsgTeste.Visible := True;
      qrlMsgTeste.Enabled := True;
     end;
   end;

  qrlMsgTeste.Repaint;

//  qrlMsgTeste.Enabled := FCTe.Ide.tpAmb = taHomologacao;
end;

procedure TfrmDACTeQRRetrato.qrb_10_ModRodFracionadoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  // Incluido por Italo em 20/04/2011
  PrintBand := QRCTe.PageNumber = 1;

  // Imprime as Informações Especificas do Modal se o Tipo de CTe for Normal
  // Incluido / Alterado por Italo e Doni em 24/09/2010
  {*
  ** Alterado por: Brian Collo Gonçalves e Eric Helfenstens
  ** Data: 17/03/2011
  ** Descrição: Incluida banda para os dados especificos do Modal Aéreo
  ** e carregamento de suas respectivas informações.
  *}
  qrb_10_ModRodFracionado.Enabled := (FCTe.Ide.tpCTe = tcNormal) and (FCTe.Ide.modal = mdRodoviario);

  // Incluido / Alterado por Italo em 29/12/2010
  qrb_11_ModRodLotacao.Enabled := False;

  with FCTe.Rodo do
  begin
    qrlRntrcEmpresa.Caption := RNTRC;

  // Incluido / Alterado por Italo em 29/12/2010
    case Lota of
      ltNao: begin
              qrlTituloLotacao.Caption     := 'DADOS ESPECÍFICOS DO MODAL RODOVIÁRIO - CARGA FRACIONADA';
              qrlLotacao.Caption           := 'NÃO';
              qrb_11_ModRodLotacao.Enabled := False;
             end;
      ltsim: begin
              qrlTituloLotacao.Caption     := 'DADOS ESPECÍFICOS DO MODAL RODOVIÁRIO - LOTAÇÃO';
              qrlLotacao.Caption           := 'SIM';
              qrb_11_ModRodLotacao.Enabled := True;
             end;
    end;

    qrlDtPrevEntrega.Caption := FormatDateTime('DD/MM/YYYY', dPrev);
  end;
end;

procedure TfrmDACTeQRRetrato.qrb_11_ModRodLotacaoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i: integer;
begin
  inherited;
  // Incluido por Italo em 20/04/2011
  PrintBand := QRCTe.PageNumber = 1;

  // Incluido / Alterado por Italo em 29/12/2010 e 30/12/2010
{$IFDEF PL_103}
  qrlNumRegEsp.Caption := FCTe.Rodo.valePed.nroRE;
  case FCTe.Rodo.valePed.respPg of
   rpEmitente:       qrlResponsavel.Caption := 'EMITENTE';
   rpRemetente:      qrlResponsavel.Caption := 'REMETENTE';
   rpExpedidor:      qrlResponsavel.Caption := 'EXPEDIDOR';
   rpRecebedor:      qrlResponsavel.Caption := 'RECEBEDOR';
   rpDestinatario:   qrlResponsavel.Caption := 'DESTINATÁRIO';
   rpTomadorServico: qrlResponsavel.Caption := 'TOMADOR DO SERVIÇO';
  end;
  qrlValorTotal.Caption := CteUtil.FormatarValor(msk13x2, FCTe.Rodo.valePed.vTValePed);
{$ENDIF}

  qrmTipo.Lines.Clear;
  qrmPlaca.Lines.Clear;
  qrmUF.Lines.Clear;
  qrmRNTRC.Lines.Clear;

  for i:= 0 to FCTe.Rodo.veic.Count - 1 do
  begin
   if TpPropriedadeToStr(FCTe.Rodo.veic.Items[i].tpProp) = 'P'
    then qrmTipo.Lines.Add('Próprio')
    else qrmTipo.Lines.Add('Terceiro');
   qrmPlaca.Lines.Add(FCTe.Rodo.veic.Items[i].placa);
   qrmUF.Lines.Add(FCTe.Rodo.veic.Items[i].UF);
   qrmRNTRC.Lines.Add(FCTe.Rodo.veic.Items[i].Prop.RNTRC);
  end;

  qrmEmpresas.Lines.Clear;
  qrmVigencias.Lines.Clear;
  qrmNumDispositivo.Lines.Clear;
  qrmCodTransacao.Lines.Clear;

{$IFDEF PL_103}
  for i := 0 to FCTe.Rodo.valePed.disp.Count - 1 do
  begin
   qrmEmpresas.Lines.Add(FCTe.Rodo.valePed.disp.Items[i].xEmp);
   qrmVigencias.Lines.Add(FormatDateTime('DD/MM/YYYY', FCTe.Rodo.valePed.disp.Items[i].dVig));
   qrmNumDispositivo.Lines.Add(FCTe.Rodo.valePed.disp.Items[i].nDisp);
   qrmCodTransacao.Lines.Add(FCTe.Rodo.valePed.disp.Items[i].nCompC);
  end;
{$ENDIF}

  qrlNomeMotorista.Caption := '';
  qrlCPFMotorista.Caption  := '';
  qrlLacres.Caption        := '';
  if FCTe.Rodo.moto.Count>0
   then begin
    qrlNomeMotorista.Caption := FCTe.Rodo.moto.Items[0].xNome;
    qrlCPFMotorista.Caption  := CTeUtil.FormatarCNPJ(FCTe.Rodo.moto.Items[0].CPF);
   end;

  for i := 0 to FCTe.Rodo.Lacres.Count - 1 do
  begin
   qrlLacres.Caption := qrlLacres.Caption + FCTe.Rodo.Lacres.Items[i].nLacre + '/';
  end;
end;

procedure TfrmDACTeQRRetrato.qrb_18_ReciboBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  // Última alteração realizada por base nas correções de Clever - BSoft Sistemas

  // Incluido/Alterado por Italo em 20/04/2011 / 27/04/2011 / 04/07/2011
  PrintBand := (QRCTe.PageNumber = 1);

  // Incluido por Italo em 27/04/2011 / 04/07/2011
  // TpcteTipoCTe = (tcNormal, tcComplemento, tcAnulacao, tcSubstituto);
  if (FCTe.Ide.tpCTe = tcNormal) and PrintBand
   then begin
    qrb_18_Recibo.Enabled := (FPosRecibo = prRodape);
    if qrb_18_Recibo.Enabled
     then qrb_18_Recibo.Height  := 68
     else qrb_18_Recibo.Height  := 0;
   end;
end;

procedure TfrmDACTeQRRetrato.qrb_17_SistemaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  // Incluido por Italo em 20/04/2011
  PrintBand := QRCTe.PageNumber = 1;

  qrlblSistema.Caption := FSistema + ' - ' + FUsuario;
end;

procedure TfrmDACTeQRRetrato.qrb_16_DadosExcEmitenteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
 xTexto: String;
 i: Integer;
begin
  inherited;
  // Incluido por Italo em 20/04/2011
  PrintBand := QRCTe.PageNumber = 1;

  qrmObsExcEmitente.Lines.BeginUpdate; // Linha inserida por Italo em 28/06/2011
  qrmObsExcEmitente.Lines.Clear;

  // Linhas Alteradas por Italo em 06/05/2011
  if FCTe.Ide.modal = mdAereo
   then begin
    qrmObsExcEmitente.Lines.Add( 'O transporte coberto por este conhecimento se rege pelo código brasileiro de aeronáutica. '+
                  'O expedidor/remetente aceita como corretas todas as especificações impressas neste conhecimento,' );
    qrmObsExcEmitente.Lines.Add( 'certificando que os artigos perigosos descritos pela regulamentação da ICAO foram devidamente '+
                  'informados e acondicionados para transporte aéreo.' );
   end;

  // Incluido por Italo em 28/06/2011
  if FCTe.Ide.modal <> mdAereo
   then begin
//    qrmObsExcEmitente.Lines.Add( StringReplace( FCTe.Compl.xObs, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) );
    for i := 0 to FCTe.Compl.ObsCont.Count-1 do
     with FCTe.Compl.ObsCont.Items[i] do
      begin
       qrmObsExcEmitente.Lines.Add( StringReplace( xCampo, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] )+': '+
                                    StringReplace( xTexto, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) );
      end;
   end;

  // Linhas inseridas por Italo em 28/06/2011
  qrmObsExcEmitente.Lines.Text := StringReplace( qrmObsExcEmitente.Lines.Text, ';', #13, [rfReplaceAll] );
  qrmObsExcEmitente.Lines.EndUpdate;
end;

procedure TfrmDACTeQRRetrato.qrb_12_ModAereoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  // Incluido por Italo em 06/05/2011
  PrintBand := QRCTe.PageNumber = 1;
  {*
  ** Alterado por: Brian Collo Gonçalves e Eric Helfenstens
  ** Data: 17/03/2011
  ** Descrição: Incluida banda para os dados especificos do Modal Aéreo
  ** e carregamento de suas respectivas informações.
  *}
  qrb_12_ModAereo.Enabled := (FCTe.Ide.tpCTe = tcNormal) and (FCTe.Ide.modal = mdAereo);

  qrlCaracAdServico.Caption    := FCTe.Compl.xCaracSer;
  qrlCaracAdTransporte.Caption := FCTe.Compl.xCaracAd;

  with FCTe.Aereo do
  begin
    qrlAWB.Caption           := nOCA;
  {$IFDEF PL_103}
    qrlTrecho.Caption        := tarifa.trecho;
  {$ENDIF}
    qrlTarifaCL.Caption      := tarifa.CL;
    qrlTarifaCodigo.Caption  := tarifa.cTar;
    qrlTarifaValor.Caption   := FormatCurr('###,###,##0.00', tarifa.vTar);
    qrlContaCorrente.Caption := cIATA; // ??? Conta Corrente ???
    qrlMinuta.Caption        := FormatFloat('0000000000', nMinu);

    qrlLojaAgenteEmissor.Caption := xLAgEmi;
  end;

  if FCte.Ide.retira = rtSim
   then qrlRetira.Caption := 'SIM'
   else qrlRetira.Caption := 'NÃO';
  qrlDadosRetira.Caption  := FCte.Ide.xdetretira;
end;

procedure TfrmDACTeQRRetrato.qrb_13_ModAquaviarioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  // Incluido por Italo em 06/05/2011
  PrintBand := QRCTe.PageNumber = 1;
  qrb_13_ModAquaviario.Enabled := (FCTe.Ide.tpCTe = tcNormal) and (FCTe.Ide.modal = mdAquaviario);
end;

procedure TfrmDACTeQRRetrato.qrb_14_ModFerroviarioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
 i: Integer;
begin
  inherited;
  // Incluido por Italo em 06/05/2011
  PrintBand := QRCTe.PageNumber = 1;
  qrb_14_ModFerroviario.Enabled := (FCTe.Ide.tpCTe = tcNormal) and (FCTe.Ide.modal = mdFerroviario);

  qrlPortoEmbarque.Caption     := FCTe.Aquav.prtEmb;
  qrlPortoDestino.Caption      := FCTe.Aquav.prtDest;
  qrlIndNavioRebocador.Caption := FCTe.Aquav.xNavio;

  qrlBCAFRMM.Caption    := FormatCurr('###,###,##0.00', FCTe.Aquav.vPrest);
  qrlValorAFRMM.Caption := FormatCurr('###,###,##0.00', FCTe.Aquav.vAFRMM);

  case FCTe.Aquav.tpNav of
   tnInterior:  qrlTipoNav.Caption := 'INTERIOR';
   tnCabotagem: qrlTipoNav.Caption := 'CABOTAGEM';
  end;

  case FCTe.Aquav.direc of
   drNorte: qrlDirecao.Caption := 'NORTE';
   drLeste: qrlDirecao.Caption := 'LESTE';
   drSul:   qrlDirecao.Caption := 'SUL';
   drOeste: qrlDirecao.Caption := 'OESTE';
  end;

  qrlIndConteiners.Caption := '';
  for i := 0 to FCTe.Aquav.Lacre.Count - 1 do
   begin
    if i = 0
     then qrlIndConteiners.Caption := FCTe.Aquav.Lacre.Items[i].nLacre
     else qrlIndConteiners.Caption := qrlIndConteiners.Caption + '/' + FCTe.Aquav.Lacre.Items[i].nLacre;
   end;
end;

procedure TfrmDACTeQRRetrato.qrb_15_ModDutoviarioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  // Incluido por Italo em 06/05/2011
  PrintBand := QRCTe.PageNumber = 1;
  qrb_15_ModDutoviario.Enabled := (FCTe.Ide.tpCTe = tcNormal) and (FCTe.Ide.modal = mdDutoviario);
end;

end.

