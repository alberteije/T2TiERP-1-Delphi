unit rpaxreportparameters;

interface

uses
  ComObj, ActiveX, reportman_TLB, StdVcl,rpreport,rpaxreportparam;

type
  TReportParameters = class(TAutoObject, IReportParameters)
  private
   FReportParam:TReportParam;
  protected
    function Get_Count: Integer; safecall;
    function Get_Items(Index: Integer): ReportParam; safecall;
    function ParamExists(const paramname: WideString): WordBool; safecall;
    { Protected declarations }
  public
   FReport:TRpReport;
  end;

implementation

uses ComServ;

function TReportParameters.Get_Count: Integer;
begin
 Result:=FReport.Params.Count;
end;

function TReportParameters.Get_Items(Index: Integer): ReportParam;
begin
 If NOt Assigned(FReportParam) then
 begin
  FReportParam:=TReportParam.Create;
 end;
 FReportParam.FParam:=FReport.Params.Items[index];
 Result:=FReportParam;
 Result._AddRef;
end;

function TReportParameters.ParamExists(
  const paramname: WideString): WordBool;
begin
 Result:=FReport.Params.FindParam(paramname)<>nil;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TReportParameters, Class_ReportParameters,
    ciInternal,tmSingle);
end.
