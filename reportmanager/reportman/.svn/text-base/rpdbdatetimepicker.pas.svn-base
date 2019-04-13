unit rpdbdatetimepicker;

interface

{$I rpconf.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls,dbctrls,db,
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
  commctrl;

type
  TRpDateTimePicker = class(TDateTimePicker)
  private
    { Private declarations }
   FDateIfNull:TDate;
   FCanvas:TControlCanvas;
   FIsNull:Boolean;
   FFocused:Boolean;
   FModifyOnExit:Boolean;
   FDataLink:TFieldDataLink;
   IsModified: Boolean;
   editant:Boolean;
   function GetDataField:string;
   function GetDataSource:TDataSource;
   procedure SetDataField(const Value:string);
   procedure SetDataSource(Value:TDataSource);
   procedure DataChange(Sender:TObject);
   procedure UpdateData(Sender:TObject);
   procedure PickerChange(Sender:TObject);
   procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
   procedure SetFocused(Value: Boolean);
   procedure EditingChange(Sender:TObject);
  protected
    { Protected declarations }
    procedure KeyPress(var Key:char);override;
    procedure Notification(AComponent: TComponent;
          Operation: TOperation);override;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    { Published declarations }
    property TabOrder;
    property DataField:string read GetDataField write SetDataField;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
    property ModifyOnExit:Boolean read FModifyOnExit write FModifyOnExit default true;
    property DateIfNull:Tdate read FDateIfNull write FDateIfNull;
  end;


implementation

constructor TRpDateTimePicker.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FDataLink:=TFieldDataLink.Create;
 FDataLink.Control:=Self;
 FDataLink.OnDataChange:=DataChange;
 FDataLink.OnUpdateData:=UpdateData;
 FDataLink.OnEditingChange:=EditingChange;
 OnChange:=PickerChange;
 IsModified:=False;
 FIsNUll:=False;
 FModifyOnExit:=True;

end;

destructor TRpDateTimePicker.destroy;
begin
 FCanvas.free;
 FDataLink.free;
 FDatalink:=nil;
 inherited;
end;

procedure TRpDateTimePicker.PickerChange(Sender:TObject);
begin
 IsModified:=True;
end;

function TRpDateTimePicker.GetDataField:string;
begin
 result:=FDatalink.FieldName;
end;

function TRpDateTimePicker.GetDataSource:TDataSource;
begin
 result:=FDatalink.DataSource;
end;

procedure TRpDateTimePicker.SetDataField(const Value:string);
begin
 FDatalink.fieldname:=Value;
end;

procedure TRpDateTimePicker.SetDataSource(Value:TDataSource);
begin
 FDatalink.DataSource:=Value;
end;

procedure TRpDateTimePicker.EditingChange(Sender:TObject);
begin
 invalidate;
end;

procedure TRpDateTimePicker.DataChange(Sender:TObject);
begin
 if FDatalink.Field=nil then
  FIsNull:=True
 else
 begin
  if not IsModified then
  begin
   FIsNull:=FDatalink.Field.IsNull;
   if Trunc(FDatalink.Field.AsDateTime)<>0 then
   begin
    if self.Kind=dtkdate then
     Date:=Trunc(FDatalink.Field.AsDateTime)
    else
    begin
     Date:=FDatalink.Field.AsDateTime;
     Time:=FDatalink.Field.AsDateTime;
    end;
   end
   else
   begin
    if fDateifNull<>0 then  //si es 0 hi posarà la data actual
    begin
     Date:=FDateIfNull;
     Time:=FDateIfNull;
    end
    else
     Date:=sysutils.date;
     Time:=sysutils.date;
    end;
  end;
  IsModified:=False;
 end;
end;

procedure TRpDateTimePicker.UpdateData(Sender:TObject);
var
 anticnull:boolean;
begin
 anticnull:=Fisnull;
 Fisnull:=anticnull;
 if FIsNull then
 begin
  if FDatalink.Field.AsVariant<>Null then
  begin
   FDatalink.edit;
   FDatalink.modified;
   FDatalink.Field.AsVariant:=Null
  end;
 end
 else
 begin
  if  self.Kind=dtkdate then
  begin
   if FDatalink.Field.AsDateTime<>Trunc(Date) then
   begin
    FDatalink.edit;
    FDatalink.modified;
    FDatalink.Field.AsDateTime:=Trunc(Date);
   end;
  end
  else
  if FDatalink.Field.AsDateTime<>Date then
  begin
    FDatalink.edit;
    FDatalink.modified;
    FDatalink.Field.AsDateTime:=Date;
  end;
 end;
end;

procedure TRpDateTimePicker.CNNotify(var Message: TWMNotify);
begin
 inherited;
 if Message.NMHdr^.code=DTN_DATETIMECHANGE then
 begin
  if Not FDataLink.Field.ReadOnly then
  begin
   if editant then
   begin
    Message.Result:=1;
    application.processmessages;
    exit;
   end;
   editant:=true;
   try
    try
     FDatalink.Edit;
     FDatalink.Modified;
     FIsnull:=False;
     if Not FModifyOnExit then
      FDataLink.UpdateRecord;
    except
     application.processmessages;
     raise;
    end;
   finally
    editant:=false;
   end;
  end
  else
   if Date<>FDataLink.Field.AsDateTime then
   begin
    Date:=FDataLink.Field.AsDateTime;
    Time:=FDataLink.Field.AsDateTime;
   end;
 end;
 Invalidate;
end;

procedure TRpDateTimePicker.KeyPress(var Key:Char);
begin
 if Key=chr(VK_ESCAPE) then
 begin
  FDataLink.Reset;
  Key:=chr(0);
 end
 else
 if ( (Key=chr(VK_DELETE)) or (Key=chr(VK_BACK)) ) then
 begin
  FIsNull:=True;
  Invalidate;
  Key:=chr(0);
  if Not FModifyOnExit then
  begin
   Updatedata(Self);
   FDataLink.UpdateRecord;
  end;
 end;
 if Key=chr(13) then
 begin
  FDataLink.UpdateRecord;
  Key:=chr(0);
 end;
 inherited Keypress(Key);
 Invalidate;
end;

procedure TRpDateTimePicker.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TRpDateTimePicker.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TRpDateTimePicker.CMExit(var Message: TCMExit);
begin
  try
    if (NOt (FDatalink.field.isnull and FIsnull)) then
     Updatedata(Self);
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
end;

procedure TRpDateTimePicker.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    FDataLink.Reset;
  end;
  Invalidate;
end;


procedure TRpDateTimePicker.WMPaint(var Message: TWMPaint);
var
  R,NouR: TRect;
  DC: HDC;
  PS: TPaintStruct;
begin
  { Since edit controls do not handle justification unless multi-line (and
   then only poorly) we will draw right and center justify manually unless
   the edit has the focus. }
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  // Mirem si es null
  if Not FIsnull then
  begin
   inherited;
   exit;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      if not (NewStyleControls and Ctl3D) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      if FFocused then
      begin
       FCanvas.Brush.Color:=clHighLight
      end
      else
       FCanvas.Brush.Color := Color;
      // Restem l'amplada del butó
      NouR:=R;
      NouR.Left:=R.Right-GetSystemMetrics(SM_CXHSCROLL);
      R.Right:=R.Right-GetSystemMetrics(SM_CXHSCROLL);
      FCanvas.FillRect(R);
      if ((Kind=dtkDate) and (DateMode=dmComboBox)) then
       DrawFrameControl(FCanvas.handle,NouR,DFC_SCROLL,DFCS_SCROLLDOWN);
   end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

end.
