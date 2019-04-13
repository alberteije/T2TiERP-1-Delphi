{*******************************************************}
{                                                       }
{       Report Manager Server configuration             }
{                                                       }
{       unewuservcl                                     }
{                                                       }
{       Ask info to create a new user                   }
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

unit unewuservcl;

interface

uses SysUtils, Classes, Graphics, Forms,
  Buttons, ExtCtrls, Controls, StdCtrls,rpmdconsts;

type
  TFNewUserVCL = class(TForm)
    BOK: TButton;
    BCancel: TButton;
    LUser: TLabel;
    EUserName: TEdit;
    EPassword: TEdit;
    LPassword: TLabel;
    LConfirm: TLabel;
    EConfirmPassword: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BOKClick(Sender: TObject);
  private
    { Private declarations }
    dook:boolean;
  public
    { Public declarations }
  end;


function AskUserNameAndPassword(var username,password:string;onlypassword:boolean):boolean;

implementation

{$R *.dfm}

procedure TFNewUserVCL.FormCreate(Sender: TObject);
begin
 Caption:=TranslateStr(809,Caption);
 LUser.Caption:=TranslateStr(810,LUser.Caption);
 LPassword.Caption:=TranslateStr(811,LPassword.Caption);
 LConfirm.Caption:=TranslateStr(812,LConfirm.Caption);
 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);

end;

function AskUserNameAndPassword(var username,password:string;onlypassword:boolean):boolean;
var
 dia:TFNewUserVCL;
begin
 Result:=false;
 dia:=TFNewUserVCL.Create(Application);
 try
  dia.EUserName.Text:=username;
  dia.ActiveControl:=dia.EUserName;
  if onlypassword then
  begin
   dia.EUserName.ReadOnly:=true;
   dia.EUserName.Color:=clBtnFace;
   dia.ActiveControl:=dia.EPassword;
  end;
  dia.EPassword.Text:=password;
  dia.EConfirmPassword.Text:=password;
  dia.showmodal;
  if dia.dook then
  begin
   Result:=True;
   username:=Trim(Uppercase(dia.EUserName.Text));
   password:=dia.EPassword.Text;
  end;
 finally
  dia.free;
 end;
end;


procedure TFNewUserVCL.BOKClick(Sender: TObject);
begin
 if Length(Trim(EUserName.Text))<1 then
 begin
  EUserName.SetFocus;
  Raise Exception.Create(SRpAUserNameMustbeAssigned);
 end;
 if Trim(EPassword.Text)<>Trim(EConfirmPassword.Text) then
 begin
  EConfirmPassword.SetFocus;
  Raise Exception.Create(SRpPasswordConfirmationIncorrect);
 end;
 dook:=true;
 close;
end;

end.
