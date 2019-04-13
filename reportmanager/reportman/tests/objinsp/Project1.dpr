program Project1;

uses
  QForms,
  Unit1 in 'Unit1.pas' {Form1},
{$IFDEF MSWINDOWS}
  rpobjinsp in '..\..\repman\rpobjinsp.pas' {FObjInsp: TFrame},
  rpconsts in '..\..\rpconsts.pas',
  rpobinsint in '..\..\repman\rpobinsint.pas',
  rpprintitem in '..\..\rpprintitem.pas',
  rpmetafile in '..\..\rpmetafile.pas',
  rpmunits in '..\..\rpmunits.pas',
  rpqtdriver in '..\..\rpqtdriver.pas',
  rptypes in '..\..\rptypes.pas',
  rpsection in '..\..\rpsection.pas';
{$ENDIF}

{$IFDEF LINUX}
  rpobjinsp in '../../repman/rpobjinsp.pas' {FObjInsp: TFrame},
  rpconsts in '../../rpconsts.pas',
  rpobinsint in '../../repman/rpobinsint.pas',
  rpprintitem in '../../rpprintitem.pas',
  rpmetafile in '../../rpmetafile.pas',
  rpmunits in '../../rpmunits.pas',
  rpqtdriver in '../../rpqtdriver.pas',
  rptypes in '../../rptypes.pas',
  rpsection in '../../rpsection.pas';
{$ENDIF}

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
