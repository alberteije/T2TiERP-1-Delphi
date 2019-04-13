program Project1;

uses
  QForms,
  Unit1 in 'Unit1.pas' {Form1},
  rpalias in '../../rpalias.pas',
  rptypeval in '../../rptypeval.pas',
  rpconsts in '../../rpconsts.pas',
  rpeval in '../../rpeval.pas',
  rpevalfunc in '../../rpevalfunc.pas',
  rpparser in '../../rpparser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
