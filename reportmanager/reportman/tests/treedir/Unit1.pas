unit Unit1;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls,rpgraphutils, QComCtrls, DBXpress, DB, SqlExpr,
  FMTBcd,rpmdftree,rpmdconsts,dbtables,rptypes,rpdatainfo;

type
  TForm1 = class(TForm)
    Button1: TButton;
    SQLConnection1: TSQLConnection;
    QReports: TSQLQuery;
    QGroups: TSQLQuery;
    Button2: TButton;
    QReport: TSQLQuery;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    atree:TFRpDBTree;
    db1,db2:TDatabase;
    procedure OnLoadReport(reportname:string;memstream:TMemoryStream);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.xfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 dbinfo:TRpDatabaseInfoItem;
begin
 db1.connected:=true;
 db2.connected:=true;
 SQLConnection1.Connected:=True;
 QGroups.Open;
 QReports.Open;
 atree.FillTree(QGroups,QReports);
 atree.EditTree(dbinfo,'REPMAN_REPORTS','REPMAN_GROUPS');
// FillTreeView('c:\prog\toni\cvsroot\reportman\reportman',TreeView1.Items,TreeView1.TopItem,'*.rep');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 atree:=TFRpDBTree.Create(Self);
 atree.OnLoadReport:=Self.OnLoadReport;
 atree.Top:=0;
 atree.Left:=0;
 atree.Parent:=Self;
 db1:=TDatabase.Create(Self);
 db2:=TDatabase.Create(Self);
 db1.LoginPrompt:=false;
 db2.LoginPrompt:=false;
 db1.AliasName:='IFACTUR';
 db1.DatabaseName:='FACTUR';
 db2.AliasName:='IFACTUREMP';
 db2.DatabaseName:='FACTUREMP';
 db1.Params.Add('USER NAME=SYSDBA');
 db1.Params.Add('PASSWORD=tw2000');
// db1.Params.Add('SERVER NAME=pluton:c:\000');
 db2.Params.Assign(db1.Params);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 alist:TStringList;
begin
// atree.FillTree('c:\prog\toni\cvsroot\reportman\reportman\tests\treedir\test');
 alist:=TStringList.Create;
 try
  rptypes.FillTreeDir('c:\prog\toni\cvsroot\reportman\reportman\tests\treedir\test',alist);
  Memo1.Lines.Assign(alist);
  atree.rootfilename:='c:\prog\toni\cvsroot\reportman\reportman\tests\treedir\test';
  atree.FillTree(alist);
 finally
  alist.free;
 end;
end;

procedure TForm1.OnLoadReport(reportname:string;memstream:TMemoryStream);
begin
 QReport.ParamByName('REPORTNAME').Value:=reportname;
 QReport.Open;
 try
  if QReport.Eof then
   Raise Exception.Create(SrptReportNotFound);
  (QReport.FieldByName('REPORT') As TBlobField).SaveToStream(memstream);
 finally
  QReport.Close;
 end;
end;

end.
