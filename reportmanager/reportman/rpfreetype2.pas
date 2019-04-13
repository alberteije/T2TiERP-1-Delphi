(*******************************************************************
 *
 *  FreeType2.Pas
 *  Pas file generated from freetype.h Freetype2 library
 *  http://freetype.sourceforge.net
 *
 ******************************************************************)

unit rpfreetype2;

interface

{$I rpconf.inc}

uses
{$IFDEF LINUX}
 Libc,
{$ENDIF}
{$IFDEF MSWINDOWS}
 Windows,
{$ENDIF}
 SysUtils,rptypes;

const
{$IFDEF LINUX}
 C_FREETYPE='libfreetype.so';
{$ENDIF}
{$IFDEF MSWINDOWS}
 C_FREETYPE='freetype6.dll';
{$ENDIF}
 FT_LOAD_DEFAULT=$0;
 FT_LOAD_NO_SCALE=$1;
 FT_LOAD_NO_HINTING=$2;
 FT_LOAD_RENDER=$4;
 FT_LOAD_NO_BITMAP=$8;
 FT_LOAD_VERTICAL_LAYOUT=$10;
 FT_LOAD_FORCE_AUTOHINT=$20;
 FT_LOAD_CROP_BITMAP=$40;
 FT_LOAD_PEDANTIC=$80;
 FT_LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH=$200;
 FT_LOAD_NO_RECURSE=$400;
 FT_LOAD_IGNORE_TRANSFORM=$800;
 FT_LOAD_MONOCHROME=$1000;
 FT_LOAD_LINEAR_DESIGN=$2000;

 FT_FACE_FLAG_SCALABLE=1;
 FT_FACE_FLAG_SFNT=8;
 FT_FACE_FLAG_FIXED_WIDTH=4;
 FT_FACE_FLAG_KERNING=32;

 FT_STYLE_FLAG_ITALIC=1;
 FT_STYLE_FLAG_BOLD=2;

 FT_KERNING_DEFAULT  = 0;
 FT_KERNING_UNFITTED=1;
 FT_KERNING_UNSCALED=2;

type

  FT_F26Dot6=integer;

  FT_Library     = record z : Pointer; end;
  FT_SubGlyph= record z:Pointer;end;
  FT_Slot_Internal=record z:Pointer;end;
  FT_Size_Internal=record z:Pointer;end;
  FT_Driver=record z:Pointer;end;
  FT_Stream=record z:Pointer;end;
  FT_Int32=integer;
  FT_memory=record z:Pointer;end;
  FT_ListRec=record z:Pointer;end;
  FT_Face_Internal=record z:Pointer;end;
  FT_Int    = Integer;
  FT_Error = FT_Int;
  FT_Byte = Byte;
  PFT_Byte = ^Byte;
  FT_String = char;
  PFT_String = PChar;
  FT_Long = longint;
  FT_Pointer = Pointer;
  FT_ULong = Cardinal;
  FT_UInt = Cardinal;
  FT_Short=smallint;
  FT_UShort=Word;
  FT_Pos=integer;
  FT_Fixed=Integer;
  FT_Bitmap_Size=record
    height:FT_Short;
    width:FT_Short;
    size:FT_Pos;
    x_ppem:FT_Pos;
    y_ppem:FT_Pos;
  end;
  PFT_Bitmap_Size=^FT_Bitmap_Size;


  FT_Generic_Finalizer=procedure (aobject:Pointer);cdecl;
  FT_Generic=record
    data:Pointer;
    finalizer:FT_Generic_Finalizer;
  end;

  FT_Size_Metrics=record
    x_ppem:FT_UShort;      // horizontal pixels per EM               */
    y_ppem:FT_UShort;      // vertical pixels per EM                 */

    x_scale:FT_Fixed   ;     // two scales used to convert font units  */
    y_scale:FT_Fixed   ;     // to 26.6 frac. pixel coordinates        */

    ascender:FT_Pos     ;    // ascender in 26.6 frac. pixels          */
    descender:FT_Pos     ;   // descender in 26.6 frac. pixels         */
    height:FT_Pos     ;      // text height in 26.6 frac. pixels       */
    max_advance:FT_Pos     ; // max horizontal advance, in 26.6 pixels */
  end;

  FT_Glyph_Metrics=record
    width:FT_Pos;           // glyph width  */
    height:FT_Pos;        // glyph height */

    horiBearingX:FT_Pos;  // left side bearing in horizontal layouts */
    horiBearingY:FT_Pos;  // top side bearing in horizontal layouts  */
    horiAdvance:FT_Pos;   // advance width for horizontal layout     */

    vertBearingX:FT_Pos;  // left side bearing in vertical layouts */
    vertBearingY:FT_Pos ;  // top side bearing in vertical layouts  */
    vertAdvance:FT_Pos;   // advance height for vertical layout    */
  end;

  PFT_Vector=^FT_Vector;

  FT_Vector=record
    x:FT_Pos;
    y:FT_Pos;
  end;

  const
   FT_ENCODING_NONE=0;
//   FT_ENCODING_MS_SYMBOL=Ord('s') shl 24+Ord('y') shl 16 +Ord('m') shl 8+Ord('b');
   FT_ENCODING_UNICODE=Cardinal(Ord('u')) shl 24+Cardinal(Ord('n')) shl 16 +Cardinal(Ord('i')) shl 8+Cardinal(Ord('c'));

   FT_ENCODING_ADOBE_STANDARD=Cardinal(Ord('A')) shl 24+Cardinal(Ord('D')) shl 16 +Cardinal(Ord('O')) shl 8+Cardinal(Ord('B'));
//   FT_ENCODING_ADOBE_EXPERT=Ord('A') shl 24+Ord('D') shl 16 +Ord('B') shl 8+Ord('E');
//   FT_ENCODING_ADOBE_CUSTOM=Ord('A') shl 24+Ord('D') shl 16 +Ord('B') shl 8+Ord('C');
   FT_ENCODING_ADOBE_LATIN_1=(Cardinal(Ord('l')) shl 24)+Cardinal(Cardinal(Ord('a')) shl 16) +Cardinal(Cardinal(Ord('t')) shl 8)+Cardinal(Ord('1'));
   FT_ENCODING_OLD_LATIN_2=Cardinal(Ord('l') shl 24)+Cardinal(Ord('a') shl 16) +Cardinal(Ord('t') shl 8)+Cardinal(Ord('2'));
   FT_ENCODING_APLE_ROMAN=Cardinal(Ord('a')) shl 24+Cardinal(Ord('r')) shl 16 +Cardinal(Ord('m')) shl 8+Cardinal(Ord('n'));


  // None, Composite,bitmap,outline,plotter
  type
   FT_Glyph_Format=integer;
//  (0,1);
//   Ord('c') shl 24+Ord('o') shl 16 +Ord('m') shl 8+Ord('p')
//   );
   FT_Encoding=integer;

  FT_Bitmap=record
   rows:integer;
   width:integer;
   pitch:integer;
   buffer:PByte;
   num_grays:smallint;
   pixel_mode: char;
   palette_mode:char;
   palette:Pointer;
  end;

  FT_Face     = ^FT_FaceRec;

  FT_Outline=record
    n_contours:smallint;      //* number of contours in glyph        */
    n_points:smallint;        //* number of points in the glyph      */
    points:PFT_Vector;          //* the outline's points               */
    tags:Pchar;            //* the points flags                   */
    contours:^smallint ;        //* the contour end points             */

    flags:integer;           // outline masks                      */
  end;

  FT_GlyphSlot=^FT_GlyphSlotRec;

  FT_GlyphSlotRec=record
    alibrary:FT_Library;
    face:FT_Face;
    next:FT_GlyphSlot;
    reserved:FT_UInt;       //* retained for binary compatibility */
    generic:FT_Generic;
    metrics:FT_Glyph_Metrics;
    linearHoriAdvance:FT_Fixed;
    linearVertAdvance:FT_Fixed;
    advance:FT_Vector;

    format:FT_Glyph_Format;

    bitmap:FT_Bitmap;
    bitmap_left:FT_Int;
    bitmap_top:FT_Int;
    outline:FT_Outline;

    num_subglyphs:FT_UInt;
    subglyphs:FT_SubGlyph;

    control_data:Pointer;
    control_len:longint;

    other:Pointer;

    internal:FT_Slot_Internal;
  end;

  FT_BBox=record
    xMin, yMin:FT_Pos;
    xMax, yMax:FT_Pos  ;
  end;

  FT_SizeRec=record
    face:FT_Face;                 // parent face object              */
    generic:FT_Generic;   // generic pointer for client uses */
    metrics:FT_Size_Metrics;   // size metrics                    */
    internal:FT_Size_Internal;
  end;

  FT_Size=^FT_SizeRec;

  FT_CharMap  = ^FT_CharMapRec;

  FT_CharMapRec=record
    face:FT_Face;
    encoding:FT_Encoding;
    platform_id:FT_UShort;
    encoding_id:FT_UShort;
  end;
  PFT_CharMap  = ^FT_CharMap;

  FT_FaceRec=record
    num_faces:FT_Long;
    face_index:FT_Long;
    face_flags:FT_Long;
    style_flags:FT_Long;
    num_glyphs:FT_Long;
    family_name:PFT_String;
    style_name:PFT_String;
    num_fixed_sizes:FT_Int;
    available_sizes:PFT_Bitmap_Size;
    num_charmaps:FT_Int;
    charmaps:PFT_CharMap;
    generic:FT_Generic;

    //# the following are only relevant to scalable outlines */
    bbox:FT_BBox;
    units_per_EM:FT_UShort;
    ascender:FT_Short;
    descender:FT_Short;
    height:FT_Short;

    max_advance_width:FT_Short;
    max_advance_height:FT_Short;

    underline_position:FT_Short;
    underline_thickness:FT_Short;

    glyph:FT_GlyphSlot;
    size:FT_Size;
    charmap:FT_CharMap;

    //*@private begin */

    driver:FT_Driver         ;
    memory:FT_Memory         ;
    stream:FT_Stream         ;

    sizes_list:FT_ListRec        ;

    autohint:FT_Generic        ;
    extensions:Pointer;

    internal:FT_Face_Internal  ;

    //*@private end */
  end;



  FT_Module     = record z : Pointer; end;

  TFT_Init_FreeType =function (var alibrary:FT_Library):FT_Error;cdecl;
  TFT_Done_FreeType=function (alibrary:FT_Library):FT_Error;cdecl;
  TFT_New_Face=function (alibrary:FT_Library;filepathname:PChar;
               face_index:FT_Long;var aface:FT_Face):FT_Error;cdecl;
  TFT_Done_Face=function  (aface : FT_Face ) : FT_Error;cdecl;
  TFT_Attach_File=function (aface:FT_Face;filepathname:PChar):FT_Error;cdecl;


  FT_Parameter=record
    tag:FT_ULong;
    data:FT_Pointer;
  end;
  PFT_Parameter=^FT_Parameter;


  FT_Open_Args=record
    flags:FT_UInt;
    memory_base:PFT_Byte;
    memory_size:FT_Long;
    pathname:PFT_String;
    stream:FT_Stream;
    driver:FT_Module;
    num_params:FT_Int;
    params:PFT_Parameter;
   end;

  TFT_Set_Charmap=function (face:FT_Face; charmap:FT_CharMap  ):FT_Error;cdecl;
  TFT_Select_Charmap=function (face:FT_Face;encoding:FT_Encoding):FT_Error;cdecl;



  TFT_Get_Char_Index=function (face:FT_Face;charcode:FT_ULong):FT_UInt;cdecl;

  TFT_Load_Glyph=function (face:FT_Face;glyph_index:FT_UInt;
                 load_flags:FT_Int32 ):FT_Error;cdecl;

  TFT_Load_Char=function (face:FT_Face;char_code:FT_ULong;
                           load_flags:FT_Int32):FT_Error;cdecl;
  TFT_Set_Char_Size=function (face:FT_Face;char_width,char_height:FT_F26Dot6;
                           horz_resolution,vert_resolution:FT_UInt):FT_Error;cdecl;

  TFT_Get_Kerning=function (aface:FT_Face;left_glyph,right_glyph,kern_mode:FT_UInt;
                    var akerning:FT_Vector):FT_Error;cdecl;

  TFT_Get_First_Char=function (aface:FT_Face;var agindex:FT_UInt):FT_ULong;cdecl;
  TFT_Get_Next_Char=function (aface:FT_Face;char_code:FT_ULong;
                         var agindex:FT_UInt):FT_ULong;cdecl;

procedure CheckFreeTypeLoaded;
procedure LoadFreeType;
procedure FreeFreeType;
procedure CheckFreeType(avalue:FT_Error);

var
  FT_Init_FreeType:TFT_Init_FreeType;
  FT_Done_FreeType:TFT_Done_FreeType;
  FT_New_Face:TFT_New_Face;
  FT_Done_Face:TFT_Done_Face;
  FT_Get_Char_Index:TFT_Get_Char_Index;
  FT_Load_Glyph:TFT_Load_Glyph;
  FT_Set_Charmap:TFT_Set_Charmap;
  FT_Select_Charmap:TFT_Select_Charmap;
  FT_Load_Char:TFT_Load_Char;
  FT_Set_Char_Size:TFT_Set_Char_Size;
  FT_Attach_File:TFT_Attach_File;
  FT_Get_Kerning:TFT_Get_Kerning;
  FT_Get_First_Char:TFT_Get_First_Char;
  FT_Get_Next_Char:TFT_Get_Next_Char;

var
{$IFDEF MSWINDOWS}
 FreeTypeLib:HINST;
{$ENDIF}
{$IFDEF LINUX}
 FreeTypeLib:Pointer;
{$ENDIF}

implementation

procedure CheckFreeTypeLoaded;
begin
{$IFDEF LINUX}
 if Assigned(FreeTypeLib) then
  exit;
{$ENDIF}
{$IFDEF MSWINDOWS}
 if FreeTypeLib>HINSTANCE_ERROR then
  exit;
{$ENDIF}
 LoadFreeType;
end;

procedure LoadFreeType;
{$IFDEF MSWINDOWS}
  function GetProcAddr(ProcName: PChar): Pointer;
  begin
    Result := GetProcAddress(FreeTypeLib, ProcName);
    if not Assigned(Result) then
      RaiseLastOsError;
  end;
{$ENDIF}
{$IFDEF LINUX}
 function GetProcAddr(ProcName:Pchar):Pointer;
 begin
  Result:=dlsym(FreeTypeLib,ProcName);
  if not Assigned(Result) then
   raise Exception.Create(Format('Error loading %s,Error Code %s',[ProcName,dlerror]));
 end;
{$ENDIF}
begin
{$IFDEF LINUX}
 FreeTypeLib:=dlopen(Pchar(C_FREETYPE),RTLD_GLOBAL);
 if FreeTypeLib=nil then
  Raise Exception.Create('Error opening:'+C_FREETYPE);
{$ENDIF}

{$IFDEF MSWINDOWS}
  FreeTypeLib := LoadLibrary(PChar(C_FREETYPE));
  if (FreeTypeLib <= HINSTANCE_ERROR) then
   Raise Exception.Create('Error opening:'+C_FREETYPE);
{$ENDIF}

 // Load function addresses
 FT_Init_FreeType:=GetProcAddr('FT_Init_FreeType');
 FT_Done_FreeType:=GetProcAddr('FT_Done_FreeType');
 FT_New_Face:=GetProcAddr('FT_New_Face');
 FT_Done_Face:=GetProcAddr('FT_Done_Face');
 FT_Get_Char_Index:=GetProcAddr('FT_Get_Char_Index');
 FT_Load_Glyph:=GetProcAddr('FT_Load_Glyph');
 FT_Set_Charmap:=GetProcAddr('FT_Set_Charmap');
 FT_Select_Charmap:=GetProcAddr('FT_Select_Charmap');
 FT_Load_Char:=GetProcAddr('FT_Load_Char');
 FT_Set_Char_Size:=GetProcAddr('FT_Set_Char_Size');
 FT_Attach_File:=GetProcAddr('FT_Attach_File');
 FT_Get_Kerning:=GetProcAddr('FT_Get_Kerning');
 FT_Get_First_Char:=GetProcAddr('FT_Get_First_Char');
 FT_Get_Next_Char:=GetProcAddr('FT_Get_Next_Char');

end;

procedure FreeFreeType;
begin
{$IFDEF MSWINDOWS}
  if FreeTypeLib > HINSTANCE_ERROR then
  begin
    FreeLibrary(FreeTypeLib);
    FreeTypeLib := 0;
  end;
{$ENDIF}
 // Do nothing because the Linux Loader already frees it
end;

procedure CheckFreeType(avalue:FT_Error);
begin
 if avalue<>0 then
  Raise Exception.Create('Freetype 2 library error:'+IntToStr(avalue));
end;

initialization
{$IFDEF MSWINDOWS}
 FreeTypeLib:=HINSTANCE_ERROR;
{$ENDIF}
{$IFDEF LINUX}
 FreeTypeLib:=nil;
{$ENDIF}
finalization
 FreeFreeType;
end.
