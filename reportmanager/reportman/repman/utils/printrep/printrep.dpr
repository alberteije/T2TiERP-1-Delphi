{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       printrep                                        }
{                                                       }
{       Process and Prints a report                     }
{       you can select the pages to print               }
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

program printrep;

{$I rpconf.inc}

{$APPTYPE CONSOLE}

uses
  SysUtils,Classes,QGraphics,QPrinters,
{$IFDEF MSWINDOWS}
  midaslib,ActiveX,
  QThemed in '..\..\QThemed.pas',
  QThemeSrv in '..\..\QThemeSrv.pas',
  TmSchema in '..\..\TmSchema.pas',
  rpreport in '..\..\..\rpreport.pas',
  rpparams in '..\..\..\rpparams.pas',
  rpmdconsts in '..\..\..\rpmdconsts.pas',
  rptypes in '..\..\..\rptypes.pas',
  rpsubreport in '..\..\..\rpsubreport.pas',
  rpsection in '..\..\..\rpsection.pas',
  rppreview in '..\..\..\rppreview.pas',
  rpsecutil in '..\..\..\rpsecutil.pas',
  rprfparams in '..\..\..\rprfparams.pas',
  rpmetafile in '..\..\..\rpmetafile.pas',
  rppreviewcontrolclx in '..\..\..\rppreviewcontrolclx.pas',
  rpqtdriver in '..\..\..\rpqtdriver.pas';
{$ENDIF}

{$IFDEF LINUX}
  Libc,
  LibcExec in '../../LibcExec.pas',
  rpreport in '../../../rpreport.pas',
  rpparams in '../../../rpparams.pas',
  rpmdconsts in '../../../rpmdconsts.pas',
  rptypes in '../../../rptypes.pas',
  rpsubreport in '../../../rpsubreport.pas',
  rpsection in '../../../rpsection.pas',
  rppreview in '../../../rppreview.pas',
  rpsecutil in '../../../rpsecutil.pas',
  rprfparams in '../../../rprfparams.pas',
  rpmetafile in '../../../rpmetafile.pas',
  rppreviewcontrolclx in '../../../rppreviewcontrolclx.pas',
  rppdfdriver in '../../../rppdfdriver.pas',
  rpqtdriver in '../../../rpqtdriver.pas';
{$ENDIF}

var
 report:TRpReport;
 indexparam:integer;
 showprogress:boolean;
 filename:string;
 allpages:boolean;
 frompage:integer;
 topage:integer;
 copies,acopies:integer;
 collate:boolean;
 preview,modified:boolean;
 pdialog:boolean;
 compress,doprint:boolean;

procedure PrintHelp;
begin
 Writeln(SRpPrintRep1+' '+RM_VERSION);
 Writeln(SRpPrintRep2);
 Writeln(SRpPrintRep3);
 Writeln(SRpPrintRep4);
 Writeln(SRpPrintRep5);
 Writeln(SRpPrintRep6);
 Writeln(SRpPrintRep7);
 Writeln(SRpPrintRep8);
 Writeln(SRpPrintRep9);
 Writeln(SRpPrintRep10);
 Writeln(SRpPrintRep12);
 Writeln(SRpPrintPDFRep8);
 Writeln(SRpPrintPDFRep9);
 Writeln(SRpPrintRep14);
 Writeln(SRpPrintRep18);
 Writeln(SRpPrintRep19);
 Writeln(SRpPrintRep20);
 Writeln(SRpPrintRep24);
 Writeln(SRpPrintRep25);
 Writeln(SRpPrintRep29);
{$IFDEF LINUX}
 Writeln(SRpUseKPrinter);
{$ENDIF}
 Writeln(SRpParseParamsH);
 Writeln(SRpCommandLineStdIN);
end;

var
 metafile:TRpMetafileReport;
 isstdin:Boolean;
 memstream:TMemoryStream;
 async:boolean;
 bmpresx,bmpresy:integer;
 meta:TrpMetafileReport;
 abitmap:TBitmap;
 topdf,tobmp,monobmp,tometafile,showparams:Boolean;
 outputfilename:String;
 aprintername:string;
 aindex:integer;
 amessage:String;
 prcontrol:TRpPreviewControlCLX;
{$IFDEF LINUX}
 usekprinter:Boolean;
{$ENDIF}
begin
{$IFDEF LINUX}
 usekprinter:=GetEnvironmentVariable('REPMANUSEKPRINTER')='true';
{$ENDIF}
 async:=false;
 bmpresx:=100;
 bmpresy:=100;
 tobmp:=false;
 monobmp:=true;
 topdf:=false;
 tometafile:=false;
 outputfilename:='';
{$IFDEF USEADO}
  CoInitialize(nil);
{$ENDIF}
  isstdin:=false;
  showparams:=False;
  { TODO -oUser -cConsole Main : Insert code here }
  try
   if ParamCount<1 then
    PrintHelp
   else
   begin
   compress:=true;
   showprogress:=true;
   collate:=false;
   allpages:=true;
   preview:=false;
   pdialog:=false;
   frompage:=1;
   acopies:=0;
   topage:=999999999;
   indexparam:=1;
   filename:='';
   // Get the options
   while indexparam<ParamCount+1 do
   begin
    if ParamStr(indexparam)='-q' then
     showprogress:=false
    else
    if ParamStr(indexparam)='-preview' then
     preview:=true
    else
    if ParamStr(indexparam)='-showparams' then
     showparams:=true
    else
    if ParamStr(indexparam)='-pdialog' then
     pdialog:=true
    else
    if ParamStr(indexparam)='-u' then
     compress:=false
    else
    if ParamStr(indexparam)='-async' then
     async:=true
    else
{$IFDEF LINUX}
    if ParamStr(indexparam)='-kprinter' then
     usekprinter:=true
    else
{$ENDIF}
    if ParamStr(indexparam)='-stdin' then
     isstdin:=true
    else
    if ParamStr(indexparam)='-from' then
    begin
     inc(indexparam);
     if indexparam>=Paramcount+1 then
      Raise Exception.Create(SRpNumberexpected);
     frompage:=StrToInt(ParamStr(indexparam));
     allpages:=false;
    end
    else
    if ParamStr(indexparam)='-pdf' then
    begin
     topdf:=true;
    end
    else
    if ParamStr(indexparam)='-bmp' then
    begin
     tobmp:=true;
    end
    else
    if ParamStr(indexparam)='-bmpcolor' then
    begin
     monobmp:=false;
    end
    else
    if ParamStr(indexparam)='-m' then
    begin
     tometafile:=true;
    end
    else
     if ParamStr(indexparam)='-to' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpNumberexpected);
      topage:=StrToInt(ParamStr(indexparam));
      allpages:=false;
     end
     else
     if ParamStr(indexparam)='-copies' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpNumberexpected);
      acopies:=StrToInt(ParamStr(indexparam));
      if acopies<=0 then
       acopies:=1;
     end
     else
     if ParamStr(indexparam)='-printer' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpIdentifierexpected);
      aprintername:=ParamStr(indexparam);
      aindex:=printer.printers.IndexOf(aprintername);
      if aindex<0 then
      begin
       amessage:=SRpErrorOpenImp+':'+aprintername+#10;
       for aindex:=0 to printer.Printers.Count-1 do
       begin
        amessage:=amessage+printer.printers.Strings[aindex]+#10;
       end;
       Raise Exception.Create(amessage);
      end;
      printer.SetPrinter(aprintername);
     end
     else
     if ParamStr(indexparam)='-bmpresx' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpNumberexpected);
      bmpresx:=StrToInt(ParamStr(indexparam));
      if bmpresx<=0 then
       bmpresx:=100;
     end
     else
     if ParamStr(indexparam)='-bmpresy' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpNumberexpected);
      bmpresy:=StrToInt(ParamStr(indexparam));
      if bmpresy<=0 then
       bmpresy:=100;
     end
     else
     if ParamStr(indexparam)='-collate' then
     begin
      collate:=true;
     end
     else
     if Pos('-param',ParamStr(indexparam))<>1 then
     begin
      if (isstdin or (Length(filename)>0)) then
      begin
       outputfilename:=ParamStr(indexparam);
       inc(indexparam);
       break;
      end
      else
      begin
       filename:=ParamStr(indexparam);
       if ((not topdf) and (not tometafile) and (not tobmp)) then
       begin
        inc(indexparam);
        break;
       end;
      end;
     end;
    inc(indexparam);
   end;
   if indexparam<ParamCount+1 then
   begin
    PrintHelp;
    Raise Exception.Create(SRpTooManyParams)
   end;
   if ((Length(filename)<1) and (not isstdin)) then
   begin
    PrintHelp;
   end
   else
   begin
    report:=TRpReport.Create(nil);
    try
     if not preview then
      async:=false;
     report.AsyncExecution:=async;
     report.ProgressToStdOut:=true;
     if isstdin then
     begin
      memstream:=ReadFromStdInputStream;
      try
       memstream.Seek(0,soFromBeginning);
       report.LoadFromStream(memstream);
      finally
       memstream.free;
      end;
     end
     else
      report.LoadFromFile(filename);
     if acopies=0 then
      copies:=report.Copies
     else
      copies:=acopies;
     ParseCommandLineParams(report.Params);
     doprint:=True;
     if showparams then
      doprint:=rprfparams.SHowUserParams(report.Params);
     if not preview then
      if pdialog then
{$IFDEF LINUX}
       if usekprinter then
       begin
        doprint:=False;
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
        doprint:=rpqtdriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
     if doprint then
     begin
      if topdf or tometafile then
      begin
       memstream:=TMemoryStream.Create;
       try
        rpqtdriver.ExportReportToPDFMetaStream(report,filename,showprogress,
         allpages,frompage,topage,copies,pdialog,memstream,compress,collate,tometafile);
        memstream.Seek(0,soFromBeginning);
        if Length(outputfilename)>0 then
         memstream.SaveToFile(outputfilename)
        else
         WriteStreamToStdOutput(memstream);
       finally
        memstream.Free;
       end;
      end
      else
      if (tobmp) then
      begin
       memstream:=TMemoryStream.Create;
       try
        rpqtdriver.ExportReportToPDFMetaStream(report,filename,showprogress,
         allpages,frompage,topage,copies,pdialog,memstream,compress,collate,true);
        memstream.Seek(0,soFromBeginning);
        meta:=TRpMetafileReport.Create(nil);
        try
         meta.LoadFromStream(memstream);
         abitmap:=rpqtdriver.MetafileToBitmap(meta,showprogress,monobmp,bmpresx,bmpresy);
         try
          memstream.SetSize(0);
          abitmap.SaveToStream(memstream);
          memstream.Seek(0,soFromBeginning);
          if Length(outputfilename)>0 then
           memstream.SaveToFile(outputfilename)
          else
           WriteStreamToStdOutput(memstream);
         finally
          abitmap.free;
         end;
        finally
         meta.free;
        end;
       finally
        memstream.Free;
       end;
      end
      else
      if preview then
      begin
       prcontrol:=TRpPreviewControlCLX.Create(nil);
       try
        prcontrol.Report:=report;
        ShowPreview(prcontrol,filename,true);
       finally
        prcontrol.free;
       end;
      end
      else
      begin
       if pdialog then
        doprint:=rpqtdriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
       if doprint then
        PrintReport(report,filename,showprogress,allpages,
         frompage,topage,copies,collate,aprintername);
      end;
     end;
    finally
     report.free;
    end;
   end;
  end;
 except
  On E:Exception do
  begin
   WriteToStdError(E.Message+LINE_FEED);
   ExitCode:=1;
  end;
 end;
end.
