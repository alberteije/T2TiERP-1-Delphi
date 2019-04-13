{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdysinfoqt                                    }
{       Form showing info about printer and system      }
{       Qt version                                      }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

unit rpmdsysinfoqt;

interface

{$I rpconf.inc}

uses SysUtils, Classes, QGraphics, QForms, QControls, QStdCtrls,
  QButtons, QExtCtrls,QPrinters,rpmdconsts,QDialogs,
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  Qt;

type
  TFRpSysInfo = class(TForm)
    BOK: TButton;
    GSelectedPrinter: TGroupBox;
    Label1: TLabel;
    EStatus: TEdit;
    EPrinterName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    LCollation: TLabel;
    Label9: TLabel;
    LResolution: TLabel;
    GWinInfo: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    LProcessors: TLabel;
    LOEMID: TLabel;
    LOS: TLabel;
    Label14: TLabel;
    Label12: TLabel;
    LVersion: TLabel;
    EPrinterDevice: TEdit;
    Label13: TLabel;
    LDisplay: TLabel;
    GLinINfo: TGroupBox;
    LSysComp: TListBox;
    ESysInfo: TMemo;
    LFiles: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LSysCompClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


procedure RpShowSystemInfoQt;

implementation


{$R *.xfm}

{$IFDEF LINUX}
procedure ReadFileLines(filename:String;dest:TStrings);
var
 f:TextFile;
 astring:String;
begin
 dest.clear;
 if (FileExists(filename)) then
 begin
  try
   AssignFile(f,filename);
   try
    Reset(f);
    while not EOF(f) do
    begin
     ReadLn(f,astring);
     dest.Add(Trim(astring));
    end;
   finally
    CloseFile(f);
   end;
  except
   on E:Exception do
   begin
    dest.Add(E.Message);
   end;
  end;
 end
 else
  dest.Add(filename+' - '+SRpNotFound);
end;
{$ENDIF}

procedure RpShowSystemInfoQt;
var
 dia:TFRpSysInfo;
begin
 dia:=TFRpSysInfo.Create(Application);
 try
  dia.ShowModal;
 finally
  dia.free;
 end;
end;



procedure TFRpSysInfo.FormCreate(Sender: TObject);
begin
 Caption:=TranslateStr(976,Caption);
 BOK.Caption:=SRpOk;
 Lresolution.Font.Style:=[fsBold];
 LCollation.Font.Style:=[fsBold];
 LOemID.Font.Style:=[fsBold];
 LProcessors.Font.Style:=[fsBold];
 LDisplay.Font.Style:=[fsBold];
 LOS.Font.Style:=[fsBold];
 LVersion.Font.Style:=[fsBold];
{$IFDEF MSWINDOWS}
 GLinInfo.Visible:=false;
{$ENDIF}
{$IFDEF LINUX}
 GWinInfo.Visible:=false;
{$ENDIF}
 GSelectedPrinter.Caption:=SRpSelectedPrinter;
 Label2.Caption:=TranslateStr(1061,Label2.Caption);
 Label1.Caption:=TranslateStr(1062,Label1.Caption);
 Label3.Caption:=TranslateStr(1063,Label3.Caption);
 GLinInfo.Caption:=TranslateStr(976,GLinInfo.Caption);
 Label14.Caption:=TranslateStr(1076,Label14.Caption);
 Label10.Caption:=TranslateStr(1077,Label10.Caption);
 Label12.Caption:=TranslateStr(91,Label12.Caption);
 Label11.Caption:=TranslateStr(1078,Label11.Caption);
 Label13.Caption:=TranslateStr(1079,Label13.Caption);
 Label9.Caption:=TranslateStr(1069,Label9.Caption);
 GWinInfo.Caption:=TranslateStr(976,GWinInfo.Caption);

 SetInitialBounds;
end;

procedure TFRpSysInfo.FormShow(Sender: TObject);
var
 abuffer:widestring;
{$IFDEF MSWINDOWS}
 sysinfo:SYSTEM_INFO;
 osinfo:TOsVersionInfo;
{$ENDIF}
begin
 if Printer.Printers.Count>0 then
 begin
  SetLength(abuffer,500);
  QPrinter_printerName(QPrinterH(Printer.Handle),@abuffer);
  EPrinterDevice.Text:=abuffer;
  // If there is no printer selected, selects one
  if Printer.Printers.Count>0 then
  begin
   if Length(EPrinterDevice.Text)<1 then
   begin
    Printer.SetPrinter(Printer.Printers.Strings[0]);
    QPrinter_printerName(QPrinterH(Printer.Handle),@abuffer);
    EPrinterDevice.Text:=abuffer;
   end;
  end;
  EPrinterName.text:=EPrinterDevice.Text;
  LResolution.Caption:=FormatFloat('###,###',Printer.XDPI)+
      ' x '+FormatFloat('###,###',Printer.YDPI);
  // Printer selected not valid error
  if Printer.XDPI=0 then
   EStatus.Text:=SRpSNotAvail
  else
   EStatus.Text:=SRpSReady;
 end;
 LDisplay.Caption:=FormatCurr('##,##',Screen.Width)+
  ' x '+FormatCurr('##,##',Screen.Height)+' '+
   SRpDPIRes+':'+IntToStr(Screen.PixelsPerInch);
{$IFDEF MSWINDOWS}
 GetSystemInfo(sysinfo);
 LOemID.Caption:=IntToStr(sysinfo.dwOemId);
 LProcessors.Caption:=IntToStr(sysinfo.dwNumberOfProcessors);
 osinfo.dwOSVersionInfoSize:=sizeof(osinfo);
 if GetVersionEx(osinfo) then
 begin
  if osinfo.dwPlatformId=VER_PLATFORM_WIN32_NT then
   LOS.Caption:='Windows NT/XP/NET'
  else
   LOS.Caption:='Windows 95/98/ME';
  LVersion.Caption:=IntToStr(osinfo.dwMajorVersion)+
   '.'+IntToStr(osinfo.dwMinorVersion)+' Build:'+IntToStr(osinfo.dwBuildNumber)+
   '-'+StrPas(osinfo.szCSDVersion);
  end;
{$ENDIF}
{$IFDEF LINUX}
 LSysComp.ItemIndex:=0;
 LSysCompClick(Self);
{$ENDIF}
end;

procedure TFRpSysInfo.LSysCompClick(Sender: TObject);
begin
{$IFDEF LINUX}
 if LSysComp.ItemIndex<0 then
  exit;
 ReadFileLines(LFiles.Items.Strings[LSysComp.ItemIndex],ESysInfo.Lines);
{$ENDIF}
end;

end.
