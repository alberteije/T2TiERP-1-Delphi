{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpmdshfolder                                    }
{                                                       }
{                                                       }
{       An interface to user and system config files    }
{       to store information with a Windows 2000        }
{       compliant procedure (and LSB in Linux)          }
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

unit rpmdshfolder;

interface

{$I rpconf.inc}

uses
  SysUtils, Classes,
{$IFDEF LINUX}
  Libc,
{$ENDIF}
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
{$IFNDEF USEVARIANTS}
{$IFNDEF FPC}
  FileCtrl,
{$ENDIF}
{$ENDIF}
{$IFDEF DOTNETD}
  System.IO,
{$ENDIF}
  rpmdconsts;

{$IFDEF MSWINDOWS}
const
{$IFNDEF DOTNETD}
  {$EXTERNALSYM CSIDL_APPDATA}
  CSIDL_APPDATA              = $001A;  // Application Data, new for NT4
  {$EXTERNALSYM CSIDL_FLAG_CREATE}
  CSIDL_FLAG_CREATE          = $8000;  // new for Win2K, or this in to force
  {$EXTERNALSYM CSIDL_LOCAL_APPDATA}
  CSIDL_LOCAL_APPDATA        = $001C;  // non roaming,
  {$EXTERNALSYM CSIDL_COMMON_APPDATA}
  CSIDL_COMMON_APPDATA       = $0023;  // All Users\Application Data
{$ENDIF}

  shlwapi32 = 'shlwapi.dll';
  shfolder  = 'shfolder.dll';
{$ENDIF}
{$IFDEF LINUX}
const
 DIR_SEPARATOR='/';
{$ENDIF}
{$IFDEF MSWINDOWS}
 DIR_SEPARATOR='\';
{$ENDIF}


  function Obtainininameuserconfig (company, product, filename:string):string;
  function Obtainininamelocalconfig (company, product, filename:string):string;
  function Obtainininamecommonconfig (company, product, filename:string):string;
  function GetTheSystemDirectory:String;
{$IFDEF MSWINDOWS}
var SHGetFolderPathA:function (hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWORD; pszPath: PAnsiChar): HResult; stdcall;
var SHGetFolderPathW:function (hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWORD; pszPath: PWideChar): HResult; stdcall;
var HandleLib:THandle;
var PathAppendA:function (pszPath: PAnsiChar; pMore: PAnsiChar): BOOL; stdcall;
var PathAppendW:function (pszPath: PWideChar; pMore: PWideChar): BOOL; stdcall;
var HandleLib2:THandle;
{$ENDIF}

implementation

uses rptypes;

function Obtainininameuserconfig(company,product,filename:string):string;
var
 szAppDataA:array [0..MAX_PATH] of AnsiChar;
 szAppDataW:array [0..MAX_PATH] of WideChar;
 wcompany:Widestring;
 wproduct:WideString;
 wfilename:WideString;
{$IFDEF LINUX}
 ap:PCHar;
{$ENDIF}
 nresult:THandle;
begin

{$IFDEF LINUX}
 ap:=getenv(Pchar('HOME'));
 if assigned(ap) then
 begin
  StrPCopy(szAppdata,ap);
  Result:=StrPas(szAppdata)+'/.'
 end
 else
  Result:='./.';
 if length(company)>0 then
  Result:=Result+company+'.';
 if length(product)>0 then
  Result:=Result+product+'.';
 Result:=Result+filename;
{$ENDIF}
{$IFDEF MSWINDOWS}
 if length(filename)<1 then
  Raise Exception.Create(SRpFileNameRequired);
 if (IsWindowsNT) then
 begin
  nresult:=SHGetFolderPathW(0, CSIDL_APPDATA or CSIDL_FLAG_CREATE, 0, 0, szAppDataW);
  wcompany:=company;
  wproduct:=product;
  wfilename:=filename;
  if length(wcompany)>0 then
  begin
   if not PathAppendW(szAppdataW,PWidechar(wcompany)) then
    RaiseLastOSError;
  end;
  if Length(wproduct)>0 then
  begin
   if not PathAppendW(szAppdataW,Pchar(wproduct)) then
    RaiseLastOSError;
  end;
  Result:=StrPas(szAppdataW);
 end
 else
 begin
  nresult:=SHGetFolderPathA(0, CSIDL_APPDATA or CSIDL_FLAG_CREATE, 0, 0, szAppDataA);
  if length(company)>0 then
  begin
   if not PathAppendA(szAppdataA,PAnsichar(company)) then
    RaiseLastOSError;
  end;
  if Length(product)>0 then
  begin
   if not PathAppendA(szAppdataA,PAnsichar(product)) then
    RaiseLastOSError;
  end;
  Result:=StrPas(szAppdataA);
 end;
 if (S_OK <>nresult) then
 begin
  Result:=Result+'Error in ShGetFolderPath(CSIDL_APPDATA or CSIDL_FLAG_CREATE)';
  exit;
 end;



 if Not DirectoryExists(Result) then
 begin
{$IFDEF BUILDER4}
 ForceDirectories(Result);
{$ENDIF}
{$IFNDEF BUILDER4}
 try
  if not ForceDirectories(Result) then
   Result:='';
 except
   Result:='';
 end;
{$ENDIF}
 end;
 if (IsWindowsNT) then
 begin
  if not PathAppendW(szAppdataW,PWidechar(filename+'.ini')) then
    RaiseLastOSError;
  Result:=StrPas(szAppdataW);
 end
 else
 begin
  if not PathAppendA(szAppdataA,PAnsichar(filename+'.ini')) then
    RaiseLastOSError;
  Result:=StrPas(szAppdataA);
 end;
{$ENDIF}
end;




function Obtainininamecommonconfig(company,product,filename:string):string;
var
 nresult:THandle;
 szAppDataA:array [0..MAX_PATH] of AnsiChar;
 szAppDataW:array [0..MAX_PATH] of WideChar;
 wcompany:Widestring;
 wproduct:WideString;
 wfilename:WideString;
begin
{$IFDEF LINUX}
 Result:='/etc/'+company+product+filename;
{$ENDIF}
{$IFDEF MSWINDOWS}
 if length(filename)<1 then
  Raise Exception.Create(SRpFileNameRequired);
 if (IsWindowsNT) then
 begin
  nresult:=SHGetFolderPathW(0, CSIDL_COMMON_APPDATA or CSIDL_FLAG_CREATE, 0, 0, szAppDataW);
  if (nresult<>S_OK) then
  begin
   // Error in apache configuration
   nresult:=SHGetFolderPathW(0, CSIDL_LOCAL_APPDATA or CSIDL_FLAG_CREATE, 0, 0, szAppDataW);
   if (nresult<>S_OK) then
   begin
    try
     RaiseLastOsError;
    except
     On E:Exception do
     begin
      raise Exception.Create('Error calling SHGetFolderPathW CSIDL_COMMON_APPDATA && CSIDL_LOCAL_APPDATA:'+
       'Error code:'+IntToStr(nresult)+' '+E.Message);
     end;
    end;
   end;
  end;
  wcompany:=company;
  wproduct:=product;
  wfilename:=filename;
  if length(wcompany)>0 then
  begin
   if not PathAppendW(szAppdataW,PWidechar(wcompany)) then
    RaiseLastOSError;
  end;
  if Length(wproduct)>0 then
  begin
   if not PathAppendW(szAppdataW,Pchar(wproduct)) then
    RaiseLastOSError;
  end;
  Result:=StrPas(szAppdataW);
 end
 else
 begin
  nresult:=SHGetFolderPathA(0, CSIDL_COMMON_APPDATA or CSIDL_FLAG_CREATE, 0, 0, szAppDataA);
  if length(company)>0 then
  begin
   if not PathAppendA(szAppdataA,PAnsichar(company)) then
    RaiseLastOSError;
  end;
  if Length(product)>0 then
  begin
   if not PathAppendA(szAppdataA,PAnsichar(product)) then
    RaiseLastOSError;
  end;
  Result:=StrPas(szAppdataA);
 end;
 if (S_OK <>nresult) then
 begin
  Result:=Result+'Error in ShGetFolderPath(CSIDL_COMMON_APPDATA or CSIDL_FLAG_CREATE)';
  exit;
 end;



 if Not DirectoryExists(Result) then
 begin
{$IFDEF BUILDER4}
 ForceDirectories(Result);
{$ENDIF}
{$IFNDEF BUILDER4}
 try
  if not ForceDirectories(Result) then
   Result:='';
 except
   Result:='';
 end;
{$ENDIF}
 end;
 if (IsWindowsNT) then
 begin
  if not PathAppendW(szAppdataW,PWidechar(filename+'.ini')) then
    RaiseLastOSError;
  Result:=StrPas(szAppdataW);
 end
 else
 begin
  if not PathAppendA(szAppdataA,PAnsichar(filename+'.ini')) then
    RaiseLastOSError;
  Result:=StrPas(szAppdataA);
 end;
{$ENDIF}
end;


function Obtainininamelocalconfig(company,product,filename:string):string;
var
 nresult:THandle;
 szAppDataA:array [0..MAX_PATH] of AnsiChar;
 szAppDataW:array [0..MAX_PATH] of WideChar;
 wcompany:Widestring;
 wproduct:WideString;
 wfilename:WideString;
begin
{$IFDEF LINUX}
 Result:=Obtainininameuserconfig(company,product+'etc',filename);
{$ENDIF}
{$IFDEF MSWINDOWS}
 if length(filename)<1 then
  Raise Exception.Create(SRpFileNameRequired);
 if (IsWindowsNT) then
 begin
  nresult:=SHGetFolderPathW(0, CSIDL_LOCAL_APPDATA or CSIDL_FLAG_CREATE, 0, 0, szAppDataW);
  wcompany:=company;
  wproduct:=product;
  wfilename:=filename;
  if length(wcompany)>0 then
  begin
   if not PathAppendW(szAppdataW,PWidechar(wcompany)) then
    RaiseLastOSError;
  end;
  if Length(wproduct)>0 then
  begin
   if not PathAppendW(szAppdataW,Pchar(wproduct)) then
    RaiseLastOSError;
  end;
  Result:=StrPas(szAppdataW);
 end
 else
 begin
  nresult:=SHGetFolderPathA(0, CSIDL_LOCAL_APPDATA or CSIDL_FLAG_CREATE, 0, 0, szAppDataA);
  if length(company)>0 then
  begin
   if not PathAppendA(szAppdataA,PAnsichar(company)) then
    RaiseLastOSError;
  end;
  if Length(product)>0 then
  begin
   if not PathAppendA(szAppdataA,PAnsichar(product)) then
    RaiseLastOSError;
  end;
  Result:=StrPas(szAppdataA);
 end;
 if (S_OK <>nresult) then
 begin
  Result:=Result+'Error in ShGetFolderPath(CSIDL_LOCAL_APPDATA or CSIDL_FLAG_CREATE)';
  exit;
 end;



 if Not DirectoryExists(Result) then
 begin
{$IFDEF BUILDER4}
 ForceDirectories(Result);
{$ENDIF}
{$IFNDEF BUILDER4}
 try
  if not ForceDirectories(Result) then
   Result:='';
 except
   Result:='';
 end;
{$ENDIF}
 end;
 if (IsWindowsNT) then
 begin
  if not PathAppendW(szAppdataW,PWidechar(filename+'.ini')) then
    RaiseLastOSError;
  Result:=StrPas(szAppdataW);
 end
 else
 begin
  if not PathAppendA(szAppdataA,PAnsichar(filename+'.ini')) then
    RaiseLastOSError;
  Result:=StrPas(szAppdataA);
 end;
{$ENDIF}
end;

function GetTheSystemDirectory:String;
{$IFDEF MSWINDOWS}
var
 pbuf:PChar;
 asize:Integer;
{$ENDIF}
begin
{$IFDEF LINUX}
 Result:='/lib';
{$ENDIF}
{$IFDEF MSWINDOWS}
 pbuf:=AllocMem(MAX_PATH+1);
 try
  asize:=GetSystemDirectory(pbuf,MAX_PATH);
  if asize=0 then
   RaiseLastOsError;
  if asize>MAX_PATH then
  begin
   asize:=GetSystemDirectory(pbuf,MAX_PATH);
   if asize=0 then
    RaiseLastOsError;
  end;
  result:=StrPas(pbuf);
 finally
  FreeMem(pbuf);
 end;
{$ENDIF}
end;



initialization

{$IFDEF MSWINDOWS}
HandleLib:=LoadLibrary(shfolder);
if HandleLib=0 then
 RaiseLastOSError;
HandleLib2:=LoadLibrary(shlwapi32);
if HandleLib=2 then
 RaiseLastOSError;
//{$IFDEF DELPHI2009UP
//SHGetFolderPath:=GetProcAddress(HandleLib,PChar('SHGetFolderPathW'));
//{$ENDIF}
//{$IFNDEF DELPHI2009UP}
if (IsWindowsNt) then
begin
 SHGetFolderPathW:=GetProcAddress(HandleLib,PChar('SHGetFolderPathW'));
 if Not Assigned(SHGetFolderPathW) then
  RaiseLastOSError;
end
else
begin
 SHGetFolderPathA:=GetProcAddress(HandleLib,PChar('SHGetFolderPathA'));
 if Not Assigned(SHGetFolderPathA) then
  RaiseLastOSError;
end;
//{$ENDIF}
//{$IFDEF DELPHI2009UP}
//PathAppend:=GetProcAddress(HandleLib2,PChar('PathAppendW'));
//{$ENDIF}
//{$IFNDEF DELPHI2009UP}
if (IsWindowsNt) then
begin
 PathAppendW:=GetProcAddress(HandleLib2,PChar('PathAppendW'));
 if Not Assigned(PathAppendW) then
  RaiseLastOSError;
end
else
begin
 PathAppendA:=GetProcAddress(HandleLib2,PChar('PathAppendA'));
 if Not Assigned(PathAppendA) then
  RaiseLastOSError;
end;
//{$ENDIF}
{$ENDIF}

finalization

{$IFDEF MSWINDOWS}
if HandleLib<>0 then
 FreeLibrary(HandleLib);
if HandleLib2<>0 then
 FreeLibrary(HandleLib2);
{$ENDIF}

end.











