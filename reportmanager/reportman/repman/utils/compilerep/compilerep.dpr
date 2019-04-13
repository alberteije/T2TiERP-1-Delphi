program compilerep;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows,
  rpcompilerep in '..\..\..\rpcompilerep.pas';

const
 LINE_FEED=#13+#10;
 
procedure WriteHelp;
begin
 WriteLn('compilerep Compiles a report into a .exe file');
 WriteLn('Syntax: compilerep filename.rep [-preview] [-showparams] [-compress] [-metafile]');
end;




procedure WriteToStdError(astring:String);
var
// writed:DWORD;
 handle:THANDLE;
 writed:DWORD;
 apchar:PChar;
 lasterror:Integer;
begin
 // In windows obtain sdtin
 handle:=Windows.GetStdHandle(STD_ERROR_HANDLE);
 if handle=INVALID_HANDLE_VALUE then
  RaiseLastOsError;
 apchar:=PChar(astring);
 if not WriteFile(handle,apchar,Length(astring),writed,nil) then
 begin
  lasterror:=GetLastError;
  if ((lasterror<>ERROR_BROKEN_PIPE) AND (lasterror<>ERROR_HANDLE_EOF)) then
   RaiseLastOSError;
 end;
// Estandard output interrupted is not a critical error
//  if LongInt(writed)<>MemStream.Size then
//   RaiseLastOSError;
end;

var
 destinationexe:String;
 correctparam:Boolean;
 docompress:Boolean;
 metaprint:Boolean;
 i:integer;
 dopreview,doshowparams:Boolean;
 filename:String;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  docompress:=false;
  metaprint:=false;
  dopreview:=false;
  doshowparams:=false;
  try
   if ParamCount<1 then
   begin
    WriteHelp;
    Raise Exception.Create('Incorrect Syntax');
   end;
   filename:=ParamStr(1);
   i:=2;
   correctparam:=True;
   while i<=paramcount do
   begin
    correctparam:=false;
    if UpperCase(ParamStr(i))='-COMPRESS' then
    begin
     docompress:=true;
     correctparam:=true;
    end
    else
    if UpperCase(ParamStr(i))='-METAFILE' then
    begin
     metaprint:=true;
     correctparam:=true;
    end
    else
    if UpperCase(ParamStr(i))='-PREVIEW' then
    begin
     dopreview:=true;
     correctparam:=true;
    end
    else
    if UpperCase(ParamStr(i))='-SHOWPARAMS' then
    begin
     doshowparams:=true;
     correctparam:=true;
    end;
    if not correctparam then
     break;
    inc(i);
   end;
   if not correctparam then
   begin
    WriteHelp;
   end
   else
   begin
    destinationexe:=ChangeFileExt(ParamStr(1),'.exe');
    ReportFileToExe(filename,destinationexe,doshowparams,
     dopreview,metaprint,docompress);
   end;
  except
   on E:Exception do
   begin
    WriteToStdError(E.Message+LINE_FEED);
    ExitCode:=1;
   end;
  end;
end.
