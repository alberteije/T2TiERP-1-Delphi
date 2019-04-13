{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpdesigneditors                                 }
{       Design time editors for Report Components       }
{       designment of reports                           }
{                                                       }
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

unit rpmdesigneditors;

{$I rpconf.inc}

interface

uses Classes,SysUtils,rptypes,rpcompobase,rpalias,rpdatainfo,DB,rpeval,
{$IFDEF MSWINDOWS}
 rpmdfopenlibvcl,rprfvparams,rpexpredlgvcl,Dialogs,
{$ENDIF}
{$IFDEF LINUX}
 rpmdfopenlib,rprfparams,rpexpredlg,QDialogs,
{$ENDIF}
{$IFNDEF DOTNETD}
 {$IFDEF USEVARIANTS}
  Designintf,
  DesignEditors,
 {$ENDIF}
 {$IFNDEF USEVARIANTS}
  Dsgnintf,
 {$ENDIF}
{$ENDIF}
{$IFDEF DOTNETD}
  Borland.Vcl.Design.DesignIntf,
  Borland.Vcl.Design.DesignEditors,
{$ENDIF}
 TypInfo;

type
  TRpReportLibNamePropEditor=class(TPropertyEditor)
  protected
  public
   function GetAttributes:TPropertyAttributes;override;
   procedure GetValues(Proc: TGetStrProc); override;
   function GetValue: string;override;
   procedure SetValue(const Value: string); override;
  end;

  TRpReportNamePropEditor=class(TPropertyEditor)
  protected
  public
   function GetAttributes:TPropertyAttributes;override;
   procedure Edit;override;
   function GetValue: string;override;
   procedure SetValue(const Value: string); override;
  end;

  TRpExpressionPropEditor=class(TPropertyEditor)
  protected
  public
   function GetAttributes:TPropertyAttributes;override;
   procedure Edit;override;
   function GetValue: string;override;
   procedure SetValue(const Value: string); override;
  end;

  TRpBaseComponentEditor=class(TComponentEditor)
  protected
  public
   procedure Edit;override;
   function GetVerbCount:integer;override;
   function GetVerb(Index:integer):string;override;
   procedure ExecuteVerb(Index:Integer);override;
  end;

  TRpEvalComponentEditor=class(TComponentEditor)
  protected
  public
   procedure Edit;override;
   function GetVerbCount:integer;override;
   function GetVerb(Index:integer):string;override;
   procedure ExecuteVerb(Index:Integer);override;
  end;


implementation


procedure TRpBaseComponentEditor.Edit;
begin
 if Component is TCBaseReport then
  (Component As TCBaseReport).Execute;
end;

function TRpBaseComponentEditor.GetVerbCount:integer;
begin
 Result:=3;
end;

function TRpBaseComponentEditor.GetVerb(Index:integer):string;
begin
 case index of
  0:
   Result:='Execute';
  1:
   Result:='Preview';
  2:
   Result:='Parameters';
 end;
end;

procedure TRpBaseComponentEditor.ExecuteVerb(Index:Integer);
var
 oldpreview:Boolean;
begin
 case index of
  0:
   (Component As TCBaseReport).Execute;
  1:
   begin
    oldpreview:=(Component As TCBaseReport).Preview;
    try
     (Component As TCBaseReport).Preview:=true;
     (Component As TCBaseReport).Execute;
    finally
     (Component As TCBaseReport).Preview:=oldpreview;
    end;
   end;
  2:
   begin
    ShowUserParams((Component As TCBaseReport).Report.Params);
   end;
 end;
end;


procedure TRpEvalComponentEditor.Edit;
begin
 if Component is TRpEvaluator then
 begin
  (Component As TRpEvaluator).Evaluate;
  ShowMessage((Component As TRpEvaluator).EvalResultString);
 end;
end;

function TRpEvalComponentEditor.GetVerbCount:integer;
begin
 Result:=2;
end;

function TRpEvalComponentEditor.GetVerb(Index:integer):string;
begin
 case index of
  0:
   Result:='Evaluate';
  1:
   Result:='Edit expression';
 end;
end;

procedure TRpEvalComponentEditor.ExecuteVerb(Index:Integer);
begin
 case index of
  0:
   begin
    (Component As TRpEvaluator).Evaluate;
    ShowMessage((Component As TRpEvaluator).EvalResultString);
   end;
  1:
   begin
    (Component As TRpEvaluator).Expression:=ChangeExpression((Component As TRpEvaluator).Expression,(Component As TRpEvaluator));
   end;
 end;
end;



function TRpReportLibNamePropEditor.GetAttributes:TPropertyAttributes;
begin
 Result:=[paValueList];
end;

procedure TRpReportLibNamePropEditor.GetValues(Proc: TGetStrProc);
var
 i,j:integer;
 acompo:TCBaseReport;
 alist:TStringList;
begin
 inherited;
 alist:=TStringList.Create;
 try
  for i:=0 to PropCount-1 do
  begin
   if (GetComponent(i) is TCBaseReport) then
   begin
    acompo:=GetComponent(i) as TCBaseReport;
    if assigned(acompo.AliasList) then
    begin
     for j:=0 to acompo.AliasList.Connections.Count-1 do
      Proc(acompo.AliasList.Connections.Items[j].Alias);
    end;
   end;
  end;
 finally
  alist.free;
 end;
end;

function TRpReportLibNamePropEditor.GetValue: string;
var
 aname:String;
 i:integer;
 acompo:TCBaseReport;
begin
 aname:='';
 for i:=0 to PropCount-1 do
 begin
  if (GetComponent(i) is TCBaseReport) then
  begin
   acompo:=GetComponent(i) as TCBaseReport;
   if Length(acompo.ConnectionName)<1 then
   begin
    aname:='';
    break;
   end
   else
   begin
    if Length(aname)>0 then
    begin
     if aname<>acompo.ConnectionName then
     begin
      aname:='';
      break;
     end;
    end
    else
     aname:=acompo.ConnectionName;
   end;
  end;
 end;
 Result:=aname;
end;


procedure TRpReportLibNamePropEditor.SetValue(const Value: string);
var
 acompo:TCBaseReport;
 i:integer;
begin
 for i:=0 to PropCount-1 do
 begin
  if (GetComponent(i) is TCBaseReport) then
  begin
   acompo:=GetComponent(i) as TCBaseReport;
   acompo.ConnectionName:=Value;
  end;
 end;
end;


function TRpReportNamePropEditor.GetAttributes:TPropertyAttributes;
begin
 Result:=[paDialog];
end;

procedure TRpReportNamePropEditor.Edit;
var
 i,index:integer;
 acompo:TCBaseReport;
 aliaslist:TRpAlias;
 alibname:String;
 areportname:String;
begin
 inherited;
 aliaslist:=nil;
 alibname:='';
 for i:=0 to PropCount-1 do
 begin
  if (GetComponent(i) is TCBaseReport) then
  begin
   acompo:=GetComponent(i) as TCBaseReport;
   if Length(acompo.ConnectionName)<1 then
   begin
    aliaslist:=nil;
   end
   else
   begin
    if Length(alibname)>0 then
    begin
     if alibname<>UpperCase(acompo.ConnectionName) then
     begin
      aliaslist:=nil;
      break;
     end;
    end
    else
     alibname:=UpperCase(acompo.COnnectionName);
   end;
   if assigned(acompo.AliasList) then
   begin
    if assigned(aliaslist) then
    begin
     if aliaslist<>acompo.Aliaslist then
     begin
      aliaslist:=nil;
      break;
     end;
    end
    else
     aliaslist:=acompo.AliasList;
   end;
  end;
 end;
 if not assigned(aliaslist) then
  exit;
 index:=aliaslist.COnnections.IndexOf(alibname);
 if index<0 then
  exit;
 areportname:=SelectReportFromLibrary(aliaslist.Connections,alibname);
 if Length(areportname)>0 then
 begin
  for i:=0 to PropCount-1 do
  begin
   if (GetComponent(i) is TCBaseReport) then
   begin
    acompo:=GetComponent(i) as TCBaseReport;
    acompo.ReportName:=areportname;
   end;
  end;
 end;
{ dbinfo:=aliaslist.Connections.Items[index];
 adatareports:=
 dbinfo.OpenDatasetFromSQL('SELECT '+dbinfo.ReportSearchField+',REPORT_GROUP FROM '+
 dbinfo.reporttable,nil,false);
 try
  while Not adatareports.Eof do
  begin
   Proc(adatareports.FieldByName('REPORT_NAME').AsString);
   adatareports.Next;
  end;
 finally
  adatareports.free;
 end;
}
end;

function TRpReportNamePropEditor.GetValue: string;
var
 aname:String;
 i:integer;
 acompo:TCBaseReport;
begin
 aname:='';
 for i:=0 to PropCount-1 do
 begin
  if (GetComponent(i) is TCBaseReport) then
  begin
   acompo:=GetComponent(i) as TCBaseReport;
   if Length(acompo.ReportName)<1 then
   begin
    aname:='';
    break;
   end
   else
   begin
    if Length(aname)>0 then
    begin
     if aname<>acompo.Reportname then
     begin
      aname:='';
      break;
     end;
    end
    else
     aname:=acompo.ReportName;
   end;
  end;
 end;
 Result:=aname;
end;

procedure TRpReportNamePropEditor.SetValue(const Value: string);
var
 acompo:TCBaseReport;
 i:integer;
begin
 for i:=0 to PropCount-1 do
 begin
  if (GetComponent(i) is TCBaseReport) then
  begin
   acompo:=GetComponent(i) as TCBaseReport;
   acompo.ReportName:=Value;
  end;
 end;
end;


function TRpExpressionPropEditor.GetAttributes:TPropertyAttributes;
begin
 Result:=[paDialog];
end;

procedure TRpExpressionPropEditor.Edit;
var
 acompo:TRpCustomEvaluator;
 aexpression,newexpression:String;
 i:integer;
begin
 inherited;
 aexpression:='';
 acompo:=nil;
 for i:=0 to PropCount-1 do
 begin
  if (GetComponent(i) is TRpCustomEvaluator) then
  begin
   acompo:=GetComponent(i) as TRpCustomEvaluator;
   if Length(acompo.Expression)<1 then
   begin
    aexpression:='';
    break;
   end
   else
   begin
    if Length(aexpression)>0 then
    begin
     if aexpression<>acompo.Expression then
     begin
      aexpression:='';
      break;
     end;
    end
    else
     aexpression:=acompo.Expression;
   end;
  end;
 end;
 if not assigned(acompo) then
  exit;
 newexpression:=ChangeExpression(aexpression,acompo);
 if newexpression<>aexpression then
 begin
  for i:=0 to PropCount-1 do
  begin
   if (GetComponent(i) is TRpCustomEvaluator) then
   begin
    acompo:=GetComponent(i) as TRpCustomEvaluator;
    acompo.Expression:=newExpression;
   end;
  end;
 end;
end;

function TRpExpressionPropEditor.GetValue: string;
var
 aexpression:String;
 acompo:TRpCustomEvaluator;
 i:integer;
begin
 aexpression:='';
 acompo:=nil;
 for i:=0 to PropCount-1 do
 begin
  if (GetComponent(i) is TRpCustomEvaluator) then
  begin
   acompo:=GetComponent(i) as TRpCustomEvaluator;
   if Length(acompo.Expression)<1 then
   begin
    aexpression:='';
    break;
   end
   else
   begin
    if Length(aexpression)>0 then
    begin
     if aexpression<>acompo.Expression then
     begin
      aexpression:='';
      break;
     end;
    end
    else
     aexpression:=acompo.Expression;
   end;
  end;
 end;
 if not assigned(acompo) then
  Result:=''
 else
  Result:=aexpression;
end;

procedure TRpExpressionPropEditor.SetValue(const Value: string);
var
 acompo:TRpCustomEvaluator;
 i:integer;
begin
 for i:=0 to PropCount-1 do
 begin
  if (GetComponent(i) is TRpCustomEvaluator) then
  begin
   acompo:=GetComponent(i) as TRpCustomEvaluator;
   acompo.Expression:=Value;
  end;
 end;
end;


end.
