{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfsearch                                     }
{                                                       }
{       Search dialog for paramters                     }
{                                                       }
{       Copyright (c) 1994-2005 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpmdfsearch;

interface

uses
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  rpmdconsts,rpdatainfo,rpparams,rpreport,
  QStdCtrls, QExtCtrls, QGrids, QDBGrids, Provider, Db, DBClient, QTypes;

type
  TFRpSearchParam = class(TForm)
    PTop: TPanel;
    LSearch: TLabel;
    ESearch: TEdit;
    BSearch: TButton;
    Timer1: TTimer;
    GridData: TDBGrid;
    BOK: TButton;
    DataSource1: TDataSource;
    DData: TClientDataSet;
    Dataprov: TDataSetProvider;
    procedure FormCreate(Sender: TObject);
    procedure ESearchChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BSearchClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure DDataAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    param:TRpParam;
    params:TRpParamList;
    searchparam:TRpParam;
    databaseinfo:TRpDatabaseInfoList;
    datainfo:TRpDataInfoList;
    dinfo:TRpDataInfoItem;
    report:TRpReport;
  public
    { Public declarations }
  end;


procedure ParamValueSearch(aparam:TRpParam;report:TRpReport);

implementation

{$R *.xfm}

procedure ParamValueSearch(aparam:TRpParam;report:TRpReport);
var
 dia:TFRpSearchParam;
begin
 dia:=TFRpSearchParam.Create(Application);
 try
  dia.param:=aparam;
  dia.params:=TRpParamList(aparam.Collection);
  dia.report:=report;
  dia.databaseinfo:=dia.Report.databaseinfo;
  if Length(aparam.SearchParam)>0 then
   dia.searchparam:=dia.Params.ParamByName(aparam.SearchParam);
  dia.datainfo:=dia.Report.datainfo;
  dia.LSearch.Visible:=Assigned(dia.searchparam);
  dia.ESearch.Visible:=Assigned(dia.searchparam);
  dia.dinfo:=dia.datainfo.ItemByName(aparam.SearchDataset);
  try
   if not assigned(dia.searchparam) then
   begin
    dia.BSearch.Visible:=false;
    dia.Timer1Timer(dia);
    dia.PTop.Height:=dia.BOk.Top+dia.BOk.Height+5;
   end;
   dia.ShowModal;
  finally
   dia.dinfo.Disconnect;
  end;
 finally
  dia.free;
 end;
end;

procedure TFRpSearchParam.FormCreate(Sender: TObject);
begin
 Caption:=SRpSearchValue;
 LSearch.Caption:=SRpSearchValue;
 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BSearch.Caption:=SRpSearch;
end;

procedure TFRpSearchParam.ESearchChange(Sender: TObject);
begin
 Timer1.Enabled:=true;
end;

procedure TFRpSearchParam.Timer1Timer(Sender: TObject);
begin
 Timer1.Enabled:=false;
 DData.Close;
 try
  dinfo.Disconnect;
  if assigned(searchparam) then
   searchparam.Value:=ESearch.Text;
  dinfo.Connect(databaseinfo,params);
  Dataprov.DataSet:=dinfo.Dataset;
  DData.Open;
  BOK.Enabled:=Not DData.Eof;
  GridData.Visible:=true;
 except
  GridData.Visible:=false;
  BOK.Enabled:=false;
  raise;
 end;
end;

procedure TFRpSearchParam.BSearchClick(Sender: TObject);
begin
 Timer1Timer(Self);
end;

procedure TFRpSearchParam.BOKClick(Sender: TObject);
begin
 param.Value:=DData.Fields[0].AsVariant;
 Close;
end;

procedure TFRpSearchParam.DDataAfterScroll(DataSet: TDataSet);
begin
 if DData.Eof then
  DData.GetNextPacket;
end;

end.
