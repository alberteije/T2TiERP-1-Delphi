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
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls,
  JvEdit, JvValidateEdit, DB, FMTBcd, Provider, DBClient, SqlExpr,
  JvEnterTab, JvComponentBase;

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
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure GridTurnoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ImprimeAbertura;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FIniciaMovimento: TFIniciaMovimento;

implementation

uses UDataModule, OperadorController, OperadorVO, MovimentoVO,
  MovimentoController, SuprimentoVO, UCaixa, UECF,
  UCargaPDV, ULoginGerenteSupervisor, UPAF;

{$R *.dfm}
var
  Movimento: TMovimentoVO;

procedure TFIniciaMovimento.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFIniciaMovimento.Confirma;
var
  Operador: TOperadorVO;
  Gerente: TOperadorVO;
  Suprimento: TSuprimentoVO;
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
            if UECF.ImpressoraOK(2) then
            begin
              if TMovimentoController.PrimeiroMovimento(FDataModule.ACBrECF.DataHora) then
              begin
                UCaixa.CargaOK := False;
                
                if FDataModule.ConectaBalcao then
                begin
                  FCaixa.labelMensagens.Caption := 'Aguarde, Importando Dados';
                  Application.CreateForm(TFCargaPDV, FCargaPDV);
                  FCargaPDV.Left := Self.Left;
                  FCargaPDV.Width := Self.Left;
                  FCargaPDV.Tipo := 5;
                  FCargaPDV.ShowModal;
                  UCaixa.CargaOK := True;
                end;

                Application.ProcessMessages;
                if not UCaixa.CargaOK then
                begin
                  Application.MessageBox('É Necessário Fazer a Primeira Carga do Dia Para Iniciar o Movimento!.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
                  
                  Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
                  try
                    if (FLoginGerenteSupervisor.ShowModal = MROK) then
                    begin
                      if not FLoginGerenteSupervisor.LoginOK then
                      begin
                         Application.MessageBox('Login - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
                         Exit;
                      end;
                    end;
                  finally
                    FreeAndNil(FLoginGerenteSupervisor);
                  end;
                end;//if not UCaixa.CargaOK then
              end;//if TMovimentoController.PrimeiroMovimento(FDataModule.ACBrECF.DataHora) then
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
            end
            else
            begin
             Application.MessageBox('Não foi possível abrir o movimento!.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
             UCaixa.StatusCaixa := 3;
             Close;
            end;//if UECF.ImpressoraOK(2) then

            //insere suprimento
            if StrToFloat(editValorSuprimento.Text) <> 0 then
            begin
              try
                Suprimento := TSuprimentoVO.Create;
                Suprimento.IdMovimento := Movimento.Id;
                Suprimento.DataSuprimento := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
                Suprimento.Valor := StrToFloat(editValorSuprimento.Text);
                TMovimentoController.Suprimento(Suprimento);
              finally
                FreeAndNil(Suprimento);
              end;
            end;//if StrToFloat(editValorSuprimento.Text) <> 0 then

            FCaixa.labelMensagens.Caption := 'CAIXA ABERTO';
            if assigned(Movimento) then
               begin
                    FCaixa.labelCaixa.Caption := 'Terminal: ' + Movimento.NomeCaixa;
                    FCaixa.labelOperador.Caption := 'Operador: ' + Movimento.LoginOperador;
                    Application.MessageBox('Movimento aberto com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
                    UCaixa.Movimento := Movimento;
                    ImprimeAbertura;
               end;
            Application.ProcessMessages;
            Close;
          end
          else
          begin
            Application.MessageBox('Gerente ou Supervisor: nível de acesso incorreto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
            editLoginGerente.SetFocus;
          end;//if (Gerente.Nivel = 'G') or (Gerente.Nivel = 'S') then
        end
        else
        begin
          Application.MessageBox('Gerente ou Supervisor: dados incorretos.','Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          editLoginGerente.SetFocus;
        end;//if Gerente.Id <> 0 then
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
    if Assigned(Gerente) then
      FreeAndNil(Gerente);
  end;
end;

procedure TFIniciaMovimento.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  GridTurno.SetFocus;
end;

procedure TFIniciaMovimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FCaixa.ExportaParaRetaguarda('Movimento.txt',3);
  if Assigned(Movimento) then
    FreeAndNil(Movimento);
  Action := caFree;
  FIniciaMovimento := nil;
end;

procedure TFIniciaMovimento.FormCreate(Sender: TObject);
begin
  CDSTurno.Active := True;
end;

procedure TFIniciaMovimento.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 123 then
    Confirma;
end;

procedure TFIniciaMovimento.GridTurnoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    editValorSuprimento.SetFocus;
end;

procedure TFIniciaMovimento.ImprimeAbertura;
begin
  Movimento := TMovimentoController.VerificaMovimento(Movimento.Id,'A');

  FDataModule.ACBrECF.AbreRelatorioGerencial(UCaixa.Configuracao.GerencialX);
  FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
  FDataModule.ACBrECF.LinhaRelatorioGerencial(' ABERTURA DE CAIXA ');
  FDataModule.ACBrECF.PulaLinhas(1);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('DATA DE ABERTURA  : '+Movimento.DataAbertura);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('HORA DE ABERTURA  : '+Movimento.HoraAbertura);
  FDataModule.ACBrECF.LinhaRelatorioGerencial(Movimento.NomeCaixa+'  OPERADOR: '+Movimento.LoginOperador);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('MOVIMENTO: '+IntToStr(Movimento.id));
  FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
  FDataModule.ACBrECF.PulaLinhas(1);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('SUPRIMENTO...: '+formatfloat('##,###,##0.00',editValorSuprimento.AsFloat));
  FDataModule.ACBrECF.PulaLinhas(3);
  FDataModule.ACBrECF.LinhaRelatorioGerencial(' ________________________________________ ');
  FDataModule.ACBrECF.LinhaRelatorioGerencial(' VISTO DO CAIXA ');
  FDataModule.ACBrECF.PulaLinhas(3);
  FDataModule.ACBrECF.LinhaRelatorioGerencial(' ________________________________________ ');
  FDataModule.ACBrECF.LinhaRelatorioGerencial(' VISTO DO SUPERVISOR ');

  FDataModule.ACBrECF.FechaRelatorio;
  UPAF.GravaR06('RG');
end;

end.
