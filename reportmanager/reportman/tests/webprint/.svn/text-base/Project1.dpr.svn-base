program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  rpwebmetaclient in '..\..\rpwebmetaclient.pas',
  rpfmetaviewvcl in '..\..\rpfmetaviewvcl.pas' {FRpMetaVCL},
  rpfmainmetaviewvcl in '..\..\rpfmainmetaviewvcl.pas' {FRpMainMetaVCL},
  Project1_TLB in 'Project1_TLB.pas',
  WebReportManX_TLB in 'WebReportManX_TLB.pas';

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFRpMainMetaVCL, FRpMainMetaVCL);
  Application.Run;
end.
