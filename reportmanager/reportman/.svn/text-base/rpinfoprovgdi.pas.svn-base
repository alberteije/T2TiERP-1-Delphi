{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       TRpInfoProvider GDI                             }
{       Provides information about fonts                }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{                                                       }
{*******************************************************}

unit rpinfoprovgdi;

{$I rpconf.inc}


interface

uses Classes,SysUtils,Windows,rpinfoprovid,SyncObjs,
{$IFDEF DOTNETD}
 System.Runtime.InteropServices,
{$ENDIF}
    rpmdconsts,rptypes;

const
 MAXKERNINGS=10000;

type

 TGetCharPlac=function (DC: HDC; p2: PWideChar; p3, p4:integer;
   var p5: TGCPResults; p6: DWORD): DWORD;stdcall;
 // external 'gdi32.dll' name 'GetCharacterPlacementW'
 TRpGDIInfoProvider=class(TRpInfoProvider)
//  adc:HDC;
  fonthandle:THandle;
  currentname:String;
  currentstyle:integer;
  isnt:Boolean;
  GetCharPlac:TGetCharPlac;
  gdilib:THandle;
  procedure SelectFont(pdffont:TRpPDFFOnt);
  procedure FillFontData(pdffont:TRpPDFFont;data:TRpTTFontData);override;
  function GetCharWidth(pdffont:TRpPDFFont;data:TRpTTFontData;charcode:widechar):Integer;override;
  function GetKerning(pdffont:TRpPDFFont;data:TRpTTFontData;leftchar,rightchar:widechar):integer;override;
  constructor Create;
  destructor Destroy;override;
 end;

implementation

var
 adc:ThAndle;
 critsec:TCriticalSection;
const
 TTF_PRECISION=1000;


constructor TRpGDIInfoProvider.Create;
var
 ddc:THandle;
begin
 inherited Create;
 isnt:=IsWindowsNt;
 currentname:='';
 currentstyle:=0;
 fonthandle:=0;
 gdilib:=0;
 critsec.Enter;
 try
  if adc=0 then
  begin
   ddc:=GetDC(0);
   adc:=CreateCompatibleDC(ddc);
   ReleaseDC(0,ddc);
  end;
 finally
  critsec.Leave;
 end;
 if isnt then
 begin
  gdilib:=LoadLibrary('gdi32.dll');
  if gdilib=0 then
   RaiseLastOsError;
  GetCharPlac:=GetProcAddress(gdilib,'GetCharacterPlacementW');
  if not Assigned(GetCharPlac) then
   RaiseLastOsError;
 end;
end;

destructor TRpGDIInfoProvider.destroy;
begin
 if fonthandle<>0 then
  DeleteObject(fonthandle);
 if gdilib<>0 then
  FreeLibrary(gdilib);
 inherited destroy;
end;

procedure TRpGDIInfoProvider.SelectFont(pdffont:TRpPDFFOnt);
var
 LogFont:TLogFont;
{$IFDEF DOTNETD}
 i:integer;
{$ENDIF}
{$IFDEF DOTNETD}
 afontname:string;
{$ENDIF}
begin
 if ((currentname=pdffont.WFontName) and (currentstyle=pdffont.Style)) then
  exit;
 currentname:=pdffont.WFontName;
 currentstyle:=pdffont.Style;
 if fonthandle<>0 then
 begin
  DeleteObject(fonthandle);
  fonthandle:=0;
 end;
 LogFont.lfHeight:=Round(-TTF_PRECISION*GetDeviceCaps(adc,LOGPIXELSX)/72);

 LogFont.lfWidth:=0;
 LogFont.lfEscapement:=0;
 LogFont.lfOrientation:=0;

 if (pdffont.style and 1)>0 then
  LogFont.lfWeight:=FW_BOLD
 else
  LogFont.lfWeight:=FW_NORMAL;
 if (pdffont.style and (1 shl 1))>0 then
  LogFont.lfItalic:=1
 else
  LogFont.lfItalic:=0;
 if (pdffont.style and (1 shl 2))>0 then
  LogFont.lfUnderline:=1
 else
  Logfont.lfUnderline:=0;
 if (pdffont.style and (1 shl 3))>0 then
  LogFont.lfStrikeOut:=1
 else
  LogFont.lfStrikeOut:=0;
 LogFont.lfCharSet:=DEFAULT_CHARSET;
 lOGfONT.lfOutPrecision:=OUT_tt_onLy_PRECIS;
 LogFont.lfClipPrecision:=CLIP_DEFAULT_PRECIS;
 LogFont.lfEscapement:=0;
 LogFont.lfOrientation:=0;
 // Low Quality high measurement precision
 // LogFont.lfQuality:=Draft_QUALITY;
 // Improving quality
 LogFont.lfQuality:=PROOF_QUALITY;
 LogFont.lfPitchAndFamily:=FF_DONTCARE or DEFAULT_PITCH;
{$IFNDEF DOTNETD}
 StrPCopy(LogFont.lffACEnAME,Copy(pdffont.WFontName,1,LF_FACESIZE));
{$ENDIF}
{$IFDEF DOTNETD}
 afontname:=Copy(pdffont.WFontName,1,LF_FACESIZE);
 for i:=1 to Length(afontname) do
 begin
  LogFont.lfFaceName[i-1]:=afontname[i];
 end;
 LogFont.lfFaceName[Length(afontname)]:=chr(0);
{$ENDIF}
 Fonthandle:= CreateFontIndirect(LogFont);
 SelectObject(adc,fonthandle);
end;




{$IFNDEF DOTNETD}
procedure TRpGDIInfoProvider.FillFontData(pdffont:TRpPDFFont;data:TRpTTFontData);
var
{$IFNDEF DOTNETD}
 potm:POUTLINETEXTMETRIC;
{$ENDIF}
{$IFDEF DOTNETD}
 potm:^OUTLINETEXTMETRIC;
{$ENDIF}
 asize:integer;
 embeddable:boolean;
 logx:integer;
 multipli:double;
{$IFDEF DELPHI2009UP}
 apchar:PWideChar;
{$ELSE}
 apchar:PAnsiChar;
{$ENDIF}
 alog:LOGFONT;
 acomp:byte;
{$IFDEF USEKERNING}
 akernings:array [0..MAXKERNINGS] of KERNINGPAIR;
 numkernings:integer;
 langinfo:DWord;
 i:integer;
 index:integer;
 newsize:integer;
 klist:TStringList;
{$ENDIF}
begin
   // See if data can be embedded
   embeddable:=false;
   SelectFont(pdffont);
   logx:=GetDeviceCaps(adc,LOGPIXELSX);
   data.postcriptname:=StringReplace(pdfFont.WFontName,' ','',[rfReplaceAll]);
   data.Encoding:='WinAnsiEncoding';
{$IFDEF DELPHI2009UP}
   asize:=GetOutlineTextMetricsW(adc,0,nil);
{$ELSE}
   asize:=GetOutlineTextMetricsA(adc,0,nil);
{$ENDIF}
   if asize>0 then
   begin
{$IFNDEF DOTNETD}
    potm:=AllocMem(asize);
{$ENDIF}
{$IFDEF DOTNETD}
    potm:=Marshal.AllocHGlobal(sizeof(OUTLINETEXTMETRIC));
{$ENDIF}
    try

{$IFDEF DELPHI2009UP}
     newsize:=GetOutlineTextMetricsW(adc,asize,potm);
{$ELSE}
     newsize:=GetOutlineTextMetricsA(adc,asize,potm);
{$ENDIF}
     if (newsize<>0) then
     begin
      if (potm^.otmfsType AND $8000)=0 then
       embeddable:=true;
      multipli:=1/logx*72000/TTF_PRECISION;
      data.Ascent:=Round(potm^.otmTextMetrics.tmAscent*multipli);
      data.Descent:=-Round(potm^.otmTextMetrics.tmDescent*multipli);
      data.FontWeight:=potm^.otmTextMetrics.tmWeight;
      data.FontBBox:=potm^.otmrcFontBox;
      data.FontBBox.Left:=Round(data.FontBBox.Left*multipli);
      data.FontBBox.Right:=Round(data.FontBBox.Right*multipli);
      data.FontBBox.Bottom:=Round(data.FontBBox.Bottom*multipli);
      data.FontBBox.Top:=Round(data.FontBBox.Top*multipli);
      // CapHeight is not really correct, where to get?
      data.CapHeight:=Round(potm^.otmAscent*multipli);
      data.StemV:=0;
      data.MaxWidth:=Round(potm^.otmTextMetrics.tmMaxCharWidth*multipli);
      data.AvgWidth:=Round(potm^.otmTextMetrics.tmAveCharWidth*multipli);

      data.Leading:=Round((potm^.otmTextMetrics.tmExternalLeading+potm^.otmTextMetrics.tmInternalLeading)*multipli);
      // Windows does not allow Type1 fonts
      data.Type1:=false;

{$IFDEF DELPHI2009UP}
      apchar:=PWideChar(Integer(potm)+potm^.otmpFamilyName);
      data.FamilyName:=StrPas(PWideChar(apchar));
      apchar:=PWideChar(Integer(potm)+potm^.otmpFullName);
      data.FullName:=StrPas(apchar);
      apchar:=PWideChar(Integer(potm)+potm^.otmpStyleName);
      data.StyleName:=StrPas(apchar);
      apchar:=PWideChar(Integer(potm)+potm^.otmpFaceName);
      data.FaceName:=StrPas(apchar);
{$ELSE}
      apchar:=PAnsiChar(Integer(potm)+potm^.otmpFamilyName);
      data.FamilyName:=StrPas(apchar);
      apchar:=PAnsiChar(Integer(potm)+potm^.otmpFullName);
      data.FullName:=StrPas(apchar);
      apchar:=PAnsiChar(Integer(potm)+potm^.otmpStyleName);
      data.StyleName:=StrPas(apchar);
      apchar:=PAnsiChar(Integer(potm)+potm^.otmpFaceName);
      data.FaceName:=StrPas(apchar);
//      data.FamilyName:=StrPas(PAnsiChar(@apchar[Integer(potm^.otmpFamilyName)]));
//      data.FullName:=StrPas(PAnsiChar(@apchar[Integer(potm^.otmpFullName)]));
//      data.StyleName:=StrPas(PAnsiChar(@apchar[Integer(potm^.otmpStyleName)]));
//      data.FaceName:=StrPas(PAnsiChar(@apchar[Integer(potm^.otmpFaceName)]));
{$ENDIF}


      data.ItalicAngle:=Round(potm^.otmItalicAngle/10);
      if ((potm^.otmTextMetrics.tmPitchAndFamily AND TMPF_TRUETYPE)=0) then
       Raise Exception.Create(SRpNoTrueType+'-'+data.FaceName);
      data.postcriptname:=StringReplace(data.familyname,' ','',[rfReplaceAll]);
      // Italic emulation
      if pdffont.Bold then
        data.postcriptname:=data.postcriptname+',Bold';
      if pdffont.Italic then
//       if data.ItalicAngle=0 then
//       begin
      if pdffont.Bold then
        data.postcriptname:=data.postcriptname+'Italic'
      else
        data.postcriptname:=data.postcriptname+',Italic';
//       end;
      //
      data.Flags:=32;
      // Fixed pitch? Doc says inverse meaning
      if ((potm^.otmTextMetrics.tmPitchAndFamily AND TMPF_FIXED_PITCH)=0) then
       data.Flags:=data.Flags+1;
      if GetObject(FontHandle,sizeof(alog),@alog)>0 then
      begin
       acomp:=(alog.lfPitchAndFamily AND $C0);
       if ((acomp or FF_SCRIPT)=alog.lfPitchAndFamily) then
        data.Flags:=data.Flags+8;
       if ((acomp or FF_ROMAN)=alog.lfPitchAndFamily) then
        data.Flags:=data.Flags+2;
      end;
      if Round(potm^.otmItalicAngle/10)<>0 then
//      if potm^.otmTextMetrics.tmItalic<>0 then
       data.Flags:=data.Flags+64;
      data.FontStretch:='/Normal';
     end;
    finally
     FreeMem(potm);
    end;
{$IFNDEF USEKERNING}
    data.havekerning:=false;
{$ENDIF}
{$IFDEF USEKERNING}
    // Get kerning pairs feature
    langinfo:=GetFontLanguageInfo(adc);
    data.havekerning:=(langinfo AND GCP_USEKERNING)>0;
    numkernings:=0;
    if data.havekerning then
    begin
     numkernings:=GetKerningPairs(adc,MAXKERNINGS,akernings[0]);
     if numkernings<0 then
     begin
      numkernings:=0;
     end;
    end;
    if numkernings>0 then
    begin
     for i:=0 to numkernings-1 do
     begin
      data.loadedk[akernings[i].wFirst]:=true;
      index:=data.kerningsadded.IndexOf(FormatFloat('000000',akernings[i].wFirst));
      if index>=0 then
       klist:=data.loadedkernings[akernings[i].wFirst]
      else
      begin
       klist:=TStringList.Create;
       klist.sorted:=true;
       data.loadedkernings[akernings[i].wFirst]:=klist;
       data.kerningsadded.Add(FormatFloat('000000',akernings[i].wFirst));
      end;
      klist.AddObject(FormatFloat('000000',akernings[i].wSecond),
       TObject(Round(-akernings[i].iKernAmount/logx*72000/TTF_PRECISION)));
     end;
    end;
{$ENDIF}
   end;

   if embeddable then
   begin
    asize:=GetFontData(adc,0,0,nil,0);
    if asize>0 then
    begin
     // Gets the raw data of the font
     data.FontData.SetSize(asize);
     if GDI_ERROR=GetFontData(adc,0,0,data.FontData.Memory,asize) then
      RaiseLastOSError;
     data.FontData.Seek(0,soFromBeginning);
    end;
   end;
end;
{$ENDIF}



{$IFDEF DOTNETD}
{$UNSAFECODE ON}
function TRpGDIInfoProvider.GetCharWidth(pdffont:TRpPDFFont;data:TRpTTFontData;charcode:widechar):integer;unsafe;
var
 logx:integer;
 aabc:array [1..1] of ABC;
 aint:Word;
 glyphindex:UInt;
 gcp:windows.tagGCP_RESULTS;
 astring:WideString;
begin
 glyphindex:=0;
 aint:=Ord(charcode);
 if (not (data.isunicode)) then
   data.isunicode:=true;
 if isnt then
 begin
  if aint>255 then
   data.isunicode:=true;
 end;
 if data.loaded[aint] then
 begin
  Result:=data.loadedwidths[aint];
   exit;
 end;
 SelectFont(pdffont);
 logx:=GetDeviceCaps(adc,LOGPIXELSX);
 if isnt then
 begin
  if not GetCharABCWidthsW(adc,aint,aint,aabc[1]) then
   RaiseLastOSError;
  gcp.lStructSize:=sizeof(gcp);
  gcp.lpOutString:=nil;
  gcp.lpOrder:=nil;
  gcp.lpDx:=nil;
  gcp.lpCaretPos:=nil;
  gcp.lpClass:=nil;
  gcp.lpGlyphs:=IntPtr(@glyphindex);
  gcp.nGlyphs:=1;
  gcp.nMaxFit:=1;
  astring:='';
  astring:=astring+charcode+Widechar(0);
  if GetCharacterPlacementW(adc,astring,true,false,gcp,GCP_DIACRITIC)=0 then
   RaiseLastOSError;
  data.loadedglyphs[aint]:=WideChar(glyphindex);
  data.loadedg[aint]:=true;
 end
 else
 begin
  if not GetCharABCWidths(adc,Cardinal(chr(aint)),Cardinal(chr(aint)),aabc[1]) then
    RaiseLastOSError;
 end;
 Result:=Round(
   (Integer(aabc[1].abcA)+Integer(aabc[1].abcB)+Integer(aabc[1].abcC))/logx*72000/TTF_PRECISION
   );
 data.loadedwidths[aint]:=Result;
 data.loaded[aint]:=true;
 if data.firstloaded>aint then
  data.firstloaded:=aint;
 if data.lastloaded<aint then
  data.lastloaded:=aint;
end;
{$UNSAFECODE OFF}
{$ENDIF}

{$IFNDEF DOTNETD}
function TRpGDIInfoProvider.GetCharWidth(pdffont:TRpPDFFont;data:TRpTTFontData;charcode:widechar):integer;
var
 logx:integer;
 aabc:array [1..1] of ABC;
 aint:Word;
 glyphindex:UInt;
{$IFNDEF DELPHI2009UP}
{$IFDEF VER180}
 gcp:windows.tagGCP_RESULTSW;
{$ENDIF}
{$IFNDEF VER180}
 gcp:windows.tagGCP_RESULTSA;
{$ENDIF}
{$ENDIF}
{$IFDEF DELPHI2009UP}
 gcp:windows.tagGCP_RESULTSW;
{$ENDIF}

 astring:WideString;
begin
 glyphindex:=0;
 aint:=Ord(charcode);
 if isnt then
 begin
  if aint>255 then
   data.isunicode:=true;
 end;
 if data.loaded[aint] then
 begin
  Result:=data.loadedwidths[aint];
   exit;
 end;
 SelectFont(pdffont);
 logx:=GetDeviceCaps(adc,LOGPIXELSX);
 if isnt then
 begin
  if not GetCharABCWidthsW(adc,aint,aint,aabc[1]) then
   RaiseLastOSError;
  gcp.lStructSize:=sizeof(gcp);
  gcp.lpOutString:=nil;
  gcp.lpOrder:=nil;
  gcp.lpDx:=nil;
  gcp.lpCaretPos:=nil;
  gcp.lpClass:=nil;
  gcp.lpGlyphs:=@glyphindex;
  gcp.nGlyphs:=1;
  gcp.nMaxFit:=1;
  astring:='';
  astring:=astring+charcode+Widechar(0);
{$IFDEF CHARPLACBOOL}
  if GetCharPlac(adc,PWideChar(astring),1,9,gcp,GCP_DIACRITIC)=0 then
   RaiseLastOSError;
{$ENDIF}
{$IFNDEF CHARPLACBOOL}
  if GetCharacterPlacementW(adc,PWideChar(astring),1,0,gcp,GCP_DIACRITIC)=0 then
   RaiseLastOSError;
{$ENDIF}
  data.loadedglyphs[aint]:=WideChar(glyphindex);
  data.loadedg[aint]:=true;
 end
 else
 begin
  if not GetCharABCWidths(adc,Cardinal(chr(aint)),Cardinal(chr(aint)),aabc[1]) then
    RaiseLastOSError;
 end;
 Result:=Round(
   (Integer(aabc[1].abcA)+Integer(aabc[1].abcB)+Integer(aabc[1].abcC))/logx*72000/TTF_PRECISION
   );
 data.loadedwidths[aint]:=Result;
 data.loaded[aint]:=true;
 if data.firstloaded>aint then
  data.firstloaded:=aint;
 if data.lastloaded<aint then
  data.lastloaded:=aint;
end;
{$ENDIF}


function TRpGDIInfoProvider.GetKerning(pdffont:TRpPDFFont;data:TRpTTFontData;leftchar,rightchar:widechar):integer;
{$IFDEF USEKERNING}
var
 index:integer;
 alist:TStringList;
 aint:Integer;
{$ENDIF}
begin
{$IFNDEF USEKERNING}
 Result:=0;
 exit;
{$ENDIF}
{$IFDEF USEKERNING}
 // Looks for the cached kerning
 Result:=0;
 aint:=Integer(leftchar);
 if data.loadedk[aint] then
 begin
  alist:=data.loadedkernings[aint];
  index:=alist.IndexOf(FormatFloat('000000',Integer(rightchar)));
  if index>=0 then
   Result:=Integer(alist.Objects[index])
 end;
{$ENDIF}
end;

initialization
adc:=0;
critsec:=TCriticalSection.Create;
finalization
if adc<>0 then
 ReleaseDC(0,adc);
critsec.Free;

end.
