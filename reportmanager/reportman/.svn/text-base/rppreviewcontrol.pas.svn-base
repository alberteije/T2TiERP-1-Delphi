{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rppreviewcontrol                                }
{       VCL Preview control                             }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2005 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rppreviewcontrol;

interface

uses Classes,SysUtils,Graphics,Controls,Forms,rppreviewmeta,rpbasereport,rpgdidriver,
 rpmetafile,dialogs,rpgraphutilsvcl;

type
 TRpPreviewControl=class(TRpPreviewMeta)
  private
   FReport:TRpBasereport;
   ndriver:TRpPrintDriver;
   procedure SetReport(Avalue:TRpBaseReport);
  protected
   procedure Notification(AComponent:TComponent;Operation:TOperation);override;
  public
   procedure RefreshMetafile;override;
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
   property Report:TRpBaseReport read FReport write SetReport;
  end;

implementation

constructor TRpPreviewControl.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

end;

destructor TRpPreviewControl.Destroy;
begin
 Metafile:=nil;
 if Assigned(FReport) then
  Report.EndPrint;
 ndriver:=nil;
 inherited Destroy;
end;

procedure TRpPreviewControl.SetReport(Avalue:TRpBaseReport);
var
  errormessage:string;
begin
 if ndriver<>TRpPrintDriver(prdriver_internal) then
  ndriver:=prdriver_internal;
 errormessage:='';
 try
  if Assigned(FReport) then
   Report.EndPrint;
 except
  on E:Exception do
  begin
   errormessage:=E.Message;
  end;
 end;
 if Length(errormessage)>0 then
  RpShowMessage(errormessage);
 FReport:=Avalue;
 if Assigned(FReport) then
 begin
  FReport.BeginPrint(ndriver);
  Metafile:=FReport.metafile;
 end;
end;

procedure TRpPreviewControl.RefreshMetafile;
begin
 Report:=FReport;
 inherited RefreshMetafile;
end;

procedure TRpPreviewControl.Notification(AComponent:TComponent;Operation:TOperation);
begin
 inherited Notification(AComponent,Operation);
 if assigned(Report) then
 begin
  if Operation=OpRemove then
  begin
   if (AComponent=Report) then
   begin
    Report:=nil;
   end;
  end;
 end;
end;

end.
