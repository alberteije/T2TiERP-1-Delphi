unit rpquerywiz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  rpreport, StdCtrls, ExtCtrls,rpdatainfo, Db, DBClient;

type
  TFRpQueryWiz = class(TFrame)
    PConnection: TPanel;
    ComboConnection: TComboBox;
    Label1: TLabel;
    PBottom: TPanel;
    Label2: TLabel;
    ComboTable: TComboBox;
    Label3: TLabel;
    LFields: TListBox;
    Label4: TLabel;
    LSelected: TListBox;
    BAdd: TButton;
    BDelete: TButton;
    BAddAll: TButton;
    BDeleteAll: TButton;
    Label5: TLabel;
    LSorted: TListBox;
    BSAdd: TButton;
    BSDelete: TButton;
    BSAddAll: TButton;
    BSDeleteAll: TButton;
    PAlBottom: TPanel;
    BShowData: TButton;
    procedure ComboConnectionClick(Sender: TObject);
    procedure ComboTableClick(Sender: TObject);
    procedure BSDeleteAllClick(Sender: TObject);
    procedure BSAddAllClick(Sender: TObject);
    procedure BSAddClick(Sender: TObject);
    procedure BSDeleteClick(Sender: TObject);
    procedure BAddClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure BAddAllClick(Sender: TObject);
    procedure BDeleteAllClick(Sender: TObject);
    procedure LFieldsDblClick(Sender: TObject);
    procedure LSelectedDblClick(Sender: TObject);
    procedure LSortedDblClick(Sender: TObject);
  private
    { Private declarations }
    FReport:TRpReport;
    LFieldNames:TStrings;
    LFieldTypes:TStrings;
    LFieldSizes:TStrings;
    procedure SetReport(areport:TRpReport);
  public
    { Public declarations }
    datasetname:String;
    dbinfo:TRpDatabaseInfoItem;
    datainfo:TRpDatainfoItem;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property Report:TRpReport read FReport write SetReport;
  end;


implementation

{$R *.DFM}

constructor TFRpQueryWiz.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 LFieldNames:=TStringList.Create;
 LFieldTypes:=TStringList.Create;
 LFieldSizes:=TStringList.Create;

 Width:=LSorted.Left+LSorted.Width+10;
 Height:=LFields.Top+LFields.Height+PAlbottom.Height+10;
 LFields.Anchors:=[akLeft,akTop,akBottom];
 LSelected.Anchors:=[akLeft,akTop,akBottom];
 LSorted.Anchors:=[akLeft,akRight,akTop,akBottom];
end;

destructor TFRpQueryWiz.Destroy;
begin
 LFieldNames.free;
 LFieldSizes.free;
 LFieldTypes.free;

 inherited Destroy;
end;


procedure TFRpQueryWiz.SetReport(areport:TRpReport);
var
 i:integer;
begin
 FReport:=areport;
 ComboConnection.Clear;
 for i:=0 to FReport.Databaseinfo.Count-1 do
 begin
  ComboConnection.Items.Add(FReport.DatabaseInfo.Items[i].Alias);
 end;
 datainfo:=FReport.DataInfo.ItemByName(datasetname);
 if Length(datainfo.DatabaseAlias)<1 then
  datainfo.DatabaseAlias:=FReport.DatabaseInfo.Items[0].Alias;
 ComboCOnnection.ItemIndex:=ComboConnection.Items.Indexof(datainfo.DatabaseAlias);
 dbinfo:=FReport.DatabaseInfo.ItemByName(datainfo.DatabaseAlias);
 ComboConnectionClick(Self);
end;


procedure TFRpQueryWiz.ComboConnectionClick(Sender: TObject);
begin
 datainfo.DatabaseAlias:=ComboConnection.Text;
 ComboTable.Clear;
 dbinfo.GetTableNames(ComboTable.Items,nil);
 ComboTable.ItemIndex:=ComboTable.Items.Count-1;
 ComboTableClick(Self);
end;

procedure TFRpQueryWiz.ComboTableClick(Sender: TObject);
begin
 LSelected.Items.Clear;
 LFields.Items.Clear;
 LSorted.Items.Clear;
 dbinfo.GetFieldNames(ComboTable.Text,LFieldNames,LFieldTypes,LFieldSizes,nil);
 LFields.Items.Assign(LFieldNames);
end;

procedure TFRpQueryWiz.BSDeleteAllClick(Sender: TObject);
begin
 LSorted.Items.Clear;
end;

procedure TFRpQueryWiz.BSAddAllClick(Sender: TObject);
begin
 LSorted.Items.Assign(LSelected.Items);
end;

procedure TFRpQueryWiz.BSAddClick(Sender: TObject);
begin
 if LSelected.ItemIndex<0 then
  exit;
 if LSorted.Items.IndexOf(LSelected.Items[LSelected.ItemIndex])<0 then
  LSorted.Items.Add(LSelected.Items[LSelected.ItemIndex]);
end;

procedure TFRpQueryWiz.BSDeleteClick(Sender: TObject);
begin
 if LSorted.ItemIndex<0 then
  exit;
 LSorted.Items.Delete(LSorted.ItemIndex);
end;

procedure TFRpQueryWiz.BAddClick(Sender: TObject);
var
 oldindex:integer;
 aname:string;
begin
 if LFields.ItemIndex<0 then
  exit;
 aname:=LFields.Items[LFields.ItemIndex];
 if LSelected.Items.IndexOf(aname)>=0 then
  exit;
 LSelected.Items.Add(aname);
 oldindex:=LFields.Itemindex;
 LFields.Items.Delete(oldindex);
 if LFields.Items.Count<1 then
  oldindex:=-1;
 LFields.ItemIndex:=oldindex;
end;

procedure TFRpQueryWiz.BDeleteClick(Sender: TObject);
var
 oldindex,i:integer;
 aname:string;
begin
 oldindex:=LSelected.ItemIndex;
 if oldindex<0 then
  exit;
 aname:=LSelected.Items[oldindex];
 LSelected.Items.Delete(oldindex);
 LFields.Items.Assign(LFieldNames);
 for i:=0 to LSelected.Items.Count-1 do
 begin
  oldindex:=LFields.Items.IndexOf(LSelected.Items[i]);
  if oldindex>=0 then
   LFields.Items.Delete(oldindex);
 end;
 oldindex:=LSorted.Items.Indexof(aname);
 if oldindex>=0 then
  LSorted.Items.Delete(oldindex);
end;

procedure TFRpQueryWiz.BAddAllClick(Sender: TObject);
var
 i:integer;
begin
 for i:=0 to LFields.Items.Count-1 do
 begin
  LSelected.Items.Add(LFields.Items[i]);
 end;
 LFields.Items.Clear;
end;

procedure TFRpQueryWiz.BDeleteAllClick(Sender: TObject);
begin
 LSelected.Items.Clear;
 LSorted.Items.Clear;
 LFields.Items.Assign(LFieldNames);
end;

procedure TFRpQueryWiz.LFieldsDblClick(Sender: TObject);
begin
 BAddClick(Sender);
end;

procedure TFRpQueryWiz.LSelectedDblClick(Sender: TObject);
begin
 BDeleteClick(Sender);
end;

procedure TFRpQueryWiz.LSortedDblClick(Sender: TObject);
begin
 BSDeleteClick(Sender);
end;

end.
