{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpfaxsebd                                       }
{       Functions to send reports by fax                }
{       Only supports Windows and you must have         }
{       Turbo Power asyncpro installed                  }
{       http://sourceforge.net/projects/tpapro          }
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

unit rpfaxsend;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,rpmetafile,
  AdFaxCvt, AdPort, AdFax, AdFStat, OoMisc,AdExcept,AdFView,
  AdTapi,
  rpgdidriver,rptypes,rpmunits, ComCtrls, rpgraphutilsvcl,
  rpreport,rpmdshfolder,inifiles,rpmdconsts;

const
 CT_FAXHEADER='$D $T, $S $P / $N';
type
  TFRpFaxSend = class(TForm)
    BCancel: TButton;
    LEstatus: TLabel;
    LStatus: TLabel;
    LPhone: TLabel;
    LPhoneNum: TLabel;
    ApdTapiDevice1: TApdTapiDevice;
    ApdFaxStatus1: TApdFaxStatus;
    ApdFaxLog1: TApdFaxLog;
    ApdSendFax1: TApdSendFax;
    ApdComPort1: TApdComPort;
    ApdFaxConverter1: TApdFaxConverter;
    LConversion: TLabel;
    PConvers: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure ApdFaxConverter1ReadUserLine(F: TObject; Data: PByteArray;
      var Len: Integer; var EndOfPage, MorePages: Boolean);
    procedure BCancelClick(Sender: TObject);
    procedure ApdSendFax1FaxFinish(CP: TObject; ErrorCode: Integer);
  private
    { Private declarations }
    apffile,bitmapfile,coverfile:String;
    codeerror:Integer;
    Errormessage:String;
    sendok:Boolean;
    oldonidle:TIdleEvent;
    phonenumber,covertext:String;
    metafile:TRpMetafileReport;
    pageheight:integer;
    totallines:integer;
    numlinea:integer;
    abitmap:TBitmap;
    docancel:Boolean;
    tapidevice:String;
    showprogress:Boolean;
    sendingfax:Boolean;
    highres:Boolean;
    headerline:string;
    procedure AppIdle(Sender:TObject;var done:Boolean);
  public
    { Public declarations }
  end;


function SendFaxReport(phonenumber:String;covertext:string;tapidevice:String;report:TRpReport;showprogress:Boolean;highres:Boolean=false;headerline:string=CT_FAXHEADER):Boolean;
function SendFaxMetafile(phonenumber:String;covertext:string;tapidevice:String;metafile:TRpMetafileReport;showprogress:Boolean;highres:Boolean=false;headerline:string=CT_FAXHEADER):Boolean;
function SelectTApiDevice:String;
function GetDefaultTApiDevice:String;
procedure ChangeDefaultTApiDevice;

implementation

uses Math;

{$R *.dfm}

function SendFaxReport(phonenumber:String;covertext:string;tapidevice:String;report:TRpReport;showprogress:Boolean;highres:Boolean=false;headerline:string=CT_FAXHEADER):Boolean;
begin
 rpgdidriver.CalcReportWidthProgress(Report);
 Result:=SendFaxMetafile(phonenumber,covertext,tapidevice,Report.Metafile,showprogress,highres,headerline);
end;

function SendFaxMetafile(phonenumber:String;covertext:string;tapidevice:String;metafile:TRpMetafileReport;showprogress:Boolean;highres:Boolean=false;headerline:string=CT_FAXHEADER):Boolean;
var
 dia:TFRpFaxSend;
 apffile,coverfile,bitmapfile:string;
begin
 if not assigned(metafile) then
  Raise Exception.Create('Metafile not assigned');
 dia:=TFRpFaxSend.Create(Application);
 try
  dia.OldOnIdle:=Application.OnIdle;
  dia.phonenumber:=phonenumber;
  dia.LPhone.Caption:=dia.phonenumber;
  dia.metafile:=metafile;
  dia.tapidevice:=tapidevice;
  dia.covertext:=covertext;
  dia.headerline:=headerline;
  dia.showprogress:=showprogress;
  dia.highres:=highres;
  if showprogress then
  begin
   Application.OnIdle:=dia.AppIdle;
   dia.ShowModal;
  end
  else
  begin
   Application.OnIdle:=dia.AppIdle;
   dia.ApdFaxStatus1.Fax:=nil;
   dia.ApdSendFax1.StatusDisplay:=nil;
   dia.ShowModal;
  end;
  Result:=dia.Sendok;
  Application.OnIdle:=dia.oldonidle;
  if not dia.sendok then
   Raise Exception.Create(IntToStr(dia.codeerror)+':'+dia.Errormessage);
  apffile:=dia.apffile;
  coverfile:=dia.coverfile;
  bitmapfile:=dia.bitmapfile;
 finally
  dia.free;
  if Length(bitmapfile)>0 then
   DeleteFile(bitmapfile);
  if Length(apffile)>0 then
   DeleteFile(apffile);
  if Length(coverfile)>0 then
   DeleteFile(coverfile);
 end;
end;

procedure TFRpFaxSend.AppIdle(Sender:TObject;var done:Boolean);
var
 alist:TStringList;
begin
 done:=False;
 Application.Onidle:=nil;
 coverfile:='';
 bitmapfile:='';
 apffile:='';
 // Ask phone number if necesary
 if Length(phonenumber)<1 then
 begin
  phonenumber:=RpInputBox('Phone number','Enter phone number','');
 end;
 if Length(phonenumber)<1 then
 begin
  Raise Exception.Create('Must enter a phone number');
 end;
 docancel:=false;
 pageheight:=metafile.CustomY*100 div TWIPS_PER_INCHESS;
 totallines:=pageheight*metafile.CurrentPageCount;
 pconvers.Max:=totallines;
 if highres then
  abitmap:=rpgdidriver.MetafileToBitmap(metafile,showprogress,true,200,200)
 else
  abitmap:=rpgdidriver.MetafileToBitmap(metafile,showprogress,true,200,100);
 if not assigned(abitmap) then
  Raise Exception.Create(SRpErrorGeneratingFax);
 if abitmap.Height<1 then
  Raise Exception.Create(SRpErrorGeneratingFax);
 bitmapfile:=ChangeFileExt(RpTempFileName,'.bmp');
 abitmap.SaveToFile(bitmapfile);
 try
  apffile:=ChangeFileExt(RpTempFileName,'.apf');
  if highres then
  begin
   ApdFaxConverter1.Resolution:=frHigh;
  end
  else
   ApdFaxConverter1.Resolution:=frNormal;
  ApdFaxConverter1.DocumentFile:=bitmapfile;
  ApdFaxConverter1.OutFileName:=apffile;
  numlinea:=0;
  ApdFaxConverter1.ConvertToFile;
 finally
  abitmap.free;
 end;
 if Length(covertext)>0 then
 begin
  coverfile:=ChangeFileExt(RpTempFileName,'.txt');
  alist:=TStringList.Create;
  try
   alist.Text:=covertext;
   alist.SaveToFile(coverfile);
  finally
   alist.free;
  end;
  ApdSendFax1.FaxFile:=apffile;
  ApdSendFax1.CoverFile:=coverfile;
 end
 else
 begin
  ApdSendFax1.FaxFile:=apffile;
 end;
 ApdSendFax1.HeaderLine:=headerline;
 apdComPort1.AutoOpen:=true;
 if Length(tapidevice)<1 then
  ApdTapiDevice1.SelectDevice
 else
  ApdTapiDevice1.SelectedDevice:=tapidevice;
 ApdSendFax1.PhoneNumber:=phonenumber;
 ApdSendFax1.StartTransmit;
 sendingfax:=true;
end;

procedure TFRpFaxSend.FormCreate(Sender: TObject);
begin
 LPhoneNum.Caption:=SRpPhoneNum;
 LStatus.Caption:=SRpStatus;
 LConversion.Caption:=SRpConversion;
 BCancel.Caption:=SRpCancel;
 LStatus.Font.Style:=[fsBold];
 LPhone.Font.Style:=[fsBold];
end;

procedure TFRpFaxSend.ApdFaxConverter1ReadUserLine(F: TObject;
  Data: PByteArray; var Len: Integer; var EndOfPage, MorePages: Boolean);
var
 i:integer;
 aline:PChar;
begin
 Len:=abitmap.Width div 8;
 aline:=PChar(abitmap.ScanLine[numlinea]);
 for i:=0 to Len-1 do
 begin
  Data[i]:=Not (Byte(aline[i]));
 end;
 inc(numlinea);
 if (numlinea mod 10)=0 then
  PConvers.Position:=numlinea;
 EndOfPage:=false;
 MorePages:=true;
 if (numlinea mod pageheight)=0 then
 begin
  EndOfPage:=true;
  if numlinea>=abitmap.Height then
  begin
   PConvers.Position:=PConvers.Max;
   MorePages:=false;
  end;
 end;
end;

procedure TFRpFaxSend.BCancelClick(Sender: TObject);
begin
 docancel:=true;
end;

function SelectTApiDevice:String;
var
 ApdTapiDevice1: TApdTapiDevice;
begin
 Result:='';
 ApdTapiDevice1:=TApdTapiDevice.Create(Application);
 try
  ApdTapiDevice1.ShowPorts:=false;
  if mrok=ApdTapiDevice1.SelectDevice then
   Result:=ApdTapiDevice1.SelectedDevice;
 finally
  ApdTapiDevice1.Free;
 end;
end;


procedure TFRpFaxSend.ApdSendFax1FaxFinish(CP: TObject;
  ErrorCode: Integer);
begin
 sendingfax:=false;
 if ErrorCode=0 then
  sendok:=true
 else
 begin
  CodeError:=ErrorCode;
  Errormessage:=ErrorMsg(ErrorCode);
 end;
// if showprogress then
  Close;
end;

function GetDefaultTApiDevice:String;
var
 inif:TMemInifile;
 filename:String;
begin
 filename:=Obtainininamecommonconfig('','','repmand');
 inif:=TMemInifile.Create(filename);
 try
  Result:=inif.ReadString('FAX','TAPIDEVICE','');
 finally
  inif.Free;
 end;
end;

procedure ChangeDefaultTApiDevice;
var
 inif:TMemInifile;
 filename:String;
begin
 filename:=Obtainininamecommonconfig('','','repmand');
 inif:=TMemInifile.Create(filename);
 try
  inif.WriteString('FAX','TAPIDEVICE',SelectTApiDevice);
  inif.UpdateFile;
 finally
  inif.Free;
 end;
end;

end.
