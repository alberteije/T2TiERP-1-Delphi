unit rpwebreportx;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, WebReportManX_TLB,
//  rptranslator,rpgdidriver,
  rpwebmetaclient,
// rpmetafile,rpreport,
// rpfmainmetaviewvcl,
// rpmdconsts,
// IdHttp,
// rpmdprintconfigvcl,
// rpmdshfolder,
 StdVcl, StdCtrls;

type
  TWebReportMan = class(TActiveForm, IWebReportMan)
    Button1: TButton;
    LError: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    oldOnIdle:TIdleEvent;
    executed:Boolean;
    FEvents: IWebReportManEvents;
    Preview:Integer;
    PrinterConfig:Integer;
    MetaUrl:WideString;
    procedure AppIdle(Sender:TObject;var Done:Boolean);
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

procedure TWebReportMan.AppIdle(Sender:TObject;var Done:Boolean);
begin
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
var
 acontrol:TrpWebMetaPrint;
begin
 MetaUrl:=Value;
 try
  acontrol:=TrpWebMetaPrint.Create(nil);
  try
   acontrol.parent:=Self;
   acontrol.Align:=alclient;
   acontrol.caption:=Caption;
   acontrol.preview:=Preview<>0;
   acontrol.aForm:=Self;
   acontrol.PrinterConfig:=PrinterConfig<>0;
   acontrol.Invalidate;
   acontrol.MetaUrl:=MetaUrl;
   if Length(MetaUrl)>0 then
    acontrol.Execute;
  finally
   acontrol.Free;
  end;
 except
  On E:Exception do
  begin
   LError.Caption:=E.Message;
   LError.Update;
  end;
 end;
end;

procedure TWebReportMan.Set_Preview(Value: Integer);
begin
 Preview:=Value;
end;

procedure TWebReportMan.Set_PrinterConfig(Value: Integer);
begin
 PrinterConfig:=Value;
end;

procedure TWebReportMan.Button1Click(Sender: TObject);
var
 acontrol:TrpWebMetaPrint;
begin
 try
  acontrol:=TrpWebMetaPrint.Create(Self);
  acontrol.parent:=Self;
  acontrol.Align:=alclient;
  acontrol.caption:=Caption;
  acontrol.preview:=Preview<>0;
  acontrol.aForm:=Self;
  acontrol.PrinterConfig:=PrinterConfig<>0;
  acontrol.Invalidate;
  acontrol.MetaUrl:=MetaUrl;
  if Length(MetaUrl)>0 then
   acontrol.Execute;
 except
  On E:Exception do
  begin
   acontrol.Caption:=E.Message;
   acontrol.Invalidate;
  end;
 end;
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
    tmApartment);
end.
