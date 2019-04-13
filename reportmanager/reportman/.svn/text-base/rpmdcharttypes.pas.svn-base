{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpmdcharttypes                                  }
{       Type definitions for Chart implementation       }
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

unit rpmdcharttypes;

interface

{$I rpconf.inc}

uses Classes,SysUtils,rptypes,
{$IFDEF USEVARIANTS}
 Variants,
{$ENDIF}
 rpmdconsts;

const
 CONS_HORZGAP=1000;
 DEFAULT_ALLOCATION=100;
 DEFAULT_STRINGALLOCATION=2000;
 MAX_SERIECOLORS=21;


type
 TRpChartType=(rpchartline,rpchartbar,rpchartpoint,
  rpcharthorzbar,rpchartarea,rpchartpie,rpchartarrow,
  rpchartbubble,rpchartgantt);

 TRpChartDriver=(rpchartdriverdefault,rpchartdriverengine,rpchartdriverteechart);

 TRpMultiBar=(rpMultiNone,rpMultiside,rpMultiStacked,
  rpMultiStacked100);

 TRpSeriesItem=class(TCollectionItem)
  private
   FValues:array of Double;
   FColors:array of Integer;
   FPoolPositions:array of integer;
   FPoolSizes:array of integer;
   FValueCount:Integer;
   FPool:widestring;
   FPoolPos:integer;
   FMaxAllocated:integer;
   FColor:integer;
   procedure SetValue(index:integer;AValue:double);
   procedure SetValueColor(index:integer;AValue:integer);
   function GetValue(index:integer):double;
   function GetValueCaption(index:integer):WideString;
   function GetValueColor(index:integer):Integer;
  public
   ChangeValue:Variant;
   MinValue:double;
   MaxValue:double;
   Caption:WideString;
   charttype:TRpChartType;
   constructor Create(Collection: TCollection);override;
   property Values[index:integer]:double read GetValue write SetValue;
   property Colors[index:integer]:integer read GetValueColor write SetValueColor;
   property ValueCaptions[index:integer]:WideString read GetValueCaption;
   property ValueCount:integer read FValueCount;
   procedure AddValue(avalue:double;acaption:widestring='');
   procedure AddValueColor(avalue:double;color:integer;acaption:widestring='');
   procedure Assign(Source:TPersistent);override;
   procedure SetLastValueColor(color:integer);
   procedure ClearValues;
  published
   property Color:integer read FColor write FColor;
 end;

 TRpSeries=class(TCollection)
 private
  function GetItem(Index:Integer):TRpSeriesItem;
  procedure SetItem(index:integer;Value:TRpSeriesItem);
 public
  AutoRangeL:Boolean;
  AutoRangeH:Boolean;
  LowValue:double;
  HighValue:double;
  Logaritmic:Boolean;
  LogBase:double;
  Inverted:boolean;
  function Add:TRpSeriesItem;
  property Items[index:integer]:TRpSeriesItem read GetItem write SetItem;default;
 end;



const SeriesColors:Array[0..MAX_SERIECOLORS-1] of integer=
   ($FF0000,$FFDDFF,$00FF00,$0000FF,$FFFF00,$FF00FF,$00FFFF,
    $AAAAAA,$BB0000,$00BB00,$0000BB,$BBBB00,$BB00BB,$00BBBB,
    $777777,$773333,$337733,$333377,$777700,$770077,$007777);

function RpChartTypeToString(charttype:TRpChartType):String;
function StringToRpChartType(Value:String):TRpChartType;
procedure GetRpChartTypePossibleValues(alist:TRpWideStrings);

function RpChartDriverToString(driver:TRpChartDriver):String;
function StringToRpChartDriver(Value:String):TRpChartDriver;
procedure GetRpChartDriverPossibleValues(alist:TRpWideStrings);

function RpMultiBarToString(multibar:TRpMultibar):String;
function StringToRpMultibar(Value:String):TRpMultiBar;
procedure GetRpMultiBarPossibleValues(alist:TRpWideStrings);

function RpMarkTypeToString(mtype:Integer):String;
function StringToRpMarkType(Value:String):Integer;
procedure GetRpMarTypePossibleValues(alist:TRpWideStrings);


implementation



const
 AlignmentFlags_SingleLine=64;


function TRpSeries.Add:TRpSeriesItem;
begin
 Result:=TRpSeriesItem(inherited Add);
end;


function TRpSeries.GetItem(Index:Integer):TRpSeriesItem;
begin
 Result:=TRpSeriesItem(inherited GetItem(index));
end;

procedure TRpSeries.SetItem(index:integer;Value:TRpSeriesItem);
begin
 inherited SetItem(Index,Value);
end;

constructor TRpSeriesItem.Create(Collection: TCollection);
begin
 inherited Create(Collection);

 FColor:=-1;
 FValueCount:=0;
 SetLength(FValues,DEFAULT_ALLOCATION);
 SetLength(FColors,DEFAULT_ALLOCATION);
 SetLength(FPoolPositions,DEFAULT_ALLOCATION);
 SetLength(FPoolSizes,DEFAULT_ALLOCATION);
 FMaxAllocated:=DEFAULT_ALLOCATION;
 Fpool:='';
 FPoolPos:=1;
 MaxValue:=-10e300;
 MinValue:=+10e300;
end;

procedure TRpSeriesItem.Assign(Source:TPersistent);
var
 aitem:TRpSeriesItem;
begin
 if SOurce is TRpSeriesItem then
 begin
  aitem:=TRpSeriesItem(Source);
  FColor:=aitem.FColor;
 end
 else
  inherited Assign(Source);
end;


procedure TRpSeriesItem.SetValueColor(index:integer;AValue:integer);
begin
 if index>=FValueCount then
  Raise Exception.Create(SRpIndexOutOfBounds+':'+ClassName);
 FColors[index]:=AValue;
end;

procedure TRpSeriesItem.SetValue(index:integer;AValue:double);
begin
 if index>=FValueCount then
  Raise Exception.Create(SRpIndexOutOfBounds+':'+ClassName);
 FValues[index]:=AValue;
end;

function TRpSeriesItem.GetValue(index:integer):double;
begin
 if index>=FValueCount then
  Raise Exception.Create(SRpIndexOutOfBounds+':'+ClassName);
 Result:=FValues[index];
end;

function TRpSeriesItem.GetValueColor(index:integer):Integer;
begin
 if index>=FValueCount then
  Raise Exception.Create(SRpIndexOutOfBounds+':'+ClassName);
 Result:=FColors[index];
end;

function TRpSeriesItem.GetValueCaption(index:integer):WideString;
begin
 if index>=FValueCount then
  Raise Exception.Create(SRpIndexOutOfBounds+':'+ClassName);
 Result:=Copy(FPool,FPoolPositions[index],FPoolSizes[index]);
end;

procedure TRpSeriesItem.ClearValues;
begin
 FValueCount:=0;
 FPoolPos:=1;
 FPool:='';
 MaxValue:=-10e300;
 MinValue:=+10e300;
end;

procedure TRpSeriesItem.SetLastValueColor(color:integer);
begin
 if FValueCount=0 then
  exit;
 FColors[FValueCount-1]:=color;
end;

procedure TRpSeriesItem.AddValueColor(avalue:double;color:integer;acaption:widestring='');
begin
 AddValue(avalue,caption);
 SetLastValueColor(color);
end;

procedure TRpSeriesItem.AddValue(avalue:double;acaption:widestring='');
var
 caplength:integer;
begin
 if FValueCount>=FMaxAllocated then
 begin
  SetLength(FValues,FMaxAllocated*2);
  SetLength(FPoolPositions,FMaxAllocated*2);
  SetLength(FPoolSizes,FMaxAllocated*2);
  SetLength(FColors,FMaxAllocated*2);
  FMaxAllocated:=FMaxAllocated*2;
 end;
 FValues[FValueCount]:=avalue;
 FColors[FValueCount]:=-1;
 if FColor>=0 then
 begin
  FColors[FValueCount]:=FColor;
 end;
 // Adds the string
 caplength:=Length(acaption);
 if caplength>0 then
 begin
  FPool:=FPool+acaption;
  FPoolPositions[FValueCount]:=FPoolPos;
  FPoolSizes[FValueCount]:=caplength;
  FPoolPos:=FPoolPos+caplength;
 end
 else
 begin
  FPoolPositions[FValueCount]:=0;
  FPoolSizes[FValueCount]:=0;
 end;
 inc(FValueCount);
 if avalue>MaxValue then
  MaxValue:=avalue;
 if avalue<MinValue then
  MinValue:=avalue;
end;


function RpChartDriverToString(driver:TRpChartDriver):String;
begin
 case driver of
  rpchartdriverdefault:
   Result:=SRpSDefault;
  rpchartdriverengine:
   Result:=SRpSChartDriverEngine;
  rpchartdriverteechart:
   Result:=SRpSChartDriverTeeChart;
 end;
end;

procedure GetRpChartDriverPossibleValues(alist:TRpWideStrings);
begin
 alist.Clear;
 alist.Add(SRpSDefault);
 alist.Add(SRpSChartDriverEngine);
 alist.Add(SRpSChartDriverTeeChart);
end;

function StringToRpChartDriver(Value:String):TRpChartDriver;
begin
 Result:=rpchartdriverdefault;
 if Value=SRpSChartDriverEngine then
 begin
  Result:=rpchartdriverengine;
  exit;
 end;
 if Value=SRpSChartDriverTeeChart then
 begin
  Result:=rpchartdriverteechart;
  exit;
 end;
end;

function RpChartTypeToString(charttype:TRpChartType):String;
begin
 Result:=SRpChartLine;
 case charttype of
  rpchartline:
   Result:=SRpChartLine;
  rpchartbar:
   Result:=SRpChartBar;
  rpchartpoint:
   Result:=SRpChartPoint;
  rpcharthorzbar:
   Result:=SRpChartHorzBar;
  rpchartarea:
   Result:=SRpChartArea;
  rpchartpie:
   Result:=SRpChartPie;
  rpchartarrow:
   Result:=SRpChartArrow;
  rpchartgantt:
   Result:=SRpChartgantt;
  rpchartbubble:
   Result:=SRpChartBubble;
 end;
end;

function StringToRpChartType(Value:String):TRpChartType;
begin
 Result:=rpchartline;
 if Value=SRpChartBar then
 begin
  Result:=rpchartbar;
  exit;
 end;
 if Value=SRpChartPoint then
 begin
  Result:=rpchartpoint;
  exit;
 end;
 if Value=SRpChartHorzBar then
 begin
  Result:=rpcharthorzbar;
  exit;
 end;
 if Value=SRpChartArea then
 begin
  Result:=rpchartarea;
  exit;
 end;
 if Value=SRpChartPie then
 begin
  Result:=rpchartpie;
  exit;
 end;
 if Value=SRpChartArrow then
 begin
  Result:=rpchartarrow;
  exit;
 end;
 if Value=SRpChartBubble then
 begin
  Result:=rpchartbubble;
  exit;
 end;
 if Value=SRpChartgantt then
 begin
  Result:=rpchartgantt;
  exit;
 end;
end;

procedure GetRpChartTypePossibleValues(alist:TRpWideStrings);
begin
 alist.Clear;
 alist.add(SRpChartLine);
 alist.Add(SRpChartBar);
 alist.Add(SRpChartPoint);
 alist.Add(SRpChartHorzBar);
 alist.Add(SRpChartArea);
 alist.Add(SRpChartPie);
 alist.Add(SRpChartArrow);
 alist.Add(SRpChartBubble);
 alist.Add(SRpChartGantt);
 
end;


function RpMultiBarToString(multibar:TRpMultibar):String;
begin
 Result:=SRPSNone;
 case multibar of
  rpMultiNone:
   Result:=SRPSNone;
  rpMultiside:
   Result:=SRPSSide;
  rpMultiStacked:
   Result:=SRPSStacked;
  rpMultiStacked100:
   Result:=SRPSStacked100;
 end;
end;

function StringToRpMultibar(Value:String):TRpMultiBar;
begin
 Result:=rpMultiNone;
 if Value=SRPSSide then
 begin
  Result:=rpMultiSide;
  exit;
 end;
 if Value=SRPSStacked then
 begin
  Result:=rpMultiStacked;
  exit;
 end;
 if Value=SRPSStacked100 then
 begin
  Result:=rpMultiStacked100;
  exit;
 end;
end;

procedure GetRpMultiBarPossibleValues(alist:TRpWideStrings);
begin
 alist.Clear;
 alist.Add(SRpSNone);
 alist.Add(SRpSSide);
 alist.Add(SRpSStacked);
 alist.Add(SRpSStacked100);
end;


function RpMarkTypeToString(mtype:Integer):String;
begin
 case mtype of
  1:
   Result:=SRpSMarkType1;
  2:
   Result:=SRpSMarkType2;
  3:
   Result:=SRpSMarkType3;
  4:
   Result:=SRpSMarkType4;
  5:
   Result:=SRpSMarkType5;
  6:
   Result:=SRpSMarkType6;
  7:
   Result:=SRpSMarkType7;
  8:
   Result:=SRpSMarkType8;
  else
   Result:=SRpSMarkType0;
 end;
end;

function StringToRpMarkType(Value:String):Integer;
begin
 if Value=SRpSMarkType1 then
  Result:=1
 else
 if Value=SRpSMarkType2 then
  Result:=2
 else
 if Value=SRpSMarkType3 then
  Result:=3
 else
 if Value=SRpSMarkType4 then
  Result:=4
 else
 if Value=SRpSMarkType5 then
  Result:=5
 else
 if Value=SRpSMarkType6 then
  Result:=6
 else
 if Value=SRpSMarkType7 then
  Result:=7
 else
 if Value=SRpSMarkType8 then
  Result:=8
 else
  Result:=0;
end;

procedure GetRpMarTypePossibleValues(alist:TRpWideStrings);
begin
 alist.Clear;
 alist.Add(SRpSMarkType0);
 alist.Add(SRpSMarkType1);
 alist.Add(SRpSMarkType2);
 alist.Add(SRpSMarkType3);
 alist.Add(SRpSMarkType4);
 alist.Add(SRpSMarkType5);
 alist.Add(SRpSMarkType6);
 alist.Add(SRpSMarkType7);
end;

end.

