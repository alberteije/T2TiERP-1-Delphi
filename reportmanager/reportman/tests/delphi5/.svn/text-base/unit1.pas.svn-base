unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, rpvclreport;

type
  TForm1 = class(TForm)
    Button1: TButton;
    VCLReport1: TVCLReport;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
 VCLReport1.Filename:=Edit1.Text;
 VCLReport1.Execute;
end;

end.
