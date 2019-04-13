unit rpaxreportparam;

{$I rpconf.inc}

interface

uses
  ComObj, ActiveX, reportman_TLB, StdVcl,rpparams,
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
  rptypes;

type                    
  TReportParam = class(TAutoObject, IReportParam)
  protected
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Value: WideString); safecall;
    function Get_Description: WideString; safecall;
    function Get_ParamType: TxParamType; safecall;
    function Get_Value: OleVariant; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Description(const Value: WideString); safecall;
    procedure Set_ParamType(Value: TxParamType); safecall;
    procedure Set_Value(Value: OleVariant); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    { Protected declarations }
  public
   FParam:TRpParam;
  end;

implementation

uses ComServ;

function TReportParam.Get_Name: WideString;
begin
 Result:=FParam.Name;
end;

procedure TReportParam.Set_Name(const Value: WideString);
begin
 FParam.Name:=Value;
end;

function TReportParam.Get_Description: WideString;
begin
 Result:=FParam.Description;
end;

function TReportParam.Get_ParamType: TxParamType;
begin
 Result:=TxParamType(FParam.ParamType);
end;

function TReportParam.Get_Value: OleVariant;
begin
 Result:=FParam.Value;
end;

function TReportParam.Get_Visible: WordBool;
begin
 Result:=FParam.Visible;
end;

procedure TReportParam.Set_Description(const Value: WideString);
begin
 FParam.Description:=Value;
end;

procedure TReportParam.Set_ParamType(Value: TxParamType);
begin
 FParam.ParamType:=TRpParamtype(Value);
end;

procedure TReportParam.Set_Value(Value: OleVariant);
begin
 FParam.Value:=Value;
end;

procedure TReportParam.Set_Visible(Value: WordBool);
begin
 FParam.Visible:=Value;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TReportParam, Class_ReportParam,
    ciInternal, tmSingle);
end.
