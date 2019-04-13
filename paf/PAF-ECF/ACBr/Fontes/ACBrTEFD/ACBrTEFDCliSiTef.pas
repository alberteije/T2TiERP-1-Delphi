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
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 21/11/2009: Daniel Simoes de Almeida
|*  - Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrTEFDCliSiTef;

interface

uses
  Classes, SysUtils, ACBrTEFDClass,
  {$IFDEF VisualCLX}
     QControls, QDialogs
  {$ELSE}
     Controls, Dialogs
  {$ENDIF};


Const
   CACBrTEFD_CliSiTef_Backup = 'ACBr_CliSiTef_Backup.tef' ;

{$IFDEF LINUX}
  CACBrTEFD_CliSiTef_Lib = 'libclisitef.so' ;
{$ELSE}
  CACBrTEFD_CliSiTef_Lib = 'CliSiTef32I.dll' ;
{$ENDIF}

type
  { TACBrTEFDRespCliSiTef }

  TACBrTEFDRespCliSiTef = class( TACBrTEFDResp )
  protected
    function GetTransacaoAprovada : Boolean; override;
  public
    procedure ConteudoToProperty; override;
    procedure GravaInformacao( const Identificacao : Integer;
      const Informacao : AnsiString );
  end;

  TACBrTEFDCliSiTefExibeMenu = procedure( Titulo : String; Opcoes : TStringList;
    var ItemSelecionado : Integer; var VoltarMenu : Boolean ) of object ;

  TACBrTEFDCliSiTefOperacaoCampo = (tcString, tcDouble, tcCMC7, tcBarCode) ;

  TACBrTEFDCliSiTefObtemCampo = procedure( Titulo : String;
    TamanhoMinimo, TamanhoMaximo : Integer ;
    TipoCampo : Integer; Operacao : TACBrTEFDCliSiTefOperacaoCampo;
    var Resposta : AnsiString; var Digitado : Boolean; var VoltarMenu : Boolean )
    of object ;

  { TACBrTEFDCliSiTef }

   TACBrTEFDCliSiTef = class( TACBrTEFDClass )
   private
      fReimpressao: Boolean; {Indica se foi selecionado uma reimpressão}
      fCodigoLoja : AnsiString;
      fEnderecoIP : AnsiString;
      fNumeroTerminal : AnsiString;
      fOnExibeMenu : TACBrTEFDCliSiTefExibeMenu;
      fOnObtemCampo : TACBrTEFDCliSiTefObtemCampo;
      fOperacaoADM : Integer;
      fOperacaoATV : Integer;
      fOperacaoCHQ : Integer;
      fOperacaoCNC : Integer;
      fOperacaoCRT : Integer;
      fOperacaoReImpressao: Integer;
      fOperador : AnsiString;
      fParametrosAdicionais : TStringList;
      fRespostas: TStringList;
      fRestricoes : AnsiString;
      fDocumentosProcessados : AnsiString ;
      fPathDLL: string;

     xConfiguraIntSiTefInterativoEx : function (
                pEnderecoIP: PAnsiChar;
                pCodigoLoja: PAnsiChar;
                pNumeroTerminal: PAnsiChar;
                ConfiguraResultado: smallint;
                pParametrosAdicionais: PAnsiChar): integer;
               {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;

     xIniciaFuncaoSiTefInterativo : function (
                Modalidade: integer;
                pValor: PAnsiChar;
                pNumeroCuponFiscal: PAnsiChar;
                pDataFiscal: PAnsiChar;
                pHorario: PAnsiChar;
                pOperador: PAnsiChar;
                pRestricoes: PAnsiChar ): integer;
                {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;


     xFinalizaTransacaoSiTefInterativo : procedure (
                 smallint: Word;
                 pNumeroCuponFiscal: PAnsiChar;
                 pDataFiscal: PAnsiChar;
                 pHorario: PAnsiChar );
                 {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;


     xContinuaFuncaoSiTefInterativo : function (
                var ProximoComando: Integer;
                var TipoCampo: Integer;
                var TamanhoMinimo: smallint;
                var TamanhoMaximo: smallint;
                pBuffer: PAnsiChar;
                TamMaxBuffer: Integer;
                ContinuaNavegacao: Integer ): integer;
                {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;

     xEscreveMensagemPermanentePinPad: function(Mensagem:PAnsiChar):Integer;
     {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;           

     xObtemQuantidadeTransacoesPendentes: function(
        DataFiscal:AnsiString;
        NumeroCupon:AnsiString):Integer;
     {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;        
        
     procedure AvaliaErro(Sts : Integer);
     procedure FinalizarTransacao( Confirma : Boolean;
        DocumentoVinculado : AnsiString);
     procedure LoadDLLFunctions;
     procedure SetParametrosAdicionais(const AValue : TStringList) ;
   protected
     procedure SetNumVias(const AValue : Integer); override;

     Function FazerRequisicao( Funcao : Integer; AHeader : AnsiString = '';
        Valor : Double = 0; Documento : AnsiString = '';
        ListaRestricoes : AnsiString = '') : Integer ;
     Function ContinuarRequisicao( ImprimirComprovantes : Boolean ) : Integer ;

     Function ProcessarRespostaPagamento( const IndiceFPG_ECF : String;
        const Valor : Double) : Boolean; override;

   public
     property Respostas : TStringList read fRespostas ;
     property PathDLL: string read fPathDLL write fPathDLL;

     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     procedure Inicializar ; override;

     procedure AtivarGP ; override;
     procedure VerificaAtivo ; override;

     procedure ConfirmarEReimprimirTransacoesPendentes ;

     Procedure ATV ; override;
     Function ADM : Boolean ; override;
     Function CRT( Valor : Double; IndiceFPG_ECF : String;
        DocumentoVinculado : String = ''; Moeda : Integer = 0 ) : Boolean; override;
     Function CHQ( Valor : Double; IndiceFPG_ECF : String;
        DocumentoVinculado : String = ''; CMC7 : String = '';
        TipoPessoa : AnsiChar = 'F'; DocumentoPessoa : String = '';
        DataCheque : TDateTime = 0; Banco   : String = '';
        Agencia    : String = ''; AgenciaDC : String = '';
        Conta      : String = ''; ContaDC   : String = '';
        Cheque     : String = ''; ChequeDC  : String = '';
        Compensacao: String = '' ) : Boolean ; override;
     Procedure NCN(Rede, NSU, Finalizacao : String;
        Valor : Double = 0; DocumentoVinculado : String = ''); override;
     Procedure CNF(Rede, NSU, Finalizacao : String;
        DocumentoVinculado : String = ''); override;
     Function CNC(Rede, NSU : String; DataHoraTransacao : TDateTime;
        Valor : Double) : Boolean; overload; override;
     Function DefineMensagemPermanentePinPad(Mensagem:AnsiString):Integer;
     Function ObtemQuantidadeTransacoesPendentes(Data:TDateTime;
        CupomFiscal:AnsiString):Integer;
   published
     property EnderecoIP     : AnsiString read fEnderecoIP     write fEnderecoIP ;
     property CodigoLoja     : AnsiString read fCodigoLoja     write fCodigoLoja ;
     property NumeroTerminal : AnsiString read fNumeroTerminal write fNumeroTerminal ;
     property Operador       : AnsiString read fOperador       write fOperador ;
     property ParametrosAdicionais : TStringList read fParametrosAdicionais
        write SetParametrosAdicionais ;
     property Restricoes : AnsiString read fRestricoes write fRestricoes ;
     property OperacaoATV : Integer read fOperacaoATV write fOperacaoATV
        default 111 ;
     property OperacaoADM : Integer read fOperacaoADM write fOperacaoADM
        default 110 ;
     property OperacaoCRT : Integer read fOperacaoCRT write fOperacaoCRT
        default 0 ;
     property OperacaoCHQ : Integer read fOperacaoCHQ write fOperacaoCHQ
        default 1 ;
     property OperacaoCNC : Integer read fOperacaoCNC write fOperacaoCNC
        default 200 ;
     property OperacaoReImpressao : Integer read fOperacaoReImpressao
        write fOperacaoReImpressao default 112 ;

     property OnExibeMenu : TACBrTEFDCliSiTefExibeMenu read fOnExibeMenu
        write fOnExibeMenu ;
     property OnObtemCampo : TACBrTEFDCliSiTefObtemCampo read fOnObtemCampo
        write fOnObtemCampo ;
   end;

implementation

Uses ACBrUtil, dateutils, StrUtils, ACBrTEFD, Math;

{ TACBrTEFDRespCliSiTef }

function TACBrTEFDRespCliSiTef.GetTransacaoAprovada : Boolean;
begin
   Result := True ;
end;

procedure TACBrTEFDRespCliSiTef.ConteudoToProperty;
var
   Linha : TACBrTEFDLinha ;
   I     : Integer;
   Parc  : TACBrTEFDRespParcela;
   LinStr: AnsiString ;
begin
// Conteudo.Conteudo.SaveToFile('c:\temp\conteudo.txt') ;

   fpValorTotal := 0 ;
   fpImagemComprovante1aVia.Clear;
   fpImagemComprovante2aVia.Clear;
   fpDebito  := False;
   fpCredito := False;
   for I := 0 to Conteudo.Count - 1 do
   begin
     Linha := Conteudo.Linha[I];

     LinStr := StringToBinaryString( Linha.Informacao.AsString );

     case Linha.Identificacao of
       // TODO: Mapear mais propriedades do CliSiTef //
       15  : fpDebito                  := True;
       25  : fpCredito                 := True;
       100 : fpModalidadePagto         := LinStr;
       101 : fpModalidadePagtoExtenso  := LinStr;
       102 : fpModalidadePagtoDescrita := LinStr;
       105 :
         begin
           fpDataHoraTransacaoComprovante  := Linha.Informacao.AsTimeStampSQL;
           fpDataHoraTransacaoHost         := fpDataHoraTransacaoComprovante ;
         end;
       121 : fpImagemComprovante1aVia.Text := StringReplace( StringToBinaryString( Linha.Informacao.AsString ), #10, sLineBreak, [rfReplaceAll] );
       122 : fpImagemComprovante2aVia.Text := StringReplace( StringToBinaryString( Linha.Informacao.AsString ), #10, sLineBreak, [rfReplaceAll] );
       130 :
         begin
           fpSaque      := Linha.Informacao.AsFloat ;
           fpValorTotal := fpValorTotal + fpSaque ;
         end;
       131 : fpInstituicao                 := LinStr;
       133 : fpCodigoAutorizacaoTransacao  := Linha.Informacao.AsInteger;
       134 : fpNSU                         := LinStr;
       156 : fpRede                        := LinStr;
       501 : fpTipoPessoa                  := AnsiChar(IfThen(Linha.Informacao.AsInteger = 0,'J','F')[1]);
       502 : fpDocumentoPessoa             := LinStr ;
       505 : fpQtdParcelas                 := Linha.Informacao.AsInteger ;
       506 : fpDataPreDatado               := Linha.Informacao.AsDate;
       
       //incluido por Evandro
       627 : fpAgencia                     := LinStr;
       628 : fpAgenciaDC                   := LinStr;
       120 : fpAutenticacao                := LinStr;
       626 : fpBanco                       := LinStr;
       613 :
        begin
          fpCheque                         := copy(LinStr, 21, 6);
          fpCMC7                           := LinStr;
        end;
       629 : fpConta                       := LinStr;
       630 : fpContaDC                     := LinStr;
       527 : fpDataVencimento              := Linha.Informacao.AsDate ; {Data Vencimento}
       //

       899 :  // Tipos de Uso Interno do ACBrTEFD
        begin
          case Linha.Sequencia of
              1 : fpCNFEnviado         := (UpperCase( Linha.Informacao.AsString ) = 'S' );
              2 : fpIndiceFPG_ECF      := Linha.Informacao.AsString ;
              3 : fpOrdemPagamento     := Linha.Informacao.AsInteger ;
            100 : fpHeader             := LinStr;
            101 : fpID                 := Linha.Informacao.AsInteger;
            102 : fpDocumentoVinculado := LinStr;
            103 : fpValorTotal         := fpValorTotal + Linha.Informacao.AsFloat;
          end;
        end;
     end;
   end ;

   fpParcelas.Clear;
   for I := 1 to fpQtdParcelas do
   begin
      Parc := TACBrTEFDRespParcela.create;
      Parc.Vencimento := LeInformacao( 141, I).AsDate ;
      Parc.Valor      := LeInformacao( 142, I).AsFloat ;

      fpParcelas.Add(Parc);
   end;
end;

procedure TACBrTEFDRespCliSiTef.GravaInformacao(const Identificacao : Integer;
   const Informacao : AnsiString);
Var
  Sequencia : Integer ;
begin
  Sequencia := 0 ;

  if (Identificacao in [141,142]) then  // 141 - Data Parcela, 142 - Valor Parcela
  begin
    Sequencia := 1 ;
    while LeInformacao(Identificacao, Sequencia).AsString <> '' do
       Inc( Sequencia ) ;
  end;

  fpConteudo.GravaInformacao( Identificacao, Sequencia,
                              BinaryStringToString(Informacao) ); // Converte #10 para "\x0A"
end;


{ TACBrTEFDClass }

constructor TACBrTEFDCliSiTef.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  fReimpressao := False;
  ArqReq    := '' ;
  ArqResp   := '' ;
  ArqSTS    := '' ;
  ArqTemp   := '' ;
  GPExeName := '' ;
  fpTipo    := gpCliSiTef;
  Name      := 'CliSiTef' ;

  fEnderecoIP     := '' ;
  fCodigoLoja     := '' ;
  fNumeroTerminal := '' ;
  fOperador       := '' ;
  fRestricoes     := '' ;

  fOperacaoATV         := 111 ; // 111 - Teste de comunicação com o SiTef
  fOperacaoReImpressao := 112 ; // 112 - Menu Re-impressão
  fOperacaoADM         := 110 ; // 110 - Abre o leque das transações Gerenciais
  fOperacaoCRT         := 0 ;   // A CliSiTef permite que o operador escolha a forma
                                // de pagamento através de menus
  fOperacaoCHQ         := 1 ;   // Cheque
  fOperacaoCNC         := 200 ; // 200 Cancelamento Normal: Inicia a coleta dos dados
                                // no ponto necessário para fazer o cancelamento de uma
                                // transação de débito ou crédito, sem ser necessário
                                // passar antes pelo menu de transações administrativas
  fDocumentosProcessados := '' ;

  fParametrosAdicionais := TStringList.Create;
  fRespostas            := TStringList.Create;

  xConfiguraIntSiTefInterativoEx    := nil ;
  xIniciaFuncaoSiTefInterativo      := nil ;
  xContinuaFuncaoSiTefInterativo    := nil ;
  xFinalizaTransacaoSiTefInterativo := nil ;
  xEscreveMensagemPermanentePinPad  := nil; 
  xObtemQuantidadeTransacoesPendentes := nil;

  fOnExibeMenu  := nil ;
  fOnObtemCampo := nil ;

  if Assigned( fpResp ) then
     fpResp.Free ;

  fpResp := TACBrTEFDRespCliSiTef.Create;
  fpResp.TipoGP := Tipo;
end;

function TACBrTEFDCliSiTef.DefineMensagemPermanentePinPad(Mensagem:AnsiString):Integer;
begin
   if Assigned(xEscreveMensagemPermanentePinPad) then  
      Result := xEscreveMensagemPermanentePinPad(PAnsiChar(Mensagem))
   else
      raise Exception.Create( ACBrStr('CliSiTEF não inicializado' ) ) ;   
end;

destructor TACBrTEFDCliSiTef.Destroy;
begin
   fParametrosAdicionais.Free ;
   fRespostas.Free ;

   inherited Destroy;
end;

procedure TACBrTEFDCliSiTef.LoadDLLFunctions ;
 procedure CliSiTefFunctionDetect( FuncName: AnsiString; var LibPointer: Pointer ) ;
 var
 sLibName: string;
 begin
   if not Assigned( LibPointer )  then
   begin
     // Verifica se exite o caminho das DLLs
     if Length(PathDLL) > 0 then
        sLibName := PathWithDelim(PathDLL);

     // Concatena o caminho se exitir mais o nome da DLL.
     sLibName := sLibName + CACBrTEFD_CliSiTef_Lib;

     if not FunctionDetect( sLibName, FuncName, LibPointer) then
     begin
        LibPointer := NIL ;
        raise Exception.Create( ACBrStr( 'Erro ao carregar a função:'+FuncName+
                                         ' de: '+CACBrTEFD_CliSiTef_Lib ) ) ;
     end ;
   end ;
 end ;
begin
   CliSiTefFunctionDetect('ConfiguraIntSiTefInterativoEx', @xConfiguraIntSiTefInterativoEx);
   CliSiTefFunctionDetect('IniciaFuncaoSiTefInterativo', @xIniciaFuncaoSiTefInterativo);
   CliSiTefFunctionDetect('ContinuaFuncaoSiTefInterativo', @xContinuaFuncaoSiTefInterativo);
   CliSiTefFunctionDetect('FinalizaTransacaoSiTefInterativo', @xFinalizaTransacaoSiTefInterativo);
   CliSiTefFunctionDetect('EscreveMensagemPermanentePinPad',@xEscreveMensagemPermanentePinPad);
   CliSiTefFunctionDetect('ObtemQuantidadeTransacoesPendentes',@xObtemQuantidadeTransacoesPendentes);
end ;

procedure TACBrTEFDCliSiTef.SetParametrosAdicionais(const AValue : TStringList
   ) ;
begin
   fParametrosAdicionais.Assign( AValue ) ;
end ;

procedure TACBrTEFDCliSiTef.SetNumVias(const AValue : Integer);
begin
   fpNumVias := 2;
end;

procedure TACBrTEFDCliSiTef.Inicializar;
Var
  Sts : Integer ;
  ParamAdic : AnsiString ;
  Erro : String;
  Est  : AnsiChar;
begin
  if Inicializado then exit ;

  if not Assigned( OnExibeMenu ) then
     raise Exception.Create( ACBrStr('Evento "OnExibeMenu" não programado' ) ) ;

  if not Assigned( OnObtemCampo ) then
     raise Exception.Create( ACBrStr('Evento "OnObtemCampo" não programado' ) ) ;

  LoadDLLFunctions;

  ParamAdic := StringReplace( ParametrosAdicionais.Text, sLineBreak, ';',
                              [rfReplaceAll] ) ;

  Sts := xConfiguraIntSiTefInterativoEx( PAnsiChar(fEnderecoIP),
                                         PAnsiChar(fCodigoLoja),
                                         PAnsiChar(fNumeroTerminal),
                                         0,
                                         PAnsiChar(ParamAdic) );
  Erro := '' ;
  Case Sts of
    1 :	Erro := 'Endereço IP inválido ou não resolvido' ;
    2 : Erro := 'Código da loja inválido' ;
    3 : Erro := 'Código de terminal invalido' ;
    6 : Erro := 'Erro na inicialização do Tcp/Ip' ;
    7 : Erro := 'Falta de memória' ;
    8 : Erro := 'Não encontrou a CliSiTef ou ela está com problemas' ;
   10 : Erro := 'O PinPad não está devidamente configurado no arquivo CliSiTef.ini' ;
  end;

  if Erro <> '' then
     raise EACBrTEFDErro.Create( ACBrStr( Erro ) ) ;

  fpInicializado := True ;
  GravaLog( Name +' Inicializado CliSiTEF' );

  try
     Est := TACBrTEFD(Owner).EstadoECF;
  except
     Est := 'O' ;
  end ;

  if (Est in ['V','P','N','O']) then            // Cupom Ficou aberto ?? //
     CancelarTransacoesPendentesClass           // SIM, Cancele tudo... //
  else
     ConfirmarEReimprimirTransacoesPendentes ;  // NAO, Cupom Fechado, basta re-imprimir //
end;

procedure TACBrTEFDCliSiTef.AtivarGP;
begin
   raise Exception.Create( ACBrStr( 'CliSiTef não pode ser ativado localmente' )) ;
end;

procedure TACBrTEFDCliSiTef.VerificaAtivo;
begin
   {Nada a Fazer}
end;

procedure TACBrTEFDCliSiTef.ConfirmarEReimprimirTransacoesPendentes;
Var
  ArquivosVerficar : TStringList ;
//I, Sts           : Integer;
  ArqMask, NSUs    : AnsiString;
  ExibeMsg         : Boolean ;
begin
  ArquivosVerficar := TStringList.Create;

  try
     ArquivosVerficar.Clear;

     { Achando Arquivos de Backup deste GP }
     ArqMask := TACBrTEFD(Owner).PathBackup + PathDelim + 'ACBr_' + Self.Name + '_*.tef' ;
     FindFiles( ArqMask, ArquivosVerficar, True );
     NSUs := '' ;
     ExibeMsg := (ArquivosVerficar.Count > 0) ;

     { Enviando NCN ou CNC para todos os arquivos encontrados }
     while ArquivosVerficar.Count > 0 do
     begin
        if not FileExists( ArquivosVerficar[ 0 ] ) then
        begin
           ArquivosVerficar.Delete( 0 );
           Continue;
        end;

        Resp.LeArquivo( ArquivosVerficar[ 0 ] );

        try
           if pos(Resp.DocumentoVinculado, fDocumentosProcessados) = 0 then
              CNF;   {Confirma}

           if Resp.NSU <> '' then
              NSUs := NSUs + sLineBreak + 'NSU: '+Resp.NSU ;

           SysUtils.DeleteFile( ArquivosVerficar[ 0 ] );
           ArquivosVerficar.Delete( 0 );
        except
        end;
     end;

     if ExibeMsg then
        TACBrTEFD(Owner).DoExibeMsg( opmOK,
                               'Transação TEF efetuada.'+sLineBreak+
                               'Favor Re-Imprimir Ultimo Cupom ' + NSUs + sLineBreak +
                               '(Para Cielo utilizar os 6 últimos dígitos.)') ;

  finally
     ArquivosVerficar.Free;
  end;
end;

Procedure TACBrTEFDCliSiTef.ATV ;
var
   Sts : Integer;
begin
  Sts := FazerRequisicao( fOperacaoATV, 'ATV' ) ;

  if Sts = 10000 then
     Sts := ContinuarRequisicao( True ) ;  { True = Imprimir Comprovantes agora }

  if ( Sts <> 0 ) then
     AvaliaErro( Sts );
end;

Function TACBrTEFDCliSiTef.ADM : Boolean;
var
   Sts : Integer;
begin
  Sts := FazerRequisicao( fOperacaoADM, 'ADM' ) ;

  if Sts = 10000 then
     Sts := ContinuarRequisicao( True ) ;  { True = Imprimir Comprovantes agora }

  Result := ( Sts = 0 ) ;

  if not Result then
     AvaliaErro( Sts );
end;

Function TACBrTEFDCliSiTef.CRT( Valor : Double; IndiceFPG_ECF : String;
   DocumentoVinculado : String = ''; Moeda : Integer = 0 ) : Boolean;
var
  Sts : Integer;
  Restr : AnsiString ;
begin
  VerificarTransacaoPagamento( Valor );

  Restr := fRestricoes;
  if Restr = '' then
     Restr := '[10]' ;     // 10 - Cheques

  Sts := FazerRequisicao( fOperacaoCRT, 'CRT', Valor, DocumentoVinculado, Restr ) ;

  if Sts = 10000 then
     Sts := ContinuarRequisicao( False ) ;  { False = NAO Imprimir Comprovantes agora }

  Result := ( Sts = 0 ) ;

  if not Result then
     AvaliaErro( Sts )
  else
     ProcessarRespostaPagamento( IndiceFPG_ECF, Valor );
end;

Function TACBrTEFDCliSiTef.CHQ(Valor : Double; IndiceFPG_ECF : String;
   DocumentoVinculado : String; CMC7 : String; TipoPessoa : AnsiChar;
   DocumentoPessoa : String; DataCheque : TDateTime; Banco : String;
   Agencia : String; AgenciaDC : String; Conta : String; ContaDC : String;
   Cheque : String; ChequeDC : String; Compensacao: String) : Boolean ;
var
  Sts : Integer;
  Restr : AnsiString ;

  Function FormataCampo( Campo : AnsiString; Tamanho : Integer ) : AnsiString ;
  begin
    Result := padR( OnlyNumber( Trim( Campo ) ), Tamanho, '0') ;
  end ;

begin
  VerificarTransacaoPagamento( Valor );

  Respostas.Values['501'] := ifthen(TipoPessoa = 'J','1','0');

  if DocumentoPessoa <> '' then
     Respostas.Values['502'] := OnlyNumber(Trim(DocumentoPessoa));

  if DataCheque <> 0  then
     Respostas.Values['506'] := FormatDateTime('DDMMYYYY',DataCheque) ;

  if CMC7 <> '' then
     Respostas.Values['517'] := '1:'+CMC7
  else
     Respostas.Values['517'] := '0:'+FormataCampo(Compensacao,3)+
                                     FormataCampo(Banco,3)+
                                     FormataCampo(Agencia,4)+
                                     FormataCampo(AgenciaDC,1)+
                                     FormataCampo(Conta,10)+
                                     FormataCampo(ContaDC,1)+
                                     FormataCampo(Cheque,6)+
                                     FormataCampo(ChequeDC,1) ;

  Restr := fRestricoes;
  if Restr = '' then
     Restr := '[15;25]' ;  // 15 - Cartão Credito; 25 - Cartao Debito

  Sts := FazerRequisicao( fOperacaoCHQ, 'CHQ', Valor, DocumentoVinculado, Restr ) ;

  if Sts = 10000 then
     Sts := ContinuarRequisicao( False ) ;  { False = NAO Imprimir Comprovantes agora }

  Result := ( Sts = 0 ) ;

  if not Result then
     AvaliaErro( Sts )
  else
     ProcessarRespostaPagamento( IndiceFPG_ECF, Valor );
end;

Procedure TACBrTEFDCliSiTef.CNF(Rede, NSU, Finalizacao : String;
   DocumentoVinculado : String) ;
begin
  // CliSiTEF não usa Rede, NSU e Finalizacao

  FinalizarTransacao( True, DocumentoVinculado );
end;

Function TACBrTEFDCliSiTef.CNC(Rede, NSU : String;
   DataHoraTransacao : TDateTime; Valor : Double) : Boolean;
var
   Sts : Integer;
begin
  Respostas.Values['146'] := FormatFloat('0.00',Valor);
  Respostas.Values['147'] := FormatFloat('0.00',Valor);
  Respostas.Values['515'] := FormatDateTime('DDMMYYYY',DataHoraTransacao) ;
  Respostas.Values['516'] := NSU ;

  Sts := FazerRequisicao( fOperacaoCNC, 'CNC' ) ;

  if Sts = 10000 then
     Sts := ContinuarRequisicao( True ) ;  { True = Imprimir Comprovantes agora }

  Result := ( Sts = 0 ) ;

  if not Result then
     AvaliaErro( Sts );
end;

Procedure TACBrTEFDCliSiTef.NCN(Rede, NSU, Finalizacao : String;
   Valor : Double; DocumentoVinculado : String) ;
begin
  // CliSiTEF não usa Rede, NSU, Finalizacao e Valor

  FinalizarTransacao( False, DocumentoVinculado );
end;

function TACBrTEFDCliSiTef.ObtemQuantidadeTransacoesPendentes(Data:TDateTime;
  CupomFiscal: AnsiString): Integer;
var
  sDate:AnsiString;
begin
   sDate:= FormatDateTime('yyyymmdd',Data);
   if Assigned(xObtemQuantidadeTransacoesPendentes) then  
      Result := xObtemQuantidadeTransacoesPendentes(sDate,CupomFiscal)
   else
      raise Exception.Create( ACBrStr('CliSiTEF não inicializado' ) ) ;   
end;

Function TACBrTEFDCliSiTef.FazerRequisicao( Funcao : Integer;
   AHeader : AnsiString = ''; Valor : Double = 0; Documento : AnsiString = '';
   ListaRestricoes : AnsiString = '') : Integer ;
Var
  ValorStr, DataStr, HoraStr : AnsiString;
  ANow : TDateTime ;
begin
   if fpAguardandoResposta then
      raise Exception.Create( ACBrStr( 'Requisição anterior não concluida' ) ) ;

   fReimpressao := False;
   Result   := 0 ;
   ANow     := Now ;
   DataStr  := FormatDateTime('YYYYMMDD', ANow );
   HoraStr  := FormatDateTime('HHNNSS', ANow );
   ValorStr := StringReplace( FormatFloat( '0.00', Valor ),
                              DecimalSeparator, ',', [rfReplaceAll]) ;
   fDocumentosProcessados := '' ;

   GravaLog( '*** IniciaFuncaoSiTefInterativo. Modalidade: '+IntToStr(Funcao)+
                                             ' Valor: '     +ValorStr+
                                             ' Documento: ' +Documento+
                                             ' Data: '      +DataStr+
                                             ' Hora: '      +HoraStr+
                                             ' Operador: '  +fOperador+
                                             ' Restricoes: '+ListaRestricoes ) ;

   Result := xIniciaFuncaoSiTefInterativo( Funcao,
                                           PAnsiChar( ValorStr ),
                                           PAnsiChar( Documento ),
                                           PAnsiChar( DataStr ),
                                           PAnsiChar( HoraStr ),
                                           PAnsiChar( fOperador ),
                                           PAnsiChar( ListaRestricoes ) ) ;

   { Adiciona Campos já conhecidos em Resp, para processa-los em
     métodos que manipulam "RespostasPendentes" (usa códigos do G.P.)  }
   Resp.Clear;

   with TACBrTEFDRespCliSiTef( Resp ) do
   begin
     fpIDSeq := fpIDSeq + 1 ;
     if Documento = '' then
        Documento := IntToStr(fpIDSeq) ;

     Conteudo.GravaInformacao(899,100, AHeader ) ;
     Conteudo.GravaInformacao(899,101, IntToStr(fpIDSeq) ) ;
     Conteudo.GravaInformacao(899,102, Documento ) ;
     Conteudo.GravaInformacao(899,103, IntToStr(Trunc(SimpleRoundTo( Valor * 100 ,0))) );

     Resp.TipoGP := fpTipo;
   end;
end;

Function TACBrTEFDCliSiTef.ContinuarRequisicao( ImprimirComprovantes : Boolean )
  : Integer;
var
  ProximoComando, TipoCampo, Continua, ItemSelecionado, I: Integer;
  TamanhoMinimo, TamanhoMaximo : SmallInt ;
  Buffer: array [0..20000] of AnsiChar;
  Mensagem, MensagemOperador, MensagemCliente, CaptionMenu : String ;
  Resposta, ArqBackUp : AnsiString;
  SL : TStringList ;
  Interromper, Digitado, GerencialAberto, FechaGerencialAberto, ImpressaoOk,
     HouveImpressao, Voltar : Boolean ;
  Est : AnsiChar;
begin
   Result           := 0;
   ProximoComando   := 0;
   TipoCampo        := 0;
   TamanhoMinimo    := 0;
   TamanhoMaximo    := 0;
   Continua         := 0;
   Mensagem         := '' ;
   MensagemOperador := '' ;
   MensagemCliente  := '' ;
   CaptionMenu      := '' ;
   GerencialAberto  := False ;
   ImpressaoOk      := True ;
   HouveImpressao   := False ;
   ArqBackUp        := '' ;
   Resposta         := '' ;

   fpAguardandoResposta := True ;
   FechaGerencialAberto := True ;

   with TACBrTEFD(Owner) do
   begin
      try
         BloquearMouseTeclado( True );

         repeat
            GravaLog( 'ContinuaFuncaoSiTefInterativo, Chamando: Contina = '+
                      IntToStr(Continua)+' Buffer = '+Resposta ) ;

            Result := xContinuaFuncaoSiTefInterativo( ProximoComando,
                                                      TipoCampo,
                                                      TamanhoMinimo, TamanhoMaximo,
                                                      Buffer, sizeof(Buffer),
                                                      Continua );
            Continua := 0;
            Mensagem := TrimRight( Buffer ) ;
            Resposta := '' ;
            Voltar   := False;
            Digitado := True ;

            GravaLog( 'ContinuaFuncaoSiTefInterativo, Retornos: STS = '+IntToStr(Result)+
                      ' ProximoComando = '+IntToStr(ProximoComando)+
                      ' TipoCampo = '+IntToStr(TipoCampo)+
                      ' Buffer = '+Mensagem +
                      ' Tam.Min = '+IntToStr(TamanhoMinimo) +
                      ' Tam.Max = '+IntToStr(TamanhoMaximo)) ;

            if Result = 10000 then
            begin
              if TipoCampo > 0 then
                 Resposta := fRespostas.Values[IntToStr(TipoCampo)];

              case ProximoComando of
                 0 :
                   begin
                     TACBrTEFDRespCliSiTef( Self.Resp ).GravaInformacao( TipoCampo, Mensagem ) ;

                     case TipoCampo of
                        15 : TACBrTEFDRespCliSiTef( Self.Resp ).GravaInformacao( TipoCampo, 'True') ;//Selecionou Debito;
                        25 : TACBrTEFDRespCliSiTef( Self.Resp ).GravaInformacao( TipoCampo, 'True') ;//Selecionou Credito;
                        {Indica que foi escolhido menu de reimpressão}
                        56,57,58 : fReimpressao := True;
                        121, 122 :
                          if ImprimirComprovantes then
                          begin
                             { Impressão de Gerencial, deve ser Sob demanda }
                             if not HouveImpressao then
                             begin
                                HouveImpressao := True ;
                                ArqBackUp      := CopiarResposta;
                             end;

                             SL := TStringList.Create;
                             ImpressaoOk := False ;
                             I := TipoCampo ;
                             try
                                while not ImpressaoOk do
                                begin
                                  try
                                    while I <= TipoCampo do
                                    begin
                                       if FechaGerencialAberto then
                                       begin
                                         Est := EstadoECF;

                                         { Fecha Vinculado ou Gerencial ou Cupom, se ficou algum aberto por Desligamento }
                                         case Est of
                                           'C'         : ComandarECF( opeFechaVinculado );
                                           'G','R'     : ComandarECF( opeFechaGerencial );
                                           'V','P','N' : ComandarECF( opeCancelaCupom );
                                         end;

                                         GerencialAberto      := False ;
                                         FechaGerencialAberto := False ;

                                         if EstadoECF <> 'L' then
                                           raise EACBrTEFDECF.Create( ACBrStr('ECF não está LIVRE') ) ;
                                       end;

                                       Mensagem := Self.Resp.LeInformacao(I).AsString ;
                                       Mensagem := StringToBinaryString( Mensagem ) ;
                                       if Mensagem <> '' then
                                       begin
                                          SL.Text  := StringReplace( Mensagem, #10, sLineBreak, [rfReplaceAll] ) ;

                                          if not GerencialAberto then
                                           begin
                                             ComandarECF( opeAbreGerencial ) ;
                                             GerencialAberto := True ;
                                           end
                                          else
                                           begin
                                             ComandarECF( opePulaLinhas ) ;
                                             DoExibeMsg( opmDestaqueVia, 'Destaque a 1ª Via') ;
                                           end;

                                          ECFImprimeVia( trGerencial, I-120, SL );

                                          ImpressaoOk := True ;
                                       end;

                                       Inc( I ) ;
                                    end;

                                    if (TipoCampo = 122) and GerencialAberto then
                                    begin
                                       ComandarECF( opeFechaGerencial );
                                       GerencialAberto := False;
                                    end;
                                  except
                                    on EACBrTEFDECF do ImpressaoOk := False ;
                                    else
                                       raise ;
                                  end;

                                  if not ImpressaoOk then
                                  begin
                                    if DoExibeMsg( opmYesNo, 'Impressora não responde'+sLineBreak+
                                                             'Deseja imprimir novamente ?') <> mrYes then
                                      break ;

                                    I := 121 ;
                                    FechaGerencialAberto := True ;
                                  end;
                                end ;
                             finally
                                if not ImpressaoOk then
                                   Continua := -1 ;

                                SL.Free;
                             end;
                          end ;
                     end;
                   end;

                 1 :
                   begin
                     MensagemOperador := Mensagem;
                     DoExibeMsg( opmExibirMsgOperador, MensagemOperador ) ;
                   end ;

                 2 :
                   begin
                     MensagemCliente := Mensagem;
                     DoExibeMsg( opmExibirMsgCliente, MensagemCliente ) ;
                   end;

                 3 :
                   begin
                     MensagemOperador := Mensagem;
                     MensagemCliente  := Mensagem;
                     DoExibeMsg( opmExibirMsgOperador, MensagemOperador ) ;
                     DoExibeMsg( opmExibirMsgCliente, MensagemCliente ) ;
                   end ;

                 4 : CaptionMenu := ACBrStr( Mensagem ) ;

                 11 :
                   begin
                     MensagemOperador := '' ;
                     DoExibeMsg( opmRemoverMsgOperador, '' ) ;
                   end;

                 12 :
                   begin
                     MensagemCliente := '' ;
                     DoExibeMsg( opmRemoverMsgCliente, '' ) ;
                   end;

                 13 :
                   begin
                     DoExibeMsg( opmRemoverMsgOperador, '' ) ;
                     DoExibeMsg( opmRemoverMsgCliente, '' ) ;
                   end ;

                 14 : CaptionMenu := '' ;
                   {Deve limpar o texto utilizado como cabeçalho na apresentação do menu}

                 20 :
                   begin
                     if Mensagem = '' then
                        Mensagem := 'CONFIRMA ?';

                     Resposta := ifThen( (DoExibeMsg( opmYesNo, Mensagem ) = mrYes), '0', '1' ) ;
                     {Digitado := ( Resposta <> '1') ;}
                   end ;

                 21 :
                   begin
                     SL := TStringList.Create;
                     try
                        ItemSelecionado := -1 ;
                        SL.Text := StringReplace( Mensagem, ';',
                                                         sLineBreak, [rfReplaceAll] ) ;
                        BloquearMouseTeclado(False);
                        OnExibeMenu( CaptionMenu, SL, ItemSelecionado, Voltar ) ;
                        BloquearMouseTeclado(True);

                        if (not Voltar) then
                        begin
                           if (ItemSelecionado >= 0) and
                              (ItemSelecionado < SL.Count) then
                              Resposta := copy( SL[ItemSelecionado], 1,
                                             pos(':',SL[ItemSelecionado])-1 )
                           else
                              Digitado := False ;
                        end;
                     finally
                        SL.Free ;
                     end ;
                   end;

                 22 :
                   begin
                     if Mensagem = '' then
                        Mensagem := 'PRESSIONE <ENTER>';

                     DoExibeMsg( opmOK, Mensagem );
                   end ;

                 23 :
                   begin
                     Interromper := False ;
                     OnAguardaResp( '23', 0, Interromper ) ;
                     if Interromper then
                        Continua := -1 ;
                   end;

                 30 :
                   begin
                     BloquearMouseTeclado(False);
                     OnObtemCampo( ACBrStr(Mensagem), TamanhoMinimo, TamanhoMaximo,
                                   TipoCampo, tcString, Resposta, Digitado, Voltar) ;
                     {Se o tipo campo for 505 é a quantidade de parcelas}
                     TACBrTEFDRespCliSiTef( Self.Resp ).GravaInformacao( TipoCampo, Resposta ) ;
                     BloquearMouseTeclado(True);
                   end;

                 31 :
                   begin
                     BloquearMouseTeclado(False);
                     OnObtemCampo( ACBrStr(Mensagem), TamanhoMinimo, TamanhoMaximo,
                                   TipoCampo, tcCMC7, Resposta, Digitado, Voltar ) ;
                     BloquearMouseTeclado(True);
                   end;

                 34 :
                   begin
                     BloquearMouseTeclado(False);
                     OnObtemCampo( ACBrStr(Mensagem), TamanhoMinimo, TamanhoMaximo,
                                   TipoCampo, tcDouble, Resposta, Digitado, Voltar ) ;
                     BloquearMouseTeclado(True);

                     // Garantindo que a Resposta é Float //
                     Resposta := FormatFloat('0.00', StringToFloatDef(Resposta, 0));
                     // Garantindo que o Seprador de Decimal é a Virgula //
                     if DecimalSeparator <> ',' then
                        Resposta := StringReplace( Resposta, DecimalSeparator, ',', [] );
                   end;

                 35 :
                   begin
                     BloquearMouseTeclado(False);
                     OnObtemCampo( ACBrStr(Mensagem), TamanhoMinimo, TamanhoMaximo,
                                   TipoCampo, tcBarCode, Resposta, Digitado, Voltar ) ;
                     BloquearMouseTeclado(True);
                   end;

              end;
            end
            else
               GravaLog( '*** ContinuaFuncaoSiTefInterativo, Finalizando: STS = '+IntToStr(Result) ) ;

            if Voltar then
               Continua := 1     { Volta para o menu anterior }
            else if not Digitado then
               Continua := -1 ;  { Cancela operacao }

            StrPCopy(Buffer, Resposta);

         until Result <> 10000;
      finally
        if GerencialAberto then
        try
           ComandarECF( opeFechaGerencial );
        except
           ImpressaoOk := False ;
        end;

        if (ArqBackUp <> '') and FileExists( ArqBackUp ) then
           SysUtils.DeleteFile( ArqBackUp );

        if HouveImpressao then
           FinalizarTransacao( ImpressaoOk, Resp.DocumentoVinculado );

        BloquearMouseTeclado( False );

        { Transfere valore de "Conteudo" para as propriedades }
        TACBrTEFDRespCliSiTef( Self.Resp ).ConteudoToProperty ;

        fpAguardandoResposta := False ;
      end;
   end ;
end;

procedure TACBrTEFDCliSiTef.FinalizarTransacao( Confirma : Boolean;
   DocumentoVinculado : AnsiString);
Var
   DataStr, HoraStr : AnsiString;
begin
   fRespostas.Clear;

   if (fReimpressao) or (pos(DocumentoVinculado, fDocumentosProcessados) > 0) then
      exit;

  fDocumentosProcessados := fDocumentosProcessados + DocumentoVinculado + '|' ;

  DataStr := FormatDateTime('YYYYMMDD',Now);
  HoraStr := FormatDateTime('HHNNSS',Now);

  GravaLog( '*** FinalizaTransacaoSiTefInterativo. Confirma: '+IfThen(Confirma,'SIM','NAO')+
                                          ' Documento: ' +DocumentoVinculado+
                                          ' Data: '      +DataStr+
                                          ' Hora: '      +HoraStr ) ;

  xFinalizaTransacaoSiTefInterativo( IfThen(Confirma,1,0),
                                     PAnsiChar( DocumentoVinculado ),
                                     PAnsiChar( DataStr ),
                                     PAnsiChar( HoraStr ) ) ;

  if not Confirma then
     TACBrTEFD(Owner).DoExibeMsg( opmOK, 'Transação não efetuada.'+sLineBreak+
                                         'Favor reter o Cupom');

end;

procedure TACBrTEFDCliSiTef.AvaliaErro( Sts : Integer );
//var
//   Erro : String;
begin
(*
   Erro := '' ;
   Case Sts of
        -1 : Erro := 'Módulo não inicializado' ;
        -2 : Erro := 'Operação cancelada pelo operador' ;
        -3 : Erro := 'Fornecida uma modalidade inválida' ;
        -4 : Erro := 'Falta de memória para rodar a função' ;
        -5 : Erro := '' ; // 'Sem comunicação com o SiTef' ; // Comentado pois SiTEF já envia a msg de Erro
        -6 : Erro := 'Operação cancelada pelo usuário' ;
   else
      if Sts < 0 then
         Erro := 'Erros detectados internamente pela rotina ('+IntToStr(Sts)+')'
      else
         Erro := 'Negada pelo autorizador ('+IntToStr(Sts)+')' ;
   end;


   if Erro <> '' then
      TACBrTEFD(Owner).DoExibeMsg( opmOK, Erro );
*)
end ;

Function TACBrTEFDCliSiTef.ProcessarRespostaPagamento(
   const IndiceFPG_ECF : String; const Valor : Double) : Boolean; 
var
  ImpressaoOk : Boolean;
  RespostaPendente : TACBrTEFDResp ;
begin
  Result := True ;

  with TACBrTEFD(Owner) do
  begin
     Self.Resp.IndiceFPG_ECF := IndiceFPG_ECF;

     { Cria Arquivo de Backup, contendo Todas as Respostas }
     CopiarResposta ;

     { Cria cópia do Objeto Resp, e salva no ObjectList "RespostasPendentes" }
     RespostaPendente := TACBrTEFDRespCliSiTef.Create ;
     RespostaPendente.Assign( Resp );
     RespostasPendentes.Add( RespostaPendente );

     if AutoEfetuarPagamento then
     begin
        ImpressaoOk := False ;

        try
           while not ImpressaoOk do
           begin
              try
                 ECFPagamento( IndiceFPG_ECF, Valor );
                 RespostasPendentes.SaldoAPagar  := RoundTo( RespostasPendentes.SaldoAPagar - Valor, -2 ) ;
                 RespostaPendente.OrdemPagamento := RespostasPendentes.Count + 1 ;
                 ImpressaoOk := True ;
              except
                 on EACBrTEFDECF do ImpressaoOk := False ;
                 else
                    raise ;
              end;

              if not ImpressaoOk then
              begin
                 if DoExibeMsg( opmYesNo, 'Impressora não responde'+sLineBreak+
                                          'Deseja imprimir novamente ?') <> mrYes then
                 begin
                    try ComandarECF(opeCancelaCupom); except {Exceção Muda} end ;
                    break ;
                 end;
              end;
           end;
        finally
           if not ImpressaoOk then
              CancelarTransacoesPendentes;
        end;
     end;

     if RespostasPendentes.SaldoRestante <= 0 then
     begin
        if AutoFinalizarCupom then
        begin
           FinalizarCupom;
           ImprimirTransacoesPendentes;
        end;
     end ;
  end;
end;

end.

