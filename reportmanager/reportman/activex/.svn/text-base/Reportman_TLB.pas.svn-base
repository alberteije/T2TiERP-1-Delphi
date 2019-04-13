unit reportman_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 17244 $
// File generated on 09/01/2010 14:44:57 from Type Library described below.

// ************************************************************************  //
// Type Lib: reportman.tlb (1)
// LIBID: {D4D26F6B-6564-44F4-A913-03C91CE37740}
// LCID: 0
// Helpfile: 
// HelpString: Report Manager ActiveX Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TReportManX) : No Server registered for this CoClass
//   Error creating palette bitmap of (TReportReport) : No Server registered for this CoClass
//   Error creating palette bitmap of (TReportParameters) : No Server registered for this CoClass
//   Error creating palette bitmap of (TReportParam) : No Server registered for this CoClass
//   Error creating palette bitmap of (TReportmanXAServer) : No Server registered for this CoClass
//   Error creating palette bitmap of (TPreviewControl) : No Server registered for this CoClass
// Cmdline:
//   "c:\Program Files (x86)\Embarcadero\RAD Studio\7.0\bin\tlibimp.exe"  -P reportman.tlb
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  reportmanMajorVersion = 2;
  reportmanMinorVersion = 1;

  LIBID_reportman: TGUID = '{D4D26F6B-6564-44F4-A913-03C91CE37740}';

  IID_IReportManX: TGUID = '{B3AE1470-158D-4855-83DB-BC3A2746C26E}';
  DIID_IReportManXEvents: TGUID = '{50909EA4-8F4F-4865-877D-287FC7072177}';
  CLASS_ReportManX: TGUID = '{DC30E149-4129-450F-BDFE-BD9E6F31147E}';
  IID_IReportReport: TGUID = '{2FCB34BE-8DD4-4567-A771-9965C2FD3A04}';
  CLASS_ReportReport: TGUID = '{E30FD4FC-F47A-4932-A3E6-6694550588F3}';
  IID_IReportParameters: TGUID = '{A5F6E90E-DFE7-49DA-AA38-C1A41C995B6B}';
  CLASS_ReportParameters: TGUID = '{F79CF82C-C2AD-46CC-ABEA-084016CFE58A}';
  IID_IReportParam: TGUID = '{F1634F9E-DE5A-411E-9A9E-3A46707A7ABB}';
  CLASS_ReportParam: TGUID = '{E96B253E-143E-40E8-BFDA-366C5F112DAE}';
  IID_IReportmanXAServer: TGUID = '{F3A6B88C-D629-402E-BC62-BAB0E2EE39AF}';
  CLASS_ReportmanXAServer: TGUID = '{FD3BE5E5-CBE4-4C29-A733-8CB842999075}';
  IID_IPreviewControl: TGUID = '{3D8043B8-E2F6-4F5D-B055-571924F5B0DC}';
  DIID_IPreviewControlEvents: TGUID = '{7364E2EA-8EEC-4673-9059-3B078C388717}';
  CLASS_PreviewControl: TGUID = '{45978803-4B15-4E0E-98CE-AED9B1E1B701}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TxHelpType
type
  TxHelpType = TOleEnum;
const
  htKeyword = $00000000;
  htContext = $00000001;

// Constants for enum TxParamType
type
  TxParamType = TOleEnum;
const
  rpParamString = $00000000;
  rpParamInteger = $00000001;
  rpParamDouble = $00000002;
  rpParamDate = $00000003;
  rpParamTime = $00000004;
  rpParamDateTime = $00000005;
  rpParamCurrency = $00000006;
  rpParamBool = $00000007;
  rpParamExpreB = $00000008;
  rpParamExpreA = $00000009;
  rpParamSubst = $0000000A;
  rpParamList = $0000000B;
  rpParamUnknown = $0000000C;

// Constants for enum TxAutoScaleType
type
  TxAutoScaleType = TOleEnum;
const
  AScaleReal = $00000000;
  AScaleWide = $00000001;
  AScaleHeight = $00000002;
  AScaleEntirePage = $00000003;
  AScaleCustom = $00000004;

// Constants for enum TxBorderStyle
type
  TxBorderStyle = TOleEnum;
const
  bsNone = $00000000;
  bsSingle = $00000001;

// Constants for enum TxDragMode
type
  TxDragMode = TOleEnum;
const
  dmManual = $00000000;
  dmAutomatic = $00000001;

// Constants for enum TxMouseButton
type
  TxMouseButton = TOleEnum;
const
  mbLeft = $00000000;
  mbRight = $00000001;
  mbMiddle = $00000002;

// Constants for enum TxActiveFormBorderStyle
type
  TxActiveFormBorderStyle = TOleEnum;
const
  afbNone = $00000000;
  afbSingle = $00000001;
  afbSunken = $00000002;
  afbRaised = $00000003;

// Constants for enum TxPrintScale
type
  TxPrintScale = TOleEnum;
const
  poNone = $00000000;
  poProportional = $00000001;
  poPrintToFit = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IReportManX = interface;
  IReportManXDisp = dispinterface;
  IReportManXEvents = dispinterface;
  IReportReport = interface;
  IReportReportDisp = dispinterface;
  IReportParameters = interface;
  IReportParametersDisp = dispinterface;
  IReportParam = interface;
  IReportParamDisp = dispinterface;
  IReportmanXAServer = interface;
  IReportmanXAServerDisp = dispinterface;
  IPreviewControl = interface;
  IPreviewControlDisp = dispinterface;
  IPreviewControlEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ReportManX = IReportManX;
  ReportReport = IReportReport;
  ReportParameters = IReportParameters;
  ReportParam = IReportParam;
  ReportmanXAServer = IReportmanXAServer;
  PreviewControl = IPreviewControl;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PPUserType1 = ^IFontDisp; {*}


// *********************************************************************//
// Interface: IReportManX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B3AE1470-158D-4855-83DB-BC3A2746C26E}
// *********************************************************************//
  IReportManX = interface(IDispatch)
    ['{B3AE1470-158D-4855-83DB-BC3A2746C26E}']
    procedure SetDatasetSQL(const datasetname: WideString; const sqlsentence: WideString); safecall;
    procedure SetDatabaseConnectionString(const databasename: WideString; 
                                          const connectionstring: WideString); safecall;
    function GetDatasetSQL(const datasetname: WideString): WideString; safecall;
    function GetDatabaseConnectionString(const databasename: WideString): WideString; safecall;
    procedure SetParamValue(const paramname: WideString; paramvalue: OleVariant); safecall;
    function GetParamValue(const paramname: WideString): OleVariant; safecall;
    function Execute: WordBool; safecall;
    procedure PrinterSetup; safecall;
    function ShowParams: WordBool; safecall;
    procedure SaveToPDF(const filename: WideString; compressed: WordBool); safecall;
    function PrintRange(frompage: Integer; topage: Integer; copies: Integer; collate: WordBool): WordBool; safecall;
    function Get_filename: WideString; safecall;
    procedure Set_filename(const Value: WideString); safecall;
    function Get_Preview: WordBool; safecall;
    procedure Set_Preview(Value: WordBool); safecall;
    function Get_ShowProgress: WordBool; safecall;
    procedure Set_ShowProgress(Value: WordBool); safecall;
    function Get_ShowPrintDialog: WordBool; safecall;
    procedure Set_ShowPrintDialog(Value: WordBool); safecall;
    function Get_Title: WideString; safecall;
    procedure Set_Title(const Value: WideString); safecall;
    function Get_Language: Integer; safecall;
    procedure Set_Language(Value: Integer); safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure InitiateAction; safecall;
    function IsRightToLeft: WordBool; safecall;
    function UseRightToLeftReading: WordBool; safecall;
    function UseRightToLeftScrollBar: WordBool; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_Cursor: Smallint; safecall;
    procedure Set_Cursor(Value: Smallint); safecall;
    function Get_HelpType: TxHelpType; safecall;
    procedure Set_HelpType(Value: TxHelpType); safecall;
    function Get_HelpKeyword: WideString; safecall;
    procedure Set_HelpKeyword(const Value: WideString); safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
    procedure AboutBox; safecall;
    procedure ExecuteRemote(const hostname: WideString; port: Integer; const user: WideString; 
                            const password: WideString; const aliasname: WideString; 
                            const reportname: WideString; const sql: WideString); safecall;
    procedure CalcReport(ShowProgress: WordBool); safecall;
    procedure Compose(const Report: ReportReport; Execute: WordBool); safecall;
    procedure SaveToText(const filename: WideString; const textdriver: WideString); safecall;
    function Get_Report: ReportReport; safecall;
    procedure SaveToExcel(const filename: WideString); safecall;
    procedure SaveToHTML(const filename: WideString); safecall;
    procedure SetRecordSet(const datasetname: WideString; const Value: IDispatch); safecall;
    procedure SaveToCustomText(const filename: WideString); safecall;
    procedure SaveToCSV(const filename: WideString); safecall;
    procedure SaveToSVG(const filename: WideString); safecall;
    procedure SaveToMetafile(const filename: WideString); safecall;
    procedure SaveToExcel2(const filename: WideString); safecall;
    function Get_DefaultPrinter: WideString; safecall;
    procedure Set_DefaultPrinter(const Value: WideString); safecall;
    function Get_PrintersAvailable: WideString; safecall;
    procedure GetRemoteParams(const hostname: WideString; port: Integer; const user: WideString; 
                              const password: WideString; const aliasname: WideString; 
                              const reportname: WideString); safecall;
    procedure SaveToCSV2(const filename: WideString; const separator: WideString); safecall;
    function Get_AsyncExecution: WordBool; safecall;
    procedure Set_AsyncExecution(Value: WordBool); safecall;
    procedure SaveToHTMLSingle(const filename: WideString); safecall;
    property filename: WideString read Get_filename write Set_filename;
    property Preview: WordBool read Get_Preview write Set_Preview;
    property ShowProgress: WordBool read Get_ShowProgress write Set_ShowProgress;
    property ShowPrintDialog: WordBool read Get_ShowPrintDialog write Set_ShowPrintDialog;
    property Title: WideString read Get_Title write Set_Title;
    property Language: Integer read Get_Language write Set_Language;
    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;
    property AlignDisabled: WordBool read Get_AlignDisabled;
    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Cursor: Smallint read Get_Cursor write Set_Cursor;
    property HelpType: TxHelpType read Get_HelpType write Set_HelpType;
    property HelpKeyword: WideString read Get_HelpKeyword write Set_HelpKeyword;
    property Report: ReportReport read Get_Report;
    property DefaultPrinter: WideString read Get_DefaultPrinter write Set_DefaultPrinter;
    property PrintersAvailable: WideString read Get_PrintersAvailable;
    property AsyncExecution: WordBool read Get_AsyncExecution write Set_AsyncExecution;
  end;

// *********************************************************************//
// DispIntf:  IReportManXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B3AE1470-158D-4855-83DB-BC3A2746C26E}
// *********************************************************************//
  IReportManXDisp = dispinterface
    ['{B3AE1470-158D-4855-83DB-BC3A2746C26E}']
    procedure SetDatasetSQL(const datasetname: WideString; const sqlsentence: WideString); dispid 1;
    procedure SetDatabaseConnectionString(const databasename: WideString; 
                                          const connectionstring: WideString); dispid 2;
    function GetDatasetSQL(const datasetname: WideString): WideString; dispid 3;
    function GetDatabaseConnectionString(const databasename: WideString): WideString; dispid 4;
    procedure SetParamValue(const paramname: WideString; paramvalue: OleVariant); dispid 5;
    function GetParamValue(const paramname: WideString): OleVariant; dispid 6;
    function Execute: WordBool; dispid 7;
    procedure PrinterSetup; dispid 8;
    function ShowParams: WordBool; dispid 9;
    procedure SaveToPDF(const filename: WideString; compressed: WordBool); dispid 10;
    function PrintRange(frompage: Integer; topage: Integer; copies: Integer; collate: WordBool): WordBool; dispid 11;
    property filename: WideString dispid 12;
    property Preview: WordBool dispid 13;
    property ShowProgress: WordBool dispid 14;
    property ShowPrintDialog: WordBool dispid 15;
    property Title: WideString dispid 16;
    property Language: Integer dispid 17;
    property DoubleBuffered: WordBool dispid 18;
    property AlignDisabled: WordBool readonly dispid 19;
    property VisibleDockClientCount: Integer readonly dispid 20;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; dispid 22;
    property Enabled: WordBool dispid -514;
    procedure InitiateAction; dispid 23;
    function IsRightToLeft: WordBool; dispid 24;
    function UseRightToLeftReading: WordBool; dispid 27;
    function UseRightToLeftScrollBar: WordBool; dispid 28;
    property Visible: WordBool dispid 29;
    property Cursor: Smallint dispid 30;
    property HelpType: TxHelpType dispid 31;
    property HelpKeyword: WideString dispid 32;
    procedure SetSubComponent(IsSubComponent: WordBool); dispid 34;
    procedure AboutBox; dispid -552;
    procedure ExecuteRemote(const hostname: WideString; port: Integer; const user: WideString; 
                            const password: WideString; const aliasname: WideString; 
                            const reportname: WideString; const sql: WideString); dispid 201;
    procedure CalcReport(ShowProgress: WordBool); dispid 202;
    procedure Compose(const Report: ReportReport; Execute: WordBool); dispid 203;
    procedure SaveToText(const filename: WideString; const textdriver: WideString); dispid 204;
    property Report: ReportReport readonly dispid 21;
    procedure SaveToExcel(const filename: WideString); dispid 25;
    procedure SaveToHTML(const filename: WideString); dispid 26;
    procedure SetRecordSet(const datasetname: WideString; const Value: IDispatch); dispid 33;
    procedure SaveToCustomText(const filename: WideString); dispid 35;
    procedure SaveToCSV(const filename: WideString); dispid 36;
    procedure SaveToSVG(const filename: WideString); dispid 37;
    procedure SaveToMetafile(const filename: WideString); dispid 38;
    procedure SaveToExcel2(const filename: WideString); dispid 39;
    property DefaultPrinter: WideString dispid 42;
    property PrintersAvailable: WideString readonly dispid 44;
    procedure GetRemoteParams(const hostname: WideString; port: Integer; const user: WideString; 
                              const password: WideString; const aliasname: WideString; 
                              const reportname: WideString); dispid 40;
    procedure SaveToCSV2(const filename: WideString; const separator: WideString); dispid 41;
    property AsyncExecution: WordBool dispid 43;
    procedure SaveToHTMLSingle(const filename: WideString); dispid 205;
  end;

// *********************************************************************//
// DispIntf:  IReportManXEvents
// Flags:     (4096) Dispatchable
// GUID:      {50909EA4-8F4F-4865-877D-287FC7072177}
// *********************************************************************//
  IReportManXEvents = dispinterface
    ['{50909EA4-8F4F-4865-877D-287FC7072177}']
  end;

// *********************************************************************//
// Interface: IReportReport
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2FCB34BE-8DD4-4567-A771-9965C2FD3A04}
// *********************************************************************//
  IReportReport = interface(IDispatch)
    ['{2FCB34BE-8DD4-4567-A771-9965C2FD3A04}']
    function Get_Params: ReportParameters; safecall;
    function Get_VCLReport: PChar; safecall;
    procedure AddColumn(Width: Integer; const Expression: WideString; const ExpFormat: WideString; 
                        const Caption: WideString; const CaptionFormat: WideString; 
                        const SumaryExpression: WideString; const SumaryFormat: WideString); safecall;
    function Get_AutoResizeColumns: WordBool; safecall;
    procedure Set_AutoResizeColumns(Value: WordBool); safecall;
    property Params: ReportParameters read Get_Params;
    property VCLReport: PChar read Get_VCLReport;
    property AutoResizeColumns: WordBool read Get_AutoResizeColumns write Set_AutoResizeColumns;
  end;

// *********************************************************************//
// DispIntf:  IReportReportDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2FCB34BE-8DD4-4567-A771-9965C2FD3A04}
// *********************************************************************//
  IReportReportDisp = dispinterface
    ['{2FCB34BE-8DD4-4567-A771-9965C2FD3A04}']
    property Params: ReportParameters readonly dispid 1;
    property VCLReport: {??PChar}OleVariant readonly dispid 3;
    procedure AddColumn(Width: Integer; const Expression: WideString; const ExpFormat: WideString; 
                        const Caption: WideString; const CaptionFormat: WideString; 
                        const SumaryExpression: WideString; const SumaryFormat: WideString); dispid 2;
    property AutoResizeColumns: WordBool dispid 4;
  end;

// *********************************************************************//
// Interface: IReportParameters
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A5F6E90E-DFE7-49DA-AA38-C1A41C995B6B}
// *********************************************************************//
  IReportParameters = interface(IDispatch)
    ['{A5F6E90E-DFE7-49DA-AA38-C1A41C995B6B}']
    function Get_Count: Integer; safecall;
    function Get_Items(Index: Integer): ReportParam; safecall;
    function ParamExists(const paramname: WideString): WordBool; safecall;
    property Count: Integer read Get_Count;
    property Items[Index: Integer]: ReportParam read Get_Items;
  end;

// *********************************************************************//
// DispIntf:  IReportParametersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A5F6E90E-DFE7-49DA-AA38-C1A41C995B6B}
// *********************************************************************//
  IReportParametersDisp = dispinterface
    ['{A5F6E90E-DFE7-49DA-AA38-C1A41C995B6B}']
    property Count: Integer readonly dispid 1;
    property Items[Index: Integer]: ReportParam readonly dispid 2;
    function ParamExists(const paramname: WideString): WordBool; dispid 3;
  end;

// *********************************************************************//
// Interface: IReportParam
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F1634F9E-DE5A-411E-9A9E-3A46707A7ABB}
// *********************************************************************//
  IReportParam = interface(IDispatch)
    ['{F1634F9E-DE5A-411E-9A9E-3A46707A7ABB}']
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Value: WideString); safecall;
    function Get_Description: WideString; safecall;
    procedure Set_Description(const Value: WideString); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_ParamType: TxParamType; safecall;
    procedure Set_ParamType(Value: TxParamType); safecall;
    function Get_Value: OleVariant; safecall;
    procedure Set_Value(Value: OleVariant); safecall;
    property Name: WideString read Get_Name write Set_Name;
    property Description: WideString read Get_Description write Set_Description;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property ParamType: TxParamType read Get_ParamType write Set_ParamType;
    property Value: OleVariant read Get_Value write Set_Value;
  end;

// *********************************************************************//
// DispIntf:  IReportParamDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F1634F9E-DE5A-411E-9A9E-3A46707A7ABB}
// *********************************************************************//
  IReportParamDisp = dispinterface
    ['{F1634F9E-DE5A-411E-9A9E-3A46707A7ABB}']
    property Name: WideString dispid 1;
    property Description: WideString dispid 2;
    property Visible: WordBool dispid 3;
    property ParamType: TxParamType dispid 4;
    property Value: OleVariant dispid 5;
  end;

// *********************************************************************//
// Interface: IReportmanXAServer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F3A6B88C-D629-402E-BC62-BAB0E2EE39AF}
// *********************************************************************//
  IReportmanXAServer = interface(IDispatch)
    ['{F3A6B88C-D629-402E-BC62-BAB0E2EE39AF}']
    procedure GetPDF(const Report: IReportReport; compressed: WordBool); safecall;
    procedure GetCustomText(const Report: IReportReport); safecall;
    procedure GetText(const Report: IReportReport); safecall;
    procedure GetCSV(const Report: IReportReport); safecall;
    procedure GetMetafile(const Report: IReportReport); safecall;
    procedure GetCSV2(const Report: IReportReport; const separator: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IReportmanXAServerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F3A6B88C-D629-402E-BC62-BAB0E2EE39AF}
// *********************************************************************//
  IReportmanXAServerDisp = dispinterface
    ['{F3A6B88C-D629-402E-BC62-BAB0E2EE39AF}']
    procedure GetPDF(const Report: IReportReport; compressed: WordBool); dispid 1;
    procedure GetCustomText(const Report: IReportReport); dispid 2;
    procedure GetText(const Report: IReportReport); dispid 3;
    procedure GetCSV(const Report: IReportReport); dispid 4;
    procedure GetMetafile(const Report: IReportReport); dispid 5;
    procedure GetCSV2(const Report: IReportReport; const separator: WideString); dispid 6;
  end;

// *********************************************************************//
// Interface: IPreviewControl
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3D8043B8-E2F6-4F5D-B055-571924F5B0DC}
// *********************************************************************//
  IPreviewControl = interface(IDispatch)
    ['{3D8043B8-E2F6-4F5D-B055-571924F5B0DC}']
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_AutoScroll: WordBool; safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    function Get_AutoSize: WordBool; safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    function Get_KeyPreview: WordBool; safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    function Get_PixelsPerInch: Integer; safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    function Get_PrintScale: TxPrintScale; safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    function Get_Scaled: WordBool; safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    function Get_Active: WordBool; safecall;
    function Get_DropTarget: WordBool; safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    function Get_HelpFile: WideString; safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_Cursor: Smallint; safecall;
    procedure Set_Cursor(Value: Smallint); safecall;
    procedure SetReport(const Report: IReportReport); safecall;
    function Get_AutoScale: TxAutoScaleType; safecall;
    procedure Set_AutoScale(Value: TxAutoScaleType); safecall;
    function Get_PreviewScale: Double; safecall;
    procedure Set_PreviewScale(Value: Double); safecall;
    function Get_EntirePageCount: Integer; safecall;
    procedure Set_EntirePageCount(Value: Integer); safecall;
    function Get_EntireTopDown: WordBool; safecall;
    procedure Set_EntireTopDown(Value: WordBool); safecall;
    procedure FirstPage; safecall;
    procedure PriorPage; safecall;
    procedure NextPage; safecall;
    procedure LastPage; safecall;
    procedure RefreshMetafile; safecall;
    function Get_Page: Integer; safecall;
    procedure Set_Page(Value: Integer); safecall;
    procedure DoScroll(vertical: WordBool; increment: Integer); safecall;
    function Get_Finished: WordBool; safecall;
    procedure Set_Finished(Value: WordBool); safecall;
    procedure SaveToFile(const filename: WideString; format: Integer; const textdriver: WideString; 
                         horzres: Integer; vertres: Integer; mono: WordBool); safecall;
    procedure Clear; safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property AutoScroll: WordBool read Get_AutoScroll write Set_AutoScroll;
    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property AxBorderStyle: TxActiveFormBorderStyle read Get_AxBorderStyle write Set_AxBorderStyle;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property Font: IFontDisp read Get_Font write Set_Font;
    property KeyPreview: WordBool read Get_KeyPreview write Set_KeyPreview;
    property PixelsPerInch: Integer read Get_PixelsPerInch write Set_PixelsPerInch;
    property PrintScale: TxPrintScale read Get_PrintScale write Set_PrintScale;
    property Scaled: WordBool read Get_Scaled write Set_Scaled;
    property Active: WordBool read Get_Active;
    property DropTarget: WordBool read Get_DropTarget write Set_DropTarget;
    property HelpFile: WideString read Get_HelpFile write Set_HelpFile;
    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;
    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Cursor: Smallint read Get_Cursor write Set_Cursor;
    property AutoScale: TxAutoScaleType read Get_AutoScale write Set_AutoScale;
    property PreviewScale: Double read Get_PreviewScale write Set_PreviewScale;
    property EntirePageCount: Integer read Get_EntirePageCount write Set_EntirePageCount;
    property EntireTopDown: WordBool read Get_EntireTopDown write Set_EntireTopDown;
    property Page: Integer read Get_Page write Set_Page;
    property Finished: WordBool read Get_Finished write Set_Finished;
  end;

// *********************************************************************//
// DispIntf:  IPreviewControlDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3D8043B8-E2F6-4F5D-B055-571924F5B0DC}
// *********************************************************************//
  IPreviewControlDisp = dispinterface
    ['{3D8043B8-E2F6-4F5D-B055-571924F5B0DC}']
    property Visible: WordBool dispid 1;
    property AutoScroll: WordBool dispid 2;
    property AutoSize: WordBool dispid 3;
    property AxBorderStyle: TxActiveFormBorderStyle dispid 4;
    property Caption: WideString dispid -518;
    property Color: OLE_COLOR dispid -501;
    property Font: IFontDisp dispid -512;
    property KeyPreview: WordBool dispid 5;
    property PixelsPerInch: Integer dispid 6;
    property PrintScale: TxPrintScale dispid 7;
    property Scaled: WordBool dispid 8;
    property Active: WordBool readonly dispid 9;
    property DropTarget: WordBool dispid 10;
    property HelpFile: WideString dispid 11;
    property DoubleBuffered: WordBool dispid 12;
    property VisibleDockClientCount: Integer readonly dispid 13;
    property Enabled: WordBool dispid -514;
    property Cursor: Smallint dispid 14;
    procedure SetReport(const Report: IReportReport); dispid 16;
    property AutoScale: TxAutoScaleType dispid 15;
    property PreviewScale: Double dispid 17;
    property EntirePageCount: Integer dispid 18;
    property EntireTopDown: WordBool dispid 19;
    procedure FirstPage; dispid 20;
    procedure PriorPage; dispid 21;
    procedure NextPage; dispid 22;
    procedure LastPage; dispid 23;
    procedure RefreshMetafile; dispid 24;
    property Page: Integer dispid 25;
    procedure DoScroll(vertical: WordBool; increment: Integer); dispid 26;
    property Finished: WordBool dispid 27;
    procedure SaveToFile(const filename: WideString; format: Integer; const textdriver: WideString; 
                         horzres: Integer; vertres: Integer; mono: WordBool); dispid 28;
    procedure Clear; dispid 29;
  end;

// *********************************************************************//
// DispIntf:  IPreviewControlEvents
// Flags:     (4096) Dispatchable
// GUID:      {7364E2EA-8EEC-4673-9059-3B078C388717}
// *********************************************************************//
  IPreviewControlEvents = dispinterface
    ['{7364E2EA-8EEC-4673-9059-3B078C388717}']
    procedure OnActivate; dispid 1;
    procedure OnClick; dispid 2;
    procedure OnCreate; dispid 3;
    procedure OnDblClick; dispid 5;
    procedure OnDestroy; dispid 6;
    procedure OnDeactivate; dispid 7;
    procedure OnKeyPress(var Key: Smallint); dispid 11;
    procedure OnPaint; dispid 16;
    procedure OnWorkProgress(records: Integer; pagecount: Integer; var docancel: WordBool); dispid 4;
    procedure OnPageDrawn(PageDrawn: Integer; PagesDrawn: Integer); dispid 8;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TReportManX
// Help String      : ReportManX Control
// Default Interface: IReportManX
// Def. Intf. DISP? : No
// Event   Interface: IReportManXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TReportManX = class(TOleControl)
  private
    FIntf: IReportManX;
    function  GetControlInterface: IReportManX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_Report: ReportReport;
  public
    procedure SetDatasetSQL(const datasetname: WideString; const sqlsentence: WideString);
    procedure SetDatabaseConnectionString(const databasename: WideString; 
                                          const connectionstring: WideString);
    function GetDatasetSQL(const datasetname: WideString): WideString;
    function GetDatabaseConnectionString(const databasename: WideString): WideString;
    procedure SetParamValue(const paramname: WideString; paramvalue: OleVariant);
    function GetParamValue(const paramname: WideString): OleVariant;
    function Execute: WordBool;
    procedure PrinterSetup;
    function ShowParams: WordBool;
    procedure SaveToPDF(const filename: WideString; compressed: WordBool);
    function PrintRange(frompage: Integer; topage: Integer; copies: Integer; collate: WordBool): WordBool;
    function DrawTextBiDiModeFlagsReadingOnly: Integer;
    procedure InitiateAction;
    function IsRightToLeft: WordBool;
    function UseRightToLeftReading: WordBool;
    function UseRightToLeftScrollBar: WordBool;
    procedure SetSubComponent(IsSubComponent: WordBool);
    procedure AboutBox;
    procedure ExecuteRemote(const hostname: WideString; port: Integer; const user: WideString; 
                            const password: WideString; const aliasname: WideString; 
                            const reportname: WideString; const sql: WideString);
    procedure CalcReport(ShowProgress: WordBool);
    procedure Compose(const Report: ReportReport; Execute: WordBool);
    procedure SaveToText(const filename: WideString; const textdriver: WideString);
    procedure SaveToExcel(const filename: WideString);
    procedure SaveToHTML(const filename: WideString);
    procedure SetRecordSet(const datasetname: WideString; const Value: IDispatch);
    procedure SaveToCustomText(const filename: WideString);
    procedure SaveToCSV(const filename: WideString);
    procedure SaveToSVG(const filename: WideString);
    procedure SaveToMetafile(const filename: WideString);
    procedure SaveToExcel2(const filename: WideString);
    procedure GetRemoteParams(const hostname: WideString; port: Integer; const user: WideString; 
                              const password: WideString; const aliasname: WideString; 
                              const reportname: WideString);
    procedure SaveToCSV2(const filename: WideString; const separator: WideString);
    procedure SaveToHTMLSingle(const filename: WideString);
    property  ControlInterface: IReportManX read GetControlInterface;
    property  DefaultInterface: IReportManX read GetControlInterface;
    property DoubleBuffered: WordBool index 18 read GetWordBoolProp write SetWordBoolProp;
    property AlignDisabled: WordBool index 19 read GetWordBoolProp;
    property VisibleDockClientCount: Integer index 20 read GetIntegerProp;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp;
    property Visible: WordBool index 29 read GetWordBoolProp write SetWordBoolProp;
    property Report: ReportReport read Get_Report;
    property PrintersAvailable: WideString index 44 read GetWideStringProp;
  published
    property Anchors;
    property filename: WideString index 12 read GetWideStringProp write SetWideStringProp stored False;
    property Preview: WordBool index 13 read GetWordBoolProp write SetWordBoolProp stored False;
    property ShowProgress: WordBool index 14 read GetWordBoolProp write SetWordBoolProp stored False;
    property ShowPrintDialog: WordBool index 15 read GetWordBoolProp write SetWordBoolProp stored False;
    property Title: WideString index 16 read GetWideStringProp write SetWideStringProp stored False;
    property Language: Integer index 17 read GetIntegerProp write SetIntegerProp stored False;
    property Cursor: Smallint index 30 read GetSmallintProp write SetSmallintProp stored False;
    property HelpType: TOleEnum index 31 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property HelpKeyword: WideString index 32 read GetWideStringProp write SetWideStringProp stored False;
    property DefaultPrinter: WideString index 42 read GetWideStringProp write SetWideStringProp stored False;
    property AsyncExecution: WordBool index 43 read GetWordBoolProp write SetWordBoolProp stored False;
  end;

// *********************************************************************//
// The Class CoReportReport provides a Create and CreateRemote method to          
// create instances of the default interface IReportReport exposed by              
// the CoClass ReportReport. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoReportReport = class
    class function Create: IReportReport;
    class function CreateRemote(const MachineName: string): IReportReport;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TReportReport
// Help String      : ReportReport Object
// Default Interface: IReportReport
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TReportReportProperties= class;
{$ENDIF}
  TReportReport = class(TOleServer)
  private
    FIntf: IReportReport;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TReportReportProperties;
    function GetServerProperties: TReportReportProperties;
{$ENDIF}
    function GetDefaultInterface: IReportReport;
  protected
    procedure InitServerData; override;
    function Get_Params: ReportParameters;
    function Get_VCLReport: PChar;
    function Get_AutoResizeColumns: WordBool;
    procedure Set_AutoResizeColumns(Value: WordBool);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IReportReport);
    procedure Disconnect; override;
    procedure AddColumn(Width: Integer; const Expression: WideString; const ExpFormat: WideString; 
                        const Caption: WideString; const CaptionFormat: WideString; 
                        const SumaryExpression: WideString; const SumaryFormat: WideString);
    property DefaultInterface: IReportReport read GetDefaultInterface;
    property Params: ReportParameters read Get_Params;
    property VCLReport: PChar read Get_VCLReport;
    property AutoResizeColumns: WordBool read Get_AutoResizeColumns write Set_AutoResizeColumns;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TReportReportProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TReportReport
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TReportReportProperties = class(TPersistent)
  private
    FServer:    TReportReport;
    function    GetDefaultInterface: IReportReport;
    constructor Create(AServer: TReportReport);
  protected
    function Get_Params: ReportParameters;
    function Get_VCLReport: PChar;
    function Get_AutoResizeColumns: WordBool;
    procedure Set_AutoResizeColumns(Value: WordBool);
  public
    property DefaultInterface: IReportReport read GetDefaultInterface;
  published
    property AutoResizeColumns: WordBool read Get_AutoResizeColumns write Set_AutoResizeColumns;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoReportParameters provides a Create and CreateRemote method to          
// create instances of the default interface IReportParameters exposed by              
// the CoClass ReportParameters. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoReportParameters = class
    class function Create: IReportParameters;
    class function CreateRemote(const MachineName: string): IReportParameters;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TReportParameters
// Help String      : ReportParameters Object
// Default Interface: IReportParameters
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TReportParametersProperties= class;
{$ENDIF}
  TReportParameters = class(TOleServer)
  private
    FIntf: IReportParameters;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TReportParametersProperties;
    function GetServerProperties: TReportParametersProperties;
{$ENDIF}
    function GetDefaultInterface: IReportParameters;
  protected
    procedure InitServerData; override;
    function Get_Count: Integer;
    function Get_Items(Index: Integer): ReportParam;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IReportParameters);
    procedure Disconnect; override;
    function ParamExists(const paramname: WideString): WordBool;
    property DefaultInterface: IReportParameters read GetDefaultInterface;
    property Count: Integer read Get_Count;
    property Items[Index: Integer]: ReportParam read Get_Items;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TReportParametersProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TReportParameters
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TReportParametersProperties = class(TPersistent)
  private
    FServer:    TReportParameters;
    function    GetDefaultInterface: IReportParameters;
    constructor Create(AServer: TReportParameters);
  protected
    function Get_Count: Integer;
    function Get_Items(Index: Integer): ReportParam;
  public
    property DefaultInterface: IReportParameters read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoReportParam provides a Create and CreateRemote method to          
// create instances of the default interface IReportParam exposed by              
// the CoClass ReportParam. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoReportParam = class
    class function Create: IReportParam;
    class function CreateRemote(const MachineName: string): IReportParam;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TReportParam
// Help String      : ReportParam Object
// Default Interface: IReportParam
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TReportParamProperties= class;
{$ENDIF}
  TReportParam = class(TOleServer)
  private
    FIntf: IReportParam;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TReportParamProperties;
    function GetServerProperties: TReportParamProperties;
{$ENDIF}
    function GetDefaultInterface: IReportParam;
  protected
    procedure InitServerData; override;
    function Get_Name: WideString;
    procedure Set_Name(const Value: WideString);
    function Get_Description: WideString;
    procedure Set_Description(const Value: WideString);
    function Get_Visible: WordBool;
    procedure Set_Visible(Value: WordBool);
    function Get_ParamType: TxParamType;
    procedure Set_ParamType(Value: TxParamType);
    function Get_Value: OleVariant;
    procedure Set_Value(Value: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IReportParam);
    procedure Disconnect; override;
    property DefaultInterface: IReportParam read GetDefaultInterface;
    property Value: OleVariant read Get_Value write Set_Value;
    property Name: WideString read Get_Name write Set_Name;
    property Description: WideString read Get_Description write Set_Description;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property ParamType: TxParamType read Get_ParamType write Set_ParamType;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TReportParamProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TReportParam
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TReportParamProperties = class(TPersistent)
  private
    FServer:    TReportParam;
    function    GetDefaultInterface: IReportParam;
    constructor Create(AServer: TReportParam);
  protected
    function Get_Name: WideString;
    procedure Set_Name(const Value: WideString);
    function Get_Description: WideString;
    procedure Set_Description(const Value: WideString);
    function Get_Visible: WordBool;
    procedure Set_Visible(Value: WordBool);
    function Get_ParamType: TxParamType;
    procedure Set_ParamType(Value: TxParamType);
    function Get_Value: OleVariant;
    procedure Set_Value(Value: OleVariant);
  public
    property DefaultInterface: IReportParam read GetDefaultInterface;
  published
    property Name: WideString read Get_Name write Set_Name;
    property Description: WideString read Get_Description write Set_Description;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property ParamType: TxParamType read Get_ParamType write Set_ParamType;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoReportmanXAServer provides a Create and CreateRemote method to          
// create instances of the default interface IReportmanXAServer exposed by              
// the CoClass ReportmanXAServer. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoReportmanXAServer = class
    class function Create: IReportmanXAServer;
    class function CreateRemote(const MachineName: string): IReportmanXAServer;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TReportmanXAServer
// Help String      : ReportmanXAServer Object
// Default Interface: IReportmanXAServer
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TReportmanXAServerProperties= class;
{$ENDIF}
  TReportmanXAServer = class(TOleServer)
  private
    FIntf: IReportmanXAServer;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TReportmanXAServerProperties;
    function GetServerProperties: TReportmanXAServerProperties;
{$ENDIF}
    function GetDefaultInterface: IReportmanXAServer;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IReportmanXAServer);
    procedure Disconnect; override;
    procedure GetPDF(const Report: IReportReport; compressed: WordBool);
    procedure GetCustomText(const Report: IReportReport);
    procedure GetText(const Report: IReportReport);
    procedure GetCSV(const Report: IReportReport);
    procedure GetMetafile(const Report: IReportReport);
    procedure GetCSV2(const Report: IReportReport; const separator: WideString);
    property DefaultInterface: IReportmanXAServer read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TReportmanXAServerProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TReportmanXAServer
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TReportmanXAServerProperties = class(TPersistent)
  private
    FServer:    TReportmanXAServer;
    function    GetDefaultInterface: IReportmanXAServer;
    constructor Create(AServer: TReportmanXAServer);
  protected
  public
    property DefaultInterface: IReportmanXAServer read GetDefaultInterface;
  published
  end;
{$ENDIF}



// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TPreviewControl
// Help String      : PreviewControl Control
// Default Interface: IPreviewControl
// Def. Intf. DISP? : No
// Event   Interface: IPreviewControlEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TPreviewControlOnKeyPress = procedure(ASender: TObject; var Key: Smallint) of object;
  TPreviewControlOnWorkProgress = procedure(ASender: TObject; records: Integer; pagecount: Integer; 
                                                              var docancel: WordBool) of object;
  TPreviewControlOnPageDrawn = procedure(ASender: TObject; PageDrawn: Integer; PagesDrawn: Integer) of object;

  TPreviewControl = class(TOleControl)
  private
    FOnActivate: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnCreate: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    FOnKeyPress: TPreviewControlOnKeyPress;
    FOnPaint: TNotifyEvent;
    FOnWorkProgress: TPreviewControlOnWorkProgress;
    FOnPageDrawn: TPreviewControlOnPageDrawn;
    FIntf: IPreviewControl;
    function  GetControlInterface: IPreviewControl;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure SetReport(const Report: IReportReport);
    procedure FirstPage;
    procedure PriorPage;
    procedure NextPage;
    procedure LastPage;
    procedure RefreshMetafile;
    procedure DoScroll(vertical: WordBool; increment: Integer);
    procedure SaveToFile(const filename: WideString; format: Integer; const textdriver: WideString; 
                         horzres: Integer; vertres: Integer; mono: WordBool);
    procedure Clear;
    property  ControlInterface: IPreviewControl read GetControlInterface;
    property  DefaultInterface: IPreviewControl read GetControlInterface;
    property Visible: WordBool index 1 read GetWordBoolProp write SetWordBoolProp;
    property Active: WordBool index 9 read GetWordBoolProp;
    property DropTarget: WordBool index 10 read GetWordBoolProp write SetWordBoolProp;
    property HelpFile: WideString index 11 read GetWideStringProp write SetWideStringProp;
    property DoubleBuffered: WordBool index 12 read GetWordBoolProp write SetWordBoolProp;
    property VisibleDockClientCount: Integer index 13 read GetIntegerProp;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp;
  published
    property Anchors;
    property AutoScroll: WordBool index 2 read GetWordBoolProp write SetWordBoolProp stored False;
    property AutoSize: WordBool index 3 read GetWordBoolProp write SetWordBoolProp stored False;
    property AxBorderStyle: TOleEnum index 4 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Caption: WideString index -518 read GetWideStringProp write SetWideStringProp stored False;
    property Color: TColor index -501 read GetTColorProp write SetTColorProp stored False;
    property Font: TFont index -512 read GetTFontProp write SetTFontProp stored False;
    property KeyPreview: WordBool index 5 read GetWordBoolProp write SetWordBoolProp stored False;
    property PixelsPerInch: Integer index 6 read GetIntegerProp write SetIntegerProp stored False;
    property PrintScale: TOleEnum index 7 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Scaled: WordBool index 8 read GetWordBoolProp write SetWordBoolProp stored False;
    property Cursor: Smallint index 14 read GetSmallintProp write SetSmallintProp stored False;
    property AutoScale: TOleEnum index 15 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property PreviewScale: Double index 17 read GetDoubleProp write SetDoubleProp stored False;
    property EntirePageCount: Integer index 18 read GetIntegerProp write SetIntegerProp stored False;
    property EntireTopDown: WordBool index 19 read GetWordBoolProp write SetWordBoolProp stored False;
    property Page: Integer index 25 read GetIntegerProp write SetIntegerProp stored False;
    property Finished: WordBool index 27 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnCreate: TNotifyEvent read FOnCreate write FOnCreate;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnKeyPress: TPreviewControlOnKeyPress read FOnKeyPress write FOnKeyPress;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property OnWorkProgress: TPreviewControlOnWorkProgress read FOnWorkProgress write FOnWorkProgress;
    property OnPageDrawn: TPreviewControlOnPageDrawn read FOnPageDrawn write FOnPageDrawn;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'Servers';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TReportManX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{DC30E149-4129-450F-BDFE-BD9E6F31147E}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80040154*);
    Flags: $00000008;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TReportManX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IReportManX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TReportManX.GetControlInterface: IReportManX;
begin
  CreateControl;
  Result := FIntf;
end;

function TReportManX.Get_Report: ReportReport;
begin
    Result := DefaultInterface.Report;
end;

procedure TReportManX.SetDatasetSQL(const datasetname: WideString; const sqlsentence: WideString);
begin
  DefaultInterface.SetDatasetSQL(datasetname, sqlsentence);
end;

procedure TReportManX.SetDatabaseConnectionString(const databasename: WideString; 
                                                  const connectionstring: WideString);
begin
  DefaultInterface.SetDatabaseConnectionString(databasename, connectionstring);
end;

function TReportManX.GetDatasetSQL(const datasetname: WideString): WideString;
begin
  Result := DefaultInterface.GetDatasetSQL(datasetname);
end;

function TReportManX.GetDatabaseConnectionString(const databasename: WideString): WideString;
begin
  Result := DefaultInterface.GetDatabaseConnectionString(databasename);
end;

procedure TReportManX.SetParamValue(const paramname: WideString; paramvalue: OleVariant);
begin
  DefaultInterface.SetParamValue(paramname, paramvalue);
end;

function TReportManX.GetParamValue(const paramname: WideString): OleVariant;
begin
  Result := DefaultInterface.GetParamValue(paramname);
end;

function TReportManX.Execute: WordBool;
begin
  Result := DefaultInterface.Execute;
end;

procedure TReportManX.PrinterSetup;
begin
  DefaultInterface.PrinterSetup;
end;

function TReportManX.ShowParams: WordBool;
begin
  Result := DefaultInterface.ShowParams;
end;

procedure TReportManX.SaveToPDF(const filename: WideString; compressed: WordBool);
begin
  DefaultInterface.SaveToPDF(filename, compressed);
end;

function TReportManX.PrintRange(frompage: Integer; topage: Integer; copies: Integer; 
                                collate: WordBool): WordBool;
begin
  Result := DefaultInterface.PrintRange(frompage, topage, copies, collate);
end;

function TReportManX.DrawTextBiDiModeFlagsReadingOnly: Integer;
begin
  Result := DefaultInterface.DrawTextBiDiModeFlagsReadingOnly;
end;

procedure TReportManX.InitiateAction;
begin
  DefaultInterface.InitiateAction;
end;

function TReportManX.IsRightToLeft: WordBool;
begin
  Result := DefaultInterface.IsRightToLeft;
end;

function TReportManX.UseRightToLeftReading: WordBool;
begin
  Result := DefaultInterface.UseRightToLeftReading;
end;

function TReportManX.UseRightToLeftScrollBar: WordBool;
begin
  Result := DefaultInterface.UseRightToLeftScrollBar;
end;

procedure TReportManX.SetSubComponent(IsSubComponent: WordBool);
begin
  DefaultInterface.SetSubComponent(IsSubComponent);
end;

procedure TReportManX.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure TReportManX.ExecuteRemote(const hostname: WideString; port: Integer; 
                                    const user: WideString; const password: WideString; 
                                    const aliasname: WideString; const reportname: WideString; const sql: WideString);
begin
  DefaultInterface.ExecuteRemote(hostname, port, user, password, aliasname, reportname, sql);
end;

procedure TReportManX.CalcReport(ShowProgress: WordBool);
begin
  DefaultInterface.CalcReport(ShowProgress);
end;

procedure TReportManX.Compose(const Report: ReportReport; Execute: WordBool);
begin
  DefaultInterface.Compose(Report, Execute);
end;

procedure TReportManX.SaveToText(const filename: WideString; const textdriver: WideString);
begin
  DefaultInterface.SaveToText(filename, textdriver);
end;

procedure TReportManX.SaveToExcel(const filename: WideString);
begin
  DefaultInterface.SaveToExcel(filename);
end;

procedure TReportManX.SaveToHTML(const filename: WideString);
begin
  DefaultInterface.SaveToHTML(filename);
end;

procedure TReportManX.SetRecordSet(const datasetname: WideString; const Value: IDispatch);
begin
  DefaultInterface.SetRecordSet(datasetname, Value);
end;

procedure TReportManX.SaveToCustomText(const filename: WideString);
begin
  DefaultInterface.SaveToCustomText(filename);
end;

procedure TReportManX.SaveToCSV(const filename: WideString);
begin
  DefaultInterface.SaveToCSV(filename);
end;

procedure TReportManX.SaveToSVG(const filename: WideString);
begin
  DefaultInterface.SaveToSVG(filename);
end;

procedure TReportManX.SaveToMetafile(const filename: WideString);
begin
  DefaultInterface.SaveToMetafile(filename);
end;

procedure TReportManX.SaveToExcel2(const filename: WideString);
begin
  DefaultInterface.SaveToExcel2(filename);
end;

procedure TReportManX.GetRemoteParams(const hostname: WideString; port: Integer; 
                                      const user: WideString; const password: WideString; 
                                      const aliasname: WideString; const reportname: WideString);
begin
  DefaultInterface.GetRemoteParams(hostname, port, user, password, aliasname, reportname);
end;

procedure TReportManX.SaveToCSV2(const filename: WideString; const separator: WideString);
begin
  DefaultInterface.SaveToCSV2(filename, separator);
end;

procedure TReportManX.SaveToHTMLSingle(const filename: WideString);
begin
  DefaultInterface.SaveToHTMLSingle(filename);
end;

class function CoReportReport.Create: IReportReport;
begin
  Result := CreateComObject(CLASS_ReportReport) as IReportReport;
end;

class function CoReportReport.CreateRemote(const MachineName: string): IReportReport;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ReportReport) as IReportReport;
end;

procedure TReportReport.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{E30FD4FC-F47A-4932-A3E6-6694550588F3}';
    IntfIID:   '{2FCB34BE-8DD4-4567-A771-9965C2FD3A04}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TReportReport.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IReportReport;
  end;
end;

procedure TReportReport.ConnectTo(svrIntf: IReportReport);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TReportReport.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TReportReport.GetDefaultInterface: IReportReport;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TReportReport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TReportReportProperties.Create(Self);
{$ENDIF}
end;

destructor TReportReport.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TReportReport.GetServerProperties: TReportReportProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TReportReport.Get_Params: ReportParameters;
begin
    Result := DefaultInterface.Params;
end;

function TReportReport.Get_VCLReport: PChar;
begin
    Result := DefaultInterface.VCLReport;
end;

function TReportReport.Get_AutoResizeColumns: WordBool;
begin
    Result := DefaultInterface.AutoResizeColumns;
end;

procedure TReportReport.Set_AutoResizeColumns(Value: WordBool);
begin
  DefaultInterface.Set_AutoResizeColumns(Value);
end;

procedure TReportReport.AddColumn(Width: Integer; const Expression: WideString; 
                                  const ExpFormat: WideString; const Caption: WideString; 
                                  const CaptionFormat: WideString; 
                                  const SumaryExpression: WideString; const SumaryFormat: WideString);
begin
  DefaultInterface.AddColumn(Width, Expression, ExpFormat, Caption, CaptionFormat, 
                             SumaryExpression, SumaryFormat);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TReportReportProperties.Create(AServer: TReportReport);
begin
  inherited Create;
  FServer := AServer;
end;

function TReportReportProperties.GetDefaultInterface: IReportReport;
begin
  Result := FServer.DefaultInterface;
end;

function TReportReportProperties.Get_Params: ReportParameters;
begin
    Result := DefaultInterface.Params;
end;

function TReportReportProperties.Get_VCLReport: PChar;
begin
    Result := DefaultInterface.VCLReport;
end;

function TReportReportProperties.Get_AutoResizeColumns: WordBool;
begin
    Result := DefaultInterface.AutoResizeColumns;
end;

procedure TReportReportProperties.Set_AutoResizeColumns(Value: WordBool);
begin
  DefaultInterface.Set_AutoResizeColumns(Value);
end;

{$ENDIF}

class function CoReportParameters.Create: IReportParameters;
begin
  Result := CreateComObject(CLASS_ReportParameters) as IReportParameters;
end;

class function CoReportParameters.CreateRemote(const MachineName: string): IReportParameters;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ReportParameters) as IReportParameters;
end;

procedure TReportParameters.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F79CF82C-C2AD-46CC-ABEA-084016CFE58A}';
    IntfIID:   '{A5F6E90E-DFE7-49DA-AA38-C1A41C995B6B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TReportParameters.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IReportParameters;
  end;
end;

procedure TReportParameters.ConnectTo(svrIntf: IReportParameters);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TReportParameters.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TReportParameters.GetDefaultInterface: IReportParameters;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TReportParameters.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TReportParametersProperties.Create(Self);
{$ENDIF}
end;

destructor TReportParameters.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TReportParameters.GetServerProperties: TReportParametersProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TReportParameters.Get_Count: Integer;
begin
    Result := DefaultInterface.Count;
end;

function TReportParameters.Get_Items(Index: Integer): ReportParam;
begin
    Result := DefaultInterface.Items[Index];
end;

function TReportParameters.ParamExists(const paramname: WideString): WordBool;
begin
  Result := DefaultInterface.ParamExists(paramname);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TReportParametersProperties.Create(AServer: TReportParameters);
begin
  inherited Create;
  FServer := AServer;
end;

function TReportParametersProperties.GetDefaultInterface: IReportParameters;
begin
  Result := FServer.DefaultInterface;
end;

function TReportParametersProperties.Get_Count: Integer;
begin
    Result := DefaultInterface.Count;
end;

function TReportParametersProperties.Get_Items(Index: Integer): ReportParam;
begin
    Result := DefaultInterface.Items[Index];
end;

{$ENDIF}

class function CoReportParam.Create: IReportParam;
begin
  Result := CreateComObject(CLASS_ReportParam) as IReportParam;
end;

class function CoReportParam.CreateRemote(const MachineName: string): IReportParam;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ReportParam) as IReportParam;
end;

procedure TReportParam.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{E96B253E-143E-40E8-BFDA-366C5F112DAE}';
    IntfIID:   '{F1634F9E-DE5A-411E-9A9E-3A46707A7ABB}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TReportParam.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IReportParam;
  end;
end;

procedure TReportParam.ConnectTo(svrIntf: IReportParam);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TReportParam.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TReportParam.GetDefaultInterface: IReportParam;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TReportParam.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TReportParamProperties.Create(Self);
{$ENDIF}
end;

destructor TReportParam.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TReportParam.GetServerProperties: TReportParamProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TReportParam.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

procedure TReportParam.Set_Name(const Value: WideString);
  { Warning: The property Name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Name := Value;
end;

function TReportParam.Get_Description: WideString;
begin
    Result := DefaultInterface.Description;
end;

procedure TReportParam.Set_Description(const Value: WideString);
  { Warning: The property Description has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Description := Value;
end;

function TReportParam.Get_Visible: WordBool;
begin
    Result := DefaultInterface.Visible;
end;

procedure TReportParam.Set_Visible(Value: WordBool);
begin
  DefaultInterface.Set_Visible(Value);
end;

function TReportParam.Get_ParamType: TxParamType;
begin
    Result := DefaultInterface.ParamType;
end;

procedure TReportParam.Set_ParamType(Value: TxParamType);
begin
  DefaultInterface.Set_ParamType(Value);
end;

function TReportParam.Get_Value: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.Value;
end;

procedure TReportParam.Set_Value(Value: OleVariant);
begin
  DefaultInterface.Set_Value(Value);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TReportParamProperties.Create(AServer: TReportParam);
begin
  inherited Create;
  FServer := AServer;
end;

function TReportParamProperties.GetDefaultInterface: IReportParam;
begin
  Result := FServer.DefaultInterface;
end;

function TReportParamProperties.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

procedure TReportParamProperties.Set_Name(const Value: WideString);
  { Warning: The property Name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Name := Value;
end;

function TReportParamProperties.Get_Description: WideString;
begin
    Result := DefaultInterface.Description;
end;

procedure TReportParamProperties.Set_Description(const Value: WideString);
  { Warning: The property Description has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Description := Value;
end;

function TReportParamProperties.Get_Visible: WordBool;
begin
    Result := DefaultInterface.Visible;
end;

procedure TReportParamProperties.Set_Visible(Value: WordBool);
begin
  DefaultInterface.Set_Visible(Value);
end;

function TReportParamProperties.Get_ParamType: TxParamType;
begin
    Result := DefaultInterface.ParamType;
end;

procedure TReportParamProperties.Set_ParamType(Value: TxParamType);
begin
  DefaultInterface.Set_ParamType(Value);
end;

function TReportParamProperties.Get_Value: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.Value;
end;

procedure TReportParamProperties.Set_Value(Value: OleVariant);
begin
  DefaultInterface.Set_Value(Value);
end;

{$ENDIF}

class function CoReportmanXAServer.Create: IReportmanXAServer;
begin
  Result := CreateComObject(CLASS_ReportmanXAServer) as IReportmanXAServer;
end;

class function CoReportmanXAServer.CreateRemote(const MachineName: string): IReportmanXAServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ReportmanXAServer) as IReportmanXAServer;
end;

procedure TReportmanXAServer.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{FD3BE5E5-CBE4-4C29-A733-8CB842999075}';
    IntfIID:   '{F3A6B88C-D629-402E-BC62-BAB0E2EE39AF}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TReportmanXAServer.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IReportmanXAServer;
  end;
end;

procedure TReportmanXAServer.ConnectTo(svrIntf: IReportmanXAServer);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TReportmanXAServer.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TReportmanXAServer.GetDefaultInterface: IReportmanXAServer;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TReportmanXAServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TReportmanXAServerProperties.Create(Self);
{$ENDIF}
end;

destructor TReportmanXAServer.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TReportmanXAServer.GetServerProperties: TReportmanXAServerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TReportmanXAServer.GetPDF(const Report: IReportReport; compressed: WordBool);
begin
  DefaultInterface.GetPDF(Report, compressed);
end;

procedure TReportmanXAServer.GetCustomText(const Report: IReportReport);
begin
  DefaultInterface.GetCustomText(Report);
end;

procedure TReportmanXAServer.GetText(const Report: IReportReport);
begin
  DefaultInterface.GetText(Report);
end;

procedure TReportmanXAServer.GetCSV(const Report: IReportReport);
begin
  DefaultInterface.GetCSV(Report);
end;

procedure TReportmanXAServer.GetMetafile(const Report: IReportReport);
begin
  DefaultInterface.GetMetafile(Report);
end;

procedure TReportmanXAServer.GetCSV2(const Report: IReportReport; const separator: WideString);
begin
  DefaultInterface.GetCSV2(Report, separator);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TReportmanXAServerProperties.Create(AServer: TReportmanXAServer);
begin
  inherited Create;
  FServer := AServer;
end;

function TReportmanXAServerProperties.GetDefaultInterface: IReportmanXAServer;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure TPreviewControl.InitControlData;
const
  CEventDispIDs: array [0..9] of DWORD = (
    $00000001, $00000002, $00000003, $00000005, $00000006, $00000007,
    $0000000B, $00000010, $00000004, $00000008);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CControlData: TControlData2 = (
    ClassID: '{45978803-4B15-4E0E-98CE-AED9B1E1B701}';
    EventIID: '{7364E2EA-8EEC-4673-9059-3B078C388717}';
    EventCount: 10;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80040154*);
    Flags: $0000001D;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnActivate) - Cardinal(Self);
end;

procedure TPreviewControl.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IPreviewControl;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TPreviewControl.GetControlInterface: IPreviewControl;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TPreviewControl.SetReport(const Report: IReportReport);
begin
  DefaultInterface.SetReport(Report);
end;

procedure TPreviewControl.FirstPage;
begin
  DefaultInterface.FirstPage;
end;

procedure TPreviewControl.PriorPage;
begin
  DefaultInterface.PriorPage;
end;

procedure TPreviewControl.NextPage;
begin
  DefaultInterface.NextPage;
end;

procedure TPreviewControl.LastPage;
begin
  DefaultInterface.LastPage;
end;

procedure TPreviewControl.RefreshMetafile;
begin
  DefaultInterface.RefreshMetafile;
end;

procedure TPreviewControl.DoScroll(vertical: WordBool; increment: Integer);
begin
  DefaultInterface.DoScroll(vertical, increment);
end;

procedure TPreviewControl.SaveToFile(const filename: WideString; format: Integer; 
                                     const textdriver: WideString; horzres: Integer; 
                                     vertres: Integer; mono: WordBool);
begin
  DefaultInterface.SaveToFile(filename, format, textdriver, horzres, vertres, mono);
end;

procedure TPreviewControl.Clear;
begin
  DefaultInterface.Clear;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TReportManX, TPreviewControl]);
  RegisterComponents(dtlServerPage, [TReportReport, TReportParameters, TReportParam, TReportmanXAServer]);
end;

end.
