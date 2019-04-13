{
  Part of Kylix / Delphi open source DbExpress driver for ODBC
  Version 2.011, 2003-12-09

  Copyright (c) 2003 by Vadim V.Lopushansky

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public License
  as published by the Free Software Foundation; either version 2.1
  of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU Lesser General Public License for more details.
}

(*

For review of debug messages (outside of IDE) it is possible to take advantage of DebugView program.

Debug View:
http://www.sysinternals.com/ntw2k/freeware/debugview.shtml

DebugView is an application that lets you monitor debug output on your local system, or any computer
on the network that you can reach via TCP/IP. It is capable of displaying both kernel-mode and Win32
debug output, so you don't need a debugger to catch the debug output your applications or device
drivers generate, nor do you need to modify your applications or drivers to use non-standard debug
output APIs.

DebugView works on Windows 95, 98, Me, NT 4, 2000, XP and .NET Server.

Download (169KB):
http://www.sysinternals.com/files/dbgvnt.zip
http://www.sysinternals.com/files/dbgv98.zip

Under Linux debug messages will be dispatched on a console (stderr).

*)

unit DbxOpenOdbcTrace;

interface

{$i DbxOpenOdbc.inc}
{.$D+,L+}

uses
  {$IFDEF MSWINDOWS}
    Windows,
  {$ENDIF IFDEF MSWINDOWS}
    Classes,
    SysUtils,
    DBXpress,
    DbxOpenOdbcInterface,
    OdbcApi;


procedure OutputDebugString(const S:String);

procedure LogEnterProc(const ProcName: string; const Params: string=''); overload;
procedure LogEnterProc(const ProcName: string; const Params: array of const); overload;

procedure LogInfoProc(const Params: string=''); overload;
procedure LogInfoProc(const Params: array of const); overload;

procedure LogExitProc(const ProcName: string; const ExitInfo: string=''); overload;
procedure LogExitProc(const ProcName: string; const ExitInfo: array of const); overload;

procedure LogExceptProc(const ProcName: string; E:Exception; const ExceptInfo: string=''); overload;
procedure LogExceptProc(const ProcName: string; E:Exception; const ExceptInfo: array of const); overload;

const

  cSQLConnectionOption: array[TXSQLConnectionOption] of string = (
    'eConnAutoCommit', 'eConnBlockingMode', 'eConnBlobSize', 'eConnRoleName',
    'eConnWaitOnLocks', 'eConnCommitRetain', 'eConnTxnIsoLevel',
    'eConnNativeHandle', 'eConnServerVersion', 'eConnCallBack', 'eConnHostName',
    'eConnDatabaseName', 'eConnCallBackInfo', 'eConnObjectMode',
    'eConnMaxActiveComm', 'eConnServerCharSet', 'eConnSqlDialect'
    {.$IFDEF _K3UP_},
    'eConnRollbackRetain', 'eConnObjectQuoteChar', 'eConnConnectionName',
    'eConnOSAuthentication', 'eConnSupportsTransaction', 'eConnMultipleTransaction',
    'eConnServerPort', 'eConnOnLine', 'eConnTrimChar'
    {.$ENDIF}
    {.$IFDEF _D7UP_}, 'eConnQualifiedName',
    'eConnCatalogName', 'eConnSchemaName', 'eConnObjectName', 'eConnQuotedObjectName',
    'eConnCustomInfo', 'eConnTimeOut'
    {.$ENDIF}
    ,'eConnConnectionString'
  );

  cSQLDriverOption: array[TSQLDriverOption] of string = (
    'eDrvBlobSize', 'eDrvCallBack', 'eDrvCallBackInfo', 'eDrvRestrict');

  cSQLMetaDataOption: array[TXSQLMetaDataOption] of string = (
    'eMetaCatalogName', 'eMetaSchemaName', 'eMetaDatabaseName',
    'eMetaDatabaseVersion', 'eMetaTransactionIsoLevel', 'eMetaSupportsTransaction',
    'eMetaMaxObjectNameLength', 'eMetaMaxColumnsInTable', 'eMetaMaxColumnsInSelect',
    'eMetaMaxRowSize', 'eMetaMaxSQLLength', 'eMetaObjectQuoteChar',
    'eMetaSQLEscapeChar', 'eMetaProcSupportsCursor', 'eMetaProcSupportsCursors',
    'eMetaSupportsTransactions'
    {.$IFDEF _D7UP_}
    , 'eMetaPackageName'
    {.$ENDIF}
  );

  cSQLCommandOption: array[TXSQLCommandOption] of string = (
    'eCommRowsetSize', 'eCommBlobSize', 'eCommBlockRead', 'eCommBlockWrite',
    'eCommParamCount', 'eCommNativeHandle', 'eCommCursorName', 'eCommStoredProc',
    'eCommSQLDialect', 'eCommTransactionID'
    {.$IFDEF _D7UP_}
    , 'eCommPackageName', 'eCommTrimChar',
    'eCommQualifiedName', 'eCommCatalogName', 'eCommSchemaName', 'eCommObjectName',
    'eCommQuotedObjectName'
    {.$ENDIF}
  );

  cSTMTParamType: array[TSTMTParamType] of string = (
    'paramUNKNOWN', 'paramIN', 'paramOUT', 'paramINOUT', 'paramRET'
  );

  cSQLCursorOption: array[TSQLCursorOption] of string = (
    'eCurObjectAttrName', 'eCurObjectTypeName', 'eCurParentFieldID'
  );

  cOdbcDriverType: array[TOdbcDriverType] of string = (
    'eOdbcDriverTypeUnspecified',
    'eOdbcDriverTypeGupta', 'eOdbcDriverTypeMsSqlServer', 'eOdbcDriverTypeIbmDb2',
    'eOdbcDriverTypeMsJet',
    'eOdbcDriverTypeMySql', 'eOdbcDriverTypeMySql3',
    'eOdbcDriverTypeInterbase', 'eOdbcDriverTypeInformix',
    'eOdbcDriverTypeOracle', 'eOdbcDriverTypeSybase',
    'eOdbcDriverTypeSQLLite', 'eOdbcDriverTypeThinkSQL', 'eOdbcDriverTypeMerantOle',
    'eOdbcDriverTypePervasive', 'eOdbcDriverTypeNexusDbFlashFiler', 'eOdbcDriverTypePostgreSQL',
    'eOdbcDriverTypeInterSystemCache', 'eOdbcDriverTypeMerantDBASE',  'eOdbcDriverTypeSAPDB'
  );

  cDbmsType: array[TDbmsType] of string = (
    'eDbmsTypeUnspecified',
    'eDbmsTypeGupta', 'eDbmsTypeMsSqlServer', 'eDbmsTypeIbmDb2',
    'eDbmsTypeMySql', 'eDbmsTypeMySqlMax',
    'eDbmsTypeMsAccess', 'eDbmsTypeExcel', 'eDbmsTypeText', 'eDbmsTypeDBase', 'eDbmsTypeParadox',
    'eDbmsTypeOracle', 'eDbmsTypeInterbase', 'eDbmsTypeInformix', 'eDbmsTypeSybase',
    'eDbmsTypeSQLLite', 'eDbmsTypeThinkSQL', 'eDbmsTypeSapDb', 'eDbmsTypePervasiveSQL',
    'eDbmsTypeFlashFiler', 'eDbmsTypePostgreSQL', 'eDbmsTypeInterSystemCache'
   );

function GetTransactionDescStr(TranID: pTTransactionDesc):String;

implementation

function GetCurThreadInfoStr:String;
var
 tID: WORD;
begin
  tID := GetCurrentThreadID;
  if tID = MainThreadID then
    Result := ':(    0) '
  else
    Result := ':('+Format('%5d',[tID])+') ';
  {$IFDEF LINUX}
  // add process id info:
  //  Result := '['+Format('%10d',[DWORD(getpid)])+']' + Result;
  {$ENDIF}
end;

procedure OutputDebugString(const S:String);
{$IFDEF LINUX}
var
  sTI: String;
{$ENDIF}
begin
  {$IFDEF LINUX}
    sTI := GetCurThreadInfoStr;
    __write(stderr, sTI, Length(sTI));
    __write(stderr, S,   Length(S)  );
    __write(stderr, EOL, Length(EOL));
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    Windows.OutputDebugString(PChar(GetCurThreadInfoStr+S));
  {$ENDIF}
end;

function ArrayToStr(const Consts: array of Const; const sSeparator :String = ' ';
  const bQuoteData:boolean = True):string;
 var
   i:integer;
   sV:String;
 const
     cBoolean:Array[Boolean] of String  = ('False','True');
begin
  Result := '';
  if Length(Consts)=0 then
    exit;
  for i:=0 to Length(Consts)-1 do
  begin
    Case Consts[i].VType of
       vtInteger:
         sV := IntToStr(Consts[i].VInteger);
       vtBoolean:
         sV := cBoolean[Consts[i].VBoolean];
       vtChar   :
         sV := Consts[i].VChar;
       vtPointer:
         sV := format('$%x',[Integer(Consts[i].VPointer)]);
       vtPChar,
       vtAnsiString  :
         if Assigned(Consts[i].VPChar)  then
           sV := Consts[i].VPChar
         else
           sV := '';
       vtObject :
         if Assigned(Consts[i].VObject) then
           sV := format('$%x ClassName :%s',[Integer(@Consts[i].VObject), Consts[i].VObject.ClassName])
         else
           sV := '';
       vtClass  :
          if Assigned(Consts[i].VClass) then
            sV := format('ClassReference :%s',[Consts[i].VClass.ClassName])
          else
            sV := '';
       vtWideChar   :
         sV := Consts[i].VWideChar;
       vtPWideChar  :
         if Assigned( Consts[i].VPWideChar ) then
           sV := Consts[i].VPWideChar^
         else
           sV := '';
       vtCurrency   :
         if Assigned(Consts[i].VCurrency) then
           sV := FloatToStr(Consts[i].VCurrency^)
         else
           sV := '';
       vtVariant    :
         if Assigned(Consts[i].VVariant) then
           sV := 'Variant Assigend'
         else
           sV := '';
       vtInterface  :
         if Assigned(Consts[i].VInterface) then
           sV := format('Interface address: $%x',[Integer(Consts[i].VInterface)])
         else
           sV := '';
       vtWideString :
         if Assigned(Consts[i].VWideString) then
           sV := PWideString(Consts[i].VWideString)^
         else
           sV := '';
       vtInt64:
         sV := IntToStr(Consts[i].VInt64^);
    end;
    if bQuoteData and (i mod 2 = 1) then
      sV := '"'+sV+'"';
    Insert(sV, Result, Length(Result)+1);
    if i< Length(Consts)-1 then
      Insert(sSeparator, Result, Length(Result)+1);
  end;
end;

threadvar
  bExceptionFlag: Integer;

procedure LogEnterProc(const ProcName: string; const Params: string=''); overload;
begin
  inc(bExceptionFlag);

  if Params='' then
    OutputDebugString('->:'+ProcName+';')
  else
    OutputDebugString('->:'+ProcName+',  Params: '+Params+';');
end;

procedure LogEnterProc(const ProcName: string; const Params: array of const); overload;
begin
  LogEnterProc(ProcName, ArrayToStr(Params));
end;

procedure LogInfoProc(const Params: string=''); overload;
begin
  if Params<>'' then
    OutputDebugString('// '+' Info: '+Params+';');
end;

procedure LogInfoProc(const Params: array of const); overload;
begin
  LogInfoProc(ArrayToStr(Params));
end;

procedure LogExitProc(const ProcName: string; const ExitInfo: string=''); overload;
begin
  if bExceptionFlag>0 then
    dec(bExceptionFlag);

  if ExitInfo='' then
    OutputDebugString('~-:'+ProcName+';')
  else
    OutputDebugString('~-:'+ProcName+',  ExitInfo: '+ExitInfo+';') ;
end;

procedure LogExitProc(const ProcName: string; const ExitInfo: array of const); overload;
begin
  LogExitProc(ProcName, ArrayToStr(ExitInfo));
end;

procedure LogExceptProc(const ProcName: string; E:Exception; const ExceptInfo: string=''); overload;
  function GetExceptionInfoStr(E:Exception):String;
    var
      LastError :Integer;
  begin
    Result :=  '  ' + E.ClassName+': ' + E.Message+';';
    LastError := GetLastError;
    if LastError<>0 then
      Result := Result + '  SystemError: '+SysErrorMessage(LastError)+';';
  end;
  var
    ei:String;
begin
  if bExceptionFlag=0 then
      exit;
  bExceptionFlag := 0;
  if E is EAbort then
  begin
    ei := ' Aborted;';
  end
  else
  if Assigned(E) then
    ei := GetExceptionInfoStr(E)
  else
    ei := '';

  if ExceptInfo='' then
    OutputDebugString('##:'+ProcName+';'+ei)
  else
    OutputDebugString('##:'+ProcName+',  ExceptInfo: '+ExceptInfo+';'+ei) ;
end;

procedure LogExceptProc(const ProcName: string; E:Exception; const ExceptInfo: array of const); overload;
begin
  LogExceptProc(ProcName, E, ArrayToStr(ExceptInfo));
end;

function GetTransactionDescStr(TranID: pTTransactionDesc):String;
begin
  if TranID=nil then
    Result := ''
  else
  begin
    case TranId.IsolationLevel of
      xilREPEATABLEREAD:
        // Dirty reads and nonrepeatable reads are not possible. Phantoms are possible
        Result := 'xilREPEATABLEREAD(SQL_TXN_REPEATABLE_READ)';
      xilREADCOMMITTED:
        // Dirty reads are not possible. Nonrepeatable reads and phantoms are possible
        Result := 'xilREADCOMMITTED(SQL_TXN_READ_COMMITTED)';
      xilDIRTYREAD:
        // Dirty reads, nonrepeatable reads, and phantoms are possible.
        Result := 'xilDIRTYREAD(SQL_TXN_READ_UNCOMMITTED)';
      xilCUSTOM:
        // Custom Level
        Result := 'xilCUSTOM('+IntToStr(TranID.CustomIsolation)+')';
      else
        Result := 'Unknown IsolationLevel:'+IntToStr(Integer(TranId.IsolationLevel));
    end;
  end;
end;

initialization
  OutputDebugString('*** Debug Start :'+ParamStr(0));
finalization
  OutputDebugString('*** Debug Done  :'+ParamStr(0));
end.
