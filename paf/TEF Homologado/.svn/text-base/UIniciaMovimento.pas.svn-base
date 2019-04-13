{*******************************************************************************
Title: T2Ti ERP
Description: Inicia um novo movimento.

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
unit UIniciaMovimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, DB, FMTBcd, Provider, DBClient, SqlExpr, JvExControls,
  JvEnterTab;

type
  TFIniciaMovimento = class(TForm)
    Image1: TImage;
    GroupBox2: TGroupBox;
    editValorSuprimento: TJvValidateEdit;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    GridTurno: TJvDBGrid;
    JvEnterAsTab1: TJvEnterAsTab;
    GroupBox1: TGroupBox;
    editLoginGerente: TLabeledEdit;
    editSenhaGerente: TLabeledEdit;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    GroupBox4: TGroupBox;
    editLoginOperador: TLabeledEdit;
    editSenhaOperador: TLabeledEdit;
    QTurno: TSQLQuery;
    DSTurno: TDataSource;
    CDSTurno: TClientDataSet;
    DSPTurno: TDataSetProvider;
    procedure confirma;
    procedure FormActivate(Sender: TObject);
    procedure GridTurnoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FIniciaMovimento: TFIniciaMovimento;

implementation

uses UDataModule, CaixaController, OperadorController, OperadorVO, MovimentoVO,
  MovimentoController, SuprimentoVO, UCaixa, Biblioteca;

{$R *.dfm}

procedure TFIniciaMovimento.botaoConfirmaClick(Sender: TObject);
begin
  confirma;
end;

procedure TFIniciaMovimento.confirma;
var
  Operador : TOperadorVO;
  Gerente : TOperadorVO;
  Movimento : TMovimentoVO;
  Suprimento : TSuprimentoVO;
begin
  try
    try
      //verifica se senha e o nível do operador estão corretos
      Operador := TOperadorController.ConsultaUsuario(editLoginOperador.Text,editSenhaOperador.Text);
      if Operador.Id <> 0 then
      begin
        //verifica se senha do gerente esta correta
        Gerente := TOperadorController.ConsultaUsuario(editLoginGerente.Text,editSenhaGerente.Text);
        if Gerente.Id <> 0 then
        begin
          //verifica nivel de acesso do gerente/supervisor
          if (Gerente.Nivel = 'G') or (Gerente.Nivel = 'S') then
          begin
            //insere movimento
            Movimento := TMovimentoVO.Create;
            Movimento.IdTurno := CDSTurno.FieldByName('ID').AsInteger;
            Movimento.IdImpressora := UCaixa.Configuracao.IdImpressora;
            Movimento.idEmpresa := UCaixa.Configuracao.IdEmpresa;
            Movimento.IdOperador := Operador.Id;
            Movimento.IdCaixa := UCaixa.Configuracao.idCaixa;
            Movimento.IdGerenteSupervisor := Gerente.Id;
            Movimento.DataAbertura := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
            Movimento.HoraAbertura := FormatDateTime('hh:nn:ss', FDataModule.ACBrECF.DataHora);
            Movimento.TotalSuprimento := StrToFloat(editValorSuprimento.Text);
            Movimento.Status := 'A';
            Movimento.Sincronizado := 'N';
            Movimento := TMovimentoController.IniciaMovimento(Movimento);
            //insere suprimento
            if StrToFloat(editValorSuprimento.Text) <> 0 then
            begin
              Suprimento := TSuprimentoVO.Create;
              Suprimento.IdMovimento := Movimento.Id;
              Suprimento.DataSuprimento := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
              Suprimento.Valor := StrToFloat(editValorSuprimento.Text);
              TMovimentoController.Suprimento(Suprimento);
            end;
            FCaixa.labelMensagens.Caption := 'CAIXA ABERTO';
            FCaixa.labelCaixa.Caption := 'Terminal: ' + Movimento.NomeCaixa;
            FCaixa.labelOperador.Caption := 'Operador: ' + Movimento.LoginOperador;
            Application.MessageBox('Movimento aberto com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
            UCaixa.Movimento := Movimento;
            UCaixa.StatusCaixa := 0;
            Close;
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

procedure TFIniciaMovimento.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  GridTurno.SetFocus;
end;

procedure TFIniciaMovimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFIniciaMovimento.FormCreate(Sender: TObject);
begin
  CDSTurno.Active := True;
end;

procedure TFIniciaMovimento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 123 then
    confirma;
end;

procedure TFIniciaMovimento.GridTurnoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    editValorSuprimento.SetFocus;
end;

end.
