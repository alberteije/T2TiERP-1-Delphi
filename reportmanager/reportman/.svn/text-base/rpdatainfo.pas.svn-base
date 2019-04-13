{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpdatainfo                                      }
{                                                       }
{                                                       }
{       A collection of information for opening datasets}
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

unit rpdatainfo;

interface

{$I rpconf.inc}


uses Classes,SysUtils,
 {$IFDEF DELPHI2007UP}
{$IFDEF USESQLEXPRESS}
 {$IFDEF REPMANRELEASE}
  DBXCLient,DBXDynaLink,
 {$ENDIF}
{$ENDIF}
 {$ENDIF}
{$IFDEF MSWINDOWS}
 registry,windows,
{$ENDIF}
{$IFDEF LINUX}
 Libc,
{$ENDIF}
{$IFDEF USESQLEXPRESS}
 {$DEFINE USENEWLINK}
  SqlExpr,SqlConst,
 //DBExpMYSQL,DbExpMyS,dbExpDB2,dbExpORA,dbExpINT
 {$IFDEF DELPHI2009UP}
   DBXOracle,DBXInformix,DBXFirebird,DBXInterbase,DBXSyBaseASA,
   DBXSyBaseASE,DBXMSSQL,DBXMySQL,DBXCommon,DBXDb2,
 {$ENDIF}
 {$IFNDEF DELPHI2009UP}
  DBXpress,
 {$ENDIF}
{$ENDIF}
 rpmdconsts,rpmdshfolder,
 DB,rpparams,Inifiles,rptypes,
{$IFDEF USEIBX}
 IBQuery,IBDatabase,
{$ENDIF}
{$IFDEF USEZEOS}
 {$DEFINE USENEWLINK}
 ZDbcIntfs,ZAbstractRODataset, ZDataset, ZConnection,
{$ENDIF}
{$IFDEF USEBDE}
  dbtables,
{$ENDIF}
{$IFDEF USEADO}
 {$IFNDEF DOTNETD}
  adodb,oleauto,
 {$ENDIF}
 {$IFDEF DOTNETD}
  ADONetDb,
 {$ENDIF}
{$ENDIF}
{$IFDEF USEIBO}
  IB_Components,IBODataset,
{$ENDIF}
{$IFDEF USEVARIANTS}
  Variants,Types,
{$ENDIF}
{$IFDEF USERPDATASET}
 rpdataset,
 {$IFNDEF FPC}
  DBClient,
 {$ENDIF}
 {$IFDEF FPC}
  Memds,
 {$ENDIF}
{$ENDIF}
 rpdatatext;

{$IFDEF LINUX}
const
 DBXDRIVERFILENAME='dbxdrivers';
 DBXCONFIGFILENAME='dbxconnections';
{$ENDIF}
type
 TRpDbDriver=(rpdatadbexpress,rpdatamybase,rpdataibx,
  rpdatabde,rpdataado,rpdataibo,rpdatazeos,rpdatadriver,rpdotnet2driver);


 TRpConnAdmin=class(TObject)
  private
  public
   DBXConnectionsOverride:String;
   DBXDriversOverride:String;
   driverfilename:string;
   configfilename:string;
   config:TMemInifile;
   drivers:TMemInifile;
   constructor Create;
   destructor Destroy;override;
   procedure LoadConfig;
   procedure GetDriverNames(alist:TStrings);
   procedure GetConnectionParams(conname:string;params:TStrings);
   procedure GetDriverLibNames(const drivername:string;var LibraryName,VendorLib:string);
   procedure GetConnectionNames(alist:TStrings;drivername:String);
   procedure AddConnection(newname:string;drivername:string);
   procedure DeleteConnection(conname:string);
 end;


 IRpDatabaseDriver=interface
  ['{B3BA37D5-5401-4B9E-8804-698C214F8B0C}']
  procedure Connect;
  procedure AssignParams(params:TStrings);
  procedure GetParams(params:TStrings);
  function GetStreamFromSQL(sqlsentence:String;params:TStringList;paramlist:TRpParamList):TStream;
  procedure GetTableNames(Alist:TStrings;params:TRpParamList);
  procedure GetFieldNames(atable:String;fieldlist,fieldtypes,fieldsizes:TStrings;params:TRpParamList);
  function OpenDatasetFromSQL(sqlsentence:String;params:TStringList;onlyexec:Boolean;paramlist:TRpParamList):TDataset;
 end;

 IRpDataDriver=interface
  ['{5094336F-C953-4108-94E3-1EC0E3D3D94C}']
  function Open:TDataset;
  procedure Close;
  procedure SetDatabase(IDatabase:IRpDatabaseDriver);
  procedure AssignParams(params:TStrings);
  procedure GetParams(params:TStrings);
 end;

 TRpDatabaseInfoItem=class(TCollectionItem)
  private
   FAlias:string;
   FMyBasePath:String;
{$IFDEF USESQLEXPRESS}
   FSQLConnection:TSQLConnection;
   FSQLInternalConnection:TSQLConnection;
{$ENDIF}
   ConAdmin:TRpConnAdmin;
   FConfigFile:string;
   FLoadParams:boolean;
   FReportTable,FReportGroupsTable,FReportSearchField,FReportField:String;
   FLoadDriverParams:boolean;
   FLoginPrompt:boolean;
   FADOConnectionString:widestring;
{$IFDEF USEIBX}
   FIBInternalDatabase:TIBDatabase;
   FIBDatabase:TIBDatabase;
   FIBTransaction:TIBTransaction;
   FIBInternalTransaction:TIBTransaction;
{$ENDIF}
{$IFDEF USEZEOS}
   FZInternalDatabase:TZConnection;
   FZConnection:TZConnection;
{$ENDIF}
{$IFDEF USEADO}
   FADOConnection:TADOConnection;
   FProvidedADOConnection:TADOConnection;
{$ENDIF}
{$IFDEF USEBDE}
   FBDEDatabase:TDatabase;
   FBDEAlias:string;
   CreatedBDE:Boolean;
{$ENDIF}
{$IFDEF USEIBO}
   FIBODatabase: TIB_Database;
{$ENDIF}
   FDriver:TRpDbDriver;
   procedure SetAlias(Value:string);
   procedure SetConfigFile(Value:string);
   procedure SetLoadParams(Value:boolean);
   procedure SetLoadDriverParams(Value:boolean);
   procedure SetLoginPrompt(Value:boolean);
{$IFDEF USEADO}
   procedure SetADOConnection(Value:TADOConnection);
   function GetADOConnection:TADOConnection;
{$ENDIF}
   procedure ReadAdoConnectionString(Reader:TReader);
   procedure WriteAdoConnectionString(Writer:TWriter);
  protected
    procedure DefineProperties(Filer:TFiler);override;
  public
   DotNetDriver:integer;
   ProviderFactory:string;
   procedure UpdateConAdmin;
   procedure Assign(Source:TPersistent);override;
   destructor Destroy;override;
   procedure Connect(params:TRpParamList);
   procedure DisConnect;
   constructor Create(Collection:TCollection);override;
{$IFDEF USESQLEXPRESS}
   property SQLConnection:TSQLConnection read FSQLConnection write FSQLConnection;
{$ENDIF}
{$IFDEF USEIBX}
   property IBDatabase:TIBDatabase read FIBDatabase
    write FIBDatabase;
   property IBTransaction:TIBTransaction read FIBTransaction
    write FIBTransaction;
{$ENDIF}
{$IFDEF USEZEOS}
   property ZConnection:TZConnection read FZConnection
    write FZConnection;
{$ENDIF}
   function GetStreamFromSQL(sqlsentence:String;params:TStringList;paramlist:TRpParamList):TStream;
   procedure GetTableNames(Alist:TStrings;params:TRpParamList);
   procedure GetFieldNames(atable:String;fieldlist,fieldtypes,fieldsizes:TStrings;params:TRpParamList);
   function OpenDatasetFromSQL(sqlsentence:String;params:TStringList;onlyexec:Boolean;paramlist:TRpParamList):TDataset;
   procedure CreateLibrary(reporttable,reportfield,reportsearchfield,groupstable:String;paramlist:TRpParamList);
   function GetReportStream(ReportName:WideString;paramlist:TRpParamList):TStream;
   procedure SaveReportStream(ReportName:WideString;astream:TStream;paramlist:TRpParamList);
{$IFDEF USEADO}
   property ADOConnection:TADOConnection read GetADOConnection write SetADOConnection;
{$ENDIF}
   property MyBasePath:String read FMyBasePath;
   property ADOConnectionString:widestring read FADOConnectionString write FADOConnectionString;
   procedure DoCommit;
  published
   property Alias:string read FAlias write SetAlias;
   property ConfigFile:string read FConfigFile write SetConfigFile;
   property LoadParams:boolean read FLoadParams write SetLoadParams;
   property LoadDriverParams:boolean read FLoadDriverParams write SetLoadDriverParams;
   property LoginPrompt:boolean read FLoginPrompt write SetLoginPrompt;
   property Driver:TRpDbDriver read FDriver write FDriver default rpdatadbexpress;
   property ReportTable:String read FReportTable write FReportTable;
   property ReportSearchField:String read FReportSearchField write FReportSearchField;
   property ReportField:String read FReportField write FReportField;
   property ReportGroupsTable:String read FReportGroupsTable write FReportGroupsTable;
  end;

  TRpDatabaseInfoList=class(TCollection)
  private
   FReport:TComponent;
{$IFDEF USEBDE}
   FBDESession:TSession;
{$ENDIF}
   function GetItem(Index:Integer):TRpDatabaseInfoItem;
   procedure SetItem(index:integer;Value:TRpDatabaseInfoItem);
  public
{$IFDEF USEBDE}
   property BDESession:TSession read FBDESession write FBDESession;
{$ENDIF}
   function Add(alias:string):TRpDatabaseInfoItem;
   function IndexOf(Value:string):integer;
   function ItemByName(AName:string):TRpDatabaseInfoItem;
   function GetReportStream(ConnectionName:String;ReportName:WideString;paramlist:TRpParamList):TStream;
   procedure SaveReportStream(ConnectionName:String;ReportName:WideString;astream:TStream;paramlist:TRpParamList);
   procedure SaveToFile(ainifile:String);
   procedure LoadFromFile(ainifile:String);
   procedure FillTreeDir(ConnectionName:String;alist:TStrings);
   property Items[index:integer]:TRpDatabaseInfoItem read GetItem write SetItem;default;
   constructor Create(rep:TComponent);
   destructor Destroy;override;
  end;

 TRpDatasetType=(rpdquery,rpdtable);

 TRpDataLink=class;

 TRpDataInfoItem=class(TCollectionItem)
  private
   FDatabaseAlias:string;
   FSQL:widestring;
   FDataSource:string;
   FAlias:string;
   FDataset:TDataset;
   FDataLink:TRpDatalink;
{$IFDEF USERPDATASET}
   FCachedDataset:TRpDataset;
{$ENDIF}
   FSQLInternalQuery:TDataset;
   FMyBaseFilename:string;
   FMyBaseFields:String;
   FMyBaseIndexFields:string;
   FMyBaseMasterFields:string;
   FBDEIndexFields:string;
   FBDEIndexName:string;
   FBDETable:string;
   FBDEType:TRpDatasetType;
   FBDEMasterFields:string;
   FBDEFilter:string;
   FBDEFirstRange,FBDELastRange:string;
   connecting:boolean;
   FCached:Boolean;
   FMasterSource:TDataSource;
   FDataUnions:TStrings;
   FGroupUnion:Boolean;
   FDBInfoList:TRpDatabaseInfoList;
   FParamsList:TRpParamList;
   FOpenOnStart:Boolean;
{$IFDEF USEADO}
   FexternalDataSet: Pointer;
{$ENDIF}
   FOnConnect:TDatasetNotifyEvent;
   FOnDisConnect:TDatasetNotifyEvent;
   FParallelUnion:Boolean;
   procedure SetDataUnions(Value:TStrings);
   procedure SetDatabaseAlias(Value:string);
   procedure SetAlias(Value:string);
   procedure SetDataSource(Value:string);
   procedure SetSQL(Value:widestring);
{$IFDEF USEBDE}
   procedure SetRangeForTable(lastrange:boolean);
{$ENDIF}
  public
   SQLOverride:widestring;
   procedure GetFieldNames(fieldlist,fieldtypes,fieldsizes:TStrings);
   property OnConnect:TDatasetNotifyEvent read FOnConnect write FOnConnect;
   property OnDisConnect:TDatasetNotifyEvent read FOnDisConnect write FOnDisConnect;
   procedure Assign(Source:TPersistent);override;
   procedure Connect(databaseinfo:TRpDatabaseInfoList;params:TRpParamList);
   procedure Disconnect;
   destructor Destroy;override;
   constructor Create(Collection:TCollection);override;
   property Dataset:TDataset read FDataset write FDataset;
{$IFDEF USERPDATASET}
   property CachedDataset:TRpDataset read FCachedDataset;
{$ENDIF}
   property Cached:Boolean read FCached write FCached;
{$IFDEF USEADO}
   property externalDataset: Pointer read FexternalDataSet write FexternalDataSet;
{$ENDIF}
  published
   property Alias:string read FAlias write SetAlias;
   property DatabaseAlias:string read FDatabaseAlias write SetDatabaseAlias;
   property SQL:widestring read FSQL write SetSQL;
   property DataSource:string read FDatasource write SetDataSource;
   property MyBaseFilename:string read FMyBaseFilename write FMyBaseFilename;
   property MyBaseFields:string read FMyBaseFields write FMyBaseFields;
   property MyBaseIndexFields:string read FMyBaseIndexFields write FMyBaseIndexFields;
   property MyBaseMasterFields:string read FMyBaseMasterFields write FMyBaseMasterFields;
   property BDEIndexFields:string read FBDEIndexFields write FBDEIndexFields;
   property BDEIndexName:string read FBDEIndexName write FBDEIndexName;
   property BDETable:string read FBDETable write FBDETable;
   property BDEType:TRpDatasetType read FBDEType write FBDEType
    default rpdquery;
   property BDEFilter:string read FBDEFilter write FBDEFilter;
   property BDEMasterFields:string read FBDEMasterFields write FBDEMasterFields;
   property BDEFirstRange:string read FBDEFirstRange write FBDEFirstRange;
   property BDELastRange:string read FBDELastRange write FBDELastRange;
   property DataUnions:TStrings read FDataUnions write SetDataUnions;
   property GroupUnion:Boolean read FGroupUnion write FGroupUnion default false;
   property OpenOnStart:Boolean read FOpenOnStart write FOpenOnStart default true;
   property ParallelUnion:Boolean read FParallelUnion write FParallelUnion default false;
  end;

 TRpDataInfoList=class(TCollection)
  private
   FReport:TComponent;
   function GetItem(Index:Integer):TRpDataInfoItem;
   procedure SetItem(index:integer;Value:TRpDataInfoItem);
   procedure IntEnableLink(alist:TStringList;i:integer);
   procedure IntDisableLink(alist:TStringList;i:integer);
  public
   procedure DisableLinks;
   procedure EnableLinks;
   function Add(alias:string):TRpDataInfoItem;
   function IndexOf(Value:string):integer;
   function ItemByName(AName:string):TRpDataInfoItem;
   property Items[index:integer]:TRpDataInfoItem read GetItem write SetItem;default;
   property Report:TComponent read FReport;
   constructor Create(rep:TComponent);
  end;

  TRpDataLink=class(TDataLink)
   protected

    procedure RecordChanged(Field:TField);override;
   public
    databaseinfo:TRpDatabaseInfoList;
    datainfo:TRpDataInfoList;
    datainfoitem:TRpDataInfoItem;
    dbinfoitem:TRpDatabaseInfoItem;
    procedure DoRecordChange;
    constructor Create;
  end;
procedure GetRpDatabaseDrivers(alist:TStrings);
{$IFDEF USERPDATASET}
{$IFDEF FPC}
procedure CombineAddDataset(client:TMemDataset;data:TDataset;group:boolean);
{$ENDIF}
{$IFNDEF FPC}
procedure CombineAddDataset(client:TClientDataset;data:TDataset;group:boolean);
{$ENDIF}
{$ENDIF}
procedure FillFieldsInfo(adata:TDataset;fieldnames,fieldtypes,fieldsizes:TStrings);
function ExtractFieldNameEx(astring:String):string;
function EncodeADOPassword(astring:String):String;
procedure GetDotNetDrivers(alist:TStrings);
procedure GetDotNet2Drivers(alist:TStrings);
function CombineParallel(data1:TClientDataset;data2:TDataset;prefix:string;commonfields:TStrings;originalfields:TStrings):TClientDataset;
procedure ExtractUnionFields(var datasetname:string;alist:TStrings);

implementation



uses
{$IFDEF USEBDE}
 rpeval,
{$ENDIF}
 rpreport,rpbasereport;


const
  SDRIVERREG_SETTING = 'Driver Registry File';           { Do not localize }
  SCONNECTIONREG_SETTING = 'Connection Registry File';   { Do not localize }
  VENDORLIB_KEY = 'VendorLib';                  { Do not localize }
  DLLLIB_KEY = 'LibraryName';                   { Do not localize }
{$IFDEF MSWINDOWS}
  SDriverConfigFile = 'dbxdrivers.ini';            { Do not localize }
  SConnectionConfigFile = 'dbxconnections.ini';    { Do not localize }
  SDBEXPRESSREG_SETTING = '\Software\Borland\DBExpress'; { Do not localize }
{$ENDIF}
{$IFDEF LINUX}
  SDBEXPRESSREG_USERPATH = '/.borland/';          { Do not localize }
  SDBEXPRESSREG_GLOBALPATH = '/usr/local/etc/';   { Do not localize }
  SDriverConfigFile = 'dbxdrivers';                  { Do not localize }
  SConnectionConfigFile = 'dbxconnections';          { Do not localize }
  SConfExtension = '.conf';                       { Do not localize }
{$ENDIF}


{$IFDEF USEZEOS}
procedure  AssignParamValuesZ(ZQuery:TZReadOnlyQuery;Dataset:TDataset);
var
 i:integer;
 afield:TField;
begin
 for i:=0 to ZQuery.Params.Count-1 do
 begin
  afield:=Dataset.FindField(ZQuery.Params.Items[i].Name);
  if Assigned(afield) then
  begin
   ZQuery.Params.Items[i].Clear;
   ZQuery.Params.Items[i].DataType:=afield.DataType;
   if Not afield.IsNull then
    ZQuery.Params.Items[i].Value:=afield.Value;
  end;
 end;
end;

function  EqualParamValuesZ(ZQuery:TZReadOnlyQuery;Dataset:TDataset):Boolean;
var
 i:integer;
 afield:TField;
 qvalue:Variant;
begin
 Result:=true;
 for i:=0 to ZQuery.Params.Count-1 do
 begin
  afield:=Dataset.FindField(ZQuery.Params.Items[i].Name);
  if Assigned(afield) then
  begin
   qvalue:=ZQuery.Params.Items[i].Value;
   if VarType(qvalue)=varEmpty then
   begin
    Result:=false;
    break;
   end;
   if Not (qvalue=afield.AsVariant) then
   begin
    Result:=false;
    break;
   end;
  end;
 end;
end;
{$ENDIF}


{$IFDEF USESQLEXPRESS}
procedure  AssignParamValuesS(ZQuery:TSQLQuery;Dataset:TDataset);
var
 i:integer;
 afield:TField;
begin
 for i:=0 to ZQuery.Params.Count-1 do
 begin
  afield:=Dataset.FindField(ZQuery.Params.Items[i].Name);
  if Assigned(afield) then
  begin
   ZQuery.Params.Items[i].Clear;
   ZQuery.Params.Items[i].DataType:=afield.DataType;
   if Not afield.IsNull then
    ZQuery.Params.Items[i].Value:=afield.Value;
  end;
 end;
end;

function  EqualParamValuesS(ZQuery:TSQLQuery;Dataset:TDataset):Boolean;
var
 i:integer;
 afield:TField;
 qvalue:Variant;
begin
 Result:=true;
 for i:=0 to ZQuery.Params.Count-1 do
 begin
  afield:=Dataset.FindField(ZQuery.Params.Items[i].Name);
  if Assigned(afield) then
  begin
   qvalue:=ZQuery.Params.Items[i].Value;
   if VarType(qvalue)=varEmpty then
   begin
    Result:=false;
    break;
   end;
   if Not (qvalue=afield.AsVariant) then
   begin
    Result:=false;
    break;
   end;
  end;
 end;
end;
{$ENDIF}


{$IFDEF USEBDE}
procedure AddParamsFromDBXToBDE(paramssource,params:TStrings);
var
 index:integer;
begin
 index:=paramssource.IndexOfName('Password');
 if index>=0 then
  params.Add(paramssource.Strings[index]);
end;
{$ENDIF}




{$IFDEF USEIBX}
procedure ConvertParamsFromDBXToIBX(base:TIBDatabase);
var
 index:integer;
 params:TStrings;
begin
 params:=base.Params;
 index:=params.IndexOfName('DriverName');
 if index>=0 then
 begin
  if UpperCase(params.Values['DriverName'])<>'INTERBASE' then
   Raise Exception.Create(SRpDriverAliasIsNotInterbase);
  params.Delete(index);
 end;
 index:=params.IndexOfName('Database');
 if index<0 then
  Raise Exception.Create(SRpNoDatabase);
 base.DatabaseName:=params.Values['Database'];
 params.Delete(index);
 index:=params.IndexOfName('BlobSize');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('CommitRetain');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('Trim Char');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('ErrorResourceFile');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('LocaleCode');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('Interbase TransIsolation');
 if index>=0 then
  params.Delete(index);
 // D2007 DBX4 params
 index:=params.IndexOfName('DriverUnit');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('DriverPackageLoader');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('DriverAssemblyLoader');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('MetaDataPackageLoader');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('MetaDataAssemblyLoader');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('IsolationLevel');
 if index>=0 then
  params.Delete(index);

 // End D2007 DBX4 params
 index:=params.IndexOfName('WaitOnLocks');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('SQLDialect');
 if index>=0 then
 begin
  base.SQLDialect:=StrToInt(params.Values['SQLDialect']);
  params.Delete(index);
 end;
 index:=params.IndexOfName('RoleName');
 if index>=0 then
 begin
  params.Add('sql_role_name='+params.Values['RoleName']);
  params.Delete(index);
 end;
 index:=params.IndexOfName('ServerCharSet');
 if index>=0 then
 begin
  params.Add('lc_ctype='+params.Values['ServerCharSet']);
  params.Delete(index);
 end;
end;
{$ENDIF}

{$IFDEF USEIBO}
procedure ConvertParamsFromDBXToIBO(base:TIB_Database);
var
 index:integer;
 params:TStrings;
begin
 params:=base.Params;
 index:=params.IndexOfName('DriverName');
 if index>=0 then
 begin
  if UpperCase(params.Values['DriverName'])<>'INTERBASE' then
   Raise Exception.Create(SRpDriverAliasIsNotInterbase);
  params.Delete(index);
 end;
 index:=params.IndexOfName('Database');
 if index<0 then
  Raise Exception.Create(SRpNoDatabase);
 base.DatabaseName:=params.Values['Database'];
 params.Delete(index);
 index:=params.IndexOfName('BlobSize');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('CommitRetain');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('ErrorResourceFile');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('LocaleCode');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('Interbase TransIsolation');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('WaitOnLocks');
 if index>=0 then
  params.Delete(index);
 index:=params.IndexOfName('SQLDialect');
 if index>=0 then
 begin
  base.SQLDialect:=StrToInt(params.Values['SQLDialect']);
  params.Delete(index);
 end;
 index:=params.IndexOfName('RoleName');
 if index>=0 then
 begin
  base.SQLRole:=params.Values['RoleName'];
  params.Delete(index);
 end;
 index:=params.IndexOfName('user_name');
 if index>=0 then
 begin
  params.Add('USER NAME='+params.Values['user_name']);
  params.Delete(index);
 end;
 index:=params.IndexOfName('ServerCharSet');
 if index>=0 then
 begin
  base.Charset:=params.Values['ServerCharSet'];
  params.Delete(index);
 end;
end;
{$ENDIF}

procedure TRpDataInfoItem.SetDataUnions(Value:TStrings);
begin
 FDataUnions.Assign(Value);
 Changed(False);
end;


procedure TRpDataInfoItem.SetDatabaseAlias(Value:string);
begin
 FDatabaseAlias:=AnsiUpperCase(Value);
 Changed(False);
end;

procedure TRpDataInfoItem.SetAlias(Value:string);
begin
 Value:=AnsiUpperCase(Value);
 FAlias:=AnsiUpperCase(Value);
 Changed(False);
end;

procedure TRpDataInfoItem.SetDataSource(Value:string);
begin
 Value:=TRim(AnsiUpperCase(Value));
 FDataSource:=AnsiUpperCase(Value);
 Changed(False);
end;

procedure TRpDataInfoItem.SetSQL(Value:widestring);
begin
 FSQL:=Value;
 Changed(False);
end;

procedure TRpDataInfoItem.Assign(Source:TPersistent);
begin
 if Source is TRpDataInfoItem then
 begin
  FAlias:=TRpDataInfoItem(Source).FAlias;
  FDatabaseAlias:=TRpDataInfoItem(Source).FDatabaseAlias;
  FDataSource:=TRpDataInfoItem(Source).FDataSource;
  FSQL:=TRpDataInfoItem(Source).FSQL;
  FMyBaseFilename:=TRpDataInfoItem(Source).FMyBaseFilename;
  FMyBaseFields:=TRpDataInfoItem(Source).FMyBaseFields;
  FMyBaseIndexFields:=TRpDataInfoItem(Source).FMyBaseIndexFields;
  FBDEIndexFields:=TRpDataInfoItem(Source).FBDEIndexFields;
  FBDEMasterFields:=TRpDataInfoItem(Source).FBDEMasterFields;
  FMyBaseMasterFields:=TRpDataInfoItem(Source).FMyBaseMasterFields;
  FBDEIndexName:=TRpDataInfoItem(Source).FBDEIndexName;
  FBDEFilter:=TRpDataInfoItem(Source).FBDEFilter;
  FBDETable:=TRpDataInfoItem(Source).FBDETable;
  FBDEType:=TRpDataInfoItem(Source).FBDEType;
  FDataUnions.Assign(TRpDataInfoItem(Source).FDataUnions);
  FGroupUnion:=TRpDataInfoItem(Source).FGroupUnion;
  FBDEFirstRange:=TRpDataInfoItem(Source).FBDEFirstRange;
  FBDELastRange:=TRpDataInfoItem(Source).FBDELastRange;
  FOpenOnStart:=TRpDataInfoItem(Source).FOpenOnStart;
  FParallelUnion:=TRpDataInfoItem(Source).FParallelUnion;
 end
 else
  inherited Assign(Source);
end;

constructor TRpDataInfoList.Create(rep:TComponent);
begin
 inherited Create(TRpDataInfoItem);
 FReport:=rep;
end;


function TRpDataInfoList.GetItem(Index:Integer):TRpDataInfoItem;
begin
 Result:=TRpDataInfoItem(inherited GetItem(index));
end;

procedure TRpDataInfoList.SetItem(index:integer;Value:TRpDataInfoItem);
begin
 inherited SetItem(Index,Value);
end;

function TRpDataInfoList.Add(alias:string):TRpDataInfoItem;
begin
 // Then function is defined by the class TCollectionItem
 alias:=AnsiUpperCase(alias);
 if Indexof(alias)>=0 then
  Raise Exception.Create(SRpAliasExists);
 Result:=TRpDataInfoItem(inherited Add);
 Result.Alias:=alias;
end;

function TRpDataInfoList.IndexOf(Value:string):integer;
var
 i:integer;
begin
 Value:=AnsiUpperCase(Value);
 Result:=-1;
 i:=0;
 While i<count do
 begin
  if items[i].FAlias=Value then
  begin
   Result:=i;
   break;
  end;
  inc(i);
 end;
end;

// Database info


procedure TRpDatabaseInfoItem.SetAlias(Value:string);
begin
 Value:=AnsiUpperCase(Value);
 FAlias:=AnsiUpperCase(Value);
 Changed(False);
end;

destructor TRpDatabaseInfoList.Destroy;
begin
 inherited Destroy;
end;


destructor TRpDatabaseInfoItem.Destroy;
begin
{$IFDEF USESQLEXPRESS}
 FSQLInternalConnection.free;
{$ENDIF}
{$IFDEF USEIBX}
 if Assigned(FIBInternalDatabase) then
 begin
  FIBInternalDatabase.Free;
 end;
 if Assigned(FIBInternalTransaction) then
 begin
  FIBInternalTransaction.Free;
 end;
{$ENDIF}
{$IFDEF USEZEOS}
 if Assigned(FZInternalDatabase) then
 begin
  FZInternalDatabase.Free;
 end;
{$ENDIF}
{$IFDEF USEIBO}
 if Assigned(FIBODatabase) then
 begin
  FIBODatabase.Free;
 end;
{$ENDIF}
{$IFDEF USEBDE}
 if CreatedBDE then
  FBDEDatabase.free;
{$ENDIF}
{$IFDEF USEADO}
 FADOConnection.free;
{$ENDIF}
 if Assigned(ConAdmin) then
 begin
  ConAdmin.free;
  ConAdmin:=nil;
 end;
 inherited Destroy;
end;


procedure TRpDatabaseInfoItem.SetLoadParams(Value:boolean);
begin
 FLoadParams:=Value;
 Changed(False);
end;

procedure TRpDatabaseInfoItem.SetLoadDriverParams(Value:boolean);
begin
 FLoadDriverParams:=Value;
 Changed(False);
end;

procedure TRpDatabaseInfoItem.SetLoginPrompt(Value:boolean);
begin
 FLoginPrompt:=Value;
 Changed(False);
end;


procedure TRpDatabaseInfoItem.SetConfigFile(Value:string);
begin
 FConfigFile:=Value;
 Changed(False);
end;

procedure TRpDatabaseInfoItem.Assign(Source:TPersistent);
begin
 if Source is TRpDatabaseInfoItem then
 begin
  FAlias:=TRpDatabaseInfoItem(Source).FAlias;
  FLoadParams:=TRpDatabaseInfoItem(Source).FLoadParams;
  FLoginPrompt:=TRpDatabaseInfoItem(Source).FLoginPrompt;
  FLoadDriverParams:=TRpDatabaseInfoItem(Source).FLoadDriverParams;
  FConfigFile:=TRpDatabaseInfoItem(Source).FConfigFile;
  FDriver:=TRpDatabaseInfoItem(Source).FDriver;
  FADOConnectionString:=TRpDatabaseInfoItem(Source).FADOConnectionString;
  FReportTable:=TRpDatabaseInfoItem(Source).FReportTable;
  FReportField:=TRpDatabaseInfoItem(Source).FReportField;
  FReportSearchField:=TRpDatabaseInfoItem(Source).FReportSearchField;
  FReportGroupsTable:=TRpDatabaseInfoItem(Source).FReportGroupsTable;
  DotNetDriver:=TRpDatabaseInfoItem(Source).DotNetDriver;
  ProviderFactory:=TRpDatabaseInfoItem(Source).ProviderFactory;
 end
 else
  inherited Assign(Source);
end;

constructor TRpDatabaseInfoList.Create(rep:TComponent);
begin
 inherited Create(TRpDatabaseInfoItem);
 FReport:=rep;
end;

function TRpDatabaseInfoList.GetItem(Index:Integer):TRpDatabaseInfoItem;
begin
 Result:=TRpDatabaseInfoItem(inherited GetItem(index));
end;

procedure TRpDatabaseInfoList.SetItem(index:integer;Value:TRpDatabaseInfoItem);
begin
 inherited SetItem(Index,Value);
end;

function TRpDatabaseInfoList.Add(alias:string):TRpDatabaseInfoItem;
begin
 // Then function is defined by teh class TCollectionItem
 alias:=AnsiUpperCase(alias);
 if Indexof(alias)>=0 then
  Raise Exception.Create(SRpAliasExists);
 Result:=TRpDatabaseInfoItem(inherited Add);
 Result.Alias:=alias;
end;

function TRpDatabaseInfoList.IndexOf(Value:string):integer;
var
 i:integer;
begin
 Value:=AnsiUppercase(Value);
 Result:=-1;
 i:=0;
 While i<count do
 begin
  if items[i].FAlias=Value then
  begin
   Result:=i;
   break;
  end;
  inc(i);
 end;
end;

constructor TRpDatabaseinfoitem.Create(Collection:TCollection);
begin
 inherited Create(Collection);

 FLoadParams:=true;
 FLoadDriverParams:=true;
 FDriver:=rpdatadbexpress;
 FReportTable:='REPMAN_REPORTS';
 FReportGroupsTable:='REPMAN_GROUPS';
 FReportSearchField:='REPORT_NAME';
 FReportField:='REPORT';
end;

procedure TRpDatabaseinfoitem.UpdateConAdmin;
var
 aparam:TRpParam;
 report:TRpReport;
begin
 if Assigned(ConAdmin) then
 begin
  ConAdmin.Free;
  ConAdmin:=nil;
 end;
 ConAdmin:=TRpConnAdmin.Create;
 if TRpDataInfoList(Collection).FReport is TRpReport then
 begin
  report:=TRpDataInfoList(Collection).FReport As TRpReport;
  aparam:=report.Params.FindParam('DBXCONNECTIONS');
  if Assigned(aparam) then
  begin
   ConAdmin.DBXConnectionsOverride:=aparam.AsString;
   ConAdmin.LoadConfig;
  end;
  aparam:=report.Params.FindParam('DBXDRIVERS');
  if Assigned(aparam) then
  begin
   ConAdmin.DBXDriversOverride:=aparam.AsString;
   ConAdmin.LoadConfig;
  end;
 end;
end;


{$IFDEF USEADO}
procedure TRpDatabaseinfoitem.SetADOConnection(Value:TADOConnection);
begin
 FProvidedADOConnection:=Value;
end;

function TRpDatabaseinfoitem.GetADOConnection:TADOConnection;
begin
 if Assigned(FProvidedADOConnection) then
  Result:=FProvidedADOConnection
 else
 begin
  if Not Assigned(FADOConnection) then
  begin
    FADOConnection:=TADOConnection.Create(nil);
    FADOConnection.KeepConnection:=true;
    // Keep connection=false fails when using ADO and parameters
    //FADOConnection.KeepConnection:=false;
    FADOConnection.Mode:=cmRead;
  end;
  Result:=FADOConnection;
 end;
end;

{$ENDIF}

procedure MergeList(source,destination:TStrings);
var
 i:integer;
 index:integer;
 aname:string;
begin
 for i:=0 to source.Count-1 do
 begin
  aname:=source.Names[i];
  index:=destination.IndexOfName(aname);
  if index>=0 then
  begin
   destination.Strings[index]:=source.Strings[i];
  end
  else
   destination.Add(source.Strings[i]);
 end;
end;

procedure TRpDatabaseinfoitem.Connect(params:TRpParamList);
var
 conname:string;
 paramname:String;
 index:integer;
 alist,alist2:TStringList;
 paramlist:TStringList;
 i:integer;
{$IFDEF USEADO}
 report:TRpBasereport;
{$ENDIF}
{$IFDEF USESQLEXPRESS}
 funcname,drivername,vendorlib,libraryname:string;
{$ENDIF}
{$IFDEF USEZEOS}
  transiso:String;
{$ENDIF}
{$IFDEF USEBDE}
 AlreadyOpen:boolean;
 OpenedName:string;
 FOpenedDatabase:TDatabase;
 ASession:TSession;
 adparams:TStrings;
{$ENDIF}
begin
 paramlist:=TStringList.Create;
 try
   if Assigned(params) then
   begin
    for i:=0 to params.COunt-1 do
    begin
     paramname:=params.Items[i].Name;
     if Copy(paramname,1,8)='DBPARAM_' then
     begin
      paramlist.Add(Copy(paramname,9,Length(paramname))+
       '='+params.Items[i].AsString);
     end;
     if Copy(paramname,1,8+Length(alias)+1)=Alias+'_DBPARAM_' then
     begin
      paramlist.Add(Copy(paramname,10+Length(alias),Length(paramname)-1)+
       '='+params.Items[i].AsString);
     end;
    end;
   end;
   case Fdriver of
    rpdatadbexpress:
     begin
  {$IFDEF USESQLEXPRESS}
       if Not Assigned(FSQLConnection) then
       begin
        if Not Assigned(FSQLInternalConnection) then
         FSQLInternalConnection:=TSQLConnection.Create(nil);
        FSQLConnection:=FSQLInternalConnection;
       end;
       if FSQLCOnnection.Connected then
        exit;
       FSQLConnection.LoginPrompt:=FLoginPrompt;
       conname:=alias;
       FSQLConnection.ConnectionName:=alias;
       // Load Connection parameters
       if (FLoadParams) then
       begin
        if Not Assigned(ConAdmin) then
         UpdateConAdmin;
        alist:=TStringList.Create;
        try
         ConAdmin.GetConnectionParams(conname,alist);
         FSQLConnection.Params.Assign(alist);
        finally
         alist.free;
        end;
       end;
       index:=paramlist.IndexOfName('CONNECTIONNAME');
       if (index>=0) then
       begin
        FSQLConnection.ConnectionName:=paramlist.Values['CONNECTIONNAME'];
        paramlist.Delete(index);
       end;
       index:=paramlist.IndexOfName('ConnectionName');
       if (index>=0) then
       begin
        FSQLConnection.ConnectionName:=paramlist.Values['ConnectionName'];
        paramlist.Delete(index);
       end;
       index:=paramlist.IndexOfName('DRIVERNAME');
       if (index>=0) then
       begin
        FSQLConnection.DriverName:=paramlist.Values['DRIVERNAME'];
        paramlist.Delete(index);
       end;
       index:=paramlist.IndexOfName('DriverName');
       if (index>=0) then
       begin
        FSQLConnection.DriverName:=paramlist.Values['DriverName'];
        paramlist.Delete(index);
       end;
       // Load vendor lib, library name...
       if (FLoadDriverParams) then
       begin
        if Not Assigned(ConAdmin) then
         UpdateConAdmin;
        drivername:=FSQLCOnnection.DriverName;
        if Length(drivername)<1 then
         drivername:=FSQLConnection.params.Values['DriverName'];
        if Length(drivername)<1 then
         drivername:=FSQLConnection.params.Values['Drivername'];
        if Length(drivername)<1 then
         Raise Exception.Create(SRpNoDriverName+' - '+conname);


        funcname:=ConAdmin.drivers.ReadString(drivername,'GetDriverFunc','');
        ConAdmin.GetDriverLibNames(drivername,LibraryName,VendorLib);
        // Assigns all
          FSQLConnection.Params.Delete(index);
        FSQLConnection.DriverName:=drivername;
        FSQLConnection.VendorLib:=vendorlib;
        FSQLConnection.LibraryName:=libraryname;
        FSQLConnection.GetDriverFunc:=funcname;
       end;
       index:=paramlist.IndexOfName('VENDORLIB');
       if (index>=0) then
       begin
        FSQLConnection.VendorLib:=paramlist.Values['VENDORLIB'];
        paramlist.Delete(index);
       end;
       index:=paramlist.IndexOfName('GETDRIVERFUNC');
       if (index>=0) then
       begin
        FSQLConnection.GetDriverFunc:=paramlist.Values['GETDRIVERFUNC'];
        paramlist.Delete(index);
       end;
       index:=paramlist.IndexOfName('LIBRARYNAME');
       if (index>=0) then
       begin
        FSQLConnection.LibraryName:=paramlist.Values['LIBRARYNAME'];
        paramlist.Delete(index);
       end;
       alist2:=TStringList.Create;
       try
        alist2.Assign(FSQLConnection.Params);
        MergeList(paramlist,alist2);
        FSQLConnection.Params.Assign(alist2);
       finally
        alist2.free;
       end;
       FSQLConnection.Connected:=true;
  {$ELSE}
      Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverDBX);
  {$ENDIF}
     end;
    rpdataibx:
     begin
  {$IFDEF USEIBX}
       if Not Assigned(FIBDatabase) then
       begin
        FIBInternalDatabase:=TIBDatabase.Create(nil);

        FIBInternalDatabase.DefaultTransaction:=TIBTransaction.Create(nil);
        FIBInternalDatabase.DefaultTransaction.DefaultDatabase:=FIBInternalDatabase;
        FIBInternalDatabase.DefaultTransaction.Params.Add('concurrency');
        FIBInternalDatabase.DefaultTransaction.Params.Add('nowait');
        FIBDatabase:=FIBInternalDatabase;
        FIBTransaction:=FIBInternalDatabase.DefaultTransaction;
        FIBInternalTransaction:=FIBTransaction;
       end;
       if Not Assigned(FIBTransaction) then
       begin
        FIBInternalTransaction:=TIBTransaction.Create(nil);
        FIBInternalTransaction.DefaultDatabase:=FIBDatabase;
        FIBInternalTransaction.Params.Add('concurrency');
        FIBInternalTransaction.Params.Add('nowait');
        FIBTransaction:=FIBInternalTransaction;
       end;
       if FIBDatabase.Connected then
       begin
        if FIBTransaction=FIBInternalTransaction then
        begin
         if not FIBInternalTransaction.InTransaction then
          FIBInternalTransaction.StartTransaction;
        end;
        exit;
       end;
       FIBDatabase.LoginPrompt:=FLoginPrompt;
       conname:=alias;
       // Load Connection parameters
       if (FLoadParams) then
       begin
        if Not Assigned(ConAdmin) then
         UpdateConAdmin;
        ConAdmin.GetConnectionParams(conname,FIBDatabase.params);
       end;
       MergeList(paramlist,FIBDatabase.Params);
       ConvertParamsFromDBXToIBX(FIBDatabase);
       index:=paramlist.IndexOfName('DATABASENAME');
       if (index>=0) then
       begin
        FIBDatabase.DatabaseName:=paramlist.Values['DATABASENAME'];
        paramlist.Delete(index);
       end;

       FIBDatabase.Connected:=true;
       if FIBTransaction=FIBInternalTransaction then
       begin
        if not FIBInternalTransaction.InTransaction then
         FIBInternalTransaction.StartTransaction;
       end;
  {$ELSE}
      Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverIBX);
  {$ENDIF}
     end;
    rpdatazeos:
     begin
  {$IFDEF USEZEOS}
       if Not Assigned(FZConnection) then
       begin
        FZInternalDatabase:=TZConnection.Create(nil);
        FZConnection:=FZInternalDatabase;
       end;
       if FZConnection.Connected then
        exit;
       FZConnection.LoginPrompt:=FLoginPrompt;
       conname:=alias;
       // Load Connection parameters
       alist:=TStringList.Create;
       try
        if (FLoadParams) then
        begin
         if Not Assigned(ConAdmin) then
          UpdateConAdmin;
         ConAdmin.GetConnectionParams(conname,alist);
        end;
        MergeList(paramlist,alist);
        FZConnection.User:=alist.Values['User_Name'];
        FZConnection.Password:=alist.Values['Password'];
        if length(alist.Values['Port'])>0 then
         FZConnection.Port:=StrToInt(alist.Values['Port']);
        FZConnection.HostName:=alist.Values['HostName'];
        FZConnection.Database:=alist.Values['Database'];
        FZConnection.Protocol:=alist.Values['Database Protocol'];
        FZConnection.Properties.Add(alist.Values['Property1']);
        FZConnection.Properties.Add(alist.Values['Property2']);
        FZConnection.Properties.Add(alist.Values['Property3']);
        FZConnection.Properties.Add(alist.Values['Property4']);
        FZConnection.Properties.Add(alist.Values['Property5']);
        FZConnection.Properties.Add(alist.Values['Property6']);
        FZConnection.Properties.Add(alist.Values['Property7']);
        FZConnection.Properties.Add(alist.Values['Property8']);
        FZConnection.Properties.Add(alist.Values['Property9']);
        transiso:=alist.Values['Zeos TransIsolation'];
        if (transiso='ReadCommited') then
         FZConnection.TransactIsolationLevel:=ZDbcIntfs.tiReadCommitted
        else
        if (transiso='ReadUnCommited') then
         FZConnection.TransactIsolationLevel:=ZDbcIntfs.tiReadUnCommitted
        else
        if (transiso='RepeatableRead') then
         FZConnection.TransactIsolationLevel:=ZDbcIntfs.tiRepeatableRead
        else
        if (transiso='Serializable') then
         FZConnection.TransactIsolationLevel:=ZDbcIntfs.tiSerializable
        else
         FZConnection.TransactIsolationLevel:=ZDbcIntfs.tiNone;
       finally
        alist.free;
       end;
       FZConnection.Connected:=true;
  {$ELSE}
      Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverZEOS);
  {$ENDIF}
     end;
    rpdatamybase:
     begin
      // Connect will read the mybasepath variable
      // or will left blank if not found
      FMyBasePath:='';
      conname:=alias;
      // Load Connection parameters
      alist:=TStringList.Create;
      try
       if (FLoadParams) then
       begin
        if Not Assigned(ConAdmin) then
         UpdateConAdmin;
        ConAdmin.GetConnectionParams(conname,alist);
       end;
       MergeList(paramlist,alist);
       index:=alist.IndexOfName('DATABASE');
       if index>=0 then
        FMyBasePath:=alist.Values['DATABASE'];
      finally
       alist.free;
      end;
     end;
    rpdatabde:
     begin
  {$IFDEF USEBDE}
      FOpenedDatabase:=nil;
      FBDEAlias:=Alias;
      CreatedBDE:=false;
      if Not Assigned(FBDEDatabase) then
      begin
       FBDEDatabase:=TDatabase.Create(nil);
       createdBDE:=true;
       FBDEDatabase.KeepConnection:=False;
       if Assigned(TRpDatabaseInfoList(Collection).FBDESession) then
        FBDEDatabase.SessionName:=TRpDatabaseInfoList(Collection).FBDESession.SessionName;
      end;
      if FBDEDatabase.Connected then
       exit;
      ASession:=Session;
      if Assigned(TRpDatabaseInfoList(Collection).FBDESession) then
       ASession:=TRpDatabaseInfoList(Collection).FBDESession;
      // Find an opened database in this session that
      // openend the alias
      OpenedName:=FBDEAlias;
      AlreadyOpen:=False;
      for i:=0 to ASession.DatabaseCount-1 do
      begin
       if ((UpperCase(ASession.Databases[i].DatabaseName)=UpperCase(FBDEAlias)) or
        (UpperCase(ASession.Databases[i].AliasName)=UpperCase(FBDEAlias))) then
       begin
        if ASession.Databases[i].Connected then
        begin
         AlreadyOpen:=True;
         OpenedName:=ASession.Databases[i].DatabaseName;
         FOpenedDatabase:=ASession.Databases[i];
         break;
        end
        else
         ASession.Databases[i].DatabaseName:='';
       end;
       if ASession.Databases[i].AliasName=FBDEAlias then
        if ASession.Databases[i].Connected then
        begin
         AlreadyOpen:=True;
         FOpenedDatabase:=ASession.Databases[i];
         OpenedName:=ASession.Databases[i].DatabaseName;
         break;
        end;
      end;
      if Not AlreadyOpen then
      begin
       FBDEDatabase.DatabaseName:=OpenedName;
       if FLoadParams then
       begin
        try
         FBDEDatabase.AliasName:=FBDEAlias;
         ASession.GetAliasParams(FBDEAlias,FBDEDatabase.Params);
         // Add aditional parameters
         adparams:=TStringList.Create;
         try
          if Not Assigned(ConAdmin) then
           UpdateConAdmin;
          ConAdmin.GetConnectionParams(FBDEAlias,adparams);
          AddParamsFromDBXToBDE(adparams,FBDEDatabase.Params);
         finally
          adparams.free;
         end;
         FBDEDatabase.LoginPrompt:=LoginPrompt;
         MergeList(paramlist,FBDEDatabase.Params);
         FBDEDatabase.Connected:=true;
        except
         on E:Exception do
         begin
  {$IFDEF DOTNETD}
          Raise Exception.Create(E.Message+':BDE-ALIAS:'+FBDEAlias);
  {$ENDIF}
  {$IFNDEF DOTNETD}
          E.Message:=E.Message+':BDE-ALIAS:'+FBDEAlias;
          Raise;
  {$ENDIF}
         end;
        end;
       end;
      end
      else
      begin
       if createdBDE then
       begin
        FBDEDatabase.free;
        FBDEDatabase:=nil;
        CreatedBDE:=false;
       end;
       FBDEDatabase:=FOpenedDatabase;
      end;
  {$ELSE}
      Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverBDE);
  {$ENDIF}
     end;
    rpdataado:
     begin
  {$IFDEF USEADO}
      if ADOConnection.Connected then
       exit;
      if Not Assigned(FProvidedADOCOnnection) then
      begin
       ADOConnection.Mode:=cmRead;
       report:=TRpDataInfoList(Collection).FReport As TRpbASEReport;
       if report.Params.IndexOf(Alias+'_ADOCONNECTIONSTRING')>=0 then
        ADOConnection.ConnectionString:=report.Params.ParamByName(Alias+'_ADOCONNECTIONSTRING').AsString
       else
        if report.Params.IndexOf('ADOCONNECTIONSTRING')>=0 then
         ADOConnection.ConnectionString:=report.Params.ParamByName('ADOCONNECTIONSTRING').AsString
        else
         ADOConnection.ConnectionString:=ADOConnectionString;
       ADOConnection.LoginPrompt:=LoginPrompt;
       ADOConnection.Connected:=true;
      end
      else
       FProvidedADOConnection.Connected:=True;
  {$ELSE}
      Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverADO);
  {$ENDIF}
     end;
    rpdataibo:
     begin
  {$IFDEF USEIBO}
       if Not Assigned(FIBODatabase) then
       begin
        FIBODatabase:=TIB_Database.Create(nil);
       end;
       if FIBODatabase.Connected then
        exit;
       FIBODatabase.LoginPrompt:=FLoginPrompt;
       conname:=alias;
       // Load Connection parameters
       if (FLoadParams) then
       begin
        if Not Assigned(ConAdmin) then
         UpdateConAdmin;
        ConAdmin.GetConnectionParams(conname,FIBODatabase.params);
       end;
       ConvertParamsFromDBXToIBO(FIBODatabase);
       FIBODatabase.Connected:=true;
  {$ELSE}
      Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverIBO);
  {$ENDIF}
     end;
   end;
 finally
  paramlist.free;
 end;
end;



{$IFDEF USEBDE}
procedure TRpDatainfoitem.SetRangeForTable(lastrange:boolean);
var
 report:TRpReport;
 eval:TRpEvaluator;
 atable:TTable;
 alist:TStringList;
 i:integer;
begin
 report:=TRpDataInfoList(Collection).FReport As TRpReport;
 eval:=report.Evaluator;
 atable:=TTable(FSQLInternalQuery);
 alist:=TStringList.Create;
 try
  if lastrange then
  begin
   atable.SetRangeEnd;
   alist.Text:=FBDELastRange;
  end
  else
  begin
   atable.SetRangeStart;
   alist.Text:=FBDEFirstRange;
  end;
  for i:=0 to alist.count-1 do
  begin
   if Length(alist.Strings[i])>0 then
   begin
    atable.IndexFields[i].AsVariant:=eval.EvaluateText(alist.Strings[i]);
   end;
  end;
  atable.ApplyRange;
 finally
  alist.free;
 end;
end;
{$ENDIF}


procedure TRpDatabaseinfoitem.DisConnect;
begin
{$IFDEF USESQLEXPRESS}
 if Assigned(FSQLConnection) then
 begin
  if FSQLCOnnection=FSQLInternalConnection then
  begin
   FSQLConnection.Connected:=False;
  end;
 end;
{$ENDIF}
{$IFDEF USEIBX}
 if assigned(FIBInternalTransaction) then
   if FIBInternalTransaction.InTransaction then
    FIBInternalTransaction.Commit;
 if Assigned(FIBInternalDatabase) then
 begin
  FIBInternalDatabase.Connected:=False;
 end;
{$ENDIF}
{$IFDEF USEZEOS}
 if Assigned(FZInternalDatabase) then
 begin
  FZInternalDatabase.Connected:=False;
 end;
{$ENDIF}
{$IFDEF USEBDE}
 if (Assigned(FBDEDatabase) and createdBDE) then
  FBDEDatabase.Connected:=false;
{$ENDIF}
{$IFDEF USEADO}
 if Assigned(FADOConnection) then
  FADOConnection.Connected:=false;
{$ENDIF}
{$IFDEF USEIBO}
 if Assigned(FIBODatabase) then
 begin
  FIBODatabase.Connected:=False;
 end;
{$ENDIF}
end;

procedure ExtractUnionFields(var datasetname:string;alist:TStrings);
var
 index:integer;
 fullname:string;
begin
 alist.Clear;
 fullname:=datasetname;
 index:=Pos('-',fullname);
 if index=0 then
  exit;
 datasetname:=Copy(fullname,1,index-1);
 fullname:=Copy(fullname,index+1,Length(fullname));
 index:=Pos(';',fullname);
 while (index>0) do
 begin
  alist.Add(UpperCase(Copy(fullname,1,index-1)));
  fullname:=Copy(fullname,index+1,Length(fullname));
  index:=Pos(';',fullname);
 end;
 alist.Add(UpperCase(fullname));
end;



procedure TRpDataInfoItem.Connect(databaseinfo:TRpDatabaseInfoList;params:TRpParamList);
var
 index:integer;
 i:integer;
 afilename:string;
 datainfosource:TRpDatainfoItem;
 baseinfo:TRpDatabaseInfoItem;
 doexit:boolean;
 param:TRpParam;
 atype:TFieldType;
 avalue:Variant;
 afilter:String;
 sqlsentence:widestring;
{$IFDEF USEADO}
  j:integer;
  adoParam:TParameter;
{$ENDIF}
 datasetname:string;
 originalfields,commonfields:TStrings;
 ndataset:TClientDataset;
begin
 if connecting then
  Raise Exception.Create(SRpCircularDatalink+' - '+alias);
 connecting:=true;
 try
  FDBInfoList:=databaseinfo;
  FParamsList:=params;
  doexit:=false;
  datainfosource:=nil;
  if assigned(FDataset) then
  begin
   if FDataset.Active then
   begin
    // For opened datasets they must go to first record
    // Before printing, must not go first here because
    // child subreports and master-source master-fields
    if FDataset<>FSQLInternalQuery then
     FDataset.First;
{$IFDEF USERPDATASET}
    if cached then
    begin
     if Not FCachedDataset.Active then
     begin
      FCachedDataset.Dataset:=FDataset;
      FCachedDataset.DoOpen;
     end;
    end;
{$ENDIF}
    doexit:=true;
   end;
   if ((FDataset<>FSQLInternalQuery) and (not doexit)) then
   begin
    try
     FDataset.Active:=true;
    except
     on E:Exception do
     begin
      Raise Exception.Create(E.Message);
     end;
    end;
{$IFDEF USERPDATASET}
    if cached then
    begin
//     FCachedDataset.DoClose;
     FCachedDataset.Dataset:=FDataset;
     FCachedDataset.DoOpen;
    end;
{$ENDIF}
    doexit:=true;
   end;
  end;
  if (not doexit) then
  begin
   // Substitute text in parameters
   if (Length(SQLOverride)>0) then
    sqlsentence:=SQLOverride
   else
    sqlsentence:=FSQL;
   for i:=0 to params.Count-1 do
   begin
    param:=params.items[i];
    if param.ParamType in [rpParamSubst,rpParamSubstE,rpParamSubstList,rpParamMultiple] then
    begin
     index:=param.Datasets.IndexOf(Alias);
     if index>=0 then
     begin
      if ((param.ParamType=rpParamSubstE) or (param.ParamType=rpParamSubstList)) then
       sqlsentence:=StringReplace(sqlsentence,param.Search,param.LastValue,[rfReplaceAll, rfIgnoreCase])
      else
       sqlsentence:=StringReplace(sqlsentence,param.Search,param.Value,[rfReplaceAll, rfIgnoreCase]);
     end;
    end;
   end;

   if Assigned(FDataLink) then
   begin
    FDataLink.Free;
    FDataLink:=nil;
   end;
   if Assigned(FMasterSource) then
   begin
    FMasterSource.Free;
    FMasterSource:=nil;
   end;
   // Opens the connection
   index:=databaseinfo.IndexOf(Databasealias);
   if index<0 then
    Raise Exception.Create(SRPDabaseAliasNotFound+' : '+FDatabaseAlias);
   baseinfo:=databaseinfo.items[index];
   baseinfo.Connect(params);

   // Connect first the parent datasource
   if Length(DataSource)>0 then
   begin
    index:=TRpDatainfolist(Collection).IndexOf(datasource);
    if index<0 then
     Raise Exception.Create(SRPMasterNotFound+alias+' - '+datasource);
    datainfosource:=TRpDatainfolist(Collection).Items[index];
    datainfosource.connect(databaseinfo,params);
   end;


   if not assigned(FSQLInternalQuery) then
   begin
    case baseinfo.FDriver of
     rpdatadbexpress:
      begin
{$IFDEF USESQLEXPRESS}
       FSQLInternalQuery:=TSQLQuery.Create(nil);
{$ELSE}
       Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverDBX);
{$ENDIF}
      end;
     rpdataibx:
      begin
{$IFDEF USEIBX}
       FSQLInternalQuery:=TIBQuery.Create(nil);
{$ELSE}
       Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverIBX);
{$ENDIF}
      end;
     rpdatazeos:
      begin
{$IFDEF USEZEOS}
       FSQLInternalQuery:=TZReadOnlyQuery.Create(nil);
{$ELSE}
       Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverZeos);
{$ENDIF}
      end;
     rpdatamybase:
      begin
{$IFDEF USERPDATASET}
 {$IFDEF FPC}
       FSQLInternalQuery:=TMemDataset.Create(nil);
 {$ENDIF}
 {$IFNDEF FPC}
       FSQLInternalQuery:=TClientDataset.Create(nil);
 {$ENDIF}
{$ENDIF}
{$IFNDEF USERPDATASET}
       Raise Exception.Create(SRpClientDatasetNotSupported);
{$ENDIF}
      end;
     rpdatabde:
      begin
{$IFDEF USEBDE}
       if FBDEType=rpdquery then
       begin
        FSQLInternalQuery:=TQuery.Create(nil);
        if Assigned(databaseinfo.FBDESession) then
         TQuery(FSQLInternalQuery).SessionName:=databaseinfo.FBDESession.SessionName;
       end
       else
       begin
        FSQLInternalQuery:=TTable.Create(nil);
        if Assigned(databaseinfo.FBDESession) then
         TTable(FSQLInternalQuery).SessionName:=databaseinfo.FBDESession.SessionName;
       end;
{$ELSE}
       Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverBDE);
{$ENDIF}
      end;
     rpdataado:
      begin
{$IFDEF USEADO}
       FSQLInternalQuery:=TADOQuery.Create(nil);
{$IFDEF USEVARIANTS}
       TADOQuery(FSQLInternalQuery).CommandTimeout:=0;
{$ENDIF}
{$ELSE}
       Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverADO);
{$ENDIF}
      end;
     rpdataibo:
      begin
{$IFDEF USEIBO}
       FSQLInternalQuery:=TIBOQuery.Create(nil);
{$ELSE}
       Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverIBO);
{$ENDIF}
      end;
    end;
   end
   else
   begin
    case baseinfo.FDriver of
     rpdatadbexpress:
      begin
{$IFDEF USESQLEXPRESS}
       if Not (FSQLInternalQuery is TSQLQuery) then
       begin
        FSQLInternalQuery.Free;
        FSQLInternalQuery:=nil;
        FSQLInternalQuery:=TSQLQuery.Create(nil);
       end;
{$ENDIF}
      end;
     rpdataibx:
      begin
{$IFDEF USEIBX}
       if Not (FSQLInternalQuery is TIBQuery) then
       begin
        FSQLInternalQuery.Free;
        FSQLInternalQuery:=nil;
        FSQLInternalQuery:=TIBQuery.Create(nil);
       end;
{$ENDIF}
      end;
     rpdatazeos:
      begin
{$IFDEF USEZEOS}
       if Not (FSQLInternalQuery is TZReadOnlyQuery) then
       begin
        FSQLInternalQuery.Free;
        FSQLInternalQuery:=nil;
        FSQLInternalQuery:=TZReadOnlyQuery.Create(nil);
       end;
{$ENDIF}
      end;
     rpdatabde:
      begin
{$IFDEF USEBDE}
       if FBDEType=rpdquery then
       begin
        if Not (FSQLInternalQuery is TQuery) then
        begin
         FSQLInternalQuery.Free;
         FSQLInternalQuery:=nil;
         FSQLInternalQuery:=TQuery.Create(nil);
         if Assigned(databaseinfo.FBDESession) then
          TQuery(FSQLInternalQuery).SessionName:=databaseinfo.FBDESession.SessionName;
        end;
       end
       else
       begin
        if Not (FSQLInternalQuery is TTable) then
        begin
         FSQLInternalQuery.Free;
         FSQLInternalQuery:=nil;
         FSQLInternalQuery:=TTable.Create(nil);
         if Assigned(databaseinfo.FBDESession) then
          TTable(FSQLInternalQuery).SessionName:=databaseinfo.FBDESession.SessionName;
        end;
       end;
{$ENDIF}
      end;
     rpdataado:
      begin
{$IFDEF USEADO}
       if Not (FSQLInternalQuery is TADOQuery) then
       begin
        FSQLInternalQuery.Free;
        FSQLInternalQuery:=nil;
        FSQLInternalQuery:=TADOQuery.Create(nil);
{$IFDEF USEVARIANTS}
        TADOQuery(FSQLInternalQuery).CommandTimeout:=0;
{$ENDIF}
       end;
{$ENDIF}
      end;
     rpdataibo:
      begin
{$IFDEF USEIBO}
       if Not (FSQLInternalQuery is TIBOQuery) then
       begin
        FSQLInternalQuery.Free;
        FSQLInternalQuery:=nil;
        FSQLInternalQuery:=TIBOQuery.Create(nil);
       end;
{$ENDIF}
      end;
    end;
   end;

   FDataset:=FSQLInternalQuery;

   // Assigns the connection
   case baseinfo.Driver of
    rpdatadbexpress:
     begin
{$IFDEF USESQLEXPRESS}
      TSQLQuery(FSQLInternalQuery).SQLConnection:=
       baseinfo.SQLConnection;
      TSQLQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
//      TSQLQuery(FSQLInternalQuery).DataSource:=nil;
{$ENDIF}
     end;
    rpdataibx:
     begin
{$IFDEF USEIBX}
      TIBQuery(FSQLInternalQuery).Database:=
       baseinfo.FIBDatabase;
      TIBQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
      if Assigned(TIBQuery(FSQLInternalQuery).Database) then
      begin
       TIBQuery(FSQLInternalQuery).Transaction:=baseinfo.FIBTransaction;
      end;
      TIBQuery(FSQLInternalQuery).UniDirectional:=true;
      TIBQuery(FSQLInternalQuery).DataSource:=nil;
{$ENDIF}
     end;
    rpdatazeos:
     begin
{$IFDEF USEZEOS}
      TZReadOnlyQuery(FSQLInternalQuery).Connection:=
       baseinfo.FZConnection;
      TZReadOnlyQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
//      TZReadOnlyQuery(FSQLInternalQuery).DataSource:=nil;
{$ENDIF}
     end;
    rpdatamybase:
     begin
{$IFNDEF USERPDATASET}
      Raise Exception.Create(SRpClientDatasetNotSupported);
{$ENDIF}
{$IFDEF USERPDATASET}
      try
{$IFNDEF FPC}
       TClientDataSet(FSQLInternalQuery).IndexName:='';
       TClientDataSet(FSQLInternalQuery).IndexFieldNames:='';
{$ENDIF}
       if Length(FMyBaseFileName)>0 then
       begin
        // Adds the path
        afilename:=baseinfo.FMyBasePath+FMyBaseFilename;
        if Length(FMyBaseFields)>0 then
        begin
{$IFNDEF FPC}
         TClientDataSet(FSQLInternalQuery).IndexDefs.Clear;
         TClientDataSet(FSQLInternalQuery).FieldDefs.Clear;
         FillClientDatasetFromFile(TClientDataSet(FSQLInternalQuery),baseinfo.FMyBasePath+FMyBaseFields,afilename,FMyBaseIndexFields);
{$ENDIF}
{$IFDEF FPC}
         FillClientDatasetFromFile(TMemDataSet(FSQLInternalQuery),baseinfo.FMyBasePath+FMyBaseFields,afilename,FMyBaseIndexFields);
{$ENDIF}
        end
        else
        begin
{$IFNDEF FPC}
         TClientDataSet(FSQLInternalQuery).IndexFieldNames:=FMyBaseIndexFields;
         TClientDataSet(FSQLInternalQuery).LoadFromFile(afilename);
{$ENDIF}
{$IFDEF FPC}
         TMemDataSet(FSQLInternalQuery).LoadFromFile(afilename);
        end;
       end;
{$ENDIF}
{$IFNDEF FPC}
        end;
       end
       else
       begin
        TClientDataSet(FSQLInternalQuery).IndexDefs.Clear;
        TClientDataSet(FSQLInternalQuery).FieldDefs.Clear;
        TClientDataSet(FSQLInternalQuery).IndexDefs.Add('IPRIM',FMyBaseIndexFields,[]);
        TClientDataSet(FSQLInternalQuery).IndexFieldNames:=FMyBaseIndexFields;
       end;
{$ENDIF}
       commonfields:=TStringList.Create;
       originalfields:=TStringList.Create;
       try
        for i:=0 to FDataUnions.Count-1 do
        begin
         datasetname:=FDataUnions[i];
         ExtractUnionFields(datasetname,commonfields);
         index:=TRpDatainfolist(Collection).IndexOf(datasetname);
         if index<0 then
          Raise Exception.Create(SRpDataUnionNotFound+' - '+Alias+' - '+FDataUnions.Strings[i]);
         TRpDatainfolist(Collection).Items[index].Connect(databaseinfo,params);
         if ((i=0) or (not FParallelUnion)) then
         begin
{$IFNDEF FPC}
         CombineAddDataset(TClientDataSet(FSQLInternalQuery),TRpDatainfolist(Collection).Items[index].Dataset,FGroupUnion);
{$ENDIF}
{$IFDEF FPC}
         CombineAddDataset(TMemDataSet(FSQLInternalQuery),TRpDatainfolist(Collection).Items[index].Dataset,FGroupUnion);
{$ENDIF}
          originalfields.Assign(commonfields);
         end
         else
         begin
          ndataset:=CombineParallel(TClientDataset(FSQLInternalQuery),
           TRpDatainfolist(Collection).Items[index].Dataset,'Q'+FormatFloat('00',i+1)+'_',commonfields,originalfields);
          try
           FSQLInternalQuery.Close;
           TClientDataSet(FSQLInternalQuery).FieldDefs.Clear;
           CombineAddDataset(TClientDataSet(FSQLInternalQuery),ndataset,FGroupUnion);
          finally
           ndataset.free;
          end;
         end;
        end;
       finally
        originalfields.free;
        commonfields.free;
       end;
       // Apply filter if exists
       index:=params.IndexOf(Alias+'_FILTER');
       if index>=0 then
       begin
        afilter:=Trim(params.Items[index].AsString);
        if Length(afilter)>0 then
        begin
         try
          if (TClientDataSet(FSQLInternalQuery).Filter<>afilter) then
          begin
           TClientDataSet(FSQLInternalQuery).Filtered:=false;
           TClientDataSet(FSQLInternalQuery).Filter:=afilter;
           TClientDataSet(FSQLInternalQuery).Filtered:=true;
          end;
         except
          on E:Exception do
          begin
           E.Message:=SRpErrorFilter+'-'+afilter+'-'+E.Message;
           raise;
          end;
         end;
        end
        else
        begin
         if TClientDataSet(FSQLInternalQuery).Filtered then
         begin
          TClientDataSet(FSQLInternalQuery).Filtered:=false;
          TClientDataSet(FSQLInternalQuery).Filter:=afilter;
         end;
        end;
       end;
      except
       FDataset:=nil;
       FSQLInternalQuery.free;
       FSQLInternalQuery:=nil;
       raise;
      end;
{$ENDIF}
     end;
    rpdatabde:
     begin
{$IFDEF USEBDE}
      if FBDEType=rpdquery then
      begin
       TQuery(FSQLInternalQuery).DatabaseName:=baseinfo.FBDEDatabase.DatabaseName;
      end
      else
      begin
       TTable(FSQLInternalQuery).DatabaseName:=baseinfo.FBDEDatabase.DatabaseName;
      end;
      TBDEDataset(FSQLInternalQuery).Filter:=FBDEFilter;
      if length(Trim(FBDEFilter))>0 then
       TBDEDataset(FSQLInternalQuery).Filtered:=True;
      if FBDEType=rpdquery then
      begin
       TQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
       TQuery(FSQLInternalQUery).UniDirectional:=True;
       TQuery(FSQLInternalQuery).DataSource:=nil;
      end
      else
      begin
       TTable(FSQLInternalQuery).MasterSource:=nil;
       TTable(FSQLInternalQuery).Tablename:=FBDETable;
       TTable(FSQLInternalQUery).IndexFieldNames:='';
       TTable(FSQLInternalQUery).IndexName:='';
       if Length(FBDEIndexFields)>0 then
        TTable(FSQLInternalQUery).IndexFieldNames:=FBDEIndexFields;
       if Length(FBDEIndexName)>0 then
        TTable(FSQLInternalQUery).IndexName:=FBDEIndexName;
      end;
{$ENDIF}
     end;
    rpdataado:
     begin
{$IFDEF USEADO}
      if Assigned(FexternalDataSet) then
      begin
         TADOQuery(FSQLInternalQuery).Recordset := _Recordset(FexternalDataSet);
         _Recordset(FexternalDataSet).MoveFirst;
      end
      else
      begin
         TADOQuery(FSQLInternalQuery).Connection:=baseinfo.ADOConnection;
         TADOQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
         TADOQuery(FSQLInternalQuery).CursorType:=ctUnspecified;
   //      TADOQuery(FSQLInternalQuery).CursorType:=ctOpenForwardOnly;
         TADOQuery(FSQLInternalQuery).DataSource:=nil;
   //      Activating this switches break linked querys
   //      TADOQuery(FSQLInternalQuery).CursorLocation:=clUseServer;
      end;
{$ENDIF}
     end;
    rpdataibo:
     begin
{$IFDEF USEIBO}
      TIBOQuery(FSQLInternalQuery).IB_Connection:=baseinfo.FIBODatabase;
      TIBOQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
      TIBOQuery(FSQLInternalQuery).UniDirectional:=true;
      TIBOQuery(FSQLInternalQuery).DataSource:=nil;
{$ENDIF}
     end;
   end;
   // Use the datasource
   if Assigned(datainfosource) then
   begin
    FMasterSource:=TDataSource.Create(nil);
    case baseinfo.Driver of
     rpdatadbexpress:
      begin
{$IFDEF USESQLEXPRESS}
       FDataLink:=TRpDataLink.Create;
       FDataLink.databaseinfo:=databaseinfo;
       FDataLink.datainfo:=TRpDataInfoList(collection);
       FDataLink.datainfoitem:=self;
       FDataLink.DataSource:=FMasterSource;
       FDataLink.dbinfoitem:=databaseinfo.ItemByName(FDatabaseAlias);
       if datainfosource.cached then
        FMasterSource.DataSet:=datainfosource.CachedDataset
       else
        FMasterSource.DataSet:=datainfosource.Dataset;
       AssignParamValuesS(TSQlQuery(FSQLInternalQuery),datainfosource.Dataset);
//       TSQLQuery(FSQLInternalQuery).DataSource:=FMasterSource;
//       if datainfosource.cached then
//        FMasterSource.DataSet:=datainfosource.CachedDataset
//       else
//        FMasterSource.DataSet:=datainfosource.Dataset;
{$ENDIF}
      end;
     rpdataibx:
      begin
{$IFDEF USEIBX}
       TIBQuery(FSQLInternalQuery).DataSource:=FMasterSource;
       if datainfosource.cached then
        FMasterSource.DataSet:=datainfosource.CachedDataset
       else
        FMasterSource.DataSet:=datainfosource.Dataset;
{$ENDIF}
      end;
     rpdatazeos:
      begin
{$IFDEF USEZEOS}
       FDataLink:=TRpDataLink.Create;
       FDataLink.databaseinfo:=databaseinfo;
       FDataLink.datainfo:=TRpDataInfoList(collection);
       FDataLink.datainfoitem:=self;
       FDataLink.DataSource:=FMasterSource;
       FDataLink.dbinfoitem:=databaseinfo.ItemByName(FDatabaseAlias);
       if datainfosource.cached then
        FMasterSource.DataSet:=datainfosource.CachedDataset
       else
        FMasterSource.DataSet:=datainfosource.Dataset;
       AssignParamValuesZ(TZReadOnlyQuery(FSQLInternalQuery),datainfosource.Dataset);
{$ENDIF}
      end;
     rpdatamybase:
      begin
{$IFNDEF FPC}
       TClientDataset(FSQLInternalQuery).MasterFields:=MyBaseMasterFields;
       TClientDataset(FSQLInternalQuery).MasterSource:=FMasterSource;
       if datainfosource.cached then
        FMasterSource.DataSet:=datainfosource.CachedDataset
       else
        FMasterSource.DataSet:=datainfosource.Dataset;
{$ENDIF}
      end;
     rpdatabde:
      begin
{$IFDEF USEBDE}
       if FBDEType=rpdquery then
       begin
        TQuery(FSQLInternalQuery).DataSource:=FMasterSource;
        if datainfosource.cached then
         FMasterSource.DataSet:=datainfosource.CachedDataset
        else
         FMasterSource.DataSet:=datainfosource.Dataset;
       end
       else
       begin
        TTable(FSQLInternalQuery).MasterFields:=BDEMasterFields;
        TTable(FSQLInternalQuery).MasterSource:=FMasterSource;
        if datainfosource.cached then
         FMasterSource.DataSet:=datainfosource.CachedDataset
        else
         FMasterSource.DataSet:=datainfosource.Dataset;
       end;
{$ENDIF}
      end;
     rpdataado:
      begin
{$IFDEF USEADO}
       TADOQuery(FSQLInternalQuery).DataSource:=FMasterSource;
       if datainfosource.cached then
        FMasterSource.DataSet:=datainfosource.CachedDataset
       else
        FMasterSource.DataSet:=datainfosource.Dataset;
{$ENDIF}
      end;
     rpdataibo:
      begin
{$IFDEF USEIBO}
       TIBOQuery(FSQLInternalQuery).DataSource:=FMasterSource;
       if datainfosource.cached then
        FMasterSource.DataSet:=datainfosource.CachedDataset
       else
        FMasterSource.DataSet:=datainfosource.Dataset;
{$ENDIF}
      end;
    end;
   end;
   // Assigns parameters
   for i:=0 to params.count-1 do
   begin
    param:=params.items[i];
    atype:=rpparams.ParamTypeToDataType(param.ParamType);
//    if param.ParamType=rpParamExpreB then
//    begin
     avalue:=param.LastValue;
//    end
//    else
//    begin
//      avalue:=param.ListValue
//    end;
    if ((atype=ftUnknown) or (param.ParamType=rpParamExpreB)) then
{$IFNDEF FPC}
     atype:=VarTypeToDataType(Vartype(avalue));
{$ENDIF}
{$IFDEF FPC}
     Raise Exception.Create('Freepascal does not implement VarTypeToDataType');
{$ENDIF}
    if (param.ParamType in [rpParamSubst,rpParamSubstE,rpParamSubstList,rpParamMultiple]) then
     continue;
    index:=param.Datasets.IndexOf(Alias);
    if index>=0 then
    begin
     case baseinfo.Driver of
      rpdatadbexpress:
       begin
{$IFDEF USESQLEXPRESS}
        TSQLQuery(FSQLInternalQuery).ParamByName(param.Name).DataType:=atype;
        TSQLQuery(FSQLInternalQuery).ParamByName(param.Name).Value:=avalue;
{$ENDIF}
       end;
      rpdataibx:
       begin
{$IFDEF USEIBX}
        TIBQuery(FSQLInternalQuery).ParamByName(param.Name).DataType:=atype;
        TIBQuery(FSQLInternalQuery).ParamByName(param.Name).Value:=avalue;
{$ENDIF}
       end;
      rpdatazeos:
       begin
{$IFDEF USEZEOS}
        TZReadOnlyQuery(FSQLInternalQuery).ParamByName(param.Name).DataType:=atype;
        TZReadOnlyQuery(FSQLInternalQuery).ParamByName(param.Name).Value:=avalue;
{$ENDIF}
       end;
      rpdatabde:
       begin
{$IFDEF USEBDE}
        if FBDEType=rpdquery then
        begin
         TQuery(FSQLInternalQuery).ParamByName(param.Name).DataType:=atype;
         TQuery(FSQLInternalQuery).ParamByName(param.Name).Value:=avalue;
        end
        else
         Raise Exception.Create(SrpParamBDENotSupported);
{$ENDIF}
       end;
      rpdataado:
       begin
{$IFDEF USEADO}
        // Bugfix provided by Argon Konay
        for j := 0 to TADOQuery(FSQLInternalQuery).Parameters.Count - 1 do
        begin
         adoParam := TADOQuery(FSQLInternalQuery).Parameters.Items[j];
         if (UpperCase(adoParam.Name) = UpperCase(param.Name)) then
         begin
          adoParam.DataType := atype;
          adoParam.Value := avalue;
         end;
        end;
//        TADOQuery(FSQLInternalQuery).Parameters.ParamByName(param.Name).DataType:=
//         ParamTypeToDataType(param.ParamType);
//        TADOQuery(FSQLInternalQuery).Parameters.ParamByName(param.Name).Value:=param.ListValue;
{$ENDIF}
       end;
      rpdataibo:
       begin
{$IFDEF USEIBO}
//        TIBOQuery(FSQLInternalQuery).ParamByName(param.Name).AsVariant:=avalue;
        TIBOQuery(FSQLInternalQuery).ParamByName(param.Name).Value:=avalue;
{$ENDIF}
       end;
     end;
    end;
   end;
   if Not Assigned(FSQLInternalQuery) then
    Raise Exception.Create(SRpDriverNotSupported);

   if Cached then
   begin
    FSQLInternalQuery.AfterOpen:=OnConnect;
    FSQLInternalQuery.AfterClose:=OnDisConnect;
   end
   else
   begin
    FSQLInternalQuery.AfterOpen:=nil;
    FSQLInternalQuery.AfterClose:=nil;
   end;
   if Assigned(FDataLink) then
    FDataLink.DoRecordChange;
   FSQLInternalQuery.Active:=true;
{$IFDEF USEBDE}
   if (FSQLInternalQuery is TTable) then
   begin
    // Set the range start and range end
    if Length(Trim(FBDEFirstRange))>0 then
    begin
     SetRangeForTable(false);
    end;
    if Length(Trim(FBDELastRange))>0 then
    begin
     SetRangeForTable(true);
    end;
   end;
{$ENDIF}
{$IFDEF USERPDATASET}
   if cached then
   begin
    FCachedDataset.AfterOpen:=OnConnect;
    FCachedDataset.AfterClose:=OnDisConnect;
//    FCachedDataset.DoClose;
    FCachedDataset.Dataset:=FDataset;
    FCachedDataset.DoOpen;
   end;
{$ENDIF}
  end;
  connecting:=false;
 except
  on E:Exception do
  begin
   connecting:=false;
{$IFDEF USEADO}
   if (E.ClassName='EOleSysError') then
   begin   
    Raise Exception.Create(Alias+':'+E.Message+' Error code:'+IntToStr(EOleSysError(E).ErrorCode));
   end
   else
{$ENDIF}
    Raise Exception.Create(Alias+':'+E.Message);
//    Raise Exception.Create(Alias+':'+E.Message+':'+E.ClassName);
  end;
 end;
end;

 

procedure TRpDataInfoItem.DisConnect;
begin
 if Assigned(FDataLink) then
 begin
  FDataLink.Free;
  FDataLink:=nil;
 end;
 if Assigned(FMasterSource) then
 begin
  FMasterSource.Free;
  FMasterSource:=nil;
 end;
 if Assigned(FDataset) then
 begin
  if FDataset=FSQLInternalQuery then
   FDataset.Active:=false;
{$IFDEF USERPDATASET}
//  if Assigned(FCachedDataset) then
//   FCachedDataset.DoClose;
{$ENDIF}
 end;
end;

constructor TRpDatainfoitem.Create(Collection:TCollection);
begin
 inherited Create(Collection);

 FDataUnions:=TStringList.Create;
 FOpenOnStart:=true;
 FBDEType:=rpdquery;
{$IFDEF USERPDATASET}
 FCachedDataset:=TRpDataset.Create(nil);
{$ENDIF}
end;

destructor TRpDataInfoItem.Destroy;
begin
 try
  FDataUnions.free;
{$IFDEF USERPDATASET}
  FCachedDataset.free;
  FCachedDataset:=nil;
{$ENDIF}
  if assigned(FSQLInternalQuery) then
  begin
   if Assigned(FSQLInternalQuery.datasource) then
    FSQLInternalQuery.datasource.free;
   FSQLInternalQuery.free;
  end;
 finally
  inherited Destroy;
 end;
end;

constructor TRpConnAdmin.Create;
begin
 inherited Create;
 LoadConfig;
end;

procedure TRpConnAdmin.DeleteConnection(conname:string);
begin
 config.EraseSection(conname);
end;

procedure TRpConnAdmin.AddConnection(newname:string;drivername:string);
var
 alist:TStringList;
 i:integer;
begin
 config.EraseSection(newname);
 alist:=TStringList.Create;
 try
  drivers.ReadSectionValues(drivername,alist);
  config.WriteString(newname,'DriverName',drivername);
  for i:=0 to alist.count-1 do
  begin
   if Uppercase(alist.Names[i])<>'GETDRIVERFUNC' then
    if Uppercase(alist.Names[i])<>'VENDORLIB' then
     if Uppercase(alist.Names[i])<>'LIBRARYNAME' then
     begin
      config.WriteString(newname,alist.Names[i],alist.Values[alist.Names[i]]);
     end;
  end;
 finally
  alist.free;
 end;
end;

procedure TRpConnAdmin.GetConnectionNames(alist:TStrings;drivername:String);
var
 alist2:TStringList;
 i:integer;
begin
 alist.clear;
 alist2:=TStringList.Create;
 try
  config.ReadSections(alist2);
  for i:=0 to alist2.Count-1 do
  begin
   if Length(drivername)>0 then
   begin
    if UpperCase(config.ReadString(alist2.Strings[i],'DriverName',''))=
     UpperCase(drivername) then
     alist.Add(alist2.Strings[i]);
   end
   else
    alist.Add(alist2.Strings[i]);
  end;
 finally
  alist2.free;
 end;
end;



procedure TRpConnAdmin.GetDriverNames(alist:TStrings);
var
 alist2:TStringList;
 i:integer;
begin
 alist.clear;
 alist2:=TStringList.Create;
 try
  drivers.ReadSection('Installed Drivers',alist2);
  for i:=0 to alist2.count-1 do
   alist.add(alist2.Strings[i]);
 finally
  alist2.free;
 end;
end;

destructor TRpConnAdmin.Destroy;
begin
 if Assigned(config) then
 begin
  config.free;
  config:=nil;
 end;
 if Assigned(drivers) then
 begin
  drivers.free;
  drivers:=nil;
 end;
 inherited Destroy;
end;


function GetRegistryFile(Setting, Default: string; DesignMode: Boolean): string;
{$IFDEF MSWINDOWS}
var
  Reg: TRegistry;
{$ENDIF}
//{$IFDEF LINUX}
//  GlobalFile: string;
//{$ENDIF}
begin
  {$IFDEF MSWINDOWS}
  Result := '';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKeyReadOnly(SDBEXPRESSREG_SETTING) then
      Result := Reg.ReadString(Setting)
    else
    begin
     Reg.RootKey := HKEY_CURRENT_USER;
     if Reg.OpenKeyReadOnly(SDBEXPRESSREG_SETTING) then
      Result := Reg.ReadString(Setting)
    end;
  finally
    Reg.Free;
  end;
  if Result = '' then
    Result := ExtractFileDir(ParamStr(0)) + '\' + Default;
  {$ENDIF}
//  {$IFDEF LINUX}
//  Result := getenv('HOME') + SDBEXPRESSREG_USERPATH + Default;    { do not localize }
//  if not FileExists(Result) then
//  begin
//    GlobalFile := SDBEXPRESSREG_GLOBALPATH + Default + SConfExtension;
//    if FileExists(GlobalFile) then
//    begin
//      if DesignMode then
//      begin
//        if not CopyConfFile(GlobalFile, Result) then
//          DatabaseErrorFmt(SConfFileMoveError, [GlobalFile, Result])
//      end else
//        Result := GlobalFile;
//    end else
//      DatabaseErrorFmt(SMissingConfFile, [GlobalFile]);
//  end;
//  {$ENDIF}
end;

{$IFDEF MSWINDOWS}
function ObtainDriverRegistryFile(DesignMode: Boolean = False): string;
begin
  Result := GetRegistryFile(SDRIVERREG_SETTING, sDriverConfigFile, DesignMode);
end;

function ObtainConnectionRegistryFile(DesignMode: Boolean = False): string;
begin
  Result := GetRegistryFile(SCONNECTIONREG_SETTING, sConnectionConfigFile, DesignMode);
end;
{$ENDIF}



procedure TRpConnAdmin.LoadConfig;
var
 dbxconpath,dbxdrivpath:String;
{$IFDEF LINUX}
 configdir:string;
{$ENDIF}
begin
 if Assigned(config) then
 begin
  config.free;
  config:=nil;
 end;
 if Assigned(drivers) then
 begin
  drivers.free;
  drivers:=nil;
 end;
 // Looks for ./borland in Linux registry in Windows
{$IFDEF LINUX}
 configdir:=GetEnvironmentVariable('HOME')+'/.borland';
 if Length(configdir)>12 then
 begin
  if Not DirectoryExists(configdir) then
  begin
   if not CreateDir(configdir) then
    Raise Exception.Create(SRpDirCantBeCreated+'-'+configdir);
  end;
 end
 else
  configdir:='/usr/local/etc';
 driverfilename:=configdir+'/'+DBXDRIVERFILENAME;
 configfilename:=configdir+'/'+DBXCONFIGFILENAME;
 if  (configdir='/usr/local/etc') then
 begin
  driverfilename:=driverfilename+'.conf';
  configfilename:=configfilename+'.conf';
 end;
{$ENDIF}
{$IFDEF MSWINDOWS}
 // Looks the registry and if there is not registry
 // Use current dir
 driverfilename:=ObtainDriverRegistryFile;
 configfilename:=ObtainConnectionRegistryFile;
{$ENDIF}

 dbxconpath:=DBXConnectionsOverride;
 dbxdrivpath:=DBXDriversOverride;
 // Override configuration if necessary
 if Length(dbxconpath)>0 then
  configfilename:=dbxconpath;
 if Length(dbxdrivpath)>0 then
  driverfilename:=dbxdrivpath;
 if FileExists(driverfilename) then
 begin
  drivers:=TMemInifile.Create(driverfilename);
 end
 else
 begin
{$IFDEF MSWINDOWS}
   Raise Exception.Create(SRpConfigFileNotExists+' - '+driverfilename);
{$ENDIF}
{$IFDEF LINUX}
  // Check if exists in the current dir
  if FileExists(DBXDRIVERFILENAME) then
  begin
   drivers:=TMemIniFile.Create(DBXDRIVERFILENAME);
   if configdir<>'/usr/local/etc' then
   begin
    CopyFileTo(DBXDRIVERFILENAME,driverfilename);
   end;
  end
  else
  begin
   // Check int /usr/local/etc
   if FileExists('/usr/local/etc/'+DBXDRIVERFILENAME+'.conf') then
   begin
    if configdir<>'/usr/local/etc' then
    begin
     CopyFileTo('/usr/local/etc/'+DBXDRIVERFILENAME+'.conf',driverfilename);
    end;
    drivers:=TMemIniFile.Create(driverfilename);
   end
   else
    Raise Exception.Create(SRpConfigFileNotExists+' - '+DBXDRIVERFILENAME);
  end;
{$ENDIF}
 end;
 if FileExists(configfilename) then
 begin
  config:=TMemInifile.Create(configfilename);
{$IFDEF USEVARIANTS}
 {$IFNDEF FPC}
   config.CaseSensitive:=false;
 {$ENDIF}
{$ENDIF}
 end
 else
 begin
{$IFDEF MSWINDOWS}
   Raise Exception.Create(SRpConfigFileNotExists+' - '+configfilename);
{$ENDIF}
{$IFDEF LINUX}
  // Check if exists in the current dir
  if FileExists(DBXCONFIGFILENAME) then
  begin
   config:=TMemInifile.Create(DBXCONFIGFILENAME);
 {$IFNDEF FPC}
   config.CaseSensitive:=false;
 {$ENDIF}
   CopyFileTo(DBXCONFIGFILENAME,configfilename);
  end
  else
  begin
   // Check int /usr/local/etc
   if FileExists('/usr/local/etc/'+DBXCONFIGFILENAME+'.conf') then
   begin
    CopyFileTo('/usr/local/etc/'+DBXCONFIGFILENAME+'.conf',configfilename);
    config:=TMemIniFile.Create(configfilename);
 {$IFNDEF FPC}
    config.CaseSensitive:=false;
 {$ENDIF}
   end
   else
    Raise Exception.Create(SRpConfigFileNotExists+' - '+DBXCONFIGFILENAME);
  end
{$ENDIF}
 end;
end;

procedure TRpConnAdmin.GetConnectionParams(conname:string;params:TStrings);
begin
 config.ReadSectionValues(conname,params);
end;

procedure TRpConnAdmin.GetDriverLibNames(const drivername:string;var LibraryName,VendorLib:string);
begin
 LibraryName:=drivers.ReadString(DriverName,DLLLIB_KEY,'');
 VendorLib:=drivers.ReadString(DriverName,VENDORLIB_KEY,'');
end;

function TRpDatabaseInfoItem.GetStreamFromSQL(sqlsentence:String;params:TStringList;paramlist:TRpParamList):TStream;
var
 data:TDataset;
 memstream:TMemoryStream;
 astream:TStream;
begin
 Result:=nil;
 data:=OpenDatasetFromSQL(sqlsentence,params,false,paramlist);
 try
  if data.Eof then
   Raise Exception.Create(SRpExternalSectionNotFound);
  if data.FieldCount<1 then
   Raise Exception.Create(SRpExternalSectionNotFound);
  memstream:=TMemoryStream.Create;
  try
   astream:=data.CreateBlobStream(data.fields[0],bmRead);
   memstream.SetSize(astream.size);
{$IFDEF DOTNETD}
   memstream.CopyFrom(astream,memstream.size);
{$ENDIF}
{$IFNDEF DOTNETD}
   astream.Read(memstream.memory^,memstream.size);
{$ENDIF}
   memstream.Seek(0,soFromBeginning);
  except
   memstream.free;
   Raise;
  end;
  Result:=memstream;
 finally
  data.free;
 end;
end;

procedure TRpDataInfoItem.GetFieldNames(fieldlist,fieldtypes,fieldsizes:TStrings);
var
 report:TRpReport;
 alist:TStringList;
 tmpfile:string;
 i:integer;
 baseinfo:TRpDatabaseInfoItem;
 astring:string;
{$IFDEF LINUX}
 aparams:TStringList;
{$ENDIF}
{$IFDEF MSWINDOWS}
 startinfo:TStartupinfo;
 linecount:string;
 FExename,FCommandLine:string;
 procesinfo:TProcessInformation;
{$ENDIF}
begin
 report:=TRpDataInfoList(Collection).FReport As TRpReport;
 // Opens the connection
 i:=report.databaseinfo.IndexOf(Databasealias);
 if i<0 then
  Raise Exception.Create(SRPDabaseAliasNotFound+' : '+FDatabaseAlias);
 baseinfo:=report.databaseinfo.items[i];
 case baseinfo.Driver of
  rpdatadriver:
   begin
    tmpfile:=RpTempFileName;
    alist:=TStringList.Create;
    try
     astring:=RpTempFileName;
     report.StreamFormat:=rpStreamXML;
     report.SaveToFile(astring);
{$IFDEF LINUX}
     aparams:=TStringList.Create;
     try
        aparams.Add('mono');
        aparams.Add(ExtractFilePath(ParamStr(0))+'printreport.exe');
        aparams.Add('-deletereport');
        aparams.Add('-showfields');
        aparams.Add(Alias);
        aparams.Add(tmpfile);
        aparams.Add(astring);
        ExecuteSystemApp(aparams,true);
     finally
        aparams.free;
     end;
{$ENDIF}
{$IFDEF MSWINDOWS}
     linecount:='';
     with startinfo do
     begin
      cb:=sizeof(startinfo);
      lpReserved:=nil;
      lpDesktop:=nil;
      lpTitle:=PChar('Report manager');
      dwX:=0;
      dwY:=0;
      dwXSize:=400;
      dwYSize:=400;
      dwXCountChars:=80;
      dwYCountChars:=25;
      dwFillAttribute:=FOREGROUND_RED or BACKGROUND_RED or BACKGROUND_GREEN or BACKGROUND_BLUe;
      dwFlags:=STARTF_USECOUNTCHARS or STARTF_USESHOWWINDOW;
      cbReserved2:=0;
      lpreserved2:=nil;
     end;

     FExename:=ExtractFilePath(ParamStr(0))+'net/printreport.exe';
     FCommandLine:=' -deletereport -showfields '+Alias+' "'+tmpfile+'" "'+
      astring+'"';
     if Not CreateProcess(Pchar(FExename),Pchar(Fcommandline),nil,nil,True,NORMAL_PRIORITY_CLASS or CREATE_NEW_PROCESS_GROUP,nil,nil,
     startinfo,procesinfo) then
      RaiseLastOSError;
     WaitForSingleObject(procesinfo.hProcess,60000);
{$ENDIF}
     alist.LoadFromFile(tmpfile);
     i:=0;
     while i<alist.Count do
     begin
      fieldlist.Add(alist.Strings[i]);
      fieldtypes.Add(alist.Strings[i+1]);
      if alist.Strings[i+2]<>'-1' then
       fieldsizes.Add(alist.Strings[i+2])
      else
       fieldsizes.Add('');
      i:=i+3;
     end;
    finally
     alist.free;
     SysUtils.DeleteFile(tmpfile);
    end;
   end;
  rpdotnet2driver:
   begin
    tmpfile:=RpTempFileName;
    alist:=TStringList.Create;
    try
     astring:=RpTempFileName;
     report.StreamFormat:=rpStreamXML;
     report.SaveToFile(astring);
{$IFDEF LINUX}
     aparams:=TStringList.Create;
     try
        aparams.Add('mono');
        aparams.Add(ExtractFilePath(ParamStr(0))+'net2/printreport.exe');
        aparams.Add('-deletereport');
        aparams.Add('-showfields');
        aparams.Add(Alias);
        aparams.Add(tmpfile);
        aparams.Add(astring);
        ExecuteSystemApp(aparams,true);
     finally
        aparams.free;
     end;
{$ENDIF}
{$IFDEF MSWINDOWS}
     linecount:='';
     with startinfo do
     begin
      cb:=sizeof(startinfo);
      lpReserved:=nil;
      lpDesktop:=nil;
      lpTitle:=PChar('Report manager');
      dwX:=0;
      dwY:=0;
      dwXSize:=400;
      dwYSize:=400;
      dwXCountChars:=80;
      dwYCountChars:=25;
      dwFillAttribute:=FOREGROUND_RED or BACKGROUND_RED or BACKGROUND_GREEN or BACKGROUND_BLUe;
      dwFlags:=STARTF_USECOUNTCHARS or STARTF_USESHOWWINDOW;
      cbReserved2:=0;
      lpreserved2:=nil;
     end;

     FExename:=ExtractFilePath(ParamStr(0))+'net2\printreport.exe';
     FCommandLine:=' -deletereport -showfields '+Alias+' "'+tmpfile+'" "'+
      astring+'"';
     if Not CreateProcess(Pchar(FExename),Pchar(Fcommandline),nil,nil,True,NORMAL_PRIORITY_CLASS or CREATE_NEW_PROCESS_GROUP,nil,nil,
     startinfo,procesinfo) then
      RaiseLastOSError;
     WaitForSingleObject(procesinfo.hProcess,60000);
{$ENDIF}
     alist.LoadFromFile(tmpfile);
     i:=0;
     while i<alist.Count do
     begin
      fieldlist.Add(alist.Strings[i]);
      fieldtypes.Add(alist.Strings[i+1]);
      if alist.Strings[i+2]<>'-1' then
       fieldsizes.Add(alist.Strings[i+2])
      else
       fieldsizes.Add('');
      i:=i+3;
     end;
    finally
     alist.free;
     SysUtils.DeleteFile(tmpfile);
    end;
   end;
  else
  begin
    report.PrepareParamsBeforeOpen;
    Connect(report.databaseinfo,report.params);
    FillFieldsInfo(Dataset,fieldlist,fieldtypes,fieldsizes);
  end;
 end;
end;

procedure TRpDatabaseInfoItem.GetFieldNames(atable:String;fieldlist,fieldtypes,fieldsizes:TStrings;params:TRpParamList);
{$IFDEF USEZEOS}
var
 res:IZResultSet;
{$ENDIF}
{$IFDEF USEBDE}
var
  bdetable:TTable;
{$ENDIF}
begin
 Connect(params);
 case Driver of
  rpdatadbexpress:
   begin
{$IFDEF USESQLEXPRESS}
    SQLConnection.GetFieldNames(atable,fieldlist);
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverDBX);
{$ENDIF}
   end;
  rpdataibx:
   begin
{$IFDEF USEIBX}
    FIBDatabase.GetFieldNames(atable,fieldlist);
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverIBX);
{$ENDIF}
   end;
  rpdatazeos:
   begin
{$IFDEF USEZEOS}
    res:=FZConnection.DbcConnection.GetMetadata.GetColumns('','',atable,'');
    fieldlist.Clear;
    if res.First then
     fieldlist.Add(res.GetStringByName('COLUMN_NAME'));
    while res.Next do
     fieldlist.Add(res.GetStringByName('COLUMN_NAME'));
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverZeos);
{$ENDIF}
   end;
  rpdatamybase:
   begin
    fieldlist.Clear;
   end;
  rpdatabde:
   begin
{$IFDEF USEBDE}
    bdetable:=TTable.Create(nil);
    try
     bdetable.DatabaseName:=FBDEDatabase.Databasename;
     bdetable.TableName:=atable;
     if Assigned(TRpDatabaseInfoList(Collection).FBDESession) then
      bdetable.SessionName:=TRpDatabaseInfoList(Collection).FBDESession.SessionName;
     bdetable.GetFieldNames(fieldlist);
    finally
     bdetable.free;
    end;
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverBDE);
{$ENDIF}
   end;
  rpdataado:
   begin
{$IFDEF USEADO}
    ADOConnection.GetFieldNames(atable,fieldlist);
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverADO);
{$ENDIF}
   end;
  rpdataibo:
   begin
{$IFDEF USEIBO}
    fieldlist.clear;
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverIBO);
{$ENDIF}
   end;
  rpdatadriver:
   begin
    Raise Exception.Create(SRpDriverNotSupported+' -  Dot net ');
   end;
  rpdotnet2driver:
   begin
    Raise Exception.Create(SRpDriverNotSupported+' -  Dot net 2');
   end;
 end;
end;


procedure TRpDatabaseInfoItem.GetTableNames(Alist:TStrings;params:TRpParamList);
{$IFDEF USEZEOS}
var
 res:IZResultSet;
{$ENDIF}
begin
 Connect(params);

 case Driver of
  rpdatadbexpress:
   begin
{$IFDEF USESQLEXPRESS}
    SQLConnection.GetTableNames(alist);
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverDBX);
{$ENDIF}
   end;
  rpdataibx:
   begin
{$IFDEF USEIBX}
    FIBDatabase.GetTableNames(alist);
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverIBX);
{$ENDIF}
   end;
  rpdatazeos:
   begin
{$IFDEF USEZEOS}
    res:=FZConnection.DbcConnection.GetMetadata.GetTables('','','',nil);
    alist.Clear;
    if res.First then
     alist.Add(res.GetStringByName('TABLE_NAME'));
    while res.Next do
     alist.Add(res.GetStringByName('TABLE_NAME'));
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverZeos);
{$ENDIF}
   end;
  rpdatamybase:
   begin
    alist.Clear;
   end;
  rpdatabde:
   begin
{$IFDEF USEBDE}
    if Assigned(TRpDatabaseInfoList(Collection).FBDESession) then
     TRpDatabaseInfoList(Collection).FBDESession.GetTableNames(FBDEDatabase.Databasename,'',False,False,alist)
    else
     Session.GetTableNames(FBDEDatabase.Databasename,'',False,False,alist);
//    GetTableNames(alist);
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverBDE);
{$ENDIF}
   end;
  rpdataado:
   begin
{$IFDEF USEADO}
    ADOConnection.GetTableNames(alist);
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverADO);
{$ENDIF}
   end;
  rpdataibo:
   begin
{$IFDEF USEIBO}
    alist.clear;
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverIBO);
{$ENDIF}
   end;
 end;
end;

function TRpDatabaseInfoItem.OpenDatasetFromSQL(sqlsentence:String;params:TStringList;onlyexec:Boolean;paramlist:TRpParamList):TDataset;
var
 FSQLInternalQuery:TDataset;
 i:integer;
 astream:TStream;
 param:TRpParamObject;
 paramname:String;
 avariant:Variant;
{$IFDEF USEADO}
  j:integer;
  adoParam:TParameter;
{$ENDIF}
begin
 Result:=nil;
 FSQLInternalQuery:=nil;
 // Connects and opens the dataset
 Connect(paramlist);
 case Driver of
  rpdatadbexpress:
   begin
{$IFDEF USESQLEXPRESS}
    FSQLInternalQuery:=TSQLQuery.Create(nil);
    TSQLQuery(FSQLInternalQuery).SQLConnection:=SQLConnection;
    TSQLQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverDBX);
{$ENDIF}
   end;
  rpdataibx:
   begin
{$IFDEF USEIBX}
    FSQLInternalQuery:=TIBQuery.Create(nil);
    TIBQuery(FSQLInternalQuery).Database:=FIBDatabase;
    TIBQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
    if Assigned(TIBQuery(FSQLInternalQuery).Database) then
    begin
     TIBQuery(FSQLInternalQuery).Transaction:=FIBTransaction;
    end;
    TIBQuery(FSQLInternalQuery).UniDirectional:=true;
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverIBX);
{$ENDIF}
   end;
  rpdatazeos:
   begin
{$IFDEF USEZEOS}
    FSQLInternalQuery:=TZReadOnlyQuery.Create(nil);
    TZReadOnlyQuery(FSQLInternalQuery).Connection:=FZConnection;
    TZReadOnlyQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
//    TZReadOnlyQuery(FSQLInternalQuery).UniDirectional:=true;
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverZeos);
{$ENDIF}
   end;
  rpdatamybase:
   begin
    Raise Exception.Create(SRpDriverNotSupported);
   end;
  rpdatabde:
   begin
{$IFDEF USEBDE}
    FSQLInternalQuery:=TQuery.Create(nil);
    if Assigned(TRpDatabaseInfoList(Collection).FBDESession) then
     TQuery(FSQLInternalQuery).SessionName:=TRpDatabaseInfoList(Collection).FBDESession.SessionName;
    TQuery(FSQLInternalQuery).DatabaseName:=FBDEDatabase.DatabaseName;
    TQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
//    TQuery(FSQLInternalQUery).UniDirectional:=True;
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverBDE);
{$ENDIF}
   end;
  rpdataado:
   begin
{$IFDEF USEADO}
    FSQLInternalQuery:=TADOQuery.Create(nil);
    TADOQuery(FSQLInternalQuery).Connection:=ADOConnection;
    TADOQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
//    TADOQuery(FSQLInternalQuery).CursorType:=ctOpenForwardOnly;
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverADO);
{$ENDIF}
   end;
  rpdataibo:
   begin
{$IFDEF USEIBO}
    FSQLInternalQuery:=TIBOQuery.Create(nil);
    TIBOQuery(FSQLInternalQuery).IB_Connection:=FIBODatabase;
    TIBOQuery(FSQLInternalQuery).SQL.Text:=SQLsentence;
    TIBOQuery(FSQLInternalQuery).UniDirectional:=true;
{$ELSE}
    Raise Exception.Create(SRpDriverNotSupported+' - '+SrpDriverIBO);
{$ENDIF}
   end;
 end;
 // Assigns parameters
 if assigned(params) then
 begin
  for i:=0 to params.count-1 do
  begin
   param:=TRpParamObject(params.Objects[i]);
   if not assigned(param) then
    continue;
   paramname:=Trim(params.Strings[i]);
   if Length(paramname)<1 then
    continue;
   astream:=nil;
   avariant:=Null;
   if Assigned(param.stream) then
    astream:=param.stream
   else
    avariant:=param.Value;
   case Driver of
    rpdatadbexpress:
     begin
{$IFDEF USESQLEXPRESS}
      if assigned(astream) then
      begin
       TSQLQuery(FSQLInternalQuery).ParamByName(paramName).DataType:=ftBlob;
       TSQLQuery(FSQLInternalQuery).ParamByName(paramName).LoadFromStream(astream,ftBlob);
      end
      else
      begin
       TSQLQuery(FSQLInternalQuery).ParamByName(paramName).DataType:=
          VariantTypeToDataType(avariant);
       TSQLQuery(FSQLInternalQuery).ParamByName(paramName).Value:=avariant;
      end;
{$ENDIF}
     end;
    rpdataibx:
     begin
{$IFDEF USEIBX}
      if assigned(astream) then
      begin
       TIBQuery(FSQLInternalQuery).ParamByName(paramName).DataType:=ftBlob;
       TIBQuery(FSQLInternalQuery).ParamByName(paramName).LoadFromStream(astream,ftBlob);
      end
      else
      begin
       TIBQuery(FSQLInternalQuery).ParamByName(paramName).DataType:=
        VariantTypeToDataType(avariant);
       TIBQuery(FSQLInternalQuery).ParamByName(paramName).Value:=avariant;
      end;
{$ENDIF}
     end;
    rpdatazeos:
     begin
{$IFDEF USEZEOS}
      if assigned(astream) then
      begin
       TZReadOnlyQuery(FSQLInternalQuery).ParamByName(paramName).DataType:=ftBlob;
       TZReadOnlyQuery(FSQLInternalQuery).ParamByName(paramName).LoadFromStream(astream,ftBlob);
      end
      else
      begin
       TZReadOnlyQuery(FSQLInternalQuery).ParamByName(paramName).DataType:=
        VariantTypeToDataType(avariant);
       TZReadOnlyQuery(FSQLInternalQuery).ParamByName(paramName).Value:=avariant;
      end;
{$ENDIF}
     end;
    rpdatabde:
     begin
{$IFDEF USEBDE}
      if assigned(astream) then
      begin
       TQuery(FSQLInternalQuery).ParamByName(paramName).DataType:=ftBlob;
       TQuery(FSQLInternalQuery).ParamByName(paramName).LoadFromStream(astream,ftBlob);
      end
      else
      begin
       TQuery(FSQLInternalQuery).ParamByName(paramName).DataType:=
        VariantTypeToDataType(avariant);
       TQuery(FSQLInternalQuery).ParamByName(paramName).Value:=avariant;
      end;
{$ENDIF}
     end;
    rpdataado:
     begin
{$IFDEF USEADO}
      if assigned(astream) then
      begin
       for j := 0 to TADOQuery(FSQLInternalQuery).Parameters.Count - 1 do
       begin
        adoParam := TADOQuery(FSQLInternalQuery).Parameters.Items[j];
        if (UpperCase(adoParam.Name) = UpperCase(paramName)) then
        begin
         adoParam.DataType:=ftBlob;
         adoParam.LoadFromStream(astream,ftBlob);
        end;
       end;
      end
      else
      begin
       for j := 0 to TADOQuery(FSQLInternalQuery).Parameters.Count - 1 do
       begin
        adoParam := TADOQuery(FSQLInternalQuery).Parameters.Items[j];
        if (adoParam.Name = paramName) then
        begin
         adoParam.DataType := VariantTypeToDataType(avariant);
         adoParam.Value := avariant;
        end;
       end;
      end;
{$ENDIF}
     end;
    rpdataibo:
     begin
{$IFDEF USEIBO}
      if assigned(astream) then
      begin
       TIBOQuery(FSQLInternalQuery).ParamByName(paramName).Assign(astream);
      end
      else
      begin
//       TIBOQuery(FSQLInternalQuery).ParamByName(paramName).AsVariant:=avariant;
       TIBOQuery(FSQLInternalQuery).ParamByName(paramName).Value:=avariant;
      end;
{$ENDIF}
     end;
   end;
  end;
 end;
 if onlyexec then
 begin
  // Executes
  case Driver of
   rpdatadbexpress:
    begin
 {$IFDEF USESQLEXPRESS}
     TSQLQuery(FSQLInternalQuery).ExecSQL;
 {$ENDIF}
    end;
   rpdataibx:
    begin
 {$IFDEF USEIBX}
     TIBQuery(FSQLInternalQuery).ExecSQL;
 {$ENDIF}
    end;
   rpdatazeos:
    begin
 {$IFDEF USEZEOS}
     TZReadOnlyQuery(FSQLInternalQuery).ExecSQL;
 {$ENDIF}
    end;
   rpdatamybase:
    begin
     Raise Exception.Create(SRpDriverNotSupported);
    end;
   rpdatabde:
    begin
 {$IFDEF USEBDE}
     TQuery(FSQLInternalQuery).ExecSQL;
 {$ENDIF}
    end;
   rpdataado:
    begin
 {$IFDEF USEADO}
     TADOQuery(FSQLInternalQuery).ExecSQL;
 {$ENDIF}
    end;
   rpdataibo:
    begin
 {$IFDEF USEIBO}
     TIBOQuery(FSQLInternalQuery).ExecSQL;
 {$ENDIF}
    end;
  end;
 end
 else
  FSQLInternalQuery.Active:=True;

 if onlyexec then
  FSQLInternalQuery.Free
 else
  Result:=FSQLInternalQuery;
end;

procedure GetRpDatabaseDrivers(alist:TStrings);
begin
 alist.clear;
 alist.Add('Borland DBExpress');
 alist.Add('B.MyBase and text files');
 alist.Add('Interbase Express');
 alist.Add('Borland Database Engine');
 alist.Add('Microsoft DAO');
 alist.Add('Interbase Objects');
 alist.Add('Zeos Database Objects');
 alist.Add('Dot Net Connection');
 alist.Add('Dot Net 2 Connection');
end;


procedure TRpDataInfoList.IntDisableLink(alist:TStringList;i:integer);
var
 index:integer;
 j:integer;
begin
 for j:=0 to Count-1 do
 begin
  index:=alist.IndexOf(IntToStr(i));
  if index>=0 then
  begin
   if i<>j then
   begin
    if assigned(items[j].FMasterSource) then
    begin
     if items[j].FDataSource=items[i].Alias then
     begin
      IntDisableLink(alist,j);
     end;
    end;
   end;
  end;
 end;
 if Assigned(Items[i].FMasterSource) then
 begin
  index:=alist.IndexOf(IntToStr(i));
  if index>=0 then
  begin
   Items[i].FMasterSource.Enabled:=false;
   alist.Delete(index);
  end;
 end;
end;



procedure TRpDataInfoList.DisableLinks;
var
 alist:TStringList;
 i:integer;
begin
 alist:=TStringList.Create;
 try
  for i:=0 to Count-1 do
  begin
   alist.Add(IntToStr(i));
  end;
  for i:=0 to Count-1 do
  begin
   IntDisableLink(alist,i);
  end;
 finally
  alist.free;
 end;
end;

procedure TRpDataInfoList.IntEnableLink(alist:TStringList;i:integer);
var
 index:integer;
 sindex:integer;
begin
 index:=alist.IndexOf(IntToStr(i));
 if index<0 then
  exit;
 // Enables first the master source
 if Assigned(Items[i].FMasterSource) then
 begin
  sindex:=IndexOf(Items[i].FDataSource);
  if sindex>=0 then
  begin
   IntEnableLink(alist,sindex);
  end;
  Items[i].FMasterSource.Enabled:=True;
 end;
 alist.Delete(index);
end;

procedure TRpDataInfoList.EnableLinks;
var
 alist:TStringList;
 i:integer;
begin
 alist:=TStringList.Create;
 try
  for i:=0 to Count-1 do
  begin
   alist.Add(IntToStr(i));
  end;
  for i:=0 to Count-1 do
  begin
   IntEnableLink(alist,i);
  end;
 finally
  alist.free;
 end;
end;

procedure ParseFields(fields:String;list:TStrings);
var
 fieldrest:string;
 index:integer;
begin
 fieldrest:=fields;
 list.clear;
 repeat
  index:=Pos(';',fieldrest);
  if index>0 then
  begin
   list.add(Copy(fieldrest,1,index-1));
   fieldrest:=Copy(fieldrest,index+1,Length(fieldrest));
  end;
 until index<1;
 list.add(fieldrest);
end;



function CombineParallel(data1:TClientDataset;data2:TDataset;prefix:string;commonfields:TStrings;originalfields:TStrings):TClientDataset;
var
 aresult:TClientDataset;
 lfields1:TStringList;
 lfields2:TStringList;
 i,index:integer;
 fname:string;
 fdef:TFieldDef;
 counter:integer;
 indexfieldnames:string;
begin
 counter:=0;
 aresult:=TClientDataset.Create(nil);
 lfields1:=TStringList.Create;
 lfields2:=TStringList.Create;
 try
  aresult.FieldDefs.Assign(data1.FieldDefs);
  aresult.FieldDefs.Add(prefix,ftInteger);
  indexfieldnames:=prefix;
  for i:=0 to originalfields.Count-1 do
  begin
   indexfieldnames:=indexfieldnames+';'+originalfields[i];
  end;
  aresult.IndexDefs.Add('IPRIMINDEX',indexfieldnames,[]);
  if indexfieldnames<>prefix then
   aresult.IndexFieldNames:=indexfieldnames;
  for i:=0 to data2.FieldDefs.Count-1 do
  begin
   fname:=UpperCase(data2.FieldDefs.Items[i].Name);
   index:=commonfields.IndexOf(fname);
   if (index<0) then
   begin
    lfields1.Add(data2.FieldDefs.Items[i].Name);
    lfields2.Add(prefix+data2.FieldDefs.Items[i].Name);
    fdef:=aresult.FieldDefs.AddFieldDef;
    fdef.DataType:=data2.FieldDefs[i].DataType;
    fdef.Precision:=data2.FieldDefs[i].Precision;
    fdef.Size:=data2.FieldDefs[i].Size;
//    fdef.Assign(data2.FieldDefs[i]);
    fdef.Name:=prefix+data2.FieldDefs.Items[i].Name;
    fdef.DisplayName:=fdef.Name;
   end
   else
   begin
    lfields1.Add(data2.FieldDefs.Items[i].Name);
    lfields2.Add(data2.FieldDefs.Items[i].Name);
    Inc(counter);
   end;
  end;
  aresult.CreateDataSet;
  data1.First;
  while not data1.Eof do
  begin
   aresult.Append;
   try
    for i:=0 to data1.Fields.Count-1 do
    begin
     aresult.Fields[i].AsVariant:=data1.Fields[i].AsVariant;
    end;
    aresult.FieldByName(prefix).Value:=0;
    aresult.Post;
   except
    aresult.Cancel;
    raise;
   end;
   data1.Next;
  end;
  aresult.First;
  while not data2.eof do
  begin
   if aresult.Indexfieldnames<>'' then
   begin
    aresult.SetKey;
    for i:=0 to commonfields.Count-1 do
    begin
     aresult.FieldByName(originalfields[i]).AsVariant:=data2.FieldByName(commonfields.Strings[i]).AsVariant;
    end;
    aresult.FieldByName(prefix).Value:=0;
    if (aresult.GotoKey) then
     aresult.Edit
    else
     aresult.Append;
   end
   else
   begin
    if aresult.Eof then
     aresult.Append
    else
     aresult.Edit;
   end;
   try
    for i:=0 to data2.fields.Count-1 do
    begin
     aresult.FieldByName(lfields2.Strings[i]).AsVariant:=data2.FieldByName(lfields1.Strings[i]).AsVariant;
    end;
    aresult.FieldByName(prefix).Value:=1;
    aresult.Post;
   except
    aresult.cancel;
    raise;
   end;
   data2.Next;
   if aresult.indexfieldnames='' then
    aresult.Next;
  end;
 finally
  lfields1.free;
  lfields2.free;
 end;
 aresult.first;
 Result:=aresult;
end;


{$IFDEF USERPDATASET}
{$IFDEF FPC}
procedure CombineAddDataset(client:TMemDataset;data:TDataset;group:boolean);
{$ENDIF}
{$IFNDEF FPC}
procedure CombineAddDataset(client:TClientDataset;data:TDataset;group:boolean);
{$ENDIF}
var
 i,index:integer;
 groupfields:TStringList;
 groupfieldindex:TStringList;
 grouped:boolean;
begin
 groupfields:=TStringList.Create;
 groupfieldindex:=TStringList.Create;
 try
  // Combine the two datasets
  client.Close;
  client.FieldDefs.Assign(data.FieldDefs);
{$IFNDEF FPC}
   client.CreateDataSet;
{$ENDIF}
{$IFDEF FPC}
   client.CreateTable;
{$ENDIF}
  if (data.fields.Count>client.Fields.Count) then
  begin
   Raise Exception.Create(SRpCannotCombine);
  end;
  if group then
  begin
{$IFNDEF FPC}
   ParseFields(client.IndexFieldNames,groupfields);
   for i:=0 to groupfields.count-1 do
   begin
    groupfieldindex.Add(IntToStr(client.FieldByName(groupfields.strings[i]).index));
   end;
{$ENDIF}
{$IFDEF FPC}
   Raise Exception.Create('TMemDataset does not implement indexes');
{$ENDIF}
  end;
  while not data.eof do
  begin
   grouped:=false;
   if Group then
   begin
{$IFDEF FPC}
    Raise Exception.Create('TMemDataset does not implement indexes');
{$ENDIF}
{$IFNDEF FPC}
    client.SetKey;
    for i:=0 to groupfieldindex.count-1 do
    begin
     index:=StrToInt(groupfieldindex.Strings[i]);
     client.Fields[index].AsVariant:=data.Fields[index].AsVariant;
    end;
    if client.GotoKey then
    begin
     grouped:=true;
     client.edit;
     try
      for i:=0 to data.fieldcount-1 do
      begin
       index:=groupfieldindex.IndexOf(IntToStr(i));
       if index<0 then
       begin
        if Not data.Fields[i].IsNull then
        begin
         if client.Fields[i].IsNull then
          client.Fields[i].AsVariant:=data.Fields[i].AsVariant
         else
          client.Fields[i].AsVariant:=client.Fields[i].AsVariant+data.Fields[i].AsVariant;
        end;
       end;
      end;
      client.post;
     except
      client.cancel;
      raise;
     end;
    end;
{$ENDIF}
   end;
   if not grouped then
   begin
    client.Append;
    try

     for i:=0 to data.fieldcount-1 do
     begin
      client.Fields[i].AsVariant:=data.Fields[i].AsVariant;
     end;
     client.post;
    except
     client.cancel;
     raise;
    end;
   end;
   data.Next;
  end;
  client.First;
  if data is TClientDataset then
   TClientDataSet(data).First;
 finally
  groupfields.free;
  groupfieldindex.free;
 end;
end;
{$ENDIF}

procedure TRpDatabaseInfoItem.DefineProperties(Filer:TFiler);
begin
 inherited;

 Filer.DefineProperty('ADOConnectionString',ReadAdoConnectionString,WriteAdoConnectionString,True);
end;

procedure TRpDatabaseInfoItem.ReadAdoConnectionString(Reader:TReader);
begin
 FAdoConnectionString:=ReadWideString(Reader);
end;

procedure TRpDatabaseInfoItem.WriteAdoConnectionString(Writer:TWriter);
begin
 WriteWideString(Writer, FAdoConnectionString);
end;

procedure TRpDatabaseInfoList.SaveToFile(ainifile:String);
var
 i:integer;
 inif:TMemInifile;
 concount:integer;
 aitem:TRpDatabaseInfoItem;
 conname:String;
begin
 inif:=TMemInifile.Create(ainifile);
 try
  concount:=Count;
  inif.WriteInteger('REPMAN_CONNECTIONS','COUNT',concount);
  for i:=0 to concount-1 do
  begin
   aitem:=Items[i];
   conname:='REPMAN_CONNECTION'+IntToStr(i);
   inif.WriteString(conname,'NAME',aitem.FAlias);
   inif.WriteString(conname,'ADOSTRING',aitem.ADOConnectionString);
   inif.WriteBool(conname,'LOADPARAMS',aitem.LoadParams);
   inif.WriteBool(conname,'LOADDRIVERPARAMS',aitem.LoadDriverParams);
   inif.WriteBool(conname,'LOGINPROMPT',aitem.LoginPrompt);
   inif.WriteInteger(conname,'DRIVER',Integer(aitem.Driver));
   inif.WriteString(conname,'REPORTTABLE',aitem.ReportTable);
   inif.WriteString(conname,'REPORTFIELD',aitem.ReportField);
   inif.WriteString(conname,'REPORTSEARCHFIELD',aitem.ReportSearchField);
   inif.WriteString(conname,'REPORTGROUPSTABLE',aitem.ReportGroupsTable);
  end;
  inif.UpdateFile;
 finally
  inif.free;
 end;
end;

procedure TRpDatabaseInfoList.LoadFromFile(ainifile:String);
var
 i:integer;
 inif:TMemInifile;
 concount:integer;
 aitem:TRpDatabaseInfoItem;
 aname:String;
 conname:String;
begin
 inif:=TMemInifile.Create(ainifile);
 try
  Clear;
  concount:=inif.ReadInteger('REPMAN_CONNECTIONS','COUNT',0);
  for i:=0 to concount-1 do
  begin
   conname:='REPMAN_CONNECTION'+IntToStr(i);
   aname:=inif.ReadString(conname,'NAME','CONNECTION'+IntToStr(i));
   aitem:=Add(aname);
   aitem.ADOConnectionString:=inif.ReadString(conname,'ADOSTRING',aitem.ADOConnectionString);
   aitem.LoadParams:=inif.ReadBool(conname,'LOADPARAMS',aitem.LoadParams);
   aitem.LoadDriverParams:=inif.ReadBool(conname,'LOADDRIVERPARAMS',aitem.LoadDriverParams);
   aitem.LoginPrompt:=inif.ReadBool(conname,'LOGINPROMPT',aitem.LoginPrompt);
   aitem.Driver:=TRpDbDriver(inif.ReadInteger(conname,'DRIVER',Integer(aitem.Driver)));
   aitem.ReportTable:=inif.ReadString(conname,'REPORTTABLE',aitem.ReportTable);
   aitem.ReportField:=inif.ReadString(conname,'REPORTFIELD',aitem.ReportField);
   aitem.ReportSearchField:=inif.ReadString(conname,'REPORTSEARCHFIELD',aitem.ReportSearchField);
   aitem.ReportGroupsTable:=inif.ReadString(conname,'REPORTGROUPSTABLE',aitem.ReportGroupsTable);
  end;
 finally
  inif.free;
 end;
end;

procedure TRpDatabaseInfoItem.CreateLibrary(reporttable,reportfield,reportsearchfield,groupstable:String;paramlist:TRpParamList);
var
 astring:String;
begin
 // Creates the library
 astring:='CREATE TABLE '+reporttable+' ('+reportsearchfield+' VARCHAR(50) NOT NULL,'+
  reportfield+' BLOB,REPORT_GROUP INTEGER,USER_FLAG INTEGER,PRIMARY KEY ('+reportsearchfield+'))';
 OpenDatasetFromSQL(astring,nil,true,paramlist);
 astring:='CREATE TABLE REPMAN_GROUPS (GROUP_CODE INTEGER NOT NULL,'+
  'GROUP_NAME VARCHAR(50),PARENT_GROUP INTEGER NOT NULL,'+
  'PRIMARY KEY (GROUP_CODE))';
 OpenDatasetFromSQL(astring,nil,true,paramlist);
end;



function TRpDatabaseInfoList.GetReportStream(ConnectionName:String;ReportName:WideString;paramlist:TRpParamList):TStream;
var
 index:integer;
begin
 index:=IndexOf(ConnectionName);
 if index<0 then
  Raise Exception.Create(SRPDabaseAliasNotFound+':'+ConnectionName);
 Result:=Items[index].GetReportStream(Reportname,paramlist);
end;

procedure TRpDatabaseInfoList.SaveReportStream(ConnectionName:String;ReportName:WideString;astream:TStream;paramlist:TRpParamList);
var
 index:integer;
begin
 index:=IndexOf(ConnectionName);
 if index<0 then
  Raise Exception.Create(SRPDabaseAliasNotFound+':'+ConnectionName);
 Items[index].SaveReportStream(Reportname,astream,paramlist);
end;


function TRpDatabaseInfoItem.GetReportStream(ReportName:WideString;paramlist:TRpParamList):TStream;
var
 astring:String;
 params:TStringList;
 aparam:TRpParamObject;
 adata:TDataset;
 astream:TStream;
begin
 Result:=nil;
 astring:='SELECT '+ReportField+' FROM '+
  ReportTable+' WHERE '+ReportSearchField+
  '=:REPNAME';
 params:=TStringList.Create;
 try
  aparam:=TRpParamObject.Create;
  try
   // WideStrings not supported by most dbdrivers
   aparam.Value:=String(reportname);
   params.AddObject('REPNAME',aparam);
   adata:=OpenDatasetFromSQL(astring,params,false,paramlist);
   try
    if adata.eof and adata.Bof then
     Raise Exception.Create(SRptReportnotfound+':'+Alias+':'+ReportName);
    astream:=adata.CreateBlobStream(adata.Fields[0],bmRead);
    try
     Result:=TMemoryStream.Create;
     Result.CopyFrom(astream,astream.Size);
     Result.Seek(0,soFromBeginning);
    finally
     astream.free;
    end;
   finally
    adata.free;
   end;
  finally
   aparam.free;
  end;
 finally
  params.free;
 end;
end;

procedure TRpDatabaseInfoItem.SaveReportStream(ReportName:WideString;astream:TStream;paramlist:TRpParamList);
var
 astring:String;
 params:TStringList;
 aparam,aparam2:TRpParamObject;
 adata:TDataset;
begin
 params:=TStringList.Create;
 try
  aparam:=TRpParamObject.Create;
  aparam2:=TRpParamObject.Create;
  try
   // WideStrings not supported
   aparam.Value:=String(reportname);
   aparam2.Stream:=astream;
   params.AddObject('REPNAME',aparam);
   // if the report does not exists raise an error
   astring:='SELECT '+ReportSearchField+' FROM '+
    ReportTable+' WHERE '+ReportSearchField+
    '=:REPNAME';
   adata:=OpenDatasetFromSQL(astring,params,false,paramlist);
   try
    if adata.eof and adata.Bof then
     Raise Exception.Create(SRptReportnotfound+':'+Alias+':'+ReportName);
   finally
    adata.free;
   end;
   astring:='UPDATE '+ReportTable+' SET '+ReportField+'=:REPORT'
    +' WHERE '+ReportSearchField+
    '=:REPNAME';
   params.AddObject('REPORT',aparam2);
   OpenDatasetFromSQL(astring,params,true,paramlist);
   DoCommit;
  finally
   aparam.free;
   aparam2.free;
  end;
 finally
  params.free;
 end;
end;

{$IFDEF FPC}
procedure TRpDatabaseInfoList.FillTreeDir(ConnectionName:String;alist:TStrings);
begin
 Raise Exception.Create('FIllTreeDir Not implemented on Freepascal version');
end;
{$ENDIF}
{$IFNDEF FPC}
procedure TRpDatabaseInfoList.FillTreeDir(ConnectionName:String;alist:TStrings);
var
 index:integer;
 adatareports:TDataset;
 adatagroups:TDataset;
 dbinfo:TRpDatabaseInfoItem;
 DReportgroups,DReportgroups2:TClientDataset;
 Dreports:TClientDataset;
 groupcode:Integer;
 grouppath:string;
 sqltext:string;
 havegroup:Boolean;
 i:integer;


 function CalcGroupPath(acode:Integer):String;
 var
  parent:integer;
  agroupname:String;
 begin
  if DReportgroups2.FindKey([acode]) then
  begin
   parent:=0;
   if Not DReportgroups2.FieldByName('PARENT_GROUP').IsNull then
    parent:=DReportgroups2.FieldByName('PARENT_GROUP').AsInteger;
   if parent<0 then
    parent:=0;
   agroupname:=DReportgroups2.FieldByName('GROUP_NAME').AsString;
   if parent>0 then
    Result:=CalcGroupPath(parent)+C_DIRSEPARATOR+agroupname
   else
    Result:=agroupname;
  end
  else
   Result:='';
 end;

begin
 index:=IndexOf(ConnectionName);
 if index<0 then
  Raise Exception.Create(SRPAliasNotExists+' - '+Connectionname);
 adatagroups:=nil;
 alist.Clear;
 dbinfo:=Items[Index];
 dbinfo.Connect(nil);
 sqltext:='SELECT '+dbinfo.ReportSearchField;
 if Length(dbinfo.Reportgroupstable)>0 then
 begin
  if dbinfo.Reportgroupstable='GINFORME' then
   sqltext:=sqltext+',GRUPO AS REPORT_GROUP'
  else
   sqltext:=sqltext+',REPORT_GROUP';
 end;
 sqltext:=sqltext+' FROM '+dbinfo.reporttable;
 adatareports:=dbinfo.OpenDatasetFromSQL(sqltext,nil,false,nil);
 try
  if Length(dbinfo.Reportgroupstable)>0 then
  begin
   if dbinfo.ReportGroupsTable='GINFORME' then
   begin
    adatagroups:=
     dbinfo.OpenDatasetFromSQL('SELECT CODIGO AS GROUP_CODE,NOMBRE AS GROUP_NAME,'+
       ' GRUPO AS PARENT_GROUP FROM '+dbinfo.Reportgroupstable,nil,false,nil);
   end
   else
    adatagroups:=
     dbinfo.OpenDatasetFromSQL('SELECT GROUP_CODE,GROUP_NAME,'+
       ' PARENT_GROUP FROM '+dbinfo.Reportgroupstable,nil,false,nil);
  end;
  try
   // Fill client dataset helpers
   DReportGroups:=TClientDataSet.Create(nil);
   DReportGroups2:=TClientDataSet.Create(nil);
   DReports:=TClientDataSet.Create(nil);
   try
    DReportGroups.FieldDefs.Add('GROUP_CODE',ftInteger,0,true);
    DReportGroups.FieldDefs.Add('GROUP_NAME',ftString,100,false);
    DReportGroups.FieldDefs.Add('PARENT_GROUP',ftInteger,0,false);
    DReportGroups.FieldDefs.Add('GROUP_PATH',ftMemo,250,false);
    DReportGroups2.FieldDefs.Assign(DReportGroups.FieldDefs);
    DReports.FieldDefs.Add('REPORT_NAME',ftString,100,true);
    DReports.FieldDefs.Add('REPORT_GROUP',ftInteger,0,false);
    DReports.IndexDefs.Add('IGROUP','REPORT_GROUP',[]);
    DReports.IndexFieldNames:='REPORT_GROUP';
    DReportGroups.IndexDefs.Add('IGROUP','GROUP_CODE',[]);
    DReportGroups.IndexFieldNames:='GROUP_CODE';
    DReportGroups2.IndexDefs.Add('IGROUP','GROUP_CODE',[]);
    DReportGroups2.IndexFieldNames:='GROUP_CODE';
    DReportGroups.CreateDataset;
    DReportGroups2.CreateDataset;
    DReports.CreateDataset;
    // Fill the datasets
    if Length(dbinfo.Reportgroupstable)>0 then
    begin
     While Not adatagroups.Eof do
     begin
      DReportGroups.Append;
      try
       DReportGroups.FieldByName('GROUP_CODE').Value:=adatagroups.FieldByName('GROUP_CODE').Value;
       DReportGroups.FieldByName('GROUP_NAME').AsVariant:=adatagroups.FieldByName('GROUP_NAME').AsVariant;
       DReportGroups.FieldByname('PARENT_GROUP').AsVariant:=adatagroups.FieldByName('PARENT_GROUP').AsVariant;
       DReportGroups2.Append;
       try
        for i:=0 to DReportGroups2.Fields.Count-1 do
        begin
         DReportGroups2.Fields[i].AsVariant:=DReportGroups.Fields[i].AsVariant;
        end;
        DReportGroups2.Post;
       except
        DReportGroups2.Cancel;
        Raise;
       end;
       DReportGroups.Post;
      except
       DReportGroups.Cancel;
       Raise;
      end;
      adatagroups.Next;
     end;
    end;
    havegroup:=adatareports.FindField('REPORT_GROUP')<>nil;
    While Not adatareports.Eof do
    begin
     DReports.Append;
     try
      DReports.FieldByname('REPORT_NAME').Value:=adatareports.FieldByName('REPORT_NAME').Value;
      if havegroup then
       DReports.FieldByName('REPORT_GROUP').AsVariant:=adatareports.FieldByName('REPORT_GROUP').AsVariant;
      DReports.Post;
     except
      DReports.Cancel;
      Raise;
     end;
     adatareports.Next;
    end;
    // Fill the string for each group
    DReportgroups.First;
    while Not DReportGroups.Eof do
    begin
     groupcode:=DReportGroups.FieldByName('GROUP_CODE').AsInteger;
     // If the group have no reports, delete it
     if Not Dreports.FindKey([groupcode]) then
     begin
      DReportGroups.Delete;
     end
     else
     begin
      grouppath:=CalcGroupPath(groupcode);
      while ((DReports.FieldByName('REPORT_GROUP').AsInteger=groupcode) and
       (Not DReports.Eof)) do
      begin
       alist.Add(grouppath+C_DIRSEPARATOR+Dreports.FieldByName('REPORT_NAME').AsString);
       DReports.Next;
      end;

      DReportGroups.Next;
     end;
    end;
   finally
    DReportGroups.free;
    DReportGroups2.free;
    DReports.free;
   end;
//   FillTree(adatagroups,adatareports);
  finally
   if Length(dbinfo.Reportgroupstable)>0 then
    adatagroups.free;
  end;
 finally
  adatareports.free;
 end;
end;
{$ENDIF}


procedure FieldToDataString(afield:TField;var typestring,sizestring:String);
begin
 sizestring:='';
 if afield.size>0 then
  sizestring:=IntToStr(afield.Size);
 case afield.datatype of
  ftString:
   begin
    typestring:=SRpString;
   end;
  ftSmallint:
   begin
    typestring:=SRpSmallInt;
   end;
  ftInteger:
   begin
    typestring:=SRpInteger;
   end;
  ftLargeInt:
   begin
    typestring:=SRpSLargeInteger;
   end;
  ftWord:
   begin
    typestring:=SRpWord;
   end;
  ftBoolean:
   begin
    typestring:=SRpBoolean;
   end;
  ftFloat:
   begin
    typestring:=SRpFloat;
   end;
  ftCurrency:
   begin
    typestring:=SRpCurrency;
   end;
  ftBCD:
   begin
    typestring:=SRpBCD;
   end;
  ftDate:
   begin
    typestring:=SRpDate;
   end;
  ftTime:
   begin
    typestring:=SRpTime;
   end;
  ftDateTime:
   begin
    typestring:=SRpDateTime;
   end;
  ftBytes:
   begin
    typestring:=SRpBytes;
   end;
  ftVarBytes:
   begin
    typestring:=SRpVarBytes;
   end;
  ftAutoInc:
   begin
    typestring:=SRpAutoInc;
   end;
  ftBlob:
   begin
    typestring:=SRpBlob;
   end;
  ftMemo:
   begin
    typestring:=SRpMemo;
   end;
  ftGraphic:
   begin
    typestring:=SRpGraphic;
   end;
  ftFmtMemo:
   begin
    typestring:=SRpFmtmemo;
   end;
  ftParadoxOle:
   begin
    typestring:=SRpParadoxOLE;
   end;
  ftDBaseOLE:
   begin
    typestring:=SRpDBaseOLE;
   end;
  ftTypedBinary:
   begin
    typestring:=SRpTypedBinary;
   end;
  ftCursor:
   begin
    typestring:=SRpCursor;
   end;
  ftFixedChar:
   begin
    typestring:=SRpFixedChar;
   end;
  ftWideString:
   begin
    typestring:=SRpWideString;
   end;
  ftADT:
   begin
    typestring:=SRpADT;
   end;
  ftArray:
   begin
    typestring:=SRpArray;
   end;
  ftReference:
   begin
    typestring:=SRpReference;
   end;
  ftDataset:
   begin
    typestring:=SRpDataset;
   end;
{$IFNDEF BUILDER4}
  ftOraBlob:
   begin
    typestring:=SRpOraBlob;
   end;
  ftOraClob:
   begin
    typestring:=SRpOraClob;
   end;
  ftVariant:
   begin
    typestring:=SRpVariant;
   end;
  ftInterface:
   begin
    typestring:=SRpInterface;
   end;
  ftIDispatch:
   begin
    typestring:=SRpIDispatch;
   end;
  ftGUID:
   begin
    typestring:=SRpGUID;
   end;
{$ENDIF}
{$IFDEF USEVARIANTS}
  ftTimeStamp:
   begin
    typestring:=SRpTimeStamp;
   end;
  ftFmtBCD:
   begin
    typestring:=SRpFmtBCD;
   end;
{$ENDIF}
  else
   begin
    typestring:=SRpUnknown;
    sizestring:='';
   end;
 end;
end;

function ExtractFieldNameEx(astring:String):string;
var
 index:integer;
 newstring:string;
 fieldname:string;
begin
 fieldname:='';
 if Length(astring)<1 then
  exit;
 if astring[1]='[' then
  index:=Pos(']',astring)+1
 else
  index:=Pos(' ',astring);
 if index>0 then
 begin
  fieldname:=Copy(astring,1,index-1);
  newstring:=Copy(astring,index+1,Length(astring));
 end
 else
  fieldname:=astring;
 Result:=fieldname;
end;

procedure FillFieldsInfo(adata:TDataset;fieldnames,fieldtypes,fieldsizes:TStrings);
var
 i:integer;
 afield:TField;
 typestring,sizestring:String;
begin
 adata.GetFieldNames(fieldnames);
 for i:=0 to fieldnames.Count-1 do
 begin
  afield:=adata.FieldByName(fieldnames[i]);
  FieldToDataString(afield,typestring,sizestring);
  fieldtypes.Add(typestring);
  fieldsizes.Add(sizestring);
 end;
end;

function TRpDataInfoList.ItemByName(AName:string):TRpDataInfoItem;
var
 index:Integer;
begin
 index:=IndexOf(AName);
 if index<0 then
  Raise Exception.Create(SRPDabaseAliasNotFound);
 Result:=Items[index];
end;

function TRpDatabaseInfoList.ItemByName(AName:string):TRpDatabaseInfoItem;
var
 index:Integer;
begin
 index:=IndexOf(AName);
 if index<0 then
  Raise Exception.Create(SRPDabaseAliasNotFound);
 Result:=Items[index];
end;

procedure TRpDataLink.DoRecordChange;
begin
 RecordChanged(nil);
end;


procedure TRpDataLink.RecordChanged(Field:TField);
var
 oldopen:Boolean;
 reopen:boolean;
 dtype:TRpDbDriver;
begin
 inherited RecordChanged(Field);

 reopen:=false;
 dtype:=dbinfoitem.driver;
 // See if the parameters are equal
{$IFDEF USEZEOS}
 if dtype=rpdatazeos then
  if Not EqualParamValuesZ(TZReadOnlyQuery(datainfoitem.dataset),DataSource.Dataset) then
   reopen:=true;
{$ENDIF}
{$IFDEF USESQLEXPRESS}
 if dtype=rpdatadbexpress then
 begin
  if datainfoitem.dataset is TSQLQuery then
  begin
   if Not EqualParamValuesS(TSQLQuery(datainfoitem.dataset),DataSource.Dataset) then
    reopen:=true;
  end;
 end;
{$ENDIF}
 if reopen then
 begin
  oldopen:=datainfoitem.dataset.Active;
  datainfoitem.dataset.Active:=false;
{$IFDEF USEZEOS}
  if dtype=rpdatazeos then
   AssignParamValuesZ(TZReadOnlyQuery(datainfoitem.dataset),DataSource.Dataset);
{$ENDIF}
{$IFDEF USESQLEXPRESS}
 if dtype=rpdatadbexpress then
   AssignParamValuesS(TSQLQuery(datainfoitem.dataset),DataSource.Dataset);
{$ENDIF}
  datainfoitem.dataset.Active:=oldopen;
 end;
end;

constructor TRpDataLink.Create;
begin
 inherited Create;


end;

procedure TRpDatabaseInfoItem.DoCommit;
begin
{$IFDEF USESQLEXPRESS}
// if Assigned(FSQLConnection) then
// begin
//  if FSQLCOnnection.InTransaction then
//   FSQLConnection.Commit;
// end;
{$ENDIF}
{$IFDEF USEIBX}
 if Assigned(FIBTransaction) then
 begin
  FIBTransaction.Commit;
 end;
{$ENDIF}
{$IFDEF USEZEOS}
 if Assigned(FZInternalDatabase) then
 begin
  FZInternalDatabase.Commit;
 end;
{$ENDIF}
end;

function EncodeADOPassword(astring:String):String;
var
 index:integer;
 ustring:string;
begin
 Result:=astring;
 ustring:=UpperCase(astring);
 index:=Pos('PASSWORD=',ustring);
 if index=0 then
 begin
  index:=Pos('PASSWORD =',ustring);
  if index>0 then
   index:=index+10;
 end
 else
  index:=index+9;
 if index>0 then
 begin
  while index<=Length(astring) DO
  begin
   if astring[index]=';' then
    break;
   astring[index]:='*';
   inc(index);
  end;
  Result:=astring;
 end;
end;

procedure GetDotNetDrivers(alist:TStrings);
begin
 alist.Clear;
 alist.Add('OleDb');
 alist.Add('Odbc');
 alist.Add('Firebird');
 alist.Add('SQL Server');
 alist.Add('PostgreSQL');
 alist.Add('MySQL');
 alist.Add('SQLite');
 alist.Add('Oracle');
 alist.Add('Ibm Db2');
 alist.Add('Sybase');
 alist.Add('SQL Server CE');
end;

procedure GetDotNet2Drivers(alist:TStrings);
var
 tmpfile:string;
{$IFDEF LINUX}
 aparams:TStringList;
{$ENDIF}
{$IFDEF MSWINDOWS}
 startinfo:TStartupinfo;
 linecount:string;
 FExename,FCommandLine:string;
 procesinfo:TProcessInformation;
{$ENDIF}
begin
 tmpfile:=RpTempFileName;
 try
{$IFDEF LINUX}
  aparams:=TStringList.Create;
  try
     aparams.Add('mono');
     aparams.Add(ExtractFilePath(ParamStr(0))+'net2/printreport.exe');
     aparams.Add('-getproviders');
     aparams.Add(tmpfile);
     ExecuteSystemApp(aparams,true);
  finally
     aparams.free;
  end;
{$ENDIF}
{$IFDEF MSWINDOWS}
     linecount:='';
     with startinfo do
     begin
      cb:=sizeof(startinfo);
      lpReserved:=nil;
      lpDesktop:=nil;
      lpTitle:=PChar('Report manager');
      dwX:=0;
      dwY:=0;
      dwXSize:=400;
      dwYSize:=400;
      dwXCountChars:=80;
      dwYCountChars:=25;
      dwFillAttribute:=FOREGROUND_RED or BACKGROUND_RED or BACKGROUND_GREEN or BACKGROUND_BLUe;
      dwFlags:=STARTF_USECOUNTCHARS or STARTF_USESHOWWINDOW;
      cbReserved2:=0;
      lpreserved2:=nil;
     end;

     FExename:=ExtractFilePath(ParamStr(0))+'net2\printreport.exe';
     FCommandLine:=' -getproviders  "'+tmpfile+'"';
     if Not CreateProcess(Pchar(FExename),Pchar(Fcommandline),nil,nil,True,NORMAL_PRIORITY_CLASS or CREATE_NEW_PROCESS_GROUP,nil,nil,
      startinfo,procesinfo) then
      RaiseLastOSError;
     WaitForSingleObject(procesinfo.hProcess,60000);
{$ENDIF}
     alist.LoadFromFile(tmpfile);
    finally
     SysUtils.DeleteFile(tmpfile);
    end;
end;




end.



