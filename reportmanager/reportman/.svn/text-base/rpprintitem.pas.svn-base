{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpprintitem                                     }
{       TRpPrintItem: Base class for printable comps    }
{       TRpGenTextItem: Base class for text items       }
{                                                       }
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

unit rpprintitem;

interface

{$I rpconf.inc}

uses Sysutils,Classes,rptypes,
 rpeval,
{$IFDEF MSWINDOWS}
 Windows,
{$ENDIF}
{$IFDEF USEVARIANTS}
 types,
{$ENDIF}
 rpmdconsts,rpmetafile;

// Maximum width or height of a element, that is 60 inch
const
 MAX_ELEMENT_WIDTH=86400;
 MAX_ELEMENT_HEIGHT=86400;

type


 TRpCommonComponent=class(TComponent)
  private
   FHeight:TRpTwips;
   FWidth:TRpTwips;
   FDoBeforePrint,FDoAfterPrint:widestring;
   FPrintCondition:widestring;
   FOnBeforePrint:TNotifyEvent;
   FVisible:Boolean;
   procedure SetWidth(Value:TRpTwips);
   procedure SetHeight(Value:TRpTwips);
   procedure WritePrintCondition(Writer:TWriter);
   procedure ReadPrintCondition(Reader:TReader);
   procedure WriteDoBeforePrint(Writer:TWriter);
   procedure ReadDoBeforePrint(Reader:TReader);
   procedure WriteDoAfterPrint(Writer:TWriter);
   procedure ReadDoAfterPrint(Reader:TReader);
  protected
   procedure DefineProperties(Filer:TFiler);override;
   function GetReport:TComponent;
   procedure DoPrint(adriver:TRpPrintDriver;
    aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);virtual;
  public
   lastextent:TPoint;
   oldowner:TComponent;
   PrintWidth,PrintHeight:Integer;
   constructor Create(AOwner:TComponent);override;
   function GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;virtual;
   function EvaluatePrintCondition:boolean;
   procedure Print(adriver:TRpPrintDriver;aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);
   procedure SubReportChanged(newstate:TRpReportChanged;newgroup:string='');virtual;
   property Report:TComponent read GetReport;
   property OnBeforePrint:TNotifyEvent read FOnBeforePrint write FOnBeforePrint;
   property Visible:Boolean read FVisible write FVisible;
   property PrintCondition:widestring read FPrintCondition write FPrintCondition;
   property DoBeforePrint:widestring read FDoBeforePrint write FDoBeforePrint;
   property DoAfterPrint:widestring read FDoAfterPrint write FDoAfterPrint;
  published
   property Width:TRpTwips read FWidth write SetWidth;
   property Height:TRpTwips read FHeight write SetHeight;
  end;

 TRpCommonPosComponent=class(TRpCommonComponent)
  private
   FPosY:TRpTwips;
   FPosX:TRpTwips;
   FAlign:TRpPosAlign;
  public
   PartialFlag:boolean;
   function GetParent:TRpCommonComponent;
  published
   property PosX:TRpTwips read FPosX write FPosX;
   property PosY:TRpTwips read FPosY write FPosY;
   property Align:TRpPosAlign read FAlign write FAlign
    default rpalnone;
  end;

 TRpCommonPosClass=class of TRpCommonPosComponent;

 TRpCommonListItem=class(TCollectionItem)
  private
   FComponent:TRpCommonComponent;
   procedure SetComponent(Value:TRpCommonComponent);
  public
   procedure Assign(Source:TPersistent);override;
  published
   property Component:TRpCommonComponent read FComponent write SetComponent;
 end;


 TRpCommonList=class(TCollection)
  private
   FSection:TComponent;
   function GetItem(Index:Integer):TRpCommonListItem;
   procedure SetItem(index:integer;Value:TRpCommonListItem);
  public
   function Add:TRpCommonListItem;
   function Insert(index:integer):TRpCommonListItem;
   function IndexOf(Value:TRpCommonComponent):integer;
   property Items[index:integer]:TRpCommonListItem read GetItem write SetItem;default;
   constructor Create(sec:TComponent);
 end;

 TRpGenTextComponent=class(TRpCommonPosComponent)
  private
   FWFontName:widestring;
   FLFontName:widestring;
   FFontSize:smallint;
   FFontRotation:smallint;
   FFontStyle:integer;
   FFontColor:integer;
   FBackColor:integer;
   FTransparent:Boolean;
   FCutText:Boolean;
   FWordWrap:Boolean;
   FWordBreak:Boolean;
   FInterLine:Integer;
   FAlignMent:integer;
   FVAlignMent:integer;
   FSingleLine:boolean;
   FType1Font:TRpType1Font;
   FBidiModes:TStrings;
   FMultiPage:Boolean;
   FPrintStep:TRpSelectFontStep;
   procedure ReadWFontName(Reader:TReader);
   procedure WriteWFontName(Writer:TWriter);
   procedure ReadLFontName(Reader:TReader);
   procedure WriteLFontName(Writer:TWriter);
   procedure SetBidiModes(Value:TStrings);
   function GetBidiMode:TRpBidiMode;
   procedure SetBidiMode(Value:TRpBidiMode);
   function GetRightToLeft:Boolean;
   function GetPrintAlignMent:integer;
  protected
   procedure DefineProperties(Filer:TFiler);override;
  public
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
   property WFontName:widestring read FWFontName write FWFontName;
   property LFontName:widestring read FLFontName write FLFontName;
   property BidiMode:TRpBidiMode read GetBidiMode write SetBidiMode;
   property RightToLeft:Boolean read GetRightToLeft;
   property PrintAlignMent:Integer read GetPrintAlignMent;
  published
   property Type1Font:TRpType1Font read FType1Font write FType1Font;
   property FontSize:smallint read FFontSize write FFontSize default 10;
   property FontRotation:smallint read FFontRotation write FFontRotation default 0;
   property FontStyle:integer read FFontStyle write FFontStyle default 0;
   property FontColor:integer read FFontColor write FFontColor default 0;
   property BackColor:integer read FBackColor write FBackColor default $FFFFFF;
   property Transparent:Boolean read FTransparent write FTransparent default true;
   property CutText:Boolean read FCutText write FCutText default false;
   property Alignment:integer read FAlignment write FAlignment default 0;
   property VAlignment:integer read FVAlignment write FVAlignment default 0;
   property WordWrap:Boolean read FWordWrap write FWordWrap default false;
   property WordBreak:Boolean read FWordBreak write FWordBreak default false;
   property InterLine:Integer read FInterLine write FInterLine default 0;
   property SingleLine:boolean read FSingleLine write FSingleLine default false;
   property BidiModes:TStrings read FBidiModes write SetBidiModes;
   property MultiPage:Boolean read FMultiPage write FMultiPage default false;
   property PrintStep:TRpSelectFontStep read FPrintStep write FPrintStep
    default rpselectsize;
  end;

implementation

uses rpbasereport,rpsection,rpsubreport;

const
 AlignmentFlags_AlignLeft = 1 { $1 };
 AlignmentFlags_AlignRight = 2 { $2 };



constructor TRpCommonComponent.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 // The owner must be a report
 if Assigned(AOwner) then
  if (Not (AOwner is TRpBaseReport)) then
   if (Not (AOwner is TRpSection)) then
    Raise Exception.Create(SRpOnlyAReportOwner+classname);

 FVisible:=True;
 FHeight:=0;
 FWidth:=0;
end;

procedure TRpCommonComponent.DefineProperties(Filer:TFiler);
begin
 inherited;

 Filer.DefineProperty('PrintCondition',ReadPrintCondition,WritePrintCondition,True);
 Filer.DefineProperty('DoBeforePrint',ReadDoBeforePrint,WriteDoBeforePrint,True);
 Filer.DefineProperty('DoAfterPrint',ReadDoAfterPrint,WriteDoAfterPrint,True);
end;

procedure TRpCommonComponent.WritePrintCondition(Writer:TWriter);
begin
 WriteWideString(Writer, FPrintCondition);
end;

procedure TRpCommonComponent.ReadPrintCondition(Reader:TReader);
begin
 FPrintCondition:=ReadWideString(Reader);
end;

procedure TRpCommonComponent.WriteDoBeforePrint(Writer:TWriter);
begin
 WriteWideString(Writer, FDoBeforePrint);
end;

procedure TRpCommonComponent.ReadDoBeforePrint(Reader:TReader);
begin
 FDoBeforePrint:=ReadWideString(Reader);
end;

procedure TRpCommonComponent.WriteDoAfterPrint(Writer:TWriter);
begin
 WriteWideString(Writer, FDoAfterPrint);
end;

procedure TRpCommonComponent.ReadDoAfterPrint(Reader:TReader);
begin
 FDoAfterPrint:=ReadWideString(Reader);
end;

procedure TRpCommonComponent.SetWidth(Value:TRpTwips);
begin
 if Value>MAX_ELEMENT_WIDTH then
  Value:=MAX_ELEMENT_WIDTH;
 if Value<0 then
  Value:=0;
 FWidth:=Value;
end;

procedure TRpCommonComponent.SetHeight(Value:TRpTwips);
begin
 if Value>MAX_ELEMENT_HEIGHT then
  Value:=MAX_ELEMENT_HEIGHT;
 if Value<0 then
  Value:=0;
 FHeight:=Value;
end;

function TRpCommonComponent.GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;
begin
 Result.X:=Width;
 Result.Y:=Height;
 LastExtent:=Result;
end;

function TRpCommonComponent.EvaluatePrintCondition:boolean;
var
 fevaluator:TRpEvaluator;
begin
 if Length(Trim(PrintCondition))<1 then
 begin
  Result:=true;
  exit;
 end;
 try
  fevaluator:=TRpBaseREport(GetReport).Evaluator;
  fevaluator.Expression:=PrintCondition;
  fevaluator.Evaluate;
  Result:=Boolean(fevaluator.EvalResult);
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSPrintCondition,self,SRpSPrintCondition);
  end;
 end;
end;


procedure TRpCommonComponent.DoPrint(adriver:TRpPrintDriver;aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);
begin
 // Executes OnBeforePrint
 if Assigned(FOnBeforePrint) then
 begin
  OnBeforePrint(Self);
 end;
 if newwidth>=0 then
  PrintWidth:=newwidth
 else
  PrintWidth:=Width;
 if newheight>=0 then
  PrintHeight:=newheight
 else
  PrintHeight:=Height;
 PartialPrint:=False;
end;


function TRpCommonPosComponent.GetParent:TRpCommonComponent;
var
 areport:TRpBaseReport;
 sec:TRpSection;
 subrep:TRpSubReport;
 i,j,k:integer;
begin
 Result:=nil;
 areport:=TRpBaseReport(GetReport);
 for i:=0 to areport.Subreports.Count-1 do
 begin
  subrep:=areport.Subreports.items[i].Subreport;
  for j:=0 to subrep.Sections.Count-1 do
  begin
   sec:=subrep.Sections.Items[j].Section;
   for k:=0 to sec.Components.Count-1 do
   begin
    if sec.Components.Items[k].Component=self then
    begin
     Result:=sec;
     break;
    end;
   end;
   if Assigned(Result) then
    break;
  end;
  if Assigned(Result) then
   break;
 end;
end;

procedure TRpCommonComponent.Print(adriver:TRpPrintDriver;
 aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);
var
 fevaluator:TRpEvaluator;
begin
 if Not EvaluatePrintCondition then
  exit;

 // Do Before print and doafter print
 if Length(FDoBeforePrint)>0 then
 begin
  try
   fevaluator:=TRpBaseREport(GetReport).Evaluator;
   fevaluator.Expression:=FDoBeforePrint;
   fevaluator.Evaluate;
  except
   on E:Exception do
   begin
    Raise TRpReportException.Create(E.Message+':'+SRpSBeforePrint+' '+Name,self,SRpSBeforePrint);
   end;
  end;
 end;

 DoPrint(adriver,aposx,aposy,newwidth,newheight,metafile,MaxExtent,PartialPrint);

 if Length(FDoAfterPrint)>0 then
 begin
  try
   fevaluator:=TRpBaseREport(GetReport).Evaluator;
   fevaluator.Expression:=FDoAfterPrint;
   fevaluator.Evaluate;
  except
   on E:Exception do
   begin
    Raise TRpReportException.Create(E.Message+':'+SRpSAfterPrint+' '+Name,self,SRpSAfterPrint);
   end;
  end;
 end;
end;

constructor TrpCOmmonList.Create(sec:TComponent);
begin
 inherited Create(TRpCommonListItem);
 FSection:=sec;
end;

procedure TRpCommonListItem.SetComponent(Value:TRpCommonComponent);
begin
 FComponent:=Value;
 Changed(False);
end;

function TRpCommonList.GetItem(Index:Integer):TRpCommonListItem;
begin
 Result:=TRpCommonListItem(inherited GetItem(index));
end;

procedure TRpCommonList.SetItem(index:integer;Value:TRpCommonListItem);
begin
 inherited SetItem(Index,Value);
end;


procedure TRpCommonListItem.Assign(Source:TPersistent);
begin
 if Source is TRpCommonListItem then
 begin
  FComponent:=TRpCommonListItem(Source).FComponent;
 end
 else
  inherited Assign(Source);
end;

function TRpCommonList.Add:TRpCommonListItem;
begin
 Result:=TRpCommonListItem(inherited Add);
end;

function TRpCommonList.Insert(index:integer):TRpCommonListItem;
begin
 Result:=TRpCommonListItem(inherited Insert(index));
end;


function TRpCommonList.IndexOf(Value:TRpCommonComponent):integer;
var
 i:integer;
begin
 Result:=-1;
 i:=0;
 While i<count do
 begin
  if items[i].FComponent=Value then
  begin
   Result:=i;
   break;
  end;
  inc(i);
 end;
end;

constructor TRpGenTextComponent.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FLFontName:='Helvetica';
 FWFontName:='Arial';
 FontSize:=10;
 FontRotation:=0;
 FontStyle:=0;
 FontColor:=0;
 FBackColor:=$FFFFFF;
 FTransparent:=true;
 FCutText:=false;
 FBidiModes:=TStringList.Create;
end;

destructor TRpGenTextComponent.Destroy;
begin
 FBidiModes.free;

 inherited Destroy;
end;

function TRpGenTextComponent.GetPrintAlignMent:integer;
begin
 // Inverse the alignment for BidiMode Full
 Result:=FAlignMent;
 if BidiMode=rpBidiFull then
 begin
  if (((FAlignMent AND AlignmentFlags_AlignLEFT)>0) or (FAlignMent=0)) then
   Result:=(Result AND (NOT (AlignmentFlags_AlignLEFT)) OR AlignmentFlags_AlignRight)
  else
   if (FAlignMent AND AlignmentFlags_AlignRight)>0 then
    Result:=(Result AND (NOT (AlignmentFlags_AlignRIGHT)) OR AlignmentFlags_AlignLEFT);
 end;
end;


function TRpGenTextComponent.GetRightToLeft:Boolean;
begin
 Result:=BidiMode<>rpBidiNo;
end;

function TRpGenTextComponent.GetBidiMode:TRpBidiMode;
var
 langindex:integer;
begin
 Result:=rpBidiNo;
 langindex:=TRpBaseReport(GetReport).Language+1;
 if langindex<0 then
  langindex:=0;
 if BidiModes.Count>langindex then
 begin
  if BidiModes.Strings[langindex]='BidiPartial' then
   Result:=rpBidiPartial
  else
   if BidiModes.Strings[langindex]='BidiFull' then
    Result:=rpBidiFull;
 end;
end;

procedure TRpGenTextComponent.SetBidiMode(Value:TRpBidiMode);
var
 langindex:integer;
begin
 langindex:=TRpBaseReport(GetReport).Language+1;
 if langindex<0 then
  langindex:=0;
 while (BidiModes.Count<=langindex) do
 begin
  BidiModes.Add('BidiNo');
 end;
 case Value of
  rpBidiNo:
   BidiModes.Strings[langindex]:='BidiNo';
  rpBidiPartial:
   BidiModes.Strings[langindex]:='BidiPartial';
  rpBidiFull:
   BidiModes.Strings[langindex]:='BidiFull';
 end;
end;

procedure TRpGenTextComponent.SetBidiModes(Value:TStrings);
begin
 FBidiModes.Assign(Value);
end;

function TRpCommonComponent.GetReport:TComponent;
begin
 Result:=nil;
 if (Owner is TRpBaseReport) then
 begin
  Result:=Owner;
  exit;
 end;
 if (Owner is TRpSection) then
 begin
  if (TRpSection(Owner).Owner is TRpBaseReport) then
  begin
   Result:=TRpSection(Owner).Owner;
   exit;
  end;
 end;
 if Assigned(Result) then
  Raise Exception.Create(SRpOnlyAReportOwner);
end;

procedure TRpCommonComponent.SubReportChanged(newstate:TRpReportChanged;newgroup:string='');
begin
 // Base class does nothing
end;




procedure TRpGenTextComponent.WriteWFontName(Writer:TWriter);
begin
 WriteWideString(Writer, FWFontName);
end;

procedure TRpGenTextComponent.WriteLFontName(Writer:TWriter);
begin
 WriteWideString(Writer, FLFontName);
end;



procedure TRpGenTextComponent.ReadLFontName(Reader:TReader);
begin
 FLFontName:=ReadWideString(Reader);
end;

procedure TRpGenTextComponent.ReadWFontName(Reader:TReader);
begin
 FWFontName:=ReadWideString(Reader);
end;

procedure TRpGenTextComponent.DefineProperties(Filer:TFiler);
begin
 inherited;

 Filer.DefineProperty('WFontName',ReadWFontName,WriteWFontName,True);
 Filer.DefineProperty('LFontName',ReadLFontName,WriteLFontName,True);
end;


end.
