{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Lançamento a Receber

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
unit UFinLancamentoReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Atributos,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FinLancamentoReceberVO,
  FinLancamentoReceberController, Tipos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, ShellApi, ACBrBoleto,
  AdmParametroVO;

type
  [TFormDescription(TConstantes.MODULO_CONTAS_RECEBER, 'Lançamento a Receber')]

  TFFinLancamentoReceber = class(TFTelaCadastro)
    ActionManager: TActionManager;
    ActionGerarParcelas: TAction;
    PanelParcelas: TPanel;
    PanelMestre: TPanel;
    EditIdCliente: TLabeledCalcEdit;
    EditCliente: TLabeledEdit;
    EditIdDocumentoOrigem: TLabeledCalcEdit;
    EditDocumentoOrigem: TLabeledEdit;
    EditPrimeiroVencimento: TLabeledDateEdit;
    EditQuantidadeParcelas: TLabeledCalcEdit;
    EditValorAReceber: TLabeledCalcEdit;
    EditValorTotal: TLabeledCalcEdit;
    EditDataLancamento: TLabeledDateEdit;
    DSParcelaReceber: TDataSource;
    CDSParcelaReceber: TClientDataSet;
    PageControlItensLancamento: TPageControl;
    tsItens: TTabSheet;
    PanelItensLancamento: TPanel;
    GridParcelas: TJvDBUltimGrid;
    ActionToolBarEdits: TActionToolBar;
    EditNumeroDocumento: TLabeledEdit;
    EditIntervalorEntreParcelas: TLabeledCalcEdit;
    PanelContaCaixa: TPanel;
    EditIdContaCaixa: TLabeledCalcEdit;
    EditContaCaixa: TLabeledEdit;
    ActionEmitirBoleto: TAction;
    tsNaturezaFinanceira: TTabSheet;
    PanelNaturezaFinanceira: TPanel;
    JvDBUltimGrid1: TJvDBUltimGrid;
    CDSLancamentoNaturezaFinanceira: TClientDataSet;
    DSLancamentoNaturezaFinanceira: TDataSource;
    CDSParcelaReceberID: TIntegerField;
    CDSParcelaReceberID_CONTA_CAIXA: TIntegerField;
    CDSParcelaReceberID_FIN_LANCAMENTO_RECEBER: TIntegerField;
    CDSParcelaReceberID_FIN_STATUS_PARCELA: TIntegerField;
    CDSParcelaReceberNUMERO_PARCELA: TIntegerField;
    CDSParcelaReceberDATA_EMISSAO: TDateField;
    CDSParcelaReceberDATA_VENCIMENTO: TDateField;
    CDSParcelaReceberDESCONTO_ATE: TDateField;
    CDSParcelaReceberVALOR: TFMTBCDField;
    CDSParcelaReceberTAXA_JURO: TFMTBCDField;
    CDSParcelaReceberTAXA_MULTA: TFMTBCDField;
    CDSParcelaReceberTAXA_DESCONTO: TFMTBCDField;
    CDSParcelaReceberVALOR_JURO: TFMTBCDField;
    CDSParcelaReceberVALOR_MULTA: TFMTBCDField;
    CDSParcelaReceberVALOR_DESCONTO: TFMTBCDField;
    CDSParcelaReceberPERSISTE: TStringField;
    CDSParcelaReceberCONTA_CAIXANOME: TStringField;
    CDSParcelaReceberEMITIU_BOLETO: TStringField;
    CDSParcelaReceberBOLETO_NOSSO_NUMERO: TStringField;
    CDSLancamentoNaturezaFinanceiraID: TIntegerField;
    CDSLancamentoNaturezaFinanceiraID_FIN_LANCAMENTO_RECEBER: TIntegerField;
    CDSLancamentoNaturezaFinanceiraID_CONTABIL_LANCAMENTO_DET: TIntegerField;
    CDSLancamentoNaturezaFinanceiraID_NATUREZA_FINANCEIRA: TIntegerField;
    CDSLancamentoNaturezaFinanceiraDATA_INCLUSAO: TDateField;
    CDSLancamentoNaturezaFinanceiraVALOR: TFMTBCDField;
    CDSLancamentoNaturezaFinanceiraNATUREZA_FINANCEIRACLASSIFICACAO: TStringField;
    CDSLancamentoNaturezaFinanceiraNATUREZA_FINANCEIRADESCRICAO: TStringField;
    CDSLancamentoNaturezaFinanceiraPERSISTE: TStringField;
    EditTaxaComissao: TLabeledCalcEdit;
    EditValorComissao: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdClienteExit(Sender: TObject);
    procedure EditIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdDocumentoOrigemExit(Sender: TObject);
    procedure EditIdDocumentoOrigemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionGerarParcelasExecute(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridParcelasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSParcelaReceberAfterEdit(DataSet: TDataSet);
    procedure CDSParcelaReceberBeforeDelete(DataSet: TDataSet);
    procedure GridParcelasUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure EditIdClienteKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdDocumentoOrigemKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdContaCaixaExit(Sender: TObject);
    procedure EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure CDSParcelaReceberAfterPost(DataSet: TDataSet);
    procedure GerarParcelas;
    procedure ActionEmitirBoletoExecute(Sender: TObject);
    procedure JvDBUltimGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSLancamentoNaturezaFinanceiraAfterEdit(DataSet: TDataSet);
    procedure CDSLancamentoNaturezaFinanceiraAfterPost(DataSet: TDataSet);
    procedure EditTaxaComissaoExit(Sender: TObject);
    procedure GridParcelasCellClick(Column: TColumn);
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
  FFinLancamentoReceber: TFFinLancamentoReceber;
  AdmParametroVO: TAdmParametroVO;

implementation

uses ULookup, Biblioteca, UDataModule, PessoaVO, PessoaController,
  FinDocumentoOrigemVO, FinDocumentoOrigemController, FinParcelaReceberVO,
  FinParcelaReceberController, ContaCaixaVO, ContaCaixaController, NaturezaFinanceiraVO,
  NaturezaFinanceiraController, FinLctoReceberNtFinanceiraVO, FinConfiguracaoBoletoController,
  FinConfiguracaoBoletoVO, ClienteVO, ClienteController, AdmParametroController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFFinLancamentoReceber.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFinLancamentoReceberVO;
  ObjetoController := TFinLancamentoReceberController.Create;

  inherited;

  AdmParametroVO := TAdmParametroController.VO<TAdmParametroVO>('ID_EMPRESA', IntToStr(Sessao.IdEmpresa));
end;

procedure TFFinLancamentoReceber.LimparCampos;
begin
  inherited;
  CDSParcelaReceber.EmptyDataSet;
  CDSLancamentoNaturezaFinanceira.EmptyDataSet;
end;

procedure TFFinLancamentoReceber.ConfigurarLayoutTela;
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

function TFFinLancamentoReceber.VerificarTotalNaturezaFinanceira: Boolean;
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
  Result := (Total = EditValorAReceber.Value);
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFinLancamentoReceber.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdCliente.SetFocus;
  end;
end;

function TFFinLancamentoReceber.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdCliente.SetFocus;
  end;
end;

function TFFinLancamentoReceber.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFinLancamentoReceberController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFinLancamentoReceberController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFinLancamentoReceber.DoSalvar: Boolean;
var
  ParcelaReceber: TFinParcelaReceberVO;
  LancamentoNaturezaFinanceira: TFinLctoReceberNtFinanceiraVO;
begin
  if not CDSLancamentoNaturezaFinanceira.IsEmpty then
  begin
    if not VerificarTotalNaturezaFinanceira then begin
      Application.MessageBox('Os valores informados nas naturezas financeiras não batem com o valor a receber.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      Exit(False);
    end;
  end;

  Result := inherited DoSalvar;

  DecimalSeparator := '.';

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFinLancamentoReceberVO.Create;

      TFinLancamentoReceberVO(ObjetoVO).IdCliente := EditIdCliente.AsInteger;
      TFinLancamentoReceberVO(ObjetoVO).ClientePessoaNome := EditCliente.Text;
      TFinLancamentoReceberVO(ObjetoVO).IdFinDocumentoOrigem := EditIdDocumentoOrigem.AsInteger;
      TFinLancamentoReceberVO(ObjetoVO).DocumentoOrigemSigla := EditDocumentoOrigem.Text;
      TFinLancamentoReceberVO(ObjetoVO).QuantidadeParcela := EditQuantidadeParcelas.AsInteger;
      TFinLancamentoReceberVO(ObjetoVO).ValorTotal := EditValorTotal.Value;
      TFinLancamentoReceberVO(ObjetoVO).ValorAReceber := EditValorAReceber.Value;
      TFinLancamentoReceberVO(ObjetoVO).DataLancamento := EditDataLancamento.Date;
      TFinLancamentoReceberVO(ObjetoVO).NumeroDocumento := EditNumeroDocumento.Text;
      TFinLancamentoReceberVO(ObjetoVO).PrimeiroVencimento := EditPrimeiroVencimento.Date;
      TFinLancamentoReceberVO(ObjetoVO).IntervaloEntreParcelas := EditIntervalorEntreParcelas.AsInteger;
      TFinLancamentoReceberVO(ObjetoVO).TaxaComissao := EditTaxaComissao.Value;
      TFinLancamentoReceberVO(ObjetoVO).ValorComissao := EditValorComissao.Value;

      if StatusTela = stEditando then
        TFinLancamentoReceberVO(ObjetoVO).Id := IdRegistroSelecionado;

      // Parcelas
      TFinLancamentoReceberVO(ObjetoVO).ListaParcelaReceberVO := TObjectList<TFinParcelaReceberVO>.Create;
      CDSParcelaReceber.DisableControls;
      CDSParcelaReceber.First;
      while not CDSParcelaReceber.Eof do
      begin
        if (CDSParcelaReceberPERSISTE.AsString = 'S') or (CDSParcelaReceberID.AsInteger = 0) then
        begin
          ParcelaReceber := TFinParcelaReceberVO.Create;
          ParcelaReceber.Id := CDSParcelaReceberID.AsInteger;
          ParcelaReceber.IdFinLancamentoReceber := TFinLancamentoReceberVO(ObjetoVO).Id;
          ParcelaReceber.IdContaCaixa := CDSParcelaReceberID_CONTA_CAIXA.AsInteger;
          ParcelaReceber.IdFinStatusParcela := AdmParametroVO.FinParcelaAberto;
          ParcelaReceber.NumeroParcela := CDSParcelaReceberNUMERO_PARCELA.AsInteger;
          ParcelaReceber.DataEmissao := CDSParcelaReceberDATA_EMISSAO.AsDateTime;
          ParcelaReceber.DataVencimento := CDSParcelaReceberDATA_VENCIMENTO.AsDateTime;
          ParcelaReceber.DescontoAte := CDSParcelaReceberDESCONTO_ATE.AsDateTime;
          ParcelaReceber.Valor := CDSParcelaReceberVALOR.AsExtended;

          ParcelaReceber.EmitiuBoleto := CDSParcelaReceberEMITIU_BOLETO.AsString;
          ParcelaReceber.BoletoNossoNumero := CDSParcelaReceberBOLETO_NOSSO_NUMERO.AsString;

          ParcelaReceber.TaxaJuro := CDSParcelaReceberTAXA_JURO.AsExtended;
          ParcelaReceber.TaxaMulta := CDSParcelaReceberTAXA_MULTA.AsExtended;
          ParcelaReceber.TaxaDesconto := CDSParcelaReceberTAXA_DESCONTO.AsExtended;
          ParcelaReceber.ValorJuro := CDSParcelaReceberVALOR_JURO.AsExtended;
          ParcelaReceber.ValorMulta := CDSParcelaReceberVALOR_MULTA.AsExtended;
          ParcelaReceber.ValorDesconto := CDSParcelaReceberVALOR_DESCONTO.AsExtended;

          TFinLancamentoReceberVO(ObjetoVO).ListaParcelaReceberVO.Add(ParcelaReceber);
        end;

        CDSParcelaReceber.Next;
      end;
      CDSParcelaReceber.EnableControls;

      // Natureza Financeira
      TFinLancamentoReceberVO(ObjetoVO).ListaLancReceberNatFinanceiraVO := TObjectList<TFinLctoReceberNtFinanceiraVO>.Create;
      CDSLancamentoNaturezaFinanceira.DisableControls;
      CDSLancamentoNaturezaFinanceira.First;
      while not CDSLancamentoNaturezaFinanceira.Eof do
      begin
        if (CDSLancamentoNaturezaFinanceiraPERSISTE.AsString = 'S') or (CDSLancamentoNaturezaFinanceiraID.AsInteger = 0) then
        begin
          LancamentoNaturezaFinanceira := TFinLctoReceberNtFinanceiraVO.Create;

          LancamentoNaturezaFinanceira.Id := CDSLancamentoNaturezaFinanceiraID.AsInteger;
          LancamentoNaturezaFinanceira.IdFinLancamentoReceber := CDSLancamentoNaturezaFinanceiraID_FIN_LANCAMENTO_RECEBER.AsInteger;
          LancamentoNaturezaFinanceira.IdNaturezaFinanceira := CDSLancamentoNaturezaFinanceiraID_NATUREZA_FINANCEIRA.AsInteger;
          LancamentoNaturezaFinanceira.DataInclusao := CDSLancamentoNaturezaFinanceiraDATA_INCLUSAO.AsDateTime;
          LancamentoNaturezaFinanceira.Valor := CDSLancamentoNaturezaFinanceiraVALOR.AsExtended;

          TFinLancamentoReceberVO(ObjetoVO).ListaLancReceberNatFinanceiraVO.Add(LancamentoNaturezaFinanceira);
        end;

        CDSLancamentoNaturezaFinanceira.Next;
      end;
      CDSLancamentoNaturezaFinanceira.EnableControls;

      // ObjetoVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      TFinLancamentoReceberVO(ObjetoVO).ClienteVO := Nil;
      TFinLancamentoReceberVO(ObjetoVO).DocumentoOrigemVO := Nil;
      if Assigned(ObjetoOldVO) then
      begin
        TFinLancamentoReceberVO(ObjetoOldVO).ClienteVO := Nil;
        TFinLancamentoReceberVO(ObjetoOldVO).DocumentoOrigemVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TFinLancamentoReceberController(ObjetoController).Insere(TFinLancamentoReceberVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFinLancamentoReceberVO(ObjetoVO).ToJSONString <> TFinLancamentoReceberVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TFinLancamentoReceberController(ObjetoController).Altera(TFinLancamentoReceberVO(ObjetoVO), TFinLancamentoReceberVO(ObjetoOldVO));
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
procedure TFFinLancamentoReceber.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;

procedure TFFinLancamentoReceber.GridParaEdits;
var
  ParcelaReceberEnumerator: TEnumerator<TFinParcelaReceberVO>;
  LancamentoNaturezaFinanceiraEnumerator: TEnumerator<TFinLctoReceberNtFinanceiraVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFinLancamentoReceberVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFinLancamentoReceberVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdCliente.AsInteger := TFinLancamentoReceberVO(ObjetoVO).IdCliente;
    EditCliente.Text := TFinLancamentoReceberVO(ObjetoVO).ClientePessoaNome;
    EditIdDocumentoOrigem.AsInteger := TFinLancamentoReceberVO(ObjetoVO).IdFinDocumentoOrigem;
    EditDocumentoOrigem.Text := TFinLancamentoReceberVO(ObjetoVO).DocumentoOrigemSigla;
    EditQuantidadeParcelas.AsInteger := TFinLancamentoReceberVO(ObjetoVO).QuantidadeParcela;
    EditValorTotal.Value := TFinLancamentoReceberVO(ObjetoVO).ValorTotal;
    EditValorAReceber.Value := TFinLancamentoReceberVO(ObjetoVO).ValorAReceber;
    EditDataLancamento.Date := TFinLancamentoReceberVO(ObjetoVO).DataLancamento;
    EditNumeroDocumento.Text := TFinLancamentoReceberVO(ObjetoVO).NumeroDocumento;
    EditPrimeiroVencimento.Date := TFinLancamentoReceberVO(ObjetoVO).PrimeiroVencimento;
    EditIntervalorEntreParcelas.AsInteger := TFinLancamentoReceberVO(ObjetoVO).IntervaloEntreParcelas;
    EditTaxaComissao.Value := TFinLancamentoReceberVO(ObjetoVO).TaxaComissao;
    EditValorComissao.Value := TFinLancamentoReceberVO(ObjetoVO).ValorComissao;

    // Parcelas
    ParcelaReceberEnumerator := TFinLancamentoReceberVO(ObjetoVO).ListaParcelaReceberVO.GetEnumerator;
    try
      if TFinLancamentoReceberVO(ObjetoVO).ListaParcelaReceberVO.Count > 0 then
      begin
        EditIdContaCaixa.AsInteger := TFinLancamentoReceberVO(ObjetoVO).ListaParcelaReceberVO[0].IdContaCaixa;
        EditContaCaixa.Text := TFinLancamentoReceberVO(ObjetoVO).ListaParcelaReceberVO[0].ContaCaixaVO.Nome;
      end;

      with ParcelaReceberEnumerator do
      begin
        while MoveNext do
        begin
          CDSParcelaReceber.Append;

          CDSParcelaReceberID.AsInteger := Current.Id;
          CDSParcelaReceberID_FIN_LANCAMENTO_RECEBER.AsInteger := Current.IdFinLancamentoReceber;
          CDSParcelaReceberID_CONTA_CAIXA.AsInteger := Current.IdContaCaixa;
          CDSParcelaReceberCONTA_CAIXANOME.AsString := Current.ContaCaixaVO.Nome;
          CDSParcelaReceberNUMERO_PARCELA.AsInteger := Current.NumeroParcela;
          CDSParcelaReceberDATA_EMISSAO.AsDateTime := Current.DataEmissao;
          CDSParcelaReceberDATA_VENCIMENTO.AsDateTime := Current.DataVencimento;
          CDSParcelaReceberDESCONTO_ATE.AsDateTime := Current.DescontoAte;
          CDSParcelaReceberVALOR.AsExtended := Current.Valor;
          CDSParcelaReceberTAXA_JURO.AsExtended := Current.TaxaJuro;
          CDSParcelaReceberTAXA_MULTA.AsExtended := Current.TaxaMulta;
          CDSParcelaReceberTAXA_DESCONTO.AsExtended := Current.TaxaDesconto;
          CDSParcelaReceberVALOR_JURO.AsExtended := Current.ValorJuro;
          CDSParcelaReceberVALOR_MULTA.AsExtended := Current.ValorMulta;
          CDSParcelaReceberVALOR_DESCONTO.AsExtended := Current.ValorDesconto;
          CDSParcelaReceberEMITIU_BOLETO.AsString := Current.EmitiuBoleto;
          CDSParcelaReceberBOLETO_NOSSO_NUMERO.AsString := Current.BoletoNossoNumero;

          CDSParcelaReceber.Post;
        end;
      end;
    finally
      ParcelaReceberEnumerator.Free;
    end;

    // Natureza Financeira
    LancamentoNaturezaFinanceiraEnumerator := TFinLancamentoReceberVO(ObjetoVO).ListaLancReceberNatFinanceiraVO.GetEnumerator;
    try
      with LancamentoNaturezaFinanceiraEnumerator do
      begin
        while MoveNext do
        begin
          CDSLancamentoNaturezaFinanceira.Append;

          CDSLancamentoNaturezaFinanceiraID.AsInteger := Current.Id;
          CDSLancamentoNaturezaFinanceiraID_FIN_LANCAMENTO_RECEBER.AsInteger := Current.IdFinLancamentoReceber;
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

    TFinLancamentoReceberVO(ObjetoVO).ListaParcelaReceberVO := Nil;
    TFinLancamentoReceberVO(ObjetoVO).ListaLancReceberNatFinanceiraVO := Nil;
    if Assigned(TFinLancamentoReceberVO(ObjetoOldVO)) then
    begin
      TFinLancamentoReceberVO(ObjetoOldVO).ListaParcelaReceberVO := Nil;
      TFinLancamentoReceberVO(ObjetoOldVO).ListaLancReceberNatFinanceiraVO := Nil;
    end;
  end;
  ConfigurarLayoutTela;
end;

procedure TFFinLancamentoReceber.GridParcelasUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    CDSParcelaReceber.AddIndex(IxDName, Fields, [], DescFields);
    CDSParcelaReceber.IndexDefs.Update;
    CDSParcelaReceber.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFFinLancamentoReceber.JvDBUltimGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFFinLancamentoReceber.GridParcelasCellClick(Column: TColumn);
var
  NossoNumero: String;
begin
  if Column.Index = 4 then
  begin
    CDSParcelaReceber.Edit;
    if CDSParcelaReceber.FieldByName('EMITIU_BOLETO').AsString = '' then
    begin
      NossoNumero := StringOfChar('0', 5 - Length(EditIdCliente.Text)) + EditIdCliente.Text;
      NossoNumero := NossoNumero + StringOfChar('0', 5 - Length(EditIdContaCaixa.Text)) + EditIdContaCaixa.Text;
      NossoNumero := NossoNumero + StringOfChar('0', 4 - Length(CDSParcelaReceber.FieldByName('NUMERO_PARCELA').AsString)) + CDSParcelaReceber.FieldByName('NUMERO_PARCELA').AsString;
      NossoNumero := NossoNumero + FormatDateTime('ddhhss', now);
      CDSParcelaReceber.FieldByName('EMITIU_BOLETO').AsString := 'S';
      CDSParcelaReceber.FieldByName('BOLETO_NOSSO_NUMERO').AsString := NossoNumero;
    end
    else
    begin
      CDSParcelaReceber.FieldByName('EMITIU_BOLETO').AsString := '';
      CDSParcelaReceber.FieldByName('BOLETO_NOSSO_NUMERO').AsString := '';
    end;
    CDSParcelaReceber.Post;
  end;
end;

procedure TFFinLancamentoReceber.GridParcelasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridParcelas.SelectedIndex := GridParcelas.SelectedIndex + 1;
end;

procedure TFFinLancamentoReceber.CDSLancamentoNaturezaFinanceiraAfterEdit(DataSet: TDataSet);
begin
  CDSLancamentoNaturezaFinanceiraPERSISTE.AsString := 'S';
end;

procedure TFFinLancamentoReceber.CDSLancamentoNaturezaFinanceiraAfterPost(DataSet: TDataSet);
begin
  if CDSLancamentoNaturezaFinanceiraID_NATUREZA_FINANCEIRA.AsInteger = 0 then
    CDSLancamentoNaturezaFinanceira.Delete;
end;

procedure TFFinLancamentoReceber.CDSParcelaReceberAfterEdit(DataSet: TDataSet);
begin
  CDSParcelaReceberPERSISTE.AsString := 'S';
end;

procedure TFFinLancamentoReceber.CDSParcelaReceberAfterPost(DataSet: TDataSet);
begin
  if CDSParcelaReceberNUMERO_PARCELA.AsInteger = 0 then
    CDSParcelaReceber.Delete;
end;

procedure TFFinLancamentoReceber.CDSParcelaReceberBeforeDelete(DataSet: TDataSet);
begin
  if CDSParcelaReceberID.AsInteger > 0 then
    TFinParcelaReceberController.Exclui(CDSParcelaReceberID.AsInteger);
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFinLancamentoReceber.EditIdClienteExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdCliente.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdCliente.Text;
      EditIdCliente.Clear;
      EditCliente.Clear;
      if not PopulaCamposTransientes(Filtro, TClienteVO, TClienteController) then
        PopulaCamposTransientesLookup(TClienteVO, TClienteController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdCliente.Text := CDSTransiente.FieldByName('ID').AsString;
        EditCliente.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdCliente.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCliente.Clear;
  end;
end;

procedure TFFinLancamentoReceber.EditIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdCliente.Value := -1;
    EditIdDocumentoOrigem.SetFocus;
  end;
end;

procedure TFFinLancamentoReceber.EditIdClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdDocumentoOrigem.SetFocus;
  end;
end;

procedure TFFinLancamentoReceber.EditIdContaCaixaExit(Sender: TObject);
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

procedure TFFinLancamentoReceber.EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContaCaixa.Value := -1;
    GridParcelas.SetFocus;
  end;
end;

procedure TFFinLancamentoReceber.EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    GridParcelas.SetFocus;
  end;
end;

procedure TFFinLancamentoReceber.EditIdDocumentoOrigemExit(Sender: TObject);
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

procedure TFFinLancamentoReceber.EditIdDocumentoOrigemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdDocumentoOrigem.Value := -1;
    EditNumeroDocumento.SetFocus;
  end;
end;

procedure TFFinLancamentoReceber.EditIdDocumentoOrigemKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditNumeroDocumento.SetFocus;
  end;
end;

procedure TFFinLancamentoReceber.EditTaxaComissaoExit(Sender: TObject);
begin
  EditValorComissao.Value := EditValorAReceber.Value * EditTaxaComissao.Value / 100;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFFinLancamentoReceber.ActionEmitirBoletoExecute(Sender: TObject);
var
  Titulo: TACBrTitulo;
  Pdir: Pchar;
  ConfiguracaoBoletoVO: TFinConfiguracaoBoletoVO;
  ClienteVO: TClienteVO;
  TemBoleto: Boolean;
begin
  TemBoleto := False;

  CDSParcelaReceber.DisableControls;
  CDSParcelaReceber.First;
  while not CDSParcelaReceber.Eof do
  begin
    if CDSParcelaReceber.FieldByName('EMITIU_BOLETO').AsString = 'S' then
    begin
      TemBoleto := True;
    end;
    CDSParcelaReceber.Next;
  end;
  CDSParcelaReceber.First;
  CDSParcelaReceber.EnableControls;

  if not TemBoleto then
  begin
    Application.MessageBox('Não existem registros selecionados para emissão de boleto.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    GridParcelas.SetFocus;
    Exit;
  end;

  if EditIdContaCaixa.AsInteger <= 0 then
  begin
    Application.MessageBox('É necessário informar a conta/caixa para previsão das parcelas.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdContaCaixa.SetFocus;
    Exit;
  end;

  ConfiguracaoBoletoVO := TFinConfiguracaoBoletoController.VO<TFinConfiguracaoBoletoVO>('ID_CONTA_CAIXA', QuotedStr(EditIdContaCaixa.Text));

  if not Assigned(ConfiguracaoBoletoVO) then
  begin
    Application.MessageBox('Não existem configurações de boleto para a conta/caixa. Cadastre as configurações.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdContaCaixa.SetFocus;
    Exit;
  end;
  
  if ConfiguracaoBoletoVO.ContaCaixaVO.AgenciaBancoVO.IdBanco = 0 then
  begin
    Application.MessageBox('A conta/caixa não está vinculada a um banco. Geração de boletos não permitida.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdContaCaixa.SetFocus;
    Exit;
  end;

  ClienteVO := TClienteController.VO<TClienteVO>('ID', QuotedStr(EditIdCliente.Text));

  FDataModule.ACBrBoleto.ListadeBoletos.Clear;

  if ConfiguracaoBoletoVO.ContaCaixaVO.AgenciaBancoVO.BancoVO.Codigo = '001' then
    FDataModule.ACBrBoleto.Banco.TipoCobranca := cobBancoDoBrasil
  else if ConfiguracaoBoletoVO.ContaCaixaVO.AgenciaBancoVO.BancoVO.Codigo = '104' then
    FDataModule.ACBrBoleto.Banco.TipoCobranca := cobCaixaEconomica
  else if ConfiguracaoBoletoVO.ContaCaixaVO.AgenciaBancoVO.BancoVO.Codigo = '237' then
    FDataModule.ACBrBoleto.Banco.TipoCobranca := cobBradesco
  else if ConfiguracaoBoletoVO.ContaCaixaVO.AgenciaBancoVO.BancoVO.Codigo = '341' then
    FDataModule.ACBrBoleto.Banco.TipoCobranca := cobItau;

  FDataModule.ACBrBoleto.DirArqRemessa := StringReplace(ConfiguracaoBoletoVO.CaminhoArquivoRemessa,'/','\',[rfReplaceAll]);
  FDataModule.ACBrBoleto.DirArqRetorno := StringReplace(ConfiguracaoBoletoVO.CaminhoArquivoRetorno,'/','\',[rfReplaceAll]);
  if ConfiguracaoBoletoVO.LayoutRemessa = '240' then
    FDataModule.ACBrBoleto.LayoutRemessa := c240
  else if ConfiguracaoBoletoVO.LayoutRemessa = '400' then
    FDataModule.ACBrBoleto.LayoutRemessa := c400;

  FDataModule.ACBrBoleto.Cedente.Nome := Sessao.Empresa.RazaoSocial;
  FDataModule.ACBrBoleto.Cedente.Agencia := ConfiguracaoBoletoVO.ContaCaixaVO.AgenciaBancoVO.Codigo;
  FDataModule.ACBrBoleto.Cedente.AgenciaDigito := ConfiguracaoBoletoVO.ContaCaixaVO.AgenciaBancoVO.Digito;
  FDataModule.ACBrBoleto.Cedente.CNPJCPF := Sessao.Empresa.Cnpj;
  FDataModule.ACBrBoleto.Cedente.Conta := ConfiguracaoBoletoVO.ContaCaixaVO.Codigo;
  FDataModule.ACBrBoleto.Cedente.ContaDigito := ConfiguracaoBoletoVO.ContaCaixaVO.Digito;
  FDataModule.ACBrBoleto.Cedente.CodigoCedente := ConfiguracaoBoletoVO.CodigoCedente;
  FDataModule.ACBrBoleto.Cedente.Convenio := ConfiguracaoBoletoVO.CodigoConvenio;
  FDataModule.ACBrBoleto.Cedente.Logradouro := Sessao.Empresa.ListaEnderecoVO.Items[0].Logradouro;
  FDataModule.ACBrBoleto.Cedente.Complemento := Sessao.Empresa.ListaEnderecoVO.Items[0].Complemento;
  FDataModule.ACBrBoleto.Cedente.Bairro := Sessao.Empresa.ListaEnderecoVO.Items[0].Bairro;
  FDataModule.ACBrBoleto.Cedente.CEP := Sessao.Empresa.ListaEnderecoVO.Items[0].Cep;
  FDataModule.ACBrBoleto.Cedente.Cidade := Sessao.Empresa.ListaEnderecoVO.Items[0].Cidade;
  FDataModule.ACBrBoleto.Cedente.UF := Sessao.Empresa.ListaEnderecoVO.Items[0].Uf;


  CDSParcelaReceber.DisableControls;
  CDSParcelaReceber.First;
  while not CDSParcelaReceber.Eof do
  begin
    if CDSParcelaReceber.FieldByName('EMITIU_BOLETO').AsString = 'S' then
    begin
      Titulo := FDataModule.ACBrBoleto.CriarTituloNaLista;

      Titulo.LocalPagamento := ConfiguracaoBoletoVO.LocalPagamento;
      Titulo.Vencimento := CDSParcelaReceber.FieldByName('DATA_VENCIMENTO').AsDateTime;
      Titulo.DataDocumento := Now;
      Titulo.DataProcessamento := Now;
      Titulo.EspecieDoc := ConfiguracaoBoletoVO.Especie;
      if ConfiguracaoBoletoVO.Aceite = 'S' then
        Titulo.Aceite := atSim
      else
        Titulo.Aceite := atNao;
      Titulo.NumeroDocumento := CDSParcelaReceber.FieldByName('BOLETO_NOSSO_NUMERO').AsString;
      Titulo.NossoNumero := CDSParcelaReceber.FieldByName('BOLETO_NOSSO_NUMERO').AsString;
      Titulo.Carteira := ConfiguracaoBoletoVO.Carteira;

      Titulo.Sacado.NomeSacado := ClienteVO.PessoaVO.Nome;

      if ClienteVO.PessoaVO.Tipo = 'F' then
        Titulo.Sacado.CNPJCPF := ClienteVO.PessoaVO.PessoaFisicaVO.Cpf
      else
        Titulo.Sacado.CNPJCPF := ClienteVO.PessoaVO.PessoaJuridicaVO.Cnpj;

      Titulo.Sacado.Logradouro := ClienteVO.PessoaVO.ListaEnderecoVO.Items[0].Logradouro;
      Titulo.Sacado.Numero := ClienteVO.PessoaVO.ListaEnderecoVO.Items[0].Numero;
      Titulo.Sacado.Bairro := ClienteVO.PessoaVO.ListaEnderecoVO.Items[0].Bairro;
      Titulo.Sacado.Cidade := ClienteVO.PessoaVO.ListaEnderecoVO.Items[0].Cidade;
      Titulo.Sacado.UF := ClienteVO.PessoaVO.ListaEnderecoVO.Items[0].Uf;
      Titulo.Sacado.CEP := ClienteVO.PessoaVO.ListaEnderecoVO.Items[0].Cep;

      Titulo.ValorDesconto := CDSParcelaReceber.FieldByName('VALOR_DESCONTO').AsExtended;
      Titulo.DataDesconto := CDSParcelaReceber.FieldByName('DESCONTO_ATE').AsDateTime;
      Titulo.ValorDocumento := CDSParcelaReceber.FieldByName('VALOR').AsFloat;
      Titulo.Parcela := CDSParcelaReceber.FieldByName('NUMERO_PARCELA').AsInteger;
      Titulo.PercentualMulta := CDSParcelaReceber.FieldByName('TAXA_MULTA').AsExtended;
      Titulo.TotalParcelas := EditQuantidadeParcelas.AsInteger;

      Titulo.Instrucao1 := ConfiguracaoBoletoVO.Instrucao01;
      Titulo.Instrucao2 := ConfiguracaoBoletoVO.Instrucao02;

      FDataModule.ACBrBoleto.AdicionarMensagensPadroes(Titulo, TStrings(ConfiguracaoBoletoVO.Mensagem));
    end;
    CDSParcelaReceber.Next;
  end;
  CDSParcelaReceber.First;
  CDSParcelaReceber.EnableControls;

  if Application.MessageBox('Deseja emitir os boletos?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    //FDataModule.ACBrBoleto.ACBrBoletoFC.DirArqPDF_HTML := StringReplace(ConfiguracaoBoletoVO.CaminhoArquivoPdf,'/','\',[rfReplaceAll]);
    //FDataModule.ACBrBoleto.ACBrBoletoFC.NomeArquivo := 'boleto.pdf';
    FDataModule.ACBrBoleto.ACBrBoletoFC.NomeArquivo := StringReplace(ConfiguracaoBoletoVO.CaminhoArquivoPdf,'/','\',[rfReplaceAll]) + 'boleto.pdf';
    FDataModule.ACBrBoleto.GerarPDF;

    GetMem(Pdir, 256);
    StrPCopy(Pdir, StringReplace(ConfiguracaoBoletoVO.CaminhoArquivoPdf,'/','\',[rfReplaceAll]));
    ShellExecute(0, nil, 'boleto.pdf', nil, Pdir, SW_NORMAL);
    FreeMem(Pdir, 256);
  end;

  if Application.MessageBox('Deseja gerar o arquivo de remessa?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    FDataModule.ACBrBoleto.NomeArqRemessa := 'arquivo_remessa.txt';
    FDataModule.ACBrBoleto.GerarRemessa(1);
    Application.MessageBox('Remessa gerada com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  end;
end;

procedure TFFinLancamentoReceber.ActionGerarParcelasExecute(Sender: TObject);
begin
  if EditIdContaCaixa.AsInteger <= 0 then
  begin
    Application.MessageBox('É necessário informar a conta/caixa para previsão das parcelas.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdContaCaixa.SetFocus;
    Exit;
  end;

  if not CDSParcelaReceber.IsEmpty then
  begin
    if Application.MessageBox('Já existem parcelas geradas e serão excluídas. Deseja continuar?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
    begin
      CDSParcelaReceber.DisableControls;
      CDSParcelaReceber.First;
      while not CDSParcelaReceber.Eof do
      begin
        if CDSParcelaReceberID.AsInteger > 0 then
          TFinParcelaReceberController.Exclui(CDSParcelaReceberID.AsInteger);

        CDSParcelaReceber.Next;
      end;
      CDSParcelaReceber.First;
      CDSParcelaReceber.EnableControls;

      CDSParcelaReceber.EmptyDataSet;
      GerarParcelas;
    end;
  end
  else
    GerarParcelas;
end;

procedure TFFinLancamentoReceber.GerarParcelas;
var
  I: Integer;
  Vencimento: TDate;
  SomaParcelas, Residuo: Extended;
begin
  if EditQuantidadeParcelas.AsInteger <= 0 then
    EditQuantidadeParcelas.AsInteger := 1;

  if EditPrimeiroVencimento.Text = '  /  /    ' then
    EditPrimeiroVencimento.Date := Date;

  Vencimento := EditPrimeiroVencimento.Date;
  SomaParcelas := 0;
  Residuo := 0;

  for I := 0 to EditQuantidadeParcelas.AsInteger - 1 do
  begin
    CDSParcelaReceber.Append;
    CDSParcelaReceber.FieldByName('NUMERO_PARCELA').AsInteger := I + 1;
    CDSParcelaReceber.FieldByName('ID_CONTA_CAIXA').AsInteger := EditIdContaCaixa.AsInteger;
    CDSParcelaReceber.FieldByName('DATA_EMISSAO').AsString := DateToStr(Date);
    CDSParcelaReceber.FieldByName('DATA_VENCIMENTO').AsString := DateToStr(Vencimento + (EditIntervalorEntreParcelas.AsInteger * I));
    CDSParcelaReceber.FieldByName('DESCONTO_ATE').AsString := DateToStr(Date);
    CDSParcelaReceber.FieldByName('VALOR').AsFloat := ArredondaTruncaValor('A', EditValorAReceber.Value / EditQuantidadeParcelas.AsInteger, Constantes.TConstantes.DECIMAIS_VALOR);
    CDSParcelaReceber.FieldByName('CONTA_CAIXA.NOME').AsString := EditContaCaixa.Text;
    CDSParcelaReceber.Post;

    SomaParcelas := SomaParcelas + CDSParcelaReceber.FieldByName('VALOR').AsFloat;
  end;

  // calcula o resíduo e lança na última parcela
  Residuo := EditValorAReceber.Value - SomaParcelas;
  CDSParcelaReceber.Edit;
  CDSParcelaReceber.FieldByName('VALOR').AsFloat := CDSParcelaReceber.FieldByName('VALOR').AsFloat + Residuo;
  CDSParcelaReceber.Post;
end;
{$ENDREGION}

end.
