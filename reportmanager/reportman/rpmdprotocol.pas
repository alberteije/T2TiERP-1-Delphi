{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpmdprotocol                                    }
{                                                       }
{       Report Manager Client protocol                  }
{       for Report Manager Server                       }
{       routines to send and receive data               }
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

unit rpmdprotocol;

interface

{$I rpconf.inc}

uses SysUtils,Classes,rpmdconsts,
 IdTCPConnection;

const
  REPSERBUFSIZE=4096;
  MAX_BLOCK=200000000;

type
  TRepCommand=(repauth,repopenalias,repopenreport,repexecutereportmeta,
   repexecutereportpdf,reperror,replog,repgetusers,repgetaliases,repaddalias,
   repdeletealias,repadduser,repdeleteuser,repgettree,
   repgetparams,repsetparams,repgetgroups,repaddgroup,repdeletegroup,
   repgetusergroups,repuserdeletegroup,repuseraddgroup,
   repgetaliasgroups,repaliasdeletegroup,repaliasaddgroup,
   repgetconnections,repdeleteconnection,repgetremotedatainfo);

  TRpLogMessageEvent=procedure (Sender:TObject;aMessage:WideString) of object;

  TRpComBlock = record
   Command:TRepCommand;
   Datasize:integer;
   Data:TMemoryStream;
  end;

  // The real data of the command is stored at the end
  // of the communications block

  // Report commands

  // repauth
  // Client:Sends string list containing  user and password

  // repopenalias
  // Client:Sends a string containing an alias to the connection
  //        if no alias defined must be the path where the reports are
  //        in the server
  // Server:Returns the available reports in a string list

  // repopenreport
  // Client:Sends a string containing the report name to open
  // Server:Returns the available parameters


  // repexecutereportmeta
  // Client:Sends nothing (only the key)
  // Server:Returns the executed report in Metafileformat

  // repexecutereportpdf
  // Client:Sends nothing (only the key)
  // Server:Returns the executed report in pdf format


function GenerateUserNameData(user,password:string):TRpComBlock;
function GenerateCBErrorMessage(amessage:WideString):TRpComBLock;
function GenerateCBLogMessage(amessage:WideString):TRpComBLock;
function GenerateBlock(command:TRepCommand;Stream:TMemoryStream):TRpComBlock;overload;
function GenerateBlock(command:TRepCommand;alist:TStringList):TRpComBlock;overload;
procedure FreeBlock(ablock:TRpComBlock);
procedure SendBlock(AConnection:TIdTCPConnection;CB:TRpComBlock);
procedure WriteRpComBlockToStream(CB:TRpComBlock;astream:TStream);
function ReadRpComBlockFromStream(astream:TStream):TRpComBlock;
function RPComBlockToWideString(CB:TRpComBlock):WideString;

implementation




procedure WriteRpComBlockToStream(CB:TRpComBlock;astream:TStream);
var
 aint:integer;
begin
 aint:=integer(CB.Command);
 astream.Write(aint,sizeof(aint));
// Bug in delphi.net when sending streams
//{$IFDEF DOTNETD}
// astream.Write(aint,sizeof(aint));
//{$ENDIF}
 astream.Write(CB.Datasize,sizeof(CB.DataSize));
 CB.Data.Seek(0,soFromBeginning);
 astream.CopyFrom(CB.Data,CB.Datasize);
end;


function ReadRpComBlockFromStream(astream:TStream):TRpComBlock;
var
 aint:integer;
begin
 astream.Seek(0,soFromBeginning);
 astream.Read(aint,sizeof(aint));
 Result.Command:=TRepCommand(aint);
 astream.Read(Result.DataSize,sizeof(Result.Datasize));
 if Result.Datasize<0 then
  Result.Datasize:=0;
 if Result.Datasize>MAX_BLOCK then
  Raise Exception.Create(SRpMax+' BLOCKSIZE');
 Result.Data:=TMemoryStream.Create;
 Result.Data.SetSize(Result.DataSize);
 if Result.Datasize>0 then
  Result.Data.CopyFrom(astream,Result.Datasize);
end;


function GenerateUserNameData(user,password:string):TRpComBlock;
var
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  alist.Add(user+'='+password);
  Result:=GenerateBlock(repauth,alist);
 finally
  alist.free;
 end;
end;

function GenerateCBErrorMessage(amessage:WideString):TRpComBLock;
var
 astream:TMemoryStream;
 alist:TStringList;
begin
 astream:=TMemoryStream.Create;
 try
  alist:=TStringList.Create;
  try
   alist.Add(amessage);
   alist.SaveToStream(aStream);
   Result:=GenerateBlock(reperror,astream);
  finally
   alist.free;
  end;
 finally
  astream.free;
 end;
end;

function RPComBlockToWideString(CB:TRpComBlock):WideString;
var
 alist:TStringList;
begin
 alist:=TStringList.Create;
 try
  CB.Data.Seek(0,soFromBeginning);
  alist.LoadFromStream(CB.Data);
  Result:=alist.Text;
 finally
  alist.free;
 end;
end;


function GenerateCBLogMessage(amessage:WideString):TRpComBLock;
var
 astream:TMemoryStream;
 alist:TStringList;
begin
 astream:=TMemoryStream.Create;
 try
  alist:=TStringList.Create;
  try
   alist.Add(amessage);
   alist.SaveToStream(aStream);
   Result:=GenerateBlock(replog,astream);
  finally
   alist.free;
  end;
 finally
  astream.free;
 end;
end;

function GenerateBlock(command:TRepCommand;Stream:TMemoryStream):TRpComBlock;overload;
begin
 Stream.Seek(0,soFromBeginning);
 Result.Command:=command;
 Result.Datasize:=Stream.Size;
 Result.Data:=TMemoryStream.Create;
 Result.Data.SetSize(Result.Datasize);
 Result.Data.CopyFrom(Stream,Result.Datasize);
 Result.Data.Seek(0,soFromBeginning);
end;

function GenerateBlock(command:TRepCommand;alist:TStringList):TRpComBlock;overload;
var
 mems:TMemoryStream;
begin
  mems:=TMemoryStream.Create;
  try
    alist.SaveToStream(mems);
    mems.Seek(0,soFromBeginning);
    Result:=GenerateBlock(command,mems);
  finally
    mems.free;
  end;
end;

procedure FreeBlock(ablock:TRpComBlock);
begin
 ablock.Data.free;
 ablock.Data:=nil;
 ablock.DataSize:=0;
end;

procedure SendBlock(AConnection:TIdTCPConnection;CB:TRpComBlock);
var
 memstream:TMemoryStream;
begin
 if Not AConnection.Connected then
  exit;
 memstream:=TMemoryStream.Create;
 try
  WriteRpComBlockToStream(CB,memstream);
  memstream.Seek(0,soFromBeginning);
{$IFDEF INDY10}
  AConnection.IOHandler.Write(memstream,0,True);
{$ENDIF}
{$IFNDEF INDY10}
  AConnection.WriteStream(memstream,true,true);
{$ENDIF}
 finally
  memstream.free;
 end;
end;


end.
