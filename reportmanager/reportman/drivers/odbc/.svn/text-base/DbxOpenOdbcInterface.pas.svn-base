{
  Kylix / Delphi open source DbExpress driver for ODBC
  Version 2.011, 2003-12-09

  Copyright (c) 2001, 2002 Edward Benson

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public License
  as published by the Free Software Foundation; either version 2.1
  of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU Lesser General Public License for more details.
}
unit DbxOpenOdbcInterface;

interface

uses
  Classes, DBXpress;

Type

  TXSQLConnectionOption = (
      xeConnAutoCommit, xeConnBlockingMode, xeConnBlobSize, xeConnRoleName,
      xeConnWaitOnLocks, xeConnCommitRetain, xeConnTxnIsoLevel,
      xeConnNativeHandle, xeConnServerVersion, xeConnCallBack, xeConnHostName,
      xeConnDatabaseName, xeConnCallBackInfo, xeConnObjectMode,
      xeConnMaxActiveComm, xeConnServerCharSet, xeConnSqlDialect,
      xeConnRollbackRetain, xeConnObjectQuoteChar, xeConnConnectionName,
      xeConnOSAuthentication, xeConnSupportsTransaction, xeConnMultipleTransaction,
      xeConnServerPort, xeConnOnLine, xeConnTrimChar, xeConnQualifiedName,
      xeConnCatalogName, xeConnSchemaName, xeConnObjectName, xeConnQuotedObjectName,
      xeConnCustomInfo, xeConnTimeOut,
      // Delphi 8:
      xeConnConnectionString);

  TXSQLCommandOption = (
      xeCommRowsetSize, xeCommBlobSize, xeCommBlockRead, xeCommBlockWrite,
      xeCommParamCount, xeCommNativeHandle, xeCommCursorName, xeCommStoredProc,
      xeCommSQLDialect, xeCommTransactionID, xeCommPackageName, xeCommTrimChar,
      xeCommQualifiedName, xeCommCatalogName, xeCommSchemaName, xeCommObjectName,
      xeCommQuotedObjectName);

  TXSQLMetaDataOption = (xeMetaCatalogName, xeMetaSchemaName, xeMetaDatabaseName,
      xeMetaDatabaseVersion, xeMetaTransactionIsoLevel, xeMetaSupportsTransaction,
      xeMetaMaxObjectNameLength, xeMetaMaxColumnsInTable, xeMetaMaxColumnsInSelect,
      xeMetaMaxRowSize, xeMetaMaxSQLLength, xeMetaObjectQuoteChar,
      xeMetaSQLEscapeChar, xeMetaProcSupportsCursor, xeMetaProcSupportsCursors,
      xeMetaSupportsTransactions, xeMetaPackageName);

type
  TOdbcDriverType = (eOdbcDriverTypeUnspecified,
   eOdbcDriverTypeGupta, eOdbcDriverTypeMsSqlServer, eOdbcDriverTypeIbmDb2,
   eOdbcDriverTypeMsJet,
   eOdbcDriverTypeMySql, eOdbcDriverTypeMySql3,
   eOdbcDriverTypeInterbase, eOdbcDriverTypeInformix,
   eOdbcDriverTypeOracle, eOdbcDriverTypeSybase,
   eOdbcDriverTypeSQLLite, eOdbcDriverTypeThinkSQL, eOdbcDriverTypeMerantOle,
   eOdbcDriverTypePervasive, {bad support MixedFetch}
   eOdbcDriverTypeNexusDbFlashFiler,{very bad driver} eOdbcDriverTypePostgreSQL,
   eOdbcDriverTypeInterSystemCache, eOdbcDriverTypeMerantDBASE, eOdbcDriverTypeSAPDB
   );

  TDbmsType = (eDbmsTypeUnspecified,
   eDbmsTypeGupta, eDbmsTypeMsSqlServer, eDbmsTypeIbmDb2,
   eDbmsTypeMySql, eDbmsTypeMySqlMax,
   eDbmsTypeMsAccess, eDbmsTypeExcel, eDbmsTypeText, eDbmsTypeDBase, eDbmsTypeParadox,
   eDbmsTypeOracle, eDbmsTypeInterbase, eDbmsTypeInformix, eDbmsTypeSybase,
   eDbmsTypeSQLLite, {Any type is mapped into the text, with maximum length 2048 }
   eDbmsTypeThinkSQL, eDbmsTypeSapDb, eDbmsTypePervasiveSQL,
   eDbmsTypeFlashFiler, eDbmsTypePostgreSQL, eDbmsTypeInterSystemCache
   );


{ ISqlConnectionOdbc interface  }
{
// ISqlConnectionOdbc introduces additional methods on ISqlConnection.
// Here is an example of how you can access this interface:
procedure OdbcInterfaceExample1(Conn: SqlConnection; Memo: TMemo);
var
  aSqlConnectionInterface: ISqlConnection;
  aSqlConnectionOdbcInterface: ISqlConnectionOdbc;
  aResult: HResult;
begin
  aSqlConnectionInterface := Conn.SqlConnection;
  aResult := aSqlConnectionInterface.QueryInterface(ISqlConnectionOdbc, aSqlConnectionOdbcInterface);
  if aResult = S_OK then
    aSqlConnectionOdbcInterface.GetConnectStrings(Memo.Lines);
end;

// If you have statically linked DbxOpenOdbc into your program,
// so you know SqlConnection will be implemented by TSqlConnectionOdbc,
// you can use "as" in place of "QueryInterface"
procedure OdbcInterfaceExample2(Conn: SqlConnection; Memo: TMemo);
var
  aSqlConnectionInterface: ISqlConnection;
  aSqlConnectionOdbcInterface: ISqlConnectionOdbc;
begin
  aSqlConnectionInterface := Conn.SqlConnection;
  aSqlConnectionOdbcInterface := aSqlConnectionInterface as ISqlConnectionOdbc;
  aSqlConnectionOdbcInterface.GetConnectStrings(Memo.Lines);
end;
}

  ISqlConnectionOdbc = interface
    ['{136DD9D1-9B9C-4355-9AEF-959662CB095E}']
    function GetDbmsName: string;
    function GetDbmsType: TDbmsType;
    function GetDbmsVersionString: string;
    function GetDbmsVersionMajor: integer;
    function GetDbmsVersionMinor: Integer;
    function GetDbmsVersionRelease: Integer;
    function GetLastOdbcSqlState: pchar;
    procedure GetOdbcConnectStrings(ConnectStringList: TStrings);
    function GetOdbcDriverName: string;
    function GetOdbcDriverType: TOdbcDriverType;
    function GetOdbcDriverVersionString: string;
    function GetOdbcDriverVersionMajor: integer;
    function GetOdbcDriverVersionMinor: Integer;
    function GetOdbcDriverVersionRelease: Integer;
    // 2.9
    function GetDbmsVersionBuild: Integer;
    function GetOdbcDriverVersionBuild: Integer;
  end;

implementation

end.
