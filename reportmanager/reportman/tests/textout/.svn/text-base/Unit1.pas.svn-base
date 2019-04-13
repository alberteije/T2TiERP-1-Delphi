unit Unit2;

interface

uses
  SysUtils, Classes, QForms,QDialogs,
  rpcompobase, rpvclreport,rptextdriver;

type
  TForm1 = class(TForm)
    Button1: TButton;
    VCLReport1: TVCLReport;
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
 VCLReport1.Filename:='c:\prog\toni\cvsroot\reportman\reportman\repman\repsamples\sampl2.rep';
 PrintReportToText(VCLReport1.Report,'test',false,true,0,1,1,'test.txt',false,true);
 VCLReport1.Preview:=true;
 VCLReport1.Execute;
end;

end.
