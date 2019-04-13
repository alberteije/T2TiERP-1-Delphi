{*******************************************************}
{                                                       }
{       Rpeval                                          }
{       TRpCustomEvaluator: The Expression evaluator for}
{       Report Manager                                  }
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

unit rpeval;


interface

{$I rpconf.inc}

uses
  SysUtils, Classes,DB,rptypeval,
  rpmdconsts,sysconst,rpparser,
{$IFDEF USEEVALHASH}
 rpstringhash,
{$ENDIF}
{$IFDEF USEREPORTFUNC}
  rpalias,
{$ENDIF}
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
  rptypes;

type
 TRpCustomEvaluator=class(TComponent)
 private
  // Component to access fields
  Rpfunctions:TStringList;
{$IFDEF USEREPORTFUNC}
  fRpalias:TRpalias;
{$ENDIF}
  // Error information
  FError:string;
  FPosError:LongInt;
  FLineError:Word;
  // The parser
  Rpparser:TRpparser;
  // The expresion to evaluate
  FExpression:Ansistring;
  // Result of the evaluation
  FEvalResult:TRpValue;
{$IFDEF USEEVALHASH}
  FIdentifiers:TStringHash;
{$ENDIF}
{$IFNDEF USEEVALHASH}
  FIdentifiers:TStringList;
{$ENDIF}
  FPartial:TRpValue;
  // Variable that contains if we are doing syntax checking
  FChecking:Boolean;
  FLanguage:Integer;
  FOnGraphicOp:TRpGraphicOpProc;
  FOnOrientationOp:TRpOrientationOpProc;
  FOnPageOp:TRpPageOpProc;
  FOnImageOp:TRpImageOpProc;
  FOnBarcodeOp:TRpBarcodeOpProc;
  FOnReOpenOp:TRpReOpenOp;
  FOnTextOp:TRpTextOpProc;
  FOnTextHeight:TRpTextHeightProc;
  FOnNewLanguage:TRpNewLanguage;
  FOnGetSQLValue:TRpOnGetSQLValue;
  FOnParamInfo:TRpParamInfoProc;
  procedure SetExpression(Value:Ansistring);
  // Recursive functions to evaluate the expresion
  procedure variables(var Value:TRpValue);
  procedure separator(var Value:TRpValue);
  procedure logicalOR(var Value:TRpValue);
  procedure logicalAND(var Value:TRpValue);
  procedure comparations(var Value:TRpValue);
  procedure sum_dif(var Value:TRpValue);
  procedure mul_div(var Value:TRpValue);
  procedure dosign(var Value:TRpValue);
  procedure ExecuteIIF(var Value:TRpValue);
  procedure parentesis(var Value:TRpValue);
  procedure operand(var Value:TRpValue);
  // Aditional priva procedures
  function EvaluateExpression:TRpValue;
  // Searching indentifiers
  function Searchwithoutdot(name1:Shortstring):TRpIdentifier;
  function GetEvalResultString:Ansistring;
  procedure AddIdentifiers;
  procedure Freerprmfunctions;
  procedure InitRpFunctions;
  procedure FillFunctions;
 protected
  procedure Notification(AComponent:TComponent;Operation:TOperation);override;
 public
  // To avoid infinite recursive
  Evaluating:Boolean;
  // Creation and destruction
  constructor Create(AOwner:TComponent);override;
  constructor CreateWithoutiden(AOwner:TComponent;AddIdens:boolean);
  destructor Destroy;override;
  // Adds identifiers
  procedure AddVariable(name1:string;objecte:TRpIdentifier);
  procedure AddIden(name1:string;objecte:TRpIdentifier);
  function NewVariable(name1:string;ValueIni:TRpValue):TIdenVariable;
  // Searching identifiers
  function Searchidentifier(name1:shortstring):TRpIdentifier;
  // The evaluation procedure
  procedure Evaluate;
  // The evaluation procedure without Expression property
  function EvaluateText(text:string):TRpValue;
  function GetStreamFromExpression(atext:WideString):TMemoryStream;

  // Checking Syntax
  procedure CheckSyntax;
  property Expression:Ansistring Read FExpression write SetExpression;
  property EvalResult:TRpValue Read FEvalResult;
  // The identifiers including functions
{$IFDEF USEEVALHASH}
  property Identifiers:TStringHash read FIdentifiers
{$ENDIF}
{$IFNDEF USEEVALHASH}
  property Identifiers:TStringList read FIdentifiers
{$ENDIF}
   write FIdentifiers;
  property Checking:Boolean read FChecking;
  // Error information
  property Error:string read FError;
  property PosError:LongInt read FPosError;
  property LineError:Word read FLineError;
  property EvalResultString:Ansistring read GetEvalResultString;
  // Database access component link
{$IFDEF USEREPORTFUNC}
  property Rpalias:TRpalias read FRpalias write FRpalias;
{$ENDIF}
  property Language:Integer read FLanguage write FLanguage;
  property OnGraphicOp:TRpGraphicOpProc read FOnGraphicOp write FOnGraphicOp;
  property OnOrientationOp:TRpOrientationOpProc read FOnOrientationOp write FOnOrientationOp;
  property OnPageOp:TRpPageOpProc read FOnPageOp write FOnPageOp;
  property OnImageOp:TRpImageOpProc read FOnImageOp write FOnImageOp;
  property OnBarcodeOp:TRpbarcodeOpProc read FOnBarcodeOp write FOnBarcodeOp;
  property OnTextOp:TRpTextOpProc read FOnTextOp write FOnTextOp;
  property OnTextHeight:TRpTextHeightProc read FOnTextHeight write FOnTextHeight;
  property OnReOpenOp:TRpReOpenOp read FOnReOpenOp write FOnReOpenOp;
  property OnGetSQLValue:TRpOnGetSQLValue read FOnGetSQLValue write FOnGetSQLValue;
  property OnNewLanguage:TRpNewLanguage read FOnNewLanguage write FOnNewLanguage;
  property OnParamInfo:TRpParamInfoProc read FOnParamInfo write FOnParamInfo;
 end;

 // The visual component
 TRpEvaluator = class(TRpCustomEvaluator)
  private
  protected
  public
   { Public declarations }
  published
   { Published declarations }
{$IFDEF USEREPORTFUNC}
   property Rpalias;
{$ENDIF}
   property EvalResult;
   property Expression;
  end;


function EvaluateExpression(aexpression:WideString):Variant;

implementation

uses rpevalfunc;

{ Paradox graphic BLOB header }

type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;

// TRpCustomEvaluator

constructor TRpCustomEvaluator.CreateWithoutiden(AOwner:TComponent;AddIdens:boolean);
begin
 inherited Create(AOwner);
 Evaluating:=false;
 FExpression:=String(chr(0));
 // Creates de parser
 Rpparser:=TRpparser.Create;
 // The identifiers list
{$IFDEF USEEVALHASH}
 FIdentifiers:=TStringHash.Create;
{$ENDIF}
{$IFNDEF USEEVALHASH}
 FIdentifiers:=TStringList.Create;
{$ENDIF}
// FIdentifiers.Sorted:=True;
// FIdentifiers.Duplicates:=dupError;
 if AddIdens then
  AddIdentifiers;
end;

constructor TRpCustomEvaluator.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 InitRpFunctions;
 Evaluating:=false;
 FExpression:=String(chr(0));
 // The parser
 Rpparser:=TRpparser.Create;
 // The identifiers
{$IFNDEF USEEVALHASH}
 FIdentifiers:=TStringList.Create;
{$ENDIF}
{$IFDEF USEEVALHASH}
 FIdentifiers:=TStringHash.Create;
{$ENDIF}
 // FIdentifiers.Sorted:=True;
// FIdentifiers.Duplicates:=dupError;
 // Always add with this constructor
 AddIdentifiers;
end;

procedure TRpCustomEvaluator.FillFunctions;
var iden:TRpIdentifier;
begin
 if Rpfunctions.count>0 then
  exit;
  // Boolean constants
  iden:=TIdenTrue.Create(nil);
  Rpfunctions.AddObject('TRUE',iden);
  iden:=TIdenFalse.Create(nil);
  Rpfunctions.AddObject('FALSE',iden);
  iden:=TIdenTrue.Create(nil);
  Rpfunctions.AddObject('CIERTO',iden);
  iden:=TIdenFalse.Create(nil);
  Rpfunctions.AddObject('FALSO',iden);

 // Datetime constants
 iden:=TIdenToday.Create(nil);
 Rpfunctions.AddObject('TODAY',iden);
 iden:=TIdenTime.Create(nil);
 Rpfunctions.AddObject('TIME',iden);
 iden:=TIdenNow.Create(nil);
 Rpfunctions.AddObject('NOW',iden);

 // Null constant
 iden:=TIdenNULL.Create(nil);
 Rpfunctions.AddObject('NULL',iden);

 // Functions
 iden:=TIdenSinus.Create(nil);
 Rpfunctions.AddObject('SIN',iden);
 iden:=TIdenMax.Create(nil);
 Rpfunctions.AddObject('MAX',iden);
 iden:=TIdenFloatToDateTime.Create(nil);
 Rpfunctions.AddObject('FLOATTODATETIME',iden);
 iden:=TIdenRound.Create(nil);
 Rpfunctions.AddObject('ROUND',iden);
 iden:=TIdenRoundToInteger.Create(nil);
 Rpfunctions.AddObject('ROUNDTOINTEGER',iden);
 iden:=TIdenInt.Create(nil);
 Rpfunctions.AddObject('INT',iden);
 iden:=TIdenAbs.Create(nil);
 Rpfunctions.AddObject('ABS',iden);
 iden:=TIdenCompareValue.Create(nil);
 Rpfunctions.AddObject('COMPAREVALUE',iden);
 iden:=TIdenSQRT.Create(nil);
 Rpfunctions.AddObject('SQRT',iden);
 iden:=TIdenASC2.Create(nil);
 Rpfunctions.AddObject('ASC2',iden);
 iden:=TIdenFieldExists.Create(nil);
 Rpfunctions.AddObject('IDENTEXISTS',iden);
 iden:=TIdenIsInteger.Create(nil);
 Rpfunctions.AddObject('ISINTEGER',iden);
 iden:=TIdenIsNumeric.Create(nil);
 Rpfunctions.AddObject('ISNUMERIC',iden);
 iden:=TIdenIsValidDateTime.Create(nil);
 Rpfunctions.AddObject('ISVALIDDATETIME',iden);
 iden:=TIdenCheckExpression.Create(nil);
 Rpfunctions.AddObject('CHECKEXPRESSION',iden);
{$IFDEF MSWINDOWS}
 iden:=TIdenChsToCht.Create(nil);
 Rpfunctions.AddObject('CHSTOCHT',iden);
 iden:=TIdenChtToChs.Create(nil);
 Rpfunctions.AddObject('CHTTOCHS',iden);
{$ENDIF}
 iden := TIdenGetINIValue.Create(nil);
 Rpfunctions.AddObject('GETINIVALUE', iden);
{$IFDEF USEINDY}
 iden := TIdenDecode64.Create(nil);
 Rpfunctions.AddObject('DECODE64', iden);
{$ENDIF}
 iden := TIdenStringToBin.Create(nil);
 Rpfunctions.AddObject('STRINGTOBIN', iden);
 iden := TIdenLoadFile.Create(nil);
 Rpfunctions.AddObject('LOADFILE', iden);

 // Functions for compatibility with Gestor reports
 iden:=TIdenVariable.Create(nil);
 iden.Value:=True;
 RpFunctions.AddObject('MODOGRAFICO',iden);

 iden:=TIdenSTR.Create(nil);
 Rpfunctions.AddObject('STR',iden);
 iden:=TIdenVal.Create(nil);
 Rpfunctions.AddObject('VAL',iden);
 iden:=TIdenLEFT.Create(nil);
 Rpfunctions.AddObject('LEFT',iden);
 iden:=TIdenLENGTH.Create(nil);
 Rpfunctions.AddObject('LENGTH',iden);
 iden:=TIdenTrim.Create(nil);
 Rpfunctions.AddObject('TRIM',iden);
 iden:=TIdenPos.Create(nil);
 Rpfunctions.AddObject('POS',iden);
 iden:=TIdenModul.Create(nil);
 Rpfunctions.AddObject('MOD',iden);
 iden:=TIdenMonthname.Create(nil);
 Rpfunctions.AddObject('MONTHNAME',iden);
 iden:=TIdenMonth.Create(nil);
 Rpfunctions.AddObject('MONTH',iden);
 iden:=TIdenYear.Create(nil);
 Rpfunctions.AddObject('YEAR',iden);
 iden:=TIdenDay.Create(nil);
 Rpfunctions.AddObject('DAY',iden);
 iden:=TIdenRight.Create(nil);
 Rpfunctions.AddObject('RIGHT',iden);
 iden:=TIdenSubstr.Create(nil);
 Rpfunctions.AddObject('SUBSTR',iden);
 iden:=TIdenFormatstr.Create(nil);
 Rpfunctions.AddObject('FORMATSTR',iden);
 iden:=TIdenFormatNum.Create(nil);
 Rpfunctions.AddObject('FORMATNUM',iden);
 iden:=TIdenFormatMask.Create(nil);
 Rpfunctions.AddObject('FORMATMASK',iden);
 iden:=TIdenHourMinSec.Create(nil);
 Rpfunctions.AddObject('HOURMINSEC',iden);
 iden:=TIdenUppercase.Create(nil);
 Rpfunctions.AddObject('UPPERCASE',iden);
 iden:=TIdenFileExists.Create(nil);
 Rpfunctions.AddObject('FILEEXISTS',iden);
 iden:=TIdenLowercase.Create(nil);
 Rpfunctions.AddObject('LOWERCASE',iden);
 iden:=TIdenEvalText.Create(nil);
 Rpfunctions.AddObject('EVALTEXT',iden);
 iden:=TIdenNumToText.Create(nil);
 Rpfunctions.AddObject('NUMTOTEXT',iden);
 //added FRB 20030204
 iden:=TIdenReplaceStr.Create(nil);
 Rpfunctions.AddObject('REPLACESTR',iden);
 // Advanced reporting drawing operations
 iden:=TIdenOrientationOperation.Create(nil);
 Rpfunctions.AddObject('SETPAGEORIENTATION',iden);
 iden:=TIdenPageOperation.Create(nil);
 Rpfunctions.AddObject('SETPAGESOURCE',iden);
 iden:=TIdenGraphicOperation.Create(nil);
 Rpfunctions.AddObject('GRAPHICOP',iden);
 iden:=TIdenTextOperation.Create(nil);
 Rpfunctions.AddObject('TEXTOP',iden);
 iden:=TIdenTextHeight.Create(nil);
 Rpfunctions.AddObject('TEXTHEIGHT',iden);
 iden:=TIdenImageOperation.Create(nil);
 Rpfunctions.AddObject('IMAGEOP',iden);
 iden:=TIdenBarcodeOperation.Create(nil);
 Rpfunctions.AddObject('BARCODEOP',iden);
 iden:=TIdenParamInfo.Create(nil);
 Rpfunctions.AddObject('PARAMINFO',iden);
 iden:=TIdenUTF8ToWideString.Create(nil);
 Rpfunctions.AddObject('UTF8TOWIDESTRING',iden);
 // Other

 // Graphic functions
 iden:=TIdenGraphicClear.Create(nil);
 Rpfunctions.AddObject('GRAPHICCLEAR',iden);
 iden:=TIdenGraphicNew.Create(nil);
 Rpfunctions.AddObject('GRAPHICNEW',iden);
 iden:=TIdenGraphicColor.Create(nil);
 Rpfunctions.AddObject('GRAPHICCOLOR',iden);
 iden:=TIdenGraphicSerieColor.Create(nil);
 Rpfunctions.AddObject('GRAPHICSERIECOLOR',iden);
 iden:=TIdenGraphicBounds.Create(nil);
 Rpfunctions.AddObject('GRAPHICBOUNDS',iden);
 // SQl functions
 iden:=TIdenGetValueFromSQL.Create(nil);
 Rpfunctions.AddObject('GETVALUEFROMSQL',iden);
 //
 iden:=TIdenReOpenOp.Create(nil);
 Rpfunctions.AddObject('REOPEN',iden);
 //
 iden:=TIdenSetLanguage.Create(nil);
 Rpfunctions.AddObject('SETLANGUAGE',iden);

end;

// Adds the identifiers that are on cache
procedure TRpCustomEvaluator.AddIdentifiers;
var
 i:integer;
begin
 FillFunctions;
 for i:=0 to Rpfunctions.Count-1 do
{$IFDEF USEEVALHASH}
  Fidentifiers.setValue(RpFunctions.Strings[i],RpFunctions.Objects[i]);
{$ENDIF}
{$IFNDEF USEEVALHASH}
  Fidentifiers.AddObject(RpFunctions.Strings[i],RpFunctions.Objects[i]);
{$ENDIF}
// Identifiers.Assign(Rpfunctions);
end;

destructor TRpCustomEvaluator.Destroy;
begin
 if Rpparser<>nil then
  Rpparser.free;
 FIdentifiers.free;
 FreeRprmFunctions;
 inherited Destroy;
end;

procedure TRpCustomEvaluator.SetExpression(Value:Ansistring);
begin
 if Evaluating then
  Raise Exception.Create(SRpsetexpression);
 FExpression:=Value;
end;

// To evaluate a text we must create another evaluator
function TRpCustomEvaluator.EvaluateText(text:string):TRpValue;
var eval:TRpCustomEvaluator;
{$IFDEF USEEVALHASH}
    oldiden:TStringHash;
{$ENDIF}
{$IFNDEF USEEVALHASH}
    oldiden:TStringList;
{$ENDIF}
begin
 oldiden:=nil;
 if Evaluating then
 begin
  eval:=TRpCustomEvaluator.CreateWithoutiden(Self,false);
  try
   oldiden:=eval.Identifiers;
   eval.Identifiers:=Identifiers;
{$IFDEF USEREPORTFUNC}
   eval.Rpalias:=FRpalias;
{$ENDIF}
   eval.Expression:=text;
   eval.Evaluate;
   Result:=eval.EvalResult;
  finally
   eval.Identifiers:=oldiden;
   eval.free;
  end;
 end
 else
 begin
  Expression:=text;
  Evaluate;
  Result:=EvalResult;
 end;
end;

// Checking for syntax
procedure TRpCustomEvaluator.CheckSyntax;
begin
 Rpparser.Expression:=FExpression;

 if Rpparser.TokenString='' then
 begin
  FEvalResult:=True;
  Exit;
 end;
 FChecking:=True;
 try
  EvaluateExpression;
  FEvalResult:=True;
 except
  FEvalResult:=False;
  Raise;
 end;
end;

procedure TRpCustomEvaluator.Evaluate;
begin
 Rpparser.Expression:=FExpression;
 FChecking:=False;
 if ((Rpparser.TokenString='') AND (Not (Rpparser.Token in [tkString,toWString]))) then
 begin
  FEvalResult:=True;
  Exit;
 end;
 FEvalResult:=EvaluateExpression;
end;

function TRpCustomEvaluator.EvaluateExpression:TRpValue;
begin
 FPartial:=varnull;
 try
  Evaluating:=True;
  try
   // Call the recursive tree to evaluate the expresion
   separator(FPartial);
  finally
   Evaluating:=False;
  end;
 except
  // We can assign error information here
  on E:EZeroDivide do
   begin
    FError:=SRpDivisioZero;
    FLineError:=Rpparser.SourceLine;
    FPosError:=Rpparser.SourcePos;
    Raise TRpEvalException.Create(FError,
        Rpparser.TokenString,FLineError,FPosError);
   end;
  On E:TRpNamedException do
   begin
   FError:=E.ErrorMessage;
   FLineError:=Rpparser.SourceLine;
   FPosError:=Rpparser.SourcePos;
   Raise TRpEvalException.Create(FError+' '''+E.ElementError+'''',
        Rpparser.TokenString,FLineError,FPosError)
   end;
  on EParserError do
   begin
    FError:=SRpEvalSyntax;
    FLineError:=Rpparser.SourceLine;
    FPosError:=Rpparser.SourcePos;
    Raise TRpEvalException.Create(Ferror,
        Rpparser.TokenString,FLineError,FPosError);
   end;
  on E:TRpEvalException do
   begin
    FError:=E.ErrorMessage;
    FLineError:=E.ErrorLine;
    FPosError:=E.ErrorPosition;
    Raise;
   end;
  on E:EVariantError do
   begin
    if E.Message=SInvalidCast then
    begin
     FError:=SRpEvalType;
     FLineError:=Rpparser.SourceLine;
     FPosError:=Rpparser.SourcePos;
     Raise TRpEvalException.Create(Ferror,
         Rpparser.TokenString,FLineError,FPosError);
    end
    else
     if E.Message=SInvalidVarOp then
     begin
      FError:=SRpInvalidOperation;
      FLineError:=Rpparser.SourceLine;
      FPosError:=Rpparser.SourcePos;
      Raise TRpEvalException.Create(Ferror,
         Rpparser.TokenString,FLineError,FPosError);
     end;
   end;
  else
  begin
   FError:=SRpEvalSyntax;
   FLineError:=Rpparser.SourceLine;
   FPosError:=Rpparser.SourcePos;
   Raise;
  end;
 end;

 if Rpparser.Token<>toEOF then
 begin
  FError:=SRpEvalSyntax;
  FLineError:=Rpparser.SourceLine;
  FPosError:=Rpparser.SourcePos;
  Raise TRpEvalException.Create(SRpEvalSyntax+Rpparser.TokenString,
        Rpparser.TokenString,Rpparser.SourceLine,Rpparser.SourcePos);
 end;
 Result:=FPartial;
end;

procedure TRpCustomEvaluator.variables(var Value:TRpValue);
var
 iden:TRpIdentifier;
begin
 if Rpparser.Token=toSymbol then
 begin
  // Exists this identifier?
  iden:=Searchidentifier(Rpparser.TokenString);
  if iden=nil then
  begin
   Raise TRpEvalException.Create(SRpEvalDescIden+':'+
         Rpparser.TokenString,Rpparser.TokenString,
        Rpparser.SourceLine,Rpparser.SourcePos);
  end
  else
  begin
   iden.evaluator:=self;
   // Is a variable?
   if iden.RType=RTypeidenvariable then
   begin
    // Is a := , so we must assign
    if Rpparser.NextTokenIs(':=') then
    begin
     Rpparser.NextToken;
     // The :=
     Rpparser.NextToken;
     // Look for the value
     variables(Value);
     // If syntax checking not touch the variable
     if (Not FChecking) then
      (iden As TIdenVariable).Value:=Value;
     if ((Rpparser.Token=toOperator) and (Rpparser.TokenString[1]=';')) then
      separator(Value);
    end
    else
     // not a := we must continue
     logicalOR(Value);
   end
   else
    // look for it
    logicalOR(Value);
  end
 end
 else
 begin
   // look for it
  logicalOR(Value);
 end;
end;

{**************************************************************************}

procedure TRpCustomEvaluator.logicalOR(var Value:TRpValue);
var operador:string[3];
    Auxiliar,Auxiliar2:TRpValue;
begin
 // First precedes the AND operator
 logicalAND(Value);

 if Rpparser.Token=toOperator then
 begin
  operador:=UpperCase(Rpparser.TokenString);
  while (operador='OR') do
  begin
   Auxiliar2:=Value;
   Rpparser.NextToken;
   logicalAND(Auxiliar);
   // Compatible types?
   if (Not FChecking) then
    Value:=LogicalORTRpValue(Auxiliar2,Auxiliar);
   if Rpparser.Token<>toOperator then
    Exit
   else
    operador:=UpperCase(Rpparser.TokenString);
  end;
 end;
end;

procedure TRpCustomEvaluator.logicalAND(var Value:TRpValue);
var operador:string[3];
    Auxiliar,Auxiliar2:TRpValue;
begin
 comparations(Value);       

 if Rpparser.Token=toOperator then
 begin
  operador:=UpperCase(Rpparser.TokenString);
  while (operador='AND') do
  begin
   Rpparser.NextToken;
   Auxiliar2:=Value;
   comparations(Auxiliar);
   // Compatible types?
   if (Not FChecking) then
    Value:=LogicalANDTRpValue(Auxiliar2,Auxiliar);
   if Rpparser.Token<>toOperator then
    Exit
   else
    operador:=UpperCase(Rpparser.TokenString);
  end;
 end;
end;

procedure TRpCustomEvaluator.separator(var Value:TRpValue);
begin
 if ((Rpparser.Token=toOperator) and (Rpparser.TokenString[1]=';')) then
 begin
  while ((Rpparser.Token=toOperator) and (Rpparser.TokenString[1]=';')) do
  begin
   Rpparser.NextToken;
   if (Rpparser.Token<>toEof) then
    variables(Value);
  end
 end
 else
 begin
  variables(Value);
  while ((Rpparser.Token=toOperator) and (Rpparser.TokenString[1]=';')) do
  begin
   Rpparser.NextToken;
   if (Rpparser.Token<>toEof) then
    variables(Value);
  end
 end;
end;

procedure TRpCustomEvaluator.comparations(var Value:TRpValue);
var
operation:string[3];
auxiliar,auxiliar2:TRpValue;
begin
 sum_dif(Value);
 while Rpparser.Token=tooperator do
 begin
  operation:=Rpparser.TokenString;
  if operation='=' then
    begin
     Rpparser.NextToken;
     auxiliar2:=Value;
     sum_dif(auxiliar);
     if (NOT FChecking) then
      Value:=EqualTRpValue(Auxiliar2,auxiliar);
    end
   else
   if ((operation='<>') OR (operation='><')) then
   begin
    Rpparser.NextToken;
    auxiliar2:=Value;
    sum_dif(auxiliar);
    if (NOT FChecking) then
    Value:=DiferentTRpValue(auxiliar2,auxiliar);
   end
   else
   if operation='>=' then
   begin
    Rpparser.NextToken;
    auxiliar2:=Value;
    sum_dif(auxiliar);
    if (NOT FChecking) then
    Value:=MoreThanEqualTRpValue(auxiliar2,auxiliar);
   end
   else
   if operation='<=' then
   begin
    Rpparser.NextToken;
    auxiliar2:=Value;
    sum_dif(auxiliar);
    if (NOT FChecking) then
    Value:=LessThanEqualTRpValue(auxiliar2,auxiliar);
   end
   else
   if operation='>' then
   begin
    Rpparser.NextToken;
    auxiliar2:=Value;
    sum_dif(auxiliar);
    if (NOT FChecking) then
    Value:=MoreThanTRpValue(auxiliar2,auxiliar);
   end
   else
   if operation='<' then
   begin
    Rpparser.NextToken;
    auxiliar2:=Value;
    sum_dif(auxiliar);
    if (NOT FChecking) then
    Value:=LessThanTRpValue(auxiliar2,auxiliar);
   end
   else
   if operation='==' then
   begin
    Rpparser.NextToken;
    auxiliar2:=Value;
    sum_dif(auxiliar);
    if (NOT FChecking) then
    Value:=EqualEqualTRpValue(auxiliar2,auxiliar);
   end
   else
   if operation=':=' then
   begin
    Raise TRpEvalException.Create(SRpEvalDescIdenLeft+':'+
          Rpparser.TokenString,Rpparser.TokenString,
         Rpparser.SourceLine,Rpparser.SourcePos);
   end
   else
    Exit;
 end;
end;

procedure TRpCustomEvaluator.sum_dif(var Value:TRpValue);
var operador:string[3];
    Auxiliar,auxiliar2:TRpValue;
begin
 mul_div(Value);

 if Rpparser.Token=toOperator then
 begin
  operador:=UpperCase(Rpparser.TokenString);
  while ((operador='+') or (operador='-')) do
  begin
   Rpparser.NextToken;
   auxiliar2:=Value;
   mul_div(Auxiliar);

   // Compatible types?
   if (Not FChecking) then
   case operador[1] of
    '+':Value:=SumTRpValue(auxiliar2,Auxiliar);
    '-':Value:=DifTRpValue(auxiliar2,Auxiliar);
   end;
   if Rpparser.Token<>toOperator then
    Exit
   else
    operador:=UpperCase(Rpparser.TokenString);
  end;
 end;
end;

procedure TRpCustomEvaluator.mul_div(var Value:TRpValue);
var operador:string[4];
    Auxiliar,auxiliar2:TRpValue;
begin
 dosign(Value);

 if Rpparser.Token=toOperator then
 begin
  operador:=Uppercase(Rpparser.TokenString);
  while ((operador='*') or (operador='/')) do
  begin
   Rpparser.NextToken;
   auxiliar2:=Value;
   dosign(Auxiliar);
   if (Not FChecking) then
   case operador[1] of
    '*':Value:=MultTRpValue(auxiliar2,Auxiliar);
    '/':Value:=DivTRpValue(auxiliar2,Auxiliar);
   end;
   if Rpparser.Token<>toOperator then
      Exit
   else
    operador:=UpperCase(Rpparser.TokenString);
  end;
 end;
end;

// The sign is same precedence than functions
procedure TRpCustomEvaluator.dosign(var Value:TRpValue);
var operador:string[4];
    iden:TRpIdentifier;
    i:integer;
begin
 iden:=nil;
 operador:='';
 if Rpparser.Token=toOperator then
 begin
  operador:=UpperCase(Rpparser.TokenString);
  if ((operador='+') or (operador='-')
       or (operador='NOT') or (operador='IIF')) then
   Rpparser.NextToken;
 end
 else
 // Is a function?
 if Rpparser.Token=toSymbol then
 begin
  iden:=Searchidentifier(Rpparser.TokenString);
  if iden=nil then
   Raise TRpEvalException.Create(SRpEvalDescIden+
       Rpparser.TokenString,Rpparser.TokenString,
      Rpparser.SourceLine,Rpparser.SourcePos);
  if iden.RType=RTypeidenfunction then
  begin
   iden.evaluator:=self;
   // Ok is a function assign params
   if iden.paramcount>0 then
   begin
    Rpparser.NextToken;
    if Rpparser.Token<>toOperator then
       Raise TRpEvalException.Create(SRpEvalParent+' ('+
       Rpparser.TokenString,' ( '+Rpparser.TokenString,Rpparser.SourceLine,
       Rpparser.SourcePos);
    if Rpparser.TokenString<>'(' then
       Raise TRpEvalException.Create(SRpEvalParent+
       Rpparser.TokenString,'('+Rpparser.TokenString,Rpparser.SourceLine,
       Rpparser.SourcePos);
   end;
   for i:=0 to iden.paramcount-1 do
   begin
    // Next param
    Rpparser.NextToken;
    // Look for the value
    separator(iden.Params[i]);
    // Param separator is ','
    if iden.paramcount>i+1 then
    begin
      if Rpparser.Token<>ToOperator then
       Raise TRpEvalException.Create(SRpEvalSyntax+
       Rpparser.TokenString,Rpparser.TokenString,Rpparser.SourceLine,
       Rpparser.SourcePos);
      if Rpparser.TokenString[1]<>',' then
       Raise TRpEvalException.Create(SRpEvalSyntax+
       Rpparser.TokenString,Rpparser.TokenString,Rpparser.SourceLine,
       Rpparser.SourcePos);
     end;
   end;
   // Now the close ) expected
   if iden.paramcount>0 then
   begin
    if Rpparser.Token<>toOperator then
       Raise TRpEvalException.Create(SRpEvalParent+' )'+
       Rpparser.TokenString,' ) '+Rpparser.TokenString,Rpparser.SourceLine,
       Rpparser.SourcePos);
    if Rpparser.TokenString<>')' then
       Raise TRpEvalException.Create(SRpEvalParent+' )'+
       Rpparser.TokenString,' ) '+Rpparser.TokenString,Rpparser.SourceLine,
       Rpparser.SourcePos);
    Rpparser.NextToken;
   end;
  end
  else
   // If not a function must be an operator
   iden:=nil;
 end;
 if iden=nil then
 begin
  if operador='IIF' then
     ExecuteIIF(Value)
  else
   parentesis(Value)
 end
 else
  if iden.paramcount=0 then
   Rpparser.NextToken;

 // If it's a funcion execute it (if not syntax check)
 if iden<>nil then
 begin
  if Not FChecking then
   Value:=iden.Value;
 end
 else
 begin
  if operador='-' then
     if (NOT FChecking) then
      Value:=SignTRpValue(Value)
     else
     begin
     end
  else
   if operador='NOT' then
     if (NOT FChecking) then
      Value:=LogicalNOTTRpValue(Value);
 end;
end;

procedure TRpCustomEvaluator.Operand(var Value:TRpValue);
VAR
    iden:TRpIdentifier;
begin
 case Rpparser.Token of
  toSymbol:
   begin
    // Obtaining the value of an identifier
    iden:=Searchidentifier(Rpparser.TokenString);
    if iden=nil then
    begin
     Raise TRpEvalException.Create(SRpEvalDescIden+
         Rpparser.TokenString,Rpparser.TokenString,
        Rpparser.SourceLine,Rpparser.SourcePos);
    end;
    iden.evaluator:=self;
    Value:=iden.Value;
    Rpparser.NextToken;
   end;
  tkString:
   begin
    Value:=Rpparser.TokenString;
    Rpparser.NextToken;
   end;
  toWString:
   begin
    Value:=Rpparser.TokenWideString;
    Rpparser.NextToken;
   end;
  toInteger:
   begin
    Value:=Rpparser.TokenInt;
    Rpparser.NextToken;
   end;
  toFloat:
   begin
    Value:=Rpparser.TokenFloat;
    Rpparser.NextToken;
   end;
  else
  begin
   Raise TRpEvalException.Create(SRpEvalSyntax+
         Rpparser.TokenString,Rpparser.TokenString,
        Rpparser.SourceLine,Rpparser.SourcePos);
  end;
 end;
end;

procedure TRpCustomEvaluator.parentesis(var Value:TRpValue);
var operation:Ansichar;
begin
 if Rpparser.Token=toOperator then
 begin
  operation:=Rpparser.TokenString[1];
  if operation='(' then
  begin
   Rpparser.NextToken;
   // Look into the parentesis
   separator(Value);

   if (Rpparser.Token<>toOperator) then
    Raise TRpEvalException.Create(SRpEvalParent,'',
        Rpparser.SourceLine,Rpparser.SourcePos);
   operation:=Rpparser.TokenString[1];
   if (operation<>')') then
      Raise TRpEvalException.Create(SRpEvalParent,'',
        Rpparser.SourceLine,Rpparser.SourcePos);
   Rpparser.NextToken;
  end
  else
   operand(Value);
 end
 else
   operand(Value);
end;

procedure TRpCustomEvaluator.ExecuteIIF(var Value:TRpValue);
var
 auxiliar:TRpValue;
 AnticFChecking:Boolean;
begin
 // Must be a parentesis
 if Rpparser.Token<>toOperator then
   Raise TRpEvalException.Create(SRpEvalParent,'(',
      Rpparser.SourceLine,Rpparser.SourcePos);
 if Rpparser.TokenString<>'(' then
   Raise TRpEvalException.Create(SRpEvalParent,'(',
      Rpparser.SourceLine,Rpparser.SourcePos);
 // Decision term
 Rpparser.NextToken;
 separator(Value);
 // Null means false
 if VarIsNull(Value) then
  Value:=false;
 // Not boolean error
 if ((VarType(Value)<>varBoolean) AND (Not FChecking)) then
   Raise TRpEvalException.Create(SRpEvalType,'IIF',
      Rpparser.SourceLine,Rpparser.SourcePos);
 // Next tokens
 if Rpparser.Token<>tooperator then
   Raise TRpEvalException.Create(SRpEvalSyntax,'IIF',
      Rpparser.SourceLine,Rpparser.SourcePos);
 if Rpparser.Tokenstring<>',' then
   Raise TRpEvalException.Create(SRpEvalSyntax,'IIF',
      Rpparser.SourceLine,Rpparser.SourcePos);
 Rpparser.NextToken;
 // If yes and not checking syntax
 if Not FChecking then
 begin
  if Boolean(Value) then
  begin
   separator(Value);
   // Skip the second term
   if Rpparser.Token<>tooperator then
     Raise TRpEvalException.Create(SRpEvalSyntax,'IIF',
        Rpparser.SourceLine,Rpparser.SourcePos);
   if Rpparser.Tokenstring<>',' then
     Raise TRpEvalException.Create(SRpEvalSyntax,'IIF',
        Rpparser.SourceLine,Rpparser.SourcePos);
   Rpparser.NextToken;

   AnticFChecking:=FChecking;
   FChecking:=True;
   separator(auxiliar);
   FChecking:=AnticFChecking;
  end
  else
  begin
   AnticFChecking:=FChecking;
   FChecking:=True;
   separator(auxiliar);

   if Rpparser.Token<>tooperator then
     Raise TRpEvalException.Create(SRpEvalSyntax,'IIF',
        Rpparser.SourceLine,Rpparser.SourcePos);
   if Rpparser.Tokenstring<>',' then
     Raise TRpEvalException.Create(SRpEvalSyntax,'IIF',
        Rpparser.SourceLine,Rpparser.SourcePos);
   Rpparser.NextToken;

   FChecking:=AnticFChecking;
   separator(Value);
  end;
 end
 else
 // Syntax checking
 begin
  // Skip the params
  separator(Value);
  if Rpparser.Token<>tooperator then
    Raise TRpEvalException.Create(SRpEvalSyntax,'IIF',
       Rpparser.SourceLine,Rpparser.SourcePos);
  if Rpparser.Tokenstring<>',' then
    Raise TRpEvalException.Create(SRpEvalSyntax,'IIF',
       Rpparser.SourceLine,Rpparser.SourcePos);
  Rpparser.NextToken;
  separator(auxiliar);
 end;
 // Must be a ) now
 if Rpparser.Token<>toOperator then
   Raise TRpEvalException.Create(SRpEvalParent,')',
      Rpparser.SourceLine,Rpparser.SourcePos);
 if Rpparser.TokenString<>')' then
   Raise TRpEvalException.Create(SRpEvalParent,')',
      Rpparser.SourceLine,Rpparser.SourcePos);
 Rpparser.NextToken;
end;

procedure TRpCustomEvaluator.AddVariable(name1:string;objecte:TRpIdentifier);
begin
 objecte.idenname:=name1;
{$IFDEF USEEVALHASH}
 FIdentifiers.SetValue('M.'+AnsiUpperCase(name1),objecte);
{$ENDIF}
{$IFNDEF USEEVALHASH}
 FIdentifiers.AddObject('M.'+AnsiUpperCase(name1),objecte);
{$ENDIF}
end;

procedure TRpCustomEvaluator.AddIden(name1:string;objecte:TRpIdentifier);
begin
{$IFDEF USEEVALHASH}
 Identifiers.SetValue(name1,objecte);
{$ENDIF}
{$IFNDEF USEEVALHASH}
 Identifiers.AddObject(name1,objecte);
{$ENDIF}
end;

function TRpCustomEvaluator.Searchwithoutdot(name1:Shortstring):TRpIdentifier;
var
 Doble:Boolean;
{$IFNDEF USEEVALHASH}
  index:integer;
{$ENDIF}
begin
  Doble:=False;
{$IFDEF USEEVALHASH}
  Result:=FIdentifiers.GetValue(name1) As TRpIdentifier;
{$ENDIF}
{$IFNDEF USEEVALHASH}
  Result:=nil;
  index:=FIdentifiers.IndexOf(name1);
  if index>=0 then
   Result:=FIdentifiers.Objects[index] As TRpIdentifier;
{$ENDIF}
  if Assigned(Result) then
   Exit;
  // Memory variable?
{$IFNDEF USEEVALHASH}
  index:=FIdentifiers.IndexOf('M.'+name1);
  if index>=0 then
   Result:=FIdentifiers.Objects[index] As TRpIdentifier;
{$ENDIF}
{$IFDEF USEEVALHASH}
  Result:=FIdentifiers.GetValue('M.'+name1) As TRpIdentifier;
{$ENDIF}
  if Assigned(Result) then
   Exit;
  // May be a field ?
{$IFDEF USEREPORTFUNC}
  if FRpalias<>nil then
   Result:=FRpalias.Searchfield(name1,'',Doble);
{$ENDIF}
  if Doble then
     Raise TRpEvalException.Create(SRpFieldDuplicated+ Rpparser.TokenString,
       Rpparser.TokenString,Rpparser.SourceLine,Rpparser.SourcePos);
end;

function TRpCustomEvaluator.Searchidentifier(name1:Shortstring):TRpIdentifier;
var
pospunt:byte;
primer,sensepunt:string;
doble:Boolean;
{$IFNDEF USEEVALHASH}
 index:integer;
{$ENDIF}
begin
 name1:=AnsiUpperCase(name1);
 Result:=nil;
 // Have a point ?
 pospunt:=Pos('.',name1);
 if pospunt=0 then
 begin
  Result:=Searchwithoutdot(name1);
  Exit;
 end;
 primer:=copy(name1,0,pospunt-1);
  // Memory variable ?
 if primer='M' then
 begin
{$IFNDEF USEEVALHASH}
  index:=FIdentifiers.IndexOf(name1);
  if index>=0 then
   Result:=FIdentifiers.Objects[index] As TRpIdentifier;
{$ENDIF}
{$IFDEF USEEVALHASH}
  Result:=FIdentifiers.GetValue(name1) As TRpIdentifier;
{$ENDIF}
  Exit;
 end;
 sensepunt:=copy(name1,pospunt+1,ord(name1[0])-pospunt);
{$IFDEF USEREPORTFUNC}
 if FRpalias<>nil then
  Result:=FRpalias.Searchfield(sensepunt,primer,Doble);
{$ENDIF}
end;

function TRpCustomEvaluator.GetEvalResultString:Ansistring;
begin
 Result:=TRpValueToString(EvalResult);
end;

procedure TRpCustomEvaluator.Notification(AComponent:TComponent;Operation:TOperation);
begin
 inherited Notification(AComponent,Operation);
 if operation=opRemove then
 begin
{$IFDEF USEREPORTFUNC}
  if AComponent=FRpalias then
   Rpalias:=nil;
{$ENDIF}
 end;
end;


function TRpCustomEvaluator.NewVariable(name1:string;ValueIni:TRpValue):TIdenVariable;
var iden:TIdenVariable;
begin
 if Searchidentifier(name1)=nil then
 begin
  iden:=TIdenVariable.Create(Self);
  iden.Value:=ValueIni;
  // The owner is the TRprmEvaluator to free the variable
  AddVariable(name1,iden);
  iden.evaluator:=self;
  REsult:=Iden;
 end
 else
  // Error variable redeclared
  Raise Exception.Create(SRpVariabledefined+name1)
end;

procedure TRpCustomEvaluator.Freerprmfunctions;
var
 i:integer;
begin
 if assigned(rpfunctions) then
 begin
  for i:=0 to Rpfunctions.count-1 do
  begin
   Rpfunctions.objects[i].free;
  end;
 end;
 rpfunctions.free;
end;

procedure TRpCustomEvaluator.InitRpFunctions;
begin
 Rpfunctions:=TStringList.create;
 Rpfunctions.Sorted:=True;
 Rpfunctions.Duplicates:=dupError;
end;

function EvaluateExpression(aexpression:WideString):Variant;
var
 aeval:TRpEvaluator;
begin
 aeval:=TRpEvaluator.Create(nil);
 try
  aeval.Expression:=aexpression;
  aeval.Evaluate;
  Result:=aeval.EvalResult;
 finally
  aeval.free;
 end;
end;

{$IFDEF DOTNETD}
function BytesToGraphicHeader(const ABytes: TBytes): TGraphicHeader;
begin
  Result.Count := System.BitConverter.ToUInt16(ABytes, 0);
  Result.HType := System.BitConverter.ToUInt16(ABytes, sizeof(Result.Count));
  Result.Size := System.BitConverter.ToUInt32(ABytes, sizeof(Result.Count) +
    sizeof(Result.HType));
end;
{$ENDIF}



function TRpCustomEvaluator.GetStreamFromExpression(atext:WideString):TMemoryStream;
var
 iden:TRpIdentifier;
 afield:TField;
 aValue:Variant;
 afilename:TFilename;
 AStream:TStream;
 FMStream:TMemoryStream;
 Size,readed: Longint;
 i,lvalue,hvalue:integer;
 Header: TGraphicHeader;
 astring:String;
 p:Pointer;
{$IFDEF DOTNETD}
 Temp:TBytes;
{$ENDIF}
begin
   Result:=nil;
   iden:=SearchIdentifier(atext);
   if Assigned(iden) then
    if (Not (iden is TIdenField)) then
     iden:=nil;
   if Not Assigned(iden) then
   begin
    // Looks for a string (path to file)
    aValue:=EvaluateText(atext);
    if (not ((VarType(aValue)=varString) or (VarType(aValue)=varOleStr))) then
    begin
     // Check for a varvinary variant type
     i:=VarType(aValue);
     if (i=8209) then
     begin
      FMStream:=TMemoryStream.Create;
      try
       lvalue:=VarArrayLowBound(aValue,1);
       hvalue:=VarArrayHighBound(aValue,1);
//       readed:=1;
//       lvalue:=VarArrayLowBound(aValue,1);
//       hvalue:=VarArrayHighBound(aValue,1);
//       SetLength(astring,hvalue-lvalue+1);
//       for i:=lvalue to hvalue do
//       begin
//        astring[readed]:=char(byte(aValue[i]));
//        readed:=readed+1;
//       end;
       p:=VarArrayLock(aValue);
       try
        FMStream.Write(p^,hvalue-lvalue+1);
       finally
        VarArrayUnLock(aValue);
       end;
       FMStream.Seek(0,soFromBeginning);
//       FMStream.Write(astring[1],Length(astring));
//       FMStream.Seek(0,soFromBeginning);
      except
       FMStream.free;
       raise;
      end;
      Result:=FMStream;
      exit;
     end;
     Raise Exception.Create(SRpFieldNotFound+atext);
    end;
    afilename:=Trim(aValue);
    if (Length(afilename)=0) then
    begin
     FMStream:=nil;
    end
    else
    begin
    FMStream:=TMemoryStream.Create;
    try
     AStream:=TFileStream.Create(afilename,fmOpenread or fmShareDenyWrite);
     try
      Size := AStream.Size;
      FMStream.SetSize(Size);
      if Size >= SizeOf(TGraphicHeader) then
      begin
{$IFDEF DOTNETD}
      SetLength(Temp,SizeOf(Header));
      AStream.Read(Temp, SizeOf(Header));
      Header := BytesToGraphicHeader(Temp);
      if (Header.Count <> 1) or (Header.HType <> $0100) or
        (Header.Size <> Size - SizeOf(Header)) then
        AStream.Position := 0
      else
        FMStream.SetSize(AStream.Size-SizeOf(Header));
{$ENDIF}
{$IFNDEF DOTNETD}
        AStream.Read(Header, SizeOf(Header));
        if (Header.Count <> 1) or (Header.HType <> $0100) or
          (Header.Size <> Size - SizeOf(Header)) then
          AStream.Position := 0
        else
         FMStream.SetSize(AStream.Size-SizeOf(Header));
{$ENDIF}
      end;
      FMStream.Seek(0,soFromBeginning);
{$IFNDEF DOTNETD}
      readed:=AStream.Read(FMStream.Memory^,FMStream.Size);
{$ENDIF}
{$IFDEF DOTNETD}
      readed:=FMStream.CopyFrom(AStream,FMStream.Size);
{$ENDIF}
      if readed<>FMStream.Size then
       Raise Exception.Create(SRpErrorReadingFromFieldStream);
      FMStream.Seek(0,soFromBeginning);
     finally
      AStream.free;
     end;
     Result:=FMStream;
    except
     FMStream.free;
     Raise;
    end;
    end;
   end
   else
   begin
    AField:=(iden As TIdenField).Field;
    if (Not (AField is TBlobField)) then
    begin
     astring:=AField.AsString;
     if (Length(astring)>0) then
     begin
      FMStream:=TMemoryStream.Create;
      try
       FMStream.SetSize(Length(astring));
       FMStream.Write(astring[1],FMStream.Size);
       FMStream.Seek(0,soFromBeginning);
       Result:=FMStream;
      except
       FMStream.free;
       raise;
      end;
     end;
     exit;
    end;
    if AField.isnull then
     exit;
    FMStream:=TMemoryStream.Create;
    try
     AStream:=AField.DataSet.CreateBlobStream(AField,bmRead);
     try
      Size := AStream.Size;
      FMStream.SetSize(Size);
      if Size >= SizeOf(TGraphicHeader) then
      begin
{$IFDEF DOTNETD}
       SetLength(Temp,SizeOf(Header));
       AStream.Read(Temp, SizeOf(Header));
       Header := BytesToGraphicHeader(Temp);
       if (Header.Count <> 1) or (Header.HType <> $0100) or
         (Header.Size <> Size - SizeOf(Header)) then
         AStream.Position := 0
       else
        FMStream.SetSize(AStream.Size-SizeOf(Header));
{$ENDIF}
{$IFNDEF DOTNETD}
        AStream.Read(Header, SizeOf(Header));
        if (Header.Count <> 1) or (Header.HType <> $0100) or
          (Header.Size <> Size - SizeOf(Header)) then
          AStream.Position := 0
        else
         FMStream.SetSize(AStream.Size-SizeOf(Header));
{$ENDIF}
      end;
      FMStream.Seek(0,soFromBeginning);
{$IFNDEF DOTNETD}
      readed:=AStream.Read(FMStream.Memory^,FMStream.Size);
{$ENDIF}
{$IFDEF DOTNETD}
      readed:=FMStream.CopyFrom(AStream,FMStream.Size);
{$ENDIF}
      if readed<>FMStream.Size then
       Raise Exception.Create(SRpErrorReadingFromFieldStream);
      FMStream.Seek(0,soFromBeginning);
     finally
      AStream.free;
     end;
     Result:=FMStream;
    except
     FMStream.free;
     Raise;
    end;
   end;
end;


initialization



finalization


end.
