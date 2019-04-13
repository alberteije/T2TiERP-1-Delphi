{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpdbgridvcl                                     }
{                                                       }
{       Grid with decimal separator detection           }
{                                                       }
{       Copyright (c) 1994-2005 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpdbgridvcl;

interface

{$I rpconf.inc}

uses Windows,Messages,Classes,SysUtils,Grids,DBGrids,DbCtrls,StdCtrls,Controls,
{$IFDEF USEVARIANTS}
 Variants,Types,
{$ENDIF}
 DB,Graphics,Forms;

type
  TOnHelpEvent=procedure (Sender:TObject;textsource:string;var texthelp:string;var x,y:integer) of object;
  TOnChangeTextField=procedure (Sender:TObject;Editor:TInPlaceEdit)  of object;

  TRpGrid=class(TDBGrid)
   private
    FTabReturns:Boolean;
    FOnHelp:TOnHelpEvent;
    FOnchangeTExtField:TOnChangeTextField;
    procedure SuprimirData;
    procedure DoHelp(editr:TInPlaceEdit);
   protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState);override;
    procedure KeyPress(var Key: char);override;
    function CreateEditor: TInplaceEdit;override;
   public
    constructor Create(AOwner:TComponent);override;
   published
    property TabReturns:BOolean read FTabReturns write FTabReturns default true;
    property OnHelp:TOnHelpEvent read FonHelp write FOnHelp;
    property OnChangeTextField:TOnChangeTextField read FOnChangeTExtField write FOnChangeTextField;
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


type
  TEditStyle = (esSimple, esEllipsis, esPickList, esDataList);
  TPopupListbox = class(TCustomListbox)
  private
    FSearchText: String;
    FSearchTickCount: Longint;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;
  TRpGridInplaceEdit = class(TInplaceEdit)
   private
    FButtonWidth: Integer;
    FDataList: TDBLookupListBox;
    FPickList: TPopupListbox;
    FActiveList: TWinControl;
    FLookupSource: TDatasource;
    FEditStyle: TEditStyle;
    FListVisible: Boolean;
    FTracking: Boolean;
    FPressed: Boolean;
    StaticHelp:TStaticText;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetEditStyle(Value: TEditStyle);
    procedure StopTracking;
    procedure TrackButton(X,Y: Integer);
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    procedure WMCancelMode(var Message: TMessage); message WM_CancelMode;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message wm_LButtonDblClk;
    procedure WMPaint(var Message: TWMPaint); message wm_Paint;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
    procedure MaskEdit1Change(Sender: TObject);
    function ButtonRect: TRect;
   protected
    procedure BoundsChanged; override;
    procedure CloseUp(Accept: Boolean);
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState);
    procedure DropDown;
    procedure PaintWindow(DC: HDC); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure UpdateContents; override;
    procedure WndProc(var Message: TMessage); override;
    property  EditStyle: TEditStyle read FEditStyle write SetEditStyle;
    property  ActiveList: TWinControl read FActiveList write FActiveList;
    property  DataList: TDBLookupListBox read FDataList;
    property  PickList: TPopupListbox read FPickList;
  public
    procedure SetBounds(Aleft,ATop,AWidth,AHeight:integer);override;
    constructor Create(Owner: TComponent); override;
  end;

procedure TRpGrid.DoHelp(editr:TInPlaceEdit);
var
 x,y:integer;
 texte:string;
 editor:TRpGridInPlaceEdit;
begin
 editor:=TRpGridInPlaceEdit(editr);
 x:=editor.Left;
 y:=editor.Top+editor.Height;;
 texte:='';
 if assigned(FOnHelp) then
  FOnHelp(Self,editor.text,texte,x,y);
 if texte='' then
 begin
  editor.StaticHelp.Visible:=False;
  editor.StaticHelp.Caption:='';
 end
 else
 begin
  editor.StaticHelp.Left:=x;
  editor.StaticHelp.Top:=y;
  editor.Statichelp.visible:=True;
  editor.StaticHelp.Caption:=texte;
 end;
end;

procedure TRpGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
 camp:TField;
begin
 if Key=VK_DELETE then
  SuprimirData;
 // Mirem si la grid es una dbgrid
 camp:=SelectedField;
 if ((camp<>nil)and(camp.DataType in [ftfloat..ftBCD])) then
  if ((Key=VK_DECIMAL) AND (VK_DECIMAL<>Ord(DecimalSeparator))) then
  begin
           KillMessage(Handle, WM_CHAR);
   PostMessage(handle,WM_CHAR,ord(decimalseparator),0);
   Key:=0;
 end;
 inherited Keydown(key,shift);
end;

procedure TRpGrid.KeyUp(var Key: Word; Shift: TShiftState);
var
 camp:TField;
begin
 // Mirem si la grid es una dbgrid
 camp:=SelectedField;
 if ((camp<>nil) and (camp.DataType in [ftfloat..ftBCD])) then
  if ((Key=VK_DECIMAL) AND (VK_DECIMAL<>Ord(DecimalSeparator))) then
    Key:=0;
 inherited KeyUp(key,shift);
end;

procedure TRpGrid.KeyPress(var Key: char);
var
 camp:TField;
begin
 // Mirem si la grid es una dbgrid
 camp:=SelectedField;
 if camp.DataType in [ftfloat..ftBCD] then
  if ((Key=chr(VK_DECIMAL)) AND (VK_DECIMAL<>Ord(DecimalSeparator))) then
    Key:=chr(0);
 if Key<>chr(0) then
  inherited KeyPress(key);
end;

procedure TRpGrid.SuprimirData;
begin
 if SelectedField<>nil then
 begin
  if SelectedField.DataType in [ftTime..ftDateTime] then
  begin
   if Not (SelectedField.Dataset.state in dseditmodes) then
   begin
    if ((SelectedField.Dataset.EOF) AND (SelectedField.Dataset.BOF)) then
     Exit;
    SelectedField.DataSet.edit;
   end;
   SelectedField.AsVariant:=Null;
  end;
 end;
end;

procedure TRpGridInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
var
 camp:TField;
begin
 // Mirem si la grid es una dbgrid
 if Grid<>nil then
  if (Grid is TDBGRid) then
  begin
   camp:=(grid As TDBGrid).SelectedField;
   if camp.DataType in [ftfloat..ftBCD] then
    if ((Key=VK_DECIMAL) AND (VK_DECIMAL<>Ord(DecimalSeparator))) then
      Key:=0;
    if TRpGrid(Grid).FTabReturns then
    begin
     if (Key=VK_RETURN) then
     begin
      Key:=VK_TAB;
      inherited KeyUp(Key, Shift);
     end
    end;
  end;
 inherited KeyUp(key,shift);
end;

procedure TRpGridInplaceEdit.Keypress(var Key: char);
var
 camp:TField;
begin
 // Mirem si la grid es una dbgrid
 if Grid<>nil then
  if (Grid is TDBGRid) then
  begin
   camp:=(grid As TDBGrid).SelectedField;
   if camp.DataType in [ftfloat..ftBCD] then
    if ((Key=chr(VK_DECIMAL)) AND (VK_DECIMAL<>Ord(DecimalSeparator))) then
      Key:=chr(0);
  end;
 if key<>chr(0) then
  inherited KeyPress(key);
end;



procedure TRpGridInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
 data:tdataset;
 camp:tfield;
begin
 // Mirem si la grid es una dbgrid
 if Grid<>nil then
  if (Grid is TDBGRid) then
  begin
   camp:=(grid As TDBGrid).SelectedField;
   if camp.DataType in [ftfloat..ftBCD] then
    if ((Key=VK_DECIMAL) AND (VK_DECIMAL<>Ord(DecimalSeparator))) then
    begin
     KillMessage(Handle, WM_CHAR);
     PostMessage(handle,WM_CHAR,ord(decimalseparator),0);
     Key:=0;
    end;
  end;
  // Tractament dates nules en grid
  if Key=VK_DELETE then
   TRpGrid(Grid).SuprimirData;
  if TRpGrid(Grid).FTabReturns then
  begin
   if Key=VK_RETURN then
   begin
    Key:=VK_TAB;
    inherited KeyDown(Key, Shift);
   end
   else
   begin
    if ((Key=VK_DELETE) and (ssCtrl in shift)) then
    begin
     if assigned(TRpGrid(Grid).datasource) then
      if assigned(TRpGrid(Grid).datasource.dataset) then
      begin
       data:=TRpGrid(Grid).datasource.dataset;
       if (Not (data.eof and data.bof)) then
        data.delete;
      end;
    end
    else
     inherited KeyDown(Key, Shift);
   end;
  end
  else
  inherited KeyDown(Key, Shift);
end;

constructor TRpGrid.Create(AOwner:TComponent);
begin
 inherited Create(AOWner);
 FTabReturns:=true;
end;

function TRpGrid.CreateEditor: TInplaceEdit;
begin
 Result := TRpGridInplaceEdit.Create(Self);
end;

function TRpGridInplaceEdit.ButtonRect: TRect;
begin
  if not TCustomDBGrid(Owner).UseRightToLeftAlignment then
    Result := Rect(Width - FButtonWidth, 0, Width, Height)
  else
    Result := Rect(0, 0, FButtonWidth, Height);
end;


procedure TRpGridInplaceEdit.PaintWindow(DC: HDC);
var
  R: TRect;
  Flags: Integer;
  W, X, Y: Integer;
begin
  if FEditStyle <> esSimple then
  begin
    R := ButtonRect;
    Flags := 0;
    if FEditStyle in [esDataList, esPickList] then
    begin
      if FActiveList = nil then
        Flags := DFCS_INACTIVE
      else if FPressed then
        Flags := DFCS_FLAT or DFCS_PUSHED;
      DrawFrameControl(DC, R, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
    end
    else   { esEllipsis }
    begin
      if FPressed then Flags := BF_FLAT;
      DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
      X := R.Left + ((R.Right - R.Left) shr 1) - 1 + Ord(FPressed);
      Y := R.Top + ((R.Bottom - R.Top) shr 1) - 1 + Ord(FPressed);
      W := FButtonWidth shr 3;
      if W = 0 then W := 1;
      PatBlt(DC, X, Y, W, W, BLACKNESS);
      PatBlt(DC, X - (W * 2), Y, W, W, BLACKNESS);
      PatBlt(DC, X + (W * 2), Y, W, W, BLACKNESS);
    end;
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end;

procedure TRpGridInplaceEdit.SetBounds(Aleft,ATop,AWidth,AHeight:integer);
begin
 inherited setbounds(Aleft,atop,awidth,aheight);
 if assigned(grid) then
  (Grid As TRpGrid).DoHelp(self);
end;

procedure TRpGridInplaceEdit.BoundsChanged;
var
  R: TRect;
begin
 SetRect(R, 2, 2, Width - 2, Height);
 if FEditStyle <> esSimple then Dec(R.Right, FButtonWidth);
 SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
 SendMessage(Handle, EM_SCROLLCARET, 0, 0);
 if SysLocale.FarEast then
   SetImeCompositionWindow(Font, R.Left, R.Top);

 if assigned(grid) then
  (Grid As TRpGrid).DoHelp(self);
end;

procedure TRpGridInplaceEdit.WMKillFocus(var Message: TMessage);
begin
  if not SysLocale.FarEast then inherited
  else
  begin
    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
    inherited;
    if LongInt(Message.WParam) <> LongInt(TCustomDBGrid(Grid).Handle) then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
  end;
  CloseUp(False);
 StaticHelp.Visible:=False;
end;


procedure TPopupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TPopupListbox.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, wm_SetFocus, 0, 0);
end;

procedure TPopupListbox.Keypress(var Key: Char);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27: FSearchText := '';
    #32..#255:
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTickCount > 2000 then FSearchText := '';
        FSearchTickCount := TickCount;
        if Length(FSearchText) < 32 then FSearchText := FSearchText + Key;
        SendMessage(Handle, LB_SelectString, WORD(-1), Longint(PChar(FSearchText)));
        Key := #0;
      end;
  end;
  inherited Keypress(Key);
end;

procedure TPopupListbox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  TRpGridInPlaceEdit(Owner).CloseUp((X >= 0) and (Y >= 0) and
      (X < Width) and (Y < Height));
end;

procedure TRpGridInplaceEdit.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FActiveList.ClientRect, Point(X, Y)));
end;

procedure TRpGridInplaceEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (FEditStyle <> esSimple) and
    PtInRect(Rect(Width - FButtonWidth, 0, Width, Height), Point(X,Y)) then
  begin
    if FListVisible then
      CloseUp(False)
    else
    begin
      MouseCapture := True;
      FTracking := True;
      TrackButton(X, Y);
      if Assigned(FActiveList) then
        DropDown;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;


procedure TRpGridInplaceEdit.SetEditStyle(Value: TEditStyle);
begin
  if Value = FEditStyle then Exit;
  FEditStyle := Value;
  case Value of
    esPickList:
      begin
        if FPickList = nil then
        begin
          FPickList := TPopupListbox.Create(Self);
          FPickList.Visible := False;
          FPickList.Parent := Self;
          FPickList.OnMouseUp := ListMouseUp;
          FPickList.IntegralHeight := True;
          FPickList.ItemHeight := 11;
        end;
        FActiveList := FPickList;
      end;
    esDataList:
      begin
        if FDataList = nil then
        begin
          FDataList := TPopupDataList.Create(Self);
          FDataList.Visible := False;
          FDataList.Parent := Self;
          FDataList.OnMouseUp := ListMouseUp;
        end;
        FActiveList := FDataList;
      end;
  else  { cbsNone, cbsEllipsis, or read only field }
    FActiveList := nil;
  end;
  with TRpGrid(Grid) do
    Self.ReadOnly := Columns[SelectedIndex].ReadOnly;
  Repaint;
end;

procedure TRpGridInplaceEdit.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TRpGridInplaceEdit.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := ButtonRect;
  NewState := PtInRect(R, Point(X, Y));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TRpGridInplaceEdit.UpdateContents;
var
  Column: TColumn;
  NewStyle: TEditStyle;
  MasterField: TField;
  nomcamp: String;
  i: integer;
  continuar: boolean;
begin
  with TRpGrid(Grid) do
    Column := Columns[SelectedIndex];
  NewStyle := esSimple;
  case Column.ButtonStyle of
   cbsEllipsis: NewStyle := esEllipsis;
   cbsAuto:
     if Assigned(Column.Field) then
     with Column.Field do
     begin
       { Show the dropdown button only if the field is editable }
       if FieldKind = fkLookup then
       begin
         continuar:=True;
         i:=1;
         while i<=Length(keyfields) do
         begin
              nomcamp:='';
              while (keyfields[i]<>';') do
              begin
                    nomcamp:=nomcamp+keyfields[i];
                    Inc(i);
                    if i>Length(keyfields) then
                     break;
              end;
              MasterField := Dataset.FieldByName(nomcamp);
              if not(Assigned(MasterField) and MasterField.CanModify) then
                 continuar:=false;
              Inc(i);
         end;
         { Column.DefaultReadonly will always be True for a lookup field.
           Test if Column.ReadOnly has been assigned a value of True }
         if continuar and
           not ((cvReadOnly in Column.AssignedValues) and Column.ReadOnly) then
           with TRpGrid(Grid) do
             if not ReadOnly and DataLink.Active and not Datalink.ReadOnly then
               NewStyle := esDataList
       end
       else
       begin
        if Assigned(Column.Picklist) and (Column.PickList.Count > 0) and
          not Column.Readonly then
        begin
          NewStyle := esPickList;
        end
        else
        begin
{         if assigned(Column.Field) then
          if Column.Field.isnull then
//           Pos('!',Column.Field.Editmask)=1 then
           SelStart:=0;
}        end;
       end;
     end;
  end;
  EditStyle := NewStyle;
  inherited UpdateContents;
end;

procedure TRpGridInplaceEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FActiveList) then
    CloseUp(False);
end;

procedure TRpGridInplaceEdit.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;


procedure TRpGridInplaceEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  with Message do
  if (FEditStyle <> esSimple) and
    PtInRect(Rect(Width - FButtonWidth, 0, Width, Height), Point(XPos, YPos)) then
    Exit;
  inherited;
end;

procedure TRpGridInplaceEdit.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TRpGridInplaceEdit.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      if EditStyle in [esPickList, esDataList] then
      with TWMKey(Message) do
      begin
        DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
        if (CharCode <> 0) and FListVisible then
        begin
          with TMessage(Message) do
            SendMessage(FActiveList.Handle, Msg, WParam, LParam);
          Exit;
        end;
      end
  end;
  inherited;
end;

procedure TRpGridInplaceEdit.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  if (FEditStyle <> esSimple) and
    PtInRect(Rect(Width - FButtonWidth, 0, Width, Height), ScreenToClient(P)) then
    Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else
    inherited;
end;

procedure TRpGridInplaceEdit.MaskEdit1Change(Sender: TObject);
begin
 if Assigned((Grid As TRpGrid).FOnChangeTextField) then
  (Grid As TRpGrid).FOnChangeTextField(Grid,Self);
 StaticHelp.Visible:=False;
end;


procedure TRpGridInplaceEdit.CloseUp(Accept: Boolean);
var
  MasterField: TField;
  ListValue: Variant;
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if FActiveList = FDataList then
      ListValue := FDataList.KeyValue
    else
      if FPickList.ItemIndex <> -1 then
        ListValue := FPickList.Items[FPicklist.ItemIndex];
    SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    if Assigned(FDataList) then
      FDataList.ListSource := nil;
    FLookupSource.Dataset := nil;
    Invalidate;
    if Accept then
      if FActiveList = FDataList then
        with TRpGrid(Grid), Columns[SelectedIndex].Field do
        begin
          MasterField := DataSet.FieldByName(KeyFields);
          if MasterField.CanModify then
          begin
            DataSet.Edit;
            MasterField.Value := ListValue;
          end;
        end
      else
        if (not VarIsNull(ListValue)) and EditCanModify then
          with TRpGrid(Grid), Columns[SelectedIndex].Field do
            Text := ListValue;
  end;
end;

procedure TRpGridInplaceEdit.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if FListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if FListVisible and not (ssAlt in Shift) then
      begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
      end;
  end;
end;

procedure TRpGridInplaceEdit.DropDown;
var
  P: TPoint;
  I,J,Y: Integer;
  Column: TColumn;
begin
  if not FListVisible and Assigned(FActiveList) then
  begin
    FActiveList.Width := Width;
    with TRpGrid(Grid) do
      Column := Columns[SelectedIndex];
    if FActiveList = FDataList then
    with Column.Field do
    begin
      FDataList.Color := Color;
      FDataList.Font := Font;
      FDataList.RowCount := Column.DropDownRows;
      FLookupSource.DataSet := LookupDataSet;
      FDataList.KeyField := LookupKeyFields;
      FDataList.ListField := LookupResultField;
      FDataList.ListSource := FLookupSource;
      FDataList.KeyValue := DataSet.FieldByName(KeyFields).Value;
{      J := Column.DefaultWidth;
      if J > FDataList.ClientWidth then
        FDataList.ClientWidth := J;
}    end
    else
    begin
      FPickList.Color := Color;
      FPickList.Font := Font;
      FPickList.Items := Column.Picklist;
      if LongInt(FPickList.Items.Count) >= LongInt(Column.DropDownRows) then
        FPickList.Height := LongInt(Column.DropDownRows) * LongInt(FPickList.ItemHeight) + 4
      else
        FPickList.Height := FPickList.Items.Count * FPickList.ItemHeight + 4;
      if Column.Field.IsNull then
        FPickList.ItemIndex := -1
      else
        FPickList.ItemIndex := FPickList.Items.IndexOf(Column.Field.Value);
      J := FPickList.ClientWidth;
      for I := 0 to FPickList.Items.Count - 1 do
      begin
        Y := FPickList.Canvas.TextWidth(FPickList.Items[I]);
        if Y > J then J := Y;
      end;
      FPickList.ClientWidth := J;
    end;
    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + FActiveList.Height > Screen.Height then Y := P.Y - FActiveList.Height;
    SetWindowPos(FActiveList.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FListVisible := True;
    Invalidate;
    Windows.SetFocus(Handle);
  end;
end;

procedure TRpGridInplaceEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if FListVisible then
    begin
      ListPos := FActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(FActiveList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(FActiveList.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TRpGridInplaceEdit.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := FPressed;
  StopTracking;
  if (Button = mbLeft) and (FEditStyle = esEllipsis) and WasPressed then
    TRpGrid(Grid).EditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

constructor TRpGridInplaceEdit.Create(Owner:TComponent);
begin
 inherited create(Owner);

 OnChange:=MaskEdit1Change;
 StaticHelp:=TStaticText.Create(Self);
 StaticHelp.AutoSize:=True;
 Statichelp.Caption:='';
 StaticHelp.Visible:=False;
 STaticHelp.Parent:=Owner As TDBGrid;
 STaticHelp.Color:=ClInfoBK;
 STaticHelp.Font.Color:=ClInfoText;
  FLookupSource := TDataSource.Create(Self);
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FEditStyle := esSimple;
end;



end.
