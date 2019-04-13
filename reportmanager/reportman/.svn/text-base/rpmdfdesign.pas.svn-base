{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfdesign                                     }
{       Design frame of the Main form                   }
{       Used by a subreport                             }
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

unit rpmdfdesign;

interface

{$I rpconf.inc}

uses
  SysUtils, Types, Classes,
  QGraphics, QControls, QForms, QDialogs, QMenus,
  QTypes, QExtCtrls,
  rpmdfstruc,rpmdobinsint,rpreport,rpmunits,rpgraphutils,
  rpmdfsectionint,rpsubreport,rpsection, rpruler,rpmdobjinsp;

const
 CONS_RULER_LEFT=20;
 CONS_RIGHTPWIDTH=6;

type

  // A ScrollBox that not scrolls in view focused controls
  TRpScrollBox=class(TScrollBox)
   protected
    procedure AutoScrollInView(AControl: TControl); override;
   end;

  TFRpDesignFrame=class;


  TRpPanelRight=Class(TPanel)
   private
    FFrame:TFRpDesignFrame;
    FRectangle:TRpRectanglew;
    FRectangle2:TRpRectanglew;
    FRectangle3:TRpRectanglew;
    FRectangle4:TRpRectanglew;
    FXOrigin,FYOrigin:integer;
    FBlocked:boolean;
   protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure Paint;override;
   public
    Section:TRpSection;
    constructor Create(AOwner:TComponent);override;
   end;

  TRpPaintEventPanel=Class(TPanel)
   private
    FOnPaint:TNotifyEvent;
    Updating:boolean;
    FFrame:TFRpDesignFrame;
    FXOrigin,FYOrigin:integer;
    FBlocked:boolean;
    allowselect:Boolean;
    FRectangle:TRpRectanglew;
    FRectangle2:TRpRectanglew;
    FRectangle3:TRpRectanglew;
    FRectangle4:TRpRectanglew;
   protected
    procedure Paint;override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
   public
    CaptionText:WideString;
    section:TRpSection;
    constructor Create(AOwner:TComponent);override;
    property OnPaint:TNotifyEvent read FOnPaint write FOnPaint;
   end;

  TFRpDesignFrame = class(TFrame)
    PTop: TPanel;
    PLeft: TPanel;
  private
    { Private declarations }
    panelheight:integer;
    PSection: TRpPaintEventPanel;
    FReport:TRpReport;
    FObjInsp:TFRpObjInsp;
    leftrulers:Tlist;
    FSubReport:TRpSubreport;
    toptitles:Tlist;
    righttitles:Tlist;
    FScale:double;
    procedure SetReport(Value:TRpReport);
    procedure SecPosChange(Sender:TObject);
    procedure SetScale(nvalue:double);
  public
    { Public declarations }
    freportstructure:TFRpStructure;
    SectionScrollBox: TScrollBox;
    secinterfaces:TList;
    TopRuler:TRpRuler;
    procedure InvalidateCaptions;
    procedure UpdateInterface(refreshobjinsp:boolean);
    procedure ShowAllHiden;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure UpdateSelection(force:boolean);
    procedure SelectSubReport(subreport:TRpSubReport);
    property Report:TRpReport read FReport write SetReport;
    property ObjInsp:TFRpObjInsp read FObjInsp write FObjInsp;
    property CurrentSubreport:TRpSubReport read FSubReport;
    property Scale:double read FScale write SetScale;
  end;


implementation

{$R *.xfm}
uses rpmdfmain;

procedure TrpScrollBox.AutoScrollInView(AControl: TControl);
begin

end;


constructor TrpPaintEventPanel.Create(AOwner:TComponent);
var
 opts:TControlStyle;
begin
 Inherited Create(AOwner);

 BevelInner:=bvNone;
 BevelOuter:=bvNone;
 BorderStyle:=bsNone;
 allowselect:=true;

 opts:=ControlStyle;
 include(opts,csCaptureMouse);
 ControlStyle:=opts;
end;


procedure TRpPaintEventPanel.Paint;
var
 rec:TRect;
 secint:TRpSectionInterface;
begin
 inherited Paint;

 if not updating then
 begin
  if Assigned(FOnPaint) then
   FOnPaint(Self);
 end;

 if not assigned(parent) then
  exit;

 Canvas.Brush.Color:=Color;

 secint:=nil;
 if FFrame.objinsp.SelectedItems.Count>0 then
  if (FFrame.ObjInsp.SelectedItems.Objects[0] is TRpSectionInterface) then
   secint:=TRpSectionInterface(FFrame.objinsp.CompItem)
  else
   secint:=TRpSectionInterface(TRpSizePosInterface(FFrame.objinsp.SelectedItems.Objects[0]).SectionInt);

 if assigned(Section) then
  if assigned(secint) then
   if section=secint.printitem then
    if allowselect then
     Canvas.Brush.Color:=clAppWorkSpace;
 rec:=ClientRect;
 Canvas.Rectangle(rec);
 if (parent.parent is TScrollBox) then
 begin
  Canvas.TextOut(TScrollBox(parent.parent).HorzScrollBar.Position,0,CaptionText);
 end;
end;



constructor TFRpDesignFrame.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 TopRuler:=TRpRuler.Create(Self);
 TopRuler.Rtype:=rHorizontal;
 TopRuler.Left:=20;
 TopRuler.Width:=389;
 TopRuler.Height:=20;
 TopRuler.Parent:=PTop;
 FScale:=1.0;

 panelheight:=Round(1.5*Font.Size/72*Screen.PixelsPerInch);
 SectionScrollBox:=TRpScrollBox.Create(Self);
 SectionScrollBox.BorderStyle:=bsNone;
 SectionScrollBox.Color:=clDisabledForeground;
 SectionScrollBox.Align:=Alclient;
 SectionScrollBox.HorzScrollBar.Tracking:=True;
 SectionScrollBox.VertScrollBar.Tracking:=True;
 SectionScrollBox.Parent:=Self;


 leftrulers:=Tlist.Create;
 toptitles:=Tlist.Create;
 righttitles:=Tlist.Create;
 secinterfaces:=TList.Create;

 PSection:=TRpPaintEventPanel.Create(Self);
 PSection.allowselect:=False;
 PSection.FFrame:=Self;
 PSection.Color:=clDisabledForeground;
 PSection.Parent:=SectionSCrollBox;
 PSection.OnPaint:=SecPosChange;
end;

destructor TFRpDesignFrame.Destroy;
begin
 leftrulers.free;
 toptitles.free;
 righttitles.free;
 secinterfaces.free;

 inherited Destroy;
end;


procedure TFRpDesignFrame.SetReport(Value:TRpReport);
begin
 FReport:=Value;
 if Not Assigned(FReport) then
  exit;
 SelectSubReport(Freport.SubReports[0].SubReport);
 UpdateSelection(false);
end;



procedure TFRpDesignFrame.UpdateSelection(force:boolean);
var
 data:Pointer;
 dataobj:TOBject;
 FSectionInterface:TRpSectionInterface;
 i:integer;
 asubreport:TRpSubReport;
begin
 if Not Assigned(freportstructure) then
  exit;
 if Not Assigned(freportstructure.RView.Selected) then
  exit;
 data:=freportstructure.RView.Selected.Data;
 if Not Assigned(data) then
  exit;
 if force then
 begin
  SelectSubReport(nil);
 end;

 dataobj:=TObject(data);
 // Looks if there is a subreport selected
 asubreport:=freportstructure.FindSelectedSubreport;
 if asubreport<>FSubReport then
 begin
  SelectSubReport(asubreport);
 end;
 if (dataobj is TRpSubReport) then
 begin
  if assigned(fobjinsp) then
  begin
   fobjinsp.AddCompItem(nil,true);
  end;
  exit;
 end;
 if (dataobj is TRpSection) then
 begin
  i:=0;
  FSectionInterface:=nil;
  while i<secinterfaces.count do
  begin
   if TRpSectionInterface(secinterfaces.items[i]).printitem=dataobj then
   begin
    FSectionInterface:=TRpSectionInterface(secinterfaces.items[i]);
    break;
   end;
   inc(i);
  end;
  if Assigned(FSectionInterface) then
   fobjinsp.AddCompItem(FSectionInterface,true);
 end;
(*{$IFDEF MSWINDOWS}
  Application.ProcessMessages;
{$ENDIF}
  SectionScrollBox.HorzScrollBar.Position:=0;
  SectionScrollBox.VertScrollBar.Position:=0;
{$IFDEF MSWINDOWS}
  if Assigned(FSectionInterface) then
   FSectionInterface.InvalidateAll;
{$ENDIF}
 end;
*)end;


procedure TFRpDesignFrame.SecPosChange(Sender:TObject);
var
 i:integer;
 aruler:TRpRuler;
 despy:integer;
 apanel:TRpPaintEventPanel;
begin
 TopRuler.Left:=CONS_RULER_LEFT-SectionScrollBox.HorzScrollBar.Position;;
 for i:=0 to leftrulers.count-1 do
 begin
  despy:=SectionScrollBox.VertScrollBar.Position;
  aruler:=TRpRuler(leftrulers.items[i]);
  aruler.Top:=TRpSectionInterface(secinterfaces.Items[i]).Top-despy;
  apanel:=TRpPaintEventPanel(toptitles.Items[i]);
  apanel.Updating:=true;
  try
   apanel.Invalidate;
   apanel.Update;
  finally
   apanel.Updating:=false;
  end;
 end;
end;


procedure TFRpDesignFrame.InvalidateCaptions;
var
 apanel:TRpPaintEventpanel;
 i:integer;
begin
 for i:=0 to toptitles.count-1 do
 begin
  apanel:=TRpPaintEventpanel(toptitles.Items[i]);
  if i<FSubReport.Sections.Count then
   apanel.CaptionText:=' '+FSubReport.Sections.Items[i].Section.SectionCaption(false);
  apanel.Invalidate;
 end;
end;


procedure TFRpDesignFrame.SelectSubReport(subreport:TRpSubReport);
var
 i:integer;
 asecint:TRpSectionInterface;
 apanel:TRpPaintEventpanel;
 rpanel:TRpPanelRight;
 aruler:TRpRuler;
 posx:integer;
 maxwidth:integer;
 oldsection:TRpSection;
begin
 // If subreport is not the same frees
 if Fsubreport=subreport then
  exit;
 oldsection:=nil;
 if assigned(fsubreport) then
 begin
  fobjinsp.ClearMultiselect;
  for i:=0 to secinterfaces.Count-1 do
  begin
   TRpSectionInterface(secinterfaces.Items[i]).Free;
   TPanel(TopTitles.Items[i]).Free;
   TPanel(RightTitles.Items[i]).Free;
   TRpRuler(LeftRulers.Items[i]).Free;
  end;
  TPanel(TopTitles.Items[secinterfaces.Count]).Free;
  secinterfaces.clear;
  toptitles.clear;
  righttitles.clear;
  leftrulers.Clear;
 end;
 Fsubreport:=subreport;
 FObjInsp.RecreateChangesize;
 fobjinsp.AddCompItem(nil,true);
 if not assigned(fsubreport) then
  exit;
 asecint:=nil;
 SectionScrollBox.Visible:=true;
 try
  maxwidth:=0;
  posx:=0;
  for i:=0 to fsubreport.Sections.Count-1 do
  begin
   apanel:=TRpPaintEventPanel.Create(self);
   apanel.FFrame:=Self;
   if i=0 then
    apanel.Cursor:=crArrow
   else
    apanel.Cursor:=crSizeNS;
   apanel.OnPaint:=SecPosChange;
   apanel.Height:=panelheight;
   apanel.Caption:='';
   apanel.CaptionText:=' '+FSubReport.Sections.Items[i].Section.SectionCaption(false);
   apanel.Alignment:=taLeftJustify;
   apanel.BorderStyle:=bsNone;
   apanel.BevelInner:=bvNone;
   apanel.BevelOuter:=bvNone;
   apanel.Top:=posx;
   apanel.section:=FSubReport.Sections.Items[i].Section;
   oldsection:=apanel.section;
   posx:=posx+apanel.Height;
   apanel.parent:=PSection;
   toptitles.Add(apanel);

   asecint:=TRpSectionInterface.Create(Self,fsubreport.Sections.Items[i].Section);
   asecint.Scale:=Scale;
   asecint.OnPosChange:=SecPosChange;
   asecint.fobjinsp:=FObjInsp;
   asecint.freportstructure:=freportstructure;
   asecint.Left:=0;
   asecint.Top:=posx;
   asecint.UpdatePos;
   asecint.Parent:=PSection;
   asecint.CreateChilds;
   asecint.UpdatePos;
   secinterfaces.Add(asecint);

   apanel.Width:=asecint.Width;

   rpanel:=TRpPanelRight.Create(self);
   rpanel.FFrame:=Self;
   rpanel.Height:=asecint.Height;
   rpanel.Left:=asecint.Width;
   rpanel.Caption:='';
   rpanel.Top:=posx;
   rpanel.Width:=CONS_RIGHTPWIDTH;
   rpanel.section:=oldsection;
   rpanel.parent:=PSection;
   righttitles.Add(rpanel);

   aruler:=TRpRuler.Create(Self);
   aruler.RType:=rVertical;
   aruler.Width:=20;
   aruler.Left:=0;
   aruler.Scale:=Scale;
   aruler.parent:=PLeft;
   leftrulers.Add(aruler);
   aruler.Top:=posx;
   aruler.Height:=asecint.Height;
   if rpmunits.defaultunit=rpUnitCms then
    aruler.Metrics:=rCms
   else
    aruler.Metrics:=rInchess;

   if maxwidth<asecint.width then
    maxwidth:=asecint.width;
   posx:=posx+asecint.Height;

  end;
  // Last panel for resizing only
  apanel:=TRpPaintEventPanel.Create(self);
  apanel.allowselect:=false;
  apanel.FFrame:=Self;
  apanel.Cursor:=crSizeNS;
  apanel.OnPaint:=SecPosChange;
  apanel.Height:=panelheight div 3;
  apanel.Caption:='';
  apanel.CaptionText:='';
  apanel.Alignment:=taLeftJustify;
  apanel.BorderStyle:=bsNone;
  apanel.BevelInner:=bvNone;
  apanel.BevelOuter:=bvNone;
  apanel.Top:=posx;
  apanel.width:=asecint.Width;
  apanel.section:=oldsection;
  posx:=posx+apanel.Height;
  apanel.parent:=PSection;
  toptitles.Add(apanel);

  for i:=0 to secinterfaces.Count-1 do
  begin
   asecint:=TRpSectionInterface(secinterfaces.items[i]);
   asecint.SendToBack;
  end;
  TopRuler.Width:=maxwidth*2+CONS_RIGHTPWIDTH;
  if rpmunits.defaultunit=rpUnitCms then
   TopRuler.Metrics:=rCms
  else
   TopRuler.Metrics:=rInchess;
  PSection.Height:=posx+Height;
  PSection.Width:=maxwidth*2+CONS_RIGHTPWIDTH;
 finally
  SectionScrollBox.Visible:=true;
 end;
 SectionScrollBox.VertScrollBar.Position:=0;
 SectionScrollBox.HorzScrollBar.Position:=0;
end;


procedure TFRpDesignFrame.UpdateInterface(refreshobjinsp:boolean);
var
 i,j:integer;
 asecint:TRpSectionInterface;
 apanel:TRpPaintEventpanel;
 rpanel:TRpPanelRight;
 aruler:TRpRuler;
 posx:integer;
 maxwidth:integer;
 oldxposition,oldyposition:integer;
begin
 if not Assigned(FSubreport) then
  exit;
 oldxposition:=SectionScrollBox.HorzScrollBar.Position;
 oldyposition:=SectionScrollBox.VertScrollBar.Position;
 SectionScrollBox.Visible:=true; // Set to false?
 try
  SectionScrollBox.HorzScrollBar.Position:=0;
  SectionScrollBox.VertScrollBar.Position:=0;
  maxwidth:=0;
  posx:=0;
  asecint:=nil;
  for i:=0 to secinterfaces.Count-1 do
  begin
   apanel:=TRpPaintEventpanel(toptitles.Items[i]);
   asecint:=TRpSectionInterface(secinterfaces.items[i]);
   asecint.UpdateBack;
   rpanel:=TRpPanelRight(Righttitles.Items[i]);

   apanel.Width:=asecint.Width;
   apanel.Caption:='';
   apanel.CaptionText:=' '+FSubReport.Sections.Items[i].Section.SectionCaption(false);
   apanel.Top:=posx;
   posx:=posx+apanel.Height;

   asecint.Top:=posx;
   asecint.UpdatePos;
   for j:=0 to asecint.childlist.Count-1 do
   begin
    TRpSizePosInterface(asecint.childlist.Items[j]).UpdatePos;
   end;
   apanel.Width:=asecint.Width;

   rpanel.Top:=posx;
   rpanel.Height:=asecint.Height;
   rpanel.Left:=asecint.Width;

   aruler:=TRpRuler(leftrulers.items[i]);
   aruler.Top:=posx;
   aruler.Height:=asecint.Height;
   if rpmunits.defaultunit=rpUnitCms then
    aruler.Metrics:=rCms
   else
    aruler.Metrics:=rInchess;

   if maxwidth<asecint.width then
    maxwidth:=asecint.width;
   posx:=posx+asecint.Height;
   asecint.SendToBack;
   if ObjInsp.CompItem=asecint then
    if refreshobjinsp then
     ObjInsp.AddCompItem(asecint,true);
  end;
  apanel:=TRpPaintEventpanel(toptitles.Items[secinterfaces.Count]);
  apanel.Width:=asecint.Width;
  apanel.Caption:='';
  apanel.Top:=posx;
  posx:=posx+apanel.Height;

  TopRuler.Width:=maxwidth*2+CONS_RIGHTPWIDTH;
  if rpmunits.defaultunit=rpUnitCms then
   TopRuler.Metrics:=rCms
  else
   TopRuler.Metrics:=rInchess;
 finally
  SectionScrollBox.Visible:=true;
 end;
 SectionScrollBox.HorzScrollBar.Position:=oldxposition;
 SectionScrollBox.VertScrollBar.Position:=oldyposition;
 PSection.Height:=posx+Height;
 PSection.Width:=maxwidth*2+CONS_RIGHTPWIDTH;
 SectionScrollBox.HorzScrollBar.Position:=0;
 SectionScrollBox.VertScrollBar.Position:=0;
end;

procedure TFRpDesignFrame.ShowAllHiden;
var
 asecint:TRpSectionInterface;
 aposint:TRpSizePosInterface;
 i,j:integer;
begin
 for i:=0 to secinterfaces.Count-1 do
 begin
  asecint:=TRpSectionInterface(secinterfaces.items[i]);
  for j:=0 to asecint.childlist.Count-1 do
  begin
   aposint:=TRpSizePosInterface(asecint.childlist.items[j]);
   aposint.Visible:=true;
   aposint.PrintItem.Visible:=true;
  end;
 end;
end;


procedure TRpPaintEventPanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
 inherited MouseDown(Button,Shift,X,Y);

 if cursor<>crSizeNS then
  exit;
 if Not Assigned(FRectangle) then
 begin
  FRectangle:=TRpRectanglew.Create(Self);
  FRectangle2:=TRpRectanglew.Create(Self);
  FRectangle3:=TRpRectanglew.Create(Self);
  FRectangle4:=TRpRectanglew.Create(Self);

  FRectangle.SetBounds(Left,Top,Width,1);
  FRectangle2.SetBounds(Left,Top+Height,Width,1);
  FRectangle3.SetBounds(Left,Top,1,Height);
  FRectangle4.SetBounds(Left+Width,Top,1,Height);

  FRectangle.Parent:=Parent;
  FRectangle2.Parent:=Parent;
  FRectangle3.Parent:=Parent;
  FRectangle4.Parent:=Parent;
 end;


 FXOrigin:=X;
 FYOrigin:=Y;
 FBlocked:=True;
end;

procedure TRpPaintEventPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
 NewLeft,NewTop:integer;
 i,MaxY:integer;
begin
 inherited MouseMove(Shift,X,Y);

 if MouseCapture then
 begin
  if ((Abs(X-FXOrigin)>CONS_MINIMUMMOVE) OR
    (Abs(Y-FYOrigin)>CONS_MINIMUMMOVE)) then
     FBlocked:=False;

  if Assigned(FRectangle) AND (Not FBlocked) then
  begin
   // Look the last panel
   i:=0;
   while i<FFrame.toptitles.count do
   begin
    if FFrame.toptitles.Items[i]=Self then
    begin
     dec(i);
     break;
    end;
    inc(i);
   end;
   MaxY:=TRpPaintEventPanel(FFrame.toptitles.Items[i]).Top+
    TRpPaintEventPanel(FFrame.toptitles.Items[i]).Height;

   NewLeft:=0;
   NewTop:=Top-FYOrigin+Y;
   if NewTop<0 then
    NewTop:=0;
   if NewTop+Height>Parent.Height then
    NewTop:=Parent.Height-Height;
   if NewTop<0 then
    NewTop:=0;
   if NewTop<MaxY then
    NewTop:=MaxY;
   FRectangle.SetBounds(Newleft,NewTop,Parent.Width,1);
   FRectangle2.SetBounds(Newleft,NewTop+Height,Parent.Width,1);
   FRectangle3.SetBounds(Newleft,NewTop,1,Height);
   FRectangle4.SetBounds(Newleft+Parent.Width,NewTop,1,Height);
   FRectangle.Parent.Update;
  end;
 end;
end;

procedure TRpPaintEventPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 NewTop:integer;
 i,MaxY:integer;
 asection:TRpSection;
 dframe:TFRpDesignFrame;
begin
 inherited MouseUp(Button,Shift,X,Y);

 if Assigned(FRectangle) then
 begin
  FRectangle.Free;
  FRectangle:=nil;
  FRectangle2.Free;
  FRectangle:=nil;
  FRectangle3.Free;
  FRectangle:=nil;
  FRectangle4.Free;
  FRectangle:=nil;


  // Look the last panel
  i:=0;
  while i<FFrame.toptitles.count do
  begin
   if FFrame.toptitles.Items[i]=Self then
   begin
    dec(i);
    break;
   end;
   inc(i);
  end;
  MaxY:=TRpPaintEventPanel(FFrame.toptitles.Items[i]).Top+
   TRpPaintEventPanel(FFrame.toptitles.Items[i]).Height;
  asection:=TRpPaintEventPanel(FFrame.toptitles.Items[i]).Section;
  // New position
  NewTop:=Top-FYOrigin+Y;
  if NewTop<0 then
   NewTop:=0;
  if NewTop+Height>Parent.Height then
   NewTop:=Parent.Height-Height;
  if NewTop<MaxY then
   NewTop:=MaxY;
  // Resize with the diference
  if NewTop<>Top then
  begin
   asection.Height:=pixelstotwips(NewTop-MaxY,FFrame.Scale);
   if asection.Height=0 then
    asection.Height:=0;
   FFrame.UpdateInterface(true);
  end;
 end;
 if allowselect then
 begin
  dframe:=TFRpDesignFrame(Owner);
  dframe.freportstructure.SelectDataItem(section);
 end;
end;

constructor TRpPanelRight.Create(AOwner:TComponent);
var
 opts:TControlStyle;
begin
 inherited Create(AOwner);

 BevelInner:=bvNone;
 BevelOuter:=bvNone;
 BorderStyle:=bsNone;
 Cursor:=crSizeWE;

 opts:=ControlStyle;
 include(opts,csCaptureMouse);
 ControlStyle:=opts;
end;

procedure TRpPanelRight.Paint;
var
 rec:TRect;
begin
 inherited Paint;

 if not assigned(parent) then
  exit;

 rec:=ClientRect;
 Canvas.Brush.Color:=Color;

 Canvas.Rectangle(rec);
end;


procedure TRpPanelRight.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
 if Not Assigned(FRectangle) then
 begin
  FRectangle:=TRpRectanglew.Create(Self);
  FRectangle2:=TRpRectanglew.Create(Self);
  FRectangle3:=TRpRectanglew.Create(Self);
  FRectangle4:=TRpRectanglew.Create(Self);

  FRectangle.SetBounds(Left,Top,Width,1);
  FRectangle2.SetBounds(Left,Top+Height,Width,1);
  FRectangle3.SetBounds(Left,Top,1,Height);
  FRectangle4.SetBounds(Left+Width,Top,1,Height);

  FRectangle.Parent:=Parent;
  FRectangle2.Parent:=Parent;
  FRectangle3.Parent:=Parent;
  FRectangle4.Parent:=Parent;
 end;


 FXOrigin:=X;
 FYOrigin:=Y;
 FBlocked:=True;
end;

procedure TRpPanelRight.MouseMove(Shift: TShiftState; X, Y: Integer);
var
 NewLeft,NewTop:integer;
begin
 inherited MouseMove(Shift,X,Y);

 if MouseCapture then
 begin
  if ((Abs(X-FXOrigin)>CONS_MINIMUMMOVE) OR
    (Abs(Y-FYOrigin)>CONS_MINIMUMMOVE)) then
     FBlocked:=False;

  if Assigned(FRectangle) AND (Not FBlocked) then
  begin
   NewLeft:=Left-FXOrigin+X;
   NewTop:=Top;
   if NewLeft<0 then
    NewLeft:=0;
   FRectangle.SetBounds(Newleft,NewTop,Width,1);
   FRectangle2.SetBounds(Newleft,NewTop+Height,Width,1);
   FRectangle3.SetBounds(Newleft,NewTop,1,Height);
   FRectangle4.SetBounds(Newleft+Width,NewTop,1,Height);
   FRectangle.Parent.Update;
  end;
 end;
end;

procedure TRpPanelRight.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 NewLeft:integer;
begin
 inherited MouseUp(Button,Shift,X,Y);

 if Assigned(FRectangle) then
 begin
  FRectangle.Free;
  FRectangle:=nil;
  FRectangle2.Free;
  FRectangle:=nil;
  FRectangle3.Free;
  FRectangle:=nil;
  FRectangle4.Free;
  FRectangle:=nil;
  // New position
  NewLeft:=Left-FXOrigin+X;
  if NewLeft<0 then
   NewLeft:=0;
  if NewLeft+Width>Parent.Width then
   NewLeft:=Parent.Width-Width;
  if NewLeft<0 then
   NewLeft:=0;

  section.Width:=pixelstotwips(NewLeft,FFrame.Scale);

  FFrame.UpdateInterface(true);
 end;
end;

procedure TFRpDesignFrame.SetScale(nvalue:double);
var
 i:integer;
 subrep:TRpSubReport;
begin
 FScale:=nvalue;
 TopRuler.Scale:=FScale;
 for i:=0 to leftrulers.Count-1 do
 begin
  TRpRuler(leftrulers.Items[i]).Scale:=FScale;
 end;
 if Assigned(FReport) then
 begin
  subrep:=CurrentSubReport;
  SelectSubReport(nil);
  SelectSubReport(subrep);
 end;
end;


end.
