unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, System.ComponentModel, Borland.Vcl.StdCtrls, rpcompobase,
  rpvclreport;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    VCLReport1: TVCLReport;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.nfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
 VCLReport1.Filename:='samplenet.rep';
 VCLReport1.Preview:=True;
 VCLReport1.Execute;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 VCLReport1.Filename:='samplenet.rep';
 VCLReport1.Preview:=False;
 VCLReport1.Execute;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 VCLReport1.Filename:='samplenet.rep';
 VCLReport1.SaveToPDF('test.pdf',false) ;
end;

end.
