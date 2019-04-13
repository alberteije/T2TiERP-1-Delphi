{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpmdfdinfovcl                                   }
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
unit rpmdfdinfovcl;

interface

{$I rpconf.inc}

uses
 windows,Classes,sysutils,Dialogs,Controls,Graphics,Forms,rpmdconsts,
{$IFDEF USEVARIANTS}
 types,
{$ENDIF}
 rptypes,rpdatainfo,rpreport,
 rpmdfdatasetsvcl,rpmdfconnectionvcl,
 StdCtrls, ExtCtrls, ComCtrls;

type
  TFRpDInfoVCL = class(TForm)
    PBottom: TPanel;
    BOk: TButton;
    BCancel: TButton;
    PControl: TPageControl;
    TabConnections: TTabSheet;
    TabDatasets: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure PControlChange(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
  private
    { Private declarations }
    freport:TRpReport;
    fdatasets:TFRpDatasetsVCL;
    fconnections:TFRpConnectionVCL;
    procedure SetReport(value:TRpReport);
  public
    { Public declarations }
    property report:TRpReport read FReport write SetReport;
  end;


procedure ShowDataConfig(report:TRpReport);


implementation

uses rpdbxconfigvcl;


{$R *.dfm}

procedure TFRpDInfoVCL.SetReport(value:TRpReport);
begin
 freport:=value;
 fconnections:=TFRpConnectionVCL.Create(Self);
 fconnections.Parent:=TabConnections;
 fdatasets:=TFRpDatasetsVCL.Create(Self);
 fdatasets.Parent:=TabDatasets;
 fdatasets.Datainfo:=report.DataInfo;
 fdatasets.Databaseinfo:=report.DatabaseInfo;
 fconnections.Databaseinfo:=report.DatabaseInfo;
 fconnections.Params:=report.Params;
 fdatasets.params:=report.params;
 if report.DatabaseInfo.Count>0 then
  PControl.ActivePage:=TabDatasets
 else
  PControl.ActivePage:=TabConnections;
end;

procedure ShowDataConfig(report:TRpReport);
var
 dia:TFRpDInfoVCL;
begin
// UpdateConAdmin;

 dia:=TFRpDInfoVCL.Create(Application);
 try
  dia.report:=report;
  dia.showmodal;
 finally
  dia.free;
 end;
end;



procedure TFRpDInfoVCL.FormCreate(Sender: TObject);
begin
 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
 Caption:=TranslateStr(1097,Caption);
 TabConnections.Caption:=TranslateStr(142,TabConnections.Caption);
 TabDatasets.Caption:=TranslateStr(148,TabDatasets.Caption);
end;






procedure TFRpDInfoVCL.PControlChange(Sender: TObject);
begin
 fdatasets.Databaseinfo:=fconnections.DatabaseInfo;
 fconnections.Params:=fdatasets.Params;
end;

procedure TFRpDInfoVCL.BOkClick(Sender: TObject);
begin
 fdatasets.Databaseinfo:=fconnections.Databaseinfo;
 freport.DatabaseInfo.Assign(fdatasets.Databaseinfo);
 freport.DataInfo.Assign(fdatasets.Datainfo);
 freport.Params.Assign(fdatasets.Params);
 Close;
end;

procedure TFRpDInfoVCL.BCancelClick(Sender: TObject);
begin
 Close;
end;

end.

