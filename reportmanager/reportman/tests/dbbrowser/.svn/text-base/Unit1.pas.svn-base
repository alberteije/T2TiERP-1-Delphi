unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  rpreport,rpdbbrowservcl,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    areport:TRpReport;
    abrowser:TFRpBrowserVCL;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
 areport:=TRpReport.Create(Self);
 areport.LoadFromFile('c:\prog\toni\espuna\devolucions\detalle.rep');
 abrowser:=TFRpBrowserVCL.Create(Self);
 abrowser.Report:=areport;
 abrowser.parent:=self;

end;

end.
 