{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2011 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Regys silveira, Isaque Pinheiro                 }
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
{       Rua Coronel Aureliano de Camargo, 973 - Tatuí - SP - 18270-170         }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrAAC;

interface

uses ACBrBase, ACBrPAFClass,
     SysUtils, Classes;

type
  EACBrAAC                       = class(Exception);
  EACBrAAC_CRC                   = class(EACBrAAC);
  EACBrAAC_ArqNaoEncontrado      = class(EACBrAAC);
  EACBrAAC_SemNomeArquivo        = class(EACBrAAC);
  EACBrAAC_SemChave              = class(EACBrAAC);
  EACBrAAC_SemResposta           = class(EACBrAAC);
  EACBrAAC_ArquivoInvalido       = class(EACBrAAC);
  EACBrAAC_NumSerieNaoEncontrado = class(EACBrAAC);
  EACBrAAC_ValorGTInvalido       = class(EACBrAAC);

  TACBrAACOnCrypt   = procedure( ConteudoArquivo : AnsiString;
     var Resposta : AnsiString ) of object ;
  TACBrAACOnDeCrypt = procedure( ConteudoCriptografado : AnsiString;
     var Resposta : AnsiString ) of object ;
  TACBrAACGetChave = procedure(var Chave: AnsiString) of object ;
  TACBrAACAntesArquivo = procedure( var Continua: Boolean) of object ;
  TACBrAACOnVerificarRecomporValorGT = procedure(const NumSerie: String;
     var ValorGT : Double) of object ;

  { TACBrAAC }

  TACBrAAC = class( TACBrComponent )
  private
     fsArqLOG : String ;
     fsCriarBAK : Boolean ;
     fsDtHrArquivo : TDateTime ;
     fsEfetuarFlush : Boolean ;
     fsGravarDadosPAF : Boolean ;
     fsGravarDadosSH : Boolean ;
     fsGravarTodosECFs : Boolean ;
     fsNomeArquivoAux : String ;
     fsNomeCompleto : String ;
     fsOnAntesAbrirArquivo : TACBrAACAntesArquivo ;
     fsOnAntesGravarArquivo : TACBrAACAntesArquivo ;
     fsOnCrypt : TACBrAACOnCrypt ;
     fsOnDeCrypt : TACBrAACOnDeCrypt ;
     fsOnDepoisAbrirArquivo : TNotifyEvent ;
     fsOnDepoisGravarArquivo : TNotifyEvent ;
     fsOnGetChave : TACBrAACGetChave ;
     fsOnVerificarRecomporValorGT : TACBrAACOnVerificarRecomporValorGT ;
     fsParams : TStringList ;
     fsIdentPAF: TACBrECFIdentificacaoPAF;
     function GetChave : AnsiString ;
     procedure SetNomeArquivoAux(const AValue : String) ;
     procedure SetParams(const AValue : TStringList) ;
  protected

     function Criptografar( const Dados: AnsiString ) : AnsiString ;
     function DesCriptografar( const Dados: AnsiString ) : AnsiString ;
     Procedure GravaLog( const AString: AnsiString );
     procedure VerificaReCarregarArquivo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AchaECF( const NumSerie : String ) : TACBrAACECF ;
    function AchaIndiceECF(const NumeroSerie: String): Integer;

    property Chave : AnsiString read GetChave ;

    procedure AbrirArquivo;
    procedure SalvarArquivo;

    function VerificarGTECF(const NumeroSerie: String;
      var ValorGT: Double): Integer ;
    procedure AtualizarMD5(const AMD5: String);
    procedure AtualizarValorGT(const NumeroSerie: String;
      const ValorGT: Double);

    property DtHrArquivo : TDateTime read fsDtHrArquivo ;

  published
    property NomeArquivoAux : String  read fsNomeArquivoAux
       write SetNomeArquivoAux ;
    property CriarBAK : Boolean read fsCriarBAK write fsCriarBAK default True;
    property EfetuarFlush : Boolean read fsEfetuarFlush write fsEfetuarFlush default True;
    property GravarDadosSH  : Boolean read fsGravarDadosSH
       write fsGravarDadosSH default True;
    property GravarDadosPAF : Boolean read fsGravarDadosPAF
       write fsGravarDadosPAF default True;
    property GravarTodosECFs : Boolean read fsGravarTodosECFs
       write fsGravarTodosECFs default True;
    property ArqLOG : String  read fsArqLOG write fsArqLOG ;

    property IdentPAF    : TACBrECFIdentificacaoPAF
       read fsIdentPAF write fsIdentPAF;

    property Params : TStringList read fsParams write SetParams ;

    { Eventos }
    property OnCrypt   : TACBrAACOnCrypt   read fsOnCrypt    write fsOnCrypt ;
    property OnDeCrypt : TACBrAACOnDeCrypt read fsOnDeCrypt  write fsOnDeCrypt ;
    property OnGetChave: TACBrAACGetChave  read fsOnGetChave write fsOnGetChave ;
    property OnAntesAbrirArquivo : TACBrAACAntesArquivo read fsOnAntesAbrirArquivo
      write fsOnAntesAbrirArquivo ;
    property OnDepoisAbrirArquivo : TNotifyEvent read fsOnDepoisAbrirArquivo
      write fsOnDepoisAbrirArquivo ;
    property OnAntesGravarArquivo : TACBrAACAntesArquivo read fsOnAntesGravarArquivo
      write fsOnAntesGravarArquivo ;
    property OnDepoisGravarArquivo : TNotifyEvent
      read fsOnDepoisGravarArquivo write fsOnDepoisGravarArquivo ;
    property VerificarRecomporValorGT : TACBrAACOnVerificarRecomporValorGT
      read fsOnVerificarRecomporValorGT write fsOnVerificarRecomporValorGT;
  end;

implementation

Uses IniFiles, ACBrUtil, math ;

{ TACBrAAC }

constructor TACBrAAC.Create(AOwner : TComponent) ;
begin
  inherited Create(AOwner) ;

  fsParams          := TStringList.Create;
  fsIdentPAF        := TACBrECFIdentificacaoPAF.Create;

  fsOnCrypt    := nil ;
  fsOnDeCrypt  := nil ;
  fsOnGetChave := nil ;
  fsOnAntesAbrirArquivo   := nil ;
  fsOnDepoisAbrirArquivo  := nil ;
  fsOnAntesGravarArquivo  := nil ;
  fsOnDepoisGravarArquivo := nil ;

  fsNomeArquivoAux    := '' ;
  fsCriarBAK          := True;
  fsEfetuarFlush      := True;
  fsGravarDadosSH     := True;
  fsGravarDadosPAF    := True;
  fsGravarTodosECFs   := True;
  fsDtHrArquivo       := 0 ;
end ;

destructor TACBrAAC.Destroy ;
begin
  fsIdentPAF.Free;
  fsParams.Free;

  inherited Destroy ;
end ;

function TACBrAAC.AchaECF(const NumSerie : String) : TACBrAACECF ;
Var
  I : Integer ;
begin
  VerificaReCarregarArquivo;

  Result := nil;
  I      := 0 ;
  while (Result = nil) and (I < fsIdentPAF.ECFsAutorizados.Count) do
  begin
    if Trim( NumSerie ) = Trim( fsIdentPAF.ECFsAutorizados[I].NumeroSerie ) then
       Result := fsIdentPAF.ECFsAutorizados[I]
    else
       Inc( I ) ;
  end ;
end ;

procedure TACBrAAC.AbrirArquivo ;
var
  Ini: TMemIniFile;
  SL : TStringList;
  MS : TMemoryStream ;
  I  : Integer ;
  S, R : AnsiString ;
  Linha, Ident : String ;
  Continua : Boolean ;
  CRC : Word ;
begin
  GravaLog( 'AbrirArquivo');

  Continua := True;
  if Assigned( fsOnAntesAbrirArquivo ) then
     fsOnAntesAbrirArquivo( Continua );

  if not Continua then
  begin
     GravaLog( 'AbrirArquivo abortado' );
     exit;
  end ;

  if NomeArquivoAux = '' then
     raise EACBrAAC_SemNomeArquivo.Create( ACBrStr('Nome do Arquivo não Informado em: ACBrAAC.NomeArquivoAux') ) ;

  if not FileExists( fsNomeCompleto ) then
     raise EACBrAAC_ArqNaoEncontrado.Create(
        ACBrStr( 'Arquivo Auxiliar Criptografado'+sLineBreak+
                 '"'+NomeArquivoAux+'"'+sLineBreak+
                 'não encontrado') );

  fsDtHrArquivo := FileDateToDateTime( FileAge( fsNomeCompleto ) );

  // Lê arquivo de modo binário e transfere para a AnsiString = S //
  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile( fsNomeCompleto );
    MS.Position := 0;
    SetLength(S, MS.Size);
    MS.ReadBuffer(PChar(S)^, MS.Size);
  finally
    MS.Free;
  end;

  SL  := TStringList.Create ;
  Ini := TMemIniFile.Create('') ;
  try
     // DEBUG
     // GravaLog('Arquivo Lido: '+sLineBreak+ S );
     R := DesCriptografar( S ) ;
     // DEBUG
     //GravaLog('Arquivo Descriptografado: '+sLineBreak+ R );

     SL.Text := R;
     Ini.SetStrings( SL );

     if GravarDadosSH then
     begin
        fsIdentPAF.Empresa.Cep         := Ini.ReadString('SH','Cep','');
        fsIdentPAF.Empresa.Cidade      := Ini.ReadString('SH','Cidade','');
        fsIdentPAF.Empresa.CNPJ        := Ini.ReadString('SH','CNPJ','');
        fsIdentPAF.Empresa.Contato     := Ini.ReadString('SH','Contato','');
        fsIdentPAF.Empresa.Email       := Ini.ReadString('SH','Email','');
        fsIdentPAF.Empresa.Endereco    := Ini.ReadString('SH','Endereco','');
        fsIdentPAF.Empresa.IE          := Ini.ReadString('SH','IE','');
        fsIdentPAF.Empresa.IM          := Ini.ReadString('SH','IM','');
        fsIdentPAF.Empresa.RazaoSocial := Ini.ReadString('SH','Nome','');
        fsIdentPAF.Empresa.Telefone    := Ini.ReadString('SH','Telefone','');
        fsIdentPAF.Empresa.Uf          := Ini.ReadString('SH','Uf','');
     end ;

     if GravarDadosPAF then
     begin
        fsIdentPAF.NumeroLaudo           := Ini.ReadString('PAF','NumeroLaudo',''); // Número do Laudo
        fsIdentPAF.VersaoER              := Ini.ReadString('PAF','VersaoER','');    // Versão do Roteiro Executado na Homologação
        fsIdentPAF.Paf.Nome              := Ini.ReadString('PAF','Nome','');        // Nome do Sistema PAF
        fsIdentPAF.Paf.Versao            := Ini.ReadString('PAF','Versao','');      // Versão do Sistema PAF
        fsIdentPAF.Paf.PrincipalExe.Nome := Ini.ReadString('PAF','NomeExe','');     // Nome do Principal EXE do PAF
        fsIdentPAF.Paf.PrincipalExe.MD5  := Ini.ReadString('PAF','MD5Exe','');      // MD5 do Principal EXE do PAF
     end ;
     fsIdentPAF.ArquivoListaAutenticados.MD5 := Ini.ReadString('PAF','MD5','');     // MD5 do arquivo que contem a lista de arquivos autenticados

     if GravarDadosPAF and GravarDadosSH then
     begin
       CRC := StringCrc16( fsIdentPAF.Empresa.RazaoSocial +
                           fsIdentPAF.Empresa.CNPJ +
                           fsIdentPAF.Empresa.IE +
                           fsIdentPAF.Empresa.IM +
                           fsIdentPAF.Paf.Nome +
                           fsIdentPAF.Paf.Versao +
                           fsIdentPAF.ArquivoListaAutenticados.MD5 );
       if Ini.ReadInteger('CHK','CRC16',0) <> CRC then
          raise EACBrAAC_ArquivoInvalido.Create(
             ACBrStr('Arquivo: '+NomeArquivoAux+' inválido') );
     end ;

     fsIdentPAF.ECFsAutorizados.Clear;
     I := 0 ;
     while True do
     begin
        Ident := 'ECF_'+IntToStrZero(I,4);
        Linha := Ini.ReadString( 'ECFs', Ident, '*FIM*' );

        if Linha = '*FIM*' then
           break ;

        with fsIdentPAF.ECFsAutorizados.New do
        begin
           LinhaDados := Linha;
        end;

        Inc( I ) ;
     end ;

     Params.Clear;
     I := 0 ;
     while True do
     begin
        Ident := 'L_'+IntToStrZero(I,4);
        Linha := Ini.ReadString( 'Params', Ident, '*FIM*' );

        if Linha = '*FIM*' then
           break ;

        Params.Add( Linha );
        Inc( I ) ;
     end ;

     if Assigned( fsOnDepoisAbrirArquivo ) then
        fsOnDepoisAbrirArquivo( Self );

  finally
     Ini.Free ;
     SL.Free;
  end ;
end ;

procedure TACBrAAC.SalvarArquivo ;
var
  Ini: TMemIniFile;
  SL : TStringList;
  I  : Integer ;
  Ident  : String ;
  ArqBak : String ;
  R      : AnsiString ;
  Continua : Boolean ;
  CRC : Word ;
begin
  GravaLog( 'GravarArqRegistro' );

  Continua := True;
  if Assigned( fsOnAntesGravarArquivo ) then
    fsOnAntesGravarArquivo( Continua );

  if not Continua then
  begin
    GravaLog( 'GravarArqRegistro abortado' );
    exit;
  end ;

  if NomeArquivoAux = '' then
    raise EACBrAAC_SemNomeArquivo.Create( ACBrStr('Nome do Arquivo não Informado em: ACBrAAC.NomeArquivoAux') ) ;

  if GravarDadosSH then
  begin
    if (fsIdentPAF.Empresa.RazaoSocial = '') or (fsIdentPAF.Empresa.CNPJ = '') then
      raise EACBrAAC_ArquivoInvalido.Create(
         ACBrStr('SH_RazaoSocial e/ou SH_CNPJ não informados') );
  end ;

  if GravarDadosPAF then
  begin
    if (fsIdentPAF.Paf.Nome = '') or (fsIdentPAF.Paf.Versao = '')then
      raise EACBrAAC_ArquivoInvalido.Create(
         ACBrStr('PAF_Nome e/ou PAF_Versao não informados') );
  end ;

  SL  := TStringList.Create ;
  Ini := TMemIniFile.Create( '' ) ;
  try
     if GravarDadosSH then
     begin
        Ini.WriteString('SH','CNPJ',fsIdentPAF.Empresa.CNPJ);
        Ini.WriteString('SH','Nome',fsIdentPAF.Empresa.RazaoSocial);
        Ini.WriteString('SH','Cep',fsIdentPAF.Empresa.Cep);
        Ini.WriteString('SH','Cidade',fsIdentPAF.Empresa.Cidade);
        Ini.WriteString('SH','Contato',fsIdentPAF.Empresa.Contato);
        Ini.WriteString('SH','Email',fsIdentPAF.Empresa.Email);
        Ini.WriteString('SH','Endereco',fsIdentPAF.Empresa.Endereco);
        Ini.WriteString('SH','IE',fsIdentPAF.Empresa.IE);
        Ini.WriteString('SH','IM',fsIdentPAF.Empresa.IM);
        Ini.WriteString('SH','Telefone',fsIdentPAF.Empresa.Telefone);
        Ini.WriteString('SH','Uf',fsIdentPAF.Empresa.Uf);
     end ;

     if GravarDadosPAF then
     begin
        Ini.WriteString('PAF','Nome',fsIdentPAF.Paf.Nome);                 // Nome do Sistema PAF
        Ini.WriteString('PAF','Versao',fsIdentPAF.Paf.Versao);             // Versão do Sistema PAF
        Ini.WriteString('PAF','NumeroLaudo',fsIdentPAF.NumeroLaudo);       // Número do Laudo
        Ini.WriteString('PAF','VersaoER',fsIdentPAF.VersaoER);             // Versão do Roteiro Executado na Homologação
        Ini.WriteString('PAF','NomeExe',fsIdentPAF.Paf.PrincipalExe.Nome); // Nome do Principal EXE do PAF
        Ini.WriteString('PAF','MD5Exe',fsIdentPAF.Paf.PrincipalExe.MD5);   // MD5  do Principal EXE do PAF
     end ;
     Ini.WriteString('PAF','MD5',fsIdentPAF.ArquivoListaAutenticados.MD5); // MD5 do arquivo que contem a lista de arquivos autenticados

     // Lista de ECFs autorizados a usar o PAF-ECF no estabelecimento
     For I := 0 to fsIdentPAF.ECFsAutorizados.Count-1 do
     begin
        Ident := 'ECF_'+IntToStrZero(I,4);
        Ini.WriteString( 'ECFs', Ident, fsIdentPAF.ECFsAutorizados[I].LinhaDados );
     end ;

     // Lista de parametros adicionais
     For I := 0 to Params.Count-1 do
     begin
        Ident := 'L_'+IntToStrZero(I,4);
        Ini.WriteString( 'Params', Ident, Params[I] );
     end ;

     if GravarDadosPAF and GravarDadosSH then
     begin
       // Calculando o CRC //
       CRC := StringCrc16( fsIdentPAF.Empresa.RazaoSocial +
                           fsIdentPAF.Empresa.CNPJ +
                           fsIdentPAF.Empresa.IE +
                           fsIdentPAF.Empresa.IM +
                           fsIdentPAF.Paf.Nome +
                           fsIdentPAF.Paf.Versao +
                           fsIdentPAF.ArquivoListaAutenticados.MD5 );
       Ini.WriteInteger('CHK','CRC16',CRC);
     end ;

     Ini.GetStrings( SL );

     // DEBUG
     //GravaLog('Arquivo em Memoria: '+sLineBreak+ SL.Text );
     R := Criptografar( SL.Text );
     // DEBUG
     //GravaLog('Arquivo Criptografado: '+sLineBreak+ R );

     if fsCriarBAK then
     begin
        ArqBak := ChangeFileExt( fsNomeCompleto, '.bak');
        DeleteFile( ArqBak );
        RenameFile( fsNomeCompleto, ArqBak );
     end ;

     WriteToTXT( fsNomeCompleto, R, False, False );

     if fsEfetuarFlush then
        FlushToDisk( fsNomeCompleto );

     fsDtHrArquivo := FileDateToDateTime( FileAge( fsNomeCompleto ) );

     if Assigned( fsOnDepoisGravarArquivo ) then
        fsOnDepoisGravarArquivo( Self );
  finally
     Ini.Free ;
     SL.Free;
  end ;
end ;

procedure TACBrAAC.VerificaReCarregarArquivo ;
var
   NewDtHrArquivo : TDateTime;
begin
  // Data/Hora do arquivo é diferente ?
  NewDtHrArquivo := FileDateToDateTime( FileAge( fsNomeCompleto ) ) ;

  if fsDtHrArquivo <> NewDtHrArquivo then
     AbrirArquivo ;
end ;

function TACBrAAC.AchaIndiceECF(const NumeroSerie : String ) : Integer ;
Var
  I : Integer ;
begin
  VerificaReCarregarArquivo;

  I := 0 ;
  while (I < fsIdentPAF.ECFsAutorizados.Count) and
        (NumeroSerie <> fsIdentPAF.ECFsAutorizados[I].NumeroSerie) do
    Inc( I ) ;

  if I = fsIdentPAF.ECFsAutorizados.Count then
     Result := -1
  else
     Result := I ;
end ;

function TACBrAAC.VerificarGTECF(const NumeroSerie : String ;
   var ValorGT : Double) : Integer ;
// Retornos:
//   0 = Tudo OK
//  -1 = NumSerie não encontrado
//  -2 = GT não confere
var
   AECF : TACBrAACECF ;
   ValorGTNovo : Double ;
begin
  Result := 0;
  VerificaReCarregarArquivo;

  AECF := AchaECF( NumeroSerie );
  if not Assigned( AECF ) then
     Result := -1
  else
    if RoundTo( AECF.ValorGT, -2) <> RoundTo( ValorGT, -2 ) then
    begin
       ValorGT := AECF.ValorGT;
       Result  := -2;

       if Assigned( fsOnVerificarRecomporValorGT ) then
       begin
          ValorGTNovo := AECF.ValorGT;
          fsOnVerificarRecomporValorGT( NumeroSerie, ValorGTNovo );

          if RoundTo( ValorGTNovo, -2) <> RoundTo( AECF.ValorGT, -2) then
          begin
             AtualizarValorGT( NumeroSerie, ValorGTNovo );
             Result := 0;
          end ;
       end ;
    end ;
end ;

procedure TACBrAAC.AtualizarMD5(const AMD5 : String) ;
var
  iFor: Integer;
begin
  GravaLog( 'AtualizarMD5 - De: '+fsIdentPAF.ArquivoListaAutenticados.MD5+' Para: '+AMD5 );

  if fsDtHrArquivo = 0 then
     AbrirArquivo;

  if AMD5 = fsIdentPAF.ArquivoListaAutenticados.MD5 then exit ;

  fsIdentPAF.ArquivoListaAutenticados.MD5 := AMD5;

  // Acha o MD5 do EXE principal, caso o nome já esteja definido
  if fsIdentPAF.Paf.PrincipalExe.Nome <> '' then
  begin
     for iFor := 0 to fsIdentPAF.OutrosArquivos.Count - 1 do
     begin
        if AnsiCompareText(fsIdentPAF.Paf.PrincipalExe.Nome, fsIdentPAF.OutrosArquivos[iFor].Nome) = 0 then
        begin
           fsIdentPAF.Paf.PrincipalExe.MD5 := fsIdentPAF.OutrosArquivos[iFor].MD5;
           Break
        end;
     end;
  end;

  SalvarArquivo;
end ;

procedure TACBrAAC.AtualizarValorGT(const NumeroSerie : String ;
   const ValorGT : Double) ;
var
  AECF, NewECF : TACBrAACECF ;
  LogTXT: String;
begin
  LogTXT := 'AtualizarGTECF - NumSerie: '+NumeroSerie ;

  if fsDtHrArquivo = 0 then
     AbrirArquivo;

  AECF := AchaECF( NumeroSerie );
  if not Assigned( AECF ) then
  begin
     LogTXT := LogTXT +' - nao encontrado';
     GravaLog( LogTXT );
     raise EACBrAAC_NumSerieNaoEncontrado.Create( ACBrStr(
        'Erro ao atualivar Valor do G.T.'+sLineBreak+
        ' ECF: '+NumeroSerie+' não encontrado') );
  end ;

  LogTXT := LogTXT + ' - De:' +FormatFloat('###,###,##0.00',AECF.ValorGT)+
                     ' Para:'+FormatFloat('###,###,##0.00',ValorGT) ;
  GravaLog( LogTXT );

  if RoundTo( ValorGT, -2) = RoundTo( AECF.ValorGT, -2) then exit ;

  AECF.ValorGT        := ValorGT ;
  AECF.DtHrAtualizado := Now;

  if (not fsGravarTodosECFs) and (fsIdentPAF.ECFsAutorizados.Count > 1) then
  begin
    NewECF := TACBrAACECF.Create;
    NewECF.NumeroSerie    := AECF.NumeroSerie;
    NewECF.CRO            := AECF.CRO;
    NewECF.DtHrAtualizado := AECF.DtHrAtualizado;
    NewECF.ValorGT        := AECF.ValorGT;

    fsIdentPAF.ECFsAutorizados.Clear;
    fsIdentPAF.ECFsAutorizados.Add( NewECF );
  end ;

  SalvarArquivo;
end ;

procedure TACBrAAC.GravaLog( const AString : AnsiString) ;
begin
  if fsArqLOG = '' then
     exit ;

  try
     WriteToTXT(fsArqLOG, FormatDateTime('dd/mm hh:nn',Now)+' - '+AString, True);
  except
  end ;
end ;

function TACBrAAC.GetChave : AnsiString ;
Var
  AChave : AnsiString ;
begin
  AChave := '';
  if Assigned( fsOnGetChave ) then
     fsOnGetChave( AChave );

  if AChave = '' then
     raise EACBrAAC_SemChave.Create(
        ACBrStr('Chave não informada ou Evento ACBrAAC.OnGetChave não programado' ) );

  Result := AChave;
end;

procedure TACBrAAC.SetNomeArquivoAux(const AValue : String) ;
begin
  if fsNomeArquivoAux = AValue then exit ;

  fsNomeArquivoAux := AValue ;

  fsNomeCompleto := fsNomeArquivoAux;
  // Tem Path no Nome do Arquivo ?
  if (fsNomeCompleto <> '') and (pos(PathDelim, fsNomeCompleto) = 0) then
     fsNomeCompleto := ExtractFilePath( ParamStr(0) ) + fsNomeCompleto;
end ;

procedure TACBrAAC.SetParams(const AValue : TStringList) ;
begin
   fsParams.Assign( AValue );
end ;

function TACBrAAC.Criptografar( const Dados : AnsiString) : AnsiString ;
var
   R : AnsiString ;
begin
  R := '' ;
  if Assigned( fsOnCrypt ) then
   begin
     fsOnCrypt( Dados, R ) ;

     if R = '' then
        raise EACBrAAC_SemResposta.Create(
           ACBrStr('Evento ACBrACC.OnCrypt não informou a resposta') ) ;
   end
  else
     R := StrCrypt( Dados, Chave );

  Result := R ;
end ;

function TACBrAAC.DesCriptografar( const Dados : AnsiString) : AnsiString ;
var
   R : AnsiString ;
begin
  R := '' ;
  if Assigned( fsOnDeCrypt ) then
   begin
     fsOnDeCrypt( Dados, R ) ;

     if R = '' then
        raise EACBrAAC_SemResposta.Create(
           ACBrStr('Evento ACBrACC.OnDeCrypt não informou a resposta') ) ;
   end
  else
     R := StrCrypt( Dados, Chave );

  Result := R ;
end ;

end.

