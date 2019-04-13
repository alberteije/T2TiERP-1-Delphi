{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       urepserver                                      }
{                                                       }
{       Report Manager Net Server implementation        }
{       Routines and main interface to implement        }
{       the Report Manager Server                       }
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

unit urepserver;


interface

{$I rpconf.inc}

uses
  SysUtils, Classes, JclStringLists,
  IdBaseComponent, IdComponent,rpmdconsts,SyncObjs,
  IdTCPServer,
{$IFNDEF USEVARIANTS}
  FileCtrl,
{$ENDIF}
  IdResourceStrings,
{$IFDEF USEBDE}
  dbtables,
{$ENDIF}
{$IFDEF USEADO}
  ActiveX,
{$ENDIF}
{$IFDEF MSWINDOWS}
  Windows,Forms,
{$ENDIF}
{$IFDEF LINUX}
 Libc,
{$ENDIF}
{$IFDEF INDY10}
 IdThread,IdThreadComponent,IdContext,IdStack,IdTCPConnection,IdCustomTCPServer,
 IdGlobal,
{$ENDIF}
{$IFNDEF INDY10}
 IdThreadMgr, IdThreadMgrDefault,IdThreadMgrPool,IdTCPConnection,
{$ENDIF}
  rptranslator,rpmdshfolder,IniFiles,rpmdprotocol,rpalias,dbclient,
  rpreport,rpbasereport,rppdfdriver, rptypes,rpparams, rpdatainfo, Db;

const
 DEFAULT_MILIS_PROGRESS=10000;

type
  TRpClient=class(TObject)  // Object holding data of client (see events)
    DNS: String;
    ConnectionDate,                           { Time of connect }
    LastAction  : TDateTime;             { Time of last transaction }
{$IFDEF INDY10}
    Thread      : TIdContext;               { Pointer to context }
{$ENDIF}
{$IFNDEF INDY10}
    Thread      : TIdPeerThread;               { Pointer to thread }
{$ENDIF}
    Auth:boolean;
    IsAdmin:boolean;
    Username:string;
    Password:string;
    CurrentAlias:String;
    CurrentPath:String;
    CurrentReport:TRpReport;
    FromPage,ToPage:integer;
    Copies:integer;
    CompressedPDF:boolean;
    cancelled:boolean;
{$IFDEF USEBDE}
    ASession:TSession;
    SessionNumber:integer;
{$ENDIF}
    FRpAliasLibs:TRpAlias;
    procedure DoInit(fconfig:string);
    procedure OnProgress(Sender:TRpBaseReport;var docancel:boolean);
    procedure CreateReport;
  public
    constructor Create;
    destructor Destroy;override;
    property RpAliasLibs:TRpAlias read  FRpAliasLibs;
  end;


  Tmodserver = class(TDataModule)
    adata: TClientDataSet;
    adataID: TIntegerField;
    adataLASTOPERATION: TDateTimeField;
    adataCONNECTIONDATE: TDateTimeField;
    adataUSERNAME: TStringField;
    adataRUNNING: TBooleanField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    // Data for all clients
{$IFNDEF INDY10}
    ThreadMan: TIdThreadMgrPool;
{$ENDIF}
    Clients:TThreadList;
    FInitEvent:TEvent;
    EventName:String;
    FHostName:String;
    LAliases,LUsers,LGroups,LUserGroups,LAliasGroups:TStringList;
    FOnlog:TRpLogMessageEvent;
    FLogFilename:TFilename;
    FLogFile:TFileStream;
    FFileNameConfig:String;
    fport:integer;
{$IFNDEF INDY10}
    procedure RepServerExecute(AThread: TIdPeerThread);
    procedure RepServerConnect(AThread: TIdPeerThread);
    procedure RepServerDisconnect(AThread: TIdPeerThread);
{$ENDIF}
{$IFDEF INDY10}
    procedure RepServerExecute(AContext: TIdContext);
    procedure RepServerConnect(AContext: TIdContext);
    procedure RepServerDisconnect(AContext: TIdContext);
{$ENDIF}
    procedure ClearLists;
    procedure WriteLog(aMessage:WideString);
    procedure GetIsSMP;
    procedure LoadReport(alist:TStringList;ActClient:TRpClient);
    function CheckPrivileges(username,aliasname:String):boolean;
    procedure DoFillTreeDir(apath:String;alist:TStringList;actclient:TRpClient);
  public
    smp:Boolean;
    disablesmp:Boolean;
    RepServer:TIdTcpServer;
    procedure InitConfig;
    procedure WriteConfig;
    property LogFileName:TFileName read FLogFileName;
    property FileNameConfig:String read FFilenameconfig;
    { Public declarations }
    property HostName:String read FHostName;
  end;

function StartServer(OnLog:TRpLogMessageEvent):TModServer;
procedure StopServer(modserver:TModServer);
procedure SMPExecuteReport(report:TRpReport;astream:TMemoryStream;metafile:Boolean);


implementation

{$R *.dfm}

procedure TRpClient.CreateReport;
begin
{$IFDEF USEADO}
 CoInitialize(nil);
{$ENDIF}
 if Assigned(CurrentReport) then
 begin
  try
   CurrentReport.free;
  finally
   CurrentReport:=nil;
  end;
 end;
 CurrentReport:=TRpReport.Create(nil);
 CurrentReport.OnProgress:=OnProgress;
 CurrentReport.MilisProgres:=DEFAULT_MILIS_PROGRESS;
{$IFDEF USEBDE}
 if Assigned(ASession) then
  CurrentReport.DatabaseInfo.BDESession:=ASession;
{$ENDIF}
end;


destructor TRpClient.Destroy;
begin
 FRpAliasLibs.free;
 if Assigned(CurrentReport) then
 begin
  CurrentReport.Free;
  CurrentReport:=nil;
 end;
{$IFDEF USEBDE}
 if Assigned(ASession) then
 begin
  try
   if ASession.Active then
   begin
    ASession.Close;
   end;
  except
  end;
 end;
{$ENDIF}

 inherited Destroy;
end;

procedure TRpClient.OnProgress(Sender:TRpBaseReport;var docancel:boolean);
var
 astring:WideString;
 CB:TRpComBLock;
begin
 // Sends the message progress to the thread
 astring:=IntToStr(Sender.CurrentSubReportIndex)+' '+SRpPage+':'+
 FormatFloat('####,####',Currentreport.PageNum)+':'
 +FormatFloat('####,####',Currentreport.RecordCount);
 CB:=GenerateCBLogMessage(astring);
 try
  SendBlock(Thread.Connection,CB);
 finally
  FreeBlock(CB);
 end;
 docancel:=cancelled;
end;

function StartServer(onlog:TRpLogMessageEvent):TModServer;
var
 amod:TModServer;
{$IFDEF MSWINDOWS}
 wresult:TWaitResult;
{$ENDIF}
begin
 amod:=TModServer.Create(nil);
 try
  // Look for any other server running in this server
  // Check if the server is running
{$IFDEF MSWINDOWS}
  wresult:=amod.FInitEvent.WaitFor(100);
  if wresult<>wrSignaled then
   Raise Exception.Create(SRpServerAlreadyRunning);
{$ENDIF}
  amod.InitConfig;
  amod.RepServer.DefaultPort:=amod.fport;
  amod.RepServer.Active:=True;
  amod.FOnLog:=OnLog;
{$IFDEF INDY10}
  amod.FHostname:=GStack.HostName;
{$ENDIF}
{$IFNDEF INDY10}
  amod.FHostname:=amod.RepServer.LocalName;
{$ENDIF}
  amod.WriteLog(SRpServerStarted);
  if amod.smp then
   amod.WriteLog('SMP Server');
 except
  amod.free;
  raise;
 end;
 Result:=amod;
end;

procedure StopServer(modserver:TModServer);
begin
 if modserver.RepServer.Active then
 begin
  modserver.RepServer.Active:=false;
  // Releases the event
  modserver.WriteLog(SRpServerStoped);
  modserver.FInitEvent.SetEvent;
 end;
 modserver.Free;
end;


procedure Tmodserver.WriteLog(aMessage:WideString);
var
 messa:WideString;
 ansimessa:String;
begin
 messa:=FormatDateTime('dd/mm/yyyy hh:nn:ss - ',Now)+aMessage;
 if Assigned(FOnlog) then
  FOnLog(Self,messa);
 if Assigned(FLogFile) then
 begin
  ansimessa:=messa;
  ansimessa:=ansimessa+#10;
  FLogFile.Write(ansimessa[1],Length(ansimessa));
 end;
end;


procedure Tmodserver.GetIsSMP;
{$IFDEF MSWINDOWS}
var
 sysinfo:SYSTEM_INFO;
begin
 smp:=false;
 if disablesmp then
  exit;
 GetSystemInfo(sysinfo);
 if sysinfo.dwNumberOfProcessors>1 then
  smp:=true;
end;
{$ENDIF}
{$IFDEF LINUX}
var
 alist:TStringList;
 proccount:integer;
 i:integer;
begin
 smp:=false;
 if disablesmp then
  exit;
 proccount:=1;
 alist:=TStringList.Create;
 try
  ReadFileLines('/proc/cpuinfo',alist);
  for i:=0 to alist.Count-1 do
  begin
   if UpperCase(Copy(alist.Strings[i],1,9))='PROCESSOR' then
    inc(proccount);
  end;
 finally
  alist.free;
 end;
 smp:=proccount>=2;
end;
{$ENDIF}

procedure Tmodserver.DataModuleCreate(Sender: TObject);
begin
 RepServer:=TIdTCPServer.Create(Self);
 RepServer.DefaultPort:=3060;
 RepServer.OnDisconnect:=RepServerDisconnect;
 RepServer.OnConnect:=RepServerConnect;
 RepServer.OnExecute:=RepServerExecute;
 disablesmp:=false;
{$IFNDEF INDY10}
 ThreadMan:=TIdThreadMgrPool.Create(Self);
 ThreadMan.PoolSize:=10;
 RepServer.ThreadMgr:=ThreadMan;
{$ENDIF}
 fport:=3060;
 Clients:=TTHreadList.Create;
 LAliases:=TStringList.Create;
 LUsers:=TStringList.Create;
 LGroups:=TStringList.Create;
 LUserGroups:=TStringList.Create;
 LAliasGroups:=TStringList.Create;
 // Creates the event
 eventname:='REPORTMANRUNNINGEVENT';
 FInitEvent:=TEvent.Create(nil,false,true,eventname);
 // Gets the log file and try to create it
 FLogFilename:=Obtainininamecommonconfig('','','reportmanlog');
 try
  if Not (FileExists(FLogFileName)) then
   FLogFile:=TFileStream.Create(FLogFilename,fmOpenReadWrite or fmCreate)
  else
   FLogFile:=TFileStream.Create(FLogFilename,fmOpenReadWrite or fmShareDenyWrite);
 except
  // If fails try with local filename
  FLogFilename:=Obtainininamelocalconfig('','','reportmanlog');
  if Not (FileExists(FLogFileName)) then
   FLogFile:=TFileStream.Create(FLogFilename,fmOpenReadWrite or fmCreate)
  else
   FLogFile:=TFileStream.Create(FLogFilename,fmOpenReadWrite or fmShareDenyWrite);
 end;
 FLogFile.Free;
 FLogFile:=nil;
 FLogFile:=TFileStream.Create(FLogFilename,fmOpenReadWrite or fmShareDenyWrite);
 FLogFile.Seek(0,soFromEnd);
end;

procedure TmodServer.ClearLists;
var
 i:integer;
begin
 laliases.clear;
 lusers.clear;
 lgroups.Clear;
 for i:=0 to LUserGroups.Count-1 do
 begin
  TStringList(LUserGroups.Objects[i]).free;
 end;
 LUserGroups.Clear;
 for i:=0 to LAliasGroups.Count-1 do
 begin
  TStringList(LAliasGroups.Objects[i]).Free;
 end;
 LAliasGroups.Clear;
end;

// Read users and passwords
// Also read directories and aliases
procedure TmodServer.InitConfig;
var
 inif:TMemInifile;
 i:integer;
 alist:TStringList;
begin
 Ffilenameconfig:=Obtainininamecommonconfig('','','reportmanserver');
 inif:=TMemInifile.Create(ffilenameconfig);
 try
  try
   inif.UpdateFile;
  except
   // If the file can't be updated, it's because
   // readonly privileges
  end;
 finally
  inif.free;
 end;
 if Not FileExists(FFilenameConfig) then
  Ffilenameconfig:=Obtainininamelocalconfig('','','reportmanserver');
 ForceDirectories(ExtractFilePath(ffilenameconfig));
 inif:=TMemInifile.Create(filenameconfig);
 try
  ClearLists;
{$IFDEF USEVARIANTS}
  inif.CaseSensitive:=false;
{$ENDIF}
  fport:=inif.ReadInteger('CONFIG','TCPPORT',3060);
  disablesmp:=inif.ReadBool('CONFIG','DISABLESMP',false);
  inif.ReadSectionValues('USERS',lusers);
  inif.ReadSectionValues('GROUPS',lgroups);
  inif.ReadSectionValues('ALIASES',laliases);
  i:=0;
  while i<lusers.count do
  begin
   if Length(Trim(lusers.strings[i]))<1 then
    LUsers.delete(i)
   else
    inc(i);
  end;
  i:=0;
  while i<lgroups.count do
  begin
   if Length(Trim(lgroups.strings[i]))<1 then
    LGroups.delete(i)
   else
    inc(i);
  end;
  i:=0;
  while i<laliases.count do
  begin
   if Length(Trim(laliases.strings[i]))<1 then
    laliases.delete(i)
   else
    inc(i);
  end;
  for i:=0 to lusers.count-1 do
  begin
   if Length(lusers.Names[i])<1 then
    lusers.Strings[i]:=lusers.Strings[i]+'=';
  end;
  for i:=0 to laliases.count-1 do
  begin
   if Length(laliases.Names[i])<1 then
    laliases.Strings[i]:=laliases.Strings[i]+'=';
  end;
  if lusers.IndexOfName('ADMIN')<0 then
   lusers.Add('ADMIN=');
  // Read privilege lists
  for i:=0 to lusers.Count-1 do
  begin
   if lusers.Names[i]<>'ADMIN' then
   begin
    alist:=TStringList.Create;
    LUserGroups.AddObject(lusers.Names[i],alist);
    inif.ReadSectionValues('USERGROUPS'+lusers.Names[i],alist);
   end;
  end;
  for i:=0 to LAliases.Count-1 do
  begin
   alist:=TStringList.Create;
   LAliasGroups.AddObject(LAliases.Names[i],alist);
   inif.ReadSectionValues('GROUPALLOW'+LAliases.Names[i],alist);
  end;
 finally
  inif.free;
 end;
 GetIsSMP;
 // Read library configuration
end;

// Write users and passwords and aliases
procedure TmodServer.WriteConfig;
var
 inif:TMemInifile;
 i,j:integer;
 adups:TStringList;
 alist:TStringList;
begin
 Ffilenameconfig:=Obtainininamecommonconfig('','','reportmanserver');
 if Not FileExists(FFilenameConfig) then
  Ffilenameconfig:=Obtainininamelocalconfig('','','reportmanserver');
 ForceDirectories(ExtractFilePath(ffilenameconfig));
 inif:=TMemInifile.Create(filenameconfig);
 try
  inif.WriteInteger('CONFIG','TCPPORT',fport);
  adups:=TStringList.Create;
  try
   if lusers.IndexOfName('ADMIN')<0 then
    lusers.Add('ADMIN=');
   inif.EraseSection('USERS');
   adups.clear;
   for i:=0 to lusers.Count-1 do
   begin
    if Length(lusers.Names[i])>0 then
    begin
     if adups.Indexof(lusers.Names[i])<0 then
     begin
      adups.Add(lusers.Names[i]);
      inif.WriteString('USERS',lusers.Names[i],lusers.Values[lusers.Names[i]]);
     end;
    end;
   end;
   inif.EraseSection('GROUPS');
   for i:=0 to lgroups.Count-1 do
   begin
    if Length(lgroups.Strings[i])>0 then
    begin
     inif.WriteString('GROUPS',lgroups.Strings[i],lgroups.Values[lgroups.Strings[i]]);
    end;
   end;
   inif.EraseSection('ALIASES');
   adups.clear;
   for i:=0 to laliases.Count-1 do
   begin
    if Length(laliases.Names[i])>0 then
    begin
     if adups.Indexof(laliases.Names[i])<0 then
     begin
      adups.Add(laliases.Names[i]);
      inif.WriteString('ALIASES',laliases.Names[i],laliases.Values[laliases.Names[i]]);
     end;
    end;
   end;
   // Write privilege lists
   for i:=0 to luserGroups.Count-1 do
   begin
    if lusergroups.Strings[i]<>'ADMIN' then
    begin
     alist:=TStringList(LUserGroups.Objects[i]);
     for j:=0 to LGroups.Count-1 do
     begin
      inif.DeleteKey('USERGROUPS'+LUserGRoups.Strings[i],LGroups.Names[j]);
     end;
     for j:=0 to alist.Count-1 do
     begin
      inif.WriteString('USERGROUPS'+luserGroups.Strings[i],alist.Names[j],
        alist.Names[j]);
     end;
    end;
   end;
   for i:=0 to LAliasGroups.Count-1 do
   begin
    alist:=TStringList(LAliasGroups.Objects[i]);
    for j:=0 to LGroups.Count-1 do
    begin
     inif.DeleteKey('GROUPALLOW'+LAliasGRoups.Strings[i],LGroups.Names[j]);
    end;
    for j:=0 to alist.Count-1 do
    begin
     inif.WriteString('GROUPALLOW'+LAliasGRoups.Strings[i],alist.Names[j],
       alist.Names[j]);
    end;
   end;
   inif.UpdateFile;
  finally
   adups.free;
  end;
 finally
  inif.free;
 end;
end;


procedure Tmodserver.DataModuleDestroy(Sender: TObject);
begin
 ClearLists;
 Clients.Free;
 LAliases.free;
 LUsers.free;
 LGroups.free;
 FInitEvent.Free;
 if assigned(FLogFile) then
 begin
  FLogFile.Free;
  FLogFile:=nil;
 end;
end;

function TModServer.CheckPrivileges(username,aliasname:String):Boolean;
var
 i,index:integer;
 lugroups:TStringList;
 lagroups:TStringList;
begin
 Result:=true;
 if username='ADMIN' then
  exit;
 index:=LUserGroups.IndexOf(username);
 if index<0 then
  Raise Exception.Create(SRpAuthFailed+' - '+username);
 lugroups:=TStringList(LUserGroups.Objects[index]);
 index:=LAliasGroups.IndexOf(aliasname);
 if index<0 then
  Raise Exception.Create(SRpAuthFailed+' - '+aliasname);
 lagroups:=TStringList(LAliasGroups.Objects[index]);
 if ((lagroups.Count>0) and (lugroups.Count>0)) then
 begin
  Result:=false;
  for i:=0 to lugroups.Count-1 do
  begin
   if lagroups.IndexOfName(lugroups.Names[i])>=0 then
   begin
    Result:=true;
    break;
   end;
  end;
 end;
end;

procedure TModServer.DoFillTreeDir(apath:String;alist:TStringList;actclient:TRpClient);
begin
 if Length(apath)<1 then
  Raise Exception.Create(SRpAuthFailed);
 alist.clear;
 if apath[1]=':' then
  actclient.RpAliasLibs.Connections.FillTreeDir(Copy(apath,2,Length(apath)),alist)
 else
  rptypes.FillTreeDir(apath,alist);
end;

{
  Modificado por Albert Eije em 12/10/2012
  - Adicionada a variável ConsultaSQL para receber a consulta enviada pela aplicação cliente
  - A região DADOS do relatório receberá a consulta SQL enviada pela aplicação cliente
}
procedure TModserver.LoadReport(alist:TStringList;ActClient:TRpClient);
var
 aliasname,apath,username:String;
 index:integer;
 astream:TStream;
 reportname:String;
 //Modificado por Albert Eije em 12/10/2012
 ConsultaSQL: String;
 //Implementação temporária para o C#
 ConteudoCliente, Arquivo: String;
 ConteudoClienteCSharp: TJclStringList;
begin
   //Modificado por Albert Eije em 12/10/2012
   if alist.count > 1 then
     ConsultaSQL := alist[1];
   //
   //Implementação temporária para o C#
   Arquivo := '';
   if alist.count = 1 then
   begin
     ConteudoClienteCSharp := TJclStringList.Create;
     if pos('|', alist[0]) > 0 then
     begin
       ConteudoClienteCSharp.Clear;
       ConteudoCliente := Copy(alist[0], pos('|', alist[0]) + 1, Length(alist[0]));
       ConteudoClienteCSharp.Split(ConteudoCliente, '|', true);
       Arquivo := Copy(alist[0], 1, pos('|', alist[0]) - 1);
       Arquivo := Copy(Arquivo, pos('=', alist[0]) + 1, Length(alist[0]));
       ConsultaSQL := ConteudoClienteCSharp[0];
     end;
   end;
   //
   if alist.count<=0 then
   begin
    if Assigned(ActClient.CurrentReport) then
     exit
    else
     Raise Exception.Create(SRPAliasNotExists);
   end;
   aliasname:=alist.Names[0];
   index:=LAliases.IndexOfName(aliasname);
   if index<0 then
    Raise Exception.Create(SRPAliasNotExists+' - '+aliasname);
   // Check for privileges
   username:=ActClient.Username;
   if Not CheckPrivileges(username,aliasname) then
    Raise Exception.Create(SRpAuthFailed+' - '+username+' - '+aliasname);
   apath:=LAliases.Values[LAliases.Names[index]];
   if Length(apath)<1 then
    Raise Exception.Create(SRPEmptyAliasPath+' - '+aliasname);
   if apath[1]<>':' then
   begin
    ActClient.CreateReport;
    if Arquivo = '' then
      ActClient.CurrentReport.LoadFromFile(apath+C_DIRSEPARATOR+alist.Values[alist.Names[0]])
    else
      ActClient.CurrentReport.LoadFromFile(apath+C_DIRSEPARATOR+Arquivo);
    //Modificado por Albert Eije em 12/10/2012
    if ConsultaSQL <> '' then
      ActClient.CurrentReport.DataInfo.ItemByName('DADOS').SQL := ConsultaSQL;

    if Assigned(ConteudoClienteCSharp) then
    begin
      if ConteudoClienteCSharp.Count > 0 then
      begin
        ActClient.CurrentReport.Params.ParamByName('TITULORELATORIO').Value := ConteudoClienteCSharp[1];
        ActClient.CurrentReport.Params.ParamByName('TITULOSOFTHOUSE').Value := ConteudoClienteCSharp[2];
        ActClient.CurrentReport.Params.ParamByName('TITULORODAPE').Value := ConteudoClienteCSharp[3];
      end;
    end;

   end
   else
   begin
    ActClient.CreateReport;
    reportname:=alist.Values[alist.Names[0]];
    reportname:=ChangeFileExt(reportname,'');
    reportname:=ExtractFilename(reportname);
    astream:=ActClient.RpAliasLibs.Connections.GetReportStream(Copy(apath,2,Length(apath)),reportname,nil);
    try
     ActClient.CurrentReport.LoadFromStream(astream);
    finally
     astream.free;
    end;
   end;
end;

{$IFNDEF INDY10}
procedure Tmodserver.RepServerExecute(AThread: TIdPeerThread);
{$ENDIF}
{$IFDEF INDY10}
procedure Tmodserver.RepServerExecute(AContext: TIdContext);
{$ENDIF}
var
 CB,ACB:TRpComBlock;
 astream:TMemoryStream;
 templist,alist:TStringList;
 username,groupname,password:string;
 aliasname,apath:string;
 ConsultaSQL:String;
 taskid:integer;
 correct:boolean;
 aplist:Tlist;
 index:integer;
 ActClient:TRpClient;
 i:integer;
 APDFDriver:TRpPDFDriver;
 acompo:TRpParamComp;
 writer:TWriter;
 connection:TIdTCPConnection;
 found:boolean;
 reader:TReader;
begin
 // Execution of commands
{$IFDEF INDY10}
 connection:=AContext.Connection;
 if ((not connection.IOHandler.Connected)) then
  exit;
{$ENDIF}
{$IFNDEF INDY10}
 connection:=AThread.Connection;
 if (AThread.Terminated) or (Not AThread.Connection.Connected) then
  exit;
{$ENDIF}
 try
  astream:=TMemoryStream.Create;
  try
{$IFDEF INDY10}
   AContext.Connection.IOHandler.ReadStream(astream);
{$ENDIF}
{$IFNDEF INDY10}
   AThread.Connection.ReadStream(astream);
{$ENDIF}
   ACB:=ReadRpComBlockFromStream(astream);
   try
    astream.Seek(0,soFromBeginning);
    ACB.Data.Seek(0,soFromBeginning);
    astream.SetSize(ACB.Data.Size);
    astream.CopyFrom(ACB.Data,ACB.Data.Size);
    astream.Seek(0,soFromBeginning);
{$IFDEF INDY10}
    ActClient := TRpClient(AContext.Data);
{$ENDIF}
{$IFNDEF INDY10}
    ActClient := TRpClient(AThread.Data);
{$ENDIF}
    ActClient.LastAction := Now;  // update the time of last action
    // if is a auth message return the key
    case ACB.Command of

     repauth:
      begin
       username:='';
       password:='';
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>0 then
        begin
         username:=Uppercase(Alist.Names[0]);
         password:=Alist.Values[Alist.Names[0]];
        end;
       finally
        alist.free;
       end;
       // Looks if the user exists
       correct:=false;
       if length(username)>0 then
       begin
        index:=LUsers.IndexOfName(username);
        if index>=0 then
        begin
         If LUsers.Values[LUsers.Names[index]]=password then
         begin
          correct:=true;
         end;
        end;
       end;
       if correct then
       begin
        ActClient.UserName:=username;
        ActClient.Password:=password;
        ActClient.Auth:=True;
        // Admin can administer aliases-users
        ActClient.IsAdmin:=UpperCase(username)='ADMIN';
        // Sends the authorization message with the dirseparator
        alist:=TStringList.Create;
        try
         alist.Assign(LAliases);
         alist.insert(0,C_DIRSEPARATOR);
         CB:=GenerateBlock(repauth,alist);
         try
          SendBlock(connection,CB);
         finally
          FreeBlock(CB);
         end;
        finally
         alist.free;
        end;
       end
       else
        Raise Exception.Create(SRpAuthFailed);
      end;

     repgetusers:
      begin
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        for i:=0 to LUsers.Count-1 do
         alist.Add(LUsers.Names[i]);
        CB:=GenerateBlock(repgetusers,alist);
        try
         SendBlock(cOnnection,CB);
        finally
         FreeBlock(CB);
        end;
       finally
        alist.free;
       end;
      end;

     repgetgroups:
      begin
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        for i:=0 to LGroups.Count-1 do
         alist.Add(LGroups.Names[i]);
        CB:=GenerateBlock(repgetgroups,alist);
        try
         SendBlock(COnnection,CB);
        finally
         FreeBlock(CB);
        end;
       finally
        alist.free;
       end;
      end;

     repgetaliases:
      begin
       if Not ActClient.Auth then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        for i:=0 to LAliases.Count-1 do
        begin
         if CheckPrivileges(ActClient.username,LAliases.Names[i]) then
          alist.Add(LAliases.Strings[i]);
        end;
        CB:=GenerateBlock(repgetaliases,alist);
        try
         SendBlock(COnnection,CB);
        finally
         FreeBlock(CB);
        end;
       finally
        alist.free;
       end;
      end;

     repaddalias:
      begin
       // Add a alias (only admin)
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);

       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>0 then
        begin
         aliasname:=UpperCase(AList.Names[0]);
         apath:=Alist.Values[aliasname];
         if LAliases.IndexOfName(aliasname)<0 then
         begin
          if length(apath)>0 then
          begin
           LAliases.Add(aliasname+'='+apath);
           WriteConfig;
           InitConfig;
          end;
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repdeletealias:
      begin
       // Add a alias (only admin)
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>0 then
        begin
         aliasname:=UpperCase(AList.Names[0]);
         index:=LAliases.IndexOfName(aliasname);
         if index>=0 then
         begin
          LAliases.Delete(index);
          WriteConfig;
          InitConfig;
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repadduser:
      begin
       // Add a user (only admin)
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>0 then
        begin
         username:=Trim(UpperCase(AList.Names[0]));
         password:=Alist.Values[username];
         index:=LUsers.IndexOfName(username);
         if index>=0 then
          LUsers.Delete(index);
         LUsers.Add(username+'='+password);
         WriteConfig;
         InitConfig;
        end;
       finally
        alist.free;
       end;
      end;

     repdeleteuser:
      begin
       // delete user (only admin)
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>0 then
        begin
         username:=Trim(Uppercase(AList.Names[0]));
         if username<>'ADMIN' then
         begin
          index:=LUsers.IndexOfName(username);
          if index>=0 then
          begin
           LUsers.Delete(index);
           WriteConfig;
           InitConfig;
           // Break user connections?
           //Clients.LockList;
          end;
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repaddgroup:
      begin
       // Add a group (only admin)
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>0 then
        begin
         groupname:=Trim(UpperCase(AList.Strings[0]));
         index:=LGroups.IndexOfName(groupname);
         if index>=0 then
          LGroups.Delete(index);
         LGroups.Add(groupname);
         WriteConfig;
         InitConfig;
        end;
       finally
        alist.free;
       end;
      end;

     repdeletegroup:
      begin
       // delete group (only admin)
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>0 then
        begin
         groupname:=Trim(Uppercase(AList.Strings[0]));
         index:=LGroups.IndexOfName(groupname);
         if index>=0 then
         begin
          LGroups.Delete(index);
          WriteConfig;
          InitConfig;
          // Break user connections?
          //Clients.LockList;
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repgetusergroups:
      begin
       // Return groups access for a user
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>0 then
        begin
         username:=Trim(Uppercase(AList.Strings[0]));
         if username<>'ADMIN' then
         begin
          index:=LUserGroups.IndexOf(username);
          if index>=0 then
          begin
           CB:=GenerateBlock(repgetusergroups,TStringList(LUserGroups.Objects[index]));
           try
            SendBlock(COnnection,CB);
           finally
            FreeBlock(CB);
           end;
          end;
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repuserdeletegroup:
      begin
       // Delete a group from user access list
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>1 then
        begin
         username:=Trim(UpperCase(AList.Strings[0]));
         if username<>'ADMIN' then
         begin
          index:=LUsers.IndexOfName(username);
          if index>=0 then
          begin
           groupname:=Trim(UpperCase(AList.Strings[1]));
           index:=LUserGroups.IndexOf(username);
           if index>=0 then
           begin
            templist:=TStringList(LUserGroups.Objects[index]);
            index:=templist.IndexOfName(groupname);
            if index>=0 then
            begin
             templist.Delete(index);
             WriteConfig;
             InitConfig;
            end;
           end;
          end;
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repuseraddgroup:
      begin
       // Add a group inside a user access list
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>1 then
        begin
         username:=Trim(UpperCase(AList.Strings[0]));
         if username<>'ADMIN' then
         begin
          index:=LUsers.IndexOfName(username);
          if index>=0 then
          begin
           groupname:=Trim(UpperCase(AList.Strings[1]));
           index:=LGroups.IndexOfName(groupname);
           if index>=0 then
           begin
            index:=LUserGroups.IndexOf(username);
            if index>=0 then
            begin
             if 0>TStringList(LUserGroups.Objects[Index]).IndexOfName(groupname) then
             begin
              TStringList(LUserGroups.Objects[Index]).Add(groupname+'='+groupname);
              WriteConfig;
              InitConfig;
             end;
            end;
           end;
          end;
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repgetconnections:
      begin
       // Return connections information
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       adata.Close;
       adata.CreateDataSet;
       try
{$IFDEF INDY10}
        aplist:=RepServer.Contexts.LockList;
{$ENDIF}
{$IFNDEF INDY10}
        aplist:=RepServer.Threads.LockList;
{$ENDIF}
        try
         for i:=0 to aplist.Count-1 do
         begin
{$IFDEF INDY10}
          actclient:=TRpClient(TIdContext(aplist.Items[i]).Data);
{$ENDIF}
{$IFNDEF INDY10}
          actclient:=TRpClient(TIdPeerThread(aplist.Items[i]).Data);
{$ENDIF}
          adata.Append;
          try
{$IFDEF INDY10}
           adataID.Value:=Integer(TIdContext(aplist.Items[i]));
{$ENDIF}
{$IFNDEF INDY10}
           adataID.Value:=TIdPeerThread(aplist.Items[i]).ThreadID;
{$ENDIF}
           adataLASTOPERATION.Value:=actclient.LastAction;
           adataCONNECTIONDATE.Value:=actclient.ConnectionDate;
           adataUSERNAME.Value:=actclient.username;
{$IFDEF INDY10}
           adataRUNNING.Value:=true;
{$ENDIF}
{$IFNDEF INDY10}
           adataRUNNING.Value:=Not TIdPeerThread(aplist.Items[i]).Suspended;
{$ENDIF}
           adata.Post;
          except
           adata.Cancel;
           raise;
          end;
         end;
        finally
{$IFDEF INDY10}
         RepServer.Contexts.UnlockList;
{$ENDIF}
{$IFNDEF INDY10}
         RepServer.Threads.UnlockList;
{$ENDIF}
        end;
        astream.Clear;
        adata.SaveToStream(astream,dfBinary);
        astream.Seek(0,soFromBeginning);
        CB:=GenerateBlock(repgetconnections,astream);
        try
         SendBlock(COnnection,CB);
        finally
         FreeBlock(CB);
        end;
       finally
        adata.Close;
       end;
      end;

     repdeleteconnection:
      begin
       // Delete a group from alias access list
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>0 then
        begin
         taskid:=StrToInt(alist.Strings[0]);
         i:=0;
{$IFDEF INDY10}
         aplist:=RepServer.Contexts.LockList;
{$ENDIF}
{$IFNDEF INDY10}
         aplist:=RepServer.Threads.LockList;
{$ENDIF}
         try
          while i<aplist.Count do
          begin
{$IFDEF INDY10}
           if Integer(TIdContext(aplist.Items[i]))=taskid then
           begin
            TIdContext(aplist.Items[i]).Free;
{$ENDIF}
{$IFNDEF INDY10}
           if Integer(TIdPeerThread(aplist.Items[i]).ThreadID)=taskid then
           begin
            TIdPeerThread(aplist.Items[i]).Terminate;
{$ENDIF}
            aplist.Remove(aplist.Items[i]);
            break;
           end;
           inc(i);
          end;
         finally
{$IFDEF INDY10}
         RepServer.Contexts.UnlockList;
{$ENDIF}
{$IFNDEF INDY10}
         RepServer.Threads.UnlockList;
{$ENDIF}
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repgetaliasgroups:
      begin
       // Return alias access for a user
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>0 then
        begin
         aliasname:=Trim(Uppercase(AList.Strings[0]));
         index:=LAliasGroups.IndexOf(aliasname);
         if index>=0 then
         begin
          CB:=GenerateBlock(repgetaliasgroups,TStringList(LAliasGroups.Objects[index]));
          try
           SendBlock(COnnection,CB);
          finally
           FreeBlock(CB);
          end;
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repaliasdeletegroup:
      begin
       // Delete a group from alias access list
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>1 then
        begin
         aliasname:=Trim(UpperCase(AList.Strings[0]));
         groupname:=Trim(UpperCase(AList.Strings[1]));
         index:=LAliasGroups.IndexOf(aliasname);
         if index>=0 then
         begin
          templist:=TStringList(LAliasGroups.Objects[index]);
          index:=templist.IndexOfName(groupname);
          if index>=0 then
          begin
           templist.Delete(index);
           WriteConfig;
           InitConfig;
          end;
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repaliasaddgroup:
      begin
       // Add a group inside a alias
       if Not ActClient.IsAdmin then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        if alist.count>1 then
        begin
         aliasname:=Trim(UpperCase(AList.Strings[0]));
         groupname:=Trim(UpperCase(AList.Strings[1]));
         index:=LGroups.IndexOfName(groupname);
         if index>=0 then
         begin
          index:=LAliasGroups.IndexOf(aliasname);
          if index>=0 then
          begin
           if 0>TStringList(LAliasGroups.Objects[Index]).IndexOfName(groupname) then            begin
            TStringList(LAliasGroups.Objects[Index]).Add(groupname+'='+groupname);
            WriteConfig;
            InitConfig;
           end;
          end;
         end;
        end;
       finally
        alist.free;
       end;
      end;

     repopenreport:
      begin
       if Not ActClient.Auth then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        LoadReport(alist,ActClient);
        CB:=GenerateBlock(repopenreport,alist);
        try
         SendBlock(COnnection,CB);
        finally
         FreeBlock(CB);
        end;
       finally
        alist.Free;
       end;
      end;

     repgetparams:
      begin
       if Not Assigned(ActClient.CurrentReport) then
        Raise Exception.Create(SRpNoFilename);
       astream.clear;
       acompo:=TRpParamcomp.Create(nil);
       try
        ActClient.CurrentReport.Params.UpdateLookup;
        acompo.Params.Assign(ActClient.CurrentReport.Params);
        writer:=TWriter.Create(astream,4096);
        try
         writer.WriteRootComponent(acompo);
        finally
         writer.free;
        end;
       finally
        acompo.free;
       end;
       astream.Seek(0,soFromBeginning);
       CB:=GenerateBlock(repgetparams,astream);
       try
        SendBlock(COnnection,CB);
       finally
        FreeBlock(CB);
       end;
      end;

     {
        Modificado por Albert Eije em 12/10/2012
        - Adicionado o código abaixo para retornar o DataInfo para a aplicação cliente
     }
     repgetremotedatainfo:
      begin
       if Not Assigned(ActClient.CurrentReport) then
        Raise Exception.Create(SRpNoFilename);
       alist:=TStringList.Create;
       try
        for i:=0 to ActClient.CurrentReport.DataInfo.Count-1 do
        begin
          ConsultaSQL := ActClient.CurrentReport.DataInfo.Items[i].SQL;
          { descomente essas linha se deseja que os dados retornem para o cliente sem quebra de linha
          ConsultaSQL := StringReplace(ConsultaSQL,#$D,'',[rfReplaceAll]);
          ConsultaSQL := StringReplace(ConsultaSQL,#$A,'',[rfReplaceAll]);
          }
          alist.Add(ConsultaSQL);
        end;
        CB:=GenerateBlock(repgetremotedatainfo,alist);

        alist.Clear;
        alist.LoadFromStream(cb.Data);
        try
         SendBlock(cOnnection,CB);
        finally
         FreeBlock(CB);
        end;
       finally
        alist.free;
       end;
      end;

     repsetparams:
      begin
       if Not Assigned(ActClient.CurrentReport) then
        Raise Exception.Create(SRpNoFilename);
       acompo:=TRpParamcomp.Create(nil);
       try
        acompo.Params.Assign(ActClient.CurrentReport.Params);
        reader:=TReader.Create(astream,4096);
        try
         Reader.ReadRootComponent(acompo);
        finally
         Reader.free;
        end;
        ActClient.CurrentReport.Params.Assign(acompo.Params);
       finally
        acompo.free;
       end;
       alist:=TStringList.Create;
       try
        CB:=GenerateBlock(repsetparams,alist);
        try
         SendBlock(COnnection,CB);
        finally
         FreeBlock(CB);
        end;
       finally
        alist.free;
       end;
      end;

     repexecutereportmeta:
      begin
       if Not ActClient.Auth then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        LoadReport(alist,ActClient);
        if Assigned(ActClient.CurrentReport) then
        begin
         if smp then
         begin
          SMPExecuteReport(ActClient.CurrentReport,astream,true);
         end
         else
         begin
          ActClient.cancelled:=false;
          APDFDriver:=TRpPdfDriver.Create;
          ActClient.CurrentReport.PrintAll(APDFDriver);
          astream.Clear;
          ActClient.CurrentReport.Metafile.SaveToStream(astream);
          astream.Seek(0,soFromBeginning);
         end;
         CB:=GenerateBlock(repexecutereportmeta,astream);
         try
          SendBlock(COnnection,CB);
         finally
          FreeBlock(CB);
         end;
        end;
       finally
        alist.Free;
       end;
      end;

     repexecutereportpdf:
      begin
       if Not ActClient.Auth then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        alist.LoadFromStream(astream);
        LoadReport(alist,ActClient);
        if assigned(ActClient.CurrentReport) then
        begin
         if smp then
         begin
          SMPExecuteReport(ActClient.CurrentReport,astream,false);
          CB:=GenerateBlock(repexecutereportpdf,astream);
         end
         else
         begin
          ActClient.cancelled:=false;
          ActClient.CurrentReport.Metafile.SaveToStream(astream);
          ActClient.cancelled:=false;
          APDFDriver:=TRpPdfDriver.Create;
          ActClient.CurrentReport.PrintRange(apdfdriver,false,ActClient.FromPage,ActClient.ToPage,ActClient.Copies,false);
          CB:=GenerateBlock(repexecutereportpdf,APDFDriver.PDFFile.MainPDF);
         end;
         try
           SendBlock(COnnection,CB);
         finally
          FreeBlock(CB);
         end;
        end;
       finally
        alist.Free;
       end;
      end;

     repgettree:
      begin
       if Not ActClient.Auth then
        Raise Exception.Create(SRpAuthFailed);
       alist:=TStringList.Create;
       try
        found:=true;
        alist.LoadFromStream(astream);
        if alist.Count<1 then
         found:=false;
        if found then
        begin
         aliasname:=alist.Names[0];
         index:=LAliases.IndexOfName(aliasname);
         if index<0 then
          found:=false;
        end;
        if found then
        begin
         username:=ActClient.Username;
         // Must check for privileges
         if Not CheckPrivileges(username,aliasname) then
          Raise Exception.Create(SRpAuthFailed+' - '+username+' - '+aliasname);
         apath:=LAliases.Values[alist.Names[0]];
         DoFillTreeDir(apath,alist,actclient);
        end;
        CB:=GenerateBlock(repgettree,alist);
        try
         SendBlock(COnnection,CB);
        finally
         FreeBlock(CB);
        end;
       finally
        alist.free;
       end;
      end;
    end;
   finally
    FreeBlock(ACB);
   end;
  finally
   astream.free;
  end;
 except
  // Sends the exception via socket as a error
  on E:Exception do
  begin
   if E.Message<>RSConnectionClosedGracefully then
   begin
    CB:=GenerateCBErrorMessage(SRpError+' - '+E.Message);
    try
     SendBlock(COnnection,CB);
    finally
     FreeBlock(CB);
    end;
   end;
  end;
 end;
end;
{$IFNDEF INDY10}
procedure Tmodserver.RepServerConnect(AThread: TIdPeerThread);
{$ENDIF}
{$IFDEF INDY10}
procedure Tmodserver.RepServerConnect(AContext: TIdContext);
{$ENDIF}
var
 NewClient: TRpClient;
begin
 NewClient:=TRpClient.Create;
 NewClient.DoInit(FFileNameConfig);
{$IFNDEF INDY10}
 NewClient.DNS:= AThread.Connection.LocalName;
{$ENDIF}
{$IFDEF INDY10}
 NewClient.DNS:= GStack.HostName;
{$ENDIF}
 NewClient.ConnectionDate:=Now;
 NewClient.LastAction:=NewClient.ConnectionDate;
{$IFNDEF INDY10}
 NewClient.Thread:=AThread;
{$ENDIF}
{$IFDEF INDY10}
 NewClient.Thread:=AContext;
{$ENDIF}
 NewClient.Auth:=False;
 NewClient.FromPage:=1;
 NewClient.ToPage:=9999999;
 NewClient.CompressedPDF:=true;
 NewClient.Copies:=1;
 NewClient.UserName:='';
 NewClient.Password:='';
{$IFNDEF INDY10}
 AThread.Data:=NewClient;
{$ENDIF}
{$IFDEF INDY10}
 AContext.Data:=NewClient;
{$ENDIF}
 try
  Clients.LockList.Add(NewClient);
 finally
  Clients.UnlockList;
 end;
end;

{$IFNDEF INDY10}
procedure Tmodserver.RepServerDisconnect(AThread: TIdPeerThread);
{$ENDIF}
{$IFDEF INDY10}
procedure Tmodserver.RepServerDisconnect(AContext: TIdContext);
{$ENDIF}
var
 ActClient: TRpClient;
begin
{$IFNDEF INDY10}
 ActClient:= TRpClient(AThread.Data);
{$ENDIF}
{$IFDEF INDY10}
 ActClient:= TRpClient(AContext.Data);
{$ENDIF}
 try
{$IFDEF USEBDE}
  ActClient.ASession.Close;
{$ENDIF}
  Clients.LockList.Remove(ActClient);
 finally
  Clients.UnlockList;
 end;
 ActClient.free;
{$IFNDEF INDY10}
 AThread.Data := nil;
{$ENDIF}
{$IFDEF INDY10}
 AContext.Data := nil;
{$ENDIF}
end;

procedure SMPExecuteReport(report:TRpReport;astream:TMemoryStream;metafile:Boolean);
var
 memstream:TMemoryStream;
 aparams:TStringList;
 currentdir:String;
{$IFDEF MSWINDOWS}
 sinfo:TStartupInfo;
 pinfo:TProcessInformation;
 secat:TSecurityAttributes;
 alist:TStringLIst;
 errorfname:string;
{$ENDIF}
 exefull:string;
 toexecute:String;
 repname,pdfname:string;
{$IFDEF LINUX}
 child:__pid_t;
 theparams:array [0..10] of pchar;
 i:integer;
 atempname,atempname2:String;
{$ENDIF}
begin
 astream.Clear;
 memstream:=TMemoryStream.Create;
 try
  report.SaveToStream(memstream);
  memstream.Seek(0,soFromBeginning);
  aparams:=TStringList.Create;
  try
{$IFDEF MSWINDOWS}
   currentdir:=ExtractFilePath(Application.Exename);
   repname:=RpTempFileName;
   pdfname:=RpTempFilename;
   errorfname:=RpTempFileName;
   exefull:=currentdir+'printreptopdf.exe';
   aparams.Add(exefull);
   aparams.Add(repname);
   aparams.Add(pdfname);
{$ENDIF}
{$IFDEF MSWINDOWS}
   sinfo.cb:=sizeof(sinfo);
   sinfo.lpReserved:=nil;
   sinfo.lpDesktop:=nil;
   sinfo.lpTitle:=nil;
   sinfo.dwX:=0;
   sinfo.dwY:=0;
   sinfo.dwXSize:=10;
   sinfo.dwYSize:=10;
   sinfo.dwFillAttribute:=0;
   sinfo.wShowWindow:=SW_HIDE;
   sinfo.cbReserved2:=0;
   sinfo.lpReserved2:=nil;
   sinfo.dwFlags:=0;
   sinfo.hStdError:=0;
   sinfo.hStdOutput:=0;
   secat.nLength:=sizeof(secat);
   secat.lpSecurityDescriptor:=nil;
   secat.bInheritHandle:=False;
   sinfo.hStdInput:=0;
   sinfo.hStdOutput:=0;
// Fixing 'printreptopdf System Error. Code:2':
// Missimg file-path in commandline-parameter for CreateProcess
// earlier code:
//   toexecute:='printreptopdf.exe';
// changed code:
   toexecute:='"'+currentdir+'printreptopdf.exe"';
   if metafile then
    toexecute:=toexecute+' -m ';
   toexecute:=toexecute+' -q -errorfile "'+
    errorfname+'" "'+repname+'" "'+pdfname+'"';
   memstream.SaveToFile(repname);
   try
    try
// Fixing second error: 'Error - ':
// An existing empty errorfile raises an error
// Errorfile should not exist except printreptopdf.exe create this  and fill it with errortext
// (it seems windows sometimes creates the file with the  GetTempFileName-API)
// new code-line before CreateProcess
// (may be there is a better way to solve this problem):
     DeleteFile(Pchar(errorfname));

     if not CreateProcess(PChar(exefull),Pchar(toexecute),nil,nil,false,
       NORMAL_PRIORITY_CLASS or DETACHED_PROCESS,nil,PChar(Currentdir),sinfo,pinfo) then
        RaiseLastOsError;
    except
     On E:Exception do
     begin
      Raise Exception.Create(SRpPrintPDFRep1+' '+E.Message);
     end;
    end;
    WaitForSingleObject(pinfo.hProcess,INFINITE);
    try
     if FileExists(errorfname) then
     begin
      alist:=TStringList.Create;
      try
       alist.LoadFromFile(errorfname);
       DeleteFile(Pchar(errorfname));
       raise Exception.Create(alist.Text);
      finally
       alist.free;
      end;
     end
     else
     begin
      astream.LoadFromFile(pdfname);
      astream.Seek(0,soFromBeginning);
     end;
    finally
     DeleteFile(Pchar(pdfname));
    end;
   finally
    DeleteFile(Pchar(repname));
   end;
{$ENDIF}
{$IFDEF LINUX}
   atempname:=RpTempFileName;
   atempname2:=RpTempFileName;
   memstream.SaveToFile(atempname);
{$IFDEF FORCECONSOLE}
   aparams.Add('printreptopdf');
{$ENDIF}
{$IFNDEF FORCECONSOLE}
   aparams.Add('printrep');
{$ENDIF}
   aparams.Add('-pdf');
   aparams.Add('-m');
   aparams.Add('-q');
   aparams.Add(atempname);
   aparams.Add(atempname2);
   // Creates a fork, and provides the input from a temp file
   for i:=0 to aparams.count-1 do
   begin
    theparams[i]:=Pchar(aparams[i]);
   end;
   theparams[aparams.count]:=nil;
   child:=fork;
   if child=-1 then
    Raise Exception.Create(SRpErrorForking);
   if child=0 then
   begin
    // The child executes the command
    execvp(theparams[0],PPChar(@theparams))
   end
   else
   begin
    try
     wait(@child);
    finally
     DeleteFile(atempname);
    end;
    astream.LoadFromFile(atempname2);
    astream.Seek(0,soFromBeginning);
    DeleteFile(atempname2);
   end;
{$ENDIF}
  finally
   aparams.Free;
  end;
 finally
  memstream.free;
 end;
end;


procedure TRpClient.DoInit(fconfig:string);
begin
 FRpAliasLibs.Connections.LoadFromFile(fconfig);
{$IFDEF USEBDE}
 FRpAliasLibs.Connections.BDESession:=ASession;
{$ENDIF}
end;

constructor TRpClient.Create;
begin
 FRpAliasLibs:=TRpAlias.Create(nil);
{$IFDEF USEBDE}
 // If can not create session omit it
 try
  ASession:=Sessions.OpenSession('Session'+IntToStr(SessionNumber));
  inc(SessionNumber);
//   ASession.AutoSessionName:=True;
//   ASession.Open;
 except
  ASession.free;
  ASession:=nil;
 end;
{$ENDIF}
end;

end.
