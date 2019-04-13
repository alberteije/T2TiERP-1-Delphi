program Project1;

uses
  QForms,
  Unit1 in 'Unit1.pas' {Form1},
{$IFDEF MSWINDOWS}
  rpruler in '..\..\rpruler.pas',
  rpconsts in '..\..\rpconsts.pas',
  rpmunits in '..\..\rpmunits.pas',
  rptypes in '..\..\rptypes.pas';
{$ENDIF}

{$IFDEF LINUX}
  rpruler in '../../rpruler.pas',
  rpconsts in '../../rpconsts.pas',
  rpmunits in '../../rpmunits.pas',
  rptypes in '../../rptypes.pas';
{$ENDIF}

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
