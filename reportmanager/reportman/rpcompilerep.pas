{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpcompilerep                                    }
{       Generates a executable self containing a report }
{                                                       }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

unit rpcompilerep;

interface


{$I rpconf.inc}

uses SysUtils,
  Windows;

procedure ReportFileToExe(filename,destinationexe:String;
 showparams,preview,metafile,compress:Boolean);


implementation

{$IFNDEF USEVARIANTS}
procedure RaiseLastOSError;
begin
 RaiseLastWin32Error;
end;
{$ENDIF}

procedure ReportFileToExe(filename,destinationexe:String;
 showparams,preview,metafile,compress:Boolean);
var
 amem:PChar;
 han:THandle;
 afile:integer;
 readed:integer;
 isok:Boolean;
 haninfo:BY_HANDLE_FILE_INFORMATION;
 filesize:INteger;
 path:String;
begin
 // Find the path to the executable module
 amem:=AllocMem(MAX_PATH+1);
 try
  if GetModuleFileName(HInstance,amem,MAX_PATH)=0 then
   RaiseLastOsError;
  path:=StrPas(amem);
 finally
   FreeMem(amem);
 end;
 path:=ExtractFilePath(path);
 // Duplicates printrepxp.exe or metaprintxp
 if metafile then
  isok:=CopyFile(PChar(path+'\'+'metaprintxp.exe'),PChar(destinationexe),false)
 else
  isok:=CopyFile(PChar(path+'\'+'printrepxp.exe'),PChar(destinationexe),false);
 if not isok then
  RaiseLastOsError;
 afile:=FileOpen(filename,fmOpenRead or fmShareDenyNone);
 if afile=-1 then
  RaiseLastOsError;
 try
  if Not GetFileInformationByHandle(afile,haninfo) then
   RaiseLastOsError;
  filesize:=haninfo.nFileSizeLow;
  amem:=AllocMem(filesize);
  try
   readed:=FileRead(afile,amem^,filesize);
   if readed<>filesize then
    RaiseLastOsError;
   han:=BeginUpdateResource(PChar(destinationexe),false);
   if han=0 then
    RaiseLastOsError;
   try
    if Not UpdateResource(han,RT_RCDATA,PCHAR(100),0,amem,readed) then
     RaiseLastOSError;
    if preview then
     if Not UpdateResource(han,RT_RCDATA,PCHAR(101),0,amem,2) then
      RaiseLastOSError;
    if showparams then
     if Not UpdateResource(han,RT_RCDATA,PCHAR(102),0,amem,2) then
      RaiseLastOSError;
   finally
    EndUpdateResource(han,False);
   end;
  finally
   FreeMem(amem);
  end;
 finally
  FileClose(afile);
 end;
 // CHeck for UPX
 if compress then
 begin
  if FileExists(path+'\upx.exe') then
  begin
   WinExec(PAnsiChar('"'+path+'\'+'upx" '+'"'+destinationexe+'"'),SW_HIDE);
  end
  else
   WinExec(PAnsiChar('"upx" '+'"'+destinationexe+'"'),SW_HIDE);
 end;
end;

end.
