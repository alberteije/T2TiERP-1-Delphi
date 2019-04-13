{*******************************************************}
{                                                       }
{       Report Manager Server configuration             }
{                                                       }
{       mainfvcl                                        }
{                                                       }
{       Main form to configure the server               }
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

unit mainfvcl;

interface

{$I rpconf.inc}

uses
  SysUtils,
{$IFDEF USEVARIANS}
  Types,Variants, 
{$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, rptranslator, DB, DBClient, Grids, DBGrids,
  rpmdrepclient,rpmdconsts, ComCtrls, Buttons,rpgraphutilsvcl, ExtCtrls;

type
  TFMainVCL = class(TForm)
    LHost: TLabel;
    ComboHost: TComboBox;
    Trans: TRpTranslator;
    GUser: TGroupBox;
    LUserName: TLabel;
    EUserName: TEdit;
    EPassword: TEdit;
    LPassword: TLabel;
    BConnect: TButton;
    GServerinfo: TGroupBox;
    DDirectories: TClientDataSet;
    DDirectoriesAlias: TStringField;
    DDirectoriesServerPath: TStringField;
    SDirectories: TDataSource;
    BCloseConnection: TButton;
    LMessages: TListBox;
    LPort: TLabel;
    ComboPort: TComboBox;
    PControl: TPageControl;
    TabUsers: TTabSheet;
    GUsers: TGroupBox;
    LUsers: TListBox;
    BDeleteUser: TButton;
    BAddUser: TButton;
    BChangePassword: TButton;
    TabAliases: TTabSheet;
    GReportDirectories: TGroupBox;
    DBGrid1: TDBGrid;
    BAddAlias: TButton;
    BDeleteAlias: TButton;
    BPreviewTree: TButton;
    GGroups: TGroupBox;
    LGroups: TListBox;
    BAddGroup: TButton;
    BDeleteGroup: TButton;
    GUserGroups: TGroupBox;
    LUserGroups: TListBox;
    GGroups2: TGroupBox;
    LGroups2: TListBox;
    GAliasGroups: TGroupBox;
    LAliasGroups: TListBox;
    BAddUserGroup: TBitBtn;
    BDeleteUserGroup: TBitBtn;
    BDeleteAliasGroup: TBitBtn;
    BAddAliasGroup: TBitBtn;
    TabConnections: TTabSheet;
    PBotTasks: TPanel;
    GTasks: TDBGrid;
    adata: TClientDataSet;
    adataID: TIntegerField;
    adataLASTOPERATION: TDateTimeField;
    adataCONNECTIONDATE: TDateTimeField;
    adataUSERNAME: TStringField;
    adataRUNNING: TBooleanField;
    BRefresh: TButton;
    SData: TDataSource;
    BStop: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BConnectClick(Sender: TObject);
    procedure BCloseConnectionClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BAddUserClick(Sender: TObject);
    procedure BDeleteUserClick(Sender: TObject);
    procedure BChangePasswordClick(Sender: TObject);
    procedure BAddAliasClick(Sender: TObject);
    procedure BDeleteAliasClick(Sender: TObject);
    procedure OnLog(Sender:TObject;aMessage:WideString);
    procedure BPreviewTreeClick(Sender: TObject);
    procedure LUsersClick(Sender: TObject);
    procedure BAddGroupClick(Sender: TObject);
    procedure BDeleteGroupClick(Sender: TObject);
    procedure BAddUserGroupClick(Sender: TObject);
    procedure BDeleteUserGroupClick(Sender: TObject);
    procedure BAddAliasGroupClick(Sender: TObject);
    procedure BDeleteAliasGroupClick(Sender: TObject);
    procedure DDirectoriesAfterScroll(DataSet: TDataSet);
    procedure BRefreshClick(Sender: TObject);
    procedure BStopClick(Sender: TObject);
  private
    { Private declarations }
    repclient:TModClient;
    procedure OnGetUsers(alist:TStringList);
    procedure OnGetTree(alist:TStringList);
    procedure OnGetAliases(alist:TStringList);
    procedure OnGetGroups(alist:TStringList);
    procedure OnGetUserGroups(alist:TStringList);
    procedure OnGetAliasGroups(alist:TStringList);
    procedure OnGetTasks(astream:TMemoryStream);
  public
    { Public declarations }
  end;

var
  FMainVCL: TFMainVCL;

implementation

uses unewuservcl, unewaliasvcl, ureptreevcl;

{$R *.dfm}

procedure TFMainVCL.FormCreate(Sender: TObject);
begin
 Trans.Active:=True;
 Caption:=Trans.LoadString(749,Caption);
 Application.Title:=Caption;
 LHost.Caption:=Trans.LoadString(747,LHost.Caption);
 GUser.Caption:=Trans.LoadString(750,GUser.Caption);
 LUserName.Caption:=Trans.LoadString(751,LUserName.Caption);
 LPassword.Caption:=Trans.LoadString(752,LPassword.Caption);
 BConnect.Caption:=Trans.LoadString(753,BConnect.Caption);
 GServerInfo.Caption:=Trans.LoadString(755,GServerinfo.Caption);
 GUsers.Caption:=Trans.LoadString(756,GUsers.Caption);
 BDeleteUser.Caption:=Trans.LoadString(150,BDeleteUser.Caption);
 BAddUser.Caption:=Trans.LoadString(149,BAddUser.Caption);
 BChangePassword.Caption:=Trans.LoadString(757,BChangePassword.Caption);
 GReportDirectories.Caption:=Trans.LoadString(758,GReportDirectories.Caption);
 DDirectoriesAlias.DisplayLabel:=Trans.LoadString(759,DDirectoriesAlias.DisplayLabel);
 DDirectoriesServerPath.DisplayLabel:=Trans.LoadString(760,DDirectoriesServerpath.DisplayLabel);
 DDirectories.CreateDataset;
 BDeleteAlias.Caption:=Trans.LoadString(150,BDeleteAlias.Caption);
 BAddAlias.Caption:=Trans.LoadString(149,BAddAlias.Caption);
 BPreviewTree.Caption:=Trans.LoadString(761,BPreviewTree.Caption);
 BCloseConnection.Caption:=Trans.LoadString(762,BCloseConnection.Caption);
 LPort.Caption:=TranslateStr(829,LPort.Caption);
 PControl.ActivePageIndex:=0;
 TabAliases.Caption:=Trans.LoadString(758,GReportDirectories.Caption);
 TabUsers.Caption:=Trans.LoadString(750,GUser.Caption);
 GGroups.Caption:=SRpuserGroups;
 GGroups2.Caption:=SRpuserGroups;
 GAliasGroups.Caption:=SRpAliasGroups;
 GUserGroups.Caption:=SRpUserGroupsHint;
 BAddGroup.Caption:=SrpAdd;
 BDeleteGroup.Caption:=SRpDelete;

 TabConnections.Caption:=Trans.LoadString(1275,TabConnections.Caption);
 BRefresh.Caption:=Trans.LoadString(1149,BRefresh.Caption);
 BStop.Caption:=Trans.LoadString(762,BSTop.Caption);
end;


procedure TFMainVCL.BCloseConnectionClick(Sender: TObject);
begin
 if not assigned(repclient) then
  exit;
 Disconnect(repclient);
 repclient:=nil;
 ComboHost.Enabled:=True;
 ComboPort.Enabled:=True;
 GServerInfo.Visible:=False;
 GUser.Visible:=True;
 GTasks.Visible:=false;
end;

procedure TFMainVCL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(repclient) then
 begin
  BCloseConnectionClick(Self);
 end;
end;


procedure TFMainVCL.OnGetAliases(alist:TStringList);
var
 i:integer;
begin
 DDirectories.DisableControls;
 try
  DDirectories.Close;
  DDirectories.CreateDataSet;
  for i:=0 to alist.count-1 do
  begin
   DDirectories.Append;
   DDirectoriesAlias.AsString:=alist.Names[i];
   DDirectoriesServerPath.AsString:=alist.Values[alist.Names[i]];
   DDirectories.Post;
  end;
 finally
  DDirectories.EnableControls;
 end;
end;

procedure TFMainVCL.BAddUserClick(Sender: TObject);
var
 username,password:string;
begin
 // Shows the create user dialog
 username:='';
 password:='';
 if Not AskUserNameAndPassword(username,password,false) then
  exit;
 repclient.AddUser(username,password);
 repclient.GetUsers;
end;

procedure TFMainVCL.BDeleteUserClick(Sender: TObject);
begin
 if (LUSers.ItemIndex)<0 then
  exit;
 repclient.DeleteUser(LUSers.Items.Strings[LUsers.ItemIndex]);
 repclient.GetUsers;
end;

procedure TFMainVCL.BChangePasswordClick(Sender: TObject);
var
 username,password:string;
begin
 if (LUSers.ItemIndex)<0 then
  exit;
 // Shows the create user dialog
 username:=LUsers.Items.Strings[LUsers.ItemIndex];
 password:='';
 if Not AskUserNameAndPassword(username,password,false) then
  exit;
 repclient.AddUser(username,password);
 repclient.GetUsers;
end;

procedure TFMainVCL.BAddAliasClick(Sender: TObject);
var
 aliasname,path:string;
begin
 aliasname:='';
 path:='';
 if Not AskForNewAlias(aliasname,path) then
  exit;
 repclient.AddAlias(aliasname,path);
 repclient.GetAliases;
end;

procedure TFMainVCL.BDeleteAliasClick(Sender: TObject);
begin
 if (DDirectories.EOF and DDirectories.BOF) then
  exit;
 repclient.Deletealias(DDirectoriesALIAS.AsString);
 repclient.GetAliases;
end;

procedure TFMainVCL.OnLog(Sender:TObject;aMessage:WideString);
begin
 if amessage=SRpAuthFailed then
 begin
  ShowMessage(SRpUserorPasswordIncorrect);
  BCloseConnectionClick(Self);
 end;
 LMessages.Items.Insert(0,AMessage);
end;


procedure TFMainVCL.BPreviewTreeClick(Sender: TObject);
begin
 if (DDirectories.EOF and DDirectories.BOF) then
  exit;
 repclient.GetTree(DDirectoriesAlias.AsString);;
end;

procedure TFMainVCL.OnGetTree(alist:TStringList);
begin
 ShowReportTree(alist);
end;

procedure TFMainVCL.OnGetGroups(alist:TStringList);
var
 i:integer;
begin
 LGroups.Items.Clear;
 for i:=0 to alist.count-1 do
 begin
  LGroups.Items.Add(alist.Strings[i]);
 end;
 LGroups2.Items.Assign(LGroups.Items);
end;

procedure TFMainVCL.LUsersClick(Sender: TObject);
var
 username:String;
begin
 // Read groups for this user
 LUserGroups.Clear;
 username:='ADMIN';
 if LUSers.ItemIndex>=0 then
  username:=LUsers.Items.Strings[LUsers.ItemIndex];
 repclient.GetUserGroups(username);
end;

procedure TFMainVCL.OnGetUsers(alist:TStringList);
begin
 LUsers.Items.Assign(Alist);
 LUsersClick(Self);
end;

procedure TFMainVCL.OnGetUserGroups(alist:TStringList);
var
 i:integer;
begin
 LUserGroups.Clear;
 for i:=0 to alist.Count-1 do
 begin
  LUserGroups.Items.Add(alist.Names[i]);
 end;
end;

procedure TFMainVCL.OnGetAliasGroups(alist:TStringList);
var
 i:integer;
begin
 LAliasGroups.Clear;
 for i:=0 to alist.Count-1 do
 begin
  LAliasGroups.Items.Add(alist.Names[i]);
 end;
end;

procedure TFMainVCL.BConnectClick(Sender: TObject);
begin
 repclient:=Connect(ComboHost.Text,EUsername.Text,EPassword.Text,StrToInt(ComboPort.Text));
 ComboHost.Enabled:=False;
 ComboPort.Enabled:=False;
 GUser.Visible:=False;
 GServerInfo.Visible:=True;
 repclient.OnGetUsers:=OnGetUsers;
 repclient.OnGetTasks:=OnGetTasks;
 repclient.OnGetAliases:=OnGetAliases;
 repclient.OnGetGroups:=OnGetGroups;
 repclient.OnGetAliasGroups:=OnGetAliasGroups;
 repclient.OnGetUserGroups:=OnGetUserGroups;
 repclient.OnLog:=OnLog;
 repclient.OnError:=OnLog;
 repclient.OnGetTree:=OnGetTree;
 repclient.GetUsers;
 repclient.GetAliases;
 repclient.GetGroups;
end;


procedure TFMainVCL.BAddGroupClick(Sender: TObject);
var
 groupname:String;
begin
 groupname:=RpInputBox(SRpNewGroup,SRpGroup,'');
 repclient.AddGroup(groupname);
 repclient.GetUsers;
 repclient.GetGroups;
end;

procedure TFMainVCL.BDeleteGroupClick(Sender: TObject);
var
 groupname:String;
begin
 if LGroups.ItemIndex<0 then
  exit;
 groupname:=LGroups.Items.Strings[Lgroups.Itemindex];
 repclient.DeleteGroup(groupname);
 repclient.GetUsers;
 repclient.GetGroups;
end;

procedure TFMainVCL.BAddUserGroupClick(Sender: TObject);
var
 username:String;
 groupname:String;
begin
 if LUSers.ITemIndex<0 then
  exit;
 username:=LUSers.Items.Strings[LUSers.ITemIndex];
 if username='ADMIN' then
  exit;
 if LGroups.ItemIndex<0 then
  exit;
 groupname:=LGroups.Items.Strings[LGroups.Itemindex];
 repclient.AddUserGroup(username,groupname);
 repclient.GetUserGroups(username);
end;

procedure TFMainVCL.BDeleteUserGroupClick(Sender: TObject);
var
 username:String;
 groupname:String;
begin
 if LUSers.ITemIndex<0 then
  exit;
 username:=LUSers.Items.Strings[LUSers.ITemIndex];
 if username='ADMIN' then
  exit;
 groupname:=LUserGroups.Items.Strings[LUserGroups.Itemindex];
 repclient.DeleteUserGroup(username,groupname);
 repclient.GetUserGroups(username);
end;

procedure TFMainVCL.BAddAliasGroupClick(Sender: TObject);
var
 aliasname:String;
 groupname:String;
begin
 if (DDirectories.Eof and DDirectories.Bof) then
  exit;
 aliasname:=DDirectoriesAlias.AsString;
 if LGroups2.ItemIndex<0 then
  exit;
 groupname:=LGroups2.Items.Strings[LGroups2.Itemindex];
 repclient.AddAliasGroup(aliasname,groupname);
 repclient.GetAliasGroups(aliasname);
end;

procedure TFMainVCL.BDeleteAliasGroupClick(Sender: TObject);
var
 aliasname:String;
 groupname:String;
begin
 if (DDirectories.Eof and DDirectories.Bof) then
  exit;
 aliasname:=DDirectoriesAlias.AsString;
 groupname:=LAliasGroups.Items.Strings[LAliasGroups.Itemindex];
 repclient.DeleteAliasGroup(aliasname,groupname);
 repclient.GetAliasGroups(aliasname);
end;

procedure TFMainVCL.DDirectoriesAfterScroll(DataSet: TDataSet);
var
 aliasname:String;
begin
 if (DDirectories.Eof and DDirectories.Bof) then
  exit;
 aliasname:=DDirectoriesAlias.AsString;
 repclient.GetAliasGroups(aliasname);
end;

procedure TFMainVCL.OnGetTasks(astream:TMemoryStream);
begin
 astream.Seek(0,soFromBeginning);
 adata.Close;
 adata.CreateDataset;
 adata.LoadFromStream(astream);
 GTasks.Visible:=true;
end;

procedure TFMainVCL.BRefreshClick(Sender: TObject);
begin
 repclient.GetTasks;
end;

procedure TFMainVCL.BStopClick(Sender: TObject);
begin
 if not adata.Active then
  exit;
 if (Not (adata.Eof and adata.bof)) then
 begin
  repclient.CloseTask(adataID.Value);
  BRefreshClick(Self);
 end;
end;

end.

