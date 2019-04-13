{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfabout                                      }
{       About box for report manager designer           }
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
unit rpmdfabout;

interface

{$I rpconf.inc}

uses SysUtils, Classes,
{$IFDEF LINUX}
  Libc,
{$ENDIF}
{$IFDEF MSWINDOWS}
  Windows,ShellApi,
{$ENDIF}
  QGraphics, QForms,
  QButtons, QExtCtrls, QControls, QStdCtrls,QDialogs,
  rpmdconsts;

type
  TFRpAboutBox = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    BOK: TButton;
    Panel2: TPanel;
    Image1: TImage;
    Image2: TImage;
    LReport: TLabel;
    LAuthor: TLabel;
    LName: TLabel;
    Label2: TLabel;
    LEmail: TLabel;
    Label3: TLabel;
    LVersion: TLabel;
    LProject: TLabel;
    Label5: TLabel;
    LContributors: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Label5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


procedure ShowAbout;

implementation


{$R *.xfm}

procedure ShowAbout;
var dia:TFRpAboutBox;
begin
 dia:=TFRpAboutBox.Create(Application);
 try
  dia.ShowModal;
 finally
  dia.free;
 end;
end;



procedure TFRpAboutBox.FormCreate(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
 LReport.Font.Name:='Arial';
{$ENDIF}
 Caption:=TranslateStr(88,Caption);
 LAuthor.Caption:=TranslateStr(89,LAuthor.Caption);
 LProject.Caption:=TranslateStr(90,LProject.Caption);
 LContributors.Caption:=TranslateStr(92,LContributors.Caption);
 LVersion.Caption:=TranslateStr(91,'Version')+' '+RM_VERSION;
 BOK.Caption:=TranslateStr(93,BOK.Caption);
 Label5.Font.Color:=clBlue;

 LReport.Font.Size:=20;
 LReport.Font.Style:=[fsBold];
 LName.Font.Style:=[fsBold];
 LVersion.Font.Size:=16;
 LEmail.Font.Style:=[fsBold];

 SetInitialBounds;
end;

procedure TFRpAboutBox.Label5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{$IFDEF LINUX}
  Libc.system(PChar('konqueror "'+'http://reportman.sourceforge.net'+'"&'))
{$ENDIF}
{$IFDEF MSWINDOWS}
  ShellExecute(0,Pchar('open'),Pchar('http://reportman.sourceforge.net'),
   nil,nil,SW_SHOWNORMAL);
{$ENDIF}
end;

end.
