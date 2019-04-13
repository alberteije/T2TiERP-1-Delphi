{*******************************************************}
{                                                       }
{       Report Manager Service data module              }
{                                                       }
{       urepservice                                     }
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

unit urepservice;

interface

uses
  Windows, Messages, SysUtils, Classes, SvcMgr,
  urepserver,rpmdconsts;

type
  TReportManServer = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceCreate(Sender: TObject);
  private
    { Private declarations }
    amod:TModServer;
    procedure Onlog(Sender:TObject;aMessage:WideString);
    procedure OnError(Sender:TObject;aMessage:WideString);
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  ReportManServer: TReportManServer;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ReportManServer.Controller(CtrlCode);
end;

function TReportManServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TReportManServer.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
 try
  if Assigned(amod) then
  begin
   StopServer(amod);
   amod:=nil;
  end;
  amod:=StartServer(OnLog);
  Started:=True;
 except
  on E:Exception do
  begin
   OnError(Self,E.Message);
   raise;
  end;
 end;
end;

procedure TReportManServer.Onlog(Sender:TObject;aMessage:WideString);
begin
 LogMessage(aMessage,EVENTLOG_INFORMATION_TYPE,0);
end;

procedure TReportManServer.OnError(Sender:TObject;aMessage:WideString);
begin
 LogMessage(aMessage,EVENTLOG_ERROR_TYPE ,0);
end;

procedure TReportManServer.ServiceShutdown(Sender: TService);
begin
 if assigned(amod) then
 begin
  StopServer(amod);
  amod:=nil;
 end;
end;

procedure TReportManServer.ServicePause(Sender: TService;
  var Paused: Boolean);
begin
 if assigned(amod) then
 begin
  StopServer(amod);
  amod:=nil;
 end;
 Paused:=True;
end;


procedure TReportManServer.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
 if assigned(amod) then
 begin
  StopServer(amod);
  amod:=nil;
 end;
 Stopped:=True;
end;

procedure TReportManServer.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
 if Assigned(amod) then
 begin
  StopServer(amod);
  amod:=nil;
 end;
 amod:=StartServer(OnLog);
 Continued:=True;
end;

procedure TReportManServer.ServiceCreate(Sender: TObject);
begin
 if UpperCase(ParamStr(1))='/INSTALL' then
 begin
  if Length(ParamStr(2))>0 then
  begin
   ServiceStartName:='.\'+ParamStr(2);
  end;
  if Length(ParamStr(3))>0 then
   Password:=ParamStr(3);
 end;
end;

end.
