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
|* 29/04/2007:  Daniel Simoes de Almeida
|*   Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFSCU ;

interface
uses ACBrECFClass, ACBrUtil, ACBrDevice,
     Classes ;

const  SOH = #01  ;
       ESC = #27  ;
       ACK = #06  ;

type

TACBrECFSCUComando = class
  private
    fsCMD    : Byte ;
    fsEXT    : Byte ;
    fsSEQ    : Byte ;
    fsParams : TStringList ;
    fsTimeOut: Integer;

    function GetComando: AnsiString;
    procedure SetCMD(const Value: Byte);
 public
    constructor create ;
    destructor destroy ; override ;

    property SEQ : Byte    read fsSEQ write fsSEQ ;
    property CMD : Byte    read fsCMD write SetCMD ;
    property EXT : Byte    read fsEXT write fsEXT ;
    property TimeOut : Integer read fsTimeOut write fsTimeOut ;

    property Comando : AnsiString  read GetComando ;
    property Params  : TStringList read fsParams ;

    Procedure AddParamString(AString : AnsiString) ;
    Procedure AddParamInteger(AInteger : Integer) ;
    Procedure AddParamDouble(ADouble : Double; Decimais: Byte) ;
    Procedure AddParamDateTime( ADateTime: TDateTime; Tipo : Char = 'D';
                                FlagHV : String = '' ) ;
 end ;

TACBrECFSCUResposta = class
  private
    fsResposta : AnsiString ;
    fsParams  : TStringList ;
    fsSEQ     : Byte ;
    fsCMD     : Byte ;
    fsEXT     : Byte ;
    fsCAT     : Byte ;
    fsRET     : Integer ;
    fsTBR     : Integer ;
    fsBRS     : AnsiString ;
    fsCHK     : Byte ;

    procedure SetResposta(const Value: AnsiString);
 public
    constructor create ;
    destructor destroy ; override ;

    property Resposta   : AnsiString  read fsResposta write SetResposta ;
    property Params     : TStringList read fsParams ;
    property SEQ        : Byte        read fsSEQ ;
    property CMD        : Byte        read fsCMD ;
    property EXT        : Byte        read fsEXT ;
    property CAT        : Byte        read fsCAT ;
    property RET        : Integer     read fsRET ;
    property TBR        : Integer     read fsTBR ;
    property BRS        : AnsiString  read fsBRS ;
    property CHK        : Byte        read fsCHK ;
 end ;


 { Classe filha de TACBrECFClass com implementaçao para SCU }
TACBrECFSCU = class( TACBrECFClass )
 private
    fsNumVersao   : String ;
    fsNumECF      : String ;
    fsNumCRO      : String ;
    fsSCUComando  : TACBrECFSCUComando;
    fsSCUResposta : TACBrECFSCUResposta;

    fsDecimaisPreco: Integer;
    fsDecimaisQtd  : Integer;

    function PreparaCmd(CmdExtBcd: AnsiString): AnsiString;
protected
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumECF: String; override ;
    function GetNumCRO: String; override ;
    function GetNumSerie: String; override ;
    function GetNumVersao: String; override ;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetHorarioVerao: Boolean; override ;

    function GetCNPJ: String; override ;
    function GetDataMovimento: TDateTime; override ;

    function GetNumCRZ: String; override ;
    function GetGrandeTotal: Double; override ;
    function GetVendaBruta: Double; override ;

    function GetTotalAcrescimos: Double; override ;
    function GetTotalCancelamentos: Double; override ;
    function GetTotalDescontos: Double; override ;
    function GetTotalSubstituicaoTributaria: Double; override ;
    function GetTotalNaoTributado: Double; override ;
    function GetTotalIsencao: Double; override ;

    function GetNumCOOInicial: String; override ;
    function GetNumUltimoItem: Integer; override ;

    Function VerificaFimLeitura(Retorno: AnsiString) : Boolean ; override ;
    function VerificaFimImpressao : Boolean ; override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;

    property SCUComando : TACBrECFSCUComando  read fsSCUComando ;
    property SCUResposta: TACBrECFSCUResposta read fsSCUResposta ;

    Property DecimaisPreco : Integer read fsDecimaisPreco ;
    Property DecimaisQtd   : Integer read fsDecimaisQtd   ;

    Function EnviaComando_ECF( cmd : AnsiString = '' ) : AnsiString ; override ;

    Procedure AbreCupom ; override ;
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; DescontoPorc : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo: String = '%') ; override ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : AnsiString  = '' ) ; override ;
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ;
       override ;
    Procedure FechaCupom( Observacao : AnsiString = '') ; override ;
    Procedure CancelaCupom ; override ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; override ;

    Procedure LeituraX ; override ;
    Procedure ReducaoZ(DataHora : TDateTime = 0 ) ; override ;
    Procedure AbreRelatorioGerencial ; override ;
    Procedure LinhaRelatorioGerencial( Linha : AnsiString ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : AnsiString ) ; override ;
    Procedure FechaRelatorio ; override ;


    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;

    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime ) ;
       override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer);
       override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       var Linhas : TStringList ) ; override ;
    Procedure LeituraMFDSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList ) ; overload ; override ;
    Procedure LeituraMFDSerial( COOInicial, COOFinal : Integer;
       var Linhas : TStringList ) ; overload ; override ;

    { Procedimentos de Cupom Não Fiscal }
    Procedure AbreNaoFiscal( CPF_CNPJ : String = '') ; override ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : AnsiString = '') ; override ;
    Procedure SubtotalizaNaoFiscal( DescontoAcrescimo : Double = 0) ; override ;
    Procedure EfetuaPagamentoNaoFiscal( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ; override ;
    Procedure FechaNaoFiscal( Observacao : AnsiString = '') ; override ;
    Procedure CancelaNaoFiscal ; override ;

    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    procedure LerTotaisAliquota ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;

    procedure CarregaFormasPagamento ; override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;
 end ;

implementation
Uses SysUtils, Math,
    {$IFDEF COMPILER6_UP} DateUtils, StrUtils {$ELSE} ACBrD5, Windows{$ENDIF} ;

{ ------------------------------ TACBrECFSCUComando -------------------------- }

constructor TACBrECFSCUComando.create;
begin
  inherited create ;

  fsParams := TStringList.create ;
  fsSEQ    := 0 ;
end;

destructor TACBrECFSCUComando.destroy;
begin
  fsParams.Free ;

  inherited destroy ;
end;


procedure TACBrECFSCUComando.SetCMD(const Value: Byte);
begin
  if fsSEQ = 255 then
     fsSEQ := 0
  else
     Inc( fsSEQ ) ;

  fsCMD     := Value ;
  fsTimeOut := 0 ;
  fsParams.Clear ;
end;

function TACBrECFSCUComando.GetComando: AnsiString;
  Var I, LenCmd, Soma : Integer ;
      BCD : AnsiString ;
      TBC : Integer ;
      CHK : Byte ;
begin
  if (fsCMD = 255) and (fsEXT = 0) then
     raise Exception.Create(ACBrStr('Para comandos 255, EXT deve ser especificado')) ;

  BCD := '' ;
  For I := 0 to fsParams.Count-1 do
    BCD := BCD + fsParams[I] + '|';
  TBC := Length( BCD ) ;

  Result := chr(fsSEQ) + chr(fsCMD) + chr(fsEXT) +
            AscToBcd(IntToStr(TBC),2) + BCD ;

  Soma := 0 ;
  LenCmd := Length( Result ) ;
  For I := 1 to LenCmd do
     Soma := Soma + ord( Result[I] ) ;
  CHK := Soma mod 256  ;

  Result := SOH + Result + chr( CHK ) ;
end;

procedure TACBrECFSCUComando.AddParamString(AString: AnsiString);
var Buf : AnsiString ;
    I,ASC : Integer ;
begin
  { SCU usa Pipe (|) como seprador, não permite o Pipe na String }
  AString := StringReplace(AString,'|',':',[rfReplaceAll]) ;

  { Convertendo caracteres de comando para Hexa para poder armazenar
    corretamente no TStringList }
  Buf := '' ;
  For I := 1 to Length(AString) do
  begin
     ASC := Ord(AString[I]) ;
     if (ASC < 32) or (ASC > 127) then
        Buf := Buf + '\x'+Trim(IntToHex(ASC,2))
     else
        Buf := Buf + AString[I] ;
  end ;

  fsParams.Add( TrimRight( Buf ) ) ;
end;

procedure TACBrECFSCUComando.AddParamDouble(ADouble: Double; Decimais: Byte);
  Var FloatStr : String ;
begin
  ADouble  := RoundTo(ADouble,-Decimais) ; // no máximo de casas decimais
  FloatStr := FloatToStr(ADouble) ;
  { Removendo o ponto decimal }
  FloatStr := StringReplace( FloatStr , DecimalSeparator,'',[rfReplaceAll]) ;

  fsParams.Add( FloatStr ) ;
end;

procedure TACBrECFSCUComando.AddParamInteger(AInteger: Integer);
begin
  fsParams.Add( IntToStr( AInteger ) ) ;
end;

procedure TACBrECFSCUComando.AddParamDateTime(ADateTime: TDateTime;
   Tipo : Char = 'D'; FlagHV : String = ''  ) ;
  Var Formato : String ;
begin
  case Tipo of
    'T','H' : Formato := 'hh:nn:ss' ;
        'D' : Formato := 'dd/mm/yyyy' ;
  else
     Formato := 'dd/mm/yyyyhh:nn:ss' ;
  end ;

  fsParams.Add( FormatDateTime(Formato, ADateTime) + FlagHV ) ;
end;


{ ----------------------------- TACBrECFSCUResposta -------------------------- }

constructor TACBrECFSCUResposta.create;
begin
  inherited create ;

  fsParams := TStringList.create ;
  fsSEQ    := 0 ;
  fsCMD    := 0 ;
  fsEXT    := 0  ;
  fsCAT    := 0  ;
  fsRET    := 0  ;
  fsTBR    := 0  ;
  fsBRS    := '' ;
  fsCHK    := 0 ;
end;

destructor TACBrECFSCUResposta.destroy;
begin
  fsParams.Free ;
  inherited destroy ;
end;

procedure TACBrECFSCUResposta.SetResposta(const Value: AnsiString);
  Var Soma, I, LenCmd : Integer ;
      CHK  : Byte ;
begin
  fsParams.Clear ;
  fsSEQ    := 0 ;
  fsCMD    := 0 ;
  fsEXT    := 0  ;
  fsCAT    := 0  ;
  fsRET    := 0  ;
  fsTBR    := 0  ;
  fsBRS    := '' ;
  fsCHK    := 0 ;

  if Value = '' then exit ;

  fsResposta := Value ;
  fsSEQ := ord( Value[2] ) ;
  fsCMD := ord( Value[3] ) ;
  fsEXT := ord( Value[4] ) ;
  fsCAT := ord( Value[5] ) ;
  fsRET := StrToInt( BcdToAsc( copy(Value,6,3) ) ) ;
  fsTBR := StrToInt( BcdToAsc( copy(Value,9,2) ) ) ;
  fsBRS := copy( Value, 11, fsTBR ) ;
  fsCHK := ord( Value[ 11 + fsTBR ] ) ;

  Soma := 0 ;
  LenCmd := Length( Value )-1 ;  { -1 por causa do CHK }
  For I := 2 to LenCmd do  
     Soma := Soma + ord( Value[I] ) ;
  CHK := Soma mod 256  ;

  if CHK <> fsCHK then
     raise Exception.Create(ACBrStr('CheckSum da Resposta é inválido'));

(*  { Convertendo caracteres de comando para Hexa para poder armazenar
    corretamente no TStringList }
  Buf := '' ;
  For I := 1 to Length(AString) do
  begin
     ASC := Ord(AString[I]) ;
     if (ASC < 32) or (ASC > 127) then
        Buf := Buf + '\x'+Trim(IntToHex(ASC,2))
     else
        Buf := Buf + AString[I] ;
  end ;
*)
end;

{ ----------------------------- TACBrECFSCU ------------------------------ }

constructor TACBrECFSCU.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fsSCUComando   := TACBrECFSCUComando.create ;
  fsSCUResposta  := TACBrECFSCUResposta.create ;

  fpDevice.HandShake := hsRTS_CTS ;
  { Variaveis internas dessa classe }
  fsNumVersao   := '' ;
  fsNumECF      := '' ;
  fsNumCRO      := '' ;

  fsDecimaisPreco := -1 ;
  fsDecimaisQtd   := -1;

  fpModeloStr := 'SCU' ;
end;

destructor TACBrECFSCU.Destroy;
begin
  fsSCUComando.Free ;
  fsSCUResposta.Free ;

  inherited Destroy ;
end;

procedure TACBrECFSCU.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create(ACBrStr('A impressora: '+fpModeloStr+' requer'+#10+
                            'Porta Serial:  (COM1, COM2, COM3, ...)'));

  inherited Ativar ; { Abre porta serial }

  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumCRO    := '' ;

  fsDecimaisPreco := -1 ;
  fsDecimaisQtd   := -1 ;
  
  fpMFD     := True ;
  fpTermica := True ;

  try
     { Testando a comunicaçao com a porta }
     if NumVersao = '' then
        raise EACBrECFNaoInicializado.Create( ACBrStr(
                 'Erro inicializando a impressora '+fpModeloStr ));
  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFSCU.EnviaComando_ECF( cmd : AnsiString = '') : AnsiString ;
Var ErroMsg : String ;
    OldTimeOut : Integer ;
begin
  if cmd <> '' then
     cmd := PreparaCmd(cmd) ;  // Ajusta e move para SCUcomando

  cmd := SCUComando.Comando ;

  Result  := '' ;
  ErroMsg := '' ;
  fpComandoEnviado     := '' ;
  fpRespostaComando    := '' ;
  SCUResposta.Resposta := '' ;
  OldTimeOut := TimeOut ;
  TimeOut    := max(SCUComando.TimeOut, TimeOut) ;

  try
     fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }
     fpDevice.Serial.Purge ;                   { Limpa a Porta }

     while fpComandoEnviado = '' do
     begin
        fpDevice.Serial.Purge ;                   { Limpa a Porta }

        if not TransmiteComando( cmd ) then
           continue ;

        fpComandoEnviado := cmd ;
     end ;

     { Chama Rotina da Classe mãe TACBrClass para ler Resposta. Se houver
       falha na leitura LeResposta dispara Exceçao.
       Resposta fica gravada na váriavel "fpRespostaComando" }
     LeResposta ;

     Try
        SCUResposta.Resposta := fpRespostaComando ;

        ErroMsg := '' ;
        if SCUResposta.RET > 0 then
           ErroMsg := 'Erro: '+IntToStr(SCUResposta.RET) + ' - ' +
                      SCUResposta.Params.Values['NomeErro'] + #10 +
                      SCUResposta.Params.Values['Circunstancia'] ;
     except
        ErroMsg := 'Resposta do ECF inválida' ;
     end ;

     if ErroMsg <> '' then
      begin
        ErroMsg := ACBrStr('Erro retornado pela Impressora: '+fpModeloStr+#10+#10+
                   ErroMsg );
        raise EACBrECFSemResposta.create(ErroMsg) ;
      end
     else
        Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }

  finally
     TimeOut := OldTimeOut ;
  end ;
end;

function TACBrECFSCU.PreparaCmd(CmdExtBcd: AnsiString): AnsiString;
  Var CMD, EXT : Byte ;
      BCD : AnsiString ;
begin
  CMD := ord( CmdExtBcd[1] ) ;
  EXT := ord( CmdExtBcd[2] ) ;
  BCD := copy(CmdExtBcd,3,Length(CmdExtBcd) ) ;

  if (CMD = 255) and (EXT = 0) then
     raise Exception.Create(ACBrStr('Erro ! CMD = 255 e EXT = 0')) ;

  if (CMD <> 255) and (EXT <> 0) then
     raise Exception.Create(ACBrStr('Erro ! EXT deve ser 0')) ;

  SCUComando.CMD := CMD ;
  SCUComando.EXT := EXT ;
  SCUComando.Params.Text := BCD ;
end;


function TACBrECFSCU.VerificaFimLeitura(Retorno:AnsiString) : Boolean;
begin
  Result := True ;
  { Nota sobre o VerificaFimLeitura: A SCU responde muito antes da
    Impressao terminar, o que pode causar problemas com comandos enviados logo
    após impressoes demoradas como a Leitura X (por exemplo). Para esses casos,
    é necessário ativar a propriedade "AguardaImpressao := True" }
end;


function TACBrECFSCU.VerificaFimImpressao: Boolean;
begin
  { Essa função só é chamada se AguardaImpressao = True,
    Como essa função é executada dentro da "LeResposta", que por sua vez foi
    chamada por "EnviaComando", não podemos usar o método "EnviaComando" (ou
    teriamos uma chamada recursiva infinita), por isso o Loop abaixo envia o
    comando "Palavra Status" diretamente para a Serial, e aguarda por .5 segundo
    a resposta... Se a SCU consegir responder, verifica se o Bit 0 de S8,
    está desligado, o que significa que a Impressão Terminou }
  Result := false ;
  if not EmLinha() then
     Sleep(100)
  else
   begin
   end ;
end;

function TACBrECFSCU.GetDataHora: TDateTime;
(*Var RetCmd : String ;
    OldShortDateFormat : String ;
begin
  RetCmd := EnviaComando( ESC + #230 ) ;
  RetCmd := copy(RetCmd,Length(RetCmd)-12,12) ;  {Pega apenas a Data/Hora}

  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yy' ;
     result := StrToDate(copy(RetCmd,1,2)+ DateSeparator +
                         copy(RetCmd,3,2)+ DateSeparator +
                         copy(RetCmd,5,2)) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
  Result := RecodeHour(  Result,StrToInt(copy(RetCmd, 7,2))) ;
  Result := RecodeMinute(Result,StrToInt(copy(RetCmd, 9,2))) ;
  Result := RecodeSecond(Result,StrToInt(copy(RetCmd,11,2))) ;*)
begin
  Result := now ;
end;

function TACBrECFSCU.GetNumCupom: String;
begin
  Result := '' ;
end;

function TACBrECFSCU.GetNumECF: String;
begin
  if Trim(fsNumECF) = '' then
  begin
  end ;

  Result := fsNumECF ;
end;

function TACBrECFSCU.GetNumCRO: String;
begin
  if Trim(fsNumCRO) = '' then
  begin
  end ;

  Result := fsNumCRO ;
end;

function TACBrECFSCU.GetNumSerie: String;
begin
  Result := '' ;
end;

function TACBrECFSCU.GetNumVersao: String ;
(*Var RetCmd    : String ;
    wRetentar : Boolean ;
begin
  if fsNumVersao = '' then
  begin
     wRetentar := Retentar ;
     try
        Retentar := false ;
        RetCmd   := EnviaComando('R' + #200 + '083', 1) ;
        if copy(RetCmd,1,5) = ':'+#200+'083' then
        begin
           fsNumVersao := copy(RetCmd, 6, 6) ;
        end ;
     finally
        Retentar := wRetentar ;
     end ;

     if (fsDecimaisPreco < 0) or (fsDecimaisQtd < 0) then
     begin
        fsDecimaisQtd   := 3 ;
        fsDecimaisPreco := 2 ;

        RetCmd := EnviaComando('R' + #200 + '139', 1) ;
        if copy(RetCmd,1,5) = ':'+#200+'139' then
        begin
           fsDecimaisQtd   := StrToIntDef(copy(RetCmd,6,1),fsDecimaisQtd) ;
           fsDecimaisPreco := StrToIntDef(copy(RetCmd,7,1),fsDecimaisPreco) ;
        end ;
     end ;
  end ;
*)
begin
  Result := fsNumVersao ;
end;

function TACBrECFSCU.GetTotalPago: Double;
begin
  Result := 0 ;
end;

function TACBrECFSCU.GetSubTotal: Double;
begin
  Result := 0 ;
end;

function TACBrECFSCU.GetEstado: TACBrECFEstado;
begin
  if (not fpAtivo) then
     fpEstado := estNaoInicializada
  else
   begin
     fpEstado := estDesconhecido ;

   end ;

  Result := fpEstado ;
end;

function TACBrECFSCU.GetGavetaAberta: Boolean;
begin
  Result := False ;
end;

function TACBrECFSCU.GetPoucoPapel: Boolean;
begin
  Result := False ;
end;

function TACBrECFSCU.GetHorarioVerao: Boolean;
begin
  Result := False ;
end;

Procedure TACBrECFSCU.LeituraX ;
begin
  AguardaImpressao := True ;

end;

Procedure TACBrECFSCU.AbreGaveta ;
begin
end;

Procedure TACBrECFSCU.ReducaoZ(DataHora: TDateTime) ;
begin
(*  if DataHora = 0 then  { Aparentemente a DataHora é obrigatória na SCU }
     DataHora := now ;

  AguardaImpressao := True ;*)
end;

Procedure TACBrECFSCU.MudaHorarioVerao ;
begin
  MudaHorarioVerao( not HorarioVerao) ;
end;

procedure TACBrECFSCU.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
end;

procedure TACBrECFSCU.AbreCupom ;
begin
  fpUltimaMsgPoucoPapel := 0 ;  { Zera tempo pra msg de pouco papel }

  AguardaImpressao := True ;
//  EnviaComando(ESC + #200, 8) ;
end;

procedure TACBrECFSCU.CancelaCupom;
begin

  FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (só por garantia)}
end;

procedure TACBrECFSCU.CancelaItemVendido(NumItem: Integer);
begin
end;

procedure TACBrECFSCU.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
end;

procedure TACBrECFSCU.FechaCupom(Observacao: AnsiString);
begin
end;

procedure TACBrECFSCU.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : AnsiString );
begin
end;

Procedure TACBrECFSCU.VendeItem( Codigo, Descricao : String;
   AliquotaECF : String;  Qtd : Double ; ValorUnitario : Double;
   DescontoPorc : Double = 0; Unidade : String = '';
   TipoDescontoAcrescimo: String = '%') ;
begin
  if Qtd > 99999 then
     raise EACBrECFCMDInvalido.Create( ACBrStr(
           'Quantidade deve ser inferior a 99999.'));

end;


procedure TACBrECFSCU.CarregaAliquotas;
begin
end;

procedure TACBrECFSCU.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String );
begin
end;

procedure TACBrECFSCU.CarregaFormasPagamento;  { funçao Lenta +- 3 sec. }
begin
end;

procedure TACBrECFSCU.ProgramaFormaPagamento(var Descricao: String;
  PermiteVinculado: Boolean; Posicao : String);
begin
end;

procedure TACBrECFSCU.CarregaComprovantesNaoFiscais;
begin
  CarregaFormasPagamento ;
end;

procedure TACBrECFSCU.ProgramaComprovanteNaoFiscal(var Descricao: String;
  Tipo: String; Posicao : String );
begin
end;


procedure TACBrECFSCU.AbreRelatorioGerencial;
begin
end;

procedure TACBrECFSCU.LinhaRelatorioGerencial(Linha: AnsiString);
begin
end;

procedure TACBrECFSCU.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
begin
end;

procedure TACBrECFSCU.LinhaCupomVinculado(Linha: AnsiString);
begin
end;

procedure TACBrECFSCU.FechaRelatorio;
begin
end;

procedure TACBrECFSCU.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal: Integer);
begin
end;

procedure TACBrECFSCU.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime);
begin
end;

procedure TACBrECFSCU.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas: TStringList);
begin
end;

procedure TACBrECFSCU.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; var Linhas: TStringList);
begin
end;

procedure TACBrECFSCU.LeituraMFDSerial(COOInicial, COOFinal: Integer;
  var Linhas: TStringList);
begin
end;

procedure TACBrECFSCU.LeituraMFDSerial(DataInicial,
  DataFinal: TDateTime; var Linhas: TStringList);
begin
end;

function TACBrECFSCU.GetNumCRZ: String;
begin
  Result := '' ;
end;

function TACBrECFSCU.GetGrandeTotal: Double;
begin
  Result := 0 ;
end;

function TACBrECFSCU.GetNumCOOInicial: String;
begin
  Result := '' ;
end;

function TACBrECFSCU.GetVendaBruta: Double;
begin
  Result := 0 ;
end;

function TACBrECFSCU.GetNumUltimoItem: Integer;
begin
  Result := 0 ;
end;

procedure TACBrECFSCU.AbreNaoFiscal(CPF_CNPJ: String);
begin
end;

procedure TACBrECFSCU.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: String);
begin
end;

procedure TACBrECFSCU.SubtotalizaNaoFiscal(DescontoAcrescimo: Double);
begin
end;

procedure TACBrECFSCU.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
end;

procedure TACBrECFSCU.FechaNaoFiscal(Observacao: AnsiString);
begin
end;

procedure TACBrECFSCU.CancelaNaoFiscal;
begin
end;

function TACBrECFSCU.GetTotalAcrescimos: Double;
begin
  Result := 0 ;
end;

function TACBrECFSCU.GetTotalCancelamentos: Double;
begin
  Result := 0 ;
end;

function TACBrECFSCU.GetTotalDescontos: Double;
begin
  Result := 0 ;
end;

function TACBrECFSCU.GetTotalIsencao: Double;
begin
  Result := 0 ;
end;

function TACBrECFSCU.GetTotalNaoTributado: Double;
begin
  Result := 0 ;
end;

function TACBrECFSCU.GetTotalSubstituicaoTributaria: Double;
begin
  Result := 0 ;
end;

function TACBrECFSCU.GetCNPJ: String;
begin
  Result := '' ;
end;

function TACBrECFSCU.GetDataMovimento: TDateTime;
begin
  Result := now ;
end;

procedure TACBrECFSCU.LerTotaisAliquota;
begin
end;

end.


