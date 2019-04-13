unit rpwebreportx;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, WebReportManX_TLB,
  rpwebmetaclient,rptypes,rpmetafile,
  StdVcl, StdCtrls, XPMan, ExtCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TWebReportMan = class(TActiveForm, IWebReportMan)
    Timer1: TTimer;
    webmetaprint: TRpWebMetaPrint;
    procedure ActiveFormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ActiveFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FEvents: IWebReportManEvents;
    Preview:Integer;
    AsyncRead:Integer;
    ShowProgress:Integer;
    Embedded:Integer;
    PrinterConfig:Integer;
    Install:Integer;
    MetaUrl:WideString;
    Port:Integer;
    SSL:Integer;
    ShowPrintDialog:Integer;
    Copies:Integer;
    procedure ActivateEvent(Sender: TObject);
    procedure ClickEvent(Sender: TObject);
    procedure CreateEvent(Sender: TObject);
    procedure DblClickEvent(Sender: TObject);
    procedure DeactivateEvent(Sender: TObject);
    procedure DestroyEvent(Sender: TObject);
    procedure KeyPressEvent(Sender: TObject; var Key: Char);
    procedure PaintEvent(Sender: TObject);
  protected
    { Protected declarations }
    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    function Get_Active: WordBool; safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_AutoScroll: WordBool; safecall;
    function Get_AutoSize: WordBool; safecall;
    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    function Get_Caption: WideString; safecall;
    function Get_Color: OLE_COLOR; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    function Get_DropTarget: WordBool; safecall;
    function Get_Enabled: WordBool; safecall;
    function Get_Font: IFontDisp; safecall;
    function Get_HelpFile: WideString; safecall;
    function Get_KeyPreview: WordBool; safecall;
    function Get_PixelsPerInch: Integer; safecall;
    function Get_PrintScale: TxPrintScale; safecall;
    function Get_Scaled: WordBool; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_MetaUrl: WideString; safecall;
    function Get_Preview: Integer; safecall;
    function Get_PrinterConfig: Integer; safecall;
    procedure Set_MetaUrl(const Value: WideString); safecall;
    procedure Set_Preview(Value: Integer); safecall;
    procedure Set_PrinterConfig(Value: Integer); safecall;
    function Get_ShowProgress: Integer; safecall;
    procedure Set_ShowProgress(Value: Integer); safecall;
    function Get_Embedded: Integer; safecall;
    procedure Set_Embedded(Value: Integer); safecall;
    function Get_Install: Integer; safecall;
    procedure Set_Install(Value: Integer); safecall;
    function Get_Port: Integer; safecall;
    procedure Set_Port(Value: Integer); safecall;
    function Get_ShowPrintDialog: Integer; safecall;
    procedure Set_ShowPrintDialog(Value: Integer); safecall;
    function Get_Copies: Integer; safecall;
    procedure Set_Copies(Value: Integer); safecall;
    function Get_AsyncRead: Integer; safecall;
    procedure Set_AsyncRead(Value: Integer); safecall;
    function Get_SSL: Integer; safecall;
    procedure Set_SSL(Value: Integer); safecall;
  public
    { Public declarations }
    procedure Initialize; override;
  end;

implementation

uses ComObj, ComServ;

{$R *.DFM}

{ TWebReportMan }


procedure TWebReportMan.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  { Define property pages here.  Property pages are defined by calling
    DefinePropertyPage with the class id of the page.  For example,
      DefinePropertyPage(Class_WebReportManPage); }
end;

procedure TWebReportMan.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IWebReportManEvents;
  inherited EventSinkChanged(EventSink);
end;

procedure TWebReportMan.Initialize;
begin
  inherited Initialize;
  OnActivate := ActivateEvent;
  OnClick := ClickEvent;
  OnCreate := CreateEvent;
  OnDblClick := DblClickEvent;
  OnDeactivate := DeactivateEvent;
  OnDestroy := DestroyEvent;
  OnKeyPress := KeyPressEvent;
  OnPaint := PaintEvent;
  Copies:=1;
end;

function TWebReportMan.Get_Active: WordBool;
begin
  Result := Active;
end;

function TWebReportMan.Get_AlignDisabled: WordBool;
begin
  Result := AlignDisabled;
end;

function TWebReportMan.Get_AutoScroll: WordBool;
begin
  Result := AutoScroll;
end;

function TWebReportMan.Get_AutoSize: WordBool;
begin
  Result := AutoSize;
end;

function TWebReportMan.Get_AxBorderStyle: TxActiveFormBorderStyle;
begin
  Result := Ord(AxBorderStyle);
end;

function TWebReportMan.Get_Caption: WideString;
begin
  Result := WideString(Caption);
end;

function TWebReportMan.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(Color);
end;

function TWebReportMan.Get_DoubleBuffered: WordBool;
begin
  Result := DoubleBuffered;
end;

function TWebReportMan.Get_DropTarget: WordBool;
begin
  Result := DropTarget;
end;

function TWebReportMan.Get_Enabled: WordBool;
begin
  Result := Enabled;
end;

function TWebReportMan.Get_Font: IFontDisp;
begin
  GetOleFont(Font, Result);
end;

function TWebReportMan.Get_HelpFile: WideString;
begin
  Result := WideString(HelpFile);
end;

function TWebReportMan.Get_KeyPreview: WordBool;
begin
  Result := KeyPreview;
end;

function TWebReportMan.Get_PixelsPerInch: Integer;
begin
  Result := PixelsPerInch;
end;

function TWebReportMan.Get_PrintScale: TxPrintScale;
begin
  Result := Ord(PrintScale);
end;

function TWebReportMan.Get_Scaled: WordBool;
begin
  Result := Scaled;
end;



function TWebReportMan.Get_Visible: WordBool;
begin
  Result := Visible;
end;

function TWebReportMan.Get_VisibleDockClientCount: Integer;
begin
  Result := VisibleDockClientCount;
end;

procedure TWebReportMan._Set_Font(var Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TWebReportMan.ActivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnActivate;
end;

procedure TWebReportMan.ClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnClick;
end;

procedure TWebReportMan.CreateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnCreate;
end;

procedure TWebReportMan.DblClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDblClick;
end;

procedure TWebReportMan.DeactivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDeactivate;
end;

procedure TWebReportMan.DestroyEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDestroy;
end;

procedure TWebReportMan.KeyPressEvent(Sender: TObject; var Key: Char);
var
  TempKey: Smallint;
begin
  TempKey := Smallint(Key);
  if FEvents <> nil then FEvents.OnKeyPress(TempKey);
  Key := Char(TempKey);
end;

procedure TWebReportMan.PaintEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnPaint;
end;

procedure TWebReportMan.Set_AutoScroll(Value: WordBool);
begin
  AutoScroll := Value;
end;

procedure TWebReportMan.Set_AutoSize(Value: WordBool);
begin
  AutoSize := Value;
end;

procedure TWebReportMan.Set_AxBorderStyle(Value: TxActiveFormBorderStyle);
begin
  AxBorderStyle := TActiveFormBorderStyle(Value);
end;

procedure TWebReportMan.Set_Caption(const Value: WideString);
begin
  Caption := TCaption(Value);
end;

procedure TWebReportMan.Set_Color(Value: OLE_COLOR);
begin
  Color := TColor(Value);
end;

procedure TWebReportMan.Set_DoubleBuffered(Value: WordBool);
begin
  DoubleBuffered := Value;
end;

procedure TWebReportMan.Set_DropTarget(Value: WordBool);
begin
  DropTarget := Value;
end;

procedure TWebReportMan.Set_Enabled(Value: WordBool);
begin
  Enabled := Value;
end;

procedure TWebReportMan.Set_Font(const Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TWebReportMan.Set_HelpFile(const Value: WideString);
begin
  HelpFile := String(Value);
end;

procedure TWebReportMan.Set_KeyPreview(Value: WordBool);
begin
  KeyPreview := Value;
end;

procedure TWebReportMan.Set_PixelsPerInch(Value: Integer);
begin
  PixelsPerInch := Value;
end;

procedure TWebReportMan.Set_PrintScale(Value: TxPrintScale);
begin
  PrintScale := TPrintScale(Value);
end;

procedure TWebReportMan.Set_Scaled(Value: WordBool);
begin
  Scaled := Value;
end;



procedure TWebReportMan.Set_Visible(Value: WordBool);
begin
  Visible := Value;
end;




function TWebReportMan.Get_MetaUrl: WideString;
begin
 Result:=MetaUrl;
end;

function TWebReportMan.Get_Preview: Integer;
begin
 Result:=Preview;
end;

function TWebReportMan.Get_PrinterConfig: Integer;
begin
 Result:=PrinterConfig;
end;

procedure TWebReportMan.Set_MetaUrl(const Value: WideString);
begin
 MetaUrl:=Value;
end;

procedure TWebReportMan.Set_Preview(Value: Integer);
begin
 Preview:=Value;
end;

procedure TWebReportMan.Set_PrinterConfig(Value: Integer);
begin
 PrinterConfig:=Value;
end;


procedure TWebReportMan.ActiveFormCreate(Sender: TObject);
begin
 Timer1.Enabled:=true;
 Port:=80;
end;

function TWebReportMan.Get_ShowProgress: Integer;
begin
 Result:=ShowProgress;
end;

procedure TWebReportMan.Set_ShowProgress(Value: Integer);
begin
 ShowProgress:=Value;
end;

function TWebReportMan.Get_Embedded: Integer;
begin
 Result:=Embedded;
end;

procedure TWebReportMan.Set_Embedded(Value: Integer);
begin
 Embedded:=Value;
end;

procedure TWebReportMan.Timer1Timer(Sender: TObject);
var
 msg:string;
begin
 Timer1.Enabled:=false;
 try
  webmetaprint.Align:=alclient;
  webmetaprint.caption:=Caption;
  webmetaprint.preview:=Preview<>0;
  webmetaprint.AsyncRead:=AsyncRead<>0;
  webmetaprint.ShowProgress:=ShowProgress<>0;
  if Embedded<>0 then
   webmetaprint.aForm:=webmetaprint;
  webmetaprint.PrinterConfig:=PrinterConfig<>0;
  webmetaprint.Install:=Install<>0;
  webmetaprint.MetaUrl:=MetaUrl;
  webmetaprint.Port:=Port;
  webmetaprint.Copies:=Copies;
  webmetaprint.ShowPrintDialog:=ShowPrintDialog<>0;
  webmetaprint.SSL:=SSL<>0;
  if Length(MetaUrl)>0 then
  begin
   // Create the stream and handle behaviour of async reading
   webmetaprint.Execute;
  end;
 except
  On E:Exception do
  begin
   // Build message
   msg:=E.Message;
   msg:=msg+#10+'MetaUrl:'+MetaUrl;
   msg:=msg+#10+'Stream size:'+FormatFloat('##,##0',webmetaprint.StreamSize)+' bytes';
   msg:=msg+#10+'SSL:'+IntToStr(SSL);
   msg:=msg+#10+'AyncRead:'+BoolToStr(webmetaprint.AsyncRead);
   if (E is ERpBadFileFormat) then
    msg:=msg+#10+'BadFileFormat, position:'+FormatFloat('##,#0',ERpBadFileFormat(E).position);
   ShowMessage(msg);

   caption:=msg;
   webmetaprint.visible:=false;
   Invalidate;
  end;
 end;
end;


function TWebReportMan.Get_Install: Integer;
begin
 Result:=Install;
end;


procedure TWebReportMan.Set_Install(Value: Integer);
begin
 Install:=Value;
end;


procedure TWebReportMan.ActiveFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if assigned(webmetaprint.Meta) then
  webmetaprint.Meta.FormKeyDown(Self,Key,Shift);
end;

function TWebReportMan.Get_Port: Integer;
begin
 Result:=Port;
end;

procedure TWebReportMan.Set_Port(Value: Integer);
begin
 Port:=Value;
end;

function TWebReportMan.Get_ShowPrintDialog: Integer;
begin
 Result:=ShowPrintDialog;
end;

procedure TWebReportMan.Set_ShowPrintDialog(Value: Integer);
begin
 ShowPrintDialog:=Value;
end;

function TWebReportMan.Get_Copies: Integer;
begin
 Result:=Copies;
end;

procedure TWebReportMan.Set_Copies(Value: Integer);
begin
 Copies:=Value;
end;

function TWebReportMan.Get_AsyncRead: Integer;
begin
 Result:=AsyncRead;
end;

procedure TWebReportMan.Set_AsyncRead(Value: Integer);
begin
 AsyncRead:=Value;
end;

function TWebReportMan.Get_SSL: Integer;
begin
 Result:=SSL;
end;

procedure TWebReportMan.Set_SSL(Value: Integer);
begin
 SSL:=Value;
end;

initialization
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TWebReportMan,
    Class_WebReportMan,
    1,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmSingle);
// Has been changed from tmApartment to tmSingle
// Because TPrinter object is not thread safe
end.
