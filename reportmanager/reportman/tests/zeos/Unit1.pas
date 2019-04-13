unit Unit1;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, DB, ZAbstractRODataset, ZDataset, ZConnection,
  QGrids, QDBGrids;

type
  TForm1 = class(TForm)
    ZConnection1: TZConnection;
    ZData: TZReadOnlyQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    EHost: TEdit;
    Label1: TLabel;
    EDatabase: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EPassword: TEdit;
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
 ZConnection1.HostName:=EHost.Text;
 ZConnection1.Database:=EDatabase.Text;
 ZConnection1.Password:=EPassword.Text;
 ZConnection1.Connected:=True;
 ZData.Open;
end;

end.
