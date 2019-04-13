program testtwain;

uses
  Forms,
  umain in 'umain.pas' {Form1},
  rptwaincomp in '..\rptwaincomp.pas',
  rpdeltwain in '..\rpdeltwain.pas',
  rpdeltwainfunc in '..\rpdeltwainfunc.pas',
  rpdeltwainutils in '..\rpdeltwainutils.pas',
  rpmdconsts in '..\rpmdconsts.pas',
  GIFImage in '..\repman\gifimage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
