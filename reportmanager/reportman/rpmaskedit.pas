{*******************************************************}
{                                                       }
{       RpMaskEdit component                            }
{       A mask edit to enter numbers                    }
{                                                       }
{       Copyright (c) 1994-2004 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpmaskedit;

interface

{$I rpconf.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
  StdCtrls, Mask;

type
  TRpEditType=(tegeneral,teinteger,tefloat,tecurrency,teDate,teTime,teDateTime);

  TTValidChars=set of Char;

  TRpMaskEdit = class(TCustomMaskEdit)
  private
    { Private declarations }
    FValidChars:TTValidChars;
    FAlignment:TAlignment;
    FFocused:Boolean;
    FCanvas: TControlCanvas;
    FEditType:TRpEditType;
    FIntroExit:Boolean;
    FDisplayMask:string;
    oldtext:string;
    FDoValidate:boolean;
    procedure SetEditType(NewValue:TRpEditType);
    function  GetTextMargins: TPoint;
    procedure SetFocused(Value: Boolean);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KeyDown;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CheckValidData;
    function GetDisplayText:string;
    function Getentero:integer;
    function GetFloat:double;
    function GetCurr:Currency;
    function GetDate:TDateTime;
    function GetDateTime:TDateTime;
    function GetTime:TDateTime;
    function GetValue:variant;
    procedure SetValue(NewValue:variant);
  protected
    { Protected declarations }
   procedure KeyPress(var key:char);override;
   procedure Change;override;
  public
    { Public declarations }
    destructor Destroy;override;
    constructor Create(AOwner:TComponent);override;
    function IsValidChar(key:char):Boolean;
    property ValidChars:TTValidchars read FValidchars write FValidChars;
    property AsInteger:integer read getentero;
    property AsFloat:double read GetFloat;
    property AsCurrency:currency read GetCurr;
    property AsDate:TDateTime read GEtDate;
    property AsTime:TDateTime read GEttime;
    property AsDateTime:TDateTime read GEtDateTime;
    property Value:variant read GetValue write SetValue;
  published
    { Published declarations }
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property Text;
    property Displaytext:string read GetDisplayTExt;
    property EditMask;
    property EditType:TRpEditType read FEditType write SetEditType default tegeneral;
    property DisplayMask:string read FDisplayMask write FDisplaymask;
    property IntroExit:boolean read FIntroExit write FIntroExit default True;
    property DoValidate:Boolean read FDoValidate write FDoValidate default False;
    property ReadOnly;
  end;


implementation

procedure KillMessage(Wnd: HWnd; Msg: Integer);
// Delete the requested message from the queue, but throw back
// any WM_QUIT msgs that PeekMessage may also return
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.wparam);
end;

constructor TRpMaskEdit.create(AOwner:TComponent);
begin
 inherited Create(AOwner);

  ControlStyle := ControlStyle + [csReplicatable];
  FEditType:=tegeneral;
  FValidchars:=[#0..#255];
  FDisplayMask:='';
  FIntroExit:=True;
end;

destructor TRpMaskEdit.Destroy;
begin
  FCanvas.Free;
  inherited Destroy;
end;

procedure TRpMaskEdit.CMEnter(var Message: TCMEnter);
begin
  oldtext:=text;
  SetFocused(True);
  inherited;
end;

procedure TRpMaskEdit.CMExit(var Message: TCMExit);
begin
  if FDoValidate then
  begin
   try
     CheckValidData;
   except
     SelectAll;
     SetFocus;
     raise;
   end;
  end;
  SetFocused(False);
  CheckCursor;
  try
   Text:=String(Value);
  except

  end;
  DoExit;
end;

{$IFDEF DOTNETD}
procedure TRpMaskEdit.WMPaint(var Message: TWMPaint);
const
  AlignStyle : array[Boolean, TAlignment] of DWORD =
   ((WS_EX_LEFT, WS_EX_RIGHT, WS_EX_LEFT),
    (WS_EX_RIGHT, WS_EX_LEFT, WS_EX_LEFT));
var
  Left: Integer;
  Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  AAlignment: TAlignment;
  ExStyle: DWORD;
begin
  AAlignment := FAlignment;
  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
  if ((AAlignment = taLeftJustify) or FFocused) and
    not (csPaintCopy in ControlState) then
  begin
    if SysLocale.MiddleEast and HandleAllocated and (IsRightToLeft) then
    begin { This keeps the right aligned text, right aligned }
      ExStyle := DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) and (not WS_EX_RIGHT) and
        (not WS_EX_RTLREADING) and (not WS_EX_LEFTSCROLLBAR);
      if UseRightToLeftReading then ExStyle := ExStyle or WS_EX_RTLREADING;
      if UseRightToLeftScrollbar then ExStyle := ExStyle or WS_EX_LEFTSCROLLBAR;
      ExStyle := ExStyle or
        AlignStyle[UseRightToLeftAlignment, AAlignment];
      if DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) <> ExStyle then
        SetWindowLong(Handle, GWL_EXSTYLE, ExStyle);
    end;
    inherited;
    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      Brush.Color := Color;
      if not Enabled then
        Font.Color := clGrayText;
      if (csPaintCopy in ControlState) then
      begin
        S := DisplayText;
        case CharCase of
          ecUpperCase: S := UpperCase(S);
          ecLowerCase: S := LowerCase(S);
        end;
      end else
        S := EditText;
      if PasswordChar <> #0 then
        S := StringOfChar(PasswordChar, Length(S));
      Margins := GetTextMargins;
      case AAlignment of
        taLeftJustify: Left := Margins.X;
        taRightJustify: Left := ClientWidth - TextWidth(S) - Margins.X - 1;
      else
        Left := (ClientWidth - TextWidth(S)) div 2;
      end;
      if SysLocale.MiddleEast then UpdateTextFlags;
      TextRect(R, Left, Margins.Y, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;
{$ENDIF}

{$IFNDEF DOTNETD}
procedure TRpMaskEdit.WMPaint(var Message: TWMPaint);
var
  Left: Integer;
  Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
begin
  if ((FAlignment = taLeftJustify) or FFocused) and
    not (csPaintCopy in ControlState) then
  begin
    inherited;
    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    if not Enabled then
     FCanvas.Font.Color := clGrayText;
    with FCanvas do
    begin
      R := ClientRect;
      if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      Brush.Color := Color;
      if (csPaintCopy in ControlState) then
      begin
        S := DisplayText;
        case CharCase of
          ecUpperCase: S := AnsiUpperCase(S);
          ecLowerCase: S := AnsiLowerCase(S);
        end;
      end else
//        S := EditText;
        S := DisplayText;
      if PasswordChar <> #0 then FillChar(S[1], Length(S), PasswordChar);
      Margins := GetTextMargins;
      case FAlignment of
        taLeftJustify: Left := Margins.X;
        taRightJustify: Left := ClientWidth - TextWidth(S) - Margins.X - 1;
      else
        Left := (ClientWidth - TextWidth(S)) div 2;
      end;
      TextRect(R, Left, Margins.Y, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;
{$ENDIF}

function TRpMaskEdit.GetTextMargins: TPoint;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  if NewStyleControls then
  begin
    if BorderStyle = bsNone then I := 0 else
      if Ctl3D then I := 1 else I := 2;
    Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
    Result.Y := I;
  end else
  begin
    if BorderStyle = bsNone then I := 0 else
    begin
      DC := GetDC(0);
      GetTextMetrics(DC, SysMetrics);
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextMetrics(DC, Metrics);
      SelectObject(DC, SaveFont);
      ReleaseDC(0, DC);
      I := SysMetrics.tmHeight;
      if I > Metrics.tmHeight then I := Metrics.tmHeight;
      I := I div 4;
    end;
    Result.X := I;
    Result.Y := I;
  end;
end;

procedure TRpMaskEdit.SetEditType(NewValue:TRpEditType);
begin
 FEditType:=NewValue;
 case FEditType of
  tegeneral:
   begin
    FValidchars:=[#0..#255];
    FAlignment:=taLeftJustify;
   end;
  teinteger:
   begin
    FValidchars:=['+','-','0'..'9'];
    FAlignment:=taRightJustify;
   end;
  tedatetime:
   begin
{$IFDEF DOTNETD}
    FValidchars:=['0'..'9'];
{$ENDIF}
{$IFNDEF DOTNETD}
    FValidchars:=[DateSeparator,Timeseparator,'0'..'9'];
{$ENDIF}
    FAlignment:=taLeftJustify;
   end;
  tedate:
   begin
{$IFDEF DOTNETD}
    FValidchars:=['0'..'9'];
{$ENDIF}
{$IFNDEF DOTNETD}
    FValidchars:=[DateSeparator,'0'..'9'];
{$ENDIF}
    FAlignment:=taLeftJustify;
   end;
  tetime:
   begin
{$IFDEF DOTNETD}
    FValidchars:=['0'..'9'];
{$ENDIF}
{$IFNDEF DOTNETD}
    FValidchars:=[Timeseparator,'0'..'9'];
{$ENDIF}
    FAlignment:=taRightJustify;
   end;
  tefloat:
   begin
{$IFDEF DOTNETD}
    FValidchars:=['+','-','0'..'9','E','e'];
{$ENDIF}
{$IFNDEF DOTNETD}
    FValidchars:=[DecimalSeparator,'+','-','0'..'9','E','e'];
{$ENDIF}
    FAlignment:=taRightJustify;
   end;
  teCurrency:
   begin
{$IFDEF DOTNETD}
    FValidchars:=['+','-','0'..'9'];
{$ENDIF}
{$IFNDEF DOTNETD}
    FValidchars:=[DecimalSeparator,'+','-','0'..'9'];
{$ENDIF}
    FAlignment:=taRightJustify;
   end;
 end;
end;

procedure TRpMaskEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then Invalidate;
  end;
end;

procedure TRpMaskEdit.KeyPress(var Key: Char);
var
 curcontrol:TWincontrol;
begin
  if EditType=teDate then
  begin
   if (Key<>#13) then
    inherited KeyPress(Key);
  end
  else
   inherited KeyPress(Key);
  if ((Key in [#32..#255]) and
    (not IsValidChar(Key)) and (not (key=chr(13)))) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    #27:
      begin
        text:=oldtext;
        SelectAll;
        Key := #0;
      end;
    #13:
      begin
        Key := #0;
        if Parent<>nil then
        begin
         curcontrol:=TRpMaskEdit(parent).FIndNextCOntrol(Self,true,true,false);
         if curcontrol<>nil then
          curcontrol.setfocus;
        end;
      end;
  end;
end;

procedure TRpMaskEdit.CheckValidData;
begin
 // Mirem si es correcte el número
  case FEditType of
   teinteger:
    strtoint(text);
   tefloat:
    StrTofloat(Text);
   tecurrency:
    StrTocurr(TExt);
   tedate:
    StrToDate(TExt);
   tetime:
    StrToTime(TExt);
   teDatetime:
    StrToDateTime(TExt)
  end;
end;

function TRpMaskEdit.IsValidChar(key:char):Boolean;
begin
 result:=key in ValidChars;
{$IFDEF DOTNETD}
 if not result then
 begin
  case FEditType of
   teDate:
    Result:=String(Key)=String(DateSeparator);
   teTime:
    Result:=String(Key)=String(TimeSeparator);
   teDateTime:
    Result:=(String(Key)=String(DateSeparator)) or (String(Key)=String(TimeSeparator));
   teFloat,teCurrency:
    Result:=(String(Key)=String(DecimalSeparator));
  end;
 end;
{$ENDIF}
end;

function TRpMaskEdit.GetDisplayText:string;
begin
 if Length(FDisplaymask)<1 then
 begin
  case EditType of
   tegeneral:
    result:=text;
   teinteger:
    result:=IntToStr(Value);
   tecurrency:
    result:=CurrToStr(Value);
   tefloat:
    result:=FloatToStr(Value);
   teDate:
    result:=DateToStr(Value);
   teTime:
    result:=TimeToStr(Value);
   teDateTime:
    result:=DateTimeToStr(Value);
  end;
 end
 else
 case EditType of
  tegeneral:
   result:=text;
  teinteger,tefloat:
   result:=FormatFloat(fdisplaymask,Value);
  tecurrency:
   result:=FormatCurr(fdisplaymask,Value);
  teDate:
   result:=FormatDateTime(fdisplaymask,Value);
  teTime:
   result:=FormatDateTime(fdisplaymask,Value);
  teDateTime:
   result:=FormatDateTime(fdisplaymask,Value);
 end;
end;


procedure TRpMaskEdit.WMKeyDown(var Message: TWMKeyDown);
begin
{$IFDEF DOTNETD}
 if ((Message.CharCode=VK_DECIMAL) AND  (VK_DECIMAL<>Ord(DecimalSeparator[1])) ) then
{$ENDIF}
{$IFNDEF DOTNETD}
 if ((Message.CharCode=VK_DECIMAL) AND  (VK_DECIMAL<>Ord(DecimalSeparator)) ) then
{$ENDIF}
 begin
  KillMessage(Handle, WM_CHAR);
{$IFDEF DOTNETD}
  PostMessage(self.handle,wM_CHAR,ord(decimalseparator[1]),0);
{$ENDIF}
{$IFNDEF DOTNETD}
  PostMessage(self.handle,wM_CHAR,ord(decimalseparator),0);
{$ENDIF}
 end;
 if (Not FDoValidate) then
  if (Message.Charcode=VK_RETURN) then
   begin
    if IntroExit then
    begin
     KillMessage(Handle, WM_CHAR);
     PostMessage(self.handle,wM_KEYDOWN,VK_TAB,0);
    end;
   end;
 inherited;
end;



function TRpMaskEdit.Getentero:integer;
begin
 result:=StrToInt(Text);
end;

function TRpMaskEdit.GetFloat:double;
begin
 result:=StrTofloat(Text);
end;

function TRpMaskEdit.GetCurr:Currency;
begin
 result:=StrToCurr(Text);
end;

function TRpMaskEdit.GetDate:TDateTime;
begin
 result:=StrToDate(EditText);
end;

function TRpMaskEdit.GetTime:TDateTime;
begin
 result:=StrToTime(EditText);
end;

function TRpMaskEdit.GetDateTime:TDateTime;
begin
 result:=StrToDateTime(EditText);
end;

function TRpMaskEdit.GetValue:variant;
begin
 try
  case FEditType of
   teinteger:
    if Length(Trim(text))=0 then
     result:=0
    else
     result:=strtoint(text);
   tefloat:
    if Length(Trim(text))=0 then
     result:=0.0
    else
     result:=StrTofloat(Text);
   tecurrency:
    if Length(Trim(text))=0 then
     result:=0.0
    else
     result:=StrToCurr(Text);
   tedate:
    if Length(Trim(text))=0 then
     result:=Date
    else
     result:=StrToDate(TExt);
   tetime:
    if Length(Trim(text))=0 then
     result:=Time
    else
     result:=StrToTime(TExt);
   teDatetime:
    if Length(Trim(text))=0 then
     result:=Now
    else
     result:=StrToDateTime(TExt)
   else
    result:=text;
  end;
 except
  case FEditType of
   teinteger:
    result:=0;
   tefloat:
    result:=0.0;
   tecurrency:
    result:=StrToCurr('0');
   tedate:
    result:=Date;
   tetime:
    result:=Time;
   teDatetime:
    result:=Now;
   else
    result:=text;
  end;
 end;
end;

procedure TRpMaskEdit.SetValue(NewValue:Variant);
begin
 if VarIsNull(NewValue) then
  text:=''
 else
 begin
  case FEditType of
   teinteger:
    text:=IntToStr(NewValue);
   tefloat:
    text:=Floattostr(NewValue);
   tecurrency:
    text:=CurrToStr(NewValue);
   tedate:
    text:=DateToStr(NewValue);
   tetime:
    text:=TimeToStr(NewValue);
   teDatetime:
    text:=DateTimeToStr(NewValue)
   else
    text:=NewValue;
  end;
 end;
end;



procedure TRpMaskEdit.Change;
begin
 if (csloading in componentstate) then
  exit;
 inherited change;
end;

end.
