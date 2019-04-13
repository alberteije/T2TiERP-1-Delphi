{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdFSampledatavcl                              }
{       Show data of a unidirectional query             }
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

unit rpmdfsampledatavcl;

interface

uses SysUtils, Classes, Graphics, Forms,
  Buttons, ExtCtrls, Controls, StdCtrls,DB, DBCtrls, Grids, DBGrids,
  ComCtrls, ImgList,rpmdconsts, ToolWin;

const
 DCONTROL_DISTANCEY=5;
 DCONTROL_DISTANCEX=10;
 DCONTROL_DISTANCEX2=300;
 DCONTROL_WIDTHX=200;
 DCONTROL_GAP=15;
 DBEVEL_GAP=2;
 DLABEL_INCY=1;

type
  TFRpShowSampledataVCL = class(TForm)
    DataSource1: TDataSource;
    ToolBar1: TToolBar;
    DBNavigator1: TDBNavigator;
    ScrollBox1: TScrollBox;
    ImageList1: TImageList;
    BExit: TToolButton;
    ToolButton2: TToolButton;
    procedure BExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CreateControls;
  public
    { Public declarations }
  end;

procedure ShowDataset(Data:TDataset);

implementation

{$R *.dfm}

procedure ShowDataset(Data:TDataset);
var
 dia:TFRpShowSampledataVCL;
begin
 dia:=TFRpShowSampledataVCL.Create(Application);
 try
  dia.DataSource1.DataSet:=data;
  dia.CreateControls;
  dia.ShowModal;
 finally
  dia.free;
 end;
end;

procedure TFRpShowSampledataVCL.CreateControls;
var
 i:integer;
 dataset:TDataset;
 label1:TLabel;
 Control:TControl;
 top:integer;
 bevel:TBevel;
begin
 if Not Assigned(Datasource1.dataset) then
  exit;
 if not Datasource1.dataset.active then
  exit;
 dataset:=Datasource1.dataset;
 top:=DCONTROL_DISTANCEY;
 for i:=0 to dataset.FieldCount-1 do
 begin
  label1:=Tlabel.Create(self);
  label1.Top:=top+DLABEL_INCY;
  label1.Left:=DCONTROL_DISTANCEX;
  label1.caption:=Dataset.fields[i].FieldName;
  label1.Parent:=ScrollBox1;

  control:=TDBTExt.Create(self);
  TDBText(control).Font.Style:=[fsBold];
  TDBText(control).Datasource:=datasource1;
  TDBText(control).DataField:=Dataset.fields[i].FieldName;

  control.top:=top;
  control.left:=DCONTROL_DISTANCEX2;
  control.Anchors:=[akLeft,akTop,akRight];
  control.Width:=ScrollBox1.Width-DCONTROL_GAP-control.Left;
  control.Height:=Canvas.TextHeight('Wg');
  control.parent:=SCrollbox1;

  bevel:=TBevel.Create(Self);
  bevel.Top:=top+Control.Height+DBEVEL_GAP;
  bevel.left:=label1.Left;
  bevel.Anchors:=[akLeft,akTop,akRight];
  bevel.Width:=ScrollBox1.Width-DCONTROL_GAP-bevel.Left;
  bevel.Height:=2;
  bevel.parent:=SCrollbox1;


  top:=top+Control.Height+DCONTROL_DISTANCEY;
 end;
end;


procedure TFRpShowSampledataVCL.BExitClick(Sender: TObject);
begin
 Close;
end;

procedure TFRpShowSampledataVCL.FormCreate(Sender: TObject);
begin
 Caption:=TranslateStr(735,Caption);
 BExit.Hint:=TranslateStr(212,BExit.Caption);
 DBNavigator1.Hints.Clear;
 DBNavigator1.Hints.Add(TranslateStr(738,''));
 DBNavigator1.Hints.Add(TranslateStr(736,''));
 DBNavigator1.Hints.Add(TranslateStr(737,''));
end;

end.
