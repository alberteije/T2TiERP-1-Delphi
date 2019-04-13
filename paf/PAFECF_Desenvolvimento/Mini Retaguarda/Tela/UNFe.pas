unit UNFe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Mask,
  JvExMask, JvToolEdit, DBCtrls, JvPageList, Rtti, TypInfo, DBClient, UNFeItemUtil,
  SqlExpr, FMTBcd, ACBrNFeUtil, EmpresaController;

type
  TFNFe = class(TForm)
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
    pcEdits: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Label8: TLabel;
    editModelo: TLabeledEdit;
    editNumeroNFe: TLabeledEdit;
    editSerie: TLabeledEdit;
    editDataEmissao: TJvDateEdit;
    editNaturezaOp: TLabeledEdit;
    GroupBox1: TGroupBox;
    editDestNome: TLabeledEdit;
    editDestDocumento: TLabeledEdit;
    editDestIE: TLabeledEdit;
    editDestTelefone: TLabeledEdit;
    editDestLogradouro: TLabeledEdit;
    editDestNumero: TLabeledEdit;
    editDestBairro: TLabeledEdit;
    editDestCEP: TLabeledEdit;
    editDestCidade: TLabeledEdit;
    editDestUF: TLabeledEdit;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Panel2: TPanel;
    GridItens: TDBGrid;
    Panel3: TPanel;
    editItemNCM: TLabeledEdit;
    editItemDescricao: TLabeledEdit;
    editItemQuantidade: TJvValidateEdit;
    Label2: TLabel;
    Label3: TLabel;
    editItemValorItem: TJvValidateEdit;
    editItemTotalItem: TJvValidateEdit;
    Label4: TLabel;
    Panel5: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    editBC: TJvValidateEdit;
    editICMS: TJvValidateEdit;
    editBCSubst: TJvValidateEdit;
    editOutrasDespesas: TJvValidateEdit;
    editDesconto: TJvValidateEdit;
    editICMSSubst: TJvValidateEdit;
    editTotalProduto: TJvValidateEdit;
    editTotalNota: TJvValidateEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    editFrete: TJvValidateEdit;
    editSeguro: TJvValidateEdit;
    editTotalIPI: TJvValidateEdit;
    ActionValidar: TAction;
    editVenda: TJvValidateEdit;
    Label5: TLabel;
    Label6: TLabel;
    editPedido: TJvValidateEdit;
    editDataEntradaSaida: TJvDateEdit;
    Label7: TLabel;
    ActionAssinar: TAction;
    ActionEnviar: TAction;
    ActionCancelarNFe: TAction;
    ActionImprimirDANFE: TAction;
    ActionConsultaSEFAZ: TAction;
    editItemCodBarras: TLabeledEdit;
    Label24: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label41: TLabel;
    Label28: TLabel;
    editItemDesconto: TJvValidateEdit;
    editItemAliqIPI: TJvValidateEdit;
    editItemValorIPI: TJvValidateEdit;
    editItemBCIcmsST: TJvValidateEdit;
    editItemAliqICMSST: TJvValidateEdit;
    editItemICMSST: TJvValidateEdit;
    btInsereItem: TButton;
    editItemIDProduto: TJvValidateEdit;
    Label25: TLabel;
    editDestComplemento: TLabeledEdit;
    rgpFormaPagamento: TRadioGroup;
    cbxTipoOperacao: TComboBox;
    Label26: TLabel;
    cbxFormaImpDANFE: TComboBox;
    Label27: TLabel;
    cbxFormaEmissao: TComboBox;
    Label29: TLabel;
    cbxFinalidadeEmissao: TComboBox;
    Label30: TLabel;
    memoInfComplementar: TMemo;
    editItemUnidade: TLabeledEdit;
    editIDPessoa: TJvValidateEdit;
    Label31: TLabel;
    editDestCodCidadeIBGE: TJvValidateEdit;
    Label32: TLabel;
    editItemCFOP: TJvValidateEdit;
    Label33: TLabel;
    ActionVisualizaDetalhes: TAction;
    Panel4: TPanel;
    btResumoInfo: TSpeedButton;
    editStatus: TLabeledEdit;
    editProtocolo: TLabeledEdit;
    Action1: TAction;
    editChaveAcesso: TDBEdit;
    Label34: TLabel;
    editVersao: TDBEdit;
    Label35: TLabel;
    editNumero: TDBEdit;
    Label14: TLabel;
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
    procedure ActionValidarExecute(Sender: TObject);
    procedure btnPesquisarProdutoClick(Sender: TObject);
    procedure CarregaValorPadraoEdits(ID_Empresa: Integer);
    procedure editIDPessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editItemQuantidadeExit(Sender: TObject);
    procedure btInsereItemClick(Sender: TObject);
    procedure editItemIDProdutoExit(Sender: TObject);
    procedure editItemIDProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editItemAliqIPIExit(Sender: TObject);
    procedure ActionConsultaSEFAZExecute(Sender: TObject);
    procedure ActionImprimirDANFEExecute(Sender: TObject);
    procedure ActionCancelarNFeExecute(Sender: TObject);
    procedure ActionEnviarExecute(Sender: TObject);
    procedure ActionAssinarExecute(Sender: TObject);
    procedure editIDPessoaExit(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
    procedure btResumoInfoClick(Sender: TObject);
  private
    procedure AtualizaTotais;
    function  GeraNFeXML(Numero: string): Boolean;
  public

  end;

var
  FNFe: TFNFe;

implementation

uses
  UDataModule, UFiltro, Constantes, Biblioteca, ULookup, UMenu, Atributos,
  NotaFiscalDetalheController, T2TiORM, DBXCommon, Generics.Collections,
  ConexaoBD, pcnConversao,

  NFeCabecalhoVO, NFeCabecalhoController, NFeDetalheVO, PessoaVO,
  PessoaController, ProdutoVO, ProdutoController, EmpresaVO,
  UNFeDestinatarioUtil, NFeConfiguracaoController, NFeConfiguracaoVO,
  NfeDetalheController;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

  NFeItem : TNFeItemUtil;
  NFeDestinatario: TNFeDestinatarioUtil;

{$R *.dfm}

procedure TFNFe.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFNFe.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFNFe.FormCreate(Sender: TObject);
begin
 // Grid Principal
  ConfiguraGrid;

  TNfeConfiguracaoController.ConfiguraACBrNFe(1);

  Pagina := 0;
  VerificarPaginacao;
  FDataModule.CDSNFe.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
  PanelGrid.BringToFront;
end;

procedure TFNFe.ActionInserirExecute(Sender: TObject);
begin
  FDataModule.CDSNFe.EmptyDataSet;
  FDataModule.CDSNFeItens.EmptyDataSet;
  PanelEdits.BringToFront;
  CarregaValorPadraoEdits(1);
  pcEdits.TabIndex := 0;
  editNumeroNFe.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
  editStatus.Text := 'Em Edição/Inserção';
end;

procedure TFNFe.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSNFe.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    pcEdits.TabIndex := 0;
    editNumeroNFe.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
    editStatus.Text := 'Em Edição/Alteração';
  end;
end;

procedure TFNFe.ActionEnviarExecute(Sender: TObject);
begin
  FDataModule.ACBrNFe.NotasFiscais.LoadFromFile(GetCurrentDir+'\NFe\'+FDataModule.CDSNFe.FieldByName('Chave_acesso').AsString+'-Nfe.xml');
  if Assigned(FDataModule.ACBrNFe.NotasFiscais.Items[0]) then
  begin
     try
       FDataModule.ACBrNFe.Enviar(1,True);
       TNfeCabecalhoController.AtuaizaSituacaoNota(FDataModule.CDSNFe.FieldByName('ID').AsInteger,
                                                 4);
     except
       TNfeCabecalhoController.AtuaizaSituacaoNota(FDataModule.CDSNFe.FieldByName('ID').AsInteger,
                                                 7);
     end;
  end;
end;

procedure TFNFe.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSNFe.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TNfeCabecalhoController.Exclui(FDataModule.CDSNFe.FieldByName('ID').AsInteger);
      TNfeCabecalhoController.Consulta(Filtro, Pagina, False);
    end;
  end;
end;

procedure TFNFe.ActionSairExecute(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TFNFe.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  NFeCabecalho : TNFeCabecalhoVO;
  NFeDetalhe: TNFeDetalheVO;
  ListaNFeItem: TObjectList<TNFeDetalheVO>;
  iItem: Integer;
  ChaveAcesso: string;
begin
  try
    NFeCabecalho                           := TNfeCabecalhoVO.Create;
    NFeCabecalho.Id                        := 0;
    NFeCabecalho.IdFuncionario             := 1;
    NFeCabecalho.IdPedidoCompra            := editPedido.AsInteger;
    NFeCabecalho.IdVendaCabecalho          := editVenda.AsInteger;
    NFeCabecalho.IdCliente                 := StrToInt(editIDPessoa.Text);
    NFeCabecalho.CodigoNumerico            := editNumeroNFe.Text; // cNF - Código numérico que compõe a  Chave de Acesso. Número  aleatório gerado pelo emitente  para cada NF-e para evitar  acessos indevidos da NF-e.  (v2.0)
    NFeCabecalho.NaturezaOperacao          := editNaturezaOp.Text;
    NFeCabecalho.IndicadorFormaPagamento   := IntToStr(rgpFormaPagamento.ItemIndex);  // indPag - 0=pagamento à vista | 1=pagamento à prazo | 2=outros.
    NFeCabecalho.CodigoModelo              := editModelo.Text;
    NFeCabecalho.Serie                     := EditSerie.Text;
    NFeCabecalho.Numero                    := editNumeroNFe.Text; // numero nota fiscal sequencial, esta é controlada na base SEFAZ (Não permite duplicidade)
    NFeCabecalho.DataEmissao               := FormatDateTime('dd/mm/yyyy',editDataEmissao.Date);
    NFeCabecalho.DataEntradaSaida          := FormatDateTime('dd/mm/yyyy',editDataEntradaSaida.Date);
    NFeCabecalho.HoraEntradaSaida          := FormatDateTime('hh:mm:ss',Now);
    NFeCabecalho.TipoOperacao              := IntToStr(cbxTipoOperacao.ItemIndex); //tpNF - 0-entrada / 1-saída
    NFeCabecalho.CodigoMunicipio           := 0; //cMunFG - Informar o município de ocorrência  do fato gerador do ICMS. Utilizar a  Tabela do IBGE
    NFeCabecalho.FormatoImpressaoDanfe     := IntToStr(cbxFormaImpDANFE.ItemIndex+1);
    NFeCabecalho.TipoEmissao               := IntToStr(cbxFormaEmissao.ItemIndex +1); //tpEmis - 1 = Normal emissão normal;  2 = Contingência FS emissão  em contingência com impressão  do DANFE em Formulário de  Segurança;  3 = Contingência SCAN emissão em contingência no  Sistema de Contingência do  Ambiente Nacional SCAN;  4 = Contingência DPEC -  emissão em contingência com  envio da Declaração Prévia de  Emissão em Contingência DPEC;  5 = Contingência FS-DA -  emissão em contingência com  impressão do DANFE em Formulário de Segurança para  Impressão de Documento  Auxiliar de Documento Fiscal  Eletrônico (FS-DA).
    NFeCabecalho.ChaveAcesso               := '';// Chave de acesso da NF-e composta por  Código da UF + AAMM da emissão + CNPJ do  Emitente + Modelo, Série e Número da NFe +  Código Numérico + DV.
    NFeCabecalho.DigitoChaveAcesso         := '0'; //cDV - Informar o DV da Chave de  Acesso da NF-e, o DV será  calculado com a aplicação do  algoritmo módulo 11 (base 2,9)  da Chave de Acesso. (vide item  5 do Manual de Integração)
    NFeCabecalho.Ambiente                  := IntToStr(2); // tpAmb - 1-Produção/ 2-Homologação
    NFeCabecalho.FinalidadeEmissao         := IntToStr(cbxFinalidadeEmissao.ItemIndex + 1); //finNFe - 1- NF-e normal/ 2-NF-e  complementar / 3 – NF-e de  ajuste
    NFeCabecalho.ProcessoEmissao           := IntToStr(0); //procEmi - Identificador do processo de  emissão da NF-e:  0 - emissão de NF-e com  aplicativo do contribuinte;  1 - emissão de NF-e avulsa pelo  Fisco;  2 - emissão de NF-e avulsa,  pelo contribuinte com seu  certificado digital, através do site  do Fisco;  3- emissão NF-e pelo  contribuinte com aplicativo  fornecido pelo Fisco.
    NFeCabecalho.VersaoProcessoEmissao     := 1; //verProc - Identificador da versão do  processo de emissão (informar  a versão do aplicativo emissor  de NF-e).
    NFeCabecalho.BaseCalculoIcms           := editBC.AsFloat;
    NFeCabecalho.ValorIcms                 := editICMS.AsFloat;
    NFeCabecalho.BaseCalculoIcmsSt         := editBCSubst.AsFloat;
    NFeCabecalho.ValorIcmsSt               := editICMSSubst.AsFloat;
    NFeCabecalho.ValorTotalProdutos        := editTotalProduto.AsFloat;
    NFeCabecalho.ValorFrete                := editFrete.AsFloat;
    NFeCabecalho.ValorSeguro               := editSeguro.AsFloat;
    NFeCabecalho.ValorDesconto             := editDesconto.AsFloat;
    NFeCabecalho.ValorImpostoImportacao    := 0;
    NFeCabecalho.ValorIpi                  := editTotalIPI.AsFloat;
    NFeCabecalho.ValorPis                  := 0;
    NFeCabecalho.ValorCofins               := 0;
    NFeCabecalho.ValorDespesasAcessorias   := editOutrasDespesas.AsFloat;
    NFeCabecalho.ValorTotal                := editTotalNota.AsFloat;
    NFeCabecalho.ValorServicos             := 0;
    NFeCabecalho.BaseCalculoIssqn          := 0;
    NFeCabecalho.ValorIssqn                := 0;
    NFeCabecalho.ValorPisIssqn             := 0;
    NFeCabecalho.ValorCofinsIssqn          := 0;
    NFeCabecalho.ValorRetidoPis            := 0;
    NFeCabecalho.ValorRetidoCofins         := 0;
    NFeCabecalho.ValorRetidoCsll           := 0;
    NFeCabecalho.BaseCalculoIrrf           := 0;
    NFeCabecalho.ValorRetidoIrrf           := 0;
    NFeCabecalho.BaseCalculoPrevidencia    := 0;
    NFeCabecalho.ValorRetidoPrevidencia    := 0;
    NFeCabecalho.UfEmbarque                := '';
    NFeCabecalho.LocalEmbarque             := '';
    NFeCabecalho.NotaEmpenho               := '';
    NFeCabecalho.Pedido                    := '';
    NFeCabecalho.InformacoesComplementares := memoInfComplementar.Text;
    NFeCabecalho.ValorIssqn                := 0;
    NFeCabecalho.IssRetido                 := 'N';
    NFeCabecalho.SituacaoNota              := 1;

    {NFeCabecalho.NumeroEcf                 := 0;
    NFeCabecalho.NumeroCupomFiscal         := 0;
    }
    ListaNFeItem := TObjectList<TNfeDetalheVO>.Create(True);
    NFeDetalhe := TNfeDetalheVO.Create;
    FDataModule.CDSNFeItens.First;
    iItem := 0;
    while not FDataModule.CDSNFeItens.eof do
    begin
      inc(iItem);
      NFeDetalhe.IdNfeCabecalho          := NFeCabecalho.Id;
      NFeDetalhe.IdProduto               := FDataModule.CDSNFeItens.FieldByName('Id_produto').AsInteger;
      NFeDetalhe.NumeroItem              := iItem;
      NFeDetalhe.CodigoProduto           := FDataModule.CDSNFeItens.FieldByName('Id_produto').AsString;
      NFeDetalhe.Gtin                    := FDataModule.CDSNFeItens.FieldByName('GTIN').AsString;
      NFeDetalhe.NomeProduto             := FDataModule.CDSNFeItens.FieldByName('Nome_Produto').AsString;
      NFeDetalhe.Ncm                     := FDataModule.CDSNFeItens.FieldByName('NCM').AsString;
      NFeDetalhe.ExTipi                  := 0;
      NFeDetalhe.Cfop                    := FDataModule.CDSNFeItens.FieldByName('CFOP').AsInteger;
      NFeDetalhe.UnidadeComercial        := FDataModule.CDSNFeItens.FieldByName('Unidade_Comercial').AsString;
      NFeDetalhe.QuantidadeComercial     := FDataModule.CDSNFeItens.FieldByName('Quantidade_Comercial').AsFloat;
      NFeDetalhe.ValorUnitarioComercial  := FDataModule.CDSNFeItens.FieldByName('Valor_Unitario_Comercial').AsFloat;
      NFeDetalhe.ValorBrutoProdutos      := FDataModule.CDSNFeItens.FieldByName('VALOR_BRUTO_PRODUTOS').AsFloat;
      NFeDetalhe.GtinUnidadeTributavel   := FDataModule.CDSNFeItens.FieldByName('GTIN_UNIDADE_TRIBUTAVEL').AsString;;
      NFeDetalhe.UnidadeTributavel       := FDataModule.CDSNFeItens.FieldByName('UNIDADE_TRIBUTAVEL').AsString;
      NFeDetalhe.QuantidadeTributavel    := FDataModule.CDSNFeItens.FieldByName('QUANTIDADE_TRIBUTAVEL').AsFloat;
      NFeDetalhe.ValorUnitarioTributacao := FDataModule.CDSNFeItens.FieldByName('VALOR_UNITARIO_TRIBUTACAO').AsFloat;
      NFeDetalhe.ValorFrete              := 0; // CALCULAR FRETE INDIVIDUAL BASEADO NO FRETE DA NOTA
      NFeDetalhe.ValorSeguro             := 0; // CALCULAR SEGURO INDIVIDUAL BASEADO NO SEGURO DA NOTA
      NFeDetalhe.ValorDesconto           := 0; // Desconto do item
      NFeDetalhe.ValorOutrasDespesas     := 0;
      NFeDetalhe.EntraTotal              := '1'; //indTot - Este campo deverá ser  preenchido com:  0 = o valor do item (vProd)  compõe o valor total da NF-e  (vProd)  1 = o valor do item (vProd) não  compõe o valor total da NF-e  (vProd) (v2.0)
      NFeDetalhe.OrigemMercadoria        := '0'; //orig - Origem da mercadoria:  0 = Nacional; 1 = Estrangeira Importação  direta;  2 = Estrangeira Adquirida no  mercado interno.
      NFeDetalhe.Csosn                   := '';// ???
      NFeDetalhe.ModalidadeBcIcms        := '3'; //modBC - 0 - Margem Valor Agregado (%);  1 - Pauta (Valor);  2 - Preço Tabelado Máx. (valor);  3 - valor da operação.
      NFeDetalhe.TaxaReducaoBcIcms       := FDataModule.CDSNFeItens.FieldByName('TAXA_REDUCAO_BC_ICMS').AsFloat;
      NFeDetalhe.BaseCalculoIcms         := FDataModule.CDSNFeItens.FieldByName('BASE_CALCULO_ICMS').AsFloat;
      NFeDetalhe.AliquotaIcms            := FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_ICMS').AsFloat;
      NFeDetalhe.ValorIcms               := FDataModule.CDSNFeItens.FieldByName('VALOR_ICMS').AsFloat;
      NFeDetalhe.MotivoDesoneracaoIcms   := '';//??? motDesICMS - Este campo será preenchido  quando o campo anterior estiver  preenchido.  Informar o motivo da  desoneração:  1 - Táxi;  2 - Deficiente Físico;  3 - Produtor Agropecuário;  4 - Frotista/Locadora;  5 - Diplomático/Consular;  6 - Utilitários e Motocicletas da  Amazônia Ocidental e Áreas de  Livre Comércio (Resolução  714/88 e 790/94 - CONTRAN e  suas alterações);  7 - SUFRAMA;  9 - outros. (v2.0)
      NFeDetalhe.ModalideBcIcmsSt        := '';//modBCST - 0 - Preço tabelado ou máximo sugerido;  1 - Lista Negativa (valor);  2 - Lista Positiva (valor);  3 - Lista Neutra (valor);  4 - Margem Valor Agregado (%);  5 - Pauta (valor);
      NFeDetalhe.PercentualMvaIcmsSt     := 0; //pMVAST -Percentual da margem de  valor Adicionado do ICMS ST
      NFeDetalhe.ReducaoBcIcmsSt         := 0;
      NFeDetalhe.BaseCalculoIcmsSt       := 0;
      NFeDetalhe.AliquotaIcmsSt          := 0;
      NFeDetalhe.ValorIcmsSt             := 0;
      NFeDetalhe.ValorBcIcmsStRetido     := 0;
      NFeDetalhe.ValorIcmsStRetido       := 0;
      NFeDetalhe.AliquotaCreditoIcmsSn   := 0;
      NFeDetalhe.ValorCreditoIcmsSn      := 0;
      NFeDetalhe.EnquadramentoIpi        := '';//clEnq - Classe de enquadramento do  IPI para Cigarros e Bebidas - Preenchimento conforme Atos  Normativos editados pela  Receita Federal (Observação 2)
      NFeDetalhe.CnpjProdutor            := ''; //CNPJProd - CNPJ do produtor da  mercadoria, quando diferente  do emitente. Somente para os  casos de exportação direta ou  indireta.
      NFeDetalhe.CodigoSeloIpi           := ''; //cSelo - Código do selo de controle IPI - Preenchimento conforme Atos  Normativos editados pela  Receita Federal (Observação 3)
      NFeDetalhe.QuantidadeSeloIpi       := 0;
      NFeDetalhe.EnquadramentoLegalIpi   := '';
      NFeDetalhe.CstIpi                  := '';
      NFeDetalhe.BaseCalculoIpi          := 0;
      NFeDetalhe.AliquotaIpi             := 0;
      NFeDetalhe.ValorIpi                := 0;
      NFeDetalhe.ValorBcIi               := 0;
      NFeDetalhe.ValorDespesasAduaneiras := 0;
      NFeDetalhe.ValorImpostoImportacao  := 0;
      NFeDetalhe.ValorImpostoImportacao  := 0;
      NFeDetalhe.CtsPis                  := ''; //01 - Operação Tributável (base  de cálculo = valor da operação  alíquota normal (cumulativo/não  cumulativo));  02 - Operação Tributável (base  de cálculo = valor da operação  (alíquota diferenciada));
      NFeDetalhe.ValorBaseCalculoPis     := 0;
      NFeDetalhe.AliquotaPisPercentual   := 0;
      NFeDetalhe.AliquotaPisReais        := 0;
      NFeDetalhe.ValorPis                := 0;
      NFeDetalhe.CstCofins               := ''; //01 - Operação Tributável (base  de cálculo = valor da operação  alíquota normal (cumulativo/não  cumulativo));  02 - Operação Tributável (base  de cálculo = valor da operação  (alíquota diferenciada));
      NFeDetalhe.BaseCalculoCofins       := 0;
      NFeDetalhe.AliquotaCofinsPercentual := 0;
      NFeDetalhe.AliquotaCofinsReais     := 0;
      NFeDetalhe.ValorCofins             := 0;
      NFeDetalhe.BaseCalculoIssqn        := 0;
      NFeDetalhe.AliquotaIssqn           := 0;
      NFeDetalhe.ValorIssqn              := 0;
      NFeDetalhe.MunicipioIssqn          := 0; //Código do município de  ocorrência do fato gerador do  ISSQN
      NFeDetalhe.ItemListaServicos       := 0;//Informar o Item da lista de  serviços da LC 116/03 em que  se classifica o serviço.
      NFeDetalhe.TributacaoIssqn         := '';//cSitTrib - Informar o código da tributação  do ISSQN:  N - NORMAL;  R - RETIDA;  S - SUBSTITUTA;  I - ISENTA. (v.2.0)
      NFeDetalhe.ValorSubtotal           := FDataModule.CDSNFeItens.FieldByName('VALOR_SUBTOTAL').AsFloat;
      NFeDetalhe.ValorTotal              := FDataModule.CDSNFeItens.FieldByName('VALOR_TOTAL').AsFloat;
      NFeDetalhe.InformacoesAdicionais   := '';
      {
      NFeDetalhe.MovimentaEstoque        := 'S';
      NFeDetalhe.CstA                    := '';
      NFeDetalhe.CstB                    := '';
      NFeDetalhe.MvaAliquota             := 0;
      NFeDetalhe.ValorPauta              := 0;
      NFeDetalhe.MvaAjustada             := 0;
      }

      ListaNFeItem.Add(NFeDetalhe);
      FDataModule.CDSNFeItens.Next;
    end;

    if Operacao = 1 then
    begin
      NFeCabecalho.ID := TNfeCabecalhoController.Insere(NFeCabecalho, ListaNFeItem);
    end
    else if Operacao = 2 then
    begin
    	NFeCabecalho.ID := FDataModule.CDSNFe.FieldByName('ID').AsInteger;
      LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
      TNfeCabecalhoController.Altera(NFeCabecalho, ListaNFeItem,  Filtro, Pagina);
      Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
      Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
    end;

    GeraNFeXML(NFeCabecalho.Numero);
    ChaveAcesso := SoNumeros(FDataModule.ACBrNFe.NotasFiscais.Items[0].NFe.infNFe.ID);
    TNfeCabecalhoController.AtuaizaChaveAcesso(NFeCabecalho.ID,ChaveAcesso);

    FDataModule.CDSNFe.Edit;
    FDataModule.CDSNFe.FieldByName('CHAVE_ACESSO').AsString := ChaveAcesso;
    FDataModule.CDSNFe.Post;

    editStatus.Text := 'Em Edição/Salva';
    //PanelGrid.BringToFront;
    //ActionToolBarGrid.Enabled := True;
    //LimparCampos;
    //Pagina := 0;
    //Filtro := ' ID =' + IntToStr(NFeCabecalho.Id);
    //TNfeCabecalhoController.Consulta(trim(Filtro), Pagina, False);
    //VerificarPaginacao;
    //Grid.SetFocus;

  finally
    NFeCabecalho.Free;
  end;
end;

procedure TFNFe.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFNFe.ActionCancelarNFeExecute(Sender: TObject);
begin
  ShowMessage('Desenvolver função com ACBrNFe');
end;

procedure TFNFe.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  editNumeroNFe.SetFocus;
  ActionToolBarGrid.Enabled := False;
  GridParaEdits;
  ActionSalvar.Enabled := False;
  Operacao := 3;
end;

procedure TFNFe.ActionConsultaSEFAZExecute(Sender: TObject);
begin
 //
 ShowMessage('Desenvolver função com ACBrNFe');
end;

procedure TFNFe.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    EditCriterioRapido.clear;
    EditCriterioRapido.Text := '*';
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TNfeCabecalhoController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TNfeCabecalhoController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end;
end;

procedure TFNFe.ActionFiltrarExecute(Sender: TObject);
var
  NFeCabecalho : TNfeCabecalhoVO;
  I : Integer;
begin
  Filtro := '';
  NFeCabecalho := TNfeCabecalhoVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSNFe;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TNfeCabecalhoController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFNFe.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSNFe.First;
end;

procedure TFNFe.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSNFe.Last;
end;

procedure TFNFe.AtualizaTotais;
var dBaseCalculoIcms,
    dValorIcms ,
    dTotalProduto,
    dBaseCalculoIcmsST,
    dValorIcmsST,
    dDesconto,
    dValorTotalIpi,
    dValorNotaFiscal : Double;
begin


  dBaseCalculoIcms   := editBC.AsFloat;
  dValorIcms         := editICMS.AsFloat;
  dTotalProduto      := editTotalProduto.AsFloat;
  dBaseCalculoIcmsST := editBCSubst.AsFloat;
  dValorIcmsST       := editICMSSubst.AsFloat;
  dDesconto          := editDesconto.AsFloat;
  dValorTotalIpi     := editTotalIPI.AsFloat;

  dBaseCalculoIcms   := dBaseCalculoIcms   + FDataModule.CDSNFeItens.FieldByName('BASE_CALCULO_ICMS').AsFloat;
  dValorIcms         := dValorIcms         + FDataModule.CDSNfeItens.FieldByName('VALOR_ICMS').AsFloat;
  dTotalProduto      := dTotalProduto      + FDataModule.CDSNfeItens.FieldByName('VALOR_TOTAL').AsFloat;
  dBaseCalculoIcmsST := dBaseCalculoIcmsST + FDataModule.CDSNfeItens.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat;
  dValorIcmsST       := dValorIcmsST       + FDataModule.CDSNfeItens.FieldByName('VALOR_ICMS_ST').AsFloat;
  //dDesconto          := dDesconto          + FDataModule.CDSNfeItens.FieldByName('Valor_Desconto_Item').AsFloat;
  dValorTotalIpi     := dValorTotalIpi     + FDataModule.CDSNfeItens.FieldByName('VALOR_IPI').AsFloat;

  editTotalProduto.Value := dTotalProduto;
  editBC.Value           := dBaseCalculoIcms;
  editICMS.Value         := dValorIcms;
  editBCSubst.Value      := dBaseCalculoIcmsST;
  editICMSSubst.Value    := dValorIcmsST;
  editDesconto.Value     := dDesconto;
  editTotalIPI.Value     := dValorTotalIpi;


  dValorNotaFiscal    := dTotalProduto +  dValorIcmsST + dValorTotalIpi  + editOutrasDespesas.Value - dDesconto;
  editTotalNota.Value := dValorNotaFiscal;

end;

procedure TFNFe.btInsereItemClick(Sender: TObject);
var
  BaseCalculo: Double;
begin
  if editItemIDProduto.AsInteger > 0 then
  begin
    try
      FDataModule.CDSNFeItens.Append;
      FDataModule.CDSNFeItens.FieldByName('ID').AsInteger := 0;
      FDataModule.CDSNFeItens.FieldByName('ID_PRODUTO').AsInteger := editItemIDProduto.AsInteger;
      FDataModule.CDSNFeItens.FieldByName('ID_NFE_CABECALHO').AsInteger := 0;
      FDataModule.CDSNFeItens.FieldByName('NUMERO_ITEM').AsInteger := 0;
      FDataModule.CDSNFeItens.FieldByName('CODIGO_PRODUTO').AsString := editItemIDProduto.Text;
      FDataModule.CDSNFeItens.FieldByName('GTIN').AsString := editItemCodBarras.Text;
      FDataModule.CDSNFeItens.FieldByName('NOME_PRODUTO').AsString := editItemDescricao.Text;
      FDataModule.CDSNFeItens.FieldByName('NCM').AsString := editItemNCM.Text;
      FDataModule.CDSNFeItens.FieldByName('EX_TIPI').AsInteger := 0;
      FDataModule.CDSNFeItens.FieldByName('CFOP').AsInteger := editItemCFOP.AsInteger;
      FDataModule.CDSNFeItens.FieldByName('UNIDADE_COMERCIAL').AsString := editItemUnidade.Text;
      FDataModule.CDSNFeItens.FieldByName('QUANTIDADE_COMERCIAL').AsFloat := editItemQuantidade.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('VALOR_UNITARIO_COMERCIAL').AsFloat := editItemValorItem.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('VALOR_BRUTO_PRODUTOS').AsFloat := editItemTotalItem.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('GTIN_UNIDADE_TRIBUTAVEL').AsString := editItemCodBarras.Text;
      FDataModule.CDSNFeItens.FieldByName('UNIDADE_TRIBUTAVEL').AsString := editItemUnidade.Text;
      FDataModule.CDSNFeItens.FieldByName('QUANTIDADE_TRIBUTAVEL').AsFloat := editItemQuantidade.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('VALOR_UNITARIO_TRIBUTACAO').AsFloat := editItemValorItem.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('VALOR_FRETE').AsFloat := 0; // calcular valor frete para o item
      FDataModule.CDSNFeItens.FieldByName('VALOR_SEGURO').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_DESCONTO').AsFloat := editItemDesconto.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('VALOR_OUTRAS_DESPESAS').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('ENTRA_TOTAL').AsString := 'S';
      FDataModule.CDSNFeItens.FieldByName('ORIGEM_MERCADORIA').AsString := '0';
      FDataModule.CDSNFeItens.FieldByName('CST_ICMS').AsString := '';
      FDataModule.CDSNFeItens.FieldByName('CSOSN').AsString := '';
      FDataModule.CDSNFeItens.FieldByName('MODALIDADE_BC_ICMS').AsString := '3';
      FDataModule.CDSNFeItens.FieldByName('TAXA_REDUCAO_BC_ICMS').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('BASE_CALCULO_ICMS').AsFloat := editItemTotalItem.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_ICMS').AsFloat := NFeItem.Aliquota;
      FDataModule.CDSNFeItens.FieldByName('VALOR_ICMS').AsFloat := (editItemTotalItem.AsFloat * NFeItem.Aliquota)/100;
      FDataModule.CDSNFeItens.FieldByName('MOTIVO_DESONERACAO_ICMS').AsString := '';
      FDataModule.CDSNFeItens.FieldByName('MODALIDE_BC_ICMS_ST').AsString := '';
      FDataModule.CDSNFeItens.FieldByName('PERCENTUAL_MVA_ICMS_ST').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('REDUCAO_BC_ICMS_ST').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat := editItemBCIcmsST.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_ICMS_ST').AsFloat := editItemAliqICMSST.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('VALOR_ICMS_ST').AsFloat := editItemICMSST.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('VALOR_BC_ICMS_ST_RETIDO').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_ICMS_ST_RETIDO').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_CREDITO_ICMS_SN').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_CREDITO_ICMS_SN').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('ENQUADRAMENTO_IPI').AsString := '';
      FDataModule.CDSNFeItens.FieldByName('CNPJ_PRODUTOR').AsString := '';
      FDataModule.CDSNFeItens.FieldByName('CODIGO_SELO_IPI').AsString := '';
      FDataModule.CDSNFeItens.FieldByName('QUANTIDADE_SELO_IPI').AsInteger := 0;
      FDataModule.CDSNFeItens.FieldByName('ENQUADRAMENTO_LEGAL_IPI').AsString := '';
      FDataModule.CDSNFeItens.FieldByName('CST_IPI').Value := Null;
      FDataModule.CDSNFeItens.FieldByName('BASE_CALCULO_IPI').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_IPI').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_IPI').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_BC_II').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_DESPESAS_ADUANEIRAS').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_IMPOSTO_IMPORTACAO').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_IOF').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('CTS_PIS').AsString := '99';
      FDataModule.CDSNFeItens.FieldByName('VALOR_BASE_CALCULO_PIS').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_PIS_PERCENTUAL').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_PIS_REAIS').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_PIS').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('CST_COFINS').AsString := '';
      FDataModule.CDSNFeItens.FieldByName('BASE_CALCULO_COFINS').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_COFINS_PERCENTUAL').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_COFINS_REAIS').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_COFINS').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('BASE_CALCULO_ISSQN').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_ISSQN').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('VALOR_ISSQN').AsFloat := 0;
      FDataModule.CDSNFeItens.FieldByName('MUNICIPIO_ISSQN').AsInteger := 0;
      FDataModule.CDSNFeItens.FieldByName('ITEM_LISTA_SERVICOS').AsInteger := 0;
      FDataModule.CDSNFeItens.FieldByName('TRIBUTACAO_ISSQN').AsString := '';
      FDataModule.CDSNFeItens.FieldByName('VALOR_SUBTOTAL').AsFloat := editItemTotalItem.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('VALOR_TOTAL').AsFloat := editItemTotalItem.AsFloat;
      FDataModule.CDSNFeItens.FieldByName('INFORMACOES_ADICIONAIS').AsString := '';

      FDataModule.CDSNFeItens.Post;

      AtualizaTotais;

      editItemIDProduto.Value  := 0;
      editItemCodBarras.Text   := '';
      editItemDescricao.Text   := '';
      editItemNCM.Text         := '';
      editItemQuantidade.Value := 0;
      editItemValorItem.Value  := 0;
      editItemTotalItem.Value  := 0;
      editItemDesconto.Value   := 0;
      editItemAliqIPI.Value    := 0;
      editItemValorIPI.Value   := 0;
      editItemBCIcmsST.Value   := 0;
      editItemAliqICMSST.Value := 0;
      editItemICMSST.Value     := 0;

      editItemIDProduto.SetFocus;

    finally
      FreeAndNil(NFeItem);
    end;
  end;
end;

procedure TFNFe.btnPesquisarProdutoClick(Sender: TObject);
begin
  ShowMessage('Abre pesquisa de produtos');
end;

procedure TFNFe.CarregaValorPadraoEdits(ID_Empresa: Integer);
begin
  // Carregar valores padroes para operações de inserção de acordo com a empresa

  ID_Empresa := 1; // Carregar empresa
  editNumeroNFe.Text := '1';
  editModelo.Text := '55';
  editSerie.Text := '1';
  editNaturezaOp.Text := 'Venda de Mercadorias';
  editDataEmissao.Date := Now;
  editDataEntradaSaida.Date := Now;

end;

procedure TFNFe.ConfiguraGrid;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  I: Integer;

begin
  try

    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(TNfeCabecalhoVO);

    //Configura ClientDataset
    FDataModule.CDSNFe.Close;
    FDataModule.CDSNFe.FieldDefs.Clear;
    FDataModule.CDSNFe.IndexDefs.Clear;

    //preenche os nomes dos campos do CDS
    FDataModule.CDSNFe.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
              FDataModule.CDSNFe.FieldDefs.add((Atributo as TColumn).Name, ftString, (Atributo as TColumn).Length)
            else
            if Propriedade.PropertyType.TypeKind in [tkFloat] then
              FDataModule.CDSNFe.FieldDefs.add((Atributo as TColumn).Name, ftFloat)
            else
            if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
              FDataModule.CDSNFe.FieldDefs.add((Atributo as TColumn).Name, ftInteger)
          end;
        end;
      end;
    end;
    FDataModule.CDSNFe.CreateDataSet;

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

    Contexto.Free;
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(TNfeDetalheVO);

    //Configura ClientDataset
    FDataModule.CDSNFeItens.Close;
    FDataModule.CDSNFeItens.FieldDefs.Clear;
    FDataModule.CDSNFeItens.IndexDefs.Clear;

    //preenche os nomes dos campos do CDS
    FDataModule.CDSNFeItens.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
              FDataModule.CDSNFeItens.FieldDefs.add((Atributo as TColumn).Name, ftString, (Atributo as TColumn).Length)
            else
            if Propriedade.PropertyType.TypeKind in [tkFloat] then
              FDataModule.CDSNFeItens.FieldDefs.add((Atributo as TColumn).Name, ftFloat)
            else
            if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
              FDataModule.CDSNFeItens.FieldDefs.add((Atributo as TColumn).Name, ftInteger)
          end;
        end;
      end;
    end;
    FDataModule.CDSNFeItens.CreateDataSet;

    //Configura a Grid
    I := 1;
    GridItens.Columns[0].Title.Caption := 'ID';
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            GridItens.Columns[I].Title.Caption := (Atributo as TColumn).Caption;
            Inc(I);
          end;
        end;
      end;
    end;

    Tipo := Contexto.GetType(TEmpresaVO);

    //Configura ClientDataset
    FDataModule.CDSEmpresa.Close;
    FDataModule.CDSEmpresa.FieldDefs.Clear;
    FDataModule.CDSEmpresa.IndexDefs.Clear;

    //preenche os nomes dos campos do CDS
    FDataModule.CDSEmpresa.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if not ((Atributo as TColumn).Name = 'IMAGEM_LOGOTIPO') then
          begin
            if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
            begin
              if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
                FDataModule.CDSEmpresa.FieldDefs.add((Atributo as TColumn).Name, ftString, (Atributo as TColumn).Length)
              else
              if Propriedade.PropertyType.TypeKind in [tkFloat] then
                 FDataModule.CDSEmpresa.FieldDefs.add((Atributo as TColumn).Name, ftFloat)
              else
              if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
                FDataModule.CDSEmpresa.FieldDefs.add((Atributo as TColumn).Name, ftInteger);
            end;
          end;
        end;
      end;
    end;
    FDataModule.CDSEmpresa.CreateDataSet;


    Tipo := Contexto.GetType(TNfeConfiguracaoVO);

    //Configura ClientDataset
    FDataModule.CDSNFeConfiguracao.Close;
    FDataModule.CDSNFeConfiguracao.FieldDefs.Clear;
    FDataModule.CDSNFeConfiguracao.IndexDefs.Clear;

    //preenche os nomes dos campos do CDS
    FDataModule.CDSNFeConfiguracao.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
              FDataModule.CDSNFeConfiguracao.FieldDefs.add((Atributo as TColumn).Name, ftString, (Atributo as TColumn).Length)
            else
            if Propriedade.PropertyType.TypeKind in [tkFloat] then
              FDataModule.CDSNFeConfiguracao.FieldDefs.add((Atributo as TColumn).Name, ftFloat)
            else
            if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
              FDataModule.CDSNFeConfiguracao.FieldDefs.add((Atributo as TColumn).Name, ftInteger)
          end;
        end;
      end;
    end;
    FDataModule.CDSNFeConfiguracao.CreateDataSet;

    {
    FDataModule.CDSNFeDestinatario.Close;
    FDataModule.CDSNFeDestinatario.FieldDefs.Clear;
    FDataModule.CDSNFeDestinatario.IndexDefs.Clear;

    FDataModule.CDSNFeDestinatario.FieldDefs.Add('ID',ftInteger);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('NOME',ftString,150);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('DOCUMENTO',ftString,14);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('INSCRICAO_ESTADUAL',ftString,14);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('TELEFONE',ftString,16);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('CEP',ftString,8);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('LOGRADOURO',ftString,250);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('NUMERO',ftString,7);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('BAIRRO',ftString,100);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('COMPLEMENTO',ftString,50);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('CODIGO_IBGE_CIDADE',ftInteger);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('CIDADE',ftString,100);
    FDataModule.CDSNFeDestinatario.FieldDefs.Add('UF',ftString,2);

    FDataModule.CDSNFeDestinatario.CreateDataSet;
    }



  finally
    Contexto.Free;
  end;
end;

procedure TFNFe.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSNFe.Prior;
end;

procedure TFNFe.ActionAssinarExecute(Sender: TObject);
begin
  FDataModule.ACBrNFe.NotasFiscais.LoadFromFile(GetCurrentDir+'\NFe\'+FDataModule.CDSNFe.FieldByName('Chave_acesso').AsString+'-Nfe.xml');
  if Assigned(FDataModule.ACBrNFe.NotasFiscais.Items[0]) then
  begin
     FDataModule.ACBrNFe.NotasFiscais.Assinar;
     //0 - Edição| 1 - Salva| 2 - Validada|  3 - Assinada| 4 - Enviada| 5 - Autrizada| 6 - Cancelada
     TNfeCabecalhoController.AtuaizaSituacaoNota(FDataModule.CDSNFe.FieldByName('ID').AsInteger,
                                                 3);
  end;
end;

procedure TFNFe.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSNFe.Next;
end;

procedure TFNFe.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TNfeCabecalhoController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFNFe.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TNfeCabecalhoController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

function TFNFe.GeraNFeXML(Numero: string): Boolean;
var
 iSeqItem: integer;
begin

  TNfeConfiguracaoController.ConfiguraACBrNFe(cbxFormaEmissao.ItemIndex);
  FDataModule.ACBrNFe.NotasFiscais.Clear;


  with FDataModule.ACBrNFe.NotasFiscais.Add.NFe do
   begin
     Ide.cNF       := StrToInt(Numero);
     Ide.natOp     := 'VENDA PRODUCAO DO ESTAB.';
     Ide.indPag    := ipVista;
     Ide.modelo    := 55;
     Ide.serie     := 1;
     Ide.nNF       := StrToInt(Numero);
     Ide.dEmi      := Date;
     Ide.dSaiEnt   := Date;
     Ide.hSaiEnt   := Now;
     Ide.tpNF      := tnSaida;
     Ide.tpEmis    := teNormal;
     Ide.tpAmb     := taHomologacao;  //Lembre-se de trocar esta variável quando for para ambiente de produção
     Ide.verProc   := '1.0.0.0'; //Versão do seu sistema
     Ide.cUF       := NotaUtil.UFtoCUF('PI');
     Ide.cMunFG    := StrToInt('2211001');
     Ide.finNFe    := fnNormal;

     //     Ide.dhCont := date;
     //     Ide.xJust  := 'Justificativa Contingencia';

     //Para NFe referenciada use os campos abaixo
    { with Ide.NFref.Add do
      begin
        refNFe       := ''; //NFe Eletronica

        RefNF.cUF    := 0;  // |
        RefNF.AAMM   := ''; // |
        RefNF.CNPJ   := ''; // |
        RefNF.modelo := 1;  // |- NFe Modelo 1/1A
        RefNF.serie  := 1;  // |
        RefNF.nNF    := 0;  // |

        RefNFP.cUF     := 0;  // |
        RefNFP.AAMM    := ''; // |
        RefNFP.CNPJCPF := ''; // |
        RefNFP.IE      := ''; // |- NF produtor Rural
        RefNFP.modelo  := ''; // |
        RefNFP.serie   := 1;  // |
        RefNFP.nNF     := 0;  // |

        RefECF.modelo  := ECFModRef2B; // |
        RefECF.nECF    := '';          // |- Cupom Fiscal
        RefECF.nCOO    := '';          // |
      end;
      }

      TEmpresaController.Consulta('ID = 1',0,False);

      Emit.CNPJCPF           := FDataModule.CDSEmpresa.FieldByName('CNPJ').AsString;
      Emit.IE                := FDataModule.CDSEmpresa.FieldByName('INSCRICAO_ESTADUAL').AsString;
      Emit.xNome             := FDataModule.CDSEmpresa.FieldByName('RAZAO_SOCIAL').AsString;
      Emit.xFant             := FDataModule.CDSEmpresa.FieldByName('NOME_FANTASIA').AsString;

      Emit.EnderEmit.fone    := FDataModule.CDSEmpresa.FieldByName('FONE').AsString;
      Emit.EnderEmit.CEP     := FDataModule.CDSEmpresa.FieldByName('CEP').AsInteger;
      Emit.EnderEmit.xLgr    := FDataModule.CDSEmpresa.FieldByName('LOGRADOURO').AsString;
      Emit.EnderEmit.nro     := FDataModule.CDSEmpresa.FieldByName('NUMERO').AsString;
      Emit.EnderEmit.xCpl    := FDataModule.CDSEmpresa.FieldByName('COMPLEMENTO').AsString;
      Emit.EnderEmit.xBairro := FDataModule.CDSEmpresa.FieldByName('BAIRRO').AsString;
      Emit.EnderEmit.cMun    := FDataModule.CDSEmpresa.FieldByName('CODIGO_IBGE_CIDADE').AsInteger;
      Emit.EnderEmit.xMun    := FDataModule.CDSEmpresa.FieldByName('CIDADE').AsString;
      Emit.EnderEmit.UF      := FDataModule.CDSEmpresa.FieldByName('UF').AsString;
      Emit.enderEmit.cPais   := 1058;
      Emit.enderEmit.xPais   := 'BRASIL';

      Emit.IEST              := '';
      Emit.IM                := ''; // Preencher no caso de existir serviços na nota
      Emit.CNAE              := ''; // Verifique na cidade do emissor da NFe se é permitido
                                    // a inclusão de serviços na NFe
      Emit.CRT               := crtRegimeNormal;// (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)

     //Para NFe Avulsa preencha os campos abaixo
     {Avulsa.CNPJ    := '';
      Avulsa.xOrgao  := '';
      Avulsa.matr    := '';
      Avulsa.xAgente := '';
      Avulsa.fone    := '';
      Avulsa.UF      := '';
      Avulsa.nDAR    := '';
      Avulsa.dEmi    := now;
      Avulsa.vDAR    := 0;
      Avulsa.repEmi  := '';
      Avulsa.dPag    := now;}

      Dest.CNPJCPF           := editDestDocumento.Text;
      Dest.IE                := editDestIE.Text;
      Dest.ISUF              := '';
      Dest.xNome             := editDestNome.Text;

      Dest.EnderDest.Fone    := editDestTelefone.Text;
      Dest.EnderDest.CEP     := StrToInt(editDestCEP.Text);
      Dest.EnderDest.xLgr    := editDestLogradouro.Text;
      Dest.EnderDest.nro     := editDestNumero.Text;
      Dest.EnderDest.xCpl    := editDestComplemento.Text;
      Dest.EnderDest.xBairro := editDestBairro.Text;
      Dest.EnderDest.cMun    := editDestCodCidadeIBGE.AsInteger;
      Dest.EnderDest.xMun    := editDestCidade.Text;
      Dest.EnderDest.UF      := editDestUF.Text;
      Dest.EnderDest.cPais   := 1058;
      Dest.EnderDest.xPais   := 'BRASIL';

     //Use os campos abaixo para informar o endereço de retirada quando for diferente do Remetente/Destinatário
     {Retirada.CNPJCPF := '';
      Retirada.xLgr    := '';
      Retirada.nro     := '';
      Retirada.xCpl    := '';
      Retirada.xBairro := '';
      Retirada.cMun    := 0;
      Retirada.xMun    := '';
      Retirada.UF      := '';}

     //Use os campos abaixo para informar o endereço de entrega quando for diferente do Remetente/Destinatário
     {Entrega.CNPJCPF := '';
      Entrega.xLgr    := '';
      Entrega.nro     := '';
      Entrega.xCpl    := '';
      Entrega.xBairro := '';
      Entrega.cMun    := 0;
      Entrega.xMun    := '';
      Entrega.UF      := '';}

     //Adicionando Produtos
      iSeqItem := 0; // Verificar se ha controle no sistema/banco de dados
      FDataModule.CDSNFeItens.DisableControls;
      FDataModule.CDSNFeItens.First;
      while not FDataModule.CDSNFeItens.Eof do
      begin
        with Det.Add do
         begin
           inc(iSeqItem);
           Prod.nItem    := iSeqItem; // Número sequencial, para cada item deve ser incrementado
           Prod.cProd    := FDataModule.CDSNFeItens.FieldByName('CODIGO_PRODUTO').AsString;
           Prod.cEAN     := FDataModule.CDSNFeItens.FieldByName('GTIN').AsString;
           Prod.xProd    := FDataModule.CDSNFeItens.FieldByName('NOME_PRODUTO').AsString;
           Prod.NCM      := FDataModule.CDSNFeItens.FieldByName('NCM').AsString;
           if FDataModule.CDSNFeItens.FieldByName('EX_TIPI').AsInteger > 0 then
             Prod.EXTIPI   := FDataModule.CDSNFeItens.FieldByName('EX_TIPI').AsString;
           Prod.CFOP     := FDataModule.CDSNFeItens.FieldByName('CFOP').AsString;
           Prod.uCom     := FDataModule.CDSNFeItens.FieldByName('UNIDADE_COMERCIAL').AsString;
           Prod.qCom     := FDataModule.CDSNFeItens.FieldByName('QUANTIDADE_COMERCIAL').AsFloat ;
           Prod.vUnCom   := FDataModule.CDSNFeItens.FieldByName('VALOR_UNITARIO_COMERCIAL').AsFloat;
           Prod.vProd    := FDataModule.CDSNFeItens.FieldByName('VALOR_BRUTO_PRODUTOS').AsFloat;

           Prod.cEANTrib  := FDataModule.CDSNFeItens.FieldByName('GTIN').AsString;
           Prod.uTrib     := FDataModule.CDSNFeItens.FieldByName('UNIDADE_COMERCIAL').AsString;
           Prod.qTrib     := FDataModule.CDSNFeItens.FieldByName('QUANTIDADE_COMERCIAL').AsFloat ;
           Prod.vUnTrib   := FDataModule.CDSNFeItens.FieldByName('VALOR_UNITARIO_COMERCIAL').AsFloat;

           Prod.vFrete    := FDataModule.CDSNFeItens.FieldByName('VALOR_FRETE').AsFloat;
           Prod.vSeg      := FDataModule.CDSNFeItens.FieldByName('VALOR_SEGURO').AsFloat;
           Prod.vDesc     := FDataModule.CDSNFeItens.FieldByName('VALOR_DESCONTO').AsFloat;

           infAdProd      := FDataModule.CDSNFeItens.FieldByName('INFORMACOES_ADICIONAIS').AsString;

         //Declaração de Importação. Pode ser adicionada várias através do comando Prod.DI.Add
         {with Prod.DI.Add do
          begin
            nDi         := '';
            dDi         := now;
            xLocDesemb  := '';
            UFDesemb    := '';
            dDesemb     := now;
            cExportador := '';

            with adi.Add do
             begin
               nAdicao     := 1;
               nSeqAdi     := 1;
               cFabricante := '';
               vDescDI     := 0;
             end;
          end;}

         //Campos para venda de veículos novos
         {with Prod.veicProd do
          begin
            tpOP    := toVendaConcessionaria;
            schassi  := '';
            cCor    := '';
            xCor    := '';
            pot     := '';
            Cilin   := '';
            pesoL   := '';
            pesoB   := '';
            nSerie  := '';
            tpComb  := '';
            nMotor  := '';
            CMT     := '';
            dist    := '';
            RENAVAM := '';
            anoMod  := 0;
            anoFab  := 0;
            tpPint  := '';
            tpVeic  := 0;
            espVeic := 0;
            VIN     := '';
            condVeic := cvAcabado;
            cMod    := '';
          end;}

         //Campos específicos para venda de medicamentos
         {with Prod.med.Add do
          begin
            nLote := '';
            qLote := 0 ;
            dFab  := now ;
            dVal  := now ;
            vPMC  := 0 ;
          end;}

         //Campos específicos para venda de armamento
         {with Prod.arma.Add do
          begin
            nSerie := 0;
            tpArma := taUsoPermitido ;
            nCano  := 0 ;
            descr  := '' ;
          end;}

         //Campos específicos para venda de combustível(distribuidoras)
         {with Prod.comb do
          begin
            cProdANP := 0;
            CODIF    := '';
            qTemp    := 0;
            UFcons   := '';

            CIDE.qBCprod   := 0 ;
            CIDE.vAliqProd := 0 ;
            CIDE.vCIDE     := 0 ;

            ICMS.vBCICMS   := 0 ;
            ICMS.vICMS     := 0 ;
            ICMS.vBCICMSST := 0 ;
            ICMS.vICMSST   := 0 ;

            ICMSInter.vBCICMSSTDest := 0 ;
            ICMSInter.vICMSSTDest   := 0 ;

            ICMSCons.vBCICMSSTCons := 0 ;
            ICMSCons.vICMSSTCons   := 0 ;
            ICMSCons.UFcons        := '' ;
          end;}

           with Imposto do
           begin
             with ICMS do
             begin
               CST          := cst00;
               ICMS.orig    := oeNacional;
               ICMS.modBC   := dbiValorOperacao;
               ICMS.vBC     := FDataModule.CDSNFeItens.FieldByName('BASE_CALCULO_ICMS').AsFloat;
               ICMS.pICMS   := FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_ICMS').AsFloat;
               ICMS.vICMS   := FDataModule.CDSNFeItens.FieldByName('VALOR_ICMS').AsFloat;
               ICMS.modBCST := dbisMargemValorAgregado;
               ICMS.pMVAST  := 0;
               ICMS.pRedBCST:= 0;
               ICMS.vBCST   := 0;
               ICMS.pICMSST := 0;
               ICMS.vICMSST := 0;
               ICMS.pRedBC  := 0;
             end;

           { with IPI do
             begin
               CST      := ipi99 ;
               clEnq    := '999';
               CNPJProd := '';
               cSelo    := '';
               qSelo    := 0;
               cEnq     := '';

               vBC    := 100;
               qUnid  := 0;
               vUnid  := 0;
               pIPI   := 5;
               vIPI   := 5;
             end;}

           {
            with II do
             begin
               vBc      := 0;
               vDespAdu := 0;
               vII      := 0;
               vIOF     := 0;
             end;

            with PIS do
             begin
               CST      := pis99;
               PIS.vBC  := 0;
               PIS.pPIS := 0;
               PIS.vPIS := 0;

               PIS.qBCProd   := 0;
               PIS.vAliqProd := 0;
               PIS.vPIS      := 0;
             end;

            with PISST do
             begin
               vBc       := 0;
               pPis      := 0;
               qBCProd   := 0;
               vAliqProd := 0;
               vPIS      := 0;
             end;

            with COFINS do
             begin
               CST            := cof99;
               COFINS.vBC     := 0;
               COFINS.pCOFINS := 0;
               COFINS.vCOFINS := 0;

               COFINS.qBCProd   := 0;
               COFINS.vAliqProd := 0;
             end;

            with COFINSST do
             begin
               vBC       := 0;
               pCOFINS   := 0;
               qBCProd   := 0;
               vAliqProd := 0;
               vCOFINS   := 0;
             end;}

            //Grupo para serviços
           { with ISSQN do
             begin
               vBC       := 0;
               vAliq     := 0;
               vISSQN    := 0;
               cMunFG    := 0;
               cListServ := 0; // Preencha este campo usando a tabela disponível
                               // em http://www.planalto.gov.br/Ccivil_03/LEIS/LCP/Lcp116.htm
             end;}
            end;
         end ;
         FDataModule.CDSNFeItens.Next;
         FDataModule.CDSNFeItens.EnableControls;
      end;

      Total.ICMSTot.vBC     := editBC.AsFloat;
      Total.ICMSTot.vICMS   := editICMS.AsFloat;
      Total.ICMSTot.vBCST   := editBCSubst.AsFloat;
      Total.ICMSTot.vST     := 0;
      Total.ICMSTot.vProd   := editTotalProduto.AsFloat;
      Total.ICMSTot.vFrete  := editFrete.AsFloat;
      Total.ICMSTot.vSeg    := editSeguro.AsFloat;
      Total.ICMSTot.vDesc   := editDesconto.AsFloat;
      Total.ICMSTot.vII     := 0;
      Total.ICMSTot.vIPI    := editTotalIPI.AsFloat;
      Total.ICMSTot.vPIS    := 0;
      Total.ICMSTot.vCOFINS := 0;
      Total.ICMSTot.vOutro  := editOutrasDespesas.AsFloat;
      Total.ICMSTot.vNF     := editTotalNota.AsFloat;

{      Total.ISSQNtot.vServ   := 0;
      Total.ISSQNTot.vBC     := 0;
      Total.ISSQNTot.vISS    := 0;
      Total.ISSQNTot.vPIS    := 0;
      Total.ISSQNTot.vCOFINS := 0;}

{      Total.retTrib.vRetPIS    := 0;
      Total.retTrib.vRetCOFINS := 0;
      Total.retTrib.vRetCSLL   := 0;
      Total.retTrib.vBCIRRF    := 0;
      Total.retTrib.vIRRF      := 0;
      Total.retTrib.vBCRetPrev := 0;
      Total.retTrib.vRetPrev   := 0;}

      Transp.modFrete := mfContaEmitente;
      Transp.Transporta.CNPJCPF  := '';
      Transp.Transporta.xNome    := '';
      Transp.Transporta.IE       := '';
      Transp.Transporta.xEnder   := '';
      Transp.Transporta.xMun     := '';
      Transp.Transporta.UF       := '';

{      Transp.retTransp.vServ    := 0;
      Transp.retTransp.vBCRet   := 0;
      Transp.retTransp.pICMSRet := 0;
      Transp.retTransp.vICMSRet := 0;
      Transp.retTransp.CFOP     := '';
      Transp.retTransp.cMunFG   := 0;         }

      Transp.veicTransp.placa := '';
      Transp.veicTransp.UF    := '';
      Transp.veicTransp.RNTC  := '';
//Dados do Reboque
{      with Transp.Reboque.Add do
       begin
         placa := '';
         UF    := '';
         RNTC  := '';
       end;}

      with Transp.Vol.Add do
       begin
         qVol  := 1;
         esp   := 'Especie';
         marca := 'Marca';
         nVol  := 'Numero';
         pesoL := 100;
         pesoB := 110;

         //Lacres do volume. Pode ser adicionado vários
         //Lacres.Add.nLacre := '';
       end;

      Cobr.Fat.nFat  := 'Numero da Fatura';
      Cobr.Fat.vOrig := 100 ;
      Cobr.Fat.vDesc := 0 ;
      Cobr.Fat.vLiq  := 100 ;

      with Cobr.Dup.Add do
       begin
         nDup  := '1234';
         dVenc := now+10;
         vDup  := 50;
       end;

      with Cobr.Dup.Add do
       begin
         nDup  := '1235';
         dVenc := now+10;
         vDup  := 50;
       end;


      InfAdic.infCpl     :=  '';
      InfAdic.infAdFisco :=  '';

      with InfAdic.obsCont.Add do
       begin
         xCampo := 'ObsCont';
         xTexto := 'Texto';
       end;

      with InfAdic.obsFisco.Add do
       begin
         xCampo := 'ObsFisco';
         xTexto := 'Texto';
       end;
//Processo referenciado
{     with InfAdic.procRef.Add do
       begin
         nProc := '';
         indProc := ipSEFAZ;
       end;                 }

      exporta.UFembarq   := '';;
      exporta.xLocEmbarq := '';

      compra.xNEmp := '';
      compra.xPed  := '';
      compra.xCont := '';
   end;

   FDataModule.ACBrNFe.Configuracoes.Geral.Salvar := true;
   FDataModule.ACBrNFe.Configuracoes.Geral.PathSalvar := GetCurrentDir+'\NFe';
   FDataModule.ACBrNFe.NotasFiscais.Items[0].SaveToFile;


end;

procedure TFNFe.GridParaEdits;
begin

  // Cabecalho

  editNumeroNFe.Text         := FDataModule.CDSNFe.FieldByName('Numero').AsString;
  editModelo.Text            := FDataModule.CDSNFe.FieldByName('CODIGO_MODELO').AsString;
  editSerie.Text             := FDataModule.CDSNFe.FieldByName('Serie').AsString;
  editNaturezaOp.Text        := FDataModule.CDSNFe.FieldByName('NATUREZA_OPERACAO').AsString;
  editDataEmissao.Date       := FDataModule.CDSNFe.FieldByName('DATA_EMISSAO').AsDateTime;
  editDataEntradaSaida.Date  := FDataModule.CDSNFe.FieldByName('DATA_ENTRADA_SAIDA').AsDateTime;
  cbxTipoOperacao.ItemIndex  := FDataModule.CDSNFe.FieldByName('TIPO_OPERACAO').AsInteger;
  cbxFormaImpDANFE.ItemIndex := FDataModule.CDSNFe.FieldByName('FORMATO_IMPRESSAO_DANFE').AsInteger -1;
  cbxFormaEmissao.ItemIndex  := FDataModule.CDSNFe.FieldByName('TIPO_EMISSAO').AsInteger -1;
  editPedido.Value           := FDataModule.CDSNFe.FieldByName('ID_PEDIDO_COMPRA').AsInteger;
  editVenda.Value            := FDataModule.CDSNFe.FieldByName('ID_VENDA_CABECALHO').AsInteger;

  /// Destinatario

  NFeDestinatario := TNFeDestinatarioUtil.Create;
  try
    NFeDestinatario.AtualizaDestinatario(FDataModule.CDSNFe.FieldByName('ID_CLIENTE').asinteger);
    if NFeDestinatario.Nome <> '' then
    begin
      editIDPessoa.AsInteger          := NFeDestinatario.ID;
      editDestNome.Text               := NFeDestinatario.Nome;
      editDestDocumento.Text          := NFeDestinatario.Documento;
      editDestTelefone.Text           := NFeDestinatario.Telefone;
      editDestLogradouro.Text         := NFeDestinatario.Logradouro;
      editDestNumero.Text             := NFeDestinatario.Numero;
      editDestComplemento.Text        := NFeDestinatario.Complemento;
      editDestBairro.Text             := NFeDestinatario.Bairro;
      editDestCEP.Text                := NFeDestinatario.Cep;
      editDestCidade.Text             := NFeDestinatario.Cidade;
      editDestUF.Text                 := NFeDestinatario.Uf;
      editDestCodCidadeIBGE.AsInteger := NFeDestinatario.CodigoCidadeIBGE;
    end;
  finally
    FreeAndNil(NFeDestinatario);
  end;

  /// Itens
  TNfeDetalheController.Consulta('ID_NFE_CABECALHO = '+IntToStr(FDataModule.CDSNFe.FieldByName('ID').AsInteger),0,False);


  /// Totais
  editTotalProduto.Value    := FDataModule.CDSNFe.FieldByName('VALOR_TOTAL_PRODUTOS').AsFloat;
  editTotalNota.Value       := FDataModule.CDSNFe.FieldByName('VALOR_TOTAL').AsFloat;
  editBC.Value              := FDataModule.CDSNFe.FieldByName('BASE_CALCULO_ICMS').AsFloat;
  editICMS.Value            := FDataModule.CDSNFe.FieldByName('VALOR_ICMS').AsFloat;
  editBCSubst.Value         := FDataModule.CDSNFe.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat;
  editICMSSubst.Value       := FDataModule.CDSNFe.FieldByName('VALOR_ICMS_ST').AsFloat;
  editFrete.Value           := FDataModule.CDSNFe.FieldByName('VALOR_FRETE').AsFloat;
  editSeguro.Value          := FDataModule.CDSNFe.FieldByName('VALOR_SEGURO').AsFloat;
  editOutrasDespesas.Value  := FDataModule.CDSNFe.FieldByName('VALOR_DESPESAS_ACESSORIAS').AsFloat;
  editTotalIPI.Value        := FDataModule.CDSNFe.FieldByName('VALOR_IPI').AsFloat;
  editDesconto.Value        := FDataModule.CDSNFe.FieldByName('VALOR_DESCONTO').AsFloat;

end;

procedure TFNFe.editIDPessoaExit(Sender: TObject);
begin
  if editIDPessoa.AsInteger > 0 then
  begin
    NFeDestinatario := TNFeDestinatarioUtil.Create;
    try
      NFeDestinatario.AtualizaDestinatario(editIDPessoa.AsInteger);
      if NFeDestinatario.Nome <> '' then
      begin
        editDestNome.Text          := NFeDestinatario.Nome;
        editDestDocumento.Text     := NFeDestinatario.Documento;
        editDestTelefone.Text      := NFeDestinatario.Telefone;
        editDestLogradouro.Text    := NFeDestinatario.Logradouro;
        editDestNumero.Text        := NFeDestinatario.Numero;
        editDestComplemento.Text   := NFeDestinatario.Complemento;
        editDestBairro.Text        := NFeDestinatario.Bairro;
        editDestCEP.Text           := NFeDestinatario.Cep;
        editDestCidade.Text        := NFeDestinatario.Cidade;
        editDestUF.Text            := NFeDestinatario.Uf;
        editDestCodCidadeIBGE.AsInteger := NFeDestinatario.CodigoCidadeIBGE;
      end
      else
        Application.MessageBox('Destinatário não localizado!','Informação do Sistema',MB_OK+MB_ICONEXCLAMATION);
    finally
      FreeAndNil(NFeDestinatario);
    end;
  end;
end;

procedure TFNFe.editIDPessoaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TPessoaVO.Create;
    ULookup.ObjetoController := TPessoaController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'Nome';
    FLookup.ShowModal;
    editIDPessoa.Text := ULookup.CampoRetorno1;
    editDestNome.Text := ULookup.CampoRetorno2;
    editIDPessoa.SetFocus;
  end;

end;

procedure TFNFe.editItemAliqIPIExit(Sender: TObject);
begin
  if editItemAliqIPI.AsFloat > 0 then
    editItemValorIPI.Value := ((editItemTotalItem.AsFloat * editItemAliqIPI.AsFloat)/100)
  else
    editItemValorIPI.Value := 0;
end;

procedure TFNFe.editItemIDProdutoExit(Sender: TObject);
begin

  if editItemIDProduto.AsInteger > 0 then
  begin
    if NFeItem = nil then
      NFeItem := TNFeItemUtil.Create;
    NFeItem.AtualizaNFeItem(editItemIDProduto.AsInteger);
    if NFeItem.Id_Produto > 0  then
    begin
      editItemCodBarras.Text    := NFeItem.CodBarras;
      editItemDescricao.Text    := NFeItem.Descricao;
      editItemUnidade.Text      := NFeItem.Unidade;
      editItemNCM.Text          := NFeItem.NCM;
      editItemValorItem.AsFloat := NFeItem.ValorItem;
      editItemAliqIPI.AsFloat   := 0;
      editItemQuantidade.AsFloat := 1;
    end
    else
      Application.MessageBox('Produto não localizado!','Informação do Sistema',MB_OK+MB_ICONEXCLAMATION);
  end;
end;

procedure TFNFe.editItemIDProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TProdutoVO.Create;
    ULookup.ObjetoController := TProdutoController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'Nome';
    if FLookup.ShowModal = mrOk then
    begin
      editItemIDProduto.Text         := ULookup.CampoRetorno1;
      editItemDescricao.Text  := ULookup.CampoRetorno2;
      editItemNCM.Text        := FDataModule.CDSLookup.FieldByName('NCM').AsString;
      editItemValorItem.Value := FDataModule.CDSLookup.FieldByName('Valor_Venda').AsFloat;
    end;
    editItemIDProduto.SetFocus;
  end;

end;

procedure TFNFe.editItemQuantidadeExit(Sender: TObject);
begin
  editItemTotalItem.Value := (editItemQuantidade.AsFloat * editItemValorItem.AsFloat) - editItemDesconto.AsFloat;
  editItemAliqIPIExit(editItemAliqIPI);
end;

procedure TFNFe.LimparCampos;
begin
  LimpaEdits(Self);
end;

procedure TFNFe.btResumoInfoClick(Sender: TObject);
begin
  ShowMessage('Exibe resumo de informações da nota fiscal');
end;

procedure TFNFe.TabSheet2Enter(Sender: TObject);
begin
  editItemIDProduto.SetFocus;
end;

procedure TFNFe.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSNFe.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFNFe.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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

procedure TFNFe.ActionExportarCSVExecute(Sender: TObject);
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

procedure TFNFe.ActionExportarExcelExecute(Sender: TObject);
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

procedure TFNFe.ActionExportarHTMLExecute(Sender: TObject);
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

procedure TFNFe.ActionExportarWordExecute(Sender: TObject);
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

procedure TFNFe.ActionExportarXMLExecute(Sender: TObject);
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

procedure TFNFe.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFNFe.ActionValidarExecute(Sender: TObject);
begin
  FDataModule.ACBrNFe.NotasFiscais.LoadFromFile(GetCurrentDir+'\NFe\'+FDataModule.CDSNFe.FieldByName('Chave_acesso').AsString+'-Nfe.xml');
  if Assigned(FDataModule.ACBrNFe.NotasFiscais.Items[0]) then
    FDataModule.ACBrNFe.NotasFiscais.Valida;
end;

procedure TFNFe.ActionImprimirDANFEExecute(Sender: TObject);
begin
  FDataModule.ACBrNFe.NotasFiscais.LoadFromFile(GetCurrentDir+'\NFe\'+FDataModule.CDSNFe.FieldByName('Chave_acesso').AsString+'-Nfe.xml');
  if Assigned(FDataModule.ACBrNFe.NotasFiscais.Items[0]) then
    FDataModule.ACBrNFe.NotasFiscais.Imprimir;
end;

procedure TFNFe.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
