{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rptypes                                         }
{       TRpTypes: Generic type definitions used by      }
{       common components of Report manager             }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rptypes;

interface

{$I rpconf.inc}

uses
{$IFDEF MSWINDOWS}
 Windows,
{$IFNDEF FPC}
 MApi,
 ShellApi,
{$ENDIF}
{$ENDIF}
{$IFDEF LINUX}
 Libc,
{$ENDIF}
 Sysutils,IniFiles,rpmdshfolder,Classes,
{$IFDEF USEVARIANTS}
 Variants,Types,
 {$IFNDEF FPC}
  rtlconsts,
 {$ENDIF}
{$ENDIF}
{$IFNDEF USEVARIANTS}
  consts,
{$ENDIF}
{$IFDEF USEBCD}
 FMTBcd,
{$ENDIF}
{$IFDEF DOTNETD}
 System.IO,System.Text,
 System.Runtime.InteropServices,
{$ENDIF}
{$IFDEF BUILDER4}
 Db,
{$ENDIF}
{$IFDEF USEZLIB}
{$IFDEF DELPHI2009UP}
 zlib,
{$ENDIF}
{$IFNDEF DELPHI2009UP}
 rpmzlib,
{$ENDIF}
{$ENDIF}
{$IFDEF USEINDY}
  IdCoderUUE,IdCoderMIME,
{$ENDIF}
 rpmdconsts;


const
 REP_C_WHEELINC=5;
 REP_C_WHEELSCALE=4;
 CONS_MINLINEINFOITEMS=400;
 LINE_FEED=#13+#10;


 {$IFNDEF USEVARIANTS}
 varWord     = $0012;
 varLongWord = $0013;
 varInt64    = $0014;
 varShortInt = $0010;
{$ENDIF}

type
{$IFNDEF USEVARIANTS}
 TVarType=integer;
{$ENDIF}



 TRpPosAlign=(rpalnone,rpalbottom,rpalright,rpalbotright,
  rpalleftright,rpaltopbottom,rpalclient);

 TRpSelectFontStep=(rpselectsize,rpselectcpi20,rpselectcpi17,rpselectcpi15,rpselectcpi12,
  rpselectcpi10,rpselectcpi6,rpselectcpi5);

 TRpFontStep=(rpcpi20,rpcpi17,rpcpi15,rpcpi12,rpcpi10,rpcpi6,rpcpi5);

 TRpLineInfo=record
  Position:integer;
  Size:integer;
  Width:integer;
  height:integer;
  TopPos:integer;
  step:TRpFontStep;
  lastline:Boolean;
 end;

 TRpNewLanguage=function (alanguage:integer):integer of object;
 TRpOnGetSQLValue=function (connectionname,sql:String):Variant of object;
 TRpGraphicOpProc=function (Top,Left,Width,Height:integer;
    DrawStyle:integer;BrushStyle:integer;BrushColor:integer;
    PenStyle:integer;PenWidth:integer; PenColor:integer):Boolean of object;
 TRpOrientationOpProc=function (orientation:integer):Boolean of object;
 TRpPageOpProc=function (indexqt:integer;custom:Boolean;
  customwidth,customheight,papersource:integer;
  ForcePaperName:String;duplex:integer):Boolean of object;
 TRpImageOpProc=function (Top,Left,Width,Height:integer;
    DrawStyle,DPIRes:integer;PreviewOnly:Boolean;Image:WideString):Boolean of object;
 TRpBarcodeOpProc=function (Top,Left,Width,Height:integer;
    Expression,DisplayFormat:WideString;BarType,Modul:Integer;Ratio,Rotation:Currency;
     CalcChecksum:Boolean;BrushColor:Integer):Boolean of object;
 TRpTextOpProc=function (Top,Left,Width,Height:integer;
  Text,LFontName,WFontName:WideString;
  FontSize,FontRotation,FontStyle,FontColor,Type1Font:integer;
  CutText:boolean;Alignment:integer;WordWrap,RightToLeft:Boolean;
  PrintStep,BackColor:integer;transparent:boolean):Boolean of Object;
 TRpTextHeightProc=function (Text,LFontName,WFontName:WideString;
     RectWidth,FontSize,FontStyle,Type1Font:integer;
     PrintStep:integer):integer of object;
 TRpParamInfoProc=function (ParamName:String;index:integer):String of Object;

 TRpReOpenOp=function (datasetname:String;sql:Widestring):Boolean of object;

 TRpOrientation=(rpOrientationDefault,rpOrientationPortrait,rpOrientationLandscape);

 TRpStreamFormat=(rpStreamzlib,rpStreamText,rpStreambinary,rpStreamXML,rpStreamXMLZlib);

 TRpBidiMode=(rpBidiNo,rpBidiPartial,rpBidiFull);

 TRpParamtype=(rpParamString,rpParamInteger,rpParamDouble,rpParamDate,
  rpParamTime,rpParamDateTime,rpParamCurrency,rpParamBool,
  rpParamExpreB,rpParamExpreA,rpParamSubst,rpParamList,rpParamMultiple,rpParamSubstE,rpParamSubstList,rpParamInitialExpression,rpParamUnknown);

 TRpCachedImage=(rpCachedNone,rpCachedFixed,rpCachedVariable);
 TRpParamObject=class(TObject)
  public
   Value:Variant;
   Stream:TStream;
  end;

 TrpBackStyle=(baDesign,baPreview,baPrint);
 TRpType1Font=(poHelvetica,poCourier,poTimesRoman,poSymbol,poZapfDingbats,poLinked,poEmbedded);
 TRpBrushStyle=(rpbsSolid, rpbsClear, rpbsHorizontal, rpbsVertical,
  rpbsFDiagonal, rpbsBDiagonal, rpbsCross, rpbsDiagCross, rpbsDense1,
  rpbsDense2, rpbsDense3, rpbsDense4, rpbsDense5, rpbsDense6, rpbsDense7);

 TRpTwips=integer;
 TRpImageDrawStyle=(rpDrawCrop,rpDrawStretch,rpDrawFull,rpDrawTile,rpDrawTiledpi);
 TRpAggregate=(rpAgNone,rpAgGroup,rpAgPage,rpAgGeneral);
 TRpAggregateType=(rpagSum,rpagMin,rpagMax,rpagAvg,rpagStdDev);
 TRpReportChanged=(rpReportStart,rpDataChange,rpGroupChange,rpPageChange,rpInvalidateValue,rpSubReportStart,rpSubReportEnd);
 TRpShapeType=(rpsRectangle, rpsSquare, rpsRoundRect, rpsRoundSquare,
  rpsEllipse, rpsCircle,rpsHorzLine,rpsVertLine,rpsOblique1,rpsOblique2);

 TRpReportAction=(rpDrawerBefore,rpDrawerAfter);
 TRpReportActions=set of TRpReportAction;

 TRpPrinterFontsOption=(rppfontsdefault,rppfontsalways,rppfontsnever,rppfontsrecalculate);

 TRpPrinterEscapeStyle=(rpPrinterDefault,rpPrinterPlain,rpPrinterDatabase,rpPrinterCustom);

 TRpPageSize=(rpPageSizeDefault,rpPageSizeCustom,rpPageSizeUser);

 TPageSizeQt=record
  Indexqt:integer;
  Custom:boolean;
  CustomWidth:integer;
  CustomHeight:integer;
  PhysicWidth:integer;
  PhysicHeight:integer;
  PaperSource:integer;
  ForcePaperName:array [0..60] of char;
  Duplex:integer;
 end;


 TRpPrinterSelect=(pRpDefaultPrinter,pRpReportPrinter,
  pRpTicketPrinter,pRpGraphicprinter,
  pRpCharacterprinter,pRpReportPrinter2,
  pRpTicketPrinter2,pRpUserPrinter1,pRpUserPrinter2,
  pRpUserPrinter3,pRpUserPrinter4,pRpUserPrinter5,
  pRpUserPrinter6,pRpUserPrinter7,pRpUserPrinter8,
  pRpUserPrinter9,pRpPlainPrinter,pRpPlainFullPrinter);

 TRpColor=integer;

 // How to show preview
 TRpPreviewStyle = (spWide,spNormal,spEntirePage,spCustom);
 TRpPreviewWindowStyle=(spwNormal,spwMaximized);

 TPrinterRawOp=(rawopcutpaper,rawopopendrawer,rpescapelinefeed,rpescapecr,
  rpescapeformfeed,rpescapetearoff,rpescapeinitprinter,rpescapepulse,
  rpescapeendprint,rpescaperedfont,rpescapeblackfont,
  rpescapeNormal, rpescapeBold,rpescapeUnderline,rpescapeItalic,
  rpescapeStrikeOut,
  rplinespace6,rplinespace8,rplinespace7_72,rplinespacen_216,rplinespacen_180,rplinespacen_60,
  rpescape20cpi,rpescape17cpi,rpescape15cpi,rpescape12cpi,rpescape10cpi,
  rpescape6cpi,rpescape5cpi);

 TBitmapResizeEvent=procedure (awidth,aheight:integer;var scale:double) of object;

 TRpReportException=class(Exception)
  private
   FComponent:TComponent;
   FPropertyName:string;
  public
   constructor Create(AMessage:String;compo:TComponent;apropname:string);
   property Component:TComponent read FComponent;
   property PropertyName:string read FPropertyName;
  end;

  TRpWString = class(TObject)
    WString: WideString;
  end;


  TRpWideStrings = class(TPersistent)
  private
    FWideList: TList;
    function GetString(Index: Integer): WideString;
    procedure PutString(Index: Integer; const S: WideString);
    procedure SetText(avalue:widestring);
    function GetText:widestring;
  protected
    procedure AssignTo(destination:TPersistent);override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function  Count: Integer;
    function IndexOf(name:WideString):integer;
    procedure Insert(Index: Integer; const S: WideString);
    function Add(const S: WideString): Integer;
    property Strings[Index: Integer]: WideString read GetString write PutString;
    property Text:widestring read GetText write SetText;
  end;



function StringCachedImageToCachedImage(Value:widestring):TRpCachedImage;
function RpCachedImageToString(Value:TRpCachedImage):String;
procedure GetCachedImageDescriptionsA(alist:TStrings);
procedure GetCachedImageDescriptions(alist:TRpWideStrings);

procedure SetForcePaperName(var apagesize:TPageSizeQt;source:string);
function StringDrawStyleToDrawStyle(Value:widestring):TRpImageDrawStyle;
function RpDrawStyleToString(Value:TRpImageDrawStyle):String;
procedure GetDrawStyleDescriptionsA(alist:TStrings);
procedure GetDrawStyleDescriptions(alist:TRpWideStrings);
function StrToBackStyle(value:string):TrpBackStyle;
function BackStyleToStr(value:TrpBackStyle):string;
{$IFNDEF FPC}
procedure SendMail(destination,subject,content,filename,originalfile:String);
{$ENDIF}
function StrToAlign(value:string):TRpPosAlign;
function AlignToStr(value:TRpPosAlign):string;
function VarIsString(avar:Variant):Boolean;
function VarIsNumber(avar:Variant):Boolean;
function VarIsInteger(avar:Variant):Boolean;
function VarIsBoolean(avar:Variant):Boolean;
function IsRedColor(Color:Integer):Boolean;
// Compares 2 streams and returns true if they are equal
function StreamCompare(Stream1:TStream;Stream2:TStream):Boolean;
function IsCompressed(astream:TMemoryStream):Boolean;
procedure DecompressStream(astream,deststream:TMemoryStream);
procedure CompressStream(astream,deststream:TMemoryStream);
procedure WriteWideString(Writer:TWriter;Value:WideString);
function  ReadWideString(Reader:TReader):WideString;
procedure Generatenewname(Component:TComponent);
function FormatVariant(displayformat:string;Value:Variant;paramtype:TRpParamType;printnulls:boolean):widestring;
function CopyFileTo(const Source, Destination: string): Boolean;
function GetPrinterConfigName(printerindex:TRpPrinterSelect):string;
function GetPrinterOffset(printerindex:TRpPrinterSelect):TPoint;
function GetDeviceFontsOption(printerindex:TRpPrinterSelect):boolean;
function GetPrinterOemConvertOption(printerindex:TRpPrinterSelect):boolean;
function GetPrinterRawOp(printerindex:TRpPrinterSelect;rawop:TPrinterRawOp):string;
procedure FillTreeDir(adirectory:String;alist:TStringList);
function WideStringToDOS(astring:WideString):WideString;
function NumberToText(FNumero:currency;female:boolean;idiom:integer):WideString;
procedure GetLanguageDescriptions(alist:TStrings);
procedure GetBidiDescriptions(alist:TRpWideStrings);
procedure GetBidiDescriptionsA(alist:TStrings);
function RpBidiModeToString(BidiMode:TRpBidiMode):String;
function StringToRpBidiMode(Value:String):TRpBidiMode;
function DoReverseString(Value:String):String;
function DoReverseStringW(Value:WideString):WideString;
function GetWheelInc(Shift:TShiftState):integer;
procedure GetStepDescriptions(alist:TRpWideStrings);
procedure GetStepDescriptionsA(alist:TStrings);
procedure GetBackStyleDescriptions(alist:TRpWideStrings);
procedure GetBackStyleDescriptionsA(alist:TStrings);
function StringToFontStep(cad:string):TRpSelectFontStep;
function FontStepToString(fstep:TRpSelectFontStep):Widestring;
function FontSizeToStep (asize:integer;select:TRpSelectFontStep):TRpFontStep;
function GetPrinterEscapeStyleDriver(printerindex:TRpPrinterSelect):String;
function GetPrinterEscapeOem(printerindex:TRpPrinterSelect):Boolean;
function GetPrinterEscapeStyleOption(printerindex:TRpPrinterSelect):TRpPrinterEscapeStyle;
procedure GetTextOnlyPrintDrivers(drivernames:TStrings);
procedure ReloadPrinterConfig;
procedure WriteStringToDevice(S,Device:String);
function GetLastname(astring:string):string;
function GetPathName(astring:string):string;
function GetFirstName(astring:string):string;
function TextToType1Font(value:string):TRpType1Font;
function Type1FontToText(value:TRpType1Font):string;
{$IFNDEF DOTNETD}
procedure WriteToStdError(astring:String);
procedure WriteStreamToStdOutput(astream:TStream);
procedure WriteStreamToHandle(astream:TStream;handle:Integer);
function ReadFromStdInputStream:TMemoryStream;
function ReadStreamFromHandle(handle:THandle):TMemoryStream;
{$ENDIF}
{$IFDEF DOTNETD}
function CompareMem(const Mem1: array of Byte; const Mem2: array of Byte;
    Count: Integer): Boolean;
{$ENDIF}
function PrinterRawOpEnabled(printerindex:TRpPrinterSelect;rawop:TPrinterRawOp):Boolean;

{$IFDEF LINUX}
procedure ExecuteSystemApp(aparams:TStrings;waitend:Boolean);
procedure  ObtainPrinters(alist:TStrings);
procedure SendTextToPrinter(S:String;printerindex:TRpPrinterSelect;Title,forceprintername:String);
procedure ReadFileLines(filename:String;dest:TStrings);
procedure ExecuteSystemCommand(params:TStrings);
{$ENDIF}

procedure GetPaperSourceDescriptions(alist:TStrings);
procedure GetDuplexDescriptions(alist:TStrings);

function RpTempFileName:String;
function RpTempPath:String;
procedure WriteStringToStream(astring:AnsiString;deststream:TStream);
procedure WriteWideStringToStream(astring:WideString;deststream:TStream);
function FormatCurrAdv(mask:String;number:double):String;
// Rounding a number with not balanced system
// always the upper value if in the middle
function Roundfloat(num:double;redondeo:double):double;

{$IFDEF MSWINDOWS}
function RpCharToOem(source:AnsiString):AnsiString;
{$ENDIF}

{$IFDEF DOTNETD}
{$UNSAFECODE ON}
 function StrPas(source:Pchar):String;unsafe;
 function StrPCopy(destination:PChar;Source:String):PChar;unsafe;
 function StrPWCopy(destination:PWideChar;Source:WideString):PWideChar;unsafe;
{$UNSAFECODE OFF}
{$ENDIF}


{$IFDEF MSWINDOWS}
function IsWindowsNT:Boolean;
 {$IFNDEF DOTNETD}
  function ExeResourceToStream (resId: Integer):TMemoryStream;
 {$ENDIF}
{$ENDIF}


{$IFNDEF USEVARIANTS}
type
 TValueRelationship = -1..1;

function CompareValue(const A,B,Epsilon: Double): TValueRelationship;
{$ENDIF}


{$IFNDEF USEVARIANTS}
 {$DEFINE BOOLFUNC}
{$ENDIF}

{$IFDEF BOOLFUNC}
procedure RaiseLastOSError;
function BoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string;
function StrToBool(const S: string): Boolean;
function StrToBoolDef(const S: string; const Default: Boolean): Boolean;
function TryStrToBool(const S: string; out Value: Boolean): Boolean;
function TryStrToFloat(const S: string; out Value: Double): Boolean;
var
  TrueBoolStrs: array of String;
  FalseBoolStrs: array of String;

const
  DefaultTrueBoolStr = 'True';   // DO NOT LOCALIZE
  DefaultFalseBoolStr = 'False'; // DO NOT LOCALIZE
{$ENDIF}

{$IFDEF BUILDER4}
function VarTypeToDataType(VarType: Integer): TFieldType;
{$ENDIF}

{$IFNDEF USEVARIANTS}
function GetEnvironmentVariable(aname:String):string;
{$ENDIF}
function RpHTMLEncode(const AStr:String):String;


function GetLineLangByIndex(astring:widestring;index:integer):string;
function AddLineLangByIndex(astring:widestring;newstring:widestring;index:integer):string;

{$IFDEF MSWINDOWS}
var
 osinfo:TOsVersionInfo;
{$ENDIF}

{$IFDEF USEINDY}
procedure CheckUUDecode(amemstream:TMemoryStream);
procedure MIMEDecode(amemstream:TMemoryStream);
function MIMEDecodeString(avalue:string):string;
procedure MIMEEncode(amemstream:TMemoryStream;DestStream:TStream);
function MIMEEncodeString(amemstream:TMemoryStream):string;
{$ENDIF}
function EscapeCodedToString(astring:string):string;


implementation

procedure SetForcePaperName(var apagesize:TPageSizeQt;source:string);
var
 i:integer;
begin
 if Length(source)>60 then
  source:=Copy(source,1,60);
 i:=1;
 while i<=Length(source) do
 begin
  apagesize.ForcePaperName[i-1]:=source[i];
  inc(i);
 end;
 while i<=61 do
 begin
  apagesize.ForcePaperName[i-1]:=chr(0);
  inc(i);
 end;
end;


var
//  cajpeg:array [0..10] of char=(chr($FF),chr($D8),chr($FF),chr($E0),chr($0),chr($10),'J','F','I','F',chr(0));
 printerconfigfile:TMemInifile;

{$IFNDEF DOTNETD}
{$IFDEF MSWINDOWS}
var
 obtainedversion:Boolean;
{$ENDIF}
{$ENDIF}

{$IFDEF BOOLFUNC}


procedure RaiseLastOSError;
begin
{$IFDEF FPC}
 SysUtils.RaiseLastOSError;
{$ENDIF}
{$IFNDEF FPC}
 RaiseLastWin32Error;
{$ENDIF}
end;

function TryStrToFloat(const S: string; out Value: Double): Boolean;
{$IFNDEF FPC}
var
 avalue:extended;
{$ENDIF}
begin
{$IFNDEF FPC}
 try
  avalue:=value;
  Result := TextToFloat(PChar(S), aValue, fvExtended);
  if Result then
   Value:=avalue;
 except
  Result:=false;
 end;
{$ENDIF}
{$IFDEF FPC}
  Result:=true;
  try
   Value:=StrToFloat(S);
  except
   Result:=false;
  end;
{$ENDIF}
end;

procedure VerifyBoolStrArray;
begin
  if Length(TrueBoolStrs) = 0 then
  begin
    SetLength(TrueBoolStrs, 1);
    TrueBoolStrs[0] := DefaultTrueBoolStr;
  end;
  if Length(FalseBoolStrs) = 0 then
  begin
    SetLength(FalseBoolStrs, 1);
    FalseBoolStrs[0] := DefaultFalseBoolStr;
  end;
end;

function StrToBool(const S: string): Boolean;
begin
  if not TryStrToBool(S, Result) then
    Raise Exception.Create(SRpInvalidBoolean+S);
end;

function StrToBoolDef(const S: string; const Default: Boolean): Boolean;
begin
  if not TryStrToBool(S, Result) then
    Result := Default;
end;

function TryStrToBool(const S: string; out Value: Boolean): Boolean;
  function CompareWith(const aArray: array of string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := Low(aArray) to High(aArray) do
//      if AnsiSameText(S, aArray[I]) then
      if UpperCase(S)=UpperCase(aArray[I]) then
      begin
        Result := True;
        Break;
      end;
  end;
var
  LResult: Double;
begin
  Result := TryStrToFloat(S, LResult);
  if Result then
    Value := LResult <> 0
  else
  begin
    VerifyBoolStrArray;
    Result := CompareWith(TrueBoolStrs);
    if Result then
      Value := True
    else
    begin
      Result := CompareWith(FalseBoolStrs);
      if Result then
        Value := False;
    end;
  end;
end;

function BoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string;
const
  cSimpleBoolStrs: array [boolean] of String = ('0', '-1');
begin
  if UseBoolStrs then
  begin
    VerifyBoolStrArray;
    if B then
      Result := TrueBoolStrs[0]
    else
      Result := FalseBoolStrs[0];
  end
  else
    Result := cSimpleBoolStrs[B];
end;
{$ENDIF}

function VarIsString(avar:Variant):Boolean;
begin
 Result:=false;
 if ((VarType(avar)=varstring) or (VarType(avar)=varOleStr)) then
  Result:=true;
end;

function VarIsNumber(avar:Variant):Boolean;
begin
 Result:=(Vartype(avar) in [varSmallInt,varInteger,varSingle,varDouble,VarCurrency,
  varShortInt,varByte,varWord,varLongWord,varInt64]);
end;

function VarIsInteger(avar:Variant):Boolean;
begin
 Result:=(Vartype(avar) in [varSmallInt,varInteger,varShortInt,varByte,varWord,varLongWord,varInt64]);
end;

function VarIsBoolean(avar:Variant):Boolean;
begin
 Result:=(Vartype(avar) in [varBoolean]);
end;


constructor TRpReportException.Create(AMessage:String;compo:TComponent;
 apropname:string);
begin
 FComponent:=compo;
 FPropertyName:=apropname;
 inherited Create(AMessage);
end;

function StreamCompare(Stream1:TStream;Stream2:TStream):Boolean;
const
 SIZE_BUF=131072;
var
 buf1,buf2:array [0..SIZE_BUF] of Byte;
 readcount:integer;
begin
 Result:=True;
 if Stream1.Size<>Stream2.Size then
 begin
  Result:=False;
  Exit;
 end;
 // If the same size then compare memory
 Stream1.Seek(0,soFromBeginning);
 Stream2.Seek(0,soFromBeginning);
{$IFNDEF DOTNETD}
 readcount:=Stream1.Read(buf1[0],SIZE_BUF);
 Stream2.Read(buf2[0],SIZE_BUF);
{$ENDIF}
{$IFDEF DOTNETD}
 readcount:=Stream1.Read(buf1,SIZE_BUF);
 Stream2.Read(buf2,SIZE_BUF);
{$ENDIF}
 while (readcount<>0) do
 begin
{$IFDEF DOTNETD}
  if Not CompareMem(buf1,buf2,readcount) then
{$ENDIF}
{$IFNDEF DOTNETD}
  if Not CompareMem(@buf1,@buf2,readcount) then
{$ENDIF}
  begin
   result:=False;
   break;
  end;
{$IFNDEF DOTNETD}
  readcount:=Stream1.Read(buf1[0],SIZE_BUF);
  Stream2.Read(buf2[0],SIZE_BUF);
{$ENDIF}
{$IFDEF DOTNETD}
  readcount:=Stream1.Read(buf1,SIZE_BUF);
  Stream2.Read(buf2,SIZE_BUF);
{$ENDIF}
 end;
end;

function CopyFileTo(const Source, Destination: string): Boolean;
var
 Stream1:TMemoryStream;
begin
 Stream1:=TMemoryStream.Create;
 try
  Stream1.LoadFromFile(Source);
  Stream1.Seek(0,soFromBeginning);
  Stream1.SaveToFile(Destination);
 finally
  Stream1.free;
 end;
 Result:=True;
//  Result := CopyFile(PChar(Source), PChar(Destination), true);
end;


procedure Generatenewname(Component:TComponent);
var i:integer;
    name1:string;
begin
 i:=0;
 name1:=Component.ClassName;
 while (nil<>Component.Owner.FindComponent(name1+IntToStr(i))) do
  inc(i);
 Component.Name:=name1+IntToStr(i);
end;

const
 varDecimalType=14;



function FormatVariant(displayformat:string;Value:Variant;
 paramtype:TRpParamType;printnulls:boolean):widestring;
var
 atype:TVarType;
begin
 if paramtype<>rpParamunknown then
 begin
  if VarIsNull(Value) then
  begin
   case paramtype of
    rpParamString,rpParamExpreB,rpParamExpreA,rpParamSubst,rpParamSubstE,rpParamMultiple:
     Value:='';
    rpParamInteger,rpParamDouble,rpParamCurrency:
     Value:=0;
    rpParamBool:
     Value:=false;
   end;
  end;
 end
 else
 begin
  if VarIsNull(Value) then
  begin
   Result:='';
   exit;
  end;
 end;
 if Not VarIsNull(Value) then
 begin
  if Length(displayformat)<1 then
  begin
   if printnulls then
   begin
    if (paramtype in [rpParamDate,rpParamTime,rpParamDateTime]) then
    begin
     if paramtype=rpParamDate then
      displayformat:=ShortDateFormat
     else
      if paramtype=rpParamTime then
       displayformat:=ShortTimeFormat
      else
       displayformat:=ShortDateFormat+' '+ShortTimeFormat;
     if VarType(value) in [varDate,varDouble,varSingle,varCurrency,varInteger,varDecimalType] then
      Result:=FormatDateTime(displayformat,TDateTime(Value))
     else
      Result:=widestring(Value);
    end
    else
     Result:=widestring(Value);
    exit;
   end;
  end;
 end;
 atype:=VarType(value);
 if ((atype=271) or (atype=272)) then
  atype:=varDate;
 case atype of
  varEmpty,varNull:
   Result:='';
  varSmallint,varInteger,varByte:
   begin
    if ((Value=0) and (Not printnulls)) then
     Result:=''
    else
    begin
     if length(displayformat)<1 then
      Result:=widestring(Value)
     else
     begin
      if displayformat[1]='*' then
       Result:=FormatCurrAdv(Copy(displayformat,2,Length(displayformat)),Value)
      else
       Result:=FormatFloat(displayformat,Value);
     end;
    end;
   end;
  varWord,varInt64,varLongWord,varShortInt:
   begin
    if ((Value=0) and (Not printnulls)) then
     Result:=''
    else
    begin
     if (paramtype in [rpParamDate,rpParamTime,rpParamDateTime]) then
     begin
      if Length(displayformat)<1 then
      begin
       if paramtype=rpParamDate then
        displayformat:=ShortDateFormat
       else
        if paramtype=rpParamTime then
         displayformat:=ShortTimeFormat
        else
         displayformat:=ShortDateFormat+' '+ShortTimeFormat;
      end;
      Result:=FormatDateTime(displayformat,Value);
     end
     else
     begin
      if length(displayformat)<1 then
       Result:=widestring(Value)
      else
      begin
       if displayformat[1]='*' then
        Result:=FormatCurrAdv(Copy(displayformat,2,Length(displayformat)),Value)
       else
        Result:=FormatFloat(displayformat,Value);
       end;
      end;
     end;
   end;
  varDecimalType:
   begin
    Value:=double(Value);
    if ((Value=0.0) and (Not printnulls)) then
     Result:=''
    else
    begin
     if (paramtype in [rpParamDate,rpParamTime,rpParamDateTime]) then
     begin
      if Length(displayformat)<1 then
      begin
       if paramtype=rpParamDate then
        displayformat:=ShortDateFormat
       else
        if paramtype=rpParamTime then
         displayformat:=ShortTimeFormat
        else
         displayformat:=ShortDateFormat+' '+ShortTimeFormat;
      end;
      Result:=FormatDateTime(displayformat,Value);
     end
     else
     begin
      if length(displayformat)<1 then
       Result:=widestring(Value)
      else
      begin
       if displayformat[1]='*' then
        Result:=FormatCurrAdv(Copy(displayformat,2,Length(displayformat)),Value)
       else
        Result:=FormatFloat(displayformat,Value);
      end;
     end;
    end;
   end;
  varSingle,varDouble:
   begin
    if ((Value=0.0) and (Not printnulls)) then
     Result:=''
    else
    begin
     if (paramtype in [rpParamDate,rpParamTime,rpParamDateTime]) then
     begin
      if Length(displayformat)<1 then
      begin
       if paramtype=rpParamDate then
        displayformat:=ShortDateFormat
       else
        if paramtype=rpParamTime then
         displayformat:=ShortTimeFormat
        else
         displayformat:=ShortDateFormat+' '+ShortTimeFormat;
      end;
      Result:=FormatDateTime(displayformat,Value);
     end
     else
     begin
      if length(displayformat)<1 then
       Result:=widestring(Value)
      else
      begin
       if displayformat[1]='*' then
        Result:=FormatCurrAdv(Copy(displayformat,2,Length(displayformat)),Value)
       else
        Result:=FormatFloat(displayformat,Value);
      end;
     end;
    end;
   end;
  varCurrency:
   begin
    if ((Value=0.0) and (Not printnulls)) then
     Result:=''
    else
    begin
     if length(displayformat)<1 then
      Result:=widestring(Value)
     else
     begin
      if displayformat[1]='*' then
       Result:=FormatCurrAdv(Copy(displayformat,2,Length(displayformat)),Value)
      else
       Result:=FormatCurr(displayformat,Value);
     end;
    end;
   end;
  varDate:
   Result:=FormatDateTime(displayformat,Value);
{$IFNDEF DOTNETD}
  varOleStr,
{$ENDIF}
  varString:
   begin
    if Length(displayformat)>0 then
     Result:=Format(displayformat,[Value])
    else
     Result:=widestring(Value);
   end;
  // Delphi 2009 widestring
  258:
   begin
    if Length(displayformat)>0 then
     Result:=Format(displayformat,[Value])
    else
     Result:=widestring(Value);
   end;
  varBoolean:
   Result:=Format(displayformat,[BoolToStr(Value,true)]);
  else
  begin
{$IFDEF USEBCD}
   if atype=varFmtBCD then
   begin
    Value:=BCDToDouble(VarToBCD(Value));
    if ((Value=0.0) and (not printnulls)) then
     Result:=''
    else
    begin
     if displayformat[1]='*' then
      Result:=FormatCurrAdv(Copy(displayformat,2,Length(displayformat)),Value)
     else
      Result:=FormatFloat(displayformat,Value);
    end;
   end
   else
{$ENDIF}
   begin
    Result:=SRpUnknownType;
   end;
  end;
 end;
 {  varOleStr   = $0008;  varDispatch = $0009;  varError    = $000A;  varVariant  = $000C;  varUnknown  = $000D;  varStrArg   = $0048;  varAny      = $0101;  varTypeMask = $0FFF;  varArray    = $2000;  varByRef    = $4000;}
end;

procedure CheckLoadedPrinterConfig;
var
 systemconfigfilename:string;
 userconfigfilename:string;
 configfilename:string;
begin
 if Not assigned(printerconfigfile) then
 begin
  systemconfigfilename:=Obtainininamecommonconfig('','','reportman');
  userconfigfilename:=Obtainininameuserconfig('','','reportman');
  if FileExists(systemconfigfilename) then
  begin
   configfilename:=systemconfigfilename;
  end
  else
  begin
   configfilename:=userconfigfilename;
  end;
  printerconfigfile:=TMemInifile.Create(configfilename);
 end;
end;

function GetPrinterEscapeOem(printerindex:TRpPrinterSelect):Boolean;
begin
 CheckLoadedPrinterConfig;
 Result:=printerconfigfile.ReadBool('PrinterEscapeOem','Printer'+IntToStr(integer(printerindex)),true);
end;

function GetPrinterEscapeStyleOption(printerindex:TRpPrinterSelect):TRpPrinterEscapeStyle;
var
 adefault:integer;
begin
 CheckLoadedPrinterConfig;
 adefault:=0;
 if (printerindex in [pRpCharacterprinter,pRPTicketPrinter]) then
  adefault:=2;
 adefault:=printerconfigfile.ReadInteger('PrinterEscapeStyle','Printer'+IntToStr(integer(printerindex)),adefault);
 Result:=TRpPrinterEscapeStyle(adefault);
end;

function GetPrinterEscapeStyleDriver(printerindex:TRpPrinterSelect):String;
var
 def:String;
begin
 CheckLoadedPrinterConfig;
 def:='';
 if printerindex=prpTicketPrinter then
  def:='EPSONTMU210'
 else
 if printerindex=prpCharacterPrinter then
  def:='EPSON'
 else
 if printerindex=prpPlainPrinter then
  def:='PLAIN'
 else
 if printerindex=prpPlainFullPrinter then
  def:='PLAINFULL';
 Result:=printerconfigfile.ReadString('PrinterDriver','Printer'+IntToStr(integer(printerindex)),def);
end;


function GetDeviceFontsOption(printerindex:TRpPrinterSelect):boolean;
begin
 CheckLoadedPrinterConfig;
 if printerindex=pRpDefaultPrinter then
 begin
  Result:=printerconfigfile.ReadBool('PrinterFonts','Default',false);
  Exit;
 end;
 Result:=printerconfigfile.ReadBool('PrinterFonts','Printer'+IntToStr(integer(printerindex)),false);
end;

function GetPrinterOemConvertOption(printerindex:TRpPrinterSelect):boolean;
begin
 CheckLoadedPrinterConfig;
 if printerindex=pRpDefaultPrinter then
 begin
  Result:=printerconfigfile.ReadBool('OemConvert','Default',true);
  Exit;
 end;
 Result:=printerconfigfile.ReadBool('OemConvert','Printer'+IntToStr(integer(printerindex)),true);
end;


function GetPrinterConfigName(printerindex:TRpPrinterSelect):string;
begin
 CheckLoadedPrinterConfig;
 if printerindex=pRpDefaultPrinter then
 begin
  Result:='';
  Exit;
 end;
 Result:=printerconfigfile.ReadString('PrinterNames','Printer'+IntToStr(integer(printerindex)),'');
end;

procedure ReloadPrinterConfig;
begin
 printerconfigfile.free;
 printerconfigfile:=nil;
 CHeckLoadedPrinterConfig;
end;

function GetPrinterOffset(printerindex:TRpPrinterSelect):TPoint;
begin
 CheckLoadedPrinterConfig;
 Result.X:=printerconfigfile.ReadInteger('PrinterOffsetX','Printer'+IntToStr(integer(printerindex)),0);
 Result.Y:=printerconfigfile.ReadInteger('PrinterOffsetY','Printer'+IntToStr(integer(printerindex)),0);
end;

// A escape coded string is for example for Epson Tear off
// #27#50#27C#1#12
// That is escape code+ascci(50)...
function EscapeCodedToString(astring:string):string;
var
 index,i:integer;
begin
 astring:=astring+chr(0);
 result:='';
 index:=1;
 while length(astring)>=index do
 begin
   case astring[index] of
    '#':
     begin
      Inc(index);
      I := 0;
      while Ord(astring[index]) in [Ord('0')..Ord('9')] do
      begin
       I := I * 10 + (Ord(astring[index]) - Ord('0'));
       Inc(index);
      end;
      result:=result+Chr(I);
     end;
    chr(0):
     begin
      inc(index);
     end;
   else
    begin
     result:=result+astring[index];
     inc(index);
    end;
  end;
 end;
end;

function RawOpToString(rawop:TPrinterRawOp):String;
var
 Operation:String;
begin
 Operation:='';
 case rawop of
  rawopcutpaper:
   Operation:='CutPaper';
  rawopopendrawer:
   Operation:='OpenDrawer';
  rpescapelinefeed:
   Operation:='LineFeed';
  rpescapecr:
   Operation:='CarrierReturn';
  rpescapeformfeed:
   Operation:='FormFeed';
  rpescapetearoff:
   Operation:='TearOff';
  rpescapeinitprinter:
   Operation:='InitPrinter';
  rpescapeendprint:
   Operation:='EndPrint';
  rpescapepulse:
   Operation:='PulseDrawer';
  rpescaperedfont:
   Operation:='RedFont';
  rpescapeblackfont:
   Operation:='BlackFont';
  rpescapeNormal:
   Operation:='NormalFont';
  rpescapeBold:
   Operation:='BoldFont';
  rpescapeUnderline:
   Operation:='UnderlineFont';
  rpescapeItalic:
   Operation:='ItalicFont';
  rpescapeStrikeOut:
   Operation:='StrikeOutFont';
  rpescape20cpi:
   Operation:='Font20cpi';
  rpescape17cpi:
   Operation:='Font17cpi';
  rpescape15cpi:
   Operation:='Font15cpi';
  rpescape12cpi:
   Operation:='Font12cpi';
  rpescape10cpi:
   Operation:='Font10cpi';
  rpescape6cpi:
   Operation:='Font6cpi';
  rpescape5cpi:
   Operation:='Font5cpi';
 end;
 Result:=Operation;
end;

function PrinterRawOpEnabled(printerindex:TRpPrinterSelect;rawop:TPrinterRawOp):Boolean;
var
 operation:String;
begin
 CheckLoadedPrinterConfig;
 Operation:=RawOpToString(rawop);
 Result:=printerconfigfile.ReadBool(Operation+'On','Printer'+IntToStr(integer(printerindex)),False);
end;



function GetPrinterRawOp(printerindex:TRpPrinterSelect;rawop:TPrinterRawOp):string;
var
 operation:String;
 defaultvalue:string;
begin
 CheckLoadedPrinterConfig;
 Result:='';
 // If active decode and return result
 defaultvalue:='';
 if rawop=rpescapelinefeed then
 begin
  defaultvalue:='#10';
 end;
 if rawop=rawopopendrawer then
 begin
  defaultvalue:='#27#112#0#100#100';
 end;
 if rawop=rpescapecr then
 begin
{$IFDEF MSWINDOWS}
  defaultvalue:='#13';
{$ENDIF}
{$IFDEF LINUX}
  defaultvalue:='';
{$ENDIF}
 end;
 Operation:=RawOpToString(rawop);
 Result:=printerconfigfile.ReadString(Operation,'Printer'+IntToStr(integer(printerindex)),defaultvalue);
 // Transform the string to a real string
 Result:=EscapeCodedToString(Result);
end;

procedure FillTreeDir(adirectory:string;alist:TStringList);
var
 adirlength:integer;

procedure IntFillTreeDir(adir:string);
var
 srec:TSearchRec;
 Attr:Integer;
 ares:Integer;
 sdir:string;
begin
 Attr:=faAnyfile;
 sdir:=adir+C_DIRSEPARATOR+'*.*';
 ares:=FindFirst(sdir,Attr,srec);
 try
  if ares=0 then
  begin
   repeat
    if ((srec.Attr AND faDirectory)>0) then
    begin
     if ((srec.Name<>'.') AND (srec.Name<>'..')) then
     begin
//      alist.Add(Copy(adir,adirlength,Length(adir))+C_DIRSEPARATOR+srec.Name);
      IntFillTreeDir(adir+C_DIRSEPARATOR+srec.Name);
     end;
    end
    else
    begin
     // Only adds the .rep files
     if ExtractFileExt(srec.Name)='.rep' then
      alist.Add(Copy(adir,adirlength+1,Length(adir))+C_DIRSEPARATOR+ChangeFileExt(srec.Name,''));
    end;
   until FindNext(srec)<>0;
  end;
 finally
  if ares=0 then
   FindClose(srec);
 end;
end;

begin
 adirlength:=Length(adirectory)+1;
 IntFillTreeDir(adirectory);
end;

constructor TRpWideStrings.Create;
begin
  inherited Create;
  FWideList := TList.Create;
end;

procedure TRpWideStrings.SetText(avalue:widestring);
var
 astring:string;
 i:integer;
begin
 Clear;
 astring:='';
 i:=1;
 while i<=Length(avalue) do
 begin
  if avalue[i]=#10 then
  begin
   Add(astring);
   if Length(avalue)>i then
    if (avalue[i+1])=#13 then
     Inc(i);
   astring:='';
  end
  else
   astring:=astring+avalue[i];
  inc(i);
 end;
 Add(astring);
end;

function TRpWideStrings.GetText:widestring;
var
 i:integer;
begin
 Result:='';
 if Count>0 then
 begin
  Result:=Result+Strings[0];
  i:=1;
  while i<Count do
  begin
   Result:=Result+#10+Strings[i];
   Inc(i);
  end;
 end;
end;


destructor TRpWideStrings.Destroy;
var
  i: Integer;
begin
  for i := 0 to FWideList.Count-1 do
  begin
    TObject(FWideList.Items[i]).free;
  end;
  FWideList.Free;
  inherited Destroy;
end;

function TRpWideStrings.GetString(Index: Integer): WideString;
var
  PWStr: TRpWString;
begin
  Result := '';
  if ( (Index >= 0) and (Index < FWideList.Count) ) then
  begin
    PWStr := TRpWString(FWideList.Items[Index]);
    Result := PWStr.WString;
  end;
end;

procedure TRpWideStrings.PutString(Index: Integer; const S: WideString);
begin
  Insert(Index,S);
end;

function TRpWideStrings.Add(const S: WideString): Integer;
var
  PWStr:TRpWString;
begin
  PWStr:=TRpWString.Create;
  PWStr.WString := S;
  Result := FWideList.Add(PWStr);
end;

function TRpWideStrings.Count: Integer;
begin
  Result := FWideList.Count;
end;


procedure TRpWideStrings.AssignTo(destination:TPersistent);
var
 alist:TStrings;
 i:integer;
 wlist:TRpWideStrings;
begin
 if destination is TStrings then
 begin
  alist:=TStrings(destination);
  alist.clear;
  for i:=0 to count-1 do
  begin
   alist.Add(Strings[i]);
  end;
 end
 else
 if destination is TRpWideStrings then
 begin
  wlist:=TRpWideStrings(destination);
  wlist.clear;
  for i:=0 to count-1 do
  begin
   wlist.Add(Strings[i]);
  end;
 end
 else
  inherited AssignTo(destination);
end;

function TRpWideStrings.IndexOf(name:WideString):integer;
var
 i:integer;
begin
 Result:=-1;
 for i:=0 to Count-1 do
 begin
  if name=Strings[i] then
  begin
   Result:=i;
   break;
  end;
 end;
end;


procedure TRpWideStrings.Clear;
var
  i: Integer;
  PWStr: TRpWString;
begin
  for i:=0 to FWideList.Count-1 do
  begin
    PWStr := TRpWString(FWideList.Items[i]);
    PWStr.free;
  end;
  FWideList.Clear;
end;

procedure TRpWideStrings.Insert(Index: Integer; const S: WideString);
var
  PWStr: TRpWString;
begin
  if((Index < 0) or (Index > FWideList.Count)) then
    raise Exception.Create(SRpIndexOutOfBounds);
  if Index < FWideList.Count then
  begin
    PWStr := TRpWString(FWideList.Items[Index]);
    if PWStr <> nil then
      PWStr.WString := S;
  end
  else
    Add(S);
end;

{$IFDEF MSWINDOWS}
function IsWindowsNT:Boolean;
begin
{$IFNDEF DOTNETD}
 try
  if Not obtainedversion then
  begin
   osinfo.dwOSVersionInfoSize:=sizeof(osinfo);
   if Not GetVersionEx(osinfo) then
    RaiseLastOsError;
   obtainedversion:=True;
  end;
  Result:=osinfo.dwPlatformId=VER_PLATFORM_WIN32_NT;
 except
  on E:Exception do
  begin
   E.Message:=E.Message+' - VersionEx';
   raise;
  end;
 end;
{$ENDIF}
{$IFDEF DOTNETD}
//  osinfo.dwOSVersionInfoSize:=sizeof(osinfo);
//  System.Console.WriteLine(osinfo.dwOSVersionInfoSize);
//  if Not GetVersionEx(osinfo) then
// GetVersionEx does not return the required size
//   System.Console.WriteLine(osinfo.dwOSVersionInfoSize);
 Result:=true;
{$ENDIF}
end;
{$ENDIF}


procedure WriteWideString(Writer:TWriter;Value:WideString);
{$IFDEF DOTNETD}
var
  L: Integer;
  aval:TValueType;
  Utf8Bytes: TBytes;

  function StringToWideBytes(const Value: string): TBytes;
  var
    I: Integer;
  begin
    SetLength(Result, Length(Value) * 2);
    for I := 0 to Length(Value) - 1 do
    begin
      Result[I * 2] := Byte(Value[I]);
      Result[I * 2 + 1] := Byte((Word(Value[I]) shr 8) and $FF);
    end;
  end;


begin
 aval:=vaWString;
 Writer.Write(Byte(aval), SizeOf(aval));
 Utf8Bytes := StringToWideBytes(Value);
 L := Length(Utf8Bytes);
 Writer.Write(L, SizeOf(Integer));
 Writer.Write(Utf8Bytes, L);
end;
{$ENDIF}
{$IFNDEF DOTNETD}
var
  L: Integer;
  aval:TValueType;
begin
 aval:=vaWString;
{$IFDEF FPC}
// Writer.Write(aval);
// L := Length(Value);
// Writer.Write(L, SizeOf(Integer));
// Writer.Write(Pointer(Value)^, L * 2);
{$ENDIF}
{$IFNDEF FPC}
 Writer.Write(aval,SizeOf(aval));
 L := Length(Value);
 Writer.Write(L, SizeOf(Integer));
 Writer.Write(Pointer(Value)^, L * 2);
{$ENDIF}
end;
{$ENDIF}



{$IFNDEF USEVARIANTS}
type
  UTF8String = type string;

function Utf8ToUnicode(Dest: PWideChar; MaxDestChars: Cardinal; Source: PChar; SourceBytes: Cardinal): Cardinal;
var
  i, count: Cardinal;
  c: Byte;
  wc: Cardinal;
begin
  if Source = nil then
  begin
    Result := 0;
    Exit;
  end;
  Result := Cardinal(-1);
  count := 0;
  i := 0;
  if Dest <> nil then
  begin
    while (i < SourceBytes) and (count < MaxDestChars) do
    begin
      wc := Cardinal(Source[i]);
      Inc(i);
      if (wc and $80) <> 0 then
      begin
        if i >= SourceBytes then Exit;          // incomplete multibyte char
        wc := wc and $3F;
        if (wc and $20) <> 0 then
        begin
          c := Byte(Source[i]);
          Inc(i);
          if (c and $C0) <> $80 then Exit;      // malformed trail byte or out of range char
          if i >= SourceBytes then Exit;        // incomplete multibyte char
          wc := (wc shl 6) or (c and $3F);
        end;
        c := Byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then Exit;       // malformed trail byte

        Dest[count] := WideChar((wc shl 6) or (c and $3F));
      end
      else
        Dest[count] := WideChar(wc);
      Inc(count);
    end;
    if count >= MaxDestChars then count := MaxDestChars-1;
    Dest[count] := #0;
  end
  else
  begin
    while (i < SourceBytes) do
    begin
      c := Byte(Source[i]);
      Inc(i);
      if (c and $80) <> 0 then
      begin
        if i >= SourceBytes then Exit;          // incomplete multibyte char
        c := c and $3F;
        if (c and $20) <> 0 then
        begin
          c := Byte(Source[i]);
          Inc(i);
          if (c and $C0) <> $80 then Exit;      // malformed trail byte or out of range char
          if i >= SourceBytes then Exit;        // incomplete multibyte char
        end;
        c := Byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then Exit;       // malformed trail byte
      end;
      Inc(count);
    end;
  end;
  Result := count+1;
end;

function Utf8Decode(const S: UTF8String): WideString;
var
  L: Integer;
  Temp: WideString;
begin
  Result := '';
  if S = '' then Exit;
  SetLength(Temp, Length(S));

  L := Utf8ToUnicode(PWideChar(Temp), Length(Temp)+1, PChar(S), Length(S));
  if L > 0 then
    SetLength(Temp, L-1)
  else
    Temp := '';
  Result := Temp;
end;
{$ENDIF}

function ReadWideString(Reader:TReader):WideString;
{$IFDEF DELPHI2009UP}
begin
 Result:=Reader.ReadWideString;
end;
{$ENDIF}
{$IFNDEF DELPHI2009UP}
var
  L: Integer;
  aResult:String;
  avalue:TValueType;
begin
{$IFNDEF FPC}
  L := 0;
  avalue:=Reader.ReadValue;
  if  avalue<> vaWString then
  begin
   case Integer(avalue) of
    Integer(vaString):
     begin
      Reader.Read(L, SizeOf(Byte));
      SetString(aResult, PChar(nil), L);
      Reader.Read(Pointer(aResult)^, L);
      Result:=aResult;
     end;
    Integer(vaLString):
     begin
      Reader.Read(L, SizeOf(Integer));
      SetString(aResult, PChar(nil), L);
      Reader.Read(Pointer(aResult)^, L);
      Result:=aResult;
     end;
{$IFDEF USEVARIANTS}
    Integer(vaUTF8String):
{$ENDIF}
{$IFNDEF USEVARIANTS}
    20:
{$ENDIF}
     begin
      Reader.Read(L, SizeOf(Integer));
      SetString(aResult, PChar(nil), L);
      Reader.Read(Pointer(aResult)^, L);
      Result:=Utf8Decode(aResult);
     end;
    else
    begin
     Raise EReadError.Create(SInvalidPropertyValue);
    end;
   end;
  end
  else
  begin
   Reader.Read(L, SizeOf(Integer));
   SetLength(Result, L);
   Reader.Read(Pointer(Result)^, L * 2);
  end;
{$ENDIF}
end;
{$ENDIF}


function WideStringToDOS(astring:WideString):WideString;
var
 i:integer;
 along:integer;
begin
 Result:='';
 i:=1;
 along:=Length(astring);
 while i<=along do
 begin
  // ignore #13
  while Ord(astring[i])=13 do
  begin
   inc(i);
   if i>along then
    exit;
  end;
  // Adds lines
  while Ord(astring[i])=10 do
  begin
   inc(i);
   Result:=Result+WideChar(13)+WideChar(10);
   if i>along then
    exit;
  end;
  if (Ord(astring[i])<>13) then
  begin
   Result:=Result+astring[i];
  end;
  inc(i);
 end;
end;



// Function cortesy of Hamza Al-Aradi (AradBox@hotmail.com)
// Altered to support negative and not show fractionary
// when there is not fractionary part
function NumberToTextEnglish(Amount:currency):WideString;
var
 Num : LongInt;
 Fracture : Integer;

 function Num2Str(Num: LongInt): String;
 Const hundred = 100;
       thousand = 1000;
       million = 1000000;
       billion = 1000000000;
  begin
    if Num >= billion then
      if (Num mod billion) = 0 then
        Num2Str := Num2Str(Num div billion) + ' Billion'
      else
        Num2Str := Num2Str(Num div billion) + ' Billion ' +
                   Num2Str(Num mod billion)
    else
      if Num >= million then
        if (Num mod million) = 0 then
          Num2Str := Num2Str(Num div million) + ' Million'
        else
          Num2Str := Num2Str(Num div million) + ' Million ' +
                     Num2Str(Num mod million)
      else
        if Num >= thousand then
          if (Num mod thousand) = 0 then
            Num2Str := Num2Str(Num div thousand) + ' Thousand'
          else
            Num2Str := Num2Str(Num div thousand) + ' Thousand ' +
                       Num2Str(Num mod thousand)
        else
          if Num >= hundred then
            if (Num mod hundred) = 0 then
              Num2Str := Num2Str(Num div hundred) + ' Hundred'
            else
              Num2Str := Num2Str(Num div  hundred) + ' Hundred ' +
                         Num2Str(Num mod hundred)
          else
          case (Num div 10) of
         6,7,9: if (Num mod 10) = 0 then
                   Num2Str := Num2Str(Num div 10) + 'ty'
                 else
                   Num2Str := Num2Str(Num div 10) + 'ty-' +
                              Num2Str(Num mod 10);
              8: if Num = 80 then
                   Num2Str := 'Eighty'
                 else
                   Num2Str := 'Eighty-' + Num2Str(Num mod 10);
              5: if Num = 50 then
                   Num2Str := 'Fifty'
                 else
                   Num2Str := 'Fifty-' + Num2Str(Num mod 10);
              4: if Num = 40 then
                   Num2Str := 'Forty'
                 else
                   Num2Str := 'Forty-' + Num2Str(Num mod 10);
              3: if Num = 30 then
                   Num2Str := 'Thirty'
                 else
                   Num2Str := 'Thirty-' + Num2Str(Num mod 10);
              2: if Num = 20 then
                   Num2Str := 'Twenty'
                 else
                   Num2Str := 'Twenty-' + Num2Str(Num mod 10);
            0,1: case Num of
                    0: Num2Str := 'Zero';
                    1: Num2Str := 'One';
                    2: Num2Str := 'Two';
                    3: Num2Str := 'Three';
                    4: Num2Str := 'Four';
                    5: Num2Str := 'Five';
                    6: Num2Str := 'Six';
                    7: Num2Str := 'Seven';
                    8: Num2Str := 'Eight';
                    9: Num2Str := 'Nine';
                   10: Num2Str := 'Ten';
                   11: Num2Str := 'Eleven';
                   12: Num2Str := 'Twelve';
                   13: Num2Str := 'Thirteen';
                   14: Num2Str := 'Fourteen';
                   15: Num2Str := 'Fifteen';
                   16: Num2Str := 'Sixteen';
                   17: Num2Str := 'Seventeen';
                   18: Num2Str := 'Eightteen';
                   19: Num2Str := 'Nineteen'
                 end
          end
 end {Num2Str};

begin
 Num:= Trunc(Abs(Amount));
 Fracture:= Round(1000*Frac(Abs(Amount)));
 Result := Num2Str(Num);
 if Fracture > 0 then
   Result := Result + ' and '+IntToStr(Fracture) + '/1000';
end;

{$IFNDEF DOTNETD}
function NumberToTextLithuanian(Amount : currency; Female : boolean = false) : WideString;
//..............................................................................
function Num2Str(Num : Int64; gimine : boolean = false; flag : integer = 0) : string;
// Made by Antanas Vipartas :))
Const
	hundred = 100;
	Thousand = 1000;
	Million = 1000000;
	billion = 1000000000;
	trillion = 1000000000000;
begin
	// ---------------------- T R I L I J O N A I
	if Num >= trillion then
		if (Num mod trillion) = 0 then begin // jei dalinasi is trilijono be liekanos (yra kazkiek milijardu lygiai)
			if ((Num div trillion) < 10) then begin
				case (Num div trillion) of
					1 : Num2Str := Num2Str(Num div trillion) + ' trilijonas';
					2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div trillion) + ' trilijonai';
				end;
			end
			else
			if (((Num div trillion) < 20) and (Num div trillion > 9)) then
				Num2Str := Num2Str(Num div trillion) + ' trilijonø'
			else
			if (Num div trillion >= 20) then begin
				if (((Num div trillion > 110) and (Num div trillion < 120)) or
				   ((Num div trillion > 210) and (Num div trillion < 220)) or
				   ((Num div trillion > 310) and (Num div trillion < 320)) or
				   ((Num div trillion > 410) and (Num div trillion < 420)) or
				   ((Num div trillion > 510) and (Num div trillion < 520)) or
				   ((Num div trillion > 610) and (Num div trillion < 620)) or
				   ((Num div trillion > 710) and (Num div trillion < 720)) or
				   ((Num div trillion > 810) and (Num div trillion < 820)) or
				   ((Num div trillion > 910) and (Num div trillion < 920))) then
				begin
					Num2Str := Num2Str(Num div trillion) + ' trilijonø';
				end
				else begin
					case ((Num div trillion) mod 10) of
						0 : Num2Str := Num2Str(Num div trillion) + ' trilijonø';
						1 : Num2Str := Num2Str(Num div trillion) + ' trilijonas';
						2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div trillion) + ' trilijonai';
					end;
				end;
			end
		end
		else begin // jei is milijardo dalinasi su liekanos
			if ((Num div trillion) < 10) then begin
				case (Num div trillion) of
					1 : Num2Str := Num2Str(Num div trillion) + ' trilijonas ' + Num2Str(Num mod trillion, gimine, 1);
					2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div trillion) + ' trilijonai ' + Num2Str(Num mod trillion, gimine, 1);
				end;
			end
			else
			if (((Num div trillion) < 20) and (Num div trillion > 9)) then
				Num2Str := Num2Str(Num div trillion) + ' trilijonø ' + Num2Str(Num mod trillion, gimine, 1)
			else
			if (Num div trillion >= 20) then begin
				if (((Num div trillion > 110) and (Num div trillion < 120)) or
				   ((Num div trillion > 210) and (Num div trillion < 220)) or
				   ((Num div trillion > 310) and (Num div trillion < 320)) or
				   ((Num div trillion > 410) and (Num div trillion < 420)) or
				   ((Num div trillion > 510) and (Num div trillion < 520)) or
				   ((Num div trillion > 610) and (Num div trillion < 620)) or
				   ((Num div trillion > 710) and (Num div trillion < 720)) or
				   ((Num div trillion > 810) and (Num div trillion < 820)) or
				   ((Num div trillion > 910) and (Num div trillion < 920))) then
				begin
					Num2Str := Num2Str(Num div trillion) + ' trilijonø ' + Num2Str(Num mod trillion, gimine, 1);
				end
				else begin
					case ((Num div trillion) mod 10) of
						0 : Num2Str := Num2Str(Num div trillion) + ' trilijonø ' + Num2Str(Num mod trillion, gimine, 1);
						1 : Num2Str := Num2Str(Num div trillion) + ' trilijonas ' + Num2Str(Num mod trillion, gimine, 1);
						2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div trillion) + ' trilijonai ' + Num2Str(Num mod trillion, gimine, 1);
					end;
				end;
			end;
		end
	else
	// ---------------------- M I L I J A R D A I
	if Num >= billion then
		if (Num mod billion) = 0 then begin // jei dalinasi is milijardo be liekanos (yra kazkiek milijardu lygiai)
			if ((Num div billion) < 10) then begin
				case (Num div billion) of
					1 : Num2Str := Num2Str(Num div billion) + ' milijardas';
					2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div billion) + ' milijardai';
				end;
			end
			else
			if (((Num div billion) < 20) and (Num div billion > 9)) then
				Num2Str := Num2Str(Num div billion) + ' milijardø'
			else
			if (Num div billion >= 20) then begin
				if (((Num div billion > 110) and (Num div billion < 120)) or
				   ((Num div billion > 210) and (Num div billion < 220)) or
				   ((Num div billion > 310) and (Num div billion < 320)) or
				   ((Num div billion > 410) and (Num div billion < 420)) or
				   ((Num div billion > 510) and (Num div billion < 520)) or
				   ((Num div billion > 610) and (Num div billion < 620)) or
				   ((Num div billion > 710) and (Num div billion < 720)) or
				   ((Num div billion > 810) and (Num div billion < 820)) or
				   ((Num div billion > 910) and (Num div billion < 920))) then
				begin
					Num2Str := Num2Str(Num div billion) + ' milijardø';
				end
				else begin
					case ((Num div billion) mod 10) of
						0 : Num2Str := Num2Str(Num div billion) + ' milijardø';
						1 : Num2Str := Num2Str(Num div billion) + ' milijardas';
						2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div billion) + ' milijardai';
					end;
				end;
			end
		end
		else begin // jei is milijardo dalinasi su liekanos
			if ((Num div billion) < 10) then begin
				case (Num div billion) of
					1 : Num2Str := Num2Str(Num div billion) + ' milijardas ' + Num2Str(Num mod billion, gimine, 1);
					2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div billion) + ' milijardai ' + Num2Str(Num mod billion, gimine, 1);
				end;
			end
			else
			if (((Num div billion) < 20) and (Num div billion > 9)) then
				Num2Str := Num2Str(Num div billion) + ' milijardø ' + Num2Str(Num mod billion, gimine, 1)
			else
			if (Num div billion >= 20) then begin
				if (((Num div billion > 110) and (Num div billion < 120)) or
				   ((Num div billion > 210) and (Num div billion < 220)) or
				   ((Num div billion > 310) and (Num div billion < 320)) or
				   ((Num div billion > 410) and (Num div billion < 420)) or
				   ((Num div billion > 510) and (Num div billion < 520)) or
				   ((Num div billion > 610) and (Num div billion < 620)) or
				   ((Num div billion > 710) and (Num div billion < 720)) or
				   ((Num div billion > 810) and (Num div billion < 820)) or
				   ((Num div billion > 910) and (Num div billion < 920))) then
				begin
					Num2Str := Num2Str(Num div billion) + ' milijardø ' + Num2Str(Num mod billion, gimine, 1);
				end
				else begin
					case ((Num div billion) mod 10) of
						0 : Num2Str := Num2Str(Num div billion) + ' milijardø ' + Num2Str(Num mod billion, gimine, 1);
						1 : Num2Str := Num2Str(Num div billion) + ' milijardas ' + Num2Str(Num mod billion, gimine, 1);
						2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div billion) + ' milijardai ' + Num2Str(Num mod billion, gimine, 1);
					end;
				end;
			end;
		end
	else
	// ---------------------- M I L I J O N A I
	if Num >= Million then
		if (Num mod Million) = 0 then begin // jei dalinasi is milijono be liekanos (yra kazkiek milijonu lygiai)
			if ((Num div Million) < 10) then begin
				case (Num div Million) of
					1 : Num2Str := Num2Str(Num div Million) + ' milijonas';
					2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div Million) + ' milijonai';
				end;
			end
			else
			if (((Num div Million) < 20) and (Num div Million > 9)) then
				Num2Str := Num2Str(Num div Million) + ' milijonø'
			else
			if (Num div Million >= 20) then begin
				if (((Num div Million > 110) and (Num div Million < 120)) or
				   ((Num div Million > 210) and (Num div Million < 220)) or
				   ((Num div Million > 310) and (Num div Million < 320)) or
				   ((Num div Million > 410) and (Num div Million < 420)) or
				   ((Num div Million > 510) and (Num div Million < 520)) or
				   ((Num div Million > 610) and (Num div Million < 620)) or
				   ((Num div Million > 710) and (Num div Million < 720)) or
				   ((Num div Million > 810) and (Num div Million < 820)) or
				   ((Num div Million > 910) and (Num div Million < 920))) then
				begin
					Num2Str := Num2Str(Num div Million) + ' milijonø';
				end
				else begin
					case ((Num div Million) mod 10) of
						0 : Num2Str := Num2Str(Num div Million) + ' milijonø';
						1 : Num2Str := Num2Str(Num div Million) + ' milijonas';
						2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div Million) + ' milijonai';
					end;
				end;
			end;
		end
		else begin // is milijono dalinasi su liekana
			if ((Num div Million) < 10) then begin
				case (Num div Million) of
					1 : Num2Str := Num2Str(Num div Million) + ' milijonas ' + Num2Str(Num mod million, gimine, 1);
					2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div Million) + ' milijonai ' + Num2Str(Num mod million, gimine, 1);
				end;
			end
			else
			if (((Num div Million) < 20) and (Num div Million > 9)) then
				Num2Str := Num2Str(Num div Million) + ' milijonø ' + Num2Str(Num mod Million, gimine, 1)
			else
			if (Num div Million >= 20) then begin
				if (((Num div Million > 110) and (Num div Million < 120)) or
				   ((Num div Million > 210) and (Num div Million < 220)) or
				   ((Num div Million > 310) and (Num div Million < 320)) or
				   ((Num div Million > 410) and (Num div Million < 420)) or
				   ((Num div Million > 510) and (Num div Million < 520)) or
				   ((Num div Million > 610) and (Num div Million < 620)) or
				   ((Num div Million > 710) and (Num div Million < 720)) or
				   ((Num div Million > 810) and (Num div Million < 820)) or
				   ((Num div Million > 910) and (Num div Million < 920))) then
				begin
					Num2Str := Num2Str(Num div Million) + ' milijonø ' + Num2Str(Num mod Million, gimine, 1);
				end
				else begin
					case ((Num div Million) mod 10) of
						0 : Num2Str := Num2Str(Num div Million) + ' milijonø ' + Num2Str(Num mod Million, gimine, 1);
						1 : Num2Str := Num2Str(Num div Million) + ' milijonas ' + Num2Str(Num mod Million, gimine, 1);
						2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div Million) + ' milijonai ' + Num2Str(Num mod Million, gimine, 1);
					end;
				end;
			end;
		end
	else
	// ---------------------- T U K S T A N C I A I
	if Num >= Thousand then
		if (Num mod Thousand) = 0 then begin // Jei dalinasi is tuksntancio be liekanos
			if ((Num div Thousand) < 10) then begin
				case (Num div Thousand) of
					1 : Num2Str := Num2Str(Num div Thousand) + ' tûkstantis';
					2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div Thousand) + ' tûkstanèiai';
				end;
			end
			else
			if (((Num div Thousand) < 20) and (Num div Thousand > 9)) then
				Num2Str := Num2Str(Num div Thousand) + ' tûkstanèiø'
			else
			if (Num div Thousand >= 20) then begin
				if (((Num div Thousand > 110) and (Num div Thousand < 120)) or
				   ((Num div Thousand > 210) and (Num div Thousand < 220)) or
				   ((Num div Thousand > 310) and (Num div Thousand < 320)) or
				   ((Num div Thousand > 410) and (Num div Thousand < 420)) or
				   ((Num div Thousand > 510) and (Num div Thousand < 520)) or
				   ((Num div Thousand > 610) and (Num div Thousand < 620)) or
				   ((Num div Thousand > 710) and (Num div Thousand < 720)) or
				   ((Num div Thousand > 810) and (Num div Thousand < 820)) or
				   ((Num div Thousand > 910) and (Num div Thousand < 920))) then
				begin
					Num2Str := Num2Str(Num div Thousand) + ' tûkstanèiø';
				end
				else begin
					case ((Num div Thousand) mod 10) of
						0 : Num2Str := Num2Str(Num div Thousand) + ' tûkstanèiø';
						1 : Num2Str := Num2Str(Num div Thousand) + ' tûkstantis';
						2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div Thousand) + ' tûkstanèiai';
					end;
				end
			end
		end
		else begin // is tûkstanèio dalinasi su liekana
			if ((Num div Thousand) < 10) then begin
				case (Num div Thousand) of
					1 : Num2Str := Num2Str(Num div Thousand) + ' tûkstantis ' + Num2Str(Num mod Thousand, gimine, 1);
					2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div Thousand) + ' tûkstanèiai ' + Num2Str(Num mod Thousand, gimine, 1);
				end;
			end
			else
			if (((Num div Thousand) < 20) and (Num div Thousand > 9)) then
				Num2Str := Num2Str(Num div Thousand) + ' tûkstanèiø ' + Num2Str(Num mod Thousand, gimine, 1)
			else
			if (Num div Thousand >= 20) then begin
				if (((Num div Thousand > 110) and (Num div Thousand < 120)) or
				   ((Num div Thousand > 210) and (Num div Thousand < 220)) or
				   ((Num div Thousand > 310) and (Num div Thousand < 320)) or
				   ((Num div Thousand > 410) and (Num div Thousand < 420)) or
				   ((Num div Thousand > 510) and (Num div Thousand < 520)) or
				   ((Num div Thousand > 610) and (Num div Thousand < 620)) or
				   ((Num div Thousand > 710) and (Num div Thousand < 720)) or
				   ((Num div Thousand > 810) and (Num div Thousand < 820)) or
				   ((Num div Thousand > 910) and (Num div Thousand < 920))) then
				begin
					Num2Str := Num2Str(Num div Thousand) + ' tûkstanèiø ' + Num2Str(Num mod Thousand, gimine, 1);
				end
				else begin
					case ((Num div Thousand) mod 10) of
						0 : Num2Str := Num2Str(Num div Thousand) + ' tûkstanèiø ' + Num2Str(Num mod Thousand, gimine, 1);
						1 : Num2Str := Num2Str(Num div Thousand) + ' tûkstantis ' + Num2Str(Num mod Thousand, gimine, 1);
						2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div Thousand) + ' tûkstanèiai ' + Num2Str(Num mod Thousand, gimine, 1);
					end;
				end;
			end;
		end
	else
	// ---------------------- S I M T A I
	if Num >= hundred then
		if (Num mod hundred) = 0 then begin // Jei dalinasi is simto be liekanos
			case (Num div hundred) of
				1 : Num2Str := Num2Str(Num div hundred) + ' ðimtas';
				2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div hundred) + ' ðimtai';
			end;
		end
		else begin
			case (Num div hundred) of
				1 : Num2Str := Num2Str(Num div hundred) + ' ðimtas ' + Num2Str(Num mod hundred, gimine, 1);
				2,3,4,5,6,7,8,9 : Num2Str := Num2Str(Num div hundred) + ' ðimtai ' + Num2Str(Num mod hundred, gimine, 1);
			end;
		end
	// ---------------------- D E S I M T Y S
	else begin
		case (Num div 10) of
			9: 	if Num = 90 then
					Num2Str := 'devyniasdeðimt'
				else
					Num2Str := 'devyniasdeðimt ' + Num2Str(Num mod 10, gimine, 1);
			8: 	if Num = 80 then
					Num2Str := 'aðtuoniasdeðimt'
				else
					Num2Str := 'aðtuoniasdeðimt ' + Num2Str(Num mod 10, gimine, 1);
			7: 	if Num = 70 then
					Num2Str := 'septyniasdeðimt'
				else
					Num2Str := 'septyniasdeðimt ' + Num2Str(Num mod 10, gimine, 1);
			6: 	if Num = 60 then
					Num2Str := 'ðeðiasdeðimt'
				else
					Num2Str := 'ðeðiasdeðimt ' + Num2Str(Num mod 10, gimine, 1);
			5: 	if Num = 50 then
					Num2Str := 'penkiasdeðimt'
				else
					Num2Str := 'penkiasdeðimt ' + Num2Str(Num mod 10, gimine, 1);
			4: 	if Num = 40 then
					Num2Str := 'keturiasdeðimt'
				else
					Num2Str := 'keturiasdeðimt ' + Num2Str(Num mod 10, gimine, 1);
			3: 	if Num = 30 then
					Num2Str := 'trisdeðimt'
				else
					Num2Str := 'trisdeðimt ' + Num2Str(Num mod 10, gimine, 1);
			2: 	if Num = 20 then
					Num2Str := 'dvideðimt'
				else
					Num2Str := 'dvideðimt ' + Num2Str(Num mod 10, gimine, 1);
			0,1: if gimine and (flag = 1) then begin // moteriska gimine ir jau pabaiga
				case Num of
						0: Num2Str := 'nulis';
						1: Num2Str := 'viena';
						2: Num2Str := 'dvi';
						3: Num2Str := 'trys';
						4: Num2Str := 'keturios';
						5: Num2Str := 'penkios';
						6: Num2Str := 'ðeðios';
						7: Num2Str := 'septynios';
						8: Num2Str := 'aðtuonios';
						9: Num2Str := 'devynios';
						10: Num2Str := 'deðimt';
						11: Num2Str := 'vienuolika';
						12: Num2Str := 'dvylika';
						13: Num2Str := 'trylika';
						14: Num2Str := 'keturiolika';
						15: Num2Str := 'penkiolika';
						16: Num2Str := 'ðeðiolika';
						17: Num2Str := 'septyniolika';
						18: Num2Str := 'aðtuoniolika';
						19: Num2Str := 'devyniolika'
				end
			end
				else begin // vyriska gimine (arba moteriska gimine bet nera skirtumo nes pradzia)
				case Num of
						0: Num2Str := 'nulis';
						1: Num2Str := 'vienas';
						2: Num2Str := 'du';
						3: Num2Str := 'trys';
						4: Num2Str := 'keturi';
						5: Num2Str := 'penki';
						6: Num2Str := 'ðeði';
						7: Num2Str := 'septyni';
						8: Num2Str := 'aðtuoni';
						9: Num2Str := 'devyni';
						10: Num2Str := 'deðimt';
						11: Num2Str := 'vienuolika';
						12: Num2Str := 'dvylika';
						13: Num2Str := 'trylika';
						14: Num2Str := 'keturiolika';
						15: Num2Str := 'penkiolika';
						16: Num2Str := 'ðeðiolika';
						17: Num2Str := 'septyniolika';
						18: Num2Str := 'aðtuoniolika';
						19: Num2Str := 'devyniolika'
				end;
			end;
		end;
	end;
end {Num2Str};
//..............................................................................
begin
	Result := Num2Str(Trunc(Abs(Amount)), Female);
	if (copy(Result, 1,1) = 'ð') then begin
		 Result := 'Ð' + copy(Result, 2, length(Result));
	end
	else begin
		Result := UpperCase(copy(Result,1,1)) + Copy(Result,2, length(Result));
	end;
end;



function NumberToTextPortuguese(FNumero:currency):WideString;
    function ReplaceSubstring( StringAntiga, StringNova, s : string ) :
string;
      var p : word;
    begin
       repeat
         p := Pos( StringAntiga, s );
         if p > 0 then begin
            Delete( s, p, Length( StringAntiga ) );
            Insert( StringNova, s, p );
         end;
       until p = 0;
       ReplaceSubstring := s;
    end;


    { Esta é a função que gera os blocos de extenso que depois serão
montados }
    function Extenso3em3( Numero : Word ) : string;
      const Valores : array[1..36] of word = ( 1, 2, 3, 4, 5, 6, 7, 8, 9,
              10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 30, 40, 50, 60,
              70, 80, 90,100, 200, 300, 400, 500, 600, 700, 800, 900 );
            Nomes : array[0..36] of string[12] = ( '', 'um', 'dois', 'três',
  'quatro','cinco', 'seis', 'sete', 'oito', 'nove', 'dez',
  'onze','doze', 'treze', 'quatorze', 'quinze','dezesseis',
  'dezessete', 'dezoito', 'dezenove', 'vinte','trinta',
  'quarenta', 'cinquenta', 'sessenta', 'setenta','oitenta',
  'noventa', 'cento', 'duzentos', 'trezentos','quatrocentos',
  'quinhentos', 'seiscentos', 'setecentos','oitocentos',
                           'novecentos' );
      var i         : byte;
          Resposta  : string;
          Inteiro   : word;
          Resto     : word;
    begin
      Inteiro   := Numero;
      Resposta  := '';

      for i := 36 downto 1 do begin
          Resto := ( Inteiro div valores[i] ) * valores[i];
          if ( Resto = valores[i] ) and ( Inteiro >= Resto ) then begin
             Resposta := Resposta + Nomes[i] + ' e ';
             Inteiro  := Inteiro - Valores[i];
          end;
      end;

      { Corta o 'E' excedente do final da string }
      Extenso3em3 := Copy( Resposta, 1, Length( Resposta ) - 3 );
    end;


    {
      A função extenso divide os números em grupos de três e chama a função
      extenso3em3 para o obter extenso de cada parte e armazená-los no vetor
      Resposta.
    }
    function Extenso( Numero : extended ) : string;
      const NoSingular : array[1..6] of string = ( 'trilhão', 'bilhão',
'milhão', 'mil', '', '');
                                                  // 'REAL', 'CENTAVO' );
            NoPlural   : array[1..6] of string = ( 'trilhões', 'bilhões',
'milhões', 'mil', '', '');
                                                  // 'REAIS', 'CENTAVOS' );
            {
              Estas constantes facilitam o entendimento do código.
              Como os valores de singular e plural são armazenados em um
vetor,
              cada posicao indica a grandeza do número armazenado (leia-se
sempre
              da esquerda para a direita).
            }
            CasaDosTrilhoes = 1;
            CasaDosBilhoes  = CasaDosTrilhoes + 1;
            CasaDosMilhoes  = CasaDosBilhoes  + 1;
            CasaDosMilhares = CasaDosMilhoes  + 1;
            CasaDasCentenas = CasaDosMilhares + 1;
            CasaDosCentavos = CasaDasCentenas + 1;

      var TrioAtual,
          TrioPosterior : byte;
          v             : integer; { usada apenas com o Val }
          Resposta      : array[CasaDosTrilhoes..CasaDosCentavos] of string;
          RespostaN     : array[CasaDosTrilhoes..CasaDosCentavos] of word;
          Plural        : array[CasaDosTrilhoes..CasaDosCentavos] of
boolean;
          Inteiro       : extended;
          NumStr        : string;
          TriosUsados   : set of CasaDosTrilhoes..CasaDosCentavos;
          NumTriosInt   : byte;

      { Para os não pascalistas de tradição, observe o uso de uma função
        encapsulada na outra. }
      function ProximoTrio( i : byte ) : byte;
      begin
         repeat
           Inc( i );
         until ( i in TriosUsados ) or ( i >= CasaDosCentavos );
         ProximoTrio := i;
      end;

    begin
      Inteiro  := Int( Numero * 100 );

      { Inicializa os vetores }
      for TrioAtual := CasaDosTrilhoes to CasaDosCentavos do begin
           Resposta[TrioAtual] := '';
           Plural[TrioAtual]   := False;
      end;

      {
        O número é quebrado em partes distintas, agrupadas de três em três
casas:
        centenas, milhares, milhões, bilhões e trilhões. A última parte (a
sexta)
        contém apenas os centavos, com duas casas
      }
      Str( Inteiro : 17 : 0, NumStr );
      TrioAtual    := 1;
      Inteiro      := Int( Inteiro / 100 ); { remove os centavos }

      { Preenche os espaços vazios com zeros para evitar erros de conversão
}
      while NumStr[TrioAtual] = ' ' do begin
         NumStr[TrioAtual] := '0';
         Inc( TrioAtual );
      end;

      { Inicializa o conjunto como vazio }
      TriosUsados := [];
      NumTriosInt := 0; { Números de trios da parte inteira (sem os
centavos) }

      { Este loop gera os extensos de cada parte do número }
      for TrioAtual := CasaDosTrilhoes to CasaDosCentavos do begin
      Val( Copy( NumStr, 3 * TrioAtual - 2, 3 ), RespostaN[TrioAtual], v );
          if RespostaN[TrioAtual] <> 0 then begin
             Resposta[TrioAtual] := Resposta[TrioAtual] +
                                    Extenso3em3( RespostaN[TrioAtual] );
             TriosUsados := TriosUsados + [ TrioAtual ];
             Inc( NumTriosInt );
             if RespostaN[TrioAtual] > 1 then begin
                Plural[TrioAtual] := True;
             end;
          end;
      end;

      if CasaDosCentavos in TriosUsados then
         Dec( NumTriosInt );

      { Gerar a resposta propriamente dita }
      NumStr := '';

      {
        Este trecho obriga que o nome da moeda seja sempre impresso no caso
de
        haver uma parte inteira, qualquer que seja o valor.
      }
      if (Resposta[CasaDasCentenas]='') and ( Inteiro > 0 ) then begin
          Resposta[CasaDasCentenas] := ' ';
          Plural[CasaDasCentenas]   := True;
          TriosUsados := TriosUsados + [ CasaDasCentenas ];
      end;


      { Basta ser maior que um para que a palavra "real" seja escrita no
plural }
      if Inteiro > 1 then
         Plural[CasaDasCentenas] := True;

      { Localiza o primeiro elemento }
      TrioAtual     := 0;
      TrioPosterior := ProximoTrio( TrioAtual );

      { Localiza o segundo elemento }
      TrioAtual     := TrioPosterior;
      TrioPosterior := ProximoTrio( TrioAtual );

      { Este loop vai percorrer apenas os trios preenchidos e saltar os
vazios. }
      while TrioAtual <= CasaDosCentavos do begin
         { se for apenas cem, não escrever 'cento' }
         if Resposta[TrioAtual] = 'cento' then
            Resposta[TrioAtual] := 'cem';

         { Verifica se a resposta deve ser no plural ou no singular }
         if Resposta[TrioAtual] <> '' then begin
            NumStr := NumStr + Resposta[TrioAtual] + ' ';
            if plural[TrioAtual] then
               NumStr := NumStr + NoPlural[TrioAtual] + ' '
            else
               NumStr := NumStr + NoSingular[TrioAtual] + ' ';

            { Verifica a necessidade da particula 'e' para os números }
            if ( TrioAtual < CasaDosCentavos ) and ( Resposta[TrioPosterior]
<> '' )
               and ( Resposta[TrioPosterior] <> ' ' ) then begin
               {
                 Este trecho analisa diversos fatores e decide entre usar
uma
                 vírgula ou um "E", em função de uma peculiaridade da
língua. Veja
                 os exemplos para compreender:
                 - DOIS MIL, QUINHENTOS E CINQÜENTA REAIS
                 - DOIS MIL E QUINHENTOS REAIS
                 - DOIS MIL E UM REAIS
                 - TRÊS MIL E NOVENTA E CINCO REAIS
                 - QUATRO MIL, CENTO E UM REAIS
                 - UM MILHÃO E DUZENTOS MIL REAIS
                 - UM MILHÃO, DUZENTOS MIL E UM REAIS
                 - UM MILHÃO, OITOCENTOS E NOVENTA REAIS
                 Obs.: Fiz o máximo esforço pra que o extenso soasse o mais
natural
                       possível em relação à lingua falada, mas se aparecer
alguma
                       situação em que algo soe esquisito, peço a gentileza
de me
                       avisar.
               }
               if ( TrioAtual < CasaDosCentavos ) and
                  ( ( NumTriosInt = 2 ) or ( TrioAtual = CasaDosMilhares ) )
and
                  ( ( RespostaN[TrioPosterior] <= 100 ) or
                    ( RespostaN[TrioPosterior] mod 100 = 0 ) ) then
                  NumStr := NumStr + 'e '
               else
                  NumStr := NumStr + ', ';
            end;
         end;

         { se for apenas trilhões, bilhões ou milhões, acrescenta o 'de' }
         if ( NumTriosInt = 1 ) and ( Inteiro > 0 ) and ( TrioAtual <=
CasaDosMilhoes ) then begin
            NumStr := NumStr + ' de ';
         end;

         { se tiver centavos, acrescenta a partícula 'e', mas somente se
houver
           qualquer valor na parte inteira }
         if ( TrioAtual = CasaDasCentenas ) and ( Resposta[CasaDosCentavos]
<> '' )
            and ( inteiro > 0 ) then begin
            NumStr := Copy( NumStr, 1, Length( NumStr ) - 2 ) + ' e ';
         end;

         TrioAtual     := ProximoTrio( TrioAtual );
         TrioPosterior := ProximoTrio( TrioAtual );
      end;

      { Eliminar algumas situações em que o extenso gera excessos de espaços
        da resposta. Mero perfeccionismo... }
      NumStr := ReplaceSubstring( '  ', ' ', NumStr );
      NumStr := ReplaceSubstring( ' ,', ',', NumStr );

      Result := NumStr;
    end;

begin
    Result := Extenso(FNumero);
end;


// Function cortesy of Argon Konay * 2004.03.11
function NumberToTextTurkish(Amount:currency):WideString;
const
  NumberNames : array[0..3, 0..9] of WideString =(
        (* 0  1     2        3        4         5           6
7         8          9 *)
(*   1x*)
('','Bir','iki',   'Üç',    'Dört',   'Be?',      'Alt?',   'Yedi',
'Sekiz',   'Dokuz'),
(*  10x*)
('','On', 'Yirmi', 'Otuz',  'K?rk',   'Elli',     'Altm??', 'Yetmi?',
'Seksen',  'Doksan'),
(* 100x*)
('','Yüz','?kiYüz','ÜçYüz', 'DörtYüz','Be?Yüz',   'Alt?Yüz','YediYüz',
'SekizYüz','DokuzYüz'),
(*1000x*)
('','Bin','Milyon','Milyar','Trilyon','Katrilyon','',       '',
'',        ''));
  NumberZero: WideString = 'S?f?r';
  var
    IntegerPart: String;
    s: WideString;
    pStart, pCurrent: PChar;
    i, j: integer;
  begin
    Result := '';
    Amount := Abs(Amount);
    IntegerPart := CurrToStr(Int(Amount));

    (* Prefix string with zeroes to make its length a multiple of
three. *)
    i := Length(IntegerPart) mod 3;
    if i <> 0 then
      IntegerPart := StringOfChar('0', 3 - i) + IntegerPart;
    pStart := PChar(IntegerPart);
    pCurrent := pStart + Length(IntegerPart) - 1;

    i := 0;
    while (pCurrent >= pStart) do
    begin
      s := '';
      (* 0 - 999 *)
      for j := 0 to 2 do
      begin
        s := NumberNames[j, Ord(pCurrent^) - Ord('0')] + s;
        Dec(pCurrent);
      end;

      (* 1000x *)
      if s <> '' then
      begin
        (* bir bin (one thousand) ==> bin (thousand) *)
        if (i = 1) and (s = NumberNames[0, 1]) then
          s := '';
        Result := s + NumberNames[3, i] + Result
      end;
      inc(i);
    end;

    if Result = '' then
      Result := NumberZero;

    (* Only two digits are used for the decimal part *)
    i := Round(100*Frac(Amount));
    if i <> 0 then
      Result := Result + '%' + IntToStr(i);
end;
{$ENDIF}

function NumberToTextSpanishMex(FNumero:currency;female:boolean):WideString;
var s:String;
    centavos:Integer;
    i:Integer;
    Numero:Int64;
    fseparador:string;

     Function longitud(numero:LongInt):integer;
     {Esta funciÓn nos da la longitud del número que vamos a
     deletrear}
     begin
	  If numero div 10 =0 then
	     longitud:=1
	  else
	     longitud:=1+longitud(numero div 10);
     end;

     Function Unidades(numero:Integer):String;
     begin
	  case numero of
	  0: Unidades:='';
	  1:
	     If Not Female then
	      Unidades:='un'
	     else
	      Unidades:='una';
	  2: Unidades:='dos';
	  3: Unidades:='tres';
	  4: Unidades:='cuatro';
	  5: Unidades:='cinco';
	  6: Unidades:='seis';
	  7: Unidades:='siete';
	  8: Unidades:='ocho';
	  9: Unidades:='nueve';
	  end;
     end;

     Function Decenas (numero:integer):String;
     begin
	  Case numero of
	  0:Decenas:='';
	  1..9:Decenas:=Unidades(numero);
	  10: Decenas:='diez';
	  11: Decenas:='once';
	  12: Decenas:='doce';
	  13: Decenas:='trece';
	  14: Decenas:='catorce';
	  15: Decenas:='quince';
	  16: Decenas:='dieciséis';
	  17: Decenas:='diecisiete';
	  18: Decenas:='dieciocho';
	  19: Decenas:='diecinueve';
	  20: Decenas:='veinte';
	  21: begin
         if female then
          Decenas:='veintiuna'
         else
          Decenas:='veintiún';
        end;
	  22: Decenas:='veintidós';
	  23: Decenas:='veintitrés';
	  24..29: Decenas:='veinti'+Unidades(numero mod 10);
	  30: Decenas:='treinta';
	  40: Decenas:='cuarenta';
	  50: Decenas:='cincuenta';
	  60: Decenas:='sesenta';
	  70: Decenas:='setenta';
	  80: Decenas:='ochenta';
	  90: Decenas:='noventa';
	  else
	       Decenas:=Decenas(numero - numero mod 10)+' y '+ unidades(numero mod 10);
	  end;
     end;
     Function centenas(numero:integer):String;
     begin
	  case numero of
	  0: centenas:='';
	  1..99:centenas:=decenas(numero);
	  100: centenas:='cien';
	  101..199: centenas:='ciento '+decenas(numero mod 100);
	  200: If Not Female then
		centenas:='doscientos'
	       else
		centenas:='doscientas';
	  500: If Not Female then
		centenas:='quinientos'
	       else
		centenas:='quinientas';
	  501..599:
	       If Not Female then
		centenas:='quinientos '+decenas(numero mod 100)
	       else
		centenas:='quinientas '+decenas(numero mod 100);

	  700: If Not Female then
		centenas:='setecientos'
	       else
		centenas:='setecientas';

	  701..799:
	       If Not Female then
		centenas:='setecientos '+decenas(numero mod 100)
	       else
		centenas:='setecientas '+decenas(numero mod 100);
	  900..999:
	       If Not Female then
		centenas:='novecientos '+decenas(numero mod 100)
	       else
		centenas:='novecientas '+decenas(numero mod 100);
	  else
	   If Not Female then
	    centenas:=unidades(numero div 100)+'cientos'+' '+decenas(numero mod 100)
	   else
	      centenas:=unidades(numero div 100)+'cientas'+' '+decenas(numero mod 100);
	  end;
     end;

     Function UnidadesDeMillar(numero:Integer):String;
     begin
     if numero > 999 then begin
	  if numero > 1999 then
	       UnidadesDeMillar:=Unidades(numero div 1000) +' mil '+ centenas(numero mod 1000)
	  else
	      UnidadesDeMillar:='mil '+ centenas(numero mod 1000);
     end
     else
	 UnidadesDeMillar:=Centenas(numero);
     end;

     Function DecenasDeMillar(Numero:LongInt):String;
     begin
     If numero > 9999 then
	 DecenasDeMillar:=Decenas(Numero div 1000) +' mil '+Centenas(Numero mod 1000)
     else
	 DecenasDeMillar:=UnidadesDeMillar(Numero);
     end;

     Function CentenasDeMillar(Numero:LongInt):String;
     begin
	  If Numero > 99999 then
	       CentenasDeMillar:=Centenas(Numero div 1000) +' mil '+Centenas(numero mod 1000)
	  else
	       CentenasDeMillar:=DecenasDeMillar(numero);
     end;

     Function UnidadesDeMillon(Numero:LongInt):String;
     begin
	  if numero > 1999999 then
	  UnidadesDeMillon:=Unidades(Numero div 1000000)+' millones '+CentenasDeMillar(Numero mod 1000000)
	  else
	  UnidadesDeMillon:= 'un millón '+CentenasDeMillar(Numero mod 1000000)
     end;

     Function DecenasDeMillon(Numero:LongInt):String;
     var tmp,c:String;
	 i:Byte;
     begin
	  tmp:= Decenas(Numero div 1000000);
	  i:=Length(tmp);
	  c:= tmp[i-1]+tmp[i];
	  if c='na' then
	     SetLength(tmp,i-1);
	  DecenasDeMillon:=tmp+ ' millones '+CentenasDeMillar(Numero mod 1000000)
     end;

     Function CentenasDeMillon(Numero:LongInt):String;
     var tmp:String;
	 c:String;
	 i:byte;
     begin
     {Pasamos del femenino al masculino en las centenas}
       tmp:=Centenas(Numero div 1000000);
       c:=tmp[1];
       i:=1;
       While ( (c<>' ') and (length(tmp)>=i) ) do
       begin
	    if (tmp[i]='a') and (tmp[i+1] ='s') then begin
	       tmp[i]:='o';
	       break;
	    end;
	    inc(i);
       end;
       i:=Length(tmp);
       c:= tmp[i-1]+tmp[i];
       if c='na' then
	     SetLength(tmp,i-1);
       CentenasDeMillon:=tmp+' millones '+CentenasDeMillar(Numero mod 1000000)
     end;

begin
Result:='';
FNumero:=Abs(Fnumero);
fseparador:=decimalseparator;
s:=FormatFloat('##########0.00',Fnumero);
i:=pos(Fseparador,s);
numero:=StrToInt(copy(s,1,i-1));
s:=copy(s,i+1,Length(s));
centavos:=StrToInt(s);
if Length(s)=1 then centavos:=centavos*10;
Case Longitud(numero) of
     1: s:=Unidades(numero);
     2: s:=Decenas(numero);
     3: s:=Centenas(numero);
     4: s:=UnidadesDeMillar(numero);
     5: s:=DecenasDeMillar(numero);
     6: s:=CentenasDeMillar(numero);
     7: s:=UnidadesDeMillon(numero);
     8: s:=DecenasdeMillon(numero);
     9: s:=CentenasDeMillon(numero);
     else
	 s:='Demasiado grande';
     end;
 s[1]:=UpCase(s[1]);
  case longitud(centavos) of
    1: Result:=Unidades(Centavos);
    2: Result:=Decenas(Centavos);
  end;
  Result:=IntToStr(Centavos)+'0';
  Result:='('+s+'  pesos '+copy(Result,1,2)+'/100)';
end;


function NumberToTextCatalan(Fnumero:currency;female:boolean):WideString;
var s:String;
    centavos:Integer;
    i:Integer;
    Numero:Int64;
    fseparador:string;

     Function longitud(numero:LongInt):integer;
     {Esta funciÓn nos da la longitud del número que vamos a
     deletrear}
     begin
	  If numero div 10 =0 then
	     longitud:=1
	  else
	     longitud:=1+longitud(numero div 10);
     end;

     Function Unidades(numero:Integer):String;
     begin
	  case numero of
	  0: Unidades:='';
	  1:
	     If Not Female then
	      Unidades:='un'
	     else
	      Unidades:='una';
	  2: Unidades:='dos';
	  3: Unidades:='tres';
	  4: Unidades:='quatre';
	  5: Unidades:='cinc';
	  6: Unidades:='sis';
	  7: Unidades:='set';
	  8: Unidades:='vuit';
	  9: Unidades:='nou';
	  end;
     end;

     Function Decenas (numero:integer):String;
     begin
	  Case numero of
	  0:Decenas:='';
	  1..9:Decenas:=Unidades(numero);
	  10: Decenas:='deu';
	  11: Decenas:='onze';
	  12: Decenas:='dotze';
	  13: Decenas:='tretze';
	  14: Decenas:='catorze';
	  15: Decenas:='quinze';
	  16: Decenas:='setze';
	  17: Decenas:='disset';
	  18: Decenas:='divuit';
	  19: Decenas:='dinou';
	  20: Decenas:='vint';
	  21: If Not Female then
	       Decenas:='veint-i-un'
              else
	       Decenas:='veint-i-una';
	  22: Decenas:='vint-i-dos';
	  23: Decenas:='vint-i-tres';
	  24..29: Decenas:='vint-i-'+Unidades(numero mod 10);
	  30: Decenas:='trenta';
	  31: If Not Female then
	       Decenas:='trenta-un'
              else
	       Decenas:='trenta-una';
	  40: Decenas:='quaranta';
	  41: If Not Female then
	       Decenas:='quaranta-un'
              else
	       Decenas:='quaranta-una';
	  50: Decenas:='cinquanta';
	  51: If Not Female then
	       Decenas:='cinquanta-un'
              else
	       Decenas:='cinquanta-una';
	  60: Decenas:='seixanta';
	  61: If Not Female then
	       Decenas:='seixanta-un'
              else
	       Decenas:='seixanta-una';
	  70: Decenas:='setenta';
	  71: If Not Female then
	       Decenas:='setanta-un'
              else
	       Decenas:='setanta-una';
	  80: Decenas:='vuitanta';
	  81: If Not Female then
	       Decenas:='vuitanta-un'
              else
	       Decenas:='vuitanta-una';
	  90: Decenas:='noranta';
	  91: If Not Female then
	       Decenas:='noranta-un'
              else
	       Decenas:='noranta-una';
	  else
	       Decenas:=Decenas(numero - numero mod 10)+'-'+ unidades(numero mod 10);
	  end;
     end;
     Function centenas(numero:integer):String;
     begin
	  case numero of
	  0: centenas:='';
	  1..99:centenas:=decenas(numero);
	  100: centenas:='cent';
	  101..199: centenas:='cent '+decenas(numero mod 100);
	  200: If Not Female then
		centenas:='dos-cents'
	       else
		centenas:='dos-centes';
	  500: If Not Female then
		centenas:='cinc-cents'
	       else
		centenas:='cinc-centes';
	  501..599:
	       If Not Female then
		centenas:='cinc-cents '+decenas(numero mod 100)
	       else
		centenas:='cinc-centes '+decenas(numero mod 100);

	  700: If Not Female then
		centenas:='set-cents'
	       else
		centenas:='set-centes';

	  701..799:
	       If Not Female then
		centenas:='set-cents '+decenas(numero mod 100)
	       else
		centenas:='set-centes '+decenas(numero mod 100);
	  900..999:
	       If Not Female then
		centenas:='nou-cents '+decenas(numero mod 100)
	       else
		centenas:='nou-centes '+decenas(numero mod 100);
	  else
	   If Not Female then
	    centenas:=unidades(numero div 100)+'-cents '+decenas(numero mod 100)
	   else
	      centenas:=unidades(numero div 100)+'-centes '+decenas(numero mod 100);
	  end;
     end;

     Function UnidadesDeMillar(numero:Integer):String;
     begin
     if numero > 999 then begin
	  if numero > 1999 then
	       UnidadesDeMillar:=Unidades(numero div 1000) +' mil '+ centenas(numero mod 1000)
	  else
	      UnidadesDeMillar:='mil '+ centenas(numero mod 1000);
     end
     else
	 UnidadesDeMillar:=Centenas(numero);
     end;

     Function DecenasDeMillar(Numero:LongInt):String;
     begin
     If numero > 9999 then
	 DecenasDeMillar:=Decenas(Numero div 1000) +' mil '+Centenas(Numero mod 1000)
     else
	 DecenasDeMillar:=UnidadesDeMillar(Numero);
     end;

     Function CentenasDeMillar(Numero:LongInt):String;
     begin
	  If Numero > 99999 then
	       CentenasDeMillar:=Centenas(Numero div 1000) +' mil '+Centenas(numero mod 1000)
	  else
	       CentenasDeMillar:=DecenasDeMillar(numero);
     end;

     Function UnidadesDeMillon(Numero:LongInt):String;
     begin
	  if numero > 1999999 then
	  UnidadesDeMillon:=Unidades(Numero div 1000000)+' milions '+CentenasDeMillar(Numero mod 1000000)
	  else
	  UnidadesDeMillon:= 'un milió '+CentenasDeMillar(Numero mod 1000000)
     end;

     Function DecenasDeMillon(Numero:LongInt):String;
     var tmp,c:String;
	 i:Byte;
     begin
	  tmp:= Decenas(Numero div 1000000);
	  i:=Length(tmp);
	  c:= tmp[i-1]+tmp[i];
	  if c='na' then
	     SetLength(tmp,i-1);
	  DecenasDeMillon:=tmp+ ' milions '+CentenasDeMillar(Numero mod 1000000)
     end;

     Function CentenasDeMillon(Numero:LongInt):String;
     var tmp:String;
	 c:String;
	 i:byte;
     begin
     {Pasamos del femenino al masculino en las centenas}
       tmp:=Centenas(Numero div 1000000);
       c:=tmp[1];
       i:=1;
       While ( (c<>' ') and (length(tmp)>=i) ) do
       begin
	    if (tmp[i]='a') and (tmp[i+1] ='s') then begin
	       tmp[i]:='o';
	       break;
	    end;
	    inc(i);
       end;
       i:=Length(tmp);
       c:= tmp[i-1]+tmp[i];
       if c='na' then
	     SetLength(tmp,i-1);
       CentenasDeMillon:=tmp+' milions '+CentenasDeMillar(Numero mod 1000000)
     end;

begin
FNumero:=Abs(Fnumero);
fseparador:=decimalseparator;
s:=FormatFloat('##########0.00',Fnumero);
i:=pos(Fseparador,s);
numero:=StrToInt(copy(s,1,i-1));
s:=copy(s,i+1,Length(s));
centavos:=StrToInt(s);
if Length(s)=1 then centavos:=centavos*10;
Case Longitud(numero) of
     1: s:=Unidades(numero);
     2: s:=Decenas(numero);
     3: s:=Centenas(numero);
     4: s:=UnidadesDeMillar(numero);
     5: s:=DecenasDeMillar(numero);
     6: s:=CentenasDeMillar(numero);
     7: s:=UnidadesDeMillon(numero);
     8: s:=DecenasdeMillon(numero);
     9: s:=CentenasDeMillon(numero);
     else
	 s:='Demasiado grande';
     end;
If (i<>0) and (centavos>0) then begin
 case longitud(centavos) of
   1: Result:=Unidades(Centavos);
   2: Result:=Decenas(Centavos);
 end;
 Result:=s+' amb '+Result;
end else
 Result:=s;
end;

function NumberToTextCastellano(FNumero:currency;female:boolean):WideString;
var s:String;
    centavos:Integer;
    i:Integer;
    Numero:Int64;
    fseparador:string;

     Function longitud(numero:LongInt):integer;
     {Esta funciÓn nos da la longitud del número que vamos a
     deletrear}
     begin
	  If numero div 10 =0 then
	     longitud:=1
	  else
	     longitud:=1+longitud(numero div 10);
     end;

     Function Unidades(numero:Integer):String;
     begin
	  case numero of
	  0: Unidades:='';
	  1:
	     If Not Female then
	      Unidades:='un'
	     else
	      Unidades:='una';
	  2: Unidades:='dos';
	  3: Unidades:='tres';
	  4: Unidades:='cuatro';
	  5: Unidades:='cinco';
	  6: Unidades:='seis';
	  7: Unidades:='siete';
	  8: Unidades:='ocho';
	  9: Unidades:='nueve';
	  end;
     end;

     Function Decenas (numero:integer):String;
     begin
	  Case numero of
	  0:Decenas:='';
	  1..9:Decenas:=Unidades(numero);
	  10: Decenas:='diez';
	  11: Decenas:='once';
	  12: Decenas:='doce';
	  13: Decenas:='trece';
	  14: Decenas:='catorce';
	  15: Decenas:='quince';
	  16: Decenas:='dieciséis';
	  17: Decenas:='diecisiete';
	  18: Decenas:='dieciocho';
	  19: Decenas:='diecinueve';
	  20: Decenas:='veinte';
	  21: begin
         if female then
          Decenas:='veintiuna'
         else
          Decenas:='veintiún';
        end;
	  22: Decenas:='veintidós';
	  23: Decenas:='veintitrés';
	  24..29: Decenas:='veinti'+Unidades(numero mod 10);
	  30: Decenas:='treinta';
	  40: Decenas:='cuarenta';
	  50: Decenas:='cincuenta';
	  60: Decenas:='sesenta';
	  70: Decenas:='setenta';
	  80: Decenas:='ochenta';
	  90: Decenas:='noventa';
	  else
	       Decenas:=Decenas(numero - numero mod 10)+' y '+ unidades(numero mod 10);
	  end;
     end;
     Function centenas(numero:integer):String;
     begin
	  case numero of
	  0: centenas:='';
	  1..99:centenas:=decenas(numero);
	  100: centenas:='cien';
	  101..199: centenas:='ciento '+decenas(numero mod 100);
	  200: If Not Female then
		centenas:='doscientos'
	       else
		centenas:='doscientas';
	  500: If Not Female then
		centenas:='quinientos'
	       else
		centenas:='quinientas';
	  501..599:
	       If Not Female then
		centenas:='quinientos '+decenas(numero mod 100)
	       else
		centenas:='quinientas '+decenas(numero mod 100);

	  700: If Not Female then
		centenas:='setecientos'
	       else
		centenas:='setecientas';

	  701..799:
	       If Not Female then
		centenas:='setecientos '+decenas(numero mod 100)
	       else
		centenas:='setecientas '+decenas(numero mod 100);
	  900..999:
	       If Not Female then
		centenas:='novecientos '+decenas(numero mod 100)
	       else
		centenas:='novecientas '+decenas(numero mod 100);
	  else
	   If Not Female then
	    centenas:=unidades(numero div 100)+'cientos'+' '+decenas(numero mod 100)
	   else
	      centenas:=unidades(numero div 100)+'cientas'+' '+decenas(numero mod 100);
	  end;
     end;

     Function UnidadesDeMillar(numero:Integer):String;
     begin
     if numero > 999 then begin
	  if numero > 1999 then
	       UnidadesDeMillar:=Unidades(numero div 1000) +' mil '+ centenas(numero mod 1000)
	  else
	      UnidadesDeMillar:='mil '+ centenas(numero mod 1000);
     end
     else
	 UnidadesDeMillar:=Centenas(numero);
     end;

     Function DecenasDeMillar(Numero:LongInt):String;
     begin
     If numero > 9999 then
	 DecenasDeMillar:=Decenas(Numero div 1000) +' mil '+Centenas(Numero mod 1000)
     else
	 DecenasDeMillar:=UnidadesDeMillar(Numero);
     end;

     Function CentenasDeMillar(Numero:LongInt):String;
     begin
	  If Numero > 99999 then
	       CentenasDeMillar:=Centenas(Numero div 1000) +' mil '+Centenas(numero mod 1000)
	  else
	       CentenasDeMillar:=DecenasDeMillar(numero);
     end;

     Function UnidadesDeMillon(Numero:LongInt):String;
     begin
	  if numero > 1999999 then
	  UnidadesDeMillon:=Unidades(Numero div 1000000)+' millones '+CentenasDeMillar(Numero mod 1000000)
	  else
	  UnidadesDeMillon:= 'un millón '+CentenasDeMillar(Numero mod 1000000)
     end;

     Function DecenasDeMillon(Numero:LongInt):String;
     var tmp,c:String;
	 i:Byte;
     begin
	  tmp:= Decenas(Numero div 1000000);
	  i:=Length(tmp);
	  c:= tmp[i-1]+tmp[i];
	  if c='na' then
	     SetLength(tmp,i-1);
	  DecenasDeMillon:=tmp+ ' millones '+CentenasDeMillar(Numero mod 1000000)
     end;

     Function CentenasDeMillon(Numero:LongInt):String;
     var tmp:String;
	 c:String;
	 i:byte;
     begin
     {Pasamos del femenino al masculino en las centenas}
       tmp:=Centenas(Numero div 1000000);
       c:=tmp[1];
       i:=1;
       While ( (c<>' ') and (length(tmp)>=i) ) do
       begin
	    if (tmp[i]='a') and (tmp[i+1] ='s') then begin
	       tmp[i]:='o';
	       break;
	    end;
	    inc(i);
       end;
       i:=Length(tmp);
       c:= tmp[i-1]+tmp[i];
       if c='na' then
	     SetLength(tmp,i-1);
       CentenasDeMillon:=tmp+' millones '+CentenasDeMillar(Numero mod 1000000)
     end;

begin
Result:='';
FNumero:=Abs(Fnumero);
fseparador:=decimalseparator;
s:=FormatFloat('##########0.00',Fnumero);
i:=pos(Fseparador,s);
numero:=StrToInt(copy(s,1,i-1));
s:=copy(s,i+1,Length(s));
centavos:=StrToInt(s);
if Length(s)=1 then centavos:=centavos*10;
Case Longitud(numero) of
     1: s:=Unidades(numero);
     2: s:=Decenas(numero);
     3: s:=Centenas(numero);
     4: s:=UnidadesDeMillar(numero);
     5: s:=DecenasDeMillar(numero);
     6: s:=CentenasDeMillar(numero);
     7: s:=UnidadesDeMillon(numero);
     8: s:=DecenasdeMillon(numero);
     9: s:=CentenasDeMillon(numero);
     else
	 s:='Demasiado grande';
     end;
If (i<>0) and (centavos>0) then begin
 case longitud(centavos) of
   1: Result:=Unidades(Centavos);
   2: Result:=Decenas(Centavos);
 end;
 Result:=s+' con '+Result;
end else
 Result:=s;
 If Length(Result)>0 then
  Result[1]:=WideString(UpperCase(Result))[1];
end;


function NumberToText(FNumero:currency;female:boolean;idiom:integer):WideString;
begin
 Result:='';
 case idiom of
  0,-1:
    Result:= NumberToTextEnglish(FNumero);
  1:
   Result:=NumberToTextCastellano(FNumero,female);
  2:
   Result:=NumberToTextCatalan(FNumero,female);
{$IFNDEF DOTNETD}
  4:
   Result:=NumberToTextPortuguese(FNumero);
  7:
   Result:=NumberToTextTurkish(FNumero);
  8:
   Result:=NumberToTextLithuanian(FNumero,female);
{$ENDIF}
  13:
   Result:=NumberToTextSpanishMex(FNumero,female);
 end;
end;


procedure GetLanguageDescriptions(alist:TStrings);
//var
// rplangids:array [0..MAX_LANGUAGES-1] of string=('EN','ES','CAT','FR','PT');
begin
 alist.Clear;
 alist.Add(SRpEnglish);     // 0
 alist.Add(SRpSpanish);
 alist.Add(SRpCatalan);
 alist.Add(SRpFrench);
 alist.Add(SRpPortuguesse);
 alist.Add(SRpGerman);      // 5
 alist.Add(SRpItalian);
 alist.Add(SRpTurkish);
 alist.Add(SRpLithuanian);
 alist.Add(SRpGreek);
 alist.Add(SRpHungar);      // 10
 alist.Add(SRpDanish);
 alist.Add(SRpDutch);
 alist.Add(SrpSpanishMe);
 alist.Add(SrpSpanishAr);
 alist.Add(SRpPortuguesseBrasil);   // 15
 alist.Add(SrpCroatian);
 alist.Add(SrpCzech);
 alist.Add(SRpDutchFlemish);
 alist.Add(SRpFinn);
 alist.Add(SRpNorwegian);   // 20
 alist.Add(SRpGalician);
 alist.Add(SRpRussian);
 alist.Add(SRpPolish);
 alist.Add(SRpSwedish);
 alist.Add(SRpSlovenian);   // 25
 alist.Add(SRpBasque);
 alist.Add(SRpJapanese);
end;

procedure GetBidiDescriptionsA(alist:TStrings);
var
 list:TRpWideStrings;
begin
 list:=TRpWideStrings.create;
 try
  GetBidiDescriptions(list);
  alist.Assign(list);
 finally
  list.free;
 end;
end;

procedure GetBidiDescriptions(alist:TRpWideStrings);
begin
 alist.Clear;
 alist.Add(SRpSBidiNo);
 alist.Add(SRpSBidiPartial);
 alist.Add(SRpSBidiFull);
end;

function RpBidiModeToString(BidiMode:TRpBidiMode):String;
begin
 Result:=SRpSBidiNo;
 if BidiMode=rpBidiPartial then
  Result:=SRpSBidiPartial
 else
  if BidiMode=rpBidiFull then
   Result:=SRpSBidiFull;
end;

function StringToRpBidiMode(Value:String):TRpBidiMode;
begin
 Result:=rpBidiNo;
 if Value=SRpSBidiPartial then
  Result:=rpBidiPartial
 else
  if Value=SRpSBidiFull then
   Result:=rpBidiFull;
end;

function DoReverseString(Value:String):String;
var
 i:integer;
begin
 Result:='';
 for i:=1 to Length(Value) do
 begin
  Result:=Value[i]+Result;
 end;
end;

function DoReverseStringW(Value:WideString):WideString;
var
 i:integer;
begin
 Result:='';
 for i:=1 to Length(Value) do
 begin
  Result:=Value[i]+Result;
 end;
end;

function GetWheelInc(Shift:TShiftState):integer;
var
 multiplier:integer;
begin
 multiplier:=REP_C_WHEELSCALE;
 if (ssShift in Shift) then
  multiplier:=multiplier*REP_C_WHEELSCALE;
 Result:=multiplier*REP_C_WHEELINC;
end;


function FontStepToString(fstep:TRpSelectFontStep):Widestring;
begin
 case fstep of
  rpselectsize:
   Result:=SRpStepBySize;
  rpselectcpi20:
   Result:=SRpStep20;
  rpselectcpi17:
   Result:=SRpStep17;
  rpselectcpi15:
   Result:=SRpStep15;
  rpselectcpi12:
   Result:=SRpStep12;
  rpselectcpi10:
   Result:=SRpStep10;
  rpselectcpi6:
   Result:=SRpStep6;
  rpselectcpi5:
   Result:=SRpStep5;
 end;
end;

function StringToFontStep(cad:string):TRpSelectFontStep;
begin
 Result:=rpselectsize;
 if cad=SRpStepBySize then
 begin
  result:=rpselectsize;
  exit;
 end;
 if cad=SRpStep20 then
 begin
  result:=rpselectcpi20;
  exit;
 end;
 if cad=SRpStep17 then
 begin
  result:=rpselectcpi17;
  exit;
 end;
 if cad=SRpStep15 then
 begin
  result:=rpselectcpi15;
  exit;
 end;
 if cad=SRpStep12 then
 begin
  result:=rpselectcpi12;
  exit;
 end;
 if cad=SRpStep10 then
 begin
  result:=rpselectcpi10;
  exit;
 end;
 if cad=SRpStep6 then
 begin
  result:=rpselectcpi6;
  exit;
 end;
 if cad=SRpStep5 then
 begin
  result:=rpselectcpi5;
  exit;
 end;
end;

procedure GetStepDescriptionsA(alist:TStrings);
var
 list:TRpWideStrings;
begin
 list:=TRpWideStrings.create;
 try
  GetStepDescriptions(list);
  alist.Assign(list);
 finally
  list.free;
 end;
end;

procedure GetStepDescriptions(alist:TRpWideStrings);
begin
 alist.Clear;
 alist.Add(SRpStepBySize);
 alist.Add(SRpStep20);
 alist.Add(SRpStep17);
 alist.Add(SRpStep15);
 alist.Add(SRpStep12);
 alist.Add(SRpStep10);
 alist.Add(SRpStep6);
 alist.Add(SRpStep5);
end;

function FontSizeToStep(asize:integer;select:TRpSelectFontStep):TRpFontStep;
begin
 if select=rpselectsize then
 begin
  case asize of
   8:
    Result:=rpcpi17;
   9:
    Result:=rpcpi15;
   10:
    Result:=rpcpi12;
   11..12:
    Result:=rpcpi10;
   13..15:
     Result:=rpcpi6;
   else
    begin
     if asize>15 then
      Result:=rpcpi5
     else
      REsult:=rpcpi20;
    end;
  end;
 end
 else
 begin
  Result:=TRpFontStep(Integer(select)-1);
 end;
end;

procedure GetTextOnlyPrintDrivers(drivernames:TStrings);
begin
 drivernames.Clear;
 drivernames.Add(' ');
 drivernames.Add('PLAIN');
 drivernames.Add('EPSON');
 drivernames.Add('EPSON-MASTER');
// drivernames.Add('EPSON-IBMPRO');
 drivernames.Add('EPSON-ESCP');
 drivernames.Add('EPSON-ESCPQ');
 drivernames.Add('IBMPROPRINTER');
 drivernames.Add('EPSONTMU210');
 drivernames.Add('EPSONTMU210CUT');
 drivernames.Add('EPSONTM88IICUT');
 drivernames.Add('EPSONTM88II');
 drivernames.Add('HP-PCL');
 drivernames.Add('VT100');
 drivernames.Add('PLAINFULL');
end;

procedure WriteStringToDevice(S,Device:String);
var
 fstream:TFileStream;
begin
 fstream:=TFileStream.Create(Device,fmOpenWrite);
 try
  fstream.Write(S[1],Length(S));
 finally
  fstream.free;
 end;
end;


function GetLastname(astring:string):string;
var
 j,index:integer;
begin
 j:=1;
 index:=1;
 while j<=Length(astring) do
 begin
  if astring[j]=C_DIRSEPARATOR then
  begin
   index:=j;
  end;
  inc(j);
 end;
 Result:=Copy(astring,index+1,Length(astring));
end;

function GetPathName(astring:string):string;
var
 j,index:integer;
begin
 j:=1;
 index:=1;
 while j<=Length(astring) do
 begin
  if astring[j]=C_DIRSEPARATOR then
  begin
   index:=j;
  end;
  inc(j);
 end;
 Result:=Copy(astring,1,index-1);
end;

function GetFirstName(astring:string):string;
var
 j,index:integer;
begin
 j:=1;
 index:=Length(astring)+1;
 while j<=Length(astring) do
 begin
  if astring[j]=C_DIRSEPARATOR then
  begin
   index:=j;
   break;
  end;
  inc(j);
 end;
 Result:=Copy(astring,1,index-1);
end;

function IsRedColor(Color:Integer):Boolean;
var
 R,G,B:Byte;
begin
 Color:=Color and $00FFFFFF;
 R:=Byte(Color and $000000FF);
 if R<$E0 then
 begin
  Result:=false;
  exit;
 end;
 G:=Byte((Color shr 8) and $000000FF);
 B:=Byte((Color shr 16) and $000000FF);
 Result:=((R>(G*2)) and (R>(B*2)));
end;

{$IFDEF LINUX}
procedure  ObtainPrinters(alist:TStrings);
var
 PrintCap: TStrings;
 i: Integer;
 ALine: string;
begin
 alist.Clear;
 PrintCap := TStringList.Create;
 try
  PrintCap.LoadFromFile('/etc/printcap');
  for i := 0 to PrintCap.Count - 1 do
  begin
   ALine := Trim(PrintCap.Strings[i]);
   if (Length(ALine) > 0) and (ALine[1] <> ':') and (ALine[1] <> '|')
     and (ALine[1] <> '#') then
   begin
    if (Pos('|', ALine) > 0) then
      alist.Add(Copy(ALine, 1, Pos('|', ALine)-1))
    else if (Pos(':', ALine) > 0) then
      alist.Add(Copy(ALine, 1, Pos(':', Aline)-1))
    else
      alist.Add(ALine);
   end;
  end;
 finally
  PrintCap.Free;
 end;
end;
{$ENDIF}


{$IFDEF LINUX}
procedure ExecuteSystemApp(aparams:TStrings;waitend:Boolean);
var
 child:__pid_t;
 i:integer;
 theparams:array [0..100] of pchar;
begin
 if aparams.count>90 then
  Raise exception.create(SRpTooManyParams);
 // Creates a fork, 
 for i:=0 to aparams.count-1 do
 begin
  theparams[i]:=Pchar(aparams[i]);
 end;
 theparams[aparams.count]:=nil;
 child:=fork;
 if child=-1 then
  Raise Exception.Create(SRpErrorForking);
 if child=0 then
 begin
  // The child executes the command
  execvp(theparams[0],PPChar(@theparams))
 end
 else
 begin
  // Waits to the end
  if waitend then
   waitpid(child,@i,0);
 end;
end;


procedure ExecuteRecode(afilename,parameter:String);
var
 child:__pid_t;
 i:integer;
 theparams:array [0..10] of pchar;
 params:TStringList;
begin
 params:=TStringList.Create;
 try
  params.Add('recode');
  params.Add('-f');
  params.Add(parameter);
  params.Add(afilename);
  // Creates a fork, and provides the input from standard
  // input to lpr command
  if params.count>10 then
   Raise exception.create(SRpTooManyParams);
  for i:=0 to params.count-1 do
  begin
   theparams[i]:=Pchar(params[i]);
  end;
  theparams[params.count]:=nil;
  child:=fork;
  if child=-1 then
   Raise Exception.Create(SRpErrorForking);
  if child=0 then
  begin
   // The child executes the command
   execvp(theparams[0],PPChar(@theparams))
  end
  else
  begin
   // Waits to the end
   wait(@child);
  end;
 finally
  params.Free;
 end;
end;


procedure ExecuteSystemCommand(params:TStrings);
var
 child:__pid_t;
 i:integer;
 theparams:array [0..100] of pchar;
begin
 // Creates a fork, and provides the input from standard
 // input to lpr command
 if params.count>100 then
  Raise exception.create(SRpTooManyParams);
 for i:=0 to params.count-1 do
 begin
  theparams[i]:=Pchar(params[i]);
 end;
 theparams[params.count]:=nil;
 child:=fork;
 if child=-1 then
  Raise Exception.Create(SRpErrorForking);
 if child=0 then
 begin
  // The child executes the command
  execvp(theparams[0],PPChar(@theparams))
 end
 else
 begin
  // Waits to the end
  wait(@child);
 end;
end;


procedure SendTextToPrinter(S:String;printerindex:TRpPrinterSelect;Title,forceprintername:String);
var
 printername:String;
 printernamecommand:string;
 child:__pid_t;
 i:integer;
 theparams:array [0..10] of pchar;
 params:TStringList;
 afilename:String;
 files:TFilestream;
 oemconvert:Boolean;
{$IFDEF ALTLINUXTEXTPRINT}     //   
 cmdtext:String;               // Need to use a temporary string
{$ENDIF}                       //
begin
 oemconvert:=GetPrinterEscapeOem(printerindex);
 afilename:=rpTempFileName;
 files:=TFileStream.Create(afilename,fmCreate or fmShareDenyWrite);  try
  files.Write(S[1],Length(S));
 finally
  files.free;
 end;
 // Looks for the printer name
 printernamecommand:='';
 if Length(forceprintername)>0 then
  printername:=forceprintername
 else
  printername:=GetPrinterConfigName(printerindex);
 params:=TStringList.Create;
 try
  if oemconvert then
  begin
   ExecuteRecode(afilename,'..850/');
  end;
{$IFDEF ALTLINUXTEXTPRINT}                           // Here I add my workaround
  cmdtext := 'lpr ';                                 // 
  if Length(printername) > 0 then                    // Building the lpr command and
    cmdtext := cmdtext + '-P ' + printername + ' ';  // parameters into the temporary
  cmdtext := cmdtext + '-r -l ';                     // string exactly as yours code.
  if Length(Title) > 0 then                          //
    cmdtext := cmdtext + 'J ''' + Title + ''' ';     //
  cmdtext := cmdtext + afilename + ' &';             // But I execute it as
  LibC.system(PChar(cmdtext));                       // a background process here.
{$ELSE}                                              //
  params.Add('lpr');
  if Length(printername)>0 then
  begin
   params.Add('-P');
   params.Add(printername);
  end;
  // Remove after print
  params.Add('-r');
  params.Add('-l');
  Title:=Trim(Title);
  if Length(Title)>0 then
  begin
   params.Add('-J');
   params.Add(Title);
  end;
  params.Add(afilename);
  // Creates a fork
  if params.count>10 then
   Raise exception.create(SRpTooManyParams);
  for i:=0 to params.count-1 do
  begin
   theparams[i]:=Pchar(params[i]);
  end;
  theparams[params.count]:=nil;
  child:=fork;
  if child=-1 then
   Raise Exception.Create(SRpErrorForking);
  if child=0 then
  begin
   // The child executes the command
   execvp(theparams[0],PPChar(@theparams))
  end;
{$ENDIF}
 finally
  params.Free;
 end;
end;

(*procedure SendTextToPrinter(S:String;printerindex:TRpPrinterSelect;Title,forceprintername:String);
var
 printername:String;
 printernamecommand:string;
 child:__pid_t;
 i:integer;
 theparams:array [0..10] of pchar;
 params:TStringList;
 afilename:String;
 files:TFilestream;
 oemconvert:Boolean;
begin
 oemconvert:=GetPrinterEscapeOem(printerindex);
 afilename:=rpTempFileName;
 files:=TFileStream.Create(afilename,fmCreate or fmShareDenyWrite);
 try
  files.Write(S[1],Length(S));
 finally
  files.free;
 end;
 // Looks for the printer name
 printernamecommand:='';
 if Length(forceprintername)>0 then
  printername:=forceprintername
 else
  printername:=GetPrinterConfigName(printerindex);
 params:=TStringList.Create;
 try
  if oemconvert then
  begin
   ExecuteRecode(afilename,'..850/');
  end;
  params.Add('lpr');
  if Length(printername)>0 then
  begin
   params.Add('-P');
   params.Add(printername);
  end;
  // Remove after print
  params.Add('-r');
  params.Add('-l');
  Title:=Trim(Title);
  if Length(Title)>0 then
  begin
   params.Add('-J');
   params.Add(Title);
  end;
  params.Add(afilename);
  // Creates a fork
  if params.count>10 then
   Raise exception.create(SRpTooManyParams);
  for i:=0 to params.count-1 do
  begin
   theparams[i]:=Pchar(params[i]);
  end;
  theparams[params.count]:=nil;
  child:=fork;
  if child=-1 then
   Raise Exception.Create(SRpErrorForking);
  if child=0 then
  begin
   // The child executes the command
   execvp(theparams[0],PPChar(@theparams))
  end;
 finally
  params.Free;
 end;
end;
*)
{$ENDIF}


{$IFNDEF DOTNETD}
function ReadStreamFromHandle(handle:THandle):TMemoryStream;
var
 memstream:TMemoryStream;
 astring:String;
 buffer:array [0..3] of char;
 pbuf:Pchar;
 finish:boolean;
{$IFDEF LINUX}
 readed:Integer;
{$ENDIF}
{$IFDEF MSWINDOWS}
 readed:DWORD;
 lasterror:Integer;
{$ENDIF}
begin
 memstream:=TMemoryStream.Create;
 try
  pbuf:=@buffer;
  astring:='';
  finish:=false;
  buffer[1]:=chr(0);
  repeat
{$IFDEF LINUX}
   // In linux the handle 0 is the stdinput
   readed:=__read(0,pbuf^,1);
   if readed=0 then
    finish:=true;
{$ENDIF}
{$IFDEF MSWINDOWS}
   if not ReadFile(handle,pbuf^,1,readed,nil) then
   begin
    lasterror:=GetLastError;
    if ((lasterror<>ERROR_HANDLE_EOF) AND (lasterror<>ERROR_BROKEN_PIPE)) then
    begin
     RaiseLastOSError;
    end
    else
    begin
     finish:=true;
     readed:=0;
    end;
   end;
{$ENDIF}
   if readed>0 then
   begin
    astring:=astring+pbuf[0];
   end;
  until finish;
  if Length(astring)>0 then
  begin
   memstream.Write(astring[1],Length(astring));
   memstream.Seek(0,soFromBeginning);
  end;
  Result:=memstream;
 except
  memstream.free;
  raise;
 end;
end;
{$ENDIF}

{$IFNDEF DOTNETD}
function ReadFromStdInputStream:TMemoryStream;
{$IFDEF MSWINDOWS}
var
// writed:DWORD;
 handle:THANDLE;
{$ENDIF}
{$IFDEF LINUX}
var
// writed:DWORD;
 handle:integer;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  // In windows obtain sdtin
 handle:=GetStdHandle(STD_INPUT_HANDLE);
 if handle=INVALID_HANDLE_VALUE then
  RaiseLastOsError;
{$ENDIF}
{$IFDEF LINUX}
 handle:=0;
{$ENDIF}
 Result:=ReadStreamFromHandle(handle);
end;

procedure WriteStreamToHandle(astream:TStream;handle:Integer);
var
 memstream:TMemoryStream;
{$IFDEF MSWINDOWS}
 lasterror:Integer;
 writed:DWord;
{$ENDIF}
begin
 memstream:=TMemoryStream.Create;
 try
  memstream.LoadFromStream(astream);
  memstream.Seek(0,soFromBeginning);
{$IFDEF MSWINDOWS}
//  writed:=FileWrite(handle,MemStream.Memory^,MemStream.Size);
  if not WriteFile(handle,MemStream.Memory^,MemStream.Size,writed,nil) then
  begin
   lasterror:=GetLastError;
   if ((lasterror<>ERROR_BROKEN_PIPE) AND (lasterror<>ERROR_HANDLE_EOF)) then
    RaiseLastOSError;
  end;
{$ENDIF}
{$IFDEF LINUX}
  __write(handle,MemStream.Memory^,MemStream.Size);
//  writed:=__write(1,MemStream.Memory^,MemStream.Size);
{$ENDIF}
// Estandard output interrupted is not a critical error
//  if LongInt(writed)<>MemStream.Size then
//   RaiseLastOSError;
 finally
  memstream.free;
 end;
end;

procedure WriteToStdError(astring:String);
{$IFDEF MSWINDOWS}
var
// writed:DWORD;
 handle:THANDLE;
{$ENDIF}
{$IFDEF LINUX}
var
// writed:DWORD;
 handle:integer;
{$ENDIF}
 astream:TMemoryStream;
 i:integer;
begin
{$IFDEF MSWINDOWS}
 // In windows obtain sdtin
 handle:=Windows.GetStdHandle(STD_ERROR_HANDLE);
 if handle=INVALID_HANDLE_VALUE then
  RaiseLastOsError;
{$ENDIF}
{$IFDEF LINUX}
 handle:=2;
{$ENDIF}
 astream:=TMemoryStream.Create;
 try
  for i:=1 to Length(astring) do
  begin
   astream.Write(astring[i],1);
  end;
  WriteStreamToHandle(astream,handle);
 finally
  astream.free;
 end;
end;

{$ENDIF}



{$IFNDEF DOTNETD}

procedure WriteStreamToStdOutput(astream:TStream);
{$IFDEF MSWINDOWS}
var
// writed:DWORD;
 handle:THANDLE;
{$ENDIF}
{$IFDEF LINUX}
var
// writed:DWORD;
 handle:integer;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
 // In windows obtain sdtin
 handle:=Windows.GetStdHandle(STD_OUTPUT_HANDLE);
 if handle=INVALID_HANDLE_VALUE then
  RaiseLastOsError;
{$ENDIF}
{$IFDEF LINUX}
 handle:=1;
{$ENDIF}
 WriteStreamToHandle(astream,handle);
end;


function RpTempPath:String;
{$IFDEF LINUX}
var
 abuffer:array [0..L_tmpnam] of char;
begin
 tmpnam(abuffer);
 Result:=StrPas(abuffer);
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
var
 apath:Pchar;
 alen:DWord;
begin
 alen:=GetTempPath(0,nil);
 if alen=0 then
  RaiseLastOsError;
 apath:=AllocMem(alen+1);
 try
  if 0=GetTempPath(alen,apath) then
   RaiseLastOsError;
  Result:=StrPas(apath);
 finally
  FreeMem(apath);
 end;
end;
{$ENDIF}
{$ENDIF} // Endif dotnetd


{$IFNDEF DOTNETD}
function RpTempFileName:String;
{$IFDEF LINUX}
var
 abuffer:array [0..L_tmpnam] of char;
begin
 tmpnam(abuffer);
 Result:=StrPas(abuffer);
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
var
 apath:Pchar;
 afilename:array [0..MAX_PATH] of char;
 alen:DWord;
begin
 alen:=GetTempPath(0,nil);
 if alen=0 then
  RaiseLastOsError;
 apath:=AllocMem(alen+1);
 try
  if 0=GetTempPath(alen,apath) then
   RaiseLastOsError;
 if 0=Windows.GetTempFileName(apath,'REP',0,afilename) then
  RaiseLastOsError;
 finally
  FreeMem(apath);
 end;
 Result:=StrPas(afilename);
end;
{$ENDIF}
{$ENDIF} // Endif dotnetd


{$IFDEF DOTNETD}
function RpTempPath:String;
begin
 Result:=System.IO.Path.GetTempPath;
end;

function RpTempFileName:String;
begin
 Result:=System.IO.Path.GetTempFileName;
end;
{$ENDIF}


{$IFDEF LINUX}
procedure ReadFileLines(filename:String;dest:TStrings);
var
 f:TextFile;
 astring:String;
begin
 dest.clear;
 if (FileExists(filename)) then
 begin
  try
   AssignFile(f,filename);
   try
    Reset(f);
    while not EOF(f) do
    begin
     ReadLn(f,astring);
     dest.Add(Trim(astring));
    end;
   finally
    CloseFile(f);
   end;
  except
   on E:Exception do
   begin
    dest.Add(E.Message);
   end;
  end;
 end
 else
  dest.Add(filename+' - '+SRpNotFound);
end;
{$ENDIF}

{$IFDEF BUILDER4}
function VarTypeToDataType(VarType: Integer): TFieldType;
begin
  case VarType of
    varSmallint, varByte: Result := ftSmallInt;
    varInteger: Result := ftInteger;
    varCurrency: Result := ftBCD;
    varSingle, varDouble,varDecimalType: Result := ftFloat;
    varDate: Result := ftDateTime;
    varBoolean: Result := ftBoolean;
    varString: Result := ftString;
    varOleStr: Result := ftWideString;
  else
    Result := ftUnknown;
  end;
end;
{$ENDIF}

{$IFDEF DOTNETD}
function CompareMem(const Mem1: array of Byte; const Mem2: array of Byte;
  Count: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Mem1[I] <> Mem2[I] then
      Exit;
  Result := True;
end;
{$ENDIF}


procedure WriteWideStringToStream(astring:WideString;deststream:TStream);
{$IFDEF DOTNETD}
var
 i:integer;
 buf:array of Byte;
{$ENDIF}
begin
 if Length(astring)<1 then
  exit;
{$IFDEF DOTNETD}
 SetLength(buf,Length(astring)*2);
 for i:=0 to Length(astring)-1 do
 begin
  buf[i*2]:=Byte(astring[i+1]);
  buf[i*2+1]:=Byte(Word(astring[i+1]) shr 8);
 end;
 deststream.Write(buf,Length(astring));
{$ENDIF}
{$IFNDEF DOTNETD}
 deststream.Write(astring[1],Length(astring)*2);
{$ENDIF}
end;


procedure WriteStringToStream(astring:AnsiString;deststream:TStream);
{$IFDEF DOTNETD}
var
 i:integer;
 buf:array of Byte;
{$ENDIF}
begin
 if Length(astring)<1 then
  exit;
{$IFDEF DOTNETD}
 SetLength(buf,Length(astring));
 for i:=0 to Length(astring)-1 do
 begin
  buf[i]:=Byte(astring[i+1]);
 end;
 deststream.Write(buf,Length(astring));
{$ENDIF}
{$IFNDEF DOTNETD}
 deststream.Write(astring[1],Length(astring));
{$ENDIF}
end;

{$IFDEF MSWINDOWS}
{$IFNDEF DOTNETD}
function ExeResourceToStream (resId: Integer):TMemoryStream;
var
  Res: TResourceStream;
  MRes: TMemoryStream;
begin
  if FindResource (hInstance,    PCHAR(resID), RT_RCDATA) = 0 then
  begin
   Result := nil;
   Exit;
  end;
  Res := TResourceStream.CreateFromID(HInstance, resId, RT_RCDATA);
  try
   MRes := TMemoryStream.Create;
   try
    MRes.LoadFromStream(Res);
    MRes.Seek(0,soFromBeginning);
    Result := MRes;
   except
    MRes.Free;
    Result:=nil;
   end;
  finally
   Res.Free;
  end;
end;
{$ENDIF}
{$ENDIF}

function AlignToStr(value:TRpPosAlign):string;
begin
 case value of
  rpalnone:
   REsult:=SRpNone;
  rpalbottom:
   Result:=SRPBottom;
  rpalright:
   Result:=SRPSRight;
  rpalbotright:
   Result:=SRPBottom+'/'+SRpSRight;
  rpalleftright:
   Result:=SRpLeftRight;
  rpaltopbottom:
   Result:=SRpTopBottom;
  rpalclient:
   Result:=SRpAllClient;
 end;
end;

procedure GetBackStyleDescriptions(alist:TRpWideStrings);
begin
 alist.clear;
 alist.Add(SRpSBDesign);
 alist.Add(SRpSBPreview);
 alist.Add(SRpSBPrint);
end;

procedure GetBackStyleDescriptionsA(alist:TStrings);
begin
 alist.clear;
 alist.Add(SRpSBDesign);
 alist.Add(SRpSBPreview);
 alist.Add(SRpSBPrint);
end;

function StrToBackStyle(value:string):TrpBackStyle;
begin
 if value=SRpSBDesign then
  Result:=baDesign
 else
  if Value=SRpSBPreview then
   Result:=baPreview
  else
   Result:=baPrint;
end;

function BackStyleToStr(value:TrpBackStyle):string;
begin
 case value of
  baDesign:
   Result:=SRpSBDesign;
  baPreview:
   Result:=SRpSBPreview;
  baPrint:
   Result:=SRpSBPrint;
 end;
end;

function StrToAlign(value:string):TRpPosAlign;
begin
 Result:=rpalnone;
 if value=SRPBottom then
 begin
  Result:=rpalbottom;
  exit;
 end;
 if value=SRPSRight then
 begin
  Result:=rpalright;
  exit;
 end;
 if value=SRPBottom+'/'+SRpSRight then
 begin
  Result:=rpalbotright;
  exit;
 end;
 if value=SRpLeftRight then
 begin
  Result:=rpalleftright;
  exit;
 end;
 if value=SRpTopBottom then
 begin
  Result:=rpaltopbottom;
  exit;
 end;
 if value=SRpAllClient then
 begin
  Result:=rpalclient;
  exit;
 end;
end;


{$IFDEF LINUX}
procedure SendMail(destination,subject,content,filename,originalfile:String);
var
 aparams:TStringList;
begin
 aparams:=TStringList.Create;
 try
  aparams.Add('kmail');
  aparams.Add('-s');
  aparams.ADD(subject);
  aparams.Add('--body');
  aparams.Add(content);
  aparams.Add('-c');
  aparams.Add(destination);
  aparams.Add('--attatch');
  aparams.Add(filename);
  ExecuteSystemApp(aparams,false);
 finally
  aparams.free;
 end;
end;
{$ENDIF LINUX}


{$IFDEF MSWINDOWS}




Function LongFileName(ShortName: String): String;
Var
 SR: TSearchRec;
Begin
  Result := '';
  If (pos ('\\', ShortName) + pos ('*', ShortName) +
      pos ('?', ShortName) <> 0) Or Not FileExists(ShortName) Then
  Begin
    { ignore NetBIOS name, joker chars and invalid file names }
    Result:=ShortName;
    Exit;
  End;
  While FindFirst(ShortName, faAnyFile, SR) = 0 Do
  Begin
    { next part as prefix }
    Result := '\' + SR.Name + Result;
    SysUtils.FindClose(SR); { the SysUtils, not the WinProcs procedure! }
    { directory up (cut before '\') }
    ShortName := ExtractFileDir (ShortName);
    If length (ShortName) <= 2 Then
    Begin
      Break; { ShortName contains drive letter followed by ':' }
    End;
  End;
  Result := ExtractFileDrive (ShortName) + Result;
end;

{$IFNDEF FPC}
procedure SendMail(destination,subject,content,filename,originalfile:String);
procedure CheckMAPI(avalue:Cardinal);
begin
 if avalue=SUCCESS_SUCCESS then
  exit;
 case avalue of
  MAPI_E_AMBIGUOUS_RECIPIENT:
   Raise Exception.Create(TranslateStr(1232,
    'A recipient matched more than one of the recipient descriptor structures and MAPI_DIALOG was not set. No message was sent.'));
  MAPI_E_ATTACHMENT_NOT_FOUND:
   Raise Exception.Create(TranslateStr(1233,
    'The specified attachment could not be open; no message was sent'));
  MAPI_E_ATTACHMENT_OPEN_FAILURE:
   Raise Exception.Create(TranslateStr(1234,
    'The specified attachment could not be open; no message was sent.'));
  MAPI_E_BAD_RECIPTYPE:
   Raise Exception.Create(TranslateStr(1235,
    'The specified attachment could not be open; no message was sent.'));
  MAPI_E_FAILURE:
   Raise Exception.Create(TranslateStr(1236,
    'One or more unspecified errors occurred; no message was sent.'));
  MAPI_E_INSUFFICIENT_MEMORY:
   Raise Exception.Create(TranslateStr(1237,
    'There was insufficient memory to proceed. No message was sent.'));
  MAPI_E_LOGIN_FAILURE:
   Raise Exception.Create(TranslateStr(1238,
    'There was no default logon, and the user failed to log on successfully when the logon dialog box was displayed. No message was sent.'));
  MAPI_E_TEXT_TOO_LARGE:
   Raise Exception.Create(TranslateStr(1239,
    'The text in the message was too large to sent; the message was not sent.'));
  MAPI_E_TOO_MANY_FILES:
   Raise Exception.Create(TranslateStr(1240,
    'There were too many file attachments; no message was sent.'));
  MAPI_E_TOO_MANY_RECIPIENTS:
   Raise Exception.Create(TranslateStr(1241,
    'There were too many recipients; no message was sent.'));
  MAPI_E_UNKNOWN_RECIPIENT:
   Raise Exception.Create(TranslateStr(1242,
    'A recipient did not appear in the address list; no message was sent.'));
  MAPI_E_USER_ABORT:
   Raise Exception.Create(TranslateStr(1243 ,
    'The user canceled one of the dialog boxes; no message was sent.'));
  MAPI_E_TOO_MANY_SESSIONS:
   Raise Exception.Create(TranslateStr(1244 ,
    'The user had too many sessions open simultaneously. No session handle was returned.'));
  MAPI_E_INVALID_RECIPS:
   Raise Exception.Create(TranslateStr(1245 ,
    'Invalid recipient. No message was sent.'));
  else
   Raise Exception.Create(TranslateStr(1236,
    'One or more unspecified errors occurred; no message was sent.')+
     ' Error: '+IntToStr(avalue));
 end;
end;

var
 Sessionh:LHandle;
 amessage:MapiMessage;
begin
 CheckMAPI(MapiLogOn(0,nil,nil,MAPI_LOGON_UI,0,@Sessionh));
 try
  amessage.lpszSubject:=nil;
  if Length(subject)>0 then
  amessage.lpszSubject:=PAnsiChar(subject);
  if Length(content)<1 then
   content:=' ';
{$IFDEF UNICODE}
  amessage.ulReserved:=CP_UTF8;
  amessage.lpszNoteText:=PAnsichar(UTF8Encode(content));
  amessage.lpszMessageType:=nil;
  amessage.lpszDateReceived:=nil;
  amessage.lpszConversationID:=nil;
  amessage.lpszDateReceived:=nil;
  amessage.nRecipCount:=0;
  amessage.lpRecips:=nil;
{$ENDIF}
{$IFNDEF UNICODE}
  amessage.ulReserved:=0;
  amessage.lpszNoteText:= PAnsiChar(content);
  amessage.lpszMessageType:=nil;
  amessage.lpszDateReceived:=nil;
  amessage.lpszConversationID:=nil;
  amessage.lpszDateReceived:=nil;
  amessage.nRecipCount:=0;
  amessage.lpRecips:=nil;
{$ENDIF}

  if Length(destination)>0 then
  begin
   amessage.nRecipCount:=1;
   amessage.lpRecips:=AllocMem(sizeof(MAPIRecipDesc));
{$IFDEF UNICODE}
   amessage.lpRecips.lpszName:=PAnsichar(UTF8Encode(destination));
   amessage.lpRecips.lpszAddress:=PAnsichar(UTF8Encode('SMTP:'+destination));
{$ENDIF}
{$IFNDEF UNICODE}
   amessage.lpRecips.lpszName:=PAnsiChar(destination);
   amessage.lpRecips.lpszAddress:=PAnsiChar('SMTP:'+destination);
{$ENDIF}
   amessage.lpRecips.ulRecipClass:=1;
   amessage.lpRecips.ulEIDSize:=0;
   amessage.lpRecips.lpEntryID:=nil;
  end;

  amessage.flFlags:=MAPI_RECEIPT_REQUESTED;
  amessage.lpOriginator:=nil;
{  amessage.lpOriginator:=AllocMem(sizeof(MAPIRecipDesc));
  amessage.lpOriginator.ulReserved:=0;
  amessage.lpOriginator.lpszName:=PChar('');
  amessage.lpOriginator.lpszAddress:=PChar('');
  amessage.lpOriginator.ulEIDSize:=0;
  amessage.lpOriginator.ulRecipClass:=0;
  amessage.lpOriginator.lpEntryID:=nil;
}
  amessage.nFileCount:=0;
  amessage.lpFiles:=nil;

  if Length(filename)>0 then
  begin
   amessage.nFileCount:=1;
   amessage.lpFiles:=AllocMem(sizeof(MapiFileDesc));
   amessage.lpFiles.ulReserved:=0;
   amessage.lpFiles.flFlags:=0;
{$IFDEF UNICODE}
   amessage.lpFiles.lpszPathName:=PAnsichar(UTF8Encode(filename));
   amessage.lpFiles.lpszFileName:=PAnsichar(UTF8Encode(originalfile));
{$ENDIF}
{$IFNDEF UNICODE}
   amessage.lpFiles.lpszPathName:=PAnsiChar(filename);
   amessage.lpFiles.lpszFileName:=PAnsiChar(originalfile);
{$ENDIF}
   amessage.lpFiles.nPosition:=0;
   amessage.lpFiles.lpFileType:=nil;
  end;
  CheckMAPI(MapiSendMail(sessionh,0,amessage,MAPI_DIALOG,0));
 finally
  CheckMAPI(MapiLogOff(sessionh,0,0,0));
 end;
//  ShellExecute(0,PChar('start'),PChar('mailto:'+destination+'?Subject='+subject),nil,nil,SW_SHOWNORMAL);
end;
{$ENDIF}
{$ENDIF}


function StringCachedImageToCachedImage(Value:widestring):TRpCachedImage;
begin
 Result:=rpCachedNone;

 if Value=SRpCachedFixed then
  Result:=rpCachedFixed
 else
  if Value=SRPCachedVariable then
   Result:=rpCachedVariable;
end;


function RpCachedImageToString(Value:TRpCachedImage):String;
begin
 case Value of
  rpCachedNone:
   Result:=SRPNone;
  rpCachedFixed:
   Result:=SRPCachedFixed;
  rpCachedVariable:
   Result:=SRPCachedVariable;
 end;
end;

procedure GetCachedImageDescriptionsA(alist:TStrings);
begin
 alist.Clear;
 alist.Add(SRpNone);
 alist.Add(SRpCachedFixed);
 alist.Add(SRpCachedVariable);
end;

procedure GetCachedImageDescriptions(alist:TRpWideStrings);
begin
 alist.Clear;
 alist.Add(SRpNone);
 alist.Add(SRpCachedFixed);
 alist.Add(SRpCachedVariable);
end;


function StringDrawStyleToDrawStyle(Value:widestring):TRpImageDrawStyle;
begin
 Result:=rpDrawCrop;

 if Value=SRPSDrawStretch then
  Result:=rpDrawStretch
 else
  if Value=SRPSDrawFull then
   Result:=rpDrawFull
  else
  if Value=SRPDrawTile then
   Result:=rpDrawTile
  else
  if Value=SRPDrawTiledpi then
   Result:=rpDrawTiledpi;
end;

function RpDrawStyleToString(Value:TRpImageDrawStyle):String;
begin
 case Value of
  rpDrawCrop:
   Result:=SRPSDrawCrop;
  rpDrawStretch:
   Result:=SRPSDrawStretch;
  rpDrawFull:
   Result:=SRPSDrawFull;
  rpDrawTile:
   Result:=SRPDrawTile;
  rpDrawTiledpi:
   Result:=SRPDrawTiledpi;
 end;
end;

procedure GetDrawStyleDescriptionsA(alist:TStrings);
begin
 alist.clear;
 alist.Add(SRpSDrawCrop);
 alist.Add(SRpSDrawStretch);
 alist.Add(SRpSDrawFull);
 alist.Add(SRpDrawTile);
 alist.Add(SRpDrawTiledpi);
end;

procedure GetDrawStyleDescriptions(alist:TRpWideStrings);
begin
 alist.clear;
 alist.Add(SRpSDrawCrop);
 alist.Add(SRpSDrawStretch);
 alist.Add(SRpSDrawFull);
 alist.Add(SRpDrawTile);
 alist.Add(SRpDrawTiledpi);
end;



function IsCompressed(astream:TMemoryStream):Boolean;
var
 abyte:Byte;
begin
 Result:=false;
 astream.Seek(0,soFromBeginning);
 if 1=astream.Read(abyte,1) then
 begin
  if Char(abyte)='x' then
   Result:=true;
  astream.Seek(0,soFromBeginning);
 end;
end;

procedure DecompressStream(astream,deststream:TMemoryStream);
{$IFDEF USEZLIB}
var
 zStream:TDeCompressionStream;
 abuf:array of Byte;
 readed:Integer;
{$ENDIF}
begin
{$IFDEF USEZLIB}
 astream.Seek(0,sofromBeginning);
 deststream.SetSize(0);
 zStream:=TDeCompressionStream.Create(aStream);
 try
  setLength(abuf,131072);
  readed:=zStream.Read(abuf[0],131072);
  while readed>0 do
  begin
   deststream.Write(abuf[0],readed);
   readed:=zStream.Read(abuf[0],131072);
  end;
 finally
  zStream.free;
 end;
 deststream.Seek(0,soFromBeginning);
{$ENDIF}
{$IFNDEF USEZLIB}
   Raise Exception.Create(SRpZLibNotSupported);
{$ENDIF}
end;

procedure CompressStream(astream,deststream:TMemoryStream);
{$IFDEF USEZLIB}
var
 zStream:TCompressionStream;
 abuf:array of Byte;
 readed:Integer;
{$ENDIF}
begin
{$IFDEF USEZLIB}
 deststream.SetSize(0);
 astream.Seek(0,sofromBeginning);
 zStream:=TCompressionStream.Create(clDefault,destStream) ;
 try
  setLength(abuf,131072);
  readed:=aStream.Read(abuf[0],131072);
  while readed>0 do
  begin
   zStream.Write(abuf[0],readed);
   readed:=aStream.Read(abuf[0],131072);
  end;
 finally
  zStream.free;
 end;
 deststream.Seek(0,soFromBeginning);
{$ENDIF}
{$IFNDEF USEZLIB}
   Raise Exception.Create(SRpZLibNotSupported);
{$ENDIF}
end;

function Type1FontToText(value:TRpType1Font):string;
begin
 case value of
  poHelvetica:
   Result:='Helvetica';
  poCourier:
   Result:='Courier';
  poTimesRoman:
   Result:='Times Roman';
  poSymbol:
   Result:='Symbol';
  poZapfDingbats:
   Result:='ZapfDingbats';
  poLinked:
   Result:='TrueType link';
  poEmbedded:
   Result:='TrueType Embedded';
 end;
end;

function TextToType1Font(value:string):TRpType1Font;
begin
 Result:=poHelvetica;
 if value='Helvetica' then
 begin
  Exit;
 end;
 if value='Courier' then
 begin
  Result:=poCourier;
  Exit;
 end;
 if value='Times Roman' then
 begin
  Result:=poTimesRoman;
  Exit;
 end;
 if value='Symbol' then
 begin
  Result:=poSymbol;
  Exit;
 end;
 if value='ZapfDingbats' then
 begin
  Result:=poZapfDingbats;
  Exit;
 end;
 if value='TrueType link' then
 begin
  Result:=poLinked;
  exit;
 end;
 if value='TrueType Embedded' then
 begin
  Result:=poEmbedded;
  exit;
 end;
end;


// Rounding a number with not balanced system
// always the upper value if in the middle
function Roundfloat(num:double;redondeo:double):double;
var
 provanum,provaredon,quocient:currency;
 intnum,intredon:Comp;
 reste:integer;
 signenum,escala:integer;
begin
 if ((redondeo=0) or (num=0)) then
 begin
  result:=num;
  exit;
 end;
 if redondeo<0.0001 then
 begin
  redondeo:=0.0001;
 end;

 // Original number
 signenum:=1;
 if num<0 then
  signenum:=-1;
 // Has decimal?
 provanum:=abs(num);
 provaredon:=abs(redondeo);
 escala:=1;
 While (frac(provanum)<>0) do
 begin
  provanum:=provanum*10;
  provaredon:=provaredon*10;
  escala:=escala*10;
 end;
 While (frac(provaredon)<>0) do
 begin
  provanum:=provanum*10;
  provaredon:=provaredon*10;
  escala:=escala*10;
 end;
 // Integers
 intnum:=Trunc(provanum);
 intredon:=Trunc(provaredon);
// intnum:=Int(provanum);
// intredon:=Int(provaredon);
 // Mod
 quocient:=intnum/intredon;
 reste:=Round(intnum-intredon*Int(quocient));
 if (reste<(intredon/2)) then
  intnum:=intnum-reste
 else
  intnum:=intnum-reste+intredon;
 result:=intnum/escala*signenum;
end;

// 0.## Decimal separator
// 0:## Hidden decimal separator
// Thousand separator must be placed ok
// ###,###,##0.00
// Decimal separator
// Optional left fill char, for example blank
// L 000,000
// Optional thousand char for example blank
// T.000,000
function FormatCurrAdv(mask:String;number:double):String;
var
 decseparator:boolean;
 hiddendecseparator:boolean;
 decimalplacesvariable:boolean;
 index:integer;
 leftfillchar:char;
 astring:string;
 intstring,decstring:string;
 decchar:char;
 thchar:char;
 leftmask:string;
 rightmask:String;
 i:integer;
 allzeros:boolean;
 isnegative:boolean;
begin
 isnegative:=number<0;
 if (isnegative) then
  number:=-number;

 decseparator:=true;
 hiddendecseparator:=false;
 leftfillchar:='0';
 rightmask:='';
 decimalplacesvariable:=true;
{$IFDEF DOTNETD}
 decchar:=decimalseparator[1];
{$ENDIF}
{$IFNDEF DOTNETD}
 decchar:=decimalseparator;
{$ENDIF}
 if decchar=chr(0) then
  decchar:='.';
{$IFNDEF DOTNETD}
 thchar:=thousandseparator;
{$ENDIF}
{$IFDEF DOTNETD}
 thchar:=thousandseparator[1];
{$ENDIF}
 // Decimal separator options
 index:=Pos('.',mask);
 if index<1 then
 begin
  index:=Pos(':',mask);
  if index>=0 then
   hiddendecseparator:=true;
 end;
 if index>0 then
 begin
  if index<Length(mask) then
  begin
   if mask[index+1]='0' then
    decimalplacesvariable:=false;
  end
  else
   decseparator:=false;
 end
 else
  decseparator:=false;
 if Not decseparator then
  decimalplacesvariable:=false;
 // Right mask
 if index>0 then
  rightmask:=Copy(mask,index+1,Length(mask));
 // Left mask option
 if index=0 then
  index:=Length(mask);
 leftmask:='';
 while index>0 do
 begin
  if mask[index] in ['#',',','0'] then
   leftmask:=leftmask+mask[index];
  dec(index);
 end;

 // Fill char options
 index:=Pos('L',mask);
 if index>0 then
 begin
  if index<Length(mask) then
   leftfillchar:=mask[index+1];
 end;
 // Thousand  char
 index:=Pos('T',mask);
 if index>0 then
 begin
  if index<Length(mask) then
   thchar:=mask[index+1];
 end;
 index:=Pos('D',mask);
 if index>0 then
 begin
  if index<Length(mask) then
   decchar:=mask[index+1];
 end;

 // Now formats the number
 intstring:='';
 decstring:='';
 astring:='##.';
 if decimalplacesvariable then
  astring:=astring+'#'
 else
  astring:=astring+rightmask;
 astring:=FormatFloat(astring,number);
 index:=Pos(decimalseparator,astring);
 if index>=0 then
 begin
  decstring:=Copy(astring,index+1,Length(astring));
  intstring:=Copy(astring,1,index-1);
 end;
 // Convert the number integer number
 i:=1;
 index:=Length(intstring);
 astring:='';
 allzeros:=true;
 while index>0 do
 begin
  // Negative case
  if intstring[index]='-' then
  begin
   astring:=intstring[index]+astring;
   break;
  end;
  while i<=Length(leftmask) do
  begin
   if leftmask[i]=',' then
   begin
    astring:=thchar+astring;
    inc(i)
   end
   else
   begin
    if leftmask[i]='#' then
     allzeros:=false;
    inc(i);
    break;
   end;
  end;
  astring:=intstring[index]+astring;
  dec(index);
 end;
 if not decseparator then
  inc(i);
 // Now fills if all 0
 while (allzeros and (i<=Length(leftmask))) do
 begin
  if leftmask[i]='#' then
   allzeros:=false
  else
   astring:=leftfillchar+astring;
  inc(i);
 end;

 if hiddendecseparator then
  Result:=astring+decstring
 else
 begin
  if (decseparator and (Length(decstring)>0)) then
   Result:=astring+decchar+decstring
  else
   Result:=astring;
 end;
 if (isnegative) then
  Result:='-'+Result;
end;


procedure GetPaperSourceDescriptions(alist:TStrings);
begin
 alist.Clear;
 alist.Add(SRpSDefault);
 alist.Add(SRpBinFirst);
 alist.Add(SRpBinLower);
 alist.Add(SRpBinMiddle);
 alist.Add(SRpBinManual);
 alist.Add(SRpBinEnvelope);
 alist.Add(SRpBinEnvelopeManual);
 alist.Add(SRpBinAuto);
 alist.Add(SRpBinTractor);
 alist.Add(SRpBinSmallFMT);
 alist.Add(SRpBinLargeFMT);
 alist.Add(SRpBinLargeCapacity);
 alist.Add('---');
 alist.Add('---');
 alist.Add(SRpBinCassette);
 alist.Add(SRpFormSource);
end;

procedure GetDuplexDescriptions(alist:TStrings);
begin
 alist.Clear;
 alist.Add(SRpSDefault);
 alist.Add(SRpDuplexS);
 alist.Add(SRpDuplexVer);
 alist.Add(SRpDuplexHor);
end;


{$IFDEF MSWINDOWS}
function RpCharToOem(source:AnsiString):AnsiString;
var
 abuf:PAnsichar;
 i:integer;
begin
 Result:='';
 if Length(source)<1 then
  exit;
 abuf:=AllocMem(Length(source)+1);
 try
  CharToOemA(PAnsiChar(source),abuf);
  Result:=StrPas(abuf);
  for i:=1 to Length(Result) do
  begin
   // The Euro symbol
   if Source[i]=chr(128) then
    Result[i]:=chr($D5);
  end;
 finally
  FreeMem(abuf);
 end;
end;
{$ENDIF}



{$IFNDEF USEVARIANTS}
function CompareValue(const A,B,Epsilon: Double): TValueRelationship;
begin
 if Abs(Abs(A)-Abs(B))<=Epsilon then
  Result:=0
 else
 begin
  if A<B then
   Result:=-1
  else
   Result:=1;
 end;
end;
{$ENDIF}

{$IFNDEF USEVARIANTS}
function GetEnvironmentVariable(aname:String):string;
const DEFSIZE=200;
var
 abuffer:Pchar;
 ares:DWORD;
begin
 abuffer:=AllocMem(DEFSIZE+2);
 try
  ares:=Windows.GetEnvironmentVariable(PChar(aname),abuffer,DEFSIZE);
  if ares=0 then
   Result:=''
  else
  begin
   if ares>DEFSIZE then
   begin
    FreeMem(abuffer);
    abuffer:=nil;
    abuffer:=AllocMem(ares+2);
    Windows.GetEnvironmentVariable(PChar(aname),abuffer,ares+1);
   end;
   Result:=StrPas(abuffer);
  end;
 finally
  FreeMem(abuffer);
 end;
end;

{$ENDIF}

function RpHTMLEncode(const AStr:String):String;
begin
	Result := StringReplace(AStr,   '&', '&amp;', [rfReplaceAll]);    {Do not Localize}
	Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);    {Do not Localize}
	Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);    {Do not Localize}
	Result := StringReplace(Result, '"', '&quot;', [rfReplaceAll]);    {Do not Localize}
	Result := StringReplace(Result, '''', '&apos;', [rfReplaceAll]);    {Do not Localize}
end;


function GetLineLangByIndex(astring:widestring;index:integer):string;
var
 alist:TRpWideStrings;
begin
 if index<0 then
  index:=0;
 if Length(astring)<0 then
 begin
  Result:='';
  exit;
 end;
 alist:=TRpWideStrings.Create;
 try
  alist.Text:=astring;
  if (alist.Count>index) then
   Result:=alist.Strings[index]
  else
   Result:=alist.Strings[0];
 finally
  alist.free;
 end;
end;


function AddLineLangByIndex(astring:widestring;newstring:widestring;index:integer):string;
var
 alist:TRpWideStrings;
 defvalue:widestring;
begin
 defvalue:=astring;
 alist:=TRPWideStrings.Create;
 try
  alist.Text:=astring;
  if alist.Count>0 then
   defvalue:=alist.Strings[0];
  while (alist.Count<(index+1)) do
  begin
   alist.Add(defvalue);
  end;
  alist.Strings[index]:=newstring;
  Result:=alist.Text;
 finally
  alist.free;
 end;
end;


{$IFDEF USEINDY}
procedure CheckUUDecode(amemstream:TMemoryStream);
var
 astring:String;
 memstream:TMemoryStream;
 i:integer;
 decoder:TIdDecoderUUE;
 alist:TStringList;
begin
 if amemstream.Size>5 then
 begin
  SetLength(astring,5);
  amemstream.Seek(0,soFromBeginning);
  amemstream.Read(astring[1],5);
  if UpperCase(astring)='BEGIN' then
  begin
   memstream:=TMemoryStream.Create;
   try
    amemstream.Seek(0,soFromBeginning);
    memstream.SetSize(amemstream.size);
    amemstream.Read(memstream.memory^,amemstream.size);
    decoder:=TIdDecoderUUE.Create(nil);
    try
     alist:=TStringList.Create;
     try
      alist.LoadFromStream(memstream);
      memstream.SetSize(0);
      for i:=1 to alist.Count-2 do
      begin
       astring:=decoder.DecodeString(alist.Strings[i]);
       if Length(astring)>0 then
        memstream.Write(astring[1],Length(astring))
      end;
      memstream.Seek(0,soFromBeginning);
      amemstream.SetSize(0);
      amemstream.Write(memstream.memory^,memstream.size);
      amemstream.Seek(0,soFromBeginning);
     finally
      alist.free;
     end;
    finally
     decoder.Free;
    end;
   finally
    memstream.free;
   end;
  end;
 end;
 amemstream.Seek(0,soFromBeginning);
end;


function MIMEEncodeString(amemstream:TMemoryStream):string;
var
 acoder:TIdEncoderMIME;
 astring:string;
begin
 amemstream.Seek(0,soFromBeginning);
 acoder:=TIdEncoderMIME.Create(nil);
 try
  astring:=acoder.Encode(amemstream);
 finally
  acoder.free;
 end;
 Result:=astring;
end;

procedure MIMEEncode(amemstream:TMemoryStream;DestStream:TStream);
var
 acoder:TIdEncoderMIME;
 astring:string;
begin
 amemstream.Seek(0,soFromBeginning);
 acoder:=TIdEncoderMIME.Create(nil);
 try
  astring:=acoder.Encode(amemstream);
  if Length(astring)>0 then
   DestStream.Write(astring[1],Length(astring));
 finally
  acoder.free;
 end;
end;

function MIMEDecodeString(avalue:string):string;
var
 decoder:TIdDecoderMIME;
 alist:TStringList;
 aresult:string;
 i:integer;
 astring:string;
begin
 aresult:='';
 alist:=TStringList.Create;
 try
  alist.Text:=avalue;
  decoder:=TIdDecoderMIME.Create(nil);
  try
   for i:=0 to alist.count-1 do
   begin
    astring:=decoder.DecodeString(alist.strings[i]);
    if Length(astring)>0 then
     aresult:=aresult+astring;
   end;
  finally
   decoder.free;
  end;
  Result:=aresult;
 finally
  alist.free;
 end;
end;

procedure MIMEDecode(amemstream:TMemoryStream);
var
 memstream:TMemoryStream;
 decoder:TIdDecoderMIME;
 astring:string;
 alist:TStringList;
 i:integer;
begin
 if amemstream.Size<5 then
  exit;
 amemstream.Seek(0,soFromBeginning);
 alist:=TStringList.Create;
 memstream:=TMemoryStream.Create;
 try
   alist.LoadFromStream(amemstream);
   decoder:=TIdDecoderMIME.Create(nil);
   try
    for i:=0 to alist.count-1 do
    begin
     astring:=decoder.DecodeString(alist.strings[i]);
     if Length(astring)>0 then
      memstream.Write(astring[1],Length(astring));
    end;
   finally
    decoder.free;
   end;
   // Copy the decoded to the result
   memstream.Seek(0,soFromBeginning);
   amemstream.SetSize(0);
   amemstream.Write(memstream.memory^,memstream.size);
   amemstream.Seek(0,soFromBeginning);
 finally
  alist.free;
  memstream.free;
 end;
 amemstream.Seek(0,soFromBeginning);
end;


{$ENDIF}





initialization

{$IFNDEF DOTNETD}
{$IFDEF MSWINDOWS}
obtainedversion:=false;
{$ENDIF}
{$ENDIF}
printerconfigfile:=nil;


finalization

if assigned(printerconfigfile) then
begin
 printerconfigfile.free;
 printerconfigfile:=nil;
end;




end.
