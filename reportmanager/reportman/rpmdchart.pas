{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpmdchart                                       }
{       TRpChar printable component                     }
{       Is a small chart drawing component              }
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

unit rpmdchart;

interface

{$I rpconf.inc}

uses Classes,SysUtils,rpprintitem,rpmdconsts,rpeval,
 rptypeval,rptypes,rpevalfunc,rpmunits,rpmdcharttypes,
{$IFNDEF USEVARIANTS}
 windows,
{$ENDIF}
{$IFDEF USEVARIANTS}
 Types,Variants,
{$ENDIF}
 rpmetafile;



type
 TRpChart=class(TRpGenTextComponent)
  private
   FChartType:TRpChartType;
   FValue:Variant;
   FUpdated:Boolean;
   FSeries:TRpSeries;
   FGetValuecondition:widestring;
   FValueExpression:widestring;
   FChangeSerieExpression:widestring;
   FChangeSerieBool,FClearExpressionBool:Boolean;
   FCaptionExpression,FSerieCaption,FClearExpression:widestring;
   FColorExpression,FSerieColorExpression:widestring;
   FIdenChart:TVariableGrap;
   FIdentifier:string;
   FDriver:TRpChartDriver;
   FView3d:Boolean;
   FView3dWalls:Boolean;
   FPerspective:Integer;
   FElevation:Integer;
   FRotation:Integer;
   FOrthogonal:Boolean;
   FZoom:Integer;
   FHorzOffset:Integer;
   FVertOffset:Integer;
   FTilt:Integer;
   FMultiBar:TRpMultiBar;
   FClearValue:Variant;
   FResolution:Integer;
   FShowHint:Boolean;
   FShowLegend:Boolean;
   FMarkStyle:Integer;
   FHorzFontSize:Integer;
   FVertFontSize:Integer;
   FHorzFontRotation:Integer;
   FVertFontRotation:Integer;
   procedure OnClear(Sender:TObject);
   procedure OnNewValue(Y:Single;Cambio:Boolean;leyen,textleyen,textserie:string;newcharttype:TRpChartType);
   procedure OnBoundsValue(autol,autoh:boolean;lvalue,hvalue:double;
    logaritmic:boolean;logbase:double;inverted:boolean);
   procedure OnSerieColor(color:Integer);
   procedure OnValueColor(color:Integer);
   procedure SetIdentifier(Value:string);
   procedure SetSeries(avalue:TRpSeries);
   function CheckValueCondition:boolean;
   function EvaluateSerieExpression:Variant;
   function EvaluateSerieCaption:Variant;
   procedure EvaluateClearExpression;
   function EvaluateCaption:Variant;
   procedure WriteGetValueCondition(Writer:TWriter);
   procedure ReadGetValueCondition(Reader:TReader);
   procedure WriteValueExpression(Writer:TWriter);
   procedure ReadValueExpression(Reader:TReader);
   procedure WriteChangeSerieExpression(Writer:TWriter);
   procedure ReadChangeSerieExpression(Reader:TReader);
   procedure WriteCaptionExpression(Writer:TWriter);
   procedure ReadCaptionExpression(Reader:TReader);
   procedure WriteSerieCaption(Writer:TWriter);
   procedure ReadSerieCaption(Reader:TReader);
   procedure WriteClearExpression(Writer:TWriter);
   procedure ReadClearExpression(Reader:TReader);
   procedure WriteColorExpression(Writer:TWriter);
   procedure ReadColorExpression(Reader:TReader);
   procedure WriteSerieColorExpression(Writer:TWriter);
   procedure ReadSerieColorExpression(Reader:TReader);
   function EvaluateText(atext:WideString):Variant;
  protected
   procedure DoPrint(adriver:TRpPrintDriver;
    aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);override;
   procedure DefineProperties(Filer:TFiler);override;
   procedure Loaded;override;
  public
   procedure GetNewValue;
   procedure Evaluate;
   procedure SetChartType(avalue:TRpChartType);
   property IdenChart:TVariableGrap read FIdenChart;
   procedure SubReportChanged(newstate:TRpReportChanged;newgroup:string='');override;
   constructor Create(AOwner:TComponent);override;
   property ChangeSerieExpression:widestring read FChangeSerieExpression write
    FChangeSerieExpression;
   property ClearExpression:widestring read FClearExpression write
    FClearExpression;
   property GetValueCondition:widestring read FGetValueCondition
    write FGetValuecondition;
   property ValueExpression:widestring read FValueExpression
    write FValueExpression;
   property CaptionExpression:widestring read FCaptionExpression
    write FCaptionExpression;
   property SerieCaption:widestring read FSerieCaption
    write FSerieCaption;
   property ColorExpression:widestring read FColorExpression write
    FColorExpression;
   property SerieColorExpression:widestring read FSerieColorExpression write
    FSerieColorExpression;
  published
   property Series:TRpSeries read FSeries write SetSeries;
   property ChangeSerieBool:boolean read FChangeSerieBool write FChangeSerieBool
    default false;
   property ChartType:TRpChartType read FChartType write SetChartType
    default rpchartline;
   property Identifier:string read FIdentifier write SetIdentifier;
   property ClearExpressionBool:boolean read FClearExpressionBool write FClearExpressionBool
    default false;
   property Driver:TRpChartDriver read FDriver write FDriver;
   property View3d:Boolean read FView3d write FView3d default true;
   property View3dWalls:Boolean read FView3dWalls write FView3dWalls default true;
   property Perspective:Integer read FPerspective write FPersPective default 15;
   property Elevation:Integer read FElevation write FElevation default 345;
   property Rotation:Integer read FRotation write FRotation default 345;
   property Zoom:Integer read FZoom write FZoom default 100;
   property HorzOffset:Integer read FHorzOffset write FHorzOffset default 0;
   property VertOffset:Integer read FVertOffset write FVertOffset default 0;
   property Tilt:Integer read FTilt write FTilt default 0;
   property Orthogonal:Boolean read FOrthogonal write FOrthogonal default true;
   property MultiBar:TRpMultiBar read FMultiBar write FMultiBar
    default rpMultiside;
   property Resolution:Integer read FResolution write FResolution default 100;
   property ShowLegend:boolean read FShowLegend write FShowLegend
    default false;
   property ShowHint:boolean read FShowHint write FShowHint
    default true;
   property MarkStyle:Integer read FMarkStyle write FMarkStyle default 0;
   property HorzFontSize:Integer read FHorzFontSize write FHorzFontSize;
   property VertFontSize:Integer read FVertFontSize write FVertFontSize;
   property HorzFontRotation:Integer read FHorzFontRotation write FHorzFontRotation;
   property VertFontRotation:Integer read FVertFontRotation write FVertFontRotation;
  end;


implementation

uses rpbasereport;


const
 AlignmentFlags_SingleLine=64;


procedure TRpChart.SetChartType(avalue:TRpChartType);
begin
 FChartType:=avalue;
 if assigned(FIdenChart) then
  FIdenChart.DefaultChartType:=avalue;
end;

procedure TRpChart.Loaded;
begin
 inherited Loaded;
 FIdenChart.DefaultChartType:=FChartType;
end;

constructor TRpChart.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FShowHint:=true;
 FShowLegend:=False;
 FSeries:=TRpSeries.Create(TRpSeriesItem);
 Fseries.AutoRangel:=true;
 Fseries.AutoRangeh:=true;
 Fseries.Logaritmic:=false;
 FChangeSerieBool:=false;
 FClearExpressionBool:=false;
 FIdenChart:=TVariableGrap.Create(Self);
 FIdenChart.OnClear:=OnClear;
 FIdenChart.OnNewValue:=OnNewValue;
 FIdenChart.OnSerieColor:=OnSerieColor;
 FIdenChart.OnValueColor:=OnValueColor;
 FIdenChart.OnBounds:=OnBoundsValue;
 FView3d:=true;
 FPerspective:=15;
 FElevation:=345;
 FRotation:=345;
 FResolution:=100;
 FZoom:=100;
 FOrthogonal:=True;
 FMultiBar:=rpMultiside;
 //
 FMarkStyle:=0;
 FHorzFontSize:=10;
 FVertFontSize:=10;
 FHorzFontRotation:=0;
 FVertFontRotation:=0;
end;

procedure TRpChart.SetSeries(avalue:TRpSeries);
begin
 Series.Assign(avalue);
end;

procedure TRpChart.SetIdentifier(Value:string);
var
 fidens:TStringList;
 index:integer;
begin
 if (csloading in componentstate) then
 begin
  FIdentifier:=Value;
  exit;
 end;
 // Check if the identifier is used
 Value:=UpperCase(Trim(Value));
 if Value=FIdentifier then
  exit;
 fidens:=TRpBaseReport(GetReport).Identifiers;
 index:=fidens.IndexOf(Value);
 if index>=0 then
  Raise Exception.Create(SRpIdentifierAlreadyExists);
 // Erases previous identifier
 index:=fidens.IndexOf(FIdentifier);
 if index>=0 then
  fidens.Delete(index);
 FIdentifier:=Value;
 if Length(FIdentifier)>0 then
 begin
  fidens.AddObject(FIdentifier,self);
 end;
end;

procedure TRpChart.GetNewValue;
var
 aserie:TRpSeriesItem;
 newvalue:Variant;
 changeserie:boolean;
 caption:widestring;
begin
 if Length(FValueExpression)<1 then
  exit;
 EvaluateClearExpression;
 if FSeries.Count<1 then
 begin
  aserie:=FSeries.Add;
  aserie.charttype:=ChartType;
  if Length(FSerieCaption)>0 then
   aserie.Caption:=EvaluateSerieCaption;
  newvalue:=EvaluateSerieExpression;
  aserie.ChangeValue:=newvalue;
 end
 else
 begin
  // Looks if the serie has changed
  aserie:=FSeries.Items[FSeries.Count-1];
  newvalue:=EvaluateSerieExpression;
  changeserie:=false;
  if ChangeSerieBool then
  begin
   if Boolean(newvalue) then
    changeserie:=true
  end
  else
  begin
   if aserie.ChangeValue<>newvalue then
    changeserie:=true;
  end;
  if changeserie then
  begin
   aserie:=FSeries.Add;
   aserie.charttype:=ChartType;
   if Length(FSerieCaption)>0 then
    aserie.Caption:=EvaluateSerieCaption;
   aserie.ChangeValue:=newvalue;
   if Length(Trim(FSerieColorExpression))>0 then
   begin
    try
     aserie.Color:=EvaluateText(FSerieColorExpression);
    except
     on E:Exception do
     begin
      Raise TRpReportException.Create(E.Message+':'+SRpSChart+' '+Name,self,SrpSSerieColor);
     end;
    end;
   end;
  end;
 end;
 // Gests the data
 Evaluate;
 if Length(TRim(FCaptionExpression))<1 then
  Caption:=IntToStr(aserie.ValueCount+1)
 else
  Caption:=EvaluateCaption;
 aserie.AddValue(FValue,Caption);
 if Length(Trim(FColorExpression))>0 then
 begin
  try
   aserie.SetLastValueColor(EvaluateText(FColorExpression));
  except
   on E:Exception do
   begin
    Raise TRpReportException.Create(E.Message+':'+SRpSChart+' '+Name,self,SrpSValueColor);
   end;
  end;
 end;
end;


procedure TRpChart.Evaluate;
var
 fevaluator:TRpEvaluator;
begin
 if FUpdated then
  exit;
 try
  fevaluator:=TRpBaseReport(GetReport).Evaluator;
  fevaluator.Expression:=FValueExpression;
  fevaluator.Evaluate;
  FValue:=fevaluator.EvalResult;
  FUpdated:=true;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSExpression+' '+Name,self,SRpSExpression);
  end;
 end;
end;


function TRpChart.EvaluateCaption:Variant;
var
 fevaluator:TRpEvaluator;
begin
 if Length(Trim(FCaptionExpression))<1 then
 begin
  Result:='';
  exit;
 end;
 try
  fevaluator:=TRpBaseReport(GetReport).Evaluator;
  fevaluator.Expression:=FCaptionExpression;
  fevaluator.Evaluate;
  Result:=fevaluator.EvalResult;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSChart+' '+Name,self,SRpSCaptionExp);
  end;
 end;
end;

function TRpChart.EvaluateText(atext:WideString):Variant;
var
 fevaluator:TRpEvaluator;
begin
 if Length(Trim(atext))<1 then
 begin
  Result:='';
  exit;
 end;
 fevaluator:=TRpBaseReport(GetReport).Evaluator;
 fevaluator.Expression:=atext;
 fevaluator.Evaluate;
 Result:=fevaluator.EvalResult;
end;


procedure TRpChart.EvaluateClearExpression;
var
 fevaluator:TRpEvaluator;
 newclearvalue:Variant;
begin
 if Length(Trim(ClearExpression))<1 then
 begin
  exit;
 end;
 try
  fevaluator:=TRpBaseReport(GetReport).Evaluator;
  fevaluator.Expression:=ClearExpression;
  fevaluator.Evaluate;
  newclearvalue:=fevaluator.EvalResult;
  if ClearExpressionBool then
  begin
   if Boolean(newclearvalue) then
    Series.Clear;
  end
  else
  begin
   if FClearValue<>newclearvalue then
   begin
    Series.Clear;
    FClearValue:=newclearvalue;
   end;
  end;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSChart+' '+Name,self,SrpSChangeSerieExp);
  end;
 end;
end;

function TRpChart.EvaluateSerieExpression:Variant;
var
 fevaluator:TRpEvaluator;
begin
 if Length(Trim(ChangeSerieExpression))<1 then
 begin
  Result:=True;
  exit;
 end;
 try
  fevaluator:=TRpBaseReport(GetReport).Evaluator;
  fevaluator.Expression:=ChangeSerieExpression;
  fevaluator.Evaluate;
  Result:=fevaluator.EvalResult;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSChart+' '+Name,self,SrpSChangeSerieExp);
  end;
 end;
end;

function TRpChart.EvaluateSerieCaption:Variant;
var
 fevaluator:TRpEvaluator;
begin
 if Length(Trim(SerieCaption))<1 then
 begin
  Result:=WideString('');
  exit;
 end;
 try
  fevaluator:=TRpBaseReport(GetReport).Evaluator;
  fevaluator.Expression:=SerieCaption;
  fevaluator.Evaluate;
  Result:=WideString(fevaluator.EvalResult);
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSChart+' '+Name,self,SrpSSerieCaptionExp);
  end;
 end;
end;


function TRpChart.CheckValueCondition:boolean;
var
 fevaluator:TRpEvaluator;
begin
 if Length(Trim(FGetValuecondition))<1 then
 begin
  Result:=True;
  exit;
 end;
 try
  fevaluator:=TRpBaseReport(GetReport).Evaluator;
  fevaluator.Expression:=FGetValuecondition;
  fevaluator.Evaluate;
  Result:=fevaluator.EvalResult;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSChart+' '+Name,self,SrpSGetValueCondition);
  end;
 end;
end;


procedure TRpChart.SubReportChanged(newstate:TRpReportChanged;newgroup:string='');
begin
 inherited SubReportChanged(newstate,newgroup);
 case newstate of
  rpReportStart:
   begin
    FClearValue:=Null;
    FUpdated:=false;
    FSeries.Clear;
   end;
  rpDataChange:
   begin
    FUpdated:=false;
    // Gets a value if the condition is true
    if CheckValueCondition then
     GetNewValue;
   end;
 end;
end;




procedure TRpChart.DoPrint(adriver:TRpPrintDriver;
    aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);
begin
 inherited DoPrint(adriver,aposx,aposy,newwidth,newheight,metafile,MaxExtent,PartialPrint);
 if FSeries.Count<1 then
  exit;

 adriver.DrawChart(FSeries,metafile,aposx,aposy,self);
end;

procedure TRpChart.OnSerieColor(Color:Integer);
var
 aserie:TRpSeriesItem;
begin
 if FSeries.Count<1 then
  exit;
 aserie:=FSeries.Items[FSeries.Count-1];
 aserie.Color:=Color;
end;

procedure TRpChart.OnValueColor(Color:Integer);
var
 aserie:TRpSeriesItem;
begin
 if FSeries.Count<1 then
  exit;
 aserie:=FSeries.Items[FSeries.Count-1];
 aserie.SetLastValueColor(Color);
end;

procedure TRpChart.OnNewValue(Y:Single;Cambio:Boolean;leyen,textleyen,textserie:string;newcharttype:TRpChartType);
var
 aserie:TRpSeriesItem;
 firstserie:Boolean;
begin
 firstserie:=false;
 if FSeries.Count<1 then
 begin
  aserie:=FSeries.Add;
  aserie.charttype:=newChartType;
  aserie.Caption:=textserie;
  firstserie:=true;
 end
 else
 begin
  aserie:=FSeries.Items[FSeries.Count-1];
 end;
  // Looks if the serie has changed
 if Cambio then
 begin
  if not firstserie then
   aserie:=FSeries.Add;
  aserie.charttype:=newChartType;
  aserie.Caption:=textserie;
 end;
 aserie.AddValue(Y,leyen);
end;

procedure TRpChart.OnBoundsValue(autol,autoh:boolean;lvalue,hvalue:double;
  logaritmic:boolean;logbase:double;inverted:boolean);
begin
 FSeries.AutorangeL:=autol;
 FSeries.AutorangeH:=autoh;
 FSeries.LowValue:=lvalue;
 FSeries.HighValue:=hvalue;
 FSeries.Logaritmic:=logaritmic;
 FSeries.Logbase:=logbase;
 FSeries.Inverted:=inverted;
end;

procedure TRpChart.OnClear(Sender:TObject);
begin
 Series.Clear;
end;

procedure TRpChart.WriteGetValueCondition(Writer:TWriter);
begin
 WriteWideString(Writer, FGetValueCondition);
end;

procedure TRpChart.ReadGetValueCondition(Reader:TReader);
begin
 FGetValueCondition:=ReadWideString(Reader);
end;

procedure TRpChart.WriteValueExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FValueExpression);
end;

procedure TRpChart.ReadValueExpression(Reader:TReader);
begin
 FValueExpression:=ReadWideString(Reader);
end;

procedure TRpChart.WriteChangeSerieExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FChangeSerieExpression);
end;

procedure TRpChart.ReadChangeSerieExpression(Reader:TReader);
begin
 FChangeSerieExpression:=ReadWideString(Reader);
end;

procedure TRpChart.WriteClearExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FClearExpression);
end;


procedure TRpChart.ReadClearExpression(Reader:TReader);
begin
 FClearExpression:=ReadWideString(Reader);
end;

procedure TRpChart.WriteColorExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FColorExpression);
end;


procedure TRpChart.ReadColorExpression(Reader:TReader);
begin
 FColorExpression:=ReadWideString(Reader);
end;

procedure TRpChart.WriteSerieColorExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FSerieColorExpression);
end;


procedure TRpChart.ReadSerieColorExpression(Reader:TReader);
begin
 FSerieColorExpression:=ReadWideString(Reader);
end;


procedure TRpChart.WriteCaptionExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FCaptionExpression);
end;

procedure TRpChart.ReadCaptionExpression(Reader:TReader);
begin
 FCaptionExpression:=ReadWideString(Reader);
end;

procedure TRpChart.WriteSerieCaption(Writer:TWriter);
begin
 WriteWideString(Writer, FSerieCaption);
end;

procedure TRpChart.ReadSerieCaption(Reader:TReader);
begin
 FSerieCaption:=ReadWideString(Reader);
end;


procedure TRpChart.DefineProperties(Filer:TFiler);
begin
 inherited;

 Filer.DefineProperty('GetValueCondition',ReadGetValueCondition,WriteGetValueCondition,True);
 Filer.DefineProperty('ValueExpression',ReadValueExpression,WriteValueExpression,True);
 Filer.DefineProperty('ChangeSerieExpression',ReadChangeSerieExpression,WriteChangeSerieExpression,True);
 Filer.DefineProperty('CaptionExpression',ReadCaptionExpression,WriteCaptionExpression,True);
 Filer.DefineProperty('SerieCaption',ReadSerieCaption,WriteSerieCaption,True);
 Filer.DefineProperty('ClearExpression',ReadClearExpression,WriteClearExpression,True);
 Filer.DefineProperty('ColorExpression',ReadColorExpression,WriteColorExpression,True);
 Filer.DefineProperty('SerieColorExpression',ReadSerieColorExpression,WriteSerieColorExpression,True);
end;

end.

