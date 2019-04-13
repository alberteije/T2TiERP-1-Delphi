{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2010                                        }
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
|* 05/07/2010: Elton M. Barbosa
|*  - Baseado em métodos já existentes no ACBrRFD.
|*  - Esboço da Primeira Versao para avaliação.
*******************************************************************************}

{$I ACBr.inc}

unit ACBrEAD;

interface

{$IFNDEF FPC}
 {$DEFINE USE_libeay32}
{$ENDIF}

uses
   Classes, SysUtils,
   ACBrUtil, {$IFDEF USE_libeay32}libeay32{$ELSE} OpenSSL{$ENDIF};

const
   CACBrEAD_Versao = '0.3.0' ;
   cRFDRSAKey = '-----BEGIN RSA PRIVATE KEY-----' + sLineBreak +
                'MIICXQIBAAKBgQCtpPqcoOX4rwgdoKi6zJwPX9PA2iX2KxgvyxjE+daI5ZmYxcg0'+ sLineBreak +
                'NScjX59nXRaLmtltVRfsRc1n4+mLSXiWMh3jIbw+TWn+GXKQhS2GitpLVhO3A6Ns'+ sLineBreak +
                'vO1+RuP77s+uGYhqVvbD0Pziq+I2r4oktsjTbpnC7Mof3BjJdIUFsTHKYwIDAQAB'+ sLineBreak +
                'AoGAXXqwU7umsi8ADnsb+pwF85zh8TM/NnvSpIAQkJHzNXVtL7ph4gEvVbK3rLyH'+ sLineBreak +
                'U5aEMICbxV16i9A9PPfLjAfk4CuPpZlTibgfBRIG3MXirum0tjcyzbPyiDrk0qwM'+ sLineBreak +
                'e83MyRkrnGlss6cRT3mZk67txEamqTVmDwz/Sfo1fVlCQAkCQQDW3N/EKyT+8tPW'+ sLineBreak +
                '1EuPXafRONMel4xB1RiBmHYJP1bo/sDebLpocL6oiVlUX/k/zPRo1wMvlXJxPyiz'+ sLineBreak +
                'mnf37cZ9AkEAzuPcDvGxwawr7EPGmPQ0f7aWv87tS/rt9L3nKiz8HfrT6WT0R1Bh'+ sLineBreak +
                'I7lLGq4VFWE29I6hQ2lPNGX9IGFjiflKXwJBALgsO+J62QtwOgU7lEkfjmnYu57N'+ sLineBreak +
                'aHxFnOv5M7RZhrXRKKF/sYk0mzj8AoZAffYiSJ5VL3XqNF6+NLU/AvaR6kECQQCV'+ sLineBreak +
                'nY6sd/kWmA4DhFgAkMnOehq2h0xwH/0pepPLmlCQ1a2eIVXOpMA692rq1m2E0pLN'+ sLineBreak +
                'dMAGYgfXWtIdMpCrXM59AkB5npcELeGBv1K8B41fmrlA6rEq4aqmfwAFRKcQTj8a'+ sLineBreak +
                'n09FVtccLVPJ42AM1/QXK6a8DGCtB9R+j5j3UO/iL0+3'+ sLineBreak +
                '-----END RSA PRIVATE KEY-----' ;

{    **** IMPORTANTE ****
    Por motivos de segurança, GERE A SUA PROPRIA CHAVE e informe-a em:
     "OnGetChavePrivada" }

type
  TACBrEADDgst = (dgstMD2, dgstMD4, dgstMD5, dgstRMD160, dgstSHA, dgstSHA1) ;

  TACBrEADCalc = procedure(Arquivo: String) of object ;
  TACBrEADGetChave = procedure(var Chave: AnsiString) of object ;

  { TACBrEAD }

  TACBrEAD = class(TComponent)
  private
    fsOnGetChavePrivada: TACBrEADGetChave;
    fsOnGetChavePublica : TACBrEADGetChave ;

    fsInicializado : Boolean ;

    fsKey : pEVP_PKEY ;

    function GetOpenSSL_Version: String;
    procedure InitOpenSSL ;
    procedure FreeOpenSSL ;

    procedure LerChavePrivada ;
    procedure LerChavePublica ;
    procedure LerChave(Chave : AnsiString; Privada: Boolean) ;
    procedure LiberarChave ;

    function CriarMemBIO: pBIO ;
    procedure LiberarBIO( Bio : pBIO);

    function BioToStr( ABio : pBIO) : String ;

    function GetAbout: String;

    procedure VerificaNomeArquivo( NomeArquivo : String ) ;
  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy  ; override;

    Procedure GerarChaves( var AChavePublica : AnsiString;
       var AChavePrivada : AnsiString ) ;

    function AssinarArquivoComEAD( const NomeArquivo: String) : AnsiString ;

    function VerificarEADArquivo( const NomeArquivo: String): Boolean ; overload ;
    function VerificarEAD( const AString : AnsiString): Boolean ; overload ;
    function VerificarEAD( const AStringList : TStringList): Boolean ; overload ;
    function VerificarEAD( const MS : TMemoryStream; EAD: AnsiString):
       Boolean ; overload ;

    Function GerarXMLeECFc( const NomeSwHouse, Diretorio : String ) : Boolean ;
    Procedure CalcularModuloeExpoente( var Modulo, Expoente : AnsiString );
    Function CalcularChavePublica : AnsiString ;

    function CalcularHashArquivo( const NomeArquivo: String;
       const Digest: TACBrEADDgst ): AnsiString ; overload ;
    function CalcularHash( const AString : AnsiString;
       const Digest: TACBrEADDgst ): AnsiString ; overload ;
    function CalcularHash( const AStringList : TStringList;
       const Digest: TACBrEADDgst ): AnsiString ; overload ;
    function CalcularHash( const MS : TMemoryStream;
       const Digest: TACBrEADDgst ): AnsiString ; overload ;

    function CalcularEADArquivo( const NomeArquivo: String): AnsiString ; overload ;
    function CalcularEAD( const AString : AnsiString): AnsiString ; overload ;
    function CalcularEAD( const AStringList : TStringList): AnsiString ; overload ;
    function CalcularEAD( const MS : TMemoryStream): AnsiString ; overload ;

    property OpenSSL_Version : String read GetOpenSSL_Version ;

    function MD5FromFile(const APathArquivo: String): String;
    function MD5FromString(const AString: String): String;
  published
    property About: String read GetAbout stored False;

    property OnGetChavePrivada: TACBrEADGetChave read fsOnGetChavePrivada
       write fsOnGetChavePrivada;
    property OnGetChavePublica: TACBrEADGetChave read fsOnGetChavePublica
       write fsOnGetChavePublica;
  end;

implementation


function TACBrEAD.MD5FromFile(const APathArquivo: String): String;
begin
  Result := CalcularHashArquivo(APathArquivo, dgstMD5);
end;

function TACBrEAD.MD5FromString(const AString: String): String;
begin
  Result := CalcularHash(AString, dgstMD5);
end;

{ ------------------------------ TACBrEAD ------------------------------ }

function TACBrEAD.GetAbout: String;
begin
   Result := 'ACBrEAD Ver: ' + CACBrEAD_Versao;
end;

constructor TACBrEAD.Create(AOwner : TComponent) ;
begin
   inherited Create(AOwner) ;

   fsInicializado := False ;

   fsOnGetChavePrivada := nil;
   fsOnGetChavePublica := nil;
end ;

destructor TACBrEAD.Destroy ;
begin
   FreeOpenSSL;

   inherited Destroy ;
end ;

procedure TACBrEAD.InitOpenSSL;
begin
  if fsInicializado then
     exit ;

  OpenSSL_add_all_algorithms;
  OpenSSL_add_all_ciphers;
  OpenSSL_add_all_digests;
  ERR_load_crypto_strings;

  fsInicializado := True;
end;

function TACBrEAD.GetOpenSSL_Version: String;
Var
  SSLInfo : Integer ;
begin
   Result := SSLeay_version( 0 );
end;

procedure TACBrEAD.FreeOpenSSL;
begin
  LiberarChave;
  {$IFDEF USE_libeay32}
   EVP_cleanup();
  {$ELSE}
   EVPcleanup();
  {$ENDIF}
end;

Function TACBrEAD.BioToStr( ABio: pBIO) : String ;
Var
  {$IFDEF USE_libeay32}
   Buf : array [0..1023] of AnsiChar;
  {$ENDIF}
  Lin : AnsiString ;
  Ret : Integer ;
begin
  Result := '';

  {$IFDEF USE_libeay32}
   while BIO_eof( ABio ) = 0 do
   begin
     BIO_gets( ABio, Buf, 1024 );
     Lin := StrPas( Buf );
     Result := Result + Lin;
   end ;
  {$ELSE}
   repeat
      SetLength(Lin,1024);
      Ret := BioRead( ABio, Lin, 1024);
      if Ret > 0 then
      begin
         Lin := copy(Lin,1,Ret) ;
         Result := Result + Lin;
      end ;
   until (Ret <= 0);
  {$ENDIF}
end ;

procedure TACBrEAD.GerarChaves( var AChavePublica : AnsiString;
  var AChavePrivada : AnsiString ) ;

  function FindFileSeed : String ;
  var
    TmpFile : TSearchRec ;
    TmpDir : String ;
  begin
    Result := '';
    TmpDir := GetEnvironmentVariable('TEMP');
    if FindFirst(TmpDir + '\*', faReadOnly and faHidden and faSysFile and faArchive, TmpFile) = 0 then
       Result := TmpFile.Name
    else
       if FindFirst(ExtractFileDir(ParamStr(0)) + '*', faReadOnly and faHidden and faSysFile and faArchive, TmpFile) = 0 then
          Result := TmpFile.Name ;

    FindClose(TmpFile);
  end ;

Var
  FileSeed : String ;
  BioKey : pBIO;
  RSAKey : pRSA ;
begin
  InitOpenSSL;

  AChavePublica := '';
  AChavePrivada := '';

  // Load a pseudo random file
  FileSeed := FindFileSeed;
  RAND_load_file(PAnsiChar(FileSeed), -1);

  // Gera a Chave RSA
  LiberarChave;
  {$IFDEF USE_libeay32}
   RSAKey := RSA_generate_key( 1024, RSA_F4, nil, nil);
  {$ELSE}
   RSAKey := RsaGenerateKey( 1024, RSA_F4, nil, nil);
  {$ENDIF}
  if RSAKey = nil then
     raise Exception.Create( 'Erro ao gerar par de Chaves RSA');

  // Lendo Conteudo da Chave
  BioKey := CriarMemBIO;
  try
     PEM_write_bio_RSAPrivateKey(BioKey, RSAKey, nil, nil, 0, nil, nil);
     AChavePrivada := BioToStr( BioKey );

     LerChave( AChavePrivada, True );

     BIO_reset( BioKey );
     PEM_write_bio_PUBKEY( BioKey, fsKey);
     AChavePublica := BioToStr( BioKey );
  finally
     LiberarBIO( BioKey );
  end ;
end ;

procedure TACBrEAD.LerChavePrivada ;
var
  Chave : AnsiString ;
begin
  Chave := '';
  if Assigned( fsOnGetChavePrivada ) then
     fsOnGetChavePrivada( Chave ) ;

  if Chave = '' then
     Chave := cRFDRSAKey;
     //raise Exception.Create( ACBrStr('Chave RSA Privada não especificada no evento: "OnGetChavePrivada"') ) ;

  LerChave(Chave, True) ;
end ;

procedure TACBrEAD.LerChavePublica ;
var
  Chave : AnsiString ;
begin
  Chave := '';
  if Assigned( fsOnGetChavePublica ) then
    fsOnGetChavePublica( Chave ) ;

  if Chave = '' then
    raise Exception.Create( ACBrStr('Chave RSA Publica não especificada no evento: "OnGetChavePublica"') ) ;

  LerChave(Chave, False) ;
end ;

procedure TACBrEAD.LerChave(Chave : AnsiString; Privada: Boolean) ;
var
   A : pEVP_PKEY ;
   BioKey : pBIO ;
begin
   InitOpenSSL ;

 if (sLineBreak <> #10) then
     Chave := StringReplace(Chave, sLineBreak, #10, [rfReplaceAll] );

   LiberarChave ;

   BioKey := BIO_new_mem_buf( PChar(Chave), Length(Chave) + 1 ) ;
   try
      A := nil ;
      if Privada then
         fsKey := PEM_read_bio_PrivateKey( BioKey, {$IFDEF USE_libeay32}A{$ELSE}nil{$ENDIF}, nil, nil)
      else
         fsKey := PEM_read_bio_PUBKEY( BioKey, A, nil, nil) ;
   finally
      LiberarBIO( BioKey );
   end ;

   if fsKey = nil then
      raise Exception.Create('Erro ao ler a Chave');
end ;

procedure TACBrEAD.LiberarChave ;
begin
  if fsKey <> Nil then
  begin
     EVP_PKEY_free( fsKey );
     fsKey := nil;
  end ;
end ;

function TACBrEAD.CriarMemBIO : pBIO ;
begin
  {$IFDEF USE_libeay32}
   Result := Bio_New(Bio_S_Mem());
  {$ELSE}
   Result := BioNew(BioSMem());
  {$ENDIF}
end ;

procedure TACBrEAD.LiberarBIO( Bio : pBIO);
begin
  {$IFDEF USE_libeay32}
   BIO_free_all( Bio );
  {$ELSE}
   BioFreeAll( Bio );
  {$ENDIF}
end ;

function TACBrEAD.GerarXMLeECFc( const NomeSwHouse, Diretorio : String ) : Boolean ;
Var
  Modulo, Expoente : AnsiString ;
  SL : TStringList ;
begin
  Modulo   := '';
  Expoente := '';
  CalcularModuloeExpoente( Modulo, Expoente );

  SL := TStringList.Create;
  try
    SL.Add( '<?xml version="1.0"?>' ) ;
    SL.Add( '<empresa_desenvolvedora>' ) ;
    SL.Add( '  <nome>'+NomeSwHouse+'</nome>' ) ;
    SL.Add( '  <chave>' ) ;
    SL.Add( '    <modulo>'+Modulo+'</modulo>' ) ;
    SL.Add( '    <expoente_publico>'+Expoente+'</expoente_publico>' ) ;
    SL.Add( '  </chave>' );
    SL.Add( '</empresa_desenvolvedora>' ) ;

    try
       SL.SaveToFile( PathWithDelim(Diretorio)+NomeSwHouse+'.xml' );
       Result := True;
    except
       Result := False;
    end ;
  finally
     SL.Free;
  end ;
end ;

Procedure TACBrEAD.CalcularModuloeExpoente( var Modulo, Expoente : AnsiString );
Var
  Bio : pBIO;
  Ver : String ;
begin
  Ver := OpenSSL_Version;
  if pos('1.0',Ver) > 0 then
     raise Exception.Create( ACBrStr('Método CalcularModuloeExpoente ainda não é '+
                                     'compatível com OpenSSL 1.0.0 ou superior'));

  LerChavePrivada();

  Modulo   := '';
  Expoente := '';
  Bio := CriarMemBIO;
  try
    BN_print( Bio , fsKey.pkey.rsa.e);
    Modulo := BioToStr( Bio );

    BIO_reset( Bio );
    BN_print( Bio , fsKey.pkey.rsa.d);
    Expoente := BioToStr( Bio );
  finally
    LiberarBIO( Bio ) ;
    LiberarChave;
  end ;
end ;

function TACBrEAD.CalcularChavePublica : AnsiString ;
Var
  Bio : pBIO;
begin
  LerChavePrivada();

  Result := '';
  Bio    := CriarMemBIO;
  try
    if PEM_write_bio_PUBKEY( Bio, fsKey) = 1 then
       Result := BioToStr( Bio );
  finally
    LiberarBIO( Bio );
    LiberarChave;
  end ;
end ;

function TACBrEAD.CalcularHashArquivo(const NomeArquivo : String;
   const Digest: TACBrEADDgst) : AnsiString ;
Var
   MS : TMemoryStream ;
begin
  VerificaNomeArquivo( NomeArquivo );

  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile( NomeArquivo );
    Result := CalcularHash( MS, Digest );
  finally
    MS.Free ;
  end ;
end ;

function TACBrEAD.CalcularHash(const AString : AnsiString;
   const Digest: TACBrEADDgst) : AnsiString ;
Var
   MS : TMemoryStream ;
begin
  MS := TMemoryStream.Create;
  try
    MS.Write( Pointer(AString)^, Length(AString) );
    Result := CalcularHash( MS, Digest );
  finally
    MS.Free ;
  end ;
end ;

function TACBrEAD.CalcularHash(const AStringList : TStringList;
   const Digest: TACBrEADDgst) : AnsiString ;
Var
  MS : TMemoryStream ;
begin
  MS := TMemoryStream.Create;
  try
    AStringList.SaveToStream( MS );
    Result := CalcularHash( MS, Digest );
  finally
    MS.Free ;
  end ;
end ;

function TACBrEAD.CalcularHash(const MS : TMemoryStream;
   const Digest: TACBrEADDgst) : AnsiString ;
Var
  md : PEVP_MD ;
  md_len: cardinal;
  md_ctx: EVP_MD_CTX;
  md_value_bin : array [0..EVP_MAX_MD_SIZE] of char;
  md_value_hex : array [0..1023] of char;
  NameDgst : PAnsiChar;
begin
  InitOpenSSL ;
  Result   := '';
  NameDgst := '';

  case Digest of
    dgstMD2    : NameDgst := 'md2';
    dgstMD4    : NameDgst := 'md4';
    dgstMD5    : NameDgst := 'md5';
    dgstRMD160 : NameDgst := 'rmd160';
    dgstSHA    : NameDgst := 'sha';
    dgstSHA1   : NameDgst := 'sha1';
 end ;

  MS.Position := 0;
  md := EVP_get_digestbyname( NameDgst );
  EVP_DigestInit( @md_ctx, md );
  EVP_DigestUpdate( @md_ctx, MS.Memory, MS.Size );
  EVP_DigestFinal( @md_ctx, @md_value_bin, {$IFNDEF USE_libeay32}@{$ENDIF}md_len);

  BinToHex( md_value_bin, md_value_hex, md_len);
  md_value_hex[2 * md_len] := #0;
  Result := StrPas(md_value_hex);
end ;

function TACBrEAD.CalcularEADArquivo(const NomeArquivo : String) : AnsiString ;
Var
   MS : TMemoryStream ;
begin
  VerificaNomeArquivo( NomeArquivo );

  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile( NomeArquivo );
    Result := CalcularEAD( MS );
  finally
    MS.Free ;
  end ;
end ;

function TACBrEAD.CalcularEAD(const AString : AnsiString) : AnsiString ;
Var
   MS : TMemoryStream ;
begin
  MS := TMemoryStream.Create;
  try
    MS.Write( Pointer(AString)^, Length(AString) );
    Result := CalcularEAD( MS );
  finally
    MS.Free ;
  end ;
end ;

function TACBrEAD.CalcularEAD(const AStringList : TStringList) : AnsiString ;
Var
   MS : TMemoryStream ;
begin
  MS := TMemoryStream.Create;
  try
    AStringList.SaveToStream( MS );
    Result := CalcularEAD( MS );
  finally
    MS.Free ;
  end ;
end ;

function TACBrEAD.CalcularEAD(const MS : TMemoryStream) : AnsiString ;
Var
  md : PEVP_MD ;
  md_len: cardinal;
  md_ctx: EVP_MD_CTX;
  md_value_bin : array [0..EVP_MAX_MD_SIZE] of char;
  md_value_hex : array [0..1023] of char;
begin
  Result := '';
  LerChavePrivada;

  try
    MS.Position := 0;
    md_len := 0;
    md := EVP_get_digestbyname('md5');
    EVP_DigestInit( @md_ctx, md ) ;
    EVP_DigestUpdate( @md_ctx, MS.Memory, MS.Size ) ;
    EVP_SignFinal( @md_ctx, @md_value_bin, md_len, fsKey);

    //MS.Clear;
    //MS.Write( md_value_bin, md_len );
    //MS.SaveToFile( 'sign.rsa' );

    BinToHex( md_value_bin, md_value_hex, md_len);
    md_value_hex[2 * md_len] := #0;
    Result := StrPas(md_value_hex);

  finally
     LiberarChave;
  end ;
end ;

procedure TACBrEAD.VerificaNomeArquivo( NomeArquivo : String ) ;
begin
  if ( Trim(NomeArquivo) = '' ) then
     raise Exception.Create( ACBrStr('Nome do arquivo não informado!') );

  if not FileExists( NomeArquivo ) then
     raise Exception.Create( ACBrStr('Arquivo: ' + NomeArquivo + ' não encontrado!') );
end ;


function TACBrEAD.AssinarArquivoComEAD( const NomeArquivo: String) : AnsiString ;
begin
  Result := CalcularEADArquivo( NomeArquivo );
  if Result <> '' then
     WriteToTXT( NomeArquivo, 'EAD' + Result, True, False );  // Compatiblidade Linux
end;

function TACBrEAD.VerificarEADArquivo(const NomeArquivo : String) : Boolean ;
Var
  SL : TStringList ;
begin
  VerificaNomeArquivo( NomeArquivo );

  SL := TStringList.Create;
  try
     SL.LoadFromFile( NomeArquivo );
     Result := VerificarEAD( SL );
  finally
     SL.Free;
  end ;
end ;

function TACBrEAD.VerificarEAD(const AString : AnsiString) : Boolean ;
Var
  SL : TStringList ;
begin
  SL := TStringList.Create;
  try
    SL.Text := AString;
    Result := VerificarEAD( SL );
  finally
    SL.Free ;
  end ;
end ;

function TACBrEAD.VerificarEAD(const AStringList : TStringList) : Boolean ;
Var
  MS : TMemoryStream ;
  EAD : AnsiString ;
  SLBottom : Integer ;
begin
  if AStringList.Count < 1 then
     raise Exception.Create( 'Conteudo Informado é vazio' );

  SLBottom := AStringList.Count-1;   // Pega a última linha do arquivo,
  EAD := AStringList[ SLBottom ] ;  // pois ela contem o EAD, e depois,
  AStringList.Delete( SLBottom );    // remove a linha do EAD

  MS := TMemoryStream.Create;
  try
    AStringList.SaveToStream( MS );
{   EAD2 := CalcularEAD( MS );

    if UpperCase(copy(EAD1,1,3)) = 'EAD' then
       EAD1 := copy(EAD1,4,Length(EAD1));

    if EAD1 = EAD2 then
       EAD1 := EAD2;

    MS.Position := 0;}
    Result := VerificarEAD( MS, EAD );
  finally
    MS.Free ;
  end ;
end ;

function TACBrEAD.VerificarEAD(const MS : TMemoryStream ; EAD : AnsiString
   ) : Boolean ;
Var
  md : PEVP_MD ;
  md_len: cardinal;
  md_ctx: EVP_MD_CTX;
  md_value_bin : array [0..128] of char;
  Ret : LongInt ;
begin
  Result := False;

  LerChavePublica;

  if UpperCase(copy(EAD,1,3)) = 'EAD' then
     EAD := copy(EAD,4,Length(EAD));

  if EAD = '' then
     raise Exception.Create( ACBrStr('Registro EAD não informado') );

  // Convertendo o EAD para binário //
  md_len := trunc(Length(EAD) / 2);
  if md_len <> 128 then
     raise Exception.Create('EAD deve conter 256 caracteres');

  HexToBin( PAnsiChar(EAD), md_value_bin, md_len );

  try
    MS.Position := 0;
    Ret := -1 ;
    md := EVP_get_digestbyname('md5');
    EVP_DigestInit( @md_ctx, md ) ;
    EVP_DigestUpdate( @md_ctx, MS.Memory, MS.Size ) ;
    Ret := EVP_VerifyFinal( @md_ctx, @md_value_bin, md_len, fsKey) ;

    Result := (Ret = 1);
  finally
     LiberarChave;
  end ;
end ;

end.

