{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Pagamento das Parcelas

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
unit UFinParcelaPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Atributos,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ViewFinLancamentoPagarVO,
  ViewFinLancamentoPagarController, Tipos, Constantes, LabeledCtrls,
  ActnList, RibbonSilverStyleActnCtrls, ActnMan, Mask, JvExMask, JvToolEdit,
  JvExStdCtrls, JvEdit, JvValidateEdit, ToolWin, ActnCtrls, JvBaseEdits,
  Generics.Collections, Biblioteca, RTTI, FinChequeEmitidoVO, AdmParametroVO;

type
  [TFormDescription(TConstantes.MODULO_FINANCEIRO, 'Emiss�o de Cheques')]

  TFFinParcelaPagamento = class(TFTelaCadastro)
    BevelEdits: TBevel;
    PanelEditsInterno: TPanel;
    EditDataPagamento: TLabeledDateEdit;
    EditTaxaJuro: TLabeledCalcEdit;
    EditValorJuro: TLabeledCalcEdit;
    EditValorMulta: TLabeledCalcEdit;
    EditValorDesconto: TLabeledCalcEdit;
    EditTaxaDesconto: TLabeledCalcEdit;
    EditTaxaMulta: TLabeledCalcEdit;
    MemoHistorico: TLabeledMemo;
    ActionManager: TActionManager;
    ActionBaixarParcela: TAction;
    DSParcelaPagamento: TDataSource;
    CDSParcelaPagamento: TClientDataSet;
    CDSParcelaPagamentoID: TIntegerField;
    CDSParcelaPagamentoID_FIN_PARCELA_PAGAR: TIntegerField;
    CDSParcelaPagamentoID_FIN_CHEQUE_EMITIDO: TIntegerField;
    CDSParcelaPagamentoID_FIN_TIPO_PAGAMENTO: TIntegerField;
    CDSParcelaPagamentoID_CONTA_CAIXA: TIntegerField;
    CDSParcelaPagamentoDATA_PAGAMENTO: TDateField;
    CDSParcelaPagamentoTAXA_JURO: TFMTBCDField;
    CDSParcelaPagamentoTAXA_MULTA: TFMTBCDField;
    CDSParcelaPagamentoTAXA_DESCONTO: TFMTBCDField;
    CDSParcelaPagamentoVALOR_JURO: TFMTBCDField;
    CDSParcelaPagamentoVALOR_MULTA: TFMTBCDField;
    CDSParcelaPagamentoVALOR_DESCONTO: TFMTBCDField;
    CDSParcelaPagamentoVALOR_PAGO: TFMTBCDField;
    CDSParcelaPagamentoCONTA_CAIXANOME: TStringField;
    CDSParcelaPagamentoTIPO_PAGAMENTODESCRICAO: TStringField;
    CDSParcelaPagamentoCHEQUENUMERO: TIntegerField;
    EditIdTipoPagamento: TLabeledCalcEdit;
    EditCodigoTipoPagamento: TLabeledEdit;
    EditTipoPagamento: TLabeledEdit;
    EditIdContaCaixa: TLabeledCalcEdit;
    EditContaCaixa: TLabeledEdit;
    EditValorPago: TLabeledCalcEdit;
    EditValorAPagar: TLabeledCalcEdit;
    EditDataVencimento: TLabeledDateEdit;
    CDSParcelaPagamentoHISTORICO: TStringField;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditDataInicio: TLabeledDateEdit;
    EditDataFim: TLabeledDateEdit;
    PanelParcelaPaga: TPanel;
    GridPagamentos: TJvDBUltimGrid;
    ActionToolBar1: TActionToolBar;
    ComboBoxTipoBaixa: TLabeledComboBox;
    PopupMenuExluiParcela: TPopupMenu;
    ExcluirParcelaPaga1: TMenuItem;
    PanelTotaisPagos: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ActionBaixarParcelaExecute(Sender: TObject);
    procedure CalcularTotalPago(Sender: TObject);
    procedure EditIdTipoPagamentoExit(Sender: TObject);
    procedure EditIdTipoPagamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdTipoPagamentoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdContaCaixaExit(Sender: TObject);
    procedure EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure BotaoConsultarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ExcluirParcelaPaga1Click(Sender: TObject);
    procedure BaixarParcela;
    procedure BaixarParcelaCheque;
    procedure CalcularTotais;
    procedure GridDblClick(Sender: TObject);
    procedure GridCellClick(Column: TColumn);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    function VerificarPacotePagamentoCheque: Boolean;
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
  FFinParcelaPagamento: TFFinParcelaPagamento;
  ChequeEmitido: TFinChequeEmitidoVO;
  SomaCheque: Extended;
  AdmParametroVO: TAdmParametroVO;

implementation

uses
  FinParcelaPagamentoVO, FinParcelaPagamentoController, FinParcelaPagarVO,
  FinParcelaPagarController, FinTipoPagamentoVO, FinTipoPagamentoController,
  ContaCaixaVO, ContaCaixaController, UTela, USelecionaCheque, UDataModule,
  AdmParametroController;

{$R *.dfm}

{$REGION 'Infra'}
procedure TFFinParcelaPagamento.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TViewFinLancamentoPagarVO;
  ObjetoController := TViewFinLancamentoPagarController.Create;

  inherited;

  AdmParametroVO := TAdmParametroController.VO<TAdmParametroVO>('ID_EMPRESA', IntToStr(Sessao.IdEmpresa));
end;

procedure TFFinParcelaPagamento.FormShow(Sender: TObject);
begin
  inherited;
  EditDataInicio.Date := Now;
  EditDataFim.Date := Now;
end;

procedure TFFinParcelaPagamento.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
  BotaoInserir.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoCancelar.Visible := False;
  BotaoAlterar.Caption := 'Confirmar [F3]';
  BotaoSalvar.Caption := 'Retornar [F12]';
end;

procedure TFFinParcelaPagamento.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
  MenuInserir.Visible := False;
  MenuExcluir.Visible := False;
  MenuCancelar.Visible := False;
  MenuAlterar.Caption := 'Confirmar [F3]';
  menuSalvar.Caption := 'Retornar [F12]';
end;

procedure TFFinParcelaPagamento.LimparCampos;
var
  DataInicioInformada, DataFimInformada: TDateTime;
begin
  DataInicioInformada := EditDataInicio.Date;
  DataFimInformada := EditDataFim.Date;
  inherited;
  CDSParcelaPagamento.EmptyDataSet;
  EditDataInicio.Date := DataInicioInformada;
  EditDataFim.Date := DataFimInformada;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFinParcelaPagamento.DoEditar: Boolean;
begin
  if not CDSGrid.IsEmpty then
  begin
    if VerificarPacotePagamentoCheque then
    begin
      ChequeEmitido := TFinChequeEmitidoVO.Create;

      Application.CreateForm(TFSelecionaCheque, FSelecionaCheque);
      FSelecionaCheque.EditValorCheque.Value := SomaCheque;
      FSelecionaCheque.ShowModal;

      if FSelecionaCheque.Confirmou then
      begin
        ChequeEmitido.IdCheque := FSelecionaCheque.CDSChequesEmSerID_CHEQUE.AsInteger;
        ChequeEmitido.DataEmissao := now;
        ChequeEmitido.Valor := FSelecionaCheque.EditValorCheque.Value;
        ChequeEmitido.NominalA := FSelecionaCheque.EditNominalA.Text;
        ChequeEmitido.BomPara := FSelecionaCheque.EditBomPara.Date;
        BaixarParcelaCheque;
        FreeAndNil(FSelecionaCheque);
      end;
    end
    else
    begin
      Result := inherited DoEditar;

      if Result then
      begin
        ComboBoxTipoBaixa.SetFocus;
      end;
    end;
  end;
end;

function TFFinParcelaPagamento.VerificarPacotePagamentoCheque: Boolean;
var
  LinhaAtual: TBookMark;
  ParcelasVencidas: Boolean;
begin
  Result := False;
  ParcelasVencidas := False;
  LinhaAtual := CDSGrid.GetBookmark;
  SomaCheque := 0;

  CDSGrid.DisableControls;
  CDSGrid.First;
  while not CDSGrid.Eof do
  begin
    if CDSGrid.FieldByName('EmitirCheque').AsString = 'S' then
      SomaCheque := SomaCheque + CDSGrid.FieldByName('VALOR_PARCELA').AsFloat;
    ParcelasVencidas := CDSGrid.FieldByName('DATA_VENCIMENTO').AsDateTime < Date;
    CDSGrid.Next;
  end;

  if CDSGrid.BookmarkValid(LinhaAtual) then
  begin
    CDSGrid.GotoBookmark(LinhaAtual);
    CDSGrid.FreeBookmark(LinhaAtual);
  end;
  CDSGrid.EnableControls;

  if SomaCheque = 0 then
    Exit;

  if ParcelasVencidas then
  begin
    Application.MessageBox('Procedimento n�o permitido. Parcela sem valores ou vencidas.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    CDSGrid.EnableControls;
    Exit;
  end;

  Result := True;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFinParcelaPagamento.EditIdContaCaixaExit(Sender: TObject);
var
  Filtro: String;
begin
   if EditIdContaCaixa.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdContaCaixa.Text;
      EditIdContaCaixa.Clear;
      EditContaCaixa.Clear;
      if not PopulaCamposTransientes(Filtro, TContaCaixaVO, TContaCaixaController) then
        PopulaCamposTransientesLookup(TContaCaixaVO, TContaCaixaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdContaCaixa.Text := CDSTransiente.FieldByName('ID').AsString;
        EditContaCaixa.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdContaCaixa.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContaCaixa.Clear;
  end;
end;

procedure TFFinParcelaPagamento.EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContaCaixa.Value := -1;
    EditDataVencimento.SetFocus;
  end;
end;

procedure TFFinParcelaPagamento.EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDataVencimento.SetFocus;
  end;
end;

procedure TFFinParcelaPagamento.EditIdTipoPagamentoExit(Sender: TObject);
var
  Filtro: String;
begin
   if EditIdTipoPagamento.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdTipoPagamento.Text;
      EditIdTipoPagamento.Clear;
      EditCodigoTipoPagamento.Clear;
      EditTipoPagamento.Clear;
      if not PopulaCamposTransientes(Filtro, TFinTipoPagamentoVO, TFinTipoPagamentoController) then
        PopulaCamposTransientesLookup(TFinTipoPagamentoVO, TFinTipoPagamentoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdTipoPagamento.Text := CDSTransiente.FieldByName('ID').AsString;
        EditCodigoTipoPagamento.Text := CDSTransiente.FieldByName('TIPO').AsString;
        EditTipoPagamento.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditIdTipoPagamento.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCodigoTipoPagamento.Clear;
    EditTipoPagamento.Clear;
  end;
end;

procedure TFFinParcelaPagamento.EditIdTipoPagamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdTipoPagamento.Value := -1;
    EditIdContaCaixa.SetFocus;
  end;
end;

procedure TFFinParcelaPagamento.EditIdTipoPagamentoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdContaCaixa.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFFinParcelaPagamento.GridCellClick(Column: TColumn);
begin
  if Column.Index = 0 then
  begin
    if CDSGrid.FieldByName('SITUACAO_PARCELA').AsString = '02' then
    begin
      Application.MessageBox('Procedimento n�o permitido. Parcela j� quitada.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    end
    else
    begin
      CDSGrid.Edit;
      if CDSGrid.FieldByName('EmitirCheque').AsString = '' then
        CDSGrid.FieldByName('EmitirCheque').AsString := 'S'
      else
        CDSGrid.FieldByName('EmitirCheque').AsString := '';
      CDSGrid.Post;
    end;
  end;
end;

procedure TFFinParcelaPagamento.GridDblClick(Sender: TObject);
begin
  //
end;

procedure TFFinParcelaPagamento.GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  lIcone : TBitmap;
  lRect: TRect;
begin
  lRect := Rect;
  lIcone := TBitmap.Create;

  if Column.Index = 0 then
  begin
    if Grid.Columns[0].Width <> 32 then
      Grid.Columns[0].Width := 32;

    try
      if Grid.Columns[1].Field.Value = '' then
      begin
        FDataModule.ImagensCheck.GetBitmap(0, lIcone);
        Grid.Canvas.Draw(Rect.Left+8 ,Rect.Top+1, lIcone);
      end
      else if Grid.Columns[1].Field.Value = 'S' then
      begin
        FDataModule.ImagensCheck.GetBitmap(1, lIcone);
        Grid.Canvas.Draw(Rect.Left+8,Rect.Top+1, lIcone);
      end
    finally
      lIcone.Free;
    end;
  end;
end;

procedure TFFinParcelaPagamento.GridParaEdits;
var
  ParcelaPagarEnumerator: TEnumerator<TFinParcelaPagarVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TViewFinLancamentoPagarVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdContaCaixa.AsInteger := TViewFinLancamentoPagarVO(ObjetoVO).IdContaCaixa;
    EditContaCaixa.Text := TViewFinLancamentoPagarVO(ObjetoVO).NomeContaCaixa;
    EditDataVencimento.Date := TViewFinLancamentoPagarVO(ObjetoVO).DataVencimento;
    EditValorAPagar.Value := TViewFinLancamentoPagarVO(ObjetoVO).ValorParcela;
    EditTaxaJuro.Value := TViewFinLancamentoPagarVO(ObjetoVO).TaxaJuro;
    EditValorJuro.Value := TViewFinLancamentoPagarVO(ObjetoVO).ValorJuro;
    EditTaxaMulta.Value := TViewFinLancamentoPagarVO(ObjetoVO).TaxaMulta;
    EditValorMulta.Value := TViewFinLancamentoPagarVO(ObjetoVO).ValorMulta;
    EditTaxaDesconto.Value := TViewFinLancamentoPagarVO(ObjetoVO).TaxaDesconto;
    EditValorDesconto.Value := TViewFinLancamentoPagarVO(ObjetoVO).ValorDesconto;
    CalcularTotalPago(nil);

    TFinParcelaPagamentoController.SetDataSet(CDSParcelaPagamento);
    TFinParcelaPagamentoController.Consulta('ID_FIN_PARCELA_PAGAR=' + QuotedStr(IntToStr(CDSGrid.FieldByName('ID_PARCELA_PAGAR').AsInteger)), 0);
    CalcularTotais;
  end;
end;

procedure TFFinParcelaPagamento.ExcluirParcelaPaga1Click(Sender: TObject);
var
  ParcelaPagar, ParcelaPagarOld: TFinParcelaPagarVO;
begin
  DecimalSeparator := '.';
  if CDSParcelaPagamentoID.AsInteger > 0 then
    TFinParcelaPagamentoController.Exclui(CDSParcelaPagamentoID.AsInteger);
  CDSParcelaPagamento.Delete;

  if CDSParcelaPagamento.IsEmpty then
  begin
    ParcelaPagarOld := TFinParcelaPagarController.VO<TFinParcelaPagarVO>(CDSGrid.FieldByName('ID_PARCELA_PAGAR').AsInteger);
    ParcelaPagar := TFinParcelaPagarController.VO<TFinParcelaPagarVO>(CDSGrid.FieldByName('ID_PARCELA_PAGAR').AsInteger);
    ParcelaPagar.IdFinStatusParcela := 1;
    TFinParcelaPagarController.Altera(ParcelaPagar, ParcelaPagarOld);
  end;
  DecimalSeparator := ',';
  CalcularTotais;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFFinParcelaPagamento.ActionBaixarParcelaExecute(Sender: TObject);
begin
  if EditIdTipoPagamento.AsInteger <= 0 then
  begin
    Application.MessageBox('� necess�rio informar o tipo de pagamento.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdTipoPagamento.SetFocus;
    Exit;
  end;
  if EditIdContaCaixa.AsInteger <= 0 then
  begin
    Application.MessageBox('� necess�rio informar a conta caixa.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdContaCaixa.SetFocus;
    Exit;
  end;

  ChequeEmitido := TFinChequeEmitidoVO.Create;

  if EditCodigoTipoPagamento.Text = '02' then
  begin
    Application.CreateForm(TFSelecionaCheque, FSelecionaCheque);
    FSelecionaCheque.EditBomPara.Date := EditDataPagamento.Date;
    FSelecionaCheque.EditValorCheque.Value := EditValorPago.Value;
    FSelecionaCheque.MemoHistorico.Text := MemoHistorico.Text;
    FSelecionaCheque.ShowModal;

    if FSelecionaCheque.Confirmou then
    begin
      ChequeEmitido.IdCheque := FSelecionaCheque.CDSChequesEmSerID_CHEQUE.AsInteger;
      ChequeEmitido.DataEmissao := now;
      ChequeEmitido.Valor := FSelecionaCheque.EditValorCheque.Value;
      ChequeEmitido.NominalA := FSelecionaCheque.EditNominalA.Text;
      ChequeEmitido.BomPara := FSelecionaCheque.EditBomPara.Date;
      BaixarParcela;
      FreeAndNil(FSelecionaCheque);
    end;
  end
  else
    BaixarParcela;
end;

procedure TFFinParcelaPagamento.BaixarParcela;
var
  ParcelaPagar: TFinParcelaPagarVO;
  ParcelaPagamento: TFinParcelaPagamentoVO;
begin
  DecimalSeparator := '.';
  ParcelaPagar := TFinParcelaPagarController.VO<TFinParcelaPagarVO>(CDSGrid.FieldByName('ID_PARCELA_PAGAR').AsInteger);

  if ComboBoxTipoBaixa.ItemIndex = 0 then
    ParcelaPagar.IdFinStatusParcela := AdmParametroVO.FinParcelaQuitado
  else if ComboBoxTipoBaixa.ItemIndex = 1 then
    ParcelaPagar.IdFinStatusParcela := AdmParametroVO.FinParcelaQuitadoParcial;

  ParcelaPagamento := TFinParcelaPagamentoVO.Create;

  ParcelaPagamento.IdFinTipoPagamento := EditIdTipoPagamento.AsInteger;
  ParcelaPagamento.IdFinParcelaPagar := ParcelaPagar.Id;
  ParcelaPagamento.IdContaCaixa := EditIdContaCaixa.AsInteger;
  ParcelaPagamento.DataPagamento := EditDataPagamento.Date;
  ParcelaPagamento.TaxaJuro := EditTaxaJuro.Value;
  ParcelaPagamento.ValorJuro := EditValorJuro.Value;
  ParcelaPagamento.TaxaMulta := EditTaxaMulta.Value;
  ParcelaPagamento.ValorMulta := EditValorMulta.Value;
  ParcelaPagamento.TaxaDesconto := EditTaxaDesconto.Value;
  ParcelaPagamento.ValorDesconto := EditValorDesconto.Value;
  ParcelaPagamento.Historico := Trim(MemoHistorico.Text);
  ParcelaPagamento.ValorPago := EditValorPago.Value;

  TFinParcelaPagamentoController.Altera(ParcelaPagar, ParcelaPagamento, ChequeEmitido);
  TFinParcelaPagamentoController.SetDataSet(CDSParcelaPagamento);
  TFinParcelaPagamentoController.Consulta('ID_FIN_PARCELA_PAGAR=' + QuotedStr(IntToStr(CDSGrid.FieldByName('ID_PARCELA_PAGAR').AsInteger)), 0);
  DecimalSeparator := ',';
  CalcularTotais;
end;

procedure TFFinParcelaPagamento.BaixarParcelaCheque;
var
  ParcelaPagar: TFinParcelaPagarVO;
  ParcelaPagamento: TFinParcelaPagamentoVO;
  ListaParcelaPagar: TObjectList<TFinParcelaPagarVO>;
  ListaParcelaPagamento: TObjectList<TFinParcelaPagamentoVO>;
begin
  DecimalSeparator := '.';
  ListaParcelaPagar := TObjectList<TFinParcelaPagarVO>.Create;
  ListaParcelaPagamento := TObjectList<TFinParcelaPagamentoVO>.Create;

  CDSGrid.DisableControls;
  CDSGrid.First;
  while not CDSGrid.Eof do
  begin
    if CDSGrid.FieldByName('EmitirCheque').AsString = 'S' then
    begin
      ParcelaPagar := TFinParcelaPagarController.VO<TFinParcelaPagarVO>(CDSGrid.FieldByName('ID_PARCELA_PAGAR').AsInteger);
      ParcelaPagar.IdFinStatusParcela := AdmParametroVO.FinParcelaQuitado;

      ParcelaPagamento := TFinParcelaPagamentoVO.Create;

      ParcelaPagamento.IdFinTipoPagamento := 2;
      ParcelaPagamento.IdFinParcelaPagar := ParcelaPagar.Id;
      ParcelaPagamento.IdContaCaixa := FSelecionaCheque.CDSChequesEmSerID_CONTA_CAIXA.AsInteger;
      ParcelaPagamento.DataPagamento := FSelecionaCheque.EditBomPara.Date;
      ParcelaPagamento.Historico := FSelecionaCheque.MemoHistorico.Text;
      ParcelaPagamento.ValorPago := ParcelaPagar.Valor;

      ListaParcelaPagar.Add(ParcelaPagar);
      ListaParcelaPagamento.Add(ParcelaPagamento);
    end;
    CDSGrid.Next;
  end;
  CDSGrid.First;
  CDSGrid.EnableControls;

  TFinParcelaPagamentoController.Altera(ListaParcelaPagar, ListaParcelaPagamento, ChequeEmitido);
  DecimalSeparator := ',';
  BotaoConsultar.Click;
end;

procedure TFFinParcelaPagamento.BotaoConsultarClick(Sender: TObject);
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
  end
  else
    EditCriterioRapido.SetFocus;
end;

procedure TFFinParcelaPagamento.BotaoSalvarClick(Sender: TObject);
begin
  inherited;
  BotaoConsultar.Click;
end;

function TFFinParcelaPagamento.MontaFiltro: string;
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
      Result := '([DATA_VENCIMENTO] between ' + QuotedStr(DataParaTexto(EditDataInicio.Date)) + ' and ' + QuotedStr(DataParaTexto(EditDataFim.Date)) + ') and [' + Item.Campo + '] LIKE ' + QuotedStr('%' + EditCriterioRapido.Text + '%');
  end
  else
  begin
    Result := ' 1=1 ';
  end;
end;

procedure TFFinParcelaPagamento.CalcularTotalPago(Sender: TObject);
begin
  EditValorJuro.Value := (EditValorAPagar.Value * (EditTaxaJuro.Value / 30) / 100) * (Now - EditDataVencimento.Date);
  EditValorMulta.Value := EditValorAPagar.Value * (EditTaxaMulta.Value / 100);
  EditValorDesconto.Value := EditValorAPagar.Value * (EditTaxaDesconto.Value / 100);
  EditValorPago.Value := EditValorAPagar.Value + EditValorJuro.Value + EditValorMulta.Value - EditValorDesconto.Value;
end;

procedure TFFinParcelaPagamento.CalcularTotais;
var
  Juro, Multa, Desconto, Total, Saldo: Extended;
begin
  Juro := 0;
  Multa := 0;
  Desconto := 0;
  Total := 0;
  Saldo := 0;
  //
  CDSParcelaPagamento.DisableControls;
  CDSParcelaPagamento.First;
  while not CDSParcelaPagamento.Eof do
  begin
    Juro := Juro + CDSParcelaPagamento.FieldByName('VALOR_JURO').AsExtended;
    Multa := Multa + CDSParcelaPagamento.FieldByName('VALOR_MULTA').AsExtended;
    Desconto := Desconto + CDSParcelaPagamento.FieldByName('VALOR_DESCONTO').AsExtended;
    Total := Total + CDSParcelaPagamento.FieldByName('VALOR_PAGO').AsExtended;
    CDSParcelaPagamento.Next;
  end;
  CDSParcelaPagamento.First;
  CDSParcelaPagamento.EnableControls;
  //
  PanelTotaisPagos.Caption := '|      Juros: ' +  FloatToStrF(Juro, ffCurrency, 15, 2) +
                        '      |      Multa: ' +   FloatToStrF(Multa, ffCurrency, 15, 2) +
                        '      |      Desconto: ' +   FloatToStrF(Desconto, ffCurrency, 15, 2) +
                        '      |      Total Pago: ' +   FloatToStrF(Total, ffCurrency, 15, 2) +
                        '      |      Saldo: ' +   FloatToStrF(Total - EditValorAPagar.Value, ffCurrency, 15, 2) + '      |';
end;
{$ENDREGION}

end.
