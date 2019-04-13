program repwebexex;

{$APPTYPE CONSOLE}

uses
  WebBroker,
  CGIApp,
{$IFDEF MSWINDOWS}
  midaslib,
{$ENDIF}
  rpwebmodule in 'rpwebmodule.pas' {repwebmod: TWebModule},
  rpwebpages in 'rpwebpages.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Trepwebmod, repwebmod);
  Application.Run;
end.
