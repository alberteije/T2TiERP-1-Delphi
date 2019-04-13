unit LabeledDBCtrls;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, DBCtrls, Types, Messages,
  Graphics, DB, JvDBControls, Variants, SqlExpr,
  DBXCommon, Windows;

type
  TDBBoundLabel = class(TCustomLabel)
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

  TDBLabelPosition = (lpAbove, lpBelow, lpLeft, lpRight);

  TLabeledDBEdit = class(TDBEdit)
  private
    OriginalColor: TColor;
    FEditLabel: TDBBoundLabel;
    FLabelPosition: TDBLabelPosition;
    FLabelSpacing: Integer;
    procedure SetLabelPosition(const Value: TDBLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);

    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit (var Message: TCMExit);  message CM_Exit;
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
    property DBEditLabel: TDBBoundLabel read FEditLabel;
    property LabelPosition: TDBLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
  end;

  TLabeledDBDateEdit = class(TJvDBDateEdit)
  private
    OriginalColor: TColor;
    FEditLabel: TDBBoundLabel;
    FLabelPosition: TDBLabelPosition;
    FLabelSpacing: Integer;
    procedure SetLabelPosition(const Value: TDBLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);

    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit (var Message: TCMExit);  message CM_Exit;
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
    property DBDateEditLabel: TDBBoundLabel read FEditLabel;
    property LabelPosition: TDBLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
  end;

  TLabeledDBLookupComboBox = class(TDBLookupComboBox)
  private
    OriginalColor: TColor;
    FEditLabel: TDBBoundLabel;
    FLabelPosition: TDBLabelPosition;
    FLabelSpacing: Integer;
    procedure SetLabelPosition(const Value: TDBLabelPosition);
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
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalLabel;
  published
    property DBLookupComboBoxLabel: TDBBoundLabel read FEditLabel;
    property LabelPosition: TDBLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('LabeledDBControls', [TLabeledDBEdit]);
  RegisterComponents('LabeledDBControls', [TLabeledDBDateEdit]);
  RegisterComponents('LabeledDBControls', [TLabeledDBLookupComboBox]);
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

{ TDBEditTHZ }

procedure TLabeledDBEdit.CMBidimodechanged(var Message: TMessage);
begin
  if FEditLabel <> nil then
    FEditLabel.BiDiMode := BiDiMode;
end;

procedure TLabeledDBEdit.CMEnabledchanged(var Message: TMessage);
begin
  if FEditLabel <> nil then
    FEditLabel.Enabled := Enabled;
end;

procedure TLabeledDBEdit.CMEnter(var Message: TCMEnter);
begin
  OriginalColor := Color;

  Color:= clSkyBlue;

  //Se for requerido muda cor do Edit
  if (DataSource <> nil) and (DataField <> '') then
  begin
    if DataSource.DataSet <> nil then
    begin
      if DataSource.DataSet.State in [dsEdit, dsInsert] then
      begin
        if DataSource.DataSet.FieldByName(DataField).Required then
        begin
          Color := clInfoBk;
        end;
      end;
    end;
  end;

  SelStart := 0;  // Coloca o cursor no início
  SelectAll; // Seleciona todo o texto
  inherited;
end;

procedure TLabeledDBEdit.CMExit(var Message: TCMExit);
begin
  Color := OriginalColor;
  inherited;
end;

procedure TLabeledDBEdit.CMVisiblechanged(var Message: TMessage);
begin
  if FEditLabel <> nil then
    FEditLabel.Visible := Visible;
end;

constructor TLabeledDBEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  CharCase := ecUpperCase;

  OriginalColor := Color;

  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

procedure TLabeledDBEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end;

procedure TLabeledDBEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledDBEdit.SetLabelPosition(const Value: TDBLabelPosition);
var
  P: TPoint;
begin
  if FEditLabel = nil then
    Exit;

  FLabelPosition := Value;

  case Value of
    lpAbove:
      case AdjustedAlignment(UseRightToLeftAlignment, Alignment) of
        taLeftJustify:  P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FEditLabel.Width,
                                   Top - FEditLabel.Height - FLabelSpacing);
        taCenter:       P := Point(Left + (Width - FEditLabel.Width) div 2,
                                   Top - FEditLabel.Height - FLabelSpacing);
      end;
    lpBelow:
      case AdjustedAlignment(UseRightToLeftAlignment, Alignment) of
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

procedure TLabeledDBEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledDBEdit.SetName(const Value: TComponentName);
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

procedure TLabeledDBEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);

  if FEditLabel = nil then
    Exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

procedure TLabeledDBEdit.SetupInternalLabel;
begin
  if Assigned(FEditLabel) then
    Exit;

  FEditLabel := TDBBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;

{ TDBBoundLabel }

procedure TDBBoundLabel.AdjustBounds;
begin
  inherited AdjustBounds;
  if Owner is TLabeledDBEdit then
    with Owner as TLabeledDBEdit do
      SetLabelPosition(LabelPosition);
end;

constructor TDBBoundLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name := 'SubLabel';  { do not localize }
  SetSubComponent(True);
  if Assigned(AOwner) then
    Caption := AOwner.Name;
end;

function TDBBoundLabel.GetHeight: Integer;
begin
  Result := inherited Height;
end;

function TDBBoundLabel.GetLeft: Integer;
begin
  Result := inherited Left;
end;

function TDBBoundLabel.GetTop: Integer;
begin
  Result := inherited Top;
end;

function TDBBoundLabel.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TDBBoundLabel.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure TDBBoundLabel.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;


{ TDBDateEditTHZ }

procedure TLabeledDBDateEdit.CMBidimodechanged(var Message: TMessage);
begin
  if FEditLabel <> nil then
    FEditLabel.BiDiMode := BiDiMode;
end;

procedure TLabeledDBDateEdit.CMEnabledchanged(var Message: TMessage);
begin
  if FEditLabel <> nil then
    FEditLabel.Enabled := Enabled;
end;

procedure TLabeledDBDateEdit.CMEnter(var Message: TCMEnter);
begin
  OriginalColor := Color;

  Color:= clSkyBlue;

  //Se for requerido muda cor do Edit
  if (DataSource <> nil) and (DataField <> '') then
  begin
    if DataSource.DataSet <> nil then
    begin
      if DataSource.DataSet.State in [dsEdit, dsInsert] then
      begin
        if DataSource.DataSet.FieldByName(DataField).Required then
        begin
          Color := clInfoBk;
        end;
      end;
    end;
  end;

  SelStart := 0;  // Coloca o cursor no início
  SelectAll; // Seleciona todo o texto
  inherited;
end;

procedure TLabeledDBDateEdit.CMExit(var Message: TCMExit);
begin
  Color := OriginalColor;
  inherited;
end;

procedure TLabeledDBDateEdit.CMVisiblechanged(var Message: TMessage);
begin
  if FEditLabel <> nil then
    FEditLabel.Visible := Visible;
end;

constructor TLabeledDBDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  OriginalColor := Color;

  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

procedure TLabeledDBDateEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end;

procedure TLabeledDBDateEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledDBDateEdit.SetLabelPosition(const Value: TDBLabelPosition);
var
  P: TPoint;
begin
  if FEditLabel = nil then
    Exit;

  FLabelPosition := Value;

  case Value of
    lpAbove:
      case AdjustedAlignment(UseRightToLeftAlignment, Alignment) of
        taLeftJustify:  P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
        taRightJustify: P := Point(Left + Width - FEditLabel.Width,
                                   Top - FEditLabel.Height - FLabelSpacing);
        taCenter:       P := Point(Left + (Width - FEditLabel.Width) div 2,
                                   Top - FEditLabel.Height - FLabelSpacing);
      end;
    lpBelow:
      case AdjustedAlignment(UseRightToLeftAlignment, Alignment) of
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

procedure TLabeledDBDateEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledDBDateEdit.SetName(const Value: TComponentName);
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

procedure TLabeledDBDateEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);

  if FEditLabel = nil then
    Exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

procedure TLabeledDBDateEdit.SetupInternalLabel;
begin
  if Assigned(FEditLabel) then
    Exit;

  FEditLabel := TDBBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;

{ TDBLookupComboBoxTHZ }

procedure TLabeledDBLookupComboBox.CMBidimodechanged(var Message: TMessage);
begin
  if FEditLabel <> nil then
    FEditLabel.BiDiMode := BiDiMode;
end;

procedure TLabeledDBLookupComboBox.CMEnabledchanged(var Message: TMessage);
begin
  if FEditLabel <> nil then
    FEditLabel.Enabled := Enabled;
end;

procedure TLabeledDBLookupComboBox.CMVisiblechanged(var Message: TMessage);
begin
  if FEditLabel <> nil then
    FEditLabel.Visible := Visible;
end;

constructor TLabeledDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  OriginalColor := Color;

  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

procedure TLabeledDBLookupComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TLabeledDBLookupComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end;

procedure TLabeledDBLookupComboBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledDBLookupComboBox.SetLabelPosition(const Value: TDBLabelPosition);
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

procedure TLabeledDBLookupComboBox.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TLabeledDBLookupComboBox.SetName(const Value: TComponentName);
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
    KeyValue := null;
end;

procedure TLabeledDBLookupComboBox.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);

  if FEditLabel = nil then
    Exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

procedure TLabeledDBLookupComboBox.SetupInternalLabel;
begin
  if Assigned(FEditLabel) then
    Exit;

  FEditLabel := TDBBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;

end.
