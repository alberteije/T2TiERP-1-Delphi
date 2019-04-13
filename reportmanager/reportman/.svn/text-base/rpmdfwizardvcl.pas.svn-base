{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfwizardvcl                                  }
{                                                       }
{       Wizard to create new reports                    }
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

unit rpmdfwizardvcl;

interface

uses
  Windows, Messages, SysUtils,
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,rppagesetupvcl,
  rpmdconsts,rpreport,rpmdfconnectionvcl, ExtCtrls,
  rpmdfdatasetsvcl,rpmdfselectfields;

type
  TFRpWizardVCL = class(TForm)
    PControl: TPageControl;
    TabInstructions: TTabSheet;
    LDesign: TLabel;
    LPass1: TLabel;
    LPass2: TLabel;
    LPass3: TLabel;
    LBegin: TLabel;
    TabConnections: TTabSheet;
    TabDatasets: TTabSheet;
    TabFields: TTabSheet;
    PBottom3: TPanel;
    BCancel: TButton;
    BNext: TButton;
    BFinish: TButton;
    BBack: TButton;
    BPageSetup: TButton;
    procedure BNext1Click(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure BFinishClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BBackClick(Sender: TObject);
    procedure PControlChange(Sender: TObject);
    procedure PControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure BPageSetupClick(Sender: TObject);
  private
    { Private declarations }
    report:TRpReport;
    Created:Boolean;
    conframe:TFRpConnectionVCL;
    dataframe:TFRpDatasetsVCL;
    selframe:TFRpSelectFields;
  public
    { Public declarations }
  end;

function NewReportWizard(report:TRpReport;fromtemplate:boolean):Boolean;

implementation

uses rpcolumnar;

{$R *.dfm}


function NewReportWizard(report:TRpReport;fromtemplate:boolean):boolean;
var
 dia:TFRpWizardVCL;
 i:integer;
begin
 dia:=TFRpWizardVCL.Create(Application);
 try
  if not fromtemplate then
  begin
   report.Createnew;
   report.SubReports[0].SubReport.AddGroup('TOTAL');
   for i:=0 to report.SubReports[0].SubReport.Sections.Count-1 do
   begin
    report.SubReports[0].SubReport.Sections[i].Section.Height:=275;
   end;
  end;
  dia.report:=report;
  dia.ShowModal;
  Result:=dia.Created;
  if (dia.Created and (not fromtemplate)) then
  begin
   if report.DataInfo.Count>0 then
   begin
    report.SubReports[0].SubReport.Alias:=report.DataInfo.Items[0].Alias;
   end;
  end;
 finally
  dia.free;
 end;
end;

procedure TFRpWizardVCL.BNext1Click(Sender: TObject);
var
 allow:boolean;
begin
 if PControl.ActivePageIndex<PControl.PageCount-1 then
 begin
  allow:=true;
  PControlChanging(PControl,allow);
  PControl.ActivePageIndex:=PControl.ActivePageIndex+1;
  PControlChange(PControl);
 end;
end;

procedure TFRpWizardVCL.BCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TFRpWizardVCL.BFinishClick(Sender: TObject);
var
 colrep:TRpColumnar;
 i:integer;
 expformat,captionformat,sumaryexpression,sumaryformat:string;
 expression:string;
begin
 // Creates a new adding columns based on the template
 colrep:=TRpColumnar.Create;
 try
  colrep.Report:=report;
  colrep.CutColumns:=not selframe.CheckProportional.Checked;
  for i:=0 to selframe.LSelected.Items.Count-1 do
  begin
   expression:=selframe.LSelected.Items.Strings[i];
   expformat:='';
   captionformat:='';
   if selframe.LSelected.Checked[i] then
   begin
    sumaryexpression:=expression;
    sumaryformat:='';
   end
   else
   begin
    sumaryexpression:='';
    sumaryformat:='';
   end;
   colrep.AddColumn(StrToInt(selframe.widths.Strings[i]),
    expression,expformat,
    selframe.fieldlabels.Strings[i],captionformat,sumaryexpression,sumaryformat);
  end;
 finally
  colrep.Free;
 end;
 Created:=True;
 Close;
end;

procedure TFRpWizardVCL.FormCreate(Sender: TObject);
begin
 // Load strings
 Caption:=TranslateStr(935,Caption);
 LDesign.Caption:=TranslateStr(869,LDesign.Caption);
 LPass1.Caption:=TranslateStr(870,LPass1.Caption);
 LPass2.Caption:=TranslateStr(871,LPass2.Caption);
 LPass3.Caption:=TranslateStr(872,LPass3.Caption);
// LPass4.Caption:=TranslateStr(873,LPass4.Caption);
 LBegin.Caption:=TranslateStr(874,LBegin.Caption);
 TabInstructions.Caption:=TranslateStr(875,TabInstructions.Caption);
 TabConnections.Caption:=TranslateStr(142,TabConnections.Caption);
 TabDatasets.Caption:=TranslateStr(876,TabDatasets.Caption);
 TabFields.Caption:=TranslateStr(877,TabFields.Caption);
// TabReportType.Caption:=TranslateStr(878,TabReportType.Caption);
 BNext.Caption:=TranslateStr(933,BNext.Caption);
 BBack.Caption:=TranslateStr(934,BBack.Caption);
 BFinish.Caption:=TranslateStr(935,BFinish.Caption);

 // Create the connections frame
 conframe:=TFRpConnectionVCL.Create(Self);
 conframe.Parent:=TabConnections;
 dataframe:=TFRpDatasetsVCL.Create(Self);
 dataframe.Parent:=TabDatasets;
 selframe:=TFRpSelectFields.Create(Self);
 selframe.Parent:=TabFields;
 PControl.ActivePage:=TabInstructions;
 PControlChange(PControl);
end;

procedure TFRpWizardVCL.BBackClick(Sender: TObject);
var
 allow:boolean;
begin
 allow:=true;
 if PControl.ActivePageIndex>0 then
 begin
  PControlChanging(PControl,allow);
  PControl.ActivePageIndex:=PControl.ActivePageIndex-1;
  PControlChange(PControl);
 end;
end;

procedure TFRpWizardVCL.PControlChange(Sender: TObject);
begin
 BBack.Enabled:=PControl.ActivePageIndex>0;
 BNext.Enabled:=PControl.ActivePageIndex<PControl.PageCount-1;
 BFinish.Enabled:=PControl.ActivePageIndex=PControl.PageCount-1;
 if PControl.ActivePage=TabDatasets then
 begin
  dataframe.Databaseinfo:=report.databaseinfo;
  dataframe.Datainfo:=report.DataInfo;
  dataframe.Params:=report.params;
  // Gets the datasets
  dataframe.FillDatasets;
 end;
 if PControl.ActivePage=TabConnections then
 begin
  conframe.Databaseinfo:=report.DatabaseInfo;
 end;
 if PControl.ActivePage=TabFields then
 begin
  selframe.Report:=report;
  selframe.UpdateDatasets;
 end;
end;

procedure TFRpWizardVCL.PControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
 if PControl.ActivePage=TabConnections then
 begin
  report.Databaseinfo.Assign(conframe.DatabaseInfo);
 end;
 if PControl.ActivePage=TabDatasets then
 begin
  report.databaseinfo.Assign(dataframe.Databaseinfo);
  report.DataInfo.Assign(dataframe.Datainfo);
  report.Params.Assign(dataframe.params);
 end;

end;

procedure TFRpWizardVCL.BPageSetupClick(Sender: TObject);
begin
 ExecutePageSetup(report);
end;

end.
