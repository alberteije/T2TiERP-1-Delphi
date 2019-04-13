{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       printreptopdf                                   }
{                                                       }
{       Preoces and exports to pdf a report             }
{       you can select the pages to print               }
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

program printreptopdf;

{$APPTYPE CONSOLE}

{$I rpconf.inc}

uses
  SysUtils,Classes,
{$IFDEF MSWINDOWS}
  ActiveX,mmsystem,Windows,
{$IFDEF USEVARIANTS}
  midaslib,types,
{$ENDIF}
  rpreport in '..\..\..\rpreport.pas',
  rpparams in '..\..\..\rpparams.pas',
  rpmdconsts in '..\..\..\rpmdconsts.pas',
  rptypes in '..\..\..\rptypes.pas',
  rptextdriver in '..\..\..\rptextdriver.pas',
  rpsubreport in '..\..\..\rpsubreport.pas',
  rpsection in '..\..\..\rpsection.pas',
  rpsecutil in '..\..\..\rpsecutil.pas',
  rphtmldriver in '..\..\..\rphtmldriver.pas',
  rpexceldriver in '..\..\..\rpexceldriver.pas',
  rpsvgdriver in '..\..\..\rpsvgdriver.pas',
  rpgdidriver in '..\..\..\rpgdidriver.pas',
  rpcsvdriver in '..\..\..\rpcsvdriver.pas',
  rppdffile in '..\..\..\rppdffile.pas',
  rppdfdriver in '..\..\..\rppdfdriver.pas';
{$ENDIF}

{$IFDEF LINUX}
  DateUtils,
  rpreport in '../../../rpreport.pas',
  rpparams in '../../../rpparams.pas',
  rpmdconsts in '../../../rpmdconsts.pas',
  rptypes in '../../../rptypes.pas',
  rptextdriver in '../../../rptextdriver.pas',
  rpsubreport in '../../../rpsubreport.pas',
  rpsection in '../../../rpsection.pas',
  rpsecutil in '../../../rpsecutil.pas',
  rphtmldriver in '../../../rphtmldriver.pas',
  rppdffile in '../../../rppdffile.pas',
  rpsvgdriver in '../../../rpsvgdriver.pas',
  rpcsvdriver in '../../../rpcsvdriver.pas',
  rppdfdriver in '../../../rppdfdriver.pas';
{$ENDIF}

var
 separator:string;
 report:TRpReport;
 indexparam:integer;
 showprogress:boolean;
 onesheet:Boolean;
 filename:string;
 pdffilename:string;
 allpages:boolean;
 frompage:integer;
 topage:integer;
 copies,acopies:integer;
 compress:boolean;
 collate:boolean;
 doprintmetafile:boolean;
 stdinput:boolean;
 doprintastext:Boolean;
 errorfile:string;
{$IFDEF MSWINDOWS}
 toexcel:Boolean;
{$ENDIF}
 textdriver:String;
 memstream:TMemoryStream;
 oemconvert:Boolean;
 htmloutput:Boolean;
 tocsv,tosvg,toctxt:Boolean;
 filestream:TFileStream;
 dotime:boolean;
 singlefile:boolean;
 seconds,minutes,hours:integer;
 difmilis:int64;
{$IFDEF MSWINDOWS}
   mmfirst,mmlast:DWORD;
{$ENDIF}
{$IFDEF LINUX}
   milifirst,mililast:TDatetime;
{$ENDIF}

procedure PrintHelp;
var
 astring:String;
 alist:TStringList;
 i:integer;
begin
 Writeln(AnsiString(SRpPrintPDFRep1+' '+RM_VERSION));
 Writeln(AnsiString(SRpPrintPDFRep2));
 Writeln(AnsiString(SRpPrintPDFRep3));
 Writeln(AnsiString(SRpPrintPDFRep4));
 Writeln(AnsiString(SRpPrintPDFRep5));
 Writeln(AnsiString(SRpPrintPDFRep6));
 Writeln(AnsiString(SRpPrintPDFRep7));
 Writeln(AnsiString(SRpPrintPDFRep8));
 Writeln(AnsiString(SRpPrintPDFRep9));
 Writeln(AnsiString(SRpPrintRep8));
{$IFDEF MSWINDOWS}
 Writeln(AnsiString(SRpPrintRep11));
 Writeln(AnsiString(SRpPrintRep26));
{$ENDIF}
 Writeln(AnsiString(SRpPrintRep15));
 Writeln(AnsiString(SRpPrintRep16));
 Writeln(AnsiString(SRpPrintRep17));
 Writeln(AnsiString(SRpPrintRep28));
 Writeln(AnsiString(SRpParseParamsH));
 Writeln(AnsiString(SRpCommandLineStdIN));
 Writeln(AnsiString(SRpPrintPDFRep10));
 Writeln(AnsiString(SRpPrintPDFRep11));
 Writeln(AnsiString(SRpPrintPDFRep12));
 Writeln(AnsiString(SRpPrintPDFRep13));
 astring:=SRpTextDrivers+' ';
 alist:=TStringList.Create;
 try
  rptypes.GetTextOnlyPrintDrivers(alist);
  alist.Add(alist.Strings[0]);
  for i:=1 to alist.count-1 do
  begin
   alist.Add(' / '+alist.Strings[0]);
  end;
 finally
  alist.free;
 end;
end;

begin
{$IFDEF USEADO}
  CoInitialize(nil);
{$ENDIF}
{$IFDEF MSWINDOWS}
  toexcel:=false;
{$ENDIF}
{$IFDEF MSWINDOWS}
  mmfirst:=TimeGetTime;
{$ENDIF}
{$IFDEF LINUX}
  milifirst:=0;
{$ENDIF}
  separator:=',';
  errorfile:='';
  dotime:=false;
  tocsv:=false;
  toctxt:=false;
  tosvg:=false;
  onesheet:=false;
  htmloutput:=false;
  singlefile:=false;
  stdinput:=false;
  doprintmetafile:=false;
  doprintastext:=False;
  textdriver:='';
  oemconvert:=false;
  { TODO -oUser -cConsole Main : Insert code here }
  try
   if ParamCount<1 then
    PrintHelp
   else
   begin
   showprogress:=true;
   compress:=true;
   allpages:=true;
   frompage:=1;
   acopies:=0;
   topage:=999999999;
   collate:=false;
   indexparam:=1;
   filename:='';
   pdffilename:='';
   // Get the options
   while indexparam<ParamCount+1 do
   begin
{$IFDEF MSWINDOWS}
    if ParamStr(indexparam)='-excel' then
     toexcel:=true
    else
    if ParamStr(indexparam)='-onesheet' then
     onesheet:=true
    else
{$ENDIF}
    if ParamStr(indexparam)='-svg' then
     tosvg:=true
    else
    if ParamStr(indexparam)='-csv' then
     tocsv:=true
    else
    if ParamStr(indexparam)='-ctxt' then
     tocsv:=true
    else
    if ParamStr(indexparam)='-q' then
     showprogress:=false
    else
    if ParamStr(indexparam)='-time' then
     dotime:=true
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
    if ParamStr(indexparam)='-errorfile' then
    begin
     inc(indexparam);
     if indexparam>=Paramcount+1 then
      Raise Exception.Create(SRpNumberexpected);
     errorfile:=ParamStr(indexparam);
     allpages:=false;
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
     if ParamStr(indexparam)='-u' then
     begin
      compress:=false;
     end
     else
     if ParamStr(indexparam)='-m' then
     begin
      doprintmetafile:=true;
     end
     else
     if ParamStr(indexparam)='-pdf' then
     begin
      // Compatibility with printrep command line tool
     end
     else
     if ParamStr(indexparam)='-html' then
     begin
      htmloutput:=true;
     end
     else
     if ParamStr(indexparam)='-htmlsingle' then
     begin
      htmloutput:=true;
      singlefile:=true;
     end
     else
     if ParamStr(indexparam)='-text' then
     begin
      doprintastext:=true;
     end
     else
     if ParamStr(indexparam)='-oemconvert' then
     begin
      oemconvert:=true;
     end
     else
     if ParamStr(indexparam)='-textdriver' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpNumberexpected);
      textdriver:=ParamStr(indexparam);
      doprintastext:=true;
     end
     else
     if ParamStr(indexparam)='-csvseparator' then
     begin
      inc(indexparam);
      if indexparam>=Paramcount+1 then
       Raise Exception.Create(SRpstringexpected);
      separator:=ParamStr(indexparam);
     end
     else
     if ParamStr(indexparam)='-collate' then
     begin
      collate:=true;
     end
     else
     if ParamStr(indexparam)='-stdin' then
     begin
      stdinput:=true;
      filename:='stdinput';
     end
     else
     begin
      if Pos('-param',ParamStr(indexparam))<>1 then
      begin
       if length(filename)>0 then
       begin
        pdffilename:=ParamStr(indexparam);
        inc(indexparam);
        break;
       end
       else
       begin
        filename:=ParamStr(indexparam);
       end;
      end;
     end;
    inc(indexparam);
   end;
   if indexparam<ParamCount+1 then
   begin
    Raise Exception.Create(SRpTooManyParams)
   end;
   if ((Length(filename)<1) and (Length(pdffilename)<1) and (not stdinput)) then
   begin
    PrintHelp;
   end
   else
   begin
    if dotime then
    begin
{$IFDEF MSWINDOWS}
     mmfirst:=TimeGetTime;
{$ENDIF}
{$IFDEF LINUX}
     milifirst:=now;
{$ENDIF}
    end;
    report:=TRpReport.Create(nil);
    try
     if stdinput then
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
{$IFDEF MSWINDOWS}
     if toexcel then
     begin
      PrintReportToMetafile(report,'',showprogress,allpages,frompage,topage,
       copies,'',collate);
      ExportMetafileToExcel(report.metafile,pdffilename,showprogress,
       Length(pdffilename)<1,allpages,frompage,topage,onesheet);
     end
     else
{$ENDIF}
     if tosvg then
     begin
      PrintReportToMetafile(report,'',showprogress,allpages,frompage,topage,
       copies,'',collate);
      ExportMetafileToSVG(report.metafile,'SVG',pdffilename,showprogress,allpages,
       frompage,topage);
     end
     else
     if tocsv then
     begin
      PrintReportToMetafile(report,'',showprogress,allpages,frompage,topage,
       copies,'',collate);
      ExportMetafileToCSV(report.Metafile,pdffilename,showprogress,
       allpages,frompage,topage,separator);
     end
     else
     if toctxt then
     begin
      PrintReportToMetafile(report,'',showprogress,allpages,frompage,topage,
       copies,'',collate);
      ExportMetafileToTextPro(report.Metafile,pdffilename,showprogress,
       allpages,frompage,topage);
     end
     else
     if htmloutput then
     begin
      if Length(PDFFilename)<1 then
       Raise Exception.Create(SRpOutputFilenameHTML);
      PrintReportToMetafile(report,'',showprogress,allpages,frompage,topage,
       copies,'',collate);
      if (singlefile) then
       ExportMetafileToHtmlSingle(report.Metafile,'',pdffilename)
      else
      ExportMetafileToHtml(report.metafile,pdffilename,pdffilename,showprogress,
       true,1,99999);
     end
     else
     begin
      if Length(PDFFilename)<1 then
       showprogress:=false;
      memstream:=TMemoryStream.Create;
      try
       if doprintmetafile then
       begin
{$IFDEF MSWINDOWS}
        rpgdidriver.ExportReportToPDFMetaStream(report,filename,showprogress,
              allpages,frompage,topage,copies,false,memstream,compress,collate,true);
{$ENDIF}
{$IFDEF LINUX}
        PrintReportMetafileStream(report,'',showprogress,allpages,frompage,topage,
         copies,memstream,compress,collate);
{$ENDIF}
       end
       else
       if doprintastext then
       begin
        PrintReportToStream(report,filename,showprogress,allpages,
        frompage,topage,copies,memstream,collate,oemconvert,textdriver);
       end
       else
       begin
{$IFDEF MSWINDOWS}
         rpgdidriver.ExportReportToPDFMetaStream(report,filename,showprogress,
               allpages,frompage,topage,copies,false,memstream,compress,collate,false);
{$ENDIF}
{$IFDEF LINUX}
        PrintReportPDFStream(report,filename,showprogress,
          allpages,frompage,topage,copies,
           memstream,compress,collate);
{$ENDIF}
       end;
       memstream.Seek(0,soFromBeginning);
       if Length(PDFFilename)<1 then
        WriteStreamToStdOutput(memstream)
       else
        memstream.SaveToFile(PDFFilename);
      finally
       memstream.free;
      end;
     end;
    finally
     report.free;
    end;
   end;
  end;
  if dotime then
  begin
{$IFDEF MSWINDOWS}
   mmlast:=TimeGetTime;
   difmilis:=(mmlast-mmfirst);
{$ENDIF}
{$IFDEF LINUX}
   mililast:=now;
   difmilis:=MillisecondsBetween(mililast,milifirst);
{$ENDIF}
   seconds:=difmilis div 1000;
   minutes:=seconds div 60;
   hours:=minutes div 60;
   seconds:=seconds-minutes*60;
   minutes:=minutes-hours*60;
   WriteLn('Time: '+FormatFloat('00',hours)+timeseparator+
    FormatFloat('00',minutes)+timeseparator+
    FormatFloat('00',seconds)+' '+IntToStr(difmilis mod 1000)+' ms');
  end;
 except
  On E:Exception do
  begin
   if (errorfile<>'') then
   begin
    filestream:=TFileStream.Create(errorfile,fmCreate);
    try
     WriteStringToStream(E.Message,filestream);
    finally
     filestream.free;
    end;
   end
   else
   begin
    WriteToStdError(E.Message+LINE_FEED);
   end;
   ExitCode:=1;
  end;
 end;
end.
