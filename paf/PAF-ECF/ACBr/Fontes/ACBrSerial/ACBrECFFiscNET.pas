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
|* 26/06/2006: Daniel Simões de Almeida
|* - Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
|* 28/11/2006: Daniel Simões de Almeida
|* - Corrigo bug em SubTotalizaCupom
|* 09/01/2007: Daniel Simões de Almeida
|* - Corrigido espacejamento de PulaLinhas ( considerando 1 linha = 30 dots )
|* - Corrigido BUG em Método CorrigeEstadoErro, que sempre causava o Reinicio
|*   do ECF
|* - Método AbreRelatorioGerencial modificado para cadastrar  Relatorio
|*   Gerencial ( 0 ) caso ele ainda não exista
|* 10/01/2007: Daniel Simões de Almeida
|* - Método VendeItem gerava exceção quando Desconto era informado
|* - Método "LinhaRelatorioGerencial" nao imprimir linhas vazias e em textos
|*   maiores que 492 caracteres poderia haver quebra do lay-out de impressao
|* 01/04/2007:  Daniel Simoes de Almeida
|*  - Implementados métodos de Cupom Não Fiscal
|* 24/02/2008:  Fabio Farias
|*  - Compatibilizada com a TermoPrinter
|* 05/02/2009:  Daniel Simões de Almeida
|*  - Corrigido método NaoFiscalCompleto, que era cancelado quando Registrador
|*    NaoFiscal era de Saidas (-) ou continha Obs no rodapé
|* 13/09/2010:  Emerson da Silva Crema
|*  - Implementado Metodo GetDadosUltimaReducaoZ.
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFFiscNET ;

interface
uses ACBrECFClass, ACBrDevice, ACBrUtil,
     Classes
     {$IFNDEF CONSOLE}
       {$IFDEF VisualCLX}, QForms {$ELSE}, Forms {$ENDIF}
     {$ENDIF};
type

TACBrECFFiscNETComando = class
  private
    fsNomeComando : String ;
    fsParams  : TStringList ;
    fsCont    : Byte ;
    fsTimeOut: Integer;

    function GetComando: AnsiString;
    procedure SetNomeComando(const Value: String);
 public
    constructor create ;
    destructor destroy ; override ;

    property NomeComando : String  write SetNomeComando ;
    property TimeOut     : Integer read fsTimeOut write fsTimeOut ;
    property Comando     : AnsiString  read GetComando ;
    property Params      : TStringList read fsParams ;

    Procedure AddParamString(ParamName : String; AString  : AnsiString) ;
    Procedure AddParamInteger(ParamName : String; AInteger : Integer) ;
    Procedure AddParamDouble(ParamName : String; ADouble  : Double) ;
    Procedure AddParamBool(ParamName : String; ABool    : Boolean) ;
    Procedure AddParamDateTime(ParamName : String; ADateTime: TDateTime;Tipo : Char = 'D'  ) ;
 end ;

TACBrECFFiscNETResposta = class
  private
    fsParams  : TStringList ;
    fsCont: Byte;
    fsCodRetorno: Integer;
    fsTamanho: Integer;
    fsResposta : AnsiString ;

    procedure SetResposta(const Value: AnsiString);
 public
    constructor create ;
    destructor destroy ; override ;

    property Resposta   : AnsiString  read fsResposta write SetResposta ;
    property Cont       : Byte        read fsCont;
    property CodRetorno : Integer     read fsCodRetorno ;
    property Params     : TStringList read fsParams ;
    property Tamanho    : Integer     read fsTamanho ;
 end ;

{ Classe filha de TACBrECFClass com implementaçao para FiscNET }

{ TACBrECFFiscNET }

TACBrECFFiscNET = class( TACBrECFClass )
 private
    fsNumVersao : String ;
    fsNumECF    : String ;
    fsNumLoja   : String ;
    fsPAF       : String ;
    fsBaseTotalDiaMeioPagamento : Integer ;
    fsBaseTotalDiaNaoFiscal     : Integer ;
    fsArredonda : Integer ;
    fsFiscNETComando: TACBrECFFiscNETComando;
    fsFiscNETResposta: TACBrECFFiscNETResposta;
    fsComandoVendeItem : String ;
    fsComandosImpressao : array[0..9] of AnsiString ;
    fsEmPagamento : Boolean ;
    fsMarcaECF : String ;

    //dataregis | termoprinter
    xGera_PAF                       : Function ( ComPort     : AnsiString;
                                                 Modelo      : AnsiString;
                                                 RegFileName : AnsiString;
                                                 COOInicial  : AnsiString;
                                                 COOFinal    : AnsiString) : integer; stdcall;
    xGera_AtoCotepe1704_Periodo_MFD : Function ( ComPort            : AnsiString;
                                                 Modelo             : AnsiString;
                                                 RegFileName        : AnsiString;
                                                 DataReducaoInicial : AnsiString;
                                                 DataReducaoFinal   : AnsiString) : integer; stdcall;

    // urano e demais
    xDLLReadLeMemorias : function (szPortaSerial, szNomeArquivo, szSerieECF,
         bAguardaConcluirLeitura : AnsiString) : Integer; stdcall;

    xDLLATO17GeraArquivo : function (szArquivoBinario, szArquivoTexto, szPeriodoIni, szPeriodoFIM,
         TipoPeriodo, szUsuario, szTipoLeitura : AnsiString) : Integer; stdcall;

    //Elgin
    xElgin_AbrePortaSerial  : function : Integer; StdCall;
    XElgin_FechaPortaSerial : function : Integer; StdCall;
    xElgin_DownloadMFD      : function(Arquivo          : AnsiString;
                                       TipoDownload     : AnsiString;
                                       ParametroInicial : AnsiString;
                                       ParametroFinal   : AnsiString;
                                       UsuarioECF       : AnsiString) : Integer; StdCall;
    xElgin_FormatoDadosMFD  : function(ArquivoOrigem    : AnsiString;
                                       ArquivoDestino   : AnsiString;
                                       TipoFormato      : AnsiString;
                                       TipoDownload     : AnsiString;
                                       ParametroInicial : AnsiString;
                                       ParametroFinal   : AnsiString;
                                       UsuarioECF       : AnsiString) : Integer; StdCall;
    xElgin_LeMemoriasBinario : function(Arquivo: AnsiString;
                                        NumSerie: AnsiString;
                                        AguardaLeitura: Boolean) : Integer; StdCall;
    xElgin_GeraArquivoATO17Binario : function(ArquivoBinario: AnsiString;
                                              ArquivoTexto: AnsiString;
                                              PeriodoIni: AnsiString;
                                              PeriodoFim: AnsiString;
                                              TipoPeriodo :AnsiChar;
                                              UsuarioECF: AnsiString;
                                              TipoLeitura: AnsiString) : Integer; StdCall;

    procedure LoadDLLFunctions;
    procedure AbrePortaSerialDLL(const Porta, Path : String ) ;

    Procedure PreparaCmd( cmd : AnsiString ) ;
    Function AjustaLeitura( AString : AnsiString ) : AnsiString ;
    function DocumentosToStr(Documentos: TACBrECFTipoDocumentoSet): String;
    function GetErroAtoCotepe1704(pRet: Integer): string;

 protected
    function TraduzirTag(const ATag: AnsiString): AnsiString; override;

    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumCCF: String; override ;
    function GetNumECF: String; override ;
    function GetNumLoja: String; override ;
    function GetNumSerie: String; override ;
    function GetNumSerieMFD: String; override ;
    function GetNumVersao: String; override ;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetHorarioVerao: Boolean; override ;
    function GetParamDescontoISSQN: Boolean; override ;
    function GetChequePronto: Boolean; override ;
    function GetArredonda: Boolean; override ;

    function GetCNPJ: String; override ;
    function GetIE: String; override ;
    function GetIM: String; override ;
    function GetCliche: AnsiString; override ;
    function GetUsuarioAtual: String; override ;
    function GetDataHoraSB: TDateTime; override ;
    function GetSubModeloECF: String ; override ;
    
    function GetDataMovimento: TDateTime; override ;
    function GetGrandeTotal: Double; override ;
    function GetNumCRO: String; override ;
    function GetNumGRG: String; override ;
    function GetNumGNF: String; override ;
    function GetNumCDC: String; override ;    
    function GetNumCFC: String; override ;    
    function GetNumCRZ: String; override ;
    function GetVendaBruta: Double; override ;
    function GetTotalAcrescimos: Double; override ;
    function GetTotalCancelamentos: Double; override ;
    function GetTotalDescontos: Double; override ;
    function GetTotalTroco: Double; override ;
    function GetTotalSubstituicaoTributaria: Double; override ;
    function GetTotalNaoTributado: Double; override ;
    function GetTotalIsencao: Double; override ;


    function GetTotalAcrescimosISSQN: Double; override;
    function GetTotalCancelamentosISSQN: Double; override;
    function GetTotalDescontosISSQN: Double; override;
    function GetTotalSubstituicaoTributariaISSQN: Double; override;
    function GetTotalIsencaoISSQN: Double; override;
    function GetTotalNaoTributadoISSQN: Double; override;


    function GetNumCOOInicial: String; override ;
    function GetNumUltimoItem: Integer; override ;

    function GetDadosUltimaReducaoZ: AnsiString; override ;    

    function GetPAF: String; override ;

    Function VerificaFimLeitura(var Retorno: AnsiString;
       var TempoLimite: TDateTime) : Boolean ; override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;

    property FiscNETComando : TACBrECFFiscNETComando  read fsFiscNETComando ;
    property FiscNETResposta: TACBrECFFiscNETResposta read fsFiscNETResposta ;

    Function EnviaComando_ECF( cmd : AnsiString = '') : AnsiString ; override ;

    Procedure AbreCupom ; override ;
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D' ) ; override ;
    Procedure DescontoAcrescimoItemAnterior( ValorDescontoAcrescimo : Double = 0;
       DescontoAcrescimo : String = 'D'; TipoDescontoAcrescimo : String = '%';
       NumItem : Integer = 0 ) ;  override ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : AnsiString  = '' ) ; override ;
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
    procedure NaoFiscalCompleto(CodCNF: String; Valor: Double;
      CodFormaPagto: String; Obs: AnsiString; IndiceBMP : Integer = 0); override ;

    Procedure LeituraX ; override ;
    Procedure LeituraXSerial( Linhas : TStringList) ; override ;
    Procedure ReducaoZ(DataHora : TDateTime) ; override ;
    Procedure AbreRelatorioGerencial(Indice: Integer = 0) ; override ;
    Procedure LinhaRelatorioGerencial( Linha : AnsiString; IndiceBMP: Integer = 0 ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : AnsiString ) ; override ;
    Procedure FechaRelatorio ; override ;
    Procedure PulaLinhas( NumLinhas : Integer = 0 ) ; override ;
    Procedure CortaPapel( const CorteParcial : Boolean = false) ; override ;

    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;
    Procedure CorrigeEstadoErro(Reducao: Boolean = True) ; override ;


    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime;
       Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer;
       Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       Linhas : TStringList; Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       Linhas : TStringList; Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMFDSerial( DataInicial, DataFinal : TDateTime;
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

    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;
    Function LeituraCMC7 : AnsiString ; override ;
    
    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    procedure LerTotaisAliquota ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;
    function AchaICMSAliquota( var AliquotaICMS : String ) :
       TACBrECFAliquota ;  override;

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

    procedure IdentificaPAF( Linha1, Linha2 : String) ; override ;

 end ;

implementation
Uses ACBrECF, ACBrConsts,
     {$IFDEF COMPILER6_UP} DateUtils, StrUtils{$ELSE} ACBrD5, SysUtils, Windows{$ENDIF},
     SysUtils, Math, IniFiles ;

{ -------------------------  TACBrECFFiscNETComando -------------------------- }
constructor TACBrECFFiscNETComando.create;
begin
  inherited create ;

  fsParams := TStringList.create ;
  fsCont   := 0 ;
end;

destructor TACBrECFFiscNETComando.destroy;
begin
  fsParams.Free ;

  inherited destroy ;
end;

procedure TACBrECFFiscNETComando.SetNomeComando(const Value: String);
begin
  if fsCont >= 250 then
     fsCont := 1
  else
     Inc( fsCont ) ;

  fsNomeComando := Trim(Value) ;
  fsTimeOut     := 0 ;
  fsParams.Clear ;
end;

function TACBrECFFiscNETComando.GetComando: AnsiString;
var
  I: Integer;
begin
  Result := '{'+IntToStr(fsCont)+';'+fsNomeComando+';' ;

  For I := 0 to fsParams.Count-1 do
    Result := Result + Trim(fsParams[I]) + ' ';
  Result := Trim(Result) ;

  Result := Result + ';'+IntToStr(Length(Result))+'}' ;
end;

procedure TACBrECFFiscNETComando.AddParamString(ParamName: String;
  AString: AnsiString);
var
  Buf : AnsiString ;
begin
  if AString = '' then exit ;

  AString := StringReplace(AString,'\','\\',[rfReplaceAll]) ;
  AString := StringReplace(AString,'"','\"',[rfReplaceAll]) ;
  { Restaurando caracteres de controle }
  AString := StringReplace(AString,'\\x','\x',[rfReplaceAll]) ;

  Buf := BinaryStringToString(AString);

  fsParams.Add( ParamName + '="' + TrimRight( Buf ) + '"' ) ;
end;

procedure TACBrECFFiscNETComando.AddParamDouble(ParamName: String;
  ADouble: Double);
var
  AFloatStr: string;
begin
  ADouble   := RoundTo(ADouble,-4) ; // FiscNet aceita no máximo 4 casas decimais
  AFloatStr := FloatToStr(ADouble) ;
  // FiscNET sempre usar "," como separador de decimal //
  AFloatStr := StringReplace(AFloatStr,DecimalSeparator,',',[rfReplaceAll]) ;
  fsParams.Add(ParamName + '=' + AFloatStr ) ;
end;

procedure TACBrECFFiscNETComando.AddParamInteger(ParamName: String;
  AInteger: Integer);
begin
  fsParams.Add(ParamName + '=' + IntToStr(AInteger) )
end;

procedure TACBrECFFiscNETComando.AddParamBool(ParamName: String;
  ABool: Boolean);
var
  CharBool: Char;
begin
  if ABool then
    CharBool := 't'
  else
    CharBool := 'f';

  fsParams.Add(ParamName + '=' + CharBool )
end;

Procedure TACBrECFFiscNETComando.AddParamDateTime(ParamName : String;
  ADateTime: TDateTime;Tipo : Char = 'D'  ) ;
var
  Texto: string;
begin
  if Tipo in ['T','H'] then
     Texto := FormatDateTime('hh:nn:ss',ADateTime)
  else
     Texto := FormatDateTime('dd/mm/yyyy',ADateTime) ;

  fsParams.Add(ParamName + '=' + '#'+Texto+'#' )
end;

{ ------------------------- TACBrECFFiscNETResposta -------------------------- }

constructor TACBrECFFiscNETResposta.create;
begin
  inherited create ;

  fsParams     := TStringList.create ;
  fsCont       := 0 ;
  fsCodRetorno := 0;
  fsTamanho    := 0;
  fsResposta   := '' ;
end;

destructor TACBrECFFiscNETResposta.destroy;
begin
  fsParams.Free ;
  inherited destroy ;
end;

procedure TACBrECFFiscNETResposta.SetResposta(const Value: AnsiString);
var
  Buf: AnsiString;
  P,I : Integer ;
  Param : AnsiString ;
  CharAposIgual : AnsiChar ;
begin
  fsParams.Clear ;
  fsCont       := 0 ;
  fsCodRetorno := 0;
  fsTamanho    := 0;
  fsResposta   := '' ;

  if Value = '' then exit ;

  fsResposta := Value ;
  Buf        := copy(fsResposta,2,Length(fsResposta)-2) ;  //  Remove "{"  "}"

  P := PosLast(';',Buf) ;
  fsTamanho := StrToIntDef(copy(Buf,P+1,Length(Buf)),0) ;
  Buf       := copy(Buf,1,P-1) ;  // Remove tamanho

  P := pos(';',Buf) ;
  try
     fsCont := StrToInt( copy(Buf,1,(P-1)) ) ;
  except
     raise Exception.Create(ACBrStr('Num.Identificação inválido')) ;
  end ;
  Buf := copy(Buf,P+1,Length(Buf)) ;  // Remove a Ident.

  P := pos(';',Buf) ;
  try
     fsCodRetorno := StrToInt( copy(Buf,1,(P-1)) ) ;
  except
     raise Exception.Create(ACBrStr('Cod.Retorno inválido')) ;
  end ;
  Buf := Trim(copy(Buf,P+1,Length(Buf))) ;  // Remove Retorno

  if Buf = '' then
     exit ;

  Buf := StringReplace(Buf,'\"','\x22',[rfReplaceAll]) ;  // Tira aspas internas
  // Tem Parametros ? //
  P := pos('=',Buf) ;
  while P > 0 do
  begin
     try
        CharAposIgual := Buf[P+1] ;
        case CharAposIgual of
           '#' : P := PosAt('#',Buf,2) ;
           '"' : P := PosAt('"',Buf,2) ;
        else
           P := Pos(' ',Buf) ;
        end ;
     except
        CharAposIgual := ' ';
        P := 0 ;
     end ;

     if P = 0 then
        P := Length(Buf) ;

     Param := Trim(copy(Buf,1,P)) ;
     Buf   := Trim(copy(Buf,P+1,Length(Buf))) ;  // Restante

     if CharAposIgual in ['"','#'] then   // É parametro Texto ou Data/Hora ?
     begin
        I := pos('=',Param) ;
        { removendo as " ou # }
        Param := copy(Param,1,I) + copy(Param,I+2,(Length(Param)-I-2) ) ;

        { Verificando por codigos em Hexa }
        Param := StringToBinaryString(Param);
     end ;

     fsParams.Add(Param) ;

     P := pos('=',Buf) ;
  end ;
end;

{ ----------------------------- TACBrECFFiscNET ----------------------------- }

constructor TACBrECFFiscNET.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fsFiscNETComando   := TACBrECFFiscNETComando.create ;
  fsFiscNETResposta  := TACBrECFFiscNETResposta.create ;

  fpDevice.HandShake := hsRTS_CTS ;
  fpDevice.Baud      := 115200 ;
  fpDevice.Parity    := pEven ;

  (*
     Para funcionar na TermoPrinter use as configurações abaixo...
     Vc pode programar essas caracteristicas em tempo de execução no
     ACBrECF.Device após ajustar o Modelo e antes de Ativar... Exemplo:

     ACBrECF1.Modelo           := ecfFiscNET ;
     ACBrECF1.Device.Baud      := 9600 ;
     ACBrECF1.Device.Parity    := pNone ;
     ACBrECF1.Device.HandShake := hsDTR_DSR ;
     ACBrECF1.Ativar ;
  *)


  { Variaveis internas dessa classe }
  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumLoja   := '' ;
  fsPAF       := '' ;
  fsBaseTotalDiaMeioPagamento := 99;
  fsBaseTotalDiaNaoFiscal     := 99;
  fsArredonda := -1 ;
  fsComandoVendeItem := '' ;
  fsEmPagamento := false ;
  fsMarcaECF := '';
  
  fpModeloStr := 'FiscNET' ;
  fpPaginaDeCodigo := 850 ;
  fpColunas   := 57 ;
  fpMFD       := True ;
  fpTermica   := True ;
  fpIdentificaConsumidorRodape := True ;

  { Criando Lista de String com comandos de Impressao a Remover de Leituras }
  fsComandosImpressao[0]  := #27 + 'E1';
  fsComandosImpressao[1]  := #27 + 'E0';
  fsComandosImpressao[2]  := #27 + 'E';
  fsComandosImpressao[3]  := #27 + 'F';
  fsComandosImpressao[4]  := #27 + '!(';
  fsComandosImpressao[5]  := #27 + '!' + #1 ;
  fsComandosImpressao[6]  := #27 + '!' + #2 ;
  fsComandosImpressao[7]  := #27 + 'W1';
  fsComandosImpressao[8]  := #27 + 'W0';
  fsComandosImpressao[9]  := #30 ;
end;

destructor TACBrECFFiscNET.Destroy;
begin
  fsFiscNETComando.Free ;
  fsFiscNETResposta.Free ;

  inherited Destroy ;
end;

procedure TACBrECFFiscNET.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create(ACBrStr('A impressora: '+fpModeloStr+' requer'+sLineBreak+
                            'Porta Serial:  (COM1, COM2, COM3, ...)'));

  inherited Ativar ; { Abre porta serial }

  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumLoja   := '' ;
  fsArredonda := -1 ;
  fsComandoVendeItem := '' ;
  fsMarcaECF := '' ;
  fsBaseTotalDiaMeioPagamento := 99;
  fsBaseTotalDiaNaoFiscal     := 99;

  { FiscNET sempre aceita até 3 decimais na QTD e PrecoUnit }
  fpDecimaisQtd   := 3 ;
  fpDecimaisPreco := 3 ;

  try
     if NumVersao = '' then
        raise EACBrECFNaoInicializado.Create( ACBrStr(
                 'Erro inicializando a impressora '+fpModeloStr ));

     GetPAF ;

     FiscNETComando.NomeComando := 'LeTexto' ;
     FiscNETComando.AddParamString('NomeTexto','Marca') ;
     EnviaComando ;
     fpModeloStr := 'FiscNET: '+ FiscNETResposta.Params.Values['ValorTexto'] ;

     FiscNETComando.NomeComando := 'LeTexto';
     FiscNETComando.AddParamString('NomeTexto','Modelo');
     EnviaComando;
     fpModeloStr := fpModeloStr + ' - ' + FiscNETResposta.Params.Values['ValorTexto'] ;
     // Ajuste de Colunas na ThermoPrinter, por Fabio Farias //
     if FiscNETResposta.Params.Values['ValorTexto']='TPF2001' then
        fpColunas := 40;
     // Ajuste para 48 colunas no caso da Elgin X5 , por Juliomar Marchetti //
     if FiscNETResposta.Params.Values['ValorTexto']='X5' then
        fpColunas := 48;

  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFFiscNET.EnviaComando_ECF( cmd : AnsiString = '' ) : AnsiString ;
var
  ErroMsg: string;
  OldTimeOut : Integer ;
begin
  if cmd <> '' then
     PreparaCmd(cmd) ;  // Ajusta e move para FiscNETcomando

  cmd := FiscNETComando.Comando ;

  Result  := '' ;
  ErroMsg := '' ;
  fpComandoEnviado   := '' ;
  fpRespostaComando  := '' ;
  FiscNETResposta.Resposta := '' ;
  OldTimeOut := TimeOut ;
  TimeOut    := max(FiscNETComando.TimeOut, TimeOut) ;

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
        FiscNETResposta.Resposta := fpRespostaComando ;

        ErroMsg := '' ;
        if FiscNETResposta.CodRetorno > 0 then
           ErroMsg := 'Erro: '+IntToStr(FiscNETResposta.CodRetorno) + ' - ' +
                      FiscNETResposta.Params.Values['NomeErro'] + #10 +
                      FiscNETResposta.Params.Values['Circunstancia'] ;
     except
        ErroMsg := 'Resposta do ECF inválida' ;
     end ;

     if ErroMsg <> '' then
      begin
        ErroMsg := ACBrStr('Erro retornado pela Impressora: '+fpModeloStr+#10+#10+
                   ErroMsg ) ;
        raise EACBrECFSemResposta.create(ErroMsg) ;
      end
     else
        Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }

  finally
     TimeOut := OldTimeOut ;
  end ;
end;

Procedure TACBrECFFiscNET.PreparaCmd(cmd: AnsiString) ;
var
  P: Integer;
begin
  P := pos(';',cmd) ;
  if P = 0 then
     P := Length(cmd)+1 ;
  FiscNETComando.NomeComando := copy(cmd,1,P-1) ;
  FiscNETComando.Params.Text := copy(cmd,P+1,Length(cmd)) ;
end;

Function TACBrECFFiscNET.VerificaFimLeitura(var Retorno: AnsiString;
   var TempoLimite: TDateTime) : Boolean ;
begin
  Result := (RightStr(Retorno,1) = '}') and (CountStr(Retorno,';') >= 3) ; 
end;

function TACBrECFFiscNET.GetDataHora: TDateTime;
var
  RetCmd: AnsiString;
  OldShortDateFormat : String ;
begin
  FiscNETComando.NomeComando := 'LeData' ;
  FiscNETComando.AddParamString('NomeData','Data');
  EnviaComando ;
  RetCmd := FiscNETResposta.Params.Values['ValorData'] ;
  RetCmd := StringReplace(RetCmd ,'/',DateSeparator, [rfReplaceAll] );
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yyyy' ;
     Result := StrToDate( RetCmd ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;

  try
     FiscNETComando.NomeComando := 'LeHora' ;
     FiscNETComando.AddParamString('NomeHora','Hora');
     EnviaComando ;
     RetCmd := FiscNETResposta.Params.Values['ValorHora'] ;
  except
     if fsNumVersao = '01.00.01' then   // Versao 01.00.01 da TermoPrinter não lê hora
        RetCmd := FormatDateTime('hh:mm:ss',Now)
     else
        raise ;
  end ;

  Result := RecodeHour(  Result,StrToInt(copy(RetCmd,1,2))) ;
  Result := RecodeMinute(Result,StrToInt(copy(RetCmd,4,2))) ;
  Result := RecodeSecond(Result,StrToInt(copy(RetCmd,7,2))) ;
end;

function TACBrECFFiscNET.GetNumCupom: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','COO') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumCCF: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','CCF') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumCRO: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','CRO') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumGRG: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','GRG') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumGNF: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','GNF') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumCDC: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','CDC') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumCFC: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','CFC') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumLoja: String;
begin
  if fsNumLoja = '' then
  begin
     FiscNETComando.NomeComando := 'LeInteiro' ;
     FiscNETComando.AddParamString('NomeInteiro','Loja') ;
     EnviaComando ;

     fsNumLoja := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 3) ;
  end ;

  Result := fsNumLoja ;
end;

function TACBrECFFiscNET.GetNumECF: String;
begin
  if fsNumECF = '' then
  begin
     FiscNETComando.NomeComando := 'LeInteiro' ;
     FiscNETComando.AddParamString('NomeInteiro','ECF') ;
     EnviaComando ;

     fsNumECF := IntToStrZero(  StrToIntDef(
                     FiscNETResposta.Params.Values['ValorInteiro'],0 ), 4) ;
  end ;

  Result := fsNumECF ;
end;

function TACBrECFFiscNET.GetNumSerie: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','NumeroSerieECF') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetNumSerieMFD: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','NumeroSerieMFD') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetNumVersao: String ;
begin
  if fsNumVersao = '' then
  begin
     FiscNETComando.NomeComando := 'LeTexto' ;
     FiscNETComando.AddParamString('NomeTexto','VersaoSW') ;
     EnviaComando ;

     fsNumVersao := FiscNETResposta.Params.Values['ValorTexto'] ;
  end ;

  Result := fsNumVersao ;
end;

function TACBrECFFiscNET.GetTotalPago: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDocValorPago') ;
  EnviaComando ;

  Result := StringToFloatDef(
               RemoveString('.',FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
end;

function TACBrECFFiscNET.GetSubTotal: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDocLiquido') ;
  EnviaComando ;

  Result := StringToFloatDef(
               RemoveString('.',FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
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
function TACBrECFFiscNET.GetEstado: TACBrECFEstado;
var
  Est, Ind: Integer;
begin
  Result := fpEstado ;  // Suprimir Warning
  try
    fpEstado := estNaoInicializada ;
    if (not fpAtivo) then
      exit ;

    fpEstado := estDesconhecido ;

    FiscNETComando.NomeComando := 'LeInteiro' ;
    FiscNETComando.AddParamString('NomeInteiro','EstadoFiscal') ;
    EnviaComando ;

    Est := StrToIntDef( FiscNETResposta.Params.Values['ValorInteiro'] ,0) ;

    case Est of
      1      : fpEstado := estLivre ;
      2      : fpEstado := estVenda ;
      4,8,16 : fpEstado := estPagamento ;
      32,64  : fpEstado := estRelatorio ;
      128    : fpEstado := estNaoFiscal ;
    end ;

    if fsEmPagamento and (fpEstado = estVenda) then
       fpEstado := estPagamento ;

    if fpEstado in [estDesconhecido, estLivre] then
    begin
      FiscNETComando.NomeComando := 'LeInteiro' ;
      FiscNETComando.AddParamString('NomeInteiro','Indicadores') ;
      EnviaComando ;
      Ind := StrToIntDef( FiscNETResposta.Params.Values['ValorInteiro'] ,0) ;

      if TestBit(Ind,5) then
         fpEstado := estBloqueada

      else if TestBit(Ind,7) then
         fpEstado := estRequerZ

//    else if not TestBit(Ind,6) then
//       fpEstado := estRequerX

    end ;
  finally
    Result := fpEstado ;
  end ;
end;

function TACBrECFFiscNET.GetGavetaAberta: Boolean;
begin
  FiscNETComando.NomeComando := 'LeIndicador' ;
  FiscNETComando.AddParamString('NomeIndicador','SensorGaveta') ;
  EnviaComando ;

  Result := (FiscNETResposta.Params.Values['ValorNumericoIndicador'] = '1');
end;

function TACBrECFFiscNET.GetPoucoPapel: Boolean;
begin
  try
     FiscNETComando.NomeComando := 'LeIndicador' ;
     FiscNETComando.AddParamString('NomeIndicador','SensorPoucoPapel') ;
     EnviaComando ;
     Result := (FiscNETResposta.Params.Values['ValorNumericoIndicador'] = '1');
  except
     if fsNumVersao = '01.00.01' then   // Versao 01.00.01 da TermoPrinter não lê SensorPoucoPapel
        Result := False
     else
        raise ;
  end ;
end;

function TACBrECFFiscNET.GetHorarioVerao: Boolean;
begin
  try
     FiscNETComando.NomeComando := 'LeIndicador' ;
     FiscNETComando.AddParamString('NomeIndicador','HorarioVerao') ;
     EnviaComando ;
     Result := (FiscNETResposta.Params.Values['ValorNumericoIndicador'] = '1') ;
  except
     if fsNumVersao = '01.00.01' then   // Versao 01.00.01 da TermoPrinter não lê HorarioVerao
        Result := False
     else
        raise ;
  end ;
end;

Procedure TACBrECFFiscNET.LeituraX ;
begin
  FiscNETComando.NomeComando := 'EmiteLeituraX' ;
  FiscNETComando.TimeOut     := 30 ;
  FiscNETComando.AddParamString('Destino','I') ;
  FiscNETComando.AddParamString('Operador',Operador) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.LeituraXSerial(Linhas: TStringList);
Var
  Leitura, RetCmd : AnsiString ;
begin
  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraX' ;
     AddParamString('Destino','S') ;
     AddParamString('Operador',Operador) ;
  end ;
  FiscNETComando.TimeOut := 10 ;
  EnviaComando ;
  Sleep(500);

  Leitura := '' ;
  Linhas.Clear ;
  repeat
     FiscNETComando.NomeComando := 'LeImpressao' ;
     EnviaComando ;

     RetCmd  := FiscNETResposta.Params.Values['TextoImpressao'] ;
     Leitura := Leitura + RetCmd ;
     sleep(100) ;
  until (RetCmd = '') ;

  Linhas.Text := AjustaLeitura( Leitura );
end;


Procedure TACBrECFFiscNET.AbreGaveta ;
begin
  FiscNETComando.NomeComando := 'AbreGaveta' ;
  EnviaComando ;
end;

Procedure TACBrECFFiscNET.ReducaoZ(DataHora: TDateTime) ;
begin
  FiscNETComando.NomeComando := 'EmiteReducaoZ' ;
  FiscNETComando.TimeOut     := 900 ;
  if DataHora <> 0 then
     FiscNETComando.AddParamDateTime('Hora',DataHora,'T') ;
  FiscNETComando.AddParamString('Operador',Operador) ;

  try
     EnviaComando ;
  except
     on E : Exception do
     begin
        if (pos('8092',E.Message) <> 0) then   // Erro de Hora fora da faixa ?
           ReducaoZ(0)                         // Tenta sem DataHora
        else
           raise ;
     end ;
  end ;
end;

Procedure TACBrECFFiscNET.MudaHorarioVerao ;
begin
  MudaHorarioVerao( not HorarioVerao ) ;
end;

procedure TACBrECFFiscNET.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  FiscNETComando.NomeComando := 'AcertaHorarioVerao' ;
  FiscNETComando.AddParamInteger('EntradaHV', IfThen(EHorarioVerao,1,0)) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.AbreCupom ;
begin
  FiscNETComando.NomeComando := 'AbreCupomFiscal' ;
  FiscNETComando.TimeOut     := 10 ;
  FiscNETComando.AddParamString('IdConsumidor',LeftStr(Consumidor.Documento,29)) ;
  if Consumidor.Nome <> '' then
     FiscNETComando.AddParamString('NomeConsumidor',LeftStr(Consumidor.Nome,30)) ;
  if Consumidor.Endereco <> '' then
     FiscNETComando.AddParamString('EnderecoConsumidor',LeftStr(Consumidor.Endereco,80)) ;
  EnviaComando ;
  Consumidor.Enviado := True ;
  fsEmPagamento := false ;
end;

procedure TACBrECFFiscNET.CancelaCupom;
var
  Erro : string;
  CCD  : Integer ;
begin
  try
     FiscNETComando.NomeComando := 'CancelaCupom' ;
     FiscNETComando.TimeOut     := 30 ;
     FiscNETComando.AddParamString('Operador',Operador) ;
     EnviaComando ;
  except
     on E : Exception do
     begin
        Erro := E.Message ;
        CCD  := StrToIntDef(NumCupom,0) ;

        // 8000 - ErroCMDForaDeSequencia
        // 8086 - ErroCMDCancelamentoInvalido
        // Todos CCD´s vinculados ao cupom devem ser estornados antes da operacao de cancelamento
        while {pos('CCD',Erro) <> 0) and }((pos('8000',Erro) <> 0) or (pos('8086',Erro) <> 0) ) do
        begin
           try
              Erro := '' ;
              FiscNETComando.NomeComando := 'EstornaCreditoDebito' ;
              FiscNETComando.AddParamInteger('COO',CCD) ;
              EnviaComando ;

              Dec(CCD);

              FiscNETComando.NomeComando := 'EncerraDocumento' ;
              FiscNETComando.AddParamString('Operador',Operador) ;
              EnviaComando ;

              FiscNETComando.NomeComando := 'CancelaCupom' ;
              FiscNETComando.AddParamString('Operador',Operador) ;
              EnviaComando ;
           except
              on E : Exception do
                 Erro := E.Message ;
           end ;
        end ;
     end ;
  end ;

  if Erro <> '' then
     raise Exception.create(Erro);

  fsEmPagamento := false ;
    
  FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (só por garantia)}
end;

procedure TACBrECFFiscNET.CancelaItemVendido(NumItem: Integer);
begin
  FiscNETComando.NomeComando := 'CancelaItemFiscal' ;
  FiscNETComando.AddParamInteger('NumItem',NumItem) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
  FiscNETComando.NomeComando := 'PagaCupom' ;
  FiscNETComando.AddParamInteger('CodMeioPagamento', StrToInt(CodFormaPagto)) ;
  FiscNETComando.AddParamString('TextoAdicional',Observacao) ;
  FiscNETComando.AddParamDouble('Valor',Valor) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.FechaCupom(Observacao: AnsiString; IndiceBMP : Integer);
var
  Obs: AnsiString;
begin
  Obs := Observacao ;

  if not Consumidor.Enviado then
  begin
     { Removendo o Consumidor da Observação, pois vai usar comando próprio }
     Obs := StringReplace(Obs,#10+'CPF/CNPJ consumidor: '+Consumidor.Documento,'',[]) ;
     Obs := StringReplace(Obs,#10+'Nome: '+Consumidor.Nome,'',[]) ;
     Obs := StringReplace(Obs,#10+'Endereco: '+Consumidor.Endereco,'',[]) ;
     try
        { Se tiver Observações no rodape, deve enviar antes do consumidor }
        if Obs <> '' then
        begin
           FiscNETComando.NomeComando := 'ImprimeTexto' ;
           FiscNETComando.AddParamString('TextoLivre',Obs);
           EnviaComando ;
           Obs := '' ;
        end ;

        FiscNETComando.NomeComando := 'IdentificaConsumidor' ;
        FiscNETComando.AddParamString('IdConsumidor',LeftStr(Consumidor.Documento,29)) ;
        if Consumidor.Nome <> '' then
           FiscNETComando.AddParamString('NomeConsumidor',LeftStr(Consumidor.Nome,30)) ;
        if Consumidor.Nome <> '' then
           FiscNETComando.AddParamString('EnderecoConsumidor',LeftStr(Consumidor.Endereco,80)) ;
        EnviaComando ;
        Consumidor.Enviado := True ;
     except
//        Obs := Observacao ;
     end ;
  end ;

     { Tem PAF ? }     { PAF ainda não está na Obs ?}
  if (fsPAF <> '') and (pos(fsPAF,Obs) = 0) then
     if Obs = '' then
        Obs := fsPAF
     else 
        Obs := fsPAF + #10 + Obs ;

  if (Obs <> '') then
  begin
     FiscNETComando.NomeComando := 'ImprimeTexto' ;
     FiscNETComando.AddParamString('TextoLivre',Obs);
     EnviaComando ;
  end ;

  FiscNETComando.NomeComando := 'EncerraDocumento' ;
  FiscNETComando.TimeOut     := 5 ;
  FiscNETComando.AddParamString('Operador',Operador) ;
  EnviaComando ;

  fsEmPagamento := false ;
end;

procedure TACBrECFFiscNET.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : AnsiString);
begin
  fsEmPagamento := True ;
  if DescontoAcrescimo = 0 then
     exit ;
  FiscNETComando.NomeComando := 'AcresceSubtotal' ;
  FiscNETComando.AddParamBool('Cancelar',False) ;
  FiscNETComando.AddParamDouble('ValorAcrescimo',DescontoAcrescimo) ;
  EnviaComando ;
end;

Procedure TACBrECFFiscNET.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
var
  CodAliq: Integer;
begin
  Unidade := padL(Unidade,2) ;

  try
     CodAliq := StrToInt(AliquotaECF) ;
  except
     raise EACBrECFCMDInvalido.Create(ACBrStr('Aliquota Inválida: '+AliquotaECF));
  end ;

  try
    with FiscNETComando do
    begin
       if fsComandoVendeItem = '' then
          NomeComando := 'VendeItem'
       else
          NomeComando := fsComandoVendeItem ;
          
       AddParamInteger('CodAliquota',CodAliq) ;
       AddParamString('CodProduto',LeftStr(Codigo,48));
       AddParamString('NomeProduto',LeftStr(Descricao,200));
       AddParamDouble('PrecoUnitario',ValorUnitario);
       AddParamDouble('Quantidade',Qtd);
       AddParamString('Unidade',Unidade);
    end ;
    EnviaComando ;
  except
     on E : Exception do
     begin
        if (fsComandoVendeItem = '') and
           (pos('ComandoInexistente',E.Message) > 0) then   // Não reconheceu o comando
         begin
           fsComandoVendeItem := 'VendaDeItem' ;
           VendeItem( Codigo,Descricao,AliquotaECF,Qtd,ValorUnitario,
                      ValorDescontoAcrescimo,Unidade,TipoDescontoAcrescimo,
                      DescontoAcrescimo );
         end
        else
           raise ;
     end ;
  end ;

  { Se o desconto é maior que zero dá o comando de desconto de item }
  if ValorDescontoAcrescimo > 0 then
     DescontoAcrescimoItemAnterior( ValorDescontoAcrescimo, DescontoAcrescimo,
        TipoDescontoAcrescimo );

  fsEmPagamento := false ;
end;

procedure TACBrECFFiscNET.DescontoAcrescimoItemAnterior(
   ValorDescontoAcrescimo : Double ; DescontoAcrescimo : String ;
   TipoDescontoAcrescimo : String ; NumItem : Integer) ;
begin
  if DescontoAcrescimo = 'D' then
     ValorDescontoAcrescimo := -ValorDescontoAcrescimo ;

  FiscNETComando.NomeComando := 'AcresceItemFiscal' ;
  if TipoDescontoAcrescimo = '%' then
     FiscNETComando.AddParamDouble('ValorPercentual',ValorDescontoAcrescimo)
  else
     FiscNETComando.AddParamDouble('ValorAcrescimo',ValorDescontoAcrescimo);

  if NumItem > 0 then
     FiscNETComando.AddParamInteger('NumItem',NumItem) ;

  FiscNETComando.AddParamBool('Cancelar',False);

  EnviaComando ;
end ;

procedure TACBrECFFiscNET.CarregaAliquotas;
var
  A        : Integer;
  Aliquota : TACBrECFAliquota ;
  ValAliq  : Double ;
  TipoAliq : Char ;
  Erro     : Boolean ;
begin
  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  { Lê as alíquotas cadastradas na impressora }
  A    := 0 ;
  Erro := False ;
  while (A <= 15) and (not Erro) do
  begin
     FiscNETComando.NomeComando := 'LeAliquota' ;
     FiscNETComando.AddParamInteger('CodAliquotaProgramavel',A) ;
     try
        EnviaComando ;

        ValAliq  := StringToFloat(
                         FiscNETResposta.Params.Values['PercentualAliquota'] );
        if UpCase(
            FiscNETResposta.Params.Values['AliquotaICMS'][1]) in ['F','N'] then
           TipoAliq := 'S'
        else
           TipoAliq := 'T' ;
        Aliquota          := TACBrECFAliquota.create ;
        Aliquota.Indice   :=
            FiscNETResposta.Params.Values['CodAliquotaProgramavel'] ;
        Aliquota.Aliquota := ValAliq ;
        Aliquota.Tipo     := TipoAliq ;

        fpAliquotas.Add( Aliquota ) ;
     except
        on E : Exception do
        begin
           Erro := (pos('ErroCMDAliquotaNaoCarregada',E.Message) = 0)
        end ;
     end;

     Inc( A ) ;
  end;

  if Erro then   { "niliza" para tentar carregar novamente no futuro }
  begin
     fpAliquotas.Free ;
     fpAliquotas := nil ;
  end ;
end;

procedure TACBrECFFiscNET.LerTotaisAliquota;
var
  A: Integer;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  For A := 0 to Aliquotas.Count-1 do
  begin
     FiscNETComando.NomeComando := 'LeMoeda' ;
     FiscNETComando.AddParamString('NomeDadoMonetario',
                               'TotalDiaValorAliquota['+Trim(Aliquotas[A].indice)+']') ;
     EnviaComando ;

     Aliquotas[A].Total := StringToFloatDef(
        RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
  end ;   
end;


procedure TACBrECFFiscNET.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
var
  AliqECF : TACBrECFAliquota;
  Descr   : String ;
begin
  Tipo := UpCase(Tipo) ;
  if not (Tipo in ['T','S']) then
     Tipo := 'T' ;

  if Tipo = 'T' then
     Descr := 'ICMS: '
  else
     Descr := 'ISS: ' ;
  Descr := Descr + FloatToStr(Aliquota)+'%' ;

  with FiscNETComando do
  begin
     NomeComando := 'DefineAliquota' ;
     AddParamBool('AliquotaICMS',(Tipo = 'T')) ;
     AddParamInteger('CodAliquotaProgramavel', StrToIntDef(Posicao,-1) ) ;
     AddParamString('DescricaoAliquota', Descr)  ;
     AddParamDouble('PercentualAliquota',Aliquota);
  end ;
  EnviaComando ;

  { Adicionanodo nova Aliquota no ObjectList }
  if Assigned( fpAliquotas ) then
  begin
     AliqECF          := TACBrECFAliquota.create ;
     AliqECF.Indice   := FiscNETResposta.Params.Values['CodAliquotaProgramavel'] ;
     AliqECF.Aliquota := Aliquota ;
     AliqECF.Tipo     := Tipo ;

     fpAliquotas.Add( AliqECF ) ;
  end ;
end;

function TACBrECFFiscNET.AchaICMSAliquota( var AliquotaICMS: String):
   TACBrECFAliquota;
var
  AliquotaStr: string;
begin
  AliquotaStr := '' ;
  Result      := nil ;

  if copy(AliquotaICMS,1,2) = 'SF' then
     AliquotaStr := '-11'
  else if copy(AliquotaICMS,1,2) = 'SN' then
     AliquotaStr := '-13'
  else if copy(AliquotaICMS,1,2) = 'SI' then
     AliquotaStr := '-12'
  else
     case AliquotaICMS[1] of
        'F' : AliquotaStr := '-2' ;
        'I' : AliquotaStr := '-3' ;
        'N' : AliquotaStr := '-4' ;
        'T' :
           try
              AliquotaICMS := 'T'+IntToStr(StrToInt(copy(AliquotaICMS,2,2))) ; {Indice}
           except
               raise EACBrECFCMDInvalido.Create(ACBrStr('Aliquota Inválida: '+AliquotaICMS));
           end ;
     end ;

  if AliquotaStr = '' then
     Result := inherited AchaICMSAliquota( AliquotaICMS )
  else
     AliquotaICMS := AliquotaStr ;
end;


procedure TACBrECFFiscNET.CarregaFormasPagamento;
  Function SubCarregaFormasPagamento(Indice : Integer) : Boolean ;
  var
    FPagto: TACBrECFFormaPagamento;
  begin
     Result := True ;
     FiscNETComando.NomeComando := 'LeMeioPagamento' ;
     FiscNETComando.AddParamInteger('CodMeioPagamentoProgram',Indice) ;
     try
        EnviaComando ;

        FPagto := TACBrECFFormaPagamento.create ;
        FPagto.Indice :=
            FiscNETResposta.Params.Values['CodMeioPagamentoProgram'] ;
        FPagto.Descricao := FiscNETResposta.Params.Values['NomeMeioPagamento'] ;
        FPagto.PermiteVinculado := ( UpCase(
           FiscNETResposta.Params.Values['PermiteVinculado'][1]) in ['T','Y']) ;

        fpFormasPagamentos.Add( FPagto ) ;
     except
        on E : Exception do
        begin
           Result := (pos('ErroCMDFormaPagamentoIndefinida',E.Message) <> 0)
        end ;
     end;
  end ;

var
  A    : Integer;
  Erro : Boolean ;
begin
  inherited CarregaFormasPagamento ;   { Cria fpFormasPagamentos }

  Erro :=  not SubCarregaFormasPagamento(-2) ; { Le Forma Padrão (fixa) -2 = Dinheiro }

  { Lê as Formas de Pagamento cadastradas na impressora }
  A := 0 ;
  while (A <= 14) and (not Erro) do
  begin
     Erro := not SubCarregaFormasPagamento(A);
     Inc( A )
  end ;

  if Erro then   { "niliza" para tentar carregar novamente no futuro }
  begin
     fpFormasPagamentos.Free ;
     fpFormasPagamentos := nil ;
  end ;
end;

procedure TACBrECFFiscNET.LerTotaisFormaPagamento;
var
  A: Integer;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  A := 0 ;
  while fsBaseTotalDiaMeioPagamento = 99 do
  begin
    FiscNETComando.NomeComando := 'LeMoeda' ;
    FiscNETComando.AddParamString('NomeDadoMonetario',
                                  'TotalDiaMeioPagamento['+IntToStrZero(A,2)+']');
    try
       EnviaComando ;
       fsBaseTotalDiaMeioPagamento := A;
    except
       On E : Exception do
       begin
          if Pos('11017',E.Message) > 0 then  // ErroProtIndiceRegistrador
             Inc(A)
          else
             raise ;
       end ;
    end ;
  end ;

  For A := 0 to FormasPagamento.Count-1 do
  begin
     FiscNETComando.NomeComando := 'LeMoeda' ;
     if A = 0 then
        FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaDinheiro')
     else
        FiscNETComando.AddParamString('NomeDadoMonetario',
          'TotalDiaMeioPagamento['+IntToStrZero(A+fsBaseTotalDiaMeioPagamento-1,2)+']');
     EnviaComando ;

     FormasPagamento[A].Total := StringToFloatDef(
        RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
  end ;
end;

procedure TACBrECFFiscNET.ProgramaFormaPagamento( var Descricao: String;
  PermiteVinculado : Boolean; Posicao : String) ;
var
  FPagto: TACBrECFFormaPagamento;
begin
  with FiscNETComando do
  begin
     NomeComando := 'DefineMeioPagamento' ;
     if StrToIntDef(Posicao,-1) >= 0 then
        AddParamInteger('CodMeioPagamentoProgram', StrToInt(Posicao) ) ;
     AddParamString('DescricaoMeioPagamento',Descricao) ;
     AddParamString('NomeMeioPagamento',Descricao) ;
     AddParamBool('PermiteVinculado',PermiteVinculado) ;
  end ;
  EnviaComando ;

  { Adicionanodo nova FPG no ObjectList }
  if Assigned( fpFormasPagamentos ) then
  begin
     FPagto := TACBrECFFormaPagamento.create ;
     FPagto.Indice    := FiscNETResposta.Params.Values['CodMeioPagamentoProgram'] ;
     FPagto.Descricao := Descricao ;
     FPagto.PermiteVinculado :=  PermiteVinculado ;

     fpFormasPagamentos.Add( FPagto ) ;
  end ;
end;

procedure TACBrECFFiscNET.CarregaComprovantesNaoFiscais;
var
  A    : Integer;
  CNF  : TACBrECFComprovanteNaoFiscal ;
  Erro : Boolean ;
begin
  inherited CarregaComprovantesNaoFiscais ;

  A    := 0 ;
  Erro := False ;
  while (A <= 14) and (not Erro) do
  begin
     FiscNETComando.NomeComando := 'LeNaoFiscal' ;
     FiscNETComando.AddParamInteger('CodNaoFiscal',A) ;
     try
        EnviaComando ;

        CNF := TACBrECFComprovanteNaoFiscal.create ;

        CNF.Indice    := FiscNETResposta.Params.Values['CodNaoFiscal'] ;
        CNF.Descricao := FiscNETResposta.Params.Values['NomeNaoFiscal'] ;

        fpComprovantesNaoFiscais.Add( CNF ) ;
     except
        on E : Exception do
        begin
           Erro := (pos('ErroCMDNaoFiscalIndefinido',E.Message) = 0)
        end ;
     end;

     Inc( A ) ;
  end ;

  if Erro then   { "niliza" para tentar carregar novamente no futuro }
  begin
     fpComprovantesNaoFiscais.Free ;
     fpComprovantesNaoFiscais := nil ;
  end ;
end;

procedure TACBrECFFiscNET.LerTotaisComprovanteNaoFiscal;
var
  A: Integer;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  A := 0 ;
  while fsBaseTotalDiaNaoFiscal = 99 do
  begin
    FiscNETComando.NomeComando := 'LeMoeda' ;
    FiscNETComando.AddParamString('NomeDadoMonetario',
                                  'TotalDiaNaoFiscal['+IntToStrZero(A,2)+']');
    try
       EnviaComando ;
       fsBaseTotalDiaNaoFiscal := A;
    except
       On E : Exception do
       begin
          if Pos('11017',E.Message) > 0 then  // ErroProtIndiceRegistrador
             Inc(A)
          else
             raise ;
       end ;
    end ;
  end ;

  For A := 0 to ComprovantesNaoFiscais.Count-1 do
  begin
     FiscNETComando.NomeComando := 'LeMoeda' ;
     FiscNETComando.AddParamString('NomeDadoMonetario',
        'TotalDiaNaoFiscal['+IntToStrZero(A+fsBaseTotalDiaNaoFiscal,2)+']');
     EnviaComando ;

     ComprovantesNaoFiscais[A].Total := StringToFloatDef(
        RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda']), 0) ;

     FiscNETComando.NomeComando := 'LeInteiro' ;
     FiscNETComando.AddParamString('NomeInteiro',
        'CON['+IntToStrZero(A+fsBaseTotalDiaNaoFiscal,2)+']');
     EnviaComando ;

     ComprovantesNaoFiscais[A].Contador := StrToIntDef(
         FiscNETResposta.Params.Values['ValorInteiro'], 0) ;
  end ;
end;

procedure TACBrECFFiscNET.ProgramaComprovanteNaoFiscal(var Descricao : String;
   Tipo: String; Posicao : String);
var
  CNF: TACBrECFComprovanteNaoFiscal;
begin
  with FiscNETComando do
  begin
     NomeComando := 'DefineNaoFiscal' ;
     AddParamInteger('CodNaoFiscal', StrToIntDef(Posicao,-1) ) ;
     AddParamString('DescricaoNaoFiscal',Descricao) ;
     AddParamString('NomeNaoFiscal',Descricao) ;
     AddParamBool('TipoNaoFiscal',
                  (not (UpCase(PadR(Tipo,1)[1]) in ['-','F','0'])) ) ;
  end ;
  EnviaComando ;

  { Adicionanodo novo CNF no ObjectList }
  if Assigned( fpComprovantesNaoFiscais ) then
  begin
     CNF := TACBrECFComprovanteNaoFiscal.create ;
     CNF.Indice    := FiscNETResposta.Params.Values['CodNaoFiscal'] ;
     CNF.Descricao := Descricao ;

     fpComprovantesNaoFiscais.Add( CNF ) ;
  end ;
end;

procedure TACBrECFFiscNET.AbreRelatorioGerencial(Indice: Integer = 0);
begin
  if Indice = 0 then
  begin
     try
        { Procurando por Relatorio Gerencial na posição informada na variável Indice... Se nao achar, programa }
        FiscNETComando.NomeComando := 'LeGerencial' ;
        FiscNETComando.AddParamInteger('CodGerencial', Indice ) ;
        EnviaComando ;
     except
        { Se nao existir,  gera exceção e nesse caso programa a posicao }
        FiscNETComando.NomeComando := 'DefineGerencial' ;
        FiscNETComando.AddParamInteger('CodGerencial', Indice ) ;
        FiscNETComando.AddParamString('DescricaoGerencial','Relatorio Gerencial') ;
        FiscNETComando.AddParamString('NomeGerencial','Relatorio Gerencial') ;
        EnviaComando ;
     end ;
  end ;

  FiscNETComando.NomeComando := 'AbreGerencial' ;
  FiscNETComando.TimeOut     := 5 ;
  FiscNETComando.AddParamInteger('CodGerencial', Indice ) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.LinhaRelatorioGerencial(Linha: AnsiString; IndiceBMP: Integer);
var
  P, Espera: Integer;
  Buffer   : AnsiString ;
  MaxChars : Integer ;
begin
  Linha    := AjustaLinhas( Linha, Colunas );  { Formata as Linhas de acordo com "Coluna" }
  MaxChars := 492 ;  { FiscNet aceita no máximo 492 caract. por comando }

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
     FiscNETComando.NomeComando := 'ImprimeTexto' ;
     FiscNETComando.TimeOut     := Espera ;
     FiscNETComando.AddParamString('TextoLivre',Buffer);
     EnviaComando ;

     { ficou apenas um LF sozinho ? }
     if (P = Colunas) and (RightStr( Buffer, 1) <> #10) and
        (copy( Linha, P+1, 1) = #10) then
        P := P + 1 ;

     Linha  := copy( Linha, P+1, Length(Linha) ) ;   // O Restante
  end ;
end;

procedure TACBrECFFiscNET.AbreCupomVinculado(COO, CodFormaPagto,
   CodComprovanteNaoFiscal :  String; Valor : Double ) ;
var
  FPG: TACBrECFFormaPagamento;
begin
  FPG := AchaFPGIndice( CodFormaPagto ) ;

  if FPG = nil then
     raise Exception.create( ACBrStr('Forma de Pagamento: '+CodFormaPagto+
                             ' não foi cadastrada.') ) ;

  FiscNETComando.NomeComando := 'AbreCreditoDebito' ;
  FiscNETComando.TimeOut     := 5 ;
  FiscNETComando.AddParamInteger('CodMeioPagamento',
                                 StrToIntDef(CodFormaPagto,0)) ;
  FiscNETComando.AddParamInteger('COO', StrToIntDef(COO,0));
  FiscNETComando.AddParamDouble('Valor',Valor);
  EnviaComando ;
end;

procedure TACBrECFFiscNET.LinhaCupomVinculado(Linha: AnsiString);
begin
  LinhaRelatorioGerencial( Linha );
end;

procedure TACBrECFFiscNET.FechaRelatorio;
begin
  if Estado = estRelatorio then
  begin
     FiscNETComando.NomeComando := 'EncerraDocumento' ;
     FiscNETComando.TimeOut     := 5 ;
     FiscNETComando.AddParamString('Operador',Operador) ;
     EnviaComando ;
  end ;
end;

procedure TACBrECFFiscNET.PulaLinhas(NumLinhas: Integer);
begin
  if NumLinhas = 0 then
     NumLinhas := LinhasEntreCupons ;

  { Alguem sabe quantos Dots tem 1 linha impressa ?? (no manual não consta :) )
    Estou considerando que uma Linha tem 30 dots }

  FiscNETComando.NomeComando := 'AvancaPapel' ;
  FiscNETComando.AddParamInteger('Avanco',NumLinhas * 30) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.CortaPapel(const CorteParcial: Boolean);
var
  TipoCorte: Integer;
begin
  if CorteParcial then
     TipoCorte := 1
  else
     TipoCorte := 0 ;

  FiscNETComando.NomeComando := 'CortaPapel';
  FiscNETComando.AddParamInteger('TipoCorte', TipoCorte);
  EnviaComando;
end;


procedure TACBrECFFiscNET.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal : Integer; Simplificada : Boolean);
begin
  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraMF' ;
     AddParamString('Destino','I') ;
     AddParamBool('LeituraSimplificada',Simplificada);
     AddParamString('Operador',Operador) ;
     AddParamInteger('ReducaoFinal',ReducaoFinal) ;
     AddParamInteger('ReducaoInicial',ReducaoInicial) ;
  end ;
  FiscNETComando.TimeOut := 30 + (ReducaoFinal - ReducaoInicial) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime; Simplificada : Boolean);
begin
  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraMF' ;
     AddParamDateTime('DataFinal',DataFinal) ;
     AddParamDateTime('DataInicial',DataInicial) ;
     AddParamString('Destino','I') ;
     AddParamBool('LeituraSimplificada',Simplificada);
     AddParamString('Operador',Operador) ;
  end ;
  FiscNETComando.TimeOut := 30 + DaysBetween(DataInicial,DataFinal) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; Linhas : TStringList; Simplificada : Boolean);
Var
  Leitura, RetCmd : AnsiString ;
begin
  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraMF' ;
     AddParamString('Destino','S') ;
     AddParamBool('LeituraSimplificada',Simplificada);
     AddParamString('Operador',Operador) ;
     AddParamInteger('ReducaoFinal',ReducaoFinal) ;
     AddParamInteger('ReducaoInicial',ReducaoInicial) ;
  end ;
  FiscNETComando.TimeOut := 30 + (ReducaoFinal - ReducaoInicial) ;
  EnviaComando ;
  Sleep(500);

  Leitura := '' ;
  Linhas.Clear ;
  repeat
     FiscNETComando.NomeComando := 'LeImpressao' ;
     EnviaComando ;

     RetCmd  := FiscNETResposta.Params.Values['TextoImpressao'] ;
     Leitura := Leitura + RetCmd ;
     sleep(100) ;
  until (RetCmd = '') ;

  Linhas.Text := AjustaLeitura( Leitura );
end;

procedure TACBrECFFiscNET.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; Linhas : TStringList; Simplificada : Boolean);
Var
  Leitura, RetCmd : AnsiString ;
begin
  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraMF' ;
     AddParamDateTime('DataFinal',DataFinal) ;
     AddParamDateTime('DataInicial',DataInicial) ;
     AddParamString('Destino','S') ;
     AddParamBool('LeituraSimplificada',Simplificada);
     AddParamString('Operador',Operador) ;
  end ;
  FiscNETComando.TimeOut := 30 + DaysBetween(DataInicial,DataFinal) ;
  EnviaComando ;
  Sleep(500);

  Leitura := '' ;
  Linhas.Clear ;
  repeat
     FiscNETComando.NomeComando := 'LeImpressao' ;
     EnviaComando ;

     RetCmd := FiscNETResposta.Params.Values['TextoImpressao'] ;
     Leitura := Leitura + RetCmd ;
     sleep(100) ;
  until (RetCmd = '') ;

  Linhas.Text := AjustaLeitura( Leitura );
end;

procedure TACBrECFFiscNET.LeituraMFDSerial(DataInicial,
  DataFinal: TDateTime; Linhas: TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos]);
Var
  Leitura, RetCmd : AnsiString ;
  Doctos : String ;
begin
  Doctos := DocumentosToStr(Documentos) ;

  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraFitaDetalhe' ;
     AddParamDateTime('DataFinal',DataFinal);
     AddParamDateTime('DataInicial',DataInicial);
     AddParamString('Destino','S') ;
     if Doctos <> '' then
        AddParamString('TipoDocumento',Doctos);
  end ;
  FiscNETComando.TimeOut := 5 + DaysBetween(DataInicial,DataFinal) ;
  EnviaComando ;
  Sleep(500);

  //WriteToTXT('d:\temp\mfd_ret.txt','', False);
  Leitura := '' ;
  repeat
     FiscNETComando.NomeComando := 'LeImpressao' ;
     EnviaComando ;

     RetCmd := FiscNETResposta.Params.Values['TextoImpressao'] ;
     //WriteToTXT('d:\temp\mfd_ret.txt',RetCmd, True);
     Leitura := Leitura + RetCmd ;
     sleep(100) ;
  until (RetCmd = '') ;

  Linhas.Text := AjustaLeitura( Leitura );
  //WriteToTXT('d:\temp\mfd_limpo.txt',Linhas.Text, False);
end;

procedure TACBrECFFiscNET.LeituraMFDSerial(COOInicial,
  COOFinal: Integer; Linhas: TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos]);
Var
  Leitura, RetCmd : AnsiString ;
  Doctos : String ;
begin
  Doctos := DocumentosToStr(Documentos) ;

  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraFitaDetalhe' ;
     AddParamInteger('COOFinal',COOFinal);
     AddParamInteger('COOInicial',COOInicial);
     AddParamString('Destino','S') ;
     if Doctos <> '' then
        AddParamString('TipoDocumento',Doctos);
  end ;
  FiscNETComando.TimeOut := 5 + (COOFinal - COOInicial) ;
  EnviaComando ;
  Sleep(400);

  Leitura := '' ;
  Linhas.Clear ;
  repeat
     FiscNETComando.NomeComando := 'LeImpressao' ;
     EnviaComando ;

     RetCmd := FiscNETResposta.Params.Values['TextoImpressao'] ;
     Leitura := Leitura + RetCmd ;
     sleep(100) ;
  until (RetCmd = '') ;

  Linhas.Text := AjustaLeitura( Leitura ) ;
end;

Function TACBrECFFiscNET.DocumentosToStr(Documentos : TACBrECFTipoDocumentoSet) : String ;
begin
  Result := '' ;
  if (docTodos in Documentos) then
     exit ;

  if docLX              in Documentos then Result := Result + '1,' ;
  if docRZ              in Documentos then Result := Result + '2,' ;
  if docCF              in Documentos then Result := Result + '3,' ;
  if docCNF             in Documentos then Result := Result + '4,5,6,'
  else
   begin
     if docSuprimento   in Documentos then Result := Result + '5,' ;
     if docSangria      in Documentos then Result := Result + '6,' ;
   end ;
  if docCFCancelamento  in Documentos then Result := Result + '7,8,' ;
  if docCNFCancelamento in Documentos then Result := Result + '9,' ;
  if docCupomAdicional  in Documentos then Result := Result + '10,' ;
  if docLMF             in Documentos then Result := Result + '11,' ;
  if docCCD             in Documentos then Result := Result + '12,13,14,' ;
  if docRG              in Documentos then Result := Result + '15,' ;
  if docEstornoPagto    in Documentos then Result := Result + '16,' ;
  if docEstornoCCD      in Documentos then Result := Result + '17,' ;

  Result := copy(Result,1,Length(Result)-1) ; // Remove a ultima Virgula
end ;

Function TACBrECFFiscNET.AjustaLeitura( AString : AnsiString ) : AnsiString ;
Var
  A, Cols : Integer ;
begin
  { Detectando o número de Colunas (não encontrei registrador no ECF que
    retorne o Numero de Colunas) }
  A := pos(StringOfChar('-',40), AString ) ;
  if A < 1 then
     Cols := Colunas
  else
   begin
     Cols := 40 ;
     while copy(AString,A+Cols,1) = '-' do
        Inc( Cols ) ;
   end ;

  { Remove caracteres de Impressao }
  Result := RemoveStrings( AString, fsComandosImpressao ) ;

  { Ajusta o Tamanho das Colunas }
  Result := AjustaLinhas( Result, Cols ) ;
end;

procedure TACBrECFFiscNET.CorrigeEstadoErro(Reducao: Boolean);
begin
  inherited CorrigeEstadoErro(Reducao) ;

  if Estado <> estLivre then
     try
        FiscNETComando.NomeComando := 'ReinicializaEquipamento' ;
        EnviaComando ;
        sleep(200) ;
     except
     end ;
end;

procedure TACBrECFFiscNET.CancelaImpressaoCheque;
begin
  FiscNETComando.NomeComando := 'ChancelaCheque' ;
  EnviaComando ;
end;

function TACBrECFFiscNET.GetChequePronto: Boolean;
begin
  FiscNETComando.NomeComando := 'LeIndicador' ;
  FiscNETComando.AddParamString('NomeIndicador','SensorCheque') ;
  EnviaComando ;

  Result := (FiscNETResposta.Params.Values['ValorNumericoIndicador'] = '1')
end;

procedure TACBrECFFiscNET.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
begin
   { Não implementado pois NAO encontrei uma tabela com as cordenadas de
     impressão para cada Banco }

 {14;ImprimeCheque;Cidade="Tatui" Data=#01/03/07# Favorecido="Daniel Simoes de Almeida" HPosAno=1 HPosCidade=2 HPosDia=3 HPosExtensoLinha1=4 HPosExtensoLinha2=5 HPosFavorecido=6 HPosMes=7 HPosMsgLinha1=8 HPosMsgLinha2=9 HPosMsgLinha3=10 HPosValor=11 MensagemDocLinha1="Msg DOC Linha 1" MensagemDocLinha2="Msg DOC Linha 1" MensagemDocLinha3="Msg DOC Linha 1" TempoEspera=10 Valor=100,00 VPosCidade=12 VPosExtensoLinha1=13 VPosExtensoLinha2=14 VPosFavorecido=15 VPosMsgLinha1=16 VPosMsgLinha2=17 VPosMsgLinha3=18 VPosValor=19;522}
end;

Function TACBrECFFiscNET.LeituraCMC7 : AnsiString ;     
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto', 'CMC7Documento') ;
  AguardaImpressao := True;
  EnviaComando ;
  sleep(500);
  
  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetCNPJ: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','CNPJ') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetIE: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','IE') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetIM: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','IM') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetCliche: AnsiString;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','Cliche') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetUsuarioAtual: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','ContadorProprietarios') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorInteiro'] ;
end;

function TACBrECFFiscNET.GetDataHoraSB: TDateTime;
Var RetCmd : AnsiString ;
    OldShortDateFormat : String ;
    Linhas : TStringList;
    i,x,nLinha, CRZ :Integer;
begin
  Result := 0.0;

  if Estado in [estLivre] then
  begin
    nLinha := -1;
    Linhas := TStringList.Create;

    try
      CRZ := StrToIntDef(NumCRZ, 0) ;
      LeituraMemoriaFiscalSerial(CRZ, CRZ, Linhas);

      for i := 0 to Linhas.Count-1 do
      begin
        if pos('SOFTWARE B', Linhas[i]) > 0 then
        begin
          for x := i+1 to Linhas.Count-1 do
          begin
            if StrToIntDef(StringReplace(Copy(Linhas[x], 1, 8), '.', '', [rfReplaceAll]), 0) = 0 then
            begin
               nLinha := x-1;
               break;
            end;
          end;
          Break;
        end;
      end;

      if nLinha >= 0 then
      begin
        // 01.00.01                    25/06/2009 21:07:40
        RetCmd := Linhas[nLinha] ;
        x := pos('/', RetCmd ) ;

        OldShortDateFormat := ShortDateFormat ;
        try
          ShortDateFormat := 'dd/mm/yyyy' ;
          Result := StrToDate( StringReplace( copy(RetCmd, x-2, 10 ),
                                           '/', DateSeparator, [rfReplaceAll] ) ) ;

          x := pos(':', RetCmd ) ;
          Result := RecodeHour(  result,StrToInt(copy(RetCmd, x-2,2))) ;
          Result := RecodeMinute(result,StrToInt(copy(RetCmd, x+1,2))) ;
          Result := RecodeSecond(result,StrToInt(copy(RetCmd, x+4,2))) ;
        finally
          ShortDateFormat := OldShortDateFormat ;
        end ;
      end
    finally
      Linhas.Free ;
    end ;
  end;
end;

function TACBrECFFiscNET.GetSubModeloECF: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','Modelo') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetDataMovimento: TDateTime;
var
  RetCmd: AnsiString;
  OldShortDateFormat : String ;
  bDiaAberto, bDiaFechado: boolean;
  sParam: String;
begin
   FiscNETComando.TimeOut := 15;
   FiscNETComando.NomeComando := 'LeIndicador' ;
   FiscNETComando.AddParamString('NomeIndicador','DiaAberto');
   EnviaComando ;
   bDiaAberto := FiscNETResposta.Params.Values['ValorTextoIndicador'] = '1';

   FiscNETComando.NomeComando := 'LeIndicador' ;
   FiscNETComando.AddParamString('NomeIndicador','DiaFechado');
   EnviaComando ;
   bDiaFechado := FiscNETResposta.Params.Values['ValorTextoIndicador'] = '1';

   if not (bDiaAberto or bDiaFechado) then
      sParam := 'Data'
   else
      sParam := 'DataAbertura';

  FiscNETComando.NomeComando := 'LeData' ;
  FiscNETComando.AddParamString('NomeData', sParam);
  EnviaComando ;
  RetCmd := FiscNETResposta.Params.Values['ValorData'] ;
  RetCmd := StringReplace(RetCmd ,'/',DateSeparator, [rfReplaceAll] );
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yyyy' ;
     Result := StrToDate( RetCmd ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
end;

function TACBrECFFiscNET.GetGrandeTotal: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','GT') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.',FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetNumCRZ: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','CRZ') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetTotalAcrescimos: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaAcrescimos') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.',FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
end;

function TACBrECFFiscNET.GetTotalAcrescimosISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaAcrescimosISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.',FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
end;



function TACBrECFFiscNET.GetTotalCancelamentos: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaCancelamentosIcms') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalCancelamentosISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaCancelamentosISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;



function TACBrECFFiscNET.GetTotalDescontos: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaDescontos') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalTroco: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaTroco') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;


function TACBrECFFiscNET.GetTotalDescontosISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaDescontosISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalSubstituicaoTributaria: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaSubstituicaoTributariaICMS') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalSubstituicaoTributariaISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaSubstituicaoTributariaISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalIsencao: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaIsencaoICMS') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalIsencaoISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaIsencaoISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalNaoTributado: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaNaoTributadoICMS') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalNaoTributadoISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaNaoTributadoISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetVendaBruta: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaVendaBruta') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetNumCOOInicial: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','COOInicioDia') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumUltimoItem: Integer;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','ContadorDocUltimoItemVendido') ;
  EnviaComando ;

  Result := StrToIntDef( FiscNETResposta.Params.Values['ValorInteiro'],0 ) ;
end;

procedure TACBrECFFiscNET.AbreNaoFiscal(CPF_CNPJ : String ; Nome : String ;
   Endereco : String) ;
begin
  FiscNETComando.NomeComando := 'AbreCupomNaoFiscal' ;
  FiscNETComando.TimeOut     := 5 ;
  FiscNETComando.AddParamString('IdConsumidor',LeftStr(CPF_CNPJ,29)) ;
  if Nome <> '' then
     FiscNETComando.AddParamString('NomeConsumidor',LeftStr(Nome,30)) ;
  if Endereco <> '' then
     FiscNETComando.AddParamString('EnderecoConsumidor',LeftStr(Endereco,80)) ;

  EnviaComando ;
end;

procedure TACBrECFFiscNET.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: AnsiString);
begin
  FiscNETComando.NomeComando := 'EmiteItemNaoFiscal' ;
  FiscNETComando.TimeOut     := 5 ;
  FiscNETComando.AddParamInteger('CodNaoFiscal',StrToInt(CodCNF) ) ;
  FiscNETComando.AddParamDouble('Valor',Valor) ;
  EnviaComando ;
end;

function TACBrECFFiscNET.GetArredonda: Boolean;
begin
  if fsArredonda < 0 then
  begin
     try
        FiscNETComando.NomeComando := 'LeInteiro' ;
        FiscNETComando.AddParamString('NomeInteiro','Arredondamento') ;
        EnviaComando ;

        fsArredonda :=  StrToIntDef( FiscNETResposta.Params.Values['ValorInteiro'],0 ) ;
     except
        on E : Exception do
        begin
           // Erro: 11011 - ErroProtNomeRegistrador Parametro NomeInteiro contem nome de registrador inexistente
           if (pos('ErroProtNomeRegistrador',E.Message) = 0) then
              raise ;
           fsArredonda := 1 ;  // Não tem o comando, assume Truncamento
        end ;
     end ;
  end ;

  { Os valores válidos são: 0 para arredondamento segundo ABNT,
                            1 para truncamento e
                            2 para arredondamento para cima  }
  Result := (fsArredonda = 0) or (fsArredonda = 2) ;
end;

procedure TACBrECFFiscNET.NaoFiscalCompleto(CodCNF: String; Valor: Double;
  CodFormaPagto: String; Obs: AnsiString; IndiceBMP : Integer);
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

        try
           FechaNaoFiscal( Obs );
        except
           FechaNaoFiscal        // Tenta sem Obs
        end ;
     except
        try
           CancelaNaoFiscal
        except
        end;

        raise ;
     end ;
  end ;
end;

procedure TACBrECFFiscNET.CarregaRelatoriosGerenciais;
  Function SubCarregaGerenciais(Indice : Integer) : Boolean ;
  var
    RG: TACBrECFRelatorioGerencial;
  begin
     Result := True ;
     FiscNETComando.NomeComando := 'LeGerencial' ;
     FiscNETComando.AddParamInteger('CodGerencial',Indice) ;
     try
        EnviaComando ;

        RG := TACBrECFRelatorioGerencial.create ;
        RG.Indice    := FiscNETResposta.Params.Values['CodGerencial'] ;
        RG.Descricao := FiscNETResposta.Params.Values['NomeGerencial'] ;

        fpRelatoriosGerenciais.Add( RG ) ;
     except
        on E : Exception do
        begin
           Result := (pos('ErroCMDGerencialNaoDefinido',E.Message) <> 0)
        end ;
     end;
  end ;

var
  A    : Integer;
  Erro : Boolean ;
begin
  inherited CarregaRelatoriosGerenciais ;   { Cria fpRelatoriosGerenciais }

  Erro := False ;

  { Lê as Formas de Pagamento cadastradas na impressora }
  A := 0 ;
  while (A <= 19) and (not Erro) do
  begin
     Erro := not SubCarregaGerenciais(A);
     Inc( A )
  end ;

  if Erro then   { "niliza" para tentar carregar novamente no futuro }
  begin
     fpRelatoriosGerenciais.Free ;
     fpRelatoriosGerenciais := nil ;
  end ;
end;

procedure TACBrECFFiscNET.LerTotaisRelatoriosGerenciais ;
var
  A: Integer;
begin
  if not Assigned( fpRelatoriosGerenciais ) then
     CarregaRelatoriosGerenciais ;

  For A := 0 to RelatoriosGerenciais.Count-1 do
  begin
     FiscNETComando.NomeComando := 'LeInteiro' ;
     FiscNETComando.AddParamString('NomeInteiro','CER['+RelatoriosGerenciais[A].Indice+']');
     EnviaComando ;

     RelatoriosGerenciais[A].Contador := StrToIntDef(
        FiscNETResposta.Params.Values['ValorInteiro'], 0) ;
  end ;
end ;

procedure TACBrECFFiscNET.ProgramaRelatorioGerencial(var Descricao: String;
  Posicao: String);
var
  RG: TACBrECFRelatorioGerencial;
begin
  with FiscNETComando do
  begin
     NomeComando := 'DefineGerencial' ;
     if StrToIntDef(Posicao,-1) >= 0 then
        AddParamInteger('CodGerencial', StrToInt(Posicao) ) ;
     AddParamString('DescricaoGerencial',Descricao) ;
     AddParamString('NomeGerencial',Descricao) ;
  end ;
  EnviaComando ;

  { Adicionanodo novo RG no ObjectList }
  if Assigned( fpRelatoriosGerenciais ) then
  begin
     RG := TACBrECFRelatorioGerencial.create ;
     RG.Indice    := FiscNETResposta.Params.Values['CodGerencial'] ;
     RG.Descricao := Descricao ;

     fpRelatoriosGerenciais.Add( RG ) ;
  end ;
end;

procedure TACBrECFFiscNET.IdentificaPAF(Linha1, Linha2: String);  
begin
   fsPAF := Linha1 + #10 + Linha2 ;
   FiscNETComando.NomeComando := 'EscreveTexto' ;
   FiscNETComando.AddParamString('NomeTexto' ,'TextoLivre') ;
   FiscNETComando.AddParamString('ValorTexto', fsPAF ) ;
   EnviaComando ;
end;

function TACBrECFFiscNET.GetPAF: String;   
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','TextoLivre') ;
  EnviaComando ;
  fsPAF  := FiscNETResposta.Params.Values['ValorTexto'] ;
  Result := fsPAf ;
end;

function TACBrECFFiscNET.GetParamDescontoISSQN: Boolean;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','PermiteISS') ;
  EnviaComando ;
  try
    Result  := StrToIntDef(FiscNETResposta.Params.Values['ValorInteiro'], 0) = 15 ;
  except
     Result := False;
  end;
end;

procedure TACBrECFFiscNET.LoadDLLFunctions;
Var
  LIB_FiscNet : String ;

 procedure FiscNetFunctionDetect( LibName, FuncName: String; var LibPointer: Pointer ) ;
 var
 sLibName: string;
 begin
   if not Assigned( LibPointer )  then
   begin
     // Verifica se exite o caminho das DLLs
     if Length(PathDLL) > 0 then
        sLibName := PathWithDelim(PathDLL);

     // Concatena o caminho se exitir mais o nome da DLL.
     sLibName := sLibName + LibName;

     if not FunctionDetect( sLibName, FuncName, LibPointer) then
     begin
        LibPointer := NIL ;
        raise Exception.Create( ACBrStr( 'Erro ao carregar a função:'+FuncName+' de: '+LibName ) ) ;
     end ;
   end ;
 end ;
begin
  FiscNETComando.NomeComando := 'LeTexto';
  FiscNETComando.AddParamString('NomeTexto','Marca');
  EnviaComando;
  fsMarcaECF := FiscNETResposta.Params.Values['ValorTexto'] ;
  fsMarcaECF := LowerCase(Trim(fsMarcaECF)) ;

  if pos(fsMarcaECF, 'dataregis|termoprinter') > 0 then
   begin
     LIB_FiscNet := 'DLLG2_Gerador.dll' ;
     FiscNetFunctionDetect(LIB_FiscNet, 'Gera_AtoCotepe1704_Periodo_MFD',@xGera_AtoCotepe1704_Periodo_MFD );
     FiscNetFunctionDetect(LIB_FiscNet, 'Gera_PAF',@xGera_PAF );
   end

  else if (fsMarcaECF = 'elgin') then
   begin
     LIB_FiscNet := 'Elgin.dll' ;

     FiscNetFunctionDetect(LIB_FiscNet, 'Elgin_AbrePortaSerial', @xElgin_AbrePortaSerial );
     FiscNetFunctionDetect(LIB_FiscNet, 'Elgin_FechaPortaSerial', @xElgin_FechaPortaSerial );
     FiscNetFunctionDetect(LIB_FiscNet, 'Elgin_DownloadMFD', @xElgin_DownloadMFD );
     FiscNetFunctionDetect(LIB_FiscNet, 'Elgin_FormatoDadosMFD', @xElgin_FormatoDadosMFD );
     FiscNetFunctionDetect(LIB_FiscNet, 'Elgin_LeMemoriasBinario', @xElgin_LeMemoriasBinario );
     FiscNetFunctionDetect(LIB_FiscNet, 'Elgin_GeraArquivoATO17Binario', @xElgin_GeraArquivoATO17Binario  );
   end
  else
   begin
     FiscNetFunctionDetect('Leitura.dll', 'DLLReadLeMemorias',  @xDLLReadLeMemorias );
     FiscNetFunctionDetect('ATO17.dll',   'DLLATO17GeraArquivo', @xDLLATO17GeraArquivo );
   end ;
end;

procedure TACBrECFFiscNET.AbrePortaSerialDLL(const Porta, Path: String);
Var
  Resp : Integer ;
  IniFile : String ;
  Ini  : TIniFile ;
begin
  if (fsMarcaECF = 'elgin') then
  begin
     Resp := xElgin_AbrePortaSerial();
     {
     1: Indica que nenhum erro ocorreu
     -4: O arquivo de inicialização Elgin.ini não foi encontrado no diretório de sistema do Windows.
     -5: Erro ao abrir a porta de comunicação.
     -50: Número de série inválido.
     }
     if (Resp = -4) or (Resp = -5) then
     begin
        IniFile := ExtractFilePath(
             {$IFNDEF CONSOLE} Application.ExeName {$ELSE} ParamStr(0) {$ENDIF}
                                       )+'ELGIN.ini' ;
        Ini := TIniFile.Create( IniFile );
        try
           Ini.WriteString('Sistema','Porta',Porta ) ;
           Ini.WriteString('Sistema','Path',Path ) ;
           Ini.WriteString('Sistema','PathRFD', Path );
           Ini.WriteString('Sistema','Gera_RFD_REDZ', '1');
        finally
           Ini.Free ;
        end ;

        Resp := xElgin_AbrePortaSerial();
     end ;

     if Resp <> 1 then
        raise Exception.Create( ACBrStr('Erro: '+IntToStr(Resp)+' ao abrir a Porta com:'+sLineBreak+
        'Elgin_AbrePortaSerial()'));
  end ;
end;

procedure TACBrECFFiscNET.EspelhoMFD_DLL(DataInicial, DataFinal: TDateTime; NomeArquivo: AnsiString;
  Documentos: TACBrECFTipoDocumentoSet);
Var
  iRet : Integer;
  PortaSerial : String;
  DiaIni, DiaFim, ArqTmp : String ;
  OldAtivo : Boolean ;
begin
  if (fsMarcaECF <> 'elgin') then
  begin
     TACBrECF(fpOwner).LeituraMFDSerial( DataInicial, DataFinal, NomeArquivo, Documentos );
     exit ;
  end ;

  LoadDLLFunctions;

  DiaIni := FormatDateTime('ddmmyy', DataInicial) ;
  DiaFim := FormatDateTime('ddmmyy', DataFinal) ;

  PortaSerial := fpDevice.Porta ;
  OldAtivo    := Ativo ;
  try
     Ativo := False ;

     AbrePortaSerialDLL( PortaSerial, ExtractFilePath( NomeArquivo ) ) ;

     ArqTmp := ExtractFilePath( NomeArquivo ) ;
     DeleteFile( ArqTmp + '.mfd' ) ;

     iRet := xElgin_DownloadMFD(ArqTmp + '.mfd', '1', DiaIni, DiaFim, '');
     if (iRet <> 1) then
        raise Exception.Create( ACBrStr( 'Erro ao executar Elgin_DownloadMFD.'+sLineBreak+
                                         'Cod.: ' + IntToStr(iRet) )) ;
     if not FileExists( ArqTmp + '.mfd' ) then
        raise Exception.Create( ACBrStr( 'Erro na execução de Elgin_DownloadMFD.'+sLineBreak+
                                         'Arquivo: "' + ArqTmp + '.mfd" não gerado' )) ;

     iRet := xElgin_FormatoDadosMFD(ArqTmp + '.mfd', nomeArquivo, '0', '1', DiaIni, DiaFim, '');
     if (iRet <> 1) then
        raise Exception.Create( ACBrStr( 'Erro ao executar Elgin_FormatoDadosMFD.'+sLineBreak+
                                         'Cod.: ' + IntToStr(iRet) )) ;
     if not FileExists( NomeArquivo ) then
        raise Exception.Create( ACBrStr( 'Erro na execução de Elgin_FormatoDadosMFD.'+sLineBreak+
                                         'Arquivo: "' + NomeArquivo + '" não gerado' )) ;
     xElgin_FechaPortaSerial();
     DeleteFile( ArqTmp + '.mfd' ) ;
  finally
    Ativo := OldAtivo ;
  end;
end;

procedure TACBrECFFiscNET.EspelhoMFD_DLL(COOInicial, COOFinal: Integer; NomeArquivo: AnsiString;
  Documentos: TACBrECFTipoDocumentoSet);
Var
  iRet : Integer;
  PortaSerial : String;
  CooIni, CooFim, Prop, ArqTmp : String ;
  OldAtivo : Boolean ;
begin
  if (fsMarcaECF <> 'elgin') then
  begin
     TACBrECF(fpOwner).LeituraMFDSerial( COOInicial, COOFinal, NomeArquivo, Documentos );
     exit ;
  end ;

  LoadDLLFunctions;

  CooIni := IntToStrZero( COOInicial, 6 ) ;
  CooFim := IntToStrZero( COOFinal, 6 ) ;
  Prop   := IntToStr( StrToIntDef( UsuarioAtual, 1) ) ;

  PortaSerial := fpDevice.Porta ;

  OldAtivo := Ativo ;
  try
     Ativo := False ;

     AbrePortaSerialDLL( PortaSerial, ExtractFilePath( NomeArquivo ) ) ;

     ArqTmp := ExtractFilePath( NomeArquivo ) ;
     DeleteFile( ArqTmp + '.mfd' ) ;

     iRet := xElgin_DownloadMFD(ArqTmp + '.mfd', '2', CooIni, CooFim, Prop);
     if (iRet <> 1) then
        raise Exception.Create( ACBrStr( 'Erro ao executar Elgin_DownloadMFD.'+sLineBreak+
                                         'Cod.: ' + IntToStr(iRet) )) ;
     if not FileExists( ArqTmp + '.mfd' ) then
        raise Exception.Create( ACBrStr( 'Erro na execução de Elgin_DownloadMFD.'+sLineBreak+
                                         'Arquivo: "' + ArqTmp + '.mfd" não gerado' )) ;

     iRet := xElgin_FormatoDadosMFD(ArqTmp + '.mfd', nomeArquivo, '0', '2', CooIni, CooFim, Prop);
     if (iRet <> 1) then
        raise Exception.Create( ACBrStr( 'Erro ao executar Elgin_FormatoDadosMFD.'+sLineBreak+
                                         'Cod.: ' + IntToStr(iRet) )) ;
     if not FileExists( NomeArquivo ) then
        raise Exception.Create( ACBrStr( 'Erro na execução de Elgin_FormatoDadosMFD.'+sLineBreak+
                                         'Arquivo: "' + NomeArquivo + '" não gerado' )) ;
     xElgin_FechaPortaSerial();
     DeleteFile( ArqTmp + '.mfd' ) ;
  finally
    Ativo := OldAtivo ;
  end;
end;

procedure TACBrECFFiscNET.ArquivoMFD_DLL(DataInicial, DataFinal: TDateTime;
  NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet;
  Finalidade: TACBrECFFinalizaArqMFD);
Var
  iRet : Integer;
  PortaSerial, ModeloECF, NumFab, ArqTmp, Prop : AnsiString;
  DiaIni, DiaFim : AnsiString;
  OldAtivo  : Boolean;
  cFinalidade:AnsiString;
begin
  NumFab      := NumSerie;
  ModeloECF   := SubModeloECF;
  PortaSerial := fpDevice.Porta;
  Prop        := IntToStr( StrToIntDef( UsuarioAtual, 1) ) ;

  LoadDLLFunctions;
  OldAtivo := Ativo;
  try
     Ativo := False;

     if pos(fsMarcaECF, 'urano') > 0 then
      begin
        if (Finalidade = finMF) then
           cFinalidade := 'MF'
        else if (Finalidade = finTDM) then
           cFinalidade := 'TDM'
        else
           cFinalidade := 'MFD';

        ArqTmp := ExtractFilePath( NomeArquivo ) + 'ACBr.TDM' ;
        if FileExists( NomeArquivo ) then
           DeleteFile( NomeArquivo ) ;
        
        DiaIni := FormatDateTime('yyyymmdd', DataInicial);
        DiaFim := FormatDateTime('yyyymmdd', DataFinal);

        iRet := xDLLReadLeMemorias( PortaSerial, ArqTmp, NumFab, '1');

        if iRet <> 0 then
           raise Exception.Create( ACBrStr( 'Erro ao executar DLLReadLeMemorias.' + sLineBreak +
                                            'Cod.: '+ IntToStr(iRet) + ' - ' +
                                            GetErroAtoCotepe1704(iRet) )) ;

        iRet := xDLLATO17GeraArquivo( ArqTmp, NomeArquivo, DiaIni, DiaFim,
                                      'M', '1', cFinalidade );

        if iRet <> 0 then
           raise Exception.Create( ACBrStr( 'Erro ao executar DLLATO17GeraArquivo.' + sLineBreak +
                                            'Cod.: '+ IntToStr(iRet) + ' - ' +
                                            GetErroAtoCotepe1704(iRet) )) ;
      end
     else if pos(fsMarcaECF, 'dataregis|termoprinter') > 0 then
      begin
        DiaIni := FormatDateTime('dd/mm/yyyy', DataInicial);
        DiaFim := FormatDateTime('dd/mm/yyyy', DataFinal);

        iRet := xGera_AtoCotepe1704_Periodo_MFD( PortaSerial, ModeloECF,
                                                 NomeArquivo, DiaIni, DiaFim );

        if iRet <> 0 then
           raise Exception.Create( ACBrStr( 'Erro ao executar Gera_AtoCotepe1704_Periodo_MFD.'+sLineBreak+
                                            'Cod.: '+IntToStr(iRet) + ' - ' +
                                            GetErroAtoCotepe1704(iRet) )) ;

        if not FileExists( NomeArquivo ) then
           raise Exception.Create( ACBrStr( 'Erro na execução de Gera_AtoCotepe1704_Periodo_MFD.'+sLineBreak+
                                            'Arquivo: "'+NomeArquivo + '" não gerado' ))
      end
     else if (fsMarcaECF = 'elgin') then
      begin
        DiaIni := FormatDateTime('yyyymmdd', DataInicial);
        DiaFim := FormatDateTime('yyyymmdd', DataFinal);

        AbrePortaSerialDLL( PortaSerial, ExtractFilePath(NomeArquivo) );

        ArqTmp := ExtractFilePath( NomeArquivo ) + 'Memoria.tdm' ;

        iRet := xElgin_LeMemoriasBinario( ArqTmp, NumFab, true );

        if (iRet <> 1) then
           raise Exception.Create(ACBrStr('Erro ao executar Elgin_LeMemoriasBinario.'+sLineBreak+
                                          'Cod.: ' + IntToStr(iRet))) ;

        if not FilesExists( ArqTmp ) then
           raise Exception.Create(ACBrStr('Erro na execução de Elgin_LeMemoriasBinario.'+sLineBreak+
                                          'Arquivo binário não gerado!'));

        iRet := xElgin_GeraArquivoATO17Binario( ArqTmp, NomeArquivo, DiaIni,
                                                DiaFim, 'D', Prop, 'TDM');

        if (iRet <> 1) then
           raise Exception.Create(ACBrStr('Erro ao executar Elgin_GeraArquivoATO17Binario.'+sLineBreak+
                                          'Cod.: ' + IntToStr(iRet))) ;

        xElgin_FechaPortaSerial();
      end
     else
        raise Exception.Create( ACBrStr( 'ArquivoMFD_DLL por período ainda não Implementado para: '+fsMarcaECF ) ) ;
  finally
     Ativo := OldAtivo ;
  end ;
end;

procedure TACBrECFFiscNET.ArquivoMFD_DLL(ContInicial, ContFinal: Integer; NomeArquivo: AnsiString;
  Documentos: TACBrECFTipoDocumentoSet;
  Finalidade: TACBrECFFinalizaArqMFD; TipoContador: TACBrECFTipoContador);
Var
  iRet : Integer;
  PortaSerial, ModeloECF, NumFab : AnsiString;
  CooIni, CooFim, Prop, ArqTmp : AnsiString ;
  OldAtivo : Boolean ;
  cFinalidade:AnsiString;
begin
  NumFab      := NumSerie;
  ModeloECF   := SubModeloECF;
  CooIni      := IntToStrZero( ContInicial, 6 ) ;
  CooFim      := IntToStrZero( ContFinal, 6 ) ;
  Prop        := IntToStr( StrToIntDef( UsuarioAtual, 1) ) ;
  PortaSerial := fpDevice.Porta ;

  LoadDLLFunctions;
  OldAtivo := Ativo;
  try
     Ativo := False;

     if pos(fsMarcaECF, 'urano') > 0 then
      begin
        if (Finalidade = finMF) then
           cFinalidade := 'MF'
        else if (Finalidade = finTDM) then
           cFinalidade := 'TDM'
        else
           cFinalidade := 'MFD';

        ArqTmp := ExtractFilePath( NomeArquivo ) + 'ACBr.TDM' ;
        if FileExists( NomeArquivo ) then
           DeleteFile( NomeArquivo ) ;

        iRet := xDLLReadLeMemorias( PortaSerial, ArqTmp, NumFab, '1');

        if iRet <> 0 then
           raise Exception.Create( ACBrStr( 'Erro ao executar DLLReadLeMemorias.' + sLineBreak +
                                            'Cod.: '+ IntToStr(iRet) + ' - ' +
                                            GetErroAtoCotepe1704(iRet) )) ;

        iRet := xDLLATO17GeraArquivo( ArqTmp, NomeArquivo, CooIni, CooFim,
                                      'C', '1', cFinalidade );

        if iRet <> 0 then
           raise Exception.Create( ACBrStr( 'Erro ao executar DLLATO17GeraArquivo.' + sLineBreak +
                                            'Cod.: '+ IntToStr(iRet) + ' - ' +
                                            GetErroAtoCotepe1704(iRet) )) ;
      end
     else if pos(fsMarcaECF, 'dataregis|termoprinter') > 0 then
      begin
        iRet := xGera_PAF( PortaSerial, ModeloECF, NomeArquivo, CooIni, CooFim );

        if iRet <> 0 then
           raise Exception.Create( ACBrStr( 'Erro ao executar Gera_PAF.'+sLineBreak+
                                            'Cod.: '+IntToStr(iRet) + ' - ' +
                                            GetErroAtoCotepe1704(iRet) )) ;

        if not FileExists( NomeArquivo ) then
           raise Exception.Create( ACBrStr( 'Erro na execução de Gera_PAF.'+sLineBreak+
                                            ': "'+NomeArquivo + '" não gerado' ))
      end

     else if (fsMarcaECF = 'elgin') then
      begin
        AbrePortaSerialDLL(fpDevice.Porta, ExtractFilePath(NomeArquivo));

        ArqTmp := ExtractFilePath( NomeArquivo ) + 'Memoria.tdm' ;

        iRet := xElgin_LeMemoriasBinario( ArqTmp, NumFab, true );

        if (iRet <> 1) then
           raise Exception.Create(ACBrStr('Erro ao executar Elgin_LeMemoriasBinario.'+sLineBreak+
                                                   'Cod.: ' + IntToStr(iRet))) ;

        if not FilesExists( ArqTmp ) then
           raise Exception.Create(ACBrStr('Erro na execução de Elgin_LeMemoriasBinario.'+sLineBreak+
                                          'Arquivo binário não gerado!'));

        iRet := xElgin_GeraArquivoATO17Binario( ArqTmp, NomeArquivo, CooIni,
                                                CooFim, 'C', Prop, 'TDM');

        if (iRet <> 1) then
           raise Exception.Create(ACBrStr('Erro ao executar Elgin_GeraArquivoATO17Binario.'+sLineBreak+
                                          'Cod.: ' + IntToStr(iRet))) ;

        xElgin_FechaPortaSerial();
      end
     else
        raise Exception.Create( ACBrStr( 'ArquivoMFD_DLL por COO ainda não Implementado para: '+fsMarcaECF ) ) ;
  finally
    Ativo := OldAtivo ;
  end;
end;

function TACBrECFFiscNET.GetDadosUltimaReducaoZ: AnsiString;
var
   RetCmd, sAux, sIcms : AnsiString ;
   nAux, nAux2 : Integer ;
   VBruta, TOPNF, nVal, nIcms : Double ;
begin
   try
      FiscNETComando.NomeComando := 'LeTexto' ;
      FiscNETComando.AddParamString( 'NomeTexto', 'DadosUltimaReducaoZ' );
      EnviaComando ;
      RetCmd := FiscNETResposta.Params.Values['ValorTexto']
   except
      Result := '' ;
      exit ;
   end ;

   { Tamanho de Retorno 616 dígitos BCD (308 bytes),
     com a seguinte estrutura.
     2 Constante 00.
    18 GTDA GT no momento da última redução.
    14 CANCEL Cancelamentos
    14 DESCON Descontos
    64 TR Tributos
   266 TP Totalizadores Parciais Tributados
    14 SANGRIA Sangria
    14 SUPRIMENTOS Suprimentos
   126 NSI Totalizadores não Sujeitos ao ICMS
    36 CNSI Contadores dos TP’s não Sujeitos ao ICMS
     6 COO Contador de Ordem de Operação
     6 CNS Contador de Operações não Sujeitas ao ICMS
     2 AL Número de Alíquotas Cadastradas
     6 DATA_PC Data do Movimento
    14 ACRESC Acréscimo
    14 ACRFIN Acréscimo Financeiro

   RRGGGGGGGGGGGGGGGGGGCCCCCCCCCCCCCCDDDDDDDDDDDDDDT001T002T003T004T005T006T007T008T009T010T011T012T013T014T015T016TPT00000000001TPT00000000002TPT00000000003TPT00000000004TPT00000000005TPT00000000006TPT00000000007TPT00000000008TPT00000000009TPT00000000010TPT00000000011TPT00000000012TPT00000000013TPT00000000014TPT00000000015TPT00000000016IIIIIIIIIIIIIINNNNNNNNNNNNNNFFFFFFFFFFFFFFAAAAAAAAAAAAAAUUUUUUUUUUUUUUTNS00000000001TNS00000000002TNS00000000003TNS00000000004TNS00000000005TNS00000000006TNS00000000007TNS00000000008TNS00000000009CN01CN02CN03CN04CN05CN06CN07CN08CN09COOCOOCNSCNSALDTMOVTAAAAAAAAAAAAAAFFFFFFFFFFFFFF
   0000000000000014231000000000000000000000000000001800021605001200050025000250180013001600170002110200100006000100000000000001000000000000020000000000000300000000000004010000000000050100000000000601000000000007010000000000080100000000000901000000000010010000000000110200000000001202000000000013020000000000140200000000001502000000000016020000000001001400000000010114000000000408640000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000162000019161708070000000000011100000000000000
   ....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+.
   }


   Result := '[ECF]'+sLineBreak ;
   try
      Result := Result + 'DataMovimento = ' +
                copy( RetCmd, 583, 2 ) + DateSeparator +
                copy( RetCmd, 585, 2 ) + DateSeparator +
                copy( RetCmd, 587, 2 ) + sLineBreak ;
   except
   end ;

   try
      Result := Result + 'NumSerie = ' + NumSerie + sLineBreak ;
   except
   end ;

   try
      Result := Result + 'NumLoja = ' + NumLoja + sLineBreak ;
      Result := Result + 'NumECF = ' + NumECF + sLineBreak ;
   except
   end ;

   try
      Result := Result + 'NumCOO = ' + copy( RetCmd, 569, 6 ) + sLineBreak ;
   except
   end ;

   try
      Result := Result + 'NumCRZ = ' + NumCRZ + sLineBreak ;
   except
   end ;

   try
      Result := Result + 'NumCRO = ' + NumCRO + sLineBreak ;
   except
   end ;

   VBruta := 0 ;
   TOPNF  := 0 ;

   try
      Result := Result + sLineBreak + '[Aliquotas]' + sLineBreak ;

      if not Assigned( fpAliquotas ) then
         CarregaAliquotas ;

      sIcms := copy( RetCmd,  49,  64 ) ;
      sAux  := copy( RetCmd, 113, 224 ) ;

      for nAux := 0 to 7 do
      begin
         nIcms := RoundTo( StrToFloatDef( Copy( sIcms, ( nAux *  4 ) + 1,  4 ), 0 ) / 100, -2 ) ;
         nVal  := RoundTo( StrToFloatDef( Copy( sAux , ( nAux * 14 ) + 1, 14 ), 0 ) / 100, -2 ) ;
         if nIcms = 0 then
            continue ;
         for nAux2 := 0 to ( Aliquotas.Count - 1 ) do
         begin
            if ( Aliquotas[ nAux2 ].Aliquota = nIcms ) then
            begin
               Result := Result + padL( Aliquotas[ nAux2 ].Indice, 2 ) +
                                  Aliquotas[ nAux2 ].Tipo +
                                  IntToStrZero( Trunc( Aliquotas[ nAux2 ].Aliquota * 100 ), 4 ) + ' = '+
                                  FloatToStr( nVal ) + sLineBreak ;
               VBruta := VBruta + nVal ;
               break ;
            end;
         end ;
      end;
   except
   end ;

   try
      Result := Result + sLineBreak + '[OutrasICMS]' + sLineBreak ;

      nVal := RoundTo( StrToFloatDef( copy( RetCmd, 365, 14 ),0 ) / 100, -2 ) ;
      Result := Result + 'TotalSubstituicaoTributaria = ' + FloatToStr( nVal ) + sLineBreak ;
      VBruta := VBruta + nVal ;

      nVal := RoundTo( StrToFloatDef( copy( RetCmd, 351, 14 ), 0 ) / 100, -2 ) ;
      Result := Result + 'TotalNaoTributado = ' + FloatToStr( nVal ) + sLineBreak ;
      VBruta := VBruta + nVal ;

      nVal := RoundTo( StrToFloatDef( copy( RetCmd, 337, 14 ), 0 ) / 100, -2 ) ;
      Result := Result + 'TotalIsencao = ' + FloatToStr( nVal ) + sLineBreak ;
      VBruta := VBruta + nVal ;
   except
   end ;

   try
      Result := Result + sLineBreak + '[NaoFiscais]' + sLineBreak ;

      if not Assigned( fpComprovantesNaoFiscais ) then
         CarregaComprovantesNaoFiscais ;

      sAux := copy( RetCmd, 379, 126 ) ;

      For nAux := 0 to min( ComprovantesNaoFiscais.Count - 1, 11 ) do
      begin
         nVal := RoundTo( StrToFloatDef( copy(sAux,( nAux * 14 ) + 1, 14 ), 0 ) / 100, -2 ) ;
         Result := Result + padL( ComprovantesNaoFiscais[ nAux ].Indice, 2 ) + '_' +
                            ComprovantesNaoFiscais[ nAux ].Descricao + ' = ' +
                            FloatToStr( nVal ) + sLineBreak ;
         TOPNF := TOPNF + nVal ;
      end ;
   except
   end ;

   Result := Result + sLineBreak + '[Totalizadores]' + sLineBreak;

   try
      nVal := RoundTo( StrToFloatDef( copy( RetCmd, 35, 14 ), 0 ) / 100, -2 ) ;
      Result := Result + 'TotalDescontos = ' + FloatToStr( nVal ) + sLineBreak ;
      VBruta := VBruta + nVal ;
   except
   end ;

   try
      nVal := RoundTo( StrToFloatDef( copy( RetCmd, 21, 14 ), 0 ) / 100, -2 )  ;
      Result := Result + 'TotalCancelamentos = ' + FloatToStr( nVal ) + sLineBreak ;
      VBruta := VBruta + nVal ;
   except
   end ;

   try
      Result := Result + 'TotalAcrescimos = ' + FloatToStr(
          RoundTo( StrToFloatDef( copy( RetCmd, 589, 14 ), 0 ) / 100, -2 ) )  + sLineBreak ;
   except
   end ;

   try
      Result := Result + 'TotalNaoFiscal = ' + FloatToStr( TOPNF ) + sLineBreak ;
   except
   end ;

   try
      Result := Result + 'VendaBruta = ' + FloatToStr( VBruta ) + sLineBreak ;
   except
   end ;

   try
      Result := Result + 'GrandeTotal = ' + FloatToStr(
          RoundTo( StrToFloatDef( copy( RetCmd, 3, 18 ), 0 ) / 100, -2 ) )  + sLineBreak ;
   except
   end ;
end;

//Constantes usada para DLL do Ato Cotepe 1704
function TACBrECFFiscNET.GetErroAtoCotepe1704(pRet: Integer): string;
const
  ERROS_DLL : Array[1..17] of String =
    ( 'Erro ao executar comando EmiteLeituraX.',
      'Erro ao executar comando EmiteLeituraMF.',
      'Erro ao executar comando EmiteLeituraFitaDetalhe.',
      'Comando Inexistente.',
      'Erro ao obter dados de impressão.',
      'Erro ao acessar o arquivo.',
      'Erro ao executar comando.Data inválida.',
      'Não existe redução executada na data informada.',
      'Modelo não permitido.',
      'Comando inválido.',
      'Biblioteca não foi encontrada.',
      'Sem Sinal de CTS.',
      'Nome do arquivo inválido',
      'Intervalo de data não permitido',
      'Caminho de origem não permitido.',
      'Caminho de destino não permitido.',
      'Erro Desconhecido.' ) ;
begin
  if (-pRet >= Low(ERROS_DLL)) and (-pRet <= High(ERROS_DLL)) then begin
     Result := ERROS_DLL[ -pRet ] ;
  end else begin
     Result := '';
  end;
end;

function TACBrECFFiscNET.TraduzirTag(const ATag : AnsiString) : AnsiString ;
const
  cOff = ESC + '!' + #0 ;

  // <e></e>
  cExpandido   = ESC + '!' + #32 ;

  // <n></n>
  cNegrito     = ESC + '!' + #8 ;
begin

  case AnsiIndexText( ATag, ARRAY_TAGS) of
     -1: Result := ATag;
     2 : Result := cExpandido;
     3 : Result := cOff;
     4 : Result := cNegrito;
     5 : Result := cOff;
  else
     Result := '' ;
  end;
end ;

end.
