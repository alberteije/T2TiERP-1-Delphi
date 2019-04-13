{*******************************************************}
{                                                       }
{       Rpevalfunc                                      }
{       Functions for the TRpEvaluator for              }
{        Manager                                        }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpevalfunc;

interface

{$I rpconf.inc}

uses
  SysUtils, Classes,
  rpmdconsts,DB,
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
{$IFDEF USEVARIANTS}
  Variants,
{$IFNDEF FPC}
  MaskUtils,
{$ENDIF}
{$ENDIF}
{$IFNDEF USEVARIANTS}
  Mask,
{$ENDIF}
{$IFDEF USEINDY}
  IdCoderMIME,
{$ENDIF}
  rptypeval,rptypes,rpmdcharttypes;

type

 { Function Uppercase }
 TIdenUppercase=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function FileExists }
 TIdenFileExists=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function Lowercase }
 TIdenLowercase=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function HourMinSec }
 TIdenHourMinSec=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function Sinus }
 TIdenSinus=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

  { Function Sinus }
 TIdenMax=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;


 { Function FloatToDataTime }
 TIdenFloatToDateTime=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function Round }
 TIdenRound=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function Round }
 TIdenRoundToInteger=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function Abs }
 TIdenAbs=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function CompareValue }
 TIdenCompareValue=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function INT }
 TIdenInt=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function Val }
 TIdenVal=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function STR }
 TIdenSTR=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function STR }
 TIdenUTF8ToWideString=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function LEFT }
 TIdenTrim=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function LEFT }
 TIdenLEFT=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function Length }
 TIdenLength=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function IsInteger }
 TIdenIsInteger=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function IsNumeric }
 TIdenIsNumeric=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;


 { Function IsValidDateTime }
 TIdenIsValidDateTime=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function CheckExpression }
 TIdenCheckExpression=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;


 { Function Pos }
 TIdenPos=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function GraphicLear }
 TIdenGraphicClear=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;
 TIdenGraphicNew=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;
 TIdenGraphicColor=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;
 TIdenGraphicSerieColor=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;
 {SQL function}
 TIdenGetValueFromSQL=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TIdenGraphicBounds=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TIdenGraphicOperation=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TIdenOrientationOperation=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TIdenPageOperation=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;


 TIdenImageOperation=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TIdenBarcodeOperation=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TIdenReOpenOp=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TIdenTextOperation=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TIdenTextHeight=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function Modul }
 TIdenModul=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Function SQRT }
 TIdenSQRT=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;


//Added by Luciano Enzweiler - 17 Dec, 2003 - Start
// On Brazilian Portuguese we use a lot á, ç, ú, etc. and it wasn't
// printable on matrix printers.
//This function is very useful to convert the text to printable chars.
 { Function  }
 TIdenASC2=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;
//Added by Luciano Enzweiler - 17 Dec, 2003 - End

 { Constant }
 TIdenToday=class(TIdenConstant)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Constant }
 TIdenTime=class(TIdenConstant)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TIdenNow=class(TIdenConstant)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TIdenNULL=class(TIdenConstant)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 { Returns the month }
 TIdenMonth=Class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

 TIdenEvalText=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
 public
   constructor Create(AOWner:TComponent);override;
 end;

 TIdenSetLanguage=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
 public
   constructor Create(AOWner:TComponent);override;
 end;

 TIdenMonthname=Class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

 TIdenYear=Class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

 TIdenDay=Class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

 TIdenRight=Class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

{$IFDEF USEINDY}
 TIdenDecode64=Class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;
{$ENDIF}

 TIdenStringToBin=Class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

 TIdenSubstr=Class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

 TIdenFormatStr=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

 TIdenFormatNum=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

 TIdenFormatMask=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

 TIdenNumToText=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;


 TRpNewValue=procedure (Y:Single;Cambio:Boolean;leyen,textleyen,
  textserie:string;ChartType:TRpChartType) of object;
 TRpColorEvent=procedure (Color:Integer) of object;
 TRpBoundsValue=procedure (autol,autoh:boolean;lvalue,hvalue:double;
  logaritmic:boolean;logbase:double;inverted:boolean) of object;

 TVariableGrap=class(TIdenVariable)
  protected
   FOnNewValue:TRpNewValue;
   FOnClear:TNotifyEvent;
   FOnBounds:TRpBoundsValue;
   FOnSerieColor:TRpColorEvent;
   FOnValueColor:TRpColorEvent;
   procedure SetRpValue(Value:TRpValue);override;
   function GetRpValue:TRpValue;override;
  public
   DefaultChartType:TRpChartType;
   constructor Create(AOwner:TComponent);override;
   procedure NewValue(Y:Single;Cambio:Boolean;leyen,textleyen,textserie:string;charttype:TRpChartType);
   procedure Clear;
   property OnClear:TNotifyEvent read FOnClear write FOnClear;
   property OnNewValue:TRpNewValue read FOnNewValue write FOnNewValue;
   property OnBounds:TRpBoundsValue read FOnBounds write FOnBounds;
   property OnSerieColor:TRpColorEvent read FOnSerieColor write FOnSerieColor;
   property OnValueColor:TRpColorEvent read FOnValueColor write FOnValueColor;
  end;


 //added FRB 20030204
 TIdenReplaceStr=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;

 TIdenParamInfo=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

  TIdenFieldExists=class(TIdenFunction)
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

{$IFDEF MSWINDOWS}
  TIdenChsToCht=class(TIdenFunction)
  protected
    function GetRpValue:TRpvalue;override;
   public
    constructor Create(AOWner:TComponent);override;
  end;

  TIdenChtToChs=class(TIdenFunction)
  protected
    function GetRpValue:TRpvalue;override;
   public
    constructor Create(AOWner:TComponent);override;
  end;
{$ENDIF}

 TIdenGetINIValue=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;
 TIdenLoadFile=class(TIdenFunction)
 protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOWner:TComponent);override;
  end;


implementation

uses rpeval,Math,IniFiles;

function VarIsString(avar:Variant):Boolean;
var
 avartype:integer;
begin
 Result:=false;
 avartype:=VarType(avar);
 // 258 = WideString Delphi 2009
 if (avartype=varstring) or (avartype=varOleStr) or (avartype=258) then
  Result:=true;
end;

{**************************************************************************}

{ TIdenUppercase }

constructor TIdenUppercase.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Uppercase';
 Help:=SRpUppercase;
 Model:='function '+'Uppercase'+'(s:string):string';
 AParams:=SRpPUppercase;
end;

{**************************************************************************}


function TIdenUppercase.GeTRpValue:TRpValue;
begin
 if Params[0]=NULL then
 begin
  result:='';
  exit;
 end;
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
{$IFDEF USEVARIANTS}
 Result:=WideUppercase(Params[0]);
{$ENDIF}
{$IFNDEF USEVARIANTS}
 Result:=AnsiUppercase(Params[0]);
{$ENDIF}
end;

{**************************************************************************}

{ TIdenFileExists }

constructor TIdenFileExists.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='FileExists';
 Help:=SRpFileExists;
 Model:='function '+'FileExists'+'(s:string):Boolean';
 AParams:=SRpPFileExists;
end;

{**************************************************************************}

function TIdenLowercase.GeTRpValue:TRpValue;
begin
 if Params[0]=NULL then
 begin
  result:='';
  exit;
 end;
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
{$IFDEF USEVARIANTS}
  Result:=WideLowercase(Params[0]);
{$ENDIF}
{$IFNDEF USEVARIANTS}
  Result:=AnsiLowercase(Params[0]);
{$ENDIF}
end;

{ TIdenLowercase }

constructor TIdenLowercase.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Lowercase';
 Help:=SRpLowercase;
 Model:='function '+'Lowercase'+'(s:string):string';
 AParams:=SRpPLowercase;
end;

{**************************************************************************}

function TIdenFileExists.GeTRpValue:TRpValue;
begin
 if Params[0]=NULL then
 begin
  result:=False;
  exit;
 end;
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (VarType(Params[0])=varString) then
   Result:=FileExists(String(Params[0]))
 else
   Result:=FileExists(WideString(Params[0]));
end;

{**************************************************************************}

{ TIdenHourMinSec }

constructor TIdenHourMinSec.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=4;
 IdenName:='HourMinSec';
 Help:=SRpHourMinSec;
 Model:='function '+'HourMinSec'+'(h:Double;idenH:string;idenM:string;idenS:string):string';
 AParams:=SRpPHourMinSec;
end;

{**************************************************************************}

function TIdenHourMinSec.GeTRpValue:TRpValue;
var
 racional:double;
 hores:integer;
 minuts,segons:word;
 minutsstr,segonsstr:string;
begin
 if (not VarIsString(Params[1])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (not VarIsString(Params[2])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (not VarIsString(Params[3])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if VarIsNumber(Params[0]) then
 begin
  racional:=Double(Params[0]);
  //calculations in racional
  hores:=Round(Int(racional));
  minuts:=Round(Int(Frac(racional)*60));
  segons:=Round(Frac(Frac(racional)*60)*60);
  if segons<10 then
   segonsstr:='0'+IntToStr(segons)
  else
   segonsstr:=IntToStr(segons);
  if minuts<10 then
   minutsstr:='0'+IntToStr(minuts)
  else
   minutsstr:=IntToStr(minuts);
  Result:=IntToStr(hores)+Params[1]+minutsstr+Params[2]
   +segonsstr+Params[3];
 end
 else
  Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
end;

{**************************************************************************}

{ TFloatToDateTime }

constructor TIdenFloatToDateTime.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='FloatToDateTime';
 Help:=SRpFloatToDateTime;
 Model:='function '+'FloatToDateTime'+'(n:Double):TDateTime';
 AParams:=SRpPFloatToDateTime;
end;

{**************************************************************************}

function TIdenFloatToDateTime.GeTRpValue:TRpValue;
begin
 if VarIsNumber(Params[0]) then
  Result:=TDateTime(Params[0])
 else
  if Vartype(Params[0])=vardate then
    Result:=TDateTime(Params[0])
  else
  if VarIsNull(Params[0]) then
  begin
   Result:=Null;
  end
  else
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
end;


{**************************************************************************}

{ TIdenSinus }

constructor TIdenSinus.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Sin';
 Help:=SRpSin;
 Model:='function '+'Sin'+'(ang:Double):double';
 AParams:=SRpPSin;
end;

{**************************************************************************}

function TIdenSinus.GeTRpValue:TRpValue;
begin
 if  VarIsNumber(Params[0]) then
  Result:=Sin(Double(Params[0]))
 else
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
end;

{ TIdenMax }

constructor TIdenMax.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='Max';
 Help:=SRpMax;
 Model:='function '+'Max'+'(a,y:double):double';
end;

{**************************************************************************}

function TIdenMax.GeTRpValue:TRpValue;
begin
 if  VarIsNumber(Params[0]) then
 begin
  if VarIsNumber(Params[1]) then
   Result:=Max(double(Params[0]),double(Params[1]))
  else
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 end
 else
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
end;


{**************************************************************************}

{ TIdenRound }

constructor TIdenRound.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='Round';
 Help:=SRpRound;
 model:='function '+'Round'+'(num:double,r:double):double';
 aParams:=SRpPRound;
end;

{**************************************************************************}


{**************************************************************************}

function TIdenRound.GeTRpValue:TRpValue;
begin
 if (not VarIsNumber(Params[0])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (not VarIsNumber(Params[1])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Result:=Roundfloat(Double(Params[0]),Double(Params[1]));
end;


{ TIdenRound }

constructor TIdenRoundToInteger.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='RoundToInteger';
 Help:=SRpRound;
 model:='function '+'RoundToInteger'+'(num:double):integer';
 aParams:='';
end;

{**************************************************************************}


{**************************************************************************}

function TIdenRoundToInteger.GeTRpValue:TRpValue;
begin
 if (not VarIsNumber(Params[0])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
{$IFNDEF USEVARIANTS}
 Result:=Integer(Round(Double(Params[0])));
{$ENDIF}
{$IFDEF USEVARIANTS}
 Result:=Round(Double(Params[0]));
{$ENDIF}
end;

{**************************************************************************}

{ TIdenAbs }

constructor TIdenAbs.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Abs';
 Help:=SRpAbs;
 model:='function '+'Abs'+'(num:double):double';
 aParams:=SRpPAbs;
end;


{**************************************************************************}

function TIdenAbs.GeTRpValue:TRpValue;
begin
 if (not VarIsNumber(Params[0])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Result:=Abs(Double(Params[0]));
end;

{**************************************************************************}


{ TIdenCompareValue }

constructor TIdenCompareValue.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=3;
 IdenName:='CompareValue';
 Help:=SRpCompareValue;
 model:='function '+'Compare'+'(num1,num2,epsilon:double):integer';
 aParams:=SRpPCompareValue;
end;


{**************************************************************************}
{$IFDEF FPC}
function CompareValue(p1,p2,epsilon:double):integer;
var
 dif:double;
begin
 dif:=Abs(p1-p2);
 epsilon:=Abs(epsilon);
 if dif<epsilon then
 begin
  Result:=0;
  exit;
 end;
 if p1<p2 then
  REsult:=-1
 else
  Result:=1;
end;
{$ENDIF}

function TIdenCompareValue.GeTRpValue:TRpValue;
begin
 if (not VarIsNumber(Params[0])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (not VarIsNumber(Params[1])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (not VarIsNumber(Params[2])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 result:=Integer(CompareValue(double(Params[0]),double(Params[1]),double(Params[2])));
end;

{**************************************************************************}


{ TIdenInt }

constructor TIdenInt.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Int';
 Help:=SRpInt;
 model:='function '+'Int'+'(num:double):integer';
 aParams:=SRpPInt;
end;

{**************************************************************************}

function TIdenInt.GeTRpValue:TRpValue;
begin
 if (not (VarType(Params[0]) in [varSmallInt..varDate,varVariant])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 case Vartype(Params[0]) of
  varSmallInt..varDate:
   begin
    Result:=Integer(Trunc(Int(Double(Params[0]))));
   end;
  varVariant:
   begin
    Result:=Integer(Trunc(Int(Double(Params[0]))));
   end;
  else
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
  end;

end;


{ TIdenSTR }

constructor TIdenSTR.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Str';
 Help:=SRpStr;
 model:='function '+'Str'+'(num:variant):string';
 aParams:=SRpPStr;
end;

{**************************************************************************}

function TIdenStr.GeTRpValue:TRpValue;
begin
// if VarType(Params[0])=varString then
//   Raise TRpNamedException.Create(SRpEvalType,
//         IdenName);
 if VarIsNull(Params[0]) then
  Result:=''
 else
 begin
  if (VarIsString(params[0])) then
    Result := params[0]
  else
    Result:=String(Params[0]);
 end;
end;

{ TIdenUTF8ToWideString }

constructor TIdenUTF8ToWideString.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='UTF8ToWideString';
// Help:=SRpStr;
 model:='function '+'StrFSSToWideString'+'(value:string):WideString';
end;

{**************************************************************************}

function TIdenUTF8ToWideString.GeTRpValue:TRpValue;
var
 cadena:string;
 cadenaw:WideString;
begin
 if VarIsNull(Params[0]) then
  Result:=''
 else
 begin
  cadenaw:='';
  cadena:=String(Params[0]);
{$IFDEF USEVARIANTS}
  Result:=UTF8Decode(cadena);
{$ENDIF}
{$IFNDEF USEVARIANTS}
  Result:=cadena;
{$ENDIF}
 end;
end;


{**************************************************************************}

{ TIdenVal }

constructor TIdenVal.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Val';
 Help:=SRpVal;
 model:='function '+'Val'+'(s:string):double';
 aParams:=SRpPVal;
end;

{**************************************************************************}

function TIdenVal.GeTRpValue:TRpValue;
begin
 try
  if VarIsString(Params[0]) then
  begin
   if Params[0]=''+chr(0) then
   begin
    Result:=0;
    Exit;
   end;
   Result:=StrToFloat(Params[0]);
  end
  else
  begin
   Result:=Double(Params[0]);
  end;
  { To integer }
 except
   Raise TRpNamedException.Create(SRpConvertError,
         IdenName);
 end;
end;

{**************************************************************************}

{ TIdenTrim }

constructor TIdenTrim.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Trim';
 Help:=SRpTrim;
 model:='function '+'Trim'+'(s:string):string';
 aParams:=SRpPTrim;
end;

{**************************************************************************}

function TIdenTrim.GeTRpValue:TRpValue;
begin
 if Params[0]=Null then
 begin
  result:='';
  exit;
 end;
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (VarType(Params[0])=varString) then
  Result:=Trim(String(Params[0]))
 else
  Result:=Trim(WideString(Params[0]));
end;

{**************************************************************************}

{ TIdenLeft }

constructor TIdenLEFT.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='Left';
 Help:=SRpLeft;
 model:='function '+'Left'+'(s:string,count:integer):string';
 aParams:=SRpPLeft;
end;

{**************************************************************************}

function TIdenLEFT.GeTRpValue:TRpValue;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if  Not (VarIsInteger(Params[1])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (VarType(Params[0])=varString) then
  Result:=Copy(String(Params[0]),1,Integer(Params[1]))
 else
  Result:= Copy(WideString(Params[0]),1,Integer(Params[1]));
end;

{ TIdenLength }

constructor TIdenLength.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Length';
 Help:=SRpLength;
 model:='function '+'Length'+'(s:string):Integer';
 aParams:=SRpPLength;
end;

{**************************************************************************}

function TIdenLength.GeTRpValue:TRpValue;
begin
 if VarIsNull(Params[0]) then
 begin
  Result:=0;
  exit;
 end;
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (VarType(Params[0])=varString) then 
   Result:=Length(String(Params[0]))
 else
   Result:=Length(WideString(Params[0]));
end;

{ TIdenIsInteger }

constructor TIdenIsInteger.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='IsInteger';
 Help:=SRpIsInteger;
 model:='function '+'IsInteger'+'(s:string):boolean';
end;

{**************************************************************************}

function TIdenIsInteger.GeTRpValue:TRpValue;
begin
 if VarIsNull(Params[0]) then
 begin
  Result:=false;
  exit;
 end;
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Result:=true;
 try
  StrToInt(Params[0]);
 except
  Result:=false;
 end;
end;

{ TIdenIsNumeric }

constructor TIdenIsNumeric.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='IsNumeric';
 Help:=SRpIsNumeric;
 model:='function '+'IsNumeric'+'(s:string):boolean';
end;

{**************************************************************************}

function TIdenIsNumeric.GeTRpValue:TRpValue;
begin
 if VarIsNull(Params[0]) then
 begin
  Result:=false;
  exit;
 end;
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Result:=true;
 try
  StrToFloat(Params[0]);
 except
  Result:=false;
 end;
end;

{ TIdenIsVaidDateTime }

constructor TIdenIsValidDateTime.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='IsValidDateTime';
 Help:=SRpIsValidDateTime;
 model:='function '+'IsValidDateTime'+'(s:string):boolean';
end;

{**************************************************************************}

function TIdenIsValidDateTime.GeTRpValue:TRpValue;
begin
 if VarIsNull(Params[0]) then
 begin
  Result:=false;
  exit;
 end;
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Result:=true;
 try
  StrToDateTime(Params[0]);
 except
  Result:=false;
 end;
end;


{ TIdenCheckExpression }

constructor TIdenCheckExpression.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='CheckExpression';
 Help:=SRpCheckExpression;
 model:='function '+'CheckExpression'+'(expression,message:string):boolean';
end;

{**************************************************************************}

function TIdenCheckExpression.GeTRpValue:TRpValue;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not VarIsString(Params[1]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Result:=TRpEvaluator(evaluator).EvaluateText(Params[0]);
 if VarIsBoolean(Params[0]) then
  Result:=Params[0];
 if (not Result) then
  Raise Exception.Create(Params[1]);
end;


{ TIdenPos }

constructor TIdenPos.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='Pos';
 Help:=SRpPos;
 model:='function '+'Pos'+'(substr:string,str:string):integer';
 aParams:=SRpPPos;
end;

{**************************************************************************}

function TIdenPos.GeTRpValue:TRpValue;
begin
 if Params[0]=null then
 begin
  Result:=0;
  exit;
 end;
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not VarIsString(Params[1]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (VarType(Params[0])=varString) then
   Result:=Pos(String(Params[0]),string(Params[1]))
 else
 begin
   if (VarType(Params[0])=varString) then
    Result:=Pos(WideString(Params[0]),WideString(Params[1]))
   else
    Result:=Pos(WideString(Params[0]),WideString(Params[1]));
 end;
end;


constructor TIdenGraphicClear.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='GraphicClear';
 Help:=SRpGraphicClear;
 model:='function '+'GraphicClear'+'(Gr:string):Boolean';
 aParams:=SRpPGraphicClear;
end;


function TIdenGraphicClear.GeTRpValue:TRpValue;
var
 iden:TRpIdentifier;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 // Buscamos el identificador
 iden:=(evaluator As TRpEvaluator).Searchidentifier(String(Params[0]));
 if iden=nil then
 begin
   Raise TRpNamedException.Create(SRpIdentifierexpected,
         IdenName+'-'+Params[0]);
 end;
 if Not (iden is TVariableGrap) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName+'-'+Params[0]);
 Result:=True;
 (iden As TVariableGrap).Clear;
end;


constructor TIdenGraphicNew.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=5;
 IdenName:='GraphicNew';
 Help:=SRpGraphicNew;
 model:='function '+'GraphicNew'+'(Gr:string, V:Single, C:Boolean,Etiq:string,Caption:string):Boolean';
 aParams:=SRPPgraphicnew;
end;


function TIdenGraphicNew.GeTRpValue:TRpValue;
var
 iden:TRpIdentifier;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not VarIsNumber(Params[1]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Vartype(Params[2])<>varBoolean then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not VarIsString(Params[3]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not VarIsString(Params[4]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 // Buscamos el identificador
 iden:=(evaluator As TRpEvaluator).SearchIdentifier(String(Params[0]));
 if iden=nil then
 begin
   Raise TRpNamedException.Create(SRpIdentifierexpected,
         IdenName+'-'+Params[0]);
 end;
 if Not (iden is TVariableGrap) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName+'-'+Params[0]);

 Result:=True;
 (iden As TVariableGrap).NewValue(single(Params[1]),Boolean(Params[2]),string(Params[3]),'',string(Params[4]),(iden As TVariableGrap).DefaultChartType);
end;

constructor TIdenGraphicColor.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='GraphicColor';
 Help:=SRpGraphicColor;
 model:='function '+'GraphicColor'+'(Gr:string, Color:Integer):Boolean';
end;


function TIdenGraphicColor.GeTRpValue:TRpValue;
var
 iden:TRpIdentifier;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not VarIsInteger(Params[1]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 // Buscamos el identificador
 iden:=(evaluator As TRpEvaluator).SearchIdentifier(String(Params[0]));
 if iden=nil then
 begin
   Raise TRpNamedException.Create(SRpIdentifierexpected,
         IdenName+'-'+Params[0]);
 end;
 if Not (iden is TVariableGrap) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName+'-'+Params[0]);

 Result:=True;
 if assigned((iden As TVariableGrap).OnValueColor) then
  (iden As TVariableGrap).OnValueColor(Params[1]);
end;


constructor TIdenGraphicSerieColor.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='GraphicSerieColor';
 Help:=SRpGraphicColor;
 model:='function '+'GraphicSerieColor'+'(Gr:string, Color:Integer):Boolean';
end;


function TIdenGraphicSerieColor.GeTRpValue:TRpValue;
var
 iden:TRpIdentifier;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not VarIsInteger(Params[1]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 // Buscamos el identificador
 iden:=(evaluator As TRpEvaluator).SearchIdentifier(String(Params[0]));
 if iden=nil then
 begin
   Raise TRpNamedException.Create(SRpIdentifierexpected,
         IdenName+'-'+Params[0]);
 end;
 if Not (iden is TVariableGrap) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName+'-'+Params[0]);

 Result:=True;
 if assigned((iden As TVariableGrap).OnSerieColor) then
  (iden As TVariableGrap).OnSerieColor(Params[1]);
end;

constructor TIdenGetValueFromSQL.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='GetValueFromSQL';
 Help:=SRpGetValueFromSQL;
 model:='function '+'GetValueFromSQL'+'(connectionname:String;sql:String):Variant';
 aParams:=SRpGetValueFromSQLP;
end;



function TIdenGetValueFromSQL.GetRpValue:TRpValue;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not VarIsString(Params[1]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Result:=Null;
 if assigned((evaluator As TRpEvaluator).OnGetSQLValue) then
  Result:=(evaluator As TRpEvaluator).OnGetSQLValue(Params[0],Params[1]);
end;




constructor TIdenGraphicBounds.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=8;
 IdenName:='GraphicBounds';
 Help:=SRpGraphicBounds;
 model:='function '+'GraphicBounds'+'(Gr:string; autol,autoh:boolean; low,high:double;log:boolean; logbase:double; inverted:boolean):Boolean';
 aParams:=SRPPgraphicBounds;
end;


function TIdenGraphicBounds.GeTRpValue:TRpValue;
var
 iden:TRpIdentifier;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Vartype(Params[1])<>varBoolean then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Vartype(Params[2])<>varBoolean then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not VarIsNumber(Params[3]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not VarIsNumber(Params[4]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Vartype(Params[5])<>varBoolean then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Not (VarIsNumber(Params[6])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Vartype(Params[7])<>varBoolean then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 // Buscamos el identificador
 iden:=(evaluator As TRpEvaluator).SearchIdentifier(String(Params[0]));
 if iden=nil then
 begin
   Raise TRpNamedException.Create(SRpIdentifierexpected,
         IdenName+'-'+Params[0]);
 end;
 if Not (iden is TVariableGrap) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName+'-'+Params[0]);

 Result:=True;
 (iden As TVariableGrap).OnBounds(Boolean(Params[1]),Boolean(Params[2]),
  double(Params[3]),double(Params[4]),Boolean(Params[5]),double(Params[6]),  Boolean(Params[7]));
end;


constructor TIdenSQRT.Create(AOwner:TComponent);
begin
 inherited Create(Aowner);
 FParamcount:=1;
 IdenName:='Sqrt';
 Help:=SRpSqrt;
 model:='function '+'Sqrt'+'(num:double):double';
 aParams:=SRpPSQrt;
end;

{**************************************************************************}

function TIdenSQRT.GeTRpValue:TRpValue;
begin
 if varIsNumber(Params[0]) then
  Result:=SQRT(Double(Params[0]))
 else
  Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
end;


{**************************************************************************}
//Added by Luciano Enzweiler - 17 Dec, 2003 - Start
constructor TIdenASC2.Create(AOwner:TComponent);
begin
 inherited Create(Aowner);
 FParamcount:=1;
 IdenName:='ASC2';
 Help:=SRpAsc2;
 model:='function '+'ASC2'+':string';
 aParams:='';
end;

function TIdenASC2.GeTRpValue:TRpValue;
var
  StrTemp, StrRet: String;
  i, NrChr: Integer;
begin
  StrRet := '';
  StrTemp := VarToStr(Params[0]);
  for i := 1 to Length(StrTemp) do begin
    NrChr := Ord(StrTemp[i]);
    if ((NrChr >= 192) and (NrChr <= 198)) then begin
      StrRet := StrRet + 'A';
      Continue;
    end;
    if ((NrChr >= 224) and (NrChr <= 230)) then begin
      StrRet := StrRet + 'a';
      Continue;
    end;
    if ((NrChr >= 200) and (NrChr <= 203)) then begin
      StrRet := StrRet + 'E';
      Continue;
    end;
    if ((NrChr >= 232) and (NrChr <= 235)) then begin
      StrRet := StrRet + 'e';
      Continue;
    end;
    if ((NrChr >= 204) and (NrChr <= 207)) then begin
      StrRet := StrRet + 'I';
      Continue;
    end;
    if ((NrChr >= 236) and (NrChr <= 239)) then begin
      StrRet := StrRet + 'i';
      Continue;
    end;
    if ((NrChr >= 210) and (NrChr <= 214)) then begin
      StrRet := StrRet + 'O';
      Continue;
    end;
    if ((NrChr >= 242) and (NrChr <= 246)) then begin
      StrRet := StrRet + 'o';
      Continue;
    end;
    if ((NrChr >= 217) and (NrChr <= 220)) then begin
      StrRet := StrRet + 'U';
      Continue;
    end;
    if ((NrChr >= 249) and (NrChr <= 252)) then begin
      StrRet := StrRet + 'u';
      Continue;
    end;
    if (NrChr = 199) then begin  //Ç
      StrRet := StrRet + 'C';
      Continue;
    end;
    if (NrChr = 231) then begin  //Ç
      StrRet := StrRet + 'c';
      Continue;
    end;
    if (NrChr = 209) then begin  //Ñ
      StrRet := StrRet + 'N';
      Continue;
    end;
    if (NrChr = 241) then begin  //ñ
      StrRet := StrRet + 'n';
      Continue;
    end;
    if ((NrChr = 176) or (NrChr = 186)) then begin  //° ou º
      StrRet := StrRet + 'o';
      Continue;
    end;
    if (NrChr = 170) then begin  //ª
      StrRet := StrRet + 'a';
      Continue;
    end;
    StrRet := StrRet + StrTemp[i];
  end;
  Result := StrRet;
end;
//Added by Luciano Enzweiler - 17 Dec, 2003 - End
{**************************************************************************}


{**************************************************************************}

{ TIdenModul }

constructor TIdenModul.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='Mod';
 Help:=SRpMod;
 model:='function '+'Mod'+'(d1:integer,d2:integer):integer';
 aParams:=SRpPMod;
end;

{**************************************************************************}

function TIdenModul.GeTRpValue:TRpValue;
begin
 if Not VarIsNumber(Params[0]) then
  Raise TRpNamedException.Create(SRpEvalType,
       IdenName);
 if Not VarIsNumber(Params[1]) then
  Raise TRpNamedException.Create(SRpEvalType,
       IdenName);
 Result:=Integer(Params[0]) mod Integer(Params[1]);
end;

{ TIdenToday }
constructor TIdenToday.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 IdenName:='Today';
 Help:=SRpToday;
 model:='function '+'Today'+':date';
end;

function TIdenToday.GeTRpValue:TRpValue;
begin
 REsult:=Date;
end;

{ TIdenAhora }
constructor TIdenTime.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 IdenName:='Time';
 Help:=SRpTimeH;
 model:='function '+'Time'+':time';
end;

{**************************************************************************}

function TIdenTime.GeTRpValue:TRpValue;
begin
 REsult:=Time;
end;

{ TIdenNULL }
constructor TIdenNULL.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 IdenName:='NULL';
 Help:=SRpNull;
 model:='function '+'NULL'+':variant';
end;

{**************************************************************************}

function TIdenNULL.GeTRpValue:TRpValue;
begin
 REsult:=Null;
end;

{ TIdenTime }
constructor TIdenNow.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 IdenName:='Now';
 Help:=SRpNow;
 model:='function '+'Now'+':datetime';
end;

{**************************************************************************}

function TIdenNow.GeTRpValue:TRpValue;
begin
 REsult:=Now;
end;

{ TIdenMonthname }
{**************************************************************************}

constructor TIdenMonthname.Create(AOwner:TComponent);
begin
 inherited Create(Aowner);
 FParamcount:=1;
 IdenName:='Monthname';
 Help:=SRpMonthname;
 model:='function '+'Monthname'+'(d:datetime):string';
 aParams:=SRpPMonthName;
end;

{**************************************************************************}

function TIdenMonthname.GeTRpValue:TRpValue;
var any,mes,dia:Word;
begin
 if varIsNumber(Params[0]) then
 begin
  Mes:=integer(Params[0]);
  if (not (mes in [1..12])) then
   Result:=''
  else
   Result:=LongMonthNames[mes];
 end
 else
 if varType(Params[0])=varDate then
 begin
  DecodeDate(TDateTime(Params[0]),Any,Mes,Dia);
  Result:=LongMonthNames[Mes];
 end
 else
  Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
end;

// TIdenEvalText

constructor TIdenEvalText.Create(AOwner:TComponent);
begin
 inherited Create(Aowner);
 FParamcount:=1;
 IdenName:='EvalText';
 Help:=SRpEvaltext;
 model:='function '+'EvalText'+'(expr:string):variant';
 aParams:=SRpPEvalText;
end;

function TIdenEvalText.GeTRpValue:TRpValue;
var avaluador:TRpCustomEvaluator;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 // Evalue
 avaluador:=(evaluator As TRpCustomEvaluator);
 result:=avaluador.Evaluatetext(Params[0]);
end;

// TIdenSetLanguage

constructor TIdenSetLanguage.Create(AOwner:TComponent);
begin
 inherited Create(Aowner);
 FParamcount:=1;
 IdenName:='SetLanguage';
 Help:=SRpSetLanguage;
 model:='function '+'SetLanguage'+'(language:integer):integer';
// aParams:=SRpPEvalText;
end;

function TIdenSetLanguage.GeTRpValue:TRpValue;
var avaluador:TRpEvaluator;
begin
 if Not VarIsInteger(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 // Evaluate
 avaluador:=(evaluator As TRpEvaluator);
 if assigned(avaluador.OnNewLanguage) then
  result:=avaluador.OnNewLanguage(Params[0]);
end;


{ TIdenMonth }
{**************************************************************************}

constructor TIdenMonth.Create(AOwner:TComponent);
begin
 inherited Create(Aowner);
 FParamcount:=1;
 IdenName:='Month';
 Help:=SRpMonth;
 model:='function '+'Month'+'(d:datetime):integer';
 aParams:=SRpPMonth;
end;

{**************************************************************************}

function TIdenMonth.GeTRpValue:TRpValue;
var any,mes,dia:Word;
begin
 case varType(Params[0]) of
  varDate:
   begin
    DecodeDate(TDateTime(Params[0]),Any,Mes,Dia);
    Result:=Mes;
   end;
  else
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 end;
end;

{ TIdenYear }
{**************************************************************************}

constructor TIdenYear.Create(AOwner:TComponent);
begin
 inherited Create(Aowner);
 FParamcount:=1;
 IdenName:='Year';
 Help:=SRpYear;
 model:='function '+'Year'+'(d:datetime):integer';
 aParams:=SRpPYear;
end;

{**************************************************************************}

function TIdenYear.GeTRpValue:TRpValue;
var any,mes,dia:Word;
begin
 case varType(Params[0]) of
  varDate:
   begin
    DecodeDate(TDateTime(Params[0]),Any,Mes,Dia);
    Result:=Any;
   end;
  else
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 end;
end;

{ TIdenDay }
{**************************************************************************}

constructor TIdenDay.Create(AOwner:TComponent);
begin
 inherited Create(Aowner);
 FParamcount:=1;
 IdenName:='Day';
 Help:=SRpDay;
 model:='function '+'Day'+'(d:datetime):integer';
 aParams:=SRpPDay;
end;

{**************************************************************************}

function TIdenDay.GeTRpValue:TRpValue;
var any,mes,dia:Word;
begin
 if ((VarType(Params[0])=varDate) or (VarIsNumber(Params[0]))) then
 begin
  DecodeDate(TDateTime(Params[0]),Any,Mes,Dia);
  Result:=integer(Dia);
 end
 else
  Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
end;

{ TIdenRight }

constructor TIdenRight.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='Right';
 Help:=SRpRight;
 model:='function '+'Right'+'(s:string,count:integer):string';
 aParams:=SRpPRight;
end;

{**************************************************************************}

function TIdenRight.GeTRpValue:TRpValue;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if ( Not (VarIsInteger(Params[1]))) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if  (Integer(Params[1])<1) then
  Result:=''
 else
 begin
 if (VarType(Params[0])=varString) then
  Result:=Copy(String(Params[0]),
              Length(String(Params[0]))+1-Integer(Params[1]),
              Integer(Params[1]))
 else
  Result:=Copy(WideString(Params[0]),
              Length(WideString(Params[0]))+1-Integer(Params[1]),
              Integer(Params[1]));
 end;
end;


{ TIdenSubstr }

constructor TIdenSubstr.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=3;
 IdenName:='Substr';
 Help:=SRpSubStr;
 model:='function '+'Substr'+'(s:string,index:integer,count:integer):string';
 aParams:=SRpPSubStr;
end;

{**************************************************************************}

function TIdenSubstr.GeTRpValue:TRpValue;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if ( Not (VarIsInteger(Params[1]))) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Integer(Params[1])<1 then
 begin
  Result:='';
  exit;
 end;
 if ( Not (VarIsInteger(Params[2]))) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if Integer(Params[2])<1 then
 begin
  Result:='';
  exit;
 end;
 if (VarType(Params[0])=varString) then
 begin
  Result:=Copy(String(Params[0]),
              Integer(Params[1]),
              Integer(Params[2]));
 end
 else
 begin
  Result:=Copy(WideString(Params[0]),
              Integer(Params[1]),
              Integer(Params[2]));
 end;
end;

{ TIdenFormatStr }

constructor TIdenFormatstr.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='FormatStr';
 Help:=SRpFormatStr;
 model:='function '+'Formatstr'+'(format:string,v:variant):string';
 aParams:=SRpPFormatStr;
end;

{**************************************************************************}

function TIdenFormatstr.GeTRpValue:TRpValue;
var
 Value:variant;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);

 Value:=Params[1];
 if Value=NULL then
 begin
  result:='';
  exiT;
 end;
 case vartype(Value) of
  varSmallint,varInteger,varSingle,varDouble,varWord,varByte,VarCurrency:
   begin
    Result:=FormatFloat(Params[0],Double(Value));
   end;
  // Modify by RAHUL TAMRAKR 27/05/2003
  // Bugfix for detecting DateTime datatypes (MySQL)
  varDate,272:
   begin
{$IFDEF DOTNETD}
    Result:=FormatDateTime(Params[0],TDateTime(Value));
{$ENDIF}
{$IFNDEF DOTNETD}
    Result:=FormatDateTime(Params[0],VarToDateTime(Value));
{$ENDIF}
   end;
  varBoolean:
   begin
    if Boolean(Value) then
     result:='True'
    else
     result:='False';
   end;
  else
  begin
   Result:=VarToStr(Value);
  end;
 end;
end;


{ TIdenFormatNum }

constructor TIdenFormatNum.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='FormatNum';
 Help:=SRpFormatNum;
 model:='function '+'FormatNum'+'(mask:string;number:double):string';
 aParams:=SRpPFormatNum;
end;

{**************************************************************************}

function TIdenFormatNum.GeTRpValue:TRpValue;
begin
 if VarIsnull(Params[1]) then
  Params[1]:=0.0;
 if Not (VarIsNumber(Params[1]))then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if ( Not (VarIsString(Params[0]))) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Result:=FormatCurrAdv(Params[0],Params[1]);
end;

{ TIdenFormatMask }

constructor TIdenFormatMask.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='FormatMask';
 Help:=SRpFormatStr;
 model:='function '+'FormatMask'+'(format:string,v:string):string';
 aParams:=SRpPFormatMask;
end;

{**************************************************************************}

function TIdenFormatMask.GeTRpValue:TRpValue;
var
 Value:variant;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Value:=Params[1];
 if Value=NULL then
 begin
  Value:='';
 end;
 if Not VarIsString(Params[1]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
{$IFDEF FPC}
 Raise Exception.Create('Free pascal library does not support FOrmatMaskText');
{$ENDIF}
{$IFNDEF FPC}
 Result:=FormatMaskText(Params[0],Value);
{$ENDIF}
end;


{ TIdenNumToText }

constructor TIdenNumToText.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='NumToText';
 Help:=SRpNumToText;
 model:='function '+'NumToText'+'(n:double,f:boolean):WideString';
 aParams:=SRpPNumToText;
end;

{**************************************************************************}

function TIdenNumToText.GeTRpValue:TRpValue;
var
 Value:variant;
begin
 if Vartype(Params[1])<>varboolean then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if NOt (VarIsNumber(Params[0])) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);

 Value:=Params[1];
 if Value=NULL then
 begin
  result:='';
  exiT;
 end;
 Result:=NumberToText(Params[0],Params[1],TRpEvaluator(evaluator).Language);
end;



constructor TVariableGrap.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
end;

procedure TVariableGrap.SetRpValue(Value:TRpValue);
begin
 // Asignem i pasem
 NewValue(Value,False,string(Value),'','',DefaultChartType);
end;


procedure TVariableGrap.NewValue(Y:Single;Cambio:Boolean;leyen,textleyen,textserie:string;charttype:TRpChartType);
begin
 if Assigned(FOnNewValue) then
  FOnNewValue(Y,Cambio,leyen,textleyen,textserie,DefaultChartType);
end;

procedure TVariableGrap.Clear;
begin
 if Assigned(FOnClear) then
  FOnClear(Self);
end;

function TVariableGrap.GetRpValue:TRpValue;
begin
 Raise Exception.Create(SRpErrorIdenExpression);
end;



//added FRB 20030204
{ TIdenReplaceStr }

constructor TIdenReplaceStr.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=3;
 IdenName:='ReplaceStr';
 Help:=SRpReplaceStr;
 model:='function '+'ReplaceStr'+'(const S, OldPattern, NewPattern:string;): string;';
 aParams:=SRpPReplaceStr;
end;

{**************************************************************************}

function TIdenReplaceStr.GeTRpValue:TRpValue;
begin
 if (Not VarIsString(Params[0]))
  or (Not VarIsString(Params[1]))
  or (Not VarIsString(Params[2])) then
   Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (VarType(Params[0])=varString) then
 begin
   Result:=StringReplace(String(Params[0]),String(Params[1]),String(Params[2]),
    [rfReplaceAll, rfIgnoreCase]);
 end
 else
 begin
   Result:=StringReplace(WideString(Params[0]),WideString(Params[1]),WideString(Params[2]),
    [rfReplaceAll, rfIgnoreCase]);
 end;
end;


{ TIdenGraphicOperation }

constructor TIdenGraphicOperation.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=10;
 IdenName:='GraphicOp';
 Help:='';
 model:='function '+'GraphicOp'+'(Top,Left,Width,Height:integer;'+#10+
    'DrawStyle:integer;BrushStyle:integer;BrushColor:integer;'+#10+
    'PenStyle:integer;PenWidth:integer; PenColor:integer):Boolean';
 aParams:='';
end;

{**************************************************************************}

function TIdenGraphicOperation.GeTRpValue:TRpValue;
var
 i:integer;
begin
 for i:=0 to 3 do
 begin
  if (Not VarIsNumber(Params[i])) then
   Raise TRpNamedException.Create(SRpEvalType,IdenName);
 end;
 for i:=4 to ParamCount-1 do
 begin
  if (Not VarIsInteger(Params[i])) then
   Raise TRpNamedException.Create(SRpEvalType,IdenName);
 end;
 if Assigned((evaluator As TRpEvaluator).OnGraphicOp) then
  Result:=(evaluator As TRpEvaluator).OnGraphicOp(Round(Params[0]),Round(Params[1]),Round(Params[2]),Round(Params[3]),Params[4],
   Params[5],Params[6],Params[7],Params[8],Params[9])
 else
  Result:=false;
end;

{ TIdenImageOperation }

constructor TIdenImageOperation.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=8;
 IdenName:='ImageOp';
 Help:='';
 model:='function '+'ImageOp'+'(Top,Left,Width,Height:integer;'+#10+
    'DrawStyle,PixelsPerinch:integer;PreviewOnly:Boolean;Image:String):Boolean';
 aParams:='';
end;

{**************************************************************************}

function TIdenImageOperation.GeTRpValue:TRpValue;
var
 i:integer;
begin
 for i:=0 to 3 do
 begin
  if (Not VarIsNumber(Params[i])) then
   Raise TRpNamedException.Create(SRpEvalType,IdenName);
 end;
 if (Not VarIsInteger(Params[4])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsInteger(Params[5])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if Vartype(Params[6])<>varBoolean then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 if (Not VarIsString(Params[7])) then
   Raise TRpNamedException.Create(SRpEvalType,IdenName);

 if Assigned((evaluator As TRpEvaluator).OnImageOp) then
  Result:=(evaluator As TRpEvaluator).OnImageOp(Round(Params[0]),Round(Params[1]),Round(Params[2]),Round(Params[3]),Params[4],
   Params[5],Params[6],Params[7])
 else
  Result:=false;
end;


{ TIdenReOpenOp }

constructor TIdenReOpenOp.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='ReOpen';
 Help:='';
 model:='function '+'ReOpen'+'(dataset, sql:string):Boolean';
 aParams:='';
end;

{**************************************************************************}

function TIdenReOpenOp.GeTRpValue:TRpValue;
var
 i:integer;
begin
 for i:=0 to 1 do
 begin
  if (Not VarIsString(Params[i])) then
   Raise TRpNamedException.Create(SRpEvalType,IdenName);
 end;
 if Assigned((evaluator As TRpEvaluator).OnReOpenOp) then
  Result:=(evaluator As TRpEvaluator).OnReOpenOp(Params[0],
   Params[1])
 else
  Result:=false;
end;


{ TIdenTextOperation }

constructor TIdenTextOperation.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=19;
 IdenName:='TextOp';
 Help:='';
 model:='function TextOp(Top,Left,Width,Height:integer;'+#10+
  'Text,LFontName,WFontName:WideString;'+#10+
  'FontSize,FontRotation,FontStyle,FontColor,Type1Font:integer;'+#10+
  'CutText:boolean;Alignment:integer;WordWrap,RightToLeft:Boolean;'+#10+
  'PrintStep,BackColor:integer;transparent:boolean)';
 aParams:='';
end;

{**************************************************************************}

function TIdenTextOperation.GeTRpValue:TRpValue;
var
 i:integer;
begin
 for i:=0 to ParamCount-1 do
 begin
  if (i in [0..3]) then
   if Not (VarIsNumber(Params[i])) then
    Raise TRpNamedException.Create(SRpEvalType,IdenName);
  if (i in [7..11,13,16,17]) then
   if (Not (VarIsInteger(Params[i]))) then
    Raise TRpNamedException.Create(SRpEvalType,IdenName);
  if (i in [12,14,15,18]) then
   if (Not (Vartype(Params[i])=varBoolean)) then
    Raise TRpNamedException.Create(SRpEvalType,IdenName);
  if (i in [4..6]) then
   if (Not (VarIsString(Params[i]))) then
    Raise TRpNamedException.Create(SRpEvalType,IdenName);
 end;
 if Assigned((evaluator As TRpEvaluator).OnTextOp) then
  Result:=(evaluator As TRpEvaluator).OnTextOp(Round(Params[0]),Round(Params[1]),Round(Params[2]),Round(Params[3]),Params[4],
   Params[5],Params[6],Params[7],Params[8],Params[9],
   Params[10],Params[11],Params[12],Params[13],Params[14],
   Params[15],Params[16],Params[17],Params[18])
 else
  Result:=false;
end;

{ TIdenTextHeight }

constructor TIdenTextHeight.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=8;
 IdenName:='TextHeight';
 Help:='';
 model:='function OnTextheight(Text,LFontName,WFontName:WideString;'+#10+
     'RectWidth,FontSize,FontStyle,Type1Font:integer;'+#10+
     'PrintStep:integer):integer';
 aParams:='';
end;

{**************************************************************************}

function TIdenTextHeight.GeTRpValue:TRpValue;
var
 i:integer;
begin
 for i:=0 to ParamCount-1 do
 begin
  if (i in [0..2]) then
   if (Not (VarIsString(Params[i]))) then
    Raise TRpNamedException.Create(SRpEvalType,IdenName);
  if (i in [3..7]) then
   if (Not (VarIsInteger(Params[i]))) then
    Raise TRpNamedException.Create(SRpEvalType,IdenName);
 end;
 if Assigned((evaluator As TRpEvaluator).OnTextHeight) then
  Result:=(evaluator As TRpEvaluator).OnTextHeight(Params[0],Params[1],Params[2],
   Params[3],Params[4],params[5],Params[6],Params[7])
 else
  Result:=0;
end;


{ TIdenBarcodeOperation }

constructor TIdenBarcodeOperation.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=12;
 IdenName:='BarcodeOp';
 Help:='';
 model:='function '+'BarcodeOp'+'(Top,Left,Width,Height:integer; '+#10+
    'Expression,DisplayFormat:WideString; BarType,Modul:Integer; Ratio,Rotation:Currency;'+
    #10+'CalcChecksum:Boolean; BColor:Integer):Boolean';
 aParams:='';
end;

{**************************************************************************}

function TIdenBarcodeOperation.GeTRpValue:TRpValue;
var
 i:integer;
begin
 for i:=0 to 3 do
 begin
  if (Not VarIsNumber(Params[i])) then
   Raise TRpNamedException.Create(SRpEvalType,IdenName);
 end;
 if (Not VarIsString(Params[4])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsString(Params[5])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsInteger(Params[6])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsInteger(Params[7])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsNumber(Params[8])) then
   Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsNumber(Params[9])) then
   Raise TRpNamedException.Create(SRpEvalType,IdenName);

 if Vartype(Params[10])<>varBoolean then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);

 if Not VarIsInteger(Params[11]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);

 if Assigned((evaluator As TRpEvaluator).OnBarcodeOp) then
  Result:=(evaluator As TRpEvaluator).OnBarcodeOp(Round(Params[0]),Round(Params[1]),Round(Params[2]),Round(Params[3]),
   WideString(Params[4]),WideString(Params[5]),
   Integer(Params[6]),Integer(Params[7]),
   Currency(Params[8]),Currency(Params[9]),
   Boolean(Params[10]),Integer(Params[11]))
 else
  Result:=false;
end;

// Operations to change orientation and page size
constructor TIdenOrientationOperation.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='SetPageOrientation';
 Help:='';
 model:='function '+'SetPageOrientation'+'(orientation:integer):Boolean';
 aParams:='';
end;

{**************************************************************************}

function TIdenOrientationOperation.GeTRpValue:TRpValue;
begin
 if (Not VarIsInteger(Params[0])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if Assigned((evaluator As TRpEvaluator).OnOrientationOp) then
  Result:=(evaluator As TRpEvaluator).OnOrientationOp(Params[0])
 else
  Result:=false;
end;

constructor TIdenPageOperation.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=7;
 IdenName:='SetPageSource';
 Help:='';
{ TPageSizeQt=record
  Indexqt:integer;
  Custom:boolean;
  CustomWidth:integer;
  CustomHeight:integer;
  PaperSource:integer;
  ForcePaperName:String;
  Duplex:integer;
 end;
}
 model:='function '+'SetPageSource'+'(QtIndex:integer;'+#10+
  'Custom:Boolean;CustomWidth,CustomHeight,PaperSource:integer;'+#10+
  'ForcePaperName:String;Duplex:integer):Boolean';
 aParams:='';
end;

{**************************************************************************}

function TIdenPageOperation.GeTRpValue:TRpValue;
begin
 if (Not VarIsInteger(Params[0])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if Vartype(Params[1])<>varBoolean then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsInteger(Params[2])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsInteger(Params[3])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsInteger(Params[4])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsString(Params[5])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not VarIsInteger(Params[6])) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if Assigned((evaluator As TRpEvaluator).OnPageOp) then
  Result:=(evaluator As TRpEvaluator).OnPageOp(Params[0],
   Params[1],Params[2],Params[3],Params[4],Params[5],Params[6])
 else
  Result:=false;
end;

{ TIdenParamInfo }

constructor TIdenParamInfo.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=2;
 IdenName:='ParamList';
 Help:='';
 model:='function ParamInfo(paramname:String;index:integer)';
 aParams:='';
end;

{**************************************************************************}

function TIdenParamInfo.GeTRpValue:TRpValue;
begin
 if (Not (VarIsString(Params[0]))) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not (VarIsInteger(Params[1]))) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if Assigned((evaluator As TRpEvaluator).OnParamInfo) then
  Result:=(evaluator As TRpEvaluator).OnParamInfo(Params[0],Params[1])
 else
  Result:='';
end;


constructor TIdenFieldExists.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='IdentExists';
 Help:='';
 model:='function IdentExists(s:String)';
 aParams:='';
end;

function TIdenFieldExists.GetRpValue: TRpValue;
 var iden:TRpIdentifier;
begin
  // check if the parameter is a string
  if (Not VarIsString( Params[0])) then
   Raise TRpNamedException.Create(SRpEvalType,IdenName);
  // search for the identifier
  iden:=(evaluator As TRpEvaluator).Searchidentifier(String(Params[0]));
  // set result
  Result := not (iden = nil)
end;


{$IFDEF MSWINDOWS}
//added jasonpun 20060306
{ TIdenChsToCht }

constructor TIdenChsToCht.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='ChsToCht';
 Help:=SRpChsToCht;
 model:='function '+'ChsToCht'+'(expr:string):String';
 aParams:=SRpChsToCht;
end;

function TIdenCHSToCHT.GeTRpValue:TRpValue;
var
  buf: PChar;
  len: Integer;
  src: String;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);

 src:=Params[0];
 if src=NULL then
 begin
  result:='';
  exiT;
 end;
  len := LCMapString($804,
    LCMAP_TRADITIONAL_CHINESE,
    Pchar(src),
    -1,
    nil,
    0);
  GetMem(buf, len);
  ZeroMemory(buf, len);
  LCMapString($804, //LCID_CHINESE_SIMPLIFIED
    LCMAP_TRADITIONAL_CHINESE,
    Pchar(src),
    -1,
    buf,
    len);
  Result := string(buf);
  FreeMem(buf);
end;

{ TIdenChtToChs }
constructor TIdenChtToChs.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='ChtToChs';
 Help:=SRpChtToChs;
 model:='function '+'ChtToChs'+'(expr:string):String';
 aParams:=SRpChtToChs;
end;

function TIdenCHtToCHs.GeTRpValue:TRpValue;
var
  buf: PChar;
  len: Integer;
  src: String;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);

 src:=Params[0];
 if src=NULL then
 begin
  result:='';
  exiT;
 end;
  len := LCMapString($804,
    LCMAP_TRADITIONAL_CHINESE,
    PChar(src),
    -1,
    nil,
    0);
  GetMem(buf, len);
  ZeroMemory(buf, len);
  LCMapString($804, //LCID_CHINESE_SIMPLIFIED
    LCMAP_TRADITIONAL_CHINESE,
    PChar(src),
    -1,
    buf,
    len);
  Result := string(buf);
  FreeMem(buf);
end;
{$ENDIF}


{ TIdenGetINIValue }

constructor TIdenGetINIValue.Create(AOWner: TComponent);
begin
  inherited;
 FParamcount:=4;
 IdenName:='GetINIValue';
 Help:=SRpGetIniValue;
 model:='function '+'GetINIValue'+'(file, section, name, default : string):String';
 aParams:='';
end;
function TIdenGetINIValue.GetRpValue: TRpValue;
begin
 if (Not (VarIsString(Params[0]))) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not (VarIsString(Params[1]))) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not (VarIsString(Params[2]))) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);
 if (Not (VarIsString(Params[3]))) then
  Raise TRpNamedException.Create(SRpEvalType,IdenName);

// try
  with TMemIniFile.Create(Params[0]) do
  begin
      try
          Result := ReadString(Params[1], Params[2], Params[3]);
      finally
          Free;
      end;
  end;
// except
//    Result := ''
// end;
end;

{ TIdenDecode64 }

{$IFDEF USEINDY}
constructor TIdenDecode64.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Decode64';
 Help:=SRpDecode64;
 model:='function '+'Decode64'+'(s:string):string';
 aParams:='';
end;

{**************************************************************************}

function TIdenDecode64.GeTRpValue:TRpValue;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Result:=MIMEDecodeString(String(Params[0]));
end;
{$ENDIF}

{ TIdenLoadFile }

constructor TIdenLoadFile.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='LoadFile';
 Help:=SRpLoadFile;
 model:='function '+'LoadFile'+'(s:string):string';
 aParams:='';
end;

{**************************************************************************}

function TIdenLoadFile.GeTRpValue:TRpValue;
var
 astring:string;
 memstream:TMemorystream;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 astring:=String(Params[0]);
 memstream:=TMemoryStream.Create;
 try
  memstream.LoadFromFile(astring);
  astring:='';
  if memstream.size>0 then
  begin
   SetLength(astring,memstream.size);
   memstream.Seek(0,soFromBeginning);
   memstream.Read(astring[1],memstream.size);
  end;
 finally
  memstream.free;
 end;
 Result:=astring;
end;


{ TIdenStringToBin }

constructor TIdenStringToBin.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='StringToBin';
 Help:=SRpDecode64;
 model:='function '+'StringToBin'+'(s:string):binary';
 aParams:='';
end;

{**************************************************************************}

function TIdenStringToBin.GeTRpValue:TRpValue;
var
// i:integer;
 astring:string;
 p:pointer;
begin
 if Not VarIsString(Params[0]) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 astring:=String(Params[0]);
 if Length(astring)>0 then
 begin
  Result:=VarArrayCreate([0,Length(astring)-1],varByte);
//   for i:=1 to Length(astring) do
//   begin
//    Result[i-1]:=byte(astring[i]);
//   end;
  p:=VarArrayLock(Result);
  try
   Move(astring[1],p^,Length(astring));
  finally
   VarArrayUnlock(Result);
  end;
 end;
end;


end.
