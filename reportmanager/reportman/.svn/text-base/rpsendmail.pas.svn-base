unit rpsendmail;


interface

uses SysUtils,Classes,IdBaseComponent, IdComponent, IdTCPConnection,
 IdSMTP,IdMessage,IdTCPClient,IdMessageClient,rpmdconsts;

type
 TRpSendProgress=procedure (amessage:WideString;bytecount,bytetotal:Integer;
  var docancel:Boolean) of object;

 TRpSendObjProg=class(TObject)
  private
   onprogress:TRpSendProgress;
   maximum:integer;
   procedure OnWork(Sender: TObject; AWorkMode: TWorkMode;
    const AWorkCount: Integer);
   procedure WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
    const AWorkCountMax: Integer);
   procedure WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
  end;

function SendMail(dologin:Boolean;fromaddress,fromname,smtpserver,
 username,password,subject,content,recipients,cc:String;
 attatchments:TStrings;onprogress:TRpSendProgress):Boolean;

implementation

procedure DecodeDestinationsString(astring:String;alist:TStrings);
var
 index:integer;
begin
 index:=pos(';',astring);
 while index>0 do
 begin
  alist.Add(Copy(astring,1,index-1));
  astring:=Copy(astring,index+1,Length(astring));
  index:=pos(';',astring);
 end;
 if Length(astring)>0 then
  alist.Add(astring);
end;

function SendMail(dologin:Boolean;fromaddress,fromname,smtpserver,
 username,password,subject,content,recipients,cc:String;
 attatchments:TStrings;onprogress:TRpSendProgress):Boolean;
var
 asmtp:TIdSmtp;
 amessage:TIDMessage;
 alist:TStringList;
 i:integer;
 idfile:TIdAttachment;
 progress:TRpSendObjProg;
 docancel:Boolean;
begin
 docancel:=False;
 asmtp:=TIdSMTP.Create(nil);
 try
  asmtp.Username:=username;
  asmtp.MailAgent:='IdSMTP-rpsendmail';
  asmtp.Host:=smtpserver;
  asmtp.Password:=password;
  if dologin then
   asmtp.AuthenticationType:=atLogin
  else
   asmtp.AuthenticationType:=atNone;
  if assigned(onprogress) then
  begin
   onprogress(SRpConnecting,0,0,docancel);
   if docancel then
    Raise Exception.Create(SRpOperationAborted);
  end;
  asmtp.Connect;
  try
   if assigned(onprogress) then
   begin
    onprogress(SRpGenerating,0,0,docancel);
    if docancel then
     Raise Exception.Create(SRpOperationAborted);
   end;
   amessage:=TIdMessage.Create(nil);
   try
    amessage.Subject:=subject;
    amessage.Body.Text:=content;
    amessage.From.Address:=fromaddress;
    amessage.From.Name:=fromname;
    alist:=TStringList.Create;
    try
     DecodeDestinationsString(recipients,alist);
     for i:=0 to alist.count-1 do
     begin
      amessage.Recipients.Add.Address:=alist.Strings[i];
     end;
     alist.clear;
     DecodeDestinationsString(cc,alist);
     for i:=0 to alist.count-1 do
     begin
      amessage.CCList.Add.Address:=alist.Strings[i];
     end;
     if Assigned(attatchments) then
     begin
      for i:=0 to attatchments.Count-1 do
      begin
       idfile:=TIdAttachment.Create(amessage.MessageParts);
       idfile.FileName:=ExtractFileName(attatchments.Strings[i]);
       idfile.StoredPathName:=attatchments.Strings[i];
      end;
     end;
    finally
     alist.free;
    end;
    if assigned(onprogress) then
    begin
     progress:=TRpSendObjProg.Create;
     try
      progress.onprogress:=onprogress;
      asmtp.OnWork:=progress.OnWork;
      asmtp.OnWorkBegin:=progress.WorkBegin;
      asmtp.OnWorkEnd:=progress.WorkEnd;
      onprogress(SRpSending,0,0,docancel);
      if docancel then
       Raise Exception.Create(SRpOperationAborted);
      asmtp.Send(amessage);
     finally
      progress.free;
     end;
    end
    else
     asmtp.Send(amessage);
   finally
    amessage.free;
   end;
  finally
   asmtp.Disconnect;
  end;
 finally
  asmtp.free;
 end;
 Result:=true;
end;

procedure TRpSendObjProg.OnWork(Sender: TObject; AWorkMode: TWorkMode;
    const AWorkCount: Integer);
var
 docancel:Boolean;
begin
 docancel:=false;
 onprogress(SRpSending,AWorkCount,maximum,docancel);
 if docancel then
  Raise Exception.Create(SRpOperationAborted);
end;

procedure TRpSendObjProg.WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
    const AWorkCountMax: Integer);
var
 docancel:Boolean;
begin
 docancel:=false;
 maximum:=AWorkCountMax;
 onprogress(SRpSending,0,maximum,docancel);
 if docancel then
  Raise Exception.Create(SRpOperationAborted);
end;

procedure TRpSendObjProg.WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
var
 docancel:Boolean;
begin
 docancel:=false;

 onprogress(SRpSending,maximum,maximum,docancel);
 if docancel then
  Raise Exception.Create(SRpOperationAborted);
end;

end.
