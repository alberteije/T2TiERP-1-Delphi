{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       TRpInfoProvider Fretype library                 }
{       Provides information about fonts in Linux       }
{       It uses freetype library version 2              }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{                                                       }
{*******************************************************}

unit rpinfoprovft;


interface

{$I rpconf.inc}

uses Classes,SysUtils,
{$IFDEF USEVARIANTS}
    Types,
{$ENDIF}
{$IFDEF MSWINDOWS}
    Windows,
{$ENDIF}
    rpinfoprovid,SyncObjs,
    rpmdconsts,rpfreetype2;


type

 TRpLogFont=class(TObject)
  fixedpitch:boolean;
  postcriptname:string;
  familyname:String;
  stylename:string;
  italic:Boolean;
  bold:Boolean;
  filename:String;
  ascent:integer;
  descent:integer;
  weight:integer;
  MaxWidth:integer;
  avCharWidth:Integer;
  Capheight:integer;
  ItalicAngle:double;
  leading:integer;
  BBox:TRect;
  fullinfo:Boolean;
  StemV:double;
  ftface:FT_Face;
  faceinit:boolean;
  havekerning:Boolean;
  type1:boolean;
  convfactor,widthmult:Double;
  constructor Create;
  destructor Destroy;override;
  procedure OpenFont;
 end;

 TRpFTInfoProvider=class(TRpInfoProvider)
  currentname:String;
  currentstyle:integer;
  currentfont:TRpLogFont;
  crit:TCriticalSection;
  procedure InitLibrary;
  procedure SelectFont(pdffont:TRpPDFFOnt);
  procedure FillFontData(pdffont:TRpPDFFont;data:TRpTTFontData);override;
  function GetCharWidth(pdffont:TRpPDFFont;data:TRpTTFontData;charcode:widechar):Integer;override;
  function GetKerning(pdffont:TRpPDFFont;data:TRpTTFontData;leftchar,rightchar:widechar):integer;override;
  constructor Create;
  destructor destroy;override;
 end;

implementation

var
  fontlist:TStringList;
  fontpaths:TStringList;
  fontfiles:TStringList;
  ftlibrary:FT_Library;
  initialized:boolean;
  defaultfont:TRpLogFont;
  defaultfontb:TRpLogFont;
  defaultfontit:TRpLogFont;
  defaultfontbit:TRpLogFont;

const
 TTF_PRECISION=1000;


// add self directory and subdirectories to the lis
procedure Parsedir(alist:TStringList;adir:string);
var
 f:TSearchRec;
 retvalue:integer;
begin
 adir:=ExpandFileName(adir);
 alist.Add(adir);
 retvalue:=SysUtils.FindFirst(adir+C_DIRSEPARATOR+'*',faDirectory,F);
 if 0=retvalue then
 begin
  try
   while retvalue=0 do
   begin
    if ((F.Name<>'.') AND (F.Name<>'..')) then
    begin
     if (f.Attr AND faDirectory)<>0 then
      Parsedir(alist,adir+C_DIRSEPARATOR+F.Name);
    end;
    retvalue:=SysUtils.FindNext(F);
   end;
  finally
   SysUtils.FindClose(F);
  end;
 end;
end;

// Parses /etc/fonts/fonts.conf for font directories
// also includes subdirectories
procedure GetFontsDirectories(alist:TStringList);
var
{$IFDEF LINUX}
 afile:TStringList;
 astring:String;
 diderror:Boolean;
 apath:String;
 index:integer;
{$ENDIF}
{$IFDEF MSWINDOWS}
  abuf:pchar;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
 abuf:=AllocMem(255);
 try
  GetWindowsDirectory(abuf,255);
  alist.Add(StrPas(abuf)+'\fonts');
 finally
  FreeMem(abuf);
 end;
 exit;
{$ENDIF}
{$IFDEF LINUX}
 diderror:=false;
 alist.clear;
 afile:=TStringList.create;
 try
  afile.LoadFromFile('/etc/fonts/fonts.conf');
 except
  afile.free;
  diderror:=true;
 end;
 if diderror then
 begin
  // Default font directories
  ParseDir(alist,'/usr/X11R6/lib/X11/fonts');
  ParseDir(alist,'~/fonts');
  exit;
 end;
 astring:=afile.Text;
 index:=Pos('<dir>',astring);
 while index>0 do
 begin
  astring:=Copy(astring,index+5,Length(astring));
  index:=Pos('</dir>',astring);
  if index>0 then
  begin
   apath:=Copy(astring,1,index-1);
   ParseDir(alist,apath);
   astring:=Copy(astring,index+6,Length(astring));
  end;
  index:=Pos('<dir>',astring);
 end;
{$ENDIF}
end;

procedure TRpFTInfoProvider.InitLibrary;
var
 i:integer;
 f:TSearchRec;
 retvalue:integer;
 aobj:TRpLogFont;
 afilename:string;
 errorface:FT_Error;
 aface:FT_Face;
begin
 if Assigned(fontlist) then
  exit;
 CheckFreeTypeLoaded;
 // reads font directory
 fontlist:=TStringList.Create;
 fontfiles:=TStringList.Create;
 fontfiles.Sorted:=true;
 fontpaths:=TStringList.Create;

 GetFontsDirectories(fontpaths);
 fontfiles.Clear;
 for i:=0 to fontpaths.Count-1 do
 begin
  retvalue:=SysUtils.FindFirst(fontpaths.strings[i]+C_DIRSEPARATOR+'*.pf*',faAnyFile,F);
  if 0=retvalue then
  begin
   try
    while retvalue=0 do
    begin
     if ((F.Name<>'.') AND (F.Name<>'..')) then
     begin
      if (f.Attr AND faDirectory)=0 then
       fontfiles.Add(fontpaths.strings[i]+C_DIRSEPARATOR+F.Name);
     end;
     retvalue:=SysUtils.FindNext(F);
    end;
   finally
    SysUtils.FindClose(F);
   end;
  end;
  retvalue:=SysUtils.FindFirst(fontpaths.strings[i]+C_DIRSEPARATOR+'*.ttf',faAnyFile,F);
  if 0=retvalue then
  begin
   try
    while retvalue=0 do
    begin
     if ((F.Name<>'.') AND (F.Name<>'..')) then
     begin
      if (f.Attr AND faDirectory)=0 then
       fontfiles.Add(fontpaths.strings[i]+C_DIRSEPARATOR+F.Name);
     end;
     retvalue:=SysUtils.FindNext(F);
    end;
   finally
    SysUtils.FindClose(F);
   end;
  end;
{$IFDEF LINUX}
  retvalue:=SysUtils.FindFirst(fontpaths.strings[i]+C_DIRSEPARATOR+'*.TTF',faAnyFile,F);
  if 0=retvalue then
  begin
   try
    while retvalue=0 do
    begin
     if ((F.Name<>'.') AND (F.Name<>'..')) then
     begin
      if (f.Attr AND faDirectory)=0 then
       fontfiles.Add(fontpaths.strings[i]+C_DIRSEPARATOR+F.Name);
     end;
     retvalue:=SysUtils.FindNext(F);
    end;
   finally
    SysUtils.FindClose(F);
   end;
  end;
{$ENDIF}
 end;
 defaultfont:=nil;
 defaultfontb:=nil;
 defaultfontit:=nil;
 defaultfontbit:=nil;
 CheckFreeType(FT_Init_FreeType(ftlibrary));
 initialized:=true;

 // Now fill the font list with all font files
 for i:=0 to fontfiles.Count-1 do
 begin
  afilename:=fontfiles.strings[i];
  errorface:=FT_New_Face(ftlibrary,Pchar(afilename),0,aface);
  if errorface=0 then
  begin
   try
    // Add it only if it's a TrueType or OpenType font
    // Type1 fonts also supported
    if  (FT_FACE_FLAG_SCALABLE AND aface.face_flags)<>0 then
    begin
     aobj:=TRpLogFont.Create;
     try
      aobj.FullInfo:=false;
      // Fill font properties
      aobj.Type1:=(FT_FACE_FLAG_SFNT AND aface.face_flags)=0;
      if aobj.Type1 then
      begin
       aobj.convfactor:=1;
//       aobj.convfactor:=1000/aface.units_per_EM;
       aobj.widthmult:=aobj.convfactor;
      end
      else
      begin
       aobj.convfactor:=1;
//       aobj.convfactor:=1000/aface.units_per_EM;
       aobj.widthmult:=aobj.convfactor;
      end;
      aobj.filename:=fontfiles.strings[i];
      aobj.postcriptname:=StringReplace(StrPas(aface.family_name),' ','',[rfReplaceAll]);
      aobj.familyname:=StrPas(aface.family_name);
      aobj.fixedpitch:=(aface.face_flags AND FT_FACE_FLAG_FIXED_WIDTH)<>0;
      aobj.HaveKerning:=(aface.face_flags AND FT_FACE_FLAG_KERNING)<>0;
      aobj.BBox.Left:=Round(aobj.convfactor*aface.bbox.xMin);
      aobj.BBox.Right:=Round(aobj.convfactor*aface.bbox.xMax);
      aobj.BBox.Top:=Round(aobj.convfactor*aface.bbox.yMax);
      aobj.BBox.Bottom:=Round(aobj.convfactor*aface.bbox.yMin);
      aobj.ascent:=Round(aobj.convfactor*aface.ascender);
      aobj.descent:=Round(aobj.convfactor*aface.descender);
      aobj.leading:=Round(aobj.convfactor*aface.height)-(aobj.ascent-aobj.descent);
      aobj.MaxWidth:=Round(aobj.convfactor*aface.max_advance_width);
      aobj.Capheight:=Round(aobj.convfactor*aface.ascender);
      aobj.stylename:=StrPas(aface.style_name);
      aobj.bold:=(aface.style_flags AND FT_STYLE_FLAG_BOLD)<>0;
      aobj.italic:=(aface.style_flags AND FT_STYLE_FLAG_ITALIC)<>0;

      // Default font configuration, LUXI SANS is default
      if ((not aobj.italic) and (not aobj.bold)) then
      begin
       if not assigned(defaultfont) then
        defaultfont:=aobj
       else
       begin
        if (UpperCase(aobj.familyname)='LUXI SANS') then
        begin
         defaultfont:=aobj;
        end;
       end;
      end
      else
      if ((not aobj.italic) and (aobj.bold)) then
      begin
       if not assigned(defaultfontb) then
        defaultfontb:=aobj
       else
       begin
        if (UpperCase(aobj.familyname)='LUXI SANS') then
        begin
         defaultfontb:=aobj;
        end;
       end;
      end
      else
      if ((aobj.italic) and (not aobj.bold)) then
      begin
       if not assigned(defaultfontit) then
        defaultfontit:=aobj
       else
       begin
        if (UpperCase(aobj.familyname)='LUXI SANS') then
        begin
         defaultfontit:=aobj;
        end;
       end;
      end
      else
      if ((aobj.italic) and (aobj.bold)) then
      begin
       if not assigned(defaultfontbit) then
        defaultfontbit:=aobj
       else
       begin
        if (UpperCase(aobj.familyname)='LUXI SANS') then
        begin
         defaultfontbit:=aobj;
        end;
       end;
      end;

      fontlist.AddObject(UpperCase(aobj.familyname),aobj);
     except
      aobj.free;
     end;
    end;
   finally
    FT_Done_Face(aface);
   end;
  end;
 end;
end;

constructor TRpFTInfoProvider.Create;
begin
 currentname:='';
 currentstyle:=0;
 crit:=TCriticalSection.Create;
end;


procedure FreeFontList;
var
 i:integer;
begin
 if assigned(fontlist) then
 begin
  for i:=0 to fontlist.count-1 do
  begin
   fontlist.Objects[i].free;
  end;
  fontlist.clear;
  fontlist.free;
  fontlist:=nil;
  fontpaths.free;
  fontfiles.free;
 end;
end;

destructor TRpFTInfoProvider.destroy;
begin
 crit.free;

 inherited destroy;
end;

procedure TRpFtInfoProvider.SelectFont(pdffont:TRpPDFFOnt);
var
 afontname:string;
 isbold:boolean;
 isitalic:boolean;
 i:integer;
 match:boolean;
 afont:TRpLogFont;
begin
 crit.Enter;
 try
  InitLibrary;
{$IFDEF MSWINDOWS}
 afontname:=UpperCase(pdffont.WFontName);
{$ENDIF}
{$IFDEF LINUX}
 afontname:=UpperCase(pdffont.LFontName);
{$ENDIF}
 if ((currentname=afontname) and (currentstyle=pdffont.Style)) then
  exit;
 currentname:=afontname;
 currentstyle:=pdffont.Style;
 // Selects de font by font matching
 // First exact coincidence of family and style
 isbold:=(pdffont.style and 1)>0;
 isitalic:=(pdffont.style and (1 shl 1))>0;
 match:=false;
 i:=0;
 while i<fontlist.Count do
 begin
  if fontlist.strings[i]=afontname then
  begin
   afont:=TRpLogFont(fontlist.Objects[i]);
   if isitalic=afont.italic then
    if isbold=afont.bold then
    begin
     match:=true;
     currentfont:=afont;
     break;
    end;
  end;
  inc(i);
 end;
 if match then
  exit;
 // If not matching search for similar font name
 i:=0;
 while i<fontlist.Count do
 begin
  if Pos(afontname,fontlist.strings[i])>0 then
  begin
   afont:=TRpLogFont(fontlist.Objects[i]);
   if isitalic=afont.italic then
    if isbold=afont.bold then
    begin
     match:=true;
     currentfont:=afont;
     break;
    end;
  end;
  inc(i);
 end;
 if match then
  exit;
 // Ignoring styles
 match:=false;
 i:=0;
 while i<fontlist.Count do
 begin
  if fontlist.strings[i]=afontname then
  begin
   afont:=TRpLogFont(fontlist.Objects[i]);
   match:=true;
   currentfont:=afont;
   break;
  end;
  inc(i);
 end;
 if match then
  exit;
 // Ignoring styles partial match
 match:=false;
 i:=0;
 while i<fontlist.Count do
 begin
  if Pos(afontname,fontlist.strings[i])>0 then
  begin
   afont:=TRpLogFont(fontlist.Objects[i]);
   match:=true;
   currentfont:=afont;
   break;
  end;
  inc(i);
 end;
 if match then
  exit;
 // Finally gets default font, but applying styles
 if ((not isbold) and (not isitalic)) then
  currentfont:=defaultfont
 else
 if ((isbold) and (not isitalic)) then
  currentfont:=defaultfontb
 else
 if ((not isbold) and (isitalic)) then
  currentfont:=defaultfontit
 else
  currentfont:=defaultfontbit;

 if not assigned(currentfont) then
  Raise Exception.Create('No active font');
 finally
  crit.Leave;
 end;
end;



procedure TRpFTInfoProvider.FillFontData(pdffont:TRpPDFFont;data:TRpTTFontData);
begin
 crit.Enter;
 try
  InitLibrary;
  // See if data can be embedded
  SelectFont(pdffont);
  data.fontdata.Clear;
  if not currentfont.type1 then
   data.fontdata.LoadFromFile(currentfont.filename);
  data.postcriptname:=currentfont.postcriptname;
  data.FamilyName:=currentfont.familyname;
  data.FaceName:=currentfont.familyname;
  data.Ascent:=currentfont.ascent;
  data.Descent:=currentfont.descent;
  data.Leading:=currentfont.leading;
  data.capHeight:=currentfont.Capheight;
  data.Encoding:='WinAnsiEncoding';
  data.FontWeight:=0;
  data.MaxWidth:=currentfont.MaxWidth;
  data.AvgWidth:=currentfont.avCharWidth;
  data.havekerning:=currentfont.havekerning;
  data.StemV:=0;
  data.FontStretch:='/Normal';
  data.fdata:=currentfont;
  data.FontBBox:=currentfont.BBox;
  if currentfont.italic then
   data.ItalicAngle:=-15
  else
   data.ItalicAngle:=0;
  data.StyleName:=currentfont.stylename;
  data.Flags:=32;
  if (currentfont.fixedpitch) then
   data.Flags:=data.Flags+1;
  if pdffont.Bold then
   data.postcriptname:=data.postcriptname+',Bold';
  if currentfont.italic then
    data.Flags:=data.Flags+64;
  if pdffont.Italic then
  begin
   if pdffont.Bold then
    data.postcriptname:=data.postcriptname+'Italic'
   else
     data.postcriptname:=data.postcriptname+',Italic';
  end;
  data.Type1:=currentfont.Type1;
 finally
   crit.Leave;
 end;
end;


function TRpFTInfoProvider.GetCharWidth(pdffont:TRpPDFFont;data:TRpTTFontData;charcode:widechar):integer;
var
 awidth:integer;
 aint:integer;
 width1,width2:word;
 cfont:TRpLogFont;
 dwidth:double;
begin
 aint:=Ord(charcode);
 if aint>255 then
  data.isunicode:=true;
 if data.loaded[aint] then
 begin
  Result:=data.loadedwidths[aint];
 end
 else
 begin
  cfont:=TRpLogFont(data.fdata);
  cfont.OpenFont;
  if 0=FT_Load_Char(cfont.ftface,Cardinal(charcode),FT_LOAD_NO_SCALE) then
  begin
   width1:=word(cfont.ftface.glyph.linearHoriAdvance shr 16);
   width2:=word((cfont.ftface.glyph.linearHoriAdvance shl 16) shr 16);
   dwidth:=width1+width2/65535;
   awidth:=Round(cfont.widthmult*dwidth);
  end
  else
   awidth:=0;
  data.loadedwidths[aint]:=awidth;
  data.loaded[aint]:=true;
  if data.firstloaded>aint then
   data.firstloaded:=aint;
  if data.lastloaded<aint then
   data.lastloaded:=aint;
  Result:=awidth;
  // Get glyph index
  data.loadedglyphs[aint]:=WideChar(FT_Get_Char_Index(cfont.ftface,Cardinal(charcode)));
  data.loadedg[aint]:=true;
 end;
end;

function TRpFTInfoProvider.GetKerning(pdffont:TRpPDFFont;data:TRpTTFontData;leftchar,rightchar:widechar):integer;
{$IFDEF USEKERNING}
var
 wl,wr:FT_UInt;
 akerning:FT_Vector;
 cfont:TRpLogFont;
{$ENDIF}
begin
{$IFNDEF USEKERNING}
  Result:=0;
  exit;
{$ENDIF}
{$IFDEF USEKERNING}
 REsult:=0;
 cfont:=TRpLogFont(data.fdata);
 if cfont.havekerning then
 begin
  cfont.OpenFont;
  wl:=FT_Get_Char_Index(cfont.ftface,Cardinal(leftchar));
  if wl>0 then
  begin
   wr:=FT_Get_Char_Index(cfont.ftface,Cardinal(rightchar));
   if wr>0 then
   begin
    CheckFreeType(FT_Get_Kerning(cfont.ftface,wl,wr,FT_KERNING_UNSCALED,akerning));
    result:=Round(cfont.widthmult*-akerning.x);
   end;
  end;
 end;
{$ENDIF}
end;

constructor TRpLogFont.Create;
begin
 faceinit:=false;
end;

destructor TRpLogFont.Destroy;
begin
 if faceinit then
  CheckFreeType(FT_Done_Face(ftface));
 inherited destroy;
end;

procedure TRpLogFont.OpenFont;
var
 kerningfile:string;
begin
 if faceinit then
  exit;
 CheckFreeType(FT_New_Face(ftlibrary,PChar(filename),0,ftface));
 faceinit:=true;
 if type1 then
 begin
  // Check for kening file for type1 font
  kerningfile:=ChangeFileExt(filename,'.afm');
  if FileExists(kerningfile) then
  begin
   CheckFreeType(FT_Attach_File(ftface,Pchar(kerningfile)));
  end;
 end;
 // Don't need scale, but this is a scale that returns
 // exact widht for pdf if you divide the result
 // of Get_Char_Width by 64
 CheckFreeType(FT_Set_Char_Size(ftface,0,64*100,720,720));
end;


initialization
 fontlist:=nil;
 initialized:=false;
finalization
 FreeFontList;
 if initialized then
  FT_Done_FreeType(ftlibrary);
end.
