unit Unit1;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls,rpprintitem,rpobinsint,rpobjinsp, QExtCtrls,rpsection;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    psec:TRPCommonPosComponent;
    pintsec:TRpSizeInterface;

    pitem:TRpCOmmonPosCOmponent;
    pint:TRpSizePosInterface;
    objinsp:TFObjInsp;
  end;

var
  Form1: TForm1;

implementation

uses rpmunits;

{$R *.xfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 // Creates a print item
// pitem:=TRpCOmmonCOmponent(Self);
// defaultunit:=rpUnitInchess;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
{ psec:=TRpCOmmonPosCOmponent.Create(Self);
 psec.Width:=2880;
 psec.Height:=2880;
 pintsec:=TRpSizePosInterface.Create(Self,psec);
 pintsec.Parent:=Panel1;
 pintsec.UpdatePos;
}


 pitem:=TRpCOmmonPosCOmponent.Create(self);
 pint:=TRpSizePosInterface.Create(Self,pitem);
 pitem.PosX:=1440;
 pitem.PosY:=1440;
 pitem.Width:=2880;
 pitem.Height:=720;
 pint.Parent:=Panel1;
 pint.UpdatePos;
// pint.GetProperties(LNames.Lines,LTypes.Lines,LValues.Lines);
// objinsp:=TFObjInsp.Create(Self);
// objinsp.Parent:=Self;
// objinsp.CompItem:=pint;

end;


procedure TForm1.Button2Click(Sender: TObject);
var
 i:integer;
 con:TRpSizeModifier;
begin
 con:=TRpSizeModifier.Create(Self);
 con.Control:=Shape1;
end;

end.
