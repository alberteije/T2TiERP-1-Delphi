{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfdatatext                                   }
{       Form for configuration of report datasets       }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpmdfdatatext;

interface

{$I rpconf.inc}

uses SysUtils, Classes, QGraphics, QForms,
  QStdCtrls,rptypes,
  QDialogs,rpdatatext,rpmdconsts,
{$IFDEF USEVARIANTS}
 Variants,Types,
{$ENDIF}
  rpparams,rpfparams, db,rpgraphutils, DBClient, QGrids,
  QDBGrids, QActnList, QImgList, QComCtrls, QControls, QExtCtrls;

type
  TFRpDataText = class(TForm)
    PTop: TPanel;
    LFieldsFile: TLabel;
    EFileName: TEdit;
    LSampleFile: TLabel;
    ESampleFile: TEdit;
    PClient: TPanel;
    ActionList1: TActionList;
    ANewField: TAction;
    ADelete: TAction;
    PList: TPanel;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton5: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    PBottom: TPanel;
    PFieldProps: TPanel;
    DFields: TClientDataSet;
    SData: TDataSource;
    PControl: TPageControl;
    TabSource: TTabSheet;
    TabData: TTabSheet;
    GridTest: TDBGrid;
    MSource: TMemo;
    BTest: TButton;
    Label4: TLabel;
    Label3: TLabel;
    ERecordseparator: TEdit;
    EIgnoreAfterRecordseparator: TEdit;
    GridFields: TDBGrid;
    Splitter1: TSplitter;
    DData: TClientDataSet;
    SFiedls: TDataSource;
    DDataType: TClientDataSet;
    DDataTypeCODE: TIntegerField;
    DFieldsFIELDNAME: TStringField;
    DFieldsFIELDTYPE: TIntegerField;
    BOK: TButton;
    DDataTypeDESCRIPTION: TStringField;
    DFieldsFIELDTYPENAME: TStringField;
    DFieldsFIELDSIZE: TIntegerField;
    DFieldsPRECISION: TIntegerField;
    DFieldsPOSBEGINPRECISION: TIntegerField;
    DFieldsFIELDTRIM: TBooleanField;
    DYesNo: TClientDataSet;
    DYesNoCODE: TBooleanField;
    DYesNoDESCRIPTION: TStringField;
    DFieldsTRIM: TStringField;
    DFieldsYEARPOS: TIntegerField;
    DFieldsYEARSIZE: TIntegerField;
    DFieldsMONTHPOS: TIntegerField;
    DFieldsMONTHSIZE: TIntegerField;
    DFieldsDAYPOS: TIntegerField;
    DFieldsDAYSIZE: TIntegerField;
    DFieldsHOURPOS: TIntegerField;
    DFieldsHOURSIZE: TIntegerField;
    DFieldsMINPOS: TIntegerField;
    DFieldsMINSIZE: TIntegerField;
    DFieldsSECPOS: TIntegerField;
    DFieldsSECSIZE: TIntegerField;
    DFieldsPOSBEGIN: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ANewFieldExecute(Sender: TObject);
    procedure ADeleteExecute(Sender: TObject);
    procedure DFieldsNewRecord(DataSet: TDataSet);
    procedure BTestClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    lfields:TStringList;
    filename:String;
    samplefile:String;
    procedure DoSave;
    procedure ReadFromFile;
    procedure FillList;
    procedure ConvertToLFields;
  public
    { Public declarations }
  end;

procedure ShowDataTextConfig(filename,samplefile:String);

implementation


{$R *.xfm}

procedure ShowDataTextConfig(filename,samplefile:String);
var
 dia:TFRpDataText;
begin
 if Length(Trim(filename))<1 then
  Raise Exception.Create(SRpFieldsFileNotDefined);
 dia:=TFRpDataText.Create(Application);
 try
  dia.filename:=filename;
  dia.samplefile:=samplefile;
  dia.ESampleFile.Text:=samplefile;
  if (Length(Trim(samplefile))>0) then
  begin
   dia.BTest.Visible:=True;
  end
  else
   dia.BTest.Visible:=False;
  dia.EFileName.Text:=filename;
  dia.showmodal;
 finally
  dia.free;
 end;
end;

procedure TFRpDataText.FormCreate(Sender: TObject);
begin
 Caption:=TranslateStr(1088,Caption);
 BOK.Caption:=SRpOk;

 lfields:=TStringList.Create;
 DDataType.CreateDataset;
 DDataType.AppendRecord([Integer(ftInteger),AnsiString(SRpSInteger)]);
 DDataType.AppendRecord([Integer(ftString),AnsiString(SRpSString)]);
 DDataType.AppendRecord([Integer(ftCurrency),AnsiString(SRpSCurrency)]);
 DDataType.AppendRecord([Integer(ftDate),AnsiString(SRpSDate)]);
 DDataType.AppendRecord([Integer(ftTime),AnsiString(SRpSTime)]);
 DDataType.AppendRecord([Integer(ftDateTime),AnsiString(SRpSDateTime)]);
 DDataType.AppendRecord([Integer(ftBoolean),AnsiString(SRpSBoolean)]);
 DDataType.AppendRecord([Integer(ftMemo),AnsiString(SRpSMemo)]);
 // Translation
// LRange.Caption:=TranslateStr(833,LRange.Caption);
 DYesNo.CreateDataset;
 DYesNo.AppendRecord([True,AnsiString(SRpYes)]);
 DYesNo.AppendRecord([False,AnsiString(SRpNo)]);

 LFieldsFile.Caption:=TranslateStr(1085,LFieldsFile.Caption);
 LSampleFile.Caption:=TranslateStr(1087,LSampleFile.Caption);
 Label3.Caption:=TranslateStr(1089,Label3.Caption);
 Label4.Caption:=TranslateStr(1090,Label4.Caption);
 BTest.Caption:=TranslateStr(42,BTest.Caption);
 ANewField.Caption:=TranslateStr(1091,ANewField.Caption);
 ANewField.Hint:=TranslateStr(1092,ANewField.Hint);
 ADelete.Caption:=TranslateStr(1093,ADelete.Caption);
 ADelete.Hint:=TranslateStr(1094,ADelete.Hint);
 TabData.Caption:=TranslateStr(1094,TabData.Caption);
 TabSource.Caption:=TranslateStr(1095,TabSource.Caption);

 SetInitialBounds;
end;


procedure TFRpDataText.ReadFromFile;
var
 recordseparator:char;
 ignoreafterrecordseparator:char;
begin
 FillFieldObjList(filename,lfields,
  recordseparator,ignoreafterrecordseparator);
 ERecordSeparator.Text:=IntToStr(Ord(recordseparator));
 EIgnoreAfterRecordSeparator.Text:=IntToStr(Ord(ignoreafterrecordseparator));
end;

procedure TFRpDataText.FillList;
var
 i:integer;
 aobj:TRpFieldObj;
begin
 DFields.Close;
 DFields.CreateDataset;
 for i:=0 to lfields.count-1 do
 begin
  aobj:=TRpFieldObj(lfields.Objects[i]);
  DFields.Append;
  try
   DFieldsFIELDNAME.AsString:=aobj.fieldname;
   DFieldsFIELDTYPE.AsInteger:=Integer(aobj.FieldType);
   DFieldsPOSBEGIN.AsInteger:=aobj.Posbegin;
   DFieldsFIELDSIZE.AsInteger:=aobj.Fieldsize;
   DFieldsPRECISION.AsInteger:=aobj.Precision;
   DFieldsPOSBEGINPRECISION.AsInteger:=aobj.PosBeginPrecision;
   DFieldsFIELDTRIM.AsBoolean:=aobj.fieldtrim;
   DFieldsYEARPOS.AsInteger:= aobj.yearpos;
   DFieldsYEARSIZE.AsInteger:=aobj.yearsize;
   DFieldsMONTHPOS.AsInteger:=aobj.monthpos;
   DFieldsMONTHSIZE.AsInteger:=aobj.monthsize;
   DFieldsDAYPOS.AsInteger:=aobj.daypos;
   DFieldsDAYSIZE.AsInteger:=aobj.daysize;
   DFieldsDAYPOS.AsInteger:=aobj.daypos;
   DFieldsDAYSIZE.AsInteger:=aobj.daysize;
   DFieldsHOURPOS.AsInteger:=aobj.hourpos;
   DFieldsHOURSIZE.AsInteger:=aobj.hoursize;
   DFieldsMINPOS.AsInteger:=aobj.minpos;
   DFieldsMINSIZE.AsInteger:=aobj.minsize;
   DFieldsSECPOS.AsInteger:=aobj.secpos;
   DFieldsSECSIZE.AsInteger:=aobj.secsize;
   DFields.Post;
  except
   DFields.Cancel;
   raise;
  end;
 end;
end;


procedure TFRpDataText.FormShow(Sender: TObject);
begin
 // Reads the fields from the filename
 ReadFromFile;
 FillList;
 if BTest.Visible then
  MSource.Lines.LoadFromFile(samplefile);
end;

procedure TFRpDataText.ConvertToLFields;
var
 aobj:TRpFieldObj;
begin
 FreeFieldObjList(lfields);
 lfields.Clear;
 DFields.CheckBrowseMode;
 DFields.First;
 while Not DFields.Eof do
 begin
  aobj:=TRpFieldObj.Create;
  aobj.fieldname:=DFieldsFIELDNAME.AsString;
  aobj.FieldType:=TFieldType(DFieldsFIELDTYPE.AsInteger);
  aobj.Fieldsize:=DFieldsFIELDSIZE.AsInteger;
  aobj.Precision:=DFieldsPRECISION.AsInteger;
  aobj.PosBeginPrecision:=DFieldsPOSBEGINPRECISION.AsInteger;
  aobj.fieldtrim:=DFieldsFIELDTRIM.AsBoolean;
  aobj.yearpos:=DFieldsYEARPOS.AsInteger;
  aobj.yearsize:=DFieldsYEARSIZE.AsInteger;
  aobj.monthpos:=DFieldsMONTHPOS.AsInteger;
  aobj.monthsize:=DFieldsMONTHSIZE.AsInteger;
  aobj.daypos:=DFieldsDAYPOS.AsInteger;
  aobj.daysize:=DFieldsDAYSIZE.AsInteger;
  aobj.daypos:=DFieldsDAYPOS.AsInteger;
  aobj.daysize:=DFieldsDAYSIZE.AsInteger;
  aobj.hourpos:=DFieldsHOURPOS.AsInteger;
  aobj.hoursize:=DFieldsHOURSIZE.AsInteger;
  aobj.minpos:=DFieldsMINPOS.AsInteger;
  aobj.minsize:=DFieldsMINSIZE.AsInteger;
  aobj.secpos:=DFieldsSECPOS.AsInteger;
  aobj.secsize:=DFieldsSECSIZE.AsInteger;
  aobj.Posbegin:=DFieldsPOSBEGIN.AsInteger;

  lfields.AddObject(aobj.fieldname,aobj);
  DFields.Next;
 end;
end;

procedure TFRpDataText.DoSave;
var
 recordseparator:char;
 ignoreafterrecordseparator:char;
begin
 ConvertToLFields;
 try
  recordseparator:=Chr(StrToInt(ERecordSeparator.Text));
 except
  recordseparator:=chr(13);
 end;
 try
  ignoreafterrecordseparator:=Chr(StrToInt(EIgnoreAfterRecordSeparator.Text));
 except
  ignoreafterrecordseparator:=chr(10);
 end;
 SaveFieldObjListToFile(lfields,filename,recordseparator,
  ignoreafterrecordseparator);
end;

procedure TFRpDataText.BOkClick(Sender: TObject);
begin
 DoSave;
 Close;
end;

procedure TFRpDataText.BCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TFRpDataText.FormDestroy(Sender: TObject);
begin
 FreeFieldObjList(lfields);
 lfields.free;
end;


procedure TFRpDataText.ANewFieldExecute(Sender: TObject);
begin
 DFields.Insert;
end;

procedure TFRpDataText.ADeleteExecute(Sender: TObject);
begin
 DFields.Delete;
end;

procedure TFRpDataText.DFieldsNewRecord(DataSet: TDataSet);
begin
 DFieldsPOSBEGIN.AsInteger:=1;
 DFieldsFIELDSIZE.AsInteger:=0;
 DFieldsPRECISION.AsInteger:=0;
 DFieldsPOSBEGINPRECISION.AsInteger:=0;
 DFieldsFIELDTRIM.AsBoolean:=true;
 DFieldsYEARPOS.AsInteger:=0;
 DFieldsYEARSIZE.AsInteger:=0;
 DFieldsMONTHPOS.AsInteger:=0;
 DFieldsMONTHSIZE.AsInteger:=0;
 DFieldsDAYPOS.AsInteger:=0;
 DFieldsDAYSIZE.AsInteger:=0;
 DFieldsDAYPOS.AsInteger:=0;
 DFieldsDAYSIZE.AsInteger:=0;
 DFieldsHOURPOS.AsInteger:=0;
 DFieldsHOURSIZE.AsInteger:=0;
 DFieldsMINPOS.AsInteger:=0;
 DFieldsMINSIZE.AsInteger:=0;
 DFieldsSECPOS.AsInteger:=0;
 DFieldsSECSIZE.AsInteger:=0;
end;

procedure TFRpDataText.BTestClick(Sender: TObject);
begin
 DoSave;
 DData.Close;
 FillClientDatasetFromFile(DData,filename,samplefile,'');
 PControl.ActivePage:=TabData;
end;

procedure TFRpDataText.Button1Click(Sender: TObject);
begin
 DoSave;
 Close;
end;

end.
