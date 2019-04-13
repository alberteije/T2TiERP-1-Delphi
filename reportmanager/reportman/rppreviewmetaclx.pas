{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rppreviewmetafileclx                               }
{       CLX Preview metafile control                    }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2005 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rppreviewmetaclx;

interface

uses Types,Classes,QGraphics,QControls,QForms,rpmetafile,Qextctrls,rptypes,
 rpgraphutils,rpqtdriver,SysUtils,rptextdriver,Qt;

const
 MAXENTIREPAGES=128;
 DEFAULT_RESOLUTION=96;
 MIN_SCALE=0.01;
 MAX_SCALE=10.0;
type
 TRpPreviewMetaCLX=class;
 TAutoScaleType=(AScaleReal,AScaleWide,AScaleHeight,AScaleEntirePage,AScaleCustom);
 TPageDrawnEvent=procedure (prm:TRpPreviewMetaCLX) of object;
 TRpPreviewMetaCLX=class(TScrollBox)
  private
   FBarWidth:integer;
   FBarHeight:integer;
   FAutoScale:TAutoScaleType;
   FPreviewScale:double;
   FMetafile:TRpMetafileReport;
   FBitmap:TBitmap;
   FIntBitmap:TBitmap;
   FPage:integer;
   FPageDrawn,FPagesDrawn:integer;
   FScaleDrawn:double;
   dpix,dpiy:integer;
   FEntirePageCount:integer;
   FOldPage:integer;
   pagecolsdrawn,pagerowsdrawn:integer;
   pagewidthdrawn,pageheightdrawn:integer;
   FEntireTopDown:boolean;
   FOnPageDrawn:TPageDrawnEvent;
   FOnWorkProgress:TMetaFileWorkProgress;
   image:TImage;
   conteimage:TPanel;
   procedure SetMetafile(meta:TRpMetafileReport);
   procedure WorkAsyncError(amessage:String);
   procedure SetEntireTopDown(avalue:boolean);
   procedure SetEntirePageCount(avalue:integer);
   procedure ChangePreviewScale(newvalue:double);
   procedure DoResize;
   procedure SetAutoScale(newvalue:TAutoScaleType);
   procedure ResizeEvent(Sender:TObject);
   procedure InternalMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
   procedure SetPage(avalue:integer);
   procedure SetPreviewScale(avalue:double);
   procedure SetOnWorkProgress(AValue:TMetaFileWorkProgress);
  protected
   prdriver:TRpQtDriver;
   procedure Notification(AComponent:TComponent;Operation:TOperation);override;
   procedure SetParent(const AParent:TWidgetControl);override;
   procedure ReDrawPage;
  public
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
   procedure FirstPage;
   procedure PriorPage;
   procedure NextPage;
   procedure LastPage;
   procedure RefreshPage;
   procedure Scroll(vertical:boolean;increment:integer);
   procedure RefreshMetafile;virtual;
   property Metafile:TRpMetafileReport read FMetafile write SetMetafile;
   property PagesDrawn:integer read FPagesDrawn;
   property Page:integer read FPage write SetPage;
   property PageDrawn:integer read FPageDrawn;
  published
   property Visible;
   property Left;
   property Top;
   property Width;
   property Height;
   property Align;
   property Anchors;
   property Cursor;
   property PreviewScale:double read FPreviewScale write SetPreviewScale;
   property OnPageDrawn:TPageDrawnEvent read FOnPageDrawn write FOnPageDrawn;
   property EntirePageCount:integer read FEntirePageCount write SetEntirePageCount;
   property EntireTopDown:boolean read FEntireTopDown write
    SetEntireTopDown;
   property AutoScale:TAutoScaleType read FAutoScale write SetAutoScale;
   property Color;
   property OnWorkProgress:TMetaFileWorkProgress read FOnWorkProgress write SetOnWorkProgress;
 end;

implementation

constructor TRpPreviewMetaCLX.Create(AOwner:TComponent);
var
 asize:Size;
 astyle:QStyleH;
begin
 inherited Create(AOwner);

 OnResize:=ResizeEvent;
 Color:=clAppWorkSpace;
 FBitmap:=TBitmap.Create;
 FBitmap.PixelFormat:=pf32bit;
 FPage:=-1;
 FEntirePageCount:=1;
 dpix:=Screen.PixelsPerInch;
 dpiy:=Screen.PixelsPerInch;
 prdriver:=TRpQtDriver.Create;
 conteimage:=TPanel.Create(self);
 conteimage.BevelInner:=bvNone;
 conteimage.BevelOuter:=bvNone;
 image:=TImage.Create(Self);
 image.OnMouseDown:=InternalMouseDown;
 conteimage.Width:=0;
 conteimage.Height:=0;
 conteimage.Parent:=self;
 image.Parent:=conteimage;
 HorzScrollBar.Tracking:=true;
 VertScrollBar.Tracking:=true;
 astyle:=QApplication_style();
 QStyle_scrollBarExtent(astyle,@asize);
 FBarWidth:=asize.cx;
 FBarHeight:=asize.cy;
end;


procedure TRpPreviewMetaCLX.SetPreviewScale(avalue:double);
begin
 ChangePreviewScale(avalue);
 FAutoScale:=AScaleCustom;
 FPageDrawn:=-1;
 ReDrawPage;
end;

procedure TRpPreviewMetaCLX.SetAutoScale(newvalue:TAutoScaleType);
begin
 FAutoScale:=newvalue;
 ReDrawPage;
end;

procedure TRpPreviewMetaCLX.SetEntireTopDown(avalue:boolean);
begin
 FEntireTopDown:=avalue;
 if (FAutoScale=AScaleEntirePage) then
 begin
  FPagesDrawn:=0;
  ReDrawPage;
 end;
end;

procedure TRpPreviewMetaCLX.SetEntirePageCount(avalue:integer);
var
 pcount,i,newpage:integer;
begin
 if (FEntirePageCount<>avalue) then
 begin
  FEntirePageCount:=avalue;
  if (FEntirePageCount<1) then
   FEntirePageCount:=1;
  if (FEntirePageCount>MAXENTIREPAGES) then
   FEntirePageCount:=MAXENTIREPAGES;
  if Not Assigned(metafile) then
   exit;
  if (FEntirePageCount>1) then
  begin
   metafile.RequestPage(FPage+FEntirePageCount);
   pcount:=FEntirePageCount;
   for i:=metafile.CurrentPageCount-1 downto FPage-1 do
   begin
    pcount:=pcount-1;
   end;
   newpage:=FPage;
   for i:=0 to pcount-2 do
   begin
    newpage:=newpage+1;
    if (newpage<0) then
     newpage:=0;
    FPage:=newpage;
   end;
  end;
  ReDrawPage;
 end;
end;


procedure TRpPreviewMetaCLX.SetMetafile(meta:TRpMetafileReport);
var
 drivername:string;
 istextonly:boolean;
begin
 if meta=nil then
 begin
  FMetafile:=meta;
  exit;
 end;

 conteimage.Color:=meta.BackColor;
 istextonly:=Length(drivername)>0;
 if istextonly then
 begin
  prdriver.FontDriver:=TRpTextDriver.Create;
 end
 else
  prdriver.FontDriver:=nil;
 prdriver.NewDocument(meta,1,false);
 FScaleDrawn:=-1.0;
 FPageDrawn:=-1;
 FOldPage:=-1;
 FMetafile:=meta;
 if (FPage<0) then
  FPage:=0;
 case metafile.PreviewStyle of
   spNormal:
    FAutoScale:=AScaleReal;
   spWide:
    FAutoScale:=AScaleWide;
   spEntirePage:
    FAutoScale:=AScaleEntirePage;
 end;
 metafile.OnWorkAsyncError:=WorkAsyncError;
 metafile.OnWorkProgress:=OnWorkProgress;
 drivername:=Trim(GetPrinterEscapeStyleDriver(metafile.PrinterSelect));
 ReDrawPage;
end;

procedure TRpPreviewMetaCLX.WorkAsyncError(amessage:String);
begin
 RpMessageBox(amessage);
end;

destructor TRpPreviewMetaCLX.Destroy;
begin
 if Assigned(FBitmap) then
  FBitmap.Free;
 if Assigned(FIntBitmap) then
  FIntBitmap.Free;
 inherited Destroy;
end;

procedure TRpPreviewMetaCLX.Scroll(vertical:boolean;increment:integer);
begin
 if vertical then
  VertScrollBar.Position:=VertScrollBar.Position+increment
 else
  HorzScrollBar.Position:=HorzScrollBar.Position+increment;
end;

procedure TRpPreviewMetaCLX.ChangePreviewScale(newvalue:double);
begin
 if (newvalue<MIN_SCALE) then
  newvalue:=MIN_SCALE;
 if (newvalue>MAX_SCALE) then
  newvalue:=MAX_SCALE;
 FPreviewScale:=newvalue;
 prdriver.Scale:=FPreviewScale;
end;

procedure TRpPreviewMetaCLX.DoResize;
var
 AWidth:integeR;
 Aheight:integer;
begin
 AWidth:=Width-FBarWidth;
 AHeight:=Height-FBarHeight;

 if conteimage.Width>AWidth then
  conteimage.Left:=-HorzScrollBar.Position
 else
  conteimage.Left:=((AWidth-conteimage.Width) div 2)-HorzScrollBar.Position;
 if conteimage.Height>AHeight then
  conteimage.Top:=-VertScrollBar.Position
 else
  conteimage.Top:=((AHeight-conteimage.Height) div 2)-VertScrollBar.Position;
end;


type
 TPointF=record
  Width:double;
  Height:double;
 end;



procedure TRpPreviewMetaCLX.ReDrawPage;
var
 newwidth,newheight:integer;
 pagerows,pagecols:integer;
 intentirepcount:integer;
 asize,clients,newsize:TPointF;
 metapage:TRpMetafilePage;
 PhysicWidth,PhysicHeight:Integer;
 scalewide,scaleheight:double;
 scalev,scaleh:double;
 pagesequal:integer;
 intpagerowsv,intpagecolsv:integer;
 intpagerowsh,intpagecolsh:integer;
 pixelwidth,pixelheight:integer;
 dorefresh:boolean;
 pwidth,pheight:integer;
 pdrawn,x,y:integer;
 rec:TRect;

 procedure GetPhysicSize;
 begin
  if metapage.UpdatedPageSize then
  begin
   PhysicWidth:=metapage.PageSizeqt.PhysicWidth;
   PhysicHeight:=metapage.PageSizeqt.PhysicHeight;
  end
  else
  begin
   PhysicWidth:=FMetafile.CustomX;
   PhysicHeight:=FMetafile.CustomY;
  end;
 end;
begin
 if not Assigned(Parent) then
  exit;
 if not Assigned(FMetafile) then
  exit;
 if (FPage<0) then
  FPage:=0;
 if ((Width=0) or (Height=0)) then
  exit;
 if (FPage>=FMetafile.CurrentPageCount) then
 begin
  FMetafile.RequestPage(FPage+EntirePageCount);
  if (FPage>=FMetafile.CurrentPageCount) then
   FPage:=FMetafile.CurrentPageCount-1;
 end;
 metapage:=FMetafile.Pages[FPage];
 pagerows:=1;pagecols:=1;
 intentirepcount:=1;
 GetPhysicSize;
 clients.Width:=ClientWidth-FBarWidth;
 clients.Height:=ClientHeight-FBarHeight;
 asize.Width:=PhysicWidth*dpix/1440;
 asize.Height:=PhysicHeight*dpix/1440;
 case FAutoScale of
  AScaleHeight:
   begin
    scaleheight:=(clients.Height-FBarHeight)/asize.Height;
    ChangePreviewScale(scaleheight);
   end;
  AScaleReal:
   begin
    ChangePreviewScale(1.0);
   end;
  AScaleWide:
   begin
    scalewide:=(clients.Width-FBarWidth)/asize.Width;
    ChangePreviewScale(scalewide);
   end;
  AScaleEntirePage:
   begin
    if (FEntirePageCount>1) then
    begin
     FMetafile.RequestPage(FPage+FEntirePageCount);
     intentirepcount:=FMetafile.CurrentPageCount-FPage;
     if (intentirepcount>FEntirePageCount) then
      intentirepcount:=FEntirePageCount;
     if (intentirepcount<1) then
      intentirepcount:=1;
     // Look for diferent page sizes
     pagesequal:=1;
     while (pagesequal<intentirepcount) do
     begin
      metapage:=metafile.Pages[FPage+pagesequal];
      GetPhysicSize;
      newsize.Width:=PhysicWidth*dpix/1440;
      newsize.Height:=PhysicHeight*dpiy/1440;
      if ((newsize.Width<>asize.Width) or (newsize.Height<>asize.Height)) then
      begin
       intentirepcount:=pagesequal;
       break;
      end;
      pagesequal:=pagesequal+1;
     end;
    end;
    if (intentirepcount=1) then
    begin
     scalev:=clients.Height/asize.Height;
     scaleh:=clients.Width/asize.Width;
     if (scalev<scaleh) then
      ChangePreviewScale(scalev)
     else
      ChangePreviewScale(scaleh);
    end
    else
    begin
     // Determine how many pages will fit horizontal
     intpagerowsv:=0;
     intpagecolsv:=intentirepcount;
     repeat
      inc(intpagerowsv);
      scalev:=(clients.Height/intpagerowsv)/asize.Height;
      pixelwidth:=Trunc(asize.Width*scalev);
      if (pixelwidth<=0) then
      begin
       scalev:=0.0;
       break;
      end;
      intpagecolsv:=Trunc(clients.Width/pixelwidth);
     until not (((intpagecolsv*intpagerowsv)<intentirepcount) or  (intpagecolsv<0));
     while (((intpagecolsv-1)*intpagerowsv)>=intentirepcount) do
      Dec(intpagecolsv);
     while (intpagerowsv>intentirepcount) do
      Dec(intpagerowsv);
     intpagerowsh:=intentirepcount;
     intpagecolsh:=0;
     repeat
      Inc(intpagecolsh);
      scaleh:=(clients.Width/intpagecolsh)/asize.Width;
      pixelheight:=Trunc(asize.Height*scaleh);
      if (pixelheight<=0) then
      begin
       scaleh:=0.0;
       break;
      end;
      intpagerowsh:=Trunc(clients.Height/pixelheight);
     until (not  (((intpagecolsh*intpagerowsh)<intentirepcount) or (intpagerowsh<=0)));
     while (((intpagecolsh)*(intpagerowsh-1))>=intentirepcount) do
      Dec(intpagerowsh);
     while (intpagecolsh>intentirepcount) do
      Dec(intpagecolsh);
     if (scaleh>scalev) then
     begin
      pagerows:=intpagerowsh;
      pagecols:=intpagecolsh;
      scalev:=scaleh;
     end
     else
     begin
      pagerows:=intpagerowsv;
      pagecols:=intpagecolsv;
     end;
     if (pagecols<0) then
      pagecols:=1;
     if (pagerows<0) then
      pagerows:=1;
     ChangePreviewScale(scalev);
    end;
   end;
 end;
 dorefresh:=false;
 metapage:=FMetafile.Pages[FPage];
 GetPhysicSize;
 pwidth:=Trunc(PhysicWidth*FPreviewScale*dpix/1440);
 pheight:=Trunc(PhysicHeight*FPreviewScale*dpiy/1440);
 if (pwidth<=0) then
  pwidth:=2;
 if (pheight<=0) then
  pheight:=2;
 pagewidthdrawn:=pwidth;
 pageheightdrawn:=pheight;
 newwidth:=pwidth*pagecols;
 newheight:=pheight*pagerows;
 if ((newheight<>FBitmap.Height) or (newwidth<>FBitmap.Width)) then
 begin
  dorefresh:=true;
  FBitmap.free;
  FBitmap:=nil;
  FBitmap:=TBitmap.Create;
  FBitmap.PixelFormat:=pf32bit;
  FBitmap.Width:=newwidth;
  FBitmap.Height:=newheight;
  image.Picture.Bitmap:=FBitmap;
  image.Width:=newwidth;
  image.Height:=newheight;
 end
 else
 if ((FPageDrawn<>FPage) or (FScaleDrawn<>FPreviewScale) or (FPagesDrawn<>intentirepcount)) then
  dorefresh:=true;
 if (dorefresh) then
 begin
  FPagesDrawn:=intentirepcount;
  FBitmap.Canvas.Pen.Color:=Color;
  pagecolsdrawn:=pagecols;
  pagerowsdrawn:=pagerows;
  if (intentirepcount=1) then
  begin
   prdriver.DrawPage(FMetafile.Pages[FPage]);
   FBitmap.Canvas.Draw(0,0,prdriver.bitmap);
   FBitmap.Canvas.MoveTo(FBitmap.Width-1,0);
   FBitmap.Canvas.LineTo(FBitmap.Width-1,FBitmap.Height-1);
   FBitmap.Canvas.LineTo(0,FBitmap.Height-1);
   FBitmap.Canvas.MoveTo(FBitmap.Width-1,FBitmap.Height-1);
  end
  else
  begin
   if not Assigned(FIntBitmap) then
   begin
    FIntBitmap:=TBitmap.Create;
    FIntBitmap.PixelFormat:=pf32bit;
    FIntBitmap.Width:=pwidth;
    FIntBitmap.Height:=pheight;
   end
   else
   begin
    if ((FIntBitmap.Width<>pwidth) or (FIntBitmap.Height<>pheight)) then
    begin
     FIntBitmap:=TBitmap.Create;
     FIntBitmap.Width:=pwidth;
     FIntBitmap.Height:=pheight;
    end;
   end;
   pdrawn:=0;
   if (FEntireTopDown) then
   begin
    for x:=0 to pagecols-1 do
     for y:=0 to pagerows-1 do
     begin
      if (pdrawn<intentirepcount) then
      begin
       prdriver.DrawPage(FMetafile.Pages[FPage+pdrawn]);
       FBitmap.Canvas.Draw(x*pwidth,y*pheight,prdriver.bitmap);
       FBitmap.Canvas.MoveTo((x+1)*pwidth-1,y*pheight-1);
       FBitmap.Canvas.LineTo((x+1)*pwidth-1,(y+1)*pheight-1);
       FBitmap.Canvas.MoveTo((x)*pwidth-1,(y+1)*pheight-1);
       FBitmap.Canvas.LineTo((x+1)*pwidth-1,(y+1)*pheight-1);
      end
      else
      begin
       FBitmap.Canvas.Brush.Color:=Color;
       rec.Left:=x*pwidth;
       rec.Top:=y*pheight;
       rec.Right:=(x+1)*pwidth;
       rec.Bottom:=(y+1)*(pheight);
       FBitmap.Canvas.FillRect(rec);
      end;
      Inc(pdrawn);
     end;
   end
   else
   begin
    for y:=0 to pagerows-1 do
     for x:=0 to pagecols-1 do
     begin
      if (pdrawn<intentirepcount) then
      begin
       prdriver.DrawPage(FMetafile.Pages[FPage+pdrawn]);
       FBitmap.Canvas.Draw(x*pwidth,y*pheight,prdriver.bitmap);
       FBitmap.Canvas.MoveTo((x+1)*pwidth-1,y*pheight-1);
       FBitmap.Canvas.LineTo((x+1)*pwidth-1,(y+1)*pheight-1);
       FBitmap.Canvas.MoveTo((x)*pwidth-1,(y+1)*pheight-1);
       FBitmap.Canvas.LineTo((x+1)*pwidth-1,(y+1)*pheight-1);
      end
      else
      begin
        FBitmap.Canvas.Brush.Color:=Color;
        rec.Left:=x*pwidth;
        rec.Top:=y*pheight;
        rec.Right:=(x+1)*pwidth;
        rec.Bottom:=(y+1)*(pheight);
        FBitmap.Canvas.FillRect(rec);
      end;
      Inc(pdrawn);
     end;
   end;
  end;
  FPageDrawn:=FPage;
  FScaleDrawn:=FPreviewScale;
  image.Picture.Bitmap:=nil;
  image.Picture.Bitmap:=FBitmap;
  conteimage.Width:=image.Width;
  conteimage.Height:=image.Height;
 end;
 DoResize;
 if (dorefresh) then
 begin
  if Assigned(OnPageDrawn) then
   OnPageDrawn(self);
 end;
end;



procedure TRpPreviewMetaCLX.ResizeEvent(Sender:TObject);
begin
 ReDrawPage;
end;

procedure TRpPreviewMetaCLX.InternalMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
var
 offsetx,offsety:integer;
 newpagenum:integer;
 numrow,numcol:integer;
 posx,posy:integer;
begin
 if ((pagecolsdrawn<=0) or (pagerowsdrawn<=0)) then
  exit;
 if (FAutoScale<>AScaleEntirePage) then
 begin
  if (FOldPage>=0) then
   FPage:=FOldPage;
  AutoScale:=AScaleEntirePage;
  exit;
 end;
 FOldPage:=FPage;
 // Calculate the page number based on x/y position
 newpagenum:=FPage;
 numrow:=Trunc(Y/pageheightdrawn);
 numcol:=Trunc(X/pagewidthdrawn);
 offsetx:=Trunc((X-(numcol*pagewidthdrawn))/FPreviewScale);
 offsety:=Trunc((Y-(numrow*pageheightdrawn))/FPreviewScale);
 if (FEntireTopDown) then
 begin
  newpagenum:=newpagenum+numcol*pagerowsdrawn+numrow;
 end
 else
 begin
  newpagenum:=newpagenum+numrow*pagecolsdrawn+numcol;
 end;
 if (newpagenum>=FPage+PagesDrawn) then
  exit;
 FPage:=newpagenum;
 AutoScale:=AScaleReal;
 posy:=Trunc(offsety-(ClientHeight-Fbarheight)/2);
 posx:=Trunc(offsetx-(ClientWidth-Fbarwidth)/2);
 HorzScrollBar.Position:=posx;
 VertScrollBar.Position:=posy;
end;

procedure TRpPreviewMetaCLX.SetPage(avalue:integer);
var
 request:integer;
begin
 if Assigned(metafile) then
 begin
  request:=avalue+1;
  if (FAutoScale=AScaleEntirePage) then
   request:=avalue+FEntirePageCount-1;
  metafile.RequestPage(request);
 end;
 FPage:=avalue;
 ReDrawPage;
 FOldPage:=-1;
end;

procedure TRpPreviewMetaCLX.NextPage;
var
 increment,request:integer;
begin
 increment:=1;
 FOldPage:=-1;
 if (FAutoScale=AScaleEntirePage) then
 begin
  increment:=FPagesDrawn;
  request:=FPage+increment+FEntirePageCount;
 end
 else
  request:=FPage+increment+1;
 if Assigned(metafile) then
 begin
  metafile.RequestPage(request);
  if ((FPage+increment)<metafile.CurrentPageCount) then
  begin
   Page:=FPage+increment;
  end
  else
  begin
   if (FPage<>(metafile.CurrentPageCount-FPagesDrawn)) then
    Page:=metafile.CurrentpAGECount-1;
  end;
 end;
end;

procedure TRpPreviewMetaCLX.PriorPage;
var
 decrement:integer;
begin
 decrement:=1;
 FOldPage:=-1;
 if (FAutoScale=AScaleEntirePage) then
 begin
  decrement:=EntirePageCount;
 end;
 if ((FPage-decrement)<0) then
  Page:=0
 else
  Page:=FPage-decrement;
end;

procedure TRpPreviewMetaCLX.LastPage;
var
 newpage,decrement:integer;
begin
 FOldPage:=-1;
 if Assigned(metafile) then
 begin
  metafile.RequestPage(999999);
  newpage:=metafile.CurrentPageCount;
  decrement:=1;
  if (FAutoScale=AScaleEntirePage) then
  begin
   decrement:=EntirePageCount;
  end;
  if ((newpage-decrement)<0) then
   Page:=0
  else
   Page:=newpage-decrement;
 end;
end;

procedure TRpPreviewMetaCLX.FirstPage;
begin
 Page:=0;
end;

procedure TRpPreviewMetaCLX.SetParent(const AParent:TWidgetControl);
begin
 inherited SetParent(aparent);
 if aparent<>Parent then
  ReDrawPage;
end;

procedure TRpPreviewMetaCLX.RefreshPage;
begin
 FScaleDrawn:=-1.0;
 FPageDrawn:=-1;
 FOldPage:=-1;
 ReDrawPage;
end;

procedure TRpPreviewMetaCLX.SetOnWorkProgress(AValue:TMetaFileWorkProgress);
begin
 FOnWorkProgress:=AValue;
 if Assigned(metafile) then
  metafile.OnWorkProgress:=FOnWorkProgress;
end;

procedure TRpPreviewMetaCLX.Notification(AComponent:TComponent;Operation:TOperation);
begin
 inherited Notification(AComponent,Operation);
 if assigned(metafile) then
 begin
  if Operation=OpRemove then
  begin
   if (AComponent=metafile) then
   begin
    metafile:=nil;
   end;
  end;
 end;
end;

procedure TRpPreviewMetaCLX.RefreshMetafile;
var
 meta:TRpMetafileReport;
begin
 meta:=FMetafile;
 FMetafile:=nil;
 Metafile:=meta;
 RefreshPage;
end;

end.
