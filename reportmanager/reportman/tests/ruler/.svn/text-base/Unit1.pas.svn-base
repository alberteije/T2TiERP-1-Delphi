unit Unit1;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls,rpruler;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.xfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 aruler:TRpRuler;
begin
 aruler:=TRpRuler.Create(Self);
 aruler.RType:=rHorizontal;
// aruler.Metrics:=rInchess;
 aruler.Metrics:=rCms;
// aruler.RType:=rVertical;
 aruler.Left:=0;
// aruler.Width:=150;
// aruler.Height:=150000;
 aruler.Width:=15000;
 aruler.Top:=0;
 aruler.parent:=self;
end;

end.
