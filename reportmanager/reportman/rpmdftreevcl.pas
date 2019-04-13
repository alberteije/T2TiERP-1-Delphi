{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpmdftree                                       }
{                                                       }
{       Build a report tree from a dataset              }
{       or a directory                                  }
{                                                       }
{       You can assign events to OnDelete, OnNew        }
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

unit rpmdftreevcl;

interface

{$I rpconf.inc}

uses
  mmsystem,windows,
  SysUtils, Classes,
{$IFDEF USEVARIANTS}
  Variants,
  Types,
{$ENDIF}
  Graphics, Controls, Forms,
  Dialogs,rpmdconsts, ActnList, ImgList, ComCtrls,rpvgraphutils, DB,
  DBClient, StdCtrls,Printers,rpdatainfo,rpgraphutilsvcl,
  rptypes,rpvclreport, rpreport,ToolWin, ExtCtrls, Menus;

const PROGRESS_INTERVAL=500;

type

  TFRpDBTreeVCL = class(TFrame)
    BToolBar: TToolBar;
    imalist: TImageList;
    ActionList1: TActionList;
    ANew: TAction;
    ADelete: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ATree: TTreeView;
    DReports: TClientDataSet;
    DReportGroups: TClientDataSet;
    BCancel: TButton;
    DReportGroupsGROUP_CODE: TIntegerField;
    DReportGroupsGROUP_NAME: TWideStringField;
    DReportGroupsPARENT_GROUP: TIntegerField;
    DReportGroupsTREE_NODE: TIntegerField;
    DReportGroups2: TClientDataSet;
    DReportsREPORT_NAME: TWideStringField;
    DReportsREPORT_GROUP: TIntegerField;
    DReportGroups2GROUP_CODE: TIntegerField;
    DReportGroups2GROUP_NAME: TWideStringField;
    DReportGroups2PARENT_GROUP: TIntegerField;
    DReportGroups2TREE_NODE: TIntegerField;
    APreview: TAction;
    APrint: TAction;
    AUserParams: TAction;
    APrintSetup: TAction;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    SaveDialog1: TSaveDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    ANewFolder: TAction;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    AFind: TAction;
    AExportFolder: TAction;
    mpopup: TPopupMenu;
    ARename: TAction;
    Rename1: TMenuItem;
    timerscroll1: TTimer;
    timerexpand: TTimer;
    timerinvalidate: TTimer;
    EFind: TEdit;
    procedure ADeleteExecute(Sender: TObject);
    procedure APreviewExecute(Sender: TObject);
    procedure AUserParamsExecute(Sender: TObject);
    procedure APrintExecute(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure APrintSetupExecute(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ANewFolderExecute(Sender: TObject);
    procedure ANewExecute(Sender: TObject);
    procedure AFindExecute(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure ATreeChange(Sender: TObject; Node: TTreeNode);
    procedure ARenameExecute(Sender: TObject);
    procedure ATreeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ATreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure timerscroll1Timer(Sender: TObject);
    procedure ATreeEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure timerexpandTimer(Sender: TObject);
    procedure timerinvalidateTimer(Sender: TObject);
  private
    { Private declarations }
    docancel:boolean;
    expandcount:integer;
    oldtarget:TTreeNode;
    lobjects:TList;
    report:TVCLReport;
    CurrentLoaded:String;
    FReportstable,FGroupsTable:String;
    counter:Integer;
    mmfirst,mmlast:DWORD;
    difmilis:int64;
    dbinfo:TRpDatabaseInfoItem;
    doreadonly:Boolean;
    mouseX:integer;
    mouseY:integer;
    procedure IntFillTree(adir:string;anode:TTreeNode);
    procedure SaveDir(adir:String;anode:TTreeNode);
    procedure CheckCancel(acount:integer);
    procedure GenerateTree;
    procedure FillTreeForCurrentRecord(ANode:TTreeNode);
    procedure CheckLoaded;
    procedure DisableButtonsReport;
    procedure EnableButtonsReport;
  public
    { Public declarations }
    rootfilename:string;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure FillTree(adbinfo:TRpDatabaseInfoItem;groups:TDataset;reports:TDataset);overload;
    procedure FillTree(adir:string);overload;
    procedure FillTree(alist:TStringList);overload;
    procedure EditTree(adbinfo:TRpDatabaseInfoItem;readonly:boolean);
  end;


implementation

{$R *.dfm}



constructor TFRpDBTreeVCL.Create(AOwner:TComponent);
var
 ncontrolstyle:TControlStyle;
begin
 inherited Create(AOwner);

 ncontrolstyle:=ATree.ControlStyle;
 include(ncontrolstyle,csCaptureMouse);
 ATree.ControlStyle:=ncontrolstyle;
 lobjects:=TList.Create;
 ANew.Caption:=TranslateStr(790,ANew.Caption);
 ANew.Hint:=TranslateStr(791,ANew.Hint);
 ADelete.Caption:=TranslateStr(792,ADelete.Caption);
 ADelete.Hint:=TranslateStr(793,ADelete.Hint);
 APrint.Caption:=TranslateStr(52,APrint.Caption);
 APrint.Hint:=TranslateStr(53,APrint.Hint);
 APreview.Caption:=TranslateStr(54,APreview.Caption);
 APreview.Hint:=TranslateStr(55,APreview.Hint);
 APrintSetup.Caption:=TranslateStr(56,APrintSetup.Caption);
 APrintSetup.Hint:=TranslateStr(57,APrintSetup.Hint);
 AUserParams.Caption:=TranslateStr(135,AUserparams.Caption);
 AUserParams.Hint:=TranslateStr(136,AUserparams.Hint);
 ARename.Caption:=SRprename;
 ANew.Caption:=SRpNewReport;
 Anew.Hint:=SRpNewReport;
 ANewFolder.Caption:=SRpNewFolder;
 ANewFolder.Hint:=SRpNewFolder;
 ADelete.Caption:=SRpDeleteSelection;
 ADelete.Hint:=SRpDeleteSelection;
 AFind.Caption:=SRpSearchReport;
 AFind.Hint:=SRpSearchReport;
 AExportFolder.Caption:=SRpExportFolder;
 AExportFolder.Hint:=SRpExportFolderH;
end;

destructor TFRpDBTreeVCL.Destroy;
var
 i:integer;
begin
 for i:=0 to lobjects.count-1 do
 begin
  TObject(lobjects[i]).free;
 end;
 lobjects.clear;
 lobjects.free;

 ATree.Items.Clear;

 inherited Destroy;
end;

procedure TFRpDBTreeVCL.FillTree(adbinfo:TRpDatabaseInfoItem;groups:TDataset;reports:TDataset);
var
 acount:integer;
 i:integer;
 agroup,aname,agroupname:String;
begin
 // Get the time
{$IFDEF MSWINDOWS}
 mmfirst:=TimeGetTime;
{$ENDIF}
 agroup:='REPORT_GROUP';
 agroupname:='GROUP_NAME';
 aname:='REPORT_NAME';
 if Assigned(adbinfo) then
 begin
  aname:=adbinfo.ReportSearchField;
  if length(adbinfo.ReportGroupsTable)<1 then
   agroup:='';
 end;
 // Transport the dataset to the clientdatasets
 DReports.Close;
 DReportGroups.Close;
 DReportGroups2.Close;
 DReportsREPORT_NAME.Size:=reports.FieldByName(aname).size;
 if Length(agroup)>0 then
 begin
  DReportGroupsGROUP_NAME.Size:=groups.FieldByName(agroupname).Size;
  DReportGroups2GROUP_NAME.Size:=groups.FieldByName(agroupname).Size;
 end;
 DReports.CreateDataSet;
 DReportGroups.CreateDataset;
 DReportGroups2.Close;
 DReportGroups2.FieldDefs.Assign(DReportGroups.FieldDefs);
 DReportGroups2.IndexDefs.Assign(DReportGroups.IndexDefs);
 DReportGroups2.CreateDataSet;
 docancel:=false;
 acount:=0;
 BCancel.Visible:=True;
 try
  While Not groups.Eof do
  begin
   DReportGroups.Append;
   try
    DReportGroupsGROUP_CODE.Value:=groups.FieldByName('GROUP_CODE').Value;
    DReportGroupsGROUP_NAME.AsVariant:=groups.FieldByName('GROUP_NAME').AsVariant;
    DReportGroupsPARENT_GROUP.AsVariant:=groups.FieldByName('PARENT_GROUP').AsVariant;
    DReportGroups2.Append;
    try
     for i:=0 to DReportGroups2.Fields.Count-1 do
     begin
      DReportGroups2.Fields[i].AsVariant:=DReportGroups.Fields[i].AsVariant;
     end;
     DReportGroups2.Post;
    except
     DReportGroups2.Cancel;
     Raise;
    end;
    DReportGroups.Post;
   except
    DReportGroups.Cancel;
    Raise;
   end;
   inc(acount);
   CheckCancel(acount);
   groups.Next;
  end;

  acount:=0;
  While Not reports.Eof do
  begin
   DReports.Append;
   try
    DReportsREPORT_NAME.Value:=reports.FieldByName(aname).Value;
    if length(agroup)>0 then
    begin
     DReportsREPORT_GROUP.AsVariant:=reports.FieldByName(agroup).AsVariant;
     if DReportsREPORT_GROUP.IsNull then
      DReportsREPORT_GROUP.Value:=0;
    end
    else
     DReportsREPORT_GROUP.Value:=0;
    DReports.Post;
   except
    DReports.Cancel;
    Raise;
   end;
   inc(acount);
   CheckCancel(acount);
   reports.Next;
  end;

  // Generates the tree view
  GenerateTree;
 finally
  BCancel.Visible:=False;
 end;
end;

procedure TFRpDBTreeVCL.FillTreeForCurrentRecord(ANode:TTreeNode);
var
 amark:TBookMark;
 agroup:Integer;
 NewNode,ANewNode:TTreeNode;
 ninfo:TRpNodeInfo;
begin
 agroup:=DReportGroups2GROUP_CODE.Value;
 if Not DReportGroups2.FindKey([agroup]) then
  Exit;
 While (DReportGroups2PARENT_GROUP.Value=agroup) do
 begin
  NewNode:=ATree.Items.AddChild(ANode,DReportGroups2GROUP_NAME.AsString);
  NewNode.ImageIndex:=9;
  NewNode.SelectedIndex:=9;
  ninfo:=TRpNodeInfo.Create;
  lobjects.Add(ninfo);
  ninfo.ReportName:='';
  ninfo.Group_Code:=DReportGroups2GROUP_CODE.AsInteger;
  ninfo.Parent_Group:=DReportGroups2PARENT_GROUP.AsInteger;
  ninfo.Node:=NewNode;
  NewNode.Data:=ninfo;

  amark:=DReportGroups2.GetBookmark;
  try
   FillTreeForCurrentRecord(NewNode);
   DReportGroups2.GotoBookmark(amark);
  finally
   DReportGroups2.FreeBookmark(amark);
  end;
  // Add the reports for this group
  if DReports.FindKey([DReportGroups2GROUP_CODE.Value]) then
  begin
   While Not DReports.Eof do
   begin
    if DReportsREPORT_GROUP.IsNull then
     break;
    if DReportsREPORT_GROUP.Value<>DReportGroups2GROUP_CODE.Value then
      break;
    ANewNode:=ATree.Items.AddChild(NewNode,DReportsREPORT_NAME.AsString);
    ANewNode.ImageIndex:=10;
    ANewNode.SelectedIndex:=10;
    ninfo:=TRpNodeInfo.Create;
    lobjects.Add(ninfo);
    ninfo.ReportName:=DReportsREPORT_NAME.AsString;
    ninfo.Group_Code:=DReportsREPORT_GROUP.AsInteger;
    ninfo.Parent_Group:=0;
    ninfo.Node:=ANewNode;
    ANewNode.Data:=ninfo;
    DReports.Next;
   end;
  end;
  DReportGroups2.Next;
  if DReportGroups2.Eof then
   break;
  CheckCancel(0);
 end;
end;

procedure TFRpDBTreeVCL.GenerateTree;
var
 ANode,NewNode:TTreeNode;
 ATopItem:TTreeNode;
 ninfo:TRpNodeInfo;
begin
 ATree.Items.BeginUpdate;
 try
// ATopItem:=ATree.TopItem;
  ANode:=ATree.Items.AddChild(nil,'');
  ANode.ImageIndex:=9;
  ANode.SelectedIndex:=9;
  ninfo:=TRpNodeInfo.Create;
  lobjects.Add(ninfo);
  ninfo.ReportName:='';
  ninfo.Group_Code:=0;
  ninfo.Parent_Group:=0;
  ninfo.Node:=ANode;
  ANode.Data:=ninfo;

  ATopItem:=ANode;

  DReportGroups.First;
  While Not DReportGroups.Eof do
  begin
   if DReportGroupsPARENT_GROUP.Value=0 then
   begin
    ANode:=ATree.Items.AddChild(ATopItem,DReportGroupsGROUP_NAME.AsString);
    ANode.ImageIndex:=9;
    ANode.SelectedIndex:=9;
    ninfo:=TRpNodeInfo.Create;
    lobjects.Add(ninfo);
    ninfo.ReportName:='';
    ninfo.Group_Code:=DReportGroupsGROUP_CODE.AsInteger;
    ninfo.Parent_Group:=0;
    ninfo.Node:=ANode;
    ANode.Data:=ninfo;
    DReportGroups2.Locate('GROUP_CODE',DReportGroups.FieldByName('GROUP_CODE').Value,[]);
    FillTreeForCurrentRecord(ANode);
    // Add the reports for this group
    if DReports.FindKey([DReportGroupsGROUP_CODE.Value]) then
    begin
     While Not DReports.Eof do
     begin
      if DReportsREPORT_GROUP.IsNull then
       break;
      if DReportsREPORT_GROUP.Value<>DReportGroupsGROUP_CODE.Value then
       break;
      NewNode:=ATree.Items.AddChild(ANode,DReportsREPORT_NAME.AsString);
      NewNode.ImageIndex:=10;
      NewNode.SelectedIndex:=10;
      ninfo:=TRpNodeInfo.Create;
      lobjects.Add(ninfo);
      ninfo.ReportName:=DReportsREPORT_NAME.AsString;
      ninfo.Group_Code:=DReportsREPORT_GROUP.AsInteger;
      ninfo.Parent_Group:=0;
      ninfo.Node:=NewNode;
      NewNode.Data:=ninfo;
      DReports.Next;
      CheckCancel(0);
     end;
    end;
   end;
   DReportGroups.Next;
  end;
  // Insert te reports without any group
  DReports.First;
  While Not DReports.Eof do
  begin
   if Not DReportsREPORT_GROUP.IsNull then
    if DReportsREPORT_GROUP.Value=0 then
    begin
     NewNode:=ATree.Items.AddChild(ATopItem,DReportsREPORT_NAME.AsString);
     NewNode.ImageIndex:=10;
     NewNode.SelectedIndex:=10;
     ninfo:=TRpNodeInfo.Create;
     lobjects.Add(ninfo);
     ninfo.ReportName:=DReportsREPORT_NAME.AsString;
     ninfo.Group_Code:=DReportsREPORT_GROUP.AsInteger;
     ninfo.Parent_Group:=0;
     ninfo.Node:=NewNode;
     NewNode.Data:=ninfo;
    end;
   DReports.Next;
   CHeckCancel(0);
  end;
 finally
  ATree.Items.EndUpdate;
 end;
 ATopItem.Expand(false);
end;

procedure TFRpDBTreeVCL.CheckCancel(acount:integer);
begin
 mmlast:=TimeGetTime;
 difmilis:=(mmlast-mmfirst);
 if difmilis>PROGRESS_INTERVAL then
 begin
  // Get the time
  mmfirst:=TimeGetTime;
  docancel:=false;
  BCancel.Caption:=FormatFloat('###,####',acount)+'-'+SRpCancel;
  Application.ProcessMessages;
  if docancel then
   Raise Exception.Create(SRpOperationAborted);
 end;
end;

procedure TFRpDBTreeVCL.ADeleteExecute(Sender: TObject);
var
 curnode:TTreeNode;
 ninfo:TRpNodeInfo;
 astring:String;
 adata:TDataset;
 params:TStringList;
 aparam:TRpParamObject;
begin
 if smbYes<>RpMessageBox(SRpSureDeleteSection,SRpWarning,[smbYes,smbCancel],smsWarning,smbYes) then
  exit;
 // Creates a new group
 curnode:=ATree.Selected;
 if Not assigned(curnode) then
  exit;
 ninfo:=TRpNodeInfo(curnode.data);
 params:=TStringList.Create;
 try
  if Length(ninfo.ReportName)>0 then
  begin
   // A report can always be deleted
   astring:='DELETE FROM '+dbinfo.ReportTable+' WHERE '+
    dbinfo.ReportSearchField+'=:REPNAME';
   aparam:=TRpParamObject.Create;
   try
    aparam.Value:=String(ninfo.ReportName);
    params.AddObject('REPNAME',aparam);
    dbinfo.OpenDatasetFromSQL(astring,params,true,nil);
   finally
    aparam.free;
   end;
   //
   lobjects.Remove(curnode.Data);
   curnode.Free;
//   EditTree(dbinfo,doreadonly);
  end
  else
  begin
   // A group needs checking for a report using the
   // group or a group using the parent_group
   if dbinfo.ReportGroupsTable='GINFORME' then
    astring:='SELECT COUNT(GRUPO) AS COUNTG FROM '+dbinfo.ReportTable+
     ' WHERE GRUPO='+IntToStr(ninfo.Group_Code)
   else
    astring:='SELECT COUNT(REPORT_GROUP) AS COUNTG FROM '+dbinfo.ReportTable+
     ' WHERE REPORT_GROUP='+IntToStr(ninfo.Group_Code);
   adata:=dbinfo.OpenDatasetFromSQL(astring,nil,false,nil);
   try
    if adata.FieldByName('COUNTG').AsInteger>0 then
     Raise Exception.Create(SRpExistReportInThisGroup);
   finally
    adata.free;
   end;
   if dbinfo.ReportGroupsTable='GINFORME' then
    astring:='SELECT COUNT(CODIGO)AS COUNTG FROM '+dbinfo.ReportGroupsTable+
    ' WHERE GRUPO='+IntToStr(ninfo.Group_Code)
   else
    astring:='SELECT COUNT(GROUP_CODE) AS COUNTG FROM '+dbinfo.ReportGroupsTable+
    ' WHERE PARENT_GROUP='+IntToStr(ninfo.Group_Code);
   adata:=dbinfo.OpenDatasetFromSQL(astring,nil,false,nil);
   try
    if adata.FieldByName('COUNTG').AsInteger>0 then
     Raise Exception.Create(SRpGroupParent);
   finally
    adata.free;
   end;
   if dbinfo.ReportGroupsTable='GINFORME' then
    astring:='DELETE FROM '+dbinfo.ReportGroupsTable+
     ' WHERE CODIGO='+IntToStr(ninfo.Group_Code)
   else
    astring:='DELETE FROM '+dbinfo.ReportGroupsTable+
     ' WHERE GROUP_CODE='+IntToStr(ninfo.Group_Code);
   dbinfo.OpenDatasetFromSQL(astring,nil,true,nil);
   lobjects.Remove(curnode.Data);
   curnode.Free;
//   EditTree(dbinfo,doreadonly);
  end;
 finally
  params.free;
 end;
end;

procedure TFRpDBTreeVCL.APreviewExecute(Sender: TObject);
begin
 CheckLoaded;
 report.Preview:=true;
 report.Execute;
end;

procedure TFRpDBTreeVCL.CheckLoaded;
var
 ANode:TTreeNode;
 ninfo:TRpNodeInfo;
 memstream:TStream;
 afilename:String;
begin
 if Not Assigned(Report) then
  report:=TVCLReport.Create(Self);
 // See if selected node is a report
 if Not Assigned(ATree.Selected) then
  Raise Exception.Create(SRptReportnotfound);
 ANode:=ATree.Selected;
 if Assigned(ANode.Data) then
 begin
  ninfo:=TRpNodeinfo(ANode.Data);
  if Length(ninfo.ReportName)<1 then
   Raise Exception.Create(SRptReportnotfound);
  if CurrentLoaded=ninfo.ReportName then
   exit;
  memstream:=dbinfo.GetReportStream(ninfo.ReportName,nil);
  try
   memstream.Seek(0,soFromBeginning);
   report.LoadFromStream(memstream);
   CurrentLoaded:=ninfo.ReportName;
  finally
   memstream.free;
  end;
 end
 else
 begin
  // Construct the filename
  afilename:=rootfilename+'\'+GetFullFileName(ANode,C_DIRSEPARATOR)+'.rep';
  if report.filename<>afilename then
   report.filename:=afilename;
  report.CheckLoaded;
 end;
end;


procedure TFRpDBTreeVCL.DisableButtonsReport;
begin
 APreview.Enabled:=False;
 APrint.Enabled:=False;
 AUserParams.Enabled:=False;
end;


procedure TFRpDBTreeVCL.EnableButtonsReport;
begin
 APreview.Enabled:=True;
 APrint.Enabled:=True;
 AUserParams.Enabled:=True;
end;


procedure TFRpDBTreeVCL.AUserParamsExecute(Sender: TObject);
begin
 CheckLoaded;
 report.ShowParams;
end;

procedure TFRpDBTreeVCL.APrintExecute(Sender: TObject);
begin
 CheckLoaded;
 report.Preview:=false;
 report.Execute;
end;

procedure TFRpDBTreeVCL.BCancelClick(Sender: TObject);
begin
 docancel:=true;
end;

procedure TFRpDBTreeVCL.APrintSetupExecute(Sender: TObject);
begin
 PrinterSetupDialog1.Execute;
end;

procedure TFRpDBTreeVCL.SaveDir(adir:String;anode:TTreeNode);
var
 i:integer;
 newnode:TTreeNode;
 newdir,repname:string;
 ainfo:TRpNodeInfo;
 memstream:TMemoryStream;
begin
 // Save folders of de node
 for i:=0 to anode.Count-1 do
 begin
  newnode:=anode.Item[i];
  ainfo:=TRpNodeInfo(newnode.data);
  if Length(ainfo.ReportName)<1 then
  begin
   // Creates the dir
   newdir:=adir+'\'+String(newnode.Text);
   newdir:=StringReplace(newdir,'/','-',[rfReplaceAll]);
   CreateDir(newdir);
   SaveDir(newdir,newnode);
  end
  else
  begin
   memstream:=TMemoryStream(dbinfo.GetReportStream(ainfo.ReportName,nil));
   try
    memstream.Seek(0,soFromBeginning);
    repname:=StringReplace(ainfo.ReportName,'/','-',[rfReplaceAll]);
    repname:=StringReplace(repname,'\','-',[rfReplaceAll]);
    repname:=StringReplace(repname,'.',' ',[rfReplaceAll]);
    repname:=StringReplace(repname,'*','-',[rfReplaceAll]);
    memstream.SaveToFile(adir+'\'+repname+'.rep');
   finally
    memstream.free;
   end;
  end;
  inc(counter);
  CheckCancel(counter);
 end;
end;

procedure TFRpDBTreeVCL.ToolButton9Click(Sender: TObject);
var
 aDir:String;
 newnode:TTreeNode;
 i:integer;
 newdir:string;
 ainfo:TRpNodeInfo;
 memstream:TMemoryStream;
 repname:string;
begin
 // Exports database reports to filenames and directories
 if Not SaveDialog1.Execute then
  exit;
 adir:=ExtractFilePath(SaveDialog1.Filename);
 if Length(adir)<1 then
  exit;
 if adir[Length(adir)]='\' then
  adir:=Copy(adir,1,Length(adir)-1);
 // Get the time
 mmfirst:=TimeGetTime;
 counter:=0;
 BCancel.Visible:=True;
 try
  for i:=0 to ATree.Items.Count-1 do
  begin
   newnode:=Atree.Items.Item[i];
   if Assigned(newnode.Parent) then
    continue;
   ainfo:=TRpNodeInfo(newnode.data);
   if Length(ainfo.ReportName)<1 then
   begin
    // Creates the dir
    newdir:=adir+'\'+String(newnode.Text);
    newdir:=StringReplace(newdir,'/','-',[rfReplaceAll]);
    CreateDir(newdir);
    SaveDir(newdir,newnode);
   end
   else
   begin
    memstream:=TMemoryStream.Create;
    try
     memstream.Seek(0,soFromBeginning);
     repname:=StringReplace(ainfo.ReportName,'/','-',[rfReplaceAll]);
     repname:=StringReplace(repname,'\','-',[rfReplaceAll]);
     repname:=StringReplace(repname,'.',' ',[rfReplaceAll]);
     repname:=StringReplace(repname,'*','-',[rfReplaceAll]);
     memstream.SaveToFile(adir+'\'+repname+'.rep');
    finally
     memstream.free;
    end;
   end;
   inc(counter);
   CheckCancel(counter);
  end;
 finally
  BCancel.Visible:=False;
 end;
end;


procedure TFRpDBTreeVCL.IntFillTree(adir:string;anode:TTreeNode);
var
 srec:TSearchRec;
 Attr:Integer;
 ares:Integer;
 NewNode:TTreeNode;
 sdir:string;
begin
 Attr:=faAnyfile;
 sdir:=adir+'\*.*';
 ares:=FindFirst(sdir,Attr,srec);
 try
  if ares=0 then
  begin
   repeat
    if ((srec.Attr AND faDirectory)>0) then
    begin
     if ((srec.Name<>'.') AND (srec.Name<>'..')) then
     begin
      NewNode:=ATree.Items.AddChild(ANode,srec.Name);
      NewNode.ImageIndex:=9;
      NewNode.SelectedIndex:=9;
      IntFillTree(adir+'\'+srec.Name,NewNode);
     end;
    end
    else
    begin
     NewNode:=ATree.Items.AddChild(ANode,srec.Name);
     NewNode.ImageIndex:=10;
     NewNode.SelectedIndex:=10;
    end;
   until FindNext(srec)<>0;
  end;
 finally
  if ares=0 then
   FindClose(srec);
 end;
end;


procedure TFRpDBTreeVCL.FillTree(adir:string);
begin
 ATree.Items.Clear;
 ATree.Items.BeginUpdate;
 try
  IntFillTree(adir,ATree.TopItem);
 finally
  ATree.Items.EndUpdate;
 end;
end;

procedure TFRpDBTreeVCL.FillTree(alist:TStringList);
begin
 rpvgraphutils.FillTreeView(ATree,alist);
end;


procedure TFRpDBTreeVCL.EditTree(adbinfo:TRpDatabaseInfoItem;readonly:boolean);
var
 adatareports:TDataset;
 adatagroups:TDataset;
 sqltext:String;
begin
 doreadonly:=readonly;
 if readonly then
 begin
  ANew.Enabled:=false;
  AExportFolder.Enabled:=false;
  ANewFolder.Enabled:=false;
  ADelete.Enabled:=false;
  ARename.Enabled:=false;
  ATree.DragMode:=dmManual;
 end;
 dbinfo:=adbinfo;
 dbinfo.Connect(nil);
 ATree.Items.Clear;
 sqltext:='SELECT '+dbinfo.ReportSearchField;
 sqltext:=sqltext+','+dbinfo.ReportField;
 if length(dbinfo.ReportGroupsTable)>0 then
 begin
  if dbinfo.ReportGroupsTable='GINFORME' then
   sqltext:=sqltext+',GRUPO AS REPORT_GROUP'
  else
   sqltext:=sqltext+',REPORT_GROUP';
 end;
 sqltext:=sqltext+' FROM '+dbinfo.ReportTable;
 adatareports:=dbinfo.OpenDatasetFromSQL(sqltext,nil,false,nil);
 try
  if Length(dbinfo.ReportGroupsTable)>0 then
  begin
   if dbinfo.ReportGroupsTable='GINFORME' then
    adatagroups:=
    dbinfo.OpenDatasetFromSQL('SELECT CODIGO AS GROUP_CODE,NOMBRE AS GROUP_NAME,'+
      ' GRUPO AS PARENT_GROUP FROM '+dbinfo.Reportgroupstable,nil,false,nil)
   else
    adatagroups:=
    dbinfo.OpenDatasetFromSQL('SELECT GROUP_CODE,GROUP_NAME,'+
      ' PARENT_GROUP FROM '+dbinfo.Reportgroupstable,nil,false,nil);
  end
  else
  begin
   adatagroups:=TClientDataset.Create(nil);
   adatagroups.FieldDefs.Add('GROUP_CODE',ftinteger);
   adatagroups.FieldDefs.Add('GROUP_NAME',ftstring,100);
   adatagroups.FieldDefs.Add('PARENT_GROUP',ftinteger);
   TClientDataset(adatagroups).CreateDataSet;
  end;
  try
   FReportstable:=dbinfo.reporttable;
   FGroupsTable:=dbinfo.Reportgroupstable;
   FillTree(dbinfo,adatagroups,adatareports);
  finally
   adatagroups.free;
  end;
 finally
  adatareports.free;
 end;
end;


procedure TFRpDBTreeVCL.ANewFolderExecute(Sender: TObject);
var
 curnode:TTreeNode;
 ninfo:TRpNodeInfo;
 groupcode,newgroup:integer;
 astring:String;
 group_name:String;
 adata:TDataset;
 params:TStringList;
 aparam:TRpParamObject;
 ANode:TTreeNode;
 i:integer;
begin
 // Creates a new group
 curnode:=ATree.Selected;
 if assigned(curnode) then
 begin
  ninfo:=TRpNodeInfo(curnode.data);
  if Length(ninfo.ReportName)>0 then
  begin
   groupcode:=ninfo.Group_Code;
   // Look for the group
   for i:=0 to lobjects.count-1 do
   begin
    ninfo:=TRpNodeInfo(lobjects.Items[i]);
    if ninfo.Group_Code=groupcode then
    begin
     if Length(ninfo.ReportName)=0 then
     begin
      curnode:=ninfo.Node;
      break;
     end;
    end;
   end;
  end
  else
   groupcode:=ninfo.Group_Code;
 end
 else
 begin
  groupcode:=0;
 end;
 // Ask for the new group name
 group_name:=RpInputBox(SRpNewGroup,SRpSGroupName,'');
 if Length(group_name)<1 then
  exit;
 // obtain the next group code
 if dbinfo.ReportGroupsTable='GINFORME' then
  astring:='SELECT MAX(CODIGO) GCODE'+' FROM '+dbinfo.ReportGroupsTable
 else
  astring:='SELECT MAX(GROUP_CODE) GCODE'+' FROM '+dbinfo.ReportGroupsTable;
 adata:=dbinfo.OpenDatasetFromSQL(astring,nil,false,nil);
 try
  if ((adata.eof) and (adata.bof)) then
   newgroup:=1
  else
  begin
   if adata.FieldByName('GCODE').IsNull then
    newgroup:=1
   else
    newgroup:=adata.FieldByName('GCODE').AsInteger+1;
  end;
 finally
  adata.free;
 end;
 params:=TStringList.Create;
 try
  aparam:=TRpParamObject.Create;
  try
   aparam.Value:=String(group_name);
   params.AddObject('GROUPNAME',aparam);
   astring:='INSERT INTO '+dbinfo.ReportGroupsTable;
   if dbinfo.ReportGroupsTable='GINFORME' then
    astring:=Astring+ ' (CODIGO,NOMBRE,GRUPO)  '
   else
    astring:=Astring+ ' (GROUP_CODE,GROUP_NAME,PARENT_GROUP)  ';
   astring:=astring+ ' VALUES ('+
    IntToStr(newgroup)+',:GROUPNAME,'+IntToStr(groupcode)+')';
   dbinfo.OpenDatasetFromSQL(astring,params,true,nil);
  finally
   aparam.free;
  end;
 finally
  params.free;
 end;
 ANode:=ATree.Items.AddChild(curnode,group_name);
 ANode.ImageIndex:=9;
 ANode.SelectedIndex:=9;
 ninfo:=TRpNodeInfo.Create;
 lobjects.Add(ninfo);
 ninfo.ReportName:='';
 ninfo.Group_Code:=newgroup;
 ninfo.Parent_Group:=groupcode;
 ninfo.Node:=ANode;
 ANode.Data:=ninfo;
 ATree.Selected:=ANode;

// EditTree(dbinfo,doreadonly);
end;

procedure TFRpDBTreeVCL.ANewExecute(Sender: TObject);
var
 curnode,NewNode:TTreeNode;
 ninfo:TRpNodeInfo;
 groupcode:integer;
 reportname:String;
 astring:String;
 params:TStringList;
 aparam:TRpParamObject;
 aparam2:TRpParamObject;
 areport:TRpReport;
begin
 // inside or outside a group
 curnode:=ATree.Selected;
 if assigned(curnode) then
 begin
  ninfo:=TRpNodeInfo(curnode.data);
  groupcode:=ninfo.Group_Code;
 end
 else
  groupcode:=0;
 // Ask to the user for the new report name
 reportname:=RpInputBox(SRpNewReport,SRpReportName,'');
 if Length(reportname)<1 then
  exit;
 params:=TStringList.Create;
 try
  aparam:=TRpParamObject.Create;
  aparam2:=TRpParamObject.Create;
  try
   astring:='INSERT INTO '+dbinfo.ReportTable+' ( '+
    dbinfo.ReportSearchField+','+dbinfo.ReportField;
   if Length(dbinfo.ReportGroupsTable)>0 then
   begin
    if  dbinfo.ReportGroupsTable='GINFORME' then
     astring:=astring+',GRUPO,DEF_USUARIO'
    else
     astring:=astring+',REPORT_GROUP';
   end;
   astring:=astring+') VALUES (:REPNAME,:REPORT';
   if Length(dbinfo.ReportGroupsTable)>0 then
   begin
    if  dbinfo.ReportGroupsTable='GINFORME' then
     astring:=astring+','+IntToStr(groupcode)+',0'
    else
     astring:=astring+','+IntToStr(groupcode);
   end;
   astring:=astring+')';
   aparam.Value:=String(reportname);
   aparam2.Value:=Null;
   params.AddObject('REPNAME',aparam);
   params.AddObject('REPORT',aparam2);
   areport:=TRpReport.Create(nil);
   try
    areport.CreateNew;
    aparam2.Stream:=TMemoryStream.Create;
    try
     areport.SaveToStream(aparam2.Stream);
     aparam2.Stream.Seek(0,soFromBeginning);
     dbinfo.OpenDatasetFromSQL(astring,params,true,nil);
    finally
     aparam2.Stream.free;
    end;
   finally
    areport.free;
   end;
   NewNode:=ATree.Items.AddChild(curnode,reportname);
   NewNode.ImageIndex:=10;
   NewNode.SelectedIndex:=10;
   ninfo:=TRpNodeInfo.Create;
   lobjects.Add(ninfo);
   ninfo.ReportName:=reportname;
   ninfo.Group_Code:=groupcode;
   ninfo.Parent_Group:=0;
   ninfo.Node:=NewNode;
   NewNode.Data:=ninfo;
   ATree.Selected:=NewNode;
//   EditTree(dbinfo,doreadonly);
//   EFind.Text:=reportname;
//   FindDialog1Find(Self);
  finally
   aparam.free;
   aparam2.free;
  end;
 finally
  params.free;
 end;
end;

procedure TFRpDBTreeVCL.AFindExecute(Sender: TObject);
begin
 FindDialog1Find(Self);
end;

procedure TFRpDBTreeVCL.FindDialog1Find(Sender: TObject);
var
 curnode:TTreeNode;
 i:integer;
 dofirst:Boolean;
begin
 dofirst:=false;
 // Finds the string inside the tree
 curnode:=ATree.Selected;
 if Not Assigned(curnode) then
 begin
  dofirst:=true;
  curnode:=ATree.TopItem;
 end;
 if Not Assigned(curnode) then
  Exit;
 // Omits until curnode
 i:=0;
 if not dofirst then
 begin
  while i<Atree.Items.Count do
  begin
   if Atree.Items[i]=curnode then
   begin
    inc(i);
    break;
   end;
   inc(i);
  end;
 end;
 while i<Atree.Items.Count do
 begin
  if Pos(UpperCase(EFind.Text),UpperCase(Atree.Items[i].Text))>0 then
  begin
   ATree.Selected:=Atree.Items[i];
   break;
  end
  else
   inc(i);
 end;
 if i>=Atree.items.Count then
  Raise Exception.Create(SRptReportnotfound);
end;


procedure TFRpDBTreeVCL.ATreeChange(Sender: TObject; Node: TTreeNode);
var
 ANode:TTreeNode;
 ninfo:TRpNodeInfo;
begin
 // See if selected node is a report
 if Not Assigned(ATree.Selected) then
 begin
  DisableButtonsReport;
  exit;
 end;
 ANode:=ATree.Selected;
 if Not Assigned(Anode.Data) then
 begin
  if ANode.ImageIndex=9 then
   DisableButtonsReport
  else
   EnableButtonsReport;
 end
 else
 begin
  ninfo:=TRpNodeInfo(ANode.Data);
  if Length(ninfo.ReportName)<1 then
   DisableButtonsReport
  else
   EnableButtonsReport;
 end;
end;


procedure TFRpDBTreeVCL.ARenameExecute(Sender: TObject);
var
 ANode:TTreeNode;
 ninfo:TRpNodeInfo;
 oldername,newname:widestring;
 params:TStringList;
 aparam:TRpParamObject;
 aparam2:TRpParamObject;
 astring:string;
begin
 // See if selected node is a report
 if Not Assigned(ATree.Selected) then
 begin
  DisableButtonsReport;
  exit;
 end;
 ANode:=ATree.Selected;
 if Assigned(Anode.Data) then
 begin
  ninfo:=TRpNodeInfo(ANode.Data);
  if Length(ninfo.ReportName)<1 then
  begin
   // Rename folder
   oldername:=ANode.Text;
   newname:=RpInputBox(SRpRename,SRpSGroupName,oldername);
   if (oldername<>newname) then
    if Length(newname)>0 then
    begin
     params:=TStringList.Create;
     try
      aparam:=TRpParamObject.Create;
      aparam2:=TRpParamObject.Create;
      try
       aparam.Value:=String(newname);
       aparam2.Value:=ninfo.Group_Code;
       params.AddObject('GROUPNAME',aparam);
       params.AddObject('GROUPCODE',aparam2);
       astring:='UPDATE '+dbinfo.ReportGroupsTable;
       if dbinfo.ReportGroupsTable='GINFORME' then
        astring:=Astring+ ' SET NOMBRE=:GROUPNAME WHERE CODIGO=:GROUPCODE  '
       else
        astring:=Astring+ ' SET GROUP_NAME=:GROUPNAME WHERE GROUP_CODE=:GROUPCODE';
       dbinfo.OpenDatasetFromSQL(astring,params,true,nil);
       ANode.Text:=newname;
      finally
       aparam.free;
      end;
     finally
      params.free;
     end;
    end;
  end
  else
  begin
   // Rename report
   oldername:=ninfo.ReportName;
   newname:=RpInputBox(SRpRename,SRpReportName,oldername);
   if (oldername<>newname) then
    if Length(newname)>0 then
    begin
     params:=TStringList.Create;
     try
      aparam:=TRpParamObject.Create;
      aparam2:=TRpParamObject.Create;
      try
       astring:='UPDATE '+dbinfo.ReportTable+' SET '+
         dbinfo.ReportSearchField+'=:REPNAME'+
         ' WHERE '+dbinfo.ReportSearchField+'=:OLDREPNAME';
        aparam.Value:=String(newname);
        aparam2.Value:=String(oldername);
        params.AddObject('REPNAME',aparam);
        params.AddObject('OLDREPNAME',aparam2);
        dbinfo.OpenDatasetFromSQL(astring,params,true,nil);
       ANode.Text:=newname;
       ninfo.ReportName:=newname;
      finally
       aparam.free;
       aparam2.free;
      end;
     finally
      params.free;
     end;
    end;
  end;
 end;
end;



procedure TFRpDBTreeVCL.ATreeDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
 nodesource:TTreeNode;
 nodedest:TTreeNode;
 infosource,infodest:TRpNodeInfo;
begin
 TimerScroll1.Enabled:=true;
 mouseX:=X;
 mouseY:=Y;
 Accept:=false;
 if not assigned(ATree.Selected) then
  exit;
 if not (Source is TTreeView) then
  exit;
 if not (Sender is TTreeView) then
  exit;
 if (Sender<>Source) then
  exit;
 nodedest := ATree.GetNodeAt(X,Y);
 nodesource := ATree.Selected;
 if (nodedest = nil) then
   Exit;
 if nodedest=nodesource then
  exit;
 if not assigned(nodesource.Data) then
  exit;
 if not assigned(nodedest.Data) then
  exit;
 if not nodedest.Expanded then
 begin
  expandcount:=10;
  oldtarget:=nodedest;
  timerexpand.Enabled:=True;
 end;
 // Same group does nothing
 infosource:=TRpNodeInfo(nodesource.Data);
 infodest:=TRpNodeInfo(nodedest.Data);
 // Source is a folder
 if infosource.ReportName='' then
 begin
  // Both are folders
  if infodest.ReportName='' then
  begin
   if (infosource.Parent_Group<>infodest.Group_Code) then
    Accept:=true;
   // Check the source is not parent of the child
   if (Accept) then
   begin
    if nodedest.HasAsParent(nodesource) then
     Accept:=false;
   end;
  end
  else
  begin
   if infosource.Group_Code<>infodest.Group_Code then
    Accept:=true;
  end;
 end
 else
 // Source is a report
 begin
  if infodest.ReportName='' then
  begin
   if infosource.Group_Code<>infodest.Group_Code then
    Accept:=true;
  end
  else
  begin
   if infosource.Group_Code<>infodest.Group_Code then
    Accept:=true;
  end;
 end;
end;

procedure TFRpDBTreeVCL.ATreeDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
 nodesource:TTreeNode;
 nodedest:TTreeNode;
 infosource,infodest:TRpNodeInfo;
 params:TStringList;
 aparam:TRpParamObject;
 aparam2:TRpParamObject;
 astring:string;
begin
 if not assigned(ATree.Selected) then
  exit;
 if not (Source is TTreeView) then
  exit;
 if not (Sender is TTreeView) then
  exit;
 if (Sender<>Source) then
  exit;
 nodedest := ATree.GetNodeAt(X,Y);
 nodesource := ATree.Selected;
 if (nodedest = nil) then
 begin
   EndDrag(False);
   Exit;
 end;

 if nodedest=nodesource then
  exit;
 if not assigned(nodesource.Data) then
  exit;
 if not assigned(nodedest.Data) then
  exit;
 infosource:=TRpNodeInfo(nodesource.Data);
 infodest:=TRpNodeInfo(nodedest.Data);
 // Source as folder
 if (infosource.ReportName='') then
 begin
  params:=TStringList.Create;
  try
   aparam:=TRpParamObject.Create;
   aparam2:=TRpParamObject.Create;
   try
    // Destination is always the folder
    // For a report group_code
    aparam.Value:=infodest.Group_Code;
    aparam2.Value:=infosource.Group_Code;
    params.AddObject('GROUP',aparam);
    params.AddObject('GROUPCODE',aparam2);
    astring:='UPDATE '+dbinfo.ReportGroupsTable;
    if dbinfo.ReportGroupsTable='GINFORME' then
     astring:=Astring+ ' SET GRUPO=:GROUP WHERE CODIGO=:GROUPCODE  '
    else
     astring:=Astring+ ' SET PARENT_GROUP=:GROUP WHERE GROUP_CODE=:GROUPCODE';
    dbinfo.OpenDatasetFromSQL(astring,params,true,nil);
    // If it's a report change to his parent
    // else add as child
    infosource.Parent_Group:=infodest.Group_Code;
    if infodest.ReportName='' then
    begin
     nodesource.MoveTo(nodedest,naAddChildFirst);
    end
    else
    begin
     nodesource.MoveTo(nodedest.Parent,naAddFirst);
    end;
   finally
    aparam.free;
   end;
  finally
   params.free;
  end;
 end
 else
 begin
  // Source as report
  params:=TStringList.Create;
  try
   aparam:=TRpParamObject.Create;
   aparam2:=TRpParamObject.Create;
   try
    // Destination is always the folder
    // For a report group_code
    aparam.Value:=infodest.Group_Code;
    aparam2.Value:=String(infosource.ReportName);
    params.AddObject('GROUP',aparam);
    params.AddObject('REPNAME',aparam2);
    astring:='UPDATE '+dbinfo.ReportTable;
    if dbinfo.ReportGroupsTable='GINFORME' then
     astring:=Astring+ ' SET GRUPO=:GROUP WHERE NOMBRE=:REPNAME  '
    else
     astring:=Astring+ ' SET REPORT_GROUP=:GROUP WHERE REPORT_NAME=:REPNAME';
    dbinfo.OpenDatasetFromSQL(astring,params,true,nil);
    // If it's a report change to his parent
    // else add as child
    infosource.Group_Code:=infodest.Group_Code;
    if infodest.ReportName='' then
    begin
     nodesource.MoveTo(nodedest,naAddChild);
    end
    else
    begin
     infosource.Parent_Group:=infodest.Group_Code;
     nodesource.MoveTo(nodedest.Parent,naAddChild);
    end;
   finally
    aparam.free;
   end;
  finally
   params.free;
  end;
 end;
end;


procedure TFRpDBTreeVCL.ATreeEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
 TimerScroll1.Enabled:=false;
end;

procedure TFRpDBTreeVCL.timerscroll1Timer(Sender: TObject);
var
 target:TTreeNode;
begin
 // Top auto scroll
 // Get node at mouse Position
 target:=ATree.GetNodeAt(mouseX,mouseY);

 if Assigned(target) then
  if mouseY<20 then
  begin
    if target.GetPrevVisible <> nil then
    begin
     ATree.topitem :=target.GetPrevVisible;
    timerinvalidate.Enabled:=true;
    end;
  end;
 // Bottom autoscroll
 if MouseY > ATree.Height-20 then
 begin
   target:=ATree.GetNodeAt(2,2);
   if target.GetNextVisible <> nil then
   begin
     ATree.topitem := target.GetNextVisible;
     timerinvalidate.Enabled:=true;
   end;
 end;
end;


procedure TFRpDBTreeVCL.timerexpandTimer(Sender: TObject);
var
 target:TTreeNode;
begin
 // Top auto scroll
 // Get node at mouse Position
 target:=ATree.GetNodeAt(mouseX,mouseY);
 if target=nil then
 begin
  timerexpand.Enabled:=false;
  exit;
 end;
 if (oldtarget<>target) then
 begin
  timerexpand.Enabled:=false;
  exit;
 end;
 dec(expandcount);
 if (expandcount<0) then
 begin
  target.Expand(false);
  timerinvalidate.Enabled:=true;
  timerexpand.Enabled:=false;
 end;
end;

procedure TFRpDBTreeVCL.timerinvalidateTimer(Sender: TObject);
begin
 ATree.Invalidate;
 timerinvalidate.Enabled:=false;
end;

end.
