unit rpaxreportreport;

interface

uses
  ComObj, ActiveX, reportman_TLB, StdVcl,rpreport,
  rpaxreportparameters,rpcolumnar;

type
  TReportReport = class(TAutoObject, IReportReport)
  private
    FReportParameters:TReportParameters;
    FColumnar:TRpColumnar;
    FAutoResizeColumns:Boolean;
  protected
    function Get_Params: ReportParameters; safecall;
    function Get_VCLReport: PChar; safecall;
    procedure AddColumn(Width: Integer; const Expression, ExpFormat, Caption,
      CaptionFormat, SumaryExpression, SumaryFormat: WideString); safecall;
    function Get_AutoResizeColumns: WordBool; safecall;
    procedure Set_AutoResizeColumns(Value: WordBool); safecall;
    { Protected declarations }
  public
   FReport:TRpReport;
  end;

implementation

uses ComServ;

function TReportReport.Get_Params: ReportParameters;
begin
 if Not Assigned(FReportParameters) then
 begin
  FReportParameters:=TReportParameters.Create;
  FReportParameters.FReport:=FReport;
 end;
 Result:=FReportParameters;
 Result._Addref;
end;


function TReportReport.Get_VCLReport: PChar;
begin
 Result:=PChar(FReport);
end;

procedure TReportReport.AddColumn(Width: Integer; const Expression,
  ExpFormat, Caption, CaptionFormat, SumaryExpression,
  SumaryFormat: WideString);
begin
 if not Assigned(FColumnar) then
 begin
  FColumnar:=TRpColumnar.Create;
  FColumnar.Report:=FReport;
 end
 else
 begin
  if FColumnar.Report<>FReport then
  begin
   FColumnar.free;
   FColumnar:=nil;
   FColumnar:=TRpColumnar.Create;
   FColumnar.Report:=FReport;
  end;
 end;
 FColumnar.CutColumns:=Not FAutoResizeColumns;
 FColumnar.AddColumn(Width,Expression,ExpFormat,Caption,CaptionFormat,
  SumaryExpression,SumaryFormat);
end;

function TReportReport.Get_AutoResizeColumns: WordBool;
begin
 Result:=FAutoResizeColumns;
end;

procedure TReportReport.Set_AutoResizeColumns(Value: WordBool);
begin
 FAutoResizeColumns:=Value;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TReportReport, Class_ReportReport,
    ciInternal, tmSingle);
end.
