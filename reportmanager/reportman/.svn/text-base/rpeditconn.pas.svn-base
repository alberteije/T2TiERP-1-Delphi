{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpeditconn                                      }
{                                                       }
{                                                       }
{       Connection List editor, CLX version             }
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

unit rpeditconn;

interface

{$I rpconf.inc}

uses
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QExtCtrls, QComCtrls, QActnList,rpalias,
  DB,rpdatainfo,
{$IFDEF USEADO}
  adodb,
{$ENDIF}
  rpdbxconfig,rpmdfopenlib,
  rpmdconsts,
  QImgList, QStdCtrls;

type
  TFRpEditCon = class(TForm)
    ImageList1: TImageList;
    ActionList1: TActionList;
    ANewConn: TAction;
    ADelete: TAction;
    ARename: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton5: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    PBottom: TPanel;
    BOK: TButton;
    BCancel: TButton;
    PConnections: TPanel;
    Splitter2: TSplitter;
    LConnections: TListBox;
    PCon2: TPanel;
    EReportGroupsTable: TEdit;
    EReportSearchfield: TEdit;
    EReportField: TEdit;
    EReportTable: TEdit;
    ComboDriver: TComboBox;
    LDriver: TLabel;
    LReportTable: TLabel;
    LReportField: TLabel;
    LRSearchField: TLabel;
    LGroupsTable: TLabel;
    CheckLoginPrompt: TCheckBox;
    CheckLoadDriverParams: TCheckBox;
    CheckLoadParams: TCheckBox;
    BConfig: TButton;
    EAdoConnection: TEdit;
    LAdoConnection: TLabel;
    BADOCOnf: TButton;
    BTest: TButton;
    BCreateLib: TButton;
    BBrowse: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ANewConnExecute(Sender: TObject);
    procedure LAliasesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ADeleteExecute(Sender: TObject);
    procedure ARenameExecute(Sender: TObject);
    procedure EReportTableChange(Sender: TObject);
    procedure BConfigClick(Sender: TObject);
    procedure BADOCOnfClick(Sender: TObject);
    procedure BTestClick(Sender: TObject);
    procedure BCreateLibClick(Sender: TObject);
    procedure BBrowseClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
  private
    { Private declarations }
    rpalias1:TRpAlias;
    dook:Boolean;
    procedure UpdateConList;
  public
    { Public declarations }
  end;


function ShowModifyConnections(Connections:TRpDatabaseInfoList):Boolean;


implementation


{$R *.xfm}


function ShowModifyConnections(Connections:TRpDatabaseInfoList):Boolean;
var
 dia:TFRpEditCon;
begin
 Result:=False;
 dia:=TFRpEditCon.Create(Application);
 try
  dia.rpalias1.Connections.Assign(Connections);
  dia.showmodal;
  if (dia.dook) then
  begin
   Result:=True;
   Connections.Assign(dia.rpalias1.Connections);
  end;
 finally
  dia.free;
 end;
end;



procedure TFRpEditCon.ANewConnExecute(Sender: TObject);
var
 aname:String;
begin
 aname:=InputBox('New connection','Connection name','');
 aname:=Trim(UpperCase(aname));
 if rpalias1.Connections.indexof(aname)>0 then
  Raise Exception.Create('Connection name already exists');
 rpalias1.Connections.Add(aname);
 UpdateConList;
 LConnections.ItemIndex:=LConnections.Items.Count-1;
 LAliasesClick(Self);
end;




procedure TFRpEditCon.UpdateConList;
var
 i:integer;
begin
 LConnections.Clear;
 for i:=0 to rpalias1.Connections.count-1 do
 begin
  LConnections.Items.Add(rpalias1.Connections.Items[i].Alias);
 end;
end;


procedure TFRpEditCon.FormShow(Sender: TObject);
begin
 PConnections.Visible:=True;
 PConnections.Align:=alClient;
 UpdateConList;
 GetRpDatabaseDrivers(ComboDriver.Items);
 if LConnections.Items.Count>0 then
  LConnections.ItemIndex:=0
 else
  LConnections.ItemIndex:=-1;
 LAliasesClick(Self);
end;




procedure TFRpEditCon.ADeleteExecute(Sender: TObject);
var
 oldindex:integer;
begin
 if LConnections.Items.Count<1 then
 begin
  PCon2.Visible:=False;
  exit;
 end;
 if LConnections.ItemIndex<0 then
 begin
  PCon2.Visible:=False;
  exit;
 end;
 oldindex:=LConnections.ItemIndex;
 rpalias1.Connections.Items[LConnections.ItemIndex].free;
 UpdateConList;
 dec(oldindex);
 if oldindex<0 then
  oldindex:=0;
 if LConnections.Items.Count>0 then
 begin
  LConnections.ItemIndex:=oldindex;
  LAliasesClick(Self);
 end;
end;

procedure TFRpEditCon.LAliasesClick(Sender: TObject);
var
 dbitem:TRpDatabaseInfoItem;
begin
 if LConnections.Items.Count<1 then
 begin
  PCon2.Visible:=False;
  exit;
 end;
 if LConnections.ItemIndex<0 then
 begin
  PCon2.Visible:=False;
  exit;
 end;
 dbitem:=rpalias1.Connections.Items[LConnections.ItemIndex];
 ComboDriver.ItemIndex:=Integer(dbitem.Driver);
 CheckLoadParams.Checked:=dbitem.LoadParams;
 CheckLoadDriverParams.Checked:=dbitem.LoadDriverParams;
 CheckLoginPrompt.Checked:=dbitem.LoginPrompt;
 EReportTable.TExt:=dbitem.ReportTable;
 EReportField.Text:=dbitem.ReportField;
 EReportSearchfield.Text:=dbitem.ReportSearchField;
 EReportGroupsTable.Text:=dbitem.ReportGroupsTable;
 EADOConnection.Onchange:=nil;
 EAdoConnection.Text:=EncodeADOPAssword(dbitem.ADOConnectionString);
 EADOConnection.Onchange:=EReportTableChange;

 PCon2.Visible:=True;
end;



procedure TFRpEditCon.ARenameExecute(Sender: TObject);
var
 aname:String;
 adbitem:TRpDatabaseInfoItem;
begin
 if LConnections.Items.Count<1 then
  exit;
 if LConnections.ItemIndex<0 then
  exit;
 aname:=InputBox('Rename connection','New connection name','');
 aname:=Trim(UpperCase(aname));
 if rpalias1.Connections.indexof(aname)>0 then
  Raise Exception.Create('Alias name already exists');
 adbitem:=rpalias1.Connections.Items[LConnections.ItemIndex];
 adbitem.Alias:=aname;
 UpdateConList;
 LConnections.ItemIndex:=LConnections.Items.IndexOf(aname);
 LAliasesClick(Self);
end;

procedure TFRpEditCon.EReportTableChange(Sender: TObject);
var
 dbitem:TRpDatabaseInfoItem;
begin
 // Change any data
 if LConnections.Items.Count<1 then
  exit;
 if LConnections.ItemIndex<0 then
  exit;
 dbitem:=rpalias1.Connections.Items[LConnections.ItemIndex];
 if Sender=CheckLoadParams then
  dbitem.LoadParams:=CheckLoadParams.Checked
 else
 if Sender=CheckLoadDriverParams then
  dbitem.LoadDriverParams:=CheckLoadDriverParams.Checked
 else
 if Sender=CheckLoginPrompt then
  dbitem.LoginPrompt:=CheckLoginPrompt.Checked
 else
 if Sender=ComboDriver then
  dbitem.Driver:=TRpDbDriver(ComboDriver.ItemIndex)
 else
 if Sender=EReportTable then
  dbitem.ReportTable:=EReportTable.TExt
 else
 if Sender=EReportField then
  dbitem.ReportField:=EReportField.Text
 else
 if Sender=EReportSearchField then
  dbitem.ReportSearchField:=EReportSearchfield.Text
 else
 if Sender=EReportGroupsTable then
  dbitem.ReportGroupsTable:=EReportGroupsTable.Text
 else
 if Sender=EAdoConnection then
  dbitem.ADOConnectionString:=EAdoConnection.Text;
end;

procedure TFRpEditCon.FormCreate(Sender: TObject);
begin
 rpalias1:=TRpAlias.Create(Self);
{$IFDEF BUILDER4}
 BConfig.Visible:=False;
 BBrowse.Visible:=False;
{$ENDIF}

 BOk.Caption:=SRpOk;
 BCancel.Caption:=SRpCancel;
 ANewConn.Caption:=TranslateStr(1102,ANewConn.Caption);
 ANewConn.Hint:=TranslateStr(1103,ANewConn.Hint);
 ADelete.Caption:=TranslateStr(1104,ADelete.Caption);
 ADelete.Hint:=TranslateStr(1105,ADelete.Hint);
 ARename.Caption:=TranslateStr(151,ARename.Caption);
 ARename.Hint:=TranslateStr(512,ARename.Hint);
 CheckLoadParams.Caption:=TranslateStr(145,CheckLoadParams.Caption);
 CheckLoadDriverParams.Caption:=TranslateStr(146,CheckLoadDriverParams.Caption);
 CheckLoginPrompt.Caption:=TranslateStr(144,CheckLoginPrompt.Caption);
 LDriver.Caption:=TranslateStr(147,LDriver.Caption);
 LReportTable.Caption:=TranslateStr(1115,LReportTable.Caption);
 LReportField.Caption:=TranslateStr(1116,LReportField.Caption);
 LRSearchField.Caption:=TranslateStr(1117,LRSearchField.Caption);
 LGroupsTable.Caption:=TranslateStr(1118,LGroupsTable.Caption);
 LAdoConnection.Caption:=TranslateStr(1119,LAdoConnection.Caption);
 BConfig.Caption:=TranslateStr(143,BConfig.Caption);
 BCreateLib.Caption:=TranslateStr(1120,BCreateLib.Caption);
 BTest.Caption:=TranslateStr(748,BTest.Caption);
 BBrowse.Caption:=TranslateStr(1121,BBrowse.Caption);
 BADOConf.Caption:=TranslateStr(143,BADOConf.Caption);
 Caption:=TranslateStr(1122,Caption);

 SetInitialBounds;
end;


procedure TFRpEditCon.BConfigClick(Sender: TObject);
begin
{$IFNDEF BUILDER4}
 ShowDBXConfig(TRpDbDriver(ComboDriver.ItemIndex) in [rpdataibx,rpdataibo,rpdatamybase]);
{$ENDIF}
// conadmin.GetConnectionNames(ComboAvailable.Items,'');
end;

procedure TFRpEditCon.BADOCOnfClick(Sender: TObject);
{$IFDEF USEADO}
var
 dinfoitem:TRpDatabaseinfoitem;
 newstring:String;
{$ENDIF}
begin
{$IFDEF USEADO}
 dinfoitem:=rpalias1.Connections.Items[LConnections.ItemIndex];
  if LConnections.ItemIndex<0 then
   Raise Exception.Create(SRpSelectAddConnection);
 EADOConnection.OnChange:=nil;
 newstring:=PromptDataSource(0,dinfoitem.ADOConnectionString);
 EADOConnection.Text:=EncodeADOPassword(newstring);
 dinfoitem.ADOConnectionString:=newstring;
 EADOConnection.Onchange:=EReportTableChange;
{$ENDIF}
end;
procedure TFRpEditCon.BTestClick(Sender: TObject);
var
 dbinfo:TRpDatabaseInfoItem;
begin
 dbinfo:=rpalias1.Connections.Items[LConnections.ItemIndex];
 dbinfo.Connect(nil);
 try
  ShowMessage(SRpConnectionOk);
 finally
  dbinfo.DisConnect;
 end;
end;

procedure TFRpEditCon.BCreateLibClick(Sender: TObject);
var
 dbitem:TRpDatabaseinfoItem;
begin
 // Change any data
 if LConnections.Items.Count<1 then
  exit;
 if LConnections.ItemIndex<0 then
  exit;
 dbitem:=rpalias1.Connections.Items[LConnections.ItemIndex];
 dbitem.CreateLibrary(dbitem.ReportTable,dbitem.ReportField,dbitem.ReportSearchField,dbitem.ReportGroupsTable,nil);
end;

procedure TFRpEditCon.BBrowseClick(Sender: TObject);
var
 alibrary:String;
begin
 // Change any data
 if LConnections.Items.Count<1 then
  exit;
 if LConnections.ItemIndex<0 then
  exit;
 alibrary:=LConnections.Items.Strings[LConnections.ItemIndex];
 SelectReportFromLibrary(rpalias1.Connections,alibrary);
end;

procedure TFRpEditCon.BOKClick(Sender: TObject);
begin
 dook:=true;
 Close;
end;

end.
