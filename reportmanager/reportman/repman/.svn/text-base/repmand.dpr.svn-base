{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       Repmand                                         }
{       Report manager designer executable              }
{       allow to design, print, preview reports         }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

program repmand;

{%ToDo 'repmand.todo'}
{%File '..\rpconf.inc'}

{$I rpconf.inc}

uses
 QForms,
{$IFDEF MSWINDOWS}
  midaslib,ActiveX,
// QThemed fails in dbgrid, combobox field, disabled
//  QThemed in 'QThemed.pas',
  rpmdfmain in '..\rpmdfmain.pas' {FRpMainF},
  rpmdfstruc in '..\rpmdfstruc.pas' {FRpStructure: TFrame},
  rpmdfdesign in '..\rpmdfdesign.pas' {FRpDesignFrame: TFrame},
  rpmdshfolder in '..\rpmdshfolder.pas',
  rpmdfsampledata in '..\rpmdfsampledata.pas' {FRpShowSampledata},
  rpmdobinsint in '..\rpmdobinsint.pas',
  rpmdfdrawint in '..\rpmdfdrawint.pas',
  rptextdriver in '..\rptextdriver.pas',
  rpcsvdriver in '..\rpcsvdriver.pas',
  rphtmldriver in '..\rphtmldriver.pas',
  rpmdobjinsp in '..\rpmdobjinsp.pas' {FRpObjInsp: TFrame},
  rpmdfgrid in '..\rpmdfgrid.pas' {FRpGridOptions},
  rpmdflabelint in '..\rpmdflabelint.pas',
  rpmdfbarcodeint in '..\rpmdfbarcodeint.pas',
  rpinfoprovid in '..\rpinfoprovid.pas',
  rpmdfchartint in '..\rpmdfchartint.pas',
  rpmdfabout in '..\rpmdfabout.pas' {FRpAboutBox},
  rppdfreport in '..\rppdfreport.pas',
  rpmaskeditclx in '..\rpmaskeditclx.pas',
  rpfmetaview in '..\rpfmetaview.pas' {FRpMeta},
  rpfmainmetaview in '..\rpfmainmetaview.pas' {FRpMainMeta},
  rpmdfsearch in '..\rpmdfsearch.pas' {FRpSearchParam},
{$IFDEF VCLANDCLX}
  rpfmainmetaviewvcl in '..\rpfmainmetaviewvcl.pas' {FRpMainMetaVCL},
  rpvgraphutils in '..\rpvgraphutils.pas',
  rpvpreview in '..\rpvpreview.pas' {FRpVPreview},
  rpgdidriver in '..\rpgdidriver.pas' {FRpVCLProgress},
  rpfmetaviewvcl in '..\rpfmetaviewvcl.pas' {FRpMetaVCL},
  rpmdfsearchvcl in '..\rpmdfsearchvcl.pas' {FRpSearchParamVCL},
  rpvclreport in '..\rpvclreport.pas',
  rprfvparams in '..\rprfvparams.pas' {FRpRTParams},
  rppagesetupvcl in '..\rppagesetupvcl.pas' {FRpPageSetupVCL},
  rpfparamsvcl in '..\rpfparamsvcl.pas' {FRpParamsVCL},
  rpinfoprovgdi in '..\rpinfoprovgdi.pas',
  rpmdfgridvcl in '..\rpmdfgridvcl.pas' {FRpGridOptionsVCL},
  rpmdprintconfigvcl in '..\rpmdprintconfigvcl.pas' {FRpPrinterConfigVCL},
{$ENDIF}
  rpdbbrowser in '..\rpdbbrowser.pas' {FRpBrowser},
  rpgdifonts in '..\rpgdifonts.pas',
  rpreport in '..\rpreport.pas',
  rpbasereport in '..\rpbasereport.pas',
  rpsubreport in '..\rpsubreport.pas',
  rpmdconsts in '..\rpmdconsts.pas',
  rppagesetup in '..\rppagesetup.pas' {FRpPageSetup},
  rpmunits in '..\rpmunits.pas',
  rptypes in '..\rptypes.pas',
  rpdataset in '..\rpdataset.pas',
  rpsection in '..\rpsection.pas',
  rpsecutil in '..\rpsecutil.pas',
  rplastsav in '..\rplastsav.pas',
  rpprintitem in '..\rpprintitem.pas',
  rpparser in '..\rpparser.pas',
  rpevalfunc in '..\rpevalfunc.pas',
  rpeval in '..\rpeval.pas',
  rpalias in '..\rpalias.pas',
  rpexpredlg in '..\rpexpredlg.pas' {FrpExpredialog},
  rpmetafile in '..\rpmetafile.pas',
  rpqtdriver in '..\rpqtdriver.pas' {FRpQtProgress},
  rppreview in '..\rppreview.pas' {FRpPreview},
  rpmdfdinfo in '..\rpmdfdinfo.pas' {TFRpDInfo},
  rpprintdia in '..\rpprintdia.pas' {FRpPrintDialog},
  rprfparams in '..\rprfparams.pas' {FRpRunTimeParams},
  rpmdfhelpform in '..\rpmdfhelpform.pas' {FRpHelpForm},
  rpfparams in '..\rpfparams.pas' {FRpParams},
  rpmdprintconfig in '..\rpmdprintconfig.pas' {FRpPrinterConfig},
  rpmdfconnection in '..\rpmdfconnection.pas' {FRpConnection: TFrame},
  rpmdfdatasets in '..\rpmdfdatasets.pas' {FRpDatasets: TFrame},
  rpmdfdatatext in '..\rpmdfdatatext.pas' {FRpDataText},
  rpruler in '..\rpruler.pas',
  rptypeval in '..\rptypeval.pas',
  rpwriter in '..\rpwriter.pas',
  rpdatainfo in '..\rpdatainfo.pas',
  rpparams in '..\rpparams.pas',
  rpmdfsectionint in '..\rpmdfsectionint.pas',
  rpdbxconfig in '..\rpdbxconfig.pas' {FRpDBXConfig},
  rpgraphutils in '..\rpgraphutils.pas' {FRpMessageDlg},
  rpmdfextsec in '..\rpmdfextsec.pas' {TFRpExtSection},
  rplabelitem in '..\rplabelitem.pas',
  rpmdbarcode in '..\rpmdbarcode.pas',
  rpmdchart in '..\rpmdchart.pas',
  rpdrawitem in '..\rpdrawitem.pas',
  rpmzlib in '..\rpmzlib.pas',
  rpzlibadler in '..\rpzlibadler.pas',
  rpzlibinfblock in '..\rpzlibinfblock.pas',
  rpzlibinfcodes in '..\rpzlibinfcodes.pas',
  rpzlibinffast in '..\rpzlibinffast.pas',
  rpzlibinftrees in '..\rpzlibinftrees.pas',
  rpzlibinfutil in '..\rpzlibinfutil.pas',
  rpzlibtrees in '..\rpzlibtrees.pas',
  rpzlibzdeflate in '..\rpzlibzdeflate.pas',
  rpzlibzinflate in '..\rpzlibzinflate.pas',
  rpzlibzlib in '..\rpzlibzlib.pas',
  rpzlibzutil in '..\rpzlibzutil.pas',
  rpcompobase in '..\rpcompobase.pas',
  rptranslator in '..\rptranslator.pas',
  rpclxreport in '..\rpclxreport.pas',
  rppdffile in '..\rppdffile.pas',
  rpmdesigner in '..\rpmdesigner.pas',
  rpmdsysinfoqt in '..\rpmdsysinfoqt.pas' {FRpSysInfo},
  rpeditconn in '..\rpeditconn.pas' {FRpEditCon},
  rpmdftree in '..\rpmdftree.pas' {FRpDBTree},
  rpmdfopenlib in '..\rpmdfopenlib.pas' {FRpOpenLib},
  rppdfdriver in '..\rppdfdriver.pas';
{$ENDIF}


{$IFDEF LINUX}
  LibcExec in 'LibcExec.pas',
  rpmdfmain in '../rpmdfmain.pas' {FRpMainF},
  rpmdfstruc in '../rpmdfstruc.pas' {FRpStructure: TFrame},
  rpmdfdesign in '../rpmdfdesign.pas' {FRpDesignFrame: TFrame},
  rpmdshfolder in '../rpmdshfolder.pas',
  rpmdfsampledata in '../rpmdfsampledata.pas' {FRpShowSampledata},
  rpmdobinsint in '../rpmdobinsint.pas',
  rpmdfdrawint in '../rpmdfdrawint.pas',
  rptextdriver in '../rptextdriver.pas',
  rpcsvdriver in '../rpcsvdriver.pas',
  rphtmldriver in '../rphtmldriver.pas',
  rpmdobjinsp in '../rpmdobjinsp.pas' {FRpObjInsp: TFrame},
  rpmdfgrid in '../rpmdfgrid.pas' {FRpGridOptions},
  rpmdflabelint in '../rpmdflabelint.pas',
  rpmdfbarcodeint in '../rpmdfbarcodeint.pas',
  rpmdfchartint in '../rpmdfchartint.pas',
  rpmdfabout in '../rpmdfabout.pas' {FRpAboutBox},
  rpmdfhelpform in '../rpmdfhelpform.pas' {FRpHelpForm},
  rppdfreport in '../rppdfreport.pas',
  rpmaskeditclx in '../rpmaskeditclx.pas',
  rpreport in '../rpreport.pas',
  rpbasereport in '../rpbasereport.pas',
  rpsubreport in '../rpsubreport.pas',
  rpmdconsts in '../rpmdconsts.pas',
  rppagesetup in '../rppagesetup.pas' {FRpPageSetup},
  rpmdfsearch in '../rpmdfsearch.pas' {FRpSearchParam},
  rpmunits in '../rpmunits.pas',
  rptypes in '../rptypes.pas',
  rpdataset in '../rpdataset.pas',
  rpsection in '../rpsection.pas',
  rpsecutil in '../rpsecutil.pas',
  rplastsav in '../rplastsav.pas',
  rpprintitem in '../rpprintitem.pas',
  rpparser in '../rpparser.pas',
  rpevalfunc in '../rpevalfunc.pas',
  rpeval in '../rpeval.pas',
  rpalias in '../rpalias.pas',
  rpexpredlg in '../rpexpredlg.pas' {FrpExpredialog},
  rpfmetaview in '../rpfmetaview.pas' {FRpMeta},
  rpfmainmetaview in '../rpfmainmetaview.pas' {FRpMainMeta},
  rpmetafile in '../rpmetafile.pas',
  rpqtdriver in '../rpqtdriver.pas' {FRpQtProgress},
  rpmdfconnection in '../rpmdfconnection.pas' {FRpConnection: TFrame},
  rpmdfdatasets in '../rpmdfdatasets.pas' {FRpDatasets: TFrame},
  rpmdfdatatext in '../rpmdfdatatext.pas' {FRpDataText},
  rpruler in '../rpruler.pas',
  rptypeval in '../rptypeval.pas',
  rpwriter in '../rpwriter.pas',
  rpdatainfo in '../rpdatainfo.pas',
  rpparams in '../rpparams.pas',
  rpmdfsectionint in '../rpmdfsectionint.pas',
  rpfparams in '../rpfparams.pas' {FRpParams},
  rpdbxconfig in '../rpdbxconfig.pas' {FRpDBXConfig},
  rpgraphutils in '../rpgraphutils.pas' {FRpMessageDlg},
  rpmdfextsec in '../rpmdfextsec.pas' {TFRpExtSection},
  rpprintdia in '../rpprintdia.pas' {FRpPrintDialog},
  rplabelitem in '../rplabelitem.pas',
  rpmdbarcode in '../rpmdbarcode.pas',
  rpmdchart in '../rpmdchart.pas',
  rpdrawitem in '../rpdrawitem.pas',
  rpmzlib in '../rpmzlib.pas',
  rppreview in '../rppreview.pas' {FRpPreview},
  rpmdfdinfo in '../rpmdfdinfo.pas' {TFRpDInfo},
  rprfparams in '../rprfparams.pas' {FRpRunTimeParams},
  rpdbbrowser in '../rpdbbrowser.pas' {FRpBrowser},
  rpzlibadler in '../rpzlibadler.pas',
  rpzlibinfblock in '../rpzlibinfblock.pas',
  rpzlibinfcodes in '../rpzlibinfcodes.pas',
  rpzlibinffast in '../rpzlibinffast.pas',
  rpzlibinftrees in '../rpzlibinftrees.pas',
  rpzlibinfutil in '../rpzlibinfutil.pas',
  rpzlibtrees in '../rpzlibtrees.pas',
  rpzlibzdeflate in '../rpzlibzdeflate.pas',
  rpzlibzinflate in '../rpzlibzinflate.pas',
  rpzlibzlib in '../rpzlibzlib.pas',
  rpzlibzutil in '../rpzlibzutil.pas',
  rpcompobase in '../rpcompobase.pas',
  rptranslator in '../rptranslator.pas',
  rpclxreport in '../rpclxreport.pas',
  rpinfoprovid in '../rpinfoprovid.pas',
  rpinfoprovft in '../rpinfoprovft.pas',
  rppdffile in '../rppdffile.pas',
  rppdfdriver in '../rppdfdriver.pas',
  rpmdesigner in '../rpmdesigner.pas',
  rpmdsysinfoqt in '../rpmdsysinfoqt.pas' {FRpSysInfo},
  rpeditconn in '../rpeditconn.pas' {FRpEditCon},
  rpmdftree in '../rpmdftree.pas' {FRpDBTree},
  rpmdfopenlib in '../rpmdfopenlib.pas' {FRpOpenLib},
  rpmdprintconfig in '../rpmdprintconfig.pas' {FRpPrinterConfig};
{$ENDIF}



{$R *.res}

var
  FRpMainF: TFRpMainF;

begin
  with Application do
  begin
   Title:=TranslateStr(1,Title);
  end;
  Application.Initialize;
{$IFDEF MSWINDOWS}
  CoInitialize(nil);
{$ENDIF}
  Application.CreateForm(TFRpMainF, FRpMainF);
  FRpMainF.BrowseCommandLine:=true;
  LoadQtTranslator;
  Application.Run;
end.
