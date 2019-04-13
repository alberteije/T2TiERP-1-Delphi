{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpmetafile                                      }
{       TRpMetafileReport: A Metafile report            }
{       is a collection of pages that can be printed    }
{       using a printer driver interface                }
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

{
 The Report Metafile is a file that contains all
 the info to print a complete report.
 File Format Binary

 Signature='RPMETAFILE04'
 rpFHeader=integer(0);
 PageSize=integer;
 CustomX=integer;
 CustomY=integer;
 Orientation=integer;
 BackColor=integer;

 rpFPage=integer(1);
 ...
 rpFObject or rpFPage

}
unit rpmetafile;

interface

{$I rpconf.inc}

uses Classes,SyncObjs,
{$IFDEF LINUX}
  Libc,DateUtils,
{$ENDIF}
{$IFDEF MSWINDOWS}
  mmsystem,windows,
 {$IFNDEF DOTNETD}
  rpcompilerep,
 {$ENDIF}
{$ENDIF}
{$IFDEF USEVARIANTS}
 types,
{$ENDIF}
 Sysutils,rpmdconsts,
 rpmdcharttypes,
{$IFDEF USEZLIB}
{$IFDEF DELPHI2009UP}
 zlib,
{$ENDIF}
{$IFNDEF DELPHI2009UP}
 rpmzlib,
{$ENDIF}
{$ENDIF}
 rptypes;

const
 MILIS_PROGRESS=500;
 RP_SIGNATURELENGTH=13;
 BUFFER_FLEX_SIZE=8192;
 // The metafile signature and version
 RpSignature:string='RPMETAFILE09'+chr(0);
 RpSignature2_2:string='RPMETAFILE07'+chr(0);
const
 FIRST_ALLOCATION_OBJECTS=50;
 FIRST_ALLOCATED_WIDESTRING=1000;
type
 TMetaFileWorkProgress=procedure (Sender:TObject;records,pagecount:integer;var docancel:boolean) of object;
 TStopWork=procedure of object;
 TWorkAsyncError=procedure (amessage:string) of object;
 TRequestPageEvent=function (pageindex:integer):boolean of object;
 ERpBadFileFormat=class(Exception)
  private
   FPosition:integer;
  public
   constructor CreatePos(Msg:String;APosition,Pos2:LongInt);
   property position:LongInt read FPosition;
  end;

 TRpMetafileReport=class;
 TRpMetafilePage=class;

 TReadThread=class(TThread)
  private
   errormessage:string;
  public
   metafile:TRpMetafileReport;
   Stream:TStream;
   procedure Execute;override;
   procedure ShowError;
   procedure Progress;
 end;

 TOnRequestData=procedure (Sender:TObject;count:integer) of object;

 TFlexStream=class(TStream)
  private
   FStream:TStream;
   FIsCompressed:Boolean;
   FLastReadCount:Integer;
   FInternalPosition:integer;
   FPosition:integer;
   FBuffer:TMemoryStream;
   FBuf:array [0..BUFFER_FLEX_SIZE] of byte;
   FIntStream:TMemoryStream;
   FEof:boolean;
   FOnRequestData:TOnRequestData;
   critsec:TCriticalSection;
   procedure ReadBuffer;
  public
   function Write(const Buffer; Count: Longint): Longint;override;
   function Read(var Buffer; Count: Longint): Longint; override;
   function Seek(Offset: Longint; Origin: Word): Longint; override;
   constructor Create(AStream:TStream;OnRequestData:TOnRequestData;criticalsec:TCriticalSection);
   destructor Destroy;override;
   property IsCompressed:boolean read FIsCompressed;
  end;

 TTotalPagesObject=class(TObject)
  public
   PageIndex,ObjectIndex:integer;
   DisplayFormat:widestring;
  end;

 TRpMetaObjectType=(rpMetaText,rpMetaDraw,rpMetaImage,rpMetaPolygon,rpMetaExport);

 TRpMetaSeparator=(rpFHeader,rpFPage,rpFObject,rpFStream);

 TRpTextObject=record
  Text:WideString;
  LFontName:WideString;
  WFontName:WideString;
  FontSize:smallint;
  FontRotation:smallint;
  FontStyle:smallint;
  FontColor:Integer;
  Type1Font:smallint;
  CutText:boolean;
  Alignment:integer;
  WordWrap:boolean;
  RightToLeft:Boolean;
  PrintStep:TRpSelectFontStep;
 end;


// This is not a safe type, so
// .net metafiles are not compatible
// need to rework all streaming to
// be compatible or enlarge the file size a lot
// size *4
{$IFNDEF DOTNETDBUGS}
 TRpMetaObject=packed record
  Top,Left,Width,Height:integer;
  case Metatype:TRpMetaObjectType of
   rpMetaText:
    (TextP,TextS:integer;
    LFontNameP,LFontNameS:integer;
    WFontNameP,WFontNameS:integer;
    FontSize:smallint;
    FontRotation:smallint;
    FontStyle:smallint;
    Type1Font:smallint;
    FontColor:integer;
    BackColor:integer;
    Transparent:boolean;
    CutText:boolean;Alignment:integer;WordWrap:boolean;
    RightToLeft:Boolean;PrintStep:TRpSelectFontStep);
   rpMetaDraw:
    (DrawStyle:integer;
    BrushStyle:integer;
    BrushColor:integer;
    PenStyle:integer;
    PenWidth:integer;
    PenColor:integer);
   rpMetaImage:
    (CopyMode:integer;
     DrawImageStyle:integer;
     DPIres:integer;
     PreviewOnly:boolean;
     StreamPos:int64;
     StreamSize:int64;
     SharedImage:boolean);
   rpMetaPolygon:
    (PolyBrushStyle:integer;
     PolyBrushColor:integer;
     PolyPenStyle:integer;
     PolyPenWidth:integer;
     PolyPenColor:integer;
     PolyPointCount:integer;
     PolyStreamPos:int64;
     PolyStreamSize:int64);
   rpMetaExport:
    (TextExpP,TextExpS:integer;
     Line:Integer;
     Position:Integer;
     Size:Integer;
     DoNewLine:Boolean);
 end;
{$ENDIF}
{$IFDEF DOTNETDBUGS}
 TRpMetaObject=packed record
  Top,Left,Width,Height:integer;
//  case Metatype:TRpMetaObjectType of
   Metatype:TRpMetaObjectType;
//   rpMetaText:
    TextP,TextS:integer;
    LFontNameP,LFontNameS:integer;
    WFontNameP,WFontNameS:integer;
    FontSize:smallint;
    FontRotation:smallint;
    FontStyle:smallint;
    Type1Font:smallint;
    FontColor:integer;
    BackColor:integer;
    Transparent:boolean;
    CutText:boolean;Alignment:integer;WordWrap:boolean;
    RightToLeft:Boolean;PrintStep:TRpSelectFontStep;
//   rpMetaDraw:
    DrawStyle:integer;
    BrushStyle:integer;
    BrushColor:integer;
    PenStyle:integer;
    PenWidth:integer;
    PenColor:integer;
//   rpMetaImage:
    CopyMode:integer;
     DrawImageStyle:integer;
     DPIres:integer;
     PreviewOnly:boolean;
     StreamPos:int64;
     StreamSize:int64;
//   rpMetaPolygon:
    PolyBrushStyle:integer;
     PolyBrushColor:integer;
     PolyPenStyle:integer;
     PolyPenWidth:integer;
     PolyPenColor:integer;
     PolyPointCount:integer;
     PolyStreamPos:int64;
     PolyStreamSize:int64;
//   rpMetaExport:
    TextExpP,TextExpS:integer;
     Line:Integer;
     Position:Integer;
     Size:Integer;
     DoNewLine:Boolean;
 end;
{$ENDIF}


 TRpPrintDriver=class(TObject)
  procedure NewDocument(report:TrpMetafileReport;hardwarecopies:integer;
   hardwarecollate:boolean);virtual;abstract;
  procedure EndDocument;virtual;abstract;
  procedure AbortDocument;virtual;abstract;
  procedure NewPage(metafilepage:TRpMetafilePage);virtual;abstract;
  procedure EndPage;virtual;abstract;
  function GetPageSize(var PageSizeQt:Integer):TPoint;virtual;abstract;
  function SetPagesize(PagesizeQt:TPageSizeQt):TPoint;virtual;abstract;
  procedure SetOrientation(Orientation:TRpOrientation);virtual;abstract;
  procedure DrawObject(page:TRpMetaFilePage;obj:TRpMetaObject);virtual;abstract;
  procedure DrawChart(Series:TRpSeries;ametafile:TRpMetaFileReport;posx,posy:integer;achart:TObject);virtual;abstract;
  procedure FilterImage(memstream:TMemoryStream);virtual;
  procedure TextExtent(atext:TRpTextObject;var extent:TPoint);virtual;abstract;
  procedure GraphicExtent(Stream:TMemoryStream;var extent:TPoint;dpi:integer);virtual;abstract;
  procedure DrawPage(apage:TRpMetaFilePage);virtual;abstract;
  function SupportsCopies(maxcopies:integer):boolean;virtual;abstract;
  function SupportsCollation:boolean;virtual;abstract;
  function AllowCopies:boolean;virtual;abstract;
  procedure SelectPrinter(printerindex:TRpPrinterSelect);virtual;abstract;
  function GetFontDriver:TRpPrintDriver;virtual;abstract;
 end;

{$IFNDEF FORWEBAX}
 TDoDrawChartEvent=procedure (adriver:TRpPrintDriver;Series:TRpSeries;page:TRpMetaFilePage;
  aposx,aposy:integer;achart:TObject) of Object;
 TDoFilterImage=procedure (memstream:TMemoryStream) of object;
{$ENDIF}

 TRpMetafilePage=class(TObject)
  private
   Fversion2_2:Boolean;
   FUpdatedPageSize:Boolean;
   FObjects:array of TRpMetaObject;
   FObjectCount:Integer;
   FPool:Widestring;
   FPoolPos:integer;
   FStreamPos:int64;
   FMemStream:TMemoryStream;
   FIntStream:TMemoryStream;
   FMark:Integer;
   FOrientation:TRpOrientation;
   FPageSizeqt:TPageSizeQt;
   FMetafile:TRpMetafileReport;
   CritEx:TCriticalSection;

//   FStringList:TStringList;
   function GetObject(index:integer):TRpMetaObject;
   procedure NewWideString(var position,size:integer;const text:widestring);
  public
   procedure LoadFromStream(Stream:TStream);
   procedure SaveToStream(Stream:TStream);
   procedure DeleteObject(index:integer);
   constructor Create;
   destructor Destroy;override;
   procedure Clear;
   procedure NewTextObject(Top,Left,Width,Height:integer;
    aText:TRpTextObject;BackColor:integer;transparent:boolean);
   procedure NewExportObject(Top,Left,Width,Height:integer;
    aText:WideString;Line,Position,Size:Integer;DoNewLine:boolean);
   procedure NewDrawObject(Top,Left,Width,Height:integer;
    DrawStyle:integer;BrushStyle:integer;BrushColor:integer;
    PenStyle:integer;PenWidth:integer; PenColor:integer);
   function NewImageObject(Top,Left,Width,Height:integer;
    CopyMode:integer;DrawImageStyle:integer;DPIres:integer;stream:TStream;PreviewOnly:Boolean):integer;
   procedure NewImageObjectShared(Top,Left,Width,Height:integer;
    CopyMode:integer;DrawImageStyle:integer;DPIres:integer;var imagepos:int64;stream:TStream;PreviewOnly:Boolean);
   function GetText(arecord:TRpMetaObject):widestring;
   function GetWFontName(arecord:TRpMetaObject):widestring;
   function GetLFontName(arecord:TRpMetaObject):widestring;
   function GetStream(arecord:TRpMetaObject):TMemoryStream;
   property Mark:Integer read FMark write FMark;
   property ObjectCount:integer read FObjectCount;
   property Pool:WideString read FPool;
   property Objects[Index:integer]:TRpMetaObject read GetObject;
   property Orientation:TRpOrientation read FOrientation write FOrientation;
   property PageSizeqt:TPageSizeQt read FPageSizeQt write FPageSizeQt;
   property UpdatedPageSize:Boolean read FUpdatedPageSize
    write FUpdatedPageSize default false;
  end;

 TRpMetafileReport=class(TComponent)
  private
   zStream:TStream;
   FPages:TList;
   FIntPageCount:Integer;
   FWaiting:Boolean;
   FCurrentPage:integer;
   FFinished:Boolean;
   FReading:boolean;
   FPreviewAbout:Boolean;
   FPreviewMargins:Boolean;
   Fversion2_2:Boolean;
   FOnWorkAsyncError:TWorkAsyncError;
   FOnRequestPage:TRequestPageEvent;
   FReadThread:TReadThread;
   FlexStream,FlexStream2:TFlexStream;
   FBackColor:integer;
   AbortingThread:Boolean;
   IntStream:TStream;
   FMemStream:TMemoryStream;
   FTextsFound:TStringList;
   FTextsFoundByPage:TStringList;
   procedure SetCurrentPage(index:integer);
   function GetPageCount:integer;
   function GetPage(Index:integer):TRpMetafilePage;
   procedure IntSaveToStream(Stream:TStream;SaveStream:TStream);
   procedure IntLoadFromStream(Stream:TStream;clearfirst:boolean=true);
   procedure DoRequestData(Sender:TObject;count:integer);
   procedure SetBackColor(avalue:integer);
  public
   BlockPrinterSelection:Boolean;
   AsyncReading:Boolean;
   PageSize:integer;
   CustomX:integer;
   CustomY:integer;
   Orientation:TRpOrientation;
   PaperSource:Word;
   Copies:Word;
   Duplex:Byte;
   CollateCopies:Boolean;
   LinesPerInch:Word;
   PrinterSelect:TRpPrinterSelect;
   PreviewStyle:TRpPreviewStyle;
   PreviewWindow:TRpPreviewWindowStyle;
   OpenDrawerBefore:Boolean;
   OpenDrawerAfter:Boolean;
{$IFNDEF FORWEBAX}
   OnDrawChart:TDoDrawChartEvent;
   OnFilterImage:TDoFilterImage;
{$ENDIF}
   OnWorkProgress:TMetaFileWorkProgress;
   OnStopWork:TStopWork;
   OnRequestData:TOnRequestData;
   Title:string;
   critsec:TCriticalSection;
   ForcePaperName:string;
   DidSearch:boolean;
   procedure Clear;
   procedure DoSearch(avalue:string);
   procedure LoadFromStream(Stream:TStream;clearfirst:boolean=true);
   procedure LoadFromFile(filename:string;clearfirst:boolean=true);
   procedure SaveToStream(Stream:TStream;compressed:boolean=true);
   procedure SaveToFile(filename:string;compressed:boolean=true);
   procedure Assign(Source:TPersistent);override;
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
   procedure NewPage;
   procedure DrawPage(IDriver:TRpPrintDriver;index:integer);
   procedure DrawAll(IDriver:TRpPrintDriver);
   procedure DrawPageOnly(IDriver:TRpPrintDriver;index:integer);
   procedure InsertPage(index:integer);
   procedure DeletePage(index:integer);
   function RequestPage(pageindex:integer):boolean;
   procedure WorkProgress(Sender:TObject;records,pagecount:integer;var docancel:boolean);
   procedure WorkAsyncError(amessage:string);
   procedure Finish;
   procedure StopWork;
   function IsFound(page:TRpMetafilePage;objectindex:integer):boolean;
   function NextPageFound(pageindex:integer):integer;
   property BackColor:integer read FBackColor write SetBackColor;
   property CurrentPage:integer read FCurrentPage write SetCurrentPage;
   property Reading:boolean read FReading;
//   property PagesCount:integer read GetPageCount;
   property CurrentPageCount:integer read GetPageCount;
   procedure UpdateTotalPages(alist:TList);
   procedure UpdateTotalPagesPCount(alist:TList;pcount:integer);
   procedure PageRange(frompage,topage:integer);
   property Pages[Index:integer]:TRpMetafilePage read GetPage;
   property PreviewAbout:Boolean read FPreviewAbout write FPreviewAbout;
   property PreviewMargins:Boolean read FPreviewMargins write FPreviewMargins;
   property OnWorkAsyncError:TWorkAsyncError read FOnWorkAsyncError write FOnWorkAsyncError;
   property Finished:Boolean read FFinished;
   property OnRequestPage:TRequestPageEvent read FOnRequestPage write FOnRequestPage;
  published
  end;

  function CalcTextExtent(adriver:TRpPrintDriver;maxextent:TPoint;obj:TRpTextObject):integer;

{$IFDEF MSWINDOWS}
{$IFNDEF DOTNETD}
  procedure  MetafileToExe(metafile:TRpMetafileReport;filename:String);
{$ENDIF}
{$ENDIF}

function IsMetafile(memstream:TMemoryStream):boolean;

implementation

procedure TRpMetafileReport.SetBackColor(avalue:integer);
begin
 FBackColor:=avalue AND $00FFFFFF;
end;

constructor TrpMetafilePage.Create;
begin
 inherited Create;
 SetLength(FObjects,FIRST_ALLOCATION_OBJECTS);
 FObjectCount:=0;
 FMark:=0;
 FPoolPos:=1;
 FStreamPos:=0;
 CritEx:=TCriticalSection.Create;
 FMemStream:=TMemoryStream.Create;
// FStringList:=TStringList.Create;
// FStringList.Sorted:=true;
end;

procedure TRpMetafilePage.Clear;
begin
 SetLength(FObjects,FIRST_ALLOCATION_OBJECTS);
 FPool:='';
 FObjectCount:=0;
 FMark:=0;
 FPoolPos:=1;
 FStreamPos:=0;
end;

destructor TRpMetafilePage.Destroy;
begin
 FMemStream.Free;
 FMemStream:=nil;
 CritEx.free;
 if Assigned(FIntStream) then
 begin
  FIntStream.Free;
  FIntStream:=nil;
 end;

 inherited Destroy;
end;

procedure TrpMetafilePage.NewImageObjectShared(Top,Left,Width,Height:integer;
 CopyMode:integer;DrawImageStyle:integer;DPIres:integer;var imagepos:int64;stream:TStream;PreviewOnly:Boolean);
begin
 if FObjectCount>=High(FObjects)-1 then
 begin
  // Duplicates capacity
  SetLength(FObjects,High(FObjects)*2);
 end;
 FObjects[FObjectCount].Left:=Left;
 FObjects[FObjectCount].Top:=Top;
 FObjects[FObjectCount].Height:=Height;
 FObjects[FObjectCount].Width:=Width;
 FObjects[FObjectCount].CopyMode:=CopyMode;
 FObjects[FObjectCount].DrawImageStyle:=DrawImageStyle;
 FObjects[FObjectCount].DPIres:=DPIres;
 FObjects[FObjectCount].Metatype:=rpMetaImage;
 FObjects[FObjectCount].StreamSize:=stream.Size;
 FObjects[FObjectCount].PreviewOnly:=PreviewOnly;
 FObjects[FObjectCount].SharedImage:=true;
 if (imagepos<0) then
 begin
  CritEx.Enter;
  try
   FObjects[FObjectCount].StreamPos:=FMetafile.FMemStream.Size;
   imagepos:=FMetafile.FMemStream.Size;
   Stream.Seek(0,soFromBeginning);
   FMetafile.FMemStream.Seek(FMetafile.FMemStream.Size,soFromBeginning);
   if (Stream.size<>Fmetafile.FMemStream.CopyFrom(stream,stream.Size)) then
    Raise Exception.Create(SRpCopyStreamError);
  finally
   CritEx.Leave;
  end;
 end
 else
 begin
  FObjects[FObjectCount].StreamPos:=imagepos;
 end;
 inc(FObjectCount);
end;


function TrpMetafilePage.NewImageObject(Top,Left,Width,Height:integer;
 CopyMode:integer; DrawImageStyle:integer;DPIres:integer;stream:TStream;PreviewOnly:Boolean):integer;
begin
 if FObjectCount>=High(FObjects)-1 then
 begin
  // Duplicates capacity
  SetLength(FObjects,High(FObjects)*2);
 end;
 FObjects[FObjectCount].Left:=Left;
 FObjects[FObjectCount].Top:=Top;
 FObjects[FObjectCount].Height:=Height;
 FObjects[FObjectCount].Width:=Width;
 FObjects[FObjectCount].CopyMode:=CopyMode;
 FObjects[FObjectCount].DrawImageStyle:=DrawImageStyle;
 FObjects[FObjectCount].DPIres:=DPIres;
 FObjects[FObjectCount].Metatype:=rpMetaImage;
 FObjects[FObjectCount].StreamSize:=stream.Size;
 FObjects[FObjectCount].PreviewOnly:=PreviewOnly;
 FObjects[FObjectCount].SharedImage:=false;
 FObjects[FObjectCount].StreamPos:=FStreamPos;
 // Set the size of the stream
 if FMemStream.size=0 then
 begin
  FMemStream.SetSize(stream.size);
 end
 else
 begin
  if FMemStream.Size-FStreamPos-1<stream.size then
  begin
   FMemStream.SetSize(FStreamPos+stream.size);
  end;
 end;
 Stream.Seek(0,soFromBeginning);
 FMemStream.Seek(FStreamPos,soFromBeginning);
 if (Stream.size<>FMemStream.CopyFrom(stream,stream.Size)) then
  Raise Exception.Create(SRpCopyStreamError);
 FStreamPos:=FMemStream.Position;
 Result:=FObjectCount;
 inc(FObjectCount);
end;


function TrpMetafilePage.GetStream(arecord:TRpMetaObject):TMemoryStream;
begin
 if Assigned(FIntStream) then
 begin
  FIntStream.Free;
  FIntStream:=nil;
  FIntStream:=TMemoryStream.Create;
  FIntStream.SetSize(arecord.StreamSize);
 end
 else
 begin
  FIntStream:=TMemoryStream.Create;
 end;
 if arecord.SharedImage then
 begin
  CritEx.Enter;
  try
   FMetafile.FMemStream.Seek(arecord.StreamPos,soFromBeginning);
   FIntStream.CopyFrom(FMetafile.FMemStream,arecord.StreamSize);
  finally
   CritEx.Leave;
  end;
 end
 else
 begin
  FMemStream.Seek(arecord.StreamPos,soFromBeginning);
  FIntStream.CopyFrom(FMemStream,arecord.StreamSize);
 end;
 FIntStream.Seek(0,soFromBeginning);
 Result:=FIntStream;
end;


procedure TrpMetafilePage.NewDrawObject(Top,Left,Width,Height:integer;
    DrawStyle:integer;BrushStyle:integer;BrushColor:integer;
    PenStyle:integer;PenWidth:integer; PenColor:integer);
begin
 if FObjectCount>=High(FObjects)-1 then
 begin
  // Duplicates capacity
  SetLength(FObjects,High(FObjects)*2);
 end;
 FObjects[FObjectCount].Left:=Left;
 FObjects[FObjectCount].Top:=Top;
 FObjects[FObjectCount].Height:=Height;
 FObjects[FObjectCount].Width:=Width;
 FObjects[FObjectCount].Metatype:=rpMetaDraw;

 FObjects[FObjectCount].DrawStyle:=DrawStyle;
 FObjects[FObjectCount].BrushStyle:=BrushStyle;
 FObjects[FObjectCount].BrushColor:=BrushColor;
 FObjects[FObjectCount].PenColor:=PenColor;
 FObjects[FObjectCount].PenWidth:=PenWidth;
 FObjects[FObjectCount].PenStyle:=PenStyle;

 inc(FObjectCount);
end;

procedure TrpMetafilePage.NewWideString(var position,size:integer;const text:widestring);
//var
// index:integeR;
begin
 size:=Length(Text);
// index:=FStringList.IndexOf(text);
// if (index>=0) then
// begin
//  position:=integer(FStringList.Objects[index]);
//  exit;
// end;
 FPool:=FPool+Text;
 position:=FPoolPos;
 FPoolPos:=FPoolPos+size;
// FStringList.AddObject(text,TObject(position));

end;


procedure TrpMetafilePage.NewExportObject(Top,Left,Width,Height:integer;
    aText:WideString;Line,Position,Size:Integer;DoNewLine:boolean);
begin
 if FObjectCount>=High(FObjects)-1 then
 begin
  // Duplicates capacity
  SetLength(FObjects,High(FObjects)*2);
 end;

 FObjects[FObjectCount].Left:=Left;
 FObjects[FObjectCount].Top:=Top;
 FObjects[FObjectCount].Height:=Height;
 FObjects[FObjectCount].Width:=Width;
 FObjects[FObjectCount].Metatype:=rpMetaExport;

 NewWideString(FObjects[FObjectCount].TextExpP,FObjects[FObjectCount].TextExpS,
  aText);
 FObjects[FObjectCount].Line:=Line;
 FObjects[FObjectCount].Position:=Position;
 FObjects[FObjectCount].Size:=Size;
 FObjects[FObjectCount].DoNewLine:=DoNewLine;

 inc(FObjectCount);

end;

procedure TrpMetafilePage.NewTextObject(Top,Left,Width,Height:integer;
    aText:TRpTextObject;BackColor:integer;transparent:boolean);
begin
 if FObjectCount>=High(FObjects)-1 then
 begin
  // Duplicates capacity
  SetLength(FObjects,High(FObjects)*2);
 end;
 FObjects[FObjectCount].Left:=Left;
 FObjects[FObjectCount].Top:=Top;
 FObjects[FObjectCount].Height:=Height;
 FObjects[FObjectCount].Width:=Width;
 FObjects[FObjectCount].Metatype:=rpMetaText;

 NewWideString(FObjects[FObjectCount].TextP,FObjects[FObjectCount].TextS,aText.Text);
 NewWideString(FObjects[FObjectCount].WFontNameP,
  FObjects[FObjectCount].WFontNameS,aText.WFontName);
 NewWideString(FObjects[FObjectCount].LFontNameP,
  FObjects[FObjectCount].LFontNameS,aText.LFontName);
 FObjects[FObjectCount].FontSize:=aText.FontSize;
 FObjects[FObjectCount].FontRotation:=aText.FontRotation;
 FObjects[FObjectCount].FontStyle:=aText.FontStyle;
 FObjects[FObjectCount].Type1Font:=aText.Type1Font;
 FObjects[FObjectCount].FontColor:=aText.FontColor;
 FObjects[FObjectCount].BackColor:=BackColor;
 FObjects[FObjectCount].Transparent:=Transparent;
 FObjects[FObjectCount].CutText:=aText.CutText;
 FObjects[FObjectCount].Alignment:=aText.Alignment;
 FObjects[FObjectCount].WordWrap:=aText.WordWrap;
 FObjects[FObjectCount].RightToLeft:=aText.RightToLeft;
 FObjects[FObjectCount].PrintStep:=aText.PrintStep;


 inc(FObjectCount);

end;

function TrpMetafilePage.GetText(arecord:TRpMetaObject):widestring;
begin
 Result:=Copy(FPool,arecord.TextP,arecord.TextS);
end;

function TrpMetafilePage.GetWFontName(arecord:TRpMetaObject):widestring;
begin
 Result:=Copy(FPool,arecord.WFontNameP,arecord.WFontNameS);
end;

function TrpMetafilePage.GetLFontName(arecord:TRpMetaObject):widestring;
begin
 Result:=Copy(FPool,arecord.LFontNameP,arecord.LFontNameS);
end;

procedure TrpMetafilePage.DeleteObject(index:integer);
var
 i:integer;
begin
 if index<0 then
  Raise Exception.Create(SRpMetaIndexObjectOutofBounds);
 if index>FObjectCount-1 then
  Raise Exception.Create(SRpMetaIndexObjectOutofBounds);
 dec(FObjectCount);
 for i:=index to FObjectCount-1 do
 begin
  FObjects[index]:=FObjects[index+1];
 end;
end;

function TrpMetafilePage.GetObject(index:integer):TrpMetaObject;
begin
 if index<0 then
  Raise Exception.Create(SRpMetaIndexObjectOutofBounds);
 if index>FObjectCount-1 then
  Raise Exception.Create(SRpMetaIndexObjectOutofBounds);
 Result:=FObjects[index];
end;


function TRpMetafileReport.GetPageCount:integer;
begin
 Result:=FPages.count;
end;

procedure TRpMetafileReport.NewPage;
begin
 InsertPage(FPages.Count);
end;

function TRpMetafileReport.GetPage(Index:integer):TRpMetafilePage;
begin
 if index<0 then
  Raise Exception.Create(SRpMetaIndexPageOutofBounds);
 if index>FPages.Count-1 then
  Raise Exception.Create(SRpMetaIndexPageOutofBounds);
 Result:=TRpMetafilePage(FPages.Items[index]);
end;

procedure TRpMetafileReport.SetCurrentPage(index:integer);
begin
 if index<0 then
  Raise Exception.Create(SRpMetaIndexPageOutofBounds);
 if index>FPages.Count-1 then
  Raise Exception.Create(SRpMetaIndexPageOutofBounds);
 FCurrentPage:=index;
end;

procedure TRpMetafileReport.InsertPage(index:integer);
var
 FPage:TRpMetafilePage;
begin
 if index<0 then
  Raise Exception.Create(SRpMetaIndexPageOutofBounds);
 if index>FPages.Count then
  Raise Exception.Create(SRpMetaIndexPageOutofBounds);
 FPage:=TRpMetafilePage.Create;
 FPage.FMetafile:=self;
 if index=FPages.Count then
  FPages.Add(FPage)
 else
  FPages.Insert(index,FPage);
 FCurrentPage:=index;
end;

procedure TRpMetafileReport.DeletePage(index:integer);
begin
 if (index>FPages.count-1) then
  Raise Exception.Create(SRpMetaIndexPageOutofBounds);
 TObject(FPages.items[index]).free;
 FPages.Delete(index);
 if FCurrentPage<FPages.count-1 then
  FCurrentPage:=FPages.count-1;
end;

constructor TRpMetafileReport.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 critsec:=TCriticalSection.Create;
 FCurrentPage:=-1;
 FMemStream:=TMemoryStream.Create;
 FTextsFound:=TStringList.Create;
 FTextsFoundByPage:=TStringList.Create;
 FTextsFound.Sorted:=true;
 FTextsFoundByPage.Sorted:=true;

 // Standard sizes
 CustomX:=12047;
 CustomY:=17039;
 OpenDrawerBefore:=false;
 OpenDrawerAfter:=false;
 CollateCopies:=true;
 LinesPerInch:=6;

 FPages:=TList.Create;
end;

procedure TRpMetafileReport.Clear;
var
 i:integer;
begin
 FFinished:=false;
 for i:=0 to FPages.Count-1 do
 begin
  TRpMetafilePage(FPages.Items[i]).Clear;
  TRpMetafilePage(Fpages.Items[i]).Free;
 end;
 FPages.clear;


 FCurrentPage:=-1;
 FMemStream.SetSize(0);
end;

destructor TRpMetafileReport.Destroy;
begin
 FTextsFound.free;
 FTextsFoundByPage.free;
 if FReading then
 begin
  FReading:=False;
  FWaiting:=true;
  try
   FReadThread.WaitFor;
  finally
   FWaiting:=false;
  end;
 end;


 Clear;

 FPages.free;
 FMemStream.free;
 critsec.free;
 inherited Destroy;
end;




procedure TRpMetafileReport.SaveToStream(Stream:TStream;compressed:boolean=true);
{$IFDEF USEZLIB}
var
 zstream:TCompressionStream;
{$ENDIF}
begin
 // Get the time
{$IFDEF USEZLIB}
 if compressed then
 begin
  zstream:=TCompressionStream.Create(clDefault,Stream);
  try
   IntSaveToStream(zstream,Stream);
  finally
   zstream.free;
  end;
  exit;
 end;
{$ENDIF}
 IntSaveToStream(Stream,Stream);
end;

procedure TRpMetafileReport.IntSaveToStream(Stream:TStream;SaveStream:TStream);
var
 separator:integer;
 i:integer;
 acount:integer;
 ainteger:integer;
 docancel:boolean;
 ssize:Int64;
begin
 RequestPage(MAX_PAGECOUNT);
 WriteStringToStream(rpSignature,Stream);
 separator:=integer(rpFHeader);
 Stream.Write(separator,sizeof(separator));
 // Report header
 Stream.Write(PageSize,sizeof(pagesize));
 Stream.Write(CustomX,sizeof(CustomX));
 Stream.Write(CustomY,sizeof(CustomY));
 ainteger:=Integer(Orientation);
 Stream.Write(ainteger,sizeof(integer));
 Stream.Write(BackColor,sizeof(BackColor));
 Stream.Write(PaperSource,sizeof(PaperSource));
 Stream.Write(Copies,sizeof(Copies));
 Stream.Write(LinesPerInch,sizeof(LinesPerInch));
 Stream.Write(CollateCopies,sizeof(CollateCopies));
 Stream.Write(Duplex,sizeof(Duplex));
 ainteger:=Integer(PrinterSelect);
 Stream.Write(ainteger,sizeof(integer));
 ainteger:=Integer(PreviewStyle);
 Stream.Write(ainteger,sizeof(integer));
 ainteger:=Integer(PreviewWindow);
 Stream.Write(ainteger,sizeof(Integer));
 Stream.Write(OpenDrawerBefore,sizeof(OpenDrawerBefore));
 Stream.Write(OpenDrawerAfter,sizeof(OpenDrawerAfter));
 ainteger:=0;
 if FPreviewAbout then
  ainteger:=1;
 Stream.Write(ainteger,sizeof(Integer));
 ainteger:=0;
 if FPreviewMargins then
  ainteger:=1;
 Stream.Write(ainteger,sizeof(Integer));


 // Pages
 // Write pagecount
 acount:=FPages.Count;
 Stream.Write(acount,sizeof(acount));
 for i:=0 to FPages.count-1 do
 begin
  if i=0 then
  begin
   // Main stream
   if FMemStream.Size>0 then
   begin
    separator:=integer(rpFStream);
    Stream.Write(separator,sizeof(separator));
    ssize:=FMemStream.Size;
    Stream.Write(ssize,sizeof(ssize));
    FMemStream.Seek(0,soFromBeginning);
    Stream.CopyFrom(FMemStream,ssize);
   end;
  end;
  separator:=integer(rpFPage);
  Stream.Write(separator,sizeof(separator));

  TRpMetafilePage(FPages.items[i]).SaveToStream(Stream);
  if Assigned(OnWorkProgress) then
  begin
   docancel:=false;
   OnWorkProgress(Self,-1,CurrentPageCount,docancel);
   if (docancel) then
    Raise Exception.Create(SRpOperationAborted);
  end;
 end;
end;

procedure TRpMetafileReport.DoRequestData(Sender:TObject;count:integer);
begin
 if Assigned(OnRequestData) then
  OnRequestData(Sender,count);
end;

procedure TRpMetafileReport.LoadFromStream(Stream:TStream;clearfirst:boolean=true);
begin
 if clearfirst then
  Clear;
  // Get the time
 FlexStream:=TFlexStream.Create(Stream,DoRequestData,critsec);
 try
  if FlexStream.IsCompressed then
  begin
{$IFDEF USEZLIB}
   zStream:=TDeCompressionStream.Create(FlexStream);
   try
    FlexStream2:=TFlexStream.Create(zStream,nil,critsec);
    try
     IntLoadFromStream(FlexStream2);
    finally
     if not FReading then
     begin
      FlexStream2.free;
      FlexStream2:=nil;
     end;
    end;
   finally
     if not FReading then
     begin
      zStream.free;
      zstream:=nil;
     end;
   end;
{$ENDIF}
{$IFNDEF USEZLIB}
   Raise Exception.Create(SRpZLibNotSupported);
{$ENDIF}
  end
  else
  begin
   IntLoadFromStream(FlexStream);
  end;
 finally
  if not FReading then
  begin
   FlexStream.free;
   FlexStream:=nil;
  end;
 end;
end;


function IntIsMetafile(Stream:TStream):boolean;
var
 buf:array of Byte;
 bufstring:string;
 bytesread,i:integer;
begin
 Result:=false;
 SetLength(buf,RP_SIGNATURELENGTH);
 bytesread:=Stream.Read(buf[0],RP_SIGNATURELENGTH);
 if (bytesread<RP_SIGNATURELENGTH) then
  exit;
 bufstring:='';
 for i:=0 to RP_SIGNATURELENGTH-1 do
 begin
  bufstring:=bufstring+Char(buf[i]);
 end;
 if (bufstring<>rpSignature) then
 begin
  if bufstring=RpSignature2_2 then
   Result:=true;
 end
 else
  Result:=true;
end;

function IsMetafile(memstream:TMemoryStream):boolean;
{$IFDEF USEZLIB}
var
 zStream:TDeCompressionStream;
{$ENDIF}
begin
 memstream.Seek(0,soFromBeginning);
 if IsCompressed(memstream) then
 begin
{$IFDEF USEZLIB}
  memstream.Seek(0,soFromBeginning);
  zStream:=TDeCompressionStream.Create(memstream);
  try
   Result:=IntIsMetafile(zStream);
  finally
   zStream.free;
  end;
{$ENDIF}
{$IFNDEF USEZLIB}
   Raise Exception.Create(SRpZLibNotSupported);
{$ENDIF}
  end
  else
  begin
   Result:=IntIsMetafile(memstream);
  end;
end;


procedure TRpMetafileReport.IntLoadFromStream(Stream:TStream;clearfirst:boolean=true);
var
 separator:integer;
 buf:array of Byte;
 bufstring:String;
 ssize:Int64;
 bytesread:integer;
 fpage:TRpMetafilePage;
 acount:integer;
 i,ainteger:integer;
 apagesizeqt:TPageSizeQt;
 docancel:boolean;
begin
 FFinished:=false;
 // Clears the report metafile
 if clearfirst then
  Clear;
 FVersion2_2:=false;
 SetLength(buf,RP_SIGNATURELENGTH);
 bytesread:=Stream.Read(buf[0],RP_SIGNATURELENGTH);
 if (bytesread<RP_SIGNATURELENGTH) then
  Raise Exception.Create(SRpBadSignature);
 bufstring:='';
 for i:=0 to RP_SIGNATURELENGTH-1 do
 begin
  bufstring:=bufstring+Char(buf[i]);
 end;
 if (bufstring<>rpSignature) then
 begin
  if bufstring=RpSignature2_2 then
   FVersion2_2:=true
  else
   Raise Exception.Create(SRpBadSignature);
 end;
 if (sizeof(separator)<>Stream.Read(separator,sizeof(separator))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (separator<>integer(rpFHeader)) then
  Raise Exception.Create(SRpBadFileHeader);
 // Report header
 if (sizeof(pagesize)<>Stream.Read(PageSize,sizeof(pagesize))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (sizeof(CustomX)<>Stream.Read(CustomX,sizeof(CustomX))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (sizeof(CustomY)<>Stream.Read(CustomY,sizeof(CustomY))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (sizeof(integer)<>Stream.Read(ainteger,sizeof(Integer))) then
  Raise Exception.Create(SRpBadFileHeader);
 Orientation:=TRpOrientation(ainteger);
 if (sizeof(ainteger)<>Stream.Read(ainteger,sizeof(BackColor))) then
  Raise Exception.Create(SRpBadFileHeader);
 BackColor:=ainteger;
 if (sizeof(PaperSource)<>Stream.Read(PaperSource,sizeof(PaperSource))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (sizeof(Copies)<>Stream.Read(Copies,sizeof(Copies))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (sizeof(LinesPerInch)<>Stream.Read(LinesPerInch,sizeof(LinesPerInch))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (sizeof(CollateCopies)<>Stream.Read(CollateCopies,sizeof(CollateCopies))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (LinesPerInch<=0) then
  LinesPerInch:=6;
 if (sizeof(Duplex)<>Stream.Read(Duplex,sizeof(Duplex))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (sizeof(integer)<>Stream.Read(ainteger,sizeof(integer))) then
  Raise Exception.Create(SRpBadFileHeader);
 PrinterSelect:=TRpPrinterSelect(ainteger);
 if (sizeof(integer)<>Stream.Read(ainteger,sizeof(integer))) then
  Raise Exception.Create(SRpBadFileHeader);
 PreviewStyle:=TRpPreviewStyle(ainteger);
 if (sizeof(integer)<>Stream.Read(ainteger,sizeof(integer))) then
  Raise Exception.Create(SRpBadFileHeader);
 PreviewWindow:=TRpPreviewWindowStyle(ainteger);
 if (sizeof(OpenDrawerBefore)<>Stream.Read(OpenDrawerBefore,sizeof(OpenDrawerBefore))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (sizeof(OpenDrawerAfter)<>Stream.Read(OpenDrawerAfter,sizeof(OpenDrawerAfter))) then
  Raise Exception.Create(SRpBadFileHeader);
 if (sizeof(integer)<>Stream.Read(ainteger,sizeof(Integer))) then
  Raise Exception.Create(SRpBadFileHeader);
 FPreviewAbout:=true;
 if ainteger=0 then
  FPreviewAbout:=False;
 if (sizeof(integer)<>Stream.Read(ainteger,sizeof(Integer))) then
  Raise Exception.Create(SRpBadFileHeader);
 FPreviewMargins:=true;
 if ainteger=0 then
  FPreviewMargins:=False;

 // If there is no pages then end of read
 // Read pagecount
 if (sizeof(acount)<>Stream.Read(acount,sizeof(acount))) then
  Raise Exception.Create(SRpBadFileHeader);
 FIntPageCount:=acount;


 // Pages
 bytesread:=Stream.Read(separator,sizeof(separator));
 while (bytesread>0) do
 begin
  if bytesread<>sizeof(separator) then
   Raise ERpBadFileFormat.CreatePos(SrpMtPageSeparatorExpected,Stream.Position,0);
  if (separator=integer(rpFStream)) then
  begin
   ssize:=0;
   Stream.Read(ssize,sizeof(ssize));
   FMemStream.SetSize(ssize);
   FMemStream.Seek(0,soFromBeginning);
   FMemStream.CopyFrom(Stream,ssize);
   Stream.Read(separator,sizeof(separator));
  end;
  if (separator<>integer(rpFPage)) then
   Raise ERpBadFileFormat.CreatePos(SrpMtPageSeparatorExpected,Stream.Position,0);
  // New page and load from stream
  fpage:=TRpMetafilePage.Create;
  FPage.FMetafile:=self;
  FPages.Add(fpage);
  FPage.Fversion2_2:=Fversion2_2;
  FPage.FUpdatedPageSize:=false;
  FPage.FOrientation:=Orientation;
  aPageSizeqt.Indexqt:=PageSize;
  aPageSizeqt.Custom:=true;
  aPageSizeqt.CustomWidth:=CustomX;
  aPageSizeqt.Customheight:=CustomY;
  aPageSizeqt.PhysicWidth:=CustomX;
  aPageSizeqt.PhysicHeight:=CustomY;
  aPageSizeqt.PaperSource:=0;
  aPageSizeqt.ForcePaperName:='';
  aPageSizeqt.Duplex:=0;

  FPage.PageSizeqt:=apagesizeqt;
  fpage.LoadFromStream(Stream);
  ForcePaperName:=StrPas(fpage.PageSizeqt.ForcePaperName);

  if Not AsyncReading then
  begin
   if Assigned(OnWorkProgress) then
   begin
    docancel:=false;
    OnWorkProgress(Self,-1,FIntPageCount,docancel);
    if (docancel) then
     Raise Exception.Create(SRpOperationAborted);
   end;
  end;
  bytesread:=Stream.Read(separator,sizeof(separator));
  if (bytesread>0) then
  begin
   if AsyncReading then
   begin
    if bytesread<>sizeof(separator) then
     Raise ERpBadFileFormat.CreatePos(SrpMtPageSeparatorExpected,Stream.Position,0);
    if (separator<>integer(rpFPage)) then
     Raise ERpBadFileFormat.CreatePos(SrpMtPageSeparatorExpected,Stream.Position,0);
    FReadThread:=TReadThread.Create(true);
    FReadThread.Metafile:=self;
    FReadThread.Stream:=Stream;
    FReading:=true;
    FReadThread.Resume;
    break;
   end;
  end;
 end;
 if not FReading then
 begin
  FFinished:=true;
  if Assigned(OnWorkProgress) then
  begin
   docancel:=false;
   OnWorkProgress(Self,-1,FIntPageCount,docancel);
   if (docancel) then
    Raise Exception.Create(SRpOperationAborted);
  end;
 end;
 if Fpages.Count>0 then
  FCurrentPage:=0;
end;


procedure TRpMetafilePage.SaveToStream(Stream:TStream);
var
 separator:integer;
 asize:int64;
 wsize,i:integer;
 byteswrite:integer;
 abytes:array of Byte;
 intor:integer;
begin
 // Objects
 // Save all objects
 separator:=integer(rpFObject);
 Stream.Write(separator,sizeof(separator));
 Stream.Write(FMark,sizeof(FMark));
 intor:=integer(forientation);
 Stream.Write(intor,sizeof(intor));
 Stream.Write(fpagesizeqt.Indexqt,sizeof(fpagesizeqt.Indexqt));
 Stream.Write(fpagesizeqt.Custom,sizeof(fpagesizeqt.Custom));
 Stream.Write(fpagesizeqt.CustomWidth,sizeof(fpagesizeqt.CustomWidth));
 Stream.Write(fpagesizeqt.CustomHeight,sizeof(fpagesizeqt.CustomHeight));
 Stream.Write(fpagesizeqt.PhysicWidth,sizeof(fpagesizeqt.PhysicWidth));
 Stream.Write(fpagesizeqt.PhysicHeight,sizeof(fpagesizeqt.PhysicHeight));
 Stream.Write(fpagesizeqt.PaperSource,sizeof(fpagesizeqt.PaperSource));
 byteswrite:=61;
 SetLength(abytes,100);
 for i:=0 to 60 do
 begin
  abytes[i]:=byte(fpagesizeqt.ForcePaperName[i]);
 end;
 if byteswrite<>Stream.Write(abytes[0],byteswrite) then
  Raise Exception.Create(SRpErrorWritingPage);
//  ForcePaperName:array [0..60] of char;
 Stream.Write(fpagesizeqt.Duplex,sizeof(fpagesizeqt.Duplex));
 for i:=0 to 3 do
 begin
  abytes[i]:=0;
 end;
 Stream.Write(abytes[0],3);

 Stream.Write(FUpdatedPageSize,sizeof(FUpdatedPageSize));
 Stream.Write(FObjectCount,sizeof(FObjectCount));
 byteswrite:=sizeof(TRpMetaObject)*FObjectCount;
 SetLength(abytes,byteswrite);
 if byteswrite>0 then
 begin
{$IFDEF DOTNETD}
  System.Array.Copy(FObjects,abytes,byteswrite);
{$ENDIF}
{$IFNDEF DOTNETD}
  Move(FObjects[0],abytes[0],byteswrite);
{$ENDIF}
  if byteswrite<>Stream.Write(abytes[0],byteswrite) then
   Raise Exception.Create(SRpErrorWritingPage);
 end;
 wsize:=Length(FPool)*2;
 Stream.Write(wsize,sizeof(wsize));
 if wsize>0 then
 begin
  WriteWideStringToStream(FPool,Stream);
 end;
 asize:=FMemStream.Size;
 FMemStream.Seek(0,soFromBeginning);
 Stream.Write(asize,sizeof(asize));
{$IFDEF DOTNETD}
 Stream.Write(FMemStream.Memory,FMemStream.Size);
{$ENDIF}
{$IFNDEF DOTNETD}
 Stream.Write(FMemStream.Memory^,FMemStream.Size);
{$ENDIF}
end;

procedure TRpMetafilePage.LoadFromStream(Stream:TStream);
var
 separator:integer;
 bytesread,readed:integer;
 objcount:integer;
 asize:int64;
 wsize:integer;
 i:integer;
 abytes:array of Byte;
begin
 SetLength(abytes,200);
 // read the object separator
 bytesread:=Stream.Read(separator,sizeof(separator));
 if (bytesread<>sizeof(separator)) then
  Raise ERpBadFileFormat.CreatePos(SrpMtObjectSeparatorExpected,Stream.Position,0);
 if (separator<>integer(rpFObject)) then
  Raise ERpBadFileFormat.CreatePos(SrpMtObjectSeparatorExpected,Stream.Position,0);
 bytesread:=Stream.Read(FMark,sizeof(FMark));
 if (bytesread<>sizeof(FMark)) then
  Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Mark',Stream.Position,0);
 if Not FVersion2_2 then
 begin
  bytesread:=Stream.Read(separator,sizeof(separator));
  if (bytesread<>sizeof(separator)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Separator',Stream.Position,0);
  FOrientation:=TRpOrientation(separator);
  bytesread:=Stream.Read(fpagesizeqt.Indexqt,sizeof(fpagesizeqt.IndexQt));
  if (bytesread<>sizeof(fpagesizeqt.Indexqt)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' PageSize',Stream.Position,0);

  bytesread:=Stream.Read(fpagesizeqt.Custom,sizeof(fpagesizeqt.Custom));
  if (bytesread<>sizeof(fpagesizeqt.Custom)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Custom',Stream.Position,0);
  bytesread:=Stream.Read(fpagesizeqt.CustomWidth,sizeof(fpagesizeqt.CustomWidth));
  if (bytesread<>sizeof(fpagesizeqt.CustomWidth)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Custom Width',Stream.Position,0);
  bytesread:=Stream.Read(fpagesizeqt.CustomHeight,sizeof(fpagesizeqt.CustomHeight));
  if (bytesread<>sizeof(fpagesizeqt.CustomHeight)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Custom Height',Stream.Position,0);
  bytesread:=Stream.Read(fpagesizeqt.PhysicWidth,sizeof(fpagesizeqt.PhysicWidth));
  if (bytesread<>sizeof(fpagesizeqt.PhysicWidth)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Physic Width',Stream.Position,0);
  bytesread:=Stream.Read(fpagesizeqt.PhysicHeight,sizeof(fpagesizeqt.PhysicHeight));
  if (bytesread<>sizeof(fpagesizeqt.PhysicHeight)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Physic Height',Stream.Position,0);
  bytesread:=Stream.Read(fpagesizeqt.PaperSource,sizeof(fpagesizeqt.PaperSource));
  if (bytesread<>sizeof(fpagesizeqt.PaperSource)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Paper Source',Stream.Position,0);
  bytesread:=Stream.Read(abytes[0],61);
  if (61<>bytesread) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Paper name',Stream.Position,0);
  for i:=0 to bytesread-1 do
  begin
   fpagesizeqt.ForcePaperName[i]:=chr(abytes[0]);
  end;
  bytesread:=Stream.Read(fpagesizeqt.Duplex,sizeof(fpagesizeqt.Duplex));
  if (bytesread<>sizeof(fpagesizeqt.Duplex)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Duplex',Stream.Position,0);
  if (3<>Stream.Read(abytes[0],3)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' Duplex 3',Stream.Position,0);
  bytesread:=Stream.Read(FUpdatedPageSize,sizeof(FUpdatedPageSize));
  if (bytesread<>sizeof(FUpdatedPageSize)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' UpdatedPageSize',Stream.Position,0);
 end;
 bytesread:=Stream.Read(objcount,sizeof(objcount));
 if (bytesread<>sizeof(objcount)) then
  Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' ObjCount',Stream.Position,0);
 if (objcount<0) then
  Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' ObjCount<0',Stream.Position,0);
 if High(FObjects)-1<objcount then
  SetLength(FObjects,objcount+1);
 // Read then whole array
 bytesread:=objcount*sizeof(TRpMetaObject);
 SetLength(abytes,bytesread);
 if bytesread>0 then
 begin
  readed:=Stream.Read(abytes[0],bytesread);
  if (bytesread<>readed) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' ObjectArraySize',Stream.Position,0);
 {$IFDEF DOTNETD}
  System.Array.Copy(abytes,FObjects,bytesread);
 {$ENDIF}
 {$IFNDEF DOTNETD}
  Move(abytes[0],FObjects[0],bytesread);
 {$ENDIF}
 end;
 // Read string pool
 if (sizeof(wsize)<>Stream.Read(wsize,sizeof(wsize))) then
  Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' StringPoolSize',Stream.Position,0);
 if wsize<0 then
  Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' StringPoolSize<0',Stream.Position,0);
 SetLength(FPool,wsize div 2);
 SetLength(abytes,wsize);
 if wsize>0 then
 begin
{$IFDEF DOTNETD}
  if (wsize<>Stream.Read(abytes[0],wsize)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' StringPool',Stream.Position,0);
  for i:=0 to wsize div 2 do
  begin
   // Revise byte order
   FPool[i+1]:=WideChar((Integer(abytes[i+1]) shl 8)+abytes[i]);
  end;
   // System.Array.Copy(abytes,FPool,wsize);
{$ENDIF}
{$IFNDEF DOTNETD}
  if (wsize<>Stream.Read(abytes[0],wsize)) then
   Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' StringPool',Stream.Position,0);
 // Copy the pool
  Move(abytes[0],FPool[1],wsize);
{$ENDIF}
 end;
 FPoolPos:=(wsize div 2)+1;
 // The Stream
 if (sizeof(asize)<>Stream.Read(asize,sizeof(asize))) then
  Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' MemStreamSize',Stream.Position,0);
 if asize<0 then
  Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' MemStreamSize<0',Stream.Position,0);
 if asize=0 then
 begin
  FMemStream.Free;
  FMemStream:=TMemoryStream.Create;
 end
 else
  FMemStream.SetSize(asize);
 if asize>0 then
 begin
{$IFDEF DOTNETD}
  readed:=Stream.Read(FMemStream.Memory[0],asize);
  if (asize<>readed) then
{$ENDIF}
{$IFNDEF DOTNETD}
  readed:=Stream.Read(FMemStream.Memory^,asize);
  if (asize<>readed) then
{$ENDIF}
  Raise ERpBadFileFormat.CreatePos(SrpStreamErrorPage+' MemStream readed:'
   +IntToStr(readed)+'Total:'+IntToStr(asize),Stream.Position,0);
  // Seeks at the end to add objects at correct position
  FStreamPos:=FMemStream.Size;
 end;
 FObjectCount:=objcount;
end;

constructor ErpBadFileFormat.CreatePos(Msg:String;APosition,Pos2:LongInt);
begin
 inherited Create(Msg);
 FPosition:=Position;
end;


procedure TRpMetafileReport.SaveToFile(filename:string;compressed:boolean=true);
var
 fstream:TFileStream;
begin
 fstream:=TFileStream.Create(filename,fmCreate);
 try
  SaveToStream(fstream,compressed);
 finally
  fstream.free;
 end
end;

procedure TRpMetafileReport.LoadFromFile(filename:string;clearfirst:boolean=true);
begin
 IntStream:=TFileStream.Create(filename,fmOpenRead);
 try
  LoadFromStream(IntStream,clearfirst);
 finally
  if (not FReading) then
  begin
   IntStream.free;
   IntStream:=nil;
  end;
 end
end;


procedure TRpMetafileReport.DrawPageOnly(IDriver:TRpPrintDriver;index:integer);
var
 FPage:TRpMetafilePage;
begin
 FPage:=TRpMetafilePage(FPages.items[index]);
 IDriver.DrawPage(FPage);
end;


procedure TRpMetafileReport.DrawPage(IDriver:TRpPrintDriver;index:integer);
begin
 IDriver.NewDocument(self,1,false);
 try
  DrawPageOnly(IDriver,index);
  IDriver.EndPage;
  IDriver.EndDocument;
 except
  IDriver.AbortDocument;
  raise;
 end;
end;

procedure TRpMetafileReport.DrawAll(IDriver:TRpPrintDriver);
var
 i:integeR;
begin
 IDriver.NewDocument(self,1,false);
 try
  RequestPage(MAX_PAGECOUNT);
  for i:=0 to CurrentPageCount-1 do
  begin
   if i>0 then
    IDriver.NewPage(Pages[i]);
   DrawPageOnly(IDriver,i);
  end;
  IDriver.EndPage;

  IDriver.EndDocument;
 except
  IDriver.AbortDocument;
  raise;
 end;
end;

procedure TRpMetafileReport.UpdateTotalPages(alist:TList);
var
 i,index:integer;
 aobject:TTotalPagesObject;
 apage:TrpMetafilePage;
 astring:widestring;
 oldtexts:integer;
 tempstring:widestring;
begin
 for i:=0 to alist.count-1 do
 begin
  aobject:=TTotalPagesObject(alist.Items[i]);
  apage:=Pages[aobject.PageIndex];
  index:=apage.Objects[aobject.ObjectIndex].TextP;
  if Length(aobject.displayformat)>0 then
   astring:=FormatCurr(aobject.displayformat,CurrentPageCount)
  else
   astring:=IntToStr(CurrentPageCount);
//  oldtexts:=apage.Objects[aobject.ObjectIndex].TextS;
  oldtexts:=9;
  apage.FObjects[aobject.ObjectIndex].TextS:=Length(astring);
  astring:=astring+'                                      ';
  tempstring:=Copy(apage.Pool,1,index-1);
  tempstring:=tempstring+Copy(astring,1,oldtexts);
  tempstring:=tempstring+Copy(apage.Pool,index+oldtexts,Length(apage.Pool));
  apage.FPool:=tempstring;
 end;
end;

procedure TRpMetafileReport.UpdateTotalPagesPCount(alist:TList;pcount:integer);
var
 i,index:integer;
 aobject:TTotalPagesObject;
 apage:TrpMetafilePage;
 astring:widestring;
 oldtexts:integer;
 tempstring:widestring;
begin
 for i:=0 to alist.count-1 do
 begin
  aobject:=TTotalPagesObject(alist.Items[i]);
  apage:=Pages[aobject.PageIndex];
  index:=apage.Objects[aobject.ObjectIndex].TextP;
  if Length(aobject.displayformat)>0 then
   astring:=FormatCurr(aobject.displayformat,PCount)
  else
   astring:=IntToStr(PCount);
//  oldtexts:=apage.Objects[aobject.ObjectIndex].TextS;
  oldtexts:=9;
  apage.FObjects[aobject.ObjectIndex].TextS:=Length(astring);
  astring:=astring+'                                      ';
  tempstring:=Copy(apage.Pool,1,index-1);
  tempstring:=tempstring+Copy(astring,1,oldtexts);
  tempstring:=tempstring+Copy(apage.Pool,index+oldtexts,Length(apage.Pool));
  apage.FPool:=tempstring;
 end;
end;

procedure TRpMetafileReport.Assign(Source:TPersistent);
var
 memstream:TMemoryStream;
begin
 if Not (Source is TRpMetafileReport) then
 begin
  inherited Assign(Source);
  exit;
 end;
 memstream:=TMemoryStream.Create;
 try
  TRpMetafileReport(Source).SaveToStream(memstream);
  memstream.Seek(0,soFromBeginning);
  LoadFromStream(memstream);
 finally
  memstream.free;
 end;
end;

{function CalcTextExtent(adriver:IRpPrintDriver;maxextent:TPoint;obj:TRpTextObject):integer;
var
 newextent:TPoint;
 currentPos,lasttested:Integer;
 delimiters:string;
 originalstring:WideString;
begin
 delimiters:=' '+'.'+','+'-'+'/'+'\'+'='+')'+'('+'*'+'+'+'-';
 currentpos:=Length(obj.Text);
 originalstring:=obj.Text;
 obj.Text:=Copy(originalstring,1,currentpos);
 newextent:=maxextent;
 adriver.TextExtent(obj,newextent);

 lasttested:=CurrentPos;
 // Speed enhacement to cut at least lot of size testing
 while (newextent.Y>maxextent.Y) do
 begin
  currentpos:=currentpos div 2;
  while currentpos>0 do
  begin
   Dec(currentpos);
   if currentpos<1 then
    break;
   if isdelimiter(delimiters,obj.Text,currentpos) then
    break;
  end;

  if currentpos<1 then
   break;
  obj.Text:=Copy(originalstring,1,currentpos);
  newextent:=maxextent;
  adriver.TextExtent(obj,newextent);
  if newextent.Y<=maxextent.Y then
   break
  else
   lasttested:=currentpos;
 end;
 currentpos:=lasttested;
 obj.Text:=Copy(originalstring,1,currentpos);
 newextent:=maxextent;
 adriver.TextExtent(obj,newextent);
 while newextent.Y>maxextent.Y do
 begin
  while currentpos>0 do
  begin
   Dec(currentpos);
   if isdelimiter(delimiters,obj.Text,currentpos) then
    break;
  end;

  if currentpos<1 then
   break;
  obj.Text:=Copy(originalstring,1,currentpos);
  newextent:=maxextent;
  adriver.TextExtent(obj,newextent);
 end;
 if currentpos<1 then
  Result:=Length(obj.Text)
 else
 begin
  Result:=CurrentPos;
 end;
end;
}

function isadelimiter(achar:WideChar):Boolean;
const
 delimiters:string=' .,-/\=)(*,-'+#10;
var
 nchar:Char;
 i:integer;
begin
 Result:=false;
 nchar:=Char(achar);
 for i:=1 to Length(delimiters) do
 begin
  if nchar=delimiters[i] then
  begin
   Result:=true;
   break;
  end;
 end;
end;

function CalcTextExtent(adriver:TRpPrintDriver;maxextent:TPoint;obj:TRpTextObject):integer;
var
 newextent:TPoint;
 currentPos,lasttested,oldcurrentpos:Integer;
// delimiters:string;
 originalstring:WideString;
 minpos,maxpos:integer;
begin
// delimiters:=' '+'.'+','+'-'+'/'+'\'+'='+')'+'('+'*'+'+'+'-'+#10;
 currentpos:=Length(obj.Text);
 originalstring:=Copy(obj.Text,1,currentpos);
 obj.Text:=Copy(originalstring,1,currentpos);
 newextent:=maxextent;
 adriver.TextExtent(obj,newextent);

 lasttested:=CurrentPos;
 minpos:=0;
 maxpos:=CurrentPos;
 oldcurrentpos:=0;
 // Speed enhacement to cut at least lot of size testing
 while (minpos<maxpos) do
 begin
  // The first test is performed
  CurrentPos:=(minpos+maxpos) div 2;
  // Word Break
  while currentpos>1 do
  begin
   Dec(currentpos);
   if isadelimiter(originalstring[currentpos]) then
    break;
  end;
  if oldcurrentpos=currentpos then
   break;
  oldcurrentpos:=currentpos;
  obj.Text:=Copy(originalstring,1,currentpos);
  newextent:=maxextent;
  adriver.TextExtent(obj,newextent);
  if newextent.Y<=maxextent.Y then
   minpos:=currentpos
  else
  begin
   lasttested:=currentpos;
   maxpos:=lasttested;
  end;
 end;
 currentpos:=lasttested;
 obj.Text:=Copy(originalstring,1,currentpos);
 newextent:=maxextent;
 adriver.TextExtent(obj,newextent);
 while newextent.Y>maxextent.Y do
 begin
  while currentpos>0 do
  begin
   Dec(currentpos);
   if currentpos<1 then
    break;
   if isadelimiter(obj.Text[currentpos]) then
    break;
  end;

  if currentpos<1 then
   break;
  obj.Text:=Copy(originalstring,1,currentpos);
  newextent:=maxextent;
  adriver.TextExtent(obj,newextent);
 end;
 if currentpos<1 then
  Result:=Length(obj.Text)
 else
 begin
  Result:=CurrentPos;
 end;
end;


procedure TRpMetafileReport.PageRange(frompage,topage:integer);
var
 newpagecount:integer;
begin
 // Delete to first page
 newpagecount:=topage-frompage+1;
 if newpagecount=0 then
 begin
  Clear;
  exit;
 end;
 while frompage>1 do
 begin
  DeletePage(0);
  Dec(frompage);
  if currentpagecount<1 then
   break;
 end;
 while newpagecount<currentPageCount do
 begin
  DeletePage(currentPageCount-1);
 end;
end;

{$IFDEF MSWINDOWS}
{$IFNDEF DOTNETD}
procedure  MetafileToExe(metafile:TRpMetafileReport;filename:String);
var
 tempfile:String;
begin
 tempfile:=RpTempFileName;
 tempfile:=changeFileExt(tempfile,'.rpmf');
 metafile.SaveToFile(tempfile);
 try
  ReportFileToExe(tempfile,filename,true,true,true,true);
 finally
  DeleteFile(tempfile);
 end;
end;
{$ENDIF}
{$ENDIF}

procedure TRpMetafileReport.Finish;
begin
 FFinished:=true;
end;


function TRpMetafileReport.RequestPage(pageindex:integer):boolean;
begin
 if (CurrentPageCount>pageindex) then
 begin
  Result:=FFinished;
  exit;
 end;
 if Assigned(OnRequestPage) then
  FFinished:=OnRequestPage(pageindex);
 if (FReading) then
 begin
  while ((FReading) AND (CurrentPageCount<=pageindex)) do
  begin
   FWaiting:=true;
   try
{$IFDEF MSWINDOWS}
    WaitForSingleObject(FReadThread.Handle,100);
{$ENDIF}
{$IFDEF LINUX}
    Sleep(100);
{$ENDIF}
   finally
    FWaiting:=false;
   end;
  end;
 end;
 Result:=FFinished;
end;

procedure TRpMetafileReport.WorkProgress(Sender:TObject;records,pagecount:integer;var docancel:boolean);
begin
 if Assigned(OnWorkProgress) then
  OnWorkProgress(self,records,pagecount,docancel);
end;


procedure TRpMetaFileReport.WorkAsyncError(amessage:string);
begin
 if Assigned(OnWorkAsyncError) then
  OnWorkAsyncError(amessage);
end;

procedure TRpMetaFileReport.StopWork;
begin
 if (FReading) then
 begin
  FReading:=false;
  if Assigned(FReadThread) then
  begin
   AbortingThread:=true;
   FreadThread.Terminate();
   FReadThread:=nil;
  end;
 end;
 if Assigned(OnStopWork) then
  OnStopWork;
end;

procedure TFlexStream.ReadBuffer;
var
 readed:integer;
begin
 if Assigned(FOnRequestData) then
  FOnRequestData(Self,BUFFER_FLEX_SIZE);
 FBuffer.SetSize(0);
 FLastReadCount:=0;
 while (FLastReadCount<BUFFER_FLEX_SIZE) do
 begin
  if assigned(critsec) then
   critsec.enter;
  readed:=FStream.Read(FBuf[0],BUFFER_FLEX_SIZE-FLastReadCount);
  if assigned(critsec) then
   critsec.leave;
  FLastReadCount:=FLastReadCount+readed;
  if readed=0 then
   break;
  FBuffer.Write(FBuf[0],readed);
 end;
 FBuffer.Seek(0,soFromBeginning);
 FInternalPosition:=0;
 if (FLastReadCount=0) then
  FEof:=true;
end;

constructor TFlexStream.Create(AStream:TStream;OnRequestData:TOnRequestData;criticalsec:TCriticalSection);
begin
 critsec:=criticalsec;
 FOnRequestData:=OnRequestData;
 FIntStream:=TMemoryStream.create;
 FBuffer:=TMemoryStream.Create;
// FBuffer.SetSize(BUFFER_FLEX_SIZE);
 FStream:=AStream;
 ReadBuffer;
 if FLastReadCount>0 then
 begin
  FIsCompressed:=(PAnsiChar(FBuffer.Memory)^='x');
 end;
end;

destructor TFlexStream.Destroy;
begin
 FBuffer.free;
 FIntStream.free;
 inherited Destroy;
end;

function TFlexStream.Read(var Buffer; Count: Longint): Longint;
var
 readcount,readed:integer;
begin
 if FEof then
 begin
  Result:=0;
  exit;
 end;
 readcount:=0;
 if FIntStream.Size<Count then
  FIntStream.SetSize(Count);
 FIntStream.Seek(0,soFromBeginning);
 while not FEof do
 begin
  while readcount<Count do
  begin
   if ((Count-readcount)<(FLastReadCount-FInternalPosition)) then
   begin
    readed:=FBuffer.Read(FBuf[0],Count-readcount);
    FIntStream.Write(FBuf[0],readed);
    FInternalPosition:=FInternalPosition+readed;
   end
   else
   begin
    readed:=FBuffer.Read(FBuf[0],Count);
    FIntStream.Write(FBuf[0],readed);
    ReadBuffer;
   end;
   readcount:=readcount+readed;
   if FEof then
    break;
  end;
  if (readcount>=Count) then
   break;
 end;
 FIntStream.Seek(0,soFromBeginning);
 FIntStream.Read(Buffer,readcount);
 Result:=readcount;
end;

function TFlexStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
 if ((offset=0) and (origin=1)) then
  Result:=FPosition
 else
  Result:=0;
end;

function TFlexStream.Write(const Buffer; Count: Longint): Longint;
begin
 Result:=0;
end;

procedure TReadThread.Execute;
var
 bytesread:integer;
 separator:integer;
 fpage:TRpMetafilePage;
 apagesizeqt:TPageSizeQt;
begin
 try
 // Pages
 bytesread:=sizeof(separator);
 separator:=integer(rpFPage);
 while (bytesread>0) do
 begin
  if bytesread<>sizeof(separator) then
   Raise ERpBadFileFormat.CreatePos(SrpMtPageSeparatorExpected,Stream.Position,0);
  if (separator<>integer(rpFPage)) then
   Raise ERpBadFileFormat.CreatePos(SrpMtPageSeparatorExpected,Stream.Position,0);
  // New page and load from stream
  fpage:=TRpMetafilePage.Create;
  FPage.FMetafile:=metafile;
  FPage.Fversion2_2:=metafile.Fversion2_2;
  FPage.FUpdatedPageSize:=false;
  FPage.FOrientation:=metafile.Orientation;
  aPageSizeqt.Indexqt:=metafile.PageSize;
  aPageSizeqt.Custom:=true;
  aPageSizeqt.CustomWidth:=metafile.CustomX;
  aPageSizeqt.Customheight:=metafile.CustomY;
  aPageSizeqt.PhysicWidth:=metafile.CustomX;
  aPageSizeqt.PhysicHeight:=metafile.CustomY;
  aPageSizeqt.PaperSource:=0;
  aPageSizeqt.ForcePaperName:='';
  aPageSizeqt.Duplex:=0;

  FPage.PageSizeqt:=apagesizeqt;
  fpage.LoadFromStream(Stream);
  metafile.FPages.Add(fpage);
  if not metafile.FWaiting then
  begin
   if Assigned(metafile.OnWorkProgress) then
     Synchronize(Progress);
  end;
  if not metafile.FReading then
   break;
  bytesread:=Stream.Read(separator,sizeof(separator));
 end;
  metafile.FReading:=false;
  metafile.FFinished:=true;
  if not metafile.FWaiting then
  begin
   if Assigned(metafile.OnWorkProgress) then
     Synchronize(Progress);
  end;
  if Assigned(metafile.IntStream) then
  begin
   metafile.IntStream.Free;
   metafile.IntStream:=nil;
  end;
  if Assigned(metafile.zStream) then
  begin
   metafile.zStream.free;
   metafile.zstream:=nil;
  end;
 except
  on E:Exception do
  begin
   metafile.FReading:=false;
   metafile.FFinished:=true;
   if Assigned(metafile.IntStream) then
   begin
    metafile.IntStream.Free;
    metafile.IntStream:=nil;
   end;
   if Assigned(metafile.zStream) then
   begin
    metafile.zStream.free;
    metafile.zstream:=nil;
   end;
   errormessage:=E.Message;
   // AsyncWorkError
   if not metafile.FWaiting then
    if Assigned(metafile.OnWorkAsyncError) then
     Synchronize(ShowError);
  end;
 end;
end;

procedure TReadThread.Progress;
var
 docancel:boolean;
begin
 docancel:=false;
 if Assigned(metafile.OnWorkProgress) then
  metafile.OnWorkProgress(metafile,0,metafile.FIntPageCount,docancel);
 if docancel then
  metafile.FReading:=false;
end;

procedure TReadThread.ShowError;
begin
 if Assigned(metafile.OnWorkAsyncError) then
  metafile.OnWorkAsyncError(errormessage);
end;

function TrpMetaFileReport.IsFound(page:TRpMetafilePage;objectindex:integer):boolean;
var
 tosearch:string;
begin
 if not didsearch then
 begin
  Result:=false;
  exit;
 end;
 tosearch:=FormatFloat('0000000000000',Integer(page))+
      FormatFloat('0000000000',objectindex);
 Result:=FTextsFound.IndexOf(tosearch)>=0;
end;

function TrpMetaFileReport.NextPageFound(pageindex:integer):integer;
var
 tosearch:string;
 index:integer;
begin
 if not didsearch then
 begin
  Result:=0;
  exit;
 end;
 tosearch:=FormatFloat('0000000000',pageindex);
 index:=FTextsFoundByPage.IndexOf(tosearch);
 if (index>=FTextsFoundByPage.Count-1) then
 begin
  Result:=0;
  if FTextsFoundByPage.Count>0 then
  begin
  Result:=StrToInt(FTextsFoundByPage[0]);
  end;
 end
 else
 begin
  Result:=StrToInt(FTextsFoundByPage[index+1]);
 end;
end;

procedure TrpMetaFileReport.DoSearch(avalue:string);
var
 i:integer;
 j:integer;
 page:TRpMetafilePage;
 atext:string;
 foundinpage:boolean;
begin
 avalue:=UpperCase(avalue);
 RequestPage(MAX_PAGECOUNT);
 DidSearch:=true;
 FTextsFound.Clear;
 FTextsFoundByPage.Clear;
 if Length(avalue)<1 then
  exit;
 for i:=0 to CurrentPageCount-1 do
 begin
  page:=Pages[i];
  foundinpage:=false;
  for j:=0 to page.ObjectCount-1 do
  begin
   if page.Objects[j].Metatype=rpMetaText then
   begin
    atext:=UpperCase(page.GetText(page.Objects[j]));
    if (Pos(avalue,atext)>0) then
    begin
     FTextsFound.Add(FormatFloat('0000000000000',Integer(page))+
      FormatFloat('0000000000',j));
     foundinpage:=true;
    end;
   end;
   if foundinpage then
    FTextsFoundByPage.Add(FormatFloat('0000000000',i));
  end;
 end;
end;

procedure TRpPrintDriver.FilterImage(memstream:TMemoryStream);
begin

end;


end.
