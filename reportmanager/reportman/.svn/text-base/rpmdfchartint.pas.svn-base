{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfchartint                                   }
{       Implementation chart designer                   }
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


unit rpmdfchartint;

interface

{$I rpconf.inc}

uses SysUtils, Classes,
  QGraphics, QForms,Qt,rpmdcharttypes,
  QButtons, QExtCtrls, QControls, QStdCtrls,
  types,
  rpprintitem,rpmdchart,rpmdobinsint,rpmdconsts,
  rpgraphutils,rptypes;

type
 TRpChartInterface=class(TRpGenTextInterface)
  private
  protected
   procedure Paint;override;
  public
   class procedure FillAncestors(alist:TStrings);override;
   constructor Create(AOwner:TComponent;pritem:TRpCommonComponent);override;
   procedure GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);override;
   procedure SetProperty(pname:string;value:Widestring);override;
   function GetProperty(pname:string):Widestring;override;
   procedure GetPropertyValues(pname:string;lpossiblevalues:TRpWideStrings);override;
 end;




implementation



constructor TRpChartInterface.Create(AOwner:TComponent;pritem:TRpCommonComponent);
begin
 if Not (pritem is TRpChart) then
  Raise Exception.Create(SRpIncorrectComponentForInterface);
 inherited Create(AOwner,pritem);
end;

class procedure TRpChartInterface.FillAncestors(alist:TStrings);
begin
 inherited FillAncestors(alist);
 alist.Add('TRpChartInterface');
end;

procedure TRpChartInterface.GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);
begin
 inherited GetProperties(lnames,ltypes,lvalues,lhints,lcat);

 // Expression
 lnames.Add(SrpSExpression);
 ltypes.Add(SRpSExpression);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(TRpChart(printitem).ValueExpression);

 // Identifier
 lnames.Add(SrpSIdentifier);
 ltypes.Add(SRpSString);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(TRpChart(printitem).Identifier);

 // Chart type
 lnames.Add(SrpSChartType);
 ltypes.Add(SRpSList);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(RpChartTypeToString(TRpChart(printitem).ChartType));

 // GetValue condition
 lnames.Add(SrpSGetValueCondition);
 ltypes.Add(SRpSExpression);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(TRpChart(printitem).GetValueCondition);

 // Serie Expression
 lnames.Add(SrpSChangeSerieExp);
 ltypes.Add(SRpSExpression);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(TRpChart(printitem).ChangeSerieExpression);

 // Serie Bool  Expression
 lnames.Add(SrpSChangeSerieBool);
 ltypes.Add(SRpSBool);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpChart(printitem).ChangeSerieBool,True));

 // Clear Expression
 lnames.Add(SrpSClearExpChart);
 ltypes.Add(SRpSExpression);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(TRpChart(printitem).ClearExpression);

 // Clear Expression Bool
 lnames.Add(SrpSBoolClearExp);
 ltypes.Add(SRpSBool);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpChart(printitem).ClearExpressionBool,True));

 // Caption Expression
 lnames.Add(SrpSCaptionExp);
 ltypes.Add(SRpSExpression);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(TRpChart(printitem).CaptionExpression);

 // Serie Caption Expression
 lnames.Add(SrpSSerieCaptionExp);
 ltypes.Add(SRpSExpression);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(TRpChart(printitem).SerieCaption);

 // Chart Driver
 lnames.Add(SrpSDriver);
 ltypes.Add(SRpSList);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(RpChartDriverToString(TRpChart(printitem).Driver));

 // View3D
 lnames.Add(SRpSView3D);
 ltypes.Add(SRpSBool);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpChart(printitem).View3D,True));

 // View3D Walls
 lnames.Add(SRpSView3DWalls);
 ltypes.Add(SRpSBool);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpChart(printitem).View3DWalls,True));

 // Perspective
 lnames.Add(SRpSPerspective);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).Perspective));

 // Elevation
 lnames.Add(SRpSElevation);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).Elevation));

 // Rotation
 lnames.Add(SRpSRotation);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).Rotation));

 // Orthogonal
 lnames.Add(SRpSOrthogonal);
 ltypes.Add(SRpSBool);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpChart(printitem).Orthogonal,True));

 // Zoom
 lnames.Add(SRpSZoom);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).Zoom));

 // H.Offset
 lnames.Add(SRpSHOffset);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).HorzOffset));

 // H.Offset
 lnames.Add(SRpSVOffset);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).VertOffset));

 // Tilt
 lnames.Add(SRpSTilt);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).Tilt));

 // Resolution
 lnames.Add(SRpDPIRes);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).Resolution));

 // Multibar
 lnames.Add(SRpSMultibar);
 ltypes.Add(SRpSList);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(RpMultiBarToString(TRpChart(printitem).MultiBar));

 // Hint
 lnames.Add(SrpChartHint);
 ltypes.Add(SRpSBool);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpChart(printitem).ShowHint,True));
 // Legend
 lnames.Add(SrpChartLegend);
 ltypes.Add(SRpSBool);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpChart(printitem).ShowLegend,True));
 // Mark Type
 lnames.Add(SRpMarkType);
 ltypes.Add(SRpSList);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(RpMarkTypeToString(TRpChart(printitem).MarkStyle));
 // Axis
 lnames.Add(SRpSVertAxisFSize);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).VertFontSize));
 lnames.Add(SRpSHorzAxisFSize);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).HorzFontSize));
 lnames.Add(SRpSVertAxisFRot);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).VertFontRotation));
 lnames.Add(SRpSHorzAxisFRot);
 ltypes.Add(SRpSInteger);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartAspect);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpChart(printitem).HorzFontRotation));
 // Colors
 // Value Color
 lnames.Add(SrpSValueColor);
 ltypes.Add(SRpSExpression);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(TRpChart(printitem).ColorExpression);
 // Serie Color
 lnames.Add(SrpSSerieColor);
 ltypes.Add(SRpSExpression);
 lhints.Add('refchart.html');
 lcat.Add(SRpChartData);
 if Assigned(lvalues) then
  lvalues.Add(TRpChart(printitem).SerieColorExpression);
end;

procedure TRpChartInterface.SetProperty(pname:string;value:Widestring);
begin
 if pname=SRpSExpression then
 begin
  TRpChart(fprintitem).ValueExpression:=value;
  exit;
 end;
 if pname=SRpSIdentifier then
 begin
  TRpChart(fprintitem).Identifier:=value;
  exit;
 end;
 if pname=SrpSChartType then
 begin
  TRpChart(fprintitem).ChartType:=StringToRpChartType(Value);
  exit;
 end;
 if pname=SrpSGetValueCondition then
 begin
  TRpChart(fprintitem).GetValueCondition:=value;
  exit;
 end;
 if pname=SrpSChangeSerieExp then
 begin
  TRpChart(fprintitem).ChangeSerieExpression:=value;
  exit;
 end;
 if pname=SrpSChangeSerieBool then
 begin
  TRpChart(fprintitem).ChangeSerieBool:=StrToBool(value);
  exit;
 end;
 if pname=SrpSClearExpChart then
 begin
  TRpChart(fprintitem).ClearExpression:=value;
  exit;
 end;
 if pname=SrpSBoolClearExp then
 begin
  TRpChart(fprintitem).ClearExpressionBool:=StrToBool(value);
  exit;
 end;
 if pname=SrpSCaptionExp then
 begin
  TRpChart(fprintitem).CaptionExpression:=value;
  exit;
 end;
 if pname=SrpSSerieCaptionExp then
 begin
  TRpChart(fprintitem).SerieCaption:=value;
  exit;
 end;
 if pname=SrpSDriver then
 begin
  TRpChart(fprintitem).Driver:=StringToRpChartDriver(Value);
  exit;
 end;
 if pname=SrpSView3D then
 begin
  TRpChart(fprintitem).View3d:=StrToBool(value);
  exit;
 end;
 if pname=SrpSView3DWalls then
 begin
  TRpChart(fprintitem).View3dWalls:=StrToBool(value);
  exit;
 end;
 if pname=SrpSperspective then
 begin
  TRpChart(fprintitem).Perspective:=StrToInt(value);
  exit;
 end;
 if pname=SrpSElevation then
 begin
  TRpChart(fprintitem).Elevation:=StrToInt(value);
  exit;
 end;
 if pname=SrpSRotation then
 begin
  TRpChart(fprintitem).Rotation:=StrToInt(value);
  exit;
 end;
 if pname=SrpSOrthogonal then
 begin
  TRpChart(fprintitem).Orthogonal:=StrToBool(value);
  exit;
 end;
 if pname=SrpSZoom then
 begin
  TRpChart(fprintitem).Zoom:=StrToInt(value);
  exit;
 end;
 if pname=SrpSHOffset then
 begin
  TRpChart(fprintitem).HorzOffSet:=StrToInt(value);
  exit;
 end;
 if pname=SrpSVOffset then
 begin
  TRpChart(fprintitem).VertOffset:=StrToInt(value);
  exit;
 end;
 if pname=SrpSTilt then
 begin
  TRpChart(fprintitem).Tilt:=StrToInt(value);
  exit;
 end;
 if pname=SRpDPIRes then
 begin
  TRpChart(fprintitem).Resolution:=StrToInt(value);
  exit;
 end;
 if pname=SrpSMultibar then
 begin
  TRpChart(fprintitem).Multibar:=StringToRpMultibar(value);
  exit;
 end;
 if pname=SrpChartHint then
 begin
  TRpChart(fprintitem).ShowHint:=StrToBool(value);
  exit;
 end;
 if pname=SrpChartLegend then
 begin
  TRpChart(fprintitem).ShowLegend:=StrToBool(value);
  exit;
 end;
 if pname=SRpMarkType then
 begin
  TRpChart(fprintitem).MarkStyle:=StringToRpMarkType(value);
  exit;
 end;
 if pname=SRpSVertAxisFSize then
 begin
  TRpChart(fprintitem).VertFontSize:=StrToInt(value);
  exit;
 end;
 if pname=SRpSHorzAxisFSize then
 begin
  TRpChart(fprintitem).HorzFontSize:=StrToInt(value);
  exit;
 end;
 if pname=SRpSVertAxisFRot then
 begin
  TRpChart(fprintitem).VertFontRotation:=StrToInt(value);
  exit;
 end;
 if pname=SRpSHorzAxisFRot then
 begin
  TRpChart(fprintitem).HorzFontRotation:=StrToInt(value);
  exit;
 end;
 if pname=SRpSValueColor then
 begin
  TRpChart(fprintitem).ColorExpression:=value;
  exit;
 end;
 if pname=SRpSSerieColor then
 begin
  TRpChart(fprintitem).SerieColorExpression:=value;
  exit;
 end;
 inherited SetProperty(pname,value);
end;

function TRpChartInterface.GetProperty(pname:string):Widestring;
begin
 Result:='';
 if pname=SrpSExpression then
 begin
  Result:=TRpChart(printitem).ValueExpression;
  exit;
 end;
 if pname=SrpSIdentifier then
 begin
  Result:=TRpChart(printitem).Identifier;
  exit;
 end;
 if pname=SrpSChartType then
 begin
  Result:=RpChartTypeToString(TRpChart(printitem).ChartType);
  exit;
 end;
 if pname=SrpSGetValueCondition then
 begin
  Result:=TRpChart(printitem).GetValueCondition;
  exit;
 end;
 if pname=SrpSChangeSerieExp then
 begin
  Result:=TRpChart(printitem).ChangeSerieExpression;
  exit;
 end;
 if pname=SrpSChangeSerieBool then
 begin
  Result:=BoolToStr(TRpChart(printitem).ChangeSerieBool,True);
  exit;
 end;
 if pname=SrpSClearExpChart then
 begin
  Result:=TRpChart(printitem).ClearExpression;
  exit;
 end;
 if pname=SrpSBoolClearExp then
 begin
  Result:=BoolToStr(TRpChart(printitem).ClearExpressionBool,True);
  exit;
 end;
 if pname=SrpSCaptionExp then
 begin
  Result:=TRpChart(printitem).CaptionExpression;
  exit;
 end;
 if pname=SrpSSerieCaptionExp then
 begin
  Result:=TRpChart(printitem).SerieCaption;
  exit;
 end;
 if pname=SrpSDriver then
 begin
  Result:=RpChartDriverToString(TRpChart(printitem).Driver);
  exit;
 end;
 if pname=SrpSView3D then
 begin
  Result:=BoolToStr(TRpChart(printitem).View3D,True);
  exit;
 end;
 if pname=SrpSView3DWalls then
 begin
  Result:=BoolToStr(TRpChart(printitem).View3DWalls,True);
  exit;
 end;
 if pname=SrpSPerspective then
 begin
  Result:=IntToStr(TRpChart(printitem).Perspective);
  exit;
 end;
 if pname=SrpSElevation then
 begin
  Result:=IntToStr(TRpChart(printitem).Elevation);
  exit;
 end;
 if pname=SrpSRotation then
 begin
  Result:=IntToStr(TRpChart(printitem).Elevation);
  exit;
 end;
 if pname=SrpSOrthogonal then
 begin
  Result:=BoolToStr(TRpChart(printitem).Orthogonal,True);
  exit;
 end;
 if pname=SrpSZoom then
 begin
  Result:=IntToStr(TRpChart(printitem).Zoom);
  exit;
 end;
 if pname=SrpSHOffset then
 begin
  Result:=IntToStr(TRpChart(printitem).HorzOffset);
  exit;
 end;
 if pname=SrpSVOffset then
 begin
  Result:=IntToStr(TRpChart(printitem).VertOffset);
  exit;
 end;
 if pname=SrpSTilt then
 begin
  Result:=IntToStr(TRpChart(printitem).Tilt);
  exit;
 end;
 if pname=SRpDPIRes then
 begin
  Result:=IntToStr(TRpChart(printitem).Resolution);
  exit;
 end;
 if pname=SrpSMultibar then
 begin
  Result:=RpMultiBarToString(TRpChart(printitem).Multibar);
  exit;
 end;
 if pname=SrpChartHint then
 begin
  Result:=BoolToStr(TRpChart(printitem).ShowHint,True);
  exit;
 end;
 if pname=SrpChartLegend then
 begin
  Result:=BoolToStr(TRpChart(printitem).ShowLegend,True);
  exit;
 end;
 if pname=SRpMarkType then
 begin
  Result:=RpMarkTypeToString(TRpChart(fprintitem).MarkStyle);
  exit;
 end;
 if pname=SRpSVertAxisFSize then
 begin
  Result:=IntToStr(TRpChart(fprintitem).VertFontSize);
  exit;
 end;
 if pname=SRpSHorzAxisFSize then
 begin
  Result:=IntToStr(TRpChart(fprintitem).HorzFontSize);
  exit;
 end;
 if pname=SRpSVertAxisFRot then
 begin
  Result:=IntToStr(TRpChart(fprintitem).VertFontRotation);
  exit;
 end;
 if pname=SRpSHorzAxisFRot then
 begin
  Result:=IntToStr(TRpChart(fprintitem).HorzFontRotation);
  exit;
 end;
 if pname=SRpSValueColor then
 begin
  Result:=TRpChart(fprintitem).ColorExpression;
  exit;
 end;
 if pname=SRpSSerieColor then
 begin
  Result:=TRpChart(fprintitem).SerieColorExpression;
  exit;
 end;
 Result:=inherited GetProperty(pname);
end;

procedure TRpChartInterface.GetPropertyValues(pname:string;
 lpossiblevalues:TRpWideStrings);
begin
 if pname=SRpSChartType then
 begin
  GetRpChartTypePossibleValues(lpossiblevalues);
  exit;
 end;
 if pname=SRpSDriver then
 begin
  GetRpChartDriverPossibleValues(lpossiblevalues);
  exit;
 end;
 if pname=SRpSMultibar then
 begin
  GetRpMultibarPossibleValues(lpossiblevalues);
  exit;
 end;
 if pname=SRpMarkType then
 begin
  GetRpMarTypePossibleValues(lpossiblevalues);
  exit;
 end;
 inherited GetPropertyValues(pname,lpossiblevalues);
end;


procedure TRpChartInterface.Paint;
var
 aexp:TRpChart;
 rec:TRect;
 aalign:integer;
begin
 aexp:=TRpChart(printitem);
 if csDestroying in aexp.ComponentState then
  exit;

 // Draws the text
{$IFDEF MSWINDOWS}
 Canvas.Font.Name:=aexp.WFontName;
{$ENDIF}
{$IFDEF LINUX}
 Canvas.Font.Name:=aexp.LFontName;
{$ENDIF}
 Canvas.Font.Color:=aexp.FontColor;
 Canvas.Font.Size:=aexp.FontSize;
 Canvas.Font.Style:=IntegerToFontStyle(aexp.FontStyle);

 rec.Top:=0;
 rec.Left:=0;
 rec.Right:=Width-1;
 rec.Bottom:=Height-1;
 aalign:=aexp.PrintAlignment or aexp.VAlignment;
 if aexp.SingleLine then
  aalign:=aalign or Integer(AlignmentFlags_SingleLine);
 if aexp.Wordwrap then
  aalign:=aalign or Integer(AlignmentFlags_WordBreak);
 if Not aexp.Transparent then
 begin
  Canvas.TextExtent(aexp.ValueExpression,rec,aalign);
  Canvas.Brush.Style:=bsSolid;
  Canvas.Brush.Color:=aexp.BackColor;
  Canvas.FillRect(rec);
 end;
 Canvas.Brush.Style:=bsClear;
 Canvas.TextRect(rec,0,0,aexp.ValueExpression,aalign);

 Canvas.Pen.Color:=clBlack;
 Canvas.Pen.Style:=psDashDot;
 Canvas.Brush.Style:=bsClear;
 Canvas.Rectangle(0,0,Width,Height);
 DrawSelected;
end;


end.
