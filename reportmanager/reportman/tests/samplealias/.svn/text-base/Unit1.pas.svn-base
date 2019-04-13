unit Unit1;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, DB, QGrids, QDBGrids, rpcompobase, rpclxreport,
  rpalias, DBClient;

type
  TForm1 = class(TForm)
    BFillData: TButton;
    Button1: TButton;
    EFileName: TEdit;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ClientDataSet1: TClientDataSet;
    Label5: TLabel;
    RpAlias1: TRpAlias;
    CLXReport1: TCLXReport;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1CODE: TStringField;
    ClientDataSet1NAME: TStringField;
    ClientDataSet1PRICE: TCurrencyField;
    procedure FormCreate(Sender: TObject);
    procedure BFillDataClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.xfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 ClientDataSet1.CreateDataSet;
 
end;

procedure TForm1.BFillDataClick(Sender: TObject);
begin
 ClientDataset1.AppendRecord(['XF','Phone mod 25',134.25]);
 ClientDataset1.AppendRecord(['XF','Phone mod 31',145.25]);
 ClientDataset1.AppendRecord(['XF','Alcaone Phone HG45',450.25]);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 ClientDataSet1.First;
 CLXReport1.Filename:='sample.rep';
 CLXReport1.Preview:=true;
 CLXReport1.Execute;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 ClientDataSet1.SaveToFile('sample.cds');
end;

end.
