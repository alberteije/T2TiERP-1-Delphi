{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpeditalias                                     }
{                                                       }
{                                                       }
{       Alias List collection editor for                }
{       Delphi 4,5 Builder 4,5                          }
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

unit rpeditaliasclx;

interface

{$I rpconf.inc}

uses
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QExtCtrls, QComCtrls, QActnList,rpalias,
  Designintf,DesignEditors,
  TypInfo,DB,rpdatainfo,
  rpeditconn,
  ImgList, StdCtrls, QImgList, QStdCtrls;

type
  TFRpEditAlias = class(TForm)
    ImageList1: TImageList;
    ActionList1: TActionList;
    ANewParam: TAction;
    ADelete: TAction;
    ARename: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton5: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    PAliases: TPanel;
    PBottom: TPanel;
    BOK: TButton;
    BCancel: TButton;
    LAliases: TListBox;
    Splitter1: TSplitter;
    Label1: TLabel;
    ComboDataset: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ANewParamExecute(Sender: TObject);
    procedure LAliasesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ADeleteExecute(Sender: TObject);
    procedure ComboDatasetClick(Sender: TObject);
    procedure ARenameExecute(Sender: TObject);
    procedure BOKClick(Sender: TObject);
  private
    { Private declarations }
    rpalias1:TRpAlias;
{$IFNDEF USEVARIANTS}
    Designer:IFormDesigner;
{$ENDIF}
{$IFDEF USEVARIANTS}
    Designer:IDesigner;
{$ENDIF}
    dook:Boolean;
    procedure UpdateList;
    procedure FillComboDataset;
    procedure AddDatasetName(const aname:string);
  public
    { Public declarations }
  end;

  // Property editor for aliases
  TRpAliasPropEditor=class(TPropertyEditor)
  protected
  public
   function GetAttributes:TPropertyAttributes;override;
   procedure Edit;override;
   function GetValue:string;override;
  end;

  // Property editor for aliases
  TRpConnectionPropEditor=class(TPropertyEditor)
  protected
  public
   function GetAttributes:TPropertyAttributes;override;
   procedure Edit;override;
   function GetValue:string;override;
  end;


implementation

{$R *.xfm}


procedure TRpAliasPropEditor.Edit;
var
 dia:TFRpEditAlias;
 i:integer;
begin
 dia:=TFRpEditAlias.Create(Application);
 try
  dia.Designer:=Designer;
  for i:=0 to PropCount-1 do
  begin
   if (GetComponent(i) Is TRpAlias) then
   begin
    dia.rpalias1.List.Assign((GetComponent(i) As TRpAlias).List);
    dia.rpalias1.Connections.Assign((GetComponent(i) As TRpAlias).Connections);
    break;
   end;
  end;
  if (dia.dook) then
  begin
   for i:=0 to PropCount-1 do
   begin
    if (GetComponent(i) Is TRpAlias) then
    begin
     (GetComponent(i) As TRpAlias).List.Assign(dia.rpalias1.List);
     (GetComponent(i) As TRpAlias).List.Assign(dia.rpalias1.List);
    end;
   end;
   Modified;
  end;
 finally
  dia.free;
 end;
end;

function TRpAliasPropEditor.GetAttributes:TPropertyAttributes;
begin
 Result:=[paDialog];
end;

function TRpAliasPropEditor.GetValue:string;
begin
 Result:='Dataset aliases';
end;


procedure TRpConnectionPropEditor.Edit;
var
 alias1:TRpAlias;
 i:integer;
 found:Boolean;
begin
 alias1:=TRpAlias.Create(Application);
 try
  found:=false;
  for i:=0 to PropCount-1 do
  begin
   if (GetComponent(i) Is TRpAlias) then
   begin
    alias1.Connections.Assign((GetComponent(i) As TRpAlias).Connections);
    found:=true;
    break;
   end;
  end;
  if found then
  begin
   if ShowModifyConnections(alias1.Connections) then
   begin
    for i:=0 to PropCount-1 do
    begin
     if (GetComponent(i) Is TRpAlias) then
     begin
      (GetComponent(i) As TRpAlias).Connections.Assign(alias1.Connections);
     end;
    end;
    Modified;
   end;
  end;
 finally
  alias1.free;
 end;
end;

function TRpConnectionPropEditor.GetAttributes:TPropertyAttributes;
begin
 Result:=[paDialog];
end;

function TRpConnectionPropEditor.GetValue:string;
begin
 Result:='Connection aliases';
end;

procedure TFRpEditAlias.FormCreate(Sender: TObject);
begin
 rpalias1:=TRpAlias.Create(Self);
end;


procedure TFRpEditAlias.ANewParamExecute(Sender: TObject);
var
 aname:String;
 aitem:TRpAliasListItem;
begin
 aname:=InputBox('New alias','Alias name','');
 aname:=Trim(UpperCase(aname));
 if rpalias1.List.indexof(aname)>0 then
  Raise Exception.Create('Alias name already exists');
 aitem:=rpalias1.List.Add;
 aitem.Alias:=aname;
 UpdateList;
 LAliases.ItemIndex:=LAliases.Items.Count-1;
 LAliasesClick(Self);
end;


procedure TFRpEditAlias.UpdateList;
var
 i:integer;
begin
 LAliases.Clear;
 for i:=0 to rpalias1.List.count-1 do
 begin
  LAliases.Items.Add(rpalias1.List.Items[i].Alias);
 end;
end;



procedure TFRpEditAlias.FormShow(Sender: TObject);
begin
 // Fills the list with all the available dataset components
 FillComboDataset;
 PAliases.Visible:=True;
 PAliases.Align:=alClient;
 FillComboDataset;
 UpdateList;
 if LAliases.Items.Count>0 then
  LAliases.ItemIndex:=0
 else
  LAliases.ItemIndex:=-1;
 LAliasesClick(Self);
end;

procedure TFRpEditAlias.AddDatasetName(const aname:string);
begin
 ComboDataset.Items.Add(aname);
end;


procedure TFRpEditAlias.FillComboDataset;
begin
 ComboDataset.Items.Clear;
 Designer.GetComponentnames(GetTypeData(TypeInfo(TDataSet)),AddDatasetName);
 ComboDataset.Items.Insert(0,' ');
end;

procedure TFRpEditAlias.ADeleteExecute(Sender: TObject);
var
 oldindex:integer;
begin
 if LAliases.Items.Count<1 then
 begin
  Label1.Visible:=False;
  ComboDataset.Visible:=False;
  exit;
 end;
 if LAliases.ItemIndex<0 then
 begin
  Label1.Visible:=False;
  ComboDataset.Visible:=False;
  exit;
 end;
 oldindex:=LAliases.ItemIndex;
 rpalias1.List.items[LAliases.itemindex].free;
 UpdateList;
 dec(oldindex);
 if oldindex<0 then
  oldindex:=0;
 if LAliases.Items.Count>0 then
 begin
  LAliases.ItemIndex:=oldindex;
  LAliasesClick(Self);
 end;
end;

procedure TFRpEditAlias.LAliasesClick(Sender: TObject);
var
 adataset:TDataset;
begin
 ComboDataset.ItemIndex:=0;
 // Fills with the values
 if LAliases.Items.Count<1 then
 begin
  Label1.Visible:=False;
  ComboDataset.Visible:=False;
  exit;
 end;
 if LAliases.ItemIndex<0 then
 begin
  Label1.Visible:=False;
  ComboDataset.Visible:=False;
  exit;
 end;
 adataset:=rpalias1.List.Items[LAliases.ItemIndex].Dataset;
 if adataset=nil then
  ComboDataset.ItemIndex:=0
 else
 begin
  ComboDataset.ItemIndex:=ComboDataset.Items.IndexOf(Designer.GetComponentName(adataset));
  if ComboDataset.ItemIndex<0 then
   ComboDataset.ItemIndex:=0;
 end;
 Label1.Visible:=True;
 ComboDataset.Visible:=True;
end;


procedure TFRpEditAlias.ComboDatasetClick(Sender: TObject);
var
 data:TDataSet;
begin
 if LAliases.Items.Count<1 then
  exit;
 if LAliases.ItemIndex<0 then
  exit;
 if ComboDataset.ItemIndex<1 then
  data:=nil
 else
 begin
  data:=Designer.GetComponent(ComboDataset.Text) As TDataSet;
 end;
 rpalias1.List.Items[LAliases.ItemIndex].Dataset:=data;
end;

procedure TFRpEditAlias.ARenameExecute(Sender: TObject);
var
 aname:String;
 aitem:TRpAliasListItem;
begin
 if LAliases.Items.Count<1 then
  exit;
 if LAliases.ItemIndex<0 then
  exit;
 aname:=InputBox('Rename alias','New alias name','');
 aname:=Trim(UpperCase(aname));
 if rpalias1.List.indexof(aname)>0 then
  Raise Exception.Create('Alias name already exists');
 aitem:=rpalias1.List.Items[LAliases.ItemIndex];
 aitem.Alias:=aname;
 UpdateList;
 LAliases.ItemIndex:=LAliases.Items.IndexOf(aname);
 LAliasesClick(Self);
end;


procedure TFRpEditAlias.BOKClick(Sender: TObject);
begin
 dook:=true;
 Close;
end;

end.
