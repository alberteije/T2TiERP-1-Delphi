{
  Delphi translation of the Microsoft ODBC API headers, ODBC version 3.51
  Version 2.09, 2003-10-07

  Copyright (c) 2001-2003 Edward Benson

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU Lesser General Public License for more details.
}
unit OdbcApi;
{$B-}

//**************************************************************************
//
// ODBC API 3.51
//
// I have merged all the relevant header files into this one file,
// and removed all version specific IFDEFs assuming VERSION 3.51
//   sqltypes.h
//   sql.h
//   sqlext.h
//   sqlucode.h
//   sqltrace.h
//
//
// Initial translation done using
// HeadConv 4.0 (c) 2000 by Bob Swart (aka Dr.Bob - www.drbob42.com)
// Final Delphi-Jedi (Darth) command-line units edition
//
// Created   26-Jun-2001  By Edward Benson
// Modified  28-Nov-2001  By Edward Benson - Minor changes - DbxOodbc v 1.01
// Modified  05-Dec-2001  By Edward Benson - Minor changes - DbxOodbc v 1.02
// Modified  06-Dec-2001  By Edward Benson - Support Kylix - DbxOodbc v 1.03
// Modified  22-Jun-2002  By Edward Benson - UL to ULONG   - DbxOodbc v 1.05
// Modified  01-Nov-2002  By Edward Benson - DbxOodbc v 2.01
//   Bojnourdi Kaikavous
//     Support Linux (MSWINDOWS=stdcall Linux=cdecl)
//   Vadim Lopushansky
//     $B-
//   Edward Benson
//     Change const xUL to ULONG(x) (former no longer valid for Delphi 6 SP 1)
//     Various API calls corrected for Delphi
//     Support Borland C++ Builder
// Modified  2002-04-04   Edward Benson    - DbxOodbc v 2.05
//     Type names reformatted to Delphi standard
// Modified  2002-04-16   Edward Benson    - DbxOodbc v 2.06
//     Added non-overlaoded versions of SqlColAttribute, SQLGetInfo
//
//   Edward Benson
//     Borland C++ Builder
//     To avoid linker errors with BCB, you must add ODBC32.LIB to your project.
//     You can create ODBC32.LIB yourself using IMPLIB utility (Import Library)
//     IMPLIB ODBC32.LIB C:\WINNT\SYSTEM32\ODBC32.DLL
//     or use the ODBC32.LIB that I created.
//     But don't forget to also add it to your project.
//
//
//**************************************************************************

{$UNDEF DynamicOdbcImport}
interface

//##########################################################################
// sqltypes.h interface section starts here
// (N.B. no implementation section for sqltypes.h)
//##########################################################################

//******************************************************************
// SQLTYPES.H - This file defines the types used in ODBC
//
// (C) Copyright 1995-1998 By Microsoft Corp.
//
// Created 04/10/95 for 2.50 specification
// Updated 12/11/95 for 3.00 specification
//********************************************************************

// Introduced for convenience
type
  TSqlState = array[0..5] of AnsiChar;
  PSqlState = PAnsiChar;

const
  ODBCVER = $0351;

  // API declaration data types
type
{$EXTERNALSYM SQLCHAR}
  SqlChar = Byte;
  PSqlChar = ^SqlChar;
{$EXTERNALSYM SQLSCHAR}
  SqlSChar = Char;
{$EXTERNALSYM SQLDATE}
  SqlDate = Byte; // ??? Defined in DBXpress SQLDATE = Longint;
{$EXTERNALSYM SQLDECIMAL}
  SqlDecimal = Byte;
{$EXTERNALSYM SQLDOUBLE}
  SqlDouble = Double;
{$EXTERNALSYM SQLFLOAT}
  SqlFloat = Double;
{$EXTERNALSYM SQLINTEGER}
  SqlInteger = Longint;
  PSqlInteger = ^SqlInteger;
{$EXTERNALSYM SQLNUMERIC}
  SqlNumeric = Byte;
{$EXTERNALSYM SQLPOINTER}
  SqlPointer = Pointer;
  PSqlPointer = ^SqlPointer;
{$EXTERNALSYM SQLREAL}
  SqlReal = Single;
{$EXTERNALSYM SQLSMALLINT}
  SqlSmallint = Smallint;
  PSqlSmallint = ^SqlSmallint;
{$EXTERNALSYM SQLUSMALLINT}
  SqlUSmallint = Word;
  PSqlUSmallint = ^SqlUSmallint;
{$EXTERNALSYM SQLTIME}
  SqlTime = Byte; // ??? Defined in DBXpress SQLTIME = Longint;
{$EXTERNALSYM SQLTIMESTAMP}
  SqlTimestamp = Byte;
{$EXTERNALSYM SQLVARCHAR}
  SqlVarchar = Byte;

  // function return type
{$EXTERNALSYM SQLRETURN}
  SqlReturn = SqlSmallint;

  // SQL Handle types
{$EXTERNALSYM SQLHANDLE}
  SqlHandle = Pointer;
  PSqlHandle = ^SqlHandle;
{$EXTERNALSYM SQLHENV}
  SqlHEnv = Pointer;
  PSqlHEnv = ^SqlHEnv;
{$EXTERNALSYM SQLHDBC}
  SqlHDbc = Pointer;
  PSqlHDbc = ^SqlHDbc;
{$EXTERNALSYM SQLHSTMT}
  SqlHStmt = Pointer;
  PSqlHStmt = ^SqlHStmt;
{$EXTERNALSYM SQLHDESC}
  SqlHDesc = Pointer;
  PSqlHDesc = ^SqlHDesc;

  // SQL portable types
{$EXTERNALSYM UCHAR}
  UChar = Byte;
{$EXTERNALSYM SCHAR}
  SChar = Char;
{$EXTERNALSYM SDWORD}
  SDword = Longint;
{$EXTERNALSYM SWORD}
  SWord = Smallint;
{$EXTERNALSYM UDWORD}
  UDword = Longint;
{$EXTERNALSYM UWORD}
  UWord = Word;
  PUWord = ^UWord;
{$EXTERNALSYM SQLUINTEGER}
  SqlUInteger = UDword;
  PSqlUInteger = ^SqlUInteger;
{$EXTERNALSYM SLONG}
  SLong = Longint;
{$EXTERNALSYM SSHORT}
  SShort = Smallint;
{$EXTERNALSYM ULONG}
  ULong = Longint;
{$EXTERNALSYM USHORT}
  UShort = Word;
{$EXTERNALSYM SDOUBLE}
  SDouble = Double;
{$EXTERNALSYM LDOUBLE}
  LDouble = Double;
{$EXTERNALSYM SFLOAT}
  SFloat = Single;
{$EXTERNALSYM PTR}
  Ptr = Pointer;

{$EXTERNALSYM HENV}
  HEnv = Pointer;
{$EXTERNALSYM HDBC}
  HDbc = Pointer;
{$EXTERNALSYM HSTMT}
  HStmt = Pointer;

{$EXTERNALSYM RETCODE}
  Retcode = Smallint;

{$EXTERNALSYM SQLHWND}
  //  SQLHWND = HWND;
  SqlHWnd = Longword;

  // transfer types for DATE, TIME, TIMESTAMP
{$EXTERNALSYM tagDATE_STRUCT}
  tagDATE_STRUCT = packed record
    Year: SqlSmallint;
    Month: SqlUSmallint;
    Day: SqlUSmallint;
  end;
  PSqlDateStruct = ^TSqlDateStruct;
  TSqlDateStruct = tagDATE_STRUCT;
{$EXTERNALSYM SQL_DATE_STRUCT}
  SQL_DATE_STRUCT = tagDATE_STRUCT;

{$EXTERNALSYM tagTIME_STRUCT}
  tagTIME_STRUCT = packed record
    Hour: SqlUSmallint;
    Minute: SqlUSmallint;
    Second: SqlUSmallint;
  end;
  PSqlTimeStruct = ^TSqlTimeStruct;
  TSqlTimeStruct = tagTIME_STRUCT;
{$EXTERNALSYM SQL_TIME_STRUCT}
  SQL_TIME_STRUCT = tagTIME_STRUCT;

{$EXTERNALSYM tagTIMESTAMP_STRUCT}
  tagTIMESTAMP_STRUCT = packed record
    Year: SqlSmallint;
    Month: SqlUSmallint;
    Day: SqlUSmallint;
    Hour: SqlUSmallint;
    Minute: SqlUSmallint;
    Second: SqlUSmallint;
    Fraction: SqlUInteger;
  end;

{$EXTERNALSYM SQL_TIMESTAMP_STRUCT}
  SQL_TIMESTAMP_STRUCT = tagTIMESTAMP_STRUCT;
  POdbcTimestamp = ^TOdbcTimestamp;
  TOdbcTimestamp = tagTIMESTAMP_STRUCT;

  // enumerations for DATETIME_INTERVAL_SUBCODE values for interval data types
  // these values are from SQL-92
{$EXTERNALSYM SQLINTERVAL}
  SqlInterval = (
    SQL_IS_DUMMY {placeholder for 0},
    SQL_IS_YEAR {= 1},
    SQL_IS_MONTH {= 2},
    SQL_IS_DAY {= 3},
    SQL_IS_HOUR {= 4},
    SQL_IS_MINUTE {= 5},
    SQL_IS_SECOND {= 6},
    SQL_IS_YEAR_TO_MONTH {= 7},
    SQL_IS_DAY_TO_HOUR {= 8},
    SQL_IS_DAY_TO_MINUTE {= 9},
    SQL_IS_DAY_TO_SECOND {= 10},
    SQL_IS_HOUR_TO_MINUTE {= 11},
    SQL_IS_HOUR_TO_SECOND {= 12},
    SQL_IS_MINUTE_TO_SECOND {= 13});
  ESqlInterval = SqlInterval;

{$EXTERNALSYM tagSQL_YEAR_MONTH}
  tagSQL_YEAR_MONTH = packed record
    Year: SqlUInteger;
    Month: SqlUInteger;
  end;
  TSqlYearMonth = tagSQL_YEAR_MONTH;

{$EXTERNALSYM tagSQL_DAY_SECOND}
  tagSQL_DAY_SECOND = packed record
    Day: SqlUInteger;
    Hour: SqlUInteger;
    Minute: SqlUInteger;
    Second: SqlUInteger;
    Fraction: SqlUInteger;
  end;
  TSqlDaySecond = tagSQL_DAY_SECOND;

{$EXTERNALSYM tagSQL_INTERVAL_STRUCT}
  tagSQL_INTERVAL_STRUCT = packed record
    interval_type: SqlInterval;
    interval_sign: SqlSmallint;
    case ESqlInterval of
      SQL_IS_YEAR_TO_MONTH: (YearMonth: TSqlYearMonth);
      SQL_IS_DAY_TO_SECOND: (DaySecond: TSqlDaySecond);
  end;
  TSqlInterval = tagSQL_INTERVAL_STRUCT;

{$EXTERNALSYM ODBCINT64}
  OdbcInt64 = Int64;
{$EXTERNALSYM SQLBIGINT}
  SqlBigint = OdbcInt64;
{$EXTERNALSYM SQLUBIGINT}
  SqlUBigint = OdbcInt64;

  // internal representation of numeric data type
const
{$EXTERNALSYM SQL_MAX_NUMERIC_LEN}
  SQL_MAX_NUMERIC_LEN = 16;

type
{$EXTERNALSYM tagSQL_NUMERIC_STRUCT}
  tagSQL_NUMERIC_STRUCT = packed record
    Precision: SqlChar;
    Scale: SqlSChar;
    Sign: SqlChar; {= 1 if positive, 0 if negative }
    Val: array[0..SQL_MAX_NUMERIC_LEN - 1] of SqlChar;
  end;

{$EXTERNALSYM SQLGUID}
  SqlGuid = TGUID;

{$EXTERNALSYM BOOKMARK}
  Bookmark = Longint;

  //  SQLWCHAR = Word;
{$EXTERNALSYM SQLWCHAR}
  SqlWChar = WideChar; { WideCharacter - word-sized Unicode character }
  PSqlWChar = ^SqlWChar;

{$EXTERNALSYM SQLTCHAR}
{$IFDEF UNICODE}
  SqlTChar = SqlWChar;
{$ELSE}
  SqlTChar = SqlChar;
{$ENDIF} {UNICODE}

  //##########################################################################
  // sqltypes.h interface section ends here
  // (no implemetation section for sqltypes.h)
  //##########################################################################

  //##########################################################################
  // sql.h interface part starts here
  //##########################################################################

  //****************************************************************
  // SQL.H - This is the the main include for ODBC Core functions.
  //
  // preconditions:
  // INCLUDE "windows.h"
  //
  // (C) Copyright 1990 - 1998 By Microsoft Corp.
  //
  // Updated 5/12/93 for 2.00 specification
  // Updated 5/23/94 for 2.01 specification
  // Updated 11/10/94 for 2.10 specification
  // Updated 04/10/95 for 2.50 specification
  // Updated 6/6/95 for 3.00 specification
  // Updated 10/22/97 for 3.51 specification
  //********************************************************************

  // All version-specific IFDEFs removed, and assume ODBC Version 3.51

const
  // special length/indicator values
  SQL_NULL_DATA = (-1); //??? Defined in DBXpress: SQL_NULL_DATA = 100;
  SQL_DATA_AT_EXEC = (-2);

  // return values from functions
  SQL_SUCCESS = 0; //??? Defined in DBXpress: SQL_SUCCESS = $0000;
  SQL_SUCCESS_WITH_INFO = 1;
  SQL_NO_DATA = 100;
  SQL_ERROR = (-1); //??? Defined in DBXpress: SQL_ERROR = -1;
  SQL_INVALID_HANDLE = (-2);
  SQL_STILL_EXECUTING = 2;
  SQL_NEED_DATA = 99;

  // MACRO
  // test for SQL_SUCCESS or SQL_SUCCESS_WITH_INFO
function SQL_SUCCEEDED(const rc: SqlReturn): Boolean;

const
  // flags for null-terminated string
  SQL_NTS = (-3);
  SQL_NTSL = (-3);

  // maximum message length
  SQL_MAX_MESSAGE_LENGTH = 512;

  // date/time length constants
  SQL_DATE_LEN = 10;
  SQL_TIME_LEN = 8; // add P+1 if precision is nonzero
  SQL_TIMESTAMP_LEN = 19; // add P+1 if precision is nonzero

  // handle type identifiers
  SQL_HANDLE_ENV = 1;
  SQL_HANDLE_DBC = 2;
  SQL_HANDLE_STMT = 3;
  SQL_HANDLE_DESC = 4;

  // environment attribute
  SQL_ATTR_OUTPUT_NTS = 10001;

  // connection attributes
  SQL_ATTR_AUTO_IPD = 10001;
  SQL_ATTR_METADATA_ID = 10014;

  // statement attributes
  SQL_ATTR_APP_ROW_DESC = 10010;
  SQL_ATTR_APP_PARAM_DESC = 10011;
  SQL_ATTR_IMP_ROW_DESC = 10012;
  SQL_ATTR_IMP_PARAM_DESC = 10013;
  SQL_ATTR_CURSOR_SCROLLABLE = (-1);
  SQL_ATTR_CURSOR_SENSITIVITY = (-2);

  // SQL_ATTR_CURSOR_SCROLLABLE values
  SQL_NONSCROLLABLE = 0;
  SQL_SCROLLABLE = 1;

  // identifiers of fields in the SQL descriptor
  SQL_DESC_COUNT = 1001;
  SQL_DESC_TYPE = 1002;
  SQL_DESC_LENGTH = 1003;
  SQL_DESC_OCTET_LENGTH_PTR = 1004;
  SQL_DESC_PRECISION = 1005;
  SQL_DESC_SCALE = 1006;
  SQL_DESC_DATETIME_INTERVAL_CODE = 1007;
  SQL_DESC_NULLABLE = 1008;
  SQL_DESC_INDICATOR_PTR = 1009;
  SQL_DESC_DATA_PTR = 1010;
  SQL_DESC_NAME = 1011;
  SQL_DESC_UNNAMED = 1012;
  SQL_DESC_OCTET_LENGTH = 1013;
  SQL_DESC_ALLOC_TYPE = 1099;

  // identifiers of fields in the diagnostics area*
  SQL_DIAG_RETURNCODE = 1;
  SQL_DIAG_NUMBER = 2;
  SQL_DIAG_ROW_COUNT = 3;
  SQL_DIAG_SQLSTATE = 4;
  SQL_DIAG_NATIVE = 5;
  SQL_DIAG_MESSAGE_TEXT = 6;
  SQL_DIAG_DYNAMIC_FUNCTION = 7;
  SQL_DIAG_CLASS_ORIGIN = 8;
  SQL_DIAG_SUBCLASS_ORIGIN = 9;
  SQL_DIAG_CONNECTION_NAME = 10;
  SQL_DIAG_SERVER_NAME = 11;
  SQL_DIAG_DYNAMIC_FUNCTION_CODE = 12;

  // dynamic function codes
  SQL_DIAG_ALTER_DOMAIN = 3;
  SQL_DIAG_ALTER_TABLE = 4;
  SQL_DIAG_CALL = 7;
  SQL_DIAG_CREATE_ASSERTION = 6;
  SQL_DIAG_CREATE_CHARACTER_SET = 8;
  SQL_DIAG_CREATE_COLLATION = 10;
  SQL_DIAG_CREATE_DOMAIN = 23;
  SQL_DIAG_CREATE_INDEX = (-1);
  SQL_DIAG_CREATE_SCHEMA = 64;
  SQL_DIAG_CREATE_TABLE = 77;
  SQL_DIAG_CREATE_TRANSLATION = 79;
  SQL_DIAG_CREATE_VIEW = 84;
  SQL_DIAG_DELETE_WHERE = 19;
  SQL_DIAG_DROP_ASSERTION = 24;
  SQL_DIAG_DROP_CHARACTER_SET = 25;
  SQL_DIAG_DROP_COLLATION = 26;
  SQL_DIAG_DROP_DOMAIN = 27;
  SQL_DIAG_DROP_INDEX = (-2);
  SQL_DIAG_DROP_SCHEMA = 31;
  SQL_DIAG_DROP_TABLE = 32;
  SQL_DIAG_DROP_TRANSLATION = 33;
  SQL_DIAG_DROP_VIEW = 36;
  SQL_DIAG_DYNAMIC_DELETE_CURSOR = 38;
  SQL_DIAG_DYNAMIC_UPDATE_CURSOR = 81;
  SQL_DIAG_GRANT = 48;
  SQL_DIAG_INSERT = 50;
  SQL_DIAG_REVOKE = 59;
  SQL_DIAG_SELECT_CURSOR = 85;
  SQL_DIAG_UNKNOWN_STATEMENT = 0;
  SQL_DIAG_UPDATE_WHERE = 82;

  // SQL data type codes
  SQL_UNKNOWN_TYPE = 0;
  SQL_CHAR = 1;
  SQL_NUMERIC = 2;
  SQL_DECIMAL = 3;
  SQL_INTEGER = 4;
  SQL_SMALLINT = 5;
  SQL_FLOAT = 6;
  SQL_REAL = 7;
  SQL_DOUBLE = 8;
  SQL_DATETIME = 9;
  SQL_VARCHAR = 12;

  // One-parameter shortcuts for date/time data types
  SQL_TYPE_DATE = 91;
  SQL_TYPE_TIME = 92;
  SQL_TYPE_TIMESTAMP = 93;

  // Statement attribute values for cursor sensitivity
  SQL_UNSPECIFIED = 0;
  SQL_INSENSITIVE = 1;
  SQL_SENSITIVE = 2;

  // GetTypeInfo() request for all data types
  SQL_ALL_TYPES = 0;

  // Default conversion code for SQLBindCol(), SQLBindParam() and SQLGetData()
  SQL_DEFAULT = 99;

  // SQLGetData() code indicating that the application row descriptor
  // specifies the data type
  SQL_ARD_TYPE = (-99);

  // SQL date/time type subcodes
  SQL_CODE_DATE = 1;
  SQL_CODE_TIME = 2;
  SQL_CODE_TIMESTAMP = 3;

  // CLI option values
  SQL_FALSE = 0;
  SQL_TRUE = 1;

  // values of NULLABLE field in descriptor
  SQL_NO_NULLS = 0;
  SQL_NULLABLE = 1;

  // Value returned by SQLGetTypeInfo() to denote that it is
  // not known whether or not a data type supports null values.
  SQL_NULLABLE_UNKNOWN = 2;

  // Values returned by SQLGetTypeInfo() to show WHERE clause supported
  SQL_PRED_NONE = 0;
const
  SQL_PRED_CHAR = 1;
const
  SQL_PRED_BASIC = 2;

  // values of UNNAMED field in descriptor
  SQL_NAMED = 0;
  SQL_UNNAMED = 1;

  // values of ALLOC_TYPE field in descriptor
  SQL_DESC_ALLOC_AUTO = 1;
  SQL_DESC_ALLOC_USER = 2;

  // FreeStmt() options
  SQL_CLOSE = 0;
  SQL_DROP = 1;
  SQL_UNBIND = 2;
  SQL_RESET_PARAMS = 3;

  // Codes used for FetchOrientation in SQLFetchScroll(), and in SQLDataSources()
  SQL_FETCH_NEXT = 1;
  SQL_FETCH_FIRST = 2;

  // Other codes used for FetchOrientation in SQLFetchScroll()
  SQL_FETCH_LAST = 3;
  SQL_FETCH_PRIOR = 4;
  SQL_FETCH_ABSOLUTE = 5;
  SQL_FETCH_RELATIVE = 6;

  // SQLEndTran() options
  SQL_COMMIT = 0;
  SQL_ROLLBACK = 1;

  // null handles returned by SQLAllocHandle()
  SQL_NULL_HENV = SqlHandle(0);
  SQL_NULL_HDBC = SqlHandle(0);
  SQL_NULL_HSTMT = SqlHandle(0);
  SQL_NULL_HDESC = SqlHandle(0);

  // null handle used in place of parent handle when allocating HENV
  SQL_NULL_HANDLE = SqlHandle(0);

  // Values that may appear in the result set of SQLSpecialColumns()
  SQL_SCOPE_CURROW = 0;
  SQL_SCOPE_TRANSACTION = 1;
  SQL_SCOPE_SESSION = 2;
  SQL_PC_UNKNOWN = 0;
  SQL_PC_NON_PSEUDO = 1;
  SQL_PC_PSEUDO = 2;

  // Reserved value for the IdentifierType argument of SQLSpecialColumns()
  SQL_ROW_IDENTIFIER = 1;

  // Reserved values for UNIQUE argument of SQLStatistics()
  SQL_INDEX_UNIQUE = 0;
  SQL_INDEX_ALL = 1;

  // Values that may appear in the result set of SQLStatistics()
  SQL_INDEX_CLUSTERED = 1;
  SQL_INDEX_HASHED = 2;
  SQL_INDEX_OTHER = 3;

  // SQLGetFunctions() values to identify ODBC APIs
  SQL_API_SQLALLOCCONNECT = 1;
  SQL_API_SQLALLOCENV = 2;
  SQL_API_SQLALLOCHANDLE = 1001;
  SQL_API_SQLALLOCSTMT = 3;
  SQL_API_SQLBINDCOL = 4;
  SQL_API_SQLBINDPARAM = 1002;
  SQL_API_SQLCANCEL = 5;
  SQL_API_SQLCLOSECURSOR = 1003;
  SQL_API_SQLCOLATTRIBUTE = 6;
  SQL_API_SQLCOLUMNS = 40;
  SQL_API_SQLCONNECT = 7;
  SQL_API_SQLCOPYDESC = 1004;
  SQL_API_SQLDATASOURCES = 57;
  SQL_API_SQLDESCRIBECOL = 8;
  SQL_API_SQLDISCONNECT = 9;
  SQL_API_SQLENDTRAN = 1005;
  SQL_API_SQLERROR = 10;
  SQL_API_SQLEXECDIRECT = 11;
  SQL_API_SQLEXECUTE = 12;
  SQL_API_SQLFETCH = 13;
  SQL_API_SQLFETCHSCROLL = 1021;
  SQL_API_SQLFREECONNECT = 14;
  SQL_API_SQLFREEENV = 15;
  SQL_API_SQLFREEHANDLE = 1006;
  SQL_API_SQLFREESTMT = 16;
  SQL_API_SQLGETCONNECTATTR = 1007;
  SQL_API_SQLGETCONNECTOPTION = 42;
  SQL_API_SQLGETCURSORNAME = 17;
  SQL_API_SQLGETDATA = 43;
  SQL_API_SQLGETDESCFIELD = 1008;
  SQL_API_SQLGETDESCREC = 1009;
  SQL_API_SQLGETDIAGFIELD = 1010;
  SQL_API_SQLGETDIAGREC = 1011;
  SQL_API_SQLGETENVATTR = 1012;
  SQL_API_SQLGETFUNCTIONS = 44;
  SQL_API_SQLGETINFO = 45;
  SQL_API_SQLGETSTMTATTR = 1014;
  SQL_API_SQLGETSTMTOPTION = 46;
  SQL_API_SQLGETTYPEINFO = 47;
  SQL_API_SQLNUMRESULTCOLS = 18;
  SQL_API_SQLPARAMDATA = 48;
  SQL_API_SQLPREPARE = 19;
  SQL_API_SQLPUTDATA = 49;
  SQL_API_SQLROWCOUNT = 20;
  SQL_API_SQLSETCONNECTATTR = 1016;
  SQL_API_SQLSETCONNECTOPTION = 50;
  SQL_API_SQLSETCURSORNAME = 21;
  SQL_API_SQLSETDESCFIELD = 1017;
  SQL_API_SQLSETDESCREC = 1018;
  SQL_API_SQLSETENVATTR = 1019;
  SQL_API_SQLSETPARAM = 22;
  SQL_API_SQLSETSTMTATTR = 1020;
  SQL_API_SQLSETSTMTOPTION = 51;
  SQL_API_SQLSPECIALCOLUMNS = 52;
  SQL_API_SQLSTATISTICS = 53;
  SQL_API_SQLTABLES = 54;
  SQL_API_SQLTRANSACT = 23;

  // Information requested by SQLGetInfo()
  SQL_MAX_DRIVER_CONNECTIONS = 0;
  SQL_MAXIMUM_DRIVER_CONNECTIONS = SQL_MAX_DRIVER_CONNECTIONS;
  SQL_MAX_CONCURRENT_ACTIVITIES = 1;
  SQL_MAXIMUM_CONCURRENT_ACTIVITIES = SQL_MAX_CONCURRENT_ACTIVITIES;
  SQL_DATA_SOURCE_NAME = 2;
  SQL_FETCH_DIRECTION = 8;
  SQL_SERVER_NAME = 13;
  SQL_SEARCH_PATTERN_ESCAPE = 14;
  SQL_DBMS_NAME = 17;
  SQL_DBMS_VER = 18;
  SQL_ACCESSIBLE_TABLES = 19;
  SQL_ACCESSIBLE_PROCEDURES = 20;
  SQL_CURSOR_COMMIT_BEHAVIOR = 23;
  SQL_DATA_SOURCE_READ_ONLY = 25;
  SQL_DEFAULT_TXN_ISOLATION = 26;
  SQL_IDENTIFIER_CASE = 28;
  SQL_IDENTIFIER_QUOTE_CHAR = 29;
  SQL_MAX_COLUMN_NAME_LEN = 30;
  SQL_MAXIMUM_COLUMN_NAME_LENGTH = SQL_MAX_COLUMN_NAME_LEN;
  SQL_MAX_CURSOR_NAME_LEN = 31;
  SQL_MAXIMUM_CURSOR_NAME_LENGTH = SQL_MAX_CURSOR_NAME_LEN;
  SQL_MAX_SCHEMA_NAME_LEN = 32;
  SQL_MAXIMUM_SCHEMA_NAME_LENGTH = SQL_MAX_SCHEMA_NAME_LEN;
  SQL_MAX_CATALOG_NAME_LEN = 34;
  SQL_MAXIMUM_CATALOG_NAME_LENGTH = SQL_MAX_CATALOG_NAME_LEN;
  SQL_MAX_TABLE_NAME_LEN = 35;
  SQL_SCROLL_CONCURRENCY = 43;
  SQL_TXN_CAPABLE = 46;
  SQL_TRANSACTION_CAPABLE = SQL_TXN_CAPABLE;
  SQL_USER_NAME = 47;
  SQL_TXN_ISOLATION_OPTION = 72;
  SQL_TRANSACTION_ISOLATION_OPTION = SQL_TXN_ISOLATION_OPTION;
  SQL_INTEGRITY = 73;
  SQL_GETDATA_EXTENSIONS = 81;
  SQL_NULL_COLLATION = 85;
  SQL_ALTER_TABLE = 86;
  SQL_ORDER_BY_COLUMNS_IN_SELECT = 90;
  SQL_SPECIAL_CHARACTERS = 94;
  SQL_MAX_COLUMNS_IN_GROUP_BY = 97;
  SQL_MAXIMUM_COLUMNS_IN_GROUP_BY = SQL_MAX_COLUMNS_IN_GROUP_BY;
  SQL_MAX_COLUMNS_IN_INDEX = 98;
  SQL_MAXIMUM_COLUMNS_IN_INDEX = SQL_MAX_COLUMNS_IN_INDEX;
  SQL_MAX_COLUMNS_IN_ORDER_BY = 99;
  SQL_MAXIMUM_COLUMNS_IN_ORDER_BY = SQL_MAX_COLUMNS_IN_ORDER_BY;
  SQL_MAX_COLUMNS_IN_SELECT = 100;
  SQL_MAXIMUM_COLUMNS_IN_SELECT = SQL_MAX_COLUMNS_IN_SELECT;
  SQL_MAX_COLUMNS_IN_TABLE = 101;
  SQL_MAX_INDEX_SIZE = 102;
  SQL_MAXIMUM_INDEX_SIZE = SQL_MAX_INDEX_SIZE;
  SQL_MAX_ROW_SIZE = 104;
  SQL_MAXIMUM_ROW_SIZE = SQL_MAX_ROW_SIZE;
  SQL_MAX_STATEMENT_LEN = 105;
  SQL_MAXIMUM_STATEMENT_LENGTH = SQL_MAX_STATEMENT_LEN;
  SQL_MAX_TABLES_IN_SELECT = 106;
  SQL_MAXIMUM_TABLES_IN_SELECT = SQL_MAX_TABLES_IN_SELECT;
  SQL_MAX_USER_NAME_LEN = 107;
  SQL_MAXIMUM_USER_NAME_LENGTH = SQL_MAX_USER_NAME_LEN;
  SQL_OJ_CAPABILITIES = 115;
  SQL_OUTER_JOIN_CAPABILITIES = SQL_OJ_CAPABILITIES;
  SQL_XOPEN_CLI_YEAR = 10000;
  SQL_CURSOR_SENSITIVITY = 10001;
  SQL_DESCRIBE_PARAMETER = 10002;
  SQL_CATALOG_NAME = 10003;
  SQL_COLLATION_SEQ = 10004;
  SQL_MAX_IDENTIFIER_LEN = 10005;
  SQL_MAXIMUM_IDENTIFIER_LENGTH = SQL_MAX_IDENTIFIER_LEN;

  // SQL_ALTER_TABLE bitmasks
  SQL_AT_ADD_COLUMN = $00000001;
  SQL_AT_DROP_COLUMN = $00000002;
  SQL_AT_ADD_CONSTRAINT = $00000008;

  // The following bitmasks are ODBC extensions and defined in sqlext.h
  SQL_AT_COLUMN_SINGLE = $00000020;
  SQL_AT_ADD_COLUMN_DEFAULT = $00000040;
  SQL_AT_ADD_COLUMN_COLLATION = $00000080;
  SQL_AT_SET_COLUMN_DEFAULT = $00000100;
  SQL_AT_DROP_COLUMN_DEFAULT = $00000200;
  SQL_AT_DROP_COLUMN_CASCADE = $00000400;
  SQL_AT_DROP_COLUMN_RESTRICT = $00000800;
  SQL_AT_ADD_TABLE_CONSTRAINT = $00001000;
  SQL_AT_DROP_TABLE_CONSTRAINT_CASCADE = $00002000;
  SQL_AT_DROP_TABLE_CONSTRAINT_RESTRICT = $00004000;
  SQL_AT_CONSTRAINT_NAME_DEFINITION = $00008000;
  SQL_AT_CONSTRAINT_INITIALLY_DEFERRED = $00010000;
  SQL_AT_CONSTRAINT_INITIALLY_IMMEDIATE = $00020000;
  SQL_AT_CONSTRAINT_DEFERRABLE = $00040000;
  SQL_AT_CONSTRAINT_NON_DEFERRABLE = $00080000;

  // SQL_ASYNC_MODE values
  SQL_AM_NONE = 0;
  SQL_AM_CONNECTION = 1;
  SQL_AM_STATEMENT = 2;

  // SQL_CURSOR_COMMIT_BEHAVIOR values
  SQL_CB_DELETE = 0;
  SQL_CB_CLOSE = 1;
  SQL_CB_PRESERVE = 2;

  // SQL_FETCH_DIRECTION bitmasks
  SQL_FD_FETCH_NEXT = $00000001;
  SQL_FD_FETCH_FIRST = $00000002;
  SQL_FD_FETCH_LAST = $00000004;
  SQL_FD_FETCH_PRIOR = $00000008;
  SQL_FD_FETCH_ABSOLUTE = $00000010;
  SQL_FD_FETCH_RELATIVE = $00000020;

  // SQL_GETDATA_EXTENSIONS bitmasks
  SQL_GD_ANY_COLUMN = $00000001;
  SQL_GD_ANY_ORDER = $00000002;

  // SQL_IDENTIFIER_CASE values
  SQL_IC_UPPER = 1;
  SQL_IC_LOWER = 2;
  SQL_IC_SENSITIVE = 3;
  SQL_IC_MIXED = 4;

  // SQL_OJ_CAPABILITIES bitmasks
  // NB: this means 'outer join', not what you may be thinking
  SQL_OJ_LEFT = $00000001;
  SQL_OJ_RIGHT = $00000002;
  SQL_OJ_FULL = $00000004;
  SQL_OJ_NESTED = $00000008;
  SQL_OJ_NOT_ORDERED = $00000010;
  SQL_OJ_INNER = $00000020;
  SQL_OJ_ALL_COMPARISON_OPS = $00000040;

  // SQL_SCROLL_CONCURRENCY bitmasks
  SQL_SCCO_READ_ONLY = $00000001;
  SQL_SCCO_LOCK = $00000002;
  SQL_SCCO_OPT_ROWVER = $00000004;
  SQL_SCCO_OPT_VALUES = $00000008;

  // SQL_TXN_CAPABLE values
  SQL_TC_NONE = 0;
  SQL_TC_DML = 1;
  SQL_TC_ALL = 2;
  SQL_TC_DDL_COMMIT = 3;
  SQL_TC_DDL_IGNORE = 4;

  // SQL_TXN_ISOLATION_OPTION bitmasks
  SQL_TXN_READ_UNCOMMITTED = $00000001;
  SQL_TRANSACTION_READ_UNCOMMITTED = SQL_TXN_READ_UNCOMMITTED;
  SQL_TXN_READ_COMMITTED = $00000002;
  SQL_TRANSACTION_READ_COMMITTED = SQL_TXN_READ_COMMITTED;
  SQL_TXN_REPEATABLE_READ = $00000004;
  SQL_TRANSACTION_REPEATABLE_READ = SQL_TXN_REPEATABLE_READ;
  SQL_TXN_SERIALIZABLE = $00000008;
  SQL_TRANSACTION_SERIALIZABLE = SQL_TXN_SERIALIZABLE;

  // SQL_NULL_COLLATION values
  SQL_NC_HIGH = 0;
  SQL_NC_LOW = 1;

{$IFDEF DynamicOdbcImport}
type
  TSQLAllocConnect = function(
{$ELSE}
function SQLAllocConnect(
{$ENDIF}
  EnvironmentHandle: SqlHEnv;
  var ConnectionHandle: SqlHDbc
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLAllocEnv = function(
{$ELSE}
function SQLAllocEnv(
{$ENDIF}
  var EnvironmentHandle: SqlHEnv
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLAllocHandle = function(
{$ELSE}
function SQLAllocHandle(
{$ENDIF}
  HandleType: SqlSmallint;
  InputHandle: SqlHandle;
  var OutputHandle: SqlHandle
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
type
  TSQLAllocStmt = function(
{$ELSE}
function SQLAllocStmt(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  var StatementHandle: SqlHStmt
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLBindCol = function(
{$ELSE}
function SQLBindCol(
{$ENDIF}
  StatementHandle: SqlHStmt;
  ColumnNumber: SqlUSmallint;
  TargetType: SqlSmallint;
  TargetValue: SqlPointer;
  BufferLength: SqlInteger;
  StrLen_or_Ind: PSqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLBindParam = function(
{$ELSE}
function SQLBindParam(
{$ENDIF}
  StatementHandle: SqlHStmt;
  ParameterNumber: SqlUSmallint;
  ValueType: SqlSmallint;
  ParameterType: SqlSmallint;
  LengthPrecision: SqlUInteger;
  ParameterScale: SqlSmallint;
  ParameterValue: SqlPointer;
  var StrLen_or_Ind: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLCancel = function(
{$ELSE}
function SQLCancel(
{$ENDIF}
  StatementHandle: SqlHStmt
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLCloseCursor = function(
{$ELSE}
function SQLCloseCursor(
{$ENDIF}
  StatementHandle: SqlHStmt
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

// SQLColAttribute is overloaded

{$IFDEF DynamicOdbcImport}
TSQLColAttribute = function(
{$ELSE}
function SQLColAttribute(
{$ENDIF}
  StatementHandle: SqlHStmt;
  ColumnNumber: SqlUSmallint;
  FieldIdentifier: SqlUSmallint;
  CharacterAttribute: SqlPointer;
  BufferLength: SqlSmallint;
  StringLength: pSqlSmallint;
  NumericAttributePtr: SqlPointer
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLColAttributeString = function(
{$ELSE}
function SQLColAttributeString(
{$ENDIF}
// Overloaded version for String attributes
  StatementHandle: SqlHStmt;
  ColumnNumber: SqlUSmallint;
  FieldIdentifier: SqlUSmallint;
  CharacterAttribute: SqlPointer;
  BufferLength: SqlSmallint;
  var StringLength: SqlSmallint;
  NumericAttribute: SqlPointer
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLColAttributeInt = function(
{$ELSE}
function SQLColAttributeInt(
{$ENDIF}
// Overloaded version for Integer attributes
  StatementHandle: SqlHStmt;
  ColumnNumber: SqlUSmallint;
  FieldIdentifier: SqlUSmallint;
  CharacterAttribute: SqlPointer;
  BufferLength: SqlSmallint;
  StringLength: pSqlSmallint;
  var NumericAttribute: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLColumns = function(
{$ELSE}
function SQLColumns(
{$ENDIF}
  StatementHandle: SqlHStmt;
  CatalogName: PAnsiChar;
  NameLength1: SqlSmallint;
  SchemaName: PAnsiChar;
  NameLength2: SqlSmallint;
  TableName: PAnsiChar;
  NameLength3: SqlSmallint;
  ColumnName: PAnsiChar;
  NameLength4: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLConnect = function(
{$ELSE}
function SQLConnect(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  ServerName: PAnsiChar;
  NameLength1: SqlSmallint;
  UserName: PAnsiChar;
  NameLength2: SqlSmallint;
  Authentication: PAnsiChar;
  NameLength3: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLCopyDesc = function(
{$ELSE}
function SQLCopyDesc(
{$ENDIF}
  SourceDescHandle: SqlHDesc;
  TargetDescHandle: SqlHDesc
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLDataSources = function(
{$ELSE}
function SQLDataSources(
{$ENDIF}
  EnvironmentHandle: SqlHEnv;
  Direction: SqlUSmallint;
  var ServerName: SqlChar;
  BufferLength1: SqlSmallint;
  var NameLength1: SqlSmallint;
  var Description: SqlChar;
  BufferLength2: SqlSmallint;
  var NameLength2: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLDescribeCol = function(
{$ELSE}
function SQLDescribeCol(
{$ENDIF}
  StatementHandle: SqlHStmt;
  ColumnNumber: SqlUSmallint;
  ColumnName: PAnsiChar;
  BufferLength: SqlSmallint;
  var NameLength: SqlSmallint;
  var DataType: SqlSmallint;
  var ColumnSize: SqlUInteger;
  var DecimalDigits: SqlSmallint;
  var Nullable: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLDisconnect = function(
{$ELSE}
function SQLDisconnect(
{$ENDIF}
  ConnectionHandle: SqlHDbc
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLEndTran = function(
{$ELSE}
function SQLEndTran(
{$ENDIF}
  HandleType: SqlSmallint;
  Handle: SqlHandle;
  CompletionType: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLError = function(
{$ELSE}
function SQLError(
{$ENDIF}
  EnvironmentHandle: SqlHEnv;
  ConnectionHandle: SqlHDbc;
  StatementHandle: SqlHStmt;
  var Sqlstate: SqlChar;
  var NativeError: SqlInteger;
  var MessageText: SqlChar;
  BufferLength: SqlSmallint;
  var TextLength: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLExecDirect = function(
{$ELSE}
function SQLExecDirect(
{$ENDIF}
  StatementHandle: SqlHStmt;
  StatementText: PAnsiChar;
  TextLength: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLExecute = function(
{$ELSE}
function SQLExecute(
{$ENDIF}
  StatementHandle: SqlHStmt
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLFetch = function(
{$ELSE}
function SQLFetch(
{$ENDIF}
  StatementHandle: SqlHStmt
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLFetchScroll = function(
{$ELSE}
function SQLFetchScroll(
{$ENDIF}
  StatementHandle: SqlHStmt;
  FetchOrientation: SqlSmallint;
  FetchOffset: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLFreeConnect = function(
{$ELSE}
function SQLFreeConnect(
{$ENDIF}
  ConnectionHandle: SqlHDbc
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLFreeEnv = function(
{$ELSE}
function SQLFreeEnv(
{$ENDIF}
  EnvironmentHandle: SqlHEnv
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLFreeHandle = function(
{$ELSE}
function SQLFreeHandle(
{$ENDIF}
  HandleType: SqlSmallint;
  Handle: SqlHandle
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLFreeStmt = function(
{$ELSE}
function SQLFreeStmt(
{$ENDIF}
  StatementHandle: SqlHStmt;
  Option: SqlUSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

// SQLGetConnectAttr is overloaded. See OBDC API doc:
// "Depending on the value of Attribute,
//  ValuePtr will be a 32-bit unsigned integer value
//  or will point to a null-terminated character string.

{$IFDEF DynamicOdbcImport}
TSQLGetConnectAttr = function(
{$ELSE}
function SQLGetConnectAttr(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  Attribute: SqlInteger;
  ValuePtr: SqlPointer;
  BufferLength: SqlInteger;
  pStringLength: PSqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetConnectOption = function(
{$ELSE}
function SQLGetConnectOption(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  Option: SqlUSmallint;
  Value: SqlPointer
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetCursorName = function(
{$ELSE}
function SQLGetCursorName(
{$ENDIF}
  StatementHandle: SqlHStmt;
  CursorName: PAnsiChar;
  BufferLength: SqlSmallint;
  var NameLength: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetData = function(
{$ELSE}
function SQLGetData(
{$ENDIF}
  StatementHandle: SqlHStmt;
  ColumnNumber: SqlUSmallint;
  TargetType: SqlSmallint;
  TargetValue: SqlPointer;
  BufferLength: SqlInteger;
  StrLen_or_Ind: PSqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetDescField = function(
{$ELSE}
function SQLGetDescField(
{$ENDIF}
  DescriptorHandle: SqlHDesc;
  RecNumber: SqlSmallint;
  FieldIdentifier: SqlSmallint;
  Value: SqlPointer;
  BufferLength: SqlInteger;
  var StringLength: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetDescRec = function(
{$ELSE}
function SQLGetDescRec(
{$ENDIF}
  DescriptorHandle: SqlHDesc;
  RecNumber: SqlSmallint;
  var Name: SqlChar;
  BufferLength: SqlSmallint;
  var StringLength: SqlSmallint;
  var _Type: SqlSmallint;
  var SubType: SqlSmallint;
  var Length: SqlInteger;
  var Precision: SqlSmallint;
  var Scale: SqlSmallint;
  var Nullable: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetDiagField = function(
{$ELSE}
function SQLGetDiagField(
{$ENDIF}
  HandleType: SqlSmallint;
  Handle: SqlHandle;
  RecNumber: SqlSmallint;
  DiagIdentifier: SqlSmallint;
  DiagInfo: SqlPointer;
  BufferLength: SqlSmallint;
  var StringLength: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetDiagRec = function(
{$ELSE}
function SQLGetDiagRec(
{$ENDIF}
  HandleType: SqlSmallint;
  Handle: SqlHandle;
  RecNumber: SqlSmallint;
  Sqlstate: PAnsiChar; // pointer to 5 character buffer
  var NativeError: SqlInteger;
  MessageText: PAnsiChar;
  BufferLength: SqlSmallint;
  var TextLength: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetEnvAttr = function(
{$ELSE}
function SQLGetEnvAttr(
{$ENDIF}
  EnvironmentHandle: SqlHEnv;
  Attribute: SqlInteger;
  Value: SqlPointer;
  BufferLength: SqlInteger;
  var StringLength: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetFunctions = function(
{$ELSE}
function SQLGetFunctions(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  FunctionId: SqlUSmallint;
  var Supported: SqlUSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

// SQLGetInfo is overloaded. See OBDC API doc:
//   "Depending on the InfoType requested,
//   the information returned will be one of the following:
//     a null-terminated character string,
//     an SQLUSMALLINT value,
//     an SQLUINTEGER bitmask,
//     an SQLUINTEGER flag,
//     or a SQLUINTEGER binary value."

{$IFDEF DynamicOdbcImport}
TSQLGetInfo = function(
{$ELSE}
function SQLGetInfo(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  InfoType: SqlUSmallint;
  InfoValuePtr: SqlPointer;
  BufferLength: SqlSmallint;
  StringLengthPtr: SqlPointer
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetInfoString = function(
{$ELSE}
function SQLGetInfoString(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  InfoType: SqlUSmallint;
  InfoValueString: PAnsiChar; // PWideChar when calling SQLGetInfoW
  BufferLength: SqlSmallint;
  var StringLength: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetInfoSmallint = function(
{$ELSE}
function SQLGetInfoSmallint(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  InfoType: SqlUSmallint;
  var InfoValue: SqlUSmallint;
  Ignored1: SqlSmallint;
  Ignored2: Pointer
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetInfoInt = function(
{$ELSE}
function SQLGetInfoInt(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  InfoType: SqlUSmallint;
  var InfoValue: SqlUInteger;
  Ignored1: SqlSmallint;
  Ignored2: Pointer
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetStmtAttr = function(
{$ELSE}
function SQLGetStmtAttr(
{$ENDIF}
  StatementHandle: SqlHStmt;
  Attribute: SqlInteger;
  Value: SqlPointer;
  BufferLength: SqlInteger;
  var StringLength: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetStmtOption = function(
{$ELSE}
function SQLGetStmtOption(
{$ENDIF}
  StatementHandle: SqlHStmt;
  Option: SqlUSmallint;
  Value: SqlPointer
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLGetTypeInfo = function(
{$ELSE}
function SQLGetTypeInfo(
{$ENDIF}
  StatementHandle: SqlHStmt;
  DataType: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLNumResultCols = function(
{$ELSE}
function SQLNumResultCols(
{$ENDIF}
  StatementHandle: SqlHStmt;
  var ColumnCount: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLParamData = function(
{$ELSE}
function SQLParamData(
{$ENDIF}
  StatementHandle: SqlHStmt;
  var Value: SqlPointer
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLPrepare = function(
{$ELSE}
function SQLPrepare(
{$ENDIF}
  StatementHandle: SqlHStmt;
  StatementText: PAnsiChar;
  TextLength: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLPutData = function(
{$ELSE}
function SQLPutData(
{$ENDIF}
  StatementHandle: SqlHStmt;
  Data: SqlPointer;
  StrLen_or_Ind: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLRowCount = function(
{$ELSE}
function SQLRowCount(
{$ENDIF}
  StatementHandle: SqlHStmt;
  var RowCount: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLSetConnectAttr = function(
{$ELSE}
function SQLSetConnectAttr(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  Attribute: SqlInteger;
  ValuePtr: SqlPointer;
  StringLength: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLSetConnectOption = function(
{$ELSE}
function SQLSetConnectOption(
{$ENDIF}
  ConnectionHandle: SqlHDbc;
  Option: SqlUSmallint;
  Value: SqlUInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLSetCursorName = function(
{$ELSE}
function SQLSetCursorName(
{$ENDIF}
  StatementHandle: SqlHStmt;
  CursorName: PAnsiChar;
  NameLength: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLSetDescField = function(
{$ELSE}
function SQLSetDescField(
{$ENDIF}
  DescriptorHandle: SqlHDesc;
  RecNumber: SqlSmallint;
  FieldIdentifier: SqlSmallint;
  Value: SqlPointer;
  BufferLength: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLSetDescRec = function(
{$ELSE}
function SQLSetDescRec(
{$ENDIF}
  DescriptorHandle: SqlHDesc;
  RecNumber: SqlSmallint;
  _Type: SqlSmallint;
  SubType: SqlSmallint;
  Length: SqlInteger;
  Precision: SqlSmallint;
  Scale: SqlSmallint;
  Data: SqlPointer;
  var StringLength: SqlInteger;
  var Indicator: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

// SQLSetEnvAttr is overloaded. See OBDC API doc:
//   "Depending on the value of Attribute,
//   value will be a 32-bit integer value
//   or point to a null-terminated character string."

{$IFDEF DynamicOdbcImport}
TSQLSetEnvAttr = function(
{$ELSE}
function SQLSetEnvAttr(
{$ENDIF}
  EnvironmentHandle: SqlHEnv;
  Attribute: SqlInteger;
  ValuePtr: Pointer;
  StringLength: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLSetParam = function(
{$ELSE}
function SQLSetParam(
{$ENDIF}
  StatementHandle: SqlHStmt;
  ParameterNumber: SqlUSmallint;
  ValueType: SqlSmallint;
  ParameterType: SqlSmallint;
  LengthPrecision: SqlUInteger;
  ParameterScale: SqlSmallint;
  ParameterValue: SqlPointer;
  var StrLen_or_Ind: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLSetStmtAttr = function(
{$ELSE}
function SQLSetStmtAttr(
{$ENDIF}
  StatementHandle: SqlHStmt;
  Attribute: SqlInteger;
  Value: SqlPointer;
  StringLength: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLSetStmtOption = function(
{$ELSE}
function SQLSetStmtOption(
{$ENDIF}
  StatementHandle: SqlHStmt;
  Option: SqlUSmallint;
  Value: SqlUInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLSpecialColumns = function(
{$ELSE}
function SQLSpecialColumns(
{$ENDIF}
  StatementHandle: SqlHStmt;
  IdentifierType: SqlUSmallint;
  CatalogName: PAnsiChar;
  NameLength1: SqlSmallint;
  SchemaName: PAnsiChar;
  NameLength2: SqlSmallint;
  TableName: PAnsiChar;
  NameLength3: SqlSmallint;
  Scope: SqlUSmallint;
  Nullable: SqlUSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLStatistics = function(
{$ELSE}
function SQLStatistics(
{$ENDIF}
  StatementHandle: SqlHStmt;
  CatalogName: PAnsiChar;
  NameLength1: SqlSmallint;
  SchemaName: PAnsiChar;
  NameLength2: SqlSmallint;
  TableName: PAnsiChar;
  NameLength3: SqlSmallint;
  Unique: SqlUSmallint;
  Reserved: SqlUSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLTables = function(
{$ELSE}
function SQLTables(
{$ENDIF}
  StatementHandle: SqlHStmt;
  CatalogName: PAnsiChar;
  NameLength1: SqlSmallint;
  SchemaName: PAnsiChar;
  NameLength2: SqlSmallint;
  TableName: PAnsiChar;
  NameLength3: SqlSmallint;
  TableType: PAnsiChar;
  NameLength4: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLTransact = function(
{$ELSE}
function SQLTransact(
{$ENDIF}
  EnvironmentHandle: SqlHEnv;
  ConnectionHandle: SqlHDbc;
  CompletionType: SqlUSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

//##########################################################################
// sql.h interface part ends here
//##########################################################################

//##########################################################################
// sqlext.h interface part starts here
//##########################################################################

//****************************************************************
// SQLEXT.H - This is the include for applications using
// the Microsoft SQL Extensions
//
// (C) Copyright 1990 - 1998 By Microsoft Corp.
//
// Updated 05/12/93 for 2.00 specification
// Updated 05/23/94 for 2.01 specification
// Updated 10/27/94 for 2.10 specification
// Updated 04/10/95 for 2.50 specification
// Updated 07/25/95 for 3.00 specification
// Updated 01/12/96 for 3.00 preliminary release
// Updated 10/22/97 for 3.51 specification
//********************************************************************

// copied from sqlucode.h
const
  SQL_WCHAR = (-8);
  SQL_WVARCHAR = (-9);
  SQL_WLONGVARCHAR = (-10);
  SQL_C_WCHAR = SQL_WCHAR;

  // generally useful constants
const
  SQL_SPEC_MAJOR = 3; // Major version of specification
  SQL_SPEC_MINOR = 51; // Minor version of specification
  SQL_SPEC_STRING = '03.51'; // String constant for version

  SQL_SQLSTATE_SIZE = 5; // size of SQLSTATE
  SQL_MAX_DSN_LENGTH = 32; // maximum data source name size

  SQL_MAX_OPTION_STRING_LENGTH = 256;

  // return code SQL_NO_DATA_FOUND is the same as SQL_NO_DATA*
  SQL_NO_DATA_FOUND = SQL_NO_DATA;

  // an env handle type
  SQL_HANDLE_SENV = 5;

  // env attribute
  SQL_ATTR_ODBC_VERSION = 200;
  SQL_ATTR_CONNECTION_POOLING = 201;
  SQL_ATTR_CP_MATCH = 202;

  // values for SQL_ATTR_CONNECTION_POOLING
  SQL_CP_OFF = ULong(0);
  SQL_CP_ONE_PER_DRIVER = ULong(1);
  SQL_CP_ONE_PER_HENV = ULong(2);
  SQL_CP_DEFAULT = SQL_CP_OFF;

  // values for SQL_ATTR_CP_MATCH
  SQL_CP_STRICT_MATCH = ULong(0);
  SQL_CP_RELAXED_MATCH = ULong(1);
  SQL_CP_MATCH_DEFAULT = SQL_CP_STRICT_MATCH;

  // values for SQL_ATTR_ODBC_VERSION
  SQL_OV_ODBC2 = ULong(2);
  SQL_OV_ODBC3 = ULong(3);

  // connection attributes
  SQL_ACCESS_MODE = 101;
  SQL_AUTOCOMMIT = 102;
  SQL_LOGIN_TIMEOUT = 103;
  SQL_OPT_TRACE = 104;
  SQL_OPT_TRACEFILE = 105;
  SQL_TRANSLATE_DLL = 106;
  SQL_TRANSLATE_OPTION = 107;
  SQL_TXN_ISOLATION = 108;
  SQL_CURRENT_QUALIFIER = 109;
  SQL_ODBC_CURSORS = 110;
  SQL_QUIET_MODE = 111;
  SQL_PACKET_SIZE = 112;

  // connection attributes with new names
  SQL_ATTR_ACCESS_MODE = SQL_ACCESS_MODE;
  SQL_ATTR_AUTOCOMMIT = SQL_AUTOCOMMIT;
  SQL_ATTR_CONNECTION_TIMEOUT = 113;
  SQL_ATTR_CURRENT_CATALOG = SQL_CURRENT_QUALIFIER;
  SQL_ATTR_DISCONNECT_BEHAVIOR = 114;
  SQL_ATTR_ENLIST_IN_DTC = 1207;
  SQL_ATTR_ENLIST_IN_XA = 1208;
  SQL_ATTR_LOGIN_TIMEOUT = SQL_LOGIN_TIMEOUT;
  SQL_ATTR_ODBC_CURSORS = SQL_ODBC_CURSORS;
  SQL_ATTR_PACKET_SIZE = SQL_PACKET_SIZE;
  SQL_ATTR_QUIET_MODE = SQL_QUIET_MODE;
  SQL_ATTR_TRACE = SQL_OPT_TRACE;
  SQL_ATTR_TRACEFILE = SQL_OPT_TRACEFILE;
  SQL_ATTR_TRANSLATE_LIB = SQL_TRANSLATE_DLL;
  SQL_ATTR_TRANSLATE_OPTION = SQL_TRANSLATE_OPTION;
  SQL_ATTR_TXN_ISOLATION = SQL_TXN_ISOLATION;
  SQL_ATTR_CONNECTION_DEAD = 1209; // GetConnectAttr only

  { ODBC Driver Manager sets this connection attribute to a unicode driver
    (which supports SQLConnectW) when the application is an ANSI application
    (which calls SQLConnect, SQLDriverConnect, or SQLBrowseConnect).
    This is SetConnectAttr only and application does not set this attribute
    This attribute was introduced because some unicode driver's some APIs may
    need to behave differently on ANSI or Unicode applications. A unicode
    driver, which has same behavior for both ANSI or Unicode applications,
    should return SQL_ERROR when the driver manager sets this connection
    attribute. When a unicode driver returns SQL_SUCCESS on this attribute,
    the driver manager treates ANSI and Unicode connections differently in
    connection pooling. }
  SQL_ATTR_ANSI_APP = 115;

  // SQL_ACCESS_MODE options
  SQL_MODE_READ_WRITE = ULong(0);
  SQL_MODE_READ_ONLY = ULong(1);
  SQL_MODE_DEFAULT = SQL_MODE_READ_WRITE;

  // SQL_AUTOCOMMIT options
  SQL_AUTOCOMMIT_OFF = ULong(0);
  SQL_AUTOCOMMIT_ON = ULong(1);
  SQL_AUTOCOMMIT_DEFAULT = SQL_AUTOCOMMIT_ON;

  // SQL_LOGIN_TIMEOUT options
  SQL_LOGIN_TIMEOUT_DEFAULT = ULong(15);

  // SQL_OPT_TRACE options
  SQL_OPT_TRACE_OFF = ULong(0);
  SQL_OPT_TRACE_ON = ULong(1);
  SQL_OPT_TRACE_DEFAULT = SQL_OPT_TRACE_OFF;
  SQL_OPT_TRACE_FILE_DEFAULT = '\\SQL.LOG';

  // SQL_ODBC_CURSORS options
  SQL_CUR_USE_IF_NEEDED = ULong(0);
  SQL_CUR_USE_ODBC = ULong(1);
  SQL_CUR_USE_DRIVER = ULong(2);
  SQL_CUR_DEFAULT = SQL_CUR_USE_DRIVER;

  // values for SQL_ATTR_DISCONNECT_BEHAVIOR
  SQL_DB_RETURN_TO_POOL = ULong(0);
  SQL_DB_DISCONNECT = ULong(1);
  SQL_DB_DEFAULT = SQL_DB_RETURN_TO_POOL;

  // values for SQL_ATTR_ENLIST_IN_DTC
  SQL_DTC_DONE = 0;

  // values for SQL_ATTR_CONNECTION_DEAD
  SQL_CD_TRUE = 1; // Connection is closed/dead
  SQL_CD_FALSE = 0; // Connection is open/available

  // values for SQL_ATTR_ANSI_APP
  SQL_AA_TRUE = 1; // the application is an ANSI app
  SQL_AA_FALSE = 0; // the application is a Unicode app

  // statement attributes
  SQL_QUERY_TIMEOUT = 0;
  SQL_MAX_ROWS = 1;
  SQL_NOSCAN = 2;
  SQL_MAX_LENGTH = 3;
  SQL_ASYNC_ENABLE = 4; // same as SQL_ATTR_ASYNC_ENABLE
  SQL_BIND_TYPE = 5;
  SQL_CURSOR_TYPE = 6;
  SQL_CONCURRENCY = 7;
  SQL_KEYSET_SIZE = 8;
  SQL_ROWSET_SIZE = 9;
  SQL_SIMULATE_CURSOR = 10;
  SQL_RETRIEVE_DATA = 11;
  SQL_USE_BOOKMARKS = 12;
  SQL_GET_BOOKMARK = 13; // GetStmtOption Only
  SQL_ROW_NUMBER = 14; // GetStmtOption Only

  SQL_ATTR_ASYNC_ENABLE = 4;
  SQL_ATTR_CONCURRENCY = SQL_CONCURRENCY;
  SQL_ATTR_CURSOR_TYPE = SQL_CURSOR_TYPE;
  SQL_ATTR_ENABLE_AUTO_IPD = 15;
  SQL_ATTR_FETCH_BOOKMARK_PTR = 16;
  SQL_ATTR_KEYSET_SIZE = SQL_KEYSET_SIZE;
  SQL_ATTR_MAX_LENGTH = SQL_MAX_LENGTH;
  SQL_ATTR_MAX_ROWS = SQL_MAX_ROWS;
  SQL_ATTR_NOSCAN = SQL_NOSCAN;
  SQL_ATTR_PARAM_BIND_OFFSET_PTR = 17;
  SQL_ATTR_PARAM_BIND_TYPE = 18;
  SQL_ATTR_PARAM_OPERATION_PTR = 19;
  SQL_ATTR_PARAM_STATUS_PTR = 20;
  SQL_ATTR_PARAMS_PROCESSED_PTR = 21;
  SQL_ATTR_PARAMSET_SIZE = 22;
  SQL_ATTR_QUERY_TIMEOUT = SQL_QUERY_TIMEOUT;
  SQL_ATTR_RETRIEVE_DATA = SQL_RETRIEVE_DATA;
  SQL_ATTR_ROW_BIND_OFFSET_PTR = 23;
  SQL_ATTR_ROW_BIND_TYPE = SQL_BIND_TYPE;
  SQL_ATTR_ROW_NUMBER = SQL_ROW_NUMBER; // GetStmtAttr
  SQL_ATTR_ROW_OPERATION_PTR = 24;
  SQL_ATTR_ROW_STATUS_PTR = 25;
  SQL_ATTR_ROWS_FETCHED_PTR = 26;
  SQL_ATTR_ROW_ARRAY_SIZE = 27;
  SQL_ATTR_SIMULATE_CURSOR = SQL_SIMULATE_CURSOR;
  SQL_ATTR_USE_BOOKMARKS = SQL_USE_BOOKMARKS;

  //=====================================
  // This block moved to here from below because of dependent decarations

  // SQLColAttributes defines
  SQL_COLUMN_COUNT = 0;
  SQL_COLUMN_NAME = 1;
  SQL_COLUMN_TYPE = 2;
  SQL_COLUMN_LENGTH = 3;
  SQL_COLUMN_PRECISION = 4;
  SQL_COLUMN_SCALE = 5;
  SQL_COLUMN_DISPLAY_SIZE = 6;
  SQL_COLUMN_NULLABLE = 7;
  SQL_COLUMN_UNSIGNED = 8;
  SQL_COLUMN_MONEY = 9;
  SQL_COLUMN_UPDATABLE = 10;
  SQL_COLUMN_AUTO_INCREMENT = 11;
  SQL_COLUMN_CASE_SENSITIVE = 12;
  SQL_COLUMN_SEARCHABLE = 13;
  SQL_COLUMN_TYPE_NAME = 14;
  SQL_COLUMN_TABLE_NAME = 15;
  SQL_COLUMN_OWNER_NAME = 16;
  SQL_COLUMN_QUALIFIER_NAME = 17;
  SQL_COLUMN_LABEL = 18;

  SQL_COLATT_OPT_MAX = SQL_COLUMN_LABEL;
  SQL_COLATT_OPT_MIN = SQL_COLUMN_COUNT;

  // SQLColAttributes subdefines for SQL_COLUMN_UPDATABLE
  SQL_ATTR_READONLY = 0;
  SQL_ATTR_WRITE = 1;
  SQL_ATTR_READWRITE_UNKNOWN = 2;

  // SQLColAttributes subdefines for SQL_COLUMN_SEARCHABLE
  // These are also used by SQLGetInfo
  SQL_UNSEARCHABLE = 0;
  SQL_LIKE_ONLY = 1;
  SQL_ALL_EXCEPT_LIKE = 2;
  SQL_SEARCHABLE = 3;
  SQL_PRED_SEARCHABLE = SQL_SEARCHABLE;

  // Special return values for SQLGetData
  SQL_NO_TOTAL = (-4);
  // End of move
  //=====================================

  // New defines for SEARCHABLE column in SQLGetTypeInfo
  SQL_COL_PRED_CHAR = SQL_LIKE_ONLY;
  SQL_COL_PRED_BASIC = SQL_ALL_EXCEPT_LIKE;

  // whether an attribute is a pointer or not
  SQL_IS_POINTER = (-4);

  SQL_IS_UINTEGER = (-5);
  SQL_IS_INTEGER = (-6);
  SQL_IS_USMALLINT = (-7);
  SQL_IS_SMALLINT = (-8);

  // the value of SQL_ATTR_PARAM_BIND_TYPE
  SQL_PARAM_BIND_BY_COLUMN = ULong(0);
  SQL_PARAM_BIND_TYPE_DEFAULT = SQL_PARAM_BIND_BY_COLUMN;

  // SQL_QUERY_TIMEOUT options
  SQL_QUERY_TIMEOUT_DEFAULT = ULong(0);

  // SQL_MAX_ROWS options
  SQL_MAX_ROWS_DEFAULT = ULong(0);

  // SQL_NOSCAN options
  SQL_NOSCAN_OFF = ULong(0); // 1.0 FALSE
  SQL_NOSCAN_ON = ULong(1); // 1.0 TRUE
  SQL_NOSCAN_DEFAULT = SQL_NOSCAN_OFF;

  // SQL_MAX_LENGTH options
  SQL_MAX_LENGTH_DEFAULT = ULong(0);

  // values for SQL_ATTR_ASYNC_ENABLE
  SQL_ASYNC_ENABLE_OFF = ULong(0);
  SQL_ASYNC_ENABLE_ON = ULong(1);
  SQL_ASYNC_ENABLE_DEFAULT = SQL_ASYNC_ENABLE_OFF;

  // SQL_BIND_TYPE options
  SQL_BIND_BY_COLUMN = ULong(0);
  SQL_BIND_TYPE_DEFAULT = SQL_BIND_BY_COLUMN; // Default value

  // SQL_CONCURRENCY options
  SQL_CONCUR_READ_ONLY = 1;
  SQL_CONCUR_LOCK = 2;
  SQL_CONCUR_ROWVER = 3;
  SQL_CONCUR_VALUES = 4;
  SQL_CONCUR_DEFAULT = SQL_CONCUR_READ_ONLY; // Default value

  // SQL_CURSOR_TYPE options
  SQL_CURSOR_FORWARD_ONLY = ULong(0);
  SQL_CURSOR_KEYSET_DRIVEN = ULong(1);
  SQL_CURSOR_DYNAMIC = ULong(2);
  SQL_CURSOR_STATIC = ULong(3);
  SQL_CURSOR_TYPE_DEFAULT = SQL_CURSOR_FORWARD_ONLY; // Default value

  // SQL_ROWSET_SIZE options
  SQL_ROWSET_SIZE_DEFAULT = ULong(1);

  // SQL_KEYSET_SIZE options
  SQL_KEYSET_SIZE_DEFAULT = ULong(0);

  // SQL_SIMULATE_CURSOR options
  SQL_SC_NON_UNIQUE = ULong(0);
  SQL_SC_TRY_UNIQUE = ULong(1);
  SQL_SC_UNIQUE = ULong(2);

  // SQL_RETRIEVE_DATA options
  SQL_RD_OFF = ULong(0);
  SQL_RD_ON = ULong(1);
  SQL_RD_DEFAULT = SQL_RD_ON;

  // SQL_USE_BOOKMARKS options
  SQL_UB_OFF = ULong(0);
  SQL_UB_ON = ULong(1);
  SQL_UB_DEFAULT = SQL_UB_OFF;

  // New values for SQL_USE_BOOKMARKS attribute
  SQL_UB_FIXED = SQL_UB_ON;
  SQL_UB_VARIABLE = ULong(2);

  // extended descriptor field
  SQL_DESC_ARRAY_SIZE = 20;
  SQL_DESC_ARRAY_STATUS_PTR = 21;
  SQL_DESC_AUTO_UNIQUE_VALUE = SQL_COLUMN_AUTO_INCREMENT;
  SQL_DESC_BASE_COLUMN_NAME = 22;
  SQL_DESC_BASE_TABLE_NAME = 23;
  SQL_DESC_BIND_OFFSET_PTR = 24;
  SQL_DESC_BIND_TYPE = 25;
  SQL_DESC_CASE_SENSITIVE = SQL_COLUMN_CASE_SENSITIVE;
  SQL_DESC_CATALOG_NAME = SQL_COLUMN_QUALIFIER_NAME;
  SQL_DESC_CONCISE_TYPE = SQL_COLUMN_TYPE;
  SQL_DESC_DATETIME_INTERVAL_PRECISION = 26;
  SQL_DESC_DISPLAY_SIZE = SQL_COLUMN_DISPLAY_SIZE;
  SQL_DESC_FIXED_PREC_SCALE = SQL_COLUMN_MONEY;
  SQL_DESC_LABEL = SQL_COLUMN_LABEL;
  SQL_DESC_LITERAL_PREFIX = 27;
  SQL_DESC_LITERAL_SUFFIX = 28;
  SQL_DESC_LOCAL_TYPE_NAME = 29;
  SQL_DESC_MAXIMUM_SCALE = 30;
  SQL_DESC_MINIMUM_SCALE = 31;
  SQL_DESC_NUM_PREC_RADIX = 32;
  SQL_DESC_PARAMETER_TYPE = 33;
  SQL_DESC_ROWS_PROCESSED_PTR = 34;
  SQL_DESC_ROWVER = 35;
  SQL_DESC_SCHEMA_NAME = SQL_COLUMN_OWNER_NAME;
  SQL_DESC_SEARCHABLE = SQL_COLUMN_SEARCHABLE;
  SQL_DESC_TYPE_NAME = SQL_COLUMN_TYPE_NAME;
  SQL_DESC_TABLE_NAME = SQL_COLUMN_TABLE_NAME;
  SQL_DESC_UNSIGNED = SQL_COLUMN_UNSIGNED;
  SQL_DESC_UPDATABLE = SQL_COLUMN_UPDATABLE;

  // defines for diagnostics fields
  SQL_DIAG_CURSOR_ROW_COUNT = (-1249);
  SQL_DIAG_ROW_NUMBER = (-1248);
  SQL_DIAG_COLUMN_NUMBER = (-1247);

  // SQL extended datatypes
  SQL_DATE = 9;
  SQL_INTERVAL = 10;
  SQL_TIME = 10;
  SQL_TIMESTAMP = 11;
  SQL_LONGVARCHAR = (-1);
  SQL_BINARY = (-2);
  SQL_VARBINARY = (-3);
  SQL_LONGVARBINARY = (-4);
  SQL_BIGINT = (-5);
  SQL_TINYINT = (-6);
  SQL_BIT = (-7);
  SQL_GUID = (-11);

  // interval code
  SQL_CODE_YEAR = 1;
  SQL_CODE_MONTH = 2;
  SQL_CODE_DAY = 3;
  SQL_CODE_HOUR = 4;
  SQL_CODE_MINUTE = 5;
  SQL_CODE_SECOND = 6;
  SQL_CODE_YEAR_TO_MONTH = 7;
  SQL_CODE_DAY_TO_HOUR = 8;
  SQL_CODE_DAY_TO_MINUTE = 9;
  SQL_CODE_DAY_TO_SECOND = 10;
  SQL_CODE_HOUR_TO_MINUTE = 11;
  SQL_CODE_HOUR_TO_SECOND = 12;
  SQL_CODE_MINUTE_TO_SECOND = 13;

  SQL_INTERVAL_YEAR = (100 + SQL_CODE_YEAR);
  SQL_INTERVAL_MONTH = (100 + SQL_CODE_MONTH);
  SQL_INTERVAL_DAY = (100 + SQL_CODE_DAY);
  SQL_INTERVAL_HOUR = (100 + SQL_CODE_HOUR);
  SQL_INTERVAL_MINUTE = (100 + SQL_CODE_MINUTE);
  SQL_INTERVAL_SECOND = (100 + SQL_CODE_SECOND);
  SQL_INTERVAL_YEAR_TO_MONTH = (100 + SQL_CODE_YEAR_TO_MONTH);
  SQL_INTERVAL_DAY_TO_HOUR = (100 + SQL_CODE_DAY_TO_HOUR);
  SQL_INTERVAL_DAY_TO_MINUTE = (100 + SQL_CODE_DAY_TO_MINUTE);
  SQL_INTERVAL_DAY_TO_SECOND = (100 + SQL_CODE_DAY_TO_SECOND);
  SQL_INTERVAL_HOUR_TO_MINUTE = (100 + SQL_CODE_HOUR_TO_MINUTE);
  SQL_INTERVAL_HOUR_TO_SECOND = (100 + SQL_CODE_HOUR_TO_SECOND);
  SQL_INTERVAL_MINUTE_TO_SECOND = (100 + SQL_CODE_MINUTE_TO_SECOND);

  SQL_UNICODE = SQL_WCHAR;
  SQL_UNICODE_VARCHAR = SQL_WVARCHAR;
  SQL_UNICODE_LONGVARCHAR = SQL_WLONGVARCHAR;
  SQL_UNICODE_CHAR = SQL_WCHAR;

  // C datatype to SQL datatype mapping SQL types
  // -------------------
  SQL_C_CHAR = SQL_CHAR; // CHAR, VARCHAR, DECIMAL, NUMERIC
  SQL_C_LONG = SQL_INTEGER; // INTEGER
  SQL_C_SHORT = SQL_SMALLINT; // SMALLINT
  SQL_C_FLOAT = SQL_REAL; // REAL
  SQL_C_DOUBLE = SQL_DOUBLE; // FLOAT, DOUBLE
  SQL_C_NUMERIC = SQL_NUMERIC;
  SQL_C_DEFAULT = 99;
  SQL_SIGNED_OFFSET = (-20);
  SQL_UNSIGNED_OFFSET = (-22);

  // C datatype to SQL datatype mapping
  SQL_C_DATE = SQL_DATE;
  SQL_C_TIME = SQL_TIME;
  SQL_C_TIMESTAMP = SQL_TIMESTAMP;
  SQL_C_TYPE_DATE = SQL_TYPE_DATE;
  SQL_C_TYPE_TIME = SQL_TYPE_TIME;
  SQL_C_TYPE_TIMESTAMP = SQL_TYPE_TIMESTAMP;
  SQL_C_INTERVAL_YEAR = SQL_INTERVAL_YEAR;
  SQL_C_INTERVAL_MONTH = SQL_INTERVAL_MONTH;
  SQL_C_INTERVAL_DAY = SQL_INTERVAL_DAY;
  SQL_C_INTERVAL_HOUR = SQL_INTERVAL_HOUR;
  SQL_C_INTERVAL_MINUTE = SQL_INTERVAL_MINUTE;
  SQL_C_INTERVAL_SECOND = SQL_INTERVAL_SECOND;
  SQL_C_INTERVAL_YEAR_TO_MONTH = SQL_INTERVAL_YEAR_TO_MONTH;
  SQL_C_INTERVAL_DAY_TO_HOUR = SQL_INTERVAL_DAY_TO_HOUR;
  SQL_C_INTERVAL_DAY_TO_MINUTE = SQL_INTERVAL_DAY_TO_MINUTE;
  SQL_C_INTERVAL_DAY_TO_SECOND = SQL_INTERVAL_DAY_TO_SECOND;
  SQL_C_INTERVAL_HOUR_TO_MINUTE = SQL_INTERVAL_HOUR_TO_MINUTE;
  SQL_C_INTERVAL_HOUR_TO_SECOND = SQL_INTERVAL_HOUR_TO_SECOND;
  SQL_C_INTERVAL_MINUTE_TO_SECOND = SQL_INTERVAL_MINUTE_TO_SECOND;
  SQL_C_BINARY = SQL_BINARY;
  SQL_C_BIT = SQL_BIT;
  SQL_C_SBIGINT = (SQL_BIGINT + SQL_SIGNED_OFFSET); // SIGNED BIGINT
  SQL_C_UBIGINT = (SQL_BIGINT + SQL_UNSIGNED_OFFSET); // UNSIGNED BIGINT
  SQL_C_TINYINT = SQL_TINYINT;
  SQL_C_SLONG = (SQL_C_LONG + SQL_SIGNED_OFFSET); // SIGNED INTEGER
  SQL_C_SSHORT = (SQL_C_SHORT + SQL_SIGNED_OFFSET); // SIGNED SMALLINT
  SQL_C_STINYINT = (SQL_TINYINT + SQL_SIGNED_OFFSET); // SIGNED TINYINT
  SQL_C_ULONG = (SQL_C_LONG + SQL_UNSIGNED_OFFSET); // UNSIGNED INTEGER
  SQL_C_USHORT = (SQL_C_SHORT + SQL_UNSIGNED_OFFSET); // UNSIGNED SMALLINT
  SQL_C_UTINYINT = (SQL_TINYINT + SQL_UNSIGNED_OFFSET); // UNSIGNED TINYINT
  SQL_C_BOOKMARK = SQL_C_ULONG; // BOOKMARK
  SQL_C_GUID = SQL_GUID;

  SQL_TYPE_NULL = 0;
  SQL_C_VARBOOKMARK = SQL_C_BINARY;

  // define for SQL_DIAG_ROW_NUMBER and SQL_DIAG_COLUMN_NUMBER
  SQL_NO_ROW_NUMBER = (-1);
  SQL_NO_COLUMN_NUMBER = (-1);
  SQL_ROW_NUMBER_UNKNOWN = (-2);
  SQL_COLUMN_NUMBER_UNKNOWN = (-2);

  // SQLBindParameter extensions
  SQL_DEFAULT_PARAM = (-5);
  SQL_IGNORE = (-6);
  SQL_COLUMN_IGNORE = SQL_IGNORE;
  SQL_LEN_DATA_AT_EXEC_OFFSET = (-100);

function SQL_LEN_DATA_AT_EXEC(length: Integer): Integer;

const
  // binary length for driver specific attributes
  SQL_LEN_BINARY_ATTR_OFFSET = (-100);

function SQL_LEN_BINARY_ATTR(length: Integer): Integer;

const
  //=====================================
  // SQLBindParameter block moved to here because of dependent decarations

  // Defines for SQLBindParameter and
  // SQLProcedureColumns (returned in the result set)
  SQL_PARAM_TYPE_UNKNOWN = 0;
  SQL_PARAM_INPUT = 1;
  SQL_PARAM_INPUT_OUTPUT = 2;
  SQL_RESULT_COL = 3;
  SQL_PARAM_OUTPUT = 4;
  SQL_RETURN_VALUE = 5;
  // End of moved block
  //=====================================

  // Defines used by Driver Manager when mapping SQLSetParam to SQLBindParameter
  SQL_PARAM_TYPE_DEFAULT = SQL_PARAM_INPUT_OUTPUT;
  SQL_SETPARAM_VALUE_MAX = (-1);

  // SQLColAttributes block
  // WAS ORIGINALLY HERE
  // Moved above because of dependent declarations

  //*******************************************
  // SQLGetFunctions: additional values for
  // fFunction to represent functions that
  // are not in the X/Open spec.
  //*******************************************

  SQL_API_SQLALLOCHANDLESTD = 73;
  SQL_API_SQLBULKOPERATIONS = 24;
  SQL_API_SQLBINDPARAMETER = 72;
  SQL_API_SQLBROWSECONNECT = 55;
  SQL_API_SQLCOLATTRIBUTES = 6;
  SQL_API_SQLCOLUMNPRIVILEGES = 56;
  SQL_API_SQLDESCRIBEPARAM = 58;
  SQL_API_SQLDRIVERCONNECT = 41;
  SQL_API_SQLDRIVERS = 71;
  SQL_API_SQLEXTENDEDFETCH = 59;
  SQL_API_SQLFOREIGNKEYS = 60;
  SQL_API_SQLMORERESULTS = 61;
  SQL_API_SQLNATIVESQL = 62;
  SQL_API_SQLNUMPARAMS = 63;
  SQL_API_SQLPARAMOPTIONS = 64;
  SQL_API_SQLPRIMARYKEYS = 65;
  SQL_API_SQLPROCEDURECOLUMNS = 66;
  SQL_API_SQLPROCEDURES = 67;
  SQL_API_SQLSETPOS = 68;
  SQL_API_SQLSETSCROLLOPTIONS = 69;
  SQL_API_SQLTABLEPRIVILEGES = 70;

  //--------------------------------------------
  // SQL_API_ALL_FUNCTIONS returns an array
  // of 'booleans' representing whether a
  // function is implemented by the driver.
  //
  // CAUTION: Only functions defined in ODBC
  // version 2.0 and earlier are returned, the
  // new high-range function numbers defined by
  // X/Open break this scheme. See the new
  // method -- SQL_API_ODBC3_ALL_FUNCTIONS
  //--------------------------------------------

  SQL_API_ALL_FUNCTIONS = 0; // See CAUTION above

  //----------------------------------------------
  // 2.X drivers export a dummy function with
  // ordinal number SQL_API_LOADBYORDINAL to speed
  // loading under the windows operating system.
  //
  // CAUTION: Loading by ordinal is not supported
  // for 3.0 and above drivers.
  //----------------------------------------------

  SQL_API_LOADBYORDINAL = 199; // See CAUTION above

  //----------------------------------------------
  // SQL_API_ODBC3_ALL_FUNCTIONS
  // This returns a bitmap, which allows us to*
  // handle the higher-valued function numbers.
  // Use SQL_FUNC_EXISTS(bitmap,function_number)
  // to determine if the function exists.
  //----------------------------------------------

  SQL_API_ODBC3_ALL_FUNCTIONS = 999;
  SQL_API_ODBC3_ALL_FUNCTIONS_SIZE = 250; // array of 250 words

function SQL_FUNC_EXISTS(pfExists: PUWord; uwAPI: UWord): SqlInteger;

const
  //***********************************************
  // Extended definitions for SQLGetInfo
  //***********************************************

  //---------------------------------
  // Values in ODBC 2.0 that are not
  // in the X/Open spec
  //---------------------------------
  SQL_INFO_FIRST = 0;
  SQL_ACTIVE_CONNECTIONS = 0; // MAX_DRIVER_CONNECTIONS
  SQL_ACTIVE_STATEMENTS = 1; // MAX_CONCURRENT_ACTIVITIES
  SQL_DRIVER_HDBC = 3;
  SQL_DRIVER_HENV = 4;
  SQL_DRIVER_HSTMT = 5;
  SQL_DRIVER_NAME = 6;
  SQL_DRIVER_VER = 7;
  SQL_ODBC_API_CONFORMANCE = 9;
  SQL_ODBC_VER = 10;
  SQL_ROW_UPDATES = 11;
  SQL_ODBC_SAG_CLI_CONFORMANCE = 12;
  SQL_ODBC_SQL_CONFORMANCE = 15;
  SQL_PROCEDURES = 21;
  SQL_CONCAT_NULL_BEHAVIOR = 22;
  SQL_CURSOR_ROLLBACK_BEHAVIOR = 24;
  SQL_EXPRESSIONS_IN_ORDERBY = 27;
  SQL_MAX_OWNER_NAME_LEN = 32; // MAX_SCHEMA_NAME_LEN
  SQL_MAX_PROCEDURE_NAME_LEN = 33;
  SQL_MAX_QUALIFIER_NAME_LEN = 34; // MAX_CATALOG_NAME_LEN
  SQL_MULT_RESULT_SETS = 36;
  SQL_MULTIPLE_ACTIVE_TXN = 37;
  SQL_OUTER_JOINS = 38;
  SQL_OWNER_TERM = 39;
  SQL_PROCEDURE_TERM = 40;
  SQL_QUALIFIER_NAME_SEPARATOR = 41;
  SQL_QUALIFIER_TERM = 42;
  SQL_SCROLL_OPTIONS = 44;
  SQL_TABLE_TERM = 45;
  SQL_CONVERT_FUNCTIONS = 48;
  SQL_NUMERIC_FUNCTIONS = 49;
  SQL_STRING_FUNCTIONS = 50;
  SQL_SYSTEM_FUNCTIONS = 51;
  SQL_TIMEDATE_FUNCTIONS = 52;
  SQL_CONVERT_BIGINT = 53;
  SQL_CONVERT_BINARY = 54;
  SQL_CONVERT_BIT = 55;
  SQL_CONVERT_CHAR = 56;
  SQL_CONVERT_DATE = 57;
  SQL_CONVERT_DECIMAL = 58;
  SQL_CONVERT_DOUBLE = 59;
  SQL_CONVERT_FLOAT = 60;
  SQL_CONVERT_INTEGER = 61;
  SQL_CONVERT_LONGVARCHAR = 62;
  SQL_CONVERT_NUMERIC = 63;
  SQL_CONVERT_REAL = 64;
  SQL_CONVERT_SMALLINT = 65;
  SQL_CONVERT_TIME = 66;
  SQL_CONVERT_TIMESTAMP = 67;
  SQL_CONVERT_TINYINT = 68;
  SQL_CONVERT_VARBINARY = 69;
  SQL_CONVERT_VARCHAR = 70;
  SQL_CONVERT_LONGVARBINARY = 71;
  SQL_ODBC_SQL_OPT_IEF = 73; // SQL_INTEGRITY
  SQL_CORRELATION_NAME = 74;
  SQL_NON_NULLABLE_COLUMNS = 75;
  SQL_DRIVER_HLIB = 76;
  SQL_DRIVER_ODBC_VER = 77;
  SQL_LOCK_TYPES = 78;
  SQL_POS_OPERATIONS = 79;
  SQL_POSITIONED_STATEMENTS = 80;
  SQL_BOOKMARK_PERSISTENCE = 82;
  SQL_STATIC_SENSITIVITY = 83;
  SQL_FILE_USAGE = 84;
  SQL_COLUMN_ALIAS = 87;
  SQL_GROUP_BY = 88;
  SQL_KEYWORDS = 89;
  SQL_OWNER_USAGE = 91;
  SQL_QUALIFIER_USAGE = 92;
  SQL_QUOTED_IDENTIFIER_CASE = 93;
  SQL_SUBQUERIES = 95;
  SQL_UNION = 96;
  SQL_MAX_ROW_SIZE_INCLUDES_LONG = 103;
  SQL_MAX_CHAR_LITERAL_LEN = 108;
  SQL_TIMEDATE_ADD_INTERVALS = 109;
  SQL_TIMEDATE_DIFF_INTERVALS = 110;
  SQL_NEED_LONG_DATA_LEN = 111;
  SQL_MAX_BINARY_LITERAL_LEN = 112;
  SQL_LIKE_ESCAPE_CLAUSE = 113;
  SQL_QUALIFIER_LOCATION = 114;

  //-----------------------------------------------
  // ODBC 3.0 SQLGetInfo values that are not part
  // of the X/Open standard at this time. X/Open
  // standard values are in sql.h.
  //-----------------------------------------------

  SQL_ACTIVE_ENVIRONMENTS = 116;
  SQL_ALTER_DOMAIN = 117;
  SQL_SQL_CONFORMANCE = 118;
  SQL_DATETIME_LITERALS = 119;
  SQL_ASYNC_MODE = 10021; // new X/Open spec
  SQL_BATCH_ROW_COUNT = 120;
  SQL_BATCH_SUPPORT = 121;
  SQL_CATALOG_LOCATION = SQL_QUALIFIER_LOCATION;
  SQL_CATALOG_NAME_SEPARATOR = SQL_QUALIFIER_NAME_SEPARATOR;
  SQL_CATALOG_TERM = SQL_QUALIFIER_TERM;
  SQL_CATALOG_USAGE = SQL_QUALIFIER_USAGE;
  SQL_CONVERT_WCHAR = 122;
  SQL_CONVERT_INTERVAL_DAY_TIME = 123;
  SQL_CONVERT_INTERVAL_YEAR_MONTH = 124;
  SQL_CONVERT_WLONGVARCHAR = 125;
  SQL_CONVERT_WVARCHAR = 126;
  SQL_CREATE_ASSERTION = 127;
  SQL_CREATE_CHARACTER_SET = 128;
  SQL_CREATE_COLLATION = 129;
  SQL_CREATE_DOMAIN = 130;
  SQL_CREATE_SCHEMA = 131;
  SQL_CREATE_TABLE = 132;
  SQL_CREATE_TRANSLATION = 133;
  SQL_CREATE_VIEW = 134;
  SQL_DRIVER_HDESC = 135;
  SQL_DROP_ASSERTION = 136;
  SQL_DROP_CHARACTER_SET = 137;
  SQL_DROP_COLLATION = 138;
  SQL_DROP_DOMAIN = 139;
  SQL_DROP_SCHEMA = 140;
  SQL_DROP_TABLE = 141;
  SQL_DROP_TRANSLATION = 142;
  SQL_DROP_VIEW = 143;
  SQL_DYNAMIC_CURSOR_ATTRIBUTES1 = 144;
  SQL_DYNAMIC_CURSOR_ATTRIBUTES2 = 145;
  SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1 = 146;
  SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2 = 147;
  SQL_INDEX_KEYWORDS = 148;
  SQL_INFO_SCHEMA_VIEWS = 149;
  SQL_KEYSET_CURSOR_ATTRIBUTES1 = 150;
  SQL_KEYSET_CURSOR_ATTRIBUTES2 = 151;
  SQL_MAX_ASYNC_CONCURRENT_STATEMENTS = 10022; // new X/Open spec
  SQL_ODBC_INTERFACE_CONFORMANCE = 152;
  SQL_PARAM_ARRAY_ROW_COUNTS = 153;
  SQL_PARAM_ARRAY_SELECTS = 154;
  SQL_SCHEMA_TERM = SQL_OWNER_TERM;
  SQL_SCHEMA_USAGE = SQL_OWNER_USAGE;
  SQL_SQL92_DATETIME_FUNCTIONS = 155;
  SQL_SQL92_FOREIGN_KEY_DELETE_RULE = 156;
  SQL_SQL92_FOREIGN_KEY_UPDATE_RULE = 157;
  SQL_SQL92_GRANT = 158;
  SQL_SQL92_NUMERIC_VALUE_FUNCTIONS = 159;
  SQL_SQL92_PREDICATES = 160;
  SQL_SQL92_RELATIONAL_JOIN_OPERATORS = 161;
  SQL_SQL92_REVOKE = 162;
  SQL_SQL92_ROW_VALUE_CONSTRUCTOR = 163;
  SQL_SQL92_STRING_FUNCTIONS = 164;
  SQL_SQL92_VALUE_EXPRESSIONS = 165;
  SQL_STANDARD_CLI_CONFORMANCE = 166;
  SQL_STATIC_CURSOR_ATTRIBUTES1 = 167;
  SQL_STATIC_CURSOR_ATTRIBUTES2 = 168;
  SQL_AGGREGATE_FUNCTIONS = 169;
  SQL_DDL_INDEX = 170;
  SQL_DM_VER = 171;
  SQL_INSERT_STATEMENT = 172;
  SQL_CONVERT_GUID = 173;
  SQL_UNION_STATEMENT = SQL_UNION;

  SQL_DTC_TRANSITION_COST = 1750;

  // SQL_ALTER_TABLE bitmasks
  // the following bitmasks are defined in sql.h
  {
    SQL_AT_ADD_COLUMN = $00000001;
    SQL_AT_DROP_COLUMN = $00000002;
    SQL_AT_ADD_CONSTRAINT = $00000008;
  //= ODBC 3
    SQL_AT_ADD_COLUMN_SINGLE = $00000020;
    SQL_AT_ADD_COLUMN_DEFAULT = $00000040;
    SQL_AT_ADD_COLUMN_COLLATION = $00000080;
    SQL_AT_SET_COLUMN_DEFAULT = $00000100;
    SQL_AT_DROP_COLUMN_DEFAULT = $00000200;
    SQL_AT_DROP_COLUMN_CASCADE = $00000400;
    SQL_AT_DROP_COLUMN_RESTRICT = $00000800;
    SQL_AT_ADD_TABLE_CONSTRAINT = $00001000;
    SQL_AT_DROP_TABLE_CONSTRAINT_CASCADE = $00002000;
    SQL_AT_DROP_TABLE_CONSTRAINT_RESTRICT = $00004000;
    SQL_AT_CONSTRAINT_NAME_DEFINITION = $00008000;
    SQL_AT_CONSTRAINT_INITIALLY_DEFERRED = $00010000;
    SQL_AT_CONSTRAINT_INITIALLY_IMMEDIATE = $00020000;
    SQL_AT_CONSTRAINT_DEFERRABLE = $00040000;
    SQL_AT_CONSTRAINT_NON_DEFERRABLE = $00080000;
  }
  // SQL_CONVERT_* return value bitmasks
  SQL_CVT_CHAR = $00000001;
  SQL_CVT_NUMERIC = $00000002;
  SQL_CVT_DECIMAL = $00000004;
  SQL_CVT_INTEGER = $00000008;
  SQL_CVT_SMALLINT = $00000010;
  SQL_CVT_FLOAT = $00000020;
  SQL_CVT_REAL = $00000040;
  SQL_CVT_DOUBLE = $00000080;
  SQL_CVT_VARCHAR = $00000100;
  SQL_CVT_LONGVARCHAR = $00000200;
  SQL_CVT_BINARY = $00000400;
  SQL_CVT_VARBINARY = $00000800;
  SQL_CVT_BIT = $00001000;
  SQL_CVT_TINYINT = $00002000;
  SQL_CVT_BIGINT = $00004000;
  SQL_CVT_DATE = $00008000;
  SQL_CVT_TIME = $00010000;
  SQL_CVT_TIMESTAMP = $00020000;
  SQL_CVT_LONGVARBINARY = $00040000;
  SQL_CVT_INTERVAL_YEAR_MONTH = $00080000;
  SQL_CVT_INTERVAL_DAY_TIME = $00100000;
  SQL_CVT_WCHAR = $00200000;
  SQL_CVT_WLONGVARCHAR = $00400000;
  SQL_CVT_WVARCHAR = $00800000;
  SQL_CVT_GUID = $01000000;

  // SQL_CONVERT_FUNCTIONS functions
  SQL_FN_CVT_CONVERT = $00000001;
  SQL_FN_CVT_CAST = $00000002;

  // SQL_STRING_FUNCTIONS functions
  SQL_FN_STR_CONCAT = $00000001;
  SQL_FN_STR_INSERT = $00000002;
  SQL_FN_STR_LEFT = $00000004;
  SQL_FN_STR_LTRIM = $00000008;
  SQL_FN_STR_LENGTH = $00000010;
  SQL_FN_STR_LOCATE = $00000020;
  SQL_FN_STR_LCASE = $00000040;
  SQL_FN_STR_REPEAT = $00000080;
  SQL_FN_STR_REPLACE = $00000100;
  SQL_FN_STR_RIGHT = $00000200;
  SQL_FN_STR_RTRIM = $00000400;
  SQL_FN_STR_SUBSTRING = $00000800;
  SQL_FN_STR_UCASE = $00001000;
  SQL_FN_STR_ASCII = $00002000;
  SQL_FN_STR_CHAR = $00004000;
  SQL_FN_STR_DIFFERENCE = $00008000;
  SQL_FN_STR_LOCATE_2 = $00010000;
  SQL_FN_STR_SOUNDEX = $00020000;
  SQL_FN_STR_SPACE = $00040000;
  SQL_FN_STR_BIT_LENGTH = $00080000;
  SQL_FN_STR_CHAR_LENGTH = $00100000;
  SQL_FN_STR_CHARACTER_LENGTH = $00200000;
  SQL_FN_STR_OCTET_LENGTH = $00400000;
  SQL_FN_STR_POSITION = $00800000;

  // SQL_SQL92_STRING_FUNCTIONS
  SQL_SSF_CONVERT = $00000001;
  SQL_SSF_LOWER = $00000002;
  SQL_SSF_UPPER = $00000004;
  SQL_SSF_SUBSTRING = $00000008;
  SQL_SSF_TRANSLATE = $00000010;
  SQL_SSF_TRIM_BOTH = $00000020;
  SQL_SSF_TRIM_LEADING = $00000040;
  SQL_SSF_TRIM_TRAILING = $00000080;

  // SQL_NUMERIC_FUNCTIONS functions
  SQL_FN_NUM_ABS = $00000001;
  SQL_FN_NUM_ACOS = $00000002;
  SQL_FN_NUM_ASIN = $00000004;
  SQL_FN_NUM_ATAN = $00000008;
  SQL_FN_NUM_ATAN2 = $00000010;
  SQL_FN_NUM_CEILING = $00000020;
  SQL_FN_NUM_COS = $00000040;
  SQL_FN_NUM_COT = $00000080;
  SQL_FN_NUM_EXP = $00000100;
  SQL_FN_NUM_FLOOR = $00000200;
  SQL_FN_NUM_LOG = $00000400;
  SQL_FN_NUM_MOD = $00000800;
  SQL_FN_NUM_SIGN = $00001000;
  SQL_FN_NUM_SIN = $00002000;
  SQL_FN_NUM_SQRT = $00004000;
  SQL_FN_NUM_TAN = $00008000;
  SQL_FN_NUM_PI = $00010000;
  SQL_FN_NUM_RAND = $00020000;
  SQL_FN_NUM_DEGREES = $00040000;
  SQL_FN_NUM_LOG10 = $00080000;
  SQL_FN_NUM_POWER = $00100000;
  SQL_FN_NUM_RADIANS = $00200000;
  SQL_FN_NUM_ROUND = $00400000;
  SQL_FN_NUM_TRUNCATE = $00800000;

  // SQL_SQL92_NUMERIC_VALUE_FUNCTIONS
  SQL_SNVF_BIT_LENGTH = $00000001;
  SQL_SNVF_CHAR_LENGTH = $00000002;
  SQL_SNVF_CHARACTER_LENGTH = $00000004;
  SQL_SNVF_EXTRACT = $00000008;
  SQL_SNVF_OCTET_LENGTH = $00000010;
  SQL_SNVF_POSITION = $00000020;

  // SQL_TIMEDATE_FUNCTIONS functions
  SQL_FN_TD_NOW = $00000001;
  SQL_FN_TD_CURDATE = $00000002;
  SQL_FN_TD_DAYOFMONTH = $00000004;
  SQL_FN_TD_DAYOFWEEK = $00000008;
  SQL_FN_TD_DAYOFYEAR = $00000010;
  SQL_FN_TD_MONTH = $00000020;
  SQL_FN_TD_QUARTER = $00000040;
  SQL_FN_TD_WEEK = $00000080;
  SQL_FN_TD_YEAR = $00000100;
  SQL_FN_TD_CURTIME = $00000200;
  SQL_FN_TD_HOUR = $00000400;
  SQL_FN_TD_MINUTE = $00000800;
  SQL_FN_TD_SECOND = $00001000;
  SQL_FN_TD_TIMESTAMPADD = $00002000;
  SQL_FN_TD_TIMESTAMPDIFF = $00004000;
  SQL_FN_TD_DAYNAME = $00008000;
  SQL_FN_TD_MONTHNAME = $00010000;
  SQL_FN_TD_CURRENT_DATE = $00020000;
  SQL_FN_TD_CURRENT_TIME = $00040000;
  SQL_FN_TD_CURRENT_TIMESTAMP = $00080000;
  SQL_FN_TD_EXTRACT = $00100000;

  // SQL_SQL92_DATETIME_FUNCTIONS
  SQL_SDF_CURRENT_DATE = $00000001;
  SQL_SDF_CURRENT_TIME = $00000002;
  SQL_SDF_CURRENT_TIMESTAMP = $00000004;

  // SQL_SYSTEM_FUNCTIONS functions
  SQL_FN_SYS_USERNAME = $00000001;
  SQL_FN_SYS_DBNAME = $00000002;
  SQL_FN_SYS_IFNULL = $00000004;

  // SQL_TIMEDATE_ADD_INTERVALS and SQL_TIMEDATE_DIFF_INTERVALS functions
  SQL_FN_TSI_FRAC_SECOND = $00000001;
  SQL_FN_TSI_SECOND = $00000002;
  SQL_FN_TSI_MINUTE = $00000004;
  SQL_FN_TSI_HOUR = $00000008;
  SQL_FN_TSI_DAY = $00000010;
  SQL_FN_TSI_WEEK = $00000020;
  SQL_FN_TSI_MONTH = $00000040;
  SQL_FN_TSI_QUARTER = $00000080;
  SQL_FN_TSI_YEAR = $00000100;

  // bitmasks for SQL_DYNAMIC_CURSOR_ATTRIBUTES1,
  //- SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1,
  //- SQL_KEYSET_CURSOR_ATTRIBUTES1, and SQL_STATIC_CURSOR_ATTRIBUTES1
  //=

  // supported SQLFetchScroll FetchOrientation's
  SQL_CA1_NEXT = $00000001;
  SQL_CA1_ABSOLUTE = $00000002;
  SQL_CA1_RELATIVE = $00000004;
  SQL_CA1_BOOKMARK = $00000008;

  // supported SQLSetPos LockType's
  SQL_CA1_LOCK_NO_CHANGE = $00000040;
  SQL_CA1_LOCK_EXCLUSIVE = $00000080;
  SQL_CA1_LOCK_UNLOCK = $00000100;

  // supported SQLSetPos Operations
  SQL_CA1_POS_POSITION = $00000200;
  SQL_CA1_POS_UPDATE = $00000400;
  SQL_CA1_POS_DELETE = $00000800;
  SQL_CA1_POS_REFRESH = $00001000;

  // positioned updates and deletes
  SQL_CA1_POSITIONED_UPDATE = $00002000;
  SQL_CA1_POSITIONED_DELETE = $00004000;
  SQL_CA1_SELECT_FOR_UPDATE = $00008000;

  // supported SQLBulkOperations operations
  SQL_CA1_BULK_ADD = $00010000;
  SQL_CA1_BULK_UPDATE_BY_BOOKMARK = $00020000;
  SQL_CA1_BULK_DELETE_BY_BOOKMARK = $00040000;
  SQL_CA1_BULK_FETCH_BY_BOOKMARK = $00080000;

  // bitmasks for SQL_DYNAMIC_CURSOR_ATTRIBUTES2,
  //- SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2,
  //- SQL_KEYSET_CURSOR_ATTRIBUTES2, and SQL_STATIC_CURSOR_ATTRIBUTES2
  //=

  // supported values for SQL_ATTR_SCROLL_CONCURRENCY
  SQL_CA2_READ_ONLY_CONCURRENCY = $00000001;
  SQL_CA2_LOCK_CONCURRENCY = $00000002;
  SQL_CA2_OPT_ROWVER_CONCURRENCY = $00000004;
  SQL_CA2_OPT_VALUES_CONCURRENCY = $00000008;

  // sensitivity of the cursor to its own inserts, deletes, and updates
  SQL_CA2_SENSITIVITY_ADDITIONS = $00000010;
  SQL_CA2_SENSITIVITY_DELETIONS = $00000020;
  SQL_CA2_SENSITIVITY_UPDATES = $00000040;

  // semantics of SQL_ATTR_MAX_ROWS
  SQL_CA2_MAX_ROWS_SELECT = $00000080;
  SQL_CA2_MAX_ROWS_INSERT = $00000100;
  SQL_CA2_MAX_ROWS_DELETE = $00000200;
  SQL_CA2_MAX_ROWS_UPDATE = $00000400;
  SQL_CA2_MAX_ROWS_CATALOG = $00000800;
  SQL_CA2_MAX_ROWS_AFFECTS_ALL = (SQL_CA2_MAX_ROWS_SELECT or
    SQL_CA2_MAX_ROWS_INSERT or SQL_CA2_MAX_ROWS_DELETE or
    SQL_CA2_MAX_ROWS_UPDATE or SQL_CA2_MAX_ROWS_CATALOG);

  // semantics of SQL_DIAG_CURSOR_ROW_COUNT
  SQL_CA2_CRC_EXACT = $00001000;
  SQL_CA2_CRC_APPROXIMATE = $00002000;

  // the kinds of positioned statements that can be simulated
  SQL_CA2_SIMULATE_NON_UNIQUE = $00004000;
  SQL_CA2_SIMULATE_TRY_UNIQUE = $00008000;
  SQL_CA2_SIMULATE_UNIQUE = $00010000;

  // SQL_ODBC_API_CONFORMANCE values
  SQL_OAC_NONE = $0000;
  SQL_OAC_LEVEL1 = $0001;
  SQL_OAC_LEVEL2 = $0002;

  // SQL_ODBC_SAG_CLI_CONFORMANCE values
  SQL_OSCC_NOT_COMPLIANT = $0000;
  SQL_OSCC_COMPLIANT = $0001;

  // SQL_ODBC_SQL_CONFORMANCE values
  SQL_OSC_MINIMUM = $0000;
  SQL_OSC_CORE = $0001;
  SQL_OSC_EXTENDED = $0002;

  // SQL_CONCAT_NULL_BEHAVIOR values
  SQL_CB_NULL = $0000;
  SQL_CB_NON_NULL = $0001;

  // SQL_SCROLL_OPTIONS masks
  SQL_SO_FORWARD_ONLY = $00000001;
  SQL_SO_KEYSET_DRIVEN = $00000002;
  SQL_SO_DYNAMIC = $00000004;
  SQL_SO_MIXED = $00000008;
  SQL_SO_STATIC = $00000010;

  // SQL_FETCH_DIRECTION masks
  SQL_FD_FETCH_RESUME = $00000040; // SQL_FETCH_RESUME is no longer supported
  SQL_FD_FETCH_BOOKMARK = $00000080;

  // SQL_TXN_ISOLATION_OPTION masks
  SQL_TXN_VERSIONING = $00000010; // SQL_TXN_VERSIONING is no longer supported

  // SQL_CORRELATION_NAME values
  SQL_CN_NONE = $0000;
  SQL_CN_DIFFERENT = $0001;
  SQL_CN_ANY = $0002;

  // SQL_NON_NULLABLE_COLUMNS values
  SQL_NNC_NULL = $0000;
  SQL_NNC_NON_NULL = $0001;

  // SQL_NULL_COLLATION values
  SQL_NC_START = $0002;
  SQL_NC_END = $0004;

  // SQL_FILE_USAGE values
  SQL_FILE_NOT_SUPPORTED = $0000;
  SQL_FILE_TABLE = $0001;
  SQL_FILE_QUALIFIER = $0002;
  SQL_FILE_CATALOG = SQL_FILE_QUALIFIER; // ODBC 3.0

  // SQL_GETDATA_EXTENSIONS values
  SQL_GD_BLOCK = $00000004;
  SQL_GD_BOUND = $00000008;

  // SQL_POSITIONED_STATEMENTS masks
  SQL_PS_POSITIONED_DELETE = $00000001;
  SQL_PS_POSITIONED_UPDATE = $00000002;
  SQL_PS_SELECT_FOR_UPDATE = $00000004;

  // SQL_GROUP_BY values
  SQL_GB_NOT_SUPPORTED = $0000;
  SQL_GB_GROUP_BY_EQUALS_SELECT = $0001;
  SQL_GB_GROUP_BY_CONTAINS_SELECT = $0002;
  SQL_GB_NO_RELATION = $0003;
  SQL_GB_COLLATE = $0004;

  // SQL_OWNER_USAGE masks
  SQL_OU_DML_STATEMENTS = $00000001;
  SQL_OU_PROCEDURE_INVOCATION = $00000002;
  SQL_OU_TABLE_DEFINITION = $00000004;
  SQL_OU_INDEX_DEFINITION = $00000008;
  SQL_OU_PRIVILEGE_DEFINITION = $00000010;

  // SQL_SCHEMA_USAGE masks
  SQL_SU_DML_STATEMENTS = SQL_OU_DML_STATEMENTS;
  SQL_SU_PROCEDURE_INVOCATION = SQL_OU_PROCEDURE_INVOCATION;
  SQL_SU_TABLE_DEFINITION = SQL_OU_TABLE_DEFINITION;
  SQL_SU_INDEX_DEFINITION = SQL_OU_INDEX_DEFINITION;
  SQL_SU_PRIVILEGE_DEFINITION = SQL_OU_PRIVILEGE_DEFINITION;

  // SQL_QUALIFIER_USAGE masks
  SQL_QU_DML_STATEMENTS = $00000001;
  SQL_QU_PROCEDURE_INVOCATION = $00000002;
  SQL_QU_TABLE_DEFINITION = $00000004;
  SQL_QU_INDEX_DEFINITION = $00000008;
  SQL_QU_PRIVILEGE_DEFINITION = $00000010;

  // SQL_CATALOG_USAGE masks
  SQL_CU_DML_STATEMENTS = SQL_QU_DML_STATEMENTS;
  SQL_CU_PROCEDURE_INVOCATION = SQL_QU_PROCEDURE_INVOCATION;
  SQL_CU_TABLE_DEFINITION = SQL_QU_TABLE_DEFINITION;
  SQL_CU_INDEX_DEFINITION = SQL_QU_INDEX_DEFINITION;
  SQL_CU_PRIVILEGE_DEFINITION = SQL_QU_PRIVILEGE_DEFINITION;

  // SQL_SUBQUERIES masks
  SQL_SQ_COMPARISON = $00000001;
  SQL_SQ_EXISTS = $00000002;
  SQL_SQ_IN = $00000004;
  SQL_SQ_QUANTIFIED = $00000008;
  SQL_SQ_CORRELATED_SUBQUERIES = $00000010;

  // SQL_UNION masks
  SQL_U_UNION = $00000001;
  SQL_U_UNION_ALL = $00000002;

  // SQL_BOOKMARK_PERSISTENCE values
  SQL_BP_CLOSE = $00000001;
  SQL_BP_DELETE = $00000002;
  SQL_BP_DROP = $00000004;
  SQL_BP_TRANSACTION = $00000008;
  SQL_BP_UPDATE = $00000010;
  SQL_BP_OTHER_HSTMT = $00000020;
  SQL_BP_SCROLL = $00000040;

  // SQL_STATIC_SENSITIVITY values
  SQL_SS_ADDITIONS = $00000001;
  SQL_SS_DELETIONS = $00000002;
  SQL_SS_UPDATES = $00000004;

  // SQL_VIEW values
  SQL_CV_CREATE_VIEW = $00000001;
  SQL_CV_CHECK_OPTION = $00000002;
  SQL_CV_CASCADED = $00000004;
  SQL_CV_LOCAL = $00000008;

  // SQL_LOCK_TYPES masks
  SQL_LCK_NO_CHANGE = $00000001;
  SQL_LCK_EXCLUSIVE = $00000002;
  SQL_LCK_UNLOCK = $00000004;

  // SQL_POS_OPERATIONS masks
  SQL_POS_POSITION = $00000001;
  SQL_POS_REFRESH = $00000002;
  SQL_POS_UPDATE = $00000004;
  SQL_POS_DELETE = $00000008;
  SQL_POS_ADD = $00000010;

  // SQL_QUALIFIER_LOCATION values
  SQL_QL_START = $0001;
  SQL_QL_END = $0002;

  // Here start return values for ODBC 3.0 SQLGetInfo

  // SQL_AGGREGATE_FUNCTIONS bitmasks
  SQL_AF_AVG = $00000001;
  SQL_AF_COUNT = $00000002;
  SQL_AF_MAX = $00000004;
  SQL_AF_MIN = $00000008;
  SQL_AF_SUM = $00000010;
  SQL_AF_DISTINCT = $00000020;
  SQL_AF_ALL = $00000040;

  // SQL_SQL_CONFORMANCE bit masks
  SQL_SC_SQL92_ENTRY = $00000001;
  SQL_SC_FIPS127_2_TRANSITIONAL = $00000002;
  SQL_SC_SQL92_INTERMEDIATE = $00000004;
  SQL_SC_SQL92_FULL = $00000008;

  // SQL_DATETIME_LITERALS masks
  SQL_DL_SQL92_DATE = $00000001;
  SQL_DL_SQL92_TIME = $00000002;
  SQL_DL_SQL92_TIMESTAMP = $00000004;
  SQL_DL_SQL92_INTERVAL_YEAR = $00000008;
  SQL_DL_SQL92_INTERVAL_MONTH = $00000010;
  SQL_DL_SQL92_INTERVAL_DAY = $00000020;
  SQL_DL_SQL92_INTERVAL_HOUR = $00000040;
  SQL_DL_SQL92_INTERVAL_MINUTE = $00000080;
  SQL_DL_SQL92_INTERVAL_SECOND = $00000100;
  SQL_DL_SQL92_INTERVAL_YEAR_TO_MONTH = $00000200;
  SQL_DL_SQL92_INTERVAL_DAY_TO_HOUR = $00000400;
  SQL_DL_SQL92_INTERVAL_DAY_TO_MINUTE = $00000800;
  SQL_DL_SQL92_INTERVAL_DAY_TO_SECOND = $00001000;
  SQL_DL_SQL92_INTERVAL_HOUR_TO_MINUTE = $00002000;
  SQL_DL_SQL92_INTERVAL_HOUR_TO_SECOND = $00004000;
  SQL_DL_SQL92_INTERVAL_MINUTE_TO_SECOND = $00008000;

  // SQL_CATALOG_LOCATION values
  SQL_CL_START = SQL_QL_START;
  SQL_CL_END = SQL_QL_END;

  // values for SQL_BATCH_ROW_COUNT
  SQL_BRC_PROCEDURES = $0000001;
  SQL_BRC_EXPLICIT = $0000002;
  SQL_BRC_ROLLED_UP = $0000004;

  // bitmasks for SQL_BATCH_SUPPORT
  SQL_BS_SELECT_EXPLICIT = $00000001;
  SQL_BS_ROW_COUNT_EXPLICIT = $00000002;
  SQL_BS_SELECT_PROC = $00000004;
  SQL_BS_ROW_COUNT_PROC = $00000008;

  // Values for SQL_PARAM_ARRAY_ROW_COUNTS getinfo
  SQL_PARC_BATCH = 1;
  SQL_PARC_NO_BATCH = 2;

  // values for SQL_PARAM_ARRAY_SELECTS
  SQL_PAS_BATCH = 1;
  SQL_PAS_NO_BATCH = 2;
  SQL_PAS_NO_SELECT = 3;

  // Bitmasks for SQL_INDEX_KEYWORDS
  SQL_IK_NONE = $00000000;
  SQL_IK_ASC = $00000001;
  SQL_IK_DESC = $00000002;
  SQL_IK_ALL = (SQL_IK_ASC or SQL_IK_DESC);

  // Bitmasks for SQL_INFO_SCHEMA_VIEWS
  SQL_ISV_ASSERTIONS = $00000001;
  SQL_ISV_CHARACTER_SETS = $00000002;
  SQL_ISV_CHECK_CONSTRAINTS = $00000004;
  SQL_ISV_COLLATIONS = $00000008;
  SQL_ISV_COLUMN_DOMAIN_USAGE = $00000010;
  SQL_ISV_COLUMN_PRIVILEGES = $00000020;
  SQL_ISV_COLUMNS = $00000040;
  SQL_ISV_CONSTRAINT_COLUMN_USAGE = $00000080;
  SQL_ISV_CONSTRAINT_TABLE_USAGE = $00000100;
  SQL_ISV_DOMAIN_CONSTRAINTS = $00000200;
  SQL_ISV_DOMAINS = $00000400;
  SQL_ISV_KEY_COLUMN_USAGE = $00000800;
  SQL_ISV_REFERENTIAL_CONSTRAINTS = $00001000;
  SQL_ISV_SCHEMATA = $00002000;
  SQL_ISV_SQL_LANGUAGES = $00004000;
  SQL_ISV_TABLE_CONSTRAINTS = $00008000;
  SQL_ISV_TABLE_PRIVILEGES = $00010000;
  SQL_ISV_TABLES = $00020000;
  SQL_ISV_TRANSLATIONS = $00040000;
  SQL_ISV_USAGE_PRIVILEGES = $00080000;
  SQL_ISV_VIEW_COLUMN_USAGE = $00100000;
  SQL_ISV_VIEW_TABLE_USAGE = $00200000;
  SQL_ISV_VIEWS = $00400000;

  // Bitmasks for SQL_ASYNC_MODE
  // Already declared in sql.h
  {
    SQL_AM_NONE = 0;
    SQL_AM_CONNECTION = 1;
    SQL_AM_STATEMENT = 2;
  }

  // Bitmasks for SQL_ALTER_DOMAIN
  SQL_AD_CONSTRAINT_NAME_DEFINITION = $00000001;
  SQL_AD_ADD_DOMAIN_CONSTRAINT = $00000002;
  SQL_AD_DROP_DOMAIN_CONSTRAINT = $00000004;
  SQL_AD_ADD_DOMAIN_DEFAULT = $00000008;
  SQL_AD_DROP_DOMAIN_DEFAULT = $00000010;
  SQL_AD_ADD_CONSTRAINT_INITIALLY_DEFERRED = $00000020;
  SQL_AD_ADD_CONSTRAINT_INITIALLY_IMMEDIATE = $00000040;
  SQL_AD_ADD_CONSTRAINT_DEFERRABLE = $00000080;
  SQL_AD_ADD_CONSTRAINT_NON_DEFERRABLE = $00000100;

  // SQL_CREATE_SCHEMA bitmasks
  SQL_CS_CREATE_SCHEMA = $00000001;
  SQL_CS_AUTHORIZATION = $00000002;
  SQL_CS_DEFAULT_CHARACTER_SET = $00000004;

  // SQL_CREATE_TRANSLATION bitmasks
  SQL_CTR_CREATE_TRANSLATION = $00000001;

  // SQL_CREATE_ASSERTION bitmasks
  SQL_CA_CREATE_ASSERTION = $00000001;
  SQL_CA_CONSTRAINT_INITIALLY_DEFERRED = $00000010;
  SQL_CA_CONSTRAINT_INITIALLY_IMMEDIATE = $00000020;
  SQL_CA_CONSTRAINT_DEFERRABLE = $00000040;
  SQL_CA_CONSTRAINT_NON_DEFERRABLE = $00000080;

  // SQL_CREATE_CHARACTER_SET bitmasks
  SQL_CCS_CREATE_CHARACTER_SET = $00000001;
  SQL_CCS_COLLATE_CLAUSE = $00000002;
  SQL_CCS_LIMITED_COLLATION = $00000004;

  // SQL_CREATE_COLLATION bitmasks
  SQL_CCOL_CREATE_COLLATION = $00000001;

  // SQL_CREATE_DOMAIN bitmasks
  SQL_CDO_CREATE_DOMAIN = $00000001;
  SQL_CDO_DEFAULT = $00000002;
  SQL_CDO_CONSTRAINT = $00000004;
  SQL_CDO_COLLATION = $00000008;
  SQL_CDO_CONSTRAINT_NAME_DEFINITION = $00000010;
  SQL_CDO_CONSTRAINT_INITIALLY_DEFERRED = $00000020;
  SQL_CDO_CONSTRAINT_INITIALLY_IMMEDIATE = $00000040;
  SQL_CDO_CONSTRAINT_DEFERRABLE = $00000080;
  SQL_CDO_CONSTRAINT_NON_DEFERRABLE = $00000100;

  // SQL_CREATE_TABLE bitmasks
  SQL_CT_CREATE_TABLE = $00000001;
  SQL_CT_COMMIT_PRESERVE = $00000002;
  SQL_CT_COMMIT_DELETE = $00000004;
  SQL_CT_GLOBAL_TEMPORARY = $00000008;
  SQL_CT_LOCAL_TEMPORARY = $00000010;
  SQL_CT_CONSTRAINT_INITIALLY_DEFERRED = $00000020;
  SQL_CT_CONSTRAINT_INITIALLY_IMMEDIATE = $00000040;
  SQL_CT_CONSTRAINT_DEFERRABLE = $00000080;
  SQL_CT_CONSTRAINT_NON_DEFERRABLE = $00000100;
  SQL_CT_COLUMN_CONSTRAINT = $00000200;
  SQL_CT_COLUMN_DEFAULT = $00000400;
  SQL_CT_COLUMN_COLLATION = $00000800;
  SQL_CT_TABLE_CONSTRAINT = $00001000;
  SQL_CT_CONSTRAINT_NAME_DEFINITION = $00002000;

  // SQL_DDL_INDEX bitmasks
  SQL_DI_CREATE_INDEX = $00000001;
  SQL_DI_DROP_INDEX = $00000002;

  // SQL_DROP_COLLATION bitmasks
  SQL_DC_DROP_COLLATION = $00000001;

  // SQL_DROP_DOMAIN bitmasks
  SQL_DD_DROP_DOMAIN = $00000001;
  SQL_DD_RESTRICT = $00000002;
  SQL_DD_CASCADE = $00000004;

  // SQL_DROP_SCHEMA bitmasks
  SQL_DS_DROP_SCHEMA = $00000001;
  SQL_DS_RESTRICT = $00000002;
  SQL_DS_CASCADE = $00000004;

  // SQL_DROP_CHARACTER_SET bitmasks
  SQL_DCS_DROP_CHARACTER_SET = $00000001;

  // SQL_DROP_ASSERTION bitmasks
  SQL_DA_DROP_ASSERTION = $00000001;

  // SQL_DROP_TABLE bitmasks
  SQL_DT_DROP_TABLE = $00000001;
  SQL_DT_RESTRICT = $00000002;
  SQL_DT_CASCADE = $00000004;

  // SQL_DROP_TRANSLATION bitmasks
  SQL_DTR_DROP_TRANSLATION = $00000001;

  // SQL_DROP_VIEW bitmasks
  SQL_DV_DROP_VIEW = $00000001;
  SQL_DV_RESTRICT = $00000002;
  SQL_DV_CASCADE = $00000004;

  // SQL_INSERT_STATEMENT bitmasks
  SQL_IS_INSERT_LITERALS = $00000001;
  SQL_IS_INSERT_SEARCHED = $00000002;
  SQL_IS_SELECT_INTO = $00000004;

  // SQL_ODBC_INTERFACE_CONFORMANCE values
  SQL_OIC_CORE = ULong(1);
  SQL_OIC_LEVEL1 = ULong(2);
  SQL_OIC_LEVEL2 = ULong(3);

  // SQL_SQL92_FOREIGN_KEY_DELETE_RULE bitmasks
  SQL_SFKD_CASCADE = $00000001;
  SQL_SFKD_NO_ACTION = $00000002;
  SQL_SFKD_SET_DEFAULT = $00000004;
  SQL_SFKD_SET_NULL = $00000008;

  // SQL_SQL92_FOREIGN_KEY_UPDATE_RULE bitmasks
  SQL_SFKU_CASCADE = $00000001;
  SQL_SFKU_NO_ACTION = $00000002;
  SQL_SFKU_SET_DEFAULT = $00000004;
  SQL_SFKU_SET_NULL = $00000008;

  // SQL_SQL92_GRANT bitmasks
  SQL_SG_USAGE_ON_DOMAIN = $00000001;
  SQL_SG_USAGE_ON_CHARACTER_SET = $00000002;
  SQL_SG_USAGE_ON_COLLATION = $00000004;
  SQL_SG_USAGE_ON_TRANSLATION = $00000008;
  SQL_SG_WITH_GRANT_OPTION = $00000010;
  SQL_SG_DELETE_TABLE = $00000020;
  SQL_SG_INSERT_TABLE = $00000040;
  SQL_SG_INSERT_COLUMN = $00000080;
  SQL_SG_REFERENCES_TABLE = $00000100;
  SQL_SG_REFERENCES_COLUMN = $00000200;
  SQL_SG_SELECT_TABLE = $00000400;
  SQL_SG_UPDATE_TABLE = $00000800;
  SQL_SG_UPDATE_COLUMN = $00001000;

  // SQL_SQL92_PREDICATES bitmasks
  SQL_SP_EXISTS = $00000001;
  SQL_SP_ISNOTNULL = $00000002;
  SQL_SP_ISNULL = $00000004;
  SQL_SP_MATCH_FULL = $00000008;
  SQL_SP_MATCH_PARTIAL = $00000010;
  SQL_SP_MATCH_UNIQUE_FULL = $00000020;
  SQL_SP_MATCH_UNIQUE_PARTIAL = $00000040;
  SQL_SP_OVERLAPS = $00000080;
  SQL_SP_UNIQUE = $00000100;
  SQL_SP_LIKE = $00000200;
  SQL_SP_IN = $00000400;
  SQL_SP_BETWEEN = $00000800;
  SQL_SP_COMPARISON = $00001000;
  SQL_SP_QUANTIFIED_COMPARISON = $00002000;

  // SQL_SQL92_RELATIONAL_JOIN_OPERATORS bitmasks
  SQL_SRJO_CORRESPONDING_CLAUSE = $00000001;
  SQL_SRJO_CROSS_JOIN = $00000002;
  SQL_SRJO_EXCEPT_JOIN = $00000004;
  SQL_SRJO_FULL_OUTER_JOIN = $00000008;
  SQL_SRJO_INNER_JOIN = $00000010;
  SQL_SRJO_INTERSECT_JOIN = $00000020;
  SQL_SRJO_LEFT_OUTER_JOIN = $00000040;
  SQL_SRJO_NATURAL_JOIN = $00000080;
  SQL_SRJO_RIGHT_OUTER_JOIN = $00000100;
  SQL_SRJO_UNION_JOIN = $00000200;

  // SQL_SQL92_REVOKE bitmasks
  SQL_SR_USAGE_ON_DOMAIN = $00000001;
  SQL_SR_USAGE_ON_CHARACTER_SET = $00000002;
  SQL_SR_USAGE_ON_COLLATION = $00000004;
  SQL_SR_USAGE_ON_TRANSLATION = $00000008;
  SQL_SR_GRANT_OPTION_FOR = $00000010;
  SQL_SR_CASCADE = $00000020;
  SQL_SR_RESTRICT = $00000040;
  SQL_SR_DELETE_TABLE = $00000080;
  SQL_SR_INSERT_TABLE = $00000100;
  SQL_SR_INSERT_COLUMN = $00000200;
  SQL_SR_REFERENCES_TABLE = $00000400;
  SQL_SR_REFERENCES_COLUMN = $00000800;
  SQL_SR_SELECT_TABLE = $00001000;
  SQL_SR_UPDATE_TABLE = $00002000;
  SQL_SR_UPDATE_COLUMN = $00004000;

  // SQL_SQL92_ROW_VALUE_CONSTRUCTOR bitmasks
  SQL_SRVC_VALUE_EXPRESSION = $00000001;
  SQL_SRVC_NULL = $00000002;
  SQL_SRVC_DEFAULT = $00000004;
  SQL_SRVC_ROW_SUBQUERY = $00000008;

  // SQL_SQL92_VALUE_EXPRESSIONS bitmasks
  SQL_SVE_CASE = $00000001;
  SQL_SVE_CAST = $00000002;
  SQL_SVE_COALESCE = $00000004;
  SQL_SVE_NULLIF = $00000008;

  // SQL_STANDARD_CLI_CONFORMANCE bitmasks
  SQL_SCC_XOPEN_CLI_VERSION1 = $00000001;
  SQL_SCC_ISO92_CLI = $00000002;

  // SQL_UNION_STATEMENT bitmasks
  SQL_US_UNION = SQL_U_UNION;
  SQL_US_UNION_ALL = SQL_U_UNION_ALL;

  // SQL_DTC_TRANSITION_COST bitmasks
  SQL_DTC_ENLIST_EXPENSIVE = $00000001;
  SQL_DTC_UNENLIST_EXPENSIVE = $00000002;

  // additional SQLDataSources fetch directions
  SQL_FETCH_FIRST_USER = 31;
  SQL_FETCH_FIRST_SYSTEM = 32;

  // Defines for SQLSetPos
  SQL_ENTIRE_ROWSET = 0;

  // Operations in SQLSetPos
  SQL_POSITION = 0; // 1.0 FALSE
  SQL_REFRESH = 1; // 1.0 TRUE
  SQL_UPDATE = 2;
  SQL_DELETE = 3;

  // Operations in SQLBulkOperations
  SQL_ADD = 4;
  SQL_SETPOS_MAX_OPTION_VALUE = SQL_ADD;
  SQL_UPDATE_BY_BOOKMARK = 5;
  SQL_DELETE_BY_BOOKMARK = 6;
  SQL_FETCH_BY_BOOKMARK = 7;

  // Lock options in SQLSetPos
  SQL_LOCK_NO_CHANGE = 0; // 1.0 FALSE
  SQL_LOCK_EXCLUSIVE = 1; // 1.0 TRUE
  SQL_LOCK_UNLOCK = 2;

  SQL_SETPOS_MAX_LOCK_VALUE = SQL_LOCK_UNLOCK;

  // Macros for SQLSetPos
function SQL_POSITION_TO(HStmt: SqlHStmt; irow: SqlUSmallint): SqlReturn;
function SQL_LOCK_RECORD(HStmt: SqlHStmt; irow, fLock: SqlUSmallint): SqlReturn;
function SQL_REFRESH_RECORD(HStmt: SqlHStmt; irow, fLock: SqlUSmallint): SqlReturn;
function SQL_UPDATE_RECORD(HStmt: SqlHStmt; irow: SqlUSmallint): SqlReturn;
function SQL_DELETE_RECORD(HStmt: SqlHStmt; irow: SqlUSmallint): SqlReturn;
function SQL_ADD_RECORD(HStmt: SqlHStmt; irow: SqlUSmallint): SqlReturn;

const

  // Column types and scopes in SQLSpecialColumns.
  SQL_BEST_ROWID = 1;
  SQL_ROWVER = 2;

  // Defines for SQLSpecialColumns (returned in the result set
  //= SQL_PC_UNKNOWN and SQL_PC_PSEUDO are defined in sql.h
  SQL_PC_NOT_PSEUDO = 1;

  // Defines for SQLStatistics
  SQL_QUICK = 0;
  SQL_ENSURE = 1;

  // Defines for SQLStatistics (returned in the result set)
  //-SQL_INDEX_CLUSTERED, SQL_INDEX_HASHED, and SQL_INDEX_OTHER are
  //=defined in sql.h
  SQL_TABLE_STAT = 0;

  // Defines for SQLTables
  SQL_ALL_CATALOGS = '%';
  SQL_ALL_SCHEMAS = '%';
  SQL_ALL_TABLE_TYPES = '%';

  // Options for SQLDriverConnect
  SQL_DRIVER_NOPROMPT = 0;
  SQL_DRIVER_COMPLETE = 1;
  SQL_DRIVER_PROMPT = 2;
  SQL_DRIVER_COMPLETE_REQUIRED = 3;

{$IFDEF DynamicOdbcImport}
type
  TSQLDriverConnect = function(
{$ELSE}
function SQLDriverConnect(
{$ENDIF}
  HDbc: SqlHDbc;
  hwnd: SqlHWnd;
  szConnStrIn: PAnsiChar;
  cbConnStrIn: SqlSmallint;
  szConnStrOut: PAnsiChar;
  cbConnStrOutMax: SqlSmallint;
  var pcbConnStrOut: SqlSmallint;
  fDriverCompletion: SqlUSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

// Level 2 Functions

// SQLExtendedFetch "fFetchType" values
const
  SQL_FETCH_BOOKMARK = 8;

  // SQLExtendedFetch "rgfRowStatus" element values
  SQL_ROW_SUCCESS = 0;
  SQL_ROW_DELETED = 1;
  SQL_ROW_UPDATED = 2;
  SQL_ROW_NOROW = 3;
  SQL_ROW_ADDED = 4;
  SQL_ROW_ERROR = 5;
  SQL_ROW_SUCCESS_WITH_INFO = 6;
  SQL_ROW_PROCEED = 0;
  SQL_ROW_IGNORE = 1;

  // value for SQL_DESC_ARRAY_STATUS_PTR
  SQL_PARAM_SUCCESS = 0;
  SQL_PARAM_SUCCESS_WITH_INFO = 6;
  SQL_PARAM_ERROR = 5;
  SQL_PARAM_UNUSED = 7;
  SQL_PARAM_DIAG_UNAVAILABLE = 1;
  SQL_PARAM_PROCEED = 0;
  SQL_PARAM_IGNORE = 1;

  // Defines for SQLForeignKeys (UPDATE_RULE and DELETE_RULE)
  SQL_CASCADE = 0;
  SQL_RESTRICT = 1;
  SQL_SET_NULL = 2;
  SQL_NO_ACTION = 3;
  SQL_SET_DEFAULT = 4;

  // Note that the following are in a different column of SQLForeignKeys than
  // the previous #defines.   These are for DEFERRABILITY.
  SQL_INITIALLY_DEFERRED = 5;
  SQL_INITIALLY_IMMEDIATE = 6;
  SQL_NOT_DEFERRABLE = 7;

  // SQLBindParameter block
  // WAS ORIGINALLY HERE
  // Moved above because of dependent declarations

  // Defines for SQLProcedures (returned in the result set)
  SQL_PT_UNKNOWN = 0;
  SQL_PT_PROCEDURE = 1;
  SQL_PT_FUNCTION = 2;

  // This define is too large for RC
  SQL_ODBC_KEYWORDS =
    'ABSOLUTE,ACTION,ADA,ADD,ALL,ALLOCATE,ALTER,AND,ANY,ARE,AS,' +
    'ASC,ASSERTION,AT,AUTHORIZATION,AVG,' +
    'BEGIN,BETWEEN,BIT,BIT_LENGTH,BOTH,BY,CASCADE,CASCADED,CASE,CAST,CATALOG,' +
    'CHAR,CHAR_LENGTH,CHARACTER,CHARACTER_LENGTH,CHECK,CLOSE,COALESCE,' +
    'COLLATE,COLLATION,COLUMN,COMMIT,CONNECT,CONNECTION,CONSTRAINT,' +
    'CONSTRAINTS,CONTINUE,CONVERT,CORRESPONDING,COUNT,CREATE,CROSS,CURRENT,' +
    'CURRENT_DATE,CURRENT_TIME,CURRENT_TIMESTAMP,CURRENT_USER,CURSOR,' +
    'DATE,DAY,DEALLOCATE,DEC,DECIMAL,DECLARE,DEFAULT,DEFERRABLE,' +
    'DEFERRED,DELETE,DESC,DESCRIBE,DESCRIPTOR,DIAGNOSTICS,DISCONNECT,' +
    'DISTINCT,DOMAIN,DOUBLE,DROP,' +
    'ELSE,END,END-EXEC,ESCAPE,EXCEPT,EXCEPTION,EXEC,EXECUTE,' +
    'EXISTS,EXTERNAL,EXTRACT,' +
    'FALSE,FETCH,FIRST,FLOAT,FOR,FOREIGN,FORTRAN,FOUND,FROM,FULL,' +
    'GET,GLOBAL,GO,GOTO,GRANT,GROUP,HAVING,HOUR,' +
    'IDENTITY,IMMEDIATE,IN,INCLUDE,INDEX,INDICATOR,INITIALLY,INNER,' +
    'INPUT,INSENSITIVE,INSERT,INT,INTEGER,INTERSECT,INTERVAL,INTO,IS,ISOLATION,' +
    'JOIN,KEY,LANGUAGE,LAST,LEADING,LEFT,LEVEL,LIKE,LOCAL,LOWER,' +
    'MATCH,MAX,MIN,MINUTE,MODULE,MONTH,' +
    'NAMES,NATIONAL,NATURAL,NCHAR,NEXT,NO,NONE,NOT,NULL,NULLIF,NUMERIC,' +
    'OCTET_LENGTH,OF,ON,ONLY,OPEN,OPTION,OR,ORDER,OUTER,OUTPUT,OVERLAPS,' +
    'PAD,PARTIAL,PASCAL,PLI,POSITION,PRECISION,PREPARE,PRESERVE,' +
    'PRIMARY,PRIOR,PRIVILEGES,PROCEDURE,PUBLIC,' +
    'READ,REAL,REFERENCES,RELATIVE,RESTRICT,REVOKE,RIGHT,ROLLBACK,ROWS' +
    'SCHEMA,SCROLL,SECOND,SECTION,SELECT,SESSION,SESSION_USER,SET,SIZE,' +
    'SMALLINT,SOME,SPACE,SQL,SQLCA,SQLCODE,SQLERROR,SQLSTATE,SQLWARNING,' +
    'SUBSTRING,SUM,SYSTEM_USER,' +
    'TABLE,TEMPORARY,THEN,TIME,TIMESTAMP,TIMEZONE_HOUR,TIMEZONE_MINUTE,' +
    'TO,TRAILING,TRANSACTION,TRANSLATE,TRANSLATION,TRIM,TRUE,' +
    'UNION,UNIQUE,UNKNOWN,UPDATE,UPPER,USAGE,USER,USING,' +
    'VALUE,VALUES,VARCHAR,VARYING,VIEW,WHEN,WHENEVER,WHERE,WITH,WORK,WRITE,' +
    'YEAR,ZONE';

{$IFDEF DynamicOdbcImport}
type
  TSQLBrowseConnect = function(
{$ELSE}
function SQLBrowseConnect(
{$ENDIF}
  HDbc: SqlHDbc;
  var szConnStrIn: SqlChar;
  cbConnStrIn: SqlSmallint;
  var szConnStrOut: SqlChar;
  cbConnStrOutMax: SqlSmallint;
  var pcbConnStrOut: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLBulkOperations = function(
{$ELSE}
function SQLBulkOperations(
{$ENDIF}
  StatementHandle: SqlHStmt;
  Operation: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLColAttributes = function(
{$ELSE}
function SQLColAttributes(
{$ENDIF}
  HStmt: SqlHStmt;
  icol: SqlUSmallint;
  fDescType: SqlUSmallint;
  rgbDesc: SqlPointer;
  cbDescMax: SqlSmallint;
  var pcbDesc: SqlSmallint;
  var pfDesc: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLColumnPrivileges = function(
{$ELSE}
function SQLColumnPrivileges(
{$ENDIF}
  HStmt: SqlHStmt;
  var szCatalogName: SqlChar;
  cbCatalogName: SqlSmallint;
  var szSchemaName: SqlChar;
  cbSchemaName: SqlSmallint;
  var szTableName: SqlChar;
  cbTableName: SqlSmallint;
  var szColumnName: SqlChar;
  cbColumnName: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLDescribeParam = function(
{$ELSE}
function SQLDescribeParam(
{$ENDIF}
  HStmt: SqlHStmt;
  ipar: SqlUSmallint;
  var pfSqlType: SqlSmallint;
  var pcbParamDef: SqlUInteger;
  var pibScale: SqlSmallint;
  var pfNullable: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLExtendedFetch = function(
{$ELSE}
function SQLExtendedFetch(
{$ENDIF}
  HStmt: SqlHStmt;
  fFetchType: SqlUSmallint;
  irow: SqlInteger;
  var pcrow: SqlUInteger;
  var rgfRowStatus: SqlUSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLForeignKeys = function(
{$ELSE}
function SQLForeignKeys(
{$ENDIF}
  HStmt: SqlHStmt;
  var szPkCatalogName: SqlChar;
  cbPkCatalogName: SqlSmallint;
  var szPkSchemaName: SqlChar;
  cbPkSchemaName: SqlSmallint;
  var szPkTableName: SqlChar;
  cbPkTableName: SqlSmallint;
  var szFkCatalogName: SqlChar;
  cbFkCatalogName: SqlSmallint;
  var szFkSchemaName: SqlChar;
  cbFkSchemaName: SqlSmallint;
  var szFkTableName: SqlChar;
  cbFkTableName: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLMoreResults = function(
{$ELSE}
function SQLMoreResults(
{$ENDIF}
  HStmt: SqlHStmt
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLNativeSql = function(
{$ELSE}
function SQLNativeSql(
{$ENDIF}
  HDbc: SqlHDbc;
  var szSqlStrIn: SqlChar;
  cbSqlStrIn: SqlInteger;
  var szSqlStr: SqlChar;
  cbSqlStrMax: SqlInteger;
  var pcbSqlStr: SqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLNumParams = function(
{$ELSE}
function SQLNumParams(
{$ENDIF}
  HStmt: SqlHStmt;
  var pcpar: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLParamOptions = function(
{$ELSE}
function SQLParamOptions(
{$ENDIF}
  HStmt: SqlHStmt;
  crow: SqlUInteger;
  var pirow: SqlUInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLPrimaryKeys = function(
{$ELSE}
function SQLPrimaryKeys(
{$ENDIF}
  HStmt: SqlHStmt;
  szCatalogName: PAnsiChar;
  cbCatalogName: SqlSmallint;
  szSchemaName: PAnsiChar;
  cbSchemaName: SqlSmallint;
  szTableName: PAnsiChar;
  cbTableName: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLProcedureColumns = function(
{$ELSE}
function SQLProcedureColumns(
{$ENDIF}
  HStmt: SqlHStmt;
  szCatalogName: PAnsiChar;
  cbCatalogName: SqlSmallint;
  szSchemaName: PAnsiChar;
  cbSchemaName: SqlSmallint;
  szProcName: PAnsiChar;
  cbProcName: SqlSmallint;
  szColumnName: PAnsiChar;
  cbColumnName: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLProcedures = function(
{$ELSE}
function SQLProcedures(
{$ENDIF}
  HStmt: SqlHStmt;
  szCatalogName: PAnsiChar;
  cbCatalogName: SqlSmallint;
  szSchemaName: PAnsiChar;
  cbSchemaName: SqlSmallint;
  szProcName: PAnsiChar;
  cbProcName: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLSetPos = function(
{$ELSE}
function SQLSetPos(
{$ENDIF}
  HStmt: SqlHStmt;
  irow: SqlUSmallint;
  fOption: SqlUSmallint;
  fLock: SqlUSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLTablePrivileges = function(
{$ELSE}
function SQLTablePrivileges(
{$ENDIF}
  HStmt: SqlHStmt;
  var szCatalogName: SqlChar;
  cbCatalogName: SqlSmallint;
  var szSchemaName: SqlChar;
  cbSchemaName: SqlSmallint;
  var szTableName: SqlChar;
  cbTableName: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLDrivers = function(
{$ELSE}
function SQLDrivers(
{$ENDIF}
  HEnv: SqlHEnv;
  fDirection: SqlUSmallint;
  szDriverDesc: PAnsiChar;
  cbDriverDescMax: SqlSmallint;
  var pcbDriverDesc: SqlSmallint;
  szDriverAttributes: PAnsiChar;
  cbDrvrAttrMax: SqlSmallint;
  var pcbDrvrAttr: SqlSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

{$IFDEF DynamicOdbcImport}
TSQLBindParameter = function(
{$ELSE}
function SQLBindParameter(
{$ENDIF}
  HStmt: SqlHStmt;
  ipar: SqlUSmallint;
  fParamType: SqlSmallint;
  fCType: SqlSmallint;
  fSqlType: SqlSmallint;
  cbColDef: SqlUInteger;
  ibScale: SqlSmallint;
  rgbValue: SqlPointer;
  cbValueMax: SqlInteger;
  pcbValue: PSqlInteger
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

//---------------------------------------------------------
// SQLAllocHandleStd is implemented to make SQLAllocHandle
// compatible with X/Open standard. an application should
// not call SQLAllocHandleStd directly
//---------------------------------------------------------

// Internal type subcodes (ODBC_STD, ie X/OPEN)
const
  SQL_YEAR = SQL_CODE_YEAR;
  SQL_MONTH = SQL_CODE_MONTH;
  SQL_DAY = SQL_CODE_DAY;
  SQL_HOUR = SQL_CODE_HOUR;
  SQL_MINUTE = SQL_CODE_MINUTE;
  SQL_SECOND = SQL_CODE_SECOND;
  SQL_YEAR_TO_MONTH = SQL_CODE_YEAR_TO_MONTH;
  SQL_DAY_TO_HOUR = SQL_CODE_DAY_TO_HOUR;
  SQL_DAY_TO_MINUTE = SQL_CODE_DAY_TO_MINUTE;
  SQL_DAY_TO_SECOND = SQL_CODE_DAY_TO_SECOND;
  SQL_HOUR_TO_MINUTE = SQL_CODE_HOUR_TO_MINUTE;
  SQL_HOUR_TO_SECOND = SQL_CODE_HOUR_TO_SECOND;
  SQL_MINUTE_TO_SECOND = SQL_CODE_MINUTE_TO_SECOND;

{$IFDEF DynamicOdbcImport}
type
  TSQLAllocHandleStd = function(
{$ELSE}
function SQLAllocHandleStd(
{$ENDIF}
  fHandleType: SqlSmallint;
  hInput: SqlHandle;
  var phOutput: SqlHandle
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

// Deprecated defines from prior versions of ODBC
const
  SQL_DATABASE_NAME = 16; // Use SQLGetConnectOption/SQL_CURRENT_QUALIFIER
  SQL_FD_FETCH_PREV = SQL_FD_FETCH_PRIOR;
  SQL_FETCH_PREV = SQL_FETCH_PRIOR;
  SQL_CONCUR_TIMESTAMP = SQL_CONCUR_ROWVER;
  SQL_SCCO_OPT_TIMESTAMP = SQL_SCCO_OPT_ROWVER;
  SQL_CC_DELETE = SQL_CB_DELETE;
  SQL_CR_DELETE = SQL_CB_DELETE;
  SQL_CC_CLOSE = SQL_CB_CLOSE;
  SQL_CR_CLOSE = SQL_CB_CLOSE;
  SQL_CC_PRESERVE = SQL_CB_PRESERVE;
  SQL_CR_PRESERVE = SQL_CB_PRESERVE;
  // SQL_FETCH_RESUME is not supported by 2.0+ drivers
  SQL_FETCH_RESUME = 7;
  SQL_SCROLL_FORWARD_ONLY = 0; //-SQL_CURSOR_FORWARD_ONLY
  SQL_SCROLL_KEYSET_DRIVEN = (-1); //-SQL_CURSOR_KEYSET_DRIVEN
  SQL_SCROLL_DYNAMIC = (-2); //-SQL_CURSOR_DYNAMIC
  SQL_SCROLL_STATIC = (-3); //*-SQL_CURSOR_STATIC

  // Deprecated functions from prior versions of ODBC
{$IFDEF DynamicOdbcImport}
type
  TSQLSetScrollOptions = function(
{$ELSE}
function SQLSetScrollOptions(
{$ENDIF}
  // Use SQLSetStmtOptions
  HStmt: SqlHStmt;
  fConcurrency: SqlUSmallint;
  crowKeyset: SqlInteger;
  crowRowset: SqlUSmallint
  ): SqlReturn{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

// Tracing section
{$IFNDEF DynamicOdbcImport}
const
  TRACE_VERSION = 1000; // Version of trace API

function TraceOpenLogFile(
  var _1: WideChar;
  var _2: WideChar;
  _3: Longint
  ): Retcode{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

function TraceCloseLogFile: Retcode{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

procedure TraceReturn(
  _1: Retcode;
  _2: Retcode){$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

function TraceVersion: Longint{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

// Functions for Visual Studio Analyzer
// to turn on/off tracing or VS events,
// call TraceVSControl by setting or clearing the following bits
const
  TRACE_ON = $00000001;
  TRACE_VS_EVENT_ON = $00000002;

function TraceVSControl(_1: Longint): Retcode{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};

// Functions for setting the connection pooling failure detection code
// The "TryWait" value is the time (in seconds) that the DM will wait
// between detecting that a connection is dead (using
// SQL_ATTR_CONNECTION_DEAD) and retrying the connection. During that
// interval, connection requests will get "The server appears to be
// dead" error returns.

function ODBCSetTryWaitValue(dwValue: Longint): LongBool{$IFDEF MSWINDOWS} stdcall{$ELSE}
cdecl{$ENDIF};
//= In seconds

function ODBCGetTryWaitValue: Longint{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF};
//= In Milliseconds(!)

// the flags in ODBC_VS_ARGS
const
  ODBC_VS_FLAG_UNICODE_ARG = $00000001; // the argument is unicode
  ODBC_VS_FLAG_UNICODE_COR = $00000002; // the correlation is unicode
  ODBC_VS_FLAG_RETCODE = $00000004; // RetCode field is set
  ODBC_VS_FLAG_STOP = $00000008; // Stop firing visual studio analyzer events

type
  tagODBC_VS_ARGS = packed record
    PGuidEvent: PGUID; // the GUID for event
    dwFlags: Longword; // flags for the call
    case Integer of
      0: (wszArg: PWideChar;
        szArg: PChar;
        Retcode: Retcode);
      1: (wszCorrelation: PWideChar;
        szCorrelation: PChar;
        RetCode2: Retcode);
  end;

  ODBC_VS_ARGS = tagODBC_VS_ARGS;
  PODBC_VS_ARGS = ^ODBC_VS_ARGS;

procedure FireVSDebugEvent(var Args: ODBC_VS_ARGS);
{$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
{$ENDIF}

//##########################################################################
// sqlext.h interface part ends here
//##########################################################################

{$IFDEF DynamicOdbcImport}
var
  SQLAllocConnect: TSQLAllocConnect;
  SQLAllocEnv: TSQLAllocEnv;
  SQLAllocHandle: TSQLAllocHandle;
  SQLAllocStmt: TSQLAllocStmt;
  SQLBindCol: TSQLBindCol;
  SQLBindParam: TSQLBindParam;
  SQLCancel: TSQLCancel;
  SQLCloseCursor: TSQLCloseCursor;

  // SQLColAttribute is overloaded
  SQLColAttribute: TSQLColAttribute;
  SQLColAttributeString: TSQLColAttributeString;
  SQLColAttributeInt: TSQLColAttributeInt;

  SQLColumns: TSQLColumns;
  SQLConnect: TSQLConnect;
  SQLCopyDesc: TSQLCopyDesc;
  SQLDataSources: TSQLDataSources;
  SQLDescribeCol: TSQLDescribeCol;
  SQLDisconnect: TSQLDisconnect;
  SQLEndTran: TSQLEndTran;
  SQLError: TSQLError;
  SQLExecDirect: TSQLExecDirect;
  SQLExecute: TSQLExecute;
  SQLFetch: TSQLFetch;
  SQLFetchScroll: TSQLFetchScroll;
  SQLFreeConnect: TSQLFreeConnect;
  SQLFreeEnv: TSQLFreeEnv;
  SQLFreeHandle: TSQLFreeHandle;
  SQLFreeStmt: TSQLFreeStmt;

  SQLGetConnectAttr: TSQLGetConnectAttr;
  SQLGetConnectOption: TSQLGetConnectOption;
  SQLGetCursorName: TSQLGetCursorName;
  SQLGetData: TSQLGetData;
  SQLGetDescField: TSQLGetDescField;
  SQLGetDescRec: TSQLGetDescRec;
  SQLGetDiagField: TSQLGetDiagField;
  SQLGetDiagRec: TSQLGetDiagRec;
  SQLGetEnvAttr: TSQLGetEnvAttr;
  SQLGetFunctions: TSQLGetFunctions;

  // SQLGetInfo is overloaded
  SQLGetInfo: TSQLGetInfo;
  SQLGetInfoString: TSQLGetInfoString;
  SQLGetInfoSmallint: TSQLGetInfoSmallint;
  SQLGetInfoInt: TSQLGetInfoInt;

  SQLGetStmtAttr: TSQLGetStmtAttr;
  SQLGetStmtOption: TSQLGetStmtOption;
  SQLGetTypeInfo: TSQLGetTypeInfo;
  SQLNumResultCols: TSQLNumResultCols;
  SQLParamData: TSQLParamData;
  SQLPrepare: TSQLPrepare;
  SQLPutData: TSQLPutData;
  SQLRowCount: TSQLRowCount;
  SQLSetConnectAttr: TSQLSetConnectAttr;
  SQLSetConnectOption: TSQLSetConnectOption;
  SQLSetCursorName: TSQLSetCursorName;
  SQLSetDescField: TSQLSetDescField;
  SQLSetDescRec: TSQLSetDescRec;
  SQLSetEnvAttr: TSQLSetEnvAttr;
  SQLSetParam: TSQLSetParam;
  SQLSetStmtAttr: TSQLSetStmtAttr;
  SQLSetStmtOption: TSQLSetStmtOption;
  SQLSpecialColumns: TSQLSpecialColumns;
  SQLStatistics: TSQLStatistics;
  SQLTables: TSQLTables;
  SQLTransact: TSQLTransact;

  SQLAllocHandleStd: TSQLAllocHandleStd;
  SQLBindParameter: TSQLBindParameter;
  SQLBrowseConnect: TSQLBrowseConnect;
  SQLBulkOperations: TSQLBulkOperations;
  SQLColAttributes: TSQLColAttributes;
  SQLColumnPrivileges: TSQLColumnPrivileges;
  SQLDescribeParam: TSQLDescribeParam;
  SQLDriverConnect: TSQLDriverConnect;
  SQLDrivers: TSQLDrivers;
  SQLExtendedFetch: TSQLExtendedFetch;
  SQLForeignKeys: TSQLForeignKeys;
  SQLMoreResults: TSQLMoreResults;
  SQLNativeSql: TSQLNativeSql;
  SQLNumParams: TSQLNumParams;
  SQLParamOptions: TSQLParamOptions;
  SQLPrimaryKeys: TSQLPrimaryKeys;
  SQLProcedureColumns: TSQLProcedureColumns;
  SQLProcedures: TSQLProcedures;
  SQLSetPos: TSQLSetPos;
  SQLSetScrollOptions: TSQLSetScrollOptions;
  SQLTablePrivileges: TSQLTablePrivileges;
{$ENDIF}

function LoadOdbcDriverManager(LibraryName: PChar): Boolean;
procedure UnLoadOdbcDriverManager;

implementation

{$IFDEF DynamicOdbcImport}
uses
  Windows;
{$ENDIF}

//##########################################################################
// sql.h implementation part starts here
//##########################################################################

const
{$IFDEF MSWINDOWS}
  ODBC32DLL = 'odbc32.dll';
{$ELSE}
  ODBC32DLL = 'libodbc.so';
{$ENDIF}

  // Macro: test for SQL_SUCCESS or SQL_SUCCESS_WITH_INFO

function SQL_SUCCEEDED(const rc: SqlReturn): Boolean;
begin
  Result := (rc and (not 1)) = 0;
end;

{$IFNDEF DynamicOdbcImport}

function SQLAllocConnect;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLAllocEnv;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLAllocHandle;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLAllocStmt;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLBindCol;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLBindParam;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLCancel;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLCloseCursor;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

// SQLColAttribute is overloaded
function SQLColAttribute;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;
function SQLColAttributeString;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL name 'SQLColAttribute';
function SQLColAttributeInt;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL name 'SQLColAttribute';

function SQLColumns;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLConnect;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLCopyDesc;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLDataSources;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLDescribeCol;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLDisconnect;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLEndTran;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLError;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLExecDirect;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLExecute;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLFetch;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLFetchScroll;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLFreeConnect;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLFreeEnv;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLFreeHandle;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLFreeStmt;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetConnectAttr;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetConnectOption;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetCursorName;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetData;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetDescField;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetDescRec;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetDiagField;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetDiagRec;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetEnvAttr;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetFunctions;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

// SQLGetInfo is overloaded
function SQLGetInfo;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;
function SQLGetInfoString;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL name 'SQLGetInfo';
function SQLGetInfoSmallint;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL name 'SQLGetInfo';
function SQLGetInfoInt;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL name 'SQLGetInfo';

function SQLGetStmtAttr;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetStmtOption;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLGetTypeInfo;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLNumResultCols;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLParamData;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLPrepare;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLPutData;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLRowCount;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetConnectAttr;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetConnectOption;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetCursorName;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetDescField;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetDescRec;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetEnvAttr;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetParam;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetStmtAttr;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetStmtOption;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSpecialColumns;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLStatistics;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLTables;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLTransact;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;
{$ENDIF}

//##########################################################################
// sql.h implementation part ends here
//##########################################################################

//##########################################################################
// sqlext.h implementation part starts here
//##########################################################################

const
  ODBCTRAC = 'odbctrac.dll';
  ODBCINST = {$IFDEF MSWINDOWS} 'odbcinst.dll'{$ELSE} 'libodbcinst.so'{$ENDIF};

  // MACROs

function SQL_LEN_DATA_AT_EXEC(length: Integer): Integer;
begin
  result := -(length) + SQL_LEN_DATA_AT_EXEC_OFFSET;
end;

function SQL_LEN_BINARY_ATTR(length: Integer): Integer;
begin
  result := -(length) + SQL_LEN_BINARY_ATTR_OFFSET;
end;

function SQL_FUNC_EXISTS(pfExists: PUWord; uwAPI: UWord): SqlInteger;
begin
  Inc(pfExists, uwAPI shr 4);
  if (pfExists^ and (1 shl (uwAPI and $000F))) <> 0 then
    result := SQL_TRUE
  else
    result := SQL_FALSE;
end;

function SQL_POSITION_TO(HStmt: SqlHStmt; irow: SqlUSmallint): SqlReturn;
begin
  result := SQLSetPos(HStmt, irow, SQL_POSITION, SQL_LOCK_NO_CHANGE);
end;

function SQL_LOCK_RECORD(HStmt: SqlHStmt; irow, fLock: SqlUSmallint): SqlReturn;
begin
  result := SQLSetPos(HStmt, irow, SQL_POSITION, fLock);
end;

function SQL_REFRESH_RECORD(HStmt: SqlHStmt; irow, fLock: SqlUSmallint): SqlReturn;
begin
  result := SQLSetPos(HStmt, irow, SQL_REFRESH, fLock);
end;

function SQL_UPDATE_RECORD(HStmt: SqlHStmt; irow: SqlUSmallint): SqlReturn;
begin
  result := SQLSetPos(HStmt, irow, SQL_UPDATE, SQL_LOCK_NO_CHANGE);
end;

function SQL_DELETE_RECORD(HStmt: SqlHStmt; irow: SqlUSmallint): SqlReturn;
begin
  result := SQLSetPos(HStmt, irow, SQL_DELETE, SQL_LOCK_NO_CHANGE);
end;

function SQL_ADD_RECORD(HStmt: SqlHStmt; irow: SqlUSmallint): SqlReturn;
begin
  result := SQLSetPos(HStmt, irow, SQL_ADD, SQL_LOCK_NO_CHANGE);
end;

{$IFNDEF DynamicOdbcImport}

function SQLAllocHandleStd;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLBindParameter;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLBrowseConnect;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLBulkOperations;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLColAttributes;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLColumnPrivileges;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLDescribeParam;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLDriverConnect;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLDrivers;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLExtendedFetch;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLForeignKeys;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLMoreResults;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLNativeSql;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLNumParams;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLParamOptions;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLPrimaryKeys;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLProcedureColumns;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLProcedures;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetPos;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLSetScrollOptions;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function SQLTablePrivileges;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBC32DLL;

function TraceOpenLogFile;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBCTRAC;

function TraceCloseLogFile;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBCTRAC;

procedure TraceReturn;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBCTRAC;

function TraceVersion;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBCTRAC;

function TraceVSControl;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBCTRAC;

procedure FireVSDebugEvent;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBCTRAC;

function ODBCGetTryWaitValue;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBCINST;

function ODBCSetTryWaitValue;
{$IFDEF MSWINDOWS} stdcall{$ELSE} cdecl{$ENDIF}; external ODBCINST;
{$ENDIF}

//##########################################################################
// sqlext.h implementation part ends here
//##########################################################################

{$IFDEF DynamicOdbcImport}
{$INCLUDE OdbcApiLoad.pas}
{$ELSE}

function LoadOdbcDriverManager(LibraryName: PChar): Boolean;
begin
  Result := True;
end;

procedure UnLoadOdbcDriverManager;
begin
end;
{$ENDIF}

end.
