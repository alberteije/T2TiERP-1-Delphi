unit rpmdfselectfields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ImgList,rpreport,rpdatainfo;

type
  TFRpSelectFields = class(TFrame)
    Label1: TLabel;
    ComboDataset: TComboBox;
    Label2: TLabel;
    LAvailable: TListBox;
    BAdddata: TButton;
    BDeleteData: TButton;
    ImageList1: TImageList;
    Label3: TLabel;
    LSelected: TCheckListBox;
    CheckProportional: TCheckBox;
    procedure ComboDatasetChange(Sender: TObject);
    procedure BAdddataClick(Sender: TObject);
    procedure BDeleteDataClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    report:TRpReport;
    fieldlist,fieldtypes,fieldsizes:TStringList;
    fieldlabels:TStringList;
    widths:TStringList;
    ftypes:TStringList;
    function GetFieldWidth(index:integer):integer;
    procedure UpdateDatasets;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;

implementation

{$R *.DFM}

constructor TFRpSelectFields.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 fieldlabels:=TStringList.Create;
 widths:=TStringList.Create;
 ftypes:=TStringList.Create;
 fieldlist:=TStringList.Create;
 fieldtypes:=TStringList.Create;
 fieldsizes:=TStringList.Create;;
 LSelected.Height:=Height-LSelected.Top-30;
 LAvailable.Height:=Height-LAvailable.Top-30;
 LSelected.Width:=Width-LSelected.Left-30;
 LAvailable.Anchors:=[akLeft,akTop,akBottom];
 LSelected.Anchors:=[akLeft,akTop,akBottom,akRight];
end;

destructor TFRpSelectFields.Destroy;
begin
 fieldlist.free;
 fieldtypes.free;
 fieldsizes.free;
 fieldlabels.Free;
 widths.free;
 ftypes.free;
 inherited Destroy;
end;

procedure TFRpSelectFields.UpdateDatasets;
var
 i:integer;
begin
 ComboDataset.Items.Clear;
 for i:=0 to report.DataInfo.Count-1 do
 begin
  Combodataset.Items.Add(report.datainfo.Items[i].Alias);
 end;
 if ComboDataset.Items.Count>0 then
  ComboDataset.ItemIndex:=0;
 ComboDatasetChange(Self);
end;

procedure TFRpSelectFields.ComboDatasetChange(Sender: TObject);
var
 i:integer;
 fieldname:string;
begin
 LAvailable.Items.Clear;
 if ComboDataset.ItemIndex<0 then
  exit;
 report.DataInfo.Items[ComboDataset.ItemIndex].GetFieldNames(fieldlist,fieldtypes,fieldsizes);
 for i:=0 to fieldlist.Count-1 do
 begin
  fieldname:=fieldlist.Strings[i];
  if Pos(' ',fieldname)>0 then
   fieldname:='['+fieldname+']';
  fieldname:=fieldname+' '+fieldtypes.strings[i];
  if Length(fieldsizes.strings[i])>0 then
   fieldname:=fieldname+'('+fieldsizes.strings[i]+')';
  LAvailable.Items.Add(fieldname);
 end;
 if LAvailable.Items.Count>0 then
  LAvailable.ItemIndex:=0;
end;

procedure TFRpSelectFields.BAdddataClick(Sender: TObject);
var
 fieldname:string;
 index:integer;
begin
 if LAvailable.ItemIndex<0 then
  exit;
 fieldname:=LAvailable.Items.Strings[LAvailable.ItemIndex];
 if fieldname[1]='[' then
 begin
  index:=Pos(']',fieldname);
  fieldlabels.Add(Copy(fieldname,2,index-1));
  widths.Add(IntToStr(GetFieldWidth(LAvailable.ItemIndex)));
  ftypes.Add(fieldtypes.Strings[LAvailable.ItemIndex]);
  fieldname:='['+ComboDataset.Text+'.'+Copy(fieldname,2,index-1)+']';
 end
 else
 begin
  index:=Pos(' ',fieldname);
  fieldlabels.Add(Copy(fieldname,1,index-1));
  widths.Add(IntToStr(GetFieldWidth(LAvailable.ItemIndex)));
  ftypes.Add(fieldtypes.Strings[LAvailable.ItemIndex]);
  fieldname:=ComboDataset.Text+'.'+Copy(fieldname,1,index-1);
 end;
 LSelected.Items.Add(fieldname);
 if LAvailable.Items.Count-1>LAvailable.ItemIndex then
  LAvailable.ItemIndex:=LAvailable.ItemIndex+1;
end;

function TFRpSelectFields.GetFieldWidth(index:integer):integer;
begin
 Result:=10;
 if Length(fieldsizes[index])>0 then
  Result:=StrToInt(fieldsizes[index]);
end;

procedure TFRpSelectFields.BDeleteDataClick(Sender: TObject);
begin
 if LSelected.ItemIndex<0 then
  exit;
 LSelected.Items.Delete(LSelected.ItemIndex);
 fieldlabels.Delete(LSelected.ItemIndex);
 widths.Delete(LSelected.ItemIndex);
 ftypes.Delete(LSelected.ItemIndex);
end;

end.
