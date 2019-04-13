{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Lançamento a Pagar

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

  @author Albert Eije (t2ti.com@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit UFinLancamentoPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FinLancamentoPagarVO,
  FinLancamentoPagarController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, ShellApi, AdmParametroVO;

type
  [TFormDescription(TConstantes.MODULO_CONTAS_PAGAR, 'Lançamento a Pagar')]

  TFFinLancamentoPagar = class(TFTelaCadastro)
    ActionManager: TActionManager;
    ActionGerarParcelas: TAction;
    PanelParcelas: TPanel;
    PanelMestre: TPanel;
    EditIdFornecedor: TLabeledCalcEdit;
    EditFornecedor: TLabeledEdit;
    EditIdDocumentoOrigem: TLabeledCalcEdit;
    EditDocumentoOrigem: TLabeledEdit;
    ComboBoxPagamentoCompartilhado: TLabeledComboBox;
    EditImagemDocumento: TLabeledEdit;
    EditPrimeiroVencimento: TLabeledDateEdit;
    EditQuantidadeParcelas: TLabeledCalcEdit;
    EditValorAPagar: TLabeledCalcEdit;
    EditValorTotal: TLabeledCalcEdit;
    EditDataLancamento: TLabeledDateEdit;
    DSParcelaPagar: TDataSource;
    CDSParcelaPagar: TClientDataSet;
    PageControlItensLancamento: TPageControl;
    tsItens: TTabSheet;
    PanelItensLancamento: TPanel;
    GridParcelas: TJvDBUltimGrid;
    ActionToolBarEdits: TActionToolBar;
    EditNumeroDocumento: TLabeledEdit;
    EditIntervalorEntreParcelas: TLabeledCalcEdit;
    CDSParcelaPagarID: TIntegerField;
    CDSParcelaPagarID_CONTA_CAIXA: TIntegerField;
    CDSParcelaPagarID_FIN_LANCAMENTO_PAGAR: TIntegerField;
    CDSParcelaPagarID_FIN_STATUS_PARCELA: TIntegerField;
    CDSParcelaPagarNUMERO_PARCELA: TIntegerField;
    CDSParcelaPagarDATA_EMISSAO: TDateField;
    CDSParcelaPagarDATA_VENCIMENTO: TDateField;
    CDSParcelaPagarDESCONTO_ATE: TDateField;
    CDSParcelaPagarSOFRE_RETENCAO: TStringField;
    CDSParcelaPagarVALOR: TFMTBCDField;
    CDSParcelaPagarTAXA_JURO: TFMTBCDField;
    CDSParcelaPagarTAXA_MULTA: TFMTBCDField;
    CDSParcelaPagarTAXA_DESCONTO: TFMTBCDField;
    CDSParcelaPagarVALOR_JURO: TFMTBCDField;
    CDSParcelaPagarVALOR_MULTA: TFMTBCDField;
    CDSParcelaPagarVALOR_DESCONTO: TFMTBCDField;
    CDSParcelaPagarPERSISTE: TStringField;
    PanelContaCaixa: TPanel;
    EditIdContaCaixa: TLabeledCalcEdit;
    EditContaCaixa: TLabeledEdit;
    CDSParcelaPagarCONTA_CAIXANOME: TStringField;
    ActionAcionarGed: TAction;
    tsNaturezaFinanceira: TTabSheet;
    PanelNaturezaFinanceira: TPanel;
    JvDBUltimGrid1: TJvDBUltimGrid;
    CDSLancamentoNaturezaFinanceira: TClientDataSet;
    DSLancamentoNaturezaFinanceira: TDataSource;
    CDSLancamentoNaturezaFinanceiraID: TIntegerField;
    CDSLancamentoNaturezaFinanceiraID_FIN_LANCAMENTO_PAGAR: TIntegerField;
    CDSLancamentoNaturezaFinanceiraID_CONTABIL_LANCAMENTO_DET: TIntegerField;
    CDSLancamentoNaturezaFinanceiraID_NATUREZA_FINANCEIRA: TIntegerField;
    CDSLancamentoNaturezaFinanceiraDATA_INCLUSAO: TDateField;
    CDSLancamentoNaturezaFinanceiraVALOR: TFMTBCDField;
    CDSLancamentoNaturezaFinanceiraNATUREZA_FINANCEIRACLASSIFICACAO: TStringField;
    CDSLancamentoNaturezaFinanceiraNATUREZA_FINANCEIRADESCRICAO: TStringField;
    CDSLancamentoNaturezaFinanceiraPERSISTE: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure EditIdFornecedorExit(Sender: TObject);
    procedure EditIdFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdDocumentoOrigemExit(Sender: TObject);
    procedure EditIdDocumentoOrigemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionGerarParcelasExecute(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridParcelasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSParcelaPagarAfterEdit(DataSet: TDataSet);
    procedure CDSParcelaPagarBeforeDelete(DataSet: TDataSet);
    procedure GridParcelasUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure EditIdFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdDocumentoOrigemKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdContaCaixaExit(Sender: TObject);
    procedure EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure CDSParcelaPagarAfterPost(DataSet: TDataSet);
    procedure GerarParcelas;
    procedure ActionAcionarGedExecute(Sender: TObject);
    procedure JvDBUltimGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSLancamentoNaturezaFinanceiraAfterEdit(DataSet: TDataSet);
    procedure CDSLancamentoNaturezaFinanceiraAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
    function VerificarTotalNaturezaFinanceira: Boolean;
  end;

var
  FFinLancamentoPagar: TFFinLancamentoPagar;
  AdmParametroVO: TAdmParametroVO;

implementation

uses ULookup, Biblioteca, UDataModule, PessoaVO, PessoaController,
  FinDocumentoOrigemVO, FinDocumentoOrigemController, FinParcelaPagarVO,
  FinParcelaPagarController, ContaCaixaVO, ContaCaixaController, FornecedorVO,
  FornecedorController, NaturezaFinanceiraVO, NaturezaFinanceiraController,
  FinLctoPagarNtFinanceiraVO, AdmParametroController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFFinLancamentoPagar.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFinLancamentoPagarVO;
  ObjetoController := TFinLancamentoPagarController.Create;

  inherited;

  AdmParametroVO := TAdmParametroController.VO<TAdmParametroVO>('ID_EMPRESA', IntToStr(Sessao.IdEmpresa));
end;

procedure TFFinLancamentoPagar.LimparCampos;
begin
  inherited;
  CDSParcelaPagar.EmptyDataSet;
  CDSLancamentoNaturezaFinanceira.EmptyDataSet;
end;

procedure TFFinLancamentoPagar.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;

  if StatusTela = stNavegandoEdits then
  begin
    PanelMestre.Enabled := False;
    PanelItensLancamento.Enabled := False;
    ActionGerarParcelas.Enabled := False;
  end
  else
  begin
    PanelMestre.Enabled := True;
    PanelItensLancamento.Enabled := True;
    ActionGerarParcelas.Enabled := True;
  end;
end;

function TFFinLancamentoPagar.VerificarTotalNaturezaFinanceira: Boolean;
var
  Total: Extended;
begin
  Total := 0;
  CDSLancamentoNaturezaFinanceira.DisableControls;
  CDSLancamentoNaturezaFinanceira.First;
  while not CDSLancamentoNaturezaFinanceira.Eof do
  begin
    Total := Total + CDSLancamentoNaturezaFinanceiraVALOR.AsExtended;
    CDSLancamentoNaturezaFinanceira.Next;
  end;
  CDSLancamentoNaturezaFinanceira.First;
  CDSLancamentoNaturezaFinanceira.EnableControls;
  Result := (Total = EditValorAPagar.Value);
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFinLancamentoPagar.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdFornecedor.SetFocus;
  end;
end;

function TFFinLancamentoPagar.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdFornecedor.SetFocus;
  end;
end;

function TFFinLancamentoPagar.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFinLancamentoPagarController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFinLancamentoPagarController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFinLancamentoPagar.DoSalvar: Boolean;
var
  ParcelaPagar: TFinParcelaPagarVO;
  LancamentoNaturezaFinanceira: TFinLctoPagarNtFinanceiraVO;
begin
  if not CDSLancamentoNaturezaFinanceira.IsEmpty then
  begin
    if not VerificarTotalNaturezaFinanceira then begin
      Application.MessageBox('Os valores informados nas naturezas financeiras não batem com o valor a pagar.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      Exit(False);
    end;
  end;

  Result := inherited DoSalvar;

  DecimalSeparator := '.';
  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFinLancamentoPagarVO.Create;

      TFinLancamentoPagarVO(ObjetoVO).IdFornecedor := EditIdFornecedor.AsInteger;
      TFinLancamentoPagarVO(ObjetoVO).FornecedorPessoaNome := EditFornecedor.Text;
      TFinLancamentoPagarVO(ObjetoVO).IdFinDocumentoOrigem := EditIdDocumentoOrigem.AsInteger;
      TFinLancamentoPagarVO(ObjetoVO).DocumentoOrigemSigla := EditDocumentoOrigem.Text;
      TFinLancamentoPagarVO(ObjetoVO).PagamentoCompartilhado := IfThen(ComboBoxPagamentoCompartilhado.ItemIndex = 0, 'S', 'N');
      TFinLancamentoPagarVO(ObjetoVO).QuantidadeParcela := EditQuantidadeParcelas.AsInteger;
      TFinLancamentoPagarVO(ObjetoVO).ValorTotal := EditValorTotal.Value;
      TFinLancamentoPagarVO(ObjetoVO).ValorAPagar := EditValorAPagar.Value;
      TFinLancamentoPagarVO(ObjetoVO).DataLancamento := EditDataLancamento.Date;
      TFinLancamentoPagarVO(ObjetoVO).NumeroDocumento := EditNumeroDocumento.Text;
      TFinLancamentoPagarVO(ObjetoVO).ImagemDocumento := EditImagemDocumento.Text;
      TFinLancamentoPagarVO(ObjetoVO).PrimeiroVencimento := EditPrimeiroVencimento.Date;
      TFinLancamentoPagarVO(ObjetoVO).IntervaloEntreParcelas := EditIntervalorEntreParcelas.AsInteger;

      if StatusTela = stEditando then
        TFinLancamentoPagarVO(ObjetoVO).Id := IdRegistroSelecionado;

      // Parcelas
      TFinLancamentoPagarVO(ObjetoVO).ListaParcelaPagarVO := TObjectList<TFinParcelaPagarVO>.Create;
      CDSParcelaPagar.DisableControls;
      CDSParcelaPagar.First;
      while not CDSParcelaPagar.Eof do
      begin
        if (CDSParcelaPagarPERSISTE.AsString = 'S') or (CDSParcelaPagarID.AsInteger = 0) then
        begin
          ParcelaPagar := TFinParcelaPagarVO.Create;
          ParcelaPagar.Id := CDSParcelaPagarID.AsInteger;
          ParcelaPagar.IdFinLancamentoPagar := TFinLancamentoPagarVO(ObjetoVO).Id;
          ParcelaPagar.IdContaCaixa := CDSParcelaPagarID_CONTA_CAIXA.AsInteger;
          ParcelaPagar.IdFinStatusParcela := AdmParametroVO.FinParcelaAberto;
          ParcelaPagar.NumeroParcela := CDSParcelaPagarNUMERO_PARCELA.AsInteger;
          ParcelaPagar.DataEmissao := CDSParcelaPagarDATA_EMISSAO.AsDateTime;
          ParcelaPagar.DataVencimento := CDSParcelaPagarDATA_VENCIMENTO.AsDateTime;
          ParcelaPagar.DescontoAte := CDSParcelaPagarDESCONTO_ATE.AsDateTime;
          ParcelaPagar.SofreRetencao := CDSParcelaPagarSOFRE_RETENCAO.AsString;
          ParcelaPagar.Valor := CDSParcelaPagarVALOR.AsExtended;

          ParcelaPagar.TaxaJuro := CDSParcelaPagarTAXA_JURO.AsExtended;
          ParcelaPagar.TaxaMulta := CDSParcelaPagarTAXA_MULTA.AsExtended;
          ParcelaPagar.TaxaDesconto := CDSParcelaPagarTAXA_DESCONTO.AsExtended;
          ParcelaPagar.ValorJuro := CDSParcelaPagarVALOR_JURO.AsExtended;
          ParcelaPagar.ValorMulta := CDSParcelaPagarVALOR_MULTA.AsExtended;
          ParcelaPagar.ValorDesconto := CDSParcelaPagarVALOR_DESCONTO.AsExtended;

          TFinLancamentoPagarVO(ObjetoVO).ListaParcelaPagarVO.Add(ParcelaPagar);
        end;

        CDSParcelaPagar.Next;
      end;
      CDSParcelaPagar.EnableControls;

      // Natureza Financeira
      TFinLancamentoPagarVO(ObjetoVO).ListaLancPagarNatFinanceiraVO := TObjectList<TFinLctoPagarNtFinanceiraVO>.Create;
      CDSLancamentoNaturezaFinanceira.DisableControls;
      CDSLancamentoNaturezaFinanceira.First;
      while not CDSLancamentoNaturezaFinanceira.Eof do
      begin
        if (CDSLancamentoNaturezaFinanceiraPERSISTE.AsString = 'S') or (CDSLancamentoNaturezaFinanceiraID.AsInteger = 0) then
        begin
          LancamentoNaturezaFinanceira := TFinLctoPagarNtFinanceiraVO.Create;

          LancamentoNaturezaFinanceira.Id := CDSLancamentoNaturezaFinanceiraID.AsInteger;
          LancamentoNaturezaFinanceira.IdFinLancamentoPagar := CDSLancamentoNaturezaFinanceiraID_FIN_LANCAMENTO_PAGAR.AsInteger;
          LancamentoNaturezaFinanceira.IdNaturezaFinanceira := CDSLancamentoNaturezaFinanceiraID_NATUREZA_FINANCEIRA.AsInteger;
          LancamentoNaturezaFinanceira.DataInclusao := CDSLancamentoNaturezaFinanceiraDATA_INCLUSAO.AsDateTime;
          LancamentoNaturezaFinanceira.Valor := CDSLancamentoNaturezaFinanceiraVALOR.AsExtended;

          TFinLancamentoPagarVO(ObjetoVO).ListaLancPagarNatFinanceiraVO.Add(LancamentoNaturezaFinanceira);
        end;

        CDSLancamentoNaturezaFinanceira.Next;
      end;
      CDSLancamentoNaturezaFinanceira.EnableControls;

      // ObjetoVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      TFinLancamentoPagarVO(ObjetoVO).FornecedorVO := Nil;
      TFinLancamentoPagarVO(ObjetoVO).DocumentoOrigemVO := Nil;
      if Assigned(ObjetoOldVO) then
      begin
        TFinLancamentoPagarVO(ObjetoOldVO).FornecedorVO := Nil;
        TFinLancamentoPagarVO(ObjetoOldVO).DocumentoOrigemVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TFinLancamentoPagarController(ObjetoController).Insere(TFinLancamentoPagarVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFinLancamentoPagarVO(ObjetoVO).ToJSONString <> TFinLancamentoPagarVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TFinLancamentoPagarController(ObjetoController).Altera(TFinLancamentoPagarVO(ObjetoVO), TFinLancamentoPagarVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
  DecimalSeparator := ',';
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFFinLancamentoPagar.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;

procedure TFFinLancamentoPagar.GridParaEdits;
var
  ParcelaPagarEnumerator: TEnumerator<TFinParcelaPagarVO>;
  LancamentoNaturezaFinanceiraEnumerator: TEnumerator<TFinLctoPagarNtFinanceiraVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFinLancamentoPagarVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFinLancamentoPagarVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdFornecedor.AsInteger := TFinLancamentoPagarVO(ObjetoVO).IdFornecedor;
    EditFornecedor.Text := TFinLancamentoPagarVO(ObjetoVO).FornecedorPessoaNome;
    EditIdDocumentoOrigem.AsInteger := TFinLancamentoPagarVO(ObjetoVO).IdFinDocumentoOrigem;
    EditDocumentoOrigem.Text := TFinLancamentoPagarVO(ObjetoVO).DocumentoOrigemSigla;
    ComboBoxPagamentoCompartilhado.ItemIndex := IfThen(TFinLancamentoPagarVO(ObjetoVO).PagamentoCompartilhado = 'S', 0, 1);
    EditQuantidadeParcelas.AsInteger := TFinLancamentoPagarVO(ObjetoVO).QuantidadeParcela;
    EditValorTotal.Value := TFinLancamentoPagarVO(ObjetoVO).ValorTotal;
    EditValorAPagar.Value := TFinLancamentoPagarVO(ObjetoVO).ValorAPagar;
    EditDataLancamento.Date := TFinLancamentoPagarVO(ObjetoVO).DataLancamento;
    EditNumeroDocumento.Text := TFinLancamentoPagarVO(ObjetoVO).NumeroDocumento;
    EditImagemDocumento.Text := TFinLancamentoPagarVO(ObjetoVO).ImagemDocumento;
    EditPrimeiroVencimento.Date := TFinLancamentoPagarVO(ObjetoVO).PrimeiroVencimento;
    EditIntervalorEntreParcelas.AsInteger := TFinLancamentoPagarVO(ObjetoVO).IntervaloEntreParcelas;

    // Parcelas
    ParcelaPagarEnumerator := TFinLancamentoPagarVO(ObjetoVO).ListaParcelaPagarVO.GetEnumerator;
    try
      if TFinLancamentoPagarVO(ObjetoVO).ListaParcelaPagarVO.Count > 0 then
      begin
        EditIdContaCaixa.AsInteger := TFinLancamentoPagarVO(ObjetoVO).ListaParcelaPagarVO[0].IdContaCaixa;
        EditContaCaixa.Text := TFinLancamentoPagarVO(ObjetoVO).ListaParcelaPagarVO[0].ContaCaixaVO.Nome;
      end;

      with ParcelaPagarEnumerator do
      begin
        while MoveNext do
        begin
          CDSParcelaPagar.Append;

          CDSParcelaPagarID.AsInteger := Current.Id;
          CDSParcelaPagarID_FIN_LANCAMENTO_PAGAR.AsInteger := Current.IdFinLancamentoPagar;
          CDSParcelaPagarID_CONTA_CAIXA.AsInteger := Current.IdContaCaixa;
          CDSParcelaPagarCONTA_CAIXANOME.AsString := Current.ContaCaixaVO.Nome;
          CDSParcelaPagarNUMERO_PARCELA.AsInteger := Current.NumeroParcela;
          CDSParcelaPagarDATA_EMISSAO.AsDateTime := Current.DataEmissao;
          CDSParcelaPagarDATA_VENCIMENTO.AsDateTime := Current.DataVencimento;
          CDSParcelaPagarDESCONTO_ATE.AsDateTime := Current.DescontoAte;
          CDSParcelaPagarSOFRE_RETENCAO.AsString := Current.SofreRetencao;
          CDSParcelaPagarVALOR.AsExtended := Current.Valor;
          CDSParcelaPagarTAXA_JURO.AsExtended := Current.TaxaJuro;
          CDSParcelaPagarTAXA_MULTA.AsExtended := Current.TaxaMulta;
          CDSParcelaPagarTAXA_DESCONTO.AsExtended := Current.TaxaDesconto;
          CDSParcelaPagarVALOR_JURO.AsExtended := Current.ValorJuro;
          CDSParcelaPagarVALOR_MULTA.AsExtended := Current.ValorMulta;
          CDSParcelaPagarVALOR_DESCONTO.AsExtended := Current.ValorDesconto;

          CDSParcelaPagar.Post;
        end;
      end;
    finally
      ParcelaPagarEnumerator.Free;
    end;

    // Natureza Financeira
    LancamentoNaturezaFinanceiraEnumerator := TFinLancamentoPagarVO(ObjetoVO).ListaLancPagarNatFinanceiraVO.GetEnumerator;
    try
      with LancamentoNaturezaFinanceiraEnumerator do
      begin
        while MoveNext do
        begin
          CDSLancamentoNaturezaFinanceira.Append;

          CDSLancamentoNaturezaFinanceiraID.AsInteger := Current.Id;
          CDSLancamentoNaturezaFinanceiraID_FIN_LANCAMENTO_PAGAR.AsInteger := Current.IdFinLancamentoPagar;
          CDSLancamentoNaturezaFinanceiraID_NATUREZA_FINANCEIRA.AsInteger := Current.IdNaturezaFinanceira;
          CDSLancamentoNaturezaFinanceiraNATUREZA_FINANCEIRACLASSIFICACAO.AsString := Current.NaturezaFinanceiraVO.Classificacao;
          CDSLancamentoNaturezaFinanceiraNATUREZA_FINANCEIRADESCRICAO.AsString := Current.NaturezaFinanceiraVO.Descricao;
          CDSLancamentoNaturezaFinanceiraDATA_INCLUSAO.AsDateTime := Current.DataInclusao;
          CDSLancamentoNaturezaFinanceiraVALOR.AsExtended := Current.Valor;

          CDSLancamentoNaturezaFinanceira.Post;
        end;
      end;
    finally
      LancamentoNaturezaFinanceiraEnumerator.Free;
    end;

    TFinLancamentoPagarVO(ObjetoVO).ListaParcelaPagarVO := Nil;
    TFinLancamentoPagarVO(ObjetoVO).ListaLancPagarNatFinanceiraVO := Nil;
    if Assigned(TFinLancamentoPagarVO(ObjetoOldVO)) then
    begin
      TFinLancamentoPagarVO(ObjetoOldVO).ListaParcelaPagarVO := Nil;
      TFinLancamentoPagarVO(ObjetoOldVO).ListaLancPagarNatFinanceiraVO := Nil;
    end;
  end;
  ConfigurarLayoutTela;
end;

procedure TFFinLancamentoPagar.GridParcelasUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
var
  IxDName: string;
  I: Integer;
  Fields, DescFields: string;
begin
  try
    Fields := '';
    DescFields := '';
    for I := 0 to Length(FieldsToSort) - 1 do
    begin
      Fields := Fields + FieldsToSort[I].Name + ';';
      if not FieldsToSort[I].Order then
        DescFields := DescFields + FieldsToSort[I].Name + ';';
    end;
    Fields := Copy(Fields, 1, Length(Fields) - 1);
    DescFields := Copy(DescFields, 1, Length(DescFields) - 1);

    IxDName := IntToStr(Length(FieldsToSort)) + '_' + FormatDateTime('hhmmssz', Now);
    CDSParcelaPagar.AddIndex(IxDName, Fields, [], DescFields);
    CDSParcelaPagar.IndexDefs.Update;
    CDSParcelaPagar.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFFinLancamentoPagar.JvDBUltimGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    try
      PopulaCamposTransientesLookup(TNaturezaFinanceiraVO, TNaturezaFinanceiraController);
      if CDSTransiente.RecordCount > 0 then
      begin
        CDSLancamentoNaturezaFinanceira.Append;
        CDSLancamentoNaturezaFinanceiraID_NATUREZA_FINANCEIRA.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
        CDSLancamentoNaturezaFinanceiraDATA_INCLUSAO.AsDateTime := Now;
        CDSLancamentoNaturezaFinanceiraNATUREZA_FINANCEIRACLASSIFICACAO.AsString := CDSTransiente.FieldByName('CLASSIFICACAO').AsString;
        CDSLancamentoNaturezaFinanceiraNATUREZA_FINANCEIRADESCRICAO.AsString := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end;
    finally
      CDSTransiente.Close;
    end;
  end;
end;

procedure TFFinLancamentoPagar.GridParcelasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridParcelas.SelectedIndex := GridParcelas.SelectedIndex + 1;
end;

procedure TFFinLancamentoPagar.CDSLancamentoNaturezaFinanceiraAfterEdit(DataSet: TDataSet);
begin
  CDSLancamentoNaturezaFinanceiraPERSISTE.AsString := 'S';
end;

procedure TFFinLancamentoPagar.CDSLancamentoNaturezaFinanceiraAfterPost(DataSet: TDataSet);
begin
  if CDSLancamentoNaturezaFinanceiraID_NATUREZA_FINANCEIRA.AsInteger = 0 then
    CDSLancamentoNaturezaFinanceira.Delete;
end;

procedure TFFinLancamentoPagar.CDSParcelaPagarAfterEdit(DataSet: TDataSet);
begin
  CDSParcelaPagarPERSISTE.AsString := 'S';
end;

procedure TFFinLancamentoPagar.CDSParcelaPagarAfterPost(DataSet: TDataSet);
begin
  if CDSParcelaPagarNUMERO_PARCELA.AsInteger = 0 then
    CDSParcelaPagar.Delete;
end;

procedure TFFinLancamentoPagar.CDSParcelaPagarBeforeDelete(DataSet: TDataSet);
begin
  if CDSParcelaPagarID.AsInteger > 0 then
    TFinParcelaPagarController.Exclui(CDSParcelaPagarID.AsInteger);
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFinLancamentoPagar.EditIdFornecedorExit(Sender: TObject);
var
  Filtro: String;
begin
   if EditIdFornecedor.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdFornecedor.Text;
      EditIdFornecedor.Clear;
      EditFornecedor.Clear;
      if not PopulaCamposTransientes(Filtro, TFornecedorVO, TFornecedorController) then
        PopulaCamposTransientesLookup(TFornecedorVO, TFornecedorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdFornecedor.Text := CDSTransiente.FieldByName('ID').AsString;
        EditFornecedor.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdFornecedor.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditFornecedor.Clear;
  end;
end;

procedure TFFinLancamentoPagar.EditIdFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdFornecedor.Value := -1;
    EditIdDocumentoOrigem.SetFocus;
  end;
end;

procedure TFFinLancamentoPagar.EditIdFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdDocumentoOrigem.SetFocus;
  end;
end;

procedure TFFinLancamentoPagar.EditIdContaCaixaExit(Sender: TObject);
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

procedure TFFinLancamentoPagar.EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContaCaixa.Value := -1;
    GridParcelas.SetFocus;
  end;
end;

procedure TFFinLancamentoPagar.EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    GridParcelas.SetFocus;
  end;
end;

procedure TFFinLancamentoPagar.EditIdDocumentoOrigemExit(Sender: TObject);
var
  Filtro: String;
begin
   if EditIdDocumentoOrigem.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdDocumentoOrigem.Text;
      EditIdDocumentoOrigem.Clear;
      EditDocumentoOrigem.Clear;
      if not PopulaCamposTransientes(Filtro, TFinDocumentoOrigemVO, TFinDocumentoOrigemController) then
        PopulaCamposTransientesLookup(TFinDocumentoOrigemVO, TFinDocumentoOrigemController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdDocumentoOrigem.Text := CDSTransiente.FieldByName('ID').AsString;
        EditDocumentoOrigem.Text := CDSTransiente.FieldByName('SIGLA_DOCUMENTO').AsString;
      end
      else
      begin
        Exit;
        EditIdDocumentoOrigem.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditDocumentoOrigem.Clear;
  end;
end;

procedure TFFinLancamentoPagar.EditIdDocumentoOrigemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdDocumentoOrigem.Value := -1;
    EditNumeroDocumento.SetFocus;
  end;
end;

procedure TFFinLancamentoPagar.EditIdDocumentoOrigemKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditNumeroDocumento.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFFinLancamentoPagar.ActionAcionarGedExecute(Sender: TObject);
var
  Parametros: String;
begin
  if EditNumeroDocumento.Text <> '' then
  begin
    {
      Parametros
      1 - Login
      2 - Senha
      3 - Aplicação que chamou
      4 - Nome do arquivo (Aplicacao que chamou + Tela que chamou + Numero Apólice
      }

    try
      EditImagemDocumento.Text := 'LANCAMENTO_PAGAR_' + MD5String(EditNumeroDocumento.Text);

      Parametros := Sessao.Usuario.Login + ' ' +
                    Sessao.Usuario.Senha + ' ' +
                    'FINANCEIRO' + ' ' +
                    EditImagemDocumento.Text;
      ShellExecute(
            Handle,
            'open',
            'T2TiERPGed.exe',
            PChar(Parametros),
            '',
            SW_SHOWNORMAL
            );
    except
      Application.MessageBox('Erro ao tentar executar o módulo.', 'Erro do Sistema', MB_OK + MB_ICONERROR);
    end;
  end
  else
  begin
    Application.MessageBox('É preciso informar o número do documento.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditNumeroDocumento.SetFocus;
  end;
end;

procedure TFFinLancamentoPagar.ActionGerarParcelasExecute(Sender: TObject);
begin
  if EditIdContaCaixa.AsInteger <=0 then
  begin
    Application.MessageBox('É necessário informar a conta/caixa para previsão das parcelas.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdContaCaixa.SetFocus;
    Exit;
  end;

  if not CDSParcelaPagar.IsEmpty then
  begin
    if Application.MessageBox('Já existem parcelas geradas e serão excluídas. Deseja continuar?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
    begin
      CDSParcelaPagar.DisableControls;
      CDSParcelaPagar.First;
      while not CDSParcelaPagar.Eof do
      begin
        if CDSParcelaPagarID.AsInteger > 0 then
          TFinParcelaPagarController.Exclui(CDSParcelaPagarID.AsInteger);

        CDSParcelaPagar.Next;
      end;
      CDSParcelaPagar.First;
      CDSParcelaPagar.EnableControls;

      CDSParcelaPagar.EmptyDataSet;
      GerarParcelas;
    end;
  end
  else
    GerarParcelas;
end;

procedure TFFinLancamentoPagar.GerarParcelas;
var
  i: integer;
  Vencimento: TDate;
  SomaParcelas, Residuo: Extended;
  FornecedorVO: TFornecedorVO;
begin
  if EditQuantidadeParcelas.AsInteger <= 0 then
    EditQuantidadeParcelas.AsInteger := 1;

  if EditPrimeiroVencimento.Text = '  /  /    ' then
    EditPrimeiroVencimento.Date := Date;

  Vencimento := EditPrimeiroVencimento.Date;
  SomaParcelas := 0;
  Residuo := 0;

  FornecedorVO := TFornecedorController.Fornecedor('ID=' + QuotedStr(EditIdFornecedor.Text), 0);

  for i := 0 to EditQuantidadeParcelas.AsInteger - 1 do
  begin
    CDSParcelaPagar.Append;
    CDSParcelaPagar.FieldByName('NUMERO_PARCELA').AsInteger := i+1;
    CDSParcelaPagar.FieldByName('ID_CONTA_CAIXA').AsInteger := EditIdContaCaixa.AsInteger;
    CDSParcelaPagar.FieldByName('DATA_EMISSAO').AsString := DateToStr(Date);
    CDSParcelaPagar.FieldByName('DATA_VENCIMENTO').AsString := DateToStr(Vencimento + (EditIntervalorEntreParcelas.AsInteger * i));
    CDSParcelaPagar.FieldByName('DESCONTO_ATE').AsString := DateToStr(Date);
    CDSParcelaPagar.FieldByName('SOFRE_RETENCAO').AsString := FornecedorVO.SofreRetencao;
    CDSParcelaPagar.FieldByName('VALOR').AsFloat := ArredondaTruncaValor('A', EditValorAPagar.Value / EditQuantidadeParcelas.AsInteger, Constantes.TConstantes.DECIMAIS_VALOR);
    CDSParcelaPagar.FieldByName('CONTA_CAIXA.NOME').AsString := EditContaCaixa.Text;
    CDSParcelaPagar.Post;

    SomaParcelas := SomaParcelas + CDSParcelaPagar.FieldByName('VALOR').AsFloat;
  end;

  // calcula o resíduo e lança na última parcela
  Residuo := EditValorAPagar.Value - SomaParcelas;
  CDSParcelaPagar.Edit;
  CDSParcelaPagar.FieldByName('VALOR').AsFloat := CDSParcelaPagar.FieldByName('VALOR').AsFloat + Residuo;
  CDSParcelaPagar.Post;
end;
{$ENDREGION}

end.
