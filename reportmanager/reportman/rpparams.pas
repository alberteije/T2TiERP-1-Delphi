{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpparams                                        }
{                                                       }
{       Parameter collection to assign to datasets      }
{       and expresion evaluator                         }
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

unit rpparams;

interface

{$I rpconf.inc}

uses Classes, SysUtils,rpmdconsts,
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
{$IFNDEF FORWEBAX}
 DB,
{$ENDIF}
 rptypes;

type
  TRpParam=class(TCollectionitem)
   private
    FName:string;
    FDescription:widestring;
    FHint:widestring;
    FIsReadOnly:Boolean;
    FNeverVisible:Boolean;
    FSearch:WideString;
    FVisible:boolean;
    FAllowNulls:boolean;
    FValue:variant;
    FParamType:TRpParamType;
    FDatasets:TStrings;
    FItems:TStrings;
    FValues:TStrings;
    FSelected:TStrings;
    FLookupDataset:String;
    FSearchDataset:String;
    FSearchParam:String;
    FValidation:WideString;
    FErrorMessage:WideString;
    procedure SetVisible(AVisible:boolean);
    procedure SetIsReadOnly(AReadOnly:boolean);
    procedure SetNeverVisible(ANeverVisible:boolean);
    procedure SetAllowNulls(AAllowNulls:boolean);
    procedure SetName(AName:String);
    procedure SetValue(AValue:variant);
    procedure SetDescription(ADescription:widestring);
    procedure SetErrorMessage(AMessage:widestring);
    function GetErrorMessage:widestring;
    procedure SetValidation(AValidation:widestring);
    function GetDescription:widestring;
    function GetHint:widestring;
    procedure SetHint(AHint:widestring);
    procedure SetSearch(ASearch:widestring);
    procedure SetParamType(AParamType:TRpParamType);
    procedure WriteDescription(Writer:TWriter);
    procedure WriteErrorMessage(Writer:TWriter);
    procedure WriteValidation(Writer:TWriter);
    procedure WriteHint(Writer:TWriter);
    procedure ReadSearch(Reader:TReader);
    procedure WriteSearch(Writer:TWriter);
    procedure ReadDescription(Reader:TReader);
    procedure ReadErrorMessage(Reader:TReader);
    procedure ReadValidation(Reader:TReader);
    procedure ReadHint(Reader:TReader);
    function GetAsString:WideString;
    procedure SetAsString(NewValue:WideString);
    function GetMultiValue:String;
    function GetValue:Variant;
   protected
    procedure DefineProperties(Filer:TFiler);override;
   public
    LastValue:Variant;
    EvaluatedParam:boolean;
    EvaluatedString:string;
    Constructor Create(Collection:TCollection);override;
    procedure Assign(Source:TPersistent);override;
    destructor Destroy;override;
    procedure SetDatasets(AList:TStrings);
    procedure SetItems(AList:TStrings);
    procedure SetValues(AList:TStrings);
    procedure SetSelected(AList:TStrings);
{$IFNDEF FORWEBAX}
    function GetListValue:Variant;
    procedure UpdateLookup;
    procedure UpdateInitialValue;
{$ENDIF}
    property Description:widestring read GetDescription write SetDescription;
    property Descriptions:widestring read FDescription write FDescription;
    property Hint:widestring read GetHint write SetHint;
    property Hints:widestring read FHint write FHint;
    property Validation:widestring read FValidation write SetValidation;
    property ErrorMessage:widestring read GetErrorMessage write SetErrorMessage;
    property ErrorMessages:widestring read FErrorMessage write FErrorMessage;
    property Search:widestring read FSearch write SetSearch;
    property AsString:WideString read GetAsString write SetAsString;
    property MultiValue:String read GetMultiValue;
   published
    property Name:string read FName write SetName;
    property Visible:Boolean read FVisible write SetVisible default True;
    property IsReadOnly:Boolean read FIsReadOnly write SetIsReadOnly default false;
    property NeverVisible:Boolean read FNeverVisible write SetNeverVisible default false;
    property AllowNulls:Boolean read FAllowNulls write SetAllowNulls default True;
    property Value:Variant read GetValue write SetValue;
    property ParamType:TRpParamType read FParamtype write SetParamType
     default rpParamString;
    property Datasets:TStrings read FDatasets write SetDatasets;
    property Items:TStrings read FItems write SetItems;
    property Values:TStrings read FValues write SetValues;
    property Selected:TStrings read FSelected write SetSelected;
    property LookupDataset:String read FLookupDataset write FLookupDataset;
    property SearchDataset:String read FSearchDataset write FSearchDataset;
    property SearchParam:String read FSearchParam write FSearchParam;
{$IFNDEF FORWEBAX}
    property ListValue:Variant read GetListValue;
{$ENDIF}
  end;

  TRpParamList=class(TCollection)
   private
    FReport:TComponent;
    FLanguage:integer;
   public
    function GetItem(Index:Integer):TRpParam;
    procedure SetItem(index:integer;Value:TRpParam);
    procedure SetLanguage(ALang:integer);
   public
    constructor Create(AOwner:TComponent);
    function Add(AName:String):TRpParam;
    function IndexOf(AName:String):integer;
    function FindParam(AName:string):TRpParam;
    procedure Assign(Source:TPersistent);override;
    function ParamByName(AName:string):TRpParam;
{$IFNDEF FORWEBAX}
    procedure UpdateLookup;
    procedure UpdateInitialValues;
    procedure RestoreInitialValues;
{$ENDIF}
    property Items[index:integer]:TRpParam read GetItem write SetItem;default;
    property Report:TComponent read FReport;
    property Language:Integer read FLanguage write SetLanguage;
   end;

  TRpParamComp=class(TComponent)
   private
    fparams:TRpParamList;
    procedure SetParams(avalue:TRpParamList);
   public
    constructor Create(AOwner:TComponent);override;

   published
    property Params:TRpParamList read FParams write
     SetParams;
   end;

{$IFNDEF FORWEBAX}
function ParamTypeToDataType(paramtype:TRpParamType):TFieldType;
function VariantTypeToDataType(avariant:Variant):TFieldType;
function VariantTypeToParamType(avariant:Variant):TRpParamtype;
{$ENDIF}

function ParamTypeToString(paramtype:TRpParamType):String;
function StringToParamType(Value:String):TRpParamType;
procedure GetPossibleDataTypesDesign(alist:TRpWideStrings);
procedure GetPossibleDataTypesRuntime(alist:TRpWideStrings);
procedure GetPossibleDataTypesDesignA(alist:TStrings);
procedure GetPossibleDataTypesRuntimeA(alist:TStrings);
procedure ParseCommandLineParams(params:TRpParamList);

implementation

{$IFNDEF FORWEBAX}
uses rpeval,rpbasereport,rpreport,rpdatainfo;
{$ENDIF}

procedure TRpParamComp.SetParams(avalue:TRpParamList);
begin
 fparams.Assign(avalue);
end;

constructor TRpParamComp.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 fparams:=TRpParamList.Create(Self);
end;

Constructor TRpParam.Create(Collection:TCollection);
begin
 inherited Create(Collection);
 FVisible:=true;
 FAllowNulls:=true;
 FParamType:=rpParamString;
 FDatasets:=TStringList.Create;
 FItems:=TStringList.Create;
 FValues:=TStringList.Create;
 FSelected:=TStringList.Create;
end;

function TRpParam.GetDescription:WideString;
begin
 Result:=GetLineLangByIndex(FDescription,TRpParamList(Collection).Language);
end;

function TRpParam.GetHint:WideString;
begin
 Result:=GetLineLangByIndex(FHint,TRpParamList(Collection).Language);
end;

procedure TRpParam.SetDescription(ADescription:WideString);
begin
 FDescription:=AddLineLangByIndex(FDescription,ADescription,TRpParamList(Collection).Language);
 Changed(false);
end;

procedure TRpParam.SetHint(AHint:widestring);
begin
 FHint:=AddLineLangByIndex(FHint,AHint,TRpParamList(Collection).Language);
 Changed(false);
end;

function TRpParam.GetErrorMessage:WideString;
begin
 Result:=GetLineLangByIndex(FErrorMessage,TRpParamList(Collection).Language);
end;

procedure TRpParam.SetErrorMessage(AMessage:widestring);
begin
 FErrorMessage:=AddLineLangByIndex(FErrorMessage,AMessage,TRpParamList(Collection).Language);
 Changed(false);
end;

procedure TRpParam.SetValidation(AValidation:widestring);
begin
 FValidation:=AValidation;
 Changed(false);
end;


procedure TRpParam.Assign(Source:TPersistent);
begin
 if (Source is TRpParam) then
 begin
  EvaluatedParam := TRpParam(Source).EvaluatedParam;
  EvaluatedString := TRpParam(Source).EvaluatedString;

  FName:=TRpParam(Source).FName;
  FVisible:=TRpParam(Source).FVisible;
  FNeverVisible:=TRpParam(Source).FNeverVisible;
  FIsReadOnly:=TRpParam(Source).FIsReadOnly;
  FAllowNulls:=TRpParam(Source).FAllowNulls;
  Descriptions:=TRpParam(Source).Descriptions;
  Hints:=TRpParam(Source).Hints;
  FSearch:=TRpParam(Source).FSearch;
  FSelected.Assign(TRpParam(Source).FSelected);
  FItems.Assign(TRpParam(Source).FItems);
  FValues.Assign(TRpParam(Source).FValues);
  FValue:=TRpParam(Source).FValue;
  FParamType:=TRpParam(Source).FParamType;
  FValidation:=TRpParam(Source).FValidation;
  ErrorMessages:=TRpParam(Source).ErrorMessages;
  if ParamType in [rpParamDate,rpParamDateTime,rpParamTime] then
  begin
   if Not VarIsNull(FValue) then
    FValue:=TDateTime(FValue);
  end;
  FDatasets.Clear;
  FDatasets.Assign(TRpParam(Source).FDatasets);
  LastValue:=TRpParam(Source).LastValue;
  FLookupDataset:=TRpParam(Source).FLookupDataset;
  FSearchDataset:=TRpParam(Source).FSearchDataset;
  FSearchParam:=TRpParam(Source).FSearchParam;
 end
 else
  inherited Assign(Source);
end;

destructor TRpParam.Destroy;
begin
 FDatasets.Free;
 FItems.Free;
 FValues.Free;
 FSelected.Free;
 inherited Destroy;
end;


procedure TRpParam.SetIsReadOnly(AReadOnly:boolean);
begin
 FIsReadOnly:=AReadOnly;
 Changed(false);
end;

procedure TRpParam.SetNeverVisible(ANeverVisible:boolean);
begin
 FNeverVisible:=ANeverVisible;
 Changed(false);
end;

procedure TRpParam.SetVisible(AVisible:boolean);
begin
 FVisible:=AVisible;
 Changed(false);
end;

procedure TRpParam.SetAllowNulls(AAllowNulls:boolean);
begin
 FAllowNulls:=AAllowNulls;
 Changed(false);
end;

procedure TRpParam.SetDatasets(AList:TStrings);
begin
 FDatasets.Assign(Alist);
 Changed(False);
end;

procedure TRpParam.SetItems(AList:TStrings);
begin
 FItems.Assign(Alist);
 Changed(False);
end;

procedure TRpParam.SetValues(AList:TStrings);
begin
 FValues.Assign(Alist);
 Changed(False);
end;

procedure TRpParam.SetSelected(AList:TStrings);
begin
 FSelected.Assign(Alist);
 Changed(False);
end;

{$IFNDEF FORWEBAX}
procedure TRpParam.UpdateInitialValue;
var
 aexpression:String;
 avalue:variant;
begin
 if ParamType<>rpParamInitialExpression then
  exit;
 try
  aexpression:=AsString;
  avalue:=rpeval.EvaluateExpression(aexpression);
  EvaluatedParam:=true;
  EvaluatedString:=aexpression;
  FParamType:=VariantTypeToParamType(avalue);
  Value:=avalue;
 except
  on E:Exception do
  begin
   E.Message:=E.Message+' - '+SRpParameter+':'+Name;
   raise;
  end;
 end;

end;




function TRpParam.GetListValue:Variant;
var
 aexpression:String;
 aoption:integer;
begin
 if Not (ParamType in [rpParamList,rpParamMultiple,rpParamSubstList]) then
  Result:=FValue
 else
 if ParamType=rpParamMultiple then
  Result:=GetMultiValue
 else
 begin
  aoption:=0;
  if (VarType(FValue) in [varInteger,varSmallint,varShortint,varByte,varWord,varLongWord,
    varInt64]) then
  begin
   aoption:=FValue;
   if aoption<0 then
    aoption:=0;
  end
  else
  begin
   if ((VarType(FValue)=varString) or (VarType(FValue)=varOleStr)) then
   begin
    aoption:=fvalues.IndexOf(FValue);
    if aoption<0 then
     aoption:=0;
   end;
  end;
  if aoption>=fvalues.Count then
  begin
   Result:=FValue;
  end
  else
  begin
   aexpression:=fvalues.strings[aoption];
   try
    Result:=rpeval.EvaluateExpression(aexpression);
   except
    on E:Exception do
    begin
{$IFDEF DOTNETD}
     Raise Exception.Create(E.Message+' - '+SRpParameter+':'+Name);
{$ENDIF}
{$IFNDEF DOTNETD}
     E.Message:=E.Message+' - '+SRpParameter+':'+Name;
     raise;
{$ENDIF}
    end;
   end;
  end;
 end;
end;

procedure TRpParam.UpdateLookup;
var
 report:TRpReport;
 ditem:TRpDataInfoItem;
 index:integer;
begin
 if Length(LookupDataset)<1 then
  exit;
 report:=TRpReport(TRpParamList(Collection).FReport);
 index:=report.DataInfo.IndexOf(LookupDataset);
 if index<0 then
  Raise Exception.Create(SRpSLookupDatasetNotavail+':'+Name);
 ditem:=report.DataInfo.Items[index];
 ditem.Connect(report.DatabaseInfo,TRpParamList(Collection));
 try
  if ditem.Dataset.FieldCount<2 then
   Raise Exception.Create(SRpSLookupDatasetNotavail+':'+Name);
  Items.Clear;
  Values.Clear;
  while not ditem.Dataset.Eof do
  begin
   Items.Add(ditem.Dataset.Fields[0].AsString);
   Values.Add(ditem.Dataset.Fields[1].AsString);
   ditem.Dataset.Next;
  end;
 finally
  ditem.Disconnect;
 end;
end;

procedure TRpParamList.UpdateInitialValues;
var
 i:integer;
begin
 for i:=0 to Count-1 do
 begin
  items[i].UpdateInitialValue;
 end;
end;

procedure TRpParamList.RestoreInitialValues;
var
 i:integer;
begin
 for i:=0 to Count-1 do
 begin
  if items[i].EvaluatedParam then
  begin
   items[i].ParamType:=rpParamInitialExpression;
   items[i].Value:=items[i].EvaluatedString;
   items[i].EvaluatedParam:=false;
  end;
 end;
end;


procedure TRpParamList.UpdateLookup;
var
 i:integer;
begin
 for i:=0 to Count-1 do
 begin
  items[i].UpdateLookUp;
 end;
end;

{$ENDIF}

procedure TRpParam.SetName(AName:String);
begin
 FName:=AnsiUpperCase(AName);
 Changed(false);
end;

procedure TRpParam.SetParamType(AParamType:TRpParamType);
begin
 FParamType:=AParamType;
 Changed(False);
end;



procedure TRpParam.SetSearch(ASearch:wideString);
begin
 FSearch:=ASearch;
 Changed(false);
end;

procedure TRpParam.SetValue(AValue:Variant);
begin
 if VarType(AValue)=varString then
 begin
  FValue:=WideString(AValue);
 end
 else
 begin
  // To be compatible with Delhi 4-5
  if VarType(AValue)=20 then
   FValue:=Integer(AValue)
  else
   FValue:=AValue;
 end;
 if paramtype<>rpParamExpreB then
  LastValue:=FValue;
 Changed(false);
end;


function TRpParamList.GetItem(Index:Integer):TRpParam;
begin
 Result:=TRpParam(inherited GetItem(index));
end;


procedure TRpParamList.SetItem(index:integer;Value:TRpParam);
begin
 inherited SetItem(Index,Value);
end;

constructor TRpParamList.Create(AOwner:TComponent);
begin
 inherited Create(TRpParam);
 FReport:=AOwner;
end;

function TRpParamList.Add(AName:String):TRpParam;
begin
 // Checks if it exists
 if IndexOf(AName)>0 then
  Raise Exception.Create(SRpParameterExists+ ':'+AName);
 Result:=TRpParam(inherited Add);
 Result.FName:=AName;
 Result.FVisible:=true;
 Result.FAllowNulls:=true;
 Result.FParamType:=rpParamString;
 Result.FValue:=Null;
end;


function TRpParamList.IndexOf(AName:String):integer;
var
 i:integer;
begin
 AName:=AnsiUpperCase(AName);
 Result:=-1;
 i:=0;
 While i<count do
 begin
  if items[i].FName=AName then
  begin
   Result:=i;
   break;
  end;
  inc(i);
 end;
end;

function TRpParamList.FindParam(AName:string):TRpParam;
var
 aindex:integer;
begin
 Result:=nil;
 aindex:=Indexof(AName);
 if aindex>=0 then
  Result:=items[aindex];
end;

function TRpParamList.ParamByName(AName:string):TRpParam;
var
 aindex:integer;
begin
 aindex:=Indexof(AName);
 if aindex<0 then
  Raise Exception.Create(SRpParamNotFound+AName);
 Result:=items[aindex];
end;


{$IFNDEF FORWEBAX}
function VariantTypeToDataType(avariant:Variant):TFieldType;
begin
 case VarType(avariant) of
  varEmpty,varNull:
   Result:=ftUnknown;
  varSmallInt,varInteger,varShortInt,varWord,varLongWord:
   Result:=ftInteger;
  varSingle,varDouble:
   Result:=ftFloat;
  varCurrency:
   Result:=ftCurrency;
  varDate:
   Result:=ftDate;
  varBoolean:
   Result:=ftBoolean;
  varInt64:
   Result:=ftLargeint;
  varString:
   Result:=ftString;
{$IFNDEF DOTNETD}
  varOleStr:
   Result:=ftWideString;
{$ENDIF}
  else
   Result:=ftUnknown;
 end;
end;

function VariantTypeToParamType(avariant:Variant):TRpParamType;
var
 avalue:double;
begin
 case VarType(avariant) of
  varEmpty,varNull:
   Result:=rpparamunknown;
  varSmallInt,varInteger,varShortInt,varWord,varLongWord:
   Result:=rpparaminteger;
  varSingle,varDouble:
   Result:=rpParamDouble;
  varCurrency:
   Result:=rpParamCurrency;
  varDate:
   begin
    Result:=rpParamDate;
    avalue:=avariant;
    if ((avalue-Trunc(avalue))>0) then
    begin
     Result:=rpParamDateTime;
    end;
    if (avalue<1) then
     Result:=rpParamTime;
   end;
  varBoolean:
   Result:=rpParamBool;
  varInt64:
   Result:=rpParamInteger;
  varString:
   Result:=rpParamString;
  varOleStr:
   Result:=rpParamString;
  else
   Result:=rpparamUnknown;
 end;
end;



function ParamTypeToDataType(paramtype:TRpParamType):TFieldType;
begin
  Result:=ftUnknown;
  case ParamType of
   rpParamString:
    Result:=ftString;
   rpParamInteger:
    Result:=ftInteger;
   rpParamDouble:
    Result:=ftFloat;
   rpParamCurrency:
    Result:=ftCurrency;
   rpParamDate:
    Result:=ftDate;
   rpParamTime:
    Result:=ftDateTime;
   rpParamDateTime:
    Result:=ftDateTime;
   rpParamBool:
    Result:=ftBoolean;
   rpParamExpreB:
    Result:=ftString;
   rpParamExpreA:
    Result:=ftString;
   rpParamSubst:
    Result:=ftString;
   rpParamSubstE,rpParamInitialExpression:
    Result:=ftString;
  end;
end;
{$ENDIF}

procedure TRpParam.WriteDescription(Writer:TWriter);
begin
 WriteWideString(Writer, FDescription);
end;

procedure TRpParam.WriteErrorMessage(Writer:TWriter);
begin
 WriteWideString(Writer, FErrorMessage);
end;

procedure TRpParam.WriteValidation(Writer:TWriter);
begin
 WriteWideString(Writer, FValidation);
end;

procedure TRpParam.ReadDescription(Reader:TReader);
begin
 FDescription:=ReadWideString(Reader);
end;

procedure TRpParam.ReadErrorMessage(Reader:TReader);
begin
 FErrorMessage:=ReadWideString(Reader);
end;

procedure TRpParam.ReadValidation(Reader:TReader);
begin
 FValidation:=ReadWideString(Reader);
end;

procedure TRpParam.WriteHint(Writer:TWriter);
begin
 WriteWideString(Writer, FHint);
end;

procedure TRpParam.ReadHint(Reader:TReader);
begin
 FHint:=ReadWideString(Reader);
end;

procedure TRpParam.WriteSearch(Writer:TWriter);
begin
 WriteWideString(Writer, FSearch);
end;

procedure TRpParam.ReadSearch(Reader:TReader);
begin
 FSearch:=ReadWideString(Reader);
end;

procedure TRpParam.DefineProperties(Filer:TFiler);
begin
 inherited;

 Filer.DefineProperty('Description',ReadDescription,WriteDescription,True);
 Filer.DefineProperty('Hint',ReadHint,WriteHint,True);
 Filer.DefineProperty('Search',ReadSearch,WriteSearch,True);
 Filer.DefineProperty('ErrorMessage',ReadErrorMessage,WriteErrorMessage,True);
 Filer.DefineProperty('Validation',ReadValidation,WriteValidation,True);
end;

function TRpParam.GetAsString:WideString;
begin
 if Value=Null then
 begin
  Result:='';
  exit;
 end;
 case ParamType of
  rpParamUnknown:
   Result:='';
  rpParamString,rpParamExpreA,rpParamExpreB,rpParamSubst,rpParamSubstE,rpParamInitialExpression:
   Result:=String(Value);
  rpParamInteger,rpParamDouble,rpParamCurrency:
   Result:=FloatToStr(Value);
  rpParamDate:
   Result:=DateToStr(Value);
  rpParamTime:
   Result:=TimeToStr(Value);
  rpParamDateTime:
   Result:=DateTimeToStr(Value);
  rpParamBool:
   Result:=BoolToStr(Value,True);
{$IFNDEF FORWEBAX}
  rpParamList,rpParamSubstList:
   Result:=GetListValue;
{$ENDIF}
{$IFDEF FORWEBAX}
  rpParamList:
   Result:=String(Value);
{$ENDIF}
  rpParamMultiple:
   Result:=GetMultiValue;
 end;
end;

procedure TRpParam.SetAsString(NewValue:WideString);
begin
 case ParamType of
  rpParamString,rpParamExpreB,rpParamExpreA,rpParamSubst,rpParamSubstE,rpParamInitialExpression:
   Value:=NewValue;
  rpParamInteger,rpParamDouble,rpParamCurrency:
   Value:=StrToFloat(NewValue);
  rpParamDate:
   Value:=StrToDate(NewValue);
  rpParamTime:
   Value:=StrToTime(NewValue);
  rpParamDateTime:
   Value:=StrToDateTime(NewValue);
  rpParamBool:
   Value:=StrToBool(NewValue);
  rpParamUnknown:
   begin
    ParamType:=rpParamString;
    Value:=newValue;
   end;
 end;
end;

function ParamTypeToString(paramtype:TRpParamType):String;
begin
 case ParamType of
  rpParamString:
   Result:=SRpSString;
  rpParamExpreB:
   Result:=SrpSExpressionB;
  rpParamExpreA:
   Result:=SrpSExpressionA;
  rpParamSubst:
   Result:=SRpSParamSubs;
  rpParamSubstE:
   Result:=SRpSParamSubsE;
  rpParamInteger:
   Result:=SRpSInteger;
  rpParamDouble:
   Result:=SRpSFloat;
  rpParamCurrency:
   Result:=SRpSCurrency;
  rpParamDate:
   Result:=SRpSDate;
  rpParamTime:
   Result:=SRpSTime;
  rpParamDateTime:
   Result:=SRpSDateTime;
  rpParamBool:
   Result:=SRpSBoolean;
  rpParamList:
   Result:=SRpSParamList;
  rpParamMultiple:
   Result:=SRpSMultiple;
  rpParamSubstList:
   Result:=SRpSParamSubsList;
  rpParamInitialExpression:
   Result:=SRpSParamInitialExpression;
  rpParamUnknown:
   Result:=SRpSUnknownType;
 end;
end;


function StringToParamType(Value:String):TRpParamType;
begin
 Result:=rpParamUnknown;
 if Value=SRpSString then
 begin
  Result:=rpParamString;
  exit;
 end;
 if Value=SrpSExpressionA then
 begin
  Result:=rpParamExpreA;
  exit;
 end;
 if Value=SrpSExpressionB then
 begin
  Result:=rpParamExpreB;
  exit;
 end;
 if Value=SRpSParamSubs then
 begin
  Result:=rpParamSubst;
  exit;
 end;
 if Value=SRpSParamSubsE then
 begin
  Result:=rpParamSubstE;
  exit;
 end;
 if Value=SRpSInteger then
 begin
  Result:=rpParamInteger;
  exit;
 end;
 if Value=SRpSFloat then
 begin
  Result:=rpParamDouble;
  exit;
 end;
 if Value=SRpSCurrency then
 begin
  Result:=rpParamCurrency;
  exit;
 end;
 if Value=SRpSDate then
 begin
  Result:=rpParamDate;
  exit;
 end;
 if Value=SRpSDateTime then
 begin
  Result:=rpParamDateTime;
  exit;
 end;
 if Value=SRpSTime then
 begin
  Result:=rpParamTime;
  exit;
 end;
 if Value=SRpSBoolean then
 begin
  Result:=rpParamBool;
  exit;
 end;
 if Value=SRpSParamList then
 begin
  Result:=rpParamList;
  exit;
 end;
 if Value=SRpSMultiple then
 begin
  Result:=rpParamMultiple;
  exit;
 end;
 if Value=SRpSParamSubsList then
 begin
  Result:=rpParamSubstList;
  exit;
 end;
 if Value=SRpSParamInitialExpression then
 begin
  Result:=rpParamInitialExpression;
  exit;
 end;
end;

procedure GetPossibleDataTypesDesignA(alist:TStrings);
var
 list:TRpWideStrings;
begin
 list:=TRpWideStrings.Create;
 try
  GetPossibleDataTypesDesign(list);
  alist.Assign(TPersistent(list));
 finally
  list.free;
 end;
end;

procedure GetPossibleDataTypesRuntimeA(alist:TStrings);
var
 list:TRpWideStrings;
begin
 list:=TRpWideStrings.Create;
 try
  GetPossibleDataTypesRuntime(list);
  alist.Assign(TPersistent(list));
 finally
  list.free;
 end;
end;

procedure GetPossibleDataTypesDesign(alist:TRpWideStrings);
begin
 alist.Clear;
 alist.Add(SRpSUnknownType);
 alist.Add(SRpSString);
 alist.Add(SRpSInteger);
 alist.Add(SRpSFloat);
 alist.Add(SRpSCurrency);
 alist.Add(SRpSDate);
 alist.Add(SRpSDateTime);
 alist.Add(SRpSTime);
 alist.Add(SRpSBoolean);
 alist.Add(SrpSExpressionB);
 alist.Add(SrpSExpressionA);
 alist.Add(SRpSParamSubs);
 alist.Add(SRpSParamList);
 alist.Add(SRpSMultiple);
 alist.Add(SRpSParamSubsE);
 alist.Add(SRpSParamSubsList);
 alist.Add(SRpSParamInitialExpression);
end;

procedure GetPossibleDataTypesRuntime(alist:TRpWideStrings);
begin
 alist.Clear;
 alist.Add(SRpSUnknownType);
 alist.Add(SRpSString);
 alist.Add(SRpSInteger);
 alist.Add(SRpSFloat);
 alist.Add(SRpSCurrency);
 alist.Add(SRpSDate);
 alist.Add(SRpSDateTime);
 alist.Add(SRpSTime);
 alist.Add(SRpSBoolean);
end;

// Command line params are in form of:
// -paramPARAMNAME=paramvalueinstringformat
procedure ParseCommandLineParams(params:TRpParamList);
var
 i:integer;
 aparam:String;
 paramname:String;
 paramvalue:String;
 index:integer;
 param:TRpParam;
begin
 for i:=1 to ParamCount do
 begin
  aparam:=ParamStr(i);
  if Pos('-param',aparam)=1 then
  begin
   aparam:=copy(aparam,7,Length(aparam));
   index:=Pos('=',aparam);
   paramname:=copy(aparam,1,index-1);
   paramvalue:=copy(aparam,index+1,Length(aparam));
   param:=params.ParamByName(paramname);
   if param.ParamType=rpParamList then
   begin
    param.Value:=param.Values.Strings[StrToInt(paramvalue)];
   end
   else
    params.ParamByName(paramname).AsString:=paramvalue;
  end;
 end;
end;

function TRpParam.GetMultiValue:String;
var
 i,aindex:integer;
 astring:string;
begin
 Result:='';
 if ParamType<>rpParamMultiple then
  exit;
 for i:=0 to FSelected.Count-1 do
 begin
  astring:=FSelected.Strings[i];
  aindex:=StrToInt(astring);
  if FValues.Count>aindex then
  begin
   if Length(Result)>0 then
    Result:=Result+','+FValues.Strings[aindex]
   else
    Result:=Result+FValues.Strings[aindex]
  end;
 end;
end;

function TRpParam.GetValue:Variant;
begin
 if paramtype=rpParamMultiple then
  Result:=GetMultiValue
 else
  Result:=FValue;
end;

procedure TRpParamList.Assign(Source:TPersistent);
begin
 if Source is TRpParamList then
  Language:=TRpParamList(Source).Language;
 inherited Assign(Source);
end;

procedure TRpParamList.SetLanguage(ALang:integer);
begin
 if (ALang<0) then
  ALang:=0;
 FLanguage:=ALang;
end;

end.

