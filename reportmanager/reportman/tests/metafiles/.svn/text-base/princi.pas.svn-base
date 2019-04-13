unit princi;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls,rpmetafile, rpgdidriver, QExtCtrls,rpqtdriver, rpruler;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Image1: TImage;
    Button5: TButton;
    RpRuler1: TRpRuler;
    RpRuler2: TRpRuler;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    meta:TRpMetafileReport;
    IDriver:IRpPrintDriver;
    IQtDriver:IRpPrintDriver;
    qtdriver:TRpQtDriver;
    driver:TRpWinGDIDriver;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation


{$R *.xfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
 // Create a metafile and populate it
 driver:=TRpWinGDIDriver.Create;
 IDriver:=driver;

 qtdriver:=TRpQTDriver.Create;
 qtdriver.toprinter:=true;
 IQTDriver:=qtdriver;

 meta:=TRpMetafileReport.Create(Self);
 meta.CustomX:=21*100;
 meta.CustomY:=29*100;
 meta.NewPage;
 meta.Pages[meta.CurrentPage].NewTextObject(0,0,1440,1440,'Hello','Arial',
  0,0,0);
 meta.Pages[meta.CurrentPage].NewTextObject(1440,1440,2440,2440,'ByeBye','Arial',
  0,0,0);
 meta.Pages[meta.CurrentPage].NewTextObject(2880,2880,2440,2440,'ByeBye','Arial',
  0,0,0);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 memstream:TMemorystream;
begin
 // Draw the metafile
 meta.DrawPage(IDriver);
 memstream:=TMemoryStream.create;
 try
  driver.DrawMetaToBitmapStream(image1.Picture.bitmap.Width,image1.Picture.bitmap.Width,memstream);
  memstream.seek(0,soFromBeginning);
  image1.Picture.Bitmap.LoadFromStream(memstream);
 finally
  memstream.free;
 end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 // Load the metafile
  if Not Assigned(meta) then
   exit;
  if OpenDialog1.Execute then
   meta.LoadFromFile(SaveDialog1.Filename);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if Not Assigned(meta) then
   exit;
  // Save the metafile
  if SaveDialog1.Execute then
   meta.SaveToFile(SaveDialog1.Filename);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 Bitmap:TBitmap;
begin
 Bitmap:=TBitmap.Create;
 Bitmap.Height:=1000;
 Bitmap.Width:=1000;
 Image1.Picture.Graphic:=Bitmap;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
 memstream:TmemoryStream;
begin
 // Draw the metafile
 meta.DrawPage(IQtDriver);
 image1.picture.bitmap.Canvas.Draw(0,0,QtDriver.bitmap);
end;

end.
