{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdFSampledata                                 }
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

unit rpmdfsampledata;

interface

uses SysUtils, Classes, QGraphics, QForms,
  QButtons, QExtCtrls, QControls, QStdCtrls,DB, QDBCtrls, QGrids, QDBGrids,
  QComCtrls, QImgList,rpmdconsts;

const
 DCONTROL_DISTANCEY=5;
 DCONTROL_DISTANCEX=10;
 DCONTROL_DISTANCEX2=150;
 DCONTROL_WIDTHX=200;
 DLABEL_INCY=1;

type
  TFRpShowSampledata = class(TForm)
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

{$R *.xfm}
procedure ShowDataset(Data:TDataset);
var
 dia:TFRpShowSampledata;
begin
 dia:=TFRpShowSampledata.Create(Application);
 try
  dia.DataSource1.DataSet:=data;
  dia.CreateControls;
  dia.ShowModal;
 finally
  dia.free;
 end;
end;

procedure TFRpShowSampledata.CreateControls;
var
 i:integer;
 dataset:TDataset;
 label1:TLabel;
 Control:TControl;
 top:integer;
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
  control.Width:=DCONTROL_WIDTHX;
  control.Height:=Canvas.TextHeight('Wg');
  control.parent:=SCrollbox1;

  top:=top+Control.Height+DCONTROL_DISTANCEY;
 end;
end;


procedure TFRpShowSampledata.BExitClick(Sender: TObject);
begin
 Close;
end;

procedure TFRpShowSampledata.FormCreate(Sender: TObject);
begin
 Caption:=TranslateStr(735,Caption);
 BExit.Hint:=TranslateStr(212,BExit.Caption);
 DBNavigator1.Hints.Clear;
 DBNavigator1.Hints.Add(TranslateStr(738,''));
 DBNavigator1.Hints.Add(TranslateStr(736,''));
 DBNavigator1.Hints.Add(TranslateStr(737,''));
 SetInitialBounds;
end;

end.
