{*******************************************************}
{                                                       }
{       Rptypeval Datatypes and functions for           }
{       the Rpevaluator                                 }
{       Report Manager                                  }
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

unit rptypeval;

{$I rpconf.inc}

interface

uses
 SysUtils,Classes,rpmdconsts,
{$IFDEF USEVARIANTS}
 Variants,
{$ENDIF}
{$IFDEF USEBCD}
 FMTBcd,
{$ENDIF}
 DB,
 rptypes;

const
     // Parser datatypes for constants
     toEOF         =      Char(0);
     toSymbol      =      Char(1);
     tkString      =      Char(2);
     toInteger     =      Char(3);
     toFloat       =      Char(4);
     toOperator    =      Char(5);
     toWString     =      Char(6);
     // Max number of parameters in a function
     Maxparams =  50;

type
 // Token datatypes
 TRpToken=(totEOF,totSymbol,totString,totInteger,TotFloat,totOperator,
              totBoolean,totDate,totTime,totDateTime);


 // New exception to raise avaluating operations
 TRpNamedException=Class(Exception)
  public
   ErrorMessage:string;
   // The element implied on the exception
   ElementError:string;
   constructor Create(Msg,Element:String);
 end;

 // New exception to raise avaluating operations
 TRpEvalException=Class(TRpNamedException)
  public
   // Error position
   ErrorLine:Integer;
   ErrorPosition:Integer;
   // Constructor for the Eval Exception
   constructor Create(Msg,Element:String;Line,Position:integer);
 end;

 // Data type of a value returned by the expresion evaluator
 TRpValue = Variant;


 // Identifier }
 RTypeIdentificator = (RTypeidenFunction,RTypeIdenVariable,RTypeIdenConstant);

 // Identifier, abstract object
 TRpIdentifier=class(TComponent)
  protected
   FParamCount:integer;
   procedure SetRpValue(Value:TRpValue);virtual;abstract;
   function GetRpValue:TRpValue;virtual;abstract;
  public
   evaluator:TComponent;
   // Identifier type
   RType:RTypeIdentificator;
   // Internal identifier
   Idenname:string;
   // Help
   help:string;
   model:string;
   aparams:string;
   // Param function structure
   params:array[0..MAXparams-1] of TRpValue;
   constructor Create(AOwner:TComponent);override;
   // Parameter count
   property ParamCount:integer read FParamCount;
   // Function Value (read) or variable value(read/write)
   property Value:TRpValue read GeTRpValue write SeTRpValue;
  end;

 // Generic function, all function can inherit from this object
 TIdenFunction=class(TRpIdentifier)
  protected
   procedure SetRpValue(Value:TRpValue);override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 // Variable
 TIdenVariable=class(TRpIdentifier)
  protected
   FValue:TRpValue;
   procedure SetRpValue(Value:TRpValue);override;
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 // Constant
 TIdenConstant=class(TRpIdentifier)
  protected
   FValue:TRpValue;
   procedure SetRpValue(Value:TRpValue);override;
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 // Field
 TIdenField=class(TRpIdentifier)
 private
  FField:TField;
 protected
   function GetRpValue:TRpValue;override;
   procedure SetRpValue(Value:TRpValue);override;
 public
   constructor Create(AOwner:TComponent);override;
   constructor CreateField(AOWner:TComponent;Nom:string);
   property Field:TField read FField write FField;
 end;

 // True Constant
 TIdenTrue=class(TIdenConstant)
 public
  constructor Create(AOwner:TComponent);override;
 end;

 // False Constant
 TIdenFalse=class(TIdenConstant)
 public
  constructor Create(AOwner:TComponent);override;
 end;

// Math operations
function SumTRpValue(Value1,Value2:TRpValue):TRpValue;
function DifTRpValue(Value1,Value2:TRpValue):TRpValue;
function MultTRpValue(Value1,Value2:TRpValue):TRpValue;
function DivTRpValue(Value1,Value2:TRpValue):TRpValue;
function SignTRpValue(Value:TRpValue):TRpValue;
// Comp operations
function EqualTRpValue(Value1,Value2:TRpValue):TRpValue;
function EqualEqualTRpValue(Value1,Value2:TRpValue):TRpValue;
function MorethanEqualTRpValue(Value1,Value2:TRpValue):TRpValue;
function LessthanEqualTRpValue(Value1,Value2:TRpValue):TRpValue;
function MorethanTRpValue(Value1,Value2:TRpValue):TRpValue;
function LessthanTRpValue(Value1,Value2:TRpValue):TRpValue;
function DiferentTRpValue(Value1,Value2:TRpValue):TRpValue;
function IsNullTRpValue(Value:TRpValue):Boolean;

// Logical operations
function LogicalANDTRpValue(Value1,Value2:TRpValue):TRpValue;
function LogicalORTRpValue(Value1,Value2:TRpValue):TRpValue;
function LogicalNOTTRpValue(Value1:TRpValue):TRpValue;

// Formatting operations
function TRpValueToString(Value:TRpValue):string;
function FormatTRpValue(sFormat:string;Value:TRpValue;Userdef:Boolean):string;

// Date operation validation
procedure DatetimeValidation(var Value1,Value2:TRpValue);


var
 DefaultDecimals:Integer;

implementation

// TRpNamedexception
constructor TRpNamedException.Create(Msg,Element:string);
begin
 ErrorMessage:=Msg;
 ElementError:=Element;
 inherited Create(ErrorMessage);
end;

// TRpEvalException
constructor TRpEvalException.Create(Msg,Element:string;Line,Position:integer);
begin
 Inherited Create(Msg,Element);

 ErrorLine:=Line;
 ErrorPosition:=Position;
 ErrorMessage:=Msg;
 ElementError:=Element;
end;

// TRpIdentifier
constructor TRpIdentifier.Create(AOwner:TComponent);
begin
 inherited create(AOwner);

 help:=SRpNohelp;
 aparams:=SRpNoaparams;
 model:=SRpNomodel;
end;

// TIdenfunction
constructor TIdenFunction.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 RType:=RTypeIdenfunction;
end;

procedure TIdenFunction.SeTRpValue(Value:TRpValue);
begin
 Raise TRpNamedException.Create(SRpAssignFunc,
       Idenname);
end;

// TIdenTrue
constructor TIdenTrue.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FValue:=True;
 RType:=RTypeIdenConstant;
 help:=SRpTrueHelp;
 Idenname:='True';
end;

// TIdenFalse
constructor TIdenFalse.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FValue:=False;
 help:=SRpFalseHelp;
 Idenname:='False';
end;

// TIdenVariable
constructor TIdenVariable.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 RType:=RTypeIdenvariable;
end;

function TIdenVariable.GeTRpValue:TRpValue;
begin
 Result:=FValue;
end;

procedure TIdenVariable.SeTRpValue(Value:TRpValue);
begin
 FValue:=Value;
end;

// TIdenConstant
constructor TIdenConstant.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 RType:=RTypeidenconstant;
end;

function TIdenConstant.GeTRpValue:TRpValue;
begin
 Result:=FValue;
end;

procedure TIdenConstant.SeTRpValue(Value:TRpValue);
begin
 Raise TRpNamedException.Create(SRpAssignConst,
       Idenname);
end;

// TIdenField
constructor TIdenField.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
end;

constructor TIdenField.CreateField(AOwner:TComponent;Nom:string);
begin
 inherited Create(AOwner);
 Idenname:=Nom;
 help:=SRpFieldHelp;
end;

procedure TIdenField.SeTRpValue(Value:TRpValue);
begin
  Raise TRpNamedException.Create(SRpAssignfield,
       Idenname);
end;

function TIdenField.GeTRpValue:TRpValue;
var
 atype:TVarType;
begin
 if Field=nil then
 begin
  Result:=Null;
  Exit;
 end;
 Result:=Field.AsVariant;
{$IFNDEF USEBCD}
 atype:=VarType(Result);
 if atype=14 then
  Result:=Field.AsInteger;
{$ENDIF}
{$IFDEF USEBCD}
 atype:=VarType(Result);
 if atype=varFmtBCD then
 begin
  Result:=BCDToDouble(VarToBCD(Result));
 end;
{$ENDIF}
end;

// Math Functions
function SumTRpValue(Value1,Value2:TRpValue):TRpValue;
var
 atype1,atype2:TVarType;

begin
 if VarIsNull(Value1) then
 begin
  Result:=Value2;
 end
 else
  if VarIsNull(Value2) then
  begin
   Result:=Value1;
  end
  else
  begin
   // Bugfix suming widestring+string
   // The Result should be by default a widestring
   // but it's a String
   atype1:=VarType(Value1);
   atype2:=VarType(Value2);
   if atype1=atype2 then
    Result:=Value1+Value2
   else
   begin
    if atype1=varOleStr then
     Result:=Value1+WideString(Value2)
    else
     if atype2=varOleStr then
      Result:=WideString(Value1)+Value2
     else
      Result:=Value1+Value2
   end;
  end;
end;

function DifTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 if Value1=NULL then
 begin
  Result:=-Value2;
 end
 else
  if Value2=NULL then
  begin
   Result:=Value1;
  end
  else
   Result:=Value1-Value2;
end;

function MultTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 Result:=Value1*Value2;
end;

function DivTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 Result:=Value1/Value2;
end;

function SignTRpValue(Value:TRpValue):TRpValue;
begin
 Result:=-Value;
end;

// Formating functions
function TRpValueToString(Value:TRpValue):string;
begin
 if Value=NULL then
 begin
  result:='';
  exit;
 end;
 case VarType(Value) of
   vardate:
    Result:=FormatDateTime(ShortDateFormat,TDateTime(Value));
   else
    Result:=Value;
 end;

end;

function FormatTRpValue(sFormat:string;Value:TRpValue;Userdef:Boolean):string;
var
 index:integer;
 General:Boolean;
begin
 if VarIsNull(Value) then
 begin
  result:='';
  exit;
 end;
 case VarType(Value) of
  varSmallInt..varInteger:
   begin
    if Not Userdef then
    begin
     General:=False;
     index:=Pos('n',sformat);
     if index<>0 then
      General:=True
     else
     begin
      index:=Pos('f',sformat);
      if index<>0 then
       General:=True
      else
      begin
       index:=Pos('m',sformat);
       if index<>0 then
        General:=True
      end;
     end;

     if General then
     begin
      if Pos('.',sformat)=0 then
      begin
       Insert('.'+IntToStr(DefaultDecimals),sformat,index);
      end;
     end;
    end;
    if Userdef then
     Result:=sysutils.formatFloat(sformat,Double(Value))
    else
    begin
     index:=Pos('d',sformat);
     if index<>0 then
      Result:=format(sformat,[Integer(Value)])
     else
      Result:=format(sformat,[Double(Value)]);
    end;
   end;
  varSingle,varDouble,VarCurrency:
   begin
    if Not Userdef then
    begin
     General:=False;
     index:=Pos('n',sformat);
     if index<>0 then
      General:=True
     else
     begin
      index:=Pos('f',sformat);
      if index<>0 then
       General:=True
      else
      begin
       index:=Pos('m',sformat);
       if index<>0 then
       begin
        General:=True;
       end;
      end;
     end;
     if (General) then
     begin
      if Pos('.',sformat)=0 then
      begin
       Insert('.'+IntToStr(DefaultDecimals),sformat,index);
      end;
     end;
    end;
    try
     if Userdef then
      Result:=sysutils.formatFloat(sformat,Double(Value))
     else
      Result:=format(sformat,[Double(Value)]);
    except
     if Double(Value)<>Integer(Value) then
      Raise;
     if Userdef then
      Result:=sysutils.formatFloat(sformat,Double(Value))
     else
      Result:=format(sformat,[Integer(Value)]);
    end;
   end;
{$IFNDEF DOTNETD}
 varOleStr,
{$ENDIF}
  varString:
   if Value='' then Result:='' else
    Result:=format(sformat,[string(Value)]);
  varBoolean:
   begin
    if Userdef then
     Result:=sformat
    else
    if Boolean(Value) then
     Result:='True'
    else
     Result:='False';
   end;
  varDate:
   begin
    if Userdef then
    begin
     Result:=FormatDateTime(sformat,TDateTime(Value));
    end
    else
    begin
     if (sformat='%xl') then
     begin
      if TDateTime(Value)=0 then
      begin
       Result:='';
       Exit;
      end;
      if TDateTime(Value)<1 then
        Result:=FormatDateTime(LongTimeFormat,TDateTime(Value))
      else
       if TDateTime(Value)-Trunc(double(Value))=0 then
        Result:=FormatDateTime(LongDateFormat,TDateTime(Value))
       else
        Result:=FormatDateTime(LongDateFormat+' '+LongTimeFormat,TDateTime(Value))
     end
     else
     begin
      if TDateTime(Value)=0 then
      begin
       Result:='';
       Exit;
      end;
      if TDateTime(Value)<1 then
        Result:=FormatDateTime(ShortTimeFormat,TDateTime(Value))
      else
       if TDateTime(Value)-Trunc(double(Value))=0 then
        Result:=FormatDateTime(ShortDateFormat,TDateTime(Value))
       else
        Result:=FormatDateTime(ShortDateFormat+' '+ShortTimeFormat,TDateTime(Value))
     end;
    end;
   end;
  else
   Result:='';
 end;
end;

// Logical functions

function IsNullTRpValue(Value:TRpValue):Boolean;
begin
 case VarType(Value) of
  varSmallInt..varDouble:
   Result:=(Double(Value)=0);
{$IFNDEF DOTNETD}
 varOleStr,
{$ENDIF}
  varString:
   Result:=(String(Value)='');
  varBoolean:
   Result:=Not Boolean(Value);
  varDate:
   Result:=(TDateTime(Value)=0);
  else
   Result:=VarIsNull(Value);
 end;
end;

function LogicalANDTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 Result:=Value1 And Value2;
end;

function LogicalORTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 Result:=Value1 or Value2;
end;

function LogicalNOTTRpValue(Value1:TRpValue):TRpValue;
begin
  Result:=NOT Value1;
end;

function EqualTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 DatetimeValidation(Value1,Value2);
 Result:=(Value1=Value2);
end;

function MorethanEqualTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 DatetimeValidation(Value1,Value2);
 Result:=Value1>=Value2;
end;

function LessthanEqualTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 DatetimeValidation(Value1,Value2);
 Result:=(Value1<=Value2);
end;

function MorethanTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 DatetimeValidation(Value1,Value2);
 Result:=(Value1>Value2);
end;

function LessthanTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 DatetimeValidation(Value1,Value2);
 Result:=(Value1<Value2);
end;

function DiferentTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 DatetimeValidation(Value1,Value2);
 Result:=(Value1<>Value2);
end;

function EqualEqualTRpValue(Value1,Value2:TRpValue):TRpValue;
begin
 DatetimeValidation(Value1,Value2);
 Result:=(Value1=Value2);
end;

// Date time validation
procedure DatetimeValidation(var Value1,Value2:TRpValue);
begin
 if VarType(Value1)=varDate then
 begin
  if VarType(Value2)<>varDate then
   if Value2<>null then
   begin
    Value2:=varastype(Value2,varDate);
   end;
 end;
 if VarType(Value2)=varDate then
 begin
  if VarType(Value1)<>varDate then
   if Value1<>Null then
   begin
    Value1:=varastype(Value1,varDate);
   end;
 end;
end;


initialization

DefaultDecimals:=2;

end.
