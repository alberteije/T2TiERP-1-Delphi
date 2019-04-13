{*******************************************************}
{                                                       }
{       Report Manager Server configuration             }
{                                                       }
{       ureptreevcl                                     }
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

unit ureptreevcl;

interface

{$I rpconf.inc}

uses
  SysUtils,
{$IFDEF USEVARIANTS}
  Types,Variants,
{$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList,rpmdconsts,rpgraphutilsvcl;

type
  TFReportTreeVCL = class(TForm)
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

{$R *.dfm}

procedure ShowReportTree(alist:TStringList);
var
 dia:TFReportTreeVCL;
begin
 if alist.count<1 then
  exit;
 dia:=TFReportTreeVCL.Create(Application);
 try
  FillTreeView(dia.TreeView1,alist);
  dia.showmodal;
 finally
  dia.free;
 end;
end;


procedure TFReportTreeVCL.FormCreate(Sender: TObject);
begin
 Caption:=TranslateStr(813,Caption);
end;

end.
