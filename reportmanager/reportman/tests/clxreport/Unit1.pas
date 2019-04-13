unit Unit1;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, rpclxreport,  DB,
{$IFDEF MSWINDOWS}
  rpvclreport,
{$ENDIF}
  rpcompobase, rpmdesigner, DBClient, rpalias,rppdfdriver;


type
  TForm1 = class(TForm)
    CLXReport1: TCLXReport;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ETest: TEdit;
    RpDesigner1: TRpDesigner;
    BDesign: TButton;
    EReportName: TEdit;
    Label2: TLabel;
    BPrint: TButton;
    Button3: TButton;
    RpAlias1: TRpAlias;
    ClientDataSet1: TClientDataSet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BDesignClick(Sender: TObject);
    procedure BPrintClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
 CLXReport1.Filename:=EReportName.Text;
 CLXReport1.Preview:=True;
 CLXReport1.Execute;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 fstream:TFileStream;
begin
 CLXReport1.Filename:=EReportName.Text;
 fstream:=TFileStream.Create(ETest.Text,fmCreate);
 try
  rppdfdriver.PrintReportPDFStream(CLXReport1.Report,'',false,true,1,9999,1,fstream,true);
 finally
  fstream.free;
 end;
// CLXReport1.SaveToPDF(ETest.text,false);
end;

procedure TForm1.BDesignClick(Sender: TObject);
begin
 RpDesigner1.Filename:=EReportName.Text;
 RpDesigner1.Execute;
end;

procedure TForm1.BPrintClick(Sender: TObject);
begin
 CLXReport1.Filename:=EReportName.Text;
 CLXReport1.Preview:=False;
 CLXReport1.Execute;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 ClientDataset1.LoadFromFile('biolife.cds');
 CLXReport1.AliasList:=RpAlias1;
 try
  CLXReport1.Preview:=true;
  CLXReport1.Execute;
 finally
  CLXReport1.AliasList:=nil;
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
// EReportName.Text:='c:\prog\toni\cvsroot\reportman\reportman\repman\repsamples\sample5.rep';
end;

end.
