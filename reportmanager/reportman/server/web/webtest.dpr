program webtest;

{$APPTYPE GUI}

uses
  Forms,
  SockApp,
  rpwebform in 'rpwebform.pas' {FRpWebForm},
  rpwebmodule in 'rpwebmodule.pas' {RepWebModule: TWebModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TRepWebModule, RepWebModule);
  Application.CreateForm(TFRpWebForm, FRpWebForm);
  Application.Run;
end.
