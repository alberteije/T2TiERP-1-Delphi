{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdflabelintvcl                                }
{       Implementation label and expression designer    }
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


unit rpmdflabelintvcl;

interface

{$I rpconf.inc}

uses SysUtils, Classes,
  Windows,Graphics, Forms, Buttons, ExtCtrls, Controls,
  StdCtrls,rpvgraphutils,rpparams,
{$IFDEF USEVARIANTS}
  types,
{$ENDIF}
  rpprintitem,rplabelitem,rpmdobinsintvcl,rpmdconsts,
  rpgraphutilsvcl,rptypes;

type
 TRpLabelInterface=class(TRpGenTextInterface)
  private
  protected
   procedure Paint;override;
  public
   class procedure FillAncestors(alist:TStrings);override;
   constructor Create(AOwner:TComponent;pritem:TRpCommonComponent);override;
   procedure GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);override;
   procedure SetProperty(pname:string;value:Widestring);override;
   function GetProperty(pname:string):Widestring;override;
 end;

 TRpExpressionInterface=class(TRpGenTextInterface)
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

const
 AlignmentFlags_SingleLine=64;
 AlignmentFlags_AlignHCenter = 4 { $4 };
 AlignmentFlags_AlignTop = 8 { $8 };
 AlignmentFlags_AlignBottom = 16 { $10 };
 AlignmentFlags_AlignVCenter = 32 { $20 };
 AlignmentFlags_AlignLeft = 1 { $1 };
 AlignmentFlags_AlignRight = 2 { $2 };


var
 AggregatesString:array [rpAgNone..rpAgGeneral] of widestring;
 AggretypeString:array [rpagSum..rpagStdDev] of widestring;

function StringToAgeType(value:widestring):TRpAggregateType;
var
 i:TRpAggregateType;
begin
 Result:=rpAgSum;
 for i:=rpAgsum to rpAgStdDev do
 begin
  if AggreTypeString[i]=Value then
  begin
   Result:=i;
   break;
  end;
 end;
end;

function StringToAggregate(value:widestring):TRpAggregate;
var
 i:TRpAggregate;
begin
 Result:=rpAgNone;
 for i:=rpAgNone to rpAgGeneral do
 begin
  if AggregatesString[i]=Value then
  begin
   Result:=i;
   break;
  end;
 end;
end;


constructor TRpLabelInterface.Create(AOwner:TComponent;pritem:TRpCommonComponent);
begin
 if Not (pritem is TRpLabel) then
  Raise Exception.Create(SRpIncorrectComponentForInterface);
 inherited Create(AOwner,pritem);
end;

class procedure TRpLabelInterface.FillAncestors(alist:TStrings);
begin
 inherited FillAncestors(alist);
 alist.Add('TRpLabelInterface');
end;

procedure TRpLabelInterface.GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);
begin
 inherited GetProperties(lnames,ltypes,lvalues,lhints,lcat);
 // Text
 lnames.Add(SrpSText);
 ltypes.Add(SRpSString);
 lhints.Add('reflabel.html');
 lcat.Add(SRpLabel);
 if Assigned(lvalues) then
  lvalues.Add(TRpLabel(printitem).Text);
end;

procedure TRpLabelInterface.SetProperty(pname:string;value:Widestring);
begin
 if pname=SRpSText then
 begin
  TRpLabel(fprintitem).Text:=value;
  invalidate;
  exit;
 end;
 inherited SetProperty(pname,value);
end;

function TRpLabelInterface.GetProperty(pname:string):Widestring;
begin
 Result:='';
 if pname=SrpSText then
 begin
  Result:=TRpLabel(printitem).Text;
  exit;
 end;
 Result:=inherited GetProperty(pname);
end;


procedure TRpLabelInterface.Paint;
var
 alabel:TRpLabel;
 rec:TRect;
 aalign:Cardinal;
 aansitext:String;
 lalignment:integer;
 alvcenter,alvbottom:boolean;
 calcrect:boolean;
 arec:TRect;
begin
 alabel:=TRpLabel(printitem);
 if csDestroying in alabel.ComponentState then
  exit;

 // Draws the text
 Canvas.Font.Name:=alabel.WFontName;

 Canvas.Font.Color:=alabel.FontColor;
 Canvas.Font.Size:=Round(alabel.FontSize*Scale);
 Canvas.Font.Style:=CLXIntegerToFontStyle(alabel.FontStyle);
 rec.Top:=0;
 rec.Left:=0;
 rec.Right:=Width-1;
 rec.Bottom:=Height-1;
 Canvas.Brush.Style:=bsClear;
 if Not alabel.Transparent then
 begin
  Canvas.Brush.Color:=alabel.BackColor;
 end;
 lAlignment:=alabel.PrintAlignment;
 aalign:=DT_NOPREFIX;
 if (lAlignMent AND AlignmentFlags_AlignHCenter)>0 then
  aalign:=aalign or DT_CENTER;
 if (lAlignMent AND AlignmentFlags_SingleLine)>0 then
  aalign:=aalign or DT_SINGLELINE;
 if (lAlignMent AND AlignmentFlags_AlignLEFT)>0 then
  aalign:=aalign or DT_LEFT;
 if (lAlignMent AND AlignmentFlags_AlignRight)>0 then
  aalign:=aalign or DT_RIGHT;
 if alabel.WordWrap then
  aalign:=aalign or DT_WORDBREAK;
 if Not alabel.CutText then
  aalign:=aalign or DT_NOCLIP;
 if alabel.RightToLeft then
  aalign:=aalign or DT_RTLREADING;
 if alabel.Transparent then
  SetBkMode(Canvas.Handle,TRANSPARENT)
 else
  SetBkMode(Canvas.Handle,OPAQUE);
 aansitext:=alabel.text;

 alvbottom:=(alabel.VAlignMent AND AlignmentFlags_AlignBottom)>0;
 alvcenter:=(alabel.VAlignMent AND AlignmentFlags_AlignVCenter)>0;

 calcrect:=(not alabel.Transparent) or alvbottom or alvcenter;
 arec:=rec;
 if calcrect then
 begin
  // First calculates the text extent
  // Win9x does not support drawing WideChars
{$IFNDEF DOTNETD}
  if IsWindowsNT then
   DrawTextW(Canvas.Handle,PWideChar(alabel.text),Length(alabel.text),arec,aalign or DT_CALCRECT)
  else
   DrawTextA(Canvas.Handle,PChar(aansitext),Length(aansitext),arec,aalign or DT_CALCRECT);
{$ENDIF}
{$IFDEF DOTNETD}
  if IsWindowsNT then
   DrawTextW(Canvas.Handle,alabel.text,Length(alabel.text),arec,aalign or DT_CALCRECT)
  else
   DrawTextA(Canvas.Handle,aansitext,Length(aansitext),arec,aalign or DT_CALCRECT);
{$ENDIF}
  Canvas.Brush.Style:=bsSolid;
  Canvas.Brush.Color:=alabel.BackColor;
 end
 else
  Canvas.Brush.Style:=bsClear;
 if alvbottom then
 begin
  rec.Top:=rec.Top+(rec.bottom-arec.bottom)
 end;
 if alvcenter then
 begin
  rec.Top:=rec.Top+((rec.bottom-arec.bottom) div 2);
 end;
{$IFNDEF DOTNETD}
 if IsWindowsNT then
  DrawTextW(Canvas.Handle,PWideChar(alabel.text),Length(alabel.text),rec,aalign)
 else
  DrawTextA(Canvas.Handle,PChar(aansitext),Length(aansitext),rec,aalign);
{$ENDIF}
{$IFDEF DOTNETD}
 if IsWindowsNT then
  DrawTextW(Canvas.Handle,alabel.text,Length(alabel.text),rec,aalign)
 else
  DrawTextA(Canvas.Handle,aansitext,Length(aansitext),rec,aalign);
{$ENDIF}
 Canvas.Pen.Color:=clBlack;
 Canvas.Pen.Style:=psSolid;
 Canvas.Brush.Style:=bsClear;
 Canvas.Rectangle(0,0,Width,Height);
 DrawSelected;
end;


constructor TRpExpressionInterface.Create(AOwner:TComponent;pritem:TRpCommonComponent);
begin
 if Not (pritem is TRpExpression) then
  Raise Exception.Create(SRpIncorrectComponentForInterface);
 inherited Create(AOwner,pritem);
end;

class procedure TRpExpressionInterface.FillAncestors(alist:TStrings);
begin
 inherited FillAncestors(alist);
 alist.Add('TRpExpressionInterface');
end;

procedure TRpExpressionInterface.GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);
begin
 inherited GetProperties(lnames,ltypes,lvalues,lhints,lcat);
 // Expression
 lnames.Add(SrpSExpression);
 ltypes.Add(SRpSExpression);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(TRpExpression(printitem).Expression);

 // Data Type
 lnames.Add(SRpSDataType);
 ltypes.Add(SRpSList);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  ParamTypeToString(TRpExpression(printitem).DataType);

 // Display format
 lnames.Add(SrpSDisplayFOrmat);
 ltypes.Add(SRpSString);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(TRpExpression(printitem).DisplayFormat);
 // Multipage
 lnames.Add(SRpMultiPage);
 ltypes.Add(SRpSBool);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpExpression(printitem).MultiPage,true));
 lnames.Add(SRpPrintNulls);
 ltypes.Add(SRpSBool);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpExpression(printitem).PrintNulls,true));

 // Identifier
 lnames.Add(SrpSIdentifier);
 ltypes.Add(SRpSString);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(TRpExpression(printitem).Identifier);

 // Aggregate
 lnames.Add(SrpSAggregate);
 ltypes.Add(SRpSList);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(AggregatesString[TRpExpression(printitem).Aggregate]);


 // Aggregate group
 lnames.Add(SrpSAgeGroup);
 ltypes.Add(SRpGroup);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(TRpExpression(printitem).GroupName);

 // Aggregate type
 lnames.Add(SrpSAgeType);
 ltypes.Add(SRpSList);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(AggretypeString[TRpExpression(printitem).AgType]);

  // Aggregate Ini value
 lnames.Add(SrpSIniValue);
 ltypes.Add(SRpSExpression);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(TRpExpression(printitem).AgIniValue);

 // Print Only One
 lnames.Add(SRpSOnlyOne);
 ltypes.Add(SRpSBool);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpExpression(printitem).PrintOnlyOne,true));
 // Export Expression
 lnames.Add(SRpSExportExpression);
 ltypes.Add(SRpSExpression);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(TRpExpression(printitem).ExportExpression);

 // Export Display format
 lnames.Add(SRpSExportFormat);
 ltypes.Add(SRpSString);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(TRpExpression(printitem).ExportDisplayFormat);

 // Export Line
 lnames.Add(SRpSExportLine);
 ltypes.Add(SRpSInteger);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpExpression(printitem).ExportLine));

 // Export Position
 lnames.Add(SRpSExportPos);
 ltypes.Add(SRpSInteger);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpExpression(printitem).ExportPosition));

 // Export Size
 lnames.Add(SRpSExportSize);
 ltypes.Add(SRpSInteger);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpExpression(printitem).ExportSize));

 // Export Do New Line
 lnames.Add(SRpSExportDoNewLine);
 ltypes.Add(SRpSBool);
 lhints.Add('refexpression.html');
 lcat.Add(SRpExpression);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpExpression(printitem).ExportDoNewLine,true));
end;

procedure TRpExpressionInterface.SetProperty(pname:string;value:Widestring);
begin
 if pname=SRpSExpression then
 begin
  TRpExpression(fprintitem).Expression:=value;
  invalidate;
  exit;
 end;
 if pname=SRpSDatatype then
 begin
  TRpExpression(fprintitem).DataType:=StringToParamType(Value);
  exit;
 end;
 if pname=SRpSDisplayFormat then
 begin
  TRpExpression(fprintitem).DisplayFormat:=value;
  exit;
 end;
 if pname=SRpMultiPage then
 begin
  TRpExpression(fprintitem).MultiPage:=StrToBool(Value);
  exit;
 end;
 if pname=SRpPrintNulls then
 begin
  TRpExpression(fprintitem).PrintNulls:=StrToBool(Value);
  exit;
 end;
 if pname=SRpSIdentifier then
 begin
  TRpExpression(fprintitem).Identifier:=value;
  exit;
 end;
 if pname=SrpSAggregate then
 begin
  TRpExpression(fprintitem).Aggregate:=StringToAggregate(Value);
  exit;
 end;
 if pname=SrpSAgeGroup then
 begin
  TRpExpression(fprintitem).GroupName:=Value;
  exit;
 end;
 if pname=SrpSAgeType then
 begin
  TRpExpression(fprintitem).AgType:=StringToAgeType(Value);
  exit;
 end;
 if pname=SrpSIniValue then
 begin
  TRpExpression(fprintitem).AgIniValue:=Value;
  exit;
 end;
 if pname=SrpSOnlyOne then
 begin
  TRpExpression(fprintitem).PrintOnlyOne:=StrToBool(Value);
  exit;
 end;
 if pname=SRpSExportExpression then
 begin
  TRpExpression(fprintitem).ExportExpression:=value;
  exit;
 end;
 if pname=SRpSExportFormat then
 begin
  TRpExpression(fprintitem).ExportDisplayFormat:=value;
  exit;
 end;
 if pname=SRpSExportLine then
 begin
  TRpExpression(fprintitem).ExportLine:=StrToInt(value);
  exit;
 end;
 if pname=SRpSExportPos then
 begin
  TRpExpression(fprintitem).ExportPosition:=StrToInt(value);
  exit;
 end;
 if pname=SRpSExportSize then
 begin
  TRpExpression(fprintitem).ExportSize:=StrToInt(value);
  exit;
 end;
 if pname=SRpSExportDoNewLine then
 begin
  TRpExpression(fprintitem).ExportDoNewLine:=StrToBool(value);
  exit;
 end;
 inherited SetProperty(pname,value);
end;

function TRpExpressionInterface.GetProperty(pname:string):Widestring;
begin
 Result:='';
 if pname=SrpSExpression then
 begin
  Result:=TRpExpression(printitem).Expression;
  exit;
 end;
 if pname=SRpSDataType then
 begin
  Result:=ParamTypeToString(TRpExpression(printitem).DataType);
  exit;
 end;
 if pname=SrpSDisplayFormat then
 begin
  Result:=TRpExpression(printitem).DisplayFormat;
  exit;
 end;
 if pname=SRpMultiPage then
 begin
  Result:=BoolToStr(TRpExpression(printitem).MultiPage,true);
  exit;
 end;
 if pname=SrpPrintNulls then
 begin
  Result:=BoolToStr(TRpExpression(printitem).PrintNulls,true);
  exit;
 end;
 if pname=SrpSIdentifier then
 begin
  Result:=TRpExpression(printitem).Identifier;
  exit;
 end;
 if pname=SrpSAggregate then
 begin
  Result:=AggregatesString[TRpExpression(printitem).Aggregate];
  exit;
 end;
 if pname=SrpSAgeGroup then
 begin
  Result:=TRpExpression(printitem).GroupName;
  exit;
 end;
 if pname=SrpSAgeType then
 begin
  Result:=AggretypeString[TRpExpression(printitem).AgType];
  exit;
 end;
 if pname=SrpSIniValue then
 begin
  Result:=TRpExpression(printitem).AgIniValue;
  exit;
 end;
 if pname=SrpSOnlyOne then
 begin
  Result:=BoolToStr(TRpExpression(printitem).PrintOnlyOne,true);
  exit;
 end;
 if pname=SrpSExportExpression then
 begin
  Result:=TRpExpression(printitem).ExportExpression;
  exit;
 end;
 if pname=SRpSExportFormat then
 begin
  Result:=TRpExpression(printitem).ExportDisplayFormat;
  exit;
 end;
 if pname=SRpSExportLine then
 begin
  Result:=IntToStr(TRpExpression(printitem).ExportLine);
  exit;
 end;
 if pname=SRpSExportPos then
 begin
  Result:=IntToStr(TRpExpression(printitem).ExportPosition);
  exit;
 end;
 if pname=SRpSExportSize then
 begin
  Result:=IntToStr(TRpExpression(printitem).ExportSize);
  exit;
 end;
 if pname=SRpSExportDoNewLine then
 begin
  Result:=BoolToStr(TRpExpression(printitem).ExportDoNewLine,true);
  exit;
 end;

 Result:=inherited GetProperty(pname);
end;

procedure TRpExpressionInterface.GetPropertyValues(pname:string;
 lpossiblevalues:TRpWideStrings);
var
 i:TRpAggregate;
 it:TRpAggregateType;
begin
 if pname=SRpSAgeType then
 begin
  for it:=rpAgsum to rpAgStdDev do
  begin
   lpossiblevalues.Add(AggreTypeString[it]);
  end;
  exit;
 end;
 if pname=SRpSDataType then
 begin
  GetPossibleDataTypesRuntime(lpossiblevalues);
  exit;
 end;
 if pname=SRpSAggregate then
 begin
  for i:=rpAgNone to rpAgGeneral do
  begin
   lpossiblevalues.Add(AggregatesString[i]);
  end;
  exit;
 end;

 inherited GetPropertyValues(pname,lpossiblevalues);
end;


procedure TRpExpressionInterface.Paint;
var
 aexp:TRpExpression;
 rec:TRect;
 aalign:Cardinal;
 aansitext:String;
 eAlignMent:integer;
 alvcenter:Boolean;
 alvbottom:Boolean;
 arec:TRect;
 calcrect:boolean;
begin
 aexp:=TRpExpression(printitem);
 if csDestroying in aexp.ComponentState then
  exit;

 Canvas.Font.Name:=aexp.WFontName;
 Canvas.Font.Color:=aexp.FontColor;
 Canvas.Font.Size:=Round(aexp.FontSize*Scale);
 Canvas.Font.Style:=CLXIntegerToFontStyle(aexp.FontStyle);

 rec.Top:=0;
 rec.Left:=0;
 rec.Right:=Width-1;
 rec.Bottom:=Height-1;
 Canvas.Brush.Style:=bsClear;
 if Not aexp.Transparent then
 begin
  Canvas.Brush.Color:=aexp.BackColor;
 end;
 aalign:=DT_NOPREFIX;
 eAlignMent:=aexp.PrintAlignMent;
 if (eAlignMent AND AlignmentFlags_AlignHCenter)>0 then
  aalign:=aalign or DT_CENTER;
 if (eAlignMent AND AlignmentFlags_SingleLine)>0 then
  aalign:=aalign or DT_SINGLELINE;
 if (eAlignMent AND AlignmentFlags_AlignLEFT)>0 then
  aalign:=aalign or DT_LEFT;
 if (eAlignMent AND AlignmentFlags_AlignRight)>0 then
  aalign:=aalign or DT_RIGHT;
 if aexp.WordWrap then
  aalign:=aalign or DT_WORDBREAK;
 if Not aexp.CutText then
  aalign:=aalign or DT_NOCLIP;
 if aexp.Transparent then
  SetBkMode(Canvas.Handle,TRANSPARENT)
 else
  SetBkMode(Canvas.Handle,OPAQUE);
 aansitext:=aexp.Expression;

 alvbottom:=(aexp.VAlignMent AND AlignmentFlags_AlignBottom)>0;
 alvcenter:=(aexp.VAlignMent AND AlignmentFlags_AlignVCenter)>0;

 calcrect:=(not aexp.Transparent) or alvbottom or alvcenter;
 arec:=rec;
 if calcrect then
 begin
  // First calculates the text extent
  // Win9x does not support drawing WideChars
  if IsWindowsNT then
   DrawTextW(Canvas.Handle,PWideChar(aexp.Expression),Length(aexp.Expression),arec,aalign or DT_CALCRECT)
  else
   DrawTextA(Canvas.Handle,PChar(aansitext),Length(aansitext),arec,aalign or DT_CALCRECT);
  Canvas.Brush.Style:=bsSolid;
  Canvas.Brush.Color:=aexp.BackColor;
 end
 else
  Canvas.Brush.Style:=bsClear;
 if alvbottom then
 begin
  rec.Top:=rec.Top+(rec.bottom-arec.bottom)
 end;
 if alvcenter then
 begin
  rec.Top:=rec.Top+((rec.bottom-arec.bottom) div 2);
 end;
 if IsWindowsNT then
  DrawTextW(Canvas.Handle,PWideChar(aexp.Expression),Length(aexp.Expression),rec,aalign)
 else
  DrawTextA(Canvas.Handle,PChar(aansitext),Length(aansitext),rec,aalign);
 Canvas.Pen.Color:=clBlack;
 Canvas.Pen.Style:=psDashDot;
 Canvas.Brush.Style:=bsClear;
 Canvas.Rectangle(0,0,Width,Height);
 DrawSelected;
end;

initialization
 AggregatesString[rpAgNone]:=SRpNone;
 AggregatesString[rpAgGroup]:=SRpGroup;
 AggregatesString[rpAgPage]:=SRpPage;
 AggregatesString[rpAgGeneral]:=SRpGeneral;
 AggretypeString[rpagSum]:=SrpSum;
 AggretypeString[rpagMin]:=SrpMin;
 AggretypeString[rpagMax]:=SrpMax;
 AggretypeString[rpagAvg]:=SrpAvg;
 AggretypeString[rpagStdDev]:=SrpStdDev;
end.
