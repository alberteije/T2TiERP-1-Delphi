unit LabeledCtrls;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Windows, ExtCtrls, Graphics, Messages,
  ComCtrls, Mask, MaskUtils, Consts, Clipbrd, Forms, JvBaseEdits, JvToolEdit;

type
  TBoundLabel = class(TCustomLabel)
  private
    function GetTop: Integer;
    function GetLeft: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    procedure AdjustBounds; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BiDiMode;
    property Caption;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Font;
    property Height: Integer read GetHeight write SetHeight;
    property Left: Integer read GetLeft;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Top: Integer read GetTop;
    property Touch;
    property Transparent;
    property Layout;
    property WordWrap;
    property Width: Integer read GetWidth write SetWidth;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TLabelPosition = (lpAbove, lpBelow, lpLeft, lpRight);

  TLabeledComboBox = class(TComboBox)
  private
    FEditLabel: TBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisiblechanged(var Message: TMessage);
      message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage);
      message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage);
      message CM_BIDIMODECHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalLabel;
  published
    property ComboBoxLabel: TBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
  end;

  TLabeledMaskEdit = class(TLabeledEdit)
  private
    fOriginalColor: TColor;
    fRequired: Boolean;

    //Mascara
    FEditMask: TEditMask;
    FMaskBlank: Char;
    FMaxChars: Integer;
    FMaskSave: Boolean;
    FMaskState: TMaskedState;
    FCaretPos: Integer;
    FBtnDownX: Integer;
    FOldValue: string;
    FSettingCursor: Boolean;
    function DoInputChar(var NewChar: Char; MaskOffset: Integer): Boolean;
    function InputChar(var NewChar: Char; Offset: Integer): Boolean;
    function DeleteSelection(var Value: string; Offset: Integer;
      Len: Integer): Boolean;
    function InputString(var Value: string; const NewValue: string;
      Offset: Integer): Integer;
    function AddEditFormat(const Value: string; Active: Boolean): string;
    function RemoveEditFormat(const Value: string): string;
    function FindLiteralChar (MaskOffset: Integer; InChar: Char): Integer;
    function GetEditText: string;
    function GetMasked: Boolean;
    function GetText: TMaskedText;
    function GetMaxLength: Integer;
    function CharKeys(var CharCode: Char): Boolean;
    procedure SetEditText(const Value: string);
    procedure SetEditMask(const Value: TEditMask);
    procedure SetMaxLength(Value: Integer);
    procedure SetText(const Value: TMaskedText); reintroduce;
    procedure DeleteKeys(CharCode: Word);
    procedure HomeEndKeys(CharCode: Word; Shift: TShiftState);
    procedure CursorInc(CursorPos: Integer; Incr: Integer);
    procedure CursorDec(CursorPos: Integer);
    procedure ArrowKeys(CharCode: Word; Shift: TShiftState);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;

    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit (var Message: TCMExit);  message CM_Exit;
  protected
    procedure ReformatText(const NewMask: string);
    procedure GetSel(var SelStart: Integer; var SelStop: Integer);
    procedure SetSel(SelStart: Integer; SelStop: Integer);
    procedure SetCursor(Pos: Integer);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function EditCanModify: Boolean; virtual;
    procedure Reset; virtual;
    function GetFirstEditChar: Integer;
    function GetLastEditChar: Integer;
    function GetNextEditChar(Offset: Integer): Integer;
    function GetPriorEditChar(Offset: Integer): Integer;
    function GetMaxChars: Integer;
    function Validate(const Value: string; var Pos: Integer): Boolean; virtual;
    procedure ValidateError; virtual;
    procedure CheckCursor;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ValidateEdit; virtual;
    procedure Clear; override;
    function GetTextLen: Integer; reintroduce;
    property IsMasked: Boolean read GetMasked;
    property EditText: string read GetEditText write SetEditText;
    property Text: TMaskedText read GetText write SetText;
  published
    property Required: Boolean read fRequired write fRequired;
    property EditMask: TEditMask read FEditMask write SetEditMask;
    property MaskState: TMaskedState read FMaskState write FMaskState;
    property MaxLength: Integer read GetMaxLength write SetMaxLength default 0;
  end;

  TLabeledCalcEdit = class(TJvCalcEdit)
  private
    FEditLabel: TBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisiblechanged(var Message: TMessage);
      message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage);
      message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage);
      message CM_BIDIMODECHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalLabel;
  published
    property CalcEditLabel: TBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
  end;

  TLabeledDateEdit = class(TJvDateEdit)
  private
    FDateEditLabel: TBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisiblechanged(var Message: TMessage);
      message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage);
      message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage);
      message CM_BIDIMODECHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalLabel;
  published
    property DateEditLabel: TBoundLabel read FDateEditLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
  end;

  TLabeledMemo = class(TMemo)
  private
    FMemoLabel: TBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisiblechanged(var Message: TMessage);
      message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage);
      message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage);
      message CM_BIDIMODECHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalLabel;
  published
    property MemoLabel: TBoundLabel read FMemoLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('LabeledControls', [TLabeledComboBox, TLabeledMaskEdit, TLabeledDateEdit, TLabeledMemo, TLabeledCalcEdit]);
end;

function AdjustedAlignment(RightToLeftAlignment: Boolean;
  Alignment: TAlignment): TAlignment;
begin
  Result := Alignment;
  if RightToLeftAlignment then
    case Result of
      taLeftJustify: Result := taRightJustify;
      taRightJustify: Result := taLeftJustify;
    end;
end;

{ TBoundLabel }

procedure TBoundLabel.AdjustBounds;
begin
  inherited AdjustBounds;
  if Owner is TLabeledComboBox then
    with Owner as TLabeledComboBox do
      SetLabelPosition(LabelPosition);
end;

constructor TBoundLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name := 'SubLabel';  { do not localize }
  SetSubComponent(True);
  if Assigned(AOwner) then
    Caption := AOwner.Name;
end;

function TBoundLabel.GetHeight: Integer;
begin
  Result := inherited Height;
end;

function TBoundLabel.GetLeft: Integer;
begin
  Result := inherited Left;
end;

function TBoundLabel.GetTop: Integer;
begin
  Result := inherited Top;
end;

function TBoundLabel.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TBoundLabel.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure TBoundLabel.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

{ TComboBoxTHZ }

procedure TLabeledComboBox.CMBidimodechanged(var Message: TMessage);
begin
  inherited;

  if FEditLabel <> nil then
    FEditLabel.BiDiMode := BiDiMode;
end;

procedure TLabeledComboBox.CMEnabledchanged(var Message: TMessage);
begin
  inherited;

  if FEditLabel <> nil then
    FEditLabel.Enabled := Enabled;
end;

procedure TLabeledComboBox.CMVisiblechanged(var Message: TMessage);
begin
  inherited;

  if FEditLabel <> nil then
    FEditLabel.Visible := Visible;
end;

constructor TLabeledComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Style := csDropDownList;

  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

procedure TLabeledComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end;

procedure TLabeledComboBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledComboBox.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if FEditLabel = nil then
    Exit;

  FLabelPosition := Value;

  case Value of
    lpAbove:
      case AdjustedAlignment(UseRightToLeftAlignment, taLeftJustify) of
        taLeftJustify:  P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FEditLabel.Width,
                                   Top - FEditLabel.Height - FLabelSpacing);
        taCenter:       P := Point(Left + (Width - FEditLabel.Width) div 2,
                                   Top - FEditLabel.Height - FLabelSpacing);
      end;
    lpBelow:
      case AdjustedAlignment(UseRightToLeftAlignment, taLeftJustify) of
        taLeftJustify:  P := Point(Left, Top + Height + FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FEditLabel.Width,
                                   Top + Height + FLabelSpacing);
        taCenter:       P := Point(Left + (Width - FEditLabel.Width) div 2,
                                   Top + Height + FLabelSpacing);
      end;
    lpLeft : P := Point(Left - FEditLabel.Width - FLabelSpacing,
                        Top + ((Height - FEditLabel.Height) div 2));
    lpRight: P := Point(Left + Width + FLabelSpacing,
                        Top + ((Height - FEditLabel.Height) div 2));
  end;
  FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, FEditLabel.Height);
end;

procedure TLabeledComboBox.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledComboBox.SetName(const Value: TComponentName);
var
  LClearText: Boolean;
begin
  if (csDesigning in ComponentState) and (FEditLabel <> nil) and
     ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
  begin
    FEditLabel.Caption := Value;
  end;

  LClearText := (csDesigning in ComponentState) and (Text = '');

  inherited SetName(Value);

  if LClearText then
    Text := '';
end;

procedure TLabeledComboBox.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);

  if FEditLabel = nil then
    Exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

procedure TLabeledComboBox.SetupInternalLabel;
begin
  if Assigned(FEditLabel) then
    Exit;

  FEditLabel := TBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;

{ TEditTHZ }

function TLabeledMaskEdit.AddEditFormat(const Value: string; Active: Boolean): string;
begin
  if not Active then
    Result := MaskDoFormatText(EditMask, Value, ' ')
  else
    Result := MaskDoFormatText(EditMask, Value, FMaskBlank);
end;

procedure TLabeledMaskEdit.ArrowKeys(CharCode: Word; Shift: TShiftState);
var
  SelStart, SelStop : Integer;
begin
  if (ssCtrl in Shift) then Exit;
  GetSel(SelStart, SelStop);
  if (ssShift in Shift) then
  begin
    if (CharCode = VK_RIGHT) then
    begin
      Inc(FCaretPos);
      if (SelStop = SelStart + 1) then
      begin
        SetSel(SelStart, SelStop);  {reset caret to end of string}
        Inc(FCaretPos);
      end;
      if FCaretPos > FMaxChars then FCaretPos := FMaxChars;
    end
    else  {if (CharCode = VK_LEFT) then}
    begin
      Dec(FCaretPos);
      if (SelStop = SelStart + 2) and
        (FCaretPos > SelStart) then
      begin
        SetSel(SelStart + 1, SelStart + 1);  {reset caret to show up at start}
        Dec(FCaretPos);
      end;
      if FCaretPos < 0 then FCaretPos := 0;
    end;
  end
  else
  begin
    if (SelStop - SelStart) > 1 then
    begin
{$IF NOT DEFINED(CLR)}
      if ((SelStop - SelStart) = 2) and IsLeadChar(EditText[SelStart+1]) then
      begin
        if (CharCode = VK_LEFT) then
          CursorDec(SelStart)
        else
          CursorInc(SelStart, 2);
        Exit;
      end;
{$IFEND}
      if SelStop = FCaretPos then
        Dec(FCaretPos);
      SetCursor(FCaretPos);
    end
    else if (CharCode = VK_LEFT) then
      CursorDec(SelStart)
    else   { if (CharCode = VK_RIGHT) then  }
    begin
      if SelStop = SelStart then
        SetCursor(SelStart)
      else
{$IF NOT DEFINED(CLR)}
        if IsLeadChar(EditText[SelStart+1]) then
          CursorInc(SelStart, 2)
        else
{$IFEND}
          CursorInc(SelStart, 1);
    end;
  end;
end;

function TLabeledMaskEdit.CharKeys(var CharCode: Char): Boolean;
var
  SelStart, SelStop : Integer;
  Txt: string;
{$IF NOT DEFINED(CLR)}
  CharMsg: TMsg;
{$IFEND}
begin
  Result := False;
  if Word(CharCode) = VK_ESCAPE then
  begin
    Reset;
    Exit;
  end;
  if not EditCanModify or ReadOnly then Exit;
  if (Word(CharCode) = VK_BACK) then Exit;
  if (Word(CharCode) = VK_RETURN) then
  begin
    ValidateEdit;
    Exit;
  end;

  GetSel(SelStart, SelStop);
  if (SelStop - SelStart) > 1 then
  begin
    DeleteKeys(VK_DELETE);
    SelStart := GetNextEditChar(SelStart);
    SetCursor(SelStart);
  end;
{$IF NOT DEFINED(CLR)}
  if IsLeadChar(CharCode) then
    if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) then
      if CharMsg.Message = WM_Quit then
        PostQuitMessage(CharMsg.wparam);
{$IFEND}
  Result := InputChar(CharCode, SelStart);
  if Result then
  begin
{$IF NOT DEFINED(CLR)}
    if IsLeadChar(CharCode) then
    begin
      Txt := CharCode + Char(CharMsg.wParam);
      SetSel(SelStart, SelStart + 2);
    end
    else
{$IFEND}
      Txt := CharCode;
    SendTextMessage(Handle, EM_REPLACESEL, 0, Txt);
    GetSel(SelStart, SelStop);
    CursorInc(SelStart, 0);
  end;
end;

procedure TLabeledMaskEdit.CheckCursor;
var
  SelStart, SelStop: Integer;
begin
  if not HandleAllocated then  Exit;
  if (IsMasked) then
  begin
    GetSel(SelStart, SelStop);
    if SelStart = SelStop then
      SetCursor(SelStart);
  end;
end;

procedure TLabeledMaskEdit.Clear;
begin
  inherited;
  Text := '';
end;

procedure TLabeledMaskEdit.CMEnter(var Message: TCMEnter);
begin
  fOriginalColor := Color;

  //Se for requerido muda cor do Edit
  if Required then
    Color := clInfoBk
  else
    Color:= clSkyBlue;

  SelStart := 0;  // Coloca o cursor no início
  SelectAll; // Seleciona todo o texto

  if IsMasked and not (csDesigning in ComponentState) then
  begin
    if not (msReEnter in FMaskState) then
    begin
      FOldValue := EditText;
      inherited;
    end;
    Exclude(FMaskState, msReEnter);
    CheckCursor;
  end
  else
    inherited;
end;

procedure TLabeledMaskEdit.CMExit(var Message: TCMExit);
begin
  Color := fOriginalColor;

  if IsMasked and not (csDesigning in ComponentState) then
  begin
    ValidateEdit;
    CheckCursor;
  end;
  inherited;
end;

procedure TLabeledMaskEdit.CMTextChanged(var Message: TMessage);
var
  SelStart, SelStop : Integer;
  Temp: Integer;
begin
  inherited;
  FOldValue := EditText;
  if HandleAllocated then
  begin
    GetSel(SelStart, SelStop);
    Temp := GetNextEditChar(SelStart);
    if Temp <> SelStart then
      SetCursor(Temp);
  end;
end;

procedure TLabeledMaskEdit.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  inherited;
  if (Message.CharCode = VK_ESCAPE) and IsMasked and Modified then
    Message.Result := 1;
end;

constructor TLabeledMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMaskState := [];
  FMaskBlank := DefaultBlank;

  //Self.CharCase := ecUpperCase;

  fOriginalColor := Color;
end;

procedure TLabeledMaskEdit.CursorDec(CursorPos: Integer);
var
  nuPos: Integer;
begin
  nuPos := CursorPos;
  Dec(nuPos);
  nuPos := GetPriorEditChar(nuPos);
  SetCursor(NuPos);
end;

procedure TLabeledMaskEdit.CursorInc(CursorPos, Incr: Integer);
var
  NuPos: Integer;
begin
  NuPos := CursorPos + Incr;
  NuPos := GetNextEditChar(NuPos);
  if IsLiteralChar(EditMask, nuPos) then
    NuPos := CursorPos;
  SetCursor(NuPos);
end;

procedure TLabeledMaskEdit.DeleteKeys(CharCode: Word);
var
  SelStart, SelStop : Integer;
  NuSelStart: Integer;
  Str: string;
begin
  if ReadOnly then Exit;
  GetSel(SelStart, SelStop);
  if ((SelStop - SelStart) <= 1) and (CharCode = VK_BACK) then
  begin
    NuSelStart := SelStart;
    CursorDec(SelStart);
    GetSel(SelStart, SelStop);
    if SelStart = NuSelStart then Exit;
  end;

  if (SelStop - SelStart) < 1 then Exit;

  Str := EditText;
  DeleteSelection(Str, SelStart, SelStop - SelStart);
  Str := Copy(Str, SelStart+1, SelStop - SelStart);
  SendTextMessage(Handle, EM_REPLACESEL, 0, Str);
  if (SelStop - SelStart) <> 1 then
  begin
    SelStart := GetNextEditChar(SelStart);
    SetCursor(SelStart);
  end
  else begin
    GetSel(SelStart, SelStop);
    SetCursor(SelStart - 1);
  end;
end;

function TLabeledMaskEdit.DeleteSelection(var Value: string; Offset,
  Len: Integer): Boolean;
var
  EndDel: Integer;
  StrOffset, MaskOffset, Temp: Integer;
  CType: TMaskCharType;
begin
  Result := True;
  if Len = 0 then Exit;

  StrOffset := Offset + 1;
  EndDel := StrOffset + Len;
  Temp := OffsetToMaskOffset(EditMask, Offset);
  if Temp < 0 then  Exit;
  for MaskOffset := Temp to Length(EditMask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    if CType in [mcLiteral, mcIntlLiteral] then
      Inc(StrOffset)
    else if CType in [mcMask, mcMaskOpt] then
    begin
      Value[StrOffset] := FMaskBlank;
      Inc(StrOffset);
    end;
    if StrOffset >= EndDel then Break;
  end;
end;

function TLabeledMaskEdit.DoInputChar(var NewChar: Char; MaskOffset: Integer): Boolean;
var
  Dir: TMaskDirectives;
  Str: string;
  CType: TMaskCharType;

{$IF NOT DEFINED(CLR)}
  function IsKatakana(const Chr: Byte): Boolean;
  begin
    Result := (SysLocale.PriLangID = LANG_JAPANESE) and (Chr in [$A1..$DF]);
  end;
{$IFEND}

{$IF NOT DEFINED(CLR)}
  function TestChar(NewChar: Char): Boolean;
  {var
    Offset: Integer;}
  begin
    {Offset := MaskOffsetToOffset(EditMask, MaskOffset);}
    Result := not ((MaskOffset < Length(EditMask)) and
               (UpCase(EditMask[MaskOffset]) = UpCase(EditMask[MaskOffset+1]))) {or
               (ByteType(EditText, Offset) = mbTrailByte) or
               (ByteType(EditText, Offset+1) = mbLeadByte)};
  end;
{$IFEND}

begin
  Result := True;
  CType := MaskGetCharType(EditMask, MaskOffset);
  if CType in [mcLiteral, mcIntlLiteral] then
    NewChar := MaskIntlLiteralToChar(EditMask[MaskOffset])
  else
  begin
    Dir := MaskGetCurrentDirectives(EditMask, MaskOffset);
    case EditMask[MaskOffset] of
      mMskNumeric, mMskNumericOpt:
        begin
          if not ((NewChar >= '0') and (NewChar <= '9')) then
            Result := False;
        end;
      mMskNumSymOpt:
        begin
          if not (((NewChar >= '0') and (NewChar <= '9')) or
                 (NewChar = ' ') or(NewChar = '+') or(NewChar = '-')) then
            Result := False;
        end;
      mMskAscii, mMskAsciiOpt:
        begin
{$IF NOT DEFINED(CLR)}
          if IsLeadChar(NewChar) and TestChar(NewChar) then
          begin
            Result := False;
            Exit;
          end;
{$IFEND}
          if IsCharAlpha(NewChar) then
          begin
            Str := ' ';
            Str[1] := NewChar;
            if (mdUpperCase in Dir)  then
              Str := AnsiUpperCase(Str)
            else if mdLowerCase in Dir then
              Str := AnsiLowerCase(Str);
            NewChar := Str[1];
          end;
        end;
      mMskAlpha, mMskAlphaOpt, mMskAlphaNum, mMskAlphaNumOpt:
        begin
{$IF NOT DEFINED(CLR)}
          if IsLeadChar(NewChar) then
          begin
            if TestChar(NewChar) then
              Result := False;
            Exit;
          end;
{$IFEND}
          Str := ' ';
          Str[1] := NewChar;
{$IF NOT DEFINED(CLR)}
          if IsKatakana(Byte(NewChar)) then
          begin
              NewChar := Str[1];
              Exit;
          end;
{$IFEND}
          if not IsCharAlpha(NewChar) then
          begin
            Result := False;
            if ((EditMask[MaskOffset] = mMskAlphaNum) or
                (EditMask[MaskOffset] = mMskAlphaNumOpt)) and
                (IsCharAlphaNumeric(NewChar)) then
              Result := True;
          end
          else if mdUpperCase in Dir then
            Str := AnsiUpperCase(Str)
          else if mdLowerCase in Dir then
            Str := AnsiLowerCase(Str);
          NewChar := Str[1];
        end;
    end;
  end;
end;

function TLabeledMaskEdit.EditCanModify: Boolean;
begin
  Result := True;
end;

function TLabeledMaskEdit.FindLiteralChar(MaskOffset: Integer; InChar: Char): Integer;
var
  CType: TMaskCharType;
  LitChar: Char;
begin
  Result := -1;
  while MaskOffset < Length(EditMask) do
  begin
    Inc(MaskOffset);
    CType := MaskGetCharType(EditMask, MaskOffset);
    if CType in [mcLiteral, mcIntlLiteral] then
    begin
      LitChar := EditMask[MaskOffset];
      if CType = mcIntlLiteral then
        LitChar := MaskIntlLiteralToChar(LitChar);
      if LitChar = InChar then
        Result := MaskOffset;
      Exit;
    end;
  end;
end;

function TLabeledMaskEdit.GetEditText: string;
begin
  Result := inherited Text;
end;

function TLabeledMaskEdit.GetFirstEditChar: Integer;
begin
  Result := 0;
  if IsMasked then
    Result := GetNextEditChar(0);
end;

function TLabeledMaskEdit.GetLastEditChar: Integer;
begin
  Result := GetMaxChars;
  if IsMasked then
    Result := GetPriorEditChar(Result - 1);
end;

function TLabeledMaskEdit.GetMasked: Boolean;
begin
  Result := EditMask <> '';
end;

function TLabeledMaskEdit.GetMaxChars: Integer;
begin
  if IsMasked then
    Result := FMaxChars
  else
    Result := inherited GetTextLen;
end;

function TLabeledMaskEdit.GetMaxLength: Integer;
begin
  Result := inherited MaxLength;
end;

function TLabeledMaskEdit.GetNextEditChar(Offset: Integer): Integer;
begin
  Result := Offset;
  while(Result < FMaxChars) and (IsLiteralChar(EditMask, Result)) do
    Inc(Result);
end;

function TLabeledMaskEdit.GetPriorEditChar(Offset: Integer): Integer;
begin
  Result := Offset;
  while(Result >= 0) and (IsLiteralChar(EditMask, Result)) do
    Dec(Result);
  if Result < 0 then
    Result := GetNextEditChar(Result);
end;

procedure TLabeledMaskEdit.GetSel(var SelStart, SelStop: Integer);
begin
{$IF DEFINED(CLR)}
  SendGetSel(SelStart, SelStop);
{$ELSE}
  SendMessage(Handle, EM_GETSEL, Integer(@SelStart), Integer(@SelStop));
{$IFEND}
end;

function TLabeledMaskEdit.GetText: TMaskedText;
begin
  if not IsMasked then
    Result := inherited Text
  else
  begin
    Result := RemoveEditFormat(EditText);
    if FMaskSave then
      Result := AddEditFormat(Result, False);
  end;
end;

function TLabeledMaskEdit.GetTextLen: Integer;
begin
  Result := Length(Text);
end;

procedure TLabeledMaskEdit.HomeEndKeys(CharCode: Word; Shift: TShiftState);
var
  SelStart, SelStop : Integer;
begin
  GetSel(SelStart, SelStop);
  if (CharCode = VK_HOME) then
  begin
    if (ssShift in Shift) then
    begin
      if (SelStart <> FCaretPos) and (SelStop <> (SelStart + 1)) then
        SelStop := SelStart + 1;
      SetSel(0, SelStop);
      CheckCursor;
    end
    else
      SetCursor(0);
    FCaretPos := 0;
  end
  else
  begin
    if (ssShift in Shift) then
    begin
      if (SelStop <> FCaretPos) and (SelStop <> (SelStart + 1)) then
        SelStart := SelStop - 1;
      SetSel(SelStart, FMaxChars);
      CheckCursor;
    end
    else
      SetCursor(FMaxChars);
    FCaretPos := FMaxChars;
  end;
end;

function TLabeledMaskEdit.InputChar(var NewChar: Char; Offset: Integer): Boolean;
var
  MaskOffset: Integer;
  CType: TMaskCharType;
  InChar: Char;
begin
  Result := True;
  if EditMask <> '' then
  begin
    Result := False;
    MaskOffset := OffsetToMaskOffset(EditMask, Offset);
    if MaskOffset >= 0 then
    begin
      CType := MaskGetCharType(EditMask, MaskOffset);
      InChar := NewChar;
      Result := DoInputChar(NewChar, MaskOffset);
      if not Result and (CType in [mcMask, mcMaskOpt]) then
      begin
        MaskOffset := FindLiteralChar (MaskOffset, InChar);
        if MaskOffset > 0 then
        begin
          MaskOffset := MaskOffsetToOffset(EditMask, MaskOffset);
          SetCursor (MaskOffset);
          Exit;
        end;
      end;
    end;
  end;
  if not Result then
    MessageBeep(0)
end;

function TLabeledMaskEdit.InputString(var Value: string; const NewValue: string;
  Offset: Integer): Integer;
var
  NewOffset, MaskOffset, Temp: Integer;
  CType: TMaskCharType;
  NewVal: string;
  NewChar: Char;
begin
  Result := Offset;
  if NewValue = '' then Exit;
  { replace chars with new chars, except literals }
  NewOffset := 1;
  NewVal := NewValue;
  Temp := OffsetToMaskOffset(EditMask, Offset);
  if Temp < 0 then  Exit;
  MaskOffset := Temp;
  While MaskOffset <= Length(EditMask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    if CType in [mcLiteral, mcIntlLiteral, mcMask, mcMaskOpt] then
    begin
      NewChar := NewVal[NewOffset];
      if not (DoInputChar(NewChar, MaskOffset)) then
      begin
{$IF NOT DEFINED(CLR)}
        if IsLeadChar(NewChar) then
          NewVal[NewOffset + 1] := FMaskBlank;
{$IFEND}
        NewChar := FMaskBlank;
      end;
        { if pasted text does not contain a literal in the right place,
          insert one }
      if not ((CType in [mcLiteral, mcIntlLiteral]) and
        (NewChar <> NewVal[NewOffset])) then
      begin
        NewVal[NewOffset] := NewChar;
{$IF NOT DEFINED(CLR)}
        if IsLeadChar(NewChar) then
        begin
          Inc(NewOffset);
          Inc(MaskOffset);
        end;
{$IFEND}
      end
      else
        NewVal := Copy(NewVal, 1, NewOffset-1) + NewChar +
          Copy(NewVal, NewOffset, Length (NewVal));
      Inc(NewOffset);
    end;
    if (NewOffset + Offset) > FMaxChars then Break;
    if (NewOffset) > Length(NewVal) then Break;
    Inc(MaskOffset);
  end;

  if (Offset + Length(NewVal)) < FMaxChars then
  begin
{$IF NOT DEFINED(CLR)}
    if ByteType(Value, OffSet + Length(NewVal) + 1) = mbTrailByte then
    begin
      NewVal := NewVal + FMaskBlank;
      Inc(NewOffset);
    end;
{$IFEND}
    Value := Copy(Value, 1, Offset) + NewVal +
      Copy(Value, OffSet + Length(NewVal) + 1,
        FMaxChars -(Offset + Length(NewVal)));
  end
  else
  begin
    Temp := Offset;
{$IF NOT DEFINED(CLR)}
    if (ByteType(NewVal, FMaxChars - Offset) = mbLeadByte) then
      Inc(Temp);
{$IFEND}
    Value := Copy(Value, 1, Offset) +
             Copy(NewVal, 1, FMaxChars - Temp);
  end;
  Result := NewOffset + Offset - 1;
end;

procedure TLabeledMaskEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not FSettingCursor then inherited KeyDown(Key, Shift);
  if IsMasked and (Key <> 0) and not (ssAlt in Shift) then
  begin
    if (Key = VK_LEFT) or(Key = VK_RIGHT) then
    begin
      ArrowKeys(Key, Shift);
      if not ((ssShift in Shift) or (ssCtrl in Shift)) then
        Key := 0;
      Exit;
    end
    else if (Key = VK_UP) or(Key = VK_DOWN) then
    begin
      Key := 0;
      Exit;
    end
    else if (Key = VK_HOME) or(Key = VK_END) then
    begin
      HomeEndKeys(Key, Shift);
      Key := 0;
      Exit;
    end
    else if ((Key = VK_DELETE) and not (ssShift in Shift)) or
      (Key = VK_BACK) then
    begin
      if EditCanModify then
        DeleteKeys(Key);
      Key := 0;
      Exit;
    end;
    CheckCursor;
  end;
end;

procedure TLabeledMaskEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if IsMasked and (Key <> #0) and not CharInSet(Key, [^V, ^X, ^C]) then
  begin
    CharKeys(Key);
    Key := #0;
  end;
end;

procedure TLabeledMaskEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if not FSettingCursor then inherited KeyUp(Key, Shift);
  if IsMasked and (Key <> 0) then
  begin
    if ((Key = VK_LEFT) or(Key = VK_RIGHT)) and (ssCtrl in Shift) then
      CheckCursor;
  end;
end;

procedure TLabeledMaskEdit.ReformatText(const NewMask: string);
var
  OldText: string;
begin
  OldText := RemoveEditFormat(EditText);
  FEditMask := NewMask;
  FMaxChars  := MaskOffsetToOffset(EditMask, Length(NewMask));
  FMaskSave  := MaskGetMaskSave(NewMask);
  FMaskBlank := MaskGetMaskBlank(NewMask);
  OldText := AddEditFormat(OldText, True);
  EditText := OldText;
end;

function TLabeledMaskEdit.RemoveEditFormat(const Value: string): string;
var
  I: Integer;
  OldLen: Integer;
  Offset, MaskOffset: Integer;
  CType: TMaskCharType;
  Dir: TMaskDirectives;
begin
  Offset := 1;
  Result := Value;
  for MaskOffset := 1 to Length(EditMask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);

    if CType in [mcLiteral, mcIntlLiteral] then
      Result := Copy(Result, 1, Offset - 1) +
        Copy(Result, Offset + 1, Length(Result) - Offset);
    if CType in [mcMask, mcMaskOpt] then Inc(Offset);
  end;

  Dir := MaskGetCurrentDirectives(EditMask, 1);
  if mdReverseDir in Dir then
  begin
    Offset := 1;
    for I := 1 to Length(Result) do
    begin
      if Result[I] = FMaskBlank then
        Inc(Offset)
      else
        break;
    end;
    if Offset <> 1 then
      Result := Copy(Result, Offset, Length(Result) - Offset + 1);
  end
  else begin
    OldLen := Length(Result);
    for I := 1 to OldLen do
    begin
      if Result[OldLen - I + 1] = FMaskBlank then
        SetLength(Result, Length(Result) - 1)
      else Break;
    end;
  end;
  if FMaskBlank <> ' ' then
  begin
    OldLen := Length(Result);
    for I := 1 to OldLen do
    begin
      if Result[I] = FMaskBlank then
        Result[I] := ' ';
      if I > OldLen then Break;
    end;
  end;
end;

procedure TLabeledMaskEdit.Reset;
begin
  if Modified then
  begin
    EditText := FOldValue;
    Modified := False;
  end;
end;

procedure TLabeledMaskEdit.SetCursor(Pos: Integer);
const
  ArrowKey: array[Boolean] of Word = (VK_LEFT, VK_RIGHT);
var
  SelStart, SelStop: Integer;
  KeyState: TKeyboardState;
  NewKeyState: TKeyboardState;
  I: Integer;
begin
{$IF NOT DEFINED(CLR)}
  if (Pos >= 1) and (ByteType(EditText, Pos) = mbLeadByte) then Dec(Pos);
{$IFEND}
  SelStart := Pos;
  if (IsMasked) then
  begin
    if SelStart < 0 then
      SelStart := 0;
    SelStop  := SelStart + 1;
{$IF NOT DEFINED(CLR)}
    if (Length(EditText) > SelStop) and IsLeadChar(EditText[SelStop]) then
      Inc(SelStop);
{$IFEND}
    if SelStart >= FMaxChars then
    begin
      SelStart := FMaxChars;
      SelStop  := SelStart;
    end;

    SetSel(SelStop, SelStop);

    if SelStart <> SelStop then
    begin
      GetKeyboardState(KeyState);
      for I := Low(NewKeyState) to High(NewKeyState) do
        NewKeyState[I] := 0;
      NewKeyState [VK_SHIFT] := $81;
      NewKeyState [ArrowKey[UseRightToLeftAlignment]] := $81;
      SetKeyboardState(NewKeyState);
      FSettingCursor := True;
      try
        SendMessage(Handle, WM_KEYDOWN, ArrowKey[UseRightToLeftAlignment], 1);
        SendMessage(Handle, WM_KEYUP, ArrowKey[UseRightToLeftAlignment], 1);
      finally
        FSettingCursor := False;
      end;
      SetKeyboardState(KeyState);
    end;
    FCaretPos := SelStart;
  end
  else
  begin
    if SelStart < 0 then
      SelStart := 0;
    if SelStart >= Length(EditText) then
      SelStart := Length(EditText);
    SetSel(SelStart, SelStart);
  end;
end;

procedure TLabeledMaskEdit.SetEditMask(const Value: TEditMask);
var
  SelStart, SelStop: Integer;
begin
  if Value <> EditMask then
  begin
    if (csDesigning in ComponentState) and (Value <> '') and
      not (csLoading in ComponentState) then
      EditText := '';
    if HandleAllocated then GetSel(SelStart, SelStop);
    ReformatText(Value);
    Exclude(FMaskState, msMasked);
    if EditMask <> '' then Include(FMaskState, msMasked);
    inherited MaxLength := 0;
    if IsMasked and (FMaxChars > 0) then
      inherited MaxLength := FMaxChars;
    if HandleAllocated and (GetFocus = Handle) and
       not (csDesigning in ComponentState) then
      SetCursor(SelStart);
  end;
end;

procedure TLabeledMaskEdit.SetEditText(const Value: string);
begin
  if GetEditText <> Value then
  begin
{$IF DEFINED(CLR)}
    SetTextBuf(Value);
{$ELSE}
    SetTextBuf(PChar(Value));
{$IFEND}
    CheckCursor;
  end;
end;

procedure TLabeledMaskEdit.SetMaxLength(Value: Integer);
begin
  if not IsMasked then
    inherited MaxLength := Value
  else
    inherited MaxLength := FMaxChars;
end;

procedure TLabeledMaskEdit.SetSel(SelStart, SelStop: Integer);
begin
  SendMessage(Handle, EM_SETSEL, SelStart, SelStop);
end;

procedure TLabeledMaskEdit.SetText(const Value: TMaskedText);
var
  OldText: string;
  Pos: Integer;
begin
  if not IsMasked then
    inherited Text := Value
  else
  begin
    OldText := Value;
    if FMaskSave then
      OldText := PadInputLiterals(EditMask, OldText, FMaskBlank)
    else
      OldText := AddEditFormat(OldText, True);
    if not (msDBSetText in FMaskState) and
      (csDesigning in ComponentState) and
      not (csLoading in ComponentState) and
      not Validate(OldText, Pos) then
      raise EDBEditError.CreateRes({$IFNDEF CLR}@{$ENDIF}SMaskErr);
    EditText := OldText;
  end;
end;

function TLabeledMaskEdit.Validate(const Value: string; var Pos: Integer): Boolean;
var
  Offset, MaskOffset: Integer;
  CType: TMaskCharType;
begin
  Result := True;
  Offset := 1;
  for MaskOffset := 1 to Length(EditMask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);

    if CType in [mcLiteral, mcIntlLiteral, mcMaskOpt] then
      Inc(Offset)
    else if (CType = mcMask) and (Value <> '') then
    begin
      if (Value [Offset] = FMaskBlank) or
        ((Value [Offset] = ' ') and (EditMask[MaskOffset] <> mMskAscii)) then
      begin
        Result := False;
        Pos := Offset - 1;
        Exit;
      end;
      Inc(Offset);
    end;
  end;
end;

procedure TLabeledMaskEdit.ValidateEdit;
var
  Str: string;
  Pos: Integer;
begin
  Str := EditText;
  if IsMasked and Modified then
  begin
    if not Validate(Str, Pos) then
    begin
      if not (csDesigning in ComponentState) then
      begin
        Include(FMaskState, msReEnter);
        SetFocus;
      end;
      SetCursor(Pos);
      ValidateError;
    end;
  end;
end;

procedure TLabeledMaskEdit.ValidateError;
begin
  MessageBeep(0);
  raise EDBEditError.CreateResFmt({$IFNDEF CLR}@{$ENDIF}SMaskEditErr, [EditMask]);
end;

procedure TLabeledMaskEdit.WMCut(var Message: TMessage);
begin
  if not (IsMasked) then
    inherited
  else
  begin
    CopyToClipboard;
    DeleteKeys(VK_DELETE);
    if HandleAllocated then
      SendMessage(Windows.GetParent(Handle), WM_COMMAND,
        MakeWParam(GetDlgCtrlID(Handle), EN_CHANGE), LPARAM(Handle));
  end;
end;

procedure TLabeledMaskEdit.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  FBtnDownX := Message.XPos;
end;

procedure TLabeledMaskEdit.WMLButtonUp(var Message: TWMLButtonUp);
var
  SelStart, SelStop : Integer;
begin
  inherited;
  if (IsMasked) then
  begin
    GetSel(SelStart, SelStop);
    FCaretPos := SelStart;
    if (SelStart <> SelStop) and (Message.XPos > FBtnDownX) then
      FCaretPos := SelStop;
    CheckCursor;
  end;
end;

procedure TLabeledMaskEdit.WMPaste(var Message: TMessage);
var
  Value: string;
  Str: string;
  SelStart, SelStop : Integer;
{$IF DEFINED(CLR)}
  Data: HGLOBAL;
  TextPtr: IntPtr;
{$IFEND}
begin
  if not (IsMasked) or ReadOnly then
    inherited
  else
  begin
{$IF DEFINED(CLR)}
    OpenClipBoard(0);
    try
      if Marshal.SystemDefaultCharSize > 1 then
        Data := GetClipboardData(CF_UNICODETEXT)
      else
        Data := GetClipboardData(CF_TEXT);
      if Data <> 0 then
      begin
        TextPtr := GlobalLock(Data);
        try
          Value := Marshal.PtrToStringAuto(TextPtr);
        finally
          GlobalUnlock(Data);
        end;
      end else
        Value := '';
    finally
      CloseClipBoard;
    end;
{$ELSE}
    Clipboard.Open;
    Value := Clipboard.AsText;
    Clipboard.Close;
{$IFEND}
    GetSel(SelStart, SelStop);
    Str := EditText;
    DeleteSelection(Str, SelStart, SelStop - SelStart);
    EditText := Str;
    SelStart := InputString(Str, Value, SelStart);
    EditText := Str;
    SetCursor(SelStart);
    if HandleAllocated then
      SendMessage(Windows.GetParent(Handle), WM_COMMAND,
        MakeWParam(GetDlgCtrlID(Handle), EN_CHANGE), LPARAM(Handle));
  end;
end;

procedure TLabeledMaskEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if (IsMasked) then
    CheckCursor;
end;

{ TDateEditTHZ }

procedure TLabeledDateEdit.CMBidimodechanged(var Message: TMessage);
begin
  inherited;

  if FDateEditLabel <> nil then
    FDateEditLabel.BiDiMode := BiDiMode;
end;

procedure TLabeledDateEdit.CMEnabledchanged(var Message: TMessage);
begin
  inherited;

  if FDateEditLabel <> nil then
    FDateEditLabel.Enabled := Enabled;
end;

procedure TLabeledDateEdit.CMVisiblechanged(var Message: TMessage);
begin
  inherited;

  if FDateEditLabel <> nil then
    FDateEditLabel.Visible := Visible;
end;

constructor TLabeledDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

procedure TLabeledDateEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FDateEditLabel) and (Operation = opRemove) then
    FDateEditLabel := nil;
end;

procedure TLabeledDateEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledDateEdit.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if FDateEditLabel = nil then
    Exit;

  FLabelPosition := Value;

  case Value of
    lpAbove:
      case AdjustedAlignment(UseRightToLeftAlignment, taLeftJustify) of
        taLeftJustify:  P := Point(Left, Top - FDateEditLabel.Height - FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FDateEditLabel.Width,
                                   Top - FDateEditLabel.Height - FLabelSpacing);
        taCenter:       P := Point(Left + (Width - FDateEditLabel.Width) div 2,
                                   Top - FDateEditLabel.Height - FLabelSpacing);
      end;
    lpBelow:
      case AdjustedAlignment(UseRightToLeftAlignment, taLeftJustify) of
        taLeftJustify:  P := Point(Left, Top + Height + FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FDateEditLabel.Width,
                                   Top + Height + FLabelSpacing);
        taCenter:       P := Point(Left + (Width - FDateEditLabel.Width) div 2,
                                   Top + Height + FLabelSpacing);
      end;
    lpLeft : P := Point(Left - FDateEditLabel.Width - FLabelSpacing,
                        Top + ((Height - FDateEditLabel.Height) div 2));
    lpRight: P := Point(Left + Width + FLabelSpacing,
                        Top + ((Height - FDateEditLabel.Height) div 2));
  end;
  FDateEditLabel.SetBounds(P.x, P.y, FDateEditLabel.Width, FDateEditLabel.Height);
end;

procedure TLabeledDateEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledDateEdit.SetName(const Value: TComponentName);
var
  LClearText: Boolean;
begin
  if (csDesigning in ComponentState) and (FDateEditLabel <> nil) and
     ((FDateEditLabel.GetTextLen = 0) or
     (CompareText(FDateEditLabel.Caption, Name) = 0)) then
  begin
    FDateEditLabel.Caption := Value;
  end;

  LClearText := (csDesigning in ComponentState) and (Text = '');

  inherited SetName(Value);

  if LClearText then
    Text := '';
end;

procedure TLabeledDateEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);

  if FDateEditLabel = nil then
    Exit;
  FDateEditLabel.Parent := AParent;
  FDateEditLabel.Visible := True;
end;

procedure TLabeledDateEdit.SetupInternalLabel;
begin
  if Assigned(FDateEditLabel) then
    Exit;

  FDateEditLabel := TBoundLabel.Create(Self);
  FDateEditLabel.FreeNotification(Self);
  FDateEditLabel.FocusControl := Self;
end;

{ TMemoTHZ }

procedure TLabeledMemo.CMBidimodechanged(var Message: TMessage);
begin
  inherited;

  if FMemoLabel <> nil then
    FMemoLabel.BiDiMode := BiDiMode;
end;

procedure TLabeledMemo.CMEnabledchanged(var Message: TMessage);
begin
  inherited;

  if FMemoLabel <> nil then
    FMemoLabel.Enabled := Enabled;
end;

procedure TLabeledMemo.CMVisiblechanged(var Message: TMessage);
begin
  inherited;

  if FMemoLabel <> nil then
    FMemoLabel.Visible := Visible;
end;

constructor TLabeledMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

procedure TLabeledMemo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FMemoLabel) and (Operation = opRemove) then
    FMemoLabel := nil;
end;

procedure TLabeledMemo.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledMemo.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if FMemoLabel = nil then
    Exit;

  FLabelPosition := Value;

  case Value of
    lpAbove:
      case AdjustedAlignment(UseRightToLeftAlignment, taLeftJustify) of
        taLeftJustify:  P := Point(Left, Top - FMemoLabel.Height - FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FMemoLabel.Width,
                                   Top - FMemoLabel.Height - FLabelSpacing);
        taCenter:       P := Point(Left + (Width - FMemoLabel.Width) div 2,
                                   Top - FMemoLabel.Height - FLabelSpacing);
      end;
    lpBelow:
      case AdjustedAlignment(UseRightToLeftAlignment, taLeftJustify) of
        taLeftJustify:  P := Point(Left, Top + Height + FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FMemoLabel.Width,
                                   Top + Height + FLabelSpacing);
        taCenter:       P := Point(Left + (Width - FMemoLabel.Width) div 2,
                                   Top + Height + FLabelSpacing);
      end;
    lpLeft : P := Point(Left - FMemoLabel.Width - FLabelSpacing,
                        Top + ((Height - FMemoLabel.Height) div 2));
    lpRight: P := Point(Left + Width + FLabelSpacing,
                        Top + ((Height - FMemoLabel.Height) div 2));
  end;
  FMemoLabel.SetBounds(P.x, P.y, FMemoLabel.Width, FMemoLabel.Height);
end;

procedure TLabeledMemo.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledMemo.SetName(const Value: TComponentName);
var
  LClearText: Boolean;
begin
  if (csDesigning in ComponentState) and (FMemoLabel <> nil) and
     ((FMemoLabel.GetTextLen = 0) or
     (CompareText(FMemoLabel.Caption, Name) = 0)) then
  begin
    FMemoLabel.Caption := Value;
  end;

  LClearText := (csDesigning in ComponentState) and (Text = '');

  inherited SetName(Value);

  if LClearText then
    Text := '';
end;

procedure TLabeledMemo.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);

  if FMemoLabel = nil then
    Exit;
  FMemoLabel.Parent := AParent;
  FMemoLabel.Visible := True;
end;

procedure TLabeledMemo.SetupInternalLabel;
begin
  if Assigned(FMemoLabel) then
    Exit;

  FMemoLabel := TBoundLabel.Create(Self);
  FMemoLabel.FreeNotification(Self);
  FMemoLabel.FocusControl := Self;
end;

{ TCalcEditTHZ }

procedure TLabeledCalcEdit.CMBidimodechanged(var Message: TMessage);
begin
  inherited;

  if FEditLabel <> nil then
    FEditLabel.BiDiMode := BiDiMode;
end;

procedure TLabeledCalcEdit.CMEnabledchanged(var Message: TMessage);
begin
  inherited;

  if FEditLabel <> nil then
    FEditLabel.Enabled := Enabled;
end;

procedure TLabeledCalcEdit.CMVisiblechanged(var Message: TMessage);
begin
  inherited;

  if FEditLabel <> nil then
    FEditLabel.Visible := Visible;
end;

constructor TLabeledCalcEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

procedure TLabeledCalcEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end;

procedure TLabeledCalcEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledCalcEdit.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if FEditLabel = nil then
    Exit;

  FLabelPosition := Value;

  case Value of
    lpAbove:
      case AdjustedAlignment(UseRightToLeftAlignment, taLeftJustify) of
        taLeftJustify:  P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FEditLabel.Width,
                                   Top - FEditLabel.Height - FLabelSpacing);
        taCenter:       P := Point(Left + (Width - FEditLabel.Width) div 2,
                                   Top - FEditLabel.Height - FLabelSpacing);
      end;
    lpBelow:
      case AdjustedAlignment(UseRightToLeftAlignment, taLeftJustify) of
        taLeftJustify:  P := Point(Left, Top + Height + FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FEditLabel.Width,
                                   Top + Height + FLabelSpacing);
        taCenter:       P := Point(Left + (Width - FEditLabel.Width) div 2,
                                   Top + Height + FLabelSpacing);
      end;
    lpLeft : P := Point(Left - FEditLabel.Width - FLabelSpacing,
                        Top + ((Height - FEditLabel.Height) div 2));
    lpRight: P := Point(Left + Width + FLabelSpacing,
                        Top + ((Height - FEditLabel.Height) div 2));
  end;
  FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, FEditLabel.Height);
end;

procedure TLabeledCalcEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledCalcEdit.SetName(const Value: TComponentName);
var
  LClearText: Boolean;
begin
  if (csDesigning in ComponentState) and (FEditLabel <> nil) and
     ((FEditLabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
  begin
    FEditLabel.Caption := Value;
  end;

  LClearText := (csDesigning in ComponentState) and (Text = '');

  inherited SetName(Value);

  if LClearText then
    Text := '';
end;

procedure TLabeledCalcEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);

  if FEditLabel = nil then
    Exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

procedure TLabeledCalcEdit.SetupInternalLabel;
begin
  if Assigned(FEditLabel) then
    Exit;

  FEditLabel := TBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;

end.
