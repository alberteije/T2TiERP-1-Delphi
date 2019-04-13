{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rprfparams                                      }
{                                                       }
{       User parameters form                            }
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

unit rprfparams;

interface

{$I rpconf.inc}

uses SysUtils, Classes, QGraphics, QForms,
  QButtons, QExtCtrls, QControls, QStdCtrls,QCheckLst,
  rpmdconsts,rpmaskeditclx,rpgraphutils,
{$IFNDEF FORWEBAX}
  rpmdfsearch,
{$ENDIF}
  Variants,rptypes,
  rpparams;

const
  CONS_LEFTGAP=3;
  CONS_LABELTOPGAP=2;
  CONS_CONTROLGAP=5;
  CONS_RIGHTBARGAP=25;
  CONS_NULLWIDTH=50;
  CONS_SEARCH=25;
  CONS_MAXCLIENTHEIGHT=400;
type
  TFRpRunTimeParams = class(TForm)
    PModalButtons: TPanel;
    BOK: TButton;
    BCancel: TButton;
    MainScrollBox: TScrollBox;
    PParent: TPanel;
    PLeft: TPanel;
    Splitter1: TSplitter;
    PRight: TPanel;
    procedure BOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BSearchClick(Sender: TObject);
  private
    { Private declarations }
{$IFNDEF FORWEBAX}
    report:TComponent;
{$ENDIF}
    fparams:TRpParamList;
    dook:boolean;
    lnulls,lcontrols:TStringList;
    procedure SetParams(avalue:TRpParamList);
    procedure SaveParams;
  public
    { Public declarations }
    procedure CheckNullClick(Sender:TObject);
    property params:TRpParamList read fparams write Setparams;
  end;


function ShowUserParams(params:TRpParamList):boolean;

implementation

{$IFNDEF FORWEBAX}
  uses rpreport,rpbasereport;
{$ENDIF}


{$R *.xfm}

function ShowUserParams(params:TRpParamList):boolean;
var
 dia:TFRpRunTimeParams;
 oneparam:boolean;
 i:integer;
begin
 Result:=false;
 oneparam:=false;
 for i:=0 to params.count-1 do
 begin
  if (params.items[i].Visible and (not params.items[i].NeverVisible)) then
  begin
   oneparam:=true;
   break;
  end;
 end;
 if not oneparam then
 begin
  Result:=true;
  exit;
 end;
{$IFNDEF FORWEBAX}
 params.UpdateLookup;
 params.UpdateInitialValues;
{$ENDIF}
 dia:=TFRpRunTimeParams.Create(Application);
 try
  dia.params:=Params;
  dia.showmodal;
  if dia.dook then
  begin
   params.Assign(dia.Params);
   Result:=true;
  end;
 finally
  dia.Free;
 end;
end;

procedure TFRpRunTimeParams.BOKClick(Sender: TObject);
{$IFNDEF FORWEBAX}
var
 paramname,amessage:String;
 aparam:TRpParam;
 acontrol:TControl;
 index:integer;
{$ENDIF}
begin
{$IFNDEF FORWEBAX}
 if not Trpbasereport(report).CheckParameters(params,paramname,amessage) then
 begin
  aparam:=TRpBaseReport(report).Params.ParamByName(paramname);
  RpMessageBox(amessage,aparam.Description);
  index:=lcontrols.IndexOf(paramname);
  if index>=0 then
  begin
   acontrol:= TControl(lcontrols.Objects[index]);
   if acontrol.Enabled then
    TWinControl(acontrol).SetFocus;
  end;
  exit;
 end;
{$ENDIF}
 SaveParams;
 // Check parameters
{$IFNDEF FORWEBAX}
 if not Trpbasereport(report).CheckParameters(params,paramname,amessage) then
 begin
  aparam:=TRpBaseReport(report).Params.ParamByName(paramname);
  RpMessageBox(amessage,aparam.Description);
  index:=lcontrols.IndexOf(paramname);
  if index>=0 then
  begin
   acontrol:= TControl(lcontrols.Objects[index]);
   if acontrol.Enabled then
    TWinControl(acontrol).SetFocus;
  end;
  exit;
 end;
{$ENDIF}
 dook:=true;
 close;
end;

procedure TFRpRunTimeParams.FormCreate(Sender: TObject);
begin
 fparams:=TRpParamList.Create(Self);
 lcontrols:=TStringList.Create;
 lnulls:=TStringList.Create;
 Caption:=TranslateStr(238,Caption);
 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
end;


function calcdefaultheight(fontsize:integer):integer;
var
 Edit:TEdit;
begin
 Edit:=TEDit.Create(nil);
 try
  Edit.Font.Size:=fontsize;
  Edit.Text:='MMg';
  Result:=Edit.Height;
 finally
  Edit.free;
 end;
end;

procedure TFRpRunTimeParams.SetParams(avalue:TRpParamList);
var
 i,j,index:integer;
 alabel:TLabel;
 acontrol:TControl;
 posy:integer;
 aparam:TRpParam;
 TotalWidth:integer;
 achecknull:TCheckBox;
{$IFNDEF FORWEBAX}
 bbutton:TButton;
 defheight:integer;
{$ENDIF}
 NewClientHeight:integer;
begin
{$IFNDEF FORWEBAX}
 defheight:=calcdefaultheight(Font.Size);
 report:=avalue.Report;
 aparam:=avalue.FindParam('LANGUAGE');
 if Assigned(aparam) then
  TRpBaseReport(report).Language:=aparam.Value;
{$ENDIF}
 acontrol:=nil;
 fparams.assign(avalue);
 TotalWidth:=PRight.Width-CONS_NULLWIDTH-CONS_SEARCH-CONS_LEFTGAP-CONS_RIGHTBARGAP;
 posy:=CONS_CONTROLGAP;
 // Creates all controls from params
 for i:=0 to fparams.Count-1 do
 begin
  aparam:=fparams.Items[i];
  if ((aparam.Visible) and (not aparam.NeverVisible)) then
  begin
   alabel:=TLabel.Create(Self);
   alabel.Caption:=aparam.Description;
   aLabel.Left:=CONS_LEFTGAP;
   aLabel.Top:=posy+CONS_LABELTOPGAP;
   aLabel.Hint:=aparam.Hint;
   alabel.Parent:=PLeft;
   achecknull:=TCheckBox.Create(Self);
   achecknull.Top:=posy-5;
   achecknull.Tag:=i;
   achecknull.Width:=CONS_NULLWIDTH;
   achecknull.Left:=TotalWidth+CONS_SEARCH+CONS_LEFTGAP;
   achecknull.Caption:=SRpNull;
   achecknull.Anchors:=[akTop,akRight];
   achecknull.Parent:=PRight;
   achecknull.OnClick:=CheckNullClick;
   achecknull.Visible:=aparam.AllowNulls;
   lnulls.AddObject(aparam.Name,acheckNull);

{$IFNDEF FORWEBAX}
   bbutton:=TButton.Create(Self);
   bbutton.Top:=posy;
   bbutton.Tag:=i;
   bbutton.Width:=CONS_SEARCH;
   bbutton.Left:=TotalWidth;
   bbutton.Height:=defheight;
   bbutton.Caption:='...';
   bbutton.Parent:=PRight;
   bbutton.OnClick:=BSearchClick;
   bbutton.VIsible:=false;
{$ENDIF}

   case aparam.ParamType of
    rpParamString,rpParamExpreA,rpParamExpreB,rpParamSubst,rpParamSubstE,rpParamUnknown:
     begin
      acontrol:=TEdit.Create(Self);
      if aparam.IsReadOnly then
      begin
       TEdit(acontrol).Color:=Self.Color;
      end;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      TEdit(acontrol).Text:='';
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       TEdit(acontrol).Text:=aparam.Value;
      end;
{$IFNDEF FORWEBAX}
      bbutton.Visible:=Length(aparam.SearchDataset)>0;
{$ENDIF}
     end;
   rpParamInteger,rpParamDouble,rpParamCurrency:
     begin
      acontrol:=TRpCLXMaskEdit.Create(Self);
      if aparam.IsReadOnly then
      begin
       TRpCLXMaskEdit(acontrol).Color:=Self.Color;
      end;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      TEdit(acontrol).Text:='0';
      TRpCLXMaskEdit(acontrol).DisplayMask:='####,##0.##';
      if aparam.ParamType=rpParamInteger then
       TRpCLXMaskEdit(acontrol).EditType:=teInteger
      else
       TRpCLXMaskEdit(acontrol).EditType:=teCurrency;
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       TEdit(acontrol).Text:=VarToStr(aparam.Value);
      end;
{$IFNDEF FORWEBAX}
      bbutton.Visible:=Length(aparam.SearchDataset)>0;
{$ENDIF}
     end;
   rpParamDate:
     begin
      acontrol:=TEdit.Create(Self);
      if aparam.IsReadOnly then
      begin
       TEdit(acontrol).Color:=Self.Color;
      end;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      TEdit(acontrol).Text:=DateToStr(Date);
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       TEdit(acontrol).Text:=DateToStr(aparam.Value);
      end;
     end;
   rpParamTime:
     begin
      acontrol:=TEdit.Create(Self);
      if aparam.IsReadOnly then
      begin
       TEdit(acontrol).Color:=Self.Color;
      end;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      TEdit(acontrol).Text:=TimeToStr(Time);
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       TEdit(acontrol).Text:=TimeToStr(aparam.Value);
      end;
     end;
   rpParamDateTime:
     begin
      acontrol:=TEdit.Create(Self);
      if aparam.IsReadOnly then
      begin
       TEdit(acontrol).Color:=Self.Color;
      end;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      TEdit(acontrol).Text:=DateTimeToStr(now);
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       TEdit(acontrol).Text:=DateTimeToStr(aparam.Value);
      end;
     end;
   rpParamBool:
     begin
      acontrol:=TComboBox.Create(Self);
      if aparam.IsReadOnly then
      begin
       TComboBox(acontrol).Color:=Self.Color;
      end;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      TComboBox(acontrol).Style:=csDropDownList;
      TComboBox(acontrol).Items.Add(BoolToStr(false,true));
      TComboBox(acontrol).Items.Add(BoolToStr(true,true));
      TComboBox(acontrol).ItemIndex:=0;
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       if aparam.value then
        TComboBox(acontrol).ItemIndex:=1
       else
        TComboBox(acontrol).ItemIndex:=0;
      end;
     end;
   rpParamMultiple:
     begin
      acontrol:=TCheckListBox.Create(Self);
      if aparam.IsReadOnly then
      begin
       TCheckListBox(acontrol).Color:=Self.Color;
      end;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      // Can't add items without a parent
      acontrol.parent:=MainScrollBox;
      TCheckListBox(acontrol).Items.Assign(aparam.Items);
      for j:=0 to TCheckListBox(acontrol).Items.Count-1 do
       TCheckListBox(acontrol).Checked[j]:=false;
      for j:=0 to aparam.Selected.Count-1 do
      begin
       index:=StrToInt(aparam.Selected.Strings[j]);
       if TCheckListBox(acontrol).Items.Count>index then
        TCheckListBox(acontrol).Checked[index]:=true;
      end;
      index:=TCheckListBox(acontrol).Items.Count;
      if index>5 then
       index:=5;
      acontrol.Height:=(index+1)*Self.Canvas.TextHeight('Mg');
     end;
   rpParamList,rpParamSubstList:
     begin
      acontrol:=TComboBox.Create(Self);
      if aparam.IsReadOnly then
      begin
       TComboBox(acontrol).Color:=Self.Color;
      end;
      TComboBox(acontrol).Style:=csDropDownList;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      // Can't add items without a parent
      acontrol.parent:=MainScrollBox;
      TComboBox(acontrol).Items.Assign(aparam.Items);
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       TComboBox(acontrol).ItemIndex:=aparam.Values.IndexOf(aparam.Value);
      end;
     end;
   end;
   acontrol.Top:=Posy;
   acontrol.Hint:=aparam.Hint;
   if aparam.IsReadOnly then
   begin
    acontrol.Enabled:=false;
   end;

   acontrol.Left:=CONS_LEFTGAP;
   acontrol.Width:=TotalWidth-acontrol.Left;
   acontrol.parent:=PRight;
   acontrol.Anchors:=[akLeft,akTop,akRight];
   if aparam.allownulls then
    if VarIsNull(aparam.Value) then
     acontrol.Visible:=false;
   if Not assigned(ActiveControl) then
    if (acontrol.Visible and acontrol.enabled) then
     ActiveControl:=TWidgetControl(acontrol);
   Posy:=PosY+acontrol.Height+CONS_CONTROLGAP;
  end
  else
  begin
   lcontrols.AddObject('',nil);
   lnulls.AddObject('',nil);
  end;
 end;
 PParent.Height:=PosY;
 // Set the height of the form
 NewClientHeight:=PModalButtons.Height+PosY+CONS_CONTROLGAP;
 if  NewClientHeight>CONS_MAXCLIENTHEIGHT then
  NewClientHeight:=CONS_MAXCLIENTHEIGHT;
 ClientHeight:=NewClientHeight;
 SetInitialBounds;
end;

procedure TFRpRunTimeParams.FormDestroy(Sender: TObject);
begin
 lcontrols.free;
 lnulls.free;
 fparams.free;
end;

procedure TFRpRunTimeParams.CheckNullClick(Sender:TObject);
begin
 if TCheckBox(Sender).Checked then
 begin
  TControl(lcontrols.Objects[TCheckBox(Sender).Tag]).Visible:=false;
 end
 else
 begin
  TControl(lcontrols.Objects[TCheckBox(Sender).Tag]).Visible:=true;
 end;
end;

procedure TFRpRunTimeParams.SaveParams;
var
 i,j,index:integer;
begin
 for i:=0 to fparams.Count-1 do
 begin
  if fparams.items[i].Visible then
  begin
   if TCheckBox(Lnulls.Objects[i]).Checked then
   begin
    fparams.items[i].Value:=Null;
   end
   else
   begin
    case fparams.Items[i].ParamType of
     rpParamString:
      begin
       fparams.items[i].Value:=TEdit(LControls.Objects[i]).Text;
      end;
     rpParamInteger:
      begin
       fparams.items[i].Value:=StrToInt(TEdit(LControls.Objects[i]).Text);
      end;
     rpParamDouble:
      begin
       fparams.items[i].Value:=StrToFloat(TEdit(LControls.Objects[i]).Text);
      end;
     rpParamCurrency:
      begin
       fparams.items[i].Value:=StrtoCurr(TEdit(LControls.Objects[i]).Text);
      end;
     rpParamDate:
      begin
       fparams.items[i].Value:=StrtoDate(TEdit(LControls.Objects[i]).Text);
      end;
     rpParamTime:
      begin
       fparams.items[i].Value:=StrtoTime(TEdit(LControls.Objects[i]).Text);
      end;
     rpParamDateTime:
      begin
       fparams.items[i].Value:=StrtoDateTime(TEdit(LControls.Objects[i]).Text);
      end;
     rpParamBool:
      begin
       fparams.items[i].Value:=StrtoBool(TComboBox(LControls.Objects[i]).Text);
      end;
     rpParamMultiple:
      begin
       fparams.items[i].Selected.Clear;
       for j:=0 to TCheckListBox(LControls.Objects[i]).Items.Count-1 do
       begin
        if TCheckListBox(LControls.Objects[i]).Checked[j] then
         fparams.items[i].Selected.Add(IntToStr(j));
       end;
      end;
     rpParamList,rpParamSubstList:
      begin
       index:=TComboBox(LControls.Objects[i]).ItemIndex;
       if index<fparams.items[i].Values.Count then
        fparams.items[i].Value:=fparams.items[i].Values.Strings[index]
       else
        fparams.items[i].Value:='';
      end;
      else
      begin
       fparams.items[i].Value:=TEdit(LControls.Objects[i]).Text;
      end;
    end;
   end;
  end;
 end;
end;

procedure TFRpRunTimeParams.BSearchClick(Sender: TObject);
begin
 // Lookup using a dataset
{$IFNDEF FORWEBAX}
  rpmdfsearch.ParamValueSearch(params.Items[TComponent(Sender).Tag],TRpReport(report));
{$ENDIF}
end;

end.
