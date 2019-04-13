{*******************************************************************************
Title: T2Ti ERP
Description: Tela de login do ERP.

The MIT License

Copyright: Copyright (C) 2010 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           fabio_thz@yahoo.com.br | t2ti.com@gmail.com</p>

@author Fábio Thomaz
@version 1.0
*******************************************************************************}
unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UBase, StdCtrls, ExtCtrls, Buttons, jpeg, JvComponentBase, JvEnterTab,
  JvExControls;

type
  TFLogin = class(TFBase)
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    BotaoConfirma: TBitBtn;
    EditLogin: TEdit;
    EditSenha: TEdit;
    BotaoCancela: TBitBtn;
    JvEnterAsTab: TJvEnterAsTab;
    procedure BotaoCancelaClick(Sender: TObject);
    procedure BotaoConfirmaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function DoLogin: Boolean;
  public
    { Public declarations }
    Logado: Boolean;
  end;

var
  FLogin: TFLogin;

implementation

uses Biblioteca;

{$R *.dfm}

{ TFLogin }

procedure TFLogin.BotaoCancelaClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFLogin.BotaoConfirmaClick(Sender: TObject);
begin
  try
    if DoLogin then
    begin
      Logado := True;
      Close;
    end
    else
      begin
         MessageWarn('Erro no Login');
         editLogin.Clear;
         EditSenha.Clear;
         EditLogin.SetFocus;
      end;
  except

  end;
end;

function TFLogin.DoLogin: Boolean;
begin
  try
    Result := Sessao.AutenticaUsuario(EditLogin.Text,EditSenha.Text);
  except
    Result := False;
  end;
end;

procedure TFLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := Logado;
end;

procedure TFLogin.FormShow(Sender: TObject);
begin
  inherited;
  Logado := False;
  EditLogin.SetFocus;
end;

end.
