{*******************************************************************************
Title: T2Ti ERP
Description: Tela de login do sistema de balcão do PAF-ECF.

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
           t2ti.com@gmail.com</p>

@author Albert Eije (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, inifiles, jpeg, DB, DBClient,
  JvComponentBase, JvEnterTab;

type
  TFLogin = class(TForm)
    BitBtn1: TBitBtn;
    EditLogin: TEdit;
    EditSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    botaoCancela: TBitBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure botaoCancelaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    PodeFechar : Boolean;
    procedure Confirma;

  public
    { Public declarations }
  end;

var
  FLogin: TFLogin;

implementation

Uses UDataModule, OperadorVO, OperadorFuncionarioController, UConfiguracao,
  Biblioteca;

{$R *.dfm}

procedure TFLogin.BitBtn1Click(Sender: TObject);
begin
    Confirma;
end;

procedure TFLogin.botaoCancelaClick(Sender: TObject);
begin
  Application.Terminate;
  Application.ProcessMessages;
end;

procedure TFLogin.Confirma;
//var
//  Operador: TOperadorVO;
begin
   { try
      if (EditLogin.Text <> '') and (EditSenha.Text <> '') then
      begin
        // verifica se senha do operador esta correta
        Operador := TOperadorFuncionarioController.ConsultaUsuario(EditLogin.Text,editSenha.Text);
        if Operador.Id <> 0 then
        begin
          PodeFechar := True;
          // Application.CreateForm(TFConfiguracao, FConfiguracao);
          // FConfiguracao.ShowModal;
          FConfiguracao.PodeLogar := True;
        end// verificou o nivel de acesso do gerente
        else
        begin
          Application.MessageBox('Dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          EditLogin.SetFocus;
        end;
      end
      else
        Application.MessageBox('Contém campo vazio.', 'Informação do Sistema', MB_OK + MB_ICONERROR);;
    except
      Application.MessageBox('Erro ao tentar conectar.', 'Informação do Sistema', MB_OK + MB_ICONERROR);;
    end;  }

    try
      if VerificaLogin(trim(EditLogin.Text), trim(EditSenha.Text)) then
      begin
        PodeFechar := True;
        FConfiguracao.PodeLogar := True;
      end
      else
      begin
          Application.MessageBox('Dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          EditLogin.SetFocus;
      end;
    except
      Application.MessageBox('Erro ao tentar conectar.', 'Informação do Sistema', MB_OK + MB_ICONERROR);;
    end;


end;

procedure TFLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
  Flogin := Nil;
end;

procedure TFLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := PodeFechar;
end;

procedure TFLogin.FormCreate(Sender: TObject);
begin
    PodeFechar := False;
end;

procedure TFLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 123 then
    confirma;
  if Key = 27 then
    botaoCancela.Click;
end;

end.
