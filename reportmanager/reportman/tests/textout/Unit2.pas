unit Unit2;

interface

uses
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  rpcompobase,  rptextdriver,
  rpclxreport, QStdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    CLXReport1: TCLXReport;
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
 CLXReport1.Filename:='/home/toni/cvsroot/reportman/repman/repsamples/sample6.rep';
 PrintReportToText(CLXReport1.Report,'test',false,true,0,1,1,'test.txt',false,true,'');
 CLXReport1.Preview:=true;
 CLXReport1.Execute;
end;

end.
