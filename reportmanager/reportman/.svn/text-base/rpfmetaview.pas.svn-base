{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpfMetaview                                     }
{       TFRpMeta                                        }
{       A form to view, print and export                }
{        report metafiles                               }
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

unit rpfmetaview;

interface

{$I rpconf.inc}

uses
  SysUtils,Inifiles,
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
{$IFDEF VCLANDCLX}
  rpgdidriver,Dialogs,
{$ENDIF}
{$IFDEF LINUX}
  Libc,
{$ENDIF}
  Qt,Types, Classes, QGraphics, QControls, QForms,rpgraphutils,
  QStdCtrls,rpmetafile, QComCtrls,rpqtdriver, QExtCtrls,rpmdclitree,
  QActnList, QImgList,QPrinters,rpmdconsts,rptypes, QMenus,
  rpmdfabout,QTypes,QStyle,rpmdshfolder,rpmdprintconfig,rptextdriver,
  rphtmldriver,rpsvgdriver,rpcsvdriver,rppreviewmetaclx,
  rpmdfhelpform, QDialogs,rpprintdia,rppdfdriver, QMask, rpmaskeditclx;

type
  TFRpMeta = class(TFrame)
    BToolBar: TToolBar;
    ImageList1: TImageList;
    ActionList1: TActionList;
    AFirst: TAction;
    APrevious: TAction;
    ANext: TAction;
    ALast: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    EPageNum: TRpCLXMaskEdit;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    APrint: TAction;
    ToolButton6: TToolButton;
    ASave: TAction;
    ToolButton7: TToolButton;
    OpenDialog1: TOpenDialog;
    AOpen: TAction;
    ToolButton8: TToolButton;
    BCancel: TButton;
    AExit: TAction;
    AScale100: TAction;
    AScaleWide: TAction;
    AScaleFull: TAction;
    AScaleLess: TAction;
    AScaleMore: TAction;
    BExit: TToolButton;
    SaveDialog1: TSaveDialog;
    ToolButton5: TToolButton;
    ToolButton9: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Page1: TMenuItem;
    Firstpage1: TMenuItem;
    Print1: TMenuItem;
    Nextpage1: TMenuItem;
    Lastpage1: TMenuItem;
    View1: TMenuItem;
    Normalscale1: TMenuItem;
    Normalscale2: TMenuItem;
    Scaletowindow1: TMenuItem;
    N2: TMenuItem;
    Print2: TMenuItem;
    ACancel: TAction;
    Splitter1: TSplitter;
    MHelp: TMenuItem;
    AAbout: TAction;
    MAbout: TMenuItem;
    AViewConnect: TAction;
    ReportConnection1: TMenuItem;
    MPreferences: TMenuItem;
    MQtStyle: TMenuItem;
    AStatusBar: TAction;
    BStatus: TStatusBar;
    ASystemPrintDialog: TAction;
    Windows1: TMenuItem;
    Motif1: TMenuItem;
    MotifPlus1: TMenuItem;
    CDE1: TMenuItem;
    QtSGI1: TMenuItem;
    Platinum1: TMenuItem;
    MQtDefault: TMenuItem;
    ADriverQt: TAction;
    ADriverGDI: TAction;
    MDriverSelect: TMenuItem;
    WindowsGDIDriver1: TMenuItem;
    QtDriver1: TMenuItem;
    ADocumentation: TAction;
    StatusBar1: TMenuItem;
    QtSystemPrintDialog1: TMenuItem;
    MDoc: TMenuItem;
    APrintSetup: TAction;
    PrinterSetup1: TMenuItem;
    MSelectPrinter: TMenuItem;
    MSelPrinter0: TMenuItem;
    MSelPrinter1: TMenuItem;
    MSelPrinter2: TMenuItem;
    MSelPrinter3: TMenuItem;
    MSelPrinter4: TMenuItem;
    MSelPrinter5: TMenuItem;
    MSelPrinter6: TMenuItem;
    MSelPrinter7: TMenuItem;
    MSelPrinter8: TMenuItem;
    MSelPrinter9: TMenuItem;
    MSelPrinter10: TMenuItem;
    MSelPrinter11: TMenuItem;
    MSelPrinter12: TMenuItem;
    MSelPrinter13: TMenuItem;
    MSelPrinter14: TMenuItem;
    MSelPrinter15: TMenuItem;
    APrintersConfiguration: TAction;
    PrintersConfiguration1: TMenuItem;
    AAsyncExec: TAction;
    Asynchronousexecution1: TMenuItem;
    BConfig: TToolButton;
    MPrintMenu: TPopupMenu;
    PrinterSetup2: TMenuItem;
    PrintersConfiguration2: TMenuItem;
    MSelectPrinter2: TMenuItem;
    MSelPrinter20: TMenuItem;
    MSelPrinter21: TMenuItem;
    MSelPrinter22: TMenuItem;
    MSelPrinter23: TMenuItem;
    MSelPrinter26: TMenuItem;
    MSelPrinter25: TMenuItem;
    MSelPrinter27: TMenuItem;
    MSelPrinter28: TMenuItem;
    MSelPrinter29: TMenuItem;
    MSelPrinter210: TMenuItem;
    MSelPrinter211: TMenuItem;
    MSelPrinter212: TMenuItem;
    MSelPrinter213: TMenuItem;
    MSelPrinter214: TMenuItem;
    MSelPrinter215: TMenuItem;
    MSelPrinter24: TMenuItem;
    AMailTo: TAction;
    Mailto1: TMenuItem;
    ToolButton10: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    PPBar: TPanel;
    PBar: TProgressBar;
    MEntireMenu: TPopupMenu;
    MEntire1: TMenuItem;
    MEntire2: TMenuItem;
    MEntire3: TMenuItem;
    MEntire4: TMenuItem;
    MEntire6: TMenuItem;
    MEntire8: TMenuItem;
    MEntire9: TMenuItem;
    MEntire10: TMenuItem;
    MEntire12: TMenuItem;
    MEntire15: TMenuItem;
    MEntire16: TMenuItem;
    MEntire18: TMenuItem;
    MEntire20: TMenuItem;
    MEntire24: TMenuItem;
    MEntire30: TMenuItem;
    MEntire48: TMenuItem;
    MLeftRight: TMenuItem;
    ESearch: TEdit;
    ToolButton17: TToolButton;
    AFind: TAction;
    ToolButton18: TToolButton;
    procedure AFirstExecute(Sender: TObject);
    procedure ANextExecute(Sender: TObject);
    procedure APreviousExecute(Sender: TObject);
    procedure ALastExecute(Sender: TObject);
    procedure EPageNumKeyPress(Sender: TObject; var Key: Char);
    procedure APrintExecute(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure AOpenExecute(Sender: TObject);
    procedure AExitExecute(Sender: TObject);
    procedure AScale100Execute(Sender: TObject);
    procedure AScaleWideExecute(Sender: TObject);
    procedure AScaleFullExecute(Sender: TObject);
    procedure AScaleMoreExecute(Sender: TObject);
    procedure AScaleLessExecute(Sender: TObject);
    procedure ACancelExecute(Sender: TObject);
    procedure AAboutExecute(Sender: TObject);
    procedure AViewConnectExecute(Sender: TObject);
    procedure AStatusBarExecute(Sender: TObject);
    procedure Windows1Click(Sender: TObject);
    procedure ADocumentationExecute(Sender: TObject);
    procedure ASystemPrintDialogExecute(Sender: TObject);
    procedure ADriverQtExecute(Sender: TObject);
    procedure ADriverGDIExecute(Sender: TObject);
    procedure APrintSetupExecute(Sender: TObject);
    procedure APrintersConfigurationExecute(Sender: TObject);
    procedure MSelPrinter0Click(Sender: TObject);
    procedure AAsyncExecExecute(Sender: TObject);
    procedure FrameMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FrameMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure BConfigClick(Sender: TObject);
    procedure AMailToExecute(Sender: TObject);
    procedure MEntire1Click(Sender: TObject);
    procedure MLeftRightClick(Sender: TObject);
    procedure ESearchChange(Sender: TObject);
    procedure AFindExecute(Sender: TObject);
    procedure ESearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fmetafile,fintmetafile:TRpMetafileReport;
    fhelp:TFRpHelpform;
    cancelled:boolean;
    oldonHint:TNotifyEvent;
    FPreviewControl:TRpPreviewmetaCLX;
    AppStyle:TDefaultStyle;
    configfile:string;
    textchanged:boolean;
{$IFDEF LINUX}
    usekprinter:boolean;
{$ENDIF}
    faform:TForm;
    procedure SetForm(Value:TForm);
    procedure EnableButtons;
    procedure DisableButtons;
    procedure ExecuteServer(Sender:TObject);
    procedure AppHint(Sender:TObject);
    procedure LoadConfig;
    procedure SaveConfig;
    procedure UpdateStyle;
    procedure ShowHelp(AURL:string);
    procedure OnProgress(Sender:TObject;records,pagecount:integer;var docancel:boolean);
    procedure WorkAsyncError(amessage:String);
    procedure SetMetafile(avalue:TRpMetafileReport);
    procedure OnPageDrawn(prm:TRpPreviewMetaCLX);
  public
    { Public declarations }
    clitree:TFRpCliTree;
    printerindex:TRpPrinterSelect;
    aqtdriver:TRpPrintDriver;
    setmenu:boolean;
    ShowPrintDialog:Boolean;
    procedure FindNext;
    procedure DoOpen(afilename:String);
    procedure UpdatePrintSel;
    property aform:TForm read faform write SetForm;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    property PreviewControl:TRpPreviewmetaCLX read fpreviewcontrol;
    property metafile:TRpMetafileReport read fmetafile write SetMetafile;
  end;

var
 FRpMeta:TFRpMeta;


implementation


{$R *.xfm}


procedure TFRpMeta.SetForm(Value:TForm);
begin
 faform:=Value;

 if assigned(faform) then
 begin
  faform.OnKeyDown:=FormKeyDown;
  if setmenu then
   faform.Menu:=MainMenu1;
 end;
end;


constructor TFRpMeta.Create(AOwner:TComponent);
var
 inif:TInifile;
begin
 inherited Create(AOwner);
 inif:=TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
 try
  MDoc.Visible:=inif.ReadBool('CONFIG','ShowAboutBox',true);
  MAbout.Visible:=inif.ReadBool('CONFIG','ShowDocumentation',true);
  MHelp.Visible:=MDoc.Visible or MAbout.Visible;
 finally
  inif.free;
 end;
 FPreviewControl:=TRpPreviewmetaCLX.Create(Self);
 FpreviewControl.Width:=643;
 FpreviewControl.Height:=0;
 FpreviewControl.Align:=alClient;
 FpreviewControl.Parent:=Self;
 FPreviewControl.OnPageDrawn:=OnPageDrawn;

{$IFDEF LINUX}
 usekprinter:=GetEnvironmentVariable('REPMANUSEKPRINTER')='true';
{$ENDIF}

 ShowPrintDialog:=true;
 setmenu:=true;
 MSelectPrinter.Caption:=TranslateStr(741,MSelectPrinter.Caption);
 MSelPrinter0.Caption:=SRpDefaultPrinter;
 MSelPrinter1.Caption:=SRpReportPrinter;
 MSelPrinter2.Caption:=SRpTicketPrinter;
 MSelPrinter3.Caption:=SRpGraphicprinter;
 MSelPrinter4.Caption:=SRpCharacterprinter;
 MSelPrinter5.Caption:=SRpReportPrinter2;
 MSelPrinter6.Caption:=SRpTicketPrinter2;
 MSelPrinter7.Caption:=SRpUserPrinter1;
 MSelPrinter8.Caption:=SRpUserPrinter2;
 MSelPrinter9.Caption:=SRpUserPrinter3;
 MSelPrinter10.Caption:=SRpUserPrinter4;
 MSelPrinter11.Caption:=SRpUserPrinter5;
 MSelPrinter12.Caption:=SRpUserPrinter6;
 MSelPrinter13.Caption:=SRpUserPrinter7;
 MSelPrinter14.Caption:=SRpUserPrinter8;
 MSelPrinter15.Caption:=SRpUserPrinter9;

 MSelectPrinter2.Caption:=TranslateStr(741,MSelectPrinter.Caption);
 MSelPrinter20.Caption:=SRpDefaultPrinter;
 MSelPrinter21.Caption:=SRpReportPrinter;
 MSelPrinter22.Caption:=SRpTicketPrinter;
 MSelPrinter23.Caption:=SRpGraphicprinter;
 MSelPrinter24.Caption:=SRpCharacterprinter;
 MSelPrinter25.Caption:=SRpReportPrinter2;
 MSelPrinter26.Caption:=SRpTicketPrinter2;
 MSelPrinter27.Caption:=SRpUserPrinter1;
 MSelPrinter28.Caption:=SRpUserPrinter2;
 MSelPrinter29.Caption:=SRpUserPrinter3;
 MSelPrinter210.Caption:=SRpUserPrinter4;
 MSelPrinter211.Caption:=SRpUserPrinter5;
 MSelPrinter212.Caption:=SRpUserPrinter6;
 MSelPrinter213.Caption:=SRpUserPrinter7;
 MSelPrinter214.Caption:=SRpUserPrinter8;
 MSelPrinter215.Caption:=SRpUserPrinter9;
 BConfig.Hint:=TranslateStr(57,APrintSetup.Hint);

{$IFDEF VCLANDCLX}
  // Visible driver selection
  MDriverSelect.Visible:=true;
{$ENDIF}
 configfile:=Obtainininameuserconfig('','','repmand');
{$IFDEF VCLFILEFILTERS}
 SaveDialog1.Filter:=SRpRepMetafile+'|*.rpmf|'+
   SRpPDFFile+'|*.pdf|'+
   SRpPDFFileUn+'|*.pdf|'+
   SRpPlainFile+'|*.txt|'+
   SRpBitmapFile+'|*.bmp|'+
   SRpHtmlFile+'|*.html|'+
   SRpHtmlFileSingle+'|*.html|'+
   SRpSVGFile+'|*.svg|'+
   SRpCSVFile+'|*.csv|'+
   SRpTXTProFile+'|*.txt';
{$IFDEF MSWINDOWS}
 SaveDialog1.Filter:=SaveDialog1.Filter+'|'+SRpExeMetafile+'|*.exe';
{$ENDIF}
 OpenDialog1.Filter:=SRpRepMetafile+'|*.rpmf';
{$ENDIF}
{$IFNDEF VCLFILEFILTERS}
 SaveDialog1.Filter:=SRpRepMetafile+' (*.rpmf)|'+
   SRpPDFFile+' (*.pdf)|'+
   SRpPDFFileUn+' (*.pdf)|'+
   SRpPlainFile+' (*.txt)|'+
   SRpBitmapFile+' (*.bmp)|'+
   SRpHtmlFile+' (*.html)|'+
   SRpHtmlFileSingle+' (*.html)'+
   SRpSVGFile+' (*.svg)|'+
   SRpCSVFile+' (*.csv)|'+
   SRpTXTProFile+' (*.txt)';
{$IFDEF MSWINDOWS}
  SaveDialog1.Filter:=SaveDialog1.Filter+'|'+SRpExeMetafile+' (*.exe)';
{$ENDIF}
 OpenDialog1.Filter:=SRpRepMetafile+' (*.rpmf)';
{$ENDIF}
 AppStyle:=dsSystemDefault;
 clitree:=TFRpCliTree.Create(Self);
 clitree.Align:=alLeft;
 clitree.Parent:=Self;
 clitree.OnExecuteServer:=ExecuteServer;
 MHelp.Caption:=TranslateStr(6,MHelp.Caption);
 AAbout.Caption:=TranslateStr(58,AAbout.Caption);
 AAbout.Hint:=TranslateStr(59,AABout.Hint);
 Caption:=SRpRepMetafile;
 SaveDialog1.Title:=TranslateStr(216,SaveDialog1.Title);
 ACancel.Caption:=TranslateStr(94,ACancel.Caption);
 ACancel.Hint:=TranslateStr(218,ACancel.Hint);
 APrint.Caption:=TranslateStr(52,APrint.Caption);
 APrint.Hint:=TranslateStr(53,APrint.Hint);
 APrintersConfiguration.Caption:=TranslateStr(742,APrintersConfiguration.Caption);
 ASave.Caption:=TranslateStr(46,ASave.Caption);
 ASave.Hint:=TranslateStr(217,ASave.Hint);
 AMailTo.Caption:=TranslateStr(1230,AMailTo.Caption);
 AMailTo.Hint:=TranslateStr(1231,AMailTo.Hint);
 AExit.Caption:=TranslateStr(44,AExit.Caption);
 AExit.Hint:=TranslateStr(219,AExit.Hint);
 AFirst.Caption:=TranslateStr(220,AFirst.Caption);
 AFirst.Hint:=TranslateStr(221,AFirst.Hint);
 APrevious.Caption:=TranslateStr(222,APrevious.Caption);
 APrevious.Hint:=TranslateStr(223,APrevious.Hint);
 ANext.Caption:=TranslateStr(224,ANext.Caption);
 ANext.Hint:=TranslateStr(225,ANext.Hint);
 ALast.Caption:=TranslateStr(226,ALast.Caption);
 ALast.Hint:=TranslateStr(227,ALast.Hint);
 AScale100.Caption:=TranslateStr(228,AScale100.Caption);
 AScale100.Hint:=TranslateStr(229,AScale100.Hint);
 AScaleWide.Caption:=TranslateStr(230,AScaleWide.Caption);
 AScaleWide.Hint:=TranslateStr(231,AScaleWide.Hint);
 AScaleFull.Caption:=TranslateStr(232,AScaleFull.Caption);
 AScaleFull.Hint:=TranslateStr(233,AScaleFull.Hint);
 AScaleLess.Caption:=TranslateStr(234,AScaleLess.Caption);
 AScaleLess.Hint:=TranslateStr(235,AScaleLess.Hint);
 AScaleMore.Caption:=TranslateStr(236,AScaleMore.Caption);
 AScaleMore.Hint:=TranslateStr(237,AScaleMore.Hint);
 AViewConnect.Caption:=TranslateStr(781,AViewConnect.Caption);
 AViewConnect.Hint:=TranslateStr(781,AViewConnect.Hint);
 APrintSetup.Caption:=TranslateStr(56,APrintSetup.Caption);
 APrintSetup.Hint:=TranslateStr(57,APrintSetup.Hint);
 ADocumentation.Caption:=TranslateStr(60,ADocumentation.Caption);
 ADocumentation.Hint:=TranslateStr(61,ADocumentation.Hint);
 MDriverSelect.Caption:=TranslateStr(67,MDriverSelect.Caption);
 ADriverQt.Caption:=TranslateStr(68,ADriverQt.Caption);
 ADriverQt.Hint:=TranslateStr(69,ADriverQt.Hint);
 ADriverGDI.Caption:=TranslateStr(70,ADriverGDI.Caption);
 ADriverGDI.Hint:=TranslateStr(71,ADriverGDI.Hint);
 AAsyncExec.Caption:=TranslateStr(783,AASyncExec.Caption);
 AAsyncExec.Hint:=TranslateStr(784,AAsyncExec.Hint);


 File1.Caption:=TranslateStr(0,File1.Caption);
 Page1.Caption:=TranslateStr(269,Page1.Caption);
 View1.Caption:=TranslateStr(740,View1.Caption);
 OpenDialog1.Title:=File1.Caption;

 AOpen.Caption:=TranslateStr(42,AOpen.Caption);
 AOpen.Hint:=TranslateStr(739,AOpen.Hint);

 AStatusBar.Caption:=TranslateStr(76,AStatusBar.Caption);
 AStatusBar.Hint:=TranslateStr(77,AStatusBar.Hint);
 MPreferences.Caption:=TranslateStr(5,MPreferences.Caption);
 ASystemPrintDialog.Caption:=TranslateStr(72,ASystemPrintDialog.Caption);
 ASystemPrintDialog.Hint:=TranslateStr(73,ASystemPrintDialog.Hint);
 MQtStyle.Caption:=TranslateStr(78,MQtStyle.Caption);
 MQtStyle.Hint:=TranslateStr(79,MQtStyle.Hint);
 MQtDefault.Caption:=TranslateStr(80,MQtDefault.Caption);


 APrevious.ShortCut:=Key_PageUp;
 ANext.ShortCut:=Key_PageDown;
 AFirst.ShortCut:=Key_Home;
 ALast.ShortCut:=Key_End;

 fmetafile:=TRpMetafileReport.Create(nil);
 fintmetafile:=fmetafile;
 fmetafile.OnWorkProgress:=OnProgress;
 fmetafile.OnWorkAsyncError:=WorkAsyncError;

 // Activates OnHint
 oldonhint:=Application.OnHint;
 Application.OnHint:=AppHint;

 SaveDialog1.FilterIndex:=2;

 LoadConfig;
end;



procedure TFRpMeta.ShowHelp(AURL:string);
begin
 if Not Assigned(FHelp) then
  FHelp:=TFRpHelpform.Create(Application);
 FHelp.TextBrowser1.FileName:=AURL;
 FHelp.Show;
 if Length(FHelp.TextBrowser1.Text)<1 then
 begin
  FHelp.TextBrowser1.Text:=SRpDocNotInstalled+#10+
   SRpDocNotInstalled2+#10+
   SRpDocNotInstalled3+#10;
 end;
end;

procedure TFRpMeta.UpdateStyle;
var
 i:integer;
 aitem:TMenuItem;
begin
 Application.Style.DefaultStyle:=AppStyle;
 for i:=0 to MQtStyle.Count-1 do
 begin
  aitem:=MQtStyle.Items[i];
  aitem.Checked:=(aitem.Tag=Integer(Application.Style.DefaultStyle));
 end;
end;

procedure TFRpMeta.AppHint(Sender:TObject);
begin
 BStatus.Panels.Items[0].Text:=Application.Hint;
end;


procedure TFRpMeta.AFirstExecute(Sender: TObject);
begin
 fpreviewcontrol.FirstPage;
end;

procedure TFRpMeta.ANextExecute(Sender: TObject);
begin
 fpreviewcontrol.NextPage;
end;

procedure TFRpMeta.APreviousExecute(Sender: TObject);
begin
 fpreviewcontrol.PriorPage;
end;

procedure TFRpMeta.ALastExecute(Sender: TObject);
begin
 fpreviewcontrol.LastPage;
end;

procedure TFRpMeta.EPageNumKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=chr(13) then
 begin
  fpreviewcontrol.Page:=StrToInt(EPageNum.Text)-1;
 end;
end;

destructor TFRpMeta.Destroy;
begin
 cancelled:=true;
 SaveConfig;
 Application.OnHint:=oldonhint;
 fintmetafile.free;

 inherited Destroy;
end;

procedure TFRpMeta.APrintExecute(Sender: TObject);
var
 frompage,topage,copies:integer;
 allpages,collate:boolean;
 rpPageSize:TPageSizeQt;
 selectedok:boolean;
begin
 // Prints the report
{$IFDEF LINUX}
 if usekprinter then
 begin
   // Use kprinter to print the file
   PrintMetafileUsingKPrinter(metafile);
 end
 else
{$ENDIF}
 begin
 frompage:=1;
 topage:=999999;
 allpages:=true;
 collate:=false;
 copies:=1;
 rppagesize.papersource:=metafile.PaperSource;
 rppagesize.duplex:=metafile.duplex;
 rpPageSize.Custom:=metafile.PageSize<0;
 rpPageSize.Indexqt:=metafile.PageSize;
 rpPageSize.CustomWidth:=metafile.CustomX;
 rpPageSize.CustomHeight:=metafile.CustomY;
{$IFDEF VCLANDCLX}
 if ADriverGDI.Checked then
 begin
  allpages:=true;
  frompage:=1; topage:=999999;
  copies:=1;
  rpgdidriver.PrinterSelection(printerindex,metafile.PaperSource,metafile.Duplex);
  rpgdidriver.PageSizeSelection(rpPageSize);
  rpgdidriver.OrientationSelection(metafile.orientation);
  selectedok:=true;
  if ShowPrintDialog then
   selectedok:=rpgdidriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
  if selectedok then
   rpgdidriver.PrintMetafile(metafile,opendialog1.FileName,true,allpages,
    frompage,topage,copies,collate,GetDeviceFontsOption(printerindex),printerindex);
  exit;
 end;
{$ENDIF}
 rpqtdriver.PrinterSelection(printerindex);
 rpqtdriver.PageSizeSelection(rpPageSize);
 rpqtdriver.OrientationSelection(metafile.orientation);
 selectedok:=true;
 if ShowPrintDialog then
 begin
  if Not ASystemPrintDialog.Checked then
  begin
   selectedok:=rpprintdia.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
  end
  else
  begin
   selectedok:=rpqtdriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
  end;
 end;
 if selectedok then
  rpqtdriver.PrintMetafile(metafile,opendialog1.FileName,true,allpages,
    frompage,topage,copies,collate,printerindex);
 end;
end;

procedure TFRpMeta.ASaveExecute(Sender: TObject);
var
 abitmap:TBitmap;
 mono:Boolean;
 horzres,vertres:Integer;
begin
 cancelled:=false;
 // Saves the metafile
 if SaveDialog1.Execute then
 begin
  DisableButtons;
  try
   Metafile.SaveToFile(SaveDialog1.Filename);
   case SaveDialog1.FilterIndex of
    1:
     begin
      Metafile.SaveToFile(SaveDialog1.Filename)
     end;
    2,3:
     begin
      if SaveDialog1.FilterIndex=2 then
       SaveMetafileToPDF(metafile,SaveDialog1.filename,true)
      else
       SaveMetafileToPDF(metafile,SaveDialog1.filename,false);
     end;
    5:
     begin
      horzres:=100;
      vertres:=100;
      mono:=true;
      if AskBitmapProps(horzres,vertres,mono) then
      begin
       ALastExecute(Self);
       abitmap:=MetafileToBitmap(Metafile,true,mono,horzres,vertres);
       try
        if assigned(abitmap) then
         abitmap.SaveToFile(SaveDialog1.FileName);
       finally
        abitmap.free;
       end;
      end;
     end;
    6:
     begin
      ExportMetafileToHtml(Metafile,Caption,SaveDialog1.FileName,
       true,true,1,9999);
     end;
    7:
     begin
       ExportMetafileToHtmlSingle(Metafile,Caption,SaveDialog1.FileName);
     end;
    8:
     begin
      ExportMetafileToSVG(Metafile,Caption,SaveDialog1.FileName,
       true,true,1,9999);
     end;
    9:
     begin
      ExportMetafileToCSV(metafile,SaveDialog1.Filename,true,true,
       1,MAX_PAGECOUNT,',');
     end;
    10:
     begin
      ExportMetafileToTextPro(metafile,SaveDialog1.Filename,true,true,
       1,9999);
     end;
{$IFDEF MSWINDOWS}
    11:
     begin
      MetafileToExe(metafile,SaveDialog1.Filename);
     end;
{$ENDIF}
    else
    begin
     // Plain text file
     ALastExecute(Self);
     SaveMetafileToTextFile(Metafile,SaveDialog1.FileName);
    end;
   end;
 finally
   EnableButtons;
  end;
 end;
end;

procedure TFRpMeta.DoOpen(afilename:String);
begin
 metafile.LoadFromFile(afilename);
 ASave.Enabled:=True;
 AMailTo.Enabled:=true;
 APrint.Enabled:=True;
 AFirst.Enabled:=True;
 APrevious.Enabled:=True;
 ANext.Enabled:=True;
 ALast.Enabled:=True;
 FPreviewControl.Metafile:=nil;
 FPreviewControl.Metafile:=metafile;
end;

procedure TFRpMeta.AOpenExecute(Sender: TObject);
begin
 DisableButtons;
 try
  cancelled:=false;
  if OpenDialog1.Execute then
  begin
   DoOpen(OpenDialog1.Filename);
  end;
 finally
  EnableButtons;
 end;
end;

procedure TFRpMeta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 increment:integer;
begin
 if (ssShift in Shift) then
  increment:=REP_C_WHEELINC
 else
  increment:=REP_C_WHEELINC*REP_C_WHEELSCALE;
 if Key=KEY_DOWN then
  FPreviewControl.Scroll(true,increment);
 if Key=KEY_UP then
  FPreviewControl.Scroll(true,-increment);
 if Key=KEY_RIGHT then
  FPreviewControl.Scroll(false,increment);
 if Key=KEY_LEFT then
  FPreviewControl.Scroll(false,-increment);
end;




procedure TFRpMeta.EnableButtons;
begin
 AFirst.Enabled:=true;
 ANext.Enabled:=true;
 APrevious.Enabled:=true;
 ALast.Enabled:=true;
 ASave.Enabled:=true;
 AMailTo.Enabled:=true;
 AOpen.Enabled:=true;
 APrint.Enabled:=true;
 BCancel.Visible:=false;
 PPBar.Visible:=false;
end;

procedure TFRpMeta.DisableButtons;
begin
 AFirst.Enabled:=false;
 ANext.Enabled:=false;
 APrevious.Enabled:=false;
 ALast.Enabled:=false;
 ASave.Enabled:=false;
 AMailTo.Enabled:=false;
 AOpen.Enabled:=false;
 AOpen.Enabled:=false;
 APrint.Enabled:=false;
 BCancel.Visible:=true;
 PBar.Position:=0;
 PPBar.Visible:=true;
end;


procedure TFRpMeta.AExitExecute(Sender: TObject);
begin
 if assigned(aform) then
  aform.Close;
end;




procedure TFRpMeta.AScale100Execute(Sender: TObject);
begin
 fpreviewcontrol.AutoScale:=AScaleReal;
end;

procedure TFRpMeta.AScaleWideExecute(Sender: TObject);
begin
 fpreviewcontrol.AutoScale:=rppreviewmetaclx.AScaleWide;
end;

procedure TFRpMeta.AScaleFullExecute(Sender: TObject);
begin
 fpreviewcontrol.AutoScale:=AScaleEntirePage;
end;

procedure TFRpMeta.AScaleLessExecute(Sender: TObject);
begin
 PreviewControl.PreviewScale:=PreviewControl.PreviewScale-0.1;
end;

procedure TFRpMeta.AScaleMoreExecute(Sender: TObject);
begin
 PreviewControl.PreviewScale:=PreviewControl.PreviewScale+0.1;
end;


procedure TFRpMeta.ACancelExecute(Sender: TObject);
begin
 cancelled:=true;
end;

procedure TFRpMeta.ExecuteServer(Sender:TObject);
begin
 metafile.LoadFromStream(clitree.Stream);
 ASave.Enabled:=True;
 AMailTo.Enabled:=true;
 APrint.Enabled:=True;
 AFirst.Enabled:=True;
 APrevious.Enabled:=True;
 ANext.Enabled:=True;
 ALast.Enabled:=True;
 fpreviewcontrol.metafile:=nil;
 fpreviewcontrol.metafile:=metafile;
end;

procedure TFRpMeta.AAboutExecute(Sender: TObject);
begin
 ShowAbout;
end;

procedure TFRpMeta.AViewConnectExecute(Sender: TObject);
begin
 AViewConnect.Checked:=Not AViewConnect.Checked;
 clitree.Width:=clitree.Initialwidth;
 clitree.Visible:=AViewConnect.Checked;
end;

procedure TFRpMeta.AStatusBarExecute(Sender: TObject);
begin
 AStatusBar.Checked:=Not AStatusBar.Checked;
 BStatus.Visible:=AStatusBar.Checked;
end;


procedure TFRpMeta.Windows1Click(Sender: TObject);
begin
 // Sets the style
 AppStyle:=TDefaultStyle((Sender As TComponent).Tag);
 UpdateStyle;
end;

procedure TFRpMeta.LoadConfig;
var
 inif:TInifile;
begin
 inif:=TIniFile.Create(configfile);
 try
{$IFDEF VCLANDCLX}
  ADriverQT.Checked:=inif.ReadBool('Preferences','DriverQt',false);
{$ENDIF}
{$IFDEF LINUX}
  ADriverQT.Checked:=true;
{$ENDIF}
  AsystemPrintDialog.Checked:=inif.ReadBool('Preferences','SystemPrintDialog',True);
  BStatus.Visible:=inif.ReadBool('Preferences','StatusBar',True);
  AStatusBar.Checked:=BStatus.Visible;
  AViewConnect.Checked:=inif.ReadBool('Preferences','DiagConnect',True);
  clitree.Visible:=AViewConnect.Checked;
{$IFDEF LINUX}
  rpqtdriver.kylixprintbug:=false;
{$ENDIF}
  clitree.ComboHost.Text:=inif.ReadString('Preferences','Host','localhost');
  clitree.EUserName.Text:=inif.ReadString('Preferences','UserName','Admin');
  ADriverGDI.Checked:=Not ADriverQT.Checked;
  AAsyncExec.Checked:=inif.ReadBool('Preferences','AsyncExec',False);;
  metafile.AsyncReading:=AAsyncexec.Checked;
  clitree.asynchrohous:=AAsyncexec.Checked;
  AppStyle:=TDefaultStyle(inif.ReadInteger('Preferences','QtStyle',Integer(dsSystemDefault)));
  printerindex:=TRpPrinterSelect(inif.ReadInteger('Preferences','PrinterIndex',Integer(pRpDefaultPrinter)));
  UpdatePrintSel;
  UpdateStyle;
 finally
  inif.free;
 end;
end;

procedure TFRpMeta.SaveConfig;
var
 inif:TInifile;
begin
 inif:=TIniFile.Create(configfile);
 try
  inif.WriteBool('Preferences','DriverQT',ADriverQT.Checked);
  inif.WriteBool('Preferences','SystemPrintDialog',AsystemPrintDialog.Checked);
  inif.WriteBool('Preferences','StatusBar',BStatus.Visible);
  inif.WriteInteger('Preferences','QtStyle',Integer(AppStyle));
  inif.WriteInteger('Preferences','PrinterIndex',Integer(printerindex));
  inif.WriteString('Preferences','Host',clitree.ComboHost.Text);
  inif.WriteString('Preferences','UserName',clitree.EUserName.Text);
  inif.WriteBool('Preferences','AsyncExec',AAsyncExec.Checked);;
  inif.WriteBool('Preferences','DiagConnect',AViewConnect.Checked);
  inif.UpdateFile;
 finally
  inif.free;
 end;
end;

procedure TFRpMeta.ADocumentationExecute(Sender: TObject);
var
 aurl:string;
 Directorysep:string;
begin
 aurl:=ExtractFilePath(Application.Exename);
{$IFDEF MSWINDOWS}
 Directorysep:='\';
{$ENDIF}
{$IFDEF LINUX}
 Directorysep:='/';
{$ENDIF}
 aurl:=aurl+'doc'+Directorysep+
  Directorysep+'left.html';
 ShowHelp(aurl);
end;

procedure TFRpMeta.ASystemPrintDialogExecute(Sender: TObject);
begin
 ASystemPrintDialog.Checked:=Not ASystemPrintDialog.Checked;
end;

procedure TFRpMeta.ADriverQtExecute(Sender: TObject);
begin
 ADriverQT.Checked:=true;
 ADriverGDI.Checked:=false;
end;

procedure TFRpMeta.ADriverGDIExecute(Sender: TObject);
begin
 ADriverQT.Checked:=false;
 ADriverGDI.Checked:=true;
end;

procedure TFRpMeta.APrintSetupExecute(Sender: TObject);
{$IFDEF VCLANDCLX}
var
 psetup:TPrinterSetupDialog;
{$ENDIF}
begin
{$IFDEF VCLANDCLX}
 if ADriverGDI.Checked then
 begin
  psetup:=TPrinterSetupDialog.Create(nil);
  try
   psetup.execute;
  finally
   psetup.free;
  end;
  exit;
 end;
{$ENDIF}
 printer.ExecuteSetup;
end;

procedure TFRpMeta.UpdatePrintSel;
var
 i:integer;
begin
 for i:=0 to MSelectPrinter.Count-1 do
 begin
  MSelectPrinter.Items[i].Checked:=MSelectPrinter.Items[i].Tag=Integer(printerindex);
 end;
 for i:=0 to MSelectPrinter2.Count-1 do
 begin
  MSelectPrinter2.Items[i].Checked:=MSelectPrinter2.Items[i].Tag=Integer(printerindex);
 end;
end;

procedure TFRpMeta.APrintersConfigurationExecute(Sender: TObject);
begin
 ShowPrintersConfiguration;
end;

procedure TFRpMeta.MSelPrinter0Click(Sender: TObject);
begin
 printerindex:=TRpPRinterSelect((Sender as TComponent).Tag);
 UpdatePrintSel;
end;

procedure TFRpMeta.AAsyncExecExecute(Sender: TObject);
begin
 AAsyncExec.Checked:=Not AAsyncExec.checked;
 metafile.AsyncReading:=AAsyncexec.Checked;
 clitree.asynchrohous:=AAsyncexec.Checked;
end;

procedure TFRpMeta.FrameMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
 increment:integer;
begin
 increment:=REP_C_WHEELINC;
 if Not (ssShift in Shift) then
  increment:=increment*REP_C_WHEELSCALE;
 fpreviewcontrol.Scroll(not (ssCtrl in Shift),increment);
 Handled:=true;
end;

procedure TFRpMeta.FrameMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
 increment:integer;
begin
 increment:=REP_C_WHEELINC;
 if Not (ssShift in Shift) then
  increment:=increment*REP_C_WHEELSCALE;
 fpreviewcontrol.Scroll(not (ssCtrl in Shift),-increment);
 Handled:=true;
end;

procedure TFRpMeta.BConfigClick(Sender: TObject);
var
 apoint:TPoint;
begin
 apoint.X:=BConfig.Left;
 apoint.Y:=BConfig.Top+BConfig.Height;
 apoint:=BConfig.Parent.ClientToScreen(apoint);
 // SHows the printer menu
 MPrintMenu.Popup(apoint.X,apoint.Y);
end;

procedure TFRpMeta.AMailToExecute(Sender: TObject);
var
 afilename:String;
begin
 afilename:=RpTempFileName;
 SaveMetafileToPDF(Metafile,afilename,true);
 try
  rptypes.SendMail('',ExtractFileName(afilename),'',afilename,ExtractFilePath(ChangeFileExt(afilename,'.pdf')));
 finally
  SysUtils.DeleteFile(afilename);
 end;
end;

procedure TFRpMeta.OnProgress(Sender:TObject;records,pagecount:integer;var docancel:boolean);
var
 meta:TRpMetafilereport;
begin
 meta:=TRpMetafileReport(Sender);
 if meta.Finished then
 begin
  BCancel.Visible:=false;
  PPBar.Visible:=false;
 end
 else
 begin
  if not meta.Reading then
  begin
   BCancel.Visible:=true;
   BCancel.Caption:=SRpPage+':'+FormatFloat('##,##',pagecount)+' '+SrpCancel;
   Application.ProcessMessages;
   docancel:=cancelled;
{$IFDEF MSWINDOWS}
   if ((GetAsyncKeyState(VK_ESCAPE) AND $8000)<>0) then
    docancel:=true;
{$ENDIF}
  end;
  PPBar.Visible:=true;
  PBar.Max:=pagecount;
  PBar.Position:=meta.CurrentPageCount;
 end;
end;

procedure TFRpMeta.WorkAsyncError(amessage:String);
begin
 RpMessageBox(amessage);
end;

procedure TFRpMeta.SetMetafile(avalue:TRpMetafileReport);
begin
 fmetafile:=avalue;
 if assigned(FMetafile) then
 begin
  fmetafile.OnWorkProgress:=OnProgress;
  fmetafile.OnWorkAsyncError:=WorkAsyncError;
  if not fmetafile.PreviewAbout then
   MHelp.Visible:=false;
 end;
 fPreviewControl.Metafile:=fmetafile;
end;

procedure TFRpMeta.MEntire1Click(Sender: TObject);
begin
 // Adjust to entirepage
 PreviewControl.EntirePageCount:=TMenuItem(Sender).Tag;
 PreviewControl.AutoScale:=AScaleEntirePage;
end;

procedure TFRpMeta.MLeftRightClick(Sender: TObject);
begin
 MleftRight.Checked:=Not MLeftRight.Checked;
 PreviewControl.EntireTopDown:=Not MLeftRight.Checked;
end;

procedure TFRpMeta.OnPageDrawn(prm:TRpPreviewMetaCLX);
begin
 EPageNum.Text:=IntToStr(prm.Page+1);
end;

procedure TFRpMeta.ESearchChange(Sender: TObject);
begin
 textchanged:=true;
end;

procedure TFRpMeta.AFindExecute(Sender: TObject);
begin
 FindNext;
end;

procedure TFRpMeta.FindNext;
var
 pageindex:integer;
begin
 if (textchanged) then
 begin
  PreviewControl.Metafile.DoSearch(Trim(ESearch.Text));
  pageindex:=PreviewControl.Metafile.NextPageFound(-1);
  textchanged:=false;
 end
 else
  pageindex:=PreviewControl.Metafile.NextPageFound(PreviewControl.Page+PreviewControl.PagesDrawn-1);
 if PreviewControl.Page=pageindex then
  PreviewControl.RefreshPage
 else
  PreviewControl.Page:=pageindex;
end;

procedure TFRpMeta.ESearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 increment:integer;
begin
 if (ssShift in Shift) then
  increment:=REP_C_WHEELINC
 else
  increment:=REP_C_WHEELINC*REP_C_WHEELSCALE;
 if Key=Key_Down then
  fpreviewcontrol.Scroll(true,increment);
 if Key=Key_Up then
  fpreviewcontrol.Scroll(true,-increment);
 if Key=Key_Right then
  fpreviewcontrol.Scroll(false,increment);
 if Key=Key_Left then
  fpreviewcontrol.Scroll(false,-increment);
 if Key=Key_Space then
 begin
  if fpreviewcontrol.AutoScale=AScaleEntirePage then
   fpreviewcontrol.AutoScale:=AScaleReal
  else
   fpreviewcontrol.AutoScale:=AScaleEntirePage;
  Key:=0;
 end;
end;

end.
