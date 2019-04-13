{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       uinstall                                        }
{       Installation of Report Manager Service          }
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

unit uinstall;

interface

{$I rpconf.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,rpmdconsts,rptypes,WinSvc, ExtCtrls,WInSock;

type
  TFStartService = class(TForm)
    LUser: TLabel;
    EUserName: TEdit;
    EPassword: TEdit;
    LPassword: TLabel;
    EConfirm: TEdit;
    LConfirm: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    BInstall: TButton;
    BUnInstall: TButton;
    GroupBox1: TGroupBox;
    BStart: TButton;
    BStop: TButton;
    LStatus: TLabel;
    BRefresh: TButton;
    Label3: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure BInstallClick(Sender: TObject);
    procedure BUnInstallClick(Sender: TObject);
    procedure BRefreshClick(Sender: TObject);
    procedure BStartClick(Sender: TObject);
    procedure BStopClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    startedsocks:boolean;
    procedure RefreshServiceStatus;
    procedure RefreshServiceTimer;
    procedure AppIdle(Sender:TObject;var done:boolean);
  public
    { Public declarations }
  end;

var
  FStartService: TFStartService;

implementation

{$R *.dfm}

procedure TFStartService.AppIdle(Sender:TObject;var done:boolean);
begin
 Application.OnIdle:=nil;
 done:=true;
 if Not IsWindowsNT then
 begin
  ShowMessage(SRpWindowsNTRequired);
  Close;
 end
 else
  RefreshServiceStatus;
end;


procedure TFStartService.FormCreate(Sender: TObject);
var
 aint:Word;
 awsadata:WSAData;
begin
 Caption:=TranslateStr(816,Caption);
 Application.Title:=Caption;
 LUser.Caption:=TranslateStr(810,LUser.Caption);
 LPassword.Caption:=TranslateStr(811,LPassword.Caption);
 LConfirm.Caption:=TranslateStr(812,LConfirm.Caption);
 BInstall.Caption:=TranslateStr(817,BInstall.Caption);
 BUnInstall.Caption:=TranslateStr(818,BUnInstall.Caption);
 Label2.Caption:=TranslateStr(818,Label2.Caption);
 Label2.Caption:=TranslateStr(820,Label2.Caption);
 GroupBox1.Caption:=TranslateStr(821,GroupBox1.Caption);
 LStatus.Font.Style:=[fsBold];
 BStart.Caption:=TranslateStr(825,BStart.Caption);
 BStop.Caption:=TranslateStr(826,BStop.Caption);
 BRefresh.Caption:=TranslateStr(827,BRefresh.Caption);
 Label3.Caption:=TranslateStr(828,Label3.Caption);

 Application.OnIdle:=AppIdle;
 aint:=1 or (1 shl 8);
 if 0<>WSAStartup(aint,awsadata) then
  RaiseLastOSError;
 startedsocks:=true;
end;

procedure TFStartService.BInstallClick(Sender: TObject);
var
 exename:string;
begin
 if EPassword.Text<>EConfirm.Text then
 begin
  EPassword.SetFocus;
  Raise Exception.Create(SRpPasswordConfirmationIncorrect);
 end;
 // If a password is uder then
 if ((Length(EPassword.Text)>0) AND (Length(Trim(EUserName.Text))<1)) then
 begin
  EUserName.SetFocus;
  Raise Exception.Create(SRpAUserNameMustbeAssigned);
 end;
 // Executes repserverservice with parameters
 exename:=ExtractFilePath(Application.ExeName)+'repserverservice.exe';
 exename:='"'+exename+'"'+' /INSTALL ';
 if Length(Trim(EUserName.Text))>0 then
  exename:=exename+Trim(EUserName.Text)+' '+EPassword.Text;
 if (WinExec(PAnsichar(exename),SW_SHOWNORMAL)<=31) then
  Raise Exception.Create(SRpCanNotExecute+' '+exename);
 RefreshServiceTimer;
end;

procedure TFStartService.BUnInstallClick(Sender: TObject);
var
 exename:string;
begin
 // Executes repserverservice with parameters
 exename:=ExtractFilePath(Application.ExeName)+'repserverservice.exe';
 exename:='"'+exename+'"'+' /UNINSTALL ';
 if (WinExec(PAnsichar(exename),SW_SHOWNORMAL)<=31) then
  Raise Exception.Create(SRpCanNotExecute+' '+exename);
 RefreshServiceTimer;
end;

procedure TFStartService.BRefreshClick(Sender: TObject);
begin
 RefreshServiceStatus;
end;

procedure TFStartService.RefreshServiceStatus;
var
 schandle:SC_HANDLE;
 hservice:SC_HANDLE;
 sstatus:SERVICE_STATUS;
 pbuf:PAnsiChar;
 buffer:array[0..255] of char;
 nhostname:string;
begin
 pbuf:=@buffer[0];
 if 0<>gethostname(pbuf,255) then
  RaiseLastOSError;
 nhostname:=StrPas(pbuf);
 BStart.Enabled:=false;
 BStop.Enabled:=false;
 // Open the service control manager and
 // try to open the service
{$IFNDEF DELPHI2009UP}
 schandle:=OpenSCManager(pbuf,nil,GENERIC_READ);
{$ENDIF}
{$IFDEF DELPHI2009UP}
 schandle:=OpenSCManager(PWideChar(nhostname),nil,GENERIC_READ);
{$ENDIF}
 if schandle=0 then
  RaiseLastOsError;
 try
  hservice:=OpenService(schandle,'ReportManServer',SERVICE_QUERY_STATUS);
  if hservice=0 then
  begin
   if GetLastError=ERROR_SERVICE_DOES_NOT_EXIST then
    LStatus.Caption:=SRpServiceUnInstalled
   else
    RaiseLastOSError;
  end;
  if hservice<>0 then
  begin
   try
    if Not QueryServiceStatus(hservice,sstatus) then
     RaiseLastOSError;
    case sstatus.dwCurrentState of
     SERVICE_STOPPED,SERVICE_START_PENDING,SERVICE_PAUSED,
     SERVICE_CONTINUE_PENDING:
      begin
       LStatus.Caption:=SRpServiceStopped;
       BStart.Enabled:=true;
      end;
     SERVICE_STOP_PENDING,SERVICE_RUNNING,SERVICE_PAUSE_PENDING:
      begin
       LStatus.Caption:=SRpServiceStarted;
       BStop.Enabled:=true;
      end;
    end;
   finally
    CloseServiceHandle(hservice);
   end;
  end;
 finally
  CloseServiceHandle(schandle);
 end;
end;

procedure TFStartService.BStartClick(Sender: TObject);
var
 schandle:SC_HANDLE;
 hservice:SC_HANDLE;
 args:PChar;
 buffer:array[0..255] of char;
 pbuf:PAnsiChar;
 nhostname:string;
begin
 pbuf:=@buffer[0];
 if 0<>gethostname(pbuf,255) then
  RaiseLastOSError;
 nhostname:=StrPas(pbuf);
 BStart.Enabled:=false;
 BStop.Enabled:=false;
 // Open the service control manager and
 // try to open the service
{$IFNDEF DELPHI2009UP}
 schandle:=OpenSCManager(pbuf,nil,GENERIC_READ);
{$ENDIF}
{$IFDEF DELPHI2009UP}
 schandle:=OpenSCManager(PWideChar(nhostname),nil,GENERIC_READ);
{$ENDIF}
 if schandle=0 then
  RaiseLastOsError;
 try
  hservice:=OpenService(schandle,'ReportManServer',SERVICE_START);
  if hservice=0 then
  begin
   if GetLastError=ERROR_SERVICE_DOES_NOT_EXIST then
    Raise Exception.Create(SRpServiceUnInstalled)
   else
    RaiseLastOSError;
  end;
  if hservice<>0 then
  begin
   try
    args:=nil;
    if Not StartService(hService,0,args) then
     RaiseLastOSError;
    RefreshServiceTimer;
   finally
    CloseServiceHandle(hservice);
   end;
  end;
 finally
  CloseServiceHandle(schandle);
 end;
end;

procedure TFStartService.BStopClick(Sender: TObject);
var
 schandle:SC_HANDLE;
 hservice:SC_HANDLE;
 sstatus:SERVICE_STATUS;
 buffer:array[0..255] of char;
 pbuf:PAnsiChar;
 nhostname:string;
begin
 pbuf:=@buffer[0];
 if 0<>gethostname(pbuf,255) then
  RaiseLastOSError;
 nhostname:=StrPas(pbuf);
 BStart.Enabled:=false;
 BStop.Enabled:=false;
 // Open the service control manager and
 // try to open the service
{$IFNDEF DELPHI2009UP}
 schandle:=OpenSCManager(pbuf,nil,GENERIC_READ);
{$ENDIF}
{$IFDEF DELPHI2009UP}
 schandle:=OpenSCManager(PWideChar(nhostname),nil,GENERIC_READ);
{$ENDIF}
 if schandle=0 then
  RaiseLastOsError;
 try
  hservice:=OpenService(schandle,'ReportManServer',SERVICE_STOP);
  if hservice=0 then
  begin
   if GetLastError=ERROR_SERVICE_DOES_NOT_EXIST then
    Raise Exception.Create(SRpServiceUnInstalled)
   else
    RaiseLastOSError;
  end;
  if hservice<>0 then
  begin
   try
    if Not ControlService(hservice,SERVICE_CONTROL_STOP,sstatus) then
     RaiseLastOSError;
    RefreshServiceTimer;
   finally
    CloseServiceHandle(hservice);
   end;
  end;
 finally
  CloseServiceHandle(schandle);
 end;
end;

procedure TFStartService.Timer1Timer(Sender: TObject);
begin
 Timer1.Enabled:=false;
 RefreshServiceStatus;
 if Timer1.Interval=2000 then
 begin
  Timer1.Interval:=5000;
  Timer1.Enabled:=true;
 end;
end;

procedure TFStartService.RefreshServiceTimer;
begin
 Timer1.Interval:=2000;
 Timer1.Enabled:=true;
end;

procedure TFStartService.FormDestroy(Sender: TObject);
begin
 if startedsocks then
  WSACleanUp;
end;

end.
