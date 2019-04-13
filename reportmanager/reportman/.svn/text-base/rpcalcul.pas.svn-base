unit rpcalcul;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,rpmaskedit, Mask,rptypes;

type
  TFRpCalcul = class(TForm)
    EText: TRpMaskEdit;
    B7: TBitBtn;
    B8: TBitBtn;
    B9: TBitBtn;
    B4: TBitBtn;
    B5: TBitBtn;
    B6: TBitBtn;
    B1: TBitBtn;
    B2: TBitBtn;
    B3: TBitBtn;
    B0: TBitBtn;
    BSign: TBitBtn;
    BComma: TBitBtn;
    BDiv: TBitBtn;
    BMult: TBitBtn;
    BMinus: TBitBtn;
    BAdd: TBitBtn;
    BOK: TBitBtn;
    BC: TBitBtn;
    BCE: TBitBtn;
    BRetro: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure B7Click(Sender: TObject);
  private
    { Private declarations }
    oldidle:TIdleEvent;
    value,stack:double;
    operationstack:integer;
    commapressed:boolean;
    dook:boolean;
    isdoingoperation:Boolean;
    dispmask:string;
    procedure Appidle(Sender:TObject;var done:Boolean);
    procedure UpdateNumber;
  public
    { Public declarations }
  end;

function GetNumberFromCalculator(value:double):double;

implementation

{$R *.DFM}

function GetNumberFromCalculator(value:double):double;
var
 dia:TFRpCalcul;
begin
 Result:=value;
 dia:=TFRpCalcul.Create(Application);
 try
  dia.oldidle:=Application.OnIdle;
  dia.value:=value;
  dia.stack:=0;
  dia.UpdateNumber;
  dia.isdoingoperation:=true;
  Application.OnIdle:=dia.AppIdle;
  dia.ShowModal;
  if dia.dook then
   Result:=dia.value;
  Application.OnIdle:=dia.oldidle;
 finally
  dia.free;
 end;
end;

procedure TFRpCalcul.FormCreate(Sender: TObject);
var
 i:integer;
begin
 Font.Size:=Round(Font.Size*2);
 BComma.Caption:=DecimalSeparator;

 for i:=0 to controlcount-1 do
 begin
  if controls[i] is TButton then
  begin
   TButton(controls[i]).ParentFont:=false;
   if controls[i].Tag<=11 then
    TButton(controls[i]).Font.Color:=clBlue
   else
    TButton(controls[i]).Font.Color:=clRed;
  end;
 end;
end;

procedure TFRpCalcul.Appidle(Sender:TObject;var done:Boolean);
begin
 done:=false;
 Application.OnIdle:=nil;
end;

procedure TFRpCalcul.UpdateNumber;
begin
 if Length(dispmask)>0 then
 begin
  EText.DisplayMask:='#,#0.'+dispmask;
 end
 else
  EText.DisplayMask:='#,#0.########';
 EText.Text:=FloatToStr(value);
 EText.Invalidate;
end;


procedure TFRpCalcul.B7Click(Sender: TObject);

procedure DoOperation;
begin
 case operationstack of
  12:
   begin
    value:=stack+value;
   end;
  13:
   begin
    value:=stack-value;
   end;
  14:
   begin
    value:=stack*value;
   end;
  else
   begin
    if value<>0 then
    value:=stack/value;
   end;
 end;

 dispmask:='';
 stack:=0;
 operationstack:=0;
end;

var
 atag,index:integer;
 atext:string;
 avalue:double;
begin
 atag:=TButton(Sender).tag;
 case atag of
  0..9:
   begin
    avalue:=EText.AsFloat;
    if Length(dispmask)>0 then
    begin
     atext:=FormatFloat('##0.'+dispmask,avalue);
     if Length(dispmask)<4 then
      dispmask:=dispmask+'0';
    end
    else
    begin
     atext:=FloatToStr(avalue);
    end;
    if isdoingoperation then
    begin
     dispmask:='';
     atext:='0';
     isdoingoperation:=false;
    end;
    if commapressed then
    begin
     index:=Pos(decimalseparator,atext);
     if index=0 then
      atext:=atext+decimalseparator;
    end;
    index:=Pos('E',atext);
    if index>0 then
     atext:=Copy(atext,1,index-1)+IntToStr(atag)+Copy(atext,index,Length(text))
    else
     atext:=atext+IntToStr(atag);
    if (Length(dispmask)=0) then
    if atag=0 then
    begin
     index:=Pos(decimalseparator,atext);
     if index>0 then
     begin
       dispmask:='';
       for index:=index+1 to Length(atext) do
        dispmask:=dispmask+'0';
     end;
    end;
    trystrtofloat(atext,value);
   end;
  12..15:
   begin
    if operationstack<>0 then
     DoOperation;
    stack:=value;
    operationstack:=atag;
    isdoingoperation:=true;
   end;
  11:
   commapressed:=true;
  18,17:
   begin
    value:=0;
    dispmask:='';
    operationstack:=0;
    isdoingoperation:=false;
   end;
  19:
   begin
    if operationstack>0 then
     DoOperation
    else
    begin
     dook:=true;
     close;
    end;
   end;
 end;
 if atag=11 then
  commapressed:=true
 else
  commapressed:=false;
 UpdateNumber;
end;

end.
