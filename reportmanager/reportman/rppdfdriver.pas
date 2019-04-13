{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rppdfdriver                                     }
{       TRpPDFDriver: Printer driver for                }
{       generating pdf files                            }
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

unit rppdfdriver;

interface

{$I rpconf.inc}


uses Classes,Sysutils,
{$IFDEF USEVARIANTS}
 Types,
{$ENDIF}
{$IFDEF MSWINDOWS}
 Windows,
{$ENDIF}
 rptypes,rpmetafile,rppdffile,
{$IFNDEF FORWEBAX}
 rpbasereport,rpreport,rpmdchart,
{$ENDIF}
{$IFDEF LINUX}
 Libc,
{$ENDIF}
 rpmunits,rpmdconsts,rpmdcharttypes;

type
 TRpPdfDriver=class(TRpPrintDriver)
  private
   FPDFFIle:TRpPDFFile;
   FOrientation:TRpOrientation;
   FPageWidth,FPageHeight:integer;
   PageQt:Integer;
  public
   filename:string;
   Compressed:boolean;
   DestStream:TStream;
   constructor Create;
   destructor Destroy;override;
{$IFNDEF FORWEBAX}
   procedure RepProgress(Sender:TRpBaseReport;var docancel:boolean);
{$ENDIF}
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
   property PDFFile:TRpPDFFile read FPDFFile;
   function GetFontDriver:TRpPrintDriver;override;
  end;


procedure SaveMetafileToPDF(metafile:TRpMetafileReport;
 filename:string;compressed:boolean);
procedure SaveMetafileRangeToPDF(metafile:TRpMetafileReport;
 allpages:boolean;frompage,topage,copies:integer;filename:string;
  compressed:boolean);

 procedure SaveMetafileToPDFStream(metafile:TRpMetafileReport;
 Stream:TStream;compressed:boolean);
{$IFNDEF FORWEBAX}
function PrintReportPDF(report:TRpReport;Caption:string;progress:boolean;
     allpages:boolean;frompage,topage,copies:integer;
     filename:string;compressed:boolean;
      collate:boolean):Boolean;
function PrintReportPDFStream(report:TRpReport;Caption:string;progress:boolean;
     allpages:boolean;frompage,topage,copies:integer;
     Stream:TStream;compressed:boolean;collate:boolean):Boolean;
function PrintReportMetafileStream(report:TRpReport;
 Caption:string;progress:boolean;allpages:boolean;frompage,topage,copies:integer;
 Stream:TStream;compressed:boolean;collate:boolean):Boolean;
function PrintReportToMetafile(report:TRpReport;Caption:string;progress:boolean;
     allpages:boolean;frompage,topage,copies:integer;
     filename:string;collate:boolean):Boolean;
procedure DoDrawChart(adriver:TRpPrintDriver;Series:TRpSeries;page:TRpMetaFilePage;
 aposx,aposy:integer;achart:TObject);
{$ENDIF}

{$IFDEF LINUX}
procedure PrintMetafileUsingKPrinter(metafile:TRpMetafileReport);
{$ENDIF}

implementation

uses
 Math;

const
 AlignmentFlags_SingleLine=64;



constructor TRpPDFDriver.Create;
begin
 inherited Create;
 PageQt:=0;
 FPageWidth:= 11904;
 FPageHeight:= 16836;
 FPDFFile:=TRpPDFFile.Create(nil);
end;

destructor TRpPDFDriver.Destroy;
begin
 if Assigned(FPDFFile) then
 begin
  FPDFFile.free;
  FPDFFile:=nil;
 end;
 inherited Destroy;
end;

function TRpPDFDriver.SupportsCollation:boolean;
begin
 Result:=false;
end;

function TRpPDFDriver.SupportsCopies(maxcopies:integer):boolean;
begin
 Result:=false;
end;

procedure TRpPDFDriver.NewDocument(report:TrpMetafileReport;hardwarecopies:integer;
   hardwarecollate:boolean);
begin
 if Assigned(FPDFFile) then
 begin
  FPDFFile.Free;
  FPDFFile:=nil;
 end;
 FPDFFile:=TRpPDFFile.Create(nil);
 FPDFFile.FileName:=filename;
 if Assigned(DestStream) then
 begin
  FPDFFile.DestStream:=DestStream;
 end;
 FPDFFile.Compressed:=Compressed;
 FPDFFile.PageWidth:=report.CustomX;
 FPDFFile.PageHeight:=report.CustomY;
 FPageWidth:=FPDFFile.PageWidth;
 FPageHeight:=FPDFFile.PageHeight;
 FPDFFile.BeginDoc;
end;

procedure TRpPDFDriver.EndDocument;
begin
 FPDFFile.EndDoc;
 FPDFFile.Free;
 FPDFFile:=nil;
end;

procedure TRpPDFDriver.AbortDocument;
begin
 FPDFFile.Free;
 FPDFFile:=nil;
end;

procedure TRpPDFDriver.NewPage(metafilepage:TRpMetafilePage);
begin
 // Sets the page size for the pdf file, first if it's a qt page
 if metafilepage.UpdatedPageSize then
 begin
  FPageWidth:=metafilepage.PageSizeQt.PhysicWidth;
  FPageHeight:=metafilepage.PageSizeQt.PhysicHeight;
 end;
 FPDFFile.NewPage(FPageWidth,FPageHeight);
end;


procedure TRpPDFDriver.TextExtent(atext:TRpTextObject;var extent:TPoint);
var
 singleline:boolean;
 rect:TRect;
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
 FPDFFile.Canvas.Font.Name:=TRpType1Font(atext.Type1Font);
 FPDFFile.Canvas.Font.WFontName:=atext.WFontName;
 FPDFFile.Canvas.Font.LFontName:=atext.LFontName;
{$IFDEF MSWINDOWS}
 FPDFFile.Canvas.Font.FontName:=StringReplace(atext.WFontName,' ','',[rfReplaceAll]);
{$ENDIF}
{$IFDEF LINUX}
 FPDFFile.Canvas.Font.FontName:=StringReplace(atext.LFontName,' ','',[rfReplaceAll]);
{$ENDIF}

 FPDFFile.Canvas.Font.Size:=atext.FontSize;
 FPDFFile.Canvas.Font.Bold:=(atext.Fontstyle and 1)>0;
 FPDFFile.Canvas.Font.Italic:=(atext.Fontstyle and (1 shl 1))>0;
 Rect.Left:=0;
 Rect.Top:=0;
 Rect.Bottom:=0;
 Rect.Right:=extent.X;
 FPDFFile.Canvas.TextExtent(atext.Text,Rect,atext.WordWrap,singleline);
 extent.X:=Rect.Right;
 extent.Y:=Rect.Bottom;
 if (atext.CutText) then
 begin
  if maxextent.Y<extent.Y then
   extent.Y:=maxextent.Y;
 end;
end;

procedure TRpPDFDriver.EndPage;
begin

end;

procedure TRpPDFDriver.DrawObject(page:TRpMetaFilePage;obj:TRpMetaObject);
var
 X, Y, W, H, S: Integer;
 Width,Height,posx,posy:integer;
 rec:TRect;
 aalign:integer;
 stream:TStream;
 astring:WideString;
 intimageindex:integer;
// bitmap:TBitmap;
begin
 posx:=obj.Left;
 posy:=obj.Top;
 case obj.Metatype of
  rpMetaText:
   begin
{$IFDEF MSWINDOWS}
    FPDFFile.Canvas.Font.WFontName:=page.GetWFontName(Obj);
    FPDFFile.Canvas.Font.FontName:=StringReplace(FPDFFile.Canvas.Font.WFontName,' ','',[rfReplaceAll]);
{$ENDIF}
{$IFDEF LINUX}
    FPDFFile.Canvas.Font.LFontName:=page.GetLFontName(Obj);
    FPDFFile.Canvas.Font.FontName:=StringReplace(FPDFFile.Canvas.Font.LFontName,' ','',[rfReplaceAll]);
{$ENDIF}
    FPDFFile.Canvas.Font.Style:=obj.FontStyle;
    // Transparent ?
    FPDFFile.Canvas.Font.Name:=TrpType1Font(obj.Type1Font);
    FPDFFile.Canvas.Font.Size:=obj.FontSize;
    FPDFFile.Canvas.Font.Color:=obj.FontColor;
    FPDFFile.Canvas.Font.Bold:=(obj.Fontstyle and 1)>0;
    FPDFFile.Canvas.Font.Italic:=(obj.Fontstyle and (1 shl 1))>0;
    FPDFFile.Canvas.Font.UnderLine:=(obj.Fontstyle  and (1 shl 2))>0;
    FPDFFile.Canvas.Font.StrikeOut:=(obj.Fontstyle and (1 shl 3))>0;
    FPDFFile.Canvas.Font.BackColor:=obj.BackColor;
    FPDFFile.Canvas.Font.Transparent:=obj.Transparent;
    FPDFFile.Canvas.UpdateFonts;
    aalign:=obj.Alignment;
    rec.Left:=posx;
    rec.Top:=posy;
    rec.Right:=posx+round(obj.Width);
    rec.Bottom:=posy+round(obj.Height);
    // Unicode now supported
    astring:=page.GetText(Obj);
    FPDFFile.Canvas.TextRect(rec,astring,aalign,obj.cuttext,
    obj.WordWrap,obj.FontRotation,obj.RightToLeft);
   end;
  rpMetaDraw:
   begin
    Width:=obj.Width;
    Height:=obj.Height;
    FPDFFile.Canvas.BrushStyle:=obj.BrushStyle;
    FPDFFile.Canvas.PenStyle:=obj.PenStyle;
    FPDFFile.Canvas.PenColor:=obj.Pencolor;
    FPDFFile.Canvas.BrushColor:=obj.BrushColor;
    FPDFFile.Canvas.PenWidth:=obj.PenWidth;
    X := FPDFFile.Canvas.PenWidth div 2;
    Y := X;
    W := Width - FPDFFile.Canvas.PenWidth + 1;
    H := Height - FPDFFile.Canvas.PenWidth + 1;
    if FPDFFile.Canvas.PenWidth = 0 then
    begin
     Dec(W);
     Dec(H);
    end;
    if W < H then
     S := W
    else
     S := H;
    if TRpShapeType(obj.DrawStyle) in [rpsSquare, rpsRoundSquare, rpsCircle] then
    begin
     Inc(X, (W - S) div 2);
     Inc(Y, (H - S) div 2);
     W := S;
     H := S;
    end;
    case TRpShapeType(obj.DrawStyle) of
     rpsRectangle, rpsSquare:
      begin
       FPDFFile.Canvas.Rectangle(X+PosX, Y+PosY, X+PosX + W, Y +PosY+ H);
      end;
     rpsRoundRect, rpsRoundSquare:
      begin
//      Canvas.RoundRect(X, Y, X + W, Y + H, S div 4, S div 4);
       FPDFFile.Canvas.Rectangle(X+PosX, Y+PosY, X+PosX + W, Y +PosY+ H);
      end;
     rpsCircle, rpsEllipse:
      begin
       FPDFFile.Canvas.Ellipse(X+PosX, Y+PosY, X+PosX + W, Y+PosY + H);
      end;
     rpsHorzLine:
      begin
       FPDFFile.Canvas.Line(X+PosX, Y+PosY,X+PosX+W, Y+PosY);
//       if obj.PenStyle in [3,4] then
//       begin
//        FPDFFile.Canvas.PenStyle:=6;
//        FPDFFile.Canvas.Line(X+PosX, Y+PosY,X+PosX, Y+PosY+H);
//       end;
      end;
     rpsVertLine:
      begin
       FPDFFile.Canvas.Line(X+PosX, Y+PosY,X+PosX, Y+PosY+H);
      end;
     rpsOblique1:
      begin
       FPDFFile.Canvas.Line(X+PosX, Y+PosY,X+PosX+W, Y+PosY+H);
      end;
     rpsOblique2:
      begin
       FPDFFile.Canvas.Line(X+PosX, Y+PosY+H,X+PosX+W, Y+PosY);
      end;
    end;
   end;
  rpMetaImage:
   begin
    if (not obj.PreviewOnly) then
    begin
     Width:=obj.Width;
     Height:=obj.Height;
     rec.Top:=PosY;
     rec.Left:=PosX;
     rec.Bottom:=rec.Top+Height-1;
     rec.Right:=rec.Left+Width-1;
     if obj.SharedImage then
      intimageindex:=obj.StreamPos
     else
      intimageindex:=-1;
     stream:=page.GetStream(obj);
     case TRpImageDrawStyle(obj.DrawImageStyle) of
      rpDrawFull:
       begin
        FPDFFile.Canvas.DrawImage(rec,stream,obj.dpires,false,false,intimageindex);
       end;
      rpDrawStretch:
       begin
        FPDFFile.Canvas.DrawImage(rec,stream,0,false,false,intimageindex);
       end;
      rpDrawCrop:
        begin
         FPDFFile.Canvas.DrawImage(rec,stream,CONS_PDFRES,false,true,intimageindex);
        end;
      rpDrawTile,rpDrawTiledpi:
       begin
        FPDFFile.Canvas.DrawImage(rec,stream,CONS_PDFRES,true,true,intimageindex);
       end;
     end;
    end;
   end;
 end;
end;

procedure TRpPDFDriver.DrawPage(apage:TRpMetaFilePage);
var
 j:integer;
begin
 for j:=0 to apage.ObjectCount-1 do
 begin
  DrawObject(apage,apage.Objects[j]);
 end;
end;

function TRpPDFDriver.AllowCopies:boolean;
begin
 Result:=false;
end;

function TRpPDFDriver.GetPageSize(var PageSizeQt:Integer):TPoint;
begin
 PageSizeQt:=PageQt;
 Result.X:=FPageWidth;
 Result.Y:=FPageHeight;
end;

function TRpPDFDriver.SetPagesize(PagesizeQt:TPageSizeQt):TPoint;
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
end;

procedure TRpPDFDriver.SetOrientation(Orientation:TRpOrientation);
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





procedure TRpPDFDriver.SelectPrinter(printerindex:TRpPrinterSelect);
begin
 // No printer to select
end;

procedure TRpPDFDriver.GraphicExtent(Stream:TMemoryStream;var extent:TPoint;dpi:integer);
var
 imagesize:integer;
 bitmapwidth,bitmapheight:integer;
 indexed:boolean;
 numcolors,bitsperpixel:integer;
 palette:string;
 format:string;
begin
 bitmapwidth:=0;
 bitmapheight:=0;
 format:='';
 GetJPegInfo(Stream,bitmapwidth,bitmapheight,format);
 if (not (format='JPEG')) then
 begin
  if (format='BMP') then
  begin
    GetBitmapInfo(Stream,bitmapwidth,bitmapheight,imagesize,nil,indexed,bitsperpixel,numcolors,palette);
  end
  else
  begin
   // All other formats
  end;
 end;
 if dpi<=0 then
  exit;
 extent.X:=Round(bitmapwidth/dpi*TWIPS_PER_INCHESS);
 extent.Y:=Round(bitmapheight/dpi*TWIPS_PER_INCHESS);
end;

procedure SaveMetafileRangeToPDF(metafile:TRpMetafileReport;
 allpages:boolean;frompage,topage,copies:integer;filename:string;
 compressed:boolean);
var
 adriver:TRpPDFDriver;
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
 adriver:=TRpPDFDriver.Create;
 try
  adriver.filename:=filename;
  adriver.compressed:=compressed;
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
 finally
  adriver.free;
 end;
end;


procedure SaveMetafileToPDF(metafile:TRpMetafileReport;
 filename:string;compressed:boolean);
begin
 SaveMetafileRangeToPDF(metafile,false,1,MAX_PAGECOUNT,1,filename,compressed);
end;

procedure SaveMetafileToPDFStream(metafile:TRpMetafileReport;
 Stream:TStream;compressed:boolean);
var
 adriver:TRpPDFDriver;
 i:integer;
begin
 adriver:=TRpPDFDriver.Create;
 try
 adriver.compressed:=compressed;
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
  adriver.PDFFile.MainPDF.Seek(0,soFromBeginning);
  Stream.CopyFrom(adriver.PDFFile.MainPDF,adriver.PDFFile.MainPDF.Size);
  adriver.PDFFile.MainPDF.Seek(0,soFromBeginning);
//  Stream.Write(adriver.PDFFile.MainPDF.Memory^,adriver.PDFFile.MainPDF.Size);
 except
  adriver.AbortDocument;
  raise;
 end;
 finally
  adriver.free;
 end;
end;

{$IFNDEF FORWEBAX}
function PrintReportPDFStream(report:TRpReport;Caption:string;progress:boolean;
     allpages:boolean;frompage,topage,copies:integer;
     Stream:TStream;compressed:boolean;
     collate:boolean):Boolean;
var
 pdfdriver:TRpPDFDriver;
 oldprogres:TRpProgressEvent;
begin
 pdfdriver:=TRpPDFDriver.Create;
 try
 pdfdriver.compressed:=compressed;
 pdfdriver.DestStream:=Stream;
 // If report progress must print progress
 oldprogres:=report.OnProgress;
 try
  if progress then
   report.OnProgress:=pdfdriver.RepProgress;
  report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
  Stream.Seek(0,soFromBeginning);
 finally
  report.OnProgress:=oldprogres;
 end;
 finally
  pdfdriver.free;
 end;
 Result:=True;
end;


function PrintReportMetafileStream(report:TRpReport;
 Caption:string;progress:boolean;allpages:boolean;frompage,topage,copies:integer;
 Stream:TStream;compressed:boolean;
 collate:boolean):Boolean;
var
 pdfdriver:TRpPDFDriver;
 oldprogres:TRpProgressEvent;
 astream:TMemoryStream;
begin
 pdfdriver:=TRpPDFDriver.Create;
 try
 pdfdriver.compressed:=compressed;
 astream:=TMemoryStream.Create;
 try
  pdfdriver.DestStream:=aStream;
  // If report progress must print progress
  oldprogres:=report.OnProgress;
  try
   if progress then
    report.OnProgress:=pdfdriver.RepProgress;
   report.TwoPass:=true;
//   report.PrintAll(apdfdriver);
   report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
   if not allpages then
    report.Metafile.PageRange(frompage,topage);
   report.Metafile.SaveToStream(Stream);
   Stream.Seek(0,soFromBeginning);
  finally
   report.OnProgress:=oldprogres;
  end;
  Result:=True;
 finally
  astream.free;
 end;
 finally
  pdfdriver.free;
 end;
end;

procedure TRpPDFDriver.RepProgress(Sender:TRpBaseReport;var docancel:boolean);
var
 astring:WideString;
begin
 astring:=SRpRecordCount+' '+IntToStr(Sender.CurrentSubReportIndex)
  +':'+SRpPage+':'+FormatFloat('#########,####',Sender.PageNum)+'-'+
  FormatFloat('#########,####',Sender.RecordCount);
{$I-}
{$IFDEF USEVARIANTS}
 WriteLn(astring);
{$ELSE}
 WriteLn(String(astring));
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


function PrintReportToMetafile(report:TRpReport;Caption:string;progress:boolean;
     allpages:boolean;frompage,topage,copies:integer;
     filename:string;
     collate:boolean):Boolean;
var
 pdfdriver:TRpPDFDriver;
 oldprogres:TRpProgressEvent;
begin
 if Length(Trim(filename))<0 then
  Raise Exception.Create(SRpNoFileNameProvided+':Metafile');
 pdfdriver:=TRpPDFDriver.Create;
 try
 pdfdriver.compressed:=false;
 report.TwoPass:=true;
 // If report progress must print progress
 oldprogres:=report.OnProgress;
 try
  if progress then
   report.OnProgress:=pdfdriver.RepProgress;
  report.TwoPass:=true;
  report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
  if not allpages then
   report.Metafile.PageRange(frompage,topage);
  if Length(filename)>0 then
   report.Metafile.SaveToFile(filename);
 finally
  report.OnProgress:=oldprogres;
 end;
 finally
  pdfdriver.free;
 end;
 Result:=True;
end;

function PrintReportPDF(report:TRpReport;Caption:string;progress:boolean;
     allpages:boolean;frompage,topage,copies:integer;
     filename:string;compressed:boolean;
     collate:boolean):Boolean;
var
 pdfdriver:TRpPDFDriver;
 oldprogres:TRpProgressEvent;
begin
 if Length(Trim(filename))<0 then
  Raise Exception.Create(SRpNoFileNameProvided+':PDF');
 pdfdriver:=TRpPDFDriver.Create;
 try
 pdfdriver.filename:=filename;
 pdfdriver.compressed:=compressed;
 // If report progress must print progress
 oldprogres:=report.OnProgress;
 try
  if progress then
   report.OnProgress:=pdfdriver.RepProgress;
  report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
 finally
  report.OnProgress:=oldprogres;
 end;
 finally
  pdfdriver.free;
 end;
 Result:=True;
end;

procedure DoDrawChart(adriver:TRpPrintDriver;Series:TRpSeries;page:TRpMetaFilePage;
 aposx,aposy:integer;achart:TObject);
var
 nchart:TRpChart;
 i:integer;
 Maxvalue,Minvalue:double;
 aserie:TRpSeriesItem;
 gridvsep:integer;
 horzgap,vertgap:integer;
 numvlabels:integer;
 valueinc:double;
 posy:integer;
 avalue:double;
 aText:WideString;
 aalign:integer;
 xdesp:integer;
 origin,destination:TPoint;
 j:integer;
 shape:TRpShapeType;
 acolor:integer;
 pencolor:integer;
 MaxValueCount:integer;
 aTextObj:TRpTextObject;
begin
 nchart:=TRpChart(achart);
 // To draw for each serie find macvalue and minvalue
 MaxValue:=-10e300;
 MinValue:=+10e300;
 MaxValueCount:=0;
 for i:=0 to Series.Count-1 do
 begin
  aserie:=Series.Items[i];
  if aserie.MaxValue>MaxValue then
   MaxValue:=aserie.MaxValue;
  if aserie.MinValue<MinValue then
   MinValue:=aserie.MinValue;
  if aserie.ValueCount>MaxValueCount then
   MaxValueCount:=aserie.ValueCount;
 end;
 // The number of grid rows depends on font height
 gridvsep:=Round(nchart.FontSize/POINTS_PER_INCHESS*TWIPS_PER_INCHESS*2);
 vertgap:=Round(nchart.FontSize/POINTS_PER_INCHESS*TWIPS_PER_INCHESS*1.5);
 horzgap:=CONS_HORZGAP;
 // Draws coordinate system
 page.NewDrawObject(aposy,aposx+horzgap,1,nchart.PrintHeight-vertgap,
  integer(rpsVertLine),0,0,0,0,0);
 // Draws coordinate system
 page.NewDrawObject(aposy+nchart.PrintHeight-vertgap,aposx+horzgap,nchart.PrintWidth-horzgap,1,
  integer(rpsHorzLine),0,0,0,0,0);
 // Draw Texts for scales
 numvlabels:=(nchart.PrintHeight-vertgap) div gridvsep;
 // Value relation
 valueinc:=gridvsep*(MaxValue-MinValue)/(nchart.PrintHeight-vertgap);
 avalue:=MinValue;
 for i:=0 to numvlabels do
 begin
  posy:=nchart.PrintHeight-vertgap-i*gridvsep;
  // Draw the line
  page.NewDrawObject(aposy+posy,aposx+horzgap,nchart.PrintWidth-horzgap,1,
   integer(rpsHorzLine),0,0,1,0,0);
  // Draw the caption
  aText:=FormatFloat('########0.00',avalue);
  aTextObj.Text:=aText;
  aTextObj.LFontName:=nchart.LFontName;
  aTextObj.WFontName:=nchart.WFontName;
  aTextObj.FontSize:=nchart.FontSize;
  aTextObj.FontRotation:=nchart.FontRotation;
  aTextObj.FontStyle:=nchart.FontStyle;
  aTextObj.FontColor:=nchart.FontColor;
  aTextObj.Type1Font:=integer(nchart.Type1Font);
  aTextObj.CutText:=nchart.CutText;
  aTextObj.WordWrap:=nchart.WordWrap;
  aTextObj.RightToLeft:=nchart.RightToLeft;
  aTextObj.PrintStep:=nchart.PrintStep;
  aalign:=nchart.PrintAlignment or nchart.VAlignment;
  if nchart.SingleLine then
   aalign:=aalign or AlignmentFlags_SingleLine;
  aTextObj.Alignment:=aalign;
  page.NewTextObject(aposy+posy-(gridvsep div 4),
   aposx,horzgap,gridvsep,aTextobj,nchart.BackColor,nchart.Transparent);
  avalue:=avalue+valueinc;
 end;
 // Draws the lines
 acolor:=0;
 xdesp:=Round((nchart.PrintWidth-horzgap)/(MaxValueCount));
 for i:=0 to Series.Count-1 do
 begin
  aserie:=Series.Items[i];
  pencolor:=SeriesColors[acolor];
  if ASerie.MinValue<>ASerie.MaxValue then
  begin
   for j:=0 to aserie.ValueCount-1 do
   begin
    if j=0 then
    begin
     origin.X:=horzgap;
     origin.Y:=nchart.PrintHeight-vertgap-Round((aserie.Values[j]-MinValue)/(MaxValue-MinValue)*(nchart.PrintHeight-vertgap));
    end;
    destination.X:=origin.X+xdesp;
    destination.Y:=nchart.PrintHeight-vertgap-Round((aserie.Values[j]-MinValue)/(MaxValue-MinValue)*(nchart.PrintHeight-vertgap));
    if destination.Y>origin.Y then
    begin
     shape:=rpsOblique1;
     // Draw the line
      page.NewDrawObject(aposy+origin.Y,aposx+origin.X,xdesp,Destination.Y-Origin.Y,
       integer(shape),0,0,0,0,pencolor);
    end
    else
    begin
     if destination.Y<origin.Y then
     begin
      shape:=rpsOblique2;
      page.NewDrawObject(aposy+origin.Y-(origin.Y-destination.Y),aposx+origin.X,xdesp,Origin.Y-Destination.Y,
       integer(shape),0,0,0,0,pencolor);
     end
     else
     begin
      shape:=rpsHorzLine;
      page.NewDrawObject(aposy+origin.Y,aposx+origin.X,xdesp,1,
       integer(shape),0,0,0,0,pencolor);
     end;
    end;
    Origin:=Destination;
   end;
  end;
  acolor:=((acolor+1) mod MAX_SERIECOLORS);
 end;
end;
{$ENDIF}

procedure TRpPDFDriver.DrawChart(Series:TRpSeries;ametafile:TRpMetaFileReport;posx,posy:integer;achart:TObject);
begin
{$IFNDEF FORWEBAX}
 if assigned(ametafile.OnDrawChart) then
  ametafile.OnDrawChart(Self,Series,ametafile.Pages[ametafile.CurrentPage],posx,posy,achart)
 else
  DoDrawChart(Self,Series,ametafile.Pages[ametafile.CurrentPage],posx,posy,achart);
{$ENDIF}
end;

{$IFDEF LINUX}
procedure PrintMetafileUsingKPrinter(metafile:TRpMetafileReport);
var
 afilename:String;
 destfilename:string;
 alist:TStringList;
begin
 // use a temp file
 alist:=TStringList.Create;
 try
  afilename:=rptempfilename;
  afilename:=changefileext(afilename,'.pdf');
  destfilename:=rptempfilename;
  destfilename:=changefileext(destfilename,'.ps');
  rppdfdriver.SaveMetafileToPDF(metafile,afilename,false);
  try
   alist.Add('pdftops');
   alist.Add(afilename);
   alist.Add(destfilename);
   ExecuteSystemApp(alist,true);
   alist.clear;
   alist.Add('kprinter');
   alist.Add(destfilename);
   try
    ExecuteSystemApp(alist,false);
   finally
//    DeleteFile(destfilename);
   end;
  finally
   DeleteFile(afilename);
  end;
 finally
  alist.free;
 end;
end;
{$ENDIF}

function TRpPDFDriver.GetFontDriver:TRpPrintDriver;
begin
 Result:=Self;
end;



end.
