{*******************************************************************************
Title: T2Ti ERP
Description: Janela de Pedidos de compras para o módulo Gestão de Compras

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
unit UPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Mask,
  JvExMask, JvToolEdit, Generics.Collections, JvPageList;

type
  TFPedidoCompra = class(TForm)
    ActionManager: TActionManager;
    ActionInserir: TAction;
    ActionAlterar: TAction;
    ActionExcluir: TAction;
    ActionFiltroRapido: TAction;
    PanelToolBar: TPanel;
    ActionToolBarGrid: TActionToolBar;
    ActionCancelar: TAction;
    ActionSalvar: TAction;
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
    GridPedidoDetalhe: TJvDBUltimGrid;
    ScrollBox1: TScrollBox;
    Label6: TLabel;
    EditIdFuncionario: TJvValidateEdit;
    EditNomeFuncionario: TLabeledEdit;
    EditIdFornecedor: TJvValidateEdit;
    EditNomeFornecedor: TLabeledEdit;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    EditDataPedido: TJvDateEdit;
    EditContato: TLabeledEdit;
    EditDataPrevistaEntrega: TJvDateEdit;
    Label4: TLabel;
    Label5: TLabel;
    EditDataPrevisaoPagamento: TJvDateEdit;
    EditLocalEntrega: TLabeledEdit;
    EditLocalCobranca: TLabeledEdit;
    EditValorSubTotal: TJvValidateEdit;
    Label7: TLabel;
    EditTaxaDesconto: TJvValidateEdit;
    Label8: TLabel;
    EditValorDesconto: TJvValidateEdit;
    Label9: TLabel;
    EditTotalPedido: TJvValidateEdit;
    Label10: TLabel;
    RadioGroupTipoFrete: TRadioGroup;
    RadioGroupFormaPagamento: TRadioGroup;
    procedure ActionInserirExecute(Sender: TObject);
    procedure ActionAlterarExecute(Sender: TObject);
    procedure ActionExcluirExecute(Sender: TObject);
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionSalvarExecute(Sender: TObject);
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
    procedure EditIdFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridPedidoDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPedidoCompra: TFPedidoCompra;

implementation

uses
  PedidoCompraVO, PedidoCompraController, UDataModule, UFiltro, Constantes,
  Biblioteca, PedidoCompraDetalheVO, ULookup, PedidoCompraDetalheController,
  PessoaVO, PessoaController, ProdutoVO, ProdutoController, UMenu;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFPedidoCompra.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFPedidoCompra.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFPedidoCompra.FormCreate(Sender: TObject);
begin
  //Grid principal - dos pedidos
  FDataModule.CDSPedidoCompra.Close;
  FDataModule.CDSPedidoCompra.FieldDefs.Clear;
  FDataModule.CDSPedidoCompra.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSPedidoCompra.FieldDefs.add('FORNECEDOR', ftString, 100);
  FDataModule.CDSPedidoCompra.FieldDefs.add('DATA_PEDIDO', ftString, 10);
  FDataModule.CDSPedidoCompra.FieldDefs.add('DATA_PREVISTA_ENTREGA', ftString, 10);
  FDataModule.CDSPedidoCompra.FieldDefs.add('DATA_PREVISAO_PAGAMENTO', ftString, 10);
  FDataModule.CDSPedidoCompra.FieldDefs.add('LOCAL_ENTREGA', ftString, 100);
  FDataModule.CDSPedidoCompra.FieldDefs.add('LOCAL_COBRANCA', ftString, 100);
  FDataModule.CDSPedidoCompra.FieldDefs.add('CONTATO', ftString, 30);
  FDataModule.CDSPedidoCompra.FieldDefs.add('VALOR_SUBTOTAL', ftFloat);
  FDataModule.CDSPedidoCompra.FieldDefs.add('TAXA_DESCONTO', ftFloat);
  FDataModule.CDSPedidoCompra.FieldDefs.add('VALOR_DESCONTO', ftFloat);
  FDataModule.CDSPedidoCompra.FieldDefs.add('VALOR_TOTAL_PEDIDO', ftFloat);
  FDataModule.CDSPedidoCompra.FieldDefs.add('TIPO_FRETE', ftString, 1);
  FDataModule.CDSPedidoCompra.FieldDefs.add('FORMA_PAGAMENTO', ftString, 1);
  FDataModule.CDSPedidoCompra.FieldDefs.add('ID_PESSOA', ftInteger);
  FDataModule.CDSPedidoCompra.FieldDefs.add('ID_COLABORADOR', ftInteger);
  FDataModule.CDSPedidoCompra.CreateDataSet;
  TFloatField(FDataModule.CDSPedidoCompra.FieldByName('VALOR_SUBTOTAL')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSPedidoCompra.FieldByName('TAXA_DESCONTO')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSPedidoCompra.FieldByName('VALOR_DESCONTO')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSPedidoCompra.FieldByName('VALOR_TOTAL_PEDIDO')).displayFormat := '#,###,###,##0.00';

  {Implementar a digitação e cálculo dos impostos no cabeçalho
  BASE_CALCULO_ICMS        decimal(20,6)
  VALOR_ICMS               decimal(20,6)
  BASE_CALCULO_ICMS_ST     decimal(20,6)
  VALOR_ICMS_ST            decimal(20,6)
  VALOR_TOTAL_PRODUTOS     decimal(20,6)
  VALOR_FRETE              decimal(20,6)
  VALOR_SEGURO             decimal(20,6)
  VALOR_OUTRAS_DESPESAS    decimal(20,6)
  VALOR_IPI                decimal(20,6)
  VALOR_TOTAL_NF           decimal(20,6)
  }

  // Definição dos títulos dos cabeçalhos e largura das colunas
  Grid.Columns[0].Title.Caption := 'Id';
  Grid.Columns[1].Title.Caption := 'Fornecedor';
  Grid.Columns[2].Title.Caption := 'Data Pedido';
  Grid.Columns[3].Title.Caption := 'Data Prevista Entrega';
  Grid.Columns[4].Title.Caption := 'Data Previsão Pagamento';
  Grid.Columns[5].Title.Caption := 'Local Entrega';
  Grid.Columns[6].Title.Caption := 'Local Cobrança';
  Grid.Columns[7].Title.Caption := 'Contato';
  Grid.Columns[8].Title.Caption := 'Valor SubTotal';
  Grid.Columns[9].Title.Caption := 'Taxa Desconto';
  Grid.Columns[10].Title.Caption := 'Valor Desconto';
  Grid.Columns[11].Title.Caption := 'Total Pedido';
  Grid.Columns[12].Title.Caption := 'Tipo Frete';
  Grid.Columns[13].Title.Caption := 'Forma Pagamento';
  Grid.Columns[14].Visible := False;
  Grid.Columns[15].Visible := False;
  //
  //
  //Grid secundária - dos itens do pedido
  FDataModule.CDSPedidoCompraDetalhe.Close;
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.Clear;
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('ID_PRODUTO', ftInteger);
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('NOME', ftString, 100);
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('QUANTIDADE', ftFloat);
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('VALOR_UNITARIO', ftFloat);
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('VALOR_SUBTOTAL', ftFloat);
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('TAXA_DESCONTO', ftFloat);
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('VALOR_DESCONTO', ftFloat);
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('VALOR_TOTAL', ftFloat);
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('ID_PEDIDO_COMPRA', ftInteger);
  FDataModule.CDSPedidoCompraDetalhe.FieldDefs.add('PERSISTE', ftString, 1);
  FDataModule.CDSPedidoCompraDetalhe.CreateDataSet;
  TFloatField(FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_UNITARIO')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_SUBTOTAL')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSPedidoCompraDetalhe.FieldByName('TAXA_DESCONTO')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_DESCONTO')).displayFormat := '#,###,###,##0.00';
  TFloatField(FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_TOTAL')).displayFormat := '#,###,###,##0.00';

  {Implementar a digitação e cálculo dos impostos nos detalhes
  CST_CSOSN          char(4)
  CFOP               int(10)
  BASE_CALCULO_ICMS  decimal(20,6)
  VALOR_ICMS         decimal(20,6)
  VALOR_IPI          decimal(20,6)
  ALIQUOTA_ICMS      decimal(20,6)
  ALIQUOTA_IPI       decimal(20,6)
  }

  //Definição dos títulos dos cabeçalhos e largura das colunas
  GridPedidoDetalhe.Columns[0].Title.Caption := 'Id Produto';
  GridPedidoDetalhe.Columns[1].Title.Caption := 'Nome';
  GridPedidoDetalhe.Columns[2].Title.Caption := 'Quantidade';
  GridPedidoDetalhe.Columns[3].Title.Caption := 'Valor Unitário';
  GridPedidoDetalhe.Columns[4].Title.Caption := 'Valor Subtotal';
  GridPedidoDetalhe.Columns[5].Title.Caption := 'Taxa Desconto';
  GridPedidoDetalhe.Columns[6].Title.Caption := 'Valor Desconto';
  GridPedidoDetalhe.Columns[7].Title.Caption := 'Total';
  //Colunas nao visiveis
  GridPedidoDetalhe.Columns.Items[8].Visible := False;
  GridPedidoDetalhe.Columns.Items[9].Visible := False;
  GridPedidoDetalhe.Columns.Items[10].Visible := False;
  //
  Pagina := 0;
  VerificarPaginacao;
  //
  FDataModule.CDSPedidoCompra.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
end;

procedure TFPedidoCompra.ActionInserirExecute(Sender: TObject);
begin
  PanelEdits.BringToFront;
  EditIdFuncionario.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
end;

procedure TFPedidoCompra.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSPedidoCompra.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    EditIdFuncionario.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
    //Carrega itens
    FiltroLocal := 'ID_PEDIDO_COMPRA = '+ FDataModule.CDSPedidoCompra.FieldByName('ID').AsString;
    TPedidoCompraDetalheController.Consulta(trim(FiltroLocal), 0);
  end;
end;

procedure TFPedidoCompra.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSPedidoCompra.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TPedidoCompraController.Exclui(FDataModule.CDSPedidoCompra.FieldByName('ID').AsInteger);
      TPedidoCompraController.Consulta(Filtro, Pagina);
    end;
  end;
end;

procedure TFPedidoCompra.ActionSairExecute(Sender: TObject);
begin
FechaFormulario;
end;

procedure TFPedidoCompra.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  PedidoCompra : TPedidoCompraVO;
  PedidoCompraDetalhe: TPedidoCompraDetalheVO;
  ListaCompraDetalhe: TObjectList<TPedidoCompraDetalheVO>;
begin
  PedidoCompra := TPedidoCompraVO.Create;
  PedidoCompra.IdColaborador := EditIdFuncionario.AsInteger;
  PedidoCompra.IdPessoa := EditIdFornecedor.AsInteger;
  PedidoCompra.DataPedido := FormatDateTime('yyyy-mm-dd', EditDataPedido.Date);
  PedidoCompra.DataPrevistaEntrega := FormatDateTime('yyyy-mm-dd', EditDataPrevistaEntrega.Date);
  PedidoCompra.DataPrevisaoPagamento := FormatDateTime('yyyy-mm-dd', EditDataPrevisaoPagamento.Date);
  PedidoCompra.Contato := EditContato.Text;
  PedidoCompra.LocalEntrega := EditLocalEntrega.Text;
  PedidoCompra.LocalCobranca := EditLocalCobranca.Text;
  PedidoCompra.ValorSubtotal := EditValorSubTotal.AsFloat;
  PedidoCompra.TaxaDesconto := EditTaxaDesconto.AsFloat;
  PedidoCompra.ValorDesconto := EditValorDesconto.AsFloat;
  PedidoCompra.ValorTotalPedido := EditTotalPedido.AsFloat;

  if RadioGroupTipoFrete.ItemIndex = 0 then
    PedidoCompra.TipoFrete := 'C'
  else if RadioGroupTipoFrete.ItemIndex = 1 then
    PedidoCompra.TipoFrete := 'F';

  PedidoCompra.FormaPagamento := IntToStr(RadioGroupTipoFrete.ItemIndex);

  //popula a lista com os itens do pedido
  ListaCompraDetalhe := TObjectList<TPedidoCompraDetalheVO>.Create(True);
  FDataModule.CDSPedidoCompraDetalhe.First;
  while not FDataModule.CDSPedidoCompraDetalhe.Eof do
  begin
    if FDataModule.CDSPedidoCompraDetalhe.FieldByName('PERSISTE').AsString = 'S' then
    begin
      PedidoCompraDetalhe := TPedidoCompraDetalheVO.Create;
      PedidoCompraDetalhe.Id := FDataModule.CDSPedidoCompraDetalhe.FieldByName('ID').AsInteger;
      PedidoCompraDetalhe.IdPedidoCompra := FDataModule.CDSPedidoCompraDetalhe.FieldByName('ID_PEDIDO_COMPRA').AsInteger;
      PedidoCompraDetalhe.IdProduto := FDataModule.CDSPedidoCompraDetalhe.FieldByName('ID_PRODUTO').AsInteger;
      PedidoCompraDetalhe.Quantidade := FDataModule.CDSPedidoCompraDetalhe.FieldByName('QUANTIDADE').AsInteger;
      PedidoCompraDetalhe.ValorUnitario := FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_UNITARIO').AsFloat;
      PedidoCompraDetalhe.ValorSubtotal := FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_SUBTOTAL').AsFloat;
      PedidoCompraDetalhe.TaxaDesconto := FDataModule.CDSPedidoCompraDetalhe.FieldByName('TAXA_DESCONTO').AsFloat;
      PedidoCompraDetalhe.ValorDesconto := FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_DESCONTO').AsFloat;
      PedidoCompraDetalhe.ValorTotal := FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_TOTAL').AsFloat;
      ListaCompraDetalhe.Add(PedidoCompraDetalhe);
    end;
    FDataModule.CDSPedidoCompraDetalhe.Next;
  end;

  if Operacao = 1 then
    TPedidoCompraController.Insere(PedidoCompra, ListaCompraDetalhe)
  else if Operacao = 2 then
  begin
  	PedidoCompra.ID := FDataModule.CDSPedidoCompra.FieldByName('ID').AsInteger;
    LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
    TPedidoCompraController.Altera(PedidoCompra, ListaCompraDetalhe, Filtro, Pagina);
    Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
    Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
  end;

  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  Grid.SetFocus;
end;

procedure TFPedidoCompra.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFPedidoCompra.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  EditIdFuncionario.SetFocus;
  ActionToolBarGrid.Enabled := False;
  GridParaEdits;
  ActionSalvar.Enabled := False;
  Operacao := 3;
  //Carrega itens
  FiltroLocal := 'ID_PEDIDO_COMPRA = '+ FDataModule.CDSPedidoCompra.FieldByName('ID').AsString;
  TPedidoCompraDetalheController.Consulta(trim(FiltroLocal), 0);
end;

procedure TFPedidoCompra.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    Application.MessageBox('Não existe critério para consulta.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TPedidoCompraController.Consulta(trim(Filtro), Pagina);
    VerificarPaginacao;
  end;
end;

procedure TFPedidoCompra.ActionFiltrarExecute(Sender: TObject);
var
  PedidoCompra : TPedidoCompraVO;
  I : Integer;
begin
  Filtro := '';
  PedidoCompra := TPedidoCompraVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSPedidoCompra;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TPedidoCompraController.Consulta(trim(Filtro), Pagina);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFPedidoCompra.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSPedidoCompra.First;
end;

procedure TFPedidoCompra.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSPedidoCompra.Last;
end;

procedure TFPedidoCompra.EditIdFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TPessoaVO.Create;
    ULookup.ObjetoController := TPessoaController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'NOME';
    FLookup.ShowModal;
    EditIdFornecedor.Text := ULookup.CampoRetorno1;
    EditNomeFornecedor.Text := ULookup.CampoRetorno2;
    EditIdFornecedor.SetFocus;
  end;
end;

procedure TFPedidoCompra.GridPedidoDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TProdutoVO.Create;
    ULookup.ObjetoController := TProdutoController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'NOME';
    FLookup.ShowModal;

    FDataModule.CDSPedidoCompraDetalhe.Append;
    FDataModule.CDSPedidoCompraDetalhe.Fields[0].AsString := ULookup.CampoRetorno1;
    FDataModule.CDSPedidoCompraDetalhe.Fields[1].AsString := ULookup.CampoRetorno2;
    FDataModule.CDSPedidoCompraDetalhe.Fields[10].AsString := 'S';

    GridPedidoDetalhe.SetFocus;
  end;
end;

procedure TFPedidoCompra.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSPedidoCompra.Prior;
end;

procedure TFPedidoCompra.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSPedidoCompra.Next;
end;

procedure TFPedidoCompra.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TPedidoCompraController.Consulta(trim(Filtro), Pagina);
  VerificarPaginacao;
end;

procedure TFPedidoCompra.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TPedidoCompraController.Consulta(trim(Filtro), Pagina);
  VerificarPaginacao;
end;

procedure TFPedidoCompra.GridParaEdits;
begin
  EditIdFuncionario.Text := FDataModule.CDSPedidoCompra.FieldByName('ID_COLABORADOR').AsString;
  EditIdFornecedor.Text := FDataModule.CDSPedidoCompra.FieldByName('ID_PESSOA').AsString;
  EditNomeFornecedor.Text := FDataModule.CDSPedidoCompra.FieldByName('FORNECEDOR').AsString;

  EditDataPedido.Text := Copy(FDataModule.CDSPedidoCompra.FieldByName('DATA_PEDIDO').AsString,9,2) + '/' +
                         Copy(FDataModule.CDSPedidoCompra.FieldByName('DATA_PEDIDO').AsString,6,2) + '/' +
                         Copy(FDataModule.CDSPedidoCompra.FieldByName('DATA_PEDIDO').AsString,1,4);

  EditDataPrevistaEntrega.Text := Copy(FDataModule.CDSPedidoCompra.FieldByName('DATA_PREVISTA_ENTREGA').AsString,9,2) + '/' +
                                  Copy(FDataModule.CDSPedidoCompra.FieldByName('DATA_PREVISTA_ENTREGA').AsString,6,2) + '/' +
                                  Copy(FDataModule.CDSPedidoCompra.FieldByName('DATA_PREVISTA_ENTREGA').AsString,1,4);

  EditDataPrevisaoPagamento.Text := Copy(FDataModule.CDSPedidoCompra.FieldByName('DATA_PREVISAO_PAGAMENTO').AsString,9,2) + '/' +
                                    Copy(FDataModule.CDSPedidoCompra.FieldByName('DATA_PREVISAO_PAGAMENTO').AsString,6,2) + '/' +
                                    Copy(FDataModule.CDSPedidoCompra.FieldByName('DATA_PREVISAO_PAGAMENTO').AsString,1,4);

  EditContato.Text := FDataModule.CDSPedidoCompra.FieldByName('CONTATO').AsString;
  EditLocalEntrega.Text := FDataModule.CDSPedidoCompra.FieldByName('LOCAL_ENTREGA').AsString;
  EditLocalCobranca.Text := FDataModule.CDSPedidoCompra.FieldByName('LOCAL_COBRANCA').AsString;
  EditValorSubTotal.Text := FDataModule.CDSPedidoCompra.FieldByName('VALOR_SUBTOTAL').AsString;
  EditTaxaDesconto.Text := FDataModule.CDSPedidoCompra.FieldByName('TAXA_DESCONTO').AsString;
  EditValorDesconto.Text := FDataModule.CDSPedidoCompra.FieldByName('VALOR_DESCONTO').AsString;
  EditTotalPedido.Text := FDataModule.CDSPedidoCompra.FieldByName('VALOR_TOTAL_PEDIDO').AsString;
  if FDataModule.CDSPedidoCompra.FieldByName('TIPO_FRETE').AsString = 'C' then
    RadioGroupTipoFrete.ItemIndex := 0
  else
    RadioGroupTipoFrete.ItemIndex := 1;
  if FDataModule.CDSPedidoCompra.FieldByName('FORMA_PAGAMENTO').AsString = '0' then
    RadioGroupFormaPagamento.ItemIndex := 0
  else if FDataModule.CDSPedidoCompra.FieldByName('FORMA_PAGAMENTO').AsString = '1' then
    RadioGroupFormaPagamento.ItemIndex := 1
  else if FDataModule.CDSPedidoCompra.FieldByName('FORMA_PAGAMENTO').AsString = '2' then
    RadioGroupFormaPagamento.ItemIndex := 2;
end;

procedure TFPedidoCompra.LimparCampos;
begin
  EditIdFuncionario.Clear;
  EditNomeFuncionario.Clear;
  EditIdFornecedor.Clear;
  EditNomeFornecedor.Clear;
  EditDataPedido.Clear;
  EditDataPrevistaEntrega.Clear;
  EditDataPrevisaoPagamento.Clear;
  EditContato.Clear;
  EditLocalEntrega.Clear;
  EditLocalCobranca.Clear;
  EditValorSubTotal.Clear;
  EditTaxaDesconto.Clear;
  EditValorDesconto.Clear;
  EditTotalPedido.Clear;
  RadioGroupTipoFrete.ItemIndex := 0;
  RadioGroupFormaPagamento.ItemIndex := 0;
  FDataModule.CDSPedidoCompraDetalhe.EmptyDataSet;
end;

procedure TFPedidoCompra.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSPedidoCompra.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFPedidoCompra.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    FDataModule.CDSPedidoCompra.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSPedidoCompra.IndexDefs.Update;
    FDataModule.CDSPedidoCompra.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFPedidoCompra.ActionExportarCSVExecute(Sender: TObject);
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

procedure TFPedidoCompra.ActionExportarExcelExecute(Sender: TObject);
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

procedure TFPedidoCompra.ActionExportarHTMLExecute(Sender: TObject);
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

procedure TFPedidoCompra.ActionExportarWordExecute(Sender: TObject);
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

procedure TFPedidoCompra.ActionExportarXMLExecute(Sender: TObject);
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

procedure TFPedidoCompra.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFPedidoCompra.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
