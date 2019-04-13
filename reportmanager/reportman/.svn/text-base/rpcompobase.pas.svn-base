{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpcompobase                                     }
{       Report component base                           }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpcompobase;

interface

{$I rpconf.inc}

uses Classes,Sysutils,rpreport,rpmdconsts,
 rpalias,rpsubreport,rpsection,rpprintitem,rptypes,
 rpdatainfo,
 rphtmldriver,rpcsvdriver,rpsvgdriver,
{$IFDEF USEINDY}
 rpmdrepclient,rpparams,SyncObjs,
{$ENDIF}
 rpmetafile;

type
 TCBaseReport=class(TComponent)
  private
   FFilename:TFilename;
   FConnectionName:String;
   FReport:TRpReport;
   FPreview:Boolean;
   FShowProgress:Boolean;
   FTitle:WideString;
   FAliasList:TRpAlias;
   FShowPrintDialog:boolean;
   FLanguage:integer;
   FOnBeforePrint:TNotifyEvent;
   FReportName:String;
   FAsyncExecution:Boolean;
{$IFDEF USEINDY}
   FRemoteError:Boolean;
   FRemoteMessage:WideString;
   procedure OnRemoteError(Sender:TObject;aMessage:WideString);
   procedure OnGetParams(astream:TMemoryStream);
{$ENDIF}
   procedure InternalSetBeforePrint;
   function GetReport:TRpReport;
   procedure SetFileName(Value:TFilename);
   procedure SetOnBeforePrint(NewValue:TNotifyEvent);
   procedure SetConnectionName(Value:String);
   procedure SetReportName(Value:String);
   procedure SetAsyncExecution(avalue:boolean);
   procedure SetLanguage(Value:Integer);
  protected
   procedure Notification(AComponent: TComponent; Operation: TOperation);override;
   procedure InternalExecuteRemote(metafile:TRpMetafileReport);virtual;
  public
   function Execute:boolean;virtual;
   procedure PrinterSetup;virtual;abstract;
   constructor Create(AOwner:TComponent);override;
   procedure CheckLoaded;
   function ShowParams:boolean;virtual;abstract;
   function PrintRange(frompage:integer;topage:integer;
    copies:integer;collate:boolean):boolean;virtual;abstract;
  // Defined as public but will be published in descendants
   procedure SaveToText(filename:string;textdriver:String='');virtual;abstract;
   procedure SaveToHTML(filename:string);
   procedure SaveToHTMLSingle(filename:string);
   procedure SaveToCustomText(filename:string);
   procedure SaveToSVG(filename:string);
   procedure SaveToCSV(filename:string;separator:string=',');
   procedure LoadFromFile(AFilename:string);
   procedure LoadFromStream(stream:TStream);
   procedure ExecuteRemote(hostname:String;port:integer;user,password,aliasname,reportname:String);
   procedure GetRemoteParams(hostname:String;port:integer;user,password,aliasname,reportname:String);
   property Report:TRpReport read GetReport;
   property Preview:Boolean read FPreview write FPreview default true;
   property ShowProgress:boolean read FShowProgress write FShowProgress
    default true;
   property Title:widestring read FTitle write FTitle;
   property ShowPrintDialog:boolean read FShowPrintDialog
    write FShowPrintDialog default true;
   property AliasList:TRpAlias read FAliasList write FAliasList;
   property Language:integer read FLanguage write SetLanguage default -1;
  published
   property Filename:TFilename read FFilename write SetFilename;
   property ConnectionName:String read FConnectionName write SetConnectionName;
   property AsyncExecution:Boolean read FAsyncExecution write SetAsyncExecution;
   property ReportName:String read FReportName write SetReportName;
   property OnBeforePrint:TNotifyEvent read FOnBeforePrint
    write SetOnBeforePrint;
  end;


implementation


constructor TCBaseReport.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FShowProgress:=true;
 FFilename:='';
 FPreview:=true;
 FTitle:=SRpUntitled;
 FShowPrintDialog:=True;
 FLanguage:=-1;
end;

procedure TCBaseReport.Notification(AComponent: TComponent; Operation: TOperation);
begin
 inherited Notification(AComponent,Operation);

 if Assigned(AComponent) then
  if Operation=OpRemove then
   if AComponent=FAliasList then
    FAliasList:=nil;
end;

procedure TCBaseReport.SetFileName(Value:TFilename);
begin
 if (csloading in ComponentState) then
 begin
  FFilename:=Value;
  exit;
 end;
 if FFilename<>Value then
 begin
  if Assigned(FReport) then
  begin
   FReport.free;
   FReport:=nil;
  end;
  FFilename:=Value;
 end;
end;



function TCBaseReport.GetReport:TRpReport;
begin
 CheckLoaded;
 Result:=FReport;
end;



procedure TCBaseReport.CheckLoaded;
var
 dblist:TRpDatabaseInfoList;
 astream:TStream;
begin
 // Loads the report
 if Assigned(FReport) then
 begin
  FReport.AliasList:=AliasList;
  if FLanguage>=0 then
   FReport.Language:=FLanguage;
  exit;
 end;
 if Length(FFilename)>0 then
 begin
  LoadFromFile(FFilename);
 end
 else
 begin
  if Length(ConnectionName)<1 then
   Raise Exception.Create(SRpNoFilename);
  if Length(ReportName)<1 then
   Raise Exception.Create(SRpNoFilename);
  if Not Assigned(AliasList) then
   Raise Exception.Create(SRpPRpAliasRequired);
  dblist:=AliasList.Connections;
  astream:=dblist.GetReportStream(ConnectionName,ReportName,nil);
  try
   LoadFromStream(astream);
  finally
   astream.free;
  end;
 end;
 InternalSetBeforePrint;
 if Assigned(FReport) then
 begin
  FReport.AliasList:=AliasList;
 end;
end;

procedure TCBaseReport.SetOnBeforePrint(NewValue:TNotifyEvent);
begin
 FOnBeforePrint:=NewValue;
 InternalSetBeforePrint;
end;


procedure TCBaseReport.SetLanguage(Value:Integer);
begin
 FLanguage:=Value;
 if Assigned(FReport) then
  if FLanguage>=0 then
   FReport.Language:=FLanguage;
end;


function TCBaseReport.Execute:boolean;
begin
 CheckLoaded;
 Result:=false;
end;

procedure TCBaseReport.LoadFromFile(AFilename:string);
var
 astream:TFileStream;
begin
 astream:=TFileStream.Create(AFilename,fmOpenRead or fmShareDenyNone);
 try
  LoadFromStream(astream);
 finally
  astream.free;
 end;
end;


procedure TCBaseReport.LoadFromStream(stream:TStream);
begin
 if Assigned(FReport) then
 begin
  FReport.Free;
  FReport:=nil;
 end;
 FReport:=TRpReport.Create(Self);
 try
  FReport.LoadFromStream(Stream);
  InternalSetBeforePrint;
  Freport.AsyncExecution:=FAsyncExecution;
 except
  FReport.Free;
  FReport:=nil;
  raise;
 end;
end;

procedure TCBaseReport.InternalSetBeforePrint;
var
 i,j,k:integer;
 subrep:TRpSubReport;
 sec:TRpSection;
begin
 If not Assigned(FReport) then
  exit;
 for i:=0 to FReport.SubReports.Count-1 do
 begin
  subrep:=FReport.SubReports.Items[i].SubReport;
  for j:=0 to subrep.Sections.Count-1 do
  begin
   sec:=subrep.Sections.Items[j].Section;
   sec.OnBeforePrint:=FOnBeforePrint;
   for k:=0 to sec.ReportComponents.Count-1 do
   begin
    TRpCommonComponent(sec.ReportComponents.Items[k].Component).OnBeforePrint:=FOnBeforePrint;
   end;
  end;
 end;
end;



procedure TCBaseReport.InternalExecuteRemote(metafile:TRpMetafileReport);
begin
 // Implemented in derived classes
end;

{$IFDEF USEINDY}
procedure TCBaseReport.OnRemoteError(Sender:TObject;aMessage:WideString);
begin
 Fremoteerror:=true;
 Fremotemessage:=aMessage;
end;
{$ENDIF}


{$IFDEF USEINDY}
procedure TCBaseReport.OnGetParams(astream:TMemoryStream);
var
 acompo:TRpParamComp;
 reader:TReader;
begin
 acompo:=TRpParamComp.Create(nil);
 try
  reader:=TReader.Create(astream,4096);
  try
   reader.ReadRootComponent(acompo);
   if assigned(FReport) then
   begin
    FReport.free;
    FReport:=nil;
   end;
   FReport:=TRpReport.Create(Self);
   FReport.Params.Assign(acompo.params);
  finally
   reader.free;
  end;
 finally
  acompo.free;
 end;
end;
{$ENDIF}

procedure TCBaseReport.GetRemoteParams(hostname:String;port:integer;user,password,aliasname,reportname:String);
{$IFDEF USEINDY}
var
 client:Tmodclient;
{$ENDIF}
begin
{$IFDEF USEINDY}
 client:=Connect(hostname,user,password,port);
 try
  client.threadsafeexec:=true;
  client.OnError:=OnRemoteError;
  client.OnGetParams:=OnGetParams;
  client.OpenReport(aliasname,reportname);
  client.GetParams;
 finally
  Disconnect(client);
 end;
{$ENDIF}
end;

procedure TCBaseReport.ExecuteRemote(hostname:String;port:integer;user,password,aliasname,reportname:String);
{$IFDEF USEINDY}
var
 client:Tmodclient;
 metafile:TRpMetafileReport;
 acompo:TRpParamComp;
{$ENDIF}
begin
{$IFDEF USEINDY}
 client:=Connect(hostname,user,password,port);
 try
  metafile:=TRpMetafileReport.Create(nil);
  try
   client.threadsafeexec:=true;
   Fremoteerror:=false;
   client.OnError:=OnRemoteError;
   client.OpenReport(aliasname,reportname);
   if Assigned(FReport) then
   begin
    acompo:=TRpParamComp.Create(nil);
    try
     acompo.Params.Assign(FReport.Params);
     client.ModifyParams(acompo);
    finally
     acompo.free;
    end;
   end;
   client.Execute;
//   client.Execute(aliasname,reportname);
   if Fremoteerror then
    Raise Exception.Create(Fremotemessage);
   client.Stream.Seek(0,soFromBeginning);
   metafile.LoadFromStream(client.Stream);
   InternalExecuteRemote(metafile);
  finally
   metafile.free;
  end;
 finally
  Disconnect(client);
 end;
{$ENDIF}
end;

procedure TCBaseReport.SetAsyncExecution(avalue:boolean);
begin
 FAsyncExecution:=aValue;
 if Assigned(FReport) then
 begin
  FReport.AsyncExecution:=FAsyncExecution;
 end;
end;

procedure TCBaseReport.SetReportName(Value:String);
begin
 if (csloading in ComponentState) then
 begin
  FReportName:=Value;
  exit;
 end;
 if FReportname<>Value then
 begin
  if Assigned(FReport) then
  begin
   FReport.free;
   FReport:=nil;
  end;
  FReportName:=Value;
  if Length(FReportName)>0 then
   FFilename:='';
 end;
end;

procedure TCBaseReport.SetConnectionName(Value:String);
begin
 if (csloading in ComponentState) then
 begin
  FConnectionName:=Value;
  exit;
 end;
 if FConnectionName<>Value then
 begin
  if Assigned(FReport) then
  begin
   FReport.free;
   FReport:=nil;
  end;
  FConnectionName:=Value;
  if Length(FConnectionName)>0 then
   FFilename:='';
 end;
end;

procedure TCBaseReport.SaveToHTML(filename:string);
begin
 ExportReportToHtml(report,filename,showprogress);
end;

procedure TCBaseReport.SaveToHTMLSingle(filename:string);
begin
 ExportReportToHtmlSingle(report,filename);
end;

procedure TCBaseReport.SaveToCustomText(filename:string);
begin
 ExportReportToTextPro(report,filename,showprogress);
end;

procedure TCBaseReport.SaveToSVG(filename:string);
begin
 ExportReportToSVG(report,filename,showprogress);
end;

procedure TCBaseReport.SaveToCSV(filename:string;separator:string=',');
begin
 ExportReportToCSV(report,filename,showprogress,separator);
end;

end.
