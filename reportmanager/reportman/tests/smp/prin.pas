unit prin;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls;

type
  TMyThread=class;

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    athread1,athread2:TMyThread;
  end;

  TMyThread=class(TThread)
   public
   value:integer;
   aresult:int64;
   procedure Execute;override;
  end;

var
  Form1: TForm1;

implementation

{$R *.xfm}

procedure TMyThread.Execute;
var
 i,j:integer;
begin
 aresult:=0;
 for i:=0 to value do
  for j:=1 to value do
   aresult:=aresult+1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 athread1:=TMyThread.Create(true);
 athread1.Value:=100000;
 athread1.FreeOnTerminate:=true;
 athread1.Resume;
 athread2:=TMyThread.Create(true);
 athread2.FreeOnTerminate:=true;
 athread2.Value:=100000;
 athread2.Resume;
end;

end.
