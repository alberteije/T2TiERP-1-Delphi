unit rpsendmailvcl;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,rpmdconsts, ComCtrls,rpsendmail;

type
  TFRpSendMailVCL = class(TForm)                         
    BCancel: TButton;
    LProgress: TLabel;
    BProgress: TProgressBar;
    LKylobytes: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    cancelled:boolean;
    dologin:Boolean;
    fromaddress,fromname,smtpserver,
    username,password,subject,content,recipients,cc:String;
    attatchments:TStrings;
    oldonidle:TIdleEvent;
    wasok:Boolean;
    ErrorMessage:String;
    procedure AppIdle(Sender:TObject;Var done:Boolean);
    procedure OnProgress(amessage:WideString;bytecount,bytetotal:Integer;
     var docancel:Boolean);
  public
    { Public declarations }
  end;

function SendMailWithProgress(dologin:Boolean;fromaddress,fromname,smtpserver,
 username,password,subject,content,recipients,cc:String;
 attatchments:TStrings):Boolean;

implementation

{$R *.DFM}


function SendMailWithProgress(dologin:Boolean;fromaddress,fromname,smtpserver,
 username,password,subject,content,recipients,cc:String;
 attatchments:TStrings):Boolean;
var
 dia:TFRpSendMailVCL;
begin
 dia:=TFRpSendMailVCL.Create(Application);
 try
  dia.dologin:=dologin;
  dia.fromaddress:=fromaddress;
  dia.fromname:=fromname;
  dia.smtpserver:=smtpserver;
  dia.username:=username;
  dia.password:=password;
  dia.subject:=subject;
  dia.content:=content;
  dia.recipients:=recipients;
  dia.cc:=cc;
  if assigned(attatchments) then
   dia.attatchments.Assign(attatchments);
  dia.oldonidle:=Application.OnIdle;
  Application.OnIdle:=dia.AppIdle;
  dia.ShowModal;
  Result:=dia.wasok;
  if not Result then
   Raise Exception.Create(dia.ErrorMessage);
 finally
  dia.free;
 end;
end;

procedure TFRpSendMailVCL.FormCreate(Sender: TObject);
begin
 attatchments:=TStringList.Create;
 wasok:=false;
 Caption:=SRpTransmiting;
 BCancel.Caption:=SRpCancel;
 LProgress.Font.Style:=[fsBold];
 LKyloBytes.Font.Style:=[fsBold];

 cancelled:=false;
end;

procedure TFRpSendMailVCL.AppIdle(Sender:TObject;Var done:Boolean);
begin
 done:=false;
 Application.OnIdle:=oldOnidle;
 try
  SendMail(dologin,fromaddress,fromname,smtpserver,username,
   password,subject,content,recipients,cc,attatchments,OnProgress);
  wasok:=true;
 except
  on E:Exception do
  begin
   ErrorMessage:=E.Message;
   wasok:=false;
  end;
 end;
 Close;
end;


procedure TFRpSendMailVCL.BCancelClick(Sender: TObject);
begin
 cancelled:=true;
end;

procedure TFRpSendMailVCL.FormDestroy(Sender: TObject);
begin
 attatchments.free;
end;

procedure TFRpSendMailVCL.OnProgress(amessage:WideString;bytecount,bytetotal:Integer;
     var docancel:Boolean);
begin
 LProgress.Caption:=Amessage;
 BProgress.Max:=bytetotal;
 BProgress.Position:=bytecount;
 BProgress.Visible:=bytetotal>0;
 LKyloBytes.Caption:='';
 if bytecount>0 then
  LKyloBytes.Caption:=FormatFloat('##,###0.00 Kbytes',bytecount/1024);
 Application.ProcessMessages;
 docancel:=cancelled;
end;

end.
