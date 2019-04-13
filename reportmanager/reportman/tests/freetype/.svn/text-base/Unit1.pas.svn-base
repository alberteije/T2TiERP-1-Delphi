unit Unit1;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses rpfreetype;

{$R *.xfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 CheckFreeTypeLoaded;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 aface:TT_Face;
 aengine:TT_Engine;
 faceprop:TT_Face_Properties;
 inst:TT_Instance;
 i,j:integer;
 glyph:TT_Glyph;
 met:TT_Glyph_Metrics;
 charmap:TT_CharMap;
 w:word;
 namecount:integer;
 acount:integer;
 pstr:Pointer;
 astring:String;
 plainname:String;
 postcriptname:String;
 aplatform,aencoding,alanguage,nameid:integer;
begin
 CheckFreeType(TT_Init_FreeType(aengine));
 try
  CheckFreeType(TT_Open_Face(aengine,'/usr/X11R6/lib/X11/fonts/truetype/georgiai.ttf',aface));
  try
   CheckFreeType(TT_Get_Face_Properties(aface,faceprop));

   Label1.Caption:=IntToStr(faceprop.os2.usWinAscent);
   Label2.Caption:=IntToStr(-faceprop.os2.usWinDescent);

   namecount:=TT_Get_Name_Count(aface);
   for i:=0 to namecount-1 do
   begin
    astring:='';
    CheckFreeType(TT_Get_Name_ID(aface,i,aplatform,aencoding,alanguage,nameid));
    CheckFreeType(TT_Get_Name_String(aface,i,pstr,acount));
    for j:=0 to (acount div 2)-1 do
    begin
     astring:=astring+PChar(pstr)[j*2+1];
    end;
    if nameid=1 then
    begin
     Label3.Caption:=astring;
     plainname:=astring;
    end;
    if nameid=6 then
    begin
     Label4.Caption:=astring;
     postcriptname:=astring;
    end;
    Memo1.Lines.Add(astring);
   end;
   CheckFreeType(TT_New_Instance(aface,inst));
   try
    CheckFreeType(TT_Set_Instance_Resolutions(inst,72,72));
    CheckFreeType(TT_Set_Instance_CharSize(inst,1000));
    CheckFreeType(TT_New_Glyph(aface,glyph));
    try
     CheckFreeType(TT_Get_CharMap(aface,0,charmap));
     Label2.Caption:=IntToStr(TT_Get_CharMap_Count(aface));
     Edit1.Text:='';
     for i:=32 to 255 do
     begin
      w:=TT_Char_Index(charmap,i);
      CheckFreeType(TT_Load_Glyph(inst,glyph,w,TT_Load_Scale_Glyph));
      CheckFreeType(TT_Get_Glyph_Metrics(glyph,met));
      Edit1.Text:=Edit1.Text+IntToStr(met.advance)+' ';
     end;
    finally
     CheckFreeType(TT_Done_Glyph(glyph));
    end;
   finally
    CheckFreeType(TT_Done_Instance(inst));
   end;
  finally
   CheckFreeType(TT_Close_Face(aface));
  end;
 finally
  CheckFreeType(TT_Done_FreeType(aengine));
 end;
end;

end.
