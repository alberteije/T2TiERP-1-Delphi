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
{ Wiliam Zacarias da Silva Rosa  -  wrosa2009@yahoo.com.br -  www.motta.com.br }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 10/08/2009 : Wiliam Zacarias da Silva Rosa
|*  - Criadas classes e procedimentos para acesso aos webservices
|* 08/03/2010 : Bruno - Rhythmus Informatica
|* Corrigida função DoCTeRecepcao
******************************************************************************}
{$I ACBr.inc}

unit ACBrCTeWebServices;

interface

uses Classes, SysUtils,
  {$IFDEF VCL} Dialogs, {$ELSE} QDialogs, {$ENDIF}
  {$IFDEF ACBrCTeOpenSSL}
    HTTPSend,
  {$ELSE}
     SOAPHTTPTrans, WinInet, ACBrCAPICOM_TLB,
     {SoapHTTPClient, }SOAPConst,{ JwaWinCrypt,}
  {$ENDIF}
  pcnAuxiliar, pcnConversao, pcteRetConsCad,
  ACBrCTeConfiguracoes, ACBrCteConhecimentos,
  pcteRetConsReciCTe, pcteProcCte, pcteRetCancCTe, pcteConsReciCTe,
  pcteRetEnvCTe, ActiveX;

type

  TWebServicesBase = Class
  private
  	procedure DoCTeStatusServico;
    procedure DoCTeConsultaCadastro;
    procedure DoCTeConsulta;
    procedure DoCTeCancelamento;
    procedure DoCTeInutilizacao;
    procedure DoCTeRecepcao;
    procedure DoCTeRetRecepcao;
    procedure DoCTeRecibo;

    {$IFDEF ACBrCTeOpenSSL}
       procedure ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
    {$ELSE}
       procedure ConfiguraReqResp( ReqResp : THTTPReqResp);
       procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);
    {$ENDIF}
  protected
    FCabMsg: AnsiString;
    FDadosMsg: AnsiString;
    FRetornoWS: AnsiString;
    FRetWS: AnsiString;
    FMsg: AnsiString;
    FURL: WideString;
    FConfiguracoes: TConfiguracoes;
    FACBrCTe : TComponent;
    procedure LoadMsgEntrada;
    procedure LoadURL;
  public
    function Executar: Boolean;virtual;
    constructor Create(AOwner : TComponent); virtual;
    property CabMsg: AnsiString read FCabMsg;
    property DadosMsg: AnsiString read FDadosMsg;
    property RetornoWS: AnsiString read FRetornoWS;
    property RetWS: AnsiString read FRetWS;
    property Msg: AnsiString read FMsg;
  end;

  TCTeStatusServico = Class(TWebServicesBase)
  private
    FtpAmb : TpcnTipoAmbiente;
    FverAplic : String;
    FcStat : Integer;
    FxMotivo : String;
    FcUF : Integer;
    FdhRecbto : TDateTime;
    FTMed : Integer;
    FdhRetorno : TDateTime;
    FxObs :  String;
  public
    function Executar: Boolean; override;
    property tpAmb : TpcnTipoAmbiente read FtpAmb;
    property verAplic : String read FverAplic;
    property cStat : Integer read FcStat;
    property xMotivo : String read FxMotivo;
    property cUF : Integer read FcUF;
    property dhRecbto : TDateTime read FdhRecbto;
    property TMed : Integer read FTMed;
    property dhRetorno : TDateTime read FdhRetorno;
    property xObs :  String read FxObs;
  end;

  TCTeRecepcao = Class(TWebServicesBase)
  private
    FLote: Integer;
    FRecibo : String;
    FCTes : TConhecimentos;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF : Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    function GetLote: Integer;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ACTes : TConhecimentos);reintroduce;
    property Recibo: String read FRecibo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property Lote: Integer read GetLote write FLote;
  end;

  TCteRetRecepcao = Class(TWebServicesBase)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveCte: String;
    FCTes: TConhecimentos;
    FCteRetorno: TRetConsReciCTe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FcMsg: Integer;
    FxMsg: String;
    function Confirma(AInfProt: TProtCteCollection): Boolean;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; AConhecimentos : TConhecimentos);reintroduce;
    destructor destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property cMsg: Integer read FcMsg;
    property xMsg: String read FxMsg;
    property Recibo: String read FRecibo write FRecibo;
    property Protocolo: String read FProtocolo write FProtocolo;
    property ChaveCte: String read FChaveCte write FChaveCte;
    property CteRetorno: TRetConsReciCte read FCteRetorno write FCteRetorno;
  end;

  TCteRecibo = Class(TWebServicesBase)
  private
    FRecibo: String;
    FCTeRetorno: TRetConsReciCTe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FxMsg: String;
    FcMsg: Integer;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent);reintroduce;
    destructor destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property xMsg: String read FxMsg;
    property cMsg: Integer read FcMsg;
    property Recibo: String read FRecibo write FRecibo;
    property CTeRetorno: TRetConsReciCTe read FCTeRetorno write FCTeRetorno;
  end;

  TCTeConsulta = Class(TWebServicesBase)
  private
    FCTeChave: WideString;
    FProtocolo: WideString;
    FDhRecbto: TDateTime;
    FXMotivo: WideString;
    FTpAmb : TpcnTipoAmbiente;
    FverAplic : String;
    FcStat : Integer;
    FcUF : Integer;
    FdigVal : String;
    FprotCTe: TProcCTe;
    FretCancCTe: TRetCancCTe;
  public
    function Executar: Boolean;override;
    property CTeChave: WideString read FCTeChave write FCTeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto write FDhRecbto;
    property XMotivo: WideString read FXMotivo write FXMotivo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property digVal: String read FdigVal;
    property protCTe: TProcCTe read FprotCTe write FprotCTe;
    property retCancCTe: TRetCancCTe read FretCancCTe write FretCancCTe;
  end;

  TCTeCancelamento = Class(TWebServicesBase)
  private
    FCTeChave: WideString;
    FProtocolo: WideString;
    FJustificativa: WideString;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FDhRecbto: TDateTime;
    FXML_ProcCancCTe: AnsiString;
    procedure SetJustificativa(AValue: WideString);
  public
    function Executar: Boolean;override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property DhRecbto: TDateTime read FDhRecbto;
    property CTeChave: WideString read FCTeChave write FCTeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
    property XML_ProcCancCTe: AnsiString read FXML_ProcCancCTe write FXML_ProcCancCTe;
  end;

  TCTeInutilizacao = Class(TWebServicesBase)
  private
    FCTeChave: WideString;
    FProtocolo: string;
    FModelo: Integer;
    FSerie: Integer;
    FCNPJ: String;
    FAno: Integer;
    FNumeroInicial: Integer;
    FNumeroFinal: Integer;
    FJustificativa: WideString;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo : String;
    FcUF: Integer;
    FdhRecbto: TDateTime;
    FXML_ProcInutCTe: AnsiString;
    procedure SetJustificativa(AValue: WideString);
  public
    function Executar: Boolean;override;
    property CTeChave: WideString read FCTeChave write FCTeChave;
    property Protocolo: String read FProtocolo write FProtocolo;
    property Modelo: Integer read FModelo write FModelo;
    property Serie: Integer read FSerie write FSerie;
    property CNPJ: String read FCNPJ write FCNPJ;
    property Ano: Integer read FAno write FAno;
    property NumeroInicial: Integer read FNumeroInicial write FNumeroInicial;
    property NumeroFinal: Integer read FNumeroFinal write FNumeroFinal;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo : String read FxMotivo;
    property cUF: Integer read FcUF;
    property dhRecbto: TDateTime read FdhRecbto;
    property XML_ProcInutCTe: AnsiString read FXML_ProcInutCTe write FXML_ProcInutCTe;
  end;

  TCTeConsultaCadastro = Class(TWebServicesBase)
  private
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FUF: String;
    FIE: String;
    FCNPJ: String;
    FCPF: String;
    FcUF: Integer;
    FdhCons: TDateTime;
    FRetConsCad : TRetConsCad;
    procedure SetCNPJ(const Value: String);
    procedure SetCPF(const Value: String);
    procedure SetIE(const Value: String);
  public
    function Executar: Boolean;override;
    destructor Destroy; override;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property DhCons: TDateTime read FdhCons;
    property cUF: Integer read FcUF;
    property RetConsCad: TRetConsCad read FRetConsCad;

    property UF:   String read FUF write FUF;
    property IE:   String read FIE write SetIE;
    property CNPJ: String read FCNPJ write SetCNPJ;
    property CPF:  String read FCPF write SetCPF;
  end;

  TWebServices = Class(TWebServicesBase)
  private
    FACBrCTe : TComponent;
    FStatusServico: TCTeStatusServico;
    FEnviar: TCTeRecepcao;
    FRetorno: TCTeRetRecepcao;
    FRecibo: TCTeRecibo;
    FConsulta: TCTeConsulta;
    FCancelamento: TCTeCancelamento;
    FInutilizacao: TCTeInutilizacao;
    FConsultaCadastro: TCTeConsultaCadastro;
  public
    constructor Create(AFCTe: TComponent);reintroduce;
    destructor Destroy; override;
    function Envia(ALote: Integer): Boolean;
    procedure Cancela(AJustificativa: String);
    procedure Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
//  published
    property ACBrCTe: TComponent read FACBrCTe write FACBrCTe;
    property StatusServico: TCTeStatusServico read FStatusServico write FStatusServico;
    property Enviar: TCTeRecepcao read FEnviar write FEnviar;
    property Retorno: TCTeRetRecepcao read FRetorno write FRetorno;
    property Recibo: TCTeRecibo read FRecibo write FRecibo;
    property Consulta: TCTeConsulta read FConsulta write FConsulta;
    property Cancelamento: TCTeCancelamento read FCancelamento write FCancelamento;
    property Inutilizacao: TCTeInutilizacao read FInutilizacao write FInutilizacao;
    property ConsultaCadastro: TCTeConsultaCadastro read FConsultaCadastro write FConsultaCadastro;
  end;

implementation

uses {$IFDEF ACBrCTeOpenSSL}
        ssl_openssl,
     {$ENDIF}
     ACBrUtil, ACBrCTeUtil, ACBrCTe,
     pcnGerador, pcnCabecalho, pcnLeitor,
     pcteConsStatServ, pcteRetConsStatServ,
     pcteConsCad,
     pcteConsSitCTe, pcteRetConsSitCTe,
     pcteCancCTe,
     pcteInutCTe, pcteRetInutCTe;

{$IFNDEF ACBrCTeOpenSSL}
const
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;
{$ENDIF}

{ TWebServicesBase }
constructor TWebServicesBase.Create(AOwner: TComponent);
begin
  FConfiguracoes := TConfiguracoes( TACBrCTe( AOwner ).Configuracoes );
  FACBrCTe       := TACBrCTe( AOwner );
end;

{$IFDEF ACBrCTeOpenSSL}
procedure TWebServicesBase.ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
begin
  if FileExists(FConfiguracoes.Certificados.Certificado) then
    HTTP.Sock.SSL.PFXfile := FConfiguracoes.Certificados.Certificado
  else
    HTTP.Sock.SSL.PFX     := FConfiguracoes.Certificados.Certificado;

  HTTP.Sock.SSL.KeyPassword := FConfiguracoes.Certificados.Senha;

  HTTP.ProxyHost := FConfiguracoes.WebServices.ProxyHost;
  HTTP.ProxyPort := FConfiguracoes.WebServices.ProxyPort;
  HTTP.ProxyUser := FConfiguracoes.WebServices.ProxyUser;
  HTTP.ProxyPass := FConfiguracoes.WebServices.ProxyPass;

  // Linha abaixo comentada por Italo em 08/09/2010
//  HTTP.Sock.RaiseExcept := True;

  HTTP.MimeType  := 'text/xml; charset=utf-8';
  HTTP.UserAgent := '';
  HTTP.Protocol  := '1.1'; // (1.2 para 1.1) Alterado por Italo em 13/01/2011

  HTTP.AddPortNumberToHost := False;
  HTTP.Headers.Add(Action);
end;

{$ELSE}
procedure TWebServicesBase.ConfiguraReqResp( ReqResp : THTTPReqResp);
begin
  if FConfiguracoes.WebServices.ProxyHost <> '' then
   begin
     ReqResp.Proxy    := FConfiguracoes.WebServices.ProxyHost+':'+FConfiguracoes.WebServices.ProxyPort;
     ReqResp.UserName := FConfiguracoes.WebServices.ProxyUser;
     ReqResp.Password := FConfiguracoes.WebServices.ProxyPass;
   end;
  ReqResp.OnBeforePost := OnBeforePost;
end;

procedure TWebServicesBase.OnBeforePost(const HTTPReqResp: THTTPReqResp;
  Data: Pointer);
var
  Cert         : ICertificate2;
  CertContext  : ICertContext;
  PCertContext : Pointer;
  ContentHeader: string;
begin
  Cert        := FConfiguracoes.Certificados.GetCertificado;
  CertContext :=  Cert as ICertContext;
  CertContext.Get_CertContext(Integer(PCertContext));

  if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT, PCertContext,SizeOf(CertContext)*5) then
   begin
     if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
        TACBrCTe( FACBrCTe ).OnGerarLog('ERRO: Erro OnBeforePost: ' + IntToStr(GetLastError));
     raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;

   if trim(FConfiguracoes.WebServices.ProxyUser) <> '' then begin
     if not InternetSetOption(Data, INTERNET_OPTION_PROXY_USERNAME, PChar(FConfiguracoes.WebServices.ProxyUser), Length(FConfiguracoes.WebServices.ProxyUser)) then
       raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;
   if trim(FConfiguracoes.WebServices.ProxyPass) <> '' then begin
     if not InternetSetOption(Data, INTERNET_OPTION_PROXY_PASSWORD, PChar(FConfiguracoes.WebServices.ProxyPass),Length (FConfiguracoes.WebServices.ProxyPass)) then
       raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;

  ContentHeader := Format(ContentTypeTemplate, ['application/soap+xml; charset=utf-8']);
  HttpAddRequestHeaders(Data, PChar(ContentHeader), Length(ContentHeader), HTTP_ADDREQ_FLAG_REPLACE);
end;
{$ENDIF}

procedure TWebServicesBase.DoCTeCancelamento;
var
  CancCTe: TcancCTe;
begin
  CancCTe        := TcancCTe.Create;
 {$IFDEF PL_103}
  CancCTe.schema := TsPL_CTe_103;
 {$ENDIF}
 {$IFDEF PL_104}
  CancCTe.schema := TsPL_CTe_104;
 {$ENDIF}
  CancCTe.chCTe  := TCTeCancelamento(Self).CTeChave;
  CancCTe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  CancCTe.nProt  := TCTeCancelamento(Self).Protocolo;
  CancCTe.xJust  := TCTeCancelamento(Self).Justificativa;
  CancCTe.GerarXML;

{$IFDEF ACBrCTeOpenSSL}
  if not(CTeUtil.Assinar(CancCTe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
    begin
      if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
         TACBrCTe( FACBrCTe ).OnGerarLog('ERRO: Falha ao assinar Cancelamento Conhecimento Eletrônico '+LineBreak+FMsg);
      raise Exception.Create('Falha ao assinar Cancelamento Conhecimento Eletrônico '+LineBreak+FMsg);
    end;
{$ELSE}
  if not(CTeUtil.Assinar(CancCTe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
    begin
      if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
         TACBrCTe( FACBrCTe ).OnGerarLog('Falha ao assinar Cancelamento Conhecimento Eletrônico '+LineBreak+FMsg);
      raise Exception.Create('Falha ao assinar Cancelamento Conhecimento Eletrônico '+LineBreak+FMsg);
    end;
{$ENDIF}

  if not(CTeUtil.Valida(FDadosMsg, FMsg, TACBrCTe( FACBrCTe ).Configuracoes.Geral.PathSchemas)) then
     begin
       if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
          TACBrCTe( FACBrCTe ).OnGerarLog('Falha na validação dos dados do cancelamento '+LineBreak+FMsg);
       raise Exception.Create('Falha na validação dos dados do cancelamento '+LineBreak+FMsg);
     end;

  CancCTe.Free;

//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoCTeConsulta;
var
  ConsSitCTe : TConsSitCTe;
begin
  ConsSitCTe        := TConsSitCTe.Create;
 {$IFDEF PL_103}
  ConsSitCTe.schema := TsPL_CTe_103;
 {$ENDIF}
 {$IFDEF PL_104}
  ConsSitCTe.schema := TsPL_CTe_104;
 {$ENDIF}
  ConsSitCTe.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsSitCTe.chCTe  := TCTeConsulta(Self).CTeChave;
  ConsSitCTe.GerarXML;

  FDadosMsg := ConsSitCTe.Gerador.ArquivoFormatoXML;
  ConsSitCTe.Free;

//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoCTeInutilizacao;
var
  InutCTe: TinutCTe;
begin
  InutCTe        := TinutCTe.Create;
 {$IFDEF PL_103}
  InutCTe.schema := TsPL_CTe_103;
 {$ENDIF}
 {$IFDEF PL_104}
  InutCTe.schema := TsPL_CTe_104;
 {$ENDIF}
  InutCTe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  InutCTe.cUF    := FConfiguracoes.WebServices.UFCodigo;
  InutCTe.ano    := TCTeInutilizacao(Self).Ano;
  InutCTe.CNPJ   := TCTeInutilizacao(Self).CNPJ;
  InutCTe.modelo := TCTeInutilizacao(Self).Modelo;
  InutCTe.serie  := TCTeInutilizacao(Self).Serie;
  InutCTe.nCTIni := TCTeInutilizacao(Self).NumeroInicial;
  InutCTe.nCTFin := TCTeInutilizacao(Self).NumeroFinal;
  InutCTe.xJust  := TCTeInutilizacao(Self).Justificativa;
  InutCTe.GerarXML;

{$IFDEF ACBrCTeOpenSSL}
  if not(CTeUtil.Assinar(InutCTe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
          TACBrCTe( FACBrCTe ).OnGerarLog('Falha ao assinar Inutilização Conhecimento Eletrônico '+LineBreak+FMsg);
       raise Exception.Create('Falha ao assinar Inutilização Conhecimento Eletrônico '+LineBreak+FMsg);
     end;
{$ELSE}
  if not(CTeUtil.Assinar(InutCTe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
          TACBrCTe( FACBrCTe ).OnGerarLog('Falha ao assinar Inutilização Conhecimento Eletrônico '+LineBreak+FMsg);
       raise Exception.Create('Falha ao assinar Inutilização Conhecimento Eletrônico '+LineBreak+FMsg);
     end;
{$ENDIF}

  TCTeInutilizacao(Self).CTeChave := InutCTe.ID;

  InutCTe.Free;

//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoCTeConsultaCadastro;
var
  Cabecalho: TCabecalho;
  ConCadCTe: TConsCad;
begin
  Cabecalho             := TCabecalho.Create;
  Cabecalho.Versao      := CTecabMsg;  // Alterado de NFecabMsg por CTecabMsg por Italo em 18/03/2011
  Cabecalho.VersaoDados := CTeconsCad; // Alterado de NFeconsCad por CTeconsCad por Italo em 18/03/2011
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;
  // Italo
  FCabMsg := StringReplace( FCabMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FCabMsg := StringReplace( FCabMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FCabMsg := StringReplace( FCabMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;

  ConCadCTe        := TConsCad.Create;
  ConCadCTe.schema := TsPL005c;
  ConCadCTe.UF     := TCTeConsultaCadastro(Self).UF;
  ConCadCTe.IE     := TCTeConsultaCadastro(Self).IE;
  ConCadCTe.CNPJ   := TCTeConsultaCadastro(Self).CNPJ;
  ConCadCTe.CPF    := TCTeConsultaCadastro(Self).CPF;
  ConCadCTe.GerarXML;

  FDadosMsg := ConCadCTe.Gerador.ArquivoFormatoXML;

  ConCadCTe.Free;
  // Italo
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoCTeRecepcao;
var
  i    : Integer;
  vCtes: WideString;
begin
  vCtes := '';
  for i := 0 to TCTeRecepcao(Self).FCTes.Count-1 do
    vCtes := vCtes + TCTeRecepcao(Self).FCTes.Items[I].XML;

  vCtes := StringReplace( vCtes, '<?xml version="1.0" encoding="UTF-8" ?>', '', [rfReplaceAll] );
  vCtes := StringReplace( vCtes, '<?xml version="1.0" encoding="UTF-8"?>' , '', [rfReplaceAll] );

  FDadosMsg := '<enviCTe xmlns="http://www.portalfiscal.inf.br/cte" versao="'+CTeenviCTe+'">'+
               '<idLote>'+IntToStr(TCTeRecepcao(Self).Lote)+'</idLote>'+vCtes+'</enviCTe>';

  if Length(FDadosMsg) > (500 * 1024) then
   begin
      if Assigned(TACBrCTe(Self.FACBrCTe).OnGerarLog) then
         TACBrCTe(Self.FACBrCTe).OnGerarLog('ERRO: Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: '+FloatToStr(Int(Length(FDadosMsg)/500))+' Kbytes');
      raise Exception.Create('ERRO: Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: '+FloatToStr(Int(Length(FDadosMsg)/500))+' Kbytes');
      exit;
   end;
end;

procedure TWebServicesBase.DoCTeRetRecepcao;
var
  ConsReciCTe: TConsReciCTe;
begin
  ConsReciCTe        := TConsReciCTe.Create;
 {$IFDEF PL_103}
  ConsReciCTe.schema := TsPL_CTe_103;
 {$ENDIF}
 {$IFDEF PL_104}
  ConsReciCTe.schema := TsPL_CTe_104;
 {$ENDIF}
  ConsReciCTe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciCTe.nRec   := TCTeRetRecepcao(Self).Recibo;
  ConsReciCTe.GerarXML;

  FDadosMsg := ConsReciCTe.Gerador.ArquivoFormatoXML;
  ConsReciCTe.Free;

//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoCTeRecibo;
var
  Cabecalho: TCabecalho;
  ConsReciCTe: TConsReciCTe;
begin
  // Janis
  // Inicio
  Cabecalho             := TCabecalho.Create;
  Cabecalho.Versao      := CTecabMsg;
  Cabecalho.VersaoDados := CTeconsReciCTe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;
  // Fim

  ConsReciCTe        := TConsReciCTe.Create;
 {$IFDEF PL_103}
  ConsReciCTe.schema := TsPL_CTe_103;
 {$ENDIF}
 {$IFDEF PL_104}
  ConsReciCTe.schema := TsPL_CTe_104;
 {$ENDIF}
  ConsReciCTe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciCTe.nRec   := TCTeRecibo(Self).Recibo;
  ConsReciCTe.GerarXML;

  FDadosMsg := ConsReciCTe.Gerador.ArquivoFormatoXML;
  ConsReciCTe.Free;
end;

procedure TWebServicesBase.DoCTeStatusServico;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ        := TConsStatServ.create;
 {$IFDEF PL_103}
  ConsStatServ.schema := TsPL_CTe_103;
 {$ENDIF}
 {$IFDEF PL_104}
  ConsStatServ.schema := TsPL_CTe_104;
 {$ENDIF}
  ConsStatServ.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsStatServ.CUF    := FConfiguracoes.WebServices.UFCodigo;

  ConsStatServ.GerarXML;

  FDadosMsg := ConsStatServ.Gerador.ArquivoFormatoXML;
  ConsStatServ.Free;

//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

function TWebServicesBase.Executar: Boolean;
begin
  Result := False;
  LoadMsgEntrada;
  LoadURL;
end;

procedure TWebServicesBase.LoadMsgEntrada;
begin
  if self is TCTeStatusServico then
    DoCTeStatusServico
  else if self is TCTeRecepcao then
    DoCTeRecepcao
  else if self is TCTeRetRecepcao then
    DoCTeRetRecepcao
  else if self is TCTeRecibo then
    DoCTeRecibo
  else if self is TCTeConsulta then
    DoCTeConsulta
  else if self is TCTeCancelamento then
    DoCTeCancelamento
  else if self is TCTeInutilizacao then
    DoCTeInutilizacao
  else if self is TCTeConsultaCadastro then
    DoCTeConsultaCadastro
//  else if self is TCTeEnvDPEC then
//    DoCTeEnvDPEC
//  else if self is TCTeConsultaDPEC then
//    DoCTeConsultaDPEC
end;

procedure TWebServicesBase.LoadURL;
begin
  if self is TCTeStatusServico then
    FURL := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeStatusServico)
  else if self is TCTeRecepcao then
    FURL := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeRecepcao)
  else if (self is TCTeRetRecepcao) or (self is TCTeRecibo) then
    FURL := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeRetRecepcao)
  else if self is TCTeConsulta then
    FURL := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeConsultaCT)
  else if self is TCTeCancelamento then
    FURL := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeCancelamento)
  else if self is TCTeInutilizacao then
    FURL := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeInutilizacao)
  else if self is TCTeConsultaCadastro then
    FURL := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeCadastro)
//  else if self is TCTeEnvDPEC then
//    FURL := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeEnvDPEC)
//  else if self is TCTeConsultaDPEC then
//    FURL := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeConsultaDPEC)
end;

{ TWebServices }
procedure TWebServices.Cancela(AJustificativa: String);
begin
// retirado por recomendação do documento disponivel em http://www.nfe.fazenda.gov.br/PORTAL/docs/Consumo_Indevido_Aplicacao_Cliente_v1.00.pdf
{  if TACBrCTe( FACBrCTe ).Configuracoes.Geral.FormaEmissao = teNormal then
   begin
     if not(Self.StatusServico.Executar) then
      begin
        if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
           TACBrCTe( FACBrCTe ).OnGerarLog(Self.StatusServico.Msg);
        raise Exception.Create(Self.StatusServico.Msg);
      end;
   end;}

  if not(Self.Consulta.Executar) then
     begin
       if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
          TACBrCTe( FACBrCTe ).OnGerarLog(Self.Consulta.Msg);
       raise Exception.Create(Self.Consulta.Msg);
     end;

  Self.Cancelamento.CTeChave      := Self.Consulta.CTeChave;
  Self.Cancelamento.Protocolo     := Self.Consulta.FProtocolo;
  Self.Cancelamento.Justificativa := AJustificativa;
  if not(Self.Cancelamento.Executar) then
     begin
       if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
          TACBrCTe( FACBrCTe ).OnGerarLog(Self.Cancelamento.Msg);
       raise Exception.Create(Self.Cancelamento.Msg);
     end;
end;

procedure TWebServices.Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
begin
// retirado por recomendação do documento disponivel em http://www.nfe.fazenda.gov.br/PORTAL/docs/Consumo_Indevido_Aplicacao_Cliente_v1.00.pdf
{  if TACBrCTe( FACBrCTe ).Configuracoes.Geral.FormaEmissao = teNormal then
   begin
     if not(Self.StatusServico.Executar) then
      begin
        if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
           TACBrCTe( FACBrCTe ).OnGerarLog(Self.StatusServico.Msg);
         raise Exception.Create('WebService Consulta Status serviço:'+LineBreak+
                               '- Inativo ou Inoperante tente novamente.'+LineBreak+
                               Self.StatusServico.Msg);
      end;
   end;}
  CNPJ := OnlyNumber(CNPJ);
  if not ValidarCNPJ(CNPJ) then
     raise Exception.Create('CNPJ '+CNPJ+' inválido.');

  Self.Inutilizacao.CTeChave      := 'ID';
  Self.Inutilizacao.CNPJ          := CNPJ;
  Self.Inutilizacao.Modelo        := Modelo;
  Self.Inutilizacao.Serie         := Serie;
  Self.Inutilizacao.Ano           := Ano;
  Self.Inutilizacao.NumeroInicial := NumeroInicial;
  Self.Inutilizacao.NumeroFinal   := NumeroFinal;
  Self.Inutilizacao.Justificativa := AJustificativa;

  if not(Self.Inutilizacao.Executar) then
     begin
       if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
          TACBrCTe( FACBrCTe ).OnGerarLog(Self.Inutilizacao.Msg);
       raise Exception.Create(Self.Inutilizacao.Msg);
     end;
end;

constructor TWebServices.Create(AFCTe: TComponent);
begin
 inherited Create( AFCTe );
  FACBrCTe          := TACBrCTe(AFCTe);
  FStatusServico    := TCTeStatusServico.Create(AFCTe);
  FEnviar           := TCTeRecepcao.Create(AFCTe, TACBrCTe(AFCTe).Conhecimentos);
  FRetorno          := TCTeRetRecepcao.Create(AFCTe, TACBrCTe(AFCTe).Conhecimentos);
  FRecibo           := TCTeRecibo.create(AFCTe);
  FConsulta         := TCTeConsulta.Create(AFCTe);
  FCancelamento     := TCTeCancelamento.Create(AFCTe);
  FInutilizacao     := TCTeInutilizacao.Create(AFCTe);
  FConsultaCadastro := TCTeConsultaCadastro.Create(AFCTe);
//  FEnviaDPEC        := TCTeEnvDPEC.Create(AFCTe);
//  FConsultaDPEC     := TCTeConsultaDPEC.Create(AFCTe);
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FEnviar.Free;
  FRetorno.Free;
  FRecibo.Free;
  FConsulta.Free;
  FCancelamento.Free;
  FInutilizacao.Free;
  FConsultaCadastro.Free;
//  FEnviaDPEC.free;
//  FConsultaDPEC.free;
  inherited;
end;

function TWebServices.Envia(ALote: Integer): Boolean;
begin
// retirado por recomendação do documento disponivel em http://www.nfe.fazenda.gov.br/PORTAL/docs/Consumo_Indevido_Aplicacao_Cliente_v1.00.pdf
{  if not(Self.StatusServico.Executar) then
     begin
       if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
          TACBrCTe( FACBrCTe ).OnGerarLog(Self.StatusServico.Msg);
       raise Exception.Create(Self.StatusServico.Msg);
     end;}

  self.Enviar.FLote := ALote;
  if not(Self.Enviar.Executar) then
     begin
       if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
          TACBrCTe( FACBrCTe ).OnGerarLog(Self.Enviar.Msg);
       raise Exception.Create(Self.Enviar.Msg);
     end;

  Self.Retorno.Recibo := Self.Enviar.Recibo;
  if not(Self.Retorno.Executar) then
     begin
       if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
          TACBrCTe( FACBrCTe ).OnGerarLog(Self.Retorno.Msg);
       raise Exception.Create(Self.Retorno.Msg);
     end;
  Result := true;
end;

{ TCTeStatusServico }
function TCTeStatusServico.Executar: Boolean;
var
  CTeRetorno: TRetConsStatServ;
  aMsg  : string;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;

  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  {Result :=} inherited Executar;

  Result := False;
  
  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteStatusServico">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+CTeconsStatServ+'</versaoDados>';
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteStatusServico">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrCTeOpenSSL}
     Acao.SaveToStream(Stream);
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteStatusServico/cteStatusServicoCT';
  {$ENDIF}

  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeStatusServico );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ped-sta.xml', FDadosMsg);

    try
      {$IFDEF ACBrCTeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteStatusServico/cteStatusServicoCT"');
         HTTP.HTTPMethod('POST', FURL);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);

         FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
         FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteStatusServicoCTResult');
         StrStream.Free;
      {$ELSE}
         ReqResp.Execute(Acao.Text, Stream);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(Stream, 0);
         FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
         FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteStatusServicoCTResult');
         StrStream.Free;
      {$ENDIF}
      CTeRetorno := TRetConsStatServ.Create;
      CTeRetorno.Leitor.Arquivo := FRetWS;
      CTeRetorno.LerXml;

      TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
      aMsg := 'Ambiente : '+TpAmbToStr(CTeRetorno.tpAmb)+LineBreak+
              'Versão Aplicativo : '+CTeRetorno.verAplic+LineBreak+
              'Status Código : '+IntToStr(CTeRetorno.cStat)+LineBreak+
              'Status Descrição : '+CTeRetorno.xMotivo+LineBreak+
              'UF : '+CodigoParaUF(CTeRetorno.cUF)+LineBreak+
              'Recebimento : '+CTeUtil.SeSenao(CTeRetorno.DhRecbto = 0, '', DateTimeToStr(CTeRetorno.dhRecbto))+LineBreak+
              'Tempo Médio : '+IntToStr(CTeRetorno.TMed)+LineBreak+
              'Retorno : '+ CTeUtil.SeSenao(CTeRetorno.dhRetorno = 0, '', DateTimeToStr(CTeRetorno.dhRetorno))+LineBreak+
              'Observação : '+CTeRetorno.xObs;
      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
         TACBrCTe( FACBrCTe ).OnGerarLog(aMsg);

      FtpAmb     := CTeRetorno.tpAmb;
      FverAplic  := CTeRetorno.verAplic;
      FcStat     := CTeRetorno.cStat;
      FxMotivo   := CTeRetorno.xMotivo;
      FcUF       := CTeRetorno.cUF;
      FdhRecbto  := CTeRetorno.dhRecbto;
      FTMed      := CTeRetorno.TMed;
      FdhRetorno := CTeRetorno.dhRetorno;
      FxObs      := CTeRetorno.xObs;

      if TACBrCTe( FACBrCTe ).Configuracoes.WebServices.AjustaAguardaConsultaRet then
         TACBrCTe( FACBrCTe ).Configuracoes.WebServices.AguardarConsultaRet := FTMed * 1000;

      FMsg   := CTeRetorno.XMotivo + LineBreak+CTeRetorno.XObs;

      Result := (CTeRetorno.CStat = 107); // 107 = Serviço em Operação
      CTeRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-sta.xml', FRetWS);

    except on E: Exception do
      begin
       if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
          TACBrCTe( FACBrCTe ).OnGerarLog('WebService Consulta Status serviço:'+LineBreak+
                                          '- Inativo ou Inoperante tente novamente.'+LineBreak+
                                          '- '+E.Message);
       raise Exception.Create('WebService Consulta Status serviço:'+LineBreak+
                              '- Inativo ou Inoperante tente novamente.'+LineBreak+
                              '- '+E.Message);
      end;
    end;

  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    CTeUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

{ TCTeRecepcao }
constructor TCTeRecepcao.Create(AOwner: TComponent; ACTes: TConhecimentos);
begin
  inherited Create(AOwner);
  FCTes := ACTes;
end;

function TCTeRecepcao.Executar: Boolean;
var
  CTeRetorno: TretEnvCTe;
  aMsg  : string;
  Texto : String; //  Texto : WideString;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;

  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  {Result :=} inherited Executar;

  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRecepcao">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+CTeenviCTe+'</versaoDados>';
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRecepcao">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrCTeOpenSSL}
     Acao.SaveToStream(Stream);
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteRecepcao/cteRecepcaoLote';
  {$ENDIF}

  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeRecepcao );
    // Alterado por Italo em 23/02/2011
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(Lote)+'-env-lot.xml', FDadosMsg);

    try
      {$IFDEF ACBrCTeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteRecepcao/cteRecepcaoLote"');
         HTTP.HTTPMethod('POST', FURL);

         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);
         FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
         FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteRecepcaoLoteResult');
         StrStream.Free;
      {$ELSE}
         ReqResp.Execute(Acao.Text, Stream);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(Stream, 0);
         FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
         FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteRecepcaoLoteResult');
         StrStream.Free;
      {$ENDIF}
      CTeRetorno := TretEnvCTe.Create;
      CTeRetorno.Leitor.Arquivo := FRetWS;
      CTeRetorno.LerXml;

      TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
      aMsg := 'Ambiente : '+TpAmbToStr(CTeRetorno.tpAmb)+LineBreak+
                      'Versão Aplicativo : '+CTeRetorno.verAplic+LineBreak+
                      'Status Código : '+IntToStr(CTeRetorno.cStat)+LineBreak+
                      'Status Descrição : '+CTeRetorno.xMotivo+LineBreak+
                      'UF : '+CodigoParaUF(CTeRetorno.cUF)+LineBreak+
                      'Recebimento : '+CTeUtil.SeSenao(CTeRetorno.InfRec.dhRecbto = 0, '', DateTimeToStr(CTeRetorno.InfRec.dhRecbto))+LineBreak+
                      'Tempo Médio : '+IntToStr(CTeRetorno.infRec.tMed)+LineBreak+
                      'Número Recibo: '+CTeRetorno.infRec.nRec;
      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
         TACBrCTe( FACBrCTe ).OnGerarLog(aMsg);

      FtpAmb    := CTeRetorno.tpAmb;
      FverAplic := CTeRetorno.verAplic;
      FcStat    := CTeRetorno.cStat;
      FxMotivo  := CTeRetorno.xMotivo;
      FcUF      := CTeRetorno.cUF;
      FdhRecbto := CTeRetorno.infRec.dhRecbto;
      FTMed     := CTeRetorno.infRec.tMed;
      FRecibo   := CTeRetorno.infRec.nRec;
      FMsg      := CTeRetorno.XMotivo;

      Result := (CTeRetorno.CStat = 103); // 103 = Lote Recebido

      CTeRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(IntToStr(Lote)+'-rec.xml', FRetWS);

    except on E: Exception do
      begin
        raise Exception.Create('WebService Retorno de Recepção:'+LineBreak+
                               '- Inativo ou Inoperante tente novamente.'+LineBreak+
                               '- '+E.Message);
      end;
    end;

  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    CTeUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

function TCTeRecepcao.GetLote: Integer;
begin
  Result := FLote;
end;

{ TCteRetRecepcao }
function TCteRetRecepcao.Confirma(AInfProt: TProtCteCollection): Boolean;
var
  i,j     : Integer;
  AProcCTe: TProcCte;
begin
  Result := False;

  //Setando os retornos dos conhecimentos;
  for i := 0 to AInfProt.Count-1 do
  begin
    for j := 0 to FCTes.Count-1 do
    begin
      if AInfProt.Items[i].chCTe = StringReplace(FCTes.Items[j].CTe.InfCTe.Id,'CTe','',[rfIgnoreCase]) then
       begin
         FCTes.Items[j].Confirmada           := (AInfProt.Items[i].cStat = 100); // 100 = Autorizao o Uso
         FCTes.Items[j].Msg                  := AInfProt.Items[i].xMotivo;
         FCTes.Items[j].CTe.procCTe.tpAmb    := AInfProt.Items[i].tpAmb;
         FCTes.Items[j].CTe.procCTe.verAplic := AInfProt.Items[i].verAplic;
         FCTes.Items[j].CTe.procCTe.chCTe    := AInfProt.Items[i].chCTe;
         FCTes.Items[j].CTe.procCTe.dhRecbto := AInfProt.Items[i].dhRecbto;
         FCTes.Items[j].CTe.procCTe.nProt    := AInfProt.Items[i].nProt;
         FCTes.Items[j].CTe.procCTe.digVal   := AInfProt.Items[i].digVal;
         FCTes.Items[j].CTe.procCTe.cStat    := AInfProt.Items[i].cStat;
         FCTes.Items[j].CTe.procCTe.xMotivo  := AInfProt.Items[i].xMotivo;

         if FConfiguracoes.Geral.Salvar or CTeUtil.NaoEstaVazio(FCTes.Items[j].NomeArq) then
          begin
            if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chCTe+'-cte.xml') and
               FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FCTeRetorno.nRec+'-pro-rec.xml') then
             begin
               AProcCTe := TProcCTe.Create;
               AProcCTe.PathCTe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chCTe+'-cte.xml';
               AProcCTe.PathRetConsReciCTe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FCTeRetorno.nRec+'-pro-rec.xml';
               AProcCTe.GerarXML;
               if CTeUtil.NaoEstaVazio(AProcCTe.Gerador.ArquivoFormatoXML) then
                begin
                  if CTeUtil.NaoEstaVazio(FCTes.Items[j].NomeArq) then
                     AProcCTe.Gerador.SalvarArquivo(FCTes.Items[j].NomeArq)
                  else
                     AProcCTe.Gerador.SalvarArquivo(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chCTe+'-cte.xml');
                end;
               AProcCTe.Free;
             end;
          end;
         if FConfiguracoes.Arquivos.Salvar then
            if FConfiguracoes.Arquivos.EmissaoPathCTe then
               FCTes.Items[j].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathCTe(FCTes.Items[j].CTe.Ide.dhEmi))+StringReplace(FCTes.Items[j].CTe.InfCTe.Id,'CTe','',[rfIgnoreCase])+'-cte.xml')
            else
               FCTes.Items[j].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathCTe)+StringReplace(FCTes.Items[j].CTe.InfCTe.Id,'CTe','',[rfIgnoreCase])+'-cte.xml');
         break;
       end;
    end;
  end;

  //Verificando se existe algum Conhecimento confirmada
  for i := 0 to FCTes.Count-1 do
  begin
    if FCTes.Items[i].Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe algum Conhecimento nao confirmada
  for i := 0 to FCTes.Count-1 do
  begin
    if not(FCTes.Items[i].Confirmada) then
    begin
      FMsg := 'Conhecimento(s) não confirmado(s):'+LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para os Conhecimento nao confirmadas
  for i := 0 to FCTes.Count-1 do
  begin
    if not(FCTes.Items[i].Confirmada) then
      FMsg := FMsg+IntToStr(FCTes.Items[i].CTe.Ide.nCT)+'->'+FCTes.Items[i].Msg+LineBreak;
  end;
end;

constructor TCteRetRecepcao.Create(AOwner: TComponent;
  AConhecimentos: TConhecimentos);
begin
  inherited Create(AOwner);
  FCTes := AConhecimentos;
end;

destructor TCteRetRecepcao.destroy;
begin
   if assigned(FCteRetorno) then
      FCteRetorno.Free;
   inherited;
end;

function TCteRetRecepcao.Executar: Boolean;

 function Processando: Boolean;
 var
    aMsg  : string;
    Texto : String;
    Acao  : TStringList ;
    Stream: TMemoryStream;
    StrStream: TStringStream;
    {$IFDEF ACBrCTeOpenSSL}
       HTTP: THTTPSend;
    {$ELSE}
       ReqResp: THTTPReqResp;
    {$ENDIF}
 begin
    Acao   := TStringList.Create;
    Stream := TMemoryStream.Create;

    Texto := '<?xml version="1.0" encoding="utf-8"?>';
    Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
    Texto := Texto +   '<soap12:Header>';
    Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao">';
    Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
    Texto := Texto +       '<versaoDados>'+CTeconsReciCTe+'</versaoDados>';
    Texto := Texto +     '</cteCabecMsg>';
    Texto := Texto +   '</soap12:Header>';
    Texto := Texto +   '<soap12:Body>';
    Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao">';
    Texto := Texto + FDadosMsg;
    Texto := Texto +     '</cteDadosMsg>';
    Texto := Texto +   '</soap12:Body>';
    Texto := Texto + '</soap12:Envelope>';

    Acao.Text := Texto;

    {$IFDEF ACBrCTeOpenSSL}
       Acao.SaveToStream(Stream);
       HTTP := THTTPSend.Create;
    {$ELSE}
       ReqResp := THTTPReqResp.Create(nil);
       ConfiguraReqResp( ReqResp );
       ReqResp.URL := Trim(FURL);
       ReqResp.UseUTF8InHeader := True;
       ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao/cteRetRecepcao';
    {$ENDIF}

    try
      TACBrCTe( FACBrCTe ).SetStatus( stCTeRetRecepcao );
      if assigned(FCTeRetorno) then
         FCTeRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

      {$IFDEF ACBrCTeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao/cteRetRecepcao"');
         HTTP.HTTPMethod('POST', FURL);

         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);
         FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
         FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteRetRecepcaoResult');
         StrStream.Free;
      {$ELSE}
         ReqResp.Execute(Acao.Text, Stream);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(Stream, 0);
         FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
         FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteRetRecepcaoResult');
         StrStream.Free;
      {$ENDIF}
      if FConfiguracoes.Geral.Salvar then
         FConfiguracoes.Geral.Save(Recibo+'-pro-rec.xml', FRetWS);

      FCteRetorno := TRetConsReciCTe.Create;
      FCteRetorno.Leitor.Arquivo := FRetWS;
      FCteRetorno.LerXML;

      TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
      aMsg := 'Ambiente : '+TpAmbToStr(FCTeRetorno.TpAmb)+LineBreak+
              'Versão Aplicativo : '+FCTeRetorno.verAplic+LineBreak+
              'Recibo : '+FCTeRetorno.nRec+LineBreak+
              'Status Código : '+IntToStr(FCTeRetorno.cStat)+LineBreak+
              'Status Descrição : '+FCTeRetorno.xMotivo+LineBreak+
              'UF : '+CodigoParaUF(FCTeRetorno.cUF)+LineBreak;
      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
         TACBrCTe( FACBrCTe ).OnGerarLog(aMsg);

      FTpAmb    := FCTeRetorno.TpAmb;
      FverAplic := FCTeRetorno.verAplic;
      FcStat    := FCTeRetorno.cStat;
      FcUF      := FCTeRetorno.cUF;
      FMsg      := FCTeRetorno.xMotivo;
      FxMotivo  := FCTeRetorno.xMotivo;
//      FcMsg     := FCTeRetorno.cMsg;
//      FxMsg     := FCTeRetorno.xMsg;

      Result := FCTeRetorno.CStat = 105; // 105 = Lote em Processamento
      if FCTeRetorno.CStat = 104 then    // 104 = Lote Processado
      begin
         FMsg     := FCTeRetorno.ProtCTe.Items[0].xMotivo;
         FxMotivo := FCTeRetorno.ProtCte.Items[0].xMotivo;
      end;

    finally
      {$IFDEF ACBrCTeOpenSSL}
         HTTP.Free;
      {$ENDIF}
      Acao.Free;
      Stream.Free;
      CTeUtil.ConfAmbiente;
      TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
    end;
 end;

var
  vCont: Integer;
begin
  {Result :=} inherited Executar;
  Result := False;

  TACBrCTe( FACBrCTe ).SetStatus( stCTeRetRecepcao );
  Sleep(TACBrCTe( FACBrCTe ).Configuracoes.WebServices.AguardarConsultaRet);
  vCont := 1000;
  while Processando do
  begin
    if TACBrCTe( FACBrCTe ).Configuracoes.WebServices.IntervaloTentativas > 0 then
       sleep(TACBrCTe( FACBrCTe ).Configuracoes.WebServices.IntervaloTentativas)
    else
       sleep(vCont);

    if vCont > (TACBrCTe( FACBrCTe ).Configuracoes.WebServices.Tentativas * 1000) then
      break;

    vCont := vCont + 1000;
  end;
  TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );

  if FCTeRetorno.CStat = 104 then  // 104 = Lote Processado
   begin
    Result     := Confirma(FCTeRetorno.ProtCTe);
    fChaveCTe  := FCTeRetorno.ProtCTe.Items[0].chCTe;
    fProtocolo := FCTeRetorno.ProtCTe.Items[0].nProt;
    fcStat     := FCTeRetorno.ProtCTe.Items[0].cStat;
   end;
end;

{ TCteRecibo }

constructor TCteRecibo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCteRecibo.destroy;
begin
   if assigned(FCTeRetorno) then
      FCTeRetorno.Free;
  inherited;
end;

function TCteRecibo.Executar: Boolean;
var
 aMsg  : string;
 Texto : String;
 Acao  : TStringList ;
 Stream: TMemoryStream;
 StrStream: TStringStream;
// MotivoAux : String;
 {$IFDEF ACBrCTeOpenSSL}
    HTTP: THTTPSend;
 {$ELSE}
    ReqResp: THTTPReqResp;
 {$ENDIF}
begin
  {Result :=} inherited Executar;

  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+CTeconsReciCTe+'</versaoDados>';
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrCTeOpenSSL}
    Acao.SaveToStream(Stream);
    HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao/cteRetRecepcao';
  {$ENDIF}
 try
   TACBrCTe( FACBrCTe ).SetStatus( stCTeRetRecepcao );
   if assigned(FCTeRetorno) then
      FCTeRetorno.Free;

   if FConfiguracoes.Geral.Salvar then
     FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

   {$IFDEF ACBrCTeOpenSSL}
      HTTP.Document.LoadFromStream(Stream);
      ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao/cteRetRecepcao"');
      HTTP.HTTPMethod('POST', FURL);

      StrStream := TStringStream.Create('');
      StrStream.CopyFrom(HTTP.Document, 0);
      FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
      FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteRetRecepcaoResult');
      StrStream.Free;
   {$ELSE}
      ReqResp.Execute(Acao.Text, Stream);
      StrStream := TStringStream.Create('');
      StrStream.CopyFrom(Stream, 0);
      FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
      FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteRetRecepcaoResult');
      StrStream.Free;
   {$ENDIF}
   FCTeRetorno := TRetConsReciCTe.Create;
   FCTeRetorno.Leitor.Arquivo := FRetWS;
   FCTeRetorno.LerXML;

   TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
   aMsg := 'Ambiente : '+TpAmbToStr(FCTeRetorno.TpAmb)+LineBreak+
           'Versão Aplicativo : '+FCTeRetorno.verAplic+LineBreak+
           'Recibo : '+FCTeRetorno.nRec+LineBreak+
           'Status Código : '+IntToStr(FCTeRetorno.cStat)+LineBreak+
           'Status Descrição : '+FCTeRetorno.xMotivo+LineBreak+
           'UF : '+CodigoParaUF(FCTeRetorno.cUF)+LineBreak;
   if FConfiguracoes.WebServices.Visualizar then
     ShowMessage(aMsg);

//   if FCTeRetorno.ProtCTe.Count > 0 then
//     MotivoAux := FCTeRetorno.ProtCTe.Items[0].xMotivo
//   else
//     MotivoAux := '';

   if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
      TACBrCTe( FACBrCTe ).OnGerarLog(aMsg);

   FTpAmb    := FCTeRetorno.TpAmb;
   FverAplic := FCTeRetorno.verAplic;
   FcStat    := FCTeRetorno.cStat;
   FxMotivo  := FCTeRetorno.xMotivo;
   FcUF      := FCTeRetorno.cUF;
   FMsg      := FCTeRetorno.xMotivo;
//   FxMotivo  := MotivoAux;

//   Result := FCTeRetorno.CStat = 105; // Lote em Processamento
//   FMsg   := MotivoAux;
   Result := FCTeRetorno.CStat = 104;

 finally
   {$IFDEF ACBrCTeOpenSSL}
      HTTP.Free;
   {$ENDIF}
   Acao.Free;
   Stream.Free;
   CTeUtil.ConfAmbiente;
   TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
 end;
end;

{ TCTeConsulta }
function TCTeConsulta.Executar: Boolean;
var
  CTeRetorno: TRetConsSitCTe;
  aMsg : String;
  AProcCTe: TProcCTe;
  i: Integer;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  wAtualiza: boolean;

  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  {Result :=} inherited Executar;

  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteConsulta">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+CTeconsSitCTe+'</versaoDados>';
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteConsulta">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrCTeOpenSSL}
     Acao.SaveToStream(Stream);
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteConsulta/cteConsultaCT';
  {$ENDIF}
  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeConsulta );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FCTeChave+'-ped-sit.xml', FDadosMsg);

    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteConsulta/cteConsultaCT"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
       FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteConsultaCTResult');
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
       FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteConsultaCTResult');
       StrStream.Free;
    {$ENDIF}
    CTeRetorno := TRetConsSitCTe.Create;
    CTeRetorno.Leitor.Arquivo := FRetWS;
    CTeRetorno.LerXML;

    FTpAmb      := CTeRetorno.TpAmb;
    FverAplic   := CTeRetorno.verAplic;
    FcStat      := CTeRetorno.cStat;
    FxMotivo    := CTeRetorno.xMotivo;
    FcUF        := CTeRetorno.cUF;
    FCTeChave   := CTeRetorno.chCTe;
    FprotCTe    := CTeRetorno.protCTe;    //Arrumar
    FretCancCTe := CTeRetorno.retCancCTe; //Arrumar
    FMsg        := CTeRetorno.XMotivo;

    FProtocolo := CTeUtil.SeSenao(CTeUtil.NaoEstaVazio(CTeRetorno.retCancCTe.nProt),CTeRetorno.retCancCTe.nProt,CTeRetorno.protCTe.nProt);
    FDhRecbto  := CTeUtil.SeSenao(CTeRetorno.retCancCTe.dhRecbto <> 0,CTeRetorno.retCancCTe.dhRecbto,CTeRetorno.protCTe.dhRecbto);

    TACBrCTe( FACBrCTe ).SetStatus( stCteIdle );
    aMsg := //'Versão Leiaute : '+CTeRetorno.Versao+LineBreak+
            'Identificador : '+CTeRetorno.protCTe.chCTe+LineBreak+
            'Ambiente : '+TpAmbToStr(CTeRetorno.TpAmb)+LineBreak+
            'Versão Aplicativo : '+CTeRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(CTeRetorno.CStat)+LineBreak+
            'Status Descrição : '+CTeRetorno.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(CTeRetorno.cUF)+LineBreak+
            'Chave Acesso : '+FCTeChave+LineBreak+ // Incluido por Italo em 28/08/2010
//            'Chave Acesso : '+CTeRetorno.chCTe+LineBreak+
            'Recebimento : '+DateTimeToStr(FDhRecbto)+LineBreak+
            'Protocolo : '+FProtocolo+LineBreak+
            'Digest Value : '+CTeRetorno.protCTe.digVal+LineBreak;
    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
       TACBrCTe( FACBrCTe ).OnGerarLog(aMsg);

    Result := (CTeRetorno.CStat in [100,101,110]);
    // 100 = Autorizado o Uso
    // 101 = Cancelamento Homologado
    // 110 = Uso Denegado

    if FConfiguracoes.Geral.Salvar  then
      FConfiguracoes.Geral.Save(FCTeChave+'-sit.xml', FRetWS);

    for i := 0 to TACBrCTe( FACBrCTe ).Conhecimentos.Count-1 do
     begin
        if StringReplace(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.infCTe.ID,'CTe','',[rfIgnoreCase]) = FCTeChave then
         begin
            watualiza := true;
            if ((CTeRetorno.CStat = 101) and // 101 = Cancelamento Homologado
                (FConfiguracoes.Geral.AtualizarXMLCancelado=false)) then
               wAtualiza := False;

            TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].Confirmada := (CTeRetorno.cStat = 100); // 100 = Autorizado o Uso
            if wAtualiza then
            begin
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].Msg                  := CTeRetorno.xMotivo;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.tpAmb    := CTeRetorno.tpAmb;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.verAplic := CTeRetorno.verAplic;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.chCTe    := FCTeChave; // CTeRetorno.chCTe; Alterado por Italo em 28/08/2010
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.dhRecbto := FDhRecbto;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.nProt    := FProtocolo;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.digVal   := CTeRetorno.protCTe.digVal;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.cStat    := CTeRetorno.cStat;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.xMotivo  := CTeRetorno.xMotivo;
            end;

            if ((FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FCTeChave+'-cte.xml') or CTeUtil.NaoEstaVazio(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].NomeArq))
               and wAtualiza) then
            begin
             AProcCTe := TProcCTe.Create;
             if CTeUtil.NaoEstaVazio(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].NomeArq) then
                AProcCTe.PathCTe := TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].NomeArq
             else
                AProcCTe.PathCTe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FCTeChave+'-cte.xml';
             AProcCTe.PathRetConsSitCTe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FCTeChave+'-sit.xml';
             AProcCTe.GerarXML;
             if CTeUtil.NaoEstaVazio(AProcCTe.Gerador.ArquivoFormatoXML) then
                AProcCTe.Gerador.SalvarArquivo(AProcCTe.PathCTe);
             AProcCTe.Free;
            end;

            if FConfiguracoes.Arquivos.Salvar and wAtualiza then
            begin
              if FConfiguracoes.Arquivos.EmissaoPathCTe then
                 TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathCTe(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.Ide.dhEmi))+StringReplace(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.InfCTe.Id,'CTe','',[rfIgnoreCase])+'-cte.xml')
              else
                 TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathCTe)+StringReplace(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.InfCTe.Id,'CTe','',[rfIgnoreCase])+'-cte.xml');
            end;

            break;
         end;
     end;

    //CTeRetorno.Free;

    if (TACBrCTe( FACBrCTe ).Conhecimentos.Count <= 0) then
     begin
       if FConfiguracoes.Geral.Salvar then
        begin
          if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FCTeChave+'-cte.xml') then
           begin
             AProcCTe := TProcCTe.Create;
             AProcCTe.PathCTe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FCTeChave+'-cte.xml';
             AProcCTe.PathRetConsSitCTe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FCTeChave+'-sit.xml';
             AProcCTe.GerarXML;
             if CTeUtil.NaoEstaVazio(AProcCTe.Gerador.ArquivoFormatoXML) then
                AProcCTe.Gerador.SalvarArquivo(AProcCTe.PathCTe);
             AProcCTe.Free;
           end;
        end;
     end;

  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    CTeUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

{ TCTeCancelamento }
function TCTeCancelamento.Executar: Boolean;
var
  CTeRetorno: TRetCancCTe;
  aMsg: string;
  i : Integer;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  wPROC: TStringList;
  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  {Result :=} inherited Executar;

  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteCancelamento">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+CTecancCTe+'</versaoDados>';
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteCancelamento">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrCTeOpenSSL}
     Acao.SaveToStream(Stream);
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteCancelamento/cteCancelamentoCT';
  {$ENDIF}

  CTeRetorno := TRetCancCTe.Create;
  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeCancelamento );

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FCTeChave+'-ped-can.xml', FDadosMsg);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FCTeChave+'-ped-can.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathCan );

    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteCancelamento/cteCancelamentoCT"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
       FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteCancelamentoCTResult');
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
       FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteCancelamentoCTResult');
       StrStream.Free;
    {$ENDIF}

    CTeRetorno.Leitor.Arquivo := FRetWS;
    CTeRetorno.LerXml;

    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
    aMsg := 'Identificador : '+ CTeRetorno.chCTe+LineBreak+
            'Ambiente : '+TpAmbToStr(CTeRetorno.TpAmb)+LineBreak+
            'Versão Aplicativo : '+CTeRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(CTeRetorno.cStat)+LineBreak+
            'Status Descrição : '+CTeRetorno.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(CTeRetorno.cUF)+LineBreak+
            'Chave Acesso : '+CTeRetorno.chCTe+LineBreak+
            'Recebimento : '+CTeUtil.SeSenao(CTeRetorno.DhRecbto = 0, '', DateTimeToStr(CTeRetorno.DhRecbto))+LineBreak+
            'Protocolo : '+CTeRetorno.nProt+LineBreak;

    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
       TACBrCTe( FACBrCTe ).OnGerarLog(aMsg);

    FTpAmb     := CTeRetorno.TpAmb;
    FverAplic  := CTeRetorno.verAplic;
    FcStat     := CTeRetorno.cStat;
    FxMotivo   := CTeRetorno.xMotivo;
    FcUF       := CTeRetorno.cUF;
    FDhRecbto  := CTeRetorno.dhRecbto;
    Fprotocolo := CTeRetorno.nProt;
    FMsg       := CTeRetorno.XMotivo;

    Result := (CTeRetorno.CStat = 101); // 101 = Cancelamento Homologado

    for i := 0 to TACBrCTe( FACBrCTe ).Conhecimentos.Count-1 do
     begin
        if StringReplace(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.infCTe.ID,'CTe','',[rfIgnoreCase]) = CTeRetorno.chCTE then
         begin
           if (FConfiguracoes.Geral.AtualizarXMLCancelado) then
           begin
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].Msg                  := CTeRetorno.xMotivo;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.tpAmb    := CTeRetorno.tpAmb;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.verAplic := CTeRetorno.verAplic;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.chCTe    := CTeRetorno.chCTe;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.dhRecbto := CTeRetorno.dhRecbto;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.nProt    := CTeRetorno.nProt;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.cStat    := CTeRetorno.cStat;
              TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.xMotivo  := CTeRetorno.xMotivo;
           end;

           if FConfiguracoes.Arquivos.Salvar or CTeUtil.NaoEstaVazio(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].NomeArq) then
            begin
              if ((CTeRetorno.CStat = 101) and // 101 = Cancelamento Homologado
                  (FConfiguracoes.Geral.AtualizarXMLCancelado)) then
              begin
                 if CTeUtil.NaoEstaVazio(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].NomeArq) then
                    TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].SaveToFile(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].NomeArq)
                 else
                 begin
                    if FConfiguracoes.Arquivos.EmissaoPathCTe then
                       TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathCTe(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.Ide.dhEmi))+StringReplace(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.InfCTe.Id,'CTe','',[rfIgnoreCase])+'-cte.xml')
                    else
                       TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathCTe)+StringReplace(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.InfCTe.Id,'CTe','',[rfIgnoreCase])+'-cte.xml');
                 end;
              end;
            end;

           break;
         end;
     end;

    //CTeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FCTeChave+'-can.xml', FRetWS);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FCTeChave+'-can.xml', FRetWS, FConfiguracoes.Arquivos.GetPathCan );

    //gerar arquivo proc de cancelamento
    if CTeRetorno.cStat=101 then
    begin
      wProc := TStringList.Create;
      wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');
 {$IFDEF PL_103}
      wProc.Add('<procCancCTe versao="1.03" xmlns="http://www.portalfiscal.inf.br/cte">');
 {$ENDIF}
 {$IFDEF PL_104}
      wProc.Add('<procCancCTe versao="1.04" xmlns="http://www.portalfiscal.inf.br/cte">');
 {$ENDIF}
      wProc.Add(FDadosMSG);
      wProc.Add(FRetWS);
      wProc.Add('</procCancCTe>');
      FXML_ProcCancCTe := wProc.Text;
      wProc.Free;
      if FConfiguracoes.Geral.Salvar then
         FConfiguracoes.Geral.Save(FCTeChave+'-ProcCancCTe.xml', FXML_ProcCancCTe);

      if FConfiguracoes.Arquivos.Salvar then
         FConfiguracoes.Geral.Save(FCTeChave+'-ProcCancCTe.xml', FXML_ProcCancCTe, FConfiguracoes.Arquivos.GetPathCan );
    end;

  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    // Alterado por Italo em 16/03/2011
    // CTeRetorno.Free;
    CTeUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

procedure TCTeCancelamento.SetJustificativa(AValue: WideString);
begin
  if CTeUtil.EstaVazio(AValue) then
   begin
     if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
        TACBrCTe( FACBrCTe ).OnGerarLog('ERRO: Informar uma Justificativa para cancelar o Conhecimento Eletrônico');
     raise Exception.Create('Informar uma Justificativa para cancelar o Conhecimento Eletrônico')
   end
  else
    AValue := CTeUtil.TrataString(AValue);

  if Length(AValue) < 15 then
   begin
     if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
        TACBrCTe( FACBrCTe ).OnGerarLog('ERRO: A Justificativa para Cancelamento do Conhecimento Eletrônico deve ter no minimo 15 caracteres');
     raise Exception.Create('A Justificativa para Cancelamento do Conhecimento Eletrônico deve ter no minimo 15 caracteres')
   end
  else
    FJustificativa := Trim(AValue);
end;

{ TCTeInutilizacao }
function TCTeInutilizacao.Executar: Boolean;
var
  CTeRetorno: TRetInutCTe;
  aMsg  : string;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  wProc  : TStringList ;
  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  {Result :=} inherited Executar;

  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteInutilizacao">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+CTeinutCTe+'</versaoDados>';
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteInutilizacao">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrCTeOpenSSL}
     Acao.SaveToStream(Stream);
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteInutilizacao/cteInutilizacaoCT';
  {$ENDIF}
  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeInutilizacao );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FCTeChave+'-ped-inu.xml', FDadosMsg);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FCTeChave+'-ped-inu.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathInu);

    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteInutilizacao/cteInutilizacaoCT"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
       FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteInutilizacaoCTResult');
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
       FRetWS := CTeUtil.SeparaDados( FRetornoWS,'cteInutilizacaoCTResult');
       StrStream.Free;
    {$ENDIF}

    CTeRetorno := TRetInutCTe.Create;
    CTeRetorno.Leitor.Arquivo := FRetWS;
    CTeRetorno.LerXml;

    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
    aMsg := 'Ambiente : '+TpAmbToStr(CTeRetorno.TpAmb)+LineBreak+
            'Versão Aplicativo : '+CTeRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(CTeRetorno.cStat)+LineBreak+
            'Status Descrição : '+CTeRetorno.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(CTeRetorno.cUF)+LineBreak+
            'Recebimento : '+CTeUtil.SeSenao(CTeRetorno.DhRecbto = 0, '', DateTimeToStr(CTeRetorno.dhRecbto));
    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
       TACBrCTe( FACBrCTe ).OnGerarLog(aMsg);

    FTpAmb     := CTeRetorno.TpAmb;
    FverAplic  := CTeRetorno.verAplic;
    FcStat     := CTeRetorno.cStat;
    FxMotivo   := CTeRetorno.xMotivo;
    FcUF       := CTeRetorno.cUF ;
    FdhRecbto  := CTeRetorno.dhRecbto;
    Fprotocolo := CTeRetorno.nProt;
    FMsg       := CTeRetorno.XMotivo;

    Result := (CTeRetorno.cStat = 102); // 102 = Inutilização
    // Alterado por Italo em 15/03/2011 
    // CTeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FCTeChave+'-inu.xml', FRetWS);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FCTeChave+'-inu.xml', FRetWS, FConfiguracoes.Arquivos.GetPathInu);

    //gerar arquivo proc de inutilizacao
    if CTeRetorno.cStat=102 then
    begin
      wProc := TStringList.Create;
      wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');
 {$IFDEF PL_103}
      wProc.Add('<ProcInutCTe versao="1.03" xmlns="http://www.portalfiscal.inf.br/cte">');
 {$ENDIF}
 {$IFDEF PL_104}
      wProc.Add('<ProcInutCTe versao="1.04" xmlns="http://www.portalfiscal.inf.br/cte">');
 {$ENDIF}
      wProc.Add(FDadosMSG);
      wProc.Add(FRetWS);
      wProc.Add('</ProcInutCTe>');
      FXML_ProcInutCTe := wProc.Text;
      wProc.Free;
      if FConfiguracoes.Geral.Salvar then
         FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FCTeChave+'-ProcInutCTe.xml', FXML_ProcInutCTe);
      if FConfiguracoes.Arquivos.Salvar then
         FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FCTeChave+'-ProcInutCTe.xml', FXML_ProcInutCTe, FConfiguracoes.Arquivos.GetPathInu );
    end;

  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    CTeUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

procedure TCTeInutilizacao.SetJustificativa(AValue: WideString);
begin
  if CTeUtil.EstaVazio(AValue) then
   begin
     if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
        TACBrCTe( FACBrCTe ).OnGerarLog('ERRO: Informar uma Justificativa para Inutilização de numeração do Conhecimento Eletrônico');
     raise Exception.Create('Informar uma Justificativa para Inutilização de numeração do Conhecimento Eletrônico')
   end
  else
    AValue := CTeUtil.TrataString(AValue);

  if Length(Trim(AValue)) < 15 then
   begin
     if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
        TACBrCTe( FACBrCTe ).OnGerarLog('ERRO: A Justificativa para Inutilização de numeração do Conhecimento Eletrônico deve ter no minimo 15 caracteres');
     raise Exception.Create('A Justificativa para Inutilização de numeração do Conhecimento Eletrônico deve ter no minimo 15 caracteres')
   end
  else
    FJustificativa := Trim(AValue);
end;

{ TCTeConsultaCadastro }
destructor TCTeConsultaCadastro.destroy;
begin
  FRetConsCad.Free;

  inherited;
end;

function TCTeConsultaCadastro.Executar: Boolean;
var
  aMsg  : String;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  {Result :=} inherited Executar;

  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
  Texto := Texto +   '<soap:Body>';
  Texto := Texto +     '<consultaCadastro xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro">';
  Texto := Texto +       '<nfeCabecMsg>';
  Texto := Texto + CTeUtil.ParseText(FCabMsg,False);
  Texto := Texto +       '</nfeCabecMsg>';
  Texto := Texto +       '<nfeDadosMsg>';
  Texto := Texto + CTeUtil.ParseText(FDadosMsg,False);
  Texto := Texto +       '</nfeDadosMsg>';
  Texto := Texto +     '</consultaCadastro>';
  Texto := Texto +   '</soap:Body>';
  Texto := Texto + '</soap:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrCTeOpenSSL}
     Acao.SaveToStream(Stream);
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro/consultaCadastro';
  {$ENDIF}
  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeCadastro );
    if assigned(FRetConsCad) then
       FRetConsCad.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ped-cad.xml', FDadosMsg);
    FRetWS := '';
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro/consultaCadastro"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
       FRetWS := CTeUtil.SeparaDados( FRetornoWS,'consultaCadastroResult');
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetornoWS := TiraAcentos(CTeUtil.ParseText(StrStream.DataString, True));
       FRetWS := CTeUtil.SeparaDados( FRetornoWS,'consultaCadastroResult');
       StrStream.Free;
    {$ENDIF}

//    if FRetConsCad = nil then
//       FRetConsCad := TRetConsCad.Create;
    FRetConsCad := TRetConsCad.Create;
    FRetConsCad.Leitor.Arquivo := FRetWS;
    FRetConsCad.LerXml;

    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
    aMsg := 'Versão Aplicativo : '+FRetConsCad.verAplic+LineBreak+
            'Status Código : '+IntToStr(FRetConsCad.cStat)+LineBreak+
            'Status Descrição : '+FRetConsCad.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(FRetConsCad.cUF)+LineBreak+
            'Consulta : '+DateTimeToStr(FRetConsCad.dhCons);
    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
       TACBrCTe( FACBrCTe ).OnGerarLog(aMsg);

    FverAplic := FRetConsCad.verAplic;
    FcStat    := FRetConsCad.cStat;
    FxMotivo  := FRetConsCad.xMotivo;
    FdhCons   := FRetConsCad.dhCons;
    FcUF      := FRetConsCad.cUF ;
    FMsg      := FRetConsCad.XMotivo;

    if FRetConsCad.cStat = 111 then
     begin
       FUF   := FRetConsCad.UF ;
       FIE   := FRetConsCad.IE ;
       FCNPJ := FRetConsCad.CNPJ ;
       FCPF  := FRetConsCad.CPF ;
     end;

   Result := (FRetConsCad.cStat in [111,112]);

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-cad.xml', FRetWS);
  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    CTeUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

procedure TCTeConsultaCadastro.SetCNPJ(const Value: String);
begin
  if CTeUtil.NaoEstaVazio(Value) then
   begin
     FIE  := '';
     FCPF := '';
   end;
  FCNPJ := Value;
end;

procedure TCTeConsultaCadastro.SetCPF(const Value: String);
begin
  if CTeUtil.NaoEstaVazio(Value) then
   begin
     FIE   := '';
     FCNPJ := '';
   end;
  FCPF := Value;
end;

procedure TCTeConsultaCadastro.SetIE(const Value: String);
begin
  if CTeUtil.NaoEstaVazio(Value) then
   begin
     FCNPJ := '';
     FCPF  := '';
   end;
  FIE := Value;
end;

end.
