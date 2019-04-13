{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpqtriver                                       }
{       TRpQTDriver: Printer driver for  QT Libs        }
{       can be used for windows and linux               }
{       it includes printer and bitmap support          }
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

unit rpqtdriver;

interface

{$I rpconf.inc}

uses
{$IFDEF LINUX}
  Libc,
{$ENDIF}
{$IFDEF MSWINDOWS}
  mmsystem,windows,winspool,
{$ENDIF}
 Classes,sysutils,rpmetafile,rpmdconsts,QForms,
 rpmunits,QPrinters,QDialogs,rpgraphutils,
 QStdCtrls,QExtCtrls,types,DateUtils,rptypes,Qt,rppdffile,
{$IFDEF VCLANDCLX}
 rpvgraphutils,
{$ENDIF}
 rpmdcharttypes,
{$IFNDEF FORWEBAX}
 rpbasereport,rpreport,rpmdchart,
 {$IFDEF USECLXTEECHART}
  Chart,Series,rpdrawitem,
  {$IFDEF MSWINDOWS}
  Controls,Graphics,rpgraphutilsvcl,
  {$ENDIF}
  teEngine,ArrowCha,BubbleCh,GanttCh,
 {$ENDIF}
{$ENDIF}
 rptextdriver,rppdfdriver,QGraphics, QControls,rpmaskeditclx, QMask;

const
 METAPRINTPROGRESS_INTERVAL=20;
 SCROLLBAR_HX=20;
 SCROLLBAR_VX=20;
type
  TRpQtDriver=class;
  TFRpQtProgress = class(TForm)
    BOk: TButton;
    BCancel: TButton;
    LProcessing: TLabel;
    LRecordCount: TLabel;
    LTitle: TLabel;
    LTittle: TLabel;
    GBitmap: TGroupBox;
    LHorzRes: TLabel;
    LVertRes: TLabel;
    EHorzRes: TRpCLXMaskEdit;
    EVertRes: TRpCLXMaskEdit;
    CheckMono: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOKClick(Sender: TObject);
  private
    { Private declarations }
    allpages,collate:boolean;
    dook:boolean;
    frompage,topage,copies:integer;
    printerindex:TRpPrinterSelect;
    MetaBitmap:TBitmap;
    bitresx,bitresy:Integer;
    bitmono:Boolean;
    procedure AppIdle(Sender:TObject;var done:boolean);
    procedure AppIdleBitmap(Sender:TObject;var done:boolean);
{$IFNDEF FORWEBAX}
    procedure AppIdleReport(Sender:TObject;var done:boolean);
    procedure AppIdlePrintPDF(Sender:TObject;var done:boolean);
    procedure AppIdlePrintRange(Sender:TObject;var done:boolean);
    procedure AppIdlePrintRangeText(Sender:TObject;var done:boolean);
    procedure RepProgress(Sender:TRpBaseReport;var docancel:boolean);
{$ENDIF}
  public
    { Public declarations }
    forceprintername:string;
    pdfcompressed:boolean;
    cancelled:boolean;
    oldonidle:TIdleEvent;
    tittle:string;
    filename:string;
    errorproces:boolean;
    errormessage:String;
    metafile:TRpMetafileReport;
{$IFNDEF FORWEBAX}
    report:TRpReport;
{$ENDIF}
    qtdriver:TRpQtDriver;
    TextDriver:TRpTextDriver;
    pdfdriver:TRpPDFDriver;
  end;


 TRpQtDriver=class(TRpPrintDriver)
  private
    FReport:TRpMetafileReport;
    BackColor:integer;
   intdpix,intdpiy:integer;
   FOrientation:TRpOrientation;
   FIntPageSize:TPageSizeQt;
   OldOrientation:TPrinterOrientation;
   DrawerBefore,DrawerAfter:Boolean;
   calconly:boolean;
   function InternalSetPagesize(PagesizeQt:integer):TPoint;
{$IFDEF VCLANDCLX}
   procedure SendAfterPrintOperations;
{$ENDIF}
   procedure UpdateBitmapSize(report:TrpMetafileReport;apage:TrpMetafilePage);
   procedure IntDrawObject(page:TRpMetaFilePage;obj:TRpMetaObject;selected:boolean);
  public
   forceprintername:string;
   bitmap:TBitmap;
   dpi:integer;
   toprinter:boolean;
   scale:double;
   offset:TPoint;
   bitmapwidth,bitmapheight:integer;
   PreviewStyle:TRpPreviewStyle;
   clientwidth,clientheight:integer;
   printerindex:TRpPrinterSelect;
   FontDriver:TRpPrintDriver;
   procedure NewDocument(report:TrpMetafileReport;hardwarecopies:integer;
    hardwarecollate:boolean);override;
   procedure EndDocument;override;
   procedure AbortDocument;override;
   procedure NewPage(metafilepage:TRpMetafilePage);override;
   procedure EndPage;override;
   procedure DrawObject(page:TRpMetaFilePage;obj:TRpMetaObject);override;
   procedure DrawChart(Series:TRpSeries;ametafile:TRpMetaFileReport;posx,posy:integer;achart:TObject);override;
{$IFNDEF FORWEBAX}
 {$IFDEF USECLXTEECHART}
   procedure DoDrawChart(adriver:TRpPrintDriver;Series:TRpSeries;page:TRpMetaFilePage;
    aposx,aposy:integer;xchart:TObject);
 {$ENDIF}
{$ENDIF}
   procedure PrintObject(Canvas:TCanvas;page:TRpMetafilePage;obj:TRpMetaObject;
    dpix,dpiy:integer;scale:double;offset:TPoint;selected:boolean);
   procedure DrawPage(apage:TRpMetaFilePage);override;
   procedure TextExtent(atext:TRpTextObject;var extent:TPoint);override;
   procedure GraphicExtent(Stream:TMemoryStream;var extent:TPoint;dpi:integer);override;
   function AllowCopies:boolean;override;
   procedure SelectPrinter(printerindex:TRpPrinterSelect);override;
   function GetPageSize(var PageSizeQt:Integer):TPoint;override;
   function SetPagesize(PagesizeQt:TPageSizeQt):TPoint;override;
   procedure SetOrientation(Orientation:TRpOrientation);override;
   function SupportsCopies(maxcopies:integer):boolean;override;
   function SupportsCollation:boolean;override;
   constructor Create;
   destructor Destroy;override;
   function GetFontDriver:TRpPrintDriver;override;
  end;

function PrintMetafile (metafile:TRpMetafileReport; tittle:string;
 showprogress,allpages:boolean; frompage,topage,copies:integer;
  collate:boolean; printerindex:TRpPrinterSelect;forceprintername:String=''):boolean;
function MetafileToBitmap(metafile:TRpMetafileReport;ShowProgress:Boolean;
 Mono:Boolean;resx:integer=200;resy:integer=100):TBitmap;
function AskBitmapProps(var HorzRes,VertRes:Integer;var Mono:Boolean):Boolean;

{$IFNDEF FORWEBAX}
function CalcReportWidthProgress (report:TRpReport):boolean;
function PrintReport (report:TRpReport; Caption:string; progress:boolean;
  allpages:boolean; frompage,topage,copies:integer; collate:boolean;forceprintername:String=''):Boolean;
function ExportReportToPDF (report:TRpReport; Caption:string; progress:boolean;
  allpages:boolean; frompage,topage,copies:integer;
  showprintdialog:boolean; filename:string;compressed:boolean;collate:boolean):Boolean;
function ExportReportToPDFMetaStream (report:TRpReport; Caption:string; progress:boolean;
  allpages:boolean; frompage,topage,copies:integer;
  showprintdialog:boolean; stream:TStream; compressed:boolean;collate:boolean;metafile:Boolean):Boolean;
{$ENDIF}

// Because copies and collation not work in Windows we
// use the ShowPrintdialog in rpprintdia
function DoShowPrintDialog (var allpages:boolean;
 var frompage,topage,copies:integer; var collate:boolean; disablecopies:boolean=false):boolean;
function PrinterSelection (printerindex:TRpPrinterSelect):TPoint;
procedure PageSizeSelection (rpPageSize:TPageSizeQt);
procedure OrientationSelection (neworientation:TRpOrientation);

 var
{$IFDEF MSWINDOWS}
  kylixprintbug:boolean=false;
{$ENDIF}
{$IFDEF LINUX}
  kylixprintbug:boolean=false;
{$ENDIF}

function GetQtPageSize(value:integer):integer;

implementation

uses rpprintdia;

{$R *.xfm}

function GetQtPageSize(value:integer):integer;
begin
 Result:=value;
 if Result>1000 then
  Result:=0;
end;

const
 AlignmentFlags_AlignHJustify = 1024 { $400 };

function DoShowPrintDialog(var allpages:boolean;
 var frompage,topage,copies:integer;var collate:boolean;disablecopies:boolean=false):boolean;
begin
 Result:=false;
 QPrinter_setMinMax(QPrinterH(Printer.Handle),1,999999);
 QPrinter_setFromTo(QPrinterH(Printer.Handle),frompage,topage);
 if copies>0 then
 begin
  QPrinter_setNumCopies(QprinterH(printer.Handle),copies);
  if Not Collate then
   QPrinter_setPageOrder(QPrinterH(Printer.Handle),qt.QPrinterPageOrder_FirstPageFirst)
  else
   QPrinter_setPageOrder(QPrinterH(Printer.Handle),qt.QPrinterPageOrder_LastPageFirst);
 end;
 if Integer(QPrinter_setup(QPrinterH(Printer.handle),nil))<>0 then
 begin
  frompage:=QPrinter_fromPage(QPrinterH(Printer.handle));
  topage:=QPrinter_toPage(QPrinterH(Printer.handle));
  // Collate does not work, copies does not work
  copies:=QPrinter_numCopies(QPrinterH(Printer.Handle));
  collate:=qt.QPrinterPageOrder_LastPageFirst=QPrinter_PageOrder(QPrinterH(Printer.Handle));
  allpages:=false;
  Result:=true;
 end;
end;

constructor TRpQtDriver.Create;
begin
 offset.X:=0;
 offset.Y:=0;
 // By default 1:1 scale
 FIntPageSize.Custom:=false;
 dpi:=Screen.PixelsPerInch;
 scale:=1;
end;

destructor TRpQtDriver.Destroy;
begin
 if assigned(bitmap) then
 begin
  bitmap.free;
  bitmap:=nil;
 end;
 inherited Destroy;
end;

function TRpQtDriver.SupportsCollation:boolean;
begin
 Result:=false;
end;

function TRpQtDriver.SupportsCopies(maxcopies:integer):boolean;
begin
 Result:=false;
end;

procedure TRpQtDriver.UpdateBitmapSize(report:TrpMetafileReport;apage:TrpMetafilePage);
var
 awidth,aheight:integer;
 rec:TRect;
 asize:TPoint;
 scale2:double;
 frompage:boolean;
begin
  // Offset is 0 in preview
  offset.X:=0;
  offset.Y:=0;
  if Not assigned(bitmap) then
  begin
   bitmap:=TBitmap.Create;
   bitmap.PixelFormat:=pf32bit;
  end;
  BackColor:=report.BackColor;
  frompage:=false;
  if assigned(apage) then
   if apage.UpdatedPageSize then
    frompage:=true;
  if frompage then
  begin
   SetOrientation(apage.Orientation);
   asize.X:=apage.PageSizeqt.PhysicWidth;
   asize.Y:=apage.PageSizeqt.PhysicHeight;
  end
  else
  begin
   SetOrientation(report.Orientation);
   asize.X:=report.CustomX;
   asize.Y:=report.CustomY;
  end;
  bitmapwidth:=Round((asize.x/TWIPS_PER_INCHESS)*dpi);
  bitmapheight:=Round((asize.y/TWIPS_PER_INCHESS)*dpi);

  awidth:=bitmapwidth;
  aheight:=bitmapheight;

  if clientwidth>0 then
  begin
   // Calculates the scale
   case PreviewStyle of
    spWide:
     begin
      // Adjust clientwidth to bitmap width
      scale:=(clientwidth-SCROLLBAR_VX)/bitmapwidth;
     end;
    spNormal:
     begin
      scale:=1.0;
     end;
    spEntirePage:
     begin
      // Adjust client to bitmap with an height
      scale:=(clientwidth-1)/bitmapwidth;
      scale2:=(clientheight-1)/bitmapheight;
      if scale2<scale then
       scale:=scale2;
     end;
   end;
  end;
  if scale<0.01 then
   scale:=0.01;
  if scale>10 then
   scale:=10;
  // Sets page size and orientation
  bitmap.Width:=Round(awidth*scale);
  bitmap.Height:=Round(aheight*scale);
  if bitmap.Width<1 then
   bitmap.Width:=1;
  if bitmap.Height<1 then
   bitmap.Height:=1;

  Bitmap.Canvas.Brush.Style:=bsSolid;
  Bitmap.Canvas.Brush.Color:=BackColor;
  rec.Top:=0;
  rec.Left:=0;
  rec.Right:=Bitmap.Width+1;
  rec.Bottom:=Bitmap.Height+1;
  bitmap.Canvas.FillRect(rec);

  // Draw Page Margins none for qt driver because they
  // are very innacurate
{  QPrinter_margins(QPrinterH(Printer.Handle),@amargins);
  bitmap.Canvas.Pen.Style:=psSolid;
  bitmap.Canvas.Pen.Color:=clBlack;
  bitmap.Canvas.Brush.Style:=bsclear;
  bitmap.Canvas.rectangle(amargins.cx,amargins.cy,
  rec.Right-amargins.cx,rec.Bottom-amargins.cy);
}
end;

procedure TRpQtDriver.NewDocument(report:TrpMetafileReport;hardwarecopies:integer;
  hardwarecollate:boolean);
var
 asize:TPoint;
 sizeqt:integer;
begin
 FReport:=report;
{$IFDEF USECLXTEECHART}
   report.OnDrawChart:=DoDrawChart;
{$ENDIF}
 printerindex:=report.PrinterSelect;
 DrawerBefore:=report.OpenDrawerBefore;
 DrawerAfter:=report.OpenDrawerAfter;
 if printer.Printers.Count>0 then
  QPrinter_setFullPage(QPrinterH(Printer.Handle),true);
 if ToPrinter then
 begin
  scale:=1.0;
  // Set full page
  printer.Title:=SRpUntitled;
  SetOrientation(report.Orientation);
  // Sets pagesize, only supports default and qt index
  if report.PageSize<0 then
  begin
   asize:=GetPageSize(sizeqt);
  end
  else
  begin
   asize:=InternalSetPageSize(report.PageSize);
  end;
  if Length(printer.Title)<1 then
   printer.Title:='Untitled';
  QPrinter_setFullPage(QPrinterH(Printer.Handle),true);
//  begin
//   QPrinter_setOrientation(QPrinterH(Printer.Handle),QPrinterOrientation_Portrait);
//   QPrinter_setOrientation(QPrinterH(Printer.Handle),QPrinterOrientation_Landscape);
//  end;
  if Not Printer.Printing then
   if DrawerBefore then
   begin
{$IFDEF VCLANDCLX}
    SendControlCodeToPrinter(GetPrinterRawOp(printerindex,rawopopendrawer));
{$ENDIF}
{$IFDEF LINUX}
    SendTextToPrinter(GetPrinterRawOp(printerindex,rawopopendrawer),printerindex,SRpOpenDrawerAfter,forceprintername);
{$ENDIF}
   end;
  if Not Printer.Printing then
  begin
   printer.copies:=1;
   QPrinter_setNumCopies(QprinterH(printer.Handle),1);
   printer.BeginDoc;
  end;
  intdpix:=printer.XDPI;
  intdpiy:=printer.YDPI;
 end
 else
 begin
  UpdateBitmapSize(report,nil);
 end;
end;

procedure TRpQtDriver.EndDocument;
begin
 if toprinter then
 begin
  printer.EndDoc;
  if DrawerAfter then
  begin
{$IFDEF VCLANDCLX}
   SendControlCodeToPrinter(GetPrinterRawOp(printerindex,rawopopendrawer));
{$ENDIF}
{$IFDEF LINUX}
   SendTextToPrinter(GetPrinterRawOp(printerindex,rawopopendrawer),printerindex,SRpOpenDrawerAfter,forceprintername);
{$ENDIF}
  end;
{$IFDEF VCLANDCLX}
  // Send Especial operations
  SendAfterPrintOperations;
{$ENDIF}
 end
 else
 begin
  // Does nothing because the last bitmap can be usefull
 end;
end;

procedure TRpQtDriver.AbortDocument;
begin
 if toprinter then
 begin
  printer.Abort;
 end
 else
 begin
  if assigned(bitmap) then
   bitmap.free;
  bitmap:=nil;
 end;
end;

procedure TRpQtDriver.NewPage(metafilepage:TRpMetafilePage);
begin
 if toprinter then
 begin
  if metafilepage.UpdatedPageSize then
  begin
   QPrinter_newPage(QPrinterH(Printer.Handle));
  end
  else
   printer.NewPage;
 end
 else
 begin
  UpdateBitmapSize(FReport,metafilepage);
 end;
end;

procedure TRpQtDriver.EndPage;
begin
 // Does nothing
end;

procedure TRpQtDriver.TextExtent(atext:TRpTextObject;var extent:TPoint);
var
 dpix,dpiy:integer;
 Canvas:TCanvas;
 aalign:integeR;
 arec:Trect;
 maxextent:TPoint;
begin
 if atext.FontRotation<>0 then
  exit;
 if atext.CutText then
 begin
  maxextent:=extent;
 end;
 if (toprinter) then
 begin
  // If to printer then begin doc
  if not printer.Printing then
   Raise Exception.Create(SRpQtDriverNotInit);
  dpix:=intdpix;
  dpiy:=intdpiy;
  Canvas:=printer.canvas;
 end
 else
 begin
  if not Assigned(bitmap) then
   Raise Exception.Create(SRpQtDriverNotInit);
  Canvas:=bitmap.canvas;
  dpix:=dpi;
  dpiy:=dpi;
 end;
{$IFDEF MSWINDOWS}
 Canvas.Font.Name:=atext.WFontName;
{$ENDIF}
{$IFDEF LINUX}
 Canvas.Font.Name:=atext.LFontName;
{$ENDIF}
 Canvas.Font.Color:=atext.FontColor;
 Canvas.Font.Style:=IntegerToFontStyle(atext.FontStyle);
 Canvas.Font.Size:=atext.FontSize;
 aalign:=atext.Alignment;
 if Not atext.CutText then
  aalign:=aalign or Integer(AlignmentFlags_DontClip);
 if atext.Wordwrap then
  aalign:=aalign or Integer(AlignmentFlags_WordBreak);
 arec.Left:=0;
 arec.Top:=0;
 arec.Right:=Round(extent.X*dpix/TWIPS_PER_INCHESS);
 arec.Bottom:=0;
 Canvas.TextExtent(atext.Text,arec,aalign);
 extent.Y:=Round(arec.Bottom/dpiy*TWIPS_PER_INCHESS);
 extent.X:=Round(arec.Right/dpix*TWIPS_PER_INCHESS);
 if (atext.CutText) then
 begin
  if maxextent.Y<extent.Y then
   extent.Y:=maxextent.Y;
 end;
end;

procedure TRpQtDriver.PrintObject(Canvas:TCanvas;page:TRpMetafilePage;obj:TRpMetaObject;
 dpix,dpiy:integer;scale:double;offset:TPoint;selected:boolean);
var
 posx,posy:integer;
 rec:TRect;
 atext:Widestring;
// recsrc:TRect;
 X, Y, W, H, S: Integer;
 Width,Height:integer;
 stream:TMemoryStream;
 bitmap:TBitmap;
 aalign:Integer;
 arec,R:TRect;
{$IFDEF MSWINDOWS}
 bitmapwidth,bitmapheight:integer;
{$ENDIF}
begin
 // Switch to device points
 posx:=round((obj.Left+offset.X)*dpix*scale/TWIPS_PER_INCHESS);
 posy:=round((obj.Top+offset.Y)*dpiy*scale/TWIPS_PER_INCHESS);
 case obj.Metatype of
  rpMetaText:
   begin
{$IFDEF MSWINDOWS}
    Canvas.Font.Name:=page.GetWFontName(Obj);
{$ENDIF}
{$IFDEF LINUX}
    Canvas.Font.Name:=page.GetLFontName(Obj);
{$ENDIF}
    if (selected) then
     Canvas.Brush.Color:=clHighlightText
    else
     Canvas.Font.Color:=Obj.FontColor;
    Canvas.Font.Style:=IntegerToFontStyle(obj.FontStyle);
    Canvas.Font.Size:=Obj.FontSize;
    aalign:=obj.Alignment;
    if Not obj.CutText then
     aalign:=aalign or Integer(AlignmentFlags_DontClip);
    if obj.Wordwrap then
     aalign:=aalign or Integer(AlignmentFlags_WordBreak);
    rec.Left:=posx;
    rec.Top:=posy;
    rec.Right:=posx+round(obj.Width*dpix*scale/TWIPS_PER_INCHESS);
    rec.Bottom:=posy+round(obj.Height*dpiy*scale/TWIPS_PER_INCHESS);
    // Not Transparent
    if ((Not obj.Transparent) or selected) then
    begin
     arec:=rec;
     Canvas.TextExtent(page.GetText(obj),arec,aalign);
     arec.Right:=arec.Left+Round((arec.Right-arec.Left)*scale);
     arec.Bottom:=arec.Top+Round((arec.Bottom-arec.Top)*scale);
     Canvas.Brush.Style:=bsSolid;
     if (selected) then
      Canvas.Brush.Color:=clHighlight
     else
      Canvas.Brush.Color:=obj.BackColor;
     Canvas.FillRect(arec);
    end
    else
     Canvas.Brush.Style:=bsClear;

    atext:=page.GetText(Obj);
    if obj.RightToLeft then
     atext:=DoReverseStringW(atext);
    if obj.FontRotation<>0 then
    begin
     Canvas.Start;
     try
      QPainter_setFont(Canvas.Handle, Canvas.Font.Handle);
      QPainter_setPen(Canvas.Handle, Canvas.Font.FontPen);
      QPainter_save(Canvas.Handle);
      try
       QPainter_translate(Canvas.Handle,posx,posy+Round(Canvas.Font.Size/72*dpiy)*scale);
       QPainter_rotate(Canvas.Handle,-obj.FontRotation/10);
       QPainter_scale(Canvas.Handle,scale,scale);
       // Qt driver does not support oriented multiline text
       QPainter_drawText(Canvas.Handle,0,0,PWideString(@atext),Length(Atext));
      finally
       QPainter_restore(Canvas.Handle);
      end;
     finally
      Canvas.Stop;
     end;
    end
    else
    begin
     posx:=round((obj.Left+offset.X)*dpix/TWIPS_PER_INCHESS);
     posy:=round((obj.Top+offset.Y)*dpiy/TWIPS_PER_INCHESS);
     rec.Left:=posx;
     rec.Top:=posy;
     rec.Right:=posx+round(obj.Width*dpix/TWIPS_PER_INCHESS);
     rec.Bottom:=posy+round(obj.Height*dpiy/TWIPS_PER_INCHESS);
     Canvas.Start;
     try      R.Left := posx;
      R.Top := posy;
      R.Right := rec.Right;
      R.Bottom := rec.Bottom;
      QPainter_setFont(Canvas.Handle, Canvas.Font.Handle);
      QPainter_setPen(Canvas.Handle, Canvas.Font.FontPen);
      QPainter_save(Canvas.Handle);
      try
       QPainter_scale(Canvas.Handle,scale,scale);       QPainter_drawText(Canvas.Handle, @R, aalign, PWideString(@atext), -1,        @Rec, nil);      finally       QPainter_restore(Canvas.Handle);
      end;
     finally
       Canvas.Stop;
      end;
//      Canvas.TextRect(rec,posx,posy,atext,aalign);
    end;
   end;
  rpMetaDraw:
   begin
    Width:=round(obj.Width*dpix*scale/TWIPS_PER_INCHESS);
    Height:=round(obj.Height*dpiy*scale/TWIPS_PER_INCHESS);
// Workaround CLX bug. On printed version detail band shapes appear in black color and psSolid.
       Canvas.Pen.Color := 0;
       Canvas.Pen.Style := psSolid;


    Canvas.Pen.Color:=obj.Pencolor;
    Canvas.Pen.Style:=TPenStyle(obj.PenStyle);
    Canvas.Brush.Color:=obj.BrushColor;
    Canvas.Brush.Style:=TBrushStyle(obj.BrushStyle);
    Canvas.Pen.Width:=Round(dpix*scale*obj.PenWidth/TWIPS_PER_INCHESS);
    X := Canvas.Pen.Width div 2;
    Y := X;
    W := Width - Canvas.Pen.Width + 1;
    H := Height - Canvas.Pen.Width + 1;
    if Canvas.Pen.Width = 0 then
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
      Canvas.Rectangle(X+PosX, Y+PosY, X+PosX + W, Y +PosY+ H);
     rpsRoundRect, rpsRoundSquare:
      Canvas.RoundRect(X+PosX, Y+PosY, X +PosX+ W, Y + PosY+H, Round(22*dpix/96),Round(22*dpiy/96));
     rpsCircle, rpsEllipse:
      Canvas.Ellipse(X+PosX, Y+PosY, X+PosX + W, Y+PosY + H);
     rpsHorzLine:
      begin
       Canvas.MoveTo(X+PosX, Y+PosY);
       Canvas.LineTo(X+PosX+W, Y+PosY);
      end;
     rpsVertLine:
      begin
       Canvas.MoveTo(X+PosX, Y+PosY);
       Canvas.LineTo(X+PosX, Y+PosY+H);
      end;
     rpsOblique1:
      begin
       Canvas.MoveTo(X+PosX, Y+PosY);
       Canvas.LineTo(X+PosX+W, Y+PosY+H);
      end;
     rpsOblique2:
      begin
       Canvas.MoveTo(X+PosX, Y+PosY+H);
       Canvas.LineTo(X+PosX+W, Y+PosY);
      end;
    end;
   end;
  rpMetaImage:
   begin
    if (not (obj.previewonly and toprinter)) then
    begin
    Width:=round(obj.Width*dpix*scale/TWIPS_PER_INCHESS);
    Height:=round(obj.Height*dpiy*scale/TWIPS_PER_INCHESS);
    rec.Top:=PosY;
    rec.Left:=PosX;
    rec.Bottom:=rec.Top+Height-1;
    rec.Right:=rec.Left+Width-1;

    stream:=page.GetStream(obj);
    bitmap:=TBitmap.Create;
    try
// Windows does not have support for jpeg in CLX
{$IFDEF VCLANDCLX}
     if GetJPegInfo(stream,bitmapwidth,bitmapheight) then
     begin
      rpvgraphutils.JPegStreamToBitmapStream(stream);
     end;
{$ENDIF}
      bitmap.LoadFromStream(stream);
//     Copy mode does not work for Stretchdraw
//     Canvas.CopyMode:=TCopyMode(obj.CopyMode);

     case TRpImageDrawStyle(obj.DrawImageStyle) of
      rpDrawFull:
       begin
        rec.Bottom:=rec.Top+round((bitmap.height/obj.dpires)*dpiy*scale)-1;
        rec.Right:=rec.Left+round((bitmap.width/obj.dpires)*dpix*scale)-1;
        Canvas.StretchDraw(rec,bitmap);
       end;
      rpDrawStretch:
       Canvas.StretchDraw(rec,bitmap);
      rpDrawCrop:
       begin
//      Crop Should cut graphic but it don't work
//        recsrc.Top:=0;
//        recsrc.Left:=0;
//        recsrc.Bottom:=Height-1;
//        recsrc.Right:=Width-1;
//        Canvas.CopyRect(rec,bitmap.canvas,recsrc);
        Canvas.Draw(PosX,PosY,bitmap);
       end;
      rpDrawTile,rpDrawTiledpi:
       begin
        Canvas.TiledDraw(rec,bitmap);
       end;
     end;
    finally
     bitmap.Free;
    end;
    end;
   end;
 end;
end;

procedure TRpQtDriver.DrawPage(apage:TRpMetaFilePage);
var
 j:integer;
 selected:boolean;
begin
 if not toprinter then
 begin
  UpdateBitmapSize(FReport,apage);
  for j:=0 to apage.ObjectCount-1 do
  begin
    selected:=FReport.IsFound(apage,j);
    IntDrawObject(apage,apage.Objects[j],selected);
  end;
 end
 else
 begin
  for j:=0 to apage.ObjectCount-1 do
  begin
   IntDrawObject(apage,apage.Objects[j],false);
  end;
 end;
end;


procedure TRpQtDriver.DrawObject(page:TRpMetaFilePage;obj:TRpMetaObject);
begin
 IntDrawObject(page,obj,false);
end;

procedure TRpQtDriver.IntDrawObject(page:TRpMetaFilePage;obj:TRpMetaObject;selected:boolean);
var
 dpix,dpiy:integer;
 Canvas:TCanvas;
begin
 if calconly then
  exit;
 if (toprinter) then
 begin
  if not printer.Printing then
   Raise Exception.Create(SRpQtDriverNotInit);
  dpix:=intdpix;
  dpiy:=intdpiy;
  Canvas:=printer.canvas;
 end
 else
 begin
  if not Assigned(bitmap) then
   Raise Exception.Create(SRpQtDriverNotInit);
  Canvas:=bitmap.canvas;
  dpix:=dpi;
  dpiy:=dpi;
 end;
 PrintObject(Canvas,page,obj,dpix,dpiy,scale,offset,selected);
end;

function TRpQtDriver.AllowCopies:boolean;
begin
 Result:=false;
end;


function TrpQtDriver.GetPageSize(var PageSizeQt:Integer):TPoint;
begin
 // If no printer installed get A4 pagesize
 if Printer.printers.count<1 then
 begin
  result.y:=16637;
  result.x:=12047;
  exit;
 end;
 if FIntPageSize.Custom then
 begin
  PageSizeQt:=-1;
  Result.X:=FIntPageSize.CustomWidth;
  Result.Y:=FIntPageSize.CustomHeight;
 end
 else
 begin
  if ((Printer.XDPI=0) or (Printer.YDPI=0)) then
  begin
   result.y:=16637;
   result.x:=12047;
   exit;
  end
  else
  begin
   PageSizeQt:=Printer.PageNumber;
   Result.x:=Round((Printer.PageWidth/Printer.XDPI)*TWIPS_PER_INCHESS);
   Result.y:=Round((Printer.PageHeight/Printer.YDPI)*TWIPS_PER_INCHESS);
  end;
 end;
end;


function TRpQTDriver.SetPagesize(PagesizeQt:TPageSizeQt):TPoint;
begin
 FIntPageSize:=PageSizeQt;
 if FIntPageSize.Custom then
 begin
  Result.X:=PagesizeQt.CustomWidth;
  Result.Y:=PagesizeQt.CustomHeight;
 end
 else
  Result:=InternalSetPageSize(PagesizeQT.Indexqt);
end;

function TRpQTDriver.InternalSetPagesize(PagesizeQt:integer):TPoint;
var
 sizeqt:integer;
begin
 PageSizeQt:=GetQtPageSize(PageSizeQt);
 Printer.PrintAdapter.PageSize:=TPageSize(PagesizeQT);
 if FOrientation<>rpOrientationDefault then
 begin
  if FOrientation=rpOrientationPortrait then
   Printer.Orientation:=poPortrait
  else
   Printer.Orientation:=poLandscape;
 end;
 Result:=GetPageSize(sizeqt);
end;

procedure TRpQTDriver.SetOrientation(Orientation:TRpOrientation);
begin
 FOrientation:=Orientation;
 OldOrientation:=Printer.Orientation;
 if Orientation=rpOrientationPortrait then
 begin
  if Printer.Orientation<>poPortrait then
   Printer.Orientation:=poPortrait;
 end
 else
 if Orientation=rpOrientationLandscape then
  if Printer.Orientation<>poLandsCape then
   Printer.Orientation:=poLandsCape;
end;


procedure DoPrintMetafile(metafile:TRpMetafileReport;tittle:string;
 aform:TFRpQtProgress;allpages:boolean;frompage,topage,copies:integer;
 collate:boolean;printerindex:TRpPrinterSelect;forceprintername:String='');
var
 i:integer;
 j:integer;
 apage:TRpMetafilePage;
 pagecopies:integer;
 reportcopies:integer;
 dpix,dpiy:integer;
 count1,count2:integer;
{$IFDEF MSWINDOWS}
    mmfirst,mmlast:DWORD;
{$ENDIF}
{$IFDEF LINUX}
    milifirst,mililast:TDatetime;
{$ENDIF}
 difmilis:int64;
 totalcount:integer;
 offset:TPoint;
 istextonly:boolean;
 drivername,S:String;
 memstream:TMemoryStream;
 qtdriver:TRpQtDriver;
begin
 if copies<=0 then
  copies:=1;
 drivername:=Trim(GetPrinterEscapeStyleDriver(printerindex));
 istextonly:=Length(drivername)>0;
 if istextonly then
 begin
  memstream:=TMemoryStream.Create;
  try
   rptextdriver.SaveMetafileRangeToText(metafile,allpages,frompage,topage,
    copies,memstream);
   memstream.Seek(soFromBeginning,0);
   SetLength(S,MemStream.Size);
   MemStream.Read(S[1],MemStream.Size);
  finally
   memstream.free;
  end;
  // Now Prints to selected printer the stream
  PrinterSelection(metafile.PrinterSelect);
{$IFDEF VCLANDCLX}
  SendControlCodeToPrinter(S);
{$ENDIF}
{$IFDEF LINUX}
  SendTextToPrinter(S,metafile.PrinterSelect,tittle,forceprintername);
{$ENDIF}
 end
 else
 begin
  if printerindex<>pRpDefaultPrinter then
   offset:=PrinterSelection(printerindex)
  else
  begin
   offset:=PrinterSelection(metafile.PrinterSelect);
  end;
  // Get the time
 {$IFDEF MSWINDOWS}
  mmfirst:=TimeGetTime;
 {$ENDIF}
 {$IFDEF LINUX}
  milifirst:=now;
 {$ENDIF}
  printer.Title:=tittle;
  // Sets page size and orientation
  if metafile.Orientation<>rpOrientationDefault then
  begin
   if metafile.Orientation=rpOrientationPortrait then
    printer.Orientation:=poPortrait
   else
    printer.Orientation:=poLandscape;
  end;
  // Sets pagesize
  if metafile.PageSize>=0 then
   Printer.PrintAdapter.PageSize:=TPageSize(metafile.PageSize);

  pagecopies:=1;
  reportcopies:=1;
  if copies>1 then
  begin
   if collate then
    reportcopies:=copies
   else
    pagecopies:=copies;
  end;
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
  printer.Copies:=1;
  QPrinter_setNumCopies(QprinterH(printer.Handle),1);
  printer.Begindoc;
  try
   qtdriver:=TRpQtDriver.Create;
   try
   dpix:=printer.XDPI;
   dpiy:=printer.YDPI;
   totalcount:=0;
   for count1:=0 to reportcopies-1 do
   begin
    for i:=frompage to topage do
    begin
     for count2:=0 to pagecopies-1 do
     begin
      apage:=metafile.Pages[i];
      if totalcount>0 then
      begin
       printer.NewPage;
      end;
      inc(totalcount);
      for j:=0 to apage.ObjectCount-1 do
      begin
       qtdriver.PrintObject(Printer.Canvas,apage,apage.Objects[j],dpix,dpiy,1,offset,false);
       if assigned(aform) then
       begin
   {$IFDEF MSWINDOWS}
        mmlast:=TimeGetTime;
        difmilis:=(mmlast-mmfirst);
   {$ENDIF}
   {$IFDEF LINUX}
        mililast:=now;
        difmilis:=MillisecondsBetween(mililast,milifirst);
   {$ENDIF}
        if difmilis>MILIS_PROGRESS then
        begin
         // Get the time
   {$IFDEF MSWINDOWS}
         mmfirst:=TimeGetTime;
   {$ENDIF}
   {$IFDEF LINUX}
         milifirst:=now;
   {$ENDIF}
         aform.LRecordCount.Caption:=SRpPage+':'+ IntToStr(i+1)+
           ' - '+SRpItem+':'+ IntToStr(j+1);
         Application.ProcessMessages;
         if aform.cancelled then
          Raise Exception.Create(SRpOperationAborted);
        end;
       end;
      end;
      if assigned(aform) then
      begin
        Application.ProcessMessages;
        if aform.cancelled then
         Raise Exception.Create(SRpOperationAborted);
      end;
     end;
    end;

   end;
   finally
    qtdriver.free;
   end;
   Printer.EndDoc;
  except
   printer.Abort;
   raise;
  end;
  if assigned(aform) then
   aform.close;
 end;
end;

function PrintMetafile(metafile:TRpMetafileReport;tittle:string;
 showprogress,allpages:boolean;frompage,topage,copies:integer;
  collate:boolean;printerindex:TRpPrinterSelect;forceprintername:String=''):boolean;
var
 dia:TFRpQtProgress;
begin
 Result:=true;
 if Not ShowProgress then
 begin
  DoPrintMetafile(metafile,tittle,nil,allpages,frompage,topage,copies,collate,printerindex,forceprintername);
  exit;
 end;
 dia:=TFRpQtProgress.Create(Application);
 try
  dia.oldonidle:=Application.OnIdle;
  try
   dia.metafile:=metafile;
   dia.printerindex:=printerindex;
   dia.tittle:=tittle;
   dia.allpages:=allpages;
   dia.frompage:=frompage;
   dia.topage:=topage;
   dia.copies:=copies;
   dia.collate:=collate;
   Application.OnIdle:=dia.AppIdle;
   dia.ShowModal;
   if dia.errorproces then
    Raise Exception.Create(dia.ErrorMessage);
   Result:=Not dia.cancelled;
  finally
   Application.OnIdle:=dia.oldonidle;
  end;
 finally
  dia.free;
 end;
end;

const
 MAX_RES_BITMAP=5760;

function DoMetafileToBitmap(metafile:TRpMetafileReport;aform:TFRpQtProgress;
 Mono:Boolean;resx:integer=200;resy:integer=100):TBitmap;
var
 QtDriver:TRpQtDriver;
 apage:TRpMetafilePage;
 i,j:integer;
 offset:TPoint;
 pagemargins:TRect;
{$IFDEF MSWINDOWS}
    mmfirst,mmlast:DWORD;
{$ENDIF}
{$IFDEF LINUX}
    milifirst,mililast:TDatetime;
 tmpfile1,tmpfile2:string;
 alist:TStringList;
{$ENDIF}
 difmilis:int64;
 pageheight,pagewidth:integer;
 tempbitmap:TBitmap;
 arec:TRect;
 realdpix:integer;
 realdpiy:integer;
 scale:integer;
 maxdpi:integer;
begin
 // Maximum resolution
 if resx>MAX_RES_BITMAP then
  resx:=MAX_RES_BITMAP;
 if resy>MAX_RES_BITMAP then
  resy:=MAX_RES_BITMAP;
 if resx<1 then
  resx:=1;
 if resy<1 then
  resy:=1;

 realdpix:=Screen.PixelsPerInch;
 realdpiy:=Screen.PixelsPerInch;
 scale:=1;
 if resy>resx then
  maxdpi:=resy
 else
  maxdpi:=resy;
 while scale*realdpix<maxdpi do
  scale:=scale*2;

 offset.X:=0;
 offset.Y:=0;
{$IFDEF MSWINDOWS}
 mmfirst:=TimeGetTime;
{$ENDIF}
{$IFDEF LINUX}
  milifirst:=now;
{$ENDIF}
 pagemargins.Left:=0;
 pagemargins.Top:=0;
 pagemargins.Bottom:=0;
 pagemargins.Top:=0;
 Result:=TBitmap.Create;
 try
  Result.PixelFormat:=pf32bit;
  pagewidth:=(metafile.CustomX*resx) div TWIPS_PER_INCHESS;
  Result.Width:=pagewidth;
  pageheight:=(metafile.CustomY*resy) div TWIPS_PER_INCHESS;
  metafile.RequestPage(MAX_PAGECOUNT);
  Result.Height:=pageheight*metafile.CurrentPageCount;
  arec.Top:=0;
  arec.Left:=0;
  arec.Bottom:=Result.Height*2;
  arec.Right:=Result.Width*2;
  REsult.Canvas.Brush.Color:=metafile.BackColor;
  REsult.Canvas.Brush.Style:=bsSolid;
  Result.Canvas.FillRect(arec);
  QtDriver:=TRpQtDriver.Create;
  try
  qtdriver.toprinter:=false;
  tempbitmap:=TBitmap.Create;
  try
   for i:=0 to metafile.CurrentPageCount-1 do
   begin
    tempbitmap.PixelFormat:=pf32bit;
    tempbitmap.Height:=(metafile.CustomY*realdpiy*scale) div TWIPS_PER_INCHESS;
    tempbitmap.Width:=(metafile.CustomX*realdpix*scale) div TWIPS_PER_INCHESS;
    arec.Top:=0;arec.Bottom:=0;
    arec.Right:=tempbitmap.Width*2;
    arec.Bottom:=tempbitmap.Height*2;

    apage:=metafile.Pages[i];
    tempbitmap.Canvas.Brush.Color:=clWhite;
    tempbitmap.Canvas.Brush.Style:=bsSolid;
    tempbitmap.Canvas.FillRect(arec);
    for j:=0 to apage.ObjectCount-1 do
    begin
     QtDriver.PrintObject(tempbitmap.Canvas,apage,apage.Objects[j],realdpix,
      realdpiy,scale,offset,false);
     if assigned(aform) then
     begin
   {$IFDEF MSWINDOWS}
      mmlast:=TimeGetTime;
      difmilis:=(mmlast-mmfirst);
   {$ENDIF}
   {$IFDEF LINUX}
      mililast:=now;
      difmilis:=MillisecondsBetween(mililast,milifirst);
   {$ENDIF}
      if difmilis>MILIS_PROGRESS then
      begin
       // Get the time
     {$IFDEF MSWINDOWS}
       mmfirst:=TimeGetTime;
     {$ENDIF}
     {$IFDEF LINUX}
       milifirst:=now;
     {$ENDIF}
       aform.LRecordCount.Caption:=SRpPage+':'+ IntToStr(i+1)+
         ' - '+SRpItem+':'+ IntToStr(j+1);
       Application.ProcessMessages;
       if aform.cancelled then
        Raise Exception.Create(SRpOperationAborted);
      end;
     end;
    end;
    arec.Top:=pageheight*i;
    arec.Bottom:=pageheight*i+pageheight;
    arec.Left:=0;
    arec.Right:=pagewidth;
    Result.Canvas.StretchDraw(arec,tempbitmap);
    if assigned(aform) then
    begin
     Application.ProcessMessages;
      if aform.cancelled then
       Raise Exception.Create(SRpOperationAborted);
    end;
   end;
  finally
   tempbitmap.free;
  end;
  finally
   qtdriver.Free;
  end;
  // To obtain monocrhome bitmaps must use convert command line tool
{$IFDEF LINUX}
  if Mono then
  begin
   alist:=TStringList.Create;
   try
    tmpfile1:=RpTempFileName;
    tmpfile2:=RpTempFileName;
    Result.SaveToFile(tmpfile1);
    try
     alist.Add('convert');
     alist.Add('-monochrome');
     alist.Add(tmpfile1);
     alist.Add(tmpfile2);
     ExecuteSystemCommand(alist);
     Result.LoadFromFile(tmpfile2);
    finally
     DeleteFile(tmpfile1);
     DeleteFile(tmpfile2);
    end;
   finally
    alist.free;
   end;
  end;
{$ENDIF}

 except
  Result.free;
  raise;
 end;
end;

function MetafileToBitmap(metafile:TRpMetafileReport;ShowProgress:Boolean;
 Mono:Boolean;resx:integer=200;resy:integer=100):TBitmap;
var
 dia:TFRpQtProgress;
begin
 Result:=nil;
 if Not ShowProgress then
 begin
  Result:=DoMetafileToBitmap(metafile,nil,mono);
  exit;
 end;
 dia:=TFRpQtProgress.Create(Application);
 try
  dia.oldonidle:=Application.OnIdle;
  try
   dia.metafile:=metafile;
   dia.tittle:='Bitmap';
   dia.bitresx:=resx;
   dia.bitresy:=resy;
   dia.bitmono:=Mono;
   Application.OnIdle:=dia.AppIdleBitmap;
   dia.ShowModal;
   if dia.errorproces then
    Raise Exception.Create(dia.ErrorMessage);
   Result:=dia.MetaBitmap;
  finally
   Application.OnIdle:=dia.oldonidle;
  end;
 finally
  dia.free;
 end;
end;

procedure TFRpQtProgress.FormCreate(Sender: TObject);
begin
 LRecordCount.Font.Style:=[fsBold];
 LTittle.Font.Style:=[fsBold];

 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
 LTitle.Caption:=TranslateStr(252,LTitle.Caption);
 LProcessing.Caption:=TranslateStr(253,LProcessing.Caption);

 LHorzRes.Caption:=SRpHorzRes;
 LVertRes.Caption:=SRpVertRes;
 CheckMono.Caption:=SRpMonochrome;

 SetInitialBounds;
end;

procedure TFRpQtProgress.AppIdle(Sender:TObject;var done:boolean);
begin
 cancelled:=false;
 Application.OnIdle:=nil;
 done:=false;
 errorproces:=false;
 try
  LTittle.Caption:=tittle;
  Lprocessing.Visible:=true;
  DoPrintMetafile(metafile,tittle,self,allpages,frompage,topage,copies,collate,printerindex,forceprintername);
 except
  On E:Exception do
  begin
   errorproces:=true;
   ErrorMessage:=E.Message;
  end;
 end;
 Close;
end;

procedure TFRpQtProgress.AppIdleBitmap(Sender:TObject;var done:boolean);
begin
 cancelled:=false;
 Application.OnIdle:=nil;
 done:=false;
 errorproces:=false;
 try
  LTittle.Caption:=tittle;
  LProcessing.Visible:=true;
  MetaBitmap:=DoMetafileToBitmap(metafile,self,bitmono,bitresx,bitresy);
 except
  on E:Exception do
  begin
   errorproces:=true;
   ErrorMessage:=E.Message;
  end;
 end;
 Close;
end;

procedure TFRpQtProgress.BCancelClick(Sender: TObject);
begin
 cancelled:=true;
end;


{$IFNDEF FORWEBAX}
procedure TFRpQtProgress.RepProgress(Sender:TRpBaseReport;var docancel:boolean);
var
 astring:WideString;
begin
 if Not Assigned(LRecordCount) then
  exit;
 if Sender.ProgressToStdOut then
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
 LRecordCount.Caption:=IntToStr(Sender.CurrentSubReportIndex)+':'+SRpPage+':'+
  FormatFloat('#########,####',Sender.PageNum)+'-'+FormatFloat('#########,####',Sender.RecordCount);
 if Sender.LastPage then
   LRecordCount.Caption:=Format('%-20.20s',[SRpPage])+FormatFloat('0000000000',Sender.PageNum+1);
 Application.ProcessMessages;
 if cancelled then
  docancel:=true;
end;

procedure TFRpQtProgress.AppIdleReport(Sender:TObject;var done:boolean);
var
 oldprogres:TRpProgressEvent;
 istextonly:Boolean;
 drivername:String;
 TextDriver:TRpTextDriver;
begin
 Application.Onidle:=nil;
 done:=false;
 errorproces:=false;
 try
  drivername:=Trim(GetPrinterEscapeStyleDriver(report.PrinterSelect));
  istextonly:=Length(drivername)>0;

  if istextonly then
  begin
   TextDriver:=TRpTextDriver.Create;
   try
   TextDriver.SelectPrinter(report.PrinterSelect);
   oldprogres:=report.OnProgress;
   try
    report.OnProgress:=RepProgress;
    report.PrintAll(TextDriver);
   finally
    report.OnProgress:=oldprogres;
   end;
   finally
    TextDriver.free;
   end;
  end
  else
  begin
   qtdriver:=TRpQtDriver.Create;
   try
   qtdriver.forceprintername:=forceprintername;
   oldprogres:=report.OnProgress;
   try
    report.OnProgress:=RepProgress;
    report.PrintAll(qtdriver);
   finally
    report.OnProgress:=oldprogres;
   end;
   finally
    qtdriver.free;
   end;
  end;
 except
  On E:Exception do
  begin
   errorproces:=true;
   ErrorMessage:=E.Message;
  end;
 end;
 Close;
end;

function CalcReportWidthProgress(report:TRpReport):boolean;
var
 dia:TFRpQTProgress;
begin
 Result:=false;
 dia:=TFRpQTProgress.Create(Application);
 try
  dia.oldonidle:=Application.OnIdle;
  try
   dia.report:=report;
   Application.OnIdle:=dia.AppIdleReport;
   dia.ShowModal;
   if dia.errorproces then
    Raise Exception.Create(dia.ErrorMessage);
   Result:=Not dia.cancelled;
  finally
   Application.onidle:=dia.oldonidle;
  end;
 finally
  dia.free;
 end;
end;


procedure TFRpQtProgress.AppIdlePrintRange(Sender:TObject;var done:boolean);
var
 oldprogres:TRpProgressEvent;
begin
 Application.Onidle:=nil;
 done:=false;
 errorproces:=false;
 try
  qtdriver:=TRpQtDriver.Create;
  try
  qtdriver.forceprintername:=forceprintername;
  qtdriver.toprinter:=true;
  oldprogres:=report.OnProgress;
  try
   report.OnProgress:=RepProgress;
   report.PrintRange(qtdriver,allpages,frompage,topage,copies,collate);
  finally
   report.OnProgress:=oldprogres;
  end;
  finally
   qtdriver.free;
  end;
 except
  On E:Exception do
  begin
   errorproces:=true;
   ErrorMessage:=E.Message;
  end;
 end;
 Close;
end;

procedure TFRpQtProgress.AppIdlePrintRangeText(Sender:TObject;var done:boolean);
var
 oldprogres:TRpProgressEvent;
 S:String;
begin
 Application.Onidle:=nil;
 done:=false;
 errorproces:=false;
 try
  TextDriver:=TRpTextDriver.Create;
  try
  oldprogres:=report.OnProgress;
  try
   TextDriver.SelectPrinter(report.PrinterSelect);
   report.OnProgress:=RepProgress;
   report.PrintRange(TextDriver,allpages,frompage,topage,copies,collate);
   // Now Prints to selected printer the stream
   SetLength(S,TextDriver.MemStream.Size);
   TextDriver.MemStream.Read(S[1],TextDriver.MemStream.Size);
   PrinterSelection(report.PrinterSelect);
{$IFDEF VCLANDCLX}
   SendControlCodeToPrinter(S);
{$ENDIF}
{$IFDEF LINUX}
   SendTextToPrinter(S,report.PrinterSelect,tittle,forceprintername);
{$ENDIF}
  finally
   report.OnProgress:=oldprogres;
  end;
  finally
   textdriver.free;
  end;
 except
  On E:Exception do
  begin
   errorproces:=true;
   ErrorMessage:=E.Message;
  end;
 end;
 Close;
end;


procedure TFRpQtProgress.AppIdlePrintPDF(Sender:TObject;var done:boolean);
var
 oldprogres:TRpProgressEvent;
 qtdriver:TRpQtDriver;
begin
 Application.Onidle:=nil;
 done:=false;
 errorproces:=false;
 try
  pdfdriver:=TRpPDFDriver.Create;
  qtdriver:=TRpQtDriver.Create;
  try
   pdfdriver.filename:=filename;
   pdfdriver.compressed:=pdfcompressed;
{$IFDEF USECLXTEECHART}
   report.metafile.OnDrawChart:=qtdriver.DoDrawChart;
{$ENDIF}
   qtdriver.forceprintername:=forceprintername;
   oldprogres:=report.OnProgress;
   try
    report.OnProgress:=RepProgress;
    report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
   finally
    report.OnProgress:=oldprogres;
   end;
  finally
   pdfdriver.free;
   qtdriver.free;
  end;
 except
  On E:Exception do
  begin
   errorproces:=true;
   ErrorMessage:=E.Message;
  end;
 end;
 Close;
end;



function PrintReport(report:TRpReport;Caption:string;progress:boolean;
  allpages:boolean;frompage,topage,copies:integer;collate:boolean;forceprintername:String=''):Boolean;
var
{$IFDEF LINUXPRINTBUG}
 abuffer:array [0..L_tmpnam] of char;
 theparams:array [0..20] of pchar;
 params:array[0..20] of string;
 paramcount:integer;
 afilename:string;
 child:__pid_t;
 i:integer;
{$ENDIF}
 qtdriver:TRpQtDriver;
 Textdriver:TRpTextDriver;
 forcecalculation:boolean;
 dia:TFRpQtProgress;
 oldonidle:TIdleEvent;
 istextonly:boolean;
 drivername:String;
 S:String;
begin
 drivername:=Trim(GetPrinterEscapeStyleDriver(report.PrinterSelect));
 istextonly:=Length(drivername)>0;
 Result:=true;
 forcecalculation:=false;
 if kylixprintbug then
  forcecalculation:=true;
 if ((report.copies>1) and (report.CollateCopies)) then
 begin
  forcecalculation:=true;
 end;
 if report.TwoPass then
  forcecalculation:=true;
 if forcecalculation then
 begin
  if progress then
  begin
   if Not CalcReportWidthProgress(report) then
   begin
    Result:=false;
    exit;
   end;
  end
  else
  begin
   if istextonly then
   begin
    TextDriver:=TRpTextDriver.Create;
    try
     TextDriver.SelectPrinter(report.PrinterSelect);
     report.PrintAll(TextDriver);
    finally
     Textdriver.free;
    end;
   end
   else
   begin
    qtdriver:=TRpQtDriver.Create;
    try
     qtdriver.forceprintername:=forceprintername;
     report.PrintAll(qtdriver);
    finally
     qtdriver.free;
    end;
   end;
  end;
 end;
 // A bug in Kylix 2 does not allow printing
 // when using dbexpress in some systems
 if not kylixprintbug then
 begin
   if forcecalculation then
   begin
    PrintMetafile(report.Metafile,Caption,progress,allpages,frompage,topage,copies,collate,report.PrinterSelect,forceprintername);
   end
   else
   begin
    if progress then
    begin
     // Assign appidle frompage to page...
     dia:=TFRpQtProgress.Create(Application);
     try
      dia.allpages:=allpages;
      dia.frompage:=frompage;
      dia.topage:=topage;
      dia.copies:=copies;
      dia.report:=report;
      dia.forceprintername:=forceprintername;
      dia.collate:=collate;
      oldonidle:=Application.Onidle;
      try
       if istextonly then
        Application.OnIdle:=dia.AppIdlePrintRangeText
       else
        Application.OnIdle:=dia.AppIdlePrintRange;
       dia.ShowModal;
       if dia.errorproces then
        Raise Exception.Create(dia.ErrorMessage);
      finally
       Application.OnIdle:=oldonidle;
      end;
     finally
      dia.Free;
     end;
    end
    else
    begin
     if istextonly then
     begin
      TextDriver:=TRpTextDriver.Create;
      try
       TextDriver.SelectPrinter(report.PrinterSelect);
       report.PrintRange(TextDriver,allpages,frompage,topage,copies,collate);
       SetLength(S,TextDriver.MemStream.Size);
       TextDriver.MemStream.Read(S[1],TextDriver.MemStream.Size);
       PrinterSelection(report.PrinterSelect);
{$IFDEF VCLANDCLX}
       SendControlCodeToPrinter(S);
{$ENDIF}
{$IFDEF LINUX}
      SendTextToPrinter(S,report.PrinterSelect,Caption,forceprintername);
{$ENDIF}
      finally
       TextDriver.free;
      end;
     end
     else
     begin
      qtdriver:=TRpQtDriver.Create;
      try
      qtdriver.forceprintername:=forceprintername;
      qtdriver.toprinter:=true;
      report.PrintRange(qtdriver,allpages,frompage,topage,copies,collate);
      finally
       qtdriver.free;
      end;
     end;
    end;
   end;
 end
{$IFDEF LINUXPRINTBUG}
 else
 begin
   // When compiling metaview the bug can be skiped
   // Saves the metafile
   // Selects the printer for that report
   tmpnam(abuffer);
   afilename:=StrPas(abuffer);
   report.Metafile.SaveToFile(afilename);
   params[0]:='metaprint';
   params[1]:='-d';
   params[2]:='-copies';
   params[3]:=IntToStr(copies);
   params[4]:='-p';
   params[5]:=IntToStr(integer(report.PrinterSelect));
   paramcount:=6;
   if collate then
   begin
    params[paramcount]:='-collate';
    inc(paramcount);
   end;
   if not allpages then
   begin
    params[paramcount]:='-from';
    inc(paramcount);
    params[paramcount]:=IntToStr(frompage);
    inc(paramcount);
    params[paramcount]:='-to';
    inc(paramcount);
    params[paramcount]:=IntToStr(topage);
    inc(paramcount);
   end;
   if not progress then
   begin
    params[paramcount]:='-q';
    inc(paramcount);
   end;
   params[paramcount]:=afilename;
   inc(paramcount);

   for i:=0 to paramcount-1 do
   begin
    theparams[i]:=Pchar(params[i]);
   end;
   theparams[paramcount]:=nil;

   child:=fork;
   if child=-1 then
    Raise Exception.Create(SRpErrorFork);
   if child<>0 then
   begin
    if (-1=execv(theparams[0],PPChar(@theparams))) then
    begin
     try
      RaiseLastOsError;
     except
      on E:Exception do
      begin
       E.Message:=SRpErrorFork+':execv:'+IntToStr(errno)+'-'+E.Message;
       Raise;
      end;
     end;
    end;
   end
 end;
{$ENDIF}
end;


function ExportReportToPDF(report:TRpReport;Caption:string;progress:boolean;
  allpages:boolean;frompage,topage,copies:integer;
  showprintdialog:boolean;filename:string;compressed:boolean;collate:boolean):Boolean;
var
 dia:TFRpQtProgress;
 oldonidle:TIdleEvent;
 pdfdriver:TRpPDFDriver;
{$IFDEF USECLXTEECHART}
 qtdriver:TRpQtDriver;
{$ENDIF}
begin
 Result:=false;
 allpages:=true;
 if showprintdialog then
 begin
  if Not rpprintdia.DoShowPrintDialog(allpages,frompage,topage,copies,collate,true) then
   exit;
 end;
 if progress then
 begin
  // Assign appidle frompage to page...
  dia:=TFRpQtProgress.Create(Application);
  try
   dia.allpages:=allpages;
   dia.frompage:=frompage;
   dia.topage:=topage;
   dia.copies:=copies;
   dia.report:=report;
   dia.filename:=filename;
   dia.pdfcompressed:=compressed;
   dia.collate:=collate;
   oldonidle:=Application.Onidle;
   try
    Application.OnIdle:=dia.AppIdlePrintPdf;
    dia.ShowModal;
    if dia.errorproces then
     Raise Exception.Create(dia.ErrorMessage);
   finally
    Application.OnIdle:=oldonidle;
   end;
  finally
   dia.Free;
  end;
 end
 else
 begin
  pdfdriver:=TRpPDFDriver.Create;
  try
  pdfdriver.filename:=filename;
  pdfdriver.compressed:=compressed;
{$IFDEF USECLXTEECHART}
  qtdriver:=TRpQtDriver.Create;
  report.Metafile.OnDrawChart:=qtdriver.DoDrawChart;
{$ENDIF}
  report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
  finally
   pdfdriver.free;
  end;
  Result:=True;
 end;
end;

function ExportReportToPDFMetaStream (report:TRpReport; Caption:string; progress:boolean;
  allpages:boolean; frompage,topage,copies:integer;
  showprintdialog:boolean; stream:TStream; compressed:boolean;collate:boolean;metafile:Boolean):Boolean;
var
 pdfdriver:TRpPDFDriver;
 qtdriver:TRpQtDriver;
 oldtwopass:Boolean;
 onprog:TRpProgressEvent;
begin
 oldtwopass:=report.TwoPass;
 onprog:=report.OnPRogress;
 try
  if metafile then
   report.TwoPass:=true;
  qtdriver:=TRpQtDriver.create;
  pdfdriver:=TRpPDFDriver.Create;
  try
  if not metafile then
   pdfdriver.DestStream:=stream;
  pdfdriver.compressed:=compressed;
  if progress then
   report.OnProgress:=pdfdriver.RepProgress;
{$IFDEF USECLXTEECHART}
  report.Metafile.OnDrawChart:=qtdriver.DoDrawChart;
{$ENDIF}
  if metafile then
  begin
//   qtdriver.calconly:=true;
//   aqtdriver:=qtDriver;
//   report.PrintRange(aqtdriver,allpages,frompage,topage,copies,collate)
   report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
  end
  else
   report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
  if metafile then
   report.Metafile.SaveToStream(stream);
  finally
   qtdriver.Free;
   pdfdriver.free;
  end;
 finally
  report.TwoPass:=oldtwopass;
  report.OnPRogress:=onprog;
 end;
 Result:=True;
end;


{$ENDIF}

procedure TFRpQtProgress.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 qtdriver:=nil;
end;

procedure TRpQtDriver.GraphicExtent(Stream:TMemoryStream;var extent:TPoint;dpi:integer);
var
 graphic:TBitmap;
{$IFDEF VCLANDCLX}
 bitmapwidth,bitmapheight:integer;
{$ENDIF}
begin
 if dpi<=0 then
  exit;
 graphic:=TBitmap.Create;
 try
// CLX Graphics in Windows does not support jpeg
{$IFDEF VCLANDCLX}
  if GetJPegInfo(Stream,bitmapwidth,bitmapheight) then
  begin
   rpvgraphutils.JPegStreamToBitmapStream(Stream);
  end;
{$ENDIF}
  Graphic.LoadFromStream(Stream);
  extent.X:=Round(graphic.width/dpi*TWIPS_PER_INCHESS);
  extent.Y:=Round(graphic.height/dpi*TWIPS_PER_INCHESS);
 finally
  graphic.Free;
 end;
end;


function GetQtPrinterName:string;
var
 abuffer:widestring;
begin
  SetLength(abuffer,500);
  QPrinter_printerName(QPrinterH(Printer.Handle),@abuffer);
  Result:=abuffer;
end;

function PrinterSelection(printerindex:TRpPrinterSelect):TPoint;
var
 printername:String;
 index:integer;
 qtprintername:WideString;
 offset:TPoint;
begin
 printername:=GetPrinterConfigName(printerindex);
 offset:=GetPrinterOffset(printerindex);
 if length(printername)>0 then
 begin
  index:=Printer.Printers.IndexOf(printername);
  if index>=0 then
  begin
   Printer.SetPrinter(printername);
  end;
 end;
 // Gets the printer name if no printer selected select the first one
 if Printer.Printers.Count>0 then
 begin
  qtprintername:=GetQtPrinterName;
  if Length(qtprintername)<1 then
  begin
   Printer.SetPrinter(Printer.Printers.Strings[0]);
  end;
 end;
 Result:=offset;
end;

procedure TRpQtDriver.SelectPrinter(printerindex:TRpPrinterSelect);
begin
 offset:=PrinterSelection(printerindex);
end;

procedure PageSizeSelection(rpPageSize:TPageSizeQt);
begin
 if Printer.Printers.Count<1 then
  exit;
 if rpPageSize.Custom then
  exit;
 Printer.PrintAdapter.PageSize:=TPageSize(rpPagesize.Indexqt);
end;

{$IFDEF VCLANDCLX}
procedure TRpQtDriver.SendAfterPrintOperations;
var
 Operation:String;
 i:TPrinterRawOp;
begin
 for i:=Low(TPrinterRawOp) to High(TPrinterRawOp) do
 begin
  if PrinterRawOpEnabled(printerindex,i) then
  begin
   Operation:=GetPrinterRawOp(printerindex,i);
   if Length(Operation)>0 then
    SendControlCodeToPrinter(Operation);
  end;
 end;
end;
{$ENDIF}


procedure OrientationSelection(neworientation:TRpOrientation);
begin
 if Printer.Printers.Count<1 then
  exit;
 if neworientation=rpOrientationDefault then
  exit;
 if neworientation=rpOrientationPortrait then
  Printer.Orientation:=poPortrait
 else
  Printer.Orientation:=poLandscape;
end;


{$IFNDEF FORWEBAX}
 {$IFDEF USECLXTEECHART}
procedure TRpQtDriver.DoDrawChart(adriver:TRpPrintDriver;Series:TRpSeries;page:TRpMetaFilePage;
  aposx,aposy:integer;xchart:TObject);
var
 nchart:TRpChart;
 achart:TChart;
 aserie:TChartSeries;
 i,j,afontsize:integer;
 rec:TRect;
 intserie:TRpSeriesItem;
{$IFDEF MSWINDOWS}
 abitmap:Graphics.TBitmap;
{$ENDIF}
{$IFDEF LINUX}
 abitmap:TBitmap;
{$ENDIF}
 FMStream:TMemoryStream;
 acolor:integer;
begin
 nchart:=TRpChart(xchart);
 if nchart.Driver=rpchartdriverengine then
 begin
  rppdfdriver.DoDrawChart(adriver,Series,page,aposx,aposy,xchart);
  exit;
 end;
 achart:=TChart.Create(nil);
 try
{$IFDEF MSWINDOWS}
  achart.BevelOuter:=Controls.bvNone;
{$ENDIF}
{$IFDEF LINUX}
  achart.BevelOuter:=bvNone;
{$ENDIF}
  afontsize:=Round(nchart.FontSize*nchart.Resolution/100);
  achart.View3D:=nchart.View3d;
  achart.View3DOptions.Rotation:=nchart.Rotation;
  achart.View3DOptions.Perspective:=nchart.Perspective;
  achart.View3DOptions.Elevation:=nchart.Elevation;
  achart.View3DOptions.Orthogonal:=nchart.Orthogonal;
  achart.View3DOptions.Zoom:=nchart.Zoom;
  achart.View3DOptions.Tilt:=nchart.Tilt;
  achart.View3DOptions.HorizOffset:=nchart.HorzOffset;
  achart.View3DOptions.VertOffset:=nchart.VertOffset;
  achart.View3DWalls:=nchart.View3DWalls;
  achart.BackColor:=clTeeColor;
{$IFDEF MSWINDOWS}
  achart.BackWall.Brush.Style:=Graphics.bsClear;
{$ENDIF}
{$IFDEF LINUX}
  achart.BackWall.Brush.Style:=bsClear;
{$ENDIF}
  achart.Gradient.Visible:=false;
  achart.Color:=clWhite;
{$IFDEF MSWINDOWS}
  achart.LeftAxis.LabelsFont.Name:=nchart.WFontName;
  achart.BottomAxis.LabelsFont.Name:=nchart.WFontName;
  achart.Legend.Font.Name:=nchart.WFontName;
{$ENDIF}
{$IFDEF LINUX}
  achart.LeftAxis.LabelsFont.Name:=nchart.LFontName;
  achart.BottomAxis.LabelsFont.Name:=nchart.LFontName;
  achart.Legend.Font.Name:=nchart.LFontName;
{$ENDIF}
{$IFDEF MSWINDOWS}
  achart.LeftAxis.LabelsFont.Style:=CLXIntegerToFontStyle(nchart.FontStyle);
  achart.Legend.Font.Style:=CLXIntegerToFontStyle(nchart.FontStyle);
  achart.BottomAxis.LabelsFont.Style:=CLXIntegerToFontStyle(nchart.FontStyle);
{$ENDIF}
{$IFDEF LINUX}
  achart.LeftAxis.LabelsFont.Style:=IntegerToFontStyle(nchart.FontStyle);
  achart.Legend.Font.Style:=IntegerToFontStyle(nchart.FontStyle);
  achart.BottomAxis.LabelsFont.Style:=IntegerToFontStyle(nchart.FontStyle);
{$ENDIF}
  achart.Legend.Visible:=nchart.ShowLegend;
  acolor:=0;
  // autorange and other ranges
  achart.LeftAxis.Maximum:=Series.HighValue;
  achart.LeftAxis.Minimum:=Series.LowValue;
  achart.LeftAxis.Automatic:=false;
  achart.LeftAxis.AutomaticMaximum:=Series.AutoRangeH;
  achart.LeftAxis.AutomaticMinimum:=Series.AutoRangeL;
  achart.LeftAxis.Logarithmic:=Series.Logaritmic;
  achart.LeftAxis.LogarithmicBase:=Round(Series.LogBase);
  achart.LeftAxis.Inverted:=Series.Inverted;
  achart.LeftAxis.LabelsAngle:=nchart.VertFontRotation mod 360;
  achart.LeftAxis.LabelsFont.Size:=Round(nchart.VertFontSize*nchart.Resolution/100);
  achart.BottomAxis.LabelsAngle:=nchart.HorzFontRotation mod 360;
  achart.BottomAxis.LabelsFont.Size:=Round(nchart.HorzFontSize*nchart.Resolution/100);
  for i:=0 to Series.Count-1 do
  begin
   aserie:=nil;
   case nchart.ChartType of
    rpchartline:
     begin
      aserie:=TLineSeries.Create(nil);
     end;
    rpchartbar:
     begin
      aserie:=TBarSeries.Create(nil);
      case nchart.MultiBar of
       rpMultiNone:
        TBarSeries(aserie).MultiBar:=mbNone;
       rpMultiside:
        TBarSeries(aserie).MultiBar:=mbSide;
       rpMultiStacked:
        TBarSeries(aserie).MultiBar:=mbStacked;
       rpMultiStacked100:
        TBarSeries(aserie).MultiBar:=mbStacked100;
      end;
     end;
    rpchartpoint:
     aserie:=TPointSeries.Create(nil);
    rpcharthorzbar:
     aserie:=THorizBarSeries.Create(nil);
    rpchartarea:
     aserie:=TAreaSeries.Create(nil);
    rpchartpie:
     begin
      aserie:=TPieSeries.Create(nil);
     end;
    rpchartarrow:
     aserie:=TArrowSeries.Create(nil);
    rpchartbubble:
     aserie:=TBubbleSeries.Create(nil);
    rpchartgantt:
     aserie:=TGanttSeries.Create(nil);
   end;
   if not assigned(aserie) then
    exit;
   intserie:=Series.Items[i];
   aserie.Marks.Visible:=nchart.ShowHint;
   if Length(intserie.Caption)>0 then
    aserie.Title:=intserie.Caption;
{$IFDEF MSWINDOWS}
   aserie.Marks.Font.Name:=nchart.WFontName;
   aserie.Marks.Font.Style:=CLXIntegerToFontStyle(nchart.FontStyle);
{$ENDIF}
{$IFDEF LINUX}
   aserie.Marks.Font.Name:=nchart.lFontName;
   aserie.Marks.Font.Style:=IntegerToFontStyle(nchart.FontStyle);
{$ENDIF}
   aserie.Marks.Font.Size:=aFontSize;
   aserie.ParentChart:=achart;
   aserie.Marks.Style:=TSeriesMarksStyle(nchart.MarkStyle);
   // Assigns the color for this serie
   if intserie.Color>=0 then
    aserie.SeriesColor:=intserie.Color
   else
    aserie.SeriesColor:=SeriesColors[aColor];
   // Assigns the color for this serie
   for j:=0 to intserie.ValueCount-1 do
   begin
    if series.count<2 then
    begin
     if intserie.Colors[j]>=0 then
      aserie.Add(intserie.Values[j],
       intSerie.ValueCaptions[j],intSerie.Colors[j])
     else
      aserie.Add(intserie.Values[j],
       intSerie.ValueCaptions[j],SeriesColors[aColor]);
     if (nchart.ChartType in [rpchartpie]) or nchart.ShowLegend then
      acolor:=((acolor+1) mod (MAX_SERIECOLORS));
    end
    else
    begin
     if intserie.Colors[j]>=0 then
      aserie.Add(intserie.Values[j],
       intSerie.ValueCaptions[j],intserie.Colors[j])
     else
      aserie.Add(intserie.Values[j],
       intSerie.ValueCaptions[j],SeriesColors[aColor]);
    end;
   end;
   acolor:=((acolor+1) mod (MAX_SERIECOLORS));
{$IFDEF MSWINDOWS}
   abitmap:=Graphics.TBitmap.Create;
   try
    abitmap.HandleType:=bmDIB;
    abitmap.PixelFormat:=pf24bit;
{$ENDIF}
{$IFDEF LINUX}
   abitmap:=TBitmap.Create;
   try
    abitmap.PixelFormat:=pf32bit;
{$ENDIF}
    // Chart resolution to default screen
    abitmap.Width:=Round(twipstoinchess(nchart.PrintWidth)*nchart.Resolution);
    abitmap.Height:=Round(twipstoinchess(nchart.PrintHeight)*nchart.Resolution);
    rec.Top:=0;
    rec.Left:=0;
    rec.Bottom:=abitmap.Height-1;
    rec.Right:=abitmap.Width-1;
    achart.Draw(abitmap.Canvas,rec);
    // Finally print it
    FMStream:=TMemoryStream.Create;
    try
     abitmap.SaveToStream(FMStream);
     page.NewImageObject(aposy,aposx,
      nchart.PrintWidth,nchart.PrintHeight,DEF_COPYMODE,Integer(rpDrawStretch),
      nchart.Resolution,FMStream,false);
    finally
     FMStream.Free;
    end;
   finally
    abitmap.free;
   end;
   acolor:=((acolor+1) mod MAX_SERIECOLORS);
  end;
 finally
  while achart.SeriesList.Count>0 do
  begin
   TObject(achart.SeriesList.Items[0]).free;
  end;
  achart.Free;
 end;
end;
{$ENDIF}
{$ENDIF}

procedure TRpQtDriver.DrawChart(Series:TRpSeries;ametafile:TRpMetaFileReport;posx,posy:integer;achart:TObject);
begin
{$IFNDEF FORWEBAX}
 {$IFDEF USECLXTEECHART}
   DoDrawChart(Self,Series,ametafile.Pages[ametafile.CurrentPage],posx,posy,achart);
 {$ENDIF}
{$ENDIF}
end;


function AskBitmapProps(var HorzRes,VertRes:Integer;var Mono:Boolean):Boolean;
var
 diarange:TFRpQtProgress;
begin
 Result:=false;
 diarange:=TFRpQtProgress.Create(Application);
 try
  diarange.Caption:=SRpBitmapProps;
  diarange.BOK.Visible:=true;
  diarange.GBitmap.Visible:=true;
  diarange.EHorzRes.Text:=IntToStr(HorzRes);
  diarange.EVertRes.Text:=IntToStr(HorzRes);
  diarange.CheckMono.Checked:=Mono;
  diarange.ActiveControl:=diarange.BOK;
  diarange.showmodal;
  if diarange.dook then
  begin
   try
    HorzRes:=StrToInt(diarange.EHorzRes.Text);
    VertRes:=StrToInt(diarange.EVertRes.Text);
   except
   end;
   if HorzRes<1 then
    HorzREs:=1;
   if VertRes<1 then
    VertRes:=1;
   Mono:=diarange.CheckMono.Checked;
   Result:=true;
  end
 finally
  diarange.free;
 end;
end;

procedure TFRpQtProgress.BOKClick(Sender: TObject);
begin
 dook:=true;
 Close;
end;

function TRpQtDriver.GetFontDriver:TRpPrintDriver;
begin
 if Assigned(FontDriver) then
  Result:=FontDriver
 else
  Result:=Self;
end;


end.

