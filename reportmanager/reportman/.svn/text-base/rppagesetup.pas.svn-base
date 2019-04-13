{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpmpagesetup                                    }
{       Page setup dialog for a report                  }
{       avaliable in runtime and design time            }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rppagesetup;

interface

{$I rpconf.inc}

uses
  SysUtils, Types, Classes,rpmunits,
  QGraphics, QControls, QForms, QDialogs,
  QStdCtrls,rpreport, QExtCtrls,QButtons,QPrinters,
  rptypes,rpbasereport,
  rpmetafile,rpmdconsts,rpmdprintconfig, QComCtrls, QMask, rpmaskeditclx;

type
  TFRpPageSetup = class(TForm)
    ColorDialog1: TColorDialog;
    PControl: TPageControl;
    TabPage: TTabSheet;
    TabPrint: TTabSheet;
    Panel1: TPanel;
    BOK: TButton;
    BCancel: TButton;
    SColor: TShape;
    RPageSize: TRadioGroup;
    GPageSize: TGroupBox;
    ComboPageSize: TComboBox;
    RPageOrientation: TRadioGroup;
    RCustomOrientation: TRadioGroup;
    BBackground: TButton;
    GPageMargins: TGroupBox;
    LLeft: TLabel;
    ELeftMargin: TRpCLXMaskEdit;
    ETopMargin: TRpCLXMaskEdit;
    LTop: TLabel;
    LMetrics3: TLabel;
    LMetrics4: TLabel;
    LMetrics5: TLabel;
    ERightMargin: TRpCLXMaskEdit;
    LRight: TLabel;
    LBottom: TLabel;
    EBottomMargin: TRpCLXMaskEdit;
    LMetrics6: TLabel;
    GUserDefined: TGroupBox;
    LMetrics7: TLabel;
    LMetrics8: TLabel;
    EPageheight: TRpCLXMaskEdit;
    EPageWidth: TRpCLXMaskEdit;
    LWidth: TLabel;
    LHeight: TLabel;
    LSelectPrinter: TLabel;
    ComboSelPrinter: TComboBox;
    BConfigure: TButton;
    CheckTwoPass: TCheckBox;
    CheckPrintOnlyIfData: TCheckBox;
    ECopies: TRpCLXMaskEdit;
    LCopies: TLabel;
    CheckCollate: TCheckBox;
    LPrinterFonts: TLabel;
    ComboPrinterFonts: TComboBox;
    ComboLanguage: TComboBox;
    LRLang: TLabel;
    LPreview: TLabel;
    ComboPreview: TComboBox;
    ComboStyle: TComboBox;
    TabOptions: TTabSheet;
    ComboFormat: TComboBox;
    LPreferedFormat: TLabel;
    CheckDrawerAfter: TCheckBox;
    CheckDrawerBefore: TCheckBox;
    CheckPreviewAbout: TCheckBox;
    CheckMargins: TCheckBox;
    ComboDuplex: TComboBox;
    LDuplex: TLabel;
    LPaperSource: TLabel;
    ComboPaperSource: TComboBox;
    EForceFormName: TRpCLXMaskEdit;
    LForceFormName: TLabel;
    EPaperSource: TRpCLXMaskEdit;
    ELinesPerInch: TRpCLXMaskEdit;
    LLinesPerInch: TLabel;
    CheckDefaultCopies: TCheckBox;
    procedure BCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure SColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BBackgroundClick(Sender: TObject);
    procedure RPageSizeClick(Sender: TObject);
    procedure RPageOrientationClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BConfigureClick(Sender: TObject);
    procedure EPaperSourceChange(Sender: TObject);
    procedure ComboPaperSourceClick(Sender: TObject);
    procedure CheckDefaultCopiesClick(Sender: TObject);
  private
    { Private declarations }
    report:TRpBaseReport;
    dook:boolean;
    oldleftmargin,oldtopmargin,oldrightmargin,oldbottommargin:string;
    oldcustompagewidth,oldcustompageheight:string;
    procedure SaveOptions;
    procedure ReadOptions;
  public
    { Public declarations }
  end;


function ExecutePageSetup(report:TRpBaseReport):boolean;

implementation

{$R *.xfm}




function ExecutePageSetup(report:TRpBaseReport):boolean;
var
 dia:TFRpPageSetup;
begin
 dia:=TFRpPageSetup.Create(Application);
 try
  dia.report:=report;

  dia.ShowModal;
  Result:=dia.dook;
 finally
  dia.free;
 end;
end;

procedure TFRpPageSetup.BCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TFRpPageSetup.FormCreate(Sender: TObject);
var
 astring:widestring;
 awidth:integer;
 aheight:integer;
 i:integer;
begin
 PControl.ActivePage:=TabPage;
 CheckDefaultCopies.Caption:=SRpDefaultCopies;
 LMetrics3.Caption:=rpunitlabels[defaultunit];
 LMetrics4.Caption:=LMetrics3.Caption;
 LMetrics5.Caption:=LMetrics3.Caption;
 LMetrics6.Caption:=LMetrics3.Caption;
 LMetrics7.Caption:=LMetrics3.Caption;
 LMetrics8.Caption:=LMetrics3.Caption;
 GetLanguageDescriptions(ComboLanguage.Items);
 ComboLanguage.Items.Insert(0,TranslateStr(95,'Default'));
 for i:=0 to 148 do
 begin
  astring:=PageSizeNames[i];
  awidth:=Round(PageSizeArray[i].Width/1000*TWIPS_PER_INCHESS);
  aheight:=Round(PageSizeArray[i].Height/1000*TWIPS_PER_INCHESS);
  astring:=astring+' ('+gettextfromtwips(awidth)+'x'+
   gettextfromtwips(aheight)+') '+rpunitlabels[defaultunit];
  ComboPageSize.Items.Add(astring);
 end;
 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
 RPageSize.Items.Strings[0]:=TranslateStr(95,RPageSize.Items.Strings[0]);
 RPageSize.Items.Strings[1]:=TranslateStr(96,RPageSize.Items.Strings[1]);
 RPageSize.Items.Strings[2]:=TranslateStr(732,RPageSize.Items.Strings[2]);
 RPageOrientation.Items.Strings[0]:=TranslateStr(95,RPageOrientation.Items.Strings[0]);
 RPageOrientation.Items.Strings[1]:=TranslateStr(96,RPageOrientation.Items.Strings[1]);
 RPageSize.Caption:=TranslateStr(97,RPageSize.Caption);
 GPageSize.Caption:=TranslateStr(104,GPageSize.Caption);
 GUserDefined.Caption:=TranslateStr(733,GPageSize.Caption);
 LWidth.Caption:=SRpSWidth;
 LHeight.Caption:=SRpSHeight;
 RPageOrientation.Caption:=TranslateStr(98,RPageOrientation.Caption);
 GPageMargins.Caption:=TranslateStr(99,GPagemargins.Caption);
 LLeft.Caption:=TranslateStr(100,LLeft.Caption);
 LRight.Caption:=TranslateStr(101,LRight.Caption);
 LTop.Caption:=TranslateStr(102,LTop.Caption);
 LBottom.Caption:=TranslateStr(103,LBottom.Caption);
 RCustomOrientation.Caption:=TranslateStr(105,RCustomOrientation.Caption);
 RCustomOrientation.Items.Strings[0]:=TranslateStr(106,RCustomOrientation.Items.Strings[0]);
 RCustomOrientation.Items.Strings[1]:=TranslateStr(107,RCustomOrientation.Items.Strings[1]);
 LCopies.Caption:=TranslateStr(108,LCopies.Caption);
 LLinesPerInch.Caption:=TranslateStr(1377,LLinesPerInch.Caption);
 CheckCollate.Caption:=TranslateStr(109,CheckCollate.Caption);
 Caption:=TranslateStr(110,Caption);
 CheckTwoPass.Caption:=TranslateStr(111,CheckTwoPass.Caption);
 CheckPrintOnlyIfData.Caption:=TranslateStr(800,CheckPrintOnlyIfData.Caption);
 LRLang.Caption:=TranslateStr(112,LRLang.Caption);
 LPrinterFonts.Caption:=TranslateStr(113,LPrinterFonts.Caption);
 ComboPrinterFonts.Items.Strings[0]:=TranslateStr(95,ComboPrinterFonts.Items.Strings[0]);
 ComboPrinterFonts.Items.Strings[1]:=TranslateStr(114,ComboPrinterFonts.Items.Strings[1]);
 ComboPrinterFonts.Items.Strings[2]:=TranslateStr(115,ComboPrinterFonts.Items.Strings[2]);
 BBAckground.Caption:=TranslateStr(116,BBAckground.Caption);
 CheckPreviewAbout.Caption:=SRpAboutBoxPreview;
 CheckMargins.Caption:=SRpPreviewMargins;

 with ComboSelPrinter.Items do
 begin
  Add(SRpDefaultPrinter);
  Add(SRpReportPrinter);
  Add(SRpTicketPrinter);
  Add(SRpGraphicprinter);
  Add(SRpCharacterprinter);
  Add(SRpReportPrinter2);
  Add(SRpTicketPrinter2);
  Add(SRpUserPrinter1);
  Add(SRpUserPrinter2);
  Add(SRpUserPrinter3);
  Add(SRpUserPrinter4);
  Add(SRpUserPrinter5);
  Add(SRpUserPrinter6);
  Add(SRpUserPrinter7);
  Add(SRpUserPrinter8);
  Add(SRpUserPrinter9);
  Add(SRpPlainPrinter);
  Add(SRpPlainFullPrinter);
 end;
 LPaperSource.Caption:=SRpPaperSource;
 LForceFormName.Caption:=SRpForceForm;
 LDuplex.Caption:=SRpDuplex;
 LSelectPrinter.Caption:=TranslateStr(741,LSelectPrinter.Caption);
 BConfigure.Caption:=TranslateStr(143,BConfigure.Caption);
 LPreview.Caption:=TranslateStr(840,LPreview.Caption);
 ComboPreview.Items.Strings[0]:=TranslateStr(841,ComboPreview.Items.Strings[0]);
 ComboPreview.Items.Strings[1]:=TranslateStr(842,ComboPreview.Items.Strings[1]);
 ComboStyle.Items.Strings[0]:=TranslateStr(843,ComboStyle.Items.Strings[0]);
 ComboStyle.Items.Strings[1]:=TranslateStr(844,ComboStyle.Items.Strings[1]);
 ComboStyle.Items.Strings[2]:=TranslateStr(845,ComboStyle.Items.Strings[2]);
 TabPage.Caption:=TranslateStr(857,TabPage.Caption);
 TabPrint.Caption:=TranslateStr(858,TabPrint.Caption);
 TabOptions.Caption:=SRpSOptions;
 LPreferedFormat.Caption:=SRpPreferedFormat;
 ComboFormat.Items.Add(SRpStreamZLib);
 ComboFormat.Items.Add(SRpStreamText);
 ComboFormat.Items.Add(SRpStreamBinary);
 ComboFormat.Items.Add(SRpStreamXML);
 ComboFormat.Items.Add(SRpStreamXMLComp);
 CheckDrawerAfter.Caption:=SRpOpenDrawerAfter;
 CheckDrawerBefore.Caption:=SRpOpenDrawerBefore;
 GetPaperSourceDescriptions(ComboPaperSource.Items);
 GetDuplexDescriptions(ComboDuplex.Items);
 
 SetInitialBounds;
end;

procedure TFRpPageSetup.BOKClick(Sender: TObject);
begin
 SaveOptions;
 close;
end;

procedure TFRpPageSetup.SaveOptions;
var
 acopies:integer;
 FReportAction:TRpReportActions;
 linch:Integer;
begin
 linch:=Round(ELinesPerInch.AsFloat*100);
 if ((linch<100) OR (linch>3000)) then
  Raise Exception.Create(SRpSLinesInchError);
 report.LinesPerInch:=linch;
 if CheckDefaultCopies.Checked then
  acopies:=0
 else
 begin
  acopies:=StrToInt(ECopies.Text);
 end;
 if acopies<=0 then
  acopies:=1;
 if acopies<=0 then
  acopies:=1;
 report.Copies:=acopies;
 report.CollateCopies:=CheckCollate.Checked;
 report.TwoPass:=CheckTwoPass.Checked;
 report.PreviewAbout:=CheckPreviewAbout.Checked;
 report.PrintOnlyIfDataAvailable:=CheckPrintOnlyIfData.Checked;
 FReportAction:=[];
 if CheckDrawerAfter.Checked then
  include(FreportAction,rpDrawerAfter);
 if CheckDrawerBefore.Checked then
  include(FreportAction,rpDrawerBefore);
 report.ReportAction:=FReportAction;

 // Saves the options to report
 report.Pagesize:=TRpPageSize(RPageSize.ItemIndex);
  // Assigns the with and height in twips
 report.PagesizeQt:=ComboPageSize.ItemIndex;
 report.PageHeight:=Round(PageSizeArray[report.PageSizeQt].Height*1000/TWIPS_PER_INCHESS);
 report.PageWidth:=Round(PageSizeArray[report.PageSizeQt].Width*1000/TWIPS_PER_INCHESS);
 if EPageWidth.Text<>oldcustompagewidth then
  report.CustomPageWidth:=gettwipsfromtext(EPageWidth.Text);
 if EPageHeight.Text<>oldcustompageheight then
  report.CustomPageHeight:=gettwipsfromtext(EPageHeight.Text);
 if ELeftMargin.Text<>oldleftmargin then
  report.LeftMargin:=gettwipsfromtext(ELeftMargin.Text);
 if ERightMargin.Text<>oldrightmargin then
  report.RightMargin:=gettwipsfromtext(ERightMargin.Text);
 if ETopMargin.Text<>oldtopmargin then
  report.TopMargin:=gettwipsfromtext(ETopMargin.Text);
 if EBottomMargin.Text<>oldbottommargin then
  report.BottomMargin:=gettwipsfromtext(EBottomMargin.Text);
 report.PageOrientation:=rpOrientationDefault;
 report.PrinterSelect:=TRpPrinterSelect(ComboSelPrinter.ItemIndex);
 if RPageOrientation.itemindex=1 then
 begin
  if RCustomOrientation.itemindex=0 then
   report.PageOrientation:=rpOrientationPortrait
  else
   report.PageOrientation:=rpOrientationLandscape;
 end;
 report.PageBackColor:=SColor.Brush.Color;
 // Language
 report.Language:=ComboLanguage.ItemIndex-1;
 // Other
 report.PrinterFonts:=TRpPrinterFontsOption(ComboPrinterFonts.ItemIndex);
 report.PreviewStyle:=TRpPreviewStyle(ComboStyle.ItemIndex);
 report.PreviewMargins:=CheckMargins.Checked;
 report.PreviewWindow:=TRpPreviewWindowStyle(ComboPreview.ItemIndex);
 report.StreamFormat:=TRpStreamFormat(ComboFormat.ItemIndex);
 report.PaperSOurce:=StrToInt(EPaperSource.Text);
 report.Duplex:=ComboDuplex.ItemIndex;
 report.ForcePaperName:=EForceFormName.Text;
end;

procedure TFRpPageSetup.ReadOptions;
begin
 // ReadOptions
 ELinesPerInch.Text:=FloatToStr(report.LinesPerInch/100);
 ECopies.Text:=IntToStr(report.Copies);
 CheckCollate.Checked:=report.CollateCopies;
 CheckTwoPass.Checked:=report.TwoPass;
 CheckPrintOnlyIfData.Checked:=report.PrintOnlyIfDataAvailable;
 CheckDrawerBefore.Checked:=rpDrawerBefore in report.ReportAction;
 CheckDrawerAfter.Checked:=rpDrawerAfter in report.ReportAction;
 CheckPreviewAbout.Checked:=report.PreviewAbout;

 // Size
 ComboPageSize.ItemIndex:=report.PagesizeQt;
 GPageSize.Visible:=false;
 RPageSize.ItemIndex:=0;
 ELeftMargin.Text:=gettextfromtwips(report.LeftMargin);
 ERightMargin.Text:=gettextfromtwips(report.RightMargin);
 ETopMargin.Text:=gettextfromtwips(report.TopMargin);
 EBottomMargin.Text:=gettextfromtwips(report.BottomMargin);
 EPageWidth.Text:=gettextfromtwips(report.CustomPageWidth);
 EPageHeight.Text:=gettextfromtwips(report.CustomPageheight);
 oldcustompagewidth:=EPageWidth.Text;
 oldcustompageheight:=EPageheight.Text;
 oldleftmargin:=ELeftMargin.Text;
 oldrightmargin:=ERightMargin.Text;
 oldTopmargin:=ETopMargin.Text;
 oldBottommargin:=EBottomMargin.Text;

 RPageSize.ItemIndex:=integer(report.Pagesize);
 RPageSizeClick(Self);
 // Orientation
 RPageOrientation.Itemindex:=0;
 RCustomOrientation.Itemindex:=0;
 RCustomOrientation.Visible:=false;
 if report.PageOrientation>rpOrientationdefault then
 begin
  RCustomOrientation.Visible:=true;
  RPageOrientation.itemindex:=1;
 end;
 if report.PageOrientation=rpOrientationPortrait then
  RCustomOrientation.Itemindex:=0;
 if report.PageOrientation=rpOrientationLandscape then
  RCustomOrientation.Itemindex:=1;
 ComboSelPrinter.ItemIndex:=integer(report.PrinterSelect);
 // Color
 SColor.Brush.Color:=TColor(report.PageBackColor);
 // Language
 ComboLanguage.ItemIndex:=0;
 ComboPrinterFonts.ItemIndex:=integer(report.PrinterFonts);
 if (report.Language+1)<ComboLanguage.Items.Count then
  ComboLanguage.ItemIndex:=report.Language+1;
 ComboStyle.ItemIndex:=integer(report.PreviewStyle);
 ComboPreview.ItemIndex:=integer(report.PreviewWindow);
 ComboFormat.ItemIndex:=integer(report.StreamFormat);
 CheckMargins.Checked:=report.PreviewMargins;
 EPaperSource.Text:=IntToStr(report.PaperSource);
 EPaperSourceChange(Self);
 ComboDuplex.ItemIndex:=report.Duplex;
 EForceFormName.Text:=report.ForcePaperName;
end;

procedure TFRpPageSetup.SColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 BBackgroundClick(Self);
end;

procedure TFRpPageSetup.BBackgroundClick(Sender: TObject);
begin
 if ColorDialog1.Execute then
  SColor.Brush.Color:=ColorDialog1.Color;
end;

procedure TFRpPageSetup.RPageSizeClick(Sender: TObject);
begin
 GPageSize.Visible:=RPageSize.Itemindex=1;
 GUserDefined.Visible:=RPageSize.Itemindex=2;
end;

procedure TFRpPageSetup.RPageOrientationClick(Sender: TObject);
begin
 RCustomOrientation.Visible:=RPageOrientation.Itemindex=1;
end;

procedure TFRpPageSetup.FormShow(Sender: TObject);
begin
 ReadOptions;
end;

procedure TFRpPageSetup.BConfigureClick(Sender: TObject);
begin
 ShowPrintersConfiguration;
end;



procedure TFRpPageSetup.EPaperSourceChange(Sender: TObject);
var
 index:integer;
begin
 try
  index:=StrToInt(EPaperSource.Text);
 except
  index:=-1;
 end;
 if index<0 then
  index:=-1;
 if (index<ComboPaperSource.Items.Count) then
 begin
  CombopaperSource.ItemIndex:=index;
 end;
end;

procedure TFRpPageSetup.ComboPaperSourceClick(Sender: TObject);
begin
 EPaperSource.Text:=IntToStr(ComboPaperSource.ItemIndex);
end;

procedure TFRpPageSetup.CheckDefaultCopiesClick(Sender: TObject);
begin
 ECopies.Enabled:=not CheckDefaultCopies.Checked;

end;

end.
