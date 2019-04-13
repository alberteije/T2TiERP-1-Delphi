{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpclxreport                                     }
{       Report component for clx and vcl applications   }
{       supports drivers qt and gdi in Windows          }
{                                                       }
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

unit rpclxreport;

interface

{$I rpconf.inc}

uses Classes,Sysutils,rpreport,
 rpmdconsts,rpcompobase,rptypes,rpmetafile,rptextdriver,rppreviewcontrolclx,
 QPrinters,rpqtdriver,rppreview,rprfparams,rpgraphutils,
{$IFDEF VCLANDCLX}
 rpgdidriver,Printers,Dialogs,rprfvparams,rpvpreview,rpfmainmetaviewvcl,
 rppagesetupvcl,
{$ENDIF}
{$IFDEF LINUX}
 Libc,
{$ENDIF}
 rpalias,rpfmainmetaview,rppagesetup,rppdfdriver;

type
 // rpDriverGDI is ignored in Linux
 TRpPrintDriver=(rpDriverQt,rpDriverGDI);

 TCLXReport=class(TCBaseReport)
  private
   FUseSystemPrintDialog:boolean;
   FDriver:TRpPrintDriver;
{$IFDEF LINUX}
   usekprinter:Boolean;
{$ENDIF} 
  protected
   procedure InternalExecuteRemote(metafile:TRpMetafileReport);override;
  public
   function Execute:boolean;override;
   procedure PrinterSetup;override;
   function ShowParams:boolean;override;
   procedure SaveToPDF(filename:string;compressed:boolean=false);
   procedure SaveToMetafile(filename:string);
   procedure SaveToText(filename:string;textdriver:String='');override;
   constructor Create(AOwner:TComponent);override;
   function PrintRange(frompage:integer;topage:integer;
    copies:integer;collate:boolean):boolean;override;
   procedure PageSetup;
 published
   property Filename;
   property Preview;
   property ShowProgress;
   property Title;
   property ShowPrintDialog;
   property AliasList;
   property Language;
   property UseSystemPrintDialog:Boolean read
    FUseSystemPrintDialog write FUseSystemPrintDialog default true;
   property Driver:TRpPrintDriver read FDriver write FDriver
    default rpDriverGDI;
  end;

implementation

uses rpprintdia;


constructor TCLXReport.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FUseSystemPrintDialog:=true;
 FDriver:=rpDriverGDI;
{$IFDEF LINUX}
 usekprinter:=GetEnvironmentVariable('REPMANUSEKPRINTER')='true';
{$ENDIF}
end;

procedure TCLXReport.PrinterSetup;
{$IFDEF VCLANDCLX}
var
 dia:TPrinterSetupDialog;
{$ENDIF}
begin
{$IFDEF VCLANDCLX}
 if FDriver=rpDriverGDI then
 begin
  dia:=TPrinterSetupDialog.Create(nil);
  try
   dia.Execute;
  finally
   dia.free;
  end;
  exit;
 end;
{$ENDIF}
 QPrinters.Printer.ExecuteSetup;
end;


function TCLXReport.ShowParams:boolean;
begin
 CheckLoaded;
{$IFDEF VCLANDCLX}
 if FDriver=rpDriverGDI then
 begin
  Result:=rprfvparams.ShowUserParams(report.params);
  exit;
 end;
{$ENDIF}
 Result:=rprfparams.ShowUserParams(report.params);
end;


function TCLXReport.Execute:boolean;
var
 allpages,collate,modified:boolean;
 frompage,topage,copies:integer;
 dook:boolean;
{$IFDEF LINUX}
 metafile:TRpMEtafileReport;
 memstream:TMemoryStream;
{$ENDIF}
 prcontrol:TRpPreviewControlCLX;
begin
 inherited Execute;
 if Preview then
 begin
{$IFDEF VCLANDCLX}
  if FDriver=rpDriverGDI then
  begin
   Result:=rpvpreview.ShowPreview(report,Title,modified);
   exit;
  end;
{$ENDIF}
  prcontrol:=TRpPreviewControlCLX.Create(nil);
  try
   prcontrol.Report:=Report;
   Result:=ShowPreview(prcontrol,Title,FUseSystemPrintDialog);
  finally
   prcontrol.free;
  end;
 end
 else
 begin
  allpages:=true;
  collate:=report.CollateCopies;
  frompage:=1; topage:=999999;
  copies:=report.Copies;
{$IFDEF HORZPAPERBUG}
  if report.PageOrientation=rpOrientationPortrait then
  begin
   printer.Orientation:=poPortrait;
  end
  else
   if report.PageOrientation=rpOrientationLandscape then
   begin
    printer.Orientation:=poLandscape;
   end;
{$ENDIF}


  if ShowPrintDialog then
  begin
{$IFDEF VCLANDCLX}
   if FDriver=rpDriverGDI then
   begin
    if rpgdidriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate) then
    begin
     Result:=rpgdidriver.PrintReport(report,Title,Showprogress,allpages,frompage,
      topage,copies,collate);
    end
    else
     Result:=false;
    exit;
   end;
{$ENDIF}
{$IFDEF LINUX}
   if usekprinter then
   begin
    metafile:=TRpMetafileReport.Create(nil);
    try
     memstream:=tmemoryStream.Create;
     try
      rppdfdriver.PrintReportMetafileStream(report,'',false,true,1,9999,1,memstream,false,false);
      memstream.Seek(0,soFromBeginning);
      metafile.LoadFromStream(memstream);
     finally
      memstream.free;
     end;
     // Use kprinter to print the file
     PrintMetafileUsingKPrinter(metafile);
    finally
     metafile.free;
    end;
   end
   else
{$ENDIF}
   begin   
    if FUseSystemPrintDialog then
     dook:=rpqtdriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate)
    else
     dook:=rpprintdia.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
    if dook then
    begin
     Result:=rpqtdriver.PrintReport(report,Title,Showprogress,allpages,frompage,
      topage,copies,collate);
    end
    else
     Result:=false;
   end;
  end
  else
  begin
{$IFDEF VCLANDCLX}
   if FDriver=rpDriverGDI then
   begin
    Result:=rpgdidriver.PrintReport(report,Title,Showprogress,true,1,
     9999999,report.copies,report.collatecopies);
    exit;
   end;
{$ENDIF}
   Result:=rpqtdriver.PrintReport(report,Title,Showprogress,true,1,
     9999999,report.copies,report.collatecopies);
  end;
 end;
end;

procedure TCLXReport.SaveToPDF(filename:string;compressed:boolean=false);
begin
 CheckLoaded;
{$IFDEF VCLANDCLX}
 if FDriver=rpDriverGDI then
 begin
  rpgdidriver.ExportReportToPDF(report,filename,ShowProgress,true,1,999999,1,
   false,filename,compressed,false);
  exit;
 end;
{$ENDIF}
 rpqtdriver.ExportReportToPDF(report,filename,ShowProgress,true,1,999999,1,
  false,filename,compressed,false)
end;

procedure TCLXReport.SaveToMetafile(filename:string);
begin
 CheckLoaded;
{$IFDEF VCLANDCLX}
 if FDriver=rpDriverGDI then
 begin
  rpgdidriver.ExportReportToPDF(report,filename,ShowProgress,true,1,999999,1,
   false,filename,false,true);
  exit;
 end;
{$ENDIF}
 rpqtdriver.ExportReportToPDF(report,filename,ShowProgress,true,1,999999,1,
  false,filename,false,true)
end;




function TCLXReport.PrintRange(frompage:integer;topage:integer;
    copies:integer;collate:boolean):boolean;
begin
{$IFDEF VCLANDCLX}
 if FDriver=rpDriverGDI then
 begin
  Result:=rpgdidriver.PrintReport(Report,Title,ShowProgress,false,
   frompage,topage,copies,collate);
  exit;
 end;
{$ENDIF}
 Result:=rpqtdriver.PrintReport(Report,Title,ShowProgress,false,
  frompage,topage,copies,collate);
end;


procedure TCLXReport.InternalExecuteRemote(metafile:TRpMetafileReport);
var
 allpages,collate,dook:boolean;
 frompage,topage,copies:integer;
begin
 inherited InternalExecuteRemote(metafile);

 if Preview then
 begin
{$IFDEF VCLANDCLX}
  if FDriver=rpDriverGDI then
  begin
   rpfmainmetaviewvcl.PreviewMetafile(metafile,nil,true,true);
   exit;
  end;
{$ENDIF}
  rpfmainmetaview.PreviewMetafile(metafile,nil,true,true);
  exit;
 end;

 allpages:=true;
 collate:=false;
 frompage:=1; topage:=999999;
 copies:=1;
{$IFDEF HORZPAPERBUG}
 if metafile.Orientation=rpOrientationPortrait then
 begin
  printer.Orientation:=poPortrait;
 end
 else
 if metafile.Orientation=rpOrientationLandscape then
 begin
  printer.Orientation:=poLandscape;
 end;
{$ENDIF}


 if ShowPrintDialog then
 begin
{$IFDEF VCLANDCLX}
  if FDriver=rpDriverGDI then
  begin
   if rpgdidriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate) then
   begin
    rpgdidriver.PrintMetafile(metafile,Title,ShowProgress,allpages,frompage,topage,copies,collate,GetDeviceFontsOption(metafile.PrinterSelect),metafile.PrinterSelect)
   end;
   exit;
  end;
{$ENDIF}
  if FUseSystemPrintDialog then
   dook:=rpqtdriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate)
  else
   dook:=rpprintdia.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
  if dook then
  begin
   rpqtdriver.PrintMetafile(metafile,Title,ShowProgress,allpages,frompage,topage,copies,collate,metafile.PrinterSelect)
  end;
  exit;
 end
 else
 begin
{$IFDEF VCLANDCLX}
  if FDriver=rpDriverGDI then
  begin
   rpgdidriver.PrintMetafile(metafile,Title,ShowProgress,allpages,frompage,topage,copies,collate,GetDeviceFontsOption(metafile.PrinterSelect),metafile.PrinterSelect);
   exit;
  end;
{$ENDIF}
  rpqtdriver.PrintReport(report,Title,Showprogress,true,1,
     9999999,report.copies,report.collatecopies);
 end;
end;

procedure TCLXReport.SaveToText(filename:string;textdriver:String='');
begin
 rptextdriver.PrintReportToText(report,'',false,true,1,999,
   1,filename,true,true,textdriver);
end;

procedure TCLXReport.PageSetup;
begin
{$IFDEF VCLANDCLX}
  if FDriver=rpDriverGDI then
  begin
   rppagesetupvcl.ExecutePageSetup(Report);
   exit;
  end;
{$ENDIF}
 rppagesetup.ExecutePageSetup(Report);
end;

end.
