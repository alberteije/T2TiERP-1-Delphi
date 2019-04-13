unit Unit1;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, DBXpress, DB, SqlExpr,SQLConst,DBConnAdmin;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Alist: TListBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses rpdbxconfig;

{$R *.xfm}

procedure TForm1.FormCreate(Sender: TObject);
var
 LibraryName:string;
 VendorLibrary:string;
 params:TStringlist;
begin
 ShowDBXConfig('');
{ SQLConnection1.LoadParamsFromIniFile;
 Memo1.Lines.Assign(SQLCOnnection1.Params);
 SQLConnection1.DriverName:=SQLConnection1.Params.Values['DriverName'];
 Label1.caption:=GetDriverRegistryFile;
 Label2.caption:=GetConnectionRegistryFile;
 GetDriverNames(alist.items);
 GetConnectionAdmin.GetDriverLibNames(SQLConnection1.Params.Values['DriverName'],
  LibraryName,VendorLibrary);

 SQLConnection1.VendorLib:=VendorLibrary;
 SQLCOnnection1.LibraryName:=LibraryName;

 SQLConnection1.Connected:=true;
}
end;


function FormatLine(const Key, Value: string): string;
begin
  Result := Format('%s=%s', [Key, Value]);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 params:TStringlist;
begin
 params:=TStringList.Create;
 try
//  GetConnectionAdmin.GetDriverParams();
 finally
  params.Free;
 end;
end;

end.
