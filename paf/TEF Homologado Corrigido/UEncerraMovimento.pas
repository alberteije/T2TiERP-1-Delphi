{*******************************************************************************
Title: T2Ti ERP
Description: Encerra um movimento aberto.

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
unit UEncerraMovimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, ExtCtrls,
  JvExStdCtrls, JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage,
  FMTBcd, JvExControls, JvEnterTab, Provider, DBClient, DB, SqlExpr;

type
  TFEncerraMovimento = class(TForm)
    Image1: TImage;
    GroupBox2: TGroupBox;
    editSenhaOperador: TLabeledEdit;
    GroupBox1: TGroupBox;
    editLoginGerente: TLabeledEdit;
    editSenhaGerente: TLabeledEdit;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    LabelTurno: TLabel;
    LabelTerminal: TLabel;
    LabelOperador: TLabel;
    LabelImpressora: TLabel;
    procedure confirma;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEncerraMovimento: TFEncerraMovimento;

implementation

uses UDataModule, CaixaController, OperadorController, OperadorVO, MovimentoVO,
  MovimentoController, SuprimentoVO, UCaixa, UIniciaMovimento;

var
  Movimento: TMovimentoVO;
{$R *.dfm}

procedure TFEncerraMovimento.FormCreate(Sender: TObject);
begin
  Movimento := TMovimentoController.VerificaMovimento;
  LabelTurno.Caption := Movimento.DescricaoTurno;
  LabelTerminal.Caption := Movimento.NomeCaixa;
  LabelOperador.Caption := Movimento.LoginOperador;
  LabelImpressora.Caption := Movimento.IdentificacaoImpressora;
end;

procedure TFEncerraMovimento.confirma;
var
  Operador: TOperadorVO;
  Gerente: TOperadorVO;
  Suprimento: TSuprimentoVO;
begin
  try
    try
      // verifica se senha do operador esta correta
      Operador := TOperadorController.ConsultaUsuario(Movimento.LoginOperador, editSenhaOperador.Text);
      if Operador.Id <> 0 then
      begin
        // verifica se senha do gerente esta correta
        Gerente := TOperadorController.ConsultaUsuario(editLoginGerente.Text,editSenhaGerente.Text);
        if Gerente.Id <> 0 then
        begin
          if (Gerente.Nivel = 'G') or (Gerente.Nivel = 'S') then
          begin
            //encerra movimento
            Movimento.DataFechamento := FormatDateTime('yyyy-mm-dd', now);
            Movimento.HoraFechamento := FormatDateTime('hh:nn:ss', now);
            Movimento.Status := 'F';
            TMovimentoController.EncerraMovimento(Movimento);
            //
            Application.MessageBox('Movimento encerrado com sucesso.','Informação do Sistema', MB_OK + MB_ICONINFORMATION);
            Close;
            Application.CreateForm(TFIniciaMovimento, FIniciaMovimento);
            FIniciaMovimento.ShowModal;
          end//verificou nivel de acesso do gerente
          else
          begin
            Application.MessageBox('Gerente ou Supervisor: nível de acesso incorreto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
            editLoginGerente.SetFocus;
          end;
        end//verificou os dados do gerente
        else
        begin
          Application.MessageBox('Gerente ou Supervisor: dados incorretos.','Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          editLoginGerente.SetFocus;
        end;
      end//verificou os dados do operador
      else
      begin
        Application.MessageBox('Operador: dados incorretos.','Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        editSenhaOperador.SetFocus;
      end;
    except
    end;
  finally
  end;
end;

procedure TFEncerraMovimento.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
end;

procedure TFEncerraMovimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Movimento.Free;
  Action := caFree;
end;

procedure TFEncerraMovimento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 123 then
    confirma;
end;

procedure TFEncerraMovimento.botaoConfirmaClick(Sender: TObject);
begin
  confirma;
end;

end.
