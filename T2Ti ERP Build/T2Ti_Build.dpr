program T2Ti_Build;

uses
  Forms,
  UPrincipal in 'UPrincipal.pas' {FPrincipal},
  UMenu in 'UMenu.pas' {FMenu};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFMenu, FMenu);
  Application.Run;
end.
