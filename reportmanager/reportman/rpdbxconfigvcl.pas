{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpdbxconfigvcl                                  }
{                                                       }
{       Configuration dialog for connections            }
{       it stores all info in config files              }
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

unit rpdbxconfigvcl;

interface

{$I rpconf.inc}

uses SysUtils, Classes,
  Graphics, Forms,ComCtrls, ImgList,
  Buttons, ExtCtrls, Controls, StdCtrls,Dialogs,
  rpgraphutilsvcl,rpdatainfo,
{$IFDEF USESQLEXPRESS}
  SQLExpr,
{$IFNDEF DELPHI2009UP}
  DBXpress,
{$ENDIF´}
{$ENDIF}
{$IFDEF USEZEOS}
 ZDbcIntfs,ZConnection,
{$ENDIF}
{$IFDEF USEVARIANTS}
 Variants,
{$ENDIF}
  DB,rpmdconsts, ToolWin;

const
 CONTROL_DISTANCEY=5;
 CONTROL_DISTANCEX=10;
 CONTROL_DISTANCEX2=150;
 CONTROL_WIDTHX=200;
 LABEL_INCY=4;
type
  TFRpDBXConfigVCL = class(TForm)
    Panel1: TPanel;
    LDriversFile: TLabel;
    LConnsFile: TLabel;
    EDriversFile: TEdit;
    EConnectionsFile: TEdit;
    ImageList1: TImageList;
    PanelParent: TPanel;
    PanelLeft: TPanel;
    LConnections: TListBox;
    ToolBar1: TToolBar;
    BAdd: TToolButton;
    BDelete: TToolButton;
    ToolButton1: TToolButton;
    BShowProps: TToolButton;
    ToolButton2: TToolButton;
    BConnect: TToolButton;
    ToolButton3: TToolButton;
    BClose: TToolButton;
    Panel2: TPanel;
    ComboDrivers: TComboBox;
    LShowDriver: TLabel;
    ScrollParams: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure ComboDriversClick(Sender: TObject);
    procedure LConnectionsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BAddClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure BShowPropsClick(Sender: TObject);
    procedure BConnectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCloseClick(Sender: TObject);
  private
    { Private declarations }
    DriversFile:string;
    params:TStringList;
    connectionname:string;
    onlyibx:boolean;
{$IFDEF USESQLEXPRESS}
    SQLConnection1: TSQLConnection;
{$ENDIF}
    conadmin:TRpConnAdmin;
    procedure FreeParamsControls;
    procedure CreateParamsControls;
    procedure Edit1Change(Sender:TObject);
    procedure UpdateIBX;
  public
    { Public declarations }
    ConnectionsFile:string;
  end;

procedure ShowDBXConfig(onlyibx:boolean;ConnectionsFile:string='');

implementation

{$R *.dfm}


procedure ShowDBXConfig(onlyibx:boolean;ConnectionsFile:string);
var
 dia:TFRpDBXCOnfigVCL;
begin
 dia:=TFRpDBXConfigVCL.Create(Application);
 try
  dia.onlyibx:=onlyibx;
  dia.ConnectionsFile:=Trim(ConnectionsFile);
  dia.UpdateIBX;
  dia.showmodal;
 finally
  dia.free;
 end;
end;

procedure TFRpDBXConfigVCL.FormCreate(Sender: TObject);
begin
 ConAdmin:=TRpConnAdmin.Create;
{$IFDEF USESQLEXPRESS}
 SQLConnection1:=TSQLConnection.Create(Self);
{$ENDIF}
{$IFNDEF USESQLEXPRESS}
 BConnect.Enabled:=false;
{$ENDIF}
 LDriversFile.Caption:=TranslateStr(169,LDriversFile.Caption);
 LConnsFile.Caption:=TranslateStr(170,LConnsFile.Caption);
 LShowDriver.Caption:=TranslateStr(171,LShowDriver.Caption);
 BClose.Hint:=TranslateStr(172,BCLose.Hint);
 BShowProps.Hint:=TranslateStr(173,BShowProps.Hint);
 BConnect.Hint:=TranslateStr(174,BConnect.Hint);
 BDelete.Hint:=TranslateStr(175,BDelete.Hint);
 BAdd.Hint:=TranslateStr(176,BAdd.Hint);
 Caption:=TranslateStr(177,Caption);

 params:=TStringList.Create;
 // Read the drivers file
 DriversFile:=COnAdmin.driverfilename;
 EDriversFile.Text:=DriversFile;
 // Read the connections file
 if Length(ConnectionsFile)<1 then
 begin
  Connectionsfile:=ConAdmin.configfilename;
 end;
 EConnectionsFile.Text:=ConnectionsFile;
 // Read the database connections
 ConAdmin.GetDriverNames(ComboDrivers.Items);
 ComboDrivers.Items.Insert(0,SRpAllDriver);
 ComboDrivers.ItemIndex:=0;
 ComboDriversClick(Self);
end;

procedure TFRpDBXConfigVCL.ComboDriversClick(Sender: TObject);
var
 drivername:string;
begin
 // Load the connections
 if Not Assigned(ConAdmin) then
  exit;
 drivername:=ComboDrivers.Text;
 if drivername=SRpAllDriver then
  drivername:='';
 ConAdmin.GetConnectionNames(LConnections.items,drivername);
 if LConnections.Items.Count>0 then
  LConnections.ItemIndex:=0
 else
  LConnections.ItemIndex:=-1;
 LConnectionsClick(Self);
end;


procedure TFRpDBXConfigVCL.FreeParamsControls;
var
 i:integer;
begin
 i:=0;
 While  ScrollParams.ControlCount>0 do
 begin
  ScrollParams.Controls[i].Free;
 end;
end;

procedure TFRpDBXConfigVCL.CreateParamsControls;
var
 i:integer;
 index:integer;
 label1:TLabel;
 Edit1:TWinControl;
 top:integer;
 alist:TStringList;
begin
 if Not Assigned(ConAdmin) then
  exit;
 alist:=TStringList.create;
 try
  ConAdmin.Drivers.ReadSections(alist);
  top:=CONTROL_DISTANCEY;
  ConAdmin.GetConnectionParams(connectionname,params);
  for i:=0 to params.Count-1 do
  begin
   label1:=TLabel.Create(Self);
   label1.Caption:=params.Names[i];
   label1.Top:=Top+LABEL_INCY;
   label1.Left:=CONTROL_DISTANCEX;
   label1.Parent:=ScrollParams;
   // It can be a combo with different options
   index:=alist.indexof(params.Names[i]);
   if index<0 then
   begin
    Edit1:=TEdit.Create(Self);
    TEdit(Edit1).Text:=params.Values[params.Names[i]];
    if AnsiUpperCase(params.Names[i])='DRIVERNAME' then
    begin
     TEdit(Edit1).ReadOnly:=true;
     TEdit(Edit1).Color:=clBtnFace;
    end
    else
     TEdit(Edit1).OnChange:=Edit1Change;
    if AnsiUpperCase(params.Names[i])='PASSWORD' then
     TEdit(Edit1).PasswordChar:='*';
   end
   else
   begin
    Edit1:=TComboBox.Create(Self);
    TComboBox(Edit1).Style:=csDropDownList;
    TComboBox(Edit1).Visible:=False;
    TComboBox(Edit1).Parent:=ScrollParams;
    ConAdmin.Drivers.ReadSection(alist.strings[index],TComboBox(Edit1).Items);
    TComboBox(Edit1).Text:=params.Values[params.Names[i]];
    TComboBox(Edit1).ItemIndex:=TComboBox(Edit1).Items.IndexOf(params.Values[params.Names[i]]);
    TComboBox(Edit1).OnChange:=Edit1Change;
   end;

   Edit1.Tag:=i;
   Edit1.Top:=Top;
   Edit1.Left:=CONTROL_DISTANCEX2;
   Edit1.Width:=CONTROL_WIDTHX;

   Edit1.Parent:=ScrollParams;
   Edit1.Visible:=True;

   top:=top+Edit1.Height+CONTROL_DISTANCEY;
  end;
 finally
  alist.free;
 end;
end;

procedure TFRpDBXConfigVCL.LConnectionsClick(Sender: TObject);
begin
 if LConnections.ItemIndex<0 then
 begin
  ScrollParams.Visible:=false;
  exit;
 end;
 ScrollParams.Visible:=true;
 connectionname:=LConnections.Items.strings[LConnections.ItemIndex];
 FreeParamsControls;
 CreateParamsControls;
end;


procedure TFRpDBXConfigVCL.FormDestroy(Sender: TObject);
begin
 params.Free;
 ConAdmin.free;
end;

procedure TFRpDBXConfigVCL.Edit1Change(Sender:TObject);
var
 paramvalue:string;
 paramname:string;
 conname:string;
 index:integer;
begin
 if Not Assigned(ConAdmin) then
  exit;
 conname:=LConnections.Items.Strings[LConnections.ItemIndex];
 paramname:=params.Names[TEdit(Sender).Tag];
 paramvalue:=TEdit(Sender).Text;
 if Length(paramvalue)=0 then
 begin
  index:=params.IndexOfName(paramname);
  if index>=0 then
  begin
   params.Strings[index]:=paramname+'=';
  end;
 end
 else
  params.Values[paramname]:=paramvalue;
 ConAdmin.config.WriteString(conname,paramname,paramvalue);
 ConAdmin.config.UpdateFile;
end;

procedure TFRpDBXConfigVCL.BAddClick(Sender: TObject);
var
 newname:string;
begin
 if Not Assigned(ConAdmin) then
  exit;
 if ComboDrivers.ItemIndex=0 then
  Raise Exception.Create(SRpSelectDriver);
 newname:=UpperCase(Trim(RpInputBox(SRpNewConnection,SRpConnectionName,'')));
 if Length(newname)<1 then
  exit;
 ConAdmin.AddConnection(newname,ComboDrivers.Text);
 ConAdmin.config.UpdateFile;
 ComboDriversClick(Self);
 LConnections.ItemIndex:=LConnections.Items.IndexOf(newname);
 LConnectionsClick(Self);
end;

procedure TFRpDBXConfigVCL.BDeleteClick(Sender: TObject);
var
 conname:string;
begin
 if Not Assigned(ConAdmin) then
  exit;
 if LConnections.ItemIndex<0 then
  exit;
 conname:=LConnections.Items.Strings[LConnections.ItemIndex];
 if smbOk=RpMessageBox(SRpSureDropConnection+conname,SRpDropConnection,[smbok,smbCancel],smsWarning,smbCancel) then
 begin
  ConAdmin.DeleteConnection(conname);
  ConAdmin.Config.UpdateFile;
  ComboDriversCLick(Self);
 end;
end;

procedure TFRpDBXConfigVCL.BShowPropsClick(Sender: TObject);
var
 VendorLib,LibraryName:string;
begin
 if Not Assigned(ConAdmin) then
  exit;
 if ComboDrivers.ItemIndex=0 then
  Raise Exception.Create(SRpSelectDriver);
 ConAdmin.GetDriverLibNames(ComboDrivers.Text,LibraryName,VendorLib);
 RpShowMessage(SRpVendorLib+':'+VendorLib+#10+SRpLibraryName+':'+LibraryName);
end;

procedure TFRpDBXConfigVCL.BConnectClick(Sender: TObject);
{$IFDEF USESQLEXPRESS}
var
 conname:string;
 funcname,drivername,vendorlib,libraryname:string;
 alist:TStringList;
{$IFDEF USEZEOS}
 FZConnection:TZConnection;
 transiso:String;
{$ENDIF}
{$ENDIF}
begin
{$IFDEF USESQLEXPRESS}
 if Not Assigned(ConAdmin) then
  exit;
 if LConnections.ItemIndex<0 then
  Raise Exception.Create(SRpSelectConnectionFirst);
 conname:=LConnections.Items.strings[Lconnections.itemindex];
 // Assigns properties to SQLCOn.
 SQLConnection1.ConnectionName:=conname;
 alist:=TStringList.Create;
 try
  ConAdmin.GetConnectionParams(conname,alist);
  SQLConnection1.params.Assign(alist);
 finally
  alist.free;
 end;
 drivername:=SQLConnection1.params.Values['DriverName'];
{$IFDEF USEZEOS}
 if drivername='ZeosLib' then
 begin
  FZConnection:=TZConnection.Create(nil);
  try
   FZConnection.LoginPrompt:=False;
   FZConnection.HostName:=SQLConnection1.params.Values['HostName'];
   FZConnection.Protocol:=SQLConnection1.params.Values['Database Protocol'];
   FZConnection.Database:=SQLConnection1.params.Values['Database'];
   FZConnection.User:=SQLConnection1.params.Values['User_Name'];
   FZConnection.Password:=SQLConnection1.params.Values['Password'];
   if Length(Trim(SQLConnection1.params.Values['Port']))>0 then
    FZConnection.Port:=StrToInt(SQLConnection1.params.Values['Port']);
   transiso:=SQLConnection1.params.Values['Zeos TransIsolation'];
   if (transiso='ReadCommited') then
    FZConnection.TransactIsolationLevel:=ZDbcIntfs.tiReadCommitted
   else
   if (transiso='ReadUnCommited') then
    FZConnection.TransactIsolationLevel:=ZDbcIntfs.tiReadUnCommitted
   else
   if (transiso='RepeatableRead') then
    FZConnection.TransactIsolationLevel:=ZDbcIntfs.tiRepeatableRead
   else
   if (transiso='Serializable') then
    FZConnection.TransactIsolationLevel:=ZDbcIntfs.tiSerializable
   else
    FZConnection.TransactIsolationLevel:=ZDbcIntfs.tiNone;
   FZConnection.Connected:=True;
   RpShowMessage(SRpConnectionOk);
   FZConnection.Connected:=False;
  finally
   FZConnection.free;
  end;
 end
 else
{$ENDIF}
 begin
  funcname:=ConAdmin.Drivers.ReadString(drivername,'GetDriverFunc','');
  ConAdmin.GetDriverLibNames(drivername,LibraryName,VendorLib);
  SQLConnection1.DriverName:=drivername;
  SQLConnection1.VendorLib:=vendorlib;
  SQLConnection1.LibraryName:=libraryname;
  SQLConnection1.GetDriverFunc:=funcname;
  SQLConnection1.Connected:=true;
  RpShowMessage(SRpConnectionOk);
  SQLConnection1.Connected:=false;
 end;
{$ENDIF}
end;

procedure TFRpDBXConfigVCL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 try
  if Assigned(ConAdmin) then
   ConAdmin.Config.UpdateFile;
//  UpdateConAdmin;
 except
  on E:Exception do
  begin
   RpMessageBox(E.MEssage);
  end;
 end;
end;


procedure TFRpDBXConfigVCL.BCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TFRpDBXConfigVCL.UpdateIBX;
begin
 if OnlyIBX then
 begin
  ComboDrivers.ItemIndex:=ComboDrivers.Items.IndexOf('Interbase');
  if ComboDrivers.ItemIndex>=0 then
   ComboDrivers.Enabled:=False;
 end;
 if ComboDrivers.ItemIndex<0 then
  ComboDrivers.ItemIndex:=0;
 ComboDriversClick(Self);
end;

end.
