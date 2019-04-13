{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpmdclitree                                     }
{                                                       }
{       Report Manager Client Frame,                    }
{       for Report Manager Server to manage login       }
{       and execution, integrated in metaview.exe       }
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

unit rpmdclitree;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, rptranslator, QStdCtrls, QExtCtrls,rpmdrepclient,
  rpmdconsts, QActnList, QImgList, QComCtrls,rpgraphutils,rpparams,
  rprfparams;

type
  TFRpCliTree = class(TFrame)
    PTop: TPanel;
    GUser: TGroupBox;
    LUserName: TLabel;
    EUserName: TEdit;
    EPassword: TEdit;
    LPassword: TLabel;
    BConnect: TButton;
    PClient: TPanel;
    LHost: TLabel;
    ComboHost: TComboBox;
    PMessages: TPanel;
    LMessages: TMemo;
    Splitter1: TSplitter;
    PTree: TPanel;
    BToolBar: TToolBar;
    ImageList1: TImageList;
    ActionList1: TActionList;
    AConnect: TAction;
    ADisconnect: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    AParameters: TAction;
    AExecute: TAction;
    ToolButton4: TToolButton;
    LTree: TTreeView;
    PAlias: TPanel;
    Label1: TLabel;
    ComboAlias: TComboBox;
    imalist: TImageList;
    ComboPort: TComboBox;
    LPort: TLabel;
    procedure BExecuteClick(Sender: TObject);
    procedure BConnectClick(Sender: TObject);
    procedure BDisconnectClick(Sender: TObject);
    procedure ComboAliasClick(Sender: TObject);
    procedure LTreeChange(Sender: TObject; Node: TTreeNode);
    procedure AParametersExecute(Sender: TObject);
  private
    { Private declarations }
    FStream:TMemoryStream;
    FOnExecuteServer:TNotifyEvent;
    amod:TModClient;
    loadedreport:Boolean;
    paramscomp:TRpParamComp;
    openedreport:boolean;
    procedure InsertMessage(aMessage:WideString);
    procedure OnError(Sender:TObject;aMessage:WideString);
    procedure OnLog(Sender:TObject;aMessage:WideString);
    procedure OnAuthorization(Sender:TObject);
    procedure OnExecute(Sender:TObject);
    procedure OnGetAliases(alist:TStringList);
    procedure OnGetTree(alist:TStringList);
    procedure OnGetParams(astream:TMemoryStream);
  public
    { Public declarations }
    initialwidth:integer;
    asynchrohous:boolean;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property OnExecuteServer:TNotifyEvent read FOnExecuteServer write FOnExecuteServer;
    property Stream:TMemoryStream read FStream;
  end;

implementation

{$R *.xfm}

constructor TFRpCliTree.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FStream:=TMemoryStream.Create;
 LHost.Caption:=TranslateStr(747,LHost.Caption);
 LUserName.Caption:=TranslateStr(751,LUserName.Caption);
 LPassword.Caption:=TranslateStr(752,LPassword.Caption);
 GUser.Caption:=TranslateStr(750,Guser.Caption);
 AConnect.Caption:=TranslateStr(753,AConnect.Caption);
 ADisconnect.Caption:=TranslateStr(777,ADisconnect.Caption);
 ADisconnect.Hint:=TranslateStr(778,ADisconnect.Hint);
 AExecute.Caption:=TranslateStr(779,AExecute.Caption);
 AExecute.Hint:=TranslateStr(780,AExecute.Hint);
 AParameters.Caption:=TranslateStr(135,AParameters.Caption);
 AParameters.Hint:=TranslateStr(136,AParameters.Hint);
 paramscomp:=TRpParamComp.Create(Self);
 LPort.Caption:=TranslateStr(829,LPort.Caption);

 InitialWidth:=Width;
end;



destructor TFRpCliTree.Destroy;
begin
 FStream.Free;
 if assigned(amod) then
  Disconnect(amod);
 inherited Destroy;
end;


procedure TFRpCliTree.InsertMessage(aMessage:WideString);
begin
 if (csDestroying in ComponentState) then
  exit;
 LMessages.Lines.Insert(0,FormatDateTime('dd/mm/yyyy hh:nn:ss - ',Now)+aMessage);
 if LMessages.Lines.Count>1000 then
  LMEssages.Lines.Delete(LMessages.Lines.Count-1);
end;



procedure TFRpCliTree.OnLog(Sender:TObject;aMessage:WideString);
begin
 InsertMessage(aMessage);
 if aMessage=SRpAuthFailed then
  ADisconnect.Execute;
end;

procedure TFRpCliTree.OnError(Sender:TObject;aMessage:WideString);
begin
 OnLog(Sender,aMessage);
 ShowMessage(aMessage);
end;

procedure TFRpCliTree.OnAuthorization(Sender:TObject);
begin
 InsertMessage(SRpAuthorized);
// LAliases.Lines.Assign((Sender As TModClient).Aliases);
end;

procedure TFRpCliTree.OnExecute(Sender:TObject);
begin
 stream.Clear;
 stream.SetSize(amod.Stream.Size);
 stream.Write(amod.Stream.Memory^,amod.Stream.Size);
 stream.Seek(0,soFromBeginning);
 if Assigned(OnExecuteServer) then
  OnExecuteServer(Self);
 loadedreport:=true;
end;

procedure TFRpCliTree.BExecuteClick(Sender: TObject);
var
 afilename:string;
begin
 if assigned(amod) then
 begin
  if assigned(LTree.Selected) then
  begin
   if openedreport then
   begin
    amod.asynchronous:=asynchrohous;
    amod.Execute;
   end
   else
   begin
    if LTree.Selected.ImageIndex=3 then
    begin
     amod.asynchronous:=asynchrohous;
     // Execute with alias and report filename
     afilename:=GetFullFileName(LTree.Selected,amod.dirseparator)+'.rep';
     amod.Execute(ComboAlias.Text,afilename);
    end;
   end;
  end;
 end;
end;

procedure TFRpCliTree.BConnectClick(Sender: TObject);
begin
 amod:=Connect(ComboHost.Text,EUserName.Text,EPassword.Text,StrToInt(ComboPort.Text));
 amod.OnAuthorization:=OnAuthorization;
 amod.OnExecute:=OnExecute;
 amod.asynchronous:=asynchrohous;
 amod.OnError:=OnError;
 amod.OnLog:=OnLog;
 amod.OnGetAliases:=OnGetAliases;
 amod.OnGetTree:=OnGetTree;
 amod.OnGetParams:=OnGetParams;
 amod.GetAliases;
 PTop.Visible:=False;
 LTree.Visible:=True;
 BToolBar.Visible:=True;
 PAlias.Visible:=true;
end;

procedure TFRpCliTree.BDisconnectClick(Sender: TObject);
begin
 Disconnect(amod);
 amod:=nil;
 LTree.Visible:=false;
 PAlias.Visible:=false;
 BToolBar.Visible:=False;
 PTop.Visible:=true;
 LTree.Items.Clear;
end;

procedure TFRpCliTree.OnGetAliases(alist:TStringList);
var
 i:integer;
begin
 ComboAlias.Items.Clear;
 for i:=0 to alist.count-1 do
  Comboalias.Items.Add(alist.Names[i]);
 ComboAlias.ItemIndex:=0;
 ComboAliasClick(Self);
end;

procedure TFRpCliTree.OnGetTree(alist:TStringList);
begin
 LTree.Items.Clear;
 rpgraphutils.FillTreeView(LTree,alist);
end;

procedure TFRpCliTree.ComboAliasClick(Sender: TObject);
begin
 amod.GetTree(ComboAlias.Text);
end;

procedure TFRpCliTree.LTreeChange(Sender: TObject; Node: TTreeNode);
begin
 openedreport:=false;
 if Assigned(LTree.Selected) then
 begin
  if LTree.Selected.ImageIndex=3 then
  begin
   AExecute.Enabled:=true;
   AParameters.Enabled:=true;
  end
  else
  begin
   AExecute.Enabled:=false;
   AParameters.Enabled:=false;
  end;
 end
 else
 begin
  AExecute.Enabled:=false;
  AParameters.Enabled:=false;
 end;
end;

procedure TFRpCliTree.AParametersExecute(Sender: TObject);
var
 afilename:string;
begin
 // Gets the parameters and assign them after execution
 if assigned(amod) then
 begin
  if assigned(LTree.Selected) then
  begin
   if openedreport then
   begin

   end
   else
   begin
    if LTree.Selected.ImageIndex=3 then
    begin
     amod.asynchronous:=asynchrohous;
     // Execute with alias and report filename
     afilename:=GetFullFileName(LTree.Selected,amod.dirseparator)+'.rep';
     amod.OpenReport(ComboAlias.Text,afilename);
    end;
   end;
   amod.GetParams;
  end;
 end;
end;

procedure TFRpCliTree.OnGetParams(astream:TMemoryStream);
var
 acompo:TRpParamComp;
 reader:TReader;
begin
 openedreport:=true;
 acompo:=TRpParamComp.Create(nil);
 try
  reader:=TReader.Create(astream,4096);
  try
   reader.ReadRootComponent(acompo);
   if ShowuserParams(acompo.params) then
    amod.ModifyParams(acompo);
  finally
   reader.free;
  end;
 finally
  acompo.free;
 end;
end;

end.
