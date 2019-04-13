{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       fmainf                                          }
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

unit fmainf;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, rptranslator,urepserver,rpmdconsts,  QExtCtrls,
  rpeditconn,rpalias;

type
  TFSerMain = class(TForm)
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
  FSerMain: TFSerMain;

implementation

{$R *.xfm}

procedure TFSerMain.BStartServerClick(Sender: TObject);
begin
 if assigned(mserver) then
 begin
  StopServer(mserver);
  LHostName.Caption:='';
  LPortNumber.Caption:='';
  mserver:=nil;
 end;
 mserver:=StartServer(onlog);
 BStartServer.Enabled:=False;
 BStopServer.Enabled:=True;
 LHostName.Caption:=mserver.HostName;
 ELogFile.Text:=mserver.LogFileName;
 EConfigFile.Text:=mserver.FileNameConfig;
 LPortNumber.Caption:=IntToStr(mserver.RepServer.DefaultPort);
end;

procedure TFSerMain.AppException(Sender: TObject; E: Exception);
begin
 InsertMessage(FormatDateTime('dd/mm/yyyy hh:nn:ss - ',Now)+E.ClassName+':'+E.Message);
end;

procedure TFSerMain.FormDestroy(Sender: TObject);
begin
 if assigned(mserver) then
 begin
  StopServer(mserver);
  mserver:=nil;
  LHostName.Caption:='';
 end;
 Application.OnException:=nil;
end;

procedure TFSerMain.FormCreate(Sender: TObject);
begin
 Application.OnException:=AppException;
 Caption:=TranslateStr(769,Caption);
 Application.Title:=Caption;
 BStartServer.Caption:=TranslateStr(770,BStartServer.Caption);
 LHost.Caption:=TranslateStr(747,LHost.Caption);
 LLog.Caption:=TranslateStr(786,LLog.Caption);
 LConfigFile.Caption:=TranslateStr(743,LConfigFile.Caption);
 BConfigLibs.Caption:=SRpConfigLib;
 BStopServer.Caption:=TranslateStr(785,BStopServer.Caption);
 LPort.Caption:=TranslateStr(829,LPort.Caption);
 LPortNumber.Font.Style:=[fsbold];
 LHostName.Font.Style:=[fsbold];
 LVersion.Caption:=TranslateStr(91,'Version')+' '+RM_VERSION;
 LVersion.Font.Style:=[fsBold];
 BStartServerClick(Self);

 SetInitialBounds;
end;


procedure TFSerMain.InsertMessage(aMessage:WideString);
begin
 LMessages.Lines.Insert(0,aMessage);
 if LMessages.Lines.Count>1000 then
  LMEssages.Lines.Delete(LMessages.Lines.Count-1);
end;


procedure TFSerMain.OnLog(Sender:TObject;aMessage:WideString);
begin
 InsertMessage(aMessage);
end;



procedure TFSerMain.BStopServerClick(Sender: TObject);
begin
 if assigned(mserver) then
 begin
  StopServer(mserver);
  LHostName.Caption:='';
  LPortNumber.Caption:='';
  mserver:=nil;
  BStopServer.Enabled:=False;
  BStartServer.Enabled:=True;
 end;
end;


procedure TFSerMain.BConfigLibsClick(Sender: TObject);
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
