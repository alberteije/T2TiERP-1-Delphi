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
|* 10/02/2009: André Ferreira de Moraes
|*  - Adicionado URL de todos os estados
|* 18/02/2009: André Ferreira de Moraes
|*  - Criado Assinatura baseado em código passado por Daniel Simões
|*  - Criado Validação do XML da NFE baseado em código passado por Daniel Simões
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeUtil;

interface

uses {$IFNDEF ACBrNFeOpenSSL}ACBrCAPICOM_TLB, ACBrMSXML2_TLB, JwaWinCrypt, {$ENDIF}
  Classes, Forms,
  {$IFDEF FPC}
     LResources, Controls, Graphics, Dialogs,
  {$ELSE}
     StrUtils,
  {$ENDIF}
  ACBrNFeConfiguracoes, pcnConversao, pcnNFe;


{$IFDEF ACBrNFeOpenSSL}
const
 cDTD     = '<!DOCTYPE test [<!ATTLIST infNFe Id ID #IMPLIED>]>' ;
 cDTDCanc = '<!DOCTYPE test [<!ATTLIST infCanc Id ID #IMPLIED>]>' ;
 cDTDInut = '<!DOCTYPE test [<!ATTLIST infInut Id ID #IMPLIED>]>' ;
 cDTDDpec = '<!DOCTYPE test [<!ATTLIST infDPEC Id ID #IMPLIED>]>' ;
{$ELSE}
const
  DSIGNS = 'xmlns:ds="http://www.w3.org/2000/09/xmldsig#"';
{$ENDIF}
{$IFNDEF ACBrNFeOpenSSL}
var
  CertStore     : IStore3;
  CertStoreMem  : IStore3;
  PrivateKey    : IPrivateKey;
  Certs         : ICertificates2;
  Cert          : ICertificate2;
  NumCertCarregado : String;
{$ENDIF}

type
  NotaUtil = class
  private
//(AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,RJ,RN,RS,RO,RR,SC,SP,SE,TO);
//AC,AL,AP,MA,PA,PB,PI,RJ,RN,RR,SC,SE,TO - Estados sem WebServices próprios
//Estados Emissores pela Sefaz Virtual RS (Rio Grande do Sul): AC, AL, AM, AP, MS, PB, RJ, RR, SC, SE e TO.
//Estados Emissores pela Sefaz Virtual AN (Ambiente Nacional): CE, ES, MA, PA, PI, PR e RN.
    class function GetURLSVRS(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLSVAN(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLAM(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLBA(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLCE(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLDF(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLGO(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLMT(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLMS(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLMG(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLPR(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLPE(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLRS(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLRO(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLSP(AAmbiente: Integer; ALayOut: TLayOut): WideString;
  protected

  public
    {$IFDEF ACBrNFeOpenSSL}
       class function sign_file(const Axml: PAnsiChar; const key_file: PChar; const senha: PChar): AnsiString;
       class function sign_memory(const Axml: PChar; const key_file: Pchar; const senha: PChar; Size: Cardinal; Ponteiro: Pointer): AnsiString;
       class Procedure InitXmlSec ;
       class Procedure ShutDownXmlSec ;
    {$ENDIF}
    class function PosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
    class function PosLast(const SubStr, S: AnsiString ): Integer;
    class function PadE(const AString : string; const nLen : Integer; const Caracter : Char = ' ') : String;
    class function PadD(const AString : string; const nLen : Integer; const Caracter : Char = ' ') : String;
    class function padC(const AString : string; const nLen : Integer; const Caracter : Char = ' ') : String;
    class function SeSenao(ACondicao: Boolean; ATrue, AFalse: Variant) : Variant;
    class function FormatFloat(AValue: Extended; const AFormat: string = ',0.00'): String;
    class function Poem_Zeros(const Texto : String; const Tamanho : Integer) : String;overload;
    class function Poem_Zeros(const Valor : Integer; const Tamanho : Integer) : String;overload;
    class function Modulo11(Valor: string): String;
    class function ChaveAcesso(AUF:Integer; ADataEmissao:TDateTime; ACNPJ:String; ASerie:Integer;
                               ANumero,ACodigo: Integer; AModelo:Integer=55): String;
    class function LasString(AString: String): String;
    class function EstaVazio(const AValue: String): Boolean;overload;
    class procedure EstaVazio(const AValue, AMensagem: String);overload;
    class function NaoEstaVazio(AValue: String): Boolean;
    class function EstaZerado(AValue: Double): Boolean;overload;
    class function EstaZerado(AValue: Integer): Boolean;overload;
    class procedure EstaZerado(AValue: Integer; AMensagem: String);overload;
    class function NaoEstaZerado(AValue: Double): Boolean;overload;
    class function NaoEstaZerado(AValue: Integer): Boolean;overload;
    class function LimpaNumero(AValue: String): String;
    class function TrataString(const AValue: String): String;overload;
    class function TrataString(const AValue: String; const ATamanho: Integer): String;overload;
    class function CortaD(const AString: string; const ATamanho: Integer): String;
    class function CortaE(const AString: string; const ATamanho: Integer): String;
    class function FormatDate(const AString: string): String;
    class function StringToDate(const AString: string): TDateTime;
    class function TamanhoIgual(const AValue: String; const ATamanho: Integer): Boolean;overload;
    class procedure TamanhoIgual(const AValue: String; const ATamanho: Integer; AMensagem: String);overload;
    class function TamanhoIgual(const AValue: Integer; const ATamanho: Integer): Boolean;overload;
    class procedure TamanhoIgual(const AValue: Integer; const ATamanho: Integer; AMensagem: String);overload;
    class function TamanhoMenor(const AValue: String; const ATamanho: Integer): Boolean;
    class function ValidaUFCidade(const UF, Cidade: Integer): Boolean;overload;
    class procedure ValidaUFCidade(const UF, Cidade: Integer; Const AMensagem: String);overload;
    class function FormatarCPF(AValue : String ): String;
    class function FormatarCNPJ(AValue : String ): String;
    class function FormatarCEP(AValue : String ): String;
    class function FormatarFone(AValue : String ): String;
    class function FormatarNumeroDocumentoFiscal(AValue : String ): String;
    class function FormatarChaveAcesso(AValue : String ): String;
    class function GetURL(Const AUF, AAmbiente, FormaEmissao: Integer; ALayOut: TLayOut): WideString;
    class function Valida(Const AXML: AnsiString; var AMsg: AnsiString; const APathSchemas: string = ''): Boolean;
{$IFDEF ACBrNFeOpenSSL}
    class function Assinar(const AXML, ArqPFX, PFXSenha: AnsiString; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ELSE}
    class function Assinar(const AXML: AnsiString; Certificado : ICertificate2; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ENDIF}
    class function StringToFloat(AValue : String ) : Double ;
    class function StringToFloatDef(const AValue: String; const DefaultValue: Double): Double;
    class procedure ConfAmbiente;
    class function PathAplication: String;
    class function ParseText( Texto : AnsiString; Decode : Boolean = True) : AnsiString;
    class function SeparaDados( Texto : AnsiString; Chave : String; MantemChave : Boolean = False ) : AnsiString;
    class function GerarChaveContingencia(FNFe:TNFe): String;
    class function FormatarChaveContigencia(AValue: String): String;
    class function PreparaCasasDecimais(AValue: Integer): String;
    class function CollateBr(Str: String): String;
    class function UpperCase2(Str: String): String;

  published

  end;

implementation

uses {$IFDEF ACBrNFeOpenSSL}libxml2, libxmlsec, libxslt, {$ELSE} ComObj, {$ENDIF} Sysutils,
  Variants, ACBrUtil;

{ NotaUtil }

{$IFDEF ACBrNFeOpenSSL}
class function NotaUtil.sign_file(const Axml: PAnsiChar; const key_file: PChar; const senha: PChar): AnsiString;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PChar;
  bufSize: integer;
label done;
begin
    doc := nil;
    node := nil;
    dsigCtx := nil;
    result := '';

    if (Axml = nil) or (key_file = nil) then Exit;

    try
       { load template }
       doc := xmlParseDoc(Axml);
       if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
         raise Exception.Create('Error: unable to parse');

       { find start node }
       node := xmlSecFindNode(xmlDocGetRootElement(doc), PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
       if (node = nil) then
         raise Exception.Create('Error: start node not found');

       { create signature context, we don't need keys manager in this example }
       dsigCtx := xmlSecDSigCtxCreate(nil);
       if (dsigCtx = nil) then
         raise Exception.Create('Error :failed to create signature context');

       // { load private key}
       dsigCtx^.signKey := xmlSecCryptoAppKeyLoad(key_file, xmlSecKeyDataFormatPkcs12, senha, nil, nil);
       if (dsigCtx^.signKey = nil) then
          raise Exception.Create('Error: failed to load private pem key from "' + key_file + '"');

       { set key name to the file name, this is just an example! }
       if (xmlSecKeySetName(dsigCtx^.signKey, PAnsiChar(key_file)) < 0) then
         raise Exception.Create('Error: failed to set key name for key from "' + key_file + '"');

       { sign the template }
       if (xmlSecDSigCtxSign(dsigCtx, node) < 0) then
         raise Exception.Create('Error: signature failed');

       { print signed document to stdout }
       // xmlDocDump(stdout, doc);
       // Can't use "stdout" from Delphi, so we'll use xmlDocDumpMemory instead...
       buffer := nil;
       xmlDocDumpMemory(doc, @buffer, @bufSize);
       if (buffer <> nil) then
          { success }
          result := buffer ;
   finally
       { cleanup }
       if (dsigCtx <> nil) then
         xmlSecDSigCtxDestroy(dsigCtx);

       if (doc <> nil) then
         xmlFreeDoc(doc);
   end ;
end;

class function NotaUtil.sign_memory(const Axml: PChar; const key_file: Pchar; const senha: PChar; Size: Cardinal; Ponteiro: Pointer): AnsiString;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PChar;
  bufSize: integer;
label done;
begin
    doc := nil;
    node := nil;
    dsigCtx := nil;
    result := '';

    if (Axml = nil) or (key_file = nil) then Exit;
    try
       { load template }
       doc := xmlParseDoc(Axml);
       if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
         raise Exception.Create('Error: unable to parse');

       { find start node }
       node := xmlSecFindNode(xmlDocGetRootElement(doc), PChar(xmlSecNodeSignature), PChar(xmlSecDSigNs));
       if (node = nil) then
         raise Exception.Create('Error: start node not found');

       { create signature context, we don't need keys manager in this example }
       dsigCtx := xmlSecDSigCtxCreate(nil);
       if (dsigCtx = nil) then
         raise Exception.Create('Error :failed to create signature context');

       // { load private key, assuming that there is not password }
       dsigCtx^.signKey := xmlSecCryptoAppKeyLoadMemory(Ponteiro, size, xmlSecKeyDataFormatPkcs12, senha, nil, nil);

       if (dsigCtx^.signKey = nil) then
          raise Exception.Create('Error: failed to load private pem key from "' + key_file + '"');

       { set key name to the file name, this is just an example! }
       if (xmlSecKeySetName(dsigCtx^.signKey, key_file) < 0) then
         raise Exception.Create('Error: failed to set key name for key from "' + key_file + '"');

       { sign the template }
       if (xmlSecDSigCtxSign(dsigCtx, node) < 0) then
         raise Exception.Create('Error: signature failed');

       { print signed document to stdout }
       // xmlDocDump(stdout, doc);
       // Can't use "stdout" from Delphi, so we'll use xmlDocDumpMemory instead...
       buffer := nil;
       xmlDocDumpMemory(doc, @buffer, @bufSize);
       if (buffer <> nil) then
          { success }
          result := buffer ;
   finally
       { cleanup }
       if (dsigCtx <> nil) then
         xmlSecDSigCtxDestroy(dsigCtx);

       if (doc <> nil) then
         xmlFreeDoc(doc);
   end ;
end;

class Procedure NotaUtil.InitXmlSec ;
begin
    { Init libxml and libxslt libraries }
    xmlInitParser();
    __xmlLoadExtDtdDefaultValue^ := XML_DETECT_IDS or XML_COMPLETE_ATTRS;
    xmlSubstituteEntitiesDefault(1);
    __xmlIndentTreeOutput^ := 1;


    { Init xmlsec library }
    if (xmlSecInit() < 0) then
       raise Exception.Create('Error: xmlsec initialization failed.');

    { Check loaded library version }
    if (xmlSecCheckVersionExt(1, 2, 8, xmlSecCheckVersionABICompatible) <> 1) then
       raise Exception.Create('Error: loaded xmlsec library version is not compatible.');

    (* Load default crypto engine if we are supporting dynamic
     * loading for xmlsec-crypto libraries. Use the crypto library
     * name ("openssl", "nss", etc.) to load corresponding
     * xmlsec-crypto library.
     *)
    if (xmlSecCryptoDLLoadLibrary('openssl') < 0) then
       raise Exception.Create( 'Error: unable to load default xmlsec-crypto library. Make sure'#10 +
                          			'that you have it installed and check shared libraries path'#10 +
                          			'(LD_LIBRARY_PATH) environment variable.');

    { Init crypto library }
    if (xmlSecCryptoAppInit(nil) < 0) then
       raise Exception.Create('Error: crypto initialization failed.');

    { Init xmlsec-crypto library }
    if (xmlSecCryptoInit() < 0) then
       raise Exception.Create('Error: xmlsec-crypto initialization failed.');
end ;

class Procedure NotaUtil.ShutDownXmlSec ;
begin
    { Shutdown xmlsec-crypto library }
    xmlSecCryptoShutdown();

    { Shutdown crypto library }
    xmlSecCryptoAppShutdown();

    { Shutdown xmlsec library }
    xmlSecShutdown();

    { Shutdown libxslt/libxml }
    xsltCleanupGlobals();
    xmlCleanupParser();
end ;
{$ENDIF}

class function NotaUtil.ChaveAcesso(AUF: Integer; ADataEmissao: TDateTime;
  ACNPJ: String; ASerie, ANumero, ACodigo: Integer; AModelo: Integer): String;
var
  vUF, vDataEmissao, vSerie, vNumero,
  vCodigo, vModelo: String;
begin
  vUF          := NotaUtil.Poem_Zeros(AUF, 2);
  vDataEmissao := FormatDateTime('YYMM', ADataEmissao);
  vModelo      := NotaUtil.Poem_Zeros(AModelo, 2);
  vSerie       := NotaUtil.Poem_Zeros(ASerie, 3);
  vNumero      := NotaUtil.Poem_Zeros(ANumero, 9);
  vCodigo      := NotaUtil.Poem_Zeros(ACodigo, 9);

  Result := vUF+vDataEmissao+ACNPJ+vModelo+vSerie+vNumero+vCodigo;
  Result := Result+NotaUtil.Modulo11(Result);
end;

class function NotaUtil.PosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
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

class function NotaUtil.PosLast(const SubStr, S: AnsiString ): Integer;
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


class function NotaUtil.CortaD(const AString: string;
  const ATamanho: Integer): String;
begin
  Result := copy(AString,1,ATamanho);
end;

class function NotaUtil.CortaE(const AString: string;
  const ATamanho: Integer): String;
begin
  Result := AString;
  if Length(AString) > ATamanho then
    Result := copy(AString, Length(AString)-ATamanho+1, length(AString));
end;

class function NotaUtil.EstaVazio(const AValue: String): Boolean;
begin
  Result := (Trim(AValue)='');
end;

class function NotaUtil.EstaZerado(AValue: Double): Boolean;
begin
  Result := (AValue = 0);
end;

class procedure NotaUtil.EstaVazio(const AValue, AMensagem: String);
begin
  if NotaUtil.EstaVazio(AValue) then
    raise Exception.Create(AMensagem);
end;

class function NotaUtil.EstaZerado(AValue: Integer): Boolean;
begin
  Result := (AValue = 0);
end;

class function NotaUtil.FormatDate(const AString: string): String;
var
  vTemp: TDateTime;
{$IFDEF VER140} //delphi6
{$ELSE}
  FFormato : TFormatSettings;
{$ENDIF}
begin
  try
{$IFDEF VER140} //delphi6
    DateSeparator := '/';
    ShortDateFormat := 'dd/mm/yyyy';
{$ELSE}
    FFormato.DateSeparator   := '-';
    FFormato.ShortDateFormat := 'yyyy-mm-dd';
//    vTemp := StrToDate(AString, FFormato);
{$ENDIF}
    vTemp := StrToDate(AString);
    if vTemp = 0 then
      Result := ''
    else
      Result := DateToStr(vTemp);
  except
    Result := '';
  end;
end;

class function NotaUtil.StringToDate(const AString: string): TDateTime;
begin
  if (AString = '0') or (AString = '') then
     Result := 0
  else
     Result := StrToDate(AString);
end;

class function NotaUtil.FormatFloat(AValue: Extended;
  const AFormat: string): string;
{$IFDEF VER140} //delphi6
{$ELSE}
var
  vFormato: TFormatSettings;
{$ENDIF}
begin
{$IFDEF VER140} //delphi6
  DecimalSeparator  := ',';
  ThousandSeparator := '.';
  Result := SysUtils.FormatFloat(AFormat, AValue);
{$ELSE}
  vFormato.DecimalSeparator  := ',';
  vFormato.ThousandSeparator := '.';
  Result := SysUtils.FormatFloat(AFormat, AValue, vFormato);
{$ENDIF}
end;

class function NotaUtil.LasString(AString: String): String;
begin
  Result := Copy(AString, Length(AString), Length(AString));
end;

class function NotaUtil.LimpaNumero(AValue: String): String;
var
  A : Integer ;
begin
  Result := '' ;
  For A := 1 to length(AValue) do
  begin
     if (AValue[A] in ['0'..'9']) then
       Result := Result + AValue[A];
  end ;
end;

class function NotaUtil.Modulo11(Valor: string): string;
var
  Soma: integer;
  Contador, Peso, Digito: integer;
begin
  Soma := 0;
  Peso := 2;
  for Contador := Length(Valor) downto 1 do
  begin
    Soma := Soma + (StrToInt(Valor[Contador]) * Peso);
    if Peso < 9 then
      Peso := Peso + 1
    else
      Peso := 2;
  end;

  Digito := 11 - (Soma mod 11);
  if (Digito > 9) then
    Digito := 0;

  Result := IntToStr(Digito);
end;

class function NotaUtil.NaoEstaVazio(AValue: String): Boolean;
begin
  Result := not(EstaVazio(AValue));
end;

class function NotaUtil.NaoEstaZerado(AValue: Double): Boolean;
begin
  Result := not(EstaZerado(AValue));
end;

class function NotaUtil.NaoEstaZerado(AValue: Integer): Boolean;
begin
  Result := not(EstaZerado(AValue));
end;

class function NotaUtil.padC(const AString: string; const nLen: Integer;
  const Caracter: Char): String;
Var nCharLeft : Integer ;
    D : Double ;
begin
  Result    := copy(AString,1,nLen) ;
  D         := (nLen - Length( Result )) / 2 ;
  nCharLeft := Trunc( D ) ;
  Result    := PadE( StringOfChar(Caracter, nCharLeft)+Result, nLen, Caracter) ;
end ;

class function NotaUtil.PadD(const AString: string; const nLen: Integer;
  const Caracter: Char): String;
begin
  Result := copy(AString,1,nLen) ;
  Result := StringOfChar(Caracter, (nLen - Length(Result))) + Result ;
end;

class function NotaUtil.PadE(const AString: string; const nLen: Integer;
  const Caracter: Char): String;
begin
  Result := copy(AString,1,nLen) ;
  Result := Result + StringOfChar(Caracter, (nLen - Length(Result))) ;
end;

class function NotaUtil.Poem_Zeros(const Texto: String;
  const Tamanho: Integer): String;
begin
  Result := PadD(Trim(Texto),Tamanho,'0') ;
end;

class function NotaUtil.Poem_Zeros(const Valor, Tamanho: Integer): String;
begin
  Result := PadD(IntToStr(Valor), Tamanho, '0') ;
end;

class function NotaUtil.SeSenao(ACondicao: Boolean; ATrue,
  AFalse: Variant): Variant;
begin
  Result := AFalse;
  if ACondicao then
    Result := ATrue;
end;

class function NotaUtil.TrataString(const AValue: String): String;
var
  A : Integer ;
begin
  Result := '' ;
  For A := 1 to length(AValue) do
  begin
    case Ord(AValue[A]) of
      60  : Result := Result + '&lt;';  //<
      62  : Result := Result + '&gt;';  //>
      38  : Result := Result + '&amp;'; //&
      34  : Result := Result + '&quot;';//"
      39  : Result := Result + '&#39;'; //'
      32  : begin          // Retira espaços duplos
              if ( Ord(AValue[Pred(A)]) <> 32 ) then
                 Result := Result + ' ';
            end;
      193 : Result := Result + 'A';//Á
      224 : Result := Result + 'a';//à
      226 : Result := Result + 'a';//â
      234 : Result := Result + 'e';//ê
      244 : Result := Result + 'o';//ô
      251 : Result := Result + 'u';//û
      227 : Result := Result + 'a';//ã
      245 : Result := Result + 'o';//õ
      225 : Result := Result + 'a';//á
      233 : Result := Result + 'e';//é
      237 : Result := Result + 'i';//í
      243 : Result := Result + 'o';//ó
      250 : Result := Result + 'u';//ú
      231 : Result := Result + 'c';//ç
      252 : Result := Result + 'u';//ü
      192 : Result := Result + 'A';//À
      194 : Result := Result + 'A';//Â
      202 : Result := Result + 'E';//Ê
      212 : Result := Result + 'O';//Ô
      219 : Result := Result + 'U';//Û
      195 : Result := Result + 'A';//Ã
      213 : Result := Result + 'O';//Õ
      201 : Result := Result + 'E';//É
      205 : Result := Result + 'I';//Í
      211 : Result := Result + 'O';//Ó
      218 : Result := Result + 'U';//Ú
      199 : Result := Result + 'C';//Ç
      220 : Result := Result + 'U';//Ü
    else
      Result := Result + AValue[A];
    end;
  end;
  Result := Trim(Result);
end;

class function NotaUtil.TrataString(const AValue: String;
  const ATamanho: Integer): String;
begin
  Result := NotaUtil.TrataString(NotaUtil.CortaD(AValue, ATamanho));
end;

class function NotaUtil.TamanhoIgual(const AValue: String;
  const ATamanho: Integer): Boolean;
begin
  Result := (Length(AValue)= ATamanho);
end;

class procedure NotaUtil.TamanhoIgual(const AValue: String;
  const ATamanho: Integer; AMensagem: String);
begin
  if not(NotaUtil.TamanhoIgual(AValue, ATamanho)) then
    raise Exception.Create(AMensagem);
end;

class function NotaUtil.TamanhoIgual(const AValue,
  ATamanho: Integer): Boolean;
begin
  Result := (Length(IntToStr(AValue))= ATamanho);
end;

class procedure NotaUtil.TamanhoIgual(const AValue,
  ATamanho: Integer; AMensagem: String);
begin
  if not(NotaUtil.TamanhoIgual(AValue, ATamanho)) then
    raise Exception.Create(AMensagem);
end;


class procedure NotaUtil.EstaZerado(AValue: Integer;
  AMensagem: String);
begin
  if NotaUtil.EstaZerado(AValue) then
    raise Exception.Create(AMensagem);
end;

class function NotaUtil.FormatarCPF(AValue: String): String;
begin
  if Length(AValue) = 0 then
     Result := AValue
  else
   begin
      AValue := NotaUtil.LimpaNumero(AValue);
     Result := copy(AValue,1,3) + '.' + copy(AValue,4 ,3) + '.' +
               copy(AValue,7,3) + '-' + copy(AValue,10,2) ;
   end;
end;

class function NotaUtil.FormatarCNPJ(AValue: String): String;
begin
  if Length(AValue) = 0 then
     Result := AValue
  else
   begin
     AValue := NotaUtil.LimpaNumero(AValue);
     Result := copy(AValue,1,2) + '.' + copy(AValue,3,3) + '.' +
               copy(AValue,6,3) + '/' + copy(AValue,9,4) + '-' + copy(AValue,13,2) ;
   end;
end;

class function NotaUtil.FormatarCEP(AValue: String): String;
begin
  Result := copy(AValue,1,5) + '-' + copy(AValue,6,3);
end;

class function NotaUtil.TamanhoMenor(const AValue: String;
  const ATamanho: Integer): Boolean;
begin
  Result := (Length(AValue) < ATamanho);
end;

class function NotaUtil.FormatarFone(AValue: String): String;
begin
  Result := AValue;
  if NotaUtil.NaoEstaVazio(AValue) then
  begin
    AValue := NotaUtil.Poem_Zeros(NotaUtil.LimpaNumero(AValue), 10);
    Result := '('+copy(AValue,1,2) + ')' + copy(AValue,3,8);
  end;
end;

class function NotaUtil.FormatarNumeroDocumentoFiscal(
  AValue: String): String;
begin
  AValue := NotaUtil.Poem_Zeros(AValue, 9);
  Result := copy(AValue,1,3) + '.' + copy(AValue,4,3)+ '.'+
            copy(AValue,7,3);
end;

class function NotaUtil.FormatarChaveAcesso(AValue: String): String;
begin
  AValue := NotaUtil.LimpaNumero(AValue);
{  Result := copy(AValue,1,2)  + '-' + copy(AValue,3,2) + '/' +
            copy(AValue,5,2)  + '-' + copy(AValue,7,2) + '.' +
            copy(AValue,9,3)  + '.' + copy(AValue,12,3)+ '/' +
            copy(AValue,15,4) + '-' + copy(AValue,19,2)+ '-' +
            copy(AValue,21,2) + '-' + copy(AValue,23,3)+ '-' +
            copy(AValue,26,3) + '.' + copy(AValue,29,3)+ '.' +
            copy(AValue,32,3) + '-' + copy(AValue,35,3)+ '.' +
            copy(AValue,38,3) + '.' + copy(AValue,41,3)+ '-' +
            copy(AValue,44,2);}
  Result := copy(AValue,1,4)  + ' ' + copy(AValue,5,4)  + ' ' +
            copy(AValue,9,4)  + ' ' + copy(AValue,13,4) + ' ' +
            copy(AValue,17,4) + ' ' + copy(AValue,21,4) + ' ' +
            copy(AValue,25,4) + ' ' + copy(AValue,29,4) + ' ' +
            copy(AValue,33,4) + ' ' + copy(AValue,37,4) + ' ' +
            copy(AValue,41,4) ;
end;

class function NotaUtil.GetURL(const AUF, AAmbiente, FormaEmissao : Integer;
  ALayOut: TLayOut): WideString;
begin
//  (AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,RJ,RN,RS,RO,RR,SC,SP,SE,TO);
//  (12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17);

case FormaEmissao of
  1,2,4,5 : begin
       case ALayOut of
         LayNfeEnvDPEC : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/SCERecepcaoRFB/SCERecepcaoRFB.asmx','https://hom.nfe.fazenda.gov.br/SCERecepcaoRFB/SCERecepcaoRFB.asmx');
         LayNfeConsultaDPEC : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.nfe.fazenda.gov.br/SCEConsultaRFB/SCEConsultaRFB.asmx','https://hom.nfe.fazenda.gov.br/SCEConsultaRFB/SCEConsultaRFB.asmx');
       end;
       case AUF of
         12: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //AC
         27: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //AL
         16: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //AP
         13: Result := NotaUtil.GetURLAM(AAmbiente,ALayOut); //AM
         29: Result := NotaUtil.GetURLBA(AAmbiente,ALayOut); //BA
         23: Result := NotaUtil.GetURLCE(AAmbiente,ALayOut); //CE
//         53: Result := NotaUtil.GetURLDF(AAmbiente,ALayOut); //DF  A partir do dia 04/10/2009 todos os contribuintes do DF deverão modificar seus sistemas para utilizarem os serviços da SEFAZ Virtual do Rio Grande do Sul (SVRS).
         53: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //DF
         32: Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut); //ES
         52: Result := NotaUtil.GetURLGO(AAmbiente,ALayOut); //GO
         21: Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut); //MA
         51: Result := NotaUtil.GetURLMT(AAmbiente,ALayOut); //MT
         50: Result := NotaUtil.GetURLMS(AAmbiente,ALayOut); //MS
         31: Result := NotaUtil.GetURLMG(AAmbiente,ALayOut); //MG
         15: Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut); //PA
         25: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //PB
         41: Result := NotaUtil.GetURLPR(AAmbiente,ALayOut); //PR
         26: Result := NotaUtil.GetURLPE(AAmbiente,ALayOut); //PE
         22: Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut); //PI
         33: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //RJ
         24: Result := NotaUtil.GetURLSVAN(AAmbiente,ALayOut); //RN
         43: Result := NotaUtil.GetURLRS(AAmbiente,ALayOut); //RS
//         11: Result := NotaUtil.GetURLRO(AAmbiente,ALayOut); //RO
         11: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //RO  A partir do dia 03/09/2009 todos os contribuintes de RONDÔNIA deverão modificar seus sistemas para utilizarem os serviços da SEFAZ Virtual do Rio Grande do Sul (SVRS).
         14: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //RR
         42: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //SC
         35: Result := NotaUtil.GetURLSP(AAmbiente,ALayOut); //SP
         28: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //SE
         17: Result := NotaUtil.GetURLSVRS(AAmbiente,ALayOut); //TO
      end;
     end;
  3 : begin
       case ALayOut of
         LayNfeRecepcao : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeRecepcao/NfeRecepcao.asmx','https://hom.nfe.fazenda.gov.br/SCAN/nferecepcao/NfeRecepcao.asmx');
         LayNfeRetRecepcao : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeRetRecepcao/NfeRetRecepcao.asmx','https://hom.nfe.fazenda.gov.br/SCAN/nferetrecepcao/NfeRetRecepcao.asmx');
         LayNfeCancelamento : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeCancelamento/NfeCancelamento.asmx','https://hom.nfe.fazenda.gov.br/SCAN/nfecancelamento/NfeCancelamento.asmx');
         LayNfeInutilizacao : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeInutilizacao/NfeInutilizacao.asmx','https://hom.nfe.fazenda.gov.br/SCAN/nfeinutilizacao/NfeInutilizacao.asmx');
         LayNfeConsulta : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeConsulta/NfeConsulta.asmx','https://hom.nfe.fazenda.gov.br/SCAN/nfeconsulta/NfeConsulta.asmx');
         LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.scan.fazenda.gov.br/NfeStatusServico/NfeStatusServico.asmx','https://hom.nfe.fazenda.gov.br/SCAN/nfestatusservico/NfeStatusServico.asmx');
       end;
     end;
  end;
  if Result = '' then
     raise Exception.Create('URL não disponível para o estado solicitado.');
end;

//AC,AL,AP,MA,PA,PB,PI,RJ,RN,RR,SC,SE,TO - Estados sem WebServices próprios
//Estados Emissores pela Sefaz Virtual RS (Rio Grande do Sul): AC, AL, AM, AP, MS, PB, RJ, RR, SC, SE e TO.
//Estados Emissores pela Sefaz Virtual AN (Ambiente Nacional): CE, ES, MA, PA, PI, PR e RN.

class function NotaUtil.GetURLSVRS(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/nferecepcao/NfeRecepcao.asmx', 'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/nferecepcao/NfeRecepcao.asmx');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/nferetrecepcao/NfeRetRecepcao.asmx', 'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/nferetrecepcao/NfeRetRecepcao.asmx');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/nfecancelamento/NfeCancelamento.asmx', 'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/nfecancelamento/NfeCancelamento.asmx');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/nfeinutilizacao/NfeInutilizacao.asmx', 'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/nfeinutilizacao/NfeInutilizacao.asmx');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/nfeconsulta/NfeConsulta.asmx', 'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/nfeconsulta/NfeConsulta.asmx');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefazvirtual.rs.gov.br/ws/nfestatusservico/NfeStatusServico.asmx', 'https://homologacao.nfe.sefazvirtual.rs.gov.br/ws/nfestatusservico/NfeStatusServico.asmx');
//    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, '', '');
  end;
end;

class function NotaUtil.GetURLSVAN(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NfeRecepcao/NfeRecepcao.asmx', 'https://hom.nfe.fazenda.gov.br/NfeRecepcao/NfeRecepcao.asmx');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeRetRecepcao/NFeRetRecepcao.asmx', 'https://hom.nfe.fazenda.gov.br/NFeRetRecepcao/NFeRetRecepcao.asmx');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeCancelamento/NFeCancelamento.asmx', 'https://hom.nfe.fazenda.gov.br/NFeCancelamento/NFeCancelamento.asmx');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeInutilizacao/NFeInutilizacao.asmx', 'https://hom.nfe.fazenda.gov.br/NFeInutilizacao/NFeInutilizacao.asmx');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/nfeconsulta/nfeconsulta.asmx', 'https://hom.nfe.fazenda.gov.br/nfeconsulta/nfeconsulta.asmx');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://www.sefazvirtual.fazenda.gov.br/NFeStatusServico/NFeStatusServico.asmx', 'https://hom.nfe.fazenda.gov.br/NFeStatusServico/NFeStatusServico.asmx');
//    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, '', '');
  end;
end;

class function NotaUtil.GetURLAM(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/ws/services/NfeRecepcao', 'https://homnfe.sefaz.am.gov.br/ws/services/NfeRecepcao');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/ws/services/NfeRetRecepcao', 'https://homnfe.sefaz.am.gov.br/ws/services/NfeRetRecepcao');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/ws/services/NfeCancelamento', 'https://homnfe.sefaz.am.gov.br/ws/services/NfeCancelamento');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/ws/services/NfeInutilizacao', 'https://homnfe.sefaz.am.gov.br/ws/services/NfeInutilizacao');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/ws/services/NfeConsulta', 'https://homnfe.sefaz.am.gov.br/ws/services/NfeConsulta');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.am.gov.br/ws/services/NfeStatusServico', 'https://homnfe.sefaz.am.gov.br/ws/services/NfeStatusServico');
//    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, '', '');
  end;
end;

class function NotaUtil.GetURLBA(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfe/NfeRecepcao.asmx', 'https://hnfe.sefaz.ba.gov.br/webservices/nfe/NfeRecepcao.asmx');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfe/NfeRetRecepcao.asmx', 'https://hnfe.sefaz.ba.gov.br/webservices/nfe/NfeRetRecepcao.asmx');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfe/NfeCancelamento.asmx', 'https://hnfe.sefaz.ba.gov.br/webservices/nfe/NfeCancelamento.asmx');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfe/NfeInutilizacao.asmx', 'https://hnfe.sefaz.ba.gov.br/webservices/nfe/NfeInutilizacao.asmx');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfe/NfeConsulta.asmx', 'https://hnfe.sefaz.ba.gov.br/webservices/nfe/NfeConsulta.asmx');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfe/NfeStatusServico.asmx', 'https://hnfe.sefaz.ba.gov.br/webservices/nfe/NfeStatusServico.asmx');
    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ba.gov.br/webservices/nfe/NfeConsulta.asmx', '');
  end;
end;

class function NotaUtil.GetURLCE(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe/services/NfeRecepcao', 'https://nfeh.sefaz.ce.gov.br/nfe/services/NfeRecepcao');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe/services/NfeRetRecepcao', 'https://nfeh.sefaz.ce.gov.br/nfe/services/NfeRetRecepcao');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe/services/NfeCancelamento', 'https://nfeh.sefaz.ce.gov.br/nfe/services/NfeCancelamento');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe/services/NfeInutilizacao', 'https://nfeh.sefaz.ce.gov.br/nfe/services/NfeInutilizacao');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe/services/NfeConsulta', 'https://nfeh.sefaz.ce.gov.br/nfe/services/NfeConsulta');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe/services/NfeStatusServico', 'https://nfeh.sefaz.ce.gov.br/nfe/services/NfeStatusServico');
    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.ce.gov.br/nfe/services/CadConsultaCadastro', 'https://nfeh.sefaz.ce.gov.br/nfe/services/CadConsultaCadastro');
  end;
end;

class function NotaUtil.GetURLDF(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://dec.fazenda.df.gov.br/nfe/ServiceRecepcao.asmx', 'https://homolog.nfe.fazenda.df.gov.br/nfe/ServiceRecepcao.asmx');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://dec.fazenda.df.gov.br/nfe/ServiceRetRecepcao.asmx', 'https://homolog.nfe.fazenda.df.gov.br/nfe/ServiceRetRecepcao.asmx');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://dec.fazenda.df.gov.br/nfe/ServiceCancelamento.asmx', 'https://homolog.nfe.fazenda.df.gov.br/nfe/ServiceCancelamento.asmx');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://dec.fazenda.df.gov.br/nfe/ServiceInutilizacao.asmx', 'https://homolog.nfe.fazenda.df.gov.br/nfe/ServiceInutilizacao.asmx');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://dec.fazenda.df.gov.br/nfe/ServiceConsulta.asmx', 'https://homolog.nfe.fazenda.df.gov.br/nfe/ServiceConsulta.asmx');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://dec.fazenda.df.gov.br/nfe/ServiceStatus.asmx', 'https://homolog.nfe.fazenda.df.gov.br/nfe/ServiceStatus.asmx');
    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://dec.fazenda.df.gov.br/nfe/ServiceConsultaCadastro.asmx', 'https://homolog.nfe.fazenda.df.gov.br/nfe/ServiceConsultaCadastro.asmx');
  end;
end;

class function NotaUtil.GetURLGO(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/NfeRecepcao', 'https://homolog.sefaz.go.gov.br/nfe/services/NfeRecepcao');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/NfeRetRecepcao', 'https://homolog.sefaz.go.gov.br/nfe/services/NfeRetRecepcao');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/NfeCancelamento', 'https://homolog.sefaz.go.gov.br/nfe/services/NfeCancelamento');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/NfeInutilizacao', 'https://homolog.sefaz.go.gov.br/nfe/services/NfeInutilizacao');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/NfeConsulta', 'https://homolog.sefaz.go.gov.br/nfe/services/NfeConsulta');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/NfeStatusServico', 'https://homolog.sefaz.go.gov.br/nfe/services/NfeStatusServico');
    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.go.gov.br/nfe/services/CadConsultaCadastro', 'https://homolog.sefaz.go.gov.br/nfe/services/CadConsultaCadastro');
  end;
end;

class function NotaUtil.GetURLMT(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/NfeRecepcao', 'https://homologacao.sefaz.mt.gov.br/nfews/NfeRecepcao');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/NfeRetRecepcao', 'https://homologacao.sefaz.mt.gov.br/nfews/NfeRetRecepcao');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/NfeCancelamento', 'https://homologacao.sefaz.mt.gov.br/nfews/NfeCancelamento');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/NfeInutilizacao', 'https://homologacao.sefaz.mt.gov.br/nfews/NfeInutilizacao');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/NfeConsulta', 'https://homologacao.sefaz.mt.gov.br/nfews/NfeConsulta');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/NfeStatusServico', 'https://homologacao.sefaz.mt.gov.br/nfews/NfeStatusServico');
    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.mt.gov.br/nfews/CadConsultaCadastro', 'https://homologacao.sefaz.mt.gov.br/nfews/CadConsultaCadastro');
  end;
end;

class function NotaUtil.GetURLMS(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://producao.nfe.ms.gov.br/producao/services/NfeRecepcao', 'https://homologacao.nfe.ms.gov.br/homologacao/services/NfeRecepcao');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://producao.nfe.ms.gov.br/producao/services/NfeRetRecepcao', 'https://homologacao.nfe.ms.gov.br/homologacao/services/NfeRetRecepcao');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://producao.nfe.ms.gov.br/producao/services/NfeCancelamento', 'https://homologacao.nfe.ms.gov.br/homologacao/services/NfeCancelamento');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://producao.nfe.ms.gov.br/producao/services/NfeInutilizacao', 'https://homologacao.nfe.ms.gov.br/homologacao/services/NfeInutilizacao');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://producao.nfe.ms.gov.br/producao/services/NfeConsulta', 'https://homologacao.nfe.ms.gov.br/homologacao/services/NfeConsulta');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://producao.nfe.ms.gov.br/producao/services/NfeStatusServico', 'https://homologacao.nfe.ms.gov.br/homologacao/services/NfeStatusServico');
//    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, '', '');
  end;
end;

class function NotaUtil.GetURLMG(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe/services/NfeRecepcao', 'https://hnfe.fazenda.mg.gov.br/nfe/services/NfeRecepcao');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe/services/NfeRetRecepcao', 'https://hnfe.fazenda.mg.gov.br/nfe/services/NfeRetRecepcao');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe/services/NfeCancelamento', 'https://hnfe.fazenda.mg.gov.br/nfe/services/NfeCancelamento');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe/services/NfeInutilizacao', 'https://hnfe.fazenda.mg.gov.br/nfe/services/NfeInutilizacao');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe/services/NfeConsulta', 'https://hnfe.fazenda.mg.gov.br/nfe/services/NfeConsulta');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe/services/NfeStatusServico', 'https://hnfe.fazenda.mg.gov.br/nfe/services/NfeStatusServico');
    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.mg.gov.br/nfe/services/CadConsultaCadastro', 'https://hnfe.fazenda.mg.gov.br/nfe/services/CadConsultaCadastro');
  end;
end;

class function NotaUtil.GetURLPR(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeRecepcao', 'https://homologacao.nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeRecepcao');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeRetRecepcao', 'https://homologacao.nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeRetRecepcao');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeCancelamentoNF', 'https://homologacao.nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeCancelamentoNF');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeInutilizacaoNF', 'https://homologacao.nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeInutilizacaoNF');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeConsultaNF', 'https://homologacao.nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeConsultaNF');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeStatusServicoNF', 'https://homologacao.nfe.fazenda.pr.gov.br/NFENWebServices/services/nfeStatusServicoNF');
//    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, '', '');
  end;
end;

class function NotaUtil.GetURLPE(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeRecepcao', 'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeRecepcao');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeRetRecepcao', 'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeRetRecepcao');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeCancelamento', 'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeCancelamento');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeInutilizacao', 'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeInutilizacao');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeConsulta', 'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeConsulta');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/NfeStatusServico', 'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/NfeStatusServico');
    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.pe.gov.br/nfe-service/services/CadConsultaCadastro', 'https://nfehomolog.sefaz.pe.gov.br/nfe-service/services/CadConsultaCadastro');
  end;
end;

class function NotaUtil.GetURLRS(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nferecepcao/NfeRecepcao.asmx', 'https://homologacao.nfe.sefaz.rs.gov.br/ws/nferecepcao/NfeRecepcao.asmx');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nferetrecepcao/NfeRetRecepcao.asmx', 'https://homologacao.nfe.sefaz.rs.gov.br/ws/nferetrecepcao/NfeRetRecepcao.asmx');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfecancelamento/NfeCancelamento.asmx', 'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfecancelamento/NfeCancelamento.asmx');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfeinutilizacao/NfeInutilizacao.asmx', 'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfeinutilizacao/NfeInutilizacao.asmx');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfeconsulta/NfeConsulta.asmx', 'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfeconsulta/NfeConsulta.asmx');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.sefaz.rs.gov.br/ws/nfestatusservico/NfeStatusServico.asmx', 'https://homologacao.nfe.sefaz.rs.gov.br/ws/nfestatusservico/NfeStatusServico.asmx');
    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://sef.sefaz.rs.gov.br/ws/CadConsultaCadastro/CadConsultaCadastro.asmx', 'https://sef.sefaz.rs.gov.br/ws/CadConsultaCadastro/CadConsultaCadastro.asmx');
  end;
end;

class function NotaUtil.GetURLRO(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://ws.nfe.sefin.ro.gov.br/wsprod/NfeRecepcao', 'https://ws.nfe.sefin.ro.gov.br/ws/NfeRecepcao');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://ws.nfe.sefin.ro.gov.br/wsprod/NfeRetRecepcao', 'https://ws.nfe.sefin.ro.gov.br/ws/NfeRetRecepcao');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://ws.nfe.sefin.ro.gov.br/wsprod/NfeCancelamento', 'https://ws.nfe.sefin.ro.gov.br/ws/NfeCancelamento');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://ws.nfe.sefin.ro.gov.br/wsprod/NfeInutilizacao', 'https://ws.nfe.sefin.ro.gov.br/ws/NfeInutilizacao');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://ws.nfe.sefin.ro.gov.br/wsprod/NfeConsulta', 'https://ws.nfe.sefin.ro.gov.br/ws/NfeConsulta');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://ws.nfe.sefin.ro.gov.br/wsprod/NfeStatusServico', 'https://ws.nfe.sefin.ro.gov.br/ws/NfeStatusServico');
    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://ws.nfe.sefin.ro.gov.br/wsprod/CadConsultaCadastro', 'https://ws.nfe.sefin.ro.gov.br/ws/CadConsultaCadastro');
  end;
end;

class function NotaUtil.GetURLSP(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayNfeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nferecepcao.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/nferecepcao.asmx');
    LayNfeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nferetrecepcao.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/nferetrecepcao.asmx');
    LayNfeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfecancelamento.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/nfecancelamento.asmx');
    LayNfeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfeinutilizacao.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/nfeinutilizacao.asmx');
    LayNfeConsulta      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfeconsulta.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/nfeconsulta.asmx');
    LayNfeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/nfestatusservico.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeweb/services/nfestatusservico.asmx');
    LayNfeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeweb/services/cadconsultacadastro.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeWEB/services/cadconsultacadastro.asmx');
  end;
end;

{$IFDEF ACBrNFeOpenSSL}
function ValidaLibXML(const AXML: AnsiString;
  var AMsg: AnsiString; const APathSchemas: string = ''): Boolean;
var
 doc, schema_doc : xmlDocPtr;
 parser_ctxt : xmlSchemaParserCtxtPtr;
 schema : xmlSchemaPtr;
 valid_ctxt : xmlSchemaValidCtxtPtr;
 schemError : xmlErrorPtr;
 schema_filename : PChar;

 Tipo, I : Integer;
begin
  I := pos('<infNFe',AXML) ;
  Tipo := 1;
  if I = 0  then
   begin
     I := pos('<infCanc',AXML) ;
     if I > 0 then
        Tipo := 2
     else
      begin
        I := pos('<infInut',AXML) ;
        if I > 0 then
           Tipo := 3
        else
           Tipo := 4;
      end;
   end;

// if not DirectoryExists(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas') then
//    raise Exception.Create('Diretório de Schemas não encontrado'+sLineBreak+
//                           PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas');
 if not DirectoryExists(NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',PathWithDelim(APathSchemas))) then
    raise Exception.Create('Diretório de Schemas não encontrado'+sLineBreak+
                           NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',PathWithDelim(APathSchemas)));

 if Tipo = 1 then
    //schema_filename := pchar(ExtractFileDir(application.ExeName)+'\Schemas\nfe_v1.10.xsd')
 begin
    if NotaUtil.EstaVazio(APathSchemas) then
       schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\nfe_v1.10.xsd')
    else
       schema_filename := pchar(PathWithDelim(APathSchemas)+'nfe_v1.10.xsd');
 end
 else if Tipo = 2 then
    //schema_filename := pchar(ExtractFileDir(application.ExeName)+'\Schemas\cancNFe_v1.07.xsd')
 begin
    if NotaUtil.EstaVazio(APathSchemas) then
       schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\cancNFe_v1.07.xsd')
    else
       schema_filename := pchar(PathWithDelim(APathSchemas)+'cancNFe_v1.07.xsd');
 end
 else if Tipo = 3 then
    //schema_filename := pchar(ExtractFileDir(application.ExeName)+'\Schemas\inutNFe_v1.07.xsd')
 begin
    if NotaUtil.EstaVazio(APathSchemas) then
       schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\inutNFe_v1.07.xsd')
    else
       schema_filename := pchar(PathWithDelim(APathSchemas)+'inutNFe_v1.07.xsd');
 end
 else if Tipo = 4 then
    //schema_filename := pchar(ExtractFileDir(application.ExeName)+'\Schemas\envDPEC_v1.01.xsd');
 begin
    if NotaUtil.EstaVazio(APathSchemas) then
       schema_filename := pchar(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\envDPEC_v1.01.xsd')
    else
       schema_filename := pchar(PathWithDelim(APathSchemas)+'envDPEC_v1.01.xsd');
 end;

 doc         := nil;
 schema_doc  := nil;
 parser_ctxt := nil;
 schema      := nil;
 valid_ctxt  := nil;

 doc := xmlParseDoc(PAnsiChar(Axml));
 if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
  begin
    AMsg := 'Erro: unable to parse';
    Result := False;
    exit;
  end;

 schema_doc  := xmlReadFile(schema_filename, nil, XML_DETECT_IDS);
//  the schema cannot be loaded or is not well-formed
 if (schema_doc = nil) then
  begin
    AMsg := 'Erro: Schema não pode ser carregado ou está corrompido';
    Result := False;
    exit;
  end;

  parser_ctxt  := xmlSchemaNewDocParserCtxt(schema_doc);
// unable to create a parser context for the schema */
    if (parser_ctxt = nil) then
     begin
        xmlFreeDoc(schema_doc);
        AMsg := 'Erro: unable to create a parser context for the schema';
        Result := False;
        exit;
     end;

   schema := xmlSchemaParse(parser_ctxt);
// the schema itself is not valid
    if (schema = nil) then
     begin
        xmlSchemaFreeParserCtxt(parser_ctxt);
        xmlFreeDoc(schema_doc);
        AMsg := 'Error: the schema itself is not valid';
        Result := False;
        exit;
     end;

    valid_ctxt := xmlSchemaNewValidCtxt(schema);
//   unable to create a validation context for the schema */
    if (valid_ctxt = nil) then
     begin
        xmlSchemaFree(schema);
        xmlSchemaFreeParserCtxt(parser_ctxt);
        xmlFreeDoc(schema_doc);
        AMsg := 'Error: unable to create a validation context for the schema';
        Result := False;
        exit;
     end;

    if (xmlSchemaValidateDoc(valid_ctxt, doc) <> 0) then
     begin
       schemError := xmlGetLastError();
       AMsg := IntToStr(schemError^.code)+' - '+schemError^.message;
       Result := False;
       exit;
     end;

    xmlSchemaFreeValidCtxt(valid_ctxt);
    xmlSchemaFree(schema);
    xmlSchemaFreeParserCtxt(parser_ctxt);
    xmlFreeDoc(schema_doc);
    Result := True;
end;
{$ELSE}
function ValidaMSXML(XML: AnsiString; out Msg: AnsiString; const APathSchemas: string = ''): Boolean;
var
  DOMDocument: IXMLDOMDocument2;
  ParseError: IXMLDOMParseError;
  Schema: XMLSchemaCache;
  Tipo, I : Integer;
begin
  I := pos('<infNFe',XML) ;
  Tipo := 1;
  if I = 0  then
   begin
     I := pos('<infCanc',XML) ;
     if I > 0 then
        Tipo := 2
     else
      begin
        I := pos('<infInut',XML) ;
        if I > 0 then
           Tipo := 3
        else
           Tipo := 4;
      end;
   end;

  DOMDocument := CoDOMDocument50.Create;
  DOMDocument.async := False;
  DOMDocument.resolveExternals := False;
  DOMDocument.validateOnParse := True;
  DOMDocument.loadXML(XML);

  Schema := CoXMLSchemaCache50.Create;

// if not DirectoryExists(PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas') then
//    raise Exception.Create('Diretório de Schemas não encontrado'+sLineBreak+
//                            PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas');
 if not DirectoryExists(NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',PathWithDelim(APathSchemas))) then
    raise Exception.Create('Diretório de Schemas não encontrado'+sLineBreak+
                           NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',PathWithDelim(APathSchemas)));
  if Tipo = 1 then
     //Schema.add( 'http://www.portalfiscal.inf.br/nfe', ExtractFileDir(application.ExeName)+'\Schemas\nfe_v1.10.xsd')
     Schema.add( 'http://www.portalfiscal.inf.br/nfe', NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',PathWithDelim(APathSchemas))+'nfe_v1.10.xsd')
  else if Tipo = 2 then
     //Schema.add( 'http://www.portalfiscal.inf.br/nfe', ExtractFileDir(application.ExeName)+'\Schemas\cancNFe_v1.07.xsd')
     Schema.add( 'http://www.portalfiscal.inf.br/nfe', NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',PathWithDelim(APathSchemas))+'cancNFe_v1.07.xsd')
  else if Tipo = 3 then
     //Schema.add( 'http://www.portalfiscal.inf.br/nfe', ExtractFileDir(application.ExeName)+'\Schemas\inutNFe_v1.07.xsd')
     Schema.add( 'http://www.portalfiscal.inf.br/nfe', NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',PathWithDelim(APathSchemas))+'inutNFe_v1.07.xsd')
  else if Tipo = 4 then
     //Schema.add( 'http://www.portalfiscal.inf.br/nfe', ExtractFileDir(application.ExeName)+'\Schemas\envDPEC_v1.01.xsd');
     Schema.add( 'http://www.portalfiscal.inf.br/nfe', NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\',PathWithDelim(APathSchemas))+'envDPEC_v1.01.xsd');

  DOMDocument.schemas := Schema;
  ParseError := DOMDocument.validate;
  Result := (ParseError.errorCode = 0);
  Msg   := ParseError.reason;

  DOMDocument := nil;
  ParseError := nil;
  Schema := nil;
end;
{$ENDIF}

class function NotaUtil.Valida(const AXML: AnsiString;
  var AMsg: AnsiString; const APathSchemas: string = ''): Boolean;
begin
{$IFDEF ACBrNFeOpenSSL}
  Result := ValidaLibXML(AXML,AMsg,APathSchemas);
{$ELSE}
  Result := ValidaMSXML(AXML,AMsg,APathSchemas);
{$ENDIF}
end;

{$IFDEF ACBrNFeOpenSSL}
function AssinarLibXML(const AXML, ArqPFX, PFXSenha : AnsiString;
  out AXMLAssinado, FMensagem: AnsiString): Boolean;
 Var I, J, PosIni, PosFim : Integer ;
     URI, AStr, XmlAss : AnsiString ;
     Tipo : Integer; // 1 - NFE 2 - Cancelamento 3 - Inutilizacao
     Cert: TMemoryStream;
     Cert2: TStringStream;
begin
  AStr := AXML ;

  //// Encontrando o URI ////
  I := pos('<infNFe',AStr) ;
  Tipo := 1;

  if I = 0  then
   begin
     I := pos('<infCanc',AStr) ;
     if I > 0 then
        Tipo := 2
     else
      begin
        I := pos('<infInut',AStr) ;
        if I > 0 then
           Tipo := 3
        else
           Tipo := 4;
      end;
   end;

  I := NotaUtil.PosEx('Id=',AStr,I+6) ;
  if I = 0 then
     raise Exception.Create('Não encontrei inicio do URI: Id=') ;
  I := NotaUtil.PosEx('"',AStr,I+2) ;
  if I = 0 then
     raise Exception.Create('Não encontrei inicio do URI: aspas inicial') ;
  J := NotaUtil.PosEx('"',AStr,I+1) ;
  if J = 0 then
     raise Exception.Create('Não encontrei inicio do URI: aspas final') ;

  URI := copy(AStr,I+1,J-I-1) ;

  //// Adicionando Cabeçalho DTD, necessário para xmlsec encontrar o ID ////
  I := pos('?>',AStr) ;

  if Tipo = 1 then
     AStr := copy(AStr,1,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+1,I)))) + cDTD     + Copy(AStr,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+2,I))),Length(AStr))
  else if Tipo = 2 then
     AStr := copy(AStr,1,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+1,I)))) + cDTDCanc + Copy(AStr,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+2,I))),Length(AStr))
  else if Tipo = 3 then
     AStr := copy(AStr,1,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+1,I)))) + cDTDInut + Copy(AStr,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+2,I))),Length(AStr))
  else if Tipo = 4 then
     AStr := copy(AStr,1,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+1,I)))) + cDTDDpec + Copy(AStr,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+2,I))),Length(AStr));

  //// Inserindo Template da Assinatura digital ////
  if Tipo = 1 then
   begin
     I := pos('</NFe>',AStr) ;
     if I = 0 then
        raise Exception.Create('Não encontrei final do XML: </NFe>') ;
   end
  else if Tipo = 2 then
   begin
     I := pos('</cancNFe>',AStr) ;
     if I = 0 then
        raise Exception.Create('Não encontrei final do XML: </cancNFe>') ;
   end
  else if Tipo = 3 then
   begin
     I := pos('</inutNFe>',AStr) ;
     if I = 0 then
        raise Exception.Create('Não encontrei final do XML: </inutNFe>') ;
   end
  else if Tipo = 4 then
   begin
     I := pos('</envDPEC>',AStr) ;
     if I = 0 then
        raise Exception.Create('Não encontrei final do XML: </envDPEC>') ;
   end;


  if pos('<Signature',AStr) > 0 then
     I := pos('<Signature',AStr);
     AStr := copy(AStr,1,I-1) +
            '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">'+
              '<SignedInfo>'+
                '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>'+
                '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />'+
                '<Reference URI="#'+URI+'">'+
                  '<Transforms>'+
                    '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />'+
                    '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />'+
                  '</Transforms>'+
                  '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />'+
                  '<DigestValue></DigestValue>'+
                '</Reference>'+
              '</SignedInfo>'+
              '<SignatureValue></SignatureValue>'+
              '<KeyInfo>'+
                '<X509Data>'+
                  '<X509Certificate></X509Certificate>'+
                '</X509Data>'+
              '</KeyInfo>'+
            '</Signature>';

  if Tipo = 1 then
     AStr := AStr + '</NFe>'
  else if Tipo = 2 then
     AStr := AStr + '</cancNFe>'
  else if Tipo = 3 then
     AStr := AStr + '</inutNFe>'
  else if Tipo = 4 then
     AStr := AStr + '</envDPEC>';


  if FileExists(ArqPFX) then
    XmlAss := NotaUtil.sign_file(PChar(AStr), PChar(ArqPFX), PChar(PFXSenha))
  else
   begin
    Cert := TMemoryStream.Create;
    Cert2 := TStringStream.Create(ArqPFX);

    Cert.LoadFromStream(Cert2);

    XmlAss := NotaUtil.sign_memory(PChar(AStr), PChar(ArqPFX), PChar(PFXSenha), Cert.Size, Cert.Memory) ;
  end;

  // Removendo quebras de linha //
  XmlAss := StringReplace( XmlAss, #10, '', [rfReplaceAll] ) ;
  XmlAss := StringReplace( XmlAss, #13, '', [rfReplaceAll] ) ;

  // Removendo DTD //
  if Tipo = 1 then
     XmlAss := StringReplace( XmlAss, cDTD, '', [] )
  else if Tipo = 2 then
     XmlAss := StringReplace( XmlAss, cDTDCanc, '', [] )
  else if Tipo = 3 then
     XmlAss := StringReplace( XmlAss, cDTDInut, '', [] )
  else if Tipo = 4 then
     XmlAss := StringReplace( XmlAss, cDTDDpec, '', [] );

  PosIni := Pos('<X509Certificate>',XmlAss)-1;
  PosFim := NotaUtil.PosLast('<X509Certificate>',XmlAss);

  XmlAss := copy(XmlAss,1,PosIni)+copy(XmlAss,PosFim,length(XmlAss));

  AXMLAssinado := XmlAss ;

  Result := True;
end;
{$ELSE}
function AssinarMSXML(XML : AnsiString; Certificado : ICertificate2; out XMLAssinado : AnsiString): Boolean;
var
 I, J, PosIni, PosFim : Integer;
 URI           : String ;
 Tipo : Integer;

 xmlHeaderAntes, xmlHeaderDepois : AnsiString ;
 xmldoc  : IXMLDOMDocument3;
 xmldsig : IXMLDigitalSignature;
 dsigKey   : IXMLDSigKey;
 signedKey : IXMLDSigKey;
begin
   if Pos('<Signature',XML) <= 0 then
   begin
      I := pos('<infNFe',XML) ;
      Tipo := 1;

      if I = 0  then
       begin
         I := pos('<infCanc',XML) ;
         if I > 0 then
            Tipo := 2
         else
          begin
            I := pos('<infInut',XML) ;
            if I > 0 then
               Tipo := 3
            else
               Tipo := 4;
          end;
       end;

      I := NotaUtil.PosEx('Id=',XML,6) ;
      if I = 0 then
         raise Exception.Create('Não encontrei inicio do URI: Id=') ;
      I := NotaUtil.PosEx('"',XML,I+2) ;
      if I = 0 then
         raise Exception.Create('Não encontrei inicio do URI: aspas inicial') ;
      J := NotaUtil.PosEx('"',XML,I+1) ;
      if J = 0 then
         raise Exception.Create('Não encontrei inicio do URI: aspas final') ;

      URI := copy(XML,I+1,J-I-1) ;

      if Tipo = 1 then
         XML := copy(XML,1,pos('</NFe>',XML)-1)
      else if Tipo = 2 then
         XML := copy(XML,1,pos('</cancNFe>',XML)-1)
      else if Tipo = 3 then
         XML := copy(XML,1,pos('</inutNFe>',XML)-1)
      else if Tipo = 4 then
         XML := copy(XML,1,pos('</envDPEC>',XML)-1);

      XML := XML + '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#"><SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />';
      XML := XML + '<Reference URI="#'+URI+'">';
      XML := XML + '<Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" /><Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" /></Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />';
      XML := XML + '<DigestValue></DigestValue></Reference></SignedInfo><SignatureValue></SignatureValue><KeyInfo></KeyInfo></Signature>';

      if Tipo = 1 then
         XML := XML + '</NFe>'
      else if Tipo = 2 then
         XML := XML + '</cancNFe>'
      else if Tipo = 3 then
         XML := XML + '</inutNFe>'
      else if Tipo = 4 then
         XML := XML + '</envDPEC>';
   end;

   // Lendo Header antes de assinar //
   xmlHeaderAntes := '' ;
   I := pos('?>',XML) ;
   if I > 0 then
      xmlHeaderAntes := copy(XML,1,I+1) ;

   xmldoc := CoDOMDocument50.Create;

   xmldoc.async              := False;
   xmldoc.validateOnParse    := False;
   xmldoc.preserveWhiteSpace := True;

   xmldsig := CoMXDigitalSignature50.Create;

   if (not xmldoc.loadXML(XML) ) then
      raise Exception.Create('Não foi possível carregar o arquivo: '+XML);

   xmldoc.setProperty('SelectionNamespaces', DSIGNS);

   xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');

   if (xmldsig.signature = nil) then
      raise Exception.Create('É preciso carregar o template antes de assinar.');

  if NumCertCarregado <> Certificado.SerialNumber then
      CertStoreMem := nil;

   if  CertStoreMem = nil then
    begin
      CertStore := CoStore.Create;
      CertStore.Open(CAPICOM_CURRENT_USER_STORE, 'My', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

      CertStoreMem := CoStore.Create;
      CertStoreMem.Open(CAPICOM_MEMORY_STORE, 'Memoria', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

      Certs := CertStore.Certificates as ICertificates2;
      for i:= 1 to Certs.Count do
      begin
        Cert := IInterface(Certs.Item[i]) as ICertificate2;
        if Cert.SerialNumber = Certificado.SerialNumber then
         begin
           CertStoreMem.Add(Cert);
           NumCertCarregado := Certificado.SerialNumber;
         end;
      end;
   end;

   OleCheck(IDispatch(Certificado.PrivateKey).QueryInterface(IPrivateKey,PrivateKey));
   xmldsig.store := CertStoreMem;

   dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType, PrivateKey.ProviderName, PrivateKey.ContainerName, 0);

   if (dsigKey = nil) then
      raise Exception.Create('Erro ao criar a chave do CSP.');

   signedKey := xmldsig.sign(dsigKey, $00000002);
   if (signedKey <> nil) then
    begin
      XMLAssinado := xmldoc.xml;
      XMLAssinado := StringReplace( XMLAssinado, #10, '', [rfReplaceAll] ) ;
      XMLAssinado := StringReplace( XMLAssinado, #13, '', [rfReplaceAll] ) ;
      PosIni := Pos('<SignatureValue>',XMLAssinado)+length('<SignatureValue>');
      XMLAssinado := copy(XMLAssinado,1,PosIni-1)+StringReplace( copy(XMLAssinado,PosIni,length(XMLAssinado)), ' ', '', [rfReplaceAll] ) ;
      PosIni := Pos('<X509Certificate>',XMLAssinado)-1;
      PosFim := NotaUtil.PosLast('<X509Certificate>',XMLAssinado);

      XMLAssinado := copy(XMLAssinado,1,PosIni)+copy(XMLAssinado,PosFim,length(XMLAssinado));
    end
   else
      raise Exception.Create('Assinatura Falhou.');

   if xmlHeaderAntes <> '' then
   begin
      I := pos('?>',XMLAssinado) ;
      if I > 0 then
       begin
         xmlHeaderDepois := copy(XMLAssinado,1,I+1) ;
         if xmlHeaderAntes <> xmlHeaderDepois then
            XMLAssinado := StuffString(XMLAssinado,1,length(xmlHeaderDepois),xmlHeaderAntes) ;
       end
      else
         XMLAssinado := xmlHeaderAntes + XMLAssinado ;
   end ;

   dsigKey   := nil;
   signedKey := nil;
   xmldoc    := nil;
   xmldsig   := nil;

   Result := True;
end;
{$ENDIF}

{$IFDEF ACBrNFeOpenSSL}
class function NotaUtil.Assinar(const AXML, ArqPFX, PFXSenha: AnsiString; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ELSE}
class function NotaUtil.Assinar(const AXML: AnsiString; Certificado : ICertificate2; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ENDIF}
begin
{$IFDEF ACBrNFeOpenSSL}
  Result := AssinarLibXML(AXML, ArqPFX, PFXSenha, AXMLAssinado, FMensagem);
{$ELSE}
  Result := AssinarMSXML(AXML,Certificado,AXMLAssinado);
{$ENDIF}
end;


class function NotaUtil.ValidaUFCidade(const UF, Cidade: Integer): Boolean;
begin
  Result := (Copy(IntToStr(UF), 1, 2) = Copy(IntToStr(Cidade), 1, 2));
end;

class procedure NotaUtil.ValidaUFCidade(const UF, Cidade: Integer;
  const AMensagem: String);
begin
  if not(ValidaUFCidade(UF,Cidade)) then
    raise Exception.Create(AMensagem);
end;

class function NotaUtil.StringToFloat(AValue: String): Double;
begin
  AValue := Trim( AValue ) ;

  if DecimalSeparator <> '.' then
     AValue := StringReplace(AValue,'.',DecimalSeparator,[rfReplaceAll]) ;

  if DecimalSeparator <> ',' then
     AValue := StringReplace(AValue,',',DecimalSeparator,[rfReplaceAll]) ;

  Result := StrToFloat(AValue)
end ;

class function NotaUtil.StringToFloatDef(const AValue: String;
  const DefaultValue: Double): Double;
begin
  try
     Result := StringToFloat( AValue ) ;
  except
     Result := DefaultValue ;
  end ;
end ;

class procedure NotaUtil.ConfAmbiente;
begin
  DecimalSeparator := ',';
end;

class function NotaUtil.PathAplication: String;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

class function NotaUtil.ParseText( Texto : AnsiString; Decode : Boolean = True) : AnsiString;
begin
  if Decode then
   begin
    Texto := StringReplace(Texto, '&amp;', '&', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&lt;', '<', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&gt;', '>', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&quot;', '"', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&#39;', #39, [rfReplaceAll]);
    Texto := StringReplace(Texto, '&aacute;', 'á', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Aacute;', 'Á', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&acirc;' , 'â', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Acirc;' , 'Â', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&atilde;', 'ã', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Atilde;', 'Ã', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&agrave;', 'à', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Agrave;', 'À', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&eacute;', 'é', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Eacute;', 'É', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&ecirc;' , 'ê', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Ecirc;' , 'Ê', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&iacute;', 'í', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Iacute;', 'Í', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&oacute;', 'ó', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Oacute;', 'Ó', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&otilde;', 'õ', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Otilde;', 'Õ', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&ocirc;' , 'ô', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Ocirc;' , 'Ô', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&uacute;', 'ú', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Uacute;', 'Ú', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&uuml;'  , 'ü', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Uuml;'  , 'Ü', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&ccedil;', 'ç', [rfReplaceAll]);
    Texto := StringReplace(Texto, '&Ccedil;', 'Ç', [rfReplaceAll]);
    Texto := UTF8Decode(Texto);
   end
  else
   begin
    Texto := StringReplace(Texto, '&', '&amp;', [rfReplaceAll]);
    Texto := StringReplace(Texto, '<', '&lt;', [rfReplaceAll]);
    Texto := StringReplace(Texto, '>', '&gt;', [rfReplaceAll]);
    Texto := StringReplace(Texto, '"', '&quot;', [rfReplaceAll]);
    Texto := StringReplace(Texto, #39, '&#39;', [rfReplaceAll]);
    Texto := UTF8Encode(Texto);
   end;

  Result := Texto;
end;

class function NotaUtil.SeparaDados( Texto : AnsiString; Chave : String; MantemChave : Boolean = False ) : AnsiString;
var
  PosIni, PosFim : Integer;
begin
  if MantemChave then
   begin
     PosIni := Pos(Chave,Texto)-1;
     PosFim := Pos('/'+Chave,Texto)+length(Chave)+3;

     if (PosIni = 0) or (PosFim = 0) then
      begin
        PosIni := Pos('ns1:'+Chave,Texto)-1;
        PosFim := Pos('/ns1:'+Chave,Texto)+length(Chave)+3;
      end;
   end
  else
   begin
     PosIni := Pos(Chave,Texto)+length(Chave)+1;
     PosFim := Pos('/'+Chave,Texto);

     if (PosIni = 0) or (PosFim = 0) then
      begin
        PosIni := Pos('ns1:'+Chave,Texto)+length(Chave)+5;
        PosFim := Pos('/ns1:'+Chave,Texto);
      end;
   end;
  Result := copy(Texto,PosIni,PosFim-(PosIni+1));
end;

class function NotaUtil.GerarChaveContingencia(FNFe:TNFe): string;
   function GerarDigito_Contigencia(var Digito: integer; chave: string): boolean;
   var
     i, j: integer;
   const
     PESO = '43298765432987654329876543298765432';
   begin
     // Manual Integracao Contribuinte v2.02a - Página: 70 //
     chave := NotaUtil.LimpaNumero(chave);
     j := 0;
     Digito := 0;
     result := True;
     try
       for i := 1 to 35 do
         j := j + StrToInt(copy(chave, i, 1)) * StrToInt(copy(PESO, i, 1));
       Digito := 11 - (j mod 11);
       if (j mod 11) < 2 then
         Digito := 0;
     except
       result := False;
     end;
     if length(chave) <> 35 then
       result := False;
   end;
var
   wchave: string;
   wicms_s, wicms_p: string;
   wd,wm,wa: word;
   Digito: integer;
begin
   //ajustado de acordo com nota tecnica 2009.003

   //UF
   if FNFe.Dest.EnderDest.UF='EX' then
      wchave:='99' //exterior
   else
   begin
      if FNFe.Ide.tpNF=tnSaida then
         wchave:=copy(inttostr(FNFe.Dest.EnderDest.cMun),1,2) //saida
      else
         wchave:=copy(inttostr(FNFe.Emit.EnderEmit.cMun),1,2); //entrada
   end;

   //TIPO DE EMISSAO
   if FNFe.Ide.tpEmis=teContingencia then
      wchave:=wchave+'2'
   else if FNFe.Ide.tpEmis=teFSDA then
      wchave:=wchave+'5'
   else
      wchave:=wchave+'0'; //esta valor caracteriza ERRO, valor tem q ser  2 ou 5

   //CNPJ OU CPF
   if (FNFe.Dest.EnderDest.UF='EX') then
      wchave:=wchave+NotaUtil.Poem_Zeros('0',14)
   else
      wchave:=wchave+NotaUtil.Poem_Zeros(FNFe.Dest.CNPJCPF,14);

   //VALOR DA NF
   wchave:=wchave+NotaUtil.Poem_Zeros(NotaUtil.LimpaNumero(Floattostrf(FNFe.Total.ICMSTot.vNF,ffFixed,18,2)),14);

   //DESTAQUE ICMS PROPRIO E ST
   wicms_p:='2';
   wicms_s:='2';
   if (NotaUtil.NaoEstaZerado(FNFe.Total.ICMSTot.vICMS)) then
      wicms_p:='1';
   if (NotaUtil.NaoEstaZerado(FNFe.Total.ICMSTot.vST)) then
      wicms_s:='1';
   wchave:=wchave+wicms_p+wicms_s;

   //DIA DA EMISSAO
   decodedate(FNFe.Ide.dEmi,wa,wm,wd);
   wchave:=wchave+NotaUtil.Poem_Zeros(inttostr(wd),2);

   //DIGITO VERIFICADOR
   GerarDigito_Contigencia(Digito,wchave);
   wchave:=wchave+inttostr(digito);

   //RETORNA A CHAVE DE CONTINGENCIA
   result:=wchave;
end;

class function NotaUtil.FormatarChaveContigencia(AValue: String): String;
begin
  AValue := NotaUtil.LimpaNumero(AValue);
  Result := copy(AValue,1,4)  + ' ' + copy(AValue,5,4)  + ' ' +
            copy(AValue,9,4)  + ' ' + copy(AValue,13,4) + ' ' +
            copy(AValue,17,4) + ' ' + copy(AValue,21,4) + ' ' +
            copy(AValue,25,4) + ' ' + copy(AValue,29,4) + ' ' +
            copy(AValue,33,4) ;
end;

class function NotaUtil.PreparaCasasDecimais(AValue: Integer): String;
var
   i: integer;
begin
   Result:='0';
   if AValue > 0 then
      Result:=Result+'.';
   for I := 0 to AValue-1 do
      Result:=Result+'0';
end;

class function NotaUtil.CollateBr(Str: String): String;
var
   i, wTamanho: integer;
   wChar, wResultado: Char;
begin
   result:='';
   wtamanho:=Length(Str);
   i:=1;
   while (i <= wtamanho) do
   begin
      wChar:=Str[i];
      case wChar of
         'á', 'â', 'ã', 'à', 'ä', 'å',
         'Á', 'Â', 'Ã', 'À', 'Ä', 'Å': wResultado := 'A';
         'é', 'ê', 'è', 'ë',
         'É', 'Ê', 'È', 'Ë': wResultado := 'E';
         'í', 'î', 'ì', 'ï',
         'Í', 'Î', 'Ì', 'Ï': wResultado := 'I';
         'ó', 'ô', 'õ', 'ò', 'ö',
         'Ó', 'Ô', 'Õ', 'Ò', 'Ö': wResultado := 'O';
         'ú', 'û', 'ù', 'ü',
         'Ú', 'Û', 'Ù', 'Ü': wResultado := 'U';
         'ç', 'Ç': wResultado := 'C';
         'ñ', 'Ñ': wResultado := 'N';
         'ý', 'ÿ', 'Ý', 'Y': wResultado := 'Y';
      else
         wResultado:=wChar;
      end;
      i:=i+1;
      Result:=Result+wResultado;
   end;
   Result:=UpperCase(Result);
end;

class function NotaUtil.UpperCase2(Str: String): String;
var
   i, wTamanho: integer;
   wChar, wResultado: Char;
begin
   result:='';
   wtamanho:=Length(Str);
   i:=1;
   while (i <= wtamanho) do
   begin
      wChar:=Str[i];
      case wChar of
         'á','Á': wResultado := 'Á';
         'ã','Ã': wResultado := 'Ã';
         'à','À': wResultado := 'À';
         'â','Â': wResultado := 'Â';
         'ä','Ä': wResultado := 'Ä';
         'å','Å': wResultado := 'Å';
         'é','É': wResultado := 'É';
         'è','È': wResultado := 'È';
         'ê','Ê': wResultado := 'Ê';
         'ë','Ë': wResultado := 'Ë';
         'í','Í': wResultado := 'Í';
         'ì','Ì': wResultado := 'Ì';
         'î','Î': wResultado := 'Î';
         'ï','Ï': wResultado := 'Ï';
         'ó','Ó': wResultado := 'Ó';
         'õ','Õ': wResultado := 'Õ';
         'ò','Ò': wResultado := 'Ò';
         'ô','Ô': wResultado := 'Ô';
         'ö','Ö': wResultado := 'Ö';
         'ú','Ú': wResultado := 'Ú';
         'ù','Ù': wResultado := 'Ù';
         'û','Û': wResultado := 'Û';
         'ü','Ü': wResultado := 'Ü';
         'ç', 'Ç': wResultado := 'Ç';
         'ñ', 'Ñ': wResultado := 'Ñ';
         'ý', 'ÿ', 'Ý', 'Y': wResultado := 'Y';
      else
         wResultado:=wChar;
      end;
      i:=i+1;
      Result:=Result+wResultado;
   end;
   Result:=UpperCase(Result);
end;

end.
