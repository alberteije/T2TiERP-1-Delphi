{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfbarcodeint                                 }
{       Implementation barcode design interface         }
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


unit rpmdfbarcodeint;

interface

{$I rpconf.inc}

uses SysUtils, Classes,rpmunits,types,
 QGraphics, QForms,Qt,
 QButtons, QExtCtrls, QControls, QStdCtrls,
  rpprintitem,rpmdbarcode,rpmdobinsint,rpmdconsts,
  rpgraphutils,rptypes;

type
 TRpBarcodeInterface=class(TRpSizePosInterface)
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


constructor TRpBarcodeInterface.Create(AOwner:TComponent;pritem:TRpCommonComponent);
begin
 if Not (pritem is TRpBarcode) then
  Raise Exception.Create(SRpIncorrectComponentForInterface);
 inherited Create(AOwner,pritem);
end;

class procedure TRpBarcodeInterface.FillAncestors(alist:TStrings);
begin
 inherited FillAncestors(alist);
 alist.Add('TRpBarcodeInterface');
end;

procedure TRpBarcodeInterface.GetProperties(lnames,ltypes,lvalues,lhints,lcat:TRpWideStrings);
begin
 inherited GetProperties(lnames,ltypes,lvalues,lhints,lcat);

 // Barcode Type
 lnames.Add(SRpSBarcodeType);
 ltypes.Add(SRpSList);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(BarcodeTypeStrings[TRpBarcode(printitem).Typ]);

 // Checksum
 lnames.Add(SRpSChecksum);
 ltypes.Add(SRpSBool);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpBarcode(printitem).CheckSum,True));
 // Modul
 lnames.Add(SrpSModul);
 ltypes.Add(SRpSCurrency);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(gettextfromtwips(TRpBarcode(printitem).Modul));
 // Ratio
 lnames.Add(SrpSRatio);
 ltypes.Add(SRpSCurrency);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(FormatCurr('#####0.00',TRpBarcode(printitem).Ratio));

 // Expression
 lnames.Add(SrpSExpression);
 ltypes.Add(SRpSExpression);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(TRpBarcode(printitem).Expression);

 // Display format
 lnames.Add(SrpSDisplayFOrmat);
 ltypes.Add(SRpSString);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(TRpBarcode(printitem).DisplayFormat);
 // Rotation in degrees
 lnames.Add(SRpSRotation);
 ltypes.Add(SrpSList);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(FormatCurr('#####0.0',TRpBarcode(printitem).Rotation/10));
 // Brush Color
 lnames.Add(SrpSColor);
 ltypes.Add(SRpSColor);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpBarcode(printitem).BColor));


 // ECC Check
 lnames.Add(SRpECCLevel);
 ltypes.Add(SRpSList);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(ECCToString(TRpBarcode(printitem).ECCLevel));
 // Num rows
 lnames.Add(SRpNumRows);
 ltypes.Add(SRpInteger);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpBarcode(printitem).NumRows));

 // Num cols
 lnames.Add(SRpNumCols);
 ltypes.Add(SRpInteger);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(IntToStr(TRpBarcode(printitem).NumColumns));

 // Truncated
 lnames.Add(SRpTruncatedPDF417);
 ltypes.Add(SRpSBool);
 lhints.Add('refbarcode.html');
 lcat.Add(SRpBarcode);
 if Assigned(lvalues) then
  lvalues.Add(BoolToStr(TRpBarcode(printitem).Truncated,True));
end;

procedure TRpBarcodeInterface.SetProperty(pname:string;value:Widestring);
begin
 if pname=SRpSBarcodeType then
 begin
  TRpBarcode(fprintitem).Typ:=StringBarcodeToBarCodeType(value);
  invalidate;
  exit;
 end;
 if pname=SRpSCheckSum then
 begin
  TRpBarcode(fprintitem).Checksum:=StrToBool(value);
  invalidate;
  exit;
 end;
 if pname=SRpSModul then
 begin
  TRpBarcode(fprintitem).Modul:=gettwipsfromtext(value);
  invalidate;
  exit;
 end;
 if pname=SRpSRatio then
 begin
  TRpBarcode(fprintitem).Ratio:=StrToCurr(value);
  invalidate;
  exit;
 end;
 if pname=SRpSExpression then
 begin
  TRpBarcode(fprintitem).Expression:=value;
  invalidate;
  exit;
 end;
 if pname=SRpSDisplayFormat then
 begin
  TRpBarcode(fprintitem).DisplayFormat:=value;
  invalidate;
  exit;
 end;
 if pname=SRpSRotation then
 begin
  TRpBarcode(fprintitem).Rotation:=Round(StrToCurr(Value)*10);
  exit;
 end;
 if pname=SRpSColor then
 begin
  TRpBarcode(fprintitem).BColor:=StrToInt(Value);
  invalidate;
  exit;
 end;
 if pname=SRpTruncatedPDF417 then
 begin
  TRpBarcode(fprintitem).Truncated:=StrToBool(value);
  invalidate;
  exit;
 end;
 if pname=SRpNumCols then
 begin
  TRpBarcode(fprintitem).NumColumns:=StrToInt(value);
  invalidate;
  exit;
 end;
 if pname=SRpNumRows then
 begin
  TRpBarcode(fprintitem).NumRows:=StrToInt(value);
  invalidate;
  exit;
 end;
 if pname=SRpECCLevel then
 begin
  TRpBarcode(fprintitem).ECCLevel:=StringECCToInteger(value);
  invalidate;
  exit;
 end;
 inherited SetProperty(pname,value);
end;

function TRpBarcodeInterface.GetProperty(pname:string):Widestring;
begin
 Result:='';
 if pname=SrpSBarcodeType then
 begin
  Result:=BarcodeTypeStrings[TRpBarcode(printitem).Typ];
  exit;
 end;
 if pname=SrpSCheckSum then
 begin
  Result:=BoolToStr(TRpBarcode(printitem).CheckSum,true);
  exit;
 end;
 if pname=SrpSModul then
 begin
  Result:=gettextfromtwips(TRpBarcode(printitem).Modul);
  exit;
 end;
 if pname=SrpSRatio then
 begin
  Result:=FormatCurr('######0.00',TRpBarcode(printitem).Ratio);
  exit;
 end;
 if pname=SrpSExpression then
 begin
  Result:=TRpBarcode(printitem).Expression;
  exit;
 end;
 if pname=SrpSDisplayFormat then
 begin
  Result:=TRpBarcode(printitem).DisplayFormat;
  exit;
 end;
 if pname=SRpSRotation then
 begin
  Result:=FormatCurr('#####0.0',TRpBarcode(printitem).Rotation/10);
  exit;
 end;
 if pname=SrpSColor then
 begin
  Result:=IntToStr(TRpBarcode(printitem).BColor);
  exit;
 end;
 if pname=SRpTruncatedPDF417 then
 begin
  Result:=BoolToStr(TRpBarcode(printitem).Truncated,true);
  exit;
 end;
 if pname=SRpNumRows then
 begin
  Result:=IntToStr(TRpBarcode(printitem).NumRows);
  exit;
 end;
 if pname=SRpNumCols then
 begin
  Result:=IntToStr(TRpBarcode(printitem).NumColumns);
  exit;
 end;
 if pname=SRpECCLevel then
 begin
  Result:=ECCToString(TRpBarcode(printitem).ECCLevel);
  exit;
 end;
 Result:=inherited GetProperty(pname);
end;

procedure TRpBarcodeInterface.GetPropertyValues(pname:string;
 lpossiblevalues:TRpWideStrings);
var
 it:TRpBarCodeType;
begin
 if pname=SRpSBarcodeType then
 begin
  for it:=bcCode_2_5_interleaved to bcCodePDF417 do
  begin
   lpossiblevalues.Add(BarcodeTypeStrings[it]);
  end;
  exit;
 end;
 if pname=SRpSRotation then
 begin
  lpossiblevalues.Add(FormatCurr('##0.0',0));
  lpossiblevalues.Add(FormatCurr('##0.0',90));
  lpossiblevalues.Add(FormatCurr('##0.0',180));
  lpossiblevalues.Add(FormatCurr('##0.0',270));
  exit;
 end;
 if pname=SRpECCLevel then
 begin
  FillEccValues(lpossiblevalues);
  Exit;
 end;
 inherited GetPropertyValues(pname,lpossiblevalues);
end;


procedure TRpBarcodeInterface.Paint;
var
 aexp:TRpBarcode;
 rec:TRect;
begin
 aexp:=TRpBarcode(printitem);
 if csDestroying in aexp.ComponentState then
  exit;

 // Draws the text
 rec.Top:=0;
 rec.Left:=0;
 rec.Right:=Width-1;
 rec.Bottom:=Height-1;
// Canvas.TextRect(rec,0,0,aexp.Expression,0);
 Canvas.Brush.Style:=bsClear;
 Canvas.TextOut(0,0,aexp.Expression);
 Canvas.Pen.Color:=clBlack;
 Canvas.Pen.Style:=psDashDotDot;
 Canvas.Rectangle(0,0,Width,Height);
 DrawSelected;
end;


end.
