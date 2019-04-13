{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfdrawintvcl                                 }
{       Implementation draw item and image interface    }
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

unit rpmdfdrawintvcl;

interface

{$I rpconf.inc}

uses SysUtils, Classes,Windows,
  Graphics, Forms,Menus,Dialogs,extdlgs,
  Buttons, ExtCtrls, Controls, StdCtrls,rpvgraphutils,
{$IFDEF USEVARIANTS}
  types,
{$ENDIF}
{$IFNDEF DOTNETD}
  jpeg,
{$ENDIF}
{$IFDEF EXTENDEDGRAPHICS}
 rpgraphicex,
{$ENDIF}
  rppdffile,clipbrd,rpgdidriver,
  rpprintitem,rpdrawitem,rpmdobinsintvcl,rpmdconsts,
  rpgraphutilsvcl,rpmunits,rptypes;

type
 TRpDrawInterface=class(TRpSizePosInterface)
  private
  protected
   procedure Paint;override;
  public
   class procedure FillAncestors(alist:TStrings);override;
   constructor Create(AOwner:TComponent;pritem:TRpCommonComponent);override;
   procedure GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);override;
   procedure SetProperty(pname:string;value:Widestring);override;
   function GetProperty(pname:string):Widestring;override;
   procedure GetPropertyValues(pname:string;lpossiblevalues:TRpWideStrings);override;
 end;

 TRpImageInterface=class(TRpSizePosInterface)
  private
   FBitmap:TBitmap;
   FIntStream:TMemoryStream;
   mcut,mcopy,mpaste,mopen:TMenuItem;
   procedure CutImageClick(Sender:TObject);
   procedure CopyImageClick(Sender:TObject);
   procedure PasteImageClick(Sender:TObject);
   procedure LoadImageClick(Sender:TObject);
  protected
   procedure Paint;override;
   procedure InitPopUpMenu;override;
   procedure PopUpContextMenu;override;
  public
   class procedure FillAncestors(alist:TStrings);override;
   constructor Create(AOwner:TComponent;pritem:TRpCommonComponent);override;
   destructor Destroy;override;
   procedure GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);override;
   procedure SetProperty(pname:string;value:Widestring);override;
   function GetProperty(pname:string):Widestring;override;
   procedure GetPropertyValues(pname:string;lpossiblevalues:TRpWideStrings);override;
   procedure SetProperty(pname:string;stream:TMemoryStream);override;
   procedure GetProperty(pname:string;var Stream:TMemoryStream);override;
 end;


var
 StringPenStyle:array [psSolid..psClear] of wideString;
 StringBrushStyle:array [rpbsSolid..rpbsDense7] of wideString;
 StringShapeType:array [rpsRectangle..rpsOblique2] of wideString;
// StringCopyModes:array [cmBlackness..cmCreateMask] of widestring;
 // TCopyMode = (cmBlackness, cmDstInvert, cmMergeCopy, cmMergePaint,
// cmNotSrcCopy, cmNotSrcErase, cmPatCopy, cmPatInvert,
// cmPatPaint, cmSrcAnd, cmSrcCopy, cmSrcErase,
// cmSrcInvert, cmSrcPaint, cmWhiteness, cmCreateMask);

function StringPenStyleToInt(Value:widestring):integer;
function StringBrushStyleToInt(Value:wideString):integer;
function StringShapeTypeToShape(Value:wideString):TRpShapeType;
//function StringCopyModeToCopyMode(Value:widestring):TCopyMode;

implementation



constructor TRpDrawInterface.Create(AOwner:TComponent;pritem:TRpCommonComponent);
begin
 if Not (pritem is TRpShape) then
  Raise Exception.Create(SRpIncorrectComponentForInterface);
 inherited Create(AOwner,pritem);
end;

class procedure TRpDrawInterface.FillAncestors(alist:TStrings);
begin
 inherited FillAncestors(alist);
 alist.Add('TRpDrawInterface');
end;

procedure TRpDrawInterface.GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);
begin
 inherited GetProperties(lnames,ltypes,lvalues,lhints,lcat);


 // Shape
 lnames.Add(SrpSShape);
 ltypes.Add(SRpSList);
 lhints.Add('refdraw.html');
 lcat.Add(SRpShape);
 if Assigned(lvalues) then
  lvalues.Add(StringShapeType[TRpShapeType(TRpShape(printitem).Shape)]);

 // Pen style
 lnames.Add(SrpSPenStyle);
 ltypes.Add(SRpSList);
 lhints.Add('refdraw.html');
 lcat.Add(SRpShape);
 if Assigned(lvalues) then
  lvalues.Add(StringPenStyle[TPenStyle(TRpShape(printitem).PenStyle)]);

 // Pen Color
 lnames.Add(SrpSPenColor);
 ltypes.Add(SRpSColor);
 lhints.Add('refdraw.html');
 lcat.Add(SRpShape);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpShape(printitem).PenColor));

 // PenWidth
 lnames.Add(SrpSPenWidth);
 ltypes.Add(SRpSString);
 lhints.Add('refdraw.html');
 lcat.Add(SRpShape);
 if Assigned(lvalues) then
  lvalues.Add(gettextfromtwips(TRpShape(printitem).PenWidth));


 // Brush style
 lnames.Add(SrpSBrushStyle);
 ltypes.Add(SRpSList);
 lhints.Add('refdraw.html');
 lcat.Add(SRpShape);
 if Assigned(lvalues) then
  lvalues.Add(StringBrushStyle[TRpBrushStyle(TRpShape(printitem).BrushStyle)]);

 // Brush Color
 lnames.Add(SrpSBrushColor);
 ltypes.Add(SRpSColor);
 lhints.Add('refdraw.html');
 lcat.Add(SRpShape);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpShape(printitem).BrushColor));

end;

function StringPenStyleToInt(Value:wideString):integer;
var
 i:TPenStyle;
begin
 Result:=0;
 for i:=psSolid to psClear do
 begin
  if Value=StringPenStyle[i] then
  begin
   Result:=Integer(i);
   break;
  end;
 end;
end;

function StringShapeTypeToShape(Value:wideString):TRpShapeType;
var
 i:TRpShapetype;
begin
 Result:=rpsRectangle;
 for i:=rpsRectangle to rpsOblique2 do
 begin
  if Value=StringShapeType[i] then
  begin
   Result:=i;
   break;
  end;
 end;
end;


function StringBrushStyleToInt(Value:wideString):integer;
var
 i:TRpBrushStyle;
begin
 Result:=0;
 for i:=rpbsSolid to rpbsDense7 do
 begin
  if Value=StringBrushStyle[i] then
  begin
   Result:=Integer(i);
   break;
  end;
 end;
end;


{function StringCopyModeToCopyMode(Value:widestring):TCopyMode;
var
 i:TCopyMode;
begin
 Result:=cmSrcCopy;
 for i:=cmBlackness to cmCreateMask do
 begin
  if Value=StringCopyModes[i] then
  begin
   Result:=i;
   break;
  end;
 end;
end;
}

procedure TRpDrawInterface.SetProperty(pname:string;value:Widestring);
begin
 if pname=SRpSShape then
 begin
  TRpShape(fprintitem).Shape:=StringShapeTypeToShape(Value);
  invalidate;
  exit;
 end;
 if pname=SRpSPenStyle then
 begin
  TRpShape(fprintitem).PenStyle:=StringPenStyleToInt(Value);
  invalidate;
  exit;
 end;
 if pname=SRpSPenColor then
 begin
  TRpShape(fprintitem).PenColor:=StrToInt(Value);
  invalidate;
  exit;
 end;
 if pname=SRpSPenWidth then
 begin
  TRpShape(fprintitem).PenWidth:=gettwipsfromtext(value);
  invalidate;
  exit;
 end;
 if pname=SRpSBrushStyle then
 begin
  TRpShape(fprintitem).BrushStyle:=StringBrushStyleToInt(Value);
  invalidate;
  exit;
 end;
 if pname=SRpSBrushColor then
 begin
  TRpShape(fprintitem).BrushColor:=StrToInt(Value);
  invalidate;
  exit;
 end;

 inherited SetProperty(pname,value);
end;

function TRpDrawInterface.GetProperty(pname:string):Widestring;
begin
 Result:='';
 if pname=SrpSShape then
 begin
  Result:=StringShapeType[TRpShapeType(TRpShape(printitem).Shape)];
  exit;
 end;
 if pname=SrpSPenStyle then
 begin
  Result:=StringPenStyle[TPenStyle(TRpShape(printitem).PenStyle)];
  exit;
 end;
 if pname=SrpSPenColor then
 begin
  Result:=IntToStr(TRpShape(printitem).PenColor);
  exit;
 end;
 if pname=SrpSPenWidth then
 begin
  Result:=gettextfromtwips(TRpShape(printitem).PenWidth);
  exit;
 end;

 if pname=SrpSBrushStyle then
 begin
  Result:=StringBrushStyle[TRpBrushStyle(TRpShape(printitem).BrushStyle)];
  exit;
 end;
 if pname=SrpSBrushColor then
 begin
  Result:=IntToStr(TRpShape(printitem).BrushColor);
  exit;
 end;

 Result:=inherited GetProperty(pname);
end;



procedure TRpDrawInterface.Paint;
var
 ashape:TRpShape;
 X, Y, W, H, S: Integer;
begin
 Canvas.Brush.Style:=bsClear;
 Canvas.Pen.Style:=psDashDot;
 Canvas.Pen.Width:=0;
 Canvas.Rectangle(0, 0, Width ,Height);
 ashape:=TRpShape(printitem);
 if csDestroying in ashape.ComponentState then
  exit;
 Canvas.Brush.Color:=ashape.BrushColor;
 Canvas.Brush.Style:=TBrushStyle(ashape.BrushStyle);
 Canvas.Pen.Style:=TPenStyle(ashape.PenStyle);
 Canvas.Pen.Color:=ashape.Pencolor;
 Canvas.Pen.Width:=Round(Screen.PixelsPerInch*ashape.PenWidth/TWIPS_PER_INCHESS);

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
 if ashape.Shape in [rpsSquare, rpsRoundSquare, rpsCircle] then
 begin
  Inc(X, (W - S) div 2);
  Inc(Y, (H - S) div 2);
  W := S;
  H := S;
 end;
 case ashape.Shape of
  rpsRectangle, rpsSquare:
   Canvas.Rectangle(X, Y, X + W, Y + H);
  rpsRoundRect, rpsRoundSquare:
   Canvas.RoundRect(X, Y, X + W, Y + H, S div 4, S div 4);
  rpsCircle, rpsEllipse:
   Canvas.Ellipse(X, Y, X + W, Y + H);
  rpsHorzLine:
   begin
    Canvas.MoveTo(0,0);
    Canvas.LineTo(X+W,0);
   end;
  rpsVertLine:
   begin
    Canvas.MoveTo(0,0);
    Canvas.LineTo(0,Y+H);
   end;
  rpsOblique1:
   begin
    Canvas.MoveTo(0,0);
    Canvas.LineTo(X+W,Y+H);
   end;
  rpsOblique2:
   begin
    Canvas.MoveTo(0,Y+H);
    Canvas.LineTo(X+W,0);
   end;
 end;
 DrawSelected;
end;



procedure TRpDrawInterface.GetPropertyValues(pname:string;lpossiblevalues:TRpWideStrings);
var
 pi:TPenStyle;
 bi:TRpBrushStyle;
 shi:TRpShapeType;
begin
 if pname=SrpSShape then
 begin
  lpossiblevalues.clear;
  for shi:=rpsRectangle to rpsOblique2 do
  begin
   lpossiblevalues.Add(StringShapeType[shi]);
  end;
  exit;
 end;
 if pname=SrpSPenStyle then
 begin
  lpossiblevalues.clear;
  for pi:=psSolid to psClear do
  begin
   lpossiblevalues.Add(StringPenStyle[pi]);
  end;
  exit;
 end;
 if pname=SrpSBrushStyle then
 begin
  lpossiblevalues.clear;
  for bi:=rpbsSolid to rpbsDense7 do
  begin
   lpossiblevalues.Add(StringBrushStyle[bi]);
  end;
  exit;
 end;
 inherited GetPropertyValues(pname,lpossiblevalues);
end;

// Image Interface

constructor TRpImageInterface.Create(AOwner:TComponent;pritem:TRpCommonComponent);
begin
 if Not (pritem is TRpImage) then
  Raise Exception.Create(SRpIncorrectComponentForInterface);
 inherited Create(AOwner,pritem);
 FIntStream:=TMemoryStream.Create;
end;

class procedure TRpImageInterface.FillAncestors(alist:TStrings);
begin
 inherited FillAncestors(alist);
 alist.Add('TRpImageInterface');
end;

destructor TRpImageInterface.Destroy;
begin
 FIntStream.free;
 if Assigned(FBitmap) then
  FBitmap.free;
 inherited destroy;
end;

procedure TRpImageInterface.GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);
begin
 inherited GetProperties(lnames,ltypes,lvalues,lhints,lcat);


 // DrawStyle
 lnames.Add(SRpDrawStyle);
 ltypes.Add(SRpSList);
 lhints.Add('refimage.html');
 lcat.Add(SRpImage);
 if Assigned(lvalues) then
  lvalues.Add(RpDrawStyleToString(TRpImage(printitem).DrawStyle));

 // Expression
 lnames.Add(SrpSExpression);
 ltypes.Add(SRpSExpression);
 lhints.Add('refimage.html');
 lcat.Add(SRpImage);
 if Assigned(lvalues) then
  lvalues.Add(TRpImage(printitem).Expression);

 // Image
 lnames.Add(SrpSImage);
 ltypes.Add(SRpSImage);
 lhints.Add('refimage.html');
 lcat.Add(SRpImage);
 if Assigned(lvalues) then
  lvalues.Add('['+FormatFloat('###,###0.00',TRpImage(printitem).Stream.Size/1024)+
  SRpKbytes+']');

 // DPI
 lnames.Add(SRpDPIRes);
 ltypes.Add(SRpSString);
 lhints.Add('refimage.html');
 lcat.Add(SRpImage);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpImage(printitem).DPIRes));

 // CopyMode is disabled because it don't work with stretchdraw
// lnames.Add(SRpCopyMode);
// ltypes.Add(SRpSList);
// if Assigned(lvalues) then
// lvalues.Add(StringCopyModes[TCopyMode(TRpImage(printitem).CopyMode)]);
 // CachedImage
 lnames.Add(SRpCached);
 ltypes.Add(SRpSList);
 lhints.Add('refimage.html');
 lcat.Add(SRpImage);
 if Assigned(lvalues) then
  lvalues.Add(RpCachedImageToString(TRpImage(printitem).CachedImage));

end;



procedure TRpImageInterface.SetProperty(pname:string;value:Widestring);
begin
 if pname=SRpSExpression then
 begin
  TRpImage(fprintitem).Expression:=Value;
  if Length(Trim(Value))>0 then
  begin
   TRpImage(fprintitem).Stream.SetSize(0);
  end;
  invalidate;
  exit;
 end;
 if pname=SRpDrawStyle then
 begin
  TRpImage(fprintitem).DrawStyle:=StringDrawStyleToDrawStyle(Value);
  invalidate;
  exit;
 end;
{ if pname=SRpCopyMode then
 begin
  TRpImage(fprintitem).CopyMode:=Integer(StringCopyModeToCopyMode(Value));
  invalidate;
  exit;
 end;
} if pname=SRpDPIRes then
 begin
  TRpImage(fprintitem).DPIRes:=StrToInt(Value);
  if TRpImage(fprintitem).DPIRes<=0 then
   TRpImage(fprintitem).DPIRes:=100;
  invalidate;
  exit;
 end;
 if pname=SRpCached then
 begin
  TRpImage(fprintitem).CachedImage:=StringCachedImageToCachedImage(Value);
  invalidate;
  exit;
 end;
 inherited SetProperty(pname,value);
end;

function TRpImageInterface.GetProperty(pname:string):Widestring;
begin
 Result:='';
 if pname=SrpSExpression then
 begin
  Result:=TRpImage(printitem).Expression;
  exit;
 end;
 if pname=SrpDrawStyle then
 begin
  Result:=RpDrawStyleToString(TRpImage(printitem).DrawStyle);
  exit;
 end;
// if pname=SrpCopyMode then
// begin
//  Result:=StringCopyModes[TCopyMode(TRpImage(printitem).CopyMode)];
//  exit;
// end;
 if pname=SRpDPIRes then
 begin
  Result:=IntToStr(TRpImage(fprintitem).DPIRes);
  exit;
 end;
 if pname=SrpSImage then
 begin
  Result:='['+FormatFloat('###,###0.00',TRpImage(printitem).Stream.Size/1024)+
  SRpKbytes+']';
  exit;
 end;
 if pname=SRpCached then
 begin
  Result:=RpCachedImageToString(TRpImage(fprintitem).CachedImage);
  exit;
 end;
 Result:=inherited GetProperty(pname);
end;



procedure TRpImageInterface.Paint;
var
 aimage:TRpImage;
 rec:TRect;
 dpix,dpiy:integer;
// oldrgn:HRGN;
// newrgn:HRGN;
// aresult:integer;
 bitmapwidth,bitmapheight:integer;
 format:string;
{$IFNDEF DOTNETD}
 jpegimage:TJPegImage;
{$ENDIF}
 astream:TStream;
begin
 aimage:=TRpImage(printitem);
 try
  if csDestroying in aimage.ComponentState then
   exit;
  Canvas.Pen.Color:=clBlack;
  Canvas.Pen.Style:=psSolid;
  Canvas.Brush.Style:=bsClear;
  Canvas.Rectangle(0,0,Width,Height);
  if aimage.Stream.Size>0 then
  begin
   if IsCompressed(aimage.Stream) then
   begin
    FIntStream.SetSize(0);
    DecompressStream(aimage.Stream,FIntStream);
    astream:=FIntStream;
    FIntStream.Seek(0,soFromBeginning);
   end
   else
    astream:=aimage.Stream;

   if Not Assigned(FBitmap) then
   begin
    FBitmap:=TBitmap.Create;
    FBitmap.PixelFormat:=pf32bit;
    aStream.Seek(0,soFromBeginning);
    try
     FBitmap.HandleType:=bmDIB;
     GetJPegInfo(astream,bitmapwidth,bitmapheight,format);
     if (format='JPEG') then
     begin
{$IFNDEF DOTNETD}
      jpegimage:=TJPegImage.Create;
      try
       jpegimage.LoadFromStream(astream);
       fbitmap.Assign(jpegimage);
      finally
       jpegimage.free;
      end;
{$ENDIF}
{$IFDEF DOTNETD}
      fbitmap.LoadFromStream(astream);
{$ENDIF}
     end
     else
     begin
      aStream.Seek(0,soFromBeginning);
      if (format='BMP') then
      begin
      fbitmap.LoadFromStream(astream);
      end
      else
      begin
        // All other formats
{$IFDEF EXTENDEDGRAPHICS}
       ExFilterImage(aimage.Stream);
       jpegimage:=TJPegImage.Create;
       try
        jpegimage.LoadFromStream(aimage.stream);
        fbitmap.Assign(jpegimage);
       finally
        jpegimage.free;
       end;
{$ENDIF}
      end;
     end;
    except
     FBitmap.free;
     FBitmap:=nil;
     raise;
    end;
   end;
//   Canvas.CopyMode:=TCopyMode(aimage.CopyMode);
   rec.Top:=0;rec.Left:=0;
   rec.Bottom:=Height-1;rec.Right:=Width-1;
   // Draws it with the style
   case aimage.DrawStyle of
    rpDrawStretch:
     begin
      Canvas.StretchDraw(rec,fbitmap);
     end;
    rpDrawCrop:
     begin
      Canvas.Draw(0,0,fbitmap);
     end;
    rpDrawFull:
     begin
      dpix:=Screen.PixelsPerInch;
      dpiy:=Screen.PixelsPerInch;
      rec.Bottom:=round(fbitmap.height/aimage.dpires)*dpiy-1;
      rec.Right:=round(fbitmap.width/aimage.dpires)*dpix-1;
      Canvas.StretchDraw(rec,fbitmap);
     end;
    rpDrawTile,rpDrawTileDpi:
     begin
      // Set clip region
//      oldrgn:=CreateRectRgn(0,0,2,2);

//      aresult:=GetClipRgn(Canvas.Handle,oldrgn);
//      newrgn:=CreateRectRgn(rec.Left,rec.Top,rec.Right,rec.Bottom);
//      SelectClipRgn(Canvas.handle,newrgn);
      if aimage.DrawStyle=rpDrawTile then
       DrawBitmapMosaicSlow(Canvas,rec,fbitmap,0)
      else
       DrawBitmapMosaicSlow(Canvas,rec,fbitmap,aimage.dpires);
//      if aresult=0 then
//       SelectClipRgn(Canvas.handle,0)
//      else
//       SelectClipRgn(Canvas.handle,oldrgn);
     end;
   end;
  end;
  // Draws the expresion
  Canvas.Brush.Style:=bsClear;
  Canvas.Rectangle(0,0,Width,Height);
  Canvas.TextOut(0,0,SRpSImage+aimage.Expression);
 except
  Canvas.TextOut(0,0,SRpInvalidImageFormat);
 end;
 DrawSelected;
end;


procedure TRpImageInterface.SetProperty(pname:string;stream:TMemoryStream);
begin
 if pname=SrpSImage then
 begin
  TRpImage(printitem).Stream:=stream;
  if TRpImage(printitem).Stream.Size>0 then
   TrpImage(printitem).Expression:='';
  FBitmap.Free;
  FBitmap:=nil;
  Invalidate;
  exit;
 end;
 inherited SetProperty(pname,stream);
end;

procedure TRpImageInterface.GetProperty(pname:string;var Stream:TMemoryStream);
begin
 if pname=SrpSImage then
 begin
  Stream:=TRpImage(printitem).Stream;
  exit;
 end;
 inherited GetProperty(pname,stream);
end;



procedure TRpImageInterface.GetPropertyValues(pname:string;lpossiblevalues:TRpWideStrings);
// k:TCopyMode;
begin
 if pname=SrpDrawStyle then
 begin
  GetDrawStyleDescriptions(lpossiblevalues);
  exit;
 end;
 if pname=SRpCached then
 begin
  GetCachedImageDescriptions(lpossiblevalues);
  exit;
 end;
{ if pname=SrpCopyMode then
 begin
  lpossiblevalues.clear;
  for k:=cmBlackness to cmCreateMask do
  begin
   lpossiblevalues.Add(StringCopyModes[k]);
  end;
  exit;
 end;
} inherited GetPropertyValues(pname,lpossiblevalues);
end;

procedure TRpImageInterface.InitPopUpMenu;
begin
 inherited InitPopUpMenu;

 // Cut Image
 mcut:=TMenuItem.Create(FContextMenu);
 mcut.Caption:=TranslateStr(9,'Cut');
 mcut.Hint:=TranslateStr(12,'Cut the image to the clipboard');
 mcut.OnClick:=CutImageClick;
 FContextMenu.Items.Add(mcut);

 // Copy Image
 mcopy:=TMenuItem.Create(FContextMenu);
 mcopy.Caption:=TranslateStr(10,'Copy');
 mcopy.Hint:=TranslateStr(13,'Copy the image to the clipboard');
 mcopy.OnClick:=CopyImageClick;
 FContextMenu.Items.Add(mcopy);

 // Paste Image
 mpaste:=TMenuItem.Create(FContextMenu);
 mpaste.Caption:=TranslateStr(11,'Paste');
 mpaste.Hint:=TranslateStr(14,'Paste the image from the clipboard');
 mpaste.OnClick:=PasteImageClick;
 FContextMenu.Items.Add(mpaste);

 // Open Image
 mopen:=TMenuItem.Create(FContextMenu);
 mopen.Caption:=TranslateStr(42,'Open');
// mopen.Hint:=TranslateStr(43,'Load the image from a file');
 mopen.OnClick:=LoadImageClick;
 FContextMenu.Items.Add(mopen);
end;

procedure TRpImageInterface.PopUpContextMenu;
var
 aimage:TRpImage;
begin
 inherited PopUpContextMenu;
 aimage:=TRpImage(printitem);

 if aimage.Stream.Size=0 then
 begin
  mcut.Enabled:=false;
  mcopy.Enabled:=false;
 end
 else
 begin
  mcut.Enabled:=true;
  mcopy.Enabled:=true;
 end;
 if Clipboard.HasFormat(CF_BITMAP) then
 begin
  mpaste.Enabled:=true;
 end
 else
 begin
  mpaste.Enabled:=false;
 end;
end;


procedure TRpImageInterface.CutImageClick(Sender:TObject);
var
 aimage:TRpImage;
begin
 aimage:=TRpImage(printitem);

 CopyImageClick(Self);

 aimage.Stream.Clear;
 Invalidate;
end;

procedure TRpImageInterface.CopyImageClick(Sender:TObject);
var
 jpe:TJPEGImage;
 jpegimage:TJPEGImage;
 bitmap:TBitmap;
   format:string;
 bitmapwidth,bitmapheight:integer;
 aimage:TRpImage;
begin
 aimage:=TRpImage(printitem);
 if (aimage.Stream.Size=0) then
  exit;
 bitmap:=TBitmap.Create;
 try
   aimage.Stream.Seek(0,soFromBeginning);
   format:='';
   GetJPegInfo(aimage.Stream,bitmapwidth,bitmapheight,format);
   if (format='JPEG') then
   begin
    aimage.Stream.Seek(0,soFromBeginning);
    jpe:=TJPEGImage.Create;
    try
     jpe.LoadFromStream(aimage.Stream);
     bitmap.PixelFormat:=pf24bit;
     bitmap.Width:=jpe.Width;
     bitmap.Height:=jpe.Height;
     bitmap.Canvas.Draw(0,0,jpe);
    finally
     jpe.free;
    end;
   end
   else
   begin
    if (format='BMP') then
    begin
    aimage.Stream.Seek(0,soFromBeginning);
    bitmap.LoadFromStream(aimage.Stream);
    ClipBoard.Assign(bitmap);
    end
    else
    begin
      // All other formats
{$IFDEF EXTENDEDGRAPHICS}
       ExFilterImage(aimage.Stream);
       jpegimage:=TJPegImage.Create;
       try
        jpegimage.LoadFromStream(aimage.stream);
        bitmap.Assign(jpegimage);
       finally
        jpegimage.free;
       end;
{$ENDIF}
    end;
   end;
 finally
  bitmap.free;
 end;
end;

procedure TRpImageInterface.PasteImageClick(Sender:TObject);
var
 bitmap:TBitmap;
 aimage:TRpImage;
begin
 aimage:=TRpImage(printitem);
 if ClipBoard.HasFormat(CF_BITMAP) then
 begin
  bitmap:=TBitmap.Create;
  try
   bitmap.Assign(ClipBoard);
   aimage.Stream.Clear;
   bitmap.SaveToStream(aimage.Stream);
   aimage.Expression:='';
   Invalidate;
  finally
   bitmap.free;
  end;
 end;
end;



procedure TRpImageInterface.LoadImageClick(Sender:TObject);
var
 OpenDialog1:TOpenPictureDialog;
 aimage:TRpImage;
 jpeg:TJPegImage;
{$IFDEF EXTENDEDGRAPHICS}
 gfilter:string;
 apic:TPicture;
{$ENDIF}
begin
 aimage:=TRpImage(printitem);
 OpenDialog1:=TOpenPictureDialog.Create(Application);
 try
  OpenDialog1.Filter:=
   SrpBitmapImages+'|*.bmp|'+
   SrpSJpegImages+'|*.jpg|';
//  SrpSPNGImages+'|*.png|'+
//  SRpSXPMImages+'|*.xpm';
 // Add Registered file formats
 // Add registered filters
{$IFDEF EXTENDEDGRAPHICS}
  gfilter:=rpgraphicex.FileFormatList.GetGraphicFilter([],fstExtension,[foIncludeExtension],nil);
  OpenDialog1.Filter:=OpenDialog1.Filter+gfilter;
(* TFRpObjInspVCL(Owner).OpenDialog1.Filter:=TFRpObjInspVCL(Owner).OpenDialog1.Filter+
  'PCX '+'|*.pcx|'+
  'GIF '+'|*.gif|'+
  'PNG '+'|*.png|'+
  'TIFF '+'|*.tiff|'+
  'TIF '+'|*.tif|'+
  'FAX '+'|*.fax|'+
  'EPS '+'|*.eps|';*)
{$ENDIF}

 if OpenDialog1.Execute then
 begin
  if (OpenDialog1.FilterIndex<=1) then
  begin
   aimage.Stream.LoadFromFile(OpenDialog1.FileName);
  end
{$IFDEF EXTENDEDGRAPHICS}
  else
  begin
   apic:=TPicture.Create;
   try
     apic.LoadFromFile(OpenDialog1.FileName);
     jpeg:=TJPegImage.Create;
     try
      jpeg.CompressionQuality:=100;
      jpeg.Assign(apic.Graphic);
      jpeg.SaveToStream(aimage.stream);
     finally
      jpeg.free;
     end;
   finally
    apic.free;
   end;
  end;
{$ENDIF}
 end;
 finally
  OpenDialog1.free;
 end;
end;

initialization
 StringPenStyle[psSolid]:=SRpSPSolid;
 StringPenStyle[psDash]:=SRpSPDash;
 StringPenStyle[psDot]:=SRpSPDot;
 StringPenStyle[psDashDot]:=SRpSPDashDot;
 StringPenStyle[psDashDotDot]:=SRpSPDashDotDot;
 StringPenStyle[psClear]:=SRpSPClear;

 StringBrushStyle[rpbsSolid]:=SRpSBSolid;
 StringBrushStyle[rpbsClear]:=SRpSBClear;
 StringBrushStyle[rpbsHorizontal]:=SRpSBHorizontal;
 StringBrushStyle[rpbsVertical]:=SRpSBVertical;
 StringBrushStyle[rpbsFDiagonal]:=SRpSBFDiagonal;
 StringBrushStyle[rpbsBDiagonal]:=SRpSBBDiagonal;
 StringBrushStyle[rpbsCross]:=SRpSBCross;
 StringBrushStyle[rpbsDiagCross]:=SRpSBDiagCross;
 StringBrushStyle[rpbsDense1]:=SRpSBDense1;
 StringBrushStyle[rpbsDense2]:=SRpSBDense2;
 StringBrushStyle[rpbsDense3]:=SRpSBDense3;
 StringBrushStyle[rpbsDense4]:=SRpSBDense4;
 StringBrushStyle[rpbsDense5]:=SRpSBDense5;
 StringBrushStyle[rpbsDense6]:=SRpSBDense6;
 StringBrushStyle[rpbsDense7]:=SRpSBDense7;

 StringShapeType[rpsRectangle]:=SRpsSRectangle;
 StringShapeType[rpsSquare]:=SRpsSSquare;
 StringShapeType[rpsRoundRect]:=SRpsSRoundRect;
 StringShapeType[rpsRoundSquare]:=SRpsSRoundSquare;
 StringShapeType[rpsEllipse]:=SRpsSEllipse;
 StringShapeType[rpsCircle]:=SRpsSCircle;
 StringShapeType[rpsHorzLine]:=SRpSHorzLine;
 StringShapeType[rpsVertLine]:=SRpSVertLine;
 StringShapeType[rpsOblique1]:=SRpSOblique1;
 StringShapeType[rpsOblique2]:=SRpSOblique2;


{ StringCopyModes:array [cmBlackness..cmCreateMask] of string=(
  SRpBlackness, SRpDstInvert, SRpMergeCopy, SRpMergePaint,
  SRpNotSrcCopy, SRpNotSrcErase, SRpPatCopy, SRpPatInvert,
  SRpPatPaint, SRpSrcAnd, SRpSrcCopy, SRpSrcErase,
  SRpSrcInvert, SRpSrcPaint, SRpWhiteness, SRpCreateMask);
}
end.
