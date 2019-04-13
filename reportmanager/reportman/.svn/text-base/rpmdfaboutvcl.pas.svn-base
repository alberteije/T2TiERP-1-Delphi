{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfaboutvcl                                   }
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
unit rpmdfaboutvcl;

interface

{$I rpconf.inc}

uses Windows,SysUtils, Classes,
  Graphics, Forms,ShellApi,
  Buttons, ExtCtrls, Controls, StdCtrls,Dialogs,
  rpmdconsts;

type
  TFRpAboutBoxVCL = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    BOK: TButton;
    Panel2: TPanel;
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


{$R *.dfm}

procedure ShowAbout;
var dia:TFRpAboutBoxVCL;
begin
 dia:=TFRpAboutBoxVCL.Create(Application);
 try
  dia.ShowModal;
 finally
  dia.free;
 end;
end;



procedure TFRpAboutBoxVCL.FormCreate(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
 LReport.Font.Name:='Arial';
{$ENDIF}
 Caption:=TranslateStr(88,Caption);
 LAuthor.Caption:=TranslateStr(89,LAuthor.Caption);
 LProject.Caption:=TranslateStr(90,LProject.Caption);
 LContributors.Caption:=TranslateStr(92,LContributors.Caption);
 LVersion.Caption:=TranslateStr(91,'Version')+' '+RM_VERSION+' XP';
 BOK.Caption:=TranslateStr(93,BOK.Caption);

 LReport.Font.Size:=20;
 LReport.Font.Style:=[fsBold];
 LName.Font.Style:=[fsBold];
 LVersion.Font.Size:=16;
 LEmail.Font.Style:=[fsBold];
 Label5.Font.Color := clHighlight;

end;

procedure TFRpAboutBoxVCL.Label5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 // Starts the explorer
{$IFNDEF DOTNETD}
 ShellExecute(Self.handle,Pchar('open'),Pchar(TLabel(Sender).Caption),nil,nil,SW_SHOWNORMAL);
{$ENDIF}
end;

end.
