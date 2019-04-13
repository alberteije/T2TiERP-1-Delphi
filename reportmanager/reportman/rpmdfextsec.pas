{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       Rpmdfextsec                                     }
{                                                       }
{       External section properties form                }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpmdfextsec;

interface

uses SysUtils, Classes, QGraphics, QForms, QControls, QStdCtrls,
  QButtons, QExtCtrls,rpmdconsts,rpdatainfo,rpreport,rpsection,
  db,rptypes,rpgraphutils;

type
  TFRpExtSection = class(TForm)
    BOk: TButton;
    BCancel: TButton;
    LConnection: TLabel;
    ComboConnections: TComboBox;
    ComboTable: TComboBox;
    LTable: TLabel;
    ComboReportField: TComboBox;
    Lreportfield: TLabel;
    LSearchField: TLabel;
    ComboSearchField: TComboBox;
    ComboSearchValue: TComboBox;
    LSearchValue: TLabel;
    ComboFormat: TComboBox;
    LPreferedFormat: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure ComboTableDropDown(Sender: TObject);
    procedure ComboReportFieldDropDown(Sender: TObject);
    procedure ComboSearchValueDropDown(Sender: TObject);
  private
    { Private declarations }
    dook:boolean;
    FReport:TRpReport;
    FSection:TRpSection;
    procedure UpdateCombos;
    procedure ValidateRecord;
  public
    { Public declarations }
  end;

function ChangeExternalSectionProps(report:TRpReport;section:TRpSection):Boolean;

implementation

{$R *.xfm}

function ChangeExternalSectionProps(report:TRpReport;section:TRpSection):Boolean;
var
 dia:TFRpExtSection;
begin
 Result:=False;
 dia:=TFRpExtSection.Create(Application);
 try
  dia.FReport:=report;
  dia.FSection:=section;
  dia.UpdateCombos;
  dia.showmodal;
  if dia.dook then
  begin
   Section.ExternalConnection:=Trim(dia.ComboConnections.Text);
   Section.ExternalTable:=Trim(dia.ComboTable.Text);
   Section.ExternalField:=Trim(dia.ComboReportField.Text);
   Section.ExternalSearchField:=Trim(dia.ComboSearchField.Text);
   Section.ExternalSearchValue:=Trim(dia.ComboSearchValue.Text);
   Section.StreamFormat:=TRpStreamFormat(dia.ComboFormat.ItemIndex);
   if Length(Section.GetExternalDataDescription)>0 then
   begin
    section.ExternalFilename:='';
    dia.ValidateRecord;
   end;
   Result:=true;
  end;
 finally
  dia.free;
 end;
end;

procedure TFRpExtSection.FormCreate(Sender: TObject);
begin
 // Load translations
 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
 Caption:=TranslateStr(860,Caption);
 LConnection.Caption:=TranslateStr(154,LConnection.Caption);
 LTable.Caption:=TranslateStr(862,LTable.Caption);
 LReportField.Caption:=TranslateStr(863,LReportField.Caption);
 LSearchField.Caption:=TranslateStr(864,LSearchField.Caption);
 LSearchValue.Caption:=TranslateStr(865,LSearchValue.Caption);

 LPreferedFormat.Caption:=SRpPreferedFormat;
 ComboFormat.Items.Add(SRpStreamZLib);
 ComboFormat.Items.Add(SRpStreamText);
 ComboFormat.Items.Add(SRpStreamBinary);
 ComboFormat.Items.Add(SRpStreamXML);
 ComboFormat.Items.Add(SRpStreamXMLComp);

 SetInitialBounds;
end;

procedure TFRpExtSection.BOkClick(Sender: TObject);
begin
 // Assign properties
 dook:=true;
 Close;
end;


procedure TFRpExtSection.UpdateCombos;
var
 i:integer;
begin
 for i:=0 to FReport.DatabaseInfo.Count-1 do
 begin
  ComboConnections.Items.Add(FReport.DatabaseInfo.Items[i].Alias);
 end;
 ComboConnections.Text:=FSection.ExternalConnection;
 ComboTable.Items.Add(' ');
 ComboReportField.Items.Add(' ');
 ComboSearchField.Items.Add(' ');
 ComboSearchValue.Items.Add(' ');
 ComboTable.Text:=FSection.ExternalTable;
 ComboReportField.Text:=FSection.ExternalField;
 ComboSearchField.Text:=FSection.ExternalSearchField;
 ComboSearchValue.Text:=FSection.ExternalSearchValue;
 ComboFormat.ItemIndex:=integer(FSection.StreamFormat);
end;

procedure TFRpExtSection.ComboTableDropDown(Sender: TObject);
var
 index:integer;
begin
 ComboTable.Items.Clear;
 ComboTable.Items.Add(' ');
 // Search for table names
 index:=Freport.DatabaseInfo.IndexOf(ComboConnections.Text);
 if index>=0 then
 begin
  FReport.DatabaseInfo.Items[index].GetTableNames(ComboTable.Items,FReport.Params);
  if ComboTable.Items.Count<1 then
   ComboTable.Items.Add(' ');
 end;
end;

procedure TFRpExtSection.ComboReportFieldDropDown(Sender: TObject);
var
 index:integer;
 sqlsentence:String;
 adata:TDataset;
begin
 TComboBox(Sender).Items.Clear;
 TComboBox(Sender).Items.Add(' ');

 // Search for Field names
 index:=Freport.DatabaseInfo.IndexOf(ComboConnections.Text);
 if index<0 then
  exit;
 if Length(Trim(ComboTable.Text))<1 then
  exit;
 sqlsentence:='SELECT * FROM '+ComboTable.Text;
 adata:=FReport.DatabaseInfo.Items[index].OpenDatasetFromSQL(sqlsentence,nil,false,FReport.Params);
 try
  adata.GetFieldNames(TComboBox(Sender).Items);
 finally
  adata.Free;
 end;
 if (TComboBox(Sender).Items.Count<1) then
  TComboBox(Sender).Items.Add(' ');
end;

procedure TFRpExtSection.ComboSearchValueDropDown(Sender: TObject);
var
 index:integer;
 sqlsentence:String;
 adata:TDataset;
begin
 TComboBox(Sender).Items.Clear;
 TComboBox(Sender).Items.Add(' ');

 // Search for Field names
 index:=Freport.DatabaseInfo.IndexOf(ComboConnections.Text);
 if index<0 then
  exit;
 if Length(Trim(ComboTable.Text))<1 then
  exit;
 if Length(Trim(ComboSearchField.Text))<1 then
  exit;
 sqlsentence:='SELECT '+ComboSearchField.Text+' FROM '+ComboTable.Text+
  ' ORDER BY '+ComboSearchField.Text;
 adata:=FReport.DatabaseInfo.Items[index].OpenDatasetFromSQL(sqlsentence,nil,false,FReport.Params);
 try
  TComboBox(Sender).Items.Clear;
  while Not adata.Eof do
  begin
   TComboBox(Sender).Items.Add(adata.Fields[0].AsString);
   adata.Next;
  end;
 finally
  adata.Free;
 end;
 if (TComboBox(Sender).Items.Count<1) then
  TComboBox(Sender).Items.Add(' ');
end;

procedure TFRpExtSection.ValidateRecord;
var
 index:integer;
 sqlsentence:String;
 adata:TDataset;
 aparam:TRpParamObject;
 alist:TStringList;
begin
 // Select the field from the database
 index:=Freport.DatabaseInfo.IndexOf(ComboConnections.Text);
 if index<0 then
  exit;
 if Length(Trim(ComboTable.Text))<1 then
  exit;
 if Length(Trim(ComboSearchField.Text))<1 then
  exit;
 sqlsentence:='SELECT '+ComboSearchField.Text+' FROM '+ComboTable.Text+
  ' WHERE '+ComboSearchField.Text+'=:'+ComboSearchField.Text;
 alist:=TStringlist.Create;
 try
  aparam:=TRpParamObject.Create;
  try
   aparam.Value:=ComboSearchValue.Text;
   alist.AddObject(ComboSearchField.Text,aparam);
   adata:=FReport.DatabaseInfo.Items[index].OpenDatasetFromSQL(sqlsentence,alist,false,FReport.Params);
   try
    if adata.eof then
    begin
     // Ask if create record
     if smbYes=rpMessageBox(SRpRecordnotExists,SRpWarning,
      [smbYes,smbNo],smsWarning,smbYes,smbNo) then
     begin
      sqlsentence:='INSERT INTO '+ComboTable.Text+'('+
       ComboSearchField.Text+') VALUES (:'
       +ComboSearchField.Text+')';
      FReport.DatabaseInfo.Items[index].OpenDatasetFromSQL(sqlsentence,alist,true,FReport.Params);
      FSection.SaveExternal;
     end;
    end
    else
    begin
     if smbYes=rpMessageBox(SRpLoadSection,SRpWarning,
      [smbYes,smbNo],smsWarning,smbYes,smbNo) then
     begin
      FSection.LoadExternal;
     end;
    end;
   finally
    adata.free;
   end;
  finally
   aparam.free;
  end;
 finally
  alist.free;
 end;
end;



end.
