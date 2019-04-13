{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Metaprint                                       }
{                                                       }
{       Prints a metafile report                        }
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

program metaprint;

{$APPTYPE CONSOLE}
uses
  Classes,SysUtils,
{$IFDEF MSWINDOWS}
  QThemed in '..\..\QThemed.pas',
  QThemeSrv in '..\..\QThemeSrv.pas',
  TmSchema in '..\..\TmSchema.pas',
  rpqtdriver in '..\..\..\rpqtdriver.pas',
  rpmetafile in '..\..\..\rpmetafile.pas',
  rpfmainmetaview in '..\..\..\rpfmainmetaview.pas',
  rptypes in '..\..\..\rptypes.pas',
  rpmdconsts in '..\..\..\rpmdconsts.pas';
{$ENDIF}

{$IFDEF LINUX}
  Libc,
  LibcExec in '../../LibcExec.pas',
  rpqtdriver in '../../../rpqtdriver.pas',
  rpmetafile in '../../../rpmetafile.pas',
  rppdfdriver in '../../../rppdfdriver.pas',
  rptypes in '../../../rptypes.pas',
  rpfmainmetaview in '../../../rpfmainmetaview.pas',
  rpmdconsts in '../../../rpmdconsts.pas';
{$ENDIF}

var
 metafile:TRpMetafileReport;

procedure PrintHelp;
begin
 Writeln(SRpMetaPrint1+' '+RM_VERSION);
 Writeln(SRpMetaPrint2);
 Writeln(SRpMetaPrint3);
 Writeln(SRpMetaPrint4);
 Writeln(SRpMetaPrint5);
 Writeln(SRpMetaPrint6);
 Writeln(SRpMetaPrint7);
 Writeln(SRpMetaPrint8);
 Writeln(SRpMetaPrint9);
 Writeln(SRpPrintRep9);
 Writeln(SRpPrintRep10);
{$IFDEF LINUX}
 Writeln(SRpUseKPrinter);
{$ENDIF}
 Writeln(SRpCommandLineStdIN);
end;


var
 isstdin:Boolean;
 indexparam:integer;
 showprogress:boolean;
 dodeletefile:boolean;
 filename:string;
 allpages:boolean;
 frompage:integer;
 topage:integer;
 copies:integer;
 collate:boolean;
 printerindex:TRpPrinterSelect;
 preview,pdialog,doprint:boolean;
 memstream:TMemoryStream;
{$IFDEF LINUX}
 usekprinter:Boolean;
{$ENDIF} 
begin
{$IFDEF LINUX}
 usekprinter:=GetEnvironmentVariable('REPMANUSEKPRINTER')='true';
{$ENDIF}
 try
  { TODO -oUser -cConsole Main : Insert code here }
  isstdin:=false;
  printerindex:=pRpDefaultPrinter;
  if ParamCount<1 then
   PrintHelp
  else
  begin
   preview:=false;
   pdialog:=false;
   showprogress:=true;
   collate:=false;
   allpages:=true;
   frompage:=1;
   topage:=999999999;
   copies:=1;
   dodeletefile:=false;
   metafile:=TRpMetafileReport.Create(nil);
   try
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
     if ParamStr(indexparam)='-pdialog' then
      pdialog:=true
     else
      if ParamStr(indexparam)='-d' then
       dodeletefile:=true
      else
      if ParamStr(indexparam)='-stdin' then
       isstdin:=true
      else
{$IFDEF LINUX}
      if ParamStr(indexparam)='-kprinter' then
       usekprinter:=true
      else
{$ENDIF}
      if ParamStr(indexparam)='-from' then
      begin
       inc(indexparam);
       if indexparam>=Paramcount+1 then
        Raise Exception.Create(SRpNumberexpected);
       frompage:=StrToInt(ParamStr(indexparam));
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
       copies:=StrToInt(ParamStr(indexparam));
       if copies<=0 then
        copies:=1;
      end
      else
      // Printer selection
      if ParamStr(indexparam)='-p' then
      begin
       inc(indexparam);
       if indexparam>=Paramcount+1 then
        Raise Exception.Create(SRpNumberexpected);
       printerindex:=TRpPrinterSelect(StrToInt(ParamStr(indexparam)));
      end
      else
      if ParamStr(indexparam)='-collate' then
      begin
       collate:=true;
      end
      else
      begin
       filename:=ParamStr(indexparam);
       inc(indexparam);
       break;
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
     if isstdin then
     begin
      memstream:=ReadFromStdInputStream;
      try
       memstream.Seek(0,soFromBeginning);
       metafile.LoadFromStream(memstream);
      finally
       memstream.free;
      end;
      dodeletefile:=false;
     end
     else
     begin
      metafile.LoadFromFile(filename);
     end;
     try
      if ShowProgress then
      begin
       if not isstdin then
        WriteLn(SRpPrintingFile+':'+filename);
      end;
      if preview then
      begin
       rpfmainmetaview.PreviewMetafile(metafile,nil,true,true);
      end
      else
      begin
       doprint:=true;
       if pdialog then
{$IFDEF LINUX}
        if usekprinter then
        begin
         doprint:=False;
         // Use kprinter to print the file
         PrintMetafileUsingKPrinter(metafile);
        end
        else
{$ENDIF}
         doprint:=rpqtdriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
       if doprint then
       begin
        if PrintMetafile(metafile,filename,ShowProgress,allpages,
         frompage,topage,copies,collate,printerindex) then
        if ShowProgress then
        begin
         WriteLn(SRpPrinted);
        end;
       end;
      end;
     finally
      if dodeletefile then
       if DeleteFile(filename) then
        if ShowProgress then
        begin
          WriteLn(SRpPrintedFileDeleted);
        end;
     end;
    end;
   finally
     metafile.free;
   end;
  end;
 except
  On E:Exception do
  begin
   WriteToStdError(SRPError+':'+E.Message+LINE_FEED);
   ExitCode:=1;
  end;
 end;
end.
