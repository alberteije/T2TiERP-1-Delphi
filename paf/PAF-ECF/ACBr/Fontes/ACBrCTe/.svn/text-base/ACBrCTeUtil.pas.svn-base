{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - CTe - http://www.CTe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wiliam Zacarias da Silva Rosa          }
{                                       Wemerson Souto                         }
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
|* 10/02/2009: André Ferreira de Moraes
|*  - Adicionado URL de todos os estados
|* 18/02/2009: André Ferreira de Moraes
|*  - Criado Assinatura baseado em código passado por Daniel Simões
|*  - Criado Validação do XML da CTe baseado em código passado por Daniel Simões
|* 07/08/2009 : Wiliam Zacarias da Silva Rosa
|*  - Adicionado URL do estado de MT
|* 08/03/2010 : Bruno - Rhythmus Informatica
|* - Function GetURL:
|*  Incluida instrução 33: Result := CTeUtil.GetURLRS(AAmbiente, ALayOut); //RJ
|*  RJ usa os WebServices do RS
******************************************************************************}
{$I ACBr.inc}

unit ACBrCTeUtil;

interface

uses
{$IFNDEF ACBrCTeOpenSSL}
  ACBrCAPICOM_TLB, ACBrMSXML2_TLB, JwaWinCrypt,
{$ENDIF}
  Classes, Forms,
{$IFDEF FPC}
  LResources, Controls, Graphics, Dialogs,
{$ELSE}
  StrUtils,
{$ENDIF}
  ACBrCTeConfiguracoes, pcnConversao, pcteCTe;

{$IFDEF ACBrCTeOpenSSL}
const
  cDTD         = '<!DOCTYPE test [<!ATTLIST infCte Id ID #IMPLIED>]>';
  cDTDCanc     = '<!DOCTYPE test [<!ATTLIST infCanc Id ID #IMPLIED>]>';
  cDTDInut     = '<!DOCTYPE test [<!ATTLIST infInut Id ID #IMPLIED>]>';
{$ELSE}
const
  DSIGNS = 'xmlns:ds="http://www.w3.org/2000/09/xmldsig#"';
{$ENDIF}
{$IFNDEF ACBrCTeOpenSSL}
var
  CertStore    : IStore3;
  CertStoreMem : IStore3;
  PrivateKey   : IPrivateKey;
  Certs        : ICertificates2;
  Cert         : ICertificate2;
  NumCertCarregado : String;
{$ENDIF}

type
  CTeUtil = class
  private
    // Estados Emissores pela Sefaz Virtual RS (Rio Grande do Sul):
    // AC, AL, AP, AM, BA, CE, DF, ES, GO, MA, PA, PB, PR, PE, PI, RJ, RN,
    // RO, RR, SC, SE, TO.
    class function GetURLSVRS(AAmbiente: Integer; ALayOut: TLayOut): WideString;

    class function GetURLMG(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLRS(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLSP(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLMT(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLMS(AAmbiente: Integer; ALayOut: TLayOut): WideString;

  protected

  public
{$IFDEF ACBrCTeOpenSSL}
    class function sign_file(const Axml: PAnsiChar; const key_file: PChar; const senha: PChar): AnsiString;
    class procedure InitXmlSec;
    class procedure ShutDownXmlSec;
{$ENDIF}
    class function GetURL(const AUF, AAmbiente, FormaEmissao: Integer; ALayOut: TLayOut): WideString;
    class function SeparaDados( Texto : AnsiString; Chave : String; MantemChave : Boolean = False ) : AnsiString;
    class function Valida(const AXML: AnsiString; var AMsg: AnsiString; const APathSchemas: string = ''): Boolean;

    class function LimpaNumero(AValue: string): string;
    class function FormatarCPF(AValue: string): string;
    class function FormatarCNPJ(AValue: string): string;
    class function FormatarCEP(AValue: string): string;
    class function FormatarFone(AValue: string): string;
    class function FormatDate(const AString: string): string;
    class function FormatDateTime(const AString: string): string;
    class function EstaVazio(const AValue: string): Boolean; overload;
    class procedure EstaVazio(const AValue, AMensagem: string); overload;
    class function NaoEstaVazio(AValue: string): Boolean;
    class function EstaZerado(AValue: Double): Boolean; overload;
    class function EstaZerado(AValue: Integer): Boolean; overload;
    class procedure EstaZerado(AValue: Integer; AMensagem: string); overload;
    class function NaoEstaZerado(AValue: Double): Boolean; overload;
    class function NaoEstaZerado(AValue: Integer): Boolean; overload;
    class function Poem_Zeros(const Texto: string; const Tamanho: Integer): string; overload;
    class function Poem_Zeros(const Valor: Integer; const Tamanho: Integer): string; overload;
    class function PosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
    class function PosLast(const SubStr, S: AnsiString): Integer;
    class function PadE(const AString: string; const nLen: Integer; const Caracter: Char = ' '): string;
    class function PadD(const AString: string; const nLen: Integer; const Caracter: Char = ' '): string;
    class function padC(const AString: string; const nLen: Integer; const Caracter: Char = ' '): string;
    class function SeSenao(ACondicao: Boolean; ATrue, AFalse: Variant): Variant;
    class function StringToDate(const AString: string): TDateTime;
    class function StringToTime(const AString: string): TDateTime;
    class function TamanhoIgual(const AValue: string; const ATamanho: Integer): Boolean; overload;
    class procedure TamanhoIgual(const AValue: string; const ATamanho: Integer; AMensagem: string); overload;
    class function TamanhoIgual(const AValue: Integer; const ATamanho: Integer): Boolean; overload;
    class procedure TamanhoIgual(const AValue: Integer; const ATamanho: Integer; AMensagem: string); overload;
    class function TamanhoMenor(const AValue: string; const ATamanho: Integer): Boolean;
    class function ValidaUFCidade(const UF, Cidade: Integer): Boolean; overload;
    class procedure ValidaUFCidade(const UF, Cidade: Integer; const AMensagem: string); overload;
    // Alterado por Italo em 17/05/2011
    class function FormatarChaveAcesso(AValue : String; Mascara: Boolean = False ): String;
    class function FormatarNumCTe(const AValue: Integer): string;
    class function FormatarValor(mask: TpcteMask; const AValue: real): string;
    // Incluido por Italo em 28/01/2011
    class function GerarChaveContingencia(FCTe:TCTe): String;
    class function FormatarChaveContingencia(AValue: String): String;


{$IFDEF ACBrCTeOpenSSL}
    class function Assinar(const AXML, ArqPFX, PFXSenha: AnsiString; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ELSE}
    class function Assinar(const AXML: AnsiString; Certificado: ICertificate2; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ENDIF}

    class function PathAplication: String;
    class procedure ConfAmbiente;
    class function ParseText( Texto : AnsiString; Decode : Boolean = True) : AnsiString;
    class function TrataString(const AValue: String): String;overload;
    class function TrataString(const AValue: String; const ATamanho: Integer): String;overload;
    class function CortaD(const AString: string; const ATamanho: Integer): String;
    class function CortaE(const AString: string; const ATamanho: Integer): String;
    class function UFtoCUF(UF : String): Integer;
  end;

implementation

uses
 {$IFDEF ACBrCTeOpenSSL}
  libxml2, libxmlsec, libxslt,
 {$ELSE}
  ComObj,
 {$ENDIF}
  Sysutils, Variants, ACBrUtil;

{ CTeUtil }
{$IFDEF ACBrCTeOpenSSL}

class procedure CTeUtil.InitXmlSec;
begin
  { Init libxml and libxslt libraries }
  xmlInitParser();
  __xmlLoadExtDtdDefaultValue^ := XML_DETECT_IDS or XML_COMPLETE_ATTRS;
  xmlSubstituteEntitiesDefault(1);
  __xmlIndentTreeOutput^ := 1;

  { Init xmlsec library }
  if (xmlSecInit() < 0) then
    raise Exception.Create('Error: xmlsec initialization failed.');

  { Check loaded library version }
  if (xmlSecCheckVersionExt(1, 2, 8, xmlSecCheckVersionABICompatible) <> 1) then
    raise Exception.Create('Error: loaded xmlsec library version is not compatible.');

  (* Load default crypto engine if we are supporting dynamic
   * loading for xmlsec-crypto libraries. Use the crypto library
   * name ("openssl", "nss", etc.) to load corresponding
   * xmlsec-crypto library.
   *)
  if (xmlSecCryptoDLLoadLibrary('openssl') < 0) then
    raise Exception.Create('Error: unable to load default xmlsec-crypto library. Make sure'#10 +
      'that you have it installed and check shared libraries path'#10 +
      '(LD_LIBRARY_PATH) environment variable.');

  { Init crypto library }
  if (xmlSecCryptoAppInit(nil) < 0) then
    raise Exception.Create('Error: crypto initialization failed.');

  { Init xmlsec-crypto library }
  if (xmlSecCryptoInit() < 0) then
    raise Exception.Create('Error: xmlsec-crypto initialization failed.');
end;

class procedure CTeUtil.ShutDownXmlSec;
begin
  { Shutdown xmlsec-crypto library }
  xmlSecCryptoShutdown();

  { Shutdown crypto library }
  xmlSecCryptoAppShutdown();

  { Shutdown xmlsec library }
  xmlSecShutdown();

  { Shutdown libxslt/libxml }
  xsltCleanupGlobals();
  xmlCleanupParser();
end;
{$ENDIF}

class function CTeUtil.GetURL(const AUF, AAmbiente, FormaEmissao: Integer;
  ALayOut: TLayOut): WideString;
begin
  //  (AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,RJ,RN,RS,RO,RR,SC,SP,SE,TO);
  //  (12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17);

 case FormaEmissao of
  1,2,4,5 : begin
             {
             case ALayOut of
              LayCTeEnvDPEC      : Result := CTeUtil.SeSenao(AAmbiente=1,
               'https://www.nfe.fazenda.gov.br/SCERecepcaoRFB/SCERecepcaoRFB.asmx',
               'https://hom.nfe.fazenda.gov.br/SCERecepcaoRFB/SCERecepcaoRFB.asmx');
              LayCTeConsultaDPEC : Result := CTeUtil.SeSenao(AAmbiente=1,
               'https://www.nfe.fazenda.gov.br/SCEConsultaRFB/SCEConsultaRFB.asmx',
               'https://hom.nfe.fazenda.gov.br/SCEConsultaRFB/SCEConsultaRFB.asmx');
             end;
             }
             case AUF of
              12: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //AC - Acre
              27: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //AL - Alagoas
              16: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //AP - Amapá
              13: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //AM - Amazonas
              29: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //BA - Bahia
              23: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //CE - Ceará
              53: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //DF - Distrito Federal
              32: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //ES - Espirito Santo
              52: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //GO - Goiás
              21: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //MA - Maranhão

              51: Result := CTeUtil.GetURLMT(AAmbiente, ALayOut);               //MT - Mato Grosso
                  // Só Homologacao
              50: Result := CTeUtil.GetURLMS(AAmbiente, ALayOut);               //MS - Mato Grosso do Sul
              31: Result := CTeUtil.GetURLMG(AAmbiente, ALayOut);               //MG - Minas Gerais

              15: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //PA - Pará
              25: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //PB - Paraibá
              41: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //PR - Paraná
              26: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //PE - Pernambuco
              22: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //PI - Piauí
              33: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //RJ - Rio de Janeiro
              24: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //RN - Rio Grande do Norte

              43: Result := CTeUtil.GetURLRS(AAmbiente, ALayOut);               //RS - Rio Grande do Sul

              11: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //RO - Rondônia
              14: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //RR - Roraima
              42: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //SC - Santa Catarina

              35: Result := CTeUtil.GetURLSP(AAmbiente, ALayOut);               //SP - São Paulo

              28: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //SE - Sergipe
              17: Result := CTeUtil.GetURLSVRS(AAmbiente, ALayOut);             //TO - Tocantins
             end;
            end;
        3 : begin
             {
             case ALayOut of
              LayCTeStatusServico : Result := CTeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeStatusServico/NfeStatusServico.asmx', 'https://hom.nfe.fazenda.gov.br/SCAN/nfestatusservico/NfeStatusServico.asmx');
              LayCTeConsultaCT    : Result := CTeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeConsulta/NfeConsulta.asmx'          , 'https://hom.nfe.fazenda.gov.br/SCAN/nfeconsulta/NfeConsulta.asmx');
              LayCTeCancelamento  : Result := CTeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeCancelamento/NfeCancelamento.asmx'  , 'https://hom.nfe.fazenda.gov.br/SCAN/nfecancelamento/NfeCancelamento.asmx');
              LayCTeInutilizacao  : Result := CTeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeInutilizacao/NfeInutilizacao.asmx'  , 'https://hom.nfe.fazenda.gov.br/SCAN/nfeinutilizacao/NfeInutilizacao.asmx');
              LayCTeRecepcao      : Result := CTeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeRecepcao/NfeRecepcao.asmx'          , 'https://hom.nfe.fazenda.gov.br/SCAN/nferecepcao/NfeRecepcao.asmx');
              LayCTeRetRecepcao   : Result := CTeUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeRetRecepcao/NfeRetRecepcao.asmx'    , 'https://hom.nfe.fazenda.gov.br/SCAN/nferetrecepcao/NfeRetRecepcao.asmx');
             end;
             }
            end;

 end;
 if Result = '' then
     raise Exception.Create('URL não disponível para o Estado solicitado.');
end;

class function CTeUtil.GetURLSVRS(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayCTeStatusServico: Result := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/ctestatusservico/ctestatusservico.asmx'      , 'https://homologacao.cte.sefaz.rs.gov.br/ws/ctestatusservico/ctestatusservico.asmx');
//    LayCTeCadastro: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://sef.sefaz.rs.gov.br/ws/CadConsultaCadastro/CadConsultaCadastro.asmx', 'https://sef.sefaz.rs.gov.br/ws/CadConsultaCadastro/CadConsultaCadastro.asmx');
    LayCTeConsultaCT: Result    := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/cteconsulta/cteconsulta.asmx'                , 'https://homologacao.cte.sefaz.rs.gov.br/ws/cteconsulta/cteconsulta.asmx');
    LayCTeCancelamento: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/ctecancelamento/ctecancelamento.asmx'        , 'https://homologacao.cte.sefaz.rs.gov.br/ws/ctecancelamento/ctecancelamento.asmx');
    LayCTeInutilizacao: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/cteinutilizacao/cteinutilizacao.asmx'        , 'https://homologacao.cte.sefaz.rs.gov.br/ws/cteinutilizacao/cteinutilizacao.asmx');
    LayCTeRecepcao: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/cterecepcao/CteRecepcao.asmx'                , 'https://homologacao.cte.sefaz.rs.gov.br/ws/cterecepcao/CteRecepcao.asmx');
    LayCTeRetRecepcao: Result   := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/cteretrecepcao/CteRetRecepcao.asmx'          , 'https://homologacao.cte.sefaz.rs.gov.br/ws/cteretrecepcao/CteRetRecepcao.asmx');
  end;
end;

class function CTeUtil.GetURLMG(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayCTeStatusServico: Result := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.fazenda.mg.gov.br/cte/services/CteStatusServico'   , 'https://hcte.fazenda.mg.gov.br/cte/services/CteStatusServico');
//    LayCTeCadastro: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.fazenda.mg.gov.br/cte/services/cadConsultaCadastro', 'https://hcte.fazenda.mg.gov.br/cte/services/cadConsultaCadastro');
    LayCTeConsultaCT: Result    := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.fazenda.mg.gov.br/cte/services/CteConsulta'        , 'https://hcte.fazenda.mg.gov.br/cte/services/CteConsulta');
    LayCTeCancelamento: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.fazenda.mg.gov.br/cte/services/CteCancelamento'    , 'https://hcte.fazenda.mg.gov.br/cte/services/CteCancelamento');
    LayCTeInutilizacao: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.fazenda.mg.gov.br/cte/services/CteInutilizacao'    , 'https://hcte.fazenda.mg.gov.br/cte/services/CteInutilizacao');
    LayCTeRecepcao: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.fazenda.mg.gov.br/cte/services/CteRecepcao'        , 'https://hcte.fazenda.mg.gov.br/cte/services/CteRecepcao'); //?WSDL
    LayCTeRetRecepcao: Result   := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.fazenda.mg.gov.br/cte/services/CteRetRecepcao'     , 'https://hcte.fazenda.mg.gov.br/cte/services/CteRetRecepcao'); //?WSDL
  end;
end;

class function CTeUtil.GetURLRS(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayCTeStatusServico: Result := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/ctestatusservico/CteStatusServico.asmx'      , 'https://homologacao.cte.sefaz.rs.gov.br/ws/ctestatusservico/CteStatusServico.asmx');
//    LayCTeCadastro: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://sef.sefaz.rs.gov.br/ws/CadConsultaCadastro/CadConsultaCadastro.asmx', 'https://sef.sefaz.rs.gov.br/ws/CadConsultaCadastro/CadConsultaCadastro.asmx');
    LayCTeConsultaCT: Result    := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/cteconsulta/CteConsulta.asmx'                , 'https://homologacao.cte.sefaz.rs.gov.br/ws/cteconsulta/CteConsulta.asmx');
    LayCTeCancelamento: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/ctecancelamento/ctecancelamento.asmx'        , 'https://homologacao.cte.sefaz.rs.gov.br/ws/ctecancelamento/ctecancelamento.asmx');
    LayCTeInutilizacao: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/cteinutilizacao/cteinutilizacao.asmx'        , 'https://homologacao.cte.sefaz.rs.gov.br/ws/cteinutilizacao/cteinutilizacao.asmx');
    LayCTeRecepcao: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/cterecepcao/CteRecepcao.asmx'                , 'https://homologacao.cte.sefaz.rs.gov.br/ws/cterecepcao/CteRecepcao.asmx');
    LayCTeRetRecepcao: Result   := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.rs.gov.br/ws/cteretrecepcao/cteRetRecepcao.asmx'          , 'https://homologacao.cte.sefaz.rs.gov.br/ws/cteretrecepcao/cteRetRecepcao.asmx'); //CteRetRecepcao.asmx
  end;
end;

class function CTeUtil.GetURLSP(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayCTeStatusServico: Result := CTeUtil.SeSenao(AAmbiente = 1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteStatusServico.asmx'   , 'https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteStatusServico.asmx');
    LayCTeCadastro: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://nfe.fazenda.sp.gov.br/nfeWEB/services/cadConsultaCadastro.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeWEB/services/cadConsultaCadastro.asmx');
    LayCTeConsultaCT: Result    := CTeUtil.SeSenao(AAmbiente = 1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteConsulta.asmx'        , 'https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteConsulta.asmx');
    LayCTeCancelamento: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteCancelamento.asmx'    , 'https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteCancelamento.asmx');
    LayCTeInutilizacao: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteInutilizacao.asmx'    , 'https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteInutilizacao.asmx');
    LayCTeRecepcao: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteRecepcao.asmx'        , 'https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteRecepcao.asmx');
    LayCTeRetRecepcao: Result   := CTeUtil.SeSenao(AAmbiente = 1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteRetRecepcao.asmx'     , 'https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteRetRecepcao.asmx');
  end;
end;

class function CTeUtil.GetURLMS(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  // Os links para o Ambiente de Produção devem ser checados
  case ALayOut of
    LayCTeStatusServico: Result := CTeUtil.SeSenao(AAmbiente = 1, 'https://producao.cte.ms.gov.br/cteWEB/CteStatusServico.asmx'   , 'https://homologacao.cte.ms.gov.br/cteWEB/CteStatusServico.asmx');
    LayCTeCadastro: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://producao.cte.ms.gov.br/cteWEB/CadConsultaCadastro.asmx', 'https://homologacao.cte.ms.gov.br/cteWEB/CadConsultaCadastro.asmx');
    LayCTeConsultaCT: Result    := CTeUtil.SeSenao(AAmbiente = 1, 'https://producao.cte.ms.gov.br/cteWEB/CteConsulta.asmx'        , 'https://homologacao.cte.ms.gov.br/cteWEB/CteConsulta.asmx');
    LayCTeCancelamento: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://producao.cte.ms.gov.br/cteWEB/CteCancelamento.asmx'    , 'https://homologacao.cte.ms.gov.br/cteWEB/CteCancelamento.asmx');
    LayCTeInutilizacao: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://producao.cte.ms.gov.br/cteWEB/CteInutilizacao.asmx'    , 'https://homologacao.cte.ms.gov.br/cteWEB/CteInutilizacao.asmx');
    LayCTeRecepcao: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://producao.cte.ms.gov.br/cteWEB/CteRecepcao.asmx'        , 'https://homologacao.cte.ms.gov.br/cteWEB/CteRecepcao.asmx');
    LayCTeRetRecepcao: Result   := CTeUtil.SeSenao(AAmbiente = 1, 'https://producao.cte.ms.gov.br/cteWEB/CteRetRecepcao.asmx'     , 'https://homologacao.cte.ms.gov.br/cteWEB/CteRetRecepcao.asmx');
  end;
end;

class function CTeUtil.GetURLMT(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
// TIRADOS ESPAÇOS EM BRANCO DO INICIO DAS URL´S
  case ALayOut of
    LayCTeStatusServico: Result := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.mt.gov.br/ctews/services/CteStatusServico'   , 'https://homologacao.sefaz.mt.gov.br/ctews/services/CteStatusServico'); //?WSDL
//    LayCTeCadastro: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.mt.gov.br/ctews/services/cadConsultaCadastro', 'https://homologacao.sefaz.mt.gov.br/ctews/services/cadConsultaCadastro');
    LayCTeConsultaCT: Result    := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.mt.gov.br/ctews/services/CteConsulta'        , 'https://homologacao.sefaz.mt.gov.br/ctews/services/CteConsulta');
    LayCTeCancelamento: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.mt.gov.br/ctews/services/CteCancelamento'    , 'https://homologacao.sefaz.mt.gov.br/ctews/services/CteCancelamento');
    LayCTeInutilizacao: Result  := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.mt.gov.br/ctews/services/CteInutilizacao'    , 'https://homologacao.sefaz.mt.gov.br/ctews/services/CteInutilizacao');
    LayCTeRecepcao: Result      := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.mt.gov.br/ctews/services/CteRecepcao'        , 'https://homologacao.sefaz.mt.gov.br/ctews/services/CteRecepcao'); //?WSDL
    LayCTeRetRecepcao: Result   := CTeUtil.SeSenao(AAmbiente = 1, 'https://cte.sefaz.mt.gov.br/ctews/services/CteRetRecepcao'     , 'https://homologacao.sefaz.mt.gov.br/ctews/services/CteRetRecepcao'); //?WSDL
  end;
end;

class function CTeUtil.LimpaNumero(AValue: string): string;
var
  A : Integer;
begin
  Result := '';
  for A := 1 to length(AValue) do
  begin
    {$IFDEF DELPHI12_UP}
    if CharInSet(AValue[A], ['0'..'9']) then
    {$ELSE}
    if (AValue[A] in ['0'..'9']) then
    {$ENDIF}
      Result := Result + AValue[A];
  end;
end;

class function CTeUtil.FormatarCPF(AValue: string): string;
begin
  if Length(AValue) = 0 then
    Result := AValue
  else
  begin
    AValue := CTeUtil.LimpaNumero(AValue);
    Result := copy(AValue, 1, 3) + '.' + copy(AValue, 4, 3) + '.' +
      copy(AValue, 7, 3) + '-' + copy(AValue, 10, 2);
  end;
end;

class function CTeUtil.FormatarCNPJ(AValue: string): string;
begin
  if Length(AValue) = 0 then
    Result := AValue
  else
  if Length(AValue) < 14 then
    Result := CTeUtil.FormatarCPF(AValue)
  else
  begin
    AValue := CTeUtil.LimpaNumero(AValue);
    Result := copy(AValue, 1, 2) + '.' + copy(AValue, 3, 3) + '.' +
      copy(AValue, 6, 3) + '/' + copy(AValue, 9, 4) + '-' + copy(AValue, 13, 2);
  end;
end;

class function CTeUtil.FormatarCEP(AValue: string): string;
var
  I    : integer;
  sAux : string;
begin
  sAux := AValue;

  for I := 0 to 7 do
    if (Length(sAux) < 8) then
      sAux := '0' + sAux;

  Result := copy(sAux, 1, 5) + '-' + copy(sAux, 6, 3);
end;

class function CTeUtil.FormatarFone(AValue: string): string;
begin
  Result := AValue;
  if CTeUtil.NaoEstaVazio(AValue) then
  begin
    AValue := CTeUtil.Poem_Zeros(CTeUtil.LimpaNumero(AValue), 10);
    Result := copy(AValue, 1, 2) + ' ' + copy(AValue, 3, 4) + '-' + copy(AValue, 7, 4);
//    Result := '(' + copy(AValue, 1, 2) + ')' + copy(AValue, 3, 8);
  end;
end;

class function CTeUtil.FormatarNumCTe(const AValue: Integer): string;
begin
  result := FormatFloat('000000000', AValue);
end;

class function CTeUtil.FormatarValor(mask: TpcteMask; const AValue: real): string;
begin
  result := FormatFloat(TpMaskToStrText(mask), AValue);
end;

class function CTeUtil.EstaVazio(const AValue: string): Boolean;
begin
  Result := (Trim(AValue) = '');
end;

class function CTeUtil.EstaZerado(AValue: Double): Boolean;
begin
  Result := (AValue = 0);
end;

class function CTeUtil.EstaZerado(AValue: Integer): Boolean;
begin
  Result := (AValue = 0);
end;

class procedure CTeUtil.EstaZerado(AValue: Integer; AMensagem: string);
begin
  if CTeUtil.EstaZerado(AValue) then
    raise Exception.Create(AMensagem);
end;

class procedure CTeUtil.ConfAmbiente;
begin
  DecimalSeparator := ',';
end;

class function CTeUtil.CortaD(const AString: string; const ATamanho: Integer): String;
begin
  Result := copy(AString,1,ATamanho);
end;

class function CTeUtil.CortaE(const AString: string; const ATamanho: Integer): String;
begin
  Result := AString;
  if Length(AString) > ATamanho then
    Result := copy(AString, Length(AString)-ATamanho+1, length(AString));
end;

class procedure CTeUtil.EstaVazio(const AValue, AMensagem: string);
begin
  if CTeUtil.EstaVazio(AValue) then
    raise Exception.Create(AMensagem);
end;

class function CTeUtil.NaoEstaVazio(AValue: string): Boolean;
begin
  Result := not (EstaVazio(AValue));
end;

class function CTeUtil.NaoEstaZerado(AValue: Double): Boolean;
begin
  Result := not (EstaZerado(AValue));
end;

class function CTeUtil.NaoEstaZerado(AValue: Integer): Boolean;
begin
  Result := not (EstaZerado(AValue));
end;

class function CTeUtil.padC(const AString: string; const nLen: Integer;
  const Caracter: Char): string;
var
  nCharLeft : Integer;
  D         : Double;
begin
  Result := copy(AString, 1, nLen);
  D := (nLen - Length(Result)) / 2;
  nCharLeft := Trunc(D);
  Result := PadE(StringOfChar(Caracter, nCharLeft) + Result, nLen, Caracter);
end;

class function CTeUtil.SeSenao(ACondicao: Boolean; ATrue,
  AFalse: Variant): Variant;
begin
  Result := AFalse;
  if ACondicao then
    Result := ATrue;
end;

class function CTeUtil.FormatDate(const AString: string): string;
var
  vTemp : TDateTime;
{$IFDEF VER140}  //delphi6
{$ELSE}
  FFormato : TFormatSettings;
{$ENDIF}
begin
  try
{$IFDEF VER140} //delphi6
    DateSeparator := '/';
    ShortDateFormat := 'dd/mm/yyyy';
{$ELSE}
    FFormato.DateSeparator := '-';
    FFormato.ShortDateFormat := 'yyyy-mm-dd';
    //    vTemp := StrToDate(AString, FFormato);
{$ENDIF}
    vTemp := StrToDate(AString);
    if vTemp = 0 then
      Result := ''
    else
      Result := DateToStr(vTemp);
  except
    Result := '';
  end;
end;

class function CTeUtil.StringToDate(const AString: string): TDateTime;
begin
  if (AString = '0') or (AString = '') then
    Result := 0
  else
    Result := StrToDate(AString);
end;

class function CTeUtil.StringToTime(const AString: string): TDateTime;
begin
  if (AString = '0') or (AString = '') then
     Result := 0
  else
     Result := StrToTime(AString);
end;

class function CTeUtil.FormatDateTime(const AString: string): string;
var
  vTemp : TDateTime;
{$IFDEF VER140} //delphi6
{$ELSE}
  FFormato : TFormatSettings;
{$ENDIF}
begin
  try
{$IFDEF VER140} //delphi6
    DateSeparator := '/';
    ShortDateFormat := 'dd/mm/yyyy';
    ShortTimeFormat := 'hh:nn:ss';
{$ELSE}
    FFormato.DateSeparator := '-';
    FFormato.ShortDateFormat := 'yyyy-mm-dd';
    //    vTemp := StrToDate(AString, FFormato);
{$ENDIF}
    vTemp := StrToDateTime(AString);
    if vTemp = 0 then
      Result := ''
    else
      Result := DateTimeToStr(vTemp);
  except
    Result := '';
  end;
end;

class function CTeUtil.TamanhoIgual(const AValue: string; const ATamanho: Integer): Boolean;
begin
  Result := (Length(AValue) = ATamanho);
end;

class procedure CTeUtil.TamanhoIgual(const AValue: string; const ATamanho: Integer; AMensagem: string);
begin
  if not (CTeUtil.TamanhoIgual(AValue, ATamanho)) then
    raise Exception.Create(AMensagem);
end;

class function CTeUtil.TamanhoIgual(const AValue, ATamanho: Integer): Boolean;
begin
  Result := (Length(IntToStr(AValue)) = ATamanho);
end;

class procedure CTeUtil.TamanhoIgual(const AValue, ATamanho: Integer; AMensagem: string);
begin
  if not (CTeUtil.TamanhoIgual(AValue, ATamanho)) then
    raise Exception.Create(AMensagem);
end;

class function CTeUtil.TamanhoMenor(const AValue: string; const ATamanho: Integer): Boolean;
begin
  Result := (Length(AValue) < ATamanho);
end;

class function CTeUtil.ValidaUFCidade(const UF, Cidade: Integer): Boolean;
begin
  Result := (Copy(IntToStr(UF), 1, 2) = Copy(IntToStr(Cidade), 1, 2));
end;

class procedure CTeUtil.ValidaUFCidade(const UF, Cidade: Integer; const AMensagem: string);
begin
  if not (ValidaUFCidade(UF, Cidade)) then
    raise Exception.Create(AMensagem);
end;

class function CTeUtil.FormatarChaveAcesso(AValue: String; Mascara: Boolean = False ): String;
begin
  AValue := CTeUtil.LimpaNumero(AValue);
  // Alterado por Italo em 17/05/2011
  if Mascara
   then Result := copy(AValue,1,2)  + '-' + copy(AValue,3,2) + '/' +
                  copy(AValue,5,2)  + '-' + copy(AValue,7,2) + '.' +
                  copy(AValue,9,3)  + '.' + copy(AValue,12,3)+ '/' +
                  copy(AValue,15,4) + '-' + copy(AValue,19,2)+ '-' +
                  copy(AValue,21,2) + '-' + copy(AValue,23,3)+ '-' +
                  copy(AValue,26,3) + '.' + copy(AValue,29,3)+ '.' +
                  copy(AValue,32,3) + '-' + copy(AValue,35,3)+ '.' +
                  copy(AValue,38,3) + '.' + copy(AValue,41,3)+ '-' +
                  copy(AValue,44,1)
   else Result := copy(AValue,1,4)  + ' ' + copy(AValue,5,4)  + ' ' +
                  copy(AValue,9,4)  + ' ' + copy(AValue,13,4) + ' ' +
                  copy(AValue,17,4) + ' ' + copy(AValue,21,4) + ' ' +
                  copy(AValue,25,4) + ' ' + copy(AValue,29,4) + ' ' +
                  copy(AValue,33,4) + ' ' + copy(AValue,37,4) + ' ' +
                  copy(AValue,41,4) ;
end;

class function CTeUtil.PadD(const AString: string; const nLen: Integer; const Caracter: Char): string;
begin
  Result := copy(AString, 1, nLen);
  Result := StringOfChar(Caracter, (nLen - Length(Result))) + Result;
end;

class function CTeUtil.PadE(const AString: string; const nLen: Integer; const Caracter: Char): string;
begin
  Result := copy(AString, 1, nLen);
  Result := Result + StringOfChar(Caracter, (nLen - Length(Result)));
end;

class function CTeUtil.ParseText(Texto: AnsiString; Decode: Boolean): AnsiString;
begin
  if Decode then
   begin
    Texto := StringReplace(Texto, '&amp;', '&', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&lt;', '<', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&gt;', '>', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&quot;', '"', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&#39;', #39, [rfReplaceAll]);
    Texto := StringReplace(Texto, '&aacute;', 'á', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Aacute;', 'Á', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&acirc;' , 'â', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Acirc;' , 'Â', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&atilde;', 'ã', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Atilde;', 'Ã', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&agrave;', 'à', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Agrave;', 'À', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&eacute;', 'é', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Eacute;', 'É', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&ecirc;' , 'ê', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Ecirc;' , 'Ê', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&iacute;', 'í', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Iacute;', 'Í', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&oacute;', 'ó', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Oacute;', 'Ó', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&otilde;', 'õ', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Otilde;', 'Õ', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&ocirc;' , 'ô', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Ocirc;' , 'Ô', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&uacute;', 'ú', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Uacute;', 'Ú', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&uuml;'  , 'ü', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Uuml;'  , 'Ü', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&ccedil;', 'ç', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Ccedil;', 'Ç', [rfReplaceAll]);
    Texto := UTF8Decode(Texto);
   end
  else
   begin
    Texto := StringReplace(Texto, '&', '&amp;', [rfReplaceAll]);
    Texto := StringReplace(Texto, '<', '&lt;', [rfReplaceAll]);
    Texto := StringReplace(Texto, '>', '&gt;', [rfReplaceAll]);
    Texto := StringReplace(Texto, '"', '&quot;', [rfReplaceAll]);
    Texto := StringReplace(Texto, #39, '&#39;', [rfReplaceAll]);
    Texto := UTF8Encode(Texto);
   end;

  Result := Texto;
end;

class function CTeUtil.PathAplication: String;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

class function CTeUtil.Poem_Zeros(const Texto: string; const Tamanho: Integer): string;
begin
  Result := PadD(Trim(Texto), Tamanho, '0');
end;

class function CTeUtil.Poem_Zeros(const Valor, Tamanho: Integer): string;
begin
  Result := PadD(IntToStr(Valor), Tamanho, '0');
end;

class function CTeUtil.PosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
var
  I, X           : Integer;
  Len, LenSubStr : Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

class function CTeUtil.PosLast(const SubStr, S: AnsiString): Integer;
var
  P : Integer;
begin
  Result := 0;
  P := Pos(SubStr, S);

  while P <> 0 do
  begin
    Result := P;
    P := PosEx(SubStr, S, P + 1);
  end;
end;

class function CTeUtil.SeparaDados( Texto : AnsiString; Chave : String; MantemChave : Boolean = False ) : AnsiString;
var
  PosIni, PosFim : Integer;
begin
  if MantemChave then
   begin
     PosIni := Pos(Chave, Texto) - 1;
     PosFim := Pos('/' + Chave, Texto) + length(Chave) + 3;

     if (PosIni = 0) or (PosFim = 0) then
      begin
        PosIni := Pos('ns2:' + Chave, Texto) - 1;
        PosFim := Pos('/ns2:' + Chave, Texto) + length(Chave) + 3;
      end;
   end
  else
   begin
     PosIni := Pos(Chave, Texto) + Pos('>', copy(Texto, Pos(Chave, Texto), length(Texto)));
     PosFim := Pos('/' + Chave, Texto);

     if (PosIni = 0) or (PosFim = 0) then
      begin
        PosIni := Pos('ns2:' + Chave, Texto) + Pos('>', copy(Texto, Pos('ns2:' + Chave, Texto), length(Texto)));
        PosFim := Pos('/ns2:' + Chave, Texto);
      end;
   end;

  Result := copy(Texto, PosIni, PosFim - (PosIni + 1));
{
  PosIni := Pos(Chave, Texto) - 1;
  PosFim := Pos('/' + Chave, Texto) + length(Chave) + 3;

  if (PosIni = 0) or (PosFim = 0) then
  begin
    PosIni := Pos('ns1:' + Chave, Texto) - 1;
    PosFim := Pos('/ns1:' + Chave, Texto) + length(Chave) + 3;
  end;

  Result := copy(Texto, PosIni, PosFim - (PosIni + 1));
 }
end;

{$IFDEF ACBrCTeOpenSSL}

function ValidaLibXML(const AXML: AnsiString;
  var AMsg: AnsiString; const APathSchemas: string = ''): Boolean;
var
  doc, schema_doc   : xmlDocPtr;
  parser_ctxt       : xmlSchemaParserCtxtPtr;
  schema            : xmlSchemaPtr;
  valid_ctxt        : xmlSchemaValidCtxtPtr;
  schemError        : xmlErrorPtr;
  schema_filename   : PChar;
  Tipo, I           : Integer;
begin
  I := pos('<infCte', AXML);
  Tipo := 1;
  if I = 0 then
  begin
    I := pos('<infCanc',AXML) ;
    if I > 0 then
       Tipo := 2
    else
     begin
       I := pos('<infInut',AXML) ;
       if I > 0 then
          Tipo := 3
       else
          Tipo := 4;
     end;
  end;

 if not DirectoryExists(CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
                 PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',
                 PathWithDelim(APathSchemas))) then
    raise Exception.Create('Diretório de Schemas não encontrado'+sLineBreak+
                           CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
                           PathWithDelim(ExtractFileDir(application.ExeName))+
                           'Schemas',PathWithDelim(APathSchemas)));

{$IFDEF PL_103}
 case Tipo of
  1: begin
      if CTeUtil.EstaVazio(APathSchemas) then
        schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\cte_v1.03.xsd')
       else
        schema_filename := pchar(PathWithDelim(APathSchemas)+'cte_v1.03.xsd');
     end;
  2: begin
      if CTeUtil.EstaVazio(APathSchemas) then
        schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\canccte_v1.03.xsd')
       else
        schema_filename := pchar(PathWithDelim(APathSchemas)+'canccte_v1.03.xsd');
     end;
  3: begin
      if CTeUtil.EstaVazio(APathSchemas) then
        schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\inutcte_v1.03.xsd')
       else
        schema_filename := pchar(PathWithDelim(APathSchemas)+'inutcte_v1.03.xsd');
     end;
  4: begin
      {
      if CTeUtil.EstaVazio(APathSchemas) then
        schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\envDPEC_v1.03.xsd')
       else
        schema_filename := pchar(PathWithDelim(APathSchemas)+'envDPEC_v1.03.xsd');
      }
     end;
 end;
{$ENDIF}
{$IFDEF PL_104}
 case Tipo of
  1: begin
      if CTeUtil.EstaVazio(APathSchemas) then
        schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\cte_v1.04.xsd')
       else
        schema_filename := pchar(PathWithDelim(APathSchemas)+'cte_v1.04.xsd');
     end;
  2: begin
      if CTeUtil.EstaVazio(APathSchemas) then
        schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\canccte_v1.04.xsd')
       else
        schema_filename := pchar(PathWithDelim(APathSchemas)+'canccte_v1.04.xsd');
     end;
  3: begin
      if CTeUtil.EstaVazio(APathSchemas) then
        schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\inutcte_v1.04.xsd')
       else
        schema_filename := pchar(PathWithDelim(APathSchemas)+'inutcte_v1.04.xsd');
     end;
  4: begin
      {
      if CTeUtil.EstaVazio(APathSchemas) then
        schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\envDPEC_v1.04.xsd')
       else
        schema_filename := pchar(PathWithDelim(APathSchemas)+'envDPEC_v1.04.xsd');
      }
     end;
 end;
{$ENDIF}

  doc         := nil;
  schema_doc  := nil;
  parser_ctxt := nil;
  schema      := nil;
  valid_ctxt  := nil;
  doc         := xmlParseDoc(PAnsiChar(Axml));

  if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
  begin
    AMsg := 'Erro: unable to parse';
    Result := False;
    exit;
  end;

  schema_doc := xmlReadFile(schema_filename, nil, XML_DETECT_IDS);
  //  the schema cannot be loaded or is not well-formed
  if (schema_doc = nil) then
  begin
    AMsg := 'Erro: Schema não pode ser carregado ou está corrompido';
    Result := False;
    exit;
  end;

  parser_ctxt := xmlSchemaNewDocParserCtxt(schema_doc);
  // unable to create a parser context for the schema */
  if (parser_ctxt = nil) then
  begin
    xmlFreeDoc(schema_doc);
    AMsg := 'Erro: unable to create a parser context for the schema';
    Result := False;
    exit;
  end;

  schema := xmlSchemaParse(parser_ctxt);
  // the schema itself is not valid
  if (schema = nil) then
  begin
    xmlSchemaFreeParserCtxt(parser_ctxt);
    xmlFreeDoc(schema_doc);
    AMsg := 'Error: the schema itself is not valid';
    Result := False;
    exit;
  end;

  valid_ctxt := xmlSchemaNewValidCtxt(schema);
  //   unable to create a validation context for the schema */
  if (valid_ctxt = nil) then
  begin
    xmlSchemaFree(schema);
    xmlSchemaFreeParserCtxt(parser_ctxt);
    xmlFreeDoc(schema_doc);
    AMsg := 'Error: unable to create a validation context for the schema';
    Result := False;
    exit;
  end;

  if (xmlSchemaValidateDoc(valid_ctxt, doc) <> 0) then
  begin
    schemError := xmlGetLastError();
    AMsg := IntToStr(schemError^.code) + ' - ' + schemError^.message;
    Result := False;
    exit;
  end;

  xmlSchemaFreeValidCtxt(valid_ctxt);
  xmlSchemaFree(schema);
  xmlSchemaFreeParserCtxt(parser_ctxt);
  xmlFreeDoc(schema_doc);
  Result := True;
end;
{$ELSE}

function ValidaMSXML(XML: AnsiString; out Msg: AnsiString;
 const APathSchemas: string = ''): Boolean;
var
  DOMDocument : IXMLDOMDocument2;
  ParseError  : IXMLDOMParseError;
  Schema      : XMLSchemaCache;
  Tipo, I     : Integer;
begin
  I := pos('<infCte',XML) ;
  Tipo := 1;
  if I = 0  then
   begin
     I := pos('<infCanc',XML) ;
     if I > 0 then
        Tipo := 2
     else
      begin
        I := pos('<infInut',XML) ;
        if I > 0 then
           Tipo := 3
        else
           Tipo := 4;
      end;
   end;

  DOMDocument                  := CoDOMDocument50.Create;
  DOMDocument.async            := False;
  DOMDocument.resolveExternals := False;
  DOMDocument.validateOnParse  := True;
  DOMDocument.loadXML(XML);

  Schema := CoXMLSchemaCache50.Create;

 if not DirectoryExists(CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
                  PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',
                  PathWithDelim(APathSchemas))) then
    raise Exception.Create('Diretório de Schemas não encontrado'+sLineBreak+
                            CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
                            PathWithDelim(ExtractFileDir(application.ExeName))+
                            'Schemas',PathWithDelim(APathSchemas)));

{$IFDEF PL_103}
  case Tipo of
   1: begin
       Schema.remove('http://www.portalfiscal.inf.br/cte');
       Schema.add('http://www.portalfiscal.inf.br/cte',
        CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
        PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',
        PathWithDelim(APathSchemas))+'cte_v1.03.xsd')
      end;
   2: begin
       Schema.remove('http://www.portalfiscal.inf.br/cte');
       Schema.add('http://www.portalfiscal.inf.br/cte',
        CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
        PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',
        PathWithDelim(APathSchemas))+'cancCte_v1.03.xsd')
      end;
   3: begin
       Schema.remove('http://www.portalfiscal.inf.br/cte');
       Schema.add('http://www.portalfiscal.inf.br/cte',
        CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
        PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',
        PathWithDelim(APathSchemas))+'inutCte_v1.03.xsd')
      end;
   4: begin
       Schema.remove('http://www.portalfiscal.inf.br/cte');
       Schema.add( 'http://www.portalfiscal.inf.br/cte',
        CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
        PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',
        PathWithDelim(APathSchemas))+'envDPEC_v1.03.xsd')
      end;
  end;
{$ENDIF}
{$IFDEF PL_104}
  case Tipo of
   1: begin
       Schema.remove('http://www.portalfiscal.inf.br/cte');
       Schema.add('http://www.portalfiscal.inf.br/cte',
        CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
        PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',
        PathWithDelim(APathSchemas))+'cte_v1.04.xsd')
      end;
   2: begin
       Schema.remove('http://www.portalfiscal.inf.br/cte');
       Schema.add('http://www.portalfiscal.inf.br/cte',
        CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
        PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',
        PathWithDelim(APathSchemas))+'cancCte_v1.04.xsd')
      end;
   3: begin
       Schema.remove('http://www.portalfiscal.inf.br/cte');
       Schema.add('http://www.portalfiscal.inf.br/cte',
        CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
        PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',
        PathWithDelim(APathSchemas))+'inutCte_v1.04.xsd')
      end;
   4: begin
       Schema.remove('http://www.portalfiscal.inf.br/cte');
       Schema.add( 'http://www.portalfiscal.inf.br/cte',
        CTeUtil.SeSenao(CTeUtil.EstaVazio(APathSchemas),
        PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',
        PathWithDelim(APathSchemas))+'envDPEC_v1.04.xsd')
      end;
  end;
{$ENDIF}

  DOMDocument.schemas := Schema;
  ParseError          := DOMDocument.validate;
  Result              := (ParseError.errorCode = 0);
  Msg                 := ParseError.reason;
  DOMDocument         := nil;
  ParseError          := nil;
  Schema              := nil;
end;
{$ENDIF}

class function CTeUtil.Valida(const AXML: AnsiString;
  var AMsg: AnsiString; const APathSchemas: string = ''): Boolean;
begin
{$IFDEF ACBrCTeOpenSSL}
  Result := ValidaLibXML(AXML, AMsg, APathSchemas);
{$ELSE}
  Result := ValidaMSXML(AXML, AMsg, APathSchemas);
{$ENDIF}
end;

{$IFDEF ACBrCTeOpenSSL}

function AssinarLibXML(const AXML, ArqPFX, PFXSenha: AnsiString;
  out AXMLAssinado, FMensagem: AnsiString): Boolean;
var
  I, J, PosIni, PosFim : Integer;
  URI, AStr, XmlAss    : AnsiString;
  Tipo                 : Integer;  // 1 - CTe 2 - Cancelamento 3 - Inutilizacao
begin
  AStr := AXML;

  //// Encontrando o URI ////
  I := pos('<infCte', AStr);
  Tipo := 1;

  if I = 0  then
   begin
     I := pos('<infCanc',AStr) ;
     if I > 0 then
        Tipo := 2
     else
      begin
        I := pos('<infInut',AStr) ;
        if I > 0 then
           Tipo := 3
        else
           Tipo := 4;
      end;
   end;

  if I = 0 then
    raise Exception.Create('Não encontrei inicio do URI: <infCte');
  I := CTeUtil.PosEx('Id=', AStr, I + 6);
  if I = 0 then
    raise Exception.Create('Não encontrei inicio do URI: Id=');
  I := CTeUtil.PosEx('"', AStr, I + 2);
  if I = 0 then
    raise Exception.Create('Não encontrei inicio do URI: aspas inicial');
  J := CTeUtil.PosEx('"', AStr, I + 1);
  if J = 0 then
    raise Exception.Create('Não encontrei inicio do URI: aspas final');

  URI := copy(AStr, I + 1, J - I - 1);

  //// Adicionando Cabeçalho DTD, necessário para xmlsec encontrar o ID ////
  I := pos('?>', AStr);
  //if I = 0 then
  //   raise Exception.Create('Não encontrei inicio do XML: <?xml version="1.0" encoding="UTF-8"?>') ;

  //  AStr := copy(AStr,1,I+1) + cDTD + Copy(AStr,I+2,Length(AStr)) ;
  {  if Tipo = 1 then
       AStr := cDTD + Copy(AStr,I,Length(AStr))
    else if Tipo = 2 then
       AStr := cDTDCanc + Copy(AStr,I+2,Length(AStr))
    else if Tipo = 3 then
       AStr := cDTDInut + Copy(AStr,I+2,Length(AStr));}

  case Tipo of
   1: AStr := copy(AStr, 1, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 1, I))))
         + cDTD + Copy(AStr, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 2, I))),
          Length(AStr));
   2: AStr := copy(AStr, 1, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 1, I))))
         + cDTDCanc + Copy(AStr, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 2, I))),
          Length(AStr));
   3: AStr := copy(AStr, 1, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 1, I))))
         + cDTDInut + Copy(AStr, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 2, I))),
          Length(AStr));
   {
   4: AStr := copy(AStr,1,StrToInt(VarToStr(CTeUtil.SeSenao(I>0,I+1,I))))
         + cDTDDpec + Copy(AStr,StrToInt(VarToStr(CTeUtil.SeSenao(I>0,I+2,I))),
          Length(AStr));
   }
  end;

  {
  if Tipo = 1 then
    AStr := copy(AStr, 1, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 1, I)))) + cDTD + Copy(AStr, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 2, I))), Length(AStr))
  else if Tipo = 2 then
    AStr := copy(AStr, 1, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 1, I)))) + cDTDCanc + Copy(AStr, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 2, I))), Length(AStr))
  else if Tipo = 3 then
    AStr := copy(AStr, 1, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 1, I)))) + cDTDInut + Copy(AStr, StrToInt(VarToStr(CTeUtil.SeSenao(I > 0, I + 2, I))), Length(AStr));
  }

  //// Inserindo Template da Assinatura digital ////
  if Tipo = 1 then
  begin
    I := pos('</CTe>', AStr);
    if I = 0 then
      raise Exception.Create('Não encontrei final do XML: </CTe>');
  end
  else if Tipo = 2 then
  begin
    I := pos('</cancCTe>', AStr);
    if I = 0 then
      raise Exception.Create('Não encontrei final do XML: </cancCTe>');
  end
  else if Tipo = 3 then
  begin
    I := pos('</inutCTe>', AStr);
    if I = 0 then
      raise Exception.Create('Não encontrei final do XML: </inutCTe>');
  end;

  if pos('<Signature', AStr) > 0 then
    I := pos('<Signature', AStr);
  AStr := copy(AStr, 1, I - 1) +
    '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">' +
      '<SignedInfo>' +
        '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />' +
        '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />' +
        '<Reference URI="#' + URI + '">' +
          '<Transforms>' +
            '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />' +
            '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />' +
          '</Transforms>' +
          '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />' +
          '<DigestValue></DigestValue>' +
        '</Reference>' +
      '</SignedInfo>' +
      '<SignatureValue></SignatureValue>' +
      '<KeyInfo>' +
        '<X509Data>' +
          '<X509Certificate></X509Certificate>' +
        '</X509Data>' +
      '</KeyInfo>' +
    '</Signature>';

  if Tipo = 1 then
    AStr := AStr + '</CTe>'
  else if Tipo = 2 then
    AStr := AStr + '</cancCTe>'
  else if Tipo = 3 then
    AStr := AStr + '</inutCTe>';

  XmlAss := CTeUtil.sign_file(PChar(AStr), PChar(ArqPFX), PChar(PFXSenha));

  // Removendo quebras de linha //
  XmlAss := StringReplace(XmlAss, #10, '', [rfReplaceAll]);
  XmlAss := StringReplace(XmlAss, #13, '', [rfReplaceAll]);

  // Removendo DTD //
  if Tipo = 1 then
    XmlAss := StringReplace(XmlAss, cDTD, '', [])
  else if Tipo = 2 then
    XmlAss := StringReplace(XmlAss, cDTDCanc, '', [])
  else if Tipo = 3 then
    XmlAss := StringReplace(XmlAss, cDTDInut, '', []);

  PosIni := Pos('<X509Certificate>', XmlAss) - 1;
  PosFim := CTeUtil.PosLast('<X509Certificate>', XmlAss);

  XmlAss := copy(XmlAss, 1, PosIni) + copy(XmlAss, PosFim, length(XmlAss));

  AXMLAssinado := XmlAss;

  Result := True;
end;
{$ELSE}

function AssinarMSXML(XML: AnsiString; Certificado: ICertificate2; out XMLAssinado: AnsiString): Boolean;
var
  I, J, PosIni, PosFim: Integer;
  URI               : string;
  Tipo              : Integer;

  xmlHeaderAntes, xmlHeaderDepois: AnsiString;
  xmldoc            : IXMLDOMDocument3;
  xmldsig           : IXMLDigitalSignature;
  dsigKey           : IXMLDSigKey;
  signedKey         : IXMLDSigKey;
begin
  if Pos('<Signature', XML) <= 0 then
  begin
    I := pos('<infCte', XML);
    Tipo := 1;

    if I = 0 then
    begin
      I := pos('<infCanc', XML);
      Tipo := 2;
      if I = 0 then
        Tipo := 3;
    end;

    I := CTeUtil.PosEx('Id=', XML, 6);
    if I = 0 then
      raise Exception.Create('Não encontrei inicio do URI: Id=');
    I := CTeUtil.PosEx('"', XML, I + 2);
    if I = 0 then
      raise Exception.Create('Não encontrei inicio do URI: aspas inicial');
    J := CTeUtil.PosEx('"', XML, I + 1);
    if J = 0 then
      raise Exception.Create('Não encontrei inicio do URI: aspas final');

    URI := copy(XML, I + 1, J - I - 1);

    if Tipo = 1 then
      XML := copy(XML, 1, pos('</CTe>', XML) - 1)
    else if Tipo = 2 then
      XML := copy(XML, 1, pos('</cancCTe>', XML) - 1)
    else if Tipo = 3 then
      XML := copy(XML, 1, pos('</inutCTe>', XML) - 1);

    XML := XML + '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#"><SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" /><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />';
    XML := XML + '<Reference URI="#' + URI + '">';
    XML := XML + '<Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" /><Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" /></Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />';
    XML := XML + '<DigestValue></DigestValue></Reference></SignedInfo><SignatureValue></SignatureValue><KeyInfo></KeyInfo></Signature>';

    if Tipo = 1 then
      XML := XML + '</CTe>'
    else if Tipo = 2 then
      XML := XML + '</cancCTe>'
    else if Tipo = 3 then
      XML := XML + '</inutCTe>';
  end;

  // Lendo Header antes de assinar //
  xmlHeaderAntes := '';
  I := pos('?>', XML);
  if I > 0 then
    xmlHeaderAntes := copy(XML, 1, I + 1);

  xmldoc := CoDOMDocument50.Create;

  xmldoc.async := False;
  xmldoc.validateOnParse := False;
  xmldoc.preserveWhiteSpace := True;

  xmldsig := CoMXDigitalSignature50.Create;

  if (not xmldoc.loadXML(XML)) then
    raise Exception.Create('Não foi possível carregar o arquivo: ' + XML);

  xmldoc.setProperty('SelectionNamespaces', DSIGNS);

  xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');

  if (xmldsig.signature = nil) then
    raise Exception.Create('Falha ao setar assinatura.');

  if (xmldsig.signature = nil) then
    raise Exception.Create('É preciso carregar o template antes de assinar.');

   if NumCertCarregado <> Certificado.SerialNumber then
      CertStoreMem := nil;

  if CertStoreMem = nil then
  begin
    CertStore := CoStore.Create;
    CertStore.Open(CAPICOM_CURRENT_USER_STORE, 'My', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

    CertStoreMem := CoStore.Create;
    CertStoreMem.Open(CAPICOM_MEMORY_STORE, 'Memoria', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

    Certs := CertStore.Certificates as ICertificates2;
    for i := 1 to Certs.Count do
    begin
      Cert := IInterface(Certs.Item[i]) as ICertificate2;
      if Cert.SerialNumber = Certificado.SerialNumber then
       begin
         CertStoreMem.Add(Cert);
         NumCertCarregado := Certificado.SerialNumber;
       end;
    end;
  end;

  OleCheck(IDispatch(Certificado.PrivateKey).QueryInterface(IPrivateKey, PrivateKey));
  xmldsig.store := CertStoreMem;

  dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType, PrivateKey.ProviderName, PrivateKey.ContainerName, 0);
  if (dsigKey = nil) then
    raise Exception.Create('Erro ao criar a chave do CSP.');

  signedKey := xmldsig.sign(dsigKey, $00000002);
  if (signedKey <> nil) then
  begin
    XMLAssinado := xmldoc.xml;
    XMLAssinado := StringReplace(XMLAssinado, #10, '', [rfReplaceAll]);
    XMLAssinado := StringReplace(XMLAssinado, #13, '', [rfReplaceAll]);
    PosIni := Pos('<SignatureValue>', XMLAssinado) + length('<SignatureValue>');
    XMLAssinado := copy(XMLAssinado, 1, PosIni - 1) + StringReplace(copy(XMLAssinado, PosIni, length(XMLAssinado)), ' ', '', [rfReplaceAll]);
    PosIni := Pos('<X509Certificate>', XMLAssinado) - 1;
    PosFim := CTeUtil.PosLast('<X509Certificate>', XMLAssinado);

    XMLAssinado := copy(XMLAssinado, 1, PosIni) + copy(XMLAssinado, PosFim, length(XMLAssinado));
  end
  else
    raise Exception.Create('Assinatura Falhou.');

  if xmlHeaderAntes <> '' then
  begin
    I := pos('?>', XMLAssinado);
    if I > 0 then
    begin
      xmlHeaderDepois := copy(XMLAssinado, 1, I + 1);
      if xmlHeaderAntes <> xmlHeaderDepois then
        XMLAssinado := StuffString(XMLAssinado, 1, length(xmlHeaderDepois), xmlHeaderAntes);
    end
    else
      XMLAssinado := xmlHeaderAntes + XMLAssinado;
  end;

  dsigKey := nil;
  signedKey := nil;
  xmldoc := nil;
  xmldsig := nil;

  Result := True;
end;
{$ENDIF}

{$IFDEF ACBrCTeOpenSSL}

class function CTeUtil.sign_file(const Axml: PAnsiChar; const key_file: PChar; const senha: PChar): AnsiString;
var
  doc               : xmlDocPtr;
  node              : xmlNodePtr;
  dsigCtx           : xmlSecDSigCtxPtr;
  buffer            : PChar;
  bufSize           : integer;
label done;
begin
  doc := nil;
  node := nil;
  dsigCtx := nil;
  result := '';

  if (Axml = nil) or (key_file = nil) then Exit;

  try
    { load template }
    doc := xmlParseDoc(Axml);
    if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
      raise Exception.Create('Error: unable to parse');

    { find start node }
    node := xmlSecFindNode(xmlDocGetRootElement(doc), PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
    if (node = nil) then
      raise Exception.Create('Error: start node not found');

    { create signature context, we don't need keys manager in this example }
    dsigCtx := xmlSecDSigCtxCreate(nil);
    if (dsigCtx = nil) then
      raise Exception.Create('Error :failed to create signature context');

    // { load private key}
    dsigCtx^.signKey := xmlSecCryptoAppKeyLoad(key_file, xmlSecKeyDataFormatPkcs12, senha, nil, nil);
    if (dsigCtx^.signKey = nil) then
      raise Exception.Create('Error: failed to load private pem key from "' + key_file + '"');

    { set key name to the file name, this is just an example! }
    if (xmlSecKeySetName(dsigCtx^.signKey, PAnsiChar(key_file)) < 0) then
      raise Exception.Create('Error: failed to set key name for key from "' + key_file + '"');

    { sign the template }
    if (xmlSecDSigCtxSign(dsigCtx, node) < 0) then
      raise Exception.Create('Error: signature failed');

    { print signed document to stdout }
    // xmlDocDump(stdout, doc);
    // Can't use "stdout" from Delphi, so we'll use xmlDocDumpMemory instead...
    buffer := nil;
    xmlDocDumpMemory(doc, @buffer, @bufSize);
    if (buffer <> nil) then
      { success }
      result := buffer;
  finally
    { cleanup }
    if (dsigCtx <> nil) then
      xmlSecDSigCtxDestroy(dsigCtx);

    if (doc <> nil) then
      xmlFreeDoc(doc);
  end;
end;
{$ENDIF}

{$IFDEF ACBrCTeOpenSSL}

class function CTeUtil.Assinar(const AXML, ArqPFX, PFXSenha: AnsiString; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ELSE}

class function CTeUtil.Assinar(const AXML: AnsiString; Certificado: ICertificate2; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ENDIF}
begin
{$IFDEF ACBrCTeOpenSSL}
  Result := AssinarLibXML(AXML, ArqPFX, PFXSenha, AXMLAssinado, FMensagem);
{$ELSE}
  Result := AssinarMSXML(AXML, Certificado, AXMLAssinado);
{$ENDIF}
end;

class function CteUtil.TrataString(const AValue: String): String;
var
  A : Integer ;
begin
  Result := '' ;
  For A := 1 to length(AValue) do
  begin
    case Ord(AValue[A]) of
      60  : Result := Result + '&lt;';  //<
      62  : Result := Result + '&gt;';  //>
      38  : Result := Result + '&amp;'; //&
      34  : Result := Result + '&quot;';//"
      39  : Result := Result + '&#39;'; //'
      32  : begin          // Retira espaços duplos
              if ( Ord(AValue[Pred(A)]) <> 32 ) then
                 Result := Result + ' ';
            end;
      193 : Result := Result + 'A';//Á
      224 : Result := Result + 'a';//à
      226 : Result := Result + 'a';//â
      234 : Result := Result + 'e';//ê
      244 : Result := Result + 'o';//ô
      251 : Result := Result + 'u';//û
      227 : Result := Result + 'a';//ã
      245 : Result := Result + 'o';//õ
      225 : Result := Result + 'a';//á
      233 : Result := Result + 'e';//é
      237 : Result := Result + 'i';//í
      243 : Result := Result + 'o';//ó
      250 : Result := Result + 'u';//ú
      231 : Result := Result + 'c';//ç
      252 : Result := Result + 'u';//ü
      192 : Result := Result + 'A';//À
      194 : Result := Result + 'A';//Â
      202 : Result := Result + 'E';//Ê
      212 : Result := Result + 'O';//Ô
      219 : Result := Result + 'U';//Û
      195 : Result := Result + 'A';//Ã
      213 : Result := Result + 'O';//Õ
      201 : Result := Result + 'E';//É
      205 : Result := Result + 'I';//Í
      211 : Result := Result + 'O';//Ó
      218 : Result := Result + 'U';//Ú
      199 : Result := Result + 'C';//Ç
      220 : Result := Result + 'U';//Ü
    else
      Result := Result + AValue[A];
    end;
  end;
  Result := Trim(Result);
end;

class function CteUtil.TrataString(const AValue: String;
  const ATamanho: Integer): String;
begin
  Result := CteUtil.TrataString(CteUtil.CortaD(AValue, ATamanho));
end;

class function CTeUtil.UFtoCUF(UF : String): Integer;
var
  Codigo, i: Integer;
begin
  Codigo := -1 ;
  for i:= 0 to High(NFeUF) do
  begin
    if NFeUF[I] = UF then
      Codigo := NFeUFCodigo[I];
  end;

  if Codigo < 0 then
     Result := -1
  else
     Result := Codigo;
end;

// Incluido por Italo em 28/01/2011

class function CTeUtil.GerarChaveContingencia(FCTe:TCTe): string;

   function GerarDigito_Contingencia(var Digito: integer; chave: string): boolean;
   var
     i, j: integer;
   const
     PESO = '43298765432987654329876543298765432';
   begin
     chave  := CTeUtil.LimpaNumero(chave);
     j      := 0;
     Digito := 0;
     result := True;
     try
       for i := 1 to 35 do
         j := j + StrToInt(copy(chave, i, 1)) * StrToInt(copy(PESO, i, 1));
       Digito := 11 - (j mod 11);
       if (j mod 11) < 2 then
         Digito := 0;
     except
       result := False;
     end;
     if length(chave) <> 35 then
       result := False;
   end;

var
   wchave: string;
   wicms_s, wicms_p: string;
   wd,wm,wa: word;
   Digito: integer;
begin
   //UF
   if FCTe.Dest.EnderDest.UF = 'EX'
    then wchave := '99' //exterior
    else wchave := copy(inttostr(FCTe.Dest.EnderDest.cMun),1,2);

   //TIPO DE EMISSAO
   if FCTe.Ide.tpEmis = teContingencia
    then wchave := wchave + '2'
    else if FCTe.Ide.tpEmis = teFSDA
          then wchave := wchave + '5'
          else wchave := wchave + '0'; //esta valor caracteriza ERRO, valor tem q ser  2 ou 5

   //CNPJ OU CPF
   if (FCTe.Dest.EnderDest.UF='EX')
    then wchave:=wchave+CTeUtil.Poem_Zeros('0',14)
    else wchave:=wchave+CTeUtil.Poem_Zeros(FCTe.Dest.CNPJCPF,14);

   //VALOR DA CT-e
   wchave := wchave + CTeUtil.Poem_Zeros(CTeUtil.LimpaNumero(FloatToStrf(FCTe.vPrest.vTPrest, ffFixed,18,2)),14);

   //DESTAQUE ICMS PROPRIO E ST
   wicms_p := '2';
   wicms_s := '2';

   // Checar esse trecho

   if (CTeUtil.NaoEstaZerado(FCTe.Imp.ICMS.CST00.vICMS))
    then wicms_p := '1';
   if (CTeUtil.NaoEstaZerado(FCTe.Imp.ICMS.CST80.vICMS))
    then wicms_s := '1';

   wchave := wchave + wicms_p + wicms_s;

   //DIA DA EMISSAO
   decodedate(FCTe.Ide.dhEmi, wa, wm, wd);
   wchave := wchave + CTeUtil.Poem_Zeros(inttostr(wd), 2);

   //DIGITO VERIFICADOR
   GerarDigito_Contingencia(Digito, wchave);
   wchave := wchave + inttostr(digito);

   //RETORNA A CHAVE DE CONTINGENCIA
   result:=wchave;
end;

class function CTeUtil.FormatarChaveContingencia(AValue: String): String;
begin
  AValue := CTeUtil.LimpaNumero(AValue);
  Result := copy(AValue,1,4)  + ' ' + copy(AValue,5,4)  + ' ' +
            copy(AValue,9,4)  + ' ' + copy(AValue,13,4) + ' ' +
            copy(AValue,17,4) + ' ' + copy(AValue,21,4) + ' ' +
            copy(AValue,25,4) + ' ' + copy(AValue,29,4) + ' ' +
            copy(AValue,33,4) ;
end;

end.

