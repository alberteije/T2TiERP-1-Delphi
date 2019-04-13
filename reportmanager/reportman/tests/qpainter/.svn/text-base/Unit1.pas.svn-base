unit Unit1;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls,Qt;

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
 han:QPainterH;
 i:integer;
begin
// QPainter_setViewport(Canvas.Handle,0,0,1000,1000);
// QPainter_setWindow(Canvas.Handle,0,0,100,100);
 han:=Canvas.Handle;
 Canvas.Start;
// QPainter_scale(han,4,4);
 QPainter_setViewport(han,0,0,2500,2500);
 QPainter_setWindow(han,0,0,2500*1440 div 96,2500*1440 div 96);
 for i:=100 downto 1 do     
 begin
  Canvas.Rectangle(0,0,i*144,i*144);
 end;
 Canvas.Stop;
// Canvas.Rectangle(0,0,100,100);
// QPainter_begin(han,nil,nil);
// QPainter_end(han);
end;

end.
