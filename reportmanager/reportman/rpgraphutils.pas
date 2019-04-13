{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpgraphutils                                    }
{       Graphic routines used by report manager         }
{                                                       }
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
unit rpgraphutils;

interface

{$I rpconf.inc}

uses
{$IFDEF MSWINDOWS}
  windows,
{$ENDIF}
  SysUtils,Classes,Types,rptranslator,
  QGraphics, QForms,QButtons, QExtCtrls,QPrinters,
  QControls, QStdCtrls,Qt,QImgList,QComCtrls,
{$IFDEF LINUX}
  Libc,
{$ENDIF}
  rpmdconsts,rpmunits,rptypes;


type
  TRpNodeInfo=class(TObject)
   public
    Node:TTreeNode;
    ReportName:WideString;
    Group_Code:Integer;
    Parent_Group:integer;
    Path:String;
   end;

  TFRpMessageDlg = class(TForm)
    Panel1: TPanel;
    BCancel: TButton;
    BOk: TButton;
    BYes: TButton;
    BNo: TButton;
    LMessage: TLabel;
    BAbort: TButton;
    BRetry: TButton;
    BIgnore: TButton;
    EInput: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BYesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
   Buttonpressed,EscapeButton:TMessageButton;
  public
    { Public declarations }
  end;

procedure DrawGrid (Canvas:TCanvas;XWidth,XHeight,PixelsWidth,PixelsHeight:integer;Color:TColor;lines:boolean;XOffset,YOffset:integer;scale:double);
function twipstopixels(ATwips:integer;Scale:double):integer;
function pixelstotwips(apixels:integer;scale:double):integer;
function FontStyleToInteger (fontstyle:TFontStyles):integer;
function IntegerToFontStyle (intfontstyle:integer):TFontStyles;
function IntegerFontStyleToString (intfontstyle:integer):String;
procedure LoadQtTranslator;
function AlignToGrid(Value:integer;scale:integer):integer;
function AlignToGridPixels(Value:integer;scaletwips:integer;scale:double):integer;
function RpMessageBox (const Text: WideString; const Caption: WideString = '';
  Buttons: TMessageButtons = [QForms.smbOK]; Style: TMessageStyle = QForms.smsInformation;
  Default: TMessageButton = QForms.smbOK; Escape: TMessageButton = QForms.smbCancel): TMessageButton;
function RpInputBox (const ACaption, APrompt, ADefault:WideString ):WideString;
procedure FillTreeView (ATree:TTreeView;alist:TStringList);
function GetFullFileName (ANode:TTreeNode;dirseparator:char):String;

implementation

{$R *.xfm}


{$IFDEF MSWINDOWS}
const
  kernel = 'kernel32.dll';
  OldLocaleOverrideKey = 'Software\Borland\Delphi\Locales';
  NewLocaleOverrideKey = 'Software\Borland\Locales';


function RegOpenKeyEx(hKey: LongWord; lpSubKey: PChar; ulOptions,
  samDesired: LongWord; var phkResult: LongWord): Longint; stdcall;
  external advapi32 name 'RegOpenKeyExA';
function RegQueryValueEx(hKey: LongWord; lpValueName: PChar;
  lpReserved: Pointer; lpType: Pointer; lpData: PChar; lpcbData: Pointer): Integer; stdcall;
  external advapi32 name 'RegQueryValueExA';
{$ENDIF}

function AlignToGrid(Value:integer;scale:integer):integer;
var
 rest:integer;
begin
 Result:=Value div scale;
 rest:=Value mod scale;
 Result:=scale*Result;
 if rest>(scale div 2) then
  Result:=Result+scale;
end;

function AlignToGridPixels(Value:integer;scaletwips:integer;scale:double):integer;
begin
 Value:=pixelstotwips(Value,scale);
 Value:=AlignToGrid(Value,scaletwips);
 Result:=twipstopixels(Value,scale);
end;

procedure DrawGrid(Canvas:TCanvas;XWidth,XHeight,PixelsWidth,PixelsHeight:integer;Color:TColor;lines:boolean;XOffset,YOffset:integer;scale:double);
var
 pixelsperinchx,pixelsperinchy:integer;
 rect:TRect;
 han:QPainterh;
 hanbrush:QBrushH;
 windowwidth,windowheight:integer;
 x,y:integer;
 pixelwidth:integer;
 pixelheight:integer;
 xof,yof:integer;
begin
 if XHeight<=0 then
  exit;
 if XWidth<=0 then
  exit;
 if scale=0 then
  scale:=1;

 Rect.Left:=0;
 Rect.Top:=0;
 Rect.Right:=PixelsWidth+XOffset;
 Rect.Bottom:=PixelsHeight+YOffset;

 if Screen.PixelsPerInch<=0 then
  exit;
 pixelsperinchx:=Round(Screen.PixelsPerInch*scale);
 pixelsperinchy:=Round(Screen.PixelsPerInch*scale);
 xof:=Round(XOffset/pixelsperinchx*TWIPS_PER_INCHESS);
 yof:=Round(YOffset/pixelsperinchy*TWIPS_PER_INCHESS);
 windowwidth:=Round(TWIPS_PER_INCHESS*(rect.right+XOffset)/pixelsperinchx);
 windowheight:=Round(TWIPS_PER_INCHESS*(rect.bottom+YOffset)/pixelsperinchy);
 Canvas.Pen.Color:=Color;
 Canvas.Brush.Color:=Color;
 han:=Canvas.Handle;
 hanbrush:=Canvas.Brush.handle;

 pixelwidth:=Round(TWIPS_PER_INCHESS/pixelsperinchx)+1;
 pixelheight:=Round(TWIPS_PER_INCHESS/pixelsperinchy)+1;

 // Draws the grid
 // Painting of the ruler
 Canvas.start;
 // Get the pixels per inch
 try
  // 1440 points per inches
  QPainter_SetViewport(han,rect.left,rect.top,
   rect.Right,rect.Bottom);
  QPainter_SetWindow(han,rect.left,rect.top,windowwidth
   ,windowheight);
  if lines then
  begin
   x:=xof+XWidth;
   y:=yof+Xheight;
   while ((x<windowwidth) or (y<windowheight)) do
   begin
    if (x<windowwidth) then
    begin
     Canvas.MoveTo(x,yof);
     Canvas.LineTo(x,windowheight);
      x:=x+XWidth;
    end;
    if (y<windowheight) then
    begin
     Canvas.MoveTo(xof,y);
     Canvas.LineTo(windowwidth,y);
     y:=y+XHeight;
    end;
   end;
  end
  else
  begin
   x:=xof+XWidth;
   while (x<windowwidth) do
   begin
    rect.Left:=x;
    rect.Right:=x+pixelwidth;
    y:=yof+XHeight;
    while y<windowheight do
    begin
     rect.Top:=y;
     rect.Bottom:=y+pixelheight;
     QPainter_fillrect(han,@rect,hanbrush);
 //    Canvas.FillRect(rect);
     y:=y+XHeight;
    end;
    x:=x+XWidth;
   end;
  end;
 finally
  Canvas.Stop;
 end;
end;

function twipstopixels(ATwips:integer;Scale:double):integer;
begin
 Result:=Round((ATwips/TWIPS_PER_INCHESS)*Screen.PixelsPerInch*Scale);
end;

function pixelstotwips(apixels:integer;scale:double):integer;
begin
 if scale=0 then
  scale:=1;
 Result:=Round((APixels/(Screen.PixelsPerInch*scale))*TWIPS_PER_INCHESS);
end;


function FontStyleToInteger(fontstyle:TFontStyles):integer;
begin
 Result:=0;
 if (fsBold in fontstyle) then
  Result:=Result or 1;
 if (fsItalic in fontstyle) then
  Result:=Result or (1 shl 1);
 if (fsUnderline in fontstyle) then
  Result:=Result or (1 shl 2);
 if (fsStrikeOut in fontstyle) then
  Result:=Result or (1 shl 3);
end;

function IntegerToFontStyle(intfontstyle:integer):TFontStyles;
begin
 Result:=[];
 if (intfontstyle and 1)>0 then
  include(Result,fsBold);
 if (intfontstyle and (1 shl 1))>0 then
  include(Result,fsItalic);
 if (intfontstyle and (1 shl 2))>0 then
  include(Result,fsUnderline);
 if (intfontstyle and (1 shl 3))>0 then
  include(Result,fsStrikeOut);
end;

function IntegerFontStyleToString(intfontstyle:integer):String;
begin
 Result:='[';
 if (intfontstyle and 1)>0 then
  Result:=Result+SRpBold+',';
 if (intfontstyle and (1 shl 1))>0 then
  Result:=Result+SRpItalic+',';
 if (intfontstyle and (1 shl 2))>0 then
  Result:=Result+SRpUnderline+',';
 if (intfontstyle and (1 shl 3))>0 then
  Result:=Result+SRpStrikeOut+',';
 if Length(Result)>1 then
  Result:=Copy(REsult,1,Length(Result)-1);
 Result:=Result+']';
end;


function FindQtLocaleFile:string;
{$IFDEF LINUX}
var
 LangCode,P:PChar;
 I:Integer;
 afilename:String;
{$ENDIF}
{$IFDEF MSWINDOWS}
var
  FileName: array[0..260] of Char;
  Key: LongWord;
  LocaleName, LocaleOverride: array[0..4] of Char;
  Size: Integer;
  P: PChar;
  afilename:string;

  function FindBS(Current: PChar): PChar;
  begin
    Result := Current;
    while (Result^ <> #0) and (Result^ <> C_DIRSEPARATOR) do
      Result := CharNext(Result);
  end;

  function ToLongPath(AFileName: PChar): PChar;
  var
    CurrBS, NextBS: PChar;
     L: Integer;
     Handle:Integer;
    FindData: TWin32FindData;
    Buffer: array[0..260] of Char;
    GetLongPathName: function (ShortPathName: PChar; LongPathName: PChar;
      cchBuffer: Integer): Integer stdcall;
  begin
{$R-}
    Result := AFileName;
    Handle := GetModuleHandle(kernel);
    if Handle <> 0 then
    begin
      @GetLongPathName := GetProcAddress(Handle, 'GetLongPathNameA');
      if Assigned(GetLongPathName) and
         (GetLongPathName(AFileName, Buffer, SizeOf(Buffer)) <> 0) then
      begin
        lstrcpy(AFileName, Buffer);
        Exit;
      end;
    end;

    if AFileName[0] = C_DIRSEPARATOR then
    begin
      if AFileName[1] <> C_DIRSEPARATOR then Exit;
      CurrBS := FindBS(AFileName + 2);  // skip server name
      if CurrBS^ = #0 then Exit;
      CurrBS := FindBS(CurrBS + 1);     // skip share name
      if CurrBS^ = #0 then Exit;
    end else
      CurrBS := AFileName + 2;          // skip drive name

    L := CurrBS - AFileName;
    lstrcpyn(Buffer, AFileName, L + 1);
    while CurrBS^ <> #0 do
    begin
      NextBS := FindBS(CurrBS + 1);
      if L + (NextBS - CurrBS) + 1 > SizeOf(Buffer) then Exit;
      lstrcpyn(Buffer + L, CurrBS, (NextBS - CurrBS) + 1);

      Handle := FindFirstFile(Buffer, FindData);
      if (Handle = -1) then Exit;
      windows.FindClose(Handle);

      if L + 1 + lstrlen(FindData.cFileName) + 1 > SizeOf(Buffer) then Exit;
      Buffer[L] := C_DIRSEPARATOR;
      lstrcpy(Buffer + L + 1, FindData.cFileName);
      Inc(L, lstrlen(FindData.cFileName) + 1);
      CurrBS := NextBS;
    end;
    lstrcpy(AFileName, Buffer);
{$R+}
  end;
{$ENDIF}
begin
{$IFDEF LINUX}
 afilename:='qt';
 LangCode := getenv('LANG');
 if (LangCode = nil) or (LangCode^ = #0) then
  Exit;
 // look for modulename.en_US
 P := LangCode;
 while P^ in ['a'..'z', 'A'..'Z', '_'] do
  Inc(P);
 if P = LangCode then
  Result := afilename
 else
 begin
//  Result := afilename + '.' + Copy(LangCode, 1, P - LangCode);
  Result:='qt_'+Copy(LangCode, 1, P - LangCode)+'.qm';
  if not FileExists(Result) then
  begin
   Result := afilename + '.' + Copy(LangCode, 1, P - LangCode);
   // look for modulename.en    (ignoring country code and suffixes)
   I := Length(Result);
   while (I > 0) and not (Result[I] in ['.', '_']) do
    Dec(I);
   if (I-1 = Length(Result)) or (I-1 < Length(afilename)) then
    Exit;
   SetLength(Result, I-1);
   Result:='qt_'+Copy(ExtractFileExt(Result),2,255)+'.qm';

   if not FileExists(Result) then
   begin
    Result:=afilename;
    Exit;
   end;
  end;
 end;
{$ENDIF}
{$IFDEF MSWINDOWS}
  Result:=afilename;
  afilename:='qt.exe';
  StrCopy(Filename,Pchar(afilename));
  LocaleOverride[0] := #0;
  if (RegOpenKeyEx(HKEY_CURRENT_USER, NewLocaleOverrideKey, 0, KEY_ALL_ACCESS, Key) = 0) or
   (RegOpenKeyEx(HKEY_CURRENT_USER, OldLocaleOverrideKey, 0, KEY_ALL_ACCESS, Key) = 0) then
  try
    Size := SizeOf(LocaleOverride);
    if RegQueryValueEx(Key, ToLongPath(FileName), nil, nil, LocaleOverride, @Size) <> 0 then
      RegQueryValueEx(Key, '', nil, nil, LocaleOverride, @Size);
  finally
    RegCloseKey(Key);
  end;
  GetLocaleInfo(GetThreadLocale, LOCALE_SABBREVLANGNAME, LocaleName, SizeOf(LocaleName));
  Result := '';
  if (FileName[0] <> #0) and ((LocaleName[0] <> #0) or (LocaleOverride[0] <> #0)) then
  begin
    P := PChar(@FileName) + lstrlen(FileName);
    while (P^ <> '.') and (P <> @FileName) do Dec(P);
    if P <> @FileName then
    begin
      Inc(P);
      // First look for a locale registry override
      if LocaleOverride[0] <> #0 then
      begin
        lstrcpy(P, LocaleOverride);
        afilename:='qt_'+Copy(ExtractFileExt(StrPas(FileName)),2,255)+'.qm';
        if FileExists(aFileName) then
         Result := aFileName;
      end;
      if (Result ='') and (LocaleName[0] <> #0) then
      begin
        // Then look for a potential language/country translation
        lstrcpy(P, LocaleName);
        afilename:='qt_'+Copy(ExtractFileExt(StrPas(FileName)),2,255)+'.qm';
        if FileExists(aFileName) then
         Result := aFileName;
        if Result = '' then
        begin
          // Finally look for a language only translation
          LocaleName[2] := #0;
          lstrcpy(P, LocaleName);
          afilename:='qt_'+Copy(ExtractFileExt(StrPas(FileName)),2,255)+'.qm';
          if FileExists(aFileName) then
           Result := aFileName;
        end;
      end;
    end;
  end;
{$ENDIF}
end;


procedure LoadQtTranslator;
var
  Translator: QTranslatorH;
  Filename:string;
  WFileName,
  WDelimiter: WideString;
begin
 Filename:=FindQtLocaleFile;
 Translator := QTranslator_create(nil, nil);
 WFileName := FileName;
 WDelimiter := '_';
 if QTranslator_load(Translator, @WFileName, nil, @WDelimiter, nil) then
   QApplication_installTranslator(Application.Handle, Translator)
end;

function RpMessageBox(const Text: WideString; const Caption: WideString = '';
  Buttons: TMessageButtons = [smbOK]; Style: TMessageStyle = smsInformation;
  Default: TMessageButton = smbOK; Escape: TMessageButton = smbCancel): TMessageButton;
var
 dia:TFRpMessageDlg;
begin
 dia:=TFRpMessageDlg.Create(Application);
 try
  dia.LMessage.Caption:=Text;
  if smbOK in Buttons then
   dia.BOK.Visible:=true;
  if smbCancel in Buttons then
   dia.BCancel.Visible:=true;
  if smbYes in Buttons then
   dia.BYes.Visible:=true;
  if smbNo in Buttons then
   dia.BNo.Visible:=true;
  if smbAbort in Buttons then
   dia.BAbort.Visible:=true;
  if smbRetry in Buttons then
   dia.BRetry.Visible:=true;
  if smbIgnore in Buttons then
   dia.BIgnore.Visible:=true;
  dia.EscapeButton:=Escape;
  case Default of
   smbOK:
    begin
     dia.BOk.Default:=True;
     dia.ActiveControl:=dia.BOK;
    end;
   smbCancel:
    begin
     dia.BCancel.Default:=True;
     dia.ActiveControl:=dia.BCancel;
    end;
   smbYes:
    begin
     dia.BYes.Default:=True;
     dia.ActiveControl:=dia.BYes;
    end;
   smbNo:
    begin
     dia.BNo.Default:=True;
     dia.ActiveControl:=dia.BNo;
    end;
   smbRetry:
    begin
     dia.BRetry.Default:=True;
     dia.ActiveControl:=dia.BRetry;
    end;
   smbIgnore:
    begin
     dia.BIgnore.Default:=True;
     dia.ActiveControl:=dia.BIgnore;
    end;
   smbAbort:
    begin
     dia.BIgnore.Default:=True;
     dia.ActiveControl:=dia.BAbort;
    end;
  end;
  case Style of
   smsInformation:
    begin
     dia.Caption:=SRpInformation;
    end;
   smsWarning:
    begin
     dia.Caption:=SRpWarning;
    end;
   smsCritical:
    begin
     dia.Caption:=SRpCritical;
    end;
  end;
  dia.ShowModal;
  Result:=dia.Buttonpressed;
 finally
  dia.free;
 end;
end;

procedure TFRpMessageDlg.FormCreate(Sender: TObject);
begin
 Buttonpressed:=smbCancel;
 EscapeButton:=smbCancel;
 BYes.Tag:=integer(smbYes);
 BNo.Tag:=integer(smbNo);
 BOk.Tag:=integer(smbOk);
 BCancel.Tag:=integer(smbCancel);
 BRetry.Tag:=integer(smbRetry);
 BIgnore.Tag:=integer(smbIgnore);
 BIgnore.Tag:=integer(smbIgnore);
 BYes.Caption:=SRpYes;
 BNo.Caption:=SRpNo;
 BOk.Caption:=SRpOk;
 BCancel.Caption:=SRpCancel;
 BIgnore.Caption:=SRpIgnore;
 BAbort.Caption:=SRpAbort;
 BRetry.Caption:=SRpRetry;
end;

procedure TFRpMessageDlg.BYesClick(Sender: TObject);
begin
 ButtonPressed:=TMessageButton((Sender As TButton).Tag);
 Close;
end;

procedure TFRpMessageDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key=Key_Escape then
 begin
  Buttonpressed:=EscapeButton;
  Close;
 end;
end;

function RpInputBox(const ACaption, APrompt, ADefault:WideString ):WideString;
var
 dia:TFRpMessageDlg;
begin
 dia:=TFRpMessageDlg.Create(Application);
 try
  dia.LMessage.Caption:=APrompt;
  dia.EInput.Visible:=true;
  dia.EInput.Text:=ADefault;
  dia.ActiveControl:=dia.EInput;
  dia.LMessage.Alignment:=taLeftJustify;
  dia.Caption:=ACaption;
  dia.BOk.Visible:=True;
  dia.BOk.Default:=True;
  dia.BCancel.Visible:=True;
  dia.showmodal;
  if dia.Buttonpressed=smbOK then
   Result:=dia.EInput.Text
  else
   Result:='';
 finally
  dia.free;
 end;
end;



function SearchnodeInt(ATree:TTreeView;astring:String;anode:TTreeNode):TTreeNode;
var
 i:integer;
 firstname:string;
begin
 firstname:=GetFirstName(astring);
 Result:=nil;
 for i:=0 to anode.Count-1 do
 begin
  if firstname=anode.Item[i].Text then
  begin
   if firstname=astring then
   begin
    Result:=anode.Item[i];
   end
   else
    Result:=Searchnodeint(ATree,Copy(astring,length(firstname)+2,length(astring)),anode.Item[i]);
  end;
 end;
 if Not Assigned(Result) then
 begin
  Result:=ATree.Items.AddChild(anode,firstname);
  Result.ImageIndex:=2;
  if firstname<>astring then
  begin
   Result:=Searchnodeint(ATree,Copy(astring,length(firstname)+2,length(astring)),Result);
  end;
 end;
end;

function Searchnode(FTopItems:TStringList;ATree:TTreeView;astring:String):TTreeNode;
var
 i:integer;
 firstname:string;
begin
 firstname:=GetFirstName(astring);
 Result:=nil;
 for i:=0 to FTopItems.Count-1 do
 begin
  if firstname=FTopItems.Strings[i] then
  begin
   if firstname=astring then
   begin
    Result:=TTreeNode(FTopItems.Objects[i]);
   end
   else
    Result:=Searchnodeint(ATree,Copy(astring,length(firstname)+2,length(astring)),TTreeNode(FTopItems.Objects[i]));
  end;
 end;
 if Not Assigned(Result) then
 begin
  Result:=ATree.Items.AddChild(nil,firstname);
  Result.ImageIndex:=2;
  FTopItems.AddObject(firstname,Result);
  if firstname<>astring then
  begin
   Result:=Searchnodeint(ATree,Copy(astring,length(firstname)+2,length(astring)),Result);
  end;
 end;
end;

procedure FillTreeView(ATree:TTreeView;alist:TStringList);
var
 newitem,anode:TTreeNode;
 astring:string;
 repname,dirname:String;
 i:integer;
 FTopItems:TStringList;
begin
 FTopitems:=TStringList.Create;
 try
  for i:=0 to alist.count-1 do
  begin
   if Length(alist.Strings[i])<1 then
    continue;
   astring:=alist.Strings[i];
   // Dir separator can be / or
{$IFDEF MSWINDOWS}
   astring:=StringReplace(astring,'/',C_DIRSEPARATOR,[rfReplaceAll]);
{$ENDIF}
{$IFDEF LINUX}
   astring:=StringReplace(astring,'\',C_DIRSEPARATOR,[rfReplaceAll]);
{$ENDIF}
   repname:=GetLastName(astring);
   dirname:=GetPathName(astring);
   anode:=SearchNode(FTopItems,ATree,dirname);
   newitem:=ATree.Items.AddChild(anode,repname);
   newitem.ImageIndex:=3;
  end;
 finally
  FTopItems.Free;
 end;
end;


function GetFullFileName(ANode:TTreeNode;dirseparator:char):String;
begin
 if Assigned(ANode.Parent) then
  Result:=GetFullFileName(ANode.Parent,dirseparator)+dirseparator+ANode.Text
 else
  Result:=ANode.Text;
end;


end.
