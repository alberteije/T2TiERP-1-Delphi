{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rptextdriver                                    }
{       TRpTextDriver: Printer driver to                }
{       generate plain text or dot matrix               }
{       prepared documents                              }
{       Limitations:                                    }
{       - Only one size/step for each line              }
{       will obtain the size from the first text        }
{       of that line                                    }
{       - Will overwrite text in same position as       }
{       designed a line can not have more than one      }
{       character in the same position                  }
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

unit rptextdriver;

interface

{$I rpconf.inc}

uses Classes,Sysutils,
{$IFDEF USEVARIANTS}
 Types,
{$ENDIF}
{$IFDEF MSWINDOWS}
 Windows,
{$ENDIF}
{$IFNDEF FORWEBAX}
 rpbasereport,rpreport,
{$ENDIF}
 rptypes,rpmetafile,
 rpmunits,rpmdconsts,rpmdcharttypes;

const
 DEFAULT_LINESPERINCH=600;
type
 TRpPrintLine=record
  FontStep:TRpFontStep;
  Attributes:TStringList;
  red:boolean;
  Value:String;
 end;

 TRpAttribObject=class(TObject)
 public
  fontstyle:Integer;
  size:Integer;
  Position:Integer;
 end;

 TRpTextDriver=class(TRpPrintDriver)
  private
   selectedprinter:TRpPrinterSelect;
   FOrientation:TRpOrientation;
   FPageWidth,FPageHeight:integer;
   FFullPlain:Boolean;
   FLinesPerInch:Integer;
   FLines:array of TRpPrintLine;
   FLineInfo:array of TRpLineInfo;
   FLineInfoMaxItems:integer;
   FLineInfoCount:integer;
   FOemConvert:Boolean;
   FPlainText:Boolean;
   escapecodes:array [Low(TPrinterRawOp)..High(TPrinterRawOp)] of String;
   allowedsizes:array [Low(TRpFontStep)..High(TRpFontStep)] of Boolean;
   PageQt:Integer;
   FPrinterDriver:TRpPrinterEscapeStyle;
   FPrinterDriverName:String;
   FForceDriverName:String;
   masterselect,limitedmaster,condensedmaster:boolean;
   DrawerBefore,DrawerAfter:Boolean;
   master10,master12,mastercond,masterwide,masterbold,masteritalic,masterunderline:Byte;
   function GetLineIndex(posy:integer):integer;
{$IFNDEF FORWEBAX}
   procedure RepProgress(Sender:TRpBaseReport;var docancel:boolean);
{$ENDIF}
   procedure RecalcSize;
   procedure CalculateTextExtent(text:WideString;var Rect:TRect;
    WordBreak:Boolean;singleline:Boolean;fontstep:TRpFontStep);
   procedure NewLineInfo(info:TRpLineInfo);
   procedure TextRect(ARect: TRect; Text: string;
                       Alignment: integer; Clipping: boolean;
                       Wordbreak:boolean;RightToLeft:Boolean;fontstep:TRpFontStep;fontstyle:integer;red:Boolean);
   procedure DoTextOut(X, Y: Integer; const Text: string;LineWidth:Integer;
    FontStep:TRpFontStep;RightToLeft:Boolean;fontstyle:integer;red:Boolean);
   function GetColumnNumber(posx:integer;FontStep:TRpFontStep):integer;
   function GetBlankLine(FontStep:TRpFontStep):String;
   procedure WriteCurrentPage(cutclearlines:Boolean);
   function EnCodeLine(Line:TRpPrintLine;index:integer):String;
   function FindEscapeStep(FontStep:TRpFontStep;red:Boolean):String;
   function FindEscapeStyle(fontstyle:integer;FontStep:TRpFontStep):String;
   function NearestFontStep(FontStep:TRpFontStep):TRpFontStep;
   procedure UpdatePrinterConfig;
   procedure FillEspcapes(FPrinterDriverName:String);
   procedure WritePageSize;
  public
   LoadOemConvert:Boolean;
   MemStream:TMemoryStream;
   constructor Create;
   destructor Destroy;override;
   procedure NewDocument(report:TrpMetafileReport;hardwarecopies:integer;
    hardwarecollate:boolean);override;
   procedure EndDocument;override;
   procedure AbortDocument;override;
   procedure NewPage(metafilepage:TRpMetafilePage);override;
   procedure EndPage;override;
   procedure DrawObject(page:TRpMetaFilePage;obj:TRpMetaObject);override;
   procedure DrawChart(Series:TRpSeries;ametafile:TRpMetaFileReport;posx,posy:integer;achart:TObject);override;
   procedure DrawPage(apage:TRpMetaFilePage);override;
   function AllowCopies:boolean;override;
   function GetPageSize(var PageSizeQt:Integer):TPoint;override;
   function SetPagesize(PagesizeQt:TPageSizeQt):TPoint;override;
   procedure TextExtent(atext:TRpTextObject;var extent:TPoint);override;
   procedure GraphicExtent(Stream:TMemoryStream;var extent:TPoint;dpi:integer);override;
   procedure SetOrientation(Orientation:TRpOrientation);override;
   procedure SelectPrinter(printerindex:TRpPrinterSelect);override;
   function SupportsCopies(maxcopies:integer):boolean;override;
   function SupportsCollation:boolean;override;
   property LinesPerInch:Integer read FLinesPerInch write FLinesPerInch;
   property PlainText:Boolean read FPlainText write FPlainText default false;
   property FullPlain:Boolean read FFullPlain write FFullPlain default false;
   property OemConvert:Boolean read FOemConvert write FOemConvert default false;
   property ForceDriverName:String read FForceDriverName write FForceDriverName;
   function GetFontDriver:TRpPrintDriver;override;
  end;


procedure SaveMetafileToTextFile(metafile:TRpMetafileReport;
 afilename:String);
procedure SaveMetafileToText(metafile:TRpMetafileReport;
 Stream:TStream);
procedure SaveMetafileRangeToText(metafile:TRpMetafileReport;
 allpages:boolean;frompage,topage,copies:integer;Stream:TStream);
procedure SaveMetafileRangeToFile(metafile:TRpMetafileReport;
 allpages:boolean;frompage,topage,copies:integer;filename:String);

{$IFNDEF FORWEBAX}
function PrintReportToText(report:TRpReport;Caption:string;progress:boolean;
     allpages:boolean;frompage,topage,copies:integer;
     filename:string;collate:boolean;oemconvert:boolean;forcedrivername:String):Boolean;

function PrintReportToStream(report:TRpReport;Caption:string;progress:boolean;
     allpages:boolean;frompage,topage,copies:integer;
     stream:TStream;collate:Boolean;oemconvert:boolean;forcedrivername:string):Boolean;
{$ENDIF}

implementation

uses Math;

const
 AlignmentFlags_SingleLine=64;
 AlignmentFlags_AlignHCenter = 4 { $4 };
 AlignmentFlags_AlignHJustify = 1024 { $400 };
 AlignmentFlags_AlignTop = 8 { $8 };
 AlignmentFlags_AlignBottom = 16 { $10 };
 AlignmentFlags_AlignVCenter = 32 { $20 };
 AlignmentFlags_AlignLeft = 1 { $1 };
 AlignmentFlags_AlignRight = 2 { $2 };



constructor TRpTextDriver.Create;
var
 i:TPrinterRawOp;
 j:TRpFontStep;
begin
 inherited Create;
 master10:=0;
 master12:=1;
 mastercond:=4;
 masterwide:=32;
 masterbold:=8;
 masteritalic:=64;
 masterunderline:=128;
 LoadOemConvert:=true;
 PageQt:=0;
 FPageWidth:= 11904;
 FPageHeight:= 16836;
 MemStream:=TMemoryStream.Create;
 FLinesPerInch:=DEFAULT_LINESPERINCH;
 selectedprinter:=pRpDefaultPrinter;
 SetLength(FLineInfo,CONS_MINLINEINFOITEMS);
 FLineInfoMaxItems:=CONS_MINLINEINFOITEMS;
 for i:=Low(TPrinterRawOp) to High(TPrinterRawOp) do
 begin
  escapecodes[i]:='';
 end;
 for j:=Low(TRpFontStep) to High(TRpFontStep) do
 begin
  i:=TPrinterRawOp(Ord(rpescape20cpi)+Ord(j));
  allowedsizes[j]:=Length(escapecodes[i])>0;
 end;
 RecalcSize;
 FPrinterDriverName:='PLAIN';
end;

procedure FreeObjects(FLines:TStringList);
var
 i:integer;
begin
 for i:=0 to FLines.Count-1 do
 begin
  FLines.Objects[i].free;
 end;
end;

destructor TRpTextDriver.Destroy;
var
 i:integer;
begin
 MemStream.Free;
 for i:=0 to high(FLines) do
 begin
  FreeObjects(FLines[i].Attributes);
  FLines[i].Attributes.free;
  FLines[i].Attributes:=nil;
 end;
 SetLength(FLines,0);
end;

function TRpTextDriver.NearestFontStep(FontStep:TRpFontStep):TRpFontStep;
var
 maxallowed:TRpFontStep;
 i:TRpFontStep;
begin
 maxallowed:=rpcpi10;
 for i:=Low(TRpFontStep) to High(TRpFontStep) do
 begin
  if allowedsizes[i] then
  begin
   maxallowed:=i;
   break;
  end;
 end;
 Result:=maxallowed;
 i:=FontStep;
 while i>maxallowed do
 begin
  if allowedsizes[i] then
  begin
   Result:=i;
   break;
  end;
  dec(i);
 end;
end;


function TRpTextDriver.SupportsCollation:boolean;
begin
 Result:=false;
end;

function TRpTextDriver.SupportsCopies(maxcopies:integer):boolean;
begin
 Result:=false;
end;

procedure TRpTextDriver.NewDocument(report:TrpMetafileReport;hardwarecopies:integer;
   hardwarecollate:boolean);
var
 sizeqt:TPageSizeQt;
 astring:String;
begin
 LinesPerInch:=report.LinesPerInch;
 DrawerBefore:=report.OpenDrawerBefore;
 DrawerAfter:=report.OpenDrawerAfter;
 MemStream.free;
 MemStream:=TMemoryStream.Create;
 FPageWidth:=report.CustomX;
 FPageHeight:=report.CustomY;
 selectedprinter:=report.PrinterSelect;
 UpdatePrinterConfig;
 WriteStringToStream(escapecodes[rpescapeinitprinter],MemStream);
 // Set line spacing
 if FLinesPerInch=600 then
  WriteStringToStream(escapecodes[rplinespace6],MemStream)
 else
 if FLinesPerInch=800 then
  WriteStringToStream(escapecodes[rplinespace8],MemStream)
 else
 begin
  if ((Length(escapecodes[rplinespace7_72])>0) AND (FLinesPerInch=972)) then
  begin
   WriteStringToStream(escapecodes[rplinespace7_72],MemStream)
  end
  else
  begin
   if (Length(escapecodes[rplinespacen_216])>0) then
   begin
    astring:=escapecodes[rplinespacen_216];
    astring:=astring+Chr(Round(1/(FLinesPerInch/100)*216));
    WriteStringToStream(astring,MemStream);
   end
   else
   if (Length(escapecodes[rplinespacen_180])>0) then
   begin
    astring:=escapecodes[rplinespacen_180];
    astring:=astring+Chr(Round(1/(FLinesPerInch/100)*180));
    WriteStringToStream(astring,MemStream);
   end
   else
   if (Length(escapecodes[rplinespacen_60])>0) then
   begin
    astring:=escapecodes[rplinespacen_60];
    astring:=astring+Chr(Round(1/(FLinesPerInch/100)*60));
    WriteStringToStream(astring,MemStream);
   end;
  end
 end;
 if DrawerBefore then
  WriteStringToStream(escapecodes[rpescapepulse],MemStream);
 // Set page size
 if report.PageSize<0 then
 begin
  sizeqt.Custom:=True;
  sizeqt.CustomWidth:=report.CustomX;
  sizeqt.CustomHeight:=report.CustomY;
 end
 else
 begin
  sizeqt.Indexqt:=report.PageSize;
  sizeqt.CustomWidth:=Round(PageSizeArray[sizeqt.Indexqt].Width/1000*TWIPS_PER_INCHESS);
  sizeqt.CustomHeight:=Round(PageSizeArray[sizeqt.Indexqt].Height/1000*TWIPS_PER_INCHESS);
 end;
 SetPagesize(sizeqt);

 WritePageSize;
end;

procedure TRpTextDriver.EndDocument;
var
 cutclearlines:Boolean;
begin
 cutclearlines:=false;
 // Write the last page and the tear off
 if ((FPrinterDriverName='EPSONTMU210') or
   (FPrinterDriverName='EPSONTMU210CUT') or
   (FPrinterDriverName='EPSONTM88II') or
   (FPrinterDriverName='EPSONTM88IICUT')) then
  cutclearlines:=true;
 WriteCurrentPage(cutclearlines);

 WriteStringToStream(escapecodes[rpescapeendprint],MemStream);
 // Tear off
 WriteStringToStream(escapecodes[rpescapetearoff],MemStream);
 // MemStream.Write;
 if DrawerAfter then
  WriteStringToStream(escapecodes[rpescapepulse],MemStream);
 MemStream.Seek(0,soFromBeginning);
end;

procedure TRpTextDriver.AbortDocument;
begin
 MemStream.free;
 MemStream:=TMemoryStream.Create;
end;

procedure TRpTExtDriver.NewPage(metafilepage:TRpMetafilePage);
begin
 // Writes the page to the stream
 WriteCurrentPage(false);
 // Recalculate page size
 if metafilepage.UpdatedPageSize then
 begin
  FPageWidth:=metafilepage.PageSizeqt.PhysicWidth;
  FPageHeight:=metafilepage.PageSizeqt.PhysicHeight;
 end;
 // Reinitialize the page
 RecalcSize;
 if metafilepage.UpdatedPageSize then
 begin
  WritePageSize;
 end;
end;


procedure TRpTextDriver.TextExtent(atext:TRpTextObject;var extent:TPoint);
var
 singleline:boolean;
 rect:TRect;
 fontstep:TRpFontStep;
 maxextent:TPoint;
begin
 if atext.FontRotation<>0 then
  exit;
 if atext.CutText then
 begin
  maxextent:=extent;
 end;

 // single line
 singleline:=(atext.Alignment AND AlignmentFlags_SingleLine)>0;
 fontstep:=FontSizeToStep(atext.FontSize,atext.PrintStep);

 Rect.Left:=0;
 Rect.Top:=0;
 Rect.Bottom:=0;
 Rect.Right:=extent.X;
 CalculateTextExtent(atext.Text,Rect,atext.WordWrap,singleline,fontstep);

 extent.X:=Rect.Right;
 extent.Y:=Rect.Bottom;
 if (atext.CutText) then
 begin
  if maxextent.Y<extent.Y then
   extent.Y:=maxextent.Y;
 end;

end;


procedure TRpTextDriver.EndPage;
begin
 // Nothing to do
end;


function TRpTextDriver.GetLineIndex(posy:integer):integer;
var
 amax:integer;
begin
 Result:=0;
 if FPageheight<=0 then
  exit;
 aMax:=High(Flines);
 // Patch provided by Hadyatmo Ang (h4o80@yahoo.com)
 Result:=Round(posy/FPageheight*(amax+1));
 // Original line
// Result:=Round(posy/FPageheight*(amax));
 if Result<0 then
  Result:=0;
 if Result>aMax then
  Result:=aMax;
end;

procedure TRpTextDriver.DrawObject(page:TRpMetaFilePage;obj:TRpMetaObject);
var
 posx,posy:integer;
 rec:TRect;
 aalign:integer;
 astring:String;
 fontstep:TrpFontStep;
 red:Boolean;
begin
 posx:=obj.Left;
 posy:=obj.Top;
 // only text is supported
 case obj.Metatype of
  rpMetaText:
   begin
    aalign:=obj.Alignment;
    rec.Left:=posx;
    rec.Top:=posy;
    rec.Right:=posx+round(obj.Width);
    rec.Bottom:=posy+round(obj.Height);
    astring:=page.GetText(Obj);
    fontstep:=FontSizeToStep(obj.FontSize,obj.PrintStep);
    red:=IsRedColor(obj.FontColor);
    TextRect(rec,astring,aalign,obj.cuttext,
    obj.WordWrap,obj.RightToLeft,fontstep,obj.FontStyle,red);
   end;
 end;
end;

procedure TRpTextDriver.DrawPage(apage:TRpMetaFilePage);
var
 j:integer;
begin
 for j:=0 to apage.ObjectCount-1 do
 begin
  DrawObject(apage,apage.Objects[j]);
 end;
end;

function TRpTextDriver.AllowCopies:boolean;
begin
 Result:=false;
end;

function TRpTextDriver.GetPageSize(var PageSizeQt:Integer):TPoint;
begin
 PageSizeQt:=PageQt;
 Result.X:=FPageWidth;
 Result.Y:=FPageHeight;
end;

function TRpTextDriver.SetPagesize(PagesizeQt:TPageSizeQt):TPoint;
var
 newwidth,newheight:integer;
begin
 // Sets the page size for the pdf file, first if it's a qt page
 PageQt:=PageSizeQt.indexqt;
 if PagesizeQt.Custom then
 begin
  PageQt:=-1;
  newwidth:=PagesizeQt.CustomWidth;
  newheight:=PagesizeQt.CustomHeight;
 end
 else
 begin
  newWidth:=Round(PageSizeArray[PagesizeQt.Indexqt].Width/1000*TWIPS_PER_INCHESS);
  newheight:=Round(PageSizeArray[PagesizeQt.Indexqt].Height/1000*TWIPS_PER_INCHESS);
 end;
 if FOrientation=rpOrientationLandscape then
 begin
  FPageWidth:=NewHeight;
  FPageHeight:=NewWidth;
 end
 else
 begin
  FPageWidth:=NewWidth;
  FPageHeight:=NewHeight;
 end;
 Result.X:=FPageWidth;
 Result.Y:=FPageHeight;
 RecalcSize;
end;

procedure TRpTextDriver.RecalcSize;
var
 i:integer;
 numberoflines:integer;
begin
 for i:=0 to high(FLines) do
 begin
  FreeObjects(FLines[i].Attributes);
  FLines[i].Attributes.free;
  FLines[i].Attributes:=nil;
 end;
 if LinesPerInch<0 then
  Raise Exception.Create(SRpLinesPerInchIncorrect);
 numberoflines:=Round(twipstoinchess(FPageHeight)*(FLinesPerInch/100));
 SetLength(FLines,numberoflines);
 for i:=0 to high(FLines) do
 begin
  FLines[i].FontStep:=rpcpi10;
  FLines[i].Value:='';
  FLines[i].Attributes:=TStringList.Create;
  FLines[i].Attributes.Sorted:=true;
 end;
end;

procedure TRpTextDriver.SetOrientation(Orientation:TRpOrientation);
var
 atemp:Integer;
begin
 if Orientation=FOrientation then
  exit;
 if Orientation=rpOrientationDefault then
  exit;
 if Orientation=rpOrientationPortrait then
 begin
  FOrientation:=Orientation;
 end
 else
 begin
  atemp:=FPageWidth;
  FPageWidth:=FPageHeight;
  FPageHeight:=atemp;
  FOrientation:=Orientation;
 end;
end;


{$IFNDEF FORWEBAX}
procedure TRpTextDriver.RepProgress(Sender:TRpBaseReport;var docancel:boolean);
var
 astring:WideString;
begin
{$I-}
{$IFDEF USEVARIANTS}
 WriteLn(SRpRecordCount+' '+IntToStr(Sender.CurrentSubReportIndex)
  +':'+SRpPage+':'+FormatFloat('#########,####',Sender.PageNum)+'-'+
  FormatFloat('#########,####',Sender.RecordCount));
{$ELSE}
 WriteLn(String(SRpRecordCount+' '+IntToStr(Sender.CurrentSubReportIndex)
  +':'+SRpPage+':'+FormatFloat('#########,####',Sender.PageNum)+'-'+
  FormatFloat('#########,####',Sender.RecordCount)));
{$ENDIF}
{$I+}
 // If it's the last page prints additional info
 if Sender.LastPage then
 begin
  astring:=Format('%-20.20s',[SRpPage])+FormatFloat('0000000000',Sender.PageNum+1);
{$I-}
{$IFDEF USEVARIANTS}
  WriteLn(astring);
{$ELSE}
  WriteLn(String(astring));
{$ENDIF}
{$I+}
 end;
end;


function PrintReportToStream(report:TRpReport;Caption:string;progress:boolean;
     allpages:boolean;frompage,topage,copies:integer;
     stream:TStream;collate:Boolean;oemconvert:boolean;forcedrivername:string):Boolean;
var
 TextDriver:TRpTextDriver;
 aTextDriver:TRpPrintDriver;
 oldprogres:TRpProgressEvent;
begin
 TextDriver:=TRpTextDriver.Create;
 TextDriver.ForceDriverName:=Trim(forcedrivername);
 TextDriver.OemConvert:=oemconvert;
 if Length(TextDriver.ForceDriverName)>0 then
  TextDriver.LoadOemConvert:=false;
 aTextDriver:=TextDriver;
 // If report progress must print progress
 oldprogres:=report.OnProgress;
 try
  if progress then
   report.OnProgress:=TextDriver.RepProgress;
  report.PrintRange(aTextDriver,allpages,frompage,topage,copies,collate);
 finally
  report.OnProgress:=oldprogres;
 end;
 Stream.CopyFrom(TextDriver.MemStream,TextDriver.MemStream.Size);
// Stream.Write(TextDriver.MemStream.Memory^,TextDriver.MemStream.Size);
 Result:=True;
end;


function PrintReportToText(report:TRpReport;Caption:string;progress:boolean;
     allpages:boolean;frompage,topage,copies:integer;
     filename:string;collate:Boolean;oemconvert:boolean;forcedrivername:string):Boolean;
var
 TextDriver:TRpTextDriver;
 aTextDriver:TRpPrintDriver;
 oldprogres:TRpProgressEvent;
begin
 if Length(Trim(filename))<0 then
  Raise Exception.Create(SRpNoFileNameProvided+':TXT');
 TextDriver:=TRpTextDriver.Create;
 TextDriver.ForceDriverName:=Trim(forcedrivername);
 TextDriver.OemConvert:=oemconvert;
 if Length(TextDriver.ForceDriverName)>0 then
  TextDriver.LoadOemConvert:=false;
 aTextDriver:=TextDriver;
 // If report progress must print progress
 oldprogres:=report.OnProgress;
 try
  if progress then
   report.OnProgress:=TextDriver.RepProgress;
  report.PrintRange(aTextDriver,allpages,frompage,topage,copies,collate);
 finally
  report.OnProgress:=oldprogres;
 end;
 TextDriver.MemStream.SaveToFile(filename);
 Result:=True;
end;
{$ENDIF}

procedure TRpTextDriver.WritePageSize;
var
 s:String;
begin
 FPrinterDriverName:=UpperCase(FPrinterDriverName);
 s:='';
 // Set line space

 if ((FPrinterDriverName='EPSON') or (FPrinterDriverName='EPSON-ESCPQ')
  or (FPrinterDriverName='EPSON-ESCP') or (FPrinterDriverName='EPSON-MASTER')
  or (FPrinterDriverName='IBMPROPRINTER')) then
 begin
  s:=#27+'C'+Chr(High(FLines)+1);
 end
 else
 if FPrinterDriverName='HP-PCL' then
 begin
  s:=#27+#38+#108+Chr(High(FLines)+1)+#80;
 end;
 WriteStringToStream(s,MemStream);
end;


procedure TRpTextDriver.FillEspcapes(FPrinterDriverName:String);
var
 i:TPrinterRawOp;
begin
 FFullPlain:=false;
 for i:=Low(TPrinterRawOp) to High(TPrinterRawOp) do
 begin
  escapecodes[i]:='';
 end;
 FPrinterDriverName:=UpperCase(FPrinterDriverName);
 masterselect:=false;
 limitedmaster:=false;
 condensedmaster:=false;
 // Epson old printers only share expanded and compressed
 // character codes and underline.
 if FPrinterDriverName='EPSON' then
 begin
  // Init Printer-Line spacing to 1/6
  escapecodes[rpescapeinitprinter]:=#27+#64;
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rplinespace6]:=#27+'2';
  escapecodes[rplinespace8]:=#27+'0';
  escapecodes[rplinespace7_72]:=#27+'1';
  escapecodes[rplinespacen_216]:=#27+'3';
  escapecodes[rpescapecr]:=#13;
  escapecodes[rpescapeformfeed]:=#12;
//  escapecodes[rpescapebold]:=#27+'E';
  escapecodes[rpescapeunderline]:=#27+#45+#1;
//  escapecodes[rpescapeitalic]:=#27+'4';
  // Underline off-Bold off-Italic off
  escapecodes[rpescapenormal]:=#27+#45+#0;
//  escapecodes[rpescapenormal]:=#27+#45+#0+
//   #27+'F'+#27+'5';
  // Set 10 or 12 cpi, enabled-disable double wide, enable-disable condensed
  escapecodes[rpescape5cpi]:=#18+#14;
//  escapecodes[rpescape6cpi]:=#27+'M'+#14+#18;
  escapecodes[rpescape10cpi]:=#20+#18;
//  escapecodes[rpescape12cpi]:=#27+'M'+#20+#18;
//  escapecodes[rpescape15cpi]:=#27+'g'+#20;
  escapecodes[rpescape17cpi]:=#20+#15;
//  escapecodes[rpescape20cpi]:=#27+'M'+#20+#15;

  escapecodes[rpescapeendprint]:=#27+#64;


  // Open drawer
  escapecodes[rpescapepulse]:=#27+#112+#0+#100+#100;
 end
 else
 if FPrinterDriverName='EPSON-MASTER' then
 begin
  // Init Printer-Line spacing to 1/6 - Draft mode
  escapecodes[rpescapeinitprinter]:=#27+#64+#27+'x'+#0;
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rplinespace6]:=#27+'2';
  escapecodes[rplinespace8]:=#27+'0';
  escapecodes[rpescapecr]:=#13;
  escapecodes[rpescapeformfeed]:=#12;
  masterselect:=true;
  limitedmaster:=false;
  condensedmaster:=false;

  // Open drawer
  escapecodes[rpescapepulse]:=#27+#112+#0+#100+#100;
  escapecodes[rpescapeendprint]:=#27+#64;
 end
 else
 if FPrinterDriverName='EPSON-ESCP' then
 begin
  // Init Printer-Line spacing to 1/6 - Draft mode - Bidirectional print
  escapecodes[rpescapeinitprinter]:=#27+#64+#27+'x'+#0+#27+'U'+#0;
  escapecodes[rplinespace6]:=#27+'2';
  escapecodes[rplinespace7_72]:=#27+'1';
  escapecodes[rplinespace8]:=#27+'0';
  escapecodes[rplinespacen_216]:=#27+'3';
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
  escapecodes[rpescapeformfeed]:=#12;
  escapecodes[rpescapebold]:=#27+'E';
  escapecodes[rpescapeunderline]:=#27+#45+#1;
  escapecodes[rpescapeitalic]:=#27+'4';
  // Underline off-Bold off-Italic off
  escapecodes[rpescapenormal]:=#27+#45+#0+
   #27+'F'+#27+'5';
  // Set 10 or 12 cpi, enabled-disable double wide, enable-disable condensed
  escapecodes[rpescape5cpi]:=#27+'P'+#14+#18;
  escapecodes[rpescape6cpi]:=#27+'M'+#14+#18;
  escapecodes[rpescape10cpi]:=#27+'P'+#20+#18;
  escapecodes[rpescape12cpi]:=#27+'M'+#20+#18;
  // 15 cpi not supported in LX models
//  escapecodes[rpescape15cpi]:=#27+'g'+#20;
  escapecodes[rpescape17cpi]:=#27+'P'+#20+#15;
  escapecodes[rpescape20cpi]:=#27+'M'+#20+#15;

  escapecodes[rpescapeendprint]:=#27+#64;


  // Open drawer
  escapecodes[rpescapepulse]:=#27+#112+#0+#100+#100;
 end
 else
 if FPrinterDriverName='EPSON-ESCPQ' then
 begin
  // Init Printer-Line spacing to 1/6 - Draft mode - Bidirectional print
  escapecodes[rpescapeinitprinter]:=#27+#64+#27+'x'+#1+#27+'U'+#0;
  escapecodes[rplinespace6]:=#27+'2';
  escapecodes[rplinespace8]:=#27+'0';
  escapecodes[rplinespacen_180]:=#27+'3';
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
  escapecodes[rpescapeformfeed]:=#12;
  escapecodes[rpescapebold]:=#27+'E';
  escapecodes[rpescapeunderline]:=#27+#45+#1;
  escapecodes[rpescapeitalic]:=#27+'4';
  // Underline off-Bold off-Italic off
  escapecodes[rpescapenormal]:=#27+#45+#0+
   #27+'F'+#27+'5';
  // Set 10 or 12 cpi, enabled-disable double wide, enable-disable condensed
  escapecodes[rpescape5cpi]:=#27+'P'+#14+#18;
  escapecodes[rpescape6cpi]:=#27+'M'+#14+#18;
  escapecodes[rpescape10cpi]:=#27+'P'+#20+#18;
  escapecodes[rpescape12cpi]:=#27+'M'+#20+#18;
  // 15 cpi not supported in LX models
//  escapecodes[rpescape15cpi]:=#27+'g'+#20;
  escapecodes[rpescape17cpi]:=#27+'P'+#20+#15;
  escapecodes[rpescape20cpi]:=#27+'M'+#20+#15;

  escapecodes[rpescapeendprint]:=#27+#64;

  // Open drawer
  escapecodes[rpescapepulse]:=#27+#112+#0+#100+#100;
 end
 else
 if FPrinterDriverName='IBMPROPRINTER' then
 begin
  // Init Printer-Line spacing to 1/6 - Draft mode
  escapecodes[rpescapeinitprinter]:=#20+#20+#27+#64;
  escapecodes[rplinespace6]:=#27+'2';
  escapecodes[rplinespace8]:=#27+'0';
  escapecodes[rplinespace7_72]:=#27+'1';
  escapecodes[rplinespacen_216]:=#27+'3';
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
  escapecodes[rpescapeformfeed]:=#12;
  escapecodes[rpescapebold]:=#27+'E';
  escapecodes[rpescapeunderline]:=#27+#45+#1;
  escapecodes[rpescapeitalic]:=#27+'4';
  // Underline off-Bold off-Italic off
  escapecodes[rpescapenormal]:=#27+#45+#0+
   #27+'F'+#27+'5';
  // Set 10 or 12 cpi, enabled-disable double wide, enable-disable condensed
  escapecodes[rpescape5cpi]:=#27+#18+#14+#18;
  escapecodes[rpescape6cpi]:=#27+':'+#14+#18;
  escapecodes[rpescape10cpi]:=#27+#18+#20+#18;
  escapecodes[rpescape12cpi]:=#20+#18+#27+':';
  escapecodes[rpescape17cpi]:=#20+#27+#18+#15;
  escapecodes[rpescape20cpi]:=#20+#27+':'+#15;

  escapecodes[rpescapeendprint]:=#20+#20+#27+#64;
 end
 else
 if FPrinterDriverName='EPSONTMU210' then
 begin
  // Init Printer-Line spacing to 1/6 - Draft mode
  escapecodes[rpescapeinitprinter]:=#27+#64;
  escapecodes[rplinespace6]:=#27+'2';
  escapecodes[rplinespacen_60]:=#27+'3';
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
  //escapecodes[rpescapeformfeed]:=#12;
  masterselect:=true;
  limitedmaster:=true;
  condensedmaster:=false;

  // Can select red font
  escapecodes[rpescaperedfont]:=#27+'r'+#1;
  escapecodes[rpescapeblackfont]:=#27+'r'+#0;

  escapecodes[rpescapeendprint]:=#27+#64;
  // Open drawer
  escapecodes[rpescapepulse]:=#27+#112+#0+#100+#100;
 end
 else
 if FPrinterDriverName='EPSONTMU210CUT' then
 begin
  // Init Printer-Line spacing to 1/6 - Draft mode
  escapecodes[rpescapeinitprinter]:=#27+#64;
  escapecodes[rplinespace6]:=#27+'2';
  escapecodes[rplinespacen_60]:=#27+'3';
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
  //escapecodes[rpescapeformfeed]:=#12;
  masterselect:=true;
  limitedmaster:=true;
  condensedmaster:=false;
  // Can select red font
  escapecodes[rpescaperedfont]:=#27+'r'+#1;
  escapecodes[rpescapeblackfont]:=#27+'r'+#0;
  // Cut paper
  escapecodes[rpescapeendprint]:=#27+'m'+#27+#64;
  // Open drawer
  escapecodes[rpescapepulse]:=#27+#112+#0+#100+#100;
 end
 else
 if FPrinterDriverName='EPSONTM88II' then
 begin
  // Init Printer-Line spacing to 1/6 - Draft mode
  escapecodes[rpescapeinitprinter]:=#27+#64;
  escapecodes[rplinespace6]:=#27+'2';
  escapecodes[rplinespacen_60]:=#27+'3';
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
  //escapecodes[rpescapeformfeed]:=#12;
  masterselect:=true;
  limitedmaster:=true;
  condensedmaster:=true;

  escapecodes[rpescapeendprint]:=#27+#64;
  // Open drawer
  escapecodes[rpescapepulse]:=#27+#112+#0+#100+#100;
 end
 else
 if FPrinterDriverName='EPSONTM88IICUT' then
 begin
  // Init Printer-Line spacing to 1/6 - Draft mode
  escapecodes[rpescapeinitprinter]:=#27+#64;
  escapecodes[rplinespace6]:=#27+'2';
  escapecodes[rplinespacen_60]:=#27+'3';
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
  //escapecodes[rpescapeformfeed]:=#12;
  masterselect:=true;
  limitedmaster:=true;
  condensedmaster:=true;
  // Cut paper
  escapecodes[rpescapeendprint]:=#27+'m'+#27+#64;
  // Open drawer
  escapecodes[rpescapepulse]:=#27+#112+#0+#100+#100;
 end
 else
 if FPrinterDriverName='HP-PCL' then
 begin
  // Init printer + 6 lines per inch
  escapecodes[rpescapeinitprinter]:=#27+#64;

  escapecodes[rplinespace6]:=#27+#38+#108+#54+#68;
  escapecodes[rplinespace8]:=#27+#38+#108+#56+#68;

  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
  escapecodes[rpescapeformfeed]:=#27+#38+#108+#48+#72; // Form feed and eject page
  escapecodes[rpescapebold]:=#27+#40+#115+#51+#66;
  escapecodes[rpescapeunderline]:=#27+#38+#100+#48+#68;
  escapecodes[rpescapeitalic]:=#27+#40+#115+#49+#83;
  // Underline off-Bold off-Italic off
  escapecodes[rpescapenormal]:=#27+#38+#100+#64+
    #27+#40+#115+#48+#66+
    #27+#40+#115+#48+#83;
  // Set 10 or 12 cpi, enabled-disable double wide, enable-disable condensed
  escapecodes[rpescape5cpi]:=#27+#40+#115+#5+#72;
  escapecodes[rpescape6cpi]:=#27+#40+#115+#6+#72;
  escapecodes[rpescape10cpi]:=#27+#38+#107+#48+#83;
  escapecodes[rpescape12cpi]:=#27+#38+#107+#52+#83;
  escapecodes[rpescape17cpi]:=#27+#40+#115+#17+#72;
  escapecodes[rpescape20cpi]:=#27+#40+#115+#20+#72;
 end
 else
 if FPrinterDriverName='PLAIN' then
 begin
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
 end
 else
 if FPrinterDriverName='PLAINFULL' then
 begin
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
  FFullPlain:=true;
  FPlainText:=true;
 end
 else
 if FPrinterDriverName='VT100' then
 begin
  // Init Printer-Line spacing to 1/6 - Draft mode
//  escapecodes[rpescapeinitprinter]:=#27+#64+#27+'2'+#27+'x'+#0;
  escapecodes[rpescapelinefeed]:=#10;
//  escapecodes[rpescapecr]:=#13;
//  escapecodes[rpescapeformfeed]:=#12;
//  escapecodes[rpescapenormal]:=#27+'[0m';
  // Set 10 or 12 cpi, enabled-disable double wide, enable-disable condensed
  escapecodes[rpescape5cpi]:=#27+'#'+'6';
  escapecodes[rpescape10cpi]:=#27+'#'+'5';
 end
end;


procedure TRpTextDriver.UpdatePrinterConfig;
var
 i:TPrinterRawOp;
 j:TRpFontStep;
begin
 FForceDriverName:=Trim(FForceDriverName);
 if Length(FForceDriverName)<1 then
 begin
  FPrinterDriver:=GetPrinterEscapeStyleOption(selectedprinter);
  FPlainText:=FPrinterDriver in [rpPrinterDefault,rpPrinterPlain];
 end
 else
 begin
  if UpperCase(FForceDriverName)='PLAIN' then
  begin
   FPrinterDriver:=rpPrinterPlain;
   FPrinterDriverName:='PLAIN';
   FPlainText:=true;
  end
  else
  begin
   FPrinterDriver:=rpPrinterDatabase;
   FPlainText:=false;
   FPrinterDriverName:=FForceDriverName;
  end;
 end;
 if FPlainText then
 begin
  for i:=Low(TPrinterRawOp) to High(TPrinterRawOp) do
  begin
   escapecodes[i]:='';
  end;
  escapecodes[rpescapelinefeed]:=#10;
  escapecodes[rpescapecr]:=#13;
 end
 else
 begin
  if FPrinterDriver=rpPrinterCustom then
  begin
   for i:=Low(TPrinterRawOp) to High(TPrinterRawOp) do
   begin
    escapecodes[i]:=GetPrinterRawOp(selectedprinter,i);
   end;
  end
  else
  begin
   if Length(FForceDriverName)<1 then
    FPrinterDriverName:=GetPrinterEscapeStyleDriver(selectedprinter);
   FillEspcapes(FPrinterDriverName);
  end;
 end;
 if masterselect then
 begin
  for j:=Low(TRpFontStep) to High(TRpFontStep) do
  begin
   allowedsizes[j]:=True;
  end;
  allowedsizes[rpcpi15]:=False;
  if limitedmaster then
  begin
   if condensedmaster then
   begin
    allowedsizes[rpcpi10]:=False;
    allowedsizes[rpcpi5]:=False;
    allowedsizes[rpcpi20]:=False;
   end
   else
   begin
    allowedsizes[rpcpi17]:=False;
    allowedsizes[rpcpi20]:=False;
   end;
  end;
 end
 else
 begin
  for j:=Low(TRpFontStep) to High(TRpFontStep) do
  begin
   allowedsizes[j]:=Length(escapecodes[TPrinterRawOp(Ord(rpescape20cpi)+Ord(j))])>0;
  end;
 end;
 If LoadOemConvert then
 begin
  oemconvert:=GetPrinterOemConvertOption(selectedprinter);
 end;
end;

procedure TRpTextDriver.SelectPrinter(printerindex:TRpPrinterSelect);
var
 i:TPrinterRawOp;
begin
 selectedprinter:=printerindex;
 UpdatePrinterConfig;
 for i:=Low(TPrinterRawOp) to High(TPrinterRawOp) do
 begin
  escapecodes[i]:=GetPrinterRawOp(selectedprinter,i);
 end;
end;

procedure TRpTextDriver.GraphicExtent(Stream:TMemoryStream;var extent:TPoint;dpi:integer);
begin
 // Graphics not supported in text mode
 extent.X:=0;
 extent.Y:=0;
end;

procedure SaveMetafileRangeToText(metafile:TRpMetafileReport;
 allpages:boolean;frompage,topage,copies:integer;Stream:TStream);
var
 adriver:TRpTextDriver;
 i:integer;
 j:integer;
begin
 if allpages then
 begin
  metafile.RequestPage(MAX_PAGECOUNT);
  frompage:=0;
  topage:=metafile.CurrentPageCount-1;
 end
 else
 begin
  frompage:=frompage-1;
  topage:=topage-1;
  metafile.RequestPage(topage);
  if topage>metafile.CurrentPageCount-1 then
   topage:=metafile.CurrentPageCount-1;
 end;
 if copies<=0 then
  copies:=1;
 adriver:=TRpTextDriver.Create;
 adriver.ForceDriverName:=rptypes.GetPrinterEscapeStyleDriver(metafile.Printerselect);
 adriver.NewDocument(metafile,1,false);
 try
  for i:=frompage to topage do
  begin
   for j:=0 to copies-1 do
   begin
    adriver.DrawPage(metafile.Pages[i]);
    if ((i<metafile.CurrentPageCount-1) or (j<copies-1)) then
    begin
     if j<copies-1 then
      adriver.NewPage(metafile.Pages[i])
     else
      adriver.NewPage(metafile.Pages[i+1]);
    end;
   end;
  end;
  adriver.EndDocument;
 except
  adriver.AbortDocument;
  raise;
 end;
 Stream.CopyFrom(adriver.MemStream,adriver.MemStream.Size);
// Stream.Write(adriver.MemStream.Memory^,adriver.MemStream.Size);
end;


procedure SaveMetafileToText(metafile:TRpMetafileReport;
 Stream:TStream);
begin
 SaveMetafileRangeToText(metafile,false,1,MAX_PAGECOUNT,1,Stream);
end;

procedure SaveMetafileToTextStream(metafile:TRpMetafileReport;
 Stream:TStream;compressed:boolean);
var
 adriver:TRpTextDriver;
 i:integer;
begin
 adriver:=TRpTextDriver.Create;
 adriver.NewDocument(metafile,1,false);
 try
  metafile.RequestPage(MAX_PAGECOUNT);
  for i:=0 to metafile.CurrentPageCount-1 do
  begin
   adriver.DrawPage(metafile.Pages[i]);
   if i<metafile.CurrentPageCount-1 then
    adriver.NewPage(metafile.Pages[i+1]);
  end;
  adriver.EndDocument;
  adriver.MemStream.Seek(0,soFromBeginning);
  Stream.CopyFrom(adriver.MemStream,adriver.MemStream.Size);
//  Stream.Write(adriver.MemStream.Memory^,adriver.MemStream.Size);
 except
  adriver.AbortDocument;
  raise;
 end;
end;

function steptotwips(step:TRpFontStep):double;
begin
  Result:=TWIPS_PER_INCHESS/10;
 case step of
  rpcpi20:
   Result:=TWIPS_PER_INCHESS/20;
  rpcpi17:
   Result:=TWIPS_PER_INCHESS/17.14;
  rpcpi15:
   Result:=TWIPS_PER_INCHESS/15;
  rpcpi12:
   Result:=TWIPS_PER_INCHESS/12;
  rpcpi10:
   Result:=TWIPS_PER_INCHESS/10;
  rpcpi6:
   Result:=TWIPS_PER_INCHESS/6;
  rpcpi5:
   Result:=TWIPS_PER_INCHESS/5;
 end;
end;

function CalcCharWidth(charcode:char;step:TRpFOntStep):double;
begin
 if charcode in [#0,#13,#10] then
 begin
  Result:=0;
  exit;
 end;
 Result:=steptotwips(step);
end;

procedure TRpTextDriver.CalculateTextExtent(text:WideString;var Rect:TRect;
    WordBreak:Boolean;singleline:Boolean;fontstep:TRpFontStep);
var
 astring:string;
 i:integer;
 asize:double;
 arec:TRect;
 position:integer;
 info:TRpLineInfo;
 maxwidth:double;
 newsize:double;
 recwidth:double;
 linebreakpos:integer;
 nextline:boolean;
 alastsize:double;
 lockspace:boolean;
 createsnewline:Boolean;
 //Added by Luciano Enzweiler - 08 Feb, 2004 - Start
 // When you have a field with wordwrap on and the text on it had a #10, the driver was
 // sending this extra linefeed without considering it. So a page with 72 lines, for example
 // jumped one extra line because of this.
 DescPos:boolean;
 //Added by Luciano Enzweiler - 08 Feb, 2004 - End
begin
 //Added by Luciano Enzweiler - 08 Feb, 2004 - Start
 // Wordwrap issue
 DescPos := False;
 //Added by Luciano Enzweiler - 08 Feb, 2004 - End
 // Text extent for the simple strings, wide strings not supported
 fontstep:=NearestFontStep(fontstep);
 astring:=Text;
 arec:=Rect;
 arec.Left:=0;
 arec.Top:=0;
 arec.Bottom:=0;

 asize:=0;

 createsnewline:=false;
 FLineInfoCount:=0;
 position:=1;
 linebreakpos:=0;
 maxwidth:=0;
 recwidth:=(rect.Right-rect.Left);
 nextline:=false;
 i:=1;
 alastsize:=0;
 lockspace:=false;
 while i<=Length(astring) do
 begin
  newsize:=CalcCharWidth(astring[i],fontstep);
  if (Not (astring[i] in [' ',#10,#13])) then
   lockspace:=false;
  if wordbreak then
  begin
   if asize+newsize>recwidth then
   begin
    if linebreakpos>0 then
    begin
     i:=linebreakpos;
     nextline:=true;
     asize:=alastsize;
     linebreakpos:=0;
    end;
   end
   else
   begin
    if astring[i] in ['.',',','-',' '] then
    begin
     linebreakpos:=i;
     if astring[i]=' ' then
     begin
      if not lockspace then
      begin
       alastsize:=asize;
       lockspace:=true;
      end;
     end
     else
     begin
      alastsize:=asize+newsize;
     end;
    end;
    asize:=asize+newsize;
   end;
  end
  else
  begin
   asize:=asize+newsize;
  end;
  if not singleline then
 //Added by Luciano Enzweiler - 08 Feb, 2004 - Start
 // Wordwrap issue
{  if astring[i]=#10 then  //From this
    nextline:=true;  }
   if astring[i]=#10 then
   begin
    //To this
    nextline:=true;
    DescPos:=True;
    createsnewline:=true;
   end;
 //Added by Luciano Enzweiler - 08 Feb, 2004 - End
  if asize>maxwidth then
   maxwidth:=asize;
  if nextline then
  begin
   nextline:=false;
   info.Position:=position;
   info.lastline:=createsnewline;
   info.Size:=i-position+1;
 //Added by Luciano Enzweiler - 08 Feb, 2004 - Start
 // Wordwrap issue
   if DescPos then
   begin
    DescPos:=False;
    Dec(info.Size);
   end;
 //Added by Luciano Enzweiler - 08 Feb, 2004 - End
   info.Width:=Round((asize));
   info.height:=Round((TWIPS_PER_INCHESS/(FLinesPerInch/100)));
   info.TopPos:=arec.Bottom;
   arec.Bottom:=arec.Bottom+info.height;
   asize:=0;
   position:=i+1;
   NewLineInfo(info);
   createsnewline:=false;
   // Skip only one blank char
   if i<Length(astring) then
    if astring[i+1]=' ' then
    begin
     inc(i);
     position:=i+1;
    end;
  end;
  inc(i);
 end;
 arec.Right:=Round((maxwidth+1));
 if Position<=Length(astring) then
 begin
  info.Position:=position;
  info.Size:=Length(astring)-position+1;
  info.Width:=Round((asize+1));
  info.height:=Round((TWIPS_PER_INCHESS/(FLinesPerInch/100)));
  info.TopPos:=arec.Bottom;
  arec.Bottom:=arec.Bottom+info.height;
  NewLineInfo(info);
 end;
 rect:=arec;
end;
{
procedure TRpTextDriver.CalculateTextExtent(text:WideString;var Rect:TRect;
    WordBreak:Boolean;singleline:Boolean;fontstep:TRpFontStep);
var
 astring:string;
 i:integer;
 asize:double;
 arec:TRect;
 position:integer;
 info:TRpLineInfo;
 maxwidth:double;
 newsize:double;
 recwidth:double;
 linebreakpos:integer;
 nextline:boolean;
 alastsize:double;
 lockspace:boolean;
begin
 // Text extent for the simple strings, wide strings not supported
 fontstep:=NearestFontStep(fontstep);
 astring:=Text;
 arec:=Rect;
 arec.Left:=0;
 arec.Top:=0;
 arec.Bottom:=0;

 asize:=0;

 FLineInfoCount:=0;
 position:=1;
 linebreakpos:=0;
 maxwidth:=0;
 recwidth:=(rect.Right-rect.Left);
 nextline:=false;
 i:=1;
 alastsize:=0;
 lockspace:=false;
 while i<=Length(astring) do
 begin
  newsize:=CalcCharWidth(astring[i],fontstep);
  if (Not (astring[i] in [' ',#10,#13])) then
   lockspace:=false;
  if wordbreak then
  begin
   if asize+newsize>recwidth then
   begin
    if linebreakpos>0 then
    begin
     i:=linebreakpos;
     nextline:=true;
     asize:=alastsize;
     linebreakpos:=0;
    end;
   end
   else
   begin
    if astring[i] in ['.',',','-',' '] then
    begin
     linebreakpos:=i;
     if astring[i]=' ' then
     begin
      if not lockspace then
      begin
       alastsize:=asize;
       lockspace:=true;
      end;
     end
     else
     begin
      alastsize:=asize+newsize;
     end;
    end;
    asize:=asize+newsize;
   end;
  end
  else
  begin
   asize:=asize+newsize;
  end;
  if not singleline then
   if astring[i]=#10 then
    nextline:=true;
  if asize>maxwidth then
   maxwidth:=asize;
  if nextline then
  begin
   nextline:=false;
   info.Position:=position;
   info.Size:=i-position+1;
   info.Width:=Round((asize));
   info.height:=Round((TWIPS_PER_INCHESS/(FLinesPerInch/100)));
   info.TopPos:=arec.Bottom;
   arec.Bottom:=arec.Bottom+info.height;
   asize:=0;
   position:=i+1;
   NewLineInfo(info);
  end;
  inc(i);
 end;
 arec.Right:=Round((maxwidth+1));
 if Position<=Length(astring) then
 begin
  info.Position:=position;
  info.Size:=Length(astring)-position+1;
  info.Width:=Round((asize+1));
  info.height:=Round((TWIPS_PER_INCHESS/(FLinesPerInch/100)));
  info.TopPos:=arec.Bottom;
  arec.Bottom:=arec.Bottom+info.height;
  NewLineInfo(info);
 end;
 rect:=arec;
end;
}
procedure TRpTextDriver.NewLineInfo(info:TRpLineInfo);
begin
 if FLineInfoMaxItems<=FLineInfoCount-1 then
 begin
  SetLength(FLineInfo,FLineInfoMaxItems*2);
  FLineInfoMaxItems:=FLineInfoMaxItems*2;
 end;
 FLineInfo[FLineInfoCount]:=info;
 inc(FLineInfoCount);
end;

procedure TRpTextDriver.TextRect(ARect: TRect; Text: string;
                       Alignment: integer; Clipping: boolean;Wordbreak:boolean;
                       RightToLeft:Boolean;fontstep:TRpFontStep;fontstyle:integer;red:Boolean);
var
 recsize:TRect;
 i,index:integer;
 posx,posY:integer;
 singleline:boolean;
 astring:String;
 lwords,lwidths:TStringList;
 aword:String;
 alinesize,alinedif,currpos:integer;
 arec:TRect;
begin
 singleline:=(Alignment AND AlignmentFlags_SingleLine)>0;
 if singleline then
  wordbreak:=false;
 // Calculates text extent and apply alignment
 recsize:=ARect;
 CalculateTextExtent(Text,recsize,wordbreak,singleline,fontstep);
 // Align bottom or center
 PosY:=ARect.Top;
 if (AlignMent AND AlignmentFlags_AlignBottom)>0 then
 begin
  PosY:=ARect.Bottom-recsize.bottom;
 end;
 if (AlignMent AND AlignmentFlags_AlignVCenter)>0 then
 begin
  PosY:=ARect.Top+(((ARect.Bottom-ARect.Top)-recsize.Bottom) div 2);
 end;
 for i:=0 to FLineInfoCount-1 do
 begin
  posX:=ARect.Left;
  // Aligns horz.
  if  ((Alignment AND AlignmentFlags_AlignRight)>0) then
  begin
   // recsize.right contains the width of the full text
   PosX:=ARect.Right-FLineInfo[i].Width;
  end;
  // Aligns horz.
  if (Alignment AND AlignmentFlags_AlignHCenter)>0 then
  begin
   PosX:=ARect.Left+(((Arect.Right-Arect.Left)-FLineInfo[i].Width) div 2);
  end;
  astring:=Copy(Text,FLineInfo[i].Position,FLineInfo[i].Size);
  if  (((Alignment AND AlignmentFlags_AlignHJustify)>0) AND (NOT FLineInfo[i].LastLine)) then
  begin
   // Calculate the sizes of the words, then
   // share space between words
   lwords:=TStringList.Create;
   try
    aword:='';
    index:=1;
    while index<=Length(astring) do
    begin
     if astring[index]<>' ' then
     begin
      aword:=aword+astring[index];
     end
     else
     begin
      if Length(aword)>0 then
       lwords.Add(aword);
      aword:='';
     end;
     inc(index);
    end;
    if Length(aword)>0 then
      lwords.Add(aword);
    // Calculate all words size
    alinesize:=0;
    lwidths:=TStringList.Create;
    try
     for index:=0 to lwords.Count-1 do
     begin
      arec:=ARect;
      arec.Left:=0;
      arec.Right:=Round(Length(lwords.Strings[index])*steptotwips(fontstep));
      if RightToLeft then
       lwidths.Add(IntToStr(-(arec.Right-arec.Left)))
      else
       lwidths.Add(IntToStr(arec.Right-arec.Left));
      alinesize:=alinesize+arec.Right-arec.Left;
     end;
     alinedif:=ARect.Right-ARect.Left-alinesize;
     if alinedif>0 then
     begin
      if lwords.count>1 then
       alinedif:=alinedif div (lwords.count-1);
      if RightToLeft then
      begin
       currpos:=ARect.Right;
       alinedif:=-alinedif;
      end
      else
       currpos:=PosX;
      for index:=0 to lwords.Count-1 do
      begin
       DoTextOut(currpos,PosY+FLineInfo[i].TopPos,lwords.strings[index],
        FLineInfo[i].Width,fontstep,RightToLeft,fontstyle,red);
       currpos:=currpos+StrToInt(lwidths.Strings[index])+alinedif;
      end;
     end
     else
      DoTextOut(PosX,PosY+FLineInfo[i].TopPos,astring,FLineInfo[i].Width,fontstep,RightToLeft,fontstyle,red);
    finally
     lwidths.Free;
    end;
   finally
    lwords.free;
   end;
  end
  else
   DoTextOut(PosX,PosY+FLineInfo[i].TopPos,astring,FLineInfo[i].Width,fontstep,RightToLeft,fontstyle,red);
 end;
end;


function TRpTextDriver.GetColumnNumber(posx:integer;FontStep:TRpFontStep):integer;
begin
 if FPlainText then
  FontStep:=rpcpi10;
 Result:=Round(posx/steptotwips(fontstep));
 if Result<0 then
  Result:=0;
end;

function TRpTextDriver.GetBlankLine(FontStep:TRpFontStep):String;
var
 charcount:integer;
 i:integer;
begin
 if FPlainText then
  FontStep:=rpcpi10;
 charcount:=Round(FPageWidth/steptotwips(fontstep));
 SetLength(Result,charcount);
 for i:=1 to charcount do
 begin
  Result[i]:=' ';
 end;
// FillChar(Result[1],charcount,' ');
end;

procedure TRpTextDriver.DoTextOut(X, Y: Integer; const Text: string;LineWidth:Integer;
  FontStep:TRpFontStep;RightToLeft:Boolean;fontstyle:integer;red:boolean);
var
 astring,atpos:String;
 lineindex,index:integer;
 columnnumber:integer;
 toposition:integer;
 i:integer;
 attr:TRpAttribObject;
begin
 astring:=Text;
 if RightToLeft then
 begin
  astring:=DoReverseString(astring);
 end;
 lineindex:=getlineindex(Y);
 if FLines[lineindex].Attributes.Count<1 then
 begin
  FLines[lineindex].FontStep:=NearestFontStep(FontStep);
  FLines[lineindex].Value:=GetBlankLine(FLines[lineindex].FontStep);
  FLines[lineindex].Red:=red;
 end;
 columnnumber:=GetColumnNumber(X,FLines[lineindex].FontStep);
 atpos:=FormatFloat('00000',columnnumber+1);
 index:=FLines[lineindex].Attributes.IndexOf(atpos);
 if index<0 then
 begin
  attr:=TRpAttribObject.Create;
  attr.FontStyle:=fontStyle;
  attr.Position:=columnnumber+1;
  attr.size:=0;
  FLines[lineindex].Attributes.AddObject(atpos,attr);
 end
 else
 begin
  attr:=TRpAttribObject(FLines[lineindex].Attributes.Objects[index]);
 end;
 toposition:=Length(astring);
 if columnnumber+toposition>=Length(FLines[lineindex].Value) then
  toposition:=Length(FLines[lineindex].Value)-columnnumber;
 if toposition>attr.size then
  attr.size:=toposition;
 for i:=1 to toposition do
 begin
  FLines[lineindex].Value[columnnumber+i]:=astring[i];
 end;
end;


function TRpTextDriver.FindEscapeStep(FontStep:TRpFontStep;red:Boolean):String;
var
 aselect:Byte;
 condcode:Byte;
begin
 if FPlainText then
 begin
  Result:='';
  exit;
 end;
 if masterselect then
 begin
  if limitedmaster then
   condcode:=0
  else
   condcode:=mastercond;
  if FontStep=rpcpi15 then
  begin
   Result:='';
  end;
  aselect:=0;
  if (limitedmaster and condensedmaster) then
  begin
   case FontStep of
    rpcpi20:
     aselect:=0;
    rpcpi17:
     aselect:=master12;
    rpcpi15:
     aselect:=0;
    rpcpi12:
     aselect:=master10;
    rpcpi10:
     aselect:=0;
    rpcpi6:
     aselect:=master10 or masterwide;
    rpcpi5:
     aselect:=0;
   end;
  end
  else
  begin
   case FontStep of
    rpcpi20:
     aselect:=master12 or condcode;
    rpcpi17:
     aselect:=master10 or condcode;
    rpcpi15:
     Result:='';
    rpcpi12:
     aselect:=master12;
    rpcpi10:
     aselect:=master10;
    rpcpi6:
     aselect:=master12 or masterwide;
    rpcpi5:
     aselect:=master10 or masterwide;
   end;
  end;
  Result:=#27+'!'+Chr(aselect);
  // Red font
  if Length(escapecodes[rpescaperedfont])>0 then
  begin
   if red then
    Result:=Result+escapecodes[rpescaperedfont]
   else
    Result:=Result+escapecodes[rpescapeblackfont];
  end;
  exit;
 end;
 Result:=escapecodes[rpescape10cpi];
 case FontStep of
  rpcpi20:
   Result:=escapecodes[rpescape20cpi];
  rpcpi17:
   Result:=escapecodes[rpescape17cpi];
  rpcpi15:
   Result:=escapecodes[rpescape15cpi];
  rpcpi12:
   Result:=escapecodes[rpescape12cpi];
  rpcpi10:
   Result:=escapecodes[rpescape10cpi];
  rpcpi6:
   Result:=escapecodes[rpescape6cpi];
  rpcpi5:
   Result:=escapecodes[rpescape5cpi];
 end;
 // Red font
 if Length(escapecodes[rpescaperedfont])>0 then
 begin
  if red then
   Result:=Result+escapecodes[rpescaperedfont]
  else
   Result:=Result+escapecodes[rpescapeblackfont];
 end;
end;

function TRpTextDriver.FindEscapeStyle(fontstyle:integer;FontStep:TRpFontStep):String;
var
 aselect:byte;
 condcode:byte;
begin
 Result:='';
 if FPlainText then
  exit;
 if masterselect then
 begin
  if FontStep=rpcpi15 then
  begin
   Result:='';
  end;
  if limitedmaster then
   condcode:=0
  else
   condcode:=mastercond;
  aselect:=0;
  if limitedmaster then
  begin
   case FontStep of
    rpcpi20:
     aselect:=0;
    rpcpi17:
     aselect:=master12;
    rpcpi15:
     aselect:=0;
    rpcpi12:
     aselect:=master10;
    rpcpi10:
     aselect:=0;
    rpcpi6:
     aselect:=master10 or masterwide;
    rpcpi5:
     aselect:=0;
   end;
  end
  else
  begin
   case FontStep of
    rpcpi20:
     aselect:=master12 or condcode;
    rpcpi17:
     aselect:=master10 or condcode;
    rpcpi15:
     Result:='';
    rpcpi12:
     aselect:=master12;
    rpcpi10:
     aselect:=master10;
    rpcpi6:
     aselect:=master12 or masterwide;
    rpcpi5:
     aselect:=master10 or masterwide;
   end;
  end;
  if (fontstyle and 1)>0 then
   aselect:=aselect or masterbold;
  if not limitedmaster then
  begin
   if (fontstyle and (1 shl 1))>0 then
    aselect:=aselect or masteritalic;
  end;
  if (fontstyle and (1 shl 2))>0 then
   aselect:=aselect or masterunderline;
  Result:=#27+'!'+Chr(aselect);
  exit;
 end;
 if (FPRinterDriverName='VT100') then
 begin
  Result:='';
  if (fontstyle and 1)>0 then
   Result:=Result+';1';
  if Length(Result)<1 then
   if (fontstyle and (1 shl 1))>0 then
    Result:=Result+';5';
  if Length(Result)<1 then
   if (fontstyle and (1 shl 2))>0 then
    Result:=Result+';4';
  Result:=#27+'[0'+Result+'m';
  exit;
 end;

 Result:=escapecodes[rpescapenormal];
 if (fontstyle and 1)>0 then
  Result:=Result+escapecodes[rpescapebold];
 if (fontstyle and (1 shl 1))>0 then
  Result:=Result+escapecodes[rpescapeitalic];
 if (fontstyle and (1 shl 2))>0 then
  Result:=Result+escapecodes[rpescapeunderline];
 if (fontstyle and (1 shl 3))>0 then
  Result:=Result+escapecodes[rpescapestrikeout];
end;



function TRpTextDriver.EnCodeLine(Line:TRpPrintLine;index:integer):String;
var
 attr:TRpAttribObject;
 encoded:string;
 i:integer;
 atposition:integer;
 atindex:integer;
 wasunderline:boolean;
 currentcount:integer;
 trimed:boolean;
begin
{$IFDEF MSWINDOWS}
 if OemConvert then
 begin
  Line.Value:=RpCharToOem(Line.Value);
 end;
{$ENDIF}
 encoded:='';
 // Only set size if previos size is different
// if index>0 then
// begin
//  if Line.FontStep<>FLines[index-1].FontStep then
//   encoded:=encoded+FindEscapeStep(Line.FontStep);
// end
// else
  encoded:=encoded+FindEscapeStep(Line.FontStep,Line.red);
 if Line.Attributes.Count<1 then
 begin
  Result:=encoded+escapecodes[rpescapelinefeed];
  exit;
 end;
 encoded:=encoded+escapecodes[rpescapenormal];
 atindex:=0;
 i:=1;
 atposition:=StrToInt(Line.Attributes.Strings[atindex]);
 while ((i<=Length(Line.Value)) and (i<atposition)) do
 begin
  encoded:=encoded+Line.Value[i];
  inc(i);
 end;
 while (i<=Length(Line.Value)) do
 begin
  attr:=TRpAttribObject(Line.Attributes.Objects[atindex]);
  wasunderline:=(attr.fontstyle and (1 shl 2))>0;
  currentcount:=1;
  encoded:=encoded+FindEscapeStyle(attr.fontstyle,Line.FontStep);
  inc(atindex);
  if atindex<Line.Attributes.Count then
  begin
   atposition:=StrToInt(Line.Attributes.Strings[atindex]);
  end
  else
  begin
   atposition:=Length(Line.Value)+1;
  end;
  while ((i<=Length(Line.Value)) and (i<atposition)) do
  begin
   encoded:=encoded+Line.Value[i];
   inc(i);
   inc(currentcount);
   if wasunderline then
   begin
    if currentcount>attr.size then
    begin
     encoded:=encoded+FindEscapeStyle(attr.fontstyle and (Not (1 shl 2)),Line.FontStep);
     wasunderline:=false;
    end;
   end;
  end;
 end;
 trimed:=false;
 While Length(encoded)>0 do
 begin
  if encoded[Length(encoded)]<>' ' then
   break
  else
  begin
   encoded:=Copy(encoded,1,Length(encoded)-1);
   trimed:=true;
  end;
 end;
 if trimed then
  encoded:=encoded+' ';
 encoded:=encoded+escapecodes[rpescapecr];
 if Length(escapecodes[rpescapeformfeed])>0 then
 begin
  if index=High(FLines) then
   encoded:=encoded+escapecodes[rpescapeformfeed]
  else
   encoded:=encoded+escapecodes[rpescapelinefeed];
 end
 else
  encoded:=encoded+escapecodes[rpescapelinefeed];
 Result:=encoded;
end;

procedure TRpTextDriver.WriteCurrentPage(cutclearlines:Boolean);
var
 i:integer;
 codedstring:String;
 lastline:integer;
begin
 lastline:=High(FLines);
 if cutclearlines then
 begin
  while lastline>0 do
  begin
   if FLines[lastline].Attributes.Count<1 then
    Dec(lastline)
   else
    break;
  end;
 end;
 for i:=0 to lastline do
 begin
  codedstring:=EnCodeLine(FLines[i],i);
  if FFullPlain then
  begin
   codedstring:=Trim(codedstring);
   if Length(codedstring)>0 then
    codedstring:=codedstring+escapecodes[rpescapelinefeed];
  end;
  WriteStringToStream(codedstring,MemStream);
 end;
end;

procedure SaveMetafileToTextFile(metafile:TRpMetafileReport;
 afilename:String);
var
 memstream:TMemoryStream;
begin
 memstream:=TMemoryStream.Create;
 try
  SaveMetafileToText(metafile,memstream);
  memstream.Seek(0,soFromBeginning);
  memstream.SaveToFile(afilename);
 finally
  memstream.free;
 end;
end;

procedure SaveMetafileRangeToFile(metafile:TRpMetafileReport;
 allpages:boolean;frompage,topage,copies:integer;filename:String);
var
 memstream:TMemoryStream;
begin
 memstream:=TMemoryStream.Create;
 try
  SaveMetafileRangeToText(metafile,allpages,frompage,topage,copies,memstream);
  memstream.Seek(0,soFromBeginning);
  memstream.SaveToFile(filename);
 finally
  memstream.free;
 end;
end;

procedure TRpTextDriver.DrawChart(Series:TRpSeries;ametafile:TRpMetaFileReport;posx,posy:integer;achart:TObject);
begin
 // Charts not supported in text driver

end;

function TRpTextDriver.GetFontDriver:TRpPrintDriver;
begin
 Result:=Self;
end;

end.
