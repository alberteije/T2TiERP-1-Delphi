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
{  Algumas funçoes dessa Unit foram extraidas de outras Bibliotecas, veja no   }
{ cabeçalho das Funçoes no código abaixo a origem das informaçoes, e autores...}
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
|* 30/06/2004:  Daniel Simoes de Almeida
|*   Funçoes auxiliares separadas do código do componentes
|* 19/12/2004:  Daniel Simoes de Almeida
|*   Adcionada a procedure DeleteFiles e a Funçao CopyFileTo
|* 15/07/2005:  Daniel Simoes de Almeida
|*   Rotina TiraAcentos() modificada para permitir os chars #13 e #10
|* 09/12/2005:  Daniel Simoes de Almeida
|*   Funções StringToAsc e AscToSTring movidas de ACBrECFNaoFiscal.pas para
|*   ACBrUtil.pas
|* 09/12/2005:  Daniel Simoes de Almeida
|*   Adicionada função FunctionDetect (LibName, FuncName: String;
|*                                    var LibPointer: Pointer): boolean;
|*   Funções InPort e OutPort agora suportam a DLL inpout32.dll, que permite
|*   acesso direto a portas no XP /NT / 98  http://www.logix4u.net/inpout32.htm
|* 05/03/2006:  Daniel Simoes de Almeida
|* +  StringToDateTime( DateTimeString : String ) : TDateTime ;
|* +  StringToDateTimeDef( DateTimeString : String ; DefaultValue : TDateTime )
|*         : TDateTime ;
|* 23/05/2006:  Daniel Simoes de Almeida
|*   - Adicionada a função:  PosLast(const SubStr, S: string): Integer;
|*     que retorna a última posição de SubStr dentro da String S, ou 0 se não
|*     encontrar a SubStr dentro de S
|* 27/06/2006:  Daniel Simoes de Almeida
|*   - Adicionada as funções: BinToInt e IntToBin (http://delphi.about.com)
|*   - Modificada TestBit para permitir Inteiros de 16 bits
|* 03/10/2006:  Daniel Simoes de Almeida
|*   - Corrigido pequeno Bug na função TruncFix.
|* 21/10/2006:  Daniel Simoes de Almeida
|*   - Adicionada a função  PathWithDelim( APath : String ) : String ;
|* 08/11/2006:  Daniel Simoes de Almeida
|*   - Adicionada a função  DesligarMaquina(Reboot: Boolean = False) ;
|* 03/01/2007:  Nei José Van Lare Junior
|*   - Adicionada a função function RemoveString(sSubstr, sString: string):string;
|* 08/11/2006:  Daniel Simoes de Almeida
|*   - Declaraçoes de Funçoes revistas para maior desempenho (usando const)
|* 04/10/2006:  Rodrigo Fruhwirth
|*   - Corrigida BCDToAsc, quando valores não numericos
|* 01/11/2007:  Daniel Simoes de Almeida
|*   - Adiconada as funções HexToAscii e AsciiToHex ;
|* 20/06/2008:  Daniel Simoes de Almeida
|*   - Função IntToStrZero modificada para aceitar Int64
|* 24/09/2009:  Daniel Simoes de Almeida
|*   + function BinaryStringToString(AString: AnsiString): AnsiString;
|*   + function StringToBinaryString(AString: AnsiString): AnsiString;
******************************************************************************}

{$I ACBr.inc}

{$IFDEF FPC}
 {$IFNDEF CONSOLE}
  {$DEFINE USE_LCLIntf}

  {$IFDEF LINUX}
   {$DEFINE USE_LConvEncoding}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

unit ACBrUtil;

interface
Uses SysUtils, Math, Classes
    {$IFDEF COMPILER6_UP} ,StrUtils, DateUtils {$ELSE} ,ACBrD5, FileCtrl {$ENDIF}
    {$IFDEF FPC}
      ,dynlibs
      {$IFDEF USE_LConvEncoding} ,LConvEncoding {$ENDIF}
      {$IFDEF USE_LCLIntf} ,LCLIntf {$ENDIF}
    {$ENDIF}
    {$IFDEF MSWINDOWS}
      ,Windows, ShellAPI
    {$else}
      {$IFNDEF FPC}
        ,Libc
      {$else}
        ,unix, BaseUnix
      {$endif}
    {$endif} ;

function ACBrStr( AString : AnsiString ) : String ;
function ACBrStrToAnsi( AString : String ) : AnsiString ;
function TruncFix( X : Double ) : Integer ;

function TestBit(const Value: Integer; const Bit: Byte): Boolean;
function IntToBin (value: LongInt; digits: integer ): string;
function BinToInt(Value: String): LongInt;

Function BcdToAsc( const StrBCD : AnsiString) : AnsiString ;
Function AscToBcd( const ANumStr: AnsiString ; const TamanhoBCD : Byte) : AnsiString ;

Function HexToAscii(const HexStr : AnsiString) : AnsiString ;
Function AsciiToHex(const ABinaryString: AnsiString): String;

function BinaryStringToString(const AString: AnsiString): AnsiString;
function StringToBinaryString(const AString: AnsiString): AnsiString;

function padL(const AString : AnsiString; const nLen : Integer;
   const Caracter : AnsiChar = ' ') : AnsiString;
function padR(const AString : AnsiString; const nLen : Integer;
   const Caracter : AnsiChar = ' ') : AnsiString;
function padC(const AString : AnsiString; const nLen : Integer;
   const Caracter : AnsiChar = ' ') : AnsiString;
function padS(const AString : AnsiString; const nLen : Integer; Separador : String;
   const Caracter : AnsiChar = ' ') : AnsiString ;
function RemoveString(const sSubStr, sString: AnsiString): AnsiString;
function RemoveStrings(const AText: AnsiString; StringsToRemove: array of AnsiString): AnsiString;
function StripHTML(const AHTMLString : AnsiString) : AnsiString;
function RandomName(const LenName : Integer = 8) : String ;

{ PosEx, retirada de StrUtils.pas do D7, para compatibilizar com o Delphi 6
  (que nao possui essa funçao) }
{$IFNDEF COMPILER7_UP}
function PosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
{$ENDIF}

{$IFNDEF COMPILER6_UP}
  type TRoundToRange = -37..37;
  function RoundTo(const AValue: Double; const ADigit: TRoundToRange): Double;
  function SimpleRoundTo(const AValue: Double; const ADigit: TRoundToRange = -2): Double;

  { IfThens retirada de Math.pas do D7, para compatibilizar com o Delphi 5
  (que nao possue essas funçao) }
  function IfThen(AValue: Boolean; const ATrue: Integer; const AFalse: Integer = 0): Integer; overload;
  function IfThen(AValue: Boolean; const ATrue: Int64; const AFalse: Int64 = 0): Int64; overload;
  function IfThen(AValue: Boolean; const ATrue: Double; const AFalse: Double = 0.0): Double; overload;

  { IfThens retirada de StrUtils.pas do D7, para compatibilizar com o Delphi 5
  (que nao possue essas funçao) }
  function IfThen(AValue: Boolean; const ATrue: string;
    AFalse: string = ''): string; overload;
{$endif}

function PosAt(const SubStr, S: AnsiString; Ocorrencia : Cardinal = 1): Integer;
function PosLast(const SubStr, S: AnsiString): Integer;
function CountStr(const AString, SubStr : AnsiString ) : Integer ;
Function Poem_Zeros(const Texto : AnsiString; const Tamanho : Integer) : AnsiString;
Function IntToStrZero(const NumInteiro : Int64; Tamanho : Integer) : AnsiString;

Function StringToFloat( NumString : String ) : Double ;
Function StringToFloatDef( const NumString : String ;
   const DefaultValue : Double ) : Double ;
Function StringToDateTime( const DateTimeString : String;
   const Format : String = '') : TDateTime ;
Function StringToDateTimeDef( const DateTimeString : String ;
   const DefaultValue : TDateTime; const Format : String = '') : TDateTime ;

function StoD( YYYYMMDDhhnnss: String) : TDateTime;
function DtoS( ADate : TDateTime) : String;
function DTtoS( ADateTime : TDateTime) : String;

function StrIsAlpha(const S: AnsiString): Boolean;
function StrIsAlphaNum(const S: AnsiString): Boolean;
function StrIsNumber(const S: AnsiString): Boolean;
function CharIsAlpha(const C: AnsiChar): Boolean;
function CharIsAlphaNum(const C: AnsiChar): Boolean;
function CharIsNum(const C: AnsiChar): Boolean;
function OnlyNumber(const AValue: AnsiString): String;
function OnlyAlpha(const AValue: AnsiString): String;
function OnlyAlphaNum(const AValue: AnsiString): String;
function StrIsIP(const AValue: string): Boolean;

function TiraAcentos( const AString : String ) : String ;
function TiraAcento( const AChar : AnsiChar ) : AnsiChar ;
function AjustaLinhas(Texto: AnsiString; Colunas: Integer ;
   NumMaxLinhas: Integer = 0; PadLinhas: Boolean = False): AnsiString;
function QuebraLinhas(const Texto: String; const Colunas: Integer;
   const CaracterQuebrar : Char = ' '): String;
function TraduzComando( AString : AnsiString ) : AnsiString ;
Function StringToAsc( AString : AnsiString ) : AnsiString ;
Function AscToString( AString : AnsiString ) : AnsiString ;

function InPort(const PortAddr:word): byte;
procedure OutPort(const PortAddr: word; const Databyte: byte); overload ;

function StrCrypt(const AString, StrChave: AnsiString): AnsiString;
function SomaAscII(const AString : AnsiString): Integer;
function StringCrc16(AString : AnsiString ) : word;

Procedure FindFiles( const FileMask : String; AStringList : TStrings;
  IncludePath : Boolean = True ) ;
Function FilesExists(const FileMask: String) : Boolean ;
Procedure DeleteFiles(const FileMask: String; RaiseExceptionOnFail : Boolean = True)  ;
Procedure TryDeleteFile(const AFile: String; WaitTime: Integer = 100)  ;
function CopyFileTo(const AFromFileName, AToFileName : String;
   const AFailIfExists : Boolean = false) : Boolean;
Function PathWithDelim( const APath : String ) : String ;
Function PathWithoutDelim( const APath : String ) : String ;
Procedure CopyFilesToDir( FileMask : String ; ToDirName : String;
   const ForceDirectory : Boolean = False)  ;
procedure RunCommand(Command: String; Params: String = ''; Wait : Boolean = false;
   WindowState : Word = 5);
procedure OpenURL( const URL : String ) ;

function FunctionDetect (LibName, FuncName: String; var LibPointer: Pointer)
 : boolean; overload ;
function FunctionDetect (LibName, FuncName: String; var LibPointer: Pointer;
   var LibHandle: THandle ): boolean; overload ;

function FlushToDisk( sFile: string): boolean;

Procedure DesligarMaquina(Reboot: Boolean = False; Forcar: Boolean = False) ;
Procedure WriteToTXT( const ArqTXT, AString : AnsiString;
   const AppendIfExists : Boolean = True; AddLineBreak : Boolean = True );

//funcoes para uso com o modulo ACBrSintegra
function TiraPontos(Str: string): string;
function TBStrZero(const i: string; const Casas: byte): string;
function Space(Tamanho: Integer): string;
function LinhaSimples(Tamanho: Integer): string;
function LinhaDupla(Tamanho: Integer): string;

function EAN13Valido( CodEAN13 : String ) : Boolean ;
function EAN13_DV( CodEAN13 : String ) : String ;

function TranslateString(const S: AnsiString; CP_Destino: Word; CP_Atual: Word = 0): AnsiString;
function MatchText(const AText: AnsiString; const AValues: array of AnsiString): Boolean;

{$IFDEF MSWINDOWS}
var xInp32 : function (wAddr: word): byte; stdcall;
var xOut32 : function (wAddr: word; bOut: byte): byte; stdcall;
var xBlockInput : function (Block: BOOL): BOOL; stdcall;
{$ENDIF}

implementation
var Randomized : Boolean ;

{-----------------------------------------------------------------------------
  Todos os Fontes do ACBr usam Encoding CP1252, para manter compatibilidade com
  D5 a D2007, Porém D2009 e superiores e Lazarus 0.9.27 e acima usam UTF8.
  A função abaixo converte a AString para de ANSI, para UTF8, apenas se o
  Compilador usar UNICODE
 -----------------------------------------------------------------------------}
function ACBrStr( AString : AnsiString ) : String ;
begin
{$IFDEF UNICODE}
 {$IFDEF USE_LConvEncoding}
   Result := CP1252ToUTF8( AString ) ;
 {$ELSE}
   Result := AnsiToUtf8( AString ) ;
 {$ENDIF}
{$ELSE}
  Result := AString
{$ENDIF}
end ;

{-----------------------------------------------------------------------------
  Converte a AString de UTF8 para ANSI nativo, apenas se o Compilador usar UNICODE
 -----------------------------------------------------------------------------}
function ACBrStrToAnsi(AString: String): AnsiString;
begin
{$IFDEF UNICODE}
 {$IFDEF USE_LConvEncoding}
   Result := UTF8ToCP1252( AString ) ;
 {$ELSE}
   {$IFDEF FPC}
    Result := Utf8ToAnsi( AString ) ;
   {$ELSE}
    Result := AnsiString( AString ) ;
   {$ENDIF}
 {$ENDIF}
{$ELSE}
  Result := AString
{$ENDIF}
end;

{-----------------------------------------------------------------------------
 Corrige, bug da função Trunc.
 Deve calcular Trunc somente com variaveis e nunca com Expressoes, caso contrá-
 rio o resultado pode não ser o esperado.
 // Valores de Teste: Trunc(1,602 x 0,98) | 5 * 12,991 | 2,09 * 23,5
 -----------------------------------------------------------------------------}
function TruncFix( X : Double ) : Integer ;
begin
  Result := Trunc( SimpleRoundTo( X, -9) ) ;
end ;

{-----------------------------------------------------------------------------
 *** Adaptado de JclLogic.pas  - Project JEDI Code Library (JCL) ***
 Retorna True se o nBit está ativo (ligado) dentro do valor Value. Inicia em 0
 ---------------------------------------------------------------------------- }
function TestBit(const Value: Integer; const Bit: Byte): Boolean;
Var Base : Byte ;
begin
  Base := (Trunc(Bit/8)+1) * 8 ;
  Result := (Value and (1 shl (Bit mod Base))) <> 0;
end;

{-----------------------------------------------------------------------------
 Extraido de  http://delphi.about.com/od/mathematics/a/baseconvert.htm (Zago)
 Converte um Inteiro para uma string com a representação em Binário
 -----------------------------------------------------------------------------}
function IntToBin ( value: LongInt; digits: integer ): string;
begin
    Result := StringOfChar ( '0', digits ) ;
    while value > 0 do
    begin
      if ( value and 1 ) = 1 then
        result [ digits ] := '1';
      dec ( digits ) ;
      value := value shr 1;
    end;
end;

{-----------------------------------------------------------------------------
 Extraido de  http://delphi.about.com/od/mathematics/a/baseconvert.htm (Zago)
 converte uma String com a representação de Binário para um Inteiro
 -----------------------------------------------------------------------------}
function BinToInt(Value: String): LongInt;
var i: Integer;
begin
  Result := 0;
  
//remove leading zeroes
  while Copy(Value,1,1)='0' do
     Value := Copy(Value,2,Length(Value)-1) ;

//do the conversion
  for i:=Length(Value) downto 1 do
     if Copy(Value,i,1)='1' then
        Result:=Result+(1 shl (i-1)) ;
end;

{-----------------------------------------------------------------------------
  Converte uma String no Formato BCD para uma String que pode ser convertida em
  Integer ou Double.  // Adaptada do manual da Bematech //   Exemplo:
  - Se uma variável retornada for de 7 bytes BCD, e seu valor for R$ 1234,56 os
    7 bytes retornados em caracter (14 dígitos BCD) serão:  00 00 00 00 12 34 56.
    ou chr(00) + chr(00) + chr(00) + chr(00) + chr(12) + chr(34) + chr(56).
    Nesse caso essa função irá retornar:  "00000000123456"
 ---------------------------------------------------------------------------- }
function BcdToAsc(const StrBCD: AnsiString): AnsiString;
Var A,BCD_CHAR : Integer ;
    BH,BL,ASC_CHAR : AnsiString ;
begin
  result := '' ;

  for A := 1 to Length( StrBCD ) do
  begin
     BCD_CHAR := ord( StrBCD[A] ) ;
     BH := IntToStr( Trunc(BCD_CHAR / 16) ) ;
     If ( BCD_CHAR mod 16 ) > 9 Then        // Corrigido por Rodrigo Fruhwirth
        BL := AnsiChar( chr( 48 + BCD_CHAR mod 16 ) )
     Else
        BL := IntToStr( BCD_CHAR mod 16 ) ;

     ASC_CHAR := BH + BL ;
     Result := Result + ASC_CHAR
  end ;
end;

{-----------------------------------------------------------------------------
  Converte uma String com Numeros para uma String no Formato BCD
  - TamanhoBCD define quantos bytes a String Resultante deve ter
  - Para transformar o valor for  "123456" em 7 bytes BCD, teriamos:
    00 00 00 00 12 34 56    ou
    chr(00) + chr(00) + chr(00) + chr(00) + chr(12) + chr(34) + chr(56).
 ---------------------------------------------------------------------------- }
Function AscToBcd( const ANumStr: AnsiString ; const TamanhoBCD : Byte) : AnsiString ;
  Var StrBCD : AnsiString ;
      I      : Integer ;
begin
  Result := '' ;

  if not StrIsNumber( ANumStr ) then
     raise Exception.Create('Parâmetro "ANumStr" deve conter apenas números') ;

  StrBCD := PadR( ANumStr, TamanhoBCD*2, '0' );
  For I := 1 to TamanhoBCD do
     Result := Result + AnsiChar( chr( StrToInt( copy(StrBCD, (I*2)-1, 2) ) ) ) ;
end ;


{-----------------------------------------------------------------------------
  Converte uma String em HexaDecimal <HexStr> pela sua representação em ASCII
  Ex: "C080" em Hexadecimal é igual a "+Ç" em ASCII que é igual a 49280 que é
      igual a "1100000010000000" em binário
      Portanto se HexStr = "CO80", Result = "+Ç"
 ---------------------------------------------------------------------------- }
Function HexToAscii(const HexStr: AnsiString) : AnsiString ;
Var
  B   : Byte ;
  Cmd : AnsiString ;
  I, L: Integer ;
begin
  Result := '' ;
  Cmd    := Trim(HexStr) ;
  I      := 1 ;
  L      := Length( HexStr ) ;

  while I < L do
  begin
     B := StrToIntDef('$'+copy(Cmd,I,2),32) ;
     Result := Result + AnsiChar( chr(B) ) ;
     Inc( I, 2) ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma String pela sua representação em HexaDecimal
  Ex: "C080" em Hexadecimal é igual a "+Ç" em ASCII que é igual a 49280 que é
      igual a "1100000010000000" em binário
      Portanto se AString = "+Ç", Result = "C080"
 ---------------------------------------------------------------------------- }
function AsciiToHex(const ABinaryString: AnsiString): String;
 Var I, L: Integer;
begin
  Result := '' ;
  L := Length(ABinaryString) ;
  for I := 1 to L do
     Result := Result + IntToHex(Ord(ABinaryString[I]), 2);
end;


{-----------------------------------------------------------------------------
  Completa <AString> com <Caracter> a direita, até o tamanho <nLen>, Alinhando
  a <AString> a Esquerda. Se <AString> for maior que <nLen>, ela será truncada
 ---------------------------------------------------------------------------- }
function padL(const AString : AnsiString; const nLen : Integer;
   const Caracter : AnsiChar) : AnsiString ;
var
  Tam: Integer;
begin
  Tam := Length(AString);
  if Tam < nLen then
    Result := AString + StringOfChar(Caracter, (nLen - Tam))
  else
    Result := copy(AString,1,nLen) ;
end ;

{-----------------------------------------------------------------------------
  Completa <AString> com <Caracter> a esquerda, até o tamanho <nLen>, Alinhando
  a <AString> a Direita. Se <AString> for maior que <nLen>, ela será truncada
 ---------------------------------------------------------------------------- }
function padR(const AString : AnsiString; const nLen : Integer;
   const Caracter : AnsiChar) : AnsiString ;
var
  Tam: Integer;
begin
  Tam := Length(AString);
  if Tam < nLen then
    Result := StringOfChar(Caracter, (nLen - Tam)) + AString
  else
    Result := copy(AString,1,nLen) ;
end ;

{-----------------------------------------------------------------------------
 Completa <AString> Centralizando, preenchendo com <Caracter> a esquerda e direita
 ---------------------------------------------------------------------------- }
function padC(const AString : AnsiString; const nLen : Integer;
   const Caracter : AnsiChar) : AnsiString ;
var
  nCharLeft: Integer;
  Tam: integer;
begin
  Tam := Length( AString );
  if Tam < nLen then
  begin
    nCharLeft := Trunc( (nLen - Tam) / 2 ) ;
    Result    := padL( StringOfChar(Caracter, nCharLeft) + AString, nLen, Caracter) ;
  end
  else
    Result := copy(AString, 1, nLen) ;
end ;

{-----------------------------------------------------------------------------
  Ajusta a <AString> com o tamanho de <nLen> inserindo espaços no meio,
  substituindo <Separador> por n X <Caracter>  (Justificado)
 ---------------------------------------------------------------------------- }
function padS(const AString : AnsiString; const nLen : Integer;
   Separador : String; const Caracter : AnsiChar = ' ') : AnsiString ;
var StuffStr : AnsiString ;
    nSep, nCharSep, nResto, nFeito, Ini : Integer ;
    D : Double ;
begin
  Result := copy(AString,1,nLen) ;
  if Separador = Caracter then  { Troca Separador, senao fica em loop infinito }
  begin
     Result   := StringReplace( Result,Separador,#255,[rfReplaceAll]) ;
     Separador:= #255 ;
  end ;

  nSep   := CountStr( Result, Separador ) ;

  if nSep < 1 then
  begin
     Result := PadL(Result, nLen, Caracter ) ;
     exit ;
  end ;

  Result   := Trim( Result ) ;
  D        := (nLen - (Length(Result)-nSep)) / nSep ;
  nCharSep := Trunc( D ) ;
  nResto   := nLen - ( (Length(Result)-nSep) + (nCharSep*nSep) ) ;
  nFeito   := nSep ;
  StuffStr := StringOfChar( Caracter, nCharSep ) ;

  Ini := Pos( Separador, Result ) ;
  while Ini > 0 do
  begin
     Result := StuffString(Result, Ini, length(Separador),
                 StuffStr + ifthen(nFeito <= nResto, Caracter, '' ) );

     nFeito := nFeito - 1 ;
     Ini := Pos( Separador, Result ) ;
  end ;
end ;

{-----------------------------------------------------------------------------
   Remove todas ocorrencias do array <StringsToRemove> da String <AText>
   retornando a String alterada
 ---------------------------------------------------------------------------- }
function RemoveStrings(const AText: AnsiString;
  StringsToRemove: array of AnsiString): AnsiString;
Var
  I, J : Integer ;
  StrToFind : AnsiString ;
begin
  Result := AText ;
  { Verificando parâmetros de Entrada }
  if (AText = '') or (Length(StringsToRemove) = 0) then
     exit ;

  { Efetua um Sort no Array de acordo com o Tamanho das Substr a remover,
    para Pesquisar da Mais Larga a Mais Curta (Pois as Substr Mais Curtas podem
    estar contidas nas mais Largas) }
  For I := High( StringsToRemove ) downto Low( StringsToRemove )+1 do
     for j := Low( StringsToRemove ) to I-1 do
        if Length(StringsToRemove[J]) > Length(StringsToRemove[J+1]) then
        begin
           StrToFind := StringsToRemove[J];
           StringsToRemove[J] := StringsToRemove[J+1];
           StringsToRemove[J+1] := StrToFind;
        end;

  For I := High(StringsToRemove) downto Low(StringsToRemove) do
  begin
     StrToFind := StringsToRemove[I] ;
     J := Pos( StrToFind, Result ) ;
     while J > 0 do
     begin
        Delete( Result, J, Length( StrToFind ) ) ;
        J := PosEx( StrToFind, Result, J) ;
     end ;
  end ;
end ;

{-----------------------------------------------------------------------------
   Remove todas as TAGS de HTML de uma String, retornando a String alterada
 ---------------------------------------------------------------------------- }
function StripHTML(const AHTMLString : AnsiString) : AnsiString;
var
   PosIniTag, PosFimTag ,HTMLSize : Integer;
begin
   Result   := '' ;
   HTMLSize := Length( AHTMLString ) ;

   PosFimTag := 0 ;
   PosIniTag := Pos('<', AHTMLString) ;
   while PosIniTag > 0 do
   begin
      Result := Result + copy(AHTMLString, PosFimTag+1, (PosIniTag - PosFimTag-1 ) ) ;

      PosFimTag := PosEx( '>', AHTMLString, PosIniTag ) ;
      if PosFimTag = 0 then
         PosFimTag := PosIniTag-1
      else
         PosIniTag := PosEx( '<', AHTMLString, PosFimTag )
   end ;
   Result := Result + copy(AHTMLString, PosFimTag+1, HTMLSize ) ;

end;
{-----------------------------------------------------------------------------
   Remove todas ocorrencias <sSubStr> de <sString>, retornando a String alterada
 ---------------------------------------------------------------------------- }
function RemoveString(const sSubstr, sString: AnsiString): AnsiString;
begin
   Result := StringReplace( sString, sSubStr, '', [rfReplaceAll]) ;
end;

{-----------------------------------------------------------------------------
   Cria um Nome Aleatório (usado por exemplo, em arquivos temporários) 
 ---------------------------------------------------------------------------- }
function RandomName(const LenName : Integer ) : String ;
 Var I, N : Integer ;
     C : AnsiChar ;
begin
   if not Randomized then
   begin
      Randomize ;
      Randomized := True ;
   end ;
   
   Result := '' ;

   For I := 1 to LenName do
   begin
      N := Random( 25 ) ;
      C := AnsiChar( 65 + N ) ;

      Result := Result + C ;
   end ;
end ;

{-----------------------------------------------------------------------------
  Retorna quantas ocorrencias de <SubStr> existem em <AString>
 ---------------------------------------------------------------------------- }
function CountStr(const AString, SubStr : AnsiString ) : Integer ;
Var ini : Integer ;
begin
  result := 0 ;
  if SubStr = '' then exit ;

  ini := Pos( SubStr, AString ) ;
  while ini > 0 do
  begin
     Result := Result + 1 ;
     ini    := PosEx( SubStr, AString, ini + 1 ) ;
  end ;
end ;

{$IFNDEF COMPILER6_UP}
function RoundTo(const AValue: Double; const ADigit: TRoundToRange): Double;
var
  LFactor: Double;
begin
  LFactor := IntPower(10, ADigit);
  Result := Round(AValue / LFactor) * LFactor;
end;

function SimpleRoundTo(const AValue: Double; const ADigit: TRoundToRange = -2): Double;
var
  LFactor: Double;
begin
  LFactor := IntPower(10, ADigit);
  Result := Trunc((AValue / LFactor) + 0.5) * LFactor;
end;

function IfThen(AValue: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Int64; const AFalse: Int64): Int64;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Double; const AFalse: Double): Double;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: string;
  AFalse: string = ''): string;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

{$endif}

{$IFNDEF COMPILER7_UP}
{-----------------------------------------------------------------------------
 *** PosEx, retirada de StrUtils.pas do Borland Delphi ***
  para compatibilizar com o Delphi 6  (que nao possui essa funçao)
 ---------------------------------------------------------------------------- }
function PosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
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
{$endif}

{-----------------------------------------------------------------------------
  Acha a e-nesima "Ocorrencia" de "SubStr" em "S"
 ---------------------------------------------------------------------------- }
function PosAt(const SubStr, S: AnsiString; Ocorrencia : Cardinal = 1): Integer;
Var Count : Cardinal ;
begin
  Result := Pos( SubStr, S) ;
  Count  := 1 ;
  while (Count < Ocorrencia) and (Result > 0) do
  begin
     Result := PosEx( SubStr, S, Result+1) ;
     Count  := Count + 1 ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Acha a Ultima "Ocorrencia" de "SubStr" em "S"
 ---------------------------------------------------------------------------- }
function PosLast(const SubStr, S: AnsiString ): Integer;
Var P : Integer ;
begin
  Result := 0 ;
  P := Pos( SubStr, S) ;
  while P <> 0 do
  begin
     Result := P ;
     P := PosEx( SubStr, S, P+1) ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Insere ZEROS (0) a esquerda de <Texto> até completar <Tamanho> 
 ---------------------------------------------------------------------------- }
Function Poem_Zeros(const Texto : AnsiString; const Tamanho : Integer) : AnsiString;
begin
  Result := PadR(Trim(Texto),Tamanho,'0') ;
end ;

{-----------------------------------------------------------------------------
  Transforma <NumInteiro> em String, preenchendo com Zeros a Esquerda até
  atingiros digitos de <Tamnho>
 ---------------------------------------------------------------------------- }
Function IntToStrZero(const NumInteiro : Int64; Tamanho : Integer) : AnsiString;
begin
  Result := '' ;
  try
     Result := IntToStr( NumInteiro ) ;
     Result := Poem_Zeros( Result, Tamanho) ;
  except
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma <NumString> para Double, semelhante ao StrToFloatDef, mas
  verifica se a virgula é '.' ou ',' efetuando a conversão se necessário
  Se não for possivel converter, retorna <DefaultValue>
 ---------------------------------------------------------------------------- }
Function StringToFloatDef( const NumString : String ;
   const DefaultValue : Double ) : Double ;
begin
  try
     Result := StringToFloat( NumString ) ;
  except
     Result := DefaultValue ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma <NumString> para Double, semelhante ao StrToFloat, mas
  verifica se a virgula é '.' ou ',' efetuando a conversão se necessário
  Se não for possivel converter, retorna <DefaultValue>
 ---------------------------------------------------------------------------- }
Function StringToFloat( NumString : String ) : Double ;
begin
  NumString := Trim( NumString ) ;
  
  if DecimalSeparator <> '.' then
     NumString := StringReplace(NumString,'.',DecimalSeparator,[rfReplaceAll]) ;

  if DecimalSeparator <> ',' then
     NumString := StringReplace(NumString,',',DecimalSeparator,[rfReplaceAll]) ;

  Result := StrToFloat(NumString)
end ;

{-----------------------------------------------------------------------------
  Converte uma <DateTimeString> para TDateTime, semelhante ao StrToDateTimeDef,
  mas verifica se o seprador da Data é compativo com o S.O., efetuando a
  conversão se necessário. Se não for possivel converter, retorna <DefaultValue>
 ---------------------------------------------------------------------------- }
Function StringToDateTimeDef( const DateTimeString : String ;
   const DefaultValue : TDateTime; const Format : String = '' ) : TDateTime ;
begin
  try
     Result := StringToDateTime( DateTimeString, Format ) ;
  except
     Result := DefaultValue ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma <DateTimeString> para TDateTime, semelhante ao StrToDateTimeDef,
  mas verifica se o seprador da Data é compativo com o S.O., efetuando a
  conversão se necessário. Se não for possivel converter, retorna <DefaultValue>
 ---------------------------------------------------------------------------- }
Function StringToDateTime( const DateTimeString : String;
   const Format : String = '') : TDateTime ;
 Var
    OldShortDateFormat, AStr : String ;
begin
  OldShortDateFormat := ShortDateFormat ;
  try
     if Format <> '' then
        ShortDateFormat := Format ;

     AStr := Trim( StringReplace(DateTimeString,'/',DateSeparator, [rfReplaceAll])) ;
     AStr := StringReplace(AStr,':',TimeSeparator, [rfReplaceAll]) ;

     Result := StrToDateTime( AStr ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma String no formato YYYYMMDDhhnnss  para TDateTime
 ---------------------------------------------------------------------------- }
function StoD( YYYYMMDDhhnnss: String) : TDateTime;
  Var OldShortDateFormat : String ;
begin
  YYYYMMDDhhnnss := trim( YYYYMMDDhhnnss ) ;
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'yyyy/mm/dd' ;
     Result := StrToDateDef( copy(YYYYMMDDhhnnss, 1,4) + DateSeparator +
                             copy(YYYYMMDDhhnnss, 5,2) + DateSeparator +
                             copy(YYYYMMDDhhnnss, 7,2), 0 ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
  if Length( YYYYMMDDhhnnss ) > 8 then  { Informou Hora:minuto:segundos ? }
  begin
     Result := RecodeHour(  Result, StrToIntDef(copy(YYYYMMDDhhnnss, 9,2),0) ) ;
     Result := RecodeMinute(result, StrToIntDef(copy(YYYYMMDDhhnnss,11,2),0) ) ;
     Result := RecodeSecond(result, StrToIntDef(copy(YYYYMMDDhhnnss,13,2),0) ) ;
  end ;

end;

{-----------------------------------------------------------------------------
  Converte um TDateTime para uma String no formato YYYYMMDD
 ---------------------------------------------------------------------------- }
function DtoS( ADate : TDateTime) : String;
begin
  Result := FormatDateTime('yyyymmdd', ADate ) ;
end ;

{-----------------------------------------------------------------------------
  Converte um TDateTime para uma String no formato YYYYMMDDhhnnss
 ---------------------------------------------------------------------------- }
function DTtoS( ADateTime : TDateTime) : String;
begin
  Result := FormatDateTime('yyyymmddhhnnss', ADateTime ) ;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <S> contem apenas caracteres Alpha maiusculo/minuscula
 ---------------------------------------------------------------------------- }
function StrIsAlpha(const S: AnsiString): Boolean;
Var A : Integer ;
begin
  Result := true ;
  A      := 1 ;
  while Result and ( A <= Length( S ) )  do
  begin
     Result := CharIsAlpha( S[A] ) ;
     Inc(A) ;
  end;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <S> contem apenas caracteres Numericos.
  Retorna <False> se <S> for vazio
 ---------------------------------------------------------------------------- }
function StrIsNumber(const S: AnsiString): Boolean;
Var
  A, LenStr : Integer ;
begin
  LenStr := Length( S ) ;
  Result := (LenStr > 0) ;
  A      := 1 ;
  while Result and ( A <= LenStr )  do
  begin
     Result := CharIsNum( S[A] ) ;
     Inc(A) ;
  end;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <S> contem apenas caracteres Alpha maiusculo/minuscula
  ou Numericos
 ---------------------------------------------------------------------------- }
function StrIsAlphaNum(const S: AnsiString): Boolean;
Var
  A : Integer ;
begin
  Result := true ;
  A      := 1 ;
  while Result and ( A <= Length( S ) )  do
  begin
     Result := CharIsAlphaNum( S[A] ) ;
     Inc(A) ;
  end;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <C> é Alpha maiusculo/minusculo 
 ---------------------------------------------------------------------------- }
function CharIsAlpha(const C: AnsiChar): Boolean;
begin
  Result := ( C in ['A'..'Z','a'..'z'] ) ;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <C> é Númerico 
 ---------------------------------------------------------------------------- }
function CharIsNum(const C: AnsiChar): Boolean;
begin
  Result := ( C in ['0'..'9'] ) ;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <C> é Alpha maiusculo/minusculo ou Numerico
 ---------------------------------------------------------------------------- }
function CharIsAlphaNum(const C: AnsiChar): Boolean;
begin
  Result := ( CharIsAlpha( C ) or CharIsNum( C ) );
end ;

{-----------------------------------------------------------------------------
  Retorna uma String apenas com os char Numericos contidos em <Value>
 ---------------------------------------------------------------------------- }
function OnlyNumber(const AValue: AnsiString): String;
Var
  I : Integer ;
  LenValue : Integer;
begin
  Result   := '' ;
  LenValue := Length( AValue ) ;
  For I := 1 to LenValue  do
  begin
     if CharIsNum( AValue[I] ) then
        Result := Result + AValue[I] ;
  end;
end ;

{-----------------------------------------------------------------------------
  Retorna uma String apenas com os char Alpha contidos em <Value>
 ---------------------------------------------------------------------------- }
function OnlyAlpha(const AValue: AnsiString): String;
Var
  I : Integer ;
  LenValue : Integer;
begin
  Result := '' ;
  LenValue := Length( AValue ) ;
  For I := 1 to LenValue do
  begin
     if CharIsAlpha( AValue[I] ) then
        Result := Result + AValue[I] ;
  end;
end ;
{-----------------------------------------------------------------------------
  Retorna uma String apenas com os char Alpha-Numericos contidos em <Value>
 ---------------------------------------------------------------------------- }
function OnlyAlphaNum(const AValue: AnsiString): String;
Var
  I : Integer ;
  LenValue : Integer;
begin
  Result := '' ;
  LenValue := Length( AValue ) ;
  For I := 1 to LenValue do
  begin
     if CharIsAlphaNum( AValue[I] ) then
        Result := Result + AValue[I] ;
  end;
end ;

{-----------------------------------------------------------------------------
 ** Baseada em "IsIp" de synautil.pas - Synapse http://www.ararat.cz/synapse/ **
  Retorna <True> se <Value> é um IP Valido
 ---------------------------------------------------------------------------- }
function StrIsIP(const AValue: string): Boolean;
var
  TempIP : string;
  function ByteIsOk(const AValue: string): Boolean;
  var
    x: integer;
  begin
    x := StrToIntDef(AValue, -1);
    Result := (x >= 0) and (x < 256);
    // X may be in correct range, but value still may not be correct value!
    // i.e. "$80"
    if Result then
       Result := StrIsNumber( AValue ) ;
  end;

  function Fetch(var AValue: string; const Delimiter: string): string;
  var
    p : Integer ;
  begin
    p := pos(Delimiter,AValue) ;
    Result := copy(AValue, 1, p-1);
    AValue := copy(AValue, p+1, Length(AValue));
  end;
begin
  TempIP := AValue;
  Result := False;
  if not ByteIsOk(Fetch(TempIP, '.')) then
    Exit;
  if not ByteIsOk(Fetch(TempIP, '.')) then
    Exit;
  if not ByteIsOk(Fetch(TempIP, '.')) then
    Exit;
  if ByteIsOk(TempIP) then
    Result := True;
end;

{-----------------------------------------------------------------------------
  Substitui todos os caracteres acentuados por compativeis.  
 ---------------------------------------------------------------------------- }
function TiraAcentos( const AString : String ) : String ;
Var A : Integer ;
    Letra : AnsiChar ;
    AnsiStr, Ret : AnsiString ;
begin
  Result  := '' ;
  Ret     := '' ;
  AnsiStr := ACBrStrToAnsi( AString );
  For A := 1 to Length( AnsiStr ) do
  begin
     Letra := TiraAcento( AnsiStr[A] ) ;
     if not (Letra in [#32..#126,#13,#10,#8]) then    {Letras / numeros / pontos / sinais}
        Letra := ' ' ;
     Ret := Ret + Letra ;
  end ;

  Result := ACBrStr(Ret)
end ;

{-----------------------------------------------------------------------------
  Substitui caracter acentuado por compativel
 ---------------------------------------------------------------------------- }
function TiraAcento( const AChar : AnsiChar ) : AnsiChar ;
begin
  case AChar of
    'à','á','ã','ä','â' : Result := 'a' ;
    'À','Á','Ã','Ä','Â' : Result := 'A' ;
    'è','é',    'ë','ê' : Result := 'e' ;
    'È','É',    'Ë','Ê' : Result := 'E' ;
    'ì','í',    'ï','î' : Result := 'i' ;
    'Ì','Í',    'Ï','Î' : Result := 'I' ;
    'ò','ó','õ','ö','ô' : Result := 'o' ;
    'Ò','Ó','Õ','Ö','Ô' : Result := 'O' ;
    'ù','ú',    'ü','û' : Result := 'u' ;
    'Ù','Ú',    'Ü','Û' : Result := 'U' ;
    'ç'                 : Result := 'c' ;
    'Ç'                 : Result := 'C' ;
    'ñ'                 : Result := 'n' ;
    'Ñ'                 : Result := 'N' ;
  else
    Result := AChar ;
  end;
end ;

{-----------------------------------------------------------------------------
  Quebra Linhas grandes no máximo de Colunas especificado, ou caso encontre 
  uma quebra de Linha (CR ou CR+LF)
 ---------------------------------------------------------------------------- }
function AjustaLinhas(Texto: AnsiString; Colunas: Integer ;
   NumMaxLinhas: Integer = 0; PadLinhas: Boolean = False): AnsiString;
Var Count,P,I : Integer ;
    Linha : AnsiString ;
begin
  { Trocando todos os #13+#10 por #10 }
  Texto := StringReplace(Texto, #13+#10   , #10, [rfReplaceAll]) ;
  Texto := StringReplace(Texto, sLineBreak, #10, [rfReplaceAll]) ;

  { Ajustando a largura das Linhas para o máximo permitido em  "Colunas"
    e limitando em "NumMaxLinhas" o total de Linhas}
  Count  := 0 ;
  Result := '' ;
  while ((Count < NumMaxLinhas) or (NumMaxLinhas = 0)) and
        (Length(Texto) > 0) do
  begin
     P := pos(#10, Texto) ;
     if P > (Colunas + 1) then
        P := Colunas + 1 ;

     if P = 0 then
        P := min( Length( Texto ), Colunas ) + 1 ;

     // somar 2 quando encontrar uma tag para não quebrar ela
     if (Copy(Texto, P-1, 1) = '<') or (Copy(Texto, P-2, 2) = '</') then
        inc(P, 2);

     I := 0 ;
     if copy(Texto,P,1) = #10 then   // Pula #10 ?
        I := 1 ;

     Linha := copy(Texto,1,P-1) ;    // Remove #10 (se hover)

     if PadLinhas then
        Result := Result + padL( Linha, Colunas) + #10
     else
        Result := Result + Linha + #10 ;

     Inc(Count) ;
     Texto := copy(Texto, P+I, Length(Texto) ) ;
  end ;

  { Permitir impressão de uma linha em branco --Acrescentado por Marciano Lizzoni }
  if Result = '' then
    Result := Result + #10;
end;

function QuebraLinhas(const Texto: String; const Colunas: Integer;
   const CaracterQuebrar : Char = ' '): String;
Var
  PosIni, PosFim, Tamanho : Integer ;
begin
  Result  := '';
  Tamanho := Length(Texto) ;
  PosIni  := 1 ;
  repeat
     if PosIni > 1 then
        Result := Result + sLineBreak;

     PosFim := PosIni + Colunas - 1 ;

     if Tamanho > PosFim then                  // Ainda tem proxima linha ?
        if Texto[PosFim+1] <> CaracterQuebrar then   // Proximo já é uma Quebra ?
           while (Texto[PosFim] <> CaracterQuebrar) and (PosFim > PosIni) do // Ache uma Quebra
              Dec(PosFim) ;

     if PosFim = PosIni then  // Não foi capaz de encontrar uma quebra
        PosFim := PosIni + Colunas - 1 ;

     Result := Result + Copy( Texto, PosIni, (PosFim-PosIni)+1 );
     PosIni := PosFim + 1 ;

     // Pula CaracterQuebrar no Inicio da String
     while (Texto[PosIni] = CaracterQuebrar) and (PosIni <= Tamanho) do
        Inc(PosIni) ;

  until (PosIni > Tamanho);
end;

{-----------------------------------------------------------------------------
  Traduz Strings do Tipo '#13,v,#10', substituindo #nn por chr(nn). Ignora todo
   texto apos a String ' | '
 ---------------------------------------------------------------------------- }
function TraduzComando( AString : AnsiString ) : AnsiString ;
Var A : Integer ;
begin
  A := pos(' | ',AString) ;
  if A > 0 then
     AString := copy(AString,1,A-1) ;   { removendo texto apos ' | ' }

  Result := AscToString( AString ) ;
end ;

{-----------------------------------------------------------------------------
  Traduz Strings do Tipo chr(13)+chr(10) para uma representação que possa ser
   lida por AscToString Ex: '#13,#10'
 ---------------------------------------------------------------------------- }
function StringToAsc( AString: AnsiString): AnsiString;
Var A : Integer ;
begin
  Result := '' ;
  For A := 1 to Length( AString ) do
     Result := Result + '#'+IntToStr( Ord( AString[A] ) )+',' ;

  Result := copy(Result,1, Length( Result )-1 ) ;
end;

{-----------------------------------------------------------------------------
  Traduz Strings do Tipo '#13,v,#10', substituindo #nn por chr(nn).
  Usar , para separar um campo do outro... No exemplo acima o resultado seria
  chr(13)+'v'+chr(10) 
 ---------------------------------------------------------------------------- }
function AscToString(AString: AnsiString): AnsiString;
Var A : Integer ;
    Token : AnsiString ;
    C : AnsiChar ;
begin
  AString := Trim( AString ) ;
  Result  := '' ;
  A       := 1  ;
  Token   := '' ;

  while A <= length( AString ) + 1 do
  begin
     if A > length( AString ) then
        C := ','
     else
        C := AString[A] ;

     if (C = ',') and (Length( Token ) >= 1) then
      begin
        if Token[1] = '#' then
        try
           Token := AnsiChar( chr( StrToInt( copy(Token,2,length(Token)) ) ) );
        except
        end ;

        Result := Result + Token ;
        Token := '' ;
      end
     else
        Token := Token + C ;

     A := A + 1 ;
  end ;
end;

{-----------------------------------------------------------------------------
 Substitui todos os caracteres de Controle ( menor que ASCII 32 ou maior que
 ASCII 127), de <AString> por sua representação em HEXA. (\xNN)
 Use StringToBinaryString para Converter para o valor original.
 ---------------------------------------------------------------------------- }
function BinaryStringToString(const AString: AnsiString): AnsiString;
var
   ASC : Integer;
   I, N : Integer;
begin
  Result  := '' ;
  N := Length(AString) ;
  For I := 1 to N do
  begin
     ASC := Ord(AString[I]) ;
     if (ASC < 32) or (ASC > 127) then
        Result := Result + '\x'+Trim(IntToHex(ASC,2))
     else
        Result := Result + AString[I] ;
  end ;
end ;

{-----------------------------------------------------------------------------
 Substitui toda representação em HEXA de <AString> (Iniciada por \xNN, (onde NN,
 é o valor em Hexa)).
 Retornana o Estado original, AString de BinaryStringToString.
 ---------------------------------------------------------------------------- }
function StringToBinaryString(const AString: AnsiString): AnsiString;
var
   P : LongInt;
   Hex : String;
   CharHex : AnsiChar;
begin
  Result := AString ;

  P := pos('\x',Result) ;
  while P > 0 do
  begin
     Hex := copy(Result,P+2,2) ;

     try
        CharHex := AnsiChar( Chr(StrToInt('$'+Hex)) ) ;
     except
        CharHex := ' ' ;
     end ;

     Result := StringReplace(Result,'\x'+Hex,CharHex,[rfReplaceAll]) ;
     P      := pos('\x',Result) ;
  end ;
end ;

{-----------------------------------------------------------------------------
 Retorna a String <AString> encriptada por <StrChave>.
 Use a mesma chave para Encriptar e Desencriptar
 ---------------------------------------------------------------------------- }
function StrCrypt(const AString, StrChave: AnsiString): AnsiString;
var
  i, TamanhoString, pos, PosLetra, TamanhoChave: Integer;
  C : AnsiString ;
begin
  Result        := AString;
  TamanhoString := Length(AString);
  TamanhoChave  := Length(StrChave);

  for i := 1 to TamanhoString do
  begin
     pos := (i mod TamanhoChave);
     if pos = 0 then
        pos := TamanhoChave;

     posLetra := ord(Result[i]) xor ord(StrChave[pos]);
     if posLetra = 0 then
        posLetra := ord(Result[i]);

     C := AnsiChar( chr(posLetra) );
     Result[i] := C[1] ;
  end;
end ;

{-----------------------------------------------------------------------------
 Retorna a soma dos Valores ASCII de todos os char de <AString>
 -----------------------------------------------------------------------------}
function SomaAscII(const AString : AnsiString): Integer;
Var A , TamanhoString : Integer ;
begin
  Result        := 0 ;
  TamanhoString := Length(AString);

  For A := 1 to TamanhoString do
     Result := Result + ord( AString[A] ) ;
end ;

{-----------------------------------------------------------------------------
 Retorna valor de CRC16 de <AString>    http://www.ibrtses.com/delphi/dcrc.html
 -----------------------------------------------------------------------------}
function StringCrc16(AString : AnsiString ):word;

  procedure ByteCrc(data:byte;var crc:word);
   Var i : Byte;
  begin
    For i := 0 to 7 do
    begin
       if ((data and $01) xor (crc and $0001)<>0) then
        begin
          crc := crc shr 1;
          crc := crc xor $A001;
        end
       else
          crc := crc shr 1;

       data := data shr 1; // this line is not ELSE and executed anyway.
    end;
  end;

  var len,i : integer;
begin
 len    := length(AString);
 Result := 0;

 for i := 1 to len do
    bytecrc( ord( AString[i] ), Result);
end;


{-----------------------------------------------------------------------------
 Lê 1 byte de uma porta de Hardware
 Nota: - Essa funçao funciona normalmente em Win9x,
        - XP /NT /2000, deve-se usar um device driver que permita acesso direto
          a porta do Hardware a ser acessado (consulte o fabricante do Hardware)
        - Linux: é necessário ser ROOT para acessar man man
          (use: su  ou  chmod u+s SeuPrograma )
 ---------------------------------------------------------------------------- }
{$WARNINGS OFF}
function InPort(const PortAddr:word): byte;
{$IFDEF LINUX}
var Buffer : Pointer ;
    FDevice : String ;
    N : Integer ;
    FHandle : Integer ;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if Assigned( xInp32 ) then
     Result := xInp32(PortAddr)
  else
    asm
        mov dx,PortAddr ;
        in al,dx
        mov Result,al
     end;
{$ELSE}
  FDevice := '/dev/port' ;
  Buffer  := @Result ;

  FHandle := FileOpen(FDevice, fmOpenRead);
  if FHandle <= 0 then
     raise Exception.Create('Erro abrindo:  '+FDevice+#10+#10+
                            'Você deve ter direito de Leitura nesse diretório.');
  try
     N := FileSeek( FHandle, PortAddr, 0 )  ;
     if N <= 0 then
        raise Exception.Create('Erro ao acessar a porta: '+IntToStr(PortAddr));


     N := FileRead(FHandle, Buffer^, 1) ;
     if N <= 0 then
        raise Exception.Create('Erro ao ler a porta: '+IntToStr(PortAddr));
  finally
     FileClose( FHandle );
  end ;
{$ENDIF}
end ;
{$WARNINGS ON}

{-----------------------------------------------------------------------------
 Envia 1 byte para uma porta de Hardware 
 Nota: - Essa funçao funciona normalmente em Win9x,
        - XP /NT /2000, deve-se usar um device driver que permita acesso direto
          a porta do Hardware a ser acessado (consulte o fabricante do Hardware)
        - Linux: é necessário ser ROOT para acessar /dev/port
          (use: su  ou  chmod u+s SeuPrograma ) 
 ---------------------------------------------------------------------------- }
procedure OutPort(const PortAddr: word; const Databyte: byte);
{$IFDEF LINUX}
var Buffer : Pointer ;
    FDevice : String ;
    N : Integer ;
    FHandle : Integer ;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if Assigned( xOut32 ) then
     xOut32(PortAddr, Databyte)
  else
     asm
        mov al, Databyte
        mov dx,PortAddr
        out dx,al
     end;
{$ELSE}
  Buffer := @Databyte ;
  FDevice := '/dev/port' ;

  FHandle := FileOpen(FDevice, fmOpenWrite);
  if FHandle <= 0 then
     raise Exception.Create('Erro abrindo:  '+FDevice+#10+#10+
                            'Você deve ter direito de Escrita nesse diretório.');
  try
     N := FileSeek( FHandle, PortAddr, 0 )  ;
     if N <= 0 then
        raise Exception.Create('Erro ao acessar a porta: '+IntToStr(PortAddr));

     N := FileWrite(Fhandle, Buffer^, 1) ;
     if N <= 0 then
        raise Exception.Create('Erro ao escrever na porta: '+IntToStr(PortAddr));
  finally
     FileClose( FHandle );
  end ;
//sleep(2)
{$ENDIF}
end ;

Procedure FindFiles( const FileMask : String; AStringList : TStrings;
  IncludePath : Boolean = True ) ;
var SearchRec : TSearchRec ;
    RetFind   : Integer ;
    LastFile  : string ;
    Path      : String ;
begin
  LastFile := '' ;
  Path     := ExtractFilePath(FileMask) ;
  RetFind  := SysUtils.FindFirst(FileMask, faAnyFile, SearchRec);
  AStringList.Clear;

  try
     while (RetFind = 0) and (LastFile <> SearchRec.Name) do
     begin
        LastFile := SearchRec.Name ;

        if pos(LastFile, '..') = 0 then    { ignora . e .. }
           AStringList.Add( IfThen(IncludePath, Path, '') + LastFile) ;

        SysUtils.FindNext(SearchRec) ;
     end ;
  finally
     SysUtils.FindClose(SearchRec) ;
  end ;
end;


{-----------------------------------------------------------------------------
  Semelhante a FileExists, mas permite uso de mascaras Ex:(*.BAK, TEST*.PX, etc)
 ---------------------------------------------------------------------------- }
Function FilesExists(const FileMask: string) : Boolean ;
var SearchRec : TSearchRec ;
    RetFind   : Integer ;
    LastFile  : string ;
begin
  LastFile := '' ;
  Result   := false ;
  RetFind  := SysUtils.FindFirst(FileMask, faAnyFile, SearchRec) ;
  try
     while (not Result) and (RetFind = 0) and (LastFile <> SearchRec.Name) do
     begin
        LastFile := SearchRec.Name ;
        Result   := (pos(LastFile, '..') = 0) ;   { ignora . e .. }
        SysUtils.FindNext(SearchRec) ;
     end ;
  finally
     SysUtils.FindClose(SearchRec) ;
  end ;
end ;


{-----------------------------------------------------------------------------
  Semelhante a DeleteFile, porem tenta deletar o Arquivo por
  <WaitTime> milisegundos. Gera Exceção se não conseguir apagar o arquivo.
 ---------------------------------------------------------------------------- }
Procedure TryDeleteFile(const AFile: String; WaitTime: Integer = 100)  ;
  Var TFim : TDateTime ;
begin
  TFim := IncMilliSecond(now,WaitTime) ;
  repeat
     SysUtils.DeleteFile( AFile ) ;
  until (not FileExists( AFile )) or (now > TFim) ;

  if FileExists( AFile ) then
     raise Exception.Create('Erro ao apagar: ' + AFile);
end ;
{-----------------------------------------------------------------------------
  Semelhante a DeleteFile, mas permite uso de mascaras Ex:(*.BAK, TEST*.PX, etc)
  Gera Exceção se não conseguir apagar algum dos arquivos.
 ---------------------------------------------------------------------------- }
Procedure DeleteFiles(const FileMask: string; RaiseExceptionOnFail : Boolean = True)  ;
var SearchRec : TSearchRec ;
    RetFind   : Integer ;
    LastFile  : string ;
    Path      : String ;
begin
  LastFile := '' ;
  Path     := ExtractFilePath(FileMask) ;
  RetFind  := SysUtils.FindFirst(FileMask, faAnyFile, SearchRec);
  try
     while (RetFind = 0) and (LastFile <> SearchRec.Name) do
     begin
        LastFile := SearchRec.Name ;

        if pos(LastFile, '..') = 0 then    { ignora . e .. }
        begin
           if not SysUtils.DeleteFile(Path + LastFile) then
             if RaiseExceptionOnFail then
               raise Exception.Create('Erro ao apagar: ' + Path + LastFile);
        end ;

        SysUtils.FindNext(SearchRec) ;
     end ;
  finally
     SysUtils.FindClose(SearchRec) ;
  end ;
end ;

{-----------------------------------------------------------------------------
 *** CopyFileTo Extraida de idGlobals.pas - INDY ***
 Copia arquivo "AFromFilename" para "AToFilename".  Retorna true se OK
 Nao copia, e retorna false se o destino "AToFilename" já existir e
   "AFailIfExists"  for true
 ---------------------------------------------------------------------------- }
function CopyFileTo(const AFromFileName, AToFileName : String;
   const AFailIfExists : Boolean) : Boolean;
{$IFNDEF MSWINDOWS}
var LStream : TStream;
{$ENDIF}
begin
  {$IFDEF MSWINDOWS}
    Result := CopyFile(PChar(AFromFileName), PChar(AToFileName), AFailIfExists);
  {$ELSE}
    if FileExists(AToFileName) and AFailIfExists then
       Result := False
    else
     begin
       LStream := TFileStream.Create(AFromFileName, fmOpenRead or fmShareDenyWrite);
       try
          with TFileStream.Create(AToFileName, fmCreate) do
             try
                CopyFrom(LStream, 0);
             finally
                Free;
             end;
       finally
          FreeAndNil(LStream);
       end;
       Result := True;
     end;
  {$ENDIF}
end;

{-----------------------------------------------------------------------------
  Verifica se <APath> possui "PathDelim" no final. Retorna String com o Path
  já ajustado
 ---------------------------------------------------------------------------- }
Function PathWithDelim( const APath : String ) : String ;
begin
  Result := Trim(APath) ;
  if Result <> '' then
     if RightStr(Result,1) <> PathDelim then   { Tem delimitador no final ? }
        Result := Result + PathDelim ;
end ;

{-----------------------------------------------------------------------------
  Verifica se <APath> possui "PathDelim" no final. Retorna String SEM o
  DELIMITADOR de Path no final
 ---------------------------------------------------------------------------- }
function PathWithoutDelim(const APath : String) : String ;
Var
  Delimiters : AnsiString ;
begin
  Result := Trim(APath) ;

  Delimiters := PathDelim+'/\' ;
  while (Result <> '') and (pos(RightStr(Result,1), Delimiters ) > 0) do   { Tem delimitador no final ? }
     Result := copy(Result,1,Length(Result)-1)
end;

{-----------------------------------------------------------------------------
  Copia todos os arquivos especificados na mascara <FileMask> para o diretório
  <ToDirName>   Gera Exceção se não conseguir copiar algum dos arquivos.
 ---------------------------------------------------------------------------- }
Procedure CopyFilesToDir(FileMask: string; ToDirName : String;
   const ForceDirectory : Boolean)  ;
var SearchRec : TSearchRec ;
    RetFind   : Integer ;
    LastFile  : string ;
    Path      : String ;
begin
  ToDirName := PathWithDelim(ToDirName) ;
  FileMask  := Trim(FileMask) ;

  if ToDirName = '' then
     raise Exception.Create('Diretório destino não especificado') ;

  if not DirectoryExists(ToDirName) then
  begin
     if not ForceDirectory then
        raise Exception.Create('Diretório ('+ToDirName+') não existente.')
     else
      begin
        ForceDirectories( ToDirName ) ;  { Tenta criar o diretório }
        if not DirectoryExists( ToDirName ) then
           raise Exception.Create( 'Não foi possivel criar o diretório' + sLineBreak +
                                   ToDirName);
      end ;
  end ;

  LastFile := '' ;
  Path     := ExtractFilePath(FileMask) ;
  RetFind  := SysUtils.FindFirst(FileMask, faAnyFile, SearchRec);
  try
     while (RetFind = 0) and (LastFile <> SearchRec.Name) do
     begin
        LastFile := SearchRec.Name ;

        if pos(LastFile, '..') = 0 then    { ignora . e .. }
        begin
           if not CopyFileTo(Path + LastFile, ToDirName + LastFile) then
             raise Exception.Create('Erro ao Copiar o arquivo ('+
                  Path + LastFile + ') para o diretório ('+ToDirName+')') ;
        end ;

        SysUtils.FindNext(SearchRec) ;
     end ;
  finally
     SysUtils.FindClose(SearchRec) ;
  end ;
end ;

{-----------------------------------------------------------------------------
 - Executa programa Externo descrito em "Command", adcionando os Parametros
   "Params" na linha de comando
 - Se "Wait" for true para a execução da aplicação para esperar a conclusao do
   programa externo executado por "Command"
 - WindowState apenas é utilizado na plataforma Windows
 ---------------------------------------------------------------------------- }
procedure RunCommand(Command: String; Params: String; Wait : Boolean;
   WindowState : Word);
var
  {$ifdef MSWINDOWS}
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  Executed : Boolean ;
  PCharStr : PChar ;
  {$endif}
  ConnectCommand : PChar;
begin
  {$ifdef LINUX}
     Command := Trim(Command + ' ' + Params) ;
     if not Wait then
        Command := Command + ' &' ;  { & = Rodar em BackGround }
     {$IFNDEF FPC}
       ConnectCommand := PChar(Command);
       Libc.system(ConnectCommand);
     {$ELSE}
       Shell(Command)
     {$ENDIF}
  {$endif}
  {$ifdef MSWINDOWS}
     Command  := Trim(Command) ;
     PCharStr := PChar(Trim(Params)) ;
     if Length(PCharStr) = 0 then
        PCharStr := nil ;

     if not Wait then
        ShellExecute(0,'open',PChar(Command),PCharStr, nil, WindowState )
//        winexec(ConnectCommand, WindowState)
     else
      begin
        ConnectCommand := PChar(Trim(Command + ' ' + Params));
        PCharStr := PChar(ExtractFilePath(Command)) ;
        if Length(PCharStr) = 0 then
           PCharStr := nil ;
        FillChar(SUInfo, SizeOf(SUInfo), #0);
        with SUInfo do
        begin
           cb          := SizeOf(SUInfo);
           dwFlags     := STARTF_USESHOWWINDOW;
           wShowWindow := WindowState;
        end;

        Executed := CreateProcess(nil, ConnectCommand, nil, nil, false,
                    CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                    PCharStr, SUInfo, ProcInfo);

        try
           { Aguarda até ser finalizado }
           if Executed then
              WaitForSingleObject(ProcInfo.hProcess, INFINITE);
        finally
           { Libera os Handles }
           CloseHandle(ProcInfo.hProcess);
           CloseHandle(ProcInfo.hThread);
        end;
      end;
  {$endif}
end;

procedure OpenURL( const URL : String ) ;
{$IFDEF LINUX}
  Var BrowserName : String ;
{$ENDIF}
begin
 {$IFDEF USE_LCLIntf}
   LCLIntf.OpenURL( URL ) ;
 {$ELSE}
   {$IFDEF MSWINDOWS}
     RunCommand(URL);
   {$ENDIF}
   {$IFDEF LINUX}
     BrowserName := GetEnvironmentVariable('BROWSER') ;
     if BrowserName = '' then
        BrowserName := 'konqueror' ;

     RunCommand(BrowserName, URL);
   {$ENDIF}
 {$ENDIF}
end ;

{$IFDEF MSWINDOWS}
 { Fonte: http://stackoverflow.com/questions/1635947/how-to-make-sure-that-a-file-was-permanently-saved-on-usb-when-user-doesnt-use }
 function FlushToDisk( sFile: string): boolean;
 var
   hDrive: THandle;
   S:      string;
   OSFlushed: boolean;
   bResult: boolean;
 begin
   bResult := False;
   S := '\\.\' + ExtractFileDrive( sFile )[1] + ':';

   //NOTE: this may only work for the SYSTEM user
   hDrive    := CreateFile(PChar(S), GENERIC_READ or
     GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
     OPEN_EXISTING, 0, 0);
   OSFlushed := FlushFileBuffers(hDrive);

   CloseHandle(hDrive);

   if OSFlushed then
   begin
     bResult := True;
   end;

   Result := bResult;
 end;
{$ELSE}
 function FlushToDisk(sFile: string): boolean;
 var
   hDrive: THandle;
 begin
   hDrive := fpOpen(sFile, O_Creat or O_RDWR or O_SYNC);
   Result := (fpfsync(hDrive) = 0);
   fpClose(hDrive);
 end ;
{$ENDIF}

{-----------------------------------------------------------------------------
 - Tenta desligar a Maquina.
 - Se "Reboot" for true Reinicializa
 *** Versão Windows extraida do www.forumweb.com.br/forum  por: Rafael Luiz ***
 ---------------------------------------------------------------------------- }
Procedure DesligarMaquina(Reboot: Boolean = False; Forcar: Boolean = False) ;

{$IFDEF MSWINDOWS}
   function WindowsNT: Boolean;
   var
     osVersao : TOSVersionInfo;
   begin
     osVersao.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
     GetVersionEx(osVersao);
     Result := osVersao.dwPlatformID = VER_PLATFORM_WIN32_NT;
   end;

   procedure ObtemPrivilegios;
   var
     tmpLUID : TLargeInteger;
     hdlProc, hdlToken : THandle;
     tkpNovo, tkpIgnore : TTokenPrivileges;
     dwBuffer, dwIgnoreBuffer : DWord;
   begin
     // Abrir token do processo para ajustar privilégios
     hdlProc := GetCurrentProcess;
     OpenProcessToken(hdlProc, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
         hdlToken);

     // Obter o identificador único do privilégio de shutdown
     LookupPrivilegeValue('', 'SeShutdownPrivilege', tmpLUID);

     // Habilita o privilégio de shutdown em novo token
     tkpNovo.PrivilegeCount := 1;
     tkpNovo.Privileges[0].Luid := tmpLUID;
     tkpNovo.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
     dwBuffer := SizeOf(TTokenPrivileges);

     // Ajusta o privilégio com o novo token
     AdjustTokenPrivileges(hdlToken, False, tkpNovo,
         dwbuffer, tkpIgnore, dwIgnoreBuffer);
   end;


    Var RebootParam : Longword ;
   begin
      if WindowsNT then
         ObtemPrivilegios;

      if Reboot then
         RebootParam := EWX_REBOOT
      else
         RebootParam := EWX_SHUTDOWN  ;

      if Forcar then
         RebootParam := RebootParam or EWX_FORCE ;

      ExitWindowsEx(RebootParam, 0);
   end;

{$ELSE}
   begin
      // Precisa ser o ROOT ou a
      // aplicação ter provilegios de ROOT  (use: su  ,  chmod u+s SeuPrograma )
      if Reboot then
         RunCommand('reboot')
      else
         RunCommand('halt') ;
   end ;
{$ENDIF}

{-----------------------------------------------------------------------------
 - Grava conteudo de "AString" no arquivo "ArqTXT".
 - Se arquivo "ArqTXT" não existir, será criado.  Se "ArqTXT" já existir e
   "Append" for verdadeiro adiciona "AString" no final do arquivo
 ---------------------------------------------------------------------------- }
Procedure WriteToTXT( const ArqTXT, AString : AnsiString;
   const AppendIfExists : Boolean = True; AddLineBreak : Boolean = True );
var
  FS : TFileStream ;
  Buffer : AnsiString ;
begin
  FS := TFileStream.Create( ArqTXT, IfThen( AppendIfExists and FileExists(ArqTXT),
     fmOpenReadWrite, fmCreate) or fmShareDenyWrite );
  try
     Buffer := AString ;
     if AddLineBreak then
        Buffer := Buffer + sLineBreak ;

     FS.Seek(0, soFromEnd);  // vai para EOF
     FS.Write(Pointer(Buffer)^,Length(Buffer));
  finally
     FS.Free ;
  end;
end;

{-----------------------------------------------------------------------------
  Tenta carregar a Biblioteca (DLL) <LibName> e veirica se a função <FuncName>
  existe na DLL. Se existir, retorna ponteiro para a DLL em <LibPointer>
  Veja Exempo de uso em InPort e OutPort (logo acima)
  ( Função encontrada na Internet - Autor desconhecido )
 -----------------------------------------------------------------------------}
function FunctionDetect (LibName, FuncName: String; var LibPointer: Pointer): boolean;
Var
  LibHandle: tHandle;
begin
 Result := FunctionDetect(LibName, FuncName, LibPointer, LibHandle);
end;

function FunctionDetect (LibName, FuncName: String; var LibPointer: Pointer;
   var LibHandle: THandle ): boolean;
begin
 Result := false;
 LibPointer := NIL;
 {$IFDEF FPC}
  LibHandle := dynlibs.LoadLibrary(LibName) ;
 {$ELSE}
  if LoadLibrary(PChar(LibName)) = 0 then
     exit;                                 { não consegiu ler a DLL }

  LibHandle := GetModuleHandle(PChar(LibName));  { Pega o handle da DLL }
 {$ENDIF}

 if LibHandle <> 0 then                    { Se 0 não pegou o Handle, falhou }
  begin
     LibPointer := GetProcAddress(LibHandle, PChar(FuncName));{Procura a função}
     if LibPointer <> NIL then
        Result := true;
  end;
end;

//funcoes para uso com o modulo ACBrSintegra ***********************************************

function TBStrZero(const i: string; const Casas: byte): string;
var
  Ch: AnsiChar;
begin
Result := I;
if length(i)>Casas then begin
   Exit;
   end
 else begin          
  Ch := '0';
end;
while Length(Result)<Casas do
      Result:=Ch+Result;
end;

function TiraPontos(Str: string): string;
var
  i: Integer;
  xStr : String;
begin
 xStr := '';
 for i:=1 to Length(Trim(str)) do
   if (Pos(Copy(str,i,1),'/-.)(,')=0) then xStr := xStr + str[i];

 xStr := StringReplace(xStr,' ','',[rfReplaceAll]);

 Result:=xStr;
end;

function Space(Tamanho: Integer): string;
begin
  Result := StringOfChar(' ', Tamanho);
end;

function LinhaSimples(Tamanho: Integer): string;
begin
  Result := StringOfChar('-', Tamanho);
end;

function LinhaDupla(Tamanho: Integer): string;
begin
  Result := StringOfChar('=', Tamanho);
end;

{------------------------------------------------------------------------------
 Calcula e Retorna o Digito verificador do EAN-13 de acordo com 12 primeiros
  caracteres de <CodEAN13>
 ------------------------------------------------------------------------------}
function EAN13_DV(CodEAN13: String): String;
Var A,DV : Integer ;
begin
   Result   := '' ;
   CodEAN13 := PadR(Trim(CodEAN13),12,'0') ;
   if not StrIsNumber( CodEAN13 ) then
      exit ;

   DV := 0;
   For A := 12 downto 1 do
      DV := DV + (StrToInt( CodEAN13[A] ) * IfThen(odd(A),1,3));

   DV := (Ceil( DV / 10 ) * 10) - DV ;

   Result := IntToStr( DV );
end;

{------------------------------------------------------------------------------
 Retorna True se o <CodEAN13> informado for válido
 ------------------------------------------------------------------------------}
function EAN13Valido(CodEAN13: String): Boolean;
begin
  Result := false ;
  if Length(CodEAN13) = 13 then
     Result := ( CodEAN13[13] =  EAN13_DV(CodEAN13) ) ;
end;

{------------------------------------------------------------------------------
  Traduz uma String de uma página de código para outra
http://www.experts-exchange.com/Programming/Languages/Pascal/Delphi/Q_10147769.html
 ------------------------------------------------------------------------------}
function TranslateString(const S: AnsiString; CP_Destino: Word; CP_Atual: Word = 0): AnsiString;
{$IFDEF USE_LConvEncoding}
 Var
   AnsiStr : AnsiString ;
   UTF8Str : String ;
 begin
   if CP_Atual = 0 then
   begin
     UTF8Str := AnsiToUtf8( S );

     case CP_Destino of
       437   : Result := UTF8ToCP437( UTF8Str ) ;
       850   : Result := UTF8ToCP850( UTF8Str ) ;
       852   : Result := UTF8ToCP852( UTF8Str ) ;
       866   : Result := UTF8ToCP866( UTF8Str ) ;
       874   : Result := UTF8ToCP874( UTF8Str ) ;
       1250  : Result := UTF8ToCP1250( UTF8Str ) ;
       1251  : Result := UTF8ToCP1251( UTF8Str ) ;
       1252  : Result := UTF8ToCP1252( UTF8Str ) ;
       1253  : Result := UTF8ToCP1253( UTF8Str ) ;
       1254  : Result := UTF8ToCP1254( UTF8Str ) ;
       1255  : Result := UTF8ToCP1255( UTF8Str ) ;
       1256  : Result := UTF8ToCP1256( UTF8Str ) ;
       1257  : Result := UTF8ToCP1257( UTF8Str ) ;
       1258  : Result := UTF8ToCP1258( UTF8Str ) ;
       28591 : Result := UTF8ToISO_8859_1( UTF8Str ) ;
       28592 : Result := UTF8ToISO_8859_2( UTF8Str ) ;
     else
       Result := S;
     end ;
   end
   else
   begin
     case CP_Atual of
       437   : UTF8Str := CP437ToUTF8( S ) ;
       850   : UTF8Str := CP850ToUTF8( S ) ;
       852   : UTF8Str := CP852ToUTF8( S ) ;
       866   : UTF8Str := CP866ToUTF8( S ) ;
       874   : UTF8Str := CP874ToUTF8( S ) ;
       1250  : UTF8Str := CP1250ToUTF8( S ) ;
       1251  : UTF8Str := CP1251ToUTF8( S ) ;
       1252  : UTF8Str := CP1252ToUTF8( S ) ;
       1253  : UTF8Str := CP1253ToUTF8( S ) ;
       1254  : UTF8Str := CP1254ToUTF8( S ) ;
       1255  : UTF8Str := CP1255ToUTF8( S ) ;
       1256  : UTF8Str := CP1256ToUTF8( S ) ;
       1257  : UTF8Str := CP1257ToUTF8( S ) ;
       1258  : UTF8Str := CP1258ToUTF8( S ) ;
       28591 : UTF8Str := ISO_8859_1ToUTF8( S ) ;
       28592 : UTF8Str := ISO_8859_2ToUTF8( S ) ;
     else
        UTF8Str := AnsiToUtf8( S );
     end ;

     Result := ACBrStrToAnsi( UTF8Str ) ;
   end ;

 end ;
{$ELSE}
   function WideStringToStringEx(const WS: WideString; CodePage: Word): AnsiString;
   var
     L: Integer;
   begin
     L := WideCharToMultiByte(CodePage, 0, PWideChar(WS), -1, nil, 0, nil, nil);
     SetLength(Result, L - 1);
     WideCharToMultiByte(CodePage, 0, PWideChar(WS), -1, PAnsiChar(Result), L - 1, nil, nil);
   end;

   function StringToWideStringEx(const S: AnsiString; CodePage: Word): WideString;
   var
     L: Integer;
   begin
     L:= MultiByteToWideChar(CodePage, 0, PAnsiChar(S), -1, nil, 0);
     SetLength(Result, L - 1);
     MultiByteToWideChar(CodePage, 0, PAnsiChar(S), -1, PWideChar(Result), L - 1);
   end;
 begin
   Result := WideStringToStringEx( StringToWideStringEx(S, CP_Atual), CP_Destino);
 end;
{$ENDIF}

function MatchText(const AText: AnsiString; const AValues: array of AnsiString): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(AValues) to High(AValues) do
    if AText = AValues[I] then
    begin
      Result := True;
      Break;
    end;
end;

//*****************************************************************************************


initialization
{$IFDEF MSWINDOWS}
  if not FunctionDetect('inpout32.dll','Inp32',@xInp32) then
     xInp32 := NIL ;

  if not FunctionDetect('inpout32.dll','Out32',@xOut32) then
     xOut32 := NIL ;

  if not FunctionDetect('USER32.DLL', 'BlockInput', @xBlockInput) then
  	 xBlockInput := NIL ;
{$ENDIF}

  Randomized := False ;
end.
