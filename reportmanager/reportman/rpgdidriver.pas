{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpgdidriver                                     }
{       TRpGDIDriver: Printer driver for  VCL Lib       }
{       can be used only for windows                    }
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

unit rpgdidriver;

interface

{$I rpconf.inc}


uses
 mmsystem,windows,
 Classes,sysutils,rpmetafile,rpmdconsts,Graphics,Forms,
 rpmunits,Printers,Dialogs, Controls,rpgdifonts,Math,
 StdCtrls,ExtCtrls,rppdffile,rpgraphutilsvcl,WinSpool,rpmdcharttypes,
{$IFNDEF FORWEBAX}
 rpmdchart,
{$ENDIF}
{$IFDEF USEVARIANTS}
 types,Variants,
{$ENDIF}
{$IFDEF DOTNETD}
 System.ComponentModel,
{$ENDIF}
 rptypes,rpvgraphutils,
{$IFNDEF FORWEBAX}
 rpbasereport,rpreport,
{$IFDEF USETEECHART}
 {$IFDEF VCLNOTATION}
  VCLTee.Chart,VCLTee.Series,rpdrawitem,
  VCLTee.teEngine,VCLTee.ArrowCha,VCLTee.BubbleCh,VCLTee.GanttCh,
  VCL.Imaging.jpeg,
 {$ENDIF}
 {$IFNDEF VCLNOTATION}
  Chart,Series,rpdrawitem,
  teEngine,ArrowCha,BubbleCh,GanttCh,
  jpeg,
 {$ENDIF}
{$ENDIF}
{$IFDEF EXTENDEDGRAPHICS}
 rpgraphicex,
{$ENDIF}
{$ENDIF}
 rppdfdriver,rptextdriver, Mask, rpmaskedit;


const
 METAPRINTPROGRESS_INTERVAL=20;
type
  TRpGDIDriver=class;
  TFRpVCLProgress = class(TForm)
    BCancel: TButton;
    LProcessing: TLabel;
    LRecordCount: TLabel;
    LTitle: TLabel;
    LTittle: TLabel;
    BOK: TButton;
    GPrintRange: TGroupBox;
    EFrom: TRpMaskEdit;
    ETo: TRpMaskEdit;
    LTo: TLabel;
    LFrom: TLabel;
    RadioAll: TRadioButton;
    RadioRange: TRadioButton;
    GBitmap: TGroupBox;
    LHorzRes: TLabel;
    LVertRes: TLabel;
    EHorzRes: TRpMaskEdit;
    EVertRes: TRpMaskEdit;
    CheckMono: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    allpages,collate:boolean;
    frompage,topage,copies:integer;
    devicefonts:boolean;
    printerindex:TRpPrinterSelect;
    dook:boolean;
    MetaBitmap:TBitmap;
    bitresx,bitresy:Integer;
    bitmono:Boolean;
    procedure AppIdle(Sender:TObject;var done:boolean);
    procedure AppIdleBitmap(Sender:TObject;var done:boolean);
{$IFNDEF FORWEBAX}
    procedure AppIdleReport(Sender:TObject;var done:boolean);
    procedure RepProgress(Sender:TRpBaseReport;var docancel:boolean);
    procedure AppIdlePrintPDF(Sender:TObject;var done:boolean);
    procedure AppIdlePrintRange(Sender:TObject;var done:boolean);
    procedure AppIdlePrintRangeText(Sender:TObject;var done:boolean);
{$ENDIF}
  public
    { Public declarations }
    noenddoc:boolean;
    pdfcompressed:boolean;
    cancelled:boolean;
    oldonidle:TIdleEvent;
    tittle:string;
    filename:string;
    errorproces:boolean;
    ErrorMessage:String;
    usepdfdriver:boolean;
    metafile:TRpMetafileReport;
{$IFNDEF FORWEBAX}
    report:TRpReport;
{$ENDIF}
    nobegindoc:boolean;
  end;


 TRpGDIDriver=class(TRpPrintDriver)
  private
    FReport:TRpMetafileReport;
    BackColor:integer;
   intdpix,intdpiy:integer;
   metacanvas:TMetafilecanvas;
   meta:TMetafile;
   pagecliprec:TRect;
   onlycalc:Boolean;
   selectedprinter:TRpPrinterSelect;
   DrawerBefore,DrawerAfter:Boolean;
   npdfdriver:TRpPDFDriver;
   procedure PrintObject(Canvas:TCanvas;page:TRpMetafilePage;obj:TRpMetaObject;dpix,dpiy:integer;toprinter:boolean;pagemargins:TRect;devicefonts:boolean;offset:TPoint;selected:boolean);
   procedure SendAfterPrintOperations;
   function DoNewPage(aorientation:TRpOrientation;apagesizeqt:TPageSizeQt):Boolean;
   procedure UpdateBitmapSize(report:TrpMetafileReport;apage:TrpMetafilePage);
  public
   offset:TPoint;
   showpagemargins:boolean;
//   CurrentPageSize:Tpoint;
   bitmap:TBitmap;
   dpi:integer;
   toprinter:boolean;
   scale:double;
   pagemargins:TRect;
   drawclippingregion:boolean;
   oldpagesize,pagesize:TGDIPageSize;
   oldorientation:TPrinterOrientation;
   orientationset:boolean;
   devicefonts:boolean;
   neverdevicefonts:boolean;
   bitmapwidth,bitmapheight:integer;
   PreviewStyle:TRpPreviewStyle;
   clientwidth,clientheight:integer;
   FontDriver:TRpPrintDriver;
   noenddoc:boolean;
   procedure NewDocument(report:TrpMetafileReport;hardwarecopies:integer;
    hardwarecollate:boolean);override;
   procedure EndDocument;override;
   procedure AbortDocument;override;
   procedure NewPage(metafilepage:TRpMetafilePage);override;
   procedure EndPage;override;
   procedure DrawObject(page:TRpMetaFilePage;obj:TRpMetaObject);override;
   procedure IntDrawObject(page:TRpMetaFilePage;obj:TRpMetaObject;selected:boolean);
   procedure DrawChart(Series:TRpSeries;ametafile:TRpMetaFileReport;posx,posy:integer;achart:TObject);override;
{$IFNDEF FORWEBAX}
{$IFDEF EXTENDEDGRAPHICS}
   procedure FilterImage(memstream:TMemoryStream);override;
{$ENDIF}
{$ENDIF}
{$IFNDEF FORWEBAX}
{$IFDEF USETEECHART}
   procedure DoDrawChart(adriver:TRpPrintDriver;Series:TRpSeries;page:TRpMetaFilePage;
     aposx,aposy:integer;xchart:TObject);
{$ENDIF}
{$ENDIF}
   procedure DrawPage(apage:TRpMetaFilePage);override;
   function AllowCopies:boolean;override;
   function GetPageSize(var PageSizeQt:Integer):TPoint;override;
   function SetPagesize(PagesizeQt:TPageSizeQt):TPoint;override;
   procedure TextExtent(atext:TRpTextObject;var extent:TPoint);override;
   procedure TextRectJustify(Canvas:TCanvas;ARect: TRect; Text: Widestring;
                       Alignment: integer; Clipping: boolean;Wordbreak:boolean;
                       Rotation:integer;RightToLeft:Boolean;drawbackground:Boolean;backcolor:TColor);
   procedure GraphicExtent(Stream:TMemoryStream;var extent:TPoint;dpi:integer);override;
   procedure SetOrientation(Orientation:TRpOrientation);  override;
   procedure SelectPrinter(printerindex:TRpPrinterSelect);override;
   function SupportsCopies(maxcopies:integer):boolean;override;
   function SupportsCollation:boolean;override;
   constructor Create;
   destructor Destroy;override;
   function GetFontDriver:TRpPrintDriver;override;
  end;

function PrintMetafile(metafile:TRpMetafileReport; tittle:string;
 showprogress,allpages:boolean; frompage,topage,copies:integer;
  collate:boolean; devicefonts:boolean; printerindex:TRpPrinterSelect=pRpDefaultPrinter;nobegindoc:boolean=false):boolean;
function MetafileToBitmap(metafile:TRpMetafileReport;ShowProgress:Boolean;
 Mono:Boolean;resx:integer=200;resy:integer=100):TBitmap;
function AskBitmapProps(var HorzRes,VertRes:Integer;var Mono:Boolean):Boolean;

{$IFNDEF FORWEBAX}
function CalcReportWidthProgress (report:TRpReport;noenddoc:boolean=false):boolean;
function CalcReportWidthProgressPDF(report:TRpReport;noenddoc:boolean=false):boolean;
function PrintReport (report:TRpReport; Caption:string; progress:boolean;
  allpages:boolean; frompage,topage,copies:integer; collate:boolean):Boolean;
function ExportReportToPDF (report:TRpReport; Caption:string; progress:boolean;
  allpages:boolean; frompage,topage,copies:integer;
  showprintdialog:boolean; filename:string; compressed:boolean;collate:boolean):Boolean;
function ExportReportToPDFMetaStream (report:TRpReport; Caption:string; progress:boolean;
  allpages:boolean; frompage,topage,copies:integer;
  showprintdialog:boolean; stream:TStream; compressed:boolean;collate:boolean;metafile:Boolean):Boolean;
{$ENDIF}
function DoShowPrintDialog (var allpages:boolean;
 var frompage,topage,copies:integer; var collate:boolean;disablecopies:boolean=false) :boolean;
function PrinterSelection(printerindex:TRpPrinterSelect;papersource,duplex:integer;var pconfig:TPrinterConfig) :TPoint;
procedure PageSizeSelection (rpPageSize:TPageSizeQt);
procedure OrientationSelection (neworientation:TRpOrientation);

{$IFNDEF FORWEBAX}
{$IFDEF EXTENDEDGRAPHICS}
   procedure ExFilterImage(memstream:TMemoryStream);
{$ENDIF}
{$ENDIF}


implementation



{$R *.dfm}

const
 AlignmentFlags_SingleLine=64;
 AlignmentFlags_AlignHCenter = 4 { $4 };
 AlignmentFlags_AlignHJustify = 1024 { $400 };
 AlignmentFlags_AlignTop = 8 { $8 };
 AlignmentFlags_AlignBottom = 16 { $10 };
 AlignmentFlags_AlignVCenter = 32 { $20 };
 AlignmentFlags_AlignLeft = 1 { $1 };
 AlignmentFlags_AlignRight = 2 { $2 };

function EqualsPageSizeQt(a,b:TPageSizeQt):Boolean;
begin
 Result:=true;
 if (a.Indexqt<>b.Indexqt) then
 begin
  Result:=false;
  exit;
 end;
 if (a.Custom<>b.Custom) then
 begin
  Result:=false;
  exit;
 end;
 if (a.CustomWidth<>b.CustomWidth) then
 begin
  Result:=false;
  exit;
 end;
 if (a.CustomHeight<>b.CustomHeight) then
 begin
  Result:=false;
  exit;
 end;
 if (a.PaperSource<>b.PaperSource) then
 begin
  Result:=false;
  exit;
 end;
{$IFNDEF DOTNETD}
 if (a.ForcePaperName<>b.ForcePaperName) then
{$ENDIF}
{$IFDEF DOTNETD}
 if (String(a.ForcePaperName)<>String(b.ForcePaperName)) then
{$ENDIF}
 begin
  Result:=false;
  exit;
 end;
 if (a.Duplex<>b.Duplex) then
 begin
  Result:=false;
  exit;
 end;
end;

function TRpGDIDriver.DoNewPage(aorientation:TRpOrientation;apagesizeqt:TPageSizeQt):Boolean;
begin
 Result:=true;
 Windows.EndPage(Printer.handle);
 SetOrientation(aorientation);
 SetPageSize(apagesizeqt);
 Windows.StartPage(printer.handle);
 Printer.Canvas.Refresh;
end;


function DoShowPrintDialog(var allpages:boolean;
 var frompage,topage,copies:integer;var collate:boolean;disablecopies:boolean=false):boolean;
var
 dia:TPrintDialog;
 diarange:TFRpVCLProgress;
begin
 Result:=False;
 if disablecopies then
 begin
  diarange:=TFRpVCLProgress.Create(Application);
  try
   diarange.BOK.Visible:=true;
   diarange.GPrintRange.Visible:=true;
   diarange.RadioAll.Checked:=allpages;
   diarange.RadioRange.Checked:=not allpages;
   diarange.ActiveControl:=diarange.BOK;
   diarange.Frompage:=frompage;
   diarange.ToPage:=topage;
   diarange.showmodal;
   if diarange.dook then
   begin
    frompage:=diarange.frompage;
    topage:=diarange.topage;
    allpages:=diarange.Radioall.Checked;
    Result:=true;
   end
  finally
   diarange.free;
  end;
  exit;
 end;
 if (copies>0) then
  SetPrinterCollation(collate);
 dia:=TPrintDialog.Create(Application);
 try
  dia.Options:=[poPageNums,poWarning,
        poPrintToFile];
  dia.MinPage:=1;
  dia.MaxPage:=65535;
  if copies=0 then
  begin
   dia.copies:=GetPrinterCopies;
   dia.collate:=GetPrinterCollation;
  end
  else
  begin
   dia.copies:=copies;
   dia.collate:=collate;
  end;
  dia.frompage:=frompage;
  dia.topage:=topage;
  if dia.execute then
  begin
   allpages:=false;
   collate:=GetPrinterCollation;
   copies:=GetPrinterCopies;
   frompage:=dia.frompage;
   topage:=dia.topage;
   Result:=True;
  end;
 finally
  dia.free;
 end;
end;


constructor TRpGDIDriver.Create;
begin
 inherited Create;
 // By default 1:1 scale
 offset.X:=0;
 offset.Y:=0;
 dpi:=Screen.PixelsPerInch;
 drawclippingregion:=false;
 oldpagesize.PageIndex:=-1;
 scale:=1;
end;

destructor TRpGDIDriver.Destroy;
begin
 if assigned(metacanvas) then
 begin
  metacanvas.free;
  metacanvas:=nil;
 end;
 if assigned(meta) then
 begin
  meta.free;
  meta:=nil;
 end;
 if assigned(bitmap) then
 begin
  bitmap.free;
  bitmap:=nil;
 end;
 if assigned(npdfdriver) then
  npdfdriver.free;
 inherited Destroy;
end;

function TRpGDIDriver.SupportsCopies(maxcopies:integer):boolean;
begin
 Result:=PrinterSupportsCopies(maxcopies);
end;

function TRpGDIDriver.SupportsCollation:boolean;
begin
 Result:=PrinterSupportsCollation;
end;

procedure TRpGDIDriver.UpdateBitmapSize(report:TrpMetafileReport;apage:TrpMetafilePage);
var
 asize:TPoint;
 qtsize:integer;
 awidth,aheight:integer;
 rec:TRect;
 scale2:double;
// aregion:HRGN;
 frompage:boolean;
begin
 // Offset is 0 in preview
 offset.X:=0;
 offset.Y:=0;
 // Sets Orientation
 BackColor:=report.BackColor;
 frompage:=false;
 if assigned(apage) then
  if apage.UpdatedPageSize then
   frompage:=true;
 if not frompage then
 begin
  if drawclippingregion then
  begin
   SetOrientation(report.Orientation);
   // Gets pagesize
   asize:=GetPageSize(qtsize);
   pagemargins:=GetPageMarginsTWIPS;
//   CurrentPageSize:=asize;
  end
  else
  begin
   asize.X:=report.CustomX;
   asize.Y:=report.CustomY;
  end;
 end
 else
 begin
  if drawclippingregion then
  begin
   SetOrientation(apage.Orientation);
   pagemargins:=GetPageMarginsTWIPS;
  end;
  asize.X:=apage.PageSizeqt.PhysicWidth;
  asize.Y:=apage.PageSizeqt.PhysicHeight;
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
      scale:=(clientwidth-GetSystemMetrics(SM_CYHSCROLL))/bitmapwidth;
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
  if Not assigned(bitmap) then
  begin
   bitmap:=TBitmap.Create;
{$IFNDEF DOTNETDBUGS}
   bitmap.PixelFormat:=pf32bit;
   bitmap.HandleType:=bmDIB;
{$ENDIF}
  end;
(*  end
  else
  begin
   if ((bitmap.Width<>bitmapwidth) or (bitmap.height<>bitmapheight)) then
   begin
    bitmap.free;
    bitmap:=nil;
    bitmap:=TBitmap.Create;
 {$IFNDEF DOTNETDBUGS}
    bitmap.PixelFormat:=pf32bit;
    bitmap.HandleType:=bmDIB;
 {$ENDIF}
   end;
  end;
*)
  bitmap.Width:=Round(awidth*scale);
  bitmap.Height:=Round(aheight*scale);
  if bitmap.Width<1 then
   bitmap.Width:=1;
  if bitmap.Height<1 then
   bitmap.Height:=1;

  Bitmap.Canvas.Brush.Style:=bsSolid;
  Bitmap.Canvas.Brush.Color:=CLXColorToVCLColor(BackColor);
  rec.Top:=0;
  rec.Left:=0;
  rec.Right:=Bitmap.Width+1;
  rec.Bottom:=Bitmap.Height+1;
  bitmap.Canvas.FillRect(rec);
  // Define clipping region
  if drawclippingregion then
  begin
   rec.Left:=Round((pagemargins.Left/TWIPS_PER_INCHESS)*dpi*scale);
   rec.Top:=Round((pagemargins.Top/TWIPS_PER_INCHESS)*dpi*scale);
   rec.Right:=Round((pagemargins.Right/TWIPS_PER_INCHESS)*dpi*scale);
   rec.Bottom:=Round((pagemargins.Bottom/TWIPS_PER_INCHESS)*dpi*scale);
   pagecliprec:=rec;
  end;
{  if (Not drawclippingregion) then
  begin
   aregion:=CreateRectRgn(rec.Left,rec.Top,rec.Right,rec.Bottom);
   SelectClipRgn(bitmap.Canvas.handle,aregion);
  end;
}
end;

procedure TRpGDIDriver.NewDocument(report:TrpMetafileReport;hardwarecopies:integer;
   hardwarecollate:boolean);
var
 asize:TPoint;
 qtsize:integer;
 rpagesizeQt:TPageSizeQt;
begin
 FReport:=report;
{$IFNDEF FORWEBAX}
{$IFDEF USETEECHART}
 report.OnDrawChart:=Self.DoDrawChart;
{$ENDIF}
{$IFDEF EXTENDEDGRAPHICS}
 report.OnFilterImage:=Self.FilterImage;
 {$ENDIF}
{$ENDIF}
 DrawerBefore:=report.OpenDrawerBefore;
 DrawerAfter:=report.OpenDrawerAfter;
 if devicefonts then
 begin
  UpdatePrinterFontList;
 end;
 if ToPrinter then
 begin
  SetOrientation(report.Orientation);
  // Gets pagesize
  asize:=GetPageSize(qtsize);
  pagemargins:=GetPageMarginsTWIPS;
  if not noenddoc then
  begin
   SetPrinterCopies(hardwarecopies);
   SetPrinterCollation(hardwarecollate);
  end;

  if not noenddoc then
   if DrawerBefore then
    SendControlCodeToPrinter(GetPrinterRawOp(selectedprinter,rawopopendrawer));
  // Sets pagesize
  rpagesizeQt.papersource:=report.PaperSource;
  SetForcePaperName(rpagesizeqt,report.ForcePaperName);
  rpagesizeQt.duplex:=report.duplex;
  if report.PageSize<0 then
  begin
   rpagesizeqt.Custom:=True;
   rPageSizeQt.CustomWidth:=report.CustomX;
   rPageSizeQt.CustomHeight:=report.CustomY;
  end
  else
  begin
   rpagesizeqt.Indexqt:=report.PageSize;
   rpagesizeqt.Custom:=False;
  end;
  try
   SetPagesize(rpagesizeqt);
  except
   On E:Exception do
   begin
    rpgraphutilsvcl.RpMessageBox(E.Message);
   end;
  end;
  printer.Title:=report.Title;
  if Length(printer.Title)<1 then
  begin
   printer.Title:=SRpUntitled;
   if Length(printer.Title)<1 then
   begin
    printer.Title:='Untitled';
   end;
  end;
  printer.BeginDoc;
  intdpix:=GetDeviceCaps(Printer.Canvas.handle,LOGPIXELSX); //  printer.XDPI;
  intdpiy:=GetDeviceCaps(Printer.Canvas.handle,LOGPIXELSY);  // printer.YDPI;
 end
 else
 begin
  UpdateBitmapSize(report,nil);
 end;
end;



procedure TRpGDIDriver.EndDocument;
begin
 if toprinter then
 begin
  if not noenddoc then
  begin
   printer.EndDoc;
   if DrawerAfter then
    SendControlCodeToPrinter(GetPrinterRawOp(selectedprinter,rawopopendrawer));
   // Send Especial operations
   SendAfterPrintOperations;
  end;
 end
 else
 begin
  // Does nothing because the last bitmap can be usefull
 end;
 if oldpagesize.PageIndex<>-1 then
 begin
  SetCurrentPaper(oldpagesize);
  oldpagesize.PageIndex:=-1;
 end;
 if orientationset then
 begin
  if printer.printing then
   SetPrinterOrientation(oldorientation=poLandscape)
  else
   printer.orientation:=oldorientation;
  orientationset:=false;
 end;
end;

procedure TRpGDIDriver.AbortDocument;
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
 if orientationset then
 begin
  SetPrinterOrientation(oldorientation=poLandscape);
  orientationset:=false;
 end;
 if oldpagesize.PageIndex<>-1 then
 begin
  SetCurrentPaper(oldpagesize);
  oldpagesize.PageIndex:=-1;
 end;
end;

procedure TRpGDIDriver.NewPage(metafilepage:TRpMetafilePage);
begin
 if toprinter then
 begin
  if metafilepage.UpdatedPageSize then
   DoNewPage(metafilepage.orientation,metafilepage.pagesizeqt)
  else
   Printer.NewPage;
 end
 else
 begin
  UpdateBitmapSize(FReport,metafilepage);
 end;
end;

procedure TRpGDIDriver.EndPage;
var
 rec:TREct;
begin
 // If drawclippingregion then
 if not toprinter then
 begin
  if Not Assigned(bitmap) then
   exit;
  rec:=pagecliprec;
  if drawclippingregion then
  begin
   bitmap.Canvas.Pen.Style:=psSolid;
   bitmap.Canvas.Pen.Color:=clBlack;
   bitmap.Canvas.Brush.Style:=bsclear;
   bitmap.Canvas.rectangle(rec.Left,rec.Top,rec.Right,rec.Bottom);
  end
 end;
end;


procedure TRpGDIDriver.TextExtent(atext:TRpTextObject;var extent:TPoint);
var
 Canvas:TCanvas;
 dpix,dpiy:integer;
 aalign:Cardinal;
 aatext:widestring;
 aansitext:string;
 arec:TRect;
 maxextent:TPoint;
begin
 if atext.FontRotation<>0 then
  exit;
 // Justified text use pdf driver
 if (atext.AlignMent AND AlignmentFlags_AlignHJustify)>0 then
// if true then
 begin
  if not assigned(npdfdriver) then
    npdfdriver:=TRpPDFDriver.Create;
  atext.Type1Font:=integer(poLinked);
  npdfdriver.TextExtent(atext,extent);
  exit;
 end;


 if atext.CutText then
 begin
  maxextent:=extent;
 end;
 if (toprinter) then
 begin
  if not printer.Printing then
   Raise Exception.Create(SRpGDIDriverNotInit);
  dpix:=intdpix;
  dpiy:=intdpiy;
  Canvas:=printer.canvas;
 end
 else
 begin
  if not Assigned(bitmap) then
   Raise Exception.Create(SRpGDIDriverNotInit);
  if not Assigned(metacanvas) then
  begin
   if assigned(meta) then
   begin
    meta.free;
    meta:=nil;
   end;
   meta:=TMetafile.Create;
   meta.Enhanced:=true;
   meta.Width:=bitmapwidth;
   meta.Height:=bitmapheight;
   metacanvas:=TMetafileCanvas.Create(meta,0);
  end;
  Canvas:=metacanvas;
  dpix:=Screen.PixelsPerInch;
  dpiy:=Screen.PixelsPerInch;
 end;
 Canvas.Font.Name:=atext.WFontName;
 Canvas.Font.Style:=CLXIntegerToFontStyle(atext.FontStyle);
 Canvas.Font.Size:=atext.FontSize;
 Canvas.Font.Color:=CLXColorToVCLColor(atext.FontColor);
 // Find device font
 if devicefonts then
  FindDeviceFont(Canvas.Handle,Canvas.Font,FontSizeToStep(Canvas.Font.Size,atext.PrintStep));
 aalign:=DT_NOPREFIX;
 if (atext.AlignMent AND AlignmentFlags_AlignHCenter)>0 then
  aalign:=aalign or DT_CENTER;
 if (atext.AlignMent AND AlignmentFlags_AlignVCenter)>0 then
  aalign:=aalign or DT_VCENTER;
 if (atext.AlignMent AND AlignmentFlags_AlignTop)>0 then
  aalign:=aalign or DT_TOP;
 if (atext.AlignMent AND AlignmentFlags_AlignBottom)>0 then
  aalign:=aalign or DT_BOTTOM;
 if (atext.AlignMent AND AlignmentFlags_SingleLine)>0 then
  aalign:=aalign or DT_SINGLELINE;
 if (atext.AlignMent AND AlignmentFlags_AlignLEFT)>0 then
  aalign:=aalign or DT_LEFT;
 if (atext.AlignMent AND AlignmentFlags_AlignRight)>0 then
  aalign:=aalign or DT_RIGHT;
 if atext.WordWrap then
  aalign:=aalign or DT_WORDBREAK;
 if Not atext.CutText then
  aalign:=aalign or DT_NOCLIP;
 if atext.RightToLeft then
  aalign:=aalign or DT_RTLREADING;
 aatext:=atext.text;
 aansitext:=aatext;
 arec.Left:=0;
 arec.Top:=0;
 arec.Bottom:=0;
 arec.Right:=Round(extent.X*dpix/TWIPS_PER_INCHESS);
 // calculates the text extent
 // Win9x does not support drawing WideChars
{$IFNDEF DOTNETD}
 if IsWindowsNT then
  DrawTextW(Canvas.Handle,PWideChar(aatext),Length(aatext),arec,aalign or DT_CALCRECT)
 else
  DrawTextA(Canvas.Handle,PChar(aansitext),Length(aansitext),arec,aalign or DT_CALCRECT);
{$ENDIF}
{$IFDEF DOTNETD}
 if IsWindowsNT then
  DrawTextW(Canvas.Handle,aatext,Length(aatext),arec,aalign or DT_CALCRECT)
 else
  DrawTextA(Canvas.Handle,aansitext,Length(aansitext),arec,aalign or DT_CALCRECT);
{$ENDIF}
 // Transformates to twips
 extent.X:=Round(arec.Right/dpix*TWIPS_PER_INCHESS);
 extent.Y:=Round(arec.Bottom/dpiy*TWIPS_PER_INCHESS);
 if (atext.CutText) then
 begin
  if maxextent.Y<extent.Y then
   extent.Y:=maxextent.Y;
 end;

end;

procedure TRpGDIDriver.PrintObject(Canvas:TCanvas;page:TRpMetafilePage;obj:TRpMetaObject;dpix,dpiy:integer;toprinter:boolean;
 pagemargins:TRect;devicefonts:boolean;offset:TPoint;selected:boolean);
var
 posx,posy:integer;
 rec,recsrc:TRect;
 X, Y, W, H, S: Integer;
 Width,Height:integer;
 stream:TMemoryStream;
 bitmap:TBitmap;
 aalign:Cardinal;
 abrushstyle:integer;
 atext:widestring;
 aansitext:string;
 arec:TRect;
 calcrect:boolean;
 alvbottom,alvcenter:boolean;
 rotrad,fsize:double;
 oldrgn:HRGN;
 newrgn:HRGN;
 aresult:integer;
{$IFNDEF DOTNETD}
 jpegimage:TJPegImage;
{$ENDIF}
 bitmapwidth,bitmapheight:integer;
 astring:WideString;
 drawbackground:boolean;
 oldhandle:THandle;
 format:string;
begin
 // Switch to device points
 oldhandle:=0;
 if toprinter then
 begin
  // If printer then must be displaced
  posx:=round((obj.Left-pagemargins.Left+offset.X)*dpix/TWIPS_PER_INCHESS);
  posy:=round((obj.Top-pagemargins.Top+offset.Y)*dpiy/TWIPS_PER_INCHESS);
 end
 else
 begin
  posx:=round(obj.Left*dpix/TWIPS_PER_INCHESS);
  posy:=round(obj.Top*dpiy/TWIPS_PER_INCHESS);
 end;
 case obj.Metatype of
  rpMetaText:
   begin
    Canvas.Font.Name:=page.GetWFontName(Obj);
    Canvas.Font.Color:=CLXColorToVCLColor(Obj.FontColor);
    Canvas.Font.Style:=CLXIntegerToFontStyle(obj.FontStyle);
    Canvas.Font.Size:=Obj.FontSize;
    try
    if obj.FontRotation<>0 then
    begin
     oldhandle:=Canvas.Font.Handle;
     // Find rotated font
     Canvas.Font.Handle:=FindRotatedFont(Canvas.Handle,Canvas.Font,obj.FontRotation);
     // Moves the print position
     rotrad:=obj.FontRotation/10*(2*PI/360);
     fsize:=Obj.FontSize/72*dpiy;
     posx:=posx-Round(fsize*sin(rotrad));
     posy:=posy+Round(fsize-fsize*cos(rotrad));
    end
    else
    begin
     // Find device font
     if devicefonts then
      FindDeviceFont(Canvas.Handle,Canvas.Font,FontSizeToStep(Canvas.Font.Size,obj.PrintStep));
    end;
    // Justified text use pdf driver
    if (obj.AlignMent AND AlignmentFlags_AlignHJustify)>0 then
//    if true then
    begin
     astring:=page.GetText(Obj);
     rec.Left:=Round(posx/dpix*TWIPS_PER_INCHESS);
     rec.Top:=Round(posy/dpix*TWIPS_PER_INCHESS);
     rec.Right:=Rec.Left+obj.Width;
     rec.Bottom:=rec.TOp+obj.Height;
     if ((obj.Transparent) and (not selected)) then
     begin
      SetBkMode(Canvas.Handle,TRANSPARENT);
      drawbackground:=false;
     end
     else
     begin
      SetBkMode(Canvas.Handle,OPAQUE);
      drawbackground:=true ;
     end;
     if selected then
     begin
      Canvas.Brush.Color:=clHighlight;
      Canvas.Font.Color:=clHighlightText;
     end;
     TextRectJustify(Canvas,rec,astring,obj.AlignMent,obj.CutText,obj.WordWrap,
      obj.FontRotation,obj.RightToLeft,drawbackground,CLXColorToVCLColor(obj.BackColor));
    end
    else
    begin
      aalign:=DT_NOPREFIX;
      if (obj.AlignMent AND AlignmentFlags_AlignHCenter)>0 then
       aalign:=aalign or DT_CENTER;
      // Vertical alignment is not implemented by Windows GDI
      // on multiple lines, so it's calculated manually
//      if (obj.AlignMent AND AlignmentFlags_AlignVCenter)>0 then
//        aalign:=aalign or DT_VCENTER;
//      if (obj.AlignMent AND AlignmentFlags_AlignTop)>0 then
//        aalign:=aalign or DT_TOP;
//      if (obj.AlignMent AND AlignmentFlags_AlignBottom)>0 then
//        aalign:=aalign or DT_BOTTOM;
      if (obj.AlignMent AND AlignmentFlags_SingleLine)>0 then
       aalign:=aalign or DT_SINGLELINE;
      if (obj.AlignMent AND AlignmentFlags_AlignLEFT)>0 then
       aalign:=aalign or DT_LEFT;
      if (obj.AlignMent AND AlignmentFlags_AlignRight)>0 then
       aalign:=aalign or DT_RIGHT;
      if obj.WordWrap then
       aalign:=aalign or DT_WORDBREAK;
      if Not obj.CutText then
       aalign:=aalign or DT_NOCLIP;
      if obj.RightToLeft then
       aalign:=aalign or DT_RTLREADING;
      rec.Left:=posx;
      rec.Top:=posy;
      rec.Right:=posx+Ceil(obj.Width*dpix/TWIPS_PER_INCHESS);
      rec.Bottom:=posy+Ceil(obj.Height*dpiy/TWIPS_PER_INCHESS);
  //    rec.Right:=posx+Round(obj.Width*dpix/TWIPS_PER_INCHESS);
  //    rec.Bottom:=posy+Round(obj.Height*dpiy/TWIPS_PER_INCHESS);
      atext:=page.GetText(Obj);
      aansitext:=atext;
      alvbottom:=(obj.AlignMent AND AlignmentFlags_AlignBottom)>0;
      alvcenter:=(obj.AlignMent AND AlignmentFlags_AlignVCenter)>0;

      calcrect:=(not obj.Transparent) or alvbottom or alvcenter;
      arec:=rec;
      if calcrect then
      begin
       // First calculates the text extent
       // Win9x does not support drawing WideChars
{$IFNDEF DOTNETD}
       if IsWindowsNT then
        DrawTextW(Canvas.Handle,PWideChar(atext),Length(atext),arec,aalign or DT_CALCRECT)
       else
        DrawTextA(Canvas.Handle,PChar(aansitext),Length(aansitext),arec,aalign or DT_CALCRECT);
{$ENDIF}
{$IFDEF DOTNETD}
       if IsWindowsNT then
        DrawTextW(Canvas.Handle,atext,Length(atext),arec,aalign or DT_CALCRECT)
       else
        DrawTextA(Canvas.Handle,aansitext,Length(aansitext),arec,aalign or DT_CALCRECT);
{$ENDIF}
       Canvas.Brush.Style:=bsSolid;
       Canvas.Brush.Color:=CLXColorToVCLColor(obj.BackColor);
      end
      else
       Canvas.Brush.Style:=bsClear;
      if alvbottom then
      begin
       rec.Top:=rec.Top+(rec.bottom-arec.bottom)
      end;
      if alvcenter then
      begin
       rec.Top:=rec.Top+((rec.bottom-arec.bottom) div 2);
      end;
      if (obj.Transparent and (not selected)) then
       SetBkMode(Canvas.Handle,TRANSPARENT)
      else
      begin
  //   This does not work on XP?
       SetBkMode(Canvas.Handle,OPAQUE);
  //     SetBkColor(Canvas.Handle,Canvas.Brush.Color);
  //     SelectObject(Canvas.Handle,Canvas.Font.Handle);
      end;
      if selected then
      begin
       Canvas.Brush.Color:=clHighlight;
       Canvas.Font.Color:=clHighlightText;
      end;
{$IFDEF DOTNETD}
      if IsWindowsNT then
       DrawTextW(Canvas.Handle,atext,Length(atext),rec,aalign)
      else
       DrawTextA(Canvas.Handle,aansitext,Length(aansitext),rec,aalign)
     end;
{$ENDIF}
{$IFNDEF DOTNETD}
      if IsWindowsNT then
       DrawTextW(Canvas.Handle,PWideChar(atext),Length(atext),rec,aalign)
      else
       DrawTextA(Canvas.Handle,PChar(aansitext),Length(aansitext),rec,aalign)
     end;
{$ENDIF}
    finally
      if (obj.FontRotation<>0) then
      begin
        Canvas.Font.Handle:=oldhandle;
      end;
    end;
   end;
  rpMetaDraw:
   begin
    Width:=round(obj.Width*dpix/TWIPS_PER_INCHESS);
    Height:=round(obj.Height*dpiy/TWIPS_PER_INCHESS);
    abrushstyle:=obj.BrushStyle;
    if obj.BrushStyle>integer(bsDiagCross) then
     abrushstyle:=integer(bsDiagCross);
    Canvas.Pen.Color:=CLXColorToVCLColor(obj.Pencolor);
    Canvas.Pen.Style:=TPenStyle(obj.PenStyle);
    Canvas.Brush.Color:=CLXColorToVCLColor(obj.BrushColor);
    Canvas.Brush.Style:=TBrushStyle(abrushstyle);
    Canvas.Pen.Width:=Round(dpix*obj.PenWidth/TWIPS_PER_INCHESS);
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
      Canvas.RoundRect(X+PosX, Y+PosY, X +PosX + W, Y + PosY+ H, S div 4, S div 4);
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
    if (Not (obj.PreviewOnly and toprinter)) then
    begin
    Width:=round(obj.Width*dpix/TWIPS_PER_INCHESS);
    Height:=round(obj.Height*dpiy/TWIPS_PER_INCHESS);
    rec.Top:=PosY;
    rec.Left:=PosX;
    rec.Bottom:=rec.Top+Height-1;
    rec.Right:=rec.Left+Width-1;

    stream:=page.GetStream(obj);
    bitmap:=TBitmap.Create;
    try
{$IFNDEF DOTNETDBUGS}
     bitmap.PixelFormat:=pf32bit;
     bitmap.HandleType:=bmDIB;
{$ENDIF}
     format:='';
     GetJPegInfo(stream,bitmapwidth,bitmapheight,format);
     if (format='JPEG') then
     begin
{$IFNDEF DOTNETD}
      jpegimage:=TJPegImage.Create;
      try
       jpegimage.LoadFromStream(stream);
       bitmap.Assign(jpegimage);
      finally
       jpegimage.free;
      end;
{$ENDIF}
{$IFDEF DOTNETD}
      bitmap.LoadFromStream(stream);
{$ENDIF}
     end
     else
     // Looks if it's a jpeg image
      if (format='BMP') then
        bitmap.LoadFromStream(stream)
      else
      begin
       FilterImage(stream);
       jpegimage:=TJPegImage.Create;
       try
        jpegimage.LoadFromStream(stream);
        bitmap.Assign(jpegimage);
       finally
        jpegimage.free;
       end;
      end;
//     Copy mode does not work for StretDIBBits
//     Canvas.CopyMode:=CLXCopyModeToCopyMode(obj.CopyMode);

     case TRpImageDrawStyle(obj.DrawImageStyle) of
      rpDrawFull:
       begin
        rec.Bottom:=rec.Top+round(bitmap.height/obj.dpires*dpiy)-1;
        rec.Right:=rec.Left+round(bitmap.width/obj.dpires*dpix)-1;
        recsrc.Left:=0;
        recsrc.Top:=0;
        recsrc.Right:=bitmap.Width-1;
        recsrc.Bottom:=bitmap.Height-1;
        DrawBitmap(Canvas,bitmap,rec,recsrc);
       end;
      rpDrawStretch:
       begin
        recsrc.Left:=0;
        recsrc.Top:=0;
        recsrc.Right:=bitmap.Width-1;
        recsrc.Bottom:=bitmap.Height-1;
        DrawBitmap(Canvas,bitmap,rec,recsrc);
       end;
      rpDrawCrop:
       begin
        recsrc.Left:=0;
        recsrc.Top:=0;
        recsrc.Right:=rec.Right-rec.Left;
        recsrc.Bottom:=rec.Bottom-rec.Top;
        DrawBitmap(Canvas,bitmap,rec,recsrc);
       end;
      rpDrawTile,rpDrawTiledpi:
       begin
        // Set clip region
        oldrgn:=CreateRectRgn(0,0,2,2);
        aresult:=GetClipRgn(Canvas.Handle,oldrgn);
        newrgn:=CreateRectRgn(rec.Left,rec.Top,rec.Right,rec.Bottom);
        SelectClipRgn(Canvas.handle,newrgn);
        if TRpImageDrawStyle(obj.DrawImageStyle)=rpDrawTile then
         DrawBitmapMosaicSlow(Canvas,rec,bitmap,0)
        else
         DrawBitmapMosaicSlow(Canvas,rec,bitmap,obj.DPIres);
        if aresult=0 then
         SelectClipRgn(Canvas.handle,0)
        else
         SelectClipRgn(Canvas.handle,oldrgn);
       end;
     end;
    finally
     bitmap.Free;
    end;
   end;
   end;
 end;
end;

procedure TRpGDIDriver.TextRectJustify(Canvas:TCanvas;ARect: TRect; Text: Widestring;
                       Alignment: integer; Clipping: boolean;Wordbreak:boolean;
                       Rotation:integer;RightToLeft:Boolean;drawbackground:Boolean;backcolor:TColor);
var
 recsize:TRect;
 i,index:integer;
 posx,posY,currpos,alinedif:integer;
 singleline:boolean;
 astring:WideString;
 alinesize:integer;
 lwords:TRpWideStrings;
 lwidths:TStringList;
 arec,arec2:TRect;
 aword:WideString;
 nposx,nposy:integer;
 aatext:WideString;
 aansitext:string;
 aalign:Cardinal;
 aintdpix,aintdpiy:integer;
 lastword:boolean;
begin
 try
  if drawbackground then
  begin
   Canvas.Pen.COlor:=backcolor;
   Canvas.Brush.COlor:=backcolor;
  end;
  singleline:=(Alignment AND AlignmentFlags_SingleLine)>0;
  if singleline then
   wordbreak:=false;
  if toprinter then
  begin
   if intdpix=0 then
   begin
    intdpix:=GetDeviceCaps(Printer.Canvas.handle,LOGPIXELSX); //  printer.XDPI;
    intdpiy:=GetDeviceCaps(Printer.Canvas.handle,LOGPIXELSY);  // printer.YDPI;
   end;
   aintdpix:=intdpix;
   aintdpiy:=intdpiy;
  end
  else
  begin
   aintdpix:=dpi;
   aintdpiy:=dpi;
  end;
  // Calculates text extent and apply alignment
  recsize:=ARect;
  if not assigned(npdfdriver) then
    npdfdriver:=TRpPDFDriver.Create;
  npdfdriver.PDFFile.Canvas.Font.Size:=Canvas.Font.Size;
  npdfdriver.PDFFile.Canvas.Font.WFontName:=Canvas.Font.Name;
  npdfdriver.PDFFile.Canvas.Font.Name:=poLinked;
  npdfdriver.PDFFile.Canvas.Font.Color:=Canvas.Font.Color;
  npdfdriver.PDFFile.Canvas.Font.Italic:=fsItalic in Canvas.Font.Style;
  npdfdriver.PDFFile.Canvas.Font.Bold:=fsBold in Canvas.Font.Style;

  npdfdriver.PDFFile.Canvas.TextExtent(Text,recsize,wordbreak,singleline);
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

  for i:=0 to npdfdriver.pdffile.Canvas.LineInfoCount-1 do
  begin
   posX:=ARect.Left;
   // Aligns horz.
   if  ((Alignment AND AlignmentFlags_AlignRight)>0) then
   begin
    // recsize.right contains the width of the full text
    PosX:=ARect.Right-npdfdriver.pdffile.Canvas.LineInfo[i].Width;
   end;
   // Aligns horz.
   if (Alignment AND AlignmentFlags_AlignHCenter)>0 then
   begin
    PosX:=ARect.Left+(((Arect.Right-Arect.Left)-npdfdriver.pdffile.Canvas.LineInfo[i].Width) div 2);
   end;
   astring:=Copy(Text,npdfdriver.pdffile.Canvas.LineInfo[i].Position,npdfdriver.pdffile.Canvas.LineInfo[i].Size);
   if  (((Alignment AND AlignmentFlags_AlignHJustify)>0) AND (NOT npdfdriver.pdffile.Canvas.LineInfo[i].LastLine)) then
   begin
    // Calculate the sizes of the words, then
    // share space between words
    lwords:=TRpWideStrings.Create;
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
       npdfdriver.pdffile.Canvas.TextExtent(lwords.Strings[index],arec,false,true);
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
        nposx:=currpos;
        nposy:=PosY+npdfdriver.pdffile.Canvas.LineInfo[i].TopPos;
        nposx:=Round(nposx*aintdpix/1440);
        nposy:=Round(nposy*aintdpiy/1440);
        arec2.Left:=nposx;
        arec2.Top:=nposy;
        arec2.Bottom:=arec.Top+Round(npdfdriver.pdffile.Canvas.LineInfo[i].Height*aintdpiy/1440);
        arec2.Right:=Round(arect.Right*aintdpix/1440);
        aalign:=DT_NOPREFIX or DT_NOCLIP;
        lastword:=((index=lwords.Count-1) AND (lwords.count>1));
        if lastword then
         aalign:=aalign OR DT_RIGHT
        else
         aalign:=aalign OR DT_LEFT;
        if IsWindowsNT then
        begin
         aatext:=lwords.strings[index];
         DrawTextW(Canvas.Handle,PWideChar(aatext),Length(aatext),arec2,aalign);
        end
        else
        begin
         aansitext:=lwords.strings[index];
         DrawTextA(Canvas.Handle,PChar(aansitext),Length(aansitext),arec2,aalign);
        end;
//        TextOutW(Canvas.Handle,nposx,nposy,PWideChar(lwords.strings[index]),
//         Length(lwords.strings[index]));
//        TextOut(currpos,PosY+npdfdriver.pdffile.Canvas.LineInfo[i].TopPos,lwords.strings[index],
//         npdfdriver.pdffile.Canvas.LineInfo[i].Width,Rotation,RightToLeft);
        currpos:=currpos+StrToInt(lwidths.Strings[index])+alinedif;
        if (drawbackground) then
        begin
         if lastword then
          aalign:=(aalign AND (NOT DT_RIGHT)) OR DT_LEFT;
         if IsWindowsNT then
         begin
          DrawTextW(Canvas.Handle,PWideChar(aatext),Length(aatext),arec2,aalign or DT_CALCRECT);
         end
         else
         begin
          DrawTextA(Canvas.Handle,PChar(aansitext),Length(aansitext),arec2,aalign or DT_CALCRECT);
         end;
         arec2.Top:=nposy;
         arec2.Bottom:=nposy+Round(npdfdriver.pdffile.Canvas.LineInfo[i].Height*aintdpiy/1440);
         if (lastword) then
         begin
          arec2.Left:=nposx-1;
          arec2.Right:=Round(arect.Right*aintdpix/1440)-(arec2.Right-arec2.Left)+1;
         end
         else
         begin
          arec2.Left:=arec2.Right-1;
          arec2.Right:=Round(currpos*aintdpix/1440)+1;
         end;
         Canvas.Rectangle(arec2.Left,arec2.Top,arec2.Right,arec2.Bottom);
        end;
       end;
      end;
     finally
      lwidths.Free;
     end;
    finally
     lwords.free;
    end;
   end
   else
   begin
    aalign:=DT_NOPREFIX or DT_NOCLIP or DT_LEFT;
    nposx:=Posx;
    nposy:=PosY+npdfdriver.pdffile.Canvas.LineInfo[i].TopPos;
    nposx:=Round(nposx*aintdpix/1440);
    nposy:=Round(nposy*aintdpiy/1440);
    arec2.Left:=nposx;
    arec2.Top:=nposy;
    arec2.Bottom:=arec.Bottom+100;
    arec2.Right:=Round(arect.Right*aintdpix/1440);
    if IsWindowsNT then
     DrawTextW(Canvas.Handle,PWideChar(astring),Length(astring),arec2,aalign)
//     TextOutW(Canvas.Handle,nposx,nposy,PWideChar(astring),
//       Length(astring))
    else
    begin
     aansitext:=Trim(astring);
     DrawTextA(Canvas.Handle,PChar(aansitext),Length(aansitext),arec2,aalign);
//     TextOut(Canvas.Handle,nposx,nposy,PChar(aansitext),
//       Length(astring))
    end;
   end;
//    TextOut(PosX,PosY+npdfdriver.pdffile.Canvas.LineInfo[i].TopPos,astring,npdfdriver.pdffile.Canvas.LineInfo[i].Width,Rotation,RightToLeft);
  end;
 finally
 end;
end;


procedure TRpGDIDriver.DrawPage(apage:TRpMetaFilePage);
var
 j:integer;
 rec:TRect;
 dpix,dpiy:integer;
 selected:boolean;
begin
 if toprinter then
 begin
  for j:=0 to apage.ObjectCount-1 do
  begin
   IntDrawObject(apage,apage.Objects[j],false);
  end;
 end
 else
 begin
  UpdateBitmapSize(FReport,apage);
  if assigned(metacanvas) then
  begin
   metacanvas.free;
   metacanvas:=nil;
  end;
  if assigned(meta) then
  begin
   meta.free;
   meta:=nil;
  end;
  meta:=TMetafile.Create;
  try
   meta.Enhanced:=true;
   meta.Width:=bitmapwidth;
   meta.Height:=bitmapheight;
   metacanvas:=TMetafileCanvas.Create(meta,0);
   try
    for j:=0 to apage.ObjectCount-1 do
    begin
     selected:=FReport.IsFound(apage,j);
     IntDrawObject(apage,apage.Objects[j],selected);
    end;
    //Draw page margins
    if (showpagemargins) then
    begin
     rec:=rpvgraphutils.GetPageMarginsTWIPS;
     // transform to dpi device
     dpix:=Screen.PixelsPerInch;
     dpiy:=Screen.PixelsPerInch;

     rec.Left:=round(rec.Left*dpix/TWIPS_PER_INCHESS);
     rec.Top:=round(rec.Top*dpiy/TWIPS_PER_INCHESS);
     rec.Right:=round(rec.Right*dpix/TWIPS_PER_INCHESS);
     rec.Bottom:=round(rec.Bottom*dpiy/TWIPS_PER_INCHESS);
     metacanvas.Brush.Style:=bsClear;
     metacanvas.Pen.Color:=clBlack;
     metacanvas.Pen.Style:=psSolid;

     metacanvas.Rectangle(rec);
    end;
   finally
    metacanvas.free;
    metacanvas:=nil;
   end;
   // Draws the metafile scaled
   if Round(scale*1000)=1000 then
   begin
    Bitmap.Canvas.Draw(0,0,Meta);
   end
   else
   begin
    rec.Top:=0;
    rec.Left:=0;
    rec.Right:=bitmap.Width-1;
    rec.Bottom:=bitmap.Height-1;
    Bitmap.Canvas.StretchDraw(rec,Meta);
   end;
  finally
   meta.free;
   meta:=nil;
  end;
 end;
end;

procedure TRpGDIDriver.DrawObject(page:TRpMetaFilePage;obj:TRpMetaObject);
begin
 IntDrawObject(page,obj,false);
end;

procedure TRpGDIDriver.IntDrawObject(page:TRpMetaFilePage;obj:TRpMetaObject;selected:boolean);
var
 dpix,dpiy:integer;
 Canvas:TCanvas;
begin
 if onlycalc then
  exit;
 if (toprinter) then
 begin
  if not printer.Printing then
   Raise Exception.Create(SRpGDIDriverNotInit);
  dpix:=intdpix;
  dpiy:=intdpiy;
  Canvas:=printer.canvas;
 end
 else
 begin
  if not Assigned(bitmap) then
   Raise Exception.Create(SRpGDIDriverNotInit);
  if not Assigned(metacanvas) then
   Raise Exception.Create(SRpGDIDriverNotInit);
  Canvas:=metacanvas;
  dpix:=Screen.PixelsPerInch;
  dpiy:=Screen.PixelsPerInch;
 end;
 PrintObject(Canvas,page,obj,dpix,dpiy,toprinter,pagemargins,devicefonts,offset,selected);
end;

function TRpGDIDriver.AllowCopies:boolean;
begin
 Result:=false;
end;

function TRpGDIDriver.GetPageSize(var PageSizeQt:Integer):TPoint;
var
 gdisize:TGDIPageSize;
 qtsize:TPageSizeQt;
 asize:TPoint;
begin
 gdisize:=GetCurrentPaper;
 qtsize:=GDIPageSizeToQtPageSize(gdisize);
 PageSizeQt:=qtsize.Indexqt;
 asize:=GetPhysicPageSizeTwips;
{ if ((asize.x<1) or (asize.y<1)) then
 begin
  gdisize.Width:=Round(gdisize.Width/100/CMS_PER_INCHESS*TWIPS_PER_INCHESS);
  gdisize.Height:=Round(gdisize.Height/100/CMS_PER_INCHESS*TWIPS_PER_INCHESS);

  if Printer.Orientation=poLandscape then
  begin
   asize.x:=gdisize.Height;
   asize.y:=gdisize.Width;
  end
  else
  begin
   asize.x:=gdisize.Width;
   asize.y:=gdisize.Height;
  end;
 end;
} Result:=asize;
end;

function TRpGDIDriver.SetPagesize(PagesizeQt:TPageSizeQt):TPoint;
var
 qtsize:integer;
begin
 pagesize:=QtPageSizeToGDIPageSize(PagesizeQT);
 oldpagesize:=GetCurrentPaper;
 SetCurrentPaper(pagesize);

 Result:=GetPageSize(qtsize);
end;

procedure TRpGDIDriver.SetOrientation(Orientation:TRpOrientation);
var
 currentorientation:TPrinterOrientation;
begin
 currentorientation:=GetPrinterOrientation;
// if Orientation=rpOrientationPortrait then
 if Orientation<>rpOrientationLandscape then
 begin
  if currentorientation<>poPortrait then
  begin
   if not orientationset then
   begin
    orientationset:=true;
    oldorientation:=currentorientation;
   end;
   if printer.Printing then
    SetPrinterOrientation(false)
   else
    Printer.Orientation:=poPortrait;
  end;
 end
 else
// if Orientation=rpOrientationLandscape then
 begin
  if currentorientation<>poLandscape then
  begin
   if not orientationset then
   begin
    orientationset:=true;
    oldorientation:=currentorientation;
   end;
   if printer.Printing then
    SetPrinterOrientation(true)
   else
    Printer.Orientation:=poLandscape;
  end;
 end;
end;

procedure DoPrintMetafile(metafile:TRpMetafileReport;tittle:string;
 aform:TFRpVCLProgress;allpages:boolean;frompage,topage,copies:integer;
 collate:boolean;devicefonts:boolean;printerindex:TRpPrinterSelect=pRpDefaultPrinter;nobegindoc:boolean=false);
var
 i:integer;
 j:integer;
 apage:TRpMetafilePage;
 pagecopies:integer;
 reportcopies:integer;
 dpix,dpiy:integer;
 count1,count2:integer;
 mmfirst,mmlast:DWORD;
 difmilis:int64;
 totalcount:integer;
 pagemargins:TRect;
 offset:TPoint;
 istextonly:boolean;
 drivername,S:String;
 memstream:TMemoryStream;
 rPageSizeQt:TPageSizeQt;
 gdidriver:TRpGDIDriver;
 currentorientation:TPrinterOrientation;
 pconfig:TPrinterConfig;
begin
 pconfig.Changed:=false;
 gdidriver:=nil;
 try
 if copies=0 then
  copies:=1;
 drivername:=Trim(GetPrinterEscapeStyleDriver(printerindex));
 istextonly:=Length(drivername)>0;
 if istextonly then
 begin
  memstream:=TMemoryStream.Create;
  try
   rptextdriver.SaveMetafileRangeToText(metafile,allpages,frompage,topage,
    copies,memstream);
   memstream.Seek(0,soFromBeginning);
   SetLength(S,MemStream.Size);
{$IFNDEF DOTNETD}
   MemStream.Read(S[1],MemStream.Size);
{$ENDIF}
{$IFDEF DOTNETD}
   s:=MemStream.ToString;
{$ENDIF}
  finally
   memstream.free;
  end;
  // Now Prints to selected printer the stream
  if (not metafile.BlockPrinterSelection) then
   PrinterSelection(metafile.PrinterSelect,metafile.papersource,metafile.duplex,pconfig);
  SendControlCodeToPrinter(S);
 end
 else
 begin
  if (not metafile.BlockPrinterSelection) then
  begin
   if printerindex<>pRpDefaultPrinter then
    offset:=PrinterSelection(printerindex,metafile.papersource,metafile.duplex,pconfig)
   else
    offset:=PrinterSelection(metafile.PrinterSelect,metafile.papersource,metafile.duplex,pconfig);
  end;
  UpdatePrinterFontList;
  pagemargins:=GetPageMarginsTWIPS;
  // Get the time
  mmfirst:=TimeGetTime;
  gdidriver:=TRpGDIDriver.Create;
  try
   currentorientation:=GetPrinterOrientation;
   // Sets page size and orientation
   if metafile.Orientation<>rpOrientationDefault then
   begin
    if metafile.Orientation=rpOrientationPortrait then
    begin
     if currentorientation<>poPortrait then
     begin
      gdidriver.orientationset:=true;
      gdidriver.oldorientation:=currentorientation;
      if printer.Printing then
       SetPrinterOrientation(false)
      else
       printer.Orientation:=poPortrait;
     end;
    end
    else
    begin
     if currentorientation<>poLandscape then
     begin
      gdidriver.orientationset:=true;
      gdidriver.oldorientation:=currentorientation;
      if printer.Printing then
       SetPrinterOrientation(true)
      else
       printer.Orientation:=poLandscape;
     end;
    end;
   end;
   // Sets pagesize
   rpagesizeQt.papersource:=metafile.PaperSource;
   rpagesizeQt.duplex:=metafile.duplex;
   if Metafile.PageSize<0 then
   begin
    rpagesizeqt.Custom:=True;
    rPageSizeQt.CustomWidth:=metafile.CustomX;
    rPageSizeQt.CustomHeight:=metafile.CustomY;
   end
   else
   begin
    rpagesizeqt.Indexqt:=metafile.PageSize;
    rpagesizeqt.Custom:=False;
   end;
    gdidriver.toprinter:=True;
    gdidriver.selectedprinter:=printerindex;
    gdidriver.SetPagesize(rpagesizeqt);
   except
    On E:Exception do
    begin
     rpgraphutilsvcl.RpMessageBox(E.Message);
    end;
   end;
   pagecopies:=1;
   reportcopies:=1;

   if copies>1 then
   begin
    if (PrinterSupportsCopies(copies)) then
    begin
     if collate then
     begin
      if PrinterSupportsCollation then
      begin
       SetPrinterCopies(copies);
       SetPrinterCollation(true);
      end
      else
      begin
       SetPrinterCopies(1);
       SetPrinterCollation(false);
       reportcopies:=copies;
      end;
     end
     else
     begin
      SetPrinterCopies(copies);
      SetPrinterCollation(false);
     end;
    end
    else
    begin
     SetPrinterCopies(1);
     SetPrinterCollation(false);
     if collate then
      reportcopies:=copies
     else
      pagecopies:=copies;
    end;
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
   if metafile.OpenDrawerBefore then
     SendControlCodeToPrinter(GetPrinterRawOp(printerindex,rawopopendrawer));
   if ((not nobegindoc) OR (not printer.Printing)) then
   begin
    printer.Title:=Tittle;
    printer.Begindoc;
   end;
   try
    dpix:=GetDeviceCaps(Printer.Canvas.handle,LOGPIXELSX);
    dpiy:=GetDeviceCaps(Printer.Canvas.handle,LOGPIXELSY);
    totalcount:=0;
    for count1:=0 to reportcopies-1 do
    begin
     for i:=frompage to topage do
     begin
      for count2:=0 to pagecopies-1 do
      begin
       apage:=metafile.Pages[i];
       if totalcount>0 then
        gdidriver.NewPage(apage);
       inc(totalcount);
       for j:=0 to apage.ObjectCount-1 do
       begin
        gdidriver.PrintObject(Printer.Canvas,apage,apage.Objects[j],dpix,dpiy,true,pagemargins,devicefonts,offset,false);
        if assigned(aform) then
        begin
         mmlast:=TimeGetTime;
         difmilis:=(mmlast-mmfirst);
         if difmilis>MILIS_PROGRESS then
         begin
          // Get the time
          mmfirst:=TimeGetTime;
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
    Printer.EndDoc;
   except
    printer.Abort;
    raise;
   end;
  end;
  if metafile.OpenDrawerAfter then
   SendControlCodeToPrinter(GetPrinterRawOp(printerindex,rawopopendrawer));
  if Assigned(gdidriver) then
  begin
   gdidriver.SendAfterPrintOperations;
   if gdidriver.orientationset then
   begin
    Printer.Orientation:=gdidriver.oldorientation;
   end;
  end;
 finally
  if assigned(gdidriver) then
   gdidriver.free;
  SetPrinterConfig(pconfig);
 end;
 // Send Especial operations
 if assigned(aform) then
  aform.close;
end;

function PrintMetafile(metafile:TRpMetafileReport;tittle:string;
 showprogress,allpages:boolean;frompage,topage,copies:integer;
  collate:boolean;devicefonts:boolean;printerindex:TRpPrinterSelect=pRpDefaultPrinter;nobegindoc:boolean=false):boolean;
var
 dia:TFRpVCLProgress;
begin
 Result:=true;
 if Not ShowProgress then
 begin
  DoPrintMetafile(metafile,tittle,nil,allpages,frompage,topage,copies,collate,devicefonts,printerindex,nobegindoc);
  exit;
 end;
 dia:=TFRpVCLProgress.Create(Application);
 try
  dia.oldonidle:=Application.OnIdle;
  try
   dia.metafile:=metafile;
   dia.tittle:=tittle;
   dia.allpages:=allpages;
   dia.frompage:=frompage;
   dia.topage:=topage;
   dia.copies:=copies;
   dia.collate:=collate;
   dia.devicefonts:=devicefonts;
   dia.printerindex:=printerindex;
   dia.nobegindoc:=nobegindoc;
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

type
  LogPal = record
   lpal : TLogPalette;
   dummy:Array[0..5] of TPaletteEntry;
  end;

const
 MAX_RES_BITMAP=5760;

function DoMetafileToBitmap(metafile:TRpMetafileReport;aform:TFRpVCLProgress;
 Mono:Boolean;resx:integer=200;resy:integer=100):TBitmap;
var
 GDIDriver:TRpGDIDriver;
 apage:TRpMetafilePage;
 i,j:integer;
 offset:TPoint;
 pagemargins:TRect;
 mmfirst,mmlast:DWORD;
 difmilis:int64;
 pageheight,pagewidth:integer;
 arec:TRect;
 syspal:Logpal;
 realx,realy:Integer;
 ameta:TMetaFile;
 ametacanvas:TMetafileCanvas;
 rgbintensity:integer;
 aobj:TrpMetaObject;
 ddc:HDC;
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
 offset.X:=0;
 offset.Y:=0;
 mmfirst:=TimeGetTime;
 pagemargins.Left:=0;
 pagemargins.Top:=0;
 pagemargins.Bottom:=0;
 pagemargins.Top:=0;
 Result:=TBitmap.Create;
 try
  Result.HandleType:=bmDIB;
{$IFNDEF DOTNETD}
  if Mono then
  begin
   Result.PixelFormat:=pf1bit;
   syspal.lpal.palNumEntries:=2;
   syspal.lpal.palVersion:=$300;
   syspal.lpal.palPalEntry[0].peRed:=255;
   syspal.lpal.palPalEntry[0].peGreen:=255;
   syspal.lpal.palPalEntry[0].peBlue:=255;
   syspal.dummy[0].peRed:=0;
   syspal.dummy[0].peGreen:=0;
   syspal.dummy[0].peBlue:=0;
   Result.Palette:=CreatePalette(syspal.lpal);
  end
  else
{$ENDIF}
  begin
{$IFNDEF DOTNETDBUGS}
   Result.PixelFormat:=pf32bit;
{$ENDIF}
  end;
  pagewidth:=(metafile.CustomX*resx) div TWIPS_PER_INCHESS;
  Result.Width:=pagewidth;
  pageheight:=(metafile.CustomY*resy) div TWIPS_PER_INCHESS;
  metafile.RequestPage(MAX_PAGECOUNT);
  Result.Height:=pageheight*metafile.CurrentPageCount;
  arec.Top:=0;
  arec.Right:=pagewidth*2;
  arec.Bottom:=pageheight*metafile.CurrentPagecount+pageheight;
  arec.Left:=0;
  Result.Canvas.Brush.Color:=CLXColorToVCLColor(metafile.BackColor);
  Result.Canvas.FillRect(arec);
  GDIDriver:=TRpGDIDriver.Create;
  try
   for i:=0 to metafile.CurrentPageCount-1 do
   begin
    ameta:=TMetafile.Create;
    try
     ameta.Enhanced:=true;
     if mono then
      ameta.Palette:=CreatePalette(syspal.lpal);
     ddc:=GetDC(0);
     realx:=GetDeviceCaps(ddc,LOGPIXELSX);
     realy:=GetDeviceCaps(ddc,LOGPIXELSY);
     ReleaseDC(0,ddc);
     ameta.Width:=metafile.CustomX*realx div TWIPS_PER_INCHESS;
     ameta.height:=metafile.CustomY*realy div TWIPS_PER_INCHESS;
     apage:=metafile.Pages[i];
     ametacanvas:=TMetafileCanvas.Create(ameta,0);
     try
      for j:=0 to apage.ObjectCount-1 do
      begin
       aobj:=apage.Objects[j];
       if mono then
       begin
        if apage.Objects[j].Metatype=rpMetaText then
        begin
         rgbintensity:=(aobj.FontColor AND $FF)+
          ((aobj.FontColor AND $FF00) shr 8)+
          ((aobj.FontColor AND $FF0000) shr 16);
         if rgbintensity>128*3 then
          aobj.FontColor:=clWhite
         else
          aobj.FontColor:=clBlack;
        end;
       end;
       gdidriver.PrintObject(ametaCanvas,apage,aobj,realx,realy,true,pagemargins,false,offset,false);
       if assigned(aform) then
       begin
        mmlast:=TimeGetTime;
        difmilis:=(mmlast-mmfirst);
        if difmilis>MILIS_PROGRESS then
        begin
         // Get the time
         mmfirst:=TimeGetTime;
         aform.LRecordCount.Caption:=SRpPage+':'+ IntToStr(i+1)+
           ' - '+SRpItem+':'+ IntToStr(j+1);
         Application.ProcessMessages;
         if aform.cancelled then
          Raise Exception.Create(SRpOperationAborted);
        end;
       end;
      end;
     finally
      ametacanvas.free;
     end;
     arec.Top:=pageheight*i;
     arec.Left:=0;
     arec.Bottom:=arec.Top+pageheight;
     arec.Right:=pagewidth;
     Result.Canvas.StretchDraw(arec,ameta);
     if assigned(aform) then
     begin
      Application.ProcessMessages;
       if aform.cancelled then
        Raise Exception.Create(SRpOperationAborted);
     end;
    finally
     ameta.free;
    end;
   end;
  finally
   gdidriver.free;
  end;
 except
  Result.free;
  raise;
 end;
end;

function MetafileToBitmap(metafile:TRpMetafileReport;ShowProgress:Boolean;
 Mono:Boolean;resx:integer=200;resy:integer=100):TBitmap;
var
 dia:TFRpVCLProgress;
begin
 if Not ShowProgress then
 begin
  Result:=DoMetafileToBitmap(metafile,nil,mono,resx,resy);
  exit;
 end;
 dia:=TFRpVCLProgress.Create(Application);
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
   Result:=dia.MetaBitmap;
   if dia.errorproces then
    Raise Exception.Create(dia.ErrorMessage);
  finally
   Application.OnIdle:=dia.oldonidle;
  end;
 finally
  dia.free;
 end;
end;

procedure TFRpVCLProgress.FormCreate(Sender: TObject);
begin
 LRecordCount.Font.Style:=[fsBold];
 LTittle.Font.Style:=[fsBold];

 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
 LTitle.Caption:=TranslateStr(252,LTitle.Caption);
 LProcessing.Caption:=TranslateStr(253,LProcessing.Caption);
 GPrintRange.Caption:=TranslateStr(254,GPrintRange.Caption);
 LFrom.Caption:=TranslateStr(255,LFrom.Caption);
 LTo.Caption:=TranslateStr(256,LTo.Caption);
 RadioAll.Caption:=TranslateStr(257,RadioAll.Caption);
 RadioRange.Caption:=TranslateStr(258,RadioRange.Caption);
 Caption:=TranslateStr(259,Caption);

 LHorzRes.Caption:=SRpHorzRes;
 LVertRes.Caption:=SRpVertRes;
 CheckMono.Caption:=SRpMonochrome;
end;

procedure TFRpVCLProgress.AppIdle(Sender:TObject;var done:boolean);
begin
 errorproces:=false;
 cancelled:=false;
 Application.OnIdle:=nil;
 done:=false;
 try
  LTittle.Caption:=tittle;
  LProcessing.Visible:=true;
  DoPrintMetafile(metafile,tittle,self,allpages,frompage,topage,copies,collate,devicefonts,printerindex,nobegindoc);
 except
  On E:Exception do
  begin
   ErrorMessage:=E.Message;
   errorproces:=true;
  end;
 end;
 Close;
end;

procedure TFRpVCLProgress.AppIdleBitmap(Sender:TObject;var done:boolean);
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


procedure TFRpVCLProgress.BCancelClick(Sender: TObject);
begin
 cancelled:=true;
end;


{$IFNDEF FORWEBAX}
function ExportReportToPDF(report:TRpReport;Caption:string;progress:boolean;
  allpages:boolean;frompage,topage,copies:integer;
  showprintdialog:boolean;filename:string;compressed:boolean;collate:Boolean):Boolean;
var
 dia:TFRpVCLProgress;
 oldonidle:TIdleEvent;
 pdfdriver:TRpPDFDriver;
 gdidriver:TRpGDIDriver;
begin
 Result:=false;
 allpages:=true;
 collate:=false;
 if showprintdialog then
 begin
  if Not DoShowPrintDialog(allpages,frompage,topage,copies,collate,true) then
   exit;
 end;
 if progress then
 begin
  // Assign appidle frompage to page...
  dia:=TFRpVCLProgress.Create(Application);
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
  gdidriver:=TRpGDIDriver.create;
  pdfdriver:=TRpPDFDriver.Create;
  try
   pdfdriver.filename:=filename;
   pdfdriver.compressed:=compressed;
 {$IFDEF USETEECHART}
   report.Metafile.OnDrawChart:=gdidriver.DoDrawChart;
 {$ENDIF}
 {$IFDEF EXTENDEDGRAPHICS}
  report.Metafile.OnFilterImage:=gdidriver.FilterImage;
 {$ENDIF}
   report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
  finally
   gdidriver.free;
   pdfdriver.free;
  end;
  Result:=True;
 end;
end;

function ExportReportToPDFMetaStream (report:TRpReport; Caption:string; progress:boolean;
  allpages:boolean; frompage,topage,copies:integer;
  showprintdialog:boolean; stream:TStream;compressed:boolean;collate:boolean;metafile:Boolean):Boolean;
var
 pdfdriver:TRpPDFDriver;
 gdidriver:TRpGDIDriver;
 oldtwopass:Boolean;
 onprog:TRpProgressEvent;
begin
 oldtwopass:=report.TwoPass;
 onprog:=report.OnPRogress;
 try
  if metafile then
   report.TwoPass:=true;
  gdidriver:=TRpGDIDriver.create;
  pdfdriver:=TRpPDFDriver.Create;
  try
   if not metafile then
    pdfdriver.DestStream:=stream;
   pdfdriver.compressed:=compressed;
   if progress then
    report.OnProgress:=pdfdriver.RepProgress;
{$IFDEF USETEECHART}
   report.Metafile.OnDrawChart:=gdidriver.DoDrawChart;
{$ENDIF}
{$IFDEF EXTENDEDGRAPHICS}
  report.Metafile.OnFilterImage:=gdidriver.FilterImage;
{$ENDIF}
   if metafile then
   begin
    report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
   end
   else
    report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
   if metafile then
    report.Metafile.SaveToStream(stream);
  finally
   pdfdriver.free;
   gdidriver.Free;
  end;
 finally
  report.TwoPass:=oldtwopass;
  report.OnPRogress:=onprog;
 end;
 Result:=True;
end;

procedure TFRpVCLProgress.RepProgress(Sender:TRpBaseReport;var docancel:boolean);
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
 FormatFloat('#########,####',Sender.PageNum+1)+'-'+FormatFloat('#########,####',Sender.RecordCount+1);
 if Sender.LastPage then
  LRecordCount.Caption:=Format('%-20.20s',[SRpPage])+FormatFloat('0000000000',Sender.PageNum+1);
 Application.ProcessMessages;
 if cancelled then
  docancel:=true;
end;


procedure TFRpVCLProgress.AppIdleReport(Sender:TObject;var done:boolean);
var
 oldprogres:TRpProgressEvent;
 istextonly:Boolean;
 drivername:String;
 TextDriver:TRpTextDriver;
 pdfdriver:TRpPdfDriver;
 GDIDriver:TRpGDIDriver;
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
    if (not report.metafile.BlockPrinterSelection) then
     TextDriver.SelectPrinter(report.PrinterSelect);
    oldprogres:=report.OnProgress;
    try
     report.OnProgress:=RepProgress;
     report.PrintAll(TextDriver);
    finally
     report.OnProgress:=oldprogres;
    end;
   finally
    TextDriver.Free;
   end;
  end
  else
  begin
   if usepdfdriver then
   begin
    pdfdriver:=TRpPdfDriver.Create;
    try
     oldprogres:=report.OnProgress;
     try
      report.OnProgress:=RepProgress;
      report.PrintAll(PDFDriver);
     finally
      report.OnProgress:=oldprogres;
     end;
    finally
     pdfdriver.Free;
    end;
   end
   else
   begin
    GDIDriver:=TRpGDIDriver.Create;
    try
     gdidriver.noenddoc:=noenddoc;
     if noenddoc then
      gdidriver.ToPrinter:=true;
     if report.PrinterFonts=rppfontsalways then
      gdidriver.devicefonts:=true
     else
      gdidriver.devicefonts:=false;
     gdidriver.neverdevicefonts:=report.PrinterFonts=rppfontsnever;
     oldprogres:=report.OnProgress;
     try
      report.OnProgress:=RepProgress;
      report.PrintAll(GDIDriver);
     finally
      report.OnProgress:=oldprogres;
     end;
    finally
     gdidriver.free;
    end;
   end;
  end;
 except
  On E:Exception do
  begin
   ErrorMessage:=E.Message;
   errorproces:=true;
  end;
 end;
 Close;
end;

function CalcReportWidthProgress(report:TRpReport;noenddoc:boolean=false):boolean;
var
 dia:TFRpVCLProgress;
begin
 Result:=false;
 dia:=TFRpVCLProgress.Create(Application);
 try
  dia.oldonidle:=Application.OnIdle;
  try
   dia.report:=report;
   Application.OnIdle:=dia.AppIdleReport;
   dia.noenddoc:=noenddoc;
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

function CalcReportWidthProgressPDF(report:TRpReport;noenddoc:boolean=false):boolean;
var
 dia:TFRpVCLProgress;
begin
 Result:=false;
 dia:=TFRpVCLProgress.Create(Application);
 try
  dia.oldonidle:=Application.OnIdle;
  try
   dia.report:=report;
   Application.OnIdle:=dia.AppIdleReport;
   dia.usepdfdriver:=True;
   dia.noenddoc:=noenddoc;
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


procedure TFRpVCLProgress.AppIdlePrintRange(Sender:TObject;var done:boolean);
var
 oldprogres:TRpProgressEvent;
 GDIDriver:TRpGDIDriver;
begin
 Application.Onidle:=nil;
 done:=false;
 errorproces:=false;
 try
  GDIDriver:=TRpGDIDriver.Create;
  try
   GDIDriver.toprinter:=true;
   if report.PrinterFonts=rppfontsalways then
    gdidriver.devicefonts:=true
   else
    gdidriver.devicefonts:=false;
   gdidriver.neverdevicefonts:=report.PrinterFonts=rppfontsnever;
   oldprogres:=report.OnProgress;
   try
    report.OnProgress:=RepProgress;
    report.PrintRange(GDIDriver,allpages,frompage,topage,copies,collate);
   finally
    report.OnProgress:=oldprogres;
   end;
  finally
   gdidriver.free;
  end;
 except
  On E:Exception do
  begin
   ErrorMessage:=E.Message;
   errorproces:=true;
  end;
 end;
 Close;
end;

procedure TFRpVCLProgress.AppIdlePrintRangeText(Sender:TObject;var done:boolean);
var
 oldprogres:TRpProgressEvent;
 S:String;
 TextDriver:TRpTextDriver;
 pconfig:TPrinterConfig;
begin
 pconfig.changed:=false;
 Application.Onidle:=nil;
 done:=false;
 try
 errorproces:=false;
 try
  TextDriver:=TRpTextDriver.Create;
  try
  oldprogres:=report.OnProgress;
  try
   if (not report.Metafile.BlockPrinterSelection) then
    TextDriver.SelectPrinter(report.PrinterSelect);
   report.OnProgress:=RepProgress;
   report.PrintRange(TextDriver,allpages,frompage,topage,copies,collate);
   // Now Prints to selected printer the stream
   SetLength(S,TextDriver.MemStream.Size);
{$IFNDEF DOTNETD}
   TextDriver.MemStream.Read(S[1],TextDriver.MemStream.Size);
{$ENDIF}
{$IFDEF DOTNETD}
    s:=TextDriver.MemStream.ToString;
{$ENDIF}
   if (not report.metafile.BlockPrinterSelection) then
    PrinterSelection(report.PrinterSelect,report.papersource,report.duplex,pconfig);
   SendControlCodeToPrinter(S);
  finally
   report.OnProgress:=oldprogres;
  end;
  finally
   TextDriver.free;
  end;
 except
  On E:Exception do
  begin
   ErrorMessage:=E.Message;
   errorproces:=true;
  end;
 end;
 finally
  SetPrinterConfig(pconfig);
 end;
 Close;
end;



procedure TFRpVCLProgress.AppIdlePrintPDF(Sender:TObject;var done:boolean);
var
 oldprogres:TRpProgressEvent;
 gdidriver:TRpGDIDriver;
 pdfdriver:TRpPDFDriver;
begin
 Application.Onidle:=nil;
 done:=false;
 errorproces:=false;
 try
  pdfdriver:=TRpPDFDriver.Create;
  gdidriver:=TRpGDIDriver.Create;
  try

   pdfdriver.filename:=filename;
   pdfdriver.compressed:=pdfcompressed;
 {$IFDEF USETEECHART}
   report.Metafile.OnDrawChart:=gdidriver.DoDrawChart;
 {$ENDIF}
 {$IFDEF EXTENDEDGRAPHICS}
  report.Metafile.OnFilterImage:=gdidriver.FilterImage;
 {$ENDIF}
   oldprogres:=report.OnProgress;
   try
    report.OnProgress:=RepProgress;
    report.PrintRange(pdfdriver,allpages,frompage,topage,copies,collate);
   finally
    report.OnProgress:=oldprogres;
   end;
  finally
   pdfdriver.free;
   gdidriver.free;
  end;
 except
  On E:Exception do
  begin
   ErrorMessage:=E.Message;
   errorproces:=true;
  end;
 end;
 Close;
end;



function PrintReport(report:TRpReport;Caption:string;progress:boolean;
  allpages:boolean;frompage,topage,copies:integer;collate:boolean):Boolean;
var
 GDIDriver:TRpGDIDriver;
 TextDriver:TRpTextDriver;
 forcecalculation:boolean;
 dia:TFRpVCLProgress;
 oldonidle:TIdleEvent;
 devicefonts:boolean;
 istextonly:boolean;
 drivername:String;
 S:String;
 pconfig:TPrinterConfig;
begin
 pconfig.Changed:=false;
 try
 report.metafile.Title:=Caption;
 drivername:=Trim(GetPrinterEscapeStyleDriver(report.PrinterSelect));
 istextonly:=Length(drivername)>0;
 if report.PrinterFonts=rppfontsalways then
  devicefonts:=true
 else
  devicefonts:=false;
 Result:=true;
 forcecalculation:=false;
 if ((report.copies>1) and (collate)) then
 begin
  forcecalculation:=true;
 end;
 if report.TwoPass then
  forcecalculation:=true;
 if forcecalculation then
 begin
  if progress then
  begin
   try
    if Not CalcReportWidthProgress(report,true) then
     Result:=false
    else
     PrintMetafile(report.Metafile,Caption,progress,allpages,frompage,topage,copies,collate,devicefonts,report.PrinterSelect,true);
   finally
    if Printer.Printing then
     Printer.Abort;
   end
  end
  else
  begin
   try
    if istextonly then
    begin
     TextDriver:=TRpTextDriver.Create;
     try
      if (not report.Metafile.BlockPrinterSelection) then
       TextDriver.SelectPrinter(report.PrinterSelect);
      report.PrintAll(TextDriver);
     finally
      TextDriver.free;
     end;
    end
    else
    begin
     GDIDriver:=TRpGDIDriver.Create;
     try
      if report.PrinterFonts=rppfontsalways then
       gdidriver.devicefonts:=true
      else
       gdidriver.devicefonts:=false;
      gdidriver.toprinter:=true;
      gdidriver.neverdevicefonts:=report.PrinterFonts=rppfontsnever;
      gdidriver.noenddoc:=true;
      report.PrintAll(GDIDriver);
     finally
      gdidriver.free;
     end;
    end;
    PrintMetafile(report.Metafile,Caption,progress,allpages,frompage,topage,copies,collate,devicefonts,report.PrinterSelect,true);
   finally
    if Printer.Printing then
     Printer.Abort;
   end
  end;
  exit;
 end;
 if progress then
 begin
  // Assign appidle frompage to page...
  dia:=TFRpVCLProgress.Create(Application);
  try
   dia.allpages:=allpages;
   dia.frompage:=frompage;
   dia.topage:=topage;
   dia.copies:=copies;
   dia.report:=report;
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
    if (not report.Metafile.BlockPrinterSelection) then
     TextDriver.SelectPrinter(report.PrinterSelect);
    report.PrintRange(TextDriver,allpages,frompage,topage,copies,collate);
    SetLength(S,TextDriver.MemStream.Size);
    TextDriver.MemStream.Read(S[1],TextDriver.MemStream.Size);
    if (not report.metafile.BlockPrinterSelection) then
      PrinterSelection(report.PrinterSelect,report.papersource,report.duplex,pconfig);
    SendControlCodeToPrinter(S);
   finally
    TextDriver.free;
   end;
  end
  else
  begin
   GDIDriver:=TRpGDIDriver.Create;
   try
    GDIDriver.toprinter:=true;
    if report.PrinterFonts=rppfontsalways then
     gdidriver.devicefonts:=true
    else
     gdidriver.devicefonts:=false;
    gdidriver.neverdevicefonts:=report.PrinterFonts=rppfontsnever;
    report.PrintRange(GDIDriver,allpages,frompage,topage,copies,collate);
   finally
    gdidriver.free;
   end;
  end;
 end;
 finally
  SetPrinterConfig(pconfig);
 end;
end;
{$ENDIF}

procedure TFRpVCLProgress.BOKClick(Sender: TObject);
begin
 FromPage:=StrToInt(EFrom.Text);
 ToPage:=StrToInt(ETo.Text);
 if FromPage<1 then
  FromPage:=1;
 if ToPage<FromPage then
  ToPage:=FromPage;
 Close;
 dook:=true;
end;

procedure TFRpVCLProgress.FormShow(Sender: TObject);
begin
 if BOK.Visible then
 begin
  EFrom.Text:=IntToStr(FromPage);
  ETo.Text:=IntToStr(ToPage);
 end;
end;

procedure TRpGDIDriver.GraphicExtent(Stream:TMemoryStream;var extent:TPoint;dpi:integer);
var
 graphic:TBitmap;
{$IFNDEF DOTNETD}
 jpegimage:TJpegImage;
{$ENDIF}
 bitmapwidth,bitmapheight:integer;
 format:string;
begin
 if dpi<=0 then
  exit;
 graphic:=TBitmap.Create;
 try
  format:='';
  GetJPegInfo(Stream,bitmapwidth,bitmapheight,format);
  if (format='JPEG') then
  begin
{$IFNDEF DOTNETD}
   jpegimage:=TJpegImage.Create;
   try
    jpegimage.LoadFromStream(Stream);
    graphic.Assign(jpegimage);
   finally
    jpegimage.free;
   end;
{$ENDIF}
{$IFDEF DOTNETD}
   graphic.LoadFromStream(stream);
{$ENDIF}
  end
  else
  begin
   if (format='BMP') then
   begin
     Graphic.LoadFromStream(Stream);
   end
   else
   begin
    // All other formats
{$IFDEF EXTENDEDGRAPHICS}
       FilterImage(stream);
       jpegimage:=TJPegImage.Create;
       try
        jpegimage.LoadFromStream(stream);
        bitmap.Assign(jpegimage);
       finally
        jpegimage.free;
       end;
{$ENDIF}
   end;
  end;
  extent.X:=Round(graphic.width/dpi*TWIPS_PER_INCHESS);
  extent.Y:=Round(graphic.height/dpi*TWIPS_PER_INCHESS);
 finally
  graphic.Free;
 end;
end;

function PrinterSelection(printerindex:TRpPrinterSelect;papersource,duplex:integer;var pconfig:TPrinterConfig):TPoint;
var
 printername:String;
 index:integer;
 offset:TPoint;
 apage:TGDIPageSize;
begin
 printername:=GetPrinterConfigName(printerindex);
 offset:=GetPrinterOffset(printerindex);
 if length(printername)>0 then
 begin
  index:=Printer.Printers.IndexOf(printername);
  if index>=0 then
  begin
   if Printer.PrinterIndex<>Index then
   begin
    // Fixes problem, this reads default
    // document properties after printer selection
    pconfig:=GetPrinterConfig;
    pconfig.Changed:=true;
    rpvgraphutils.SwitchToPrinterIndex(index);
    // Printer.PrinterIndex:=index;
   end;
  end;
 end;
 if ((papersource>0) or (duplex>0)) then
 begin
  apage:=GetCurrentPaper;
  if papersource>0 then
   apage.papersource:=papersource;
  if duplex>0 then
   apage.duplex:=duplex;
  SetCurrentPaper(apage);
 end;
 Result:=offset;
end;

procedure TRpGDIDriver.SelectPrinter(printerindex:TRpPrinterSelect);
var
 pconfig:TPrinterConfig;
begin
 offset:=PrinterSelection(printerindex,0,0,pconfig);
 selectedprinter:=printerindex;
 if neverdevicefonts then
  exit;
 if devicefonts then
  exit;
 devicefonts:=GetDeviceFontsOption(printerindex);
 if devicefonts then
  UpdatePrinterFontList;
end;

procedure TRpGDIDriver.SendAfterPrintOperations;
var
 Operation:String;
 i:TPrinterRawOp;
begin
 for i:=Low(TPrinterRawOp) to High(TPrinterRawOp) do
 begin
  if PrinterRawOpEnabled(selectedprinter,i) then
  begin
   Operation:=GetPrinterRawOp(selectedprinter,i);
   if Length(Operation)>0 then
    SendControlCodeToPrinter(Operation);
  end;
 end;
end;

procedure PageSizeSelection(rpPageSize:TPageSizeQt);
var
 pagesize:TGDIPageSize;
begin
 if Printer.Printers.Count<1 then
  exit;
 pagesize:=QtPageSizeToGDIPageSize(rppagesize);
 SetCurrentPaper(pagesize);
end;


procedure OrientationSelection(neworientation:TRpOrientation);
begin
 if Printer.Printers.Count<1 then
  exit;
 SetPrinterOrientation(neworientation=rpOrientationLandscape);
// if neworientation=rpOrientationDefault then
//  exit;
// if neworientation=rpOrientationPortrait then
//  Printer.Orientation:=poPortrait
// else
//  Printer.Orientation:=poLandscape;
end;


{$IFNDEF FORWEBAX}

{$IFDEF EXTENDEDGRAPHICS}
procedure TRpGDIDriver.FilterImage(memstream:TMemoryStream);
begin
 inherited FilterImage(memstream);
 ExFilterImage(memstream);
end;
{$ENDIF}



{$IFDEF USETEECHART}
procedure TRpGDIDriver.DoDrawChart(adriver:TRpPrintDriver;Series:TRpSeries;page:TRpMetaFilePage;
  aposx,aposy:integer;xchart:TObject);
var
 nchart:TRpChart;
 achart:TChart;
 aserie:TChartSeries;
 i,j,afontsize:integer;
 rec:TRect;
 intserie:TRpSeriesItem;
 abitmap:TBitmap;
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
  achart.BevelOuter:=bvNone;
  afontsize:=Round(nchart.FontSize*nchart.Resolution/100);
  achart.View3D:=nchart.View3d;
  achart.View3DOptions.Rotation:=nchart.Rotation;
{$IFNDEF BUILDER4}
  achart.View3DOptions.Perspective:=nchart.Perspective;
{$ENDIF}
  achart.View3DOptions.Elevation:=nchart.Elevation;
  achart.View3DOptions.Orthogonal:=nchart.Orthogonal;
  achart.View3DOptions.Zoom:=nchart.Zoom;
  achart.View3DOptions.Tilt:=nchart.Tilt;
  achart.View3DOptions.HorizOffset:=nchart.HorzOffset;
  achart.View3DOptions.VertOffset:=nchart.VertOffset;
  achart.View3DWalls:=nchart.View3DWalls;
  achart.BackColor:=clTeeColor;
  achart.BackWall.Brush.Style:=bsClear;
  achart.Gradient.Visible:=false;
  achart.Color:=clWhite;
  achart.LeftAxis.LabelsFont.Name:=nchart.WFontName;
  achart.BottomAxis.LabelsFont.Name:=nchart.WFontName;
  achart.Legend.Font.Name:=nchart.WFontName;
  achart.LeftAxis.LabelsFont.Style:=CLXIntegerToFontStyle(nchart.FontStyle);
  achart.BottomAxis.LabelsFont.Style:=CLXIntegerToFontStyle(nchart.FontStyle);
  achart.Legend.Font.Size:=aFontSize;
  achart.Legend.Font.Style:=CLXIntegerToFontStyle(nchart.FontStyle);
  achart.Legend.Visible:=nchart.ShowLegend;
  acolor:=0;
  // autorange and other ranges
  achart.LeftAxis.Maximum:=Series.HighValue;
  achart.LeftAxis.Minimum:=Series.LowValue;
  achart.LeftAxis.Automatic:=false;
  achart.LeftAxis.AutomaticMaximum:=Series.AutoRangeH;
  achart.LeftAxis.AutomaticMinimum:=Series.AutoRangeL;
  achart.LeftAxis.LabelsAngle:=nchart.VertFontRotation mod 360;
  achart.LeftAxis.LabelsFont.Size:=Round(nchart.VertFontSize*nchart.Resolution/100);
  achart.BottomAxis.LabelsAngle:=nchart.HorzFontRotation mod 360;
  achart.BottomAxis.LabelsFont.Size:=Round(nchart.HorzFontSize*nchart.Resolution/100);
{$IFDEF USEVARIANTS}
  achart.LeftAxis.Logarithmic:=Series.Logaritmic;
  if achart.LeftAxis.Logarithmic then
    achart.LeftAxis.LogarithmicBase:=Round(Series.LogBase);
{$ENDIF}
  achart.LeftAxis.Inverted:=Series.Inverted;
  for i:=0 to Series.Count-1 do
  begin
   intserie:=Series.Items[i];
   aserie:=nil;
   case intserie.ChartType of
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
   if Length(intserie.Caption)>0 then
    aserie.Title:=intserie.Caption;
   aserie.Marks.Font.Name:=nchart.WFontName;
   aserie.Marks.Font.Size:=aFontSize;
   aserie.Marks.Font.Style:=CLXIntegerToFontStyle(nchart.FontStyle);
   aserie.Marks.Visible:=nchart.ShowHint;
   aserie.Marks.Style:=TSeriesMarksStyle(nchart.MarkStyle);
   aserie.ParentChart:=achart;
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
   abitmap:=TBitmap.Create;
   try
{$IFNDEF DOTNETDBUGS}
    abitmap.HandleType:=bmDIB;
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

procedure TRpGDIDriver.DrawChart(Series:TRpSeries;ametafile:TRpMetaFileReport;posx,posy:integer;achart:TObject);
begin
{$IFNDEF FORWEBAX}
{$IFDEF USETEECHART}
 DoDrawChart(Self,Series,ametafile.Pages[ametafile.CurrentPage],posx,posy,achart);
{$ENDIF}
{$IFNDEF USETEECHART}
 rppdfdriver.DoDrawChart(Self,Series,ametafile.Pages[ametafile.CurrentPage],
  posx,posy,achart);
{$ENDIF}
{$ENDIF}
end;

function AskBitmapProps(var HorzRes,VertRes:Integer;var Mono:Boolean):Boolean;
var
 diarange:TFRpVCLProgress;
begin
 Result:=false;
 diarange:=TFRpVCLProgress.Create(Application);
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

function TRpGdiDriver.GetFontDriver:TRpPrintDriver;
begin
 if Assigned(FontDriver) then
  Result:=FontDriver
 else
  Result:=Self;
end;

{$IFNDEF FORWEBAX}
{$IFDEF EXTENDEDGRAPHICS}
procedure ExFilterImage(memstream:TMemoryStream);
var
 gclass:TGraphicExGraphicClass;
 bitmap:TBitmap;
 gpicture:TGraphicExGraphic;
 jpegimage:TJPegImage;
begin
 // Use graphicex library to obtain type and convert it to jpeg
 gclass:=rpgraphicex.FileFormatList.GraphicFromContent(memstream);
 if (gclass=nil) then
  exit;
 memstream.Seek(0,soFromBeginning);
 gpicture:=gclass.Create;
 try
  try
   gpicture.LoadFromStream(memstream);
   bitmap:=TBitmap.Create;
   bitmap.PixelFormat:=pf24bit;
   bitmap.Height:=gpicture.Height;
   bitmap.Width:=gpicture.Width;
   bitmap.Canvas.Draw(0,0,gpicture);
   jpegimage:=TJPegImage.Create;
   try
    jpegimage.CompressionQuality:=100;
    jpegimage.Assign(bitmap);
    memstream.Clear;
    jpegimage.SaveToStream(memstream);
   finally
    jpegimage.Free;
   end;
  finally
   memstream.Seek(0,soFromBeginning);
  end;
 finally
  gpicture.free;
 end;
end;
{$ENDIF}
{$ENDIF}


end.


