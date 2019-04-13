{*******************************************************************************
Title: T2Ti ERP
Description: Janela de Recebimento de Parcelas para o Contas a Pagar

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
@version 1.1
*******************************************************************************}
unit UParcelaPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Mask,
  JvExMask, JvToolEdit, Generics.Collections, DBClient, JvPageList;

type
  TFParcelaPagamento = class(TForm)
    ActionManager: TActionManager;
    ActionConfirmarRecebimento: TAction;
    ActionFiltroRapido: TAction;
    PanelToolBar: TPanel;
    ActionToolBarGrid: TActionToolBar;
    ActionCancelar: TAction;
    ActionRetornar: TAction;
    ActionImprimir: TAction;
    ActionPrimeiro: TAction;
    ActionUltimo: TAction;
    ActionAnterior: TAction;
    ActionProximo: TAction;
    ActionSair: TAction;
    ActionExportar: TAction;
    ActionFiltrar: TAction;
    PanelGrid: TPanel;
    PanelEdits: TPanel;
    Grid: TJvDBUltimGrid;
    ActionToolBarEdits: TActionToolBar;
    ActionExportarWord: TAction;
    ActionExportarExcel: TAction;
    ActionExportarXML: TAction;
    ActionExportarCSV: TAction;
    ActionExportarHTML: TAction;
    ActionPaginaAnterior: TAction;
    ActionPaginaProxima: TAction;
    ScreenTipsManagerCadastro: TScreenTipsManager;
    PanelFiltroRapido: TPanel;
    EditCriterioRapido: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    ComboBoxCampos: TComboBox;
    Label1: TLabel;
    ActionConsultar: TAction;
    GridParcelas: TJvDBUltimGrid;
    ActionConfirmarParcela: TAction;
    PanelEditsInterno: TPanel;
    EditTaxaJuro: TJvValidateEdit;
    Label3: TLabel;
    EditDataPagamento: TJvDateEdit;
    Label5: TLabel;
    EditValorJuro: TJvValidateEdit;
    Label2: TLabel;
    EditTaxaMulta: TJvValidateEdit;
    EditValorMulta: TJvValidateEdit;
    EditValorDesconto: TJvValidateEdit;
    EditTaxaDesconto: TJvValidateEdit;
    Label4: TLabel;
    MemoHistorico: TMemo;
    Label7: TLabel;
    EditIdContaCaixa: TJvValidateEdit;
    EditNomeContaCaixa: TLabeledEdit;
    Label6: TLabel;
    EditIdMeioPagamento: TJvValidateEdit;
    EditDescricaoMeioPagamento: TLabeledEdit;
    Label8: TLabel;
    EditValor: TJvValidateEdit;
    Label9: TLabel;
    EditValorPago: TJvValidateEdit;
    Label10: TLabel;
    procedure ActionConfirmarRecebimentoExecute(Sender: TObject);
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionRetornarExecute(Sender: TObject);
    procedure ActionImprimirExecute(Sender: TObject);
    procedure ActionFiltrarExecute(Sender: TObject);
    procedure ActionPrimeiroExecute(Sender: TObject);
    procedure ActionUltimoExecute(Sender: TObject);
    procedure ActionAnteriorExecute(Sender: TObject);
    procedure ActionProximoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FechaFormulario;
    procedure LimparCampos;
    procedure GridParaEdits;
    procedure GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure ActionExportarWordExecute(Sender: TObject);
    procedure ActionExportarExecute(Sender: TObject);
    procedure ActionPaginaAnteriorExecute(Sender: TObject);
    procedure ActionPaginaProximaExecute(Sender: TObject);
    procedure VerificarPaginacao;
    procedure ActionExportarHTMLExecute(Sender: TObject);
    procedure ActionExportarCSVExecute(Sender: TObject);
    procedure ActionExportarXMLExecute(Sender: TObject);
    procedure ActionExportarExcelExecute(Sender: TObject);
    procedure ActionFiltroRapidoExecute(Sender: TObject);
    procedure ActionConsultarExecute(Sender: TObject);
    procedure ActionConfirmarParcelaExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdMeioPagamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditTaxaJuroExit(Sender: TObject);
    procedure EditTaxaMultaExit(Sender: TObject);
    procedure EditTaxaDescontoExit(Sender: TObject);
    procedure EditValorPagoEnter(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FParcelaPagamento: TFParcelaPagamento;

implementation

uses
  ContasPagarReceberVO, UDataModule, UFiltro, Constantes, Biblioteca, ContasParcelasVO,
  ULookup, ParcelaPagamentoController, LancamentoPagarController, ContaCaixaController,
  ContaCaixaVO, MeiosPagamentoController, MeiosPagamentoVO, UMenu;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFParcelaPagamento.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFParcelaPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;

procedure TFParcelaPagamento.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  //Grid principal - dos lançamentos
  FDataModule.CDSLancamentoPagar.Close;
  FDataModule.CDSLancamentoPagar.FieldDefs.Clear;
  FDataModule.CDSLancamentoPagar.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('DESCRICAO_PLANO_CONTA', ftString, 50);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('NOME_TIPO_DOCUMENTO', ftString, 30);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('NOME_PESSOA', ftString, 150);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('NUMERO_DOCUMENTO', ftString, 20);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('QUANTIDADE_PARCELA', ftInteger);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('VALOR', ftFloat);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('DATA_LANCAMENTO', ftString, 10);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('PRIMEIRO_VENCIMENTO', ftString, 10);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('TIPO', ftString, 1);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('NATUREZA_LANCAMENTO', ftString, 1);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('ID_PLANO_CONTAS', ftInteger);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('ID_TIPO_DOCUMENTO', ftInteger);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('ID_PESSOA', ftInteger);
  FDataModule.CDSLancamentoPagar.CreateDataSet;
  TFloatField(FDataModule.CDSLancamentoPagar.FieldByName('VALOR')).displayFormat := '#,###,###,##0.00';

  // Definição dos títulos dos cabeçalhos e largura das colunas
  Grid.Columns[0].Title.Caption := 'Id';
  Grid.Columns[1].Title.Caption := 'Conta';
  Grid.Columns[2].Title.Caption := 'Tipo Documento';
  Grid.Columns[3].Title.Caption := 'Cliente';
  Grid.Columns[4].Title.Caption := 'Documento';
  Grid.Columns[5].Title.Caption := 'Qtde. Parcelas';
  Grid.Columns[6].Title.Caption := 'Valor';
  Grid.Columns[7].Title.Caption := 'Data Lançamento';
  Grid.Columns[8].Title.Caption := 'Primeiro Vencimento';
  //
  Grid.Columns[9].Visible := False;
  Grid.Columns[10].Visible := False;
  Grid.Columns[11].Visible := False;
  Grid.Columns[12].Visible := False;
  Grid.Columns[13].Visible := False;
  //
  //
  //Grid secundária - das parcelas
  FDataModule.CDSParcelaPagamento.Close;
  FDataModule.CDSParcelaPagamento.FieldDefs.Clear;
  FDataModule.CDSParcelaPagamento.FieldDefs.add('NUMERO_PARCELA', ftInteger);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('DATA_EMISSAO', ftString, 10);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('DATA_VENCIMENTO', ftString, 10);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('DATA_PAGAMENTO', ftString, 10);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('VALOR', ftFloat);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('TAXA_JUROS', ftFloat);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('VALOR_JUROS', ftFloat);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('TAXA_MULTA', ftFloat);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('VALOR_MULTA', ftFloat);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('TAXA_DESCONTO', ftFloat);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('VALOR_DESCONTO', ftFloat);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('TOTAL_PARCELA', ftFloat);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('HISTORICO', ftMemo);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('SITUACAO', ftString, 1);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('PERSISTE', ftString, 1);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('ID_CONTAS_PAGAR_RECEBER', ftInteger);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('ID_CONTA_CAIXA', ftInteger);
  FDataModule.CDSParcelaPagamento.FieldDefs.add('ID_MEIOS_PAGAMENTO', ftInteger);
  FDataModule.CDSParcelaPagamento.CreateDataSet;
  TFloatField(FDataModule.CDSParcelaPagamento.FieldByName('VALOR')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSParcelaPagamento.FieldByName('TAXA_JUROS')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSParcelaPagamento.FieldByName('VALOR_JUROS')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSParcelaPagamento.FieldByName('TAXA_MULTA')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSParcelaPagamento.FieldByName('VALOR_MULTA')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSParcelaPagamento.FieldByName('TAXA_DESCONTO')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSParcelaPagamento.FieldByName('VALOR_DESCONTO')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSParcelaPagamento.FieldByName('TOTAL_PARCELA')).displayFormat := '#,###,###,##0.00';
  //Definição dos títulos dos cabeçalhos e largura das colunas
  GridParcelas.Columns[0].Title.Caption := 'Parcela';
  GridParcelas.Columns[1].Title.Caption := 'Data de Emissão';
  GridParcelas.Columns[2].Title.Caption := 'Data de Vencimento';
  GridParcelas.Columns[3].Title.Caption := 'Data de Pagamento';
  GridParcelas.Columns[4].Title.Caption := 'Valor';
  GridParcelas.Columns[5].Title.Caption := 'Taxa Juros';
  GridParcelas.Columns[6].Title.Caption := 'Valor Juros';
  GridParcelas.Columns[7].Title.Caption := 'Taxa Multa';
  GridParcelas.Columns[8].Title.Caption := 'Valor Multa';
  GridParcelas.Columns[9].Title.Caption := 'Taxa Desconto';
  GridParcelas.Columns[10].Title.Caption := 'Valor Desconto';
  GridParcelas.Columns[11].Title.Caption := 'Valor Recebido';
  GridParcelas.Columns[12].Title.Caption := 'Histórico';
  GridParcelas.Columns[12].Width := 300;
  //Colunas nao visiveis
  GridParcelas.Columns.Items[13].Visible := False;
  GridParcelas.Columns.Items[14].Visible := False;
  GridParcelas.Columns.Items[15].Visible := False;
  GridParcelas.Columns.Items[16].Visible := False;
  GridParcelas.Columns.Items[17].Visible := False;
  GridParcelas.Columns.Items[18].Visible := False;
  //
  Pagina := 0;
  VerificarPaginacao;
  //
  FDataModule.CDSLancamentoPagar.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
end;

procedure TFParcelaPagamento.ActionConfirmarRecebimentoExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSLancamentoPagar.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    GridParcelas.SetFocus;
    ActionToolBarGrid.Enabled := False;
    Operacao := 2;
    //Carrega parcelas
    FiltroLocal := 'ID_CONTAS_PAGAR_RECEBER = '+ FDataModule.CDSLancamentoPagar.FieldByName('ID').AsString;
    TParcelaPagamentoController.Consulta(trim(FiltroLocal));
  end;
end;

procedure TFParcelaPagamento.ActionRetornarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  Grid.SetFocus;
end;

procedure TFParcelaPagamento.ActionSairExecute(Sender: TObject);
begin
FechaFormulario;
end;

procedure TFParcelaPagamento.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  Grid.SetFocus;
end;

procedure TFParcelaPagamento.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  GridParcelas.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 3;
  //Carrega parcelas
  FiltroLocal := 'ID_CONTAS_PAGAR_RECEBER = '+ FDataModule.CDSLancamentoPagar.FieldByName('ID').AsString;
  TParcelaPagamentoController.Consulta(trim(FiltroLocal));
end;

procedure TFParcelaPagamento.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    Application.MessageBox('Não existe critério para consulta.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TLancamentoPagarController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end;
end;

procedure TFParcelaPagamento.ActionFiltrarExecute(Sender: TObject);
var
  ParcelaPagamento : TContasPagarReceberVO;
  I : Integer;
begin
  Filtro := '';
  ParcelaPagamento := TContasPagarReceberVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSLancamentoPagar;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TLancamentoPagarController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFParcelaPagamento.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoPagar.First;
end;

procedure TFParcelaPagamento.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoPagar.Last;
end;

procedure TFParcelaPagamento.EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TContaCaixaVO.Create;
    ULookup.ObjetoController := TContaCaixaController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'NOME';
    FLookup.ShowModal;
    EditIdContaCaixa.Text := ULookup.CampoRetorno1;
    EditNomeContaCaixa.Text := ULookup.CampoRetorno2;
    EditIdContaCaixa.SetFocus;
  end;
end;

procedure TFParcelaPagamento.EditIdMeioPagamentoKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TMeiosPagamentoVO.Create;
    ULookup.ObjetoController := TMeiosPagamentoController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'DESCRICAO';
    FLookup.ShowModal;
    EditIdMeioPagamento.Text := ULookup.CampoRetorno1;
    EditDescricaoMeioPagamento.Text := ULookup.CampoRetorno2;
    EditIdMeioPagamento.SetFocus;
  end;
end;

procedure TFParcelaPagamento.GridParaEdits;
begin
  EditValor.AsFloat := FDataModule.CDSParcelaPagamento.FieldByName('VALOR').AsFloat;
  EditTaxaJuro.AsFloat := FDataModule.CDSParcelaPagamento.FieldByName('TAXA_JUROS').AsFloat;
  EditValorJuro.AsFloat := FDataModule.CDSParcelaPagamento.FieldByName('VALOR_JUROS').AsFloat;
  EditTaxaMulta.AsFloat := FDataModule.CDSParcelaPagamento.FieldByName('TAXA_MULTA').AsFloat;
  EditValorMulta.AsFloat := FDataModule.CDSParcelaPagamento.FieldByName('VALOR_MULTA').AsFloat;
  EditTaxaDesconto.AsFloat := FDataModule.CDSParcelaPagamento.FieldByName('TAXA_DESCONTO').AsFloat;
  EditValorDesconto.AsFloat := FDataModule.CDSParcelaPagamento.FieldByName('VALOR_DESCONTO').AsFloat;
  EditValorPago.AsFloat := FDataModule.CDSParcelaPagamento.FieldByName('TOTAL_PARCELA').AsFloat;
  MemoHistorico.Text := FDataModule.CDSParcelaPagamento.FieldByName('HISTORICO').AsString;
end;

procedure TFParcelaPagamento.EditTaxaJuroExit(Sender: TObject);
begin
  EditValorJuro.AsFloat := EditValor.AsFloat * (EditTaxaJuro.AsFloat / 100);
end;

procedure TFParcelaPagamento.EditTaxaMultaExit(Sender: TObject);
begin
  EditValorMulta.AsFloat := EditValor.AsFloat * (EditTaxaMulta.AsFloat / 100);
end;

procedure TFParcelaPagamento.EditTaxaDescontoExit(Sender: TObject);
begin
  EditValorDesconto.AsFloat := EditValor.AsFloat * (EditTaxaDesconto.AsFloat / 100);
end;

procedure TFParcelaPagamento.EditValorPagoEnter(Sender: TObject);
begin
  EditValorPago.AsFloat := EditValor.AsFloat + EditValorJuro.AsFloat + EditValorMulta.AsFloat - EditValorDesconto.AsFloat;
end;

procedure TFParcelaPagamento.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoPagar.Prior;
end;

procedure TFParcelaPagamento.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoPagar.Next;
end;

procedure TFParcelaPagamento.ActionConfirmarParcelaExecute(Sender: TObject);
var
  ParcelaPagar: TContasParcelasVO;
begin
  ParcelaPagar := TContasParcelasVO.Create;

  ParcelaPagar.Id := FDataModule.CDSParcelaPagamento.FieldByName('ID').AsInteger;
  ParcelaPagar.IdContasPagarReceber := FDataModule.CDSLancamentoPagar.FieldByName('ID').AsInteger;
  ParcelaPagar.IdContaCaixa := EditIdContaCaixa.AsInteger;
  ParcelaPagar.IdMeiosPagamento := EditIdMeioPagamento.AsInteger;
  ParcelaPagar.DataEmissao := FDataModule.CDSParcelaPagamento.FieldByName('DATA_EMISSAO').AsString;
  ParcelaPagar.DataVencimento := FDataModule.CDSParcelaPagamento.FieldByName('DATA_VENCIMENTO').AsString;
  ParcelaPagar.DataPagamento := FormatDateTime('yyyy-mm-dd', EditDataPagamento.Date);
  ParcelaPagar.NumeroParcela := FDataModule.CDSParcelaPagamento.FieldByName('NUMERO_PARCELA').AsInteger;
  ParcelaPagar.Valor := FDataModule.CDSParcelaPagamento.FieldByName('VALOR').AsFloat;
  ParcelaPagar.Situacao := 'P';
  ParcelaPagar.TaxaJuros := EditTaxaJuro.AsFloat;
  ParcelaPagar.ValorJuros := EditValorJuro.AsFloat;
  ParcelaPagar.TaxaMulta := EditTaxaMulta.AsFloat;
  ParcelaPagar.ValorMulta := EditValorMulta.AsFloat;
  ParcelaPagar.TaxaDesconto := EditTaxaDesconto.AsFloat;
  ParcelaPagar.ValorDesconto := EditValorDesconto.AsFloat;
  ParcelaPagar.TotalParcela := EditValorPago.AsFloat;
  ParcelaPagar.Historico := MemoHistorico.Text;

  TParcelaPagamentoController.Altera(ParcelaPagar);
end;

procedure TFParcelaPagamento.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TLancamentoPagarController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFParcelaPagamento.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TLancamentoPagarController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFParcelaPagamento.LimparCampos;
begin
  EditIdContaCaixa.AsInteger := 0;
  EditNomeContaCaixa.Clear;
  EditIdMeioPagamento.AsInteger := 0;
  EditDescricaoMeioPagamento.Clear;
  EditDataPagamento.Clear;
  EditValor.AsFloat := 0;
  EditTaxaJuro.AsFloat := 0;;
  EditValorJuro.AsFloat := 0;;
  EditTaxaMulta.AsFloat := 0;;
  EditValorMulta.AsFloat := 0;;
  EditTaxaDesconto.AsFloat := 0;;
  EditValorDesconto.AsFloat := 0;;
  EditValorPago.AsFloat := 0;;
  MemoHistorico.Clear;
  FDataModule.CDSParcelaPagamento.EmptyDataSet;
end;

procedure TFParcelaPagamento.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSLancamentoPagar.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFParcelaPagamento.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
var
  IxDName: string;
  i: integer;
  Fields, DescFields: string;
begin
  try
    Fields := '';
    DescFields := '';
    for i := 0 to Length(FieldsToSort) - 1 do
    begin
      Fields := Fields + FieldsToSort[i].Name + ';';
      if not FieldsToSort[i].Order then
        DescFields := DescFields + FieldsToSort[i].Name + ';';
    end;
    Fields := Copy(Fields, 1, Length(Fields)-1);
    DescFields := Copy(DescFields, 1, Length(DescFields)-1);

    IxDName := IntToStr(Length(FieldsToSort)) + '_' + FormatDateTime('hhmmssz',Now);
    FDataModule.CDSLancamentoPagar.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSLancamentoPagar.IndexDefs.Update;
    FDataModule.CDSLancamentoPagar.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFParcelaPagamento.ActionExportarCSVExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos CSV (Valores Separados por Vírgula) (*.CSV)|*.CSV';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarCSV.FileName := NomeArquivo + '.csv';
      FDataModule.ExportarCSV.Grid := Grid;
      FDataModule.ExportarCSV.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFParcelaPagamento.ActionExportarExcelExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos do Excel (*.XLS)|*.XLS';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarExcel.FileName := NomeArquivo + '.xls';
      FDataModule.ExportarExcel.Grid := Grid;
      FDataModule.ExportarExcel.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFParcelaPagamento.ActionExportarHTMLExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos HTML (*.HTML)|*.HTML';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarHTML.FileName := NomeArquivo + '.html';
      FDataModule.ExportarHTML.Grid := Grid;
      FDataModule.ExportarHTML.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFParcelaPagamento.ActionExportarWordExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos do Word (*.DOC)|*.DOC';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarWord.FileName := NomeArquivo + '.doc';
      FDataModule.ExportarWord.Grid := Grid;
      FDataModule.ExportarWord.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR)
  end;
end;

procedure TFParcelaPagamento.ActionExportarXMLExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos XML (*.XML)|*.XML';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := ExtractFileName(FDataModule.SaveDialog.FileName);
      FDataModule.ExportarXML.FileName := NomeArquivo + '.xml';
      FDataModule.ExportarXML.Grid := Grid;
      FDataModule.ExportarXML.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFParcelaPagamento.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFParcelaPagamento.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
