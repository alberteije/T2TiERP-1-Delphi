{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       Rpmdsectionint                                  }
{       Implementation of section designer              }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpmdfsectionint;


interface

{$I rpconf.inc}

uses SysUtils, Classes,Types,
  QGraphics, QForms,rpdbbrowser,QComCtrls,
  QButtons, QExtCtrls, QControls, QStdCtrls,
  rpmdobinsint,rpreport,rpprintitem,rpgraphutils,
  rpmdobjinsp,rpmdfstruc,rpmdflabelint,rplabelitem,
  rpmdconsts,rpsection,rptypes,rpdrawitem,rpmdfdrawint,
  rpsubreport,rpmdbarcode,rpmdchart,rpdatainfo,
{$IFDEF VCLANDCLX}
 rpvgraphutils,
{$ENDIF}
  rpmdfbarcodeint,rpmdfchartint,rppdffile;

const
 CONS_MINWIDTH=5;
 CONS_MINHEIGHT=5;
 MAX_DROP_SIZE=40;
type

  TRpSectionInterface=class;

  TRpSectionIntf=class(TCustomControl)
   private
    calledposchange:Boolean;
    secint:TRpSectionInterface;
    procedure DoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DoDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
     var Accept: Boolean);
   protected
    procedure Paint;override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
   public
    OnPosChange:TNotifyEvent;
    constructor Create(AOwner:TComponent);override;
   end;

  TRpSectionInterface=class(TRpSizeInterface)
   private
    FOnDestroy:TNotifyEvent;
    FInterface:TRpSectionIntf;
    FOnPosChange:TNotifyEvent;
    FXOrigin,FYOrigin:integer;
    FRectangle:TRpRectangle;
    FRectangle2:TRpRectangle;
    FRectangle3:TRpRectangle;
    FRectangle4:TRpRectangle;
    procedure SetOnPosChange(AValue:TNotifyEvent);
    procedure CalcNewCoords(var NewLeft,
     NewTop,NewWidth,NewHeight,X,Y:integer);
    function DoSelectControls(NewLeft,NewTop,NewWidth,NewHeight:integer):Boolean;
   protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure SetScale(nscale:double);override;
   public
    backbitmap:TBitmap;
    freportstructure:TFRpStructure;
    childlist:TList;
    procedure UpdateBack;
    procedure DoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure UpdatePos;override;
    property OnDestroy:TNotifyEvent read FOnDestroy write FOnDestroy;
    constructor Create(AOwner:TComponent;pritem:TRpCommonComponent);override;
    destructor destroy;override;
    procedure GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);override;
    procedure SetProperty(pname:string;value:Widestring);override;
    function GetProperty(pname:string):Widestring;override;
    procedure SetProperty(pname:string;stream:TMemoryStream);override;
    procedure GetProperty(pname:string;var Stream:TMemoryStream);override;
    procedure GetPropertyValues(pname:string;lpossiblevalues:TRpWideStrings);override;
    function CreateChild(compo:TRpCommonPosComponent):TRpSizePosInterface;
    procedure CreateChilds;
    procedure DeleteChild(achild:TRpSizePosInterface);
    procedure InvalidateAll;
    property OnPosChange:TNotifyEvent read FOnPosChange write SetOnPosChange;
    procedure DoDeleteComponent(aitem:TComponent);
  end;



procedure FreeGridBitmap;

implementation

uses rpmdfmain, rpmdfdesign;


const
 MIN_GRID_BITMAP_WITH=1024;
 MIN_GRID_BITMAP_HEIGHT=600;

var
 fbitmap:TBitmap;
 fbscale:double;
 fbwidth,fbheight:integer;
 fxgrid,fygrid:integer;
 fcolor:TColor;
 flines:boolean;



procedure FreeGridBitmap;
begin
 if Assigned(FBitmap) then
 begin
  fbitmap.free;
  fbitmap:=nil;
 end;
end;

function DrawBitmapGrid(width,height,xgrid,ygrid:integer;color:TColor;lines:boolean;scale:double):TBitmap;
var
 rec:TRect;
begin
 if ((width=0) or (height=0)) then
 begin
  Result:=nil;
  exit;
 end;
 try
   if ((width<0) or (height<0) or (xgrid<=0) or (ygrid<=0)) then
   begin
    Raise Exception.Create(SRpIncorrectCalltoDeawGrid);
   end;
   if Assigned(fbitmap) then
   begin
    if ((fbwidth>=width) and (fbheight>=height) and
     (fcolor=color) and (fxgrid=xgrid) and
     (fygrid=ygrid) and (flines=lines) and (fbscale=scale)) then
    begin
     Result:=fbitmap;
     exit;
    end;
   end;
   FreeGridBitmap;
   fbitmap:=TBitmap.Create;
   if width<MIN_GRID_BITMAP_WITH then
   begin
    width:=MIN_GRID_BITMAP_WITH;
   end;
   if height<MIN_GRID_BITMAP_HEIGHT then
   begin
    height:=MIN_GRID_BITMAP_HEIGHT;
   end;
   fBitmap.PixelFormat:=pf32bit;
   fbitmap.Width:=width;
   fbitmap.Height:=height;
   // Then draws the bitmap
   fbitmap.Canvas.Brush.Style:=bsSolid;
   rec.Top:=0;rec.Left:=0;
   rec.Right:=fbitmap.Width;
   rec.Bottom:=fbitmap.Height;
   fbitmap.Canvas.FillRect(rec);

   DrawGrid(fbitmap.Canvas,xgrid,ygrid,Width,Height,color,lines,0,0,scale);
   fbheight:=height;
   fbwidth:=width;
   fcolor:=color;
   flines:=lines;
   fygrid:=ygrid;
   fxgrid:=xgrid;
   fbscale:=scale;

   Result:=fbitmap;
 except
  FreeGridBitmap;
  Result:=nil;
 end;
end;


constructor TRpSectionInterface.Create(AOwner:TComponent;pritem:TRpCommonComponent);
var
 opts:TControlStyle;
begin
 if Not (pritem is TRpSection) then
  Raise Exception.Create(SRpIncorrectComponentForInterface);
 inherited Create(AOwner,pritem);
 opts:=ControlStyle;
 include(opts,csCaptureMouse);
 ControlStyle:=opts;
 ChildList:=TList.Create;
 FInterface:=TRpSectionIntf.Create(Self);
 Visible:=false;
 FInterface.secint:=Self;
end;


procedure TRpSectionInterface.SetScale(nscale:double);
var
 i:integer;
begin
 inherited SetScale(nscale);
 for i:=0 to childlist.count-1 do
 begin
  TRpSizeInterface(childlist.Items[i]).Scale:=nscale;
 end;
end;


destructor TRpSectionInterface.destroy;
begin
 if Assigned(FOnDestroy) then
 begin
  FOnDestroy(Self);
 end;
 childlist.free;
 inherited destroy;
end;


procedure TRpSectionInterface.SetOnPosChange(AValue:TNotifyEvent);
begin
 FOnPosChange:=AValue;
 FInterface.OnPosChange:=AValue;
end;


procedure TRpSectionInterface.GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);
begin
 inherited GetProperties(lnames,ltypes,lvalues,lhints,lcat);

 if (TrpSection(printitem).SectionType in [rpsecpfooter,rpsecpheader]) then
 begin
  lnames.Add(SRpGeneralPageHeader);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).Global,true));
 end;
 if (TrpSection(printitem).SectionType<>rpsecpfooter) then
 begin
  lnames.Add(SRpSAutoExpand);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).AutoExpand,true));
  lnames.Add(SRpSAutoContract);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).AutoContract,true));
 end;
 if (TrpSection(printitem).SectionType in [rpsecgheader,rpsecgfooter]) then
 begin
  lnames.Add(SRpIniNumPage);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).IniNumPage,true));

  lnames.Add(SRpSGroupName);
  ltypes.Add(SRpSString);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(TRpSection(printitem).GroupName);

  lnames.Add(SRpSGroupExpression);
  ltypes.Add(SRpSExpression);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(TRpSection(printitem).ChangeExpression);

  lnames.Add(SRpSChangeBool);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).ChangeBool,true));

  if TrpSection(printitem).SectionType=rpsecgheader then
  begin
   lnames.Add(SRpSPageRepeat);
   ltypes.Add(SRpSBool);
   lhints.Add('refsection.html');
   lcat.Add(SRpSection);
   if Assigned(lvalues) then
    lvalues.Add(BoolToStr(TRpSection(printitem).PageRepeat,true));
   lnames.Add(SRpSForcePrint);
   ltypes.Add(SRpSBool);
   lhints.Add('refsection.html');
   lcat.Add(SRpSection);
   if Assigned(lvalues) then
    lvalues.Add(BoolToStr(TRpSection(printitem).FooterAtReportEnd,true));
  end;
 end;
 if (TrpSection(printitem).SectionType in [rpsecgheader,rpsecgfooter,rpsecdetail]) then
 begin
  lnames.Add(SRpSBeginPage);
  ltypes.Add(SRpSExpression);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(TRpSection(printitem).BeginPageExpression);

  lnames.Add(SRpSkipPage);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).SkipPage,true));

  lnames.Add(SRPAlignBottom);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).AlignBottom,true));

  lnames.Add(SRPHorzDesp);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).HorzDesp,true));
  lnames.Add(SRPVertDesp);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).VertDesp,true));
  // Skip page expression
  lnames.Add(SRpSSkipType);
  ltypes.Add(SRpSList);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(RpSkipTypeToText(TRpSection(printitem).SkipType));
  lnames.Add(SRpSSkipToPage);
  ltypes.Add(SRpSExpression);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(TRpSection(printitem).SkipToPageExpre);
  lnames.Add(SRpSHSkipExpre);
  ltypes.Add(SRpSExpression);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(TRpSection(printitem).SkipExpreH);
  lnames.Add(SRpSHRelativeSkip);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).SkipRelativeH,true));
  lnames.Add(SRpSVSkipExpre);
  ltypes.Add(SRpSExpression);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(TRpSection(printitem).SkipExpreV);
  lnames.Add(SRpSVRelativeSkip);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).SkipRelativeV,true));
  // Child Subreport
  lnames.Add(SRpChildSubRep);
  ltypes.Add(SRpSList);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(TRpSection(printitem).GetChildSubReportName);
 end;
 if (TrpSection(printitem).SectionType in [rpsecpfooter,rpsecgheader]) then
 begin
  lnames.Add(SRpSForcePrint);
  ltypes.Add(SRpSBool);
  lhints.Add('refsection.html');
  lcat.Add(SRpSection);
  if Assigned(lvalues) then
   lvalues.Add(BoolToStr(TRpSection(printitem).FooterAtReportEnd,true));
 end;
 // External section
 lnames.Add(SRpSExternalPath);
 ltypes.Add(SRpSExternalpath);
 lhints.Add('refsection.html');
 lcat.Add(SRpSection);
 if Assigned(lvalues) then
  lvalues.Add(TRpSection(printitem).ExternalFilename);
 lnames.Add(SRpSExternalData);
 ltypes.Add(SRpSExternalData);
 lhints.Add('refsection.html');
 lcat.Add(SRpSection);
 if Assigned(lvalues) then
  lvalues.Add(TRpSection(printitem).GetExternalDataDescription);
 // Expression
 lnames.Add(SrpSBackExpression);
 ltypes.Add(SRpSExpression);
 lhints.Add('refsection.html');
 lcat.Add(SRpSection);
 if Assigned(lvalues) then
  lvalues.Add(TRpSection(printitem).BackExpression);
 // Image
 lnames.Add(SrpSImage);
 ltypes.Add(SRpSImage);
 lhints.Add('refsection.html');
 lcat.Add(SRpSection);
 if Assigned(lvalues) then
  lvalues.Add('['+FormatFloat('###,###0.00',TRpSection(printitem).Stream.Size/1024)+
  SRpKbytes+']');
 // DPI
 lnames.Add(SRpDPIRes);
 ltypes.Add(SRpSString);
 lhints.Add('refsection.html');
 lcat.Add(SRpSection);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpSection(printitem).DPIRes));
 // Back Style
 lnames.Add(SRpSBackStyle);
 ltypes.Add(SRpSList);
 lhints.Add('refsection.html');
 lcat.Add(SRpSection);
 // DrawStyle
 lnames.Add(SRpDrawStyle);
 ltypes.Add(SRpSList);
 lhints.Add('refsection.html');
 lcat.Add(SRpSection);
 if Assigned(lvalues) then
  lvalues.Add(RpDrawStyleToString(TRpSection(printitem).DrawStyle));
 // Cached
 lnames.Add(SRpCached);
 ltypes.Add(SRpSlIST);
 lhints.Add('refsection.html');
 lcat.Add(SRpSection);
 if Assigned(lvalues) then
  lvalues.Add(RpCachedImageToString(TRpSection(printitem).CachedImage));
end;

procedure TRpSectionInterface.SetProperty(pname:string;value:Widestring);
begin
 if ((pname=SRpSWidth) or (pname=SRpSHeight)) then
 begin
  UpdateBack;
 end;
 if pname=SRpGeneralPageHeader then
 begin
  TRpSection(fprintitem).Global:=StrToBool(Value);
  exit;
 end;
 if pname=SRpSExternalData then
 begin
  exit;
 end;
 if pname=SRpSAutoExpand then
 begin
  TRpSection(fprintitem).Autoexpand:=StrToBool(Value);
  exit;
 end;
 if pname=SRpSAutoContract then
 begin
  TRpSection(fprintitem).AutoContract:=StrToBool(Value);
  exit;
 end;
 if (TrpSection(printitem).SectionType in [rpsecgheader,rpsecgfooter]) then
 begin
  if pname=SRpIniNumPage then
  begin
   TRpSection(fprintitem).IniNumPage:=StrToBool(Value);
   exit;
  end;
  if pname=SRpSGroupName then
  begin
   TRpSection(fprintitem).groupname:=Value;
   exit;
  end;
  if pname=SRpSGroupExpression then
  begin
   TRpSection(fprintitem).ChangeExpression:=Value;
   exit;
  end;
  if pname=SRpSChangeBool then
  begin
   TRpSection(fprintitem).ChangeBool:=StrToBool(Value);
   exit;
  end;
  if pname=SRPSPageRepeat then
  begin
   TRpSection(fprintitem).PageRepeat:=StrToBool(Value);
   exit;
  end;
 end;
 if (TrpSection(printitem).SectionType in [rpsecgheader,rpsecgfooter,rpsecdetail]) then
 begin
  if pname=SRPSBeginPage then
  begin
   TRpSection(fprintitem).BeginPageExpression:=Value;
   exit;
  end;
  if pname=SRPSkipPage then
  begin
   TRpSection(fprintitem).SkipPage:=StrToBool(Value);
   exit;
  end;
  if pname=SRPAlignBottom then
  begin
   TRpSection(fprintitem).AlignBottom:=StrToBool(Value);
   exit;
  end;
  if pname=SRpHorzDesp then
  begin
   TRpSection(fprintitem).HorzDesp:=StrToBool(Value);
   exit;
  end;
  if pname=SRpVertDesp then
  begin
   TRpSection(fprintitem).VertDesp:=StrToBool(Value);
   exit;
  end;
  if pname=SRpSSkipType then
  begin
   TRpSection(fprintitem).SkipType:=StringToRpSkipType(Value);
   exit;
  end;
  if pname=SRpSSkipToPage then
  begin
   TRpSection(fprintitem).SkipToPageExpre:=Value;
   exit;
  end;
  if pname=SRpSHSkipExpre then
  begin
   TRpSection(fprintitem).SkipExpreH:=Value;
   exit;
  end;
  if pname=SRpSHRelativeSkip then
  begin
   TRpSection(fprintitem).SkipRelativeH:=StrToBool(Value);
   exit;
  end;
  if pname=SRpSVSkipExpre then
  begin
   TRpSection(fprintitem).SkipExpreV:=Value;
   exit;
  end;
  if pname=SRpSVRelativeSkip then
  begin
   TRpSection(fprintitem).SkipRelativeV:=StrToBool(Value);
   exit;
  end;
 end;
 if (TrpSection(printitem).SectionType in [rpsecpfooter,rpsecgheader]) then
 begin
  if pname=SRpSForcePrint then
  begin
   TRpSection(fprintitem).FooterAtReportEnd:=StrToBool(Value);
   exit;
  end;
 end;
 if pname=SRpChildSubRep then
 begin
  TRpSection(fprintitem).SetChildSubReportByName(Value);
  exit;
 end;
 if pname=SRpSExternalPath then
 begin
  TRpSection(fprintitem).ExternalFilename:=Trim(Value);
  exit;
 end;
 if pname=SRpSBackExpression then
 begin
  TRpSection(fprintitem).BackExpression:=Value;
  if Length(Trim(Value))>0 then
  begin
   TRpSection(fprintitem).Stream.SetSize(0);
  end;
  UpdateBack;
  exit;
 end; 
 if pname=SRpDPIRes then
 begin
  TRpSection(fprintitem).DPIRes:=StrToInt(Value);
  if TRpSection(fprintitem).DPIRes<=0 then
   TRpSection(fprintitem).DPIRes:=100;
  UpdateBack;
  exit;
 end;
 if pname=SRpSBackStyle then
 begin
  TRpSection(fprintitem).BackStyle:=StrToBackStyle(Value);
  exit;
 end;
 if pname=SRpDrawStyle then
 begin
  TRpSection(fprintitem).DrawStyle:=StringDrawStyleToDrawStyle(Value);
  UpdateBack;
  exit;
 end;
 if pname=SRpCached then
 begin
  TRpSection(fprintitem).CachedImage:=StringCachedImageToCachedImage(Value);
  invalidate;
  exit;
 end;

 
 inherited SetProperty(pname,value);
end;

function TRpSectionInterface.GetProperty(pname:string):Widestring;
begin
 if pname=SRpGeneralPageHeader then
 begin
  Result:=BoolToStr(TRpSection(fprintitem).Global,true);
  exit;
 end;
 if pname=SRpSAutoContract then
 begin
  Result:=BoolToStr(TRpSection(fprintitem).AutoContract,true);
  exit;
 end;
 if pname=SRpSAutoExpand then
 begin
  Result:=BoolToStr(TRpSection(fprintitem).AutoExpand,true);
  exit;
 end;
 if (TrpSection(printitem).SectionType in [rpsecgheader,rpsecgfooter]) then
 begin
  if pname=SRpIniNumPage then
  begin
   Result:=BoolToStr(TRpSection(printitem).IniNumPage,true);
   exit;
  end;
  if pname=SRpSGroupName then
  begin
   Result:=TRpSection(fprintitem).groupname;
   exit;
  end;
  if pname=SRpSGroupExpression then
  begin
   Result:=TRpSection(fprintitem).ChangeExpression;
   exit;
  end;
  if pname=SRpSChangeBool then
  begin
   Result:=BoolToStr(TRpSection(fprintitem).ChangeBool,true);
   exit;
  end;
  if pname=SRpSPageRepeat then
  begin
   Result:=BoolToStr(TRpSection(fprintitem).PageRepeat,true);
   exit;
  end;
 end;
 if (TrpSection(printitem).SectionType in [rpsecgheader,rpsecgfooter,rpsecdetail]) then
 begin
  if pname=SRPSBeginPage then
  begin
   Result:=TRpSection(fprintitem).BeginPageExpression;
   exit;
  end;
  if pname=SRPSkipPage then
  begin
   Result:=BoolToStr(TRpSection(fprintitem).SkipPage,true);
   exit;
  end;
  if pname=SRPAlignBottom then
  begin
   Result:=BoolToStr(TRpSection(fprintitem).AlignBottom,true);
   exit;
  end;
  if pname=SRPHorzDesp then
  begin
   Result:=BoolToStr(TRpSection(fprintitem).HorzDesp,true);
   exit;
  end;
  if pname=SRPVertDesp then
  begin
   Result:=BoolToStr(TRpSection(fprintitem).VertDesp,true);
   exit;
  end;
  if pname=SRpSSkipType then
  begin
   Result:=RpSkipTypeToText(TRpSection(fprintitem).SkipType);
   exit;
  end;
  if pname=SRpSSkipToPage then
  begin
   Result:=TRpSection(fprintitem).SkipToPageExpre;
   exit;
  end;
  if pname=SRpSHSkipExpre then
  begin
   Result:=TRpSection(fprintitem).SkipExpreH;
   exit;
  end;
  if pname=SRpSHRelativeSkip then
  begin
   Result:=BoolToStr(TRpSection(fprintitem).SkipRelativeH,true);
   exit;
  end;
  if pname=SRpSVSkipExpre then
  begin
   Result:=TRpSection(fprintitem).SkipExpreV;
   exit;
  end;
  if pname=SRpSVRelativeSkip then
  begin
   Result:=BoolToStr(TRpSection(fprintitem).SkipRelativeV,true);
   exit;
  end;
 end;
 if (TrpSection(printitem).SectionType=rpsecpfooter) then
 begin
  if pname=SRpSForcePrint then
  begin
   Result:=BoolToStr(TRpSection(fprintitem).FooterAtReportEnd,true);
   exit;
  end;
 end;
 if pname=SRpChildSubRep then
 begin
  Result:=TRpSection(fprintitem).GetChildSubReportName;
  exit;
 end;
 if pname=SRpSExternalPath then
 begin
  Result:=TRpSection(fprintitem).ExternalFileName;
  exit;
 end;
 if pname=SRpSExternalData then
 begin
  Result:=TRpSection(fprintitem).GetExternalDataDescription;
  exit;
 end;
 if pname=SrpSBackExpression then
 begin
  Result:=TRpSection(printitem).BackExpression;
  exit;
 end;
 if pname=SRpDPIRes then
 begin
  Result:=IntToStr(TRpSection(fprintitem).DPIRes);
  exit;
 end;
 if pname=SrpSImage then
 begin
  Result:='['+FormatFloat('###,###0.00',TRpSection(printitem).Stream.Size/1024)+
  SRpKbytes+']';
  exit;
 end;
 if pname=SRpSBackStyle then
 begin
  Result:=BackStyleToStr(TRpSection(fprintitem).BackStyle);
  exit;
 end;
 if pname=SrpDrawStyle then
 begin
  Result:=RpDrawStyleToString(TRpSection(printitem).DrawStyle);
  exit;
 end;
 if pname=SRpCached then
 begin
  Result:=RpCachedImageToString(TRpSection(fprintitem).CachedImage);
  exit;
 end;
 Result:=inherited GetProperty(pname);
end;


procedure TRpSectionInterface.SetProperty(pname:string;stream:TMemoryStream);
begin
 if pname=SrpSImage then
 begin
  TRpSection(printitem).Stream:=stream;
  if TRpSection(printitem).Stream.Size>0 then
   TrpSection(printitem).BackExpression:='';
  UpdateBack;
  exit;
 end;
 inherited SetProperty(pname,stream);
end;

procedure TRpSectionInterface.GetProperty(pname:string;var Stream:TMemoryStream);
begin
 if pname=SrpSImage then
 begin
  Stream:=TRpSection(printitem).Stream;
  exit;
 end;
 inherited GetProperty(pname,stream);
end;



procedure TRpSectionInterface.GetPropertyValues(pname:string;lpossiblevalues:TRpWideStrings);
begin
 if pname=SRpCached then
 begin
  GetCachedImageDescriptions(lpossiblevalues);
  exit;
 end;
 if pname=SRpSSkipType then
 begin
  GetSkipTypePossibleValues(lpossiblevalues);
  exit;
 end;
 if pname=SRpChildSubRep then
 begin
  TRpSection(printitem).GetChildSubReportPossibleValues(lpossiblevalues);
  exit;
 end;
 if pname=SRpSBackStyle then
 begin
  GetBackStyleDescriptions(lpossiblevalues);
  exit;
 end;
 if pname=SrpDrawStyle then
 begin
  GetDrawStyleDescriptions(lpossiblevalues);
  exit;
 end;

 inherited GetPropertyValues(pname,lpossiblevalues);
end;


constructor TRpSectionIntf.Create(AOwner:TComponent);
var
 opts:TControlStyle;
begin
 inherited Create(AOwner);

 opts:=ControlStyle;
 include(opts,csCaptureMouse);
 ControlStyle:=opts;
 OnDragOver:=DoDragOver;
 OnDragDrop:=DoDragDrop;
end;


procedure TRpSectionIntf.Paint;
var
 report:TRpReport;
 asection:TRpSection;
 rec:TRect;
 abitmap:TBitmap;
 astream:TMemoryStream;
 dodrawgrid:boolean;
 dpix,dpiy:Integer;
 errormessage:String;
{$IFDEF VCLANDCLX}
 bitmapwidth,bitmapheight:integer;
{$ENDIF}
begin
 if not assigned(secint) then
  exit;
 errormessage:='';
 rec.Top:=0;rec.Left:=0;
 rec.Bottom:=Height;
 rec.Right:=Width;
 Canvas.Brush.Color:=clwhite;
 Canvas.FillRect(rec);
 // Bug in WINDOWS when changing the size of a section
 // Remove this when clx updated
 if not calledposchange then
 begin
  calledposchange:=true;
  try
   if Assigned(OnPosChange) then
    OnPosChange(Self);
  finally
   calledposchange:=false;
  end;
 end;
 if Not Assigned(secint.fprintitem) then
  exit;
 if Not Assigned(secint.fprintitem.Report) then
  exit;
 report:=TRpReport(secint.fprintitem.Report);
 dodrawgrid:=report.GridVisible;
 asection:=TRpSection(secint.printitem);

 // Draw the image if possible
 if not assigned(secint.BackBitmap) then
 begin
  if ( (asection.Stream.Size>0) or (Length(Trim(asection.BackExpression))>0) ) then
  begin
   secint.backbitmap:=TBitmap.Create;
   try
    secint.backbitmap.PixelFormat:=pf32bit;
    astream:=TMemoryStream.Create;
    try
     asection.GetStream.Seek(0,soFromBeginning);
     astream.CopyFrom(asection.GetStream,asection.GetStream.Size);
     astream.Seek(0,soFromBeginning);
     secint.backbitmap.Height:=Height;
     secint.backbitmap.Width:=Width;
     secint.Canvas.Brush.Color:=clWhite;
     rec.Top:=0;rec.Left:=0;
     rec.Bottom:=Height;
     rec.Right:=Width;
     secint.backbitmap.Canvas.Brush.Color:=clwhite;
     secint.backbitmap.Canvas.FillRect(rec);
     abitmap:=TBitmap.Create;
     try
      abitmap.PixelFormat:=pf32bit;
 // Windows does not have support for jpeg in CLX
 {$IFDEF VCLANDCLX}
      if GetJPegInfo(astream,bitmapwidth,bitmapheight) then
      begin
       rpvgraphutils.JPegStreamToBitmapStream(astream);
      end;
 {$ENDIF}
      astream.Seek(0,soFromBeginning);
      abitmap.LoadFromStream(astream);

      rec.Top:=0;rec.Left:=0;
      rec.Bottom:=Height-1;rec.Right:=Width-1;

      // Draws it with the style
      dpix:=Screen.PixelsPerInch;
      dpiy:=Screen.PixelsPerInch;
      case TRpImageDrawStyle(asection.DrawStyle) of
       rpDrawFull:
        begin
         rec.Bottom:=round(abitmap.height/asection.dpires*dpiy)-1;
         rec.Right:=round(abitmap.width/asection.dpires*dpix)-1;
         secint.BackBitmap.Canvas.StretchDraw(rec,abitmap);
        end;
       rpDrawStretch:
        secint.BackBitmap.Canvas.StretchDraw(rec,abitmap);
       rpDrawCrop:
        begin
//       Crop Should cut graphic but it don't work
//         recsrc.Top:=0;
//         recsrc.Left:=0;
//         recsrc.Bottom:=Height-1;
//         recsrc.Right:=Width-1;
//         Canvas.CopyRect(rec,bitmap.canvas,recsrc);
         secint.BackBitmap.Canvas.Draw(0,0,abitmap);
        end;
       rpDrawTile:
        begin
         secint.BackBitmap.Canvas.TiledDraw(rec,abitmap);
        end;
      end;

     finally
      abitmap.free;
     end;
    finally
     astream.free;
    end;
    if dodrawgrid then
    begin
     // Draw
     DrawGrid(secint.backbitmap.Canvas,Report.GridWidth,Report.GridHeight,
      secint.backbitmap.width,secint.backbitmap.height,Report.GridColor,Report.GridLines,
       0,0,secint.scale);
      dodrawgrid:=false;
    end;
   except
    on E:Exception do
    begin
     secint.backbitmap.free;
     secint.backbitmap:=nil;
     errormessage:=SrpSInvBackImage+'-'+E.Message;
    end;
   end;
  end;
 end
 else
  dodrawgrid:=false;
 if assigned(secint.backbitmap) then
 begin
  Canvas.Draw(0,0,secint.backbitmap);
 end;
 if dodrawgrid then
 begin
  abitmap:=DrawBitmapGrid(width,height,report.GridWidth,report.GridHeight,report.GridColor,report.GridLines,secint.scale);
  if assigned(abitmap) then
  begin
   Canvas.Draw(0,0,abitmap);
  end;
 end;
 if Length(errormessage)>0 then
 begin
  Canvas.TextOut(0,0,errormessage);
 end;
end;

procedure TRpSectionIntf.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
 if MouseCapture then
  secint.MouseMove(Shift,X,Y);
end;

procedure TRpSectionIntf.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if MouseCapture then
  secint.MouseUp(Button,Shift,X,Y);
end;

procedure TRpSectionIntf.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
 secint.MouseDown(Button,Shift,X,Y);
end;

procedure TRpSectionInterface.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
 // Captures the origin X and Y
 FXOrigin:=X;
 FYOrigin:=Y;
 if Assigned(FRectangle) then
 begin
  FRectangle.free;
  FRectangle2.free;
  FRectangle3.free;
  FRectangle4.free;

  FRectangle:=nil;
 end;
end;

procedure TRpSectionInterface.CalcNewCoords(var NewLeft,
 NewTop,NewWidth,NewHeight,X,Y:integer);
var
 gridenabled:boolean;
 gridx,gridy:integer;
 FRpMainf:TFRpMainF;
begin
 gridenabled:=false;
 gridx:=1;
 gridy:=1;
 FRpMainf:=TFRpMainF(Owner.Owner);
 // There's a selected item insert it
 if Not FRpMainf.BArrow.Down then
 begin
  if FRpMainF.report.GridEnabled then
  begin
   GridEnabled:=True;
   GridX:=FRpMainf.Report.GridWidth;
   GridY:=FRpMainf.Report.GridHeight;
  end;
 end;
 if X<0 then
  X:=0;
 if Y<0 then
  Y:=0;
 if X>FXOrigin then
 begin
  NewLeft:=FXOrigin;
  if gridenabled then
   NewLeft:=AlignToGridPixels(NewLeft,GridX,Scale);
  NewWidth:=X-FXOrigin;
 end
 else
 begin
  NewLeft:=X;
  if gridenabled then
   NewLeft:=AlignToGridPixels(NewLeft,GridX,Scale);
  NewWidth:=FXOrigin-X;
 end;
 if Y>FYOrigin then
 begin
  NewTop:=FYOrigin;
  if gridenabled then
   NewTop:=AlignToGridPixels(NewTop,GridY,Scale);
  NewHeight:=Y-FYOrigin;
 end
 else
 begin
  NewTop:=Y;
  if gridenabled then
   NewTop:=AlignToGridPixels(NewTop,GridY,Scale);
  NewHeight:=FYOrigin-Y;
 end;
 if NewLeft+NewWidth>FInterface.Width then
  NewWidth:=FInterface.Width-NewLeft;
 if NewTop+NewHeight>FInterface.Height then
  NewHeight:=FInterface.Height-NewTop;
 // Align to grid width and height
 if GridEnabled then
  NewWidth:=AlignToGridPixels(NewLeft+NewWidth,GridX,Scale)-NewLeft;
 if GridEnabled then
  NewHeight:=AlignToGridPixels(NewTop+NewHeight,GridY,Scale)-NewTop;
 if NewHeight<CONS_MINHEIGHT then
  Newheight:=CONS_MINHEIGHT;
 if NewWidth<CONS_MINWIDTH then
  NewWidth:=CONS_MINWIDTH;
end;

procedure TRpSectionInterface.MouseMove(Shift: TShiftState; X, Y: Integer);
var NewLeft,
 NewTop,NewWidth,NewHeight:integer;
begin
 // Gets diference
 if Not Assigned(FRectangle) then
 begin
  if ((Abs(X-FXOrigin)<CONS_MINIMUMMOVE) AND
    (Abs(Y-FYOrigin)<CONS_MINIMUMMOVE)) then
    exit;
  // Creates the rectangle
  FRectangle:=TRpRectangle.Create(Self);
  FRectangle2:=TRpRectangle.Create(Self);
  FRectangle3:=TRpRectangle.Create(Self);
  FRectangle4:=TRpRectangle.Create(Self);

  FRectangle.Parent:=FInterface;
  FRectangle2.Parent:=FInterface;
  FRectangle3.Parent:=FInterface;
  FRectangle4.Parent:=FInterface;
  FInterface.Invalidate;
 end;
 CalcNewCoords(NewLeft,NewTop,NewWidth,NewHeight,X,Y);

 FRectangle.SetBounds(Newleft,NewTop,NewWidth,1);
 FRectangle2.SetBounds(Newleft,NewTop+NewHeight,NewWidth,1);
 FRectangle3.SetBounds(Newleft,NewTop,1,NewHeight);
 FRectangle4.SetBounds(Newleft+NewWidth,NewTop,1,NewHeight);
end;

function TRpSectionInterface.DoSelectControls(NewLeft,NewTop,NewWidth,NewHeight:integer):boolean;
var
 i:integer;
 aitem:TRpSizePosInterface;
 rec1,rec2:TRect;
 arec:Trect;
 fselitems:TStringList;
begin
 Result:=false;
 rec1.Left:=NewLeft;
 rec1.Top:=NewTop;
 rec1.Bottom:=NewTop+NewHeight;
 rec1.Right:=NewLeft+NewWidth;
 fselitems:=TFRpObjInsp(fobjinsp).SelectedItems;
 for i:=0 to childlist.Count-1 do
 begin
  aitem:=TRpSizePosInterface(childlist.Items[i]);
  if aitem.Visible then
  begin
   rec2.Left:=aitem.Left;
   rec2.Top:=aitem.Top;
   rec2.Bottom:=aitem.Top+aitem.Height;
   rec2.Right:=aitem.Left+aitem.Width;
   if IntersectRect(arec,Rec1,Rec2) then
   begin
    if not Result then
    begin
     if fselitems.count>0 then
      if (Not (fselitems.Objects[0] is TRpSizePosInterface)) then
       fselitems.Clear;
    end;
    if fselitems.IndexOfObject(aitem)<0 then
    begin
     fselitems.AddObject(aitem.classname,aitem);
    end;
    Result:=True;
   end;
  end;
 end;
 if Result then
 begin
  aitem:=TRpSizePosInterface(fselitems.Objects[0]);
  fselitems.Delete(0);
  TFRpObjInsp(fobjinsp).AddCompItem(aitem,false);
 end;
end;

procedure TRpSectionInterface.MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
var
 asizeposint:TRpSizePosInterface;
 asizepos:TRpCommonPosComponent;
 aitem:TRpCommonListItem;
 FRpMainf:TFRpMainF;
 NewLeft,NewTop,NewWidth,NewHeight:integer;
 theowner:TComponent;
begin
 inherited MouseDown(Button,Shift,X,Y);

 CalcNewCoords(NewLeft,NewTop,NewWidth,NewHeight,X,Y);
 if Assigned(FRectangle) then
 begin
  FRectangle.free;
  FRectangle2.free;
  FRectangle3.free;
  FRectangle4.free;
  FRectangle:=nil;
 end;
 FRpMainf:=TFRpMainF(Owner.Owner);
 // There's a selected item insert it
 if FRpMainf.BArrow.Down then
 begin
  // Selects object inspector section properties
  if (Not (ssshift in Shift)) then
   TFRpObjInsp(fobjinsp).ClearMultiSelect;
  if  Not DoSelectControls(NewLeft,NewTop,NewWidth,NewHeight) then
  begin
   freportstructure.SelectDataItem(printitem);
  end;
  exit;
 end;
 if TRpSection(printitem).IsExternal then
  theowner:=printitem
 else
  theowner:=printitem.Report;
 asizepos:=nil;
 asizeposint:=nil;
 if FRpMainf.BLabel.Down then
 begin
  asizepos:=TRpLabel.Create(theowner);
  TRpLabel(asizepos).Text:=SRpSampleTextToLabels;
  asizeposint:=TRpLabelInterface.Create(Self,asizepos);
 end;
 if FRpMainf.BExpression.Down then
 begin
  asizepos:=TRpExpression.Create(theowner);
  // Search if theres a selected field
  TRpExpression(asizepos).Expression:=FRpMainf.GetExpressionText;
  asizeposint:=TRpExpressionInterface.Create(Self,asizepos);
 end;
 if FRpMainf.BBarcode.Down then
 begin
  asizepos:=TRpBarcode.Create(theowner);
  // Search if theres a selected field
  TRpBarcode(asizepos).Expression:=FRpMainf.GetExpressionText;
  if (TRpBarcode(asizepos).Expression='2+2') then
   TRpBarcode(asizepos).Expression:=QuotedStr(SRpSampleBarCode);
  asizeposint:=TRpBarcodeInterface.Create(Self,asizepos);
 end;
 if FRpMainf.BChart.Down then
 begin
  asizepos:=TRpChart.Create(theowner);
  // Search if theres a selected field
  TRpChart(asizepos).ValueExpression:=FRpMainf.GetExpressionText;
  asizeposint:=TRpChartInterface.Create(Self,asizepos);
 end;
 if FRpMainf.BShape.Down then
 begin
  asizepos:=TRpShape.Create(theowner);
  asizeposint:=TRpDrawInterface.Create(Self,asizepos);
 end;
 if FRpMainf.BImage.Down then
 begin
  asizepos:=TRpImage.Create(theowner);
  asizeposint:=TRpImageInterface.Create(Self,asizepos);
 end;


 if Assigned(asizepos) then
 begin
  if asizepos is TRpGenTextComponent then
   FRpMainF.Report.AssignDefaultFontTo(TRpGenTextComponent(asizepos));
  asizepos.PosX:=pixelstotwips(NewLeft,Scale);
  asizepos.PosY:=pixelstotwips(NewTop,Scale);
  asizepos.Height:=pixelstotwips(NewHeight,Scale);
  asizepos.Width:=pixelstotwips(NewWidth,Scale);
  GenerateNewName(asizepos);
  aitem:=TRpSection(printitem).ReportComponents.Add;
  aitem.Component:=asizepos;
  asizeposint.Parent:=FInterface;
  asizeposint.Scale:=Scale;
  asizeposint.sectionint:=self;
  asizeposint.UpdatePos;
  asizeposint.fobjinsp:=fobjinsp;
  childlist.Add(asizeposint);
  if assigned(TFRpObjInsp(fobjinsp).Combo) then
  begin
   TFRpObjInsp(fobjinsp).Combo.Items.AddObject(asizepos.Name,asizeposint);
   TFRpObjInsp(fobjinsp).Combo.ItemIndex:=TFRpObjInsp(fobjinsp).Combo.Items.IndexOfObject(asizeposint);
  end;
  TFRpObjInsp(fobjinsp).AddCompItem(asizeposint,true);
  if (Not (SSShift in Shift)) then
   FRpMainf.BArrow.Down:=true;
 end;


end;

function TRpSectionInterface.CreateChild(compo:TRpCommonPosComponent):TRpSizePosInterface;
var
 labelint:TRpSizePosInterface;
begin
 labelint:=nil;
 if compo is TRpLabel then
 begin
  labelint:=TRpLabelInterface.Create(Self,compo);
 end;
 if compo is TRpExpression then
 begin
  labelint:=TRpExpressionInterface.Create(Self,compo);
 end;
 if compo is TRpBarcode then
 begin
  labelint:=TRpBarcodeInterface.Create(Self,compo);
 end;
 if compo is TRpChart then
 begin
  labelint:=TRpChartInterface.Create(Self,compo);
 end;
 if compo is TRpShape then
 begin
  labelint:=TRpDrawInterface.Create(Self,compo);
 end;
 if compo is TRpImage then
 begin
  labelint:=TRpImageInterface.Create(Self,compo);
 end;
 if Assigned(labelint) then
 begin
  labelint.Parent:=FInterface;
  labelint.Scale:=Scale;
  labelint.sectionint:=self;
  labelint.Visible:=compo.visible;
  labelint.UpdatePos;
  labelint.fobjinsp:=fobjinsp;
  childlist.Add(labelint)
 end;
 Result:=labelint;
end;

procedure TRpSectionInterface.DeleteChild(achild:TRpSizePosInterface);
var
 index:integer;
begin
 index:=childlist.IndexOf(achild);
 if index<0 then
  Raise Exception.Create(SRpNotFound);
 TObject(childlist.Items[index]).free;
 childlist.Delete(index);
end;

procedure TRpSectionInterface.CreateChilds;
var
 sec:TRpSection;
 i:integer;
 compo:TRpCommonPosComponent;
 labelint:TRpSizePosInterface;
begin
 sec:=TRpSection(printitem);
 for i:=0 to sec.ReportComponents.Count-1 do
 begin
  compo:=TRpCommonPosComponent(sec.ReportComponents.Items[i].Component);
  labelint:=nil;
  if compo is TRpLabel then
  begin
   labelint:=TRpLabelInterface.Create(Self,compo);
  end;
  if compo is TRpExpression then
  begin
   labelint:=TRpExpressionInterface.Create(Self,compo);
  end;
  if compo is TRpBarcode then
  begin
   labelint:=TRpBarcodeInterface.Create(Self,compo);
  end;
  if compo is TRpChart then
  begin
   labelint:=TRpChartInterface.Create(Self,compo);
  end;
  if compo is TRpShape then
  begin
   labelint:=TRpDrawInterface.Create(Self,compo);
  end;
  if compo is TRpImage then
  begin
   labelint:=TRpImageInterface.Create(Self,compo);
  end;
  if Assigned(labelint) then
  begin
   labelint.Parent:=FInterface;
   labelint.Scale:=Scale;
   labelint.sectionint:=self;
   labelint.Visible:=compo.visible;
   labelint.UpdatePos;
   labelint.fobjinsp:=fobjinsp;
   childlist.Add(labelint)
  end;
 end;
end;

procedure TRpSectionInterface.InvalidateAll;
var
 i:integer;
begin
 for i:=0 to childlist.count-1 do
 begin
  TRpSizeInterface(childlist.items[i]).Invalidate;
 end;
end;

procedure TRpSectionInterface.UpdatePos;
begin
 inherited UpdatePos;

 if Assigned(FInterface) then
 begin
  FInterface.SetBounds(Left,Top,Width,Height);
  FInterface.Parent:=Parent;
 end;
end;


procedure TRpSectionInterface.DoDeleteComponent(aitem:TComponent);
var
 i:integer;
begin
 for i:=0 to childlist.Count-1 do
 begin
  if TRpSizePosInterface(childlist.items[i]).printitem=aitem then
  begin
   TRpSizePosInterface(childlist.items[i]).Parent:=nil;
   TRpSizePosInterface(childlist.items[i]).Free;
   TRpSection(printitem).DeleteComponent(TRpCommonCOmponent(aitem));
  end;
 end;
end;


procedure TRpSectionInTf.DoDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
     var Accept: Boolean);
var
 anode:TTreeNode;
begin
 Accept:=false;
 if Source is TFRpBrowser then
 begin
  anode:=TFRpBrowser(Source).Atree.Selected;
  if Not assigned(anode) then
   exit;
  Accept:=true;
 end;
end;



procedure TRpSectionInTf.DoDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
 secint.DoDragDrop(Sender,Source,X,Y);
end;


function getmstring(asize:Integer):String;
var
 i:integer;
begin
 Result:='';
 for i:=1 to asize do
 begin
  Result:=Result+'x';
 end;
end;

procedure TRpSectionInterface.DoDragDrop(Sender, Source: TObject; X, Y: Integer);
var
 aitem:TRpCommonListItem;
 anode:TTreeNode;
 asizepos:TRpExpression;
 asizeposint:TRpExpressionInterface;
 fieldname:String;
 size:Integer;
 apoint:TPoint;
begin
 if Source is TFRpBrowser then
 begin
  anode:=TFRpBrowser(Source).Atree.Selected;
  if Not assigned(anode) then
   exit;
  if TRpSection(printitem).IsExternal then
   asizepos:=TRpExpression.Create(printitem)
  else
   asizepos:=TRpExpression.Create(printitem.Report);
  TRpReport(printitem.Report).AssignDefaultFontTo(TRpGenTextComponent(asizepos));
  // Search if theres a selected field
  // Search if theres a selected field
  size:=10;
  if (TObject(anode.Data) is TRpDBFieldInfo) then
   size:=TRpDBFieldInfo(anode.Data).FieldSize;
  fieldname:=ExtractFieldNameEx(anode.Text);
  TRpExpression(asizepos).Expression:=fieldname;
{$IFDEF MSWINDOWS}
  Canvas.Font.Name:=TRpExpression(asizepos).WFontName;
{$ENDIF}
{$IFDEF LINUX}
  Canvas.Font.Name:=TRpExpression(asizepos).LFontName;
{$ENDIF}
  Canvas.Font.Size:=TRpExpression(asizepos).FontSize;

  asizeposint:=TRpExpressionInterface.Create(Self,asizepos);

  asizeposint.Scale:=Scale;
  asizepos.PosX:=pixelstotwips(X,Scale);
  asizepos.PosY:=pixelstotwips(Y,Scale);

  apoint.y:=Canvas.TextHeight('Mg');
  if size<=MAX_DROP_SIZE then
  begin
   apoint.x:=Canvas.TextWidth(getmstring(size));
  end
  else
  begin
//   apoint.y:=Canvas.TextHeight('Mg')*((size div MAX_DROP_SIZE)+1);
   apoint.x:=Canvas.TextWidth(getmstring(MAX_DROP_SIZE));
  end;
  apoint.x:=pixelstotwips(apoint.x,Scale);
  apoint.y:=pixelstotwips(apoint.y,Scale);
  if asizepos.PosX+apoint.x>printitem.Width then
   apoint.x:=printitem.Width-asizepos.PosX;
//  if asizepos.PosY+apoint.y>printitem.Height then
//   apoint.y:=printitem.Height-asizepos.PosY;
  asizepos.Height:=Round(apoint.y*1.1);
  asizepos.Width:=apoint.x;

  GenerateNewName(asizepos);
  aitem:=TRpSection(printitem).ReportComponents.Add;
  aitem.Component:=asizepos;
  asizeposint.Parent:=FInterface;
  asizeposint.sectionint:=self;
  asizeposint.UpdatePos;
  asizeposint.fobjinsp:=fobjinsp;
  childlist.Add(asizeposint);
  if assigned(TFRpObjInsp(fobjinsp).Combo) then
  begin
   TFRpObjInsp(fobjinsp).Combo.Items.AddObject(asizepos.Name,asizeposint);
   TFRpObjInsp(fobjinsp).Combo.ItemIndex:=TFRpObjInsp(fobjinsp).Combo.Items.IndexOfObject(asizeposint);
  end;
  TFRpObjInsp(fobjinsp).AddCompItem(asizeposint,true);
 end;
end;

procedure TRpSectionInterface.UpdateBack;
begin
 if assigned(backbitmap) then
 begin
  backbitmap.Free;
  backbitmap:=nil;
 end;
 if assigned(parent) then
  FInterface.Invalidate;
end;

initialization
fbitmap:=nil;
fbwidth:=0;
fbheight:=0;
fcolor:=clBlack;

end.
