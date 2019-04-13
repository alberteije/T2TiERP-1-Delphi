{*******************************************************}
{                                                       }
{       TRpTranslator component                         }
{                                                       }
{       A component to easy translate strings at        }
{       runtime                                         }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

unit rptranslator;

{$I rpconf.inc}

interface

uses
 SysUtils,rpmdconsts,rpmdshfolder,
{$IFDEF LINUX}
 Libc,
{$ENDIF}
{$IFDEF DOTNETD}
 System.Globalization,
{$ENDIF}
{$IFDEF MSWINDOWS}
 Windows,
{$ENDIF}
 Classes,rptypes;



const
 DEFAULT_SARRAY_SIZE=100;
 INIT_POOLSIZE=32000;

type
 TRpStringInfo=record
  Position:integer;
  Size:integer;
 end;

 TRpTranslator=class(TComponent)
  private
   FFileName:string;
   FInternalActive:boolean;
   FActive:Boolean;
   FPool:WideString;
   FPoolPos:integer;
   FPoolSize:integer;
   FAutoLocale:Boolean;
   FStrings:array of TRpStringInfo;
   FArraySize:integer;
   FStringCount:integer;
   FLookForresource:boolean;
   FCurrentResourceFileName:String;
   procedure AddString(Value:WideString);
   procedure SetActive(Value:boolean);
   procedure InternalOpen;
   procedure InternalClose;
   function GetString(index:integer):WideString;
  protected
   procedure Loaded;override;
  public
   constructor Create(AOwner:TComponent);override;
   function LoadString(id:integer;DefaultValue:WideString):WideString;
   property Strings[index:integer]:WideString read GetString;
   property CurrentResourceFileName:string read FCurrentResourceFileName;
   property StringCount:integer read FStringCount;
  published
   property Active:Boolean read FActive write SetActive;
   property AutoLocale:Boolean read FAutoLocale write FAutoLocale default true;
   property LookForResource:boolean read FLookForResource write FLookForResource default true;
   property Filename:string read FFilename write FFilename;
  end;


function AddLocaleSufix(afilename:string):string;
{$IFDEF MSWINDOWS}
function FindLocaleSuffix3:string;
function FindLocaleSuffix2:string;
{$ENDIF}

implementation

{$IFNDEF DOTNETD}
{$IFDEF MSWINDOWS}
const
  kernel = 'kernel32.dll';
  OldLocaleOverrideKey = 'Software\Borland\Delphi\Locales'; // do not localize
  NewLocaleOverrideKey = 'Software\Borland\Locales'; // do not localize

function RegOpenKeyEx(hKey: LongWord; lpSubKey: PChar; ulOptions,
  samDesired: LongWord; var phkResult: LongWord): Longint;
{$IFDEF ISDELPHI}
  stdcall;
{$ENDIF}
  external advapi32 name 'RegOpenKeyExA';
function RegQueryValueEx(hKey: LongWord; lpValueName: PChar;
  lpReserved: Pointer; lpType: Pointer; lpData: PChar; lpcbData: Pointer): Integer;
{$IFDEF ISDELPHI}
  stdcall;
{$ENDIF}
  external advapi32 name 'RegQueryValueExA';
{$ENDIF}
{$ENDIF}

constructor TRpTranslator.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 SetLength(FPool,INIT_POOLSIZE);
 FPoolSize:=INIT_POOLSIZE;
 FPoolPos:=1;
 SetLength(FStrings,DEFAULT_SARRAY_SIZE);
 FArraySize:=DEFAULT_SARRAY_SIZE;
 FAutoLocale:=True;
 FLookForresource:=true;
end;



procedure TRpTranslator.SetActive(Value:boolean);
begin
 if csReading in componentState then
 begin
  FInternalActive:=Value;
  exit;
 end;
 if Value=FActive then
  exit;
 if Value then
 begin
  InternalOpen;
  FActive:=true;
 end
 else
 begin
  FActive:=False;
  InternalClose;
 end;
end;

procedure TRpTranslator.Loaded;
begin
 if FInternalActive then
  SetActive(True);
end;


{$IFDEF MSWINDOWS}
function FindLocaleSuffix3:string;
var
  LocaleName:array[0..4] of Char;
begin
  GetLocaleInfo(GetThreadLocale, LOCALE_SABBREVLANGNAME, LocaleName, SizeOf(LocaleName));
  Result:=StrPas(LocaleName);
end;




function FindLocaleSuffix2:string;
var
  LocaleName:array[0..4] of Char;
begin
  GetLocaleInfo(GetThreadLocale, LOCALE_SABBREVLANGNAME, LocaleName, SizeOf(LocaleName));
  Result:=Copy(StrPas(LocaleName),1,2);
end;
{$ENDIF}



{$IFNDEF DOTNETD}
function AddLocaleSufix(afilename:string):string;
{$IFDEF LINUX}
var
 LangCode,P:PChar;
 I:Integer;
{$ENDIF}
{$IFDEF MSWINDOWS}
var
  FileName: array[0..260] of Char;
  Key: LongWord;
  LocaleName, LocaleOverride: array[0..4] of Char;
  Size: Integer;
  P: PChar;

  function FindBS(Current: PChar): PChar;
  begin
    Result := Current;
    while (Result^ <> #0) and (Result^ <> '\') do
      Result := CharNext(Result);
  end;

  function ToLongPath(AFileName: PChar): PChar;
  var
    CurrBS, NextBS: PChar;
     L: Integer;
     Handle:Integer;
    FindData: TWin32FindData;
    Buffer: array[0..260] of Char;
    GetLongPathName: function (ShortPathName: PChar; LongPathName: PChar;
      cchBuffer: Integer): Integer;
{$IFDEF ISDELPHI}
  stdcall;
{$ENDIF}
  begin
{$R-}
    Result := AFileName;
    Handle := GetModuleHandle(kernel);
    if Handle <> 0 then
    begin
      @GetLongPathName := GetProcAddress(Handle, 'GetLongPathNameA');
      if Assigned(GetLongPathName) and
         (GetLongPathName(AFileName, Buffer, SizeOf(Buffer)) <> 0) then
      begin
        lstrcpy(AFileName, Buffer);
        Exit;
      end;
    end;

    if AFileName[0] = '\' then
    begin
      if AFileName[1] <> '\' then Exit;
      CurrBS := FindBS(AFileName + 2);  // skip server name
      if CurrBS^ = #0 then Exit;
      CurrBS := FindBS(CurrBS + 1);     // skip share name
      if CurrBS^ = #0 then Exit;
    end else
      CurrBS := AFileName + 2;          // skip drive name

    L := CurrBS - AFileName;
    lstrcpyn(Buffer, AFileName, L + 1);
    while CurrBS^ <> #0 do
    begin
      NextBS := FindBS(CurrBS + 1);
      if L + (NextBS - CurrBS) + 1 > SizeOf(Buffer) then Exit;
//      lstrcpyn(Buffer + L, CurrBS, (NextBS - CurrBS) + 1);
      lstrcpyn(@Buffer[L], CurrBS, (NextBS - CurrBS) + 1);

      Handle := FindFirstFile(Buffer, FindData);
      if (Handle = -1) then Exit;
      windows.FindClose(Handle);

      if L + 1 + lstrlen(FindData.cFileName) + 1 > SizeOf(Buffer) then Exit;
      Buffer[L] := '\';
//      lstrcpy(Buffer + L + 1, FindData.cFileName);
      lstrcpy(@Buffer[L + 1], FindData.cFileName);
      Inc(L, lstrlen(FindData.cFileName) + 1);
      CurrBS := NextBS;
    end;
    lstrcpy(AFileName, Buffer);
{$R+}
  end;
{$ENDIF}
begin
 Result:=afilename;
{$IFDEF LINUX}
 LangCode := getenv('LANG');
 if (LangCode = nil) or (LangCode^ = #0) then
  Exit;
 // look for modulename.en_US
 P := LangCode;
 while P^ in ['a'..'z', 'A'..'Z', '_'] do
  Inc(P);
 if P = LangCode then
  Result := afilename
 else
 begin
  Result := afilename + '.' + Copy(LangCode, 1, P - LangCode);
  if not FileExists(Result) then
  begin
   // look for modulename.en    (ignoring country code and suffixes)
   I := Length(Result);
   while (I > 0) and not (Result[I] in ['.', '_']) do
    Dec(I);
   if (I-1 = Length(Result)) or (I-1 < Length(afilename)) then
    Exit;
   SetLength(Result, I-1);
   if not FileExists(Result) then
   begin
    if not FileExists(LowerCase(Result)) then
    begin
     Result:=afilename;
     Exit;
    end
    else
    begin
     Result:=LowerCase(Result);
    end;
   end;
  end;
 end;
{$ENDIF}
{$IFDEF MSWINDOWS}
  afilename:=afilename+'.exe';
  StrCopy(Filename,Pchar(afilename));
  LocaleOverride[0] := #0;
  if (RegOpenKeyEx(HKEY_CURRENT_USER, NewLocaleOverrideKey, 0, KEY_ALL_ACCESS, Key) = 0) or
   (RegOpenKeyEx(HKEY_CURRENT_USER, OldLocaleOverrideKey, 0, KEY_ALL_ACCESS, Key) = 0) then
  try
    Size := SizeOf(LocaleOverride);
    if RegQueryValueEx(Key, ToLongPath(FileName), nil, nil, LocaleOverride, @Size) <> 0 then
      RegQueryValueEx(Key, '', nil, nil, LocaleOverride, @Size);
  finally
    RegCloseKey(Key);
  end;
  GetLocaleInfo(GetThreadLocale, LOCALE_SABBREVLANGNAME, LocaleName, SizeOf(LocaleName));
  Result := '';
  if (FileName[0] <> #0) and ((LocaleName[0] <> #0) or (LocaleOverride[0] <> #0)) then
  begin
    P := PChar(@FileName) + lstrlen(FileName);
    while (P^ <> '.') and (P <> @FileName) do Dec(P);
    if P <> @FileName then
    begin
      Inc(P);
      // First look for a locale registry override
      if LocaleOverride[0] <> #0 then
      begin
        lstrcpy(P, LocaleOverride);
        if FileExists(FileName) then
         Result := FileName;
      end;
      if (Result ='') and (LocaleName[0] <> #0) then
      begin
        // Then look for a potential language/country translation
        lstrcpy(P, LocaleName);
        if FileExists(Filename) then
         Result := FileName;
        if Result = '' then
        begin
          // Finally look for a language only translation
          LocaleName[2] := #0;
          lstrcpy(P, LocaleName);
          if FileExists(Filename) then
           Result := FileName;
        end;
      end;
    end;
  end;
{$ENDIF}
end;
{$ENDIF}

procedure TRpTranslator.InternalOpen;
var
 afilename:string;
 memstream:TMemoryStream;
 astring:array of WideChar;
 asize,i:integer;
 resname:string;
 nstream:TMemoryStream;
 tempstring:widestring;
{$IFDEF MSWINDOWS}
 resstream:TResourceStream;
 fromresource:boolean;
 hfind:HRSRC;
{$ENDIF}
{$IFDEF DOTNETD}
 wsize:integer;
 abytes:Array of byte;
{$ENDIF}
begin
 SetLength(FPool,INIT_POOLSIZE);
 FPoolSize:=INIT_POOLSIZE;
 FPoolPos:=1;
 SetLength(FStrings,DEFAULT_SARRAY_SIZE);
 FArraySize:=DEFAULT_SARRAY_SIZE;
 // Finds the file and read the strings
 // The format is translations separator is a #10, two #10 is a true single #10.
 if Length(FFilename)<1 then
  Raise Exception.Create(SRpNoFilenameAssignedNotTRpTranslator);
 afilename:=FFilename;
 if FAutoLocale then
 begin
   afilename:=AddLocaleSufix(ExtractFilePath(ParamStr(0))+FFilename);
   if Length(afilename)=0 then
    afilename:=FFilename;
 end;
{$IFDEF MSWINDOWS}
 // Look for a resource named same
 resname:=ExtractFileName(afilename);
 fromresource:=false;
{$ENDIF}
 memstream:=nil;
 try
{$IFDEF MSWINDOWS}
   if (Length(resname)>2) then
   begin
    resname:=ChangeFileExt(resname,'')+'_'+FindLocaleSuffix3;
    hFind := FindResource(HInstance, PChar(resname),RT_RCDATA);
    if hFind=0 then
    begin
     resname:=ExtractFileName(afilename);
     resname:=ChangeFileExt(resname,'')+'_'+FindLocaleSuffix2;
     hFind := FindResource(HInstance, PChar(resname),RT_RCDATA);
    end;
    if (hFind<>0) then
    begin
     resstream:=TResourceStream.Create(hinstance,resname,RT_RCDATA);
     try
      if (resstream.Size>0) then
      begin
       fromresource:=true;
       memstream:=TMemoryStream.Create;
       memstream.CopyFrom(resstream,resstream.size);
      end;
     finally
      resstream.free;
     end;
    end;
   end;
   FCurrentResourceFileName:=afilename;
   if (not fromresource) then
{$ENDIF}
   begin
    if Not FileExists(afilename) then
    begin
     // Try with system directory
     afilename:=FFilename;
     if FAutoLocale then
     begin
      afilename:=GetTheSystemDirectory+DIR_SEPARATOR+FFilename;
      afilename:=AddLocaleSufix(afilename);
     end;
     if Not FileExists(afilename) then
      exit;
    end;
    memstream:=TMemoryStream.Create;
    memstream.LoadFromFile(afilename);
   end;
   // Opens the file and loads the strings
   memstream.Seek(0,soFromBeginning);
   // Look for compressed
   if (IsCompressed(memstream)) then
   begin
    nstream:=memstream;
    memstream:=TMemoryStream.Create;
    try
     DecompressStream(nstream,memstream);
     memstream.Seek(0,soFromBeginning);
    finally
     nstream.free;
    end;
   end;
   SetLength(astring,memstream.size div 2);
   memstream.Read(astring[0],memstream.Size);
 finally
  if memstream<>nil then
   memstream.free;
 end;

 asize:=Length(astring);
 i:=0;
 tempstring:='';
 while i<asize do
 begin
  if astring[i]=#10 then
  begin
   inc(i);
   if i>asize then
    break;
   if astring[i]=#10 then
    tempstring:=tempstring+#10
   else
   begin
    AddString(tempstring);
    tempstring:=astring[i];
   end;
  end
  else
   tempstring:=tempstring+astring[i];
  inc(i);
 end;
 if length(tempstring)>0 then
  AddString(tempstring);
end;

procedure TRpTranslator.InternalClose;
begin
 FStringCount:=0;
 FPoolPos:=1;
 FPool:='';
 FCurrentResourceFileName:='';
 FPoolSize:=0;
end;

procedure TRpTranslator.AddString(Value:WideString);
var
 alength:integer;
 i:integer;
begin
 alength:=Length(value);
 if FStringCount>(FArraySize-2) then
 begin
  SetLength(FStrings,FArraySize*2);
  FArraySize:=FArraySize*2;
 end;
 if (FPoolPos+alength)>FPoolSize-1 then
 begin
  FPoolSize:=FPoolSize*2;
  SetLength(FPool,FPoolSize);
 end;
 FStrings[FStringCount].Position:=FPoolPos;
 for i:=1 to alength do
 begin
  FPool[FPoolPos]:=Value[i];
  inc(FPoolPos);
 end;
// FPool:=FPool+Value;
 FStrings[FStringCount].Size:=alength;
 FStringCount:=FStringCount+1;
// FPoolPos:=FPoolPos+alength;
end;


function TRpTranslator.GetString(index:integer):WideString;
begin
 if index>=FStringCount then
 begin
  Result:='';
  exit;
 end;
 Result:=Copy(FPool,FStrings[index].Position,FStrings[index].Size);
end;


function TRpTranslator.LoadString(id:integer;DefaultValue:WideString):WideString;
begin
 Result:=DefaultValue;
 if Not Active then
  exit;
 if ((StringCount-1)<id) then
  exit;
 Result:=GetString(id);
end;


end.
