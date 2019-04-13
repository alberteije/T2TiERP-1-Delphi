{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       fmainfvcl                                       }
{                                                       }
{       Report Manager Net Server main form             }
{       To Run Report Server as a standalone app        }
{       It's better to run as a service                 }
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

unit fmainfvcl;

interface

{$I rpconf.inc}

uses
  SysUtils,
{$IFDEF USEVARIANTS}
  Types,Variants,
{$ENDIF}
  Classes, Graphics, Controls, Forms,rpeditconnvcl,Windows,Messages,
  Dialogs, StdCtrls, rptranslator,urepserver,rpmdconsts,  rpalias,ExtCtrls;

type
  TFSerMainVCL = class(TForm)
    LMEssages: TMemo;
    Panel1: TPanel;
    BStartServer: TButton;
    BStopServer: TButton;
    LLog: TLabel;
    LHost: TLabel;
    LHostName: TLabel;
    ELogFIle: TEdit;
    EConfigFile: TEdit;
    LConfigFile: TLabel;
    LPort: TLabel;
    LPortNumber: TLabel;
    LVersion: TLabel;
    BConfigLibs: TButton;
    procedure BStartServerClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BStopServerClick(Sender: TObject);
    procedure BConfigLibsClick(Sender: TObject);
  private
    { Private declarations }
    mserver:TModServer;
    procedure OnLog(Sender:TObject;aMessage:WideString);
    procedure InsertMessage(aMessage:WideString);
    procedure AppException(Sender: TObject; E: Exception);
  public
    { Public declarations }
  end;

var
  FSerMainVCL: TFSerMainVCL;

implementation

{$R *.dfm}

procedure TFSerMainVCL.BStartServerClick(Sender: TObject);
begin
 if assigned(mserver) then
 begin
  StopServer(mserver);
  LHostName.Caption:='';
  mserver:=nil;
  LPortNumber.Caption:='';
 end;
 mserver:=StartServer(onlog);
 LHostName.Caption:=mserver.HostName;
 ELogFile.Text:=mserver.LogFileName;
 EConfigFile.Text:=mserver.FileNameConfig;
 LPortNumber.Caption:=IntToStr(mserver.RepServer.DefaultPort);
 BStartServer.Enabled:=False;
 BStopServer.Enabled:=True;
end;

procedure TFSerMainVCL.AppException(Sender: TObject; E: Exception);
begin
 InsertMessage(FormatDateTime('dd/mm/yyyy hh:nn:ss - ',Now)+E.ClassName+':'+E.Message);
end;

procedure TFSerMainVCL.FormDestroy(Sender: TObject);
begin
 if assigned(mserver) then
 begin
  StopServer(mserver);
  LHostName.Caption:='';
  mserver:=nil;
  BStopServer.Enabled:=False;
  BStartServer.Enabled:=True;
  LPortNumber.Caption:='';
 end;
 Application.OnException:=nil;
end;

procedure TFSerMainVCL.FormCreate(Sender: TObject);
begin
 Application.OnException:=AppException;
 Caption:=TranslateStr(769,Caption);
 Application.Title:=Caption;
 BStartServer.Caption:=TranslateStr(770,BStartServer.Caption);
 LHost.Caption:=TranslateStr(747,LHost.Caption);
 LLog.Caption:=TranslateStr(786,LLog.Caption);
 LConfigFile.Caption:=TranslateStr(743,LConfigFile.Caption);
 BStopServer.Caption:=TranslateStr(785,BStopServer.Caption);
 LPort.Caption:=TranslateStr(829,LPort.Caption);
 BConfigLibs.Caption:=SRpConfigLib;
 LPortNumber.Font.Style:=[fsbold];
 LHostName.Font.Style:=[fsbold];
 LVersion.Caption:=TranslateStr(91,'Version')+' '+RM_VERSION;
 LVersion.Font.Style:=[fsBold];
 BStartServerClick(Self);
end;


procedure TFSerMainVCL.InsertMessage(aMessage:WideString);
begin
 LMessages.Lines.Insert(0,aMessage);
 if LMessages.Lines.Count>1000 then
  LMEssages.Lines.Delete(LMessages.Lines.Count-1);
end;


procedure TFSerMainVCL.OnLog(Sender:TObject;aMessage:WideString);
begin
 InsertMessage(aMessage);
end;



procedure TFSerMainVCL.BStopServerClick(Sender: TObject);
begin
 if assigned(mserver) then
 begin
  StopServer(mserver);
  LHostName.Caption:='';
  mserver:=nil;
  BStopServer.Enabled:=False;
  BStartServer.Enabled:=True;
  LPortNumber.Caption:='';
 end;
end;


procedure TFSerMainVCL.BConfigLibsClick(Sender: TObject);
var
 librarycompo:TRpAlias;
begin
 librarycompo:=TRpAlias.Create(Self);
 try
  librarycompo.Connections.LoadFromFile(mserver.filenameconfig);
  ShowModifyConnections(librarycompo.Connections);
 finally
  // Write library configuration
  librarycompo.Connections.SaveToFile(mserver.filenameconfig);
 end;
end;



end.
