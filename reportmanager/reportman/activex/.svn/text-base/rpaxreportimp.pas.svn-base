unit rpaxreportimp;

{$I rpconf.inc}

{$IFDEF USEVARIANTS}
 {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

interface

uses
  Windows, ActiveX, SysUtils,Classes, Controls, Graphics, Menus, Forms, StdCtrls,
  ComServ, StdVCL, AXCtrls, reportman_TLB, rpactivexreport,rpreport,rpvgraphutils,
  rpparams,rptypes,rpgdidriver,rpmetafile,comobj,rpaxreportparameters,
  rpaxreportreport,rpexceldriver,rphtmldriver,printers,rpmdconsts;

type
  TReportManX = class(TActiveXControl, IReportManX)
  private
    { Private declarations }
    FDelphiControl: TRpActiveXReport;
    FEvents: IReportManXEvents;
    FReportReport:TReportReport;
  protected
    { Protected declarations }
    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    procedure InitializeControl; override;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; safecall;
    function Execute: WordBool; safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_Cursor: Smallint; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    function Get_Enabled: WordBool; safecall;
    function Get_FileName: WideString; safecall;
    function Get_HelpKeyword: WideString; safecall;
    function Get_HelpType: TxHelpType; safecall;
    function Get_Language: Integer; safecall;
    function Get_Preview: WordBool; safecall;
    function Get_ShowPrintDialog: WordBool; safecall;
    function Get_ShowProgress: WordBool; safecall;
    function Get_Title: WideString; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function GetDatabaseConnectionString(
      const databasename: WideString): WideString; safecall;
    function GetDatasetSQL(const datasetname: WideString): WideString;
      safecall;
    function GetParamValue(const paramname: WideString): OleVariant; safecall;
    function IsRightToLeft: WordBool; safecall;
    function PrintRange(frompage, topage, copies: Integer;
      collate: WordBool): WordBool; safecall;
    function ShowParams: WordBool; safecall;
    function UseRightToLeftReading: WordBool; safecall;
    function UseRightToLeftScrollBar: WordBool; safecall;
    procedure AboutBox; safecall;
    procedure InitiateAction; safecall;
    procedure PrinterSetup; safecall;
    procedure SaveToPDF(const filename: WideString; compressed: WordBool);
      safecall;
    procedure Set_Cursor(Value: Smallint); safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure Set_FileName(const Value: WideString); safecall;
    procedure Set_HelpKeyword(const Value: WideString); safecall;
    procedure Set_HelpType(Value: TxHelpType); safecall;
    procedure Set_Language(Value: Integer); safecall;
    procedure Set_Preview(Value: WordBool); safecall;
    procedure Set_ShowPrintDialog(Value: WordBool); safecall;
    procedure Set_ShowProgress(Value: WordBool); safecall;
    procedure Set_Title(const Value: WideString); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure SetDatabaseConnectionString(const databasename,
      connectionstring: WideString); safecall;
    procedure SetDatasetSQL(const datasetname, sqlsentence: WideString);
      safecall;
    procedure SetParamValue(const paramname: WideString;
      paramvalue: OleVariant); safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
    procedure ExecuteRemote(const hostname: WideString; port: Integer;
      const user, password, aliasname, reportname, sql: WideString); safecall;
    procedure CalcReport(ShowProgress: WordBool); safecall;
    procedure SaveToText(const filename, textdriver: WideString); safecall;
    procedure IReportManX.Compose = IReportManX_Compose;
    procedure IReportManX_Compose(const Report: ReportReport;
      Execute: WordBool); safecall;
    function Get_Report: ReportReport; safecall;
    procedure SaveToExcel(const filename: WideString); safecall;
    procedure SaveToHTML(const filename: WideString); safecall;
    procedure SetRecordSet(const DatasetName: WideString;
      const Value: IDispatch); safecall;
    procedure SaveToCSV(const filename: WideString); safecall;
    procedure SaveToCustomText(const filename: WideString); safecall;
    procedure SaveToSVG(const filename: WideString); safecall;
    procedure SaveToMetafile(const filename: WideString); safecall;
    procedure SaveToExcel2(const filename: WideString); safecall;
    procedure SetDefaultPrinter(const device: WideString); safecall;
    function Get_DefaultPrinter: WideString; safecall;
    procedure Set_DefaultPrinter(const Value: WideString); safecall;
    function Get_PrintersAvailable: WideString; safecall;
    procedure GetRemoteParams(const hostname: WideString; port: Integer;
      const user, password, aliasname, reportname: WideString); safecall;
    function Get_AsyncExecution: WordBool; safecall;
    procedure SaveToCSV2(const filename, separator: WideString); safecall;
    procedure Set_AsyncExecution(Value: WordBool); safecall;
    procedure SaveToHTMLSingle(const filename: WideString); safecall;
  end;

implementation

uses aboutrpax;

{ TReportManX }

procedure TReportManX.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  {TODO: Define property pages here.  Property pages are defined by calling
    DefinePropertyPage with the class id of the page.  For example,
      DefinePropertyPage(Class_ReportManXPage); }
end;

procedure TReportManX.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IReportManXEvents;
end;

procedure TReportManX.InitializeControl;
begin
  FDelphiControl := Control as TRpActiveXReport;
end;

function TReportManX.DrawTextBiDiModeFlagsReadingOnly: Integer;
begin
  Result := FDelphiControl.DrawTextBiDiModeFlagsReadingOnly;
end;

function TReportManX.Execute: WordBool;
begin
  Result := FDelphiControl.Execute;
end;

function TReportManX.Get_AlignDisabled: WordBool;
begin
{$IFDEF USEVARIANTS}
  Result := FDelphiControl.AlignDisabled;
{$ENDIF}
end;

function TReportManX.Get_Cursor: Smallint;
begin
  Result := Smallint(FDelphiControl.Cursor);
end;

function TReportManX.Get_DoubleBuffered: WordBool;
begin
  Result := FDelphiControl.DoubleBuffered;
end;

function TReportManX.Get_Enabled: WordBool;
begin
  Result := FDelphiControl.Enabled;
end;

function TReportManX.Get_FileName: WideString;
begin
  Result := WideString(FDelphiControl.Filename);
end;

function TReportManX.Get_HelpKeyword: WideString;
begin
{$IFDEF USEVARIANTS}
  Result := WideString(FDelphiControl.HelpKeyword);
{$ENDIF}
end;

function TReportManX.Get_HelpType: TxHelpType;
begin
{$IFDEF USEVARIANTS}
  Result := Ord(FDelphiControl.HelpType);
{$ENDIF}
end;

function TReportManX.Get_Language: Integer;
begin
  Result := FDelphiControl.Language;
end;

function TReportManX.Get_Preview: WordBool;
begin
  Result := FDelphiControl.Preview;
end;

function TReportManX.Get_ShowPrintDialog: WordBool;
begin
  Result := FDelphiControl.ShowPrintDialog;
end;

function TReportManX.Get_ShowProgress: WordBool;
begin
  Result := FDelphiControl.ShowProgress;
end;

function TReportManX.Get_Title: WideString;
begin
  Result := WideString(FDelphiControl.Title);
end;

function TReportManX.Get_Visible: WordBool;
begin
  Result := FDelphiControl.Visible;
end;

function TReportManX.Get_VisibleDockClientCount: Integer;
begin
  Result := FDelphiControl.VisibleDockClientCount;
end;

function TReportManX.GetDatabaseConnectionString(
  const databasename: WideString): WideString;
begin
  Result := FDelphiControl.GetDatabaseConnectionString(databasename);
end;

function TReportManX.GetDatasetSQL(
  const datasetname: WideString): WideString;
begin
  Result := FDelphiControl.GetDatasetSQL(datasetname);
end;

function TReportManX.GetParamValue(
  const paramname: WideString): OleVariant;
begin
  Result := FDelphiControl.GetParamValue(paramname);
end;

function TReportManX.IsRightToLeft: WordBool;
begin
  Result := FDelphiControl.IsRightToLeft;
end;

function TReportManX.PrintRange(frompage, topage, copies: Integer;
  collate: WordBool): WordBool;
begin
  Result := FDelphiControl.PrintRange(frompage, topage, copies, collate);
end;

function TReportManX.ShowParams: WordBool;
begin
  Result := FDelphiControl.ShowParams;
end;

function TReportManX.UseRightToLeftReading: WordBool;
begin
  Result := FDelphiControl.UseRightToLeftReading;
end;

function TReportManX.UseRightToLeftScrollBar: WordBool;
begin
  Result := FDelphiControl.UseRightToLeftScrollBar;
end;

procedure TReportManX.AboutBox;
begin
  ShowReportManXAbout;
end;

procedure TReportManX.InitiateAction;
begin
  FDelphiControl.InitiateAction;
end;

procedure TReportManX.PrinterSetup;
begin
  FDelphiControl.PrinterSetup;
end;

procedure TReportManX.SaveToPDF(const filename: WideString;
  compressed: WordBool);
begin
  FDelphiControl.SaveToPDF(filename, compressed);
end;

procedure TReportManX.Set_Cursor(Value: Smallint);
begin
  FDelphiControl.Cursor := TCursor(Value);
end;

procedure TReportManX.Set_DoubleBuffered(Value: WordBool);
begin
  FDelphiControl.DoubleBuffered := Value;
end;

procedure TReportManX.Set_Enabled(Value: WordBool);
begin
  FDelphiControl.Enabled := Value;
end;

procedure TReportManX.Set_FileName(const Value: WideString);
begin
  FDelphiControl.Filename := String(Value);
end;

procedure TReportManX.Set_HelpKeyword(const Value: WideString);
begin
{$IFDEF USEVARIANTS}
  FDelphiControl.HelpKeyword := String(Value);
{$ENDIF}
end;

procedure TReportManX.Set_HelpType(Value: TxHelpType);
begin
{$IFDEF USEVARIANTS}
  FDelphiControl.HelpType := THelpType(Value);
{$ENDIF}
end;

procedure TReportManX.Set_Language(Value: Integer);
begin
  FDelphiControl.Language := Value;
end;

procedure TReportManX.Set_Preview(Value: WordBool);
begin
  FDelphiControl.Preview := Value;
end;

procedure TReportManX.Set_ShowPrintDialog(Value: WordBool);
begin
  FDelphiControl.ShowPrintDialog := Value;
end;

procedure TReportManX.Set_ShowProgress(Value: WordBool);
begin
  FDelphiControl.ShowProgress := Value;
end;

procedure TReportManX.Set_Title(const Value: WideString);
begin
  FDelphiControl.Title := String(Value);
end;

procedure TReportManX.Set_Visible(Value: WordBool);
begin
  FDelphiControl.Visible := Value;
end;

procedure TReportManX.SetDatabaseConnectionString(const databasename,
  connectionstring: WideString);
begin
  FDelphiControl.SetDatabaseConnectionString(databasename, connectionstring);
end;

procedure TReportManX.SetDatasetSQL(const datasetname,
  sqlsentence: WideString);
begin
  FDelphiControl.SetDatasetSQL(datasetname, sqlsentence);
end;

procedure TReportManX.SetParamValue(const paramname: WideString;
  paramvalue: OleVariant);
begin
  FDelphiControl.SetParamValue(paramname, paramvalue);
end;

procedure TReportManX.SetSubComponent(IsSubComponent: WordBool);
begin
{$IFDEF USEVARIANTS}
  FDelphiControl.SetSubComponent(IsSubComponent);
{$ENDIF}
end;

procedure TReportManX.ExecuteRemote(const hostname: WideString;
  port: Integer; const user, password, aliasname, reportname, sql: WideString);
begin
 FDelphiControl.ExecuteRemote(hostname,port,user,password,aliasname,reportname, sql);
end;

procedure TReportManX.CalcReport(ShowProgress: WordBool);
var
 gdidriver:TRpGDIDriver;
begin
 if ShowProgress then
  CalcReportWidthProgress(FDelphiControl.GetReport)
 else
 begin
  GDIDriver:=TRpGDIDriver.Create;
  try
   FDelphiControl.GetReport.PrintAll(gdidriver);
  finally
   gdidriver.free;
  end;
 end;
end;


procedure TReportManX.SaveToText(const filename, textdriver: WideString);
begin
  FDelphiControl.SaveToText(filename, textdriver);
end;


procedure TReportManX.IReportManX_Compose(const Report: ReportReport;
  Execute: WordBool);
var
 gdidriver:TRpGDIDriver;
begin
 GDIDriver:=TRpGDIDriver.Create;
 try
  FDelphiControl.GetReport.Compose(TRpReport(Report.VCLReport),false,GDIDriver);
  if Execute then
   FDelphiControl.Execute;
 finally
  gdidriver.free;
 end;
end;


function TReportManX.Get_Report: ReportReport;
begin
 if Not Assigned(FReportReport) then
 begin
  FReportReport:=TReportReport.Create;
  FReportReport.FReport:=FDelphiControl.GetReport;
 end;
 Result:=FReportReport;
 Result._AddRef;
end;


procedure TReportManX.SaveToExcel(const filename: WideString);
begin
 FDelphiControl.GetReport.TwoPass:=true;
 rpgdidriver.CalcReportWidthProgress(FDelphiControl.GetReport);
 ExportMetafileToExcel (FDelphiControl.GetReport.metafile,filename,
  true,false,true,1,9999999,false);
end;


procedure TReportManX.SaveToHTML(const filename: WideString);
begin
 rphtmldriver.ExportReportToHtml(FDelphiControl.GetReport,filename,Get_ShowProgress);
end;

procedure TReportManX.SetRecordSet(const DatasetName: WideString;
  const Value: IDispatch);
begin
 FDelphiControl.SetRecordset(datasetname, Pointer(Value));
end;

procedure TReportManX.SaveToCSV(const filename: WideString);
begin
  FDelphiControl.SaveToCSV(filename);
end;

procedure TReportManX.SaveToCustomText(const filename: WideString);
begin
  FDelphiControl.SaveToCustomText(filename);
end;

procedure TReportManX.SaveToSVG(const filename: WideString);
begin
  FDelphiControl.SaveToSVG(filename);
end;

procedure TReportManX.SaveToMetafile(const filename: WideString);
begin
  FDelphiControl.SaveToMetafile(filename);
end;

procedure TReportManX.SaveToExcel2(const filename: WideString);
begin
 FDelphiControl.GetReport.TwoPass:=true;
 rpgdidriver.CalcReportWidthProgress(FDelphiControl.GetReport);
 ExportMetafileToExcel (FDelphiControl.GetReport.metafile,filename,
  true,false,true,1,9999999,true);
end;

procedure TReportManX.SetDefaultPrinter(const device: WideString);
var
 adevice:string;
 i:integer;
 itemindex:integer;
 printerlist:string;
begin
 adevice:=UpperCase(device);
 itemindex:=-1;
 printerlist:='';
 for i:=0 to printer.printers.count-1 do
 begin
  if UpperCase(printer.printers.strings[i])=adevice then
  begin
   itemindex:=i;
   break;
  end;
  printerlist:=printerlist+printer.printers.strings[i]+#10;
 end;
 if itemindex<0 then
  Raise Exception.Create(SRpErrorOpenImp+':'+device+#10+printerlist);
 SwitchToPrinterIndex(itemindex);
end;

function TReportManX.Get_DefaultPrinter: WideString;
begin
 Result:='';
 if printer.printerindex>0 then
  Result:=printer.printers[printer.printerindex];
end;

procedure TReportManX.Set_DefaultPrinter(const Value: WideString);
begin
 SetDefaultPrinter(Value);
end;

function TReportManX.Get_PrintersAvailable: WideString;
var
 i:integer;
begin
 Result:='';
 for i:=0 to printer.printers.count-1 do
 begin
  if i>0 then
   Result:=Result+#10;
  Result:=Result+printer.printers[i];
 end;
end;

procedure TReportManX.GetRemoteParams(const hostname: WideString;
  port: Integer; const user, password, aliasname, reportname: WideString);
begin
 FDelphiControl.GetRemoteParams(hostname,port,user,password,aliasname,reportname);
end;

function TReportManX.Get_AsyncExecution: WordBool;
begin
  Result := FDelphiControl.AsyncExecution;
end;

procedure TReportManX.SaveToCSV2(const filename, separator: WideString);
begin
  FDelphiControl.SaveToCSV2(filename,separator);
end;

procedure TReportManX.Set_AsyncExecution(Value: WordBool);
begin
 FDelphiControl.AsyncExecution:=Value;
end;

procedure TReportManX.SaveToHTMLSingle(const filename: WideString);
begin

end;

initialization
  TActiveXControlFactory.Create(
    ComServer,
    TReportManX,
    TRpActiveXReport,
    Class_ReportManX,
    1,
    '',
    0,
    tmSingle);
end.
