unit Unit1;

interface

uses
  SysUtils, Types, Classes, Variants, QGraphics, QControls, QForms, QDialogs,
  DBXpress, QStdCtrls, DB, SqlExpr, rpalias, rpeval, FMTBcd, QExtCtrls,
  QDBCtrls, QGrids, QDBGrids, Provider, DBClient, DBLocal, DBLocalS,DBConnAdmin;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    base: TSQLConnection;
    BConnections: TButton;
    Label2: TLabel;
    LConnected: TLabel;
    GTables: TGroupBox;
    EExpression: TMemo;
    Label3: TLabel;
    EDatabase: TEdit;
    Label4: TLabel;
    EUser: TEdit;
    Label5: TLabel;
    EPassword: TEdit;
    LTables: TListBox;
    Label6: TLabel;
    EAlias: TEdit;
    LAlias: TListBox;
    BAdd: TButton;
    BSub: TButton;
    RpEvaluator1: TRpEvaluator;
    RpAlias1: TRpAlias;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    SQLClientDataSet1: TSQLClientDataSet;
    Label7: TLabel;
    Memo1: TMemo;
    BEVal: TButton;
    LStatus: TLabel;
    Label8: TLabel;
    LDrivers: TListBox;
    procedure BConnectionsClick(Sender: TObject);
    procedure LTablesClick(Sender: TObject);
    procedure BAddClick(Sender: TObject);
    procedure LAliasClick(Sender: TObject);
    procedure BEValClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    recs:integer;
    procedure freetables;
    procedure newrec(Sender: TObject; var OwnerData: OleVariant);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.xfm}

procedure TForm1.freetables;
var
 i:integer;
begin
 for i:=0 to rpalias1.list.Count-1 do
 begin
  rpalias1.List.items[i].Dataset.Free;
 end;
 rpalias1.List.Clear;
 LAlias.Items.Clear;
end;

procedure TForm1.BConnectionsClick(Sender: TObject);
begin
 if base.connected then
 begin
  freetables;
  base.Connected:=false;
  LConnected.Caption:='Disconnected';
  GTables.Visible:=False;
  EDatabase.Enabled:=true;
 end
 else
 begin
  base.Params.Clear;
  base.Params.Values['Database']:=EDatabase.text;
  base.Params.Values['Password']:=EPassword.text;
  base.Params.Values['User_name']:=EUser.text;
  base.Connected:=true;
  LConnected.Caption:='Connected';
  GTables.Visible:=true;
  EDatabase.Enabled:=false;
  base.GetTableNames(Ltables.Items,false);
 end;
end;

procedure TForm1.LTablesClick(Sender: TObject);
begin
 if LTables.itemindex>=0 then
 begin
  EAlias.text:=LTables.Items.strings[Ltables.itemindex];
 end;
end;

procedure TForm1.BAddClick(Sender: TObject);
var
 rpitem:TRpAliaslistitem;
 sqlq:TSQLClientdataset;
begin
 rpitem:=rpalias1.List.Add;
 rpitem.Alias:=EAlias.text;
 sqlq:=TSQLClientdataset.Create(Application);
 sqlq.BeforeRowRequest:=newrec;
 recs:=0;
 rpitem.Dataset:=sqlq;
 LAlias.Items.Add(EAlias.text);
 sqlq.DBConnection:=base;
 sqlq.ReadOnly:=True;
 sqlq.Commandtext:='SELECT * FROM '+LTables.Items.strings[LTables.itemindex];
 sqlq.PacketRecords:=100;
 sqlq.active:=true;
end;

procedure TForm1.LAliasClick(Sender: TObject);
var
 index:integer;
begin
 datasource1.dataset:=nil;
 if LAlias.items.count<1 then
  exit;
 if LAlias.itemindex<0 then
  exit;
 index:=rpalias1.List.indexof(Lalias.Items.strings[Lalias.itemindex]);
 if index>=0 then
 begin
  datasource1.dataset:=rpalias1.list.items[index].dataset;
 end;
end;

procedure TForm1.BEValClick(Sender: TObject);
begin
 RpEvaluator1.Expression:=EExpression.text;
 RpEvaluator1.Evaluate;
 Memo1.Text:=RpEvaluator1.EvalResultString;
end;

procedure TForm1.newrec(Sender: TObject; var OwnerData: OleVariant);
begin
 inc(recs);
 LStatus.caption:=Formatfloat('##,##',recs);
 LStatus.Refresh;
 Application.ProcessMessages;
end;
procedure TForm1.FormCreate(Sender: TObject);
var
 libname,vendlib:string;
begin
 GetDriverNames(ldrivers.items);
 GetConnectionAdmin.GetDriverLibNames('Interbase',libname,vendlib);
 base.DriverName:='Interbase';
 base.LibraryName:=libname;
 base.VendorLib:=vendlib;
end;


end.
