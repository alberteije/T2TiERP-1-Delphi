{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpmdrepclient                                   }
{                                                       }
{       Report Manager Client for Report Manager Server }
{       Routines and main interface to implement        }
{       the report client                               }
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

unit rpmdrepclient;

interface

{$I rpconf.inc}

uses
  SysUtils, Classes,
  IdBaseComponent,IdComponent,IdTCPConnection,
  IdTCPClient, rptranslator,rpmdprotocol,rpmdconsts,
{$IFNDEF USEVARIANTS}
  forms,
{$ENDIF}
{$IFDEF DOTNETD}
  IdStream,
 {$IFDEF INDY10}
  IdStreamVCL,
 {$ENDIF}
{$ENDIF}
{$IFNDEF DOTNETD}
 {$IFDEF INDY10}
  IdStream,
  IdStreamVCL,
 {$ENDIF}
{$ENDIF}
  SyncObjs,rpparams;

type
  TRpClientHandleThread=class;

  TGetStringList=procedure (alist:TStringList) of object;
  TGetStream=procedure (astream:TMemoryStream) of object;

  Tmodclient = class(TComponent)
  private
    { Private declarations }
    RepClient: TIdTCPClient;
    FStream:TMemoryStream;
    FEndReport:TEvent;
    FAuthorized:Boolean;
    FOnError:TRpLogMessageEvent;
    FOnLog:TRpLogMessageEvent;
    FOnExecute:TNotifyEvent;
    FOnGetTree:TGetStringList;
    FAliases:TStringList;
    FTree:TStringList;
    FOnGetUsers:TGetStringList;
    FOnGetUserGroups:TGetStringList;
    FOnGetGroups:TGetStringList;
    FOnGetAliases:TGetStringList;
    FOnGetAliasGroups:TGetStringList;
    FOnAuthorization:TNotifyEvent;
    FOnGetParams:TGetStream;
    FOnGetTasks:TGetStream;
    FPDF:Boolean;
    ClientHandleThread:TRpClientHandleThread;
    procedure RepClientDisconnected(Sender: TObject);
  public
    { Public declarations }
    asynchronous:boolean;
    dirseparator:char;
    threadsafeexec:boolean;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property PDF:Boolean read FPDF write FPDF default false;
    procedure GetUsers;
    procedure GetTasks;
    procedure CloseTask(taskid:integer);
    procedure GetGroups;
    procedure GetUserGroups(username:String);
    procedure GetParams;
    procedure ModifyParams(compo:TRpParamComp);
    procedure GetTree(aliasname:string);
    procedure AddUser(username,password:string);
    procedure AddUserGroup(username,groupname:string);
    procedure AddGroup(groupname:string);
    procedure AddAlias(aliasname,path:string);
    procedure AddAliasGroup(aliasname,groupname:string);
    procedure GetAliases;
    procedure GetAliasGroups(aliasname:String);
    procedure OpenReport(aliasname,reportname:string);
    procedure Execute(aliasname,reportname:string);overload;
    procedure Execute;overload;
    procedure DeleteUser(username:string);
    procedure DeleteUserGroup(username,groupname:string);
    procedure DeleteGroup(groupname:string);
    procedure DeleteAlias(aliasname:string);
    procedure DeleteAliasGroup(aliasname,groupname:string);
    property Aliases:TStringList read FAliases;
    property LastTree:TStringList read FTree;
    property OnError:TRpLogMessageEvent read FOnError write FOnError;
    property OnLog:TRpLogMessageEvent read FOnLog write FOnLog;
    property OnAuthorization:TNotifyEvent read FOnAuthorization write FOnAuthorization;
    property OnExecute:TNotifyEvent read FOnExecute write FOnExecute;
    property OnGetUsers:TGetStringList read FOnGetUsers write FOnGetUsers;
    property OnGetUserGroups:TGetStringList read FOnGetUserGroups write FOnGetUserGroups;
    property OnGetGroups:TGetStringList read FOnGetGroups write FOnGetGroups;
    property OnGetTree:TGetStringList read FOnGetTree write FOnGetTree;
    property OnGetParams:TGetStream read FOnGetparams write FOnGetParams;
    property OnGetTasks:TGetStream read FOnGetTasks write FOnGetTasks;
    property OnGetAliases:TGetStringList read FOnGetAliases write FOnGetAliases;
    property OnGetAliasGroups:TGetStringList read FOnGetAliasGroups write FOnGetAliasGroups;
    property Authorized:boolean read FAuthorized;
    property Stream:TMemoryStream read FStream;
  end;


  TRpClientHandleThread = class(TThread)
  private
   amod:TModClient;
   CB:TRpComBlock;
   data:TMemoryStream;
   FEndreport:TEvent;
   syncexec:boolean;
   errormessage:widestring;
   threadsafeexec:boolean;
   procedure HandleInput;
   procedure DoErrorMessage;
  protected
   procedure Execute; override;
  end;


function Connect(hostname:string;user:string;password:string;port:integer):TModClient;
procedure Disconnect(amod:TModClient);

implementation

procedure TRpClientHandleThread.DoErrorMessage;
begin
 if Assigned(amod) then
 begin
  if Assigned(amod.OnLog) then
  begin
   amod.OnLog(amod,errormessage);
  end;
 end;
end;

procedure TRpClientHandleThread.HandleInput;
var
 alist:TStringList;
begin
 // Handles the input this is VCLX thread safe
 try
 case CB.Command of
  reperror:
   if Assigned(amod.OnError) then
   begin
    amod.OnError(amod,RPComBlockToWideString(CB));
   end;
  replog:
   if Assigned(amod.OnLog) then
   begin
    amod.OnLog(amod,RPComBlockToWideString(CB));
   end;
  repauth:
   begin
    amod.FAuthorized:=true;
    alist:=TStringList.Create;
    try
     if Assigned(amod.FOnAuthorization) then
      amod.FOnAuthorization(amod);
     alist.LoadFromStream(data);
     if alist.count>0 then
      if Length(alist.strings[0])>0 then
       amod.dirseparator:=alist.strings[0][1];
     alist.Delete(0);
     amod.FAliases.Assign(alist);
     if assigned(amod.FOnGetAliases) then
      amod.FOnGetAliases(amod.FAliases);
    finally
     alist.free;
    end;
   end;
  repgetaliases:
   begin
    amod.FAliases.LoadFromStream(data);
    if assigned(amod.FOnGetAliases) then
     amod.FOnGetAliases(amod.FAliases);
   end;
  repgetparams:
   begin
    if assigned(amod.FOnGetParams) then
     amod.FOnGetParams(data);
   end;
  repgetconnections:
   begin
    if assigned(amod.FOnGetTasks) then
     amod.FOnGetTasks(data);
   end;
  repgettree:
   begin
    amod.FTree.LoadFromStream(data);
    if assigned(amod.FOnGetTree) then
     amod.FOnGetTree(amod.FTree);
   end;
  repgetusers:
   if Assigned(amod.FOnGetUsers) then
   begin
    alist:=TStringList.Create;
    try
     alist.LoadFromStream(data);
     amod.FOnGetUsers(alist);
    finally
     alist.free;
    end;
   end;
  repgetgroups:
   if Assigned(amod.FOnGetGroups) then
   begin
    alist:=TStringList.Create;
    try
     alist.LoadFromStream(data);
     amod.FOnGetGroups(alist);
    finally
     alist.free;
    end;
   end;
  repgetusergroups:
   if Assigned(amod.FOnGetUserGroups) then
   begin
    alist:=TStringList.Create;
    try
     alist.LoadFromStream(data);
     amod.FOnGetUserGroups(alist);
    finally
     alist.free;
    end;
   end;
  repgetaliasgroups:
   if Assigned(amod.FOnGetAliasGroups) then
   begin
    alist:=TStringList.Create;
    try
     alist.LoadFromStream(data);
     amod.FOnGetAliasGroups(alist);
    finally
     alist.free;
    end;
   end;
  repexecutereportmeta:
   begin
    amod.Stream.Clear;
    amod.Stream.SetSize(data.Size);
    data.Seek(0,soFromBeginning);
    amod.Stream.CopyFrom(data,data.size);
    amod.Stream.Seek(0,soFromBeginning);
    if Assigned(amod.OnExecute) then
    begin
     amod.OnExecute(amod);
    end;
   end;
 end;
 except
  On E:Exception do
  begin
   amod.OnError(amod,'Internal error:'+E.Message);
  end;
 end;
end;

procedure TRpClientHandleThread.Execute;
begin
 data:=TMemoryStream.Create;
 try
  while not Terminated do
  begin
   if not assigned(amod) then
   begin
    Terminate;
    break;
   end;
   if not amod.RepClient.Connected then
    Terminate
   else
   begin
    try
 {$IFDEF INDY10}
     amod.RepClient.IOHandler.ReadStream(data);
 {$ENDIF}
 {$IFNDEF INDY10}
     amod.RepClient.ReadStream(data);
 {$ENDIF}
     data.Seek(0,soFromBeginning);
     CB:=ReadRpComBlockFromStream(data);
     try
      data.SetSize(CB.Data.Size);
      CB.data.Seek(0,soFromBeginning);
      data.Seek(0,soFromBeginning);
      data.CopyFrom(CB.Data,CB.Data.Size);
      data.Seek(0,soFromBeginning);
      if syncexec then
      begin
       if CB.Command in [repgetparams,repsetparams,repauth,repexecutereportmeta,repexecutereportpdf,repopenreport,reperror] then
       begin
        if threadsafeexec then
        begin
         if Not (CB.Command in [repopenreport,repsetparams]) then
          HandleInput;
         if CB.Command<>repsetparams then
          FEndReport.SetEvent;
        end
        else
        begin
         if CB.Command<>repsetparams then
          FEndReport.SetEvent;
         if Not (CB.Command in [repopenreport,repsetparams]) then
          Synchronize(HandleInput);
        end;
        syncexec:=false;
       end;
      end
      else
       if Not (CB.Command in [repopenreport,repsetparams]) then
        Synchronize(HandleInput);
      data.Clear;
     finally
      FreeBlock(CB);
     end;
    except
     on E:Exception do
     begin
      errormessage:=E.Message;
      if threadsafeexec then
       DoErrorMessage
      else
       Synchronize(DoErrorMessage);
     end;
    end;
   end;
  end;
 finally
  data.free;
 end;
end;


function Connect(hostname:string;user:string;password:string;port:integer):TModClient;
var
 amod:TModClient;
 arec:TRpComBlock;
begin
 amod:=TModClient.Create(nil);
 try
  amod.RepClient.Host:=hostname;
  amod.RepClient.Port:=port;
  amod.RepClient.Connect;
  // Send user and password message
  amod.FAuthorized:=false;
  amod.ClientHandleThread := TRpClientHandleThread.Create(True);
  amod.ClientHandleThread.amod:=amod;
  amod.CLientHandleThread.FEndreport:=amod.FEndReport;
  amod.ClientHandleThread.FreeOnTerminate:=True;
  amod.ClientHandleThread.Resume;


  arec:=GenerateUserNameData(user,password);
  try
   amod.ClientHandleThread.threadsafeexec:=true;
//   if asynchronous then
//   begin
//    SendBlock(RepClient,arec);
//   end
//   else
   begin
    amod.ClientHandleThread.syncexec:=true;
    amod.FEndReport.ReSetEvent;
    // Sets an event and waits for its signal
    SendBlock(amod.RepClient,arec);
{$IFDEF MSWINDOWS}
    amod.FEndReport.WaitFor(20000);
{$ENDIF}
{$IFDEF LINUX}
    amod.FEndReport.WaitFor($FFFFFFFF);
{$ENDIF}
    if Not amod.FAuthorized then
     Raise Exception.Create(SRpAuthFailed);
   end;
  finally
   FreeBlock(arec);
  end;
//  amod.RepClient.WriteBuffer(arec,sizeof(arec));
 except
  amod.free;
  raise;
 end;
 Result:=amod;
end;

procedure Disconnect(amod:TModClient);
begin
 if amod.RepClient.Connected then
  amod.RepClient.Disconnect;
 amod.free;
end;



constructor Tmodclient.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 RepClient:=TIdTCPClient.Create(Self);
 RepClient.Port:=3060;
 RepClient.OnDisconnected:=RepClientDisconnected;
 dirseparator:=C_DIRSEPARATOR;
 FPDF:=False;
 FEndReport:=TEvent.Create(nil,false,false,'');
 FStream:=TMemoryStream.Create;
 FAliases:=TStringList.Create;
 FTree:=TStringList.Create;
end;

destructor TModClient.Destroy;
begin
 FEndReport.SetEvent;
 FEndReport.Free;
 FStream.Free;
 FAliases.Free;
 FTree.Free;
 if Assigned(ClientHandleThread) then
  CLientHandleThread.amod:=nil;
 inherited destroy;
end;


procedure TModClient.Execute(aliasname,reportname:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  alist.add(aliasname+'='+reportname);
  arec:=GenerateBlock(repexecutereportmeta,alist);
  try
   ClientHandleThread.threadsafeexec:=threadsafeexec;
   if asynchronous then
   begin
    SendBlock(RepClient,arec);
   end
   else
   begin
    ClientHandleThread.syncexec:=true;
    FEndReport.ReSetEvent;
    // Sets an event and waits for its signal
    SendBlock(RepClient,arec);
    FEndReport.WaitFor($FFFFFFFF);
   end;
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure TModClient.OpenReport(aliasname,reportname:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  alist.add(aliasname+'='+reportname);
  arec:=GenerateBlock(repopenreport,alist);
  try
   ClientHandleThread.threadsafeexec:=threadsafeexec;
   if asynchronous then
   begin
    SendBlock(RepClient,arec);
   end
   else
   begin
    ClientHandleThread.syncexec:=true;
    FEndReport.ReSetEvent;
    // Sets an event and waits for its signal
    SendBlock(RepClient,arec);
    FEndReport.WaitFor($FFFFFFFF);
   end;
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure TModClient.Execute;
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  ClientHandleThread.threadsafeexec:=threadsafeexec;
  arec:=GenerateBlock(repexecutereportmeta,alist);
  try
   ClientHandleThread.threadsafeexec:=threadsafeexec;
   if asynchronous then
   begin
    SendBlock(RepClient,arec);
   end
   else
   begin
    ClientHandleThread.syncexec:=true;
    FEndReport.ReSetEvent;
    // Sets an event and waits for its signal
    SendBlock(RepClient,arec);
    FEndReport.WaitFor($FFFFFFFF);
   end;
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.RepClientDisconnected(Sender: TObject);
begin
 if assigned(ClientHandleThread.FEndReport) then
  ClientHandleThread.FEndReport.SetEvent;
end;

procedure Tmodclient.GetUsers;
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  arec:=GenerateBlock(repgetusers,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.GetTasks;
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  arec:=GenerateBlock(repgetconnections,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.GetUserGroups(username:String);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  alist.Add(username);
  arec:=GenerateBlock(repgetusergroups,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.GetAliasGroups(aliasname:String);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  alist.Add(aliasname);
  arec:=GenerateBlock(repgetaliasgroups,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.GetParams;
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  arec:=GenerateBlock(repgetparams,alist);
  try
   ClientHandleThread.threadsafeexec:=threadsafeexec;
   if asynchronous then
   begin
    SendBlock(RepClient,arec);
   end
   else
   begin
    ClientHandleThread.syncexec:=true;
    FEndReport.ReSetEvent;
    // Sets an event and waits for its signal
    SendBlock(RepClient,arec);
    FEndReport.WaitFor($FFFFFFFF);
   end;
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;


procedure Tmodclient.GetTree(aliasname:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  alist.Add(aliasname+'=');
  arec:=GenerateBlock(repgettree,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure TModClient.GetGroups;
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  arec:=GenerateBlock(repgetgroups,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.GetAliases;
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  arec:=GenerateBlock(repgetaliases,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.AddAlias(aliasname,path:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  alist.Add(aliasname+'='+path);
  arec:=GenerateBlock(repaddalias,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.AddUser(username,password:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  alist.Add(username+'='+password);
  arec:=GenerateBlock(repadduser,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.AddUserGroup(username,groupname:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  alist.Add(username);
  alist.Add(groupname);
  arec:=GenerateBlock(repuseraddgroup,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.AddAliasGroup(aliasname,groupname:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  alist.Add(aliasname);
  alist.Add(groupname);
  arec:=GenerateBlock(repaliasaddgroup,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.AddGroup(groupname:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  alist.Add(groupname);
  arec:=GenerateBlock(repaddgroup,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.DeleteAlias(aliasname:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  alist.Add(aliasname+'=');
  arec:=GenerateBlock(repdeletealias,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.DeleteGroup(groupname:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  alist.Add(groupname);
  arec:=GenerateBlock(repdeletegroup,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.DeleteUser(username:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  alist.Add(username+'=');
  arec:=GenerateBlock(repdeleteuser,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.DeleteUserGroup(username,groupname:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  alist.Add(username);
  alist.Add(groupname);
  arec:=GenerateBlock(repuserdeletegroup,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.DeleteAliasGroup(aliasname,groupname:string);
var
 arec:TRpComBlock;
 alist:TStringList;
begin
 // Get the users
 alist:=TStringList.Create;
 try
  alist.Add(aliasname);
  alist.Add(groupname);
  arec:=GenerateBlock(repaliasdeletegroup,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;

procedure Tmodclient.ModifyParams(compo:TRpParamComp);
var
 writer:TWriter;
 astream:TMemoryStream;
 arec:TRpComBlock;
begin
 astream:=TMemoryStream.Create;
 try
  writer:=TWriter.Create(astream,4096);
  try
   writer.WriteRootComponent(compo);
  finally
   writer.free;
  end;
  astream.Seek(0,soFromBeginning);
  arec:=GenerateBlock(repsetparams,astream);
  try
   ClientHandleThread.threadsafeexec:=threadsafeexec;
   if asynchronous then
   begin
    SendBlock(RepClient,arec);
   end
   else
   begin
    // To avoid lock conflicts never check or set events
//    ClientHandleThread.syncexec:=true;
//    FEndReport.ReSetEvent;
    // Sets an event and waits for its signal
    SendBlock(RepClient,arec);
//    FEndReport.WaitFor($FFFFFFFF);
   end;
  finally
   FreeBlock(arec);
  end;
 finally
  astream.Free;
 end;
end;

procedure Tmodclient.CloseTask(taskid:integer);
var
 alist:TStringList;
 arec:TRpComBlock;
begin
 alist:=TStringList.Create;
 try
  alist.Add(IntToStr(taskid));
  arec:=GenerateBlock(repdeleteconnection,alist);
  try
   SendBlock(RepClient,arec);
  finally
   FreeBlock(arec);
  end;
 finally
  alist.free;
 end;
end;


end.
