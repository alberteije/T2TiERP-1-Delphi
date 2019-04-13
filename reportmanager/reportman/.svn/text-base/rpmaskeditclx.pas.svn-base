{*******************************************************}
{                                                       }
{       RpMaskEditCLX component                            }
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

unit rpmaskeditclx;

interface

{$I rpconf.inc}

uses
  SysUtils, Classes, Qt,QGraphics, QControls, QForms, QDialogs,
  Variants,Types,
  QStdCtrls, QMask;

type
  TRpEditType=(tegeneral,teinteger,tefloat,tecurrency,teDate,teTime,teDateTime);

  TTValidChars=set of Char;

  TRpCLXMaskEdit = class(TCustomMaskEdit)
  private
    { Private declarations }
    FValidChars:TTValidChars;
    FFocused:Boolean;
    FCanvas: TControlCanvas;
    FEditType:TRpEditType;
    FIntroExit:Boolean;
    FDisplayMask:string;
    oldtext:string;
    FDoValidate:boolean;
    procedure SetEditType(NewValue:TRpEditType);
    procedure SetFocused(Value: Boolean);
  protected
    procedure DoEnter;override;
    procedure DoExit;override;
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure KeyUp(var Key: Word; Shift: TShiftState);override;
    procedure KeyPress(var Key: char);override;
    procedure CheckValidData;
    function GetDisplayText:string;
    function GetInteger:integer;
    function GetFloat:double;
    function GetCurr:Currency;
    function GetDate:TDateTime;
    function GetDateTime:TDateTime;
    function GetTime:TDateTime;
    function GetValue:variant;
    procedure SetValue(NewValue:variant);
  protected
    { Protected declarations }
   procedure Change;override;
  public
    { Public declarations }
    destructor Destroy;override;
    constructor Create(AOwner:TComponent);override;
    function IsValidChar(key:char):Boolean;
    property ValidChars:TTValidchars read FValidchars write FValidChars;
    property AsInteger:integer read GetInteger;
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
    property DragMode;
    property Enabled;
    property Font;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
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


constructor TRpCLXMaskEdit.create(AOwner:TComponent);
begin
 inherited Create(AOwner);

  ControlStyle := ControlStyle + [csReplicatable];
  FEditType:=tegeneral;
  FValidchars:=[#0..#255];
  FDisplayMask:='';
  FIntroExit:=True;
end;

destructor TRpCLXMaskEdit.Destroy;
begin
  FCanvas.Free;
  inherited Destroy;
end;

procedure TRpCLXMaskEdit.DoEnter;
begin
 oldtext:=text;
// SetFocused(True);
 inherited;
end;

procedure TRpCLXMaskEdit.DoExit;
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
  inherited DoExit;
end;



procedure TRpCLXMaskEdit.SetEditType(NewValue:TRpEditType);
begin
 FEditType:=NewValue;
 case FEditType of
  tegeneral:
   begin
    FValidchars:=[#0..#255];
    Alignment:=taLeftJustify;
   end;
  teinteger:
   begin
    FValidchars:=['+','-','0'..'9'];
    Alignment:=taRightJustify;
   end;
  tedatetime:
   begin
    FValidchars:=[DateSeparator,Timeseparator,'0'..'9'];
    Alignment:=taLeftJustify;
   end;
  tedate:
   begin
    FValidchars:=[DateSeparator,'0'..'9'];
    Alignment:=taLeftJustify;
   end;
  tetime:
   begin
    FValidchars:=[Timeseparator,'0'..'9'];
    Alignment:=taRightJustify;
   end;
  tefloat:
   begin
    FValidchars:=[DecimalSeparator,'+','-','0'..'9','E','e'];
    Alignment:=taRightJustify;
   end;
  teCurrency:
   begin
    FValidchars:=[DecimalSeparator,'+','-','0'..'9'];
    Alignment:=taRightJustify;
   end;
 end;
end;

procedure TRpCLXMaskEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (Alignment <> taLeftJustify) and not IsMasked then Invalidate;
  end;
end;

procedure TRpCLXMaskEdit.KeyPress(var Key: Char);
var
 curcontrol:TWincontrol;
begin
 if EditType in [teinteger,tefloat,tecurrency] then
 begin
  if (  ((Key=chr(44)) AND  (chr(44)<>DecimalSeparator))
   or ((Key=chr(46)) AND  (chr(46)<>DecimalSeparator)) ) then
  begin
   Key:=decimalseparator;
  end;
 end;
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
    Beep;
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
         curcontrol:=TRpCLXMaskEdit(parent).FIndNextCOntrol(Self,true,true,false);
         if curcontrol<>nil then
          curcontrol.setfocus;
        end;
      end;
  end;
end;

procedure TRpCLXMaskEdit.CheckValidData;
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

function TRpCLXMaskEdit.IsValidChar(key:char):Boolean;
begin
 result:=key in ValidChars;
end;

function TRpCLXMaskEdit.GetDisplayText:string;
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


procedure TRpCLXMaskEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
 if EditType in [teinteger,tefloat,tecurrency] then
 begin
  if (  ((Key=KEY_COMMA) AND  (KEY_COMMA<>Ord(DecimalSeparator)))
   or ((Key=KEY_PERIOD) AND  (KEY_PERIOD<>Ord(DecimalSeparator))) ) then
  begin
   Key:=ord(decimalseparator);
  end;
 end;
 if (Not FDoValidate) then
  if (Key=KEY_RETURN) then
   begin
    if IntroExit then
    begin
     Key:=KEY_TAB;
    end;
   end;
 inherited KeyDown(Key,Shift);
end;

procedure TRpCLXMaskEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
 if EditType in [teinteger,tefloat,tecurrency] then
 begin
  if (  ((Key=KEY_COMMA) AND  (KEY_COMMA<>Ord(DecimalSeparator)))
   or ((Key=KEY_PERIOD) AND  (KEY_PERIOD<>Ord(DecimalSeparator))) ) then
  begin
   Key:=ord(decimalseparator);
  end;
 end;
 inherited KeyUp(Key,Shift);
end;


function TRpCLXMaskEdit.GetInteger:integer;
begin
 result:=StrToInt(Text);
end;

function TRpCLXMaskEdit.GetFloat:double;
begin
 result:=StrTofloat(Text);
end;

function TRpCLXMaskEdit.GetCurr:Currency;
begin
 result:=StrToCurr(Text);
end;

function TRpCLXMaskEdit.GetDate:TDateTime;
begin
 result:=StrToDate(Text);
end;

function TRpCLXMaskEdit.GetTime:TDateTime;
begin
 result:=StrToTime(Text);
end;

function TRpCLXMaskEdit.GetDateTime:TDateTime;
begin
 result:=StrToDateTime(Text);
end;

function TRpCLXMaskEdit.GetValue:variant;
begin
 try
  case FEditType of
   teinteger:
    result:=strtoint(text);
   tefloat:
    result:=StrTofloat(Text);
   tecurrency:
    result:=StrTocurr(TExt);
   tedate:
    result:=StrToDate(TExt);
   tetime:
    result:=StrToTime(TExt);
   teDatetime:
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

procedure TRpCLXMaskEdit.SetValue(NewValue:Variant);
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



procedure TRpCLXMaskEdit.Change;
begin
 if (csloading in componentstate) then
  exit;
 inherited change;
end;

end.
