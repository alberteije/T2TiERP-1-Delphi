{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 21/11/2009: Daniel Simoes de Almeida
|*  - Primeira Versao: Cria�ao e Distribui�ao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrTEFD;

interface

uses
  Classes, SysUtils, ACBrTEFDClass,
  ACBrTEFDDial, ACBrTEFDDisc, ACBrTEFDHiper, ACBrTEFDCliSiTef, ACBrTEFDGpu,
  ACBrTEFDVeSPague, ACBrTEFDBanese
  {, ACBrTEFDGoodCard, ACBrTEFDFoxWin}
  {$IFDEF FPC}
    ,LResources
  {$ENDIF}
  {$IFNDEF CONSOLE}
    {$IFDEF MSWINDOWS}
      ,Windows, Messages
    {$ENDIF}
    {$IFDEF VisualCLX}
      ,QForms, QControls, Qt
    {$ELSE}
      ,Forms, Controls
    {$ENDIF}
 {$ENDIF} ;

type

   { TACBrTEFDClass }

   TACBrTEFD = class( TComponent )
   private
     fAutoAtivarGP : Boolean;
     fAutoFinalizarCupom : Boolean;
     fAutoEfetuarPagamento : Boolean;
     fEsperaSleep : Integer;
     fEstadoReq : TACBrTEFDReqEstado;
     fEstadoResp : TACBrTEFDRespEstado;
     fExibirMsgAutenticacao: Boolean;
     fMultiplosCartoes : Boolean;
     fNumeroMaximoCartoes: Integer;
     fNumVias : Integer;
     fOnAguardaResp : TACBrTEFDAguardaRespEvent;
     fOnAntesCancelarTransacao: TACBrTEFDAntesCancelarTransacao;
     fOnAntesFinalizarRequisicao : TACBrTEFDAntesFinalizarReq;
     fOnBloqueiaMouseTeclado : TACBrTEFDBloqueiaMouseTeclado;
     fOnComandaECF : TACBrTEFDComandaECF;
     fOnComandaECFAbreVinculado : TACBrTEFDComandaECFAbreVinculado;
     fOnComandaECFImprimeVia : TACBrTEFDComandaECFImprimeVia;
     fOnComandaECFPagamento : TACBrTEFDComandaECFPagamento;
     fOnDepoisCancelarTransacoes : TACBrTEFDProcessarTransacoesPendentes ;
     fOnDepoisConfirmarTransacoes : TACBrTEFDProcessarTransacoesPendentes;
     fOnExibeMsg : TACBrTEFDExibeMsg;
     fOnInfoECF : TACBrTEFDObterInfoECF;
     fOnLimpaTeclado : TACBrTEFDExecutaAcao;
     fOnMudaEstadoReq : TACBrTEFDMudaEstadoReq;
     fOnMudaEstadoResp : TACBrTEFDMudaEstadoResp;
     fOnRestauraFocoAplicacao : TACBrTEFDExecutaAcao;
     fPathBackup   : String;
     fGPAtual      : TACBrTEFDTipo;
     fTecladoBloqueado : Boolean;
     fTefClass     : TACBrTEFDClass ;
     fTefDial      : TACBrTEFDDial ;
     fTefGPU       : TACBrTEFDGpu ;
     fTefCliSiTef  : TACBrTEFDCliSiTef;
     fTefVeSPague  : TACBrTEFDVeSPague;
     fTefDisc      : TACBrTEFDDisc ;
     fTefHiper     : TACBrTEFDHiper ;
	 fTefBanese    : TACBrTEFDBanese ;
//   fTefGood      : TACBrTEFDGoodCard ;
//   fTefFW        : TACBrTEFDFoxWin ;
     fEsperaSTS    : Integer;
     fTEFList      : TACBrTEFDClassList ;
     fpRespostasPendentes : TACBrTEFDRespostasPendentes;
     fArqLOG: string;
     function GetAbout : String;
     function GetAguardandoResposta: Boolean;
     function GetArqReq : String;
     function GetArqResp : String;
     function GetArqSTS : String;
     function GetArqTmp : String;
     function GetGPExeName : String;
     function GetPathBackup : String;
     function GetReq : TACBrTEFDReq;
     function GetResp : TACBrTEFDResp;
     procedure SetAutoAtivarGP(const AValue : Boolean);
     procedure SetAutoEfetuarPagamento(const AValue : Boolean);
     procedure SetAutoFinalizarCupom(const AValue : Boolean);
     procedure SetEsperaSleep(const AValue : Integer);
     procedure SetEsperaSTS(const AValue : Integer);
     procedure SetEstadoReq(const AValue : TACBrTEFDReqEstado);
     procedure SetEstadoResp(const AValue : TACBrTEFDRespEstado);
     procedure SetMultiplosCartoes(const AValue : Boolean);
     procedure SetNumeroMaximoCartoes(const AValue: Integer);
     procedure SetNumVias(const AValue : Integer);
     procedure SetPathBackup(const AValue : String);
     procedure SetGPAtual(const AValue : TACBrTEFDTipo);
     procedure SetAbout(const Value: String);{%h-}
     procedure SetArqLOG(const AValue : String);

   public
     Function EstadoECF : AnsiChar ;
     function SubTotalECF: Double;
     function DoExibeMsg( Operacao : TACBrTEFDOperacaoMensagem;
        Mensagem : String ) : TModalResult;
     function ComandarECF(Operacao : TACBrTEFDOperacaoECF) : Integer;
     function ECFPagamento(Indice : String; Valor : Double) : Integer;
     function ECFAbreVinculado(COO, Indice : String; Valor : Double) : Integer;
     function ECFImprimeVia( TipoRelatorio : TACBrTEFDTipoRelatorio;
        Via : Integer; ImagemComprovante : TStringList) : Integer;

     procedure BloquearMouseTeclado(Bloqueia : Boolean);
     procedure LimparTeclado;
     procedure RestaurarFocoAplicacao ;

   public
     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     Procedure Inicializar( GP : TACBrTEFDTipo = gpNenhum ) ;
     Procedure DesInicializar( GP : TACBrTEFDTipo = gpNenhum ) ;
     function Inicializado( GP : TACBrTEFDTipo = gpNenhum ) : Boolean ;

     property GPAtual : TACBrTEFDTipo read fGPAtual write SetGPAtual ;
     property TecladoBloqueado : Boolean read fTecladoBloqueado ;
     property AguardandoResposta : Boolean read GetAguardandoResposta ;

     property TEF  : TACBrTEFDClass read fTefClass ;
     property Req  : TACBrTEFDReq   read GetReq  ;
     property Resp : TACBrTEFDResp  read GetResp ;
     property RespostasPendentes : TACBrTEFDRespostasPendentes
        read fpRespostasPendentes ;

     property ArqTemp  : String read GetArqTmp ;
     property ArqReq   : String read GetArqReq ;
     property ArqSTS   : String read GetArqSTS ;
     property ArqResp  : String read GetArqResp ;
     property GPExeName: String read GetGPExeName ;

     property EstadoReq  : TACBrTEFDReqEstado  read fEstadoReq  write SetEstadoReq ;
     property EstadoResp : TACBrTEFDRespEstado read fEstadoResp write SetEstadoResp ;

     procedure AtivarGP(GP : TACBrTEFDTipo);

     procedure ATV( GP : TACBrTEFDTipo = gpNenhum ) ;
     Function ADM( GP : TACBrTEFDTipo = gpNenhum ) : Boolean ;
     Function CRT( const Valor : Double; const IndiceFPG_ECF : String;
        const DocumentoVinculado : String = ''; const Moeda : Integer = 0 )
        : Boolean ;
     Function CHQ( const Valor : Double; const IndiceFPG_ECF : String;
        const DocumentoVinculado : String = ''; const CMC7 : String = '';
        const TipoPessoa : AnsiChar = 'F'; const DocumentoPessoa : String = '';
        const DataCheque : TDateTime = 0; const Banco   : String = '';
        const Agencia    : String = ''; const AgenciaDC : String = '';
        const Conta      : String = ''; const ContaDC   : String = '';
        const Cheque     : String = ''; const ChequeDC  : String = '';
        const Compensacao: String = '' ) : Boolean ;
     Function CNC(const Rede, NSU : String; const DataHoraTransacao :
        TDateTime; const Valor : Double) : Boolean ;
     procedure CNF(const Rede, NSU, Finalizacao : String;
        const DocumentoVinculado : String = '');
     procedure NCN(const Rede, NSU, Finalizacao : String;
        const Valor : Double = 0; const DocumentoVinculado : String = '');

     procedure FinalizarCupom;
     procedure CancelarTransacoesPendentes;
     procedure ConfirmarTransacoesPendentes;
     procedure ImprimirTransacoesPendentes;

     procedure AgruparRespostasPendentes(
        var Grupo : TACBrTEFDArrayGrupoRespostasPendentes) ;

   published

     property About : String read GetAbout write SetAbout stored False ;
     property MultiplosCartoes : Boolean read fMultiplosCartoes
       write SetMultiplosCartoes default False ;
     property NumeroMaximoCartoes : Integer read fNumeroMaximoCartoes
       write SetNumeroMaximoCartoes default 0;
     property AutoAtivarGP : Boolean read fAutoAtivarGP write fAutoAtivarGP
       default True ;
     property ExibirMsgAutenticacao : Boolean read fExibirMsgAutenticacao
       write fExibirMsgAutenticacao default True ;
     property AutoEfetuarPagamento : Boolean read fAutoEfetuarPagamento
       write SetAutoEfetuarPagamento default False ;
     property AutoFinalizarCupom : Boolean read fAutoFinalizarCupom
       write SetAutoFinalizarCupom default True ;
     property NumVias   : Integer read fNumVias   write SetNumVias
       default CACBrTEFD_NumVias ;
     property EsperaSTS : Integer read fEsperaSTS write SetEsperaSTS
        default CACBrTEFD_EsperaSleep ;
     property EsperaSleep : Integer read fEsperaSleep write SetEsperaSleep
        default CACBrTEFD_EsperaSleep ;
     property PathBackup : String read GetPathBackup write SetPathBackup ;
     property ArqLOG : String read fArqLOG write SetArqLOG ;

     property TEFDial    : TACBrTEFDDial     read fTefDial ;
     property TEFDisc    : TACBrTEFDDisc     read fTefDisc ;
     property TEFHiper   : TACBrTEFDHiper    read fTefHiper ;
     property TEFCliSiTef: TACBrTEFDCliSiTef read fTefCliSiTef ;
     property TEFVeSPague: TACBrTEFDVeSPague read fTefVeSPague ;
     property TEFGPU     : TACBrTEFDGpu      read fTefGPU ;
	 property TEFBanese  : TACBrTEFDBanese   read fTefBanese ;
//   property TEFGood    : TACBrTEFDGoodCard read fTefGood ;
//   property TEFFoxWin  : TACBrTEFDFoxWin   read fTefFW ;

     property OnAguardaResp : TACBrTEFDAguardaRespEvent read fOnAguardaResp
        write fOnAguardaResp ;
     property OnExibeMsg    : TACBrTEFDExibeMsg read fOnExibeMsg
        write fOnExibeMsg ;
     property OnBloqueiaMouseTeclado : TACBrTEFDBloqueiaMouseTeclado
        read fOnBloqueiaMouseTeclado write fOnBloqueiaMouseTeclado ;
     property OnRestauraFocoAplicacao : TACBrTEFDExecutaAcao
        read fOnRestauraFocoAplicacao write fOnRestauraFocoAplicacao ;
     property OnLimpaTeclado : TACBrTEFDExecutaAcao read fOnLimpaTeclado
        write fOnLimpaTeclado ;
     property OnComandaECF  : TACBrTEFDComandaECF read fOnComandaECF
        write fOnComandaECF ;
     property OnComandaECFPagamento  : TACBrTEFDComandaECFPagamento
        read fOnComandaECFPagamento write fOnComandaECFPagamento ;
     property OnComandaECFAbreVinculado : TACBrTEFDComandaECFAbreVinculado
        read fOnComandaECFAbreVinculado write fOnComandaECFAbreVinculado ;
     property OnComandaECFImprimeVia : TACBrTEFDComandaECFImprimeVia
        read fOnComandaECFImprimeVia write fOnComandaECFImprimeVia ;
     property OnInfoECF : TACBrTEFDObterInfoECF read fOnInfoECF write fOnInfoECF ;
     property OnAntesFinalizarRequisicao : TACBrTEFDAntesFinalizarReq
        read fOnAntesFinalizarRequisicao write fOnAntesFinalizarRequisicao ;
     property OnDepoisConfirmarTransacoes : TACBrTEFDProcessarTransacoesPendentes
        read fOnDepoisConfirmarTransacoes write fOnDepoisConfirmarTransacoes ;
     property OnAntesCancelarTransacao : TACBrTEFDAntesCancelarTransacao
        read fOnAntesCancelarTransacao write fOnAntesCancelarTransacao ;
     property OnDepoisCancelarTransacoes : TACBrTEFDProcessarTransacoesPendentes
        read fOnDepoisCancelarTransacoes write fOnDepoisCancelarTransacoes ;
     property OnMudaEstadoReq  : TACBrTEFDMudaEstadoReq read fOnMudaEstadoReq
        write fOnMudaEstadoReq ;
     property OnMudaEstadoResp : TACBrTEFDMudaEstadoResp read fOnMudaEstadoResp
        write fOnMudaEstadoResp ;
   end;

procedure Register;

procedure ApagaEVerifica( const Arquivo : String ) ;

implementation

Uses ACBrUtil, dateutils, TypInfo, StrUtils, Math;

{$IFNDEF FPC}
   {$R ACBrTEFD.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrTEFD]);
end;


procedure ApagaEVerifica( const Arquivo : String ) ;
begin
  if Arquivo = '' then exit ;

  SysUtils.DeleteFile( Arquivo );
  if FileExists( Arquivo ) then
     raise EACBrTEFDArquivo.Create( ACBrStr( 'Erro ao apagar o arquivo:' + sLineBreak + Arquivo ) );
end;

{ TACBrTEFDClass }

constructor TACBrTEFD.Create(AOwner : TComponent);
begin
  inherited Create(AOWner);

  fPathBackup           := '' ;
  fAutoAtivarGP         := True ;
  fAutoEfetuarPagamento := False ;
  fExibirMsgAutenticacao:= True ;
  fAutoFinalizarCupom   := True ;
  fMultiplosCartoes     := False ;
  fNumeroMaximoCartoes  := 0 ;
  fGPAtual              := gpNenhum ;
  fNumVias              := CACBrTEFD_NumVias ;
  fEsperaSTS            := CACBrTEFD_EsperaSTS ;
  fEsperaSleep          := CACBrTEFD_EsperaSleep ;
  fTecladoBloqueado     := False ;
  fArqLOG               := '' ;

  fOnAguardaResp              := nil ;
  fOnAntesFinalizarRequisicao := nil ;
  fOnDepoisConfirmarTransacoes:= nil ;
  fOnDepoisCancelarTransacoes := nil ;
  fOnAguardaResp              := nil ;
  fOnComandaECF               := nil ;
  fOnComandaECFPagamento      := nil ;
  fOnComandaECFAbreVinculado  := nil ;
  fOnComandaECFImprimeVia     := nil ;
  fOnInfoECF                  := nil ;
  fOnExibeMsg                 := nil ;
  fOnMudaEstadoReq            := nil ;
  fOnMudaEstadoResp           := nil ;
  fOnBloqueiaMouseTeclado     := nil ;
  fOnLimpaTeclado             := nil ;
  fOnRestauraFocoAplicacao    := nil ;

  { Lista de Objetos com todas as Classes de TEF }
  fTEFList := TACBrTEFDClassList.create(True);
  { Lista de Objetos TACBrTEFDresp com todas as Respostas Pendentes para Impressao }
  fpRespostasPendentes := TACBrTEFDRespostasPendentes.create(True);

  { Criando Classe TEF_DIAL }
  fTefDial := TACBrTEFDDial.Create(self);
  fTEFList.Add(fTefDial);     // Adicionando "fTefDial" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefDial.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  { Criando Classe TEF_DISC }
  fTefDisc := TACBrTEFDDisc.Create(self);
  fTEFList.Add(fTefDisc);     // Adicionando "fTefDisc" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefDisc.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  { Criando Classe HIPER TEF }
  fTefHiper := TACBrTEFDHiper.Create(self);
  fTEFList.Add(fTefHiper);     // Adicionando "fTefHiper" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefHiper.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  { Criando Classe TEF CliSiTEF }
  fTefCliSiTef := TACBrTEFDCliSiTef.Create(self);
  fTEFList.Add(fTefCliSiTef);     // Adicionando "fTefCliSiTef" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefCliSiTef.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  { Criando Classe TEF VeSPague }
  fTefVeSPague := TACBrTEFDVeSPague.Create(self);
  fTEFList.Add(fTefVeSPague);     // Adicionando "fTefVeSPague" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefVeSPague.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  { Criando Classe TEF_GPU }
  fTefGPU := TACBrTEFDGpu.Create(self);
  fTEFList.Add(fTefGPU);     // Adicionando "fTefGPU" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefGPU.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  { Criando Classe CliBanese }
  fTefBanese := TACBrTEFDBanese.Create(self);
  fTEFList.Add(fTefBanese);     // Adicionando "fTefBanese" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefBanese.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

(*
{ Criando Classe GOOD CARD }
  fTefGood := TACBrTEFDGoodCard.Create(self);
  fTEFList.Add(fTefGood);     // Adicionando "fTefGood" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefGood.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  { Criando Classe Fox Win }
  fTefFW := TACBrTEFDFoxWin.Create(self);
  fTEFList.Add(fTefFW);     // Adicionando "fTefFW" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefFW.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}
*)

  GPAtual := gpTefDial;
end;

destructor TACBrTEFD.Destroy;
begin
  fTEFList.Free;  // Destroi Lista de Classes TEF e Objetos internos
  fpRespostasPendentes.Free ;  // Destroi Lista de Respostas pendentes e Objetos internos

  inherited Destroy;
end;

procedure TACBrTEFD.Inicializar(GP : TACBrTEFDTipo);
Var
  I : Integer;
  Erros : String ;
begin
  if not Assigned( OnExibeMsg ) then
     raise Exception.Create( ACBrStr('Evento "OnExibeMsg" n�o programado' ) ) ;

  if not Assigned( OnComandaECF )  then
     raise Exception.Create( ACBrStr('Evento "OnComandaECF" n�o programado' ) ) ;

  //if not Assigned( OnComandaECFPagamento )  then
  //   raise Exception.Create( ACBrStr('Evento "OnComandaECFPagamento" n�o programado' ) ) ;

  if not Assigned( OnComandaECFAbreVinculado )  then
     raise Exception.Create( ACBrStr('Evento "OnComandaECFAbreVinculado" n�o programado' ) ) ;

  if not Assigned( OnComandaECFImprimeVia )  then
     raise Exception.Create( ACBrStr('Evento "OnComandaECFImprimeVia" n�o programado' ) ) ;

  if not Assigned( OnInfoECF )  then
     raise Exception.Create( ACBrStr('Evento "OnInfoECF" n�o programado' ) ) ;

  if not DirectoryExists( PathBackup ) then
     ForceDirectories( PathBackup );

  if not DirectoryExists( PathBackup ) then
     raise Exception.Create( ACBrStr('Diret�rio de Backup n�o existente:'+sLineBreak+PathBackup) ) ;

  if GP = gpNenhum then
   begin
     Erros := '' ;

     For I := 0 to fTEFList.Count-1 do
     begin
       if fTEFList[I].Habilitado then
       begin
         try
           fTEFList[I].Inicializado := True ;
         except
           On E : Exception do
           begin
             fTEFList[I].Inicializado := False ;
             Erros := Erros + E.Message + sLineBreak ;
           end;
         end;
       end;
     end;

     if Erros <> '' then
        raise Exception.Create( ACBrStr( Erros ) ) ;
   end
  else
   begin
     GPAtual := GP ;
     try
       fTefClass.Inicializado := True;
       fTefClass.Habilitado   := True;
     except
       fTefClass.Inicializado := False;
       raise ;
     end;
   end;
end;

procedure TACBrTEFD.DesInicializar(GP : TACBrTEFDTipo);
var
   I : Integer;
begin
  if GP = gpNenhum then
   begin
     For I := 0 to fTEFList.Count-1 do
     begin
       if fTEFList[I].Habilitado then
          fTEFList[I].Inicializado := False ;
     end;
   end
  else
   begin
     GPAtual := GP ;
     fTefClass.Inicializado := False;
   end;
end;

procedure TACBrTEFD.SetGPAtual(const AValue : TACBrTEFDTipo);
begin
  if AValue = fGPAtual then exit ;

  case AValue of
    gpTefDial  : fTefClass := fTefDial ;
    gpTefDisc  : fTefClass := fTefDisc ;
    gpHiperTef : fTefClass := fTefHiper ;
    gpCliSiTef : fTefClass := fTefCliSiTef;
    gpVeSPague : fTefClass := fTefVeSPague;
    gpTefGpu   : fTefClass := fTefGPU;
	gpBanese   : fTefClass := fTefBanese ;
//  gpGoodCard : fTefClass := fTefGood ;
//  gpFoxWin   : fTefClass := fTefFW ;
  end;

  fGPAtual := AValue;
end;

function TACBrTEFD.EstadoECF : AnsiChar;
Var
  Retorno : String ;
begin
  Retorno := ' ' ;
  try
     OnInfoEcf( ineEstadoECF, Retorno ) ;
  except
     On E : Exception do
        raise EACBrTEFDECF.Create(E.Message);
  end;
  Result := upcase( padL(Retorno,1)[1] );

  if not (Result in ['L','V','P','C','G','R','N','O']) then
     raise EACBrTEFDECF.Create(
        ACBrStr( 'Retorno de "OnInfoEcf( ineEstadoECF, Retorno )" deve ser:'+sLineBreak+
                 '"L" = Livre'+sLineBreak+
                 '"V" = Venda de Itens'+sLineBreak+
                 '"P" - Pagamento (ou SubTotal efetuado)'+sLineBreak+
                 '"C" ou "R" - CDC ou Cupom Vinculado'+sLineBreak+
                 '"G" ou "R" - Relat�rio Gerencial'+sLineBreak+
                 '"N" - Recebimento N�o Fiscal'+sLineBreak+
                 '"O" - Outro' ) );
end;

function TACBrTEFD.SubTotalECF : Double;
var
   SaldoAPagar : Double ;
   SubTotal    : String ;
begin
   try
      SubTotal := '' ;
      OnInfoECF( ineSubTotal, SubTotal ) ;
   except
      on E : Exception do
         raise EACBrTEFDECF.Create(E.Message);
   end;

   SaldoAPagar := StringToFloatDef( SubTotal, -98787158);
   SaldoAPagar := SimpleRoundTo( SaldoAPagar, -2);     // por Rodrigo Baltazar

   if SaldoAPagar = -98787158 then
      raise Exception.Create( ACBrStr( 'Erro na convers�o do Valor Retornado '+
                                       'em: OnInfoECF( ineSubTotal, SaldoAPagar )' ) );
   Result := SaldoAPagar;
end;

procedure TACBrTEFD.AtivarGP(GP : TACBrTEFDTipo);
Var
  I : Integer;
begin
  if GP = gpNenhum then
   begin
     For I := 0 to fTEFList.Count-1 do
     begin
       if fTEFList[I].Habilitado then
          fTEFList[I].AtivarGP;
     end;
   end
  else
   begin
     GPAtual := GP ;
     fTefClass.AtivarGP;
   end;
end;

procedure TACBrTEFD.ATV( GP : TACBrTEFDTipo = gpNenhum );
begin
  if GP <> gpNenhum then
     GPAtual := GP ;

  fTefClass.ATV;
end;

Function TACBrTEFD.ADM( GP : TACBrTEFDTipo = gpNenhum ) : Boolean ;
begin
  if GP <> gpNenhum then
     GPAtual := GP ;

  Result := fTefClass.ADM;
end;

Function TACBrTEFD.CRT(const Valor : Double; const IndiceFPG_ECF : String;
   const DocumentoVinculado : String; const Moeda : Integer) : Boolean ;
begin
   Result := fTefClass.CRT( Valor, IndiceFPG_ECF, DocumentoVinculado, Moeda );
end;

Function TACBrTEFD.CHQ( const Valor : Double; const IndiceFPG_ECF : String;
        const DocumentoVinculado : String = ''; const CMC7 : String = '';
        const TipoPessoa : AnsiChar = 'F'; const DocumentoPessoa : String = '';
        const DataCheque : TDateTime = 0; const Banco   : String = '';
        const Agencia    : String = ''; const AgenciaDC : String = '';
        const Conta      : String = ''; const ContaDC   : String = '';
        const Cheque     : String = ''; const ChequeDC  : String = '';
        const Compensacao: String = '' ) : Boolean ;
begin
   Result := fTefClass.CHQ( Valor, IndiceFPG_ECF, DocumentoVinculado, CMC7,
                            TipoPessoa,  DocumentoPessoa, DataCheque,
                            Banco, Agencia, AgenciaDC,
                            Conta, ContaDC, Cheque, ChequeDC, Compensacao);
end;

Function TACBrTEFD.CNC(const Rede, NSU : String;
   const DataHoraTransacao : TDateTime; const Valor : Double) : Boolean;
begin
  Result := fTefClass.CNC( Rede, NSU, DataHoraTransacao, Valor);
end;

procedure TACBrTEFD.CNF(const Rede, NSU, Finalizacao : String;
  const DocumentoVinculado : String = '');
begin
  fTefClass.CNF( Rede, NSU, Finalizacao, DocumentoVinculado);
end;

procedure TACBrTEFD.NCN(const Rede, NSU, Finalizacao : String;
  const Valor : Double = 0; const DocumentoVinculado : String = '');
begin
  fTefClass.NCN( Rede, NSU, Finalizacao, Valor, DocumentoVinculado);
end;

procedure TACBrTEFD.CancelarTransacoesPendentes;
Var
  I : Integer;
begin
  { Ajustando o mesmo valor nas Classes de TEF, caso elas usem o valor default }
  try
     For I := 0 to fTEFList.Count-1 do
     begin
       if fTEFList[I].Habilitado then
          fTEFList[I].CancelarTransacoesPendentesClass;
     end;
  finally
     try
        if Assigned( fOnDepoisCancelarTransacoes ) then
           fOnDepoisCancelarTransacoes( RespostasPendentes );
     finally
        RespostasPendentes.Clear;
     end;
  end;
end;

procedure TACBrTEFD.ConfirmarTransacoesPendentes;
var
   I : Integer;
begin
  fTefClass.GravaLog( 'ConfirmarTransacoesPendentes' ) ;

  I := 0 ;
  while I < RespostasPendentes.Count do
  begin
    try
      with RespostasPendentes[I] do
      begin
        GPAtual := TipoGP;   // Seleciona a Classe do GP

        if not CNFEnviado then
        begin
          CNF( Rede, NSU, Finalizacao, DocumentoVinculado );
          CNFEnviado := True ;
        end;

        ApagaEVerifica( ArqResp );
        ApagaEVerifica( RespostasPendentes[I].ArqBackup );

        Inc( I ) ;
      end;
    except
      { Exce��o Muda... Fica em Loop at� conseguir confirmar e apagar Backup }
    end;
  end ;

  try
     if Assigned( fOnDepoisConfirmarTransacoes ) then
        fOnDepoisConfirmarTransacoes( RespostasPendentes );
  finally
     RespostasPendentes.Clear;
  end;
end;

procedure TACBrTEFD.ImprimirTransacoesPendentes;
var
   I, J, K, NVias, Ordem : Integer;
   GrupoVinc : TACBrTEFDArrayGrupoRespostasPendentes ;
   ImpressaoOk, Gerencial, RemoverMsg, GerencialAberto : Boolean ;
   TempoInicio : Double;
   Est : AnsiChar ;
   MsgAutenticacaoAExibir : String ;
begin
  if RespostasPendentes.Count <= 0 then
     exit ;

  fTefClass.GravaLog( 'ImprimirTransacoesPendentes' ) ;

  Est := EstadoECF;

  if Est <> 'L' then
  begin
     case Est of
       'V', 'P', 'N' : FinalizarCupom;
       'R', 'G'      : ComandarECF( opeFechaGerencial );
       'C'           : ComandarECF( opeFechaVinculado );
     end;

     if EstadoECF <> 'L' then
        raise EACBrTEFDECF.Create( ACBrStr('ECF n�o est� LIVRE') ) ;
  end;

  ImpressaoOk := False ;
  Gerencial   := False ;
  RemoverMsg  := False ;
  MsgAutenticacaoAExibir := '' ;

  GrupoVinc := nil ;
  AgruparRespostasPendentes( GrupoVinc );

  try
     BloquearMouseTeclado( True );

     while not ImpressaoOk do
     begin
        try
           try
              if Gerencial then    //// Impress�o em Gerencial ////
               begin
                 Est := EstadoECF;

                 if Est <> 'L' then
                 begin
                    { Fecha Vinculado ou Gerencial, se ficou algum aberto por Desligamento }
                    case Est of
                      'C'      : ComandarECF( opeFechaVinculado );
                      'G', 'R' : ComandarECF( opeFechaGerencial );
                    end;

                    if EstadoECF <> 'L' then
                       raise EACBrTEFDECF.Create( ACBrStr('ECF n�o est� LIVRE') ) ;
                 end;

                 GerencialAberto := False ;

                 For J := 0 to RespostasPendentes.Count-1 do
                 begin
                    with RespostasPendentes[J] do
                    begin
                       GPAtual := TipoGP;  // Seleciona a Classe do GP

                       TempoInicio := now ;

                       // Calcula numero de vias //
                       NVias := fTefClass.NumVias ;
                       if ImagemComprovante2aVia.Text = '' then   // Tem 2a via ?
                          NVias := 1 ;
                       if ImagemComprovante1aVia.Text = '' then   // Tem alguma via ?
                          NVias := 0 ;

                       if NVias > 0 then   // Com Impressao, deixe a MSG na Tela
                        begin
                          if TextoEspecialOperador <> '' then
                          begin
                             RemoverMsg := True ;
                             DoExibeMsg( opmExibirMsgOperador, TextoEspecialOperador ) ;
                          end;

                          if TextoEspecialCliente <> '' then
                          begin
                             RemoverMsg := True ;
                             DoExibeMsg( opmExibirMsgCliente, TextoEspecialCliente ) ;
                          end;
                        end
                       else  // Sem Impressao, Exiba a Msg com OK
                        begin
                          if (TextoEspecialOperador + TextoEspecialCliente) <> '' then
                          begin
                            DoExibeMsg( opmOK,
                                        TextoEspecialOperador +
                                        ifthen( TextoEspecialOperador <> '',
                                                sLineBreak+sLineBreak, '') +
                                        TextoEspecialCliente ) ;
                          end ;
                        end ;

                       if (not GerencialAberto) and (NVias > 0) then
                       begin
                          ComandarECF( opeAbreGerencial ) ;
                          GerencialAberto := True ;
                       end;

                       I := 1 ;
                       while I <= NVias do
                       begin
                          if I = 1 then
                             ECFImprimeVia( trGerencial, I, ImagemComprovante1aVia  )
                          else
                             ECFImprimeVia( trGerencial, I, ImagemComprovante2aVia  ) ;

                          if (I < NVias) or (J < RespostasPendentes.Count-1) then
                          begin
                             ComandarECF( opePulaLinhas ) ;
                             DoExibeMsg( opmDestaqueVia, 'Destaque a '+IntToStr(I)+'� Via') ;
                          end;

                          Inc( I ) ;
                       end;

                       { Removendo a mensagem do Operador }
                       if RemoverMsg then
                       begin
                          { Verifica se Mensagem Ficou pelo menos por 5 segundos }
                          while SecondsBetween(now,TempoInicio) < 5 do
                          begin
                             Sleep(EsperaSTS) ;
                             Application.ProcessMessages;
                          end;

                          DoExibeMsg( opmRemoverMsgOperador, '' ) ;
                          DoExibeMsg( opmRemoverMsgCliente, '' ) ;
                          RemoverMsg := False ;
                       end;

                       if ExibirMsgAutenticacao and (Autenticacao <> '') then
                          MsgAutenticacaoAExibir := 'Favor anotar no verso do Cheque:'+sLineBreak+
                                                    Autenticacao ;

                       if (J < RespostasPendentes.Count-1) and // Nao � o ultimo ? (se for a �ltima � preferivel fechar o comprovante antes)
                          (MsgAutenticacaoAExibir <> '') then  // Tem autentica��o ?
                       begin
                          DoExibeMsg( opmOK, MsgAutenticacaoAExibir ) ;
                          MsgAutenticacaoAExibir := '' ;
                       end;
                    end;
                 end ;

                 if GerencialAberto then
                    ComandarECF( opeFechaGerencial );
               end
              else                 //// Impress�o em Vinculado ////
               begin
                 Ordem := -1 ;

                 For K := 0 to Length( GrupoVinc )-1 do
                 begin
                    For J := 0 to RespostasPendentes.Count-1 do
                    begin
                       with RespostasPendentes[J] do
                       begin
                          if GrupoVinc[K].OrdemPagamento <> OrdemPagamento then
                             continue ;

                          GPAtual := TipoGP;    // Seleciona a Classe do GP

                          TempoInicio := now ;

                          // Calcula numero de vias //
                          NVias := fTefClass.NumVias ;
                          if ImagemComprovante2aVia.Text = '' then   // Tem 2a via ?
                             NVias := 1 ;
                          if ImagemComprovante1aVia.Text = '' then   // Tem alguma via ?
                             NVias := 0 ;

                          if NVias > 0 then   // Com Impressao, deixe a MSG na Tela
                           begin
                             if TextoEspecialOperador <> '' then
                             begin
                                RemoverMsg := True ;
                                DoExibeMsg( opmExibirMsgOperador, TextoEspecialOperador ) ;
                             end;

                             if TextoEspecialCliente <> '' then
                             begin
                                RemoverMsg := True ;
                                DoExibeMsg( opmExibirMsgCliente, TextoEspecialCliente ) ;
                             end;
                           end
                          else  // Sem Impressao, Exiba a Msg com OK
                           begin
                             if (TextoEspecialOperador + TextoEspecialCliente) <> '' then
                             begin
                               DoExibeMsg( opmOK,
                                           TextoEspecialOperador +
                                           ifthen( TextoEspecialOperador <> '',
                                                   sLineBreak+sLineBreak, '') +
                                           TextoEspecialCliente ) ;
                             end ;
                           end ;

                          if (NVias > 0) and (Ordem <> OrdemPagamento) then
                          begin
                             Ordem := OrdemPagamento ;
                             ECFAbreVinculado( DocumentoVinculado,
                                               GrupoVinc[K].IndiceFPG_ECF,
                                               GrupoVinc[K].Total ) ;
                          end ;

                          I := 1 ;
                          while I <= NVias do
                          begin
                             if I = 1 then
                                ECFImprimeVia( trVinculado, I, ImagemComprovante1aVia )
                             else
                                ECFImprimeVia( trVinculado, I, ImagemComprovante2aVia ) ;

                             if (I < NVias) or (J < RespostasPendentes.Count-1) then
                             begin
                                ComandarECF( opePulaLinhas ) ;
                                DoExibeMsg( opmDestaqueVia, 'Destaque a '+IntToStr(I)+'� Via') ;
                             end;

                             Inc( I ) ;
                          end;

                          { Removendo a mensagem do Operador }
                          if RemoverMsg then
                          begin
                             { Verifica se Mensagem Ficou pelo menos por 5 segundos }
                             while SecondsBetween(now,TempoInicio) < 5 do
                             begin
                                Sleep(EsperaSTS) ;
                                Application.ProcessMessages;
                             end;

                             DoExibeMsg( opmRemoverMsgOperador, '' ) ;
                             DoExibeMsg( opmRemoverMsgCliente, '' ) ;
                             RemoverMsg := False ;
                          end;

                          if ExibirMsgAutenticacao and (Autenticacao <> '') then
                             MsgAutenticacaoAExibir := 'Favor anotar no verso do Cheque:'+sLineBreak+
                                                       Autenticacao ;

                          if (J < RespostasPendentes.Count-1) and // Nao � o ultimo ? (se for a �ltima � preferivel fechar o comprovante antes)
                             (MsgAutenticacaoAExibir <> '') then  // Tem autentica��o ?
                          begin
                             DoExibeMsg( opmOK, MsgAutenticacaoAExibir ) ;
                             MsgAutenticacaoAExibir := '' ;
                          end;
                       end;
                    end ;

                    if Ordem > -1 then
                       ComandarECF( opeFechaVinculado ) ;
                 end;
               end;

              ImpressaoOk := True ;
           finally
              { Removendo a mensagem do Operador }
              if RemoverMsg then
              begin
                 DoExibeMsg( opmRemoverMsgOperador, '' ) ;
                 DoExibeMsg( opmRemoverMsgCliente, '' ) ;
              end;
           end;
        except
           on EACBrTEFDECF do ImpressaoOk := False ;
           else
              raise ;
        end;

        if not ImpressaoOk then
        begin
          if DoExibeMsg( opmYesNo, 'Impressora n�o responde'+sLineBreak+
                                   'Tentar novamente ?') <> mrYes then
             break ;
        end;

        Gerencial := True ;
     end;
  finally
     if not ImpressaoOk then
      begin
        try ComandarECF( opeCancelaCupom ); except {Exce��o Muda} end ;
        CancelarTransacoesPendentes;
      end
     else
        ConfirmarTransacoesPendentes ;

     BloquearMouseTeclado( False );

     if (MsgAutenticacaoAExibir <> '') then  // Tem autentica��o ?
        DoExibeMsg( opmOK, MsgAutenticacaoAExibir ) ;
  end;

  RespostasPendentes.Clear;
end;

Function TACBrTEFD.DoExibeMsg( Operacao : TACBrTEFDOperacaoMensagem;
   Mensagem : String) : TModalResult ;
var
   OldTecladoBloqueado : Boolean;
begin
  fTefClass.GravaLog( fTefClass.Name +' DoExibeMsg: Oper: '+
    GetEnumName(TypeInfo(TACBrTEFDOperacaoMensagem), Integer(Operacao) )+
    ' Mensagem: '+Mensagem ) ;

  if (Operacao in [opmOK, opmYesNo, opmDestaqueVia]) then
     RestaurarFocoAplicacao ;

  OldTecladoBloqueado := TecladoBloqueado;

  if OldTecladoBloqueado and ( Operacao in [opmOK, opmYesNo] ) then
     BloquearMouseTeclado( False ) ;

  Result := mrNone ;
  OnExibeMsg( Operacao, ACBrStr( Mensagem ), Result );

  if OldTecladoBloqueado and ( Operacao in [opmOK, opmYesNo] ) then
     BloquearMouseTeclado( True ) ;
end;

Function TACBrTEFD.ComandarECF( Operacao : TACBrTEFDOperacaoECF ) : Integer ;
var
   OpName, Erro : String;
begin
  fTefClass.GravaLog( fTefClass.Name +' ComandarECF: Oper: '+
    GetEnumName( TypeInfo(TACBrTEFDOperacaoECF), Integer(Operacao) ) ) ;

  Result := -1 ;  // -1 = N�o tratado
  OnComandaECF( Operacao, fTefClass.Resp, Result ) ;

  if Result < 1 then
  begin
     OpName := GetEnumName( TypeInfo(TACBrTEFDOperacaoECF), Integer(Operacao) ) ;

     if Result = 0 then
        Erro := 'Erro ao executar Opera��o: ['+OpName+']'
     else
        Erro := 'Opera��o ['+OpName+'] n�o tratada em "OnComandaECF"' ;

     fTefClass.GravaLog(Erro);

     raise EACBrTEFDECF.Create( ACBrStr( Erro ) )
  end;
end;

Function TACBrTEFD.ECFPagamento( Indice: String; Valor: Double ) : Integer ;
Var
   Erro : String ;
begin
  fTefClass.GravaLog( fTefClass.Name +' ECFPagamento: Indice: '+
    Indice + ' Valor: '+FormatFloat('0.00',Valor) ) ;

  Result := -1 ;  // -1 = N�o tratado
  OnComandaECFPagamento( Indice, Valor, Result ) ;

  if Result < 1 then
  begin
     if Result = 0 then
        Erro := 'Erro ao executar "OnComandaECFPagamento"'
     else
        Erro := '"OnComandaECFPagamento" n�o tratada' ;

     fTefClass.GravaLog(Erro);

     raise EACBrTEFDECF.Create( ACBrStr( Erro ) )
  end;
end;

function TACBrTEFD.ECFAbreVinculado(COO, Indice : String; Valor : Double
   ) : Integer;
Var
   Erro : String ;
begin
  fTefClass.GravaLog( fTefClass.Name +' ECFAbreVinculado: COO: '+COO+' Indice: '+
    Indice + ' Valor: '+FormatFloat('0.00',Valor) ) ;

  Result := -1 ;  // -1 = N�o tratado
  OnComandaECFAbreVinculado( COO, Indice, Valor, Result ) ;

  if Result < 1 then
  begin
     if Result = 0 then
        Erro := 'Erro ao executar "OnComandaECFAbreVinculado"'
     else
        Erro := '"OnComandaECFAbreVinculado" n�o tratado'  ;

     fTefClass.GravaLog(Erro);

     raise EACBrTEFDECF.Create( ACBrStr( Erro ) )
  end;
end;

function TACBrTEFD.ECFImprimeVia( TipoRelatorio : TACBrTEFDTipoRelatorio;
   Via : Integer; ImagemComprovante : TStringList) : Integer;
Var
   Erro : String ;
begin
  fTefClass.GravaLog( fTefClass.Name +' ECFImprimeVia: '+
    GetEnumName( TypeInfo(TACBrTEFDTipoRelatorio), Integer(TipoRelatorio) ) +
    ' Via: '+IntToStr(Via) ) ;

  Result := -1 ;  // -1 = N�o tratado
  OnComandaECFImprimeVia( TipoRelatorio, Via, ImagemComprovante, Result ) ;

  if Result < 1 then
  begin
     if Result = 0 then
        Erro := 'Erro ao executar "OnComandaECFImprimeVia"'
     else
        Erro := '"OnComandaECFImprimeVia" n�o tratado' ;

     fTefClass.GravaLog(Erro);

     raise EACBrTEFDECF.Create( ACBrStr( Erro ) )
  end;
end;

procedure TACBrTEFD.FinalizarCupom;
Var
  I, J, Ordem : Integer;
  Est, EstNaoFiscal  : AnsiChar;
  ImpressaoOk : Boolean ;
  GrupoFPG    : TACBrTEFDArrayGrupoRespostasPendentes ;
begin
  ImpressaoOk := False ;
  fTefClass.GravaLog( 'FinalizarCupom ') ;

  try
     while not ImpressaoOk do
     begin
        try
           BloquearMouseTeclado( True );

           try
              EstNaoFiscal := 'N';
              Est          := EstadoECF;
              while Est <> 'L' do
              begin
                 // � n�o fiscal ? Se SIM, vamos passar por todas as fases...
                 if Est = 'N' then
                 begin
                    case EstNaoFiscal of
                      'N' : EstNaoFiscal := 'V' ;
                      'V' : EstNaoFiscal := 'P' ;
                      'P' : EstNaoFiscal := 'N' ;
                    end ;

                    Est := EstNaoFiscal ;
                 end ;

                 try
                    Case Est of
                      'V' : ComandarECF( opeSubTotalizaCupom );

                      'P' :
                        begin
                          if not AutoEfetuarPagamento then
                          begin
                             GrupoFPG := nil ;
                             AgruparRespostasPendentes( GrupoFPG );
                             Ordem := 0 ;

                             For I := 0 to Length( GrupoFPG )-1 do
                             begin
                                if GrupoFPG[I].OrdemPagamento = 0 then
                                 begin
                                   Inc( Ordem ) ;

                                   if SubTotalECF > 0 then
                                      ECFPagamento( GrupoFPG[I].IndiceFPG_ECF, GrupoFPG[I].Total );

                                   For J := 0 to RespostasPendentes.Count-1 do
                                      if RespostasPendentes[J].IndiceFPG_ECF = GrupoFPG[I].IndiceFPG_ECF then
                                         RespostasPendentes[J].OrdemPagamento := Ordem;
                                 end
                                else
                                   Ordem := GrupoFPG[I].OrdemPagamento ;
                             end;
                          end;

                          if SubTotalECF <= 0 then
                             ComandarECF( opeFechaCupom )
                          else
                             break ;
                        end ;

                      'N' :     // Usado apenas no Fechamento de NaoFiscal
                        begin
                          if SubTotalECF <= 0 then
                             ComandarECF( opeFechaCupom )
                          else
                             break ;
                        end ;
                    else
                      raise Exception.Create(
                         ACBrStr('ECF deve estar em Venda ou Pagamento'));
                    end;
                 except
                    { A condi��o abaixo, ser� True se n�o for Cupom Nao Fiscal,
                       ou se j� tentou todas as fases do Cupom Nao Fiscal
                       (SubTotaliza, Pagamento, Fechamento)...
                      Se for NaoFiscal n�o deve disparar uma exce��o at� ter
                       tentado todas as fases descritas acima, pois o ACBrECF
                       n�o � capaz de detectar com precis�o a fase atual do
                       Cupom N�o Fiscal (poucos ECFs possuem flags para isso) }

                    if EstNaoFiscal = 'N' then
                       raise ;
                 end ;

                 Est := EstadoECF;
              end;

              ImpressaoOk := True ;

           finally
              BloquearMouseTeclado( False );
           end;

        except
           on EACBrTEFDECF do ImpressaoOk := False ;
           else
              raise ;
        end;

        if not ImpressaoOk then
        begin
          if DoExibeMsg( opmYesNo, 'Impressora n�o responde'+sLineBreak+
                                   'Tentar novamente ?') <> mrYes then
          begin
             try ComandarECF(opeCancelaCupom); except {Exce��o Muda} end ;
             break ;
          end;
        end;
     end;
  finally
    if not ImpressaoOk then
       CancelarTransacoesPendentes;
  end;
end;

procedure TACBrTEFD.AgruparRespostasPendentes(
   var Grupo : TACBrTEFDArrayGrupoRespostasPendentes);
var
   I, J      : Integer;
   LenArr    : Integer;
   IndiceFPG : String;
   Ordem     : Integer;
begin
  SetLength( Grupo, 0) ;

  For I := 0 to RespostasPendentes.Count-1 do
  begin
     IndiceFPG := RespostasPendentes[I].IndiceFPG_ECF ;
     Ordem     := RespostasPendentes[I].OrdemPagamento ;

     J := 0 ;
     LenArr := Length( Grupo ) ;
     while J < LenArr do
     begin
       if (Grupo[J].IndiceFPG_ECF  = IndiceFPG) and
          (Grupo[J].OrdemPagamento = Ordem) then
          break ;
       Inc( J ) ;
     end;

     if J >= LenArr then
     begin
        SetLength( Grupo, J+1 ) ;
        Grupo[J].IndiceFPG_ECF  := IndiceFPG ;
        Grupo[J].OrdemPagamento := Ordem ;
        Grupo[J].Total  := 0 ;
     end;

     Grupo[J].Total := Grupo[J].Total + RespostasPendentes[I].ValorTotal ;
  end;
end;


function TACBrTEFD.Inicializado( GP : TACBrTEFDTipo = gpNenhum ) : Boolean;
begin
  if GP <> gpNenhum then
     GPAtual := GP ;

  Result := fTefClass.Inicializado ;
end;

procedure TACBrTEFD.SetEsperaSTS(const AValue : Integer);
Var
  I : Integer;
begin
  { Ajustando o mesmo valor nas Classes de TEF, caso elas usem o valor default }
  For I := 0 to fTEFList.Count-1 do
  begin
    if fTEFList[I] is TACBrTEFDClassTXT then
    begin
       with TACBrTEFDClassTXT( fTEFList[I] ) do
       begin
          if EsperaSTS = fEsperaSTS then
             EsperaSTS := AValue;
       end;
    end;
  end;

  fEsperaSTS := AValue;
end;

procedure TACBrTEFD.SetEstadoReq(const AValue : TACBrTEFDReqEstado);
begin
   if fEstadoReq = AValue then exit;
   fEstadoReq := AValue;

   if Assigned( OnMudaEstadoReq ) then
      OnMudaEstadoReq( EstadoReq );
end;

procedure TACBrTEFD.SetEstadoResp(const AValue : TACBrTEFDRespEstado);
begin
   if fEstadoResp = AValue then exit;
   fEstadoResp := AValue;

   if Assigned( OnMudaEstadoResp ) then
      OnMudaEstadoResp( EstadoResp );
end;

procedure TACBrTEFD.SetEsperaSleep(const AValue : Integer);
begin
   if fEsperaSleep = AValue then exit;

   if AValue < 10 then
      raise Exception.Create( ACBrStr('Valor m�nimo de EsperaSleep deve ser: 10' )) ;
   if AValue > 500 then
      raise Exception.Create( ACBrStr('Valor m�ximo de EsperaSleep deve ser: 500' )) ;

   fEsperaSleep := AValue;
end;

procedure TACBrTEFD.SetAutoAtivarGP(const AValue : Boolean);
var
   I : Integer;
begin
  { Ajustando o mesmo valor nas Classes de TEF }
  For I := 0 to fTEFList.Count-1 do
    if fTEFList[I] is TACBrTEFDClassTXT then
       TACBrTEFDClassTXT( fTEFList[I] ).AutoAtivarGP := AValue;

  fAutoAtivarGP := AValue;
end;

procedure TACBrTEFD.SetMultiplosCartoes(const AValue : Boolean);
begin
   if RespostasPendentes.Count > 0 then
      raise Exception.Create( ACBrStr( 'Existem Respostas Pendentes. '+
                              'N�o � poss�vel alterar "MultiplosCartoes"') ) ;
   fMultiplosCartoes := AValue;
end;

procedure TACBrTEFD.SetNumeroMaximoCartoes(const AValue: Integer);
begin
   fNumeroMaximoCartoes := max(AValue,0);
end;

procedure TACBrTEFD.SetAutoEfetuarPagamento(const AValue : Boolean);
begin
  if RespostasPendentes.Count > 0 then
     raise Exception.Create( ACBrStr( 'Existem Respostas Pendentes. '+
                             'N�o � poss�vel alterar "AutoEfetuarPagamento"') ) ;
  fAutoEfetuarPagamento := AValue;
end;

procedure TACBrTEFD.SetAutoFinalizarCupom(const AValue : Boolean);
begin
  if RespostasPendentes.Count > 0 then
     raise Exception.Create( ACBrStr( 'Existem Respostas Pendentes. '+
                             'N�o � poss�vel alterar "AutoFinalizarCupom"') ) ;
  fAutoFinalizarCupom := AValue;
end;

procedure TACBrTEFD.SetNumVias(const AValue : Integer);
var
   I : Integer;
begin
  For I := 0 to fTEFList.Count-1 do
  begin
    if fTEFList[I] is TACBrTEFDClassTXT then
    begin
       with TACBrTEFDClassTXT( fTEFList[I] ) do
       begin
          if NumVias = fNumVias then
             NumVias := AValue;
       end;
    end;
  end;

  fNumVias := AValue;
end;

function TACBrTEFD.GetPathBackup : String;
begin
  if fPathBackup = '' then
     if not (csDesigning in Self.ComponentState) then
        fPathBackup := ExtractFilePath(
        {$IFNDEF CONSOLE} Application.ExeName {$ELSE} ParamStr(0) {$ENDIF}
                                      ) + 'TEF' ;

  Result := fPathBackup ;
end;

function TACBrTEFD.GetArqReq : String;
begin
  if fTefClass is TACBrTEFDClassTXT then
     Result := TACBrTEFDClassTXT(fTefClass).ArqReq
  else
     Result := '' ;
end;

function TACBrTEFD.GetAbout : String;
begin
   Result := 'ACBrTEFD Ver: '+CACBrTEFD_Versao;
end;

function TACBrTEFD.GetAguardandoResposta: Boolean;
begin
  Result := fTefClass.AguardandoResposta ;
end;

procedure TACBrTEFD.SetAbout(const Value: String);
begin
  {}
end;

procedure TACBrTEFD.SetArqLOG(const AValue: String);
var
   I : Integer;
begin
  { Ajustando o mesmo valor nas Classes de TEF, caso elas usem o valor default }
  For I := 0 to fTEFList.Count-1 do
  begin
    with TACBrTEFDClassTXT( fTEFList[I] ) do
    begin
       if ArqLOG = fArqLOG then
          ArqLOG := AValue;
    end;
  end;

  fArqLOG := AValue;
end;

function TACBrTEFD.getArqResp : String;
begin
  if fTefClass is TACBrTEFDClassTXT then
     Result := TACBrTEFDClassTXT(fTefClass).ArqResp
  else
     Result := '' ;
end;

function TACBrTEFD.GetArqSTS : String;
begin
  if fTefClass is TACBrTEFDClassTXT then
     Result := TACBrTEFDClassTXT(fTefClass).ArqSTS
  else
     Result := '' ;
end;

function TACBrTEFD.GetArqTmp : String;
begin
  if fTefClass is TACBrTEFDClassTXT then
     Result := TACBrTEFDClassTXT(fTefClass).ArqTemp
  else
     Result := '' ;
end;

function TACBrTEFD.GetGPExeName : String;
begin
  if fTefClass is TACBrTEFDClassTXT then
     Result := TACBrTEFDClassTXT(fTefClass).GPExeName
  else
     Result := '' ;
end;

function TACBrTEFD.GetReq : TACBrTEFDReq;
begin
   Result := fTefClass.Req;
end;

function TACBrTEFD.GetResp : TACBrTEFDResp;
begin
   Result := fTefClass.Resp;
end;

procedure TACBrTEFD.SetPathBackup(const AValue : String);
begin
  if fPathBackup = AValue then exit ;

  if Inicializado then
     raise Exception.Create(ACBrStr('PathBackup n�o pode ser modificado com o ACBrTEFD Inicializado'));

  fPathBackup := Trim(AValue) ;

  if RightStr(fPathBackup,1) = PathDelim then   { Remove ultimo PathDelim }
     fPathBackup := copy( fPathBackup,1,Length(fPathBackup)-1 ) ;
end;

procedure TACBrTEFD.BloquearMouseTeclado( Bloqueia : Boolean );
var
   Tratado : Boolean;
begin
  Tratado := False ;
  fTecladoBloqueado := Bloqueia ;

  fTefClass.GravaLog( 'BloquearMouseTeclado: '+ IfThen( Bloqueia, 'SIM', 'NAO'));

  if Assigned( fOnBloqueiaMouseTeclado ) then
     fOnBloqueiaMouseTeclado( Bloqueia, Tratado ) ;

  if not Bloqueia then
     LimparTeclado;

  if not Tratado then
  begin
   {$IFDEF MSWINDOWS}
     if Assigned( xBlockInput ) then
        xBlockInput( Bloqueia ) ;
   {$ENDIF}
  end;
end;

 procedure TACBrTEFD.LimparTeclado;
 Var
   Tratado : Boolean ;
{$IFDEF MSWINDOWS}
     Msg: TMsg;
{$ENDIF}
 begin
   Tratado := False ;

   if Assigned( fOnLimpaTeclado ) then
      fOnLimpaTeclado( Tratado ) ;

   {$IFDEF MSWINDOWS}
    if not Tratado then
    begin
      try
         // Remove todas as Teclas do Buffer do Teclado //
         while PeekMessage(Msg, 0, WM_KEYFIRST, WM_KEYLAST, PM_REMOVE or PM_NOYIELD) do;{%h-}
      except
      end
    end;
   {$ENDIF} ;
 end;

 procedure TACBrTEFD.RestaurarFocoAplicacao ;
 var
    Tratado : Boolean;
 begin
   Tratado := False ;
   if Assigned( fOnRestauraFocoAplicacao ) then
      fOnRestauraFocoAplicacao( Tratado ) ;

   if not Tratado then
   begin
      Application.BringToFront ;

      {$IFDEF MSWINDOWS}
       if Assigned( Screen.ActiveForm ) then
       begin
         {$IFDEF VisualCLX}
          QWidget_setActiveWindow( Screen.ActiveForm.Handle );
         {$ELSE}
          SetForeGroundWindow( Screen.ActiveForm.Handle );
         {$ENDIF}
       end;
      {$ENDIF}
   end;
 end;


{$ifdef FPC}
initialization
   {$I ACBrTEFD.lrs}
{$endif}

end.

