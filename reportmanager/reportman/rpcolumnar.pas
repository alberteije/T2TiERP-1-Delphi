unit rpcolumnar;

interface

uses SysUtils,Classes,rppdfdriver,rpreport,rpprintitem,rplabelitem,
{$IFNDEF USEVARIANTS}
 Windows,
{$ENDIF}
 rpmdconsts,rpsection,rpsubreport,rptypes,rpmetafile;

type
 TRpSectionInfo=class(TObject)
   Section:TRpSection;
   expressions:TStringList;
   captions:TStringList;
   sumarys:TStringList;
   widths:TStringList;
   sectionwidth:integer;
   leftposition:integer;
   constructor Create;
   destructor Destroy;override;
 end;

 TRpColumnar=class(TObject)
  private
   FReport:TRpReport;
   pdfdriver:TRpPDFDriver;
   sections:TStringList;
   procedure SetReport(avalue:TRpReport);
   function FindSection(sectionname:string):TRpSectionInfo;
   function CalcMaxWidth(aitem:TRpGenTextComponent):integer;
  public
   CutColumns:Boolean;
   constructor Create;
   destructor Destroy;override;
   procedure AddColumn(width:integer;expression:widestring;expformat:string;
    caption:widestring;captionformat:string;sumaryexpression:string;sumaryformat:string);
   property Report:TRpReport read FReport write SetReport;
  end;

implementation

constructor TRpSectionInfo.Create;
begin
  expressions:=TStringList.Create;
  captions:=TStringList.Create;
  sumarys:=TStringList.Create;
  widths:=TStringList.Create;
end;

destructor TRpSectionInfo.Destroy;
begin
  expressions.free;
  captions.free;
  sumarys.free;
  widths.free;

  inherited Destroy;
end;


procedure TRpColumnar.SetReport(avalue:TRpReport);
var
 i:integer;
begin
 FReport:=avalue;
 for i:=0 to sections.Count-1 do
 begin
  sections.Objects[i].free;
 end;
 sections.Clear;
end;

constructor TRpColumnar.Create;
begin
  sections:=TStringList.Create;
  pdfdriver:=TRpPDFDriver.Create;
end;

destructor TRpColumnar.Destroy;
begin
  sections.free;
  pdfdriver.free;

  inherited Destroy;
end;

function TRpColumnar.FindSection(sectionname:string):TRpSectionInfo;
var
 index,i:integer;
 subrep:TRpSubReport;
 compo:TRpCommonPosComponent;
begin
 if not Assigned(FReport) then
  Raise Exception.Create(SRptReportnotfound);
 index:=sections.IndexOf(sectionname);
 if (index>=0) then
 begin
  Result:=TrpSectionInfo(sections.Objects[index]);
  exit;
 end;
 Result:=nil;
 for index:=0 to FReport.SubReports.Count-1 do
 begin
  subrep:=FReport.SubReports.Items[index].SubReport;
  for i:=0 to subrep.Sections.Count-1 do
  begin
   if sectionname=subrep.Sections.Items[i].Section.Name then
   begin
    Result:=TRpSectionInfo.Create;
    Result.Section:=subrep.Sections.Items[i].Section;
   end;
  end;
 end;
 if not Assigned(Result) then
  Raise Exception.Create(SRpSectionNotFound+':'+sectionname);
 sections.AddObject(sectionname,Result);
 Result.sectionwidth:=Result.Section.Width;
 Result.leftposition:=0;
 for i:=0 to Result.Section.ReportComponents.Count-1 do
 begin
  compo:=TRpCommonPosComponent(REsult.Section.ReportComponents.Items[i].Component);
  if UpperCase(compo.PrintCondition)<>'FALSE' then
  begin
   if ((compo.PosX+compo.Width)>Result.leftPosition) then
   begin
    Result.leftPosition:=compo.PosX+compo.Width;
    Result.sectionwidth:=Result.Section.Width-Result.leftPosition;
   end;
  end;
 end;
end;

procedure CopyProperties(source:TRpExpression;destination:TRpExpression);
begin
 destination.PosX:=source.PosX;
 destination.PosY:=source.PosY;
 destination.Width:=source.Width;
 destination.Height:=source.Height;
 destination.WFontName:=source.WFontName;
 destination.LFontName:=source.LFontName;
 destination.FontSize:=source.FontSize;
 destination.FontRotation:=source.FontRotation;
 destination.FontStyle:=source.FontStyle;
 destination.PrintOnlyOne:=source.PrintOnlyOne;
 destination.Alignment:=source.Alignment;
 destination.VAlignment:=source.VAlignment;
 destination.DataType:=source.DataType;
 destination.WordWrap:=source.WordWrap;
 destination.WordBreak:=source.WordBreak;
 destination.Type1Font:=source.Type1Font;
 destination.FontColor:=source.FontColor;
 destination.BackColor:=source.BackColor;
 destination.SingleLine:=source.SingleLine;
 destination.MultiPage:=source.MultiPage;
 destination.PrintStep:=source.PrintStep;
 destination.Transparent:=source.Transparent;
 destination.CutTexT:=source.CutText;

 destination.DisplayFormat:=source.DisplayFormat;
 destination.PrintNulls:=source.PrintNulls;
 destination.AgIniValue:=source.AgIniValue;
 destination.AgType:=source.AgType;
 destination.Aggregate:=source.Aggregate;
 destination.GroupName:=source.GroupName;
end;

procedure CopyPropertiesLabel(source:TRpLabel;destination:TRpLabel);
begin
 destination.PosX:=source.PosX;
 destination.PosY:=source.PosY;
 destination.Width:=source.Width;
 destination.Height:=source.Height;
 destination.WFontName:=source.WFontName;
 destination.LFontName:=source.LFontName;
 destination.FontSize:=source.FontSize;
 destination.FontRotation:=source.FontRotation;
 destination.FontStyle:=source.FontStyle;
 destination.Alignment:=source.Alignment;
 destination.VAlignment:=source.VAlignment;
 destination.WordWrap:=source.WordWrap;
 destination.WordBreak:=source.WordBreak;
 destination.Type1Font:=source.Type1Font;
 destination.FontColor:=source.FontColor;
 destination.BackColor:=source.BackColor;
 destination.SingleLine:=source.SingleLine;
 destination.MultiPage:=source.MultiPage;
 destination.PrintStep:=source.PrintStep;
 destination.Transparent:=source.Transparent;
 destination.CutTexT:=source.CutText;

end;

procedure CopyPropertiesExLabel(source:TRpExpression;destination:TRpLabel);
begin
 destination.PosX:=source.PosX;
 destination.PosY:=source.PosY;
 destination.Width:=source.Width;
 destination.Height:=source.Height;
 destination.WFontName:=source.WFontName;
 destination.LFontName:=source.LFontName;
 destination.FontSize:=source.FontSize;
 destination.FontRotation:=source.FontRotation;
 destination.FontStyle:=source.FontStyle;
 destination.Alignment:=source.Alignment;
 destination.VAlignment:=source.VAlignment;
 destination.WordWrap:=source.WordWrap;
 destination.WordBreak:=source.WordBreak;
 destination.Type1Font:=source.Type1Font;
 destination.FontColor:=source.FontColor;
 destination.BackColor:=source.BackColor;
 destination.SingleLine:=source.SingleLine;
 destination.MultiPage:=source.MultiPage;
 destination.PrintStep:=source.PrintStep;
 destination.Transparent:=source.Transparent;
 destination.CutTexT:=source.CutText;

end;

function TRpColumnar.CalcMaxWidth(aitem:TRpGenTextComponent):integer;
var
 aresult:TRpTextObject;
 aalign:Integer;
 apoint:TPoint;
begin
 aResult.Text:='M';
 aResult.LFontName:=aitem.LFontName;
 aResult.WFontName:=aitem.WFontName;
 aResult.FontSize:=aitem.FontSize;
 aResult.FontRotation:=aitem.FontRotation;
 aResult.FontStyle:=aitem.FontStyle;
 aResult.Type1Font:=integer(aitem.Type1Font);
 aResult.FontColor:=aitem.FontColor;
 aResult.CutText:=aitem.CutText;
 aalign:=aitem.PrintAlignment or aitem.VAlignment;
 if aitem.SingleLine then
  aalign:=aalign or AlignmentFlags_SingleLine;
 aResult.Alignment:=aalign;
 aResult.WordWrap:=aitem.WordWrap;
 aResult.RightToLeft:=aitem.RightToLeft;
 aResult.PrintStep:=aitem.PrintStep;

 pdfdriver.TextExtent(aresult,apoint);
 Result:=apoint.X;
end;


procedure RebuildPosition(secinfo:TRpSectionInfo;CutColumns:Boolean);
var
 compo:TRpCommonPosComponent;
 widthtotal:integer;
 i:integer;
 maxcolumn:integer;
 percent:double;
 posx,nwidth:integer;
begin
 percent:=1;
 widthtotal:=0;
 maxcolumn:=-1;
 for i:=0 to secinfo.expressions.Count-1 do
 begin
  widthtotal:=widthtotal+StrToInt(secinfo.widths.Strings[i]);
  if widthtotal<secinfo.sectionwidth then
  begin
   maxcolumn:=i;
  end;
 end;
 if widthtotal=0 then
  exit;
 if not cutcolumns then
 begin
  if maxcolumn<secinfo.expressions.Count-1 then
  begin
   maxcolumn:=secinfo.expressions.Count-1;
   percent:=secinfo.sectionwidth/widthtotal;
  end;
 end;
 posx:=secinfo.leftposition;
 for i:=0 to maxcolumn do
 begin
  compo:=TRpCommonPosComponent(secinfo.expressions.Objects[i]);
  compo.PrintCondition:='';
  compo.PosX:=posx;
  nwidth:=Round(StrToFloat(secinfo.widths.Strings[i])*percent);
  compo.Width:=nwidth;
  if Length(secinfo.Captions.Strings[i])>0 then
  begin
   compo:=TRpCommonPosComponent(secinfo.captions.Objects[i]);
   compo.PrintCondition:='';
   compo.PosX:=posx;
   compo.Width:=nwidth;
  end;
  if Length(secinfo.sumarys.Strings[i])>0 then
  begin
   compo:=TRpCommonPosComponent(secinfo.sumarys.Objects[i]);
   compo.PrintCondition:='';
   compo.PosX:=posx;
   compo.Width:=nwidth;
  end;
  posx:=posx+nwidth;
 end;
 for i:=maxcolumn+1 to secinfo.expressions.Count-1 do
 begin
  compo:=TRpCommonPosComponent(secinfo.expressions.Objects[i]);
  compo.PrintCondition:='False';
  if Length(secinfo.Captions.Strings[i])>0 then
  begin
   compo:=TRpCommonPosComponent(secinfo.captions.Objects[i]);
   compo.PrintCondition:='False';
  end;
  if Length(secinfo.sumarys.Strings[i])>0 then
  begin
   compo:=TRpCommonPosComponent(secinfo.sumarys.Objects[i]);
   compo.PrintCondition:='False';
  end;
 end;
end;

procedure TRpColumnar.AddColumn(width:integer;expression:widestring;expformat:string;
  caption:widestring;captionformat:string;sumaryexpression:string;sumaryformat:string);
var
 secinfo:TRpSectionInfo;
 expitem,sumitem:TRpExpression;
 fexitem:TRpExpression;
 litem:TRpLabel;
 flitem:TRpLabel;
 compo:TComponent;
 itemwidth:integer;
 parentsection:string;
 psection:TRpSection;
begin
 fexitem:=nil;
 if Length(expformat)>0 then
 begin
  compo:=FReport.FindComponent(expformat);
  if Assigned(compo) then
   if compo is TRpExpression then
    fexitem:=TRpExpression(compo);
  if fexitem=nil then
   Raise Exception.Create(SRpNotFound+':'+expformat);
 end;
 if Assigned(fexitem) then
 begin
  parentsection:=fexitem.GetParent.Name;
  secinfo:=FindSection(parentsection);
  expitem:=TrpExpression(secinfo.Section.AddComponent(TRpExpression));
  expitem.Expression:=expression;
  CopyProperties(fexitem,expitem);
 end
 else
 begin
  if Length(sumaryexpression)>0 then
   parentsection:=report.SubReports[0].SubReport.Sections[
    report.SubReports[0].SubReport.LastDetail++1].Section.Name
  else
   parentsection:=report.SubReports[0].SubReport.Sections[
    report.SubReports[0].SubReport.FirstDetail].Section.Name;
  secinfo:=FindSection(parentsection);
  expitem:=TrpExpression(secinfo.Section.AddComponent(TRpExpression));
  expitem.Expression:=expression;
 end;
 itemwidth:=CalcMaxWidth(expitem)*width;
 secinfo.expressions.AddObject(expitem.Name,expitem);
 secinfo.widths.Add(intToStr(itemwidth));
 if Length(caption)>0 then
 begin
  if (Length(captionformat)>0) then
  begin
   compo:=FReport.FindComponent(captionformat);
   if Assigned(compo) then
   begin
    if compo is TRpLabel then
    begin
     flitem:=TRpLabel(compo);
     psection:=TrpSection(flitem.GetParent);
     litem:=TrpLabel(psection.AddComponent(TRpLabel));
     litem.Text:=caption;
     CopyPropertiesLabel(flitem,litem);
     secinfo.captions.AddObject(litem.name,litem);
    end
    else
    if compo is TRpExpression then
    begin
     fexitem:=TRpExpression(compo);
     psection:=TrpSection(fexitem.GetParent);
     litem:=TrpLabel(psection.AddComponent(TRpLabel));
     litem.Text:=caption;
     CopyPropertiesExLabel(fexitem,litem);
     secinfo.captions.AddObject(litem.name,litem);
    end
    else
     Raise Exception.Create(SRpNotFound+':'+captionformat);
   end
   else
     Raise Exception.Create(SRpNotFound+':'+captionformat);
  end
  else
  begin
   psection:=report.SubReports[0].SubReport.Sections[report.SubReports[0].SubReport.FirstDetail-1].Section;
   litem:=TrpLabel(psection.AddComponent(TRpLabel));
   litem.Text:=caption;
   secinfo.captions.AddObject(litem.name,litem);
  end;
 end
 else
 begin
  secinfo.captions.Add('');
 end;
 if Length(sumaryexpression)>0 then
 begin
  fexitem:=nil;
  if (Length(sumaryformat)>0) then
  begin
   compo:=FReport.FindComponent(sumaryformat);
   if Assigned(compo) then
    if compo is TRpExpression then
     fexitem:=TRpExpression(compo);
   if fexitem=nil then
    Raise Exception.Create(SRpNotFound+':'+sumaryformat);
   psection:=TRpSection(fexitem.GetParent);
   expitem:=TrpExpression(psection.AddComponent(TRpExpression));
   expitem.Expression:=sumaryexpression;
   CopyProperties(fexitem,expitem);
   secinfo.sumarys.AddObject(expitem.Name,expitem);
  end
  else
  begin
   psection:=report.SubReports[0].SubReport.Sections[report.SubReports[0].SubReport.LastDetail+1].Section;
   sumitem:=TrpExpression(psection.AddComponent(TRpExpression));
   sumitem.Expression:=sumaryexpression;
   sumitem.GroupName:='TOTAL';
   CopyProperties(expitem,sumitem);
   sumitem.PosX:=expitem.PosX;
   sumitem.Aggregate:=rpAgGroup;
   sumitem.AgType:=rpagSum;
   secinfo.sumarys.AddObject(sumitem.Name,sumitem);
  end;
 end
 else
 begin
  secinfo.sumarys.Add('');
 end;
 // Rebuild column positions based on new information
 RebuildPosition(secinfo,CutColumns);
end;


end.
