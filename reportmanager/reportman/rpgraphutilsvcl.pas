{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpgraphutilsvcl                                 }
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
unit rpgraphutilsvcl;

interface

{$I rpconf.inc}

uses
  windows,
  SysUtils,Classes,
{$IFDEF USEVARIANTS}
  Types,Variants,
{$ENDIF}
{$IFDEF DOTNETD}
  Registry,
{$ENDIF}
  rptranslator,
  Graphics, Forms,Buttons, ExtCtrls,
  Controls, StdCtrls,ImgList,ComCtrls,
  rpmdconsts,rpmunits;


type
  TMessageButton = (smbOK, smbCancel, smbYes, smbNo, smbAbort, smbRetry, smbIgnore);
  TMessageButtons = set of TMessageButton;
  TMessageStyle = (smsInformation, smsWarning, smsCritical);

  TFRpMessageDlgVCL = class(TForm)
    PBottom: TPanel;
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
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
   Buttonpressed,EscapeButton:TMessageButton;
   function ComponentToTMessageButton(Sender:TObject):TMessageButton;
  public
    { Public declarations }
  end;

procedure DrawGrid(Canvas:TCanvas;XWidth,XHeight,PixelsWidth,PixelsHeight:integer;Color:TColor;lines:boolean;XOffset,YOffset:integer;scale:double);
function twipstopixels(ATwips:integer;Scale:double):integer;
function pixelstotwips(apixels:integer;scale:double):integer;
function FontStyleToCLXInteger(fontstyle:TFontStyles):integer;
function CLXIntegerToFontStyle(intfontstyle:integer):TFontStyles;
function IntegerFontStyleToString(intfontstyle:integer):String;
function AlignToGrid(Value:integer;scale:integer):integer;
function AlignToGridPixels(Value:integer;scaletwips:integer;scale:double):integer;
function RpMessageBox(const Text: WideString; const Caption: WideString = '';
  Buttons: TMessageButtons = [smbOK]; Style: TMessageStyle = smsInformation;
  Default: TMessageButton = smbOK; Escape: TMessageButton = smbCancel): TMessageButton;
function RpInputBox(const ACaption, APrompt, ADefault:WideString ):WideString;
procedure FillTreeView(ATree:TTreeView;alist:TStringList);
function GetFullFileName (ANode:TTreeNode;dirseparator:char):String;
function CLXColorToVCLColor (CLXColor:integer):integer;
procedure RpShowMessage(const Text: WideString);

implementation

{$R *.dfm}


{$IFDEF MSWINDOWS}
const
  kernel = 'kernel32.dll';
  OldLocaleOverrideKey = 'Software\Borland\Delphi\Locales';
  NewLocaleOverrideKey = 'Software\Borland\Locales';

{$IFNDEF DOTNETD}
function RegOpenKeyEx(hKey: LongWord; lpSubKey: PChar; ulOptions,
  samDesired: LongWord; var phkResult: LongWord): Longint; stdcall;
  external advapi32 name 'RegOpenKeyExA';
function RegQueryValueEx(hKey: LongWord; lpValueName: PChar;
  lpReserved: Pointer; lpType: Pointer; lpData: PChar; lpcbData: Pointer): Integer; stdcall;
  external advapi32 name 'RegQueryValueExA';
{$ENDIF}

{$ENDIF}

procedure RpShowMessage(const Text: WideString);
begin
 RpMessageBox(Text);
end;


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


function LogicalPointToDevicePoint(origin,destination,value:TPoint):TPoint;
begin
 Result:=value;
 value.X:=Round(value.X*(destination.X/origin.X));
 value.Y:=Round(value.Y*(destination.Y/origin.Y));
 Result:=Value;
end;

procedure DrawGrid(Canvas:TCanvas;XWidth,XHeight,PixelsWidth,PixelsHeight:integer;Color:TColor;lines:boolean;XOffset,YOffset:integer;scale:double);
var
 pixelsperinchx,pixelsperinchy:integer;
 rect:TRect;
 han:HDC;
// hanbrush:QBrushH;
 windowwidth,windowheight:integer;
 x,y:integer;
// pixelwidth:integer;
// pixelheight:integer;
 xof,yof:integer;
 oldmapmode:integer;
 origin,destination,avalue:TPoint;
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
// hanbrush:=Canvas.Brush.handle;

// pixelwidth:=Round(TWIPS_PER_INCHESS/pixelsperinchx)+1;
// pixelheight:=Round(TWIPS_PER_INCHESS/pixelsperinchy)+1;

 origin.X:=windowwidth;
 origin.Y:=windowheight;
 destination.X:=rect.Right;
 destination.Y:=rect.Bottom;
 // Draws the grid
 // Painting of the ruler
 oldmapmode:=SetMapMode(han,MM_TEXT);
 // Get the pixels per inch
 try
  if lines then
  begin
   x:=xof+XWidth;
   y:=yof+Xheight;
   while ((x<windowwidth) or (y<windowheight)) do
   begin
    if (x<windowwidth) then
    begin
     avalue.X:=x;
     avalue.Y:=yof;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Canvas.MoveTo(avalue.X,avalue.Y);
     avalue.X:=x;
     avalue.Y:=windowheight;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Canvas.LineTo(avalue.X,avalue.Y);
      x:=x+XWidth;
    end;
    if (y<windowheight) then
    begin
     avalue.X:=xof;
     avalue.Y:=y;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Canvas.MoveTo(avalue.X,avalue.Y);
     avalue.X:=windowwidth;
     avalue.Y:=y;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
     Canvas.LineTo(avalue.X,avalue.Y);
     y:=y+XHeight;
    end;
   end;
  end
  else
  begin
   x:=xof+XWidth;
   while (x<windowwidth) do
   begin
//    avalue.X:=x;
//    avalue.Y:=x+pixelwidth;
//    avalue:=LogicalPointToDevicePoint(origin,destination,avalue);

//    rect.Left:=avalue.X;
//    rect.Right:=avalue.Y;
    y:=yof+XHeight;
    while y<windowheight do
    begin
     avalue.X:=x;
     avalue.Y:=y;
//     avalue.X:=y;
//     avalue.Y:=y+pixelheight;
     avalue:=LogicalPointToDevicePoint(origin,destination,avalue);
//     rect.Top:=avalue.X;
//     rect.Bottom:=avalue.Y;
//     Canvas.FillRect(rect);
     SetPixel(han,avalue.X,avalue.Y,Color);
     y:=y+XHeight;
    end;
    x:=x+XWidth;
   end;
  end;
 finally
  SetMapMode(han,oldmapmode);
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

function FontStyleToCLXInteger(fontstyle:TFontStyles):integer;
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

function CLXIntegerToFontStyle(intfontstyle:integer):TFontStyles;
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





function RpMessageBox(const Text: WideString; const Caption: WideString = '';
  Buttons: TMessageButtons = [smbOK]; Style: TMessageStyle = smsInformation;
  Default: TMessageButton = smbOK; Escape: TMessageButton = smbCancel): TMessageButton;
var
 dia:TFRpMessageDlgVCL;
begin
 dia:=TFRpMessageDlgVCL.Create(Application);
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

function TFRpMessageDlgVCL.ComponentToTMessageButton(Sender:TObject):TMessageButton;
begin
 Result:=smbCancel;
 if Sender=BYes then
  Result:=smbYes
 else
 if Sender=BOk then
  Result:=smbOk
 else
 if Sender=BCancel then
  Result:=smbCancel
 else
 if Sender=BNo then
  Result:=smbNo
 else
 if Sender=BRetry then
  Result:=smbRetry
 else
 if Sender=BIgnore then
  Result:=smbIgnore;
end;

procedure TFRpMessageDlgVCL.FormCreate(Sender: TObject);
begin
 Buttonpressed:=smbCancel;
 EscapeButton:=smbCancel;
 BYes.Caption:=SRpYes;
 BNo.Caption:=SRpNo;
 BOk.Caption:=SRpOk;
 BCancel.Caption:=SRpCancel;
 BIgnore.Caption:=SRpIgnore;
 BAbort.Caption:=SRpAbort;
 BRetry.Caption:=SRpRetry;
end;

procedure TFRpMessageDlgVCL.BYesClick(Sender: TObject);
begin
 ButtonPressed:=ComponentToTMessageButton(Sender);
 Close;
end;

procedure TFRpMessageDlgVCL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key=VK_ESCAPE then
 begin
  Buttonpressed:=EscapeButton;
  Close;
 end;
end;

function RpInputBox(const ACaption, APrompt, ADefault:WideString ):WideString;
var
 dia:TFRpMessageDlgVCL;
begin
 dia:=TFRpMessageDlgVCL.Create(Application);
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

function CLXColorToVCLColor(CLXColor:integer):integer;
begin
 Result:=CLXColor AND $00FFFFFF;
end;

function getfirstname(astring:string):string;
var
 j,index:integer;
begin
 j:=1;
 index:=Length(astring)+1;
 while j<=Length(astring) do
 begin
  if astring[j]=C_DIRSEPARATOR then
  begin
   index:=j;
   break;
  end;
  inc(j);
 end;
 Result:=Copy(astring,1,index-1);
end;

function getpathname(astring:string):string;
var
 j,index:integer;
begin
 j:=1;
 index:=1;
 while j<=Length(astring) do
 begin
  if astring[j]=C_DIRSEPARATOR then
  begin
   index:=j;
  end;
  inc(j);
 end;
 Result:=Copy(astring,1,index-1);
end;

function getlastname(astring:string):string;
var
 j,index:integer;
begin
 j:=1;
 index:=1;
 while j<=Length(astring) do
 begin
  if astring[j]=C_DIRSEPARATOR then
  begin
   index:=j;
  end;
  inc(j);
 end;
 Result:=Copy(astring,index+1,Length(astring));
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
  Result.SelectedIndex:=2;
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
  Result.SelectedIndex:=2;
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
   repname:=GetLastName(astring);
   dirname:=GetPathName(astring);
   anode:=SearchNode(FTopItems,ATree,dirname);
   newitem:=ATree.Items.AddChild(anode,repname);
   newitem.ImageIndex:=3;
   newitem.SelectedIndex:=3;
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


procedure TFRpMessageDlgVCL.FormShow(Sender: TObject);
const
 BUTTON_GAP=10;
var
 i:integer;
 alist:TList;
 leftpos:integer;
begin
 // Center visible buttons
 alist:=TList.Create;
 try
  for i:=0 to PBottom.ControlCount-1 do
  begin
   if PBottom.Controls[i].Visible then
   begin
    alist.Add(PBottom.Controls[i]);
   end;
  end;
  leftpos:=(PBottom.Width div 2)-alist.Count*(BYes.Width div 2)-
   (alist.Count-1)*BUTTON_GAP;
  for i:=0 to alist.Count-1 do
  begin
   TControl(alist.Items[i]).Left:=leftpos;
   leftpos:=leftpos+BYes.Width+BUTTON_GAP;
  end;
 finally
  alist.Free;
 end;
end;

initialization
{$IFNDEF DOTNETDBUGS}
 if ChangeFileExt(ExtractFileName(UpperCase(Application.ExeName)),'')='REPMANDXP' then
  Application.Title:=TranslateStr(1,Application.Title);
{$ENDIF}
end.
