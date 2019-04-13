program metaview;

{%File '..\..\..\rpconf.inc'}

uses
  QForms,
{$IFDEF MSWINDOWS}
  QThemed in '..\..\QThemed.pas',
  QThemeSrv in '..\..\QThemeSrv.pas',
  TmSchema in '..\..\TmSchema.pas',
  rpfmainmetaview in '..\..\..\rpfmainmetaview.pas' {FRpMainMeta},
  rpmetafile in '..\..\..\rpmetafile.pas',
  rpprintdia in '..\..\..\rpprintdia.pas' {FRpPrintDialog},
  rpqtdriver in '..\..\..\rpqtdriver.pas' {TFRpQtProgress},
  rppdfdriver in '..\..\..\rppdfdriver.pas',
  rpmdconsts in '..\..\..\rpmdconsts.pas',
  rpmdrepclient in '..\..\..\rpmdrepclient.pas',
  rpmdprotocol in '..\..\..\rpmdprotocol.pas',
  rpmdclitree in '..\..\..\rpmdclitree.pas' {FRpCliTree: TFrame},
  rpgraphutils in '..\..\..\rpgraphutils.pas' {FRpMessageDlg},
  rpgdidriver in '..\..\..\rpgdidriver.pas' {FRpVCLProgress},
  rpmdfabout in '..\..\..\rpmdfabout.pas' {FRpAboutBox},
  rprfparams in '..\..\..\rprfparams.pas' {FRpRunTimeParams},
  rpmdprintconfig in '..\..\..\rpmdprintconfig.pas' {FRpPrinterConfig};
{$ENDIF}
{$IFDEF LINUX}
  LibcExec in '../../LibcExec.pas',
  rpfmainmetaview in '../../../rpfmainmetaview.pas' {FRpMainMeta},
  rpmetafile in '../../../rpmetafile.pas',
  rpprintdia in '../../../rpprintdia.pas' {FRpPrintDialog},
  rppdfdriver in '../../../rppdfdriver.pas',
  rpqtdriver in '../../../rpqtdriver.pas' {TFRpQtProgress},
  rpmdconsts in '../../../rpmdconsts.pas',
  rpmdrepclient in '../../../rpmdrepclient.pas',
  rpmdprotocol in '../../../rpmdprotocol.pas',
  rpmdclitree in '../../../rpmdclitree.pas' {FRpCliTree: TFrame},
  rpgraphutils in '../../../rpgraphutils.pas' {FRpMessageDlg},
  rpmdfabout in '../../../rpmdfabout.pas' {FRpAboutBox},
  rprfparams in '../../../rprfparams.pas' {FRpRunTimeParams},
  rpmdprintconfig in '../../../rpmdprintconfig.pas' {FRpPrinterConfig};
{$ENDIF}

{$R *.res}

begin
  with Application do
  begin
   Title:=SRpRepMetafile;
  end;
  Application.Initialize;
  Application.CreateForm(TFRpMainMeta, FRpMainMeta);
  FRpMainMeta.Browsecommandline:=true;
  Application.Run;
end.
