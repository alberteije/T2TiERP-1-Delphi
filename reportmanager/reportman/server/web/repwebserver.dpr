library repwebserver;

{$I rpconf.inc}

uses
  ActiveX,
  ComObj,
{$IFDEF MSWINDOWS}
  midaslib,
{$ENDIF}
  WebBroker,
  ISAPIThreadPool,
  ISAPIApp,
  rpwebmodule in 'rpwebmodule.pas' {repwebmod: TWebModule},
  rpwebpages in 'rpwebpages.pas';

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.CreateForm(Trepwebmod, repwebmod);
  Application.Run;
end.
