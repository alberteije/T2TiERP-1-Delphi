unit rpnetdriver;

interface

uses
  System.Drawing, System.Collections, System.ComponentModel,
  System.Windows.Forms, System.Data,rpbasereport,rpreport,
  rpmetafile,rptypes,Classes,Types,rptextdriver,rpmdconsts,
  System.Drawing.Printing,SysUtils;

type
  TRpNetDriver=Class;
  FRpNetProgress = class(System.Windows.Forms.Form)
  {$REGION 'Designer Managed Code'}
  strict private
    /// <summary>
    /// Required designer variable.
    /// </summary>
    Components: System.ComponentModel.Container;
    BCancel: System.Windows.Forms.Button;
    LTitle1: System.Windows.Forms.Label;
    LProcessing1: System.Windows.Forms.Label;
    LRecordCount: System.Windows.Forms.Label;
    LTitle: System.Windows.Forms.Label;
    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    procedure InitializeComponent;
    procedure BCancel_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  private
    oldonidle:EventHandler;
    cancelled:Boolean;
    procedure AppIdleReport(Sender:TObject;e:EventArgs);
    procedure RepProgress(Sender:TRpBaseReport;var docancel:boolean);
  strict protected
    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    procedure Dispose(Disposing: Boolean); override;
  public
    report:TRpReport;
    NetDriver:TRpNetDriver;
    aNetDriver:IRpPrintDriver;
    constructor Create;
  end;

 TNetPageSize=record
  // -1 default, 0 user defined, 1 A4...
  PageIndex:integer;
  // Custom size in user defined type
  // 1000 units = 1 Inch
  Width:integer;
  Height:integer;
  papername:string;
 end;

 TRpNetDriver=class(TInterfacedObject,IRpPrintDriver)
  private
   intdpix,intdpiy:integer;
//   metacanvas:TMetafilecanvas;
//   meta:TMetafile;
   pagecliprec:TRect;
   selectedprinter:TRpPrinterSelect;
   DrawerBefore,DrawerAfter:Boolean;
   adocument:System.Drawing.Printing.PrintDocument;
   procedure SendAfterPrintOperations;
  public
   offset:TPoint;
   lockedpagesize:boolean;
   CurrentPageSize:Tpoint;
   bitmap:Bitmap;
   dpi:integer;
   toprinter:boolean;
   scale:double;
   pagemargins:TRect;
   drawclippingregion:boolean;
   oldpagesize,pagesize:TNetPageSize;
   oldorientation:integer;
   orientationset:boolean;
   devicefonts:boolean;
   neverdevicefonts:boolean;
   bitmapwidth,bitmapheight:integer;
   PreviewStyle:TRpPreviewStyle;
   clientwidth,clientheight:integer;
   procedure NewDocument(report:TrpMetafileReport;hardwarecopies:integer;
    hardwarecollate:boolean);
   procedure EndDocument;
   procedure AbortDocument;
   procedure NewPage;
   procedure EndPage;
   procedure DrawObject(page:TRpMetaFilePage;obj:TRpMetaObject);
   procedure DrawPage(apage:TRpMetaFilePage);
   function AllowCopies:boolean;
   function GetPageSize(var PageSizeQt:Integer):TPoint;
   function SetPagesize(PagesizeQt:TPageSizeQt):TPoint;
   procedure TextExtent(atext:TRpTextObject;var extent:TPoint);
   procedure GraphicExtent(Stream:TMemoryStream;var extent:TPoint;dpi:integer);
   procedure SetOrientation(Orientation:TRpOrientation);
   procedure SelectPrinter(printerindex:TRpPrinterSelect);
   function SupportsCopies(maxcopies:integer):boolean;
   function SupportsCollation:boolean;
   constructor Create;
   destructor Destroy;override;
  end;

function CalcReportWidthProgress (report:TRpReport):boolean;
procedure SendControlCodeToPrinter(astring:String);
function GetPageMarginsTWIPS(adocument:System.Drawing.Printing.PrintDocument):TRect;


implementation

{$R 'rpnetdriver.FRpNetProgress.resources'}

{$REGION 'Windows Form Designer generated code'}
/// <summary>
/// Required method for Designer support - do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure FRpNetProgress.InitializeComponent;
begin
  Self.BCancel := System.Windows.Forms.Button.Create;
  Self.LTitle1 := System.Windows.Forms.Label.Create;
  Self.LProcessing1 := System.Windows.Forms.Label.Create;
  Self.LRecordCount := System.Windows.Forms.Label.Create;
  Self.LTitle := System.Windows.Forms.Label.Create;
  Self.SuspendLayout;
  // 
  // BCancel
  // 
  Self.BCancel.Location := System.Drawing.Point.Create(152, 88);
  Self.BCancel.Name := 'BCancel';
  Self.BCancel.Size := System.Drawing.Size.Create(112, 32);
  Self.BCancel.TabIndex := 0;
  Self.BCancel.Text := 'Cancel';
  Include(Self.BCancel.Click, Self.BCancel_Click);
  // 
  // LTitle1
  // 
  Self.LTitle1.Location := System.Drawing.Point.Create(8, 8);
  Self.LTitle1.Name := 'LTitle1';
  Self.LTitle1.Size := System.Drawing.Size.Create(80, 16);
  Self.LTitle1.TabIndex := 1;
  Self.LTitle1.Text := 'Title';
  // 
  // LProcessing1
  // 
  Self.LProcessing1.Location := System.Drawing.Point.Create(8, 32);
  Self.LProcessing1.Name := 'LProcessing1';
  Self.LProcessing1.Size := System.Drawing.Size.Create(80, 16);
  Self.LProcessing1.TabIndex := 2;
  Self.LProcessing1.Text := 'Processing';
  // 
  // LRecordCount
  // 
  Self.LRecordCount.Location := System.Drawing.Point.Create(88, 32);
  Self.LRecordCount.Name := 'LRecordCount';
  Self.LRecordCount.Size := System.Drawing.Size.Create(368, 16);
  Self.LRecordCount.TabIndex := 4;
  // 
  // LTitle
  // 
  Self.LTitle.Location := System.Drawing.Point.Create(88, 8);
  Self.LTitle.Name := 'LTitle';
  Self.LTitle.Size := System.Drawing.Size.Create(368, 16);
  Self.LTitle.TabIndex := 3;
  // 
  // FRpNetProgress
  // 
  Self.AutoScaleBaseSize := System.Drawing.Size.Create(5, 13);
  Self.ClientSize := System.Drawing.Size.Create(456, 134);
  Self.Controls.Add(Self.LRecordCount);
  Self.Controls.Add(Self.LTitle);
  Self.Controls.Add(Self.LProcessing1);
  Self.Controls.Add(Self.LTitle1);
  Self.Controls.Add(Self.BCancel);
  Self.Name := 'FRpNetProgress';
  Self.Text := 'Report Progress';
  Self.ResumeLayout(False);
end;
{$ENDREGION}

procedure FRpNetProgress.Dispose(Disposing: Boolean);
begin
  if Disposing then
  begin
    if Components <> nil then
      Components.Dispose();
  end;
  inherited Dispose(Disposing);
end;

constructor FRpNetProgress.Create;
begin
  inherited Create;
  //
  // Required for Windows Form Designer support
  //
  InitializeComponent;
  //
  // TODO: Add any constructor code after InitializeComponent call
  //
end;

procedure FRpNetProgress.BCancel_Click(sender: System.Object; e: System.EventArgs);
begin
  cancelled:=true;
end;


function CalcReportWidthProgress(report:TRpReport):boolean;
var
 dia:FRpNetProgress;
begin
 dia:=FRpNetProgress.Create;
 try
  Include(System.Windows.Forms.Application.Idle,dia.AppIdleReport);
  try
   dia.report:=report;
   dia.ShowDialog;
   Result:=Not dia.cancelled;
  finally
   Exclude(System.Windows.Forms.Application.Idle,dia.AppIdleReport);
  end;
 finally
  dia.free;
 end;
end;

procedure FRpNetProgress.AppIdleReport(Sender:TObject;e:EventArgs);
var
 oldprogres:TRpProgressEvent;
 istextonly:Boolean;
 drivername:String;
 TextDriver:TRpTextDriver;
 aTextDriver:IRpPrintDriver;
 printerindex:integer;
begin
 Exclude(System.Windows.Forms.Application.Idle,AppIdleReport);

 drivername:=GetPrinterEscapeStyleDriver(report.PrinterSelect).Trim;
 istextonly:=Length(drivername)>0;
 try
  if istextonly then
  begin
   TextDriver:=TRpTextDriver.Create;
   aTextDriver:=TextDriver;
   TextDriver.SelectPrinter(report.PrinterSelect);
   oldprogres:=RepProgress;
   try
    report.OnProgress:=RepProgress;
    report.PrintAll(TextDriver);
   finally
    report.OnProgress:=oldprogres;
   end;
  end
  else
  begin
   NetDriver:=TRpNetDriver.Create;
   aNetDriver:=NetDriver;
   if report.PrinterFonts=rppfontsalways then
    netdriver.devicefonts:=true
   else
    netdriver.devicefonts:=false;
   netdriver.neverdevicefonts:=report.PrinterFonts=rppfontsnever;

   oldprogres:=RepProgress;
   try
    report.OnProgress:=RepProgress;
    report.PrintAll(NetDriver);
   finally
    report.OnProgress:=oldprogres;
   end;
  end;
  Close;
 except
  cancelled:=True;
  Close;
  Raise;
 end;
end;

procedure FRpNetProgress.RepProgress(Sender:TRpBaseReport;var docancel:boolean);
begin
 if Not Assigned(LRecordCount) then
  exit;
 LRecordCount.Text:=Sender.CurrentSubReportIndex.ToString+':'+SRpPage+':'+
 FormatFloat('#########,####',Sender.PageNum+1)+'-'+FormatFloat('#########,####',Sender.RecordCount+1);
 System.Windows.Forms.Application.DoEvents;
 if cancelled then
  docancel:=true;
end;


procedure TRpNetDriver.SendAfterPrintOperations;
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


procedure SendControlCodeToPrinter(astring:String);
var
 adocument:System.Drawing.Printing.PrintDocument;
begin
{ adocument:=System.Drawing.Printing.PrintDocument.Create;
 try
  adocument.DocumentName:='Control';
  adocument.Print;
 finally
  adocument.Free;
 end;
}end;


constructor TRpNetDriver.Create;
begin
 inherited Create;

 adocument:=System.Drawing.Printing.PrintDocument.Create;
end;

destructor TRpNetDriver.Destroy;
begin
 adocument.free;

 inherited Destroy;
end;

function GetPageMarginsTWIPS(adocument:System.Drawing.Printing.PrintDocument):TRect;
begin
// adocument.PrinterSettings.DefaultPageSettings.Margins;
 Result.Left:=0;
 Result.Top:=0;
 Result.Right:=0;
 REsult.Bottom:=0;
end;


procedure TRpNetDriver.NewDocument(report:TrpMetafileReport;hardwarecopies:integer;
  hardwarecollate:boolean);
var
 asize:TPoint;
 qtsize:integer;
begin
 DrawerBefore:=report.OpenDrawerBefore;
 DrawerAfter:=report.OpenDrawerAfter;
 if devicefonts then
 begin
//  UpdatePrinterFontList;
 end;
 if ToPrinter then
 begin
  adocument.DocumentName:=SRpUntitled;

  SetOrientation(report.Orientation);
  // Gets pagesize
  asize:=GetPageSize(qtsize);
  pagemargins:=GetPageMarginsTWIPS(adocument);
  if Length(adocument.DocumentName)<1 then
   adocument.DocumentName:='Untitled';

  adocument.PrinterSettings.Copies:=hardwarecopies;
  adocument.PrinterSettings.Collate:=hardwarecollate;

  if DrawerBefore then
   SendControlCodeToPrinter(GetPrinterRawOp(selectedprinter,rawopopendrawer));

  intdpix:=GetDeviceCaps(Printer.Canvas.handle,LOGPIXELSX); //  printer.XDPI;
  intdpiy:=GetDeviceCaps(Printer.Canvas.handle,LOGPIXELSY);  // printer.YDPI;
 end
 else
 begin
  // Offset is 0 in preview
  offset.X:=0;
  offset.Y:=0;
  if assigned(bitmap) then
  begin
   bitmap.free;
   bitmap:=nil;
  end;
  bitmap:=TBitmap.Create;
  bitmap.PixelFormat:=pf32bit;
  // Sets Orientation
  SetOrientation(report.Orientation);
  // Gets pagesize
  if lockedpagesize then
  begin
   asize:=CurrentPageSize;
  end
  else
  begin
   asize:=GetPageSize(qtsize);
   pagemargins:=GetPageMarginsTWIPS;
   CurrentPageSize:=asize;
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

  bitmap.Width:=Round(awidth*scale);
  bitmap.Height:=Round(aheight*scale);
  if bitmap.Width<1 then
   bitmap.Width:=1;
  if bitmap.Height<1 then
   bitmap.Height:=1;

  Bitmap.Canvas.Brush.Style:=bsSolid;
  Bitmap.Canvas.Brush.Color:=CLXColorToVCLColor(report.BackColor);
  rec.Top:=0;
  rec.Left:=0;
  rec.Right:=Bitmap.Width-1;
  rec.Bottom:=Bitmap.Height-1;
  bitmap.Canvas.FillRect(rec);
  // Define clipping region
  rec.Left:=Round((pagemargins.Left/TWIPS_PER_INCHESS)*dpi*scale);
  rec.Top:=Round((pagemargins.Top/TWIPS_PER_INCHESS)*dpi*scale);
  rec.Right:=Round((pagemargins.Right/TWIPS_PER_INCHESS)*dpi*scale);
  rec.Bottom:=Round((pagemargins.Bottom/TWIPS_PER_INCHESS)*dpi*scale);
  pagecliprec:=rec;
  if (Not drawclippingregion) then
  begin
   aregion:=CreateRectRgn(rec.Left,rec.Top,rec.Right,rec.Bottom);
   SelectClipRgn(bitmap.Canvas.handle,aregion);
  end;
 end;
end;



end.
