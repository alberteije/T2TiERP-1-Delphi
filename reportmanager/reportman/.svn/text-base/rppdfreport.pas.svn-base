{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rppdfreport                                     }
{       Report component for pdf export only            }
{       It does not need VCL or VisualCLX so            }
{       you do not need a X Server                      }
{       and you can use it in console apps              }
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

unit rppdfreport;

interface

uses Classes,Sysutils,rpreport,rpmdconsts,rpcompobase,
 rppdfdriver,rpalias,rpmetafile,rptextdriver,rpinfoprovid;

type
 TPDFReport=class(TCBaseReport)
  private
   fpdffilename:string;
   FCompressed:Boolean;
   FFromPage,FToPAge:integer;
   FCopies:integer;
   FAsMetafile:Boolean;
  protected
   procedure InternalExecuteRemote(metafile:TRpMetafileReport);override;
  public
   function Execute:boolean;override;
   procedure PrinterSetup;override;
   function ShowParams:boolean;override;
   function PrintRange(frompage:integer;topage:integer;
     copies:integer;collate:boolean):boolean;override;
   constructor Create(AOwner:TComponent);override;
   procedure SaveToText(filename:string;textdriver:String='');override;
   procedure SaveToMetafile(filename:string);
  published
   property ShowProgress;
   property Filename;
   property Title;
   property ShowPrintDialog;
   property AliasList;
   property Language;
   property AsMetafile:Boolean read FAsMetafile write FAsMetafile default false;
   property PDFFilename:string read FPDFFilename write FPDFFilename;
   property Compressed:Boolean read FCompressed write FCompressed default True;
   property FromPage:integer read FFromPage write FFromPage default 1;
   property ToPage:integer read FToPage write FToPage default MAX_PAGECOUNT;
   property Copies:integer read FCopies write FCopies default 1;
  end;

implementation

constructor TPDFReport.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 Preview:=false;
 ShowPrintDialog:=false;
 FCompressed:=true;
 FFromPage:=1;
 FToPage:=MAX_PAGECOUNT;
 FCopies:=1;
end;

procedure TPDFReport.PrinterSetup;
begin
 // No implemented may be implement asking the printer
 // first page and last page
 Raise Exception.Create(SRpSNotYetImplemented+':TPDFReport.PrinterSetup');
end;

function TPDFReport.ShowParams:boolean;
begin
 CheckLoaded;
 // No implemented may be implement asking the parameters
 // in consolemode with Readln
 Raise Exception.Create(SRpSNotYetImplemented+':TPDFReport.ShowParams');
end;

function TPDFReport.Execute:boolean;
begin
 inherited Execute;
 if FFromPage<1 then
  FFromPage:=1;
 if FToPage<FFromPage then
  FToPage:=FFromPage;
 if FCopies<1 then
  FCopies:=1;
 if Preview then
 begin
  // No implemented may be implement asking the parameters
  // in consolemode with Readln ignore
  Raise Exception.Create(SRpSNotYetImplemented+':TPDFReport.Preview');
 end;
 begin
  if ShowPrintDialog then
  begin
   // No implemented may be implement asking the parameters
   // in consolemode with Readln
   Raise Exception.Create(SRpSNotYetImplemented+':TPDFReport.ShowPrintDialog');
  end
  else
  begin
   if FAsMetafile then
   begin
    Result:=PrintReportToMetafile(report,Title,ShowProgress,false,ffrompage,ftopage,fcopies,filename,false);
   end
   else
   begin
    Result:=PrintReportPDF(report,Title,Showprogress,false,ffrompage,
     ftopage,fcopies,FPDFFilename,FCompressed,false);
   end;
  end;
 end;
end;


function TPDFReport.PrintRange(frompage:integer;topage:integer;
    copies:integer;collate:boolean):boolean;
begin
 Result:=rppdfdriver.PrintReportPDF(Report,Title,ShowProgress,false,
  frompage,topage,copies,fpdffilename,compressed,collate);
end;

procedure TPDFReport.InternalExecuteRemote(metafile:TRpMetafileReport);
begin
 inherited InternalExecuteRemote(metafile);
 if FAsMetafile then
 begin
  metafile.SaveToFile(FPDFFilename);
 end
 else
 begin
  SaveMetafileRangeToPDF(metafile,false,ffrompage,
    ftopage,fcopies,FPDFFilename,FCompressed);
 end;
end;

procedure TPDFReport.SaveToText(filename:string;textdriver:String='');
begin
 rptextdriver.PrintReportToText(report,'',false,true,1,999,
   1,filename,true,true,textdriver);
end;

procedure TPDFReport.SaveToMetafile(filename:string);
begin
 rppdfdriver.PrintReportToMetafile(Report,Title,ShowProgress,true,
  1,MAX_PAGECOUNT,1,filename,false);
end;


end.
