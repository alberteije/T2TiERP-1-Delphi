library reportman;

uses
  WebBroker,
  ApacheTwoApp,
  rpwebmodule in 'rpwebmodule.pas' {RepWebModule: TWebModule};

{$R *.res}
{$E so}             //change binary file extension from .dll to .so
{$LIBPREFIX 'mod_'} //prefix binary file name with mod_

exports
  apache_module name 'reportman_module';

begin
  Application.Initialize;
  Application.CreateForm(TRepWebModule, RepWebModule);
  Application.Run;
end.
