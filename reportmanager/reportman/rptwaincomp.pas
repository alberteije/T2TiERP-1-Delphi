unit rptwaincomp;

interface

uses SysUtils,Classes,Graphics,Controls,ComCtrls,ExtCtrls,Forms,
  IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP,rpmdconsts,rpGIFImage;

type
 TRpHttpUploader=class(TThread)
  private
   http1:TIdHTTP;
   procedure OnWork(Sender:TObject;AWorkMode:TWorkMode;const AWorkCount:integer);
  public
   count,total:integer;
   url:string;
   buffersize:integer;
   memstream:TMemoryStream;
   errormessage:string;
   procedure Execute;override;
   destructor Destroy;override;
 end;

 TRpTwainWeb=class(TCustomControl)
  private
   TopPanel:TPanel;
   BottomPanel:TScrollBox;
   PanelCaption:TPanel;
   AImage:TImage;
   AProgres:TProgressBar;
   FImageFormat:integer;
   FMaxKBytes:Integer;
   FFilePath:string;
   FUrlPath:string;
   FCompletedUrlPath:string;
   FAppTitle:string;
   FJPegQuality:integer;
   FTHread:TRpHttpUploader;
   Timer1:TTimer;
   memstream:TMemoryStream;
   FBufferSize:integer;
   FGifColorReduction:integer;
   FGifDither:integer;
   FCurrentSize:integer;
   procedure DoTerminate(Sender:TObject);
   procedure DoTimer(Sender:TObject);
  public
   constructor Create(AOwner:TComponent);override;
   procedure Execute;
   destructor Destroy;override;
  published
   property ImageFormat:Integer read FImageFormat write FImageFormat default 0;
   property MaxKBytes:integer read FMaxKBytes write FMaxKBytes default 0;
   property FilePath:String read FFilePath write FFilePath;
   property UrlPath:String read FUrlPath write FUrlPath;
   property CompletedUrlPath:String read FCompletedUrlPath write FCompletedUrlPath;
   property AppTitle:string read FAppTitle write FAppTitle;
   property JPegQuality:Integer read FJPEgQuality write FJPegQuality default 100;
   property GifColorReduction:Integer read FGifColorReduction write FGifColorReduction default 7;
   property GifDither:Integer read FGifDither write FGifDither default 0;
   property BufferSize:Integer read FBufferSize write FBufferSize default 8192;
 end;

(*  // Color reduction methods
  TColorReduction =
    (rmNone,			// Do not perform color reduction
     rmWindows20,		// Reduce to the Windows 20 color system palette
     rmWindows256,		// Reduce to the Windows 256 color halftone palette (Only works in 256 color display mode)
     rmWindowsGray,		// Reduce to the Windows 4 grayscale colors
     rmMonochrome,		// Reduce to a black/white monochrome palette
     rmGrayScale,		// Reduce to a uniform 256 shade grayscale palette
     rmNetscape,		// Reduce to the Netscape 216 color palette
     rmQuantize,		// Reduce to optimal 2^n color palette
     rmQuantizeWindows,		// Reduce to optimal 256 color windows palette
     rmPalette			// Reduce to custom palette
    );
  TDitherMode =
    (dmNearest,			// Nearest color matching w/o error correction
     dmFloydSteinberg,		// Floyd Steinberg Error Diffusion dithering
     dmStucki,			// Stucki Error Diffusion dithering
     dmSierra,			// Sierra Error Diffusion dithering
     dmJaJuNI,			// Jarvis, Judice & Ninke Error Diffusion dithering
     dmSteveArche,		// Stevenson & Arche Error Diffusion dithering
     dmBurkes			// Burkes Error Diffusion dithering
     // dmOrdered,		// Ordered dither
    );

*)
implementation

uses Jpeg,rpdeltwainfunc;

procedure TRpHttpUploader.Execute;
begin
 try
  total:=memstream.Size;
  count:=0;
  http1:=TIdHTTP.Create(nil);
  http1.SendBufferSize:=buffersize;
  http1.OnWork:=OnWork;
  http1.Put(url,memstream);
 except
  on E:Exception do
  begin
   if http1.ResponseCode<>201 then
    ErrorMessage:=E.message;
  end;
 end;
end;

procedure TRpTwainWeb.DoTerminate(Sender:TObject);
var
 http1:TIdHttp;
 Fmem:TMemoryStream;
begin
 if FThread.ErrorMessage='' then
 begin
  if Length(FCompletedUrlPath)>0 then
  begin
   try
    http1:=TIdHTTP.Create(nil);
    try
     Fmem:=TMemoryStream.Create;
     try
      http1.Get(FCompletedUrlPath,Fmem);
     finally
      FMem.free;
     end;
    finally
     http1.Free;
    end;
    PanelCaption.Caption:=SRpCompletedUpload+' '+FormatFloat('##0',FCurrentSize div 1024)+' Kbytes';
    AProgres.Position:=AProgres.Max;
   except
    on E:Exception do
    begin
     PanelCaption.Caption:=E.Message;
    end;
   end;
  end
 end
 else
  PanelCaption.Caption:=FThread.ErrorMessage;
 FThread:=nil;
 Timer1.Enabled:=false;
end;

procedure TRpHttpUploader.OnWork(Sender:TObject;AWorkMode:TWorkMode;const AWorkCount:integer);
begin
 count:=AWorkCount;
end;


destructor TRpHttpUploader.Destroy;
begin
 http1.Free;
 inherited;
end;

destructor TRpTwainWeb.Destroy;
begin
// if Assigned(AImage.Picture.Graphic) then
// begin
//  AImage.Picture.Graphic.free;
//  AImage.Picture.Graphic:=nil;
// end;
 if Assigned(FThread) then
  FThread.Terminate;
 if Assigned(memstream) then
  memstream.free;
 inherited Destroy;
end;

procedure TRpTwainWeb.Execute;
var
 ajpeg:TJpegImage;
 agif:TGifImage;
 abitmap:TBitmap;
begin
 AImage.Picture.Graphic:=nil;
 AProgres.Position:=0;
 PanelCaption.Caption:='';
 try
 memstream:=TMemoryStream.Create;
 try
  case FImageFormat of
   0:
    begin
     abitmap:=GetBitmapFromTwainMax(apptitle,MaxKbytes);
     try
      if Assigned(abitmap) then
      begin
       abitmap.SaveToStream(memstream);
       AProgres.Position:=0;
       AImage.Picture.Graphic:=abitmap;
      end;
     except
      abitmap.free;
      raise;
     end;
    end;
   1:
    begin
     ajpeg:=GetJpegImageFromTwainMax(apptitle,jpegquality,MaxKBytes);
     try
      if assigned(ajpeg) then
      begin
       ajpeg.CompressionQuality:=JPegQuality;
       ajpeg.SaveToStream(memstream);
       AImage.Picture.Graphic:=ajpeg;
      end;
     except
      ajpeg.free;
      raise;
     end;
    end;
   2:
    begin
     agif:=GetGifImageFromTwainMax(apptitle,GifColorReduction,GifDither,MaxKBytes);
     try
      if assigned(agif) then
      begin
       agif.SaveToStream(memstream);
       AImage.Picture.Graphic:=agif;
      end;
     except
      agif.free;
      raise;
     end;
    end;
  end;
  memstream.Seek(0,soFromBeginning);
  FCurrentSize:=memstream.Size;
  if FCurrentSize<1 then
   Raise Exception.Create(SRpOperationAborted);
  if Length(FUrlPath)>0 then
  begin
   FTHread:=TRpHttpUploader.Create(true);
   FTHread.memstream:=memstream;
   FTHread.Url:=FUrlPath;
   FThread.buffersize:=FBufferSize;
   FThread.OnTerminate:=DoTerminate;
   FThread.FreeOnTerminate:=true;
   FThread.Resume;
  end;
 finally
  if not Assigned(fthread) then
  begin
   memstream.free;
   memstream:=nil;
  end;
 end;
 except
  on E:Exception do
  begin
   PanelCaption.Caption:=E.Message;
  end;
 end;
end;

constructor TRpTwainWeb.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 GifColorReduction:=7;
 FBufferSize:=8192;
 Timer1:=TTimer.Create(Self);
 Timer1.Interval:=100;
 Timer1.OnTimer:=DoTimer;
 FJPegQuality:=100;
 TopPanel:=TPanel.Create(Self);
 TopPanel.Parent:=Self;
 TopPanel.Align:=alTop;
 TopPanel.Font.Style:=[fsBold];
 TopPanel.BorderStyle:=bsNone;
 TopPanel.BevelInner:=bvNone;
 TopPanel.BevelOuter:=bvNone;
 TopPanel.Height:=60;
 BottomPanel:=TScrollBox.Create(Self);
 BottomPanel.Parent:=Self;
 BottomPanel.Align:=alClient;
 BottomPanel.BorderStyle:=bsNone;
 BottomPanel.HorzScrollBar.Tracking:=True;
 BottomPanel.VertScrollBar.Tracking:=True;
 PanelCaption:=TPanel.Create(Self);
 PanelCaption.Parent:=TopPanel;
 PanelCaption.Align:=alTop;
 PanelCaption.BorderStyle:=bsNone;
 PanelCaption.Alignment:=taLeftJustify;
// PanelCaption.BevelInner:=bvNone;
// PanelCaption.BevelOuter:=bvNone;
 PanelCaption.Height:=30;
 AProgres:=TProgressBar.Create(Self);
 AProgres.Parent:=TopPanel;
 AProgres.Align:=alClient;

 AImage:=TImage.Create(Self);
 AImage.Stretch:=false;
 AImage.Parent:=BottomPanel;
 AImage.AutoSize:=true;
 AImage.Top:=0;
 AImage.Left:=0;

end;

procedure TRpTwainWeb.DoTimer(Sender:TObject);
begin
 if Assigned(FThread) then
 begin
  AProgres.Max:=FTHread.Total;
  AProgres.Position:=FTHread.Count;
  PanelCaption.Caption:=Format(SRpUploadProg,[FTHread.Count div 1024,FTHread.Total div 1024]);
 end;
end;


end.
