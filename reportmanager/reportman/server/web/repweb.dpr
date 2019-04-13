library repweb;

uses
  WebBroker,
  ApacheApp,
  rpwebmodule in 'rpwebmodule.pas' {repwebmod: TWebModule},
  rpwebpages in 'rpwebpages.pas';

{$R *.res}

{$E *.so}

exports
  apache_module name 'repweb_module';

begin
  Application.Initialize;
  Application.CreateForm(Trepwebmod, repwebmod);
  Application.Run;
end.
