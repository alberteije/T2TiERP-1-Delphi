program repmandnet;

{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\system.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\system.data.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\system.drawing.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\system.xml.dll'}

uses
  System.Reflection,
  System.Runtime.CompilerServices,
  SysUtils,
  Forms,
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
  rpmdfsectionintvcl in '..\rpmdfsectionintvcl.pas',
  rptextdriver in '..\rptextdriver.pas',
  rpactivexreport in '..\rpactivexreport.pas',
  rpalias in '..\rpalias.pas',
  rpdatatext in '..\rpdatatext.pas',
  rpcompobase in '..\rpcompobase.pas',
  rpdatainfo in '..\rpdatainfo.pas',
  rpdataset in '..\rpdataset.pas',
  rpdbxconfigvcl in '..\rpdbxconfigvcl.pas' {FRpDBXConfigVCL},
  rpdbbrowservcl in '..\rpdbbrowservcl.pas' {FRpBrowserVCL},
  rpdrawitem in '..\rpdrawitem.pas' {rpdrawitem.TRpShape: rpprintitem.TRpCommonPosComponent},
  rpeval in '..\rpeval.pas',
  rpevalfunc in '..\rpevalfunc.pas',
  rpgdidriver in '..\rpgdidriver.pas' {FRpVCLProgress},
  rpexceldriver in '..\rpexceldriver.pas' {FRpExcelProgress},
  rpgdifonts in '..\rpgdifonts.pas',
  rplabelitem in '..\rplabelitem.pas',
  rplastsav in '..\rplastsav.pas',
  rpmdbarcode in '..\rpmdbarcode.pas',
  rpmdchart in '..\rpmdchart.pas',
  rpmdconsts in '..\rpmdconsts.pas',
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
  rpmetafile in '..\rpmetafile.pas' {rpmetafile.TRpMetafileReport: System.ComponentModel.Component},
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
  rpsection in '..\rpsection.pas' {rpsection.TRpSection: rpprintitem.TRpCommonComponent},
  rpsecutil in '..\rpsecutil.pas',
  rpsubreport in '..\rpsubreport.pas',
  rptranslator in '..\rptranslator.pas',
  rptypes in '..\rptypes.pas',
  rptypeval in '..\rptypeval.pas',
  rpvclreport in '..\rpvclreport.pas',
  rpvgraphutils in '..\rpvgraphutils.pas',
  rpvpreview in '..\rpvpreview.pas' {FRpVPreview},
  rpmdfconnectionvcl in '..\rpmdfconnectionvcl.pas' {FRpConnectionVCL: TFrame},
  rpmdfwizardvcl in '..\rpmdfwizardvcl.pas' {FRpWizardVCL},
  rpmdfextsecvcl in '..\rpmdfextsecvcl.pas' {FRpExtSectionVCL},
  rpmdfdatasetsvcl in '..\rpmdfdatasetsvcl.pas' {FRpDatasetsVCL: TFrame},
  rpfmetaviewvcl in '..\rpfmetaviewvcl.pas' {FRpMetaVCL},
  rpfmainmetaviewvcl in '..\rpfmainmetaviewvcl.pas' {FRpMainMetaVCL},
  rpmdsysinfo in '..\rpmdsysinfo.pas' {FRpSysInfo},
  rpeditconnvcl in '..\rpeditconnvcl.pas' {FRpEditConVCL},
  rpmdftreevcl in '..\rpmdftreevcl.pas' {FRpDBTreeVCL: TFrame},
  rpmdfopenlibvcl in '..\rpmdfopenlibvcl.pas' {FRpOpenLibVCL};

{$REGION 'Program/Assembly Information'}
//
// General Information about an assembly is controlled through the following
// set of attributes. Change these attribute values to modify the information
// associated with an assembly.
//
[assembly: AssemblyTitle('')]
[assembly: AssemblyDescription('')]
[assembly: AssemblyConfiguration('')]
[assembly: AssemblyCompany('')]
[assembly: AssemblyProduct('')]
[assembly: AssemblyCopyright('')]
[assembly: AssemblyTrademark('')]
[assembly: AssemblyCulture('')]

//
// Version information for an assembly consists of the following four values:
//
//      Major Version
//      Minor Version 
//      Build Number
//      Revision
//
// You can specify all the values or you can default the Revision and Build Numbers 
// by using the '*' as shown below:

[assembly: AssemblyVersion('1.0.*')]

//
// In order to sign your assembly you must specify a key to use. Refer to the 
// Microsoft .NET Framework documentation for more information on assembly signing.
//
// Use the attributes below to control which key is used for signing. 
//
// Notes: 
//   (*) If no key is specified, the assembly is not signed.
//   (*) KeyName refers to a key that has been installed in the Crypto Service
//       Provider (CSP) on your machine. KeyFile refers to a file which contains
//       a key.
//   (*) If the KeyFile and the KeyName values are both specified, the 
//       following processing occurs:
//       (1) If the KeyName can be found in the CSP, that key is used.
//       (2) If the KeyName does not exist and the KeyFile does exist, the key 
//           in the KeyFile is installed into the CSP and used.
//   (*) In order to create a KeyFile, you can use the sn.exe (Strong Name) utility.
//       When specifying the KeyFile, the location of the KeyFile should be
//       relative to the project output directory which is
//       Project Directory\bin\<configuration>. For example, if your KeyFile is
//       located in the project directory, you would specify the AssemblyKeyFile 
//       attribute as [assembly: AssemblyKeyFile('..\\..\\mykey.snk')]
//   (*) Delay Signing is an advanced option - see the Microsoft .NET Framework
//       documentation for more information on this.
//
[assembly: AssemblyDelaySign(false)]
[assembly: AssemblyKeyFile('')]
[assembly: AssemblyKeyName('')]
{$ENDREGION}

[STAThread]
begin
  Application.Initialize;
  Application.CreateForm(TFRpMainFVCL, FRpMainFVCL);
  Application.Run;
end.
