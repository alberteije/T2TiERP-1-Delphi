{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpxmlstream                                     }
{       Streams properties                              }
{       common components of Report manager             }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2005 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpxmlstream;

{$I rpconf.inc}

interface

uses Classes,sysutils,rptypes,rpreport,rpdatainfo,rpsubreport,
 rpsection,rpparams,rpprintitem,rplabelitem,rpmdbarcode,rpmdchart,
{$IFDEF USEVARIANTS}
 Variants,
{$ENDIF}
 rpdrawitem,rpmdconsts,rpmdcharttypes;


const
 C_MAXDATAWIDTH=40;
 CRLF:AnsiString=''+#13+#10;
type
 TRpPropertytypes=(rppropinteger,rppropdouble,rppropdatetime,rppropstring,
  rppropwidestring,rppropstream);



function StringToRpString(astring:AnsiString):AnsiString;
function RpStringToString(rpstring:Ansistring):AnsiString;
function WStringToRpString(astring:WideString):AnsiString;
function RpStringToWString(rpstring:Ansistring):WideString;

procedure WritePropertyI(propname:Ansistring;propvalue:integer;stream:TStream);
procedure WritePropertyD(propname:Ansistring;propvalue:double;stream:TStream);
procedure WritePropertyBool(propname:Ansistring;propvalue:Boolean;stream:TStream);
procedure WritePropertyS(propname:Ansistring;propvalue:AnsiString;stream:TStream);
procedure WritePropertyW(propname:Ansistring;propvalue:WideString;stream:TStream);
procedure WritePropertyB(propname:Ansistring;propvalue:TStream;stream:TStream);
procedure WriteReportXML(areport:TComponent;Stream:TStream);
procedure ReadReportXML(areport:TComponent;Stream:TStream);
procedure ReadSectionXML(areport:TComponent;Stream:TStream);

procedure WriteDatabaseInfoXML(dbinfo:TRpDatabaseInfoItem;Stream:TStream);
procedure WriteDataInfoXML(dinfo:TRpDataInfoItem;Stream:TStream);
procedure WriteReportPropsXML(report:TRpReport;Stream:TStream);
procedure WriteParamXML(aparam:TRpParam;Stream:TStream);
procedure WriteSubreportXML(subrep:TRpSubReport;Stream:TStream);
procedure WriteSectionXML(section:TRpSection;Stream:TStream);
procedure WriteComponentXML(comp:TRpCommonPosComponent;Stream:TStream);

function RpIsAlpha(achar:Ansichar):Boolean;
function RpIsAlphaW(achar:Widechar):Boolean;

implementation

// Implement it based on FindNextName procedure
procedure ReadSectionXML(areport:TComponent;Stream:TStream);
begin

end;

function RpIsAlpha(achar:Ansichar):Boolean;
begin
 Result:=achar in ['0'..'9','A'..'Z','a'..'z','_',' ','.','(',')',
  '=',';',':'];
end;

function RpIsAlphaW(achar:Widechar):Boolean;
begin
 Result:=achar in [WideChar('0')..WideChar('9'),WideChar('_'),WideChar(' '),
  WideChar('.'),WideChar('('),WideChar(')'),
  WideChar('='),WideChar(';'),WideChar(':'),
  WideChar('A')..WideChar('Z'),WideChar('a')..WideChar('z')];
end;

procedure WriteDatabaseInfoXML(dbinfo:TRpDatabaseInfoItem;Stream:TStream);
begin
 WritePropertyS('ALIAS',dbinfo.Alias,Stream);
 WritePropertyS('CONFIGFILE',dbinfo.Configfile,Stream);
 WritePropertyBool('LOADPARAMS',dbinfo.LoadParams,Stream);
 WritePropertyBool('LOADDRIVERPARAMS',dbinfo.LoadDriverParams,Stream);
 WritePropertyBool('LOGINPROMPT',dbinfo.LoginPrompt,Stream);
 WritePropertyI('DRIVER',Integer(dbinfo.Driver),Stream);
 WritePropertyS('REPORTTABLE',dbinfo.ReportTable,Stream);
 WritePropertyS('REPORTSEARCHFIELD',dbinfo.ReportSearchField,Stream);
 WritePropertyS('REPORTFIELD',dbinfo.ReportField,Stream);
 WritePropertyS('REPORTGROUPSTABLE',dbinfo.ReportGroupsTable,Stream);
 WritePropertyW('ADOCONNECTIONSTRING',dbinfo.ADOConnectionString,Stream);
 WritePropertyI('DOTNETDRIVER',dbinfo.DotNetDriver,Stream);
 WritePropertyS('PROVIDERFACTORY',dbinfo.ProviderFactory,Stream);

end;

procedure WriteDataInfoXML(dinfo:TRpDataInfoItem;Stream:TStream);
begin
 WritePropertyS('ALIAS',dinfo.Alias,Stream);
 WritePropertyS('DATABASEALIAS',dinfo.DatabaseAlias,Stream);
 WritePropertyW('SQL',dinfo.SQL,Stream);
 WritePropertyS('DATASOURCE',dinfo.DataSource,Stream);
 WritePropertyS('MYBASEFILENAME',dinfo.MyBaseFileName,Stream);
 WritePropertyS('MYBASEFIELDS',dinfo.MyBaseFields,Stream);
 WritePropertyS('MYBASEINDEXFIELDS',dinfo.MyBaseIndexFields,Stream);
 WritePropertyS('MYBASEMASTERFIELDS',dinfo.MyBaseMasterFields,Stream);
 WritePropertyS('BDEINDEXFIELDS',dinfo.BDEIndexFields,Stream);
 WritePropertyS('BDEINDEXNAME',dinfo.BDEIndexName,Stream);
 WritePropertyS('BDETABLE',dinfo.BDETable,Stream);
 WritePropertyI('BDETYPE',Integer(dinfo.BDEType),Stream);
 WritePropertyS('BDEFILTER',dinfo.BDEFilter,Stream);
 WritePropertyS('BDEMASTERFIELDS',dinfo.BDEMasterFields,Stream);
 WritePropertyS('BDEFIRSTRANGE',dinfo.BDEFirstRange,Stream);
 WritePropertyS('BDELASTRANGE',dinfo.BDELastRange,Stream);
 WritePropertyS('DATAUNIONS',dinfo.DataUnions.Text,Stream);
 WritePropertyBool('GROUPUNION',dinfo.GroupUnion,Stream);
 WritePropertyBool('OPENONSTART',dinfo.OpenOnStart,Stream);
 WritePropertyBool('PARALLELUNION',dinfo.ParallelUnion,Stream);
end;

procedure WriteReportPropsXML(report:TRpReport;Stream:TStream);
begin
 WritePropertyW('WFONTNAME',report.WFontName,Stream);
 WritePropertyW('LFONTNAME',report.LFontName,Stream);
 WritePropertyBool('GRIDVISIBLE',report.GridVisible,Stream);
 WritePropertyBool('GRIDLINES',report.GridLines,Stream);
 WritePropertyBool('GRIDENABLED',report.GridEnabled,Stream);
 WritePropertyI('GRIDCOLOR',report.GridColor,Stream);
 WritePropertyI('GRIDWIDTH',report.GridWidth,Stream);
 WritePropertyI('GRIDHEIGHT',report.GridHeight,Stream);
 WritePropertyI('PAGEORIENTATION',Integer(report.PageOrientation),Stream);
 WritePropertyI('PAGESIZE',Integer(report.PageSize),Stream);
 WritePropertyI('PAGESIZEQT',report.PageSizeQt,Stream);
 WritePropertyI('PAGEHEIGHT',report.PageHeight,Stream);
 WritePropertyI('PAGEWIDTH',report.PageWidth,Stream);
 WritePropertyI('CUSTOMPAGEHEIGHT',report.CustomPageHeight,Stream);
 WritePropertyI('CUSTOMPAGEWIDTH',report.CustomPageWidth,Stream);
 WritePropertyI('PAGEBACKCOLOR',Integer(report.PageBackColor),Stream);
 WritePropertyI('PREVIEWSTYLE',Integer(report.PreviewStyle),Stream);
 WritePropertyBool('PREVIEWMARGINS',report.PreviewMargins,Stream);
 WritePropertyI('PREVIEWWINDOW',Integer(report.PreviewWindow),Stream);
 WritePropertyI('LEFTMARGIN',report.LeftMargin,Stream);
 WritePropertyI('TOPMARGIN',report.TopMargin,Stream);
 WritePropertyI('RIGHTMARGIN',report.RightMargin,Stream);
 WritePropertyI('BOTTOMMARGIN',report.BottomMargin,Stream);
 WritePropertyI('PRINTERSELECT',Integer(report.PrinterSelect),Stream);
 WritePropertyI('LANGUAGE',report.Language,Stream);
 WritePropertyI('COPIES',report.Copies,Stream);
 WritePropertyBool('COLLATECOPIES',report.CollateCopies,Stream);
 WritePropertyBool('TWOPASS',report.TwoPass,Stream);
 WritePropertyI('PRINTERFONTS',Integer(report.PrinterFonts),Stream);
 WritePropertyBool('PRINTONLYIFDATAAVAILABLE',report.PrintOnlyIfDataAvailable,Stream);
 WritePropertyI('STREAMFORMAT',Integer(report.StreamFormat),Stream);
 WritePropertyBool('REPORTACTIONDRAWERBEFORE',rpDrawerBefore in report.ReportAction,Stream);
 WritePropertyBool('REPORTACTIONDRAWERAFTER',rpDrawerAfter in report.ReportAction,Stream);
 WritePropertyBool('PREVIEWABOUT',report.PreviewAbout,Stream);
 WritePropertyI('TYPE1FONT',Integer(report.Type1Font),Stream);
 WritePropertyI('FONTSIZE',report.FontSize,Stream);
 WritePropertyI('FONTROTATION',report.FontRotation,Stream);
 WritePropertyI('FONTSTYLE',report.FontStyle,Stream);
 WritePropertyI('FONTCOLOR',report.FontColor,Stream);
 WritePropertyI('BACKCOLOR',report.BackColor,Stream);
 WritePropertyBool('TRANSPARENT',report.Transparent,Stream);
 WritePropertyBool('CUTTEXT',report.CutText,Stream);
 WritePropertyI('ALIGNMENT',report.Alignment,Stream);
 WritePropertyI('VALIGNMENT',report.VAlignment,Stream);
 WritePropertyBool('WORDWRAP',report.WordWrap,Stream);
 WritePropertyBool('SINGLELINE',report.SingleLine,Stream);
 WritePropertyS('BIDIMODES',report.BidiModes.Text,Stream);
 WritePropertyBool('MULTIPAGE',report.MultiPage,Stream);
 WritePropertyI('PRINTSTEP',Integer(report.PrintStep),Stream);
 WritePropertyI('PAPERSOURCE',report.PaperSource,Stream);
 WritePropertyI('DUPLEX',report.duplex,Stream);
 WritePropertyS('FORCEPAPERNAME',report.ForcePaperName,Stream);
 WritePropertyI('LINESPERINCH',report.LinesPerInch,Stream);
end;

procedure WriteParamXML(aparam:TRpParam;Stream:TStream);
begin
 WritePropertyS('NAME',aparam.Name,Stream);
 WritePropertyW('DESCRIPTION',aparam.Descriptions,Stream);
 WritePropertyW('HINT',aparam.Hints,Stream);
 WritePropertyW('ERRORMESSAGE',aparam.ErrorMessage,Stream);
 WritePropertyW('VALIDATION',aparam.Validation,Stream);
 WritePropertyW('SEARCH',aparam.Search,Stream);
 WritePropertyBool('VISIBLE',aparam.Visible,Stream);
 WritePropertyBool('ISREADONLY',aparam.IsReadOnly,Stream);
 WritePropertyBool('NEVERVISIBLE',aparam.NeverVisible,Stream);
 WritePropertyBool('ALLOWNULLS',aparam.AllowNulls,Stream);
 WritePropertyI('PARAMTYPE',Integer(aparam.ParamType),Stream);
 WritePropertyS('DATASETS',aparam.Datasets.Text,Stream);
 WritePropertyS('ITEMS',aparam.Items.Text,Stream);
 WritePropertyS('VALUES',aparam.Values.Text,Stream);
 WritePropertyS('SELECTED',aparam.Selected.Text,Stream);
 WritePropertyS('LOOKUPDATASET',aparam.LookupDataset,Stream);
 WritePropertyS('SEARCHDATASET',aparam.SearchDataset,Stream);
 WritePropertyS('SEARCHPARAM',aparam.Searchparam,Stream);

 if (aparam.Value<>Null) then
 begin
  case aparam.ParamType of
   rpParamString,rpParamExpreA,rpParamExpreB,rpParamSubst,rpParamList,rpParamSubstList,rpParamInitialExpression,rpParamUnknown:
    WritePropertyS('VALUE',aparam.Value,Stream);
   rpParamInteger:
    begin
     WritePropertyI('VALUE',aparam.Value,Stream);
    end;
   rpParamDouble:
    begin
     WritePropertyD('VALUE',aparam.Value,Stream);
    end;
   rpParamCurrency:
    begin
     WritePropertyD('VALUE',aparam.Value,Stream);
    end;
   rpParamDate,rpParamTime,rpParamDateTime:
    WritePropertyD('VALUE',double(aparam.Value),Stream);
   rpParamBool:
    WritePropertyBool('VALUE',aparam.Value,Stream);
  end;
 end;
end;

procedure WriteSubreportXML(subrep:TRpSubReport;Stream:TStream);
begin
 WritePropertyS('NAME',subrep.Name,Stream);
 WritePropertyS('ALIAS',subrep.Alias,Stream);
 if assigned(subrep.ParentSubReport) then
 begin
  WritePropertyS('PARENTSUBREPORT',subrep.ParentSubReport.Name,Stream);
 end;
 if assigned(subrep.ParentSection) then
 begin
  WritePropertyS('PARENTSECTION',subrep.ParentSection.Name,Stream);
 end;
 WritePropertyBool('PRINTONLYIFDATAAVAILABLE',subrep.PrintOnlyIfDataAvailable,Stream);
 WritePropertyBool('REOPENONPRINT',subrep.ReOpenOnPrint,Stream);
end;

procedure WriteSectionXML(section:TRpSection;Stream:TStream);
var
 i:integer;
 aitem:TRpCommonPosComponent;
begin
 WriteStringToStream('<SECTION>'+CRLF,Stream);

 WritePropertyS('NAME',section.Name,Stream);
 WritePropertyI('WIDTH',section.Width,Stream);
 WritePropertyI('HEIGHT',section.height,Stream);
 WritePropertyW('PRINTCONDITION',section.PrintCondition,Stream);
 WritePropertyW('DOBEFOREPRINT',section.DoBeforePrint,Stream);
 WritePropertyW('DOAFTERPRINT',section.DoAfterPrint,Stream);
 if assigned(section.SubReport) then
 begin
  WritePropertyS('SUBREPORT',section.Subreport.Name,Stream);
 end;
 WritePropertyS('GROUPNAME',section.GroupName,Stream);
 WritePropertyW('CHANGEEXPRESSION',section.ChangeExpression,Stream);
 WritePropertyW('BEGINPAGEEXPRESSION',section.BeginPageExpression,Stream);
 WritePropertyW('SKIPEXPREV',section.SkipExpreV,Stream);
 WritePropertyW('SKIPEXPREH',section.SkipExpreH,Stream);
 WritePropertyW('SKIPTOPAGEEXPRE',section.SkipToPageExpre,Stream);
 WritePropertyW('BACKEXPRESSION',section.BackExpression,Stream);
 WritePropertyBool('CHANGEBOOL',section.ChangeBool,Stream);
 WritePropertyBool('PAGEREPEAT',section.PageRepeat,Stream);
 WritePropertyBool('FORCEPRINT',section.FooterAtReportEnd,Stream);
 WritePropertyBool('SKIPPAGE',section.SkipPage,Stream);
 WritePropertyBool('ALIGNBOTTOM',section.AlignBottom,Stream);
 WritePropertyI('SECTIONTYPE',Integer(section.SectionType),Stream);
 WritePropertyBool('AUTOEXPAND',section.AutoExpand,Stream);
 WritePropertyBool('AUTOCONTRACT',section.AutoContract,Stream);
 WritePropertyBool('HORZDESP',section.HorzDesp,Stream);
 WritePropertyBool('VERTDESP',section.VertDesp,Stream);
 WritePropertyS('EXTERNALFILENAME',section.ExternalFilename,Stream);
 WritePropertyS('EXTERNALCONNECTION',section.ExternalConnection,Stream);
 WritePropertyS('EXTERNALTABLE',section.ExternalTable,Stream);
 WritePropertyS('EXTERNALFIELD',section.ExternalField,Stream);
 WritePropertyS('EXTERNALSEARCHFIELD',section.ExternalSearchField,Stream);
 WritePropertyS('EXTERNALSEARCHVALUE',section.ExternalSearchValue,Stream);
 WritePropertyI('STREAMFORMAT',Integer(section.StreamFormat),Stream);
 if assigned(section.ChildSubReport) then
 begin
  WritePropertyS('CHILDSUBREPORT',section.ChildSubreport.Name,Stream);
 end;
 WritePropertyBool('SKIPRELATIVEH',section.SkipRelativeH,Stream);
 WritePropertyBool('SKIPRELATIVEV',section.SkipRelativeV,Stream);
 WritePropertyI('SKIPTYPE',Integer(section.SkipType),Stream);
 WritePropertyBool('ININUMPAGE',section.IniNumPage,Stream);
 WritePropertyBool('GLOBAL',section.Global,Stream);
 WritePropertyI('DPIRES',section.dpires,Stream);
 WritePropertyI('CACHEDIMAGE',Integer(section.CachedImage),Stream);
 WritePropertyI('BACKSTYLE',Integer(section.BackStyle),Stream);
 WritePropertyI('DRAWSTYLE',Integer(section.DrawStyle),Stream);
 if assigned(section.Stream) then
 begin
  if section.Stream.Size>0 then
  begin
   section.Stream.Seek(0,soFromBeginning);
   WritePropertyB('STREAM',section.Stream,Stream);
  end;
 end;


 for i:=0 to section.ReportComponents.Count-1 do
 begin
  aitem:=TRpCommonPosComponent(section.ReportComponents.Items[i].Component);
  WriteComponentXML(aitem,Stream);
 end;
 WriteStringToStream('</SECTION>'+CRLF,Stream);
end;

procedure WriteComponentXML(comp:TRpCommonPosComponent;Stream:TStream);
var
 compt:TRpGenTextComponent;
 compl:TRpLabel;
 comps:TRpShape;
 compi:TRpImage;
 compe:TRpExpression;
 compb:TRpBarCode;
 compc:TRpChart;
begin
 WriteStringToStream('<COMPONENT>'+CRLF,Stream);

 WritePropertyS('NAME',comp.Name,Stream);
 WritePropertyS('CLASSNAME',UpperCase(comp.ClassName),Stream);
 WritePropertyI('WIDTH',comp.Width,Stream);
 WritePropertyI('HEIGHT',comp.height,Stream);
 WritePropertyW('PRINTCONDITION',comp.PrintCondition,Stream);
 WritePropertyW('DOBEFOREPRINT',comp.DoBeforePrint,Stream);
 WritePropertyW('DOAFTERPRINT',comp.DoAfterPrint,Stream);
 // CommonPos
 WritePropertyI('POSX',comp.PosX,Stream);
 WritePropertyI('POSY',comp.PosY,Stream);
 WritePropertyI('ALIGN',Integer(comp.Align),Stream);
 // Common text component
 if comp is TRpGenTextComponent then
 begin
  compt:=TRpGenTextComponent(comp);
  WritePropertyW('WFONTNAME',compt.WFontName,Stream);
  WritePropertyW('LFONTNAME',compt.LFontName,Stream);
  WritePropertyI('BIDIMODE',Integer(compt.BidiMode),Stream);
  WritePropertyI('TYPE1FONT',Integer(compt.Type1Font),Stream);
  WritePropertyI('FONTSIZE',compt.FontSize,Stream);
  WritePropertyI('FONTROTATION',compt.FontRotation,Stream);
  WritePropertyI('FONTSTYLE',compt.FontStyle,Stream);
  WritePropertyI('FONTCOLOR',compt.FontColor,Stream);
  WritePropertyI('BACKCOLOR',compt.BackColor,Stream);
  WritePropertyBool('TRANSPARENT',compt.Transparent,Stream);
  WritePropertyBool('CUTTEXT',compt.CutText,Stream);
  WritePropertyI('ALIGNMENT',compt.Alignment,Stream);
  WritePropertyI('VALIGNMENT',compt.VAlignment,Stream);
  WritePropertyI('INTERLINE',compt.InterLine,Stream);
  WritePropertyBool('WORDWRAP',compt.WordWrap,Stream);
  WritePropertyBool('WORDBREAK',compt.WordBreak,Stream);
  WritePropertyBool('SINGLELINE',compt.SingleLine,Stream);
  WritePropertyS('BIDIMODES',compt.BidiModes.Text,Stream);
  WritePropertyBool('MULTIPAGE',compt.Multipage,Stream);
  WritePropertyI('PRINTSTEP',Integer(compt.PrintStep),Stream);
 end;
 // TRpLabel
 if comp is TRpLabel then
 begin
  compl:=TRpLabel(comp);
  compl.UpdateWideText;
  WritePropertyW('WIDETEXT',compl.WideText,Stream);
 end
 else
 // TRpExpression
 if comp is TRpExpression then
 begin
  compe:=TRpExpression(comp);

  WritePropertyW('EXPRESSION',compe.Expression,Stream);
  WritePropertyW('AGINIVALUE',compe.AgIniValue,Stream);
  WritePropertyW('EXPORTEXPRESSION',compe.ExportExpression,Stream);
  WritePropertyI('DATATYPE',Integer(compe.DataType),Stream);
  WritePropertyW('DISPLAYFORMAT',compe.DisplayFormat,Stream);
  WritePropertyS('IDENTIFIER',compe.Identifier,Stream);
  WritePropertyI('AGGREGATE',Integer(compe.Aggregate),Stream);
  WritePropertyS('GROUPNAME',compe.GroupName,Stream);
  WritePropertyI('AGTYPE',Integer(compe.AgType),Stream);
  WritePropertyBool('AUTOEXPAND',compe.AutoExpand,Stream);
  WritePropertyBool('AUTOCONTRACT',compe.AutoContract,Stream);
  WritePropertyBool('PRINTONLYONE',compe.PrintOnlyOne,Stream);
  WritePropertyBool('PRINTNULLS',compe.PrintNulls,Stream);
  WritePropertyW('EXPORTDISPLAYFORMAT',compe.ExportDisplayFormat,Stream);
  WritePropertyI('EXPORTLINE',compe.ExportLine,Stream);
  WritePropertyI('EXPORTPOSITION',compe.ExportPosition,Stream);
  WritePropertyI('EXPORTSIZE',compe.ExportSize,Stream);
  WritePropertyBool('EXPORTDONEWLINE',compe.ExportDoNewLine,Stream);
 end
 else
 // TRpShape
 if comp is TRpShape then
 begin
  comps:=TRpShape(comp);
  WritePropertyI('SHAPE',Integer(comps.Shape),Stream);
  WritePropertyI('BRUSHSTYLE',comps.BrushStyle,Stream);
  WritePropertyI('BRUSHCOLOR',comps.BrushColor,Stream);
  WritePropertyI('PENSTYLE',comps.PenStyle,Stream);
  WritePropertyI('PENCOLOR',comps.PenColor,Stream);
  WritePropertyI('PENWIDTH',comps.PenWidth,Stream);
 end
 else
 // TRpImage
 if comp is TRpImage then
 begin
  compi:=TRpImage(comp);
  WritePropertyW('EXPRESSION',compi.Expression,Stream);
  if assigned(compi.Stream) then
  begin
   if compi.Stream.Size>0 then
   begin
    compi.Stream.Seek(0,soFromBeginning);
    WritePropertyB('STREAM',compi.Stream,Stream);
   end;
  end;
  WritePropertyI('ROTATION',compi.Rotation,Stream);
  WritePropertyI('DRAWSTYLE',Integer(compi.DrawStyle),Stream);
  WritePropertyI('DPIRES',compi.dpires,Stream);
  WritePropertyI('COPYMODE',compi.CopyMode,Stream);
  WritePropertyI('CACHEDIMAGE',Integer(compi.CachedImage),Stream);
 end
 else
 // TRpChart
 if comp is TRpChart then
 begin
  compc:=TRpChart(comp);
  WritePropertyW('VALUEEXPRESSION',compc.ValueExpression,Stream);
  WritePropertyW('GETVALUECONDITION',compc.GetValueCondition,Stream);
  WritePropertyW('CHANGESERIEEXPRESSION',compc.ChangeSerieExpression,Stream);
  WritePropertyW('CAPTIONEXPRESSION',compc.CaptionExpression,Stream);
  WritePropertyW('COLOREXPRESSION',compc.ColorExpression,Stream);
  WritePropertyW('SERIECOLOREXPRESSION',compc.SerieColorExpression,Stream);
  WritePropertyW('SERIECAPTION',compc.SerieCaption,Stream);
  WritePropertyW('CLEAREXPRESSION',compc.ClearExpression,Stream);
//  WritePropertyI('SERIES',Integer(compc.Series),Stream);
  WritePropertyBool('CHANGESERIEBOOL',compc.ChangeSerieBool,Stream);
  WritePropertyI('CHARTTYPE',Integer(compc.ChartType),Stream);
  WritePropertyW('IDENTIFIER',compc.Identifier,Stream);
  WritePropertyBool('CLEAREXPRESSIONBOOL',compc.ClearExpressionBool,Stream);
  WritePropertyI('DRIVER',Integer(compc.Driver),Stream);
  WritePropertyBool('VIEW3D',compc.View3d,Stream);
  WritePropertyBool('VIEW3DWALLS',compc.View3dWalls,Stream);
  WritePropertyI('PERSPECTIVE',compc.Perspective,Stream);
  WritePropertyI('ELEVATION',compc.Elevation,Stream);
  WritePropertyI('ROTATION',compc.Rotation,Stream);
  WritePropertyI('ZOOM',compc.Rotation,Stream);
  WritePropertyI('HORZOFFSET',compc.HorzOffset,Stream);
  WritePropertyI('VERTOFFSET',compc.VertOffset,Stream);
  WritePropertyI('TILT',compc.Tilt,Stream);
  WritePropertyBool('ORTHOGONAL',compc.Orthogonal,Stream);
  WritePropertyI('MULTIBAR',Integer(compc.Multibar),Stream);
  WritePropertyI('RESOLUTION',compc.Resolution,Stream);
  WritePropertyBool('SHOWLEGEND',compc.ShowLegend,Stream);
  WritePropertyBool('SHOWHINT',compc.ShowHint,Stream);
  WritePropertyI('MARKSTYLE',compc.MarkStyle,Stream);
  WritePropertyI('HORZFONTSIZE',compc.HorzFontSize,Stream);
  WritePropertyI('VERTFONTSIZE',compc.VertFontSize,Stream);
  WritePropertyI('HORZFONTROTATION',compc.HorzFontRotation,Stream);
  WritePropertyI('VERTFONTROTATION',compc.VertFontRotation,Stream);
 end
 else
 // TRpBarcode
 if comp is TRpBarcode then
 begin
  compb:=TRpBarcode(comp);
  WritePropertyW('EXPRESSION',compb.Expression,Stream);
  WritePropertyI('MODUL',compb.Modul,Stream);
  WritePropertyD('RATIO',compb.Ratio,Stream);
  WritePropertyI('TYP',Integer(compb.Typ),Stream);
  WritePropertyBool('CHECKSUM',compb.CheckSum,Stream);
  WritePropertyW('DISPLAYFORMAT',compb.DisplayFormat,Stream);
  WritePropertyI('ROTATION',compb.Rotation,Stream);
  WritePropertyI('BCOLOR',compb.BColor,Stream);
  WritePropertyI('NUMCOLUMNS',compb.NumCOlumns,Stream);
  WritePropertyI('NUMROWS',compb.NumRows,Stream);
  WritePropertyI('ECCLEVEL',compb.ECCLevel,Stream);
  WritePropertyBool('TRUNCATED',compb.Truncated,Stream);
 end;
 WriteStringToStream('</COMPONENT>'+CRLF,Stream);
end;


function StringToRpString(astring:AnsiString):AnsiString;
var
 i:integer;
 alen:integer;
 asubs:AnsiString;
begin
 Result:='';
 alen:=0;
 for i:=1 to Length(astring) do
 begin
  if RpIsAlpha(astring[i]) then
  begin
   Result:=Result+astring[i];
   inc(alen);
   if (alen > C_MAXDATAWIDTH) then
   begin
    alen:=0;
    Result:=Result+CRLF;
   end;
  end
  else
  begin
   asubs:='#'+IntToStr(Ord(astring[i]))+'#';
   Result:=Result+asubs;
   alen:=alen+Length(asubs);
   if (alen > C_MAXDATAWIDTH) then
   begin
    alen:=0;
    Result:=Result+CRLF;
   end;
  end;
 end;
end;

function WStringToRpString(astring:WideString):AnsiString;
var
 i,alen:integer;
 subs:AnsiString;
begin
 Result:='';
 alen:=0;
 for i:=1 to Length(astring) do
 begin
  if RpIsAlphaW(astring[i]) then
  begin
   Result:=Result+astring[i];
   inc(alen);
   if (alen >C_MAXDATAWIDTH) then
   begin
    alen:=0;
    Result:=Result+CRLF;
   end;
  end
  else
  begin
   subs:='#'+IntToStr(Ord(astring[i]))+'#';
   Result:=Result+subs;
   alen:=alen+Length(subs);
   if (alen > C_MAXDATAWIDTH) then
   begin
    alen:=0;
    Result:=Result+CRLF;
   end;
  end;
 end;
end;

function RpStringToString(rpstring:Ansistring):AnsiString;
var
 anumber:Ansistring;
 i:integer;
begin
 Result:='';
 i:=1;
 while (i<=Length(rpstring)) do
 begin
  if ((RpIsAlpha(rpstring[i])) or (rpstring[i]='#')) then
  begin
    if rpstring[i]='#' then
    begin
     anumber:='0';
     inc(i);
     while (i<=Length(rpstring)) do
     begin
      if rpstring[i]='#' then
      begin
       inc(i);
       break;
      end
      else
      begin
       anumber:=anumber+rpstring[i];
       inc(i);
      end;
     end;
     Result:=Result+Chr(StrToInt(anumber) mod 256);
    end
    else
    begin
     Result:=Result+rpstring[i];
     inc(i);
    end;
  end
  else
   inc(i);
 end;
end;

function RpStringToWString(rpstring:Ansistring):WideString;
var
 anumber:Ansistring;
 i:integer;
begin
 Result:='';
 i:=1;
 while (i<=Length(rpstring)) do
 begin
  if ((RpIsAlpha(rpstring[i])) or (rpstring[i]='#')) then
  begin
    if rpstring[i]='#' then
    begin
     anumber:='0';
     inc(i);
     while (i<=Length(rpstring)) do
     begin
      if rpstring[i]='#' then
      begin
       inc(i);
       break;
      end
      else
      begin
       anumber:=anumber+rpstring[i];
       inc(i);
      end;
     end;
     Result:=Result+WideChar(StrToInt(anumber) mod 65535);
    end
    else
    begin
     Result:=Result+WideChar(rpstring[i]);
     inc(i);
    end;
  end
  else
   inc(i);
 end;
end;

procedure WritePropertyI(propname:Ansistring;propvalue:integer;stream:TStream);
var
 astring:Ansistring;
begin
 astring:='<'+propname+' type="Integer">'+IntToStr(propvalue)+'</'+propname+'>'+CRLF;
 WriteStringToStream(astring,stream);
end;

function RpDoubleToStr(avalue:double):Ansistring;
var
 olddec:char;
begin
 olddec:=DecimalSeparator;
 try
  DecimalSeparator:='.';
  Result:=FloatToStr(avalue);
 finally
  DecimalSeparator:=olddec;
 end;
end;


function RpStrToDouble(avalue:Ansistring):double;
var
 olddec:char;
begin
 olddec:=DecimalSeparator;
 try
  DecimalSeparator:='.';
  Result:=StrToFloat(avalue);
 finally
  DecimalSeparator:=olddec;
 end;
end;

procedure WritePropertyD(propname:Ansistring;propvalue:double;stream:TStream);
var
 astring:Ansistring;
begin
 astring:='<'+propname+' type="Double">'+RpDoubleToStr(propvalue)+'</'+propname+'>'+CRLF;
 WriteStringToStream(astring,stream);
end;


function RpBoolToStr(avalue:Boolean):AnsiString;
begin
 if avalue then
  Result:='True'
 else
  Result:='False';
end;

function RpStrToBool(avalue:AnsiString):Boolean;
begin
 if avalue='True' then
  Result:=True
 else
  Result:=False;
end;


procedure WritePropertyBool(propname:Ansistring;propvalue:Boolean;stream:TStream);
var
 astring:Ansistring;
begin
 astring:='<'+propname+' type="Boolean">'+RpBoolToStr(propvalue)+'</'+propname+'>'+CRLF;
 WriteStringToStream(astring,stream);
end;

procedure WritePropertyS(propname:Ansistring;propvalue:AnsiString;stream:TStream);
var
 astring:Ansistring;
begin
 astring:='<'+propname+' type="String">'+StringToRpString(propvalue)+'</'+propname+'>'+CRLF;
 WriteStringToStream(astring,stream);
end;

procedure WritePropertyW(propname:Ansistring;propvalue:WideString;stream:TStream);
var
 astring:Ansistring;
begin
 astring:='<'+propname+' type="WideString">'+WStringToRpString(propvalue)+'</'+propname+'>'+CRLF;
 WriteStringToStream(astring,stream);
end;


function StreamToBin(astream:TStream):AnsiString;
var
 abufsource,abufdest:PAnsiChar;
begin
 abufsource:=AllocMem(astream.Size);
 try
  astream.Read(abufsource^,astream.size);
  abufdest:=AllocMem(astream.size*2+1);
  try
   BinToHex(abufsource,abufdest,astream.size);
   Result:=StrPas(abufdest);
  finally
   FreeMem(abufdest);
  end;
 finally
  FreeMem(abufsource);
 end;
{ Result:='';
 alen:=0;
 while astream.Read(achar,1)>0 do
 begin
  Result:=Result+NibbleToHex(achar shr 4)+NibbleToHex(achar AND $0F);
  inc(alen);
  if (alen mod C_MAXDATAWIDTH)=0 then
  begin
   Result:=Result+CRLF;
   alen:=0;
  end;
 end;
}end;

procedure BinToStream(astream:TStream;bin2:Ansistring;propsize:Ansistring);
var
 alen:integer;
 abufdest:PAnsiCHar;
 readed:integer;
begin
 alen:=StrToInt(propsize);
 if alen=0 then
  exit;
 abufdest:=AllocMem(alen+1);
 try
  readed:=HexToBin(PAnsiChar(bin2),abufdest,alen);
  if readed<>alen then
   Raise Exception.Create('Expected: '+IntToStr(alen)+' Found: '
    +INtToStr(readed));
  astream.Write(abufdest^,alen);
  astream.Seek(0,soFromBeginning);
 finally
  FreeMem(abufdest);
 end;
end;


procedure WritePropertyB(propname:Ansistring;propvalue:TStream;stream:TStream);
var
 astring:Ansistring;
begin
 astring:='<'+propname+' type="Binary" size="'+IntTostr(propvalue.size)+'">'+StringToRpString(StreamToBin(propvalue))+'</'+propname+'>'+CRLF;
 WriteStringToStream(astring,stream);
end;

procedure WriteReportXML(areport:TComponent;Stream:TStream);
var
 report:TRpReport;
 i,j:integer;
 astring:Ansistring;
 asubrep:TRpSubReport;
 asec:TRpSection;
begin
 report:=TRpReport(areport);
 // Write header
 astring:='<?xml version="1.0" standalone="no"?>'+CRLF;
 WriteStringToStream(astring,stream);
 astring:='<!DOCTYPE REPORT_MANAGER_2>'+CRLF;
 WriteStringToStream(astring,stream);
 // Write XML Report properties
 astring:='<REPORT>'+CRLF;
 WriteStringToStream(astring,stream);
 WriteReportPropsXML(report,Stream);

 // Write database info list
 for i:=0 to report.databaseinfo.count-1 do
 begin
  astring:='<DATABASEINFO>'+CRLF;
  WriteStringToStream(astring,stream);
  WriteDatabaseInfoXML(report.databaseinfo.Items[i],Stream);
  astring:='</DATABASEINFO>'+CRLF;
  WriteStringToStream(astring,stream);
 end;
 // Write data info list
 for i:=0 to report.datainfo.count-1 do
 begin
  astring:='<DATAINFO>'+CRLF;
  WriteStringToStream(astring,stream);
  WriteDataInfoXML(report.datainfo.Items[i],Stream);
  astring:='</DATAINFO>'+CRLF;
  WriteStringToStream(astring,stream);
 end;
 // Write parameter list
 for i:=0 to report.Params.count-1 do
 begin
  astring:='<PARAMETER>'+CRLF;
  WriteStringToStream(astring,stream);
  WriteParamXML(report.params.Items[i],Stream);
  astring:='</PARAMETER>'+CRLF;
  WriteStringToStream(astring,stream);
 end;
 // Write SubReports
 for i:=0 to report.SubReports.Count-1 do
 begin
  asubrep:=report.SubReports.Items[i].SubReport;
  astring:='<SUBREPORT>'+CRLF;
  WriteStringToStream(astring,stream);
  WriteSubReportXML(asubrep,Stream);
  for j:=0 to asubrep.Sections.Count-1 do
  begin
   asec:=asubrep.Sections.Items[j].Section;
   WriteSectionXML(asec,Stream);
  end;
  astring:='</SUBREPORT>'+CRLF;
  WriteStringToStream(astring,stream);
 end;

 astring:='</REPORT>'+CRLF;
 WriteStringToStream(astring,stream);
end;

procedure ReadPropDBInfo(dbitem:TRpDatabaseInfoItem;
 propname,propvalue,proptype,propsize:Ansistring);
begin
 if propname='CONFIGFILE' then
  dbitem.Configfile:=RpStringToString(propvalue)
 else
 if propname='LOADPARAMS' then
  dbitem.LoadParams:=RpStrToBool(propvalue)
 else
 if propname='LOADDRIVERPARAMS' then
  dbitem.LoadDriverParams:=RpStrToBool(propvalue)
 else
 if propname='LOGINPROMPT' then
  dbitem.LoginPrompt:=RpStrToBool(propvalue)
 else
 if propname='DRIVER' then
  dbitem.Driver:=TRpDBDriver(StrToInt(propvalue))
 else
 if propname='DOTNETDRIVER' then
  dbitem.DotNetDriver:=StrToInt(propvalue)
 else
 if propname='PROVIDERFACTORY' then
  dbitem.ProviderFactory:=RpStringToString(propvalue)
 else
 if propname='REPORTTABLE' then
  dbitem.ReportTable:=RpStringToString(propvalue)
 else
 if propname='REPORTSEARCHFIELD' then
  dbitem.ReportSearchField:=RpStringToString(propvalue)
 else
 if propname='REPORTFIELD' then
  dbitem.ReportField:=RpStringToString(propvalue)
 else
 if propname='REPORTGROUPSTABLE' then
  dbitem.ReportGroupsTable:=RpStringToString(propvalue)
 else
 if propname='ADOCONNECTIONSTRING' then
  dbitem.ADOConnectionString:=RpStringToWString(propvalue);
end;

procedure ReadPropSubReport(subrep:TRpSubReport;
 propname,propvalue,proptype,propsize:Ansistring);
begin
 if propname='ALIAS' then
  subrep.Alias:=RpStringToString(propvalue)
 else
 if propname='PARENTSUBREPORT' then
  subrep.ParentSub:=RpStringToString(propvalue)
 else
 if propname='PARENTSECTION' then
  subrep.ParentSec:=RpStringToString(propvalue)
 else
 if propname='PRINTONLYIFDATAAVAILABLE' then
  subrep.PrintOnlyIfDataAvailable:=RpStrToBool(propvalue)
 else
 if propname='REOPENONPRINT' then
  subrep.ReOpenOnPrint:=RpStrToBool(propvalue);
end;

procedure ReadPropSection(sec:TRpSection;
 propname,propvalue,proptype,propsize:Ansistring);
var
  memstream:TMemoryStream;
begin
 if propname='CHANGEEXPRESSION' then
  sec.ChangeExpression:=RpStringToWString(propvalue)
 else
 if propname='BEGINPAGEEXPRESSION' then
  sec.BeginPageExpression:=RpStringToWString(propvalue)
 else
 if propname='SKIPEXPREV' then
  sec.SkipExpreV:=RpStringToWString(propvalue)
 else
 if propname='SKIPEXPREH' then
  sec.SkipExpreH:=RpStringToWString(propvalue)
 else
 if propname='SKIPTOPAGEEXPRE' then
  sec.SkipToPageExpre:=RpStringToWString(propvalue)
 else
 if propname='BACKEXPRESSION' then
  sec.BackExpression:=RpStringToWString(propvalue)
 else
 if propname='PRINTCONDITION' then
  sec.PrintCondition:=RpStringToWString(propvalue)
 else
 if propname='DOAFTERPRINT' then
  sec.DoAfterPrint:=RpStringToWString(propvalue)
 else
 if propname='DOBEFOREPRINT' then
  sec.DoBeforePrint:=RpStringToWString(propvalue)
 else
 if propname='WIDTH' then
  sec.Width:=StrToInt(propvalue)
 else
 if propname='HEIGHT' then
  sec.Height:=StrToInt(propvalue)
 else
 if propname='SUBREPORT' then
  sec.SubReportName:=RPStringToString(propvalue)
 else
 if propname='GROUPNAME' then
  sec.GroupName:=RPStringToString(propvalue)
 else
 if propname='CHANGEBOOL' then
  sec.ChangeBool:=RPStrToBool(propvalue)
 else
 if propname='PAGEREPEAT' then
  sec.PageRepeat:=RPStrToBool(propvalue)
 else
 if propname='FORCEPRINT' then
  sec.FooterAtReportEnd:=RPStrToBool(propvalue)
 else
 if propname='SKIPPAGE' then
  sec.SkipPage:=RPStrToBool(propvalue)
 else
 if propname='ALIGNBOTTOM' then
  sec.AlignBottom:=RPStrToBool(propvalue)
 else
 if propname='SECTIONTYPE' then
  sec.SectionType:=TRpSectionType(StrToInt(propvalue))
 else
 if propname='AUTOEXPAND' then
  sec.AutoExpand:=RPStrToBool(propvalue)
 else
 if propname='AUTOCONTRACT' then
  sec.AutoContract:=RPStrToBool(propvalue)
 else
 if propname='HORZDESP' then
  sec.HorzDesp:=RPStrToBool(propvalue)
 else
 if propname='VERTDESP' then
  sec.VertDesp:=RPStrToBool(propvalue)
 else
 if propname='EXTERNALFILENAME' then
  sec.ExternalFileName:=RPStringToString(propvalue)
 else
 if propname='EXTERNALCONNECTION' then
  sec.ExternalConnection:=RPStringToString(propvalue)
 else
 if propname='EXTERNALTABLE' then
  sec.ExternalTable:=RPStringToString(propvalue)
 else
 if propname='EXTERNALFIELD' then
  sec.ExternalField:=RPStringToString(propvalue)
 else
 if propname='EXTERNALSEARCHFIELD' then
  sec.ExternalSearchField:=RPStringToString(propvalue)
 else
 if propname='EXTERNALSEARCHVALUE' then
  sec.ExternalSearchValue:=RPStringToString(propvalue)
 else
 if propname='STREAMFORMAT' then
  sec.StreamFormat:=TRpStreamFormat(StrToInt(propvalue))
 else
 if propname='CHILDSUBREPORT' then
  sec.ChildSubReportName:=RPStringToString(propvalue)
 else
 if propname='SKIPRELATIVEH' then
  sec.SkipRelativeH:=RPStrToBool(propvalue)
 else
 if propname='SKIPRELATIVEV' then
  sec.SkipRelativeV:=RPStrToBool(propvalue)
 else
 if propname='SKIPTYPE' then
  sec.SkipType:=TRpSkipType(StrToInt(propvalue))
 else
 if propname='ININUMPAGE' then
  sec.IniNumPage:=RPStrToBool(propvalue)
 else
 if propname='GLOBAL' then
  sec.Global:=RPStrToBool(propvalue)
 else
 if propname='DPIRES' then
  sec.DPIRes:=StrToInt(propvalue)
 else
 if propname='CACHEDIMAGE' then
 begin
  if (propvalue<>'False') then
   sec.CachedImage:=TrpCachedImage(StrToInt(propvalue));
 end
 else
 if propname='BACKSTYLE' then
  sec.BackStyle:=TRpBackStyle(StrToInt(propvalue))
 else
 if propname='DRAWSTYLE' then
  sec.DrawStyle:=TRpImageDrawStyle(StrToInt(propvalue))
 else
 if propname='STREAM' then
 begin
  memstream:=TMemoryStream.Create;
  try
   BinToStream(memstream,RpStringToString(propvalue),propsize);
//    BinToStream(memstream,propvalue,propsize);
   memstream.Seek(0,soFromBeginning);
   sec.SetStream(memstream);
  finally
   memstream.free;
  end;
 end;
end;

procedure ReadPropDataInfo(ditem:TRpDataInfoItem;
 propname,propvalue,proptype,propsize:Ansistring);
begin
 if propname='DATABASEALIAS' then
  ditem.DataBaseAlias:=RpStringToString(propvalue)
 else
 if propname='SQL' then
  ditem.SQL:=RpStringToWString(propvalue)
 else
 if propname='DATASOURCE' then
  ditem.DataSource:=RpStringToString(propvalue)
 else
 if propname='MYBASEFILENAME' then
  ditem.MyBaseFileName:=RpStringToString(propvalue)
 else
 if propname='MYBASEFIELDS' then
  ditem.MyBaseFields:=RpStringToString(propvalue)
 else
 if propname='MYBASEINDEXFIELDS' then
  ditem.MyBaseIndexFields:=RpStringToString(propvalue)
 else
 if propname='MYBASEINDEXFIELDS' then
  ditem.MyBaseIndexFields:=RpStringToString(propvalue)
 else
 if propname='MYBASEMASTERFIELDS' then
  ditem.MyBaseMasterFields:=RpStringToString(propvalue)
 else
 if propname='BDEINDEXFIELDS' then
  ditem.BDEIndexFields:=RpStringToString(propvalue)
 else
 if propname='BDEINDEXNAME' then
  ditem.BDEIndexName:=RpStringToString(propvalue)
 else
 if propname='BDETABLE' then
  ditem.BDETable:=RpStringToString(propvalue)
 else
 if propname='BDETYPE' then
  ditem.BDEType:=TRpDatasetType(StrToInt(propvalue))
 else
 if propname='BDEFILTER' then
  ditem.BDEFilter:=RpStringToString(propvalue)
 else
 if propname='BDEMASTERFIELDS' then
  ditem.BDEMasterFields:=RpStringToString(propvalue)
 else
 if propname='BDEFIRSTRANGE' then
  ditem.BDEFirstRange:=RpStringToString(propvalue)
 else
 if propname='BDELASTRANGE' then
  ditem.BDELastRange:=RpStringToString(propvalue)
 else
 if propname='DATAUNIONS' then
  ditem.DataUnions.Text:=RpStringToString(propvalue)
 else
 if propname='GROUPUNION' then
  ditem.GroupUnion:=RpStrToBool(propvalue)
 else
 if propname='OPENONSTART' then
  ditem.OpenOnStart:=RpStrToBool(propvalue)
 else
 if propname='PARALLELUNION' then
  ditem.ParallelUnion:=RpStrToBool(propvalue);
end;

procedure ReadPropParam(aparam:TRpParam;
 propname,propvalue,proptype,propsize:Ansistring);
begin
 if propname='DESCRIPTION' then
  aparam.Descriptions:=RpStringToWString(propvalue)
 else
 if propname='HINT' then
  aparam.Hints:=RpStringToWString(propvalue)
 else
 if propname='ERRORMESSAGE' then
  aparam.ErrorMessages:=RpStringToWString(propvalue)
 else
 if propname='VALIDATION' then
  aparam.Validation:=RpStringToWString(propvalue)
 else
 if propname='SEARCH' then
  aparam.Search:=RpStringToWString(propvalue)
 else
 if propname='VISIBLE' then
  aparam.Visible:=RpStrToBool(propvalue)
 else
 if propname='ISREADONLY' then
  aparam.IsReadOnly:=RpStrToBool(propvalue)
 else
 if propname='NEVERVISIBLE' then
  aparam.NeverVisible:=RpStrToBool(propvalue)
 else
 if propname='ALLOWNULLS' then
  aparam.AllowNulls:=RpStrToBool(propvalue)
 else
 if propname='PARAMTYPE' then
  aparam.ParamType:=TrpPAramType(StrToInt(propvalue))
 else
 if propname='DATASETS' then
  aparam.Datasets.Text:=RpStringToString(propvalue)
 else
 if propname='ITEMS' then
  aparam.Items.Text:=RpStringToString(propvalue)
 else
 if propname='VALUES' then
  aparam.Values.Text:=RpStringToString(propvalue)
 else
 if propname='SELECTED' then
  aparam.Selected.Text:=RpStringToString(propvalue)
 else
 if propname='LOOKUPDATASET' then
  aparam.LookupDataset:=RpStringToString(propvalue)
 else
 if propname='SEARCHDATASET' then
  aparam.SearchDataset:=RpStringToString(propvalue)
 else
 if propname='SEARCHPARAM' then
  aparam.SearchParam:=RpStringToString(propvalue)
 else
 if propname='VALUE' then
 begin
  aparam.Value:=Null;
  case aparam.ParamType of
   rpParamString,rpParamExpreA,rpParamExpreB,rpParamSubst,rpParamList,rpParamUnknown:
    aparam.Value:=RpStringToString(propvalue);
   rpParamInteger:
    begin
     aparam.Value:=StrToInt(propvalue);
    end;
   rpParamDouble:
    begin
     aparam.Value:=RpStrToDouble(propvalue);
    end;
   rpParamCurrency:
    begin
     aparam.Value:=RpStrToDouble(propvalue);
    end;
   rpParamDate,rpParamTime,rpParamDateTime:
    aparam.Value:=TDateTime(RpStrToDouble(propvalue));
   rpParamBool:
    aparam.Value:=RpStrToBool(propvalue);
  end;
 end;
end;

procedure ReadPropReport(report:TRpReport;
 propname,propvalue,proptype,propsize:string);
var
 actions:TRpReportActions;
begin
 actions:=[];
 if propname='WFONTNAME' then
  report.WFontName:=RpStringToWString(propvalue)
 else
 if propname='LFONTNAME' then
  report.LFontName:=RpStringToWString(propvalue)
 else
 if propname='GRIDVISIBLE' then
  report.GridVisible:=RpStrToBool(propvalue)
 else
 if propname='GRIDLINES' then
  report.GridLines:=RpStrToBool(propvalue)
 else
 if propname='GRIDENABLED' then
  report.GridEnabled:=RpStrToBool(propvalue)
 else
 if propname='GRIDCOLOR' then
  report.GridColor:=StrToInt(propvalue)
 else
 if propname='GRIDWIDTH' then
  report.GridWidth:=StrToInt(propvalue)
 else
 if propname='GRIDHEIGHT' then
  report.GridHeight:=StrToInt(propvalue)
 else
 if propname='PAGEORIENTATION' then
  report.PageOrientation:=TrpOrientation(StrToInt(propvalue))
 else
 if propname='PAGESIZE' then
  report.PageSize:=TrpPageSize(StrToInt(propvalue))
 else
 if propname='PAGESIZEQT' then
  report.PageSizeQt:=StrToInt(propvalue)
 else
 if propname='PAGEHEIGHT' then
  report.PageHeight:=StrToInt(propvalue)
 else
 if propname='PAGEWIDTH' then
  report.PageWidth:=StrToInt(propvalue)
 else
 if propname='CUSTOMPAGEWIDTH' then
  report.CustomPageWidth:=StrToInt(propvalue)
 else
 if propname='CUSTOMPAGEHEIGHT' then
  report.CustomPageHeight:=StrToInt(propvalue)
 else
 if propname='PAGEBACKCOLOR' then
  report.PageBackColor:=StrToInt(propvalue)
 else
 if propname='PREVIEWSTYLE' then
  report.PreviewStyle:=TrpPreviewStyle(StrToInt(propvalue))
 else
 if propname='PREVIEWMARGINS' then
  report.PreviewMargins:=RpStrToBool(propvalue)
 else
 if propname='PREVIEWWINDOW' then
  report.PreviewWindow:=TrpPreviewWindowStyle(StrToInt(propvalue))
 else
 if propname='LEFTMARGIN' then
  report.LeftMargin:=StrToInt(propvalue)
 else
 if propname='TOPMARGIN' then
  report.TopMargin:=StrToInt(propvalue)
 else
 if propname='RIGHTMARGIN' then
  report.RightMargin:=StrToInt(propvalue)
 else
 if propname='BOTTOMMARGIN' then
  report.BottomMargin:=StrToInt(propvalue)
 else
 if propname='PRINTERSELECT' then
  report.PrinterSelect:=TrpPrinterSelect(StrToInt(propvalue))
 else
 if propname='LANGUAGE' then
  report.Language:=StrToInt(propvalue)
 else
 if propname='COPIES' then
  report.Copies:=StrToInt(propvalue)
 else
 if propname='COLLATECOPIES' then
  report.CollateCopies:=RpStrToBool(propvalue)
 else
 if propname='TWOPASS' then
  report.TwoPass:=RpStrToBool(propvalue)
 else
 if propname='PRINTERFONTS' then
  report.PrinterFonts:=TRpPrinterFontsOption(StrToInt(propvalue))
 else
 if propname='PRINTONLYIFDATAAVAILABLE' then
  report.PrintOnlyIfDataAvailable:=RpStrToBool(propvalue)
 else
 if propname='STREAMFORMAT' then
  report.StreamFormat:=TrpStreamFormat(StrToInt(propvalue))
 else
 if propname='REPORTACTIONDRAWERBEFORE' then
 begin
  if RpStrToBool(propvalue) then
  include(actions,rpDrawerBefore);
 end
 else
 if propname='REPORTACTIONDRAWERAFTER' then
 begin
  if RpStrToBool(propvalue) then
  include(actions,rpDrawerAfter);
 end
 else
 if propname='PREVIEWABOUT' then
  report.PreviewAbout:=RpStrToBool(propvalue)
 else
 if propname='TYPE1FONT' then
  report.Type1Font:=TRpType1Font(StrToInt(propvalue))
 else
 if propname='FONTSIZE' then
  report.FontSize:=StrToInt(propvalue)
 else
 if propname='FONTROTATION' then
  report.FontRotation:=StrToInt(propvalue)
 else
 if propname='FONTSTYLE' then
  report.FontStyle:=StrToInt(propvalue)
 else
 if propname='FONTCOLOR' then
  report.FontColor:=StrToInt(propvalue)
 else
 if propname='BACKCOLOR' then
  report.BackColor:=StrToInt(propvalue)
 else
 if propname='TRANSPARENT' then
  report.Transparent:=RpStrToBool(propvalue)
 else
 if propname='CUTTEXT' then
  report.CutText:=RpStrToBool(propvalue)
 else
 if propname='ALIGNMENT' then
  report.AlignMent:=StrToInt(propvalue)
 else
 if propname='VALIGNMENT' then
  report.VAlignMent:=StrToInt(propvalue)
 else
 if propname='WORDWRAP' then
  report.WordWrap:=RpStrToBool(propvalue)
 else
 if propname='SINGLELINE' then
  report.SingleLine:=RpStrToBool(propvalue)
 else
 if propname='BIDIMODES' then
  report.BidiModes.Text:=RpStringToString(propvalue)
 else
 if propname='MULTIPAGE' then
  report.MultiPage:=RpStrToBool(propvalue)
 else
 if propname='PRINTSTEP' then
  report.PrintStep:=TrpSelectFontStep(StrToInt(propvalue))
 else
 if propname='PAPERSOURCE' then
  report.PaperSource:=StrToInt(propvalue)
 else
 if propname='DUPLEX' then
  report.Duplex:=StrToInt(propvalue)
 else
 if propname='FORCEPAPERNAME' then
  report.ForcePaperName:=RpStringToString(propvalue)
 else
 if propname='LINESPERINCH' then
  report.LinesPerInch:=StrToInt(propvalue);
 report.ReportAction:=actions;
end;

procedure ReadCompProp(comp:TRpCommonPosComponent;
 propname,propvalue,proptype,propsize:Ansistring);
var
 compt:TRpGenTextComponent;
 compl:TRpLabel;
 comps:TRpShape;
 compi:TRpImage;
 compe:TRpExpression;
 compb:TRpBarCode;
 compc:TRpChart;
 memstream:TMemoryStream;
begin
 if propname='PRINTCONDITION' then
  comp.PrintCondition:=RpStringToWString(propvalue)
 else
 if propname='DOAFTERPRINT' then
  comp.DoAfterPrint:=RpStringToWString(propvalue)
 else
 if propname='DOBEFOREPRINT' then
  comp.DoBeforePrint:=RpStringToWString(propvalue)
 else
 if propname='WIDTH' then
  comp.Width:=StrToInt(propvalue)
 else
 if propname='HEIGHT' then
  comp.Height:=StrToInt(propvalue)
 else
 if propname='POSX' then
  comp.PosX:=StrToInt(propvalue)
 else
 if propname='POSY' then
  comp.PosY:=StrToInt(propvalue)
 else
 if propname='ALIGN' then
  comp.Align:=TRpPosAlign(StrToInt(propvalue));
 if comp is TRpGenTextComponent then
 begin
  compt:=TRpGenTextComponent(comp);
  if propname='WFONTNAME' then
   compt.WFontName:=RPStringToWString(propvalue)
  else
  if propname='LFONTNAME' then
   compt.LFontName:=RPStringToWString(propvalue)
  else
  if propname='BIDIMODE' then
   compt.BidiMode:=TRpBidiMode(StrToInt(propvalue))
  else
  if propname='TYPE1FONT' then
   compt.Type1Font:=TRpType1Font(StrToInt(propvalue))
  else
  if propname='FONTSIZE' then
   compt.FontSize:=StrToInt(propvalue)
  else
  if propname='FONTROTATION' then
   compt.FontRotation:=StrToInt(propvalue)
  else
  if propname='FONTSTYLE' then
   compt.FontSTyle:=StrToInt(propvalue)
  else
  if propname='FONTCOLOR' then
   compt.FontColor:=StrToInt(propvalue)
  else
  if propname='BACKCOLOR' then
   compt.BackColor:=StrToInt(propvalue)
  else
  if propname='TRANSPARENT' then
   compt.Transparent:=RpStrToBool(propvalue)
  else
  if propname='CUTTEXT' then
   compt.CutText:=RpStrToBool(propvalue)
  else
  if propname='ALIGNMENT' then
   compt.AlignMent:=StrToInt(propvalue)
  else
  if propname='VALIGNMENT' then
   compt.VAlignMent:=StrToInt(propvalue)
  else
  if propname='INTERLINE' then
   compt.InterLine:=StrToInt(propvalue)
  else
  if propname='WORDWRAP' then
   compt.WordWrap:=RpStrToBool(propvalue)
  else
  if propname='WORDBREAK' then
   compt.WordBreak:=RpStrToBool(propvalue)
  else
  if propname='SINGLELINE' then
   compt.SingleLine:=RpStrToBool(propvalue)
  else
  if propname='BIDIMODES' then
   compt.BidiModes.Text:=RpStringToString(propvalue)
  else
  if propname='MULTIPAGE' then
   compt.MultiPage:=RpStrToBool(propvalue)
  else
  if propname='PRINTSTEP' then
   compt.PrintStep:=TRpSelectFontStep(StrToInt(propvalue));
 end;
 // TRpLabel
 if comp is TRpLabel then
 begin
  compl:=TRpLabel(comp);
  if propname='WIDETEXT' then
  begin
   compl.WideText:=RpStringToWString(propvalue);
   compl.UpdateAllStrings;
  end;
 end
 else
 // TRpExpression
 if comp is TRpExpression then
 begin
  compe:=TRpExpression(comp);
  if propname='EXPRESSION' then
   compe.Expression:=RpStringToWString(propvalue)
  else
  if propname='AGINIVALUE' then
   compe.AgIniValue:=RpStringToWString(propvalue)
  else
  if propname='EXPORTEXPRESSION' then
   compe.ExportExpression:=RpStringToWString(propvalue)
  else
  if propname='DATATYPE' then
   compe.DataType:=TRpParamType(StrToInt(propvalue))
  else
  if propname='DISPLAYFORMAT' then
   compe.DisplayFormat:=RpStringToWString(propvalue)
  else
  if propname='IDENTIFIER' then
   compe.Identifier:=RpStringToString(propvalue)
  else
  if propname='AGGREGATE' then
   compe.Aggregate:=TRpAggregate(StrToInt(propvalue))
  else
  if propname='GROUPNAME' then
   compe.GroupName:=RpStringToString(propvalue)
  else
  if propname='AGTYPE' then
   compe.AgType:=TRpAggregateType(StrToInt(propvalue))
  else
  if propname='AUTOEXPAND' then
   compe.AutoExpand:=RpStrToBool(propvalue)
  else
  if propname='AUTOCONTRACT' then
   compe.AutoContract:=RpStrToBool(propvalue)
  else
  if propname='PRINTONLYONE' then
   compe.PrintOnlyOne:=RpStrToBool(propvalue)
  else
  if propname='PRINTNULLS' then
   compe.PrintNulls:=RpStrToBool(propvalue)
  else
  if propname='EXPORTDISPLAYFORMAT' then
   compe.ExportDisplayFormat:=RpStringToWString(propvalue)
  else
  if propname='EXPORTLINE' then
   compe.ExportLine:=StrToInt(propvalue)
  else
  if propname='EXPORTPOSITION' then
   compe.ExportPosition:=StrToInt(propvalue)
  else
  if propname='EXPORTSIZE' then
   compe.ExportSize:=StrToInt(propvalue)
  else
  if propname='EXPORTDONEWLINE' then
   compe.ExportDoNewLine:=RpStrToBool(propvalue);
 end
 else
 // TRpShape
 if comp is TRpShape then
 begin
  comps:=TRpShape(comp);
  if propname='SHAPE' then
   comps.Shape:=TrpShapeType(StrToInt(propvalue))
  else
  if propname='BRUSHSTYLE' then
   comps.BrushStyle:=StrToInt(propvalue)
  else
  if propname='BRUSHCOLOR' then
   comps.BrushColor:=StrToInt(propvalue)
  else
  if propname='PENSTYLE' then
   comps.PenStyle:=StrToInt(propvalue)
  else
  if propname='PENCOLOR' then
   comps.PenColor:=StrToInt(propvalue)
  else
  if propname='PENWIDTH' then
   comps.PenWidth:=StrToInt(propvalue);
 end
 else
 // TRpImage
 if comp is TRpImage then
 begin
  compi:=TRpImage(comp);
  if propname='EXPRESSION' then
   compi.Expression:=RpStringToWString(propvalue)
  else
  if propname='STREAM' then
  begin
   memstream:=TMemoryStream.Create;
   try
    BinToStream(memstream,RpStringToString(propvalue),propsize);
//    BinToStream(memstream,propvalue,propsize);
    memstream.Seek(0,soFromBeginning);
    compi.SetStream(memstream);
   finally
    memstream.free;
   end;
  end
  else
  if propname='ROTATION' then
   compi.Rotation:=StrToInt(propvalue)
  else
  if propname='DRAWSTYLE' then
   compi.DrawStyle:=TRpImageDrawStyle(StrToInt(propvalue))
  else
  if propname='DPIRES' then
   compi.DPIRes:=StrToInt(propvalue)
  else
  if propname='CACHEDIMAGE' then
  begin
   if (propvalue<>'False') then
    compi.CachedImage:=TrpCachedImage(StrToInt(propvalue));
  end
  else
  if propname='COPYMODE' then
   compi.CopyMode:=StrToInt(propvalue);
 end
 else
 // TRpChart
 if comp is TRpChart then
 begin
  compc:=TRpChart(comp);

  if propname='VALUEEXPRESSION' then
   compc.ValueExpression:=RpStringToWString(propvalue)
  else
  if propname='GETVALUECONDITION' then
   compc.GetValueCondition:=RpStringToWString(propvalue)
  else
  if propname='CHANGESERIEEXPRESSION' then
   compc.ChangeSerieExpression:=RpStringToWString(propvalue)
  else
  if propname='CAPTIONEXPRESSION' then
   compc.CaptionExpression:=RpStringToWString(propvalue)
  else
  if propname='COLOREXPRESSION' then
   compc.ColorExpression:=RpStringToWString(propvalue)
  else
  if propname='SERIECOLOREXPRESSION' then
   compc.SerieColorExpression:=RpStringToWString(propvalue)
  else
  if propname='SERIECAPTION' then
   compc.SerieCaption:=RpStringToWString(propvalue)
  else
  if propname='CLEAREXPRESSION' then
   compc.ClearExpression:=RpStringToWString(propvalue)
  else
  if propname='CHANGESERIEBOOL' then
   compc.ChangeSerieBool:=RpStrToBool(propvalue)
  else
  if propname='CHARTTYPE' then
   compc.ChartType:=TRpChartType(StrToInt(propvalue))
  else
  if propname='IDENTIFIER' then
   compc.Identifier:=RpStringToString(propvalue)
  else
  if propname='CLEAREXPRESSIONBOOL' then
   compc.ClearExpressionBool:=RpStrToBool(propvalue)
  else
  if propname='DRIVER' then
   compc.Driver:=TRpChartDriver(StrToInt(propvalue))
  else
  if propname='VIEW3D' then
   compc.View3D:=RpStrToBool(propvalue)
  else
  if propname='VIEW3DWALLS' then
   compc.View3DWalls:=RpStrToBool(propvalue)
  else
  if propname='PERSPECTIVE' then
   compc.Perspective:=StrToInt(propvalue)
  else
  if propname='ELEVATION' then
   compc.Elevation:=StrToInt(propvalue)
  else
  if propname='ROTATION' then
   compc.Rotation:=StrToInt(propvalue)
  else
  if propname='ZOOM' then
   compc.Zoom:=StrToInt(propvalue)
  else
  if propname='HORZOFFSET' then
   compc.HorzOffset:=StrToInt(propvalue)
  else
  if propname='VERTOFFSET' then
   compc.VertOffset:=StrToInt(propvalue)
  else
  if propname='TILT' then
   compc.Tilt:=StrToInt(propvalue)
  else
  if propname='ORTHOGONAL' then
   compc.Orthogonal:=RpStrToBool(propvalue)
  else
  if propname='MULTIBAR' then
   compc.MultiBar:=TRpMultiBar(StrToInt(propvalue))
  else
  if propname='RESOLUTION' then
   compc.Resolution:=StrToInt(propvalue)
  else
  if propname='SHOWLEGEND' then
   compc.ShowLegend:=RpStrToBool(propvalue)
  else
  if propname='SHOWHINT' then
   compc.ShowHint:=RpStrToBool(propvalue)
  else
  if propname='MARKSTYLE' then
   compc.MarkStyle:=StrToInt(propvalue)
  else
  if propname='HORZFONTSIZE' then
   compc.HorzFontSize:=StrToInt(propvalue)
  else
  if propname='VERTFONTSIZE' then
   compc.VertFontSize:=StrToInt(propvalue)
  else
  if propname='HORZFONTROTATION' then
   compc.HorzFontRotation:=StrToInt(propvalue)
  else
  if propname='VERTFONTROTATION' then
   compc.VertFontRotation:=StrToInt(propvalue);
 end
 else
 // TRpBarcode
 if comp is TRpBarcode then
 begin
  compb:=TRpBarcode(comp);
  if propname='EXPRESSION' then
   compb.Expression:=RpStringToWString(propvalue)
  else
  if propname='MODUL' then
   compb.Modul:=StrToInt(propvalue)
  else
  if propname='RATIO' then
   compb.Ratio:=RpStrToDouble(propvalue)
  else
  if propname='TYP' then
   compb.Typ:=TrpBarcodeType(StrToInt(propvalue))
  else
  if propname='CHECKSUM' then
   compb.CheckSum:=RpStrToBool(propvalue)
  else
  if propname='DISPLAYFORMAT' then
   compb.DisplayFormat:=RpStringToWString(propvalue)
  else
  if propname='ROTATION' then
   compb.Rotation:=StrToInt(propvalue)
  else
  if propname='BCOLOR' then
   compb.BColor:=StrToInt(propvalue)
  else
  if propname='NUMCOLUMNS' then
   compb.NumColumns:=StrToInt(propvalue)
  else
  if propname='NUMROWS' then
   compb.NumRows:=StrToInt(propvalue)
  else
  if propname='ECCLEVEL' then
   compb.ECCLevel:=StrToInt(propvalue)
  else
  if propname='TRUNCATED' then
   compb.Truncated:=RpStrToBool(propvalue)
 end;
end;


procedure ReadReportXML(areport:TComponent;Stream:TStream);
var
 astring:Ansistring;
 position:integer;
 propname:AnsiString;
 proptype:AnsiString;
 propvalue:ansiString;
 dbitem:TRpDatabaseInfoItem;
 ditem:TRpDataInfoItem;
 comp:TRpCommonPosComponent;
 compname,compclass:AnsiString;
 aclass:TPersistentClass;
 aparam:TRpParam;
 report:TRpReport;
 propsize:Ansistring;
 subrep:TRpSubReport;
 sec:TRpSection;
 compitem:TRpCommonListItem;
 i,j:integer;

 procedure FindNextName;
 var
  abegin,aend:integer;
  typepos:integer;
  props:Ansistring;
 begin
  propname:='';
  proptype:='';
  propsize:='';
  abegin:=0;
  aend:=0;
  while position<=Length(astring) do
  begin
   if astring[position]='<' then
   begin
    if abegin>0 then
     Raise Exception.Create(SRpStreamFormat);
    abegin:=position+1;
   end
   else
   if astring[position]='>' then
   begin
    if abegin=0 then
     Raise Exception.Create(SRpStreamFormat);
    aend:=position;
    inc(position);
    break;
   end;
   inc(position);
  end;
  if aend=0 then
   Raise Exception.Create(SRpStreamFormat);
  propname:=Trim(Copy(astring,abegin,aend-abegin));
  typepos:=Pos(' ',propname);
  props:='';
  if typepos>0 then
  begin
   props:=Copy(propname,typepos+1,Length(propname));
   propname:=Copy(propname,1,typepos-1);
  end;
  typepos:=Pos('size',props);
  if typepos>0 then
  begin
   propsize:=Copy(props,typepos+6,Length(props));
   propsize:=Copy(propsize,1,Length(propsize)-1);
   props:=Trim(Copy(props,1,typepos-1));
  end;
  typepos:=Pos('type',props);
  if typepos>0 then
  begin
   proptype:=Copy(props,typepos+7,Length(props));
   proptype:=Copy(proptype,1,Length(proptype)-1);
   props:=Trim(Copy(props,1,typepos-1));
  end;
  propvalue:='';
  while position<=Length(astring) do
  begin
   if astring[position]='<' then
   begin
    break;
   end
   else
   begin
    propvalue:=propvalue+astring[position];
    inc(position);
   end;
  end;
  if propname='' then
   Raise Exception.Create(SRpStreamFormat);
 end;

begin
 report:=TRpReport(areport);
 // Find the <report label>
{$IFNDEF DOTNETD}
 SetLength(astring,Stream.Size);
 Stream.Read(astring[1],Stream.size);
{$ENDIF}
{$IFDEF DOTNETD}
 astring:='';
{$ENDIF}
 position:=Pos('<REPORT',astring);
 if position<1 then
  Raise Exception.Create(SRpStreamFormat);
 // Next name must be
 FindNextName;
 FindNextName;
 while Length(propname)>0 do
 begin
  if propname='/REPORT' then
   break;
  if propname='DATABASEINFO' then
  begin
   FindNextName;
   if propname<>'ALIAS' then
    Raise Exception.Create(SRpStreamFormat);
   dbitem:=report.DatabaseInfo.Add(RpStringToString(propvalue));
   while propname<>'/DATABASEINFO' do
   begin
    ReadPropDBInfo(dbitem,propname,propvalue,proptype,propsize);
    FindNextName;
   end;
  end
  else
  if propname='DATAINFO' then
  begin
   FindNextName;
   if propname<>'ALIAS' then
    Raise Exception.Create(SRpStreamFormat);
   ditem:=report.DataInfo.Add(RpStringToString(propvalue));
   while propname<>'/DATAINFO' do
   begin
    ReadPropDataInfo(ditem,propname,propvalue,proptype,propsize);

    FindNextName;
   end;
  end
  else
  if propname='PARAMETER' then
  begin
   FindNextName;
   if propname<>'NAME' then
    Raise Exception.Create(SRpStreamFormat);
   aparam:=report.Params.Add(RpStringToString(propvalue));
   while propname<>'/PARAMETER' do
   begin
    ReadPropParam(aparam,propname,propvalue,proptype,propsize);

    FindNextName;
   end;
  end
  else
  if propname='SUBREPORT' then
  begin
   FindNextName;
   if propname<>'NAME' then
    Raise Exception.Create(SRpStreamFormat);
   subrep:=TRpSubReport.Create(report);
   report.SubReports.Add.SubReport:=subrep;
   subrep.Name:=RpStringToString(propvalue);
   FindNextName;

   while propname<>'/SUBREPORT' do
   begin
    // Read subreport props
    if propname='SECTION' then
    begin
     FindNextName;
     if propname<>'NAME' then
      Raise Exception.Create(SRpStreamFormat);
     sec:=TRpSection.Create(report);
     subrep.Sections.Add.Section:=sec;;
     sec.Name:=RpStringToString(propvalue);
     FindNextName;
     while propname<>'/SECTION' do
     begin
      // Read Section props
      if propname='COMPONENT' then
      begin
       FindNextName;
       if propname<>'NAME' then
        Raise Exception.Create(SRpStreamFormat);
       compname:=propvalue;
       FindNextName;
       FindNextName;
       if propname<>'CLASSNAME' then
        Raise Exception.Create(SRpStreamFormat);
       compclass:=propvalue;

       aclass:=FindClass(compclass);
       comp:=TRpCommonPosComponent(
        TComponentClass(aclass).Create(report));

       compitem:=sec.Components.Add;
       compitem.Component:=comp;
       comp.Name:=compname;
       while propname<>'/COMPONENT' do
       begin
        // Read component props
        ReadCompProp(comp,propname,propvalue,proptype,propsize);

        FindNextName;
       end;
      end
      else
       ReadPropSection(sec,propname,propvalue,proptype,propsize);
      FindNextName;
     end;
    end
    else
     ReadPropSubReport(subrep,propname,propvalue,proptype,propsize);
    FindNextName;
   end;
  end
  else
   ReadPropReport(report,propname,propvalue,proptype,propsize);
  FindNextName;
 end;
 // Reload links
 for i:=0 to report.SubReports.Count-1 do
 begin
  subrep:=report.SubReports.Items[i].SubReport;
  if Length(subrep.ParentSub)>0 then
  begin
   subrep.ParentSubReport:=TRpSubReport(report.FindComponent(subrep.ParentSub));
  end;
  if Length(subrep.ParentSec)>0 then
  begin
   subrep.ParentSection:=TRpSection(report.FindComponent(subrep.ParentSec));
  end;
  for j:=0 to subrep.Sections.Count-1 do
  begin
   sec:=subrep.Sections.Items[j].Section;
   if Length(sec.ChildSubReportName)>0 then
   begin
    sec.ChildSubReport:=TRpSubReport(report.FindComponent(sec.ChildSubReportName));
   end;
   if Length(sec.SubReportName)>0 then
   begin
    sec.SubReport:=TRpSubReport(report.FindComponent(sec.SubReportName));
   end;
  end;
 end;
end;

end.
