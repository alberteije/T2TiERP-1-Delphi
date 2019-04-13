unit rpaspserver;

interface

uses
  Classes,ComObj, ActiveX, AspTlb, reportman_TLB, StdVcl,
  rpreport,rppdfdriver,rpcsvdriver,rptextdriver;

type
  TReportmanXAServer = class(TASPMTSObject, IReportmanXAServer)
  protected
    procedure GetPDF(const Report: IReportReport; Compressed: WordBool);
      safecall;
    procedure GetCustomText(const Report: IReportReport); safecall;
    procedure GetText(const Report: IReportReport); safecall;
    procedure GetCSV(const Report: IReportReport); safecall;
    procedure GetCSV2(const Report: IReportReport;
      const separator: WideString); safecall;
    procedure GetMetafile(const Report: IReportReport); safecall;
  end;

implementation

uses ComServ, SysUtils;

procedure TReportmanXAServer.GetPDF(const Report: IReportReport;
  Compressed: WordBool);
var
 areport:TRpReport;
 memstream:TMemoryStream;
 abyte:array of byte;
begin
 areport:=TRpReport(Report.VCLReport);
 memstream:=TMemoryStream.Create;
 try
  rppdfdriver.PrintReportPDFStream(areport,'',false,true,
   1,99999,1,memstream,Compressed,false);
  memstream.Seek(0,soFromBeginning);

  Response.Clear;
  Response.ContentType := 'application/pdf';
  SetLength(abyte,memstream.size);
  memstream.Seek(0,soFromBeginning);
  memstream.Read(abyte[0],memstream.size);
  Response.BinaryWrite(abyte);
 finally
  memstream.free;
 end;
end;

procedure TReportmanXAServer.GetCustomText(const Report: IReportReport);
var
 areport:TRpReport;
 memstream:TMemoryStream;
 astring:String;
begin
 areport:=TRpReport(Report.VCLReport);
 memstream:=TMemoryStream.Create;
 try
  rpcsvdriver.ExportReportToTextProStream(areport,memstream,false);
  memstream.Seek(0,soFromBeginning);
  Response.Clear;
  Response.ContentType := 'text/plain';
  SetLength(astring,memstream.size);
  memstream.Read(astring[1],memstream.size);
  Response.BinaryWrite(astring);
 finally
  memstream.free;
 end;
end;

procedure TReportmanXAServer.GetText(const Report: IReportReport);
var
 areport:TRpReport;
 memstream:TMemoryStream;
 astring:String;
begin
 areport:=TRpReport(Report.VCLReport);
 memstream:=TMemoryStream.Create;
 try
  rptextdriver.PrintReportToStream(areport,'',false,true,1,99999,1,memstream,
   false,false,'PLAIN');
  memstream.Seek(0,soFromBeginning);
  Response.Clear;
  Response.ContentType := 'text/plain';
  SetLength(astring,memstream.size);
  memstream.Read(astring[1],memstream.size);
  Response.BinaryWrite(astring);
 finally
  memstream.free;
 end;
end;

procedure TReportmanXAServer.GetCSV2(const Report: IReportReport;
  const separator: WideString);
var
 areport:TRpReport;
 memstream:TMemoryStream;
 astring:String;
begin
 areport:=TRpReport(Report.VCLReport);
 memstream:=TMemoryStream.Create;
 try
  rpcsvdriver.ExportReportToCSVStream(areport,memstream,false,separator);
  memstream.Seek(0,soFromBeginning);
  Response.Clear;
  Response.ContentType := 'text/plain';
  SetLength(astring,memstream.size);
  memstream.Read(astring[1],memstream.size);
  Response.BinaryWrite(astring);
 finally
  memstream.free;
 end;
end;

procedure TReportmanXAServer.GetCSV(const Report: IReportReport);
var
 areport:TRpReport;
 memstream:TMemoryStream;
 astring:String;
begin
 areport:=TRpReport(Report.VCLReport);
 memstream:=TMemoryStream.Create;
 try
  rpcsvdriver.ExportReportToCSVStream(areport,memstream,false,',');
  memstream.Seek(0,soFromBeginning);
  Response.Clear;
  Response.ContentType := 'text/plain';
  SetLength(astring,memstream.size);
  memstream.Read(astring[1],memstream.size);
  Response.BinaryWrite(astring);
 finally
  memstream.free;
 end;
end;

procedure TReportmanXAServer.GetMetafile(const Report: IReportReport);
var
 areport:TRpReport;
 memstream:TMemoryStream;
 abyte:array of byte;
begin
 areport:=TRpReport(Report.VCLReport);
 memstream:=TMemoryStream.Create;
 try
  rppdfdriver.PrintReportMetafileStream(areport,'',false,true,
   1,99999,1,memstream,false,false);
  memstream.Seek(0,soFromBeginning);

  Response.Clear;
  Response.ContentType := 'application/rpmf';
  SetLength(abyte,memstream.size);
  memstream.Seek(0,soFromBeginning);
  memstream.Read(abyte[0],memstream.size);
  Response.BinaryWrite(abyte);
 finally
  memstream.free;
 end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TReportmanXAServer, Class_ReportmanXAServer,
    ciMultiInstance, tmSingle);
end.
