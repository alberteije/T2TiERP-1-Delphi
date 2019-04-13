{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpmdfopenlibvcl                                 }
{       Dialog for Report Library maintainance          }
{       add/delete reports                              }
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

unit rpmdfopenlib;

interface

uses SysUtils, Classes, QGraphics, QForms, QControls, QStdCtrls,
  QButtons, QExtCtrls,rpmdconsts,rpmdftree,DB,rpdatainfo,
  rpgraphutils,
  QComCtrls;

type
  TFRpOpenLib = class(TForm)
    Panel2: TPanel;
    LLibrary: TLabel;
    ComboLibrary: TComboBox;
    PAlClient: TPanel;
    Panel1: TPanel;
    BOK: TButton;
    BCancel: TButton;
    procedure BOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboLibraryClick(Sender: TObject);
  private
    { Private declarations }
    dook:Boolean;
    atree:TFRpDBTree;
    dbinfo:TRpDatabaseInfoList;
  public
    { Public declarations }
    SelectedReport:WideString;
  end;

function SelectReportFromLibrary(dbinfo:TRpDatabaseInfoList;var alibrary:string):WideString;

implementation

{$R *.xfm}


function SelectReportFromLibrary(dbinfo:TRpDatabaseInfoList;var alibrary:string):WideString;
var
 dia:TFRpOpenLib;
 i:integer;
begin
 Result:='';
 If dbinfo.Count<1 then
  Raise Exception.Create(SRPDabaseAliasNotFound);
 dia:=TFRpOpenLib.Create(Application);
 try
  dia.dbinfo:=dbinfo;
  dia.ComboLibrary.OnClick:=nil;
  dia.ComboLibrary.Items.Clear;
  for i:=0 to dbinfo.Count-1 do
  begin
   dia.ComboLibrary.Items.Add(dbinfo.Items[i].Alias);
  end;
  dia.ComboLibrary.ItemIndex:=0;
  if Length(alibrary)>0 then
  begin
   i:=dbinfo.IndexOf(alibrary);
   dia.ComboLibrary.ItemIndex:=i;
  end;
  dia.ComboLibrary.OnClick:=dia.ComboLibraryClick;
  dia.ComboLibraryClick(dia.ComboLibrary);
  dia.ShowModal;
  if dia.dook then
  begin
   alibrary:=dia.ComboLibrary.Text;
   Result:=dia.SelectedReport;
  end;
 finally
  dia.free;
 end;
end;

procedure TFRpOpenLib.BOKClick(Sender: TObject);
var
 anode:TTreeNode;
 ninfo:TRpNodeInfo;
begin
 // Is there a report selected?
 SelectedReport:='';
 anode:=atree.ATree.Selected;
 if Not Assigned(anode) then
  Raise Exception.Create(SRpSelectReport);
 ninfo:=TRpNodeInfo(anode.data);
 if Length(ninfo.ReportName)<1 then
  Raise Exception.Create(SRpSelectReport);
 SelectedReport:=ninfo.ReportName;
 dook:=True;
 Close;
end;

procedure TFRpOpenLib.FormCreate(Sender: TObject);
begin
 atree:=TFRpDBTree.Create(Self);
// atree.OnLoadReport:=Self.OnLoadReport;
 atree.Top:=0;
 atree.Left:=0;
 atree.Parent:=PAlClient;
 BOK.Caption:=SRpOk;
 BCancel.Caption:=SRpCancel;
 LLibrary.Caption:=SRpLibSelection;
 Caption:=TranslateStr(1123,Caption);
 SetInitialBounds;
end;

procedure TFRpOpenLib.ComboLibraryClick(Sender: TObject);
var
 i:integer;
 dbitem:TRpDatabaseInfoItem;
begin
 // Open and fill the selected
 i:=dbinfo.IndexOf(ComboLibrary.Text);
 if i<0 then
  exit;
 dbitem:=dbinfo.Items[i];
 atree.EditTree(dbitem,false);
end;

end.
