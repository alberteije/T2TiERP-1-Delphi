{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 25/08/2009:  Daniel Simoes de Almeida
|*   Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFSwedaSTX ;

interface
uses ACBrECFClass, ACBrDevice, ACBrUtil, Classes, Contnrs
     {$IFNDEF CONSOLE}
     {$IFDEF VCL}, Dialogs , Controls , Forms {$ENDIF}
     {$IFDEF VisualCLX}, QDialogs, QControls, QForms {$ENDIF}
     {$ENDIF};

const
   STX  = #02 ;
   ETX  = #03 ;
   ACK  = 06 ;
   NACK = 21 ;
   ESC  = #27 ;
   CFALHAS = 3 ;
  {$IFDEF LINUX}
   cLIB_Sweda = 'libconvecf.so';
  {$ELSE}
   cLIB_Sweda = 'CONVECF.DLL';
  {$ENDIF}


type
{Dados Fiscais}
TACBrECFSwedaInfo34A1 = class
   private
    FVendaBrutaDiaria: String;
    FTotalizadorGeral: String;
    FVendaLiquida: String;
    procedure SetTotalizadorGeral(const Value: String);
    procedure SetVendaBrutaDiaria(const Value: String);
    procedure SetVendaLiquida(const Value: String);
   public
      {GT}
      property TotalizadorGeral:String read FTotalizadorGeral write SetTotalizadorGeral;
      {VL}
      property VendaLiquida:String read FVendaLiquida write SetVendaLiquida;
      {VB}
      property VendaBrutaDiaria:String read FVendaBrutaDiaria write SetVendaBrutaDiaria;
end;
{ Classe para armazenar Cache de Informações do 34 }
TACBrECFSwedaInfo34 = class
  private
    FSecao: String;
    FDados: AnsiString;
  public
     property Secao : String     read FSecao write FSecao;
     property Dados : AnsiString read FDados write FDados;
end ;

{ Lista de Objetos do tipo TACBrECFSwedaCache }
TACBrECFSwedaCache = class(TObjectList)
protected
  procedure SetObject (Index: Integer; Item: TACBrECFSwedaInfo34);
  function GetObject (Index: Integer): TACBrECFSwedaInfo34;
  procedure Insert (Index: Integer; Obj: TACBrECFSwedaInfo34);
public
  function AchaSecao( Secao : String ) : Integer ;
  function Add (Obj: TACBrECFSwedaInfo34): Integer;
  property Objects [Index: Integer]: TACBrECFSwedaInfo34
    read GetObject write SetObject; default;
end;


{ Classe filha de TACBrECFClass com implementaçao para SwedaSTX }

{ TACBrECFSwedaSTX }

TACBrECFSwedaSTX = class( TACBrECFClass )
 private

    fsSEQ       : Byte ;
    fsVerProtocolo : String ;
    fsCache34   : TACBrECFSwedaCache ;
    fsRespostasComando : String ;
    fsFalhasRX : Byte ;

    xECF_AbrePortaSerial : Function: Integer; {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;
    xECF_DownloadMFD : Function (Arquivo: PAnsichar; TipoDownload: PAnsichar;
      ParametroInicial: PAnsichar; ParametroFinal: PAnsichar; UsuarioECF: PAnsichar ):
      Integer; {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;
    xECF_ReproduzirMemoriaFiscalMFD : Function (tipo: PAnsichar; fxai: PAnsichar;
      fxaf:  PAnsichar; asc: PAnsichar; bin: PAnsichar): Integer; {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;
    xECF_FechaPortaSerial : Function: Integer; {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;
    xECF_DownloadMF : Function(Arquivo:PAnsiChar):Integer; {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;


    procedure AbrePortaSerialDLL;
    procedure LoadDLLFunctions;

    function RemoveNulos(Str:AnsiString):AnsiString;
    Function PreparaCmd( cmd : AnsiString ) : AnsiString ;
    function CalcCheckSum(cmd: AnsiString): AnsiChar;
    function DescompactaRetorno(const Dados: AnsiString): AnsiString;
    function DescreveErro(Erro: Integer): String;
    function AjustaRetorno(Retorno: AnsiString): AnsiString;
    function AjustaValor( ADouble : Double; Decimais : Integer = 2 ) : String ;
    function ExtraiRetornoLeituras(Retorno: AnsiString): AnsiString;
 protected
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumECF: String; override ;
    function GetNumLoja: String; override ;
    function GetNumSerie: String; override ;
    function GetNumSerieMFD: String; override ;    
    function GetNumVersao: String; override ;
    function GetSubModeloECF: String; override ;    
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetHorarioVerao: Boolean; override ;
    function GetArredonda: Boolean; override ;
    function GetChequePronto: Boolean; override ;
    function GetParamDescontoISSQN: Boolean; override ;

    function GetCNPJ: String; override ;
    function GetIE: String; override ;
    function GetIM: String; override ;
    function GetCliche: AnsiString; override ;
    function GetUsuarioAtual: String; override ;
    function GetPAF: String; override ;
    function GetDataMovimento: TDateTime; override ;
    function GetGrandeTotal: Double; override ;
    function GetNumCRO: String; override ;
    function GetNumCCF: String; override ;
    function GetNumGNF: String; override ;
    function GetNumGRG: String; override ;
    function GetNumCDC: String; override ;
    function GetNumCRZ: String; override ;
    function GetVendaBruta: Double; override ;
    function GetTotalAcrescimos: Double; override ;
    function GetTotalCancelamentos: Double; override ;
    function GetTotalDescontos: Double; override ;
    function GetTotalSubstituicaoTributaria: Double; override ;
    function GetTotalNaoTributado: Double; override ;
    function GetTotalIsencao: Double; override ;
    function GetNumCOOInicial: String; override ;
    function GetNumUltimoItem: Integer; override ;

    function GetDadosUltimaReducaoZ: AnsiString; override ;

    Function VerificaFimLeitura(var Retorno: AnsiString;
       var TempoLimite: TDateTime) : Boolean ; override ;
    function VerificaFimImpressao(var TempoLimite: TDateTime) : Boolean ; override ;

    function TraduzirTag(const ATag: AnsiString): AnsiString; override;
 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;
    procedure Ativar ; override ;
    Function EnviaComando_ECF( cmd : AnsiString ) : AnsiString ; override ;
    Procedure IdentificaOperador ( Nome: String); override;
    Procedure AbreCupom ; override ;
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D' ) ; override ;
    Procedure DescontoAcrescimoItemAnterior( ValorDescontoAcrescimo : Double = 0;
       DescontoAcrescimo : String = 'D'; TipoDescontoAcrescimo : String = '%';
       NumItem : Integer = 0 ) ;  override ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : AnsiString  = '') ; override ;
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ;
       override ;
    Procedure FechaCupom( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; override ;
    Procedure CancelaCupom ; override ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; override ;

    { Procedimentos de Cupom Não Fiscal }
    Procedure AbreNaoFiscal( CPF_CNPJ: String = ''; Nome: String = '';
       Endereco: String = '' ) ; override ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : AnsiString = '') ; override ;
    Procedure SubtotalizaNaoFiscal( DescontoAcrescimo : Double = 0;
       MensagemRodape: AnsiString = '') ; override ;
    Procedure EfetuaPagamentoNaoFiscal( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ; override ;
    Procedure FechaNaoFiscal( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; override ;
    Procedure CancelaNaoFiscal ; override ;

    Procedure LeituraX ; override ;
    Procedure LeituraXSerial( Linhas : TStringList) ; override ;
    Procedure ReducaoZ(DataHora : TDateTime = 0 ) ; override ;
    Procedure AbreRelatorioGerencial(Indice: Integer = 2) ; override ;
    Procedure LinhaRelatorioGerencial( Linha : AnsiString; IndiceBMP: Integer = 0 ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : AnsiString ) ; override ;
    Procedure FechaRelatorio ; override ;

    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;

    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;
    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime;
       Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer;
       Simplificada : Boolean = False ); override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       Linhas : TStringList; Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       Linhas : TStringList; Simplificada : Boolean = False ) ; override ;
    Procedure IdentificaPAF( Linha1, Linha2 : String) ; override ;
    Function RetornaInfoECF( Registrador: String) : AnsiString; override ;

    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    procedure LerTotaisAliquota ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;
    function AchaICMSAliquota( var AliquotaICMS: String ):
       TACBrECFAliquota; override ;

    procedure CarregaFormasPagamento ; override ;
    procedure LerTotaisFormaPagamento ; override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaRelatoriosGerenciais ; override ;
    procedure LerTotaisRelatoriosGerenciais ; override ;
    Procedure ProgramaRelatorioGerencial( var Descricao: String;
       Posicao : String = '') ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    procedure LerTotaisComprovanteNaoFiscal ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;

    Procedure CortaPapel( const CorteParcial : Boolean = false) ; override ;
    procedure NaoFiscalCompleto(CodCNF: String; Valor: Double;
          CodFormaPagto: String; Obs: AnsiString; IndiceBMP : Integer);override;

    Procedure LeituraMFDSerial(DataInicial, DataFinal : TDateTime;
       Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos] ) ; overload ; override ;
    Procedure LeituraMFDSerial( COOInicial, COOFinal : Integer;
       Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos] ) ; overload ; override ;

    Procedure EspelhoMFD_DLL( DataInicial, DataFinal : TDateTime;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; override ;
    Procedure EspelhoMFD_DLL( COOInicial, COOFinal : Integer;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; override ;
    Procedure ArquivoMFD_DLL( DataInicial, DataFinal : TDateTime;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos];
       Finalidade: TACBrECFFinalizaArqMFD = finMFD  ) ; override ;
    Procedure ArquivoMFD_DLL( ContInicial, ContFinal : Integer;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos];
       Finalidade: TACBrECFFinalizaArqMFD = finMFD;
       TipoContador: TACBrECFTipoContador = tpcCOO  ) ; override ;
 end ;

implementation
Uses ACBrECF, ACBrConsts,
     SysUtils,
   {$IFDEF COMPILER6_UP} DateUtils, StrUtils, {$ELSE} ACBrD5, Windows,{$ENDIF}
     Math;

{ --------------------------- TACBrECFSwedaCache ---------------------------- }
function TACBrECFSwedaCache.AchaSecao(Secao: String): Integer;
Var I : Integer ;
begin
  I := 0 ;
  Result := -1 ;
  while (Result < 0) and (I < Count) do
  begin
    if Secao = Objects[I].Secao then
       Result := I ;

    Inc( I ) ;
  end ;
end;

function TACBrECFSwedaCache.Add(Obj: TACBrECFSwedaInfo34): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrECFSwedaCache.GetObject(Index: Integer): TACBrECFSwedaInfo34;
begin
  Result := inherited GetItem(Index) as TACBrECFSwedaInfo34 ;
end;

procedure TACBrECFSwedaCache.Insert(Index: Integer;
  Obj: TACBrECFSwedaInfo34);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFSwedaCache.SetObject(Index: Integer;
  Item: TACBrECFSwedaInfo34);
begin
  inherited SetItem (Index, Item) ;
end;


{ ----------------------------- TACBrECFSwedaSTX ------------------------------ }

constructor TACBrECFSwedaSTX.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsDTR_DSR ;
  { Variaveis internas dessa classe }
  fsVerProtocolo := '' ;
  fsCache34   := TACBrECFSwedaCache.create( True );
  fsSEQ       := 42 ;
  fsRespostasComando := '' ;
  fsFalhasRX         := 0 ;
  
  fpModeloStr := 'SwedaSTX' ;
  fpRFDID     := 'SW' ;
end;

destructor TACBrECFSwedaSTX.Destroy;
begin
  fsCache34.Free ;
   
  inherited Destroy ;
end;

procedure TACBrECFSwedaSTX.Ativar;
Var RetCmd : AnsiString ;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create(ACBrStr('A impressora: '+fpModeloStr+' requer'+sLineBreak+
                            'Porta Serial:  (COM1, COM2, COM3, ...)'));

  fpDevice.HandShake := hsDTR_DSR ;
  inherited Ativar ; { Abre porta serial }

  GravaLog( 'Ativar' ) ;

  fsVerProtocolo := '' ;
  fpMFD       := True ;
  fpTermica   := True ;
  fsCache34.Clear ;
  fsRespostasComando := '' ;
  fsFalhasRX         := 0 ;

  try
     { Testando a comunicaçao com a porta }
     fsVerProtocolo := Trim(copy( TACBrECF(fpOwner).RetornaInfoECF( 'I1' ), 82, 1)) ;

     if fsVerProtocolo = '' then
        raise EACBrECFNaoInicializado.Create( ACBrStr(
                 'Erro inicializando a impressora '+fpModeloStr ));

     fpDecimaisPreco := 0 ;
     RetCmd := TACBrECF(fpOwner).RetornaInfoECF( 'H2' ) ;
     if copy(RetCmd,10,1) = 'S' then
        fpDecimaisPreco := 2 ;
     if copy(RetCmd,11,1) = 'S' then
        fpDecimaisPreco := fpDecimaisPreco + 1 ;

     fpDecimaisQtd   := StrToIntDef(copy( TACBrECF(fpOwner).RetornaInfoECF( 'U2' ),  1, 1), 2 ) ;
  except
     Desativar ;
     raise ;
  end ;
end;

Function TACBrECFSwedaSTX.EnviaComando_ECF( cmd : AnsiString ) : AnsiString ;
Var ErroMsg, Mensagem : String ;
    FalhasTX : Integer;
    ACK_ECF  : Byte ;
begin
   Result             := '' ;
   fpComandoEnviado   := '' ;
   fpRespostaComando  := '' ;
   fsRespostasComando := '' ;
   fsFalhasRX         := 0 ;

   if (LeftStr(cmd,2) <> '34') then
      fsCache34.Clear ;         // Limpa o Cache do 34

   { Codificando CMD de acordo com o protocolo da SwedaSTX }
   cmd := PreparaCmd( cmd ) ;

   ACK_ECF  := 0 ;
   FalhasTX := 0 ;

   fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }

   while (ACK_ECF <> ACK) do
   begin
      fpDevice.Serial.Purge ;                   { Limpa a Porta }

      if not TransmiteComando( cmd ) then
         continue;

      try
         { espera ACK chegar na Porta por 7s }
         try
            ACK_ECF := fpDevice.Serial.RecvByte(TimeOut * 1000 ) ;
         except
         end ;

         if ACK_ECF = 0 then
            raise EACBrECFSemResposta.create( ACBrStr(
                     'Impressora '+fpModeloStr+' não responde (ACK = 0)') )
         else if ACK_ECF = 21 then    { retorno em caracter 21d=15h=NAK }
            raise EACBrECFSemResposta.create( ACBrStr(
                  'Impressora '+fpModeloStr+' não reconheceu o Comando'+
                  sLineBreak+' (ACK = 21). Falha: '+IntToStr(FalhasTX)) )
         else if ACK_ECF <> 6 then
            raise EACBrECFSemResposta.create( ACBrStr(
                  'Erro. Resposta da Impressora '+fpModeloStr+' inválida'+
                  sLineBreak+' (ACK = '+IntToStr(ACK)+')') ) ;
      except
         on E : EACBrECFSemResposta do
          begin
            fpDevice.Serial.Purge ;

            Inc( FalhasTX ) ;
            if FalhasTX < CFALHAS then
               Sleep(100)
            else
               if not DoOnMsgRetentar( E.Message +sLineBreak+sLineBreak+
                  'Se o problema persistir, verifique os cabos, ou'+sLineBreak+
                  'experimente desligar a impressora durante 5 seg,'+sLineBreak+
                  'liga-la novamente, e repetir a operação...'
                  , 'LerACK') then
                  raise ;
          end ;
         else
            raise ;
      end ;
   end ;

   fpComandoEnviado := cmd ;

   { Chama Rotina da Classe mãe TACBrClass para ler Resposta. Se houver
     falha na leitura LeResposta dispara Exceçao.
     Resposta fica gravada na váriavel "fpRespostaComando" }
   LeResposta ;

   { Captura informações do Ultimo Bloco Enviado }
   Mensagem := copy(fpRespostaComando,6,4) ;

   fpRespostaComando := fsRespostasComando ;   // Respostas Acumuladas

   { Limpando de "fpRespostaComando" os Status não solicitados }
   fpRespostaComando := AjustaRetorno( fpRespostaComando  );

   ErroMsg := DescreveErro( StrToIntDef(Mensagem,-1) ) ;

   if ErroMsg <> '' then
    begin
      ErroMsg := ACBrStr('Erro retornado pela Impressora: '+fpModeloStr+
                 sLineBreak+sLineBreak+
                 'Erro ('+Mensagem+') '+ErroMsg ) ;
      raise EACBrECFSemResposta.create(ErroMsg) ;
    end
   else
      Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }

   { Descompactando Strings dentro do Retorno }
   Result := DescompactaRetorno( fpRespostaComando ) ;
end;

procedure TACBrECFSwedaSTX.EspelhoMFD_DLL(COOInicial, COOFinal: Integer;
  NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet);
Var
  Resp : Integer ;
  CooIni, CooFim : AnsiString ;
  OldAtivo : Boolean ;
begin
  LoadDLLFunctions ;

  OldAtivo := Ativo ;
  try
    Ativo := False ;
    AbrePortaSerialDLL ;

    CooIni := IntToStrZero( COOInicial, 6 ) ;
    CooFim := IntToStrZero( COOFinal, 6 ) ;
    Resp := xECF_DownloadMFD( PAnsichar( NomeArquivo ), '2', PAnsiChar(CooIni), PAnsiChar(CooFim), '0');
    if (Resp <> 1) then
      raise Exception.Create( ACBrStr( 'Erro ao executar ECF_DownloadMFD.'+sLineBreak+
                                       'Cod.: '+IntToStr(Resp) ))
  finally
    xECF_FechaPortaSerial ;
    Ativo := OldAtivo ;
  end ;

  if not FileExists( NomeArquivo ) then
     raise Exception.Create( ACBrStr( 'Erro na execução de ECF_DownloadMFD.'+sLineBreak+
                            'Arquivo: "'+NomeArquivo + '" não gerado' ))
end;

procedure TACBrECFSwedaSTX.EspelhoMFD_DLL(DataInicial, DataFinal: TDateTime;
  NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet);
Var
  Resp : Integer ;
  DiaIni, DiaFim : AnsiString ;
  OldAtivo : Boolean ;
  oldDateSeparator: Char;
  OldShortDateFormat : String;
begin
  LoadDLLFunctions ;
  OldAtivo           := Ativo ;
  OldShortDateFormat := ShortDateFormat ;
  OldDateSeparator   := DateSeparator;
  try
    DateSeparator      :='/';
    ShortDateFormat    := 'dd/mm/yy' ;

    Ativo := False ;
    AbrePortaSerialDLL ;

    DiaIni := FormatDateTime('DD/MM/YY',DataInicial) ;
    DiaFim := FormatDateTime('DD/MM/YY',DataFinal) ;

    Resp := xECF_DownloadMFD( PAnsichar( NomeArquivo ), '1', PAnsiChar(DiaIni), PAnsiChar(DiaFim), '0');
    if (Resp <> 1) then
      raise Exception.Create( ACBrStr( 'Erro ao executar ECF_DownloadMFD.'+sLineBreak+
                                       'Cod.: '+IntToStr(Resp) ))
  finally
    DateSeparator   := OldDateSeparator;
    ShortDateFormat := OldShortDateFormat;
    xECF_FechaPortaSerial ;
    Ativo := OldAtivo ;
  end ;

  if not FileExists( NomeArquivo ) then
     raise Exception.Create( ACBrStr( 'Erro na execução de ECF_DownloadMFD.'+sLineBreak+
                            'Arquivo: "'+NomeArquivo+'" não gerado' ))
end;

function TACBrECFSwedaSTX.DescreveErro( Erro : Integer ) : String ;
begin
  Result := '' ;

  case Erro of
     -1 : Result := 'Erro na Interpretação da Resposta do ECF' ;
      0 : Result := '' ;

    002 : Result := 'Documento já Cancelado' ;
    003 : Result := 'Documento já foi Totalmente Pago' ;
    004 : Result := 'Documento ainda não foi Totalmente Pago' ;
    005 : Result := 'Documento já foi Totalizado' ;
    006 : Result := 'Item Inválido' ;
    007 : Result := 'Item Cancelado' ;
    008 : Result := 'Total apurado igual a Zero' ;
    009 : Result := 'Acréscimo já aplicado sobre este Item' ;
    010 : Result := 'Não há Acréscimo sobre este Item' ;
    011 : Result := 'Desconto já aplicado sobre este Item' ;
    012 : Result := 'Não há Desconto sobre este Item' ;
    013 : Result := 'Valor de Desconto superior ao Total do Item' ;
    014 : Result := 'Acréscimo já aplicado em Subtotal' ;
    015 : Result := 'Não há Acréscimo aplicado no Subtotal' ;
    016 : Result := 'Desconto já aplicado em Subtotal' ;
    017 : Result := 'Não há Desconto aplicado no Subtotal' ;
    018 : Result := 'Valor de Desconto superior ao Total do Documento' ;
    019 : Result := 'Meio de Pagamento não programado' ;
    020 : Result := 'Atingido Limite de Itens por Cupom' ;
    021 : Result := 'Alíquota de Imposto não programada' ;
    022 : Result := 'Alteração de Estilo de Fonte não permitida nesse comando' ;
    023 : Result := 'Erro na Sintaxe do Comando Enviado' ;
    025 : Result := 'Informado Valor Nulo' ;
    027 : Result := 'Data com formato inválido' ;
    028 : Result := 'Hora com formato inválido' ;
    029 : Result := 'Comando não reconhecido' ;
    030 : Result := 'Tabela Cheia' ;
    031 : Result := 'Faixa Informada é Inválida' ;
    032 : Result := 'Tentativa de registro em um mesmo comprovante de '+
                     'operações não fiscais cadastradas com sinais distintos' ;
    033 : Result := 'Informado Sinal Inválido' ;
    034 : Result := 'Excedida capacidade de pagamento por meio de CCD' ;
    035 : Result := 'Operação de TEF informada pelo comando de abertura do comprovante não encontrada' ;
    036 : Result := 'Classificação do meio de pagamento inválida' ;
    037 : Result := 'Título informado na abertura de Relatório Gerencial não encontrado' ;
    040 : Result := 'Mensagem: Abertura do Movimento' ;
    041 : Result := 'Denominação informada no Registro de Operação não fiscal não encontrada ' ;
    042 : Result := 'Valor total do Item excedido' ;
    043 : Result := 'Valor do estorno excede a soma dos pagamentos registrados no meio indicado' ;
    044 : Result := 'Valor efetivado é insuficiente para o pagamento!' ;
    050 : Result := 'Campo de Descrição não informado' ;
    058 : Result := 'Comando ou operação inválida!' ;
    060 : Result := 'É necessária a emissão do documento de Redução Z!' ;
    061 : Result := 'O ECF está em Modo de Intervenção Técnica!';
    062 : Result := 'O ECF está inativo!';
    067 : Result := 'Permitida uma única reimpressão!';
    068 : Result := 'Erro físico de gravação na memória fiscal!';
    074 : Result := 'Ejetando folha solta...';
    080 : Result := 'Esgotamento de Dispositivo: Memória Fiscal';
    087 : Result := 'Leiaute de cheque não programado!';
    092 : Result := 'Já emitida a 2ª via!';
    093 : Result := 'Excede o limite de 24 parcelas!';
    094 : Result := 'Informado número incorreto da parcela!';
    095 : Result := 'Informado valor unitário inválido!';
    096 : Result := 'Não foram estornados os Comprovantes de Crédito ou Débito emitidos!';
    098 : Result := 'Processando...';
    099 : Result := 'Confirme';
    103 : Result := 'Inserir a frente para preenchimento!';
    104 : Result := 'Inserir o verso para preenchimento!';
    105 : Result := 'Inserir o cheque para preenchimento!';
    109 : Result := 'Inserir cheque.';
    110 : Result := 'Resultado de leitura MICR-CMC7';
    111 : Result := 'Resultado de leitura MICR-E13B';
    112 : Result := 'Não foi detectado nenhum caracter!';
    113 : Result := 'Um dos caracteres não foi reconhecido!';
    114 : Result := 'As dimensões do cheque estão fora das especificações! ';
    115 : Result := 'Erro na impressora durante o processamento!';
    116 : Result := 'A tampa foi aberta durante a leitura!';
    117 : Result := 'Fonte inválida!';
    120 : Result := 'Erro de gravação no dispositivo de memória de fita-detalhe!';
    121 : Result := 'Erro mecânico na impressora!';
    122 : Result := 'Erro na guilhotina!';
    123 : Result := 'Erro recuperável!';
    124 : Result := 'Tampa Aberta' ;
    125 : Result := 'Sem Papel' ;
    126 : Result := 'Avançando Papel' ;
    127 : Result := 'Substituir Bobina' ;
    128 : Result := 'Falha de comunicação com o mecanismo de impressão!';
    130 : Result := 'Não emitida redução Z!';
    131 : Result := 'Totalizador desabilitado!';
    132 : Result := 'Esgotamento de Dispositivo: Memória de Fita-Detalhe';
    133 : Result := 'O ECF está emitindo a Redução Z para entrada em Intervenção Técnica...';
    134 : Result := 'Transmissão de leitura via porta de comunicação serial abortada';
    135 : Result := 'Já emitido o Cupom Adicional!';
    136 : Result := 'Indicado CDC Inválido';
    139 : Result := 'A cabeça de impressão térmica está levantada!';
    140 : Result := 'Status da cabeça de impressão térmica: Temperatura elevada!';
    141 : Result := 'Status da cabeça de impressão térmica: Tensão inadequada!';
    142 : Result := 'Informado código de barras Inválido!';
    148 : Result := 'Quantidade inválida!';
    149 : Result := 'Desconto sobre serviço desabilitado';
    151 : Result := 'Divergência de relógio!';
    156 : Result := 'Função MICR não disponível!';
    157 : Result := 'Função de preenchimento de cheques não disponível!';
    159 : Result := 'Preenchendo...';
    160 : Result := 'Não há acréscimo ou desconto aplicado sobre o item';
    161 : Result := 'Não há acréscimo ou desconto aplicado sobre o subtotal';
    162 : Result := 'Não cancelado a operação de acréscimo aplicada sobre o item após o desconto';
    163 : Result := 'Não cancelado a operação de desconto aplicada sobre o item após o acréscimo';
    164 : Result := 'Não cancelado a operação de acréscimo aplicada sobre o subotal após o desconto';
    165 : Result := 'Não cancelado a operação de desconto aplicada sobre o subotal após o acréscimo';
    166 : Result := 'O mecanismo de impressão detectado não pertence a este modelo de ECF';
    170 : Result := 'Código de barras não disponível!';
    171 : Result := 'Erro MICR: Falha de acionamento do leitor!';
    172 : Result := 'Mensagem: preenchimento de cheque concluído!';
    187 : Result := 'Identificar-se!';
    193 : Result := 'Falha de comunicação na transmissão das informações' ;
    195 : Result := 'Enviar imagem';
    196 : Result := 'Dimensões inválidas!';
    197 : Result := 'Falha no envio da imagem!';
    198 : Result := 'Processando....';
    200 : Result := 'Efetuando leitura MICR...';
    201 : Result := 'Preço unitário inválido!';
    202 : Result := 'Já foi impressa a identificação do consumidor!';
    203 : Result := 'Erro no formato do logotipo!';
    204 : Result := 'Função de autenticação não disponível!';
    205 : Result := 'Autenticação cancelada!';
    206 : Result := 'Inserir documento!';
    207 : Result := 'Autenticando...';
    208 : Result := 'Limitado a 5 autenticações!';
    209 : Result := 'Erro nos parâmetros do comando de repetição';
    215 : Result := 'Centavos não habilitados!';
    216 : Result := 'A data está avançada em mais de 30 dias em relação ao '+
                    'último documento emitido pelo '+
                    'ECF. Envie o comando de programação do relógio para verificação.';
    217 : Result := 'Preparando a impressão da fita-detalhe...';
    220 : Result := 'Mensagem de progressão durante a emissão da Redução Z!';
    24,38,39,45..47,65,66,69..73,75..79,81..86,88..91,97,100..102,106,118,119,
    129,137,138,145..147,150,152..155,158,173..183,185,186,188..191,199,210,
    219,221,225,230,235..237,241,242,244..248
        : Result := 'Chamar Assistência Técnica' ;
    243 : Result := 'Redução não encontrada!' ;
    249 : Result := 'Totalizadores de ISSQN desabilitados, Inscrição Municipal não programada!' ;
    250 : Result := 'Totalizadores de ICMS desabilitados, CNPJ não programado!' ;
  else
    Result := 'Consulte o manual' ;
  end ;
end ;

function TACBrECFSwedaSTX.VerificaFimLeitura(var Retorno: AnsiString;
   var TempoLimite: TDateTime) : Boolean ;
Var
  LenRet, PosETX, PosSTX : Integer ;
  Bloco, Tarefa : AnsiString ;
  Sequencia, ACK_PC : Byte ;
  Tipo : AnsiChar ;
begin
  LenRet := Length(Retorno) ;
  Result := False ;

  if LenRet < 5 then
     exit ;

  PosSTX := Pos(STX,Retorno);
  if PosSTX < 1 then     // Não recebeu o STX
     exit
  else if PosSTX > 1 then
     Retorno := copy(Retorno, PosSTX, Length(Retorno) ) ;  // STX deve estar no inicio.

  PosETX := Pos(ETX, Retorno) ;
  if PosETX < 1 then    // Não recebeu ETX
     exit ;

  if (LenRet = PosETX) then  // Sem CHK
     exit ;

  { Ok, temos um bloco completo... Vamos trata-lo}
  Bloco     := copy(Retorno, 1, PosETX+1) ;
  Result    := True ;
  Sequencia := Ord( Bloco[2] ) ;
  Tarefa    := copy(Bloco,3,2) ;
  Tipo      := Bloco[5] ;

  GravaLog( 'SwedaSTX VerificaFimLeitura: Verificando Bloco: '+Bloco, True) ;

  if Tipo = '!' then  // Bloco de Satus não solicitado, Descartando
   begin
     GravaLog( 'SwedaSTX VerificaFimLeitura: Bloco (!) Descartado: '+Bloco, True) ;
     Result := False ;
   end
  else
   begin
     { Verificando a Sequencia }
     if Sequencia <> fsSEQ then
     begin
        Result := False ;  // Ignore o Bloco, pois não é a resposta do CMD solicitado
        GravaLog( 'Sequencia de Resposta ('+IntToStr(Sequencia)+')'+
                  'diferente da enviada ('+IntToStr(fsSEQ)+')' ) ;
     end ;

     { Verificando o CheckSum }
     ACK_PC := ACK ;

     if Result and
       ( CalcCheckSum(LeftStr(Bloco,Length(Bloco)-1)) <> RightStr(Bloco,1) ) then
     begin
       ACK_PC := NACK ;  // Erro no CheckSum, retornar NACK
       if fsFalhasRX > CFALHAS then
          raise Exception( ACBrStr('Erro no digito Verificador da Resposta.'+sLineBreak+
                           'Falha: '+IntToStr(fsFalhasRX)) ) ;
       Inc( fsFalhasRX ) ;  // Incrementa numero de Falhas
       Result := False ;
     end ;

     fpDevice.Serial.SendByte(ACK_PC);

     if Result then
        fsRespostasComando := fsRespostasComando + Retorno ;  // Salva este Bloco

     if (ACK_PC = ACK) then           // ACK OK ?
     begin
        if Tipo = '-' then            // Erro ocorrido,
           AguardaImpressao := False  //   portanto, Desliga AguardaImpressao (caso estivesse ligado)
        else if Tipo <> '+' then      // Tipo não é '-' nem '+', portanto não é o Ultimo Bloco
           Result := False ;          //   portanto Zera para Ler proximo Bloco
     end ;

     GravaLog( 'SwedaSTX VerificaFimLeitura: Seq:'+IntToStr(Sequencia)+' Tarefa:'+
               Tarefa+' Tipo: '+Tipo+' ACK:'+IntToStr(ACK_PC)+' Result: '+IfThen(Result,'True','False') ) ;
   end ;

  if not Result then
  begin
     //GravaLog('Retorno Antes do ajuste: '+Retorno, True);
     Retorno := copy(Retorno, PosETX+2, Length(Retorno) ) ;
     //GravaLog('Retorno APOS o ajuste: '+Retorno, True);
  end ;
end;

function TACBrECFSwedaSTX.VerificaFimImpressao(var TempoLimite: TDateTime): Boolean;
Var Cmd, Ret, RetCmd : AnsiString ;
    wACK : Byte ;
    I : Integer ;
begin
  { Essa função só é chamada se AguardaImpressao = True,
    Como essa função é executada dentro da "LeResposta", que por sua vez foi
    chamada por "EnviaComando", não podemos usar o método "EnviaComando" (ou
    teriamos uma chamada recursiva infinita), por isso o Loop abaixo envia o
    comando '34' diretamente para a Serial, e aguarda por 5 segundos a resposta...
    Se a SwedaSTX conseguir responder, significa que a Impressão Terminou }
  Result := false ;

  if not EmLinha() then
   begin
     Sleep(100) ;
     GravaLog('SwedaSTX VerificaFimImpressao: ECF fora de linha') ;
   end
  else
   begin
     RetCmd := '' ;
     Cmd    := PreparaCmd( '34' ) ;           // Pede Status //

     try
        GravaLog('SwedaSTX VerificaFimImpressao: Pedindo o Status. Seq:'+IntToStr(fsSEQ)) ;

        fpDevice.Serial.Purge ;          // Limpa buffer de Entrada e Saida //
        fpDevice.EnviaString( Cmd );     // Envia comando //

        wACK := fpDevice.Serial.RecvByte( TimeOut * 1000 ) ; // espera ACK chegar na Porta  //

        if wACK = 6 then   // ECF Respondeu corretamente, portanto está trabalhando //
        begin
           GravaLog('SwedaSTX VerificaFimImpressao: ACK = 6, OK... Aguardando Bloco') ;

           // Aguarda por Bloco até 2 seg //
           I := 0 ;
           while (I < 20) and (not Result) do
           begin
              TempoLimite := IncSecond(now, TimeOut);
              try
                 Ret := fpDevice.Serial.RecvPacket(200) ;
              except
              end ;

              RetCmd := RetCmd + Ret ;
              Inc( I ) ;

              GravaLog('SwedaSTX VerificaFimImpressao: I: '+IntToStr(I)+' Bloco Lido: '+RetCmd ) ;
              Result :=  VerificaFimLeitura( RetCmd, TempoLimite)   ;
           end ;

           Result := Result and (pos(copy(RetCmd,11,1), 'ACDGI') > 0) ;
        end ;
     except
       On E : Exception  do
       begin
         GravaLog('SwedaSTX VerificaFimImpressao: Exception:'+E.Message ) ;
       end ;
     end ;
   end ;
end;

Function TACBrECFSwedaSTX.PreparaCmd( cmd : AnsiString ) : AnsiString ;
begin
  Result := '' ;

  if cmd = '' then exit ;

  Inc(fsSEQ) ;
  if fsSEQ = 255 then
     fsSEQ := 43 ;

 cmd := STX + AnsiChar(chr( fsSEQ ))+  cmd + ETX ;   { Prefixo ESC }
 //cmd := #02+chr( fsSEQ )+'15'#03;
// cmd := #02+chr( fsSEQ )+'34I1'#03;

  Result := cmd + CalcCheckSum( cmd ) ;
end ;

Function TACBrECFSwedaSTX.CalcCheckSum( cmd : AnsiString ) : AnsiChar ;
Var A, iSoma, LenCmd, CheckSum : Integer ;
begin
  { Calculando a Soma dos caracteres ASC }
  LenCmd := Length( cmd ) ;
  iSoma := 0 ;
  For A := 1 to LenCmd  do
     iSoma := iSoma + ord( cmd[A] ) ;

  { Calculando o digito verificado }
  CheckSum := iSoma mod 256 ;

  Result := AnsiChar( Chr( CheckSum ) ) ;
end ;

{ Remove Blocos de Resposta de Status não solicitados  (envio automático pelo ECF)}
Function TACBrECFSwedaSTX.AjustaRetorno(Retorno: AnsiString) : AnsiString ;
Var
  LenRet, PosETX, PosSTX : Integer ;
  Bloco, Tipo : AnsiString ;
begin
  LenRet := Length(Retorno) ;
  Result := Retorno ;

  if LenRet < 5 then
     exit ;

  PosSTX := Pos(STX,Result);
  if PosSTX < 1 then
     Result := ''               // Não recebeu o STX, invalida Retorno
  else if PosSTX > 1 then
     Result := copy(Result, PosSTX, Length(Result) ) ;  // Deve iniciar em STX

  while PosSTX > 0 do
  begin
     PosETX := PosEx(ETX, Result, PosSTX ) ;
     if PosETX < 1 then          // Ainda não recebeu o ETX final
        break ;

     Bloco := copy(Result, PosSTX, PosETX-PosSTX + 2  ) ;  // Pega um Bloco; +2 para pegar CHK
     Tipo  := copy(Bloco,5,1) ;

     if Tipo = '!' then  // Bloco de Status nao solicitado, excluindo
     begin
        Delete(Result, PosSTX, PosETX-PosSTX + 2 ) ;
        PosETX := max(PosSTX - 2,0) ;
     end ;

     PosSTX := PosEx( STX , Result, PosETX);
  end ;
end ;

{ Remove Blocos de Resposta de Status não solicitados  (envio automático pelo ECF)}
Function TACBrECFSwedaSTX.ExtraiRetornoLeituras(Retorno: AnsiString) : AnsiString ;
Var
  PosETX, PosSTX : Integer ;
  Bloco, Tipo : AnsiString ;
begin
  Result := '' ;

  PosSTX := Pos(STX,Retorno);
  while PosSTX > 0 do
  begin
     PosETX := PosEx(ETX, Retorno, PosSTX ) ;
     if PosETX < 1 then          // Ainda não recebeu o ETX final
        break ;

     Bloco := copy(Retorno, PosSTX, PosETX-PosSTX + 2  ) ;  // Pega um Bloco; +2 para pegar CHK
     Tipo  := copy(Bloco,5,1) ;

     if Tipo = '>' then  // Bloco de Resposta
        Result := Result + copy(Bloco,7, Length(Bloco) - 8 ) ;

     PosSTX := PosEx( STX , Retorno, PosETX);
  end ;
end ;

function TACBrECFSwedaSTX.DescompactaRetorno( const Dados : AnsiString ) : AnsiString ;
Var P      : Integer ;
    AChar  : AnsiChar ;
    NTimes : Byte ;
begin
   Result   := Dados ;

   P := pos(ESC, Result) ;
   while (P > 0) do
   begin
      AChar  := Result[P-1] ;

      if AChar <> ETX then  // Não usa caso ESC esteja no CHK
      begin
         NTimes := ord( copy( Result, P+1, 1)[1] ) - 31 ;
         Result := StuffString(Result, P, 2, StringOfChar(AChar,NTimes) ) ;
      end ;

      P := PosEx( ESC, Result, P+1) ;
   end ;
end ;

function TACBrECFSwedaSTX.AjustaValor( ADouble : Double;
  Decimais : Integer = 2 ) : String ;
begin
  Result := FormatFloat('0.'+StringOfChar('0',Decimais) ,ADouble) ;
  Result := Trim(StringReplace(Result,DecimalSeparator,',',[])) ;
end;

procedure TACBrECFSwedaSTX.ArquivoMFD_DLL(ContInicial, ContFinal: Integer;
  NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet;
  Finalidade: TACBrECFFinalizaArqMFD;
  TipoContador: TACBrECFTipoContador);
Var
  Resp : Integer ;
  CooIni, CooFim, respm : AnsiString ;
  OldAtivo : Boolean ;
  PathBin:AnsiString;
begin
  LoadDLLFunctions ;

  OldAtivo := Ativo ;
  try
    Ativo := False ;
    AbrePortaSerialDLL ;

    if TipoContador = tpcCRZ then
    begin
       {Por CRZ}
       CooIni := IntToStrZero( ContInicial, 4 ) ;
       CooFim := IntToStrZero( ContFinal, 4 ) ;
    end
    else
    if TipoContador = tpcCOO then
    begin
       {POr COO}
       CooIni := IntToStrZero( ContInicial, 7);
       CooFim := IntToStrZero( ContFinal, 7 ) ;
    end
    else
      raise Exception.Create('Tipo de contador desconhecido, tipos válidos: CRZ, COO');

    PathBin := ExtractFilePath(NomeArquivo);
    PathBin:= PathBin + 'MF.BIN';
    Resp := xECF_DownloadMF(PAnsiChar(pathBin));
    case resp of
      -3: respm:='Não existe movimento';
      -2: respm:='Parâmetro inválido na função.';
       0: respm:='Erro de comunicação.';
     -27: respm:='Status do ECF diferente de 6,0,0,0 (Ack,St1,St2,St3).';
      -1: respm:='Falta movimento em um dos arquivos binários.';
      end;

    if Resp <> 1 then
      raise Exception.Create( ACBrStr( 'Erro ao executar xECFDownloadMF'+sLineBreak+
                                       'Cod.: '+IntToStr(Resp)+' '+respm ));

    Resp := xECF_ReproduzirMemoriaFiscalMFD('2', PAnsiChar(CooIni), PAnsiChar(CooFim),PAnsichar(NomeArquivo),PansiChar(PathBin));
    DeleteFile(IncludeTrailingPathDelimiter(ExtractFilePath(
      {$IFNDEF CONSOLE} Application.ExeName {$ELSE} ParamStr(0) {$ENDIF})) + 'MF.BIN');

    if (Resp <> 1) then
      raise Exception.Create( ACBrStr( 'Erro ao executar xECF_ReproduzirMemoriaFiscalMFD.'+sLineBreak+
                                       'Cod.: '+IntToStr(Resp) ))
  finally
    xECF_FechaPortaSerial ;
    Ativo := OldAtivo ;
  end ;

  if not FileExists( NomeArquivo ) then
     raise Exception.Create( ACBrStr( 'Erro na execução de ECF_DownloadMFD.'+sLineBreak+
                            'Arquivo: "'+NomeArquivo + '" não gerado' ))
end;

procedure TACBrECFSwedaSTX.ArquivoMFD_DLL(DataInicial, DataFinal: TDateTime;
  NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet;
  Finalidade: TACBrECFFinalizaArqMFD);
Var
  Resp : Integer ;
  DiaIni, DiaFim, respm : AnsiString ;
  OldAtivo : Boolean ;
  PathBin:AnsiString;
  oldDateSeparator: Char;
  OldShortDateFormat : String;
begin
  LoadDLLFunctions ;

  OldAtivo := Ativo ;
  OldShortDateFormat := ShortDateFormat ;
  OldDateSeparator   := DateSeparator;
  try
    Ativo := False ;
    AbrePortaSerialDLL ;

    DateSeparator      :='/';
    ShortDateFormat    := 'dd/mm/yy' ;
    PathBin := ExtractFilePath(NomeArquivo);
    PathBin:= PathBin + 'MF.BIN';
    Resp := xECF_DownloadMF(PAnsiChar(pathBin));
    case resp of
      -3: respm:='Não existe movimento';
      -2: respm:='Parâmetro inválido na função.';
       0: respm:='Erro de comunicação.';
     -27: respm:='Status do ECF diferente de 6,0,0,0 (Ack,St1,St2,St3).';
      -1: respm:='Falta movimento em um dos arquivos binários.';
      end;
    if Resp <> 1 then
      raise Exception.Create( ACBrStr( 'Erro ao executar xECFDownloadMF'+sLineBreak+
                                       'Cod.: '+IntToStr(Resp)+' '+respm ));

    DiaIni := FormatDateTime('DD/MM/YY',DataInicial) ;
    DiaFim := FormatDateTime('DD/MM/YY',DataFinal) ;

    Resp := xECF_ReproduzirMemoriaFiscalMFD('2', PAnsiChar(DiaIni), PAnsiChar(DiaFim), PAnsichar( NomeArquivo ),PAnsiChar(pathBin));
    DeleteFile(IncludeTrailingPathDelimiter(ExtractFilePath(
      {$IFNDEF CONSOLE} Application.ExeName {$ELSE} ParamStr(0) {$ENDIF})) + 'MF.BIN');

    if (Resp <> 1) then
      raise Exception.Create( ACBrStr( 'Erro ao executar ECF_DownloadMFD.'+sLineBreak+
                                       'Cod.: '+IntToStr(Resp) ))
  finally
    xECF_FechaPortaSerial ;
    DateSeparator   := OldDateSeparator;
    ShortDateFormat := OldShortDateFormat;
    Ativo := OldAtivo ;
  end ;

  if not FileExists( NomeArquivo ) then
     raise Exception.Create( ACBrStr( 'Erro na execução de ECF_DownloadMFD.'+sLineBreak+
                            'Arquivo: "'+NomeArquivo+'" não gerado' ))
end;

function TACBrECFSwedaSTX.GetDataHora: TDateTime;
Var RetCmd : AnsiString ;
    OldShortDateFormat : String ;
begin
  RetCmd := Trim(RetornaInfoECF( 'I8' )) ;
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yyyy' ;
     result := StrToDate(copy(RetCmd, 1,10)) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
  result := RecodeHour(  result,StrToInt(copy(RetCmd,12,2))) ;
  result := RecodeMinute(result,StrToInt(copy(RetCmd,15,2))) ;
  result := RecodeSecond(result,StrToInt(copy(RetCmd,18,2))) ;
end;

function TACBrECFSwedaSTX.GetNumCupom: String;
begin
   Result := Trim(copy( RetornaInfoECF( 'A4' ), 33, 6)) ;
end;

function TACBrECFSwedaSTX.GetNumCRO: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'A4' ), 1, 4)) ;
end;

function TACBrECFSwedaSTX.GetNumCCF: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'A4' ), 21, 6)) ;
end;

function TACBrECFSwedaSTX.GetNumLoja: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'H2' ), 1, 5)) ;
end;

function TACBrECFSwedaSTX.GetNumECF: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'H2' ), 6, 4)) ;
end;

function TACBrECFSwedaSTX.GetNumSerie: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'I1' ), 51, 22)) ;
end;

function TACBrECFSwedaSTX.GetNumSerieMFD: String;
begin
  Result := '' ;
  if fpMFD then
     Result := trim(copy(RetornaInfoECF( 'I32' ),3,21));
end;


function TACBrECFSwedaSTX.GetNumVersao: String ;
begin
  Result := Trim(copy( RetornaInfoECF( 'I1' ), 73, 9)) ;
end;

function TACBrECFSwedaSTX.GetTotalPago: Double;
begin
  Result := StrToFloatDef( Trim(copy( RetornaInfoECF( 'L1' ), 52, 13)),0)/100 ;
end;

function TACBrECFSwedaSTX.GetSubModeloECF: String;
begin
 Result :=trim(copy(RetornaInfoECF( 'I1' ),22,21));
end;


function TACBrECFSwedaSTX.GetSubTotal: Double;
begin
  Result := StrToFloatDef( Trim(copy( RetornaInfoECF( 'L1' ), 26, 13)),0)/100 ;
end;

{  Ordem de Retorno do Estado da Impressora
   estNaoInicializada - Não Inicializada (Nova)
   estDesconhecido    - Desconhecido
   estPagamento       - Cupom Venda Aberto em Pagamento
   estVenda           - Cupom Venda Aberto em Itens
   estNaoFiscal       - Cupom Não Fiscal Aberto
   estRelatorio       - Cupom Vinculado Aberto | Relatório Gerencial Aberto
   estBloqueada       - Impressora Bloqueada para venda
   estRequerZ         - Requer Emissão da Redução da Z
   estRequerX         - Requer Leitura X
   estLivre           - Livre para vender
}
function TACBrECFSwedaSTX.GetEstado: TACBrECFEstado;
Var RetCmd : AnsiString ;
    Estado, Docto : AnsiChar ;
    Sinalizadores : AnsiString ;
    B : Integer ;
begin
  Result := fpEstado ;  // Suprimir Warning
  try
    fpEstado := estNaoInicializada ;
    if (not fpAtivo) then
      exit ;

    fpEstado := estDesconhecido ;

    RetCmd := EnviaComando( '34' ) ;
    if (copy(RetCmd,3,2) <> '34') or (Length(RetCmd) < 18) then
       exit ;         // Retorno inválido

    Estado := RetCmd[10] ;
    Docto  := RetCmd[11] ;
    Sinalizadores := copy(RetCmd,12,5) ;

    case Estado of
      'A' :
        begin
          case Docto of
             'A' :
               begin
//               if TestBit( Ord(Sinalizadores[1]), 1 ) then
//                  fpEstado := estRequerX
//               else
                   fpEstado := estLivre ;
               end ;

             'C' :
               begin
                 B := Ord( Sinalizadores[2] ) ;
                 if TestBit( B, 5 )  then
                   fpEstado := estPagamento
                 else if TestBit( B, 4 )  then
                   fpEstado := estVenda ;
               end ;

             'D' : fpEstado := estNaoFiscal ;

             'E','G','I' : fpEstado := estRelatorio ;
          end ;
        end ;

      'B' : fpEstado := estBloqueada ;

      'C' : fpEstado := estRequerZ ;
    end ;
  finally
    Result := fpEstado ;
  end ;
end;

function TACBrECFSwedaSTX.GetGavetaAberta: Boolean;
Var RetCmd : AnsiString ;
   B : Integer ;
begin
  Result := False ;
  RetCmd := EnviaComando( '34' ) ;
  if (copy(RetCmd,3,2) = '34') and (Length(RetCmd) >= 12) then
  begin
     B := Ord(RetCmd[12]) ;
     Result := TestBit( B , 2 ) ;
  end ;
end;

function TACBrECFSwedaSTX.GetPoucoPapel: Boolean;
Var RetCmd : AnsiString ;
   B : Integer ;
begin
  Result := False ;
  RetCmd := EnviaComando( '34' ) ;
  if (copy(RetCmd,3,2) = '34') and (Length(RetCmd) >= 12) then
  begin
     B := Ord(RetCmd[12]) ;
     Result := TestBit( B , 5 ) ;
  end ;
end;

function TACBrECFSwedaSTX.GetHorarioVerao: Boolean;
Var RetCmd : AnsiString ;
begin
  RetCmd := Trim(RetornaInfoECF( 'I8' )) ;
  Result := (UpperCase( copy(RetCmd,20,1) ) = 'V') ;
end;

function TACBrECFSwedaSTX.GetArredonda: Boolean;
begin
  Result := (fsVerProtocolo > 'D') ;
end;

Procedure TACBrECFSwedaSTX.LeituraX ;
begin
  AguardaImpressao := True ;
  EnviaComando( '15' ) ;
end;

procedure TACBrECFSwedaSTX.LeituraXSerial(Linhas: TStringList);
 Var RetCmd : AnsiString ;
begin
  RetCmd := EnviaComando('15|TXT|CPWIN') ;
  Linhas.Text := ExtraiRetornoLeituras( RetCmd ) ;
end;

Procedure TACBrECFSwedaSTX.AbreGaveta ;
begin
  EnviaComando( '11' ) ;
end;

Procedure TACBrECFSwedaSTX.ReducaoZ(DataHora: TDateTime) ;
Var Cmd : String ;
begin
  Cmd := '16' ;
  if DataHora <> 0 then
     Cmd := Cmd + '|' + FormatDateTime('dd"/"mm"/"yyyy',DataHora) +
                  '|' + FormatDateTime('hh":"nn":"ss',DataHora) ;

  AguardaImpressao := True ;
  EnviaComando(Cmd,30) ;
end;

Procedure TACBrECFSwedaSTX.MudaHorarioVerao ;
begin
   MudaHorarioVerao(not HorarioVerao)
end;

procedure TACBrECFSwedaSTX.MudaHorarioVerao(EHorarioVerao: Boolean);
var
   cmd:String;
begin
   if EHorarioVerao then
      cmd := 'S'
   else cmd := 'N';
   EnviaComando('35|'+cmd);
end;


procedure TACBrECFSwedaSTX.NaoFiscalCompleto(CodCNF: String; Valor: Double;
  CodFormaPagto: String; Obs: AnsiString; IndiceBMP: Integer);
begin
   { Chama rotinas da classe Pai (fpOwner) para atualizar os Memos }
   with TACBrECF(fpOwner) do
   begin
      AbreNaoFiscal ;
      try
         RegistraItemNaoFiscal(CodCNF, Valor);
         try
            SubtotalizaNaoFiscal(0);
            EfetuaPagamentoNaoFiscal(CodFormaPagto, Valor );
         except
         end ;
         FechaNaoFiscal( Obs, IndiceBMP );
      except
         try
            CancelaNaoFiscal
         except
         end;

         raise ;
      end ;
   end ;
end;

procedure TACBrECFSwedaSTX.AbreCupom  ;
begin
  if Trim(Consumidor.Documento) <> '' then    { Tem Docto ? }
  begin
     EnviaComando('12|'+LeftStr(Consumidor.Documento ,20)+'|'+
                        LeftStr(Consumidor.Nome      ,30)+'|'+
                        LeftStr(Consumidor.Endereco  ,79)+'|0') ;
     Consumidor.Enviado := True ;
  end ;

  fpUltimaMsgPoucoPapel := 0 ;  { Zera tempo pra msg de pouco papel }
  AguardaImpressao := True ;
  EnviaComando( '01' ) ;
end;

procedure TACBrECFSwedaSTX.CancelaCupom;
var
   sVinculado:String;
   iVinculados:Integer;
   I:Integer;
begin
  try
    FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (só por garantia)}
  except   // Exceçao silenciosa, pois a Impressora pode nao estar em Estado
  end ;    // de Relatorio.
  //Procurar por CCDs em aberto para Estorna-los
  sVinculado :=  RetornaInfoECF('L8');
  {Verifica se tem vinculado}
  iVinculados := StrToIntDef(Copy(sVinculado,3,2),0);
   if iVinculados > 0 then
  begin
     {Extorna todos comprovantes}
     for I := 1 to iVinculados do
     begin
        try
           {garante o fechamento do cdc}
           FechaCupom;
        except
        end;               
        EnviaComando('52',30);
        FechaCupom();
     end;
  end;
  EnviaComando('08') ;
end;

procedure TACBrECFSwedaSTX.CancelaItemVendido(NumItem: Integer);
begin
  EnviaComando( '05|' + IntToStr(NumItem) ) ;
end;

procedure TACBrECFSwedaSTX.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
  EnviaComando( '06|' + CodFormaPagto +'|'+AjustaValor(Valor)+'|'+
                LeftStr(Observacao,84) ) ;
end;

procedure TACBrECFSwedaSTX.FechaCupom(Observacao: AnsiString; IndiceBMP : Integer);
begin
  AguardaImpressao := True ;
  EnviaComando( '07|' + LeftStr( Observacao,800) ) ;
end;


procedure TACBrECFSwedaSTX.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : AnsiString);
 Var Cmd : String ;
begin
  Cmd := '' ;
  if DescontoAcrescimo < 0 then
     Cmd := '55'
  else if DescontoAcrescimo > 0 then
     Cmd := '54' ;

  if Cmd <> '' then
     EnviaComando( Cmd+'|'+AjustaValor( Abs(DescontoAcrescimo) )) ;

  EnviaComando('64') ;  // Totalização
end;

Procedure TACBrECFSwedaSTX.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
var
   Aliquota : TACBrECFAliquota;
   IAT:String;
begin
  if Qtd > 9999 then
     raise EACBrECFCMDInvalido.Create( ACBrStr(
           'Quantidade deve ser inferior a 9999.'));

  {Usa o arredondamento por item }
  if ArredondaItemMFD then
     IAT := 'A'
  else
     IAT := 'T';
 {Vai vir o indice, tem que transformar em aliquota no formato Tipo + Aliquota}
  if (AliquotaECF[1] <> 'I') and
     (AliquotaECF[1] <> 'F') and
     (AliquotaECF[1] <> 'N') then
  begin
     {Formato tem que ser T18,00% por exemplo}
     Aliquota := AchaICMSIndice(AliquotaECF);
     AliquotaECF := FormatFloat(Aliquota.Tipo+'00.00%',Aliquota.Aliquota);
  end;

  EnviaComando('02|' + AjustaValor(Qtd,fpDecimaisQtd)              +'|'+
                       Trim(LeftStr(Codigo,14))                    +'|'+
                       AjustaValor(ValorUnitario, fpDecimaisPreco) +'|'+
                       Trim(LeftStr(Unidade,2))                    +'|'+
                       AliquotaECF                                 +'|'+
                       Trim(LeftStr(Descricao,33))                 +'|'+
                       IAT
                       );

  if ValorDescontoAcrescimo > 0 then
     DescontoAcrescimoItemAnterior( ValorDescontoAcrescimo, DescontoAcrescimo,
        TipoDescontoAcrescimo );
end;

procedure TACBrECFSwedaSTX.DescontoAcrescimoItemAnterior(
   ValorDescontoAcrescimo : Double ; DescontoAcrescimo : String;
   TipoDescontoAcrescimo : String; NumItem : Integer) ;
var
   CMD : String ;
begin
  CMD := ifthen(DescontoAcrescimo = 'A','03','04') + '|' +
         AjustaValor(ValorDescontoAcrescimo) ;

  if TipoDescontoAcrescimo = '%' then
     CMD := CMD + '%' ;

  if NumItem > 0 then
     CMD := CMD + '|' +IntToStr(NumItem);

  EnviaComando( CMD ) ;
end ;

procedure TACBrECFSwedaSTX.CarregaAliquotas;
var
   RetCMD:String;
   Aliquota : TACBrECFAliquota ;
   iAliquotas:Integer;
   I:Integer;
begin

   RetCMD := RetornaInfoECF('D4');
   inherited CarregaAliquotas;
   {ICMS}
   RetCMD := RemoveNulos(RetCMD);
   iAliquotas := Trunc(Length(RetCMD)/4);
   for I := 1 to iAliquotas do
   begin
      Aliquota := TACBrECFAliquota.create;
      Aliquota.Sequencia := I;
      Aliquota.Indice := FormatFloat('T00',I);
      Aliquota.Aliquota := StrToFloatDef(Copy(RetCMD,(I*4)-3,4),0)/100;
      fpAliquotas.Add(Aliquota);
   end;
   {ISS}
   RetCMD := RetornaInfoECF('E4');
   RetCMD := RemoveNulos(RetCMD);
   iAliquotas := Trunc(Length(RetCMD)/4);
   for I := 1 to iAliquotas do
   begin
      Aliquota := TACBrECFAliquota.create;
      Aliquota.Sequencia := I;
      Aliquota.Indice := FormatFloat('S00',I);
      Aliquota.Tipo := 'S';
      Aliquota.Aliquota := StrToFloatDef(Copy(RetCMD,(I*4)-3,4),0)/100;
      fpAliquotas.Add(Aliquota);
   end;

end;

procedure TACBrECFSwedaSTX.LerTotaisAliquota;
var
   I:Integer;
   RetCMD:String;
begin
    if not Assigned(fpAliquotas) then
    begin
       CarregaAliquotas;
    end;

    RetCMD := RetornaInfoECF('D2');
    RetCMD := RemoveNulos(RetCMD);

    for I := 0 to fpAliquotas.Count - 1 do
    begin
       fpAliquotas[I].Total:=StrToFloatDef(Copy(RetCMD,((I+1)*13)-12,13),0)/100;
    end;

end;


procedure TACBrECFSwedaSTX.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
var
   sAliquota:String;
begin
   sAliquota := FormatFloat(Tipo+'00.00',Aliquota);
   {Nesse protocolo não é necessário a posição :) }
   EnviaComando('32|'+sAliquota);
end;

function TACBrECFSwedaSTX.AchaICMSAliquota( var AliquotaICMS: String):
   TACBrECFAliquota;
Var AliquotaStr : String ;
begin
   Result      := nil ;
   AliquotaStr := '';

  AliquotaICMS := UpperCase( Trim( AliquotaICMS ) ) ;
  case AliquotaICMS[1] of
    'I' : AliquotaStr  := 'I1' ;
    'N' : AliquotaStr  := 'N1' ;
    'F' : AliquotaStr  := 'F1' ;
    'T' : AliquotaICMS := 'T'+AliquotaICMS; {Indice}
    'S' : {ISSQN}
        begin
           case AliquotaICMS[2] of
              'I':AliquotaStr := 'IS1';
              'N':AliquotaStr := 'NS1';
              'F':AliquotaStr := 'FS1';
           else AliquotaICMS  := 'T'+AliquotaICMS;
           end
        end;
  end;

  if AliquotaStr = '' then
     Result := inherited AchaICMSAliquota( AliquotaICMS )
  else
     AliquotaICMS := AliquotaStr ;

end;

procedure TACBrECFSwedaSTX.CarregaFormasPagamento;  { funçao Lenta +- 3 sec. }
var
   sDenominador :String;
   I:Integer;
   FPagto : TACBrECFFormaPagamento ;
   iFormasPagto:integer;
   sVinculados:String;
begin
   {Inicializa o objeto FpFormasPagamento}
   inherited CarregaFormasPagamento;
   sDenominador := RetornaInfoECF('B4');
   sVinculados := RetornaInfoECF('B2');

   {Retirar os #0, o stringReplace não funciona nesse caso }
   sDenominador := RemoveNulos(sDenominador);
   {São 20 formas de pagamento no máximo de 21 caracteres}
   iFormasPagto := Trunc(Length(sDenominador)/21);
   for I := 1 to iFormasPagto do
   begin
      FPagto := TACBrECFFormaPagamento.create;
      FPagto.Indice := FormatFloat('00',I);
      FPagto.Descricao := Copy(sDenominador,(I*21)-20,21);
      {Se for vinculado, o valor vai ser igual a 2}
      FPagto.PermiteVinculado := sVinculados[I] = '2';
      fpFormasPagamentos.Add(FPagto);
   end;
end;

procedure TACBrECFSwedaSTX.CarregaRelatoriosGerenciais;
var
   sDenominacoes:String;
   sCRE:String;
   iRelGerenciais:Integer;
   I:integer;
   RG  : TACBrECFRelatorioGerencial ;
begin
   inherited CarregaRelatoriosGerenciais ;
   sDenominacoes := RetornaInfoECF('F1');
   sDenominacoes := RemoveNulos(sDenominacoes);

   sCRE := RetornaInfoECF('F2');
   sCRE := RemoveNulos(sCRE);

   iRelGerenciais := Trunc(Length(sDenominacoes)/26);
   for I := 1 to iRelGerenciais do
   begin
      RG := TACBrECFRelatorioGerencial.create;
      RG.Indice := FormatFloat('00',I);
      RG.Descricao := Copy(sDenominacoes,(I*26)-25,25);
      RG.Contador := StrToIntDef(Copy(sCRE,(I*4)-3,4),0);
      fpRelatoriosGerenciais.Add(RG);
   end;
end;

procedure TACBrECFSwedaSTX.LerTotaisRelatoriosGerenciais ;
begin
  CarregaRelatoriosGerenciais;
end ;

procedure TACBrECFSwedaSTX.LerTotaisFormaPagamento;
var
   sTotalizador:String;
   I:Integer;
begin
   if not Assigned(fpFormasPagamentos) then
      CarregaFormasPagamento;

   sTotalizador := RetornaInfoECF('B8');
  {Retirar os #0, o stringReplace não funciona nesse caso }
   sTotalizador := RemoveNulos(sTotalizador);

   for I := 0 to fpFormasPagamentos.Count -1 do
   begin
      fpFormasPagamentos[I].Total := StrToFloatDef(
                                     Copy(sTotalizador,((I+1)*13)-12,13),0)/100;
   end;
end;


procedure TACBrECFSwedaSTX.ProgramaFormaPagamento( var Descricao: String;
  PermiteVinculado : Boolean; Posicao : String) ;
var
   sClassificacao:String;
begin
   { Parametros possíveis:
     0 - Não classificada
     1 - Moeda
     2 - Cartão de crédito ou débito
     3 - Ticket - Contra Vale
     4 - Cheque
   }
   sClassificacao := '0';
   if PermiteVinculado then
      sClassificacao := '2';
   EnviaComando('36|'+sClassificacao+'|'+Descricao);
end;

procedure TACBrECFSwedaSTX.ProgramaRelatorioGerencial( var Descricao: String; Posicao: String);
begin
   EnviaComando('42|'+Descricao);
end;

procedure TACBrECFSwedaSTX.CarregaComprovantesNaoFiscais;
var
   sDenominadores:String;
   iDenominadores:Integer;{Quantos CNFs existem}
   I:Integer;
   CNF:TACBrECFComprovanteNaoFiscal;
begin
   sDenominadores := RetornaInfoECF('C4');
   sDenominadores := RemoveNulos(sDenominadores);
   iDenominadores := Trunc(Length(sDenominadores)/20);

   inherited CarregaComprovantesNaoFiscais;
   for I := 1 to iDenominadores do
   begin
      CNF := TACBrECFComprovanteNaoFiscal.create;
      CNF.Indice := FormatFloat('00',I);
      CNF.Descricao :=Copy(sDenominadores,(I*20)-18,19);
      fpComprovantesNaoFiscais.Add(CNF);
   end;
end;

procedure TACBrECFSwedaSTX.LerTotaisComprovanteNaoFiscal;
var
   sTotais:String;
   sCon:String;
   I:Integer;
begin
   if not Assigned(fpComprovantesNaoFiscais) then
      CarregaComprovantesNaoFiscais;
   sTotais := RetornaInfoECF('C2');
   sCon := RetornaInfoECF('C8');
   for I := 0 to fpComprovantesNaoFiscais.Count - 1 do
   begin
      fpComprovantesNaoFiscais[i].Total := StrToFloatDef(
                                           Copy(sTotais,((I+1)*13)-12,13),0)/100;
      fpComprovantesNaoFiscais[I].Contador:= StrToIntDef(
                                            Copy(sCon,((I+1)*4)-3,4),0);
   end;
end;

procedure TACBrECFSwedaSTX.ProgramaComprovanteNaoFiscal(var Descricao : String;
   Tipo: String; Posicao : String);
begin
{
Argumento(s): sinal:
Ascii Dec Sinal
  +   43   Positivo
  -   45   Negativo
Opcional, se omitido é assumido o valor padrão do sinal: +
operação Denominação da operação não-fiscal.
Alfanumérico - Extensão máxima: 15 caracteres
Poderão ser cadastradas, em um único comando, um conjunto de até 30 operações.

   Nota(s): Operações com sinal negativo não admitem os seguintes registros:
   - Pagamento;
   - Identificação do consumidor;
   - Acréscimo;
   - Desconto.
}
   EnviaComando('37|'+Tipo+Descricao);
end;


procedure TACBrECFSwedaSTX.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
var
   Moeda,Moedas:String;
   sValor:String;
   sData:String;
begin
  {Apesar de implementadao, não foi possível testar essa rotina por falta de
   equipamento que tivesse o recurso}
   Banco      := IntToStrZero(StrToIntDef(Banco,1),3) ;
   Favorecido := padL(Favorecido,80) ;
   Cidade     := padL(Cidade,30) ;
   Moeda      := padL('Real',20) ;
   Moedas     := padL('Reais',20) ;
   sValor     := FormatFloat('#0.00',Valor);
   sData      := FormatDateTime('MM-DD-yyyy',Data);
   EnviaComando('14|'+Banco+'|'+sValor+'|'+Moeda+'|'+Moedas+'|'+Favorecido+
                '|'+Cidade+'|'+sData);
end;

procedure TACBrECFSwedaSTX.CancelaImpressaoCheque;
begin
   EnviaComando('47');
end;

function TACBrECFSwedaSTX.GetChequePronto: Boolean;
begin
   {Não existe comando que implemente esse método}
   Result := True;
end;

function TACBrECFSwedaSTX.GetParamDescontoISSQN : Boolean ;
var
   RetCmd : AnsiString ;
begin
  RetCmd := RetornaInfoECF( 'H2' ) ;
  Result := (copy(RetCmd, 13, 1) = 'S') ;
end ;

procedure TACBrECFSwedaSTX.AbreRelatorioGerencial(Indice: Integer = 2 );
var
   sDescricao:String;
   RG:TACBrECFRelatorioGerencial;
begin
   { Não existe indice 0 nessa impressora usando esse protocolo}
   { O indice 1 é reservado }
   if ( Indice = 0 ) or ( Indice = 1 ) then
      Indice := 2;


   RG := AchaRGIndice(FormatFloat('00',Indice));
   if RG = nil then
     raise Exception.create( ACBrStr('Relatório Gerencial: '+IntToStr(Indice)+
                                 ' não foi cadastrado.' ));
   sDescricao := PadL(RG.Descricao,15);
   AguardaImpressao := True;
   EnviaComando('43|'+sDescricao);
end;

procedure TACBrECFSwedaSTX.LinhaRelatorioGerencial(Linha: AnsiString; IndiceBMP: Integer);
Var P, Espera : Integer ;
    Buffer : AnsiString ;
    MaxChars : Integer ;
begin

  Linha := AjustaLinhas( Linha, Colunas );  { Formata as Linhas de acordo com "Coluna" }
  MaxChars := 1190 ;  { Sweda aceita no máximo 1190 caract. por comando }

  if not fpTermica then   { Se não é Termica, Imprime Linha a Linha }
     ImprimirLinhaALinha( Linha, '25|' )
  else
     while Length( Linha ) > 0 do
     begin
        P := Length( Linha ) ;
        if P > MaxChars then    { Acha o fim de Linha mais próximo do limite máximo }
           P := PosLast(#10, LeftStr(Linha,MaxChars) ) ;

        if P = 0 then
           P := Colunas ;

        Buffer := copy( Linha, 1, P)  ;
        Espera := Trunc( CountStr( Buffer, #10 ) / 4) ;

        AguardaImpressao := (Espera > 3) ;
        EnviaComando( '25|' + Buffer, Espera ) ;

        { ficou apenas um LF sozinho ? }
        if (P = Colunas) and (RightStr( Buffer, 1) <> #10) and
           (copy( Linha, P+1, 1) = #10) then
           P := P + 1 ;

        Linha  := copy( Linha, P+1, Length(Linha) ) ;   // O Restante
     end ;
end;

procedure TACBrECFSwedaSTX.LoadDLLFunctions;
 procedure SwedaFunctionDetect( FuncName: String; var LibPointer: Pointer ) ;
 var
 sLibName: string;
 begin
   if not Assigned( LibPointer )  then
   begin
     // Verifica se exite o caminho das DLLs
     if Length(PathDLL) > 0 then
        sLibName := PathWithDelim(PathDLL);

     // Concatena o caminho se exitir mais o nome da DLL.
     sLibName := sLibName + cLIB_Sweda;

     if not FunctionDetect( sLibName, FuncName, LibPointer) then
     begin
        LibPointer := NIL ;
        raise Exception.Create( ACBrStr( 'Erro ao carregar a função:'+FuncName+' de: '+cLIB_Sweda ) ) ;
     end ;
   end ;
 end ;
begin
   {$IFDEF MSWINDOWS}
    if not fileexists(IncludeTrailingPathDelimiter(ExtractFilePath(
      {$IFNDEF CONSOLE} Application.ExeName {$ELSE} ParamStr(0) {$ENDIF})) + 'Swmfd.dll') then
       raise Exception.Create( ACBrStr( 'Não foi encontrada a dll auxiliar Swmfd.dll.' ) ) ;
   {$ENDIF}
   DeleteFile(IncludeTrailingPathDelimiter(ExtractFilePath(
      {$IFNDEF CONSOLE} Application.ExeName {$ELSE} ParamStr(0) {$ENDIF})) + 'SWC.INI');
   SwedaFunctionDetect('ECF_AbrePortaSerial', @xECF_AbrePortaSerial);
   SwedaFunctionDetect('ECF_DownloadMFD', @xECF_DownloadMFD);
   SwedaFunctionDetect('ECF_ReproduzirMemoriaFiscalMFD', @xECF_ReproduzirMemoriaFiscalMFD);
   SwedaFunctionDetect('ECF_FechaPortaSerial', @xECF_FechaPortaSerial);
   SwedaFunctionDetect('ECF_DownloadMF',@xECF_DownloadMF);
end ;


procedure TACBrECFSwedaSTX.AbreCupomVinculado(COO, CodFormaPagto,
   CodComprovanteNaoFiscal :  String; Valor : Double ) ;
var
   sValor:String;
begin
   sValor := FormatFloat('#0.00',Valor);
   EnviaComando('50|'+CodFormaPagto+'|'+sValor);
end;

procedure TACBrECFSwedaSTX.LinhaCupomVinculado(Linha: AnsiString);
begin
   EnviaComando('25|'+Linha);
end;

procedure TACBrECFSwedaSTX.FechaRelatorio;
begin
   if Estado = estRelatorio then
      FechaCupom();
end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal : Integer; Simplificada : Boolean);
var
   sSimplificada:String ;
begin
   sSimplificada := 'C';
   if Simplificada then
      sSimplificada := 'S';

   EnviaComando('17|'+IntToStr(ReducaoInicial)+'|'
                     +IntToStr(ReducaoFinal)
                     +'|'+sSimplificada);
end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime; Simplificada : Boolean);
var
   sDataInicial:String;
   sDataFinal:String;
   sSimplificada:String;
begin
   sSimplificada := 'C';
   if Simplificada then
      sSimplificada := 'S';
   sDataInicial := FormatDateTime('dd"/"mm"/"yyyy',DataInicial);
   sDataFinal := FormatDateTime('dd"/"mm"/"yyyy',DataFinal);
   AguardaImpressao := True ;
   EnviaComando('18|'+sDataInicial+'|'+sDataFinal+'|'+sSimplificada);
end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; Linhas : TStringList; Simplificada : Boolean);
var
   sSimplificada:String;
   Espera:Integer;
   RetCmd : AnsiString ;
begin
   Espera := Trunc(30 + ((ReducaoFinal - ReducaoInicial)/2) );
   sSimplificada := 'C';
   if Simplificada then
      sSimplificada := 'S';

   RetCmd := EnviaComando('17|'+IntToStr(ReducaoInicial)+'|'+IntToStr(ReducaoFinal)+'|'+
                          sSimplificada+'|TXT|'+'CPWIN',Espera);
   Linhas.Text := ExtraiRetornoLeituras( RetCmd ) ;
end;

procedure TACBrECFSwedaSTX.LeituraMFDSerial(DataInicial, DataFinal: TDateTime;
  Linhas: TStringList; Documentos: TACBrECFTipoDocumentoSet);
var
   sDataInicial:String;
   sDataFinal:String;
   Espera:Integer;
   RetCmd : AnsiString ;
begin
    Espera := Trunc(30 + (DaysBetween(DataInicial,DataFinal)/2) ) ;
   sDataInicial := FormatDateTime('dd"/"mm"/"yyyy',DataInicial);
   sDataFinal   := FormatDateTime('dd"/"mm"/"yyyy',DataFinal);
   RetCmd       := EnviaComando('45|'+sDataInicial+'|'+sDataFinal+'|TXT|'
                                 +'CPWIN',Espera);
   Linhas.Text  := ExtraiRetornoLeituras( RetCmd );
end;

procedure TACBrECFSwedaSTX.LeituraMFDSerial(COOInicial, COOFinal: Integer;
  Linhas: TStringList; Documentos: TACBrECFTipoDocumentoSet);
var
   Espera:Integer;
   RetCmd : AnsiString ;
begin
   Espera := Trunc(30 + ((COOFinal - COOInicial)/2) );
   RetCmd := EnviaComando('44|'+IntToStr(COOInicial)+'|'+IntToStr(COOFinal)+
                          '||TXT|'+'CPWIN',Espera);
   Linhas.Text  := ExtraiRetornoLeituras( RetCmd );
end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; Linhas : TStringList; Simplificada : Boolean);
var
   Espera:Integer;
   sDataInicial:String;
   sDataFinal:String;
   sSimplificada:String;
   RetCmd : AnsiString ;
begin
   sSimplificada := 'C';
   if Simplificada then
      sSimplificada := 'S';

   Espera := Trunc(30 + (DaysBetween(DataInicial,DataFinal)/2) );
   sDataInicial := FormatDateTime('dd"/"mm"/"yyyy',DataInicial);
   sDataFinal   := FormatDateTime('dd"/"mm"/"yyyy',DataFinal);
   RetCmd       := EnviaComando('18|'+sDataInicial+'|'+sDataFinal+'|'+
                                sSimplificada+'|TXT|'+'|CPWIN',Espera);
   Linhas.Text := ExtraiRetornoLeituras( RetCmd ) ;
end;

function TACBrECFSwedaSTX.GetCNPJ: String;
var
   RetCMD:String;
begin
   RetCMD := RetornaInfoECF('G64');
   Result := Copy(RemoveNulos(RetCMD),3,21);
end;

function TACBrECFSwedaSTX.GetIE: String;
var
   RetCMD:String;
begin
   RetCMD := RetornaInfoECF('G64');
   RetCMD := RemoveNulos(RetCMD);
   Result := Copy(RetCMD,21,21);
end;

function TACBrECFSwedaSTX.GetIM: String;
var
   RetCMD:String;
begin
   RetCMD := RetornaInfoECF('G64');
   Result := Copy(RemoveNulos(RetCMD),42,21);
end;

function TACBrECFSwedaSTX.GetCliche: AnsiString;
var
   RetCMD : AnsiString;
begin
   RetCMD := RetornaInfoECF('H4');
   Result := RemoveNulos(RetCMD);
end;

function TACBrECFSwedaSTX.GetUsuarioAtual: String;
 var
   RetCMD : AnsiString;
begin
  Result := '';
   RetCMD := RetornaInfoECF('I32');
   Result := copy(RemoveNulos(RetCMD),1,2);
end;


function TACBrECFSwedaSTX.GetDataMovimento: TDateTime;
 Var
  RetCmd : AnsiString ;
  OldShortDateFormat: AnsiString;
  sData:String;
begin
   Result := Date;
   RetCmd := Trim(RetornaInfoECF('A2'));
   OldShortDateFormat := ShortDateFormat ;
   try
      sData := Copy(RetCmd,22,10);
      ShortDateFormat := 'dd/mm/yy' ;
      Result := StrToDate(sData);
   finally
      ShortDateFormat := OldShortDateFormat ;
   end ;
end;

function TACBrECFSwedaSTX.GetGrandeTotal: Double;
var
   RetCMD : AnsiString;
begin
   RetCMD := Trim(RetornaInfoECF('A1'));
   Result := StrToFloatDef(Copy(RetCMD,1,18),0)/100;
end;

function TACBrECFSwedaSTX.GetNumCRZ: String;
var
   RetCMD:String;
begin
   RetCMD := Trim(RetornaInfoECF('A4'));
   Result := Copy(RetCMD,5,4);
end;

function TACBrECFSwedaSTX.GetTotalAcrescimos: Double;
var
   RetCMD:String;
begin
   RetCMD := Trim(RetornaInfoECF('D1'));
   Result := StrToFloatDef(Copy(RetCMD,1,13),0)/100;
end;

function TACBrECFSwedaSTX.GetTotalCancelamentos: Double;
var
   RetCMD:String;
begin
   RetCMD := Trim(RetornaInfoECF('D1'));
   Result := StrToFloatDef(Copy(RetCMD,27,13),0)/100;
end;

function TACBrECFSwedaSTX.GetTotalDescontos: Double;
var
   RetCMD:String;
begin
   RetCMD := Trim(RetornaInfoECF('D1'));
   Result := StrToFloatDef(Copy(RetCMD,14,13),0)/100;
end;

function TACBrECFSwedaSTX.GetTotalIsencao: Double;
var
   I1:Double;
   I2:Double;
   I3:Double;
   RetCMD:String;
begin
   RetCMD := Trim(RetornaInfoECF('D1'));
   I1:= StrToFloatDef(Copy(RetCMD,118,13),0)/100;
   I2:= StrToFloatDef(Copy(RetCMD,131,13),0)/100;
   I3:= StrToFloatDef(Copy(RetCMD,144,13),0)/100;
   Result := I1+I2+I3;
end;

function TACBrECFSwedaSTX.GetTotalNaoTributado: Double;
var
   RetCMD :String;
   N1:Double;
   N2:Double;
   N3:Double;
begin
   RetCMD := Trim(RetornaInfoECF('D1'));
   N1 := StrToFloatDef(Copy(RetCMD,79,13),0)/100;
   N2 := StrToFloatDef(Copy(RetCMD,92,13),0)/100;
   N3 := StrToFloatDef(Copy(RetCMD,105,13),0)/100;
   Result := N1+N2+N3;
end;

function TACBrECFSwedaSTX.GetTotalSubstituicaoTributaria: Double;
var
   RetCMD :String;
   F1:Double;
   F2:Double;
   F3:Double;
begin
   RetCMD := Trim(RetornaInfoECF('D1'));
   F1 := StrToFloatDef(Copy(RetCMD,40,13),0)/100;
   F2 := StrToFloatDef(Copy(RetCMD,53,13),0)/100;
   F3 := StrToFloatDef(Copy(RetCMD,66,13),0)/100;
   Result := F1+F2+F3;

end;

function TACBrECFSwedaSTX.GetNumUltimoItem: Integer;
var
   RetCMD :String;
begin
   RetCMD := Trim(RetornaInfoECF('L2'));
   Result := StrToIntDef(Copy(RetCMD,1,4),0);
end;

function TACBrECFSwedaSTX.GetVendaBruta: Double;
var
   RetCMD :String;
begin
   RetCMD := Trim(RetornaInfoECF('A1'));
   Result := StrToFloatDef(Copy(RetCMD,33,14),0)/100;
end;

function TACBrECFSwedaSTX.GetNumCOOInicial: String;
var
   RetCMD :String;
begin
   {Comando suportado apenas a partir da versão 01.00.04}
   RetCMD := RemoveNulos(EnviaComando('65|0000'));//retorna dados do movimento atual
   {Remove a primeira parte da string (#2'265+0000AA˜€’€€)}
   RetCMD := Copy(RetCMD,17,length(RetCMD));
   Result := Copy(RetCMD,210,6);
end ;

procedure TACBrECFSwedaSTX.AbreNaoFiscal( CPF_CNPJ, Nome, Endereco: String );
begin
   EnviaComando('20');
end;

procedure TACBrECFSwedaSTX.AbrePortaSerialDLL;
begin
  { Nada a fazer (ainda) }
end;

procedure TACBrECFSwedaSTX.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: AnsiString = '');
var
   CNF : TACBrECFComprovanteNaoFiscal ;
   P:Integer;
   sDescricao:String;
begin
   P := StrToInt(CodCNF);
   CNF := AchaCNFIndice(IntToStrZero(P,2));
   if CNF = nil then
      raise Exception.Create('Indice não encontrado!');
   sDescricao :=CNF.Descricao;
//   {Remove o sinal da descrição}
//   sDescricao[1]:= ' ';
   EnviaComando('21|'+Trim(sDescricao)+'|'+FormatFloat('#0.00',Valor));
end;

function TACBrECFSwedaSTX.RemoveNulos(Str: AnsiString): AnsiString;
var
   I:Integer;
begin
   for I := 1 to Length(Str) do
   begin
      if Str[I]= #0 then
      begin
         Str[I] := ' ';
      end;
   end;
   {Remove o ETX e o checksum da resposta}
   Result := Copy(Str,1,Pos(ETX,Str)-1);
end;

procedure TACBrECFSwedaSTX.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
   EfetuaPagamento(CodFormaPagto,Valor,Observacao,ImprimeVinculado);
end;

procedure TACBrECFSwedaSTX.SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: AnsiString);
begin
   SubtotalizaCupom(DescontoAcrescimo,MensagemRodape);
end;

procedure TACBrECFSwedaSTX.FechaNaoFiscal(Observacao: AnsiString; IndiceBMP : Integer);
begin
   FechaCupom(Observacao,IndiceBMP);
end;

procedure TACBrECFSwedaSTX.CancelaNaoFiscal;
begin
   CancelaCupom;
end;

function TACBrECFSwedaSTX.GetDadosUltimaReducaoZ: AnsiString;
var
   RetCMD,sAliquota:String;
   I:Integer;
   V:Double;
   PosI:Integer;
begin
   {Comando suportado apenas a partir da versão 01.00.04}
   RetCMD := RemoveNulos(EnviaComando('65|9999' ));//retorna dados do movimento atual
   {Remove a primeira parte da string (#2'265+0000AA˜€’€€)}
   RetCMD := Copy(RetCMD,17,length(RetCMD));

   Result := '[ECF]'+sLineBreak;
   Result := Result + 'DataMovimento = '+Copy(RetCMD,199,11) +sLineBreak ;
   Result := Result + 'NumSerie = ' + Copy(RetCMD,51,22) + sLineBreak;
   Result := Result + 'NumLoja = '+ NumLoja +sLineBreak;
   Result := Result + 'NumECF = '+ Copy(RetCMD,73,3) + sLineBreak;
   Result := Result + 'NumCOOInicial = '+ Copy(RetCMD,210,06) + sLineBreak ;
   Result := Result + 'NumCOO = '+ Copy(RetCMD,193,06) + sLineBreak ;
   Result := Result + 'NumCRZ = '+ Copy(RetCMD,168,04) + sLineBreak;
   Result := Result + 'NumCRO = '+ Copy(RetCMD,216,04) + sLineBreak;


   {Aliquotas}
   {As aliquotas são retornadas nesse comando, mas apenas se tiver valor }
   {Por isso percorro as aliquotas cadastradas no ECF para pegar todas}
   Result := Result + sLineBreak + '[Aliquotas]'+sLineBreak ;
    if not Assigned( fpAliquotas ) then
      LerTotaisAliquota ;

    for I := 0 to Aliquotas.Count - 1 do
    begin
       {Procura pela aliquota no formato Tnnnn na string}
       sAliquota := Aliquotas[I].Tipo+FormatFloat('00.00',Aliquotas[I].Aliquota);
       sAliquota := StringReplace(sAliquota,',','',[rfReplaceAll]);
       PosI := Pos(sAliquota,RetCMD);
       if PosI > 0 then
       begin
          V := StrToFloatDef(Copy(RetCMD,PosI+5,18),0)/100;
          Result := Result + padL(Aliquotas[I].Indice,2) +
                             sAliquota + ' = '+
                             FormatFloat('#0.00',V) + sLineBreak ;
       end
       else
       begin
          {Envia o valor zerado, pois não foi feito venda nessa aliquota}
          Result := Result + padL(Aliquotas[I].Indice,2) +
                             sAliquota + ' = '+
                             '0,00' + sLineBreak ;
       end;
    end;
    {Leitura das legendas - As legendas tem 5 caracteres + 18 de valores acumulados}
    {Exemplo: GT no arquivo está como 'GT   000000000000000000' Dúvidas consulte
    o manual da sweda stx pág 69 - Fernando Gutierres Damaceno}
    Result  := Result + sLineBreak + '[OutrasICMS]'+sLineBreak ;
    {Verifica se existe F1}
    PosI := Pos('F1   ',RetCMD);
    V := 0;
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {F1     }
       V  := StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    {Verifica se existe F2}
    PosI := Pos('F2   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {F2     }
       V  := V + StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    {Verifica se existe F3}
    PosI := Pos('F3   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {F3     }
       V  := V + StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    Result  := Result + 'TotalSubstituicaoTributaria = '+FormatFloat('#0.00',V)+sLineBreak;
    V := 0;

    {Verifica se existe não tributado}
    PosI := Pos('N1   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {N1     }
       V  :=  StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;

    PosI := Pos('N2   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {N2     }
       V  := V + StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;

    PosI := Pos('N3   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {N3     }
       V  := V + StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    Result := Result + 'TotalNaoTributado = '+FormatFloat('#0.00',V)+ sLineBreak;
    V:= 0;
   {Isentos}
    PosI := Pos('I1   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {N1     }
       V  := StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;

    PosI := Pos('I2   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {N1     }
       V  := V + StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;

    PosI := Pos('N3   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {N1     }
       V  := V + StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    Result := Result + 'TotalIsencao = '+FormatFloat('#0.00',V)+ sLineBreak;

    { A impressora não retorna as informações descriminadas }
    Result := Result + sLineBreak + '[Totalizadores]'+sLineBreak;
    V := 0 ;

    {Descontos ICMS}
    PosI := Pos('DT   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {DT     }
       V  := StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    {Descontos ISS}
    PosI := Pos('DS   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ; {DS    }
       V  := V + StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    Result := Result +'TotalDescontos = '+FormatFloat('#0.00',V)+ sLineBreak;
    V := 0 ;

    {Cancelamento  ISS}
    PosI := Pos('CS   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ;
       V  := StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    {Cancelamento  ICMS}
    PosI := Pos('CT   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ;
       V  := V + StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    Result := Result + 'TotalCancelamentos = '+FormatFloat('#0.00',V)+ sLineBreak;
    V := 0;

    {Acrescimo  ICMS}
    PosI := Pos('AT   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ;
       V  := StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    {Acrescimo  ISS}
    PosI := Pos('AS   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ;
       V  := V + StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    Result := Result + 'TotalAcrescimos = '+FormatFloat('#0.00',V)+ sLineBreak;
    V := 0;

    {Venda Bruta não fiscal}
    PosI := Pos('ON   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ;
       V  := StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    Result := Result + 'TotalNaoFiscal = ' + FormatFloat('#0.00',V)+ sLineBreak;
    V := 0;

    {Venda Bruta Diaria}
    PosI := Pos('VB   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ;
       V  := StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    Result := Result + 'VendaBruta = ' + FormatFloat('#0.00',V)+ sLineBreak;
    V := 0;

    {Grande Total}
    PosI := Pos('GT   ',RetCMD);
    if PosI > 0 then
    begin
       PosI := PosI + 5 ;
       V  := StrToFloatDef(Trim(Copy(RetCMD,PosI,18)),0)/100;
    end;
    Result := Result + 'GrandeTotal = '+FormatFloat('#0.00',V)+ sLineBreak;
end;

procedure TACBrECFSwedaSTX.CortaPapel(const CorteParcial: Boolean);
begin
   EnviaComando('62|0');
end;

procedure TACBrECFSwedaSTX.IdentificaOperador(Nome: String);
begin
   EnviaComando_ECF('56|'+Copy(Nome,1,20));
end;

procedure TACBrECFSwedaSTX.IdentificaPAF(Linha1, Linha2: String);
begin
   EnviaComando('39|D|'+padL(Linha1,42) + padL(Linha2,42));
end;

function TACBrECFSwedaSTX.GetPAF: String;
var
   RetCMD:String;
begin
   RetCMD :=  RetornaInfoECF('N2');
   Result := RemoveNulos(RetCMD);
end;

function TACBrECFSwedaSTX.GetNumCDC: String;
var
   RetCMD:String;
begin
   RetCMD:= RetornaInfoECF('A4');
   Result := Copy(RetCMD,39,4);
end;

function TACBrECFSwedaSTX.GetNumGNF: String;
var
   RetCMD:String;
begin
   RetCMD := RetornaInfoECF('A4');
   Result := Copy(RetCMD,9,6);
end;

function TACBrECFSwedaSTX.GetNumGRG: String;
var
   RetCMD:String;
begin
   RetCMD := RetornaInfoECF('A4');
   Result := Copy(RetCMD,15,6);
end;

function TACBrECFSwedaSTX.RetornaInfoECF(Registrador: String): AnsiString;
Var RetCmd : AnsiString ;
    I : Integer ;
    Info : TACBrECFSwedaInfo34 ;
begin
  I  := fsCache34.AchaSecao( Registrador ) ;
  if I >= 0 then
  begin
     Result := fsCache34[I].Dados ;
     exit ;
  end ;

  RetCmd := EnviaComando( '34|' + Registrador ) ;

  { Extraindo "DADOS" do bloco abaixo :
    STX[1]+Seq[1]+Tarefa[1]+Tipo[1]+Secao[4]+Dados[N]+ETX[1]+CHK[1] }
  if Copy(RetCmd,3,2) = '34' then
     Result := copy( RetCmd, 10, Length(RetCmd)-11 ) ;

  if pos('I8',Registrador) > 0 then  // Sem cache para Data/Hora
     exit ;

  { Adicionando resposta no Cache }
  Info := TACBrECFSwedaInfo34.create ;
  Info.Secao := Registrador ;
  Info.Dados := Result ;
  fsCache34.Add( Info ) ;
end;

function TACBrECFSwedaSTX.TraduzirTag(const ATag: AnsiString): AnsiString;
const
  INI = #22;
  OFF = INI + #175;

  // <e></e>
  cExpandidoOn   = INI + #171;
  cExpandidoOff  = OFF;

  // <n></n>
  cNegritoOn     = INI + #167;
  cNegritoOff    = OFF;

  // <s></s>
  cSublinhadoOn  = INI + #163;
  cSublinhadoOff = OFF;

  // <c></c>
  cCondensadoOn  = INI + #65;
  cCondensadoOff = OFF;

  //<i></i>
  cItalicoOn  = '';
  cITalicoOff = '';

begin

  case AnsiIndexText( ATag, ARRAY_TAGS) of
     -1: Result := ATag;
     2 : Result := cExpandidoOn;
     3 : Result := cExpandidoOff;
     4 : Result := cNegritoOn;
     5 : Result := cNegritoOff;
     6 : Result := cSublinhadoOn;
     7 : Result := cSublinhadoOff;
     8 : Result := cCondensadoOn;
     9 : Result := cCondensadoOff;
     10: Result := cItalicoOn;
     11: Result := cITalicoOff;
  else
     Result := '' ;
  end;

end;

{ TACBrECFSwedaInfo34A1 }
procedure TACBrECFSwedaInfo34A1.SetTotalizadorGeral(const Value: String);
begin
  FTotalizadorGeral := Value;
end;

procedure TACBrECFSwedaInfo34A1.SetVendaBrutaDiaria(const Value: String);
begin
  FVendaBrutaDiaria := Value;
end;

procedure TACBrECFSwedaInfo34A1.SetVendaLiquida(const Value: String);
begin
  FVendaLiquida := Value;
end;

end.

