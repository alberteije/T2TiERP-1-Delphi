{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Movimento Caixa/Banco

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

  @author Albert Eije
  @version 1.0
  ******************************************************************************* }
unit UFinMovimentoCaixaBanco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Atributos,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ViewFinMovimentoCaixaBancoVO,
  ViewFinMovimentoCaixaBancoController, Tipos, Constantes, LabeledCtrls,
  ActnList, RibbonSilverStyleActnCtrls, ActnMan, Mask, JvExMask, JvToolEdit,
  JvExStdCtrls, JvEdit, JvValidateEdit, ToolWin, ActnCtrls, JvBaseEdits,
  Generics.Collections, Biblioteca, RTTI, PlatformDefaultStyleActnCtrls,
  FinFechamentoCaixaBancoVO;

type
  [TFormDescription(TConstantes.MODULO_FINANCEIRO, 'Movimento Caixa Banco')]

  TFFinMovimentoCaixaBanco = class(TFTelaCadastro)
    BevelEdits: TBevel;
    PanelEditsInterno: TPanel;
    DSMovimentoCaixaBanco: TDataSource;
    CDSMovimentoCaixaBanco: TClientDataSet;
    EditIdContaCaixa: TLabeledCalcEdit;
    EditContaCaixa: TLabeledEdit;
    GroupBox1: TGroupBox;
    PanelGridInterna: TPanel;
    GridPagamentos: TJvDBUltimGrid;
    PanelTotais: TPanel;
    CDSMovimentoCaixaBancoID_CONTA_CAIXA: TIntegerField;
    CDSMovimentoCaixaBancoNOME_CONTA_CAIXA: TStringField;
    CDSMovimentoCaixaBancoNOME_PESSOA: TStringField;
    CDSMovimentoCaixaBancoDATA_LANCAMENTO: TDateField;
    CDSMovimentoCaixaBancoDATA_PAGO_RECEBIDO: TDateField;
    CDSMovimentoCaixaBancoHISTORICO: TStringField;
    CDSMovimentoCaixaBancoVALOR: TFMTBCDField;
    CDSMovimentoCaixaBancoDESCRICAO_DOCUMENTO_ORIGEM: TStringField;
    CDSMovimentoCaixaBancoOPERACAO: TStringField;
    PanelTotaisGeral: TPanel;
    ActionManager1: TActionManager;
    ActionProcessarFechamento: TAction;
    ActionToolBar1: TActionToolBar;
    EditMesAno: TMaskEdit;
    DSChequeNaoCompensado: TDataSource;
    CDSChequeNaoCompensado: TClientDataSet;
    CDSChequeNaoCompensadoID_CONTA_CAIXA: TIntegerField;
    CDSChequeNaoCompensadoNOME_CONTA_CAIXA: TStringField;
    CDSChequeNaoCompensadoTALAO: TStringField;
    CDSChequeNaoCompensadoNUMERO_TALAO: TIntegerField;
    CDSChequeNaoCompensadoNUMERO_CHEQUE: TIntegerField;
    CDSChequeNaoCompensadoSTATUS_CHEQUE: TStringField;
    CDSChequeNaoCompensadoDATA_STATUS: TDateField;
    CDSChequeNaoCompensadoVALOR: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure BotaoConsultarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CalcularTotais;
    procedure CalcularTotaisGeral;
    procedure ActionProcessarFechamentoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;
    procedure LimparCampos; override;
    function MontaFiltro: string; override;

    // Controles CRUD
    function DoEditar: Boolean; override;
  end;

var
  FFinMovimentoCaixaBanco: TFFinMovimentoCaixaBanco;
  Recebimentos, Pagamentos, Saldo: Extended;
  FechamentoVO: TFinFechamentoCaixaBancoVO;

implementation

uses
  UTela, UDataModule, FinFechamentoCaixaBancoController, ViewFinChequeNaoCompensadoVO,
  ViewFinChequeNaoCompensadoController;

{$R *.dfm}

{$REGION 'Infra'}
procedure TFFinMovimentoCaixaBanco.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TViewFinMovimentoCaixaBancoVO;
  ObjetoController := TViewFinMovimentoCaixaBancoController.Create;

  inherited;
end;

procedure TFFinMovimentoCaixaBanco.FormShow(Sender: TObject);
begin
  inherited;
  EditMesAno.Text := Copy(DateTimeToStr(Date), 4, 7);
end;

procedure TFFinMovimentoCaixaBanco.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoCancelar.Visible := False;
  BotaoAlterar.Caption := 'Filtrar Conta [F3]';
  BotaoAlterar.Hint := 'Filtrar Conta [F3]';
  BotaoAlterar.Width := 120;
  BotaoSalvar.Caption := 'Retornar [F12]';
  BotaoSalvar.Hint := 'Retornar [F12]';
end;

procedure TFFinMovimentoCaixaBanco.ControlaPopupMenu;
begin
  inherited;

  MenuInserir.Visible := False;
  MenuExcluir.Visible := False;
  MenuCancelar.Visible := False;
  MenuAlterar.Caption := 'Filtrar Conta [F3]';
  menuSalvar.Caption := 'Retornar [F12]';
end;

procedure TFFinMovimentoCaixaBanco.LimparCampos;
var
  MesAnoInformado: String;
begin
  MesAnoInformado := EditMesAno.Text;
  inherited;
  CDSMovimentoCaixaBanco.EmptyDataSet;
  EditMesAno.Text := MesAnoInformado;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFinMovimentoCaixaBanco.DoEditar: Boolean;
begin
  Result := inherited DoEditar;
  if Result then
  begin
    EditIdContaCaixa.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFFinMovimentoCaixaBanco.GridParaEdits;
var
  FiltroLocal: String;
begin
  inherited;

  EditIdContaCaixa.AsInteger := CDSGrid.FieldByName('ID_CONTA_CAIXA').AsInteger;
  EditContaCaixa.Text := CDSGrid.FieldByName('NOME_CONTA_CAIXA').AsString;
  //
  TViewFinMovimentoCaixaBancoController.SetDataSet(CDSMovimentoCaixaBanco);
  FiltroLocal := 'ID_CONTA_CAIXA=' + QuotedStr(EditIdContaCaixa.Text) + ' and extract(month from(DATA_PAGO_RECEBIDO))=' + Copy(EditMesAno.Text, 1, 2) + ' and extract(year from(DATA_PAGO_RECEBIDO))=' + Copy(EditMesAno.Text, 4, 4);
  TViewFinMovimentoCaixaBancoController.Consulta(FiltroLocal, 0);
  //
  FiltroLocal := '[MES_ANO]=' + QuotedStr(EditMesAno.Text) + ' and ' + '[ID_CONTA_CAIXA]=' + QuotedStr(EditIdContaCaixa.Text);
  FechamentoVO := TFinFechamentoCaixaBancoController.VO<TFinFechamentoCaixaBancoVO>(FiltroLocal);
  //
  CalcularTotais;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFFinMovimentoCaixaBanco.ActionProcessarFechamentoExecute(Sender: TObject);
var
  FiltroLocal: String;
  FechamentoAnteriorVO: TFinFechamentoCaixaBancoVO;
  SaldoAnterior, ChequesNaoCompensados: Extended;
begin
  SaldoAnterior := 0;
  Pagamentos := 0;
  Recebimentos := 0;
  ChequesNaoCompensados := 0;

  if Application.MessageBox('Deseja processar o fechamento?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    FiltroLocal := '[MES_ANO]=' + QuotedStr(PeriodoAnterior(EditMesAno.Text)) + ' and ' + '[ID_CONTA_CAIXA]=' + QuotedStr(EditIdContaCaixa.Text);
    FechamentoAnteriorVO := TFinFechamentoCaixaBancoController.VO<TFinFechamentoCaixaBancoVO>(FiltroLocal);
    if Assigned(FechamentoAnteriorVO) then
      SaldoAnterior := FechamentoAnteriorVO.SaldoDisponivel
    else
      SaldoAnterior := 0;

    TViewFinChequeNaoCompensadoController.SetDataSet(CDSChequeNaoCompensado);
    TViewFinChequeNaoCompensadoController.Consulta('ID_CONTA_CAIXA=' + QuotedStr(EditIdContaCaixa.Text), 0);

    CDSChequeNaoCompensado.DisableControls;
    CDSChequeNaoCompensado.First;
    while not CDSChequeNaoCompensado.Eof do
    begin
      ChequesNaoCompensados := ChequesNaoCompensados + CDSChequeNaoCompensado.FieldByName('VALOR').AsExtended;
      CDSChequeNaoCompensado.Next;
    end;
    CDSChequeNaoCompensado.First;
    CDSChequeNaoCompensado.EnableControls;

    CDSMovimentoCaixaBanco.DisableControls;
    CDSMovimentoCaixaBanco.First;
    while not CDSMovimentoCaixaBanco.Eof do
    begin
      if CDSMovimentoCaixaBanco.FieldByName('OPERACAO').AsString = 'S' then
        Pagamentos := Pagamentos + CDSMovimentoCaixaBanco.FieldByName('VALOR').AsExtended
      else if CDSMovimentoCaixaBanco.FieldByName('OPERACAO').AsString = 'E' then
        Recebimentos := Recebimentos + CDSMovimentoCaixaBanco.FieldByName('VALOR').AsExtended;
      CDSMovimentoCaixaBanco.Next;
    end;
    CDSMovimentoCaixaBanco.First;
    CDSMovimentoCaixaBanco.EnableControls;

    if not Assigned(FechamentoVO) then
      FechamentoVO := TFinFechamentoCaixaBancoVO.Create;

    FechamentoVO.IdContaCaixa := EditIdContaCaixa.AsInteger;
    FechamentoVO.DataFechamento := Now;
    FechamentoVO.MesAno := EditMesAno.Text;
    FechamentoVO.Mes := Copy(EditMesAno.Text, 1, 2);
    FechamentoVO.Ano := Copy(EditMesAno.Text, 4, 4);
    FechamentoVO.SaldoAnterior := SaldoAnterior;
    FechamentoVO.Recebimentos := Recebimentos;
    FechamentoVO.Pagamentos := Pagamentos;
    FechamentoVO.SaldoConta := SaldoAnterior + Recebimentos - Pagamentos;
    FechamentoVO.ChequeNaoCompensado := ChequesNaoCompensados;
    FechamentoVO.SaldoDisponivel := SaldoAnterior + Recebimentos - Pagamentos - ChequesNaoCompensados;

    DecimalSeparator := '.';

    if FechamentoVO.Id > 0 then
      TFinFechamentoCaixaBancoController.Altera(FechamentoVO, FechamentoVO)
    else
      TFinFechamentoCaixaBancoController.Insere(FechamentoVO);

    DecimalSeparator := ',';

    FiltroLocal := '[MES_ANO]=' + QuotedStr(EditMesAno.Text) + ' and ' + '[ID_CONTA_CAIXA]=' + QuotedStr(EditIdContaCaixa.Text);
    FechamentoVO := TFinFechamentoCaixaBancoController.VO<TFinFechamentoCaixaBancoVO>(FiltroLocal);

    CalcularTotais;
  end;
end;

procedure TFFinMovimentoCaixaBanco.BotaoConsultarClick(Sender: TObject);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
begin
  Filtro := MontaFiltro;

  if Filtro <> 'ERRO' then
  begin
    Pagina := 0;
    Contexto := TRttiContext.Create;
    try
      Tipo := Contexto.GetType(ObjetoController.ClassType);
      ObjetoController.SetDataSet(CDSGrid);
      Tipo.GetMethod('Consulta').Invoke(ObjetoController.ClassType, [Trim(Filtro), Pagina]);
      ControlaBotoesNavegacaoPagina;
    finally
      Contexto.Free;
    end;

    if not CDSGrid.IsEmpty then
      Grid.SetFocus;

    CalcularTotaisGeral;
  end
  else
    EditCriterioRapido.SetFocus;
end;

procedure TFFinMovimentoCaixaBanco.BotaoSalvarClick(Sender: TObject);
begin
  inherited;
  //BotaoConsultar.Click;
end;

function TFFinMovimentoCaixaBanco.MontaFiltro: string;
var
  Item: TItemComboBox;
  Idx: Integer;
  DataSetField: TField;
  DataSet: TClientDataSet;
begin
  DataSet := CDSGrid;
  if ComboBoxCampos.ItemIndex <> -1 then
  begin
    if Trim(EditCriterioRapido.Text) = '' then
      EditCriterioRapido.Text := '*';

    Idx := ComboBoxCampos.ItemIndex;
    Item := TItemComboBox(ComboBoxCampos.Items.Objects[Idx]);
    DataSetField := DataSet.FindField(Item.Campo);
    if DataSetField.DataType = ftDateTime then
    begin
      try
        Result := '[' + Item.Campo + '] IN ' + '(' + QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(EditCriterioRapido.Text))) + ')';
      except
        Application.MessageBox('Data informada inv�lida.', 'Erro', MB_OK + MB_ICONERROR);
        Result := 'ERRO';
      end;
    end
    else
      Result := 'extract(month from(DATA_PAGO_RECEBIDO))=' + Copy(EditMesAno.Text, 1, 2) + ' and extract(year from(DATA_PAGO_RECEBIDO))=' + Copy(EditMesAno.Text, 4, 4) + ' and [' + Item.Campo + '] LIKE ' + QuotedStr('%' + EditCriterioRapido.Text + '%');
  end
  else
  begin
    Result := ' 1=1 ';
  end;
end;

procedure TFFinMovimentoCaixaBanco.CalcularTotais;
begin
  if Assigned(FechamentoVO) then
  begin
    PanelTotais.Caption :=

    '|      SaldoAnterior: ' +  FloatToStrF(FechamentoVO.SaldoAnterior, ffCurrency, 15, 2) +
    '      |      Recebimentos: ' +   FloatToStrF(FechamentoVO.Recebimentos, ffCurrency, 15, 2) +
    '      |      Pagamentos: ' +   FloatToStrF(FechamentoVO.Pagamentos, ffCurrency, 15, 2) +
    '      |      Saldo Conta: ' +   FloatToStrF(FechamentoVO.SaldoConta, ffCurrency, 15, 2) +
    '      |      Cheque n�o Compensado: ' +   FloatToStrF(FechamentoVO.ChequeNaoCompensado, ffCurrency, 15, 2) +
    '      |      Saldo Dispon�vel: ' +   FloatToStrF(FechamentoVO.SaldoDisponivel, ffCurrency, 15, 2) + '      |';

  end
  else
    PanelTotais.Caption := 'Fechamento n�o realizado.';
end;

procedure TFFinMovimentoCaixaBanco.CalcularTotaisGeral;
begin
  Recebimentos := 0;
  Pagamentos := 0;
  Saldo := 0;
  //
  CDSGrid.DisableControls;
  CDSGrid.First;
  while not CDSGrid.Eof do
  begin
    if CDSGrid.FieldByName('OPERACAO').AsString = 'S' then
      Pagamentos := Pagamentos + CDSGrid.FieldByName('VALOR').AsExtended
    else if CDSGrid.FieldByName('OPERACAO').AsString = 'E' then
      Recebimentos := Recebimentos + CDSGrid.FieldByName('VALOR').AsExtended;
    CDSGrid.Next;
  end;
  CDSGrid.First;
  CDSGrid.EnableControls;
  //
  PanelTotaisGeral.Caption := '|      Recebimentos: ' +  FloatToStrF(Recebimentos, ffCurrency, 15, 2) +
                        '      |      Pagamentos: ' +   FloatToStrF(Pagamentos, ffCurrency, 15, 2) +
                        '      |      Saldo: ' +   FloatToStrF(Recebimentos - Pagamentos, ffCurrency, 15, 2) + '      |';
end;
{$ENDREGION}

end.
