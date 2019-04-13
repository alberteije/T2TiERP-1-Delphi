{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       printrepxp                                      }
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

program printrepxp;

{$APPTYPE CONSOLE}

{$I rpconf.inc}

uses
  SysUtils,
  Classes,Windows,
  ActiveX,
{$IFDEF ISDELPHI7}
  XpMan,
{$ENDIF}
{$IFDEF USEVARIANTS}
  MidasLib,
{$ENDIF}
  Graphics,
{$IFDEF USEAPRO}
  rpfaxsend,
{$ENDIF}
  Printers,
  rpreport in '..\..\..\rpreport.pas',
  rppreviewcontrol in '..\..\..\rppreviewcontrol.pas',
  rpparams in '..\..\..\rpparams.pas',
  rpmdconsts in '..\..\..\rpmdconsts.pas',
  rptypes in '..\..\..\rptypes.pas',
  rpsubreport in '..\..\..\rpsubreport.pas',
  rpsection in '..\..\..\rpsection.pas',
  rpsecutil in '..\..\..\rpsecutil.pas',
  rpvpreview in '..\..\..\rpvpreview.pas',
  rpgdidriver in '..\..\..\rpgdidriver.pas',
  rpmetafile in '..\..\..\rpmetafile.pas',
  rprfvparams in '..\..\..\rprfvparams.pas' {FRpRTParams};

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
 preview:boolean;
 pdialog:boolean;
 compress,doprint:boolean;
 faxcovertext:String;

procedure PrintHelp;
begin
 Writeln(AnsiString(SRpPrintRep1+' XP '+RM_VERSION));
 Writeln(AnsiString(SRpPrintRep2));
 Writeln(AnsiString(SRpPrintRep3));
 Writeln(AnsiString(SRpPrintRep4));
 Writeln(AnsiString(SRpPrintRep5));
 Writeln(AnsiString(SRpPrintRep6));
 Writeln(AnsiString(SRpPrintRep7));
 Writeln(AnsiString(SRpPrintRep8));
 Writeln(AnsiString(SRpPrintRep9));
 Writeln(AnsiString(SRpPrintRep10));
 Writeln(AnsiString(SRpPrintRep12));
 Writeln(AnsiString(SRpPrintPDFRep8));
 Writeln(AnsiString(SRpPrintPDFRep9));
 Writeln(AnsiString(SRpPrintRep14));
 Writeln(AnsiString(SRpPrintRep18));
 Writeln(AnsiString(SRpPrintRep19));
 Writeln(AnsiString(SRpPrintRep20));
 Writeln(AnsiString(SRpPrintRep24));
 Writeln(AnsiString(SRpPrintRep21));
 Writeln(AnsiString(SRpPrintRep22));
 Writeln(AnsiString(SRpPrintRep23));
 Writeln(AnsiString(SRpPrintRep25));
 Writeln(SRpPrintRep29);
 Writeln(AnsiString(SRpParseParamsH));
 Writeln(AnsiString(SRpCommandLineStdIN));
end;

var
 isstdin:Boolean;
 memstream:TMemoryStream;
 topdf,tobmp,monobmp,tometafile,showparams:Boolean;
 bmpresx,bmpresy:integer;
 meta:TrpMetafileReport;
 abitmap:TBitmap;
 sendfax,faxdevice,faxcoverstring:string;
 outputfilename:String;
 aprintername:string;
 aindex:integer;
 amessage:String;
 async:boolean;
 prcontrol:TRpPreviewControl;
begin
 async:=false;
 faxdevice:='';
 faxcoverstring:='';
 bmpresx:=100;
 bmpresy:=100;
 sendfax:='';
 tobmp:=false;
 monobmp:=true;
 topdf:=false;
 tometafile:=false;
 outputfilename:='';
{$IFDEF USEADO}
  CoInitialize(nil);
{$ENDIF}
  isstdin:=false;
  showparams:=false;
  { TODO -oUser -cConsole Main : Insert code here }
  try
   preview:=false;
   compress:=true;
   pdialog:=false;
   showprogress:=true;
   collate:=false;
   allpages:=true;
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
    if ParamStr(indexparam)='-u' then
     compress:=false
    else
    if ParamStr(indexparam)='-async' then
     async:=true
    else
    if ParamStr(indexparam)='-pdialog' then
     pdialog:=true
    else
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
//    if ParamStr(indexparam)='-freeconsole' then
//    begin
//     FreeConsole;
 //   end
 //   else
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
      printer.printerindex:=aindex;
     end
     else
     if ParamStr(indexparam)='-bmpresx' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpNumberexpected);
      bmpresx:=StrToInt(ParamStr(indexparam));
      if bmpresx<=0 then
       bmpresx:=200;
     end
     else
     if ParamStr(indexparam)='-bmpresy' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpNumberexpected);
      bmpresy:=StrToInt(ParamStr(indexparam));
      if bmpresy<=0 then
       bmpresy:=200;
     end
     else
     if ParamStr(indexparam)='-sendfax' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpstringexpected);
      sendfax:=ParamStr(indexparam);
     end
     else
     if ParamStr(indexparam)='-faxcover' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpstringexpected);
      faxcovertext:=ParamStr(indexparam);
     end
     else
     if ParamStr(indexparam)='-faxdevice' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpstringexpected);
      faxdevice:=ParamStr(indexparam);
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
       if ((not topdf) and (not tometafile) and (not tobmp) and
        (sendfax='')) then
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
   memstream:=ExeResourceToStream(100);
   if ((Length(filename)<1) and (not isstdin) and (Not Assigned(memstream))) then
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
     if assigned(memstream) then
     begin
      try
       report.LoadFromStream(memstream);
      finally
       memstream.free;
      end;
      // Preview flag
      memstream:=ExeResourceToStream(101);
      if Assigned(memstream) then
      begin
       preview:=true;
       memstream.free;
      end;
      // Showparams flag
      memstream:=ExeResourceToStream(102);
      if Assigned(memstream) then
      begin
       showparams:=true;
       memstream.free;
      end;
     end
     else
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
     doprint:=true;
     if showparams then
      doprint:=ShowUserParams(report.params);
     if not preview then
      if pdialog then
       doprint:=rpgdidriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
     if doprint then
     begin
      if topdf or tometafile then
      begin
       memstream:=TMemoryStream.Create;
       try
        rpgdidriver.ExportReportToPDFMetaStream(report,filename,showprogress,
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
      if (tobmp or (Length(sendfax)>0)) then
      begin
       memstream:=TMemoryStream.Create;
       try
        rpgdidriver.ExportReportToPDFMetaStream(report,filename,showprogress,
         allpages,frompage,topage,copies,pdialog,memstream,compress,collate,true);
        memstream.Seek(0,soFromBeginning);
        meta:=TRpMetafileReport.Create(nil);
        try
         meta.LoadFromStream(memstream);
         if Length(sendfax)>0 then
         begin
{$IFDEF USEAPRO}
          SendFaxMetafile(sendfax,faxcovertext,faxdevice,meta,ShowProgress);
{$ELSE}
          raise Exception.Create('Send fax not supported, not compiled with APRO');
{$ENDIF}

         end
         else
         begin
          abitmap:=rpgdidriver.MetafileToBitmap(meta,showprogress,monobmp,bmpresx,bmpresy);
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
       prcontrol:=TRpPreviewControl.Create(nil);
       try
        prcontrol.Report:=report;
        ShowPreview(prcontrol,filename);
       finally
        prcontrol.free;
       end;
      end
      else
      begin
       if doprint then
        PrintReport(report,filename,showprogress,allpages,
         frompage,topage,copies,collate);
      end;
     end;
    finally
     report.free;
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
