{*******************************************************}
{                                                       }
{       Main form of RPTranslate application            }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,rptranslator, DBCtrls, Grids, DBGrids, Db, DBClient, Menus,
  ActnList, ExtCtrls, ToolWin, ComCtrls,Consts, ImgList, rpeval,
  clipbrd,rpmdconsts,comobj, rptypes;


resourcestring
 SRptExitNoSave='Exit without saving?';
 SRpErrorOpeningKey='Error opening language list key';
 SRpIncorrectHexNumber='Incorrect hexadecimal number in registry';
type
  TFMain = class(TForm)
    DTexts: TClientDataSet;
    DTextsPOSITION: TIntegerField;
    DTextsTEXT: TWideStringField;
    STexts: TDataSource;
    ActionList1: TActionList;
    AOpen: TAction;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    OpenDialog1: TOpenDialog;
    ASaveas: TAction;
    SaveDialog1: TSaveDialog;
    Saveas1: TMenuItem;
    ANew: TAction;
    New1: TMenuItem;
    AAllowInsert: TAction;
    ToolBar1: TToolBar;
    PParent: TPanel;
    DBMemo1: TDBMemo;
    GridEdit: TDBGrid;
    Options1: TMenuItem;
    AllowInsert1: TMenuItem;
    Splitter1: TSplitter;
    ASave: TAction;
    ToolButton1: TToolButton;
    AExit: TAction;
    Save1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    StatusBar1: TStatusBar;
    N2: TMenuItem;
    AMerge: TAction;
    Merge1: TMenuItem;
    Utilities1: TMenuItem;
    AShowLangInfo: TAction;
    Languageinformation1: TMenuItem;
    ImageList1: TImageList;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    APaste: TAction;
    RpEvaluator1: TRpEvaluator;
    MEdit: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    Paste1: TMenuItem;
    Proces1: TMenuItem;
    ASearch: TAction;
    ToolButton8: TToolButton;
    Search1: TMenuItem;
    DTextsDESCRIPTION: TStringField;
    AOpenDesc: TAction;
    ASaveDesc: TAction;
    DDescriptions: TClientDataSet;
    DDescriptionsPOSITION: TIntegerField;
    DDescriptionsDESCRIPTION: TStringField;
    N3: TMenuItem;
    Opendescriptions1: TMenuItem;
    Savedescriptions1: TMenuItem;
    OpenDialogDesc: TOpenDialog;
    SaveDialogDesc: TSaveDialog;
    POrderBy: TPanel;
    ComboOrder: TComboBox;
    FindDialog1: TReplaceDialog;
    DTextsORIGINAL: TWideStringField;
    AExcelEx: TAction;
    Exporttoexcel1: TMenuItem;
    procedure AOpenExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ASaveasExecute(Sender: TObject);
    procedure ANewExecute(Sender: TObject);
    procedure DTextsAfterOpen(DataSet: TDataSet);
    procedure DTextsNewRecord(DataSet: TDataSet);
    procedure AAllowInsertExecute(Sender: TObject);
    procedure DTextsBeforeInsert(DataSet: TDataSet);
    procedure AExitExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ASaveExecute(Sender: TObject);
    procedure DTextsAfterPost(DataSet: TDataSet);
    procedure GridEditDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure AMergeExecute(Sender: TObject);
    procedure AShowLangInfoExecute(Sender: TObject);
    procedure APasteExecute(Sender: TObject);
    procedure Proces1Click(Sender: TObject);
    procedure ASearchExecute(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure AOpenDescExecute(Sender: TObject);
    procedure ASaveDescExecute(Sender: TObject);
    procedure ComboOrderClick(Sender: TObject);
    procedure FindDialog1Replace(Sender: TObject);
    procedure AExcelExExecute(Sender: TObject);
  private
    { Private declarations }
    atrans:TRpTransLator;
    modified:boolean;
    reading:boolean;
    currentfilename:string;
    formcaption:Widestring;
    procedure Saveas(filename:String;filterindex:integer);
    procedure AppHint(Sender:TObject);
    procedure CheckSaved;
    procedure UpdateDescriptions;
  public
    { Public declarations }
   formtrans:TRpTransLator;
  end;

var
  FMain: TFMain;

implementation

uses uflanginfo, Math;



{$R *.DFM}

procedure TFMain.AOpenExecute(Sender: TObject);
var
 i:integer;
begin
 CheckSaved;
 if OpenDialog1.Execute then
 begin
  atrans.Active:=false;
  atrans.Filename:=OpenDialog1.FileName;
  atrans.AutoLocale:=false;
  atrans.Active:=true;
  ComboOrder.ItemIndex:=0;
  ComboOrderClick(Self);
  DTexts.DisableControls;
  try
   // Gets the strings
   DTexts.Close;
   DTexts.CreateDataSet;
   reading:=true;
   try
    for i:=0 to atrans.StringCount-1 do
    begin
     DTexts.Append;
     DTextsText.Value:=atrans.Strings[i];
     DTextsOriginal.Value:=DTextsText.Value;
     DTexts.Post;
    end;
    UpdateDescriptions;
    PParent.Visible:=true;
    currentfilename:=OpenDialog1.Filename;
    Caption:=formcaption+'-'+currentfilename;
    modified:=false;
    ASave.Enabled:=True;
    AMerge.Enabled:=True;
    ASaveAs.Enabled:=True;
    APaste.Enabled:=True;
    ASearch.Enabled:=True;
    AAllowInsert.Checked:=False
   finally
    reading:=false;
   end;
  finally
   DTexts.Enablecontrols;
  end;
 end;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
 atrans:=TRpTransLator.Create(Self);
 formtrans:=TRpTransLator.Create(Self);
 formtrans.filename:='rptranslateres';
 formtrans.Active:=true;
 Application.Title:=formtrans.LoadString(10,Application.Title);
 ANew.Caption:=formtrans.LoadString(0,ANew.Caption);
 ANew.Hint:=formtrans.LoadString(1,ANew.Hint);
 AOpen.Caption:=formtrans.LoadString(2,AOpen.Caption);
 AOpen.Hint:=formtrans.LoadString(3,AOpen.hint);
 ASave.Caption:=formtrans.LoadString(4,ASave.Caption);
 ASave.Hint:=formtrans.LoadString(5,ASave.Hint);
 ASaveAs.Caption:=formtrans.LoadString(6,ASaveAs.Caption);
 ASaveAs.Hint:=formtrans.LoadString(7,ASaveAs.Hint);
 AExit.Caption:=formtrans.LoadString(8,AExit.Caption);
 AExit.Hint:=formtrans.LoadString(9,AExit.Hint);
 Caption:=formtrans.LoadString(10,Caption);
 Application.Title:=Caption;
 File1.Caption:=formtrans.LoadString(11,File1.Caption);
 Options1.Caption:=formtrans.LoadString(12,Options1.Caption);
 AAllowInsert.Caption:=formtrans.LoadString(13,AAllowInsert.Caption);
 AAllowInsert.Hint:=formtrans.LoadString(14,AAllowInsert.Hint);
 AMerge.Caption:=formtrans.LoadString(15,AMerge.Caption);
 AMerge.Hint:=formtrans.LoadString(16,AMerge.Hint);
 GridEdit.Columns.Items[0].Title.Caption:=formtrans.LoadString(17,GridEdit.Columns.Items[0].Title.Caption);
 GridEdit.Columns.Items[1].Title.Caption:=formtrans.LoadString(18,GridEdit.Columns.Items[1].Title.Caption);
 formcaption:=Caption;
 Utilities1.Caption:=formtrans.LoadString(28,Utilities1.Caption);
 AShowLangInfo.Caption:=formtrans.LoadString(29,AShowLangInfo.Caption);
 AShowLangInfo.Hint:=formtrans.LoadString(30,AShowLangInfo.Hint);
 MEdit.Caption:=formtrans.LoadString(31,MEdit.Caption);
 APaste.Caption:=formtrans.LoadString(32,APaste.Caption);
 APaste.Hint:=formtrans.LoadString(33,Apaste.Hint);
 ASearch.Caption:=formtrans.LoadString(34,ASearch.Caption);
 ASearch.Hint:=formtrans.LoadString(35,ASearch.Hint);

 Application.OnHint:=AppHint;
end;


procedure TFMain.Saveas(filename:String;filterindex:integer);
var
 memstream:TMemoryStream;
 i:integer;
 astring:WideString;
 nstring,partial:string;
 deststring:WideString;
 achar:Widechar;
 conta:integer;
begin
 ComboOrder.ItemIndex:=0;
 ComboOrderClick(Self);
 DTexts.CheckBrowseMode;
 DTexts.DisableControls;
 try
  if (filterindex=2) then
  begin
   memstream:=TMemoryStream.Create;
   try
     nstring:=ChangeFileExt(ExtractFileName(filename),'')+' RCDATA'+#13+#10;
     WriteStringToStream(nstring,memstream);
     nstring:='BEGIN'+#13+#10;
     WriteStringToStream(nstring,memstream);
     DTexts.First;
     while Not DTexts.Eof do
     begin
      astring:=DTextsTEXT.Value;
      deststring:='';
      for i:=1 to Length(astring) do
      begin
       deststring:=deststring+astring[i];
       if astring[i]=#10 then
        deststring:=deststring+#10;
      end;
      DTexts.Next;
      if Not DTexts.Eof then
       deststring:=deststring+#10;
      nstring:='';
      conta:=0;
      // Write deststring coded
      for i:=1 to Length(deststring) do
      begin
       achar:=deststring[i];
       if (nstring<>'') then
        nstring:=nstring+',';
       if (conta>80) then
       begin
        nstring:=nstring+#13+#10;
        conta:=0;
       end;
       partial:='0x'+IntToHex(Integer(achar),2);
       conta:=conta+Length(partial);
       nstring:=nstring+partial;
      end;
      nstring:=nstring+#13+#10;
      memstream.Write(nstring[1],Length(nstring));
     end;
     nstring:=#13+#10+'END'+#13+#10;
     WriteStringToStream(nstring,memstream);
     memstream.SaveToFile(filename);
   finally
    memstream.Free;
   end;
  end
  else
  begin
   // Saves the strings to the resource file
   memstream:=TMemoryStream.Create;
   try
     DTexts.First;
     while Not DTexts.Eof do
     begin
      astring:=DTextsTEXT.Value;
      deststring:='';
      for i:=1 to Length(astring) do
      begin
       deststring:=deststring+astring[i];
       if astring[i]=#10 then
        deststring:=deststring+#10;
      end;
      DTexts.Next;
      if Not DTexts.Eof then
       deststring:=deststring+#10;
      memstream.Write(deststring[1],Length(deststring)*2);
     end;
     memstream.SaveToFile(filename);
   finally
    memstream.Free;
   end;
  end;
  modified:=false;
  ASave.Enabled:=True;
  AMerge.Enabled:=True;
  ASaveAs.Enabled:=True;
  APaste.Enabled:=True;
  ASearch.Enabled:=True;
  CurrentFilename:=filename;
  Caption:=FormCaption+'-'+CurrentFilename;
  finally
   DTexts.EnableControls;
  end;
end;

procedure TFMain.ASaveasExecute(Sender: TObject);
begin
 if Not SaveDialog1.Execute then
  exit;
 SaveAs(SaveDialog1.Filename,SaveDialog1.FilterIndex);
end;

procedure TFMain.ANewExecute(Sender: TObject);
begin
 CheckSaved;
 DTexts.Close;
 CurrentFileName:='';
 Caption:=FormCaption;
 DTexts.CreateDataSet;
 ASave.Enabled:=False;
 AMerge.Enabled:=True;
 ASaveAs.Enabled:=True;
 APaste.Enabled:=True;
 ASearch.Enabled:=True;
 modified:=false;
 PParent.Visible:=true;
 AAllowInsert.Checked:=True;
end;

procedure TFMain.DTextsAfterOpen(DataSet: TDataSet);
begin
 DTexts.LogChanges:=false;
end;

procedure TFMain.DTextsNewRecord(DataSet: TDataSet);
begin
 DTextsPOSITION.Value:=DTexts.RecordCount;
end;

procedure TFMain.AAllowInsertExecute(Sender: TObject);
begin
 AAllowInsert.Checked:=Not AAllowInsert.Checked;
end;

procedure TFMain.DTextsBeforeInsert(DataSet: TDataSet);
begin
 if not reading then
  if Not AAllowInsert.Checked then
   Abort;
end;

procedure TFMain.AExitExecute(Sender: TObject);
begin
 Close;
end;

procedure TFMain.CheckSaved;
begin
 if Not DTexts.Active then
  exit;
 DTexts.CheckBrowseMode;
 if modified then
 begin
  if mrcancel=MessageDlg(formtrans.LoadString(19,SRptExitNoSave),mtWarning,[mbOk,mbCancel],0) then
   Abort;
 end;
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CheckSaved;
end;

procedure TFMain.ASaveExecute(Sender: TObject);
begin
 if Length(currentfilename)<1 then
  exit;
 SaveAs(CurrentFilename,1);
end;

procedure TFMain.DTextsAfterPost(DataSet: TDataSet);
begin
 modified:=true;
end;

procedure TFMain.GridEditDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
 if Column.Field.FieldName='POSITION' then
 begin
  GridEdit.Canvas.Brush.Color:=clInfoBk;
 end;
 GridEdit.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TFMain.AppHint(Sender:TObject);
begin
 StatusBar1.Panels[0].Text:=Application.Hint;
end;

procedure TFMain.AMergeExecute(Sender: TObject);
var
 asource:TRpTranslator;
 i:integer;
 oldallow:boolean;
begin
 if Not DTexts.Active then
  exit;
 DTexts.CheckBrowseMode;
 ComboOrder.ItemIndex:=0;
 ComboOrderClick(Self);

 if OpenDialog1.Execute then
 begin
  asource:=TRpTransLator.Create(Application);
  try
   asource.AutoLocale:=false;
   asource.Filename:=OpenDialog1.FileName;
   asource.Active:=true;

   oldAllow:=AAllowInsert.Checked;
   try
    AAllowInsert.Checked:=True;
    DTexts.Disablecontrols;
    try
     for i:=DTexts.RecordCount to asource.StringCount-1 do
     begin
      DTexts.Append;
      DTextsTEXT.Value:=asource.Strings[i];
      DTextsORIGINAL.Value:=asource.Strings[i];
      DTexts.Post;
     end;
     // Now set original values
     i:=0;
     DTexts.First;
     while Not DTexts.Eof do
     begin
      DTexts.Edit;
      DTextsORIGINAL.Value:=asource.Strings[i];
      DTexts.Post;

      DTexts.Next;
      inc(i);
     end;
    finally
     DTexts.EnableControls;
    end;
   finally
    AAllowInsert.Checked:=oldAllow;
   end;
  finally
   asource.free;
  end;
 end;
end;

procedure TFMain.AShowLangInfoExecute(Sender: TObject);
begin
 ShowLangInfo;
end;

procedure TFMain.APasteExecute(Sender: TObject);
var
 alist,alist2:TStringList;
 astring:string;
 identifier:string;
 i,index:integer;
begin
 DTexts.CheckBrowseMode;
 if Clipboard.HasFormat(CF_TEXT) then
 begin
  alist:=TStringList.Create;
  alist2:=TStringList.Create;
  try
   alist.text:=Clipboard.AsText;
   DTexts.Disablecontrols;
   try
    for i:=0 to alist.count-1 do
    begin
     if (Not AAllowInsert.Checked) then
      AAllowInsert.Checked:=True;
     astring:=alist.strings[i];
     index:=Pos('=',astring);
     if index>0 then
     begin
      astring:=Copy(astring,index+1,Length(astring));
      astring:=Trim(astring);
      if astring[Length(astring)]=';' then
       astring[Length(astring)]:=' ';
      astring:=RpEvaluator1.EvaluateText(astring);
      identifier:=alist.strings[i];
      index:=Pos(':',identifier);
      if index>0 then
      begin
       identifier:=Trim(Copy(identifier,1,index-1));
      end
      else
       identifier:='';
     end;
     DTexts.Append;
     try
      DTextsTEXT.Text:=astring;
      DTExts.Post;
      if Length(identifier)>0 then
      begin
       identifier:=' TranslateVar('+DTextsPOSITION.AsString+','+Identifier+');';
       alist2.add(identifier);
      end;
     except
      DTexts.Cancel;
     end;
    end;
    if alist2.count>0 then
    begin
     clipboard.AsText:=alist2.Text;
    end;
   finally
    DTexts.EnableControls;
   end;
  finally
   alist.free;
   alist2.free;
  end;
 end;
end;

procedure TFMain.Proces1Click(Sender: TObject);
var
 alist:TStringList;
 i,index:integer;
 alist2:TStringList;
 astring:string;
begin
 alist:=TStringList.Create;
 alist2:=TStringList.Create;
 try
  alist.Text:=clipboard.AsText;
  for i:=0 to alist.count-1 do
  begin
   astring:=alist.strings[i];
   index:=Pos('=',astring);
   if index>0 then
   begin
    astring:=Copy(astring,1,index-1)+':WideString'+Copy(astring,index,Length(astring));
    alist2.Add(astring);
   end;
  end;
  clipboard.AsText:=alist2.Text;
 finally
  alist.Free;
  alist2.Free;
 end;
end;

procedure TFMain.ASearchExecute(Sender: TObject);
begin
 ComboOrder.ItemIndex:=0;
 ComboOrderClick(Self);
 // Ask the texts
 FindDialog1.Options:=FindDialog1.Options-[frReplace];
 FindDialog1.Execute;
end;

procedure TFMain.FindDialog1Find(Sender: TObject);
var
 iseof:boolean;
 index:integer;
begin
 DTexts.CheckBrowseMode;
 iseof:=true;
 DTexts.DisableControls;
 try
  if Not DTexts.Bof then
   DTexts.Next;
  While Not DTexts.Eof do
  begin
   index:=Pos(UpperCase(FindDialog1.FindText),UpperCase(DTextsTEXT.AsString));
   if index>0 then
   begin
    iseof:=false;
    GridEdit.SelectedField:=DTextsTEXT;
    break;
   end;
   DTexts.Next;
  end;
  if iseof then
   Raise Exception.Create(SRpNotFound);
 finally
  DTexts.EnableControls;
 end;
end;

procedure TFMain.AOpenDescExecute(Sender: TObject);
begin
 If OpenDialogDesc.Execute then
 begin
  DDescriptions.Close;
  DDescriptions.LoadFromFile(OpenDialogDesc.Filename);
  UpdateDescriptions;
 end;
end;

procedure TFMain.UpdateDescriptions;
begin
 if Not DTexts.Active then
  exit;
 if Not DDescriptions.Active then
  DDescriptions.CreateDataset;
 DTexts.DisableControls;
 try
  DTexts.First;
  while Not DTexts.Eof do
  begin
   if DDescriptions.FindKey([DTextsPOSITION.AsInteger]) then
   begin
    DTexts.Edit;
    try
     DTextsDESCRIPTION.Value:=DDescriptionsDESCRIPTION.AsString;
     DTexts.Post;
    except
     DTexts.Cancel;
     Raise;
    end;
   end;
   DTexts.Next;
  end;
 finally
  DTexts.EnableControls;
 end;
end;

procedure TFMain.ASaveDescExecute(Sender: TObject);
begin
 if Not SaveDialogDesc.Execute then
  exit;
 // Saves de descriptions
 DDescriptions.Close;
 DDescriptions.CreateDataset;
 DTexts.DisableControls;
 try
  DTexts.First;
  while Not DTexts.Eof do
  begin
   if Length(Trim(DTextsDESCRIPTION.AsString))>0 then
   begin
    DDescriptions.AppendRecord([DTextsPOSITION.AsInteger,DTextsDESCRIPTION.AsString]);
   end;
   DTexts.Next;
  end;
  DDescriptions.SaveToFile(SaveDialogDesc.Filename,dfXML);
 finally
  DTexts.EnableControls;
 end;
end;

procedure TFMain.ComboOrderClick(Sender: TObject);
begin
 if ComboOrder.ItemIndex=0 then
  DTexts.IndexFieldNames:='POSITION'
 else
  DTexts.IndexFieldNames:='ORIGINAL';
end;

procedure TFMain.FindDialog1Replace(Sender: TObject);
var
 iseof:boolean;
 index:integer;
begin
 DTexts.CheckBrowseMode;
 iseof:=true;
 DTexts.DisableControls;
 try
  if Not DTexts.Bof then
   DTexts.Next;
  While Not DTexts.Eof do
  begin
   index:=Pos(UpperCase(FindDialog1.FindText),UpperCase(DTextsTEXT.AsString));
   if index>0 then
   begin
    iseof:=false;
    GridEdit.SelectedField:=DTextsTEXT;
    DTexts.Edit;
    try
     DTextsTEXT.Value:=StringReplace(DTextsTEXT.Value,FindDialog1.FindText,
      FindDialog1.ReplaceText,[rfReplaceAll, rfIgnoreCase]);
     DTexts.Post;
    except
     DTexts.Cancel;
     raise;
    end;
   end;
   if (Not (frReplaceAll in FindDialog1.Options)) then
    break;
   DTexts.Next;
  end;
  if iseof then
   Raise Exception.Create(SRpNotFound);
 finally
  DTexts.EnableControls;
 end;
end;


procedure TFMain.AExcelExExecute(Sender: TObject);
var
 excel,wb,sh:Variant;
 shcount,index:integer;
begin
 DTexts.CheckBrowseMode;
 DTexts.DisableControls;
 try
  Excel:=CreateOleObject('excel.application');
  Excel.Visible:=Visible;
  wb:=Excel.Workbooks.Add;
  shcount:=1;
  sh:=wb.Worksheets.item[shcount];
  index:=1;
  DTexts.First;
  while Not DTexts.Eof do
  begin
   sh.Cells.Item[index,'A']:=DTextsPOSITION.AsString;
   sh.Cells.Item[index,'B']:=DTextsTEXT.AsString;
   sh.Cells.Item[index,'C']:=DTextsDESCRIPTION.AsString;
   DTexts.Next;
   inc(index);
  end;
 finally
  DTexts.EnableControls
 end;
end;

initialization


end.
