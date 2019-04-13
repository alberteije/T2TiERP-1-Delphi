program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  rpvclreport in '..\..\rpvclreport.pas',
  rpactivexreport in '..\..\rpactivexreport.pas',
  rpcompobase in '..\..\rpcompobase.pas',
  rpmdconsts in '..\..\rpmdconsts.pas';
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
