{*******************************************************************************
Title: T2Ti ERP
Description: Detecta um movimento aberto e solicita autenticação.

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
unit UMovimentoAberto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExDBGrids, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls,
  JvEdit, JvValidateEdit, DB, MovimentoVO, FMTBcd,
  JvEnterTab, Biblioteca, JvComponentBase;

type
  TFMovimentoAberto = class(TForm)
    Image1: TImage;
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    LabelTurno: TLabel;
    LabelTerminal: TLabel;
    LabelImpressora: TLabel;
    editSenhaOperador: TLabeledEdit;
    Label3: TLabel;
    LabelOperador: TLabel;
    Bevel3: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    LabelData: TLabel;
    LabelHora: TLabel;
    procedure Confirma;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoCancelaClick(Sender: TObject);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    PodeFechar : Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMovimentoAberto: TFMovimentoAberto;
  Movimento: TMovimentoVO;

implementation

uses OperadorController, OperadorVO,
  MovimentoController, UCaixa;

{$R *.dfm}

procedure TFMovimentoAberto.FormCreate(Sender: TObject);
begin
  PodeFechar := False;
  Movimento := TMovimentoController.VerificaMovimento;
  LabelTurno.Caption := Movimento.DescricaoTurno;
  LabelTerminal.Caption := Movimento.NomeCaixa;
  LabelOperador.Caption := Movimento.LoginOperador;
  LabelImpressora.Caption := Movimento.IdentificacaoImpressora;
  LabelData.Caption := Movimento.DataAbertura;
  LabelHora.Caption := Movimento.HoraAbertura;
end;

procedure TFMovimentoAberto.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
end;

procedure TFMovimentoAberto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// A Variavel chamada AcionaMenu foi criada para que o acionamento
// dos menus (com excecao do Menu Fiscal) so possa ser feito depois de logar no sistema. Gilson
  UCaixa.AcionaMenu := True;
  FreeAndNil(Movimento);
  Action := caFree;
end;

procedure TFMovimentoAberto.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := PodeFechar;
end;

procedure TFMovimentoAberto.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFMovimentoAberto.Confirma;
var
  Operador: TOperadorVO;
begin
  try
    try
      // verifica se senha do operador esta correta
      Operador := TOperadorController.ConsultaUsuario(Movimento.LoginOperador,editSenhaOperador.Text);
      if Operador.Id <> 0 then
      begin
        PodeFechar := True;
        Close;
        if Movimento.Status = 'T' then
        begin
          TMovimentoController.RetornoOperador(Movimento);
        end;
        FCaixa.labelMensagens.Caption := 'CAIXA ABERTO';
        FCaixa.labelCaixa.Caption := 'Terminal: ' + Movimento.NomeCaixa;
        FCaixa.labelOperador.Caption := 'Operador: ' + Movimento.LoginOperador;
      end
      else
      begin
        Application.MessageBox('Operador: dados incorretos.','Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        editSenhaOperador.SetFocus;
      end;//if Operador.Id <> 0 then
    except
    end;
  finally
    if Assigned(Operador) then
      FreeAndNil(Operador);
  end;
end;

procedure TFMovimentoAberto.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 123 then
    Confirma;
  if Key = 27 then
    botaoCancela.Click;
end;

procedure TFMovimentoAberto.botaoCancelaClick(Sender: TObject);
begin
  UCaixa.StatusCaixa := 4;
  SetTaskBar(True);
  Application.ProcessMessages;
  Application.Terminate;
end;

end.
