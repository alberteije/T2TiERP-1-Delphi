unit rpdeltwainfunc;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,rpdeltwain,rptwain,rpmdconsts,jpeg,rpGIFImage,rpgraphutilsvcl;

const MAX_IMAGE_SIZE_KBYTES=1024*100;

type
  TFTwainHelp = class(TForm)
    BCancel: TButton;
    LWait: TLabel;
    procedure BCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    apptitle:String;
    oldidle:TIdleEvent;
    bitmap:TBitmap;
    atwain:TDelphiTwain;
    procedure OnTwainAcquire(Sender: TObject; const Index: Integer; Image: TBitmap; var Cancel: Boolean);
    procedure OnTwainCancel(Sender: TObject;const index:integer);
    procedure AppIdle(Sender:TObject;var done:BOolean);
  public
    { Public declarations }
  end;

function GetBitmapFromTwain(apptitle:String):TBitmap;
function GetBitmapFromTwainMax(apptitle:String;kbytesmax:integer):TBitmap;
function GetJpegImageFromTwainMax(apptitle:String;quality:integer;kbytesmax:integer):TJPegImage;
function GetGifImageFromTwainMax(apptitle:String;colorreduction,dither:integer;kbytesmax:integer):TGifImage;

implementation

{$R *.dfm}

procedure TFTwainHelp.AppIdle(Sender:TObject;var done:BOolean);
var
  SourceIndex: Integer;
  Source: TTwainSource;
  apptit:TW_STR32;
begin
 Application.OnIdle:=oldidle;
 done:=false;
 try
  //Make sure that the library and Source Manager
  //are loaded
  StrPCopy(Pchar(@apptit[0]),Copy(apptitle,1,31));
  atwain.AppIdentity.ProductName:=apptit;
  aTwain.LibraryLoaded := TRUE;
  aTwain.SourceManagerLoaded := TRUE;
  //SelectSource method displays a common Twain dialog
  //to allow the user to select one of the avaliable
  //sources and returns it's index or -1 if either
  //the user pressed Cancel or if there were no sources
  if atwain.SourceCount<2 then
  begin
   SourceIndex:=0;
   if atwain.SourceCount<1 then
    Raise Exception.Create(SRpNoTwain);
  end
  else
   SourceIndex := aTwain.SelectSource();
  if (SourceIndex <> -1) then
  begin
     //Now that we know the index of the source, we'll
     //get the object for this source
     Source := aTwain.Source[SourceIndex];
     //Load source and acquire image
     Source.Loaded := TRUE;
     Source.Enabled := TRUE;
  end
  else
   Close; {if (SourceIndex <> -1)}
 except
  On E:Exception do
  begin
   RpMessageBox(E.Message);
   Close;
  end;
 end;
end;

function GetBitmapFromTwainMax(apptitle:String;kbytesmax:integer):TBitmap;
var
 memstream:TMemoryStream;
 asize:integer;
begin
 if kbytesmax=0 then
  kbytesmax:=MAX_IMAGE_SIZE_KBYTES;
 Result:=GetBitmapFromTwain(apptitle);
 if Assigned(Result) then
 begin
  memstream:=TMemoryStream.Create;
  try
   Result.SaveToStream(memstream);
   asize:=memstream.size div 1024;
   if asize>kbytesmax then
   begin
    Raise Exception.Create(SRpWaitTwainExceededMax+FormatFloat('##,##',asize)+
     ','+FormatFloat('##,##',kbytesmax));
   end;
  finally
   memstream.free;
  end;
 end;
end;

function GetJpegImageFromTwainMax(apptitle:String;quality:integer;kbytesmax:integer):TJPegImage;
var
 memstream:TMemoryStream;
 asize:integer;
 ajpeg:TJPEGImage;
 abitmap:TBitmap;
begin
 if kbytesmax=0 then
  kbytesmax:=MAX_IMAGE_SIZE_KBYTES;
 ajpeg:=nil;
 abitmap:=GetBitmapFromTwain(apptitle);
 if Assigned(abitmap) then
 begin
  try
   ajpeg:=TJPEGImage.Create;
   try
    memstream:=TMemoryStream.Create;
    try
     ajpeg.CompressionQuality:=quality;
     ajpeg.Assign(abitmap);
     ajpeg.SaveToStream(memstream);
     asize:=memstream.size div 1024;
     if asize>kbytesmax then
     begin
      Raise Exception.Create(SRpWaitTwainExceededMax+FormatFloat('##,##',asize)+
       ','+FormatFloat('##,##',kbytesmax));
     end;
    finally
     memstream.free;
    end;
   except
    ajpeg.free;
    ajpeg:=nil;
    raise;
   end;
  finally
   abitmap.free;
  end;
 end;
 Result:=ajpeg;
end;

function GetGifImageFromTwainMax(apptitle:String;colorreduction,dither:integer;kbytesmax:integer):TGifImage;
var
 memstream:TMemoryStream;
 asize:integer;
 agif:TGifImage;
 abitmap:TBitmap;
begin
 if kbytesmax=0 then
  kbytesmax:=MAX_IMAGE_SIZE_KBYTES;
 agif:=nil;
 abitmap:=GetBitmapFromTwain(apptitle);
 if Assigned(abitmap) then
 begin
  try
   agif:=TGifImage.Create;
   try
    memstream:=TMemoryStream.Create;
    try
     agif.ColorReduction:=TColorReduction(colorreduction);
     agif.DitherMode:=TDitherMode(dither);
     agif.Assign(abitmap);
     agif.SaveToStream(memstream);
     asize:=memstream.size div 1024;
     if asize>kbytesmax then
     begin
      Raise Exception.Create(SRpWaitTwainExceededMax+FormatFloat('##,##',asize)+
       ','+FormatFloat('##,##',kbytesmax));
     end;
    finally
     memstream.free;
    end;
   except
    agif.free;
    agif:=nil;
    raise;
   end;
  finally
   abitmap.free;
  end;
 end;
 Result:=agif;
end;



function GetBitmapFromTwain(apptitle:String):TBitmap;
var
 dia: TFTwainHelp;
begin
 dia:=TFTwainHelp.Create(Application);
 try
  dia.oldidle:=Application.OnIdle;
  dia.apptitle:=apptitle;
  Application.OnIdle:=dia.AppIdle;
  dia.ShowModal;
  Result:=dia.bitmap;
 finally
  dia.free;
 end;
end;

procedure TFTwainHelp.BCancelClick(Sender: TObject);
begin
 bitmap.free;
 bitmap:=nil;
 Close;
end;

procedure TFTwainHelp.FormCreate(Sender: TObject);
begin
 BCancel.Caption:=SRpCancel;
 LWait.Caption:=SRpWaitTwain;
 atwain:=TDelphiTwain.Create(Self);
 atwain.OnAcquireCancel:=OnTwainCancel;
 atwain.OnTwainAcquire:=OnTwainAcquire;
end;

procedure TFTwainHelp.OnTwainCancel(Sender: TObject;const index:integer);
begin
 bitmap.free;
 bitmap:=nil;
 Close;
end;

procedure TFTwainHelp.OnTwainAcquire(Sender: TObject; const Index: Integer; Image: TBitmap; var Cancel: Boolean);
begin
  //Copies the acquired bitmap to the TImage control
  bitmap:=TBitmap.Create;
  bitmap.Assign(Image);
  //Because the component supports multiple images
  //from the source device, Cancel will tell the
  //source that we don't want no more images
  Cancel := TRUE;
  Close;
end;

end.
