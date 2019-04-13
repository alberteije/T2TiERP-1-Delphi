{
  Kylix / Delphi open source DbExpress driver for ODBC
  Version 2.012, 2003-12-11

  Copyright (c) 2001, 2003 Edward Benson

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public License
  as published by the Free Software Foundation; either version 2.1
  of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU Lesser General Public License for more details.
}
unit DbxOpenOdbc;

// Conditional defines can be hard-coded in here, or set using project options dialog
// (Project / Options... / Directories/Conditionals / Conditional defines).

// Compiler options:
// Define _RELEASE_ or _DEBUG_ conditional here or in project options,
// or leave undefined to use global project settings
{.$DEFINE _RELEASE_}
{.$DEFINE _DEBUG_}

{$UNDEF _TRACE_CALLS_}
{$IFDEF _RELEASE_}
  // Release options:
  {$O+} // Optimization on
{$ENDIF}

{$IFDEF _DEBUG_}
  // Debug options:
  {$O-} // Optimization off
  {$D+,L+} // Include Debug Info
  {.$DEFINE _TRACE_CALLS_} // logging of calls (optional)
{$ENDIF} //of: {$IFDEF _DEBUG_}

{$INCLUDE DbxOpenOdbc.inc}

{.$DEFINE _MULTIROWS_FETCH_}
// Explanation of _MULTIROWS_FETCH_
// Support for ODBC "block fetching" (SQL_ATTR_ROW_ARRAY_SIZE)
// Not all ODBC drivers support this mode (SQL_GD_BLOCK).
// We automatically query the ODBC driver to check if it supports this option,
// so you can safely include this option and block fetching will be used if
// the ODBC driver supports it.
// Even if the ODBC driver indicates that it supports block fetching,
// block fetching cannot be used if there are any late-bound fields in the query
// (large fields e.g. MEMO, BLOB are normally late-bound).
// If you have late-bound fields, and you want to use block fetching, you will need
// to use _MIXED_FETCH_ option in addition to _MULTIROWS_FETCH_ (see below).

{.$DEFINE _MIXED_FETCH_}
{$IFDEF _MIXED_FETCH_}
  {$IFNDEF _MULTIROWS_FETCH_}
    {$MESSAGE  Warn '_MIXED_FETCH_ ignored because _MULTIROWS_FETCH_ not defined'}
  {$ENDIF}
{$ENDIF}
// Explanation of _MIXED_FETCH_
// (This option only applies if _MULTIROWS_FETCH_ is also set.)
// Set the _MIXED_FETCH_ option if you you want to use block cursors for queries
// with late-bound fields (i.e. large fields).
// For fetching late-bound columns the following ODBC API functions are used:
// SqlBindCol + SqlSetPos + SqlGetData.
// If you have late-bound fields and you want to use block fetching,
// it is necessary to use a static cursor (SQL_CURSOR_STATIC), whereas normally
// we use the more efficient forward-only cursor (SQL_CURSOR_FORWARD_ONLY).
// But with the forward-only cursor, block fetching is not possible if the are
// and late-bound columns.
// You can dynamically control this parameter by using the connection parameter
// coMixedFetch. You can change this parameter before execution of query.
//
// Warnings:
//
// - Static and keyset-driven cursors increase the usage of tempdb. Static server cursors
//   build the entire cursor in tempdb; keyset-driven cursors build the keyset in tempdb.
//
// - Some ODBC drivers incorrectly handle this mode of operation.
//   We have detected bugs with the following drivers:
//   PervasiveSQL ODBC, Version: '08.10.0117 017'.
//   Microsoft SQL 2000, version '08.00.0194'.
//   (In Developer Edition version '08.00.0384' this error is already not present).
//
// - When the ODBC driver does not support SQL_GD_ANY_COLUMN, and you have large fields,
//   it is more efficient to specify the simple fields before large fields (MEMO, BLOB)
//   in the select statment, because all fields beyond the first large field will be late-bound.
//
// You can adjust support of this adjustment separately for each driver.
// Look for procedure RetrieveDriverName.
//

{$DEFINE _RegExprParser_}
{$IFDEF _DisableRegExprParser_}
  {$UNDEF _RegExprParser_}
{$ENDIF}
// Explanation of _RegExprParser_
// For Informix multi-part names, this option must be defined
// For any other RDBMS, can be defined not not essential
// When defined, multi-part table names are parsed using DbxObjectParser
// (which itself uses RegExpr module by Andrey V. Sorokin / Henry Spencer)

{$DEFINE _InternalCloneConnection_}
{$IFDEF _DisableInternalCloneConnection_}
  {$UNDEF _InternalCloneConnection_}
{$ENDIF}
// Explanation of _InternalCloneConnection_
// If the DBMS limits the number simultaneous statements per connection,
// DbExpress will clone the connection externally where necessary.
// If _InternalCloneConnection_ is defined, we report to DbExpress that
// statements per connection are unlimited, and automatically clone a
// new connection internally where necessary. This is particularly useful
// for prompted connects, because we hold the connection string returned by
// the first connect, and we use this for the subsequent cloned connects, so
// the user is prompted only once for connect info. (This is also needed for
// old version of DbExpress which query max simultaneous statements before
// any connect, but Borland fixed this in Delphi 6 SP2.)

interface

uses
  DbxOpenOdbcInterface,
  OdbcApi,
  DBXpress,
  {$IFDEF LINUX}
    {.$IFDEF _K1UP_}
      Types,
    {.$ENDIF IFDEF _K3UP_}
  {$ENDIF IFDEF LINUX}
  {$IFDEF _RegExprParser_}
      DbxObjectParser,
  {$ENDIF}
  {$IFDEF _TRACE_CALLS_}
    DbxOpenOdbcTrace,
  {$ENDIF _TRACE_CALLS_}
  Classes;

{
  Kylix / Delphi DbExpress driver for ODBC Version 3 drivers
  (Also works with ODBC Version 2).

  Normally SqlExpress loads the driver DLL dynamically (ie dbxoodbc.dll),
  according to TSQLConnection.LibraryName.

  Alternatively if you add this unit to a USES anywhere in your project,
  the driver will be statically linked into your program and SqlExpress will
  ignore TSQLConnection.LibraryName. (This magic is achieved by the call to
  SqlExpr.RegisterDbXpressLib in the initialization section of this unit, but
  it only works in Windows - in Kylix SqlExpr.RegisterDbXpressLib is not defined)

  The project source for DLL version is 'dbxoodbc.dpr', which just
  USES this module and EXPORTS the getSQLDriverODBC function.

  ------------------------------------------------------------------------------

  Steps to manually install new DBExpress driver
  (This is not really necessary - it just makes it easier to change drivers, by
  selecting TSQLConnection.DriverName and TSQLConnection.ConnectionName drop-down)

  1. Retrieve DbExpress INI file names from registry
     '\Software\Borland\DBExpress' Value 'Driver Registry File'
     (The default ini file names will be:
      C:\Program Files\Common Files\Borland Shared\DBExpress\dbxdrivers.ini)
      C:\Program Files\Common Files\Borland Shared\DBExpress\dbxconnections.ini)

  2. In dbxdrivers.ini file

  a. Add line to '[INSTALLEDDRIVERS]' section
       drivername=1 (eg 'Dbx Open Odbc Driver=1') (The driver name can be any name you like)

  b. Add new [drivername] section ie [Dbx Open Odbc Driver], with following 3 lines
       LibraryName=dbxoodbc.dll        (Not case-sensitive in Windows)
       GetDriverFunc=getSQLDriverODBC  (NB This is case-sensitive, even in Windows)
       VendorLib=ODBC32.DLL            (Value not actually used by this driver - ODBC32.DLL is hard-coded)

  3. In dbxconnections.ini file

  a. Add '[ConnectionName]' section with following 4 lines
       DriverName=Dbx Open Odbc Driver (or whatever you called it in dbxdrivers.ini)
       Database=ODBC DSN name, or ODBC connection string, or ? for Driver Prompt
       User_Name=user name (this can be ommitted)
       Password=password (this can be ommitted)

  b. You can have as many different [ConnectionName] sections as you like, so
     you can pre-configure several ODBC connection settings.

  If you skip the install, you must set TSQLConnection properties
  before you connect:
    .LibaryName = dbxoodbc.dll (must be fully qualified if not on the search path)
    .GetDriverFunc = getSQLDriverODBC (NB this is case-sensitive)
    .VendorLib = ODBC32.DLL
    .Params - As described dbxconnections.ini above - Database is required, others optional
}

{
  Note on Error checking:

  In this driver almost every function that implements the various
  DBXpress interfaces is guarded by "try / except".

  If an error occurs, an EDbxError exception of one of the following sub-types is rasied:

    EDbxOdbcError: An error was returned from an ODBC function call
    EDbxInvalidCall: The function or its parameters are not valid
    EDbxNotSupported: The function or its parameters are valid but not yet supported by this driver
    EDbxInternalError: Some other error occurred with this module

  Control then goes to the Except routine in the relevant interface functuon.

  If EDbxNotSupported can happen, this is always checked first, and the
  function returns DBXERR_NOTSUPPORTED, so the caller can take action as necessary.

  Otherwise the EDbxError handler gets invoked (because EDbxError is the parent
  class of the other 3 exception types). The handler retrieves the Exception message,
  saves it in an instance variable (occasionally some other info is also saved),
  and then the function returns MaxReservedStaticErrors + 1.
  The caller can get the error text (via GetErrorMessage/Len) and raise its own
  error or ignore, as appropriate.

  The reason for raising and trapping EDbxError, rather than simply returning
  non SQL_SUCCESS code, is that the calling programs may not always check
  the function return code, or it may check for error code but retrieve the error
  message from the wrong interface. So by raising exception at the point of
  error, the IDE halts on the exception during source debugging, and this makes
  it much easier to trace errors.
}

{
  Note to contributors

  DO NOT REFORMAT EXISTING CODE

  Not only is it impolite, but (more importantly) it obscures the 'real' changes.
  Also, it is a waste of time, because I will change any reformatting back again.

  Here are the formatting rules --

  As closely as possible, follow Borland formatting conventions.
  For this, run code though DelForExp (Delphi Formatting Expert),
  set with "Borland Style", but wrap lines at position 100.

  Variable naming and capitalization:
  Use lowercase for reserved words (as per Borland standard) [N.B. "string" is a reserved word!]
  Use "infix caps" (also known as "Pascal capitialzation") for identifiers.
  In this convention, each word within variable starts with uppercase, example, MyVariableName.
  In the standard used in this project, acronyms are treated as single words,
  example - MySqlOdbcDbxVariableName (NOT MySQLODBCDBXVariableName)
  Common type names are treated as single words, not two words,
  example, Smallint, Timestamp (not SmallInt, TimeStamp)
  American English spellings are used, not British English,
  examples, Color, License, Synchronize (not Colour, Licence (as a noun), Synchronise).

  Exceptions to "infix" caps:
  Our class member variables begin lowercase "f"
  (Because then the difference between a method and a field is more distinct)
  Our procedure local variables may begin lowercase or uppercase (eg i, aTempVar, or TempVar)

  Where names come from a pre-defined header, (eg, Interface method names in DBXpress.pas,
  or names in OdbcApi.pas), we always follow capitalization of the header file, even if it
  is inconsistent (eg ISQLCommand.close, ISQLCommand.getParameter, ISQLCommand.GetOption).

{
Change History

Beta, 2001-10-26 [ Edward Benson ]
----------------------------------
+ First public release

Version 1.01, 2001-11-28  [ Edward Benson ]
-------------------------------------------
+ Fix bug in TSqlCursorMetaDataIndexes
+ Support Interbase 6 Easysoft ODBC Driver
+ Support MySql ODBC Driver (ODBC level 2)

Version 1.02, 2001-12-05 [ Edward Benson ]
------------------------------------------
+ Fix bug in TSqlCursorOdbc.getBcd to cater for comma decimal separator

Version 1.03, 2001-12-06 [ Edward Benson ]
------------------------------------------
+ Change to support Kylix
  (fixes posted by Ivan Francolin Martinez)

Version 1.04, 2002-01-22 [ Edward Benson ] (Not released to public)
------------------------------------------
+ Internally clone connection for databases that only support 1 statement
  handle per connection, such as MsSqlServer
  (maintain internal connection cache for such databases, until disconnected)
+ Work around MySql bug - odbc driver incorrectly reports that
  it supports transactions when it doesn't
+ More changes to support Kylix (in OdbcApi.pas)
  (fixes posted and tested by Ivan Francolin Martinez)
+ Allow for blank column names (returned by Informix stored procedures)
  (fix posted and tested by Bulent Erdemir)

Version 1.05, 2002-06-09 [ Edward Benson ] (Not released to public)
------------------------------------------
+ Change to support TIMESTAMP parameters
  (fix posted and tested by Michael Schwarzl)
+ Work around to support multiple GetBlob calls for MS SqlServer
  (fix posted and tested by Michael Schwarzl)
+ Work around for Delphi 6.02 -
  SqlExpress now calls ISqlCommand.SetOption(RowSetSize) for all drivers
+ Fix TSqlCursorOdbc functions: isReadOnly, isAutoIncrement, isSearchable
  Were incorrectly using ColNo-1 (ie 0-based) - ODBC column indexes are 1-based
  (Confusing, because the bind array (fOdbcBindList) is 0-based)
+ eOdbcDriverTypeAccess renamed eOdbcDriverTypeMsJet
  (MsJet driver works for other databases, not just Access)

Version 1.06, 2002-11-01 [ Edward Benson ] (Prepare for Vadim's changes)
------------------------------------------
+ Reformatted comments and code, so diff shows up changes for 2.00
}

{+2.01 WhatNews}
(*
Version 2.01, 2002-11-01 (Vadim Lopushansky)
------------------------

Edward> + below means I have included Vadim's change,
Edward> - means I have not

  + Change to support Delphi7. See block: {$IFDEF _D7UP_}.
  + Change to support INFORMIX (tested on version IDS 7.31 TD3).
  + Change to support ThinkSQL (tested on version 0.4.07 beta. http://thinksql.com/).
  + Change to detect database types for Multiplatform DataDirect ODBC Drivers
    (http://www.datadirect-technologies.com)
  - Change to detect database type method TSqlConnectionOdbc.RetrieveDriverName.
    For detecting usage specific RDMS query.
    Edward> I have not included this:
    Edward> I think it is better to use SQLGetInfoString(SQL_DBMS_NAME) instead
  + Change to remapping Int64 to BCD
    (optional. Connection parameter: "Database"="...;MapInt64ToBcd=1"
    or "Custom String"="...;MapInt64ToBcd=1")
  + Change to remapping small BCD to native
    (optional. Connection parameter: "Database"="...;MapSmallBcdToNative=1"
    or "Custom String"="...;MapSmallBcdToNative=1"))
    Is problem in editing controls when native type length is more then BCD data type length.
    For editing you mast usage controls with format string...
  + Change for addition of possibility of disconnecting of support of the metadata.
    Is used in case of availability of errors in the ODBC driver.
    For disconnecting the metadata it is necessary to add to connection line Metadata=0
    (Connection parameter: "Database"="...;Metadata=0"  or "Custom String"="...;Metadata=1").
  + Change to updating BCD values when DecimalSeparator <> '.'
  + Change to reading of PK_INDEX from metadata (Calculating fPkNameLenMax).
    For an example look: ($DELPHI$)\Demos\Db\DbxExplorer\dbxexplorer.dpr
    (Read PKEY_NAME error).
    All metadata fields returned length more 0.
  + Change in %Metadata%.getColumnLength:
    Adapting to calculate visible of columns in SqlExpr.pas type.
    For an example look: ($DELPHI$)\Demos\Db\DbxExplorer\dbxexplorer.dpr
    (Read procedure parameters position error).
  + Change to remove warnings and hints.
  + Change to Access Violation code
    (When returned column precision from LongWord to Smallint type when
    precission is more High(smallint), ... )
  + Change to setting metadata position for bad odbc driver
    (Read of columns information with the "Easysoft Interbase ODBC Driver"
     version 1.00.01.67 on example "dbxexplorer.dpr").
  + Changes when QuoteChar=' '.
    In this situation QuoteChar must be empty (''). (MSSQL, Informix,...)
    ( Edward> ???Ed>Vad/All: But I think MSSQL uses doublequote char ("), not blank. )
  + Change to support Trim of Fixed Char when connection parameter "Trim Char" is True
    or when connection parameter: Database=...;TrimChar=1.
    The mode 1 - allows to work in the mode compatible
    with the "BDE" mode for "FixedChar" of strings.
    Mode 0 - is default - the strings of fixed width are not truncating.
  + New SchemaFilter parameter in login parameter "Custom String".
    This parameter allows to filter the metadata of the only current scheme.
    By default filtering is on for: Oracle.
    If it does not settle - disable filtering through the parameter of connection:
    Custom String=...;SchemaFilter=0
  + Change to autodetect ODBC driver level mode 2.
  + Change to autodetect SupportsCatalog Options.
    Warning: Some of the driver is illconditioned work with this option.
    For example do not return an error at installation of a unknown of the catalog.
    From behind it the procedure of installation of the catalog was received
    cumbersome and depending from database.
    But you have possibility of load shedding of support of the catalog.
    Read further about parameter of Catalog...
  + The possibility is supplemented to disable support of the
    'Catalog option. Database=...;Catalog=0
  + Change to increase of speed of blob fetching.
    Database or "Custom String" parameter "BlobChunkSize".
    In Bytes. Define size blob buffer for loop-fetching.
    The size of a cache can be synchronized with a size of a cache assigned in the ODBC driver.
  + Vadim> ???Vad>All: Change to support Odbc driver attribute SQL_ATTR_PACKET_SIZE.
    Edward> Very good! Although I think it is not advisable to ever change this,
    Edward> Borland has seen fit to add it as an option, so we should implement it.
    For support this attribute you must define value it parameter in
    "Custom String" (Delphi 7) or "Database" (Delphi 6, 7)
    "Custom String"="...;ConPacketSize=8192";
    Database="..;ConPacketSize=8192"
    ConPacketSize should not be less than 4096. The upper range is defined by the driver.
  - Database or "Custom String" parameter "DriverLevel"
    user defined ODBC driver level mode.
    Edward> Now removed - we now auto-detect driver level
  - Change in ParseTableName for parsing in informix ...
    Warning: Probably and for other database servers it is necessary to change
    in view of their format of the job(definition) of a full name of the table.
  + Ignoring of exceptions for want of indexes.
  + It is possible at call to the tables from other spaces (catalog, servers, references).
    (Edward> what do you mean?)
  + The possibility of the external definition of parameters of the driver
    is supplemented (Catalog,TrimChar,BlobChankSize).
      Examples:
        Delphi 7:
          Custom String=;Catalog=0;TrimChar=1;MapInt64ToBcd=1;SchemaFilter=1;
           Metadata=0;MapSmallBcdToNative=0;BlobChunkSize=32768
        Delphi 6 (also will work for Delphi 7):
          Database=DSN=DBDEMOS;UID=anonymous;PWD=unknown;
           TrimChar=1;BlobChunkSize=32768;ConPacketSize=3072
  - Change in "SqlExpr.pas" (Delphi 6,7):
     Change for reading of metadata when ODBC driver supported
     only one sql statement (MSSQL...).
     Change for support of the "connection string with prompt" '?'
     when need clone connection.
     For more detail look then file WhatNews.Txt.
    (Edward> I have done this by internally cloning the connection to handle this case)
  + All changes are included in the block:
      //                                   {+ver Optional description}
      //                                   ... new or changed code
      //                                   {/+ver /Optional description}
*)
{/+2.01 /WhatNews}

{+2.02 WhatNews}
(*
Version 2.02, 2002-11-04 [ Vadim V.Lopushansky pult@ukr.net ]
------------------------

      All changes are concluded in the block:
      {+2.02 Optional Description}
       ... new or changed code
      {/+2.02 /Optional Description}

+ added suported INTERVAL types as Fixed Char
  (look SQL_INTERVAL_YEAR or SQL_INTERVAL_MINUTE_TO_SECOND )
+ added optiong for ignoring of uknknown field types
  (look coNoIgnoreUnknownFieldType and IgnoreUnknownType )
  Connectin parameter: Database=...;IgnoreUnknownType=1
  or parameter "Custom String"="...;IgnoreUnknownType=1"
  Default is False(0) except informix. For informix=True(1)
+ Set default isolation to DirtyRead (look SQL_TXN_READ_UNCOMMITTED) (???)
- ??? Set default CURSOR BEHAVIOR to PRESERVE MODE. !!! Has failed !!!
(look SQL_CURSOR_COMMIT_BEHAVIOR) (???)
+ detect RDBMS types ( you can analyze RDBMS name, major and minor version, and client version )
*)
{/+2.02 /WhatNews}

{
Version 2.03, 2002-11-20 [ Edward Benson ]
------------------------
{
+ Split ISqlConnectionOdbc out to new module, DbxOpenOdbcInterface.
  This allows you to call the new methods of ISqlConnection,
  but without having to statically link in this module.
  (See QueryInterface comments in DbxOpenOdbcInterface on how to do this).

{+2.04 WhatNews}
(*
Version 2.04, 2002-12-19 [ Vadim V.Lopushansky pult@ukr.net ]
------------------------
+ Regular Expression Parser for Decode/Encode different DBMS object name format.
  Usage of this capability is adjusted(regulated) in parameter: {$define _RegExprParser_}
  It option can be turned off.

  If for your DBMS the off-gauge format of the definition of a full name of the object of DBMS,
  to you is necessary to describe the template of this format in the file "DbxObjectParser.pas".
  For debugging your template you can take advantage of an example from "RegExprParser.zip".

+ The capability of mapping of text fields into memo field is added as it is made in BDE:
  the fields with lengthy more than 256 characters are imaged on BlobMemo
  (optional. Connection parameter: "Database"="...;MapCharAsBDE=1"
    or "Custom String"="...;MapCharAsBDE=1")
*)
{/+2.04 /WhatNews}
{
Version 2.041, 2003-01-15 [ Dmitry Arefiev <darefiev@da-soft.com> ]
------------------------
+ Dmitry Arefiev <darefiev@da-soft.com>
  Some AV fixed in:
   TSqlCursorOdbc.BindResultSet
   TSqlCursorMetaDataIndexes.getString

Version 2.042, 2003-02-05 [ Vadim V.Lopushansky pult@ukr.net ]
------------------------
+ Alteration of implementation for ConnectionOptions
+ Cannot disconnect when inTransaction and fAutoCommitMode = SQL_AUTOCOMMIT_OFF.
   INFORMIX, MSACCESS:
   ERROR: SQLDisconnect(fhCon) returned error
   example:
    SQLCon.Open;
    SQLCon.StartTransaction(...;
    SQLQuery.Open;
    SQLCon.Close; // <- ERROR: SQLDisconnect(fhCon) returned error
+ The procedures are changed:
    - procedure FreeHCon
    - procedure FreeHStmt
      The clearing of the parameter SQLHDBC/SQLHSTMT is added.
+ Variables of types (SQLHDBC,SQLHSTMT) i compare with "SQL_NULL_HANDLE", instead of with "nil".
+ Optimization of speed by replacement:
  -----
    OdbcCheck(...)
  -----
  to
  -----
    if OdbcRetCode < > OdbcApi.SQL_SUCCESS then
      OdbcCheck(...)
  -----
+ Possibility of disconnecting of processing of a situation with hidden cloning of connections
  at limitation on quantity of simultaneous cursors. Search for an option
  $define _DisableOverloadCloningConnection_
+ The procedure "setParameter(.." are changed.
+ New Connection Option: "EmptyStrParam"
  Some ODBC of the driver do not handle a situation, when the string has zero length. For them it
  was necessary to write in the code following:
  procedure TForm1.DataSetBeforePost((DataSet: TDataSet);
  begin
    if Length(DataSet.FieldByName('customer').AsString) = 0 then
      DataSet.FieldByName('customer').Clear;
  end;
  To avoid it, now it is enough in connection string to indicate EmptyStrParam=0

Version 2.043, 2003-02-11 [ Vadim V.Lopushansky pult@ukr.net ]
------------------------
+ MSSQL SERVER: The situation with a mistake of cloning connection is corrected at connection
  through PIPE.
  ODBC Driver: SQL Server, version: 2000.81.9030.04.
  The problem consists that at connection through PIPE ODBC Driver returns a non-working line
  of connection (prevents option Network).

Version 2.05, 2003-04-04 [ Edward Benson ]
------------------------
+ Reformatting to agreed standard only.
  No functional changes.
  Release to CVS, to so we can see real functional DIFFs between next version and 2.043

Version 2.06, 2003-04-22 [ Edward Benson ]
------------------------
+ Use CompilerVersion instead of VERxxx to determine Compiler Version - this is more future-proof
+ Show Sql command text (if available) in GetErrorMessage
+ Show parameter values (if available) in GetErrorMessage
+ Show Sql Connect string (but with hidden password) in GetErrorMessage
+ Allow for Input, Output, Inout and Return parameters
+ Allow for transaction isolation level to be specified in ISQLConnection.beginTransaction
+ Reformat some exception messages
+ After SqlCloseCursor, add ODBC calls to UNBIND cursor bind vars and RESET parameters
+ Rollback outstanding transaction on disconnect, in case where concurrent statements
  per connection not unlimited (Vadim Lopushansky)
+ Conditional compilation for Kylix 3 [Kurt Fitzner / Stig Johansen]
+ TSqlCursorMetaData.isSearchable no longer raises error (Dmitry Arefiev)
+ Rename conditional (not) _DisableOverloadCloningConnection_ to _InternalCloneConnection_
+ Procedure FreeHCon changed from (out HCon: SqlHDbc) to (var HCon: SqlHDbc) [Stig Johansen]
+ Fix problem with TSqlCommandOdbc.SetParameter for fldFLOAT [Stig Johansen]
+ Do not call SQLGetStmtOption(SQL_ROWSET_SIZE) -- it does nothing [Stig Johansen]
+ In TSqlCommandOdbc.Destroy add check for statement already freed [Stig Johansen]

Version 2.07, 2003-05-07  [ Vadim V.Lopushansky pult@ukr.net ]
------------------------
+ Some critical errors have been corrected. (Uncorrect call FillChar, ...).
+ Added the possibility of watching of a sequence of calls of methods. See directive "_TRACE_CALLS_".
+ Tracing can be applied for watching problems with new drivers or DBMS.

Version 2.08, 2003-10-30  [ Vadim V.Lopushansky pult@ukr.net ]
------------------------
+ Fixed FetchLateBoundData and FetchLongData. There can be errors, when connection
  option coIgnoreUnknownFieldType is turned ON and query contained unsupported
  field type and fetching usage  LateBoundFound method for field located after
  unsupported field.
+ Fixed set SQL_VARCHAR parameter with length>255.
  AV: the reason - record outside the allocated memory.
+ Added access to INFORMIX LOB fields (not fully tested).
+ Fixed BcdToStr from FMTBcd.pas. See QC: 6169.
+ Release fhCon at disconnecting reconciled in impossibility of a reconnecting.
+ Fixed SQLite field mapping
+ Added checking of reasonableness of field size (returned from odbc driver) for next SQLTypes:
  SQL_CHAR, SQL_VARCHAR, ... SQL_BINARY, SQL_VARBINARY, SQL_LONGVARCHAR, SQL_WLONGVARCHAR
+ Added limitation to BindBufferSize for simple types:
  SQL_BINARY, SQL_VARBINARY,
  SQL_CHAR, SQL_VARCHAR ...
  It is handled only when fCommandBlobSizeLimitK<=0 (When it is possible to apply OdbcLateBound).
+ Added support in MSSQL sql_variant field type: SELECT value FROM "dbo"."sysproperties"
  But you can usage the next code for accessing:
  http://www.novicksoftware.com/UDFofWeek/Vol1/T-SQL-UDF-Volume-1-Number-12-udf_SQL_VariantToDatatypeName.htm
+ Set ConPacketSize for Cloned Cnnection
+ Fixed when transaction not supported
+ Fixed Connect: Removal of user options is made of a line of connection before its analysis.
+ Fixed Fetch Bytes Fields. Has been skipped FetchLateBoundData.
+ Added support of fldVARBYTES.
+ Fixed SortOrder. Must be in Upper Case.
+ Fixed indexing for TClientDataSet. Index cannot be unnamed (Very impotent for PK and Unique indexes).
+ Fixed Create RegExp Parser when QuoteChar = #0
+ Added support for:
    Pervasive.SQL (odbc ver: '8.10.117.17'),
    PostgreSQL (odbc ver: '7.03.01.00'),
    Cache`.
+ Added the opportunity to collect the driver in younger version Delphi for the senior version.
  Access to new opportunities now are accessible and in younger versions Delphi.
+ Added demo application: ODBC Explorer.

Version 2.09, 2003-10-31  [ Vadim V.Lopushansky pult@ukr.net ]
------------------------
+ Added usage of one buffer of memory for all types with a known size.
+ Added support BLOCK FETCHING options:
   eCommBlockRead (default=True),
   eCommRowsetSize (default in SqlExp=20).
  *****************************************************************
  *** Added support ODBC option: SQL_ATTR_ROW_ARRAY_SIZE !!!    ***
  *** It mapped to standard connection option: eCommRowsetSize. ***
  *****************************************************************
  Main changes: BindResultSet, Next, SetOption(eCommRowsetSize,...), connect

Version 2.010, 2003-11-06  [ Vadim V.Lopushansky pult@ukr.net ]
------------------------
+ Fixed procedure .next() for 'ARRAY FETCH' when the driver returns lines less than should.
  For example SAP DB ' ODBC Driver, ver: '7.04.03.00' always returns only one line at any
  set of rows.
+ Fixed TextFile(*.txt, *.csv) Table Name parsing. TableName can contain the '.'.
+ Fixed SQLite update/fetch BLOB (Memo) data types.
New/Changed options:
+ Added option "ENABLEBCD". In this option any BCD is mapped to Float.
+ Added mapping unsupported BCD Size to Float. See MaxFMTBcdDigits in FMTBcd.pas
+ Added MAXBCD option. For this option any BCD is mapped to BCD(32,??).
  It is possible for using in a case when the driver returns the incorrect column info.
+ Added check BCD Oveflow for procedure .getBCD(). Uncorrect values are trimmed.
+ Added default driver option. You can set default driver value at any time for any properties.
  For  make it you must set option value to 'X':
  example:
    SQLConnection1.SQLConnection.SetOption(
      TSQLConnectionOption(xeConnCustomInfo), Integer(PChar('MAXBCD=X')) );
New supported odbc drivers:
+ Added support for 'SAP DB ODBC Driver', ver: '7.04.03.00'
+ Added support for Firebird 'IBPhoenix ODBC Driver': http://www.ibphoenix.com/, ver: '01.00.0000'
  There were problems for the some Float fields.
+ Added support for 'XTG System Open Source Firebird, Interbase6 ODBC Driver':
  http://www.xtgsystems.com/, ver: '1.00.00.16'
  At use of this driver for function RowsAffected you will always receive 0 as the driver
  does not realize function SQLRowCount. From for it by transfer of changes to a DB by means
  of DSP you will receive mistakes: 'Record not found or changed by another user'. In part
  this problem can be solved as it is made in example OdbcExplor.dpr
  Also this driver returns bad columns Size(fColSize) for BCD field.
+ Added support for 'MERANT DBASE ODBC Driver', ver: '3.60.00.00'.
  Fixed .FetchIndexes() for it driver. The driver returns fields for an index as their concatenation
  (with a separator '+'). Example: 'fieldA+fieldB'.

Version 2.011, 2003-12-09   [ Vadim V.Lopushansky pult@ukr.net ]
-------------------------
+ Parse ConnectionString connection option (Delphi 7) and also the normal connection string,
  and if they BOTH contain "DATABASE=" we use replace the database value with
  the value from the ConnectionString option.
  eg, if normal connection string is "DSN=MyDsn;DATABASE=MyDb"
  and ConnectionString is "DATABASE=OtherDb",
  then the Odbc connect string will become "DSN=MyDsn;DATABASE=OtherDb"
  I think that's what it does.
  But I don't know why Vadim has added this.
+ Extra tracing
+ coIgnoreUnknownFieldType default value is ON

Version 2.012, 2003-12-10  [ Edward Benson ]
-------------------------
+ Simplify explanations of _MIXED_FETCH_ and _MULTIROWS_FETCH_
+ coIgnoreUnknownFieldType default value is OFF
  except Informix, which has default value ON.
+ _DENT_ conditional define [Dmitry Arefiev]

TODO:

- MS SQL Server ODBC Error:
    If in options ODBC alias to clean the checkbox " Use ANSI quoted identifiers ", then metadata
    in OdbcTest3.exe will be all the same taken in inverted commas "". But performance of inquiries
    of type:
      select * from "dbo." "syscolumns"
    will be impossible. Probably a mistake in ODBC driver - it should not return a quoting
    character !!!

    Line:
      OdbcRetCode := SQLGetInfoString(fhCon, SQL_IDENTIFIER_QUOTE_CHAR, @GetInfoStringBuffer, ...
    returned:
      GetInfoStringBuffer[0]=='"'

- INFORMIX:
  LVARCHAR field "m2" cannot be changed:

  function TSqlCommandOdbc.setParameter(
    ...
    fldBLOB:
    ...
      fOdbcParamSqlType := SQL_LONGVARCHAR;
    Does not work CDS.ApplyUpdates for a field of type SQL_VARCHAR (in Database LVARCHAR):
      Error: ... no cast from text to lvarchar.

  If to specify fOdbcParamSqlType := SQL_VARCHAR that updating for this type of a field will pass,
  but for SQL_LONGVARCHAR will cease to work.

  Example table:
  CREATE TABLE test
  (
   id SERIAL,
   m1 TEXT,
   m2 LVARCHAR,
   m3 BLOB
  );
  alter table test add constraint primary key (id) constraint ct_pr_test0;

  BLOB field "m3" cannot be changed:
  ERROR:
  Error returned from ODBC function SQLExecute
  ODBC Return Code: -1: SQL_ERROR
  ODBC SqlState:        HY000
  Native Error Code:    -609
  [Informix][Informix ODBC Driver][Informix]Illegal attempt to use Text/Byte host variable.

}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

{ getSQLDriverODBC is the starting point for everything else... }

function getSQLDriverODBC(sVendorLib: PChar; sResourceFile: PChar; out Obj): SQLResult; stdcall;

exports getSQLDriverODBC;

{ Connection Extended Options }

type

  TOptionSwitches = (osDefault, osOff, osOn);
  TConnectionOption = (
    coSupportsMetadata,
    coSupportsSchemaFilter,
    coTrimChar,
    coMapInt64ToBcd,
    coMapSmallBcdToNative,
    coSupportsCatalog,
    coIgnoreUnknownFieldType,
    coMapCharAsBDE,
    coEmptyStrParam,
    coMixedFetch,
    coEnableBCD,
    coMaxBCD
    );
  TConnectionOptions = array[TConnectionOption] of TOptionSwitches;
  PConnectionOptions = ^TConnectionOptions;
  TConnectionOptionsNames = array[TConnectionOption] of string;

const

  { Default Connection Extended Options }
  cConnectionOptionsDefault: TConnectionOptions = (
    osOn,  // - coSupportsMetadata
    osOff, // - coSupportsSchemaFilter
    osOff, // - coTrimChar
    osOn,  // - coMapInt64ToBcd
    osOff, // - coMapSmallBcdToNative
    osOn,  // - coSupportsCatalog
    osOff, // - coIgnoreUnknownFieldType
    osOff, // - coMapCharAsBDE
    osOff, // - coEmptyStrParam
    osOff, // - coMixedFetch
    osOn,  // - coEnableBCD
    osOff  // - coMaxBCD
    );

  cConnectionOptionsNames: TConnectionOptionsNames = (
    'METADATA', // - coSupportsMetadata,
    'SCHEMAFILTER', // - coSupportsSchemaFilter,
    'TRIMCHAR', // - coTrimChar,
    'MAPINT64TOBCD', // - coMapInt64ToBcd,
    'MAPSMALLBCDTONATIVE', // - coMapSmallBcdToNative,
    'CATALOG', // - coSupportsCatalog,
    'IGNOREUNKNOWNTYPE', // - coIgnoreUnknownFieldType,
    'MAPCHARASBDE', // - coMapCharAsBDE,
    'EMPTYSTRPARAM', // - coEmptyStrParam
    'MIXEDFETCH', // - coMixedFetch
    'ENABLEBCD', // - coEnableBCD
    'MAXBCD'
    );
  // Advanced parameters name (no boolean parameters):

  cBlobChunkSize: string = 'BLOBCHUNKSIZE';
  cConPacketSize: string = 'CONPACKETSIZE';

  cBlobChunkSizeDefault = 40960;
  cConPacketSizeDefault = 4096;
  cBlobChunkSizeLimit = 1024 * 1000;
  DbxOpenOdbcVersion = '2.012 (2003-12-10)';

  cOptCharFalse = '0';
  cOptCharTrue = '1';
  cOptCharDefault = 'X';

type

  TSqlConnectionOdbc = class;
  TSqlCommandOdbc = class;

  TSqlDriverOdbc = class(TInterfacedObject, ISQLDriver)
  private
    //fErrorLines: TStringList;
    fSQLCallbackEvent: TSQLCallbackEvent;
    fDbxOptionDrvCallBackInfo: Longint;
    fDrvBlobSizeLimitK: Integer;
    fOdbcErrorLines: TStringList;
    fhEnv: SqlHEnv;
    fNativeErrorCode: SqlInteger;
    fSqlStateChars: TSqlState; // 5 Chars long + null terminator
    fDbxOptionDrvRestrict: Longword;

    procedure AllocHCon(out HCon: SqlHDbc);
    procedure AllocHEnv;
    procedure FreeHCon(var HCon: SqlHDbc);
    procedure FreeHEnv;
    procedure RetrieveOdbcErrorInfo(
      CheckCode: SqlReturn;
      HandleType: Smallint;
      Handle: SqlHandle;
      Connection: TSqlConnectionOdbc;
      Command: TSqlCommandOdbc);
    procedure OdbcCheck(
      CheckCode: SqlReturn;
      const OdbcFunctionName: string;
      HandleType: Smallint;
      Handle: SqlHandle;
      Connection: TSqlConnectionOdbc = nil;
      Command: TSqlCommandOdbc = nil);
  protected
    { begin ISQLDriver methods }
    function getSQLConnection(
      out pConn: ISQLConnection
      ): SQLResult; stdcall;
    function SetOption(
      eDOption: TSQLDriverOption;
      PropValue: Longint
      ): SQLResult; stdcall;
    function GetOption(
      eDOption: TSQLDriverOption;
      PropValue: Pointer;
      MaxLength: Smallint;
      out Length: Smallint
      ): SQLResult; stdcall;
    { end ISQLDriver methods }
  public
    constructor Create;
    destructor Destroy; override;
    procedure Drivers(DriverList: TStrings);
  end;

  PConnectionStatement = ^TConnectionStatement;
  TConnectionStatement = record
    fHCon: SqlHDbc;
    fHStmt: SqlHStmt;
  end;

  { TSqlConnectionOdbc implements ISQLConnection }

  TSqlConnectionOdbc = class(TInterfacedObject, ISQLConnection, ISqlConnectionOdbc)
  private
    fConnectionErrorLines: TStringList;
    fOwnerDbxDriver: TSqlDriverOdbc;
    fDbxCallBack: TSQLCallBackEvent;
    fDbxCallBackInfo: Integer;
    fConnected: Boolean;
    fConnBlobSizeLimitK: Integer;
    // Private fields below are specific to ODBC
    fhCon: SqlHDbc;
    fStatementPerConnection: SqlUSmallint;
    // Connection + Statement cache, for databases that support
    // only 1 statement per connection (eg MS SqlServer) :
    fConnectionStatementList: TList;
    fWantQuotedTableName: Boolean;
    fOdbcConnectString: string;
    fOdbcConnectStringHidePassword: string;
    fConnConnectionString: string;
    fOdbcReturnedConnectString: PAnsiChar;
    fOdbcMaxColumnNameLen: SqlUSmallint;
    fOdbcMaxCatalogNameLen: SqlUSmallint;
    fOdbcMaxSchemaNameLen: SqlUSmallint;
    fOdbcMaxTableNameLen: SqlUSmallint;
    fOdbcMaxIdentifierLen: SqlUSmallint;
    fDbmsName: string;
    fDbmsType: TDbmsType;
    fDbmsVersionString: string;
    fDbmsVersionMajor: Integer;
    fDbmsVersionMinor: Integer;
    fDbmsVersionRelease: Integer;
    fDbmsVersionBuild: Integer;
    fOdbcDriverName: string;
    fOdbcDriverType: TOdbcDriverType;
    fOdbcDriverVersionString: string;
    fOdbcDriverVersionMajor: Integer;
    fOdbcDriverVersionMinor: Integer;
    fOdbcDriverVersionRelease: Integer;
    fOdbcDriverVersionBuild: Integer;
    fOdbcDriverLevel: Integer; // 2 or 3
    fInTransaction: Boolean;
    fSupportsCatalog: Boolean;
    fSupportsSQLSTATISTICS: Boolean;
    fSupportsSQLPRIMARYKEYS: Boolean;
    fSupportsSchemaDML: Boolean;
    fSupportsSchemaProc: Boolean;
    fSupportsCatalogDML: Boolean;
    fSupportsCatalogProc: Boolean;
    fGetDataAnyColumn: Boolean;
    fCurrentCatalog: PAnsiChar;
    fQuoteChar: AnsiChar;
    fAutoCommitMode: SqlUInteger;
    fSupportsTransaction: Boolean;
    fCurrentSchema: string; // This is no ODBC API call to get this!
    // Defined by option: fSupportsSchemaFilter
    fConnectionOptions: TConnectionOptions;
    fConnectionOptionsDrv: TConnectionOptions; // Driver Default Options
    fBlobChunkSize: Integer;
    fConPacketSize: Integer;
{.$IFDEF _K3UP_}
    fQualifiedName: string;
{.$ENDIF}
    {Ability to retrieve Error info}
    fNativeErrorCode: SqlInteger;
    fSqlStateChars: TSqlState; // 5 Chars long + null terminator
    {Bypass SetCatalog call}
    fDbxCatalog: string;
    fDbmsVersion: string;
{$IFDEF _RegExprParser_}
    fObjectNameParser: TObjectNameParser;
{$ENDIF}
    fOdbcIsolationLevel: SqlUInteger;
    fSupportsBlockRead: Boolean;

    procedure AllocHStmt(out HStmt: SqlHStmt);
    procedure CheckTransactionSupport;
    procedure CloneOdbcConnection(var HCon: SqlHDbc);
    procedure FreeHStmt(out HStmt: SqlHStmt);
    function GetMetaDataOption(
      eDOption: TSQLMetaDataOption;
      PropValue: Pointer;
      MaxLength: Smallint;
      out Length: Smallint
      ): SQLResult;
    procedure OdbcCheck(OdbcCode: SqlReturn; const OdbcFunctionName: string);
    function RetrieveDriverName: SQLResult;
    procedure GetCurrentCatalog;
    procedure TransactionCheck;
    procedure ClearConnectionOptions;
  protected
    { begin ISQLConnection methods }
    function connect(
      ServerName: PChar;
      UserName: PChar;
      Password: PChar
      ): SQLResult; stdcall;
    function disconnect: SQLResult; stdcall;
    function getSQLCommand(
      out pComm: ISQLCommand
      ): SQLResult; stdcall;
    function getSQLMetaData(
      out pMetaData: ISQLMetaData
      ): SQLResult; stdcall;
    function SetOption(
      eConnectOption: TSQLConnectionOption;
      lValue: Longint
      ): SQLResult; stdcall;
    function GetOption(
      eDOption: TSQLConnectionOption
      ; PropValue: Pointer;
      MaxLength: Smallint;
      out Length: Smallint
      ): SQLResult; stdcall;
    function beginTransaction(
      TranID: Longword
      ): SQLResult; stdcall;
    function commit(
      TranID: Longword
      ): SQLResult; stdcall;
    function rollback(
      TranID: Longword
      ): SQLResult; stdcall;
    function getErrorMessage(
      Error: PChar
      ): SQLResult; overload; stdcall;
    function getErrorMessageLen(
      out ErrorLen: Smallint
      ): SQLResult; stdcall;
    { end ISQLConnection methods }
    { begin ISQLConnectionOdbc methods }
    function GetDbmsName: string;
    function GetDbmsType: TDbmsType;
    function GetDbmsVersionString: string;
    function GetDbmsVersionMajor: Integer;
    function GetDbmsVersionMinor: Integer;
    function GetDbmsVersionRelease: Integer;
    function GetDbmsVersionBuild: Integer;
    function GetLastOdbcSqlState: PChar;
    function GetOdbcConnectString: string;
    procedure GetOdbcConnectStrings(ConnectStringList: TStrings);
    function GetOdbcDriverName: string;
    function GetOdbcDriverType: TOdbcDriverType;
    function GetOdbcDriverVersionString: string;
    function GetOdbcDriverVersionMajor: Integer;
    function GetOdbcDriverVersionMinor: Integer;
    function GetOdbcDriverVersionRelease: Integer;
    function GetOdbcDriverVersionBuild: Integer;
    { end ISQLConnectionOdbc methods }
  public
    constructor Create(OwnerDbxDriver: TSqlDriverOdbc);
    destructor Destroy; override;
    { begin additional public methods/props }

    property DbmsName: string read fDbmsName;
    property DbmsType: TDbmsType read fDbmsType;
    property DbmsVersionMajor: Integer read fDbmsVersionMajor;
    property DbmsVersionString: string read fDbmsVersion;
    property LastOdbcSqlState: PChar read GetLastOdbcSqlState;
    property OdbcConnectString: string read fOdbcConnectString;
    property OdbcDriverName: string read fOdbcDriverName;
    property OdbcDriverType: TOdbcDriverType read fOdbcDriverType;
    property OdbcDriverVersionMajor: Integer read fOdbcDriverVersionMajor;
    property OdbcDriverVersionString: string read fOdbcDriverVersionString;

    { end additional public methods/props }
  end;

  { TSqlCommandOdbc implements ISQLCommand }

  TSqlCommandOdbc = class(TInterfacedObject, ISQLCommand)
  private
    fCommandErrorLines: TStringList;
    fOwnerDbxConnection: TSqlConnectionOdbc;
    fOwnerDbxDriver: TSqlDriverOdbc;
    fCommandBlobSizeLimitK: Integer;
    fCommandRowSetSize: Integer; // New for Delphi 6.02. Map into ODBC option: SQL_ATTR_ROW_ARRAY_SIZE
    fSupportsBlockRead: Boolean; // It is used in vapour with fCommandRowSetSize. (Default = True).
    fSql: string; // fSQL is saved in prepare / executeImmediate
    // Private fields below are specific to ODBC
    fHStmt: SqlHStmt;
    fStmtFreed: Boolean;
    fOdbcParamList: TList;
    fTrimChar: Boolean;
    fExecutedOk: Boolean;
    fPreparedOnly: Boolean;
    fSupportsMixedFetch: Boolean; // flag to using SQL_ATTR_CURSOR_TYPE as SQL_CURSOR_STATIC. Need for "ARRAY FETCH" jointly witch SqlSetPos & SqlGetData.

    procedure OdbcCheck(OdbcCode: SqlReturn; const OdbcFunctionName: string);
  protected
    { begin ISQLCommand methods }
    function SetOption(
      eSqlCommandOption: TSQLCommandOption;
      ulValue: Integer
      ): SQLResult; stdcall;
    function GetOption(
      eSqlCommandOption: TSQLCommandOption;
// Borland changed GetOption function prototype between Delphi V6 and V7
// Kylix 3 uses Delphi 6 prototype
{$IFDEF _D7UP_}
      PropValue: Pointer;
{$ELSE}
      var pValue: Integer;
{$ENDIF}
      MaxLength: Smallint;
      out Length: Smallint
      ): SQLResult; stdcall;
    function setParameter(
      ulParameter: Word;
      ulChildPos: Word;
      eParamType: TSTMTParamType;
      uLogType: Word;
      uSubType: Word;
      iPrecision: Integer;
      iScale: Integer;
      Length: Longword;
      pBuffer: Pointer;
      bIsNull: Integer
      ): SQLResult; stdcall;
    function getParameter(
      ParameterNumber: Word;
      ulChildPos: Word;
      Value: Pointer;
      Length: Integer;
      var IsBlank: Integer
      ): SQLResult; stdcall;
    function prepare(
      SQL: PChar;
      ParamCount: Word
      ): SQLResult; stdcall;
    function execute(
      var Cursor: ISQLCursor
      ): SQLResult; stdcall;
    function ExecuteImmediate(
      SQL: PChar;
      var Cursor: ISQLCursor
      ): SQLResult; stdcall;
    function getNextCursor(
      var Cursor: ISQLCursor
      ): SQLResult; stdcall;
    function getRowsAffected(
      var Rows: Longword
      ): SQLResult; stdcall;
    function close: SQLResult; stdcall;
    function getErrorMessage(
      Error: PChar
      ): SQLResult; overload; stdcall;
    function getErrorMessageLen(
      out ErrorLen: Smallint
      ): SQLResult; stdcall;
    { end ISQLCommand methods }
  public
    constructor Create(OwnerDbxConnection: TSqlConnectionOdbc);
    destructor Destroy; override;
    property hOdbcStmt: SqlHStmt read fHStmt;
  end;

  { TSQLMetaDataOdbc implements ISQLMetaData }

  TSQLMetaDataOdbc = class(TInterfacedObject, ISQLMetaData)
  private
    fOwnerDbxConnection: TSqlConnectionOdbc;
    fMetaDataErrorLines: TStringList;
  protected
    { begin ISQLMetaData methods }
    function SetOption(
      eDOption: TSQLMetaDataOption;
      PropValue: Longint
      ): SQLResult; stdcall;
    function GetOption(
      eDOption: TSQLMetaDataOption;
      PropValue: Pointer;
      MaxLength: Smallint;
      out Length: Smallint
      ): SQLResult; stdcall;
    function getObjectList(
      eObjType: TSQLObjectType;
      out Cursor: ISQLCursor
      ): SQLResult; stdcall;
    function getTables(
      TableName: PChar;
      TableType: Longword;
      out Cursor: ISQLCursor
      ): SQLResult; stdcall;
    function getProcedures(
      ProcedureName: PChar;
      ProcType: Longword;
      out Cursor: ISQLCursor
      ): SQLResult; stdcall;
    function getColumns(
      TableName: PChar;
      ColumnName: PChar;
      ColType: Longword;
      out Cursor: ISQLCursor
      ): SQLResult; stdcall;
    function getProcedureParams(
      ProcName: PChar;
      ParamName: PChar;
      out Cursor: ISQLCursor
      ): SQLResult; stdcall;
    function getIndices(
      TableName: PChar;
      IndexType: Longword;
      out Cursor: ISQLCursor
      ): SQLResult; stdcall;
    function getErrorMessage(
      Error: PChar
      ): SQLResult; overload; stdcall;
    function getErrorMessageLen(
      out ErrorLen:
      Smallint
      ): SQLResult; stdcall;
    { end ISQLMetaData methods }
  public
    constructor Create(OwnerDbxConnection: TSqlConnectionOdbc);
    destructor Destroy; override;
  end;

  { TSqlCursorOdbc implements ISQLCursor }

  TSqlCursorOdbc = class(TInterfacedObject, ISQLCursor)
  private
    fCursorErrorLines: TStringList;
    fOwnerCommand: TSqlCommandOdbc;
    fOwnerDbxConnection: TSqlConnectionOdbc;
    fOwnerDbxDriver: TSqlDriverOdbc;
    fRowNo: Double;
    // Private fields below are specific to ODBC
    fHStmt: SqlHStmt;
    fOdbcNumCols: SqlSmallint;
    fOdbcBindList: TList;
    fCursorFetchRowCount: Integer; // It is necessary for usage SQL_ATTR_ROW_ARRAY_SIZE (ARAY FETCH).
    fOdbcBindBuffer: Pointer; // The common buffer for data receiving.
    fOdbcBindBufferRowSize: Integer;
    fOdbcRowsStatus: array of SqlSmallint;
    fOdbcBindBufferPos: Integer;
    fOdbcRowsFetched: SqlInteger;
    fOdbcLateBoundsFound: Boolean; // flag to using SQLSetPos() when is used "ARAY FETCH"
    procedure BindResultSet;
    procedure OdbcCheck(OdbcCode: SqlReturn; const OdbcFunctionName: string);
    procedure FetchLongData(ColNo: SqlUSmallint);
    procedure FetchLateBoundData(ColNo: SqlUSmallint);
  protected
    { begin ISQLCusror methods }
    function SetOption(
      eOption: TSQLCursorOption;
      PropValue: Longint
      ): SQLResult; stdcall;
    function GetOption(
      eOption: TSQLCursorOption;
      PropValue: Pointer;
      MaxLength: Smallint;
      out Length: Smallint
      ): SQLResult; stdcall;
    function getErrorMessage(
      Error: PChar
      ): SQLResult; overload; stdcall;
    function getErrorMessageLen(
      out ErrorLen: Smallint
      ): SQLResult; stdcall;
    function getColumnCount(
      var pColumns: Word
      ): SQLResult; stdcall;
    function getColumnNameLength(
      ColumnNumber: Word;
      var pLen: Word): SQLResult; stdcall;
    function getColumnName(
      ColumnNumber: Word;
      pColumnName: PChar
      ): SQLResult; stdcall;
    function getColumnType(
      ColumnNumber: Word;
      var puType: Word;
      var puSubType: Word
      ): SQLResult; stdcall;
    function getColumnLength(
      ColumnNumber: Word;
      var pLength: Longword
      ): SQLResult; stdcall;
    function getColumnPrecision(
      ColumnNumber: Word;
      var piPrecision: Smallint
      ): SQLResult; stdcall;
    function getColumnScale(
      ColumnNumber: Word;
      var piScale: Smallint
      ): SQLResult; stdcall;
    function isNullable(
      ColumnNumber: Word;
      var Nullable: LongBool
      ): SQLResult; stdcall;
    function isAutoIncrement(
      ColumnNumber: Word;
      var AutoIncr: LongBool
      ): SQLResult; stdcall;
    function isReadOnly(
      ColumnNumber: Word;
      var ReadOnly: LongBool
      ): SQLResult; stdcall;
    function isSearchable(
      ColumnNumber: Word;
      var Searchable: LongBool
      ): SQLResult; stdcall;
    function isBlobSizeExact(
      ColumnNumber: Word;
      var IsExact: LongBool
      ): SQLResult; stdcall;
    function next: SQLResult; stdcall;
    function getString(
      ColumnNumber: Word; Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getShort(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getLong(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getDouble(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getBcd(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getTimeStamp(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getTime(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getDate(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getBytes(
      ColumnNumber: Word; Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getBlobSize(
      ColumnNumber: Word;
      var Length: Longword;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getBlob(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool;
      Length: Longword): SQLResult; stdcall;
    { end ISQLCusror methods }
  public
    constructor Create(OwnerCommand: TSqlCommandOdbc);
    destructor Destroy; override;
  end;

  TSqlCursorMetaDataColumns = class; // forward declaration
  TSqlCursorMetaDataTables = class; // forward declaration
  TMetaIndexColumn = class; // forward declaration

  { TMetaTable - represents 1 row returned by ISQLMetaData.GetTables }

  TMetaTable = class(TObject)
  private
    fCat: PAnsiChar;
    fSchema: PAnsiChar;
    fTableName: PAnsiChar;
    fQualifiedTableName: PAnsiChar;
    fTableType: Integer;

    fPrimaryKeyColumn1: TMetaIndexColumn;
    fIndexColumnList: TList;
  public
    constructor Create(
      SqlConnectionOdbc: TSqlConnectionOdbc;
      Cat: PAnsiChar;
      Schema: PAnsiChar;
      TableName: PAnsiChar;
      TableType: Integer);
    destructor Destroy; override;
  end;

  { TMetaColumn - represents 1 row returned by ISQLMetaData.GetColumns }

  TMetaColumn = class(TObject)
  private
    fMetaTable: TMetaTable;
    fColumnName: PAnsiChar;
    fOrdinalPosition: Smallint;
    fLength: Integer;
    fTypeName: PAnsiChar;
    fPrecision: Integer;
    fDecimalScale: Smallint;
    fDbxType: Smallint;
    fDbxSubType: Smallint;
    fDbxNullable: Smallint;
    fDbxColumnType: Smallint;
  public
    constructor Create(
      ColumnName: PAnsiChar;
      OrdinalPosition: Smallint;
      TypeName: PAnsiChar);
    destructor Destroy; override;
  end;

  { TMetaIndexColumn - represents 1 row returned by ISQLMetaData.GetIndices }

  TMetaIndexColumn = class(TObject)
  private
    fMetaTable: TMetaTable;
    fIndexName: PAnsiChar;
    fIndexColumnName: PAnsiChar;
    fColumnPosition: Smallint;
    fIndexType: Smallint;
    fSortOrder: Char;
    fFilter: PAnsiChar;
  public
    constructor Create(
      MetaTable: TMetaTable;
      IndexName: PAnsiChar;
      IndexColumnName: PAnsiChar);
    destructor Destroy; override;
  end;

  { TMetaProcedure - represents 1 row returned by ISQLMetaData.GetProcedures }

  TMetaProcedure = class(TObject)
  private
    fCat: PAnsiChar;
    fSchema: PAnsiChar;
    fProcName: PAnsiChar;
    fProcType: Integer;
  public
    constructor Create(
      Cat: PAnsiChar;
      Schema: PAnsiChar;
      ProcName: PAnsiChar;
      ProcType: Integer);
    destructor Destroy; override;
  end;

  { TMetaProcedureParam - represents 1 row returned by ISQLMetaData.GetProcedureParams }

  TMetaProcedureParam = class(TObject)
  private
    fMetaProcedure: TMetaProcedure;
    fParamName: PAnsiChar;
    fDataTypeName: PAnsiChar;
    fParamType: DBXpress.TSTMTParamType;
    fDataType: Smallint;
    fDataSubtype: Smallint;
    fPrecision: Integer;
    fScale: Smallint;
    fLength: Integer;
    fNullable: Smallint;
    fPosition: Smallint;
  public
    constructor Create(ParamName: PAnsiChar);
    destructor Destroy; override;
  end;

  { TColumnNames / TColumnTypes used by TSqlCursorMetaData}

  TColumnNames = array[0..MaxListSize] of string;
  TColumnTypes = array[0..MaxListSize] of Word;
  PColumnNames = ^TColumnNames;
  PColumnTypes = ^TColumnTypes;

  { TSqlCursorMetaData - parent for all the MetaData cursor classes}

  TSqlCursorMetaData = class(TInterfacedObject, ISQLCursor)
  private
    fSqlCursorErrorMsg: TStringList;

    fOwnerMetaData: TSqlMetaDataOdbc;
    fSqlConnectionOdbc: TSqlConnectionOdbc;
    fSqlDriverOdbc: TSqlDriverOdbc;

    fHStmt: SqlHStmt;

    fRowNo: Integer;
    fColumnCount: Integer;
    fColumnNames: PColumnNames;
    fColumnTypes: PColumnTypes;
    fMetaCatalogName: PChar;
    fMetaSchemaName: PChar;
    fMetaTableName: PChar;

    procedure OdbcCheck(OdbcCode: SqlReturn; const OdbcFunctionName: string);
    procedure ParseTableName(TableName: PChar);
    procedure DescribeAllocBindString(ColumnNo: SqlUSmallint; var BindString: PAnsiChar; var
      BindInd: SqlInteger);
    procedure BindInteger(ColumnNo: SqlUSmallint; var BindInteger: Integer;
      BindInd: PSqlInteger);
    procedure BindSmallint(ColumnNo: SqlUSmallint; var BindSmallint: Smallint;
      PBindInd: PSqlInteger);
    procedure ClearMetaData;
  protected
    { begin ISQLCusror methods }
    function SetOption(
      eOption: TSQLCursorOption;
      PropValue: Longint
      ): SQLResult; stdcall;
    function GetOption(
      eOption: TSQLCursorOption;
      PropValue: Pointer;
      MaxLength: Smallint;
      out Length: Smallint
      ): SQLResult; stdcall;
    function getErrorMessage(
      Error: PChar
      ): SQLResult; overload; stdcall;
    function getErrorMessageLen(
      out ErrorLen: Smallint
      ): SQLResult; stdcall;
    function getColumnCount(
      var pColumns: Word
      ): SQLResult; stdcall;
    function getColumnNameLength(
      ColumnNumber: Word;
      var pLen: Word): SQLResult; stdcall;
    function getColumnName(
      ColumnNumber: Word;
      pColumnName: PChar
      ): SQLResult; stdcall;
    function getColumnType(
      ColumnNumber: Word;
      var puType: Word;
      var puSubType: Word
      ): SQLResult; stdcall;
    function getColumnLength(
      ColumnNumber: Word;
      var pLength: Longword
      ): SQLResult; stdcall;
    function getColumnPrecision(
      ColumnNumber: Word;
      var piPrecision: Smallint
      ): SQLResult; stdcall;
    function getColumnScale(
      ColumnNumber: Word;
      var piScale: Smallint
      ): SQLResult; stdcall;
    function isNullable(
      ColumnNumber: Word;
      var Nullable: LongBool
      ): SQLResult; stdcall;
    function isAutoIncrement(
      ColumnNumber: Word;
      var AutoIncr: LongBool
      ): SQLResult; stdcall;
    function isReadOnly(
      ColumnNumber: Word;
      var ReadOnly: LongBool
      ): SQLResult; stdcall;
    function isSearchable(
      ColumnNumber: Word;
      var Searchable: LongBool
      ): SQLResult; stdcall;
    function isBlobSizeExact(
      ColumnNumber: Word;
      var IsExact: LongBool
      ): SQLResult; stdcall;
    function next: SQLResult; stdcall;
    function getString(
      ColumnNumber: Word; Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getShort(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getLong(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getDouble(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getBcd(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getTimeStamp(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getTime(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getDate(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getBytes(
      ColumnNumber: Word; Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getBlobSize(
      ColumnNumber: Word;
      var Length: Longword;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getBlob(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool;
      Length: Longword): SQLResult; stdcall;
    { end ISQLCusror methods }
  public
    constructor Create(
      OwnerSqlMetaData: TSqlMetaDataOdbc);
    destructor Destroy; override;
  end;

  { TSqlCursorMetaDataTables - implements cursor returned by ISQLMetaData.GetTables }

  TSqlCursorMetaDataTables = class(TSQLCursorMetaData, ISQLCursor)
  private
    fTableList: TList;
    fMetaTableCurrent: TMetaTable;
    fCatLenMax: Integer;
    fSchemaLenMax: Integer;
    fQualifiedTableLenMax: Integer;

    procedure FetchTables(SearchTableName: PChar;
      SearchTableType: Longword);
  protected
    function getColumnLength(
      ColumnNumber: Word;
      var pLength: Longword
      ): SQLResult; stdcall;
    function getColumnPrecision(
      ColumnNumber: Word;
      var piPrecision: Smallint
      ): SQLResult; stdcall;
    function getLong(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getString(
      ColumnNumber: Word; Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function next: SQLResult; stdcall;
  public
    constructor Create(
      OwnerMetaData: TSQLMetaDataOdbc);
    destructor Destroy; override;
  end;

  { TSqlCursorMetaDataColumns - implements cursor returned by ISQLMetaData.GetColumns }

  TSqlCursorMetaDataColumns = class(TSQLCursorMetaData, ISQLCursor)
  private
    fTableList: TList;
    fColumnList: TList;

    fMetaTableCurrent: TMetaTable;
    fMetaColumnCurrent: TMetaColumn;

    fCatLenMax: Integer;
    fSchemaLenMax: Integer;
    fTableLenMax: Integer;
    fColumnLenMax: Integer;
    fTypeNameLenMax: Integer;

    procedure FetchColumns(SearchTableName, SearchColumnName: PChar;
      SearchColType: Longword);
  protected
    function getColumnLength(
      ColumnNumber: Word;
      var pLength: Longword
      ): SQLResult; stdcall;
    function getColumnPrecision(
      ColumnNumber: Word;
      var piPrecision: Smallint
      ): SQLResult; stdcall;
    function getLong(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getShort(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getString(
      ColumnNumber: Word; Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function next: SQLResult; stdcall;
  public
    constructor Create(
      OwnerMetaData: TSQLMetaDataOdbc);
    destructor Destroy; override;
  end;

  { TSqlCursorMetaDataIndexes - implements cursor returned by ISQLMetaData.GetIndices }

  TSqlCursorMetaDataIndexes = class(TSQLCursorMetaData, ISQLCursor)
  private
    fIndexList: TList;
    fTableList: TList;
    fCurrentIndexColumn: TMetaIndexColumn;

    fCatLenMax: Integer;
    fSchemaLenMax: Integer;
    fTableLenMax: Integer;
    fIndexNameLenMax: Integer;
    fIndexColumnNameLenMax: Integer;
    fPkNameLenMax: Integer;
    fFilterLenMax: Integer;

    procedure FetchIndexes(SearchTableName: PChar;
      SearchIndexType: Longword);
  protected
    function getColumnLength(
      ColumnNumber: Word;
      var pLength: Longword
      ): SQLResult; stdcall;
    function getColumnPrecision(
      ColumnNumber: Word;
      var piPrecision: Smallint
      ): SQLResult; stdcall;
    function getLong(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getShort(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getString(
      ColumnNumber: Word; Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function next: SQLResult; stdcall;
  public
    constructor Create(
      OwnerMetaData: TSQLMetaDataOdbc);
    destructor Destroy; override;
  end;

  { TSqlCursorMetaDataProcedures - implements cursor returned by ISQLMetaData.GetProcedures }

  TSqlCursorMetaDataProcedures = class(TSQLCursorMetaData, ISQLCursor)
  private
    fProcList: TList;
    fCatLenMax: Integer;
    fSchemaLenMax: Integer;
    fProcLenMax: Integer;
    fMetaProcedureCurrent: TMetaProcedure;

    procedure FetchProcedures(ProcedureName: PChar; ProcType: Longword);
  protected
    function getColumnLength(
      ColumnNumber: Word;
      var pLength: Longword
      ): SQLResult; stdcall;
    function getColumnPrecision(
      ColumnNumber: Word;
      var piPrecision: Smallint
      ): SQLResult; stdcall;
    function getLong(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getString(
      ColumnNumber: Word; Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function next: SQLResult; stdcall;
  public
    constructor Create(OwnerMetaData: TSQLMetaDataOdbc);
    destructor Destroy; override;
  end;

  { TSqlCursorMetaDataProcedureParams - implements cursor returned by ISQLMetaData.GetProcedureParams }

  TSqlCursorMetaDataProcedureParams = class(TSQLCursorMetaData, ISQLCursor)
  private
    fProcList: TList;
    fProcColumnList: TList;

    fCatLenMax: Integer;
    fSchemaLenMax: Integer;
    fProcNameLenMax: Integer;
    fParamNameLenMax: Integer;
    fDataTypeNameLenMax: Integer;

    fMetaProcedureParamCurrent: TMetaProcedureParam;

    procedure FetchProcedureParams(SearchProcedureName,
      SearchParamName: PChar);
  protected
    function getColumnLength(
      ColumnNumber: Word;
      var pLength: Longword
      ): SQLResult; stdcall;
    function getColumnPrecision(
      ColumnNumber: Word;
      var piPrecision: Smallint
      ): SQLResult; stdcall;
    function getLong(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getShort(
      ColumnNumber: Word;
      Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function getString(
      ColumnNumber: Word; Value: Pointer;
      var IsBlank: LongBool
      ): SQLResult; stdcall;
    function next: SQLResult; stdcall;
  public
    constructor Create(OwnerMetaData: TSQLMetaDataOdbc);
    destructor Destroy; override;
  end;

  SqlByte = Byte; // The description of type for abstraction of the reference
  PSqlByte = ^SqlByte;
  PSqlDouble = ^SqlDouble; // not founfd in OdbcApi.pas
  TArrayOfBytes = array[0..255] of Byte;
  PArrayOfBytes = ^TArrayOfBytes;

  TOdbcHostVarAddress = record // Variants of references to the buffer of the data of a column
    case SmallInt of
      0:               (Ptr: SqlPointer);
      SQL_C_CHAR:      (ptrAnsiChar: PChar);
      SQL_C_LONG:      (ptrSqlInteger: PSqlInteger);
      SQL_C_SHORT:     (ptrSqlSmallint: PSqlSmallint);
      SQL_C_DOUBLE:    (ptrSqlDouble: PSqlDouble);
      SQL_C_DATE:      (ptrSqlDateStruct: PSqlDateStruct);
      SQL_C_TIME:      (ptrSqlTimeStruct: PSqlTimeStruct);
      SQL_C_TIMESTAMP: (ptrOdbcTimestamp: POdbcTimestamp);
      SQL_C_BIT:       (ptrSqlByte: PSqlByte);
      SQL_C_SBIGINT:   (ptrSqlBigInt: SqlBigInt);
      SQL_C_BINARY:    (ptrBytesArray: PArrayOfBytes);// - for debug view
  end;

  TOdbcBindCol = class(TObject)
  private
    fOdbcColNo: Integer;
    fColName: PAnsiChar;
    fColNameSize: SqlSmallint;
    fSqlType: SqlSmallint;
    fColSize: SqlUInteger;
    fColScale: SqlSmallint;
    fNullable: SqlSmallint;
    fColValueSizePtr: PSqlInteger; // value allocated in Buffer
    fColValueSizeLoc: SqlInteger;
    fDbxType: Word;
    fDbxSubType: Word;
    fOdbcHostVarType: SqlSmallint;
    fOdbcHostVarSize: SqlUInteger;
    fOdbcHostVarAddress: TOdbcHostVarAddress; // pointer to value
    fOdbcLateBound: Boolean;
    fIsBuffer: Boolean; // Flag indicating the local buffer for BLOB. fOdbcHostVarAddress should be allocated and released.
    fBlobFetched: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TOdbcBindParam = class(TObject)
  private
    fOdbcParamNumber: SqlUSmallint;
    fOdbcInputOutputType: SqlUInteger;
    fOdbcParamCType: SqlSmallint;
    fOdbcParamSqlType: SqlSmallint;
    fOdbcParamCbColDef: SqlUInteger;
    fOdbcParamIbScale: SqlSmallint;
    fOdbcParamLenOrInd: SqlInteger;
    fBuffer: Pointer;
    fValue: packed record
      case Smallint of
        SQL_C_CHAR: (OdbcParamValueString: array[0..255] of Char);
        SQL_C_LONG: (OdbcParamValueInteger: SqlInteger);
        SQL_C_SHORT: (OdbcParamValueShort: SqlSmallint);
        SQL_C_DOUBLE: (OdbcParamValueDouble: SqlDouble);
        SQL_C_DATE: (OdbcParamValueDate: TSqlDateStruct);
        SQL_C_TIME: (OdbcParamValueTime: TSqlTimeStruct);
        SQL_C_TIMESTAMP: (OdbcParamValueTimeStamp: TOdbcTimestamp);
        SQL_C_BIT: (OdbcParamValueBit: SqlByte);
        SQL_C_SBIGINT: (OdbcParamValueBigInt: SqlBigInt);
    end;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
{$IFDEF MSWINDOWS}
  Windows, // The only reason this is needed is to supply Window handle for SqlDriverConect
  {$IFDEF _DENT_}
    gsNTRegisterDbXpressLib,
  {$ELSE}
    SqlExpr, // This is needed only for "RegisterDbXpressLib" for static linking of driver (Windows only)
  {$ENDIF}
{$ENDIF}
  SysUtils,
  FmtBcd,
  SqlTimst;

function SetConnectionOption(
  var ConnectionOptions: TConnectionOptions;
  const OptionDriverDefault: PConnectionOptions;
  Option: TConnectionOption;
  Value: Char): Boolean;
begin
  case UpCase(Value) of
    cOptCharFalse:
      begin
        ConnectionOptions[Option] := osOff;
        Result := True;
      end;
    cOptCharTrue:
      begin
        ConnectionOptions[Option] := osOn;
        Result := True;
      end;
    cOptCharDefault:
      begin
        if ConnectionOptions[Option] = osDefault then
        begin
          // set when call .connect()
          Result := False;
          if (OptionDriverDefault<>nil) and (OptionDriverDefault^[Option]<>osDefault) then
            ConnectionOptions[Option] := OptionDriverDefault^[Option]
          else
            ConnectionOptions[Option] := cConnectionOptionsDefault[Option];
        end
        else
        begin
          // set after or before call .connect()
          if (OptionDriverDefault<>nil) and (OptionDriverDefault^[Option]<>osDefault) then
          begin
            Result := ConnectionOptions[Option] <> OptionDriverDefault^[Option];
            if Result then
              ConnectionOptions[Option] := OptionDriverDefault^[Option];
          end
          else
          begin
            Result := ConnectionOptions[Option] <> cConnectionOptionsDefault[Option];
            if Result then
              ConnectionOptions[Option] := cConnectionOptionsDefault[Option];
          end;
        end;
      end;
  else
    Result := False;
  end;
end;

const
  OdbcReturnedConnectStringMax = 1024;
  cMaxBcdCharDigits = MaxFMTBcdDigits * 2;

  // IBM DB2 extensions to ODBC API:
  SQL_LONGDATA_COMPAT = 1253;
  SQL_LD_COMPAT_NO = 0;
  SQL_LD_COMPAT_YES = 1;

  {+2.08}
  // INFORMIX extensions to ODBC API (see in INFORMIX CLIENT SDK: "INFXCLI.H"):

    // For extended errors:

    SQL_INFX_ADIAG_ISAM_ERROR = 13;
    SQL_INFX_ADIAG_XA_ERROR   = 14;

    // Ajay added till here:
    //-----------------------------------------------------------------------
    { START -- Q+E Software's SQLSetStmtOption extensions (1040 to 1139)
      defines here for backwards compatibility: }
    SQL_STMTOPT_START = 1040;
    // Get the rowid for the last row inserted:
    SQL_GET_ROWID = (SQL_STMTOPT_START+8);
    // Get the value for the serial column in the last row inserted:
    SQL_GET_SERIAL_VALUE = (SQL_STMTOPT_START+9);
    { END -- Q+E Software's SQLSetStmtOption extensions (1040 to 1139) }
    //-----------------------------------------------------------------------

    //    Informix extensions:

    // Informix Column Attributes Flags Definitions:
    INFX_FDNULLABLE     = $0001; // null allowed in field
    INFX_FDDISTINCT     = $0002; // distinct of all
    INFX_FDDISTLVARCHAR = $0004; // distinct of SQLLVARCHAR
    INFX_FDDISTBOOLEAN  = $0008; // distinct of SQLBOOL
    INFX_FDDISTSIMP     = $0010; // distinct of simple type
    INFX_FDCSTTYPE      = $0020; // constructor type
    INFX_FDNAMED        = $0040; // named row type

    //#define ISNULLABLE( flags ) ( flags & FDNULLABLE ? 1 : 0)
    //#define ISDISTINCT( flags ) ( flags & FDDISTINCT ? 1 : 0)

    // Informix Type Estensions:
    SQL_INFX_UDT_FIXED     = (-100);
    SQL_INFX_UDT_VARYING   = (-101);
    SQL_INFX_UDT_BLOB      = (-102);
    SQL_INFX_UDT_CLOB      = (-103);
    SQL_INFX_UDT_LVARCHAR  = (-104);
    SQL_INFX_RC_ROW        = (-105);
    SQL_INFX_RC_COLLECTION = (-106);
    SQL_INFX_RC_LIST       = (-107);
    SQL_INFX_RC_SET        = (-108);
    SQL_INFX_RC_MULTISET   = (-109);
    SQL_INFX_UNSUPPORTED   = (-110);

    // typedef void * HINFX_RC; // row & collection handle

    // Informix Connect Attributes Extensions:
    SQL_INFX_OPT_LONGID                  = 2251;
    SQL_INFX_ATTR_LONGID                 = SQL_INFX_OPT_LONGID;
    SQL_INFX_ATTR_LEAVE_TRAILING_SPACES  = 2252;
    SQL_INFX_ATTR_DEFAULT_UDT_FETCH_TYPE = 2253;
    SQL_INFX_ATTR_ENABLE_SCROLL_CURSORS  = 2254;
    SQL_INFX_ATTR_ENABLE_INSERT_CURSORS  = 2255;
    SQL_INFX_ATTR_OPTIMIZE_AUTOCOMMIT    = 2256;
    SQL_INFX_ATTR_ODBC_TYPES_ONLY        = 2257;
    SQL_INFX_ATTR_FETCH_BUFFER_SIZE      = 2258;
    SQL_INFX_ATTR_OPTOFC                 = 2259;
    SQL_INFX_ATTR_OPTMSG                 = 2260;
    SQL_INFX_ATTR_REPORT_KEYSET_CURSORS  = 2261;
    SQL_INFX_ATTR_LO_AUTOMATIC           = 2262;  // Report Standard ODBC Types" Can  be
      // placed in ODBC Connection String options: "ODTYP=1".
      // When SQL_INFX_ATTR_LO_AUTOMATIC = SQL_FALSE then ODBC Driver return the next
      // code for LOB fields: SQL_INFX_UDT_BLOB, SQL_INFX_UDT_CLOB, ...
      // Access is possible through old api: ifx_lo. For more details see:
      // http://www-3.ibm.com/software/data/informix/pubs/library/notes/relnotes/odb0331r31.htm
      // For "Data Direct Informix Wire Protocol ODBC Driver" informix LOB types mapped to standatd ODBC Types:
      // http://www.datadirect-technologies.com/download/docs/odbc64/ODBC64REF/Rinf_wp.html
    SQL_INFX_ATTR_AUTO_FREE              = 2263;
    SQL_INFX_ATTR_DEFERRED_PREPARE       = 2265;
    // Informix Descriptor Extensions:
    SQL_INFX_ATTR_FLAGS                   = 1900; // UDWORD
    SQL_INFX_ATTR_EXTENDED_TYPE_CODE      = 1901; // UDWORD
    SQL_INFX_ATTR_EXTENDED_TYPE_NAME      = 1902; // UCHAR ptr
    SQL_INFX_ATTR_EXTENDED_TYPE_OWNER     = 1903; // UCHAR ptr
    SQL_INFX_ATTR_EXTENDED_TYPE_ALIGNMENT = 1904; // UDWORD
    SQL_INFX_ATTR_SOURCE_TYPE_CODE        = 1905; // UDWORD

    // Informix Statement Attributes Extensions:
    SQL_VMB_CHAR_LEN               = 2325;
    SQL_INFX_ATTR_VMB_CHAR_LEN     = SQL_VMB_CHAR_LEN;
    SQL_INFX_ATTR_MAX_FET_ARR_SIZE = 2326;

    // Informix fOption, SQL_VMB_CHAR_LEN vParam:
    SQL_VMB_CHAR_EXACT    = 0;
    SQL_VMB_CHAR_ESTIMATE = 1;

    // Informix row/collection traversal constants:
    SQL_INFX_RC_NEXT     = 1;
    SQL_INFX_RC_PRIOR    = 2;
    SQL_INFX_RC_FIRST    = 3;
    SQL_INFX_RC_LAST     = 4;
    SQL_INFX_RC_ABSOLUTE = 5;
    SQL_INFX_RC_RELATIVE = 6;
    SQL_INFX_RC_CURRENT  = 7;

    {*******************************************************************************
     * Large Object (LO) related structures
     *
     * LO_SPEC: Large object spec structure
     * It is used for creating smartblobs. The user may examin and/or set certain
     * fields of LO_SPEC by using ifx_lo_spec[set|get]_* accessor functions.
     *
     * LO_PTR: Large object pointer structure
     * Identifies the LO and provides ancillary, security-related information.
     *
     * LO_STAT: Large object stat structure
     * It is used in querying attribtes of smartblobs. The user may examin fields
     * herein by using ifx_lo_stat[set|get]_* accessor functions.
     *
     * These structures are opaque to the user. Accessor functions are provided
     * for these structures.
     ******************************************************************************}

    // Informix GetInfo Extensions to obtain length of LO related structures:
    SQL_INFX_LO_SPEC_LENGTH = 2250; // UWORD
    SQL_INFX_LO_PTR_LENGTH  = 2251; // UWORD
    SQL_INFX_LO_STAT_LENGTH = 2252; // UWORD

    {******************************************************************************
     * LO Open flags: (see documentation for further explanation)
     *
     * INFX_LO_APPEND   - Positions the seek position to end-of-file + 1. By itself,
     *               it is equivalent to write only mode followed by a seek to the
     *               end of large object. Read opeartions will fail.
     *               You can OR the LO_APPEND flag with another access mode.
     * INFX_LO_WRONLY   - Only write operations are valid on the data.
     * INFX_LO_RDONLY   - Only read operations are valid on the data.
     * INFX_LO_RDWR     - Both read and write operations are valid on the data.
     *
     * INFX_LO_RANDOM   - If set overrides optimizer decision. Indicates that I/O is
     *               random and that the system should not read-ahead.
     * INFX_LO_SEQUENTIAL - If set overrides optimizer decision. Indicates that
     *               reads are sequential in either forward or reverse direction.
     *
     * INFX_LO_FORWARD  - Only used for sequential access. Indicates that the sequential
     *               access will be in a forward direction, i.e. from low offset
     *               to higher offset.
     * INFX_LO_REVERSE  - Only used for sequential access. Indicates that the sequential
     *               access will be in a reverse direction.
     *
     * INFX_LO_BUFFER   - If set overrides optimizer decision. I/O goes through the
     *               buffer pool.
     * INFX_LO_NOBUFFER - If set then I/O does not use the buffer pool.
     ******************************************************************************}

    INFX_LO_APPEND       = $1;
    INFX_LO_WRONLY       = $2;
    INFX_LO_RDONLY       = $4;     // default
    INFX_LO_RDWR         = $8;

    INFX_LO_RANDOM       = $20;    // default is determined by optimizer
    INFX_LO_SEQUENTIAL   = $40;    // default is determined by optimizer

    INFX_LO_FORWARD      = $80;    // default
    INFX_LO_REVERSE      = $100;

    INFX_LO_BUFFER       = $200;   // default is determined by optimizer
    INFX_LO_NOBUFFER     = $400;   // default is determined by optimizer

    INFX_LO_DIRTY_READ   = $10;
    INFX_LO_NODIRTY_READ = $800;

    {*******************************************************************************
     * LO create-time flags:
     *
     * Bitmask - Set/Get via ifx_lo_specset_flags() on LO_SPEC.
     ******************************************************************************}

    INFX_LO_ATTR_LOG                    = $01;
    INFX_LO_ATTR_NOLOG                  = $02;
    INFX_LO_ATTR_DELAY_LOG              = $04;
    INFX_LO_ATTR_KEEP_LASTACCESS_TIME   = $08;
    INFX_LO_ATTR_NOKEEP_LASTACCESS_TIME = $10;
    INFX_LO_ATTR_HIGH_INTEG             = $20;
    INFX_LO_ATTR_MODERATE_INTEG         = $40;

    {*******************************************************************************
     * Symbolic constants for the "lseek" routine
     ******************************************************************************}

    INFX_LO_SEEK_SET = 0;   // Set curr. pos. to "offset"
    INFX_LO_SEEK_CUR = 1;   // Set curr. pos. to current + "offset"
    INFX_LO_SEEK_END = 2;   // Set curr. pos. to EOF + "offset"

    {*******************************************************************************
     * Intersolv specific infoTypes for SQLGetInfo
     ******************************************************************************}

    SQL_RESERVED_WORDS           = 1011;
    SQL_PSEUDO_COLUMNS           = 11012;
    SQL_FROM_RESERVED_WORDS      = 11013;
    SQL_WHERE_CLAUSE_TERMINATORS = 11014;
    SQL_COLUMN_FIRST_CHARS       = 11015;
    SQL_COLUMN_MIDDLE_CHARS      = 11016;
    SQL_TABLE_FIRST_CHARS        = 11018;
    SQL_TABLE_MIDDLE_CHARS       = 11019;
    SQL_FAST_SPECIAL_COLUMNS     = 11021;
    SQL_ACCESS_CONFLICTS         = 11022;
    SQL_LOCKING_SYNTAX           = 11023;
    SQL_LOCKING_DURATION         = 11024;
    SQL_RECORD_OPERATIONS        = 11025;
    SQL_QUALIFIER_SYNTAX         = 11026;

  // MSSQL extensions to ODBC API (see in INFORMIX CLIENT SDK: "INFXCLI.H"):
    SQL_MSSQL_VARIANT = (-150); // map to SQL_BINARY/fldBYTES

  {/+2.08}

type
  EDbxOdbcWarning = class(Exception);

  EDbxError = class(Exception); // The 4 Exceptions below descendents of this
  EDbxOdbcError = class(EDbxError); // Odbc returned error result code
  EDbxNotSupported = class(EDbxError); // Feature not yet implemented
  EDbxInvalidCall = class(EDbxError); // Invalid function call or function parameter
  EDbxInternalError = class(EDbxError); // Other error

  { Public function getSQLDriverODBC is the starting point for everything else... }

function getSQLDriverODBC(sVendorLib: PChar; sResourceFile: PChar; out Obj): SQLResult; stdcall;
begin
  try
    if not LoadOdbcDriverManager(sVendorLib) then
      raise EDbxError.Create('Unable to load specified Odbc Driver manager DLL: ''' +
        sVendorLib + '''');
    ISQLDriver(Obj) := TSqlDriverOdbc.Create;
    Result := DBXpress.SQL_SUCCESS;
  except
    on EDbxError do
      Result := DBXpress.MaxReservedStaticErrors + 1;
  end;
end;

{ Private utility functions... }

procedure MaxSet(var x: Integer; n: Integer);
begin
  if x < n then
    x := n;
end;

function strCompNil(const Str1, Str2: PChar): Integer;
begin
  if (Str1 = nil) then
  begin
    if (str2 = nil) then
      Result := 0
    else
      Result := -1
  end
  else
  if (str2 = nil) then
     Result := 1
  else
    Result := strComp(str1, str2);
end;

procedure FreeMemAndNil(var MemPtr);
var
  ptr: Pointer;
begin
  if Pointer(MemPtr)<>nil then
  begin
    {$IFDEF _TRACE_CALLS_}
      //LogEnterProc('FreeMemAndNil'); try
      try
    {$ENDIF _TRACE_CALLS_}
    ptr := Pointer(MemPtr);
    {$IFDEF _DEBUG_}
    //OutputDebugString(PChar('$'+IntToHex(DWORD(ptr),9)));
    {$ENDIF}
    Pointer(MemPtr) := nil;
    FreeMem(ptr);
    {$IFDEF _TRACE_CALLS_}
    except
      on e:exception do
      begin
        LogExceptProc('FreeMemAndNil', e);
        raise;
      end;
    end;
    //finally LogExitProc('FreeMemAndNil'); end;
    {$ENDIF}
  end;
end;

procedure OdbcDataTypeToDbxType(aSqlType: Smallint; var DbxType: Smallint;
  var DbxSubType: Smallint; SqlConnectionOdbc: TSqlConnectionOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('OdbcDataTypeToDbxType', ['aSqlType=',aSqlType]); try try {$ENDIF _TRACE_CALLS_}
  DbxSubType := 0;
  case aSqlType of
    SQL_INTEGER:
      DbxType := fldINT32;
    SQL_BIGINT:
      begin
        // DbExpress does NOT currently support INT64
        //DbxType := fldINT64;
        //DbxType := fldINT32;
        if (SqlConnectionOdbc<>nil) and (SqlConnectionOdbc.fConnectionOptions[coMapInt64ToBcd] = osOff) then
        begin
          // Default code:
          DbxType := fldINT32;
        end
        else
        begin
          // Remapping to BCD
          DbxType := fldBCD;
        end;
      end;
    SQL_SMALLINT, SQL_TINYINT:
      DbxType := fldINT16;
    SQL_BIT:
      DbxType := fldBOOL;
    SQL_NUMERIC, SQL_DECIMAL:
      DbxType := fldBCD;
    SQL_DOUBLE, SQL_FLOAT, SQL_REAL:
      DbxType := fldFLOAT;
    SQL_CHAR, SQL_WCHAR, SQL_GUID:
      begin
        DbxType := fldZSTRING;
        DbxSubType := fldstFIXED;
      end;
    SQL_VARCHAR, SQL_WVARCHAR:
      begin
      DbxType := fldZSTRING;
      DbxSubType := fldstFIXED;
      end;
    SQL_BINARY:
      DbxType := fldBYTES;
    SQL_VARBINARY:
      DbxType := fldVARBYTES;
    SQL_TYPE_DATE:
      DbxType := fldDATE;
    SQL_TYPE_TIME, SQL_TIME{=SQL_INTERVAL}: // SQL_TIME has been obtained from Pervasive.SQL
      DbxType := fldTIME;
    SQL_TYPE_TIMESTAMP, SQL_DATETIME{=SQL_DATE}, SQL_TIMESTAMP:
      DbxType := fldDATETIME;
    SQL_LONGVARCHAR, SQL_WLONGVARCHAR:
      begin
        DbxType := fldBLOB;
        DbxSubType := fldstMEMO;
      end;
    SQL_LONGVARBINARY:
      begin
        DbxType := fldBLOB;
        DbxSubType := fldstBINARY;
      end;
    SQL_INTERVAL_YEAR..SQL_INTERVAL_MINUTE_TO_SECOND:
      begin
        DbxType := fldZSTRING;
        DbxSubType := fldstFIXED;
      end;
  else
    begin
      {+2.08}
      if (SqlConnectionOdbc<>nil) and (SqlConnectionOdbc.fOdbcDriverType = eOdbcDriverTypeInformix) and
         (
           (aSqlType = SQL_INFX_UDT_BLOB) { INFORMIX BLOB } // fldstHBINARY
           or
           (aSqlType = SQL_INFX_UDT_CLOB) { INFORMIX CLOB } // fldstHMEMO
         )
      then
      begin
        DbxType := fldBLOB;
        if (aSqlType = SQL_INFX_UDT_BLOB) then
          DbxSubType := fldstHBINARY
        else
          DbxSubType := fldstHMEMO;
        exit;
      end;
      if (SqlConnectionOdbc<>nil) and (SqlConnectionOdbc.fOdbcDriverType = eOdbcDriverTypeMsSqlServer) and
         (aSqlType = SQL_MSSQL_VARIANT) // sql_variant: SELECT value FROM "dbo"."sysproperties"
      then
      begin
        DbxType := fldBYTES;
        exit;
      end;
      DbxType := fldUNKNOWN;
      {/+2.08}
    end;
  end; //of: case
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('OdbcDataTypeToDbxType', e); raise; end; end;
    finally LogExitProc('OdbcDataTypeToDbxType', ['DbxType=', DbxType, 'DbxSubType=', DbxSubType]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function FormatParameter(Parameter: TOdbcBindParam): string;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('FormatParameter'); try try {$ENDIF _TRACE_CALLS_}
  Result := IntToStr(Parameter.fOdbcParamNumber);
  Result := Result + ' ';
  case Parameter.fOdbcInputOutputType of
    SQL_PARAM_TYPE_UNKNOWN:
      Result := Result + 'TYPE_UNKNOWN';
    SQL_PARAM_INPUT:
      Result := Result + 'INPUT';
    SQL_PARAM_INPUT_OUTPUT:
      Result := Result + 'INPUT_OUTPUT';
    SQL_RESULT_COL:
      Result := Result + 'RESULT_COL';
    SQL_PARAM_OUTPUT:
      Result := Result + 'OUTPUT';
    SQL_RETURN_VALUE:
      Result := Result + 'RETURN_VALUE';
  end;

  if not (Parameter.fOdbcInputOutputType in [SQL_PARAM_INPUT, SQL_PARAM_INPUT_OUTPUT]) then
    exit;

  Result := Result + ' ';

  case Parameter.fOdbcParamSqlType of
    SQL_UNKNOWN_TYPE:
      begin
        Result := Result + '[VALUE NOT ASSIGNED]';
        exit;
      end;
    SQL_VARCHAR:
      begin
        Result := Result + 'VARCHAR';
      end;
    SQL_INTEGER:
      Result := Result + 'INTEGER';
    SQL_SMALLINT:
      Result := Result + 'SMALLINT';
    SQL_BIGINT:
      Result := Result + 'BIGINT';
    SQL_DOUBLE:
      Result := Result + 'DOUBLE';
    SQL_DATE:
      Result := Result + 'DATE';
    SQL_TIME:
      Result := Result + 'TIME';
    SQL_TIMESTAMP:
      Result := Result + 'TIMESTAMP';
    SQL_DECIMAL:
      Result := Result + Format('DECIMAL(%d,%d)', [
        Parameter.fOdbcParamCbColDef,
          Parameter.fOdbcParamIbScale]);
    SQL_NUMERIC:
      Result := Result + 'NUMERIC';
    SQL_BIT:
      Result := Result + 'BIT';
    SQL_LONGVARBINARY:
      Result := Result + 'LONGVARBINARY';
    SQL_LONGVARCHAR:
      Result := Result + 'SQL_LONGVARCHAR';
  else
    Result := Result + '[unknown data type ' + IntToStr(Parameter.fOdbcParamSqlType) + ']';
    exit;
  end;

  Result := Result + ': ';

  if Parameter.fOdbcParamLenOrInd = OdbcApi.SQL_NULL_DATA then
  begin
    Result := Result + '[NULL]';
    exit;
  end;

  case Parameter.fOdbcParamSqlType of
    SQL_VARCHAR:
      if Parameter.fBuffer = nil then
        Result := Result + '''' + Parameter.fValue.OdbcParamValueString + ''''
      else
        Result := Result + '[Long string]';
    SQL_INTEGER:
      Result := Result + IntToStr(Parameter.fValue.OdbcParamValueInteger);
    SQL_SMALLINT:
      Result := Result + IntToStr(Parameter.fValue.OdbcParamValueShort);
    SQL_BIGINT:
      Result := Result + IntToStr(Parameter.fValue.OdbcParamValueBigInt);
    SQL_DOUBLE:
      Result := Result + FloatToStr(Parameter.fValue.OdbcParamValueDouble);
    SQL_DATE:
      Result := Result + Format('%.4d-%.2d-%.2d', [
        Parameter.fValue.OdbcParamValueDate.Year,
          Parameter.fValue.OdbcParamValueDate.Month,
          Parameter.fValue.OdbcParamValueDate.Day]);
    SQL_TIME:
      Result := Result + Format('%.4d-%.2d-%.2d %.2d:%.2d:%.2d.%.9d', [
        Parameter.fValue.OdbcParamValueTime.Hour,
          Parameter.fValue.OdbcParamValueTime.Minute,
          Parameter.fValue.OdbcParamValueTime.Second]);
    SQL_TIMESTAMP:
      Result := Result + Format('%.4d-%.2d-%.2d %.2d:%.2d:%.2d.%.9d', [
        Parameter.fValue.OdbcParamValueTimeStamp.Year,
          Parameter.fValue.OdbcParamValueTimeStamp.Month,
          Parameter.fValue.OdbcParamValueTimeStamp.Day,
          Parameter.fValue.OdbcParamValueTimeStamp.Hour,
          Parameter.fValue.OdbcParamValueTimeStamp.Minute,
          Parameter.fValue.OdbcParamValueTimeStamp.Second,
          Parameter.fValue.OdbcParamValueTimeStamp.Fraction]);
    SQL_DECIMAL, SQL_NUMERIC:
      Result := Result + Parameter.fValue.OdbcParamValueString;
    SQL_BIT:
      Result := Result + IntToStr(Parameter.fValue.OdbcParamValueBit);
    SQL_LONGVARBINARY:
      Result := Result + '[long data]';
    SQL_LONGVARCHAR:
      Result := Result + '[long data]';
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('FormatParameter', e);  raise; end; end;
    finally LogExitProc('FormatParameter'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TSqlDriverOdbc }

constructor TSqlDriverOdbc.Create;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited Create;
  fOdbcErrorLines := TStringList.Create;
  //fErrorLines := TStringList.Create;
  fSqlStateChars := '00000' + #0;
  fDrvBlobSizeLimitK := -1;
  AllocHEnv;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.Create', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSqlDriverOdbc.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  FreeHEnv;
  //fErrorLines.Free;
  FreeAndNil(fOdbcErrorLines);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.Destroy', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlDriverOdbc.OdbcCheck(
  CheckCode: SqlReturn;
  const OdbcFunctionName: string;
  HandleType: Smallint;
  Handle: SqlHandle;
  Connection: TSqlConnectionOdbc = nil;
  Command: TSqlCommandOdbc = nil);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.OdbcCheck', ['CheckCode=', CheckCode, 'OdbcFunctionName=', OdbcFunctionName, 'HandleType=', HandleType]); try try {$ENDIF _TRACE_CALLS_}
  case CheckCode of
    OdbcApi.SQL_SUCCESS:
      exit;
    OdbcApi.SQL_SUCCESS_WITH_INFO:
      begin
        try
          fOdbcErrorLines.Clear;
          fOdbcErrorLines.Add('SQL_SUCCESS_WITH_INFO returned from ODBC function ' +
            OdbcFunctionName);
          RetrieveOdbcErrorInfo(CheckCode, HandleType, Handle, Connection, Command);
          raise EDbxODBCWarning.Create(fOdbcErrorLines.Text);
        except
          on e:EDbxOdbcWarning do
          begin
            {$IFDEF _TRACE_CALLS_}
            LogExceptProc('TSqlDriverOdbc.OdbcCheck', e);
            {$ENDIF _TRACE_CALLS_}
            fOdbcErrorLines.Clear; // Clear the error - warning only
          end;
        end
      end;
    OdbcApi.SQL_NO_DATA:
      begin
        fOdbcErrorLines.Clear;
        fOdbcErrorLines.Add('Unexpected end of data returned from ODBC function: ' +
          OdbcFunctionName);
        raise EDbxODBCError.Create(fOdbcErrorLines.Text);
      end;
  else
    begin
      fOdbcErrorLines.Clear;
      fOdbcErrorLines.Add('Error returned from ODBC function ' + OdbcFunctionName);
      RetrieveOdbcErrorInfo(CheckCode, HandleType, Handle, Connection, Command);
      raise EDbxOdbcError.Create(fOdbcErrorLines.Text);
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.OdbcCheck', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.OdbcCheck'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlDriverOdbc.RetrieveOdbcErrorInfo(
  CheckCode: SqlReturn;
  HandleType: Smallint;
  Handle: SqlHandle;
  Connection: TSqlConnectionOdbc;
  Command: TSqlCommandOdbc);
var
  CheckCodeText: string;
  GetDiagRetCode: SqlReturn;
  GetDiagRecNumber: Smallint;
  SqlStateChars: TSqlState; // 5 chars long + null terminator
  SqlState: PSqlState;
  NativeError: SqlInteger;
  pMessageText: PAnsiChar;
  BufferLengthRet: SqlSmallint;
  i: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.RetrieveOdbcErrorInfo', ['CheckCode=', CheckCode, 'HandleType', HandleType, 'Handle=', Handle]); try try {$ENDIF _TRACE_CALLS_}
  fNativeErrorCode := 0;
  fSqlStateChars := '00000' + #0;

  case CheckCode of
    OdbcApi.SQL_SUCCESS: CheckCodeText := 'SQL_SUCCESS';
    SQL_SUCCESS_WITH_INFO: CheckCodeText := 'SQL_SUCCESS_WITH_INFO';
    SQL_NO_DATA: CheckCodeText := 'SQL_NO_DATA';
    SQL_ERROR: CheckCodeText := 'SQL_ERROR';
    SQL_INVALID_HANDLE: CheckCodeText := 'SQL_INVALID_HANDLE';
    SQL_STILL_EXECUTING: CheckCodeText := 'SQL_STILL_EXECUTING';
    SQL_NEED_DATA: CheckCodeText := 'SQL_NEED_DATA';
  else
    CheckCodeText := 'Unknown Error code';
  end;

  fOdbcErrorLines.Add('ODBC Return Code: ' + IntToStr(CheckCode) + ': ' + CheckCodeText);

  pMessageText := AllocMem(SQL_MAX_MESSAGE_LENGTH + 2);

  SqlState := @SqlStateChars;
  GetDiagRecNumber := 1;
  GetDiagRetCode := SQLGetDiagRec(HandleType, Handle, GetDiagRecNumber,
    Sqlstate, NativeError, pMessageText, SQL_MAX_MESSAGE_LENGTH, BufferLengthRet);

  if GetDiagRetCode = 0 then
  begin
    // The most significant SqlState is always the FIRST record:
    fSqlStateChars := SqlStateChars;
    if Connection <> nil then
    begin
      Connection.fSqlStateChars := SqlStateChars;
      Connection.fNativeErrorCode := NativeError;
    end
  end
  else
    fOdbcErrorLines.Add('No ODBC diagnostic info available');

  i:=0;
  while (GetDiagRetCode = 0) do
  begin
    inc(i);
    fOdbcErrorLines.Add('');
    fOdbcErrorLines.Add('ODBC SqlState:        ' + Sqlstate);

    if (NativeError <> 0) then
    begin
      fOdbcErrorLines.Add('Native Error Code:    ' + IntToStr(NativeError));
      if (fNativeErrorCode <> 0) then
        fNativeErrorCode := NativeError;
    end;

    fOdbcErrorLines.Add(pMessageText);

    Inc(GetDiagRecNumber);
    GetDiagRetCode := SQLGetDiagRec(HandleType, Handle, GetDiagRecNumber,
      Sqlstate, NativeError, pMessageText, SQL_MAX_MESSAGE_LENGTH, BufferLengthRet);
  end;

  FreeMem(pMessageText);

  if (Connection<>nil) and (Connection.fDbmsName<>'') then
  begin
    if i>0 then
      fOdbcErrorLines.Add('');
    fOdbcErrorLines.Add('DBMS: "' + Connection.fDbmsName+
      '", version: ' + Connection.fDbmsVersionString +
      ', ODBC Driver: "' + Connection.fOdbcDriverName +
      '", version: ' + Connection.fOdbcDriverVersionString );
  end;

  if (Command <> nil) then
  begin
    fOdbcErrorLines.Add('');
    fOdbcErrorLines.Add('SQL:');
    fOdbcErrorLines.Add(Command.fSql);
    if (Command.fOdbcParamList <> nil) and (Command.fOdbcParamList.Count > 0) then
    begin
      fOdbcErrorLines.Add('');
      fOdbcErrorLines.Add('Parameters:');
      for i := 0 to Command.fOdbcParamList.Count - 1 do
      begin
        fOdbcErrorLines.Add(FormatParameter(Command.fOdbcParamList[i]));
      end;
    end;
    fOdbcErrorLines.Add('');
    fOdbcErrorLines.Add('Connection string:');
    fOdbcErrorLines.Add(Connection.fOdbcConnectStringHidePassword);
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.RetrieveOdbcErrorInfo', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.RetrieveOdbcErrorInfo'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlDriverOdbc.AllocHCon(out HCon: SqlHDbc);
var
  OdbcRetcode: OdbcApi.SqlReturn;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.AllocHCon'); try try {$ENDIF _TRACE_CALLS_}
  OdbcRetcode := SQLAllocHandle(SQL_HANDLE_DBC, fhEnv, HCon);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLAllocHandle(SQL_HANDLE_DBC)', SQL_HANDLE_ENV, fhEnv);
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.AllocHCon', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.AllocHCon'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlDriverOdbc.FreeHCon(var HCon: SqlHDbc);
var
  OdbcRetcode: OdbcApi.SqlReturn;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.FreeHCon'); try try {$ENDIF _TRACE_CALLS_}
  if HCon = SQL_NULL_HANDLE then
    exit;
  OdbcRetcode := SQLFreeHandle(SQL_HANDLE_DBC, HCon);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLFreeHandle(SQL_HANDLE_DBC)', SQL_HANDLE_DBC, HCon);
  HCon := SQL_NULL_HANDLE;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.FreeHCon', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.FreeHCon'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlDriverOdbc.AllocHEnv;
var
  OdbcRetcode: OdbcApi.SqlReturn;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.AllocHEnv'); try try {$ENDIF _TRACE_CALLS_}
  OdbcRetcode := SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, fhEnv);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLAllocHandle(SQL_HANDLE_ENV)', SQL_HANDLE_ENV, fhEnv);

  // This specifies ODBC version 3 (called before SQLConnect)
  OdbcRetcode := SQLSetEnvAttr(fhEnv, SQL_ATTR_ODBC_VERSION, Pointer(SQL_OV_ODBC3), 0);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLSetEnvAttr(SQL_ATTR_ODBC_VERSION, SQL_OV_ODBC3)', SQL_HANDLE_ENV,
      fhEnv);
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.AllocHEnv', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.AllocHEnv'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlDriverOdbc.FreeHEnv;
var
  OdbcRetcode: OdbcApi.SqlReturn;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.FreeHEnv'); try try {$ENDIF _TRACE_CALLS_}
  OdbcRetcode := SQLFreeHandle(SQL_HANDLE_ENV, fhEnv);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLFreeHandle(SQL_HANDLE_ENV)', SQL_HANDLE_ENV, fhEnv);
  fhEnv := SQL_NULL_HANDLE;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.FreeHEnv', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.FreeHEnv'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlDriverOdbc.GetOption(eDOption: TSQLDriverOption;
  PropValue: Pointer; MaxLength: Smallint;
  out Length: Smallint): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.GetOption', ['eDOption=',cSQLDriverOption[eDOption]]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if PropValue=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case eDOption of
      eDrvBlobSize:
        Longint(PropValue) := fDrvBlobSizeLimitK;
      eDrvCallBack:
        { TODO : IMPLEMENT TRACING SUPPORT - Just save trace callback function for now }
        TSQLCallbackEvent(PropValue) := fSQLCallbackEvent;
      eDrvCallBackInfo:
        Longint(PropValue) := fDbxOptionDrvCallBackInfo;
      eDrvRestrict:
        Longword(PropValue) := fDbxOptionDrvRestrict;
    else
      raise EDbxInvalidCall.Create('Invalid option passed to TSqlDriverOdbc.GetOption');
    end;
    Result := SQL_SUCCESS;
  except
    //on E: EDbxError do
    begin
      //fErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.GetOption', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.GetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlDriverOdbc.getSQLConnection(
  out pConn: ISQLConnection
  ): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.getSQLConnection'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    pConn := TSqlConnectionOdbc.Create(Self);
    Result := SQL_SUCCESS;
  except
    //on E: EDbxError do
    begin
      //fErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.getSQLConnection', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.getSQLConnection'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlDriverOdbc.SetOption(
  eDOption: TSQLDriverOption;
  PropValue: Longint
  ): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.SetOption', ['eDOption=',cSQLDriverOption[eDOption]]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case eDOption of
      eDrvBlobSize:
        fDrvBlobSizeLimitK := PropValue;
      eDrvCallBack:
        fSQLCallbackEvent := TSQLCallbackEvent(PropValue);
      eDrvCallBackInfo:
        fDbxOptionDrvCallBackInfo := PropValue;
      eDrvRestrict:
        fDbxOptionDrvRestrict := Longword(PropValue);
    else
      raise EDbxInvalidCall.Create('Invalid option passed to TSqlDriverOdbc.SetOption');
    end;
    Result := SQL_SUCCESS;
  except
    //on E: EDbxError do
    begin
      //fErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.SetOption', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.SetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlDriverOdbc.Drivers(DriverList: TStrings);
const
  DriverDescLengthMax = 255;
  DriverAttributesLengthMax = 4000;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  sDriverDescBuffer: PChar;
  sDriverAttributesBuffer: PChar;
  aDriverDescLength: SqlSmallint;
  aDriverAttributesLength: SqlSmallint;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlDriverOdbc.Drivers'); try try {$ENDIF _TRACE_CALLS_}
  sDriverDescBuffer := AllocMem(DriverDescLengthMax);
  sDriverAttributesBuffer := AllocMem(DriverAttributesLengthMax);
  DriverList.BeginUpdate;
  try
    DriverList.Clear;
    OdbcRetcode := SQLDrivers(fhEnv, SQL_FETCH_FIRST,
      sDriverDescBuffer, DriverDescLengthMax, aDriverDescLength,
      sDriverAttributesBuffer, DriverAttributesLengthMax, aDriverAttributesLength);
    if (OdbcRetcode <> OdbcApi.SQL_NO_DATA) and (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
      OdbcCheck(OdbcRetcode, 'SQLDrivers(SQL_FETCH_FIRST)', SQL_HANDLE_ENV, fhEnv);
    while OdbcRetcode = 0 do
    begin
      DriverList.Add(sDriverDescBuffer);
      OdbcRetcode := SQLDrivers(fhEnv, SQL_FETCH_NEXT,
        sDriverDescBuffer, DriverDescLengthMax, aDriverDescLength,
        sDriverAttributesBuffer, DriverAttributesLengthMax, aDriverAttributesLength);
      if (OdbcRetcode <> OdbcApi.SQL_NO_DATA) and (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
        OdbcCheck(OdbcRetcode, 'SQLDrivers(SQL_FETCH_NEXT)', SQL_HANDLE_ENV, fhEnv);
    end;
  finally
    DriverList.EndUpdate;
    FreeMem(sDriverAttributesBuffer);
    FreeMem(sDriverDescBuffer);
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlDriverOdbc.Drivers', e);  raise; end; end;
    finally LogExitProc('TSqlDriverOdbc.Drivers'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TSqlConnectionOdbc }

constructor TSqlConnectionOdbc.Create(OwnerDbxDriver: TSqlDriverOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited Create;
  fhCon := SQL_NULL_HANDLE;
  fNativeErrorCode := 0;
  fSqlStateChars := '00000' + #0;
  fConnectionErrorLines := TStringList.Create;
  fConnected := False;
  fOwnerDbxDriver := OwnerDbxDriver;
  fOwnerDbxDriver.AllocHCon(fhCon);
  // set default connection fields:
  ClearConnectionOptions;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.Create', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSqlConnectionOdbc.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  disconnect;
  if (fhCon <> SQL_NULL_HANDLE) then
    fOwnerDbxDriver.FreeHCon(fhCon);
{$IFDEF _RegExprParser_}
  FreeAndNil(fObjectNameParser);
{$ENDIF}
  FreeAndNil(fConnectionErrorLines);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.Destroy', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlConnectionOdbc.CloneOdbcConnection(var HCon: SqlHDbc);
var
  OdbcRetcode: OdbcApi.SqlReturn;
  cbConnStrOut: SqlSmallint;
  aTempOdbcReturnedConnectString: PChar;
  AttrVal: SqlUInteger;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.CloneOdbcConnection'); try try {$ENDIF _TRACE_CALLS_}
  fOwnerDbxDriver.AllocHCon(HCon);
  aTempOdbcReturnedConnectString := AllocMem(OdbcReturnedConnectStringMax);
  try
  OdbcRetcode := SQLDriverConnect(
    HCon, 0,
    PAnsiChar(fOdbcReturnedConnectString), SQL_NTS,
    aTempOdbcReturnedConnectString, OdbcReturnedConnectStringMax, cbConnStrOut,
    SQL_DRIVER_NOPROMPT);
  if (OdbcRetcode <> OdbcApi.SQL_SUCCESS)and(OdbcRetcode <> OdbcApi.SQL_SUCCESS_WITH_INFO) then
    fOwnerDbxDriver.OdbcCheck(OdbcRetcode, 'CloneOdbcConnection - SQLDriverConnect (NoPrompt)',
      SQL_HANDLE_DBC, HCon);
  finally
    FreeMem(aTempOdbcReturnedConnectString);
  end;
  if fSupportsTransaction then
  begin
    // Synchronize Transaction Isolation Level: (added 2.06 - Vadim Lopushansky)
    OdbcRetCode := SQLGetConnectAttr(fhCon, SQL_ATTR_TXN_ISOLATION, @AttrVal, 0, nil);
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'CloneOdbcConnection - SQLGetConnectAttr(SQL_ATTR_TXN_ISOLATION)');
    OdbcRetCode := SQLSetConnectAttr(HCon, SQL_ATTR_TXN_ISOLATION, SqlPointer(AttrVal), 0);
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'CloneOdbcConnection - SQLSetConnectAttr(SQL_ATTR_TXN_ISOLATION)');
    // Synchronize fAutoCommitMode:
    // Vad>??? Probably it is necessary to put always in OFF ???
    // Ed> No, I think what you are doing here is correct!
    OdbcRetCode := SQLGetConnectAttr(fhCon, SQL_ATTR_AUTOCOMMIT, @AttrVal, 0, nil);
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'CloneOdbcConnection - SQLGetConnectAttr(SQL_ATTR_AUTOCOMMIT)');
    if AttrVal <> fAutoCommitMode then
    begin
      OdbcRetCode := SQLSetConnectAttr(HCon, SQL_ATTR_AUTOCOMMIT, SqlPointer(fAutoCommitMode), 0);
      if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetCode, 'CloneOdbcConnection - SQLSetConnectAttr(SQL_ATTR_AUTOCOMMIT)');
    end;
  end;
  //ConPacketSize:
   if (fConPacketSize > cConPacketSizeDefault) then
     SQLSetConnectAttr(HCon, SQL_ATTR_PACKET_SIZE, SqlPointer(fConPacketSize), 0);
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.CloneOdbcConnection', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.CloneOdbcConnection'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlConnectionOdbc.AllocHStmt(out HStmt: SqlHStmt);
var
  OdbcRetcode: OdbcApi.SqlReturn;
  aConnectionStatement: PConnectionStatement;

  function FindFreeConnection: PConnectionStatement;
  var
    i: Integer;
  begin
    for i := 0 to (fConnectionStatementList.Count - 1) do
    begin
      Result := fConnectionStatementList[i];
      if (Result.fhCon <> SQL_NULL_HANDLE) and (Result.fHStmt = SQL_NULL_HANDLE) then
        exit;
    end;
    Result := nil; // not found
  end;

begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.AllocHStmt'); try try {$ENDIF _TRACE_CALLS_}
  if (fStatementPerConnection <> 0) then
  begin
    aConnectionStatement := FindFreeConnection;
    if (aConnectionStatement = nil) then
    begin
      New(aConnectionStatement);
      Self.CloneOdbcConnection(aConnectionStatement^.fhCon);
      aConnectionStatement^.fHStmt := SQL_NULL_HANDLE;
      fConnectionStatementList.Add(aConnectionStatement);
    end;
    OdbcRetcode := SQLAllocHandle(SQL_HANDLE_STMT, aConnectionStatement^.fhCon, HStmt);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      fOwnerDbxDriver.OdbcCheck(OdbcRetcode, 'SQLAllocHandle(SQL_HANDLE_STMT)',
        SQL_HANDLE_STMT, aConnectionStatement^.fhCon);
    aConnectionStatement^.fHStmt := HStmt;
  end
  else
  begin
    OdbcRetcode := SQLAllocHandle(SQL_HANDLE_STMT, fhCon, HStmt);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      fOwnerDbxDriver.OdbcCheck(OdbcRetcode, 'SQLAllocHandle(SQL_HANDLE_STMT)',
        SQL_HANDLE_STMT, fhCon);
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.AllocHStmt', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.AllocHStmt'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlConnectionOdbc.FreeHStmt(out HStmt: SqlHStmt);
var
  OdbcRetcode: OdbcApi.SqlReturn;
  i: Integer;
  iConnectionStatement: PConnectionStatement;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.FreeHStmt'); try try {$ENDIF _TRACE_CALLS_}
  if HStmt = SQL_NULL_HANDLE then
    exit;
  if (fStatementPerConnection <> 0) then
  begin
    for i := 0 to (fConnectionStatementList.Count - 1) do
    begin
      iConnectionStatement := fConnectionStatementList[i];
      if (iConnectionStatement^.fHStmt = HStmt) then
      begin
        OdbcRetcode := SQLFreeHandle(SQL_HANDLE_STMT, HStmt);
        if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
          fOwnerDbxDriver.OdbcCheck(OdbcRetcode, 'SQLFreeHandle(SQL_HANDLE_STMT)',
            SQL_HANDLE_STMT, HStmt);
        HStmt := SQL_NULL_HANDLE;
        // Indicate that connection is free to be re-used...
        iConnectionStatement^.fHStmt := SQL_NULL_HANDLE;
        exit;
      end;
    end;
    //if we reach here, the statement handle was not found in the list
    raise
      EDbxInternalError.Create('TSqlConnectionOdbc.FreeHStmt - Statement handle was not found in list');
  end
  else
  begin
    OdbcRetcode := SQLFreeHandle(SQL_HANDLE_STMT, HStmt);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLFreeHandle(SQL_HANDLE_STMT)');
    HStmt := SQL_NULL_HANDLE;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.FreeHStmt', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.FreeHStmt'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlConnectionOdbc.OdbcCheck(OdbcCode: SqlReturn; const OdbcFunctionName: string);
begin
  fOwnerDbxDriver.OdbcCheck(OdbcCode, OdbcFunctionName, SQL_HANDLE_DBC, fhCon, Self);
end;

procedure TSqlConnectionOdbc.GetCurrentCatalog;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  aCurrentCatalogLen: SqlInteger;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.GetCurrentCatalog'); try try {$ENDIF _TRACE_CALLS_}
  if fSupportsCatalog then
  begin
    if fCurrentCatalog = nil then
      fCurrentCatalog := AllocMem(fOdbcMaxCatalogNameLen + 1);
    OdbcRetcode := SQLGetConnectAttr(
      fhCon,
      SQL_ATTR_CURRENT_CATALOG,
      fCurrentCatalog,
      fOdbcMaxCatalogNameLen,
      @aCurrentCatalogLen);
    {+2.01 Workaround for bad old ODBC drivers}
    //Vadim V.Lopushansky :
    //Vadim> ???Vad>All: For old ODBC Drivers (example: INTERSOLV Inc ODBC Drivers 1997 )
    //Edward> This looks OK, but I cannot test as I do not have such old drivers.
    //Edward> (But really, no one should be using drivers 5 years old!)
    if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
    begin
      fSupportsCatalog := False;
      FreeMemAndNil(fCurrentCatalog);
    end;
    //ORIGINAL CODE:
    //if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
    //  OdbcCheck(OdbcRetCode, 'SQLGetConnectAttr(SQL_ATTR_CURRENT_CATALOG)');
    {/+2.01 /Workaround for bad old ODBC drivers}
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.GetCurrentCatalog', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.GetCurrentCatalog', ['fCurrentCatalog=', fCurrentCatalog]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.beginTransaction(
  TranID: Longword): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  aTranID: pTTransactionDesc;
  NewOdbcIsolationLevel: SqlUInteger;
begin
  {$IFDEF _TRACE_CALLS_}
    LogEnterProc('TSqlConnectionOdbc.beginTransaction', ['TranID=', GetTransactionDescStr(pTTransactionDesc(TranID))]); Result := SQL_SUCCESS; try try
  {$ENDIF _TRACE_CALLS_}
  {
    Transactions in ODBC are not explicitly initiated.
    But we must make sure we are in Manual Commit Mode.
    Also, if a statement is executed after the transation has been committed,
    without another call to beginTransaction, we must go back to Auto Commit mode
    (see procedure TransactionCheck)
  }
  if fSupportsTransaction then
  try
    if fInTransaction then
      raise EDbxInvalidCall.Create(
        'TSqlConnectionOdbc.beginTransaction - Cannot start a new transaction because a transaction is already actuve. (ODBC does not support nested transactions.)');
    aTranID := pTTransactionDesc(TranId);
    case aTranId.IsolationLevel of
      // Note that ODBC defines an even higher level of isolation, viz, SQL_TXN_SERIALIZABLE;
      // In this mode, Phantoms are not possible. (See ODBC spec).
      xilREPEATABLEREAD:
        // Dirty reads and nonrepeatable reads are not possible. Phantoms are possible
        NewOdbcIsolationLevel := SQL_TXN_REPEATABLE_READ;
      xilREADCOMMITTED:
        // Dirty reads are not possible. Nonrepeatable reads and phantoms are possible
        NewOdbcIsolationLevel := SQL_TXN_READ_COMMITTED;
      xilDIRTYREAD:
        // Dirty reads, nonrepeatable reads, and phantoms are possible.
        NewOdbcIsolationLevel := SQL_TXN_READ_UNCOMMITTED;
      xilCUSTOM:
        // Custom Level
        NewOdbcIsolationLevel := aTranID.CustomIsolation;
    else
      raise
        EDbxInvalidCall.Create('TSqlConnectionOdbc.beginTransaction(TranID)' +
          ' invalid isolation value: ' + IntToStr(Ord(aTranId.IsolationLevel)));
    end;
    OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_ATTR_TXN_ISOLATION,
      Pointer(NewOdbcIsolationLevel), 0);
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLSetConnectAttr(SQL_ATTR_TXN_ISOLATION)');
    fOdbcIsolationLevel := NewOdbcIsolationLevel;
    if (fAutoCommitMode = SQL_AUTOCOMMIT_ON) then
    begin
      OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_ATTR_AUTOCOMMIT,
        Pointer(Smallint(SQL_AUTOCOMMIT_OFF)), 0);
      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLSetConnectAttr(SQL_ATTR_AUTOCOMMIT, SQL_AUTOCOMMIT_OFF)');
      fAutoCommitMode := SQL_AUTOCOMMIT_OFF;
    end;
    fInTransaction := True;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      fConnectionErrorLines.Add(E.Message);
      // Next line unneccessary - connection string already added in OdbcCheck
      //    fConnectionErrorLines.Add('Connection string: ' + fOdbcConnectStringHidePassword);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end
  else
  begin
    fInTransaction := True;
    Result := DBXpress.SQL_SUCCESS;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.beginTransaction', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.beginTransaction'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.commit(TranID: Longword): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.commit', ['TranID=', TranID]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if fSupportsTransaction then
  try
    OdbcRetcode := SQLEndTran(SQL_HANDLE_DBC, fhCon, SQL_COMMIT);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLEndTran');
    fInTransaction := False;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      fConnectionErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end
  else
  begin
    fInTransaction := False;
    Result := DBXpress.SQL_SUCCESS;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.commit', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.commit'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlConnectionOdbc.ClearConnectionOptions;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.ClearConnectionOptions'); try try {$ENDIF _TRACE_CALLS_}
  // default connection fields:
  fWantQuotedTableName := True;
  fConnBlobSizeLimitK := fOwnerDbxDriver.fDrvBlobSizeLimitK;
  // disconnect:
  FreeMemAndNil(fOdbcReturnedConnectString);
  fOdbcDriverName := '';
  fOdbcDriverType := eOdbcDriverTypeUnspecified;
  FreeMemAndNil(fCurrentCatalog);
  // default extended fields:
  FillChar(fConnectionOptions, Length(fConnectionOptions), osDefault);
  fBlobChunkSize := cBlobChunkSizeDefault;
  fConPacketSize := cConPacketSizeDefault;
  fOdbcDriverLevel := 3;
  fSupportsBlockRead := True;
  fDbmsName := '';
  fConnConnectionString := '';
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.ClearConnectionOptions', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.ClearConnectionOptions'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{Parse options in string:}
function GetOptionValue(var ConnectString: string; const OptionName: string;
  HideOption: Boolean = False; TrimResult: Boolean = True; bOneChar: Boolean = False;
  const HideTemplate: string = ''): string;
var
  pLeft, pRight: Integer;
  sLeft, sVal: string;
  sUprConnectString: String;
  cLeft, lRight, cLeftVal, cTmp: PAnsiChar;
  bIsValue: Boolean;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('GetOptionValue',['OptionName=', OptionName, 'Options=', ConnectString]); try try {$ENDIF _TRACE_CALLS_}
  Result := #0; // when result is #0 then value not found, but if result='' then value is empty
  sUprConnectString := UpperCase(ConnectString);
  // seek to option name
  cLeft := StrPos( PAnsiChar(sUprConnectString), PAnsiChar(OptionName) );
  if cLeft=nil then
    exit;
  lRight := PAnsiChar(@sUprConnectString[Length(sUprConnectString)]);// pointed to last symbol
  bIsValue := False;
  repeat
    begin
      // check right limitation
      cLeftVal := cLeft;
      inc(cLeftVal, Length(OptionName));// seek to last symbol in OptionName
      if DWORD(cLeftVal) >= DWORD(lRight) then
        break;
      // seek to symbol '='
      while cLeftVal^<>#0 do
      begin
        if cLeftVal^='=' then
        begin
          inc(cLeftVal,2);
          bIsValue := True;
          break;
        end
        else
        if cLeftVal ^ in [#9, #10, #13, #32] then
          inc(cLeftVal)
        else
          break;
      end;
      if bIsValue then
      begin
        // search left delimiter ';' or start pos sUprConnectString:
        cTmp := cLeft-1;
        while cTmp >= PAnsiChar(sUprConnectString) do
        begin
          if cTmp^=';' then
            break
          else
          if cTmp^ in [#9, #10, #13, #32] then
            dec(cTmp)
          else
          begin
            bIsValue := False;
            break;
          end;
        end;
        if bIsValue then
          break;
      end;
      // seek to next same option name
      cLeft := StrPos( cLeftVal, PAnsiChar(OptionName) );
    end
  until (cLeft=nil);
  if bIsValue then
  begin
    pLeft := DWORD(cLeft)-DWORD(PAnsiChar(sUprConnectString));
    sLeft := Copy(ConnectString, 1, pLeft - 1);
    pRight := DWORD(cLeftVal)-DWORD(PAnsiChar(sUprConnectString));
    pLeft := pRight;
    while (pRight <= Length(ConnectString)) and (ConnectString[pRight] <> ';') do
      Inc(pRight);
    sVal := Copy(ConnectString, pLeft, pRight - pLeft);
    if HideOption then
    begin
      if HideTemplate ='' then
      begin
        // remove options value and name
        ConnectString := StringReplace(
          sLeft + Copy(ConnectString, pRight, Length(ConnectString) - pRight + 1),
          ';;', ';', [rfReplaceAll, rfIgnoreCase]
          )
      end
      else // hide only value
      if Length(HideTemplate)>1 then
      begin // replace value to template
        ConnectString :=
          Copy(ConnectString, 1, pLeft-1) +
          HideTemplate +
          Copy(ConnectString, pRight, Length(ConnectString) - pRight + 1);
      end
      else // replace value each char to template first char
      begin
        for pLeft := pLeft to pRight do
          ConnectString[pLeft] := HideTemplate[1];
      end;
    end;
    if TrimResult then
      Result := Trim(sVal)
    else
      Result := sVal;
    if bOneChar then
      Result := (Result+' ')[1];
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('GetOptionValue', e);  raise; end; end;
    finally LogExitProc('GetOptionValue'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.connect(
  ServerName: PChar;
  UserName: PChar;
  Password: PChar
  ): SQLResult;

// ServerName is either the ODBC DSN name (must be already set up in ODBC admin)
// or it is the complete ODBC connect string (to allow complete flexibility)
// In this case, the UserName and Password are passed only if they are not blank
// (Because you might want to specifiy the UID and PWD in the FileDsn, for example)
//
// Example using DSN name
//   ServerName: 'ODBCDSN'
//   UserName:   'USER'
//   Password:   'SECRET'
//
// Examples using ODBC connect string:
//   ServerName: 'DSN=Example;UID=USER;PWD=SECRET'
//   ServerName: 'DSN=Example;DB=MyDB;HOSTNAME=MyHost;TIMEOUT=10;UID=USER;PWD=SECRET''
//   ServerName: 'FILEDSN=FileDsnExample'
//   ServerName: 'DRIVER=Microsoft Access Driver (*.mdb);DBQ=c:\work\odbctest\odbctest.mdb'
//

  function HidePassword(const ConnectString: string): string;
  begin
    Result := ConnectString;
    if GetOptionValue(Result, 'PWD',
      {HideOption=}True,{TrimResult=}False, {bOneChar=}False, {HideTemplate=}'***') = #0
    then
      GetOptionValue(Result, 'PASSWORD',
      {HideOption=}True,{TrimResult=}False, {bOneChar=}False, {HideTemplate=}'***');
  end;

{$IFDEF _TRACE_CALLS_}
  const
    cLogOptionSwitchesValues: array[TOptionSwitches]of string =('osDefault', 'osOff', 'osOn');
    cLogConnectionOptionsNames: array[TConnectionOption] of string = (
      'coSupportsMetadata',
      'coSupportsSchemaFilter',
      'coTrimChar',
      'coMapInt64ToBcd',
      'coMapSmallBcdToNative',
      'coSupportsCatalog',
      'coIgnoreUnknownFieldType',
      'coMapCharAsBDE',
      'coEmptyStrParam',
      'coMixedFetch',
      'coEnableBCD',
      'coMaxBCD'
    );
{$ENDIF}
var
  OdbcRetcode: OdbcApi.SqlReturn;
{$IFDEF MSWINDOWS}
  ParentWindowHandle: HWND;
{$ELSE}
  ParentWindowHandle: Integer;
{$ENDIF}
  cbConnStrOut: SqlSmallint;
  FunctionSupported: SqlUSmallint;
  aBuffer: array[0..1] of Char;
  StringLength: SqlSmallint;
  tmpS: string;
  // Cache ConnectionOptions from Database property in following variables:
  i: TConnectionOption;
  ConnectionOptionsValues: TConnectionOptionsNames;
  vBlobChunkSize: Integer;
  vConPacketSize: Integer;

  sUserName: string;
  sPassword: String;

  Len: Smallint;
  aOdbcSchemaUsage: SqlUInteger;
  aOdbcCatalogUsage: SqlUInteger;
  aOdbcGetDataExtensions: SqlUInteger;
  aConnectionStatement: PConnectionStatement;

  bIsConnConnectionString: Boolean;

 {$IFDEF _MULTIROWS_FETCH_}
 {$IFDEF _MIXED_FETCH_}
  fHStmt: SqlHStmt;
 {$ENDIF IFDEF _MULTIROWS_FETCH_}
 {$ENDIF IFDEF _MIXED_FETCH_}

  procedure MergeAndSetConnOptions; // initiate connection boolean options
  var
    i: TConnectionOption;
  begin
    for i := Low(TConnectionOption) to High(TConnectionOption) do
    begin
      if fConnectionOptions[i] = osDefault then
      // when custom option is undefined then fill it from driver options
        fConnectionOptions[i] := fConnectionOptionsDrv[i];
      if fConnectionOptions[i] = osDefault then
      // when options is undefined then set is from common default options
        fConnectionOptions[i] := cConnectionOptionsDefault[i];
    end;
  end;

begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.connect', ['ConnectString=', fConnConnectionString, 'ServerName=', ServerName, 'UserName=', UserName, 'Password=', Password]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Result := DBXpress.SQL_SUCCESS;
  if fConnected then
    exit;

  bIsConnConnectionString := Length(fConnConnectionString)>0;

  for i := Low(TConnectionOption) to High(TConnectionOption) do
    ConnectionOptionsValues[i] := '';

  try
    // Read ConnectionString User Options. Need hide this option for next analyses.

      // '=' in connect string: it is a Custom ODBC Connect String
      if bIsConnConnectionString then
      begin
        fOdbcConnectString := fConnConnectionString;
        fDbxCatalog := StrPas(ServerName);
        if Length(fDbxCatalog) > 0 then
        begin // replace DATABASE Option

          // select DATABASE/Catalog option
          tmpS := GetOptionValue(fDbxCatalog, 'DATABASE');
          if tmpS <> #0 then
          begin
            // remove DATABASE option from Connection String
            GetOptionValue(fOdbcConnectString, 'DATABASE', True);

            if (Length(fOdbcConnectString)>0) and
              (fOdbcConnectString[Length(fOdbcConnectString)]<>';')
            then
              fOdbcConnectString := fOdbcConnectString + ';';

            fDbxCatalog := tmpS;
            fOdbcConnectString := fOdbcConnectString + 'DATABASE='+fDbxCatalog;
          end
          else
          begin
            if (Length(fOdbcConnectString)>0) and
              (fOdbcConnectString[Length(fOdbcConnectString)]<>';')
            then
              fOdbcConnectString := fOdbcConnectString + ';';
            // The user can specify a name of parameter of a database completely.
            // It is necessary when the name of parameter is distinct from 'DATABASE'
            // For example for MSAccess:
            // DBQ=C:\mydatabase.mdb
            fOdbcConnectString := fOdbcConnectString + fDbxCatalog;
          end;
        end;
      end
      else
        fOdbcConnectString := StrPas(ServerName);

      sUserName := StrPas(UserName);
      sPassword := StrPas(Password);

      {Parse custom options (Parse ConnectionOptions in Database property string)}
      for i := Low(TConnectionOption) to High(TConnectionOption) do
      begin
        ConnectionOptionsValues[i] := GetOptionValue(fOdbcConnectString,
          cConnectionOptionsNames[i], True);
        if (ConnectionOptionsValues[i] <> #0) and not SetConnectionOption(fConnectionOptions, nil,
          i, (ConnectionOptionsValues[i] + ' ')[1] )
        then
          ConnectionOptionsValues[i] := #0;
      end;

      //BlobChunkSize:
      vBlobChunkSize := StrToIntDef(GetOptionValue(fOdbcConnectString, cBlobChunkSize, True), -1);
      if vBlobChunkSize > 0 then
      begin
        if vBlobChunkSize < 256 then
          vBlobChunkSize := 256
        else if vBlobChunkSize > cBlobChunkSizeLimit then
          vBlobChunkSize := cBlobChunkSizeLimit;
        fBlobChunkSize := vBlobChunkSize;
      end;

      //ConPacketSize:
      vConPacketSize := StrToIntDef(GetOptionValue(fOdbcConnectString, cConPacketSize, True), 0);
      if (vConPacketSize > cConPacketSizeDefault) then
        fConPacketSize := vConPacketSize;
      if (fConPacketSize > cConPacketSizeDefault) then
      begin
        OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_ATTR_PACKET_SIZE, Pointer(fConPacketSize), 0);
        if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
          fConPacketSize := cConPacketSizeDefault;
      end;

      // remove last <;> for correction save fDbxCatalog
      if (Length(fOdbcConnectString)>0)and(fOdbcConnectString[Length(fOdbcConnectString)]=';') then
        SetLength(fOdbcConnectString, Length(fOdbcConnectString)-1);

    // SqlExpr calls SetCatalog for the server name after connect,
    // so save server name to enable check for this case and bypass the call

    if not bIsConnConnectionString then
      fDbxCatalog := fOdbcConnectString;

    if Pos('=', fOdbcConnectString) = 0 then
    begin
      // No '=' in connect string: it is a normal Connect String
      if not ((Length(fOdbcConnectString) = 0) or (fOdbcConnectString[1] = '?')) then
        fOdbcConnectString := 'DSN=' + fOdbcConnectString;
      if (sUserName <> '') then
        fOdbcConnectString := fOdbcConnectString + ';UID=' + UserName + ';';
      fOdbcConnectStringHidePassword := fOdbcConnectString;
      if (sUserName <> '') then
      begin
        fOdbcConnectString := fOdbcConnectString + ';PWD=' + sPassword + ';';
        fOdbcConnectStringHidePassword := fOdbcConnectStringHidePassword + 'PWD=***;';
      end;
    end
    else { if Pos('=', fOdbcConnectString) <> 0 }
    begin

      // Check to see if User Id already specified in connect string -
      // If not already specified in connect string,
      // we use UserName passed in the Connect function call (if non-blank)
      if (sUserName <> '') and
        ( GetOptionValue(fOdbcConnectString, 'UID')=#0 ) and
        ( GetOptionValue(fOdbcConnectString, 'USERID')=#0 )
      then
        fOdbcConnectString := fOdbcConnectString + ';UID=' + sUserName;

      // Check to see if Password already specified in connect string -
      // If not already specified in connect string,
      // we use Password passed in the Connect function call (if non-blank)
      if (sPassword <> '') and
        ( GetOptionValue(fOdbcConnectString, 'PWD')=#0 ) and
        ( GetOptionValue(fOdbcConnectString, 'PASSWORD')=#0 )
      then
        fOdbcConnectString := fOdbcConnectString + ';PWD=' + sPassword;

      fOdbcConnectStringHidePassword := HidePassword(fOdbcConnectString);

    end; //of: else {if Pos('=', fOdbcConnectString) <> 0 }

    fOdbcReturnedConnectString := AllocMem(OdbcReturnedConnectStringMax);

{$IFDEF MSWINDOWS}
    {+2.01}
    //Vadim> ???Vad>Ed/All: If process is not NT service (need checked)
    //Edward> When doing SQLDriverConnect, the Driver manager and/or Driver may display a
    //Edward> dialog box to prompt user for additional connect parameters.
    //Edward> So SQLDriverConnect has a Window Handle Parameter to use as the parent.
    //Edward> In Windows I pass the Active Window handle for this parameter,
    //Edward> but in Kylix, I do not know the equivalent call, so I just pass 0.
    {/+2.01}
    ParentWindowHandle := Windows.GetActiveWindow;
{$ELSE}
    ParentWindowHandle := 0;
{$ENDIF}

    if ((Length(fOdbcConnectString) = 0) or (fOdbcConnectString[1] = '?')) then
    begin
      OdbcRetcode := SQLDriverConnect(
        fhCon,
        ParentWindowHandle,
        PAnsiChar(fOdbcConnectString), SQL_NTS,
        fOdbcReturnedConnectString, OdbcReturnedConnectStringMax, cbConnStrOut,
        // SQL_DRIVER_NOPROMPT);
        // SQL_DRIVER_PROMPT);
        SQL_DRIVER_COMPLETE_REQUIRED);
      // SQL_DRIVER_COMPLETE);
      if (OdbcRetcode = OdbcApi.SQL_NO_DATA) then
      begin
        if (StrPas(fOdbcReturnedConnectString)<>'?') and (StrLen(fOdbcReturnedConnectString)>0) then
          Result := DBXpress.DBXERR_INVALIDUSRPASS // DBXERR_INVALIDPARAM
        else
        begin
          fConnectionErrorLines.Add('User unselected ODBC DNS Name');
          Result := MaxReservedStaticErrors + 1;
        end;
        ClearConnectionOptions;
        exit; // User Clicked Cancel
      end;
      if (OdbcRetcode <> OdbcApi.SQL_SUCCESS)and(OdbcRetcode <> OdbcApi.SQL_SUCCESS_WITH_INFO) then
        OdbcCheck(OdbcRetcode, 'SQLDriverConnect (Driver Complete Required)');
      fOdbcConnectString := fOdbcReturnedConnectString;
      fOdbcConnectStringHidePassword := HidePassword(fOdbcReturnedConnectString);
      fConnected := True;
    end
    else
    begin
      OdbcRetcode := SQLDriverConnect(
        fhCon,
        ParentWindowHandle,
        PAnsiChar(fOdbcConnectString), SQL_NTS,
        fOdbcReturnedConnectString, OdbcReturnedConnectStringMax, cbConnStrOut,
        SQL_DRIVER_NOPROMPT);
      //  SQL_DRIVER_PROMPT);
      //  SQL_DRIVER_COMPLETE_REQUIRED);
      //  SQL_DRIVER_COMPLETE);
      if (OdbcRetcode <> OdbcApi.SQL_SUCCESS)and(OdbcRetcode <> OdbcApi.SQL_SUCCESS_WITH_INFO) then
        OdbcCheck(OdbcRetcode, 'SQLDriverConnect (NoPrompt)');
      fConnected := True;
    end;

{$IFNDEF _InternalCloneConnection_}
    // Vadim V.Lopushansky:
    // for support cloning connection when returning database connection string
    for i := Low(TConnectionOption) to High(TConnectionOption) do
    begin
      if ConnectionOptionsValues[i] <> #0 then
        fOdbcConnectString := fOdbcConnectString +
          ';' + cConnectionOptionsNames[i] + '=' + ConnectionOptionsValues[i];
    end;
    if fBlobChunkSize <> cBlobChunkSizeDefault then
      fOdbcConnectString := fOdbcConnectString + ';' + cBlobChunkSize + '=' +
        IntToStr(fBlobChunkSize);
    if fConPacketSize <> cConPacketSizeDefault then
      fOdbcConnectString := fOdbcConnectString + ';' + cConPacketSize + '=' +
        IntToStr(fConPacketSize);
{$ENDIF}

    ReallocMem(fOdbcReturnedConnectString, cbConnStrOut + 1);


    RetrieveDriverName;

    //We unite of set-up of the user to customizations of the driver
    // Set-up of the user have the greater priority before customizations defined automatically
    MergeAndSetConnOptions;

    // Parsing default(current) SchemaName. It is equal logoon UserName
    tmpS := StrPas(fOdbcReturnedConnectString);
    sUserName := GetOptionValue(tmpS, 'UID', True, False);
    if sUserName = #0 then
    begin
      sUserName := GetOptionValue(tmpS, 'USERID');
      if sUserName = #0 then
        sUserName := '';
    end;
    fCurrentSchema := sUserName;

    if fConnectionOptions[coSupportsCatalog] = osOn then
    begin
      OdbcRetcode := SQLGetInfoString(fhCon, SQL_CATALOG_NAME, @aBuffer,
        SizeOf(aBuffer), StringLength);
      fSupportsCatalog := (OdbcRetcode = OdbcApi.SQL_SUCCESS) and (aBuffer[0] = 'Y');
      if not fSupportsCatalog then
        fConnectionOptions[coSupportsCatalog] := osOff;
    end
    else
      fSupportsCatalog := False;

    // IBM DB2 has driver-specific longdata type, but setting this option makes it ODBC compatible:
    if Self.fOdbcDriverType = eOdbcDriverTypeIbmDb2 then
    begin
      OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_LONGDATA_COMPAT,
        SqlPointer(SQL_LD_COMPAT_YES), 0);
      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLSetConnectAttr(SQL_LONGDATA_COMPAT)');
    end;

    // INFORMIX has driver-specific longdata type, but setting this option makes it ODBC compatible:
    if (Self.fOdbcDriverType = eOdbcDriverTypeInformix)
        and (StrLComp( PChar(UpperCase(fOdbcDriverName)), 'ICLI', 4) = 0) // (It is meaningful only for the native informix driver)
    then
    begin
      SQLSetConnectAttr(fhCon, SQL_INFX_ATTR_LO_AUTOMATIC, SqlPointer(SQL_TRUE), 0);
    end;

    {+2.43}
    // MSSQL SERVER: The situation with a mistake of cloning connection is corrected at connection
    // through PIPE.
    if (Self.fOdbcDriverType = eOdbcDriverTypeMsSqlServer) then
    begin
      tmpS := StrPas(fOdbcReturnedConnectString);
      tmpS := GetOptionValue(tmpS, 'NETWORK', False);
      if (tmpS<>#0) and (Pos('\\.\PIPE\', UpperCase(tmpS))>0) then
      begin
        // remove options "Network":
        tmpS := StrPas(fOdbcReturnedConnectString);
        GetOptionValue(tmpS, 'NETWORK', True); // remove option 'NETWORK'
        ReallocMem(fOdbcReturnedConnectString, Length(tmpS));
        StrCopy(fOdbcReturnedConnectString, PChar(tmpS));
      end;
    end;
    {/+2.43}

    OdbcRetcode := SQLGetInfoInt(fhCon, SQL_SCHEMA_USAGE, aOdbcSchemaUsage,
      SizeOf(aOdbcSchemaUsage), nil);
    if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
      aOdbcSchemaUsage := 0;
    fSupportsSchemaDML := ((aOdbcSchemaUsage and SQL_SU_DML_STATEMENTS) <> 0);
    fSupportsSchemaProc := ((aOdbcSchemaUsage and SQL_SU_PROCEDURE_INVOCATION) <> 0);

    OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_COLUMN_NAME_LEN, fOdbcMaxColumnNameLen,
      SizeOf(fOdbcMaxColumnNameLen), nil);
    if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
      fOdbcMaxColumnNameLen := 64;
    OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_TABLE_NAME_LEN, fOdbcMaxTableNameLen,
      SizeOf(fOdbcMaxTableNameLen), nil);
    if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
      fOdbcMaxTableNameLen := 128;
    if fSupportsCatalog then
    begin
      OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_CATALOG_NAME_LEN, fOdbcMaxCatalogNameLen,
        SizeOf(fOdbcMaxCatalogNameLen), nil);
      if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
        fSupportsCatalog := False;
      OdbcRetcode := SQLGetInfoInt(fhCon, SQL_CATALOG_USAGE, aOdbcCatalogUsage,
        SizeOf(aOdbcCatalogUsage), nil);
      if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
        aOdbcCatalogUsage := 0;
      fSupportsCatalogDML := ((aOdbcCatalogUsage and SQL_CU_DML_STATEMENTS) <> 0);
      fSupportsCatalogProc := ((aOdbcCatalogUsage and SQL_CU_PROCEDURE_INVOCATION) <> 0);
    end;

    OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_SCHEMA_NAME_LEN, fOdbcMaxSchemaNameLen,
      SizeOf(fOdbcMaxSchemaNameLen), nil);
    if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
      fOdbcMaxSchemaNameLen := 0;

    OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_IDENTIFIER_LEN, fOdbcMaxIdentifierLen,
      SizeOf(fOdbcMaxIdentifierLen), nil);
    if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
      fOdbcMaxIdentifierLen := 128;

    OdbcRetcode := SQLGetFunctions(fhCon, SQL_API_SQLSTATISTICS, FunctionSupported);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLGetFunctions(SQL_API_SQLSTATISTICS)');
    fSupportsSQLSTATISTICS := (FunctionSupported = OdbcApi.SQL_TRUE);
    OdbcRetcode := SQLGetFunctions(fhCon, SQL_API_SQLPRIMARYKEYS, FunctionSupported);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLGetFunctions(SQL_API_SQLPRIMARYKEYS)');
    fSupportsSQLPRIMARYKEYS := (FunctionSupported = OdbcApi.SQL_TRUE);

    OdbcRetcode := SQLGetInfoInt(fhCon, SQL_GETDATA_EXTENSIONS, aOdbcGetDataExtensions,
      SizeOf(aOdbcGetDataExtensions), nil);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      //OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_GETDATA_EXTENSIONS');
      aOdbcGetDataExtensions := 0;
  (*

  SQL_GD_ANY_COLUMN = SQLGetData can be called for any unbound column,
  including those before the last bound column.
  Note that the columns must be called in order of ascending column number
  unless SQL_GD_ANY_ORDER is also returned.

  SQL_GD_ANY_ORDER = SQLGetData can be called for unbound columns in any order.
  Note that SQLGetData can be called only for columns after the last bound column
  unless SQL_GD_ANY_COLUMN is also returned.
  *)
    fGetDataAnyColumn := ((aOdbcGetDataExtensions and SQL_GD_ANY_COLUMN) <> 0);

  (*

  SQL_GD_BLOCK:
  http://msdn.microsoft.com/library/default.asp?url=/library/en-us/odbc/htm/odch21epr_3.asp

  As SQLFetch returns each row, it places the data for each bound column in the buffer
  bound to that column. If no columns are bound, SQLFetch does not return any data but
  does move the block cursor forward. The data can still be retrieved with SQLGetData.
  If the cursor is a multirow cursor (that is, the SQL_ATTR_ROW_ARRAY_SIZE is greater than
   1), SQLGetData can be called only if SQL_GD_BLOCK is returned when SQLGetInfo is called
   with an InfoType of SQL_GETDATA_EXTENSIONS. (For more information, see SQLGetData.)
  *)

    if fSupportsBlockRead then
    begin
      fSupportsBlockRead := ((aOdbcGetDataExtensions and SQL_GD_BLOCK) <> 0);
      {$IFDEF _MULTIROWS_FETCH_}
      {$IFDEF _MIXED_FETCH_} // Check supported SQL_CURSOR_STATIC
      if fSupportsBlockRead and (fConnectionOptions[coMixedFetch] = osOn) then
      begin
        fHStmt := SQL_NULL_HANDLE;
        AllocHStmt(fHStmt);
        try
          OdbcRetcode := SQLSetStmtAttr(fHStmt, SQL_ATTR_CURSOR_TYPE,
            SqlPointer(SQL_CURSOR_STATIC), 0);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            fConnectionOptions[coMixedFetch] := osOff;
        except
          fConnectionOptions[coMixedFetch] := osOff;
        end;
        FreeHStmt(fHStmt);
      end;
      {$ENDIF IFDEF _MULTIROWS_FETCH_}
      {$ENDIF IFDEF _MIXED_FETCH_}
    end
    else
      fConnectionOptions[coMixedFetch] := osOff;

    GetMetaDataOption(eMetaObjectQuoteChar, @fQuoteChar, 1, Len);

{$IFDEF _RegExprParser_}
    FreeAndNil(fObjectNameParser);
    fObjectNameParser := TObjectNameParser.Create(DbmsObjectNameTemplateInfo[fDbmsType],
      StrPas(@fQuoteChar));
  {$IFDEF _TRACE_CALLS_}
    OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_CONCURRENT_ACTIVITIES,
      fStatementPerConnection, 2, nil);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(SQL_MAX_CONCURRENT_ACTIVITIES)');
  {$ENDIF _TRACE_CALLS_}
{$ENDIF}

    OdbcRetcode := SQLGetConnectAttr(fhCon, SQL_ATTR_AUTOCOMMIT, @fAutoCommitMode, 0, nil);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      fSupportsTransaction := False
      //OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(SQL_ATTR_AUTOCOMMIT)');
    else
      CheckTransactionSupport;

    // Get max no of statements per connection.
    // If necessary, we will internally clone connection for databases that
    // only support 1 statement handle per connection, such as MsSqlServer
    OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_CONCURRENT_ACTIVITIES,
      fStatementPerConnection, 2, nil);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(SQL_MAX_CONCURRENT_ACTIVITIES)');
    if (fStatementPerConnection <> 0) then
    begin
      // Create the Connection + Statement cache, for databases that support
      // only 1 statement per connection
      fConnectionStatementList := TList.Create;
      New(aConnectionStatement);
      aConnectionStatement^.fhCon := fhCon;
      aConnectionStatement^.fHStmt := SQL_NULL_HANDLE;
      fConnectionStatementList.Add(aConnectionStatement);
    end;

{$IFDEF _TRACE_CALLS_}
  LogInfoProc(['07-SupportsCatalog =', fSupportsCatalog]);
  if fSupportsCatalog then
    LogInfoProc(['08-MaxCatalogNameLen =', fOdbcMaxCatalogNameLen]);
  LogInfoProc(['09-MaxSchemaNameLen =', fOdbcMaxSchemaNameLen]);
  LogInfoProc(['10-MaxTableNameLen =', fOdbcMaxTableNameLen]);
  LogInfoProc(['11-MaxColumnNameLen =', fOdbcMaxColumnNameLen]);
  LogInfoProc(['12-QuoteChar =', '<'+StrPas(PAnsiChar(@fQuoteChar))+'>']);
  LogInfoProc(['13-MaxIdentifierLen =', fOdbcMaxIdentifierLen]);
  LogInfoProc(['14-SupportsSQLSTATISTICS =', fSupportsSQLSTATISTICS]);
  LogInfoProc(['15-SupportsSQLPRIMARYKEYS =', fSupportsSQLPRIMARYKEYS]);
  LogInfoProc(['16-GetDataAnyColumn =', fGetDataAnyColumn]);
  LogInfoProc(['17-AutoCommitMode =', fAutoCommitMode]);
  LogInfoProc(['18-SupportsTransaction =', fSupportsTransaction]);
  LogInfoProc(['19-StatementPerConnection =', fStatementPerConnection]);
  LogInfoProc(['20-'+cBlobChunkSize+' =',fBlobChunkSize]);
  LogInfoProc(['21-SupportsBlockRead =', fSupportsBlockRead]);
  if (fConPacketSize > cConPacketSizeDefault) then
    LogInfoProc(['22-'+cConPacketSize+'=', fConPacketSize])
  else
    LogInfoProc(['22-'+cConPacketSize+' = "Default"']);
  for i := Low(TConnectionOption) to High(TConnectionOption) do
  begin
    LogInfoProc([IntToStr(23+Byte(i))+'-'+cLogConnectionOptionsNames[i]+' =',
      cLogOptionSwitchesValues[fConnectionOptions[i]] ]);
  end;
{$ENDIF} // of: IFDEF _TRACE_CALLS_

    Result := DBXpress.SQL_SUCCESS;

  except
    on E: Exception{EDbxError} do
    begin
      fConnectionErrorLines.Add(E.Message);
      //fConnectionErrorLines.Add('Connection string: ' + fOdbcConnectStringHidePassword);
      Result := MaxReservedStaticErrors + 1;
      if fConnected then
        disconnect
      else
        ClearConnectionOptions;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.connect', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.connect'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.disconnect: SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  i: Integer;
  iConnectionStatement: PConnectionStatement;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.disconnect'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    if (fStatementPerConnection <> 0) and (fConnectionStatementList <> nil) then
    begin
      for i := (fConnectionStatementList.Count - 1) downto 1{0 is qual main fhCon} do
      begin
        iConnectionStatement := fConnectionStatementList[i];
        fConnectionStatementList.Delete(i);
        if fConnected then
        begin
          OdbcRetcode := SQLDisconnect(iConnectionStatement.fhCon);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            fOwnerDbxDriver.OdbcCheck(OdbcRetcode, 'SQLDisconnect',
              SQL_HANDLE_DBC, iConnectionStatement.fhCon);
        end;
        fOwnerDbxDriver.FreeHCon(iConnectionStatement.fhCon);
        Dispose(iConnectionStatement);
      end;
      FreeAndNil(fConnectionStatementList);
    end;
    if (fhCon <> SQL_NULL_HANDLE) and fConnected then
    begin
      {+2.042}
      { TODO : Edward - Need to double-check - This is questionable }
      if fInTransaction and (fAutoCommitMode = SQL_AUTOCOMMIT_OFF) then
      begin
        OdbcRetcode := SQLEndTran(SQL_HANDLE_DBC, fhCon, SQL_ROLLBACK);
        if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
          OdbcCheck(OdbcRetcode, 'SQLEndTran');
      end;
      {/+2.042}
      OdbcRetcode := SQLDisconnect(fhCon);
      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLDisconnect');
    end;
    fConnected := False;
{$IFDEF _RegExprParser_}
    FreeAndNil(fObjectNameParser);
{$ENDIF}
    ClearConnectionOptions;
    Result := SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      fConnectionErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.disconnect', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.disconnect'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.getErrorMessage(Error: PChar): SQLResult;
begin
  if Error=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  StrCopy(Error, PChar(fConnectionErrorLines.Text));
  fConnectionErrorLines.Clear;
  Result := DBXpress.SQL_SUCCESS;
end;

procedure TSqlConnectionOdbc.CheckTransactionSupport;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  GetInfoSmallInt: SqlUSmallint;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.CheckTransactionSupport'); try try {$ENDIF _TRACE_CALLS_}
  {
   ODBC Transaction support info values...

   SQL_TC_NONE = Transactions not supported. (ODBC 1.0)

   SQL_TC_DML = Transactions can only contain Data Manipulation Language
   (DML) statements (SELECT, INSERT, UPDATE, DELETE).
   Data Definition Language (DDL) statements encountered in a transaction
   cause an error. (ODBC 1.0)

   SQL_TC_DDL_COMMIT = Transactions can only contain DML statements.
   DDL statements (CREATE TABLE, DROP INDEX, and so on) encountered in a transaction
   cause the transaction to be committed. (ODBC 2.0)

   SQL_TC_DDL_IGNORE = Transactions can only contain DML statements.
   DDL statements encountered in a transaction are ignored. (ODBC 2.0)

   SQL_TC_ALL = Transactions can contain DDL statements and DML statements in any order.
   (ODBC 1.0)

   Mapping to DbExpress transaction support is based on DML support (ie SELECT, INSERT etc)
  }
  OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_TXN_CAPABLE, GetInfoSmallInt,
    SizeOf(GetInfoSmallInt), nil);
  //if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
  //  OdbcCheck(OdbcRetcode, 'SQLGetInfo(fhCon, SQL_TXN_CAPABLE)');
  {+2.02}
  fSupportsTransaction := (OdbcRetcode = OdbcApi.SQL_SUCCESS) and (GetInfoSmallInt <> SQL_TC_NONE);
  // Edward> ???Ed>Vad> Vadim's code is more concise, but the point of
  // Edward> the original code is to be absolutely explicit on how
  // Edward> ODBC isolation levels map to dbExpress isolation level
  {
  case GetInfoSmallInt of
    SQL_TC_NONE        : fSupportsTransaction := False;
    SQL_TC_DML         : fSupportsTransaction := True;
    SQL_TC_DDL_COMMIT  : fSupportsTransaction := True;
    SQL_TC_DDL_IGNORE  : fSupportsTransaction := True;
    SQL_TC_ALL         : fSupportsTransaction := True;
    end;
   }
  {/+2.02}
  // Workaund MySql bug - MySql ODBC driver can INCORRECTLY report that it
  // supports transactions, so we test it to make sure..
  if fSupportsTransaction and
     (
//       fOdbcDriverType in  [eOdbcDriverTypeMySql, eOdbcDriverTypeMySql3]
       fDbmsType = eDbmsTypeMySql // ???: Need for MySQL 4 betta
     )
  then
  begin
    OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_ATTR_AUTOCOMMIT,
      Pointer(Smallint(SQL_AUTOCOMMIT_OFF)), 0);
    if OdbcRetcode = -1 then
      fSupportsTransaction := False;
    OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_ATTR_AUTOCOMMIT,
      Pointer(Smallint(SQL_AUTOCOMMIT_ON)), 0);
    if fSupportsTransaction and (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
      OdbcCheck(OdbcRetcode, 'SQLSetConnectAttr(fhCon, SQL_ATTR_AUTOCOMMIT)');
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.CheckTransactionSupport', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.CheckTransactionSupport'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.getErrorMessageLen(
  out ErrorLen: Smallint): SQLResult;
begin
  ErrorLen := Length(fConnectionErrorLines.Text);
  Result := DBXpress.SQL_SUCCESS;
end;

function TSQLConnectionOdbc.GetMetaDataOption(eDOption: TSQLMetaDataOption;
  PropValue: Pointer; MaxLength: Smallint;
  out Length: Smallint): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  GetInfoStringBuffer: array[0..1] of AnsiChar;
  GetInfoSmallInt: SqlUSmallint;
  ConnectAttrLength: SqlInteger;
  MaxIdentifierLen: SqlUSmallint;
  MaxColumnNameLen: SqlUSmallint;
  MaxTableNameLen: SqlUSmallint;
  MaxObjectNameLen: Integer;
  BatchSupport: SqlUInteger;
  xeDOption: TXSQLMetaDataOption absolute eDOption;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSQLConnectionOdbc.GetMetaDataOption', ['eDOption=', cSQLMetaDataOption[xeDOption]]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if PropValue=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  // Note on calls to SQLGetInfo -
  //
  // ODBC API specification states that where returned value is of type SQLUSMALLINT,
  // the driver ignores the length parameter (ie assumes length of 2)
  // However, Centura driver REQUIRES length parameter, even for SQLUSMALLINT value;
  // If omitted, Centura driver returns SQL_SUCCESS_WITH_INFO - Data Truncated,
  // and does not return the data.
  // So I have had to code the length parameter for all SQLGetInfo calls.
  // Never mind, compliant ODBC driver will just ignore the length parameter...

  try
    case xeDOption of
      xeMetaCatalogName: // Dbx Read/Write
        begin
          // Do not return cached catalog name, could be changed, eg. by Sql statement USE catalogname
          GetCurrentCatalog;
          if fCurrentCatalog = nil then
            Length := 0
          else
            Length := StrLen(fCurrentCatalog);
          if (Length = 0) then
            PChar(PropValue)[0] := #0
          else
          begin
            if (MaxLength >= Length) then
              Move(PChar(fCurrentCatalog)[0], PChar(PropValue)[0], Length)
            else
              raise EDbxInvalidCall.Create(
                'TSqlConnectionOdbc.GetMetaDataOption(..) MaxLength too small. ' +
                'MaxLength=' + IntToStr(MaxLength) +
                ', CurrentCatalog=' + fCurrentCatalog);
          end;
        end;
      xeMetaSchemaName: // Dbx Read/Write
        begin
          // There is no ODBC function to get this
          Length := System.Length(fCurrentSchema);
          if Length <= MaxLength then
            AnsiChar(PropValue^) := PChar(fCurrentSchema)^
          else
            raise EDbxInvalidCall.Create(
              'TSQLConnectionOdbc.GetMetaDataOption(eMetaSchemaName) MaxLength parameter is ' +
              'smaller than length of CurrentSchema');
        end;
      xeMetaDatabaseName: // Readonly
        begin
          OdbcRetcode := SQLGetConnectAttr(fhCon, SQL_DATABASE_NAME,
            PAnsiChar(PropValue), MaxLength, @ConnectAttrLength);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(fhCon, SQL_DATABASE_NAME)');
          Length := ConnectAttrLength;
        end;
      xeMetaDatabaseVersion: // Readonly
        begin
          OdbcRetcode := SQLGetConnectAttr(fhCon, SQL_DBMS_VER,
            PAnsiChar(PropValue), MaxLength, @ConnectAttrLength);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(fhCon, SQL_DBMS_VER)');
          Length := ConnectAttrLength;
        end;
      xeMetaTransactionIsoLevel: // Readonly
        begin
        end;
      xeMetaSupportsTransaction: // Readonly
        begin
          // Transaction support
          Boolean(PropValue^) := fSupportsTransaction;
        end;
      xeMetaMaxObjectNameLength: // Readonly
        begin
          OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_IDENTIFIER_LEN, MaxIdentifierLen,
            SizeOf(GetInfoSmallInt), nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_MAX_IDENTIFIER_LEN)');
          Integer(PropValue^) := GetInfoSmallInt;

          OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_COLUMN_NAME_LEN, MaxColumnNameLen,
            SizeOf(GetInfoSmallInt), nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_MAX_COLUMN_NAME_LEN)');

          OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_TABLE_NAME_LEN, MaxTableNameLen,
            SizeOf(GetInfoSmallInt), nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_MAX_TABLE_NAME_LEN)');

          MaxObjectNameLen := MaxIdentifierLen;
          if MaxColumnNameLen < MaxObjectNameLen then
            MaxObjectNameLen := MaxColumnNameLen;
          if MaxTableNameLen < MaxObjectNameLen then
            MaxTableNameLen := MaxColumnNameLen;
          Integer(PropValue^) := MaxColumnNameLen;

        end;
      xeMetaMaxColumnsInTable: // Readonly
        begin
          OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_COLUMNS_IN_TABLE, GetInfoSmallInt,
            SizeOf(GetInfoSmallInt), nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_MAX_COLUMNS_IN_TABLE)');
          Integer(PropValue^) := GetInfoSmallInt;
        end;
      xeMetaMaxColumnsInSelect: // Readonly
        begin
          OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_COLUMNS_IN_SELECT, GetInfoSmallInt,
            SizeOf(GetInfoSmallInt), nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_MAX_COLUMNS_IN_SELECT)');
          Integer(PropValue^) := GetInfoSmallInt;
        end;
      xeMetaMaxRowSize: // Readonly
        begin
          OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_ROW_SIZE, GetInfoSmallInt,
            SizeOf(GetInfoSmallInt), nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_MAX_ROW_SIZE)');
          Integer(PropValue^) := GetInfoSmallInt;
        end;
      xeMetaMaxSQLLength: // Readonly
        begin
          OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_STATEMENT_LEN, GetInfoSmallInt,
            SizeOf(GetInfoSmallInt), nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_MAX_STATEMENT_LEN)');
          Integer(PropValue^) := GetInfoSmallInt;
        end;
      xeMetaObjectQuoteChar: // Readonly
        begin
          if fWantQuotedTableName then
          begin
            if (MaxLength = 1) then
            begin
              OdbcRetcode := SQLGetInfoString(fhCon, SQL_IDENTIFIER_QUOTE_CHAR,
                @GetInfoStringBuffer, SizeOf(GetInfoStringBuffer), Length);
              if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
                OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_IDENTIFIER_QUOTE_CHAR)');
              if GetInfoStringBuffer[0] = ' ' then
              begin
                PAnsiChar(PropValue)^ := #0;
                fWantQuotedTableName := False;
                Length := 0;
              end
              else
              begin
                AnsiChar(PropValue^) := GetInfoStringBuffer[0];
                Length := 1;
              end
            end
            else
            begin
              OdbcRetcode := SQLGetInfoString(fhCon, SQL_IDENTIFIER_QUOTE_CHAR,
                PropValue, MaxLength, Length);
              if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
                OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_IDENTIFIER_QUOTE_CHAR)');
            end;
          end
          else
          begin
            PAnsiChar(PropValue)^ := #0;
            Length := 0;
          end;
        end;
      xeMetaSQLEscapeChar: // Readonly
        begin
          if (MaxLength = 1) then
          begin
            OdbcRetcode := SQLGetInfoString(fhCon, SQL_SEARCH_PATTERN_ESCAPE,
              @GetInfoStringBuffer, SizeOf(GetInfoStringBuffer), Length);
            if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
              OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_SEARCH_PATTERN_ESCAPE)');
            AnsiChar(PropValue^) := GetInfoStringBuffer[0];
            Length := 1;
          end
          else
          begin
            OdbcRetcode := SQLGetInfoString(fhCon, SQL_SEARCH_PATTERN_ESCAPE,
              PropValue, MaxLength, Length);
            if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
              OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_SEARCH_PATTERN_ESCAPE)');
          end;
        end;
      xeMetaProcSupportsCursor: // Readonly
        // whether stored procedures can return a cursor
        // If ODBC driver indicates support for Stored Procedures,
        // it is assumed that they may return result sets (ie Cursors)
        begin
          OdbcRetcode := SQLGetInfoString(fhCon, SQL_PROCEDURES,
            @GetInfoStringBuffer, SizeOf(GetInfoStringBuffer), Length);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_PROCEDURES)');
          if GetInfoStringBuffer[0] = 'Y' then
            Boolean(PropValue^) := True
          else
            Boolean(PropValue^) := False;
        end;
      xeMetaProcSupportsCursors: // Readonly
        // whether stored procedures can return multiple cursors
        begin
          OdbcRetcode := SQLGetInfoInt(fhCon, SQL_BATCH_SUPPORT, BatchSupport,
            SizeOf(GetInfoSmallInt), nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetInfo(SQL_BATCH_SUPPORT)');

          if ((BatchSupport and SQL_BS_SELECT_PROC) <> 0) then
            // This indicates that the driver supports batches of procedures
            // that can have result-set generating statements
            Boolean(PropValue^) := True
          else
            Boolean(PropValue^) := False;
        end;
      xeMetaSupportsTransactions: // Readonly
        begin
          // Nested transactions - Not supported by ODBC
          // (N.B. Non-nested transaction support is eMetaSupportsTransaction)
          Boolean(PropValue^) := False;
        end;
{.$IFDEF _D7UP_}
      xeMetaPackageName:
        begin
          Char(PropValue^) := #0;
          Length := 0;
        end;
{.$ENDIF}
    end; //of: case
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: EDbxNotSupported do
      Result := DBXERR_NOTSUPPORTED;
    on E: EDbxError do
    begin
      fConnectionErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSQLConnectionOdbc.GetMetaDataOption', e);  raise; end; end;
    finally LogExitProc('TSQLConnectionOdbc.GetMetaDataOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.GetOption(
  eDOption: TSQLConnectionOption;
  PropValue: Pointer;
  MaxLength: Smallint;
  out Length: Smallint
  ): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  AttrVal: SqlUInteger;
  ConnectAttrLength: SqlUInteger;
{.$IFDEF _K3UP_}
  SmallintAttrVal: SqlUSmallint;
{$IFDEF _RegExprParser_}
  procedure GetQuotedQualifiedName;
  var
    sQuotedObjectName: string;
  begin
    sQuotedObjectName :=
      fObjectNameParser.GetQuotedObjectName(fQualifiedName); // This for multi-part names
    Length := System.Length(sQuotedObjectName);
    if (Length > 0) then
    begin
      if (MaxLength >= Length) then
        Move(PChar(sQuotedObjectName)[0], PChar(PropValue)[0], Length)
      else
        raise EDbxInvalidCall.Create(
          'TSqlConnectionOdbc.GetOption(eConnQualifiedName). ' +
          'Supplied MaxLength too small for value. ' +
          'MaxLength=' + IntToStr(MaxLength) +
          ', QualifiedName=' + sQuotedObjectName);
    end;
  end;
{$ELSE}
var
  aQuotedQualifiedName: string;
{$ENDIF} // of: $IFDEF _RegExprParser_}
{.$ELSE}
{.$IFNDEF _InternalCloneConnection_}
//  SmallintAttrVal: SqlUSmallint;
{.$ENDIF}
{.$ENDIF} // of: $IFDEF _K3UP_}
var
  xeDOption: TXSQLConnectionOption absolute eDOption;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.GetOption','eDOption='+cSQLConnectionOption[xeDOption]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if (PropValue=nil) then
  begin
    {
      Get Buffer Size Length.
    }
    Result := SQL_SUCCESS;
    case xeDOption of
      xeConnConnectionName:
       Length := System.Length(fOdbcConnectString)+1;
      xeConnCatalogName:
        // Do not cache catalog name, could be changed, eg. by Sql statement USE catalogname
        begin
          GetCurrentCatalog;
          if fCurrentCatalog = nil then
            Length := 1
          else
            Length := StrLen(fCurrentCatalog)+1;
        end;
      xeConnSchemaName:
        begin
          if (fConnectionOptions[coSupportsSchemaFilter] = osOn) then
            Length := System.Length(fCurrentSchema)+1
          else
            Length := 1;
        end;
      {// todo:
      xeConnCustomInfo:
        begin

        end;{}
      xeConnConnectionString:
        begin
          Length := System.Length(fConnConnectionString)+1;
          if Length=1 then
            Length := System.Length(fOdbcConnectString)+1;
        end
      else
       Result := DBXERR_INVALIDPARAM;
    end
  end
  else
  try
    case xeDOption of
      xeConnAutoCommit:
        begin
          OdbcRetcode := SQLGetConnectAttr(fhCon, SQL_ATTR_AUTOCOMMIT, @AttrVal, 0, nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(SQL_ATTR_AUTOCOMMIT)');
          Boolean(PropValue^) := (AttrVal = SQL_AUTOCOMMIT_OFF);
        end;
      xeConnBlockingMode:
        // We do not support Asynchronous statement execution
        // From ODBC API:
        // "On multithread operating systems, applications should execute functions on
        // separate threads, rather than executing them asynchronously on the same thread.
        // Drivers that operate only on multithread operating systems
        // do not need to support asynchronous execution."
        Boolean(PropValue^) := False;
      xeConnBlobSize:
        // "For drivers that donít provide the available blob size before fetching, this
        // specifies the number of kilobytes of BLOB data that is fetched for BLOB fields.
        // This overrides any value specified at the driver level using eDrvBlobSize."
        Integer(PropValue^) := fConnBlobSizeLimitK;
      xeConnRoleName:
        // String that specifies the role to use when establishing a connection. (Interbase only)
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.GetOption(eConnRoleName) not ' +
          'supported - Applies to Interbase only');
      xeConnWaitOnLocks:
        // Boolean that indicates whether application should wait until a locked
        // resource is free rather than raise an exception. (Interbase only)
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.GetOption(eConnWaitOnLocks) not ' +
          'supported - Applies to Interbase only');
      xeConnCommitRetain:
        // Cursors dropped after commit
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.GetOption(eConnCommitRetain) not ' +
          'supported - Applies to Interbase only');
      xeConnTxnIsoLevel:
        begin
          OdbcRetcode := SQLGetConnectAttr(fhCon, SQL_ATTR_TXN_ISOLATION, @AttrVal, 0, nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(SQL_ATTR_TXN_ISOLATION)');
          if (AttrVal and SQL_TXN_SERIALIZABLE) <> 0 then
            // Transactions are serializable.
            // Serializable transactions do not allow dirty reads, nonrepeatable reads, or phantoms.
            TTransIsolationLevel(PropValue^) := xilREPEATABLEREAD
          else if (AttrVal and SQL_TXN_REPEATABLE_READ) <> 0 then
            // Dirty reads and nonrepeatable reads are not possible. Phantoms are possible
            TTransIsolationLevel(PropValue^) := xilREPEATABLEREAD
          else if (AttrVal and SQL_TXN_READ_COMMITTED) <> 0 then
            // Dirty reads are not possible. Nonrepeatable reads and phantoms are possible
            TTransIsolationLevel(PropValue^) := xilREADCOMMITTED
          else if (AttrVal and SQL_TXN_READ_UNCOMMITTED) <> 0 then
            // Dirty reads, nonrepeatable reads, and phantoms are possible.
            TTransIsolationLevel(PropValue^) := xilDIRTYREAD
        end;
      xeConnNativeHandle:
        // The native SQL connection handle (Read-only)
        SqlHDbc(PropValue^) := fhCon;
      xeConnServerVersion:
        begin
          OdbcRetcode := SQLGetConnectAttr(fhCon, SQL_DBMS_VER, PropValue,
            MaxLength, @ConnectAttrLength);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(fhCon, SQL_DBMS_VER)');
          Length := ConnectAttrLength;
        end;
      xeConnCallBack:
        TSQLCallBackEvent(PropValue^) := fDbxCallBack;
      xeConnCallBackInfo:
        Integer(PropValue^) := fDbxCallBackInfo;
      xeConnHostName:
        raise EDbxNotSupported.Create(
          'TSqlConnectionOdbc.GetOption(eConnHostName) not supported - applies to MySql only');
      xeConnDatabaseName: // Readonly
        begin
          OdbcRetcode := SQLGetConnectAttr(fhCon, SQL_DATABASE_NAME, PropValue,
            MaxLength, @ConnectAttrLength);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(fhCon, SQL_DATABASE_NAME)');
          Length := ConnectAttrLength;
        end;
      xeConnObjectMode:
        // Boolean value to enable or disable object fields in Oracle8 tables
        raise EDbxNotSupported.Create(
          'TSqlConnectionOdbc.GetOption(eConnObjectMode) not supported - applies to Oracle only');
{.$IFDEF _K3UP_}
      xeConnMaxActiveComm:
{.$ELSE}
//      eConnMaxActiveConnection:
{.$ENDIF}
        begin
          // The maximum number of active commands that can be executed by a single connection.
          // Read-only.
          // If database does not support multiple statements, we internally clone
          // connection, so return 0 to DbExpress (unlimited statements per connection)
{$IFDEF _InternalCloneConnection_}
          Smallint(PropValue^) := 0;
{$ELSE}
          // Old code below commented out, v1.04:
          // Back in again v2.04, _InternalCloneConnection_ can now be turned off
          if not fConnected then
          begin
            try
              // We cannot determine this setting until after we have connected
              // Normally we should raise an exception and return error code,
              // but unfortunately SqlExpress calls this option BEFORE connecting
              // so we'll just raise a WARNING, set return value of 1
              // (ie assume only 1 concurrent connection), and Success code
              Smallint(PropValue^) := 1;
              raise EDbxOdbcWarning.Create(
                'TSqlConnectionOdbc.GetOption(eConnMaxActiveConnection) called, but not connected');
            except
              on EDbxOdbcWarning do
                ;
            end;
          end
          else
          begin
            // The maximum number of active commands that can be executed by a single connection.
            // Read-only.
            OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_MAX_CONCURRENT_ACTIVITIES,
              SmallintAttrVal, 2, nil);
            if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
              OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(SQL_MAX_CONCURRENT_ACTIVITIES)');
            Smallint(PropValue^) := SmallintAttrVal;
          end;
{$ENDIF} //of: $IFDEF _InternalCloneConnection_ $ELSE
          {$IFDEF _TRACE_CALLS_}
          LogInfoProc(['eConnMaxActiveConnection=', Smallint(PropValue^)]);
          {$ENDIF}
        end;
      xeConnServerCharSet:
        begin
          OdbcRetcode := SQLGetInfoString(fhCon, SQL_COLLATION_SEQ, PropValue,
            MaxLength, Length);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetConnectAttr(SQL_COLLATION_SEQ)');
        end;
      xeConnSqlDialect:
        // Interbase only
        raise EDbxNotSupported.Create(
          'TSqlConnectionOdbc.GetOption(eConnSqlDialect) not supported - applies to Interbase only');
{.$IFDEF _K3UP_}
      xeConnRollbackRetain:
        Pointer(PropValue^) := nil;
      xeConnObjectQuoteChar:
        PAnsiChar(PropValue)^ := fQuoteChar;
      xeConnConnectionName:
        begin
          if (MaxLength > 0) then
            PChar(PropValue)^:=#0;
          Length := System.Length(fOdbcConnectString);
          if (Length > 0) then
          begin
            if (MaxLength >= Length) then
              Move(PChar(fOdbcConnectString)[0], PChar(PropValue)[0], Length)
            else
              raise EDbxInvalidCall.Create(
                'TSqlConnectionOdbc.GetOption(eConnConnectionName) ' +
                'Supplied MaxLength too small for value. ' +
                'MaxLength=' + IntToStr(MaxLength) +
                ', ConnectString=' + fOdbcConnectString);
          end;
        end;
      xeConnOSAuthentication:
        raise EDbxNotSupported.Create(
          'TSqlConnectionOdbc.GetOption(eConnOSAuthentication) not supported');
      xeConnSupportsTransaction:
        begin
          OdbcRetcode := SQLGetInfoSmallint(fhCon, SQL_TXN_CAPABLE, SmallintAttrVal,
            SizeOf(SmallintAttrVal), nil);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetInfo(fhCon, SQL_TXN_CAPABLE)');
          Boolean(PropValue^) := SmallintAttrVal <> SQL_TC_NONE;
        end;
      xeConnMultipleTransaction:
        raise EDbxNotSupported.Create(
          'TSqlConnectionOdbc.GetOption(eConnMultipleTransaction) not supported');
      xeConnServerPort:
        raise EDbxNotSupported.Create(
          'TSqlConnectionOdbc.GetOption(eConnServerPort) not supported');
      xeConnOnLine:
        raise EDbxNotSupported.Create(
          'TSqlConnectionOdbc.GetOption(eConnOnLine) not supported');
      xeConnTrimChar:
        Boolean(PropValue^) := fConnectionOptions[coTrimChar] = osOn;
{.$ENDIF} //of: IFDEF _K3UP_
{.$IFDEF _D7UP_}
      xeConnQualifiedName:
        begin
          if (MaxLength > 0) then
            PChar(PropValue)^:=#0;
          Length := System.Length(fQualifiedName);
          if (Length > 0) then
          begin
            if (MaxLength >= Length) then
              Move(PChar(fQualifiedName)[0], PChar(PropValue)[0], Length)
            else
              raise EDbxInvalidCall.Create(
                'TSqlConnectionOdbc.GetOption(eConnQualifiedName). ' +
                'Supplied MaxLength too small for value. ' +
                'MaxLength=' + IntToStr(MaxLength) +
                ', QualifiedName=' + fQualifiedName);
          end;
        end;
      xeConnCatalogName:
        // Do not cache catalog name, could be changed, eg. by Sql statement USE catalogname
        begin
          if (MaxLength > 0) then
            PChar(PropValue)^:=#0;
          GetCurrentCatalog;
          if fCurrentCatalog = nil then
            Length := 0
          else
            Length := StrLen(fCurrentCatalog);
          if (Length > 0) then
          begin
            if (MaxLength >= Length) then
              Move(PChar(fCurrentCatalog)[0], PChar(PropValue)[0], Length)
            else
              raise EDbxInvalidCall.Create(
                'TSqlConnectionOdbc.GetOption(eConnCatalogName). ' +
                'Supplied MaxLength too small for value. ' +
                'MaxLength=' + IntToStr(MaxLength) +
                ', CurrentCatalog=' + fCurrentCatalog);
          end;
        end;
      xeConnSchemaName:
        begin
          if (MaxLength > 0) then
            PChar(PropValue)^:=#0;
          if (fConnectionOptions[coSupportsSchemaFilter] = osOn) then
            Length := System.Length(fCurrentSchema)
          else
            Length := 0;
          if (Length > 0) then
          begin
            if (MaxLength >= Length) then
              Move(PChar(fCurrentSchema)[0], PChar(PropValue)[0], Length)
            else
              raise EDbxInvalidCall.Create(
                'TSqlConnectionOdbc.GetOption(eConnSchemaName). ' +
                'Supplied MaxLength too small for value. ' +
                'MaxLength=' + IntToStr(MaxLength) +
                ', CurrentSchema=' + fCurrentSchema);
          end;
        end;
      xeConnObjectName:
        begin
          if (MaxLength > 0) then
            PChar(PropValue)^:=#0;
          Length := System.Length(fQualifiedName);
          if (Length > 0) then
          begin
            if (MaxLength >= System.Length(fQualifiedName)) then
              Move(PChar(fQualifiedName)[0], PChar(PropValue)[0], Length)
            else
              raise EDbxInvalidCall.Create(
                'TSqlConnectionOdbc.GetOption(eConnObjectName). ' +
                'Supplied MaxLength too small for value. ' +
                'MaxLength=' + IntToStr(MaxLength) +
                ', QualifiedName=' + fQualifiedName);
          end;
        end;
      xeConnQuotedObjectName:
        begin
          if (MaxLength > 0) then
            PChar(PropValue)^:=#0;
{$IFDEF _RegExprParser_}
          // This is right for multi-part names
          GetQuotedQualifiedName;
{$ELSE}
          Length := System.Length(fQualifiedName);
          if (Length > 0) then
          begin
            // doublequote chars: ObjectName = "schema"."table" (SQL Server)
            if fWantQuotedTableName and (fQualifiedName[1] <> fQuoteChar) then
              aQuotedQualifiedName := fQuoteChar + fQualifiedName + fQuoteChar
            else
              aQuotedQualifiedName := fQualifiedName;
            Length := System.Length(aQuotedQualifiedName);
            if (MaxLength >= Length) then
              Move(PChar(aQuotedQualifiedName)[0], PChar(PropValue)[0], Length)
            else
              raise EDbxInvalidCall.Create(
                'TSqlConnectionOdbc.GetOption(eConnQuotedObjectName). ' +
                'Supplied MaxLength too small for value. ' +
                'MaxLength=' + IntToStr(MaxLength) +
                ', QuotedQualifiedName=' + aQuotedQualifiedName);
          end
{$ENDIF} //of: $IFDEF _RegExprParser_ $ELSE
        end;
      xeConnCustomInfo:
        begin
          // TODO:
          raise EDbxNotSupported.Create(
            'TSqlConnectionOdbc.GetOption(eConnCustomInfo) not supported');
        end;
      xeConnTimeOut:
        raise
          EDbxNotSupported.Create('TSqlConnectionOdbc.GetOption(eConnTimeOut) not supported');
{.$ENDIF} //of: $IFDEF _D7UP_
      xeConnConnectionString:
        begin
          if (MaxLength > 0) then
            PChar(PropValue)^:=#0;

          Length := System.Length(fConnConnectionString);
          if (Length > 0) then
          begin
            if (MaxLength >= Length) then
              Move(PChar(fConnConnectionString)[0], PChar(PropValue)[0], Length)
            else
              raise EDbxInvalidCall.Create(
                'TSqlConnectionOdbc.GetOption(eConnConnectionString) ' +
                'Supplied MaxLength too small for value. ' +
                'MaxLength=' + IntToStr(MaxLength) +
                ', ConnectString=' + fConnConnectionString);
          end
          else
          begin
            Length := System.Length(fOdbcConnectString);
            if (Length > 0) then
            begin
              if (MaxLength >= Length) then
                Move(PChar(fOdbcConnectString)[0], PChar(PropValue)[0], Length)
              else
                raise EDbxInvalidCall.Create(
                  'TSqlConnectionOdbc.GetOption(eConnConnectionString) ' +
                  'Supplied MaxLength too small for value. ' +
                  'MaxLength=' + IntToStr(MaxLength) +
                  ', ConnectString=' + fOdbcConnectString);
            end;
          end;
        end;
    else
      raise EDbxInvalidCall.Create('Invalid option passed to TSqlConnectionOdbc.GetOption: ' +
        IntToStr(Ord(eDOption)));
    end; //of: case
    Result := SQL_SUCCESS;
  except
    on E: EDbxNotSupported do
      Result := DBXERR_NOTSUPPORTED;
    on E: Exception{EDbxError} do
    begin
      fConnectionErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.GetOption', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.GetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.RetrieveDriverName: SQLResult;

var
  OdbcRetcode: OdbcApi.SqlReturn;
  Buffer: array[0..100] of AnsiChar;
  uDbmsName: string;
  BufLen: SqlSmallint;

  procedure VersionStringToNumeric(const VersionString: string;
    var VersionMajor, VersionMinor, VersionRelease, VersionBuild: Integer);
  const
    cDigits = ['0'..'9'];
  var
    c: Char;
    NextNumberFound: Boolean;
    sVer: array[1..4] of string;
    VerIndex: Integer;
    i: Integer;
  begin
    VerIndex := 0;
    NextNumberFound := False;

    for i := 1 to Length(VersionString) do
    begin
      c := VersionString[i];
      if c in cDigits then
      begin
        if not NextNumberFound then
        begin
          NextNumberFound := True;
          Inc(VerIndex);
          if VerIndex > High(sVer) then
            break;
        end;
        sVer[VerIndex] := sVer[VerIndex] + c;
      end
      else
        NextNumberFound := False;
    end;
    if sVer[1] <> '' then
      VersionMajor := StrToIntDef(sVer[1], -1);
    if sVer[2] <> '' then
      VersionMinor := StrToIntDef(sVer[2], -1);
    if sVer[3] <> '' then
      VersionRelease := StrToIntDef(sVer[3], -1);
    if sVer[4] <> '' then
      VersionBuild := StrToIntDef(sVer[4], -1);
  end;

begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.RetrieveDriverName'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}

  {Get DBMS info:}

  FillChar(Buffer[0], SizeOf(Buffer), #0);
  OdbcRetcode := SQLGetInfoString(fhCon, SQL_DBMS_NAME, Buffer, SizeOf(Buffer), BufLen);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLGetInfo(fhCon, SQL_DBMS_NAME)');
  fDbmsName := Buffer;
  uDbmsName := UpperCase(fDbmsName);
  // RDBMS NAME
  if uDbmsName = 'SQLBASE' then
    fDbmsType := eDbmsTypeGupta
  else if uDbmsName = 'MICROSOFT SQL SERVER' then
    fDbmsType := eDbmsTypeMsSqlServer
  else if uDbmsName = 'IBMDB2' then
    fDbmsType := eDbmsTypeIbmDb2
  else if (StrLComp(PAnsiChar(uDbmsName), 'MYSQL', 5)=0) then
    fDbmsType := eDbmsTypeMySql
      // JET databases
  else if uDbmsName = 'ACCESS' then
    fDbmsType := eDbmsTypeMsAccess
  else if uDbmsName = 'EXCEL' then
    fDbmsType := eDbmsTypeExcel
  else if uDbmsName = 'TEXT' then
    fDbmsType := eDbmsTypeText
  else if (StrLComp(PAnsiChar(uDbmsName), 'DBASE', 5)=0) then // DBASE II, IV, V
    fDbmsType := eDbmsTypeDBase
  else if uDbmsName = 'PARADOX' then
    fDbmsType := eDbmsTypeParadox
      // Ohter databases, not fully tested
  else if uDbmsName = 'ORACLE' then
    fDbmsType := eDbmsTypeOracle
  else if uDbmsName = 'INFORMIX' then
    fDbmsType := eDbmsTypeInformix
  else if uDbmsName = 'INTERBASE' then
    fDbmsType := eDbmsTypeInterbase
  else if (StrLComp(PAnsiChar(uDbmsName), 'FIREBIRD', 8)=0) then // 'FIREBIRD / INTERBASE(R)'
    fDbmsType := eDbmsTypeInterbase
      // Ohter databases, not tested at all
  else if uDbmsName = 'SYBASE' then
    fDbmsType := eDbmsTypeSybase
  else if uDbmsName = 'SQLITE' then
    fDbmsType := eDbmsTypeSQLLite
  else if (StrLComp(PAnsiChar(uDbmsName), 'THINKSQL', 8)=0) then // 'THINKSQL RELATIONAL DATABASE MANAGEMENT SYSTEM'
    fDbmsType := eDbmsTypeThinkSQL
  else if uDbmsName = 'SAP DB' then
    fDbmsType := eDbmsTypeSAPDB
  else if uDbmsName = 'PERVASIVE.SQL' then
    fDbmsType := eDbmsTypePervasiveSQL
  else if uDbmsName = 'TURBOPOWER FLASHFILER 2' then
    fDbmsType := eDbmsTypeFlashFiler
  else if (StrLComp(PAnsiChar(uDbmsName), 'POSTGRESQL', 10)=0) then
    fDbmsType := eDbmsTypePostgreSQL
  else if uDbmsName = 'INTERSYSTEMS CACHE' then
    fDbmsType := eDbmsTypeInterSystemCache
  else
    fDbmsType := eDbmsTypeUnspecified;

  // RDBMS VERSION
  FillChar(Buffer[0], SizeOf(Buffer), #0);
  OdbcRetcode := SQLGetInfoString(fhCon, SQL_DBMS_VER, Buffer, SizeOf(Buffer), BufLen);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLGetInfo(fhCon, SQL_DBMS_VER)');
  fDbmsVersionString := Buffer;

  VersionStringToNumeric(fDbmsVersionString, fDbmsVersionMajor, fDbmsVersionMinor,
    fDbmsVersionRelease, fDbmsVersionBuild);

  // ODBC DRIVER VERSION
  FillChar(Buffer[0], SizeOf(Buffer), #0);
  OdbcRetcode := SQLGetInfoString(fhCon, SQL_DRIVER_VER, Buffer, SizeOf(Buffer), BufLen);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLGetInfo(fhCon, SQL_DRIVER_VER)');
  fOdbcDriverVersionString := Buffer;

  VersionStringToNumeric(fOdbcDriverVersionString, fOdbcDriverVersionMajor, fOdbcDriverVersionMinor,
    fOdbcDriverVersionRelease, fOdbcDriverVersionBuild);

  // ODBC DRIVER NAME:
  FillChar(Buffer[0], SizeOf(Buffer), #0);
  OdbcRetcode := SQLGetInfoString(fhCon, SQL_DRIVER_NAME, Buffer, SizeOf(Buffer), BufLen);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLGetInfo(fhCon, SQL_DRIVER_NAME)');
  fOdbcDriverName := Buffer;

  {Get DRIVER info:}

  StrUpper(Buffer);

    // SQL Base:
  if (StrLComp(Buffer, 'C2GUP', 5) = 0) or
    (StrLComp(Buffer, 'IVGUP', 5) = 0) {// DataDirect SQLBase ODBC Driver} then
    fOdbcDriverType := eOdbcDriverTypeGupta

    // SQL Server:
  else if (StrLComp(Buffer, 'SQLSRV', 6) = 0) // SQL Server Microsoft Corporation ODBC Driver
  or (StrLComp(Buffer, 'IVSS', 4) = 0) // DataDirect SQL Server ODBC Driver
  or (StrLComp(Buffer, 'IVMSSS', 6) = 0) // DataDirect SQL Server Wire Protocol ODBC Driver
  or // extended comparing
  ((StrLComp(Buffer, 'NTL', 3) = 0) and (Buffer[5] = 'M'))
    {// OpenLink Lite for MS-SQL Server (32 Bit) ODBC Driver}then
    fOdbcDriverType := eOdbcDriverTypeMsSqlServer

    // IBM DB2:
  else if (StrLComp(Buffer, 'DB2CLI', 6) = 0) // IBM DB2 ODBC DRIVER
  or (StrLComp(Buffer, 'LIBDB2', 6) = 0) // IBM
  or (StrLComp(Buffer, 'IVDB2', 5) = 0) {// DataDirect DB2 Wire Protocol ODBC Driver} then
    fOdbcDriverType := eOdbcDriverTypeIbmDb2

    // Microsoft desktop databases:
  else if StrLComp(Buffer, 'ODBCJT', 6) = 0
    {//(Microsoft Paradox Driver, Microsoft dBASE Driver, ...).}then
    fOdbcDriverType := eOdbcDriverTypeMsJet
      // This driver does not allow SQL_DECIMAL.
// It driverType usagheb for detecting this situation.

// My SQL ODBC Version 3 Driver:
  else if StrLComp(Buffer, 'MYODBC3', 7) = 0 then
    fOdbcDriverType := eOdbcDriverTypeMySql3

    // My SQL:
  else if StrLComp(Buffer, 'MYODBC', 6) = 0 then
    fOdbcDriverType := eOdbcDriverTypeMySql

    // INFORMIX:
  else if (StrLComp(Buffer, 'ICLI', 4) = 0) // "INFORMIX 3.32 32 BIT" ODBC Driver
  or (StrLComp(Buffer, 'IVINF', 5) = 0) // DataDirect Informix ODBC Driver
  or (StrLComp(Buffer, 'IVIFCL', 6) = 0) // DataDirect Informix Wire Protocol ODBC Driver
  or (StrLComp(Buffer, 'PDINF', 5) = 0) // INTERSOLV Inc ODBC Driver (1997. Now is DataDirect)
  or // extended comparing
  ((StrLComp(Buffer, 'NTL', 3) = 0) and (Buffer[5] = 'I'))
    {// OpenLink Lite for Informix 7 (32 Bit) ODBC Driver}then
    fOdbcDriverType := eOdbcDriverTypeInformix

    // SYBASE
  else if (StrLComp(Buffer, 'SYODASE', 7) = 0) then // SYBASE ACE ODBC Driver
    fOdbcDriverType := eOdbcDriverTypeSybase

    // SQL Lite:
  else if StrLComp(Buffer, 'SQLITEODBC', 10) = 0 then
    fOdbcDriverType := eOdbcDriverTypeSQLLite

    // INTERBASE:
  else if StrLComp(Buffer, 'IB6ODBC', 7) = 0 {// Easysoft ODBC Driver} then
  begin
    fOdbcDriverType := eOdbcDriverTypeInterbase;
    fOdbcDriverLevel := 2
  end
  else if StrLComp(Buffer, 'ODBCJDBC', 8) = 0 then {// IBPhoenix ODBC Driver: http://www.ibphoenix.com/}
  begin
    fOdbcDriverType := eOdbcDriverTypeInterbase;
    fSupportsBlockRead := False; // Driver fetched only one record for "array fetch".
    fConnectionOptionsDrv[coMixedFetch] := osOff; // driver unsupported STATIC cursor

  end
  else if StrLComp(Buffer, 'IB6XTG', 6) = 0 then
  begin  {// Open Firebird, Interbase6 ODBC Driver: http://www.xtgsystems.com/ }
    fOdbcDriverType := eOdbcDriverTypeInterbase;
    // bug in bcd: returned uncorrected BCD column info (SQLDescribeCol)
    // fConnectionOptionsDrv[coMaxBCD] := osOn; // - added handles in BindResultSet
  end

    // Think SQL:
  else if StrLComp(Buffer, 'THINKSQL', 8) = 0 {// ThinkSQL ODBC Driver} then
    fOdbcDriverType := eOdbcDriverTypeThinkSQL

    // ORACLE:
  else if (StrLComp(Buffer, 'SQORA', 5) = 0) // Oracle ODBC Driver
  or (StrLComp(Buffer, 'MSORCL', 6) = 0) // Microsoft ODBC for Oracle
  or (StrLComp(Buffer, 'IVOR', 4) = 0) // DataDirect Oracle ODBC Driver
  or (StrLComp(Buffer, 'IVORA', 5) = 0) {// DataDirect Oracle Wire Protocol ODBC Driver} then
    fOdbcDriverType := eOdbcDriverTypeOracle

  else if (StrLComp(Buffer, 'INOLE', 5) = 0) {// MERANT ODBC-OLE DB Adapter Driver} then
    fOdbcDriverType := eOdbcDriverTypeMerantOle

    // SYBASE:
    {
       ( StrLComp(buffer, 'IVASE', 5) = 0 )  // DataDirect SybaseWire Protocol ODBC Driver
    }
    // BTRIEVE:
    {
    ( StrLComp(buffer, 'IVBTR', 5) = 0 )  // DataDirect Btrieve (*.dta) ODBC Driver
    }
    // PROGRESS:
    {
    ( StrLComp(buffer, 'IVPRO', 5) = 0 )  // DataDirect Progress ODBC Driver
    }
    // OTHER:
    {
    Microsoft Visual FoxPro Driver (*.dbf)    'VFPODBC'
    DataDirect dBASE File (*.dbf)             'IVDBF'
    DataDirect FoxPro 3.0 database (*.dbc)    'IVDBF'
    DataDirect Excel Workbook (*.xls)         'IVXLWB'
    DataDirect Paradox File (*.db)            'IVDP'
    DataDirect Text File (*.*)                'IVTXT'
    DatDirect XML                             'IVXML'
    SQLLite                                   'SQLITEODBC'
    ThinkSQL                                  'THINKSQL'
    }

    // Pervasive.SQL
  else if (StrLComp(Buffer, 'W3ODBCCI', 8) = 0) {// Pervasive.SQL ODBC Driver Client Interface } then
    fOdbcDriverType := eOdbcDriverTypePervasive
  else if (StrLComp(Buffer, 'W3ODBCEI', 8) = 0) {// Pervasive.SQL ODBC Driver Engine Interface } then
    fOdbcDriverType := eOdbcDriverTypePervasive

    // FlasfFiller
  else if (StrLComp(Buffer, 'NXODBCDRIVER', 12) = 0) {// NexusDb FlashFiler Driver } then
    fOdbcDriverType := eOdbcDriverTypeNexusDbFlashFiler

    // PostgreSQL
  else if (StrLComp(Buffer, 'PSQLODBC', 8) = 0) then
    fOdbcDriverType := eOdbcDriverTypePostgreSQL

    // Cache
  else if (StrLComp(Buffer, 'CACHEODBC', 9) = 0)  then
    fOdbcDriverType := eOdbcDriverTypeInterSystemCache

    // Merant Clipper, DBASE, FoxPro
  else if (StrLComp(Buffer, 'IVDBF', 5) = 0)  then {MERANT DBASE ODBC DRIVER}
  begin
    fOdbcDriverType := eOdbcDriverTypeMerantDBASE; // Clipper, DBASE, FoxPro
    //fSupportsBlockRead := False; // not supported SQL_CURSOR_STATIC (it is autodetected)
  end

    // 'SAP DB' ODBC Driver by SAP AG
  else if (fDbmsType = eDbmsTypeSAPDB) and
    (StrLComp(Buffer, 'SQLOD', 5) = 0)  then {'SAP DB' ODBC Driver by SAP AG}
  begin
    fOdbcDriverType := eOdbcDriverTypeSAPDB;
    fOdbcDriverLevel := 2;
    fSupportsBlockRead := False; // Driver fetched only one record for "array fetch".
    //fConnectionOptionsDrv[coMixedFetch] := osOff;
  end

  else
    fOdbcDriverType := eOdbcDriverTypeUnspecified;

  {Initialize Server specific parameters:}

  case fDbmsType of
    eDbmsTypeText:
      begin
        // Table name is equal FileName with extension.
        // It do not allow correctly parsing table name in Provider when TableName contained '.' (Look in 'Provider.pas' procedure GetQuotedTableName).
        fWantQuotedTableName := False;
        fConnectionOptionsDrv[coSupportsCatalog] := osOff;
        // 'Microsoft Text Driver (*.txt, *.csv)', ver: '4.00.6019.00' do not allow update or delete data by this ISAM driver (Allows only an insert but only if the name of a column is simple).
      end;
  end;

  case fOdbcDriverType of
    eOdbcDriverTypeMsSqlServer:
      begin
        // DataDirect SQL Server ODBC Driver (Contains an error of installation of the
        // unknown catalog)
        if (StrLComp(Buffer, 'IVSS', 4) = 0) then
           fConnectionOptionsDrv[coSupportsCatalog] := osOff
        else // TODO: need check MixedFetch for DataDirect
          fConnectionOptionsDrv[coMixedFetch] := osOn;

        if (fConnectionOptionsDrv[coMixedFetch] = osOn) and
           not (
            (fDbmsVersionMajor >= 8) and
            (fDbmsVersionMinor >= 0) and
            (fDbmsVersionRelease >= 384)
           )
        then
        begin
          (*
            It do not work for MSSQL2K: SELECT * FROM "dbo"."syscomments" when MixedFetch is
            turned On. It is detected on:
              Server version: SQL2K '08.00.0194'
              Odbc version: '2000.81.9030.04'
            --------------------------------------------------------------
            Error returned from ODBC function SQLExecute
            ODBC Return Code: -1: SQL_ERROR
            ODBC SqlState:        42000
            Native Error Code:    510
            [Microsoft][ODBC SQL Server Driver][SQL Server]Cannot create a
            worktable row larger than allowable maximum.
              Resubmit your query with the ROBUST PLAN hint.
            --------------------------------------------------------------
            All works when Server version is: SQL2K DE '08.00.0384' and
            ODBC version is: '03.81.9030'.
          *)
          fConnectionOptionsDrv[coMixedFetch] := osOff;
        end;
      end;
    eOdbcDriverTypeMsJet:
      begin
        // Edward> ???Ed>Vad: I have commented your line below? Jet can support
        // Edward> ???Ed>Vad: "catalog" (ie directory)
        // System.Include(fConnectionOptionsDrv, coNoSupportsCatalog);
        fConnectionOptionsDrv[coMixedFetch] := osOn;
      end;
    eOdbcDriverTypeMySql3: ; // New MySql Driver - Odbc Version 3!
    eOdbcDriverTypeMySql:
      begin
        fOdbcDriverLevel := 2; // MySql is Level 2
        fConnectionOptionsDrv[coSupportsCatalog] := osOff;
      end;
    eOdbcDriverTypeInformix:
      begin
        fWantQuotedTableName := False;
        //if ( StrLComp(buffer, 'PDINF', 5) = 0 ) // INTERSOLV Inc ODBC Driver (1997. Now is DataDirect)
        fConnectionOptionsDrv[coSupportsCatalog] := osOff; // INFORMIX supports operation with
        // the catalog, but usage of this option is inconvenient for the developers and there is no
        // large sense  by work with INFORMIX. If you want to work with the catalog, comment out this line.
        fConnectionOptionsDrv[coIgnoreUnknownFieldType] := osOn;
        fConnectionOptionsDrv[coMixedFetch] := osOn;// /??? need test
      end;
    eOdbcDriverTypeSQLLite:
      begin
        fOdbcDriverLevel := 2; // SqlLite is Level 2
        fConnectionOptionsDrv[coSupportsCatalog] := osOff;
      end;
    eOdbcDriverTypeThinkSQL:
      begin
        fConnectionOptionsDrv[coSupportsCatalog] := osOff;
      end;
    eOdbcDriverTypeOracle:
      begin
        fConnectionOptionsDrv[coSupportsSchemaFilter] := osOn;
        fConnectionOptionsDrv[coMixedFetch] := osOn;//??? need test
      end;
    eOdbcDriverTypePervasive:
      begin
        fOdbcDriverLevel := 2; // Pervasive is Level 2. Not supported OrdinalPosition for MetadataColumns.
        fConnectionOptionsDrv[coMixedFetch] := osOff; // Bug in driver. Driver not correctly supported
        // this option, but user can set it option in connection string or by custom options.
      end;
    //eOdbcDriverTypeNexusDbFlashFiler:
    eOdbcDriverTypePostgreSQL:
      begin
        fOdbcDriverLevel := 2; // PostgreSQL is Level 2
        // currently BLOBs not supported
        fConnectionOptionsDrv[coMixedFetch] := osOff; // need check when large field will ( bee ·Û‰ÛÚ) pÍesented
        // for simple data types and forward_only_cursor "array fetch" is supported.
      end;
    eOdbcDriverTypeInterSystemCache:
      begin
        fOdbcDriverLevel := 2; // Cache is Level 2
        //fConnectionOptionsDrv[coMixedFetch] := osOn;
      end;
    eOdbcDriverTypeMerantDBASE:
      begin
        fConnectionOptionsDrv[coMixedFetch] := osOff;
        fOdbcDriverLevel := 2;
      end;
  end; //of: case
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.RetrieveDriverName', e);  raise; end; end;
    finally
      LogInfoProc(['01-DbmsName =', fDbmsName]);
      LogInfoProc(['02-DbmsVersion=', fDbmsVersionString]);
      LogInfoProc(['03-OdbcDriverName=', fOdbcDriverName]);
      LogInfoProc(['04-OdbcDriverVer=', fOdbcDriverVersionString]);
      LogInfoProc(['05-OdbcDriverType=', cOdbcDriverType[fOdbcDriverType]]);
      LogInfoProc(['06-DbmsType=', cDbmsType[fDbmsType]]);
      LogExitProc('TSqlConnectionOdbc.RetrieveDriverName');
    end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.getSQLCommand(
  out pComm: ISQLCommand): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.getSQLCommand'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    // Cannot get command object until we have successfully connected
    if not fConnected then
      raise EDbxInvalidCall.Create('getSQLCommand called but not yet connected');
    pComm := TSqlCommandOdbc.Create(Self);
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      pComm := nil;
      fConnectionErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.getSQLCommand', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.getSQLCommand'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.getSQLMetaData(
  out pMetaData: ISQLMetaData): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.getSQLMetaData'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    // Cannot get metadata object until we have successfully connected
    if not fConnected then
      raise EDbxInvalidCall.Create('getSQLMetaData called but not yet connected');
    pMetaData := TSqlMetaDataOdbc.Create(Self);
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      pMetaData := nil;
      fConnectionErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.getSQLMetaData', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.getSQLMetaData'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.rollback(TranID: Longword): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.rollback', ['TranID=', TranID]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if fSupportsTransaction then
  try
    OdbcRetcode := SQLEndTran(SQL_HANDLE_DBC, fhCon, SQL_ROLLBACK);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLEndTran');
    Result := DBXpress.SQL_SUCCESS;
    fInTransaction := False;
  except
    on E: Exception{EDbxError} do
    begin
      fConnectionErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end
  else
  begin
    Result := DBXpress.SQL_SUCCESS;
    fInTransaction := False;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.rollback', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.rollback'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.SetOption(
  eConnectOption: TSQLConnectionOption; lValue: Integer): SQLResult;

var
  AttrValue: SqlUInteger;

{.$IFDEF _K3UP_}

  procedure SetConnectionCustomOptions;
  var
    i: TConnectionOption;
    OptionsString: String;
    cValue: Char;
  begin
    OptionsString := StrPas(PChar(lValue));
    if Length(OptionsString)=0 then
      exit;

    // Set Boolean Options
    if Length(OptionsString)>0 then
    for i := Low(TConnectionOption) to High(TConnectionOption) do
    begin
      cValue := GetOptionValue(
          OptionsString,
          {OptionName=}cConnectionOptionsNames[i],
          {HideOption=}True,
          {TrimResult=}True,
          {bOneChar=}True
        )[1];
      if cValue in [#0, ' '] then
        continue;
      SetConnectionOption(
        fConnectionOptions,
        {OptionDriverDefault=}@fConnectionOptionsDrv{need when value = 'x'},
        {Option=}i,
        {Value=}cValue
      );
      if Length(OptionsString)=0 then
        exit;
    end;

    // Set Integer Options

      //BlobChunkSize:
    fBlobChunkSize := StrToIntDef(GetOptionValue( OptionsString,
      {OptionName=}cBlobChunkSize, {HideOption=}True, {TrimResult=}True, {bOneChar=}False),
      -1);
    if fBlobChunkSize>=0 then
    begin
      if fBlobChunkSize < cBlobChunkSizeDefault then
        fBlobChunkSize := cBlobChunkSizeDefault
      else if fBlobChunkSize > cBlobChunkSizeLimit then
        fBlobChunkSize := cBlobChunkSizeLimit;
    end;

    if Length(OptionsString)>0 then
    begin
      //ConPacketSize:
      AttrValue := StrToIntDef(GetOptionValue( OptionsString,
        {OptionName=}cConPacketSize, {HideOption=}False, {TrimResult=}True, {bOneChar=}False),
        -1);
      if AttrValue>=0 then
      begin
        if (AttrValue < cConPacketSizeDefault) then
          AttrValue := cConPacketSizeDefault;
        if fConnected and (fConPacketSize <> AttrValue) then
          SQLSetConnectAttr(fhCon, SQL_ATTR_PACKET_SIZE, Pointer(fConPacketSize), 0);
        fConPacketSize := AttrValue;
      end;
    end;
  end;

const
  cBoolOptionSwitches: array[Boolean] of TOptionSwitches = (osOff, osOn);

{.$ENDIF}

  function isConnectionString(const ConnectionString, CatalogName: string): Boolean;
  begin
    Result := (CompareText(ConnectionString, CatalogName) = 0) or
      (CompareText(ConnectionString, 'DSN=' + CatalogName) = 0);
  end;

var
  OdbcRetcode: OdbcApi.SqlReturn;
  xeConnectOption: TXSQLConnectionOption absolute eConnectOption;

begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.SetOption', ['eConnectOption=', cSQLConnectionOption[xeConnectOption], 'lValue=', lValue]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case xeConnectOption of
      xeConnAutoCommit:
        begin
          if lValue = 0 then
            AttrValue := SQL_AUTOCOMMIT_OFF
          else
            AttrValue := SQL_AUTOCOMMIT_ON;
          fAutoCommitMode := AttrValue;
          OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_ATTR_AUTOCOMMIT, Pointer(AttrValue), 0);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLSetConnectAttr(SQL_ATTR_AUTOCOMMIT)');
        end;
      xeConnBlockingMode:
        // Asynchronous support
        raise EDbxInvalidCall.Create('TSqlConnectionOdbc.SetOption(eConnBlockingMode) not valid '
          +
          '(Read-only)');
      xeConnBlobSize:
        // "For drivers that donít provide the available blob size before fetching, this
        // specifies the number of kilobytes of BLOB data that is fetched for BLOB fields."
        fConnBlobSizeLimitK := lValue;
      xeConnRoleName:
        // String that specifies the role to use when establishing a connection. (Interbase only)
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnRoleName) not supported '
          +
          '- Applies to Interbase only');
      xeConnWaitOnLocks:
        // Boolean that indicates whether application should wait until a locked
        // resource is free rather than raise an exception. (Interbase only)
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnWaitOnLocks) not ' +
          'supported - Applies to Interbase only');
      xeConnCommitRetain:
        // Cursors dropped after commit
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnCommitRetain) not ' +
          'supported - Applies to Interbase only');
      xeConnTxnIsoLevel:
        begin
          case TTransIsolationLevel(lValue) of
            // Note that ODBC defines an even higher level of isolation, viz, SQL_TXN_SERIALIZABLE;
            // In this mode, Phantoms are not possible. (See ODBC spec).
            xilREPEATABLEREAD:
              // Dirty reads and nonrepeatable reads are not possible. Phantoms are possible
              AttrValue := SQL_TXN_REPEATABLE_READ;
            xilREADCOMMITTED:
              // Dirty reads are not possible. Nonrepeatable reads and phantoms are possible
              AttrValue := SQL_TXN_READ_COMMITTED;
            xilDIRTYREAD:
              // Dirty reads, nonrepeatable reads, and phantoms are possible.
              AttrValue := SQL_TXN_READ_COMMITTED;
          else
            raise EDbxInvalidCall.Create('TSqlConnectionOdbc.SetOption(eConnTxnIsoLevel) ' +
              'invalid isolation value: ' + IntToStr(lValue));
          end;
          OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_ATTR_TXN_ISOLATION, Pointer(AttrValue), 0);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLSetConnectAttr(SQL_ATTR_TXN_ISOLATION)');
        end;
      xeConnNativeHandle:
        // The native SQL connection handle (Read-only)
        raise EDbxInvalidCall.Create('TSqlConnectionOdbc.SetOption(eConnNativeHandle) not valid '
          +
          '(Read-only)');
      xeConnServerVersion:
        // The server version (Read-only)
        raise EDbxInvalidCall.Create('TSqlConnectionOdbc.SetOption(eConnServerVersion) not valid '
          +
          '(Read-only)');
      xeConnCallback:
        fDbxCallBack := TSQLCallBackEvent(lValue);
      xeConnCallBackInfo:
        fDbxCallBackInfo := lValue;
      xeConnHostName:
        raise EDbxInvalidCall.Create('TSqlConnectionOdbc.SetOption(eConnHostName) not valid ' +
          '(Read-only)');
      xeConnDatabaseName: // Readonly
        raise EDbxInvalidCall.Create('TSqlConnectionOdbc.SetOption(eConnDatabaseName) not valid '
          +
          '(Read-only)');
      xeConnObjectMode:
        // Boolean value to enable or disable object fields in Oracle8 tables
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnObjectMode) not ' +
          'supported - applies to Oracle only');
{.$IFDEF _K3UP_}
// This was renamed in Kylix3/Delphi7
      xeConnMaxActiveComm:
{.$ELSE}
//      eConnMaxActiveConnection:
{.$ENDIF}
        raise EDbxInvalidCall.Create('TSqlConnectionOdbc.SetOption(eConnMaxActiveConnection) not '
          +
          'valid (Read-only)');
      xeConnServerCharSet:
        raise EDbxInvalidCall.Create('TSqlConnectionOdbc.SetOption(eConnServerCharSet) not valid '
          +
          '(Read-only)');
      xeConnSqlDialect:
        // Interbase only
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnSqlDialect) not ' +
          'supported - applies to Interbase only');
      {+2.01 New options for Delphi 7}
{.$IFDEF _K3UP_}
      xeConnRollbackRetain:
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnRollbackRetain) ' +
          'not supported');
      xeConnObjectQuoteChar:
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnObjectQuoteChar) not ' +
          'valid (Read-only)');
      xeConnConnectionName:
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnConnectionName) not ' +
          'valid (Read-only');
      xeConnOSAuthentication:
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnOSAuthentication) not '
          +
          'supported');
      xeConnSupportsTransaction:
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnSupportsTransaction) ' +
          'not supported');
      xeConnMultipleTransaction:
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnMultipleTransaction) ' +
          'not supported');
      xeConnServerPort:
        raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnServerPort) not ' +
          'supported');
      xeConnOnLine: ;
      //raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnOnLine) not supported');
      xeConnTrimChar:
        fConnectionOptions[coTrimChar] := cBoolOptionSwitches[Boolean(lValue)];
{.$ENDIF} //of: IFNDEF _K3UP_
{.$IFDEF _D7UP_}
      xeConnQualifiedName:
        begin
          fQualifiedName := StrPas(PChar(lValue));
          // error in D7:
          {
          //Edward> ???Ed>Ed: - I do not understand what Vadim is saying here

          See QC2289: ...

          In Delphi7: Not full analysing when FSchemaName = ''. File "SqlExpr.pas":
          function TCustomSQLDataSet.GetQueryFromType: String;
             ...
               ctTable:
                 begin
                   if Self.FSchemaName <> '' then
                     STableName := AddQuoteCharToObjectName(Self, FSchemaName + '.' + FCommandText,
                                FSQLConnection.QuoteChar)
                   else
                     STableName := AddQuoteCharToObjectName(Self, FCommandText, FSQLConnection.QuoteChar);
                   if FSortFieldNames > '' then
                     Result := SSelectStarFrom + STableName + SOrderBy + FSortFieldNames
                   else
                     if FNativeCommand = '' then
                       Result := SSelectStarFrom + STableName
                     else
                     begin
                       //+ new line:
                       if Self.FSchemaName <> '' then
                       //+. ^^^^^^^^^^^^^^^^^^^^^^^^^
                       STableName := AddQuoteCharToObjectName(Self, FSchemaName + '.' + FNativeCommand,
                                FSQLConnection.QuoteChar)
                       //+ new line:
                       else
                       STableName := AddQuoteCharToObjectName(Self, FNativeCommand, FSQLConnection.QuoteChar)
                       //+. ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                       ;
                       Result := SSelectStarFrom + STableName;
                     end;
                 end;
               ctStoredProc:
          }
          // The padding code for the analysis of this situation:
          if (Length(fQualifiedName) > 0) and (fQualifiedName[1] = '.') then
            fQualifiedName := Copy(fQualifiedName, 2, Length(fQualifiedName) - 1);
        end;
      xeConnCatalogName:
        begin
          {+2.03}
          // Vadim> Error if NewCatalog=Currentcatalog (informix, mssql)
          // Edward> ???Ed>Vad I still don't think code below is correct
          if fSupportsCatalog and
            // catalog name <> connection string
          (not isConnectionString(fOdbcConnectString, StrPas(PAnsiChar(lValue)))) then
          begin
            GetCurrentCatalog;
            // catalog name <> current catalog
            if fSupportsCatalog and
              (StrCompNil(PAnsiChar(fCurrentCatalog), PAnsiChar(lValue)) <> 0) then
            begin
              OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_ATTR_CURRENT_CATALOG,
                PAnsiChar(lValue),
                SQL_NTS);
              if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
                OdbcCheck(OdbcRetcode, 'SQLSetConnectAttr(SQL_ATTR_CURRENT_CATALOG)');
            end;
          end;
          {/+2.03}
        end;
      xeConnSchemaName: ;
      //raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnSchemaName) not supported');
      xeConnObjectName: ;
      //raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnObjectName) not supported');
      xeConnQuotedObjectName: ;
      //raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnQuotedObjectName) not supported');
      xeConnCustomInfo:
        //raise EDbxNotSupported.Create('TSqlConnectionOdbc.SetOption(eConnCustomInfo) not supported');
        begin
          SetConnectionCustomOptions;
        end;
      xeConnTimeOut:
        //Vadim> ???Vad>All: not tested
        begin
          if lValue <= 0 then
            AttrValue := SQL_LOGIN_TIMEOUT_DEFAULT
          else
            AttrValue := lValue;
          OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_ATTR_LOGIN_TIMEOUT, Pointer(AttrValue), 0);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLSetConnectAttr(SQL_ATTR_LOGIN_TIMEOUT)');
        end;
{.$ENDIF} //of: IFDEF _D7UP_
      xeConnConnectionString:
        fConnConnectionString := StrPas(PChar(lValue));
    else
      raise EDbxInvalidCall.Create('Invalid option passed to TSqlConnectionOdbc.SetOption: ' +
        IntToStr(Ord(eConnectOption)));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      fConnectionErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.SetOption', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.SetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlConnectionOdbc.TransactionCheck;
var
  OdbcRetcode: OdbcApi.SqlReturn;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.TransactionCheck'); try try {$ENDIF _TRACE_CALLS_}
  if (not fSupportsTransaction)or(fInTransaction) then
    exit; // It's OK - already in a transaction
  if (fAutoCommitMode = SQL_AUTOCOMMIT_ON) then
    exit; // It's OK - already in AutoCommit mode

  OdbcRetcode := SQLSetConnectAttr(fhCon, SQL_ATTR_AUTOCOMMIT,
    Pointer(SqlUInteger(SQL_AUTOCOMMIT_ON)), 0);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLSetConnectAttr(SQL_ATTR_AUTOCOMMIT, SQL_AUTOCOMMIT_ON)');
  fAutoCommitMode := SQL_AUTOCOMMIT_ON;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.TransactionCheck', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.TransactionCheck'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.GetDbmsType: TDbmsType;
begin
  Result := fDbmsType;
end;

function TSqlConnectionOdbc.GetOdbcDriverType: TOdbcDriverType;
begin
  Result := fOdbcDriverType;
end;

procedure TSqlConnectionOdbc.GetOdbcConnectStrings(ConnectStringList: TStrings);
var
  i: Integer;
  s: string;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlConnectionOdbc.GetOdbcConnectStrings'); try try {$ENDIF _TRACE_CALLS_}
  if ConnectStringList = nil then
    ConnectStringList := TStringList.Create;
  s := '';
  ConnectStringList.BeginUpdate;
  for i := 1 to Length(fOdbcConnectString) do
  begin
    s := s + fOdbcConnectString[i];
    if fOdbcConnectString[i] = ';' then
    begin
      ConnectStringList.Add(s);
      s := '';
    end;
  end;
  if s <> '' then
    ConnectStringList.Add(s);
  ConnectStringList.EndUpdate;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlConnectionOdbc.GetOdbcConnectStrings', e);  raise; end; end;
    finally LogExitProc('TSqlConnectionOdbc.GetOdbcConnectStrings'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlConnectionOdbc.GetLastOdbcSqlState: PChar;
begin
  Result := @fSqlStateChars;
end;

function TSqlConnectionOdbc.GetDbmsName: string;
begin
  Result := fDbmsName;
end;

function TSqlConnectionOdbc.GetDbmsVersionMajor: Integer;
begin
  Result := fDbmsVersionMajor;
end;

function TSqlConnectionOdbc.GetDbmsVersionMinor: Integer;
begin
  Result := fDbmsVersionMinor;
end;

function TSqlConnectionOdbc.GetDbmsVersionRelease: Integer;
begin
  Result := fDbmsVersionRelease;
end;

function TSqlConnectionOdbc.GetDbmsVersionBuild: Integer;
begin
  Result := fDbmsVersionBuild;
end;

function TSqlConnectionOdbc.GetDbmsVersionString: string;
begin
  Result := fDbmsVersionString;
end;

function TSqlConnectionOdbc.GetOdbcDriverName: string;
begin
  Result := fOdbcDriverName;
end;

function TSqlConnectionOdbc.GetOdbcDriverVersionMajor: Integer;
begin
  Result := fOdbcDriverVersionMajor;
end;

function TSqlConnectionOdbc.GetOdbcDriverVersionMinor: Integer;
begin
  Result := fOdbcDriverVersionMinor;
end;

function TSqlConnectionOdbc.GetOdbcDriverVersionRelease: Integer;
begin
  Result := fOdbcDriverVersionRelease;
end;

function TSqlConnectionOdbc.GetOdbcDriverVersionBuild: Integer;
begin
  Result := fOdbcDriverVersionBuild;
end;

function TSqlConnectionOdbc.GetOdbcDriverVersionString: string;
begin
  Result := fOdbcDriverVersionString;
end;

function TSqlConnectionOdbc.GetOdbcConnectString: string;
begin
  Result := fOdbcConnectString;
end;

{ TSqlCommandOdbc }

constructor TSqlCommandOdbc.Create(OwnerDbxConnection: TSqlConnectionOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCommandOdbc.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited Create;
  fHStmt := SQL_NULL_HANDLE;
  fCommandErrorLines := TStringList.Create;
  fOwnerDbxConnection := OwnerDbxConnection;
  fOwnerDbxDriver := fOwnerDbxConnection.fOwnerDbxDriver;
  fCommandBlobSizeLimitK := fOwnerDbxConnection.fConnBlobSizeLimitK;
  fOwnerDbxConnection.AllocHStmt(fHStmt);
  fSupportsBlockRead := OwnerDbxConnection.fSupportsBlockRead;
  fSupportsMixedFetch := False;
  fCommandRowSetSize := 1;
{$IFDEF _K3UP_}
  //Support Trim of Fixed Char when connection parameter "Trim Char" is True
  fTrimChar := fOwnerDbxConnection.fConnectionOptions[coTrimChar] = osOn;
{$ENDIF}
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.Create', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSqlCommandOdbc.Destroy;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  i: Integer;
  aOdbcBindParam: TOdbcBindParam;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCommandOdbc.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  if (fHStmt <> SQL_NULL_HANDLE) then
  begin
    if not fStmtFreed then // [check added Stig Johansen]
    begin // else already called in TSqlCursorOdbc.Destroy;
      OdbcRetcode := SQLFreeStmt(fHStmt, SQL_CLOSE);
      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLFreeStmt(SQL_CLOSE)');

      OdbcRetcode := SQLFreeStmt(fHStmt, SQL_UNBIND);
      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLFreeStmt(SQL_UNBIND)');

      OdbcRetcode := SQLFreeStmt(fHStmt, SQL_RESET_PARAMS);
      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLFreeStmt(SQL_RESET_PARAMS)');
    end;

    // calls freehandle & sets SQL_NULL_HANDLE
    fOwnerDbxConnection.FreeHStmt(fHStmt);
  end;

  if (fOdbcParamList <> nil) then
  begin
    for i := fOdbcParamList.Count - 1 downto 0 do
    begin
      aOdbcBindParam := TOdbcBindParam(fOdbcParamList[i]);
      fOdbcParamList[i] := nil;
      aOdbcBindParam.Free;
    end;
    FreeAndNil(fOdbcParamList);
  end;

  FreeAndNil(fCommandErrorLines);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.Destroy', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCommandOdbc.OdbcCheck(OdbcCode: SqlReturn; const OdbcFunctionName: string);
begin
  fOwnerDbxDriver.OdbcCheck(OdbcCode, OdbcFunctionName, SQL_HANDLE_STMT, fHStmt,
    fOwnerDbxConnection, Self);
end;

function TSqlCommandOdbc.close: SQLResult;
begin
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCommandOdbc.execute(var Cursor: ISQLCursor): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  OdbcNumCols: SqlSmallint;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCommandOdbc.execute'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    fStmtFreed := False;
    fExecutedOk := False;
    fOwnerDbxConnection.TransactionCheck;

    OdbcRetcode := SQLExecute(fHStmt);
    if (OdbcRetcode <> OdbcApi.SQL_NO_DATA) and (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
      OdbcCheck(OdbcRetcode, 'SQLExecute');

    fPreparedOnly := False;

    // Get no of columns:
    OdbcRetcode := SQLNumResultCols(fHStmt, OdbcNumCols);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLNumResultCols in TSqlCommandOdbc.execute');

    if (OdbcNumCols = 0) then
      Cursor := nil
    else
      Cursor := TSqlCursorOdbc.Create(Self);

    fExecutedOk := True;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      Cursor := nil;
      fCommandErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.execute', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.execute'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCommandOdbc.ExecuteImmediate(SQL: PChar;
  var Cursor: ISQLCursor): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  OdbcNumCols: SqlSmallint;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCommandOdbc.ExecuteImmediate', ['SQL=', SQL]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    fStmtFreed := False;
    fExecutedOk := False;
    fSql := SQL;
    fPreparedOnly := False;
    fOwnerDbxConnection.TransactionCheck;
    OdbcRetcode := SQLExecDirect(fHStmt, SQL, SQL_NTS);
    // Some ODBC drivers return SQL_NO_DATA if update/delete statement did not
    // update/delete any rows
    if (OdbcRetcode <> OdbcApi.SQL_NO_DATA) and (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
      OdbcCheck(OdbcRetcode, 'SQLExecDirect');

    // Get no of columns:
    OdbcRetcode := SQLNumResultCols(fHStmt, OdbcNumCols);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLNumResultCols in TSqlCommandOdbc.ExecuteImmediate');

    if (OdbcNumCols = 0) then
      Cursor := nil
    else
      Cursor := TSqlCursorOdbc.Create(Self);

    fExecutedOk := True;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      Cursor := nil;
      fCommandErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.ExecuteImmediate', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.ExecuteImmediate'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCommandOdbc.getErrorMessage(Error: PChar): SQLResult;
begin
  if Error=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  StrCopy(Error, PChar(fCommandErrorLines.Text));
  fCommandErrorLines.Clear;
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCommandOdbc.getErrorMessageLen(
  out ErrorLen: Smallint): SQLResult;
begin
  ErrorLen := Length(fCommandErrorLines.Text);
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCommandOdbc.getNextCursor(var Cursor: ISQLCursor): SQLResult;
{ TODO : getNextCursor - THIS HAS NOT BEEN TESTED }
var
  OdbcRetcode: OdbcApi.SqlReturn;
  OdbcNumCols: SqlSmallint;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCommandOdbc.getNextCursor'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    OdbcRetcode := SQLMoreResults(fHStmt);
    if (OdbcRetcode = OdbcApi.SQL_NO_DATA) then
    begin
      Cursor := nil;
      Result := DBXpress.SQL_SUCCESS;
      exit;
    end;
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLMoreResults');

    // Code below is the same as for Execute...

    // Get number of columns:
    OdbcRetcode := SQLNumResultCols(fHStmt, OdbcNumCols);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLNumResultCols in TSqlCommandOdbc.getNextCursor');

    if (OdbcNumCols = 0) then
      Cursor := nil
    else
      Cursor := TSqlCursorOdbc.Create(Self);

    Result := DBXpress.SQL_SUCCESS;

  except
    on E: Exception{EDbxError} do
    begin
      Cursor := nil;
      fCommandErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.getNextCursor', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.getNextCursor'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCommandOdbc.GetOption(
  eSqlCommandOption: TSQLCommandOption;
// Borland changed GetOption function prototype between Delphi V6 and V7
// Kylix 3 uses Delphi 6 prototype
{$IFDEF _D7UP_}
  PropValue: Pointer;
{$ELSE}
  var pValue: Integer;
{$ENDIF}
  MaxLength: Smallint; out Length: Smallint): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  ValueLength: SqlSmallint;
{$IFDEF _D7UP_}
  xPropValue: Pointer absolute PropValue;
{$ELSE}
  xPropValue: Pointer;
{$ENDIF}
var
  xeSqlCommandOption: TXSQLCommandOption absolute eSqlCommandOption;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCommandOdbc.GetOption', ['eSqlCommandOption=', cSQLCommandOption[xeSqlCommandOption]]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
{$IFDEF _D7UP_}
  if PropValue=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
{$ELSE}
  xPropValue := @pValue;
{$ENDIF}
  try
    case xeSqlCommandOption of
      xeCommRowsetSize:
        begin // New for Delphi 6.02
          Integer(xPropValue^) := fCommandRowSetSize;
          Length := SizeOf(Integer);
        end;
      xeCommBlobSize:
        begin
          Integer(xPropValue^) := fCommandBlobSizeLimitK;
          Length := SizeOf(Integer);
        end;
      xeCommBlockRead:
        begin
          Boolean(xPropValue^) := fSupportsBlockRead;
          Length := SizeOf(Boolean);
        end;
      xeCommBlockWrite:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.GetOption(eCommBlockWrite) not yet implemented');
      xeCommParamCount:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.GetOption(eCommParamCount) not yet implemented');
      xeCommNativeHandle:
        begin
          Integer(xPropValue^) := Integer(fHStmt);
          Length := SizeOf(Integer);
        end;
      xeCommCursorName:
        begin
          OdbcRetcode := SQLGetCursorName(fHStmt, xPropValue, MaxLength, ValueLength);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLGetCursorName in TSqlCommandOdbc.GetOption');
          Length := ValueLength;
        end;
      xeCommStoredProc:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.GetOption(eCommStoredProc) not yet implemented');
      xeCommSQLDialect: // INTERBASE ONLY
        raise EDbxInvalidCall.Create(
          'TSqlCommandOdbc.GetOption(eCommSQLDialect) valid only for Interbase');
      xeCommTransactionID:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.GetOption(eCommTransactionID) not yet implemented');
{.$IFDEF _D7UP_}
      xeCommPackageName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.GetOption(eCommPackageName) not yet implemented');
      xeCommTrimChar:
        Boolean(xPropValue^) := fTrimChar;
      xeCommQualifiedName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.GetOption(eCommQualifiedName) not yet implemented');
      xeCommCatalogName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.GetOption(eCommCatalogName) not yet implemented');
      xeCommSchemaName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.GetOption(eCommSchemaName) not yet implemented');
      xeCommObjectName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.GetOption(eCommObjectName) not yet implemented');
      xeCommQuotedObjectName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.GetOption(eCommQuotedObjectName) not yet implemented');
{.$ENDIF} //of: IFDEF _D7UP_
    else
      raise EDbxNotSupported.Create('TSqlCommandOdbc.GetOption - Invalid option ' +
        IntToStr(Ord(eSqlCommandOption)));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on EDbxNotSupported do
    begin
      Length := 0;
      Integer(xPropValue^) := 0;
      Result := DBXERR_NOTSUPPORTED;
    end;
    on EDbxInvalidCall do
    begin
      Length := 0;
      Integer(xPropValue^) := 0;
      Result := DBXERR_INVALIDPARAM;
    end;
    on E: Exception{EDbxError} do
    begin
      Length := 0;
      Integer(xPropValue^) := 0;
      fCommandErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.GetOption', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.GetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCommandOdbc.getParameter(ParameterNumber, ulChildPos: Word;
  Value: Pointer; Length: Integer; var IsBlank: Integer): SQLResult;
{ TODO : getParameter - THIS HAS NOT BEEN TESTED }
var
  aOdbcBindParam: TOdbcBindParam;
begin
  {$IFDEF _TRACE_CALLS_}
    IsBlank := 1;
    if Value<>nil then Pointer(Value^) := nil;
    LogEnterProc('TSqlCommandOdbc.getParameter', ['ParameterNumber=', ParameterNumber, 'ulChildPos=', ulChildPos]);
    Result := SQL_SUCCESS;
    try try
  {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    if ParameterNumber > fOdbcParamList.Count then
      raise EDbxInvalidCall.Create(
        'TSqlConnectionOdbc.getParameter - ParameterNumber exceeds parameter count');
    aOdbcBindParam := TOdbcBindParam(fOdbcParamList.Items[ParameterNumber - 1]);
    if aOdbcBindParam.fOdbcParamLenOrInd = OdbcApi.SQL_NULL_DATA then
    begin
      Pointer(Value^) := nil;
      IsBlank := 1;
    end
    else
    begin
      IsBlank := 0;
      Move(aOdbcBindParam.fValue, Value^, Length);
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      IsBlank := 1;
      Pointer(Value^) := nil;
      fCommandErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.getParameter', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.getParameter', ['Value=', Pointer(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCommandOdbc.getRowsAffected(var Rows: Longword): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  OdbcRowsAffected: SqlInteger;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCommandOdbc.getRowsAffected'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}

  // This is a workaround because SqlExpress calls getRowsAffected after Close!
  if fStmtFreed then
  begin
    Rows := 0;
    Result := DBXpress.SQL_SUCCESS;
    exit;
  end;

  // This is another workaround because SqlExpress calls getRowsAffected after Error!
  if not fExecutedOk then
  begin
    Rows := 0;
    Result := DBXpress.SQL_SUCCESS;
    exit;
  end;

  try
    OdbcRetcode := SQLRowCount(fHStmt, OdbcRowsAffected);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLRowCount in TSqlCommandOdbc.getRowsAffected');
    if OdbcRowsAffected < 0 then
      Rows := 0
    else
      Rows := OdbcRowsAffected;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      Rows := 0;
      fCommandErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.getRowsAffected', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.getRowsAffected', ['Rows=', Rows]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCommandOdbc.prepare(SQL: PChar; ParamCount: Word): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  i: Integer;
  iParam: TOdbcBIndParam;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCommandOdbc.prepare', ['SQL=', SQL, 'ParamCount=', ParamCount]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if SQL=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    fStmtFreed := False;
    fExecutedOk := False;
    fSql := SQL;
    fOwnerDbxConnection.TransactionCheck;
    OdbcRetcode := SQLPrepare(fHStmt, SQL, SQL_NTS);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLPrepare');

    fPreparedOnly := True;

    if (fOdbcParamList <> nil) then
    begin
      for i := fOdbcParamList.Count - 1 downto 0 do
        TOdbcBindParam(fOdbcParamList[i]).Free;
      FreeAndNil(fOdbcParamList)
    end;

    if ParamCount > 0 then
    begin
      fOdbcParamList := TList.Create;
      fOdbcParamList.Count := ParamCount;
      for i := 0 to ParamCount - 1 do
      begin
        iParam := TOdbcBindParam.Create;
        fOdbcParamList[i] := iParam;
        iParam.fOdbcParamNumber := i + 1;
      end;
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      fCommandErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.prepare', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.prepare'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCommandOdbc.SetOption(eSqlCommandOption: TSQLCommandOption;
  ulValue: Integer): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  {$IFDEF _MIXED_FETCH_}
  AttrValue: SqlInteger;
  BufferLength: SqlInteger;
  {$ENDIF IFDEF _MIXED_FETCH_}
  xeSqlCommandOption: TXSQLCommandOption absolute eSqlCommandOption;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCommandOdbc.SetOption', ['eSqlCommandOption=', cSQLCommandOption[xeSqlCommandOption], 'ulValue=', ulValue]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case xeSqlCommandOption of
      xeCommRowsetSize:
        // Delphi 6.02 workaround - RowSetSize now set for all drivers
        begin
          {$IFDEF _MULTIROWS_FETCH_}
          if fExecutedOk then
            ulValue := fCommandRowSetSize
          else
          if (ulValue=0)or(ulValue=-1) then
            ulValue := 1
          else
          if (ulValue<0) then
            ulValue := fCommandRowSetSize;
          if (not fExecutedOk) and (not fSupportsBlockRead) and (ulValue>1) then
            ulValue := 1;
          if ulValue <> fCommandRowSetSize then
          begin
          {$IFDEF _MIXED_FETCH_}
            fSupportsMixedFetch := fSupportsBlockRead and
              (fOwnerDbxConnection.fConnectionOptions[coMixedFetch] = osOn);
            if fSupportsMixedFetch then
            begin
              OdbcRetcode := SQLGetStmtAttr(fHStmt, SQL_ATTR_CURSOR_TYPE,
                SqlPointer(@AttrValue), SizeOf(AttrValue), BufferLength);
              if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
              begin
                ulValue := 1;
                fOwnerDbxConnection.fConnectionOptions[coMixedFetch] := osOff;
                fSupportsMixedFetch := False;
              end;
              if fSupportsMixedFetch then
              begin
                if ulValue>1 then
                begin
                  if AttrValue <> SQL_CURSOR_STATIC then
                  begin
                    OdbcRetcode := SQLSetStmtAttr(fHStmt, SQL_ATTR_CURSOR_TYPE,
                      SqlPointer(SQL_CURSOR_STATIC), 0);
                    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
                    begin
                      ulValue := 1;
                      //fOwnerDbxConnection.fConnectionOptions[coMixedFetch] := osOff;
                      fSupportsMixedFetch := False;
                    end;
                    {$IFDEF _TRACE_CALLS_}
                    LogInfoProc(['Set cursor type to SQL_CURSOR_STATIC: ', OdbcRetcode = OdbcApi.SQL_SUCCESS]);
                    {$ENDIF IFDEF _TRACE_CALLS_}
                  end;
                end
                else
                begin
                  if AttrValue <> SQL_CURSOR_FORWARD_ONLY then
                  begin
                    OdbcRetcode := SQLSetStmtAttr(fHStmt, SQL_ATTR_CURSOR_TYPE,
                      SqlPointer(SQL_CURSOR_FORWARD_ONLY{=SQL_CURSOR_TYPE_DEFAULT}), 0);
                    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
                    begin
                      ulValue := 1;
                      fSupportsMixedFetch := False;
                      OdbcCheck(OdbcRetcode, 'SQLSetStmtAttr(SQL_ATTR_CURSOR_TYPE,SQL_CURSOR_FORWARD_ONLY)');
                    end;
                    {$IFDEF _TRACE_CALLS_}
                    LogInfoProc(['Set cursor type to SQL_CURSOR_FORWARD_ONLY: ', OdbcRetcode = OdbcApi.SQL_SUCCESS]);
                    {$ENDIF IFDEF _TRACE_CALLS_}
                  end;
                end;
              end;
            end;
          {$ENDIF IFDEF _MIXED_FETCH_}
            fCommandRowSetSize := ulValue;
            {$IFDEF _TRACE_CALLS_}
            LogInfoProc(['Set Fetch Rows Count: CommandRowSetSize = ', fCommandRowSetSize]);
            {$ENDIF IFDEF _TRACE_CALLS_}
          end;
          {$ENDIF _MULTIROWS_FETCH_}
        end;
      xeCommBlobSize:
        fCommandBlobSizeLimitK := ulValue;
      xeCommBlockRead:
        begin
          if Boolean(ulValue) <> fSupportsBlockRead then
          begin
            if Boolean(ulValue) and (not fOwnerDbxConnection.fSupportsBlockRead) then
              fSupportsBlockRead := False
            else
              fSupportsBlockRead := Boolean(ulValue);
          end;
        end;
      xeCommBlockWrite:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.SetOption(eCommBlockWrite) not yet implemented');
      xeCommParamCount:
        raise EDbxInvalidCall.Create(
          'TSqlCommandOdbc.SetOption(eCommParamCount) not valid (Read-only)');
      xeCommNativeHandle:
        raise EDbxInvalidCall.Create(
          'TSqlCommandOdbc.SetOption(eCommNativeHandle) not valid (Read-only)');
      xeCommCursorName:
        begin
          OdbcRetcode := SQLSetCursorName(fHStmt, Pointer(ulValue), SQL_NTS);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLSetCursorName');
        end;
      xeCommStoredProc: ;
      // raise EDbxNotSupported.Create('TSqlCommandOdbc.SetOption(eCommStoredProc) not yet implemented');
      xeCommSQLDialect:
        raise EDbxInvalidCall.Create(
          'TSqlCommandOdbc.SetOption(eCommStoredProc) not valid for ' +
          'this DBExpress driver (Interbase only)');
      xeCommTransactionID:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.SetOption(eCommTransactionID) not yet implemented');
{.$IFDEF _D7UP_}
      xeCommPackageName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.SetOption(eCommPackageName) not yet implemented');
      xeCommTrimChar:
        fTrimChar := Boolean(ulValue);
      xeCommQualifiedName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.SetOption(eCommQualifiedName) not yet implemented');
      xeCommCatalogName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.SetOption(eCommCatalogName) not yet implemented');
      xeCommSchemaName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.SetOption(eCommSchemaName) not yet implemented');
      xeCommObjectName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.SetOption(eCommObjectName) not yet implemented');
      xeCommQuotedObjectName:
        raise EDbxNotSupported.Create(
          'TSqlCommandOdbc.SetOption(eCommQuotedObjectName) not yet implemented');
{.$ENDIF} //of: IFDEF _D7UP_
    else
      raise EDbxInvalidCall.Create(
        'TSqlCommandOdbc.SetOption - Invalid option ' + IntToStr(Ord(eSqlCommandOption)));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: EDbxNotSupported do
      Result := DBXERR_NOTSUPPORTED;
    on E: Exception{EDbxError} do
    begin
      fCommandErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.SetOption', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.SetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{+2.08}

(*

 QC : 6169:

  BcdToStr can have results with a different separator.
  BcdToStr uses for a separator '.', and used by it FractionToStr
  uses global DecimalSeparator.
*)

function FractionToStr(const pIn: PChar; count: SmallInt;
         DecPosition: ShortInt; Negative: Boolean;
         StartWithDecimal: Boolean): string;
var
  NibblesIn, BytesIn, DigitsOut: Integer;
  P, POut: PChar;
  Dot: Char;

  procedure AddOneChar(Value: Char);
  begin
    P[0] := Value;
    Inc(P);
    Inc(DigitsOut);
  end;
  procedure AddDigit(Value: Char);
  begin
    if ((DecPosition > 0) and (NibblesIn  = DecPosition)) or
       ((NibblesIn = 0) and StartWithDecimal) then
    begin
      if DigitsOut = 0 then AddOneChar('0');
      AddOneChar(Dot);
    end;
    if (Value > #0) or (DigitsOut > 0) then
      AddOneChar(Char(Integer(Value)+48));
    Inc(NibblesIn);
  end;

begin
  POut := AllocMem(Count + 3);  // count + negative/decimal/zero
  try
    Dot := '.';//DecimalSeparator; //*** FIXED QC: 6169
    P := POut;
    DigitsOut := 0;
    BytesIn := 0;
    NibblesIn := 0;
    while NibblesIn < Count do
    begin
      AddDigit(Char(Integer(pIn[BytesIn]) SHR 4));
      if NibblesIn < Count then
        AddDigit(Char(Integer(pIn[BytesIn]) AND 15));
      Inc(BytesIn);
    end;
    while (DecPosition > 0) and (NibblesIn  > DecPosition) and (DigitsOut > 1) do
    begin
      if POut[DigitsOut-1] = '0' then
      begin
        Dec(DigitsOut);
        POut[DigitsOut] := #0;
      end else
        break;
    end;
    if POut[DigitsOut-1] = Dot then
      Dec(DigitsOut);
    POut[DigitsOut] := #0;
    SetString(Result, POut, DigitsOut);
  finally
    FreeMem(POut, Count + 2);
  end;
  if Result = '' then Result := '0'
  else if Negative then Result := '-' + Result;
end;

resourcestring
  SBcdOverflow = 'BCD overflow';

procedure OverflowError(const Message: string);
begin
  raise EBcdOverflowException.Create(Message);
end;

function BcdToStr(const Bcd: TBcd): string;
var
  NumDigits: Integer;
  pStart: PChar;
  DecPos: SmallInt;
  Negative: Boolean;
begin
  if (Bcd.Precision = 0) or (Bcd.Precision > MaxFMTBcdFractionSize) then
    OverFlowError(SBcdOverFlow)
  else
  begin
    Negative := Bcd.SignSpecialPlaces and (1 shl 7) <> 0;
    NumDigits := Bcd.Precision;
    pStart := pCHAR(@Bcd.Fraction);   // move to fractions
    // use lower 6 bits of iSignSpecialPlaces.
    if (Bcd.SignSpecialPlaces and 63) > 0 then
    begin
      DecPos := ShortInt(NumDigits - (Bcd.SignSpecialPlaces and 63));
    end else
      DecPos := NumDigits + 1;     // out of range
    Result := FractionToStr(pStart, NumDigits, DecPos, Negative,
           (NumDigits = Bcd.SignSpecialPlaces and 63));
    if Result[1] in ['0', '-'] then
      if (Result = '-0') or (Result = '0.0') or (Result = '-0.0') then Result := '0';
  end;
end;

{/+2.08}

function TSqlCommandOdbc.setParameter(
  ulParameter,
  ulChildPos: Word;
  eParamType: TSTMTParamType;
  uLogType,
  uSubType: Word;
  iPrecision,
  iScale: Integer;
  Length: Longword;
  pBuffer: Pointer;
  bIsNull: Integer
  ): SQLResult;

var
  OdbcRetcode: OdbcApi.SqlReturn;
  aMSecs: Double;
  aDays: Integer;
  aSeconds: Integer;
  aTimeStamp: TTimeStamp;
  aDateTime: TDateTime;
  aYear, aMonth, aDay: Word;
  aHour, aMinute, aSecond, aMSec: Word;
  s: string;
  aOdbcBindParam: TOdbcBindParam;
  aOutputBufferLength: Integer;
  pData: Pointer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCommandOdbc.setParameter', ['ulParameter=', ulParameter,
    'ulChildPos=', ulChildPos, 'eParamType=', cSTMTParamType[eParamType], 'uLogType=', uLogType,
    'uSubType=', uSubType, 'iPrecision=', iPrecision, 'iScale=', iScale, 'Length=', Length,
    'pBuffer=', 'pBuffer=', pBuffer, 'bIsNull=', bIsNull]);
    Result := SQL_SUCCESS;
    try try
  {$ENDIF _TRACE_CALLS_}
  try

    aOdbcBindParam := TOdbcBindParam(fOdbcParamList.Items[ulParameter - 1]);
    with aOdbcBindParam do
    begin

      case eParamType of
        paramUNKNOWN:
          begin
            raise EDbxNotSupported.Create(
              'TSqlCommandOdbc.setParameter - ParamType paramUNKNOWN not yet supoorted');
          end;
        paramIN:
          fOdbcInputOutputType := SQL_PARAM_INPUT;
        paramINOUT:
          fOdbcInputOutputType := SQL_PARAM_INPUT_OUTPUT;
        paramOUT:
          fOdbcInputOutputType := SQL_PARAM_OUTPUT;
        paramRET:
          fOdbcInputOutputType := SQL_PARAM_OUTPUT;
      end;

      fOdbcParamLenOrInd := 0;
      fOdbcParamIbScale := 0;
      FreeMemAndNil(fBuffer);

      // pointer to the Data Value
      if bIsNull=0 then
        pData := @fValue // Not NULL
      else
        pData := nil;    // NULL

      if (bIsNull <> 0) then
        fOdbcParamLenOrInd := OdbcApi.SQL_NULL_DATA;
      case uLogType of
        fldZSTRING:
          (*
          { fldZSTRING subtype }
            fldstPASSWORD      = 1;               { Password }
            fldstFIXED         = 31;              { CHAR type }
            fldstUNICODE       = 32;              { Unicode }
          *)
          begin
            if uSubType <> fldstUNICODE then
            begin
              fOdbcParamSqlType := SQL_VARCHAR;
              fOdbcParamCType := SQL_C_CHAR;
            end
            else
            begin
              fOdbcParamSqlType := SQL_WVARCHAR;
              fOdbcParamCType := SQL_C_WCHAR
            end;
            fOdbcParamCbColDef := Length;
            // Workaround Centura SqlBase bug - it crashes if parameter length increases
            // So, because string is null-terminated, we just indicate it has maximum length
            // Similar error affects MSSqlServer with MDAC 2.6 (but not earlier or later versions)
            // If parameter length increases, if does not crash, but it does not find the item
            // So we set to 255 for all drivers, not just Centura
//            if fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeGupta then
              if Length < 255 then
                fOdbcParamCbColDef := 255;

            {+2.042}
            {
              New Connection Option: "EmptyStrParam"
              Some ODBC of the driver do not handle a situation, when the string has zero length.
              For them it was necessary to write in the code following:
              procedure TForm1.DataSetBeforePost((DataSet: TDataSet);
              begin
                if Length(DataSet.FieldByName('customer').AsString) = 0 then
                  DataSet.FieldByName('customer').Clear;
              end;
              To avoid it, now it is enough in connection string to indicate EmptyStrParam=0
            }
            if (fOwnerDbxConnection.fConnectionOptions[coEmptyStrParam] = osOff)
              and
              (bIsNull = 0) and (StrLen(pBuffer) = 0) then
            begin
              pBuffer := nil;
              bIsNull := 1;
            end;
            {/+2.042}

            if (bIsNull = 0) then
            begin // Not NULL
              fOdbcParamLenOrInd := SQL_NTS;
              if Length > 255 then
              begin
                fBuffer := AllocMem(Length + 1); // Add 1 for null terminator
                pData := fBuffer;
                if (bIsNull = 0) then
                  Move(pBuffer^, fBuffer^, Length);
              end
              else
                StrCopy(fValue.OdbcParamValueString, pBuffer);
            end
            else
            begin
              if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeMsSqlServer) then
                // MsSqlServer driver insists on non-zero length, even for NULL values
                fOdbcParamCbColDef := 1;
            end;

          end;
        fldINT32, fldUINT32:
          (*
          { fldINT32 subtype }
            fldstAUTOINC       = 29;
          *)
          begin
            if uLogType = fldINT32 then
              fOdbcParamCType := SQL_C_LONG
            else
              fOdbcParamCType := SQL_C_ULONG;
            fOdbcParamSqlType := SQL_INTEGER;
            fOdbcParamCbColDef := SizeOf(SqlInteger);
            if (bIsNull = 0) then
            begin
              fOdbcParamLenOrInd := SizeOf(SqlInteger);
              fValue.OdbcParamValueInteger := SqlInteger(pBuffer^);
            end;
          end;
        fldINT16, fldUINT16:
          begin
            if uLogType = fldINT16 then
              fOdbcParamCType := SQL_C_SHORT
            else
              fOdbcParamCType := SQL_C_USHORT;
            fOdbcParamSqlType := SQL_SMALLINT;
            fOdbcParamCbColDef := SizeOf(SqlSmallint);
            if (bIsNull = 0) then
            begin
              fOdbcParamLenOrInd := SizeOf(SqlSmallint);
              fValue.OdbcParamValueShort := SqlSmallint(pBuffer^);
            end;
          end;
        fldINT64, fldUINT64:
          begin
            fOdbcParamSqlType := SQL_BIGINT;
            if uLogType = fldINT64 then
              fOdbcParamCType := SQL_C_SBIGINT
            else
              fOdbcParamCType := SQL_C_UBIGINT;
            fOdbcParamCbColDef := SizeOf(SqlBigInt);
            if (bIsNull = 0) then
            begin
              fOdbcParamLenOrInd := SizeOf(SqlBigInt);
              fValue.OdbcParamValueBigInt := SqlBigInt(pBuffer^);
            end;
          end;
        fldFLOAT: // 64-bit floating point
          (*
          { fldFLOAT subtype }
            fldstMONEY         = 21;              { Money }
          *)
          begin
            fOdbcParamCType := SQL_C_DOUBLE;
            fOdbcParamSqlType := SQL_DOUBLE;
            fOdbcParamCbColDef := SizeOf(SqlDouble);
            if (bIsNull = 0) then
            begin
              fOdbcParamLenOrInd := SizeOf(SqlDouble);
              fValue.OdbcParamValueDouble := SqlDouble(pBuffer^);
            end;
          end;
        fldDATE:
          begin
            (*
            { fldDATE subtype }
              fldstADTDATE       = 37;              { DATE (OCIDate) with in an ADT }
            *)
            fOdbcParamCType := SQL_C_DATE;
            fOdbcParamSqlType := SQL_DATE;
            fOdbcParamCbColDef := SizeOf(TSqlDateStruct);
            if (bIsNull = 0) then
            begin
              fOdbcParamLenOrInd := SizeOf(TSqlDateStruct);
              aDays := Integer(pBuffer^) - DateDelta;
              // DateDelta: Days between 1/1/0001 and 12/31/1899 = 693594,
              // ie (1899 * 365) (normal days) + 460 (leap days) - 1
              //(-1: correction for being last day of 1899)
              // leap days between 0001 and 1899 = 460, ie 1896/4 - 14
              // (-14: because 14 years weren't leap years:
              // 100,200,300, 500,600,700, 900,1000,1100, 1300,1400,1500, 1700,1800)
              DecodeDate(aDays, aYear, aMonth, aDay);
              fValue.OdbcParamValueDate.Year := aYear;
              fValue.OdbcParamValueDate.Month := aMonth;
              fValue.OdbcParamValueDate.Day := aDay;
            end;
          end;
        fldTIME:
          begin
            fOdbcParamCType := SQL_C_TIME;
            fOdbcParamSqlType := SQL_TIME;
            fOdbcParamCbColDef := SizeOf(TSqlTimeStruct);
            if (bIsNull = 0) then
            begin
              // Value is time in Microseconds
              aSeconds := Longword(pBuffer^) div 1000;
              fOdbcParamLenOrInd := SizeOf(TSqlTimeStruct);
              fValue.OdbcParamValueTime.Hour := aSeconds div 3600;
              fValue.OdbcParamValueTime.Minute := (aSeconds div 60) mod 60;
              fValue.OdbcParamValueTime.Second := aSeconds mod 60;
            end;
          end;
        fldDATETIME:
          begin
            fOdbcParamCType := SQL_C_TIMESTAMP;
            fOdbcParamSqlType := SQL_TIMESTAMP;
            fOdbcParamCbColDef := 26;
            fOdbcParamIbScale := 6;
            if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeMsSqlServer) then
            begin
              // Workaround SqlServer driver - it only allows max scale of 3
              fOdbcParamCbColDef := 23;
              fOdbcParamIbScale := 3;
            end;
            if (bIsNull = 0) then
            begin
              fOdbcParamLenOrInd := SizeOf(SQL_TIMESTAMP_STRUCT);
              fValue.OdbcParamValueTimeStamp.Year := TSQLTimeStamp(pBuffer^).Year;
              fValue.OdbcParamValueTimeStamp.Month := TSQLTimeStamp(pBuffer^).Month;
              fValue.OdbcParamValueTimeStamp.Day := TSQLTimeStamp(pBuffer^).Day;
              fValue.OdbcParamValueTimeStamp.Hour := TSQLTimeStamp(pBuffer^).Hour;
              fValue.OdbcParamValueTimeStamp.Minute := TSQLTimeStamp(pBuffer^).Minute;
              fValue.OdbcParamValueTimeStamp.Second := TSQLTimeStamp(pBuffer^).Second;
              // Odbc in nanoseconds; DbExpress in milliseconds; so multiply by 1 million
              fValue.OdbcParamValueTimeStamp.Fraction :=
                TSQLTimeStamp(pBuffer^).Fractions * 1000000;
            end;
          end;
        fldTIMESTAMP: // fldTIMESTAMP added by Michael Schwarzl, to support MS SqlServer 2000
          begin
// Fix by David McCammond-Watts (not tested)
// Old code assumes that the pBuffer parameter points to a TSQLTimeStamp record.
// In fact, it points to a Double that contains the number of milliseconds since
// 01/01/0001 minus one day.
            fOdbcParamCType := SQL_C_TIMESTAMP;
            fOdbcParamSqlType := SQL_TIMESTAMP;
            fOdbcParamCbColDef := 26;
            fOdbcParamIbScale := 6;
            if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeMsSqlServer) then
            begin
              // Workaround SqlServer driver - it only allows max scale of 3
              fOdbcParamCbColDef := 23;
              fOdbcParamIbScale := 3;
            end;
            if (bIsNull = 0) then
            begin
//              aTimeStamp := TTimeStamp(pBuffer^);
              aMSecs := Double(pBuffer^);
              aTimeStamp := MSecsToTimeStamp(aMSecs);
              aDateTime := TimeStampToDateTime(aTimeStamp);
              DecodeDate(aDateTime, aYear, aMonth, aDay);
              DecodeTime(aDateTime, aHour, aMinute, aSecond, aMSec);
              fValue.OdbcParamValueTimeStamp.Year := aYear;
              fValue.OdbcParamValueTimeStamp.Month := aMonth;
              fValue.OdbcParamValueTimeStamp.Day := aDay;
              fValue.OdbcParamValueTimeStamp.Hour := aHour;
              fValue.OdbcParamValueTimeStamp.Minute := aMinute;
              fValue.OdbcParamValueTimeStamp.Second := aSecond;
              // Odbc in nanoseconds; DbExpress in  milliseconds; so multiply by 1 million
              fValue.OdbcParamValueTimeStamp.Fraction := aMSec * 1000000;
            end;
          end;
        fldBCD:
          begin
            fOdbcParamCType := SQL_C_CHAR;
            fOdbcParamSqlType := SQL_DECIMAL;
            if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeMsJet) then
              fOdbcParamSqlType := SQL_NUMERIC; // MS ACCESS driver does not allow SQL_DECIMAL
            fOdbcParamCbColDef := iPrecision;
            fOdbcParamIbScale := iScale;
            if (bIsNull = 0) then
            begin
              fOdbcParamLenOrInd := SQL_NTS;
              s := BcdToStr(TBcd(pBuffer^));
              {+2.01}// Vadim V.Lopushansky: changing to updating BCD values when DecimalSeparator <> '.'
              // Edward> Yes, I think ODBC parameters ALWAYS use '.' as decimal separator
              // It is Actual only for embedded dbxoodbc (When the user changes DecimalSeparator).
              //if (iScale > 0) and (DecimalSeparator <> '.') then
              //  s := StringReplace(s, DecimalSeparator, '.', [rfIgnoreCase]);
              {+2.08}
              // It is bug in FMTBcd.pas. See QC: 6169. BcdToStr it is corrected above.
              {/+2.08}
              {/+2.01}
              StrCopy(fValue.OdbcParamValueString, PChar(s));
            end
            else
            begin
              if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeMsSqlServer) then
                // MsSqlServer driver insists on non-zero length, even for NULL values
                fOdbcParamCbColDef := 1;
            end;
          end;
        fldBOOL:
          begin
            fOdbcParamCType := SQL_C_BIT;
            fOdbcParamSqlType := SQL_BIT; // MS ACCESS driver does not allow SQL_DECIMAL
            fOdbcParamCbColDef := 1;
            if (bIsNull = 0) then
            begin
              fOdbcParamLenOrInd := 1;
              if SqlByte(pBuffer^) = 0 then
                fValue.OdbcParamValueBit := 0
              else
                fValue.OdbcParamValueBit := 1;
            end;
          end;
        fldBLOB:
          (*
          { fldBLOB subtypes }
            fldstMEMO          = 22;              { Text Memo }
            fldstBINARY        = 23;              { Binary data }
            fldstFMTMEMO       = 24;              { Formatted Text }
            fldstOLEOBJ        = 25;              { OLE object (Paradox) }
            fldstGRAPHIC       = 26;              { Graphics object }
            fldstDBSOLEOBJ     = 27;              { dBASE OLE object }
            fldstTYPEDBINARY   = 28;              { Typed Binary data }
            fldstACCOLEOBJ     = 30;              { Access OLE object }
            fldstHMEMO         = 33;              { CLOB }
            fldstHBINARY       = 34;              { BLOB }
            fldstBFILE         = 36;              { BFILE }
          *)
          begin
            if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeSQLLite) then
              uSubType := fldstMEMO;
            case uSubType of
              fldstBINARY, fldstGRAPHIC, fldstTYPEDBINARY, fldstHBINARY:
                begin
                  fOdbcParamCType := SQL_C_BINARY;
                  fOdbcParamSqlType := SQL_LONGVARBINARY;
                end;
              fldstMEMO, fldstFMTMEMO, fldstHMEMO:
                begin
                  fOdbcParamCType := SQL_C_CHAR;
                  fOdbcParamSqlType := SQL_LONGVARCHAR;
                end;
            else
              begin
                raise EDbxNotSupported.Create(
                  'TSqlCommandOdbc.setParameter - This data sub-type not yet supoorted');
              end;
            end;

            if (bIsNull = 0) then
            begin
              fOdbcParamLenOrInd := Length;
              fOdbcParamCbColDef := Length;
              fBuffer := AllocMem(Length);
              Move(pBuffer^, fBuffer^, Length);
            end
            else
            begin
              // MsSqlServer driver insists on non-zero length, even for NULL values
              if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeMsSqlServer) then
                fOdbcParamCbColDef := 1;
              fBuffer := nil;
              if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeSQLLite) then
              begin
                fOdbcParamCbColDef := 1;
                fBuffer := AllocMem(1);
                PChar(fBuffer)^ := #0;
              end;

            end;
            pData := fBuffer;
          end;
        fldBYTES, fldVARBYTES:
          begin
            if uLogType = fldBYTES then
              fOdbcParamSqlType := SQL_BINARY
            else
              fOdbcParamSqlType := SQL_VARBINARY;
            fOdbcParamCType := SQL_C_BINARY;
            if (bIsNull = 0) then
            begin
              fOdbcParamLenOrInd := Length;
              fOdbcParamCbColDef := Length;
              fBuffer := AllocMem(Length);
              Move(pBuffer^, fBuffer^, Length);
            end
            else
            begin
              // MsSqlServer driver insists on non-zero length, even for NULL values
              if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeMsSqlServer) then
                fOdbcParamCbColDef := 1;
              fBuffer := nil;
            end;
            pData := fBuffer;
          end;
//  fldLOCKINFO        = 16;              { Look for LOCKINFO typedef }
//  fldCURSOR          = 17;              { For Oracle Cursor type }
//  fldADT             = 20;              { Abstract datatype (structure) }
     (*
     { fldADT subtype }
       fldstADTNestedTable = 35;             { ADT for nested table (has no name) }
     *)
//  fldARRAY           = 21;              { Array field type }
//  fldREF             = 22;              { Reference to ADT }
//  fldTABLE           = 23;              { Nested table (reference) }
      else
        raise EDbxNotSupported.Create('TSqlCommandOdbc.setParameter(Type='+IntToStr(uLogType)+
          ') - This data type not yet supported');
      end; //of:case

      aOutputBufferLength := fOdbcParamCbColDef;
      OdbcRetcode := SQLBindParameter(
        fHStmt, // Odbc statement handle
        ulParameter, // Parameter number, starting at 1
        fOdbcInputOutputType, // Parameter InputOutputType
        fOdbcParamCType, // 'C' data type of paremeter - Sets SQL_DESC_TYPE of APD (application parameter descriptor)
        fOdbcParamSqlType, // 'Sql' data type of paremeter - Sets SQL_DESC_TYPE of IPD (implementation parameter descriptor)
        fOdbcParamCbColDef, fOdbcParamIbScale,
        pData, // pointer to the Data Value
        aOutputBufferLength, @fOdbcParamLenOrInd);
      // Second to last argument applies to Output (or Input/Output) parameters only
      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLBindParameter');
      Result := DBXpress.SQL_SUCCESS;
    end; //of: with aOdbcBindParam
  except
    on EDbxNotSupported do
      Result := DBXERR_NOTSUPPORTED;
    on E: Exception{EDbxError} do
    begin
      fCommandErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCommandOdbc.setParameter', e);  raise; end; end;
    finally LogExitProc('TSqlCommandOdbc.setParameter'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TSQLMetaDataOdbc }

constructor TSQLMetaDataOdbc.Create(OwnerDbxConnection: TSqlConnectionOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSQLMetaDataOdbc.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited Create;
  fMetaDataErrorLines := TStringList.Create;
  fOwnerDbxConnection := OwnerDbxConnection;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSQLMetaDataOdbc.Create', e);  raise; end; end;
    finally LogExitProc('TSQLMetaDataOdbc.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSQLMetaDataOdbc.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSQLMetaDataOdbc.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  FreeAndNil(fMetaDataErrorLines);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSQLMetaDataOdbc.Destroy', e);  raise; end; end;
    finally LogExitProc('TSQLMetaDataOdbc.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSQLMetaDataOdbc.getColumns(
  TableName,
  ColumnName: PChar;
  ColType: Longword;
  out Cursor: ISQLCursor
  ): SQLResult;
var
  aCursor: TSqlCursorMetaDataColumns;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSQLMetaDataOdbc.getColumns'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  aCursor := TSqlCursorMetaDataColumns.Create(Self);
  try
    {+2.01}//Vadim V.Lopushansky:
    if fOwnerDbxConnection.fConnectionOptions[coSupportsMetadata] = osOn then
      {/+2.01}
      aCursor.FetchColumns(TableName, ColumnName, ColType);
    Cursor := aCursor;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      aCursor.Free;
      Cursor := nil;
      fMetaDataErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSQLMetaDataOdbc.getColumns', e);  raise; end; end;
    finally LogExitProc('TSQLMetaDataOdbc.getColumns'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSQLMetaDataOdbc.getErrorMessage(Error: PChar): SQLResult;
begin
  if Error=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  StrCopy(Error, PChar(fMetaDataErrorLines.Text));
  fMetaDataErrorLines.Clear;
  Result := DBXpress.SQL_SUCCESS;
end;

function TSQLMetaDataOdbc.getErrorMessageLen(
  out ErrorLen: Smallint): SQLResult;
begin
  ErrorLen := Length(fMetaDataErrorLines.Text);
  Result := DBXpress.SQL_SUCCESS;
end;

function TSQLMetaDataOdbc.getIndices(TableName: PChar; IndexType: Longword;
  out Cursor: ISQLCursor): SQLResult;
var
  aCursor: TSqlCursorMetaDataIndexes;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSQLMetaDataOdbc.getIndices', ['TableName=', TableName, 'IndexType=', IndexType]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  aCursor := TSqlCursorMetaDataIndexes.Create(Self);
  try
    {+2.01}//Vadim V.Lopushansky:
    if fOwnerDbxConnection.fConnectionOptions[coSupportsMetadata] = osOn then
      {/+2.01}
      if fOwnerDbxConnection.fSupportsSQLSTATISTICS then
        aCursor.FetchIndexes(TableName, IndexType);
    Cursor := aCursor;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      aCursor.Free;
      Cursor := nil;
      fMetaDataErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSQLMetaDataOdbc.getIndices', e);  raise; end; end;
    finally LogExitProc('TSQLMetaDataOdbc.getIndices'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSQLMetaDataOdbc.getObjectList(eObjType: TSQLObjectType;
  out Cursor: ISQLCursor): SQLResult;
begin
  Result := DBXERR_NOTSUPPORTED;
  {
  try
    raise EDbxNotSupported.Create(
      'TSQLMetaDataOdbc.getObjectList - not yet supported');
  except
    on E: EDbxNotSupported do
      Result := DBXERR_NOTSUPPORTED;
  end;
  }
end;

function TSQLMetaDataOdbc.GetOption(eDOption: TSQLMetaDataOption;
  PropValue: Pointer; MaxLength: Smallint;
  out Length: Smallint): SQLResult;
var
  xeDOption: TXSQLMetaDataOption absolute eDOption;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSQLMetaDataOdbc.GetOption', ['eDOption=', cSQLMetaDataOption[xeDOption]]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    Result := fOwnerDbxConnection.GetMetaDataOption(eDOption, PropValue, MaxLength, Length);
  except
    on E: EDbxNotSupported do
    begin
      Length := 0;
      Result := DBXERR_NOTSUPPORTED;
    end;
    on E: Exception{EDbxError} do
    begin
      Length := 0;
      fMetaDataErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSQLMetaDataOdbc.GetOption', e);  raise; end; end;
    finally LogExitProc('TSQLMetaDataOdbc.GetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSQLMetaDataOdbc.getProcedureParams(ProcName, ParamName: PChar;
  out Cursor: ISQLCursor): SQLResult;
var
  aCursor: TSqlCursorMetaDataProcedureParams;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSQLMetaDataOdbc.getProcedureParams', ['ProcName=', ProcName, 'ParamName=', ParamName]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  aCursor := TSqlCursorMetaDataProcedureParams.Create(Self);
  try
    {+2.01}//Vadim V.Lopushansky:
    if fOwnerDbxConnection.fConnectionOptions[coSupportsMetadata] = osOn then
      {/+2.01}
      aCursor.FetchProcedureParams(ProcName, ParamName);
    Cursor := aCursor;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      aCursor.Free;
      Cursor := nil;
      fMetaDataErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSQLMetaDataOdbc.getProcedureParams', e);  raise; end; end;
    finally LogExitProc('TSQLMetaDataOdbc.getProcedureParams'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSQLMetaDataOdbc.getProcedures(
  ProcedureName: PChar;
  ProcType: Longword;
  out Cursor: ISQLCursor
  ): SQLResult;
var
  aCursor: TSqlCursorMetaDataProcedures;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSQLMetaDataOdbc.getProcedures', ['ProcedureName=', ProcedureName, 'ProcType=', ProcType]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  aCursor := TSqlCursorMetaDataProcedures.Create(Self);
  try
    {+2.01}//Vadim V.Lopushansky:
    if fOwnerDbxConnection.fConnectionOptions[coSupportsMetadata] = osOn then
      {/+2.01}
      aCursor.FetchProcedures(ProcedureName, ProcType);
    Cursor := aCursor;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      aCursor.Free;
      Cursor := nil;
      fMetaDataErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSQLMetaDataOdbc.getProcedures', e);  raise; end; end;
    finally LogExitProc('TSQLMetaDataOdbc.getProcedures'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSQLMetaDataOdbc.getTables(TableName: PChar; TableType: Longword;
  out Cursor: ISQLCursor): SQLResult;
var
  aCursor: TSqlCursorMetaDataTables;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSQLMetaDataOdbc.getTables', ['TableName=', TableName, 'TableType=', TableType]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  aCursor := TSqlCursorMetaDataTables.Create(Self);
  try
    aCursor.FetchTables(TableName, TableType);
    Cursor := aCursor;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      aCursor.Free;
      Cursor := nil;
      fMetaDataErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSQLMetaDataOdbc.getTables', e);  raise; end; end;
    finally LogExitProc('TSQLMetaDataOdbc.getTables'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSQLMetaDataOdbc.SetOption(
  eDOption: TSQLMetaDataOption;
  PropValue: Integer): SQLResult;
var
  //OdbcRetCode: OdbcApi.SQLRETURN;
  xeDOption: TXSQLMetaDataOption absolute eDOption;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSQLMetaDataOdbc.SetOption', ['eDOption=', cSQLMetaDataOption[xeDOption], 'PropValue=', PropValue]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case xeDOption of
      xeMetaCatalogName:
        //Edward> Code below commented
        //Edward> MS SqlServer returns error, "Invalid cursor state"
        //Edward> I don't know why DbExpress needs to call this anyway
        begin
          {if fOwnerDbxConnection.fDbxCatalog <> PAnsiChar(PropValue) then
           begin
             fOwnerDbxConnection.fDbxCatalog := PAnsiChar(PropValue);
             if fOwnerDbxConnection.fSupportsCatalog then
             begin
               OdbcRetCode := SQLSetConnectAttr(fOwnerDbxConnection.fhCon,
                 SQL_ATTR_CURRENT_CATALOG, PAnsiChar(PropValue), SQL_NTS);
               if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
                 fOwnerDbxConnection.OdbcCheck (OdbcRetCode,
                   'SQLSetConnectAttr(SQL_ATTR_CURRENT_CATALOG)');
             end;
           end;{}
        end;
      xeMetaSchemaName:
        begin
          {+2.01}

          // Vadim> ???Vad>All: In Oracle very slowly are read Synonyms.
          // Edward> I don't have Oracle, so I do not know

          // Vadim> Cached Schema into fCurrentSchema
          // Vadim> It is not allowed to change the schema, since in SqlExpr.pas
          // Vadim> the errors are contained.
          // Edward> ???Ed>Vad: I don't understand, but I have kept your code
          // Edward> My original code did nothing here, reason in comment just below

          if (fOwnerDbxConnection.fConnectionOptions[coSupportsSchemaFilter] = osOn) and
            (Length(fOwnerDbxConnection.fCurrentSchema) = 0) and
            (StrLen(PAnsiChar(PropValue)) > 0) then
            fOwnerDbxConnection.fCurrentSchema := StrPas(PAnsiChar(PropValue));
          {/+2.01}
          {
          SQLExpress calls this option to set SCHEMA name to login USERNAME immediately after connecting.
          This is behavior is undesirable. Probably a bug.
          (We return fully qualified table names where appropriate,
          eg UserId 'ED' may want to view table 'SYSSQL.SYSTABLES').
          So we just IGNORE this option.
          }
        end;
      xeMetaDatabaseName: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaDatabaseName) not valid (Read-only)');
      xeMetaDatabaseVersion: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaDatabaseVersion) not valid (Read-only)');
      xeMetaTransactionIsoLevel: // (Read-only:
        // use the options of SQLConnection to set the transaction isolation level)
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaTransactionIsoLevel) not valid (Read-only) ' +
          '(Use options of ISQLConnection instead)');
      xeMetaSupportsTransaction: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaSupportsTransaction) not valid (Read-only)');
      xeMetaMaxObjectNameLength: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaMaxObjectNameLength) not valid (Read-only)');
      xeMetaMaxColumnsInTable: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaMaxColumnsInTable) not valid (Read-only)');
      xeMetaMaxColumnsInSelect: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaMaxColumnsInSelect) not valid (Read-only)');
      xeMetaMaxRowSize: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaMaxRowSize) not valid (Read-only)');
      xeMetaMaxSQLLength: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaMaxSQLLength) not valid (Read-only)');
      xeMetaObjectQuoteChar: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaObjectQuoteChar) not valid (Read-only)');
      xeMetaSQLEscapeChar: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaSQLEscapeChar) not valid (Read-only)');
      xeMetaProcSupportsCursor: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaProcSupportsCursor) not valid (Read-only)');
      xeMetaProcSupportsCursors: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaProcSupportsCursors) not valid (Read-only)');
      xeMetaSupportsTransactions: // Read-only
        raise EDbxInvalidCall.Create(
          'TSQLMetaDataOdbc.SetOption(eMetaSupportsTransactions) not valid (Read-only)');
{.$IFDEF _K3UP_}
      xeMetaPackageName: ; //It is required for ORACLE
// ????? Ed>Vad/All - Should we do something here?
{.$ENDIF}
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: EDbxNotSupported do
      Result := DBXERR_NOTSUPPORTED;
    on E: EDbxInvalidCall do
      Result := DBXERR_INVALIDPARAM;
    on E: Exception{EDbxError} do
    begin
      fMetaDataErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSQLMetaDataOdbc.SetOption', e);  raise; end; end;
    finally LogExitProc('TSQLMetaDataOdbc.SetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TSqlCursorOdbc }

constructor TSqlCursorOdbc.Create(OwnerCommand: TSqlCommandOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited create;

  fCursorErrorLines := TStringList.Create;
  fOwnerCommand := OwnerCommand;
  fOwnerDbxConnection := OwnerCommand.fOwnerDbxConnection;
  fOwnerDbxDriver := fOwnerDbxConnection.fOwnerDbxDriver;
  fHStmt := OwnerCommand.fHStmt;

  if OwnerCommand.fSupportsBlockRead and fOwnerDbxConnection.fSupportsBlockRead then
    fCursorFetchRowCount := OwnerCommand.fCommandRowSetSize
  else
    fCursorFetchRowCount := 1;

  BindResultSet;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.Create', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSqlCursorOdbc.Destroy;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  i: Integer;
  aOdbcBindCol: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  fOwnerCommand.fStmtFreed := True;
  if fHStmt <> SQL_NULL_HANDLE then
  begin
    OdbcRetcode := SQLCloseCursor(fHStmt);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLCloseCursor');
    OdbcRetcode := SQLFreeStmt(fHStmt, SQL_UNBIND);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLFreeStmt - SQL_UNBIND');
    OdbcRetcode := SQLFreeStmt(fHStmt, SQL_RESET_PARAMS);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLFreeStmt - SQL_RESET_PARAMS');
  end;

  if fCursorErrorLines.Count > 0 then
    // Error lines still pending! Pass to calling connection
    fOwnerDbxConnection.fConnectionErrorLines.Assign(fCursorErrorLines);
  FreeAndNil(fCursorErrorLines);
  if fOdbcBindList <> nil then
  begin
    for i := fOdbcBindList.Count - 1 downto 0 do
    begin
      aOdbcBindCol := TOdbcBindCol(fOdbcBindList[i]);
      fOdbcBindList[i] := nil;
      aOdbcBindCol.Free;
    end;
    FreeAndNil(fOdbcBindList);
  end;

  FreeMemAndNil(fOdbcBindBuffer);
  SetLength(fOdbcRowsStatus, 0);

  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.Destroy', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorOdbc.OdbcCheck(OdbcCode: SqlReturn; const OdbcFunctionName: string);
begin
  fOwnerDbxDriver.OdbcCheck(OdbcCode, OdbcFunctionName, SQL_HANDLE_STMT, fHStmt);
end;

{$IFDEF _TRACE_CALLS_}
function OdbcSqlTypeToStr(OdbcType: Integer; OdbcDriverType: TOdbcDriverType): String;
var
  bFieldHandled: Boolean;
begin
  case OdbcType of
    SQL_INTEGER: Result := 'SQL_INTEGER';
    SQL_BIGINT: Result := 'SQL_BIGINT';
    SQL_SMALLINT: Result := 'SQL_SMALLINT';
    SQL_TINYINT: Result := 'SQL_TINYINT';
    SQL_NUMERIC: Result := 'SQL_NUMERIC';
    SQL_DECIMAL: Result := 'SQL_DECIMAL';
    SQL_DOUBLE: Result := 'SQL_DOUBLE';
    SQL_FLOAT: Result := 'SQL_FLOAT';
    SQL_REAL: Result := 'SQL_REAL';
    SQL_CHAR: Result := 'SQL_CHAR';
    SQL_VARCHAR: Result := 'SQL_VARCHAR';
    SQL_WCHAR: Result := 'SQL_WCHAR';
    SQL_WVARCHAR: Result := 'SQL_WVARCHAR';
    SQL_GUID: Result := 'SQL_GUID';
    SQL_BINARY: Result := 'SQL_BINARY';
    SQL_VARBINARY: Result := 'SQL_VARBINARY';
    SQL_TYPE_DATE: Result := 'SQL_TYPE_DATE';
    SQL_TYPE_TIME: Result := 'SQL_TYPE_TIME';
    SQL_TIME: Result := 'SQL_TIME';
    SQL_TYPE_TIMESTAMP: Result := 'SQL_TYPE_TIMESTAMP';
    SQL_DATETIME: Result := 'SQL_DATETIME';
    SQL_TIMESTAMP: Result := 'SQL_TIMESTAMP';
    SQL_BIT: Result := 'SQL_BIT';
    SQL_LONGVARCHAR: Result := 'SQL_LONGVARCHAR';
    SQL_WLONGVARCHAR: Result := 'SQL_WLONGVARCHAR';
    SQL_LONGVARBINARY: Result := 'SQL_LONGVARBINARY';
    SQL_INTERVAL_YEAR: Result := 'SQL_INTERVAL_YEAR';
    SQL_INTERVAL_MONTH: Result := 'SQL_INTERVAL_MONTH';
    SQL_INTERVAL_DAY: Result := 'SQL_INTERVAL_DAY';
    SQL_INTERVAL_HOUR: Result := 'SQL_INTERVAL_HOUR';
    SQL_INTERVAL_MINUTE: Result := 'SQL_INTERVAL_MINUTE';
    SQL_INTERVAL_SECOND: Result := 'SQL_INTERVAL_SECOND';
    SQL_INTERVAL_YEAR_TO_MONTH: Result := 'SQL_INTERVAL_YEAR_TO_MONTH';
    SQL_INTERVAL_DAY_TO_HOUR: Result := 'SQL_INTERVAL_DAY_TO_HOUR';
    SQL_INTERVAL_DAY_TO_MINUTE: Result := 'SQL_INTERVAL_DAY_TO_MINUTE';
    SQL_INTERVAL_DAY_TO_SECOND: Result := 'SQL_INTERVAL_DAY_TO_SECOND';
    SQL_INTERVAL_HOUR_TO_MINUTE: Result := 'SQL_INTERVAL_HOUR_TO_MINUTE';
    SQL_INTERVAL_HOUR_TO_SECOND: Result := 'SQL_INTERVAL_HOUR_TO_SECOND';
    SQL_INTERVAL_MINUTE_TO_SECOND: Result := 'SQL_INTERVAL_MINUTE_TO_SECOND';
    else
      begin
        bFieldHandled := False;
        if (OdbcDriverType = eOdbcDriverTypeInformix) then
        case OdbcType of
          SQL_INFX_UDT_BLOB:
            begin
              bFieldHandled := True;
              Result := 'SQL_INFX_UDT_BLOB';
            end;
          SQL_INFX_UDT_CLOB:
            begin
              bFieldHandled := True;
              Result := 'SQL_INFX_UDT_CLOB';
            end;
        end;//of: case 2
        if not bFieldHandled then
          Result := 'Unknown';
      end;
  end;//of: case 1
end;
{$ENDIF IFDEF _TRACE_CALLS_}

const
  COLUMN_BIND_SIZE_LIMIT = High(SmallInt)-1;{32767-1}

procedure TSqlCursorOdbc.BindResultSet;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  aOdbcBindCol: TOdbcBindCol;
  ColNo: Integer;
  ColNameTemp: PAnsiChar;
  pCharTemp: PAnsiChar;
  IntAttribute: SqlInteger;
  IntResult: SqlInteger;
  OdbcLateBoundFound: Boolean;
  DefaultFieldName: string;
  LastColNo: Integer;
  bFieldHandled: Boolean;
  vCursorFetchRowCount: Integer;
  vLastHostVarAddress: Pointer;
  vUnbindedColsBuffSize: Integer;
  vUnbindedFirstColIdx: Integer; // first column allocate all buffer
  vBindedColsCnt: Integer;
  aOdbcBindColPrev: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.BindResultSet'); try try {$ENDIF _TRACE_CALLS_}
  ColNameTemp := nil;
  OdbcLateBoundFound := False;
  try
    ColNameTemp := AllocMem(fOwnerDbxConnection.fOdbcMaxColumnNameLen + 1);
    // Get no of columns:
    OdbcRetcode := SQLNumResultCols(fHStmt, fOdbcNumCols);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLNumResultCols');
    // Set up bind columns:
    if (fOdbcBindList <> nil) then
    begin
      for ColNo := fOdbcBindList.Count - 1 downto 0 do
        TOdbcBindCol(fOdbcBindList[ColNo]).Free;
      fOdbcBindList.Free;
    end;
    fOdbcBindList := TList.Create;
    fOdbcBindList.Count := fOdbcNumCols;
    LastColNo := 0;

    // Describe each column...
    for ColNo := 1 to fOdbcNumCols do
    begin
      aOdbcBindCol := TOdbcBindCol.Create;
      fOdbcBindList.Items[LastColNo] := aOdbcBindCol;

      with aOdbcBindCol do
      begin
        fOdbcColNo := ColNo;
        OdbcRetcode := SQLDescribeCol(
          fHStmt, ColNo,
          ColNameTemp, fOwnerDbxConnection.fOdbcMaxColumnNameLen + 1, fColNameSize,
          fSqlType, fColSize, fColScale, fNullable);
        if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
          OdbcCheck(OdbcRetcode, 'SQLDescribeCol');

        // Trim Column Name:
        if (fColNameSize <> 0) then
        begin
          pCharTemp := @ColNameTemp[fColNameSize-1];
          fColName := ColNameTemp;
          while (pCharTemp >= fColName) and (pCharTemp^=' ') do
            dec(pCharTemp);
          fColNameSize := DWORD(pCharTemp)-DWORD(fColName)+1;
        end;

        if (fColNameSize = 0) then
          // Allow for blank column names (returned by Informix stored procedures),
          // blank column names are also returned by functions, eg Max(Col)
          // Added v1.4 2002-01-16, for Bulent Erdemir
          // (Similar fix also posted by Michael Schwarzl)
        begin
          DefaultFieldName := 'Column_' + IntToStr(ColNo);
          fColNameSize := Length(DefaultFieldName);
          fColName := AllocMem(fColNameSize + 1);
          StrLCopy(fColname, PChar(DefaultFieldName), fColNameSize);
        end
        else
        begin
          fColName := AllocMem(fColNameSize + 1);
          StrLCopy(fColName, ColNameTemp, fColNameSize);
        end;
        if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeMsSqlServer) and
           (fSqlType = SQL_MSSQL_VARIANT) // sql_variant: SELECT value FROM "dbo"."sysproperties"
        then
           fSqlType := SQL_BINARY;

        fColValueSizePtr := @fColValueSizeLoc;
        fDbxSubType := 0;
        fIsBuffer:= False;
        {$IFDEF _TRACE_CALLS_}
           LogInfoProc(['Column=', StrPas(fColname), 'OdbcColType=', OdbcSqlTypeToStr(fSqlType, fOwnerDbxConnection.fOdbcDriverType)]);
        {$ENDIF}
        case fSqlType of
          SQL_INTEGER:
            begin
              fDbxType := fldINT32;
              fOdbcHostVarType := SQL_C_LONG;
              fOdbcHostVarSize := SizeOf(SqlInteger);
              // Check to see if field is an AUTO-INCREMENTING value
              OdbcRetcode := SQLColAttributeInt(fHStmt, ColNo, SQL_DESC_AUTO_UNIQUE_VALUE,
                nil, 0, nil, IntAttribute);
              {+2.01}
              // SQLLite does not support this option
              // Old code:
              // if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
              //   OdbcCheck(OdbcRetCode, 'SQLColAttribute(SQL_DESC_AUTO_UNIQUE_VALUE)');
              // if (IntAttribute = SQL_TRUE) then
              //   fDbxSubType:= fldstAUTOINC;
              // New code:
              if (OdbcRetcode = OdbcApi.SQL_SUCCESS) and (IntAttribute = SQL_TRUE) then
                fDbxSubType := fldstAUTOINC;
              {/+2.01}
            end;
          SQL_BIGINT:
            begin
              // DbExpress does not currently support Int64 - use Int32 instead!
              // Re-instate next 3 statements when DbExpress does support int64 }
              {
                fDbxType := fldINT64;
                fOdbcHostVarType := SQL_C_SBIGINT;
                fOdbcHostVarSize := SizeOf(SqlBigInt);
              }
              {+2.01}//Vadim V.Lopushansky:
              // Vadim> ???Vad>All: For supporting int64 remapping it to fldBCD type
              // Edward> This is a good idea.
              // Edward> ???Ed>All: I think it should be the default option,
              // Edward> I think the Borland dbexpress drivers map int64 to BCD
// ???: I still think BCD should be default option - actually, I think we should REMOVE Int32 mapping
              if (fOwnerDbxConnection.fConnectionOptions[coMapInt64ToBcd] = osOff) or
                (fOwnerDbxConnection.fConnectionOptions[coEnableBCD] = osOff) then
              begin
                // Default code:
                fDbxType := fldINT32;
                fOdbcHostVarType := SQL_C_LONG;
                fOdbcHostVarSize := SizeOf(SqlInteger);
              end
              else
              begin
                // Remapping to BCD
                fDbxType := fldBCD;
                fOdbcHostVarType := SQL_C_CHAR; // Odbc prefers to return BCD as string
                fColSize := 18;
                fColScale := 0;
                fOdbcHostVarSize := fColSize + 3;
                // add 3 to number of digits: sign, decimal point, null terminator
              end;
              {/+2.01}
            end;
          SQL_SMALLINT, SQL_TINYINT:
            begin
              fDbxType := fldINT16;
              fOdbcHostVarType := SQL_C_SHORT;
              fOdbcHostVarSize := SizeOf(SqlSmallint);
            end;
          SQL_NUMERIC, SQL_DECIMAL:
            begin
              if (fOwnerDbxConnection.fConnectionOptions[coEnableBCD] = osOff) or
                 (fColSize > MaxFMTBcdDigits) // Not supported more then MaxFMTBcdDigits
              then
              begin
                // Map BCD to Float as in BDE
                fDbxType := fldFLOAT;
                fOdbcHostVarType := SQL_C_DOUBLE;
                fOdbcHostVarSize := SizeOf(SqlDouble);
              end
              else
              if (fOwnerDbxConnection.fConnectionOptions[coMaxBCD] = osOn) then
              begin
                fDbxType := fldBCD;
                fOdbcHostVarType := SQL_C_CHAR; // Odbc prefers to return BCD as string
                if (fColSize - fColScale <= 2) then // fix BCD error info
                  inc(fColSize);
                if (fColScale+fColSize) > MaxFMTBcdDigits then
                  fColScale := MaxFMTBcdDigits - fColSize;
                fColSize := MaxFMTBcdDigits;
                fOdbcHostVarSize := fColSize + 3;
              end
              else
              begin
                if not (fColSize>0) then
                  raise EDbxOdbcError.Create(
                    'ODBC function "SQLDescribeCol" returned Column Size < 1 for SQL_NUMERIC or SQL_DECIMAL' + #13#10
                    + 'Column name=' + StrPas(fColname)
                    + ' Scale=' + IntToStr(fColScale)
                    + ' Size=' + IntToStr(fColSize));
                fDbxType := fldBCD;
                fOdbcHostVarType := SQL_C_CHAR; // Odbc prefers to return BCD as string

                {+2.01 Workaround for bad MERANT driver}
                // Vadim> ???Vad>All: MERANT 2.10 ODBC-OLE DB Adapter Driver: Error: "BCD Everflow" on query:
                // Edward> ???Ed>Vad: Which underlying DBMS were you connecting to with this driver?
                // Edward> I have never heard of this ODBC-OLE DB Adapter driver
                // Edward> only the other way round!
                // Edward> ???Ed>Ed: We sould have another eOdbcDriverType for this driver
                //
                //   select first 1
                //     unit_price
                //   from
                //    stores7:stock
                //
                // Native ODBC:
                // aOdbcBindCol = ('unit_price', 10, 3, 6, 2, 1, 0, 8, 0, 1, 9, ...
                // Merant bad format:
                // aOdbcBindCol = ('unit_price', 10, 3, 6, 4, 1, 0, 8, 0, 1, 9, ...
                //           value: 250.000
                // INOLE
                if (fColSize - fColScale <= 2)
                  // Vadim> ???Vad>All: for any driver?
// Edward> OK. It does no harm to other drivers if ColSize is 1 bigger
// Edward> to allow for this bug in Merant driver.

// and // Detect "MERANT 2.10 ODBC-OLE DB Adapter Driver"
{// ( Pos('INOLE',UpperCase(fOwnerDbxConnection.fOdbcDriverName))=1 )}then
                  inc(fColSize);
                {/+2.01 /Workaround for bad MERANT driver}

                // for 'Open Firebird, Interbase6 ODBC Driver': http://www.xtgsystems.com/
                if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeInterbase) and
                   ( StrLComp(PChar(UpperCase(fOwnerDbxConnection.fOdbcDriverName)),
                     'IB6XTG', 6 ) = 0 )
                then
                  fColSize := fColSize*2 - 1;

                fOdbcHostVarSize := fColSize + 3;
                // add 3 to number of digits: sign, decimal point, null terminator
              {+2.01 Workaround for bad INFORMIX behavior}
              //INFORMIX:
              {
              fColScale mast be less or equal fColSize.
              "INFORMIX 3.32 32 BIT" ODBC Returned fColScale equal 255 in next example:
              1) script tables
              --------------------------------------------------
              create table tbl (custno FLOAT primary key);
              insert into tbl values (1);
              2) exexute next query in DbExpress TSQLQuery:
              --------------------------------------------------
              select custno+1 from tbl;
              --------------------------------------------------
              When executing returned error in SqlExpr.pas:
              "invalid field size."
              It is error in informix metadata.
              Example:
              1) create view v1_tbl (custno) as select custno+1 from tbl
              2) look metadata columns info for view "v1_tbl": custno DECIMAL (17,255).
              It error handled in DataDirect ODBC driver.
              }
              // INFORMIX: Error-checking in the metadata about the datatype of columns in informix

              // Edward> ???Ed>All: Really, this bug should be fixed in Informix DBMS,
              // Edward> not with such ugly hacks in here. But I have kept Vadim's fix.
                if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeInformix)
                  and (fColSize <= 18) and (fColScale = 255) then
                begin
                  fDbxType := fldFLOAT;
                  fOdbcHostVarType := SQL_C_DOUBLE;
                  fOdbcHostVarSize := SizeOf(SqlDouble);
                end;
                {/+2.01 /Workaround for bad INFORMIX behavior}

                // if for any driver fColSize is changed then check of support of such size is necessary:
                if (fColSize > MaxFMTBcdDigits) // Not supported more then MaxFMTBcdDigits
                then
                begin
                  // Map BCD to Float as in BDE
                  fDbxType := fldFLOAT;
                  fOdbcHostVarType := SQL_C_DOUBLE;
                  fOdbcHostVarSize := SizeOf(SqlDouble);
                end;

                if (fColScale > fColSize) then
                  raise EDbxOdbcError.Create(
                    'ODBC function "SQLDescribeCol" returned Column Scale > Column Size' + #13#10
                    + 'Column name=' + StrPas(fColname)
                    + ' Scale=' + IntToStr(fColScale)
                    + ' Size=' + IntToStr(fColSize));
                {+2.01 Option for BCD mapping}
                // Vadim V.Lopushansky:
                // Vadim > ???Vad>All: If BCD is small then remap it to native type:
                // Edward> Nice idea.
                if fOwnerDbxConnection.fConnectionOptions[coMapSmallBcdToNative] = osOn then
                begin
                  if (fColSize <= 4) and (fColScale = 0) then
                  begin
                    fDbxType := fldINT16;
                    fOdbcHostVarType := SQL_C_SHORT;
                    fOdbcHostVarSize := SizeOf(SqlSmallInt);
                  end
                  else if (fColSize <= 9) and (fColScale = 0) then
                  begin
                    fDbxType := fldINT32;
                    fOdbcHostVarType := SQL_C_LONG;
                    fOdbcHostVarSize := SizeOf(SqlInteger);
                  end
                  else if (fColSize <= 10) then
                  begin
                    fDbxType := fldFLOAT;
                    fOdbcHostVarType := SQL_C_DOUBLE;
                    fOdbcHostVarSize := SizeOf(SqlDouble);
                  end
                end;
                {/+2.01 /Option for BCD mapping}
              end;
            end;
          SQL_DOUBLE, SQL_FLOAT, SQL_REAL:
            begin
              fDbxType := fldFLOAT;
              fOdbcHostVarType := SQL_C_DOUBLE;
              fOdbcHostVarSize := SizeOf(SqlDouble);
            end;
          SQL_CHAR, SQL_VARCHAR, SQL_WCHAR, SQL_WVARCHAR, SQL_GUID:
            begin
              fDbxType := fldZSTRING;
              fOdbcHostVarType := SQL_C_CHAR;
              if fColSize<=0 then
                fColSize := 1;
              fOdbcHostVarSize := fColSize + 1; // Add 1 for null terminator
              case fSqlType of
                SQL_CHAR, SQL_WCHAR: // Fixed length field
                  fDbxSubType := fldstFIXED;
              end;
              {+2.03 INFORMIX LVARCHAR}
              { Vadim V.Lopushansky:
                 Fixed when error for mapping INFORMIX LVARCHAR type over native ODBC.
                 Example query: select amparam from sysindices
              }
              if ( (fColSize > 255) and
                 (fOwnerDbxConnection.fConnectionOptions[coMapCharAsBDE] = osOn) )
              then
              begin
                fDbxType := fldBLOB;
                fDbxSubType := fldstMEMO;
              end;
              if {((fOwnerCommand.fCommandBlobSizeLimitK>0) and (fColSize > fOwnerCommand.fCommandBlobSizeLimitK*1024)) or} (fColSize > COLUMN_BIND_SIZE_LIMIT) then
              begin // large size:
                if (fOwnerCommand.fCommandBlobSizeLimitK <= 0) then
                begin
                  fOdbcLateBound := True;
                end
                else
                begin
                  { Vadim>???Vad>All if fColSize > 2 Gb ???
                     Informix native odbc supported fOdbcLateBound, but if not ?
                     DataDirect ODBC for this informix type return length 2048.
                  }
                  // trim column:
                  fColSize := 2048;
                  fOdbcHostVarSize := fColSize + 1;
                end;
              end;
              if fOdbcLateBound then
                fIsBuffer := True;
              if (Self.fOwnerDbxConnection.fDbmsType = eDbmsTypeFlashFiler)and(fColSize=4) then
              begin
                OdbcRetcode := SQLColAttributeInt(fHStmt, ColNo, SQL_DESC_AUTO_UNIQUE_VALUE,
                  nil, 0, nil, IntAttribute);
                if {AutoIncr=} (OdbcRetcode = OdbcApi.SQL_SUCCESS) and (IntAttribute = SQL_TRUE) then
                begin
                  fDbxType := fldINT32;
                  fOdbcHostVarType := SQL_C_LONG;
                  fOdbcHostVarSize := SizeOf(SqlInteger);
                  fDbxSubType := fldstAUTOINC;
                  fIsBuffer := False;
                end;
              end;
              (*

              Field Size is very big (Firebird, IBPhoenix OpenSource ODBC Driver):

                CREATE TABLE ... (
                    ...
                    LANGUAGE_REQ     VARCHAR(15) [1:5] CHARACTER SET NONE
                );

              *)
              if fColSize >= High(Smallint) then
              begin // copy from type SQL_LONGVARCHAR:
                fDbxType := fldBLOB;
                fDbxSubType := fldstMEMO;
                fOdbcHostVarType := SQL_C_CHAR;
                if fOwnerCommand.fCommandBlobSizeLimitK > 0 then
                // If BLOBSIZELIMIT specified, we early bind, just like normal column
                // Otherwise get size and column data AFTER every row fetch, using SqlGetData
                begin
                  fOdbcHostVarSize := fOwnerCommand.fCommandBlobSizeLimitK * 1024;
                end
                else
                if (fOwnerDbxConnection.fOdbcDriverType <> eOdbcDriverTypeSQLLite) then
                begin
                  fOdbcLateBound := True;
                end
                else // SQL LITE:
                begin
                  fOdbcHostVarSize := fColSize+1;
                end;
                if fOdbcLateBound then
                  fIsBuffer := True;
              end;
            end;
          SQL_BINARY, SQL_VARBINARY:
            begin
              if fSqlType = SQL_BINARY then
                fDbxType := fldBYTES
              else
                fDbxType := fldVARBYTES;{ The first word is equal to an length of data }
              fOdbcHostVarType := SQL_C_BINARY;
              if fColSize>0 then
                fOdbcHostVarSize := fColSize
              else
              begin
                if fColSize=0 then fColSize := 1;
                fOdbcHostVarSize := -1;
              end;
              if (fColSize<0)or(fColSize > COLUMN_BIND_SIZE_LIMIT) then
              begin
                if (fOwnerCommand.fCommandBlobSizeLimitK > 0) then
                begin
                  if (fColSize<=0) or
                    (COLUMN_BIND_SIZE_LIMIT > fOwnerCommand.fCommandBlobSizeLimitK * 1024) then
                    // trim data
                    fOdbcHostVarSize := fOwnerCommand.fCommandBlobSizeLimitK * 1024;
                end
                else
                  fOdbcLateBound := True;
              end;
              // check/set buffer allocation status
              if fOdbcLateBound then
                fIsBuffer := True;
            end;
          SQL_TYPE_DATE:
            begin
              fDbxType := fldDATE;
              fOdbcHostVarType := SQL_C_DATE;
              fOdbcHostVarSize := SizeOf(TSqlDateStruct);
            end;
          SQL_TYPE_TIME, SQL_TIME:
            begin
              fDbxType := fldTIME;
              fOdbcHostVarType := SQL_C_TIME;
              fOdbcHostVarSize := SizeOf(TSqlTimeStruct);
            end;
          SQL_TYPE_TIMESTAMP, SQL_DATETIME, SQL_TIMESTAMP:
            begin
              fDbxType := fldDATETIME;
              fOdbcHostVarType := SQL_C_TIMESTAMP;
              fOdbcHostVarSize := SizeOf(TOdbcTimestamp);
            end;
          SQL_BIT:
            begin
              fDbxType := fldBOOL;
              fOdbcHostVarType := SQL_C_BIT;
              fOdbcHostVarSize := SizeOf(SqlByte);
            end;
          SQL_LONGVARCHAR, SQL_WLONGVARCHAR:
            begin
              fDbxType := fldBLOB;
              fDbxSubType := fldstMEMO;
              fOdbcHostVarType := SQL_C_CHAR;
              if fOwnerCommand.fCommandBlobSizeLimitK > 0 then
              // If BLOBSIZELIMIT specified, we early bind, just like normal column
              // Otherwise get size and column data AFTER every row fetch, using SqlGetData
              begin
                fOdbcHostVarSize := fOwnerCommand.fCommandBlobSizeLimitK * 1024;
              end
              else
              if (fOwnerDbxConnection.fOdbcDriverType <> eOdbcDriverTypeSQLLite) then
              begin
                fOdbcLateBound := True;
              end
              else // SQL LITE:
              begin
                fOdbcHostVarSize := fColSize+1;
              end;
              if fOdbcLateBound then
                fIsBuffer := True;
              if fColSize=0 then fColSize := -1;
            end;
          SQL_LONGVARBINARY:
            begin
              fDbxType := fldBLOB;
              fDbxSubType := fldstBINARY;
              fOdbcHostVarType := SQL_C_BINARY;
              // We cannot Bind a BLOB - Determine size AFTER every row fetch
              // We igmore BlobSizeLimit, because binary data (Images etc) cannot normally be truncated
              fOdbcLateBound := True;
              fIsBuffer := True;
              if fColSize=0 then fColSize := -1;
            end;
          SQL_INTERVAL_YEAR..SQL_INTERVAL_MINUTE_TO_SECOND:
            begin
              fDbxType := fldZSTRING;
              fOdbcHostVarType := SQL_C_CHAR;
              fOdbcHostVarSize := 28;
              fDbxSubType := fldstFIXED;
            end;
        else
          begin
            bFieldHandled := False;
            if (fOwnerDbxConnection.fOdbcDriverType = eOdbcDriverTypeInformix) and
               (
                 (fSqlType = SQL_INFX_UDT_BLOB) { INFORMIX BLOB } // fldstHBINARY
                 or
                 (fSqlType = SQL_INFX_UDT_CLOB) { INFORMIX CLOB } // fldstHMEMO
               )
            then
            begin
              fDbxType := fldBLOB;
              fOdbcLateBound := True;
              // set buffer status
              fIsBuffer := True;
              if (fSqlType = SQL_INFX_UDT_BLOB) then
              begin
                fOdbcHostVarType := SQL_C_BINARY;
                fDbxSubType := fldstHBINARY;
              end
              else
              begin
                fOdbcHostVarType := SQL_C_CHAR;
                fDbxSubType := fldstHMEMO;
              end;
              if fColSize=0 then fColSize := -1;
              bFieldHandled := True;
            end;
            if not bFieldHandled then
            begin
              {$IFDEF _TRACE_CALLS_}
                 LogInfoProc(['WARNING: cannot bind column:"', StrPas(fColname), '",  OdbcType=', fSqlType]);
              {$ENDIF}
              {+2.03 IgnoreUnknownFieldType option}
              if (fOwnerDbxConnection.fConnectionOptions[coIgnoreUnknownFieldType] = osOn) and
                (not ((LastColNo = 0) and (ColNo = fOdbcNumCols)))
                {// when in query only one unknown field type}then
              begin
                fOdbcBindList.Items[LastColNo] := nil;
                aOdbcBindCol.Free;
                OdbcLateBoundFound := True; // field may be equal long type
                Continue;
              end
              else
                {/+2.03 /IgnoreUnknownFieldType option}
                raise EDbxOdbcError.Create(
                  'ODBC function "SQLDescribeCol" returned unknown data type' + #13#10 +
                  'Data type code= ' + IntToStr(fSqlType) + #13#10 +
                  'Column name=' + StrPas(fColname));
            end;
          end;
        end; //of: case fSqlType
        Inc(LastColNo);
        // correct fOdbcLateBound
        if fOdbcLateBound then
          OdbcLateBoundFound := True
        else
          if (OdbcLateBoundFound and (not fOwnerDbxConnection.fGetDataAnyColumn)) then
            // Driver does not support early-bound after late-bound columns,
            // and we have already had a late bound column, so we force this
            // column to be late-bound, even though normally it would be early-bound.
            fOdbcLateBound := True;
      end; //of: with aOdbcBindCol
    end; //of: for ColNo := 1 to fOdbcNumCols

    fOdbcBindList.Count := LastColNo;
    fOdbcNumCols := LastColNo;

(*

 Column-Wise Bufer Structure:

 o-----------------------------------------------o    ------------ LateBounds -----------
 |row1: [col1_len][col_1])...([colN_len][col_N]) |  /         ( One row Buffers )         \
 | ...   ...   ...   ...  ...   ...   ...   ...  | |                                       |
 |rowN: [col1_len][col_1])...([colN_len][col_N]) | ([col_A]),([col_D])....|.....BLOBs......|
 |                                               | |                      |       |        |
 o---------------- SqlBindCol() -----------------o o----- SqlGetData() ---o   SqlGetData() |
 |                    \ /                                   \ /           |       \ /
 |                     |                                     |            |        |
 |              Cols-Wise Buffer                       Static  Buffer     |   Dynamic Buffer
 |                                                     ( Small Size )     |   ( Large Size )
 o--------------------------- Common Buffer ------------------------------o

*)

    // Clear Bund buffer info:
    fOdbcBindBufferPos := -1; // = status buffer not fetched
    fOdbcBindBufferRowSize := 0; // unknown buffer size
    // unknown buffer status for simple LateBound columns:
    vUnbindedColsBuffSize := 0;
    vUnbindedFirstColIdx := -1;
    vBindedColsCnt := 0;
    // calculate buffer size for "binded" columns and "unbinded non blobs" columns
    for ColNo := 0 to fOdbcNumCols-1 do
    begin
      aOdbcBindCol := TOdbcBindCol(fOdbcBindList.Items[ColNo]);
      with aOdbcBindCol do
      begin
        if not fOdbcLateBound then
        begin
          inc(vBindedColsCnt);
          inc(fOdbcBindBufferRowSize, fOdbcHostVarSize);
        end
        else
        if not fIsBuffer then
        begin
          inc(vUnbindedColsBuffSize, fOdbcHostVarSize);
          if vUnbindedFirstColIdx<0 then
            vUnbindedFirstColIdx := ColNo;
        end;
      end;
    end;
    fOdbcBindBufferRowSize := fOdbcBindBufferRowSize + vBindedColsCnt*SizeOf(SqlInteger);

    fOdbcLateBoundsFound := OdbcLateBoundFound;

    // Check Parameters and BufferSize memory limitation:
    if (fCursorFetchRowCount>1) then
    begin
      if (OdbcLateBoundFound and (not fOwnerCommand.fSupportsMixedFetch)) or
         (fCursorFetchRowCount < 2)
      then
        fCursorFetchRowCount := 1
      else
      if // set limitatiuon to commonn rows buffer size: ???:
         ( (fOdbcBindBufferRowSize * fCursorFetchRowCount) > 1024*2000{2Mb} )
      then
      begin
        fCursorFetchRowCount := 1024*2000 div fOdbcBindBufferRowSize;
        if fCursorFetchRowCount=0 then
          fCursorFetchRowCount := 1;
      end;
      (*
      if (fCursorFetchRowCount>1) and //(vUnbindedColsBuffSize>0) and
        // optimize fetch method when Binded buffer is very small
        (fOdbcBindBufferRowSize < vUnbindedColsBuffSize)
      then
      begin
        fCursorFetchRowCount := 1;
      end;
      //*)
    end;

    if (fCursorFetchRowCount>1) then
    begin // set array mode fetch:
      // temporary copy fCursorFetchRowCount into vCursorFetchRowCount.
      vCursorFetchRowCount := fCursorFetchRowCount;
      try // <- protected from bad odbc driver
        while vCursorFetchRowCount>1 do
        begin // set ODBC cursor option SQL_ATTR_ROW_ARRAY_SIZE
          // TODO: ???: need check for ODBC 2
          OdbcRetcode := SQLSetStmtAttr(fHStmt, SQL_ATTR_ROW_ARRAY_SIZE,
            SqlPointer(vCursorFetchRowCount), 0);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
          begin
            vCursorFetchRowCount := -1; // (-1) after setting SQL_ATTR_ROW_ARRAY_SIZE
            break;
          end;
          OdbcRetcode := SQLGetStmtAttr(
            fHStmt,
            SQL_ATTR_ROW_ARRAY_SIZE,
            SqlPointer(@IntAttribute),
            SizeOf(SqlInteger),
            IntResult
          );
          if (OdbcRetcode <> OdbcApi.SQL_SUCCESS)or
            (IntAttribute<>vCursorFetchRowCount)
          then
          begin
            vCursorFetchRowCount := -1;
            break;
          end;
          // Column-Wise Binding:
          OdbcRetcode := SQLSetStmtAttr (fHStmt, SQL_ATTR_ROW_BIND_TYPE,
            SQLPOINTER(fOdbcBindBufferRowSize), 0);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
          begin
            vCursorFetchRowCount := -1;
            break;
          end;
          OdbcRetcode := SQLGetStmtAttr(fHStmt, SQL_ATTR_ROW_BIND_TYPE,
            SqlPointer(@IntAttribute), SizeOf(SqlInteger), IntResult );
          if (OdbcRetcode<>OdbcApi.SQL_SUCCESS) or (IntAttribute<>fOdbcBindBufferRowSize) then
          begin
            vCursorFetchRowCount := -1;
            break;
          end;
          SetLength(fOdbcRowsStatus, fCursorFetchRowCount);
          if ( SQLSetStmtAttr(fHStmt, SQL_ATTR_ROW_STATUS_PTR,
               @fOdbcRowsStatus[0], fCursorFetchRowCount*SizeOf(fOdbcRowsStatus[0]) {??? or 0} )
             <> OdbcApi.SQL_SUCCESS ) or
             ( SQLSetStmtAttr(fHStmt, SQL_ATTR_ROWS_FETCHED_PTR, @fOdbcRowsFetched, 0)
             <> OdbcApi.SQL_SUCCESS )
          then
          begin
            SetLength(fOdbcRowsStatus, 0);
            vCursorFetchRowCount := -1;
          end;
          break;
        end;//of: while fCursorFetchRowCount>1
        if vCursorFetchRowCount <= 0 then // is error when applying SQL_ATTR_ROW_ARRAY_SIZE:
        begin // set fetching mode: fetch only one record
          if vCursorFetchRowCount <0 then // cancel multirow fetching option:
          begin
            {OdbcRetcode := }SQLSetStmtAttr (fHStmt, SQL_ATTR_ROW_BIND_TYPE,
              SqlPointer(SQL_BIND_TYPE_DEFAULT{=SQL_BIND_BY_COLUMN}), 0);
            // ???: (0) - uncorrect value for MSSQL only or All ?
            OdbcRetcode := SQLSetStmtAttr(fHStmt, SQL_ATTR_ROW_ARRAY_SIZE, SqlPointer(0), 0);
            if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
            begin
              OdbcRetcode := SQLSetStmtAttr(fHStmt, SQL_ATTR_ROW_ARRAY_SIZE,
                SqlPointer(1), 0);
              if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
                OdbcCheck(OdbcRetcode, 'SQLSetStmtAttr(SQL_ATTR_ROW_ARRAY_SIZE,1)');
            end;
          end;
          fCursorFetchRowCount := 1;
          fOwnerCommand.fCommandRowSetSize := 1;
          fOwnerCommand.fSupportsBlockRead := False;
          fOwnerDbxConnection.fSupportsBlockRead := False;
        end;
      except  // set fetching mode: fetch only one record
        if vCursorFetchRowCount <0 then // cancel multirow fetching option:
        begin
          {OdbcRetcode := }SQLSetStmtAttr (fHStmt, SQL_ATTR_ROW_BIND_TYPE,
            SqlPointer(SQL_BIND_TYPE_DEFAULT{=SQL_BIND_BY_COLUMN}), 0);
          // ???: (0) - uncorrect value for MSSQL only or All ?
          OdbcRetcode := SQLSetStmtAttr(fHStmt, SQL_ATTR_ROW_ARRAY_SIZE, SqlPointer(0), 0);
          if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
          begin
            OdbcRetcode := SQLSetStmtAttr(fHStmt, SQL_ATTR_ROW_ARRAY_SIZE,
              SqlPointer(1), 0);
            if (OdbcRetcode <> OdbcApi.SQL_SUCCESS) then
              OdbcCheck(OdbcRetcode, 'SQLSetStmtAttr(SQL_ATTR_ROW_ARRAY_SIZE,1)');
          end;
        end;
        fCursorFetchRowCount := 1;
        fOwnerCommand.fCommandRowSetSize := 1;
        fOwnerCommand.fSupportsBlockRead := False;
        fOwnerDbxConnection.fSupportsBlockRead := False;
      end;
    end;

    if (fCursorFetchRowCount=1) then
    begin // remove ColSize rows allocation
      if vBindedColsCnt>0 then
        dec(fOdbcBindBufferRowSize, vBindedColsCnt*SizeOf(SqlInteger) );
      if vUnbindedColsBuffSize>0 then
        inc(fOdbcBindBufferRowSize, vUnbindedColsBuffSize);
    end;

    // allocate common buffer memory
      // IntResult = "FETCH ARRAY" Bufer size
    IntResult := fOdbcBindBufferRowSize*fCursorFetchRowCount;
    fOdbcBindBuffer := AllocMem( IntResult + vUnbindedColsBuffSize);

    // base address for cols values
    vLastHostVarAddress := fOdbcBindBuffer;

    if (fCursorFetchRowCount>1) then // start binding addresses and cols
    begin // Column-Wise Binding:
      // bind fOdbcHostVarAddress for unbinded columns:
      if (vUnbindedColsBuffSize>0) then // for "simple LateBound columns":
      begin // Nedd allocate buffer for "simple LateBound columns":
        // common buffer for "simple LateBound columns" is contained in aOdbcBindCol:
        aOdbcBindColPrev := TOdbcBindCol(fOdbcBindList.Items[vUnbindedFirstColIdx]);
        // set buffer first value:
        aOdbcBindColPrev.fOdbcHostVarAddress.Ptr := // seek to last pos of fetch array buffer
          Pointer( DWORD(fOdbcBindBuffer) + DWORD(IntResult) );
        //set buffer HostVarAddresses for "simple LateBound columns":
        for ColNo := vUnbindedFirstColIdx+1 to fOdbcNumCols-1 do
        begin
          aOdbcBindCol := TOdbcBindCol(fOdbcBindList.Items[ColNo]);
          with aOdbcBindCol do
          begin
            if (fOdbcLateBound) and (not fIsBuffer) then
            begin
              fOdbcHostVarAddress.Ptr :=
                Pointer(
                  DWORD(aOdbcBindColPrev.fOdbcHostVarAddress.Ptr) +
                  DWORD(aOdbcBindColPrev.fOdbcHostVarSize)
                );
              aOdbcBindColPrev := aOdbcBindCol;
            end;
          end;
        end;
      end;
      // bind fOdbcHostVarAddress for binded columns:
      for ColNo := 0 to fOdbcNumCols-1 do
      begin
        aOdbcBindCol := TOdbcBindCol(fOdbcBindList.Items[ColNo]);
        with aOdbcBindCol do
        begin
          if (not fOdbcLateBound) then
          begin
            fColValueSizePtr := vLastHostVarAddress;
            inc(DWORD(vLastHostVarAddress), SizeOf(SqlInteger));
            // set fOdbcHostVarAddress to first row value buffer
            fOdbcHostVarAddress.Ptr := vLastHostVarAddress;
            inc(DWORD(vLastHostVarAddress), fOdbcHostVarSize);
            // bind
            OdbcRetcode := SQLBindCol(
              fHStmt, fOdbcColNo, fOdbcHostVarType,
              fOdbcHostVarAddress.Ptr, fOdbcHostVarSize,
              fColValueSizePtr);
            if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
              OdbcCheck(OdbcRetcode, 'SQLBindCol');
          end;//of: if (not fOdbcLateBound)
        end;//of: with aOdbcBindCol do
      end;//of: for ColNo
    end
    else  // one row binding
    begin
      // bind fOdbcHostVarAddress for any non BLOB column:
      for ColNo := 0 to fOdbcNumCols-1 do
      begin
        aOdbcBindCol := TOdbcBindCol(fOdbcBindList.Items[ColNo]);
        with aOdbcBindCol do
        begin
          if (not fIsBuffer) then
          begin
            fOdbcHostVarAddress.Ptr := vLastHostVarAddress;
            inc(DWORD(vLastHostVarAddress), fOdbcHostVarSize);
            if not fOdbcLateBound then
            begin
              OdbcRetcode := SQLBindCol(
                fHStmt, fOdbcColNo, fOdbcHostVarType,
                fOdbcHostVarAddress.Ptr, fOdbcHostVarSize,
                fColValueSizePtr);
              if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
              begin
                if Self.fOwnerDbxConnection.fDbmsType <> eDbmsTypeFlashFiler then
                  OdbcCheck(OdbcRetcode, 'SQLBindCol')
                else
                  fOdbcLateBound := True;
              end;
            end;
          end;//of: if not fOdbcLateBound then
        end;//of: with aOdbcBindCol do
      end;//of: for ColNo
    end;//of: finished binding
  finally
    FreeMem(ColNameTemp);
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.BindResultSet', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.BindResultSet', ['FetchRowCount', fCursorFetchRowCount, 'OdbcLateBoundsFound', fOdbcLateBoundsFound]); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorOdbc.FetchLateBoundData(ColNo: SqlUSmallint);
var
  OdbcRetcode: OdbcApi.SqlReturn;
  aOdbcBindCol: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.FetchLateBoundData', ['ColNo=', ColNo]); try try {$ENDIF _TRACE_CALLS_}
  aOdbcBindCol := TOdbcBindCol(fOdbcBindList[ColNo - 1]);
  with aOdbcBindCol do
  begin
    OdbcRetcode := SQLGetData(
      fHStmt, fOdbcColNo, fOdbcHostVarType,
      fOdbcHostVarAddress.Ptr, fOdbcHostVarSize, fColValueSizePtr);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLGetData("'+StrPas(aOdbcBindCol.fColName)+'")');
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.FetchLateBoundData', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.FetchLateBoundData'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorOdbc.FetchLongData(ColNo: SqlUSmallint);
var
  OdbcRetcode: OdbcApi.SqlReturn;
  aOdbcBindCol: TOdbcBindCol;
  BlobChunkSize: Integer;
  CurrentBlobSize: Integer;
  PreviousBlobSize: Integer;
  CurrentFetchPointer: PChar;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.FetchLongData', ['ColNo=', ColNo]); try try {$ENDIF _TRACE_CALLS_}
  aOdbcBindCol := TOdbcBindCol(fOdbcBindList[ColNo - 1]);
  with aOdbcBindCol do
  begin
    if fBlobFetched then
      exit;

    {+2.01}
    //Vadim V.Lopushansky: optimize BlobChunkSize:
    //old:
    //BlobChunkSize := 256;
    //new:
    if (fOwnerDbxConnection.fBlobChunkSize < 256) or
      (fOwnerDbxConnection.fBlobChunkSize > cBlobChunkSizeLimit) then
      fOwnerDbxConnection.fBlobChunkSize := cBlobChunkSizeDefault;
    BlobChunkSize := fOwnerDbxConnection.fBlobChunkSize;
    if (aOdbcBindCol.fColSize > 256) and (aOdbcBindCol.fColSize < BlobChunkSize) then
      BlobChunkSize := aOdbcBindCol.fColSize;
    {/+2.01}
    PreviousBlobSize := 0;

    if (fOdbcHostVarAddress.Ptr = nil) then
    begin
      if not fIsBuffer then
      begin
        //  fIsBuffer := True; // ???: ERROR in TSqlCursorOdbc.BindResultSet
        raise EDbxInternalError.Create('TSqlCursorOdbc.FetchLongData. Not allocated host variable buffer in TSqlCursorOdbc.BindResultSet');
      end;
      fOdbcHostVarAddress.Ptr := AllocMem(BlobChunkSize);
    end;
    CurrentBlobSize := BlobChunkSize;
    (*
          fldBLOB:
            { fldBLOB subtypes }
              fldstMEMO          = 22;              { Text Memo }
              fldstBINARY        = 23;              { Binary data }
              fldstFMTMEMO       = 24;              { Formatted Text }
              fldstOLEOBJ        = 25;              { OLE object (Paradox) }
              fldstGRAPHIC       = 26;              { Graphics object }
              fldstDBSOLEOBJ     = 27;              { dBASE OLE object }
              fldstTYPEDBINARY   = 28;              { Typed Binary data }
              fldstACCOLEOBJ     = 30;              { Access OLE object }
              fldstHMEMO         = 33;              { CLOB }
              fldstHBINARY       = 34;              { BLOB }
              fldstBFILE         = 36;              { BFILE }
    *)
    case fDbxSubType of
      fldstMEMO, fldstFMTMEMO, fldstHMEMO:
        begin
          {  Code below is very tricky
             Call SQLGetData to get first chunk of the BLOB
             If MORE blob data to get, Odbc returns SQL_SUCCESS_WITH_INFO, SQLSTATE 01004 (String truncated)
             Keep calling SqlGetData for each part of the blob, reallocating more
             memory for the BLOB data on each successive call.
             Odbc always
          }
          OdbcRetcode := SQLGetData(
            fHStmt, fOdbcColNo, SQL_C_CHAR,
            fOdbcHostVarAddress.Ptr, BlobChunkSize, fColValueSizePtr);
          while (OdbcRetcode = SQL_SUCCESS_WITH_INFO) do
          begin
            PreviousBlobSize := CurrentBlobSize;
            Inc(CurrentBlobSize, BlobChunkSize);
            ReallocMem(fOdbcHostVarAddress.Ptr, CurrentBlobSize);
            CurrentFetchPointer := fOdbcHostVarAddress.Ptr;
            CurrentFetchPointer := CurrentFetchPointer + PreviousBlobSize
              - 1; // -1 to overwrite null termination char of previous chunk
            OdbcRetcode := SQLGetData(
              fHStmt, fOdbcColNo, SQL_C_CHAR,
              CurrentFetchPointer,
              BlobChunkSize + 1, // Chunk size is +1 because we overwrite previous null terminator
              fColValueSizePtr);
            if BlobChunkSize*2 <= cBlobChunkSizeLimit then
              BlobChunkSize := BlobChunkSize * 2;
            // Make ChunkSize bigger to avoid too many loop repetiontions
          end;
          {+2.01}
          //Michael Schwarzl
          //-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
          // blob load behavior
          // Michael Schwarzl 31.05.2002
          //-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
          // on SQL-Server connections multiple reading of the blob leads into a error message from ODBC
          // the data has been read correctly at this time and when cursor leaves position next read will
          // be successful. So when returncode is SQL_NO_DATA but data has been loaded (fColValueSize > 0)
          // reset SQL Result Csode
          //-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
          if (fColValueSizePtr^ > 0) and (OdbcRetcode = SQL_NO_DATA) then
            OdbcRetcode := 0;
          //-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
          {/+2.01}
        end;
      fldstBINARY, fldstGRAPHIC, fldstTYPEDBINARY, fldstHBINARY:
        begin
          {  Code for BINARY same as above, except we don't have NULL termination char  }
          OdbcRetcode := SQLGetData(
            fHStmt, fOdbcColNo, SQL_C_BINARY,
            fOdbcHostVarAddress.Ptr, BlobChunkSize, fColValueSizePtr);
          while (OdbcRetcode = SQL_SUCCESS_WITH_INFO) do
          begin
            PreviousBlobSize := CurrentBlobSize;
            Inc(CurrentBlobSize, BlobChunkSize);
            ReallocMem(fOdbcHostVarAddress.Ptr, CurrentBlobSize);
            CurrentFetchPointer := fOdbcHostVarAddress.Ptr;
            CurrentFetchPointer := CurrentFetchPointer + PreviousBlobSize;
            OdbcRetcode := SQLGetData(
              fHStmt, fOdbcColNo, SQL_C_BINARY,
              CurrentFetchPointer,
              BlobChunkSize,
              fColValueSizePtr);
            if BlobChunkSize*2 <= cBlobChunkSizeLimit then
              BlobChunkSize := BlobChunkSize * 2;
            // Make ChunkSize bigger to avoid too many loop repetiontions
          end;
          {+2.01}
          //Michael Schwarzl
          //-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
          // blob load behavior - see above
          // Michael Schwarzl 31.05.2002
          if (OdbcRetcode = SQL_NO_DATA) and (fColValueSizePtr^ > 0) then
            OdbcRetcode := 0;
          //-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
          {/+2.01}
        end;
    else
      raise EDbxInternalError.Create('FetchLongData called for invalid Dbx Sub Type');
    end; //of: case aOdbcBindCol.fDbxSubType

    inc(fColValueSizePtr^, PreviousBlobSize);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLGetData("'+StrPas(aOdbcBindCol.fColName)+'")');
    fBlobFetched := True;
  end; //of: with aOdbcBindCol
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.FetchLongData', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.FetchLongData'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getBcd(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
var
  i: Integer;
  c: Char;
  n: Byte;
  d: Integer;
  Places: Integer;
  DecimalPointFound: Boolean;
  aOdbcBindCol: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getBcd', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  aOdbcBindCol := TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]);
  with aOdbcBindCol{TOdbcBindCol(fOdbcBindList[ColumnNumber - 1])} do
  begin
    if fOdbcLateBound then
      FetchLateBoundData(ColumnNumber);
    IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or
      (fColValueSizePtr^ = OdbcApi.SQL_NO_TOTAL);
    if IsBlank then
      PDWORD(Value)^ := 1 // set to zero BCD
    else
    begin
      // with PBcd(Value)^ do
        // FillChar( Fraction[0], Length(Fraction), 0);
      d := 0; // Number of digits
      PBcd(Value).SignSpecialPlaces := 0; // Sign: 0=+; anything else =-
      DecimalPointFound := False;
      Places := 0;
      i := 0;
      if fOdbcHostVarAddress.ptrAnsiChar[0] = '-' then
      begin
        PBcd(Value).SignSpecialPlaces := $80; // Sign: 0=+; anything else =-
        i := 1;
      end;
      c := fOdbcHostVarAddress.ptrAnsiChar[i];
      while (c <> #0)
        // added memory protected access to Fraction index
        and (d < fColSize{or cMaxBcdCharDigits}) // when usage fColSize then trim uncorrected value
        // check max places size
        and (places<=fColScale) // trim uncorrected value
      do
      begin
        if (c = '.') or (c = ',')
        // ???: or (c = DecimalSeparator ) //Theoretically the divider can be adhered to current in system
        then
          DecimalPointFound := True
        else
        begin
          n := Byte(c) - Byte('0');
          if not odd(d) then
            PBcd(Value).Fraction[d div 2] := n shl 4
          else
            Inc(PBcd(Value).Fraction[d div 2], n); // Array of nibbles
          Inc(d);
          {
          // added memory protected access to Fraction index
          if (d > cMaxBcdCharDigits) then
            raise EDbxOdbcError.Create(
              'BCD Overflow; Bug in ODBC Driver. '+
              'Fetched value length is uncorrected (length is more then '+
                IntToStr(cMaxBcdCharDigits)+' symbols): '+
              '"'+StrPas(fOdbcHostVarAddress.ptrAnsiChar) + '"'
            );
          {}
          if DecimalPointFound then
            Inc(places);
        end;
        Inc(i);
        c := fOdbcHostVarAddress.ptrAnsiChar[i];
      end;
      PBcd(Value).Precision := d; // Number of digits
      (*
      if places > fColScale then
        raise EDbxOdbcError.Create(
          'BCD Overflow; Bug in ODBC Driver. '+
          'Returned uncorrected colunm precision (fColScale='+IntToStr(fColScale)+') '+
          'by SQLDescribeCol for column "'+fColName+'" or Fetched value is uncorrected: "'+
          StrPas(fOdbcHostVarAddress.ptrAnsiChar) + '"'
        );
      if d>fColSize{or cMaxBcdCharDigits} then
        raise EDbxOdbcError.Create(
          'BCD Overflow; Bug in ODBC Driver. '+
          'Returned uncorrected colunm size (fColSize='+IntToStr(fColSize)+') '+
          'by SQLDescribeCol for column "'+fColName+'" or Fetched value is uncorrected: "'+
          StrPas(fOdbcHostVarAddress.ptrAnsiChar) + '"'
        );
      //*)
      Inc(PBcd(Value).SignSpecialPlaces, places);
    end;
    Result := DBXpress.SQL_SUCCESS;
  end; //of: with TOdbcBindCol(fOdbcBindList[ColumnNumber-1])
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getBcd', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getBcd'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getBlob(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool; Length: Longword): SQLResult;
var
  aOdbcBindCol: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getBlob', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  //if Value=nil then
  //begin
  //  Result := DBXERR_INVALIDPARAM;
  //  exit;
  //end;
  try
    aOdbcBindCol := TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]);
    with aOdbcBindCol{TOdbcBindCol(fOdbcBindList[ColumnNumber - 1])} do
    begin

      if fOdbcLateBound then
        FetchLongData(ColumnNumber);

      if (fOwnerDbxConnection.fOdbcDriverType <> eOdbcDriverTypeSQLLite) then
      begin
        IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or
          (fColValueSizePtr^ = OdbcApi.SQL_NO_TOTAL);
        if Assigned(Value) then
        begin
          if IsBlank then
            Pointer(Value^) := nil
          else
          begin
            // Note:
              if fOdbcHostVarAddress.Ptr = nil then
            //    ERROR in TSqlCursorOdbc.BindResultSet
            begin
              //  fIsBuffer := True; // ???: ERROR in TSqlCursorOdbc.BindResultSet
              raise EDbxInternalError.Create('TSqlCursorOdbc.getBlob. Not allocated host variable buffer in TSqlCursorOdbc.BindResultSet');
            end;
            Move(fOdbcHostVarAddress.Ptr^, Value^, Length{fColValueSizePtr^})
          end;
          Result := DBXpress.SQL_SUCCESS;
        end
        else // Workaround bug in TBlobField.GetIsNull
          Result := DBXpress.SQL_SUCCESS;
      end
      else
      begin
        IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or (fColValueSizePtr^ = 0);
        if IsBlank then
          Pointer(Value^) := nil
        else
        begin
          Move(fOdbcHostVarAddress.Ptr^, Value^, Length)
        end;
        Result := DBXpress.SQL_SUCCESS;
      end;
    end;
  except
    on E: Exception{EDbxError} do
    begin
      Pointer(Value^) := nil;
      IsBlank := True;
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getBlob', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getBlob', ['Value=', Pointer(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getBlobSize(ColumnNumber: Word;
  var Length: Longword; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_}
    Length := 0;
    IsBlank := True;
    LogEnterProc('TSqlCursorOdbc.getBlobSize', ['ColumnNumber=', ColumnNumber]);
    Result := SQL_SUCCESS;
    try try
  {$ENDIF _TRACE_CALLS_}
  try
    with TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
    begin

      if (fDbxType <> fldBLOB) then
        raise EDbxInvalidCall.Create(
          'TSqlCursorOdbc.getBlobSize but field is not BLOB - column '
          + IntToStr(ColumnNumber));

      if fOdbcLateBound then
        FetchLongData(ColumnNumber);

      IsBlank :=(fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA);
      if IsBlank then
        Length := 0
      else
      begin
        if (fOwnerDbxConnection.fOdbcDriverType <> eOdbcDriverTypeSQLLite) then
          Length := fColValueSizePtr^
        else
        begin
          Length := StrLen(fOdbcHostVarAddress.ptrAnsiChar)+1;
        end;
      end;

      Result := DBXpress.SQL_SUCCESS;
    end;
  except
    on E: Exception{EDbxError} do
    begin
      Length := 0;
      IsBlank := True;
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getBlobSize', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getBlobSize', ['Length=', Length, 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getBytes(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
var
  aOdbcBindCol: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getBytes', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  aOdbcBindCol := TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]);
  with aOdbcBindCol{TOdbcBindCol(fOdbcBindList[ColumnNumber - 1])} do
  begin

    if fOdbcLateBound then
      FetchLateBoundData(ColumnNumber);

    IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or
      (fColValueSizePtr^ = OdbcApi.SQL_NO_TOTAL);
    if Assigned(Value) then
    begin
      if IsBlank then
        Pointer(Value^) := nil
      else
      begin
        // Note:
        //  if fOdbcHostVarAddress.Ptr = nil then
        //    ERROR in TSqlCursorOdbc.BindResultSet
        // FillChar(PChar(Value)[fColValueSizePtr^+1], fColSize-fColValueSizePtr^, 0);
        if fDbxType = fldVARBYTES then
        begin
          PWord(Value)^ := fColValueSizePtr^;//SizeOf(Word);
          inc( DWORD(Value), SizeOf(Word) );
        end;
        Move(fOdbcHostVarAddress.Ptr^, Value^, fColValueSizePtr^);
      end;
      Result := DBXpress.SQL_SUCCESS;
    end
    else
      Result := DBXpress.DBXERR_INVALIDPARAM;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getBytes', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getBytes', ['Value=', Pointer(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getColumnCount(var pColumns: Word): SQLResult;
begin
  pColumns := fOdbcNumCols;
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorOdbc.getColumnLength(ColumnNumber: Word;
  var pLength: Longword): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getColumnLength', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    with TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
    begin
      case fDbxType of
        fldINT32: { 32 bit signed number }
          pLength := 4;
        fldINT16: { 16 bit signed number }
          pLength := 2;
        fldINT64: { 64 bit signed number }
          pLength := 8;
        fldBCD:
          pLength := (fColSize + 1) div 2 + 2;
        fldFLOAT: { 64 bit floating point }
          pLength := 8;
        fldZSTRING: { Null terminated string }
          pLength := fColSize;
        fldDATE: { Date (32 bit) }
          pLength := 4;
        fldTIME: { Time (32 bit) }
          pLength := 4;
        fldDATETIME:
          pLength := 8;
        fldBOOL:
          pLength := 2;
        fldBYTES,
        fldVARBYTES,
        fldBLOB
        :
          pLength:= fColSize;
      else
        raise EDbxNotSupported.Create
          ('TSqlCursorOdbc.getColumnLength('+IntToStr(ColumnNumber)+') - not supported type "'
          + IntToStr(fDbxType)+'" for column "'+StrPas(fColName)+'".');
      end;
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      pLength := 0; // When Length = 0 then Delphi ignored this field.
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getColumnLength', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getColumnLength', ['pLength=', pLength]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getColumnName(ColumnNumber: Word;
  pColumnName: PChar): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getColumnName', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  StrCopy(pColumnName, TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]).fColName);
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getColumnName', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getColumnName'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getColumnNameLength(ColumnNumber: Word;
  var pLen: Word): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getColumnNameLength', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  pLen := StrLen(TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]).fColName);
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getColumnNameLength', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getColumnNameLength', ['pLen=', pLen]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getColumnPrecision(ColumnNumber: Word;
  var piPrecision: Smallint): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getColumnPrecision', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    with TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
      case fDbxType of
        fldBCD,
        fldBYTES
        :
          piPrecision := fColSize;
        fldZSTRING,
        fldVARBYTES:
          {+2.01}
            //Vadim V.Lopushnasky: Problems with loss of accuracy at type conversion.
          begin
            if fColSize < High(Smallint) then
              piPrecision := fColSize
            else
              piPrecision := High(Smallint);
          end;
        {/+2.01}
      else
        // DBXpress help says "Do not call getColumnPrecision for any other column type."
        // But the donkey SqlExpress calls for EVERY column, so we cannot raise error
        piPrecision := 0;
        // raise EDbxNotSupported.Create(
        //   'TSqlCursorOdbc.getColumnPrecision - not yet supported for data type - column '
        //   + IntToStr(ColumnNumber));
      end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      piPrecision := 0;
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getColumnPrecision', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getColumnPrecision', ['piPrecision=', piPrecision]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getColumnScale(ColumnNumber: Word;
  var piScale: Smallint): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getColumnScale', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    with TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
      case fDbxType of
        fldBCD:
          piScale := fColScale;
      else
        // getColumnScale is should only be called for fldBCD, fldADT, or fldArray
        // But SqlExpress calls it for EVERY column, so we cannot raise error...
        // raise EDbxNotSupported.Create('TSqlCursorOdbc.getColumnScale - not yet supported '+
        //   'for data type - column ' + IntToStr(ColumnNumber));
        piScale := 0;
      end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      piScale := 0;
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getColumnScale', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getColumnScale', ['piScale=', piScale]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getColumnType(ColumnNumber: Word; var puType,
  puSubType: Word): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getColumnType', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  with TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
  begin
    puType := fDbxType;
    puSubType := fDbxSubType;
  end;
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getColumnType', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getColumnType', ['puType=', puType, 'puSubType=', puSubType]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getDate(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getDate', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  with TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
  begin
    if fOdbcLateBound then
      FetchLateBoundData(ColumnNumber);
    IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or
      (fColValueSizePtr^ = OdbcApi.SQL_NO_TOTAL);
    if IsBlank then
      Integer(Value^) := 0
    else
      with fOdbcHostVarAddress.ptrSqlDateStruct^ do
        Integer(Value^) := ((365 * 1900) + 94) + Trunc( EncodeDate(Year, Month, Day) );
    Result := DBXpress.SQL_SUCCESS;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getDate', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getDate'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getDouble(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
//var
//  aOdbcBindCol: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getDouble', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
//  aOdbcBindCol := TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]);
  with {aOdbcBindCol}TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
  begin
    if fOdbcLateBound then
      FetchLateBoundData(ColumnNumber);
    IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or
      (fColValueSizePtr^ = OdbcApi.SQL_NO_TOTAL);
    if IsBlank then
      Double(Value^) := 0
    else
      Double(Value^) := fOdbcHostVarAddress.ptrSqlDouble^;
    Result := DBXpress.SQL_SUCCESS;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getDouble', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getDouble'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getErrorMessage(Error: PChar): SQLResult;
begin
  if Error=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  StrCopy(Error, PChar(fCursorErrorLines.Text));
  fCursorErrorLines.Clear;
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorOdbc.getErrorMessageLen(
  out ErrorLen: Smallint): SQLResult;
begin
  ErrorLen := Length(fCursorErrorLines.Text);
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorOdbc.getLong(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getLong', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  with TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
  begin
    if fOdbcLateBound then
      FetchLateBoundData(ColumnNumber);
    IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or
      (fColValueSizePtr^ = OdbcApi.SQL_NO_TOTAL);
    if IsBlank then
      Integer(Value^) := 0
    else
      Integer(Value^) := fOdbcHostVarAddress.ptrSqlInteger^;
  end;
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getLong', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getLong', ['Value=', Integer(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.GetOption(eOption: TSQLCursorOption;
  PropValue: Pointer; MaxLength: Smallint;
  out Length: Smallint): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.GetOption', ['eOption=', cSQLCursorOption[eOption]]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if PropValue=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    raise EDbxNotSupported.Create('TSqlCursorOdbc.GetOption - not yet supported');
  except
    on E: Exception{EDbxError} do
    begin
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.GetOption', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.GetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getShort(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getShort', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  with TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
  begin
    if fOdbcLateBound then
      FetchLateBoundData(ColumnNumber);
    IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or
      (fColValueSizePtr^ = OdbcApi.SQL_NO_TOTAL);
    if IsBlank then
      Smallint(Value^) := 0
    else
      Smallint(Value^) := fOdbcHostVarAddress.ptrSqlSmallint^;
    Result := DBXpress.SQL_SUCCESS;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getShort', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getShort', ['Value=', Smallint(Value^), IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getString(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;

var
  vLen: Integer;
  RCh: PAnsiChar;
  aOdbcBindCol: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_}
    if Value<>nil then
      PChar(Value)^ := #0;
    IsBlank := True;
    LogEnterProc('TSqlCursorOdbc.getString', ['ColumnNumber=', ColumnNumber]);
    Result := SQL_SUCCESS;
    try try
  {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  aOdbcBindCol := TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]);
  with aOdbcBindCol{}{TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]){} do
  begin
    if fOdbcLateBound then
      FetchLateBoundData(ColumnNumber);
    IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or
      (fColValueSizePtr^ = OdbcApi.SQL_NO_TOTAL);
    if IsBlank then
      PChar(Value)^ := #0
    else
    if (fDbxSubType = fldstFIXED) and fOwnerCommand.fTrimChar then
    begin
      vLen := fColValueSizePtr^;
      if vLen>0 then
      begin
        RCh := PAnsiChar(DWORD(fOdbcHostVarAddress.ptrAnsiChar)+DWORD(vLen-1));
        while (RCh<>fOdbcHostVarAddress.ptrAnsiChar)and(RCh^=' ') do
          dec(RCh);
        vLen := DWORD(RCh-fOdbcHostVarAddress.ptrAnsiChar)+1;
        if vLen>=0 then
          Move(fOdbcHostVarAddress.ptrAnsiChar^, Value^, vLen );
        PChar(Value)[vLen] := #0;
      end
      else
        PChar(Value)^ := #0;
    end
    else
      Move(fOdbcHostVarAddress.ptrAnsiChar^, Value^, fColValueSizePtr^ + 1);
    Result := DBXpress.SQL_SUCCESS;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getString', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getString', ['Value=', PChar(Value), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getTime(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getTime', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  with TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
  begin
    if fOdbcLateBound then
      FetchLateBoundData(ColumnNumber);
    IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or
      (fColValueSizePtr^ = OdbcApi.SQL_NO_TOTAL);
    if IsBlank then
      Longword(Value^) := 0
    else // Returned value is time, in Microseconds
      with fOdbcHostVarAddress.ptrSqlTimeStruct^ do
        Longword(Value^) := ( (Hour * 60 * 60) + (Minute * 60) + Second) * 1000;
    Result := DBXpress.SQL_SUCCESS;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getTime', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getTime'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.getTimeStamp(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.getTimeStamp', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  with TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]) do
  begin
    if fOdbcLateBound then
      FetchLateBoundData(ColumnNumber);
    IsBlank := (fColValueSizePtr^ = OdbcApi.SQL_NULL_DATA) or
      (fColValueSizePtr^ = OdbcApi.SQL_NO_TOTAL);
    if IsBlank then
      FillChar(PSQLTimeStamp(Value)^, SizeOf(TSQLTimeStamp), 0)
    else
    with fOdbcHostVarAddress.ptrOdbcTimestamp^ do
    begin
      PSQLTimeStamp(Value).Year := Year;
      PSQLTimeStamp(Value).Month := Month;
      PSQLTimeStamp(Value).Day := Day;
      PSQLTimeStamp(Value).Hour := Hour;
      PSQLTimeStamp(Value).Minute := Minute;
      PSQLTimeStamp(Value).Second := Second;
      // Odbc returns nanoseconds; DbExpress expects milliseconds; so divide by 1 million
      PSQLTimeStamp(Value).Fractions := Fraction div 1000000;
    end;
  end;
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.getTimeStamp', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.getTimeStamp'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.isAutoIncrement(ColumnNumber: Word;
  var AutoIncr: LongBool): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  IntAttribute: Integer;
  aOdbcBindCol: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.isAutoIncrement', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    aOdbcBindCol := TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]);
    OdbcRetcode := SQLColAttributeInt(fHStmt, aOdbcBindCol.fOdbcColNo, SQL_DESC_AUTO_UNIQUE_VALUE,
      nil, 0, nil, IntAttribute);
    // SQLLite does not support this option
    // Old code:
    //if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    //  OdbcCheck(OdbcRetcode, 'SQLColAttribute');
    //AutoIncr := (IntAttribute = SQL_TRUE);
    // New code:
    AutoIncr := (OdbcRetcode = OdbcApi.SQL_SUCCESS) and (IntAttribute = SQL_TRUE);
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      AutoIncr := (False);
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.isAutoIncrement', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.isAutoIncrement', ['AutoIncr=', Boolean(AutoIncr)]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.isBlobSizeExact(ColumnNumber: Word;
  var IsExact: LongBool): SQLResult;
begin
  // It is not used in "SqlExpr.pas"
  IsExact := True;
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorOdbc.isNullable(ColumnNumber: Word;
  var Nullable: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.isNullable', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  case TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]).fNullable of
    SQL_NULLABLE:
      Nullable := True;
    SQL_NO_NULLS:
      Nullable := False;
  else { SQL_NULLABLE_UNKNOWN: }
    Nullable := True;
  end;
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.isNullable', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.isNullable'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.isReadOnly(ColumnNumber: Word;
  var ReadOnly: LongBool): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  IntAttribute: Integer;
  aOdbcBindCol: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.isReadOnly', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    if Self.fOwnerDbxConnection.fDbmsType = eDbmsTypeFlashFiler then
    begin
      ReadOnly := False;
      Result := DBXpress.SQL_SUCCESS;
      exit;
    end;
    aOdbcBindCol := TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]);
    OdbcRetcode := SQLColAttributeInt(fHStmt, aOdbcBindCol.fOdbcColNo, SQL_DESC_UPDATABLE,
      nil, 0, nil, IntAttribute);
    //if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    //  OdbcCheck(OdbcRetcode, 'SQLColAttribute(SQL_DESC_UPDATABLE)');
    ReadOnly := (OdbcRetcode = OdbcApi.SQL_SUCCESS) and (IntAttribute = SQL_ATTR_READONLY);
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.isReadOnly', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.isReadOnly', ['ReadOnly=', Boolean(ReadOnly)]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.isSearchable(ColumnNumber: Word;
  var Searchable: LongBool): SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  IntAttribute: Integer;
  aOdbcBindCol: TOdbcBindCol;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.isSearchable', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    aOdbcBindCol := TOdbcBindCol(fOdbcBindList[ColumnNumber - 1]);
    OdbcRetcode := SQLColAttributeInt(fHStmt, aOdbcBindCol.fOdbcColNo, SQL_DESC_SEARCHABLE,
      nil, 0, nil, IntAttribute);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLColAttribute(isSearchable)');
    Searchable := (IntAttribute <> SQL_PRED_NONE);
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.isSearchable', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.isSearchable', ['Searchable=', Boolean(Searchable)]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.next: SQLResult;
var
  OdbcRetcode: OdbcApi.SqlReturn;
  i: Integer;
  bSkipFetch: Boolean;
  aOdbcBindCol: TOdbcBindCol;
  vLastHostVarAddress: Pointer;
begin
  {$IFDEF _TRACE_CALLS_}
    if fCursorFetchRowCount>1 then
      LogEnterProc('TSqlCursorOdbc.next',['OdbcBindBufferPos', fOdbcBindBufferPos])
    else
      LogEnterProc('TSqlCursorOdbc.next');
    Result := SQL_SUCCESS;
    try try
  {$ENDIF _TRACE_CALLS_}
  try
    fRowNo := fRowNo + 1;

    //???: TODO: add fRowLimit to Connection Options (as in  BDE: "MAX ROWS")
    //  if (fRowNo > fOwnerDbxConnection.fRowLimit) then
    //    Result := DBXERR_EOF;

    if fCursorFetchRowCount>1 then
    begin
      if fOdbcBindBufferPos>=0 then
      begin
        inc(fOdbcBindBufferPos);
        bSkipFetch := fOdbcBindBufferPos<fCursorFetchRowCount;
        if bSkipFetch then
        begin
          // check buffer pos
          if (fOdbcBindBufferPos >= fOdbcRowsFetched) then
          begin
            {
             Odbc driver can ignore the specified value of quantity of rows in a 'ARRAY BUFFER' and to give any other quantity of rows. It is defined by value in a variable fOdbcRowsFetched.
             For example: 'SAP DB' ODBC Driver, ver: '7.04.03.00' always returns "1".
            }
            // OLD CODE:
            //
            //  Result := DBXERR_EOF;
            //  fOdbcBindBufferPos := -1;
            //  exit;// EOF in Buffer
            //
            // NEW CODE:
            //
            fOdbcBindBufferPos := 0;
            vLastHostVarAddress := fOdbcBindBuffer;
            bSkipFetch := False;
            //
          end
          else
          begin
            // rebase base fetching addresses buffer to next record
            vLastHostVarAddress := Pointer( DWORD(fOdbcBindBuffer) +
              (DWORD(fOdbcBindBufferPos) * DWORD(fOdbcBindBufferRowSize)) );
          end;
        end
        else // buffer pos = last record, need fetched next block
        begin
          // rebase base fetching addresses buffer to first record
          fOdbcBindBufferPos := 0;
          vLastHostVarAddress := fOdbcBindBuffer;
        end;

        // rebase buffer values and size addresses for binded columns
        for i := 0 to fOdbcNumCols-1 do
        begin
          aOdbcBindCol := TOdbcBindCol(fOdbcBindList.Items[i]);
          with aOdbcBindCol do
          begin
            if not fOdbcLateBound then
            begin
              fColValueSizePtr := vLastHostVarAddress;
              inc(DWORD(vLastHostVarAddress), SizeOf(SqlInteger));
              fOdbcHostVarAddress.Ptr := vLastHostVarAddress;
              inc(DWORD(vLastHostVarAddress), fOdbcHostVarSize);
            end;
          end;
        end;

      end
      else  // first call Fetch
      begin
        bSkipFetch := False;
        fOdbcBindBufferPos := 0;
      end;

      if not bSkipFetch then
      begin
        OdbcRetcode := SQLFetch(fHStmt);
        case OdbcRetcode of
          OdbcApi.SQL_SUCCESS:
            begin
              Result := DBXpress.SQL_SUCCESS;
            end;
          OdbcApi.SQL_SUCCESS_WITH_INFO:
            begin
              case fOdbcRowsStatus[fOdbcBindBufferPos] of
                SQL_ROW_SUCCESS:
                  Result := DBXpress.SQL_SUCCESS;
                SQL_ROW_SUCCESS_WITH_INFO:
                  Result := DBXpress.SQL_SUCCESS;
                else
                begin
                  Result := MaxReservedStaticErrors + 1; // Dummy to prevent compiler warning
                  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
                    OdbcCheck(OdbcRetcode, 'SQLFetch(BlockRead)');
                end
              end;
            end;
          OdbcApi.SQL_NO_DATA:
            begin
              Result := DBXERR_EOF;
              fOdbcBindBufferPos := -1;
            end;
          else
            begin
              Result := MaxReservedStaticErrors + 1; // Dummy to prevent compiler warning
              if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
                OdbcCheck(OdbcRetcode, 'SQLFetch(BlockRead)');
            end
        end;//of: case OdbcRetcode.
      end//of:if not bSkipFetch
      else
      begin
        if fOdbcLateBoundsFound then
        begin
          OdbcRetcode := SQLSetPos(fHStmt, fOdbcBindBufferPos+1, SQL_POSITION, SQL_LOCK_NO_CHANGE);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLSetPos(irow='+IntToStr(fOdbcBindBufferPos+1)+')');
        end;
        case fOdbcRowsStatus[fOdbcBindBufferPos] of
          SQL_ROW_SUCCESS:
            Result := DBXpress.SQL_SUCCESS;
          SQL_ROW_SUCCESS_WITH_INFO:
            Result := DBXpress.SQL_SUCCESS;
          else
          begin
            raise EDbxError.Create( 'SQLFetch(BlockRead): Error in fetched buffer for row: '+
              IntToStr(fOdbcBindBufferPos)+'. Row Status: '+
              IntToStr(fOdbcRowsStatus[fOdbcBindBufferPos]) );
          end
        end;
      end;
    end
    else
    begin
      OdbcRetcode := SQLFetch(fHStmt);
      case OdbcRetcode of
        OdbcApi.SQL_SUCCESS:
          Result := DBXpress.SQL_SUCCESS;
        OdbcApi.SQL_SUCCESS_WITH_INFO: // EOdbcWarning raised (warning only)
          Result := DBXpress.SQL_SUCCESS;
        OdbcApi.SQL_NO_DATA:
          Result := DBXERR_EOF
        else
          begin
            Result := MaxReservedStaticErrors + 1; // Dummy to prevent compiler warning
            if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
              OdbcCheck(OdbcRetcode, 'SQLFetch');
          end
      end;//of: case OdbcRetcode.
    end;

    // clear fetched flags & free temporary (BLOBs) buffers
    for i := 0 to fOdbcBindList.Count - 1 do
    begin
      aOdbcBindCol := TOdbcBindCol(fOdbcBindList[i]);
    with aOdbcBindCol{TOdbcBindCol(fOdbcBindList[i])} do
      begin
      fBlobFetched := False;
      if fIsBuffer then // Free Allocated temporary buffer (Next blob value can be NULL).
        FreeMemAndNil( fOdbcHostVarAddress.Ptr );
      end;
    end;
  except
    on E: Exception{EDbxError} do
    begin
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.next', e);  raise; end; end;
    finally
      if fCursorFetchRowCount>1 then
        LogExitProc('TSqlCursorOdbc.next',['OdbcBindBufferPos', fOdbcBindBufferPos])
      else
        LogExitProc('TSqlCursorOdbc.next');
    end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorOdbc.SetOption(eOption: TSQLCursorOption;
  PropValue: Integer): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorOdbc.SetOption', ['eOption=', cSQLCursorOption[eOption], 'PropValue=', PropValue]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxNotSupported.Create('TSqlCursorOdbc.SetOption - not yet supported');
  except
    on E: Exception{EDbxError} do
    begin
      fCursorErrorLines.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorOdbc.SetOption', e);  raise; end; end;
    finally LogExitProc('TSqlCursorOdbc.SetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TSqlCursorMetaData }

constructor TSqlCursorMetaData.Create(
  OwnerSqlMetaData: TSqlMetaDataOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited Create;
  fHStmt := SQL_NULL_HANDLE;
  fSqlCursorErrorMsg := TStringList.Create;
  fOwnerMetaData := OwnerSqlMetaData;
  fSqlConnectionOdbc := fOwnerMetaData.fOwnerDbxConnection;
  fSqlDriverOdbc := fSqlConnectionOdbc.fOwnerDbxDriver
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.Create', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSqlCursorMetaData.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  FreeAndNil(fSqlCursorErrorMsg);
  ClearMetaData;
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.Destroy', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorMetaData.ClearMetaData;
begin
  FreeMemAndNil(fMetaCatalogName);
  FreeMemAndNil(fMetaSchemaName);
  FreeMemAndNil(fMetaTableName);
end;

procedure TSqlCursorMetaData.ParseTableName(TableName: PChar);

{$IFDEF _RegExprParser_}
var
  CatalogName, SchemaName, ObjectName: string;

begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.ParseTableName', ['TableName=', TableName]); try try {$ENDIF _TRACE_CALLS_}
  ClearMetaData;
  if (TableName=nil)or(TableName^=#0) then
    exit;
  fSqlConnectionOdbc.fObjectNameParser.DecodeObjectFullName(
    StrPas(TableName), CatalogName, SchemaName, ObjectName);
  if Length(ObjectName) = 0 then
    exit;
  // OBJECT:
  fMetaTableName := AllocMem(Length(ObjectName) + 1);
  StrLCopy(fMetaTableName, PChar(ObjectName), Length(ObjectName) + 1);
  // SCHEMA:
  if Length(SchemaName) > 0 then
  begin
    fMetaSchemaName := AllocMem(Length(SchemaName) + 1);
    StrLCopy(fMetaSchemaName, PChar(SchemaName), Length(SchemaName) + 1);
  end;
  // CATALOG:
  if Length(CatalogName) > 0 then
  begin
    fMetaCatalogName := AllocMem(Length(CatalogName) + 1);
    StrLCopy(fMetaCatalogName, PChar(CatalogName), Length(CatalogName) + 1);
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.ParseTableName', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.ParseTableName', ['CatalogName=', CatalogName, 'SchemaName=', SchemaName, 'MetaTableName=', fMetaTableName]); end;
  {$ENDIF _TRACE_CALLS_}
end;

{$ELSE}

var
  QuoteChar: AnsiChar;

  procedure DefaultParseTableName(TableName: PChar);
  var
    dot1, dot2: PChar;
    C_start, C_end, S_start, S_end, T_start, T_end: Integer;
  begin
    dot1 := StrPos(TableName, '.');

    C_start := 0;
    C_end := 0;

    S_start := 0;
    S_end := 0;

    T_start := 0;
    T_end := StrLen(TableName) - 1;

    if dot1 <> nil then
    begin
      dot2 := StrPos(dot1 + 1, '.');
      if (dot2 = nil) then
      begin
        S_end := dot1 - TableName - 1;
        T_start := dot1 - TableName + 1;
      end
      else
      begin
        C_end := dot1 - TableName - 1;
        S_start := dot1 - TableName + 1;
        S_end := dot2 - TableName - 1;
        T_start := dot2 - TableName + 1;
      end;
    end;

    if (C_end <> 0) then
    begin
      if (TableName[C_start] = QuoteChar) and (TableName[C_end] = QuoteChar) then
      begin
        Inc(C_start);
        Dec(C_end);
      end;
      fMetaCatalogName := AllocMem(C_end - C_Start + 2);
      StrLCopy(fMetaCatalogName, @TableName[C_start], C_end - C_start + 1);
    end;
    if (S_end <> 0) then
    begin
      if (TableName[S_start] = QuoteChar) and (TableName[S_end] = QuoteChar) then
      begin
        Inc(S_start);
        Dec(S_end);
      end;
      fMetaSchemaName := AllocMem(S_end - S_Start + 2);
      StrLCopy(fMetaSchemaName, @TableName[S_start], S_end - S_start + 1);
    end;

    if (TableName[T_start] = QuoteChar) and (TableName[T_end] = QuoteChar) then
    begin
      Inc(T_start);
      Dec(T_end);
    end;
    fMetaTableName := AllocMem(T_end - T_Start + 2);
    StrLCopy(fMetaTableName, @TableName[T_start], T_end - T_start + 1);
  end;

  procedure InformixParseTableName(TableName: PChar);
  var
    vTable, vStr: string;
    p: Integer;
  begin
    // format:   "catalog:schema:table" or "catalog::schema.table"
    //     catalog = database@server or database
    //     schema  = user
    // example:  dbdemos@infserver1:informix.biolife
    vTable :=
      StringReplace(StrPas(TableName), '::', ':', [rfReplaceAll, rfIgnoreCase]);
    if Length(vTable) = 0 then
      Exit;
    //Catalog:
    p := pos(':', vTable);
    if p > 0 then
    begin
      vStr := Copy(vTable, 1, p - 1);
      if Length(vStr) > 0 then
      begin
        fMetaCatalogName := AllocMem(Length(vStr) + 1);
        StrLCopy(fMetaCatalogName, PChar(vStr), Length(vStr) + 1);
      end;
      vTable := Copy(vTable, p + 1, Length(vTable) - p);
      if Length(vTable) = 0 then
      begin
        ClearMetaData;
        Exit;
      end;
    end;
    //Schema:
    p := pos('.', vTable);
    if p > 0 then
    begin
      vStr := Copy(vTable, 1, p - 1);
      if Length(vStr) > 0 then
      begin
        fMetaSchemaName := AllocMem(Length(vStr) + 1);
        StrLCopy(fMetaSchemaName, PChar(vStr), Length(vStr) + 1);
      end;
      vTable := Copy(vTable, p + 1, Length(vTable) - p);
      if Length(vTable) = 0 then
      begin
        ClearMetaData;
        Exit;
      end;
    end;
    //Table:
    if Length(Trim(vTable)) = 0 then
    begin
      ClearMetaData;
      Exit;
    end;
    fMetaTableName := AllocMem(Length(vTable) + 1);
    StrLCopy(fMetaTableName, PChar(vTable), Length(vTable) + 1);
  end;

begin
  QuoteChar := fSqlConnectionOdbc.fQuoteChar;

  ClearMetaData;

  if (TableName[0] = #0) then
    exit; // nothing

  if fSqlConnectionOdbc.fOdbcDriverType <> eOdbcDriverTypeInformix then
    DefaultParseTableName(TableName)
  else
    InformixParseTableName(TableName);
end;
{$ENDIF} //of: {$ifdef _RegExprParser_}

procedure TSqlCursorMetaData.DescribeAllocBindString(ColumnNo: SqlUSmallint;
  var BindString: PAnsiChar; var BindInd: SqlInteger);

var
  OdbcRetcode: OdbcApi.SqlReturn;
  cbColName: SqlSmallint;
  szColNameTemp: array[0..255] of Char;
  aSqlType: SqlSmallint;
  aScale: SqlSmallint;
  aNullable: SqlSmallint;
  aColSize: SqlUInteger;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.DescribeAllocBindString', ['ColumnNo=', ColumnNo]); try try {$ENDIF _TRACE_CALLS_}
  OdbcRetcode := SQLDescribeCol(
    fHStmt, ColumnNo, szColNameTemp, 255, cbColName,
    aSqlType, aColSize, aScale, aNullable);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLDescribeCol');
  BindString := AllocMem(aColSize + 1);
  OdbcRetcode := SQLBindCol(fHStmt, ColumnNo, SQL_C_CHAR, BindString, aColSize + 1, @BindInd);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLBindCol');
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.DescribeAllocBindString', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.DescribeAllocBindString'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorMetaData.BindSmallint(ColumnNo: SqlUSmallint;
  var BindSmallint: Smallint; PBindInd: PSqlInteger);
var
  OdbcRetcode: OdbcApi.SqlReturn;
  cbColName: SqlSmallint;
  szColNameTemp: array[0..255] of Char;
  aSqlType: SqlSmallint;
  aScale: SqlSmallint;
  aNullable: SqlSmallint;
  aColSize: SqlUInteger;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.BindSmallint', ['ColumnNo=', ColumnNo]); try try {$ENDIF _TRACE_CALLS_}
  OdbcRetcode := SQLDescribeCol(
    fHStmt, ColumnNo, szColNameTemp, 255, cbColName,
    aSqlType, aColSize, aScale, aNullable);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLDescribeCol');

  if (aSqlType <> SQL_C_SHORT) then
    {+2.01}
    //Think SQL:
    // Vadim> ???Vad>All:
    // Edward> I do not have ThinkSQL, but if that's how it works, your fix is OK
    if (fSqlConnectionOdbc.fOdbcDriverType = eOdbcDriverTypeThinkSQL) and
      not (aSqlType in [SQL_INTEGER, SQL_NUMERIC]) then
      {/+2.01}
      raise EDbxInternalError.Create(
        'BindSmallInt called for non SmallInt column no '
        + IntToStr(ColumnNo) + ' - ' + szColNameTemp);
  if (PBindInd = nil) and (aNullable <> OdbcApi.SQL_NO_NULLS) then
    raise EDbxInternalError.Create(
      'BindInteger without indicator var for nullable column '
      + IntToStr(ColumnNo) + ' - ' + szColNameTemp);
  OdbcRetcode := SQLBindCol(
    fHStmt, ColumnNo, SQL_C_SHORT, @BindSmallint, Sizeof(Smallint), PBindInd);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLBindCol');
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.BindSmallint', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.BindSmallint'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorMetaData.BindInteger(ColumnNo: SqlUSmallint;
  var BindInteger: Integer; BindInd: PSqlInteger);
var
  OdbcRetcode: OdbcApi.SqlReturn;
  cbColName: SqlSmallint;
  szColNameTemp: array[0..255] of Char;
  aSqlType: SqlSmallint;
  aScale: SqlSmallint;
  aNullable: SqlSmallint;
  aColSize: SqlUInteger;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.BindInteger', ['ColumnNo=', ColumnNo]); try try {$ENDIF _TRACE_CALLS_}
  OdbcRetcode := SQLDescribeCol(
    fHStmt, ColumnNo, szColNameTemp, 255, cbColName,
    aSqlType, aColSize, aScale, aNullable);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLDescribeCol');

  {+2.01}
  // INFORMIX: SQL_C_SHORT in INFORMIX
  // Edward> This is fine -
  // Edward> ???Ed>Ed: I thought I had already fixed this -
  // ORIGINAL CODE:
  // if (aSqlType <> SQL_C_LONG) then
  // NEW CODE:
  if not (aSqlType in [SQL_C_LONG, SQL_C_SHORT]) then
    {/+2.01}
    raise EDbxInternalError.Create
      ('BindInteger called for non Integer column no '
      + IntToStr(ColumnNo) + ' - ' + szColNameTemp);
  if (BindInd = nil) and (aNullable <> OdbcApi.SQL_NO_NULLS) then
    raise EDbxInternalError.Create
      ('BindInteger without indicator var for nullable column '
      + IntToStr(ColumnNo) + ' - ' + szColNameTemp);
  OdbcRetcode := SQLBindCol(
    fHStmt, ColumnNo, SQL_C_LONG, @BindInteger, Sizeof(Integer), BindInd);
  if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
    OdbcCheck(OdbcRetcode, 'SQLBindCol');
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.BindInteger', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.BindInteger'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getBcd(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getBcd', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getBcd - Unimplemented method invoked on metadata cursor');
  except
    on E: EDbxError do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getBcd', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getBcd'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getBlob(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool; Length: Longword): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getBlob', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getBlob - Unimplemented method invoked on metadata cursor');
  except
    on E: EDbxError do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getBlob', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getBlob'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getBlobSize(ColumnNumber: Word;
  var Length: Longword; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getBlobSize', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getBlobSize - Unimplemented method invoked on metadata cursor');
  except
    on E: EDbxError do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getBlobSize', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getBlobSize'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getBytes(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getBytes', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getBytes - Unimplemented method invoked on metadata cursor');
  except
    on E: EDbxError do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getBytes', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getBytes'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getColumnCount(var pColumns: Word): SQLResult;
begin
  pColumns := fColumnCount;
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorMetaData.getColumnLength(ColumnNumber: Word;
  var pLength: Longword): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getColumnLength', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getColumnLength - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getColumnLength', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getColumnLength'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getColumnName(ColumnNumber: Word;
  pColumnName: PChar): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getColumnName', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  StrCopy(pColumnName, PChar(fColumnNames[ColumnNumber - 1]));
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getColumnName', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getColumnName'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getColumnNameLength(ColumnNumber: Word;
  var pLen: Word): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getColumnNameLength', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  pLen := Length(fColumnNames[ColumnNumber - 1]);
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getColumnNameLength', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getColumnNameLength'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getColumnPrecision(ColumnNumber: Word;
  var piPrecision: Smallint): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getColumnPrecision', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getColumnPrecision - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getColumnPrecision', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getColumnPrecision'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getColumnScale(ColumnNumber: Word;
  var piScale: Smallint): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getColumnScale', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  piScale := 0;
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getColumnScale', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getColumnScale'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getColumnType(ColumnNumber: Word; var puType,
  puSubType: Word): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getColumnType', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  puType := fColumnTypes[ColumnNumber - 1];
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getColumnType', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getColumnType'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getDate(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getDate', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getDate - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getDate', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getDate'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getDouble(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getDouble', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getDouble - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getDouble', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getDouble'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getErrorMessage(Error: PChar): SQLResult;
begin
  if Error=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  StrCopy(Error, PChar(fSqlCursorErrorMsg.Text));
  fSqlCursorErrorMsg.Clear;
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorMetaData.getErrorMessageLen(
  out ErrorLen: Smallint): SQLResult;
begin
  ErrorLen := Length(fSqlCursorErrorMsg.Text);
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorMetaData.getLong(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getLong', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getLong - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getLong', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getLong'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.GetOption(eOption: TSQLCursorOption;
  PropValue: Pointer; MaxLength: Smallint;
  out Length: Smallint): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.GetOption', ['eOption=', cSQLCursorOption[eOption]]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('GetOption - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.GetOption', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.GetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getShort(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getShort', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getShort - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getShort', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getShort'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getString(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getString', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getString - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getString', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getString'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getTime(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getTime', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getTime - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getTime', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getTime'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.getTimeStamp(ColumnNumber: Word;
  Value: Pointer; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.getTimeStamp', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('getTimeStamp - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.getTimeStamp', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.getTimeStamp'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.isAutoIncrement(ColumnNumber: Word;
  var AutoIncr: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.isAutoIncrement', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('isAutoIncrement - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.isAutoIncrement', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.isAutoIncrement'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.isBlobSizeExact(ColumnNumber: Word;
  var IsExact: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.isBlobSizeExact', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('isBlobSizeExact - Unimplemented method invoked on metadata cursor');
  except
    on E: EDbxError do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.isBlobSizeExact', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.isBlobSizeExact'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaData.isNullable(ColumnNumber: Word;
  var Nullable: LongBool): SQLResult;
begin
  Nullable := False;
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorMetaData.isReadOnly(ColumnNumber: Word;
  var ReadOnly: LongBool): SQLResult;
begin
  ReadOnly := True; // Cannot update metadata directly
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorMetaData.isSearchable(ColumnNumber: Word;
  var Searchable: LongBool): SQLResult;

// From DbExpress help:
// "isSearchable indicates whether a specified column represents
// a field that can appear in the WHERE clause of an SQL query."
//
// But with metadata, you do not use a WHERE clause.
// So this is completely inappropriate for metadata
//
// Previously raised an error here
// Now, following suggestion from Dmitry Arefiev, just indicate not searchable

begin
  Searchable := False;
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorMetaData.next: SQLResult;
begin
  Inc(fRowNo);
  Result := DBXpress.SQL_SUCCESS;
end;

function TSqlCursorMetaData.SetOption(eOption: TSQLCursorOption;
  PropValue: Integer): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaData.SetOption', ['eOption=', cSQLCursorOption[eOption], 'PropValue=', PropValue]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    raise EDbxInternalError.Create
      ('SetOption - Unimplemented method invoked on metadata cursor');
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaData.SetOption', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaData.SetOption'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorMetaData.OdbcCheck(OdbcCode: SqlReturn;
  const OdbcFunctionName: string);
begin
  fSqlDriverOdbc.OdbcCheck(OdbcCode, OdbcFunctionName, SQL_HANDLE_STMT, fHStmt);
end;

{ TOdbcBindCol }

constructor TOdbcBindCol.Create;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TOdbcBindCol.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TOdbcBindCol.Create', e);  raise; end; end;
    finally LogExitProc('TOdbcBindCol.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TOdbcBindCol.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TOdbcBindCol.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  FreeMemAndNil(fColName);
  if fIsBuffer and (fOdbcHostVarAddress.Ptr<>nil) then
    FreeMemAndNil(fOdbcHostVarAddress.Ptr);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TOdbcBindCol.Destroy', e);  raise; end; end;
    finally LogExitProc('TOdbcBindCol.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TOdbcBindParam }

constructor TOdbcBindParam.Create;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TOdbcBindParam.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited;
  fOdbcParamSqlType := SQL_UNKNOWN_TYPE;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TOdbcBindParam.Create', e);  raise; end; end;
    finally LogExitProc('TOdbcBindParam.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TOdbcBindParam.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TOdbcBindParam.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  FreeMemAndNil(fBuffer);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TOdbcBindParam.Destroy', e);  raise; end; end;
    finally LogExitProc('TOdbcBindParam.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TMetaTable }

constructor TMetaTable.Create(
  SqlConnectionOdbc: TSqlConnectionOdbc;
  Cat: PAnsiChar;
  Schema: PAnsiChar;
  TableName: PAnsiChar;
  TableType: Integer);

var
  aCatLen: Integer;
  aSchemaLen: Integer;
  aTableLen: Integer;

  WantCatalog: Boolean;
  WantSchema: Boolean;

{$IFDEF _RegExprParser_}
  vCatalogName, vSchemaName, vObjectName: string;
{$ELSE}
  QuoteChar: AnsiChar;
{$ENDIF}
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TMetaTable.Create', ['Cat=', Cat, 'Schema=', Schema, 'TableName=', TableName, 'TableType=', TableType]); try try {$ENDIF _TRACE_CALLS_}
  aCatLen := 0;
{$IFNDEF _RegExprParser_}
  QuoteChar := SqlConnectionOdbc.fQuoteChar;
{$ENDIF}

  if (Cat <> nil) then
  begin
    aCatLen := StrLen(Cat);
    fCat := AllocMem(aCatLen + 1);
    StrCopy(fCat, Cat);
  end;
  aSchemaLen := 0;
  if (Schema <> nil) then
  begin
    aSchemaLen := StrLen(Schema);
    if (aSchemaLen <> 0) then
    begin
      fSchema := AllocMem(aSchemaLen + 1);
      StrCopy(fSchema, Schema);
    end;
  end;

  if TableName<>nil then
  begin
    aTableLen := StrLen(TableName);
    fTableName := AllocMem(aTableLen + 1);
    StrCopy(fTableName, TableName);
  end
  {$IFDEF _RegExprParser_};{$ELSE}
  else
    aTableLen := 0;
  {$ENDIF}

  WantCatalog := True;
  WantSchema := True;

  {  if (TableType = eSQLSynonym) then
      begin
      WantCatalog := False;
      WantSchema := False;
      end; }

  if (aCatLen = 0) or (not SqlConnectionOdbc.fSupportsSchemaDML) then
    WantCatalog := False
  else if (strCompNil(SqlConnectionOdbc.fCurrentCatalog, Cat) = 0) then
    WantCatalog := False;

  if (aSchemaLen = 0) or (not SqlConnectionOdbc.fSupportsSchemaDML) then
    WantSchema := False;

  //INFORMIX: tablename without owner
  if SqlConnectionOdbc.fOdbcDriverType = eOdbcDriverTypeInformix then
  begin // INFORMIX supports operation with the catalog, but usage of this
    WantCatalog := False; // option is inconvenient for the developers and there is no large
    WantSchema := False; // sense  by work with INFORMIX. If you want to work with the catalog,
  end; // comment out this block.

{$IFDEF _RegExprParser_}

  if WantCatalog and Assigned(Cat) then
    vCatalogName := StrPas(Cat)
  else
    SetLength(vCatalogName, 0);

  if WantSchema and Assigned(Schema) then
    vSchemaName := StrPas(Schema)
  else
    SetLength(vSchemaName, 0);

  if Assigned(TableName) then
    vObjectName := StrPas(TableName)
  else
    SetLength(vObjectName, 0);

  // The calculation of a full qualified name:
  vObjectName := SqlConnectionOdbc.fObjectNameParser.EncodeObjectFullName(
    vCatalogName, vSchemaName, vObjectName);

  if Length(vObjectName) > 0 then
  begin
    fQualifiedTableName := AllocMem(Length(vObjectName) + 1);
    StrLCopy(fQualifiedTableName, PChar(vObjectName), Length(vObjectName) + 1);
  end
  else // The conversion was not successful:
    fQualifiedTableName := nil;

{$ELSE}
  if WantCatalog then
    if WantSchema then
    begin
      // 3-part name (Catalog.Schema.Table)
      if SqlConnectionOdbc.fWantQuotedTableName then
      begin
        fQualifiedTableName := AllocMem(aTableLen + aSchemaLen + aCatLen + 3 + 6);
        StrCopy(fQualifiedTableName, PChar(QuoteChar + string(Cat) + QuoteChar
          + '.' + QuoteChar + string(Schema) + QuoteChar
          + '.' + QuoteChar + string(TableName) + QuoteChar));
      end
      else
      begin
        fQualifiedTableName := AllocMem(aTableLen + aSchemaLen + aCatLen + 3);
        StrCopy(fQualifiedTableName, PChar(string(Cat) + '.' + string(Schema) + '.' +
          string(TableName)));
      end
    end
    else
    begin
      // 3-part name, but schema omitted (Catalog..Schema)
      if SqlConnectionOdbc.fWantQuotedTableName then
      begin
        fQualifiedTableName := AllocMem(aTableLen + aCatLen + 3 + 4);
        StrCopy(fQualifiedTableName, PChar(QuoteChar + string(Cat) + QuoteChar +
          '..' + QuoteChar + string(TableName) + QuoteChar));
      end
      else
      begin
        fQualifiedTableName := AllocMem(aTableLen + aCatLen + 3);
        StrCopy(fQualifiedTableName, PChar(string(Cat) + '..' + string(TableName)));
      end;
    end
  else { if not WantCatalog }  if WantSchema then
  begin
    // 2-part name (Schema.Table)
    if SqlConnectionOdbc.fWantQuotedTableName then
    begin
      fQualifiedTableName := AllocMem(aTableLen + aSchemaLen + 2 + 4);
      StrCopy(fQualifiedTableName, PChar(QuoteChar + string(Schema) + QuoteChar
        + '.' + QuoteChar + string(TableName) + QuoteChar));
    end
    else
    begin
      fQualifiedTableName := AllocMem(aTableLen + aSchemaLen + 2);
      StrCopy(fQualifiedTableName, PChar(string(Schema) + '.' + string(TableName)));
    end;
  end
  else
  begin
    // 1-part name (Table only)
    if SqlConnectionOdbc.fWantQuotedTableName then
    begin
      fQualifiedTableName := AllocMem(aTableLen + 1 + 2);
      StrCopy(fQualifiedTableName, PChar(QuoteChar + string(TableName) + QuoteChar));
    end
    else
    begin
      fQualifiedTableName := AllocMem(aTableLen + 1);
      StrCopy(fQualifiedTableName, TableName);
    end;
  end;
{$ENDIF}
  fTableType := TableType;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TMetaTable.Create', e);  raise; end; end;
    finally LogExitProc('TMetaTable.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TMetaTable.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TMetaTable.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  FreeMemAndNil(fCat);
  FreeMemAndNil(fSchema);
  FreeMemAndNil(fTableName);
  FreeMemAndNil(fQualifiedTableName);
  FreeAndNil(fIndexColumnList);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TMetaTable.Destroy', e);  raise; end; end;
    finally LogExitProc('TMetaTable.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TMetaColumn }

constructor TMetaColumn.Create(
  ColumnName: PAnsiChar;
  OrdinalPosition: Smallint;
  TypeName: PAnsiChar);
var
  aLen: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TMetaColumn.Create', ['ColumnName=', ColumnName, 'OrdinalPosition=', OrdinalPosition, 'TypeName=', TypeName]); try try {$ENDIF _TRACE_CALLS_}
  aLen := StrLen(ColumnName);
  fColumnName := AllocMem(aLen + 1);
  StrCopy(fColumnName, ColumnName);

  aLen := StrLen(TypeName);
  fTypeName := AllocMem(aLen + 1);
  StrCopy(fTypeName, TypeName);

  fOrdinalPosition := OrdinalPosition;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TMetaColumn.Create', e);  raise; end; end;
    finally LogExitProc('TMetaColumn.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TMetaColumn.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TMetaColumn.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  FreeMemAndNil(fColumnName);
  FreeMemAndNil(fTypeName);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TMetaColumn.Destroy', e);  raise; end; end;
    finally LogExitProc('TMetaColumn.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TMetaIndexColumn }

constructor TMetaIndexColumn.Create(MetaTable: TMetaTable; IndexName, IndexColumnName:
  PAnsiChar);
var
  aLen: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TMetaIndexColumn.Create', ['MetaTable=', MetaTable, 'IndexName=', IndexName, 'IndexColumnName=', IndexColumnName]); try try {$ENDIF _TRACE_CALLS_}
  fMetaTable := MetaTable;

  aLen := StrLen(IndexName);
  fIndexName := AllocMem(aLen + 1);
  StrCopy(fIndexName, IndexName);

  aLen := StrLen(IndexColumnName);
  fIndexColumnName := AllocMem(aLen + 1);
  StrCopy(fIndexColumnName, IndexColumnName);
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TMetaIndexColumn.Create', e);  raise; end; end;
    finally LogExitProc('TMetaIndexColumn.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TMetaIndexColumn.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TMetaIndexColumn.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  FreeMemAndNil(fIndexName);
  FreeMemAndNil(fIndexColumnName);
  FreeMemAndNil(fFilter);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TMetaIndexColumn.Destroy', e);  raise; end; end;
    finally LogExitProc('TMetaIndexColumn.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TMetaProcedure }

constructor TMetaProcedure.Create(Cat, Schema, ProcName: PAnsiChar;
  ProcType: Integer);
var
  aLen: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TMetaProcedure.Create', ['CAt=', Cat, 'Schema=', Schema, 'ProcName=', ProcName, 'ProcType=', ProcType]); try try {$ENDIF _TRACE_CALLS_}
  if (Cat <> nil) then
  begin
    aLen := StrLen(Cat);
    fCat := AllocMem(aLen + 1);
    {+2.01}
    if Assigned(Cat) then
      StrCopy(fCat, Cat)
    else
      StrCopy(fCat, #0);
    {/+2.01}
  end;
  if (Schema <> nil) then
  begin
    aLen := StrLen(Schema);
    fSchema := AllocMem(aLen + 1);
    StrCopy(fSchema, Schema);
  end;
  aLen := StrLen(ProcName);
  fProcName := AllocMem(aLen + 1);
  StrCopy(fProcName, ProcName);
  fProcType := ProcType;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TMetaProcedure.Create', e);  raise; end; end;
    finally LogExitProc('TMetaProcedure.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TMetaProcedure.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TMetaProcedure.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  FreeMemAndNil(fCat);
  FreeMemAndNil(fSchema);
  FreeMemAndNil(fProcName);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TMetaProcedure.Destroy', e);  raise; end; end;
    finally LogExitProc('TMetaProcedure.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TMetaProcedureParam }

constructor TMetaProcedureParam.Create(ParamName: PAnsiChar);
var
  aLen: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TMetaProcedureParam.Create', ['ParamName=', ParamName]); try try {$ENDIF _TRACE_CALLS_}
  aLen := StrLen(ParamName);
  fParamName := AllocMem(aLen + 1);
  StrCopy(fParamName, ParamName);
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TMetaProcedureParam.Create', e);  raise; end; end;
    finally LogExitProc('TMetaProcedureParam.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TMetaProcedureParam.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TMetaProcedureParam.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  FreeMemAndNil(fParamName);
  FreeMemAndNil(fDataTypeName);
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TMetaProcedureParam.Destroy', e);  raise; end; end;
    finally LogExitProc('TMetaProcedureParam.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TSqlCursorTables }
{
 Dbx returned cursor columns
  1. RECNO         fldINT32
       A record number that uniquely identifies each record.
  2. CATALOG_NAME  fldZSTRING
       The name of the catalog (database) that contains the table.
  3. SCHEMA_NAME   fldZSTRING
       The name of the schema that identifies the owner of the table.
  4. TABLE_NAME    fldZSTRING
       The name of the table.
  5. TABLE_TYPE    fldINT32
       An eSQLTableType value (C++) or table type constant (Object Pascal)
       that indicates the type of table.

 ODBC Result set columns
  1. TABLE_CAT     Varchar
       Catalog name; NULL if not applicable to the data source
  2. TABLE_SCHEM   Varchar
       Schema name; NULL if not applicable to the data source.
  3. TABLE_NAME    Varchar
       Table name
  4. TABLE_TYPE    Varchar
       Table type name eg TABLE, VIEW, SYNONYM, ALIAS etc
  5. REMARKS       Varchar
       A description of the table
}

const
  TableColumnNames: array[1..5] of string =
  ('RECNO', 'CATALOG_NAME', 'SCHEMA_NAME', 'TABLE_NAME', 'TABLE_TYPE');
  TableColumnTypes: array[1..5] of Word =
  (fldINT32, fldZSTRING, fldZSTRING, fldZSTRING, fldINT32);
  TableColumnCount = Length(TableColumnNames);

constructor TSqlCursorMetaDataTables.Create(
  OwnerMetaData: TSQLMetaDataOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataTables.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited Create(OwnerMetaData);

  fColumnCount := TableColumnCount;
  fColumnNames := @TableColumnNames;
  fColumnTypes := @TableColumnTypes;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataTables.Create', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataTables.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSqlCursorMetaDataTables.Destroy;
var
  i: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataTables.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  if Assigned(fTableList) then
  begin
    for i := fTableList.Count - 1 downto 0 do
      TMetaTable(fTableList[i]).Free;
    FreeAndNil(fTableList);
  end;
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataTables.Destroy', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataTables.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorMetaDataTables.FetchTables(
  SearchTableName: PChar;
  SearchTableType: Longword);

var
  OdbcRetcode: OdbcApi.SqlReturn;
  TableTypes: string;
  sTableTypes: PChar;

  Cat: PAnsiChar;
  Schema: PAnsiChar;
  TableName: PAnsiChar;
  OdbcTableType: PAnsiChar;
  DbxTableType: Integer;

  cbCat: SqlInteger;
  cbSchema: SqlInteger;
  cbTableName: SqlInteger;
  cbOdbcTableType: SqlInteger;

  aMetaTable: TMetaTable;
  i: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataTables.FetchTables', ['SearchTableName=', SearchTableName, 'SearchTableType=', SearchTableType]); try try {$ENDIF _TRACE_CALLS_}
  Cat := nil;
  Schema := nil;
  TableName := nil;
  OdbcTableType := nil;

  try
    fSqlConnectionOdbc.AllocHStmt(fHStmt);

    TableTypes := '';
    if (SearchTableType and eSQLTable) <> 0 then
      TableTypes := 'TABLE, ';
    if (SearchTableType and eSQLView) <> 0 then
      TableTypes := TableTypes + 'VIEW, ';
    if (SearchTableType and eSQLSystemTable) <> 0 then
      TableTypes := TableTypes + 'SYSTEM TABLE, ';
    if (SearchTableType and eSQLSynonym) <> 0 then
      TableTypes := TableTypes + 'SYNONYM, ';
    if (SearchTableType and eSQLTempTable) <> 0 then
      TableTypes := TableTypes + 'GLOBAL TEMPORARY, ';
    if (SearchTableType and eSQLLocal) <> 0 then
      TableTypes := TableTypes + 'LOCAL TEMPORARY, ';
    if TableTypes = '' then
      sTableTypes := nil
    else
    begin
      TableTypes := Copy(TableTypes, 1, Length(TableTypes) - 2); // remove trailing comma
      sTableTypes := PAnsiChar(TableTypes);
    end;

    fSqlConnectionOdbc.GetCurrentCatalog;

    {+2.01 Metadata CurrentSchema Filter}
    // Vadim V.Lopushansky: Set Metadata CurrentSchema Filter
    // Edward> ???Ed>Vad: ODBC V3 certainly has the capability to support this,
    // Edward> but I don't think any DbExpress application would ever want it.
    // Edward> ???Ed>All:
    // Edward> This is much more tricky than it looks at first.
    // Edward> ODBC V2 and V3 specifications differ in their behavior here,
    // Edward> and different databases also behave differently.
    // Edward> Also, there is a particular problem if the real Schema name might
    // Edward> contain underscore character, which just happens to be the ODBC
    // Edward> wildcard character. In this case you should use an escape character,
    // Edward> but dbexpress cannot easily handle this,
    // Edward> The consistent handling of other metadata objects also needs to
    // Edward> be considered, and this requires investigation and careful thought.
    // Edward> As far as I remember, dbExpress "specificiation" (ha ha) is
    // Edward> inconsistent/unclear between the various metadata querying interfaces,
    // Edward> and it is not easily compatible with the ODBC specification (for
    // Edward> example, ODBC specification allows the catalog to be specified, but
    // Edward> dbexpress does not.
    // Edward> Really this is getting too complicated, and my feeling it is best
    // Edward> just to leave it out. But I have kept Vadim's code for now.
    if (fSqlConnectionOdbc.fConnectionOptions[coSupportsSchemaFilter] = osOn) and
      (Length(fSqlConnectionOdbc.fCurrentSchema) > 0) and
      ((SearchTableType and eSQLSystemTable) = 0) then
    begin
      OdbcRetcode := SQLTables(fHStmt,
        nil, 0, // all catalogs
        PChar(fSqlConnectionOdbc.fCurrentSchema), Length(fSqlConnectionOdbc.fCurrentSchema),
        // all schemas
        SearchTableName, SQL_NTS, // Table name match pattern
        sTableTypes, SQL_NTS); // Table types
    end
    else
      {/+2.01 /Metadata CurrentSchema Filter}
      OdbcRetcode := SQLTables(fHStmt,
        nil, 0, // all catalogs
        nil, 0, // all schemas
        SearchTableName, SQL_NTS, // Table name match pattern
        sTableTypes, SQL_NTS); // Table types

    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLTables');

    if fSqlConnectionOdbc.fSupportsCatalog then
      DescribeAllocBindString(1, Cat, cbCat);
    DescribeAllocBindString(2, Schema, cbSchema);
    DescribeAllocBindString(3, TableName, cbTableName);
    DescribeAllocBindString(4, OdbcTableType, cbOdbcTableType);

    fTableList := TList.Create;

    OdbcRetcode := SQLFetch(fHStmt);

    while (OdbcRetcode <> ODBCapi.SQL_NO_DATA) do
    begin
      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLFetch');

      if (OdbcTableType = 'TABLE') then
        DbxTableType := eSQLTable
      else if (OdbcTableType = 'VIEW') then
        DbxTableType := eSQLView
      else if (OdbcTableType = 'SYNONYM') or
        (OdbcTableType = 'ALIAS') then
        // in IBM DB2, Alias is evivalent to Synonym
        DbxTableType := eSQLSynonym
      else if (OdbcTableType = 'SYSTEM TABLE') then
        DbxTableType := eSQLSystemTable
      else if (OdbcTableType = 'GLOBAL TEMPORARY') then
        DbxTableType := eSQLTempTable
      else if (OdbcTableType = 'LOCAL TEMPORARY') then
        DbxTableType := eSQLLocal
      else
        // Database-specific table type - assume its a table
        DbxTableType := eSQLTable;

      aMetaTable := TMetaTable.Create(fSqlConnectionOdbc, Cat, Schema, TableName, DbxTableType);
      if Assigned(aMetaTable.fQualifiedTableName) then // If the conversion was successful:
        fTableList.Add(aMetaTable)
      else
        aMetaTable.Free;

      OdbcRetcode := SQLFetch(fHStmt);
    end;

    fCatLenMax := 0;
    fSchemaLenMax := 0;
    fQualifiedTableLenMax := 1;

    for i := 0 to fTableList.Count - 1 do
    begin
      aMetaTable := TMetaTable(fTableList.Items[i]);

      if Assigned(aMetaTable.fCat) then
        MaxSet(fCatLenMax, StrLen(aMetaTable.fCat));

      if Assigned(aMetaTable.fSchema) then
        MaxSet(fSchemaLenMax, StrLen(aMetaTable.fSchema));

      if Assigned(aMetaTable.fQualifiedTableName) then
        MaxSet(fQualifiedTableLenMax, StrLen(aMetaTable.fQualifiedTableName));
    end;

  finally
    FreeMem(Cat);
    FreeMem(Schema);
    FreeMem(TableName);
    FreeMem(OdbcTableType);

    if fHStmt <> SQL_NULL_HANDLE then
      fSqlConnectionOdbc.FreeHStmt(fHStmt);
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataTables.FetchTables', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataTables.FetchTables'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataTables.getColumnLength(ColumnNumber: Word;
  var pLength: Longword): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataTables.getColumnLength', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case ColumnNumber of
      1: // RECNO
        pLength := SizeOf(Integer);
      2: // CATALOG_NAME
        pLength := fCatLenMax;
      3: // SCHEMA_NAME
        pLength := fSchemaLenMax;
      4: // TABLE_NAME
        pLength := fQualifiedTableLenMax;
      5: // TABLE_TYPE
        pLength := SizeOf(Integer);
    else
      begin
        pLength := 0;
        raise EDbxInvalidCall.Create(
          'TSqlCursorMetaDataTables.getColumnLength invalid column no: '
          + IntToStr(ColumnNumber));
      end;
    end;
    {+2.01}
    // Vadim V.Lopushansky:
    // If length is equal 0 that Delphi will ignore this column.
    // It is bad, since the column describes the metadata.
    if (pLength = 0) and (TableColumnTypes[ColumnNumber] = fldZSTRING) then
      pLength := 1;
    {/+2.01}
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataTables.getColumnLength', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataTables.getColumnLength', ['pLength=', pLength]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataTables.getColumnPrecision(ColumnNumber: Word;
  var piPrecision: Smallint): SQLResult;
var
  Length: Longword;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataTables.getColumnPrecision', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Result := getColumnLength(ColumnNumber, Length);
  piPrecision := Length;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataTables.getColumnPrecision', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataTables.getColumnPrecision', ['piPrecision=', piPrecision]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataTables.getLong(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataTables.getLong', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case ColumnNumber of
      1: // RECNO
        begin
          Integer(Value^) := fRowNo;
          IsBlank := False;
        end;
      5: // TABLE_TYPE
        begin
          Integer(Value^) := fMetaTableCurrent.fTableType;
          IsBlank := False;
        end;
    else
      begin
        Integer(Value^) := 0;
        raise EDbxInvalidCall.Create(
          'TSqlCursorMetaDataTables.getLong not valid for column '
          + IntToStr(ColumnNumber));
      end;
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataTables.getLong', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataTables.getLong', ['Value=', Integer(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataTables.getString(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_}
    if Value<>nil then PChar(Value)^ := #0;
    IsBlank := True;
    LogEnterProc('TSqlCursorMetaDataTables.getString', ['ColumnNumber=', ColumnNumber]);
    Result := SQL_SUCCESS;
    try try
  {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case ColumnNumber of
      2: // CATALOG_NAME
        begin
          if (fMetaTableCurrent.fCat = nil) then
          begin
            PChar(Value)^ := #0;
            IsBlank := True;
          end
          else
          begin
            StrCopy(Value, PChar(fMetaTableCurrent.fCat));
            IsBlank := False;
          end;
        end;
      3: // SCHEMA_NAME
        begin
          if (fMetaTableCurrent.fSchema = nil) then
          begin
            PChar(Value)^ := #0;
            IsBlank := True;
          end
          else
          begin
            StrCopy(Value, PChar(fMetaTableCurrent.fSchema));
            IsBlank := False;
          end;
        end;
      4: // TABLE_NAME
        begin
          StrCopy(Value, PChar(fMetaTableCurrent.fQualifiedTableName));
          IsBlank := False;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataTables.getString not valid for column '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      PChar(Value)^ := #0;
      IsBlank := True;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataTables.getString', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataTables.getString', ['Value=', PChar(Value), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataTables.next: SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataTables.next'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Inc(fRowNo);
  {+2.01}
  if (fTableList = nil) or
    (fRowNo > fTableList.Count) then
    {/+2.01}
  begin
    Result := DBXERR_EOF;
    exit;
  end;
  fMetaTableCurrent := fTableList[fRowNo - 1];
  Result := DBXpress.SQL_SUCCESS;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataTables.next', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataTables.next'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TSqlCursorColumns }

{
1.  RECNO            fldINT32
      A record number that uniquely identifies each record.
2.  CATALOG_NAME     fldZSTRING
      The name of the catalog (database) that contains the table.
3.  SCHEMA_NAME      fldZSTRING
      The name of the schema that identifies the owner of the table.
4.  TABLE_NAME       fldZSTRING
      The name of the table in which the column appears.
5.  COLUMN_NAME      fldZSTRING
      The name of the field (column).
6.  COLUMN_POSITION  fldINT16
      The position of the column in its table.
7.  COLUMN_TYPE      fldINT32
      An eSQLColType value (C++) or column type constant (Object Pascal)
      that indicates the type of field.
8.  COLUMN_DATATYPE  fldINT16
      The logical data type for the field.
9.  COLUMN_TYPENAME  fldZSTRING
      A string describing the datatype.
      This is the same information as contained in COLUMN_DATATYPE
      and COLUMN_SUBTYPE, but in a form used in some DDL statements.
10. COLUMN_SUBTYPE   fldINT16
      The logical data subtype for the field.
11. COLUMN_PRECISION fldINT32
      The size of the field type (number of characters in a string, bytes in a
      bytes field, significant digits in a BCD value, members of an ADT field, and so on)
12. COLUMN_SCALE     fldINT16
      The number of digits to the right of the decimal on BCD values,
      or descendants on ADT and array fields.
13. COLUMN_LENGTH    fldINT32
      The number of bytes required to store field values.
14. COLUMN_NULLABLE  fldINT16
      If the field requires a value, nonzero if it can be blank.

ODBC result set columns
1.  TABLE_CAT         Varchar
      Catalog name; NULL if not applicable to the data source
2.  TABLE_SCHEM       Varchar
      Schema name; NULL if not applicable to the data source.
3.  TABLE_NAME        Varchar
      Table name
4.  COLUMN_NAME       Varchar not NULL
      Column name. Empty string for a column that does not have a name
5.  DATA_TYPE         Smallint not NULL
      SQL data type
6.  TYPE_NAME         Varchar not NULL
      Data source ñ dependent data type name
7.  COLUMN_SIZE       Integer
     Column Size
     If DATA_TYPE is SQL_CHAR or SQL_VARCHAR, then this column contains the
     maximum length in characters of the column
     For datetime data types, this is the total number of characters required
     to display the value when converted to characters.
     For numeric data types, this is either the total number of digits or the total
     number of bits allowed in the column, according to the NUM_PREC_RADIX column
8.  BUFFER_LENGTH     Integer
      The length in bytes of data transferred on SqlFetch etc if SQL_C_DEFAULT is specified
9.  DECIMAL_DIGITS    Smallint
      The total number of significant digits to the right of the decimal point
10. NUM_PREC_RADIX    Smallint
      For numeric data types, either 10 or 2.
11. NULLABLE          Smallint not NULL
      SQL_NO_NULLS / SQL_NULLABLE / SQL_NULLABLE_UNKNOWN
12. REMARKS           Varchar
      A description of the column
13. COLUMN_DEF        Varchar
      The default value of the column
14. SQL_DATA_TYPE     Smallint not NULL
     SQL data type,
     This column is the same as the DATA_TYPE column, with the exception of
     datetime and interval data types.
     This column returns the nonconcise data type (such as SQL_DATETIME or SQL_INTERVAL),
     rather than the concise data type (such as SQL_TYPE_DATE or SQL_INTERVAL_YEAR_TO_MONTH)
15. SQL_DATETIME_SUB  Smallint
      The subtype code for datetime and interval data types.
      For other data types, this column returns a NULL.
16. CHAR_OCTET_LENGTH Integer
      The maximum length in bytes of a Character or binary data type column.
17. ORDINAL_POSITION  Integer not NULL
      The ordinal position of the column in the table
18. IS_NULLABLE       Varchar
      'NO' if the column does not include NULLs
      'YES' if the column could include NULLs
      zero-length string if nullability is unknown.
}
const
  ColumnColumnNames: array[1..14] of string =
  ('RECNO', 'CATALOG_NAME', 'SCHEMA_NAME', 'TABLE_NAME', 'COLUMN_NAME',
    'COLUMN_POSITION', 'COLUMN_TYPE', 'COLUMN_DATATYPE', 'COLUMN_TYPENAME', 'COLUMN_SUBTYPE',
    'COLUMN_PRECISION', 'COLUMN_SCALE', 'COLUMN_LENGTH', 'COLUMN_NULLABLE');
  ColumnColumnTypes: array[1..14] of Word =
  (fldINT32, fldZSTRING, fldZSTRING, fldZSTRING, fldZSTRING,
    fldINT16, fldINT32, fldINT16, fldZSTRING, fldINT16,
    fldINT32, fldINT16, fldINT32, fldINT16);
  ColumnColumnCount = Length(ColumnColumnNames);

constructor TSqlCursorMetaDataColumns.Create(
  OwnerMetaData: TSQLMetaDataOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataColumns.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited Create(OwnerMetaData);
  fColumnCount := ColumnColumnCount;
  fColumnNames := @ColumnColumnNames;
  fColumnTypes := @ColumnColumnTypes;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataColumns.Create', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataColumns.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSqlCursorMetaDataColumns.Destroy;
var
  i: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataColumns.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  if Assigned(fTableList) then
  begin
    for i := fTableList.Count - 1 downto 0 do
      TMetaTable(fTableList[i]).Free;
    FreeAndNil(fTableList);
  end;
  if Assigned(fColumnList) then
  begin
    for i := fColumnList.Count - 1 downto 0 do
      TMetaColumn(fColumnList[i]).Free;
    FreeAndNil(fColumnList);
  end;
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataColumns.Destroy', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataColumns.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorMetaDataColumns.FetchColumns(
  SearchTableName,
  SearchColumnName: PChar;
  SearchColType: Longword);
var
  OdbcRetcode: OdbcApi.SqlReturn;
  Cat: PAnsiChar;
  Schema: PAnsiChar;
  TableName: PAnsiChar;
  ColumnName: PAnsiChar;
  TypeName: PAnsiChar;
  DefaultValue: PAnsiChar;
  OrdinalPosition: Integer;
  OdbcDataType: Smallint;
  Nullable: Smallint;
  OdbcColumnSize: Integer;
  DecimalScale: Smallint;
  OdbcRadix: Smallint;
  OdbcColumnBufferLength: Integer;

  cbCat: Integer;
  cbSchema: Integer;
  cbTableName: Integer;
  cbColumnName: Integer;
  cbTypeName: Integer;
  cbDefaultValue: Integer;
  cbDecimalScale: Integer; // allow for NULL values
  cbOdbcDataType: Integer;
  cbOdbcColumnSize: Integer;
  cbOdbcRadix: Integer;
  cbNullable: Integer;
  cbOrdinalPosition: Integer;
  cbOdbcColumnBufferLength: Integer;

  i: Integer;
  aMetaTable: TMetaTable;
  aMetaColumn: TMetaColumn;
  bTableFound: Boolean;

begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataColumns.FetchColumns', ['SearchTableName=', SearchTableName, 'SearchColumnName=', SearchColumnName, 'SearchColType=', SearchColType]); try try {$ENDIF _TRACE_CALLS_}
  Cat := nil;
  Schema := nil;
  TableName := nil;
  ColumnName := nil;
  TypeName := nil;
  DefaultValue := nil;

  try
    fSqlConnectionOdbc.AllocHStmt(fHStmt);
    ParseTableName(SearchTableName);

    if (SearchColumnName <> nil) then
      if (SearchColumnName[0] = #0) then
        SearchColumnName := nil;
    OdbcRetcode := SQLColumns(fHStmt,
      fMetaCatalogName, SQL_NTS, // Catalog
      fMetaSchemaName, SQL_NTS, // Schema
      fMetaTableName, SQL_NTS, // Table name match pattern
      SearchColumnName, SQL_NTS); // Column name match pattern

    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLColumns');

    if fSqlConnectionOdbc.fSupportsCatalog then
      DescribeAllocBindString(1, Cat, cbCat);
    if (fSqlConnectionOdbc.fOdbcMaxSchemaNameLen > 0) then
      DescribeAllocBindString(2, Schema, cbSchema);
    DescribeAllocBindString(3, TableName, cbTableName);
    DescribeAllocBindString(4, ColumnName, cbColumnName);
    BindSmallint(5, OdbcDataType, @cbOdbcDataType);
    DescribeAllocBindString(6, TypeName, cbTypeName);
    BindInteger(7, OdbcColumnSize, @cbOdbcColumnSize);
    BindInteger(8, OdbcColumnBufferLength, @cbOdbcColumnBufferLength);
    BindSmallint(9, DecimalScale, @cbDecimalScale);
    BindSmallint(10, OdbcRadix, @cbOdbcRadix);
    BindSmallint(11, Nullable, @cbNullable);
    // Level 2 Drivers do not support Oridinal Position
    if (fSqlConnectionOdbc.fOdbcDriverLevel = 2) then
    begin
      OrdinalPosition := 0;
      cbDefaultValue := OdbcAPi.SQL_NULL_DATA;
    end
    else
    begin
      {+2.01}
      //Vadim V.Lopushansky:
      // Automatically assign fOdbcDriverLevel mode to 2 when exception
      try
        DescribeAllocBindString(13, DefaultValue, cbDefaultValue);
        BindInteger(17, OrdinalPosition, @cbOrdinalPosition);
      except
        fSqlConnectionOdbc.fOdbcDriverLevel := 2;
        // Initialize as Level 2
        OrdinalPosition := 0;
        cbDefaultValue := OdbcAPi.SQL_NULL_DATA;
      end;
      {/+2.01}
    end;
    fTableList := TList.Create;
    fColumnList := TList.Create;

    OdbcRetcode := SQLFetch(fHStmt);

    while (OdbcRetcode <> ODBCapi.SQL_NO_DATA) do
    begin

      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLFetch');
      {+2.01}
      //Vadim V.Lopushansky:
      // The code for drivers which not supporting filter
      // (Easysoft IB6 ODBC Driver [ver:1.00.01.67] contain its error).
      // Edward> ???Ed>Vad/All: I think column name filter is a bad idea (see long
      // Edward> comment under TSqlCursorMetaDataTables.FetchTables).
      // Edward> ???Ed>Ed: I think the filter should also be removed from my code above.
      // Edward> But I have kept it all for now.
      if Assigned(SearchColumnName) then
        i := StrLen(SearchColumnName)
      else
        i := 0;
      if (i > 0) and ((i <> Integer(StrLen(ColumnName))) or
        (StrLComp(SearchColumnName, ColumnName, i) <> 0)) then
      begin
        OdbcRetcode := SQLFetch(fHStmt);
        continue;
      end;
      {/+2.01}

      bTableFound := False;
      aMetaTable := nil; // suppress compiler warning
      for i := 0 to fTableList.Count - 1 do
      begin
        aMetaTable := fTableList.Items[i];
        if (strCompNil(aMetaTable.fCat, Cat) = 0) and
          (strCompNil(aMetaTable.fSchema, Schema) = 0) and
          (strCompNil(aMetaTable.fTableName, TableName) = 0) then
        begin
          bTableFound := True;
          break;
        end;
      end;
      if not bTableFound then
      begin
        aMetaTable := TMetaTable.Create(fSqlConnectionOdbc, Cat, Schema, TableName, eSQLTable);
        fTableList.Add(aMetaTable);
      end;

      aMetaColumn := TMetaColumn.Create(ColumnName, OrdinalPosition, TypeName);
      fColumnList.Add(aMetaColumn);
      aMetaColumn.fMetaTable := aMetaTable;
      if (cbOdbcColumnBufferLength = OdbcAPi.SQL_NULL_DATA) then
        aMetaColumn.fLength := Low(Integer) // this indicates null data
      else
        aMetaColumn.fLength := OdbcColumnBufferLength;

      if cbDecimalScale = OdbcAPi.SQL_NULL_DATA then
        aMetaColumn.fDecimalScale := Low(Smallint) // this indicates null data
      else
        aMetaColumn.fDecimalScale := DecimalScale;
      if cbOdbcColumnSize = OdbcAPi.SQL_NULL_DATA then
        aMetaColumn.fPrecision := Low(Smallint) // this indicates null data
      else
      begin
        if (cbOdbcRadix <> OdbcAPi.SQL_NULL_DATA) and (OdbcRadix = 2) then
          // if RADIX = 2, Odbc column size is number of BITs;
          // Decimal Digits is log10(2) * BITS = 0.30103 * No of BITS
          aMetaColumn.fPrecision := ((OdbcColumnSize * 3) div 10) + 1
        else
          aMetaColumn.fPrecision := OdbcColumnSize
      end;

      case Nullable of
        SQL_NULLABLE:
          aMetaColumn.fDbxNullable := 1; // it can be null
        SQL_NO_NULLS:
          aMetaColumn.fDbxNullable := 0; // null not allowed
      else { SQL_NULLABLE_UNKNOWN: }
        aMetaColumn.fDbxNullable := 1; // Odbc doesn't know - assume it might contain nulls
      end;

      OdbcDataTypeToDbxType(OdbcDataType, aMetaColumn.fDbxType, aMetaColumn.fDbxSubType, fSqlConnectionOdbc);
      if aMetaColumn.fDbxType = fldUNKNOWN then
      begin
        if (fSqlConnectionOdbc.fConnectionOptions[coIgnoreUnknownFieldType] = osOn) then
        begin
          // remove unknown field from list
          fColumnList.Remove(aMetaColumn);
          FreeAndNil(aMetaColumn);
          // fetch next field
          OdbcRetcode := SQLFetch(fHStmt);
          if (OdbcRetcode <> OdbcApi.SQL_SUCCESS)and(OdbcRetcode <> ODBCapi.SQL_NO_DATA) then
            OdbcCheck(OdbcRetcode, 'SQLFetch');
          continue;
        end
        else
          raise EDbxInternalError.Create('Unsupported ODBC data type ' + IntToStr(OdbcDataType)+
            ' for column: ' + ColumnName);
      end;
      {+2.01}
      // Vadim> ???Vad>All: OpenLink Lite for Informix 7 (32 Bit) ODBC Driver:
      // (aMetaColumn.fDbxType = 3 = BLOB )
      // Edward> I do not have Informix, I do not know
      // Vadim> Problems with loss of accuracy at type conversion.
      if aMetaColumn.fPrecision > High(Smallint) then
      begin
        aMetaColumn.fPrecision := -1;
        // Edward> ???Ed>Vad/All: This does not look right!
        // Edward> But I do not understand exactly what you are trying to do
        if aMetaColumn.fLength > High(Smallint) then
          aMetaColumn.fLength := High(Integer);
      end;
      {/+2.01}

      { Dbx Column type is combination of following flags
      eSQLRowId         Row Id number.
      eSQLRowVersion    Version number.
      eSQLAutoIncr      Auto-incrementing field (server generates value).
      eSQLDefault       Field with a default value. (server can generate value)

      eSQLRowId      - This can be determined by Odbc call SQLSpecialColumns SQL_BEST_ROWID
      eSQLRowVersion - This can be determined by Odbc call SQLSpecialColumns SQL_ROWVER
      eSQLAutoIncr   - Odbc does not have facility to determine this until actual Result set
      eSQLDefault    - Odbc will return the defaulkt value
      }
      if (cbDefaultValue <> OdbcAPi.SQL_NULL_DATA) then
        aMetaColumn.fDbxColumnType := aMetaColumn.fDbxColumnType + eSQLDefault;
      OdbcRetcode := SQLFetch(fHStmt);
    end; //of: while (OdbcRetCode <> ODBCapi.SQL_NO_DATA)

    OdbcRetcode := SQLCloseCursor(fHStmt);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLCloseCursor');
    OdbcRetcode := SQLFreeStmt(fHStmt, SQL_UNBIND);
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLFreeStmt - SQL_UNBIND');

    // Next block of code to determine eSQLRowId and eSQLRowVersion
    {// But there's no point, DbExpress does not use this information

    // This is to determine eSQLRowId
    OdbcRetCode := SQLSpecialColumns(fhStmt,
      SQL_BEST_ROWID,
      fMetaCatalogName, SQL_NTS, // Catalog
      fMetaSchemaName, SQL_NTS, // Schema
      fMetaTableName, SQL_NTS, // Table name match pattern
      SQL_SCOPE_TRANSACTION, // Minimum required scope of the rowid
      SQL_NULLABLE); // Return even if column can be null
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'SQLSpecialColumns');

    DescribeAllocBindString(2, ColumnName, cbColumnName);
    BindSmallInt(3, OdbcDataType, @cbOdbcDataType);
    DescribeAllocBindString(4, TypeName, cbTypeName);
    BindInteger(5, OdbcColumnSize, @cbOdbcColumnSize);

    OdbcRetCode := SQLFetch(fhStmt);

    while (OdbcRetCode <> ODBCapi.SQL_NO_DATA) do
    begin
      if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetCode, 'SQLFetch');
      for i := 0 to fColumnList.Count - 1 do
      begin
        aMetaColumn := TMetaColumn(fColumnList.Items[i]);
        if StrComp(aMetaColumn.fColumnName, ColumnName) = 0 then
          aMetaColumn.fDbxColumnType := aMetaColumn.fDbxColumnType + eSQLRowId;
      end;
      OdbcRetCode := SQLFetch(fhStmt);
    end;

    OdbcRetCode := SQLCloseCursor(fhStmt);
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'SQLCloseCursor');
    OdbcRetCode := SQLFreeStmt (fhStmt, SQL_UNBIND);
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'SQLFreeStmt - SQL_UNBIND');

    // This is to determine eSQLRowVersion
    OdbcRetCode := SQLSpecialColumns(fhStmt,
      SQL_ROWVER,
      fMetaCatalogName, SQL_NTS, // Catalog
      fMetaSchemaName, SQL_NTS, // Schema
      fMetaTableName, SQL_NTS, // Table name match pattern
      0, // Does not apply to SQL_ROWVER
      SQL_NULLABLE); // Return even if column can be null
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'SQLSpecialColumns');

    DescribeAllocBindString(2, ColumnName, cbColumnName);
    BindSmallInt(3, OdbcDataType, @cbOdbcDataType);
    DescribeAllocBindString(4, TypeName, cbTypeName);
    BindInteger(5, OdbcColumnSize, @cbOdbcColumnSize);

    OdbcRetCode := SQLFetch(fhStmt);

    while (OdbcRetCode <> ODBCapi.SQL_NO_DATA) do
    begin
      if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetCode, 'SQLFetch');
      for i := 0 to fColumnList.Count - 1 do
      begin
        aMetaColumn := TMetaColumn(fColumnList.Items[i]);
        if StrComp(aMetaColumn.fColumnName, ColumnName) = 0 then
          aMetaColumn.fDbxColumnType := aMetaColumn.fDbxColumnType + eSQLRowVersion;
      end;
      OdbcRetCode := SQLFetch(fhStmt);
    end;

    OdbcRetCode := SQLCloseCursor(fhStmt);
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'SQLCloseCursor');
    OdbcRetCode := SQLFreeStmt (fhStmt, SQL_UNBIND);
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'SQLFreeStmt - SQL_UNBIND');
    {}

    fCatLenMax := 0;
    fSchemaLenMax := 0;
    fTableLenMax := 1;
    fColumnLenMax := 1;

    for i := 0 to fTableList.Count - 1 do
    begin
      aMetaTable := TMetaTable(fTableList.Items[i]);

      if Assigned(aMetaTable.fCat) then
        MaxSet(fCatLenMax, StrLen(aMetaTable.fCat));

      if Assigned(aMetaTable.fSchema) then
        MaxSet(fSchemaLenMax, StrLen(aMetaTable.fSchema));

      if Assigned(aMetaTable.fTableName) then
        MaxSet(fTableLenMax, StrLen(aMetaTable.fTableName));
    end;

    for i := 0 to fColumnList.Count - 1 do
    begin
      aMetaColumn := TMetaColumn(fColumnList.Items[i]);

      if Assigned(aMetaColumn.fColumnName) then
        MaxSet(fColumnLenMax, StrLen(aMetaColumn.fColumnName));

      if Assigned(aMetaColumn.fTypeName) then
        MaxSet(fTypeNameLenMax, StrLen(aMetaColumn.fTypeName));
    end;

  finally
    FreeMem(Cat);
    FreeMem(Schema);
    FreeMem(TableName);
    FreeMem(ColumnName);
    FreeMem(TypeName);
    FreeMem(DefaultValue);

    if (fHStmt <> SQL_NULL_HANDLE) then
      fSqlConnectionOdbc.FreeHStmt(fHStmt);
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataColumns.FetchColumns', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataColumns.FetchColumns'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataColumns.getColumnLength(ColumnNumber: Word;
  var pLength: Longword): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataColumns.getColumnLength', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case ColumnNumber of
      1: // RECNO
        pLength := SizeOf(Integer);
      2: // CATALOG_NAME
        pLength := fCatLenMax;
      3: // SCHEMA_NAME
        pLength := fSchemaLenMax;
      4: // TABLE_NAME
        pLength := fTableLenMax;
      5: // COLUMN_NAME
        pLength := fColumnLenMax;
      6: // COLUMN_POSITION   fldINT16
        pLength := SizeOf(Smallint);
      7: // COLUMN_TYPE       fldINT32
        pLength := SizeOf(Longint);
      8: // COLUMN_DATATYPE   fldINT16
        pLength := SizeOf(Smallint);
      9: // COLUMN_TYPENAME
        pLength := fTypeNameLenMax;
      10: // COLUMN_SUBTYPE   fldINT16
        pLength := SizeOf(Smallint);
      11: // COLUMN_PRECISION fldINT32
        pLength := SizeOf(Longint);
      12: // COLUMN_SCALE     fldINT16
        pLength := SizeOf(Smallint);
      13: // COLUMN_LENGTH    fldINT32
        pLength := SizeOf(Longint);
      14: // COLUMN_NULLABLE  fldINT16
        pLength := SizeOf(Smallint);
    else
    begin
      pLength := 0;
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataColumns.getColumnLength invalid column no: '
        + IntToStr(ColumnNumber));
    end;
    end; //of: case ColumnNumber
    {+2.01}
    // Vadim V.Lopushansky:
    // If length is equal 0 that Delphi will ignore this column.
    // It is bad, since the column describes the metadata.
    if (pLength = 0) and (ColumnColumnTypes[ColumnNumber] = fldZSTRING) then
      pLength := 1;
    {/+2.01}
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      pLength := 0;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataColumns.getColumnLength', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataColumns.getColumnLength', ['pLength=', pLength]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataColumns.getColumnPrecision(ColumnNumber: Word;
  var piPrecision: Smallint): SQLResult;
var
  Length: Longword;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataColumns.getColumnPrecision', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Result := getColumnLength(ColumnNumber, Length);
  {+2.01}
  //Vadim V.Lopushansky:
  // Problems with loss of accuracy at type conversion
  // Edward> I assume this is correct
  if Length < Longword(High(Smallint)) then
    piPrecision := Length
  else
    piPrecision := -1;
  {/+2.01}
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataColumns.getColumnPrecision', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataColumns.getColumnPrecision', ['piPrecision=', piPrecision]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataColumns.getLong(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataColumns.getLong', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case ColumnNumber of
      1: // RECNO
        begin
          IsBlank := False;
          Integer(Value^) := fRowNo;
        end;
      7: // COLUMN_TYPE      fldINT32
        begin
          IsBlank := False;
          Integer(Value^) := fMetaColumnCurrent.fDbxColumnType
        end;
      11: // COLUMN_PRECISION  fldINT32
        begin
          if fMetaColumnCurrent.fPrecision = low(Integer) then
          begin
            IsBlank := True;
            Integer(Value^) := 0;
          end
          else
          begin
            IsBlank := False;
            Integer(Value^) := fMetaColumnCurrent.fPrecision;
          end;
        end;
      13: // COLUMN_LENGTH    fldINT32
        begin
          if fMetaColumnCurrent.fLength = low(Integer) then
          begin
            IsBlank := True;
            Integer(Value^) := 0;
          end
          else
          begin
            IsBlank := False;
            Integer(Value^) := fMetaColumnCurrent.fLength;
          end;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataColumns.getLong not valid for column '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      Integer(Value^) := 0;
      IsBlank := True;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataColumns.getLong', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataColumns.getLong', ['Value=', Integer(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataColumns.getShort(ColumnNumber: Word;
  Value: Pointer; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataColumns.getShort', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case ColumnNumber of
      6: // COLUMN_POSITION    fldINT16
        begin
          IsBlank := False;
          Smallint(Value^) := fMetaColumnCurrent.fOrdinalPosition;
        end;
      8: // COLUMN_DATATYPE  fldINT16
        begin
          IsBlank := False;
          Smallint(Value^) := fMetaColumnCurrent.fDbxType;
        end;
      10: // COLUMN_SUBTYPE   fldINT16
        begin
          IsBlank := False;
          Smallint(Value^) := fMetaColumnCurrent.fDbxSubType;
        end;
      12: // COLUMN_SCALE     fldINT16
        begin
          if fMetaColumnCurrent.fDecimalScale = low(Smallint) then
          begin
            IsBlank := True;
            Smallint(Value^) := 0;
          end
          else
          begin
            IsBlank := False;
            Smallint(Value^) := fMetaColumnCurrent.fDecimalScale;
          end;
        end;
      14: // COLUMN_NULLABLE  fldINT16
        begin
          IsBlank := False;
          Smallint(Value^) := fMetaColumnCurrent.fDbxNullable;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataColumns.getShort not valid for column '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      IsBlank := True;
      Smallint(Value^) := 0;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataColumns.getShort', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataColumns.getShort', ['Value=', Smallint(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataColumns.getString(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_}
    if Value<>nil then PChar(Value)^ := #0;
    IsBlank := True;
    LogEnterProc('TSqlCursorMetaDataColumns.getString', ['ColumnNumber=', ColumnNumber]);
    Result := SQL_SUCCESS;
    try try
  {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case ColumnNumber of
      2: // CATALOG_NAME
        begin
          if (fMetaTableCurrent.fCat = nil) then
          begin
            PChar(Value)^ := #0;
            IsBlank := True;
          end
          else
          begin
            StrCopy(Value, PChar(fMetaTableCurrent.fCat));
            IsBlank := False;
          end;
        end;
      3: // SCHEMA_NAME
        begin
          if (fMetaTableCurrent.fSchema = nil) then
          begin
            PChar(Value)^ := #0;
            IsBlank := True;
          end
          else
          begin
            StrCopy(Value, PChar(fMetaTableCurrent.fSchema));
            IsBlank := False;
          end;
        end;
      4: // TABLE_NAME
        begin
          StrCopy(Value, PChar(fMetaTableCurrent.fTableName));
          IsBlank := False;
        end;
      5: // COLUMN_NAME      fldZSTRING
        begin
          StrCopy(Value, PChar(fMetaColumnCurrent.fColumnName));
          IsBlank := False;
        end;
      9: // COLUMN_TYPENAME  fldZSTRING
        begin
          StrCopy(Value, PChar(fMetaColumnCurrent.fTypeName));
          IsBlank := False;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataColumns.getString not valid for column '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      PChar(Value)^ := #0;
      IsBlank := True;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataColumns.getString', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataColumns.getString', ['Value=', PChar(Value), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataColumns.next: SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataColumns.next', ['fRowNo=', fRowNo]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Inc(fRowNo);
  if (fColumnList = nil) or
    (fRowNo > fColumnList.Count) then
  begin
    Result := DBXERR_EOF;
    exit;
  end;
  Result := DBXpress.SQL_SUCCESS;
  fMetaColumnCurrent := fColumnList.Items[fRowNo - 1];
  fMetaTableCurrent := fMetaColumnCurrent.fMetaTable;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataColumns.next', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataColumns.next', ['fRowNo=', fRowNo]); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TSqlCursorMetaDataIndexes }

const
  IndexColumnNames: array[1..11] of string =
  ('RECNO', 'CATALOG_NAME', 'SCHEMA_NAME', 'TABLE_NAME', 'INDEX_NAME',
    'PKEY_NAME', 'COLUMN_NAME', 'COLUMN_POSITION', 'INDEX_TYPE', 'SORT_ORDER',
    'FILTER');
  IndexColumnTypes: array[1..11] of Word =
  (fldINT32, fldZSTRING, fldZSTRING, fldZSTRING, fldZSTRING,
    fldZSTRING, fldZSTRING, fldINT16, fldINT16, fldZSTRING,
    fldZSTRING);
  IndexColumnCount = Length(IndexColumnNames);

  {
  1.  RECNO           fldINT32
        A record number that uniquely identifies each record.
  2.  CATALOG_NAME    fldZSTRING
        The name of the catalog (database) that contains the index.
  3.  SCHEMA_NAME     fldZSTRING
        The name of the schema that identifies the owner of the index.
  4.  TABLE_NAME      fldZSTRING
        The name of the table for which the index is defined.
  5.  INDEX_NAME      fldZSTRING
        The name of the index.
  6.  PKEY_NAME       fldZSTRING
        The name of the primary key.
  7.  COLUMN_NAME     fldZSTRING
        The name of the column (field) in the index.
  8.  COLUMN_POSITION fldINT16
        The position of this field in the index.
  9.  INDEX_TYPE      fldINT16
        An eSQLIndexType value (C++) or index type constant (Object Pascal) that
        indicates any special properties of the index.
  10. SORT_ORDER      fldZSTRING
        Indicates whether the index sorts on this field in
        ascending (a) or descending (d) order.
  11. FILTER          fldZSTRING
        A string that gives a filter condition limiting indexed records.

  ODBC SqlStatistics Result set columns:

  1.  TABLE_CAT        Varchar
        Catalog name of the table to which the statistic or index applies;
        NULL if not applicable to the data source.
  2.  TABLE_SCHEM      Varchar
        Schema name of the table to which the statistic or index applies;
        NULL if not applicable to the data source.
  3.  TABLE_NAME       Varchar not NULL
        Table name of the table to which the statistic or index applies.
  4.  NON_UNIQUE       Smallint
        Indicates whether the index prohibits duplicate values:
        SQL_TRUE if the index values can be nonunique.
        SQL_FALSE if the index values must be unique.
        NULL is returned if TYPE is SQL_TABLE_STAT.
  5.  INDEX_QUALIFIER  Varchar
        The identifier that is used to qualify the index name doing a DROP INDEX;
        NULL is returned if an index qualifier is not supported by the data source
        or if TYPE is SQL_TABLE_STAT.
        If a non-null value is returned in this column, it must be used to qualify
        the index name on a DROP INDEX statement; otherwise the TABLE_SCHEM
        should be used to qualify the index name.
  6.  INDEX_NAME       Varchar
         Index name; NULL is returned if TYPE is SQL_TABLE_STAT.
  7.  TYPE             Smallint not NULL
        Type of information being returned:
        SQL_TABLE_STAT indicates a statistic for the table (in the CARDINALITY or PAGES column).
        SQL_INDEX_BTREE indicates a B-Tree index.
        SQL_INDEX_CLUSTERED indicates a clustered index.
        SQL_INDEX_CONTENT indicates a content index.
        SQL_INDEX_HASHED indicates a hashed index.
        SQL_INDEX_OTHER indicates another type of index.
  8.  ORDINAL_POSITION Smallint
        Column sequence number in index (starting with 1);
        NULL is returned if TYPE is SQL_TABLE_STAT.
  9.  COLUMN_NAME      Varchar
        Column name.
        If the column is based on an expression, such as SALARY + BENEFITS,
        the expression is returned;
        if the expression cannot be determined, an empty string is returned.
        NULL is returned if TYPE is SQL_TABLE_STAT.
  10. ASC_OR_DESC      Char(1)         Sort sequence for the column;
       'A' for ascending; 'D' for descending;
       NULL is returned if column sort sequence is not supported by the
       data source or if TYPE is SQL_TABLE_STAT.
  11. CARDINALITY      Integer         Cardinality of table or index;
       number of rows in table if TYPE is SQL_TABLE_STAT;
       number of unique values in the index if TYPE is not SQL_TABLE_STAT;
       NULL is returned if the value is not available from the data source.
  12. PAGES            Integer
       Number of pages used to store the index or table;
       number of pages for the table if TYPE is SQL_TABLE_STAT;
       number of pages for the index if TYPE is not SQL_TABLE_STAT;
       NULL is returned if the value is not available from the data source,
       or if not applicable to the data source.
  13. FILTER_CONDITION Varchar
       If the index is a filtered index, this is the filter condition,
       such as SALARY > 30000;
       if the filter condition cannot be determined, this is an empty string.
       NULL if the index is not a filtered index, it cannot be determined whether
       the index is a filtered index, or TYPE is SQL_TABLE_STAT.

  ODBC SqlPrimaryKeys Result set columns:

  1.  TABLE_CAT   Varchar
        Primary key table catalog name;
        NULL if not applicable to the data source.
        If a driver supports catalogs for some tables but not for others,
        such as when the driver retrieves data from different DBMSs,
        it returns an empty string ('') for those tables that do not have catalogs.
  2.  TABLE_SCHEM Varchar
        Primary key table schema name;
        NULL if not applicable to the data source.
        If a driver supports schemas for some tables but not for others,
        such as when the driver retrieves data from different DBMSs,
        it returns an empty string ('') for those tables that do not have schemas.
  3.  TABLE_NAME  Varchar not NULL
        Primary key table name.
  4.  COLUMN_NAME Varchar not NULL
        Primary key column name.
        The driver returns an empty string for a column that does not have a name.
  5.  KEY_SEQ     Smallint not NULL  Column sequence number in key (starting with 1).
  6.  PK_NAME     Varchar
        Primary key name. NULL if not applicable to the data source.
  }

constructor TSqlCursorMetaDataIndexes.Create(
  OwnerMetaData: TSQLMetaDataOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataIndexes.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited Create(OwnerMetaData);

  fColumnCount := IndexColumnCount;
  fColumnNames := @IndexColumnNames;
  fColumnTypes := @IndexColumnTypes;

  fTableList := TList.Create;
  fIndexList := TList.Create;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataIndexes.Create', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataIndexes.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSqlCursorMetaDataIndexes.Destroy;
var
  i: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataIndexes.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  if fTableList<>nil then
  begin
    for i := fTableList.Count - 1 downto 0 do
      TMetaTable(fTableList[i]).Free;
    FreeAndNil(fTableList);
  end;
  if fIndexList<>nil then
  begin
    for i := fIndexList.Count - 1 downto 0 do
      TMetaIndexColumn(fIndexList[i]).Free;
    FreeAndNil(fIndexList);
  end;
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataIndexes.Destroy', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataIndexes.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorMetaDataIndexes.FetchIndexes(
  SearchTableName: PChar;
  SearchIndexType: Longword);

var
  OdbcRetcode: OdbcApi.SqlReturn;

  OdbcPkName: PAnsiChar;
  OdbcPkColumnName: PAnsiChar;

  IndexName: PAnsiChar;
  IndexColumnName: PAnsiChar;
  IndexFilter: PAnsiChar;
  IndexColumnPosition: Smallint;
  AscDesc: array[0..1] of Char;

  { Vars below were used for search pattern logic - now commented out
  Cat:                    PAnsiChar;
  Schema:                 PAnsiChar;
  TableName:              PAnsiChar;
  OdbcTableType:          PAnsiChar;

  cbCat:                  Integer;
  cbSchema:               Integer;
  cbTableName:            Integer;
  cbOdbcTableType:        Integer;{}

  cbOdbcPkColumnName: Integer;
  cbOdbcPkName: Integer;

  cbIndexName: Integer;
  cbIndexColumnName: Integer;
  cbIndexFilter: Integer;
  cbOdbcNonUnique: Integer;
  cbAscDesc: Integer;
  cbIndexColumnPosition: Smallint;
  cbOdbcIndexType: Integer;

  OdbcIndexType: Smallint;
  OdbcNonUnique: Smallint;

  i: Integer;
  aMetaTable: TMetaTable;
  aMetaIndexColumn: TMetaIndexColumn;
  sQuoteChar: String;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataIndexes.FetchIndexes', ['SearchTableName=', SearchTableName, 'SearchIndexType=', SearchIndexType]); try try {$ENDIF _TRACE_CALLS_}

  { Vars below were used for search pattern logic - now commented out
  Cat := nil;
  Schema := nil;
  TableName := nil;
  OdbcTableType := nil;{}

  OdbcPkName := nil;
  OdbcPkColumnName := nil;

  IndexName := nil;
  IndexColumnName := nil;
  IndexFilter := nil;

  try
    fSqlConnectionOdbc.AllocHStmt(fHStmt);

    ParseTableName(SearchTableName);

    if (SearchIndexType = eSQLPrimaryKey) or
      (SearchIndexType = eSQLUnique) or
      (SearchIndexType = eSQLPrimaryKey + eSQLUnique) then
      OdbcIndexType := OdbcApi.SQL_INDEX_UNIQUE
    else
      OdbcIndexType := OdbcApi.SQL_INDEX_ALL;
    {
    // Accoring to DBXpress help, ISqlMetaDate.GetIndices allows for SEARCH PATTERN
    // As Odbc Index function don't allow for search pattern, we have to get all
    // matching tables first, then call Odbc Index functions for EACH table found.

    // NOW COMMENTED OUT - DBXpress HELP IS WRONG
    // Table names containing underscore (Odbc single char wildcard) fuck it up

    OdbcRetCode := SQLTables(fhStmt,
    fMetaCatalogName, SQL_NTS, // Catalog name
    fMetaSchemaName, SQL_NTS,  // Schema name
    fMetaTableName, SQL_NTS,   // Table name match pattern
    nil, SQL_NTS);             // Table types

    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'SQLTables');

    if fSqlConnectionOdbc.fSupportsCatalog then
      DescribeAllocBindString(1, Cat, cbCat);
    DescribeAllocBindString(2, Schema, cbSchema);
    DescribeAllocBindString(3, TableName, cbTableName);
    DescribeAllocBindString(4, OdbcTableType, cbOdbcTableType);

    OdbcRetCode := SQLFetch(fhStmt);

    // -----------------------------------------------
    // This is to find the TABLES that match search parameters...
    while (OdbcRetCode <> ODBCapi.SQL_NO_DATA) do
    begin
      if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetCode, 'SQLFetch');
      aMetaTable := TMetaTable.Create(fSqlConnectionOdbc, Cat, Schema, TableName, eSQLTable);
      fTableList.Add(aMetaTable);
      OdbcRetCode := SQLFetch(fhStmt);
    end;
    OdbcRetCode := SQLCloseCursor(fhStmt);
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'SQLCloseCursor');
    OdbcRetCode := SQLFreeStmt (fhStmt, SQL_UNBIND);
    if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetCode, 'SQLFreeStmt - SQL_UNBIND');
    }  // End of commented section (Table name matching)
    aMetaTable := TMetaTable.Create(fSqlConnectionOdbc,
      fMetaCatalogName, fMetaSchemaName, fMetaTableName, eSQLTable);
    fTableList.Add(aMetaTable);
    // -----------------------------------------------
    for i := 0 to fTableList.Count - 1 do
    begin
      aMetaTable := TMetaTable(fTableList.Items[i]);
      fPkNameLenMax := 0;

      // -----------------------------------------------
      // This is to find the PRIMARY KEY of the table...
      if fSqlConnectionOdbc.fSupportsSQLPRIMARYKEYS then
      begin
        OdbcRetcode := SQLPrimaryKeys(fHStmt,
          aMetaTable.fCat, SQL_NTS, // Catalog name (match pattern not allowed)
          aMetaTable.fSchema, SQL_NTS, // Schema name (match pattern not allowed)
          aMetaTable.fTableName, SQL_NTS); // Table name (match pattern not allowed)
        // INFORMIX: The error is possible at call to other database.
        // Example:  select username from sysmaster::informix.syssessions
        // OdbcCheck(OdbcRetCode, 'SQLPrimaryKeys');
        if OdbcRetcode = OdbcApi.SQL_SUCCESS then
        begin
          DescribeAllocBindString(4, OdbcPkColumnName, cbOdbcPkColumnName);
          BindSmallint(5, IndexColumnPosition, @cbIndexColumnPosition);
          if (fSqlConnectionOdbc.fOdbcDriverType = eOdbcDriverTypeMySql) then
          begin
            // Work around bug in MySql Driver - It incorrectluy returns length ZERO for column 6
            OdbcPkName := AllocMem(129);
            OdbcRetcode := SQLBindCol(fHStmt, 6, SQL_C_CHAR, OdbcPkName, 129, @cbOdbcPkName);
            if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
              OdbcCheck(OdbcRetcode, 'SQLBindCol');
          end
          else
            DescribeAllocBindString(6, OdbcPkName, cbOdbcPkName);

          OdbcRetcode := SQLFetch(fHStmt);
          // if (OdbcRetCode <> OdbcApi.SQL_SUCCESS) then
          //   OdbcPkName[0] := #0;
          // aMetaTable.fPkName := OdbcPkName;

          // Get the PRIMARY KEY index columns(s)
          while (OdbcRetcode <> ODBCapi.SQL_NO_DATA) do
          begin
            if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
              OdbcCheck(OdbcRetcode, 'SQLFetch');
            if (OdbcPkName = nil) or (OdbcPkName[0] = #0) then
            begin
              {
                TClientDataSet do not correctly worked witch PacketRecords>0 when is unnamed PK.
                It has been detected on "PostgreSQL Legacy":
                  version: 07.03.0100 PostgreSQL 7.3.4 on i686-pc-cygwin,
                  compiled by GCC gcc (GCC) 3.2 20020927 (prerelease)
                  ODBC Driver: "PSQLODBC.DLL", version: 07.03.0100.

                Metadata:

                  create table test(
                    id integer primary key,
                    vc varchar(254)
                  );
                  insert into test(id, vc) values (1, null);
                  insert into test(id, vc) values (3, null);
                  insert into test(id, vc) values (2, 'test string');

                Code:

                CDS.PacketRecords := 2;
                SQLDataSet.GetMetadata := True;

                SELECT * FROM "public"."test"

                when query is:

                SELECT * FROM "public"."test"  order by id

                then all works truly.

              }
              // skip unnamed primary key
              aMetaIndexColumn := nil;
              {
              MaxSet(fPkNameLenMax, 23);//23=StrLen('[primary key - unnamed]'#0));
              aMetaIndexColumn := TMetaIndexColumn.Create(aMetaTable, '[primary key - unnamed]',
                OdbcPkColumnName);
              {}
            end
            else
            begin
              MaxSet(fPkNameLenMax, StrLen(OdbcPkColumnName));
              aMetaIndexColumn := TMetaIndexColumn.Create(aMetaTable, OdbcPkName,
                OdbcPkColumnName);
            end;
            if aMetaIndexColumn<>nil then
            begin
              if (aMetaTable.fIndexColumnList = nil) then
                aMetaTable.fIndexColumnList := TList.Create;
              if aMetaTable.fPrimaryKeyColumn1 = nil then
                aMetaTable.fPrimaryKeyColumn1 := aMetaIndexColumn;

              aMetaTable.fIndexColumnList.Add(aMetaIndexColumn);
              fIndexList.Add(aMetaIndexColumn);

              aMetaIndexColumn.fColumnPosition := IndexColumnPosition;
              // Assume Primary key is unique, ascending, no filter
              aMetaIndexColumn.fIndexType := eSQLPrimaryKey + eSQLUnique;
              aMetaIndexColumn.fSortOrder := 'A';
              aMetaIndexColumn.fFilter := nil;
            end;
            OdbcRetcode := SQLFetch(fHStmt);
          end; //of: while (OdbcRetCode <> ODBCapi.SQL_NO_DATA)

          OdbcRetcode := SQLCloseCursor(fHStmt);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLCloseCursor');
          OdbcRetcode := SQLFreeStmt(fHStmt, SQL_UNBIND);
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLFreeStmt - SQL_UNBIND');
        end; //of: if OdbcRetCode = OdbcApi.SQL_SUCCESS
      end; //of: if fSqlConnectionOdbc.fSupportsSQLPRIMARYKEYS
      // -----------------------------------------------

    // -----------------------------------------------
    // Get INDEX columns...
      OdbcRetcode := SQLStatistics(fHStmt,
        aMetaTable.fCat, SQL_NTS, // Catalog name (match pattern not allowed)
        aMetaTable.fSchema, SQL_NTS, // Schema name (match pattern not allowed)
        aMetaTable.fTableName, SQL_NTS, // Table name (match pattern not allowed)
        OdbcIndexType, // Type of Index to return
        0); // Reserved

      // if OdbcRetCode <> OdbcApi.SQL_SUCCESS then
      //   OdbcCheck(OdbcRetCode, 'SQLStatistics');
      if OdbcRetcode = OdbcApi.SQL_SUCCESS then
      begin
        DescribeAllocBindString(6, IndexName, cbIndexName);
        DescribeAllocBindString(9, IndexColumnName, cbIndexColumnName);
        BindSmallint(4, OdbcNonUnique, @cbOdbcNonUnique);
        {+2.01}
        //BindSmallInt(7, OdbcIndexType, nil);
        BindSmallint(7, OdbcIndexType, @cbOdbcIndexType);
        {/+2.01}
        BindSmallint(8, IndexColumnPosition, @cbIndexColumnPosition);
        OdbcRetcode := SQLBindCol(fHStmt, 10, SQL_C_CHAR,
          @AscDesc, SizeOf(AscDesc), @cbAscDesc);
        if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
          OdbcCheck(OdbcRetcode, 'SQLBindCol');
        DescribeAllocBindString(13, IndexFilter, cbIndexFilter);

        OdbcRetcode := SQLFetch(fHStmt);
        while (OdbcRetcode <> ODBCapi.SQL_NO_DATA) do
        begin
          if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
            OdbcCheck(OdbcRetcode, 'SQLFetch');

          if (OdbcIndexType <> OdbcApi.SQL_TABLE_STAT) then // Ignore table statistics
          begin
            if (IndexName<> nil) and  (IndexName^ <> #0) and // skip all unnamed indexes
              (aMetaTable.fPrimaryKeyColumn1 <> nil) and
              (AnsiStrComp(IndexName, aMetaTable.fPrimaryKeyColumn1.fIndexName) = 0) then
              // This is the Primary index - Index column already loaded
            else
            begin
              aMetaIndexColumn := TMetaIndexColumn.Create(aMetaTable, IndexName,
                IndexColumnName);
              if (aMetaTable.fIndexColumnList = nil) then
                aMetaTable.fIndexColumnList := TList.Create;
              fIndexList.Add(aMetaIndexColumn);
              aMetaTable.fIndexColumnList.Add(aMetaIndexColumn);

              aMetaIndexColumn.fColumnPosition := IndexColumnPosition;

              aMetaIndexColumn.fIndexType := eSQLNonUnique;
              if (cbOdbcNonUnique <> OdbcApi.SQL_NULL_DATA) and (OdbcNonUnique = SQL_FALSE) then
              begin
                if (fSqlConnectionOdbc.fOdbcDriverType = eOdbcDriverTypePostgreSQL) and
                   (aMetaTable.fTableName='pg_aggregate') then
                begin
                  if fSqlConnectionOdbc.fWantQuotedTableName then
                    sQuoteChar := PChar(@fSqlConnectionOdbc.fQuoteChar) // fQuoteChar can equal #0
                  else
                    sQuoteChar := '';
                  if not ( aMetaTable.fQualifiedTableName = // '"pg_catalog"."pg_aggregate"'
                     sQuoteChar+'pg_catalog'+sQuoteChar+'.'+sQuoteChar+'pg_aggregate'+sQuoteChar )
                  then
                    aMetaIndexColumn.fIndexType := eSQLUnique;
                end
                else
                  aMetaIndexColumn.fIndexType := eSQLUnique;
              end;

              if UpperCase(AscDesc[0]) = 'D' then
                aMetaIndexColumn.fSortOrder := 'D'
              else
                aMetaIndexColumn.fSortOrder := 'A';

              if cbIndexFilter > 0 then
              begin
                aMetaIndexColumn.fFilter := AllocMem(cbIndexFilter);
                StrCopy(aMetaIndexColumn.fFilter, IndexFilter);
              end;

               // MERANT DBASE returned multicolumns as 'Col_1 + Col2 + ...'
              if (fSqlConnectionOdbc.fOdbcDriverType = eOdbcDriverTypeMerantDBASE) //and
                 //( Pos('+', StrPas(aMetaIndexColumn.fIndexColumnName))>1 )
              then
              begin
                sQuoteChar := aMetaIndexColumn.fIndexColumnName;
                cbIndexName := Pos('+', sQuoteChar);
                while cbIndexName>0 do
                begin
                  if aMetaIndexColumn<>nil then
                  begin // first call
                    FreeMemAndNil(aMetaIndexColumn.fIndexColumnName);
                    aMetaIndexColumn.fIndexColumnName := AllocMem(cbIndexName);
                    Move(PChar(sQuoteChar)^, aMetaIndexColumn.fIndexColumnName^, cbIndexName-1);
                    aMetaIndexColumn.fIndexColumnName[cbIndexName-1] := #0;
                  end
                  else  // second call
                  begin
                    // create new column
                    aMetaIndexColumn := TMetaIndexColumn.Create(aMetaTable, IndexName,
                      PChar(Copy(sQuoteChar, 1, cbIndexName-1)));
                    // add column to lists
                    fIndexList.Add(aMetaIndexColumn);
                    aMetaTable.fIndexColumnList.Add(aMetaIndexColumn);
                    // fill column from previous column info
                    with TMetaIndexColumn(fIndexList.Items[fIndexList.Count-2]) do
                    begin
                      aMetaIndexColumn.fIndexType := fIndexType;
                      aMetaIndexColumn.fSortOrder := fSortOrder;// ???: It is incorrect, but the alternative does not exist.
                    end;
                    if cbIndexFilter > 0 then
                    begin
                      aMetaIndexColumn.fFilter := AllocMem(cbIndexFilter);
                      StrCopy(aMetaIndexColumn.fFilter, IndexFilter);
                    end;
                  end;
                  aMetaIndexColumn := nil;
                  if cbIndexName<Length(sQuoteChar) then
                  begin
                    sQuoteChar := StrPas(PChar(@sQuoteChar[cbIndexName+1]));
                    cbIndexName := Pos('+', sQuoteChar);
                    if cbIndexName<=0 then
                      cbIndexName := Length(sQuoteChar)+1;
                  end
                  else
                    cbIndexName := 0;
                end;
              end;// end: of MERAND fixed.

            end;
          end;
          OdbcRetcode := SQLFetch(fHStmt);
        end; //of: while (OdbcRetCode <> ODBCapi.SQL_NO_DATA)

        OdbcRetcode := SQLCloseCursor(fHStmt);
        if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
          OdbcCheck(OdbcRetcode, 'SQLCloseCursor');
        OdbcRetcode := SQLFreeStmt(fHStmt, SQL_UNBIND);
        if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
          OdbcCheck(OdbcRetcode, 'SQLFreeStmt - SQL_UNBIND');
      end; //of: if OdbcRetCode = OdbcApi.SQL_SUCCESS
    end; //of: for i := 0 to fTableList.Count - 1

    fCatLenMax := 0;
    fSchemaLenMax := 0;
    fTableLenMax := 1;
    fIndexNameLenMax := 1;
    fIndexColumnNameLenMax := 1;
    fFilterLenMax := 0;

    for i := 0 to fTableList.Count - 1 do
    begin
      aMetaTable := TMetaTable(fTableList.Items[i]);

      if aMetaTable.fCat <> nil then
        MaxSet(fCatLenMax, StrLen(aMetaTable.fCat));

      if aMetaTable.fSchema <> nil then
        MaxSet(fSchemaLenMax, StrLen(aMetaTable.fSchema));

      if Assigned(aMetaTable.fTableName) then
        MaxSet(fTableLenMax, StrLen(aMetaTable.fTableName));
    end;

    for i := 0 to fIndexList.Count - 1 do
    begin
      aMetaIndexColumn := TMetaIndexColumn(fIndexList.Items[i]);

      if Assigned(aMetaIndexColumn.fIndexName) then
        MaxSet(fIndexNameLenMax, StrLen(aMetaIndexColumn.fIndexName));

      if Assigned(aMetaIndexColumn.fIndexColumnName) then
        MaxSet(fIndexColumnNameLenMax, StrLen(aMetaIndexColumn.fIndexColumnName));

      if aMetaIndexColumn.fFilter <> nil then
        MaxSet(fFilterLenMax, StrLen(aMetaIndexColumn.fFilter));
    end;

  finally
    { Vars below were used for search pattern logic - now commented out
    FreeMem(Cat);
    FreeMem(Schema);
    FreeMem(TableName);
    FreeMem(OdbcTableType);{}
    FreeMem(OdbcPkName);
    FreeMem(OdbcPkColumnName);
    FreeMem(IndexFilter);
    FreeMem(IndexName);
    FreeMem(IndexColumnName);

    if (fHStmt <> SQL_NULL_HANDLE) then
      fSqlConnectionOdbc.FreeHStmt(fHStmt);
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataIndexes.FetchIndexes', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataIndexes.FetchIndexes'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataIndexes.getColumnLength(ColumnNumber: Word;
  var pLength: Longword): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataIndexes.getColumnLength', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case ColumnNumber of
      1: // RECNO
        pLength := SizeOf(Integer);
      2: // CATALOG_NAME
        pLength := fCatLenMax;
      3: // SCHEMA_NAME
        pLength := fSchemaLenMax;
      4: // TABLE_NAME
        pLength := fTableLenMax;
      5: // INDEX_NAME      fldZSTRING
        pLength := fIndexNameLenMax;
      6: // PKEY_NAME       fldZSTRING
        pLength := fPkNameLenMax;
      7: // COLUMN_NAME     fldZSTRING
        pLength := fIndexColumnNameLenMax;
      8: // COLUMN_POSITION fldINT16
        pLength := SizeOf(Smallint);
      9: // INDEX_TYPE       fldINT16
        pLength := SizeOf(Smallint);
      10: // SORT_ORDER     fldZSTRING
        pLength := 1;
      11: // FILTER         fldZSTRING
        pLength := fFilterLenMax;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataIndexes.getColumnLength invalid column '
        + IntToStr(ColumnNumber));
    end; //of: case ColumnNumber
    {+2.01}
    // Vadim V.Lopushansky:
    // If length is equal 0 that Delphi will ignore this column.
    // It is bad, since the column describes the metadata.
    if (pLength = 0) and (IndexColumnTypes[ColumnNumber] = fldZSTRING) then
      pLength := 1;
    {/+2.01}
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      pLength := 0;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataIndexes.getColumnLength', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataIndexes.getColumnLength', ['pLength=', pLength]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataIndexes.getColumnPrecision(ColumnNumber: Word;
  var piPrecision: Smallint): SQLResult;
var
  Length: Longword;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataIndexes.getColumnPrecision', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Result := getColumnLength(ColumnNumber, Length);
  {+2.01}
  //Vadim V.Lopushansky: Problems with loss of accuracy at type conversion
  // Edward> ???Ed>Vad: SqlIndexes should never return such a long column,
  // Edward> but this does no harm, so I leave it in
  if Length < Longword(High(Smallint)) then
    piPrecision := Length
  else
    piPrecision := -1;
  {/+2.01}
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataIndexes.getColumnPrecision', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataIndexes.getColumnPrecision', ['piPrecision=', piPrecision]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataIndexes.getLong(ColumnNumber: Word;
  Value: Pointer; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataIndexes.getLong', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case ColumnNumber of
      1: // RECNO
        begin
          Integer(Value^) := fRowNo;
          IsBlank := False;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataIndexes.getLong not valid for column '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      Integer(Value^) := 0;
      IsBlank := True;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataIndexes.getLong', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataIndexes.getLong', ['Value=', Integer(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataIndexes.getShort(ColumnNumber: Word;
  Value: Pointer; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataIndexes.getShort', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case ColumnNumber of
      8: // COLUMN_POSITION fldINT16
        begin
          Smallint(Value^) := fCurrentIndexColumn.fColumnPosition;
          IsBlank := False;
        end;
      9: // INDEX_TYPE       fldINT16
        begin
          Smallint(Value^) := fCurrentIndexColumn.fIndexType;
          IsBlank := False;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataIndexes.getLong not valid for column '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      IsBlank := True;
      Smallint(Value^) := 0;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataIndexes.getShort', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataIndexes.getShort', ['Value=', Smallint(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataIndexes.getString(ColumnNumber: Word;
  Value: Pointer; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_}
    IsBlank := True;
    if Value<>nil then PChar(Value)^ := #0;
    LogEnterProc('TSqlCursorMetaDataIndexes.getString', ['ColumnNumber=', ColumnNumber]);
    Result := SQL_SUCCESS;
    try try
  {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case ColumnNumber of
      1: ; // RECNO             fldINT32
      2: // CATALOG_NAME
        begin
          IsBlank := (not fSqlConnectionOdbc.fSupportsCatalog) or
            (fCurrentIndexColumn.fMetaTable.fCat = nil);
          if not IsBlank then
            StrCopy(Value, PChar(fCurrentIndexColumn.fMetaTable.fCat))
          else
            PChar(Value)^ := #0;
        end;
      3: // SCHEMA_NAME
        begin
          IsBlank := (fSchemaLenMax = 0) or (fCurrentIndexColumn.fMetaTable.fSchema = nil);
          if not IsBlank then
            StrCopy(Value, PChar(fCurrentIndexColumn.fMetaTable.fSchema))
          else
            PChar(Value)^ := #0;
        end;
      4: // TABLE_NAME
        begin
          StrCopy(Value, PChar(fCurrentIndexColumn.fMetaTable.fTableName));
          IsBlank := False;
        end;
      5: // INDEX_NAME        fldZSTRING
        begin
          StrCopy(Value, PChar(fCurrentIndexColumn.fIndexName));
          IsBlank := False;
        end;
      6: // PKEY_NAME        fldZSTRING
        begin
          if (fCurrentIndexColumn.fMetaTable.fPrimaryKeyColumn1 <> nil) then
          begin
            IsBlank := False;
            StrCopy(Value, fCurrentIndexColumn.fMetaTable.fPrimaryKeyColumn1.fIndexName);
          end
          else
          begin
            IsBlank := True;
            PChar(Value)^ := #0;
          end;
        end;
      7: // COLUMN_NAME     fldZSTRING
        begin
          StrCopy(Value, PChar(fCurrentIndexColumn.fIndexColumnName));
          IsBlank := False;
        end;
      8: ; // COLUMN_POSITION fldINT16
      9: ; // INDEX_TYPE      fldINT16
      10: // SORT_ORDER      fldZSTRING
        begin
          PChar(Value)[0] := fCurrentIndexColumn.fSortOrder;
          PChar(Value)[1] := #0;
          IsBlank := False;
        end;
      11: // FILTER         fldZSTRING
        begin
          if fFilterLenMax = 0 then
          begin
            IsBlank := True;
            PChar(Value)^ := #0;
          end
          else
          begin
            StrCopy(Value, PChar(fCurrentIndexColumn.fFilter));
            IsBlank := False;
          end;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataIndexes.getLong not valid for column '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      IsBlank := True;
      PChar(Value)^ := #0;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataIndexes.getString', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataIndexes.getString', ['Value=', PChar(Value), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataIndexes.next: SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataIndexes.next'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Inc(fRowNo);
  if Assigned(fIndexList) and (fRowNo <= fIndexList.Count) then
  begin
    fCurrentIndexColumn := fIndexList[fRowNo - 1];
    Result := DBXpress.SQL_SUCCESS;
  end
  else
    Result := DBXERR_EOF;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataIndexes.next', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataIndexes.next'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TSqlCursorProcedures }
{
Dbx returned cursor columns
 1. RECNO         fldINT32
      A record number that uniquely identifies each record.
 2. CATALOG_NAME  fldZSTRING
      The name of the catalog (database) that contains the stored procedure.
 3. SCHEMA_NAME   fldZSTRING
      The name of the schema that identifies the owner of the stored procedure.
 4. PROC_NAME     fldZSTRING
      The name of the stored procedure.
 5. PROC_TYPE     fldINT32
      An eSQLProcType value (C++) or stored procedure type constant (Object Pascal)
      that indicates the type of stored procedure.
 6. IN_PARAMS     fldINT16
      The number of input parameters.
 7. OUT_PARAMS    fldINT16
      The number of output parameters.

ODBC Result set columns from SQLProcedures
 1. PROCEDURE_CAT     Varchar
      Catalog name; NULL if not applicable to the data source
 2. PROCEDURE_SCHEM   Varchar
      Schema name; NULL if not applicable to the data source.
 3. PROCEDURE_NAME    Varchar not null
      Procedure identifier
 4. NUM_INPUT_PARAMS  N/A         Reserved for future use
 5. NUM_OUTPUT_PARAMS N/A         Reserved for future use
 6. NUM_RESULT_SETS   N/A         Reserved for future use
 7. REMARKS           Varchar
      A description of the procedure
 8. PROCEDURE_TYPE    Smallint    Defines the procedure type:
      SQL_PT_UNKNOWN:   It cannot be determined whether the procedure returns a value.
      SQL_PT_PROCEDURE: The returned object is a procedure;
       that is, it does not have a return value.
      SQL_PT_FUNCTION:  The returned object is a function;
       that is, it has a return value.
}

const
  ProcedureColumnNames: array[1..7] of string =
  ('RECNO', 'CATALOG_NAME', 'SCHEMA_NAME', 'PROC_NAME', 'PROC_TYPE', 'IN_PARAMS', 'OUT_PARAMS');
  ProcedureColumnTypes: array[1..7] of Word =
  (fldINT32, fldZSTRING, fldZSTRING, fldZSTRING, fldINT32, fldINT16, fldINT16);
  ProcedureColumnCount = Length(ProcedureColumnNames);

constructor TSqlCursorMetaDataProcedures.Create(
  OwnerMetaData: TSQLMetaDataOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedures.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited Create(OwnerMetaData);
  fColumnCount := ProcedureColumnCount;
  fColumnNames := @ProcedureColumnNames;
  fColumnTypes := @ProcedureColumnTypes;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedures.Create', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedures.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSqlCursorMetaDataProcedures.Destroy;
var
  i: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedures.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  if Assigned(fProcList) then
  begin
    for i := fProcList.Count - 1 downto 0 do
      TMetaProcedure(fProcList[i]).Free;
    FreeAndNil(fProcList);
  end;
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedures.Destroy', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedures.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorMetaDataProcedures.FetchProcedures(
  ProcedureName: PChar;
  ProcType: Longword);

var
  OdbcRetcode: OdbcApi.SqlReturn;
  aMetaProcedure: TMetaProcedure;

  Cat: PAnsiChar;
  Schema: PAnsiChar;
  ProcName: PAnsiChar;
  OdbcProcType: Smallint;

  cbCat: SqlInteger;
  cbSchema: SqlInteger;
  cbProcName: SqlInteger;
  cbOdbcProcType: SqlInteger;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedures.FetchProcedures', ['ProcedureName=', ProcedureName, 'ProcType=', ProcType]); try try {$ENDIF _TRACE_CALLS_}
  Cat := nil;
  Schema := nil;
  ProcName := nil;

  try
    fSqlConnectionOdbc.AllocHStmt(fHStmt);

    {  ProcType is a combination of flags:
       eSQLProcedure, eSQLFunction, eSQLPackage, eSQLSysProcedure
       But ODBC always returns all procedures }

    {+2.01}
    //Vadim V.Lopushansky:
    // Set Metadata CurrentSchema Filter
    // Edward> Again, I don't think any real dbxpress application will use
    // Edward> schema filter, but I leave this code sa it is harmless
    if (fSqlConnectionOdbc.fConnectionOptions[coSupportsSchemaFilter] = osOn) and
      (Length(fSqlConnectionOdbc.fCurrentSchema) > 0) then
    begin
      OdbcRetcode := SQLProcedures(fHStmt,
        nil, 0, // all catalogs
        PChar(fSqlConnectionOdbc.fCurrentSchema),
        Length(fSqlConnectionOdbc.fCurrentSchema), // current schemas
        ProcedureName, SQL_NTS); // Procedure name match pattern
    end
    else
      {/+2.01}
      OdbcRetcode := SQLProcedures(fHStmt,
        nil, 0, // all catalogs
        nil, 0, // all schemas
        ProcedureName, SQL_NTS); // Procedure name match pattern
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLProcedures');

    if fSqlConnectionOdbc.fSupportsCatalog then
      DescribeAllocBindString(1, Cat, cbCat);
    DescribeAllocBindString(2, Schema, cbSchema);
    DescribeAllocBindString(3, ProcName, cbProcName);
    BindSmallint(8, OdbcProcType, @cbOdbcProcType);

    fCatLenMax := 0;
    fSchemaLenMax := 0;
    fProcLenMax := 1;
    fProcList := TList.Create;
    OdbcRetcode := SQLFetch(fHStmt);

    while (OdbcRetcode <> ODBCapi.SQL_NO_DATA) do
    begin

      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLFetch');

      aMetaProcedure := TMetaProcedure.Create(Cat, Schema, ProcName, OdbcProcType);
      fProcList.Add(aMetaProcedure);

      if Cat <> nil then
        MaxSet(fCatLenMax, StrLen(Cat));

      if Assigned(Schema) then
        MaxSet(fSchemaLenMax, StrLen(Schema));

      if Assigned(ProcName) then
        MaxSet(fProcLenMax, StrLen(ProcName));

      OdbcRetcode := SQLFetch(fHStmt);
    end;

  finally
    FreeMem(Cat);
    FreeMem(Schema);
    FreeMem(ProcName);

    if fHStmt <> SQL_NULL_HANDLE then
      fSqlConnectionOdbc.FreeHStmt(fHStmt);
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedures.FetchProcedures', e);  raise; end; end;
    //except raise; end;
    finally LogExitProc('TSqlCursorMetaDataProcedures.FetchProcedures'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedures.getColumnLength(ColumnNumber: Word;
  var pLength: Longword): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedures.getColumnLength', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case ColumnNumber of
      1: // RECNO
        pLength := SizeOf(Integer);
      2: // CATALOG_NAME
        pLength := fCatLenMax;
      3: // SCHEMA_NAME
        pLength := fSchemaLenMax;
      4: // PROCEDURE_NAME
        pLength := fProcLenMax;
      5: // PROC_TYPE
        pLength := SizeOf(Integer);
      6: // IN_PARAMS
        pLength := SizeOf(Smallint);
      7: // OUT_PARAMS
        pLength := SizeOf(Smallint);
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataProcedures.getColumnLength invalid column no: '
        + IntToStr(ColumnNumber));
    end;
    {+2.01}
    // Vadim V.Lopushansky:
    // If length is equal 0 that Delphi will ignore this column.
    // It is bad, since the column describes the metadata.
    if (pLength = 0) and (ProcedureColumnTypes[ColumnNumber] = fldZSTRING) then
      pLength := 1;
    {/+2.01}
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      pLength := 0;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedures.getColumnLength', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedures.getColumnLength', ['pLength=', pLength]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedures.getColumnPrecision(ColumnNumber: Word;
  var piPrecision: Smallint): SQLResult;
var
  Length: Longword;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedures.getColumnPrecision', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Result := getColumnLength(ColumnNumber, Length);
  piPrecision := Length;
  {+2.01}
  //Vadim V.Lopushansky: Problems with loss of accuracy at type conversion
  // Edward> ???Ed>Vad: No column from SqlProcedures should ever be this big,
  // Edward> but it does no harm, and it is consistent with other changes
  if Length < Longword(High(Smallint)) then
    piPrecision := Length
  else
    piPrecision := -1;
  {/+2.01}
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedures.getColumnPrecision', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedures.getColumnPrecision', ['piPrecision=', piPrecision]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedures.getLong(ColumnNumber: Word; Value: Pointer;
  var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedures.getLong', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case ColumnNumber of
      1: // RECNO
        begin
          Integer(Value^) := fRowNo;
          IsBlank := False;
        end;
      5: // PROC_TYPE
        begin
          { TODO : CHECK FOR PROCEDURE TYPE - Assume Procedure for now }
          Integer(Value^) := eSQLProcedure;
          IsBlank := False;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataProcedures.getLong invalid column no: '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      Integer(Value^) := 0;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedures.getLong', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedures.getLong', ['Value=', Integer(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedures.getString(ColumnNumber: Word;
  Value: Pointer; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedures.getString', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case ColumnNumber of
      2: // CATALOG_NAME
        begin
          if (fMetaProcedureCurrent.fCat = nil) then
          begin
            PChar(Value)^ := #0;
            IsBlank := True;
          end
          else
          begin
            StrCopy(Value, PChar(fMetaProcedureCurrent.fCat));
            IsBlank := False;
          end;
        end;
      3: // SCHEMA_NAME
        begin
          if (fMetaProcedureCurrent.fSchema = nil) then
          begin
            PChar(Value)^ := #0;
            IsBlank := True;
          end
          else
          begin
            StrCopy(Value, PChar(fMetaProcedureCurrent.fSchema));
            IsBlank := False;
          end;
        end;
      4: // PROCEDURE_NAME
        begin
          StrCopy(Value, PChar(fMetaProcedureCurrent.fProcName));
          IsBlank := False;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataProcedures.getString invalid column no: '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      PChar(Value)^ := #0;
      IsBlank := True;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedures.getString', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedures.getString', ['Value=', PChar(Value), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedures.next: SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedures.next'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Inc(fRowNo);
  if (fProcList <> nil) and
    (fRowNo <= fProcList.Count) then
  begin
    fMetaProcedureCurrent := fProcList[fRowNo - 1];
    Result := DBXpress.SQL_SUCCESS;
  end
  else
    Result := DBXERR_EOF;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedures.next', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedures.next'); end;
  {$ENDIF _TRACE_CALLS_}
end;

{ TSqlCursorMetaDataProcedureParams }

{
Dbx returned cursor columns
 1.  RECNO          fldINT32
       A record number that uniquely identifies each record.
 2.  CATALOG_NAME      fldZSTRING
       The name of the catalog (database) that contains the stored procedure.
 3.  SCHEMA_NAME       fldZSTRING
       The name of the schema that identifies the owner of the stored procedure.
 4.  PROC_NAME         fldZSTRING
       The name of the procedure in which the parameter appears.
 5.  PARAM_NAME        fldZSTRING
       The name of the parameter.
 6.  PARAM_TYPE        fldINT16
       A STMTParamType value that indicates whether the parameter is used
       for input, output, or result.
 7.  PARAM_DATATYPE    fldINT16
       The logical data type for the parameter.
 8.  PARAM_SUBTYPE     fldINT16
       The logical data subtype for the parameter.
 9.  PARAM_TYPENAME    fldZSTRING
      A string describing the datatype.
      This is the same information as contained in PARAM_DATATYPE
      and PARAM_SUBTYPE, but in a form used in some DDL statements.
 10. PARAM_PRECISION   fldINT32
      The size of the parameter type
      (number of characters in a string, bytes in a bytes field,
      significant digits in a BCD value, members of an ADT, and so on)
 11. PARAM_SCALE       fldINT16
       The number of digits to the right of the decimal on BCD values,
       or descendants on ADT and array values.
 12. PARAM_LENGTH      fldINT32
       The number of bytes required to store parameter values.
 13. PARAM_NULLABLE    fldINT16
       0 if the parameter requires a value, nonzero if it can be blank.
 {+2.01}
 { Vadim V.Lopushansky: add support parameter position.
   For an example look: ($DELPHI$)\Demos\Db\DbxExplorer\dbxexplorer.dpr (Read PARAM_POSITION error).
 14. PARAM_POSITION    fldINT16
       The position of the param in its procedure.
 {/+2.01}
{
ODBC result set columns from SQLProcedureColumns
 1.  PROCEDURE_CAT        Varchar
       Procedure catalog name; NULL if not applicable to the data source.
 2.  PROCEDURE_SCHEM      Varchar
       Procedure schema name; NULL if not applicable to the data source.
 3.  PROCEDURE_NAME       Varchar not NULL
       Procedure name. An empty string is returned for a procedure
       that does not have a name.
 4.  COLUMN_NAME          Varchar not NULL
       Procedure column name. The driver returns an empty string for
       a procedure column that does not have a name.
 5.  COLUMN_TYPE          Smallint not NULL
       Defines the procedure column as a parameter or a result set column:
       SQL_PARAM_TYPE_UNKNOWN: The procedure column is a parameter whose type is unknown
       SQL_PARAM_INPUT:        The procedure column is an input parameter
       SQL_PARAM_INPUT_OUTPUT: The procedure column is an input/output parameter
       SQL_PARAM_OUTPUT:       The procedure column is an output parameter
       SQL_RETURN_VALUE:       The procedure column is the return value of the procedure
       SQL_RESULT_COL:         The procedure column is a result set column
 6.  DATA_TYPE            Smallint not NULL
       SQL data type. This can be an ODBC SQL data type or a driver-specific SQL data type.
       For datetime and interval data types, this column returns the concise
       data types (for example, SQL_TYPE_TIME or SQL_INTERVAL_YEAR_TO_MONTH)
 7.  TYPE_NAME            Varchar not NULL
       Data source ñ dependent data type name
 8.  COLUMN_SIZE          Integer
       The column size of the procedure column on the data source.
       NULL is returned for data types where column size is not applicable.
       For more information concerning precision, see 'Column Size, Decimal
       Digits, Transfer Octet Length, and Display Size,' in Appendix D, 'Data Types.'
 9.  BUFFER_LENGTH        Integer
      The length in bytes of data transferred on an SQLGetData or SQLFetch
      operation if SQL_C_DEFAULT is specified.
      For numeric data, this size may be different than the size of the data
      stored on the data source.
      For more information concerning precision, see 'Column Size, Decimal
      Digits, Transfer Octet Length, and Display Size,' in Appendix D, 'Data Types.'
 10. DECIMAL_DIGITS       Smallint
      The decimal digits of the procedure column on the data source.
      NULL is returned for data types where decimal digits is not applicable.
      For more information concerning decimal digits, see 'Column Size, Decimal
      Digits, Transfer Octet Length, and Display Size,' in Appendix D, 'Data Types.'
 11. NUM_PREC_RADIX       Smallint
      For numeric data types, either 10 or 2.
      If it is 10, the values in COLUMN_SIZE and DECIMAL_DIGITS give the number
      of decimal digits allowed for the column.
      For example, a DECIMAL(12,5) column would return a NUM_PREC_RADIX of 10,
      a COLUMN_SIZE of 12, and a DECIMAL_DIGITS of 5;
      a FLOAT column could return a NUM_PREC_RADIX of 10, a COLUMN_SIZE of 15
      and a DECIMAL_DIGITS of NULL.
      If it is 2, the values in COLUMN_SIZE and DECIMAL_DIGITS give the number
      of bits allowed in the column.
      For example, a FLOAT column could return a NUM_PREC_RADIX of 2,
      a COLUMN_SIZE of 53, and a DECIMAL_DIGITS of NULL.
      NULL is returned for data types where NUM_PREC_RADIX is not applicable.
 12.NULLABLE             Smallint not NULL
     Whether the procedure column accepts a NULL value:
     SQL_NO_NULLS: The procedure column does not accept NULL values.
     SQL_NULLABLE: The procedure column accepts NULL values.
     SQL_NULLABLE_UNKNOWN: It is not known if the procedure column accepts NULL values.
 13.REMARKS              Varchar
      A description of the procedure column.
 14.COLUMN_DEF           Varchar
     The default value of the column.
     If NULL was specified as the default value, then this column is
     the word NULL, not enclosed in quotation marks.
     If the default value cannot be represented without truncation, then this
     column contains TRUNCATED, with no enclosing single quotation marks.
     If no default value was specified, then this column is NULL.
     The value of COLUMN_DEF can be used in generating a new column definition,
     except when it contains the value TRUNCATED.
 15.SQL_DATA_TYPE        Smallint not NULL
      The value of the SQL data type as it appears in the SQL_DESC_TYPE field
      of the descriptor.
      This column is the same as the DATA_TYPE column, except for datetime and
      interval data types.
      For datetime and interval data types, the SQL_DATA_TYPE field in the
      result set will return SQL_INTERVAL or SQL_DATETIME,
      and the SQL_DATETIME_SUB field will return the subcode for the
      specific interval or datetime data type (see Appendix D, ìData Typesî).
 16.SQL_DATETIME_SUB     Smallint
      The subtype code for datetime and interval data types.
      For other data types, this column returns a NULL.
 17.CHAR_OCTET_LENGTH    Integer
      The maximum length in bytes of a character or binary data type column.
      For all other data types, this column returns a NULL.
 18.ORDINAL_POSITION     Integer not NULL
     For input and output parameters, the ordinal position of the parameter
     in the procedure definition (in increasing parameter order, starting at 1).
     For a return value (if any), 0 is returned.
     For result-set columns, the ordinal position of the column in the result set,
     with the first column in the result set being number 1.
     If there are multiple result sets, column ordinal positions are returned in
     a driver-specific manner.
 19.IS_NULLABLE          Varchar
      'NO' if the column does not include NULLs.
      'YES' if the column can include NULLs.
      This column returns a zero-length string if nullability is unknown.
      ISO rules are followed to determine nullability.
      An ISO SQL ñ compliant DBMS cannot return an empty string.
      The value returned for this column is different from the value returned
      for the NULLABLE column. (See the description of the NULLABLE column.)
}

const
  ProcedureParamColumnNames: array[1..14] of string =
  ('RECNO', 'CATALOG_NAME', 'SCHEMA_NAME', 'PROC_NAME', 'PARAM_NAME',
    'PARAM_TYPE', 'PARAM_DATATYPE', 'PARAM_SUBTYPE', 'PARAM_TYPENAME', 'PARAM_PRECISION',
    'PARAM_SCALE', 'PARAM_LENGTH', 'PARAM_NULLABLE', 'PARAM_POSITION');
  ProcedureParamColumnTypes: array[1..14] of Word =
  (fldINT32, fldZSTRING, fldZSTRING, fldZSTRING, fldZSTRING,
    fldINT16, fldINT16, fldINT16, fldZSTRING, fldINT32,
    fldINT16, fldINT32, fldINT16, fldINT16);
  ProcedureParamColumnCount = Length(ProcedureParamColumnNames);

constructor TSqlCursorMetaDataProcedureParams.Create(
  OwnerMetaData: TSQLMetaDataOdbc);
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedureParams.Create'); try try {$ENDIF _TRACE_CALLS_}
  inherited Create(OwnerMetaData);

  fColumnCount := ProcedureParamColumnCount;
  fColumnNames := @ProcedureParamColumnNames;
  fColumnTypes := @ProcedureParamColumnTypes;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedureParams.Create', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedureParams.Create'); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TSqlCursorMetaDataProcedureParams.Destroy;
var
  i: Integer;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedureParams.Destroy'); try try {$ENDIF _TRACE_CALLS_}
  if Assigned(fProcColumnList) then
  begin
    for i := fProcColumnList.Count - 1 downto 0 do
      TMetaProcedureParam(fProcColumnList[i]).Free;
    FreeAndNil(fProcColumnList);
  end;
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedureParams.Destroy', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedureParams.Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TSqlCursorMetaDataProcedureParams.FetchProcedureParams(
  SearchProcedureName: PChar;
  SearchParamName: PChar);

var
  OdbcRetcode: OdbcApi.SqlReturn;
  Cat: PChar;
  Schema: PChar;
  ProcName: PChar;
  ProcColumnName: PChar;
  TypeName: PChar;
  OrdinalPosition: Integer;
  bOrdinalPositionEmulate: Boolean;
  ColumnType: Smallint;
  OdbcDataType: Smallint;
  v_DECIMAL_DIGITS: Smallint;
  cbv_DECIMAL_DIGITS: Integer;
  v_NUM_PREC_RADIX: Smallint;
  cbv_NUM_PREC_RADIX: Integer;
  v_COLUMN_SIZE: Integer;
  cbv_COLUMN_SIZE: Integer;
//  v_CHAR_OCTET_LENGTH: Integer;
//  cbv_CHAR_OCTET_LENGTH: Integer;
  v_BUFFER_LENGTH: Integer;
  cbv_BUFFER_LENGTH: Integer;
  OdbcNullable: Smallint;
  cbv_OdbcNullable: Integer;

  cbCat: Integer;
  cbSchema: Integer;
  cbProcName: Integer;
  cbProcColumnName: Integer;
  cbTypeName: Integer;
  cbColumnType: Integer;
  cbOdbcDataType: Integer;
  cbOrdinalPosition: Integer;

  DbxDataType: Smallint;
  DbxDataSubType: Smallint;
  i: Integer;
  aMetaProcedure: TMetaProcedure;
  aMetaProcedureParam: TMetaProcedureParam;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedureParams.FetchProcedureParams', ['SearchProcedureName=', SearchProcedureName, 'SearchParamName=', SearchParamName]); try try {$ENDIF _TRACE_CALLS_}
  Cat := nil;
  Schema := nil;
  ProcName := nil;
  ProcColumnName := nil;
  TypeName := nil;
  try
    fSqlConnectionOdbc.AllocHStmt(fHStmt);

    if (SearchParamName <> nil) then
      if (SearchParamName[0] = #0) then
        SearchParamName := nil;

    ParseTableName(SearchProcedureName);

    OdbcRetcode := SQLProcedureColumns(fHStmt,
      fMetaCatalogName, SQL_NTS, // Catalog name
      fMetaSchemaName, SQL_NTS, // Schema name
      fMetaTableName, SQL_NTS, // Procedure name match pattern
      SearchParamName, SQL_NTS); // Column name match pattern
    if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
      OdbcCheck(OdbcRetcode, 'SQLProcedureColumns');

    if fSqlConnectionOdbc.fSupportsCatalog then
      DescribeAllocBindString(1, Cat, cbCat);
    if (fSqlConnectionOdbc.fOdbcMaxSchemaNameLen > 0) then
      DescribeAllocBindString(2, Schema, cbSchema);
    DescribeAllocBindString(3, ProcName, cbProcName);
    DescribeAllocBindString(4, ProcColumnName, cbProcColumnName);
    BindSmallint(5, ColumnType, @cbColumnType);
    BindSmallint(6, OdbcDataType, @cbOdbcDataType);
    DescribeAllocBindString(7, TypeName, cbTypeName);
    //Vadim V.Lopushansky: Reading of the information about types of parameters
    BindInteger(8, v_COLUMN_SIZE, @cbv_COLUMN_SIZE);
    BindInteger(9, v_BUFFER_LENGTH, @cbv_BUFFER_LENGTH);
    BindSmallint(10, v_DECIMAL_DIGITS, @cbv_DECIMAL_DIGITS);
    BindSmallint(11, v_NUM_PREC_RADIX, @cbv_NUM_PREC_RADIX);
//    try
//      BindInteger(17, v_CHAR_OCTET_LENGTH, @cbv_CHAR_OCTET_LENGTH);
//    except
//      v_CHAR_OCTET_LENGTH := -1;
//    end;
    v_DECIMAL_DIGITS := 0;
    v_NUM_PREC_RADIX := 0;
    v_COLUMN_SIZE := 0;
    v_BUFFER_LENGTH := 0;
//    v_CHAR_OCTET_LENGTH := 0;
    {/+2.01}
    BindSmallint(12, OdbcNullable, @cbv_OdbcNullable{nil}); // NULLABLE
    try
      BindInteger(18, OrdinalPosition, @cbOrdinalPosition);
      bOrdinalPositionEmulate := False;
    except
      OrdinalPosition := -1;
      bOrdinalPositionEmulate := True;
    end;

    fProcList := TList.Create;
    fProcColumnList := TList.Create;

    OdbcRetcode := SQLFetch(fHStmt);

    while (OdbcRetcode <> ODBCapi.SQL_NO_DATA) do
    begin

      if OdbcRetcode <> OdbcApi.SQL_SUCCESS then
        OdbcCheck(OdbcRetcode, 'SQLFetch');
      {+2.01}
      //Vadim V.Lopushansky: The code for drivers which not supporting filter
      // (Easysoft IB6 ODBC Driver [ver:1.00.01.67] contain its error).
      // Edward> Again, I don't think a real dbxpress application will use filter,
      // Edward> but I leave the code, as it is correct
      if Assigned(SearchParamName) then
        i := StrLen(SearchParamName)
      else
        i := 0;
      if (i > 0) and ((i <> Integer(StrLen(ProcColumnName))) or
        (StrLComp(SearchParamName, ProcColumnName, i) <> 0)) then
      begin
        OdbcRetcode := SQLFetch(fHStmt);
        continue;
      end;
      {/+2.01}

      if (ColumnType <> SQL_RESULT_COL) then
      begin
        aMetaProcedure := TMetaProcedure.Create(Cat, Schema, ProcName, 0);
        fProcList.Add(aMetaProcedure);
        aMetaProcedureParam := TMetaProcedureParam.Create(ProcColumnName);
        fProcColumnList.Add(aMetaProcedureParam);
        //Correction to reference from ProcedureParam to Procedure
        aMetaProcedureParam.fMetaProcedure := aMetaProcedure;
        case ColumnType of
          SQL_PARAM_TYPE_UNKNOWN:
            aMetaProcedureParam.fParamType := DBXpress.paramUNKNOWN;
          SQL_PARAM_INPUT:
            aMetaProcedureParam.fParamType := DBXpress.paramIN;
          SQL_PARAM_INPUT_OUTPUT:
            aMetaProcedureParam.fParamType := DBXpress.paramINOUT;
          SQL_PARAM_OUTPUT:
            aMetaProcedureParam.fParamType := DBXpress.paramOUT;
          SQL_RETURN_VALUE:
            aMetaProcedureParam.fParamType := DBXpress.paramRET;
          SQL_RESULT_COL: ; // Already discarded
        end;

        //Vadim V.Lopushansky: Calculating metadata:
        if (cbv_BUFFER_LENGTH = OdbcAPi.SQL_NULL_DATA) then
          aMetaProcedureParam.fLength := Low(Integer) // this indicates null data
        else
          aMetaProcedureParam.fLength := v_BUFFER_LENGTH;

        if cbv_DECIMAL_DIGITS = OdbcAPi.SQL_NULL_DATA then
          aMetaProcedureParam.fScale := Low(Smallint) // this indicates null data
        else
          aMetaProcedureParam.fScale := v_DECIMAL_DIGITS;

        if cbv_COLUMN_SIZE = OdbcAPi.SQL_NULL_DATA then
          aMetaProcedureParam.fPrecision := Low(Integer) // this indicates null data
        else
        begin
          if (cbv_NUM_PREC_RADIX <> OdbcAPi.SQL_NULL_DATA) and (v_NUM_PREC_RADIX = 2) then
            aMetaProcedureParam.fPrecision := ((v_COLUMN_SIZE * 3) div 10) + 1
          else
            aMetaProcedureParam.fPrecision := v_COLUMN_SIZE
        end;
        OdbcDataTypeToDbxType(OdbcDataType, DbxDataType, DbxDataSubType, fSqlConnectionOdbc);

        if DbxDataType = fldUNKNOWN then
          raise EDbxInternalError.Create('Unsupported ODBC data type ' + IntToStr(OdbcDataType));

        aMetaProcedureParam.fDataType := DbxDataType;
        aMetaProcedureParam.fDataSubtype := DbxDataSubType;
        aMetaProcedureParam.fDataTypeName := AllocMem(StrLen(TypeName) + 1);
        StrCopy(aMetaProcedureParam.fDataTypeName, TypeName);
        if (OdbcNullable <> SQL_NULLABLE) then
          aMetaProcedureParam.fNullable := 0 // Requires a value
        else
          aMetaProcedureParam.fNullable := 1; // Does not require a value
        if bOrdinalPositionEmulate then
          inc(OrdinalPosition);
        aMetaProcedureParam.fPosition := OrdinalPosition;
      end; //of: if (ColumnType <> SQL_Result_COL)

      {+2.01}
      v_DECIMAL_DIGITS := 0;
      v_NUM_PREC_RADIX := 0;
      v_COLUMN_SIZE := 0;
//      v_CHAR_OCTET_LENGTH := 0;
      v_BUFFER_LENGTH := 0;
      {/+2.01}

      OdbcRetcode := SQLFetch(fHStmt);
    end; //of: while (OdbcRetCode <> ODBCapi.SQL_NO_DATA)

    fCatLenMax := 0;
    fSchemaLenMax := 0;
    fProcNameLenMax := 1;
    fParamNameLenMax := 1;
    fDataTypeNameLenMax := 1;

    for i := 0 to fProcList.Count - 1 do
    begin
      aMetaProcedure := TMetaProcedure(fProcList.Items[i]);

      if Assigned(aMetaProcedure.fCat) then
        MaxSet(fCatLenMax, StrLen(aMetaProcedure.fCat));

      if Assigned(aMetaProcedure.fSchema) then
        MaxSet(fSchemaLenMax, StrLen(aMetaProcedure.fSchema));

      if Assigned(aMetaProcedure.fProcName) then
        MaxSet(fProcNameLenMax, StrLen(aMetaProcedure.fProcName));
    end;

    for i := 0 to fProcColumnList.Count - 1 do
    begin
      aMetaProcedureParam := TMetaProcedureParam(fProcColumnList.Items[i]);

      if Assigned(aMetaProcedureParam.fParamName) then
        MaxSet(fParamNameLenMax, StrLen(aMetaProcedureParam.fParamName));

      if Assigned(aMetaProcedureParam.fDataTypeName) then
        MaxSet(fDataTypeNameLenMax, StrLen(aMetaProcedureParam.fDataTypeName));
    end;

  finally
    FreeMem(Cat);
    FreeMem(Schema);
    FreeMem(ProcName);
    FreeMem(ProcColumnName);
    FreeMem(TypeName);

    if (fHStmt <> SQL_NULL_HANDLE) then
      fSqlConnectionOdbc.FreeHStmt(fHStmt);
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedureParams.FetchProcedureParams', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedureParams.FetchProcedureParams'); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedureParams.getColumnLength(
  ColumnNumber: Word; var pLength: Longword): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedureParams.getColumnLength', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  try
    case ColumnNumber of
      1: // RECNO
        pLength := SizeOf(Integer);
      2: // CATALOG_NAME
        pLength := fCatLenMax;
      3: // SCHEMA_NAME
        pLength := fSchemaLenMax;
      4: // PROCEDURE_NAME
        pLength := fProcNameLenMax;
      5: // PARAM_NAME
        pLength := fParamNameLenMax;
      6: // PARAM_TYPE
        pLength := SizeOf(Smallint);
      7: // PARAM_DATATYPE
        pLength := SizeOf(Smallint);
      8: // PARAM_SUBTYPE
        pLength := SizeOf(Smallint);
      9: // PARAM_TYPENAME
        pLength := fDataTypeNameLenMax;
      10: // PARAM_PRECISION
        pLength := SizeOf(Integer);
      11: // PARAM_SCALE
        pLength := SizeOf(Smallint);
      12: // PARAM_LENGTH
        pLength := SizeOf(Integer);
      13: // PARAM_NULLABLE
        pLength := SizeOf(Smallint);
      {+2.01}//Vadim V.Lopushansky: add support of PARAM_POSITION
      14: // PARAM_POSITION
        pLength := SizeOf(Smallint);
      {/+2.01}
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataProcedureParams.getColumnLength invalid column no: '
        + IntToStr(ColumnNumber));
    end;
    {+2.01}
    // Vadim V.Lopushansky:
    // If length is equal 0 that Delphi will ignore this column.
    // It is bad, since the column describes the metadata.
    if (pLength = 0) and (ProcedureParamColumnTypes[ColumnNumber] = fldZSTRING) then
      pLength := 1;
    {/+2.01}
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      pLength := 0;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedureParams.getColumnLength', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedureParams.getColumnLength', ['pLength=', pLength]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedureParams.getColumnPrecision(
  ColumnNumber: Word; var piPrecision: Smallint): SQLResult;
var
  Length: Longword;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedureParams.getColumnPrecision', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Result := getColumnLength(ColumnNumber, Length);
  piPrecision := Length;
  {+2.01}
  //Vadim V.Lopushansky: Problems with loss of accuracy at type conversion
  // Edward> ???Ed>Vad: SqlProcedureColumns should never return such a long column
  if Length < Longword(High(Smallint)) then
    piPrecision := Length
  else
    piPrecision := -1;
  {/+2.01}
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedureParams.getColumnPrecision', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedureParams.getColumnPrecision', ['piPrecision', piPrecision]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedureParams.getLong(ColumnNumber: Word;
  Value: Pointer; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedureParams.getLong', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case ColumnNumber of
      1: // RECNO
        begin
          Integer(Value^) := fRowNo;
          IsBlank := False;
        end;
      10: // PARAM_PRECISION
        begin
          Integer(Value^) := fMetaProcedureParamCurrent.fPrecision;
          IsBlank := False;
        end;
      12: // PARAM_LENGTH
        begin
          Integer(Value^) := fMetaProcedureParamCurrent.fLength;
          IsBlank := False;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataProcedures.getLong invalid column no: '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      Integer(Value^) := 0;
      IsBlank := True;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedureParams.getLong', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedureParams.getLong', ['Value=', Integer(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedureParams.getShort(ColumnNumber: Word;
  Value: Pointer; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedureParams.getShort', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case ColumnNumber of
      6: // PARAM_TYPE
        begin
          Smallint(Value^) := Smallint(fMetaProcedureParamCurrent.fParamType);
          IsBlank := False;
        end;
      7: // PARAM_DATATYPE
        begin
          Smallint(Value^) := fMetaProcedureParamCurrent.fDataType;
          IsBlank := False;
        end;
      8: // PARAM_SUBTYPE
        begin
          Smallint(Value^) := fMetaProcedureParamCurrent.fDataSubType;
          IsBlank := False;
        end;
      11: // PARAM_SCALE
        begin
          Smallint(Value^) := fMetaProcedureParamCurrent.fScale;
          IsBlank := False;
        end;
      13: // PARAM_NULLABLE
        begin
          Smallint(Value^) := fMetaProcedureParamCurrent.fNullable;
          IsBlank := False;
        end;
      14: // PARAM_POSITION
        begin
          Smallint(Value^) := fMetaProcedureParamCurrent.fPosition;
          IsBlank := False;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataProcedures.getShort invalid column no: '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      Smallint(Value^) := 0;
      IsBlank := True;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedureParams.getShort', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedureParams.getShort', ['Value=', Smallint(Value^), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedureParams.getString(ColumnNumber: Word;
  Value: Pointer; var IsBlank: LongBool): SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedureParams.getString', ['ColumnNumber=', ColumnNumber]); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  if Value=nil then
  begin
    Result := DBXERR_INVALIDPARAM;
    exit;
  end;
  try
    case ColumnNumber of
      2: // CATALOG_NAME
        begin
          IsBlank := fMetaProcedureParamCurrent.fMetaProcedure.fCat = nil;
          if not IsBlank then
            StrCopy(Value, fMetaProcedureParamCurrent.fMetaProcedure.fCat)
          else
            PChar(Value)^ := #0;
        end;
      3: // SCHEMA_NAME
        begin
          IsBlank := fMetaProcedureParamCurrent.fMetaProcedure.fSchema = nil;
          if not IsBlank then
            StrCopy(Value, fMetaProcedureParamCurrent.fMetaProcedure.fSchema)
          else
            PChar(Value)^ := #0;
        end;
      4: // PROC_NAME
        begin
          IsBlank := fMetaProcedureParamCurrent.fMetaProcedure.fProcName = nil;
          if not IsBlank then
            StrCopy(Value, fMetaProcedureParamCurrent.fMetaProcedure.fProcName)
          else
            PChar(Value)^ := #0;
        end;
      5: // PARAM_NAME
        begin
          IsBlank := fMetaProcedureParamCurrent.fParamName = nil;
          if not IsBlank then
            StrCopy(Value, fMetaProcedureParamCurrent.fParamName)
          else
            PChar(Value)^ := #0;
        end;
      9: // PARAM_TYPENAME
        begin
          IsBlank := fMetaProcedureParamCurrent.fDataTypeName = nil;
          if not IsBlank then
            StrCopy(Value, fMetaProcedureParamCurrent.fDataTypeName)
          else
            PChar(Value)^ := #0;
        end;
    else
      raise EDbxInvalidCall.Create(
        'TSqlCursorMetaDataProcedures.getString invalid column no: '
        + IntToStr(ColumnNumber));
    end;
    Result := DBXpress.SQL_SUCCESS;
  except
    on E: Exception{EDbxError} do
    begin
      PChar(Value)^ := #0;
      IsBlank := True;
      fSqlCursorErrorMsg.Add(E.Message);
      Result := MaxReservedStaticErrors + 1;
      {$IFDEF _TRACE_CALLS_} if not (E is EDbxError) then raise; {$ENDIF _TRACE_CALLS_}
    end;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedureParams.getString', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedureParams.getString', ['Value=', PChar(Value), 'IsBlank=', IsBlank]); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TSqlCursorMetaDataProcedureParams.next: SQLResult;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc('TSqlCursorMetaDataProcedureParams.next'); Result := SQL_SUCCESS; try try {$ENDIF _TRACE_CALLS_}
  Inc(fRowNo);
  if Assigned(fProcColumnList) and (fRowNo <= fProcColumnList.Count) then
  begin
    fMetaProcedureParamCurrent := fProcColumnList[fRowNo - 1];
    Result := DBXpress.SQL_SUCCESS;
  end
  else
    Result := DBXERR_EOF;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc('TSqlCursorMetaDataProcedureParams.next', e);  raise; end; end;
    finally LogExitProc('TSqlCursorMetaDataProcedureParams.next'); end;
  {$ENDIF _TRACE_CALLS_}
end;

initialization
begin
{$IFDEF _TRACE_CALLS_}
  LogInfoProc(['** DbxOpenOdbcVersion =', DbxOpenOdbcVersion]);
  LogInfoProc(['** RegExprParser =', {$IFDEF _RegExprParser_}'On'{$ELSE}'Off'{$ENDIF}]);
  LogInfoProc(['** InternalCloneConnection =',{$IFDEF _InternalCloneConnection_}'On'{$ELSE}'Off'{$ENDIF}]);
  LogInfoProc(['** MultiRowsFetch =',{$IFDEF _MULTIROWS_FETCH_}'On'{$ELSE}'Off'{$ENDIF}]);
  LogInfoProc(['** MixedFetch =',{$IFDEF _MIXED_FETCH_}'On'{$ELSE}'Off'{$ENDIF}]);
{$ENDIF _TRACE_CALLS_}
{$IFDEF MSWINDOWS}
  {$IFDEF _DENT_}
    NTRegisterDbXpressLibGS('OPENODBC', @getSQLDriverODBC);
  {$ELSE}
  // This allows option of static linking the DbExpress driver into your app
    SqlExpr.RegisterDbXpressLib(@getSQLDriverODBC);
  {$ENDIF}
{$ENDIF}
end;

finalization
begin
{$IFDEF MSWINDOWS}
  {$IFDEF _DENT_}
    NTUnRegisterDbXpressLibGS('OPENODBC');
  {$ENDIF}
{$ENDIF}
end;

end.
