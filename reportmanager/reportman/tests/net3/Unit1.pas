unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Borland.Vcl.StdCtrls, System.ComponentModel, rpcompobase,
  rpvclreport;

type
  TForm1 = class(TForm)
    VCLReport1: TVCLReport;
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

{$R *.nfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
 VCLREport1.Filename:='..\..\repman\repsamples\sample4.rep';
// Environment.CurrentDirectory:='c:\prog\toni\cvsroot\reportman\reportman\repman\repsamples\';
 Environment.CurrentDirectory:='..\..\repman\repsamples\';
 VCLReport1.Execute;
end;

end.
