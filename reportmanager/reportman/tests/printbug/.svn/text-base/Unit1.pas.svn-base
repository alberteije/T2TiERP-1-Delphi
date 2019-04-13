unit Unit1;

interface

uses
  SysUtils, Types, Classes, Variants, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls,QPrinters, DBXpress, DB, SqlExpr;

type
  TForm1 = class(TForm)
    Button1: TButton;
    SQLConnection1: TSQLConnection;
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
begin
 // The connection to SQL Express provoques
 // a bug, the document is lost
// SQLConnection1.Connected:=True;
// Printer.SetPrinter('Epson3000');
 Printer.BeginDoc;
 try
  Printer.Canvas.TextOut(100,100,'Hello World');
 finally
  Printer.EndDoc;
 end;
 SQLConnection1.Connected:=True;
// Printer.SetPrinter('Epson3000');
 Printer.BeginDoc;
 try
  Printer.Canvas.TextOut(100,100,'Hello World');
 finally
  Printer.EndDoc;
 end;
end;

end.
