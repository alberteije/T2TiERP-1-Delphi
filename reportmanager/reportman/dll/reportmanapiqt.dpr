library reportmanapiqt;

// Report Manager standard C API
// This file is for Linux, the
// library for Windows is
// ReportMan.ocx
// This library depend
// on X Server running but can
// print and preview, if you need only generate pdfs or metafiles
// you can use reportmanapi lib

{$I rpconf.inc}
{$E so}

uses
  rpnotlibrary in 'rpnotlibrary.pas',
  SysUtils,
  Classes,
  rpdllutil in '../rpdllutil.pas',
  rpmdconsts in '../rpmdconsts.pas',
  rppdfdriver in '../rppdfdriver.pas',
  rpdllutilqt in '../rpdllutilqt.pas',
  rpqtdriver in '../rpqtdriver.pas' {FRpQtProgress},
  QForms;

exports
 rp_open,
 rp_new,
 rp_execute,
 rp_executeremote,
 rp_executeremote_report,
 rp_close,
 rp_lasterror,
 rp_setparamvalue,
 rp_getparamname,
 rp_getparamcount,
 rp_print,
 rp_preview,
 rp_previewremote_report,
 rp_previewremote,
 rp_printremote,
 rp_bitmap,
 rp_printremote_report;


type
 Tobjexp=class(TObject)
  public
   procedure OnException(Sender: TObject; E: Exception);
  end;

procedure Tobjexp.OnException(Sender: TObject; E: Exception);
begin
 WriteLn(E.Message);
 Raise E;
end;

var
 objexp:TObjExp;

begin
 // We want to map Linux Signals to Kylix Exceptions, so
 // we call HookSignal to hook all the default signals.  HookSignal(RTL_SIGDEFAULT);   // Install the Exit handler.  DLLProc := @DLLHandler;
 objexp:=TObjExp.Create;
 Application.OnException:=objexp.OnException;
end.


