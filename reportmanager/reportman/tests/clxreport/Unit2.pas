unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, rpcompobase, rpvclreport, DB, DBTables, rppdfreport,
  rpreport,rppdfdriver;

type
  TForm1 = class(TForm)
    Button1: TButton;
    VCLReport1: TVCLReport;
    Label1: TLabel;
    EReportname: TEdit;
    Table1: TTable;
    Button2: TButton;
    PDFReport1: TPDFReport;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
 VCLReport1.Filename:=EReportname.Text;
 VCLReport1.Execute;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 EReportName.Text:='c:\prog\toni\cvsroot\reportman\reportman\repman\repsamples\sample2.rep';

end;

procedure TForm1.Button2Click(Sender: TObject);
var
 pdfreport:TRpReport;
 astream:TMemoryStream;
begin
 pdfreport:=TRpReport.Create(Application);
 try
  pdfreport.LoadFromFile(EReportName.Text);
  astream:=TMemoryStream.Create;
  try
   astream.Clear;
//   rppdfdriver.PrintReportPDFStream(pdfreport,'',false,true,1,9999,1,
//    astream,true);
   astream.Seek(0,soFromBeginning);
   astream.SaveToFile('prova.pdf');
  finally
   astream.Free;
  end;
 finally
  pdfreport.free;
 end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
 VCLReport2:TVCLReport;
begin
 VCLReport2:=TVCLReport.Create(nil);
 try
  VCLReport2.ExecuteRemote('localhost',3060,'Admin','','SAMPLE','sampl.rep');
 finally
  VCLReport2.free;
 end;
end;

end.
