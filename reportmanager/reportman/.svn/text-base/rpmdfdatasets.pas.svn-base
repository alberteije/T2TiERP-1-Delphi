{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfdatasets                                   }
{                                                       }
{       Datasets definition frame                       }
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

unit rpmdfdatasets;

interface

{$I rpconf.inc}

uses
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, rpmdconsts,rpgraphutils,
{$IFDEF USEBDE}
  DBTables,
{$ENDIF}
  rptypes,rpdatainfo,rpreport,rpfparams,rpmdfsampledata, QActnList,
  rpdbbrowser,rpparams, QImgList, QComCtrls;

type
  TFRpDatasets = class(TFrame)
    PTop: TPanel;
    ToolBar1: TToolBar;
    OpenDialog1: TOpenDialog;
    ActionList1: TActionList;
    ANew: TAction;
    ADelete: TAction;
    ARename: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    BParams: TButton;
    PTop1: TPanel;
    LDatasets: TListBox;
    PanelBasic: TPanel;
    LMasterDataset: TLabel;
    LConnection: TLabel;
    ComboDataSource: TComboBox;
    ComboConnection: TComboBox;
    BShowData: TButton;
    Splitter1: TSplitter;
    PBottom: TPanel;
    PControl: TPageControl;
    TabSQL: TTabSheet;
    MSQL: TMemo;
    TabBDEType: TTabSheet;
    RBDEType: TRadioGroup;
    Panel4: TPanel;
    PBDEFilter: TPanel;
    MBDEFilter: TMemo;
    TabBDETable: TTabSheet;
    LBDEIndexFields: TLabel;
    LIndexName: TLabel;
    LTable: TLabel;
    LMasterFields: TLabel;
    LNote: TLabel;
    LFirstRange: TLabel;
    LLastRange: TLabel;
    LRange: TLabel;
    EBDEIndexFields: TComboBox;
    EBDEIndexName: TComboBox;
    EBDETable: TComboBox;
    EBDEMasterFields: TEdit;
    EBDEFirstRange: TMemo;
    EBDELastRange: TMemo;
    TabMyBase: TTabSheet;
    LIndexFields: TLabel;
    LMyBase: TLabel;
    LFields: TLabel;
    EMyBase: TEdit;
    EIndexFields: TEdit;
    BMyBase: TButton;
    BSearchFieldsFile: TButton;
    GUnions: TGroupBox;
    LabelUnions: TLabel;
    ComboUnions: TComboBox;
    CheckGroupUnion: TCheckBox;
    BAddUnions: TButton;
    BDelUnions: TButton;
    LUnions: TListBox;
    EMybasedefs: TEdit;
    BModify: TButton;
    ImageList1: TImageList;
    PBrowser: TPanel;
    Splitter2: TSplitter;
    PLBrowser: TPanel;
    EMasterFields: TEdit;
    LMasterfi: TLabel;
    CheckOpen: TCheckBox;
    procedure BParamsClick(Sender: TObject);
    procedure LDatasetsClick(Sender: TObject);
    procedure MSQLChange(Sender: TObject);
    procedure BMyBaseClick(Sender: TObject);
    procedure BShowDataClick(Sender: TObject);
    procedure ANewExecute(Sender: TObject);
    procedure ADeleteExecute(Sender: TObject);
    procedure ARenameExecute(Sender: TObject);
    procedure BAddUnionsClick(Sender: TObject);
    procedure BDelUnionsClick(Sender: TObject);
    procedure EBDETableDropDown(Sender: TObject);
    procedure EBDEIndexNameDropDown(Sender: TObject);
    procedure EBDEIndexFieldsDropDown(Sender: TObject);
    procedure BModifyClick(Sender: TObject);
  private
    { Private declarations }
    Report:TRpReport;
    browser:TFRpBrowser;
    procedure SetDataInfo(Value:TRpDataInfoList);
    procedure SetDatabaseInfo(Value:TRpDatabaseInfoList);
    procedure SetParams(Value:TRpParamList);
    function GetParams:TRpParamList;
    function GetDatabaseInfo:TRpDatabaseInfoList;
    function GetDataInfo:TRpDataInfoList;
//    function FindDatabaseInfoItem:TRpDatabaseInfoItem;
    function FindDataInfoItem:TRpDataInfoItem;
    procedure  Removedependences(oldalias:string);
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    procedure FillDatasets;
    property Datainfo:TRpDataInfoList read GetDatainfo
     write SetDataInfo;
    property Databaseinfo:TRpDatabaseInfoList read GetDatabaseinfo
     write SetDatabaseInfo;
    property Params:TRpParamList read GetParams
     write SetParams;
  end;

implementation

uses rpmdfdatatext;

{$R *.xfm}


function TFRpDatasets.GetParams:TRpParamList;
begin
 result:=report.params;
end;

procedure TFRpDatasets.SetParams(Value:TRpParamList);
begin
 report.params.assign(value);
end;

constructor TFRpDatasets.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 Report:=TRpReport.Create(Self);
 BParams.Caption:=TranslateStr(152,BParams.Caption);
 LConnection.Caption:=TranslateStr(154,LConnection.Caption);
 LMasterDataset.Caption:=TranslateStr(155,LMasterDataset.Caption);
 BShowData.Caption:=TranslateStr(156,BShowData.Caption);
 TAbBDEType.Caption:=TranslateStr(157,TabBDEType.Caption);
 TAbBDETable.Caption:=TranslateStr(158,TabBDETable.Caption);
 RBDEType.Items.Strings[0]:=TranslateStr(159,RBDEType.Items.Strings[0]);
 RBDEType.Items.Strings[1]:=TranslateStr(160,RBDEType.Items.Strings[1]);
 PBDEFilter.Caption:=TranslateStr(161,PBDEFilter.Caption);
 LTable.Caption:=TranslateStr(162,LTable.Caption);
 LIndexName.Caption:=TranslateStr(163,LIndexName.Caption);
 LBDEIndexFields.Caption:=TranslateStr(164,LBDEIndexFields.Caption);
 LMasterFields.Caption:=TranslateStr(165,LMasterFields.Caption);
 LMasterFi.Caption:=TranslateStr(165,LMasterFi.Caption);
 LNote.Caption:=TranslateStr(166,LNote.Caption);
 LMyBase.Caption:=TranslateStr(167,LMyBase.Caption);
 LIndexFields.Caption:=TranslateStr(164,LIndexFields.Caption);
 BMyBase.Caption:=TranslateStr(168,BMyBase.Caption);
 BSearchFieldsFile.Caption:=TranslateStr(168,BSearchFieldsFile.Caption);
 Caption:=TranslateStr(178,Caption);
 LFirstRange.Caption:=TranslateStr(831,LFirstRange.Caption);
 LLastRange.Caption:=TranslateStr(832,LLastRange.Caption);
 LRange.Caption:=TranslateStr(833,LRange.Caption);
 GUnions.Caption:=TranslateStr(1082,GUnions.Caption);
 LabelUnions.Caption:=TranslateStr(1083,LabelUnions.Caption);
 CheckGroupUnion.Caption:=TranslateStr(1084,CheckGroupUnion.Caption);
 LFields.Caption:=TranslateStr(1085,LFields.Caption);
 BModify.Caption:=TranslateStr(1086,BModify.Caption);
 CheckOpen.Caption:=SRpOpenOnStart;

 ANew.Caption:=TranslateStr(539,ANew.Caption);
 ANew.Hint:=Anew.Caption;
 ARename.Caption:=TranslateStr(540,ARename.Caption);
 ARename.Hint:=ARename.Caption;
 ADelete.Caption:=TranslateStr(150,ADelete.Caption);
 ADelete.Hint:=ARename.Caption;
 BParams.Hint:=TranslateStr(152,BParams.Hint);

 PBottom.Height:=250;

 PLBrowser.Caption:=SRpDatabaseBrowser;
 browser:=TFRpBrowser.Create(Self);
 browser.ShowDatasets:=false;
 browser.ShowEval:=false;
 browser.Align:=alClient;
 browser.Parent:=PBrowser;
end;

procedure TFRpDatasets.SetDatabaseInfo(Value:TRpDatabaseInfoList);
begin
 ComboConnection.Width:=PanelBasic.Width-ComboConnection.Left-10;
 ComboDataSource.Width:=PanelBasic.Width-ComboDataSource.Left-10;
 ComboConnection.Anchors:=[akLeft,akTop,akRight];
 ComboDataSource.Anchors:=[akLeft,akTop,akRight];

 report.DatabaseInfo.Assign(Value);
 browser.Report:=Report;
 FillDatasets;
end;

procedure TFRpDatasets.SetDataInfo(Value:TRpDataInfoList);
begin
 report.DataInfo.Assign(Value);
end;

procedure TFRpDatasets.FillDatasets;
var
 i:integer;
begin
 LDatasets.Clear;
 for i:=0 to datainfo.Count-1 do
 begin
  LDatasets.Items.Add(datainfo.Items[i].Alias)
 end;
 if LDatasets.items.Count>0 then
  LDatasets.ItemIndex:=0;
 ComboConnection.Clear;
 for i:=0 to databaseinfo.Count-1 do
 begin
  ComboConnection.Items.Add(databaseinfo.items[i].Alias);
 end;
 ComboConnection.Items.Add(' ');
 LDatasetsClick(Self);
end;

function TFRpDatasets.GetDatabaseInfo:TRpDatabaseInfoList;
begin
 Result:=Report.DatabaseInfo;
end;

function TFRpDatasets.GetDataInfo:TRpDataInfoList;
begin
 Result:=Report.DataInfo;
end;

procedure TFRpDatasets.BParamsClick(Sender: TObject);
begin
 ShowParamDef(report.params,report.datainfo);
end;

procedure TFRpDatasets.LDatasetsClick(Sender: TObject);
var
 dinfo:TRpDatainfoItem;
 index:integer;
begin
 // Fils the info of the current dataset
 dinfo:=FindDataInfoItem;
 if dinfo=nil then
 begin
  PControl.Visible:=false;
  PanelBasic.Visible:=False;
  exit;
 end;
 CheckOpen.Checked:=dinfo.OpenOnStart;
 PControl.Visible:=true;
 PanelBasic.Visible:=true;
 MSQL.Text:=WideStringToDOS(dinfo.SQL);
 EMyBase.Text:=dinfo.MyBaseFilename;
 EMyBaseDefs.Text:=dinfo.MyBaseFields;
 EIndexFields.Text:=dinfo.MyBaseIndexFields;
 LUnions.Items.Assign(dinfo.DataUnions);
 CheckGroupUnion.Checked:=dinfo.GroupUnion;
 EBDEIndexFields.Text:=dinfo.BDEIndexFields;
 MBDEFilter.Text:=dinfo.BDEFilter;
 EBDEIndexName.Text:=dinfo.BDEIndexName;
 EBDEFirstRange.Text:=dinfo.BDEFirstRange;
 EBDELastRange.Text:=dinfo.BDELastRange;
 EBDETable.Text:=dinfo.BDETable;
 EBDEMasterFields.Text:=dinfo.BDEMasterFields;
 EMasterFields.Text:=dinfo.MyBaseMasterFields;
 RBDEType.ItemIndex:=Integer(dinfo.BDEType);
 index:=ComboConnection.Items.IndexOf(dinfo.DatabaseAlias);
 if index<0 then
  dinfo.DatabaseAlias:='';
 ComboConnection.ItemIndex:=Index;

 ComboDataSource.Items.Assign(Ldatasets.Items);
 index:=ComboDataSource.Items.IndexOf(dinfo.alias);
 if index>=0 then
  ComboDataSource.Items.Delete(index);

 index:=ComboDataSource.Items.IndexOf(dinfo.DataSource);
 if index<0 then
 begin
  dinfo.DataSource:='';
 end;
 ComboDataSource.Items.Insert(0,' ');
 inc(index);
 ComboDatasource.ItemIndex:=Index;
 ComboUnions.Items.Assign(LDatasets.Items);
 ComboUnions.Items.Delete(LDatasets.ItemIndex);
 if ComboUnions.Items.Count<1 then
  ComboUnions.ItemIndex:=-1
 else
  ComboUnions.ItemIndex:=0;
 MSQLChange(ComboConnection);
end;

{function TFRpDatasetsVCL.FindDatabaseInfoItem:TRpDatabaseInfoItem;
var
 index:integer;
 dinfo:TRpDataInfoItem;
begin
 Result:=nil;
 dinfo:=FindDataInfoItem;
 if not assigned(dinfo) then
  exit;
 index:=report.databaseinfo.IndexOf(dinfo.DatabaseAlias);
 if index>=0 then
  Result:=databaseinfo.items[index];
end;
}

function TFRpDatasets.FindDataInfoItem:TRpDataInfoItem;
var
 index:integer;
begin
 Result:=nil;
 if LDatasets.ItemIndex<0 then
  exit;
 index:=datainfo.IndexOf(LDatasets.Items.Strings[LDatasets.itemindex]);
 if index>=0 then
  Result:=datainfo.items[index];
end;



procedure TFRpDatasets.MSQLChange(Sender: TObject);
var
 dinfo:TRpDatainfoItem;
 index:integer;
begin
 // Fils the info of the current dataset
 dinfo:=FindDataInfoItem;
 if dinfo=nil then
 begin
  TabSQL.TabVisible:=false;
  TabBDETable.TabVisible:=false;
  TabMyBase.TabVisible:=false;
  TabBDEType.TabVisible:=false;
  exit;
 end;
 if Sender=BAddUnions then
  dinfo.DataUnions:=LUnions.Items
 else
 if Sender=CheckGroupUnion then
  dinfo.GroupUnion:=CheckGroupUnion.Checked
 else
 if Sender=MSQL then
 begin
  dinfo.SQL:=TMemo(Sender).Text;
 end
 else
 if Sender=ComboConnection then
 begin
  dinfo.DatabaseAlias:=COmboConnection.Text;
  // Finds the driver
  index:=databaseinfo.IndexOf(dinfo.DatabaseAlias);
  if index<0 then
  begin
   TabSQL.TabVisible:=false;
   TabBDETable.TabVisible:=false;
   TabMyBase.TabVisible:=false;
   TabBDEType.TabVisible:=false;
   exit;
  end;
  PBrowser.Visible:=not (databaseinfo.items[index].Driver in [rpdatadriver,rpdotnet2driver] );
  if databaseinfo.items[index].Driver=rpdatamybase then
  begin
   TabSQL.TabVisible:=false;
   TabBDETable.TabVisible:=false;
   TabMyBase.TabVisible:=True;
   TabBDEType.TabVisible:=false;
  end
  else
  begin
   if databaseinfo.items[index].Driver=rpdatabde then
   begin
    TabBDEType.TabVisible:=True;
    if (dinfo.BDEType=rpdtable) then
    begin
     TabSQL.TabVisible:=False;
     TabBDETable.TabVisible:=True;
     TabMyBase.TabVisible:=False;
    end
    else
    begin
     TabSQL.TabVisible:=True;
     TabBDETable.TabVisible:=False;
     TabMyBase.TabVisible:=False;
    end;
   end
   else
   begin
    TabSQL.TabVisible:=True;
    TabBDETable.TabVisible:=false;
    TabMyBase.TabVisible:=False;
    TabBDEType.TabVisible:=false;
   end;
  end;
 end
 else
 if Sender=ComboDataSource then
 begin
  dinfo.DataSource:=ComboDataSource.Text;
 end
 else
 if Sender=EMyBase then
 begin
  dinfo.MyBaseFilename:=EMyBase.Text;
 end
 else
 if Sender=EMyBaseDefs then
 begin
  dinfo.MyBaseFields:=EMyBaseDefs.Text;
 end
 else
 if Sender=EIndexFields then
 begin
  dinfo.MyBaseIndexFields:=EIndexFields.Text;
 end
 else
 if Sender=RBDEType then
 begin
  dinfo.BDEType:=TRpDatasetType(RBDEType.ItemIndex);
  if dinfo.BDEType=rpdQuery then
  begin
   TabSQL.TabVisible:=true;
   TabBDETable.TabVisible:=false;
  end
  else
  begin
   TabSQL.TabVisible:=False;
   TabBDETable.TabVisible:=True;
  end;
 end
 else
 if Sender=EBDEIndexFields then
 begin
  dinfo.BDEIndexFields:=Trim(EBDEIndexFields.Text);
  if length(dinfo.BDEIndexFields)>0 then
   EBDEIndexName.Text:='';
 end
 else
 if Sender=EBDEIndexName then
 begin
  dinfo.BDEIndexName:=Trim(EBDEIndexName.Text);
  if length(dinfo.BDEIndexName)>0 then
   EBDEIndexFields.Text:='';
 end
 else
 if Sender=EBDETable then
 begin
  dinfo.BDETable:=EBDETable.Text;
 end
 else
 if Sender=MBDEFilter then
 begin
  dinfo.BDEFilter:=MBDEFilter.Text;
 end
 else
 if Sender=EBDEMasterFields then
 begin
  dinfo.BDEMasterFields:=EBDEMasterFields.Text;
 end
 else
 if Sender=EMasterFields then
 begin
  dinfo.MyBaseMasterFields:=EMasterFields.Text;
 end
 else
 if Sender=EBDEFirstRange then
 begin
  dinfo.BDEFirstRange:=EBDEFirstRange.Text;
 end
 else
 if Sender=EBDELastRange then
 begin
  dinfo.BDELastRange:=EBDELastRange.Text;
 end
 else
 if Sender=CheckOpen then
 begin
  dinfo.OpenOnStart:=CheckOpen.Checked;
 end;
end;

procedure TFRpDatasets.BMyBaseClick(Sender: TObject);
begin
 if Sender=BMyBase then
 begin
  OpenDialog1.DefaultExt:='cds';
  OpenDialog1.FilterIndex:=0;
 end
 else
 begin
  OpenDialog1.DefaultExt:='ini';
  OpenDialog1.FilterIndex:=3;
 end;
 if OpenDialog1.Execute then
 begin
  if Sender=BMyBase then
   EMyBase.Text:=OpenDialog1.FileName
  else
   EMyBaseDefs.Text:=OpenDialog1.FileName
 end;
end;

procedure TFRpDatasets.BShowDataClick(Sender: TObject);
var
 dinfo:TRpDatainfoitem;
 i:integer;
 aparams:TStringList;
 astring:string;
begin
 // Opens the dataset and show the data
 dinfo:=FindDataInfoItem;
 if dinfo=nil then
  exit;
{$IFDEF LINUX}
 // See if is dot net
 i:=report.DatabaseInfo.IndexOf(dinfo.DatabaseAlias);
 if i>=0 then
 begin
  if report.DatabaseInfo.Items[i].Driver in [rpdatadriver,rpdotnet2driver] then
  begin
    aparams:=TStringList.Create;
    try
       aparams.Add('mono');
       if report.DatabaseInfo.Items[i].Driver=rpdatadriver then
        aparams.Add(ExtractFilePath(Application.exename)+'net/printreport.exe')
       else
        aparams.Add(ExtractFilePath(Application.exename)+'net2/printreport.exe');
       astring:=RpTempFileName;
       report.StreamFormat:=rpStreamXML;
       report.SaveToFile(astring);
       aparams.Add('-SHOWDATA');
       aparams.Add(dinfo.Alias);
       aparams.Add('-deletereport');
       aparams.Add(astring);
       ExecuteSystemApp(aparams,false);
    finally
     aparams.free;
    end;
   exit;
  end;
 end;
{$ENDIF}
 for i:=0 to Datainfo.Count-1 do
 begin
  Datainfo.Items[i].Disconnect;
 end;
 report.InitEvaluator;
 report.AddReportItemsToEvaluator(report.Evaluator);
 Report.PrepareParamsBeforeOpen;
 dinfo.Connect(databaseinfo,report.params);
 try
  ShowDataset(dinfo.Dataset);
 finally
  // Left the dataset open for testing relations ...
//  dinfo.Disconnect;
 end;
end;

procedure TFRpDatasets.ANewExecute(Sender: TObject);
var
 aliasname:string;
 aitem:TRpDataInfoItem;
 index:integer;
begin
 aliasname:=Trim(RpInputBox(SrpNewDataset,SRpAliasName,''));
 if Length(aliasname)<1 then
  exit;
 aitem:=datainfo.Add(aliasname);
 if databaseinfo.Count>0 then
  aitem.DatabaseAlias:=databaseinfo.Items[0].Alias;
 FillDatasets;
 index:=LDatasets.items.indexof(AnsiUppercase(aliasname));
 if index>=0 then
 begin
  LDatasets.ItemIndex:=index;
  LDatasetsClick(Self);
 end;
end;

procedure TFRpDatasets.ADeleteExecute(Sender: TObject);
var
 index:integer;
 oldalias:string;
begin
 if LDatasets.itemindex<0 then
  exit;
 index:=datainfo.IndexOf(LDatasets.Items.strings[Ldatasets.itemindex]);
 if index>=0 then
 begin
  oldalias:=datainfo.items[index].Alias;
  datainfo.Delete(index);
  Removedependences(oldalias);
 end;
 FillDatasets;
end;

procedure TFRpDatasets.ARenameExecute(Sender: TObject);
var
 dinfo:TRpDatainfoitem;
 aliasname:string;
 index:integer;
begin
 dinfo:=FindDataInfoItem;
 aliasname:=Trim(RpInputBox(SrpRenameDataset,SRpAliasName,dinfo.alias));
 if Length(aliasname)<1 then
  exit;
 index:=datainfo.IndexOf(aliasname);
 if index>=0 then
  Raise Exception.Create(SRpAliasExists);
 if Not Assigned(dinfo) then
  exit;
 dinfo.Alias:=aliasname;
 FillDatasets;
end;

procedure  TFRpDatasets.Removedependences(oldalias:string);
var
 i:integer;
begin
 for i:=0 to datainfo.count-1 do
 begin
  if AnsiUpperCase(oldalias)=AnsiUpperCase(datainfo.items[i].datasource) then
   datainfo.items[i].datasource:='';
 end;
end;

procedure TFRpDatasets.BAddUnionsClick(Sender: TObject);
var
 index:integer;
begin
 if ComboUnions.Items.Count<1 then
  exit;
 if ComboUnions.ItemIndex<0 then
  exit;
 index:=LUnions.Items.IndexOf(ComboUnions.Text);
 if index<0 then
 begin
  LUnions.Items.Add(ComboUnions.Text);
  MSQLChange(BAddUnions);
 end;
end;

procedure TFRpDatasets.BDelUnionsClick(Sender: TObject);
begin
 if LUnions.Items.Count<1 then
  exit;
 if LUnions.ItemIndex<0 then
  exit;
 LUnions.Items.Delete(LUnions.ItemIndex);
 MSQLChange(BAddUnions);
end;

procedure TFRpDatasets.EBDETableDropDown(Sender: TObject);
{$IFDEF USEBDE}
var
 dinfo:TRpDatainfoItem;
{$ENDIF}
begin
{$IFDEF USEBDE}
 // Fils the info of the current dataset
 dinfo:=FindDataInfoItem;
 if dinfo=nil then
  exit;
 // Fills with tablenames, without extensions,
 // no system tables
 try
  Session.GetTableNames(dinfo.DatabaseAlias,'',True,False,EBDETable.Items);
 finally
  EBDETable.Items.Insert(0,' ');
 end;
{$ENDIF}
end;

procedure TFRpDatasets.EBDEIndexNameDropDown(Sender: TObject);
{$IFDEF USEBDE}
var
 dinfo:TRpDatainfoItem;
 atable:TTable;
 i:integer;
{$ENDIF}
begin
{$IFDEF USEBDE}
 // Fils the info of the current dataset
 dinfo:=FindDataInfoItem;
 if dinfo=nil then
  exit;
 atable:=TTable.Create(Self);
 try
  EBDEIndexName.Items.Clear;
  atable.DatabaseName:=dinfo.DatabaseAlias;
  atable.TableName:=dinfo.BDETable;
  atable.IndexDefs.Update;
  EBDEIndexName.Items.Clear;
  for i:=0 to atable.IndexDefs.Count-1 do
  begin
   EBDEIndexName.Items.Add(atable.IndexDefs.Items[i].Name);
  end;
 finally
  atable.free;
  EBDEIndexName.Items.Insert(0,' ');
 end;
{$ENDIF}
end;

{$IFDEF USEBDE}
procedure GetIndexFieldNames(atable:TTable;Items:TStrings);
var
 i:integer;
begin
 atable.IndexDefs.Update;
 items.Clear;
 for i:=0 to atable.IndexDefs.Count-1 do
 begin
  if Length(atable.IndexDefs.Items[i].Fields)>0 then
   items.Add(atable.IndexDefs.Items[i].Fields);
 end;
end;
{$ENDIF}

procedure TFRpDatasets.EBDEIndexFieldsDropDown(Sender: TObject);
{$IFDEF USEBDE}
var
 dinfo:TRpDatainfoItem;
 atable:TTable;
{$ENDIF}
begin
{$IFDEF USEBDE}
 // Fils the info of the current dataset
 dinfo:=FindDataInfoItem;
 if dinfo=nil then
  exit;
 atable:=TTable.Create(Self);
 try
  EBDEIndexFields.Items.Clear;
  atable.DatabaseName:=dinfo.DatabaseAlias;
  atable.TableName:=dinfo.BDETable;
  GetIndexFieldNames(atable,EBDEIndexFields.Items);
 finally
  atable.free;
  EBDEIndexFields.Items.Insert(0,' ');
 end;
{$ENDIF}
end;

procedure TFRpDatasets.BModifyClick(Sender: TObject);
var
 dinfo:TRpDatainfoItem;
 dbinfo:TRpDatabaseInfoItem;
 index:Integer;
begin
 dinfo:=FindDataInfoItem;
 if dinfo=nil then
  exit;
 index:=databaseinfo.IndexOf(dinfo.DatabaseAlias);
 if index<0 then
  exit;
 dbinfo:=databaseinfo.items[index];
 dbinfo.Connect(params);
 ShowDataTextConfig(dbinfo.MyBasePath+EMyBaseDefs.Text,dbinfo.MyBasePath+EMyBase.Text);
end;

end.

