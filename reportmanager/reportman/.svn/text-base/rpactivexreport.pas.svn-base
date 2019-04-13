{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpactivexreport                                 }
{       Base for ActiveX Report                         }
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

unit rpactivexreport;

interface

{$I rpconf.inc}
uses
  Windows, Messages, SysUtils, Classes, Controls,Forms,
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
  rpvclreport,Graphics,rpreport,rpmdconsts;


const
 AX_CONSWIDTH=75;
 AX_CONSHEIGHT=20;

type
  TRpActiveXReport = class(TCustomControl)
  private
    { Private declarations }
    FVCLReport:TVCLReport;
    FFilename:String;
    FPreview:boolean;
    FTitle:string;
    FLanguage:integer;
    FSHowProgress:boolean;
    FShowPrintDIalog:boolean;
    FAsyncExecution:boolean;
    procedure SetFilename(Value:string);
    procedure SetPreview(Value:boolean);
    procedure SetAsyncExecution(Value:boolean);
    procedure SetShowProgress(Value:boolean);
    procedure SetShowPrintDialog(Value:boolean);
    procedure SetTitle(Value:string);
    procedure SetLanguage(Value:integer);
  protected
    { Protected declarations }
    procedure Paint;override;
  public
   procedure SetDatasetSQL(datasetname:string;sqlsentence:string);
   procedure SetDatabaseConnectionString(databasename:string;connectionstring:string);
   function GetDatasetSQL(datasetname:string):string;
   function GetDatabaseConnectionString(databasename:string):string;
   procedure SetParamValue(paramname:string;paramvalue:Variant);
   function GetParamValue(paramname:string):Variant;
   function Execute:Boolean;
   procedure PrinterSetup;
   function ShowParams:boolean;
   procedure SaveToPDF(filename:string;compressed:boolean=false);
   procedure SaveToText(filename:string;textdriver:String);
   procedure SaveToMetafile(filename:string);
   procedure SaveToHTML(filename:string);
   procedure SaveToHTMLSingle(filename:string);
   procedure SaveToCustomText(filename:string);
   procedure SaveToSVG(filename:string);
   procedure SaveToCSV(filename:string);
   procedure SaveToCSV2(filename:string;separator:string);
   function PrintRange(frompage:integer;topage:integer;
    copies:integer;collate:boolean):boolean;
   procedure ExecuteRemote(hostname:String;port:integer;user,password,aliasname,reportname,sql:String);
   procedure GetRemoteParams(hostname:String;port:integer;user,password,aliasname,reportname:String);
   procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);override;
   constructor Create(AOwner:TComponent);override;
   function GetReport:TRpReport;
{$IFNDEF DOTNETD}
   procedure SetRecordset(datasetname:string; recordset: Pointer);
{$ENDIF}
   { Public declarations }
  published
    { Published declarations }
    property Filename:string read FFilename write SetFilename;
    property Preview:boolean read FPreview write SetPreview default true;
    property AsyncExecution:boolean read FAsyncExecution write SetAsyncExecution default false;
    property ShowProgress:boolean read FShowProgress write SetShowProgress;
    property ShowPrintDialog:boolean read FShowPrintDialog write SetShowPrintDialog;
    property Title:string read FTitle write SetTitle;
    property Language:integer read FLanguage write SetLanguage;
  end;


implementation

procedure TRpActiveXReport.Paint;
begin
 Canvas.Brush.Color:=clWhite;
 Canvas.Pen.Color:=clBlack;
 Canvas.Rectangle(ClientRect);
 Canvas.TextOut(2,2,'ReportManX');
end;

procedure TRpActiveXReport.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
 AWidth:=AX_CONSWIDTH;
 AHeight:=AX_CONSHEIGHT;
 inherited SetBounds(ALeft,ATop,AWidth,AHeight);
end;

constructor TRpActiveXReport.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 Width:=AX_CONSWIDTH;
 Height:=AX_CONSHEIGHT;
 FVCLReport:=TVCLReport.Create(Self);
end;

procedure TRpActiveXReport.SetFilename(Value:string);
begin
 FVCLReport.Filename:=Value;
 FFilename:=Value;
end;

procedure TRpActiveXReport.SetPreview(Value:boolean);
begin
 FVCLReport.Preview:=Value;
 FPreview:=Value;
end;

procedure TRpActiveXReport.SetAsyncExecution(Value:boolean);
begin
 FVCLReport.AsyncExecution:=Value;
 FAsyncExecution:=Value;
end;

function TRpActiveXReport.Execute:boolean;
begin
 Result:=FVCLReport.Execute;
end;

procedure TRpActiveXReport.ExecuteRemote(hostname:String;port:integer;user,password,aliasname,reportname,sql:String);
begin
 FVCLReport.ExecuteRemote(hostname,port,user,password,aliasname,reportname,sql);
end;

procedure TRpActiveXReport.GetRemoteParams(hostname:String;port:integer;user,password,aliasname,reportname:String);
begin
 FVCLReport.GetRemoteParams(hostname,port,user,password,aliasname,reportname);
end;

function TRpActiveXReport.GetReport:TRpReport;
begin
 Result:=FVCLReport.Report;
end;

procedure TRpActiveXReport.SetShowProgress(Value:Boolean);
begin
 FVCLReport.ShowProgress:=Value;
 FShowProgress:=Value;
end;

procedure TRpActiveXReport.SetShowPrintDialog(Value:boolean);
begin
 FVCLReport.ShowPrintDialog:=Value;
 FShowProgress:=Value;
end;

procedure TRpActiveXReport.SetTitle(Value:string);
begin
 FVCLReport.Title:=Value;
 FTitle:=Value;
end;

procedure TRpActiveXReport.SetLanguage(Value:integer);
begin
 FVCLReport.Language:=Value;
 FLanguage:=Value;
end;

procedure TRpActiveXReport.PrinterSetup;
begin
 FVCLReport.PrinterSetup;
end;

function TRpActiveXReport.ShowParams:boolean;
begin
 Result:=FVCLReport.ShowParams;
end;

procedure TRpActiveXReport.SaveToPDF(filename:string;compressed:boolean=false);
begin
 FVCLReport.SaveToPDF(filename,compressed);
end;

procedure TRpActiveXReport.SaveToText(filename:string;textdriver:String);
begin
 FVCLReport.SaveToText(filename,textdriver);
end;

procedure TRpActiveXReport.SaveToMetafile(filename:string);
begin
 FVCLReport.SaveToMetafile(filename);
end;

procedure TRpActiveXReport.SaveToHTML(filename:string);
begin
 FVCLReport.SaveToHtml(filename);
end;

procedure TRpActiveXReport.SaveToHTMLSingle(filename:string);
begin
 FVCLReport.SaveToHtmlSingle(filename);
end;

procedure TRpActiveXReport.SaveToCustomText(filename:string);
begin
 FVCLReport.SaveToCustomText(filename);
end;

procedure TRpActiveXReport.SaveToSVG(filename:string);
begin
 FVCLReport.SaveToSVG(filename);
end;

procedure TRpActiveXReport.SaveToCSV(filename:string);
begin
 FVCLReport.SaveToCSV(filename);
end;

procedure TRpActiveXReport.SaveToCSV2(filename:string;separator:string);
begin
 FVCLReport.SaveToCSV(filename,separator);
end;


function TRpActiveXReport.PrintRange(frompage:integer;topage:integer;
    copies:integer;collate:boolean):boolean;
begin
 Result:=FVCLReport.PrintRange(frompage,topage,copies,collate);
end;

procedure TRpActiveXReport.SetDatabaseConnectionString(databasename:string;connectionstring:string);
var
 index:integer;
begin
 index:=FVCLReport.Report.DatabaseInfo.IndexOf(databasename);
 if index<0 then
  Raise Exception.Create(SRpDatabaseNotExists+':'+databasename);
 FVCLReport.Report.DatabaseInfo.Items[index].ADOConnectionString:=connectionstring;
end;

procedure TRpActiveXReport.SetDatasetSQL(datasetname:string;sqlsentence:string);
var
 index:integer;
begin
 index:=FVCLReport.Report.DataInfo.IndexOf(datasetname);
 if index<0 then
  Raise Exception.Create(SRpDatasetNotExists+':'+datasetname);
 FVCLReport.Report.DataInfo.Items[index].SQL:=sqlsentence;
end;

procedure TRpActiveXReport.SetParamValue(paramname:string;paramvalue:Variant);
begin
 FVCLReport.Report.Params.ParamByName(paramname).Value:=paramvalue;
end;

function TRpActiveXReport.GetDatasetSQL(datasetname:string):string;
var
 index:integer;
begin
 index:=FVCLReport.Report.DataInfo.IndexOf(datasetname);
 if index<0 then
  Raise Exception.Create(SRpDatasetNotExists+':'+datasetname);
 Result:=FVCLReport.Report.DataInfo.Items[index].SQL;
end;

function TRpActiveXReport.GetDatabaseConnectionString(databasename:string):string;
var
 index:integer;
begin
 index:=FVCLReport.Report.DatabaseInfo.IndexOf(databasename);
 if index<0 then
  Raise Exception.Create(SRpDatabaseNotExists+':'+databasename);
 Result:=FVCLReport.Report.DatabaseInfo.Items[index].ADOConnectionString;
end;

function TRpActiveXReport.GetParamValue(paramname:string):Variant;
begin
 Result:=FVCLReport.Report.Params.ParamByName(paramname).Value;
end;

{$IFNDEF DOTNETD}
procedure TRpActiveXReport.SetRecordset(datasetname:string; recordset: Pointer);
var
 index:integer;
begin
 index:=FVCLReport.Report.DataInfo.IndexOf(datasetname);
 if index<0 then
  Raise Exception.Create(SRpDatasetNotExists+':'+datasetname);
{$IFDEF USEADO}
 FVCLReport.Report.DataInfo.Items[index].externalDataset:=recordset;
 // maybe reste params...
 //FVCLReport.Report.DataInfo.Items[index].SQL := '';
{$ENDIF}
end;
{$ENDIF}
initialization
 Application.UpdateFormatSettings:=false;
end.

