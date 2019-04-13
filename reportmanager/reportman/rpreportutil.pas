{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
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

unit rpreportutil;

interface

{$I rpconf.inc}

uses Classes,rpbasereport,sysutils,rptypes,rpsubreport,rpsection,rpmdconsts,
 rpdatainfo,rpparams,rplabelitem,rpdrawitem,rpeval,rptypeval,
 rpmetafile,rpmdbarcode,rpprintitem,rpreport,
 rpalias,db;


function CreateReportFromDataSet(adata:TDataset):TRpReport;
function CreateReportStreamFromDataSet(adata:TDataset):TMemoryStream;

implementation

function CreateReportStreamFromDataSet(adata:TDataset):TmemoryStream;
begin
 Result:=TMemoryStream.Create;
 try
  CreateReportFromDataset(adata).SaveToStream(Result);
  Result.Seek(0,soFromBeginning);
 except
  Result.free;
  raise;
 end;
end;

function CreateReportFromDataSet(adata:TDataset):TRpReport;
var
 areport:TRpReport;
 i:integer;
 subrep:TRpSubReport;
 dbinfo:TRpDatabaseInfoItem;
 dinfo:TRpDataInfoItem;
 alabel:TRpLabel;
 aexp:TRpExpression;
 awidth:integer;
 f:TField;
 asize:integer;
 apos:integer;
begin
 areport:=TRpReport.Create(nil);
 try
  areport.Createnew;
  areport.PageOrientation:=rpOrientationLandscape;
  subrep:=areport.SubReports.Items[0].SubReport;
  subrep.Sections[0].Section.Height:=200;
  subrep.Sections[0].Section.AutoExpand:=true;
  subrep.Sections[0].Section.PageRepeat:=true;
  subrep.AddGroup('TOTAL');
  subrep.Sections[0].Section.height:=200;
  subrep.Sections[2].Section.height:=0;
  dbinfo:=areport.DatabaseInfo.Add('DATABASE');
  dinfo:=areport.DataInfo.Add('DATASET');
  dinfo.DatabaseAlias:='DATABASE';
  subrep.Alias:='DATASET';
  apos:=0;
  for i:=0 to adata.Fields.Count-1 do
  begin
   f:=adata.Fields[i];
   asize:=0;
   case f.DataType of
    ftString,ftFixedChar,ftWideString:
      begin
       asize:=f.DisplayWidth;
      end;
    ftSmallint,ftInteger,ftWord,ftLargeInt:
      asize:=8;
    ftFloat,ftCurrency,ftBCD:
      asize:=13;
    ftDate,ftTime:
      asize:=10;
    ftDateTime:
      asize:=14;
   end;
   asize:=asize*150;
   if ((asize+apos)>16000) then
    asize:=16000-apos;
   alabel:=TRpLabel(subrep.Sections[0].Section.AddComponent(TRpLabel));
   alabel.PosX:=apos;
   alabel.FontStyle:=5;
   alabel.Text:=f.DisplayLabel;
   alabel.Width:=asize;
   alabel.Height:=200;
   aexp:=TRpExpression(subrep.Sections[1].Section.AddComponent(TRpExpression));
   aexp.Expression:='DATASET'+'.'+f.FieldName;
   aexp.PosX:=alabel.Posx;
   aexp.WordWrap:=true;
   aexp.Width:=alabel.Width;
   aexp.Height:=alabel.Height;
   aexp.AutoExpand:=true;
   apos:=apos+asize;
   if apos>=16000 then
    break;
  end;
 except
  areport.free;
  raise;
 end;
 Result:=areport;
end;

initialization
end.
