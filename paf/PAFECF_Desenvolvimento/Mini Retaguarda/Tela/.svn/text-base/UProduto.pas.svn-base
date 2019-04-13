unit UProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid,ImpostoIcmsVO,ImpostoIcmsController, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Mask,
  JvExMask, JvToolEdit, DBCtrls, JvPageList, Rtti, TypInfo, JvBaseEdits;

type
  TFProduto = class(TForm)
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
    Panel1: TPanel;
    EditNome: TLabeledEdit;
    EditGtin: TLabeledEdit;
    EditNCM: TLabeledEdit;
    Label9: TLabel;
    MeDescricao: TMemo;
    edtUnidadeMedida: TDBLookupComboBox;
    Label4: TLabel;
    EditCodigoBalanca: TJvCalcEdit;
    editCodigoInterno: TEdit;
    EditDescricaoPDV: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    GpBoxEst: TGroupBox;
    EditEstoqueMinimo: TJvCalcEdit;
    Label3: TLabel;
    EditEstoqueMaximo: TJvCalcEdit;
    Label6: TLabel;
    EditQtde_estoque: TJvCalcEdit;
    Label5: TLabel;
    GpBoxMov: TGroupBox;
    editValorUnNF: TJvCalcEdit;
    Label13: TLabel;
    Label19: TLabel;
    EditNumNF: TEdit;
    Label20: TLabel;
    EditFornecedor: TEdit;
    Label21: TLabel;
    Label16: TLabel;
    Label22: TLabel;
    EditCNPJ: TEdit;
    Label23: TLabel;
    editDataAlteracao: TJvDateEdit;
    EditDataNF: TJvDateEdit;
    EditValidade: TJvCalcEdit;
    Label24: TLabel;
    GpBoxPrecificacao: TGroupBox;
    EditPerComissao: TJvCalcEdit;
    Label29: TLabel;
    EditPerDesconto: TJvCalcEdit;
    Label28: TLabel;
    EditValor_venda: TJvCalcEdit;
    Label2: TLabel;
    Label27: TLabel;
    EditPrecoCusto: TJvCalcEdit;
    Label26: TLabel;
    EditCustoMedio: TJvCalcEdit;
    Label25: TLabel;
    GpBoxInfo: TGroupBox;
    EditIDImposto: TJvCalcEdit;
    edtImpostoICMS: TDBLookupComboBox;
    Label12: TLabel;
    EditECF_ICMS_ST: TEdit;
    editPAF_P_ST: TEdit;
    editTAXA_ICMS: TJvCalcEdit;
    Label11: TLabel;
    Label10: TLabel;
    Label7: TLabel;
    EditIAT: TLabeledEdit;
    EditIPPT: TLabeledEdit;
    cmbCSTOrigem: TComboBox;
    cmbCSTTratamentoTrubutario: TComboBox;
    EditDataEstoque: TJvDateEdit;
    Label8: TLabel;
    cmbItemSped: TComboBox;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    EditUnidadeCompra: TEdit;
    EditPercLucroBruto: TJvCalcEdit;
    Label17: TLabel;
    GroupBox1: TGroupBox;
    btnTotal: TSpeedButton;
    btnParcial: TSpeedButton;
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
    procedure ActionSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FechaFormulario;
    procedure ConfiguraGrid;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtImpostoICMSEnter(Sender: TObject);
    procedure edtImpostoICMSKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtImpostoICMSCloseUp(Sender: TObject);
    procedure EditNomeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIDImpostoKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure EditValor_vendaChange(Sender: TObject);
    procedure EditPrecoCustoExit(Sender: TObject);
    procedure EditPercLucroBrutoExit(Sender: TObject);
    procedure EditNCMKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnTotalClick(Sender: TObject);
    procedure btnParcialClick(Sender: TObject);


  private
    procedure PopulaComboUnidade;
    procedure PopulaComboImpostoICMS;
    procedure PopulaEditsImpostoICMS;
    procedure VerificaRegistroExistente(Campo,conteudo :string);
    procedure CalculaLucro;


  public

  end;

var
  FProduto: TFProduto;

implementation

uses
  ProdutoVO, ProdutoController, UDataModule, UFiltro, Constantes, NCMVO, NCMController,
  Biblioteca, ULookup, UnidadeProdutoController, UnidadeProdutoVO, UMenu, Atributos,
  ExportaTabelasController;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;
  IDAtual: Integer;
{$R *.dfm}

procedure TFProduto.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFProduto.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFProduto.FormCreate(Sender: TObject);
begin
 // Grid Principal
  ConfiguraGrid;

  Pagina := 0;
  VerificarPaginacao;
  FDataModule.CDSPRODUTO.GetFieldNames(ComboBoxCampos.Items);
  PopulaComboUnidade;
  PopulaComboImpostoICMS;
  ComboBoxCampos.ItemIndex := 0;
  panelgrid.BringToFront;
end;

procedure TFProduto.ActionInserirExecute(Sender: TObject);
begin
  PanelEdits.BringToFront;
  LimparCampos;
  EditGtin.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
end;

procedure TFProduto.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSProduto.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    EditGtin.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
  end;
end;

procedure TFProduto.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSProduto.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TProdutoController.Exclui(FDataModule.CDSProduto.FieldByName('ID').AsInteger);
      TProdutoController.Consulta(Filtro, Pagina, False);
    end;
  end;
end;

procedure TFProduto.ActionSairExecute(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TFProduto.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  Produto : TProdutoVO;
  CSTO, CSTT ,ITEMSped :string;
begin
  if edtUnidadeMedida.KeyValue = Null then
  begin
    Application.MessageBox('Informe a Unidade!','Mensagem do Sistema', MB_OK+MB_ICONINFORMATION);
    edtUnidadeMedida.SetFocus;
    abort;
  end;

  if EditNome.Text = '' then
  begin
    Application.MessageBox('Informe o Nome do produto!','Mensagem do Sistema', MB_OK+MB_ICONINFORMATION);
    edtUnidadeMedida.SetFocus;
    abort;
  end;

  if EditDescricaoPDV.Text = '' then
  begin
    Application.MessageBox('Informe a Descrição do produto que vai ser impresso no cupom fiscal!','Mensagem do Sistema', MB_OK+MB_ICONINFORMATION);
    edtUnidadeMedida.SetFocus;
    abort;
  end;

  if EditIDImposto.AsInteger <= 0 then
  begin
    Application.MessageBox('Informe a Aliquota!','Mensagem do Sistema', MB_OK+MB_ICONINFORMATION);
    edtImpostoICMS.SetFocus;
    Abort;
  end;

  if not mc_DataValida(EditDataEstoque.Text,false) then
  begin
    EditDataEstoque.Date := now;
  end;

  VerificaRegistroExistente('GTIN',EditGtin.Text);
  if EditCodigoBalanca.AsInteger > 0 then
    VerificaRegistroExistente('CODIGO_BALANCA',EditCodigoBalanca.Text);
  if trim(editCodigoInterno.Text)<>'' then
    VerificaRegistroExistente('CODIGO_INTERNO',editCodigoInterno.Text);


  Produto := TProdutoVO.Create;
  Produto.Id                := 0;
  Produto.IdImpostoIcms     := EditIDImposto.AsInteger;
  Produto.IdUnidadeProduto  := edtUnidadeMedida.KeyValue;
  Produto.Gtin              := EditGtin.Text;
  Produto.CodigoInterno     := editCodigoInterno.Text;
  Produto.Nome              := EditNome.Text;
  Produto.Descricao         := MeDescricao.Text;
  Produto.DescricaoPdv      := EditDescricaoPDV.Text;
  Produto.ValorVenda        := EditValor_venda.Value;
  Produto.QtdEstoque        := EditQtde_estoque.Value;
  Produto.EstoqueMin        := EditEstoqueMinimo.Value;
  Produto.EstoqueMax        := EditEstoqueMaximo.Value;
  Produto.Iat               := EditIAT.Text;
  Produto.Ippt              := EditIPPT.Text;
  Produto.Ncm               := EditNCM.Text;
  Produto.DataEstoque       := DataParaTexto(EditDataEstoque.date);

  CSTO := cmbCSTOrigem.Text;
  CSTT := cmbCSTTratamentoTrubutario.Text;
  ITEMSped := cmbItemSped.Text;

  Produto.TipoItemSped      := DevolveConteudoDelimitado(' :',ITEMSped);
  Produto.Cst               := DevolveConteudoDelimitado(' :',CSTO) + DevolveConteudoDelimitado(' :',CSTT);

  Produto.IdCstA            := cmbCSTOrigem.ItemIndex;
  Produto.IdCstB            := cmbCSTTratamentoTrubutario.ItemIndex;
  Produto.IdItemSped        := cmbItemSped.ItemIndex;

  Produto.EcfIcmsSt         := EditECF_ICMS_ST.Text;
  Produto.CodigoBalanca     := EditCodigoBalanca.AsInteger;

  Produto.PafPSt            := editPAF_P_ST.Text;
  Produto.TaxaIcms          := editTAXA_ICMS.Value;
  Produto.DataAlteracao     := DataParaTexto(now);

  Produto.Validade          := EditValidade.AsInteger;
  Produto.CustoMedio        := EditCustoMedio.Value;
  Produto.PrecoCusto        := EditPrecoCusto.Value;

  if not mc_DataValida(EditDataNF.Text) then
    Produto.DataUltimaNF      := '2000-01-01'
  else
    Produto.DataUltimaNF      :=DataParaTexto(EditDataNF.Date);

  Produto.NumeroUltimaNf    := EditNumNF.Text;
  Produto.CnpjUltimo        := EditCNPJ.Text;
  Produto.FornecedorUltimo  := EditFornecedor.Text;
  Produto.ValorUnNF         := editValorUnNF.Value;
  Produto.UnidadeCompra     := editUnidadeCOMPRA.Text;
  Produto.PercentualLucro   := EditPercLucroBruto.Value;
  Produto.PercentualDesconto:= EditPerDesconto.Value;
  Produto.PercentualComissao:= EditPerComissao.Value;



  if Operacao = 1 then
     begin
        TProdutoController.Insere(Produto);
     end
  else if Operacao = 2 then
  begin
  	Produto.ID := IDAtual;
    LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
    TProdutoController.Altera(Produto, Filtro, Pagina);
    Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
    Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
  end;

  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  Pagina := 0;
  Filtro := ' ID =' + IntToStr(Produto.Id);
  TProdutoController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
  Grid.SetFocus;
end;

procedure TFProduto.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFProduto.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  EditGtin.SetFocus;
  ActionToolBarGrid.Enabled := False;
  GridParaEdits;
  ActionSalvar.Enabled := False;
  Operacao := 3;
end;

procedure TFProduto.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    EditCriterioRapido.clear;
    EditCriterioRapido.Text := '*';
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TProdutoController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TProdutoController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end;
end;

procedure TFProduto.ActionFiltrarExecute(Sender: TObject);
var
  Produto : TProdutoVO;
  I : Integer;
begin
  Filtro := '';
  Produto := TProdutoVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSProduto;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TProdutoController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFProduto.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSProduto.First;
end;

procedure TFProduto.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSProduto.Last;
end;

procedure TFProduto.ConfiguraGrid;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  I: Integer;

begin
  try

    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(TProdutoVO);

    //Configura ClientDataset
    FDataModule.CDSProduto.Close;
    FDataModule.CDSProduto.FieldDefs.Clear;
    FDataModule.CDSProduto.IndexDefs.Clear;

    //preenche os nomes dos campos do CDS
    FDataModule.CDSProduto.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
              FDataModule.CDSProduto.FieldDefs.add((Atributo as TColumn).Name, ftString, (Atributo as TColumn).Length)
            else
            if Propriedade.PropertyType.TypeKind in [tkFloat] then
              FDataModule.CDSProduto.FieldDefs.add((Atributo as TColumn).Name, ftFloat)
            else
            if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
              FDataModule.CDSProduto.FieldDefs.add((Atributo as TColumn).Name, ftInteger)
          end;
        end;
      end;
    end;
    FDataModule.CDSProduto.CreateDataSet;

    //Configura a Grid
    I := 1;
    Grid.Columns[0].Title.Caption := 'ID';
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            Grid.Columns[I].Title.Caption := (Atributo as TColumn).Caption;
            Inc(I);
          end;
        end;
      end;
    end;

    FDataModule.CDSProduto.GetFieldNames(ComboBoxCampos.Items);
    ComboBoxCampos.ItemIndex := 1;

    //ComboBoxCampos.SetFocus;
  finally
    Contexto.Free;

  end;
end;

procedure TFProduto.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSProduto.Prior;
end;

procedure TFProduto.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSProduto.Next;
end;

procedure TFProduto.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TProdutoController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFProduto.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TProdutoController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFProduto.GridParaEdits;
var cst:string;
begin
  IDAtual                           := FDataModule.CDSProduto.FieldByName('ID').AsInteger;

  EditIDImposto.Text                := FDataModule.CDSProduto.FieldByName('ID_IMPOSTO_ICMS').AsString;
  edtUnidadeMedida.KeyValue         := FDataModule.CDSProduto.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
  EditGtin.Text                     := FDataModule.CDSProduto.FieldByName('GTIN').AsString;
  EditNome.Text                     := FDataModule.CDSProduto.FieldByName('NOME').AsString;
  EditDescricaoPDV.Text             := FDataModule.CDSProduto.FieldByName('DESCRICAO_PDV').AsString;
  EditValor_venda.Value             := FDataModule.CDSProduto.FieldByName('VALOR_VENDA').AsFloat;
  EditQtde_estoque.Value            := FDataModule.CDSProduto.FieldByName('QTD_ESTOQUE').AsFloat;
  EditEstoqueMinimo.Value           := FDataModule.CDSProduto.FieldByName('ESTOQUE_MIN').AsFloat;
  EditEstoqueMaximo.Value           := FDataModule.CDSProduto.FieldByName('ESTOQUE_MAX').AsFloat;
  EditIAT.Text                      := FDataModule.CDSProduto.FieldByName('IAT').AsString;
  EditIPPT.Text                     := FDataModule.CDSProduto.FieldByName('IPPT').AsString;
  EditNCM.Text                      := FDataModule.CDSProduto.FieldByName('NCM').AsString;
  EditDataEstoque.Date              := TextoParaData(FDataModule.CDSProduto.FieldByName('DATA_ESTOQUE').ASString);
  EditECF_ICMS_ST.Text              := FDataModule.CDSProduto.FieldByName('ECF_ICMS_ST').AsString;
  EditCodigoBalanca.Value           := FDataModule.CDSProduto.FieldByName('CODIGO_BALANCA').Asinteger;
  MeDescricao.Text                  := FDataModule.CDSProduto.FieldByName('DESCRICAO').AsString;
  editCodigoInterno.Text            := FDataModule.CDSProduto.FieldByName('CODIGO_INTERNO').AsString;
  editDataAlteracao.Date            := TextoParaData(FDataModule.CDSProduto.FieldByName('DATA_ALTERACAO').ASString);
  EditECF_ICMS_ST.Text:= FDataModule.CDSProduto.FieldByName('ECF_ICMS_ST').AsString;
  editPAF_P_ST.Text:= FDataModule.CDSProduto.FieldByName('PAF_P_ST').AsString;
  editTAXA_ICMS.Value:= FDataModule.CDSProduto.FieldByName('TAXA_ICMS').Value;

  cmbCSTOrigem.ItemIndex := FDataModule.CDSProduto.FieldByName('ID_CST_A').AsInteger;
  cmbCSTTratamentoTrubutario.ItemIndex := FDataModule.CDSProduto.FieldByName('ID_CST_B').AsInteger;
  cmbItemSped.ItemIndex:=FDataModule.CDSProduto.FieldByName('ID_ITEM_SPED').AsInteger;

  EditValidade.Text                 := FDataModule.CDSProduto.FieldByName('VALIDADE').AsString;
  EditCustoMedio.Text               := FDataModule.CDSProduto.FieldByName('CUSTO_MEDIO').AsString;
  EditPrecoCusto.Text               := FDataModule.CDSProduto.FieldByName('PRECO_CUSTO').AsString;
  EditNumNF.Text                    := FDataModule.CDSProduto.FieldByName('NUMERO_ULTIMA_NF').AsString;
  EditCNPJ.Text                     := FDataModule.CDSProduto.FieldByName('CNPJ_ULTIMO').AsString;
  EditFornecedor.Text               := FDataModule.CDSProduto.FieldByName('FORNECEDOR_ULTIMO').AsString;
  editValorUnNF.Text                := FDataModule.CDSProduto.FieldByName('VALOR_UN_NF').AsString;
  GpBoxMov.Enabled                  := True;
  editUnidadeCOMPRA.Text            := FDataModule.CDSProduto.FieldByName('UNIDADE_COMPRA').AsString;
  EditPercLucroBruto.Text           := FDataModule.CDSProduto.FieldByName('PERCENTUAL_LUCRO').AsString;
  EditPerDesconto.Text              := FDataModule.CDSProduto.FieldByName('PERCENTUAL_DESCONTO').AsString;
  EditPerComissao.Text              := FDataModule.CDSProduto.FieldByName('PERCENTUAL_COMISSAO').AsString;

  EditDataNF.Date                   := TextoParaData(FDataModule.CDSProduto.FieldByName('DATA_ULTIMA_NF').AsString);
  GpBoxMov.Enabled                  := False;

  if trim(EditIDImposto.Text) <> '' then
  begin
    ConfiguraCDSFromVO(FDataModule.CDSImpostoIcms, TImpostoIcmsVO);
    Pagina := 0;
    Filtro := ' ID =' + trim(EditIDImposto.Text);
    TImpostoIcmsController.Consulta(trim(Filtro), Pagina, False);

   // EditAliquotaIcmsEcf.Text := FDataModule.CDSImpostoIcms.FieldByName('ECF_ICMS_ST').AsString;

  end;

end;

procedure TFProduto.LimparCampos;
begin
  EditGtin.Text                        := '';
  EditNome.Text                        := '';
  EditDescricaoPDV.Text                := '';
  EditValor_venda.Value                := 0;
  EditQtde_estoque.Value               := 0;
  EditEstoqueMinimo.Value              := 0;
  EditEstoqueMaximo.Value              := 0;
  EditIAT.Text                         := 'A';
  EditIPPT.Text                        := 'T';
  EditNCM.Text                         := '';
  EditDataEstoque.Text                 := '';
  EditECF_ICMS_ST.Text                 := '';
  EditCodigoBalanca.Value              := 0;
  EditECF_ICMS_ST.Text                 := '';
  editPAF_P_ST.Text                    := '';
  editTAXA_ICMS.Value                  := 0;
  cmbCSTOrigem.ItemIndex               := -1;
  cmbCSTTratamentoTrubutario.ItemIndex := -1;
  cmbItemSped.ItemIndex                := -1;
  editDataAlteracao.Text               := '';
  editCodigoInterno.Text               := '';
  MeDescricao.Clear;
  edtUnidadeMedida.KeyValue            := 1;

  EditValidade.Text                    := '';
  EditCustoMedio.Text                  := '';
  EditPrecoCusto.Text                  := '';
  GpBoxMov.Enabled                     := True;
  EditDataNF.Text                      := '';
  EditNumNF.Text                       := '';
  EditCNPJ.Text                        := '';
  EditFornecedor.Text                  := '';
  editValorUnNF.Text                   := '';
  editUnidadeCOMPRA.Text               := '';
  GpBoxMov.Enabled                     := False;
  EditPercLucroBruto.Text              := '';
  EditPerDesconto.Text                 := '';
  EditPerComissao.Text                 := '';
end;

procedure TFProduto.PopulaComboUnidade;
var
  UnidadeProdutoController: TUnidadeProdutoController;
begin

  ConfiguraCDSFromVO(FDataModule.CDSUnidadeProduto, TUnidadeProdutoVO);

  UnidadeProdutoController := TUnidadeProdutoController.Create;
  try
    {TODO: verificar se há necessidade dessa linha de codigo, dataset}
    UnidadeProdutoController.SetDataSet(FDataModule.CDSUnidadeProduto);
    UnidadeProdutoController.Consulta('ID > 0',0, False);

    edtUnidadeMedida.ListField := 'NOME';
    edtUnidadeMedida.KeyField := 'ID'
  finally
    UnidadeProdutoController.Free;
  end;

end;



procedure TFProduto.PopulaEditsImpostoICMS;
begin
   EditECF_ICMS_ST.Text:= FDataModule.CDSImpostoIcms.FieldByName('ECF_ICMS_ST').AsString;
   editPAF_P_ST.Text:= FDataModule.CDSImpostoIcms.FieldByName('TIPO_TRIBUTACAO_ECF').AsString;
   editTAXA_ICMS.Value:= FDataModule.CDSImpostoIcms.FieldByName('ALIQUOTA_ICMS_ECF').Value;
   EditIDImposto.Value:= FDataModule.CDSImpostoIcms.FieldByName('ID').Value;

end;

procedure TFProduto.btnTotalClick(Sender: TObject);
begin
  try
    Panel1.Enabled:= false;
    btnTotal.Caption := 'Aguarde...';
    Application.ProcessMessages;
    try
      ExportaUnidadeProduto;
      ExportaProduto(0);
      FDataModule.CopiaCargaParaPDVs;
      ShowMessage('Exportação realizada com sucesso');
    except
      ShowMessage('Falha na exportação dos arquivos');
    end;
  finally
    Panel1.Enabled:= true;
    btnTotal.Caption := 'Total';
    PanelGrid.BringToFront;
    ActionToolBarGrid.Enabled := True;
    LimparCampos;
    ActionSalvar.Enabled := True;
    Grid.SetFocus;
  end;
end;

procedure TFProduto.btnParcialClick(Sender: TObject);
begin
  try
    Panel1.Enabled:= false;
    btnParcial.Caption := 'Aguarde...';
    Application.ProcessMessages;
    try
      ExportaUnidadeProduto;
      ExportaProduto(1);
      FDataModule.CopiaCargaParaPDVs;
      ShowMessage('Exportação realizada com sucesso');
    except
      ShowMessage('Falha na exportação dos arquivos');
    end;
  finally
    Panel1.Enabled:= true;
    btnParcial.Caption := 'Parcial';
    PanelGrid.BringToFront;
    ActionToolBarGrid.Enabled := True;
    LimparCampos;
    ActionSalvar.Enabled := True;
    Grid.SetFocus;
  end;
end;

procedure TFProduto.PopulaComboImpostoICMS;
var
  ImpostoIcmsController: TImpostoIcmsController;
begin

  ConfiguraCDSFromVO(FDataModule.CDSImpostoIcms, TImpostoIcmsVO);

  ImpostoIcmsController := TImpostoIcmsController.Create;
  try
    {TODO: verificar se há necessidade dessa linha de codigo, dataset}
    ImpostoIcmsController.SetDataSet(FDataModule.CDSImpostoIcms);
    ImpostoIcmsController.Consulta('ID > 0',0, False);

    edtImpostoICMS.ListField := 'ECF_ICMS_ST';
    edtImpostoICMS.KeyField := 'ID'
  finally
    ImpostoIcmsController.Free;
  end;

end;

procedure TFProduto.VerificaRegistroExistente(Campo,conteudo :string);
var msg : string;
begin
  if Operacao = 1  then
  begin
    TProdutoController.Consulta(' '+Campo+'=' + QuotedStr(trim(conteudo)),0, False);
    if not FDataModule.CDSProduto.IsEmpty then
    begin
      // GridParaEdits;
      // Operacao := 2;
      msg := 'O campo '+Campo+' já contem um registro com '+conteudo+' e não pode ser duplicado!';
      Application.MessageBox(pchar(msg), 'Erro', MB_OK + MB_ICONERROR);
      PanelGrid.BringToFront;
      ActionToolBarGrid.Enabled := True;
      LimparCampos;
      VerificarPaginacao;
      Grid.SetFocus;
      abort;
    end;
  end else
  if (Operacao = 2) and (IDAtual > 0)  then
  begin
    TProdutoController.Consulta('  ('+Campo+' = ' + QuotedStr(trim(conteudo))+') and ( ID <> '+IntToStr(IDAtual)+')',0, False);
    if not FDataModule.CDSProduto.IsEmpty then
    begin
      // GridParaEdits;
      // Operacao := 2;
      msg := 'O campo '+Campo+' já contem um registro com '+conteudo+' e não pode ser duplicado!';
      Application.MessageBox(pchar(msg), 'Erro', MB_OK + MB_ICONERROR);
      PanelGrid.BringToFront;
      ActionToolBarGrid.Enabled := True;
      LimparCampos;
      VerificarPaginacao;
      Grid.SetFocus;
      abort;
    end;
  end;


end;

procedure TFProduto.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSProduto.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFProduto.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    FDataModule.CDSNFe.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSNFe.IndexDefs.Update;
    FDataModule.CDSNFe.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFProduto.EditIDImpostoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TImpostoIcmsVO.Create;
    ULookup.ObjetoController := TImpostoIcmsController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'ECF_ICMS_ST';
    FLookup.ShowModal;
    EditIDImposto.Text := ULookup.CampoRetorno1;
    EditAliquotaIcmsEcf.Text := ULookup.CampoRetorno2;
    EditIDImposto.SetFocus;
  end;}
end;

procedure TFProduto.EditNCMKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F1:
    begin
      Application.CreateForm(TFLookup, FLookup);
      ULookup.ObjetoVO := TNcmVO.Create;
      ULookup.ObjetoController := TNcmController.Create;
      ULookup.CampoRetorno1 := 'ID';
      ULookup.CampoRetorno2 := 'NCM';
      FLookup.ShowModal;
      EditNCM.Text := ULookup.CampoRetorno2;
      EditNCM.SetFocus;
    end;
  end;
end;

procedure TFProduto.EditNomeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   EditDescricaoPDV.Text := copy(EditNome.Text,1,30);
end;

procedure TFProduto.EditPercLucroBrutoExit(Sender: TObject);
begin
  CalculaLucro;
end;

procedure TFProduto.EditPrecoCustoExit(Sender: TObject);
begin
  CalculaLucro;
end;

procedure TFProduto.EditValor_vendaChange(Sender: TObject);
begin
  EditPercLucroBruto.Value:=((EditValor_venda.Value*100)/EditPrecoCusto.Value)-100;
end;

procedure TFProduto.edtImpostoICMSCloseUp(Sender: TObject);
begin
  PopulaEditsImpostoICMS;
end;

procedure TFProduto.edtImpostoICMSEnter(Sender: TObject);
begin
  PopulaComboImpostoICMS;
end;

procedure TFProduto.edtImpostoICMSKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  PopulaEditsImpostoICMS;
end;

procedure TFProduto.ActionExportarCSVExecute(Sender: TObject);
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

procedure TFProduto.ActionExportarExcelExecute(Sender: TObject);
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

procedure TFProduto.ActionExportarHTMLExecute(Sender: TObject);
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

procedure TFProduto.ActionExportarWordExecute(Sender: TObject);
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

procedure TFProduto.ActionExportarXMLExecute(Sender: TObject);
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

procedure TFProduto.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFProduto.ActionImprimirExecute(Sender: TObject);
begin
//
end;

procedure TFProduto.CalculaLucro;
begin
  if IDAtual <> 0 then
  begin
    if  EditPercLucroBruto.Value > 0 then
    begin
       EditValor_venda.Value:= (EditPrecoCusto.Value*(100+EditPercLucroBruto.Value))/100;
    end;
  end;

  if IDAtual = 0 then
  begin
    if  (EditPercLucroBruto.Value > 0)and (EditValor_venda.Value = 0) then
    begin
       EditValor_venda.Value:= (EditPrecoCusto.Value*(100+EditPercLucroBruto.Value))/100;
    end;
  end;
end;

end.
