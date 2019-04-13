{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfmain                                       }
{       Main form of report manager designer            }
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

unit rpmdfmain;

interface

{$I rpconf.inc}

uses
  SysUtils,
  Types, Classes,
{$IFDEF MSWINDOWS}
  Windows,ShellAPI,
{$ENDIF}
{$IFDEF VCLANDCLX}
  rpgdidriver,rpvpreview,rprfvparams,Forms,Dialogs,rppagesetupvcl,
  rpmdfgridvcl,rpfparamsvcl,rpfmainmetaviewvcl,
{$ENDIF}
  QGraphics,QStyle,Qt,QControls, QForms,
  QStdCtrls, QComCtrls, QActnList, QImgList, QMenus, QTypes,QExtCtrls,
  QClipbrd,QPrinters,QConsts, QDialogs,rpqtdriver,rpmdfhelpform,
  rpreport,rpmdfabout,rppagesetup,rpmdshfolder,rpmdfdinfo,rppreviewcontrolclx,
  rpmdfgrid,rppreview,rpprintdia, rplastsav, rpalias,rplabelitem,
  rpmdconsts,rptypes, rpmdfstruc, rpsubreport,rpeditconn,rpmdfopenlib,
  rpmdobinsint,rpfparams,rpmdfdesign,rpmdobjinsp,rpmdfsectionint,IniFiles,
  rpsection,rpprintitem,rprfparams,rpfmainmetaview,rpmdsysinfoqt,
  rppdfdriver,rpmetafile,
{$IFDEF LINUX}
  Libc,
{$ENDIF}
  DB,rpdatainfo,rpmunits,rpgraphutils;
const
  // File name in menu width
  C_FILENAME_WIDTH=40;
type
  TFRpMainF = class(TForm)
    FontDialog1:TFontDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    MAppFont: TMenuItem;
    MObjFont: TMenuItem;
    ActionList1: TActionList;
    iconlist: TImageList;
    ToolBar1: TToolBar;
    ANew: TAction;
    AOpen: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    New1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    AExit: TAction;
    Exit1: TMenuItem;
    ToolButton3: TToolButton;
    ASave: TAction;
    BSave: TToolButton;
    N2: TMenuItem;
    Save1: TMenuItem;
    SaveDialog1: TSaveDialog;
    ASaveas: TAction;
    Saveas1: TMenuItem;
    APageSetup: TAction;
    Pagesetup1: TMenuItem;
    N3: TMenuItem;
    OpenDialog1: TOpenDialog;
    mainscrollbox: TScrollBox;
    leftpanel: TPanel;
    Splitter1: TSplitter;
    Lastusedfiles: TRpLastUsedStrings;
    MReport: TMenuItem;
    ANewPageHeader: TAction;
    Newpageheader1: TMenuItem;
    MAdd: TMenuItem;
    ANewPageFooter: TAction;
    ANewGroup: TAction;
    Pagefooter1: TMenuItem;
    Groupheaderandfooter1: TMenuItem;
    ANewSubreport: TAction;
    Subreport1: TMenuItem;
    ADeleteSelection: TAction;
    ADeleteSelection1: TMenuItem;
    ANewDetail: TAction;
    Detail1: TMenuItem;
    ADataConfig: TAction;
    Dataaccessconfiguration1: TMenuItem;
    AParams: TAction;
    Parameters1: TMenuItem;
    APrint: TAction;
    APreview: TAction;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    BLabel: TToolButton;
    BArrow: TToolButton;
    BExpression: TToolButton;
    BShape: TToolButton;
    BImage: TToolButton;
    BChart: TToolButton;
    MDisplay: TMenuItem;
    AGridOptions: TAction;
    Grid1: TMenuItem;
    Splitter2: TSplitter;
    MEdit: TMenuItem;
    PrintPreview1: TMenuItem;
    Print1: TMenuItem;
    ACut: TAction;
    ACopy: TAction;
    APaste: TAction;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    APaste1: TMenuItem;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    AAbout: TAction;
    MHelp: TMenuItem;
    MAbout: TMenuItem;
    ADocumentation: TAction;
    MDoc: TMenuItem;
    APrintSetup: TAction;
    Printersetup1: TMenuItem;
    AUnitCms: TAction;
    AUnitsinchess: TAction;
    MPreferences: TMenuItem;
    MMeasurement: TMenuItem;
    Cms1: TMenuItem;
    Inchess1: TMenuItem;
    AUserParams: TAction;
    Userparameters1: TMenuItem;
    MDriverSelect: TMenuItem;
    MQtDriver: TMenuItem;
    MGDIDriver: TMenuItem;
    ADriverQT: TAction;
    ADriverGDI: TAction;
    ASystemPrintDialog: TAction;
    MSystemPrint: TMenuItem;
    AkylixPrintBug: TAction;
    MKylixPrintBug: TMenuItem;
    MQtStyle: TMenuItem;
    Windows1: TMenuItem;
    Motif1: TMenuItem;
    MotifPlus1: TMenuItem;
    CDE1: TMenuItem;
    QtSGI1: TMenuItem;
    Platinum1: TMenuItem;
    MQtDefault: TMenuItem;
    AHide: TAction;
    N4: TMenuItem;
    Hide1: TMenuItem;
    AShowAll: TAction;
    Showall1: TMenuItem;
    ASelectAll: TAction;
    ASelectAllText: TAction;
    N5: TMenuItem;
    MSelect: TMenuItem;
    ASelectAll1: TMenuItem;
    ASelectAllText1: TMenuItem;
    ToolButton14: TToolButton;
    ALeft: TAction;
    ToolButton15: TToolButton;
    ARight: TAction;
    AUp: TAction;
    ADown: TAction;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    MMove: TMenuItem;
    Left1: TMenuItem;
    Right1: TMenuItem;
    Up1: TMenuItem;
    Down1: TMenuItem;
    ToolButton19: TToolButton;
    AAlignLeft: TAction;
    AAlignRight: TAction;
    AAlignUp: TAction;
    AAlignDown: TAction;
    AAlignHorz: TAction;
    AAlignVert: TAction;
    MAlign: TMenuItem;
    Left2: TMenuItem;
    Right2: TMenuItem;
    Up2: TMenuItem;
    Down2: TMenuItem;
    Horizontalspace1: TMenuItem;
    Verticalspace1: TMenuItem;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    BBarcode: TToolButton;
    BStatus: TStatusBar;
    AStatusBar: TAction;
    Statusbar1: TMenuItem;
    ADriverPDFGDI: TAction;
    ADriverPDFQt: TAction;
    MPDFQtDriver: TMenuItem;
    MPDFGDIDriver: TMenuItem;
    ASysInfo: TAction;
    MSysInfo: TMenuItem;
    AAlign1_6: TAction;
    N6: TMenuItem;
    MAlign1_6: TMenuItem;
    RpAlias1: TRpAlias;
    ALibraries: TAction;
    N7: TMenuItem;
    MLibraries: TMenuItem;
    ADelete: TAction;
    BDelete: TToolButton;
    Delete1: TMenuItem;
    Configure1: TMenuItem;
    Openfrom1: TMenuItem;
    Copyto1: TMenuItem;
    AOpenFrom: TAction;
    ASaveTo: TAction;
    MTypeInfo: TMenuItem;
    MAsync: TMenuItem;
    ComboScale: TComboBox;
    procedure ANewExecute(Sender: TObject);
    procedure AExitExecute(Sender: TObject);
    procedure AOpenExecute(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure ASaveasExecute(Sender: TObject);
    procedure APageSetupExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ANewPageHeaderExecute(Sender: TObject);
    procedure ANewPageFooterExecute(Sender: TObject);
    procedure ANewGroupExecute(Sender: TObject);
    procedure ANewSubreportExecute(Sender: TObject);
    procedure ADeleteSelectionExecute(Sender: TObject);
    procedure ANewDetailExecute(Sender: TObject);
    procedure ADataConfigExecute(Sender: TObject);
    procedure AParamsExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure ACutExecute(Sender: TObject);
    procedure ACopyExecute(Sender: TObject);
    procedure APasteExecute(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure APreviewExecute(Sender: TObject);
    procedure AAboutExecute(Sender: TObject);
    procedure APrintExecute(Sender: TObject);
    procedure ShowHelp(AURL:string);
    procedure ShowDoc(document:String);
    procedure ADocumentationExecute(Sender: TObject);
    procedure AFeaturesExecute(Sender: TObject);
    procedure APrintSetupExecute(Sender: TObject);
    procedure AUnitCmsExecute(Sender: TObject);
    procedure AUnitsinchessExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure AUserParamsExecute(Sender: TObject);
    procedure ADriverQTExecute(Sender: TObject);
    procedure ADriverGDIExecute(Sender: TObject);
    procedure ASystemPrintDialogExecute(Sender: TObject);
    procedure AkylixPrintBugExecute(Sender: TObject);
    procedure Windows1Click(Sender: TObject);
    procedure AHideExecute(Sender: TObject);
    procedure AShowAllExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ASelectAllExecute(Sender: TObject);
    procedure ASelectAllTextExecute(Sender: TObject);
    procedure ALeftExecute(Sender: TObject);
    procedure ARightExecute(Sender: TObject);
    procedure AUpExecute(Sender: TObject);
    procedure ADownExecute(Sender: TObject);
    procedure AAlignLeftExecute(Sender: TObject);
    procedure AAlignRightExecute(Sender: TObject);
    procedure AAlignUpExecute(Sender: TObject);
    procedure AAlignDownExecute(Sender: TObject);
    procedure AAlignHorzExecute(Sender: TObject);
    procedure AAlignVertExecute(Sender: TObject);
    procedure AStatusBarExecute(Sender: TObject);
    procedure ADriverPDFGDIExecute(Sender: TObject);
    procedure ADriverPDFQtExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ASysInfoExecute(Sender: TObject);
    procedure AAlign1_6Execute(Sender: TObject);
    procedure ALibrariesExecute(Sender: TObject);
    procedure ADeleteExecute(Sender: TObject);
    procedure AOpenFromExecute(Sender: TObject);
    procedure ASaveToExecute(Sender: TObject);
    procedure MAppFontClick(Sender: TObject);
    procedure MObjFontClick(Sender: TObject);
    procedure MTypeInfoClick(Sender: TObject);
    procedure MAsyncClick(Sender: TObject);
    procedure ComboScaleClick(Sender: TObject);
  private
    { Private declarations }
    fdesignframe:TFRpDesignFrame;
    fhelp:TFRpHelpform;
    fobjinsp:TFRpObjInsp;
    lastsaved:TMemoryStream;
    configfile,configfilelib:string;
    AppStyle:TDefaultStyle;
    oldappidle:TIdleEvent;
    oldonException:TExceptionEvent;
    oldonhint:TNotifyEvent;
    HighLightText:String;
    OldHelpFilename:string;
    alibrary:String;
    areportname:WideString;
{$IFDEF LINUX}
    usekprinter:boolean;
{$ENDIF}
    FAppFontName:String;
    FAppFontSize:integer;
    FAppFontStyle:integer;
    FAppFontColor:Integer;
    FObjFontName:String;
    FObjFontSize:integer;
    FObjFontStyle:integer;
    FObjFontColor:Integer;    procedure FreeInterface;
    procedure CreateInterface;
    function checkmodified:boolean;
    procedure DoSave;
    procedure DoEnable;
    procedure DoDisable;
    function CheckSave:Boolean;
    procedure UpdateFileMenu;
    procedure OnFileClick(Sender:TObject);
    procedure DoOpen(newfilename:string;showopendialog:boolean);
    procedure OnReadError(Reader: TReader; const Message: string;
     var Handled: Boolean);
    procedure LoadConfig;
    procedure SaveConfig;
    procedure UpdateUnits;
    procedure CorrectScrollBoxes;
    procedure UpdateStyle;
    procedure OnHighLightText(Sender: TObject;
     const HighlightedText: WideString);
    procedure MyExceptionHandler(Sender:TObject;E:Exception);
    procedure AppHint(Sender:TObject);
    procedure OnHelpClick(Sender:TObject);
    procedure HelpOnIdle(Sender:TObject;var done:Boolean);
    procedure DeleteSelection;
    procedure DoOpenFromLib(alibname:String;arepname:WideString);
    procedure DoOpenStream(astream:TStream);
    procedure IdleMaximize(Sender:TObject;var done:Boolean);
    procedure UpdateFonts;
    function GetScale:double;
  public
    { Public declarations }
    report:TRpReport;
    filename:string;
    freportstructure:TFRpStructure;
    browsecommandline:boolean;
    procedure RefreshInterface(Sender: TObject);
    constructor Create(AOwner:TComponent);override;
    function GetExpressionText:string;
    destructor Destroy;override;
  end;


procedure ExecuteReportDotNet(report:TRpReport;preview:boolean;version:integer);
implementation

uses Math;


{$R *.xfm}


destructor TFRpMainF.Destroy;
begin
 if Assigned(lastsaved) then
 begin
  lastsaved.free;
  lastsaved:=nil;
 end;
 inherited Destroy;
end;

procedure TFRpMainF.UpdateFonts;
begin
  Self.Font.Name:=FAppFontName;
  Self.Font.Size:=FAppFontSize;
  Self.Font.Style:=IntegerToFontStyle(FAppFontStyle);
{  QGraphics.DefFontData.Name:=Screen.IconFont.Name;
  QGraphics.DefFontData.Height:=Screen.IconFont.Height;
  QGraphics.DefFontData.Style:=Screen.IconFont.Style;
}  if assigned(freportstructure) then
  begin
   RefreshInterface(Self);
  end;
end;


constructor TFRpMainF.Create(AOwner:TComponent);
begin
 configfile:=Obtainininameuserconfig('','','repmand');
 configfilelib:=Obtainininameuserconfig('','','repmandlib');
 inherited Create(AOwner);
 LoadConfig;
end;

// Check if it is saved and return true if all is ok
function TFRpMainF.CheckSave:Boolean;
var
 res:TMessageButton;
begin
 Result:=true;
 if report=nil then
  exit;
 if Not ASave.Visible then
  exit;
 if report<>nil then
 begin
  if Not CheckModified then
   exit;
  res:=RpMessageBox(SRpReportChanged,SRpWarning,[smbYes,smbNo,smbCancel],
   smsWarning,smbYes,smbCancel);

  if (res=smbCancel) then
   Raise EAbort.Create(SRpSaveAborted);
  if res=smbNo then
   exit;
  ASaveExecute(Self);
 end;
end;

procedure TFRpMainF.ANewExecute(Sender: TObject);
begin
 if Not checksave then
  exit;
 DoDisable;
 // Creates a new report
 report:=TRpReport.Create(Self);
 report.AsyncExecution:=MAsync.Checked;
 report.IsDesignTime:=true;
 report.OnReadError:=OnReadError;
 report.FailIfLoadExternalError:=false;
 report.CreateNew;
 filename:='';
 alibrary:='';
 areportname:='';

 DoEnable;
 FormResize(Self);
end;

procedure TFRpMainF.DoEnable;
begin
 // Save the report for seeing after if it's modified
 if Assigned(lastsaved) then
 begin
  lastsaved.free;
  lastsaved:=nil;
 end;
 lastsaved:=TMemorystream.create;
 report.SaveToStream(lastsaved);

 CreateInterface;
end;

procedure TFRpMainF.DoDisable;
begin
 FreeInterface;
 report.free;
 report:=nil;
 // Save the report for seeing after if it's modified
 if Assigned(lastsaved) then
 begin
  lastsaved.free;
  lastsaved:=nil;
 end;
end;

procedure TFRpMainF.AExitExecute(Sender: TObject);
begin
 Close;
end;


procedure TFRpMainF.AOpenExecute(Sender: TObject);
begin
 DoOpen(filename,true);
 FormResize(Self);
end;

procedure TFRpMainF.ASaveExecute(Sender: TObject);
begin
 Assert(report<>nil,'Called Save without a report assigned');
 // Saves the current report
 Assert(report<>nil,'Called Save without a report assigned');
 // Saves the current report
 if ((Length(filename)>0) or (Length(alibrary)>0)) then
 begin
  DoSave;
 end
 else
 begin
  ASaveAsExecute(Self);
 end;
end;


procedure TFRpMainF.FreeInterface;
begin
 // Frees the interface for the report
 ASave.Enabled:=false;
 ASaveas.Enabled:=false;
 MReport.Enabled:=false;
 ANewPageHeader.Enabled:=false;
 ANewPageFooter.Enabled:=false;
 ANewGroup.Enabled:=false;
 ANewSubReport.Enabled:=false;
 ADeleteSelection.Enabled:=false;
 AnewDetail.Enabled:=false;
 ADataConfig.Enabled:=false;
 APreview.Enabled:=false;
 ACut.Enabled:=False;
 ADelete.Enabled:=False;
 ACopy.Enabled:=FalsE;
 APaste.Enabled:=False;
 AShowAll.Enabled:=False;
 AHide.Enabled:=False;
 APrint.Enabled:=false;
 AGridOptions.Enabled:=false;
 MDisplay.Enabled:=false;
 MEdit.Enabled:=false;

 // Palette
 BArrow.Enabled:=false;
 BLabel.Enabled:=false;
 BExpression.Enabled:=false;
 BShape.Enabled:=false;
 BImage.Enabled:=false;
 BBarcode.Enabled:=false;
 BChart.Enabled:=false;
 BArrow.Down:=false;
 BLabel.Down:=false;
 BExpression.Down:=false;
 BShape.Down:=false;
 BImage.Down:=false;
 BBarcode.Down:=false;
 BChart.Down:=false;

 AParams.Enabled:=False;
 APageSetup.Enabled:=false;
 Caption:=SRpRepman;

 freportstructure.free;
 fdesignframe.free;
 fobjinsp.free;
 fobjinsp:=nil;
 fdesignframe:=nil;
 freportstructure:=nil;
 mainscrollbox.Visible:=false;
end;

procedure TFRpMainF.CreateInterface;
begin
 // Creates an interface for the report
 ASave.Enabled:=true;
 ASaveas.Enabled:=True;
 APageSetup.Enabled:=True;
 MReport.Enabled:=True;
 ANewPageHeader.Enabled:=True;
 ANewPageFooter.Enabled:=True;
 ANewGroup.Enabled:=true;
 ANewSubReport.Enabled:=True;
 ADeleteSelection.Enabled:=true;
 AnewDetail.Enabled:=true;
 ADataConfig.Enabled:=true;
 APreview.Enabled:=true;
 ACut.Enabled:=False;
 ADelete.Enabled:=False;
 ACopy.Enabled:=FalsE;
 AHide.Enabled:=False;
 APaste.Enabled:=true;
 AShowAll.Enabled:=True;
 APrint.Enabled:=true;
 AGridOptions.Enabled:=true;
 MDisplay.Enabled:=true;
 MEdit.Enabled:=true;

 // Palette
 BArrow.Enabled:=true;
 BLabel.Enabled:=true;
 BExpression.Enabled:=true;
 BShape.Enabled:=true;
 BImage.Enabled:=true;
 BBarcode.Enabled:=true;
 BChart.Enabled:=true;
 BArrow.Down:=true;

 AParams.Enabled:=True;
 if length(filename)<1 then
  Caption:=SRpRepman+'-'+SRpUntitled
 else
  Caption:=SRpRepman+'-'+filename;
 // Create the report structure frame
 fobjinsp:=TFRpObjInsp.Create(Self);
 fobjinsp.Font.Style:=IntegerToFontStyle(FObjFontStyle);
 fobjinsp.Font.Name:=FObjFontName;
 fobjinsp.Font.Size:=FObjFontSize;
 fobjinsp.Font.Color:=FObjFontColor;
 fobjinsp.Align:=alclient;
 fobjinsp.Parent:=leftpanel;
 freportstructure:=TFRpStructure.Create(Self);
 freportstructure.browser.showdatatypes:=MTypeInfo.Checked;
 freportstructure.Align:=alTop;
 freportstructure.Parent:=leftPanel;
 fdesignframe:=TFRpDesignFrame.Create(Self);

 fdesignframe.Scale:=GetScale;

 fobjinsp.DesignFrame:=fdesignframe;
 fdesignframe.Align:=alclient;
 fdesignframe.Parent:=MainScrollBox;
 fdesignframe.freportstructure:=freportstructure;
 freportstructure.designframe:=fdesignframe;
 splitter2.Top:=freportstructure.Height+10;

 fdesignframe.objinsp:=fobjinsp;
 freportstructure.objinsp:=fobjinsp;
 freportstructure.report:=report;
 fdesignframe.report:=report;

 mainscrollbox.Visible:=true;
end;

procedure TFRpMainF.ASaveasExecute(Sender: TObject);
begin
 Assert(report<>nil,'Called Save without a report assigned');
 // Saves the report
 if SaveDialog1.Execute then
 begin
  filename:=SaveDialog1.filename;
  alibrary:='';
  areportname:='';
  DoSave;
 end
 else
  Raise EAbort.Create(SRpSaveAborted);
end;

procedure TFRpMainF.DoSave;
var
 astream:TStream;
begin
 Assert(report<>nil,'Called DoSave without a report assigned');

 if Length(filename)>0 then
 begin
  report.SaveToFile(savedialog1.filename);
  Caption:=SRpRepman+'-'+filename;
  filename:=savedialog1.filename;
  LastUsedFiles.UseString(filename);
 end
 else
 begin
  astream:=TMemoryStream.Create;
  try
   report.SaveToStream(astream);
   astream.Seek(0,soFromBeginning);
   RpAlias1.Connections.SaveReportStream(alibrary,areportname,astream,nil);
  finally
   astream.free;
  end;
  Caption:=SRpRepman+'-'+alibrary+'->'+areportname;
  filename:='';
  LastUsedFiles.UseString(alibrary+'->'+areportname);
 end;

 // After saving update the lastsaved stream
 if assigned(lastsaved) then
 begin
  lastsaved.free;
  lastsaved:=nil;
 end;
 lastsaved:=TMemorystream.create;
 report.SaveToStream(lastsaved);

 UpdateFileMenu;
end;


procedure TFRpMainF.APageSetupExecute(Sender: TObject);
begin
 Assert(report<>nil,'Called Page setup without a report assigned');

{$IFDEF VCLANDCLX}
 if ((ADriverGDI.Checked or ADriverPDFGDI.Checked)) then
 begin
  if rppagesetupvcl.ExecutePageSetup(report) then
  begin
   fdesignframe.UpdateInterface(true);
   fdesignframe.UpdateSelection(false);
  end;
  exit;
 end;
{$ENDIF}
 if rppagesetup.ExecutePageSetup(report) then
 begin
  fdesignframe.UpdateInterface(true);
  fdesignframe.UpdateSelection(false);
 end;
end;


// A report is known is modified by comparing the saving of
// the current report with the last saved report (lastsaved)
function TFRpMainF.checkmodified:boolean;
var
 newsave:TMemoryStream;
begin
 Result:=true;
 if report=nil then
  exit;
 if Not Assigned(lastsaved) then
  exit;

 newsave:=TMemoryStream.create;
 try
  report.SaveToStream(newsave);
  if streamcompare(lastsaved,newsave) then
   result:=false;
 finally
  newsave.free;
 end;
end;

procedure TFRpMainF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 try
  canclose:=CheckSave;
 except
  canclose:=false;
 end;
end;

procedure TFRpMainF.FormCreate(Sender: TObject);
begin
 ComboScale.ItemIndex:=ComboScale.Items.IndexOf('100%');
{$IFDEF LINUX}
 usekprinter:=GetEnvironmentVariable('REPMANUSEKPRINTER')='true';
{$ENDIF}

 ToolBar1.ButtonHeight:=26;
 ToolBar1.ButtonWidth:=26;
 // Inits Bools Arrays
 BoolToStr(True,True);
 ALeft.ShortCut:=ShortCut(Key_Left,[ssCtrl]);
 ARight.ShortCut:=ShortCut(Key_Right,[ssCtrl]);
 AUp.ShortCut:=ShortCut(Key_Up,[ssCtrl]);
 ADown.ShortCut:=ShortCut(Key_Down,[ssCtrl]);
// Shortcuts disabled must checkn if TEdit active
 ADelete.ShortCut:=ShortCut(Key_Delete,[ssCtrl]);
 ACut.ShortCut:=ShortCut(Ord('X'),[ssAlt]);
 ACopy.ShortCut:=ShortCut(Ord('C'),[ssAlt]);
 APaste.ShortCut:=ShortCut(Ord('V'),[ssAlt]);
 ASelectAll.ShortCut:=ShortCut(Ord('A'),[ssAlt]);

{$IFDEF VCLFILEFILTERS}
 OpenDialog1.Filter := SRpRepFile+'|*.rep';
{$ENDIF}
{$IFDEF VCLFILEFILTERS}
 SaveDialog1.Filter := SRpRepFile+'|*.rep|'+SRpAnyFile+'|*.*';
{$ENDIF}
 // Sets on exception event
{$IFDEF VCLANDCLX}
 Forms.Application.OnException:=MyExceptionHandler;
{$ENDIF}
 oldonexception:=QForms.Application.OnException;
 QForms.Application.OnException:=MyExceptionHandler;

 AppStyle:=dsSystemDefault;

{$IFDEF MSWINDOWS}
  LastUsedFiles.CaseSensitive:=False;
{$ENDIF}
{$IFDEF VCLANDCLX}
  // Visible driver selection
  MPDFGDIDriver.Visible:=true;
  MGDIDriver.Visible:=true;
{$ENDIF}
{$IFDEF LINUX}
  LastUsedFiles.CaseSensitive:=True;
{$ENDIF}
{$IFDEF LINUXPRINTBUG}
 MKylixPrintBug.Visible:=True;
 MPDFGDIDriver.Visible:=false;
 MGDIDriver.Visible:=false;
{$ENDIF}
 LastUsedFiles.LoadFromConfigFile(configfile);
 UpdateFileMenu;
// LoadConfig;
 // A bug in Kylix loading decimal sep, and thousand sep
{$IFDEF LINUX}
 if thousandseparator=chr(0) then
 begin
  if decimalseparator='.' then
   thousandseparator:=','
  else
   if decimalseparator=',' then
    thousandseparator:='.'
 end;
{$ENDIF}
 // Translate menus and actions
 MAppFont.Caption:=TranslateStr(1347,MAppFont.Caption);
 MObjFont.Caption:=TranslateStr(1348,MAppFont.Caption);
 MTypeInfo.Caption:=SRpTypeInfo;
 MAsync.Caption:=SRpAsyncExecution;
 File1.Caption:=TranslateStr(0,File1.Caption);
 Caption:=TranslateStr(1,Caption);
 MReport.Caption:=TranslateStr(2,MReport.Caption);
 MEdit.Caption:=TranslateStr(3,MEdit.Caption);
 MDisplay.Caption:=TranslateStr(4,MDisplay.Caption);
 AGridOptions.Caption:=TranslateStr(7,AGridOptions.Caption);
 AGridOptions.Hint:=TranslateStr(8,AGridOptions.Hint);
 ACut.Caption:=TranslateStr(9,ACut.Caption);
 ADelete.Caption:=TranslateStr(150,ADelete.Caption);
 ADelete.Hint:=TranslateStr(1106,ADelete.Hint);
 ACopy.Caption:=TranslateStr(10,ACopy.Caption);
 APaste.Caption:=TranslateStr(11,APaste.Caption);
 ACut.Hint:=TranslateStr(12,ACut.Hint);
 ACopy.Hint:=TranslateStr(13,ACopy.Hint);
 APaste.Hint:=TranslateStr(14,APaste.Hint);
 AHide.Caption:=TranslateStr(15,AHide.Caption);
 AHide.Hint:=TranslateStr(16,AHide.Hint);
 AShowAll.Caption:=TranslateStr(17,AShowAll.Caption);
 AShowAll.Hint:=TranslateStr(18,AShowAll.Hint);
 ASelectAll.Caption:=TranslateStr(19,ASelectAll.Caption);
 ASelectAllText.Caption:=TranslateStr(117,ASelectAllText.Caption);
 ASelectAllText.Hint:=TranslateStr(118,ASelectAllText.Hint);
 ASelectAll.Hint:=TranslateStr(20,ASelectAll.Hint);
 MSelect.Caption:=TranslateStr(21,MSelect.Caption);
 MMove.Caption:=TranslateStr(22,MMove.Caption);
 ALeft.Caption:=TranslateStr(23,ALeft.Caption);
 ALeft.Hint:=TranslateStr(24,ALeft.Hint);
 ARight.Caption:=TranslateStr(25,ARight.Caption);
 ARight.Hint:=TranslateStr(26,ARight.Hint);
 AUp.Caption:=TranslateStr(27,AUp.Caption);
 AUp.Hint:=TranslateStr(28,AUp.Hint);
 ADown.Caption:=TranslateStr(29,ADown.Caption);
 ADown.Hint:=TranslateStr(30,ADown.Hint);
 MAlign.Caption:=TranslateStr(31,MAlign.Caption);
 AAlignLeft.Caption:=TranslateStr(23,AAlignLeft.Caption);
 AAlignRight.Caption:=TranslateStr(25,AAlignRight.Caption);
 AAlignUp.Caption:=TranslateStr(27,AAlignUp.Caption);
 AAlignDown.Caption:=TranslateStr(29,AAlignDown.Caption);
 AAlignLeft.Hint:=TranslateStr(32,AAlignLeft.Hint);
 AAlignRight.Hint:=TranslateStr(33,AAlignRight.Hint);
 AAlignUp.Hint:=TranslateStr(34,AAlignUp.Hint);
 AAlignDown.Hint:=TranslateStr(35,AAlignDown.Hint);
 AAlignHorz.Caption:=TranslateStr(36,AAlignHorz.Caption);
 AAlignHorz.Hint:=TranslateStr(37,AAlignHorz.Hint);
 AAlignVert.Caption:=TranslateStr(38,AAlignVert.Caption);
 AAlignVert.Hint:=TranslateStr(39,AAlignVert.Hint);
 ANew.Caption:=TranslateStr(40,ANew.Caption);
 ANew.Hint:=TranslateStr(41,ANew.Hint);
 AOpen.Caption:=TranslateStr(42,AOpen.Caption);
 AOpen.Hint:=TranslateStr(43,AOpen.Hint);
 AExit.Caption:=TranslateStr(44,AExit.Caption);
 AExit.Hint:=TranslateStr(45,AExit.Hint);
 ASave.Caption:=TranslateStr(46,ASave.Caption);
 ASave.Hint:=TranslateStr(47,ASave.Hint);
 ASaveas.Caption:=TranslateStr(48,ASaveas.Caption);
 ASaveas.Hint:=TranslateStr(49,ASaveas.Hint);
 APageSetup.Caption:=TranslateStr(50,APageSetup.Caption);
 APageSetup.Hint:=TranslateStr(51,APageSetup.Hint);
 APrint.Caption:=TranslateStr(52,APrint.Caption);
 APrint.Hint:=TranslateStr(53,APrint.Hint);
 APreview.Caption:=TranslateStr(54,APreview.Caption);
 APreview.Hint:=TranslateStr(55,APreview.Hint);
 APrintSetup.Caption:=TranslateStr(56,APrintSetup.Caption);
 APrintSetup.Hint:=TranslateStr(57,APrintSetup.Hint);
 MHelp.Caption:=TranslateStr(6,MHelp.Caption);
 AAbout.Caption:=TranslateStr(58,AAbout.Caption);
 AAbout.Hint:=TranslateStr(59,AABout.Hint);
 ADocumentation.Caption:=TranslateStr(60,ADocumentation.Caption);
 ADocumentation.Hint:=TranslateStr(61,ADocumentation.Hint);
 MMeasurement.Caption:=TranslateStr(62,MMeasurement.Caption);
 AUnitcms.Caption:=TranslateStr(63,AUnitcms.Caption);
 AUnitcms.Hint:=TranslateStr(64,AUnitcms.Hint);
 AUnitsinchess.Caption:=TranslateStr(65,AUnitsinchess.Caption);
 AUnitsinchess.Hint:=TranslateStr(66,AUnitsinchess.Hint);
 ADocumentation.Caption:=TranslateStr(60,ADocumentation.Caption);
 ADocumentation.Hint:=TranslateStr(61,ADocumentation.Hint);
 MDriverSelect.Caption:=TranslateStr(67,MDriverSelect.Caption);
 ADriverQt.Caption:=TranslateStr(68,ADriverQt.Caption);
 ADriverQt.Hint:=TranslateStr(69,ADriverQt.Hint);
 ADriverPDFQt.Caption:=TranslateStr(938,ADriverPDfQt.Caption);
 ADriverPDFGDI.Caption:=TranslateStr(937,ADriverPDfGDI.Caption);
 ADriverPDFQt.Hint:=TranslateStr(939,ADriverPDFQt.Hint);
 ADriverPDFGDI.Hint:=TranslateStr(939,ADriverPDFGDI.Hint);
 ADriverGDI.Caption:=TranslateStr(70,ADriverGDI.Caption);
 ADriverGDI.Hint:=TranslateStr(71,ADriverGDI.Hint);
 AKylixPrintBug.Caption:=TranslateStr(74,AKylixPrintBug.Caption);
 AKylixPrintBug.Hint:=TranslateStr(75,AKylixPrintBug.Hint);
 AStatusBar.Caption:=TranslateStr(76,AStatusBar.Caption);
 AStatusBar.Hint:=TranslateStr(77,AStatusBar.Hint);
 MPreferences.Caption:=TranslateStr(5,MPreferences.Caption);
 ASystemPrintDialog.Caption:=TranslateStr(72,ASystemPrintDialog.Caption);
 ASystemPrintDialog.Hint:=TranslateStr(73,ASystemPrintDialog.Hint);
 MQtStyle.Caption:=TranslateStr(78,MQtStyle.Caption);
 MQtStyle.Hint:=TranslateStr(79,MQtStyle.Hint);
 MQtDefault.Caption:=TranslateStr(80,MQtDefault.Caption);
 BArrow.Hint:=TranslateStr(81,BArrow.Hint);
 BLabel.Hint:=TranslateStr(82,BLabel.Hint);
 BExpression.Hint:=TranslateStr(83,BExpression.Hint);
 BShape.Hint:=TranslateStr(84,BShape.Hint);
 BImage.Hint:=TranslateStr(85,BImage.Hint);
 BBarCode.Hint:=TranslateStr(86,BBarCode.Hint);
 BChart.Hint:=TranslateStr(87,BChart.Hint);
 MAlign1_6.Caption:=TranslateStr(1059,MAlign1_6.Caption);
 MAlign1_6.Hint:=TranslateStr(1060,MAlign1_6.Hint);
 MLibraries.Caption:=TranslateStr(1080,MLibraries.Caption);
 MLibraries.Hint:=TranslateStr(1081,MLibraries.Hint);
 MSysInfo.Caption:=TranslateStr(976,MSysInfo.Caption);
 MSysInfo.Hint:=TranslateStr(977,MSysInfo.Hint);

 ALibraries.Caption:=SRpConfigLib;
 ALibraries.Hint:=SRpConfigLibH;
 AOpenFrom.Caption:=SRpOpenFrom;
 AOpenFrom.Hint:=SRpOpenFromH;
 ASaveTo.Caption:=SRpSaveTo;
 ASaveTo.Hint:=SRpSaveToH;

 ANewPageHeader.Caption:=TranslateStr(119,ANewPageHeader.Caption);
 ANewPageHeader.Hint:=TranslateStr(120,ANewPageHeader.Hint);
 ANewPageFooter.Caption:=TranslateStr(121,ANewPageFooter.Caption);
 ANewPageFooter.Hint:=TranslateStr(122,ANewPageFooter.Hint);
 ANewGroup.Caption:=TranslateStr(123,ANewGroup.Caption);
 ANewGroup.Hint:=TranslateStr(124,ANewGroup.Hint);
 ANewSubReport.Caption:=TranslateStr(125,ANewSubreport.Caption);
 ANewSubReport.Hint:=TranslateStr(126,ANewSubreport.Hint);
 ADeleteSelection.Caption:=TranslateStr(127,ADeleteSelection.Caption);
 ADeleteSelection.Hint:=TranslateStr(128,ADeleteSelection.Hint);
 ANewDetail.Caption:=TranslateStr(129,ANewDetail.Caption);
 ANewDetail.Hint:=TranslateStr(130,ANewDetail.Hint);
 ADataConfig.Caption:=TranslateStr(131,ADataConfig.Caption);
 ADataConfig.Hint:=TranslateStr(132,ADataConfig.Hint);
 AParams.Caption:=TranslateStr(133,Aparams.Caption);
 AParams.Hint:=TranslateStr(134,Aparams.Hint);
 AUserParams.Caption:=TranslateStr(135,AUserparams.Caption);
 AUserParams.Hint:=TranslateStr(136,AUserparams.Hint);
 MAdd.Caption:=TranslateStr(149,MAdd.Caption);
 SaveDialog1.Title:=TranslateStr(213,SaveDialog1.Title);
 OpenDialog1.Title:=TranslateStr(214,OpenDialog1.Title);

 // Activates OnHint
 oldonhint:=Application.OnHint;
 Application.OnHint:=AppHint;

 SetInitialBounds;
end;

procedure TFRpMainF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 LastUsedFiles.SaveToConfigFile(configfile);
 SaveConfig;
end;

procedure TFRpMainF.UpdateFileMenu;
var
 exitindex:integer;
 alist:TStringlist;
 aitem:TmenuItem;
 i:integer;
begin
 // Search the last menu item
 exitindex:=0;
 While File1.Items[exitindex].Action<>AExit do
 begin
  inc(exitindex);
  if exitindex>=File1.Count then
   raise Exception.Create(SrpErrorProcesingFileMenu);
 end;
 // Remove all the last items
 inc(exitindex);
 While exitindex<(File1.count) do
  File1.Items[exitindex].Free;
 // Add the files and the on click
 alist:=TStringList.create;
 try
  Lastusedfiles.FillWidthShortNames(alist,C_FILENAME_WIDTH);
  // Creation of menu items
  aItem:=TMenuItem.Create(Self);
  File1.Add(aitem);
  aItem.Caption:='-';
  for i:=0 to alist.count-1 do
  begin
   aItem:=TMenuItem.Create(Self);
   File1.Add(aitem);
   aItem.Caption:=alist.strings[i];
   aItem.Tag:=i;
   aItem.OnClick:=OnFileClick;
  end;
 finally
  alist.free;
 end;
end;

procedure TFRpMainF.OnFileClick(Sender:TObject);
var
 newfilename:string;
 apos:integer;
begin
 newfilename:=LastusedFiles.LastUsed.Strings[TComponent(Sender).tag];
 if Length(newfilename)<1 then
  exit;
 // Try to open the file
 apos:=Pos('->',newfilename);
 // Check if it's a database library report
 if apos=0 then
  DoOpen(newfilename,false)
 else
 begin
  DoOpenFromLib(Copy(newfilename,1,apos-1),Copy(newfilename,apos+2,Length(newfilename)));
 end;
end;

procedure TFRpMainF.RefreshInterface(Sender: TObject);
begin
 FreeInterface;
 CreateInterface;
 FormResize(self);
end;

procedure TFRpMainF.ANewPageHeaderExecute(Sender: TObject);
begin
 // Inserts a new page header
 Assert(report<>nil,'Called AddNew PageHeader without a report assigned');

 freportstructure.FindSelectedSubreport.AddPageHeader;

 RefreshInterface(Self);
end;

procedure TFRpMainF.ANewPageFooterExecute(Sender: TObject);
begin
 // Inserts a new page footer
 Assert(report<>nil,'Called AddNewPageFooter without a report assigned');

 freportstructure.FindSelectedSubreport.AddPageFooter;

 RefreshInterface(Self);
end;

procedure TFRpMainF.ANewGroupExecute(Sender: TObject);
var
 newgroupname:string;
begin
 // Inserts a new group header and footer
 Assert(report<>nil,'Called AddNewGroupout a report unassigned');

 newgroupname:=Uppercase(Trim(RpInputBox(SRpNewGroup,SRpSGroupName,'')));
 if length(newgroupname)>0 then
 begin
  freportstructure.FindSelectedSubreport.AddGroup(newgroupname);

  RefreshInterface(Self);
 end;
end;

procedure TFRpMainF.ANewSubreportExecute(Sender: TObject);
begin
 // Inserts a new group header and footer
 Assert(report<>nil,'Called AddSubReport a report unassigned');

 report.AddSubReport;

 RefreshInterface(Self);
end;

procedure TFRpMainF.ADeleteSelectionExecute(Sender: TObject);
begin
 // Deletes section
 Assert(report<>nil,'Called ADeleteSection a report unassigned');

 if RpMessageBox(SRpSureDeleteSection,SRpWarning,[smbok,smbcancel],smsWarning,smbCancel)=smbOk then
 begin
  freportstructure.DeleteSelectedNode;
  RefreshInterface(Self);
 end;
end;

procedure TFRpMainF.ANewDetailExecute(Sender: TObject);
begin
 // Inserts a new group header and footer
 Assert(report<>nil,'Called ADeleteSection a report unassigned');

 freportstructure.FindSelectedSubreport.AddDetail;

 RefreshInterface(Self);
end;

procedure TFRpMainF.ADataConfigExecute(Sender: TObject);
begin
 // Data info configuration dialog
 rpmdfdinfo.ShowDataConfig(report);
 fobjinsp.ClearMultiSelect;
 fdesignframe.UpdateSelection(true);
 fdesignframe.freportstructure.Report:=report;
end;

procedure TFRpMainF.AParamsExecute(Sender: TObject);
begin
{$IFDEF VCLANDCLX}
 if (ADriverGDI.Checked or ADriverPDFGDI.Checked) then
 begin
  rpfparamsvcl.ShowParamDef(report.Params,report.DataInfo);
  exit;
 end;
{$ENDIF}
 rpfparams.ShowParamDef(report.Params,report.DataInfo);
 fdesignframe.freportstructure.Report:=report;
end;

procedure TFRpMainF.AGridOptionsExecute(Sender: TObject);
begin
 fobjinsp.ClearMultiSelect;
{$IFDEF VCLANDCLX}
 if ((ADriverGDI.Checked or ADriverPDFGDI.Checked)) then
 begin
  rpmdfgridvcl.ModifyGridProperties(report);
  fdesignframe.UpdateSelection(true);
  exit;
 end;
{$ENDIF}
 rpmdfgrid.ModifyGridProperties(report);
 fdesignframe.UpdateSelection(true);
end;

procedure TFRpMainF.DeleteSelection;
var
 sectionintf:TRpSectionInterface;
 aitem:TRpSizePosInterface;
 alist:TStringList;
 i:integer;
begin
 alist:=TStringList.Create;
 try
  sectionintf:=nil;
  alist.Assign(fobjinsp.SelectedItems);
  fobjinsp.ClearMultiSelect;
  for i:=0 to alist.count-1 do
  begin
   aitem:=TRpSizePosInterface(alist.Objects[i]);
   sectionintf:=TRpSectionInterface(aitem.SectionInt);
   TRpSection(sectionintf.printitem).DeleteComponent(aitem.printitem);
   sectionintf.DeleteChild(aitem);
  end;
  if assigned(sectionintf) then
   fobjinsp.AddCompItem(sectionintf,true);
 finally
  alist.free;
 end;
 fdesignframe.UpdateSelection(true);
end;

procedure TFRpMainF.ACutExecute(Sender: TObject);
begin
 // Delete current selection
 if fobjinsp.SelectedItems.Count<1 then
  exit;
 if (Not (fobjinsp.SelectedItems.Objects[0] is TRpSizePosInterface)) then
  exit;
 ACopy.Execute;
 DeleteSelection;
end;

procedure TFRpMainF.ACopyExecute(Sender: TObject);
var
 pitem:TRpCommonComponent;
 acompo:TComponent;
 i:integer;
begin
 if fobjinsp.SelectedItems.Count<1 then
  exit;
 if (Not (fobjinsp.SelectedItems.Objects[0] is TRpSizePosInterface)) then
  exit;
 acompo:=TRpReport.Create(nil);
 try
  report.IsDesignTime:=true;
  acompo.Name:='TheOwner';
  for i:=0 to fobjinsp.SelectedItems.Count-1 do
  begin
   pitem:=TRpSizePosInterface(fobjinsp.SelectedItems.Objects[i]).printitem;
   pitem.oldowner:=pitem.owner;
   pitem.owner.Removecomponent(pitem);
   acompo.InsertComponent(pitem);
  end;
  Clipboard.SetComponent(acompo);
  for i:=0 to fobjinsp.SelectedItems.Count-1 do
  begin
   pitem:=TRpSizePosInterface(fobjinsp.SelectedItems.Objects[i]).printitem;
   acompo.RemoveComponent(pitem);
   pitem.oldowner.Insertcomponent(pitem);
  end;
 finally
  acompo.free;
 end;
end;

procedure TFRpMainF.APasteExecute(Sender: TObject);
var
 section:TRpSection;
 secint:TRpSectionInterface;
 compo:TComponent;
 acompo:TComponent;
 i:integer;
 alist:TList;
 pitem:TRpCommonPosComponent;
 ident:String;
begin
 if fobjinsp.SelectedItems.Count<1 then
  exit;
 if (fobjinsp.SelectedItems.Objects[0] is TRpSectionInterface) then
 begin
  secint:=TRpSectionInterface(fobjinsp.CompItem);
 end
 else
 begin
  secint:=TRpSectionInterface(TRpSizePosInterface(fobjinsp.SelectedItems.Objects[0]).SectionInt);
 end;
 fobjinsp.ClearMultiSelect;
 section:=TrpSection(secint.printitem);
 acompo:=TRpReport.Create(nil);
 try
  report.IsDesignTime:=true;
  acompo.Name:='AOwner';
  compo:=Clipboard.GetComponent(acompo,acompo);
  alist:=TList.Create;
  try
   for i:=0 to compo.ComponentCount-1 do
   begin
    alist.Add(compo.Components[i]);
    if compo.Components[i] is TRpExpression then
    begin
     ident:=TRpExpression(compo.Components[i]).Identifier;
     if Length(ident)>0 then
     begin
      if report.Identifiers.IndexOf(ident)>=0 then
       TRpExpression(compo.Components[i]).Identifier:='';
     end;
    end;
   end;
   for i:=0 to alist.Count-1 do
   begin
    if (not (TObject(alist.items[i]) is TrpCommonPosComponent)) then
    begin
     Raise Exception.Create(SRpInvalidClipboardFormat+':'+TObject(alist.items[i]).ClassName);
    end;
    pitem:=TrpCommonPosComponent(alist.Items[i]);
    compo.RemoveComponent(pitem);
    pitem.Name:='';
    (section.ReportComponents.Add).Component:=pitem;
    if section.IsExternal then
     section.InsertComponent(pitem)
    else
     report.InsertComponent(pitem);
    Generatenewname(pitem);
    TFRpObjInsp(fobjinsp).AddCompItem(secint.CreateChild(pitem),false);
   end;
//   fdesignframe.UpdateSelection(true);
  finally
   alist.Free;
  end;
 finally
  acompo.Free;
 end;
end;

procedure TFRpMainF.Splitter1Moved(Sender: TObject);
begin
 CorrectScrollBoxes;
end;

procedure TFRpMainF.OnReadError(Reader: TReader; const Message: string;
    var Handled: Boolean);
begin
 Handled:=RpMessageBox(SRpErrorReadingReport+#10+Message+#10+SRpIgnoreError,SRpWarning,[smbYes,smbNo],smsWarning,smbYes)=smbYes;
end;

procedure TFRpMainF.APreviewExecute(Sender: TObject);
var
 modified:Boolean;
 previewmodify:Boolean;
 prcontrol:TRpPreviewControlCLX;
begin
 if (report.DatabaseInfo.Count>0) then
 begin
  if report.DatabaseInfo.Items[0].Driver in [rpdatadriver,rpdotnet2driver] then
  begin
   if (report.DatabaseInfo.Items[0].Driver=rpdatadriver) then
    ExecuteReportDotNet(report,true,1)
   else
    ExecuteReportDotNet(report,true,2);
   exit;
  end;
 end;
 // Previews the report
{$IFDEF VCLANDCLX}
 if ADriverGDI.Checked then
 begin
  rpvpreview.ShowPreview(report,caption,modified);
  if modified then
  begin
   fdesignframe.UpdateInterface(true);
   fdesignframe.UpdateSelection(false);
  end;
  exit;
 end
 else
 begin
  if ADriverPDFGDI.Checked then
  begin
   if rpgdidriver.CalcReportWidthProgress(report) then
    rpfmainmetaviewvcl.PreviewMetafile(report.metafile,nil,true,true);
   exit;
  end
 end;
{$ENDIF}
 if ADriverQt.Checked then
 begin
  previewmodify:=false;
  prcontrol:=TRpPreviewControlCLX.Create(nil);
  try
   prcontrol.Report:=Report;
   rppreview.ShowPreview(prcontrol,caption,ASystemPrintDialog.Checked);
   if previewmodify then
   begin
    fdesignframe.UpdateInterface(true);
    fdesignframe.UpdateSelection(false);
   end;
  finally
   prcontrol.free;
  end;
 end
 else
 begin
  if rpqtdriver.CalcReportWidthProgress(report) then
   rpfmainmetaview.PreviewMetafile(report.metafile,nil,true,true);
  exit;
 end
end;

procedure TFRpMainF.AAboutExecute(Sender: TObject);
begin
 ShowAbout;
end;

procedure TFRpMainF.APrintExecute(Sender: TObject);
var
 allpages,collate:boolean;
 frompage,topage,copies:integer;
 dook:boolean;
{$IFDEF LINUX}
 memstream:tmemoryStream;
 metafile:TRpMetafileReport;
{$ENDIF}
begin
 if (report.DatabaseInfo.Count>0) then
 begin
  if report.DatabaseInfo.Items[0].Driver in [rpdatadriver,rpdotnet2driver] then
  begin
   if report.DatabaseInfo.Items[0].Driver=rpdatadriver then
    ExecuteReportDotNet(report,false,1)
   else
    ExecuteReportDotNet(report,false,2);
   exit;
  end;
 end;
{$IFDEF LINUX}
 if usekprinter then
 begin
   metafile:=TRpMetafileReport.Create(nil);
   try
    memstream:=tmemoryStream.Create;
    try
     rppdfdriver.PrintReportMetafileStream(report,'',false,true,1,9999,1,memstream,false,false);
     memstream.Seek(0,soFromBeginning);
     metafile.LoadFromStream(memstream);
    finally
     memstream.free;
    end;
    // Use kprinter to print the file
    PrintMetafileUsingKPrinter(metafile);
   finally
    metafile.free;
   end;
 end
 else
{$ENDIF}
 begin
{$IFDEF VCLANDCLX}
 if ((ADriverGDI.Checked) or (ADriverPDFGDI.Checked)) then
 begin
  allpages:=true;
  collate:=report.CollateCopies;
  frompage:=1; topage:=999999;
  copies:=report.Copies;
  rpgdidriver.PrinterSelection(report.PrinterSelect,report.PaperSource,report.Duplex);
  if rpgdidriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate) then
   rpgdidriver.PrintReport(report,Caption,true,allpages,frompage,topage,copies,collate);
  exit;
 end;
{$ENDIF}
 allpages:=true;
 collate:=report.CollateCopies;
 frompage:=1; topage:=999999;


{$IFDEF HORZPAPERBUG}
 if report.PageOrientation=rpOrientationPortrait then
 begin
  printer.Orientation:=poPortrait;
 end
 else
  if report.PageOrientation=rpOrientationLandscape then
  begin
   printer.Orientation:=poLandscape;
  end;
{$ENDIF}

 copies:=report.Copies;
 rpqtdriver.PrinterSelection(report.PrinterSelect);
 if ASystemPrintDialog.Checked then
  dook:=rpqtdriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate)
 else
  dook:=rpprintdia.DoShowPrintDialog(allpages,frompage,topage,copies,collate);
 if dook then
  rpqtdriver.PrintReport(report,Caption,true,allpages,frompage,topage,copies,collate);
 end
end;

function TFRpMainF.GetExpressionText:string;
var
 anode:TTreeNode;
begin
 Result:='2+2';
 if Assigned(freportstructure) then
 begin
  anode:=freportstructure.browser.ATree.Selected;
  if assigned(anode) then
   Result:=ExtractFieldNameEx(anode.Text);
 end;
end;

procedure TFRpMainF.ShowDoc(document:String);
var
 aurl:string;
 Directorysep:string;
begin
 if not MDoc.Visible then
  exit;
 aurl:=ExtractFilePath(Application.Exename);
{$IFDEF MSWINDOWS}
 Directorysep:='\';
{$ENDIF}
{$IFDEF LINUX}
 Directorysep:='/';
{$ENDIF}
 aurl:=aurl+'doc'+Directorysep+document;
 if FileExists(aurl) then
  ShowHelp(aurl)
 else
  ShowHelp(REPMAN_WEBSITE+'/doc/'+document);
end;

procedure TFRpMainF.HelpOnIdle(Sender:TObject;var done:Boolean);
begin
 Application.OnIdle:=oldappidle;
 done:=false;
 if Length(FHelp.TextBrowser1.Text)=0 then
 begin
  if Copy(HighLightText,1,7)='http://' then
  begin
   ShowHelp(HighLightText);
   FHelp.TextBrowser1.Filename:=OldHelpFilename;
  end;
 end;
end;

procedure TFRpMainF.OnHelpClick(Sender:TObject);
begin
 oldappidle:=Application.OnIdle;
 Application.OnIdle:=HelpOnIdle;
end;

procedure TFRpMainF.OnHighLightText(Sender: TObject;
 const HighlightedText: WideString);
begin
 if Length(HighLightedText)>0 then
 begin
  HighLightText:=HighlightedText;
  OldHelpFilename:=FHelp.TextBrowser1.Filename;
 end;
end;

procedure TFRpMainF.ShowHelp(AURL:string);
begin
 if Not (AURL='http://') then
 begin
  if FileExists(AURL) then
  begin
   if Not Assigned(FHelp) then
   begin
    FHelp:=TFRpHelpform.Create(Application);
    FHelp.TextBrowser1.OnHighLightText:=OnHighLightText;
    FHelp.TextBrowser1.OnClick:=OnHelpClick;
   end;
   FHelp.TextBrowser1.FileName:=AURL;
   if Length(FHelp.TextBrowser1.Text)<1 then
   begin
    FHelp.TextBrowser1.Text:=SRpDocNotInstalled+#10+
     SRpDocNotInstalled2+#10+
    SRpDocNotInstalled3+#10;
   end;
   FHelp.Show;
   exit;
  end;
 end;
{$IFDEF LINUX}
  Libc.system(PChar('konqueror "'+aurl+'"&'))
{$ENDIF}
{$IFDEF MSWINDOWS}
  ShellExecute(0,Pchar('open'),Pchar(aurl),
   nil,nil,SW_SHOWNORMAL);
{$ENDIF}
end;

procedure TFRpMainF.ADocumentationExecute(Sender: TObject);
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
  'left.html';
 if FileExists(aurl) then
  ShowHelp(aurl)
 else
  ShowHelp(REPMAN_WEBSITE);
end;

procedure TFRpMainF.AFeaturesExecute(Sender: TObject);
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
 aurl:=aurl+'doc'+Directorysep+'features.html';
 ShowHelp(aurl);
end;

procedure TFRpMainF.APrintSetupExecute(Sender: TObject);
{$IFDEF VCLANDCLX}
var
 psetup:TPrinterSetupDialog;
{$ENDIF}
begin
{$IFDEF VCLANDCLX}
 if ((ADriverGDI.Checked or ADriverPDFGDI.Checked)) then
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

procedure TFRpMainF.LoadConfig;
var
 inif:TInifile;
 deffontsize:Integer;
begin
 inif:=TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
 try
  MDoc.Visible:=inif.ReadBool('CONFIG','ShowAboutBox',true);
  MAbout.Visible:=inif.ReadBool('CONFIG','ShowDocumentation',true);
 finally
  inif.free;
 end;
 inif:=TIniFile.Create(configfile);
 try
  deffontsize:=Self.Font.Size;
  if Screen.PixelsPerInch>90 then
  begin
   deffontsize:=8;
  end;
  MTypeInfo.Checked:=inif.ReadBool('Preferences','TypeInfo',true);  
  MAsync.Checked:=inif.ReadBool('Preferences','Async',false);
  FAppFontName:=inif.ReadString('Preferences','AppFontName',Self.Font.Name);
  FAppFontSize:=inif.ReadInteger('Preferences','AppFontSize',deffontsize);
  FAppFontColor:=inif.ReadInteger('Preferences','AppFontColor',Self.Font.Color);
  if FAppFontSize<3 then
   FAppFontSize:=8;
  FAppFontStyle:=inif.ReadInteger('Preferences','AppFontStyle',FontStyleToInteger(Self.Font.Style));

  FObjFontName:=inif.ReadString('Preferences','ObjFontName',Self.Font.Name);
  FObjFontSize:=inif.ReadInteger('Preferences','ObjFontSize',7);
  FObjFontColor:=inif.ReadInteger('Preferences','ObjFontColor',Self.Font.Color);
  if FObjFontSize<3 then
   FObjFontSize:=8;
  FObjFontStyle:=inif.ReadInteger('Preferences','ObjFontStyle',FontStyleToInteger(Self.Font.Style));

  UpdateFonts;

  AUnitCms.Checked:=inif.ReadBool('Preferences','UnitCms',true);
  ADriverQt.Checked:=false;
  ADriverGDI.Checked:=false;
  ADriverPDFQt.Checked:=false;
  ADriverPDFGDI.Checked:=false;
{$IFDEF LINUX}
  ADriverPDFQT.Checked:=inif.ReadBool('Preferences','DriverPDFQt',false);
  ADriverQT.Checked:=Not ADriverPDFQT.Checked;
{$ENDIF}
{$IFDEF MSWINDOWS}
{$IFDEF VCLANDCLX}
  ADriverPDFQt.Checked:=inif.ReadBool('Preferences','DriverPDFQt',false);
  ADriverQt.Checked:=inif.ReadBool('Preferences','DriverQt',false);
  ADriverGDI.Checked:=inif.ReadBool('Preferences','DriverGDI',false);
//  ADriverPDFGDI.Checked:=inif.ReadBool('Preferences','DriverPDFGDI',false);
  ADriverPDFGDI.Checked:=Not (ADriverPDFQt.Checked or ADriverQt.Checked or ADriverGDI.Checked);
{$ENDIF}

{$IFNDEF VCLANDCLX}
  ADriverPDFQt.Checked:=inif.ReadBool('Preferences','DriverPDFQt',false);
  ADriverQt.Checked:=inif.ReadBool('Preferences','DriverQt',true);
  ADriverGDI.Visible:=false;
  ADriverPDFGDI.Visible:=false;
{$ENDIF}
{$ENDIF}
  AsystemPrintDialog.Checked:=True;
  AsystemPrintDialog.Checked:=inif.ReadBool('Preferences','SystemPrintDialog',True);
  BStatus.Visible:=inif.ReadBool('Preferences','StatusBar',True);
  AStatusBar.Checked:=BStatus.Visible;
{$IFDEF LINUX}
  AKylixPrintBug.Checked:=inif.ReadBool('Preferences','KylixPrintBug',False);
  rpqtdriver.kylixprintbug:=AKylixPrintBug.Checked;
{$ENDIF}
  AUnitsinchess.Checked:=Not AUnitCms.Checked;
  AppStyle:=TDefaultStyle(inif.ReadInteger('Preferences','QtStyle',Integer(dsSystemDefault)));
  UpdateStyle;
  UpdateUnits;
  // Read library configuration
  RpAlias1.Connections.LoadFromFile(configfilelib);
 finally
  inif.free;
 end;
end;

procedure TFRpMainF.SaveConfig;
var
 inif:TInifile;
begin
 inif:=TIniFile.Create(configfile);
 try
  inif.WriteBool('Preferences','TypeInfo', MTypeInfo.Checked);
  inif.WriteBool('Preferences','Async', MAsync.Checked);
  inif.WriteString('Preferences','AppFontName',FAppFontName);
  inif.WriteInteger('Preferences','AppFontSize',FAppFontSize);
  inif.WriteInteger('Preferences','AppFontColor',FAppFontColor);
  inif.WriteInteger('Preferences','AppFontStyle',FAppFontStyle);
  inif.WriteString('Preferences','ObjFontName',FAppFontName);
  inif.WriteInteger('Preferences','ObjFontSize',FObjFontSize);
  inif.WriteInteger('Preferences','ObjFontColor',FObjFontColor);
  inif.WriteInteger('Preferences','ObjFontStyle',FObjFontStyle);

  inif.WriteBool('Preferences','UnitCms',AUnitCms.Checked);
  inif.WriteBool('Preferences','DriverQT',ADriverQT.Checked);
  inif.WriteBool('Preferences','DriverGDI',ADriverGDI.Checked);
  inif.WriteBool('Preferences','DriverPDFGDI',ADriverPDFGDI.Checked);
  inif.WriteBool('Preferences','DriverPDFQt',ADriverPDFQt.Checked);
  inif.WriteBool('Preferences','SystemPrintDialog',AsystemPrintDialog.Checked);
  inif.WriteBool('Preferences','StatusBar',BStatus.Visible);
  inif.WriteBool('Preferences','KylixPrintBug',AKylixPrintBug.Checked);
  inif.WriteInteger('Preferences','QtStyle',Integer(AppStyle));
  inif.UpdateFile;
 finally
  inif.free;
 end;
 RpAlias1.Connections.SaveToFile(configfilelib);
end;


procedure TFRpMainF.UpdateUnits;
begin
 if assigned(fobjinsp) then
  fobjinsp.ClearMultiSelect;
 if AUnitCms.Checked then
  rpmunits.defaultunit:=rpUnitcms
 else
  rpmunits.defaultunit:=rpUnitinchess;
 if assigned(fdesignframe) then
 begin
  fdesignframe.UpdateInterface(true);
  fdesignframe.UpdateSelection(true);
 end;
end;


procedure TFRpMainF.AUnitCmsExecute(Sender: TObject);
begin
 AUnitCms.Checked:=true;
 AUnitsInchess.Checked:=false;
 UpdateUnits;
end;

procedure TFRpMainF.AUnitsinchessExecute(Sender: TObject);
begin
 AUnitCms.Checked:=false;
 AUnitsInchess.Checked:=true;
 UpdateUnits;
end;

procedure TFRpMainF.CorrectScrollBoxes;
begin
 if assigned(fdesignframe) then
 begin
  // A bug in aligments CLX Windows and Linux Still present in D7/K3
  // forced me to include this corrections
  // To reproduce the bug
  // Maximize, open a report, select text control and restore
  // the top ruler will disapear
   fdesignframe.SectionScrollBox.HorzScrollBar.Position:=0;
   fdesignframe.SectionScrollBox.VertScrollBar.Position:=0;
   fdesignframe.SectionScrollBox.Align:=alnone;
   fdesignframe.HorzScrollBar.Position:=0;
   fdesignframe.VertScrollBar.Position:=0;
   fdesignframe.SectionScrollBox.Align:=alClient;
   HorzScrollBar.Position:=0;
   VertScrollBar.Position:=0;
   MainScrollBox.HorzScrollBar.Position:=0;
   MainScrollBox.VertScrollBar.Position:=0;
   LeftPanel.Left:=0;
   Splitter1.Left:=20;
   ToolBar1.Left:=0;
 end;
end;


procedure TFRpMainF.FormResize(Sender: TObject);
begin
 if assigned(fdesignframe) then
 begin
  fdesignframe.UpdateInterface(true);
  CorrectScrollBoxes;
 end;
end;

procedure TFRpMainF.AUserParamsExecute(Sender: TObject);
begin
{$IFDEF VCLANDCLX}
 if ((ADriverGDI.Checked or ADriverPDFGDI.Checked)) then
 begin
  rprfvparams.ShowUserParams(report.params);
  exit;
 end;
{$ENDIF}
 rprfparams.ShowUserParams(report.params);
end;

procedure TFRpMainF.ADriverQTExecute(Sender: TObject);
begin
 ADriverQT.Checked:=true;
 ADriverGDI.Checked:=false;
 ADriverPDFGDI.Checked:=false;
 ADriverPDFQT.Checked:=false;
end;

procedure TFRpMainF.ADriverGDIExecute(Sender: TObject);
begin
 ADriverGDI.Checked:=true;
 ADriverQT.Checked:=false;
 ADriverPDFGDI.Checked:=false;
 ADriverPDFQT.Checked:=false;
end;

procedure TFRpMainF.ASystemPrintDialogExecute(Sender: TObject);
begin
 ASystemPrintDialog.Checked:=Not ASystemPrintDialog.Checked;
end;

procedure TFRpMainF.AkylixPrintBugExecute(Sender: TObject);
begin
 AKylixPrintBug.Checked:=Not AKylixPrintBug.Checked;
 rpqtdriver.kylixprintbug:=AKylixPrintBug.Checked;
end;


procedure TFRpMainF.UpdateStyle;
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


procedure TFRpMainF.Windows1Click(Sender: TObject);
begin
 // Sets the style
 AppStyle:=TDefaultStyle((Sender As TComponent).Tag);
 UpdateStyle;
end;

procedure TFRpMainF.AHideExecute(Sender: TObject);
var
 i:integer;
begin
 if fobjinsp.SelectedItems.Count<1 then
  exit;
 if (Not (fobjinsp.SelectedItems.Objects[0] is TRpSizePosInterface)) then
  exit;
 for i:=0 to fobjinsp.SelectedItems.Count-1 do
 begin
  TRpSizePosInterface(fobjinsp.SelectedItems.Objects[i]).Visible:=false;
  TRpSizePosInterface(fobjinsp.SelectedItems.Objects[i]).PrintItem.Visible:=false;
 end;
 fobjinsp.ClearMultiselect;
 fobjinsp.fchangesize.Control:=nil;
end;

procedure TFRpMainF.AShowAllExecute(Sender: TObject);
begin
 // Shows all components
 fdesignframe.ShowAllHiden;
end;


procedure TFRpMainf.MyExceptionHandler(Sender:TObject;E:Exception);
var
 compo:TComponent;
 subrep:TRpSubreport;
 sec,secsel:TRpSection;
 secint:TRpSectionInterface;
 printitem:TRpCommonComponent;
 i,j,k:integer;
 secintitem:TRpSizePosInterface;
begin
 // Looks the exception type
 if ((E is TRpReportException) And Assigned(fdesignframe) )then
 begin
  compo:=TRpReportException(E).Component;
  if compo is TRpSubReport then
  begin
   subrep:=TRpSubReport(compo);
   freportstructure.SelectDataItem(subrep);
   fobjinsp.SelectProperty(TRpReportException(E).PropertyName);
  end
  else
  begin
   // If is a section
   if compo is TRpSection then
   begin
    sec:=TRpSection(compo);
    freportstructure.SelectDataItem(sec);
    fobjinsp.SelectProperty(TRpReportException(E).PropertyName);
   end
   else
   begin
    if (compo is TRpCommonComponent) then
    begin
     printitem:=TRpCommonComponent(compo);
     secsel:=nil;
     for i:=0 to report.SubReports.Count-1 do
     begin
      subrep:=report.SubReports.Items[i].SubReport;
      for j:=0 to subrep.Sections.Count-1 do
      begin
       sec:=subrep.Sections.Items[j].Section;
       for k:=0 to sec.ReportComponents.Count-1 do
       begin
        if printitem=sec.ReportComponents.Items[k].Component then
        begin
         secsel:=sec;
         break;
        end;
       end;
       if Assigned(secsel) then
        break;
      end;
      if Assigned(secsel) then
      begin
       freportstructure.SelectDataItem(secsel);
       if Assigned(fobjinsp.CompItem) then
        if (fobjinsp.CompItem is TRpSectionInterface) then
        begin
         secint:=TRpSectionInterface(fobjinsp.CompItem);
         for j:=0 to secint.childlist.Count-1 do
         begin
          secintitem:=TRpSizePosInterface(secint.Childlist.Items[j]);
          if secintitem.printitem=printitem then
          begin
           secintitem.DoSelect;
           fobjinsp.SelectProperty(TRpReportException(E).PropertyName);
           break;
          end;
         end;
        end;
      end;
     end;
    end;
   end;
  end;

 end;
 if assigned(oldonexception) then
 begin
  oldonexception(Sender,E);
 end
 else
  RpMessageBox(E.Message,SRpError,[smbok]);
end;


procedure TFRpMainF.FormDestroy(Sender: TObject);
begin
 Application.OnException:=oldonexception;
 Application.OnHint:=oldonhint;
end;

procedure TFRpMainF.ASelectAllExecute(Sender: TObject);
begin
 // Selects all objects of the report
 fobjinsp.SelectAllClass('TRpSizePosInterface');
end;


procedure TFRpMainF.ASelectAllTextExecute(Sender: TObject);
begin
 // Selects all objects of the report
 fobjinsp.SelectAllClass('TRpGenTextInterface');
end;

procedure TFRpMainF.ALeftExecute(Sender: TObject);
begin
 fobjinsp.MoveSelected(1,false);
end;

procedure TFRpMainF.ARightExecute(Sender: TObject);
begin
 fobjinsp.MoveSelected(2,false);
end;

procedure TFRpMainF.AUpExecute(Sender: TObject);
begin
 fobjinsp.MoveSelected(3,false);
end;

procedure TFRpMainF.ADownExecute(Sender: TObject);
begin
 fobjinsp.MoveSelected(4,false);
end;

procedure TFRpMainF.AAlignLeftExecute(Sender: TObject);
begin
 fobjinsp.AlignSelected(1);
end;

procedure TFRpMainF.AAlignRightExecute(Sender: TObject);
begin
 fobjinsp.AlignSelected(2);
end;

procedure TFRpMainF.AAlignUpExecute(Sender: TObject);
begin
 fobjinsp.AlignSelected(3);
end;

procedure TFRpMainF.AAlignDownExecute(Sender: TObject);
begin
 fobjinsp.AlignSelected(4);
end;

procedure TFRpMainF.AAlignHorzExecute(Sender: TObject);
begin
 fobjinsp.AlignSelected(5);
end;

procedure TFRpMainF.AAlignVertExecute(Sender: TObject);
begin
 fobjinsp.AlignSelected(6);
end;

procedure TFRpMainF.AppHint(Sender:TObject);
begin
 BStatus.Panels.Items[0].Text:=Application.Hint;
end;

procedure TFRpMainF.AStatusBarExecute(Sender: TObject);
begin
 AStatusBar.Checked:=Not AStatusBar.Checked;
 BStatus.Visible:=ASTatusBar.Checked;
end;


procedure TFRpMainF.ADriverPDFGDIExecute(Sender: TObject);
begin
 ADriverGDI.Checked:=false;
 ADriverQT.Checked:=false;
 ADriverPDFGDI.Checked:=true;
 ADriverPDFQT.Checked:=false;
end;

procedure TFRpMainF.ADriverPDFQtExecute(Sender: TObject);
begin
 ADriverGDI.Checked:=false;
 ADriverQT.Checked:=false;
 ADriverPDFGDI.Checked:=false;
 ADriverPDFQT.Checked:=true;
end;

procedure TFRpMainF.FormShow(Sender: TObject);
begin
 if browsecommandline then
 begin
  if Length(ParamStr(1))>0 then
  begin
   try
    DoOpen(ParamStr(1),false);
   except
    on E:Exception do
    begin
     RpMessageBox(E.Message);
    end;
   end;
  end;
 end;
 // Bugfix to reposition the
 // tool bar and menu
 Width:=Width+1;
 FormResize(Self);
 // Bugfix but removed because kylix unofficial bugfixes
 // loops for about 5 seconds waiting an event
// WindowState:=wsMaximized;
 // New functionality test
 oldappidle:=Application.OnIdle;
 Application.OnIdle:=IdleMaximize;
end;

procedure TFRpMainF.IdleMaximize(Sender:TObject;var done:Boolean);
begin
 done:=false;
 Application.OnIdle:=oldappidle;

 WindowState:=wsMaximized;
end;

procedure TFRpMainF.ASysInfoExecute(Sender: TObject);
begin
 RpShowSystemInfoQt;
end;



procedure TFRpMainF.AAlign1_6Execute(Sender: TObject);
begin
 report.AlignSectionsTo(report.LinesPerInch);
 RefreshInterface(Self);
end;

procedure TFRpMainF.ALibrariesExecute(Sender: TObject);
begin
 ShowModifyConnections(RPalias1.Connections);
 SaveConfig;
end;

procedure TFRpMainF.ADeleteExecute(Sender: TObject);
begin
 // Delete current selection
 if fobjinsp.SelectedItems.Count<1 then
  exit;
 if (Not (fobjinsp.SelectedItems.Objects[0] is TRpSizePosInterface)) then
  exit;
 DeleteSelection;
end;

procedure TFRpMainF.AOpenFromExecute(Sender: TObject);
var
 alibname:String;
 arepname:WideString;
begin
 if Not checksave then
  exit;
 arepname:=SelectReportFromLibrary(rpalias1.Connections,alibname);
 if Length(arepname)<1 then
  exit;
 DoOpenFromLib(alibname,arepname);
end;

procedure TFRpMainF.ASaveToExecute(Sender: TObject);
var
 arepname,oldrepname:WideString;
 alibname,oldlibname,oldfilename:String;
begin
 arepname:=SelectReportFromLibrary(rpalias1.Connections,alibname);
 if Length(arepname)<1 then
  exit;
 try
  oldlibname:=alibrary;
  oldrepname:=areportname;
  oldfilename:=filename;
  filename:='';
  alibrary:=alibname;
  areportname:=arepname;
  DoSave;
 except
  alibrary:=oldlibname;
  areportname:=oldrepname;
  filename:=oldfilename;
  raise;
 end;
end;

procedure TFRpMainF.DoOpenFromLib(alibname:String;arepname:WideString);
var
 oldfilename:String;
 oldreportname:WideString;
 oldlibraryname:String;
 astream:TStream;
begin
 if Not checksave then
  exit;
 oldfilename:=filename;
 oldreportname:=areportname;
 oldlibraryname:=alibrary;
 try
  alibrary:=alibname;
  areportname:=arepname;
  astream:=rpalias1.Connections.GetReportStream(alibrary,areportname,nil);
  try
   filename:='';
   DoOpenStream(astream);
   Savedialog1.filename:='';
   LastUsedFiles.UseString(alibrary+'->'+areportname);
   UpdateFileMenu;
  finally
   astream.free;
  end;
 except
  alibrary:=oldlibraryname;
  areportname:=oldreportname;
  filename:=oldfilename;
  raise;
 end;
end;

procedure TFRpMainF.DoOpenStream(astream:TStream);
begin
 // Creates a new report
 FreeInterface;
 report.free;
 report:=nil;
 DoDisable;
 report:=TRpReport.Create(Self);
 try
  report.AsyncExecution:=MAsync.Checked;
  report.IsDesignTime:=true;
  report.OnReadError:=OnReadError;
  report.FailIfLoadExternalError:=false;
  report.LoadFromStream(astream);
  DoEnable;
 except
  report.free;
  report:=nil;
  filename:='';
  raise;
 end;
end;

procedure TFRpMainF.DoOpen(newfilename:string;showopendialog:boolean);
var
 astream:TFileStream;
 oldfilename:String;
begin
 if Not checksave then
  exit;
 // Opens an existing report
 if Showopendialog then
 begin
  if Not OpenDialog1.execute then
   Raise EAbort.Create(SRpAbort);
  newfilename:=OpenDialog1.Filename;
 end
 else
  OpenDialog1.Filename:=newfilename;
 astream:=TFileStream.Create(OpenDialog1.Filename,fmOpenRead);
 try
  oldfilename:=filename;
  try
   filename:=newfilename;
   DoOpenStream(astream);
  except
   filename:=oldfilename;
   raise;
  end;
  alibrary:='';
  areportname:='';
  Savedialog1.filename:=filename;
  LastUsedFiles.UseString(filename);
  UpdateFileMenu;
 finally
  astream.free;
 end;
end;

procedure TFRpMainF.MAppFontClick(Sender: TObject);
begin
 FontDialog1.Font.Assign(Self.Font);
 if FontDialog1.Execute then
 begin
  FAppFontName:=FontDialog1.Font.Name;
  FAppFontSize:=FontDialog1.Font.Size;
  FAppFontColor:=FontDialog1.Font.Color;
  if FAppFontSize<3 then
   FAppFontSize:=8;
  FAppFontStyle:=FontStyleToInteger(FontDialog1.Font.Style);
  UpdateFonts;
 end;
end;

procedure TFRpMainF.MObjFontClick(Sender: TObject);
begin
 FontDialog1.Font.Name:=FObjFontName;
 FontDialog1.Font.Size:=FObjFontSize;
 FontDialog1.Font.Color:=FObjFontColor;
 FontDialog1.Font.Style:=IntegerToFontStyle(FObjFontStyle);
 if FontDialog1.Execute then
 begin
  FObjFontName:=FontDialog1.Font.Name;
  FObjFontSize:=FontDialog1.Font.Size;
  FObjFontColor:=FontDialog1.Font.Color;
  if FObjFontSize<3 then
   FObjFontSize:=8;
  FObjFontStyle:=FontStyleTOInteger(FontDialog1.Font.Style);
  UpdateFonts;
 end;
end;

procedure TFRpMainF.MTypeInfoClick(Sender: TObject);
begin
 MTypeInfo.Checked:=Not MTypeInfo.Checked;

 if Assigned(freportstructure) then
 begin
  freportstructure.browser.showdatatypes:=MTypeInfo.Checked;
 end;
end;




{$IFDEF LINUX}
procedure ExecuteReportDotNet(report:TRpReport;preview:boolean;version:integer);
var
 aparams:TStringList;
 astring:string;
begin
 aparams:=TStringList.Create;
 try
  aparams.Add('mono');
  if version=1 then
   aparams.Add(ExtractFilePath(Application.exename)+'net/printreport.exe')
  else
   aparams.Add(ExtractFilePath(Application.exename)+'net2/printreport.exe');
  astring:=RpTempFileName;
  report.StreamFormat:=rpStreamXML;
  report.SaveToFile(astring);
  if preview then
   aparams.Add('-preview');
  aparams.Add(astring);
  ExecuteSystemApp(aparams,true);
 finally
  aparams.free;
 end;
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
procedure ExecuteReportDotNet(report:TRpReport;preview:boolean;version:integer);
var
 startinfo:TStartupinfo;
 linecount:string;
 tempstring:string;
 index:integer;
 exitcode:DWORD;
 numerror:integer;
 FExename,FCommandLine:string;
 memstream:TMemoryStream;
 procesinfo:TProcessInformation;
 astring:string;
begin
  linecount:='';
    with startinfo do
    begin
     cb:=sizeof(startinfo);
     lpReserved:=nil;
     lpDesktop:=nil;
     lpTitle:=PChar('Report manager');
     dwX:=0;
     dwY:=0;
     dwXSize:=400;
     dwYSize:=400;
     dwXCountChars:=80;
     dwYCountChars:=25;
     dwFillAttribute:=FOREGROUND_RED or BACKGROUND_RED or BACKGROUND_GREEN or BACKGROUND_BLUe;
     dwFlags:=STARTF_USECOUNTCHARS or STARTF_USESHOWWINDOW;
     cbReserved2:=0;
     lpreserved2:=nil;
    end;
    if version=1 then
     FExename:=ExtractFilePath(Application.exename)+'net\printreport.exe'
    else
     FExename:=ExtractFilePath(Application.exename)+'net2\printreport.exe';
    astring:=RpTempFileName;
    report.StreamFormat:=rpStreamXML;
    report.SaveToFile(astring);
    if preview then
     FCommandLine:=' -preview "'+astring+'"'
    else
     FCommandLine:='  "'+astring+'"';

    // Creates the interbase command line proces
    if Not CreateProcess(Pchar(FExename),Pchar(Fcommandline),nil,nil,True,NORMAL_PRIORITY_CLASS or CREATE_NEW_PROCESS_GROUP,nil,nil,
    startinfo,procesinfo) then
     RaiseLastOSError;
end;
{$ENDIF}

procedure TFRpMainF.MAsyncClick(Sender: TObject);
begin
 MAsync.Checked:=not MAsync.Checked;
 if Assigned(report) then
 begin
  report.AsyncExecution:=MAsync.Checked;
 end;
end;

procedure TFRpMainF.ComboScaleClick(Sender: TObject);
begin
 if Assigned(fdesignframe) then
 begin
  fdesignframe.Scale:=GetScale;
 end;
end;

function TFRpMainF.GetScale:double;
begin
 Result:=StrToFloat(Copy(ComboScale.Text,1,Length(ComboScale.Text)-1))/100;
end;


end.
