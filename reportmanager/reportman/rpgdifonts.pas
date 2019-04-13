{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpgdifonts                                      }
{       Utilities for Windows GDI fonts                 }
{       allow the use of device dependent fonts         }
{       in a device independent way                     }
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

unit rpgdifonts;

{$I rpconf.inc}

interface

uses windows, Messages, SysUtils, Classes, Graphics, Controls,printers,
 rpmunits,Forms,
{$IFDEF DOTNETD}
 System.Drawing,
{$ENDIF}
 rptypes,syncobjs;

type
  TPrinterFont=class(TObject)
   private
    FFont:TFont;
    procedure SetFont(Valor:TFont);
   public
    fstep:TRpFontStep;
    LogFont:TLogFont;
    isred:boolean;
    constructor Create;virtual;
    destructor Destroy;override;
    property Font:TFont read FFont write SetFont;
   end;

   TGDIFontType=(tfontraster,tfonttruetype,tfontdevice,tfonttruetypedevice);
   TCaracfont=class(TObject)
    public
     name:string;
     sizes:TStringlist;
     ftype:TGDIFontType;
     fstep:TRpFontStep;
     fixed:boolean;
     constructor Create;
     destructor Destroy;override;
    end;

function UpdatePrinterFontList:boolean;

procedure FindDeviceFont (DC:HDC; Font:Tfont; fstep:TRpFontStep);
function FindRotatedFont (Desti:HDC; Font:TFont; rotation:integer):HFont;
function FindFontStep (Font:TFont):integer;

var
 PrinterFonts:TList;
 PrinterSorted:TStringList;
 caracfonts:TStringlist;
 ScreenSorted:TStringList;
implementation

var
 currentprinter:integer;
 idx:integer;
 sizestruetype:Tstringlist;


procedure lliberacaracfonts;
var
 i:integeR;
begin
 for i:=0 to caracfonts.count-1 do
 begin
  caracfonts.objects[i].free;
 end;
 caracfonts.clear;
end;

{$IFDEF DOTNETD}
function CompareFonts(font1,font2:TObject):integer;
{$ENDIF}
{$IFNDEF DOTNETD}
function CompareFonts(font1,font2:Pointer):integer;
{$ENDIF}
var
 log1,log2:TPrinterFont;
begin
 log1:=TPrinterFont(Font1);
 log2:=TPrinterFont(Font2);
 if log1.fstep>log2.fstep then
  Result:=1
 else
  if log1.fstep<log2.fstep then
   result:=-1
  else
  begin
   if log1.Font.Name>log2.Font.Name then
    Result:=-1
   else
    if log1.Font.Name>log2.Font.Name then
     Result:=1
    else
     Result:=0;
  end;
end;

constructor TPrinterFont.Create;
begin
 inherited Create;
 FFOnt:=TFont.Create;
end;

destructor TPrinterFont.Destroy;
begin
 FFont.free;
 inherited Destroy;
end;

procedure TPrinterFont.SetFont(Valor:TFont);
begin
 FFOnt.Assign(Valor);
end;

{$IFNDEF DOTNETD}
function enumfontfamprocbase(var ENUMLOGFONT:TEnumlogfont;var TextMetric:TNewTextMetric;
          FontType:integer;Data:Integer):integer;stdcall;
begin
 TStringList(Data).Add(enumlogfont.elfLogFont.lfFaceName);
 Result:=1;
end;
{$ENDIF}


{$IFNDEF DOTNETD}
function enumfontfamproc(var ENUMLOGFONT:TEnumlogfont;var TextMetric:TNewTextMetric;
          FontType:integer;Data:integer):integer;
stdcall;
var
 Fontimp:TPrinterFont;
 index:integer;
 carac:TCaracFont;
 size:integer;
 logfont:TLogFont;
begin
 fontimp:=nil;
 logfont:=enumlogfont.elfLogFont;
 size:=LogFont.lfHeight*240 div 3500;
 if (fonttype=3)then
 begin
  FontImp:=TPrinterFont.Create;
  case LogFont.lfWidth of
   40..80: FOntImp.fstep:=rpcpi20;
   81..90: FOntImp.fstep:=rpcpi17;
   91..110: FOntImp.fstep:=rpcpi15;
   111..135: FOntImp.fstep:=rpcpi12;
   136..180: FOntImp.fstep:=rpcpi10;
   181..240: FOntImp.fstep:=rpcpi6;
   241..400: FOntImp.fstep:=rpcpi5;
  else
    FontImp.fstep:=rpcpi10;
  end;
  FontImp.LogFont:=LogFont;
  FontImp.Font.Name:=LogFont.lfFaceName;
  if Pos('RED',UpperCase(FontImp.Font.Name))>0 then
  begin
   Fontimp.isred:=true;
  end
  else
  begin
   if Pos('ROJO',UpperCase(FontImp.Font.Name))>0 then
    Fontimp.isred:=true
   else
    fontimp.isred:=false;
  end;
  FontImp.Font.Size:=LogFont.lfHeight*POINTS_PER_INCHESS div TWIPS_PER_INCHESS;
//  FontImp.Font.Height:=LogFont.lfHeight;
//  FontImp.Font.:=LogFont.lfHeight;
  TList(Data).Add(FontImp);
 end;
 // Caracfonts
 index:=caracfonts.IndexOf(logfont.lfFaceName);
 if index<0 then
 begin
  carac:=TCaracFont.create;
  carac.name:=logfont.lfFaceName;
  if (fonttype=3)then
  begin
   carac.ftype:=tfontdevice;
   carac.fstep:=fontimp.fstep;
  end
  else
   if (fonttype=2) then
    carac.ftype:=tfonttruetypedevice
   else
    if (fonttype AND RASTER_FONTTYPE)>0 then
     carac.ftype:=tfontraster
    else
     carac.ftype:=tfonttruetype;
  if carac.ftype=tfonttruetype then
   carac.sizes.assign(sizestruetype)
  else
   carac.sizes.Add(Format('%3s',[IntTostr(size)]));
  carac.fixed:=((textmetric.tmPitchAndFamily AND TMPF_FIXED_PITCH)=0);
  caracfonts.addobject(carac.name,carac);
 end
 else
 begin
  carac:=Tcaracfont(caracfonts.objects[index]);
  carac.sizes.Add(Format('%3s',[IntTostr(size)]));
 end;
 Result:=1;
end;
{$ENDIF}


function UpdatePrinterFontList:boolean;
var
 base:TStringList;
 i:integer;
{$IFNDEF DOTNETD}
 Anticmapmode:HDC;
{$ENDIF}
{$IFDEF DOTNETD}
 fm:array of FontFamily;
 Fontimp:TPrinterFont;
{$ENDIF}
 critsec:TCriticalSection;
begin
 critsec:=TCriticalSection.Create;
 try
  critsec.Enter;
  try
 Result:=false;
 if Printer.printers.count<1 then
 begin
  PrinterFonts.clear;
  exit;
 end;
 // If the list is updated exit
 if currentprinter=Printer.PrinterIndex then
  Exit;
 result:=true;
 currentprinter:=printer.printerindex;
 lliberacaracfonts;
 PrinterFonts.Clear;
{$IFNDEF DOTNETD}
 anticmapmode:=SetMapMode(Printer.Handle,MM_TWIPS);
 try
  base:=TStringList.create;
  try
   EnumFontfamilies(Printer.Handle,nil,@enumfontfamprocbase,Integer(Pointer(base)));
   for i:=0 to base.count-1 do
   begin
    EnumFontfamilies(Printer.Handle,Pchar(base.strings[i]),@enumfontfamproc,Integer(Pointer(PrinterFonts)));
   end;
  finally
   base.free;
  end;
 finally
  SetMapMode(Printer.Handle,anticmapmode);
 end;
{$ENDIF}
{$IFDEF DOTNETD}
 fm:=System.Drawing.FontFamily.Families;
 for i:=0 to High(fm) do
 begin
  Fontimp:=TPrinterFont.Create;
  Fontimp.Font.Name:=fm[i].Name;
  if (fm[i].IsStyleAvailable(System.Drawing.FontStyle.Regular)) then
  begin
   System.Drawing.Font.Create(fm[i].Name,10.0).Tologfont(Fontimp.LogFont);
   printerfonts.Add(Fontimp);
  end;
 end;
{$ENDIF}
 printerFonts.Sort(CompareFonts);
 printerSorted.Assign(Printer.Fonts);
 finally
  critsec.Leave;
 end;
 finally
  critsec.free;
 end;
end;

procedure FindScreenDeviceFont(FOnt:TFont;fstep:TRpFontStep);
const
 valorsCPITWIPS:array [rpcpi20..rpcpi5] of integer=(76,84,96,120,144,240,288);
 valorsCPICPI:array [rpcpi20..rpcpi5] of integer=(20,17,15,12,10,6,5);

var LogFont:TLogFont;
begin
 // To skip device font simulation ignore this function
// Exit;
 // This function selects a font that is like printer font
 // with the selected step

 LogFont.lfHeight:=Font.Height;

 LogFont.lfWidth:=Trunc(ValorsCPITWIPS[fstep]/TWIPS_PER_INCHESS*Screen.PixelsPerInch);
 LogFont.lfEscapement:=0;
 LogFont.lfOrientation:=0;
// if fsBold in Font.Style then
//  LogFont.lfWeight:=FW_BOLD
// else
//  LogFont.lfWeight:=FW_NORMAL;
 LogFont.lfWeight:=FW_dontcaRE;
 if fsITalic in Font.Style then
  LogFont.lfItalic:=1
 else
  LogFont.lfItalic:=0;
 if fsUnderline in Font.Style then
  LogFont.lfUnderline:=1
 else
  Logfont.lfUnderline:=0;
 if fsStrikeOut in Font.Style then
  LogFont.lfStrikeOut:=1
 else
  LogFont.lfStrikeOut:=0;
 LogFont.lfCharSet:=DEFAULT_CHARSET;
 lOGfONT.lfOutPrecision:=OUT_tt_onLy_PRECIS;
 LogFont.lfClipPrecision:=CLIP_DEFAULT_PRECIS;
 // Low Quality high measurement precision
 // LogFont.lfQuality:=Draft_QUALITY;
 // Improving quality
 LogFont.lfQuality:=PROOF_QUALITY;
 LogFont.lfPitchAndFamily:=FF_DONTCARE or FIXED_PITCH;
 LogFont.lffACEnAME:='';
 Font.handle:= CreateFontIndirect(LogFont);
 if Font.Color=clWhite then
  Font.Color:=clBlack;
end;

procedure FindPrinterDeviceFont(FOnt:TFont;fstep:TRpFontStep);
var
 i,fontsize:integer;
 fontname:string;
 font1:TPrinterFont;
 fontstep:TRpFontStep;
begin
 fontsize:=10;
 fontstep:=rpcpi10;
 if printerFonts.Count<1 then
  Exit;
 i:=0;
 fontname:='';
 while i<PrinterFonts.Count do
 begin
  font1:=TPrinterFont(printerfonts.Items[i]);
  if Font.Name=font1.font.name then
  begin
   fontname:='';
   break;
  end;
  if fstep>=font1.fstep then
  begin
   // Font Color
   if font.color=clred then
   begin
    if font1.isred then
    begin
     fontname:=font1.Font.Name;
     fontsize:=font1.Font.Size;
     fontstep:=font1.fstep;
    end;
   end
   else
   begin
    if Not font1.isred then
    begin
     fontname:=font1.Font.Name;
     fontsize:=font1.Font.Size;
     fontstep:=font1.fstep;
    end;
   end;
  end
  else
   break;
  inc(i);
 end;
 if fontname<>'' then
 begin
  // Looks for draft fonts in this size
  i:=0;
  while i<PrinterFonts.Count do
  begin
   font1:=TPrinterFont(printerfonts.Items[i]);
   if font1.fstep=fontstep then
   begin
    if (Pos('SUPER DRAFT',UpperCase(font1.Font.Name))>0) then
    begin
     fontname:=font1.Font.Name;
     break;
    end;
    if (Pos('DRAFT',UpperCase(font1.Font.Name))>0) then
    begin
     fontname:=font1.Font.Name;
    end;
   end;
   inc(i);
  end;
  Font.Name:=fontname;
  Font.Size:=fontsize;
 end;
end;

procedure FindDeviceFont(DC:HDC;Font:Tfont;fstep:TRpFontStep);
begin
 if Printer.Printers.count<1 then
 begin
  FindScreenDeviceFont(Font,fstep);
  exit;
 end;
 if DC=Printer.Handle then
  FindPrinterDeviceFont(Font,fstep)
 else
  FindScreenDeviceFont(Font,fstep);
end;

function FindFontStep(Font:TFont):integer;
var
 anticobject:integer;
 metric:TTextMetric;
begin
 if Printer.Printers.count<1 then
 begin
  Result:=10;
  exit;
 end;
 anticobject:=SelectObject(Printer.handle,Font.handle);
 try
  GetTextMetrics(Printer.handle,metric);
  Result:=metric.tmAveCharWidth;
 finally
  SelectObject(Printer.handle,anticobject);
 end;
end;

function FindRotatedFont(DEsti:HDC;Font:TFont;rotation:integer):HFont;
var
 logfont:tlogfont;
begin
{ LogFont.lfHeight:=Font.Height;
 LogFont.lfWidth:=0;
 LogFont.lfEscapement:=rotation;
 LogFont.lfOrientation:=rotation;
} if fsBold in Font.Style then
  LogFont.lfWeight:=FW_BOLD
 else
  LogFont.lfWeight:=FW_NORMAL;
 LogFont.lfWeight:=FW_dontcaRE;
 if fsITalic in Font.Style then
  LogFont.lfItalic:=1
 else
  LogFont.lfItalic:=0;
 if fsUnderline in Font.Style then
  LogFont.lfUnderline:=1
 else
  Logfont.lfUnderline:=0;
 if fsStrikeOut in Font.Style then
  LogFont.lfStrikeOut:=1
 else
  LogFont.lfStrikeOut:=0;
{ LogFont.lfCharSet:=DEFAULT_CHARSET;
 lOGfONT.lfOutPrecision:=OUT_DEFAULT_PRECIS;
 LogFont.lfClipPrecision:=CLIP_DEFAULT_PRECIS;
 // Poca qualitat, gran semblança
 // LogFont.lfQuality:=Draft_QUALITY;
 // Gran qualitat, semblança normal
// LogFont.lfQuality:=PROOF_QUALITY;
 LogFont.lfQuality:=DEFAULT_QUALITY;
 LogFont.lfPitchAndFamily:=FF_DONTCARE {or FIXED_PITCH};

  LOGFONT.lfheight:=-MulDiv(Font.size, GetDeviceCaps(desti, LOGPIXELSY), POINTS_PER_INCHESS);
  logfont.lfwidth:=0;
  logfont.lfWeight:=FW_DONTCARE;
  logfont.lfEscapement:=rotation;
  logfont.lfOrientation:=rotation;
{  logfont.lfItalic:=0;
  logfont.lfUnderline:=0;
   logfont.lfStrikeout:=0;
}  logfont.lfCharSet:=DEFAULT_CHARSET;
  logfont.lfOutPrecision:=OUT_DEFAULT_PRECIS;
  logfont.lfclipprecision:=CLIP_DEFAULT_PRECIS;
  logfont.lfQuality:=DRAFT_QUALITY;
  logfont.lfPitchAndFamily:=DEFAULT_PiTCH;
{$IFNDEF DOTNETD}
  logfont.lfFaceName[0]:=chr(0);
  StrPCopy(LogFont.lffACEnAME,Font.Name);
{$ENDIF}
{$IFDEF DOTNETD}
  LogFont.lfFaceName:=Font.Name;
{$ENDIF}
  Result:=CreateFontIndirect(LOGFONT);
end;


constructor TCaracfont.Create;
begin
 inherited Create;

 sizes:=TStringList.create;
 sizes.sorted:=true;
end;

destructor TCaracfont.destroy;
begin
 sizes.free;
 inherited destroy;
end;



initialization
PrinterSorted:=TStringList.Create;
PrinterSorted.Sorted:=True;
PrinterFonts:=TList.Create;
ScreenSorted:=TStringList.Create;
ScreenSorted.Sorted:=True;
caracfonts:=TStringlist.create;
caracfonts.sorted:=true;
ScreenSorted.Assign(Screen.Fonts);
currentprinter:=-1;
sizestruetype:=TStringlist.create;
with sizestruetype do
begin
 Add('  8');
 Add('  9');
 Add(' 10');
 Add(' 11');
 Add(' 12');
 Add(' 14');
 Add(' 16');
 Add(' 18');
 Add(' 20');
 Add(' 22');
 Add(' 24');
 Add(' 26');
 Add(' 28');
 Add(' 36');
 Add(' 48');
 Add(' 72');
end;


finalization
 idx:=0;
 while idx<PrinterFonts.Count do
 begin
  TPrinterFont(PrinterFonts.Items[idx]).Free;
  Inc(idx);
 end;
PrinterFonts.free;
PrinterSorted.free;
ScreenSorted.free;
lliberacaracfonts;
caracfonts.free;
sizestruetype.free;
end.
