{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rppreview                                       }
{       Preview the report                              }
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

unit rppreview;

interface

{$I rpconf.inc}

uses
  SysUtils,
{$IFDEF MSWINDOWS}
  windows,
{$ENDIF}
{$IFDEF LINUX}
  Libc,
{$ENDIF}
  Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls,rpbasereport,rpreport,rpmetafile, QComCtrls,
  rpqtdriver, QExtCtrls,rptypes,rptextdriver,rphtmldriver,
  rppagesetup,rpsvgdriver,rpcsvdriver,rppreviewmetaclx,
  rppreviewcontrolclx,
  QActnList, QImgList,QPrinters,rpmdconsts,Qt, QMask, rpmaskeditclx,
  QMenus, QTypes;


type
  TFRpPreview = class(TForm)
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
    SaveDialog1: TSaveDialog;
    ToolButton7: TToolButton;
    ACancel: TAction;
    BCancel: TButton;
    PBar: TProgressBar;
    AExit: TAction;
    BExit: TToolButton;
    ToolButton8: TToolButton;
    AParams: TAction;
    AScale100: TAction;
    AScaleWide: TAction;
    AScaleFull: TAction;
    AScaleLess: TAction;
    AScaleMore: TAction;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton5: TToolButton;
    ToolButton10: TToolButton;
    ToolButton9: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    APageSetup: TAction;
    AMailTo: TAction;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
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
    AFind: TAction;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure AFirstExecute(Sender: TObject);
    procedure ANextExecute(Sender: TObject);
    procedure APreviousExecute(Sender: TObject);
    procedure ALastExecute(Sender: TObject);
    procedure EPageNumKeyPress(Sender: TObject; var Key: Char);
    procedure APrintExecute(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure ACancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AExitExecute(Sender: TObject);
    procedure AParamsExecute(Sender: TObject);
    procedure AScale100Execute(Sender: TObject);
    procedure AScaleWideExecute(Sender: TObject);
    procedure AScaleFullExecute(Sender: TObject);
    procedure AScaleLessExecute(Sender: TObject);
    procedure AScaleMoreExecute(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ImageContainerMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure AMailToExecute(Sender: TObject);
    procedure APageSetupExecute(Sender: TObject);
    procedure MEntireMenuPopup(Sender: TObject);
    procedure MEntire1Click(Sender: TObject);
    procedure MLeftRightClick(Sender: TObject);
    procedure ESearchChange(Sender: TObject);
    procedure AFindExecute(Sender: TObject);
  private
    { Private declarations }
    textchanged:boolean;
    fpreviewcontrol:TRpPreviewMetaCLX;
    cancelled:boolean;
    printed:boolean;
{$IFDEF LINUX}
    usekprinter:boolean;
{$ENDIF}
    procedure AppIdle(Sender:TObject;var done:boolean);
    procedure RepProgress(Sender:TObject;records,pagecount:integer;var docancel:boolean);
    procedure DisableControls(enablebar:boolean);
    procedure SetPreviewControl(avalue:TRpPreviewMetaCLX);
    procedure OnPageDrawn(prm:TRpPreviewMetaCLX);
    procedure EnableControls;
  public
    { Public declarations }
    systemprintdialog:boolean;
    procedure FindNext;
    property PreviewControl:TRpPreviewmetaCLX read fpreviewcontrol write SetPreviewControl;
  end;


function ShowPreview(previewcontrol:TRpPreviewMetaCLX;caption:string;systemprintdialog:boolean):boolean;

implementation

uses rprfparams,
    rpprintdia,
    rppdfdriver;

{$R *.xfm}

procedure TFRpPreview.SetPreviewControl(avalue:TRpPreviewMetaCLX);
begin
 fpreviewcontrol:=avalue;
 fpreviewcontrol.Width:=0;
 fpreviewcontrol.Height:=0;
 Fpreviewcontrol.Align:=alClient;
end;

function ShowPreview(previewcontrol:TRpPreviewMetaCLX;caption:string;systemprintdialog:boolean):boolean;
var
 dia:TFRpPreview;
 oldprogres:TRpProgressEvent;
 hasparams:boolean;
 i:integer;
  OldIdleHandler : TIdleEvent;
begin
 dia:=TFRpPreview.Create(Application);
 try
  previewcontrol.OnWorkProgress:=dia.RepProgress;
  previewcontrol.OnPageDrawn:=dia.OnPageDrawn;
  dia.caption:=caption;
  dia.systemprintdialog:=systemprintdialog;
  dia.PreviewControl:=PreviewControl;
  dia.AParams.Enabled:=previewcontrol is TRpPreviewControlCLX;
  dia.APageSetup.Enabled:=previewcontrol is TRpPreviewControlCLX;
  if previewcontrol.metafile.PreviewWindow=spwMaximized then
    dia.WindowState:=wsMaximized;
  previewcontrol.OnWorkProgress:=dia.RepProgress;
    OldIdleHandler := Application.OnIdle;
  Application.OnIdle:=dia.AppIdle;
  dia.ShowModal;
  Result:=dia.printed;
 finally
    Application.OnIdle := OldIdleHandler;
  previewcontrol.OnWorkProgress:=nil;
  previewcontrol.OnPageDrawn:=nil;
  previewcontrol.Parent:=nil;
  dia.Free;
 end;
end;


procedure TFRpPreview.AppIdle(Sender:TObject;var done:boolean);
begin
 Application.OnIdle:=nil;
 done:=false;
 try
  if Assigned(FPreviewControl) then
  begin
   DisableControls(true);
   try
    FPreviewControl.Parent:=self;
   finally
    EnableControls;
   end;
  end;
 except
  on E:Exception do
  begin
   Close;
   Raise;
  end;
 end;
end;

procedure TFRpPreview.FormCreate(Sender: TObject);
begin
{$IFDEF LINUX}
 usekprinter:=GetEnvironmentVariable('REPMANUSEKPRINTER')='true';
{$ENDIF}


 BToolBar.ButtonHeight:=EPageNum.Height;
 APrevious.ShortCut:=Key_PageUp;
 ANext.ShortCut:=Key_PageDown;
 AFirst.ShortCut:=Key_Home;
 ALast.ShortCut:=Key_End;
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
   SRpTXTProFile+'|*.txt|'+
   SRpRepMetafileUn+'|*.rpmf';
{$IFDEF MSWINDOWS}
 SaveDialog1.Filter:=SaveDialog1.Filter+'|'+SRpExeMetafile+'|*.exe';
{$ENDIF}
{$ENDIF}
{$IFNDEF VCLFILEFILTERS}
 SaveDialog1.Filter:=SRpRepMetafile+' (*.rpmf)|'+
   SRpPDFFile+' (*.pdf)|'+
   SRpPDFFileUn+' (*.pdf)|'+
   SRpPlainFile+' (*.txt)|'+
   SRpBitmapFile+' (*.bmp)|'+
   SRpHtmlFile+' (*.html)|'+
   SRpHtmlFileSingle+' (*.html)|'+
   SRpSVGFile+' (*.svg)|'+
   SRpCSVFile+' (*.csv)|'+
   SRpTXTProFile+' (*.txt)|'+
   SRpRepMetafileUn+' (*.rpmf)';
{$IFDEF MSWINDOWS}
  SaveDialog1.Filter:=SaveDialog1.Filter+'|'+SRpExeMetafile+' (*.exe)';
{$ENDIF}
{$ENDIF}

 Caption:=TranslateStr(215,Caption);
 SaveDialog1.Title:=TranslateStr(216,SaveDialog1.Title);
 ACancel.Caption:=TranslateStr(94,ACancel.Caption);
 ACancel.Hint:=TranslateStr(218,ACancel.Hint);
 APrint.Caption:=TranslateStr(52,APrint.Caption);
 APrint.Hint:=TranslateStr(53,APrint.Hint);
 ASave.Caption:=TranslateStr(46,ASave.Caption);
 ASave.Hint:=TranslateStr(217,ASave.Hint);
 AMailTo.Caption:=TranslateStr(1230,AMailTo.Caption);
 AMailTo.Hint:=TranslateStr(1231,AMailTo.Hint);
 AExit.Caption:=TranslateStr(44,AExit.Caption);
 AExit.Hint:=TranslateStr(219,AExit.Hint);
 AParams.Caption:=TranslateStr(135,Aparams.Caption);
 AParams.Hint:=TranslateStr(136,Aparams.Hint);
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
 APageSetup.Caption:=TranslateStr(50,APageSetup.Caption);
 APageSetup.Hint:=TranslateStr(51,APageSetup.Hint);

 ActiveControl:=EPageNum;


 SaveDialog1.FilterIndex:=2;
 SetInitialBounds;
end;

procedure TFRpPreview.AFirstExecute(Sender: TObject);
begin
 PreviewControl.FirstPage;
end;

procedure TFRpPreview.ANextExecute(Sender: TObject);
var
 disable:boolean;
begin
 disable:=true;
 if PreviewControl.Metafile.Finished then
  disable:=false;
 if disable then
  DisableControls(true);
 try
  PreviewControl.NextPage;
 finally
  if disable then
   EnableControls;
 end;
end;

procedure TFRpPreview.APreviousExecute(Sender: TObject);
begin
 PreviewControl.PriorPage;
end;

procedure TFRpPreview.ALastExecute(Sender: TObject);
begin
 DisableControls(true);
 try
  PreviewControl.LastPage;
 finally
  EnableControls;
 end;
end;

procedure TFRpPreview.EPageNumKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=chr(13) then
 begin
  PreviewControl.Page:=StrToInt(EPageNum.Text)-1;
 end;
end;

procedure TFRpPreview.APrintExecute(Sender: TObject);
var
 adone:boolean;
 allpages,collate:boolean;
 frompage,topage,copies:integer;
begin
 allpages:=true;
 collate:=PreviewControl.metafile.CollateCopies;;
 frompage:=1; topage:=999999;
 copies:=PreviewControl.metafile.Copies;
{$IFDEF LINUX}
 if usekprinter then
 begin
   ALastExecute(Self);
   // Use kprinter to print the file
   PrintMetafileUsingKPrinter(PreviewControl.metafile);
 end
 else
{$ENDIF}
 begin
  if systemprintdialog then
  begin
  if Not rpqtdriver.DoShowPrintDialog(allpages,frompage,topage,copies,collate) then
   exit;
  end
  else
  begin
   if Not rpprintdia.DoShowPrintDialog(allpages,frompage,topage,copies,collate) then
    exit;
  end;
 // report.EndPrint;
 // PrintReport(report,Caption,true,allpages,frompage,topage,copies,collate);
  ALastExecute(Self);
  if not allpages then
  begin
   PreviewControl.Page:=topage+1;
  end
  else
   ALastExecute(Self);
  PrintMetafile(PreviewControl.Metafile,Caption,true,allpages,frompage,topage,copies,
   collate,PreviewControl.Metafile.PrinterSelect,'');
 end;
 AppIdle(Self,adone);
end;

procedure TFRpPreview.ASaveExecute(Sender: TObject);
var
 adone,mono:boolean;
 horzres,vertres:integer;
 abitmap:TBitmap;
begin
 // Saves the metafile
 if SaveDialog1.Execute then
 begin
   DisableControls(true);
   try
    case SaveDialog1.FilterIndex of
     1:
      begin
       ALastExecute(Self);
       PreviewControl.Metafile.SaveToFile(SaveDialog1.Filename)
      end;
     2,3:
      begin
       ALastExecute(Self);
       SaveMetafileToPDF(PreviewControl.Metafile,SaveDialog1.FileName,SaveDialog1.FilterIndex=2);
 //      report.EndPrint;
 //      ExportReportToPDF(report,SaveDialog1.Filename,true,true,1,32000,
 //       true,SaveDialog1.Filename,SaveDialog1.FilterIndex=2);
       AppIdle(Self,adone);
      end;
     5:
      begin
       horzres:=100;
       vertres:=100;
       mono:=true;
       if AskBitmapProps(horzres,vertres,mono) then
       begin
        ALastExecute(Self);
        abitmap:=MetafileToBitmap(PreviewControl.Metafile,true,mono,horzres,vertres);
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
       ALastExecute(Self);
       ExportMetafileToHtml(PreviewControl.Metafile,Caption,SaveDialog1.FileName,
        true,true,1,9999);
       AppIdle(Self,adone);
      end;
     7:
      begin
       ALastExecute(Self);
       ExportMetafileToHtmlSingle(PreviewControl.Metafile,Caption,SaveDialog1.FileName);
       AppIdle(Self,adone);
      end;
     8:
      begin
       ALastExecute(Self);
       ExportMetafileToSVG(PreviewControl.Metafile,Caption,SaveDialog1.FileName,
        true,true,1,9999);
       AppIdle(Self,adone);
      end;
     9:
      begin
       ALastExecute(Self);
       ExportMetafileToCSV(PreviewControl.metafile,SaveDialog1.Filename,true,true,
        1,MAX_PAGECOUNT,',');
       AppIdle(Self,adone);
      end;
     10:
      begin
       ALastExecute(Self);
       ExportMetafileToTextPro(PreviewControl.metafile,SaveDialog1.Filename,true,true,
        1,9999);
       AppIdle(Self,adone);
      end;
     11:
      begin
       ALastExecute(Self);
       PreviewControl.Metafile.SaveToFile(SaveDialog1.Filename,false);
      end;
{$IFDEF MSWINDOWS}
     12:
      begin
       ALastExecute(Self);
       MetafileToExe(PreviewControl.metafile,SaveDialog1.Filename);
      end;
{$ENDIF}
     else
     begin
      // Plain text file
      ALastExecute(Self);
      SaveMetafileToTextFile(PreviewControl.Metafile,SaveDialog1.FileName);
      AppIdle(Self,adone);
     end;
    end;
   finally
    EnableControls;
   end;
 end;
end;


procedure TFRpPreview.RepProgress(Sender:TObject;records,pagecount:integer;var docancel:boolean);
begin
 BCancel.Caption:=SRpPage+':'+
  FormatFloat('####,####',pagecount)+':'
  +FormatFloat('####,####',records)+'-'+SRpCancel;
{$IFDEF MSWINDOWS}
 if ((GetAsyncKeyState(VK_ESCAPE) AND $8000)<>0) then
  docancel:=true;
{$ENDIF}
 if cancelled then
  docancel:=true;
 Application.ProcessMessages;
end;


procedure TFRpPreview.BCancelClick(Sender: TObject);
begin
 cancelled:=true;
end;

procedure TFRpPreview.ACancelExecute(Sender: TObject);
begin
 cancelled:=true;
end;

procedure TFRpPreview.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if Not ANext.Enabled then
 begin
  cancelled:=true;
 end;
end;

procedure TFRpPreview.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFRpPreview.DisableControls(enablebar:boolean);
begin
 BCancel.Left:=BExit.Left+BExit.Width;
 BCancel.Visible:=true;
 AScale100.Enabled:=false;
 AScaleFull.Enabled:=false;
 AScaleWide.Enabled:=false;
 AScaleLess.Enabled:=False;
 AScaleMore.Enabled:=False;
 AFirst.Enabled:=false;
 ALast.Enabled:=false;
 APrint.Enabled:=false;
 ANext.Enabled:=false;
 APrevious.Enabled:=false;
 EPageNum.Enabled:=false;
 ASave.Enabled:=false;
 AMailTo.Enabled:=false;
 APageSetup.Enabled:=false;
 AParams.Enabled:=false;
 PBar.Position:=0;
 PBar.Visible:=enablebar;
 AExit.Enabled:=false;
end;

procedure TFRpPreview.EnableControls;
begin
 BCancel.Visible:=false;
 AScale100.Enabled:=true;
 AScaleFull.Enabled:=true;
 AScaleWide.Enabled:=true;
 AScaleLess.Enabled:=true;
 AScaleMore.Enabled:=true;
 AFirst.Enabled:=true;
 ALast.Enabled:=true;
 APrint.Enabled:=true;
 ANext.Enabled:=true;
 APrevious.Enabled:=true;
 EPageNum.Enabled:=true;
 ASave.Enabled:=true;
 AMailTo.Enabled:=true;
 APageSetup.Enabled:=true;
 AParams.Enabled:=true;
 PBar.Visible:=false;
 AExit.Enabled:=true;
end;




procedure TFRpPreview.AExitExecute(Sender: TObject);
begin
 Close;
end;

procedure TFRpPreview.AParamsExecute(Sender: TObject);
var
 adone:boolean;
begin
 if ShowUserParams(TRpPreviewControlCLX(fpreviewcontrol).Report.Params) then
 begin
  DisableControls(true);
  try
   fpreviewcontrol.RefreshMetafile;
  finally
   EnableControls;
  end;
 end;
end;





procedure TFRpPreview.AScale100Execute(Sender: TObject);
begin
 PreviewControl.AutoScale:=AScaleReal;
end;

procedure TFRpPreview.AScaleWideExecute(Sender: TObject);
begin
 PreviewControl.AutoScale:=rppreviewmetaclx.AScaleWide;
end;

procedure TFRpPreview.AScaleFullExecute(Sender: TObject);
begin
 PreviewControl.AutoScale:=AScaleEntirePage;
end;

procedure TFRpPreview.AScaleLessExecute(Sender: TObject);
begin
 PreviewControl.PreviewScale:=PreviewControl.PreviewScale-0.1;
end;

procedure TFRpPreview.AScaleMoreExecute(Sender: TObject);
begin
 PreviewControl.PreviewScale:=PreviewControl.PreviewScale+0.1;
end;


procedure TFRpPreview.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
 increment:integer;
begin
 if (ssShift in Shift) then
  increment:=REP_C_WHEELINC
 else
  increment:=REP_C_WHEELINC*REP_C_WHEELSCALE;
 fpreviewcontrol.Scroll(not (ssCtrl in Shift),increment);
 Handled:=true;
end;

procedure TFRpPreview.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
 increment:integer;
begin
 if (ssShift in Shift) then
  increment:=REP_C_WHEELINC
 else
  increment:=REP_C_WHEELINC*REP_C_WHEELSCALE;
 fpreviewcontrol.Scroll(not (ssCtrl in Shift),-increment);
 Handled:=true;
end;

procedure TFRpPreview.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
 Handled:=false;
end;

procedure TFRpPreview.ImageContainerMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
 Handled:=false;
end;


procedure TFRpPreview.AMailToExecute(Sender: TObject);
var
 afilename:String;
 destination,subject,body:string;
 report:TRpBaseReport;
begin
 destination:='';
 body:='';
 subject:='';
 if (not (fpreviewcontrol is TRpPreviewControlCLX)) then
  exit;
 report:=TRpPreviewControlCLX(fpreviewcontrol).Report;
 if report.Params.IndexOf('MAIL_DESTINATION')>=0 then
  destination:=report.Params.ParamByName('MAIL_DESTINATION').AsString;
 if report.Params.IndexOf('MAIL_SUBJECT')>=0 then
  subject:=report.Params.ParamByName('MAIL_SUBJECT').AsString;
 if report.Params.IndexOf('MAIL_BODY')>=0 then
  body:=report.Params.ParamByName('MAIL_BODY').AsString;
 ALastExecute(Self);
 afilename:=RpTempFileName;
 if report.Params.IndexOf('MAIL_FILE')>=0 then
  afilename:=ExtractFilePath(afilename)+report.Params.ParamByName('MAIL_FILE').AsString;
 SaveMetafileToPDF(report.Metafile,afilename,true);
 try
  if Length(subject)<1 then
   subject:=ExtractFileName(afilename);
  rptypes.SendMail(destination,subject,body,afilename,ExtractFilePath(ChangeFileExt(afilename,'.pdf')));
 finally
  sysutils.DeleteFile(afilename);
 end;
end;

procedure TFRpPreview.APageSetupExecute(Sender: TObject);
var
 adone:boolean;
begin
 if ExecutePageSetup(TRpPreviewControlCLX(fpreviewcontrol).Report) then
 begin
  DisableControls(true);
  try
   fpreviewcontrol.RefreshMetafile;
  finally
   EnableControls;
  end;
 end;
end;


procedure TFRpPreview.OnPageDrawn(prm:TRpPreviewMetaCLX);
begin
 EPageNum.Text:=IntToStr(prm.Page+1);
end;



procedure TFRpPreview.MEntireMenuPopup(Sender: TObject);
begin
 MleftRight.Checked:=Not PreviewControl.EntireTopDown;
end;

procedure TFRpPreview.MEntire1Click(Sender: TObject);
begin
 // Adjust to entirepage
 PreviewControl.EntirePageCount:=TMenuItem(Sender).Tag;
 PreviewControl.AutoScale:=AScaleEntirePage;
end;

procedure TFRpPreview.MLeftRightClick(Sender: TObject);
begin
 MleftRight.Checked:=Not MLeftRight.Checked;
 PreviewControl.EntireTopDown:=Not MLeftRight.Checked;
end;

procedure TFRpPreview.ESearchChange(Sender: TObject);
begin
 textchanged:=true;
end;

procedure TFRpPreview.FindNext;
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

procedure TFRpPreview.AFindExecute(Sender: TObject);
begin
 FindNext;
end;

end.
