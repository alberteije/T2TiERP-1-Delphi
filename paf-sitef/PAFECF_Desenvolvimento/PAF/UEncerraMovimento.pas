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
  FMTBcd, JvEnterTab, Provider, DBClient, DB, SqlExpr,
  JvComponentBase, Mask, JvExMask, JvToolEdit, JvBaseEdits, MovimentoVO;

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
    GroupBox3: TGroupBox;
    ComboTipoPagamento: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    edtValor: TJvCalcEdit;
    btnAdicionar: TBitBtn;
    btnRemover: TBitBtn;
    JvDBGrid1: TJvDBGrid;
    edtTotal: TJvCalcEdit;
    DSFechamento: TDataSource;
    CDSFechamento: TClientDataSet;
    QFechamento: TSQLDataSet;
    DSPFechamento: TDataSetProvider;
    CDSResumo: TClientDataSet;
    CDSResumoTIPO_PAGAMENTO: TStringField;
    CDSResumoCALCULADO: TFloatField;
    CDSResumoDECLARADO: TFloatField;
    CDSResumoDIFERENCA: TFloatField;
    QFechamentoID: TIntegerField;
    QFechamentoTIPO_PAGAMENTO: TStringField;
    QFechamentoVALOR: TFMTBCDField;
    CDSFechamentoID: TIntegerField;
    CDSFechamentoTIPO_PAGAMENTO: TStringField;
    CDSFechamentoVALOR: TFMTBCDField;
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TotalizaFechamento;
    procedure ImprimeFechamento;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure CDSResumoCalcFields(DataSet: TDataSet);
    procedure edtValorExit(Sender: TObject);
    procedure editSenhaGerenteExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure botaoCancelaClick(Sender: TObject);
  private
    FPodeFechar : Boolean;
  public
    { Public declarations }
  end;

var
  FEncerraMovimento: TFEncerraMovimento;
  Movimento: TMovimentoVO;
  FechouMovimento, AbreMovimento: Boolean;

implementation

uses UDataModule, OperadorController, OperadorVO,
  MovimentoController, UCaixa, UIniciaMovimento,
  TipoPagamentoController, TipoPagamentoVO, Generics.Collections, FechamentoVO,
  FechamentoController, MeiosPagamentoVO,
  TotalTipoPagamentoController, UPAF;

{$R *.dfm}

procedure TFEncerraMovimento.FormCreate(Sender: TObject);
var
  i: Integer;
  ListaTipoPagamento: TObjectList<TTipoPagamentoVO>;
begin
  FPodeFechar := false;
  AbreMovimento := True;
  FechouMovimento := False;
  Movimento := TMovimentoController.VerificaMovimento;
  LabelTurno.Caption := Movimento.DescricaoTurno;
  LabelTerminal.Caption := Movimento.NomeCaixa;
  LabelOperador.Caption := Movimento.LoginOperador;
  LabelImpressora.Caption := Movimento.IdentificacaoImpressora;

  TotalizaFechamento;
  try
    ListaTipoPagamento := TTipoPagamentoController.TabelaTipoPagamento;
    for i := 0 to ListaTipoPagamento.Count - 1 do
      ComboTipoPagamento.Items.Add(TTipoPagamentoVO(ListaTipoPagamento.Items[i]).Descricao);
    ComboTipoPagamento.ItemIndex := 0;
  finally
    FreeAndNil(ListaTipoPagamento);
  end;
end;

procedure TFEncerraMovimento.btnAdicionarClick(Sender: TObject);
var
  Fechamento: TFechamentoVO;
begin
  if trim(ComboTipoPagamento.Text) = '' then
  begin
    Application.MessageBox('Informe uma forma de Pagamento Válida!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    ComboTipoPagamento.SetFocus;
    Exit;
  end;

  if edtValor.Value <= 0 then
  begin
    Application.MessageBox('Informe um Valor Válido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    edtValor.SetFocus;
    Exit;
  end;

  try
    Fechamento := TFechamentoVO.Create;
    Fechamento.IdMovimento := Movimento.Id;
    Fechamento.TipoPagamento := ComboTipoPagamento.Text;
    Fechamento.Valor := edtValor.Value;

    if TFechamentoController.GravaFechamento(Fechamento) then
      TotalizaFechamento;
  finally
    FreeAndNil(Fechamento);
  end;
  edtValor.Clear;
  ComboTipoPagamento.SetFocus;
end;

procedure TFEncerraMovimento.btnRemoverClick(Sender: TObject);
begin
  if not CDSFechamento.IsEmpty then
  begin
    if TFechamentoController.ExcluiFechamento(CDSFechamentoID.AsInteger) then
      TotalizaFechamento;
  end;
  ComboTipoPagamento.SetFocus;
end;

procedure TFEncerraMovimento.CDSResumoCalcFields(DataSet: TDataSet);
begin
  CDSResumoDIFERENCA.AsFloat := (CDSResumoCALCULADO.AsFloat - CDSResumoDECLARADO.AsFloat);
end;

procedure TFEncerraMovimento.confirma;
var
  Operador: TOperadorVO;
  Gerente: TOperadorVO;
begin
  try
    Operador := TOperadorVO.Create;
    Gerente := TOperadorVO.Create;

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
            Movimento.DataFechamento := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
            Movimento.HoraFechamento := FormatDateTime('hh:nn:ss', FDataModule.ACBrECF.DataHora);
            Movimento.Status := 'F';
            TMovimentoController.EncerraMovimento(Movimento);
            Movimento := TMovimentoController.VerificaMovimento(Movimento.Id);
            ImprimeFechamento;
            UCaixa.Movimento := Movimento;
            Application.MessageBox('Movimento encerrado com sucesso.','Informação do Sistema', MB_OK + MB_ICONINFORMATION);
            FechouMovimento := True;
            FPodeFechar := true;
            botaoConfirma.ModalResult := mrOK;
            self.ModalResult := mrOK;
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

procedure TFEncerraMovimento.editSenhaGerenteExit(Sender: TObject);
begin
  botaoConfirma.SetFocus;
end;

procedure TFEncerraMovimento.edtValorExit(Sender: TObject);
begin
  if edtValor.Value = 0  then
    editSenhaOperador.SetFocus;
end;

procedure TFEncerraMovimento.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  ComboTipoPagamento.SetFocus;
end;

procedure TFEncerraMovimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FechouMovimento then
    ModalResult := mrOk
  else
    ModalResult := mrCancel;
  if Assigned(Movimento) then
    FreeAndNil(Movimento);
  Action := caFree;
  FEncerraMovimento := Nil;
end;

procedure TFEncerraMovimento.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := FPodeFechar;
  if AbreMovimento then
  begin
    Application.CreateForm(TFIniciaMovimento, FIniciaMovimento);
    FIniciaMovimento.ShowModal;
  end;
end;

procedure TFEncerraMovimento.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 123 then
    Confirma;
end;

procedure TFEncerraMovimento.botaoCancelaClick(Sender: TObject);
begin
   FPodeFechar := true;
   Close;
end;

procedure TFEncerraMovimento.botaoConfirmaClick(Sender: TObject);
begin
    Confirma;
end;

procedure TFEncerraMovimento.TotalizaFechamento;
var
  Total: Real;
begin
  Total := 0;

  CDSFechamento.Close;
  CDSFechamento.FetchParams;
  CDSFechamento.Params.ParamByName('pID_ECF_MOVIMENTO').AsInteger := Movimento.Id;
  CDSFechamento.Open;

  if not CDSFechamento.IsEmpty then
  begin
    CDSFechamento.DisableControls;
    CDSFechamento.First;
    while not CDSFechamento.Eof do
    begin
      Total := Total + CDSFechamentoVALOR.AsFloat;
      CDSFechamento.Next;
    end;
    CDSFechamento.EnableControls;
  end;
  edtTotal.Value := Total;
end;

procedure TFEncerraMovimento.ImprimeFechamento;
var
  i: Integer;
  TotalGerado: TObjectList<TMeiosPagamentoVO>;
  TotalDeclarado: TObjectList<TMeiosPagamentoVO>;
  Calculado, Declarado, Diferenca, Meio: AnsiString;
  TotCalculado, TotDeclarado, TotDiferenca: Currency;
  Suprimento,Sangria,NaoFiscal,TotalVenda,Desconto,
  Acrescimo,Recebido,Troco,Cancelado,TotalFinal: AnsiString;
begin
  try
    FDataModule.ACBrECF.AbreRelatorioGerencial(UCaixa.Configuracao.GerencialX);
    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    FDataModule.ACBrECF.LinhaRelatorioGerencial('             FECHAMENTO DE CAIXA                ');
    FDataModule.ACBrECF.PulaLinhas(1);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('DATA DE ABERTURA  : '+Movimento.DataAbertura);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('HORA DE ABERTURA  : '+Movimento.HoraAbertura);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('DATA DE FECHAMENTO: '+Movimento.DataFechamento);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('HORA DE FECHAMENTO: '+Movimento.HoraFechamento);
    FDataModule.ACBrECF.LinhaRelatorioGerencial(Movimento.NomeCaixa+'  OPERADOR: '+Movimento.LoginOperador);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('MOVIMENTO: '+IntToStr(Movimento.id));
    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    FDataModule.ACBrECF.PulaLinhas(1);

    Suprimento := FloatToStrF(Movimento.TotalSuprimento,ffNumber,11,2);
    Suprimento := StringOfChar(' ', 13 - Length(Suprimento)) + Suprimento;
    Sangria    := FloatToStrF(Movimento.TotalSangria,ffNumber,11,2);
    Sangria    := StringOfChar(' ', 13 - Length(Sangria)) + Sangria;
    NaoFiscal  := FloatToStrF(Movimento.TotalNaoFiscal,ffNumber,11,2);
    NaoFiscal  := StringOfChar(' ', 13 - Length(NaoFiscal)) + NaoFiscal;
    TotalVenda := FloatToStrF(Movimento.TotalVenda,ffNumber,11,2);
    TotalVenda := StringOfChar(' ', 13 - Length(TotalVenda)) + TotalVenda;
    Desconto   := FloatToStrF(Movimento.TotalDesconto,ffNumber,11,2);
    Desconto   := StringOfChar(' ', 13 - Length(Desconto)) + Desconto;
    Acrescimo  := FloatToStrF(Movimento.TotalAcrescimo,ffNumber,11,2);
    Acrescimo  := StringOfChar(' ', 13 - Length(Acrescimo)) + Acrescimo;
    Recebido   := FloatToStrF(Movimento.TotalRecebido,ffNumber,11,2);
    Recebido   := StringOfChar(' ', 13 - Length(Recebido)) + Recebido;
    Troco      := FloatToStrF(Movimento.TotalTroco,ffNumber,11,2);
    Troco      := StringOfChar(' ', 13 - Length(Troco)) + Troco;
    Cancelado  := FloatToStrF(Movimento.TotalCancelado,ffNumber,11,2);
    Cancelado  := StringOfChar(' ', 13 - Length(Cancelado)) + Cancelado;
    TotalFinal := FloatToStrF(Movimento.TotalFinal,ffNumber,11,2);
    TotalFinal := StringOfChar(' ', 13 - Length(TotalFinal)) + TotalFinal;

    FDataModule.ACBrECF.LinhaRelatorioGerencial('SUPRIMENTO...: '+Suprimento);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('SANGRIA......: '+Sangria);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('NAO FISCAL...: '+NaoFiscal);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('TOTAL VENDA..: '+TotalVenda);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('DESCONTO.....: '+Desconto);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('ACRESCIMO....: '+Acrescimo);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('RECEBIDO.....: '+Recebido);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('TROCO........: '+Troco);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('CANCELADO....: '+Cancelado);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('TOTAL FINAL..: '+TotalFinal);
    FDataModule.ACBrECF.PulaLinhas(3);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('                 CALCULADO  DECLARADO  DIFERENCA');

    TotalGerado := TTotalTipoPagamentoController.EncerramentoTotal(Movimento.Id,1);

    if CDSResumo.Active then
      CDSResumo.EmptyDataSet
    else
      CDSResumo.CreateDataSet;

    //BY CLAUSQUELLER  - calcula a sangria e o suprimento.
    CDSResumo.Append;
    CDSResumoTIPO_PAGAMENTO.AsString := 'DINHEIRO';
    CDSResumoCALCULADO.AsFloat := Movimento.TotalSuprimento - Movimento.TotalSangria;
    CDSResumo.Post;
    //****************************

    for i := 0 to Pred(TotalGerado.Count) do
    begin
      if CDSResumo.Locate('TIPO_PAGAMENTO',TMeiosPagamentoVO(TotalGerado.Items[I]).Descricao,[loCaseInsensitive]) then
      begin
        CDSResumo.Edit;
        CDSResumoCALCULADO.AsFloat := CDSResumoCALCULADO.AsFloat + TMeiosPagamentoVO(TotalGerado.Items[I]).Total;
        CDSResumo.Post;
      end
      else
      begin
        CDSResumo.Append;
        CDSResumoTIPO_PAGAMENTO.AsString := TMeiosPagamentoVO(TotalGerado.Items[I]).Descricao;
        CDSResumoCALCULADO.AsFloat := TMeiosPagamentoVO(TotalGerado.Items[I]).Total;
        CDSResumo.Post;
      end;
    end;

    TotalDeclarado := TTotalTipoPagamentoController.EncerramentoTotal(Movimento.Id,2);

    for i := 0 to Pred(TotalDeclarado.Count) do
    begin
      if CDSResumo.Locate('TIPO_PAGAMENTO',TMeiosPagamentoVO(TotalDeclarado.Items[I]).Descricao,[loCaseInsensitive]) then
      begin
        CDSResumo.Edit;
        CDSResumoDECLARADO.AsFloat := CDSResumoDECLARADO.AsFloat + TMeiosPagamentoVO(TotalDeclarado.Items[I]).Total;
        CDSResumo.Post;
      end
      else
      begin
        CDSResumo.Append;
        CDSResumoTIPO_PAGAMENTO.AsString := TMeiosPagamentoVO(TotalDeclarado.Items[I]).Descricao;
        CDSResumoDECLARADO.AsFloat := TMeiosPagamentoVO(TotalDeclarado.Items[I]).Total;
        CDSResumo.Post;
      end;
    end;

    TotCalculado := 0;
    TotDeclarado := 0;
    TotDiferenca := 0;

    CDSResumo.First;
    while not CDSResumo.Eof do
    begin
      Calculado := FloatToStrF(CDSResumoCALCULADO.AsFloat,ffNumber,9,2);
      Calculado := StringOfChar(' ', 11 - Length(Calculado)) + Calculado;

      Declarado := FloatToStrF(CDSResumoDECLARADO.AsFloat,ffNumber,9,2);
      Declarado := StringOfChar(' ', 11 - Length(Declarado)) + Declarado;

      Diferenca := FloatToStrF(CDSResumoDIFERENCA.AsFloat,ffNumber,9,2);
      Diferenca := StringOfChar(' ', 11 - Length(Diferenca)) + Diferenca;

      Meio := Copy(CDSResumoTIPO_PAGAMENTO.AsString,1,15);
      Meio := StringOfChar(' ', 15 - Length(Meio)) + Meio;

      TotCalculado := TotCalculado + CDSResumoCALCULADO.AsFloat;
      TotDeclarado := TotDeclarado + CDSResumoDECLARADO.AsFloat;
      TotDiferenca := TotDiferenca + CDSResumoDIFERENCA.AsFloat;

      FDataModule.ACBrECF.LinhaRelatorioGerencial(Meio+Calculado+Declarado+Diferenca);

      CDSResumo.Next;
    end;

    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('-',48));

    Calculado := FloatToStrF(TotCalculado,ffNumber,9,2);
    Calculado := StringOfChar(' ', 11 - Length(Calculado)) + Calculado;
    Declarado := FloatToStrF(TotDeclarado,ffNumber,9,2);
    Declarado := StringOfChar(' ', 11 - Length(Declarado)) + Declarado;
    Diferenca := FloatToStrF(TotDiferenca,ffNumber,9,2);
    Diferenca := StringOfChar(' ', 11 - Length(Diferenca)) + Diferenca;

    FDataModule.ACBrECF.LinhaRelatorioGerencial('TOTAL.........:'+Calculado+Declarado+Diferenca);
    FDataModule.ACBrECF.PulaLinhas(4);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('    ________________________________________    ');
    FDataModule.ACBrECF.LinhaRelatorioGerencial('                 VISTO DO CAIXA                 ');
    FDataModule.ACBrECF.PulaLinhas(3);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('    ________________________________________    ');
    FDataModule.ACBrECF.LinhaRelatorioGerencial('               VISTO DO SUPERVISOR              ');

    FDataModule.ACBrECF.FechaRelatorio;
    UPAF.GravaR06('RG');
    Application.ProcessMessages;

  finally
    if Assigned(TotalGerado) then
      FreeAndNil(TotalGerado);
    if Assigned(TotalDeclarado) then
      FreeAndNil(TotalDeclarado);
  end;
end;

end.
