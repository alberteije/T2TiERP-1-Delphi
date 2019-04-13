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

unit rprulervcl;

interface

{$I rpconf.inc}

uses
{$IFDEF USEVARIANTS}
  Types,
{$ENDIF}
  Classes,SysUtils,
  Windows,Graphics, Controls,
  Forms,rpmunits,
 rpmdconsts;


const
 CMAXHEIGHT=5800;
type

  TRprulertype = (rHorizontal,rVertical);
  TRprulermetric=(rCms,rInchess);

  TRpRulerVCL = class(TCustomControl)
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



function PaintRuler (metrics:TRprulermetric; scale:double; RType:TRpRulerType; Color:TColor; Width,Height:integer):TBitmap;

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




constructor TRpRulerVCL.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FBorderStyle:=bssingle;
 FRType:=rVertical;
 Color:=clWhite;
 // The canvas
 Canvas.Pen.Style:=psSolid;
 Canvas.Pen.Color:=clWindowtext;
 FMetrics:=rCms;
 FScale:=1.0;

 Width:=20;
 Updated:=False;
end;

procedure TRpRulerVCL.SetScale(nvalue:double);
begin
 if FScale=nvalue then
  exit;
 FScale:=nvalue;
 Invalidate;
end;



destructor TRpRulerVCL.Destroy;
begin
 inherited Destroy;
end;

procedure TRpRulerVCL.SetRType(value:TRprulertype);
begin
 if ((value<>FRType) And (Updated)) then
  Exit;
 Updated:=False;
 FRType:=value;
end;

procedure TRpRulerVCL.SetBounds(ALeft,Atop,AWidth,AHeight:integer);
begin
 inherited SetBounds(ALeft,ATop,AWidth,AHeight);

end;


procedure TRpRulerVCL.SetMetrics(Value:TRprulermetric);
begin
 if value=Fmetrics then
  exit;
 FMetrics:=Value;
 Invalidate;
end;

procedure TRpRulerVCL.Paint;
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

function LogicalPointToDevicePoint(origin,destination,value:TPoint):TPoint;
begin
 Result:=value;
 if Origin.X=0 then
  exit;
 if Origin.Y=0 then
  exit;
 value.X:=Round(value.X*(destination.X/origin.X));
 value.Y:=Round(value.Y*(destination.Y/origin.Y));
 Result:=Value;
end;


function PaintRuler(metrics:TRprulermetric;scale:double; RType:TRpRulerType;Color:TColor;Width,Height:integer):TBitmap;
var rect,rectrefresh:TRect;
    value,Clength,CHeight:integer;
    bitmap:TBitmap;
    pixelsperinchx,pixelsperinchy:Integer;
    windowwidth:integer;
    windowheight:integer;
    h1,h2,h3,x:integer;
    i,onethousand,onecent:double;
    han:HDC;
    oldmapmode:integer;
    bwidth,bheight:integer;
    origin,destination,avalue:TPoint;
begin
 if scale=0 then
  scale:=1.0;
 Bitmap:=nil;
 bwidth:=2500;
 bheight:=2500;
 if Metrics=rCms then
 begin
  if RType=rHorizontal then
  begin
   if assigned(BitmapHcm) then
   begin
    if ((width>BitmapHcm.Width)  or (bitscaleHcm<>scale)) then
    begin
     bwidth:=width;
     bitscaleHcm:=scale;
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
    if ((height>BitmapVcm.Height) or (bitscaleVcm<>scale)) then
    begin
     bheight:=height;
     bitscaleVcm:=scale;
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
    if ((width>BitmapHin.Width) or (bitscaleHin<>scale)) then
    begin
     bwidth:=width;
     bitscaleHin:=scale;
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
    if ((height>BitmapVin.Height) or (bitscaleVin<>scale)) then
    begin
     bheight:=height;
     bitscaleVin:=scale;
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
{$IFNDEF DOTNETDBUGS}
 Bitmap.PixelFormat:=pf32bit;
 Bitmap.HandleType:=bmDIB;
{$ENDIF}
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
 Bitmap.Canvas.Brush.Color:=Color;
 Bitmap.Canvas.Brush.Style:=bsSolid;
 Bitmap.Canvas.Pen.Style:=psSolid;
 Bitmap.Canvas.Pen.Color:=clBlack;
 Rect.Left:=0;
 Rect.Top:=0;
 Rect.Right:=Bitmap.Width;
 Rect.Bottom:=Bitmap.Height;
 rectrefresh:=rect;

 pixelsperinchx:=Round(Screen.PixelsPerInch*scale);
 pixelsperinchy:=Round(Screen.PixelsPerInch*scale);

 Bitmap.Canvas.Rectangle(rect.Left,rect.Top,rect.Right,rect.Bottom);


 if Metrics=rCms then
 begin
  onecent:=100/CMS_PER_INCHESS;
  onethousand:=onecent*10;
 end
 else
 begin
  onethousand:=1000;
  onecent:=100;
 end;
 windowwidth:=Round(1000*rect.right/pixelsperinchx);
 windowheight:=Round(1000*rect.bottom/pixelsperinchy);
 if scale>=1 then
 begin
  h1:=Round(120/scale*1.5);
  h2:=Round(60/scale*1.5);
  h3:=Round(30/scale*1.5);
 end
 else
 begin
  h1:=240;
  h2:=120;
  h3:=60;
 end;

 origin.X:=windowwidth;
 origin.Y:=windowheight;
 destination.X:=rect.Right;
 destination.Y:=rect.Bottom;

 han:=Bitmap.Canvas.Handle;
// oldmapmode:=SetMapMode(han,MM_ISOTROPIC);
 oldmapmode:=SetMapMode(han,MM_TEXT);
 try
//  SetViewportExtEx(han,rect.Right,rect.Bottom,nil);
//  SetWindowExtEx(han,windowwidth
//   ,windowheight,nil);
  if RType=rHorizontal then
  begin
   i:=0;
   Clength:=windowwidth;
   CHeight:=windowheight;
   x:=0;
   while (i<Clength) do
   begin
    value:=x mod 10;
    if value=0 then
    // One number
    begin
     avalue.X:=Round(i);
     avalue.Y:=0;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
{$IFNDEF DOTNETD}
     TextOut(han,avalue.X+1,avalue.Y,PChar(IntToStr(Round(i/onethousand))),Length(IntToStr(Round(i/onethousand))));
{$ENDIF}
{$IFDEF DOTNETD}
     TextOut(han,avalue.X+1,avalue.Y,IntToStr(Round(i/onethousand)),Length(IntToStr(Round(i/onethousand))));
{$ENDIF}
     avalue.X:=Round(i);
     avalue.Y:=CHeight;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.MoveTo(avalue.X,avalue.Y);
     avalue.X:=Round(i);
     avalue.Y:=CHeight-h1;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.LineTo(avalue.X,avalue.Y);
    end
    else
    if value=5 then
    begin
     avalue.X:=Round(i);
     avalue.Y:=CHeight;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.MoveTo(avalue.X,avalue.Y);
     avalue.X:=Round(i);
     avalue.Y:=CHeight-h2;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.LineTo(avalue.X,avalue.Y);
    end
    else
    begin
     avalue.X:=Round(i);
     avalue.Y:=CHeight;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.MoveTo(avalue.X,avalue.Y);
     avalue.X:=Round(i);
     avalue.Y:=CHeight-h3;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.LineTo(avalue.X,avalue.Y);
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
    value:=x mod 10;
    if value=0 then
    // One number
    begin
     avalue.X:=0;
     avalue.Y:=Round(i);
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
{$IFNDEF DOTNETD}
     TextOut(han,avalue.X+1,avalue.Y,PChar(IntToStr(Round(i/onethousand))),Length(IntToStr(Round(i/onethousand))));
{$ENDIF}
{$IFDEF DOTNETD}
     TextOut(han,avalue.X+1,avalue.Y,IntToStr(Round(i/onethousand)),Length(IntToStr(Round(i/onethousand))));
{$ENDIF}
     avalue.X:=CHEight;
     avalue.Y:=Round(i);
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.MoveTo(avalue.X,avalue.Y);
     avalue.X:=CHEight-h1;
     avalue.Y:=Round(i);
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.LineTo(avalue.X,avalue.Y);
    end
    else
    if value=5 then
    begin
     avalue.X:=CHEight;
     avalue.Y:=Round(i);
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.MoveTo(avalue.X,avalue.Y);
     avalue.X:=CHEight-h2;
     avalue.Y:=Round(i);
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.LineTo(avalue.X,avalue.Y);
    end
    else
    begin
     avalue.X:=CHEight;
     avalue.Y:=Round(i);
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.MoveTo(avalue.X,avalue.Y);
     avalue.X:=CHEight-h3;
     avalue.Y:=Round(i);
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Bitmap.Canvas.LineTo(avalue.X,avalue.Y);
    end;
    i:=i+onecent;
    inc(x);
   end;
  end;
 finally
  SetMapMode(han,oldmapmode);
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
