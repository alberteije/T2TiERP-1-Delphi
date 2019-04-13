library reportmanapi;

// Report Manager standard C API
// This file is for Linux, the
// library for Windows is
// ReportMan.ocx
// This library does not depend
// on X Server running but can not
// print, only generate pdfs o metafiles
// you can use reportmanapiqt for print and preview

{$I rpconf.inc}

uses
  ShareExcept,
  SysUtils,
  Classes,
  rpdllutil in '../rpdllutil.pas',
  rpmdconsts in '../rpmdconsts.pas',
  rppdfdriver in '../rppdfdriver.pas';

{$E so}

exports
 rp_open,
 rp_new,
 rp_execute,
 rp_close,
 rp_lasterror,
 rp_executeremote,
 rp_executeremote_report,
 rp_getremoteparams,
 rp_setparamvalue,
 rp_getparamname,
 rp_getparamcount;

begin
 // We want to map Linux Signals to Kylix Exceptions, so
 // we call HookSignal to hook all the default signals.  HookSignal(RTL_SIGDEFAULT);   // Install the Exit handler.  DLLProc := @DLLHandler;
end.



