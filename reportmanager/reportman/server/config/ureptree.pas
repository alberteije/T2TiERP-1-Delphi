{*******************************************************}
{                                                       }
{       Report Manager Server configuration             }
{                                                       }
{       ureptree                                        }
{                                                       }
{       Preview the tree for reports in a alias         }
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

unit ureptree;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QComCtrls, QImgList,rpmdconsts,rpgraphutils;

type
  TFReportTree = class(TForm)
    TreeView1: TTreeView;
    imalist: TImageList;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


procedure ShowReportTree(alist:TStringList);

implementation

{$R *.xfm}

procedure ShowReportTree(alist:TStringList);
var
 dia:TFReportTree;
begin
 if alist.count<1 then
  exit;
 dia:=TFReportTree.Create(Application);
 try
  dia.SetInitialBounds;
  rpgraphutils.FillTreeView(dia.TreeView1,alist);
  dia.showmodal;
 finally
  dia.free;
 end;
end;


procedure TFReportTree.FormCreate(Sender: TObject);
begin
 Caption:=TranslateStr(813,Caption);
end;

end.
