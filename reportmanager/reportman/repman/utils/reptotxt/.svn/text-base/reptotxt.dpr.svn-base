{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       reptotxt                                        }
{                                                       }
{       Converts a report definition to text            }
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

program reptotxt;

{$APPTYPE CONSOLE}

uses
  Classes,SysUtils,
{$IFDEF MSWINDOWS}
  rpwriter in '..\..\..\rpwriter.pas',
  rptypes in '..\..\..\rptypes.pas',
  rpmdconsts in '..\..\..\rpmdconsts.pas';
{$ENDIF}

{$IFDEF LINUX}
  rpwriter in '../../../rpwriter.pas',
  rptypes in '../../../rptypes.pas',
  rpmdconsts in '../../../rpmdconsts.pas';
{$ENDIF}

procedure PrintHelp;
begin
 Writeln(SRpRepToTxt1+' '+RM_VERSION);
 Writeln(SRpRepToTxt2);
 Writeln(SRpRepToTxt3);
 Writeln(SRpCommandLineStdIN);
end;

var
 sourcefile,destinationfile:String;

begin
  { TODO -oUser -cConsole Main : Insert code here }
 try
  if ParamCount<1 then
   PrintHelp
  else
  begin
   sourcefile:='';
   destinationfile:='';
   if ParamStr(1)='-stdin' then
   begin
    if ParamCount>1 then
     destinationfile:=ParamStr(2);
   end
   else
   begin
    sourcefile:=ParamStr(1);
    if ParamCount>1 then
    begin
     destinationfile:=ParamStr(2);
    end;
   end;
   FileReportToPlainText(sourcefile,destinationfile);
  end;
 except
  On E:Exception do
  begin
   WriteToStdError(E.Message+LINE_FEED);
   ExitCode:=1;
  end;
 end;
end.
