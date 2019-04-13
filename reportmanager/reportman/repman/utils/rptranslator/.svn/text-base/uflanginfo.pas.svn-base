unit uflanginfo;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Db, DBClient, Grids, DBGrids,registry,Math, ComCtrls;

type
  TFLangInfo = class(TForm)
    Panel1: TPanel;
    DLang: TClientDataSet;
    DLangEXTENSION: TStringField;
    GridLang: TDBGrid;
    SLang: TDataSource;
    DLangLANGID: TStringField;
    DLangLANGIDBIN: TLargeintField;
    DLangDESCRIPTION: TStringField;
    DLangENGDESC: TStringField;
    LActiveLang: TLabel;
    LSystemLang: TLabel;
    LActiveExt: TLabel;
    LSystemExt: TLabel;
    LActiveName: TLabel;
    LSystemname: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


procedure ShowLangInfo;

implementation

uses umain;

{$R *.DFM}

const
 MAX_BUF=1024;

function HexToDecimal(astring:string):LongWord;
var
 apower,i:integer;

function HexCharToInt(ch:Char):integer;
begin
 if (ch in ['0'..'9']) then
  Result:=Ord(ch)-Ord('0')
 else
 begin
  if (ch in ['A'..'F']) then
   Result:=10+Ord(ch)-Ord('A')
  else
   Raise Exception.Create(fmain.formtrans.LoadString(20,SRpIncorrectHexNumber));
 end;
end;

begin
 Result:=0;
 astring:=Trim(UpperCase(astring));
 apower:=0;
 for i:=Length(astring) downto 1 do
 begin
  Result:=Result+HexCharToInt(astring[i])*Round(Power(16,apower));
  inc(apower);
 end;
end;


procedure ShowLangInfo;
var
 dia:TFLangInfo;
begin
 dia:=TFLangInfo.Create(Application);
 try
  dia.showmodal;
 finally
  dia.free;
 end;
end;


procedure TFLangInfo.FormCreate(Sender: TObject);
var
 areg:TRegistry;
 alist:TStringList;
 langid:LongWord;
 i:integer;
 abuf:array [0..MAX_BUF-1] of char;
begin
 LActiveLang.Caption:=fmain.formtrans.LoadString(21,LActiveLang.Caption);
 LSystemLang.Caption:=fmain.formtrans.LoadString(22,LSystemLang.Caption);
 Caption:=fmain.formtrans.LoadString(23,Caption);
 DLangEXTENSION.DisplayLabel:=fmain.formtrans.LoadString(24,DLangEXTENSION.DisplayLabel);
 DLangDESCRIPTION.DisplayLabel:=fmain.formtrans.LoadString(25,DLangDESCRIPTION.DisplayLabel);
 DLangENGDESC.DisplayLabel:=fmain.formtrans.LoadString(26,DLangENGDESC.DisplayLabel);

 // Get active language
 GetLocaleInfo(LOCALE_USER_DEFAULT,LOCALE_SABBREVLANGNAME,abuf,MAX_BUF);
 LActiveExt.Caption:=StrPas(abuf);
 GetLocaleInfo(LOCALE_USER_DEFAULT,LOCALE_SLANGUAGE,abuf,MAX_BUF);
 LActiveName.Caption:=StrPas(abuf);
 GetLocaleInfo(LOCALE_SYSTEM_DEFAULT,LOCALE_SABBREVLANGNAME,abuf,MAX_BUF);
 LSystemExt.Caption:=StrPas(abuf);
 GetLocaleInfo(LOCALE_SYSTEM_DEFAULT,LOCALE_SLANGUAGE,abuf,MAX_BUF);
 LSystemName.Caption:=StrPas(abuf);
 LSystemName.Font.Style:=[fsbold];
 LSystemExt.Font.Style:=[fsbold];
 LActiveName.Font.Style:=[fsbold];
 LActiveExt.Font.Style:=[fsbold];


 DLang.CreateDataset;
 areg:=TRegistry.Create;
 try
  areg.RootKey:=HKEY_LOCAL_MACHINE;
  if Not areg.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Control\Nls\Locale') then
   Raise Exception.Create(fmain.formtrans.LoadString(27,SRpErrorOpeningKey));
  alist:=TStringList.Create;
  try
   areg.GetValueNames(alist);
   i:=0;
   while i<alist.count do
   begin
    if Length(alist.strings[i])<1 then
     alist.delete(i)
    else
     if alist.Strings[i][1]='(' then
      alist.delete(i)
     else
      inc(i);
   end;
   for i:=0 to alist.count-1 do
   begin
    DLang.Append;
    DLangLangId.Value:=alist.strings[i];
    langid:=HexToDecimal(alist.strings[i]);
    DLangLANGIDBIN.Value:=langid;
    GetLocaleInfo(langid,LOCALE_SABBREVLANGNAME,abuf,MAX_BUF);
    DLangEXTENSION.Value:=StrPas(abuf);
    GetLocaleInfo(langid,LOCALE_SLANGUAGE,abuf,MAX_BUF);
    DLangDESCRIPTION.Value:=StrPas(abuf);
    GetLocaleInfo(langid,LOCALE_SENGLANGUAGE,abuf,MAX_BUF);
    DLangENGDESC.Value:=StrPas(abuf);
    DLang.Post;
   end;
   Dlang.First;
  finally
   alist.free;
  end;
 finally
  areg.free;
 end;
 GridLang.Datasource:=SLang;
end;

end.
