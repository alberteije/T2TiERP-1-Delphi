{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rprfvarams                                      }
{                                                       }
{       User parameters form (VCL version)              }
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

unit rprfvparams;

interface

{$I rpconf.inc}

uses SysUtils, Classes,Windows,
  Graphics, Forms,
  Buttons, ExtCtrls, Controls, StdCtrls,
  rpmdconsts,rptypes,ComCtrls,rpmaskedit,checklst,
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
{$IFNDEF FORWEBAX}
  rpmdfsearchvcl,
{$ENDIF}
  rpparams,rpgraphutilsvcl;

const
  CONS_LEFTGAP=3;
  CONS_LABELTOPGAP=2;
  CONS_CONTROLGAP=5;
  CONS_RIGHTBARGAP=25;
  CONS_NULLWIDTH=50;
  CONS_SEARCH=25;
  CONS_MAXCLIENTHEIGHT=400;
type
  TFRpRTParams = class(TForm)
    PModalButtons: TPanel;
    BOK: TButton;
    BCancel: TButton;
    MainScrollBox: TScrollBox;
    PParent: TPanel;
    Splitter1: TSplitter;
    PLeft: TPanel;
    PRight: TPanel;
    procedure BOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BSearchClick(Sender: TObject);
  private
    { Private declarations }
    fparams:TRpParamList;
    dook:boolean;
    lnulls,lcontrols,lcontrols2:TStringList;
{$IFNDEF FORWEBAX}
    report:TComponent;
{$ENDIF}
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


{$R *.dfm}


function ShowUserParams(params:TRpParamList):boolean;
var
 dia:TFRpRTParams;
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
 dia:=TFRpRTParams.Create(Application);
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

procedure TFRpRTParams.BOKClick(Sender: TObject);
{$IFNDEF FORWEBAX}
var
 paramname,amessage:String;
 aparam:TRpParam;
 acontrol:TControl;
 index:integer;
{$ENDIF}
begin
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

procedure TFRpRTParams.FormCreate(Sender: TObject);
begin
 fparams:=TRpParamList.Create(Self);
 lcontrols:=TStringList.Create;
 lcontrols2:=TStringList.Create;
 lnulls:=TStringList.Create;
 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
 Caption:=TranslateStr(238,Caption);
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


procedure TFRpRTParams.SetParams(avalue:TRpParamList);
var
 i,j,index:integer;
 alabel:TLabel;
 acontrol:TControl;
 posy:integer;
 aparam:TRpParam;
 TotalWidth:integer;
 achecknull:TCheckBox;
 NewClientHeight:integer;
 acontrol2:TControl;
{$IFNDEF FORWEBAX}
 bbutton:TButton;
 defheight:integer;
{$ENDIF}
begin
{$IFNDEF FORWEBAX}
 defheight:=calcdefaultheight(Font.Size);
 report:=avalue.Report;
 aparam:=avalue.FindParam('LANGUAGE');
 if Assigned(aparam) then
  TRpBaseReport(report).Language:=aparam.Value;
{$ENDIF}
 fparams.assign(avalue);
 TotalWidth:=PRight.Width-CONS_NULLWIDTH-CONS_SEARCH-CONS_LEFTGAP-CONS_RIGHTBARGAP;
 posy:=CONS_CONTROLGAP;
 // Creates all controls from params
 for i:=0 to fparams.Count-1 do
 begin
  acontrol:=nil;
  acontrol2:=nil;
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
   achecknull.Top:=posy;
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
   bbutton.Anchors:=[akTop,akRight];
   bbutton.Parent:=PRight;
   bbutton.OnClick:=BSearchClick;
   bbutton.Visible:=false;
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
      lcontrols2.AddObject(aparam.Name,acontrol);
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
      acontrol:=TRpMaskEdit.Create(Self);
      if aparam.IsReadOnly then
      begin
       TRpMaskEdit(acontrol).Color:=Self.Color;
      end;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      lcontrols2.AddObject(aparam.Name,acontrol);
      TEdit(acontrol).Text:='0';
      TRpMaskEdit(acontrol).DisplayMask:='####,##0.##';
      if aparam.ParamType=rpParamInteger then
       TRpMaskEdit(acontrol).EditType:=teInteger
      else
       TRpMaskEdit(acontrol).EditType:=teCurrency;
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
      acontrol:=TDateTimePicker.Create(Self);
      if aparam.IsReadOnly then
      begin
       TDateTimePicker(acontrol).Color:=Self.Color;
      end;
      TDateTimePicker(acontrol).Kind:=dtkDate;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      lcontrols2.AddObject(aparam.Name,acontrol);
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       TDateTimePicker(acontrol).Date:=TDateTime(aparam.Value);
      end;
     end;
   rpParamTime:
     begin
      acontrol:=TDateTimePicker.Create(Self);
      if aparam.IsReadOnly then
      begin
       TDateTimePicker(acontrol).Color:=Self.Color;
      end;
      TDateTimePicker(acontrol).Kind:=dtkTime;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      lcontrols2.AddObject(aparam.Name,acontrol);
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       TDateTimePicker(acontrol).Time:=TDateTime(aparam.Value);
      end;
     end;
   rpParamDateTime:
     begin
      acontrol:=TDateTimePicker.Create(Self);
      if aparam.IsReadOnly then
      begin
       TDateTimePicker(acontrol).Color:=Self.Color;
      end;
      TDateTimePicker(acontrol).Kind:=dtkDate;
      acontrol.tag:=i;
      acontrol.Width:=Canvas.TextWidth(FormatDateTime(ShortDateFormat,EncodeDate(2000,12,31)))+
       GetSystemMetrics(SM_CYHSCROLL)+20;
      lcontrols.AddObject(aparam.Name,acontrol);
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       TDateTimePicker(acontrol).Date:=TDateTime(aparam.Value);
      end;


      acontrol2:=TDateTimePicker.Create(Self);
      if aparam.IsReadOnly then
      begin
       TDateTimePicker(acontrol2).Color:=Self.Color;
      end;
      TDateTimePicker(acontrol2).Kind:=dtkTime;
      acontrol2.tag:=i;
      lcontrols2.AddObject(aparam.Name,acontrol2);
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       TDateTimePicker(acontrol2).Time:=TDateTime(aparam.Value);
      end;
{      acontrol:=TEdit.Create(Self);
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
}
     end;
   rpParamBool:
     begin
      acontrol:=TCheckBox.Create(Self);
      if aparam.IsReadOnly then
      begin
       TCheckBox(acontrol).Color:=Self.Color;
      end;
      acontrol.tag:=i;
      lcontrols.AddObject(aparam.Name,acontrol);
      lcontrols2.AddObject(aparam.Name,acontrol);
      // Can't add items without a parent
      acontrol.parent:=MainScrollBox;
      TCheckBox(acontrol).Checked:=false;
      if aparam.Value=Null then
      begin
       achecknull.Checked:=true;
      end
      else
      begin
       if Boolean(aparam.value) then
        TCheckBox(acontrol).Checked:=true
       else
        TCheckBox(acontrol).Checked:=false
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
      lcontrols2.AddObject(aparam.Name,acontrol);
      // Can't add items without a parent
      acontrol.parent:=MainScrollBox;
      TCheckListBox(acontrol).Items.Assign(aparam.Items);
      for j:=0 to TCheckListBox(acontrol).Items.Count-1 do
       TCheckListBox(acontrol).Checked[j]:=false;
      for j:=0 to aparam.Selected.Count-1 do
      begin
       // Dot net checked means by value
{$IFNDEF FORWEBAX}
       if TrpBasereport(report).IsDotNet then
       begin
        index:=aparam.Values.IndexOf(aparam.Selected.Strings[j]);
        if index>=0 then
         TCheckListBox(acontrol).Checked[index]:=true;
       end
       else
{$ENDIF}
       begin
        index:=StrToInt(aparam.Selected.Strings[j]);
        if TCheckListBox(acontrol).Items.Count>index then
         TCheckListBox(acontrol).Checked[index]:=true;
       end;
      end;
      index:=TCheckListBox(acontrol).Items.Count;
      if index>5 then
       index:=5;
      acontrol.Height:=index*Self.Canvas.TextHeight('Mg');
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
      lcontrols2.AddObject(aparam.Name,acontrol);
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
   if assigned(acontrol2) then
   begin
    acontrol2.Top:=Posy;
    acontrol2.Hint:=aparam.Hint;
    if aparam.IsReadOnly then
    begin
     acontrol2.Enabled:=false;
    end;
    acontrol2.Left:=acontrol.Left+acontrol.Width+CONS_LEFTGAP;
    acontrol2.Width:=TotalWidth-(acontrol.Left+acontrol.Width)-CONS_LEFTGAP;
    acontrol2.parent:=PRight;
{$IFNDEF FORWEBAX}
    bbutton.TabOrder:=bbutton.TabOrder+1;
{$ENDIF}
    acontrol2.Anchors:=[akLeft,akTop,akRight];
   end
   else
   begin
    acontrol.Width:=TotalWidth-acontrol.Left;
   end;
   if aparam.allownulls then
    if VarIsNull(aparam.Value) then
    begin
     acontrol.Visible:=false;
     if assigned(acontrol2) then
      acontrol2.Visible:=false;
    end;
   acontrol.parent:=PRight;
{$IFNDEF FORWEBAX}
   bbutton.TabOrder:=bbutton.TabOrder+1;
{$ENDIF}
   if Not Assigned(acontrol2) then
    acontrol.Anchors:=[akLeft,akTop,akRight];
   if Not assigned(ActiveControl) then
    if (acontrol.Visible and acontrol.Enabled) then
     ActiveControl:=TWinControl(acontrol);
   Posy:=PosY+acontrol.Height+CONS_CONTROLGAP;
  end
  else
  begin
   lcontrols.AddObject('',nil);
   lcontrols2.AddObject('',nil);
   lnulls.AddObject('',nil);
  end;
 end;
 PParent.Height:=PosY;
 // Set the height of the form
 NewClientHeight:=PModalButtons.Height+PosY+CONS_CONTROLGAP;
 if  NewClientHeight>CONS_MAXCLIENTHEIGHT then
  NewClientHeight:=CONS_MAXCLIENTHEIGHT;
 ClientHeight:=NewClientHeight;
end;

procedure TFRpRTParams.FormDestroy(Sender: TObject);
begin
 lcontrols.free;
 lcontrols2.free;
 lnulls.free;
 fparams.free;
end;

procedure TFRpRTParams.CheckNullClick(Sender:TObject);
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

procedure TFRpRTParams.SaveParams;
var
 i,j,index:integer;
 datevalue:double;
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
       datevalue:=Trunc(TDateTimePicker(LControls.Objects[i]).Date);
       fparams.items[i].Value:=TDateTime(datevalue);
      end;
     rpParamTime:
      begin
       fparams.items[i].Value:=Variant(TDateTimePicker(LControls.Objects[i]).Time);
      end;
     rpParamDateTime:
      begin
       datevalue:=Trunc(TDateTimePicker(LControls.Objects[i]).Date);
       datevalue:=datevalue+TDateTimePicker(LControls2.Objects[i]).Time-Trunc(TDateTimePicker(LControls2.Objects[i]).Date);
       fparams.items[i].Value:=TDateTime(datevalue);
      end;
     rpParamBool:
      begin
       fparams.items[i].Value:=TCheckBox(LControls.Objects[i]).Checked;
      end;
     rpParamMultiple:
      begin
       fparams.items[i].Selected.Clear;
       for j:=0 to TCheckListBox(LControls.Objects[i]).Items.Count-1 do
       begin
        if TCheckListBox(LControls.Objects[i]).Checked[j] then
        begin
{$IFNDEF FORWEBAX}
         if (TRpbaseReport(report).IsDotNet) then
         begin
          fparams.items[i].Selected.Add(fparams.items[i].Values[j]);
         end
         else
{$ENDIF}
         begin
           fparams.items[i].Selected.Add(IntToStr(j));
         end;
        end;
       end;
      end;
     rpParamList,rpParamSubstList:
      begin
       index:=TComboBox(LControls.Objects[i]).ItemIndex;
       if index<0 then
        index:=0;
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


procedure TFRpRTParams.BSearchClick(Sender: TObject);
begin
 // Lookup using a dataset
{$IFNDEF FORWEBAX}
  rpmdfsearchvcl.ParamValueSearch(params.Items[TComponent(Sender).Tag],TRpReport(report));
  TEdit(LControls.Objects[TComponent(Sender).Tag]).Text:=params.Items[TComponent(Sender).Tag].AsString;
{$ENDIF}
end;

end.
