{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       Rpmdobjinspvcl                                  }
{                                                       }
{       Object inspector frame                          }
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

unit rpmdobjinspvcl;

interface

{$I rpconf.inc}

uses
  SysUtils,rptypes,
{$IFDEF USEVARIANTS}
  Types,Variants,
{$ENDIF}
{$IFDEF USETNTUNICODE}
  TntStdCtrls,
{$ENDIF}
  Classes,rppdfdriver, Dialogs, ExtDlgs, Menus, rpalias,
  Windows,Graphics, Controls, Forms,ExtCtrls,StdCtrls,
  rpmdobinsintvcl,rpmdconsts,rpprintitem,comctrls,
  rpgraphutilsvcl,rpsection,rpmunits, rpexpredlgvcl,rpmdfextsecvcl,
{$IFDEF EXTENDEDGRAPHICS}
 rpgraphicex,jpeg,
{$ENDIF}
  rpreport,rpsubreport,rpmdflabelintvcl,rplabelitem,
  rpmdfdrawintvcl,rpmdfbarcodeintvcl,rpmdfchartintvcl,
  rpmaskedit,rpmetafile;

const
  CONS_LEFTGAP=3;
  CONS_CONTROLPOS=87;
  CONS_LABELTOPGAP=2;
  CONS_RIGHTBARGAP=1;
  CONS_BUTTONWIDTH=15;
  CONS_MINWIDTH=160;
type
  TRpPanelObj=class;
  
  TFRpObjInspVCL = class(TFrame)
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    RpAlias1: TRpAlias;
    PopUpSection: TPopupMenu;
    MLoadExternal: TMenuItem;
    MSaveExternal: TMenuItem;
    OpenDialog1: TOpenPictureDialog;
    procedure MLoadExternalClick(Sender: TObject);
  private
    { Private declarations }
    FProppanels:TStringList;
    FDesignFrame:TObject;
    FSelectedItems:TStringList;
    FCommonObject:TRpSizePosInterface;
    FClasses,FClassAncestors:TStringList;
    procedure AddCompItemPos(aitem:TRpSizePosInterface;onlyone:boolean);
    procedure SetCompItem(Value:TRpSizeInterface);
    function FindPanelForClass(acompo:TRpSizeInterface):TRpPanelObj;
    function CreatePanel(acompo:TRpSizeInterface):TRpPanelObj;
    function GetComboBox:TComboBox;
    procedure ChangeSizeChange(Sender:TObject);
    function GetCompItem:TRpSizeInterface;
    function GetCurrentPanel:TRpPanelObj;
    function GetCommonClassName:String;
    function FindCommonClass(baseclass,newclass:String):String;
  public
    { Public declarations }
    fchangesize:TRpSizeModifier;
    procedure ClearMultiSelect;
    procedure InvalidatePanels;
    procedure SelectProperty(propname:string);
    procedure RecreateChangeSize;
    procedure SelectAllClass(classname:string);
    procedure AddCompItem(aitem:TRpSizeInterface;onlyone:boolean);
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure AlignSelected(direction:integer);
    procedure MoveSelected(direction:integer;fast:boolean);
    property CompItem:TRpSizeInterface read GetCompItem;
    property DesignFrame:TObject read FDesignFrame write FDesignFrame;
    property Combo:TComboBox read GetComboBox;
    property SelectedItems:TStringList read FSelectedItems;
  end;

  TRpPageObj=class(TTabSheet)
   public
    PRight,PLeft,PParent:TPanel;
    AScrollBox:TScrollBox;
    PosY:Integer;
   end;

  TRpPanelObj=class(TPanel)
   private
    fpdfdriver:TRpPDFDriver;
    FCompItem:TRpSizeInterface;
    FSelectedItems:TStringList;
    subrep:TRpSubreport;
    LNames:TRpWideStrings;
    LTypes:TRpWideStrings;
    LValues:TRpWideStrings;
    LHints:TRpWideStrings;
    LCat:TRpWideStrings;
    combo:TComboBox;
    LLabels:TList;
    LControls:TStringList;
    LControls2:TStringList;
    AList:TStringList;
    // Alias for report datasets
    comboalias:TComboBox;
    comboprintonly:TComboBox;
    LPages:TStringList;
    FPControl:TPAgeControl;
    procedure ComboObjectChange(Sender:TObject);
    procedure EditChange(Sender:TObject);
    procedure SendToBackClick(Sender:TObject);
    procedure BringToFrontClick(Sender:TObject);
    procedure ShapeMouseUp(Sender: TObject; Button: TMouseButton;
     Shift: TShiftState; X, Y: Integer);
    procedure FontClick(Sender:TObject);
    procedure ExtClick(Sender:TObject);
    procedure ImageClick(Sender:TObject);
    procedure ImageKeyDown(Sender: TObject;
     var Key: Word; Shift: TShiftState);
    procedure ExpressionClick(Sender:TObject);
//    procedure  Subreportprops;
    procedure ComboAliasChange(Sender:TObject);
    procedure ComboPrintOnlyChange(Sender:TObject);
    procedure UpdatePosValues;
    procedure CreateControlsSubReport;
    procedure SelectProperty(propname:string);
    procedure SetPropertyFull(propname:string;value:Widestring);overload;
    procedure SetPropertyFull(propname:string;stream:TMemoryStream);overload;
    procedure DupValue(Sender:TControl);
   public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure CreateControls(acompo:TRpSizeInterface);
    procedure LabelMouseDown(Sender:TObject;
     Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AssignPropertyValues;
  end;



implementation

{$R *.dfm}

uses rpmdfdesignvcl,rpmdfsectionintvcl, rpmdfmainvcl;




function FindClassName(acompo:TRpSizeInterface):string;
var
 asec:TRpSection;
begin
 if not assigned(acompo) then
 begin
  Result:='TRpSubReport';
  exit;
 end;
 if acompo is TRpSectionInterface then
 begin
  asec:=TrpSection(TRpSectionInterface(acompo).printitem);
  Result:=asec.Name;
  case asec.SectionType of
   rpsecgheader:
    Result:='TRpSectionGroupHeader';
   rpsecgfooter:
    Result:='TRpSectionGroupFooter';
   rpsecdetail:
    Result:='TRpSectionDetail';
   rpsecpheader:
    Result:='TRpSectionPageHeader';
   rpsecpfooter:
    Result:='TRpSectionPageFooter';
  end;
 end
 else
 begin
  Result:=acompo.ClassName;
 end;
end;


procedure TrpPanelObj.LabelMouseDown(Sender:TObject;
     Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 FRpMainf:TFRpMainFVCL;
begin
 FRpMainf:=TFRpMainFVCL(Owner.Owner);
 FRpMainf.ShowDoc(TLabel(Sender).Hint);
end;

// Creates an object inspector panel for the component
procedure TrpPanelObj.CreateControlsSubReport;
var
 alabel:TLabel;
 posy:integer;
 totalwidth:integer;
 AScrollBox:TScrollBox;
 PParent:TPanel;
 PLeft:TPanel;
 PRight:TPanel;
 Psplit:TSplitter;
begin
 AScrollBox:=TScrollBox.Create(Self);
 AScrollBox.Align:=alClient;
 AScrollBox.HorzScrollBar.Tracking:=True;
 AScrollBox.VertScrollBar.Tracking:=True;
 AScrollBox.BorderStyle:=bsNone;
 AScrollBox.Parent:=Self;

 PParent:=TPanel.Create(Self);
 PParent.Left:=0;
 PParent.Width:=0;
 PParent.Parent:=AScrollBox;
 PPArent.BorderStyle:=bsNone;
 PParent.BevelInner:=bvNone;
 PParent.BevelOuter:=bvNone;
 PParent.Align:=AlTop;
 PParent.Parent:=AScrollBox;

 PLeft:=TPanel.Create(Self);
 PLeft.Width:=CONS_CONTROLPOS;
 PLeft.BorderStyle:=bsNone;
 PLeft.BevelInner:=bvNone;
 PLeft.BevelOuter:=bvNone;
 PLeft.Align:=AlLeft;
 PLeft.Parent:=PParent;

 Psplit:=TSplitter.Create(Self);
 Psplit.ResizeStyle:=rsUpdate;
 Psplit.Cursor:=crHSplit;
 PSplit.MinSize:=10;
 PSplit.Beveled:=True;
 PSplit.Width:=4;
 PSplit.Left:=PLeft.Width+10;
 Psplit.Align:=Alleft;
 PSplit.Parent:=PParent;

 PRight:=TPanel.Create(Self);
 PRight.Width:=CONS_CONTROLPOS+7;
 PRight.BorderStyle:=bsNone;
 PRight.BevelInner:=bvNone;
 PRight.BevelOuter:=bvNone;
 PRight.Align:=AlClient;
 PRight.Parent:=PParent;

 totalwidth:=PRight.Width;

 posy:=0;
 ALabel:=TLabel.Create(Self);
 LLabels.Add(ALabel);
 ALabel.Caption:=SRpMainDataset;
 ALabel.Hint:='refsubreport.html';
 ALabel.Left:=CONS_LEFTGAP;
 ALabel.Top:=posy+CONS_LABELTOPGAP;
 ALabel.Cursor:=crHelp;
 ALabel.OnMouseDown:=LabelMouseDown;
 ALabel.parent:=PLeft;

 ComboAlias:=TComboBox.Create(Self);
 ComboAlias.Style:=csDropDownList;
 ComboAlias.Top:=Posy;
 ComboAlias.Left:=CONS_LEFTGAP;
 ComboAlias.Width:=TotalWidth-ComboAlias.Left-CONS_RIGHTBARGAP;
 ComboAlias.parent:=PRight;
 ComboAlias.Anchors:=[akleft,aktop,akright];

 posy:=posy+ComboAlias.Height;
 ALabel:=TLabel.Create(Self);
 LLabels.Add(ALabel);
 ALabel.Caption:=SRpSPOnlyData;
 ALabel.Hint:='refsubreport.html';
 ALabel.Cursor:=crHelp;
 ALabel.OnMouseDown:=LabelMouseDown;
 ALabel.Left:=CONS_LEFTGAP;
 ALabel.Top:=posy+CONS_LABELTOPGAP;
 ALabel.parent:=PLeft;
 ComboPrintOnly:=TComboBox.Create(Self);
 ComboPrintOnly.Style:=csDropDownList;
 ComboPrintOnly.Top:=Posy;
 ComboPrintOnly.Left:=CONS_LEFTGAP;
 ComboPrintOnly.parent:=PRight;
 ComboPrintOnly.Items.Add(FalseBoolStrs[0]);
 ComboPrintOnly.Items.Add(TrueBoolStrs[0]);
 ComboPrintOnly.Width:=TotalWidth-ComboPrintOnly.Left-CONS_RIGHTBARGAP;
 ComboPrintOnly.Anchors:=[akleft,aktop,akright];

 posy:=posy+ComboAlias.Height;
 PParent.Height:=posy;

 LControls.AddObject(SRpMainDataset,ComboAlias);
 LControls.AddObject(SRpSPOnlyData,ComboPrintOnly);
 LControls2.AddObject(SRpMainDataset,ComboAlias);
 LControls2.AddObject(SRpSPOnlyData,ComboPrintOnly);
end;





// Creates an object inspector panel for the component
function TFRpObjInspVCL.CreatePanel(acompo:TRpSizeInterface):TRpPanelObj;
var
 apanel:TRpPanelObj;
begin
 apanel:=TRpPanelObj.Create(Self);
 apanel.Visible:=false;
 apanel.Parent:=Self;
 apanel.FSelectedItems:=FSelectedItems;
 if Not Assigned(acompo) then
 begin
  apanel.CreateControlsSubReport;
 end
 else
  // Creates a panel and fills it
  apanel.CreateControls(acompo);
 Result:=apanel;
end;

function TFRpObjInspVCL.FindPanelForClass(acompo:TRpSizeInterface):TRpPanelObj;
var
 newclassname:string;
 i,index:integer;
begin
 newclassname:=FindClassName(acompo);
 // Looks if the panel exists
 index:=FPropPanels.IndexOf(newclassname);
 if (index>=0) then
 begin
  Result:=TrpPanelObj(FPropPanels.Objects[index]);
 end
 else
 begin
  // Creates the panel
  Result:=CreatePanel(acompo);
  FPropPanels.AddObject(newclassname,Result);
 end;
 // ResourceSaving for Win9x systems
 // Free all panels
 if not IsWindowsNT then
 begin
  // Free all other panels
  for i:=0 to FPropPanels.Count-1 do
  begin
   if FPropPanels.Objects[i]<>Result then
    TRpPanelObj(FPropPanels.Objects[i]).Free;
  end;
  FPropPanels.Clear;
  FPropPanels.AddObject(newclassname,Result);
 end
 else
 begin
  // Invisible all other panels
  for i:=0 to FPropPanels.Count-1 do
  begin
   if FPropPanels.Objects[i]<>Result then
    TRpPanelObj(FPropPanels.Objects[i]).Visible:=False;
  end;
 end;
 // Visible this panel
 if Not Result.Visible then
 begin
  HorzScrollBar.Position:=0;
  VertScrollBar.Position:=0;
 end;
 Result.Visible:=True;
end;

function TFRpObjInspVCL.GetCompItem:TRpSizeInterface;
var
 i:integer;
begin
 Result:=nil;
 for i:=0 to FPropPanels.Count-1 do
 begin
  if TRpPanelObj(FPropPanels.Objects[i]).Visible then
  begin
   Result:=TRpPanelObj(FPropPanels.Objects[i]).FCompItem;
  end;
 end;
end;


function TFRpObjInspVCL.GetCurrentPanel:TRpPanelObj;
var
 i:integer;
begin
 Result:=nil;
 for i:=0 to FPRopPanels.Count-1 do
 begin
  if TRpPanelObj(FPropPanels.Objects[i]).Visible then
  begin
   Result:=TRpPanelObj(FPropPanels.Objects[i]);
   break;
  end;
 end;
end;

procedure TFRpObjInspVCL.SelectProperty(propname:string);
var
 FCurrentPanel:TRpPanelObj;
begin
 FCurrentPanel:=GetCurrentPanel;
 if Assigned(FCurrentPanel) then
  FCurrentPanel.SelectProperty(propname);
end;

procedure TFRpObjInspVCL.SetCompItem(Value:TRpSizeInterface);
var
 FRpMainf:TFRpMainFVCL;
 FCurrentPanel:TRpPanelObj;
begin
 FRpMainf:=TFRpMainFVCL(Owner);
 FCurrentPanel:=FindPanelForClass(Value);
 FCurrentPanel.FCompItem:=Value;
 TFRpDesignFrameVCL(FDesignFrame).InvalidateCaptions;
 FCurrentPanel.Subrep:=FRpMainf.freportstructure.FindSelectedSubreport;
 FCurrentPanel.AssignPropertyValues;
end;

constructor TFRpObjInspVCL.Create(AOwner:TComponent);
var
 alist:TStrings;
begin
 inherited Create(AOwner);

 {$IFDEF MSWINDOWS}
// Native flags not work as expected
// FontDialog1.NativeFlags:=CF_PRINTERFONTS or CF_EFFECTS;
{$ENDIF}
 FProppanels:=TStringList.Create;
 FSelectedItems:=TStringList.Create;
 FClasses:=TStringList.Create;

 fchangesize:=TRpSizeModifier.Create(Self);
 fchangesize.OnSizeChange:=changesizechange;


 FClasses.AddObject('TRpExpressionInterface',TRpExpressionInterface.Create(Self));
 FClasses.AddObject('TRpBarcodeInterface',TRpBarcodeInterface.Create(Self));
 FClasses.AddObject('TRpChartInterface',TRpChartInterface.Create(Self));
 FClasses.AddObject('TRpLabelInterface',TRpLabelInterface.Create(Self));
 FClasses.AddObject('TRpSizePosInterface',TRpSizePosInterface.Create(Self));
 FClasses.AddObject('TRpDrawInterface',TRpDrawInterface.Create(Self));
 FClasses.AddObject('TRpGenTextInterface',TRpGenTextInterface.Create(Self));
 FClasses.AddObject('TRpImageInterface',TRpImageInterface.Create(Self));

 FClassAncestors:=TStringList.Create;
 alist:=TStringList.Create;
 TRpExpressionInterface.FillAncestors(alist);
 FClassAncestors.AddObject('TRpExpressionInterface',alist);
 alist:=TStringList.Create;
 TRpBarcodeInterface.FillAncestors(alist);
 FClassAncestors.AddObject('TRpBarcodeInterface',alist);
 alist:=TStringList.Create;
 TRpChartInterface.FillAncestors(alist);
 FClassAncestors.AddObject('TRpChartInterface',alist);
 alist:=TStringList.Create;
 TRpGenTextInterface.FillAncestors(alist);
 FClassAncestors.AddObject('TRpGenTextInterface',alist);
 alist:=TStringList.Create;
 TRpLabelInterface.FillAncestors(alist);
 FClassAncestors.AddObject('TRpLabelInterface',alist);
 alist:=TStringList.Create;
 TRpDrawInterface.FillAncestors(alist);
 FClassAncestors.AddObject('TRpDrawInterface',alist);
 alist:=TStringList.Create;
 TRpImageInterface.FillAncestors(alist);
 FClassAncestors.AddObject('TRpImageInterface',alist);

 MLoadExternal.Caption:=TranslateStr(835,MLoadExternal.Caption);
 MSaveExternal.Caption:=TranslateStr(836,MSaveExternal.Caption);
end;

destructor TFRpObjInspVCL.Destroy;
var
 i:integer;
begin
 FPropPanels.Free;
 FSelectedItems.Free;
 FClasses.Free;
 for i:=0 to FClassAncestors.Count-1 do
 begin
  FClassAncestors.Objects[i].Free;
 end;
 FClassAncestors.Free;
 inherited Destroy;
end;


procedure TRpPanelObj.ExtClick(Sender:TObject);
var
 FRpMainf:TFRpMainFVCL;
begin
 FRpMainf:=TFRpMainFVCL(Owner.Owner);
 if rpmdfextsecvcl.ChangeExternalSectionProps(FRpMainF.report,TRpSection(FCompItem.printitem)) then
 begin
  TRpMaskEdit(Sender).Text:=TRpSection(FCompItem.printitem).GetExternalDataDescription;
  DupValue(TControl(Sender));
  // Now refresh interface
  TFRpDesignFrameVCL(TFRpObjInspVCL(Owner).FDesignFrame).freportstructure.RefreshInterface;
 end;
end;


procedure TRpPanelObj.ComboObjectChange(Sender:TObject);
begin
 TFRpObjInspVCL(Owner).AddCompItem(TRpSizeInterface(TComboBox(Sender).Items.Objects[TComboBox(Sender).ItemIndex]),true);
end;

procedure TFRpObjInspVCL.ChangeSizeChange(Sender:TObject);
var
 FCurrentPanel:TRpPanelObj;
begin
 // Read bounds Values and assign
 if Not Assigned(fchangesize.Control) then
  exit;
 FCurrentPanel:=GetCurrentPanel;
 if Assigned(FCurrentPanel) then
  FCurrentPanel.UpdatePosValues;
end;

procedure TRpPanelObj.SendToBackClick(Sender:TObject);
var
 section:TRpSection;
 item:TRpCommonListItem;
 pitem:TRpCommonComponent;
 aitem:TRpSizePosInterface;
 index:integer;
 i:integer;
begin
 if FSelectedItems.Count<1 then
  exit;
 if (Not (FSelectedItems.Objects[0] is TRpSizePosInterface)) then
  exit;
 for i:=0 to FSelectedItems.Count-1 do
 begin
  aitem:=TRpSizePosInterface(FSelectedItems.Objects[i]);
  aitem.SendToBack;
  aitem.SectionInt.SendToBack;
  pitem:=aitem.printitem;
  section:=TRpSection(aitem.SectionInt.printitem);
  index:=0;
  while index<section.ReportComponents.Count do
  begin
   if (section.ReportComponents.Items[index].Component=pitem) then
    break;
   inc(index);
  end;
  if index>=section.ReportComponents.Count then
   exit;
  section.ReportComponents.Delete(index);
  item:=section.ReportComponents.Insert(0);
  item.Component:=pitem;
 end;
 if assigned(TFRpObjInspVCL(Owner).fchangesize) then
  TFRpObjInspVCL(Owner).fchangesize.UpdatePos;
end;

procedure TRpPanelObj.BringToFrontClick(Sender:TObject);
var
 section:TRpSection;
 item:TRpCommonListItem;
 pitem:TRpCommonComponent;
 index:integer;
 aitem:TRpSizePosInterface;
 i:integer;
begin
 if FSelectedItems.Count<1 then
  exit;
 if (Not (FSelectedItems.Objects[0] is TRpSizePosInterface)) then
  exit;
 for i:=0 to FSelectedItems.Count-1 do
 begin
  aitem:=TRpSizePosInterface(FSelectedItems.Objects[i]);
  aitem.BringToFront;
  pitem:=aitem.printitem;
  section:=TRpSection(aitem.SectionInt.printitem);
  index:=0;
  while index<section.ReportComponents.Count do
  begin
   if (section.ReportComponents.Items[index].Component=pitem) then
    break;
   inc(index);
  end;
  if index>=section.ReportComponents.Count then
   exit;
  section.ReportComponents.Delete(index);
  item:=section.ReportComponents.Add;
  item.Component:=pitem;
 end;
 if assigned(TFRpObjInspVCL(Owner).fchangesize) then
  TFRpObjInspVCL(Owner).fchangesize.UpdatePos;
end;



procedure TRpPanelObj.ExpressionClick(Sender:TObject);
var
 report:TRpReport;
 i:integer;
 item:TRpAliaslistItem;
 FRpMainF:TFRpMainFVCL;
 expredia:TRpExpreDialogVCL;
begin
 FRpMainF:=TFRpMainFVCL(Owner.Owner);
 report:=FRpMainf.report;
 try
  report.BeginPrint(fpdfdriver);
 except
  on E:Exception do
  begin
   RpShowMessage(E.Message);
  end;
 end;

 TFRpObjInspVCL(Owner).RpAlias1.List.Clear;
 for i:=0 to report.DataInfo.Count-1 do
 begin
  item:=TFRpObjInspVCL(Owner).RpAlias1.List.Add;
  item.Alias:=report.DataInfo.Items[i].Alias;
  item.Dataset:=report.DataInfo.Items[i].Dataset;
 end;
 expredia:=TRpExpreDialogVCL.Create(Application);
 try
  expredia.Rpalias:=TFRpObjInspVCL(Owner).RpAlias1;
  report.InitEvaluator;
  report.AddReportItemsToEvaluator(report.evaluator);
  expredia.evaluator:=report.Evaluator;
  expredia.Expresion.Text:=TRpMaskEdit(LControls.Objects[TButton(Sender).Tag]).Text;
  if expredia.Execute then
  begin
   TRpMaskEdit(LControls.Objects[TButton(Sender).Tag]).Text:=Trim(expredia.Expresion.Text);
   TRpMaskEdit(LControls2.Objects[TButton(Sender).Tag]).Text:=Trim(expredia.Expresion.Text);
  end;
 finally
  expredia.Free;
 end;
end;

procedure TRpPanelObj.UpdatePosValues;
var
 index:integer;
 sizeposint:TRpSizePosInterface;
 NewLeft,NewTop,NewWidth,NewHeight:integer;
begin
 sizeposint:=TRpSizePosInterface(TFRpObjInspVCL(Owner).fchangesize.control);
 NewLeft:=sizeposint.Left;
 NewTop:=sizeposint.Top;
 NewWidth:=sizeposint.Width;
 NewHeight:=sizeposint.Height;
 index:=LNames.IndexOf(SRpSLeft);
 if index>=0 then
 begin
  SetPropertyFull(SRpSLeft,gettextfromtwips(pixelstotwips(NewLeft,sizeposint.Scale)));
 end;
 index:=LNames.IndexOf(SRpSTop);
 if index>=0 then
 begin
  SetPropertyFull(SRpSTop,gettextfromtwips(pixelstotwips(NewTop,sizeposint.Scale)));
 end;
 index:=LNames.IndexOf(SRpSWidth);
 if index>=0 then
 begin
  SetPropertyFull(SRpSWidth,gettextfromtwips(pixelstotwips(NewWidth,sizeposint.Scale)));
 end;
 index:=LNames.IndexOf(SRpSHeight);
 if index>=0 then
 begin
  SetPropertyFull(SRpSHeight,gettextfromtwips(pixelstotwips(NewHeight,sizeposint.Scale)));
 end;
end;

procedure TRpPanelObj.ImageClick(Sender:TObject);
var
 Stream:TMemoryStream;
{$IFDEF EXTENDEDGRAPHICS}
 apic:TPicture;
 jpeg:TJpegImage;
{$ENDIF}
begin
 if TFRpObjInspVCL(Owner).OpenDialog1.Execute then
 begin
  if (TFRpObjInspVCL(Owner).OpenDialog1.FilterIndex<=1) then
  begin
   Stream:=TMemoryStream.Create;
   try
    Stream.LoadFromFile(TFRpObjInspVCL(Owner).OpenDialog1.FileName);
    Stream.Seek(0,soFromBeginning);
    SetPropertyFull(LNames.Strings[TComponent(Sender).Tag],stream);
   finally
    Stream.Free;
   end;
  end
{$IFDEF EXTENDEDGRAPHICS}
  else
  begin
   apic:=TPicture.Create;
   try
     apic.LoadFromFile(TFRpObjInspVCL(Owner).OpenDialog1.FileName);
     jpeg:=TJPegImage.Create;
     try
      jpeg.CompressionQuality:=100;
      jpeg.Assign(apic.Graphic);
      Stream:=TMemoryStream.Create;
      try
       jpeg.SaveToStream(stream);
       Stream.Seek(0,soFromBeginning);
       SetPropertyFull(LNames.Strings[TComponent(Sender).Tag],stream);
      finally
       Stream.Free;
      end;
     finally
      jpeg.free;
     end;
   finally
    apic.free;
   end;
  end;
{$ENDIF}
  AssignPropertyValues;
 end;
end;


procedure TRpPanelObj.SetPropertyFull(propname:string;value:Widestring);
var
 i:integer;
 aitem:TRpSizeInterface;
begin
 for i:=0 to FSelectedItems.Count-1 do
 begin
  aitem:=TRpSizeInterface(FSelectedItems.Objects[i]);
  aitem.SetProperty(propname,value);
 end;
end;

procedure TRpPanelObj.SetPropertyFull(propname:string;stream:TMemoryStream);
var
 i:integer;
 aitem:TRpSizeInterface;
begin
 for i:=0 to FSelectedItems.Count-1 do
 begin
  aitem:=TRpSizeInterface(FSelectedItems.Objects[i]);
  aitem.SetProperty(propname,stream);
 end;
end;

procedure TRpPanelObj.ImageKeyDown(Sender: TObject;
     var Key: Word; Shift: TShiftState);
var
 Stream:TMemoryStream;
begin
 if ((Key=VK_BACK) or (Key=VK_DELETE)) then
 begin
  Stream:=TMemoryStream.Create;
  try
   SetPropertyFull(LNames.Strings[TComponent(Sender).Tag],stream);
  finally
   Stream.Free;
  end;
 end;
end;


procedure TRpPanelObj.ComboAliasChange(Sender:TObject);
var
  FRpMainf:TFRpMainFVCL;
begin
 subrep.Alias:=TComboBox(Sender).Text;
 FRpMainf:=TFRpMainFVCL(Owner.Owner);
 FRpMainf.freportstructure.RView.Selected.Text:=TRpSubReport(FRpMainf.freportstructure.RView.Selected.Data).GetDisplayName(true);
end;

procedure TRpPanelObj.ComboPrintOnlyChange(Sender:TObject);
begin
 if ComboPrintOnly.ItemIndex=0 then
  subrep.PrintOnlyIfDataAvailable:=false
 else
  subrep.PrintOnlyIfDataAvailable:=true;
end;

procedure TFRpObjInspVCL.RecreateChangeSize;
begin
 fchangesize.free;
 fchangesize:=nil;
 fchangesize:=TRpSizeModifier.Create(Self);
 fchangesize.OnSizeChange:=changesizechange;
end;


procedure TFRpObjInspVCL.InvalidatePanels;
var
 i:integer;
begin
 // Panels must be resized when show
 for i:=0 to FPropPanels.Count-1 do
 begin
  FPropPanels.Objects[i].Free;
 end;
 FPropPanels.Clear;
end;


function TFRpObjInspVCL.GetComboBox:TComboBox;
var
 i:integer;
begin
 Result:=nil;
 for i:=0 to FPropPanels.Count-1 do
 begin
  if TrpPanelObj(FPropPanels.Objects[i]).Visible then
  begin
   Result:=TrpPanelObj(FPropPanels.Objects[i]).Combo;
  end;
 end;
end;

function TFRpObjInspVCL.FindCommonClass(baseclass,newclass:String):String;
var
 indexnew,indexbase,i,j:integer;
 aorigin,adestination:TStrings;
 found:boolean;
begin
 Result:='TRpSizePosInterface';
 // Find the index for the baseclass and
 // for the new class
 indexnew:=FClassAncestors.IndexOf(newclass);
 indexbase:=FClassAncestors.IndexOf(baseclass);
 if indexnew<0 then
  Raise Exception.Create(SRpUnkownClassForMultiSelect+':'+newclass);
 if indexbase<0 then
  Raise Exception.Create(SRpUnkownClassForMultiSelect+':'+baseclass);
 aorigin:=TStrings(FClassAncestors.Objects[indexbase]);
 adestination:=TStrings(FClassAncestors.Objects[indexnew]);
 // For the new class search a coincidence downto level
 found:=false;
 for i:=adestination.Count-1 downto 0 do
 begin
  for j:=aorigin.Count-1 downto 0 do
  begin
   if adestination.Strings[i]=aorigin.Strings[j] then
   begin
    Result:=adestination.Strings[i];
    found:=true;
    break;
   end;
  end;
  if found then
   break;
 end;
end;

function TFRpObjInspVCL.GetCommonClassName:String;
var
 baseclass:String;
 newclass:String;
 i:integer;
begin
 baseclass:=FSelectedItems.Objects[0].ClassName;
 for i:=1 to FSelectedItems.Count-1 do
 begin
  newclass:=FSelectedItems.Strings[i];
  if newclass<>baseclass then
   baseclass:=FindCommonClass(baseclass,newclass);
  if baseclass='TRpSizePosInterface' then
   break;
 end;
 Result:=baseclass;
end;


procedure TFRpObjInspVCL.ClearMultiSelect;
var
 i:integer;
 tempitem:TRpSizePosInterface;
begin
 if FSelectedItems.Count>0 then
 begin
  if (FSelectedItems.Objects[0] is TRpSizePosInterface) then
  begin
   for i:=0 to FSelectedItems.Count-1 do
   begin
    tempitem:=TRpSizePosInterface(FSelectedItems.Objects[i]);
    if tempitem.Selected then
    begin
     tempitem.Selected:=False;
     tempitem.Invalidate;
    end;
   end;
  end;
 end;
 FSelectedItems.Clear;
end;

procedure TFRpObjInspVCL.AddCompItem(aitem:TRpSizeInterface;onlyone:boolean);
var
 i:integer;
 tempitem:TRpSizePosInterface;
begin
 if Not Assigned(aitem) then
 begin
  ClearMultiSelect;
  SetCompItem(aitem);
  exit;
 end;
 if aitem is TRpSizePosInterface then
 begin
  if onlyone then
   ClearMultiSelect;
  if FSelectedItems.Count=1 then
   if NOt (FSelectedItems.Objects[0] is TRpSizePosInterface) then
   begin
    ClearMultiSelect;
   end;
  AddCompItemPos(TRpSizePosInterface(aitem),onlyone);
  if FSelectedItems.Count>1 then
  begin
   fchangesize.Control:=nil;
   for i:=0 to FSelectedItems.Count-1 do
   begin
    tempitem:=TRpSizePosInterface(FSelectedItems.Objects[i]);
    if Not tempitem.Selected then
    begin
     tempitem.Selected:=True;
     tempitem.Invalidate;
    end;
   end;
  end;
  exit;
 end
 else
 begin
  ClearMultiSelect;
  FSelectedItems.AddObject(aitem.classname,aitem);
  SetCompItem(aitem);
 end;
end;

procedure TFRpObjInspVCL.AddCompItemPos(aitem:TRpSizePosInterface;onlyone:boolean);
var
 parentclassname:String;
 i,index:integer;
 found:boolean;
begin
 if onlyone then
 begin
  FSelectedItems.Clear;
 end;
 i:=FSelectedItems.IndexOfObject(aitem);
 found:=i>=0;
 if found then
 begin
  if onlyone then
   exit;
  if FSelectedItems.Count<2 then
   exit;
  FSelectedItems.Delete(i);
  aitem.Selected:=false;
  if FSelectedItems.Count=1 then
   TRpSizePosInterface(FSelectedItems.Objects[0]).Selected:=false;
 end
 else
  FSelectedItems.AddObject(aitem.classname,aitem);
 if FSelectedItems.Count=1 then
 begin
  SetCompItem(TRpSizeInterface(FSelectedItems.Objects[0]));
  exit;
 end;
 // Looks for the most ancestor class of the list
 parentclassname:=GetCommonClassName;
 if assigned(FCommonObject) then
 begin
  if FCommonObject.ClassName<>parentclassname then
  begin
   FCommonObject:=nil;
  end;
 end;
 if Not Assigned(FCommonObject) then
 begin
  index:=FClasses.IndexOf(parentclassname);
  if index<0 then
   Raise Exception.Create(SRpClassNotRegistered+':'+parentclassname);
  FCommonObject:=TRpSizePosInterface(FClasses.Objects[index]);
 end;
 FCommonObject.SectionInt:=aitem.SectionInt;
 SetCompItem(FCommonObject);
end;

procedure TFRpObjInspVCL.SelectAllClass(classname:string);
var
 i,j:integer;
 compo:TRpSizePosInterface;
 sec:TRpSectionInterface;
 desframe:TFRpDesignFrameVCL;
 index:integer;
 alist:TStringList;
begin
 ClearMultiSelect;
 desframe:=TFRpDesignFrameVCL(FDesignFrame);
 for i:=0 to desframe.secinterfaces.Count-1 do
 begin
  sec:=TrpSectionInterface(desframe.secinterfaces.Items[i]);
  for j:=0 to sec.childlist.Count-1 do
  begin
   compo:=TRpSizePosInterface(sec.childlist.items[j]);
   index:=FClassAncestors.IndexOf(compo.classname);
   if index<0 then
    Raise Exception.Create(SRpClassNotRegistered+':'+compo.classname);
   alist:=TStringList(FClassAncestors.Objects[index]);
   index:=alist.IndexOf(classname);
   if index>=0 then
    FSelectedItems.AddObject(compo.ClassName,compo);
  end;
 end;
 if FSelectedItems.Count>0 then
 begin
  compo:=TRpSizePosInterface(FSelectedItems.Objects[FSelectedItems.Count-1]);
  FSelectedItems.Delete(FSelectedItems.Count-1);
  AddCOmpItem(compo,false);
 end;
end;


procedure TFRpObjInspVCL.AlignSelected(direction:integer);
var
 i:integer;
 aitem:TRpSizePosInterface;
 pitem:TRpCommonPosComponent;
 newpos:integer;
 actualpos:integer;
 minpos,maxpos,newminpos,newmaxpos,sumwidth:integer;
 distance:integer;
 fselitems:TStringList;
begin
 // Aligns selection
 // 1-Left, 2-Right, 3-Up, 4-Down, 5-HorzSpacing,5-VertSpacing
 if FSelectedItems.Count<2 then
  exit;
 newpos:=0;
 if direction in [1..4] then
 begin
  if direction in [1,3] then
   actualpos:=MaxInt
  else
   actualpos:=-Maxint;
  for i:=0 to FSelectedItems.Count-1 do
  begin
   aitem:=TRpSizePosInterface(FSelectedItems.Objects[i]);
   pitem:=TRpCommonPosComponent(aitem.printitem);
   case direction of
    1:
     begin
      newpos:=pitem.PosX;
     end;
    2:
     begin
      newpos:=pitem.PosX+pitem.Width;
     end;
    3:
     begin
      newpos:=pitem.PosY;
     end;
    4:
     begin
      newpos:=pitem.PosY+pitem.Height;
     end;
   end;
   if direction in [1,3] then
   begin
    if newpos<actualpos then
     actualpos:=newpos;
   end
   else
   begin
    if newpos>actualpos then
     actualpos:=newpos;
   end;
  end;
  for i:=0 to FSelectedItems.Count-1 do
  begin
   aitem:=TRpSizePosInterface(FSelectedItems.Objects[i]);
   pitem:=TRpCommonPosComponent(aitem.printitem);
   case direction of
    1:
     pitem.PosX:=actualpos;
    2:
     pitem.PosX:=actualpos-pitem.Width;
    3:
     pitem.PosY:=actualpos;
    4:
     pitem.PosY:=actualpos-pitem.Height;
   end;
   aitem.UpdatePos;
  end;
  exit;
 end;
 // Vertical distance and horz distance
 minpos:=MaxInt;
 maxpos:=-MaxInt;
 sumwidth:=0;
 for i:=0 to FSelectedItems.Count-1 do
 begin
  aitem:=TRpSizePosInterface(FSelectedItems.Objects[i]);
  pitem:=TRpCommonPosComponent(aitem.printitem);
  if direction=6 then
  begin
   newminpos:=pitem.PosX;
   newmaxpos:=pitem.PosX+pitem.Width;
   sumwidth:=sumwidth+pitem.Width;
  end
  else
  begin
   newminpos:=pitem.PosY;
   newmaxpos:=pitem.PosY+pitem.Height;
   sumwidth:=sumwidth+pitem.Height;
  end;
  if newminpos<minpos then
   minpos:=newminpos;
  if newmaxpos>maxpos then
   maxpos:=newmaxpos;
 end;
 fselitems:=TStringList.Create;
 try
  fselitems.Sorted:=True;
  for i:=0 to FSelectedItems.Count-1 do
  begin
   aitem:=TRpSizePosInterface(FSelectedItems.Objects[i]);
   pitem:=TRpCommonPosComponent(aitem.printitem);
   if direction=6 then
    fselitems.AddObject(FormatFloat('00000000000',pitem.PosX),aitem)
   else
    fselitems.AddObject(FormatFloat('00000000000',pitem.PosY),aitem)
  end;
 // Calculates the distance between them
  distance:=((maxpos-minpos)-sumwidth) div (FSelectedItems.Count-1);
  for i:=0 to FSelItems.Count-2 do
  begin
   aitem:=TRpSizePosInterface(FSelItems.Objects[i]);
   pitem:=TRpCommonPosComponent(aitem.printitem);
   if direction=6 then
   begin
    pitem.PosX:=minpos;
    minpos:=minpos+pitem.Width+distance;
   end
   else
   begin
    pitem.PosY:=minpos;
    minpos:=minpos+pitem.Height+distance;
   end;
   aitem.Updatepos;
  end;
 finally
  fselitems.free;
 end;
end;

procedure TFRpObjInspVCL.MoveSelected(direction:integer;fast:boolean);
var
 i:integer;
 aitem:TRpSizePosInterface;
 pitem:TRpCommonPosComponent;
 unitsize:integer;
 FRpMainf:TFRpMainFVCL;
 FCurrentPanel:TRpPanelObj;
begin
 if FSelectedItems.Count<1 then
  exit;
 if (Not (FSelectedItems.Objects[0] is TRpSizePosInterface)) then
  exit;
 FRpMainf:=TFRpMainFVCL(Owner);
 if FRpMainf.report.GridEnabled then
 begin
  if (direction in [1,2]) then
   unitsize:=FRpMainf.report.GridWidth
  else
   unitsize:=FRpMainf.report.GridHeight
 end
 else
 begin
  unitsize:=pixelstotwips(1,TRpSizePosInterface(FSelectedItems.Objects[0]).Scale);
 end;
 if direction in [1,3] then
  unitsize:=-unitsize;
 if fast then
  unitsize:=unitsize*5;
 for i:=0 to FSelectedItems.Count-1 do
 begin
  aitem:=TRpSizePosInterface(FSelectedItems.Objects[i]);
  pitem:=TRpCommonPosComponent(aitem.printitem);
  if direction in [1,2] then
   pitem.PosX:=pitem.PosX+unitsize
  else
   pitem.PosY:=pitem.PosY+unitsize;
  aitem.UpdatePos;
 end;
 if Assigned(fchangesize.Control) then
 begin
  fchangesize.UpdatePos;
  FCurrentPanel:=GetCurrentPanel;
  if Assigned(FCurrentPanel) then
   FCurrentPanel.AssignPropertyValues;
 end;
end;

procedure TFRpObjInspVCL.MLoadExternalClick(Sender: TObject);
begin
 if Not (CompItem is TRpSectionInterface) then
  exit;
 if Sender=MLoadExternal then
 begin
  TRpSection(TRpSectionInterface(CompItem).printitem).LoadExternal;
  // Now refresh interface
  TFRpDesignFrameVCL(FDesignFrame).freportstructure.RefreshInterface;
 end
 else
 if Sender=MSaveExternal then
 begin
  TRpSection(TRpSectionInterface(CompItem).printitem).SaveExternal;
 end
end;

procedure TRpPanelObj.CreateControls(acompo:TRpSizeInterface);
var
 totalwidth,aheight:integer;
 posy,i,j:integer;
 ALabel:TLabel;
 control:TControl;
 typename:string;
 Control2:TControl;
 FRpMainf:TFRpMainFVCL;
 AScrollBox,NScrollBox:TScrollBox;
 APanelTop:TPanel;
 APanelBottom:TPanel;
 PPArent:TPanel;
 PLeft:TPanel;
 PRight:TPanel;
 Psplit:TSplitter;
 apage,pageall:TRpPageObj;
 APControl:TPageControl;
 ncontrol:TControl;
 createpage:Boolean;
begin
 FRpMainf:=TFRpMainFVCL(Owner.Owner);
 FCompItem:=acompo;
 aheight:=0;
 apage:=nil;

 totalwidth:=WIdth;
 if totalwidth<CONS_MINWIDTH then
  totalwidth:=CONS_MINWIDTH;

 // Creates the labels and controls
 posy:=0;
 // The combobox
 APanelTop:=TPanel.Create(Self);
 APanelTop.BevelInner:=bvNone;
 APanelTop.BevelOuter:=bvNone;
 APanelTop.Align:=alTop;
 APanelTop.Parent:=Self;

 Combo:=TComboBox.Create(Self);
 Combo.Width:=TotalWidth-CONS_RIGHTBARGAP;
 Combo.Style:=csDropDownList;
 Combo.Name:='TopCombobox'+FCompItem.classname;
 combo.OnChange:=ComboObjectChange;
 APanelTop.Height:=Combo.height;
 Combo.Parent:=APanelTop;
 Combo.Anchors:=[akleft,akright,aktop];

 APControl:=TPageCOntrol.Create(self);
 APControl.Align:=alClient;
 APControl.MultiLine:=true;
 APControl.HotTrack:=true;
 APControl.Parent:=Self;

 FPControl:=APControl;

 PageAll:=TRpPageObj.Create(Self);
 PageAll.Caption:=SRpAllprops;
 PageAll.PageControl:=APControl;

 APControl.ActivePageIndex:=0;

 AScrollBox:=TScrollBox.Create(Self);
 AScrollBox.Align:=alClient;
 AScrollBox.HorzScrollBar.Tracking:=True;
 AScrollBox.VertScrollBar.Tracking:=True;
 AScrollBox.BorderStyle:=bsNone;
 AScrollBox.Parent:=PageAll;
 PageAll.AScrollBox:=AScrollBox;
 AScrollBox.HorzScrollBar.Visible:=false;
 AScrollBox.VertScrollBar.Visible:=false;

 PParent:=TPanel.Create(Self);
 PParent.Left:=0;
 PParent.Width:=0;
 PPArent.BorderStyle:=bsNone;
 PParent.BevelInner:=bvNone;
 PParent.BevelOuter:=bvNone;
 PParent.Align:=AlTop;
 PParent.Parent:=AScrollBox;
 PAgeAll.PParent:=PParent;

 PLeft:=TPanel.Create(Self);
 PLeft.Width:=CONS_CONTROLPOS;
 PLeft.BorderStyle:=bsNone;
 PLeft.BevelInner:=bvNone;
 PLeft.BevelOuter:=bvNone;
 PLeft.Align:=AlLeft;
 PLeft.Parent:=PParent;

 Psplit:=TSplitter.Create(Self);
 Psplit.ResizeStyle:=rsUpdate;
 Psplit.Cursor:=crHSplit;
 PSplit.MinSize:=10;
 PSplit.Beveled:=True;
 PSplit.Width:=4;
 PSplit.Left:=PLeft.Width+10;
 Psplit.Align:=Alleft;
 PSplit.Parent:=PParent;

 PRight:=TPanel.Create(Self);
 PRight.Width:=CONS_CONTROLPOS;
 PRight.BorderStyle:=bsNone;
 PRight.BevelInner:=bvNone;
 PRight.BevelOuter:=bvNone;
 PRight.Align:=AlClient;
 PRight.Parent:=PParent;

 totalwidth:=PRight.Width;

 FCompItem.GetProperties(LNames,LTypes,nil,LHints,LCat);
 for i:=0 to LNames.Count-1 do
 begin
  // Search the parent page
  createpage:=false;
  if Not assigned(apage) then
   createpage:=true
  else
   if apage.Caption<>LCat.Strings[i] then
    createpage:=true;
  if createpage then
  begin
   for j:=0 to APControl.PageCount-1 do
   begin
    if APControl.Pages[j].Caption=LCat.Strings[i] then
    begin
     createpage:=false;
     apage:=TRpPAgeObj(APControl.Pages[j]);
     break;
    end;
   end;
  end;
  if createpage then
  begin
   apage:=TRpPageObj.Create(Self);
   apage.Caption:=LCat.Strings[i];
   apage.PageIndex:=APControl.PageCount;
   apage.PageControl:=APControl;
   apage.posy:=0;
   NScrollBox:=TScrollBox.Create(Self);
   NScrollBox.Align:=alClient;
   NScrollBox.HorzScrollBar.Tracking:=True;
   NScrollBox.VertScrollBar.Tracking:=True;
   NScrollBox.BorderStyle:=bsNone;
   NScrollBox.Parent:=apage;
   NScrollBox.HorzScrollBar.Visible:=false;
   NScrollBox.VertScrollBar.Visible:=false;
   apage.AScrollBox:=NScrollBox;

   apage.PParent:=TPanel.Create(Self);
   apage.PParent.Left:=0;
   apage.PParent.Width:=0;
   apage.PPArent.BorderStyle:=bsNone;
   apage.PParent.BevelInner:=bvNone;
   apage.PParent.BevelOuter:=bvNone;
   apage.PParent.Align:=AlTop;
   apage.PParent.Parent:=NScrollBox;

   apage.PLeft:=TPanel.Create(Self);
   apage.PLeft.Width:=CONS_CONTROLPOS;
   apage.PLeft.BorderStyle:=bsNone;
   apage.PLeft.BevelInner:=bvNone;
   apage.PLeft.BevelOuter:=bvNone;
   apage.PLeft.Align:=AlLeft;
   apage.PLeft.Parent:=apage.PParent;

   Psplit:=TSplitter.Create(Self);
   Psplit.ResizeStyle:=rsUpdate;
   Psplit.Cursor:=crHSplit;
   PSplit.MinSize:=10;
   PSplit.Beveled:=True;
   PSplit.Width:=4;
   PSplit.Left:=PLeft.Width+10;
   Psplit.Align:=Alleft;
   PSplit.Parent:=apage.PParent;

   apage.PRight:=TPanel.Create(Self);
   apage.PRight.Width:=CONS_CONTROLPOS;
   apage.PRight.BorderStyle:=bsNone;
   apage.PRight.BevelInner:=bvNone;
   apage.PRight.BevelOuter:=bvNone;
   apage.PRight.Align:=AlClient;
   apage.PRight.Parent:=apage.PParent;
  end;

  ALabel:=TLabel.Create(Self);
  LLabels.Add(ALabel);
  ALabel.Caption:=LNames.Strings[i];
  if LHints.Count>i then
   if Length(LHints.Strings[i])>0 then
   begin
    ALabel.Hint:=LHints.Strings[i];
    ALabel.ParentShowHint:=False;
    ALabel.ShowHint:=False;
    ALabel.Cursor:=crHelp;
    ALabel.OnMouseDown:=LabelMouseDown;
   end;
  ALabel.Left:=CONS_LEFTGAP;
  ALabel.Top:=posy+CONS_LABELTOPGAP;
  ALabel.parent:=PLeft;

  ALabel:=TLabel.Create(Self);
  LLabels.Add(ALabel);
  ALabel.Caption:=LNames.Strings[i];
  if LHints.Count>i then
   if Length(LHints.Strings[i])>0 then
   begin
    ALabel.Hint:=LHints.Strings[i];
    ALabel.ParentShowHint:=False;
    ALabel.ShowHint:=False;
    ALabel.Cursor:=crHelp;
    ALabel.OnMouseDown:=LabelMouseDown;
   end;
  ALabel.Left:=CONS_LEFTGAP;
  ALabel.Top:=apage.posy+CONS_LABELTOPGAP;
  ALabel.parent:=apage.PLeft;

  typename:=LTypes.Strings[i];
  if LTypes.Strings[i]=SRpSBool then
  begin
   Control:=TComboBox.Create(Self);
   TComboBox(Control).Style:=csDropDownList;
   Control.Visible:=false;
   Control.Parent:=PRight;
   TComboBox(Control).Items.Add(FalseBoolStrs[0]);
   TComboBox(Control).Items.Add(TrueBoolStrs[0]);
   TCOmboBox(Control).OnChange:=EditChange;

   NControl:=TComboBox.Create(Self);
   TComboBox(NControl).Style:=csDropDownList;
   NControl.Visible:=false;
   NControl.Parent:=apage.PRight;
   TComboBox(NControl).Items.Add(FalseBoolStrs[0]);
   TComboBox(NControl).Items.Add(TrueBoolStrs[0]);
   TCOmboBox(NControl).OnChange:=EditChange;
  end
  else
  if LTypes.Strings[i]=SRpSList then
  begin
   Control:=TComboBox.Create(Self);
   TComboBox(Control).Style:=csDropDownList;
   Control.Visible:=false;
   Control.Parent:=PRight;
   FCompItem.GetPropertyValues(LNames.Strings[i],TComboBox(Control).Items);
   TCOmboBox(Control).OnChange:=EditChange;

   NControl:=TComboBox.Create(Self);
   TComboBox(NControl).Style:=csDropDownList;
   NControl.Visible:=false;
   NControl.Parent:=apage.PRight;
   FCompItem.GetPropertyValues(LNames.Strings[i],TComboBox(NControl).Items);
   TCOmboBox(NControl).OnChange:=EditChange;
  end
  else
  if LTypes.Strings[i]=SRpSColor then
  begin
   Control:=TShape.Create(Self);
   Control.Height:=aheight;
   TShape(Control).Shape:=stRectangle;
   TShape(Control).OnMouseUp:=ShapeMouseUp;

   NControl:=TShape.Create(Self);
   NControl.Height:=aheight;
   TShape(NControl).Shape:=stRectangle;
   TShape(NControl).OnMouseUp:=ShapeMouseUp;
  end
  else
  if LTypes.Strings[i]=SRpSImage then
  begin
   Control:=TRpMaskEdit.Create(Self);
   TRpMaskEdit(Control).ReadOnly:=True;
   TRpMaskEdit(Control).Color:=clInfoBk;
   TRpMaskEdit(Control).OnClick:=ImageClick;
   TRpMaskEdit(Control).OnKeyDown:=ImageKeyDown;

   NControl:=TRpMaskEdit.Create(Self);
   TRpMaskEdit(NControl).ReadOnly:=True;
   TRpMaskEdit(NControl).Color:=clInfoBk;
   TRpMaskEdit(NControl).OnClick:=ImageClick;
   TRpMaskEdit(NControl).OnKeyDown:=ImageKeyDown;
  end
  else
  if LTypes.Strings[i]=SRpGroup then
  begin
   Control:=TComboBox.Create(Self);
   TComboBox(Control).Style:=csDropDownList;
   Control.Visible:=false;
   Control.Parent:=PRight;
   subrep:=FRpMainf.freportstructure.FindSelectedSubreport;
   subrep.GetGroupNames(TComboBox(Control).Items);
   TComboBox(Control).Items.Insert(0,' ');
   TComboBox(Control).OnChange:=EditChange;

   NControl:=TComboBox.Create(Self);
   TComboBox(NControl).Style:=csDropDownList;
   NControl.Visible:=false;
   NControl.Parent:=apage.PRight;
   subrep:=FRpMainf.freportstructure.FindSelectedSubreport;
   subrep.GetGroupNames(TComboBox(NControl).Items);
   TComboBox(NControl).Items.Insert(0,' ');
   TComboBox(NControl).OnChange:=EditChange;
  end
  else
  if LTypes.Strings[i]=SRpSFontStyle then
  begin
   Control:=TRpMaskEdit.Create(Self);
   TRpMaskEdit(Control).ReadOnly:=True;
   TRpMaskEdit(Control).Color:=clInfoBk;
   TRpMaskEdit(Control).OnClick:=FontClick;

   NControl:=TRpMaskEdit.Create(Self);
   TRpMaskEdit(NControl).ReadOnly:=True;
   TRpMaskEdit(NControl).Color:=clInfoBk;
   TRpMaskEdit(NControl).OnClick:=FontClick;
  end
  else
  if LTypes.Strings[i]=SRpSExternalData then
  begin
   Control:=TRpMaskEdit.Create(Self);
{$IFDEF DOTNETDBUGS}
   Control.Parent:=PRight;
{$ENDIF}
   TRpMaskEdit(Control).ReadOnly:=True;
   TRpMaskEdit(Control).Color:=clInfoBk;
   TRpMaskEdit(Control).OnClick:=ExtClick;
   TRpMaskEdit(Control).PopupMenu:=TFRpObjInspVCL(Owner).PopUpSection;

   NControl:=TRpMaskEdit.Create(Self);
{$IFDEF DOTNETDBUGS}
   Control.Parent:=apage.PRight;
{$ENDIF}
   TRpMaskEdit(NControl).ReadOnly:=True;
   TRpMaskEdit(NControl).Color:=clInfoBk;
   TRpMaskEdit(NControl).OnClick:=ExtClick;
   TRpMaskEdit(NControl).PopupMenu:=TFRpObjInspVCL(Owner).PopUpSection;
  end
  else
  if LTypes.Strings[i]=SRpSCurrency then
  begin
   Control:=TRpMaskEdit.Create(Self);
{$IFDEF DOTNETDBUGS}
   Control.Parent:=PRight;
{$ENDIF}
   TRpMaskEdit(Control).OnChange:=EditChange;
   TRpMaskEdit(Control).EditType:=tecurrency;
   TRpMaskEdit(Control).DisplayMask:='##,##0.###';

   NControl:=TRpMaskEdit.Create(Self);
{$IFDEF DOTNETDBUGS}
   NControl.Parent:=apage.PRight;
{$ENDIF}
   TRpMaskEdit(NControl).OnChange:=EditChange;
   TRpMaskEdit(NControl).EditType:=tecurrency;
   TRpMaskEdit(NControl).DisplayMask:='##,##0.###';
  end
  else
  if ((LTypes.Strings[i]=SRpSInteger) or (LTypes.Strings[i]=SRpSFontSize)) then
  begin
   Control:=TRpMaskEdit.Create(Self);
   TRpMaskEdit(Control).OnChange:=EditChange;
   TRpMaskEdit(Control).EditType:=teinteger;
   TRpMaskEdit(Control).DisplayMask:='##,##0';

   NControl:=TRpMaskEdit.Create(Self);
   TRpMaskEdit(NControl).OnChange:=EditChange;
   TRpMaskEdit(NControl).EditType:=teinteger;
   TRpMaskEdit(NControl).DisplayMask:='##,##0';
  end
  else
  begin
{$IFNDEF USETNTUNICODE}
   Control:=TRpMaskEdit.Create(Self);
   TRpMaskEdit(Control).OnChange:=EditChange;
   if LTypes.Strings[i]=SRpSExternalpath then
    TRpMaskEdit(Control).PopupMenu:=TFRpObjInspVCL(Owner).PopUpSection;

   NControl:=TRpMaskEdit.Create(Self);
   TRpMaskEdit(NControl).OnChange:=EditChange;
   if LTypes.Strings[i]=SRpSExternalpath then
    TRpMaskEdit(NControl).PopupMenu:=TFRpObjInspVCL(Owner).PopUpSection;
{$ENDIF}
{$IFDEF USETNTUNICODE}
   Control:=TTntEdit.Create(Self);
   TTntEdit(Control).OnChange:=EditChange;
   if LTypes.Strings[i]=SRpSExternalpath then
    TTntEdit(Control).PopupMenu:=TFRpObjInspVCL(Owner).PopUpSection;

   NControl:=TTntEdit.Create(Self);
   TTntEdit(NControl).OnChange:=EditChange;
   if LTypes.Strings[i]=SRpSExternalpath then
    TTntEdit(NControl).PopupMenu:=TFRpObjInspVCL(Owner).PopUpSection;
{$ENDIF}
  end;
  Control.Top:=Posy;
  Control.Left:=CONS_LEFTGAP;
  Control.Width:=TotalWidth-CONS_LEFTGAP-CONS_RIGHTBARGAP;
  control.parent:=PRight;
  Control.Visible:=true;

  NControl.Top:=apage.Posy;
  NControl.Left:=CONS_LEFTGAP;
  NControl.Width:=TotalWidth-CONS_LEFTGAP-CONS_RIGHTBARGAP;

  Ncontrol.parent:=apage.PRight;
  NControl.Visible:=true;


  if aheight=0 then
   aheight:=Control.Height;
  Control.tag:=i;
  NControl.tag:=i;
  LControls.AddObject(LNames.Strings[i],Control);
  LControls2.AddObject(LNames.Strings[i],NControl);

  // Font button
{$IFDEF MSWINDOWS}
  if LTypes.Strings[i]=SRpSWFontName then
  begin
   TRpMaskEdit(Control).OnDblClick:=FontClick;
  end;
{$ENDIF}
{$IFDEF LINUX}
  if LTypes.Strings[i]=SRpSLFontName then
  begin
   TRpMaskEdit(Control).OnDblClick:=FontClick;
  end;
{$ENDIF}
{$IFDEF MSWINDOWS}
  if LTypes.Strings[i]=SRpSWFontName then
{$ENDIF}
{$IFDEF LINUX}
  if LTypes.Strings[i]=SRpSLFontName then
{$ENDIF}
  begin
   Control2:=TButton.Create(Self);
   Control2.Width:=CONS_BUTTONWIDTH;
   Control2.Top:=Control.Top;
   Control2.Left:=Control.Left+Control.Width-CONS_BUTTONWIDTH;
   Control2.Height:=COntrol.Height;
   Control2.Tag:=i;
   Control.Width:=Control.Width-CONS_BUTTONWIDTH;
   TButton(Control2).OnClick:=FontClick;
   TButton(Control2).Caption:='...';
   Control2.Parent:=PRight;
   Control2.Anchors:=[aktop,akright];

   Control2:=TButton.Create(Self);
   Control2.Width:=CONS_BUTTONWIDTH;
   Control2.Top:=NControl.Top;
   Control2.Left:=NControl.Left+NControl.Width-CONS_BUTTONWIDTH;
   Control2.Height:=COntrol.Height;
   Control2.Tag:=i;
   NControl.Width:=NControl.Width-CONS_BUTTONWIDTH;
   TButton(Control2).OnClick:=FontClick;
   TButton(Control2).Caption:='...';
   Control2.Parent:=apage.PRight;
   Control2.Anchors:=[aktop,akright];
  end;
  if (LTypes.Strings[i]=SRpSExpression) then
  begin
   Control2:=TButton.Create(Self);
   Control2.Width:=CONS_BUTTONWIDTH;
   Control2.Top:=Control.Top;
   Control2.Left:=Control.Left+Control.Width-CONS_BUTTONWIDTH;
   Control2.Height:=COntrol.Height;
   Control.Width:=Control.Width-CONS_BUTTONWIDTH;
   Control2.Tag:=i;
   TButton(Control2).OnClick:=ExpressionClick;
   TButton(Control2).Caption:='...';
   Control2.Parent:=PRight;
   Control2.Anchors:=[aktop,akright];

   Control2:=TButton.Create(Self);
   Control2.Width:=CONS_BUTTONWIDTH;
   Control2.Top:=NControl.Top;
   Control2.Left:=NControl.Left+NControl.Width-CONS_BUTTONWIDTH;
   Control2.Height:=NCOntrol.Height;
   NControl.Width:=NControl.Width-CONS_BUTTONWIDTH;
   Control2.Tag:=i;
   TButton(Control2).OnClick:=ExpressionClick;
   TButton(Control2).Caption:='...';
   Control2.Parent:=apage.PRight;
   Control2.Anchors:=[aktop,akright];
  end;
  Control.Anchors:=[akleft,aktop,akright];
  NControl.Anchors:=[akleft,aktop,akright];
  posy:=posy+control.height;
  apage.posy:=apage.posy+control.height;
 end;
 PageAll.PosY:=Posy;
 for i:=0 to APControl.PageCount-1 do
 begin
  TRpPageObj(APControl.Pages[i]).AScrollBox.HorzScrollBar.Visible:=true;
  TRpPageObj(APControl.Pages[i]).AScrollBox.VertScrollBar.Visible:=true;
  TRpPageObj(APControl.Pages[i]).PParent.Height:=TRpPageObj(APControl.Pages[i]).PosY;
 end;

 // Send to back and bring to front buttons
 if (FCompItem is TRpSizePosInterface) then
 begin
  APanelBottom:=TPanel.Create(Self);
  APanelBottom.BevelInner:=bvNone;
  APanelBottom.BevelOuter:=bvNone;
  APanelBottom.Align:=alBottom;
  APanelBottom.Parent:=Self;
  Control:=TButton.Create(Self);
  Control.Left:=0;
  Control.Top:=0;
  Control.Height:=aheight;
  Control.Width:=70;
  TBUtton(Control).Caption:=SRpSendToBack;
  TButton(Control).OnClick:=SendToBackClick;
  Control.parent:=APanelBottom;
  Control2:=TButton.Create(Self);
  Control2.Left:=Control.Width;
  Control2.Top:=0;
  Control2.Height:=aheight;
  APanelBottom.Height:=aheight;
  Control2.Width:=Control.Parent.Width-70;
  Control2.parent:=APanelBottom;
  Control2.Anchors:=[akleft,aktop,akright];
  TButton(Control2).OnClick:=BringToFrontClick;
  TBUtton(Control2).Caption:=SRpBringToFront;
 end;
end;

constructor TrpPanelObj.Create(AOwner:TComponent);
{$IFDEF EXTENDEDGRAPHICS}
var
 gfilter:string;
{$ENDIF}
begin
 inherited Create(AOwner);

 fpdfdriver:=TRpPdfDriver.Create;

 TFRpObjInspVCL(Owner).OpenDialog1.Filter:=
  SrpBitmapImages+'|*.bmp|'+
  SrpSJpegImages+'|*.jpg|';
//  SrpSPNGImages+'|*.png|'+
//  SRpSXPMImages+'|*.xpm';
 // Add Registered file formats
 // Add registered filters
{$IFDEF EXTENDEDGRAPHICS}
 gfilter:=rpgraphicex.FileFormatList.GetGraphicFilter([],fstExtension,[foIncludeExtension],nil);
 TFRpObjInspVCL(Owner).OpenDialog1.Filter:=TFRpObjInspVCL(Owner).OpenDialog1.Filter+gfilter;
(* TFRpObjInspVCL(Owner).OpenDialog1.Filter:=TFRpObjInspVCL(Owner).OpenDialog1.Filter+
  'PCX '+'|*.pcx|'+
  'GIF '+'|*.gif|'+
  'PNG '+'|*.png|'+
  'TIFF '+'|*.tiff|'+
  'TIF '+'|*.tif|'+
  'FAX '+'|*.fax|'+
  'EPS '+'|*.eps|';*)
{$ENDIF}

 Align:=alClient;

 LNames:=TRpWideStrings.Create;
 LTypes:=TRpWideStrings.Create;
 LValues:=TRpWideStrings.Create;
 LHints:=TRpWideStrings.Create;
 LCat:=TRpWideStrings.Create;
 LLabels:=TList.Create;
 LControls:=TStringList.Create;
 LControls2:=TStringList.Create;
 LPages:=TStringList.Create;
 AList:=TStringList.Create;
 BorderStyle:=bsNone;
 BevelInner:=bvNone;
 BevelOuter:=bvNone;
end;

destructor TrpPanelObj.Destroy;
begin
 fpdfdriver.free;

 LNames.Free;
 LTypes.Free;
 LValues.Free;
 LLabels.Free;
 LControls.Free;
 LControls2.Free;
 LPages.Free;
 AList.Free;
 LCat.free;
 LHints.free;

 inherited Destroy;
end;


procedure TRpPanelObj.AssignPropertyValues;
var
 FRpMainF:TFRpMainFVCL;
 i,k,j:integer;
 typename:String;
 control,control2:TControl;
 currvalue:Currency;
 secint:TRpSectionInterface;
 asecitem:TRpSizeInterface;
 aitem:TRpSizeInterface;
 selecteditems:TStringList;
 doassign:Boolean;
begin
 FRpMainF:=TFRpMainFVCL(Owner.Owner);
 selecteditems:=TFRpObjInspVCL(Owner).FSelectedItems;
 if NOt Assigned(FCompItem) then
 begin
  TFRpObjInspVCL(Owner).fchangesize.Control:=nil;
  FRpMainf.ACut.Enabled:=false;
  FRpMainf.ACopy.Enabled:=false;
  FRpMainf.AHide.Enabled:=false;
  FRpMainf.APaste.Enabled:=false;
  FRpMainf.ALeft.Enabled:=false;
  FRpMainf.ARight.Enabled:=false;
  FRpMainf.AUp.Enabled:=false;
  FRpMainf.ADown.Enabled:=false;
  FRpMainf.AAlignLeft.Enabled:=false;
  FRpMainf.AAlignRight.Enabled:=false;
  FRpMainf.AAlignUp.Enabled:=false;
  FRpMainf.AAlignDown.Enabled:=false;
  FRpMainf.AAlignHorz.Enabled:=false;
  FRpMainf.AAlignVert.Enabled:=false;

  // Assigns the datasets
  ComboAlias.OnChange:=nil;
  alist.clear;
  alist.add(' ');
  for i:=0 to FRpMainf.report.DataInfo.Count-1 do
  begin
   alist.Add(FRpMainf.report.DataInfo.items[i].Alias);
  end;
  ComboAlias.Items.Assign(alist);
  ComboAlias.Itemindex:=ComboAlias.Items.IndexOf(subrep.Alias);
  ComboAlias.OnChange:=ComboAliasChange;
  ComboPrintOnly.OnChange:=ComboPrintOnlyChange;
  if subrep.PrintOnlyIfDataAvailable then
   ComboPrintOnly.ItemIndex:=1
  else
   ComboPrintOnly.ItemIndex:=0;
  exit;
 end;
 if FCompItem is TRpSizePosInterface then
 begin
  if selecteditems.count<2 then
  begin
   TFRpObjInspVCL(Owner).fchangesize.GridEnabled:=FRpMainf.report.GridEnabled;
   TFRpObjInspVCL(Owner).fchangesize.GridX:=FRpMainf.report.GridWidth;
   TFRpObjInspVCL(Owner).fchangesize.GridY:=FRpMainf.report.GridHeight;
   TFRpObjInspVCL(Owner).fchangesize.Control:=FCompItem;
   secint:=TrpSectionInterface(TRpSizePosInterface(FCompItem).SectionInt);
   FRpMainf.AAlignLeft.Enabled:=false;
   FRpMainf.AAlignRight.Enabled:=false;
   FRpMainf.AAlignUp.Enabled:=false;
   FRpMainf.AAlignDown.Enabled:=false;
   FRpMainf.AAlignHorz.Enabled:=false;
   FRpMainf.AAlignVert.Enabled:=false;
  end
  else
  begin
   TFRpObjInspVCL(Owner).fchangesize.Control:=nil;
   secint:=TrpSectionInterface(TRpSizePosInterface(SelectedItems.Objects[0]).SectionInt);
   FRpMainf.AAlignLeft.Enabled:=true;
   FRpMainf.AAlignRight.Enabled:=true;
   FRpMainf.AAlignUp.Enabled:=true;
   FRpMainf.AAlignDown.Enabled:=true;
   if selecteditems.count>2 then
   begin
    FRpMainf.AAlignHorz.Enabled:=true;
    FRpMainf.AAlignVert.Enabled:=true;
   end
   else
   begin
    FRpMainf.AAlignHorz.Enabled:=false;
    FRpMainf.AAlignVert.Enabled:=false;
   end;
  end;
  FRpMainf.ACut.Enabled:=true;
  FRpMainf.ADelete.Enabled:=true;
  FRpMainf.ACopy.Enabled:=true;
  FRpMainf.AHide.Enabled:=true;
  FRpMainf.ALeft.Enabled:=true;
  FRpMainf.ARight.Enabled:=true;
  FRpMainf.AUp.Enabled:=true;
  FRpMainf.ADown.Enabled:=true;
 end
 else
 begin
  TFRpObjInspVCL(Owner).fchangesize.Control:=nil;
  secint:=TrpSectionInterface(FCompItem);
  FRpMainf.ACut.Enabled:=False;
  FRpMainf.ADelete.Enabled:=False;
  FRpMainf.ACopy.Enabled:=False;
  FRpMainf.AHide.Enabled:=False;
  FRpMainf.ALeft.Enabled:=false;
  FRpMainf.ARight.Enabled:=false;
  FRpMainf.AUp.Enabled:=false;
  FRpMainf.ADown.Enabled:=false;
  FRpMainf.AAlignLeft.Enabled:=false;
  FRpMainf.AAlignRight.Enabled:=false;
  FRpMainf.AAlignUp.Enabled:=false;
  FRpMainf.AAlignDown.Enabled:=false;
  FRpMainf.AAlignHorz.Enabled:=false;
  FRpMainf.AAlignVert.Enabled:=false;
 end;
 FRpMainf.APaste.Enabled:=true;

 // Assigns combo values
 combo.OnChange:=nil;
 alist.clear;
 alist.Add(' ');
 for i:=0 to secint.childlist.count-1 do
 begin
  asecitem:=TRpSizePosInterface(secint.childlist.items[i]);
  alist.AddObject(asecitem.PrintItem.Name,asecitem);
 end;
 combo.items.assign(alist);
 if (selectedItems.Count>1) then
 begin
  combo.Itemindex:=-1;
 end
 else
 begin
  if FCompItem is TRpSizePosInterface then
   combo.Itemindex:=alist.Indexof(FCompItem.Printitem.Name)
  else
   combo.Itemindex:=-1;
 end;
 combo.OnChange:=ComboObjectChange;

 // Get the property description for common component of
 // multiselect
 FCompItem.GetProperties(LNames,LTypes,nil,LHints,LCat);
 LValues.Assign(LNames);
 for k:=0 to selecteditems.count-1 do
 begin
  aitem:=TRpSizeInterface(selecteditems.Objects[k]);
  for j:=0 to LNames.Count-1 do
  begin
   LValues.Strings[j]:=aitem.GetProperty(LNames.Strings[j]);
  end;
  for i:=0 to LNames.Count-1 do
  begin
   typename:=LTypes.Strings[i];
   if LTypes.Strings[i]=SRpSBool then
   begin
    Control:=TControl(LControls.Objects[i]);
    Control2:=TControl(LControls2.Objects[i]);
    if k=0 then
    begin
     TCOmboBox(Control).OnChange:=nil;
     TComboBox(Control).ItemIndex:=TComboBox(Control).Items.IndexOf(LValues.Strings[i]);
     TCOmboBox(Control).OnChange:=EditChange;

     TCOmboBox(Control2).OnChange:=nil;
     TComboBox(Control2).ItemIndex:=TComboBox(Control).Items.IndexOf(LValues.Strings[i]);
     TCOmboBox(Control2).OnChange:=EditChange;
    end
    else
    begin
     if TComboBox(Control).ItemIndex>=0 then
     begin
      if TComboBox(Control).Items.IndexOf(LValues.Strings[i])<>TComboBox(Control).ItemIndex then
      begin
       TComboBox(Control).OnChange:=nil;
       TComboBox(Control).ItemIndex:=-1;
       TCOmboBox(Control).OnChange:=EditChange;

       TComboBox(Control2).OnChange:=nil;
       TComboBox(Control2).ItemIndex:=-1;
       TCOmboBox(Control2).OnChange:=EditChange;
      end;
     end;
    end;
   end
   else
   if LTypes.Strings[i]=SRpSList then
   begin
    Control:=TControl(LControls.Objects[i]);
    Control2:=TControl(LControls2.Objects[i]);
    if k=0 then
    begin
     TCOmboBox(Control).OnChange:=nil;
     TComboBox(Control).ItemIndex:=TComboBox(Control).Items.IndexOf(LValues.Strings[i]);
     TCOmboBox(Control).OnChange:=EditChange;

     TCOmboBox(Control2).OnChange:=nil;
     TComboBox(Control2).ItemIndex:=TComboBox(Control).Items.IndexOf(LValues.Strings[i]);
     TCOmboBox(Control2).OnChange:=EditChange;
    end
    else
    begin
     if TComboBox(Control).ItemIndex<>TComboBox(Control).Items.IndexOf(LValues.Strings[i]) then
     begin
      TComboBox(Control).OnChange:=nil;
      TComboBox(Control).ItemIndex:=-1;
      TCOmboBox(Control).OnChange:=EditChange;

      TComboBox(Control2).OnChange:=nil;
      TComboBox(Control2).ItemIndex:=-1;
      TCOmboBox(Control2).OnChange:=EditChange;
     end;
    end;
   end
   else
   if LTypes.Strings[i]=SRpSColor then
   begin
    Control:=TControl(LControls.Objects[i]);
    Control2:=TControl(LControls2.Objects[i]);
    if k=0 then
    begin
     TShape(Control).Brush.Color:=StrToInt(LValues.Strings[i]);
     TShape(Control2).Brush.Color:=StrToInt(LValues.Strings[i]);
    end;
   end
   else
   if LTypes.Strings[i]=SRpSImage then
   begin
    Control:=TControl(LControls.Objects[i]);
    Control2:=TControl(LControls2.Objects[i]);
    if k=0 then
    begin
     TRpMaskEdit(Control).Text:=LValues.Strings[i];
     TRpMaskEdit(Control2).Text:=LValues.Strings[i];
    end
    else
    begin
     if Length(TRpMaskEdit(Control).Text)>0 then
      if TRpMaskEdit(Control).Text<>LValues.Strings[i] then
      begin
       TRpMaskEdit(Control2).Text:='';
       TRpMaskEdit(Control2).Text:='';
      end;
    end;
   end
   else
   if LTypes.Strings[i]=SRpGroup then
   begin
    Control:=TControl(LControls.Objects[i]);
    Control2:=TControl(LControls2.Objects[i]);
    if k=0 then
    begin
     subrep:=FRpMainf.freportstructure.FindSelectedSubreport;
     alist.clear;
     subrep.GetGroupNames(alist);
     alist.Insert(0,' ');
     TComboBox(Control).OnChange:=nil;
     TComboBox(Control).Items.Assign(alist);
     if aitem is TRpExpressionInterface then
      TComboBox(Control).ItemIndex:=TComboBox(Control).Items.IndexOf(
        TRpExpression(TRpExpressionInterface(aitem).printitem).GroupName);
     TComboBox(Control).OnChange:=EditChange;

     TComboBox(Control2).OnChange:=nil;
     TComboBox(Control2).Items.Assign(alist);
     if aitem is TRpExpressionInterface then
      TComboBox(Control2).ItemIndex:=TComboBox(Control2).Items.IndexOf(
        TRpExpression(TRpExpressionInterface(aitem).printitem).GroupName);
     TComboBox(Control2).OnChange:=EditChange;
    end
    else
    begin
     if aitem is TRpExpressionInterface then
      if  TComboBox(Control).ItemIndex<>TComboBox(Control).Items.IndexOf(
        TRpExpression(TRpExpressionInterface(aitem).printitem).GroupName) then
      begin
       TComboBox(Control).OnChange:=nil;
       TComboBox(Control).ItemIndex:=-1;
       TComboBox(Control).OnChange:=EditChange;

       TComboBox(Control2).OnChange:=nil;
       TComboBox(Control2).ItemIndex:=-1;
       TComboBox(Control2).OnChange:=EditChange;
      end;
    end;
   end
   else
   if LTypes.Strings[i]=SRpSFontStyle then
   begin
    Control:=TControl(LControls.Objects[i]);
    Control2:=TControl(LControls2.Objects[i]);
    if k=0 then
    begin
     TRpMaskEdit(Control).Text:=IntegerFontStyleToString(StrToInt(LValues.Strings[i]));
     TRpMaskEdit(Control2).Text:=IntegerFontStyleToString(StrToInt(LValues.Strings[i]));
    end
    else
    begin
     if TRpMaskEdit(Control).Text<>IntegerFontStyleToString(StrToInt(LValues.Strings[i])) then
     begin
      TRpMaskEdit(Control).Text:='';
      TRpMaskEdit(Control2).Text:='';
     end;
    end;
   end
   else
   if LTypes.Strings[i]=SRpSCurrency then
   begin
    Control:=TControl(LControls.Objects[i]);
    Control2:=TControl(LControls2.Objects[i]);
    if k=0 then
    begin
     doassign:=false;
     currvalue:=0;
     if Length(TRpMaskEdit(Control).Text)>0 then
     begin
      try
       currvalue:=StrToCurr(TRpMaskEdit(Control).Text);
      except
       doassign:=true;
      end;
     end
     else
      doassign:=true;
     if not doassign then
      if currvalue<>StrToCurr(LValues.Strings[i]) then
       doassign:=true;
     if doassign then
     begin
      TRpMaskEdit(Control).OnChange:=nil;
      TRpMaskEdit(Control).Text:=LValues.Strings[i];
      TRpMaskEdit(Control).OnChange:=EditChange;

      TRpMaskEdit(Control2).OnChange:=nil;
      TRpMaskEdit(Control2).Text:=LValues.Strings[i];
      TRpMaskEdit(Control2).OnChange:=EditChange;
     end;
    end
    else
    begin
     currvalue:=0;
     if Length(TRpMaskEdit(Control).Text)>0 then
     begin
      try
       currvalue:=StrToCurr(TRpMaskEdit(Control).Text);
      except
       currvalue:=-9999999.9898;
      end;
     end;
     if currvalue<>StrToCurr(LValues.Strings[i]) then
     begin
      TRpMaskEdit(Control).OnChange:=nil;
      TRpMaskEdit(Control).Text:='';
      TRpMaskEdit(Control).OnChange:=EditChange;

      TRpMaskEdit(Control2).OnChange:=nil;
      TRpMaskEdit(Control2).Text:='';
      TRpMaskEdit(Control2).OnChange:=EditChange;
     end;
    end;
   end
   else
   begin
    Control:=TControl(LControls.Objects[i]);
    Control2:=TControl(LControls2.Objects[i]);
{$IFDEF USETNTUNICODE}
    if (Control is TTntEdit) then
    begin
      if k=0 then
      begin
       TTntEdit(Control).OnChange:=nil;
       TTntEdit(Control).Text:=LValues.Strings[i];
       TTntEdit(Control).OnChange:=EditChange;

       TTntEdit(Control2).OnChange:=nil;
       TTntEdit(Control2).Text:=LValues.Strings[i];
       TTntEdit(Control2).OnChange:=EditChange;
      end
      else
      begin
       if TRpMaskEdit(Control).Text<>LValues.Strings[i] then
       begin
        TTntEdit(Control).OnChange:=nil;
        TTntEdit(Control).Text:='';
        TTntEdit(Control).OnChange:=EditChange;

        TTntEdit(Control2).OnChange:=nil;
        TTntEdit(Control2).Text:='';
        TTntEdit(Control2).OnChange:=EditChange;
       end;
      end;
    end
    else
{$ENDIF}
    if k=0 then
    begin
     TRpMaskEdit(Control).OnChange:=nil;
     TRpMaskEdit(Control).Text:=LValues.Strings[i];
     TRpMaskEdit(Control).OnChange:=EditChange;

     TRpMaskEdit(Control2).OnChange:=nil;
     TRpMaskEdit(Control2).Text:=LValues.Strings[i];
     TRpMaskEdit(Control2).OnChange:=EditChange;
    end
    else
    begin
     if TRpMaskEdit(Control).Text<>LValues.Strings[i] then
     begin
      TRpMaskEdit(Control).OnChange:=nil;
      TRpMaskEdit(Control).Text:='';
      TRpMaskEdit(Control).OnChange:=EditChange;

      TRpMaskEdit(Control2).OnChange:=nil;
      TRpMaskEdit(Control2).Text:='';
      TRpMaskEdit(Control2).OnChange:=EditChange;
     end;
    end;
   end;
  end;
 end;
end;

procedure TRpPanelObj.SelectProperty(propname:string);
var
 index:integer;
 AControl:TWinControl;
begin
 if assigned(FPControl) then
  FPControl.ActivePageIndex:=0;
 index:=LControls.IndexOf(propname);
 if index>=0  then
 begin
  AControl:=TWinControl(LControls.Objects[index]);
  AControl.SetFocus;
 end;
end;

procedure TRpPanelObj.DupValue(Sender:TControl);
var
 acontrol:TControl;
 oldonchange:TNotifyEvent;
begin
 acontrol:=TControl(LControls.Objects[Sender.Tag]);
 if acontrol=Sender then
  acontrol:=TControl(LControls2.Objects[Sender.Tag]);
 if acontrol=Sender then
  exit;
 if acontrol is TRpMaskEdit then
 begin
  oldonchange:=TRpMaskEdit(acontrol).OnChange;
  TRpMaskEdit(acontrol).OnChange:=nil;
  TRpMaskEdit(acontrol).Text:=TRpMaskEdit(Sender).Text;
  TRpMaskEdit(acontrol).OnChange:=OldOnChange;
 end
 else
 if acontrol is TComboBox then
 begin
  oldonchange:=TComboBox(acontrol).OnChange;
  TComboBox(acontrol).OnChange:=nil;
  if TComboBox(acontrol).Style=csDropDownList then
   TComboBox(acontrol).ItemIndex:=TComboBox(Sender).ItemIndex
  else
   TComboBox(acontrol).Text:=TComboBox(Sender).Text;
  TComboBox(acontrol).OnChange:=OldOnChange;
 end
{$IFDEF USETNTUNICODE}
 else
 if (aControl is TTntEdit) then
 begin
  oldonchange:=TTntEdit(acontrol).OnChange;
  TTntEdit(acontrol).OnChange:=nil;
  TTntEdit(acontrol).Text:=TTntEdit(Sender).Text;
  TTntEdit(acontrol).OnChange:=OldOnChange;
 end
{$ENDIF}
 else
 if acontrol is TShape then
 begin
  TShape(acontrol).Brush.Color:=TShape(Sender).Brush.Color;
 end;
end;


procedure TRpPanelObj.EditChange(Sender:TObject);
var
 index:integer;
 aname:string;
 FRpMainf:TFRpMainFVCL;
begin
 DupValue(TControl(Sender));
 index:=TControl(Sender).tag;
 aname:=Lnames.strings[index];
 if FSelectedItems.Count<2 then
 begin
{$IFDEF USETNTUNICODE}
  if Sender is TTntEdit then
  begin
   FCompItem.SetProperty(aname,TTntEdit(Sender).Text);
  end
  else
{$ENDIF}
  if Sender is TRpMaskEdit then
  begin
   FCompItem.SetProperty(aname,String(TRpMaskEdit(Sender).Value));
  end
  else
   FCompItem.SetProperty(aname,TRpMaskEdit(Sender).Text);
  if (FCompItem is TRpSectionInterface) then
  begin
   if ((aname=SRpsWidth) or (aname=SRpsHeight)) then
    if Assigned(TFRpObjInspVCL(Owner).FDesignFrame) then
     TFRpDesignFrameVCL(TFRpObjInspVCL(Owner).FDesignFrame).UpdateInterface(false);
  end;
  // If the property es positional update position
  if Assigned(TFRpObjInspVCL(Owner).fchangesize) then
  begin
   if ((aname=SRpSWidth) or (aname=SRpsHeight) or
    (aname=SRpSTop) or (aname=SRpSLeft)) then
   begin
    TFRpObjInspVCL(Owner).fchangesize.UpdatePos;
   end;
  end;
  // If is a group, invalidate captions
  if aname=SRpSGroupName then
  begin
   TFRpDesignFrameVCL(TFRpObjInspVCL(Owner).FDesignframe).InvalidateCaptions;
   TFRpDesignFrameVCL(TFRpObjInspVCL(Owner).FDesignframe).freportstructure.UpdateCaptions;
  end;
 end
 else
 begin
{$IFDEF USETNTUNICODE}
  if Sender is TTntEdit then
  begin
   SetPropertyFull(aname,TTntEdit(Sender).Text);
  end
  else
{$ENDIF}
  if Sender is TRpMaskEdit then
  begin
   SetPropertyFull(aname,String(TRpMaskEdit(Sender).Value));
  end
  else
   SetPropertyFull(aname,TRpMaskEdit(Sender).Text);
 end;
 if aname=SRpChildSubRep then
 begin
  FRpMainf:=TFRpMainFVCL(Owner.Owner);
  FRpMainf.freportstructure.RView.Selected.Text:=TRpSection(FRpMainf.freportstructure.RView.Selected.Data).SectionCaption(true);
 end;
end;

procedure TRpPanelObj.ShapeMouseUp(Sender: TObject; Button: TMouseButton;
     Shift: TShiftState; X, Y: Integer);
var
 AShape:TShape;
begin
 AShape:=TShape(Sender);
 TFRpObjInspVCL(Owner).ColorDialog1.COlor:=StrToInt(LValues.Strings[AShape.Tag]);
 if TFRpObjInspVCL(Owner).ColorDialog1.Execute then
 begin
  AShape.Brush.Color:=TFRpObjInspVCL(Owner).ColorDialog1.Color;
  SetPropertyFull(Lnames.strings[AShape.Tag],IntToStr(TFRpObjInspVCL(Owner).ColorDialog1.Color));
  DupValue(TControl(Sender));
 end;
end;

procedure TRpPanelObj.FontClick(Sender:TObject);
var
 index:integer;
 aitem:TRpSizeInterface;
begin
 if FSelectedItems.Count<2 then
 begin
  aitem:=FCompItem;
 end
 else
 begin
  aitem:=TRpSizeInterface(FSelectedItems.Objects[0]);
 end;
 TFRpObjInspVCL(Owner).FontDialog1.Font.Name:=aitem.GetProperty(SRpSWFontName);
 TFRpObjInspVCL(Owner).FontDialog1.Font.Size:= StrToInt(aitem.GetProperty(SRpSFontSize));
 TFRpObjInspVCL(Owner).FontDialog1.Font.Color:= StrToInt(aitem.GetProperty(SRpSFontColor));
 TFRpObjInspVCL(Owner).FontDialog1.Font.Style:=CLXIntegerToFontStyle(StrToInt(aitem.GetProperty(SrpSFontStyle)));
 if TFRpObjInspVCL(Owner).FontDialog1.Execute then
 begin
  index:=TComponent(Sender).Tag;
  if index>=0 then
  begin
   TRpMaskEdit(LControls.Objects[index]).Text:=TFRpObjInspVCL(Owner).FontDialog1.Font.Name;
   TRpMaskEdit(LControls2.Objects[index]).Text:=TFRpObjInspVCL(Owner).FontDialog1.Font.Name;
  end;
  index:=LNames.IndexOf(SrpSFontSize);
  if index>=0 then
  begin
   TRpMaskEdit(LControls.Objects[index]).Text:=IntToStr(TFRpObjInspVCL(Owner).FontDialog1.Font.Size);
   TRpMaskEdit(LControls2.Objects[index]).Text:=IntToStr(TFRpObjInspVCL(Owner).FontDialog1.Font.Size);
  end;
  index:=LNames.IndexOf(SrpSFontColor);
  if index>=0 then
  begin
   TShape(LControls.Objects[index]).Brush.Color:=TFRpObjInspVCL(Owner).FontDialog1.Font.Color;
   TShape(LControls2.Objects[index]).Brush.Color:=TFRpObjInspVCL(Owner).FontDialog1.Font.Color;
   SetPropertyFull(SRpSFontColor,IntToStr(TFRpObjInspVCL(Owner).FontDialog1.Font.Color));
  end;
  index:=LNames.IndexOf(SrpSFontStyle);
  if index>=0 then
  begin
   TRpMaskEdit(LControls.Objects[index]).Text:=IntegerFontStyleToString(FontStyleToCLXInteger(TFRpObjInspVCL(Owner).Fontdialog1.Font.Style));
   TRpMaskEdit(LControls2.Objects[index]).Text:=IntegerFontStyleToString(FontStyleToCLXInteger(TFRpObjInspVCL(Owner).Fontdialog1.Font.Style));
   SetPropertyFull(SRpSFontStyle,IntToStr(FontStyleToCLXInteger(TFRpObjInspVCL(Owner).Fontdialog1.Font.Style)));
  end;
 end;
end;

end.


