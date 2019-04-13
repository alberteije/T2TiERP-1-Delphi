{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpnetreport                                     }
{       Report component for net applications           }
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

unit rpnetreport;

{$I rpconf.inc}

interface


uses Classes,Sysutils,rpreport,rpmdconsts,rpcompobase,
 rpalias,dialogs,rprfvparams,
 rpexceldriver,rptextdriver,rppdfdriver,
{$IFDEF USEINDY}
 rpfmainmetaviewvcl,
{$ENDIF}
 rpmetafile,rptypes;

type
 TNetReport=class(TCBaseReport)
  private
  protected
   procedure InternalExecuteRemote(metafile:TRpMetafileReport);override;
  public
   function Execute:boolean;override;
   procedure PrinterSetup;override;
   function ShowParams:boolean;override;
   procedure SaveToPDF(filename:string;compressed:boolean=false);
   procedure SaveToText(filename:string;textdriver:String='');override;
   procedure SaveToExcel(filename:string);
   function PrintRange(frompage:integer;topage:integer;
    copies:integer;collate:boolean):boolean;override;
  published
   property Filename;
   property Preview;
   property ShowProgress;
   property Title;
   property ShowPrintDialog;
   property AliasList;
   property Language;
  end;

implementation

procedure TNetReport.PrinterSetup;
var
 psetup:TPrinterSetUpDialog;
begin
 psetup:=TPRinterSetupDialog.Create(nil);
 try
  psetup.execute;
 finally
  psetup.free;
 end;
end;

function TNetReport.ShowParams:boolean;
begin
 CheckLoaded;
 Result:=ShowUserParams(report.params);
end;

function TNetReport.Execute:boolean;
var
 allpages,collate:boolean;
 frompage,topage,copies:integer;
begin
 inherited Execute;
 if Preview then
 begin
  Result:=ShowPreview(report,Title);
 end
 else
 begin
  allpages:=true;
  collate:=report.CollateCopies;
  frompage:=1; topage:=999999;
  copies:=report.Copies;
  if ShowPrintDialog then
  begin
   if DoShowPrintDialog(allpages,frompage,topage,copies,collate) then
   begin
    Result:=PrintReport(report,Title,Showprogress,allpages,frompage,
     topage,copies,collate);
   end
   else
    Result:=false;
  end
  else
  begin
    Result:=PrintReport(report,Title,Showprogress,true,1,
     9999999,report.copies,report.collatecopies);
  end;
 end;
end;

function TNetReport.PrintRange(frompage:integer;topage:integer;
    copies:integer;collate:boolean):boolean;
begin
 Result:=rpgdidriver.PrintReport(Report,Title,ShowProgress,false,
  frompage,topage,copies,collate);
end;


procedure TNetReport.SaveToPDF(filename:string;compressed:boolean=false);
begin
 CheckLoaded;
 rpgdidriver.ExportReportToPDF(report,filename,ShowProgress,True,1,999999,
  false,filename,compressed,false)
end;

procedure TNetReport.SaveToExcel(filename:string);
begin
 rpgdidriver.CalcReportWidthProgress(report);
 rpexceldriver.ExportMetafileToExcel(report.metafile,filename,showprogress,false,
 true,1,999);
end;

procedure TNetReport.InternalExecuteRemote(metafile:TRpMetafileReport);
{$IFDEF USEINDY}
var
 allpages,collate:boolean;
 frompage,topage,copies:integer;
 doprint:boolean;
{$ENDIF}
begin
 inherited InternalExecuteRemote(metafile);

{$IFDEF USEINDY}
 if Preview then
 begin
  rpfmainmetaviewvcl.PreviewMetafile(metafile,nil,true);
 end
 else
 begin
  allpages:=true;
  collate:=false;
  frompage:=1; topage:=999999;
  copies:=1;
  doprint:=true;
  if ShowPrintDialog then
  begin
   if Not DoShowPrintDialog(allpages,frompage,topage,copies,collate) then
    doprint:=false;
  end;
  if doprint then
  begin
   rpgdidriver.PrintMetafile(metafile,Title,ShowProgress,allpages,frompage,topage,copies,collate,GetDeviceFontsOption(metafile.PrinterSelect),metafile.PrinterSelect)
  end;
 end;
{$ENDIF}
end;

procedure TNetReport.SaveToText(filename:string;textdriver:String='');
begin
 rptextdriver.PrintReportToText(report,'',false,true,1,999,
   1,filename,true,true,textdriver);
end;


end.
