{
  Kylix / Delphi open source DbExpress driver for ODBC
  Version 3.023, 2004-11-08

  Copyright (c) 2001, 2004 Edward Benson

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


{ --- DSIntf.pas --- }
  const
    { Additional (non-BDE fieldtypes }
    fldUNICODE          = $1007;          { Unicode }
{ --- DSIntf.pas --- }

type

  TConnectionOption = (
    // Connection features:
    coInternalCloneConnection, // redefine strategy for cloning connectuion (default is true).
                               // Wneh is false then cloning connection is managed by SqlExpr.pas
                               // else it is managed internal.
    coBlobChunkSize,           // redefines blob chunk size.
    coNetwrkPacketSize,        // redefines network packet size (default=4096).
    coReadOnly,                // redefines read only connection mode (defaut=false).
    coCatalogPrefix,           // redefines "catalog prefix format" for odbc connection string
                               // (default='DATABASE').
    // Metada features:
    coSupportsMetadata,        // redefines supports metadata.
    coSupportsCatalog,         // redefines supports catalog.
    coSupportsSchemaFilter,    // redefines Supports Schema Filter (Oracle).
    // BindField features:
    coMapInt64ToBcd,           // define mapping big int to bcd(9,0) (default=True).
    coMapSmallBcdToNative,     // define mapping bcd les then bcd(9,0) to native type
                               // (improving perfomance).
    coIgnoreUnknownFieldType,  // allow ignoring unsupported fields in select query (default=false;
                               // for informix=true)
    coMapCharAsBDE,            // redefines mapping string fields as old BDE strategy
                               // (default=false).
    coEnableBCD,               // redefine supports bcd (default is true).
    coMaxBCD,                  // redefine bcd size to bcd(32,?) (default is false).
    coEnableUnicode,           // redefine supports unicode (default=false).
    coSupportsAutoInc,         // redefine supports AutInc (default=true)
    coFldReadOnly,             // redefine supports odbc read only field attributes (default=true)
    // Field & Params features:
    coTrimChar,                // define trimm char for fixed char field (default=false).
    coEmptyStrParam,           // when is false then empty string is tracted as null (default=true).
    coNullStrParam,            // when is false then null string is tracted as empty string
                               // (default=true).
    coParamDateByOdbcLevel3,    // Handling DateTime parameter follow odbc level (default=false).
    // Rows Fetch features:
    coMixedFetch,              // redefines use "block fetching" (default=true and is driver depends).
    // ISQLCommand features:
    coLockMode                 // redefines timeout to the number of seconds to wait for an SQL
                               // statement to execute before returning to the application
                               // (default=17).
                               // Values:
                               //   -1: Suspends the process until the lock is released.
                               //    0: Ends the operation immediately and returns an error code.
                               //   >0: Suspends the process until the lock is released, or until
                               //       the end of the specified number of seconds.
  );
  TConnectionOptionType = ( cot_Bool, cot_String, cot_Int, cot_UInt );
  TConnectionOptionsNames = array[TConnectionOption] of string;
  TConnectionOptionsTypes = array[TConnectionOption] of TConnectionOptionType;

  TOptionSwitches = (osDefault {=='X'}, osOff {=='0'}, osOn {=='1'});
  TConnectionOptions = array[TConnectionOption] of TOptionSwitches;
  PConnectionOptions = ^TConnectionOptions;
  TOptionSwitchesNames = array[TOptionSwitches] of string;

const
  cConnectionOptionsNames: TConnectionOptionsNames = ( { Do not localize }
    // Connection features:
    'coICloneCon',             // - coInternalCloneConnection
    'coBlobChunkSize',         // - coBlobChunkSize,
    'coNetPacketSize',         // - coNetwrkPacketSize,
    'coReadOnly',              // - coReadOnly
    'coCatPrefix',             // - coCatalogPrefix
    // Metada features:
    'coMetaData',              // - coSupportsMetadata,
    'coCatalog',               // - coSupportsCatalog,
    'coSchemFlt',              // - coSupportsSchemaFilter,
    // BindField features:
    'coMapInt64ToBCD',         // - coMapInt64ToBcd,
    'coMapSmallBcdToNative',   // - coMapSmallBcdToNative,
    'coIgnoreUnkFldType',      // - coIgnoreUnknownFieldType,
    'coMapCharAsBDE',          // - coMapCharAsBDE,
    'coEnableBCD',             // - coEnableBCD
    'coMaxBCD',                // - coMaxBCD
    'coEnableUnicode',         // - coEnableUnicode
    'coAutoInc',               // - coSupportsAutoInc
    'coFldReadOnly',           // - coFldReadOnly
    // Field & Params features:
    'coTrimChar',              // - coTrimChar,
    'coEmptyStrParam',         // - coEmptyStrParam
    'coNullStrParam',          // - coNullStrParam
    'coParDateByLev3',          // - coParamDateByOdbcLevel3
    // Rows Fetch features:
    'coMixedFetch',            // - coMixedFetch
    // ISQLConnection, ISQLCommand features:
    'coLockMode'               // - coLockMode
  );

  cConnectionOptionsTypes: TConnectionOptionsTypes = (
    // Connection features:
    cot_Bool,                  // - coInternalCloneConnection
    cot_UInt,                  // - coBlobChunkSize,
    cot_UInt,                  // - coNetwrkPacketSize,
    cot_Bool,                  // - coReadOnly
    cot_String,                // - coCatalogPrefix
    // Metada features:
    cot_Bool,                  // - coSupportsMetadata,
    cot_Bool,                  // - coSupportsCatalog,
    cot_Bool,                  // - coSupportsSchemaFilter,
    // BindField features:
    cot_Bool,                  // - coMapInt64ToBcd,
    cot_Bool,                  // - coMapSmallBcdToNative,
    cot_Bool,                  // - coIgnoreUnknownFieldType,
    cot_Bool,                  // - coMapCharAsBDE,
    cot_Bool,                  // - coEnableBCD
    cot_Bool,                  // - coMaxBCD
    cot_Bool,                  // - coEnableUnicode
    cot_Bool,                  // - coSupportsAutoInc
    cot_Bool,                  // - coFldReadOnly
    // Field & Params features:
    cot_Bool,                  // - coTrimChar,
    cot_Bool,                  // - coEmptyStrParam
    cot_Bool,                  // - coNullStrParam
    cot_Bool,                  // - coParamDateByOdbcLevel3
    // Rows Fetch features:
    cot_Bool,                  // - coMixedFetch
    // ISQLCommand features:
    cot_Int                    // - coLockMode
  );

  cConnectionOptionsDescs: TConnectionOptionsNames = (
    // Connection features:
    'Use Internal Clone Connection',           // - coInternalCloneConnection
    'Blob Chunk Size',                         // - coBlobChunkSize,
    'Network Packet Size',                     // - coNetwrkPacketSize,
    'Read Only Connection',                    // - coReadOnly
    'Catalog prefix format for odbc '+         // - coCatalogPrefix
      'connection string',
    // Metada features:
    'Supports Metadata',                       // - coSupportsMetadata,
    'Supports Catalog',                        // - coSupportsCatalog,
    'Supports Schema Filter',                  // - coSupportsSchemaFilter,
    // BindField features:
    'Map Int64(Big Int) To BCD',               // - coMapInt64ToBcd,
    'Map SmallBcd To Native',                  // - coMapSmallBcdToNative,
    'Ignore Unknown Field Type',               // - coIgnoreUnknownFieldType,
    'Map Char As BDE',                         // - coMapCharAsBDE,
    'Enable BCD',                              // - coEnableBCD
    'Use Maximum BCD Size',                    // - coMaxBCD
    'Enable Unicode',                          // - coEnableUnicode
    'Supports Auto Increment Fields',          // - coSupportsAutoInc
    'Supports Odbc Field Attribute ReadOnly',  // - coFldReadOnly
    // Field & Params features:
    'Use Trim Char',                           // - coTrimChar,
    'Allow Empty String Parameter',            // - coEmptyStrParam
    'Allow Null String Parameter',             // - coNullStrParam
    'Handling DateTime parameter follow odbc'+ // - coParamDateByOdbcLevel3
    ' Level 2',
    // Rows Fetch features:
    'Use Mixed Fetch',                         // - coMixedFetch
    // ISQLCommand features:
    'Lock Mode'                                // - coLockMode
  );

  cOptionSwitchesNames: TOptionSwitchesNames = ( { Do not localize }
    'osDefault', 'osOff', 'osOn'
  );

  { Character Values of type dxbOpenOdbc.pas:TOptionSwitches }
  cOptCharDefault = 'X'; // = TOptionSwitches.osDefault
  cOptCharFalse   = '0'; // = TOptionSwitches.osOff
  cOptCharTrue    = '1'; // = TOptionSwitches.osOn

type
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

  TOdbcDriverType = (eOdbcDriverTypeUnspecified,
   eOdbcDriverTypeGupta, eOdbcDriverTypeMsSqlServer, eOdbcDriverTypeIbmDb2,
   eOdbcDriverTypeMsJet, eOdbcDriverTypeMySql, eOdbcDriverTypeMySql3,
   eOdbcDriverTypeInterbase, eOdbcDriverTypeInformix, eOdbcDriverTypeOracle,
   eOdbcDriverTypeSybase, eOdbcDriverTypeSQLite, eOdbcDriverTypeThinkSQL,
   eOdbcDriverTypeMerantOle, eOdbcDriverTypePervasive, eOdbcDriverTypeNexusDbFlashFiler,
   eOdbcDriverTypePostgreSQL, eOdbcDriverTypeInterSystemCache,
   eOdbcDriverTypeMerantDBASE, eOdbcDriverTypeSAPDB, eOdbcDriverTypeParadox,
   eOdbcDriverTypeFoxPro, eOdbcDriverTypeClipper, eOdbcDriverTypeBtrieve,
   eOdbcDriverTypeOpenIngres, eOdbcDriverTypeProgress, eOdbcDriverTypeOterroRBase
   );

  TDbmsType = (eDbmsTypeUnspecified,
   eDbmsTypeGupta, eDbmsTypeMsSqlServer, eDbmsTypeIbmDb2,
   eDbmsTypeMySql, eDbmsTypeMySqlMax,
   eDbmsTypeMsAccess, eDbmsTypeExcel, eDbmsTypeText, eDbmsTypeDBase, eDbmsTypeParadox,
   eDbmsTypeOracle, eDbmsTypeInterbase, eDbmsTypeInformix, eDbmsTypeSybase,
   eDbmsTypeSQLite, {Any type is mapped into the text, with maximum length 2048 }
   eDbmsTypeThinkSQL, eDbmsTypeSapDb, eDbmsTypePervasiveSQL,
   eDbmsTypeFlashFiler, eDbmsTypePostgreSQL, eDbmsTypeInterSystemCache,
   eDbmsTypeFoxPro, eDbmsTypeClipper, eDbmsTypeBtrieve, eDbmsTypeOpenIngres,
   eDbmsTypeProgress, eDbmsTypeOterroRBase
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
    function GetLastOdbcSqlState: PAnsiChar;
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
    // 2.015
    function GetCursorPreserved: Boolean;
    // 3.000
    function GetIsSystemODBCManager: Boolean;
    function GetOdbcDriverLevel: Integer;
    function GetSupportsSqlPrimaryKeys: Boolean;
    function GetStatementsPerConnection: Integer;
    // 3.023
    function GetEnvironmentHandle: Pointer;
    function GetConnectionHandle: Pointer;
    function GetOdbcApiIntf: IUnknown; // returned 'OdbaApi.pas:IOdbcApi' interface
  end;

  ISqlCommandOdbc = interface
    ['{136DD9D1-9B9C-4355-9AEF-959662CB095F}']
    procedure Cancel;
    // 2.015
    // Set timeout to the number of seconds to wait for an SQL statement
    function SetQueryTimeOut(TimeOutSeconds: Integer): Boolean;
  end;

resourcestring
  rsNotSpecifiedDNSName = 'The user has not specified "ODBC DNS Name"';

implementation

end.
