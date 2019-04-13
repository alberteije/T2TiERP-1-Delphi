{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       TRppdffile                                      }
{       PDF Generator                                   }
{                                                       }
{       Code Base From Nishita's PDF Creation (TNPDF)   }
{       info@nishita.com                                }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       Converted to CLX (not Visual CLX)               }
{       and added lot functionality                     }
{       and bug fixes                                   }
{       Changed names to borland coding style           }
{       Added Canvas object                             }
{                                                       }
{       Added:                                          }
{               -Font Color                             }
{               -Text parsing                           }
{               -Filled Regions, pen color and b.color  }
{               -Pen Style                              }
{               -Resolution 1440 p.p.i                  }
{               -Exact position for text...             }
{               -Text clipping                          }
{               -Ellipse, true Rectangle                }
{               -Text alignment                         }
{               -Multiline and wordbreak                }
{               -Multiline alignment                    }
{               -Underline and strokeout                }
{               -Type1 Font selection bold/italic       }
{               -BMP and JPEG Image support             }
{               -Embedding True Type fonts              }
{               -Truetype Unicode support               }
{                                                       }
{                                                       }
{       Still Missing:                                  }
{               -Brush Patterns                         }
{               -RLE and monocrhome Bitmaps             }
{               -RoundRect                              }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace the functionality of this file    }
{       you must provide source code                    }
{                                                       }
{                                                       }
{*******************************************************}

unit rppdffile;

interface

{$I rpconf.inc}

uses Classes,Sysutils,rpinfoprovid,
{$IFDEF USEVARIANTS}
 Types,
{$ENDIF}
{$IFDEF USEZLIB}
{$IFDEF DELPHI2009UP}
 zlib,
{$ENDIF}
{$IFNDEF DELPHI2009UP}
 rpmzlib,
{$ENDIF}
{$ENDIF}
{$IFDEF MSWINDOWS}
 rpinfoprovgdi,Windows,
{$ENDIF}
{$IFDEF DOTNETD}
 Graphics,System.Runtime.InteropServices,
{$ENDIF}
{$IFDEF LINUX}
 rpinfoprovft,
{$ENDIF}
 rpmdconsts,rptypes,rpmunits;


const
 PDF_HEADER:string='%PDF-1.4';
 CONS_PDFRES=POINTS_PER_INCHESS;
 CONS_UNDERLINEWIDTH=0.1;
 CONS_SRIKEOUTWIDTH=0.05;
 CONS_UNDERLINEPOS=1.1;
 CONS_STRIKEOUTPOS=0.7;
 CONS_UNICODEPREDIX='';
type


 TRpPDFFile=class;


 TRpPageInfo=class(TObject)
  public
   APageWidth,APageHeight:integer
 end;

 TRpPDFCanvas=class(TObject)
  private
   FInfoProvider:TRpInfoProvider;
   FDefInfoProvider:TRpInfoProvider;
   FFont:TRpPDFFont;
   FFile:TRpPDFFile;
   FResolution:integer;
   FLineInfoMaxItems:integer;
   FLineInfoCount:integer;
   FFontTTData:TStringList;
   FImageIndexes:TStringList;
{$IFDEF MSWINDOWS}
   FGDIInfoProvider:TRpGDIInfoProvider;
{$ENDIF}
{$IFDEF LINUX}
  FFtInfoProvider:TRpFtInfoProvider;
{$ENDIF}
   procedure NewLineInfo(info:TRpLineInfo);
   procedure SetDash;
   procedure SaveGraph;
   procedure RestoreGraph;
   procedure SetInfoProvider(aprov:TRpInfoProvider);
   function GetTTFontData:TRpTTFontData;
   function EncodeUnicode(astring:Widestring;adata:TRpTTFontData;pdffont:TRpPDFFont):string;
  public
   PenColor:integer;
   PenStyle:integer;
   PenWidth:integer;
   BrushColor:integer;
   BrushStyle:integer;
   procedure GetStdLineSpacing(var linespacing,leading:integer);
   property InfoProvider:TRpInfoProvider read FInfoProvider write SetInfoProvider;
   function UnitsToTextX(Value:integer):string;
   function UnitsToTextY(Value:integer):string;
   function UnitsToTextText(Value:integer;FontSize:integer):string;
   procedure Line(x1,y1,x2,y2:Integer);
   procedure TextOut(X, Y: Integer; const Text: Widestring;LineWidth,
    Rotation:integer;RightToLeft:Boolean);
   procedure TextRect(ARect: TRect; Text: Widestring;
                       Alignment: integer; Clipping: boolean;
                       Wordbreak:boolean;Rotation:integer;RightToLeft:Boolean);
   procedure Rectangle(x1,y1,x2,y2:Integer);
   procedure DrawImage(rec:TRect;abitmap:TStream;dpires:integer;
    tile:boolean;clip:boolean;intimageindex:integer);
   procedure Ellipse(X1, Y1, X2, Y2: Integer);
   constructor Create(AFile:TRpPDFFile);
   destructor Destroy;override;
   function CalcCharWidth(charcode:Widechar;fontdata:TRpTTFontData):double;
   function UpdateFonts:TRpTTFontData;
   procedure FreeFonts;
   function PDFCompatibleTextWidthKerning(astring:WideString;adata:TRpTTFontData;pdffont:TRpPDFFont):String;
  public
   LineInfo:array of TRpLineInfo;
   procedure TextExtent(const Text:WideString;var Rect:TRect;wordbreak:boolean;
    singleline:boolean);
   property LineInfoMaxItems:integer read FLineInfoMaxItems;
   property LineInfoCount:integer read FLineInfoCount;

   property Font:TRpPDFFont read FFOnt;
  end;

 TRpPDFFile=class(TComponent)
  private
   FPageInfos:TStringList;
   FCanvas:TRpPDFCanvas;
   FPrinting:Boolean;
   FCompressed:boolean;
   FFilename:string;
   FDocTitle:string;
   FDocAuthor:string;
   FDocCreator:string;
   FDocKeywords:string;
   FDocSubject:string;
   FDocProducer:string;
   FMainPDF:TMemoryStream;
   FStreamValid:boolean;
   FTempStream:TMemoryStream;
   FsTempStream:TMemoryStream;
   FPage:integer;
   FPages:TStringList;
   FObjectOffsets:TStringList;
   FObjectCount:integer;
   FObjectOffset:integer;
   FStreamSize1,FStreamSize2:LongInt;
   FOutlinesNum:integer;
   FFontCount:integer;
   FFontList:TStringList;
   FParentNum:integer;
   FImageCount:integer;
   FResourceNum,FCatalogNum:integer;
   FCurrentSetPageObject:integer;
{$IFDEF USEZLIB}
   FCompressionStream:TCompressionStream;
{$ENDIF}
   FResolution:integer;
   FBitmapStreams:TList;
   // Minimum page size in 72 dpi 18x18
   // Maximum page size in 72 dpi 14.400x14.400
   FPageWidth,FPageHeight:integer;
   function GetStream:TMemoryStream;
   procedure CheckPrinting;
   procedure AddToOffset(offset:LongInt);
   procedure StartStream;
   procedure EndStream;
   procedure SetOutLine;
   procedure SetFontType;
   procedure CreateFont(Subtype,BaseFont,Encoding:string);
   procedure SetPages;
   procedure SetPageObject(index:integer);
   procedure SetArray;
   procedure SetCatalog;
   procedure SetXref;
   function GetOffsetNumber(offset:string):string;
   procedure SetResolution(Newres:integer);
   procedure ClearBitmaps;
   procedure WriteBitmap(index:Integer);
   procedure FreePageInfos;
 public
   DestStream:TStream;
   procedure BeginDoc;
   procedure NewPage(NPageWidth,NPageHeight:integer);
   procedure EndDoc;
   procedure AbortDoc;
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
   property Canvas:TRpPDFCanvas read FCanvas;
   property Printing:Boolean read FPrinting;
   property Stream:TMemoryStream read GetStream;
   property StreamValid:Boolean read FStreamValid;
   property MainPDF:TMemoryStream read FMainPDF;
  published
   // General properties
   property Compressed:boolean read FCompressed write FCompressed default true;
   property Filename:string read FFilename write FFilename;
   // Doc Info Props
   property DocTitle:string read FDocTitle write FDocTitle;
   property DocAuthor:string read FDocAuthor write FDocAuthor;
   property DocCreator:string read FDocCreator write FDocCreator;
   property DocKeywords:string read FDocKeywords write FDocKeywords;
   property DocSubject:string read FDocSubject write FDocSubject;
   property DocProducer:string read FDocProducer write FDocProducer;
   // Document physic
   property PageWidth:integer read FPageWidth write FPageWidth;
   property PageHeight:integer read FPageHeight write FPageHeight;
   property Resolution:integer read FResolution write SetResolution default TWIPS_PER_INCHESS;
  end;



function PDFCompatibleText (astring:Widestring;adata:TRpTTFontData;pdffont:TRpPDFFont):String;
function NumberToText (Value:double):string;

procedure GetBitmapInfo (stream:TStream; var width, height, imagesize:integer;FMemBits:TMemoryStream;
 var indexed:boolean;var bitsperpixel,usedcolors:integer;var palette:string);
procedure GetJPegInfo(astream:TStream;var width,height:integer;var format:string);

implementation

function IntToHex(nvalue:integer):string;
begin
 Result:=Format('%4.4x',[nvalue]);
end;

const
 AlignmentFlags_SingleLine=64;
 AlignmentFlags_AlignHCenter = 4 { $4 };
 AlignmentFlags_AlignHJustify = 1024 { $400 };
 AlignmentFlags_AlignTop = 8 { $8 };
 AlignmentFlags_AlignBottom = 16 { $10 };
 AlignmentFlags_AlignVCenter = 32 { $20 };
 AlignmentFlags_AlignLeft = 1 { $1 };
 AlignmentFlags_AlignRight = 2 { $2 };

// Font sizes (point 10)


  Helvetica_Widths: TWinAnsiWidthsArray = (
    278,278,355,556,556,889,667,191,333,333,389,584,278,333,
    278,278,556,556,556,556,556,556,556,556,556,556,278,278,584,584,
    584,556,1015,667,667,722,722,667,611,778,722,278,500,667,556,833,
    722,778,667,778,722,667,611,722,667,944,667,667,611,278,278,278,
    469,556,333,556,556,500,556,556,278,556,556,222,222,500,222,833,
    556,556,556,556,333,500,278,556,500,722,500,500,500,334,260,334,
    584,0,556,0,222,556,333,1000,556,556,333,1000,667,333,1000,0,
    611,0,0,222,222,333,333,350,556,1000,333,1000,500,333,944,0,
    500,667,0,333,556,556,556,556,260,556,333,737,370,556,584,0,
    737,333,400,584,333,333,333,556,537,278,333,333,365,556,834,834,
    834,611,667,667,667,667,667,667,1000,722,667,667,667,667,278,278,
    278,278,722,722,778,778,778,778,778,584,778,722,722,722,722,667,
    667,611,556,556,556,556,556,556,889,500,556,556,556,556,278,278,
    278,278,556,556,556,556,556,556,556,584,611,556,556,556,556,500,
    556,500);

 Default_Font_Width:integer=600;

 Helvetica_Bold_Widths: TWinAnsiWidthsArray = (
    278,333,474,556,556,889,722,238,333,333,389,584,278,333,
    278,278,556,556,556,556,556,556,556,556,556,556,333,333,584,584,
    584,611,975,722,722,722,722,667,611,778,722,278,556,722,611,833,
    722,778,667,778,722,667,611,722,667,944,667,667,611,333,278,333,
    584,556,333,556,611,556,611,556,333,611,611,278,278,556,278,889,
    611,611,611,611,389,556,333,611,556,778,556,556,500,389,280,389,
    584,0,556,0,278,556,500,1000,556,556,333,1000,667,333,1000,0,
    611,0,0,278,278,500,500,350,556,1000,333,1000,556,333,944,0,
    500,667,0,333,556,556,556,556,280,556,333,737,370,556,584,0,
    737,333,400,584,333,333,333,611,556,278,333,333,365,556,834,834,
    834,611,722,722,722,722,722,722,1000,722,667,667,667,667,278,278,
    278,278,722,722,778,778,778,778,778,584,778,722,722,722,722,667,
    667,611,556,556,556,556,556,556,889,556,556,556,556,556,278,278,
    278,278,611,611,611,611,611,611,611,584,611,611,611,611,611,556,
    611,556);

 Helvetica_Italic_Widths: TWinAnsiWidthsArray = (
    278,278,355,556,556,889,667,191,333,333,389,584,278,333,
    278,278,556,556,556,556,556,556,556,556,556,556,278,278,584,584,
    584,556,1015,667,667,722,722,667,611,778,722,278,500,667,556,833,
    722,778,667,778,722,667,611,722,667,944,667,667,611,278,278,278,
    469,556,333,556,556,500,556,556,278,556,556,222,222,500,222,833,
    556,556,556,556,333,500,278,556,500,722,500,500,500,334,260,334,
    584,0,556,0,222,556,333,1000,556,556,333,1000,667,333,1000,0,
    611,0,0,222,222,333,333,350,556,1000,333,1000,500,333,944,0,
    500,667,0,333,556,556,556,556,260,556,333,737,370,556,584,0,
    737,333,400,584,333,333,333,556,537,278,333,333,365,556,834,834,
    834,611,667,667,667,667,667,667,1000,722,667,667,667,667,278,278,
    278,278,722,722,778,778,778,778,778,584,778,722,722,722,722,667,
    667,611,556,556,556,556,556,556,889,500,556,556,556,556,278,278,
    278,278,556,556,556,556,556,556,556,584,611,556,556,556,556,500,
    556,500);

  Helvetica_BoldItalic_Widths: TWinAnsiWidthsArray = (
    278,333,474,556,556,889,722,238,333,333,389,584,278,333,
    278,278,556,556,556,556,556,556,556,556,556,556,333,333,584,584,
    584,611,975,722,722,722,722,667,611,778,722,278,556,722,611,833,
    722,778,667,778,722,667,611,722,667,944,667,667,611,333,278,333,
    584,556,333,556,611,556,611,556,333,611,611,278,278,556,278,889,
    611,611,611,611,389,556,333,611,556,778,556,556,500,389,280,389,
    584,0,556,0,278,556,500,1000,556,556,333,1000,667,333,1000,0,
    611,0,0,278,278,500,500,350,556,1000,333,1000,556,333,944,0,
    500,667,0,333,556,556,556,556,280,556,333,737,370,556,584,0,
    737,333,400,584,333,333,333,611,556,278,333,333,365,556,834,834,
    834,611,722,722,722,722,722,722,1000,722,667,667,667,667,278,278,
    278,278,722,722,778,778,778,778,778,584,778,722,722,722,722,667,
    667,611,556,556,556,556,556,556,889,556,556,556,556,556,278,278,
    278,278,611,611,611,611,611,611,611,584,611,611,611,611,611,556,
    611,556);

  TimesRoman_Widths: TWinAnsiWidthsArray = (
    250,333,408,500,500,833,778,180,333,333,500,564,250,333,
    250,278,500,500,500,500,500,500,500,500,500,500,278,278,564,564,
    564,444,921,722,667,667,722,611,556,722,722,333,389,722,611,889,
    722,722,556,722,667,556,611,722,722,944,722,722,611,333,278,333,
    469,500,333,444,500,444,500,444,333,500,500,278,278,500,278,778,
    500,500,500,500,333,389,278,500,500,722,500,500,444,480,200,480,
    541,0,500,0,333,500,444,1000,500,500,333,1000,556,333,889,0,
    611,0,0,333,333,444,444,350,500,1000,333,980,389,333,722,0,
    444,722,0,333,500,500,500,500,200,500,333,760,276,500,564,0,
    760,333,400,564,300,300,333,500,453,250,333,300,310,500,750,750,
    750,444,722,722,722,722,722,722,889,667,611,611,611,611,333,333,
    333,333,722,722,722,722,722,722,722,564,722,722,722,722,722,722,
    556,500,444,444,444,444,444,444,667,444,444,444,444,444,278,278,
    278,278,500,500,500,500,500,500,500,564,500,500,500,500,500,500,
    500,500);

  TimesRoman_Italic_Widths: TWinAnsiWidthsArray = (
    250,333,420,500,500,833,778,214,333,333,500,675,250,333,
    250,278,500,500,500,500,500,500,500,500,500,500,333,333,675,675,
    675,500,920,611,611,667,722,611,611,722,722,333,444,667,556,833,
    667,722,611,722,611,500,556,722,611,833,611,556,556,389,278,389,
    422,500,333,500,500,444,500,444,278,500,500,278,278,444,278,722,
    500,500,500,500,389,389,278,500,444,667,444,444,389,400,275,400,
    541,0,500,0,333,500,556,889,500,500,333,1000,500,333,944,0,
    556,0,0,333,333,556,556,350,500,889,333,980,389,333,667,0,
    389,556,0,389,500,500,500,500,275,500,333,760,276,500,675,0,
    760,333,400,675,300,300,333,500,523,250,333,300,310,500,750,750,
    750,500,611,611,611,611,611,611,889,667,611,611,611,611,333,333,
    333,333,722,667,722,722,722,722,722,675,722,722,722,722,722,556,
    611,500,500,500,500,500,500,500,667,444,444,444,444,444,278,278,
    278,278,500,500,500,500,500,500,500,675,500,500,500,500,500,444,
    500,444);

  TimesRoman_Bold_Widths: TWinAnsiWidthsArray = (
    250,333,555,500,500,1000,833,278,333,333,500,570,250,333,
    250,278,500,500,500,500,500,500,500,500,500,500,333,333,570,570,
    570,500,930,722,667,722,722,667,611,778,778,389,500,778,667,944,
    722,778,611,778,722,556,667,722,722,1000,722,722,667,333,278,333,
    581,500,333,500,556,444,556,444,333,500,556,278,333,556,278,833,
    556,500,556,556,444,389,333,556,500,722,500,500,444,394,220,394,
    520,0,500,0,333,500,500,1000,500,500,333,1000,556,333,1000,0,
    667,0,0,333,333,500,500,350,500,1000,333,1000,389,333,722,0,
    444,722,0,333,500,500,500,500,220,500,333,747,300,500,570,0,
    747,333,400,570,300,300,333,556,540,250,333,300,330,500,750,750,
    750,500,722,722,722,722,722,722,1000,722,667,667,667,667,389,389,
    389,389,722,722,778,778,778,778,778,570,778,722,722,722,722,722,
    611,556,500,500,500,500,500,500,722,444,444,444,444,444,278,278,
    278,278,500,556,500,500,500,500,500,570,500,556,556,556,556,500,
    556,500);

  TimesRoman_BoldItalic_Widths: TWinAnsiWidthsArray = (
    250,389,555,500,500,833,778,278,333,333,500,570,250,333,
    250,278,500,500,500,500,500,500,500,500,500,500,333,333,570,570,
    570,500,832,667,667,667,722,667,667,722,778,389,500,667,611,889,
    722,722,611,722,667,556,611,722,667,889,667,611,611,333,278,333,
    570,500,333,500,500,444,500,444,333,500,556,278,278,500,278,778,
    556,500,500,500,389,389,278,556,444,667,500,444,389,348,220,348,
    570,0,500,0,333,500,500,1000,500,500,333,1000,556,333,944,0,
    611,0,0,333,333,500,500,350,500,1000,333,1000,389,333,722,0,
    389,611,0,389,500,500,500,500,220,500,333,747,266,500,606,0,
    747,333,400,570,300,300,333,576,500,250,333,300,300,500,750,750,
    750,500,667,667,667,667,667,667,944,667,667,667,667,667,389,389,
    389,389,722,722,722,722,722,722,722,570,722,722,722,722,722,611,
    611,500,500,500,500,500,500,500,722,444,444,444,444,444,278,278,
    278,278,500,556,500,500,500,500,500,570,500,556,556,556,556,444,
    500,444);




// Writes a line into a Stream that is add #13+#10
procedure SWriteLine(Stream:TStream;astring:string);
begin
 astring:=astring+#13+#10;
 WriteStringToStream(astring,Stream);
end;



constructor TrpPDFCanvas.Create(AFile:TRpPDFFile);
begin
 inherited Create;

 FImageIndexes:=TStringList.Create;
 FImageIndexes.Sorted:=true;
{$IFDEF MSWINDOWS}
 FGDIInfoProvider:=TRpGDIInfoProvider.Create;
 FInfoProvider:=FGDIInfoProvider;
{$ENDIF}
{$IFDEF LINUX}
 FFtInfoProvider:=TRpFtInfoProvider.Create;
 FInfoProvider:=FFtInfoProvider;
{$ENDIF}
 FDefInfoProvider:=FInfoProvider;
 FFont:=TRpPDFFont.Create;
 FFile:=AFile;
 FFontTTData:=TStringList.Create;
 FFontTTData.Sorted:=true;
 SetLength(LineInfo,CONS_MINLINEINFOITEMS);
 FLineInfoMaxItems:=CONS_MINLINEINFOITEMS;
end;


destructor TrpPDFCanvas.Destroy;
begin
 FImageIndexes.free;
 FreeFonts;
 FFont.free;
 FFontTTData.free;
{$IFDEF MSWINDOWS}
 FGDIInfoProvider.free;
{$ENDIF}
{$IFDEF LINUX}
 FFtInfoProvider.free;
{$ENDIF}
 FInfoProvider:=nil;
 FDefInfoProvider:=nil;
 FFont:=nil;
 inherited Destroy;
end;




constructor TRpPDFFile.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FPageInfos:=TStringList.create;
 FCanvas:=TRpPDFCanvas.Create(Self);
 FMainPDF:=TMemoryStream.Create;
 FTempStream:=TMemoryStream.Create;
 FsTempStream:=TMemoryStream.Create;
 FObjectOffsets:=TStringList.Create;
 FFontList:=TStringList.Create;
 FPages:=TStringList.Create;
 FPageWidth:= 12048;
 FPageHeight:= 17039;
 FResolution:=TWIPS_PER_INCHESS;
 FCanvas.FResolution:=TWIPS_PER_INCHESS;
 FBitmapStreams:=TList.Create;
end;

destructor TRpPDFFile.Destroy;
begin
 FreePageInfos;
 FPageInfos.Free;
 FCanvas.free;
 FMainPDF.Free;
 FTempStream.Free;
 FsTempStream.Free;
 FObjectOffsets.free;
 FFOntList.Free;
 FPages.Free;
 FBitmapStreams.Free;

 inherited Destroy;
end;

procedure TRpPDFFile.SetResolution(Newres:integer);
begin
 FResolution:=NewRes;
 FCanvas.FResolution:=NewRes;
end;


function TrpPDFFile.GetStream:TMemoryStream;
begin
 if Not FStreamValid then
  Raise Exception.Create(SRpStreamNotValid);
 Result:=FMainPDF;
end;

procedure TRpPDFFile.BeginDoc;
var
 aobj:TRpPageInfo;
begin
 FreePageInfos;

 FCanvas.FImageIndexes.Clear;
 aobj:=TRpPageInfo.Create;
 aobj.APageWidth:=FPageWidth;
 aobj.APageHeight:=FPageHeight;
 FPageInfos.AddObject('',aobj);

 ClearBitmaps;
 FPrinting:=true;
 FStreamValid:=false;
 FMainPDF.Clear;
 FObjectOffsets.Clear;
 FObjectCount:=0;
 FObjectOffset:=0;
 FPages.Clear;
 FFontList.Clear;
 FFOntCount:=0;
 FCurrentSetPageObject:=0;
 FImageCount:=0;
 FPage:=1;
 // Writes the header
 SWriteLine(FMainPDF,PDF_HEADER);
 AddToOffset(Length(PDF_HEADER));
 // Writes Doc info
 FObjectCount:=FObjectCount+1;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,'<<');
 SWriteLine(FTempStream,'/Producer ('+FDocProducer+')');
 SWriteLine(FTempStream,'/Author ('+FDocAuthor+')');
 SWriteLine(FTempStream,'/CreationDate (D:'+FormatDateTime('YYYYMMDDHHmmSS',now)+')');
 SWriteLine(FTempStream,'/Creator ('+FDocCreator+')');
 SWriteLine(FTempStream,'/Keywords ('+FDocKeywords+')');
 SWriteLine(FTempStream,'/Subject ('+FDocSubject+')');
 SWriteLine(FTempStream,'/Title ('+FDocTitle+')');
 SWriteLine(FTempStream,'/ModDate ()');
 SWriteLine(FTempStream,'>>');
 SWriteLine(FTempStream,'endobj');
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);
 StartStream;
end;

procedure TRpPDFFile.StartStream;
begin
 // Starting of the stream
 FObjectCount:=FObjectCount+1;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,'<< /Length '+IntToStr(FObjectCount+1)+' 0 R');
{$IFDEF USEZLIB}
 if FCompressed then
  SWriteLine(FTempStream,'/Filter [/FlateDecode]');
{$ENDIF}
 SWriteLine(FTempStream,' >>');
 FStreamSize1:=FTempStream.Size;
 SWriteLine(FTempStream,'stream');
 FsTempStream.Clear;
end;

procedure TRpPDFFile.EndStream;
var TempSize: LongInt;
begin
{$IFDEF USEZLIB}
 if FCompressed then
 begin
  FCompressionStream := TCompressionStream.Create(clDefault,FTempStream);
  try
   FCompressionStream.CopyFrom(FsTempStream, 0);
  finally
   FCompressionStream.Free;
  end;
 end
 else
{$ENDIF}
  FsTempStream.SaveToStream(FTempStream);

 FsTempStream.Clear;

 SWriteLine(FTempStream,'endstream');
 SWriteLine(FTempStream,'endobj');
 FStreamSize2:=6;
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);

 TempSize:=FTempStream.Size-FStreamSize1-FStreamSize2-Length('Stream')-Length('endstream')-6;
 FObjectCount:=FObjectCount+1;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,IntToStr(TempSize));
 SWriteLine(FTempStream,'endobj');
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);
end;


procedure TRpPDFFile.AddToOffset(offset:LongInt);
begin
 FObjectOffset:=FObjectOffset+offset;
 FObjectOffsets.Add(IntToStr(FObjectOffset));
end;


procedure TRpPDFFile.NewPage(NPageWidth,NPageHeight:integer);
var
 TempSize:LongInt;
 aobj:TRpPageInfo;
begin
 CheckPrinting;

 FPageWidth:=NPageWidth;
 FPageHeight:=NPageHeight;
 aobj:=TRpPageInfo.Create;
 aobj.APageWidth:=NPageWidth;
 aobj.APageHeight:=NPageHeight;
 FPageInfos.AddObject('',aobj);

 FPage:=FPage+1;

{$IFDEF USEZLIB}
 if FCompressed then
 begin
  FCompressionStream := TCompressionStream.Create(clDefault,FTempStream);
  try
   FCompressionStream.CopyFrom(FsTempStream, 0);
  finally
   FCompressionStream.Free;
  end;
 end
 else
{$ENDIF}
  FsTempStream.SaveToStream(FTempStream);

 FsTempStream.Clear;
 SWriteLine(FTempStream,'endstream');
 SWriteLine(FTempStream,'endobj');
 FStreamSize2:=6;
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);
 TempSize:=FTempStream.Size-FStreamSize1-FStreamSize2-Length('Stream')-Length('endstream')-6;
 FObjectCount:=FObjectCount+1;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,IntToStr(TempSize));
 SWriteLine(FTempStream,'endobj');
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);

 FObjectCount:=FObjectCount+1;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,'<< /Length '+IntToStr(FObjectCount+1)+' 0 R');
{$IFDEF USEZLIB}
 if Compressed then
  SWriteLine(FTempStream,'/Filter [/FlateDecode]');
{$ENDIF}
 SWriteLine(FTempStream,' >>');

 FStreamSize1:=FTempStream.Size;
 SWriteLine(FTempStream,'stream');
end;


procedure TRpPDFFile.CheckPrinting;
begin
 if Not FPrinting then
  Raise Exception.Create(SRpNotPrintingPDF);
end;

procedure TRpPDFFile.SetOutLine;
begin
 FObjectCount:=FObjectCount+1;
 FOutLinesNum:=FObjectCount;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,'<< /Type /Outlines');
 SWriteLine(FTempStream,'/Count 0');
 SWriteLine(FTempStream,'>>');
 SWriteLine(FTempStream,'endobj');
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);
end;

procedure TrpPDFFile.CreateFont(Subtype,BaseFont,Encoding:string);
begin
 FFontCount:=FFontCount+1;
 FObjectCount:=FObjectCount+1;
 FFontList.Add(IntToStr(FObjectCount));
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,'<< /Type /Font');
 SWriteLine(FTempStream,'/Subtype /'+Subtype);
 SWriteLine(FTempStream,'/Name /F'+IntToStr(FFontCount));
 SWriteLine(FTempStream,'/BaseFont /'+BaseFont);
 SWriteLine(FTempStream,'/Encoding /'+Encoding);
 SWriteLine(FTempStream,'>>');
 SWriteLine(FTempStream,'endobj');
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);
end;



procedure TrpPDFFile.SetPages;
var
 i,PageObjNum:Integer;
begin
 FObjectCount:=FObjectCount+1;
 FParentNum:=FObjectCount;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,'<< /Type /Pages');
 SWriteLine(FTempStream,'/Kids [');

 PageObjNum:=2;
 for i:= 1 to FPage do
 begin
  SWriteLine(FTempStream,IntToStr(FObjectCount+i+1+FImageCount)+' 0 R');
  FPages.Add(IntToStr(PageObjNum));
  PageObjNum:=PageObjNum+2;
 end;
 SWriteLine(FTempStream,']');
 SWriteLine(FTempStream,'/Count '+IntToStr(FPage));
 SWriteLine(FTempStream,'>>');
 SWriteLine(FTempStream,'endobj');
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);
end;


procedure TrpPDFFile.SetArray;
var
 i:Integer;
 adata:TRpTTFontData;
begin
 FObjectCount:=FObjectCount+1;
 FResourceNum:=FObjectCount;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,'<< /ProcSet [ /PDF /Text /ImageC]');
 SWriteLine(FTempStream,'/XObject << ');
 for i:=1 to FImageCount do
  SWriteLine(FTempStream,'/Im'+IntToStr(i)+' '+IntToStr(FObjectCount+i)+' 0 R');
 SWriteLine(FTempStream,'>>');
 SWriteLine(FTempStream,'/Font << ');

 for i:=1 to FFontCount do
  SWriteLine(FTempStream,'/F'+IntToStr(i)+' '+FFontList.Strings[i-1]+' 0 R ');
 for i:=0 to Canvas.FFontTTData.Count-1 do
 begin
  adata:=TRpTTFontData(Canvas.FFontTTData.Objects[i]);
  SWriteLine(FTempStream,'/F'+Canvas.FFontTTData.Strings[i]+
   ' '+IntToStr(adata.ObjectIndexParent)+' 0 R ');
 end;
 SWriteLine(FTempStream,'>>');
 SWriteLine(FTempStream,'>>');
 SWriteLine(FTempStream,'endobj');
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);
end;

procedure TrpPDFFile.SetPageObject(index:integer);
var
 aobj:TRpPageInfo;
begin
 aobj:=TRpPageInfo(FPageInfos.Objects[index-1]);

 FObjectCount:=FObjectCount+1;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,'<< /Type /Page');
 SWriteLine(FTempStream,'/Parent '+IntToStr(FParentNum)+' 0 R');
// SWriteLine(FTempStream,'/MediaBox [ 0 0 '+Canvas.UnitsToTextX(FPageWidth)+' '+Canvas.UnitsToTextX(FPageHEight)+']');
 SWriteLine(FTempStream,'/MediaBox [ 0 0 '+
  Canvas.UnitsToTextX(aobj.APageWidth)+' '+Canvas.UnitsToTextX(aobj.APageHEight)+']');
 SWriteLine(FTempStream,'/Contents '+FPages.Strings[FCurrentSetPageObject]+' 0 R');
 SWriteLine(FTempStream,'/Resources '+IntToStr(FResourceNum)+' 0 R');
 SWriteLine(FTempStream,'>>');
 SWriteLine(FTempStream,'endobj');
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);
 FCurrentSetPageObject:=FCurrentSetPageObject+1;
end;

function TRpPDFCanvas.UnitsToTextText(Value:integer;FontSize:integer):string;
var
{$IFDEF DOTNETD}
 olddecimalseparator:String;
{$ENDIF}
{$IFNDEF DOTNETD}
 olddecimalseparator:char;
{$ENDIF}
begin
 olddecimalseparator:=decimalseparator;
 decimalseparator:='.';
 try
  Result:=FormatCurr('######0.00',(((FFile.FPageHeight-Value)/FResolution)*CONS_PDFRES)-FontSize);
 finally
  decimalseparator:=olddecimalseparator;
 end;
end;

function NumberToText(Value:double):string;
var
{$IFDEF DOTNETD}
 olddecimalseparator:String;
{$ENDIF}
{$IFNDEF DOTNETD}
 olddecimalseparator:char;
{$ENDIF}
begin
 olddecimalseparator:=decimalseparator;
 decimalseparator:='.';
 try
  Result:=FormatCurr('######0.00',Value);
 finally
  decimalseparator:=olddecimalseparator;
 end;
end;

function TRpPDFCanvas.UnitsToTextX(Value:integer):string;
var
{$IFDEF DOTNETD}
 olddecimalseparator:String;
{$ENDIF}
{$IFNDEF DOTNETD}
 olddecimalseparator:char;
{$ENDIF}
begin
 olddecimalseparator:=decimalseparator;
 decimalseparator:='.';
 try
  Result:=FormatCurr('######0.00',(Value/FResolution)*CONS_PDFRES);
 finally
  decimalseparator:=olddecimalseparator;
 end;
end;

function TRpPDFCanvas.UnitsToTextY(Value:integer):string;
var
{$IFDEF DOTNETD}
 olddecimalseparator:String;
{$ENDIF}
{$IFNDEF DOTNETD}
 olddecimalseparator:char;
{$ENDIF}
begin
 olddecimalseparator:=decimalseparator;
 decimalseparator:='.';
 try
  Result:=FormatCurr('######0.00',((FFile.FPageHeight-Value)/FResolution)*CONS_PDFRES);
 finally
  decimalseparator:=olddecimalseparator;
 end;
end;


procedure TrpPDFFile.SetCatalog;
begin
 FObjectCount:=FObjectCount+1;
 FCatalogNum:=FObjectCount;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 SWriteLine(FTempStream,'<< /Type /Catalog');
 SWriteLine(FTempStream,'/Pages '+IntToStr(FParentNum)+' 0 R');
 SWriteLine(FTempStream,'/Outlines '+IntToStr(FOutlinesNum)+' 0 R');
 SWriteLine(FTempStream,'>>');
 SWriteLine(FTempStream,'endobj');
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);
end;


function TrpPDFFile.GetOffsetNumber(offset:string):string;
var
 x,y:LongInt;
begin
 x:=Length(offset);
 result:='';
 for y:= 1 to 10-x do
  result:=result+'0';
 result:=result+offset;
end;

procedure TrpPDFFile.SetXref;
var i:Integer;
begin
 FObjectCount:=FObjectCount+1;
 FTempStream.Clear;
 SWriteLine(FTempStream,'xref');
 SWriteLine(FTempStream,'0 '+IntToStr(FObjectCount));
 SWriteLine(FTempStream,'0000000000 65535 f');

 for i:=0 to FObjectCount-2 do
  SWriteLine(FTempStream,GetOffsetNumber(trim(FObjectOffsets.Strings[i]))+' 00000 n');

 SWriteLine(FTempStream,'trailer');
 SWriteLine(FTempStream,'<< /Size '+IntToStr(FObjectCount));
 SWriteLine(FTempStream,'/Root '+IntToStr(FCatalogNum)+' 0 R');
 SWriteLine(FTempStream,'/Info 1 0 R');
 SWriteLine(FTempStream,'>>');
 SWriteLine(FTempStream,'startxref');
 SWriteLine(FTempStream,IntToStr(FMainPDF.Size));
// SWriteLine(FTempStream,trim(FObjectOffsets.Strings[FObjectCount-1]));
 FTempStream.SaveToStream(FmainPDF);
end;

procedure TRpPDFFile.ClearBitmaps;
begin
 while FBitmapStreams.Count>0 do
 begin
  TObject(FBitmapStreams.Items[0]).Free;
  FBitmapStreams.Delete(0);
 end;
end;

procedure TRpPDFFile.WriteBitmap(index:Integer);
begin
 FObjectCount:=FObjectCount+1;
 FTempStream.Clear;
 SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
 TMemoryStream(FBitmapStreams.Items[index-1]).SaveToStream(FTempStream);
 SWriteLine(FTempStream,#13#10+'endstream');
 SWriteLine(FTempStream,'endobj');
 AddToOffset(FTempStream.Size);
 FTempStream.SaveToStream(FMainPDF);
end;

procedure TRpPDFFile.EndDoc;
var
 i:integer;
begin
 CheckPrinting;
 FPrinting:=false;
 // Writes the trailing zone
 EndStream;
 SetOutLine;
 SetFontType;
 SetPages;
 SetArray;
 for i:= 1 to FImageCount do
  WriteBitmap(i);
 for i:= 1 to FPage do
 begin
  SetPageObject(i);
 end;
 SetCatalog;
 SetXref;
 SWriteLine(FMainPDF,'%%EOF');


 // Save to disk if filename assigned
 FStreamValid:=True;
 FMainPDF.Seek(0,soFromBeginning);
 if Length(Trim(FFilename))>0 then
 begin
  FMainPDF.SaveToFile(FFilename);
  FMainPDF.Seek(0,soFromBeginning);
 end;
 if Assigned(DestStream) then
 begin
  FMainPDF.SaveToStream(DestStream);
  FMainPDF.Seek(0,soFromBeginning);
 end;
 ClearBitmaps;
end;

procedure TRpPDFFile.AbortDoc;
begin
 FMainPDF.Clear;
 FStreamValid:=false;
 FPrinting:=false;
end;


function RGBToFloats(color:integer):string;
var
 r,g,b:byte;
 acolor:LongWord;
{$IFDEF DOTNETD}
 olddecimal:String;
{$ENDIF}
{$IFNDEF DOTNETD}
 olddecimal:char;
{$ENDIF}
begin
 olddecimal:=decimalseparator;
 try
  decimalseparator:='.';
  acolor:=LongWord(color);
  r:=byte(acolor);
  Result:=FormatCurr('0.00',r/256);
  g:=byte(acolor shr 8);
  Result:=Result+' '+FormatCurr('0.00',g/256);
  b:=byte(acolor shr 16);
  Result:=Result+' '+FormatCurr('0.00',b/256);
 finally
  decimalseparator:=olddecimal;
 end;
end;


procedure TRpPDFCanvas.SetDash;
begin
 case PenStyle of
  // Dash
  1:
   begin
    SWriteLine(FFile.FsTempStream,'[16 8] 0 d');
   end;
  // Dot
  2:
   begin
    SWriteLine(FFile.FsTempStream,'[3] 0 d');
   end;
  // Dash dot
  3:
   begin
    SWriteLine(FFile.FsTempStream,'[8 7 2 7] 0 d');
   end;
  // Dash dot dot
  4:
   begin
    SWriteLine(FFile.FsTempStream,'[8 4 2 4 2 4] 0 d');
   end;
  // Clear
  5:
   begin
   end;
  else
   begin
    SWriteLine(FFile.FsTempStream,'[] 0 d');
   end;
 end;
end;

procedure TRpPDFCanvas.Line(x1,y1,x2,y2:Integer);
var
 LineWidth:integer;

procedure DoWriteLine;
begin
 SWriteLine(FFile.FsTempStream,RGBToFloats(PenColor)+' RG');
 SWriteLine(FFile.FsTempStream,RGBToFloats(PenColor)+' rg');
 SWriteLine(FFile.FsTempStream,UnitsToTextX(x1)+' '+UnitsToTextY(y1)+' m');
 SWriteLine(FFile.FsTempStream,UnitsToTextX(x2)+' '+UnitsToTextY(y2)+' l');
 // S-Solid,  D-Dashed, B-Beveled, I-Inset, U-Underline
 SWriteLine(FFile.FsTempStream,'S');
end;

begin
 if PenStyle=5 then
  exit;
 SetDash;
 LineWidth:=1;
 If (PenWidth>0) then
  LineWidth:=PenWidth;
 // Line cap
 SWriteLine(FFile.FsTempStream,'1 J');
 SWriteLine(FFile.FsTempStream,UnitsToTextX(LineWidth)+' w');
 DoWriteLine;
end;

procedure TRpPDFCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
var
 LineWidth:integer;
 W,H:integer;
 opfill:string;
begin
 if ((PenStyle=5) and (BrushStyle=1)) then
  exit;
 SetDash;
 W:=X2-X1;
 H:=Y2-Y1;
 LineWidth:=1;
 If (PenWidth>0) then
  LineWidth:=PenWidth;
 SWriteLine(FFile.FsTempStream,UnitsToTextX(LineWidth)+' w');
 SWriteLine(FFile.FsTempStream,RGBToFloats(PenColor)+' RG');
 SWriteLine(FFile.FsTempStream,RGBToFloats(BrushColor)+' rg');
 // Draws a ellipse in 4 pass
 SWriteLine(FFile.FsTempStream,UnitsToTextX(X1)+' '+
  UnitsToTextY(y1+(H div 2))+' m');
 SWriteLine(FFile.FsTempStream,
  UnitsToTextX(X1)+' '+UnitsToTextY(y1+(H div 2)-Round(H/2*11/20))+' '+
  UnitsToTextX(X1+(W div 2)-Round(W/2*11/20))+' '+UnitsToTextY(y1)+' '+
  UnitsToTextX(X1+(W div 2))+' '+UnitsToTextY(y1)+
  ' c');
 SWriteLine(FFile.FsTempStream,
  UnitsToTextX(X1+(W div 2)+Round(W/2*11/20))+' '+UnitsToTextY(y1)+' '+
  UnitsToTextX(X1+W)+' '+UnitsToTextY(y1+(H div 2)-Round(H/2*11/20))+' '+
  UnitsToTextX(X1+W)+' '+UnitsToTextY(y1+(H div 2))+
  ' c');
 SWriteLine(FFile.FsTempStream,
  UnitsToTextX(X1+W)+' '+UnitsToTextY(y1+(H div 2)+Round(H/2*11/20))+' '+
  UnitsToTextX(X1+(W div 2)+Round(W/2*11/20))+' '+UnitsToTextY(y1+H)+' '+
  UnitsToTextX(X1+(W div 2))+' '+UnitsToTextY(y1+H)+
  ' c');
 SWriteLine(FFile.FsTempStream,
  UnitsToTextX(X1+(W div 2)-Round(W/2*11/20))+' '+UnitsToTextY(y1+H)+' '+
  UnitsToTextX(X1)+' '+UnitsToTextY(y1+(H div 2)+Round(H/2*11/20))+' '+
  UnitsToTextX(X1)+' '+UnitsToTextY(y1+(H div 2))+
  ' c');

 opfill:='B';
 if PenStyle=5 then
 begin
  opfill:='f';
 end;
 // Bsclear
 if BrushStyle=1 then
  SWriteLine(FFile.FsTempStream,'S')
 else
 // BsSolid
  SWriteLine(FFile.FsTempStream,opfill);
end;

procedure TRpPDFCanvas.Rectangle(x1,y1,x2,y2:Integer);
var
 LineWidth:integer;
 opfill:string;
begin
 if ((PenStyle=5) and (BrushStyle=1)) then
  exit;
 SetDash;
 LineWidth:=1;
 If (PenWidth>0) then
  LineWidth:=PenWidth;
 SWriteLine(FFile.FsTempStream,UnitsToTextX(LineWidth)+' w');
 SWriteLine(FFile.FsTempStream,RGBToFloats(PenColor)+' RG');
 SWriteLine(FFile.FsTempStream,RGBToFloats(BrushColor)+' rg');
 SWriteLine(FFile.FsTempStream,UnitsToTextX(x1)+' '+UnitsToTextY(y1)+
  ' '+UnitsToTextX(x2-x1)+' '+UnitsToTextX(-(y2-y1))+' re');
 opfill:='B';
 if PenStyle=5 then
 begin
  opfill:='f';
 end;
 // Bsclear
 if BrushStyle=1 then
  SWriteLine(FFile.FsTempStream,'S')
 else
 // BsSolid
  SWriteLine(FFile.FsTempStream,opfill);
end;


procedure TRpPDFCanvas.SaveGraph;
begin
 SWriteLine(FFile.FsTempStream,'q');
end;

procedure TRpPDFCanvas.RestoreGraph;
begin
 SWriteLine(FFile.FsTempStream,'Q');
end;

procedure TRpPDFCanvas.TextRect(ARect: TRect; Text: Widestring;
                       Alignment: integer; Clipping: boolean;Wordbreak:boolean;
                       Rotation:integer;RightToLeft:Boolean);
var
 recsize:TRect;
 i,index:integer;
 posx,posY,currpos,alinedif:integer;
 singleline:boolean;
 astring:WideString;
 alinesize:integer;
 lwords:TRpWideStrings;
 lwidths:TStringList;
 arec:TRect;
 aword:WideString;
begin
 FFile.CheckPrinting;

 if (Clipping or (Rotation<>0)) then
 begin
  SaveGraph;
 end;
 try
  if Clipping then
  begin
   // Clipping rectangle
   SWriteLine(FFile.FsTempStream,UnitsToTextX(ARect.Left)+' '+UnitsToTextY(ARect.Top)+
   ' '+UnitsToTextX(ARect.Right-ARect.Left)+' '+UnitsToTextX(-(ARect.Bottom-ARect.Top))+' re');
   SWriteLine(FFile.FsTempStream,'h'); // ClosePath
   SWriteLine(FFile.FsTempStream,'W'); // Clip
   SWriteLine(FFile.FsTempStream,'n'); // NewPath
  end;
  singleline:=(Alignment AND AlignmentFlags_SingleLine)>0;
  if singleline then
   wordbreak:=false;
  // Calculates text extent and apply alignment
  recsize:=ARect;
  TextExtent(Text,recsize,wordbreak,singleline);
  if (not Font.Transparent) then
  begin
   BrushColor:=Font.BackColor;
   BrushStyle:=0;
   Rectangle(arect.Left, arect.Top, arect.Left+recsize.Right, arect.Top+recsize.Bottom);
  end;
  // Align bottom or center
  PosY:=ARect.Top;
  if (AlignMent AND AlignmentFlags_AlignBottom)>0 then
  begin
   PosY:=ARect.Bottom-recsize.bottom;
  end;
  if (AlignMent AND AlignmentFlags_AlignVCenter)>0 then
  begin
   PosY:=ARect.Top+(((ARect.Bottom-ARect.Top)-recsize.Bottom) div 2);
  end;

  for i:=0 to FLineInfoCount-1 do
  begin
   posX:=ARect.Left;
   // Aligns horz.
   if  ((Alignment AND AlignmentFlags_AlignRight)>0) then
   begin
    // recsize.right contains the width of the full text
    PosX:=ARect.Right-LineInfo[i].Width;
   end;
   // Aligns horz.
   if (Alignment AND AlignmentFlags_AlignHCenter)>0 then
   begin
    PosX:=ARect.Left+(((Arect.Right-Arect.Left)-LineInfo[i].Width) div 2);
   end;
   astring:=Copy(Text,LineInfo[i].Position,LineInfo[i].Size);
   if  (((Alignment AND AlignmentFlags_AlignHJustify)>0) AND (NOT LineInfo[i].LastLine)) then
   begin
    // Calculate the sizes of the words, then
    // share space between words
    lwords:=TRpWideStrings.Create;
    try
     aword:='';
     index:=1;
     while index<=Length(astring) do
     begin
      if astring[index]<>' ' then
      begin
       aword:=aword+astring[index];
      end
      else
      begin
       if Length(aword)>0 then
        lwords.Add(aword);
       aword:='';
      end;
      inc(index);
     end;
     if Length(aword)>0 then
       lwords.Add(aword);
     // Calculate all words size
     alinesize:=0;
     lwidths:=TStringList.Create;
     try
      for index:=0 to lwords.Count-1 do
      begin
       arec:=ARect;
       TextExtent(lwords.Strings[index],arec,false,true);
       if RightToLeft then
        lwidths.Add(IntToStr(-(arec.Right-arec.Left)))
       else
        lwidths.Add(IntToStr(arec.Right-arec.Left));
       alinesize:=alinesize+arec.Right-arec.Left;
      end;
      alinedif:=ARect.Right-ARect.Left-alinesize;
      if alinedif>0 then
      begin
       if lwords.count>1 then
        alinedif:=alinedif div (lwords.count-1);
       if RightToLeft then
       begin
        currpos:=ARect.Right;
        alinedif:=-alinedif;
       end
       else
        currpos:=PosX;
       for index:=0 to lwords.Count-1 do
       begin
        TextOut(currpos,PosY+LineInfo[i].TopPos,lwords.strings[index],LineInfo[i].Width,Rotation,RightToLeft);
        currpos:=currpos+StrToInt(lwidths.Strings[index])+alinedif;
       end;
      end;
     finally
      lwidths.Free;
     end;
    finally
     lwords.free;
    end;
   end
   else
    TextOut(PosX,PosY+LineInfo[i].TopPos,astring,LineInfo[i].Width,Rotation,RightToLeft);
  end;
 finally
  if (Clipping or (Rotation<>0)) then
  begin
   RestoreGraph;
  end;
 end;
end;




function Type1FontTopdfFontName(Type1Font:TRpType1Font;oblique,bold:boolean;WFontName:WideString;FontStyle:integer):String;
var
 avalue:Integer;
 searchname:String;
begin
 if (Type1Font in [poLinked,poEmbedded]) then
 begin
  searchname:=WFontName+IntToStr(FontStyle);
  Result:=searchname;
 end
 else
 begin
  avalue:=0;
  case Type1Font of
  poHelvetica:
   begin
    avalue:=0;
   end;
  poCourier:
   begin
    avalue:=4;
   end;
  poTimesRoman:
   begin
    avalue:=8;
   end;
  poSymbol:
   begin
    avalue:=12;
   end;
  poZapfDingbats:
   begin
    avalue:=13;
   end;
  end;
  if (Type1Font in [poHelvetica..poTimesRoman]) then
  begin
  if bold then
   avalue:=avalue+1;
  if oblique then
   avalue:=avalue+2;
  end;
  Result:=IntToStr(avalue+1);
 end;
end;


procedure TRpPDFCanvas.TextOut(X, Y: Integer; const Text: Widestring;LineWidth,
 Rotation:integer;RightToLeft:Boolean);
var
 rotrad,fsize:double;
 rotstring:string;
 PosLine,PosLineX1,PosLineY1,PosLineX2,PosLineY2:integer;
 astring:WideString;
 adata:TRpTTFontData;
 havekerning:boolean;
 leading:integer;
 linespacing:integer;
begin
 /// Add Font leading
 adata:=GetTTFontData;
 if assigned(adata) then
 begin
  leading:=adata.Leading;
 end
 else
 begin
  GetStdLineSpacing(linespacing,leading);
 end;
 leading:=Round((leading/100000)*FResolution*FFont.Size*1.25);
 Y:=Y+leading;



 FFile.CheckPrinting;
 if (Rotation<>0) then
 begin
  SaveGraph;
 end;
 try
  SWriteLine(FFile.FsTempStream,RGBToFloats(Font.Color)+' RG');
  SWriteLine(FFile.FsTempStream,RGBToFloats(Font.Color)+' rg');
  SWriteLine(FFile.FsTempStream,'BT');
  SWriteLine(FFile.FsTempStream,'/F'+
  Type1FontTopdfFontName(Font.Name,Font.Italic,Font.Bold,Font.fontname,Font.Style)+' '+
   IntToStr(Font.Size)+ ' Tf');

  // Rotates
  if Rotation<>0 then
  begin
   rotstring:='1 0 0 1 '+
    UnitsToTextX(X)+' '+
    UnitsToTextText(Y,Font.Size);
   SWriteLine(FFile.FsTempStream,rotstring+' cm');
   rotrad:=Rotation/10*(2*PI/360);
   rotstring:=NumberToText(cos(rotrad))+' '+
    NumberToText(sin(rotrad))+' '+
    NumberToText(-sin(rotrad))+' '+
    NumberToText(cos(rotrad))+' 0 0';
   SWriteLine(FFile.FsTempStream,rotstring+' cm');
  end
  else
   SWriteLine(FFile.FsTempStream,UnitsToTextX(X)+' '+UnitsToTextText(Y,Font.Size)+' Td');
  astring:=Text;
  if RightToLeft then
  begin
   astring:=DoReverseStringW(astring);
  end;
  havekerning:=false;
  if assigned(adata) then
  begin
   if adata.havekerning then
    havekerning:=true;
  end;

  if havekerning then
  begin
   SWriteLine(FFile.FsTempStream,PDFCompatibleTextWidthKerning(astring,adata,Font)+' TJ');
  end
  else
   SWriteLine(FFile.FsTempStream,PDFCompatibleText(astring,adata,Font)+' Tj');
  SWriteLine(FFile.FsTempStream,'ET');
 finally
  if (Rotation<>0) then
  begin
   RestoreGraph;
  end;
 end;
 // Underline and strikeout
 if FFont.Underline then
 begin
  PenStyle:=0;
  PenWidth:=Round((Font.Size/CONS_PDFRES*FResolution)*CONS_UNDERLINEWIDTH);
  PenColor:=FFont.Color;
  if Rotation=0 then
  begin
   Posline:=Round(CONS_UNDERLINEPOS*(Font.Size/CONS_PDFRES*FResolution));
   Line(X,Y+Posline,X+LineWidth,Y+Posline);
  end
  else
  begin
   Y:=Y+Round(CONS_UNDERLINEPOS*(Font.Size/CONS_PDFRES*FResolution));
   rotrad:=Rotation/10*(2*PI/360);
   fsize:=CONS_UNDERLINEPOS*Font.Size/CONS_PDFRES*FResolution-Font.Size/CONS_PDFRES*FResolution;
   PosLineX1:=-Round(fsize*cos(rotrad));
   PosLineY1:=-Round(fsize*sin(rotrad));
   PosLineX2:=Round(LineWidth*cos(rotrad));
   PoslineY2:=-Round(LineWidth*sin(rotrad));
   Line(X+PosLineX1,Y+PosLineY1,X+PosLineX2,Y+PosLineY2);
   Y:=Y-Round(CONS_UNDERLINEPOS*(Font.Size/CONS_PDFRES*FResolution));
  end;
 end;
 if FFont.StrikeOut then
 begin
  PenStyle:=0;
  PenWidth:=Round((Font.Size/CONS_PDFRES*FResolution)*CONS_UNDERLINEWIDTH);
  PenColor:=FFont.Color;
  if Rotation=0 then
  begin
   Posline:=Round(CONS_STRIKEOUTPOS*(Font.Size/CONS_PDFRES*FResolution));
   Line(X,Y+Posline,X+LineWidth,Y+Posline);
  end
  else
  begin
   Y:=Y+Round(CONS_UNDERLINEPOS*(Font.Size/CONS_PDFRES*FResolution));
   rotrad:=Rotation/10*(2*PI/360);
   fsize:=CONS_UNDERLINEPOS*Font.Size/CONS_PDFRES*FResolution-Font.Size/CONS_PDFRES*FResolution;
   PosLineX1:=-Round(fsize*cos(rotrad));
   PosLineY1:=-Round(fsize*sin(rotrad));
   PosLineX2:=Round(LineWidth*cos(rotrad));
   PoslineY2:=-Round(LineWidth*sin(rotrad));
   fsize:=(1-CONS_STRIKEOUTPOS)*Font.Size/CONS_PDFRES*FResolution;
   PosLineX1:=X+PosLineX1;
   PosLineY1:=Y+PosLineY1;
   PosLineX2:=X+PosLineX2;
   PosLineY2:=Y+PosLineY2;
   PoslineX1:=PosLineX1-Round(fsize*sin(rotrad));
   PoslineY1:=PosLineY1-Round(fsize*cos(rotrad));
   PoslineX2:=PosLineX2-Round(fsize*sin(rotrad));
   PoslineY2:=PosLineY2-Round(fsize*cos(rotrad));
   Line(PoslineX1,PosLineY1,PosLineX2,PosLineY2);
  end;
 end;
end;

procedure TRpPDFCanvas.DrawImage(rec:TRect;abitmap:TStream;dpires:integer;
 tile:boolean;clip:boolean;intimageindex:integer);
var
 astream:TMemoryStream;
 // imagesize,infosize:DWORD;
 imagesize:integer;
 bitmapwidth,bitmapheight:integer;
{$IFDEF USEZLIB}
 FCompressionStream:TCOmpressionStream;
{$ENDIF}
 fimagestream:TMemoryStream;
 // tmpBitmap:TBitmap;
 // y: integer;
  aheight,awidth:integer;
 // pb: PByteArray;
  arect:TRect;
  isjpeg:Boolean;
  indexed:boolean;
  bitsperpixel,numcolors:integer;
  palette:string;
  imageindex:integer;
  format:string;
  newstream:boolean;
begin
 arect:=rec;
 FFile.CheckPrinting;
 FImageStream:=TMemoryStream.Create;
 try
  format:='';
  GetJPegInfo(abitmap,bitmapwidth,bitmapheight,format);
  isjpeg:=(format='JPEG');
  if isjpeg then
  begin
   // Read image dimensions
   fimagestream.SetSize(abitmap.size);
   fimagestream.LoadFromStream(abitmap);
   fimagestream.Seek(0,soFromBeginning);
   imagesize:=fimagestream.size;
  end
  else
  begin
   abitmap.Seek(0,soFromBeginning);
   if (format='BMP') then
   begin
    GetBitmapInfo(abitmap,bitmapwidth,bitmapheight,imagesize,FImageStream,indexed,bitsperpixel,numcolors,palette);
   end
   else
   begin

   end;
  end;
  if dpires<>0 then
  begin
   rec.Right:=rec.Left+Round(bitmapwidth/dpires*FResolution);
   rec.Bottom:=rec.Top+Round(bitmapheight/dpires*FResolution);
  end;
  newstream:=true;
  if intimageindex>=0 then
  begin
   imageindex:=FImageIndexes.IndexOf(IntToStr(intimageindex));
   if imageindex>=0 then
   begin
    imageindex:=integer(FImageIndexes.Objects[imageindex]);
    newstream:=false;
   end
   else
   begin
    FFile.FImageCount:=FFile.FImageCount+1;
    imageindex:=FFile.FImageCount;
    FimageIndexes.AddObject(IntToStr(intimageindex),TObject(imageindex));
   end;
  end
  else
  begin
   FFile.FImageCount:=FFile.FImageCount+1;
   imageindex:=FFile.FImageCount;
  end;
  SWriteLine(FFile.FsTempStream,'q');
  if clip then
  begin
   // Clipping rectangle
   SWriteLine(FFile.FsTempStream,UnitsToTextX(ARect.Left)+' '+UnitsToTextY(ARect.Top)+
   ' '+UnitsToTextX(ARect.Right-ARect.Left)+' '+UnitsToTextX(-(ARect.Bottom-ARect.Top))+' re');
   SWriteLine(FFile.FsTempStream,'h'); // ClosePath
   SWriteLine(FFile.FsTempStream,'W'); // Clip
   SWriteLine(FFile.FsTempStream,'n'); // NewPath
  end;
  awidth:=rec.Right-rec.Left;
  aheight:=rec.Bottom-rec.Top;
  if awidth<=0 then
   tile:=false;
  if aheight<=0 then
   tile:=false;
  repeat
   rec.Left:=ARect.Left;
   rec.Right:=ARect.Left+awidth;
   repeat
    SWriteLine(FFile.FsTempStream,'q');
    // Translate
    SWriteLine(FFile.FsTempStream,'1 0 0 1 '
     +UnitsToTextX(rec.Left)+
     ' '+UnitsToTextY(rec.Bottom)+' cm');
    // Scale
    SWriteLine(FFile.FsTempStream,UnitsToTextX(rec.Right-rec.Left)+
     ' 0 0  '+UnitsToTextX(rec.Bottom-rec.Top)+' 0 0 cm');
    SWriteLine(FFile.FsTempStream,'/Im'+IntToStr(imageindex)+' Do');
    SWriteLine(FFile.FsTempStream,'Q');
    if not tile then
     break;
    rec.Left:=rec.Left+awidth;
    rec.Right:=rec.Left+awidth;
    if (Rec.Right>ARect.Right+awidth) then
     break;
   until false;
   if not tile then
    break;
   rec.Top:=rec.Top+aheight;
   rec.Bottom:=rec.Top+aheight;
   if (Rec.Bottom>ARect.Bottom+aheight) then
    break;
  until false;
  SWriteLine(FFile.FsTempStream,'Q');
  // Saves the bitmap to temp bitmaps
  if newstream then
  begin
   astream:=TMemoryStream.Create;
   FFile.FBitmapStreams.Add(astream);
   SWriteLine(astream,'<< /Type /XObject');
   SWriteLine(astream,'/Subtype /Image');
   SWriteLine(astream,'/Width '+IntToStr(bitmapwidth));
   SWriteLine(astream,'/Height '+IntToStr(bitmapheight));
   if indexed then
   begin
    SWriteLine(astream,'/ColorSpace');
    SWriteLine(astream,'[/Indexed');
    SWriteLine(astream,'/DeviceRGB '+IntToStr(numcolors));
    SWriteLine(astream,palette);
    SWriteLine(astream,']');
    SWriteLine(astream,'/BitsPerComponent '+IntToStr(bitsperpixel))
   end
   else
   begin
    SWriteLine(astream,'/ColorSpace /DeviceRGB');
    SWriteLine(astream,'/BitsPerComponent 8');
   end;
   SWriteLine(astream,'/Length '+IntToStr(imagesize));
   SWriteLine(astream,'/Name /Im'+IntToStr(imageindex));
   if isjpeg then
   begin
    SWriteLine(astream,'/Filter [/DCTDecode]');
   end
   else
   begin
 {$IFDEF USEZLIB}
    if FFile.FCompressed then
     SWriteLine(astream,'/Filter [/FlateDecode]');
 {$ENDIF}
   end;
   SWriteLine(astream,'>>');
   SWriteLine(astream,'stream');
   FImageStream.Seek(0,soFrombeginning);
 {$IFDEF USEZLIB}
   if ((FFile.FCompressed) and (not isjpeg)) then
   begin
    FCompressionStream := TCompressionStream.Create(clDefault,astream);
    try
     FCompressionStream.CopyFrom(FImageStream, 0);
    finally
     FCompressionStream.Free;
    end;
   end
   else
 {$ENDIF}
    FImageStream.SaveToStream(astream);
  end;
 finally
  FImageStream.Free;
 end;
end;



{$IFDEF DOTNETD}
function TRpPDFCanvas.CalcCharWidth(charcode:Widechar;fontdata:TRpTTFontData):double;
var
 intvalue:Byte;
 defaultwidth:integer;
 aarray:TWinAnsiWidthsArray;
 isdefault:boolean;
begin
 defaultwidth:=Default_Font_Width;
 isdefault:=true;
 if charcode in [#0,#13,#10] then
 begin
  Result:=0;
  exit;
 end;
 if (FFont.Name in [poLinked,poEmbedded]) then
 begin
  // Ask for font size
  Result:=InfoProvider.GetCharWidth(Font,fontdata,charcode);
  Result:=Result*FFont.Size/1000;
  exit;
 end
 else
 if (FFont.Name=poHelvetica) then
 begin
  isdefault:=false;
  if FFont.Bold then
  begin
   if FFont.Italic then
    aarray:=Helvetica_BoldItalic_Widths
   else
    aarray:=Helvetica_Bold_Widths;
  end
  else
   if FFont.Italic then
    aarray:=Helvetica_Italic_Widths
   else
    aarray:=Helvetica_Widths;
 end
 else
 if (FFont.Name=poTimesRoman) then
 begin
  isdefault:=false;
  if FFont.Bold then
  begin
   if FFont.Italic then
    aarray:=TimesRoman_BoldItalic_Widths
   else
    aarray:=TimesRoman_Bold_Widths;
  end
  else
   if FFont.Italic then
    aarray:=TimesRoman_Italic_Widths
   else
    aarray:=TimesRoman_Widths;
 end;
 intvalue:=Byte(charcode);
 if (isdefault or (intvalue<32)) then
  Result:=defaultwidth
 else
  Result:=aarray[intvalue];
 Result:=Result*FFont.Size/1000;
end;
{$ENDIF}


{$IFNDEF DOTNETD}
function TRpPDFCanvas.CalcCharWidth(charcode:Widechar;fontdata:TRpTTFontData):double;
var
 intvalue:Byte;
 defaultwidth:integer;
 aarray:PWinAnsiWidthsArray;
 isdefault:boolean;
begin
  aarray:=nil;
  defaultwidth:=Default_Font_Width;
  isdefault:=true;
  if charcode in [WideChar(#0),WideChar(#13),WideChar(#10)] then
  begin
   Result:=0;
   exit;
  end;
  if (FFont.Name in [poLinked,poEmbedded]) then
  begin
   // Ask for font size
   Result:=InfoProvider.GetCharWidth(Font,fontdata,charcode);
   Result:=Result*FFont.Size/1000;
   exit;
  end
  else
  if (FFont.Name=poHelvetica) then
  begin
   aarray:=@Helvetica_Widths;
   isdefault:=false;
   if FFont.Bold then
   begin
    if FFont.Italic then
     aarray:=@Helvetica_BoldItalic_Widths
    else
     aarray:=@Helvetica_Bold_Widths
   end
   else
    if FFont.Italic then
     aarray:=@Helvetica_Italic_Widths;
  end
  else
  if (FFont.Name=poTimesRoman) then
  begin
   aarray:=@TimesRoman_Widths;
   isdefault:=false;
   if FFont.Bold then
   begin
    if FFont.Italic then
     aarray:=@TimesRoman_BoldItalic_Widths
    else
     aarray:=@TimesRoman_Bold_Widths
   end
   else
    if FFont.Italic then
     aarray:=@TimesRoman_Italic_Widths;
  end;
  intvalue:=Byte(charcode);
  if (isdefault or (intvalue<32)) then
   Result:=defaultwidth
  else
   Result:=aarray^[intvalue];
  Result:=Result*FFont.Size/1000;
end;
{$ENDIF}

procedure TRpPDFCanvas.GetStdLineSpacing(var linespacing,leading:integer);
begin
 case FFont.Name of
  poHelvetica:
   begin
    linespacing:=1270;
    leading:=150;
   end;
  poCourier:
   begin
    linespacing:=1265;
    leading:=133;
   end;
  poTimesRoman:
   begin
    linespacing:=1257;
    leading:=150;
   end;
  poSymbol:
   begin
    linespacing:=1450;
    leading:=255;
   end;
  poZapfDingbats:
   begin
    linespacing:=1200;
   end;
   else
   begin
    linespacing:=1270;
    leading:=200;
   end;
 end;

end;


procedure TRpPDFCanvas.TextExtent(const Text:WideString;var Rect:TRect;
 wordbreak:boolean;singleline:boolean);
var
 astring:widestring;
 i:integer;
 asize:double;
 arec:TRect;
 position:integer;
 info:TRpLineInfo;
 maxwidth:double;
 newsize:double;
 recwidth:double;
 linebreakpos:integer;
 nextline:boolean;
 alastsize:double;
 lockspace:boolean;
 createsnewline:boolean;
 havekerning:boolean;
 adata:TRpTTFontData;
 kerningamount:integer;
 linespacing:integer;
 leading:integer;
 offset:integer;
 incomplete:boolean;
begin
 // Text extent for the simple strings, wide strings not supported
 havekerning:=false;
 adata:=GetTTFontData;
 if assigned(adata) then
 begin
  if adata.havekerning then
   havekerning:=true;
  linespacing:=adata.Ascent-adata.Descent+adata.Leading;
  leading:=adata.Leading;
 end
 else
 begin
  GetStdLineSpacing(linespacing,leading);
 end;
 leading:=Round((leading/100000)*FResolution*FFont.Size*1.25);
 linespacing:=Round(((linespacing)/100000)*FResolution*FFont.Size*1.25);
// leading:=Round((leading/10000)*FResolution);
// linespacing:=Round((linespacing/10000)*FResolution);

 createsnewline:=false;
 astring:=Text;
 arec:=Rect;
 arec.Left:=0;
 arec.Top:=0;
 arec.Bottom:=0;
 asize:=0;
 FLineInfoCount:=0;
 position:=1;
 offset:=0;
 linebreakpos:=0;
 maxwidth:=0;
 recwidth:=(rect.Right-rect.Left)/FResolution*CONS_PDFRES;
 nextline:=false;
 i:=1;
 alastsize:=0;
 lockspace:=false;
 while i<=Length(astring) do
 begin
  incomplete:=false;
  newsize:=CalcCharWidth(astring[i],adata);
  if havekerning then
  begin
   if i<Length(astring) then
   begin
    kerningamount:=infoprovider.GetKerning(Font,adata,astring[i],astring[i+1]);
    newsize:=newsize-(kerningamount*FFont.Size/1000);
   end;
  end;
  if (Not (astring[i] in [WideChar(' '),WideChar(#10),WideChar(#13)])) then
   lockspace:=false;
  if wordbreak then
  begin
   if asize+newsize>recwidth then
   begin
    if linebreakpos>0 then
    begin
     i:=linebreakpos;
     nextline:=true;
     asize:=alastsize;
     linebreakpos:=0;
    end
    else
    begin
     nextline := true;
     incomplete:=true;
     linebreakpos := 0;
    end;
   end
   else
   begin
    if astring[i] in [WideChar('.'),WideChar(','),WideChar('-'),WideChar(' ')] then
    begin
     linebreakpos:=i;
     if astring[i]=' ' then
     begin
      if not lockspace then
      begin
       alastsize:=asize;
       lockspace:=true;
      end;
      asize:=asize+newsize;
     end
     else
     begin
      asize:=asize+newsize;
      alastsize:=asize;
     end;
    end
    else
     asize:=asize+newsize;
   end;
  end
  else
  begin
   asize:=asize+newsize;
  end;
  if not singleline then
  begin
   if (astring[i]=#10) then
   begin
    if (i>1) then
     if (astring[i-1]=#13) then
      offset:=1
     else
      offset:=0;
    nextline:=true;
    createsnewline:=true;
   end
   else
   if (astring[i]=#13) then
   begin
    if (i<Length(astring)) then
    begin
     if (astring[i+1]=#10) then
     begin
      offset:=1;
      Inc(i);
      nextline:=true;
      createsnewline:=true;
     end;
    end;
   end
  end;
  if asize>maxwidth then
   maxwidth:=asize;
  if nextline then
  begin
   nextline:=false;
   info.Position:=position;
   info.Size:=i-position-offset;
   info.Width:=Round((asize)/CONS_PDFRES*FResolution);
//   info.height:=Round((Font.Size)/CONS_PDFRES*FResolution);
   info.height:=linespacing;
   info.TopPos:=arec.Bottom-leading;
   info.lastline:=createsnewline;
   arec.Bottom:=arec.Bottom+info.height;
   asize:=0;
   offset:=0;
   if (incomplete) then
    i:=i-1;
   position:=i+1;
   NewLineInfo(info);
   createsnewline:=false;
   // Skip only one blank char
   if (incomplete) then
     if i<Length(astring) then
      if astring[i+1]=WideChar(' ') then
      begin
      inc(i);
      position:=i+1;
      end;
  end;
  inc(i);
 end;
 arec.Right:=Round((maxwidth+1)/CONS_PDFRES*FResolution);
 if Position<=Length(astring) then
 begin
  info.Position:=position;
  info.Size:=Length(astring)-position+1-offset;
  info.Width:=Round((asize+1)/CONS_PDFRES*FResolution);
  info.height:=linespacing;
  info.TopPos:=arec.Bottom-leading;
  arec.Bottom:=arec.Bottom+info.height;
  info.lastline:=true;
  NewLineInfo(info);
 end;
 arec.Bottom:=arec.Bottom+leading;
 rect:=arec;
end;

procedure TRpPDFCanvas.NewLineInfo(info:TRpLineInfo);
begin
 if FLineInfoMaxItems<FLineInfoCount+1 then
 begin
  SetLength(LineInfo,FLineInfoMaxItems*2);
  FLineInfoMaxItems:=FLineInfoMaxItems*2;
 end;
 LineInfo[FLineInfoCount]:=info;
 inc(FLineInfoCount);
end;

const
  BI_RGB = 0;
  BI_RLE8 = 1;
  BI_RLE4 = 2;
  BI_BITFIELDS = 3;

  MAX_BITMAPHEADERSIZE=32000;



type
 TBitmapInfoHeader = packed record
   biSize: DWORD;
   biWidth: Longint;
   biHeight: Longint;
   biPlanes: Word;
   biBitCount: Word;
   biCompression: DWORD;
   biSizeImage: DWORD;
   biXPelsPerMeter: Longint;
   biYPelsPerMeter: Longint;
   biClrUsed: DWORD;
   biClrImportant: DWORD;
 end;
 PBitmapInfoHeader = ^TBitmapInfoHeader;


 TBitmapFileHeader = packed record
  bfType: Word;
  bfSize: DWORD;
  bfReserved1: Word;
  bfReserved2: Word;
  bfOffBits: DWORD;
 end;
 PBitmapFileHeader = ^TBitmapFileHeader;

 TRGBTriple = packed record
  rgbtBlue: Byte;
  rgbtGreen: Byte;
  rgbtRed: Byte;
 end;
 PRGBTriple = ^TRGBTriple;
 TRGBQuad = packed record
  rgbBlue: Byte;
  rgbGreen: Byte;
  rgbRed: Byte;
  rgbReserved: Byte;
 end;
 PRGBQuad = ^TRGBQuad;

 TBitmapCoreHeader = packed record
    bcSize: DWORD;
    bcWidth: Word;
    bcHeight: Word;
    bcPlanes: Word;
    bcBitCount: Word;
  end;
 PBitmapCoreHeader = ^TBitmapCoreHeader;



{$IFDEF DOTNETD}
procedure GetBitmapInfo(stream:TStream;var width,height,imagesize:integer;FMemBits:TMemoryStream;;var mono:boolean);
var
 fileheader:TBitmapFileHeader;
 bitmapinfo:TBitmapInfoHeader;
 coreheader:TBitmapCoreHeader;
 bsize:DWORD;
 readed:longint;
 numcolors:integer;
 bitcount:integer;
 iscoreheader:boolean;
 qcolors:array of TRGBQuad;
 tcolors:array of TRGBTriple;
 values:array of TRGBTriple;
 qvalues:array of TRGBQuad;
 indexvalues:array of Byte;
 acolors:array of Byte;
 avalues:array of Byte;
// orgvalues:array of TRGBQuad;
procedure GetDIBBitsNet;
var
 bitmap:TBitmap;
 bits:TBytes;
 bitmapinfoptr,abits:Intptr;
 abitmapinfo:tagBitmapinfo;
begin
 bitmap:=TBitmap.Create;
 try
  bitmap.HandleType:=bmDIB;
  bitmap.PixelFormat:=pf32bit;
//  bitmapinfoptr:=nil;
  bitmapinfoptr:=Marshal.AllocHGlobal(sizeof(BitmapInfo));
  Marshal.StructureToPtr(BitmapInfo,BitmapinfoPtr,true);
  stream.Seek(0,soFromBeginning);
  bitmap.LoadFromStream(stream);
  SetLength(bits,bitmap.width*bitmap.Height*3);
//  if not GetDIB(bitmap.Handle,bitmap.Palette,bitmapinfoptr,bits) then
//   RaiseLastOsError;
  abitmapinfo.bmiHeader.biSize:=sizeof(abitmapinfo.bmiHeader);
  abitmapinfo.bmiheader.biWidth:=bitmapinfo.biWidth;
  abitmapinfo.bmiheader.biHeight:=bitmapinfo.biHeight;
  abitmapinfo.bmiheader.biPlanes:=bitmapinfo.biPlanes;
  abitmapinfo.bmiheader.biBitCount:=bitmapinfo.biBitCount;
  abitmapinfo.bmiHeader.biCompression:=bitmapinfo.biCompression;
  abitmapinfo.bmiHeader.biSizeImage:=bitmapinfo.biSizeImage;
  abitmapinfo.bmiHeader.biXPelsPerMeter:=bitmapinfo.biXPelsPerMeter;
  abitmapinfo.bmiHeader.biYPelsPerMeter:=bitmapinfo.biYPelsPerMeter;
  abitmapinfo.bmiHeader.biClrUsed:=bitmapinfo.biClrUsed;
  abitmapinfo.bmiHeader.biClrImportant:=bitmapinfo.biClrImportant;


  if GetDIBits(CreateCompatibleDC(0),bitmap.handle,0,bitmap.height,abits,abitmapinfo,DIB_RGB_COLORS)=0 then
   RaiseLastOsError;
  FMemBits.Write(bits,Length(bits));
 finally
  bitmap.Free;
 end;
end;

function bytestofileheader(const abytes:TBytes):TBitmapFileHeader;
begin
 Result.bfType := System.BitConverter.ToUInt16(ABytes, 0);
 Result.bfSize := System.BitConverter.ToUInt32(ABytes, sizeof(Result.bfType));
 Result.bfReserved1 := System.BitConverter.ToUInt16(ABytes,
  sizeof(Result.bfType)+sizeof(Result.bfSize));
 Result.bfReserved2 := System.BitConverter.ToUInt16(ABytes,
  sizeof(Result.bfType)+sizeof(Result.bfSize)+sizeof(Result.bfReserved1));
 Result.bfOffBits := System.BitConverter.ToUInt16(ABytes,
  sizeof(Result.bfType)+sizeof(Result.bfSize)+sizeof(Result.bfReserved1)+
  sizeof(Result.bfReserved2));
end;


function bytestocoreheader(const abytes:TBytes):TBitmapCoreheader;
begin
 Result.bcSize := System.BitConverter.ToUInt32(ABytes, 0);
 Result.bcWidth := System.BitConverter.ToUInt16(ABytes, sizeof(Result.bcSize));
 Result.bcHeight:= System.BitConverter.ToUInt16(ABytes,
  sizeof(Result.bcSize)+sizeof(Result.bcWidth));
 Result.bcPlanes:=System.BitConverter.ToUInt16(ABytes,
  sizeof(Result.bcSize)+sizeof(Result.bcWidth)+sizeof(Result.bcHeight));
 Result.bcBitCount:=System.BitConverter.ToUInt16(ABytes,
  sizeof(Result.bcSize)+sizeof(Result.bcWidth)+sizeof(Result.bcHeight)+
   sizeof(Result.bcPlanes));
end;

function bytestobitmapinfo(const abytes:TBytes):TBitmapInfoHeader;
var
 currindex:integer;
begin
 currindex:=0;
 Result.biSize:=System.BitConverter.ToUInt32(ABytes, 0);
 currindex:=sizeof(Result.biSize);
 Result.biWidth:=System.BitConverter.ToUInt32(ABytes, currindex);
 currindex:=currindex+sizeof(Result.biWidth);
 Result.biHeight:=System.BitConverter.ToUInt32(ABytes, currindex);
 currindex:=currindex+sizeof(Result.biHeight);
 Result.biPlanes:=System.BitConverter.ToUInt16(ABytes, currindex);
 currindex:=currindex+sizeof(Result.biPlanes);
 Result.biBitCount:=System.BitConverter.ToUInt16(ABytes, currindex);
 currindex:=currindex+sizeof(Result.biBitCount);
 Result.biCompression:=System.BitConverter.ToUInt32(ABytes, currindex);
 currindex:=currindex+sizeof(Result.biCompression);
 Result.biSizeImage:=System.BitConverter.ToUInt32(ABytes, currindex);
 currindex:=currindex+sizeof(Result.biSizeImage);
 Result.biXPelsPerMeter:=System.BitConverter.ToUInt32(ABytes, currindex);
 currindex:=currindex+sizeof(Result.biXPelsPerMeter);
 Result.biYPelsPerMeter:=System.BitConverter.ToUInt32(ABytes, currindex);
 currindex:=currindex+sizeof(Result.biYPelsPerMeter);
 Result.biClrUsed:=System.BitConverter.ToUInt32(ABytes, currindex);
 currindex:=currindex+sizeof(Result.biClrUsed);
 Result.biClrImportant:=System.BitConverter.ToUInt32(ABytes, currindex);
end;


begin
 SetLength(avalues,sizeof(fileheader));
 readed:=stream.Read(avalues,sizeof(fileheader));
 if readed<>sizeof(fileheader) then
  Raise Exception.Create(SRpBadBitmapFileHeader);
 fileheader:=bytestofileheader(avalues);
 // The header must contain 'BM'
 if fileheader.bfType<>19778 then
  Raise Exception.Create(SRpBadBitmapFileHeader);

 // read de size of bitmapinfo
 readed:=stream.Read(bsize,sizeof(bsize));
 if readed<>sizeof(bsize) then
  Raise Exception.Create(SRpBadBitmapFileHeader);
 if ((bsize<2) or (bsize>MAX_BITMAPHEADERSIZE)) then
  Raise Exception.Create(SRpInvalidBitmapHeaderSize);
 iscoreheader:=false;
 if bsize<15 then
  iscoreheader:=true;
 readed:=stream.Seek(sizeof(fileheader),soFromBeginning);
 // Allocates memory
 if iscoreheader then
 begin
  SetLength(avalues,bsize);
  // Reads the pbitmapinfo
  readed:=stream.Read(avalues,bsize);
  if DWORD(readed)<>bsize then
   Raise Exception.Create(SRpBadBitmapStream);
  coreheader:=bytestocoreheader(avalues);
  width:=coreheader.bcWidth;
  height:=coreheader.bcheight;
  imagesize:=width*height*3;
  bitcount:=coreheader.bcBitCount;
  if Assigned(FMemBits) then
   GetDIBBitsNet;
 end
 else
 begin
  SetLength(avalues,bsize);
  // Reads the pbitmapinfo
  readed:=stream.Read(avalues,bsize);
  if DWORD(readed)<>bsize then
   Raise Exception.Create(SRpBadBitmapStream);
  bitmapinfo:=bytestobitmapinfo(avalues);

  width:=bitmapinfo.biWidth;
  height:=bitmapinfo.biheight;
  bitcount:=bitmapinfo.biBitCount;
   // Check support for BI_RGB
   if (Not (bitmapinfo.biCompression in [BI_BITFIELDS,BI_RGB])) then
   begin
    // this are BI_RLE4 or BI_RLE8
    Raise Exception.Create(SRpRLECompBitmapPDF);
   end
   else
   begin
    imagesize:=width*height*3;
    if (bitcount=1) then
     Raise Exception.Create(SRpMonochromeBitmapPDF);
    if Assigned(FMemBits) then
     GetDIBBitsNet;
   end;
 end;
end;
{$ENDIF}

{$IFNDEF DOTNETD}
procedure GetBitmapInfo(stream:TStream;var width,height,imagesize:integer;FMemBits:TMemoryStream;
  var indexed:boolean;var bitsperpixel,usedcolors:integer;var palette:string);
var
 fileheader:TBitmapFileHeader;
 pbitmapinfo:PBitmapInfoHeader;
 pcoreheader:PBitmapCoreHeader;
 bsize:DWORD;
 readed:longint;
 numcolors:integer;
 bitcount:integer;
 coreheader:boolean;
 qcolors:array of TRGBQuad;
 tcolors:array of TRGBTriple;
 values:array of TRGBTriple;
 qvalues:array of TRGBQuad;
// orgvalues:array of TRGBQuad;
 module:integer;
procedure GetDIBBits;
var
 y,scanwidth:integer;
// dc:HDC;
 toread:integer;
 buffer:array of Byte;
 divider:byte;
 origwidth:integer;
 acolor:integer;
 bufdest:array of Byte;
 linewidth:integer;
 bcolor,rcolor,gcolor:Byte;
 num,num2:Word;
 h:integer;

{
 position:integer;
 index:Byte;
 pixvalue:byte;
 HDC:integer;
 aqcolor:TRGBQuad;
 desp:byte;
 atcolor:TRGBTriple;
 abyte,amask:byte;
 abyteindex:integer;
}
begin
 palette:='';
 if numcolors>0 then
 begin
  if coreheader then
  begin
   SetLength(tcolors,numcolors);
   readed:=stream.Read(tcolors[0],sizeof(TRGBTriple)*numcolors);
   if readed<>sizeof(TRGBTriple)*numcolors then
    Raise Exception.Create(SRpInvalidBitmapPalette);
   palette:='';
   for y:=0 to numcolors-1 do
   begin
    acolor:=(tcolors[y].rgbtRed shl 16)+(tcolors[y].rgbtGreen shl 8)+tcolors[y].rgbtBlue;
    if length(palette)=0 then
     palette:='<'+Format('%6.6x',[acolor])
    else
     palette:=palette+' '+Format('%6.6x',[acolor]);
   end;
   palette:=palette+'>';
  end
  else
  begin
   SetLength(qcolors,usedcolors);
   readed:=stream.Read(qcolors[0],sizeof(TRGBQuad)*usedcolors);
   if readed<>sizeof(TRGBQuad)*usedcolors then
    Raise Exception.Create(SRpInvalidBitmapPalette);
   palette:='';
   for y:=0 to usedcolors-1 do
   begin
    acolor:=(qcolors[y].rgbRed shl 16)+(qcolors[y].rgbGreen shl 8)+qcolors[y].rgbBlue;
    if length(palette)=0 then
     palette:='<'+Format('%6.6x',[acolor])
    else
     palette:=palette+' '+Format('%6.6x',[acolor]);
   end;
   palette:=palette+'>';
  end;
 end;
 // Go to position bits
 stream.Seek({sizeof(fileheader)+}fileheader.bfOffBits,soFromBeginning);
 if numcolors=0 then
 begin
  // read the values
  FMemBits.Clear;
  FMemBits.SetSize(imagesize);
  if bitcount=32 then
  begin
   SetLength(qvalues,imagesize);
   scanwidth:=width*4;
   toread:=0;
   module:=4;
  end
  else
  begin
   if bitcount=24 then
   begin
    SetLength(values,imagesize);
    scanwidth:=width*3;
    // Alignment to 32bit
    // Align to 32bit
    toread:=4-(scanwidth mod 4);
    if toread=4 then
     toread:=0;
    module:=3;
   end
   else
   begin
    SetLength(values,imagesize);
    scanwidth:=width*2;
    // Alignment to 32bit
    // Align to 32bit
    toread:=4-(scanwidth mod 4);
    if toread=4 then
     toread:=0;
    module:=2;
   end;
  end;
  scanwidth:=scanwidth+toread;
(*  if (bitcount>16) then
  begin
   for y:=height-1 downto 0 do
   begin
    if bitcount=32 then
    begin
     readed:=stream.Read(qvalues[y*width],scanwidth);
     if readed<>scanwidth then
      Raise Exception.Create(SRpBadBitmapStream);
    end
    else
    begin
     readed:=stream.Read(values[y*width],scanwidth);
     if readed<>scanwidth then
      Raise Exception.Create(SRpBadBitmapStream);
    end;
   end;
   for y:=0 to height-1 do
   begin
    for x:=0 to width-1 do
    begin
     if bitcount=32 then
     begin
      FMemBits.Write(qvalues[y*width+x].rgbRed,1);
      FMemBits.Write(qvalues[y*width+x].rgbGreen,1);
      FMemBits.Write(qvalues[y*width+x].rgbBlue,1);
     end
     else
     begin
      FMemBits.Write(values[y*width+x].rgbtRed,1);
      FMemBits.Write(values[y*width+x].rgbtGreen,1);
      FMemBits.Write(values[y*width+x].rgbtBlue,1);
     end;
    end;
   end;
  end
  else*)
  begin
   FMemBits.SetSize(width*height*3);
   linewidth:=width*3;
   SetLength(buffer,scanwidth);
	 SetLength(bufdest,linewidth);
	 for y := height - 1 downto 0 do
   begin
		readed := stream.Read(buffer[0],scanwidth);
    if readed<>scanwidth then
     Raise Exception.Create(SRpBadBitmapStream);
    FMemBits.Seek((width * 3) * y, soFromBeginning);
    if (bitcount>16) then
    begin
     for h:=0 to  width-1 do
     begin
			bufdest[h * 3] := buffer[module * h + 2];
			bufdest[h * 3 + 1] := buffer[module * h + 1];
			bufdest[h * 3 + 2] := buffer[module * h];
     end;
    end
    else
		if (bitsperpixel=15) then
		begin
		 // 5-5-5
		 for  h := 0 to width-1 do
     begin
			num:=Word(buffer[2*h]);
 		  num2:=Word(Word(buffer[2*h+1]) shl 8);
			num:=Word(num or num2);
			rcolor:=byte(num and $1F);
      gcolor := byte((num and $3FF) shr 5);
      bcolor := byte((num and $7FFF) shr 10);
			rcolor:=byte(Round(rcolor/31.0*255));
			gcolor:=byte(Round(gcolor/31.0*255));
			bcolor:=byte(Round(bcolor/31.0*255));
			bufdest[h * 3] := bcolor;
			bufdest[h * 3 + 1] :=  gcolor;
			bufdest[h * 3 + 2] := rcolor;
		 end
    end
    else
 	  begin
		 for  h := 0 to width-1 do
     begin
     	// 5-6-5
			num:=Word(buffer[2*h]);
 		  num2:=Word(Word(buffer[2*h+1]) shl 8);
			num:=Word(num or num2);
			rcolor:=byte(num and $1F);
      gcolor := byte((num and $7FF) shr 5);
      bcolor := byte((num) shr 11);
			rcolor:=byte(Round(rcolor/31.0*255));
			gcolor:=byte(Round(gcolor/63.0*255));
			bcolor:=byte(Round(bcolor/31.0*255));
			bufdest[h * 3] := bcolor;
			bufdest[h * 3 + 1] :=  gcolor;
			bufdest[h * 3 + 2] := rcolor;
     end;
    end;
 		FMemBits.Write(bufdest[0],linewidth);
   end;
  end;
  FMemBits.Seek(0, soFromBeginning);
  exit;
 end;
 case numcolors of
  2:
   divider:=8;
  16:
   divider:=2;
  256:
   divider:=1;
  else
   divider:=1;
 end;
 scanwidth:=width div divider;
 bitsperpixel:=bitcount;
 indexed:=true;
 if (width mod divider)>0 then
  scanwidth:=scanwidth+1;
 // bitmap file format is aligned on double word
 // the alignment must be removed from datafile
 origwidth:=scanwidth;
 while (scanwidth mod 4)>0 do
  scanwidth:=scanwidth+1;
 SetLength(buffer,scanwidth);
 FMemBits.Clear;
 FMemBits.SetSize(height*origwidth);
{ if numcolors=2 then
 begin
  amask:=$80;
  desp:=1;
 end
 else
 if numcolors=16 then
 begin
  amask:=$F0;
  desp:=4;
 end
 else
 begin
  amask:=$FF;
  desp:=0;
 end;
 hdc:=GetDC(0);
} for y:=height-1 downto 0 do
 begin
  stream.read(buffer[0],scanwidth);
  FMemBits.Seek(y*origwidth,soFromBeginning);
  FMemBits.Write(buffer[0],origwidth);
{  for x:=0 to width-1 do
  begin
   abyteindex:=(x div divider);
   abyte:=buffer[abyteindex] shl ((x mod divider)*desp);
   abyte:=abyte and amask;
   pixvalue:=abyte shr desp;
   if coreheader then
   begin
    atcolor:=tcolors[pixvalue];
    SetPixel(hdc,x,y,atcolor.rgbtBlue shl 16+atcolor.rgbtGreen shl 8+atcolor.rgbtRed);
   end
   else
   begin
    aqcolor:=qcolors[pixvalue];
    SetPixel(hdc,x,y,aqcolor.rgbBlue shl 16+aqcolor.rgbGreen shl 8+aqcolor.rgbRed);
   end;
  end;
}
 end;
 FMemBits.Seek(0,soFromBeginning);
 imagesize:=FMemBits.Size;
end;

begin
 indexed:=false;
 bitsperpixel:=8;
 usedcolors:=0;
 readed:=stream.Read(fileheader,sizeof(fileheader));
 if readed<>sizeof(fileheader) then
  Raise Exception.Create(SRpBadBitmapFileHeader);
 // The header must contain 'BM'
 if fileheader.bfType<>19778 then
  Raise Exception.Create(SRpBadBitmapFileHeader);

 // read de size of bitmapinfo
 readed:=stream.Read(bsize,sizeof(bsize));
 if readed<>sizeof(bsize) then
  Raise Exception.Create(SRpBadBitmapFileHeader);
 if ((bsize<2) or (bsize>MAX_BITMAPHEADERSIZE)) then
  Raise Exception.Create(SRpInvalidBitmapHeaderSize);
 coreheader:=false;
 if bsize<15 then
  coreheader:=true;
 readed:=stream.Seek(sizeof(fileheader),soFromBeginning);
 // Allocates memory
 if coreheader then
 begin
  pcoreheader:=AllocMem(bsize);
  try
   FillChar(pcoreheader^,bsize,0);
   // Reads the pbitmapinfo
   readed:=stream.Read(pcoreheader^,bsize);
   if DWORD(readed)<>bsize then
    Raise Exception.Create(SRpBadBitmapStream);
   width:=pcoreheader^.bcWidth;
   height:=pcoreheader^.bcheight;
   imagesize:=width*height*3;
   bitcount:=pcoreheader.bcBitCount;
   // Read color entries
   case bitcount of
    1:
     numcolors:=2;
    4:
     numcolors:=16;
    8:
     numcolors:=256;
    24:
     numcolors:=0;
    32:
     numcolors:=0;
    else
     Raise Exception.Create(SRpBitMapInfoHeaderBitCount+
      IntToStr(pcoreheader^.bcBitCount));
   end;
   if bitcount<24 then
    usedcolors:=numcolors;
   if Assigned(FMemBits) then
    GetDIBBits;
  finally
   FreeMem(pcoreheader);
  end;
 end
 else
 begin
  pbitmapinfo:=AllocMem(bsize);
  try
   FillChar(pbitmapinfo^,bsize,0);
   // Reads the pbitmapinfo
   readed:=stream.Read(pbitmapinfo^,bsize);
   if DWORD(readed)<>bsize then
    Raise Exception.Create(SRpBadBitmapStream);
   width:=pbitmapinfo^.biWidth;
   height:=pbitmapinfo^.biheight;
   bitcount:=pbitmapinfo^.biBitCount;
   // Check support for BI_RGB
   if (Not (pbitmapinfo^.biCompression in [BI_BITFIELDS,BI_RGB])) then
   begin
    // this are BI_RLE4 or BI_RLE8
    Raise Exception.Create(SRpRLECompBitmapPDF);
   end
   else
   begin
    imagesize:=width*height*3;
    // Read color entries
    case bitcount of
     1:
      numcolors:=2;
     4:
      numcolors:=16;
     8:
      numcolors:=256;
     24,16,15:
      numcolors:=0;
     32:
      numcolors:=0;
     else
      Raise Exception.Create(SRpBitMapInfoHeaderBitCount+
       IntToStr(pbitmapinfo^.biBitCount));
    end;
    if bitcount<15 then
    begin
     usedcolors:=pbitmapinfo^.biClrUsed;
     if usedcolors=0 then
      usedcolors:=numcolors;
    end;
    if Assigned(FMemBits) then
     GetDIBBits;
   end;
  finally
   FreeMem(pbitmapinfo);
  end;
 end;
 if (usedcolors>0) then
  usedcolors:=usedcolors-1;
end;
{$ENDIF}

const
  M_SOF0  = $C0;        { Start Of Frame N }
  M_SOF1  = $C1;        { N indicates which compression process }
  M_SOF2  = $C2;        { Only SOF0-SOF2 are now in common use }
  M_SOF3  = $C3;
  M_SOF5  = $C5;        { NB: codes C4 and CC are NOT SOF markers }
  M_SOF6  = $C6;
  M_SOF7  = $C7;
  M_SOF9  = $C9;
  M_SOF10 = $CA;
  M_SOF11 = $CB;
  M_SOF13 = $CD;
  M_SOF14 = $CE;
  M_SOF15 = $CF;
  M_SOI   = $D8;        { Start Of Image (beginning of datastream) }
  M_EOI   = $D9;        { End Of Image (end of datastream) }
  M_SOS   = $DA;        { Start Of Scan (begins compressed data) }
  M_COM   = $FE;        { COMment }



// Returns false if it's not a jpeg
procedure GetJPegInfo(astream:TStream;var width,height:integer;var format:string);
var
 c1, c2 : Byte;
 i1,i2:integer;
 readed:integer;
 marker:integer;

 function NextMarker:integer;
 var
   c:integer;
 begin
  { Find 0xFF byte; count and skip any non-FFs. }
  readed:=astream.Read(c1,1);
  if readed<1 then
   Raise Exception.Create(SRpSInvalidJPEG);
  c:=c1;
  while (c <> $FF) do
  begin
   readed:=astream.Read(c1,1);
   if readed<1 then
    Raise Exception.Create(SRpSInvalidJPEG);
   c := c1;
  end;
  { Get marker code byte, swallowing any duplicate FF bytes.  Extra FFs
    are legal as pad bytes, so don't count them in discarded_bytes. }
  repeat
   readed:=astream.Read(c1,1);
   if readed<1 then
    Raise Exception.Create(SRpSInvalidJPEG);
   c:=c1;
  until (c <> $FF);
  Result := c;
 end;

 procedure skip_variable;
 { Skip over an unknown or uninteresting variable-length marker }
 var
  alength:Integer;
  w:Word;
 begin
  { Get the marker parameter length count }
  readed:=astream.Read(w,2);
  if readed<2 then
   Raise Exception.Create(SRpSInvalidJPEG);
  alength:=Hi(w)+(Lo(w) shl 8);
  { Length includes itself, so must be at least 2 }
  if (alength < 2) then
   Raise Exception.Create(SRpSInvalidJPEG);
  Dec(alength, 2);
  { Skip over the remaining bytes }
  while (alength > 0) do
  begin
   readed:=astream.Read(c1,1);
   if readed<1 then
    Raise Exception.Create(SRpSInvalidJPEG);
   Dec(alength);
  end;
 end;

 procedure process_COM;
 var
  alength:Integer;
  comment:string;
  w:Word;
 begin
  { Get the marker parameter length count }
  readed:=astream.Read(w,2);
  if readed<2 then
   Raise Exception.Create(SRpSInvalidJPEG);
  alength:=Hi(w)+(Lo(w) shl 8);

   { Length includes itself, so must be at least 2 }
  if (alength < 2) then
   Raise Exception.Create(SRpSInvalidJPEG);
  Dec(alength, 2);
  comment := '';
  while (alength > 0) do
  begin
   readed:=astream.Read(c1,1);
   if readed<1 then
    Raise Exception.Create(SRpSInvalidJPEG);
   comment := comment + char(c1);
   Dec(alength);
  end;
 end;

 procedure process_SOFn;
 var
  alength:Integer;
  w:Word;
 begin
  readed:=astream.Read(w,2);
  if readed<2 then
   Raise Exception.Create(SRpSInvalidJPEG);
  // Skip length
 // alength:=Hi(w)+(Lo(w) shl 8);

  // data_precission skiped
  readed:=astream.Read(c1,1);
  if readed<1 then
   Raise Exception.Create(SRpSInvalidJPEG);
  // Height
  readed:=astream.Read(w,2);
  if readed<2 then
   Raise Exception.Create(SRpSInvalidJPEG);
  alength:=Hi(w)+(Lo(w) shl 8);
  Height:=alength;
  // Width
  readed:=astream.Read(w,2);
  if readed<2 then
   Raise Exception.Create(SRpSInvalidJPEG);
  alength:=Hi(w)+(Lo(w) shl 8);
  Width:=alength;
 end;


begin
 format:='JPEG';
 // Checks it's a jpeg image
 readed:=astream.Read(c1,1);
 if readed<1 then
 begin
  astream.seek(0,soFromBeginning);
  format:='';
  exit;
 end;
 i1:=c1;
 if i1<>$FF then
 begin
  format:='';
 end;
 readed:=astream.Read(c2,1);
 if readed<1 then
 begin
  astream.seek(0,soFromBeginning);
  format:='';
  exit;
 end;
 i2:=c2;
 if i2<>M_SOI then
 begin
  format:='';
  if ((c1=Ord('B')) AND (c2=Ord('M'))) then
  begin
   astream.seek(0,soFromBeginning);
   format:='BMP';
   exit;
  end;
  if ((c1=Ord('G')) AND (c2=Ord('I'))) then
  begin
   format:='GIF';
   astream.seek(0,soFromBeginning);
   exit;
  end;
 end;
 if (not (format='JPEG')) then
 begin
  astream.seek(0,soFromBeginning);
  exit;
 end;
 width:=0;
 height:=0;
 // Read segments until M_SOS
 repeat
  marker := NextMarker;
  case marker of
   M_SOF0,		{ Baseline }
   M_SOF1,		{ Extended sequential, Huffman }
   M_SOF2,		{ Progressive, Huffman }
   M_SOF3,		{ Lossless, Huffman }
   M_SOF5,		{ Differential sequential, Huffman }
   M_SOF6,		{ Differential progressive, Huffman }
   M_SOF7,		{ Differential lossless, Huffman }
   M_SOF9,		{ Extended sequential, arithmetic }
   M_SOF10,		{ Progressive, arithmetic }
   M_SOF11,		{ Lossless, arithmetic }
   M_SOF13,		{ Differential sequential, arithmetic }
   M_SOF14,		{ Differential progressive, arithmetic }
   M_SOF15:		{ Differential lossless, arithmetic }
    begin
     process_SOFn;
     // Exit, no more info need
     marker:=M_SOS;
    end;
   M_SOS:			{ stop before hitting compressed data }
    begin
    end;
   M_EOI:			{ in case it's a tables-only JPEG stream }
    begin
    end;
   M_COM:
    process_COM;
   else			{ Anything else just gets skipped }
     skip_variable;		{ we assume it has a parameter count... }
  end;
 until ((marker=M_SOS) or (marker=M_EOI));
 astream.seek(0,soFromBeginning);
end;


procedure TRpPDFCanvas.FreeFonts;
var
 i:integer;
begin
 for i:=0 to FFontTTData.Count-1 do
 begin
  TRpTTFontData(FFontTTData.Objects[i]).fontdata.free;
  FFontTTData.Objects[i].Free;
 end;
 FFontTTData.Clear;
end;


function TRpPDFCanvas.UpdateFonts:TRpTTFontData;
var
 searchname:string;
 adata:TRpTTFontData;
 index:integer;
begin
 Result:=nil;
 if Not (Font.Name in [poLinked,poEmbedded]) then
  exit;
 if Not Assigned(InfoProvider) then
  exit;
 searchname:=Font.fontname+IntToStr(Font.Style);
 index:=FFontTTData.IndexOf(searchname);
 if index<0 then
 begin
  adata:=TRpTTFontData.Create;
  adata.fontdata:=TMemoryStream.Create;
  adata.embedded:=false;
  adata.Objectname:=searchname;
  FFontTTData.AddObject(searchname,adata);
  InfoProvider.FillFontData(Font,adata);
  if adata.fontdata.size>0 then
   adata.embedded:=Font.Name=poEmbedded;
  Result:=adata;
 end
 else
  Result:=TRpTTFontData(FFontTTData.Objects[index]);
end;

procedure TRpPDFFile.SetFontType;
var
 i:integer;
 adata:TRpTTFontData;
 aunicodecount,index,acount:integer;
 currentindex,nextindex:integer;
 awidths:string;
 cmaphead,fromTo:AnsiString;
begin
 CreateFont('Type1','Helvetica','WinAnsiEncoding');
 CreateFont('Type1','Helvetica-Bold','WinAnsiEncoding');
 CreateFont('Type1','Helvetica-Oblique','WinAnsiEncoding');
 CreateFont('Type1','Helvetica-BoldOblique','WinAnsiEncoding');
 CreateFont('Type1','Courier','WinAnsiEncoding');
 CreateFont('Type1','Courier-Bold','WinAnsiEncoding');
 CreateFont('Type1','Courier-Oblique','WinAnsiEncoding');
 CreateFont('Type1','Courier-BoldOblique','WinAnsiEncoding');
 CreateFont('Type1','Times-Roman','WinAnsiEncoding');
 CreateFont('Type1','Times-Bold','WinAnsiEncoding');
 CreateFont('Type1','Times-Italic','WinAnsiEncoding');
 CreateFont('Type1','Times-BoldItalic','WinAnsiEncoding');
 CreateFont('Type1','Symbol','WinAnsiEncoding');
 CreateFont('Type1','ZapfDingbats','WinAnsiEncoding');
 // Writes font files
 for i:=0 to Canvas.FFontTTData.Count-1 do
 begin
  adata:=TRpTTFontData(Canvas.FFontTTData.Objects[i]);
  if adata.embedded then
  begin
   // Writes font resource data
   FObjectCount:=FObjectCount+1;
   FTempStream.Clear;
   SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
   SWriteLine(FTempStream,'<< /Length '+IntToStr(adata.fontdata.size));
   SWriteLine(FTempStream,'/Length1 '+IntToStr(adata.fontdata.size));
   adata.ObjectIndex:=FObjectCount;
{$IFDEF USEZLIB}
   if FCompressed then
   begin
    SWriteLine(FTempStream,'/Filter [/FlateDecode]');
   end;
{$ENDIF}
   SWriteLine(FTempStream,'>>');
   SWriteLine(FTempStream,'stream');
   adata.fontdata.Seek(0,soFromBeginning);
{$IFDEF USEZLIB}
   if FCompressed then
   begin
    FCompressionStream := TCompressionStream.Create(clDefault,FTempStream);
    try
     FCompressionStream.CopyFrom(adata.fontdata,adata.fontdata.Size);
    finally
     FCompressionStream.Free;
    end;
   end
   else
{$ENDIF}
    adata.FontData.SaveToStream(FTempStream);
   SWriteLine(FTempStream,'endstream');
   SWriteLine(FTempStream,'endobj');
   AddToOffset(FTempStream.Size);
   FTempStream.SaveToStream(FMainPDF);
  end
  else
  begin
   adata.ObjectIndex:=0;
  end;
  // Writes font descriptor
  FObjectCount:=FObjectCount+1;
  FTempStream.Clear;
  SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
  adata.DescriptorIndex:=FObjectCount;
  SWriteLine(FTempStream,'<< /Type /FontDescriptor');
  if adata.isunicode then
  begin
   SWriteLine(FTempStream,'/FontName /'+adata.postcriptname);
   SWriteLine(FTempStream,'/FontFamily('+adata.familyname+')');
  end
  else
   SWriteLine(FTempStream,'/FontName /'+adata.postcriptname);
  SWriteLine(FTempStream,'/Flags '+IntToStr(adata.Flags));
  SWriteLine(FTempStream,'/FontBBox ['+
   IntToStr(adata.FontBBox.Left)+' '+
   IntToStr(adata.FontBBox.Bottom)+' '+
   IntToStr(adata.FontBBox.Right)+' '+
   IntToStr(adata.FontBBox.Top)+']'
   );
  SWriteLine(FTempStream,'/ItalicAngle '+IntToStr(Round(adata.ItalicAngle)));
  SWriteLine(FTempStream,'/Ascent '+IntToStr(adata.Ascent));
  SWriteLine(FTempStream,'/Descent '+IntToStr(adata.Descent));
  SWriteLine(FTempStream,'/Leading '+IntToStr(adata.Leading));
  SWriteLine(FTempStream,'/CapHeight '+IntToStr(adata.CapHeight));
  SWriteLine(FTempStream,'/StemV '+IntToStr(Round(adata.StemV)));
  if (adata.AvgWidth)<>0 then
   SWriteLine(FTempStream,'/AvgWidth '+IntToStr(adata.AvgWidth));
  SWriteLine(FTempStream,'/MaxWidth '+IntToStr(adata.MaxWidth));
  SWriteLine(FTempStream,'/FontStretch /Normal');
  if adata.FontWeight>0 then
   SWriteLine(FTempStream,'/FontWeight '+IntToStr(adata.FontWeight));
  if adata.embedded then
  begin
   if adata.Type1 then
    SWriteLine(FTempStream,'/FontFile '+
     IntToStr(adata.ObjectIndex)+' 0 R')
   else
    SWriteLine(FTempStream,'/FontFile2 '+
     IntToStr(adata.ObjectIndex)+' 0 R');
  end;
  SWriteLine(FTempStream,'>>');
  SWriteLine(FTempStream,'endobj');
  AddToOffset(FTempStream.Size);
  FTempStream.SaveToStream(FMainPDF);

  // To unicode stream
  if (adata.IsUnicode) then
  begin
   // First Build the string
   cmaphead:='/CIDInit /ProcSet findresource begin' +LINE_FEED+
                '12 dict begin ' +LINE_FEED+
                'begincmap' +LINE_FEED+
                '/CIDSystemInfo' +LINE_FEED+
                '<< /Registry (TTX+0)' +LINE_FEED+
                '/Ordering (T42UV)' +LINE_FEED+
                '/Supplement 0' +LINE_FEED+
                '>> def' +LINE_FEED+
                '/CMapName /TTX+0 def' +LINE_FEED+
                '/CMapType 2 def' +LINE_FEED+
                '1 begincodespacerange' +LINE_FEED+
                '<0000><FFFF>' +LINE_FEED+
                'endcodespacerange'+LINE_FEED;
   currentindex:=adata.firstloaded;
   nextindex:=adata.firstloaded;
   while (currentindex<=adata.lastloaded) do
   begin
    aunicodecount := 0;
    index:=currentindex;
    while (index<=adata.lastloaded) do
    begin
     nextindex:=index;
     if adata.loaded[index] then
     begin
      Inc(aunicodecount);
      if (aunicodecount>=100) then
       break;
     end;
     inc(index);
    end;
    if (aunicodecount>0) then
    begin
     cmaphead:= cmaphead+IntToStr(aunicodecount)+
      ' beginbfchar'+LINE_FEED;
     for index := currentindex to nextindex do
     begin
      if adata.loaded[index] then
      begin
       fromTo:='<'+ IntToHex(Integer(adata.loadedglyphs[index]))+'> ';
       cmaphead:=cmaphead+fromTo+' <'+IntToHex(index)+'>'+LINE_FEED;
      end;
     end;
     cmaphead:=cmaphead+'endbfchar' +LINE_FEED;
    end;
    currentindex:=nextindex+1;
   end;
   cmaphead:= cmaphead+'endcmap' +LINE_FEED+
               'CMapName currentdict /CMap defineresource pop'+LINE_FEED+
               'end end'+LINE_FEED;

   FObjectCount:= FObjectCount + 1;
   adata.ToUnicodeIndex := FObjectCount;
   FTempStream.Clear;
   SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
   SWriteLine(FTempStream,'<< /Length '+IntToStr(Length(cmaphead)));
{$IFDEF USEZLIB}
   if FCompressed then
   begin
    SWriteLine(FTempStream,'/Filter [/FlateDecode]');
   end;
{$ENDIF}
   SWriteLine(FTempStream,'>>');
   SWriteLine(FTempStream,'stream');
{$IFDEF USEZLIB}
   if FCompressed then
   begin
    FCompressionStream := TCompressionStream.Create(clDefault,FTempStream);
    try
     WriteStringToStream(cmaphead,FCompressionStream);
    finally
     FCompressionStream.Free;
    end;
   end
   else
{$ENDIF}
     WriteStringToStream(cmaphead,FTempStream);
   SWriteLine(FTempStream,'endstream');
   SWriteLine(FTempStream,'endobj');
   AddToOffset(FTempStream.Size);
   FTempStream.SaveToStream(FMainPDF);
  end;
 end;
 // Creates the fonts of the font list
 for i:=0 to Canvas.FFontTTData.Count-1 do
 begin
  adata:=TRpTTFontData(Canvas.FFontTTData.Objects[i]);
  if adata.isunicode then
  begin
   FObjectCount:=FObjectCount+1;
   FTempStream.Clear;
   adata.ObjectIndexParent:=FObjectCount;
   SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
   SWriteLine(FTempStream,'<< /Type /Font');
   SWriteLine(FTempStream,'/Subtype /Type0');
   //SWriteLine(FTempStream,'/Subtype /TrueType');
   SWriteLine(FTempStream,'/Name /F'+adata.ObjectName);
   SWriteLine(FTempStream,'/BaseFont /'+CONS_UNICODEPREDIX+adata.postcriptname);
   SWriteLine(FTempStream,'/Encoding /Identity-H');
   //SWriteLine(FTempStream,'/Encoding /PDFDocEncoding');
   SWriteLine(FTempStream,'/DescendantFonts [ '+IntToStr(FObjectCount+1)+' 0 R ]');
   SWriteLine(FTempStream,'/ToUnicode '+IntToStr(adata.ToUnicodeIndex) + ' 0 R ');

   SWriteLine(FTempStream,'>>');
   SWriteLine(FTempStream,'endobj');
   AddToOffset(FTempStream.Size);
   FTempStream.SaveToStream(FMainPDF);

   FObjectCount:=FObjectCount+1;
   FTempStream.Clear;
   SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
   SWriteLine(FTempStream,'<< /Type /Font');
   if adata.Type1 then
   begin
    SWriteLine(FTempStream,'/Subtype /CIDFontType1');
   end
   else
   begin
    SWriteLine(FTempStream,'/Subtype /CIDFontType2');
   end;
   SWriteLine(FTempStream,'/BaseFont /'+CONS_UNICODEPREDIX+adata.postcriptname);

   SWriteLine(FTempStream,'/FontDescriptor '+
    IntToStr(adata.DescriptorIndex)+' 0 R');
   SWriteLine(FTempStream,'/FontFamily('+adata.familyname+')');
   SWriteLine(FTempStream,'/CIDSystemInfo<</Ordering(Identity)/Registry(Adobe)/Supplement 0>>');
   SWriteLine(FTempStream,'/DW 1000');
   SWriteLine(FTempStream,'/W [');
   awidths:='';
   index:=adata.firstloaded;
   acount:=0;
   repeat
    if adata.loaded[index] then
    begin
     awidths:=awidths+IntToStr(Integer(adata.loadedglyphs[index]))+'['+IntToStr(adata.loadedwidths[index])+'] ';
//     awidths:=awidths+IntToStr(index)+'['+IntToStr(adata.loadedwidths[index])+'] ';
     acount:=acount+1;
     if (acount mod 8)=7 then
      awidths:=awidths+LINE_FEED;
    end;
    inc(index);
   until index>adata.lastloaded;
   SWriteLine(FTempStream,awidths);
   SWriteLine(FTempStream,']');
(*
   // To unicode cmap
   SWriteLine(FTempStream,'/ToUnicode [');

   awidths:='';
   index:=adata.firstloaded;
   acount:=0;
   repeat
    if adata.loaded[index] then
    begin
     awidths:=awidths+'<'+IntToHex(Integer(adata.loadedglyphs[index]))+'> <'+IntToHex(index)+'> ';
//     awidths:=awidths+IntToStr(index)+'['+IntToStr(adata.loadedwidths[index])+'] ';
     acount:=acount+1;
     if (acount mod 8)=7 then
      awidths:=awidths+LINE_FEED;
    end;
    inc(index);
   until index>adata.lastloaded;
   SWriteLine(FTempStream,awidths);
   SWriteLine(FTempStream,']');*)


   SWriteLine(FTempStream,'/CDIToGDIMap /Identity');

   SWriteLine(FTempStream,'>>');
   SWriteLine(FTempStream,'endobj');
   AddToOffset(FTempStream.Size);
   FTempStream.SaveToStream(FMainPDF);
  end
  else
  begin
   FObjectCount:=FObjectCount+1;
   FTempStream.Clear;
   adata.ObjectIndexParent:=FObjectCount;
   SWriteLine(FTempStream,IntToStr(FObjectCount)+' 0 obj');
   SWriteLine(FTempStream,'<< /Type /Font');
   if adata.Type1 then
   begin
    SWriteLine(FTempStream,'/Subtype /Type1');
   end
   else
   begin
    SWriteLine(FTempStream,'/Subtype /TrueType');
   end;
   SWriteLine(FTempStream,'/Name /F'+adata.ObjectName);
   SWriteLine(FTempStream,'/BaseFont /'+adata.postcriptname);
   SWriteLine(FTempStream,'/FirstChar '+IntToStr(adata.firstloaded));
   SWriteLine(FTempStream,'/LastChar '+IntToStr(adata.lastloaded));
   awidths:='[';
   if adata.lastloaded>0 then
   begin
    index:=adata.firstloaded;
    repeat
     awidths:=awidths+IntToStr(adata.loadedwidths[index])+' ';
     inc(index);
     if (index mod 8)=7 then
      awidths:=awidths+LINE_FEED;
    until index>adata.lastloaded;
    awidths:=awidths+']';
    SWriteLine(FTempStream,'/Widths '+awidths);
   end;
   SWriteLine(FTempStream,'/FontDescriptor '+
    IntToStr(adata.DescriptorIndex)+' 0 R');
   SWriteLine(FTempStream,'/Encoding /'+adata.Encoding);
   SWriteLine(FTempStream,'>>');
   SWriteLine(FTempStream,'endobj');
   AddToOffset(FTempStream.Size);
   FTempStream.SaveToStream(FMainPDF);
  end;
 end;
end;

procedure TRpPDFCanvas.SetInfoProvider(aprov:TRpInfoProvider);
begin
 if Not assigned(aprov) then
  FInfoProvider:=FDefInfoProvider
 else
 begin
  FInfoProvider:=aprov;
 end;
end;

function TRpPDFCanvas.GetTTFontData:TRpTTFontData;
begin
 Result:=nil;
 if Not (Font.Name in [poLinked,poEmbedded]) then
  exit;
 if Not Assigned(InfoProvider) then
  exit;
 Result:=UpdateFonts;
end;


function WideCharToHex(achar:Widechar):string;
var
 aint:Integer;
begin
 aint:=Integer(achar);
 Result:=Format('%4.4x',[aint]);
end;



function TRpPDFCanvas.EncodeUnicode(astring:Widestring;adata:TRpTTFontData;pdffont:TRpPDFFont):string;
var
 aresult:string;
 i:integer;
 kerningvalue:integer;
begin
 aresult:= aresult+'[(';
 aresult := aresult + char(254);
 aresult := aresult + char(254);
// aresult := aresult + char(255);
  for i:=1 to Length(astring) do
  begin
   if astring[i] in [WideChar('('),WideChar(')'),WideChar('\')] then
    aresult:=aresult+'\';
   // Euro exception
//   if astring[i]=widechar(8364) then
//    Result:=Result+chr(128)
//   else
   aresult:=aresult+chr(Word(astring[i]) shr 8);
   aresult:=aresult+chr(Word(astring[i]) AND $F0);
   if (i<Length(astring)) then
   begin
    kerningvalue:=infoprovider.GetKerning(pdffont,adata,WideChar(astring[i]),WideChar(astring[i+1]));
    if kerningvalue<>0 then
    begin
     aresult:=aresult+')'+' '+IntToStr(kerningvalue);
     aresult:=aresult+' (';
    end;
   end;
  end;
  aresult:=aresult+')]';
  Result:=aresult;
end;

function TRpPDFCanvas.PDFCompatibleTextWidthKerning(astring:WideString;adata:TRpTTFontData;pdffont:TRpPDFFont):String;
var
 i:integer;
 kerningvalue:integer;
begin
 if Length(astring)<1 then
 begin
  Result:='[]';
  exit;
 end;
 if adata.isunicode then
 begin
  //Result:=EncodeUnicode(astring,adata,pdffont);

  Result:='[<';
  for i:=1 to Length(astring) do
  begin
//   Result:=Result+WideCharToHex(astring[i]);
   Result:=Result+WideCharToHex(adata.loadedglyphs[Integer(astring[i])]);
   if (i<Length(astring)) then
   begin
    kerningvalue:=infoprovider.GetKerning(pdffont,adata,WideChar(astring[i]),WideChar(astring[i+1]));
    if kerningvalue<>0 then
    begin
     Result:=Result+'>'+' '+IntToStr(kerningvalue);
     Result:=Result+' <';
    end;
   end;
  end;
  Result:=Result+'>]';
 end
 else
 begin
  Result:='[(';
  for i:=1 to Length(astring) do
  begin
   if astring[i] in [WideChar('('),WideChar(')'),WideChar('\')] then
    Result:=Result+'\';
   // Euro exception
   if astring[i]=widechar(8364) then
    Result:=Result+chr(128)
   else
    Result:=Result+astring[i];
   if (i<Length(astring)) then
   begin
    kerningvalue:=infoprovider.GetKerning(pdffont,adata,WideChar(astring[i]),WideChar(astring[i+1]));
    if kerningvalue<>0 then
    begin
     Result:=Result+')'+' '+IntToStr(kerningvalue);
     Result:=Result+' (';
    end;
   end;
  end;
  Result:=Result+')]';
 end;
end;

function PDFCompatibleText(astring:Widestring;adata:TRpTTFontData;pdffont:TRpPDFFont):String;
var
 i:integer;
 isunicode:boolean;
begin
 isunicode:=false;
 if Assigned(adata) then
 begin
  isunicode:=adata.isunicode;
 end;
 if isunicode then
 begin
  Result:='<';
  for i:=1 to Length(astring) do
  begin
//   Result:=Result+WideCharToHex(astring[i]);

   Result:=Result+WideCharToHex(adata.loadedglyphs[Integer(astring[i])]);
  end;
  Result:=Result+'>';
 end
 else
 begin
  Result:='(';
  for i:=1 to Length(astring) do
  begin
   if astring[i] in [WideChar('('),WideChar(')'),WideChar('\')] then
    Result:=Result+'\';
   // Euro character exception
   if astring[i]=widechar(8364) then
    Result:=Result+chr(128)
   else
    Result:=Result+astring[i];
  end;
  Result:=Result+')';
 end;
end;

procedure TRpPDFFile.FreePageInfos;
var
 i:integer;
begin
 for i:=0 to FPageInfos.Count-1 do
 begin
  FPageInfos.Objects[i].free;
 end;
 FPageInfos.Clear;
end;

end.

