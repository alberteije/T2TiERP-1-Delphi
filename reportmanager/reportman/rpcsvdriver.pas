{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpcsvdriver                                     }
{       Exports a metafile to a csv file                }
{                                                       }
{       Copyright (c) 1994-2004 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpcsvdriver;

interface

{$I rpconf.inc}

uses
 Classes,sysutils,rpmetafile,rpmdconsts,
 rpmunits,
 rppdffile,
{$IFDEF USEVARIANTS}
 types,Variants,
{$ENDIF}
{$IFNDEF FORWEBAX}
 rpbasereport,rppdfdriver,
{$ENDIF}
 rptypes;


const
 CSV_PRECISION=100;



{$IFNDEF FORWEBAX}
procedure ExportReportToCSV(report:TRpBaseReport;filename:String;progress:Boolean;separator:string);
procedure ExportReportToTextProStream(report:TRpBaseReport;stream:TStream;progress:Boolean);
procedure ExportReportToTextPro(report:TRpBaseReport;filename:String;progress:Boolean);
procedure ExportReportToCSVStream(report:TRpBaseReport;stream:TStream;progress:Boolean;separator:string);
{$ENDIF}
function ExportMetafileToCSV (metafile:TRpMetafileReport; filename:string;
 showprogress,allpages:boolean; frompage,topage:integer;separator:string):boolean;
function ExportMetafileToCSVStream (metafile:TRpMetafileReport; stream:TStream;
 showprogress,allpages:boolean; frompage,topage:integer;separator:string):boolean;
function ExportMetafileToTextPro (metafile:TRpMetafileReport; filename:string;
 showprogress,allpages:boolean; frompage,topage:integer):boolean;
function ExportMetafileToTextProStream (metafile:TRpMetafileReport; stream:TStream;
 showprogress,allpages:boolean; frompage,topage:integer):boolean;


implementation

type TArray2String=array of array of string;

procedure PrintObject(var pmatrix:TArray2String;page:TRpMetafilePage;obj:TRpMetaObject;
 rows,columns:TStringList);
var
 aansitext:string;
 arow,acolumn:integer;
 leftstring,topstring:String;
begin
 topstring:=FormatCurr('0000000000',obj.Top/CSV_PRECISION);
 leftstring:=FormatCurr('0000000000',obj.Left/CSV_PRECISION);
 arow:=rows.IndexOf(topstring);
 acolumn:=columns.IndexOf(leftstring);
 if acolumn<0 then
  acolumn:=0;
 if arow<0 then
  arow:=0;
 case obj.Metatype of
  rpMetaText:
   begin
    aansitext:=page.GetText(Obj);
    // If it's a number
    pmatrix[arow,acolumn]:=aansitext;
   end;
  rpMetaDraw:
   begin
   end;
  rpMetaImage:
   begin
   end;
 end;
end;

function ExportMetafileToCSVStream (metafile:TRpMetafileReport; stream:TStream;
 showprogress,allpages:boolean; frompage,topage:integer;separator:string):boolean;
var
 i:integer;
 j,k:integer;
 pmatrix:TArray2String;
 apage:TRpMetafilePage;
 columns:TStringList;
 rows:TStringList;
 index:integer;
 topstring,leftstring,srow:string;
begin
 if allpages then
 begin
  metafile.RequestPage(MAX_PAGECOUNT);
  frompage:=0;
  topage:=metafile.CurrentPageCount-1;
 end
 else
 begin
  frompage:=frompage-1;
  topage:=topage-1;
  metafile.RequestPage(topage);
  if topage>metafile.CurrentPageCount-1 then
   topage:=metafile.CurrentPageCount-1;
 end;
 // Distribute in rows and columns
 columns:=TStringList.Create;
 rows:=TStringList.Create;
 try
   rows.sorted:=true;
   columns.sorted:=true;
   for i:=frompage to topage do
   begin
    apage:=metafile.Pages[i];
    rows.clear;
    columns.clear;
    for j:=0 to apage.ObjectCount-1 do
    begin
     if apage.Objects[j].Metatype in [rpMetaText] then
     begin
      topstring:=FormatCurr('0000000000',apage.Objects[j].Top/CSV_PRECISION);
      leftstring:=FormatCurr('0000000000',apage.Objects[j].Left/CSV_PRECISION);
      index:=rows.IndexOf(topstring);
      if index<0 then
       rows.Add(topstring);
      index:=columns.IndexOf(leftstring);
      if index<0 then
       columns.Add(leftstring);
     end;
    end;
    SetLength(pmatrix,rows.Count);
    for j:=0 to rows.Count-1 do
    begin
     SetLength(pmatrix[j],columns.Count);
     for k:=0 to columns.Count-1 do
     begin
      pmatrix[j,k]:='';
     end;
    end;
    for j:=0 to apage.ObjectCount-1 do
    begin
     PrintObject(pmatrix,apage,apage.Objects[j],
      rows,columns);
    end;
    for j:=0 to rows.count-1 do
    begin
     srow:='';
     if columns.count>0 then
     begin
      srow:=AnsiQuotedStr(pmatrix[j,0],'"');
      for k:=1 to columns.Count-1 do
      begin
       srow:=srow+separator+AnsiQuotedStr(pmatrix[j,k],'"');
      end;
     end;
     srow:=srow+#13+#10;
     WriteStringToStream(srow,stream);
    end;
    // Skip page is a skip line
    srow:=#13+#10;
    WriteStringToStream(srow,stream);
   end;
 finally
  columns.free;
  rows.free;
 end;
 Result:=true;
end;

function ExportMetafileToCSV (metafile:TRpMetafileReport; filename:string;
 showprogress,allpages:boolean; frompage,topage:integer;separator:string):boolean;
var
 memstream:TMemoryStream;
begin
 memstream:=TMemoryStream.Create;
 try
  ExportMetafileToCSVStream(metafile,memstream,showprogress,allpages,frompage,topage,separator);
  memstream.Seek(0,soFromBeginning);
  memstream.SaveToFile(filename);
 finally
  memstream.free;
 end;
 Result:=true;
end;

function ExportMetafileToTextPro (metafile:TRpMetafileReport; filename:string;
 showprogress,allpages:boolean; frompage,topage:integer):boolean;
var
 memstream:TMemoryStream;
begin
 memstream:=TMemoryStream.Create;
 try
  ExportMetafileToTextProStream(metafile,memstream,showprogress,allpages,frompage,topage);
  memstream.Seek(0,soFromBeginning);
  memstream.SaveToFile(filename);
 finally
  memstream.free;
 end;
 Result:=true;
end;

function ExportMetafileToTextProStream (metafile:TRpMetafileReport; stream:TStream;
 showprogress,allpages:boolean; frompage,topage:integer):boolean;
var
 alist:TStringList;
 i,j,z:integer;
 apage:TrpMetafilePage;
 aobj:TRpMetaObject;
 atext:String;
 originaltext:String;
 aline:Integer;
begin
 alist:=TStringList.Create;
 try
  if allpages then
  begin
   metafile.RequestPage(MAX_PAGECOUNT);
   frompage:=0;
   topage:=metafile.CurrentPageCount-1;
  end
  else
  begin
   frompage:=frompage-1;
   topage:=topage-1;
   metafile.RequestPage(topage);
   if topage>metafile.CurrentPageCount-1 then
    topage:=metafile.CurrentPageCount-1;
  end;
  for i:=frompage to topage do
  begin
   apage:=metafile.Pages[i];
   for j:=0 to apage.ObjectCount-1 do
   begin
    aobj:=apage.Objects[j];
    if aobj.Metatype in [rpMetaExport] then
    begin
     if aobj.Line<=0 then
      aobj.Line:=alist.Count;
     if aobj.Line<=0 then
      aobj.Line:=1;
     if aobj.Position<=0 then
      aobj.Position:=1;
     if aobj.Size>0 then
     begin
      atext:=String(apage.GetText(aobj));
      while Length(atext)<aobj.Size do
       atext:=atext+' ';
      atext:=Copy(atext,1,aobj.size);
      aline:=aobj.Line-1;
      while alist.Count<=aline do
       alist.Add('');
      originaltext:=alist.Strings[aline];
      while Length(originaltext)<aobj.Position+aobj.Size-1 do
       originaltext:=originaltext+' ';
      for z:=1 to Length(atext) do
      begin
       originaltext[aobj.Position+z-1]:=atext[z];
      end;
      alist.Strings[aline]:=originaltext;
      if aobj.DoNewLine then
       alist.Add('');
     end;
    end;
   end;
  end;
//  originaltext:=alist.GetText;
  alist.SaveToStream(Stream);
//  Stream.Write(originaltext[1],Length(originaltext)-2)
 finally
  alist.free;
 end;
 Result:=true;
end;

{$IFNDEF FORWEBAX}
procedure ExportReportToCSV(report:TRpBaseReport;filename:String;progress:Boolean;separator:string);
var
 astream:TMemoryStream;
begin
 astream:=TMemoryStream.Create;
 try
  ExportReportToCSVStream(report,astream,progress,separator);
  astream.Seek(0,soFromBeginning);
  astream.SaveToFile(filename);
 finally
  astream.free;
 end;
end;


procedure ExportReportToCSVStream(report:TRpBaseReport;stream:TStream;progress:Boolean;separator:string);
var
 pdfdriver:TRpPDFDriver;
 apdfdriver:TRpPrintDriver;
 oldprogres:TRpProgressEvent;
 astream:TMemoryStream;
 oldtwopass:boolean;
begin
 pdfdriver:=TRpPDFDriver.Create;
 pdfdriver.compressed:=true;
 astream:=TMemoryStream.Create;
 try
  pdfdriver.DestStream:=aStream;
  apdfdriver:=pdfdriver;
  // If report progress must print progress
  oldprogres:=report.OnProgress;
  try
   if progress then
    report.OnProgress:=pdfdriver.RepProgress;
   oldtwopass:=report.TwoPass;
   try
    report.TwoPass:=true;
    report.PrintAll(apdfdriver);
    astream.SetSize(0);
    ExportMetafileToCSVStream(report.metafile,astream,progress,true,1,999,separator);
    astream.Seek(0,soFromBeginning);
    stream.CopyFrom(astream,astream.size);
   finally
    report.TwoPass:=oldtwopass;
   end;
  finally
   report.OnProgress:=oldprogres;
  end;
 finally
  astream.free;
 end;
end;


procedure ExportReportToTextPro(report:TRpBaseReport;filename:String;progress:Boolean);
var
 astream:TMemoryStream;
begin
 astream:=TMemoryStream.Create;
 try
  ExportReportToTextProStream(report,astream,progress);
  astream.Seek(0,soFromBeginning);
  astream.SaveToFile(filename);
 finally
  astream.free;
 end;
end;

procedure ExportReportToTextProStream(report:TRpBaseReport;stream:TStream;progress:Boolean);
var
 pdfdriver:TRpPDFDriver;
 apdfdriver:TRpPrintDriver;
 oldprogres:TRpProgressEvent;
 astream:TMemoryStream;
 oldtwopass:boolean;
begin
 pdfdriver:=TRpPDFDriver.Create;
 pdfdriver.compressed:=true;
 astream:=TMemoryStream.Create;
 try
  pdfdriver.DestStream:=aStream;
  apdfdriver:=pdfdriver;
  // If report progress must print progress
  oldprogres:=report.OnProgress;
  try
   if progress then
    report.OnProgress:=pdfdriver.RepProgress;
   oldtwopass:=report.TwoPass;
   try
    report.TwoPass:=true;
    report.PrintAll(apdfdriver);
    ExportMetafileToTextProStream(report.metafile,astream,progress,true,1,MAX_PAGECOUNT);
    astream.Seek(0,soFromBeginning);
    stream.CopyFrom(astream,astream.size);
   finally
    report.TwoPass:=oldtwopass;
   end;
  finally
   report.OnProgress:=oldprogres;
  end;
 finally
  astream.free;
 end;
end;
{$ENDIF}



end.

