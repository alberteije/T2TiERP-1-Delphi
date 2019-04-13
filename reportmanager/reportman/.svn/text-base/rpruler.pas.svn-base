{*******************************************************}
{                                                       }
{       RpRuler component                               }
{       A Display ruler that can be horizontal or       }
{       vertical, in cms or inchess                     }
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

unit rpruler;

interface

{$I rpconf.inc}

uses
  Types,Classes,SysUtils,
  QGraphics, QControls,
  Qt,QForms,rpmunits,
 rpmdconsts;


const
 CMAXHEIGHT=5800;
type

  TRprulertype = (rHorizontal,rVertical);
  TRprulermetric=(rCms,rInchess);

  TRpRuler = class(TCustomControl)
   private
    Updated:Boolean;
    FRType:TRprulertype;
    FBorderStyle:TBorderStyle;
    Fmetrics:TRprulermetric;
    FScale:double;
    procedure SetRType(value:TRprulertype);
    procedure SetMetrics(Value:TRprulermetric);
    procedure SetScale(nvalue:double);
   protected
    { Protected declarations }
    procedure Paint;override;
   public
    { Public declarations }
    procedure SetBounds(ALeft,Atop,AWidth,AHeight:integer);override;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
   property BorderStyle:TBorderStyle read FBorderStyle write FBorderStyle default bssingle;
   property RType:TRprulertype read FRType Write SetRType default rVertical;
   property Align;
   property Scale:double read FScale write SetScale;
   property Metrics:TRprulermetric read FMetrics write SetMetrics default rCms;
   property Visible;
  end;



function PaintRuler (metrics:TRprulermetric; pixel_scale:double; RType:TRpRulerType; Color:TColor; Width,Height:integer):TBitmap;

implementation



var
 bitmapHcm:TBitmap;
 bitscaleHcm:double;
 bitmapVcm:TBitmap;
 bitscaleVcm:double;
 bitmapHin:TBitmap;
 bitscaleHin:double;
 bitmapVin:TBitmap;
 bitscaleVin:double;




constructor TRpRuler.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FScale:=1.0;
 FBorderStyle:=bssingle;
 FRType:=rVertical;
 Color:=clWhite;
 // The canvas
 Canvas.Pen.Style:=psSolid;
 Canvas.Pen.Color:=clWindowtext;
 FMetrics:=rCms;

 Width:=20;
 Updated:=False;
end;

procedure TRpRuler.SetScale(nvalue:double);
begin
 if FScale=nvalue then
  exit;
 FScale:=nvalue;
 Invalidate;
end;


destructor TRpRuler.Destroy;
begin
 inherited Destroy;
end;

procedure TRpRuler.SetRType(value:TRprulertype);
begin
 if ((value<>FRType) And (Updated)) then
  Exit;
 Updated:=False;
 FRType:=value;
end;

procedure TRpRuler.SetBounds(ALeft,Atop,AWidth,AHeight:integer);
begin
 inherited SetBounds(ALeft,ATop,AWidth,AHeight);

end;


procedure TRpRuler.SetMetrics(Value:TRprulermetric);
begin
 if value=Fmetrics then
  exit;
 FMetrics:=Value;
 Invalidate;
end;

procedure TRpRuler.Paint;
var
 bit:TBitmap;
begin
 bit:=PaintRuler(metrics,fscale,RType,Color,Width,Height);
 Canvas.Draw(0,0,bit);
 if BorderStyle=bsSingle then
 begin
  Canvas.Brush.Style:=bsClear;
  Canvas.Pen.Color:=clblack;
  Canvas.Rectangle(0,0,Width,height);
 end;
end;

function PaintRuler(metrics:TRprulermetric;pixel_scale:double;RType:TRpRulerType;Color:TColor;Width,Height:integer):TBitmap;
var rect,rectrefresh:TRect;
    scale:double;
    value,Clength,CHeight:integer;
    bitmap:TBitmap;
    pixelsperinchx,pixelsperinchy:Integer;
    windowwidth:integer;
    windowheight:integer;
    h1,h2,h3,x:integer;
    i,onethousand,onecent:double;
  han:QPainterH;
    bwidth,bheight:integer;
    posx,posy:integer;
begin
 if pixel_scale=0 then
  pixel_scale:=1.0;
 Bitmap:=nil;
 bwidth:=2500;
 bheight:=2500;
 if Metrics=rCms then
 begin
  if RType=rHorizontal then
  begin
   if assigned(BitmapHcm) then
   begin
    if ((width>BitmapHcm.Width)  or (bitscaleHcm<>pixel_scale)) then
    begin
     bwidth:=width;
     bitscaleHcm:=pixel_scale;
     BitmapHcm.free;
     BitmapHcm:=nil;
    end
    else
     Bitmap:=BitmapHcm;
   end;
  end
  else
  begin
   if assigned(BitmapVcm) then
   begin
    if ((height>BitmapVcm.Height) or (bitscaleVcm<>pixel_scale)) then
    begin
     bheight:=height;
     bitscaleVcm:=pixel_scale;
     BitmapVcm.free;
     BitmapVcm:=nil;
    end
    else
     Bitmap:=BitmapVcm;
   end;
  end;
 end
 else
 begin
  if RType=rHorizontal then
  begin
   if assigned(BitmapHin) then
   begin
    if ((width>BitmapHin.Width) or (bitscaleHin<>pixel_scale)) then
    begin
     bwidth:=width;
     bitscaleHin:=pixel_scale;
     BitmapHin.free;
     BitmapHin:=nil;
    end
    else
     Bitmap:=BitmapHin;
   end;
  end
  else
  begin
   if assigned(BitmapVin) then
   begin
    if ((height>BitmapVin.Height) or (bitscaleVin<>pixel_scale)) then
    begin
     bheight:=height;
     bitscaleVin:=pixel_scale;
     BitmapVin.free;
     BitmapVin:=nil;
    end
    else
     Bitmap:=BitmapVin;
   end;
  end;
 end;
 if Assigned(Bitmap) then
 begin
  REsult:=Bitmap;
  exit;
 end;
 Bitmap:=TBitmap.create;
 if Metrics=rCms then
 begin
  if RType=rHorizontal then
  begin
   BitmapHcm:=Bitmap;
  end
  else
  begin
   BitmapVcm:=Bitmap;
  end;
 end
 else
 begin
  if RType=rHorizontal then
  begin
   BitmapHin:=Bitmap;
  end
  else
  begin
   BitmapVin:=Bitmap;
  end;
 end;
 Bitmap.PixelFormat:=pf32bit;
 if RType=RHorizontal then
 begin
  Bitmap.Width:=bwidth;
  Bitmap.Height:=20;
 end
 else
 begin
  Bitmap.Width:=20;
  Bitmap.Height:=bheight;
 end;
 With bitmap do
 begin
 Canvas.Brush.Color:=Color;
 Canvas.Brush.Style:=bsSolid;
 Canvas.Pen.Style:=psSolid;
 Canvas.Pen.Color:=clBlack;
 Rect.Left:=0;
 Rect.Top:=0;
 Rect.Right:=Bitmap.Width;
 Rect.Bottom:=Bitmap.Height;
 rectrefresh:=rect;

 pixelsperinchx:=Round(Screen.PixelsPerInch*pixel_scale);
 pixelsperinchy:=Round(Screen.PixelsPerInch*pixel_scale);

 Canvas.Rectangle(rect.Left,rect.Top,rect.Right,rect.Bottom);


 if Metrics=rCms then
 begin
  onecent:=100/CMS_PER_INCHESS;
  onethousand:=100/CMS_PER_INCHESS*10;
  scale:=pixelsperinchx/CMS_PER_INCHESS;
 end
 else
 begin
  onethousand:=1000;
  onecent:=100;
  scale:=pixelsperinchx;
 end;
 windowwidth:=Round(1000*rect.right/pixelsperinchx);
 windowheight:=Round(1000*rect.bottom/pixelsperinchy);
 if pixel_scale>=1 then
 begin
  h1:=Round(120/pixel_scale*1.5);
  h2:=Round(60/pixel_scale*1.5);
  h3:=Round(30/pixel_scale*1.5);
 end
 else
 begin
  h1:=240;
  h2:=120;
  h3:=60;
 end;
 han:=Canvas.Handle;
 // Painting of the ruler
 Canvas.start;
 // Get the pixels per inch
 try
  // 1000 points per inches
  QPainter_SetViewport(han,rect.left,rect.top,
   rect.Right,rect.Bottom);
  QPainter_SetWindow(han,rect.left,rect.top,windowwidth
   ,windowheight);
  if RType=rHorizontal then
  begin
   i:=0;
   Clength:=windowwidth;
   CHeight:=windowheight;
   x:=0;
   while (i<Clength) do
   begin
    value:=x mod 10;
    posx:=Round((i/onethousand)*scale);
    if value=0 then
    // One number
    begin
     QPainter_setWindow(han,rect.left,rect.top,rect.right,rect.bottom);
     Canvas.TextOut(posx,0,IntToStr(Round(i/onethousand)));
     QPainter_SetWindow(han,rect.left,rect.top,windowwidth
      ,windowheight);
//     Canvas.TextOut(i,CHeight,IntToStr(i div onethousand));
     Canvas.MoveTo(Round(i),CHeight);
     Canvas.LineTo(Round(i),CHeight-h1);
    end
    else
    if value=5 then
    begin
     Canvas.MoveTo(Round(i),CHeight);
     Canvas.LineTo(Round(i),CHeight-h2);
    end
    else
    begin
     Canvas.MoveTo(Round(i),CHeight);
     Canvas.LineTo(Round(i),CHeight-h3);
    end;
    i:=i+onecent;
    inc(x);
   end;
  end
  else
  begin
   i:=0;
   Clength:=windowheight;
   CHeight:=windowwidth;
   x:=0;
   while (i<Clength) do
   begin
    posy:=Round((i/onethousand)*scale);
    value:=x mod 10;
//    value:=Round(i/onethousand) mod 10;
//      value:=Round(i) Mod Round(onethousand);
    if value=0 then
    // One number
    begin
     QPainter_setWindow(han,rect.left,rect.top,rect.right,rect.bottom);
     Canvas.TextOut(0,posy,IntToStr(Round(i/onethousand)));
     QPainter_SetWindow(han,rect.left,rect.top,windowwidth
      ,windowheight);
     Canvas.MoveTo(CHeight,Round(i));
     Canvas.LineTo(CHeight-h1,Round(i));
    end
    else
    if value=5 then
    begin
     Canvas.MoveTo(CHeight,Round(i));
     Canvas.LineTo(CHeight-h2,Round(i));
    end
    else
    begin
     Canvas.MoveTo(CHeight,Round(i));
     Canvas.LineTo(CHeight-h3,Round(i));
    end;
    i:=i+onecent;
    inc(x);
   end;
  end
 finally
  Canvas.Stop;
 end;
 end;
 Result:=Bitmap;
end;

initialization
bitmapHcm:=nil;
bitmapVcm:=nil;
bitmapHin:=nil;
bitmapVin:=nil;

finalization
bitmapHcm.free;
bitmapVcm.free;
bitmapHin.free;
bitmapVin.free;

end.
