{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
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
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeWebServices;

interface

uses Classes, SysUtils,
  {$IFDEF CLX} QDialogs,{$ELSE} Dialogs,{$ENDIF}
  {$IFDEF ACBrNFeOpenSSL}
    HTTPSend,
  {$ELSE}
     SoapHTTPClient, SoapHTTPTrans, JwaWinCrypt, JwaWinType, WinInet, ACBrCAPICOM_TLB, ACBrMSXML2_TLB,
  {$ENDIF}
  pcnNFe, pcnNFeW,
  pcnRetConsReciNFe, pcnRetConsCad, pcnAuxiliar, pcnConversao, pcnRetDPEC,
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes ;

type

  TWebServicesBase = Class
  private
    procedure DoNFeStatusServico;
    procedure DoNFeRecepcao;
    procedure DoNFeRetRecepcao;
    procedure DoNFeRecibo;    
    procedure DoNFeConsulta;
    procedure DoNFeCancelamento;
    procedure DoNFeInutilizacao;
    procedure DoNFeConsultaCadastro;
    procedure DoNFeEnvDPEC;
    procedure DoNFeConsultaDPEC;
    {$IFDEF ACBrNFeOpenSSL}
       procedure ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
    {$ELSE}
       procedure ConfiguraRio( Rio : THTTPRIO);
       procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);
    {$ENDIF}
  protected
    FCabMsg: WideString;
    FDadosMsg: AnsiString;
    FRetWS: AnsiString;
    FMsg: AnsiString;
    FURL: WideString;
    FConfiguracoes: TConfiguracoes;
    FACBrNFe : TComponent;
    procedure LoadMsgEntrada;
    procedure LoadURL;
  public
    function Executar: Boolean;virtual;
    constructor Create(AOwner : TComponent); virtual;
    property CabMsg: WideString read FCabMsg;
    property DadosMsg: AnsiString read FDadosMsg;
    property RetWS: AnsiString read FRetWS;
    property Msg: AnsiString read FMsg;
  end;

  TNFeStatusServico = Class(TWebServicesBase)
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

  TNFeRecepcao = Class(TWebServicesBase)
  private
    FLote: String;
    FRecibo : String;
    FNotasFiscais : TNotasFiscais;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    function GetLote: String;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais);reintroduce;
    property Recibo: String read FRecibo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property Lote: String read GetLote write FLote;
  end;

  TNFeRetRecepcao = Class(TWebServicesBase)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveNFe: String; 
    FNotasFiscais: TNotasFiscais;
    FNFeRetorno: TRetConsReciNFe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    function Confirma(AInfProt: TProtNFeCollection): Boolean;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais);reintroduce;
    destructor destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property Recibo: String read FRecibo write FRecibo;
    property Protocolo: String read FProtocolo write FProtocolo;
    property ChaveNFe: String read FChaveNFe write FChaveNFe;
    property NFeRetorno: TRetConsReciNFe read FNFeRetorno write FNFeRetorno;
  end;

  TNFeRecibo = Class(TWebServicesBase)
  private
    FRecibo: String;
    FNFeRetorno: TRetConsReciNFe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent);reintroduce;
    destructor destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property Recibo: String read FRecibo write FRecibo;
    property NFeRetorno: TRetConsReciNFe read FNFeRetorno write FNFeRetorno;
  end;

  TNFeConsulta = Class(TWebServicesBase)
  private
    FNFeChave: WideString;
    FProtocolo: WideString;
    FDhRecbto: TDateTime;
    FXMotivo: WideString;
    FTpAmb : TpcnTipoAmbiente;
    FverAplic : String;
    FcStat : Integer;
    FcUF : Integer;
    FdigVal : String;
  public
    function Executar: Boolean;override;
    property NFeChave: WideString read FNFeChave write FNFeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto write FDhRecbto;
    property XMotivo: WideString read FXMotivo write FXMotivo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property digVal: String read FdigVal;
  end;

  TNFeCancelamento = Class(TWebServicesBase)
  private
    FNFeChave: WideString;
    FProtocolo: WideString;
    FJustificativa: WideString;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FDhRecbto: TDateTime;
    procedure SetJustificativa(AValue: WideString);
  public
    function Executar: Boolean;override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property DhRecbto: TDateTime read FDhRecbto;
    property NFeChave: WideString read FNFeChave write FNFeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
  end;

  TNFeInutilizacao = Class(TWebServicesBase)
  private
    FID: WideString;
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
    procedure SetJustificativa(AValue: WideString);
  public
    function Executar: Boolean;override;
    property ID: WideString read FID write FID;
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
  end;

  TNFeConsultaCadastro = Class(TWebServicesBase)
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

  TNFeEnvDPEC = Class(TWebServicesBase)
  private
    FId: String;
    FverAplic: String;
    FcStat: Integer;
    FTpAmb: TpcnTipoAmbiente;
    FxMotivo: String;
    FdhRegDPEC: TDateTime;
    FnRegDPEC: String;
    FNFeChave: String;
  public
    function Executar: Boolean;override;
    property ID: String read FId;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property xMotivo: String read FxMotivo;
    property DhRegDPEC: TDateTime read FdhRegDPEC;
    property nRegDPEC: String read FnRegDPEC;
    property NFeChave: String read FNFeChave;
  end;

  TNFeConsultaDPEC = Class(TWebServicesBase)
  private
    FverAplic: String;
    FcStat: Integer;
    FTpAmb: TpcnTipoAmbiente;
    FxMotivo: String;
    FretDPEC: TRetDPEC;
    FnRegDPEC: String;
    FNFeChave: String;
    procedure SetNFeChave(const Value: String);
    procedure SetnRegDPEC(const Value: String);
  public
    function Executar: Boolean;override;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property xMotivo: String read FxMotivo;
    property retDPEC: TRetDPEC read FretDPEC;

    property nRegDPEC: String read FnRegDPEC write SetnRegDPEC;
    property NFeChave: String read FNFeChave write SetNFeChave;
  end;

  TWebServices = Class(TWebServicesBase)
  private
    FACBrNFe : TComponent;
    FStatusServico: TNFeStatusServico;
    FEnviar: TNFeRecepcao;
    FRetorno: TNFeRetRecepcao;
    FRecibo: TNFeRecibo;
    FConsulta: TNFeConsulta;
    FCancelamento: TNFeCancelamento;
    FInutilizacao: TNFeInutilizacao;
    FConsultaCadastro: TNFeConsultaCadastro;
    FEnviaDPEC: TNFeEnvDPEC;
    FConsultaDPEC: TNFeConsultaDPEC;
  public
    constructor Create(AFNotaFiscalEletronica: TComponent);reintroduce;
    destructor Destroy; override;
    function Envia(ALote: Integer): Boolean; overload;
    function Envia(ALote: String): Boolean; overload;
    procedure Cancela(AJustificativa: String);
    procedure Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
  published
    property ACBrNFe: TComponent read FACBrNFe write FACBrNFe;
    property StatusServico: TNFeStatusServico read FStatusServico write FStatusServico;
    property Enviar: TNFeRecepcao read FEnviar write FEnviar;
    property Retorno: TNFeRetRecepcao read FRetorno write FRetorno;
    property Recibo: TNFeRecibo read FRecibo write FRecibo;
    property Consulta: TNFeConsulta read FConsulta write FConsulta;
    property Cancelamento: TNFeCancelamento read FCancelamento write FCancelamento;
    property Inutilizacao: TNFeInutilizacao read FInutilizacao write FInutilizacao;
    property ConsultaCadastro: TNFeConsultaCadastro read FConsultaCadastro write FConsultaCadastro;
    property EnviarDPEC: TNFeEnvDPEC read FEnviaDPEC write FEnviaDPEC;
    property ConsultaDPEC: TNFeConsultaDPEC read FConsultaDPEC write FConsultaDPEC;
  end;

implementation

uses {$IFDEF ACBrNFeOpenSSL}
        ssl_openssl,
     {$ELSE}
        ACBrNFeNfeStatusServicoU, ACBrNFeNfeRecepcaoU,
        ACBrNFeNfeRetRecepcaoU, ACBrNFeNfeConsultaU,
        ACBrNFeNfeCancelamentoU, ACBrNFeNfeInutilizacaoU,
        ACBrNFeCadConsultaCadastroU,
     {$ENDIF}
     ACBrUtil, ACBrNFeUtil, ACBrNFe,
     pcnGerador, pcnCabecalho,
     pcnConsStatServ, pcnRetConsStatServ,
     pcnCancNFe, pcnRetCancNFe,
     pcnConsSitNFe, pcnRetConsSitNFe,
     pcnInutNFe, pcnRetInutNFe,
     pcnRetEnvNFe, pcnConsReciNFe ,
     pcnConsCad,
     pcnNFeR, pcnLeitor, pcnProcNFe,
     pcnEnvDPEC, pcnConsDPEC, Math;

{$IFNDEF ACBrNFeOpenSSL}
const
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;
{$ENDIF}

{ TWebServicesBase }
constructor TWebServicesBase.Create(AOwner: TComponent);
begin
  FConfiguracoes := TConfiguracoes( TACBrNFe( AOwner ).Configuracoes );
  FACBrNFe       := TACBrNFe( AOwner );
end;

{$IFDEF ACBrNFeOpenSSL}
procedure TWebServicesBase.ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
begin
  if FileExists(FConfiguracoes.Certificados.Certificado) then
    HTTP.Sock.SSL.PFXfile   := FConfiguracoes.Certificados.Certificado
  else
    HTTP.Sock.SSL.PFX       := FConfiguracoes.Certificados.Certificado;

  HTTP.Sock.SSL.KeyPassword := FConfiguracoes.Certificados.Senha;

  HTTP.ProxyHost  := FConfiguracoes.WebServices.ProxyHost;
  HTTP.ProxyPort  := FConfiguracoes.WebServices.ProxyPort;
  HTTP.ProxyUser  := FConfiguracoes.WebServices.ProxyUser;
  HTTP.ProxyPass  := FConfiguracoes.WebServices.ProxyPass;

//  HTTP.Sock.RaiseExcept := True;

  HTTP.MimeType := 'text/xml; charset=utf-8';
  HTTP.UserAgent := '';
  HTTP.Protocol := '1.1' ;
  HTTP.AddPortNumberToHost := False;
  HTTP.Headers.Add(Action);
end;

{$ELSE}
procedure TWebServicesBase.ConfiguraRio( Rio : THTTPRIO);
begin
  if FConfiguracoes.WebServices.ProxyHost <> '' then
   begin
     Rio.HTTPWebNode.Proxy        := FConfiguracoes.WebServices.ProxyHost+':'+FConfiguracoes.WebServices.ProxyPort;
     Rio.HTTPWebNode.UserName     := FConfiguracoes.WebServices.ProxyUser;
     Rio.HTTPWebNode.Password     := FConfiguracoes.WebServices.ProxyPass;
   end;
  Rio.HTTPWebNode.OnBeforePost := OnBeforePost;
end;

procedure TWebServicesBase.OnBeforePost(const HTTPReqResp: THTTPReqResp;
  Data: Pointer);
var
  Cert         : ICertificate2;
  CertContext  : ICertContext;
  PCertContext : Pointer;
begin
  Cert := FConfiguracoes.Certificados.GetCertificado;
  CertContext :=  Cert as ICertContext;
  CertContext.Get_CertContext(Integer(PCertContext));

  if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT, PCertContext, Sizeof(CERT_CONTEXT)) then
   begin
     if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
        TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: Erro OnBeforePost: ' + IntToStr(GetLastError));
     raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;
end;
{$ENDIF}

procedure TWebServicesBase.DoNFeCancelamento;
var
  Cabecalho : TCabecalho;
  CancNFe: TcancNFe;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFecancNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  CancNFe := TcancNFe.Create;
  CancNFe.schema  := TsPL005c;
  CancNFe.chNFe   := TNFeCancelamento(Self).NFeChave;
  CancNFe.tpAmb   := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  CancNFe.nProt   := TNFeCancelamento(Self).Protocolo;
  CancNFe.xJust   := TNFeCancelamento(Self).Justificativa;
  CancNFe.GerarXML;

{$IFDEF ACBrNFeOpenSSL}
  if not(NotaUtil.Assinar(CancNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
    begin
      if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
         TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: Falha ao assinar Cancelamento Nota Fiscal Eletrônica '+LineBreak+FMsg);
      raise Exception.Create('Falha ao assinar Cancelamento Nota Fiscal Eletrônica '+LineBreak+FMsg);
    end;
{$ELSE}
  if not(NotaUtil.Assinar(CancNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar Cancelamento Nota Fiscal Eletrônica '+LineBreak+FMsg);
       raise Exception.Create('Falha ao assinar Cancelamento de Nota Fiscal Eletrônica '+LineBreak+FMsg);
     end;
{$ENDIF}

  if not(NotaUtil.Valida(FDadosMsg, FMsg, TACBrNFe( FACBrNFe ).Configuracoes.Geral.PathSchemas)) then
  //if not(NotaUtil.Valida(FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha na validação dos dados do cancelamento '+LineBreak+FMsg);
       raise Exception.Create('Falha na validação dos dados do cancelamento '+LineBreak+FMsg);
     end;

  CancNFe.Free;
end;

procedure TWebServicesBase.DoNFeConsulta;
var
  Cabecalho  : TCabecalho;
  ConsSitNFe : TConsSitNFe;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeconsSitNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConsSitNFe    := TConsSitNFe.Create;
  ConsSitNFe.schema := TsPL005c;
  ConsSitNFe.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsSitNFe.chNFe  := TNFeConsulta(Self).NFeChave;
  ConsSitNFe.GerarXML;

  FDadosMsg := ConsSitNFe.Gerador.ArquivoFormatoXML;
  ConsSitNFe.Free;
end;

procedure TWebServicesBase.DoNFeInutilizacao;
var
  Cabecalho: TCabecalho;
  InutNFe: TinutNFe;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeinutNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  InutNFe := TinutNFe.Create;
  InutNFe.schema  := TsPL005c;
  InutNFe.tpAmb   := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  InutNFe.cUF     := FConfiguracoes.WebServices.UFCodigo;
  InutNFe.ano     := TNFeInutilizacao(Self).Ano;
  InutNFe.CNPJ    := TNFeInutilizacao(Self).CNPJ;
  InutNFe.modelo  := TNFeInutilizacao(Self).Modelo;
  InutNFe.serie   := TNFeInutilizacao(Self).Serie;
  InutNFe.nNFIni  := TNFeInutilizacao(Self).NumeroInicial;
  InutNFe.nNFFin  := TNFeInutilizacao(Self).NumeroFinal;
  InutNFe.xJust   := TNFeInutilizacao(Self).Justificativa;
  InutNFe.GerarXML;

{$IFDEF ACBrNFeOpenSSL}
  if not(NotaUtil.Assinar(InutNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
       raise Exception.Create('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
     end;
{$ELSE}
  if not(NotaUtil.Assinar(InutNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
       raise Exception.Create('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
     end;
{$ENDIF}

  TNFeInutilizacao(Self).ID := InutNFe.ID;

  InutNFe.Free
end;

procedure TWebServicesBase.DoNFeConsultaCadastro;
var
  Cabecalho: TCabecalho;
  ConCadNFe: TConsCad;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeconsCad;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConCadNFe := TConsCad.Create;
  ConCadNFe.schema := TsPL005c;
  ConCadNFe.UF     := TNFeConsultaCadastro(Self).UF;
  ConCadNFe.IE     := TNFeConsultaCadastro(Self).IE;
  ConCadNFe.CNPJ   := TNFeConsultaCadastro(Self).CNPJ;
  ConCadNFe.CPF    := TNFeConsultaCadastro(Self).CPF;
  ConCadNFe.GerarXML;

  FDadosMsg := ConCadNFe.Gerador.ArquivoFormatoXML;

  ConCadNFe.Free
end;

procedure TWebServicesBase.DoNFeEnvDPEC;
var
  EnvDPEC: TEnvDPEC;
  i : Integer;
begin
  EnvDPEC := TEnvDPEC.Create;
  EnvDPEC.schema := TsPL005c;

  TACBrNFe( FACBrNFe ).NotasFiscais.GerarNFe; //Gera NFe pra pegar a Chave
  if TACBrNFe( FACBrNFe ).Configuracoes.Geral.Salvar then
     TACBrNFe( FACBrNFe ).NotasFiscais.SaveToFile; // Se tiver configurado pra salvar, salva as NFes

  with EnvDPEC.infDPEC do
   begin
     ID := TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.Emit.CNPJCPF;

     IdeDec.cUF   := TACBrNFe( FACBrNFe ).Configuracoes.WebServices.UFCodigo;
     ideDec.tpAmb := TACBrNFe( FACBrNFe ).Configuracoes.WebServices.Ambiente;
     ideDec.verProc := ACBRNFE_VERSAO;
     ideDec.CNPJ := TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
     ideDec.IE   := TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.Emit.IE;

     for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
      begin
        with resNFe.Add do
         begin
           chNFe   := StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.id,'NFe','',[rfReplaceAll]);
           CNPJCPF := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.dest.CNPJCPF;
           UF      := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.dest.enderdEST.UF;
           vNF     := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Total.ICMSTot.vNF;
           vICMS   := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Total.ICMSTot.vICMS;
           vST     := TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.Total.ICMSTot.vST;
         end;
      end;
   end;
  EnvDPEC.GerarXML;

{$IFDEF ACBrNFeOpenSSL}
  if not(NotaUtil.Assinar(EnvDPEC.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar DPEC '+LineBreak+FMsg);
       raise Exception.Create('Falha ao assinar DPEC '+LineBreak+FMsg);
     end;
{$ELSE}
  if not(NotaUtil.Assinar(EnvDPEC.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar DPEC '+LineBreak+FMsg);
       raise Exception.Create('Falha ao assinar DPEC '+LineBreak+FMsg);
     end;
{$ENDIF}
  EnvDPEC.Free ;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeConsultaDPEC;
var
  ConsDPEC: TConsDPEC;
begin
  ConsDPEC := TConsDPEC.Create;
  ConsDPEC.schema   := TsPL005c;
  ConsDPEC.tpAmb    := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsDPEC.verAplic := NfVersao;
  ConsDPEC.nRegDPEC := TNFeConsultaDPEC(Self).nRegDPEC;
  ConsDPEC.chNFe    := TNFeConsultaDPEC(Self).NFeChave;
  ConsDPEC.GerarXML;

  FDadosMsg := ConsDPEC.Gerador.ArquivoFormatoXML;

  ConsDPEC.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;  
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeRecepcao;
var
  Cabecalho: TCabecalho;
  i: Integer;
  vNotas: WideString;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFenviNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  vNotas := '';
  for i := 0 to TNFeRecepcao(Self).FNotasFiscais.Count-1 do
    vNotas := vNotas + TNFeRecepcao(Self).FNotasFiscais.Items[I].XML;

  FDadosMsg := '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'+
               '<enviNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="'+NFenviNFe+'">'+
               '<idLote>'+TNFeRecepcao(Self).Lote+'</idLote>'+vNotas+'</enviNFe>';

end;

procedure TWebServicesBase.DoNFeRetRecepcao;
var
  Cabecalho: TCabecalho;
  ConsReciNFe: TConsReciNFe;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeconsReciNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConsReciNFe   := TConsReciNFe.Create;
  ConsReciNFe.schema := TsPL005c;
  ConsReciNFe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciNFe.nRec   := TNFeRetRecepcao(Self).Recibo;
  ConsReciNFe.GerarXML;

  FDadosMsg := ConsReciNFe.Gerador.ArquivoFormatoXML;
  ConsReciNFe.Free;
end;

procedure TWebServicesBase.DoNFeRecibo;
var
  Cabecalho: TCabecalho;
  ConsReciNFe: TConsReciNFe;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeconsReciNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConsReciNFe   := TConsReciNFe.Create;
  ConsReciNFe.schema := TsPL005c;
  ConsReciNFe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciNFe.nRec   := TNFeRecibo(Self).Recibo;
  ConsReciNFe.GerarXML;

  FDadosMsg := ConsReciNFe.Gerador.ArquivoFormatoXML;
  ConsReciNFe.Free;
end;

procedure TWebServicesBase.DoNFeStatusServico;
var
  Cabecalho : TCabecalho;
  ConsStatServ: TConsStatServ;
begin
  Cabecalho  := TCabecalho.Create;
  Cabecalho.Versao      := NFecabMsg;
  Cabecalho.VersaoDados := NFeconsStatServ;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConsStatServ := TConsStatServ.create;
  ConsStatServ.schema := TsPL005c;
//  ConsStatServ.Versao := NFeconsStatServ;
  ConsStatServ.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsStatServ.CUF    := FConfiguracoes.WebServices.UFCodigo;
//  ConsStatServ.XServ  := 'STATUS';

  ConsStatServ.GerarXML;

  FDadosMsg := ConsStatServ.Gerador.ArquivoFormatoXML;
  ConsStatServ.Free;

end;

function TWebServicesBase.Executar: Boolean;
begin
  Result := False;
  LoadMsgEntrada;
  LoadURL;
end;

procedure TWebServicesBase.LoadMsgEntrada;
begin
  if self is TNFeStatusServico then
    DoNFeStatusServico
  else if self is TNFeRecepcao then
    DoNFeRecepcao
  else if self is TNFeRetRecepcao then
    DoNFeRetRecepcao
  else if self is TNFeRecibo then
    DoNFeRecibo
  else if self is TNFeConsulta then
    DONFeConsulta
  else if self is TNFeCancelamento then
    DONFeCancelamento
  else if self is TNFeInutilizacao then
    DoNFeInutilizacao
  else if self is TNFeConsultaCadastro then
    DoNFeConsultaCadastro
  else if self is TNFeEnvDPEC then
    DoNFeEnvDPEC
  else if self is TNFeConsultaDPEC then
    DoNFeConsultaDPEC
end;

procedure TWebServicesBase.LoadURL;
begin
  if self is TNFeStatusServico then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeStatusServico)
  else if self is TNFeRecepcao then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeRecepcao)
  else if (self is TNFeRetRecepcao) or (self is TNFeRecibo) then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeRetRecepcao)
  else if self is TNFeConsulta then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeConsulta)
  else if self is TNFeCancelamento then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeCancelamento)
  else if self is TNFeInutilizacao then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeInutilizacao)
  else if self is TNFeConsultaCadastro then
    FURL  := NotaUtil.GetURL(UFparaCodigo(TNFeConsultaCadastro(Self).UF), FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeCadastro)
  else if self is TNFeEnvDPEC then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeEnvDPEC)
  else if self is TNFeConsultaDPEC then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeConsultaDPEC)
end;

{ TWebServices }

procedure TWebServices.Cancela(AJustificativa: String);
begin
  if TACBrNFe( FACBrNFe ).Configuracoes.Geral.FormaEmissao = teNormal then
   begin
     if not(Self.StatusServico.Executar) then
      begin
        if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
           TACBrNFe( FACBrNFe ).OnGerarLog(Self.StatusServico.Msg);
        raise Exception.Create(Self.StatusServico.Msg);
      end;
   end;

  if not(Self.Consulta.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.Consulta.Msg);
       raise Exception.Create(Self.Consulta.Msg);
     end;

  Self.Cancelamento.NFeChave      := Self.Consulta.FNFeChave;
  Self.Cancelamento.Protocolo     := Self.Consulta.FProtocolo;
  Self.Cancelamento.Justificativa := AJustificativa;
  if not(Self.Cancelamento.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.Cancelamento.Msg);
       raise Exception.Create(Self.Cancelamento.Msg);
     end;
end;

procedure TWebServices.Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
begin
  if TACBrNFe( FACBrNFe ).Configuracoes.Geral.FormaEmissao = teNormal then
   begin
     if not(Self.StatusServico.Executar) then
      begin
        if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
           TACBrNFe( FACBrNFe ).OnGerarLog(Self.StatusServico.Msg);
          raise Exception.Create(Self.StatusServico.Msg);
      end;
   end;

  Self.Inutilizacao.CNPJ   := CNPJ;
  Self.Inutilizacao.Modelo := Modelo;
  Self.Inutilizacao.Serie  := Serie;
  Self.Inutilizacao.Ano    := Ano;
  Self.Inutilizacao.NumeroInicial := NumeroInicial;
  Self.Inutilizacao.NumeroFinal   := NumeroFinal;
  Self.Inutilizacao.Justificativa := AJustificativa;

  if not(Self.Inutilizacao.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.Inutilizacao.Msg);
       raise Exception.Create(Self.Inutilizacao.Msg);
     end;
end;

constructor TWebServices.Create(AFNotaFiscalEletronica: TComponent);
begin
 inherited Create( AFNotaFiscalEletronica );
  FACBrNFe          := TACBrNFe(AFNotaFiscalEletronica);
  FStatusServico    := TNFeStatusServico.Create(AFNotaFiscalEletronica);
  FEnviar           := TNFeRecepcao.Create(AFNotaFiscalEletronica, TACBrNFe(AFNotaFiscalEletronica).NotasFiscais);
  FRetorno          := TNFeRetRecepcao.Create(AFNotaFiscalEletronica, TACBrNFe(AFNotaFiscalEletronica).NotasFiscais);
  FRecibo           := TNFeRecibo.Create(AFNotaFiscalEletronica);
  FConsulta         := TNFeConsulta.Create(AFNotaFiscalEletronica);
  FCancelamento     := TNFeCancelamento.Create(AFNotaFiscalEletronica);
  FInutilizacao     := TNFeInutilizacao.Create(AFNotaFiscalEletronica);
  FConsultaCadastro := TNFeConsultaCadastro.Create(AFNotaFiscalEletronica);
  FEnviaDPEC        := TNFeEnvDPEC.Create(AFNotaFiscalEletronica);
  FConsultaDPEC     := TNFeConsultaDPEC.Create(AFNotaFiscalEletronica);
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
  FEnviaDPEC.free;
  FConsultaDPEC.free;
  inherited;
end;

function TWebServices.Envia(ALote: Integer): Boolean;
begin
  Result :=  Envia(IntToStr(ALote));
end;

function TWebServices.Envia(ALote: String): Boolean;
begin
  if not(Self.StatusServico.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.StatusServico.Msg);
       raise Exception.Create(Self.StatusServico.Msg);
     end;

  self.Enviar.FLote := ALote;
  if not(Self.Enviar.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.Enviar.Msg);
       raise Exception.Create(Self.Enviar.Msg);
     end;

  Self.Retorno.Recibo := Self.Enviar.Recibo;
  if not(Self.Retorno.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.Retorno.Msg);
       raise Exception.Create(Self.Retorno.Msg);
     end;
  Result := true;
end;

{ TNFeStatusServico }
function TNFeStatusServico.Executar: Boolean;
var
  NFeRetorno: TRetConsStatServ;
  aMsg: string;
  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: NfeStatusServico;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto +   '<soap:Body>';
     Texto := Texto + '    <nfeStatusServicoNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeStatusServicoNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio( Rio );
  {$ENDIF}

  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeStatusServico );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ped-sta.xml', FDadosMsg);

    try
      {$IFDEF ACBrNFeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico/nfeStatusServicoNF"');
         HTTP.HTTPMethod('POST', FURL);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);

         FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeStatusServicoNFResult');
         StrStream.Free;
      {$ELSE}
         Nota   := GetNfeStatusServico( False, FURL, Rio);
         FRetWS := Nota.nfeStatusServicoNF(FCabMsg, FDadosMsg);
      {$ENDIF}
      NFeRetorno := TRetConsStatServ.Create;
      NFeRetorno.Leitor.Arquivo := FRetWS;
      NFeRetorno.LerXml;

      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
      aMsg := //'Versão Leiaute : '+NFeRetorno.verAplic+LineBreak+
              'Ambiente : '+TpAmbToStr(NFeRetorno.tpAmb)+LineBreak+
              'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
              'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
              'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
              'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
              'Recebimento : '+NotaUtil.SeSenao(NFeRetorno.DhRecbto = 0, '', DateTimeToStr(NFeRetorno.dhRecbto))+LineBreak+
              'Tempo Médio : '+IntToStr(NFeRetorno.TMed)+LineBreak+
              'Retorno : '+ NotaUtil.SeSenao(NFeRetorno.dhRetorno = 0, '', DateTimeToStr(NFeRetorno.dhRetorno))+LineBreak+
              'Observação : '+NFeRetorno.xObs+LineBreak;
      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
         TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

      FtpAmb    := NFeRetorno.tpAmb;
      FverAplic := NFeRetorno.verAplic;
      FcStat    := NFeRetorno.cStat;
      FxMotivo  := NFeRetorno.xMotivo;
      FcUF      := NFeRetorno.cUF;
      FdhRecbto := NFeRetorno.dhRecbto;
      FTMed     := NFeRetorno.TMed;
      FdhRetorno:= NFeRetorno.dhRetorno;
      FxObs     := NFeRetorno.xObs;

      if TACBrNFe( FACBrNFe ).Configuracoes.WebServices.AjustaAguardaConsultaRet then
         TACBrNFe( FACBrNFe ).Configuracoes.WebServices.AguardarConsultaRet := FTMed*1000;

      FMsg   := NFeRetorno.XMotivo+ LineBreak+NFeRetorno.XObs;
      Result := (NFeRetorno.CStat = 107);
      NFeRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-sta.xml', FRetWS);

    except on E: Exception do
      begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('WebService Consulta Status serviço:'+LineBreak+
                                          '- Inativo ou Inoperante tente novamente.'+LineBreak+
                                          '- '+E.Message);
       raise Exception.Create('WebService Consulta Status serviço:'+LineBreak+
                              '- Inativo ou Inoperante tente novamente.'+LineBreak+
                              '- '+E.Message);
      end;
    end;
  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeRecepcao }
constructor TNFeRecepcao.Create(AOwner : TComponent;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

function TNFeRecepcao.Executar: Boolean;
var
  NFeRetorno: TretEnvNFe;
  aMsg: string;
  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: NfeRecepcao;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;
  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeRecepcaoLote xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeRecepcaoLote>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio(Rio);
  {$ENDIF}
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeRecepcao );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(Lote+'-env-lot.xml', FDadosMsg);
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeRecepcaoLoteResult');
       StrStream.Free;
    {$ELSE}
       Nota   := GetNfeRecepcao( False, FURL, Rio);
       FRetWS := Nota.nfeRecepcaoLote(FCabMsg, FDadosMsg);
    {$ENDIF}
    NFeRetorno := TretEnvNFe.Create;
    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    aMsg := //'Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
            'Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
            'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
            'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
            'Recibo : '+NFeRetorno.infRec.nRec+LineBreak+
            'Recebimento : '+NotaUtil.SeSenao(NFeRetorno.InfRec.dhRecbto = 0, '', DateTimeToStr(NFeRetorno.InfRec.dhRecbto))+LineBreak+
            'Tempo Médio : '+IntToStr(NFeRetorno.InfRec.TMed)+LineBreak;
    if FConfiguracoes.WebServices.Visualizar then
       ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FTpAmb    := NFeRetorno.TpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FxMotivo  := NFeRetorno.xMotivo;
    FdhRecbto := NFeRetorno.infRec.dhRecbto;
    FTMed     := NFeRetorno.infRec.tMed;
    FcUF      := NFeRetorno.cUF;

    FMsg    := NFeRetorno.xMotivo;
    FRecibo := NFeRetorno.infRec.nRec;
    Result := (NFeRetorno.CStat = 103);

    NFeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(Lote+'-rec.xml', FRetWS);

  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

function TNFeRecepcao.GetLote: String;
begin
  Result := Trim(FLote);
end;

{ TNFeRetRecepcao }
function TNFeRetRecepcao.Confirma(AInfProt: TProtNFeCollection): Boolean;
var
  i,j : Integer;
  AProcNFe: TProcNFe;
begin
  Result := False;

  //Setando os retornos das notas fiscais;
  for i:= 0 to AInfProt.Count-1 do
  begin
    for j:= 0 to FNotasFiscais.Count-1 do
    begin
      if AInfProt.Items[i].chNFe = StringReplace(FNotasFiscais.Items[j].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase]) then
       begin
         FNotasFiscais.Items[j].Confirmada := (AInfProt.Items[i].cStat = 100);
         FNotasFiscais.Items[j].Msg        := AInfProt.Items[i].xMotivo;
         FNotasFiscais.Items[j].NFe.procNFe.tpAmb    := AInfProt.Items[i].tpAmb;
         FNotasFiscais.Items[j].NFe.procNFe.verAplic := AInfProt.Items[i].verAplic;
         FNotasFiscais.Items[j].NFe.procNFe.chNFe    := AInfProt.Items[i].chNFe;
         FNotasFiscais.Items[j].NFe.procNFe.dhRecbto := AInfProt.Items[i].dhRecbto;
         FNotasFiscais.Items[j].NFe.procNFe.nProt    := AInfProt.Items[i].nProt;
         FNotasFiscais.Items[j].NFe.procNFe.digVal   := AInfProt.Items[i].digVal;
         FNotasFiscais.Items[j].NFe.procNFe.cStat    := AInfProt.Items[i].cStat;
         FNotasFiscais.Items[j].NFe.procNFe.xMotivo  := AInfProt.Items[i].xMotivo;
         if FConfiguracoes.Geral.Salvar or NotaUtil.NaoEstaVazio(FNotasFiscais.Items[j].NomeArq) then
          begin
            if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chNFe+'-nfe.xml') and
               FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeRetorno.nRec+'-pro-rec.xml') then
             begin
               AProcNFe:=TProcNFe.Create;
               AProcNFe.PathNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chNFe+'-nfe.xml';
               AProcNFe.PathRetConsReciNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeRetorno.nRec+'-pro-rec.xml';
               AProcNFe.GerarXML;
               if NotaUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
                begin
                  if NotaUtil.NaoEstaVazio(FNotasFiscais.Items[j].NomeArq) then
                     AProcNFe.Gerador.SalvarArquivo(FNotasFiscais.Items[j].NomeArq)
                  else
                     AProcNFe.Gerador.SalvarArquivo(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chNFe+'-nfe.xml');
                end;
               AProcNFe.Free;
             end;
          end;
         if FConfiguracoes.Arquivos.Salvar then
            if FConfiguracoes.Arquivos.EmissaoPathNFe then
               FNotasFiscais.Items[j].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(FNotasFiscais.Items[j].NFe.Ide.dEmi))+StringReplace(FNotasFiscais.Items[j].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')
            else
               FNotasFiscais.Items[j].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe)+StringReplace(FNotasFiscais.Items[j].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml');
         break;
       end;
    end;
  end;

  //Verificando se existe alguma nota confirmada
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if FNotasFiscais.Items[i].Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe alguma nota nao confirmada
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if not(FNotasFiscais.Items[i].Confirmada) then
    begin
      FMsg   := 'Nota(s) não confirmadas:'+LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para as notas nao confirmadas
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if not(FNotasFiscais.Items[i].Confirmada) then
      FMsg:= FMsg+IntToStr(FNotasFiscais.Items[i].NFe.Ide.nNF)+'->'+FNotasFiscais.Items[i].Msg+LineBreak;
  end;
end;

constructor TNFeRetRecepcao.Create(AOwner : TComponent;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

destructor TNFeRetRecepcao.destroy;
begin
   if assigned(FNFeRetorno) then
      FNFeRetorno.Free;
   inherited;
end;

function TNFeRetRecepcao.Executar: Boolean;
  function Processando: Boolean;
  var
    aMsg: string;
    {$IFDEF ACBrNFeOpenSSL}
       Texto : String;
       Acao  : TStringList ;
       Stream: TMemoryStream;
       StrStream: TStringStream;
       HTTP: THTTPSend;
    {$ELSE}
       Nota: NfeRetRecepcao;
       Rio: THTTPRIO;
    {$ENDIF}
  begin
    {$IFDEF ACBrNFeOpenSSL}
       Acao := TStringList.Create;
       Stream := TMemoryStream.Create;
       Texto := '<?xml version="1.0" encoding="utf-8"?>';
       Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
       Texto := Texto + '  <soap:Body>';
       Texto := Texto + '    <nfeRetRecepcao xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao">';
       Texto := Texto + '      <nfeCabecMsg>';

       Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

       Texto := Texto + '      </nfeCabecMsg>';
       Texto := Texto + '      <nfeDadosMsg>';

       Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

       Texto := Texto + '      </nfeDadosMsg>';
       Texto := Texto + '    </nfeRetRecepcao>';
       Texto := Texto + '  </soap:Body>';
       Texto := Texto + '</soap:Envelope>';

       Acao.Text := Texto;

       Acao.SaveToStream(Stream);

       HTTP := THTTPSend.Create;
    {$ELSE}
       Rio := THTTPRIO.Create(nil);
       ConfiguraRio(Rio);
    {$ENDIF}
    try
      TACBrNFe( FACBrNFe ).SetStatus( stNfeRetRecepcao );
      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

      {$IFDEF ACBrNFeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao/nfeRetRecepcao"');
         HTTP.HTTPMethod('POST', FURL);

         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);

         FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeRetRecepcaoResult');
         StrStream.Free;
      {$ELSE}
         Nota   := GetNfeRetRecepcao( False, FURL, Rio);
         FRetWS := Nota.nfeRetRecepcao(FCabMsg, FDadosMsg);
      {$ENDIF}
      if assigned(FNFeRetorno) then
         FNFeRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
         FConfiguracoes.Geral.Save(Recibo+'-pro-rec.xml', FRetWS);

      FNFeRetorno := TRetConsReciNFe.Create;
      FNFeRetorno.Leitor.Arquivo := FRetWS;
      FNFeRetorno.LerXML;

      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
      aMsg := //'Versão Leiaute : '+FNFeRetorno.Versao+LineBreak+
              'Ambiente : '+TpAmbToStr(FNFeRetorno.TpAmb)+LineBreak+
              'Versão Aplicativo : '+FNFeRetorno.verAplic+LineBreak+
              'Recibo : '+FNFeRetorno.nRec+LineBreak+
              'Status Código : '+IntToStr(FNFeRetorno.cStat)+LineBreak+
              'Status Descrição : '+FNFeRetorno.xMotivo+LineBreak+
              'UF : '+CodigoParaUF(FNFeRetorno.cUF)+LineBreak;
      if FConfiguracoes.WebServices.Visualizar then
         ShowMessage(aMsg);

      if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
         TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

      FTpAmb    := FNFeRetorno.TpAmb;
      FverAplic := FNFeRetorno.verAplic;
      FcStat    := FNFeRetorno.cStat;
      FcUF      := FNFeRetorno.cUF;
      FMsg      := FNFeRetorno.xMotivo;
      FxMotivo  := FNFeRetorno.xMotivo;

      Result := FNFeRetorno.CStat = 105;
      if FNFeRetorno.CStat = 104 then
      begin
         FMsg   := FNFeRetorno.ProtNFe.Items[0].xMotivo;
         FxMotivo  := FNFeRetorno.ProtNFe.Items[0].xMotivo;
      end;

    finally
      {$IFDEF ACBrNFeOpenSSL}
         HTTP.Free;
         Acao.Free;
         Stream.Free;
      {$ELSE}
//         Rio.Free;
      {$ENDIF}
      NotaUtil.ConfAmbiente;
      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    end;
  end;

var
  vCont: Integer;
begin
  Result := inherited Executar;
  Result := False;

  TACBrNFe( FACBrNFe ).SetStatus( stNfeRetRecepcao );
  Sleep(TACBrNFe( FACBrNFe ).Configuracoes.WebServices.AguardarConsultaRet);
  vCont := 1000;
  while Processando do
  begin
    if TACBrNFe( FACBrNFe ).Configuracoes.WebServices.IntervaloTentativas > 0 then
       sleep(TACBrNFe( FACBrNFe ).Configuracoes.WebServices.IntervaloTentativas)
    else
       sleep(vCont);

    if vCont > (TACBrNFe( FACBrNFe ).Configuracoes.WebServices.Tentativas*1000) then
      break;
      
    vCont := vCont +1000;
  end;
  TACBrNFe( FACBrNFe ).SetStatus( stIdle );

  if FNFeRetorno.CStat = 104 then
   begin
    Result := Confirma(FNFeRetorno.ProtNFe);
    fChaveNfe  := FNFeRetorno.ProtNFe.Items[0].chNFe;
    fProtocolo := FNFeRetorno.ProtNFe.Items[0].nProt;
    fcStat     := FNFeRetorno.ProtNFe.Items[0].cStat;
   end;
   
//  FNFeRetorno.Free;
end;

{ TNFeRecibo }
constructor TNFeRecibo.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

destructor TNFeRecibo.destroy;
begin
   if assigned(FNFeRetorno) then
      FNFeRetorno.Free;
  inherited;
end;

function TNFeRecibo.Executar: Boolean;
var
 aMsg: string;
 {$IFDEF ACBrNFeOpenSSL}
    Texto : String;
    Acao  : TStringList ;
    Stream: TMemoryStream;
    StrStream: TStringStream;
    HTTP: THTTPSend;
 {$ELSE}
    Nota: NfeRetRecepcao;
    Rio: THTTPRIO;
 {$ENDIF}
begin
   Result := inherited Executar;

 {$IFDEF ACBrNFeOpenSSL}
    Acao := TStringList.Create;
    Stream := TMemoryStream.Create;
    Texto := '<?xml version="1.0" encoding="utf-8"?>';
    Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
    Texto := Texto + '  <soap:Body>';
    Texto := Texto + '    <nfeRetRecepcao xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao">';
    Texto := Texto + '      <nfeCabecMsg>';

    Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

    Texto := Texto + '      </nfeCabecMsg>';
    Texto := Texto + '      <nfeDadosMsg>';

    Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

    Texto := Texto + '      </nfeDadosMsg>';
    Texto := Texto + '    </nfeRetRecepcao>';
    Texto := Texto + '  </soap:Body>';
    Texto := Texto + '</soap:Envelope>';

    Acao.Text := Texto;

    Acao.SaveToStream(Stream);

    HTTP := THTTPSend.Create;
 {$ELSE}
    Rio := THTTPRIO.Create(nil);
    ConfiguraRio(Rio);
 {$ENDIF}
 try
   TACBrNFe( FACBrNFe ).SetStatus( stNfeRetRecepcao );
   if FConfiguracoes.Geral.Salvar then
     FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

   {$IFDEF ACBrNFeOpenSSL}
      HTTP.Document.LoadFromStream(Stream);
      ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao/nfeRetRecepcao"');
      HTTP.HTTPMethod('POST', FURL);

      StrStream := TStringStream.Create('');
      StrStream.CopyFrom(HTTP.Document, 0);

      FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeRetRecepcaoResult');
      StrStream.Free;
   {$ELSE}
      Nota   := GetNfeRetRecepcao( False, FURL, Rio);
      FRetWS := Nota.nfeRetRecepcao(FCabMsg, FDadosMsg);
   {$ENDIF}
   if assigned(FNFeRetorno) then
      FNFeRetorno.Free;
   FNFeRetorno := TRetConsReciNFe.Create;
   FNFeRetorno.Leitor.Arquivo := FRetWS;
   FNFeRetorno.LerXML;

   TACBrNFe( FACBrNFe ).SetStatus( stIdle );
   aMsg := //'Versão Leiaute : '+FNFeRetorno.Versao+LineBreak+
           'Ambiente : '+TpAmbToStr(FNFeRetorno.TpAmb)+LineBreak+
           'Versão Aplicativo : '+FNFeRetorno.verAplic+LineBreak+
           'Recibo : '+FNFeRetorno.nRec+LineBreak+
           'Status Código : '+IntToStr(FNFeRetorno.cStat)+LineBreak+
           'Status Descrição : '+FNFeRetorno.ProtNFe.Items[0].xMotivo+LineBreak+
           'UF : '+CodigoParaUF(FNFeRetorno.cUF)+LineBreak;
   if FConfiguracoes.WebServices.Visualizar then
     ShowMessage(aMsg);

   if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
      TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

   FTpAmb    := FNFeRetorno.TpAmb;
   FverAplic := FNFeRetorno.verAplic;
   FcStat    := FNFeRetorno.cStat;
   FxMotivo  := FNFeRetorno.xMotivo;
   FcUF      := FNFeRetorno.cUF;

   Result := FNFeRetorno.CStat = 104;
   FMsg   := FNFeRetorno.xMotivo;

 finally
   {$IFDEF ACBrNFeOpenSSL}
      HTTP.Free;
      Acao.Free;
      Stream.Free;
   {$ELSE}
//      Rio.Free;
   {$ENDIF}
   NotaUtil.ConfAmbiente;
   TACBrNFe( FACBrNFe ).SetStatus( stIdle );
 end;
end;

{ TNFeConsulta }
function TNFeConsulta.Executar: Boolean;
var
  NFeRetorno: TRetConsSitNFe;
  aMsg: string;
  AProcNFe: TProcNFe;
  i : Integer;
  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: NfeConsulta;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeConsultaNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsulta">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeConsultaNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio(Rio);
  {$ENDIF}
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNfeConsulta );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-ped-sit.xml', FDadosMsg);

    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsulta/nfeConsultaNF"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);

       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeConsultaNFResult');
       StrStream.Free;
    {$ELSE}
       Nota   := GetNfeConsulta( False, FURL, Rio);
       FRetWS := Nota.nfeConsultaNF(FCabMsg, FDadosMsg);
    {$ENDIF}
    NFeRetorno := TRetConsSitNFe.Create;
    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXML;
    FProtocolo := NFeRetorno.nProt;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    aMsg := //'Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
            'Identificador : '+NFeRetorno.chNFe+LineBreak+
            'Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
            'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(NFeRetorno.CStat)+LineBreak+
            'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
            'Chave Acesso : '+NFeRetorno.ChNFe+LineBreak+
            'Recebimento : '+NotaUtil.SeSenao(NFeRetorno.DhRecbto = 0, '', DateTimeToStr(NFeRetorno.DhRecbto))+LineBreak+
            'Protocolo : '+NFeRetorno.nProt+LineBreak+
            'Digest Value : '+NFeRetorno.digVal+LineBreak;
    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FTpAmb    := NFeRetorno.TpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FcUF      := NFeRetorno.cUF;
    FdigVal   := NFeRetorno.digVal;
    FdhRecbto := NFeRetorno.DhRecbto;
    FxMotivo  := NFeRetorno.xMotivo;

    FMsg   := NFeRetorno.XMotivo;
    Result := (NFeRetorno.CStat in [100,101,110]);

    if FConfiguracoes.Geral.Salvar  then
      FConfiguracoes.Geral.Save(FNFeChave+'-sit.xml', FRetWS);


    for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
     begin
        if StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.ID,'NFe','',[rfIgnoreCase]) = FNFeChave then
         begin
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].Confirmada := (NFeRetorno.cStat = 100);
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].Msg        := NFeRetorno.xMotivo;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.tpAmb    := NFeRetorno.tpAmb;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.verAplic := NFeRetorno.verAplic;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.chNFe    := NFeRetorno.chNFe;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.dhRecbto := NFeRetorno.dhRecbto;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.nProt    := NFeRetorno.nProt;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.digVal   := NFeRetorno.digVal;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.cStat    := NFeRetorno.cStat;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.xMotivo  := NFeRetorno.xMotivo;

          if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-nfe.xml') or NotaUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
           begin
             AProcNFe:=TProcNFe.Create;
             if NotaUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
                AProcNFe.PathNFe:=TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq
             else
                AProcNFe.PathNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-nfe.xml';
             AProcNFe.PathRetConsSitNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-sit.xml';
             AProcNFe.GerarXML;
             if NotaUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
                AProcNFe.Gerador.SalvarArquivo(AProcNFe.PathNFe);
             AProcNFe.Free;
           end;

           if FConfiguracoes.Arquivos.Salvar then
              if FConfiguracoes.Arquivos.EmissaoPathNFe then
                 TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Ide.dEmi))+StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')
              else
                 TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe)+StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml');

           break;
         end;
     end;

    NFeRetorno.Free;

    if (TACBrNFe( FACBrNFe ).NotasFiscais.Count <= 0) then
     begin
       if FConfiguracoes.Geral.Salvar then
        begin
          if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-nfe.xml') then
           begin
             AProcNFe:=TProcNFe.Create;
             AProcNFe.PathNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-nfe.xml';
             AProcNFe.PathRetConsSitNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-sit.xml';
             AProcNFe.GerarXML;
             if NotaUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
                AProcNFe.Gerador.SalvarArquivo(AProcNFe.PathNFe);
             AProcNFe.Free;
           end;
        end;
     end;
  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeCancelamento }
function TNFeCancelamento.Executar: Boolean;
var
  NFeRetorno: TRetCancNFe;
  aMsg: string;
  i : Integer;
  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: NfeCancelamento;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeCancelamentoNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeCancelamentoNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio(Rio);
  {$ENDIF}
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNfeCancelamento );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-ped-can.xml', FDadosMsg);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-ped-can.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathCan );

    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento/nfeCancelamentoNF"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeCancelamentoNFResult');
       StrStream.Free;
    {$ELSE}
       Nota   := GetNfeCancelamento(False, FURL, Rio);
       FRetWS := Nota.nfeCancelamentoNF(FCabMsg, FDadosMsg);
    {$ENDIF}

    NFeRetorno := TRetCancNFe.Create;
    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    aMsg := //'Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
            'Identificador : '+ NFeRetorno.chNFE+LineBreak+
            'Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
            'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
            'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
            'Chave Acesso : '+NFeRetorno.chNFE+LineBreak+
            'Recebimento : '+NotaUtil.SeSenao(NFeRetorno.DhRecbto = 0, '', DateTimeToStr(NFeRetorno.DhRecbto))+LineBreak+
            'Protocolo : '+NFeRetorno.nProt+LineBreak;

    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FTpAmb    := NFeRetorno.TpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FxMotivo  := NFeRetorno.xMotivo;
    FcUF      := NFeRetorno.cUF;
    FDhRecbto := NFeRetorno.dhRecbto;
    Fprotocolo:= NFeRetorno.nProt;

    FMsg   := NFeRetorno.XMotivo;
    Result := (NFeRetorno.CStat = 101);

    for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
     begin
        if StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.ID,'NFe','',[rfIgnoreCase]) = NFeRetorno.chNFE then
         begin
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].Msg        := NFeRetorno.xMotivo;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.tpAmb    := NFeRetorno.tpAmb;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.verAplic := NFeRetorno.verAplic;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.chNFe    := NFeRetorno.chNFe;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.dhRecbto := NFeRetorno.dhRecbto;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.nProt    := NFeRetorno.nProt;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.cStat    := NFeRetorno.cStat;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.xMotivo  := NFeRetorno.xMotivo;

           if FConfiguracoes.Arquivos.Salvar or NotaUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
            begin
              if NotaUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
                 TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq)
              else
                 if FConfiguracoes.Arquivos.EmissaoPathNFe then
                    TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Ide.dEmi))+StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')
                 else
                    TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe)+StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml');
//                 TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe)+StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml');
            end;


           break;
         end;
     end;

    NFeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-can.xml', FRetWS);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-can.xml', FRetWS, FConfiguracoes.Arquivos.GetPathCan );

  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

procedure TNFeCancelamento.SetJustificativa(AValue: WideString);
begin
  if NotaUtil.EstaVazio(AValue) then
   begin
     if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
        TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: Informar uma Justificativa para cancelar a Nota Fiscal Eletronica');
     raise Exception.Create('Informar uma Justificativa para cancelar a Nota Fiscal Eletronica')
   end
  else
    AValue := NotaUtil.TrataString(AValue);

  if Length(AValue) < 15 then
   begin
     if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
        TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: A Justificativa para Cancelamento da Nota Fiscal Eletronica deve ter no minimo 15 caracteres');
     raise Exception.Create('A Justificativa para Cancelamento da Nota Fiscal Eletronica deve ter no minimo 15 caracteres')
   end
  else
    FJustificativa := Trim(AValue);
end;

{ TNFeInutilizacao }
function TNFeInutilizacao.Executar: Boolean;
var
  NFeRetorno: TRetInutNFe;
  aMsg: string;
  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: NfeInutilizacao;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeInutilizacaoNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeInutilizacao">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeInutilizacaoNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio(Rio);
  {$ENDIF}
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNfeInutilizacao );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(StringReplace(FID,'ID','',[rfIgnoreCase])+'-ped-inu.xml', FDadosMsg);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(StringReplace(FID,'ID','',[rfIgnoreCase])+'-ped-inu.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathInu);

    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeInutilizacao/nfeInutilizacaoNF"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeInutilizacaoNFResult');
       StrStream.Free;
    {$ELSE}
       Nota   := GetNfeInutilizacao(False, FURL, Rio);
       FRetWS := Nota.nfeInutilizacaoNF(FCabMsg, FDadosMsg);
    {$ENDIF}

    NFeRetorno := TRetInutNFe.Create;
    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    aMsg := 'Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
            'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
            'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
            'Recebimento : '+NotaUtil.SeSenao(NFeRetorno.DhRecbto = 0, '', DateTimeToStr(NFeRetorno.dhRecbto));
    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FTpAmb    := NFeRetorno.TpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FxMotivo  := NFeRetorno.xMotivo;
    FcUF      := NFeRetorno.cUF ;
    FdhRecbto := NFeRetorno.dhRecbto;
    Fprotocolo:= NFeRetorno.nProt;
    FMsg   := NFeRetorno.XMotivo;
    Result := (NFeRetorno.cStat = 102);
    NFeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(StringReplace(FID,'ID','',[rfIgnoreCase])+'-inu.xml', FRetWS);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(StringReplace(FID,'ID','',[rfIgnoreCase])+'-inu.xml', FRetWS, FConfiguracoes.Arquivos.GetPathInu);

  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

procedure TNFeInutilizacao.SetJustificativa(AValue: WideString);
begin
  if NotaUtil.EstaVazio(AValue) then
   begin
     if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
        TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: Informar uma Justificativa para Inutilização de numeração da Nota Fiscal Eletronica');
     raise Exception.Create('Informar uma Justificativa para Inutilização de numeração da Nota Fiscal Eletronica')
   end
  else
    AValue := NotaUtil.TrataString(AValue);

  if Length(Trim(AValue)) < 15 then
   begin
     if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
        TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: A Justificativa para Inutilização de numeração da Nota Fiscal Eletronica deve ter no minimo 15 caracteres');
     raise Exception.Create('A Justificativa para Inutilização de numeração da Nota Fiscal Eletronica deve ter no minimo 15 caracteres')
   end
  else
    FJustificativa := Trim(AValue);
end;

{ TNFeConsultaCadastro }
function TNFeConsultaCadastro.Executar: Boolean;
var
  aMsg : String;
  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: CadConsultaCadastro;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <consultaCadastro xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </consultaCadastro>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio(Rio);
  {$ENDIF}
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeCadastro );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ped-cad.xml', FDadosMsg);
    FRetWS := '';
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro/consultaCadastro"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'consultaCadastroResult');
       StrStream.Free;
    {$ELSE}
       Nota   := GetCadConsultaCadastro(False, FURL, Rio);
       FRetWS := Nota.consultaCadastro(FCabMsg, FDadosMsg);
    {$ENDIF}

    if assigned(FRetConsCad) then
       FRetConsCad.Free;
    FRetConsCad := TRetConsCad.Create;
    FRetConsCad.Leitor.Arquivo := FRetWS;
    FRetConsCad.LerXml;

    aMsg := 'Versão Aplicativo : '+FRetConsCad.verAplic+LineBreak+
            'Status Código : '+IntToStr(FRetConsCad.cStat)+LineBreak+
            'Status Descrição : '+FRetConsCad.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(FRetConsCad.cUF)+LineBreak+
            'Consulta : '+DateTimeToStr(FRetConsCad.dhCons);

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    if FConfiguracoes.WebServices.Visualizar then
       ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FverAplic := FRetConsCad.verAplic;
    FcStat    := FRetConsCad.cStat;
    FxMotivo  := FRetConsCad.xMotivo;
    FdhCons   := FRetConsCad.dhCons;
    FcUF      := FRetConsCad.cUF ;

    FMsg      := FRetConsCad.XMotivo;

   Result := (FRetConsCad.cStat in [111,112]);
//    FRetConsCad.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-cad.xml', FRetWS);
  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

procedure TNFeConsultaCadastro.SetCNPJ(const Value: String);
begin
  if NotaUtil.NaoEstaVazio(Value) then
   begin
     FIE   := '';
     FCPF  := '';
   end;
  FCNPJ := Value;
end;

procedure TNFeConsultaCadastro.SetCPF(const Value: String);
begin
  if NotaUtil.NaoEstaVazio(Value) then
   begin
     FIE   := '';
     FCNPJ := '';
   end;
  FCPF  := Value;
end;

procedure TNFeConsultaCadastro.SetIE(const Value: String);
begin
  if NotaUtil.NaoEstaVazio(Value) then
   begin
     FCNPJ := '';
     FCPF  := '';
   end;  
  FIE   := Value;
end;

{ TNFeEnvDPEC }
function TNFeEnvDPEC.Executar: Boolean;
var
  RetOriginal:String;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  aMsg : String;
  {$IFDEF ACBrNFeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
  RetDPEC : TRetDPEC;
begin
  Result := inherited Executar;

  Acao := TStringList.Create;
  Stream := TMemoryStream.Create;
  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
  Texto := Texto + '<soap:Header>';
  Texto := Texto + '  <sceCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/SCERecepcaoRFB">';
  Texto := Texto + '    <versaoDados>'+NFeEnvDPEC+'</versaoDados>';
  Texto := Texto + '  </sceCabecMsg>';
  Texto := Texto + '</soap:Header>';
  Texto := Texto + '<soap:Body>';
  Texto := Texto + '  <sceDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/SCERecepcaoRFB">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +   '</sceDadosMsg>';
  Texto := Texto + '</soap:Body>';
  Texto := Texto + '</soap:Envelope>';

  Acao.Text := Texto;

  Acao.SaveToStream(Stream);

  {$IFDEF ACBrNFeOpenSSL}
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ReqResp.OnBeforePost := OnBeforePost;
     ReqResp.URL := FURL;
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/SCERecepcaoRFB/sceRecepcaoDPEC';
  {$ENDIF}

  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeEnvDPEC );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-env-dpec.xml', FDadosMsg);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-env-dpec.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathDPEC);

    FRetWS := '';
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/SCERecepcaoRFB/sceRecepcaoDPEC"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       RetOriginal:=NotaUtil.ParseText(StrStream.DataString, True);
       FRetWS := NotaUtil.SeparaDados(RetOriginal,'sceRecepcaoDPECResult',True);
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'sceRecepcaoDPECResult',True);
       StrStream.Free;
    {$ENDIF}

    RetDPEC := TRetDPEC.Create;
    RetDPEC.Leitor.Arquivo := FRetWS;
    RetDPEC.LerXml;

    aMsg := 'Versão Aplicativo : '+RetDPEC.verAplic+LineBreak+
            'ID : '+RetDPEC.Id+LineBreak+
            'Status Código : '+IntToStr(RetDPEC.cStat)+LineBreak+
            'Status Descrição : '+RetDPEC.xMotivo+LineBreak+
            'Data Registro : '+DateTimeToStr(RetDPEC.dhRegDPEC)+LineBreak+
            'nRegDPEC : '+RetDPEC.nRegDPEC+LineBreak+
            'ChaveNFe : '+RetDPEC.chNFE;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    if FConfiguracoes.WebServices.Visualizar then
       ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FverAplic := RetDPEC.verAplic;
    FcStat    := RetDPEC.cStat;
    FxMotivo  := RetDPEC.xMotivo;
    FId       := RetDPEC.Id;
    FTpAmb    := RetDPEC.tpAmb;
    FdhRegDPEC := RetDPEC.dhRegDPEC;
    FnRegDPEC  := RetDPEC.nRegDPEC;
    FNFeChave  := RetDPEC.chNFE;

    FMsg      := RetDPEC.XMotivo;

    if FMsg = '' then
       FMsg:=RetOriginal;

    Result := (RetDPEC.cStat = 124);
    RetDPEC.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ret-dpec.xml', FRetWS);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ret-dpec.xml', FRetWS, FConfiguracoes.Arquivos.GetPathDPEC);

  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeConsultaDPEC }
function TNFeConsultaDPEC.Executar: Boolean;
var
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  aMsg : String;
  {$IFDEF ACBrNFeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  Result := inherited Executar;

  Acao := TStringList.Create;
  Stream := TMemoryStream.Create;
  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
  Texto := Texto + '  <soap:Header>';
  Texto := Texto + '    <sceCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/SCEConsultaRFB">';
  Texto := Texto + '      <versaoDados>'+NFeConsDPEC+'</versaoDados>';
  Texto := Texto + '    </sceCabecMsg>';
  Texto := Texto + '  </soap:Header>';
  Texto := Texto + '  <soap:Body>';
  Texto := Texto + '    <sceDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/SCEConsultaRFB">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</sceDadosMsg>';
  Texto := Texto + '  </soap:Body>';
  Texto := Texto + '</soap:Envelope>';

  Acao.Text := Texto;

  Acao.SaveToStream(Stream);

  {$IFDEF ACBrNFeOpenSSL}
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ReqResp.OnBeforePost := OnBeforePost;
     ReqResp.URL := FURL;
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/SCEConsultaRFB/sceConsultaDPEC';
  {$ENDIF}

  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeConsultaDPEC );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-cons-dpec.xml', FDadosMsg);
    FRetWS := '';
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/SCEConsultaRFB/sceConsultaDPEC"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'sceConsultaDPECResult',True);
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'sceConsultaDPECResult',True);
       StrStream.Free;
    {$ENDIF}

    if Assigned(FretDPEC) then
       FretDPEC.Free;
    FretDPEC := TRetDPEC.Create;
    FretDPEC.Leitor.Arquivo := FRetWS;
    FretDPEC.LerXml;

    aMsg := 'Versão Aplicativo : '+RetDPEC.verAplic+LineBreak+
            'ID : '+RetDPEC.Id+LineBreak+
            'Status Código : '+IntToStr(RetDPEC.cStat)+LineBreak+
            'Status Descrição : '+RetDPEC.xMotivo+LineBreak+
            'Data Registro : '+DateTimeToStr(RetDPEC.dhRegDPEC)+LineBreak+
            'nRegDPEC : '+RetDPEC.nRegDPEC+LineBreak+
            'ChaveNFe : '+RetDPEC.chNFE;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    if FConfiguracoes.WebServices.Visualizar then
       ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FverAplic := RetDPEC.verAplic;
    FcStat    := RetDPEC.cStat;
    FxMotivo  := RetDPEC.xMotivo;
    FTpAmb    := RetDPEC.tpAmb;
    FnRegDPEC  := RetDPEC.nRegDPEC;
    FNFeChave  := RetDPEC.chNFE;

    FMsg      := RetDPEC.XMotivo;
    Result := (RetDPEC.cStat = 125);

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-sit-dpec.xml', FRetWS);
  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

procedure TNFeConsultaDPEC.SetNFeChave(const Value: String);
begin
  if NotaUtil.NaoEstaVazio(Value) then
     FnRegDPEC := '';
  FNFeChave := StringReplace(Value,'NFe','',[rfReplaceAll]);
end;

procedure TNFeConsultaDPEC.SetnRegDPEC(const Value: String);
begin
  if NotaUtil.NaoEstaVazio(Value) then
     FNFeChave := '';
  FnRegDPEC := Value;
end;

end.
