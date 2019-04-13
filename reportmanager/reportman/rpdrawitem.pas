{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpdrawitem                                      }
{       TRpImage printable image component              }
{       TRpShape printable simple drawingv              }
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

unit rpdrawitem;

interface

{$I rpconf.inc}

uses Sysutils,
{$IFDEF MSWINDOWS}
 windows,
{$ENDIF}
{$IFDEF USEVARIANTS}
  Variants,Types,
{$ENDIF}
 Classes,rptypes,rpprintitem,rpmdconsts,rpmetafile,rpeval,
 rptypeval,db;

const
 DEF_DRAWWIDTH=500;
 DEFAULT_DPI=100;

// TCopyMode = (cmBlackness, cmDstInvert, cmMergeCopy, cmMergePaint,
// cmNotSrcCopy, cmNotSrcErase, cmPatCopy, cmPatInvert,
// cmPatPaint, cmSrcAnd, cmSrcCopy, cmSrcErase,
// cmSrcInvert, cmSrcPaint, cmWhiteness, cmCreateMask);
 DEF_COPYMODE=10;

type
 TRpShape=class(TRpCommonPosComponent)
  private
   FBrushStyle:integer;
   FBrushColor:integer;
   FPenStyle:integer;
   FPenColor:integer;
   FShape:TRpShapeType;
   FPenWidth:integer;
  protected
   procedure DoPrint(adriver:TRpPrintDriver;
   aposx,aposy,newwidth,newheight:Integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);override;
  public
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
   function GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;override;
  published
   property BrushStyle:integer read FBrushStyle write FBrushStyle default 0;
   property BrushColor:integer read FBrushColor write FBrushColor default $FFFFFF;
   property PenStyle:integer read FPenStyle write FPenStyle default 0;
   property PenColor:integer read FPenColor write FPenColor default 0;
   property Shape:TRpShapeType read FShape write FShape default rpsRectangle;
   property PenWidth:integer read FPenWidth write FPenWidth default 10;
  end;

 TRpImage=class(TRpCommonPosComponent)
  private
   FExpression:WideString;
   FStream,FDecompStream,FOldStream:TMemoryStream;
   FDrawStyle:TRpImageDrawStyle;
   Fdpires:integer;
   FCopyMode:integer;
   FRotation:SmallInt;
   FCachedImage:TRpCachedImage;
   cachedpos:int64;
   procedure ReadStream(AStream:TStream);
   procedure WriteStream(AStream:TStream);
   function GetStream:TMemoryStream;
   procedure WriteExpression(Writer:TWriter);
   procedure ReadExpression(Reader:TReader);
  public
   constructor Create(AOwner:TComponent);override;
   procedure SetStream(Value:TMemoryStream);
   destructor Destroy;override;
  protected
   procedure DefineProperties(Filer: TFiler);override;
   procedure DoPrint(adriver:TRpPrintDriver;
    aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);override;
  public
   procedure SubReportChanged(newstate:TRpReportChanged;newgroup:string='');override;
   function GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;override;
   property Stream:TMemoryStream read FStream write SetStream;
   property Expression:WideString read FExpression write FExpression;
  published
   // Rotating bitmaps still not implemented
   property Rotation:smallint read FRotation write FRotation default 0;
   property DrawStyle:TRpImageDrawStyle read FDrawStyle write FDrawStyle
    default rpDrawCrop;
   property dpires:integer read   Fdpires write Fdpires default DEfAULT_DPI;
   property CopyMode:integer read FCopyMode write FCopyMode default 10;
   property CachedImage:TRpCachedImage read FCachedImage write FCachedImage default rpCachedNone;
  end;


implementation

uses rpbasereport;

type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;


constructor TRpShape.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 Width:=DEF_DRAWWIDTH;
 Height:=DEF_DRAWWIDTH;
 FBrushColor:=$FFFFFF;
end;

destructor TRpShape.Destroy;
begin

 inherited destroy;
end;

procedure TRpShape.DoPrint(adriver:TRpPrintDriver;
    aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);
begin
 inherited DoPrint(adriver,aposx,aposy,newwidth,newheight,metafile,MaxExtent,PartialPrint);
 metafile.Pages[metafile.CurrentPage].NewDrawObject(aposy,aposx,PrintWidth,PrintHeight,
  integer(Shape),BrushStyle,BrushColor,PenStyle,PenWidth,PenColor);
end;

constructor TRpImage.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 Width:=DEF_DRAWWIDTH;
 Height:=DEF_DRAWWIDTH;
 FStream:=TMemoryStream.Create;
 FDecompStream:=TMemoryStream.Create;
 FOldStream:=TMemoryStream.Create;
 FCopyMode:=DEF_COPYMODE;
 Fdpires:=DEFAULT_DPI;
end;


destructor TRpImage.Destroy;
begin
 FStream.free;
 FDecompStream.free;
 FOldStream.free;

 inherited Destroy;
end;

procedure TRpImage.SetStream(Value:TMemoryStream);
begin
 if IsCompressed(Value) then
 begin
  FStream.LoadFromStream(Value);
 end
 else
 begin
  if (TRpBaseReport(GetReport).StreamFormat in [rpStreamzlib,rpStreamXMLZLib]) then
  begin
   CompressStream(Value,FStream);
  end
  else
   FStream.LoadFromStream(Value);
 end;
end;

procedure TRpImage.WriteExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FExpression);
end;

procedure TRpImage.ReadExpression(Reader:TReader);
begin
 FExpression:=ReadWideString(Reader);
end;


procedure TRpImage.DefineProperties(Filer: TFiler);
begin
 inherited;

 Filer.DefineProperty('Expression',ReadExpression,WriteExpression,True);
 Filer.DefineBinaryProperty('Stream', ReadStream, WriteStream, true);
end;

procedure TRpImage.ReadStream(AStream:TStream);
var
 ssize:Int64;
begin
 if (sizeof(ssize)<>AStream.Read(ssize,sizeof(ssize))) then
  Raise Exception.Create(SRpInvalidStreaminRpImage);
 FStream.SetSize(ssize);
 FStream.Seek(0,soFromBeginning);
 if ssize=0 then
  exit;
{$IFDEF DOTNETD}
 if ssize<>FStream.CopyFrom(AStream,ssize) then
  Raise Exception.Create(SRpInvalidStreaminRpImage);
{$ENDIF}
{$IFNDEF DOTNETD}
 if ssize<>AStream.Read(FStream.memory^,ssize) then
  Raise Exception.Create(SRpInvalidStreaminRpImage);
{$ENDIF}
end;

procedure TRpImage.WriteStream(AStream:TStream);
var
 ssize:Int64;
begin
 ssize:=FStream.Size;
 AStream.Write(ssize,sizeof(ssize));
 FStream.Seek(0,soFromBeginning);
 AStream.CopyFrom(FStream,ssize);
// AStream.Write(FStream.Memory^,ssize);
end;

{$IFDEF DOTNETD}
function BytesToGraphicHeader(const ABytes: TBytes): TGraphicHeader;
begin
  Result.Count := System.BitConverter.ToUInt16(ABytes, 0);
  Result.HType := System.BitConverter.ToUInt16(ABytes, sizeof(Result.Count));
  Result.Size := System.BitConverter.ToUInt32(ABytes, sizeof(Result.Count) +
    sizeof(Result.HType));
end;
{$ENDIF}




function TRpImage.GetStream:TMemoryStream;
var
 evaluator:TRpEvaluator;
 areport:TRpBaseReport;
begin
 try
  Result:=nil;
  if Length(Trim(Expression))>0 then
  begin
   // If the expression is a field
   if Not Assigned(TRpBaseReport(GetReport).Evaluator) then
    Exit;
   areport:=TRpBaseReport(GetReport);
   evaluator:=areport.evaluator;
   Result:=evaluator.GetStreamFromExpression(Expression);
   // Filter the image
   if assigned(areport.MetaFile.OnFilterImage) then
    areport.MetaFile.OnFilterImage(result);
   if CachedImage=rpCachedVariable then
   begin
    if Assigned(Result) then
    begin
     if Result.Size>0 then
     begin
      Result.Seek(0,soFromBeginning);
      FOldStream.Seek(0,soFromBeginning);
      if not StreamCompare(FOldStream,Result) then
      begin
       cachedpos:=-1;
      end;
     end;
    end;
   end;
  end
  else
  begin
   if FStream.Size=0 then
    exit;
   if IsCompressed(FStream) then
   begin
    if FDecompStream.Size<1 then
    begin
     DecompressStream(FStream,FDecompStream);
    end;
    Result:=FDecompStream;
   end
   else
    Result:=FStream;
  end;
{$IFDEF USEINDY}
  if Assigned(Result) then
   CheckUUDecode(Result);
{$ENDIF}
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSExpression+' '+Name,self,SRpSImage);
  end;
 end;
end;



procedure TRpImage.DoPrint(adriver:TRpPrintDriver;
    aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);
var
 FMStream:TMemoryStream;
begin
 inherited DoPrint(adriver,aposx,aposy,newwidth,newheight,metafile,MaxExtent,PartialPrint);
 if Not Assigned(FStream) then
  exit;
 FMStream:=GetStream;
 if Not Assigned(FMStream) then
  exit;
 try
  if CachedImage<>rpCachedNone then
  begin
   metafile.Pages[metafile.CurrentPage].NewImageObjectShared(aposy,aposx,
    PrintWidth,PrintHeight,Integer(CopyMode),Integer(DrawStyle),Integer(dpires),cachedpos,FMStream,false);
  end
  else
  begin
   metafile.Pages[metafile.CurrentPage].NewImageObject(aposy,aposx,
    PrintWidth,PrintHeight,Integer(CopyMode),Integer(DrawStyle),Integer(dpires),FMStream,false);
  end;
 finally
  if ((FMStream<>FStream) AND (FMStream<>FDeCompStream)) then
   FMStream.free;
 end;
end;


procedure TRpImage.SubReportChanged(newstate:TRpReportChanged;newgroup:string='');
begin
 inherited SubReportChanged(newstate,newgroup);
 if newstate=rpReportStart then
 begin
  cachedpos:=-1;
  FDecompStream.SetSize(0);
  FOldStream.SetSize(0);
 end;
end;

function TRpImage.GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;
var
 FMStream:TMemoryStream;
begin
 Result:=inherited GetExtension(adriver,MaxExtent,forcepartial);

 if (DrawStyle in [rpDrawCrop,rpDrawStretch,rpDrawTile]) then
  exit;
 FMStream:=GetStream;
 if Not Assigned(FMStream) then
  exit;
 try
  adriver.GraphicExtent(FMStream,Result,dpires);
  LastExtent:=Result;
 finally
  if FMStream<>FStream then
   FMStream.free;
 end;
end;

function TRpShape.GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;
begin
 Result:=inherited GetExtension(adriver,MaxExtent,forcepartial);
 if (Shape=rpsHorzLine) then
 begin
  if (PenWidth=0) then
   Result.Y:=1
  else
   Result.Y:=PenWidth;
  lastextent:=Result;
 end;
end;



end.
