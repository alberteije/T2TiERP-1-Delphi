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

unit rppreviewcontrolclx;

interface

uses Classes,QGraphics,QControls,QForms,rppreviewmetaclx,rpbasereport,rpqtdriver;

type
 TRpPreviewControlCLX=class(TRpPreviewMetaCLX)
  private
   FReport:TRpBasereport;
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

constructor TRpPreviewControlCLX.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

end;

destructor TRpPreviewControlCLX.Destroy;
begin
 Metafile:=nil;
 if Assigned(FReport) then
  Report.EndPrint;
 inherited Destroy;
end;

procedure TRpPreviewControlCLX.SetReport(Avalue:TRpBaseReport);
begin
 if Assigned(FReport) then
  Report.EndPrint;
 FReport:=Avalue;
 if Assigned(FReport) then
 begin
  FReport.BeginPrint(prdriver);
  Metafile:=FReport.metafile;
 end;
end;

procedure TRpPreviewControlCLX.RefreshMetafile;
begin
 Report:=FReport;
 inherited RefreshMetafile;
end;

procedure TRpPreviewControlCLX.Notification(AComponent:TComponent;Operation:TOperation);
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
