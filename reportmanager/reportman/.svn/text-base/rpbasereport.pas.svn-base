{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       The report base component, it contains          }
{       subreports, pagesetup, printer selection...     }
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
// One report is composed of subreports, the report has
// page setup properties and a subreport list
// The subreports are printed in order and can have
// diferent datasources, grouping, sections etc

unit rpbasereport;

interface

{$I rpconf.inc}

uses Classes,sysutils,rptypes,rpsubreport,rpsection,rpmdconsts,
 rpdatainfo,rpparams,rpeval,rptypeval,rpprintitem,rpmdbarcode,
 rpmetafile,
{$IFDEF USEVARIANTS}
 types,dateutils,Variants,
{$ENDIF}
 rpalias,db,
{$IFDEF USEZLIB}
{$IFDEF DELPHI2009UP}
 zlib,
{$ENDIF}
{$IFNDEF DELPHI2009UP}
 rpmzlib,
{$ENDIF}
{$ENDIF}
{$IFDEF USERPDATASET}
 rpdataset,
{$ENDIF}
{$IFDEF LINUX}
  Libc,
{$ENDIF}
{$IFDEF MSWINDOWS}
  mmsystem,windows,
{$ENDIF}
 rpmunits;


const
 MILIS_PROGRESS_DEFAULT=500;
 // 1 cms=574
 // 0.5 cms=287
 CONS_DEFAULT_GRIDWIDTH=115;
 CONS_DEFAULT_GRIDCOLOR=$FF0000;
 CONS_MIN_GRID_WIDTH=10;
 // 29,7/2.54*1440
 DEFAULT_PAGEHEIGHT=16837;
 DEFAULT_PAGEWIDTH=11906;
 // default Margins
 // Left 1 cm, Right 1 cm, Top 1 cm Bottom 1.5 cm
 DEFAULT_LEFTMARGIN=574;
 DEFAULT_RIGHTMARGIN=574;
 DEFAULT_BOTTOMMARGIN=861;
 DEFAULT_TOPMARGIN=574;
 // Minimum grid

type
 TRpBaseReport=class;
 TRpSubReportListItem=class;
 TRpProgressEvent=procedure (Sender:TRpBaseReport;var docancel:boolean) of object;
 TRpSubReportList=class(TCollection)
  private
   FReport:TRpBaseReport;
   function GetItem(Index:Integer):TRpSubReportListItem;
   procedure SetItem(index:integer;Value:TRpSubReportListItem);
  public
   constructor Create(rp:TRpBaseReport);
   function Add:TRpSubReportListItem;
   function IndexOf(Value:TRpSubReport):integer;
   property Items[index:integer]:TRpSubReportListItem read GetItem write SetItem;default;
 end;
 TRpSubReportListItem=class(TCollectionItem)
  private
   FSubReport:TRpSubReport;
   procedure SetSubReport(Value:TRpSubReport);
  public
   procedure Assign(Source:TPersistent);override;
  published
   property SubReport:TRpSubReport read FSubReport write SetSubReport;
 end;

 TIdenReportVar=class(TIdenFunction)
  private
   FReport:TRpBaseReport;
  protected
   function GetRpValue:TRpValue;override;
  public
   varname:string;
  end;

 TIdenEOF=class(TIdenFunction)
  private
   FReport:TRpBaseReport;
  protected
   function GetRpValue:TRpValue;override;
  public
   constructor Create(AOwner:TComponent);override;
  end;

 TThreadExecReport=class;

 TRpBaseReport=class(TComponent)
  private
   FSubReports:TRpSubReportList;
   FPageOrientation:TRpOrientation;
   FPagesize:TRpPagesize;
   FPageSizeQt:integer;
   FPageWidth:TRpTwips;
   FPageHeight:TRpTwips;
   FCustomPageWidth:TRpTwips;
   FCustomPageHeight:TRpTwips;
   FPageBackColor:TRpColor;
   FPreviewStyle:TRpPreviewStyle;
   FPreviewWindow:TRpPreviewWindowStyle;
   FPreviewMargins:Boolean;
   FOnReadError:TReaderError;
   FDataInfo:TRpDataInfoList;
   FDatabaseInfo:TRpDatabaseInfoList;
   FParams:TRpParamList;
   FGridVisible:Boolean;
   FGridEnabled:Boolean;
   FGridColor:integer;
   FGridLines:Boolean;
   FGridWidth:integer;
   FGridHeight:integer;
   FLanguage:integer;
   FMetafile:TRpMetafileReport;
   FOnProgress:TRpProgressEvent;
   FLeftMargin,FTopMargin,FRightMargin,FBottomMargin:TRpTwips;
   FCopies:integer;
   FCollateCopies:boolean;
   FTwoPass:boolean;
   FMilisProgres:integer;
   FPrinterFonts:TRpPrinterFontsOption;
   difmilis:int64;
   FPrinterSelect:TRpPrinterSelect;
   FPrintOnlyIfDataAvailable:Boolean;
   FStreamFormat:TRpStreamFormat;
   FReportAction:TRpReportActions;
   FPreviewAbout:Boolean;
   // Default font properties
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
   FAlignMent:integer;
   FVAlignMent:integer;
   FSingleLine:boolean;
   FType1Font:TRpType1Font;
   FBidiModes:TStrings;
   FMultiPage:Boolean;
   FPrintStep:TRpSelectFontStep;
   FPaperSource:Integer;
   FDuplex:Integer;
   FForcePaperName:String;
   FLinesPerInch:Word;
   fintpageindex:integer;
   FOnWorkAsyncError:TWorkAsyncError;
   FOnWorkProgress:TMetaFileWorkProgress;
   procedure FInternalOnReadError(Reader: TReader; const Message: string;
    var Handled: Boolean);
   procedure SetSubReports(Value:TRpSubReportList);
   procedure SetDataInfo(Value:TRpDataInfoList);
   procedure SetDatabaseInfo(Value:TRpDatabaseInfoList);
   procedure SetParams(Value:TRpParamList);
   procedure SetGridWidth(Value:TRpTwips);
   procedure SetGridHeight(Value:TRpTwips);
   procedure ReadWFontName(Reader:TReader);
   procedure WriteWFontName(Writer:TWriter);
   procedure ReadLFontName(Reader:TReader);
   procedure WriteLFontName(Writer:TWriter);
   procedure SetBidiModes(Value:TStrings);
   function Newlanguage(alanguage:integer):integer;
   procedure StopWork;
  protected
    oldprintedsectionext:TPoint;
    oldprintedsection:TRpSection;
    printingonepass:boolean;
    AbortingThread:Boolean;
    FThreadExec:TThreadExecReport;
    FExecuting:Boolean;
    FUpdatePageSize:Boolean;
    currentorientation:TRpOrientation;
    lasterrorprocessing:WideString;
    FTotalPagesList:TList;
    FEvaluator:TRpEvaluator;
    FIdentifiers:TStringList;
    FAliasList:TRpAlias;
    FCompose:Boolean;
    FPendingSections:TStringList;
    section:TRpSection;
    subreport:TRpSubreport;
    FRecordCount:integer;
    FDriver:TRpPrintDriver;
    // Identifiers
    Fidenpagenum:TIdenReportVar;
    Fidenlanguage:TIdenReportVar;
    Fidenpagenumgroup:TIdenReportVar;
    FidenEof:TIdenEof;
    Fidenfreespace:TIdenReportVar;
    Fidenpagewidth:TIdenReportVar;
    Fidenpageheight:TIdenReportVar;
    Fidenfreespacecms:TIdenReportVar;
    Fidenfreespaceinch:TIdenReportVar;
    Fidencurrentgroup:TIdenReportVar;
    FIdenfirstsection:TIdenReportVar;
    // Other
    FInternalPageWidth:TRpTwips;
    FInternalPageHeight:TRpTwips;
    FDataAlias:TRpAlias;
    pageposy,pageposx:integer;
    freespace:integer;
    printedsomething:Boolean;
    gheaders,gfooters:TList;
    FGroupHeaders:TStringList;
{$IFDEF MSWINDOWS}
   mmfirst,mmlast:DWORD;
{$ENDIF}
{$IFDEF LINUX}
   milifirst,mililast:TDatetime;
{$ENDIF}
    rPageSizeQt:TPageSizeQt;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent);override;
    procedure UpdateCachedSources(alias:string);
    procedure CheckProgress(finished:Boolean);
    procedure  FillGlobalHeaders;
    procedure ClearTotalPagesList;
    function OnGraphicOp(Top,Left,Width,Height:integer;
     DrawStyle:integer;BrushStyle:integer;BrushColor:integer;
     PenStyle:integer;PenWidth:integer; PenColor:integer):Boolean;
    function OnPageOp(indexqt:integer;custom:Boolean;
     customwidth,customheight,papersource:integer;
     ForcePaperName:String;duplex:integer):Boolean;
    function OnOrienationOp(orientation:integer):Boolean;
    function OnImageOp(Top,Left,Width,Height:integer;
     DrawStyle,DPIRes:integer;PreviewOnly:Boolean;Image:WideString):Boolean;
    function OnBarcodeOp (Top,Left,Width,Height:integer;
     Expression,DisplayFormat:WideString;BarType,Modul:Integer;Ratio,Rotation:Currency;
     CalcChecksum:Boolean;BrushColor:Integer):Boolean;
    function OnTextOp(Top,Left,Width,Height:integer;
     Text,LFontName,WFontName:WideString;
     FontSize,FontRotation,FontStyle,FontColor,Type1Font:integer;
     CutText:boolean;Alignment:integer;WordWrap,RightToLeft:Boolean;
     PrintStep,BackColor:integer;transparent:boolean):Boolean;
    function OnTextheight(Text,LFontName,WFontName:WideString;
     RectWidth,FontSize,FontStyle,Type1Font:integer;
     PrintStep:integer):integer;
    function ReOpenOp(datasetname:String;sql:Widestring):BOolean;
    function OnParamInfo(ParamName:String;index:integer):String;
    procedure CheckIfDataAvailable;
    procedure UpdateParamsBeforeOpen(index:integer;doeval:boolean);
    procedure DefineProperties(Filer:TFiler);override;
    procedure  DoPrintInternal;
    property OnWorkProgress:TMetaFileWorkProgress read FOnWorkProgress write
     FOnWorkProgress;
  public
   Errorprocessing:Boolean;
   FailIfLoadExternalError:Boolean;
   printing:boolean;
   CurrentSubReportIndex:integer;
   CurrentSectionIndex:integer;
   PageNum:integer;
   PageNumGroup:integer;
   LastPage:Boolean;
   ProgressToStdOut:Boolean;
   AdoNetDriver:integer;
   AsyncExecution:boolean;
   maximum_width:integer;
   maximum_height:integer;
   procedure LoadExternals;virtual;
   procedure AddReportItemsToEvaluator(eval:TRpEvaluator);
   procedure InitEvaluator;
   procedure BeginPrint(Driver:TRpPrintDriver);virtual;abstract;
   procedure EndPrint;virtual;abstract;
   function PrintNextPage:boolean;virtual;abstract;
   procedure PrintAll(Driver:TRpPrintDriver);
   property RecordCount:integer read FRecordCount;
   property Metafile:TRpMetafileReport read FMetafile;
   property Identifiers:TStringList read FIdentifiers;
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
   procedure FreeSubreports;
   function AddSubReport:TRpSubReport;
   procedure DeleteSubReport(subr:TRpSubReport);
   // Streaming functions and properties
   procedure SaveToStream(Stream:TStream);
   procedure SaveToFile(Filename:string);
   procedure LoadFromStream(Stream:TStream);
   procedure LoadFromFile(FileName:string);
   property OnReadError:TReaderError read FOnReadError write FOnReadError;
   // Design functions
   procedure Createnew;
   // Print functions
   procedure ActivateDatasets;
   procedure DeActivateDatasets;
   procedure AddTotalPagesItem(apageindex,aobjectindex:integer;
    adisplayformat:widestring);
   function IsDotNet:boolean;
   property OnWorkAsyncError:TWorkAsyncError read FOnWorkAsyncError write FOnWorkAsyncError;
   property Evaluator:TRpEvaluator read FEvaluator;
   procedure Compose(PrevReport:TRpBaseReport;execute:Boolean;ADriver:TRpPrintDriver);
   property OnProgress:TRpProgressEvent read FOnProgress write FOnProgress;
   property AliasList:TRpAlias read FAliasList write FAliasList;
   property idenpagenum:TIdenReportVar read fidenpagenum;
   property idenlanguage:TIdenReportVar read fidenlanguage;
   property ideneof:TIdenEof read fideneof;
   property idenfreespace:TIdenReportVar read fidenfreespace;
   property idenfreespacecms:TIdenReportVar read fidenfreespacecms;
   property idenfreespaceinch:TIdenReportVar read fidenfreespaceinch;
   property idencurrentgroup:TIdenReportVar read fidencurrentgroup;
   property MilisProgres:integer read FMilisProgres write FMilisProgres
    default MILIS_PROGRESS_DEFAULT;
   procedure AlignSectionsTo(linesperinch:integer);
   procedure SetLanguage(index:integer);
   procedure PrepareParamsBeforeOpen;
   procedure AssignDefaultFontTo(aitem:TRpGenTextComponent);
   procedure GetDefaultFontFrom(aitem:TRpGenTextComponent);
   function GetSQLValue(connectionname,sql:String):Variant;
   function RequestPage(pageindex:integer):boolean;
   function CheckParameters(paramlist:TRpParamList;var paramname,amessage:string):Boolean;
   // Default Font properties
   property WFontName:widestring read FWFontName write FWFontName;
   property LFontName:widestring read FLFontName write FLFontName;
  published
   property GridVisible:Boolean read FGridVisible write FGridVisible default true;
   property GridLines:Boolean read FGridLines write FGridLines default false;
   property GridEnabled:Boolean read FGridEnabled write FGridEnabled default true;
   property GridColor:integer read FGridColor write FGridColor default CONS_DEFAULT_GRIDCOLOR;
   property GridWidth:TRpTwips read FGridWidth write SetGridWidth default CONS_DEFAULT_GRIDWIDTH;
   property GridHeight:TRpTwips read FGridHeight write SetGridHeight default CONS_DEFAULT_GRIDWIDTH;
   // PageSetup properties
   property PageOrientation:TRpOrientation read FPageOrientation
    write FPageOrientation default rpOrientationDefault;
   property Pagesize:TRpPageSize read FPagesize write FPageSize
     default rpPageSizeDefault;
   property PagesizeQt:integer read FPagesizeQt write FPageSizeQt
     default 0;
   property PageHeight:TRpTwips read FPageHeight write FPageHeight
    default DEFAULT_PAGEHEIGHT;
   property PageWidth:TRpTwips read FPageWidth write FPageWidth
    default DEFAULT_PAGEWIDTH;
   property CustomPageHeight:TRpTwips read FCustomPageHeight write FCustomPageHeight
    default DEFAULT_PAGEHEIGHT;
   property CustomPageWidth:TRpTwips read FCustomPageWidth write FCustomPageWidth
    default DEFAULT_PAGEWIDTH;
   property PageBackColor:TRpColor read FPageBackColor write FPageBackColor;
   property PreviewStyle:TRpPreviewStyle read FPreviewStyle
    write FPreviewStyle default spWide;
   property PreviewMargins:Boolean read FPreviewMargins
    write FPreviewMargins default false;
   property PreviewWindow:TRpPreviewWindowStyle read FPreviewWindow
    write FPreviewWindow default spwNormal;
   property LeftMargin:TRpTwips read FLeftMargin write FLeftMargin
    default DEFAULT_LEFTMARGIN;
   property TopMargin:TRpTwips read FTopMargin write FTopMargin
    default DEFAULT_TOPMARGIN;
   property RightMargin:TRpTwips read FRightMargin write FRightMargin
    default DEFAULT_RIGHTMARGIN;
   property BottomMargin:TRpTwips read FBottomMargin write FBottomMargin
    default DEFAULT_BOTTOMMARGIN;
   property PrinterSelect:TRpPrinterSelect read FPrinterSelect write FPrinterSelect
    default pRpDefaultPrinter;
   // Subreports
   property SubReports:TRpSubReportList read FSubReports write SetSubReports;
   property DataInfo:TRpDataInfoList read FDataInfo write SetDataInfo;
   property DatabaseInfo:TRpDatabaseInfoList read FDatabaseInfo write SetDatabaseInfo;
   property Params:TRpParamList read FParams write SetParams;
   // Language
   property Language:integer read FLanguage write SetLanguage default -1;
   // Other
   property Copies:integer read FCopies write FCopies default 1;
   property CollateCopies:boolean read FCollateCopies write FCollateCopies default false;
   property TwoPass:boolean read FTwoPass write FTwoPass default false;
   property PrinterFonts:TRpPrinterFontsOption read FPrinterFonts
    write FPrinterFonts default rppfontsdefault;
   property PrintOnlyIfDataAvailable:Boolean read FPrintOnlyIfDataAvailable
    write FPrintOnlyIfDataAvailable default false;
   property StreamFormat:TRpStreamFormat read FStreamFormat
    write FStreamFormat;
   property ReportAction:TRpReportActions read FReportAction write FReportAction;
   property PreviewAbout:Boolean read FPreviewAbout write FPreviewAbout
    default true;
   // Default font props
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
   property SingleLine:boolean read FSingleLine write FSingleLine default false;
   property BidiModes:TStrings read FBidiModes write SetBidiModes;
   property MultiPage:Boolean read FMultiPage write FMultiPage default false;
   property PrintStep:TRpSelectFontStep read FPrintStep write FPrintStep
    default rpselectsize;
   // Paper source
   property PaperSource:Integer read FPaperSource write FPaperSource default 0;
   property Duplex:Integer read FDuplex write FDuplex default 0;
   property ForcePaperName:String read FForcePaperName write FForcePaperName;
   // Interline
   property LinesPerInch:Word read FLinesPerInch write FLinesPerInch default 600;
 end;

 TThreadExecReport=class(TThread)
  public
   report:TRpBaseReport;
   docancel:boolean;
   procedure Execute;override;
   procedure DoProgress;
  end;

implementation

uses rpxmlstream,rplabelitem,rpmdchart;

function TIdenReportVar.GeTRpValue:TRpValue;
var
 subrep:TRpSubReport;
begin
 Result:=Null;
 if ((varname='PAGE') or (varname='PAGINA')) then
  Result:=freport.PageNum+1
 else
  if ((varname='PAGENUM') or (varname='NUMPAGINA')) then
   Result:=freport.PageNumGroup+1
  else
  if varname='FREE_SPACE_TWIPS' then
   Result:=freport.freespace
  else
   if varname='FREE_SPACE_CMS' then
    Result:=twipstocms(freport.freespace)
   else
    if varname='FREE_SPACE_INCH' then
     Result:=twipstoinchess(freport.freespace)
    else
     if varname='CURRENTGROUP' then
     begin
      if freport.CurrentSubreportIndex>=freport.Subreports.Count then
       subrep:=freport.Subreports.Items[freport.CurrentSubreportIndex-1].SubReport
      else
        subrep:=freport.Subreports.Items[freport.CurrentSubreportIndex].SubReport;
      if subrep.LastRecord then
       Result:=subrep.GroupCount
      else
       Result:=subrep.CurrentGroupIndex;
     end
     else
     if varname='FIRSTSECTION' then
     begin
      Result:=not freport.printedsomething;
     end
     else
     if varname='PAGEWIDTH' then
     begin
      Result:=freport.FInternalPageWidth;
     end
     else
     if varname='PAGEHEIGHT' then
     begin
      Result:=freport.FInternalPageHeight;
     end
     else
     if varname='LANGUAGE' then
     begin
      Result:=freport.FLanguage;
     end;
end;

// Constructors and destructors
constructor TRpBaseReport.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FLinesPerInch:=600;
 FPaperSource:=0;
 FDuplex:=0;
 FPreviewMargins:=false;
 FGroupHeaders:=TStringList.Create;
 FPreviewAbout:=true;
 FStreamFormat:=rpStreamtext;
 gheaders:=TList.Create;
 gfooters:=TList.Create;
 FailIfLoadExternalError:=True;
 FMilisProgres:=MILIS_PROGRESS_DEFAULT;
 FLanguage:=-1;
 FCopies:=1;
 FPageOrientation:=rpOrientationDefault;
 // Means default pagesize
 FPagesize:=rpPageSizeDefault;
 FLeftMargin:=DEFAULT_LEFTMARGIN;
 FRightMargin:=DEFAULT_RIGHTMARGIN;
 FBottomMargin:=DEFAULT_BOTTOMMARGIN;
 FTopMargin:=DEFAULT_TOPMARGIN;
  // Means white
 FPageBackColor:=$FFFFFF;

 FPageWidth:=DEFAULT_PAGEWIDTH;
 FPageheight:=DEFAULT_PAGEHEIGHT;
 FCustomPageWidth:=DEFAULT_PAGEWIDTH;
 FCustomPageheight:=DEFAULT_PAGEHEIGHT;
 FPreviewStyle:=spWide;
 // Def values of grid
 FGridVisible:=True;
 FGridEnabled:=True;
 FGridColor:=CONS_DEFAULT_GRIDCOLOR;
 FGridLines:=False;
 FGridWidth:=CONS_DEFAULT_GRIDWIDTH;
 FGridHeight:=CONS_DEFAULT_GRIDWIDTH;
 FPendingSections:=TStringList.Create;
 // Subreports
 FSubReports:=TRpSubReportList.Create(Self);
 // Data Info
 FDataInfo:=TRpDataInfoList.Create(Self);
 FDatabaseInfo:=TRpDatabaseInfoList.Create(Self);
 FParams:=TRpParamList.Create(Self);
 // Identifiers
 FIdentifiers:=TStringList.Create;
 FIdentifiers.Sorted:=true;
 FIdentifiers.Duplicates:=dupError;
 // Pagenum
 FIdenPagenum:=TIdenReportVar.Create(nil);
 Fidenpagenum.FReport:=self;
 FidenPagenum.varname:='PAGE';
 FIdenLanguage:=TIdenReportVar.Create(nil);
 FIdenLanguage.FReport:=self;
 FIdenLanguage.varname:='LANGUAGE';
 FIdenPagenumgroup:=TIdenReportVar.Create(nil);
 Fidenpagenumgroup.FReport:=self;
 FidenPagenumgroup.varname:='PAGENUM';
 FIdenfreespace:=TIdenReportVar.Create(nil);
 Fidenfreespace.varname:='FREE_SPACE_TWIPS';
 Fidenfreespace.FReport:=self;
 FIdenpagewidth:=TIdenReportVar.Create(nil);
 Fidenpagewidth.varname:='PAGEWIDTH';
 Fidenpagewidth.FReport:=self;
 FIdenpageheight:=TIdenReportVar.Create(nil);
 Fidenpageheight.varname:='PAGEHEIGHT';
 Fidenpageheight.FReport:=self;
 FIdenfreespacecms:=TIdenReportVar.Create(nil);
 Fidenfreespacecms.varname:='FREE_SPACE_CMS';
 Fidenfreespacecms.FReport:=self;
 FIdenfreespaceinch:=TIdenReportVar.Create(nil);
 Fidenfreespaceinch.varname:='FREE_SPACE_INCH';
 Fidenfreespaceinch.FReport:=self;
 FIdencurrentgroup:=TIdenReportVar.Create(nil);
 Fidencurrentgroup.varname:='CURRENTGROUP';
 Fidencurrentgroup.FReport:=self;
 FIdenfirstsection:=TIdenReportVar.Create(nil);
 Fidenfirstsection.varname:='FIRSTSECTION';
 FidenFirstSection.FReport:=self;
 FIdeneof:=TIdenEOF.Create(nil);
 Fideneof.FReport:=self;
 // Metafile
 FMetafile:=TRpMetafileReport.Create(nil);
 metafile.OnRequestPage:=RequestPage;
 FOnWorkProgress:=metafile.WorkProgress;
 OnWorkAsyncError:=metafile.WorkAsyncError;
 metafile.OnStopWork:=StopWork;

 FDataAlias:=TRpAlias.Create(nil);
 FTotalPagesList:=TList.Create;
 // Other
 FPrinterFonts:=rppfontsdefault;
 FReportAction:=[];
 // Default font
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

 //
 InitEvaluator;
end;

procedure  TRpBaseReport.FillGlobalHeaders;
var
 subrep:TRpSubReport;
 i,j:integer;
 k:integer;
begin
 gheaders.clear;
 gfooters.clear;
 for i:=0 to Subreports.Count-1 do
 begin
  subrep:=SubReports.Items[i].SubReport;
  j:=subrep.FirstPageHeader;
  for k:=0 to subrep.PageHeaderCount-1 do
  begin
   if subrep.Sections[j+k].Section.Global then
    gheaders.Add(subrep.Sections[j+k].Section);
  end;
  j:=subrep.FirstPageFooter;
  for k:=0 to subrep.PageFooterCount-1 do
  begin
   if subrep.Sections[j+k].Section.Global then
    gfooters.Add(subrep.Sections[j+k].Section);
  end;
 end;
end;


procedure TRpBaseReport.SetGridWidth(Value:TRpTwips);
begin
 if Value<CONS_MIN_GRID_WIDTH then
  Value:=CONS_MIN_GRID_WIDTH;
 FGridWidth:=Value;
end;

procedure TRpBaseReport.SetGridHeight(Value:TRpTwips);
begin
 if Value<CONS_MIN_GRID_WIDTH then
  Value:=CONS_MIN_GRID_WIDTH;
 FGridHeight:=Value;
end;


procedure TRpBaseReport.AddTotalPagesItem(apageindex,aobjectindex:integer;
 adisplayformat:widestring);
var
 aobject:TTotalPagesObject;
begin
 aobject:=TTotalPagesObject.Create;
 FTotalPagesList.Add(aobject);
 aobject.PageIndex:=apageindex;
 aobject.ObjectIndex:=aobjectindex;
 aobject.DisplayFormat:=adisplayformat;
end;


procedure TRpBaseReport.ClearTotalPagesList;
var
 i:integer;
begin
 for i:=0 to FTotalPagesList.Count-1 do
 begin
  TObject(FTotalPagesList.Items[i]).Free;
 end;
 FTotalPagesList.Clear;
end;


destructor TRpBaseReport.Destroy;
begin
 if (FExecuting) then
 begin
  AbortingThread:=false;
{$IFDEF MSWINDOWS}
   WaitForSingleObject(FThreadExec.Handle,INFINITE);
{$ENDIF}
{$IFDEF LINUX}
   FThreadExec.WaitFor;
{$ENDIF}
 end;
 FGroupHeaders.free;
 gheaders.free;
 gfooters.free;
 FPendingSections.Free;
 FSubReports.free;
 FDataInfo.free;
 FDatabaseInfo.free;
 FParams.free;
 FIdentifiers.free;
 FMetafile.Free;
 FDataAlias.Free;
 FIdenPagenum.free;
 FIdenPagenumgroup.free;
 Fidenfreespace.free;
 FIdenPagewidth.free;
 FIdenPageHeight.free;
 FIdenCurrentGroup.free;
 FIdenFirstSection.free;
 Fidenfreespacecms.free;
 FBidiModes.free;
 Fidenfreespaceinch.free;
 FIdenLanguage.free;
 FIdenEof.free;
 ClearTotalPagesList;
 FTotalPagesList.free;
 if Assigned(FEvaluator) then
 begin
  FEvaluator.free;
  FEvaluator:=nil;
 end;
 inherited destroy;
end;


// Streaming procedures

// GetChildren helps streaming the subreports
procedure TRpBaseReport.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  OwnedComponent: TComponent;
//  rpsubreport:TRpSubReport;
begin
 inherited GetChildren(Proc, Root);
 if Root = Self then
  for I := 0 to ComponentCount - 1 do
  begin
   OwnedComponent := Components[I];
   if not OwnedComponent.HasParent then
    Proc(OwnedComponent);
//   if OwnedComponent is TRpSubReport then
//   begin
//    if subreport.
//      Proc(OwnedComponent);
//   end;
  end;
end;


procedure TRpBaseReport.SaveToStream(Stream:TStream);
var
{$IFDEF USEZLIB}
 zstream:TCompressionStream;
{$ENDIF}
 theformat:TRpStreamFormat;
 memstream:TMemoryStream;
 forcexml:boolean;
 i:integer;
begin
 // restore parameters initial values
 Params.RestoreInitialValues;
 theformat:=FStreamFormat;
 forcexml:=false;
 for i:=0 to DatabaseInfo.Count-1 do
 begin
  if DatabaseInfo.Items[i].Driver in [rpdatadriver,rpdotnet2driver] then
  begin
   forcexml:=true;
   break;
  end;
 end;
 if (forcexml) then
  if ((theformat<>rpStreamXML) AND (theformat<>rpStreamXMLZLib)) then
   theformat:=rpStreamXML;

 if (Subreports.Count<1) then
 begin
  AddSubReport;
 end;
{$IFNDEF USEZLIB}
 if theformat=rpStreamZLib then
  theformat:=rpStreambinary;
{$ENDIF}
{$IFDEF USEZLIB}
 if theformat=rpStreamZLib then
 begin
  zstream:=TCompressionStream.Create(clDefault,Stream);
  try
    zstream.WriteComponent(Self);
  finally
   zstream.free;
  end;
 end
 else
 if theformat=rpStreamXMLZLib then
 begin
  zstream:=TCompressionStream.Create(clDefault,Stream);
  try
    memstream:=TMemorystream.Create;
    try
     WriteReportXML(Self,memstream);
     memstream.Seek(0,soFromBeginning);
     zstream.CopyFrom(memstream,memstream.size);
    finally
     memstream.free;
    end;
  finally
   zstream.free;
  end;
 end
 else
{$ENDIF}
 if theformat=rpStreamBinary then
 begin
  Stream.WriteComponent(Self);
 end
 else
 if theformat=rpStreamXML then
 begin
  WriteReportXML(Self,Stream);
 end
 else
 begin
  memstream:=TMemoryStream.Create;
  try
   memstream.WriteComponent(Self);
   memstream.Seek(0,soFromBeginning);
   ObjectBinaryToText(memstream,Stream);
  finally
   memstream.free;
  end;
 end;
end;

procedure TRpBaseReport.FreeSubreports;
var
 i:integer;
begin
 // If it's destroying left do the work
 if (csDestroying in ComponentState) then
  exit;
 // Frees all the reports
 for i:=0 to FSubreports.Count-1 do
 begin
  FSubReports.Items[i].FSubReport.Free;
 end;
 FSubReports.Clear;
end;


function TRpBaseReport.AddSubReport:TRpSubReport;
var
 it:TRpSubReportListItem;
begin
 it:=SubReports.Add;
 it.FSubReport:=TRpSubreport.Create(Self);
 Generatenewname(it.FSubReport);
 it.FSubReport.CreateNew;
 Result:=it.FSubReport;
end;

procedure TRpBaseReport.CreateNew;
begin
 // Creates a new default report
 FreeSubreports;
 AddSubReport;
end;

procedure TRpBaseReport.SaveToFile(Filename:string);
var
 fstream:TFileStream;
begin
 fstream:=TFileStream.Create(Filename,fmCreate);
 try
  SaveToStream(fstream);
 finally
  fstream.free;
 end;
end;


procedure TRpBaseReport.LoadFromFile(FileName:string);
var
 stream:TFileStream;
begin
 stream:=TFileStream.Create(Filename,fmOpenRead or fmShareDenyWrite);
 try
  LoadFromStream(stream);
 finally
  stream.free;
 end;
end;


procedure TRpBaseReport.LoadFromStream(Stream:TStream);
var
 reader:TReader;
 memstream,amemstream:TMemoryStream;
 readed:integer;
 buf:array of Byte;
{$IFDEF USEZLIB}
 zlibs:TDeCompressionStream;
{$ENDIF}
 theformat:TRpStreamFormat;
 firstchar:char;
 first:boolean;
begin
 // FreeSubrepots
 FreeSubreports;
 MemStream:=TMemoryStream.Create;
 try
  firstchar:=chr(0);
  first:=false;
  // Copy to memory stream
  SetLength(buf,120000);
  repeat
 {$IFDEF DOTNETD}
   readed:=Stream.Read(buf,120000);
   memstream.Write(buf,readed);
 {$ENDIF}
 {$IFNDEF DOTNETD}
   readed:=Stream.Read(buf[0],120000);
   memstream.Write(buf[0],readed);
 {$ENDIF}
   if ((readed>0) and (not first)) then
   begin
    first:=true;
    firstchar:=char(buf[0]);
   end;
  until readed<120000;
  memstream.Seek(0,soFrombeginning);
  // Looks stream type
  if (memstream.size<1) then
   Raise Exception.Create(SRpStreamFormat);
  if firstchar='x' then
   theformat:=rpStreamzlib
  else
   if firstchar='o' then
    theformat:=rpStreamText
   else
    if firstchar='<' then
     theformat:=rpStreamXML
    else
     theformat:=rpStreambinary;
{$IFNDEF USEZLIB}
  if theformat=rpStreamzlib then
   Raise Exception.Create(SRpZLibNotSupported);
{$ENDIF}
{$IFDEF USEZLIB}
  if theformat=rpStreamzlib then
  begin
   amemstream:=TMemoryStream.Create;
   try
    zlibs:=TDeCompressionStream.Create(MemStream);
    try
     // Decompress
     repeat
      readed:=zlibs.Read(buf[0],120000);
      amemstream.Write(buf[0],readed);
     until readed<120000;
     amemstream.Seek(0,soFromBeginning);
     // Check if is xml
     if PAnsiChar(amemstream.memory)^='<' then
     begin
      ReadReportXML(self,amemstream);
     end
     else
     begin
      reader:=TReader.Create(amemstream,1000);
      try
       reader.OnError:=FInternalOnReadError;
       reader.ReadRootComponent(Self);
      finally
       reader.free;
      end;
     end;
    finally
     zlibs.Free;
    end;
   finally
    amemstream.free;
   end;
  end
  else
{$ENDIF}
  if theformat=rpStreambinary then
  begin
   reader:=TReader.Create(memstream,1000);
   try
    reader.OnError:=FInternalOnReadError;
    reader.ReadRootComponent(Self);
   finally
    reader.free;
   end;
  end
  else
  if theformat=rpStreamXML then
  begin
   ReadReportXML(self,memstream);
  end
  else
  begin
   amemstream:=TMemoryStream.Create;
   try
    ObjectTextToBinary(memstream,amemstream);
    amemstream.Seek(0,soFromBeginning);
    reader:=TReader.Create(amemstream,1000);
    try
     reader.OnError:=FInternalOnReadError;
     reader.ReadRootComponent(Self);
    finally
     reader.free;
    end;
   finally
    amemstream.free;
   end;
  end;
 finally
  MemStream.free;
 end;
end;

procedure TRpBaseReport.FInternalOnReadError(Reader: TReader; const Message: string;
    var Handled: Boolean);
begin
 Handled:=false;
// if Pos('AllText',Message)>0 then
//  Handled:=True;
 if Assigned(FOnReadError) then
  reader.OnError:=FOnReadError
end;

procedure TRpBaseReport.SetSubReports(Value:TRpSubReportList);
begin
 FSubReports.Assign(Value);
end;

procedure TRpBaseReport.SetDataInfo(Value:TRpDataInfoList);
begin
 FDataInfo.Assign(Value);
end;

procedure TRpBaseReport.SetDatabaseInfo(Value:TRpDatabaseInfoList);
begin
 FDatabaseInfo.Assign(Value);
end;

// Report collections

constructor TRpSubReportList.Create(rp:TRpBaseReport);
begin
 inherited Create(TRpSubReportListItem);
 FReport:=rp;
end;

procedure TRpSubReportListItem.SetSubReport(Value:TRpSubReport);
begin
 FSubReport:=Value;
 Changed(False);
end;

procedure TRpSubReportListItem.Assign(Source:TPersistent);
begin
 if Source is TRpSubReportListItem then
 begin
  FSubReport:=TRpSubReportListItem(Source).FSubReport;
 end
 else
  inherited Assign(Source);
end;


function TRpSubReportList.Add:TRpSubReportListItem;
begin
 Result:=TRpSubReportListItem(inherited Add);
end;

function TRpSubReportList.IndexOf(Value:TRpSubReport):integer;
var
 i:integer;
begin
 Result:=-1;
 i:=0;
 While i<count do
 begin
  if items[i].FSubReport=vALUE then
  begin
   Result:=i;
   break;
  end;
  inc(i);
 end;
end;

function TRpSubReportList.GetItem(Index:Integer):TRpSubReportListItem;
begin
 Result:=TRpSubReportListItem(inherited GetItem(index));
end;

procedure TRpSubReportList.SetItem(index:integer;Value:TRpSubReportListItem);
begin
 inherited SetItem(Index,Value);
end;

procedure TRpBaseReport.DeleteSubReport(subr:TRpSubReport);
var
 i:integer;
begin
 if FSubReports.Count<2 then
  Raise Exception.Create(SRpAtLeastOneSubreport);
 i:=0;
 while (FSubReports.Items[i].FSubReport<>subr) do
 begin
  inc(i);
  if (i>FSubReports.count-1) then
   Raise Exception.Create(SRpSubReportNotFound);
 end;
 FSubReports.Items[i].FSubReport.FreeSections;
 FSubReports.Items[i].FSubReport.Free;
// FSubReports.Delete(i);
 FSubReports.Items[i].Free;
end;

procedure TRpBaseReport.SetParams(Value:TRpParamList);
begin
 FParams.Assign(Value);
end;

procedure TRpBaseReport.ActivateDatasets;
var
 i,index:integer;
 alias:string;
 dbinfo:TRpDatabaseInfoItem;
 dbalias:string;
begin
 if FDataInfo.Count<1 then
  exit;
 try
  for i:=0 to FDataInfo.Count-1 do
  begin
   FDataInfo.Items[i].Cached:=false;
   FDataInfo.Items[i].SQLOverride:='';
  end;
  // The main datasets must be cached
  for i:=0 to SubReports.Count-1 do
  begin
   alias:=SubReports.items[i].Subreport.Alias;
   if Length(alias)>0 then
   begin
    index:=DataInfo.IndexOf(alias);
    if index<0 then
      Raise Exception.Create(SRpSubreportAliasNotFound+':'+alias);
    dbalias:=UpperCase(FDataInfo.Items[index].DatabaseAlias);
    index:=DatabaseInfo.IndexOf(dbalias);
    if index<0 then
     Raise Exception.Create(SRpSubreportAliasNotFound+':'+alias);
    dbinfo:=DatabaseInfo.Items[index];
    index:=DataInfo.IndexOf(alias);
    if (Not (dbinfo.Driver in [rpdataibx,rpdatamybase,rpdatazeos])) then
    begin
     FDataInfo.Items[index].Cached:=true;
    end;
   end;
  end;

  for i:=0 to FDataInfo.Count-1 do
  begin
   // Watch if external dataset
   if Assigned(FAliasList) then
   begin
    index:=FAliasList.List.indexof(FDataInfo.Items[i].Alias);
    if index>=0 then
    begin
     if Assigned(FAliasList.List.Items[index].dataset) then
     begin
      FDataInfo.Items[i].Cached:=false;
      FDataInfo.Items[i].Dataset:=FAliasList.List.Items[index].dataset;
     end;
    end;
   end;
   CheckProgress(false);
  end;
  for i:=0 to FDataInfo.Count-1 do
  begin
   if FDataInfo.Items[i].OpenOnStart then
   begin
    UpdateParamsBeforeOpen(i,true);
    FDataInfo.Items[i].Connect(DatabaseInfo,Params);
    CheckProgress(false);
   end;
  end;
 except
  for i:=0 to FDataInfo.Count-1 do
  begin
   FDataInfo.Items[i].Disconnect;
  end;
  Raise;
 end;
end;

procedure TRpBaseReport.DeActivateDatasets;
var
 i:integer;
begin
 for i:=0 to FDataInfo.Count-1 do
 begin
  FDataInfo.Items[i].DisConnect;
  if Assigned(FDataInfo.Items[i].CachedDataset) then
   FDataInfo.Items[i].CachedDataset.DoClose;
 end;
 for i:=0 to FDatabaseInfo.Count-1 do
 begin
  FDatabaseInfo.Items[i].DisConnect;
 end;
end;


procedure TRpBaseReport.UpdateCachedSources(alias:string);
var
 i:integer;
begin
 for i:=0 to datainfo.Count-1 do
 begin
  if datainfo.Items[i].DataSource=alias then
  begin
   if datainfo.Items[i].Cached then
   begin
{$IFDEF USERPDATASET}
//    datainfo.Items[i].CachedDataset.DoClose;
    datainfo.Items[i].CachedDataset.DoOpen;
{$ENDIF}
   end
   else
    if Not datainfo.Items[i].Dataset.Active then
     datainfo.Items[i].Connect(databaseinfo,params);
   UpdateCachedSources(datainfo.items[i].alias);
  end;
 end;
end;



procedure TRpBaseReport.CheckProgress(finished:Boolean);
var
 docancel:boolean;
begin
  if (Assigned(FOnProgress) or Assigned(metafile.OnWorkProgress)) then
  begin
{$IFDEF MSWINDOWS}
   mmlast:=TimeGetTime;
   difmilis:=(mmlast-mmfirst);
{$ENDIF}
{$IFDEF LINUX}
   mililast:=now;
   difmilis:=MillisecondsBetween(mililast,milifirst);
{$ENDIF}
   if ((difmilis>FMilisProgres) or finished) then
   begin
     // Get the time
{$IFDEF MSWINDOWS}
    mmfirst:=TimeGetTime;
{$ENDIF}
{$IFDEF LINUX}
    milifirst:=now;
{$ENDIF}
    docancel:=false;
    if assigned(FThreadExec) then
    begin
     if AbortingThread then
      docancel:=true;
    end
    else
    begin
     if Assigned(FOnProgress) then
      FOnProgress(Self,docancel);
     if Assigned(metafile.OnWorkProgress) then
     begin
      metafile.WorkProgress(Self,recordcount,metafile.CurrentPageCount,docancel);
     end;
    end;
    if docancel then
     Raise Exception.Create(SRpOperationAborted);
   end;
  end;
end;



procedure TRpBaseReport.CheckIfDataAvailable;
var
 dataavail:boolean;
 dinfo:TRpDatainfoItem;
 i,index:integer;
begin
 if Not FPrintOnlyIfDataAvailable then
  exit;
 dataavail:=false;
 for i:=0 to SubReports.Count-1 do
 begin
  if Length(SubReports.Items[i].SubReport.Alias)>0 then
  begin
   index:=datainfo.IndexOf(SubReports.Items[i].SubReport.Alias);
   if index>=0 then
   begin
    dinfo:=datainfo.Items[index];
    if dinfo.Dataset.Active then
    begin
     if Not dinfo.Dataset.Eof then
     begin
      dataavail:=true;
      break;
     end;
    end;
   end;
  end;
 end;
 if not dataavail then
  Raise Exception.Create(SRpNoDataAvailableToPrint);
end;


constructor TIdenEOF.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FParamcount:=1;
 IdenName:='Eof';
// Help:=SRpInt;
 model:='function '+'Eof'+'(alias:string):Boolean';
// aParams:=SRpEof;
end;

function TIdenEof.GeTRpValue:TRpValue;
var
 aliasname:string;
 index:integer;
 dataset:TDataset;
begin
 if (not ( (VarType(Params[0])=varString) or (VarType(Params[0])=varOleStr) )) then
   Raise TRpNamedException.Create(SRpEvalType,
         IdenName);
 Result:=true;
 aliasname:=String(Params[0]);
 index:=FReport.DataInfo.IndexOf(aliasname);
 if index<0 then
  exit;
{$IFDEF USERPDATASET}
 if FReport.DataInfo.Items[index].Cached then
  dataset:=FReport.DataInfo.Items[index].CachedDataset
 else
{$ENDIF}
  dataset:=FReport.DataInfo.Items[index].Dataset;
 if Not dataset.Active then
  exit;
 Result:=dataset.Eof;
end;

procedure TRpBaseReport.Compose(PrevReport:TRpBaseReport;execute:Boolean;ADriver:TRpPrintDriver);
var
 i:integer;
 aobject:TTotalPagesObject;
begin
 if PrevReport.Metafile.CurrentPageCount<1 then
  exit;
 ClearTotalPagesList;
 metafile.Assign(PrevReport.Metafile);
 for i:=0 to PrevReport.FTotalPagesList.Count-1 do
 begin
  aobject:=TTotalPagesObject(PrevReport.FTotalPagesList.Items[i]);
  AddTotalPagesItem(aobject.PageIndex,aobject.ObjectIndex,aobject.DisplayFormat);
 end;
 freespace:=PrevReport.freespace;
 pageposy:=PrevReport.pageposy;
// pageposx:=FLeftMargin;
 pageposx:=PrevReport.pageposx;
 oldprintedsection:=PrevReport.oldprintedsection;
 oldprintedsectionext:=PrevReport.oldprintedsectionext;
 FCompose:=True;
 TwoPass:=true;
 if execute then
 begin
  PrintAll(ADriver);
 end;
end;



procedure TRpBaseReport.AlignSectionsTo(linesperinch:integer);
var
 subrep:TRpSubreport;
 sec:TRpSection;
 i,j:integer;
begin
 FTopMargin:=Round((TWIPS_PER_INCHESS/(linesperinch/100))*Round(FTopMargin/(TWIPS_PER_INCHESS/(linesperinch/100))));
 for i:=0 to SubReports.Count-1 do
 begin
  subrep:=Subreports.Items[i].Subreport;
  for j:=0 to subrep.Sections.Count-1 do
  begin
   sec:=subrep.Sections.Items[j].Section;
   sec.Height:=Round((TWIPS_PER_INCHESS/(linesperinch/100))*Round(sec.Height/(TWIPS_PER_INCHESS/(linesperinch/100))));
  end;
 end;
end;

function TRpBaseReport.OnPageOp(indexqt:integer;custom:Boolean;
     customwidth,customheight,papersource:integer;
     ForcePaperName:String;duplex:integer):Boolean;
begin
 rpagesizeqt.Indexqt:=indexqt;
 rpagesizeqt.Custom:=custom;
 rPageSizeQt.CustomHeight:=customheight;
 rPageSizeQt.CustomWidth:=customwidth;
 rPageSizeQt.papersource:=papersource;
 SetForcePaperName(rpagesizeqt,forcepapername);
 Result:=true;
 FUpdatePageSize:=true;
end;

function TRpBaseReport.OnOrienationOp(orientation:integer):Boolean;
begin
 if Not orientation in [0..2] then
 begin
  Result:=false
 end
 else
 begin
  currentorientation:=TRpOrientation(orientation);
  Result:=true;
 end;
 FUpdatePageSize:=true;
end;

function TRpBaseReport.OnGraphicOp(Top,Left,Width,Height:integer;
    DrawStyle:integer;BrushStyle:integer;BrushColor:integer;
    PenStyle:integer;PenWidth:integer; PenColor:integer):Boolean;
begin
 Result:=true;
 metafile.Pages[metafile.CurrentPage].NewDrawObject(Top,Left,Width,Height,
  DrawStyle,BrushStyle,BrushColor,PenStyle,PenWidth,PenColor);
end;

function TRpBaseReport.OnImageOp(Top,Left,Width,Height:integer;
     DrawStyle,DPIRes:integer;PreviewOnly:Boolean;Image:WideString):Boolean;
var
 astream:TMemoryStream;
begin
 // Search for the image
 Result:=false;
 astream:=Evaluator.GetStreamFromExpression(image);
 if assigned(astream) then
 begin
  try
   Result:=True;
   metafile.Pages[metafile.CurrentPage].NewImageObject(Top,Left,Width,Height,0,
    DrawStyle,DPIRes,astream,previewonly);
  finally
   astream.free;
  end;
 end;
end;

function TRpBaseReport.OnBarcodeOp (Top,Left,Width,Height:integer;
     Expression,DisplayFormat:WideString;BarType,Modul:Integer;Ratio,Rotation:Currency;
     CalcChecksum:Boolean;BrushColor:Integer):Boolean;
var
 barcode:TRpBarcode;
 FValue:Variant;
 data:string;
begin
 Result:=False;
 barcode:=TRpBarcode.Create(Self);
 try
  barcode.Width:=Width;
  barcode.Height:=Height;
  barcode.Typ:=TRpBarcodeType(BarType);
  barcode.Modul:=Modul;
  barcode.Ratio:=Ratio;
  barcode.Rotation:=Round(Rotation*10);
  barcode.Checksum:=CalcChecksum;
  FValue:=Evaluator.EvaluateText(Expression);
  barcode.CurrentText:=FormatVariant(displayformat,FValue,rpParamUnknown,true);
  try
   data:=barcode.Calculatebarcode;
  except
   on E:Exception do
   begin
    Raise TRpReportException.Create(E.Message+':'+SrpSCalculatingBarcode+' ',barcode,SRpSBarcode);
   end;
  end;
  // Draws Barcode
  barcode.PrintHeight:=Height;
  barcode.BColor:=BrushColor;
  barcode.DoLines(data, Left,Top,metafile);    // draw the barcode
  Result:=true;
 finally
  barcode.Free;
 end;
end;

function TRpBaseReport.OnTextheight(Text,LFontName,WFontName:WideString;
     RectWidth,FontSize,FontStyle,Type1Font:integer;
     PrintStep:integer):integer;
var
 textr:TRpTextObject;
 extent:TPoint;
begin
 textr.Text:=Text;
 textr.LFontName:=LFontName;
 textr.WFontName:=WFontName;
 textr.FontSize:=FontSize;
 textr.FontRotation:=0;
 textr.FontStyle:=FontStyle;
 textr.FontColor:=0;;
 textr.Type1Font:=Type1Font;
 textr.CutText:=false;
 textr.Alignment:=0;
 textr.WordWrap:=true;
 textr.RightToLeft:=false;
 textr.PrintStep:=TRpSelectFontStep(PrintStep);
 extent.Y:=0;
 extent.x:=rectwidth;
 FDriver.TextExtent(textr,extent);
 Result:=extent.Y;
end;

function TRpBaseReport.OnTextOp(Top,Left,Width,Height:integer;
    Text,LFontName,WFontName:WideString;
    FontSize,FontRotation,FontStyle,FontColor,Type1Font:integer;
    CutText:boolean;Alignment:integer;WordWrap,RightToLeft:Boolean;
    PrintStep,BackColor:integer;transparent:boolean):Boolean;
var
 textr:TRpTextObject;
begin
 Result:=true;
 textr.Text:=Text;
 textr.LFontName:=LFontName;
 textr.WFontName:=WFontName;
 textr.FontSize:=FontSize;
 textr.FontRotation:=FontRotation;
 textr.FontStyle:=FontStyle;
 textr.FontColor:=FontColor;
 textr.Type1Font:=Type1Font;
 textr.CutText:=CutText;
 textr.Alignment:=Alignment;
 textr.WordWrap:=WordWrap;
 textr.RightToLeft:=RightToLeft;
 textr.PrintStep:=TRpSelectFontStep(PrintStep);
 metafile.Pages[metafile.CurrentPage].NewTextObject(Top,Left,Width,Height,
  textr,BackColor,transparent);
end;

// Print all generaties the metafile, it's capable also
// of evaluate the totalpages expression
procedure TRpBaseReport.PrintAll(Driver:TRpPrintDriver);
var
 ncopies:integer;
begin
 ncopies:=copies;
 if ncopies=0 then
  ncopies:=1;
 BeginPrint(Driver);
 try
  Driver.NewDocument(metafile,ncopies,CollateCopies);
  try
   while Not PrintNextPage do;
  finally
   Driver.EndDocument;
  end;
 finally
  EndPrint;
 end;
end;


procedure TRpBaseReport.UpdateParamsBeforeOpen(index:integer;doeval:boolean);
var
 i:integer;
 paramname:string;
 avalue:Variant;
begin
 for i:=0 to Params.Count-1 do
 begin
  if Params.Items[i].Datasets.IndexOf(datainfo.Items[index].Alias)>=0 then
  if (params.items[i].ParamType in [rpParamExpreB,rpParamList]) then
  begin
   paramname:=params.items[i].Name;
   try
    if Not VarIsNull(params.items[i].Value) then
    begin
     if doeval then
     begin
      avalue := params.items[i].Value;
      if (VarIsString(avalue)) then
        avalue := QuotedStr(avalue);
      FEvaluator.EvaluateText(paramname+':=('+String(avalue)+')');
      params.items[i].LastValue:=FEvaluator.EvaluateText(paramname);
     end
     else
     begin
      params.items[i].LastValue:=FEvaluator.EvaluateText(String(params.items[i].Value));
     end;
    end;
   except
    on E:Exception do
    begin
{$IFDEF DOTNETD}
     Raise Exception.Create(E.Message+SRpParameter+'-'+paramname);
{$ENDIF}
{$IFNDEF DOTNETD}
     E.Message:=E.Message+SRpParameter+'-'+paramname;
     Raise;
{$ENDIF}
    end;
   end;
  end;
 end;
 for i:=0 to Params.Count-1 do
 begin
  if (params.items[i].ParamType in [rpParamSubstE,rpParamSubstList]) then
  begin
   paramname:=params.items[i].Name;
   try
    if Not VarIsNull(params.items[i].Value) then
    begin
     if doeval then
     begin
      avalue := params.items[i].Value;
      if (VarIsString(avalue)) then
        avalue := QuotedStr(avalue);
      FEvaluator.EvaluateText('M.'+paramname+':=('+String(avalue)+')');
      params.items[i].LastValue:=FEvaluator.EvaluateText('M.'+paramname);
     end
     else
     begin
      params.items[i].LastValue:=FEvaluator.EvaluateText(String(params.items[i].Value));
     end;
    end;
   except
    on E:Exception do
    begin
{$IFDEF DOTNETD}
     Raise Exception.Create(E.Message+SRpParameter+'-'+paramname);
{$ENDIF}
{$IFNDEF DOTNETD}
     E.Message:=E.Message+SRpParameter+'-'+paramname;
     Raise;
{$ENDIF}
    end;
   end;
  end;
 end;
end;

procedure TRpBaseReport.PrepareParamsBeforeOpen;
var
 i:integer;
begin
 for i:=0 to DataInfo.Count-1 do
  UpdateParamsBeforeOpen(i,false);
end;

procedure TRpBaseReport.InitEvaluator;
begin
 if Assigned(FEvaluator) then
 begin
  FEvaluator.free;
  FEvaluator:=nil;
 end;
 FEvaluator:=TRpEvaluator.Create(nil);
 FEvaluator.Language:=Language;
 FEvaluator.OnNewLanguage:=Newlanguage;
 FEvaluator.OnGraphicOp:=OnGraphicOp;
 FEvaluator.OnOrientationOp:=OnOrienationOp;
 FEvaluator.OnpageOp:=OnPageOp;
 FEvaluator.OnImageOp:=OnImageOp;
 FEvaluator.OnBarcodeOp:=OnBarcodeOp;
 FEvaluator.OnTextOp:=OnTextOp;
 FEvaluator.OnParamInfo:=OnParamInfo;
 FEvaluator.OnTextHeight:=OnTextHeight;
 FEvaluator.OnReOpenOp:=ReOpenOp;
 FEvaluator.OnGetSQLValue:=GetSQLValue;
end;

procedure TRpBaseReport.SetBidiModes(Value:TStrings);
begin
 FBidiModes.Assign(Value);
end;


procedure TRpBaseReport.WriteWFontName(Writer:TWriter);
begin
 WriteWideString(Writer, FWFontName);
end;

procedure TRpBaseReport.WriteLFontName(Writer:TWriter);
begin
 WriteWideString(Writer, FLFontName);
end;



procedure TRpBaseReport.ReadLFontName(Reader:TReader);
begin
 FLFontName:=ReadWideString(Reader);
end;

procedure TRpBaseReport.ReadWFontName(Reader:TReader);
begin
 FWFontName:=ReadWideString(Reader);
end;

procedure TRpBaseReport.DefineProperties(Filer:TFiler);
begin
 inherited;

 Filer.DefineProperty('WFontName',ReadWFontName,WriteWFontName,True);
 Filer.DefineProperty('LFontName',ReadLFontName,WriteLFontName,True);
end;

procedure TRpBaseReport.AssignDefaultFontTo(aitem:TRpGenTextComponent);
begin
 aitem.Type1Font:=Type1Font;
 aitem.FontSize:=FontSize;
 aitem.FontStyle:=FontStyle;
 aitem.FontRotation:=FontRotation;
 aitem.FontColor:=FontColor;
 aitem.BackColor:=BackColor;
 aitem.Transparent:=Transparent;
 aitem.CutText:=CutText;
 aitem.Alignment:=Alignment;
 aitem.VAlignment:=VAlignment;
 aitem.Wordwrap:=Wordwrap;
 aitem.SingleLine:=SingleLine;
 aitem.BidiModes:=BidiModes;
 aitem.Multipage:=Multipage;
 aitem.PrintStep:=PrintStep;
 aitem.LFontName:=LFontName;
 aitem.WFontName:=WFontName;
end;

procedure TRpBaseReport.GetDefaultFontFrom(aitem:TRpGenTextComponent);
begin
 Type1Font:=aitem.Type1Font;
 FontSize:=aitem.FontSize;
 FontStyle:=aitem.FontStyle;
 FontRotation:=aitem.FontRotation;
 FontColor:=aitem.FontColor;
 BackColor:=aitem.BackColor;
 Transparent:=aitem.Transparent;
 CutText:=aitem.CutText;
 Alignment:=aitem.Alignment;
 VAlignment:=aitem.VAlignment;
 Wordwrap:=aitem.Wordwrap;
 SingleLine:=aitem.SingleLine;
 BidiModes:=aitem.BidiModes;
 Multipage:=aitem.Multipage;
 PrintStep:=aitem.PrintStep;
 LFontName:=aitem.LFontName;
 WFontName:=aitem.WFontName;
end;

function TRpBaseReport.GetSQLValue(connectionname,sql:String):Variant;
var
 adataset:TDataset;
begin
 Result:=Null;
 adataset:=databaseinfo.ItemByName(connectionname).OpenDatasetFromSQL(sql,nil,false,params);
 try
  if Not adataset.Eof then
  begin
   Result:=adataset.Fields[0].AsVariant;
  end;
 finally
  adataset.free;
 end;
end;

function TRpBaseReport.ReOpenOp(datasetname:String;sql:Widestring):BOolean;
var
 adata:TRpDatainfoItem;
 index,i:integer;
begin
 Result:=false;
 index:=datainfo.IndexOf(datasetname);
 if index<0 then
  exit;
 adata:=datainfo.Items[index];
 adata.Disconnect;
 // Evaluates from evaluator all parameters
 for i:=0 to params.Count-1 do
 begin
  params.Items[i].LastValue:=evaluator.EvaluateText('M.'+params.Items[i].Name);
 end;
 adata.SQLOverride:=sql;
 adata.Connect(DatabaseInfo,Params);
end;

function TRpBaseReport.Newlanguage(alanguage:integer):integer;
begin
 Result:=FLanguage;
 // Setting the property, sets the new language
 // for the evaluator and the parameters
 Language:=aLanguage;
end;

function TRpBaseReport.OnParamInfo(ParamName:String;index:integer):String;
var
 param:TRpParam;
 i,ind:integer;
begin
 Result:='';
 param:=Params.FindParam(UpperCase(ParamName));
 if Assigned(param) then
 begin
  if param.ParamType in  [rpparammultiple,rpparamlist,rpparamsubstlist] then
  begin
   case index of
    0:
     // Parameter value as string
     Result:=param.AsString;
    1:
     begin
      // Parameter value as multiple line string, real values
      if param.ParamType=rpparammultiple then
      begin
       for i:=0 to param.Selected.Count-1 do
       begin
        ind:=StrToInt(param.Selected.Strings[i]);
        if param.Values.Count>ind then
        begin
         if Length(Result)>0 then
          Result:=Result+#10+param.Values.Strings[ind]
         else
          Result:=param.Values.Strings[ind];
        end;
       end;
      end
      else
      begin
       if ((param.ParamType=rpparamlist) or (param.ParamType=rpparamsubstlist))  then
        Result:=param.ListValue;
      end;
     end;
    2:
     begin
      // Parameter value as multiple line string, indexes selected
      if param.ParamType=rpparammultiple then
      begin
       for i:=0 to param.Selected.Count-1 do
       begin
        ind:=StrToInt(param.Selected.Strings[i]);
        if Length(Result)>0 then
         Result:=Result+#10+IntToStr(ind)
        else
         Result:=IntToStr(ind);
       end;
      end
      else
      begin
       Result:=param.AsString;
      end;
     end;
    3:
     begin
      // Parameter value as multiple line string, user selection
      if param.ParamType=rpparammultiple then
      begin
       for i:=0 to param.Selected.Count-1 do
       begin
        ind:=StrToInt(param.Selected.Strings[i]);
        if param.Items.Count>ind then
        begin
         if Length(Result)>0 then
          Result:=Result+#10+param.Items.Strings[ind]
         else
          Result:=param.Items.Strings[ind];
        end;
       end;
      end
      else
      begin
       Result:=param.AsString;
      end;
     end;
    4:
     begin
      // Parameter value as multiple line string, possible values as user see
      for i:=0 to param.Items.Count-1 do
      begin
       if Length(Result)>0 then
        Result:=Result+#10+param.Items.Strings[i]
       else
        Result:=param.Items.Strings[i];
      end;
     end;
    5:
     begin
      // Parameter value as multiple line string, possible values as real values
      for i:=0 to param.Values.Count-1 do
      begin
       if Length(Result)>0 then
        Result:=Result+#10+param.Values.Strings[i]
       else
        Result:=param.Values.Strings[i];
      end;
     end;
    6:
     begin
     // Datasets related to the param
      for i:=0 to param.Datasets.Count-1 do
      begin
       if Length(Result)>0 then
        Result:=Result+#10+param.Datasets.Strings[i]
       else
        Result:=param.Datasets.Strings[i];
      end;
     end;
    7:
     begin
      // Description
      Result:=param.Description;
     end;
    8:
     begin
      // Description
      Result:=param.Hint;
     end;
    9:
     begin
      // Description
      Result:=param.ErrorMessage;
     end;
    10:
     begin
      // Description
      Result:=param.Validation;
     end;
   end;
  end
  else
  begin
   case index of
    6:
      begin
       for i:=0 to param.Datasets.Count-1 do
       begin
        if Length(Result)>0 then
         Result:=Result+#10+param.Datasets.Strings[i]
        else
         Result:=param.Datasets.Strings[i];
       end;
      end;
    7:
     begin
      // Description
      Result:=param.Description;
     end;
    8:
     begin
      // Description
      Result:=param.Hint;
     end;
    9:
     begin
      // Description
      Result:=param.ErrorMessage;
     end;
    10:
     begin
      // Description
      Result:=param.Validation;
     end;
     else
       Result:=param.AsString;
   end;
  end;
 end;
end;

function TRpBaseReport.RequestPage(pageindex:integer):boolean;
var
 asyncexec:Boolean;
begin
 AsyncExec:=AsyncExecution;;
 if (LastPage) then
 begin
  Result:=true;
  exit;
 end;
 if (TwoPass) then
 begin
  AsyncExec:=false;
  if (MAX_PAGECOUNT<>pageindex) then
  begin
   Result:=RequestPage(MAX_PAGECOUNT);
   exit;
  end;
 end;
 if (pageindex<(metafile.CurrentPageCount-1)) then
 begin
  Result:=LastPage;
  exit;
 end;
 if (FExecuting) then
 begin
   while ((FExecuting) AND  (metafile.CurrentPageCount<=pageindex)) do
   begin
{$IFDEF MSWINDOWS}
   WaitForSingleObject(FThreadExec.Handle,100);
{$ENDIF}
{$IFDEF LINUX}
   sleep(100);
{$ENDIF}
//    FThreadExec.WaitFor;
//    WairForSingleObject(threadexec.handle);
   end;
   Result:=LastPage;
   exit;
 end;
 if (AsyncExec) then
 begin
  Printingonepass:=false;
  PrintNextPage();
  if not LastPage then
  begin
   fintpageindex:=MAX_PAGECOUNT;
   FExecuting:=true;
   try
     FThreadExec:=TThreadExecReport.Create(true);
     FThreadExec.Report:=self;
     AbortingThread:=false;
     FThreadExec.Resume;
   except
    FExecuting:=false;
    FThreadExec.free;
    FThreadExec:=nil;
    raise;
   end;
   while ((FExecuting) AND  (metafile.CurrentPageCount<=pageindex)) do
   begin
{$IFDEF MSWINDOWS}
   WaitForSingleObject(FThreadExec.Handle,100);
{$ENDIF}
{$IFDEF LINUX}
   sleep(100);
{$ENDIF}
   end;
  end;
 end
 else
 begin
  if Assigned(FThreadExec) then
  begin
   FThreadExec.Terminate;
   FThreadExec:=nil;
  end;
  fintpageindex:=pageindex;
  DoPrintInternal();
 end;
 Result:=LastPage;
end;

procedure TRpBaseReport.DoPrintInternal;
begin
 try
  if (not LastPage) then
  begin
   CheckProgress(false);
   while (not PrintNextPage()) do
   begin
    CheckProgress(false);
    if (PageNum>MAX_PAGECOUNT) then
     Raise Exception.Create(SRpMaximumPages+' - '+IntToStr(MAX_PAGECOUNT));
    if (PageNum>=fintpageindex) then
     break;
    if (LastPage) then
     break;
    if AbortingThread then
     break;
   end;
  end;
  FExecuting:=false;
  CheckProgress(false);
 except
  on E:Exception do
  begin
   FExecuting:=false;
   if (FThreadExec=nil) then
    raise;
   if (not (AbortingThread)) then
   begin
    if Assigned(OnWorkAsyncError) then
     OnWorkAsyncError(E.Message)
    else
     raise;
   end;
  end;
 end;
end;

procedure TRpBaseReport.StopWork;
begin
 if Fexecuting then
 begin
  if Assigned(FThreadExec) then
  begin
   AbortingThread:=true;
   FThreadExec.Terminate;
   FExecuting:=false;
   FThreadExec:=nil;
  end;
 end;
end;

procedure TRpBaseReport.SetLanguage(index:integer);
begin
 FLanguage:=index;
 Params.Language:=index;
 if Assigned(FEvaluator) then
  FEvaluator.Language:=FLanguage;
end;

procedure TThreadExecReport.DoProgress;
begin
 docancel:=false;
 report.FOnProgress(report,docancel);
end;

procedure TThreadExecReport.Execute;
begin
 report.DoPrintInternal;
end;


procedure TRpBaseReport.AddReportItemsToEvaluator(eval:TRpEvaluator);
var
 i:integeR;
begin
 // Insert params into rpEvaluator
 for i:=0 to Params.Count-1 do
 begin
  if eval.Searchidentifier(params.items[i].Name)=nil then
   eval.NewVariable(params.items[i].Name,params.items[i].Value);
 end;
 // Here identifiers are added to evaluator
 for i:=0 to Identifiers.Count-1 do
 begin
  if FIdentifiers.Objects[i] is TRpExpression then
  begin
   eval.AddVariable(FIdentifiers.Strings[i],
    TRpExpression(FIdentifiers.Objects[i]).IdenExpression);
  end
  else
  if FIdentifiers.Objects[i] is TRpChart then
  begin
   eval.AddVariable(FIdentifiers.Strings[i],
    TRpChart(FIdentifiers.Objects[i]).IdenChart);
  end
 end;
 // Compatibility with earlier versions
 eval.AddVariable('PAGINA',fidenpagenum);
 eval.AddVariable('NUMPAGINA',fidenpagenumgroup);
 // Insert page number and other variables
 eval.AddVariable('PAGE',fidenpagenum);
 eval.AddVariable('PAGENUM',fidenpagenumgroup);
 eval.AddVariable('LANGUAGE',fidenlanguage);
 // Free space and sizes
 eval.AddVariable('FREE_SPACE_TWIPS',fidenfreespace);
 eval.AddVariable('PAGEWIDTH',fidenpagewidth);
 eval.AddVariable('PAGEHEIGHT',fidenpageheight);
 eval.AddVariable('CURRENTGROUP',fidencurrentgroup);
 eval.AddVariable('FIRSTSECTION',fidenfirstsection);
 eval.AddVariable('FREE_SPACE_CMS',fidenfreespacecms);
 eval.AddVariable('FREE_SPACE_INCH',fidenfreespaceinch);
 eval.AddIden('EOF',fideneof);
end;

procedure TRpBaseReport.LoadExternals;
begin

end;


function TRpBaseReport.CheckParameters(paramlist:TRpParamList;var paramname,amessage:string):Boolean;
var
 i:integer;
 validation:widestring;
 errormessage:widestring;
 aresult:Variant;
 paramtemp:TRpParamList;
begin
 paramtemp:=nil;
 if paramlist<>params then
  paramtemp:=TRpParamList.Create(nil);
 try
  if Assigned(paramtemp) then
   paramtemp.Assign(params);
  try
   if Assigned(paramtemp) then
    params.Assign(paramlist);
   InitEvaluator;
   AddReportItemsToEvaluator(FEvaluator);
   Result:=true;
   for i:=0 to Params.Count-1 do
   begin
    validation:=Params.Items[i].Validation;
    errormessage:=Params.Items[i].ErrorMessage;
    if Length(validation)>0 then
    begin
     aresult:=Evaluator.EvaluateText(validation);
     if not VarIsNull(aresult) then
     begin
      if VarIsBoolean(aresult) then
      begin
       if not aresult then
       begin
        paramname:=Params.Items[i].Name;
        amessage:=errormessage;
        Result:=false;
        break;
       end;
      end;
     end;
    end;
   end;
  finally
   if Assigned(paramtemp) then
    params.Assign(paramtemp);
  end;
 finally
  if Assigned(paramtemp) then
   paramtemp.free;
 end;
end;

function TRpBaseReport.IsDotNet:boolean;
begin
 Result:=false;
 if Databaseinfo.Count>0 then
  if (Databaseinfo.Items[0].Driver in [rpdatadriver,rpdotnet2driver]) then
   Result:=true;
end;



end.
