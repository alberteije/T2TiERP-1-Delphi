{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       repmandxp                                       }
{       Main form of report manager designer            }
{       Used by a subreport                             }
{                                                       }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

program repmandxp;

{$I rpconf.inc}

uses
  Graphics,
  Forms,
  Controls,
  Dialogs,
  ActiveX,
  SysUtils,
  rpmdfmainvcl in '..\rpmdfmainvcl.pas' {FRpMainFVCL},
  rpmdfdesignvcl in '..\rpmdfdesignvcl.pas' {FRpDesignFrameVCL: TFrame},
  rpmdfaboutvcl in '..\rpmdfaboutvcl.pas' {FRpAboutBoxVCL},
  rpmdfstrucvcl in '..\rpmdfstrucvcl.pas' {FRpStructureVCL: TFrame},
  rpmdobjinspvcl in '..\rpmdobjinspvcl.pas' {FRpObjInspVCL: TFrame},
  rppagesetupvcl in '..\rppagesetupvcl.pas' {FRpPageSetupVCL},
  rpfparamsvcl in '..\rpfparamsvcl.pas' {FRpParamsVCL},
  rpgraphutilsvcl in '..\rpgraphutilsvcl.pas' {FRpMessageDlgVCL},
  rpexpredlgvcl in '..\rpexpredlgvcl.pas' {FRpExpredialogVCL},
  rprfvparams in '..\rprfvparams.pas' {FRpRTParams},
  rpmdfsearchvcl in '..\rpmdfsearchvcl.pas' {TFRpSearchParamVCL},
  rpmdfsectionintvcl in '..\rpmdfsectionintvcl.pas',
  rptextdriver in '..\rptextdriver.pas',
  rpxmlstream in '..\rpxmlstream.pas',
  rpcolumnar in '..\rpcolumnar.pas',
  rpstringhash in '..\rpstringhash.pas',
  rpcomparable in '..\rpcomparable.pas',
  rphashtable in '..\rphashtable.pas',
  rpactivexreport in '..\rpactivexreport.pas',
  rpalias in '..\rpalias.pas',
  rpdatatext in '..\rpdatatext.pas',
  rpcompobase in '..\rpcompobase.pas',
  rpdatainfo in '..\rpdatainfo.pas',
  rpdataset in '..\rpdataset.pas',
  rpdbxconfigvcl in '..\rpdbxconfigvcl.pas' {FRpDBXConfigVCL},
  rpdbbrowservcl in '..\rpdbbrowservcl.pas' {FRpBrowserVCL},
  rpdrawitem in '..\rpdrawitem.pas',
  rpeval in '..\rpeval.pas',
  rpevalfunc in '..\rpevalfunc.pas',
  rpgdidriver in '..\rpgdidriver.pas' {FRpVCLProgress},
  rpexceldriver in '..\rpexceldriver.pas' {FRpExcelProgress},
  rpcsvdriver in '..\rpcsvdriver.pas',
  rpgdifonts in '..\rpgdifonts.pas',
  rplabelitem in '..\rplabelitem.pas',
  rplastsav in '..\rplastsav.pas',
  rpmaskedit in '..\rpmaskedit.pas',
  rpmdbarcode in '..\rpmdbarcode.pas',
  rpbarcodecons in '..\rpbarcodecons.pas',
  rpmdchart in '..\rpmdchart.pas',
  rpmdcharttypes in '..\rpmdcharttypes.pas',
  rpmdconsts in '..\rpmdconsts.pas',
  rpcompilerep in '..\rpcompilerep.pas',
  rpmdfbarcodeintvcl in '..\rpmdfbarcodeintvcl.pas',
  rpmdfchartintvcl in '..\rpmdfchartintvcl.pas',
  rpmdfdatatextvcl in '..\rpmdfdatatextvcl.pas' {FRpDataTextVCL},
  rpmdfdinfovcl in '..\rpmdfdinfovcl.pas' {FRpDInfoVCL},
  rpmdfdrawintvcl in '..\rpmdfdrawintvcl.pas',
  rpmdfgridvcl in '..\rpmdfgridvcl.pas' {FRpGridOptionsVCL},
  rpmdflabelintvcl in '..\rpmdflabelintvcl.pas',
  rpmdfsampledatavcl in '..\rpmdfsampledatavcl.pas' {FRpShowSampledataVCL},
  rpmdobinsintvcl in '..\rpmdobinsintvcl.pas',
  rpmdprintconfigvcl in '..\rpmdprintconfigvcl.pas' {FRpPrinterConfigVCL},
  rpmdshfolder in '..\rpmdshfolder.pas',
  rpmetafile in '..\rpmetafile.pas',
  rpmunits in '..\rpmunits.pas',
  rpparams in '..\rpparams.pas',
  rpparser in '..\rpparser.pas',
  rppdfdriver in '..\rppdfdriver.pas',
  rppdffile in '..\rppdffile.pas',
  rppdfreport in '..\rppdfreport.pas',
  rpprintitem in '..\rpprintitem.pas',
  rpregvcl in '..\rpregvcl.pas',
  rpreport in '..\rpreport.pas',
  rpbasereport in '..\rpbasereport.pas',
  rprulervcl in '..\rprulervcl.pas',
  rpsection in '..\rpsection.pas',
  rpsecutil in '..\rpsecutil.pas',
  rpsubreport in '..\rpsubreport.pas',
  rptranslator in '..\rptranslator.pas',
  rptypes in '..\rptypes.pas',
  rptypeval in '..\rptypeval.pas',
  rpvclreport in '..\rpvclreport.pas',
  rpvgraphutils in '..\rpvgraphutils.pas',
  rpvpreview in '..\rpvpreview.pas' {FRpVPreview},
  rpwriter in '..\rpwriter.pas',
  rphtmldriver in '..\rphtmldriver.pas',
  rpmdfconnectionvcl in '..\rpmdfconnectionvcl.pas' {FRpConnectionVCL: TFrame},
  rpmdfwizardvcl in '..\rpmdfwizardvcl.pas' {FRpWizardVCL},
  rpmdfextsecvcl in '..\rpmdfextsecvcl.pas' {FRpExtSectionVCL},
  rpmdfdatasetsvcl in '..\rpmdfdatasetsvcl.pas' {FRpDatasetsVCL: TFrame},
  rpfmetaviewvcl in '..\rpfmetaviewvcl.pas' {FRpMetaVCL},
  rpfmainmetaviewvcl in '..\rpfmainmetaviewvcl.pas' {FRpMainMetaVCL},
  rpmdsysinfo in '..\rpmdsysinfo.pas' {FRpSysInfo},
  rpeditconnvcl in '..\rpeditconnvcl.pas' {FRpEditConVCL},
  rpmdftreevcl in '..\rpmdftreevcl.pas' {FRpDBTreeVCL: TFrame},
  rpmdfopenlibvcl in '..\rpmdfopenlibvcl.pas' {FRpOpenLibVCL},
  rpsvgdriver in '..\rpsvgdriver.pas',
  rpinfoprovgdi in '..\rpinfoprovgdi.pas',
  rpinfoprovid in '..\rpinfoprovid.pas',
  rpdatetimepicker in '..\rpdatetimepicker.pas',
  rppreviewcontrol in '..\rppreviewcontrol.pas',
  rppreviewmeta in '..\rppreviewmeta.pas';

{$R *.res}

// Para corregir el bud en adodb
// ADODB in '..\ADOBUG\ADODB.pas'

begin
{$IFDEF DELPHI2007UP}
 UseLatestCommonDialogs:=true;
{$ENDIF}
  with Application do
  begin
   Title:=TranslateStr(1,Title);
  end;
  CoInitialize(nil);

  Application.Initialize;
  Application.CreateForm(TFRpMainFVCL, FRpMainFVCL);
  FRpMainFVCL.Font.Assign(Screen.IconFont);
  FRpMainFVCL.BrowseCommandLine:=true;

  Application.Run;

end.
