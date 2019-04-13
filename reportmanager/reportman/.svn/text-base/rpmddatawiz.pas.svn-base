unit rpmddatawiz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls,rpreport,rpdatainfo,rpquerywiz;

type
  TFRpDataWiz = class(TForm)
    PControl: TPageControl;
    TabFields: TTabSheet;
    TabRelations: TTabSheet;
    PBottom: TPanel;
    BNext: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    areport:TRpReport;
    dook:boolean;
    querywiz:TFRpQueryWiz;
  public
    { Public declarations }
  end;

function ShowDataWizard(report:TRpReport;datasetname:String):Boolean;

implementation

{$R *.DFM}

function ShowDataWizard(report:TRpReport;datasetname:String):Boolean;
var
 dia:TFRpDataWiz;
begin
 Result:=false;
 if report.databaseinfo.Count<1 then
  exit;
 dia:=TFRpDataWiz.Create(Application);
 try
  dia.areport.DataInfo.Assign(report.datainfo);
  dia.querywiz.datasetname:=datasetname;
  dia.querywiz.report:=report;
  dia.ShowModal;
  if Not dia.dook then
  begin
   report.datainfo.assign(dia.areport.datainfo);
  end;
  Result:=dia.dook;
 finally
  dia.free;
 end;
end;

procedure TFRpDataWiz.FormCreate(Sender: TObject);
begin
 areport:=TRpReport.Create(Self);
 querywiz:=TFRpQueryWiz.Create(Self);
 querywiz.Parent:=TabFields;
 querywiz.Align:=alclient;
end;

end.
