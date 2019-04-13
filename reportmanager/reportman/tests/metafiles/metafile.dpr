program metafile;

uses
  QForms,
  princi in 'princi.pas' {Form1},
  rpmetafile in '..\..\rpmetafile.pas',
  rpprintitem in '..\..\rpprintitem.pas',
  rpreport in '..\..\rpreport.pas',
  rpgdidriver in '..\..\rpgdidriver.pas',
  rptypes in '..\..\rptypes.pas',
  rpsubreport in '..\..\rpsubreport.pas',
  rpsecutil in '..\..\rpsecutil.pas',
  rpsection in '..\..\rpsection.pas',
  rpconsts in '..\..\rpconsts.pas',
  rpqtdriver in '..\..\rpqtdriver.pas',
  rpmunits in '..\..\rpmunits.pas',
  rpruler in '..\..\rpruler.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
