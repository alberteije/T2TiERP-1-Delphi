{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rplabelitem                                     }
{       TRpLabel printable component constant text      }
{       TRpExpression printable expression              }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}


unit rplabelitem;

interface


{$I rpconf.inc}

uses Sysutils,Classes,rptypes,rpprintitem,rpmdconsts,
 rpmetafile,rpeval,rpparams,
{$IFDEF MSWINDOWS}
 windows,
{$ENDIF}
{$IFDEF USEVARIANTS}
  Variants,Types,
{$ENDIF}
 rptypeval;

const
 AlignmentFlags_SingleLine=64;

type
 TRpLabel=class(TRpGenTextComponent)
  private
   FAllText:TStrings;
   FAllStrings:TRpWideStrings;
   FWideText:WideString;
   procedure SetText(Value:WideString);
   function GetText:WideString;
   procedure SetAllText(Value:TStrings);
   procedure WriteWideText(Writer:TWriter);
   procedure ReadWideText(Reader:TReader);
   function GetTextObject:TRpTextObject;
  protected
   procedure DefineProperties(Filer:TFiler);override;
   procedure DoPrint(adriver:TRpPrintDriver;
    aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);override;
   procedure Loaded;override;
  public
   procedure UpdateWideText;
   procedure UpdateAllStrings;
   function GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;override;
   property AllStrings:TRpWideStrings read FAllStrings write FAllStrings;
   constructor Create(AOwner:TComponent);override;
   property Text:widestring read GetText write SetText;
   destructor Destroy;override;
   property WideText:WideString read FWideText write FWideText;
  published
   // Compatibility with RC1,RC2
   property AllText:TStrings read FAllText write SetAllText;
  end;

 TIdenRpExpression=class;

 TRpExpression=class(TRpGenTextComponent)
  private
   FExpression:widestring;
   FGroupName:string;
   FAggregate:TRpAggregate;
   FAgType:TRpAggregateType;
   FIdentifier:string;
   FAutoExpand:Boolean;
   FAutoContract:Boolean;
   FDisplayFormat:Widestring;
   FExportDisplayFormat:Widestring;
   FDataType:TRpParamType;
   FValue:Variant;
   FExportValue:Variant;
   FSumValue:Variant;
   FDataCount:integeR;
   FUpdated:boolean;
   FAgIniValue:widestring;
   FValues:array of Double;
   FPrintOnlyOne:boolean;
   FIdenExpression:TIdenRpExpression;
   FOldString:widestring;
   FPrintNulls:boolean;
   FIsPartial:Boolean;
   FPartialPos:Integer;
   FExportExpression:WideString;
   FExportLine:Integer;
   FExportPosition:Integer;
   FExportSize:Integer;
   FExportDoNewLine:Boolean;
   FIsPageCount:Boolean;
   FIsGroupPageCount:Boolean;
   forcedpartial:boolean;
   procedure SetIdentifier(Value:string);
   procedure Evaluate;
   procedure WriteExpression(Writer:TWriter);
   procedure ReadExpression(Reader:TReader);
   procedure WriteDispFormat(Writer:TWriter);
   procedure ReadDispFormat(Reader:TReader);
   procedure WriteExpDispFormat(Writer:TWriter);
   procedure ReadExpDispFormat(Reader:TReader);
   procedure WriteExpExpression(Writer:TWriter);
   procedure ReadExpExpression(Reader:TReader);
   procedure WriteAgIniValue(Writer:TWriter);
   procedure ReadAgIniValue(Reader:TReader);
   procedure SetExpression(avalue:WideString);
   procedure UpdateIsPageCount;
  protected
   procedure DefineProperties(Filer:TFiler);override;
   procedure DoPrint(adriver:TRpPrintDriver;aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);override;
   procedure Loaded;override;
  public
   LastMetaIndex:integer;
   constructor Create(AOwner:TComponent);override;
   procedure SubReportChanged(newstate:TRpReportChanged;newgroup:string='');override;
   function GetTextObject:TRpTextObject;
   function GetText:widestring;
   property IdenExpression:TIdenRpExpression read FIdenExpression;
   function GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;override;
   property Expression:widestring read FExpression write SetExpression;
   property AgIniValue:widestring read FAgIniValue write FAgIniValue;
   property IsPartial:Boolean read FIsPartial;
   //
   property ExportExpression:widestring read FExportExpression write FExportExpression;
   property IsGroupPageCount:Boolean read FIsGroupPageCount write FIsGroupPageCount;
  published
   property DataType:TRpParamType read FDataType write FDataType default rpParamUnknown;
   property DisplayFormat:Widestring read FDisplayformat write FDisplayFormat;
   property Identifier:string read FIdentifier write SetIdentifier;
   property Aggregate:TRpAggregate read FAggregate write FAggregate
    default rpagNone;
   property GroupName:string read FGroupName write FGroupName;
   property AgType:TRpAggregateType read FAgType write FAgType
    default rpAgSum;
   property AutoExpand:Boolean read FAutoExpand write FAutoExpand;
   property AutoContract:Boolean read FAutoContract write FAutoContract;
   property PrintOnlyOne:Boolean read FPrintOnlyOne write FPrintOnlyOne
    default false;
   property PrintNulls:Boolean read FPrintNulls write FPrintNulls default true;
   //
   property ExportDisplayFormat:Widestring read FExportDisplayformat write FExportDisplayFormat;
   property ExportLine:Integer read FExportLine write FExportLine default 0;
   property ExportPosition:Integer read FExportPosition write FExportPosition default 1;
   property ExportSize:Integer read FExportSize write FExportSize default 20;
   property ExportDoNewLine:Boolean read FExportDoNewLine write FExportDoNewLine;
  end;

  TIdenRpExpression=class(TIdenFunction)
  private
   FExpreitem:TRpExpression;
  protected
   function GetRpValue:TRpValue;override;
  public
  end;


implementation


uses rpbasereport,Math;

function TIdenRpExpression.GeTRpValue:TRpValue;
begin
 if Not Assigned(FExpreItem) then
  Raise Exception.Create(SRpErrorIdenExpression);
 FExpreitem.Evaluate;
 Result:=FExpreitem.FValue;
end;

constructor TRpLabel.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 Height:=275;
 Width:=1440;
 FAllText:=TStringList.Create;
 FAllStrings:=TRpWideStrings.Create;
end;

destructor TRpLabel.Destroy;
begin
 FAllText.free;
 FAllStrings.Free;
 inherited destroy;
end;



procedure TRpLabel.SetText(Value:WideString);
var
 langindex:integer;
 acopy:WideString;
begin
 langindex:=TRpBaseReport(GetReport).Language+1;
 if langindex<0 then
  langindex:=0;
 acopy:='';
 if FAllStrings.Count>0 then
  acopy:=FAllStrings.Strings[0];
 while ((FAllStrings.Count-1)<langindex) do
 begin
  FAllStrings.Add(acopy);
 end;
 FAllStrings.Strings[langindex]:=Value;
 UpdateWideText;
end;


function TRpLabel.GetText:WideString;
var
 langindex:integer;
 acopy:WideString;
begin
 langindex:=TRpBaseReport(GetReport).Language+1;
 if langindex<0 then
  langindex:=0;
 acopy:='';
 if FAllStrings.Count>0 then
  acopy:=FAllStrings.Strings[0];
 if FAllStrings.Count>langindex then
  Result:=FAllStrings.Strings[langindex]
 else
  Result:=acopy;
end;

procedure TRpLabel.SetAllText(Value:TStrings);
var
 i:integer;
begin
 FAllText.Assign(Value);
 if FAllText.Count>0 then
 begin
  FAllStrings.Clear;
  for i:=0 to FAllText.Count-1 do
  begin
   FAllStrings.Add(FAllText.Strings[i]);
  end;
  FAllText.Clear;
  UpdateWideText;
 end
end;



procedure TRpLabel.Loaded;
var
 i:integer;
begin
 inherited Loaded;
 if FAllText.Count>0 then
 begin
  FAllStrings.Clear;
  for i:=0 to FAllText.Count-1 do
  begin
   FAllStrings.Add(FAllText.Strings[i]);
  end;
  FAllText.Clear;
  UpdateWideText;
 end
 else
  UpdateAllStrings;
end;


procedure TRpLabel.UpdateWideText;
var
 i:integer;
begin
 FWideText:='';
 for i:=0 to FAllStrings.Count-1 do
 begin
  FWideText:=FWideText+FAllStrings.Strings[i];
  if i<FAllStrings.Count-1 then
   FWideText:=FWideText+WideChar(chr(10));
 end;
end;

procedure TRpLabel.UpdateAllStrings;
var
 i:integer;
 tempwide:WideString;
 alength:integer;
begin
 FAllStrings.Clear;
 i:=1;
 tempwide:='';
 alength:=Length(FWideText);
 while i<=alength do
 begin
  if FWideText[i]=WideChar(chr(10)) then
  begin
   FAllStrings.Add(tempwide);
   tempwide:='';
  end
  else
   tempwide:=tempwide+FWideText[i];
  inc(i);
 end;
 if Length(tempwide)>0 then
  FAllStrings.Add(tempwide);
end;


constructor TRpExpression.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FPrintNulls:=true;
 Height:=275;
 FAgIniValue:='0';
 Width:=1440;
 FIdenExpression:=TIdenRpExpression.Create(Self);
 FIdenExpression.FExpreitem:=Self;
 FDataType:=rpParamUnknown;
 FExportLine:=0;
 FExportSize:=20;
 FExportSize:=1;
 FExportDoNewLine:=false;
 FExportDisplayFormat:='';
 FIsPageCount:=false;
 FIsGroupPageCount:=false;
 FExportValue:=Null;
end;

procedure TRpLabel.DoPrint(adriver:TRpPrintDriver;aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);
var
 aalign:integer;
 aTextObj:TRpTextObject;
begin
 inherited DoPrint(adriver,aposx,aposy,newwidth,newheight,metafile,MaxExtent,PartialPrint);
 aTextObj.Text:=Text;
 aTextObj.LFontName:=LFontName;
 aTextObj.WFontName:=WFontName;
 aTextObj.FontSize:=FontSize;
 aTextObj.FontRotation:=FontRotation;
 aTextObj.FontStyle:=FontStyle;
 aTextObj.FontColor:=FontColor;
 aTextObj.Type1Font:=integer(Type1Font);
 aTextObj.CutText:=CutText;
 aTextObj.WordWrap:=WordWrap;
 aTextObj.RightToLeft:=RightToLeft;
 aTextObj.PrintStep:=PrintStep;
 aalign:=PrintAlignment or VAlignment;
 if SingleLine then
  aalign:=aalign or AlignmentFlags_SingleLine;
 aTextObj.Alignment:=aalign;


 metafile.Pages[metafile.CurrentPage].NewTextObject(aposy,
  aposx,Printwidth,Printheight,aTextObj,BackColor,Transparent);
end;


procedure TRpExpression.SetIdentifier(Value:string);
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

procedure TRpExpression.Evaluate;
var
 fevaluator:TRpEvaluator;
begin
 if FUpdated then
  exit;
 try
  fevaluator:=TRpBaseReport(GetReport).Evaluator;
//  fevaluator.Expression:=FExpression;
//  fevaluator.Evaluate;
//  FValue:=fevaluator.EvalResult;
  FValue:=fevaluator.EvaluateText(FExpression);
  FUpdated:=true;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSExpression+' '+Name,self,SRpSExpression);
  end;
 end;
 FExportValue:=Null;
 if Length(FExportExpression)>0 then
 begin
  try
   fevaluator:=TRpBaseReport(GetReport).Evaluator;
   FExportValue:=fevaluator.EvaluateText(FExportExpression);
  except
   on E:Exception do
   begin
    Raise TRpReportException.Create(E.Message+':'+SRpSExportExpression+' '+Name,self,SRpSExportExpression);
   end;
  end;
 end
 else
 begin
  FExportValue:=Null;
 end;
end;

function TRpExpression.GetText:widestring;
var
 expre:WideString;
begin
 expre:=Trim(Expression);
 if Length(expre)<1 then
 begin
  Result:='';
  exit;
 end;
 // Is Total pages variable?
 if (FIsPageCount or FIsGroupPageCount) then
 begin
  // 20 spaces
  Result:='                    ';
 end
 else
 begin
  Evaluate;
  try
   Result:=FormatVariant(displayformat,FValue,FDataType,FPrintNulls);
  except
   on E:Exception do
   begin
    Raise TRpReportException.Create(E.Message+':'+SRpSDisplayFormat+' '+Name,self,SRpSDisplayFormat);
   end;
  end;
  if FIsPartial then
  begin
   // Skip one space if necessary
   if Result[FPartialPos]=Widechar(' ') then
    FPartialPos:=FPartialPos+1;
   Result:=Copy(Result,FPartialPos,Length(Result));
  end;
 end;
end;

procedure TRpExpression.DoPrint(adriver:TRpPrintDriver;aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);
var
 expre:WideString;
 Textobj:TRpTextObject;
 newposition:Integer;
 avalue:WideString;
begin
 inherited DoPrint(adriver,aposx,aposy,newwidth,newheight,metafile,MaxExtent,PartialPrint);
 LastMetaIndex:=-1;
 expre:=Trim(Expression);
 Textobj:=GetTextObject;
 if PrintOnlyOne then
 begin
  if FOldString=Textobj.Text then
   exit;
  FOldString:=Textobj.Text;
 end;
 if (MultiPage or forcedpartial) then
 begin
  maxextent.X:=PrintWidth;
  newposition:=CalcTextExtent(adriver.GetFontDriver,maxextent,Textobj);
  if newposition<Length(TextObj.Text) then
  begin
   if Not FIsPartial then
    FPartialPos:=0;
   FIsPartial:=true;
   PartialPrint:=true;
   FPartialPos:=FPartialPos+newposition;
   TextObj.Text:=Copy(TextObj.Text,1,newposition);
  end
  else
  begin
   FIsPartial:=false;
   forcedpartial:=false;
  end;
 end;
 metafile.Pages[metafile.CurrentPage].NewTextObject(aposy,
   aposx,Printwidth,Printheight,Textobj,BackColor,Transparent);
 LastMetaIndex:=metafile.Pages[metafile.CurrentPage].ObjectCount-1;
 // Is Total pages variable?
 if (FIsPageCount) then
 begin
  TRpBaseReport(GetReport).AddTotalPagesItem(metafile.currentpage,metafile.Pages[metafile.currentpage].ObjectCount-1,displayformat);
 end;
 if Not VarIsNull(FExportValue) then
 begin
  try
   avalue:=FormatVariant(exportdisplayformat,FExportValue,rpParamunknown,true);
  except
   on E:Exception do
   begin
    Raise TRpReportException.Create(E.Message+':'+SRpSExportFormat+' '+Name,self,SRpSExportFormat);
   end;
  end;
  metafile.Pages[metafile.CurrentPage].NewExportObject(aposy,aposx,
   PrintWidth,PrintHeight,avalue,FExportLine,FExportPosition,FExportSize,
   FExportDoNewLine);
 end;
end;

type
 TArrayExtended=array of Extended;
 
function ToArrayExtended(avalues:array of double):TArrayExtended;
var
 i:integer;
 c:integer;
begin
 c:=0;
 SetLength(REsult,Length(avalues));
 for i:=Low(avalues) to High(avalues) do
 begin
  Result[c]:=avalues[i];
  c:=c+1;
 end;
 
end;

procedure TRpExpression.SubReportChanged(newstate:TRpReportChanged;newgroup:string='');
var
 eval:TRpEvaluator;
begin
 inherited SubReportChanged(newstate,newgroup);
 case newstate of
  rpReportStart:
   begin
    FExportValue:=Null;
    FIsPartial:=false;
    forcedpartial:=false;
    FOldString:='';
    FUpdated:=false;
    FDataCount:=0;
    if (FAggregate<>rpAgNone) then
    begin
     // Update with the initial value
     try
      eval:=TRpBaseReport(GetReport).Evaluator;
      eval.Expression:=FAgIniValue;
      eval.Evaluate;
      FValue:=eval.EvalResult;
      FSumValue:=FValue;
      FUpdated:=true;
     except
      on E:Exception do
      begin
       Raise TRpReportException.Create(E.Message+':'+SrpSIniValue+' '+Name,self,SrpSIniValue);
      end;
     end;
    end;
   end;
  rpSubReportStart:
   begin
    FExportValue:=Null;
    FIsPartial:=false;
    forcedpartial:=false;
    FOldString:='';
    FUpdated:=false;
    FDataCount:=0;
    if ((FAggregate<>rpAgNone) AND (FAggregate<>rpAgGeneral)) then
    begin
     // Update with the initial value
     try
      eval:=TRpBaseReport(GetReport).Evaluator;
      eval.Expression:=FAgIniValue;
      eval.Evaluate;
      FValue:=eval.EvalResult;
      FSumValue:=FValue;
      FUpdated:=true;
     except
      on E:Exception do
      begin
       Raise TRpReportException.Create(E.Message+':'+SrpSIniValue+' '+Name,self,SrpSIniValue);
      end;
     end;
    end;
   end;
  rpDataChange:
   begin
    FIsPartial:=false;
    forcedpartial:=false;
    FUpdated:=false;
    inc(FDataCount);
    if (FAggregate<>rpAgNone) then
    begin
     try
      // Update with the initial value
      eval:=TRpBaseReport(GetReport).Evaluator;
      eval.Expression:=FExpression;
      eval.Evaluate;
      // Do the operation
      case AgType of
       rpagSum:
        begin
         if Not VarIsNull(eval.EvalResult) then
          FValue:=FValue+eval.EvalResult;
        end;
       rpagMin:
        begin
         if FDataCount=1 then
          FValue:=eval.EvalResult
         else
         begin
          if FValue>eval.EvalResult then
           FValue:=eval.EvalResult;
         end;
        end;
       rpagMax:
        begin
         if FDataCount=1 then
          FValue:=eval.EvalResult
         else
         begin
          if FValue<eval.EvalResult then
           FValue:=eval.EvalResult;
         end;
        end;
       rpagAvg:
        begin
         if VarIsNull(eval.EvalResult) then
          Dec(FDataCount)
         else
         begin
          FSumValue:=FSumValue+eval.EvalResult;
          FValue:=FSumValue/FDataCount;
         end;
        end;
       rpagStdDev:
        begin
         if VarIsNull(eval.EvalResult) then
          Dec(FDataCount)
         else
         begin
          SetLength(FValues,FDataCount);
          FValues[FDatacount-1]:=eval.EvalResult;
          if High(FValues)=Low(FValues) then
           FValue:=0
          else
{$IFDEF FPC}
           FValue:=StdDev(ToArrayExtended(FValues));
{$ENDIF}
{$IFNDEF FPC}
           FValue:=StdDev(FValues);
{$ENDIF}
         end;
        end;
      end;
      FUpdated:=true;
     except
      on E:Exception do
      begin
       Raise TRpReportException.Create(E.Message+':'+SrpSExpression+' '+Name,self,SrpSExpression);
      end;
     end;
    end;
   end;
  rpGroupChange:
   begin
    FIsPartial:=false;
    forcedpartial:=false;
    FUpdated:=false;
    FOldString:='';
    if (FAggregate=rpAgGroup) then
    begin
     if Uppercase(GroupName)=UpperCase(newgroup) then
     begin
      // Update with the initial value
      try
       eval:=TRpBaseReport(GetReport).Evaluator;
       eval.Expression:=FAgIniValue;
       eval.Evaluate;
      except
       on E:Exception do
       begin
        Raise TRpReportException.Create(E.Message+':'+SrpSIniValue+' '+Name,self,SrpSIniValue);
       end;
      end;
      FValue:=eval.EvalResult;
      FSumValue:=FValue;
      FDataCount:=0;
      FUpdated:=true;
     end;
    end;
   end;
  rpPageChange:
   begin
    FOldString:='';
    if (FAggregate=rpAgNone) then
    begin
     // Page variable must be recalculated
     FUpdated:=False;
    end;
    if (FAggregate=rpAgPage) then
    begin
     // Update with the initial value
     try
      eval:=TRpBaseReport(GetReport).Evaluator;
      eval.Expression:=FAgIniValue;
      eval.Evaluate;
     except
      on E:Exception do
      begin
       Raise TRpReportException.Create(E.Message+':'+SrpSIniValue+' '+Name,self,SrpSIniValue);
      end;
     end;
     FValue:=eval.EvalResult;
     FSumValue:=FValue;
     FDataCount:=0;
     FUpdated:=true;
     SubReportChanged(rpDataChange);
    end;
   end;
  rpInvalidateValue:
   begin
    FIsPartial:=false;
    forcedpartial:=false;
    FOldString:='';
    FUpdated:=false;
   end;
 end;
end;

function TRpExpression.GetTextObject:TRpTextObject;
var
 aalign:Integer;
begin
 Result.Text:=GetText;
 Result.LFontName:=LFontName;
 Result.WFontName:=WFontName;
 Result.FontSize:=FontSize;
 Result.FontRotation:=FontRotation;
 Result.FontStyle:=FontStyle;
 Result.Type1Font:=integer(Type1Font);
 Result.FontColor:=FontColor;
 Result.CutText:=CutText;
 aalign:=PrintAlignment or VAlignment;
 if SingleLine then
  aalign:=aalign or AlignmentFlags_SingleLine;
 Result.Alignment:=aalign;
 Result.WordWrap:=WordWrap;
 Result.RightToLeft:=RightToLeft;
 Result.PrintStep:=PrintStep;
end;

function TRpExpression.GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;
var
 aText:TRpTextObject;
 aposition:integer;
 IsPartial:Boolean;
begin
 aText:=GetTextObject;
 if PrintOnlyOne then
 begin
  if FOldString=aText.Text then
  begin
   Result.x:=0;
   Result.y:=0;
   exit;
  end;
 end;

 IsPartial:=False;
 Result:=inherited GetExtension(adriver,MaxExtent,forcepartial);


 if (MultiPage or forcepartial) then
 begin
  maxextent.X:=Result.X;
  aposition:=CalcTextExtent(adriver.GetFontDriver,maxextent,aText);
  if aposition<Length(aText.Text) then
   ispartial:=true;
  aText.Text:=Copy(aText.Text,1,aposition);
  adriver.TextExtent(aText,Result);
  if ispartial then
  begin
   Result.Y:=MaxExtent.Y;
   if forcepartial then
    forcedpartial:=true;
  end;
 end
 else
  adriver.TextExtent(aText,Result);
 LastExtent:=Result;
end;


procedure TRpExpression.WriteExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FExpression);
end;

procedure TRpExpression.ReadExpression(Reader:TReader);
begin
 FExpression:=ReadWideString(Reader);
end;

procedure TRpExpression.WriteDispFormat(Writer:TWriter);
begin
 WriteWideString(Writer, FDisplayFormat);
end;

procedure TRpExpression.ReadDispFormat(Reader:TReader);
begin
 FDisplayFormat:=ReadWideString(Reader);
end;

procedure TRpExpression.WriteExpDispFormat(Writer:TWriter);
begin
 WriteWideString(Writer, FExportDisplayFormat);
end;

procedure TRpExpression.ReadExpDispFormat(Reader:TReader);
begin
 FExportDisplayFormat:=ReadWideString(Reader);
end;


procedure TRpExpression.WriteExpExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FExportExpression);
end;

procedure TRpExpression.ReadExpExpression(Reader:TReader);
begin
 FExportExpression:=ReadWideString(Reader);
end;

procedure TRpExpression.WriteAgIniValue(Writer:TWriter);
begin
 WriteWideString(Writer, FAgIniValue);
end;

procedure TRpExpression.ReadAgIniValue(Reader:TReader);
begin
 FAgIniValue:=ReadWideString(Reader);
end;

procedure TRpExpression.DefineProperties(Filer:TFiler);
begin
 inherited;

 Filer.DefineProperty('Expression',ReadExpression,WriteExpression,True);
 Filer.DefineProperty('DisplayFormat',ReadDispFormat,WriteDispFormat,True);
 Filer.DefineProperty('ExportDisplayFormat',ReadExpDispFormat,WriteExpDispFormat,True);
 Filer.DefineProperty('AgIniValue',ReadAgIniValue,WriteAgIniValue,True);
 Filer.DefineProperty('ExportExpression',ReadExpExpression,
  WriteExpExpression,True);
end;

procedure TRpLabel.WriteWideText(Writer:TWriter);
begin
 WriteWideString(Writer, FWideText);
end;

procedure TRpLabel.ReadWideText(Reader:TReader);
begin
 FWideText:=ReadWideString(Reader);
end;

procedure TRpLabel.DefineProperties(Filer:TFiler);
begin
 inherited;

 Filer.DefineProperty('WideText',ReadWideText,WriteWideText,True);
end;

function TRpLabel.GetTextObject:TRpTextObject;
var
 aalign:Integer;
begin
 Result.Text:=GetText;
 Result.LFontName:=LFontName;
 Result.WFontName:=WFontName;
 Result.FontSize:=FontSize;
 Result.FontRotation:=FontRotation;
 Result.FontStyle:=FontStyle;
 Result.Type1Font:=integer(Type1Font);
 Result.FontColor:=FontColor;
 Result.CutText:=CutText;
 aalign:=PrintAlignment or VAlignment;
 if SingleLine then
  aalign:=aalign or AlignmentFlags_SingleLine;
 Result.Alignment:=aalign;
 Result.WordWrap:=WordWrap;
 Result.RightToLeft:=RightToLeft;
 Result.PrintStep:=PrintStep;
end;


function TRpLabel.GetExtension(adriver:TRpPrintDriver;MaxExtent:TPoint;forcepartial:boolean):TPoint;
var
 aText:TRpTextObject;
begin
 Result:=inherited GetExtension(adriver,MaxExtent,forcepartial);
 aText:=GetTextObject;
 adriver.TextExtent(aText,Result);
 LastExtent:=Result;
end;

procedure TRpExpression.UpdateIsPageCount;
begin
 FIsPageCount:=false;
 FIsGroupPageCount:=false;
 if UpperCase(Trim(FExpression))='PAGECOUNT' then
  FIsPageCount:=true;
 if UpperCase(Trim(FExpression))='GROUPPAGECOUNT' then
  FIsGroupPageCount:=true;
end;

procedure TRpExpression.SetExpression(avalue:WideString);
begin
 FExpression:=avalue;
 UpdateIsPageCount;
end;

procedure TRpExpression.Loaded;
begin
 inherited Loaded;
 UpdateIsPageCount;
end;

end.
