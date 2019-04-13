unit Enter;

interface

uses
  Messages, WinTypes, WinProcs, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, stdCtrls, DBGRIDS;

{$R Enter.res}

type

  TMREnter = class(TComponent)
  private
    { Private declarations }
    FAutor            : string;

    FEnterEnabled     : Boolean;

    FFocusColor       : TColor;
    FFocusEnabled     : Boolean;

    FHintEnabled      : Boolean;
    FHintColor        : TColor;

    FAutoSkip         : Boolean;
    FKeyBoardArrows   : Boolean;
    FOnMessage        : TMessageEvent;
    FOnMessageRescue  : TMessageEvent;

    FOnIdle           : TIdleEvent;
    FOnIdleRescue     : TIdleEvent;

    FOnHint           : TNotifyEvent;
    FOnHintRescue     : TNotifyEvent;

    FOnHelp           : THelpEvent;
    FOnHelpRescue     : THelpEvent;

    FClassList        : TStringList;
    procedure SetClassList( AClassList: TStringList );
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoShowHint( Control: TWinControl );
    procedure LocalOnMessage(var Msg: TMsg; var Handled: Boolean);
    procedure LocalOnIdle(Sender: TObject; var Done: Boolean);
    procedure LocalOnHint(Sender: TObject);
    function  LocalOnHelp(Command: word; Data: Longint; var CallHelp: Boolean):Boolean;

    function CheckClassList( AClassName: string ): Boolean;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;
  published
    { Published declarations }
    property Autor : string           read FAutor          write FAutor stored False;
    property AutoSkip: Boolean        read FAutoSkip        write FAutoSkip;
    property EnterEnabled: Boolean    read FEnterEnabled    write FEnterEnabled;
    property ClassList: TStringList   read FClassList       write SetClassList;
    property KeyBoardArrows : Boolean read FKeyBoardArrows  write FKeyBoardArrows;
    property FocusColor : TColor      read FFocusColor      write FFocusColor;
    property FocusEnabled : Boolean   read FFocusEnabled    write FFocusEnabled;
    property HintColor : TColor       read FHintColor       write FHintColor;
    property HintEnabled : Boolean    read FHintEnabled     write FHintEnabled;

    property OnMessage: TMessageEvent read FOnMessage       write FOnMessage;
    property OnIdle:    TIdleEvent    read FOnIdle          write FOnIdle;
    property OnHint:    TNotifyEvent  read FOnHint          write FOnHint;
    property OnHelp:    THelpEvent    read FOnHelp          write FOnHelp;
  end;

implementation

uses
  ShellAPI,
  dbctrls,
  TypInfo,
  enterreg,
  Grids;

Var
  FHintWindow       : THintWindow;
  FFocusControl     : TWinControl;
  FActiveControl    : TWinControl;
  FFocusColorReturn : TColor;

{ GetHintWindow}

function HintWindow: THintWindow;
begin

  if FHintWindow = nil then
  begin
    FHintWindow := THintWindow.Create(Application);
    FHintWindow.Visible := False;
  end;

  Result := FHintWindow;

end;

{ Create }
constructor TMREnter.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  FAutor          := 'martins@mrsoftware.com.br';
  FAutoSkip       := true;
  FFocusEnabled   := true;
  FKeyBoardArrows := true;
  FClassList      := TStringList.create;
  FEnterEnabled   := true;
  FFocusColor     := clYellow;
  FHintColor      := Application.HintColor;
  FHintEnabled    := True;
  with FClassList do
  begin
    Add('TMaskEdit');
    Add('TEdit');
    Add('TDBEdit');
    Add('TDBCheckBox');
    Add('TTabbedNoteBook');
    Add('TStringGrid');            { Suporte ao tratamento de Grids       }
    Add('TDrawGrid');
    Add('TDBGrid');

    Add('TDBCheckDocEdit');  { Componente p/ edição de CGC do Roger       }
    Add('TMRDBExtEdit');     { Edit com busca incremental MR              }
    Add('TDBDateEdit');      { Componente p/ edição de datas do Sebastião }

    Add('TwwDBGrid');              { Suporte aos componentes do InfoPower }
    Add('TwwDBEdit');              { Já que tem um monte de gente que usa }
    Add('TwwDBComboBox');          { achei por bem deixar todos disponí-  }
    Add('TwwDBSpinEdit');          { veis durante a criação do componen-  }
    Add('TwwDBComboDlg');          { te, assim como os outros ....        }
    Add('TwwDBLookupCombo');       {                                      }
    Add('TwwDBLookupComboDlg');    { ideia do Dennis ...                  }
    Add('TwwIncrementalSearch');   { valeu ...                            }
    Add('TwwDBRitchEdit');         { 02/03/1999                           }
    Add('TwwKeyCombo');            {                                      }

    Add('TRxDBLookupList');        { Suporte aos componentes do RxLib     }
    Add('TRxDBGrid');              {                                      }
    Add('TRxDBLookupCombo');       { Paulo H. Trentin                     }
    Add('TRxDBCalcEdit');          { www.rantac.com.br/users/phtrentin    }
    Add('TRxDBComboBox');
    Add('TRxDBComboEdit');
    Add('TDBDateEdit');
    Add('TRxCalcEdit');
    Add('TCurrencyEdit');
    Add('TRxLookupEdit');

  end;

  if not( csDesigning in ComponentState ) then
  begin
    FOnMessageRescue      := Application.OnMessage;
    Application.OnMessage := LocalOnMessage;

    FOnIdleRescue         := Application.OnIdle;
    Application.OnIdle    := LocalOnIdle;

    FOnHintRescue         := Application.OnHint;
    Application.OnHint    := LocalOnHint;

    FOnHelpRescue         := Application.OnHelp;
    Application.OnHelp    := LocalOnHelp;

  end;

end;

{ Destroy }
destructor TMREnter.Destroy;
begin
  FClassList.free;

  if Assigned( FOnMessageRescue ) then
    Application.OnMessage := FOnMessageRescue;

  if Assigned( FOnIdleRescue ) then
    Application.OnIdle := FOnIdleRescue;

  if Assigned( FOnHintRescue ) then
    Application.OnHint := FOnHintRescue;

  if Assigned( FOnHelpRescue ) then
    Application.OnHelp := FOnHelpRescue;

  inherited Destroy;
end;

procedure TMREnter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and
     (AComponent = FFocusControl) then
    FFocusControl := nil;
  inherited Notification(AComponent, Operation);
end;

procedure TMREnter.SetClassList( AClassList: TStringList );
begin
  FClassList.Assign( AClassList );
end;

procedure TMREnter.LocalOnMessage(var Msg: TMsg; var Handled: Boolean);
var
  pMaxLengthPropInfo,
  pColorPropInfo,
  pOnKeyDownPropInfo,
  pColPropInfo,
  pColCountPropInfo : PPropInfo;
  intMaxLength,
  intSelStart,
  intCol,
  intColCount       : integer;
begin

  if ( FFocusEnabled ) then
  begin
    if ( FActiveControl <> Screen.ActiveControl ) then
    begin

      //
      // if the control was out then turn off the hint window
      //
      if ( FHintWindow <> nil ) then
      begin
        FHintWindow.ReleaseHandle;
        FHintWindow := nil;
      end;

      //
      // Changed = ActiveControl
      //
      if FActiveControl <> Screen.ActiveControl then
      begin
        FActiveControl := Screen.ActiveControl;
        DoShowHint(FActiveControl);
      end;

      //
      // if focus control <> nil then the control was changed
      //
      if ( FFocusControl <> nil ) then
      begin
        //
        // Antes de setar de volta a cor, verifico se o component nao esta
        // sendo destruido
        //
        if not( csDestroying in FFocusControl.ComponentState ) then
        begin
          pColorPropInfo := GetPropInfo( FFocusControl.ClassInfo, 'Color' );
          if ( pColorPropInfo <> nil ) then
            SetOrdProp( FFocusControl, 'Color', FFocusColorReturn );
        end;
        FFocusControl := nil;
      end;

      //
      // The new control is geting
      //

      if CheckClassList( Screen.ActiveControl.ClassName ) then
        FFocusControl := Screen.ActiveControl else FFocusControl := nil;

      //
      // Set the Focus Color to new control
      //
      if ( FFocusControl <> nil ) then
      begin
        pColorPropInfo := GetPropInfo( FFocusControl.ClassInfo, 'Color' );
        if ( pColorPropInfo <> nil ) then
        begin
          FFocusColorReturn := GetOrdProp( FFocusControl, pColorPropInfo );
          SetOrdProp( FFocusControl, 'Color', FFocusColor );
        end;
      end;

    end;
  end;

  if FEnterEnabled then
  if Screen <> nil then
  if Screen.ActiveControl <> nil then
  if (( Msg.message = WM_KeyDown ))and
     CheckClassList( Screen.ActiveControl.ClassName ) then
  begin
    case Msg.wParam of
      VK_Return:  if ( Screen.ActiveControl is TCustomGrid ) then
                  begin
                    if ( Screen.ActiveControl is TDBGrid ) then Msg.wParam := VK_TAB
                    else Msg.wParam := VK_Right;
                  end
                  else
                  begin
                    pOnKeyDownPropInfo := GetPropInfo( Screen.ActiveControl.ClassInfo, 'OnKeyDown' );
                    if ( Screen.ActiveControl is TCustomComboBox ) then
                    begin
                      if not ( Screen.ActiveControl as TCustomComboBox ).DroppedDown then Msg.wParam := VK_TAB;
                    end
                    else
                      if ( pOnKeyDownPropInfo <> nil ) then
                        if ( GetOrdProp( Screen.ActiveControl, pOnKeyDownPropInfo ) = 0 ) then Msg.wParam := VK_TAB;
                  end;
      VK_Down  :  if (FKeyBoardArrows) and
                     not( Screen.ActiveControl is TCustomGrid ) and
                     not( Screen.ActiveControl is TCustomComboBox ) then
                    Msg.wParam := VK_TAB;
      VK_Up    :  if (FKeyBoardArrows) and
                     not( Screen.ActiveControl is TCustomGrid )  and
                     not( Screen.ActiveControl is TCustomComboBox ) then
                  begin
                    Msg.wParam := VK_CLEAR;
                    keybd_event(VK_SHIFT,0,0,0);
                    keybd_event(VK_TAB,0,0,0);
                    Keybd_event(VK_SHIFT,0,Keyeventf_keyup,0);
                  end;
      VK_Back  :  ;
    else

//
// Mais um codigo em quarentena
//
//      if ( Screen.ActiveControl is TCustomEdit ) and
      if CheckClassList( Screen.ActiveControl.ClassName ) and
         ( FAutoSkip ) then
      begin
        { Verifica a propriedade MaxLength }
        pMaxLengthPropInfo := GetPropInfo( Screen.ActiveControl.ClassInfo, 'MaxLength' );

        { Verifica a propriedade SelStart }
        { furada, GetPropInfo só trabalha com Published }
        { pSelStartPropInfo := GetPropInfo( Screen.ActiveControl.ClassInfo, 'SelStart' ); }

        if ( pMaxLengthPropInfo <> nil ) then
        begin

          { Pega os valores das propriedades }
          intMaxLength := GetOrdProp( Screen.ActiveControl, pMaxLengthPropInfo );

          //
          // Ainda preciso deixar esse codigo mais bonito :(((
          //
          if ( Screen.ActiveControl is TCustomComboBox ) then
            intSelStart  := ( Screen.ActiveControl as TCustomCombobox ).SelStart;

          if ( Screen.ActiveControl is TCustomEdit ) then
            intSelStart  := ( Screen.ActiveControl as TCustomEdit).SelStart;
          // =============================================

          if ( intMaxLength <> 0 ) and
             ( intMaxLength = ( intSelStart + 1 ) ) then
            keybd_event(13,0,0,0);
        end;
      end;
    end;
  end;

  if Assigned( FOnMessageRescue ) then FOnMessageRescue( Msg, Handled );
  if Assigned( FOnMessage ) then FOnMessage( Msg, Handled );
end;

procedure TMREnter.LocalOnIdle(Sender: TObject; var Done: Boolean);
begin
  if not (csDestroying in Application.ComponentState) then
  begin
    if Assigned( FOnIdleRescue ) then FOnIdleRescue( Sender, Done );
    if Assigned( FOnIdle ) then FOnIdle( Sender, Done );
  end;
end;

procedure TMREnter.LocalOnHint(Sender: TObject);
begin
  if not (csDestroying in Application.ComponentState) then
  begin
    if Assigned( FOnHintRescue ) then FOnHintRescue( Sender );
    if Assigned( FOnHint ) then FOnHint( Sender );
  end;
end;

function  TMREnter.LocalOnHelp(Command: word; Data: Longint; var CallHelp: Boolean):Boolean;
begin
  result := true;
  if not (csDestroying in Application.ComponentState) then
  begin
    if Assigned( FOnHelpRescue ) then result:= FOnHelpRescue( Command, Data, CallHelp );
    if Assigned( FOnHelp ) then result:= FOnHelp( Command, Data, CallHelp );
  end;
end;

function TMREnter.CheckClassList( AClassName: string ): Boolean;
var
  intX : integer;
begin
  result := false;
  for intX := 0 to FClassList.Count-1 do
  begin
    result := AnsiCompareText( AClassName, FClassList.strings[intX] ) = 0;
    if result then
      break;
  end;
end;

procedure TMREnter.DoShowHint( Control : TWinControl );
var
  lPoint : TPoint;
  lHintRect: TRect;
  lHintWindow: THintWindow;

begin

  if (Control.Hint = '') or
     not( HintEnabled ) then Exit;

  lHintWindow := HintWindow;
  lHintWindow.Color := FHintColor;

  { display hint below bottom left corner of speed button }
  lPoint.X := 0;
  lPoint.Y := Control.Height;

  { convert to scree corrdinates }
  lPoint := Control.ClientToScreen(lPoint);

  { set hint window size & position }
  lHintRect.Left   := lPoint.X;
  lHintRect.Top    := lPoint.Y ;
  lHintRect.Right  := lHintRect.Left +  lHintWindow.Canvas.TextWidth(Control.Hint)  + 6;
  lHintRect.Bottom := lHintRect.Top  +  lHintWindow.Canvas.TextHeight(Control.Hint) + 2;

  lHintWindow.Visible := True;
  lHintWindow.ActivateHint(lHintRect, Control.Hint);

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  FHintWindow := nil;

finalization

  FHintWindow := nil;

end.





