{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       Help form                                       }
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

unit rpmdfhelpform;

interface


uses
  SysUtils, Types, Classes,
  QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QActnList, QImgList, QComCtrls,
  rpmdconsts;

type
  TFRpHelpForm = class(TForm)
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ABackward: TAction;
    AForward: TAction;
    AExit: TAction;
    BBAckwar: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure AExitExecute(Sender: TObject);
    procedure ABackwardExecute(Sender: TObject);
    procedure AForwardExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TextBrowser1:TTextBrowser;
  end;


implementation


{$R *.xfm}

procedure TFRpHelpForm.AExitExecute(Sender: TObject);
begin
 Close;
end;

procedure TFRpHelpForm.ABackwardExecute(Sender: TObject);
begin
 TextBrowser1.Backward;
end;

procedure TFRpHelpForm.AForwardExecute(Sender: TObject);
begin
 TextBrowser1.Forward;
end;

procedure TFRpHelpForm.FormCreate(Sender: TObject);
begin
 TextBrowser1:=TTextBrowser.Create(Self);
 TextBrowser1.Align:=alClient;
 TextBrowser1.Parent:=Self;

 Caption:=TranslateStr(209,Caption);
 ABackward.Hint:=TranslateStr(210,ABackward.Hint);
 AForward.Hint:=TranslateStr(211,AForward.Hint);
 AExit.Hint:=TranslateStr(212,AExit.Hint);

 SetInitialBounds;
end;



end.
