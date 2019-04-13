{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfconnection                                 }
{                                                       }
{       Connections definition frame                    }
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

unit rpmdfconnection;

interface

{$I rpconf.inc}

uses
  SysUtils,rptypes,
{$IFDEF USEVARIANTS}
  Variants,Types,
{$ENDIF}
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  Classes, QGraphics, QControls, QForms,rpreport,
  QDialogs, QStdCtrls, QExtCtrls, QActnList,
{$IFDEF USEBDE}
  dbtables,
{$ENDIF}
{$IFDEF USEADO}
  adodb,
{$ENDIF}
  rpdatainfo,rpmdconsts,rpparams,
//  DBConnAdmin,
  rpgraphutils,rpdbxconfig,
  QMenus,
  QImgList, QTypes, QComCtrls;

type
  TFRpConnection = class(TFrame)
    ActionList1: TActionList;
    ANewConnection: TAction;
    ADelete: TAction;
    ToolBar1: TToolBar;
    BNew: TToolButton;
    ToolButton5: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    PParent: TPanel;
    PanelProps: TPanel;
    PopAdd: TPopupMenu;
    MNew: TMenuItem;
    PTop: TPanel;
    GDriver: TListBox;
    PDriver: TPanel;
    MHelp: TMemo;
    Panel1: TPanel;
    BConfig: TButton;
    GAvailable: TGroupBox;
    LConnections: TListBox;
    PConProps: TPanel;
    LConnectionString: TLabel;
    LAvailable: TLabel;
    LDriver: TLabel;
    CheckLoginPrompt: TCheckBox;
    CheckLoadParams: TCheckBox;
    CheckLoadDriverParams: TCheckBox;
    EConnectionString: TEdit;
    ComboAvailable: TComboBox;
    BBuild: TButton;
    ComboDriver: TComboBox;
    BTest: TButton;
    ImageList1: TImageList;
    LDotNetDriver: TLabel;
    ComboNetDriver: TComboBox;
    procedure GDriverClick(Sender: TObject);
    procedure LConnectionsClick(Sender: TObject);
    procedure BNewClick(Sender: TObject);
    procedure MNewClick(Sender: TObject);
    procedure BConfigClick(Sender: TObject);
    procedure BBuildClick(Sender: TObject);
    procedure ANewConnectionExecute(Sender: TObject);
    procedure PopAddPopup(Sender: TObject);
    procedure ADeleteExecute(Sender: TObject);
    procedure ComboDriverClick(Sender: TObject);
    procedure BTestClick(Sender: TObject);
    procedure CheckLoginPromptClick(Sender: TObject);
    procedure EConnectionStringChange(Sender: TObject);
  private
    { Private declarations }
    conadmin:TRpCOnnAdmin;
    FDatabaseInfo:TRpDatabaseInfoList;
    report:TRpReport;
    FParams:TRpParamList;
    procedure SetDatabaseInfo(Value:TRpDatabaseInfoList);
    procedure SetParams(Value:TRpParamList);
    procedure MenuAddClick(Sender:TObject);
    function FindDatabaseInfoItem:TRpDatabaseInfoItem;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property Databaseinfo:TRpDatabaseInfoList read FDatabaseinfo
     write SetDatabaseInfo;
    property Params:TRpParamList read FParams write
     SetParams;
  end;

implementation

{$R *.xfm}

constructor TFRpConnection.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 LDotNetDriver.Caption:=SRpDriverDotNet;
 // Translations
 BConfig.Caption:=TranslateStr(143,BConfig.Caption);
 CheckLoginPrompt.Caption:=TranslateStr(144,CheckLoginPrompt.Caption);
 CheckLoadParams.Caption:=TranslateStr(145,CheckLoadParams.Caption);
 CheckLoadDriverParams.Caption:=TranslateStr(146,CheckLoadDriverParams.Caption);
 BTest.Caption:=TranslateStr(753,BTest.Caption);
 BBuild.Caption:=TranslateStr(168,BBuild.Caption);

 GAvailable.Caption:=TranslateStr(1098,GAvailable.Caption);
 LConnectionString.Caption:=TranslateStr(1099,LConnectionString.Caption);
 LAvailable.Caption:=TranslateStr(1100,LAvailable.Caption);
 LDriver.Caption:=TranslateStr(1101,LDriver.Caption);
 MNew.Caption:=TranslateStr(40,MNew.Caption);
 ANewConnection.Caption:=TranslateStr(1102,ANewConnection.Caption);
 ANewConnection.Hint:=TranslateStr(1103,ANewConnection.Hint);
 ADelete.Caption:=TranslateStr(1104,ADelete.Caption);
 ADelete.Hint:=TranslateStr(1105,ADelete.Hint);

 GetRpDatabaseDrivers(GDriver.Items);
 GetRpDatabaseDrivers(ComboDriver.Items);

 report:=TRPReport.Create(Self);
 FDatabaseInfo:=report.databaseinfo;
 FParams:=report.Params;

 ConAdmin:=TRpConnAdmin.Create;

 GDriver.ItemIndex:=0;
 GDriverClick(Self);
end;

destructor TFRpConnection.Destroy;
begin
 conadmin.free;
 inherited destroy;
end;

procedure TFRpConnection.SetParams(Value:TRpParamList);
begin
 FParams.Assign(Value);
end;

procedure TFRpConnection.SetDatabaseInfo(Value:TRpDatabaseInfoList);
var
 i:integer;
begin
 ComboDriver.Width:=PConProps.Width-ComboDriver.Left-20;
 ComboNetDriver.Width:=PConProps.Width-ComboNetDriver.Left-20;
 EConnectionString.Width:=PConProps.Width-ECOnnectionString.Left-20;
 ComboAvailable.Width:=PConProps.Width-ComboAvailable.Left-20;
 ComboDriver.Anchors:=[akLeft,akTop,akRight];
 ComboAvailable.Anchors:=[akLeft,akTop,akRight];
 EConnectionString.Anchors:=[akLeft,akTop,akRight];

 if Value<>FDatabaseInfo then
  FDatabaseInfo.Assign(Value);
 LConnections.Clear;
 for i:=0 to FDatabaseinfo.Count-1 do
 begin
  LConnections.Items.Add(FDatabaseinfo.Items[i].Alias);
 end;
 if LConnections.Items.Count>0 then
  LConnections.ItemIndex:=0;
 LConnectionsClick(Self);
 GDriverClick(Self);
end;

procedure TFRpConnection.LConnectionsClick(Sender: TObject);
var
 dbinfo:TRpDatabaseInfoItem;
 index:integer;
begin
 if Not Assigned(FDatabaseInfo) then
  exit;
 If LConnections.Items.Count<1 then
 begin
  MHelp.Text:=SRpNewDatabaseInfo;
  CheckLoginPrompt.Visible:=False;
  LDotNetDriver.Visible:=False;
  ComboNetDriver.Visible:=False;
  CheckLoadParams.Visible:=False;
  CheckLoadDriverParams.Visible:=False;
  LConnectionString.Visible:=False;
  EConnectionString.Visible:=false;
  BBuild.Visible:=false;
  BTest.Visible:=false;
  ComboDriver.Visible:=false;
  LDriver.Visible:=false;
  Exit;
 end;
 If LConnections.ItemIndex<0 then
  exit;
 index:=FDatabaseInfo.IndexOf(LConnections.Items[LConnections.ItemIndex]);
 if index<0 then
  exit;
 CheckLoginPrompt.Visible:=True;
 CheckLoadParams.Visible:=True;
 LDotNetDriver.Visible:=true;
 ComboNetDriver.Visible:=true;
 BTest.Visible:=True;
 CheckLoadDriverParams.Visible:=True;
 ComboDriver.Visible:=true;
 LDriver.Visible:=true;
 // Get information about the dabaseinfo
 dbinfo:=FDatabaseinfo.Items[index];
 ComboDriver.ItemIndex:=Integer(dbinfo.Driver);
 ComboDriverClick(Self);
 CheckLoginPrompt.Checked:=dbinfo.LoginPrompt;
 if (dbinfo.Driver=rpdataDriver) then
  ComboNetDriver.ItemIndex:=dbinfo.DotNetDriver
 else
 if (dbinfo.Driver=rpdotnet2Driver) then
  ComboNetDriver.Text:=dbinfo.ProviderFactory;
 CheckLoadParams.Checked:=dbinfo.LoadParams;
 CheckLoadDriverParams.Checked:=dbinfo.LoadDriverParams;
 EConnectionString.OnChange:=nil;
 EConnectionString.Text:=EnCodeADOPassword(dbinfo.ADOConnectionString);
 EConnectionString.OnChange:=EConnectionStringChange;
end;

procedure TFRpConnection.GDriverClick(Sender: TObject);
begin
 if Not Assigned(FDatabaseInfo) then
  exit;
 case GDriver.ItemIndex of
  0:
   MHelp.Lines.Text:=SRpDBExpressDesc;
  1:
   MHelp.Lines.Text:=SRpMyBaseDesc;
  2:
   MHelp.Lines.Text:=SRpIBXDesc;
  3:
   MHelp.Lines.Text:=SRpBDEDesc;
  4:
   MHelp.Lines.Text:=SRpADODesc;
  5:
   MHelp.Lines.Text:=SRpIBODesc;
  6:
   MHelp.Lines.Text:=SrpDriverZeosDesc;
  7:
   MHelp.Lines.Text:=SRpDriverDotNetDesc;
 end;
 // Loads the alias config
 case TrpDbDriver(GDriver.ItemIndex) of
  // DBExpress
  rpdatadbexpress:
   begin
    BConfig.Visible:=true;
    if Assigned(ConAdmin) then
    begin
     conadmin.GetConnectionNames(ComboAvailable.Items,'');
    end;
   end;
  // IBX and IBO
  rpdataibx,rpdataibo:
   begin
    BConfig.Visible:=true;
    if Assigned(ConAdmin) then
    begin
     conadmin.GetConnectionNames(ComboAvailable.Items,'Interbase');
    end;
   end;
  // Zeos
  rpdatazeos:
   begin
    BConfig.Visible:=true;
    if Assigned(ConAdmin) then
    begin
     conadmin.GetConnectionNames(ComboAvailable.Items,'Interbase');
    end;
   end;
  // My Base
  rpdatamybase:
   begin
    BConfig.Visible:=True;
    ComboAvailable.Items.Clear;
   end;
  // BDE
  rpdatabde:
   begin
{$IFDEF USEBDE}
    BConfig.Visible:=true;
    Session.GetAliasNames(ComboAvailable.Items);
{$ENDIF}
   end;
  // ADO
  rpdataado:
   begin
{$IFDEF MSWINDOWS}
    BConfig.Visible:=false;
    BBuild.Visible:=false;
    ComboAvailable.Items.Clear;
{$ENDIF}
   end;
  rpdatadriver,rpdotnet2driver:
   begin
    BConfig.Visible:=false;
    BBuild.Visible:=false;
    ComboAvailable.Items.Clear;
    ComboNetDriver.Visible:=false;
    LDotNetDriver.Visible:=false;
   end;
 end;
end;


procedure TFRpConnection.BNewClick(Sender: TObject);
var
 apoint:TPoint;
begin
 if Not Assigned(FDatabaseInfo) then
  exit;
 apoint.x:=BNew.Left;
 apoint.y:=BNew.Top+BNew.Height;
 apoint:=BNew.Parent.ClientToScreen(apoint);
 BNew.DropDownMenu.Popup(apoint.x,apoint.y);
end;

procedure TFRpConnection.MNewClick(Sender: TObject);
var
 conname:string;
 item:TRpDatabaseInfoItem;
 index:integer;
begin
 if Not Assigned(FDatabaseInfo) then
  exit;
 conname:=UpperCase(Trim(RpInputBox(SRpNewConnection,SRpConnectionName,'')));
 if Length(conname)<1 then
  exit;
 item:=Fdatabaseinfo.Add(conname);
 item.Driver:=TRpDbDriver(GDriver.ItemIndex);
 SetDatabaseInfo(Fdatabaseinfo);
 index:=FDatabaseinfo.IndexOf(conname);
 if index>=0 then
 begin
  LConnections.ItemIndex:=index;
  LConnectionsClick(Self);
 end;
end;

procedure TFRpConnection.BConfigClick(Sender: TObject);
begin
 ShowDBXConfig(TRpDbDriver(GDriver.ItemIndex) in [rpdataibx,rpdataibo,rpdatamybase]);
 conadmin.free;
 conadmin:=TRPCOnnAdmin.Create;
 conadmin.GetConnectionNames(ComboAvailable.Items,'');
end;

procedure TFRpConnection.BBuildClick(Sender: TObject);
{$IFDEF USEADO}
var
 dinfoitem:TRpDatabaseinfoitem;
 newstring:String;
{$ENDIF}
begin
{$IFDEF USEADO}
 dinfoitem:=FindDatabaseInfoItem;
  if LConnections.ItemIndex<0 then
   Raise Exception.Create(SRpSelectAddConnection);
 EConnectionString.OnChange:=nil;
 newstring:=PromptDataSource(0,dinfoitem.ADOConnectionString);
 EConnectionString.Text:=EncodeADOPassword(newstring);
 dinfoitem.ADOConnectionString:=newstring;
 EConnectionString.Onchange:=EConnectionStringChange;
{$ENDIF}
end;

procedure TFRpConnection.ANewConnectionExecute(Sender: TObject);
var
 apoint:TPoint;
begin
 // Adds a new connection
 // Shows the popupmenu
 apoint.x:=BNew.Left;
 apoint.y:=BNew.Top+BNew.Height;
 apoint:=BNew.Parent.ClientToScreen(apoint);
 BNew.DropDownMenu.Popup(apoint.x,apoint.y);
end;


procedure TFRpConnection.PopAddPopup(Sender: TObject);
var
 aitem:TMenuItem;
 i:integer;
begin
 // Adds available items
 While PopAdd.Items.Count>1 do
  PopAdd.Items.Delete(1);
 for i:=0 to ComboAvailable.Items.Count-1 do
 begin
  aitem:=TMenuItem.Create(PopAdd);
  aitem.Caption:=ComboAvailable.Items.Strings[i];
  aitem.OnClick:=MenuAddClick;
  PopAdd.Items.Add(aitem);
 end;
end;

procedure TFRpConnection.ADeleteExecute(Sender: TObject);
var
 index:integer;
begin
 if LConnections.Itemindex<0 then
  exit;
 index:=databaseinfo.IndexOf(LConnections.items.strings[LConnections.Itemindex]);
 if index>=0 then
 begin
  databaseinfo.Delete(index);
  SetDatabaseInfo(databaseinfo);
  LConnectionsClick(Self);
 end;
end;

procedure TFRpConnection.ComboDriverClick(Sender: TObject);
var
 index:integeR;
begin
 if Not Assigned(FDatabaseInfo) then
  exit;
 if ComboDriver.ItemIndex<0 then
  exit;
 LConnectionString.Visible:=False;
 EConnectionString.Visible:=false;
 LDotNetDriver.Visible:=False;
 ComboNetDriver.Visible:=False;
 BBuild.Visible:=false;
 BTest.Visible:=true;
 // Loads the alias config
 case TrpDbDriver(ComboDriver.ItemIndex) of
  // DBExpress
  rpdatadbexpress:
   begin
    LConnectionString.Visible:=False;
    EConnectionString.Visible:=False;
    if Assigned(ConAdmin) then
    begin
     conadmin.GetConnectionNames(ComboAvailable.Items,'');
    end;
   end;
  // IBX and IBO
  rpdataibx,rpdataibo:
   begin
    LConnectionString.Visible:=False;
    EConnectionString.Visible:=False;
   end;
  // My Base
  rpdatamybase:
   begin
    LConnectionString.Visible:=False;
    EConnectionString.Visible:=False;
    BTest.Visible:=false;
   end;
  // BDE
  rpdatabde:
   begin
{$IFDEF USEBDE}
    LConnectionString.Visible:=False;
    EConnectionString.Visible:=False;
{$ENDIF}
   end;
  // ADO
  rpdataado:
   begin
{$IFDEF MSWINDOWS}
    LConnectionString.Visible:=True;
    EConnectionString.Visible:=True;
    BBuild.Visible:=true;
{$ENDIF}
   end;
  rpdatadriver:
   begin
    GetDotNetDrivers(ComboNetDriver.Items);
    ComboNetDriver.Style:=csDropDownList;
    LConnectionString.Visible:=True;
    EConnectionString.Visible:=True;
    BBuild.Visible:=true;
    LDotNetDriver.Visible:=true;
    ComboNetDriver.Visible:=true;
   end;
  rpdotnet2driver:
   begin
    ComboNetDriver.Style:=csDropDown;
    try
     GetDotNet2Drivers(ComboNetDriver.Items);
    except
     on E:Exception do
     begin
      ShowMessage(E.Message);
	ComboNetDriver.Clear;
     end;
    end;
    LConnectionString.Visible:=True;
    EConnectionString.Visible:=True;
    BBuild.Visible:=true;
    LDotNetDriver.Visible:=true;
    ComboNetDriver.Visible:=true;
   end;
 end;
 if LConnections.ItemIndex<0 then
  exit;
 index:=FDatabaseInfo.Indexof(LConnections.Items.Strings[LConnections.ItemIndex]);
 if index<0 then
  exit;
 FDatabaseInfo.Items[index].Driver:=TRpDbDriver(ComboDriver.ItemIndex);
end;

procedure TFRpConnection.MenuAddClick(Sender:TObject);
var
 conname:String;
 item:TRpDatabaseInfoItem;
 index:integer;
begin
 if Not Assigned(FDatabaseInfo) then
  exit;
 conname:=UpperCase(Trim(TMenuItem(Sender).Caption));
 if Length(conname)<1 then
  exit;
 item:=Fdatabaseinfo.Add(conname);
 item.Driver:=TRpDbDriver(GDriver.ItemIndex);
 SetDatabaseInfo(Fdatabaseinfo);
 index:=FDatabaseinfo.IndexOf(conname);
 if index>=0 then
 begin
  LConnections.ItemIndex:=index;
  LConnectionsClick(Self);
 end;
end;


function TFRpConnection.FindDatabaseInfoItem:TRpDatabaseInfoItem;
var
 index:integer;
begin
 Result:=nil;
 if Not Assigned(FDatabaseInfo) then
  exit;
 If LConnections.Items.Count<1 then
  exit;
 If LConnections.ItemIndex<0 then
  exit;
 index:=FDatabaseInfo.IndexOf(LConnections.Items[LConnections.ItemIndex]);
 if index<0 then
  exit;
 Result:=FDatabaseInfo.Items[index];
end;

procedure TFRpConnection.BTestClick(Sender: TObject);
var
 dbinfo:TRpDatabaseInfoItem;
 astring:string;
{$IFDEF MSWINDOWS}
 startinfo:TStartupinfo;
 linecount:string;
 FExename,FCommandLine:string;
 procesinfo:TProcessInformation;
{$ENDIF}
{$IFDEF LINUX}
 aparams:TStringList;
{$ENDIF}
begin
 dbinfo:=FindDatabaseInfoItem;
 if Not Assigned(dbinfo) then
  exit;
 if dbinfo.Driver in [rpdatadriver,rpdotnet2driver] then
 begin
  astring:=RpTempFileName;
  report.StreamFormat:=rpStreamXML;
  report.SaveToFile(astring);
{$IFDEF LINUX}
     aparams:=TStringList.Create;
     try
        aparams.Add('mono');
        if dbinfo.Driver=rpdatadriver then
         aparams.Add(ExtractFilePath(ParamStr(0))+'net/printreport.exe')
        else
         aparams.Add(ExtractFilePath(ParamStr(0))+'net2/printreport.exe');
        aparams.Add('-deletereport');
        aparams.Add('-testconnection');
        aparams.Add(dbinfo.Alias);
        aparams.Add(astring);
        ExecuteSystemApp(aparams,true);
     finally
        aparams.free;
     end;
{$ENDIF}
{$IFDEF MSWINDOWS}
  linecount:='';
  with startinfo do
  begin
   cb:=sizeof(startinfo);
   lpReserved:=nil;
   lpDesktop:=nil;
   lpTitle:=PChar('Report manager');
   dwX:=0;
   dwY:=0;
   dwXSize:=400;
   dwYSize:=400;
   dwXCountChars:=80;
   dwYCountChars:=25;
   dwFillAttribute:=FOREGROUND_RED or BACKGROUND_RED or BACKGROUND_GREEN or BACKGROUND_BLUe;
   dwFlags:=STARTF_USECOUNTCHARS or STARTF_USESHOWWINDOW;
   cbReserved2:=0;
   lpreserved2:=nil;
  end;

  if dbinfo.Driver=rpdatadriver then
   FExename:=ExtractFilePath(ParamStr(0))+'printreport.exe'
  else
   FExename:=ExtractFilePath(ParamStr(0))+'printreport2.exe';
  FCommandLine:=' -deletereport -testconnection '+dbinfo.Alias+' "'+
   astring+'"';
  if Not CreateProcess(Pchar(FExename),Pchar(Fcommandline),nil,nil,True,NORMAL_PRIORITY_CLASS or CREATE_NEW_PROCESS_GROUP,nil,nil,
     startinfo,procesinfo) then
      RaiseLastOSError;
{$ENDIF}
 end
 else
 begin
  dbinfo.Connect(params);
  try
   ShowMessage(SRpConnectionOk);
  finally
   dbinfo.DisConnect;
  end;
 end;
end;



procedure TFRpConnection.CheckLoginPromptClick(Sender: TObject);
var
 dinfoitem:TRpDatabaseinfoitem;
begin
 dinfoitem:=FindDatabaseInfoItem;
 if Not Assigned(dinfoitem) then
  exit;
 if Sender=CheckLoginPrompt then
 begin
  dinfoitem.LoginPrompt:=CheckLoginPrompt.Checked;
 end
 else
 if Sender=CheckLoadParams then
 begin
  dinfoitem.LoadParams:=CheckLoadParams.Checked;
 end
 else
 if Sender=ComboNetDriver then
 begin
  if dinfoitem.Driver=rpdatadriver then
   dinfoitem.DotNetDriver:=ComboNetDriver.ItemIndex
  else
   dinfoitem.ProviderFactory:=ComboNetDriver.Text;
 end
 else
 begin
  dinfoitem.LoadDriverParams:=CheckLoadDriverParams.Checked;
 end;
end;

procedure TFRpConnection.EConnectionStringChange(Sender: TObject);
var
 dinfoitem:TRpDatabaseinfoitem;
begin
 dinfoitem:=FindDatabaseInfoItem;
 if Not Assigned(dinfoitem) then
  exit;
 dinfoitem.ADOConnectionString:=EConnectionString.Text;
end;

end.
