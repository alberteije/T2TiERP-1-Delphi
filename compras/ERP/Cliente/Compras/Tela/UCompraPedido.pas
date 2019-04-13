{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de CompraPedidos

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
  t2ti.com@gmail.com

  @author Albert Eije
  @version 1.0
  ******************************************************************************* }
unit UCompraPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos, Constantes,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, DB, DBClient, Generics.Collections,
  WideStrings, DBXMySql, FMTBcd, Provider, SqlExpr, StrUtils, ToolWin, ActnMan,
  ActnCtrls, ActnList, PlatformDefaultStyleActnCtrls, Biblioteca, AdmParametroVO;

type
  [TFormDescription(TConstantes.MODULO_COMPRAS, 'Compra Pedido')]

  TFCompraPedido = class(TFTelaCadastro)
    DSCompraPedidoDetalhe: TDataSource;
    GroupBoxItensPedido: TGroupBox;
    GridCompraPedidoDetalhe: TJvDBUltimGrid;
    CDSCompraPedidoDetalhe: TClientDataSet;
    CDSCompraPedidoDetalheID: TIntegerField;
    CDSCompraPedidoDetalheID_COMPRA_PEDIDO: TIntegerField;
    CDSCompraPedidoDetalheID_PRODUTO: TIntegerField;
    CDSCompraPedidoDetalheQUANTIDADE: TFMTBCDField;
    CDSCompraPedidoDetalheVALOR_UNITARIO: TFMTBCDField;
    CDSCompraPedidoDetalheVALOR_SUBTOTAL: TFMTBCDField;
    CDSCompraPedidoDetalheTAXA_DESCONTO: TFMTBCDField;
    CDSCompraPedidoDetalheVALOR_DESCONTO: TFMTBCDField;
    CDSCompraPedidoDetalheVALOR_TOTAL: TFMTBCDField;
    CDSCompraPedidoDetalheCST_CSOSN: TStringField;
    CDSCompraPedidoDetalheCFOP: TIntegerField;
    CDSCompraPedidoDetalheBASE_CALCULO_ICMS: TFMTBCDField;
    CDSCompraPedidoDetalheVALOR_ICMS: TFMTBCDField;
    CDSCompraPedidoDetalheVALOR_IPI: TFMTBCDField;
    CDSCompraPedidoDetalheALIQUOTA_ICMS: TFMTBCDField;
    CDSCompraPedidoDetalheALIQUOTA_IPI: TFMTBCDField;
    CDSCompraPedidoDetalhePERSISTE: TStringField;
    CDSCompraPedidoDetalhePRODUTONOME: TStringField;
    BevelEdits: TBevel;
    EditLocalEntrega: TLabeledEdit;
    EditValorSubtotal: TLabeledCalcEdit;
    EditValorFrete: TLabeledCalcEdit;
    EditValorIcmsSt: TLabeledCalcEdit;
    EditValorICMS: TLabeledCalcEdit;
    EditFornecedor: TLabeledEdit;
    ComboBoxTipoFrete: TLabeledComboBox;
    EditDataPedido: TLabeledDateEdit;
    EditDataPrevistaEntrega: TLabeledDateEdit;
    EditValorDesconto: TLabeledCalcEdit;
    EditTaxaDesconto: TLabeledCalcEdit;
    EditValorTotalPedido: TLabeledCalcEdit;
    EditIdFornecedor: TLabeledCalcEdit;
    EditIdCompraTipoPedido: TLabeledCalcEdit;
    EditCompraTipoPedido: TLabeledEdit;
    EditQuantidadeParcelas: TLabeledCalcEdit;
    EditLocalCobranca: TLabeledEdit;
    ComboBoxFormaPagamento: TLabeledComboBox;
    EditDataPrevisaoPagamento: TLabeledDateEdit;
    EditContato: TLabeledEdit;
    EditBaseCalculoIcmsSt: TLabeledCalcEdit;
    EditValorSeguro: TLabeledCalcEdit;
    EditValorOutrasDespesas: TLabeledCalcEdit;
    EditValorIPI: TLabeledCalcEdit;
    EditBaseCalculoICMS: TLabeledCalcEdit;
    EditValorTotalProdutos: TLabeledCalcEdit;
    EditValorTotalNF: TLabeledCalcEdit;
    EditDiasPrimeiroVencimento: TLabeledCalcEdit;
    EditDiasIntervalo: TLabeledCalcEdit;
    ActionManager1: TActionManager;
    ActionAtualizarValores: TAction;
    ActionToolBar1: TActionToolBar;
    procedure FormCreate(Sender: TObject);
    procedure EditIdFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSCompraPedidoDetalheBeforePost(DataSet: TDataSet);
    procedure EditIdCompraTipoPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdFornecedorExit(Sender: TObject);
    procedure EditIdCompraTipoPedidoExit(Sender: TObject);
    procedure GridCompraPedidoDetalheUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure EditIdFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdCompraTipoPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure GridCompraPedidoDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionAtualizarValoresExecute(Sender: TObject);
    procedure CDSCompraPedidoDetalheAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
    procedure AtualizaTotaisItens(pEditarValores: Boolean);
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

  end;

var
  FCompraPedido: TFCompraPedido;
  AdmParametroVO: TAdmParametroVO;

implementation

uses CompraPedidoController, CompraPedidoVO, CompraPedidoDetalheVO,
  ULookup, FornecedorVO, FornecedorController, CompraTipoPedidoVO,
  CompraTipoPedidoController, ProdutoVO, ProdutoController, UDataModule,
  FinLancamentoPagarVO, FinParcelaPagarVO, FinLancamentoPagarController,
  AdmParametroController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFCompraPedido.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TCompraPedidoVO;
  ObjetoController := TCompraPedidoController.Create;

  inherited;

  AdmParametroVO := TAdmParametroController.VO<TAdmParametroVO>('ID_EMPRESA', IntToStr(Sessao.IdEmpresa));
end;

procedure TFCompraPedido.LimparCampos;
begin
  inherited;
  CDSCompraPedidoDetalhe.EmptyDataSet;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFCompraPedido.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdFornecedor.SetFocus;
  end;
end;

function TFCompraPedido.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdFornecedor.SetFocus;
    AtualizaTotaisItens(True);
  end;
end;

function TFCompraPedido.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TCompraPedidoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TCompraPedidoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFCompraPedido.DoSalvar: Boolean;
var
  CompraPedidoDetalhe: TCompraPedidoDetalheVO;
  LancamentoPagar: TFinLancamentoPagarVO;
  ParcelaPagar: TFinParcelaPagarVO;
  i: Integer;
begin
  DecimalSeparator := '.';
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TCompraPedidoVO.Create;

      AtualizaTotaisItens(False);

      TCompraPedidoVO(ObjetoVO).IdFornecedor := EditIdFornecedor.AsInteger;
      TCompraPedidoVO(ObjetoVO).FornecedorPessoaNome := EditFornecedor.Text;
      TCompraPedidoVO(ObjetoVO).IdCompraTipoPedido := EditIdCompraTipoPedido.AsInteger;
      TCompraPedidoVO(ObjetoVO).CompraTipoPedidoNome := EditCompraTipoPedido.Text;
      TCompraPedidoVO(ObjetoVO).DataPedido := EditDataPedido.Date;
      TCompraPedidoVO(ObjetoVO).DataPrevistaEntrega := EditDataPrevistaEntrega.Date;
      TCompraPedidoVO(ObjetoVO).DataPrevisaoPagamento := EditDataPrevisaoPagamento.Date;
      TCompraPedidoVO(ObjetoVO).LocalEntrega := EditLocalEntrega.Text;
      TCompraPedidoVO(ObjetoVO).LocalCobranca := EditLocalCobranca.Text;
      TCompraPedidoVO(ObjetoVO).Contato := EditContato.Text;
      TCompraPedidoVO(ObjetoVO).ValorSubtotal := EditValorSubtotal.Value;
      TCompraPedidoVO(ObjetoVO).TaxaDesconto := EditTaxaDesconto.Value;
      TCompraPedidoVO(ObjetoVO).ValorDesconto := EditValorDesconto.Value;
      TCompraPedidoVO(ObjetoVO).ValorTotalPedido := EditValorTotalPedido.Value;
      TCompraPedidoVO(ObjetoVO).TipoFrete := IfThen(ComboBoxTipoFrete.ItemIndex = 0, 'C', 'F');
      TCompraPedidoVO(ObjetoVO).FormaPagamento := Copy(ComboBoxFormaPagamento.Text, 1, 1);
      TCompraPedidoVO(ObjetoVO).QuantidadeParcelas := EditQuantidadeParcelas.AsInteger;
      TCompraPedidoVO(ObjetoVO).DiasPrimeiroVencimento := EditDiasPrimeiroVencimento.AsInteger;
      TCompraPedidoVO(ObjetoVO).DiasIntervalo := EditDiasIntervalo.AsInteger;
      TCompraPedidoVO(ObjetoVO).BaseCalculoIcms := EditBaseCalculoICMS.Value;
      TCompraPedidoVO(ObjetoVO).ValorIcms := EditValorICMS.Value;
      TCompraPedidoVO(ObjetoVO).BaseCalculoIcmsSt := EditBaseCalculoIcmsSt.Value;
      TCompraPedidoVO(ObjetoVO).ValorIcmsSt := EditValorIcmsSt.Value;
      TCompraPedidoVO(ObjetoVO).ValorTotalProdutos := EditValorTotalProdutos.Value;
      TCompraPedidoVO(ObjetoVO).ValorFrete := EditValorFrete.Value;
      TCompraPedidoVO(ObjetoVO).ValorSeguro := EditValorSeguro.Value;
      TCompraPedidoVO(ObjetoVO).ValorOutrasDespesas := EditValorOutrasDespesas.Value;
      TCompraPedidoVO(ObjetoVO).ValorIpi := EditValorIPI.Value;
      TCompraPedidoVO(ObjetoVO).ValorTotalNf := EditValorTotalNF.Value;

      if StatusTela = stEditando then
        TCompraPedidoVO(ObjetoVO).Id := IdRegistroSelecionado;

      // Itens do Pedido de Compra
      TCompraPedidoVO(ObjetoVO).ListaCompraPedidoDetalheVO := TObjectList<TCompraPedidoDetalheVO>.Create;
      CDSCompraPedidoDetalhe.DisableControls;
      CDSCompraPedidoDetalhe.First;
      while not CDSCompraPedidoDetalhe.Eof do
      begin
        if (CDSCompraPedidoDetalhePERSISTE.AsString = 'S') or (CDSCompraPedidoDetalheID.AsInteger = 0) then
        begin
          CompraPedidoDetalhe := TCompraPedidoDetalheVO.Create;
          CompraPedidoDetalhe.Id := CDSCompraPedidoDetalheID.AsInteger;
          CompraPedidoDetalhe.IdCompraPedido := TCompraPedidoVO(ObjetoVO).Id;
          CompraPedidoDetalhe.IdProduto := CDSCompraPedidoDetalheID_PRODUTO.AsInteger;
          CompraPedidoDetalhe.ProdutoNome := CDSCompraPedidoDetalhePRODUTONOME.AsString;
          CompraPedidoDetalhe.Quantidade := CDSCompraPedidoDetalheQUANTIDADE.AsExtended;
          CompraPedidoDetalhe.ValorUnitario := CDSCompraPedidoDetalheVALOR_UNITARIO.AsExtended;
          CompraPedidoDetalhe.ValorSubtotal := CDSCompraPedidoDetalheVALOR_SUBTOTAL.AsExtended;
          CompraPedidoDetalhe.TaxaDesconto := CDSCompraPedidoDetalheTAXA_DESCONTO.AsExtended;
          CompraPedidoDetalhe.ValorDesconto := CDSCompraPedidoDetalheVALOR_DESCONTO.AsExtended;
          CompraPedidoDetalhe.ValorTotal := CDSCompraPedidoDetalheVALOR_TOTAL.AsExtended;
          CompraPedidoDetalhe.CstCsosn := CDSCompraPedidoDetalheCST_CSOSN.AsString;
          CompraPedidoDetalhe.Cfop := CDSCompraPedidoDetalheCFOP.AsInteger;
          CompraPedidoDetalhe.BaseCalculoIcms := CDSCompraPedidoDetalheBASE_CALCULO_ICMS.AsExtended;
          CompraPedidoDetalhe.ValorIcms := CDSCompraPedidoDetalheVALOR_ICMS.AsExtended;
          CompraPedidoDetalhe.ValorIpi := CDSCompraPedidoDetalheVALOR_IPI.AsExtended;
          CompraPedidoDetalhe.AliquotaIcms := CDSCompraPedidoDetalheALIQUOTA_ICMS.AsExtended;
          CompraPedidoDetalhe.AliquotaIpi := CDSCompraPedidoDetalheALIQUOTA_IPI.AsExtended;
          TCompraPedidoVO(ObjetoVO).ListaCompraPedidoDetalheVO.Add(CompraPedidoDetalhe);
        end;
        CDSCompraPedidoDetalhe.Next;
      end;
      CDSCompraPedidoDetalhe.First;
      CDSCompraPedidoDetalhe.EnableControls;

      // ObjetoVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      TCompraPedidoVO(ObjetoVO).FornecedorVO := Nil;
      TCompraPedidoVO(ObjetoVO).CompraTipoPedidoVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TCompraPedidoVO(ObjetoOldVO).FornecedorVO := Nil;
        TCompraPedidoVO(ObjetoOldVO).CompraTipoPedidoVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TCompraPedidoController(ObjetoController).Insere(TCompraPedidoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TCompraPedidoVO(ObjetoVO).ToJSONString <> TCompraPedidoVO(ObjetoOldVO).ToJSONString then
        begin
          TCompraPedidoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TCompraPedidoController(ObjetoController).Altera(TCompraPedidoVO(ObjetoVO), TCompraPedidoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;

      if Application.MessageBox('Deseja gerar os lançamentos para o contas a pagar?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
      begin
        LancamentoPagar := TFinLancamentoPagarVO.Create;

        LancamentoPagar.IdFornecedor := EditIdFornecedor.AsInteger;
        LancamentoPagar.FornecedorPessoaNome := EditFornecedor.Text;
        LancamentoPagar.IdFinDocumentoOrigem := AdmParametroVO.CompraFinDocOrigem;
        LancamentoPagar.PagamentoCompartilhado := 'N';
        LancamentoPagar.QuantidadeParcela := EditQuantidadeParcelas.AsInteger;
        LancamentoPagar.ValorTotal := EditValorTotalNF.Value;
        LancamentoPagar.ValorAPagar := EditValorTotalNF.Value;
        LancamentoPagar.DataLancamento := now;
        LancamentoPagar.NumeroDocumento := 'PEDIDO COMPRA';
        LancamentoPagar.PrimeiroVencimento := now + EditDiasPrimeiroVencimento.AsInteger;
        LancamentoPagar.IntervaloEntreParcelas := EditDiasIntervalo.AsInteger;

        LancamentoPagar.ListaParcelaPagarVO := TObjectList<TFinParcelaPagarVO>.Create;
        for i := 0 to EditQuantidadeParcelas.AsInteger - 1 do
        begin
          ParcelaPagar := TFinParcelaPagarVO.Create;
          ParcelaPagar.NumeroParcela := i+1;
          ParcelaPagar.IdContaCaixa := AdmParametroVO.CompraContaCaixa;
          ParcelaPagar.IdFinStatusParcela := 1;
          ParcelaPagar.DataEmissao := now;
          ParcelaPagar.DataVencimento := LancamentoPagar.PrimeiroVencimento + (EditDiasIntervalo.AsInteger * i);
          ParcelaPagar.Valor := ArredondaTruncaValor('A', LancamentoPagar.ValorAPagar / EditQuantidadeParcelas.AsInteger, Constantes.TConstantes.DECIMAIS_VALOR);

          LancamentoPagar.ListaParcelaPagarVO.Add(ParcelaPagar);
        end;
        TFinLancamentoPagarController.Insere(LancamentoPagar);
      end;

    except
      Result := False;
    end;
  end;
  DecimalSeparator := ',';
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFCompraPedido.EditIdFornecedorExit(Sender: TObject);
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

procedure TFCompraPedido.EditIdFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdFornecedor.Value := -1;
    EditIdCompraTipoPedido.SetFocus;
  end;
end;

procedure TFCompraPedido.EditIdFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdCompraTipoPedido.SetFocus;
  end;
end;

procedure TFCompraPedido.EditIdCompraTipoPedidoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdCompraTipoPedido.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdCompraTipoPedido.Text;
      EditIdCompraTipoPedido.Clear;
      EditCompraTipoPedido.Clear;
      if not PopulaCamposTransientes(Filtro, TCompraTipoPedidoVO, TCompraTipoPedidoController) then
        PopulaCamposTransientesLookup(TCompraTipoPedidoVO, TCompraTipoPedidoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdCompraTipoPedido.Text := CDSTransiente.FieldByName('ID').AsString;
        EditCompraTipoPedido.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdCompraTipoPedido.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCompraTipoPedido.Clear;
  end;
end;

procedure TFCompraPedido.EditIdCompraTipoPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdCompraTipoPedido.Value := -1;
    EditDataPedido.SetFocus;
  end;
end;

procedure TFCompraPedido.EditIdCompraTipoPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDataPedido.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFCompraPedido.CDSCompraPedidoDetalheAfterEdit(DataSet: TDataSet);
begin
  CDSCompraPedidoDetalhePERSISTE.AsString := 'S';
end;

procedure TFCompraPedido.CDSCompraPedidoDetalheBeforePost(DataSet: TDataSet);
begin
  CDSCompraPedidoDetalheVALOR_SUBTOTAL.AsExtended := CDSCompraPedidoDetalheQUANTIDADE.AsExtended * CDSCompraPedidoDetalheVALOR_UNITARIO.AsExtended;
  CDSCompraPedidoDetalheVALOR_DESCONTO.AsExtended := CDSCompraPedidoDetalheVALOR_SUBTOTAL.AsExtended * (CDSCompraPedidoDetalheTAXA_DESCONTO.AsExtended / 100);
  CDSCompraPedidoDetalheVALOR_ICMS.AsExtended := CDSCompraPedidoDetalheBASE_CALCULO_ICMS.AsExtended * (CDSCompraPedidoDetalheALIQUOTA_ICMS.AsExtended / 100);
  CDSCompraPedidoDetalheVALOR_IPI.AsExtended := CDSCompraPedidoDetalheVALOR_SUBTOTAL.AsExtended * (CDSCompraPedidoDetalheALIQUOTA_IPI.AsExtended / 100);
  CDSCompraPedidoDetalheVALOR_TOTAL.AsExtended := CDSCompraPedidoDetalheVALOR_SUBTOTAL.AsExtended - CDSCompraPedidoDetalheVALOR_DESCONTO.AsExtended + CDSCompraPedidoDetalheVALOR_ICMS.AsExtended + CDSCompraPedidoDetalheVALOR_IPI.AsExtended;
end;

procedure TFCompraPedido.GridCompraPedidoDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    try
      PopulaCamposTransientesLookup(TProdutoVO, TProdutoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        CDSCompraPedidoDetalhe.Append;
        CDSCompraPedidoDetalheID_PRODUTO.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
        CDSCompraPedidoDetalheProdutoNome.AsString := CDSTransiente.FieldByName('NOME').AsString;
        CDSCompraPedidoDetalheVALOR_UNITARIO.AsExtended := CDSTransiente.FieldByName('VALOR_VENDA').AsExtended;
      end;
    finally
      CDSTransiente.Close;
    end;
  end;
  If Key = VK_RETURN then
    EditIdFornecedor.SetFocus;
end;

procedure TFCompraPedido.GridCompraPedidoDetalheUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    Fields := Copy(Fields, 1, Length(Fields) - 1);
    DescFields := Copy(DescFields, 1, Length(DescFields) - 1);

    IxDName := IntToStr(Length(FieldsToSort)) + '_' + FormatDateTime('hhmmssz', Now);
    CDSCompraPedidoDetalhe.AddIndex(IxDName, Fields, [], DescFields);
    CDSCompraPedidoDetalhe.IndexDefs.Update;
    CDSCompraPedidoDetalhe.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFCompraPedido.GridParaEdits;
var
  CompraPedidoDetEnumerator: TEnumerator<TCompraPedidoDetalheVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TCompraPedidoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TCompraPedidoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin

    EditIdCompraTipoPedido.AsInteger := TCompraPedidoVO(ObjetoVO).IdCompraTipoPedido;
    EditCompraTipoPedido.Text := TCompraPedidoVO(ObjetoVO).CompraTipoPedidoNome;
    EditIdFornecedor.AsInteger := TCompraPedidoVO(ObjetoVO).IdFornecedor;
    EditFornecedor.Text := TCompraPedidoVO(ObjetoVO).FornecedorPessoaNome;
    EditDataPedido.Date := TCompraPedidoVO(ObjetoVO).DataPedido;
    EditDataPrevistaEntrega.Date := TCompraPedidoVO(ObjetoVO).DataPrevistaEntrega;
    EditDataPrevisaoPagamento.Date := TCompraPedidoVO(ObjetoVO).DataPrevisaoPagamento;
    EditLocalEntrega.Text := TCompraPedidoVO(ObjetoVO).LocalEntrega;
    EditLocalCobranca.Text := TCompraPedidoVO(ObjetoVO).LocalCobranca;
    EditContato.Text := TCompraPedidoVO(ObjetoVO).Contato;

    case AnsiIndexStr(TCompraPedidoVO(ObjetoVO).TipoFrete, ['0', '1', '2']) of
      0:
        ComboBoxFormaPagamento.ItemIndex := 0;
      1:
        ComboBoxFormaPagamento.ItemIndex := 1;
      2:
        ComboBoxFormaPagamento.ItemIndex := 2;
    else
      ComboBoxTipoFrete.ItemIndex := -1;
    end;

    case AnsiIndexStr(TCompraPedidoVO(ObjetoVO).TipoFrete, ['C', 'F']) of
      0:
        ComboBoxTipoFrete.ItemIndex := 0;
      1:
        ComboBoxTipoFrete.ItemIndex := 1;
    else
      ComboBoxTipoFrete.ItemIndex := -1;
    end;

    EditQuantidadeParcelas.AsInteger := TCompraPedidoVO(ObjetoVO).QuantidadeParcelas;
    EditDiasPrimeiroVencimento.AsInteger := TCompraPedidoVO(ObjetoVO).DiasPrimeiroVencimento;
    EditDiasIntervalo.AsInteger := TCompraPedidoVO(ObjetoVO).DiasIntervalo;
    EditValorSubtotal.Value := TCompraPedidoVO(ObjetoVO).ValorSubtotal;
    EditTaxaDesconto.Value := TCompraPedidoVO(ObjetoVO).TaxaDesconto;
    EditValorDesconto.Value := TCompraPedidoVO(ObjetoVO).ValorDesconto;
    EditValorTotalPedido.Value := TCompraPedidoVO(ObjetoVO).ValorTotalPedido;
    EditBaseCalculoICMS.Value := TCompraPedidoVO(ObjetoVO).BaseCalculoIcms;
    EditValorICMS.Value := TCompraPedidoVO(ObjetoVO).ValorIcms;
    EditBaseCalculoIcmsSt.Value := TCompraPedidoVO(ObjetoVO).BaseCalculoIcmsSt;
    EditValorIcmsSt.Value := TCompraPedidoVO(ObjetoVO).ValorIcmsSt;
    EditValorTotalProdutos.Value := TCompraPedidoVO(ObjetoVO).ValorTotalProdutos;
    EditValorFrete.Value := TCompraPedidoVO(ObjetoVO).ValorFrete;
    EditValorSeguro.Value := TCompraPedidoVO(ObjetoVO).ValorSeguro;
    EditValorOutrasDespesas.Value := TCompraPedidoVO(ObjetoVO).ValorOutrasDespesas;
    EditValorIPI.Value := TCompraPedidoVO(ObjetoVO).ValorIpi;
    EditValorTotalNF.Value := TCompraPedidoVO(ObjetoVO).ValorTotalNf;

    // Itens do Pedido de Compra
    CompraPedidoDetEnumerator := TCompraPedidoVO(ObjetoVO).ListaCompraPedidoDetalheVO.GetEnumerator;
    try
      with CompraPedidoDetEnumerator do
      begin
        while MoveNext do
        begin
          CDSCompraPedidoDetalhe.Append;

          CDSCompraPedidoDetalheID.AsInteger := Current.Id;
          CDSCompraPedidoDetalheID_COMPRA_PEDIDO.AsInteger := Current.IdCompraPedido;
          CDSCompraPedidoDetalheID_PRODUTO.AsInteger := Current.IdProduto;
          CDSCompraPedidoDetalhePRODUTONOME.AsString := Current.ProdutoVO.Nome;
          CDSCompraPedidoDetalheQUANTIDADE.AsExtended := Current.Quantidade;
          CDSCompraPedidoDetalheVALOR_UNITARIO.AsExtended := Current.ValorUnitario;
          CDSCompraPedidoDetalheVALOR_SUBTOTAL.AsExtended := Current.ValorSubtotal;
          CDSCompraPedidoDetalheTAXA_DESCONTO.AsExtended := Current.TaxaDesconto;
          CDSCompraPedidoDetalheVALOR_DESCONTO.AsExtended := Current.ValorDesconto;
          CDSCompraPedidoDetalheVALOR_TOTAL.AsExtended := Current.ValorTotal;
          CDSCompraPedidoDetalheCST_CSOSN.AsString := Current.CstCsosn;
          CDSCompraPedidoDetalheCFOP.AsInteger := Current.Cfop;
          CDSCompraPedidoDetalheBASE_CALCULO_ICMS.AsExtended := Current.BaseCalculoIcms;
          CDSCompraPedidoDetalheVALOR_ICMS.AsExtended := Current.ValorIcms;
          CDSCompraPedidoDetalheVALOR_IPI.AsExtended := Current.ValorIpi;
          CDSCompraPedidoDetalheALIQUOTA_ICMS.AsExtended := Current.AliquotaIcms;
          CDSCompraPedidoDetalheALIQUOTA_IPI.AsExtended := Current.AliquotaIpi;

          CDSCompraPedidoDetalhe.Post;
        end;
      end;
    finally
      CompraPedidoDetEnumerator.Free;
    end;
    TCompraPedidoVO(ObjetoVO).ListaCompraPedidoDetalheVO := Nil;
    if Assigned(TCompraPedidoVO(ObjetoOldVO)) then
      TCompraPedidoVO(ObjetoOldVO).ListaCompraPedidoDetalheVO := Nil;
  end;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFCompraPedido.ActionAtualizarValoresExecute(Sender: TObject);
begin
  AtualizaTotaisItens(False);
end;

procedure TFCompraPedido.AtualizaTotaisItens(pEditarValores: Boolean);
var
  SubTotal, TotalDesconto, TotalGeral, TotalBaseCalculoIcms, TotalIcms, TotalIpi: Extended;
begin
  SubTotal := 0;
  TotalDesconto := 0;
  TotalGeral := 0;
  TotalBaseCalculoIcms := 0;
  TotalIcms := 0;
  TotalIpi := 0;
  //
  CDSCompraPedidoDetalhe.DisableControls;
  CDSCompraPedidoDetalhe.First;
  while not CDSCompraPedidoDetalhe.Eof do
  begin
    if pEditarValores then
    begin
      CDSCompraPedidoDetalhe.Edit;
      CDSCompraPedidoDetalheVALOR_SUBTOTAL.AsExtended := CDSCompraPedidoDetalheQUANTIDADE.AsExtended * CDSCompraPedidoDetalheVALOR_UNITARIO.AsExtended;
      CDSCompraPedidoDetalheVALOR_DESCONTO.AsExtended := CDSCompraPedidoDetalheVALOR_SUBTOTAL.AsExtended * (CDSCompraPedidoDetalheTAXA_DESCONTO.AsExtended / 100);
      CDSCompraPedidoDetalheVALOR_TOTAL.AsExtended := CDSCompraPedidoDetalheVALOR_SUBTOTAL.AsExtended - CDSCompraPedidoDetalheVALOR_DESCONTO.AsExtended;
      CDSCompraPedidoDetalheBASE_CALCULO_ICMS.AsExtended := CDSCompraPedidoDetalheVALOR_TOTAL.AsExtended;
      CDSCompraPedidoDetalheVALOR_ICMS.AsExtended := CDSCompraPedidoDetalheBASE_CALCULO_ICMS.AsExtended * (CDSCompraPedidoDetalheALIQUOTA_ICMS.AsExtended / 100);
      CDSCompraPedidoDetalheVALOR_IPI.AsExtended := CDSCompraPedidoDetalheVALOR_TOTAL.AsExtended * (CDSCompraPedidoDetalheALIQUOTA_IPI.AsExtended / 100);
      CDSCompraPedidoDetalhe.Post;
    end;
    SubTotal := SubTotal + CDSCompraPedidoDetalheVALOR_SUBTOTAL.AsExtended;
    TotalDesconto := TotalDesconto + CDSCompraPedidoDetalheVALOR_DESCONTO.AsExtended;
    TotalGeral := TotalGeral + CDSCompraPedidoDetalheVALOR_TOTAL.AsExtended;
    TotalBaseCalculoIcms := TotalBaseCalculoIcms + CDSCompraPedidoDetalheBASE_CALCULO_ICMS.AsExtended;
    TotalIcms := TotalIcms + CDSCompraPedidoDetalheVALOR_ICMS.AsExtended;
    TotalIpi := TotalIpi + CDSCompraPedidoDetalheVALOR_IPI.AsExtended;
    //
    CDSCompraPedidoDetalhe.Next;
  end;
  CDSCompraPedidoDetalhe.First;
  CDSCompraPedidoDetalhe.EnableControls;
  //
  EditValorSubtotal.Value := SubTotal;
  EditValorDesconto.Value := TotalDesconto;
  EditValorTotalPedido.Value := TotalGeral;
  EditBaseCalculoICMS.Value := TotalBaseCalculoIcms;
  EditValorICMS.Value := TotalIcms;
  EditValorTotalProdutos.Value := TotalGeral;
  EditValorIPI.Value := TotalIpi;
  EditValorTotalNF.Value := TotalGeral + TotalIcms;
end;
{$ENDREGION}

end.
