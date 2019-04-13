{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Para Entrada de Nota Fiscal

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

  @author Albert Eije (alberteije@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit UEntradaNF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Atributos, Constantes,
  ActnList, RibbonSilverStyleActnCtrls, ActnMan, JvExStdCtrls, JvEdit,
  JvValidateEdit, JvCombobox, Mask, JvExMask, JvToolEdit, ToolWin, pcnNFeRTXT,
  ActnCtrls, Generics.Collections, ACBrNFeUtil, pcnConversao, StrUtils,
  LabeledCtrls, DB, DBClient, JvBaseEdits, NfeConfiguracaoController, NfeConfiguracaoVO,
  JvExExtCtrls, JvNetscapeSplitter;

type
  [TFormDescription(TConstantes.MODULO_ESTOQUE, 'Entrada de Nota Fiscal')]

  TFEntradaNF = class(TFTelaCadastro)
    ActionManager: TActionManager;
    ActionSelecionarArquivo: TAction;
    ScrollBox: TScrollBox;
    BevelEdits: TBevel;
    ActionToolBarEdits: TActionToolBar;
    PageControlEdits: TPageControl;
    TabSheetDadosNotaFiscal: TTabSheet;
    PanelDadosNotaFiscal: TPanel;
    EditNumeroNfe: TLabeledEdit;
    EditSerie: TLabeledEdit;
    EditNaturezaOperacao: TLabeledEdit;
    GroupBoxEmitente: TGroupBox;
    EditEmitenteCpfCnpj: TLabeledEdit;
    EditEmitenteFantasia: TLabeledEdit;
    EditEmitenteIE: TLabeledEdit;
    EditEmitenteTelefone: TLabeledEdit;
    EditEmitenteLogradouro: TLabeledEdit;
    EditEmitenteNumero: TLabeledEdit;
    EditEmitenteBairro: TLabeledEdit;
    EditEmitenteCEP: TLabeledEdit;
    EditEmitenteCidade: TLabeledEdit;
    EditEmitenteUF: TLabeledEdit;
    EditEmitenteComplemento: TLabeledEdit;
    EditEmitenteRazao: TLabeledEdit;
    EditEmitenteEmail: TLabeledEdit;
    EditEmitenteTipo: TLabeledEdit;
    TabSheetDocumentosReferenciados: TTabSheet;
    TabSheetEntregaRetirada: TTabSheet;
    PanelEntregaRetirada: TPanel;
    GroupBoxEntrega: TGroupBox;
    EditEntregaCpfCnpj: TLabeledEdit;
    EditEntregaLogradouro: TLabeledEdit;
    EditEntregaNumero: TLabeledEdit;
    EditEntregaBairro: TLabeledEdit;
    EditEntregaCidade: TLabeledEdit;
    EditEntregaUf: TLabeledEdit;
    EditEntregaComplemento: TLabeledEdit;
    GroupBoxRetirada: TGroupBox;
    EditRetiradaCpfCnpj: TLabeledEdit;
    EditRetiradaLogradouro: TLabeledEdit;
    EditRetiradaNumero: TLabeledEdit;
    EditRetiradaBairro: TLabeledEdit;
    EditRetiradaCidade: TLabeledEdit;
    EditRetiradaUf: TLabeledEdit;
    EditRetiradaComplemento: TLabeledEdit;
    TabSheetProdutos: TTabSheet;
    PanelDetalhes: TPanel;
    GridItens: TJvDBUltimGrid;
    TabSheetTransporte: TTabSheet;
    PanelTransporte: TPanel;
    GroupBoxTransportador: TGroupBox;
    EditTransportadorCpfCnpj: TLabeledEdit;
    EditTransportadorIE: TLabeledEdit;
    EditTransportadorLogradouro: TLabeledEdit;
    EditTransportadorCidade: TLabeledEdit;
    EditTransportadorUF: TLabeledEdit;
    EditTransportadorRazaoSocial: TLabeledEdit;
    GroupBoxTransporteRetencaoICMS: TGroupBox;
    EditRetencaoIcmsUf: TLabeledEdit;
    GroupBoxVeiculo: TGroupBox;
    EditVeiculoRntc: TLabeledEdit;
    EditVeiculoPlaca: TLabeledEdit;
    EditVeiculoUf: TLabeledEdit;
    GroupBoxReboque: TGroupBox;
    GroupBoxVolumes: TGroupBox;
    TabSheetInformacoesAdicionais: TTabSheet;
    TabSheetCobranca: TTabSheet;
    PanelCobranca: TPanel;
    PanelFatura: TPanel;
    GroupBoxFatura: TGroupBox;
    EditFaturaNumero: TLabeledEdit;
    TabSheetEscrituracao: TTabSheet;
    EditDataEmissao: TLabeledDateEdit;
    EditDataEntradaSaida: TLabeledDateEdit;
    EditHoraEntradaSaida: TLabeledMaskEdit;
    ComboTipoOperacao: TLabeledComboBox;
    ComboTipoEmissao: TLabeledComboBox;
    ComboFinalidadeEmissao: TLabeledComboBox;
    ComboFormaImpDanfe: TLabeledComboBox;
    ComboBoxFormaPagamento: TLabeledComboBox;
    EditChaveAcesso: TLabeledEdit;
    ComboModalidadeFrete: TLabeledComboBox;
    ComboEmitenteCrt: TLabeledComboBox;
    GroupBox1: TGroupBox;
    GridDuplicatas: TJvDBUltimGrid;
    EditFaturaValorOriginal: TLabeledCalcEdit;
    EditFaturaValorDesconto: TLabeledCalcEdit;
    EditFaturaValorLiquido: TLabeledCalcEdit;
    GridReboque: TJvDBUltimGrid;
    GridVolumes: TJvDBUltimGrid;
    EditCodigoNumerico: TLabeledEdit;
    EditEmitenteCodigoIbge: TLabeledCalcEdit;
    EditDigitoChaveAcesso: TLabeledEdit;
    EditEntregaIbge: TLabeledCalcEdit;
    EditRetiradaIbge: TLabeledCalcEdit;
    EditRetencaoIcmsBaseCalculo: TLabeledCalcEdit;
    EditRetencaoIcmsAliquota: TLabeledCalcEdit;
    EditRetencaoIcmsValorServico: TLabeledCalcEdit;
    EditRetencaoIcmsIcmsRetido: TLabeledCalcEdit;
    EditRetencaoIcmsCidade: TLabeledCalcEdit;
    PageControlReferenciado: TPageControl;
    TabSheetReferenciadoNfe: TTabSheet;
    TabSheetReferenciadoNf: TTabSheet;
    TabSheetReferenciadoCte: TTabSheet;
    TabSheetReferenciadoRural: TTabSheet;
    TabSheetReferenciadoCupom: TTabSheet;
    GridNfeReferenciada: TJvDBUltimGrid;
    GridNfReferenciada: TJvDBUltimGrid;
    GridCteReferenciado: TJvDBUltimGrid;
    GridNfRuralReferenciada: TJvDBUltimGrid;
    GridCupomReferenciado: TJvDBUltimGrid;
    EditEmitenteId: TLabeledCalcEdit;
    EditTransportadorId: TLabeledCalcEdit;
    EditTransporteVagao: TLabeledEdit;
    EditTransporteBalsa: TLabeledEdit;
    EditRetencaoIcmsCfop: TLabeledCalcEdit;
    ComboboxModeloNotaFiscal: TLabeledComboBox;
    PageControlTotais: TPageControl;
    tsTotaisGeral: TTabSheet;
    PanelTotais: TPanel;
    EditBCIcms: TLabeledCalcEdit;
    EditValorIcms: TLabeledCalcEdit;
    EditBCIcmsSt: TLabeledCalcEdit;
    EditValorIcmsSt: TLabeledCalcEdit;
    EditValorCOFINS: TLabeledCalcEdit;
    EditValorIPI: TLabeledCalcEdit;
    EditTotalProdutos: TLabeledCalcEdit;
    EditTotalImpostoImportacao: TLabeledCalcEdit;
    EditValorTotalNota: TLabeledCalcEdit;
    EditValorFrete: TLabeledCalcEdit;
    EditValorSeguro: TLabeledCalcEdit;
    EditValorOutrasDespesas: TLabeledCalcEdit;
    EditValorPIS: TLabeledCalcEdit;
    EditValorDesconto: TLabeledCalcEdit;
    tsOutrosTotais: TTabSheet;
    PanelOutrosTotais: TPanel;
    EditBaseCalculoIssqn: TLabeledCalcEdit;
    EditValorIssqn: TLabeledCalcEdit;
    EditValorPisIssqn: TLabeledCalcEdit;
    EditValorCofinsIssqn: TLabeledCalcEdit;
    EditValorRetidoPis: TLabeledCalcEdit;
    EditValorRetidoCofins: TLabeledCalcEdit;
    EditValorRetidoCsll: TLabeledCalcEdit;
    EditValorTotalServicos: TLabeledCalcEdit;
    EditBaseCalculoIrrf: TLabeledCalcEdit;
    EditValorRetidoIrrf: TLabeledCalcEdit;
    EditBaseCalculoPrevidencia: TLabeledCalcEdit;
    EditValorRetidoPrevidencia: TLabeledCalcEdit;
    PanelInformacoesAdicionais: TPanel;
    MemoInfComplementarFisco: TLabeledMemo;
    MemoInfComplementarContribuinte: TLabeledMemo;
    GroupBox2: TGroupBox;
    EditComexLocalEmbarque: TLabeledEdit;
    EditComexUfEmbarque: TLabeledEdit;
    GroupBox3: TGroupBox;
    EditCompraPedido: TLabeledEdit;
    EditCompraNotaEmpenho: TLabeledEdit;
    EditCompraContrato: TLabeledEdit;
    EditEmitenteIEST: TLabeledEdit;
    EditEmitenteIM: TLabeledEdit;
    EditEmitenteCnae: TLabeledEdit;
    ActionToolBar1: TActionToolBar;
    ActionCadastrarProduto: TAction;
    PanelDetalhesAnexo: TPanel;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    GroupBoxLacres: TGroupBox;
    JvDBUltimGrid1: TJvDBUltimGrid;
    ActionIncluirItem: TAction;
    ActionExcluirItem: TAction;
    ActionExcluirDocumentosReferenciados: TAction;
    ActionToolBar2: TActionToolBar;
    ActionToolBar3: TActionToolBar;
    ActionExcluirEntregaRetirada: TAction;
    ActionToolBar4: TActionToolBar;
    ActionExcluirTransporte: TAction;
    ActionToolBar5: TActionToolBar;
    ActionExcluirCobranca: TAction;
    PanelEscrituracao: TPanel;
    EditEscrituracaoCompetencia: TLabeledMaskEdit;
    EditEscrituracaoCfopEntrada: TLabeledCalcEdit;
    EditEscritutacaoValorRateioFrete: TLabeledCalcEdit;
    EditEscritutacaoValorCustoMedio: TLabeledCalcEdit;
    EditEscritutacaoValorIcmsAntecipado: TLabeledCalcEdit;
    EditEscritutacaoValorBcIcmsAntecipado: TLabeledCalcEdit;
    GroupBox4: TGroupBox;
    EditEscritutacaoCstCreditoIcms: TLabeledEdit;
    EditEscritutacaoAliquotaCreditoIcms: TLabeledCalcEdit;
    EditEscritutacaoQuantidadeParcelaCreditoIcms: TLabeledCalcEdit;
    EditEscritutacaoValorBcIcmsCreditado: TLabeledCalcEdit;
    EditEscritutacaoValorIcmsCreditado: TLabeledCalcEdit;
    GroupBox5: TGroupBox;
    EditEscritutacaoValorBcPisCreditado: TLabeledCalcEdit;
    EditEscritutacaoCstCreditoPis: TLabeledEdit;
    EditEscritutacaoValorPisCreditado: TLabeledCalcEdit;
    EditEscritutacaoQuantidadeParcelaCreditoPis: TLabeledCalcEdit;
    EditEscritutacaoAliquotaCreditoPis: TLabeledCalcEdit;
    GroupBox6: TGroupBox;
    EditEscritutacaoValorBcCofinsCreditado: TLabeledCalcEdit;
    EditEscritutacaoCstCreditoCofins: TLabeledEdit;
    EditEscritutacaoValorCofinsCreditado: TLabeledCalcEdit;
    EditEscritutacaoQuantidadeParcelaCreditoCofins: TLabeledCalcEdit;
    EditEscritutacaoAliquotaCreditoCofins: TLabeledCalcEdit;
    GroupBox7: TGroupBox;
    EditEscritutacaoValorBcIpiCreditado: TLabeledCalcEdit;
    EditEscritutacaoCstCreditoIpi: TLabeledEdit;
    EditEscritutacaoValorIpiCreditado: TLabeledCalcEdit;
    EditEscritutacaoQuantidadeParcelaCreditoIpi: TLabeledCalcEdit;
    EditEscritutacaoAliquotaCreditoIpi: TLabeledCalcEdit;
    procedure ActionSelecionarArquivoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ActionCadastrarProdutoExecute(Sender: TObject);
    procedure EditEmitenteIdExit(Sender: TObject);
    procedure EditEmitenteIdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditEmitenteIdKeyPress(Sender: TObject; var Key: Char);
    procedure EditTransportadorIdExit(Sender: TObject);
    procedure EditTransportadorIdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditTransportadorIdKeyPress(Sender: TObject; var Key: Char);
    procedure ActionIncluirItemExecute(Sender: TObject);
    procedure ActionExcluirItemExecute(Sender: TObject);
    procedure ActionExcluirDocumentosReferenciadosExecute(Sender: TObject);
    procedure ActionExcluirEntregaRetiradaExecute(Sender: TObject);
    procedure ActionExcluirTransporteExecute(Sender: TObject);
    procedure ActionExcluirCobrancaExecute(Sender: TObject);
  private
    { Private declarations }
    procedure ConfiguraNFe;
    procedure CarregarDadosXML;
    function VerificarDadosFornecedor: Boolean;
    function VerificarDadosTransportadora: Boolean;
    function VerificarProdutosCadatrados: Boolean;
    procedure LimparCamposEmitente;
    procedure LimparCamposTransportadora;
    procedure ExcluirDadosReferenciados;
    procedure ExcluirDadosEntregaRetirada;
    procedure ExcluirDadosTransporte;
    procedure ExcluirDadosCobranca;
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfiguraLayoutTela;
  end;

var
  FEntradaNF: TFEntradaNF;
  NfeConfiguracaoVO: TNfeConfiguracaoVO;
  SeqItem: Integer;

implementation

uses Biblioteca, UDataModuleNFe, UDataModule, ULookup, NfeCabecalhoController, NfeCabecalhoVO,
  NfeReferenciadaVO, NfeEmitenteVO, NfeLocalEntregaVO, NfeLocalRetiradaVO,
  NfeTransporteVO, NfeFaturaVO, NfeDuplicataVO, NfeDetalheVO, ProdutoLoteVO,
  NfeCupomFiscalReferenciadoVO, NfeDetalheImpostoCofinsVO, NfeDetalheImpostoIcmsVO,
  NfeDetalheImpostoPisVO, NfeDetalheImpostoIiVO, NfeDetalheImpostoIssqnVO,
  NfeDetalheImpostoIpiVO, NfeDeclaracaoImportacaoVO, NfeImportacaoDetalheVO,
  NfeDetEspecificoVeiculoVO, NfeDetEspecificoCombustivelVO, NfeDetEspecificoMedicamentoVO,
  NfeDetEspecificoArmamentoVO, NfeNfReferenciadaVO, NfeCteReferenciadoVO,
  NfeProdRuralReferenciadaVO, NfeTransporteReboqueVO, NfeTransporteVolumeVO,
  ViewPessoaFornecedorVO, ViewPessoaFornecedorController,
  ViewPessoaTransportadoraVO, ViewPessoaTransportadoraController,
  ProdutoVO, ProdutoController, UNfeDetalheAnexo, UProduto,
  NfeDetEspecificoMedicamentoController, NfeDetEspecificoArmamentoController,
  NfeDeclaracaoImportacaoController, FiscalNotaFiscalEntradaVO;
{$R *.dfm}
{ TFEntradaNF }

{$REGION 'Infra'}
procedure TFEntradaNF.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TNfeCabecalhoVO;
  ObjetoController := TNfeCabecalhoController.Create;

  FNFeDetalheAnexo := TFNFeDetalheAnexo.Create(PanelDetalhesAnexo);
  with FNFeDetalheAnexo do
  begin
    Align := alClient;
    BorderStyle := bsNone;
    Parent := PanelDetalhesAnexo;
  end;
  FNFeDetalheAnexo.Show;

  inherited;
  NfeConfiguracaoVO := TNfeConfiguracaoController.VO<TNfeConfiguracaoVO>('ID', '1');
end;

procedure TFEntradaNF.LimparCampos;
begin
  inherited;
  SeqItem := 0;
  FDataModuleNFe.CDSNfeDetalhe.EmptyDataSet;
  FDataModuleNFe.CDSNfeReferenciada.EmptyDataSet;
  FDataModuleNFe.CDSCupomReferenciado.EmptyDataSet;
  FDataModuleNFe.CDSNfeDeclaracaoImportacao.EmptyDataSet;
  FDataModuleNFe.CDSNfeImportacaoDetalhe.EmptyDataSet;
  FDataModuleNFe.CDSNfRuralReferenciada.EmptyDataSet;
  FDataModuleNFe.CDSCteReferenciado.EmptyDataSet;
  FDataModuleNFe.CDSDuplicata.EmptyDataSet;
  FDataModuleNFe.CDSNfeDetalheVeiculo.EmptyDataSet;
  FDataModuleNFe.CDSNfeDetalheArmamento.EmptyDataSet;
  FDataModuleNFe.CDSVolumes.EmptyDataSet;
  FDataModuleNFe.CDSNfReferenciada.EmptyDataSet;
  FDataModuleNFe.CDSReboque.EmptyDataSet;
  FDataModuleNFe.CDSNfeDetalheCombustivel.EmptyDataSet;
  FDataModuleNFe.CDSNfeDetalheMedicamento.EmptyDataSet;
  FDataModuleNFe.CDSNfeImpostoCofins.EmptyDataSet;
  FDataModuleNFe.CDSNfeImpostoIcms.EmptyDataSet;
  FDataModuleNFe.CDSNfeImpostoImportacao.EmptyDataSet;
  FDataModuleNFe.CDSVolumesLacres.EmptyDataSet;
  FDataModuleNFe.CDSNfeImpostoIpi.EmptyDataSet;
  FDataModuleNFe.CDSNfeImpostoIssqn.EmptyDataSet;
  FDataModuleNFe.CDSNfeImpostoPis.EmptyDataSet;
  ConfiguraLayoutTela;
end;

procedure TFEntradaNF.LimparCamposEmitente;
begin
  EditEmitenteCpfCnpj.Clear;
  EditEmitenteRazao.Clear;
  EditEmitenteFantasia.Clear;
  EditEmitenteLogradouro.Clear;
  EditEmitenteNumero.Clear;
  EditEmitenteComplemento.Clear;
  EditEmitenteBairro.Clear;
  EditEmitenteCodigoIbge.Clear;
  EditEmitenteCidade.Clear;
  EditEmitenteUF.Clear;
  EditEmitenteCEP.Clear;
  EditEmitenteTelefone.Clear;
  EditEmitenteIE.Clear;
  EditEmitenteIEST.Clear;
  EditEmitenteIM.Clear;;
  EditEmitenteCnae.Clear;
  EditEmitenteEmail.Clear;
end;

procedure TFEntradaNF.LimparCamposTransportadora;
begin
  EditTransportadorCpfCnpj.Clear;
  EditTransportadorRazaoSocial.Clear;
  EditTransportadorIE.Clear;
  EditTransportadorLogradouro.Clear;
  EditTransportadorCidade.Clear;
  EditTransportadorUF.Clear;
end;

procedure TFEntradaNF.ConfiguraLayoutTela;
begin
  PageControlEdits.ActivePageIndex := 0;
end;

procedure TFEntradaNF.ConfiguraNFe;
begin
  if NfeConfiguracaoVO.SalvarXml = 'S' then
    FDataModule.ACBrNFe.Configuracoes.Geral.Salvar := True
  else
    FDataModule.ACBrNFe.Configuracoes.Geral.Salvar := False;

  FDataModule.ACBrNFe.Configuracoes.WebServices.Uf := NfeConfiguracaoVO.WebserviceUf;

  if NfeConfiguracaoVO.WebserviceAmbiente = '1' then
    FDataModule.ACBrNFe.Configuracoes.WebServices.Ambiente := taProducao
  else
    FDataModule.ACBrNFe.Configuracoes.WebServices.Ambiente := taHomologacao;

  if NfeConfiguracaoVO.WebserviceVisualizar = 'S' then
    FDataModule.ACBrNFe.Configuracoes.WebServices.Visualizar := True
  else
    FDataModule.ACBrNFe.Configuracoes.WebServices.Visualizar := False;

  FDataModule.ACBrNFe.Configuracoes.Geral.PathSalvar := NfeConfiguracaoVO.CaminhoSalvarXml;
  FDataModule.ACBrNFe.Configuracoes.Geral.PathSchemas := NfeConfiguracaoVO.CaminhoSchemas;
  FDataModule.ACBrNFeDanfeRave.RavFile := NfeConfiguracaoVO.CaminhoArquivoDanfe;
  FDataModule.ACBrNFeDanfeRave.PathPDF := NfeConfiguracaoVO.CaminhoSalvarPdf;
end;

procedure TFEntradaNF.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFEntradaNF.ControlaPopupMenu;
begin
  inherited;

  menuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFEntradaNF.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    ConfiguraNFe;
    ComboboxModeloNotaFiscal.SetFocus;
    ActionSelecionarArquivo.Enabled := True;
  end;
end;

function TFEntradaNF.DoEditar: Boolean;
begin
  ConfiguraNFe;

  Result := inherited DoEditar;

  if Result then
  begin
    SeqItem := FDataModuleNFe.CDSNfeDetalhe.RecordCount;
    ComboboxModeloNotaFiscal.SetFocus;
  end;
end;

function TFEntradaNF.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TNfeCabecalhoController(ObjetoController).Exclui(IdRegistroSelecionado, 'CABECALHO');
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TNfeCabecalhoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFEntradaNF.DoSalvar: Boolean;
var
  NfeReferenciada: TNfeReferenciadaVO;
  NfeNfReferenciada: TNfeNfReferenciadaVO;
  NfeCteReferenciado: TNfeCteReferenciadoVO;
  NfeCupomFiscalReferenciado: TNfeCupomFiscalReferenciadoVO;
  NfeRuralReferenciada: TNfeProdRuralReferenciadaVO;
  NfeDetalhe: TNfeDetalheVO;
  NfeDeclaracaoImportacao: TNfeDeclaracaoImportacaoVO;
  NfeImportacaoDetalhe: TNfeImportacaoDetalheVO;
  NfeDetalheMedicamento: TNfeDetEspecificoMedicamentoVO;
  NfeDetalheArmamento: TNfeDetEspecificoArmamentoVO;
  NfeTransporteReboque: TNfeTransporteReboqueVO;
  NfeTransporteVolume: TNfeTransporteVolumeVO;
  NfeDuplicata: TNfeDuplicataVO;
begin
  if ComboboxModeloNotaFiscal.ItemIndex = 1 then
  begin
    if (Trim(EditNumeroNfe.Text) = '') or (Trim(EditChaveAcesso.Text) = '') then
    begin
      Application.MessageBox('Número da nota ou chave de acesso não podem ficar em branco.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      Exit(False);
    end;
  end;

  if not VerificarDadosFornecedor then
  begin
    Application.MessageBox('É necessário cadastrar o Fornecedor.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    Exit(False);
  end;

  if Trim(EditTransportadorCpfCnpj.Text) <> '' then
  begin
    if not VerificarDadosTransportadora then
    begin
      Application.MessageBox('É necessário cadastrar a Transportadora.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      Exit(False);
    end;
  end;

  if not VerificarProdutosCadatrados then
  begin
    Application.MessageBox('Existem produtos não cadastrados.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    Exit(False);
  end;

  Result := inherited DoSalvar;

  DecimalSeparator := '.';

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TNfeCabecalhoVO.Create;

      TNfeCabecalhoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TNfeCabecalhoVO(ObjetoVO).IdFornecedor := EditEmitenteId.AsInteger;
      TNfeCabecalhoVO(ObjetoVO).UfEmitente := UFToInt(EditEmitenteUF.Text);
      TNfeCabecalhoVO(ObjetoVO).CodigoNumerico := EditCodigoNumerico.Text;
      TNfeCabecalhoVO(ObjetoVO).NaturezaOperacao := EditNaturezaOperacao.Text;
      TNfeCabecalhoVO(ObjetoVO).IndicadorFormaPagamento := IntToStr(ComboBoxFormaPagamento.ItemIndex);
      TNfeCabecalhoVO(ObjetoVO).CodigoModelo := Copy(ComboboxModeloNotaFiscal.Text, 1, 2);
      TNfeCabecalhoVO(ObjetoVO).Serie := EditSerie.Text;
      TNfeCabecalhoVO(ObjetoVO).Numero := EditNumeroNfe.Text;
      TNfeCabecalhoVO(ObjetoVO).DataEmissao := EditDataEmissao.Date;
      TNfeCabecalhoVO(ObjetoVO).DataEntradaSaida := EditDataEntradaSaida.Date;
      TNfeCabecalhoVO(ObjetoVO).HoraEntradaSaida := EditHoraEntradaSaida.Text;
      TNfeCabecalhoVO(ObjetoVO).TipoOperacao := IntToStr(ComboTipoOperacao.ItemIndex);
      TNfeCabecalhoVO(ObjetoVO).CodigoMunicipio := EditEmitenteCodigoIbge.AsInteger;
      TNfeCabecalhoVO(ObjetoVO).FormatoImpressaoDanfe := IntToStr(ComboFormaImpDanfe.ItemIndex + 1);
      TNfeCabecalhoVO(ObjetoVO).TipoEmissao := IntToStr(ComboTipoEmissao.ItemIndex + 1);
      TNfeCabecalhoVO(ObjetoVO).ChaveAcesso := EditChaveAcesso.Text;
      TNfeCabecalhoVO(ObjetoVO).DigitoChaveAcesso := EditDigitoChaveAcesso.Text;
      TNfeCabecalhoVO(ObjetoVO).Ambiente := NfeConfiguracaoVO.WebserviceAmbiente;
      TNfeCabecalhoVO(ObjetoVO).FinalidadeEmissao := IntToStr(ComboFinalidadeEmissao.ItemIndex + 1);
      TNfeCabecalhoVO(ObjetoVO).ProcessoEmissao := NfeConfiguracaoVO.ProcessoEmissao;
      TNfeCabecalhoVO(ObjetoVO).VersaoProcessoEmissao := NfeConfiguracaoVO.VersaoProcessoEmissao;
      TNfeCabecalhoVO(ObjetoVO).BaseCalculoIcms := EditBCIcms.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorIcms := EditValorIcms.Value;
      TNfeCabecalhoVO(ObjetoVO).BaseCalculoIcmsSt := EditBCIcmsSt.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorIcmsSt := EditValorIcmsSt.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorTotalProdutos := EditTotalProdutos.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorFrete := EditValorFrete.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorSeguro := EditValorSeguro.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorDesconto := EditValorDesconto.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorImpostoImportacao := EditTotalImpostoImportacao.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorIpi := EditValorIPI.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorPis := EditValorPIS.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorCofins := EditValorCOFINS.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorDespesasAcessorias := EditValorOutrasDespesas.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorTotal := EditValorTotalNota.Value;

      TNfeCabecalhoVO(ObjetoVO).ValorServicos := EditValorTotalServicos.Value;
      TNfeCabecalhoVO(ObjetoVO).BaseCalculoIssqn := EditBaseCalculoIssqn.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorIssqn := EditValorIssqn.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorPisIssqn := EditValorPisIssqn.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorCofinsIssqn := EditValorCofinsIssqn.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorRetidoPis := EditValorRetidoPis.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorRetidoCofins := EditValorRetidoCofins.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorRetidoCsll := EditValorRetidoCsll.Value;
      TNfeCabecalhoVO(ObjetoVO).BaseCalculoIrrf := EditBaseCalculoIrrf.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorRetidoIrrf := EditValorRetidoIrrf.Value;
      TNfeCabecalhoVO(ObjetoVO).BaseCalculoPrevidencia := EditBaseCalculoPrevidencia.Value;
      TNfeCabecalhoVO(ObjetoVO).ValorRetidoPrevidencia := EditValorRetidoPrevidencia.Value;
      TNfeCabecalhoVO(ObjetoVO).ComexUfEmbarque := EditComexUfEmbarque.Text;
      TNfeCabecalhoVO(ObjetoVO).ComexLocalEmbarque := EditComexLocalEmbarque.Text;
      TNfeCabecalhoVO(ObjetoVO).CompraNotaEmpenho := EditCompraNotaEmpenho.Text;
      TNfeCabecalhoVO(ObjetoVO).CompraPedido := EditCompraPedido.Text;
      TNfeCabecalhoVO(ObjetoVO).CompraContrato := EditCompraContrato.Text;

      TNfeCabecalhoVO(ObjetoVO).InformacoesAddFisco := MemoInfComplementarFisco.Text;
      TNfeCabecalhoVO(ObjetoVO).InformacoesAddContribuinte := MemoInfComplementarContribuinte.Text;

      if StatusTela = stEditando then
        TNfeCabecalhoVO(ObjetoVO).Id := IdRegistroSelecionado;

      { Emitente }
      if StatusTela = stInserindo then
        TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO := TNfeEmitenteVO.Create;

      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.CpfCnpj := EditEmitenteCpfCnpj.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.RazaoSocial := EditEmitenteRazao.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Fantasia := EditEmitenteFantasia.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Logradouro := EditEmitenteLogradouro.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Numero := EditEmitenteNumero.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Complemento := EditEmitenteComplemento.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Bairro := EditEmitenteBairro.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.CodigoMunicipio := EditEmitenteCodigoIbge.AsInteger;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.NomeMunicipio := EditEmitenteCidade.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Uf := EditEmitenteUF.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Cep := EditEmitenteCEP.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.CodigoPais := 1058;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.NomePais := 'Brazil';
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Telefone := EditEmitenteTelefone.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.InscricaoEstadual := EditEmitenteIE.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.InscricaoEstadualSt := EditEmitenteIEST.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.InscricaoMunicipal := EditEmitenteIM.Text;;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Cnae := EditEmitenteCnae.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Crt := IntToStr(ComboEmitenteCrt.ItemIndex + 1);
      TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Email := EditEmitenteEmail.Text;

      if StatusTela = stEditando then
      begin
        if TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.ToJSONString = TNfeCabecalhoVO(ObjetoOldVO).NfeEmitenteVO.ToJSONString then
        begin
          TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO := Nil;
          TNfeCabecalhoVO(ObjetoOldVO).NfeEmitenteVO := Nil;
        end
        else
          TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.IdNfeCabecalho := TNfeCabecalhoVO(ObjetoVO).Id;
      end;

      { NfeDetalhe }
      TNfeCabecalhoVO(ObjetoVO).ListaNfeDetalheVO := TObjectList<TNfeDetalheVO>.Create;
      //FDataModuleNFe.CDSNfeDetalhe.DisableControls; - se for habilitado deverá filtrar os dados dos detalhes em anexo
      FDataModuleNFe.CDSNfeDetalhe.First;
      while not FDataModuleNFe.CDSNfeDetalhe.Eof do
      begin
        NfeDetalhe := TNfeDetalheVO.Create;
        NfeDetalhe.IdNfeCabecalho := TNfeCabecalhoVO(ObjetoVO).Id;
        if FDataModuleNFe.CDSNfeDetalhe.FieldByName('PERSISTE').AsString  = 'I' then
          NfeDetalhe.Id := 0
        else
          NfeDetalhe.Id := FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger;
        NfeDetalhe.IdProduto := FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID_PRODUTO').AsInteger;
        NfeDetalhe.NumeroItem := FDataModuleNFe.CDSNfeDetalhe.FieldByName('NUMERO_ITEM').AsInteger;
        NfeDetalhe.CodigoProduto := FDataModuleNFe.CDSNfeDetalhe.FieldByName('CODIGO_PRODUTO').AsString;
        NfeDetalhe.Gtin := FDataModuleNFe.CDSNfeDetalhe.FieldByName('GTIN').AsString;
        NfeDetalhe.NomeProduto := FDataModuleNFe.CDSNfeDetalhe.FieldByName('NOME_PRODUTO').AsString;
        NfeDetalhe.Ncm := FDataModuleNFe.CDSNfeDetalhe.FieldByName('NCM').AsString;
        NfeDetalhe.ExTipi := FDataModuleNFe.CDSNfeDetalhe.FieldByName('EX_TIPI').AsInteger;
        NfeDetalhe.Cfop := FDataModuleNFe.CDSNfeDetalhe.FieldByName('CFOP').AsInteger;
        NfeDetalhe.UnidadeComercial := FDataModuleNFe.CDSNfeDetalhe.FieldByName('UNIDADE_COMERCIAL').AsString;
        NfeDetalhe.QuantidadeComercial := FDataModuleNFe.CDSNfeDetalhe.FieldByName('QUANTIDADE_COMERCIAL').AsExtended;
        NfeDetalhe.ValorUnitarioComercial := FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_UNITARIO_COMERCIAL').AsExtended;
        NfeDetalhe.ValorBrutoProduto := FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_BRUTO_PRODUTO').AsExtended;
        NfeDetalhe.GtinUnidadeTributavel := FDataModuleNFe.CDSNfeDetalhe.FieldByName('GTIN_UNIDADE_TRIBUTAVEL').AsString; ;
        NfeDetalhe.UnidadeTributavel := FDataModuleNFe.CDSNfeDetalhe.FieldByName('UNIDADE_TRIBUTAVEL').AsString;
        NfeDetalhe.QuantidadeTributavel := FDataModuleNFe.CDSNfeDetalhe.FieldByName('QUANTIDADE_TRIBUTAVEL').AsExtended;
        NfeDetalhe.ValorUnitarioTributavel := FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_UNITARIO_TRIBUTAVEL').AsExtended;
        NfeDetalhe.ValorFrete := FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_FRETE').AsExtended;
        NfeDetalhe.ValorSeguro := FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_SEGURO').AsExtended;
        NfeDetalhe.ValorDesconto := FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_DESCONTO').AsExtended;
        NfeDetalhe.ValorOutrasDespesas := FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_OUTRAS_DESPESAS').AsExtended;
        NfeDetalhe.EntraTotal := FDataModuleNFe.CDSNfeDetalhe.FieldByName('ENTRA_TOTAL').AsString;
        NfeDetalhe.ValorSubtotal := FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_SUBTOTAL').AsExtended;
        NfeDetalhe.ValorTotal := FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_TOTAL').AsExtended;
        NfeDetalhe.InformacoesAdicionais := FDataModuleNFe.CDSNfeDetalhe.FieldByName('INFORMACOES_ADICIONAIS').AsString;

        { NfeDetalhe - Imposto - ICMS }
        if FDataModuleNFe.CDSNfeImpostoIcms.RecordCount > 0 then
        begin
          if FDataModuleNFe.CDSNfeImpostoIcms.Locate('ID_NFE_DETALHE', FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger, [loPartialKey]) then
          begin
            NfeDetalhe.NfeDetalheImpostoIcmsVO := TNfeDetalheImpostoIcmsVO.Create;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.Id := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ID').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.IdNfeDetalhe := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.OrigemMercadoria := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ORIGEM_MERCADORIA').AsString;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.CstIcms := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('CST_ICMS').AsString;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.Csosn := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('CSOSN').AsString;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.ModalidadeBcIcms := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('MODALIDADE_BC_ICMS').AsString;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.TaxaReducaoBcIcms := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('TAXA_REDUCAO_BC_ICMS').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.BaseCalculoIcms := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('BASE_CALCULO_ICMS').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.AliquotaIcms := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ALIQUOTA_ICMS').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.ValorIcms := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.MotivoDesoneracaoIcms := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('MOTIVO_DESONERACAO_ICMS').AsString;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.ModalidadeBcIcmsSt := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('MODALIDADE_BC_ICMS_ST').AsString;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.PercentualMvaIcmsSt := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('PERCENTUAL_MVA_ICMS_ST').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.PercentualReducaoBcIcmsSt := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('PERCENTUAL_REDUCAO_BC_ICMS_ST').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.ValorBaseCalculoIcmsSt := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_BASE_CALCULO_ICMS_ST').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.AliquotaIcmsSt := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ALIQUOTA_ICMS_ST').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.ValorIcmsSt := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS_ST').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.ValorBcIcmsStRetido := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_BC_ICMS_ST_RETIDO').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.ValorIcmsStRetido := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS_ST_RETIDO').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.ValorBcIcmsStDestino := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_BC_ICMS_ST_DESTINO').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.ValorIcmsStDestino := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS_ST_DESTINO').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.AliquotaCreditoIcmsSn := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ALIQUOTA_CREDITO_ICMS_SN').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.ValorCreditoIcmsSn := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_CREDITO_ICMS_SN').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.PercentualBcOperacaoPropria := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('PERCENTUAL_BC_OPERACAO_PROPRIA').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIcmsVO.UfSt := FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('UF_ST').AsString;
          end;
        end;

        { NfeDetalhe - Imposto - ISSQN }
        if FDataModuleNFe.CDSNfeImpostoIssqn.RecordCount > 0 then
        begin
          if FDataModuleNFe.CDSNfeImpostoIssqn.Locate('ID_NFE_DETALHE', FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger, [loPartialKey]) then
          begin
            NfeDetalhe.NfeDetalheImpostoIssqnVO := TNfeDetalheImpostoIssqnVO.Create;
            NfeDetalhe.NfeDetalheImpostoIssqnVO.Id := FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ID').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIssqnVO.IdNfeDetalhe := FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIssqnVO.BaseCalculoIssqn := FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('BASE_CALCULO_ISSQN').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIssqnVO.AliquotaIssqn := FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ALIQUOTA_ISSQN').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIssqnVO.ValorIssqn := FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('VALOR_ISSQN').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIssqnVO.MunicipioIssqn := FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('MUNICIPIO_ISSQN').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIssqnVO.ItemListaServicos := FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ITEM_LISTA_SERVICOS').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIssqnVO.TributacaoIssqn := FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('TRIBUTACAO_ISSQN').AsString;
          end;
        end;

        { NfeDetalhe - Imposto - IPI }
        if FDataModuleNFe.CDSNfeImpostoIpi.RecordCount > 0 then
        begin
          if FDataModuleNFe.CDSNfeImpostoIpi.Locate('ID_NFE_DETALHE', FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger, [loPartialKey]) then
          begin
            NfeDetalhe.NfeDetalheImpostoIpiVO := TNfeDetalheImpostoIpiVO.Create;
            NfeDetalhe.NfeDetalheImpostoIpiVO.Id := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ID').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIpiVO.IdNfeDetalhe := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIpiVO.EnquadramentoIpi := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ENQUADRAMENTO_IPI').AsString;
            NfeDetalhe.NfeDetalheImpostoIpiVO.CnpjProdutor := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('CNPJ_PRODUTOR').AsString;
            NfeDetalhe.NfeDetalheImpostoIpiVO.CodigoSeloIpi := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('CODIGO_SELO_IPI').AsString;
            NfeDetalhe.NfeDetalheImpostoIpiVO.QuantidadeSeloIpi := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('QUANTIDADE_SELO_IPI').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIpiVO.EnquadramentoLegalIpi := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ENQUADRAMENTO_LEGAL_IPI').AsString;
            NfeDetalhe.NfeDetalheImpostoIpiVO.CstIpi := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('CST_IPI').AsString;
            NfeDetalhe.NfeDetalheImpostoIpiVO.ValorBaseCalculoIpi := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('VALOR_BASE_CALCULO_IPI').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIpiVO.AliquotaIpi := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ALIQUOTA_IPI').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIpiVO.QuantidadeUnidadeTributavel := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('QUANTIDADE_UNIDADE_TRIBUTAVEL').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIpiVO.ValorUnidadeTributavel := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('VALOR_UNIDADE_TRIBUTAVEL').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIpiVO.ValorIpi := FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('VALOR_IPI').AsExtended;
          end;
        end;

        { NfeDetalhe - Imposto - II }
        if FDataModuleNFe.CDSNfeImpostoImportacao.RecordCount > 0 then
        begin
          if FDataModuleNFe.CDSNfeImpostoImportacao.Locate('ID_NFE_DETALHE', FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger, [loPartialKey]) then
          begin
            NfeDetalhe.NfeDetalheImpostoIiVO := TNfeDetalheImpostoIiVO.Create;
            NfeDetalhe.NfeDetalheImpostoIiVO.Id := FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('ID').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIiVO.IdNfeDetalhe := FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDetalhe.NfeDetalheImpostoIiVO.ValorBcIi := FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_BC_II').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIiVO.ValorDespesasAduaneiras := FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_DESPESAS_ADUANEIRAS').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIiVO.ValorImpostoImportacao := FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_IMPOSTO_IMPORTACAO').AsExtended;
            NfeDetalhe.NfeDetalheImpostoIiVO.ValorIof := FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_IOF').AsExtended;
          end;
        end;

        { NfeDetalhe - Imposto - PIS }
        if FDataModuleNFe.CDSNfeImpostoPis.RecordCount > 0 then
        begin
          if FDataModuleNFe.CDSNfeImpostoPis.Locate('ID_NFE_DETALHE', FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger, [loPartialKey]) then
          begin
            NfeDetalhe.NfeDetalheImpostoPisVO := TNfeDetalheImpostoPisVO.Create;
            NfeDetalhe.NfeDetalheImpostoPisVO.Id := FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ID').AsInteger;
            NfeDetalhe.NfeDetalheImpostoPisVO.IdNfeDetalhe := FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDetalhe.NfeDetalheImpostoPisVO.CstPis := FDataModuleNFe.CDSNfeImpostoPis.FieldByName('CST_PIS').AsString;
            NfeDetalhe.NfeDetalheImpostoPisVO.QuantidadeVendida := FDataModuleNFe.CDSNfeImpostoPis.FieldByName('QUANTIDADE_VENDIDA').AsExtended;
            NfeDetalhe.NfeDetalheImpostoPisVO.ValorBaseCalculoPis := FDataModuleNFe.CDSNfeImpostoPis.FieldByName('VALOR_BASE_CALCULO_PIS').AsExtended;
            NfeDetalhe.NfeDetalheImpostoPisVO.AliquotaPisPercentual := FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ALIQUOTA_PIS_PERCENTUAL').AsExtended;
            NfeDetalhe.NfeDetalheImpostoPisVO.AliquotaPisReais := FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ALIQUOTA_PIS_REAIS').AsExtended;
            NfeDetalhe.NfeDetalheImpostoPisVO.ValorPis := FDataModuleNFe.CDSNfeImpostoPis.FieldByName('VALOR_PIS').AsExtended;
          end;
        end;

        { NfeDetalhe - Imposto - COFINS }
        if FDataModuleNFe.CDSNfeImpostoCofins.RecordCount > 0 then
        begin
          if FDataModuleNFe.CDSNfeImpostoCofins.Locate('ID_NFE_DETALHE', FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger, [loPartialKey]) then
          begin
            NfeDetalhe.NfeDetalheImpostoCofinsVO := TNfeDetalheImpostoCofinsVO.Create;
            NfeDetalhe.NfeDetalheImpostoCofinsVO.Id := FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ID').AsInteger;
            NfeDetalhe.NfeDetalheImpostoCofinsVO.IdNfeDetalhe := FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDetalhe.NfeDetalheImpostoCofinsVO.CstCofins := FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('CST_COFINS').AsString;
            NfeDetalhe.NfeDetalheImpostoCofinsVO.QuantidadeVendida := FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('QUANTIDADE_VENDIDA').AsExtended;
            NfeDetalhe.NfeDetalheImpostoCofinsVO.BaseCalculoCofins := FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('BASE_CALCULO_COFINS').AsExtended;
            NfeDetalhe.NfeDetalheImpostoCofinsVO.AliquotaCofinsPercentual := FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ALIQUOTA_COFINS_PERCENTUAL').AsExtended;
            NfeDetalhe.NfeDetalheImpostoCofinsVO.AliquotaCofinsReais := FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ALIQUOTA_COFINS_REAIS').AsExtended;
            NfeDetalhe.NfeDetalheImpostoCofinsVO.ValorCofins := FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('VALOR_COFINS').AsExtended;
          end;
        end;

        { NfeDetalhe - Declaração Importação }
        NfeDetalhe.ListaNfeDeclaracaoImportacaoVO := TObjectList<TNfeDeclaracaoImportacaoVO>.Create;

        if FDataModuleNFe.CDSNfeDeclaracaoImportacao.RecordCount > 0 then
        begin
          FDataModuleNFe.CDSNfeDeclaracaoImportacao.DisableControls;
          FDataModuleNFe.CDSNfeDeclaracaoImportacao.First;
          while not FDataModuleNFe.CDSNfeDeclaracaoImportacao.Eof do
          begin
            NfeDeclaracaoImportacao := TNfeDeclaracaoImportacaoVO.Create;

            NfeDeclaracaoImportacao.Id := FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('ID').AsInteger;
            NfeDeclaracaoImportacao.IdNfeDetalhe := FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDeclaracaoImportacao.NumeroDocumento := FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('NUMERO_DOCUMENTO').AsString;
            NfeDeclaracaoImportacao.DataRegistro := FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('DATA_REGISTRO').AsDateTime;
            NfeDeclaracaoImportacao.LocalDesembaraco := FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('LOCAL_DESEMBARACO').AsString;
            NfeDeclaracaoImportacao.UfDesembaraco := FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('UF_DESEMBARACO').AsString;
            NfeDeclaracaoImportacao.DataDesembaraco := FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('DATA_DESEMBARACO').AsDateTime;
            NfeDeclaracaoImportacao.UfDesembaraco := FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('UF_DESEMBARACO').AsString;

            { NfeDetalhe - Declaração Importação - Adições }
            NfeDeclaracaoImportacao.ListaNfeImportacaoDetalheVO := TObjectList<TNfeImportacaoDetalheVO>.Create;

            if FDataModuleNFe.CDSNfeImportacaoDetalhe.RecordCount > 0 then
            begin
              FDataModuleNFe.CDSNfeImportacaoDetalhe.DisableControls;
              FDataModuleNFe.CDSNfeImportacaoDetalhe.First;
              while not FDataModuleNFe.CDSNfeImportacaoDetalhe.Eof do
              begin
                NfeImportacaoDetalhe := TNfeImportacaoDetalheVO.Create;

                NfeImportacaoDetalhe.Id := FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('ID').AsInteger;
                NfeImportacaoDetalhe.IdNfeDeclaracaoImportacao := FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('ID_NFE_DECLARACAO_IMPORTACAO').AsInteger;
                NfeImportacaoDetalhe.NumeroAdicao := FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('NUMERO_ADICAO').AsInteger;
                NfeImportacaoDetalhe.NumeroSequencial := FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('NUMERO_SEQUENCIAL').AsInteger;
                NfeImportacaoDetalhe.CodigoFabricanteEstrangeiro := FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('CODIGO_FABRICANTE_ESTRANGEIRO').AsString;
                NfeImportacaoDetalhe.ValorDesconto := FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('VALOR_DESCONTO').AsExtended;

                NfeDeclaracaoImportacao.ListaNfeImportacaoDetalheVO.Add(NfeImportacaoDetalhe);
                FDataModuleNFe.CDSNfeImportacaoDetalhe.Next;
              end;
            end;

            NfeDetalhe.ListaNfeDeclaracaoImportacaoVO.Add(NfeDeclaracaoImportacao);
            FDataModuleNFe.CDSNfeDeclaracaoImportacao.Next;
          end;
          FDataModuleNFe.CDSNfeDeclaracaoImportacao.First;
          FDataModuleNFe.CDSNfeDeclaracaoImportacao.EnableControls;
        end;

        { NfeDetalhe - Específico - Veículo }
        if FDataModuleNFe.CDSNfeDetalheVeiculo.RecordCount > 0 then
        begin
          if FDataModuleNFe.CDSNfeDetalheVeiculo.Locate('ID_NFE_DETALHE', FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger, [loPartialKey]) then
          begin
            NfeDetalhe.NfeDetEspecificoVeiculoVO := TNfeDetEspecificoVeiculoVO.Create;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.Id := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ID').AsInteger;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.IdNfeDetalhe := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.TipoOperacao := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_OPERACAO').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.Chassi := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CHASSI').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.Cor := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('COR').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.DescricaoCor := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('DESCRICAO_COR').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.PotenciaMotor := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('POTENCIA_MOTOR').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.Cilindradas := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CILINDRADAS').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.PesoLiquido := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('PESO_LIQUIDO').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.PesoBruto := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('PESO_BRUTO').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.NumeroSerie := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('NUMERO_SERIE').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.TipoCombustivel := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_COMBUSTIVEL').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.NumeroMotor := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('NUMERO_MOTOR').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.CapacidadeMaximaTracao := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CAPACIDADE_MAXIMA_TRACAO').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.DistanciaEixos := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('DISTANCIA_EIXOS').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.AnoModelo := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ANO_MODELO').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.AnoFabricacao := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ANO_FABRICACAO').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.TipoPintura := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_PINTURA').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.TipoVeiculo := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_VEICULO').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.EspecieVeiculo := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ESPECIE_VEICULO').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.CondicaoVin := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CONDICAO_VIN').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.CondicaoVeiculo := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CONDICAO_VEICULO').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.CodigoMarcaModelo := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CODIGO_MARCA_MODELO').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.CodigoCor := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CODIGO_COR').AsString;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.Lotacao := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('LOTACAO').AsInteger;
            NfeDetalhe.NfeDetEspecificoVeiculoVO.Restricao := FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('RESTRICAO').AsString;
          end;
        end;

        { NfeDetalhe - Específico - Combustível }
        if FDataModuleNFe.CDSNfeDetalheCombustivel.RecordCount > 0 then
        begin
          if FDataModuleNFe.CDSNfeDetalheCombustivel.Locate('ID_NFE_DETALHE', FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger, [loPartialKey]) then
          begin
            NfeDetalhe.NfeDetEspecificoCombustivelVO := TNfeDetEspecificoCombustivelVO.Create;
            NfeDetalhe.NfeDetEspecificoCombustivelVO.Id := FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('ID').AsInteger;
            NfeDetalhe.NfeDetEspecificoCombustivelVO.IdNfeDetalhe := FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDetalhe.NfeDetEspecificoCombustivelVO.CodigoAnp := FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('CODIGO_ANP').AsInteger;
            NfeDetalhe.NfeDetEspecificoCombustivelVO.Codif := FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('CODIF').AsString;
            NfeDetalhe.NfeDetEspecificoCombustivelVO.QuantidadeTempAmbiente := FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('QUANTIDADE_TEMP_AMBIENTE').AsExtended;
            NfeDetalhe.NfeDetEspecificoCombustivelVO.UfConsumo := FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('UF_CONSUMO').AsString;
            NfeDetalhe.NfeDetEspecificoCombustivelVO.BaseCalculoCide := FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('BASE_CALCULO_CIDE').AsExtended;
            NfeDetalhe.NfeDetEspecificoCombustivelVO.AliquotaCide := FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('ALIQUOTA_CIDE').AsExtended;
            NfeDetalhe.NfeDetEspecificoCombustivelVO.ValorCide := FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('VALOR_CIDE').AsExtended;
          end;
        end;

        { NfeDetalhe - Específico - Medicamento }
        NfeDetalhe.ListaNfeDetEspecificoMedicamentoVO := TObjectList<TNfeDetEspecificoMedicamentoVO>.Create;

        if FDataModuleNFe.CDSNfeDetalheMedicamento.RecordCount > 0 then
        begin
          FDataModuleNFe.CDSNfeDetalheMedicamento.DisableControls;
          FDataModuleNFe.CDSNfeDetalheMedicamento.First;
          while not FDataModuleNFe.CDSNfeDetalheMedicamento.Eof do
          begin
            NfeDetalheMedicamento := TNfeDetEspecificoMedicamentoVO.Create;

            NfeDetalheMedicamento.Id := FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('ID').AsInteger;
            NfeDetalheMedicamento.IdNfeDetalhe := FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDetalheMedicamento.NumeroLote := FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('NUMERO_LOTE').AsString;
            NfeDetalheMedicamento.QuantidadeLote := FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('QUANTIDADE_LOTE').AsExtended;
            NfeDetalheMedicamento.DataFabricacao := FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('DATA_FABRICACAO').AsDateTime;
            NfeDetalheMedicamento.DataValidade := FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('DATA_VALIDADE').AsDateTime;
            NfeDetalheMedicamento.PrecoMaximoConsumidor := FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('PRECO_MAXIMO_CONSUMIDOR').AsExtended;

            NfeDetalhe.ListaNfeDetEspecificoMedicamentoVO.Add(NfeDetalheMedicamento);
            FDataModuleNFe.CDSNfeDetalheMedicamento.Next;
          end;
          FDataModuleNFe.CDSNfeDetalheMedicamento.First;
          FDataModuleNFe.CDSNfeDetalheMedicamento.EnableControls;
        end;

        { NfeDetalhe - Específico - Armamento }
        NfeDetalhe.ListaNfeDetEspecificoArmamentoVO := TObjectList<TNfeDetEspecificoArmamentoVO>.Create;

        if FDataModuleNFe.CDSNfeDetalheArmamento.RecordCount > 0 then
        begin
          FDataModuleNFe.CDSNfeDetalheArmamento.DisableControls;
          FDataModuleNFe.CDSNfeDetalheArmamento.First;
          while not FDataModuleNFe.CDSNfeDetalheArmamento.Eof do
          begin
            NfeDetalheArmamento := TNfeDetEspecificoArmamentoVO.Create;

            NfeDetalheArmamento.Id := FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('ID').AsInteger;
            NfeDetalheArmamento.IdNfeDetalhe := FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('ID_NFE_DETALHE').AsInteger;
            NfeDetalheArmamento.TipoArma := FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('TIPO_ARMA').AsString;
            NfeDetalheArmamento.NumeroSerieArma := FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('NUMERO_SERIE_ARMA').AsString;
            NfeDetalheArmamento.NumeroSerieCano := FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('NUMERO_SERIE_CANO').AsString;
            NfeDetalheArmamento.Descricao := FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('DESCRICAO').AsString;

            NfeDetalhe.ListaNfeDetEspecificoArmamentoVO.Add(NfeDetalheArmamento);
            FDataModuleNFe.CDSNfeDetalheArmamento.Next;
          end;
          FDataModuleNFe.CDSNfeDetalheArmamento.First;
          FDataModuleNFe.CDSNfeDetalheArmamento.EnableControls;
        end;

        TNfeCabecalhoVO(ObjetoVO).ListaNfeDetalheVO.Add(NfeDetalhe);
        FDataModuleNFe.CDSNfeDetalhe.Next;
      end;
      FDataModuleNFe.CDSNfeDetalhe.First;
      FDataModuleNFe.CDSNfeDetalhe.EnableControls;

      (* Grupo de informação dos documentos referenciados *)

      { NF-e Referenciada }
      if FDataModuleNFe.CDSNfeReferenciada.RecordCount > 0 then
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeReferenciadaVO := TObjectList<TNfeReferenciadaVO>.Create;
        FDataModuleNFe.CDSNfeReferenciada.DisableControls;
        FDataModuleNFe.CDSNfeReferenciada.First;
        while not FDataModuleNFe.CDSNfeReferenciada.Eof do
        begin
          NfeReferenciada := TNfeReferenciadaVO.Create;

          NfeReferenciada.Id := FDataModuleNFe.CDSNfeReferenciada.FieldByName('ID').AsInteger;
          NfeReferenciada.IdNfeCabecalho := FDataModuleNFe.CDSNfeReferenciada.FieldByName('ID_NFE_CABECALHO').AsInteger;
          NfeReferenciada.ChaveAcesso := FDataModuleNFe.CDSNfeReferenciada.FieldByName('CHAVE_ACESSO').AsString;

          TNfeCabecalhoVO(ObjetoVO).ListaNfeReferenciadaVO.Add(NfeReferenciada);
          FDataModuleNFe.CDSNfeReferenciada.Next;
        end;
        FDataModuleNFe.CDSNfeReferenciada.First;
        FDataModuleNFe.CDSNfeReferenciada.EnableControls;
      end
      else
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeReferenciadaVO := Nil;
        if Assigned(ObjetoOldVO) then
          TNfeCabecalhoVO(ObjetoOldVO).ListaNfeReferenciadaVO := Nil;
      end;

      { NF 1/1A Referenciada }
      if FDataModuleNFe.CDSNfReferenciada.RecordCount > 0 then
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeNfReferenciadaVO := TObjectList<TNfeNfReferenciadaVO>.Create;
        FDataModuleNFe.CDSNfReferenciada.DisableControls;
        FDataModuleNFe.CDSNfReferenciada.First;
        while not FDataModuleNFe.CDSNfReferenciada.Eof do
        begin
          NfeNfReferenciada := TNfeNfReferenciadaVO.Create;

          NfeNfReferenciada.Id := FDataModuleNFe.CDSNfReferenciada.FieldByName('ID').AsInteger;
          NfeNfReferenciada.IdNfeCabecalho := FDataModuleNFe.CDSNfReferenciada.FieldByName('ID_NFE_CABECALHO').AsInteger;
          NfeNfReferenciada.CodigoUf := FDataModuleNFe.CDSNfReferenciada.FieldByName('CODIGO_UF').AsInteger;
          NfeNfReferenciada.AnoMes := FDataModuleNFe.CDSNfReferenciada.FieldByName('ANO_MES').AsString;
          NfeNfReferenciada.Cnpj := FDataModuleNFe.CDSNfReferenciada.FieldByName('CNPJ').AsString;
          NfeNfReferenciada.Modelo := FDataModuleNFe.CDSNfReferenciada.FieldByName('MODELO').AsString;
          NfeNfReferenciada.Serie := FDataModuleNFe.CDSNfReferenciada.FieldByName('SERIE').AsString;
          NfeNfReferenciada.NumeroNf := FDataModuleNFe.CDSNfReferenciada.FieldByName('NUMERO_NF').AsString;

          TNfeCabecalhoVO(ObjetoVO).ListaNfeNfReferenciadaVO.Add(NfeNfReferenciada);
          FDataModuleNFe.CDSNfReferenciada.Next;
        end;
        FDataModuleNFe.CDSNfReferenciada.First;
        FDataModuleNFe.CDSNfReferenciada.EnableControls;
      end
      else
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeNfReferenciadaVO := Nil;
        if Assigned(ObjetoOldVO) then
          TNfeCabecalhoVO(ObjetoOldVO).ListaNfeNfReferenciadaVO := Nil;
      end;

      { NF Rural Referenciada }
      if FDataModuleNFe.CDSNfRuralReferenciada.RecordCount > 0 then
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeProdRuralReferenciadaVO := TObjectList<TNfeProdRuralReferenciadaVO>.Create;
        FDataModuleNFe.CDSNfRuralReferenciada.DisableControls;
        FDataModuleNFe.CDSNfRuralReferenciada.First;
        while not FDataModuleNFe.CDSNfRuralReferenciada.Eof do
        begin
          NfeRuralReferenciada := TNfeProdRuralReferenciadaVO.Create;

          NfeRuralReferenciada.Id := FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('ID').AsInteger;
          NfeRuralReferenciada.IdNfeCabecalho := FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('ID_NFE_CABECALHO').AsInteger;
          NfeRuralReferenciada.CodigoUf := FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('CODIGO_UF').AsInteger;
          NfeRuralReferenciada.AnoMes := FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('ANO_MES').AsString;
          NfeRuralReferenciada.Cnpj := FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('CNPJ').AsString;
          NfeRuralReferenciada.Cpf := FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('CPF').AsString;
          NfeRuralReferenciada.InscricaoEstadual := FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('INSCRICAO_ESTADUAL').AsString;
          NfeRuralReferenciada.Modelo := FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('MODELO').AsString;
          NfeRuralReferenciada.Serie := FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('SERIE').AsString;
          NfeRuralReferenciada.NumeroNf := FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('NUMERO_NF').AsString;

          TNfeCabecalhoVO(ObjetoVO).ListaNfeProdRuralReferenciadaVO.Add(NfeRuralReferenciada);
          FDataModuleNFe.CDSNfRuralReferenciada.Next;
        end;
        FDataModuleNFe.CDSNfRuralReferenciada.First;
        FDataModuleNFe.CDSNfRuralReferenciada.EnableControls;
      end
      else
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeProdRuralReferenciadaVO := Nil;
        if Assigned(ObjetoOldVO) then
          TNfeCabecalhoVO(ObjetoOldVO).ListaNfeProdRuralReferenciadaVO := Nil;
      end;

      { CT-e Referenciado }
      if FDataModuleNFe.CDSCteReferenciado.RecordCount > 0 then
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeCteReferenciadoVO := TObjectList<TNfeCteReferenciadoVO>.Create;
        FDataModuleNFe.CDSCteReferenciado.DisableControls;
        FDataModuleNFe.CDSCteReferenciado.First;
        while not FDataModuleNFe.CDSCteReferenciado.Eof do
        begin
          NfeCteReferenciado := TNfeCteReferenciadoVO.Create;

          NfeCteReferenciado.Id := FDataModuleNFe.CDSCteReferenciado.FieldByName('ID').AsInteger;
          NfeCteReferenciado.IdNfeCabecalho := FDataModuleNFe.CDSCteReferenciado.FieldByName('ID_NFE_CABECALHO').AsInteger;
          NfeCteReferenciado.ChaveAcesso := FDataModuleNFe.CDSCteReferenciado.FieldByName('CHAVE_ACESSO').AsString;

          TNfeCabecalhoVO(ObjetoVO).ListaNfeCteReferenciadoVO.Add(NfeCteReferenciado);
          FDataModuleNFe.CDSCteReferenciado.Next;
        end;
        FDataModuleNFe.CDSCteReferenciado.First;
        FDataModuleNFe.CDSCteReferenciado.EnableControls;
      end
      else
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeCteReferenciadoVO := Nil;
        if Assigned(ObjetoOldVO) then
          TNfeCabecalhoVO(ObjetoOldVO).ListaNfeCteReferenciadoVO := Nil;
      end;

      { Cupom Fiscal Referenciado }
      if FDataModuleNFe.CDSCupomReferenciado.RecordCount > 0 then
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeCupomFiscalReferenciadoVO := TObjectList<TNfeCupomFiscalReferenciadoVO>.Create;
        FDataModuleNFe.CDSCupomReferenciado.DisableControls;
        FDataModuleNFe.CDSCupomReferenciado.First;
        while not FDataModuleNFe.CDSCupomReferenciado.Eof do
        begin
          NfeCupomFiscalReferenciado := TNfeCupomFiscalReferenciadoVO.Create;

          NfeCupomFiscalReferenciado.Id := FDataModuleNFe.CDSCupomReferenciado.FieldByName('ID').AsInteger;
          NfeCupomFiscalReferenciado.IdNfeCabecalho := FDataModuleNFe.CDSCupomReferenciado.FieldByName('ID_NFE_CABECALHO').AsInteger;
          NfeCupomFiscalReferenciado.ModeloDocumentoFiscal := FDataModuleNFe.CDSCupomReferenciado.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString;
          NfeCupomFiscalReferenciado.NumeroOrdemEcf := FDataModuleNFe.CDSCupomReferenciado.FieldByName('NUMERO_ORDEM_ECF').AsInteger;
          NfeCupomFiscalReferenciado.Coo := FDataModuleNFe.CDSCupomReferenciado.FieldByName('COO').AsInteger;

          TNfeCabecalhoVO(ObjetoVO).ListaNfeCupomFiscalReferenciadoVO.Add(NfeCupomFiscalReferenciado);
          FDataModuleNFe.CDSCupomReferenciado.Next;
        end;
        FDataModuleNFe.CDSCupomReferenciado.First;
        FDataModuleNFe.CDSCupomReferenciado.EnableControls;
      end
      else
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeCupomFiscalReferenciadoVO := Nil;
        if Assigned(ObjetoOldVO) then
          TNfeCabecalhoVO(ObjetoOldVO).ListaNfeCupomFiscalReferenciadoVO := Nil;
      end;

      { Local Entrega }
      if (StatusTela = stInserindo) or (not Assigned(TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO)) then
        TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO := TNfeLocalEntregaVO.Create;

      TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.CpfCnpj := EditEntregaCpfCnpj.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.Logradouro := EditEntregaLogradouro.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.Numero := EditEntregaNumero.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.Complemento := EditEntregaComplemento.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.Bairro := EditEntregaBairro.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.CodigoMunicipio := EditEntregaIbge.AsInteger;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.NomeMunicipio := EditEntregaCidade.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.Uf := EditEntregaUf.Text;

      if (StatusTela = stEditando) and (Assigned(TNfeCabecalhoVO(ObjetoOldVO).NfeLocalEntregaVO)) then
      begin
        if TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.ToJSONString = TNfeCabecalhoVO(ObjetoOldVO).NfeLocalEntregaVO.ToJSONString then
        begin
          TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO := Nil;
          TNfeCabecalhoVO(ObjetoOldVO).NfeLocalEntregaVO := Nil;
        end
        else
          TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.IdNfeCabecalho := TNfeCabecalhoVO(ObjetoVO).Id;
      end;

      { Local Retirada }
      if (StatusTela = stInserindo) or (not Assigned(TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO)) then
        TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO := TNfeLocalRetiradaVO.Create;

      TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.CpfCnpj := EditRetiradaCpfCnpj.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.Logradouro := EditRetiradaLogradouro.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.Numero := EditRetiradaNumero.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.Complemento := EditRetiradaComplemento.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.Bairro := EditRetiradaBairro.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.CodigoMunicipio := EditRetiradaIbge.AsInteger;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.NomeMunicipio := EditRetiradaCidade.Text;
      TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.Uf := EditRetiradaUf.Text;

      if (StatusTela = stEditando) and (Assigned(TNfeCabecalhoVO(ObjetoOldVO).NfeLocalRetiradaVO)) then
      begin
        if TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.ToJSONString = TNfeCabecalhoVO(ObjetoOldVO).NfeLocalRetiradaVO.ToJSONString then
        begin
          TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO := Nil;
          TNfeCabecalhoVO(ObjetoOldVO).NfeLocalRetiradaVO := Nil;
        end
        else
          TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.IdNfeCabecalho := TNfeCabecalhoVO(ObjetoVO).Id;
      end;

      (* Grupo de Transporte *)

      { Transporte }
      if EditTransportadorId.AsInteger > 0 then
      begin

        if (StatusTela = stInserindo) or (not Assigned(TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO)) then
          TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO := TNfeTransporteVO.Create;

        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.IdTransportadora := EditTransportadorId.AsInteger;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ModalidadeFrete := Copy(ComboModalidadeFrete.Text, 1, 1);
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.CpfCnpj := EditTransportadorCpfCnpj.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Nome := EditTransportadorRazaoSocial.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.InscricaoEstadual := EditTransportadorIE.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Endereco := EditTransportadorLogradouro.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.NomeMunicipio := EditTransportadorCidade.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Uf := EditTransportadorUF.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ValorServico := EditRetencaoIcmsValorServico.Value;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ValorBcRetencaoIcms := EditRetencaoIcmsBaseCalculo.Value;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.AliquotaRetencaoIcms := EditRetencaoIcmsAliquota.Value;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ValorIcmsRetido := EditRetencaoIcmsIcmsRetido.Value;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Cfop := StrToIntDef(EditRetencaoIcmsCfop.Text, 0);
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Municipio := StrToIntDef(EditRetencaoIcmsCidade.Text, 0);
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.PlacaVeiculo := EditVeiculoPlaca.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.UfVeiculo := EditVeiculoUf.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.RntcVeiculo := EditVeiculoRntc.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Vagao := EditTransporteVagao.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Balsa := EditTransporteBalsa.Text;

        if (StatusTela = stEditando) and (Assigned(TNfeCabecalhoVO(ObjetoOldVO).NfeTransporteVO)) then
        begin
          if TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ToJSONString = TNfeCabecalhoVO(ObjetoOldVO).NfeTransporteVO.ToJSONString then
          begin
            TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO := Nil;
            TNfeCabecalhoVO(ObjetoOldVO).NfeTransporteVO := Nil;
          end
          else
            TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.IdNfeCabecalho := TNfeCabecalhoVO(ObjetoVO).Id;
        end;

        { Tranporte - Reboque }
        if FDataModuleNFe.CDSReboque.RecordCount > 0 then
        begin
          TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ListaNfeTransporteReboqueVO := TObjectList<TNfeTransporteReboqueVO>.Create;
          FDataModuleNFe.CDSReboque.DisableControls;
          FDataModuleNFe.CDSReboque.First;
          while not FDataModuleNFe.CDSReboque.Eof do
          begin
            NfeTransporteReboque := TNfeTransporteReboqueVO.Create;

            NfeTransporteReboque.Id := FDataModuleNFe.CDSReboque.FieldByName('ID').AsInteger;
            NfeTransporteReboque.IdNfeTransporte := FDataModuleNFe.CDSReboque.FieldByName('ID_NFE_TRANSPORTE').AsInteger;
            NfeTransporteReboque.Placa := FDataModuleNFe.CDSReboque.FieldByName('PLACA').AsString;
            NfeTransporteReboque.Uf := FDataModuleNFe.CDSReboque.FieldByName('UF').AsString;
            NfeTransporteReboque.Rntc := FDataModuleNFe.CDSReboque.FieldByName('RNTC').AsString;

            TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ListaNfeTransporteReboqueVO.Add(NfeTransporteReboque);
            FDataModuleNFe.CDSReboque.Next;
          end;
          FDataModuleNFe.CDSReboque.First;
          FDataModuleNFe.CDSReboque.EnableControls;
        end;

        { Tranporte - Volumes }
        if FDataModuleNFe.CDSVolumes.RecordCount > 0 then
        begin
          TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ListaNfeTransporteVolumeVO := TObjectList<TNfeTransporteVolumeVO>.Create;
          FDataModuleNFe.CDSVolumes.DisableControls;
          FDataModuleNFe.CDSVolumes.First;
          while not FDataModuleNFe.CDSVolumes.Eof do
          begin
            NfeTransporteVolume := TNfeTransporteVolumeVO.Create;

            NfeTransporteVolume.Id := FDataModuleNFe.CDSVolumes.FieldByName('ID').AsInteger;
            NfeTransporteVolume.IdNfeTransporte := FDataModuleNFe.CDSVolumes.FieldByName('ID_NFE_TRANSPORTE').AsInteger;
            NfeTransporteVolume.Quantidade := FDataModuleNFe.CDSVolumes.FieldByName('QUANTIDADE').AsInteger;
            NfeTransporteVolume.Especie := FDataModuleNFe.CDSVolumes.FieldByName('ESPECIE').AsString;
            NfeTransporteVolume.Marca := FDataModuleNFe.CDSVolumes.FieldByName('MARCA').AsString;
            NfeTransporteVolume.Numeracao := FDataModuleNFe.CDSVolumes.FieldByName('NUMERACAO').AsString;
            NfeTransporteVolume.PesoLiquido := FDataModuleNFe.CDSVolumes.FieldByName('PESO_LIQUIDO').AsExtended;
            NfeTransporteVolume.PesoBruto := FDataModuleNFe.CDSVolumes.FieldByName('PESO_BRUTO').AsExtended;

            TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ListaNfeTransporteVolumeVO.Add(NfeTransporteVolume);
            FDataModuleNFe.CDSVolumes.Next;
          end;
          FDataModuleNFe.CDSVolumes.First;
          FDataModuleNFe.CDSVolumes.EnableControls;
        end;
      end;

      (* Grupo de Cobrança *)

      { Cobrança - Fatura }
      if (StatusTela = stInserindo) or (not Assigned(TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO)) then
        TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO := TNfeFaturaVO.Create;

        TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO.Numero := EditFaturaNumero.Text;
        TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO.ValorOriginal := EditFaturaValorOriginal.Value;
        TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO.ValorDesconto := EditFaturaValorDesconto.Value;
        TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO.ValorLiquido := EditFaturaValorLiquido.Value;

      if (StatusTela = stEditando) and (Assigned(TNfeCabecalhoVO(ObjetoOldVO).NfeFaturaVO)) then
      begin
        if TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO.ToJSONString = TNfeCabecalhoVO(ObjetoOldVO).NfeFaturaVO.ToJSONString then
        begin
          TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO := Nil;
          TNfeCabecalhoVO(ObjetoOldVO).NfeFaturaVO := Nil;
        end
        else
          TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO.IdNfeCabecalho := TNfeCabecalhoVO(ObjetoVO).Id;
      end;

      { Cobrança - Duplicatas }
      if FDataModuleNFe.CDSDuplicata.RecordCount > 0 then
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeDuplicataVO := TObjectList<TNfeDuplicataVO>.Create;
        FDataModuleNFe.CDSDuplicata.DisableControls;
        FDataModuleNFe.CDSDuplicata.First;
        while not FDataModuleNFe.CDSDuplicata.Eof do
        begin
          NfeDuplicata := TNfeDuplicataVO.Create;

          NfeDuplicata.Id := FDataModuleNFe.CDSDuplicata.FieldByName('ID').AsInteger;
          NfeDuplicata.IdNfeCabecalho := FDataModuleNFe.CDSDuplicata.FieldByName('ID_NFE_CABECALHO').AsInteger;
          NfeDuplicata.Numero := FDataModuleNFe.CDSDuplicata.FieldByName('NUMERO').AsString;
          NfeDuplicata.DataVencimento := FDataModuleNFe.CDSDuplicata.FieldByName('DATA_VENCIMENTO').AsDateTime;
          NfeDuplicata.Valor := FDataModuleNFe.CDSDuplicata.FieldByName('VALOR').AsExtended;

          TNfeCabecalhoVO(ObjetoVO).ListaNfeDuplicataVO.Add(NfeDuplicata);
          FDataModuleNFe.CDSDuplicata.Next;
        end;
        FDataModuleNFe.CDSDuplicata.First;
        FDataModuleNFe.CDSDuplicata.EnableControls;
      end
      else
      begin
        TNfeCabecalhoVO(ObjetoVO).ListaNfeDuplicataVO := Nil;
        if Assigned(ObjetoOldVO) then
          TNfeCabecalhoVO(ObjetoOldVO).ListaNfeDuplicataVO := Nil;
      end;

      { Escrituração - Entradas }
      if (StatusTela = stInserindo) or (not Assigned(TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO)) then
        TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO := TFiscalNotaFiscalEntradaVO.Create;

      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.Competencia := EditEscrituracaoCompetencia.Text;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.CfopEntrada := EditEscrituracaoCfopEntrada.AsInteger;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorRateioFrete := EditEscritutacaoValorRateioFrete.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorCustoMedio := EditEscritutacaoValorCustoMedio.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorIcmsAntecipado := EditEscritutacaoValorIcmsAntecipado.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorBcIcmsAntecipado := EditEscritutacaoValorBcIcmsAntecipado.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorBcIcmsCreditado := EditEscritutacaoValorBcIcmsCreditado.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorBcPisCreditado := EditEscritutacaoValorBcPisCreditado.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorBcCofinsCreditado := EditEscritutacaoValorBcCofinsCreditado.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorBcIpiCreditado := EditEscritutacaoValorBcIpiCreditado.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.CstCreditoIcms := EditEscritutacaoCstCreditoIcms.Text;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.CstCreditoPis := EditEscritutacaoCstCreditoPis.Text;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.CstCreditoCofins := EditEscritutacaoCstCreditoCofins.Text;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.CstCreditoIpi := EditEscritutacaoCstCreditoIpi.Text;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorIcmsCreditado := EditEscritutacaoValorIcmsCreditado.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorPisCreditado := EditEscritutacaoValorPisCreditado.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorCofinsCreditado := EditEscritutacaoValorCofinsCreditado.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorIpiCreditado := EditEscritutacaoValorIpiCreditado.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.QtdeParcelaCreditoIcms := EditEscritutacaoQuantidadeParcelaCreditoIcms.AsInteger;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.QtdeParcelaCreditoPis := EditEscritutacaoQuantidadeParcelaCreditoPis.AsInteger;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.QtdeParcelaCreditoCofins := EditEscritutacaoQuantidadeParcelaCreditoCofins.AsInteger;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.QtdeParcelaCreditoIpi := EditEscritutacaoQuantidadeParcelaCreditoIpi.AsInteger;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.AliquotaCreditoIcms := EditEscritutacaoAliquotaCreditoIcms.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.AliquotaCreditoPis := EditEscritutacaoAliquotaCreditoPis.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.AliquotaCreditoCofins := EditEscritutacaoAliquotaCreditoCofins.Value;
      TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.AliquotaCreditoIpi := EditEscritutacaoAliquotaCreditoIpi.Value;

      if (StatusTela = stEditando) and (Assigned(TNfeCabecalhoVO(ObjetoOldVO).FiscalNotaFiscalEntradaVO)) then
      begin
        if TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ToJSONString = TNfeCabecalhoVO(ObjetoOldVO).FiscalNotaFiscalEntradaVO.ToJSONString then
        begin
          TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO := Nil;
          TNfeCabecalhoVO(ObjetoOldVO).FiscalNotaFiscalEntradaVO := Nil;
        end
        else
          TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.IdNfeCabecalho := TNfeCabecalhoVO(ObjetoVO).Id;
      end;

      // ObjetoVO - libera objetos vinculados (TAssociation) que não tem necessidade de subir
      TNfeCabecalhoVO(ObjetoVO).NfeDestinatarioVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) que não tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TNfeCabecalhoVO(ObjetoOldVO).NfeDestinatarioVO := Nil;
      end;


      if StatusTela = stInserindo then
        Result := TNfeCabecalhoController(ObjetoController).Insere(TNfeCabecalhoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TNfeCabecalhoVO(ObjetoVO).ToJSONString <> TNfeCabecalhoVO(ObjetoOldVO).ToJSONString then
        begin
          TNfeCabecalhoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TNfeCabecalhoController(ObjetoController).Altera(TNfeCabecalhoVO(ObjetoVO), TNfeCabecalhoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;

      DecimalSeparator := ',';
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFEntradaNF.GridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if FDataModuleNFe.CDSNfeDetalhe.FieldByName('CADASTRADO').AsString = 'N' then
    GridItens.Canvas.Brush.Color := $00C6C6FF;
  GridItens.DefaultDrawDataCell(Rect, GridItens.columns[datacol].field, State);
end;

procedure TFEntradaNF.GridItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    ActionIncluirItem.Execute;
  end;
end;

procedure TFEntradaNF.GridParaEdits;
var
  NfeReferenciadaEnumerator: TEnumerator<TNfeReferenciadaVO>;
  NfReferenciadaEnumerator: TEnumerator<TNfeNfReferenciadaVO>;
  NfeRuralReferenciadaEnumerator: TEnumerator<TNfeProdRuralReferenciadaVO>;
  NfeCteReferenciadoEnumerator: TEnumerator<TNfeCteReferenciadoVO>;
  NfeCupomFiscalReferenciadoEnumerator: TEnumerator<TNfeCupomFiscalReferenciadoVO>;
  NfeTransporteReboqueEnumerator: TEnumerator<TNfeTransporteReboqueVO>;
  NfeTransporteVolumeEnumerator: TEnumerator<TNfeTransporteVolumeVO>;
  NfeDuplicataEnumerator: TEnumerator<TNfeDuplicataVO>;
  //
  NfeDetalheEnumerator: TEnumerator<TNfeDetalheVO>;
  NfeDeclaracaoImportacaoEnumerator: TEnumerator<TNfeDeclaracaoImportacaoVO>;
  NfeDetalheEspecificoMedicamentoEnumerator: TEnumerator<TNfeDetEspecificoMedicamentoVO>;
  NfeDetalheEspecificoArmamentoEnumerator: TEnumerator<TNfeDetEspecificoArmamentoVO>;
  NfeImportacaoDetalheEnumerator: TEnumerator<TNfeImportacaoDetalheVO>;
begin
  ActionSelecionarArquivo.Enabled := False;

  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TNfeCabecalhoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TNfeCabecalhoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    { NF-e Cabeçalho }
    EditCodigoNumerico.Text := TNfeCabecalhoVO(ObjetoVO).CodigoNumerico;
    EditNaturezaOperacao.Text := TNfeCabecalhoVO(ObjetoVO).NaturezaOperacao;
    ComboBoxFormaPagamento.ItemIndex := StrToInt(TNfeCabecalhoVO(ObjetoVO).IndicadorFormaPagamento);
    ComboboxModeloNotaFiscal.ItemIndex := AnsiIndexStr(TNfeCabecalhoVO(ObjetoVO).CodigoModelo, ['01', '55']);
    EditSerie.Text := TNfeCabecalhoVO(ObjetoVO).Serie;
    EditNumeroNfe.Text := TNfeCabecalhoVO(ObjetoVO).Numero;
    EditDataEmissao.Date := TNfeCabecalhoVO(ObjetoVO).DataEmissao;
    EditDataEntradaSaida.Date := TNfeCabecalhoVO(ObjetoVO).DataEntradaSaida;
    EditHoraEntradaSaida.Text := TNfeCabecalhoVO(ObjetoVO).HoraEntradaSaida;
    ComboTipoOperacao.ItemIndex := StrToInt(TNfeCabecalhoVO(ObjetoVO).TipoOperacao);
    EditEmitenteCodigoIbge.AsInteger := TNfeCabecalhoVO(ObjetoVO).CodigoMunicipio;
    ComboFormaImpDanfe.ItemIndex := AnsiIndexStr(TNfeCabecalhoVO(ObjetoVO).FormatoImpressaoDanfe, ['1', '2']);
    ComboTipoEmissao.ItemIndex := AnsiIndexStr(TNfeCabecalhoVO(ObjetoVO).TipoEmissao, ['1', '2', '3', '4', '5', '6', '7']);
    EditChaveAcesso.Text := TNfeCabecalhoVO(ObjetoVO).ChaveAcesso;
    EditDigitoChaveAcesso.Text := TNfeCabecalhoVO(ObjetoVO).DigitoChaveAcesso;
    ComboFinalidadeEmissao.ItemIndex := AnsiIndexStr(TNfeCabecalhoVO(ObjetoVO).FormatoImpressaoDanfe, ['1', '2', '3']);
    EditBCIcms.Value := TNfeCabecalhoVO(ObjetoVO).BaseCalculoIcms;
    EditValorIcms.Value := TNfeCabecalhoVO(ObjetoVO).ValorIcms;
    EditBCIcmsSt.Value := TNfeCabecalhoVO(ObjetoVO).BaseCalculoIcmsSt;
    EditValorIcmsSt.Value := TNfeCabecalhoVO(ObjetoVO).ValorIcmsSt;
    EditTotalProdutos.Value := TNfeCabecalhoVO(ObjetoVO).ValorTotalProdutos;
    EditValorFrete.Value := TNfeCabecalhoVO(ObjetoVO).ValorFrete;
    EditValorSeguro.Value := TNfeCabecalhoVO(ObjetoVO).ValorSeguro;
    EditValorDesconto.Value := TNfeCabecalhoVO(ObjetoVO).ValorDesconto;
    EditTotalImpostoImportacao.Value := TNfeCabecalhoVO(ObjetoVO).ValorImpostoImportacao;
    EditValorIPI.Value := TNfeCabecalhoVO(ObjetoVO).ValorIpi;
    EditValorPIS.Value := TNfeCabecalhoVO(ObjetoVO).ValorPis;
    EditValorCOFINS.Value := TNfeCabecalhoVO(ObjetoVO).ValorCofins;
    EditValorOutrasDespesas.Value := TNfeCabecalhoVO(ObjetoVO).ValorDespesasAcessorias;
    EditValorTotalNota.Value := TNfeCabecalhoVO(ObjetoVO).ValorTotal;

    EditValorTotalServicos.Value := TNfeCabecalhoVO(ObjetoVO).ValorServicos;
    EditBaseCalculoIssqn.Value := TNfeCabecalhoVO(ObjetoVO).BaseCalculoIssqn;
    EditValorIssqn.Value := TNfeCabecalhoVO(ObjetoVO).ValorIssqn;
    EditValorPisIssqn.Value := TNfeCabecalhoVO(ObjetoVO).ValorPisIssqn;
    EditValorCofinsIssqn.Value := TNfeCabecalhoVO(ObjetoVO).ValorCofinsIssqn;
    EditValorRetidoPis.Value := TNfeCabecalhoVO(ObjetoVO).ValorRetidoPis;
    EditValorRetidoCofins.Value := TNfeCabecalhoVO(ObjetoVO).ValorRetidoCofins;
    EditValorRetidoCsll.Value := TNfeCabecalhoVO(ObjetoVO).ValorRetidoCsll;
    EditBaseCalculoIrrf.Value := TNfeCabecalhoVO(ObjetoVO).BaseCalculoIrrf;
    EditValorRetidoIrrf.Value := TNfeCabecalhoVO(ObjetoVO).ValorRetidoIrrf;
    EditBaseCalculoPrevidencia.Value := TNfeCabecalhoVO(ObjetoVO).BaseCalculoPrevidencia;
    EditValorRetidoPrevidencia.Value := TNfeCabecalhoVO(ObjetoVO).ValorRetidoPrevidencia;

    EditComexUfEmbarque.Text := TNfeCabecalhoVO(ObjetoVO).ComexUfEmbarque;
    EditComexLocalEmbarque.Text := TNfeCabecalhoVO(ObjetoVO).ComexLocalEmbarque;
    EditCompraNotaEmpenho.Text := TNfeCabecalhoVO(ObjetoVO).CompraNotaEmpenho;
    EditCompraPedido.Text := TNfeCabecalhoVO(ObjetoVO).CompraPedido;
    EditCompraContrato.Text := TNfeCabecalhoVO(ObjetoVO).CompraContrato;

    MemoInfComplementarFisco.Text := TNfeCabecalhoVO(ObjetoVO).InformacoesAddFisco;
    MemoInfComplementarContribuinte.Text := TNfeCabecalhoVO(ObjetoVO).InformacoesAddContribuinte;

    { Emitente }
    EditEmitenteId.AsInteger := TNfeCabecalhoVO(ObjetoVO).IdFornecedor;
    EditEmitenteUF.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Uf;
    EditEmitenteCpfCnpj.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.CpfCnpj;
    EditEmitenteRazao.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.RazaoSocial;
    EditEmitenteFantasia.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Fantasia;
    EditEmitenteLogradouro.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Logradouro;
    EditEmitenteNumero.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Numero;
    EditEmitenteComplemento.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Complemento;
    EditEmitenteBairro.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Bairro;
    EditEmitenteCodigoIbge.AsInteger := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.CodigoMunicipio;
    EditEmitenteCidade.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.NomeMunicipio;
    EditEmitenteUF.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Uf;
    EditEmitenteCEP.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Cep;
    EditEmitenteTelefone.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Telefone;
    EditEmitenteIE.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.InscricaoEstadual;
    ComboEmitenteCrt.ItemIndex := AnsiIndexStr(TNfeCabecalhoVO(ObjetoVO).FormatoImpressaoDanfe, ['1', '2', '3']);
    EditEmitenteEmail.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Email;
    EditEmitenteIEST.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.InscricaoEstadualSt;
    EditEmitenteIM.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.InscricaoMunicipal;
    EditEmitenteCnae.Text := TNfeCabecalhoVO(ObjetoVO).NfeEmitenteVO.Cnae;

    (* Grupo de informação dos documentos referenciados *)
    { NF-e Referenciada }
    NfeReferenciadaEnumerator := TNfeCabecalhoVO(ObjetoVO).ListaNfeReferenciadaVO.GetEnumerator;
    try
      with NfeReferenciadaEnumerator do
      begin
        FDataModuleNFe.CDSNfeReferenciada.EmptyDataSet;
        while MoveNext do
        begin
          FDataModuleNFe.CDSNfeReferenciada.Append;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('ID').AsInteger := Current.Id;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('ID_NFE_CABECALHO').AsInteger := Current.IdNfeCabecalho;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('CHAVE_ACESSO').AsString := Current.ChaveAcesso;
          FDataModuleNFe.CDSNfeReferenciada.Post;
        end;
      end;
    finally
      NfeReferenciadaEnumerator.Free;
    end;

    { NF Referenciada }
    NfReferenciadaEnumerator := TNfeCabecalhoVO(ObjetoVO).ListaNfeNfReferenciadaVO.GetEnumerator;
    try
      with NfReferenciadaEnumerator do
      begin
        FDataModuleNFe.CDSNfReferenciada.EmptyDataSet;
        while MoveNext do
        begin
          with FDataModuleNFe.CDSNfeReferenciada do
          begin
            Append;
            FieldByName('ID').AsInteger := Current.Id;
            FieldByName('ID_NFE_CABECALHO').AsInteger := Current.IdNfeCabecalho;
            FieldByName('CODIGO_UF').AsInteger := Current.CodigoUf;
            FieldByName('ANO_MES').AsString := Current.AnoMes;
            FieldByName('CNPJ').AsString := Current.Cnpj;
            FieldByName('MODELO').AsString := Current.Modelo;
            FieldByName('SERIE').AsString := Current.Serie;
            FieldByName('NUMERO_NF').AsString := Current.NumeroNf;
            Post;
          end;
        end;
      end;
    finally
      NfReferenciadaEnumerator.Free;
    end;

    { NF Rural Referenciada }
    NfeRuralReferenciadaEnumerator := TNfeCabecalhoVO(ObjetoVO).ListaNfeProdRuralReferenciadaVO.GetEnumerator;
    try
      with NfeRuralReferenciadaEnumerator do
      begin
        FDataModuleNFe.CDSNfeReferenciada.EmptyDataSet;
        while MoveNext do
        begin
          with FDataModuleNFe.CDSNfeReferenciada do
          begin
            Append;
            FieldByName('ID').AsInteger := Current.Id;
            FieldByName('ID_NFE_CABECALHO').AsInteger := Current.IdNfeCabecalho;
            FieldByName('CODIGO_UF').AsInteger := Current.CodigoUf;
            FieldByName('ANO_MES').AsString := Current.AnoMes;
            FieldByName('CNPJ').AsString := Current.Cnpj;
            FieldByName('CPF').AsString := Current.Cpf;
            FieldByName('INSCRICAO_ESTADUAL').AsString := Current.InscricaoEstadual;
            FieldByName('MODELO').AsString := Current.Modelo;
            FieldByName('SERIE').AsString := Current.Serie;
            FieldByName('NUMERO_NF').AsString := Current.NumeroNf;
            Post;
          end;
        end;
      end;
    finally
      NfeRuralReferenciadaEnumerator.Free;
    end;

    { CTF-e Referenciado }
    NfeCteReferenciadoEnumerator := TNfeCabecalhoVO(ObjetoVO).ListaNfeCteReferenciadoVO.GetEnumerator;
    try
      with NfeCteReferenciadoEnumerator do
      begin
        FDataModuleNFe.CDSCteReferenciado.EmptyDataSet;
        while MoveNext do
        begin
          FDataModuleNFe.CDSCteReferenciado.Append;
          FDataModuleNFe.CDSCteReferenciado.FieldByName('ID').AsInteger := Current.Id;
          FDataModuleNFe.CDSCteReferenciado.FieldByName('ID_NFE_CABECALHO').AsInteger := Current.IdNfeCabecalho;
          FDataModuleNFe.CDSCteReferenciado.FieldByName('CHAVE_ACESSO').AsString := Current.ChaveAcesso;
          FDataModuleNFe.CDSCteReferenciado.Post;
        end;
      end;
    finally
      NfeCteReferenciadoEnumerator.Free;
    end;

    { Cupom Fiscal Referenciado }
    NfeCupomFiscalReferenciadoEnumerator := TNfeCabecalhoVO(ObjetoVO).ListaNfeCupomFiscalReferenciadoVO.GetEnumerator;
    try
      with NfeCupomFiscalReferenciadoEnumerator do
      begin
        FDataModuleNFe.CDSCupomReferenciado.EmptyDataSet;
        while MoveNext do
        begin
          FDataModuleNFe.CDSCupomReferenciado.Append;
          FDataModuleNFe.CDSCupomReferenciado.FieldByName('ID').AsInteger := Current.Id;
          FDataModuleNFe.CDSCupomReferenciado.FieldByName('ID_NFE_CABECALHO').AsInteger := Current.IdNfeCabecalho;
          FDataModuleNFe.CDSCupomReferenciado.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString := Current.ModeloDocumentoFiscal;
          FDataModuleNFe.CDSCupomReferenciado.FieldByName('NUMERO_ORDEM_ECF').AsInteger := Current.NumeroOrdemEcf;
          FDataModuleNFe.CDSCupomReferenciado.FieldByName('COO').AsInteger := Current.Coo;
          FDataModuleNFe.CDSCupomReferenciado.Post;
        end;
      end;
    finally
      NfeCupomFiscalReferenciadoEnumerator.Free;
    end;

    { Local Entrega }
    if Assigned(TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO) then
    begin
      EditEntregaCpfCnpj.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.CpfCnpj;
      EditEntregaLogradouro.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.Logradouro;
      EditEntregaNumero.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.Numero;
      EditEntregaComplemento.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.Complemento;
      EditEntregaBairro.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.Bairro;
      EditEntregaIbge.Text := IntToStr(TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.CodigoMunicipio);
      EditEntregaCidade.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.NomeMunicipio;
      EditEntregaUf.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalEntregaVO.Uf;
    end;

    { Local Retirada }
    if Assigned(TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO) then
    begin
      EditRetiradaCpfCnpj.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.CpfCnpj;
      EditRetiradaLogradouro.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.Logradouro;
      EditRetiradaNumero.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.Numero;
      EditRetiradaComplemento.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.Complemento;
      EditRetiradaBairro.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.Bairro;
      EditRetiradaIbge.Text := IntToStr(TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.CodigoMunicipio);
      EditRetiradaCidade.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.NomeMunicipio;
      EditRetiradaUf.Text := TNfeCabecalhoVO(ObjetoVO).NfeLocalRetiradaVO.Uf;
    end;

    (* Grupo de Transporte *)
    { Transporte }
    if Assigned(TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO) then
    begin
      EditTransportadorId.AsInteger := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.IdTransportadora;
      ComboModalidadeFrete.ItemIndex := AnsiIndexStr(TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ModalidadeFrete, ['0', '1', '2', '9']);
      EditTransportadorCpfCnpj.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.CpfCnpj;
      EditTransportadorRazaoSocial.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Nome;
      EditTransportadorIE.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.InscricaoEstadual;
      EditTransportadorLogradouro.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Endereco;
      EditTransportadorCidade.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.NomeMunicipio;
      EditTransportadorUF.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Uf;
      EditRetencaoIcmsValorServico.Value := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ValorServico;
      EditRetencaoIcmsBaseCalculo.Value := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ValorBcRetencaoIcms;
      EditRetencaoIcmsAliquota.Value := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.AliquotaRetencaoIcms;
      EditRetencaoIcmsIcmsRetido.Value := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ValorIcmsRetido;
      EditRetencaoIcmsCfop.AsInteger := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Cfop;
      EditRetencaoIcmsCidade.AsInteger := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Municipio;
      EditVeiculoPlaca.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.PlacaVeiculo;
      EditVeiculoUf.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.UfVeiculo;
      EditVeiculoRntc.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.RntcVeiculo;
      EditRetencaoIcmsUf.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Uf;
      EditTransporteVagao.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Vagao;
      EditTransporteBalsa.Text := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.Balsa;

      { Tranporte - Reboque }
      NfeTransporteReboqueEnumerator := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ListaNfeTransporteReboqueVO.GetEnumerator;
      try
        with NfeTransporteReboqueEnumerator do
        begin
          FDataModuleNFe.CDSReboque.EmptyDataSet;
          while MoveNext do
          begin
            FDataModuleNFe.CDSReboque.Append;
            FDataModuleNFe.CDSReboque.FieldByName('ID').AsInteger := Current.Id;
            FDataModuleNFe.CDSReboque.FieldByName('ID_NFE_TRANSPORTE').AsInteger := Current.IdNfeTransporte;
            FDataModuleNFe.CDSReboque.FieldByName('PLACA').AsString := Current.Placa;
            FDataModuleNFe.CDSReboque.FieldByName('UF').AsString := Current.Uf;
            FDataModuleNFe.CDSReboque.FieldByName('RNTC').AsString := Current.Rntc;
            FDataModuleNFe.CDSReboque.Post;
          end;
        end;
      finally
        NfeTransporteReboqueEnumerator.Free;
      end;

      { Tranporte - Volume }
      NfeTransporteVolumeEnumerator := TNfeCabecalhoVO(ObjetoVO).NfeTransporteVO.ListaNfeTransporteVolumeVO.GetEnumerator;
      try
        with NfeTransporteVolumeEnumerator do
        begin
          FDataModuleNFe.CDSVolumes.EmptyDataSet;
          while MoveNext do
          begin
            FDataModuleNFe.CDSVolumes.Append;
            FDataModuleNFe.CDSVolumes.FieldByName('ID').AsInteger := Current.Id;
            FDataModuleNFe.CDSVolumes.FieldByName('ID_NFE_TRANSPORTE').AsInteger := Current.IdNfeTransporte;
            FDataModuleNFe.CDSVolumes.FieldByName('QUANTIDADE').AsExtended := Current.Quantidade;
            FDataModuleNFe.CDSVolumes.FieldByName('ESPECIE').AsString := Current.Especie;
            FDataModuleNFe.CDSVolumes.FieldByName('MARCA').AsString := Current.Marca;
            FDataModuleNFe.CDSVolumes.FieldByName('NUMERACAO').AsString := Current.Numeracao;
            FDataModuleNFe.CDSVolumes.FieldByName('PESO_LIQUIDO').AsExtended := Current.PesoLiquido;
            FDataModuleNFe.CDSVolumes.FieldByName('PESO_BRUTO').AsExtended := Current.PesoBruto;
            FDataModuleNFe.CDSVolumes.Post;
          end;
        end;
      finally
        NfeTransporteVolumeEnumerator.Free;
      end;
    end;
    (* Fim Grupo de Transporte *)

    (* Grupo de Cobrança *)
    { Cobrança - Fatura }
    if Assigned(TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO) then
    begin
      EditFaturaNumero.Text := TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO.Numero;
      EditFaturaValorOriginal.Value := TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO.ValorOriginal;
      EditFaturaValorDesconto.Value := TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO.ValorDesconto;
      EditFaturaValorLiquido.Value := TNfeCabecalhoVO(ObjetoVO).NfeFaturaVO.ValorLiquido;
    end;

    { Cobrança - Duplicatas }
    NfeDuplicataEnumerator := TNfeCabecalhoVO(ObjetoVO).ListaNfeDuplicataVO.GetEnumerator;
    try
      with NfeDuplicataEnumerator do
      begin
        FDataModuleNFe.CDSDuplicata.EmptyDataSet;
        while MoveNext do
        begin
          FDataModuleNFe.CDSDuplicata.Append;
          FDataModuleNFe.CDSDuplicata.FieldByName('ID').AsInteger := Current.Id;
          FDataModuleNFe.CDSDuplicata.FieldByName('ID_NFE_CABECALHO').AsInteger := Current.IdNfeCabecalho;
          FDataModuleNFe.CDSDuplicata.FieldByName('NUMERO').AsString := Current.Numero;
          FDataModuleNFe.CDSDuplicata.FieldByName('DATA_VENCIMENTO').AsDateTime := Current.DataVencimento;
          FDataModuleNFe.CDSDuplicata.FieldByName('VALOR').AsExtended := Current.Valor;
          FDataModuleNFe.CDSDuplicata.Post;
        end;
      end;
    finally
      NfeDuplicataEnumerator.Free;
    end;
    (* Fim Grupo de Cobrança *)


    { Escrituração - Entradas }
    if Assigned(TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO) then
    begin
      EditEscrituracaoCompetencia.Text := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.Competencia;
      EditEscrituracaoCfopEntrada.AsInteger := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.CfopEntrada;
      EditEscritutacaoValorRateioFrete.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorRateioFrete;
      EditEscritutacaoValorCustoMedio.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorCustoMedio;
      EditEscritutacaoValorIcmsAntecipado.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorIcmsAntecipado;
      EditEscritutacaoValorBcIcmsAntecipado.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorBcIcmsAntecipado;
      EditEscritutacaoValorBcIcmsCreditado.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorBcIcmsCreditado;
      EditEscritutacaoValorBcPisCreditado.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorBcPisCreditado;
      EditEscritutacaoValorBcCofinsCreditado.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorBcCofinsCreditado;
      EditEscritutacaoValorBcIpiCreditado.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorBcIpiCreditado;
      EditEscritutacaoCstCreditoIcms.Text := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.CstCreditoIcms;
      EditEscritutacaoCstCreditoPis.Text := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.CstCreditoPis;
      EditEscritutacaoCstCreditoCofins.Text := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.CstCreditoCofins;
      EditEscritutacaoCstCreditoIpi.Text := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.CstCreditoIpi;
      EditEscritutacaoValorIcmsCreditado.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorIcmsCreditado;
      EditEscritutacaoValorPisCreditado.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorPisCreditado;
      EditEscritutacaoValorCofinsCreditado.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorCofinsCreditado;
      EditEscritutacaoValorIpiCreditado.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.ValorIpiCreditado;
      EditEscritutacaoQuantidadeParcelaCreditoIcms.AsInteger := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.QtdeParcelaCreditoIcms;
      EditEscritutacaoQuantidadeParcelaCreditoPis.AsInteger := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.QtdeParcelaCreditoPis;
      EditEscritutacaoQuantidadeParcelaCreditoCofins.AsInteger := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.QtdeParcelaCreditoCofins;
      EditEscritutacaoQuantidadeParcelaCreditoIpi.AsInteger := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.QtdeParcelaCreditoIpi;
      EditEscritutacaoAliquotaCreditoIcms.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.AliquotaCreditoIcms;
      EditEscritutacaoAliquotaCreditoPis.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.AliquotaCreditoPis;
      EditEscritutacaoAliquotaCreditoCofins.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.AliquotaCreditoCofins;
      EditEscritutacaoAliquotaCreditoIpi.Value := TNfeCabecalhoVO(ObjetoVO).FiscalNotaFiscalEntradaVO.AliquotaCreditoIpi;
    end;

    (* Grupo de Detalhe *)
    // NfeDetalheEnumerator
    NfeDetalheEnumerator := TNfeCabecalhoVO(ObjetoVO).ListaNfeDetalheVO.GetEnumerator;
    try
      with NfeDetalheEnumerator do
      begin
        FDataModuleNFe.CDSNfeDetalhe.EmptyDataSet;
        while MoveNext do
        begin
          FDataModuleNFe.CDSNfeDetalhe.Append;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger := Current.Id;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID_PRODUTO').AsInteger := Current.IdProduto;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID_NFE_CABECALHO').AsInteger := Current.IdNfeCabecalho;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('NUMERO_ITEM').AsInteger := Current.NumeroItem;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('CODIGO_PRODUTO').AsString := Current.CodigoProduto;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('GTIN').AsString := Current.Gtin;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('NOME_PRODUTO').AsString := Current.NomeProduto;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('NCM').AsString := Current.Ncm;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('EX_TIPI').AsInteger := Current.ExTipi;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('CFOP').AsInteger := Current.Cfop;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('UNIDADE_COMERCIAL').AsString := Current.UnidadeComercial;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('QUANTIDADE_COMERCIAL').AsExtended := Current.QuantidadeComercial;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_UNITARIO_COMERCIAL').AsExtended := Current.ValorUnitarioComercial;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_BRUTO_PRODUTO').AsExtended := Current.ValorBrutoProduto;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('GTIN_UNIDADE_TRIBUTAVEL').AsString := Current.GtinUnidadeTributavel;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('UNIDADE_TRIBUTAVEL').AsString := Current.UnidadeTributavel;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('QUANTIDADE_TRIBUTAVEL').AsExtended := Current.QuantidadeTributavel;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_UNITARIO_TRIBUTAVEL').AsExtended := Current.ValorUnitarioTributavel;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_FRETE').AsExtended := Current.ValorFrete;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_SEGURO').AsExtended := Current.ValorSeguro;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_DESCONTO').AsExtended := Current.ValorDesconto;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_OUTRAS_DESPESAS').AsExtended := Current.ValorOutrasDespesas;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('ENTRA_TOTAL').AsString := Current.EntraTotal;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_SUBTOTAL').AsExtended := Current.ValorSubtotal;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_TOTAL').AsExtended := Current.ValorTotal;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('INFORMACOES_ADICIONAIS').AsString := Current.InformacoesAdicionais;

          { NfeDetalhe - Imposto - ICMS }
          if Assigned(Current.NfeDetalheImpostoIcmsVO) then
          begin
            FDataModuleNFe.CDSNfeImpostoIcms.Append;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ID').AsInteger := Current.NfeDetalheImpostoIcmsVO.Id;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ID_NFE_DETALHE').AsInteger := Current.NfeDetalheImpostoIcmsVO.IdNfeDetalhe;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ORIGEM_MERCADORIA').AsString := Current.NfeDetalheImpostoIcmsVO.OrigemMercadoria;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('CST_ICMS').AsString := Current.NfeDetalheImpostoIcmsVO.CstIcms;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('CSOSN').AsString := Current.NfeDetalheImpostoIcmsVO.Csosn;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('MODALIDADE_BC_ICMS').AsString := Current.NfeDetalheImpostoIcmsVO.ModalidadeBcIcms;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('TAXA_REDUCAO_BC_ICMS').AsExtended := Current.NfeDetalheImpostoIcmsVO.TaxaReducaoBcIcms;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('BASE_CALCULO_ICMS').AsExtended := Current.NfeDetalheImpostoIcmsVO.BaseCalculoIcms;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ALIQUOTA_ICMS').AsExtended := Current.NfeDetalheImpostoIcmsVO.AliquotaIcms;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS').AsExtended := Current.NfeDetalheImpostoIcmsVO.ValorIcms;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('MOTIVO_DESONERACAO_ICMS').AsString := Current.NfeDetalheImpostoIcmsVO.MotivoDesoneracaoIcms;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('MODALIDADE_BC_ICMS_ST').AsString := Current.NfeDetalheImpostoIcmsVO.ModalidadeBcIcmsSt;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('PERCENTUAL_MVA_ICMS_ST').AsExtended := Current.NfeDetalheImpostoIcmsVO.PercentualMvaIcmsSt;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('PERCENTUAL_REDUCAO_BC_ICMS_ST').AsExtended := Current.NfeDetalheImpostoIcmsVO.PercentualReducaoBcIcmsSt;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_BASE_CALCULO_ICMS_ST').AsExtended := Current.NfeDetalheImpostoIcmsVO.ValorBaseCalculoIcmsSt;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ALIQUOTA_ICMS_ST').AsExtended := Current.NfeDetalheImpostoIcmsVO.AliquotaIcmsSt;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS_ST').AsExtended := Current.NfeDetalheImpostoIcmsVO.ValorIcmsSt;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_BC_ICMS_ST_RETIDO').AsExtended := Current.NfeDetalheImpostoIcmsVO.ValorBcIcmsStRetido;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS_ST_RETIDO').AsExtended := Current.NfeDetalheImpostoIcmsVO.ValorIcmsStRetido;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_BC_ICMS_ST_DESTINO').AsExtended := Current.NfeDetalheImpostoIcmsVO.ValorBcIcmsStDestino;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS_ST_DESTINO').AsExtended := Current.NfeDetalheImpostoIcmsVO.ValorIcmsStDestino;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ALIQUOTA_CREDITO_ICMS_SN').AsExtended := Current.NfeDetalheImpostoIcmsVO.AliquotaCreditoIcmsSn;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_CREDITO_ICMS_SN').AsExtended := Current.NfeDetalheImpostoIcmsVO.ValorCreditoIcmsSn;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('PERCENTUAL_BC_OPERACAO_PROPRIA').AsExtended := Current.NfeDetalheImpostoIcmsVO.PercentualBcOperacaoPropria;
            FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('UF_ST').AsString := Current.NfeDetalheImpostoIcmsVO.UfSt;
            FDataModuleNFe.CDSNfeImpostoIcms.Post;
          end;

          { NfeDetalhe - Imposto - ISSQN }
          if Assigned(Current.NfeDetalheImpostoIssqnVO) then
          begin
            FDataModuleNFe.CDSNfeImpostoIssqn.Append;
            FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ID').AsInteger := Current.NfeDetalheImpostoIssqnVO.Id;
            FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ID_NFE_DETALHE').AsInteger := Current.NfeDetalheImpostoIssqnVO.IdNfeDetalhe;
            FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('BASE_CALCULO_ISSQN').AsExtended := Current.NfeDetalheImpostoIssqnVO.BaseCalculoIssqn;
            FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ALIQUOTA_ISSQN').AsExtended := Current.NfeDetalheImpostoIssqnVO.AliquotaIssqn;
            FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('VALOR_ISSQN').AsExtended := Current.NfeDetalheImpostoIssqnVO.ValorIssqn;
            FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('MUNICIPIO_ISSQN').AsInteger := Current.NfeDetalheImpostoIssqnVO.MunicipioIssqn;
            FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ITEM_LISTA_SERVICOS').AsInteger := Current.NfeDetalheImpostoIssqnVO.ItemListaServicos;
            FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('TRIBUTACAO_ISSQN').AsString := Current.NfeDetalheImpostoIssqnVO.TributacaoIssqn;
            FDataModuleNFe.CDSNfeImpostoIssqn.Post;
          end;

          { NfeDetalhe - Imposto - IPI }
          if Assigned(Current.NfeDetalheImpostoIpiVO) then
          begin
            FDataModuleNFe.CDSNfeImpostoIpi.Append;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ID').AsInteger := Current.NfeDetalheImpostoIpiVO.Id;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ID_NFE_DETALHE').AsInteger := Current.NfeDetalheImpostoIpiVO.IdNfeDetalhe;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ENQUADRAMENTO_IPI').AsString := Current.NfeDetalheImpostoIpiVO.EnquadramentoIpi;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('CNPJ_PRODUTOR').AsString := Current.NfeDetalheImpostoIpiVO.CnpjProdutor;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('CODIGO_SELO_IPI').AsString := Current.NfeDetalheImpostoIpiVO.CodigoSeloIpi;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('QUANTIDADE_SELO_IPI').AsInteger := Current.NfeDetalheImpostoIpiVO.QuantidadeSeloIpi;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ENQUADRAMENTO_LEGAL_IPI').AsString := Current.NfeDetalheImpostoIpiVO.EnquadramentoLegalIpi;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('CST_IPI').AsString := Current.NfeDetalheImpostoIpiVO.CstIpi;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('VALOR_BASE_CALCULO_IPI').AsExtended := Current.NfeDetalheImpostoIpiVO.ValorBaseCalculoIpi;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ALIQUOTA_IPI').AsExtended := Current.NfeDetalheImpostoIpiVO.AliquotaIpi;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('QUANTIDADE_UNIDADE_TRIBUTAVEL').AsExtended := Current.NfeDetalheImpostoIpiVO.QuantidadeUnidadeTributavel;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('VALOR_UNIDADE_TRIBUTAVEL').AsExtended := Current.NfeDetalheImpostoIpiVO.ValorUnidadeTributavel;
            FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('VALOR_IPI').AsExtended := Current.NfeDetalheImpostoIpiVO.ValorIpi;
            FDataModuleNFe.CDSNfeImpostoIpi.Post;
          end;

          { NfeDetalhe - Imposto - II }
          if Assigned(Current.NfeDetalheImpostoIiVO) then
          begin
            FDataModuleNFe.CDSNfeImpostoImportacao.Append;
            FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('ID').AsInteger := Current.NfeDetalheImpostoIiVO.Id;
            FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('ID_NFE_DETALHE').AsInteger := Current.NfeDetalheImpostoIiVO.IdNfeDetalhe;
            FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_BC_II').AsExtended := Current.NfeDetalheImpostoIiVO.ValorBcIi;
            FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_DESPESAS_ADUANEIRAS').AsExtended := Current.NfeDetalheImpostoIiVO.ValorDespesasAduaneiras;
            FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_IMPOSTO_IMPORTACAO').AsExtended := Current.NfeDetalheImpostoIiVO.ValorImpostoImportacao;
            FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_IOF').AsExtended := Current.NfeDetalheImpostoIiVO.ValorIof;
            FDataModuleNFe.CDSNfeImpostoImportacao.Post;
          end;

          { NfeDetalhe - Imposto - PIS }
          if Assigned(Current.NfeDetalheImpostoPisVO) then
          begin
            FDataModuleNFe.CDSNfeImpostoPis.Append;
            FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ID').AsInteger := Current.NfeDetalheImpostoPisVO.Id;
            FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ID_NFE_DETALHE').AsInteger := Current.NfeDetalheImpostoPisVO.IdNfeDetalhe;
            FDataModuleNFe.CDSNfeImpostoPis.FieldByName('CST_PIS').AsString := Current.NfeDetalheImpostoPisVO.CstPis;
            FDataModuleNFe.CDSNfeImpostoPis.FieldByName('QUANTIDADE_VENDIDA').AsExtended := Current.NfeDetalheImpostoPisVO.QuantidadeVendida;
            FDataModuleNFe.CDSNfeImpostoPis.FieldByName('VALOR_BASE_CALCULO_PIS').AsExtended := Current.NfeDetalheImpostoPisVO.ValorBaseCalculoPis;
            FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ALIQUOTA_PIS_PERCENTUAL').AsExtended := Current.NfeDetalheImpostoPisVO.AliquotaPisPercentual;
            FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ALIQUOTA_PIS_REAIS').AsExtended := Current.NfeDetalheImpostoPisVO.AliquotaPisReais;
            FDataModuleNFe.CDSNfeImpostoPis.FieldByName('VALOR_PIS').AsExtended := Current.NfeDetalheImpostoPisVO.ValorPis;
            FDataModuleNFe.CDSNfeImpostoPis.Post;
          end;

          { NfeDetalhe - Imposto - COFINS }
          if Assigned(Current.NfeDetalheImpostoCofinsVO) then
          begin
            FDataModuleNFe.CDSNfeImpostoCofins.Append;
            FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ID').AsInteger := Current.NfeDetalheImpostoCofinsVO.Id;
            FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ID_NFE_DETALHE').AsInteger := Current.NfeDetalheImpostoCofinsVO.IdNfeDetalhe;
            FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('CST_COFINS').AsString := Current.NfeDetalheImpostoCofinsVO.CstCofins;
            FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('QUANTIDADE_VENDIDA').AsExtended := Current.NfeDetalheImpostoCofinsVO.QuantidadeVendida;
            FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('BASE_CALCULO_COFINS').AsExtended := Current.NfeDetalheImpostoCofinsVO.BaseCalculoCofins;
            FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ALIQUOTA_COFINS_PERCENTUAL').AsExtended := Current.NfeDetalheImpostoCofinsVO.AliquotaCofinsPercentual;
            FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ALIQUOTA_COFINS_REAIS').AsExtended := Current.NfeDetalheImpostoCofinsVO.AliquotaCofinsReais;
            FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('VALOR_COFINS').AsExtended := Current.NfeDetalheImpostoCofinsVO.ValorCofins;
            FDataModuleNFe.CDSNfeImpostoCofins.Post;
          end;

          { NfeDetalhe - Declaração Importação }
          TNfeDetEspecificoArmamentoController.SetDataSet(FDataModuleNFe.CDSNfeDeclaracaoImportacao);
          TNfeDeclaracaoImportacaoController.Consulta('ID_NFE_DETALHE=' + QuotedStr(IntToStr(Current.Id)), 0);

          { NfeDetalhe - Específico - Veículo }
          if Assigned(Current.NfeDetEspecificoVeiculoVO) then
          begin
            FDataModuleNFe.CDSNfeDetalheVeiculo.Append;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ID').AsInteger := Current.NfeDetEspecificoVeiculoVO.Id;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ID_NFE_DETALHE').AsInteger := Current.NfeDetEspecificoVeiculoVO.IdNfeDetalhe;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_OPERACAO').AsString := Current.NfeDetEspecificoVeiculoVO.TipoOperacao;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CHASSI').AsString := Current.NfeDetEspecificoVeiculoVO.Chassi;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('COR').AsString := Current.NfeDetEspecificoVeiculoVO.Cor;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('DESCRICAO_COR').AsString := Current.NfeDetEspecificoVeiculoVO.DescricaoCor;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('POTENCIA_MOTOR').AsString := Current.NfeDetEspecificoVeiculoVO.PotenciaMotor;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CILINDRADAS').AsString := Current.NfeDetEspecificoVeiculoVO.Cilindradas;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('PESO_LIQUIDO').AsString := Current.NfeDetEspecificoVeiculoVO.PesoLiquido;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('PESO_BRUTO').AsString := Current.NfeDetEspecificoVeiculoVO.PesoBruto;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('NUMERO_SERIE').AsString := Current.NfeDetEspecificoVeiculoVO.NumeroSerie;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_COMBUSTIVEL').AsString := Current.NfeDetEspecificoVeiculoVO.TipoCombustivel;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('NUMERO_MOTOR').AsString := Current.NfeDetEspecificoVeiculoVO.NumeroMotor;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CAPACIDADE_MAXIMA_TRACAO').AsString := Current.NfeDetEspecificoVeiculoVO.CapacidadeMaximaTracao;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('DISTANCIA_EIXOS').AsString := Current.NfeDetEspecificoVeiculoVO.DistanciaEixos;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ANO_MODELO').AsString := Current.NfeDetEspecificoVeiculoVO.AnoModelo;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ANO_FABRICACAO').AsString := Current.NfeDetEspecificoVeiculoVO.AnoFabricacao;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_PINTURA').AsString := Current.NfeDetEspecificoVeiculoVO.TipoPintura;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_VEICULO').AsString := Current.NfeDetEspecificoVeiculoVO.TipoVeiculo;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ESPECIE_VEICULO').AsString := Current.NfeDetEspecificoVeiculoVO.EspecieVeiculo;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CONDICAO_VIN').AsString := Current.NfeDetEspecificoVeiculoVO.CondicaoVin;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CONDICAO_VEICULO').AsString := Current.NfeDetEspecificoVeiculoVO.CondicaoVeiculo;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CODIGO_MARCA_MODELO').AsString := Current.NfeDetEspecificoVeiculoVO.CodigoMarcaModelo;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CODIGO_COR').AsString := Current.NfeDetEspecificoVeiculoVO.CodigoCor;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('LOTACAO').AsInteger := Current.NfeDetEspecificoVeiculoVO.Lotacao;
            FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('RESTRICAO').AsString := Current.NfeDetEspecificoVeiculoVO.Restricao;
            FDataModuleNFe.CDSNfeDetalheVeiculo.Post;
          end;

          { NfeDetalhe - Específico - Combustível }
          if Assigned(Current.NfeDetEspecificoCombustivelVO) then
          begin
            FDataModuleNFe.CDSNfeDetalheCombustivel.Append;
            FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('ID').AsInteger := Current.NfeDetEspecificoCombustivelVO.Id;
            FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('ID_NFE_DETALHE').AsInteger := Current.NfeDetEspecificoCombustivelVO.IdNfeDetalhe;
            FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('CODIGO_ANP').AsInteger := Current.NfeDetEspecificoCombustivelVO.CodigoAnp;
            FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('CODIF').AsString := Current.NfeDetEspecificoCombustivelVO.Codif;
            FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('QUANTIDADE_TEMP_AMBIENTE').AsExtended := Current.NfeDetEspecificoCombustivelVO.QuantidadeTempAmbiente;
            FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('UF_CONSUMO').AsString := Current.NfeDetEspecificoCombustivelVO.UfConsumo;
            FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('BASE_CALCULO_CIDE').AsExtended := Current.NfeDetEspecificoCombustivelVO.BaseCalculoCide;
            FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('ALIQUOTA_CIDE').AsExtended := Current.NfeDetEspecificoCombustivelVO.AliquotaCide;
            FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('VALOR_CIDE').AsExtended := Current.NfeDetEspecificoCombustivelVO.ValorCide;
            FDataModuleNFe.CDSNfeDetalheCombustivel.Post;
          end;

          { NfeDetalhe - Específico - Medicamento }
          TNfeDetEspecificoMedicamentoController.SetDataSet(FDataModuleNFe.CDSNfeDetalheMedicamento);
          TNfeDetEspecificoMedicamentoController.Consulta('ID_NFE_DETALHE=' + QuotedStr(IntToStr(Current.Id)), 0);

          { NfeDetalhe - Específico - Armamento }
          TNfeDetEspecificoArmamentoController.SetDataSet(FDataModuleNFe.CDSNfeDetalheArmamento);
          TNfeDetEspecificoArmamentoController.Consulta('ID_NFE_DETALHE=' + QuotedStr(IntToStr(Current.Id)), 0);

          FDataModuleNFe.CDSNfeDetalhe.Post;
        end;
      end;
    finally
      NfeDetalheEnumerator.Free;
    end;
    (* Fim do Grupo de Detalhe *)
  end;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFEntradaNF.ActionCadastrarProdutoExecute(Sender: TObject);
begin
  if not FDataModuleNFe.CDSNfeDetalhe.IsEmpty then
  begin
    if FDataModuleNFe.CDSNfeDetalhe.FieldByName('CADASTRADO').AsString = 'N' then
    begin
      if Application.MessageBox('Deseja cadatrar o produto selecionado?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
      begin
        Application.CreateForm(TFproduto, FProduto);
        FProduto.Position := poScreenCenter;
        FProduto.UsadoPorOutroModulo := True;
        FProduto.BotaoInserir.Click;
        Fproduto.EditGtin.Text := FDataModuleNFe.CDSNfeDetalhe.FieldByName('GTIN').AsString;
        Fproduto.EditNcm.Text := FDataModuleNFe.CDSNfeDetalhe.FieldByName('NCM').AsString;
        Fproduto.EditNome.Text := Copy(FDataModuleNFe.CDSNfeDetalhe.FieldByName('NOME_PRODUTO').AsString, 1, 100);
        Fproduto.EditDescricaoPdv.Text := Copy(FDataModuleNFe.CDSNfeDetalhe.FieldByName('NOME_PRODUTO').AsString, 1, 30);
        Fproduto.MemoDescricao.Text := FDataModuleNFe.CDSNfeDetalhe.FieldByName('NOME_PRODUTO').AsString;
        Fproduto.EditValorCompra.Value := FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_BRUTO_PRODUTO').AsExtended;
        Fproduto.EditExTipi.Text := FDataModuleNFe.CDSNfeDetalhe.FieldByName('EX_TIPI').AsString;
        FProduto.ShowModal;
        VerificarProdutosCadatrados;
      end;
    end
    else
      Application.MessageBox('O produto já está cadastrado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Não existem itens para cadastro.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFEntradaNF.ActionExcluirCobrancaExecute(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja remover os dados de cobrança?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    if StatusTela = stInserindo then
      ExcluirDadosCobranca
    else if StatusTela = stEditando then
    begin
      if TNfeCabecalhoController(ObjetoController).Exclui(IdRegistroSelecionado, 'COBRANCA') then
        ExcluirDadosCobranca;
    end;
  end;
end;

procedure TFEntradaNF.ExcluirDadosCobranca;
begin
  FDataModuleNFe.CDSDuplicata.EmptyDataSet;
  //
  EditFaturaNumero.Clear;
  EditFaturaValorOriginal.Clear;
  EditFaturaValorDesconto.Clear;
  EditFaturaValorLiquido.Clear;
end;

procedure TFEntradaNF.ActionExcluirDocumentosReferenciadosExecute(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja remover os documentos referenciados?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    if StatusTela = stInserindo then
      ExcluirDadosReferenciados
    else if StatusTela = stEditando then
    begin
      if TNfeCabecalhoController(ObjetoController).Exclui(IdRegistroSelecionado, 'REFERENCIADO') then
        ExcluirDadosReferenciados;
    end;
  end;
end;

procedure TFEntradaNF.ExcluirDadosReferenciados;
begin
  FDataModuleNFe.CDSNfeReferenciada.EmptyDataSet;
  FDataModuleNFe.CDSNfReferenciada.EmptyDataSet;
  FDataModuleNFe.CDSCupomReferenciado.EmptyDataSet;
  FDataModuleNFe.CDSNfRuralReferenciada.EmptyDataSet;
  FDataModuleNFe.CDSCteReferenciado.EmptyDataSet;
end;

procedure TFEntradaNF.ActionExcluirEntregaRetiradaExecute(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja remover os dados de entrega/retirada?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    if StatusTela = stInserindo then
      ExcluirDadosEntregaRetirada
    else if StatusTela = stEditando then
    begin
      if TNfeCabecalhoController(ObjetoController).Exclui(IdRegistroSelecionado, 'ENTREGA_RETIRADA') then
        ExcluirDadosEntregaRetirada;
    end;
  end;
end;

procedure TFEntradaNF.ExcluirDadosEntregaRetirada;
begin
  { Local Entrega }
  EditEntregaCpfCnpj.Clear;
  EditEntregaLogradouro.Clear;
  EditEntregaNumero.Clear;
  EditEntregaComplemento.Clear;
  EditEntregaBairro.Clear;
  EditEntregaIbge.Clear;
  EditEntregaCidade.Clear;
  EditEntregaUf.Clear;

  { Local Retirada }
  EditRetiradaCpfCnpj.Clear;
  EditRetiradaLogradouro.Clear;
  EditRetiradaNumero.Clear;
  EditRetiradaComplemento.Clear;
  EditRetiradaBairro.Clear;
  EditRetiradaIbge.Clear;
  EditRetiradaCidade.Clear;
  EditRetiradaUf.Clear;
end;

procedure TFEntradaNF.ActionExcluirTransporteExecute(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja remover os dados de transporte?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    if StatusTela = stInserindo then
      ExcluirDadosTransporte
    else if StatusTela = stEditando then
    begin
      if TNfeCabecalhoController(ObjetoController).Exclui(IdRegistroSelecionado, 'TRANSPORTE') then
        ExcluirDadosTransporte;
    end;
  end;
end;

procedure TFEntradaNF.ExcluirDadosTransporte;
begin
  FDataModuleNFe.CDSReboque.EmptyDataSet;
  FDataModuleNFe.CDSVolumes.EmptyDataSet;
  FDataModuleNFe.CDSVolumesLacres.EmptyDataSet;
  //
  EditTransportadorId.Clear;
  ComboModalidadeFrete.ItemIndex := 0;
  EditTransportadorCpfCnpj.Clear;
  EditTransportadorRazaoSocial.Clear;
  EditTransportadorIE.Clear;
  EditTransportadorLogradouro.Clear;
  EditTransportadorCidade.Clear;
  EditTransportadorUF.Clear;
  EditRetencaoIcmsValorServico.Clear;
  EditRetencaoIcmsBaseCalculo.Clear;
  EditRetencaoIcmsAliquota.Clear;
  EditRetencaoIcmsIcmsRetido.Clear;
  EditRetencaoIcmsCfop.Clear;
  EditRetencaoIcmsCidade.Clear;
  EditVeiculoPlaca.Clear;
  EditVeiculoUf.Clear;
  EditVeiculoRntc.Clear;
  EditRetencaoIcmsUf.Clear;
  EditTransporteVagao.Clear;
  EditTransporteBalsa.Clear;
end;

procedure TFEntradaNF.ActionExcluirItemExecute(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja remover o item da nota fiscal?', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    if StatusTela = stInserindo then
      FDataModuleNFe.CDSNfeDetalhe.Delete
    else if StatusTela = stEditando then
    begin
      if TNfeCabecalhoController(ObjetoController).Exclui(FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger, 'DETALHE', FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID_PRODUTO').AsInteger, FDataModuleNFe.CDSNfeDetalhe.FieldByName('QUANTIDADE_COMERCIAL').AsInteger) then
        FDataModuleNFe.CDSNfeDetalhe.Delete;
    end;
  end;
end;

procedure TFEntradaNF.ActionIncluirItemExecute(Sender: TObject);
begin
  { Importar Produto - Inclusão Manual da Nota}
  try
    PopulaCamposTransientesLookup(TProdutoVO, TProdutoController);
    if CDSTransiente.RecordCount > 0 then
    begin
      inc(SeqItem);
      FDataModuleNFe.CDSNfeDetalhe.Append;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger := SeqItem;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID_PRODUTO').AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID_NFE_CABECALHO').AsInteger := 0;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('NUMERO_ITEM').AsInteger := SeqItem;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('CADASTRADO').AsString := 'S';
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('CODIGO_PRODUTO').AsString := CDSTransiente.FieldByName('GTIN').AsString;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('GTIN').AsString := CDSTransiente.FieldByName('GTIN').AsString;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('NOME_PRODUTO').AsString := CDSTransiente.FieldByName('NOME').AsString;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('NCM').AsString := CDSTransiente.FieldByName('NCM').AsString;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('EX_TIPI').AsString := CDSTransiente.FieldByName('EX_TIPI').AsString;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('CFOP').AsInteger := 0; //usuário deve digitar
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('UNIDADE_COMERCIAL').AsString := CDSTransiente.FieldByName('UNIDADE_PRODUTO.SIGLA').AsString;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('QUANTIDADE_COMERCIAL').AsExtended := 0; //usuário deve digitar
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_UNITARIO_COMERCIAL').AsExtended := CDSTransiente.FieldByName('VALOR_VENDA').AsExtended;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_BRUTO_PRODUTO').AsExtended := 0; //usuário deve digitar
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('GTIN_UNIDADE_TRIBUTAVEL').AsString := CDSTransiente.FieldByName('GTIN').AsString;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('UNIDADE_TRIBUTAVEL').AsString := CDSTransiente.FieldByName('UNIDADE_PRODUTO.SIGLA').AsString;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('QUANTIDADE_TRIBUTAVEL').AsExtended := 0; //usuário deve digitar
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_UNITARIO_TRIBUTAVEL').AsExtended := CDSTransiente.FieldByName('VALOR_VENDA').AsExtended;
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_FRETE').AsExtended := 0; //usuário deve digitar
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_SEGURO').AsExtended := 0; //usuário deve digitar
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_DESCONTO').AsExtended := 0; //usuário deve digitar
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_OUTRAS_DESPESAS').AsExtended := 0; //usuário deve digitar
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('ENTRA_TOTAL').AsString := '0';
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_SUBTOTAL').AsExtended := 0; //usuário deve digitar
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_TOTAL').AsExtended := 0; //usuário deve digitar
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('PERSISTE').AsString := 'I';
    end;
  finally
    CDSTransiente.Close;
  end;
end;

procedure TFEntradaNF.ActionSelecionarArquivoExecute(Sender: TObject);
begin
  try
    CarregarDadosXML;
    VerificarProdutosCadatrados;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFEntradaNF.CarregarDadosXML;
var
  i, j, k: Integer;
  NFeRTXT: TNFeRTXT;
  NfeCabecalhoVO: TNfeCabecalhoVO;
begin
  FDataModule.OpenDialog.FileName := '';
  FDataModule.OpenDialog.Title := 'Selecione a NFE';
  FDataModule.OpenDialog.DefaultExt := '*-nfe.XML';
  FDataModule.OpenDialog.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Arquivos TXT (*.TXT)|*.TXT|Todos os Arquivos (*.*)|*.*';
  FDataModule.OpenDialog.InitialDir := FDataModule.ACBrNFe.Configuracoes.Geral.PathSalvar;

  if FDataModule.OpenDialog.Execute then
  begin
    FDataModule.ACBrNFe.NotasFiscais.Clear;

    try
      FDataModule.ACBrNFe.NotasFiscais.LoadFromFile(FDataModule.OpenDialog.FileName);
    except
      Application.MessageBox('Arquivo NFe Inválido.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    with FDataModule.ACBrNFe.NotasFiscais.Items[0].NFe do begin

      //Verifica se a nota já foi importada e está gravada no banco de dados
      NfeCabecalhoVO := TNfeCabecalhoController.VO<TNfeCabecalhoVO>('CHAVE_ACESSO', QuotedStr(procNFe.chNFe));
      if Assigned(NfeCabecalhoVO) then
      begin
        Application.MessageBox('A nota selecionada já foi importada.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
        FDataModule.ACBrNFe.NotasFiscais.Clear;
        Exit;
      end;

      { NFe Cabeçalho }
      EditCodigoNumerico.Text := IntToStr(Ide.cNF);
      EditNaturezaOperacao.Text := Ide.natOp;
      ComboBoxFormaPagamento.ItemIndex := StrToInt(IndpagToStr(Ide.indPag));
      ComboboxModeloNotaFiscal.ItemIndex := AnsiIndexStr(IntToStr(Ide.Modelo), ['1', '55']); ;
      EditSerie.Text := IntToStr(Ide.Serie);
      EditNumeroNfe.Text := IntToStr(Ide.nNF);
      EditDataEmissao.Date := Ide.dEmi;
      EditDataEntradaSaida.Date := Ide.dSaiEnt;
      EditHoraEntradaSaida.Text := FormatDateTime('hh:MM:ss', Ide.hSaiEnt);
      ComboTipoOperacao.ItemIndex := StrToInt(tpNFToStr(Ide.tpNF));
      ComboFormaImpDanfe.ItemIndex := StrToInt(TpImpToStr(Ide.tpImp)) - 1;
      ComboTipoEmissao.ItemIndex := StrToInt(TpEmisToStr(Ide.tpEmis)) - 1;
      EditChaveAcesso.Text := procNFe.chNFe;
      EditDigitoChaveAcesso.Text := IntToStr(Ide.cDV);
      ComboFinalidadeEmissao.ItemIndex := StrToInt(FinNFeToStr(Ide.finNFe)) - 1;

      { NFe Cabeçalho -- Totais }
      EditBCIcms.Value := Total.ICMSTot.vBC;
      EditValorIcms.Value := Total.ICMSTot.vICMS;
      EditBCIcmsSt.Value := Total.ICMSTot.vBCST;
      EditValorIcmsSt.Value := Total.ICMSTot.vST;
      EditTotalProdutos.Value := Total.ICMSTot.vProd;
      EditValorFrete.Value := Total.ICMSTot.vFrete;
      EditValorSeguro.Value := Total.ICMSTot.vSeg;
      EditValorDesconto.Value := Total.ICMSTot.vDesc;
      EditTotalImpostoImportacao.Value := Total.ICMSTot.vII;
      EditValorIPI.Value := Total.ICMSTot.vIPI;
      EditValorPIS.Value := Total.ICMSTot.vPIS;
      EditValorCOFINS.Value := Total.ICMSTot.vCOFINS;
      EditValorOutrasDespesas.Value := Total.ICMSTot.vOutro;
      EditValorTotalNota.Value := Total.ICMSTot.vNF;

      EditValorTotalServicos.Value := Total.ISSQNtot.vServ;
      EditBaseCalculoIssqn.Value := total.ISSQNtot.vBC;
      EditValorIssqn.Value := total.ISSQNtot.vISS;
      EditValorPisIssqn.Value := total.ISSQNtot.vPIS;
      EditValorCofinsIssqn.Value := total.ISSQNtot.vCOFINS;

      EditValorRetidoPis.Value := total.retTrib.vRetPIS;
      EditValorRetidoCofins.Value := total.retTrib.vRetCOFINS;
      EditValorRetidoCsll.Value := total.retTrib.vRetCSLL;
      EditBaseCalculoIrrf.Value := total.retTrib.vBCIRRF;
      EditValorRetidoIrrf.Value := total.retTrib.vIRRF;
      EditBaseCalculoPrevidencia.Value := total.retTrib.vBCRetPrev;
      EditValorRetidoPrevidencia.Value := total.retTrib.vRetPrev;

      { NFe Cabeçalho -- Informações Adicionais }

      EditComexUfEmbarque.Text := exporta.UFembarq;
      EditComexLocalEmbarque.Text := exporta.xLocEmbarq;
      EditCompraNotaEmpenho.Text := compra.xNEmp;
      EditCompraPedido.Text := compra.xPed;
      EditCompraContrato.Text := compra.xCont;
      MemoInfComplementarFisco.Text := InfAdic.infAdFisco;
      MemoInfComplementarContribuinte.Text := InfAdic.infCpl;


      { Emitente }
      EditEmitenteId.Text := '';
      EditEmitenteCpfCnpj.Text := Emit.CNPJCPF;
      EditEmitenteRazao.Text := Emit.xNome;
      EditEmitenteFantasia.Text := Emit.xFant;
      EditEmitenteLogradouro.Text := Emit.EnderEmit.xLgr;
      EditEmitenteNumero.Text := Emit.EnderEmit.nro;
      EditEmitenteComplemento.Text := Emit.EnderEmit.xCpl;
      EditEmitenteBairro.Text := Emit.EnderEmit.xBairro;
      EditEmitenteCodigoIbge.AsInteger := Emit.EnderEmit.cMun;
      EditEmitenteCidade.Text := Emit.EnderEmit.xMun;
      EditEmitenteUF.Text := Emit.EnderEmit.Uf;
      EditEmitenteCEP.Text := IntToStr(Emit.EnderEmit.Cep);
      EditEmitenteTelefone.Text := Emit.EnderEmit.fone;
      EditEmitenteIE.Text := Emit.Ie;
      EditEmitenteIEST.Text := Emit.IEST;
      EditEmitenteIM.Text := Emit.IM;
      ComboEmitenteCrt.ItemIndex := StrToInt(CRTToStr(Emit.Crt)) - 1;
      EditEmitenteCNAE.Text := Emit.CNAE;

      { NFe Detalhe }
      FDataModuleNFe.CDSNfeDetalhe.EmptyDataSet;
      FDataModuleNFe.CDSNfeImpostoIcms.EmptyDataSet;
      FDataModuleNFe.CDSNfeImpostoIssqn.EmptyDataSet;
      FDataModuleNFe.CDSNfeImpostoIpi.EmptyDataSet;
      FDataModuleNFe.CDSNfeImpostoImportacao.EmptyDataSet;
      FDataModuleNFe.CDSNfeImpostoPis.EmptyDataSet;
      FDataModuleNFe.CDSNfeImpostoCofins.EmptyDataSet;
      FDataModuleNFe.CDSNfeDeclaracaoImportacao.EmptyDataSet;
      FDataModuleNFe.CDSNfeImportacaoDetalhe.EmptyDataSet;
      FDataModuleNFe.CDSNfeDetalheVeiculo.EmptyDataSet;
      FDataModuleNFe.CDSNfeDetalheMedicamento.EmptyDataSet;
      FDataModuleNFe.CDSNfeDetalheArmamento.EmptyDataSet;
      FDataModuleNFe.CDSNfeDetalheCombustivel.EmptyDataSet;
      for i := 0 to Det.Count - 1 do begin
        with Det.Items[i] do begin
          FDataModuleNFe.CDSNfeDetalhe.Append;
          // O ID será setado como "i" para facilitar a vinculação com as tabelas filhas no momento de uma inclusão e será zerado antes de subir para o servidor
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID').AsInteger := i;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID_PRODUTO').AsInteger := 0;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID_NFE_CABECALHO').AsInteger := 0;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('NUMERO_ITEM').AsInteger := Prod.nItem;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('CODIGO_PRODUTO').AsString := Prod.cProd;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('GTIN').AsString := Prod.cEAN;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('NOME_PRODUTO').AsString := Prod.xProd;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('NCM').AsString := Prod.Ncm;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('EX_TIPI').AsString := Prod.ExTipi;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('CFOP').AsInteger := StrToInt(Prod.Cfop);
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('UNIDADE_COMERCIAL').AsString := Prod.uCom;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('QUANTIDADE_COMERCIAL').AsExtended := Prod.qCom;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_UNITARIO_COMERCIAL').AsExtended := Prod.vUnCom;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_BRUTO_PRODUTO').AsExtended := Prod.vProd;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('GTIN_UNIDADE_TRIBUTAVEL').AsString := Prod.cEANTrib;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('UNIDADE_TRIBUTAVEL').AsString := Prod.uTrib;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('QUANTIDADE_TRIBUTAVEL').AsExtended := Prod.qTrib;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_UNITARIO_TRIBUTAVEL').AsExtended := Prod.vUnTrib;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_FRETE').AsExtended := Prod.vFrete;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_SEGURO').AsExtended := Prod.vSeg;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_DESCONTO').AsExtended := Prod.vDesc;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_OUTRAS_DESPESAS').AsExtended := Prod.vOutro;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('ENTRA_TOTAL').AsString := indTotToStr(Prod.IndTot);
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_SUBTOTAL').AsExtended := Prod.qCom * Prod.vUnCom;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('VALOR_TOTAL').AsExtended := (Prod.qCom * Prod.vUnCom) + Prod.vFrete + Prod.vSeg + Prod.vOutro - Prod.vDesc;
          FDataModuleNFe.CDSNfeDetalhe.FieldByName('INFORMACOES_ADICIONAIS').AsString := infAdProd;

          { Impostos }
          with Imposto do begin
            if ISSQN.cSitTrib = ISSQNcSitTribVazio then begin
              with ICMS do begin
                FDataModuleNFe.CDSNfeImpostoIcms.Append;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ID_NFE_DETALHE').AsInteger := i;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ORIGEM_MERCADORIA').AsString := OrigToStr(orig);
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('CST_ICMS').AsString := CSTICMSToStr(CST);
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('CSOSN').AsString := CSOSNIcmsToStr(Csosn);
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('MODALIDADE_BC_ICMS').AsString := modBCToStr(modBC);
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('TAXA_REDUCAO_BC_ICMS').AsExtended := pRedBC;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('BASE_CALCULO_ICMS').AsExtended := vBC;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ALIQUOTA_ICMS').AsExtended := pICMS;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS').AsExtended := vICMS;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('MOTIVO_DESONERACAO_ICMS').AsString := motDesICMSToStr(motDesICMS);
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('MODALIDADE_BC_ICMS_ST').AsString := modBCSTToStr(modBCST);
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('PERCENTUAL_MVA_ICMS_ST').AsExtended := pMVAST;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('PERCENTUAL_REDUCAO_BC_ICMS_ST').AsExtended := pRedBCST;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_BASE_CALCULO_ICMS_ST').AsExtended := vBCST;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ALIQUOTA_ICMS_ST').AsExtended := pICMSST;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS_ST').AsExtended := vICMSST;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_BC_ICMS_ST_RETIDO').AsExtended := vBCSTRet;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS_ST_RETIDO').AsExtended := vICMSSTRet;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_BC_ICMS_ST_DESTINO').AsExtended := vBCSTDest;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_ICMS_ST_DESTINO').AsExtended := vICMSSTDest;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('ALIQUOTA_CREDITO_ICMS_SN').AsExtended := pCredSN;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('VALOR_CREDITO_ICMS_SN').AsExtended := vCredICMSSN;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('PERCENTUAL_BC_OPERACAO_PROPRIA').AsExtended := pBCOp;
                FDataModuleNFe.CDSNfeImpostoIcms.FieldByName('UF_ST').AsString := UfSt;
                FDataModuleNFe.CDSNfeImpostoIcms.Post;
              end;
            end
            else begin
              with ISSQN do begin
                FDataModuleNFe.CDSNfeImpostoIssqn.Append;
                FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ID_NFE_DETALHE').AsInteger := i;
                FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('BASE_CALCULO_ISSQN').AsExtended := vBC;
                FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ALIQUOTA_ISSQN').AsExtended := vAliq;
                FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('VALOR_ISSQN').AsExtended := vISSQN;
                FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('MUNICIPIO_ISSQN').AsInteger := cMunFG;
                FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('ITEM_LISTA_SERVICOS').AsInteger := cListServ;
                FDataModuleNFe.CDSNfeImpostoIssqn.FieldByName('TRIBUTACAO_ISSQN').AsString := ISSQNcSitTribToStr(cSitTrib);
                FDataModuleNFe.CDSNfeImpostoIssqn.Post;
              end;
            end;

            if (IPI.vBC > 0) then begin
              with IPI do begin
                FDataModuleNFe.CDSNfeImpostoIpi.Append;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ID_NFE_DETALHE').AsInteger := i;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ENQUADRAMENTO_IPI').AsString := clEnq;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('CNPJ_PRODUTOR').AsString := CNPJProd;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('CODIGO_SELO_IPI').AsString := cSelo;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('QUANTIDADE_SELO_IPI').AsInteger := qSelo;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ENQUADRAMENTO_LEGAL_IPI').AsString := cEnq;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('CST_IPI').AsString := CSTIPIToStr(CST);
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('VALOR_BASE_CALCULO_IPI').AsExtended := vBC;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('ALIQUOTA_IPI').AsExtended := pIPI;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('QUANTIDADE_UNIDADE_TRIBUTAVEL').AsExtended := qUnid;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('VALOR_UNIDADE_TRIBUTAVEL').AsExtended := vUnid;
                FDataModuleNFe.CDSNfeImpostoIpi.FieldByName('VALOR_IPI').AsExtended := vIPI;
                FDataModuleNFe.CDSNfeImpostoIpi.Post;
              end;
            end;

            if (II.vBC > 0) then begin
              with II do begin
                FDataModuleNFe.CDSNfeImpostoImportacao.Append;
                FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('ID_NFE_DETALHE').AsInteger := i;
                FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_BC_II').AsExtended := vBC;
                FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_DESPESAS_ADUANEIRAS').AsExtended := vDespAdu;
                FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_IMPOSTO_IMPORTACAO').AsExtended := vII;
                FDataModuleNFe.CDSNfeImpostoImportacao.FieldByName('VALOR_IOF').AsExtended := vIOF;
                FDataModuleNFe.CDSNfeImpostoImportacao.Post;
              end;
            end;

            with PIS do begin
              FDataModuleNFe.CDSNfeImpostoPis.Append;
              FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ID_NFE_DETALHE').AsInteger := i;
              FDataModuleNFe.CDSNfeImpostoPis.FieldByName('CST_PIS').AsString := CSTPISToStr(CST);
              FDataModuleNFe.CDSNfeImpostoPis.FieldByName('QUANTIDADE_VENDIDA').AsExtended := qBCProd;
              FDataModuleNFe.CDSNfeImpostoPis.FieldByName('VALOR_BASE_CALCULO_PIS').AsExtended := vBC;
              FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ALIQUOTA_PIS_PERCENTUAL').AsExtended := pPIS;
              FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ALIQUOTA_PIS_REAIS').AsExtended := vAliqProd;
              FDataModuleNFe.CDSNfeImpostoPis.FieldByName('VALOR_PIS').AsExtended := vPIS;
              FDataModuleNFe.CDSNfeImpostoPis.Post;
            end;

            if (PISST.vBC > 0) then begin
              with PISST do begin
                FDataModuleNFe.CDSNfeImpostoPis.Append;
                FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ID_NFE_DETALHE').AsInteger := i;
                FDataModuleNFe.CDSNfeImpostoPis.FieldByName('QUANTIDADE_VENDIDA').AsExtended := qBCProd;
                FDataModuleNFe.CDSNfeImpostoPis.FieldByName('VALOR_BASE_CALCULO_PIS').AsExtended := vBC;
                FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ALIQUOTA_PIS_PERCENTUAL').AsExtended := pPIS;
                FDataModuleNFe.CDSNfeImpostoPis.FieldByName('ALIQUOTA_PIS_REAIS').AsExtended := vAliqProd;
                FDataModuleNFe.CDSNfeImpostoPis.FieldByName('VALOR_PIS').AsExtended := vPIS;
                FDataModuleNFe.CDSNfeImpostoPis.Post;
              end;
            end;

            with COFINS do begin
              FDataModuleNFe.CDSNfeImpostoCofins.Append;
              FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ID_NFE_DETALHE').AsInteger := i;
              FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('CST_COFINS').AsString := CSTCOFINSToStr(CST);
              FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('QUANTIDADE_VENDIDA').AsExtended := qBCProd;
              FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('BASE_CALCULO_COFINS').AsExtended := vBC;
              FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ALIQUOTA_COFINS_PERCENTUAL').AsExtended := pCOFINS;
              FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ALIQUOTA_COFINS_REAIS').AsExtended := vAliqProd;
              FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('VALOR_COFINS').AsExtended := vCOFINS;
              FDataModuleNFe.CDSNfeImpostoCofins.Post;
            end;

            if (COFINSST.vBC > 0) then begin
              with COFINSST do begin
                FDataModuleNFe.CDSNfeImpostoCofins.Append;
                FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ID_NFE_DETALHE').AsInteger := i;
                FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('QUANTIDADE_VENDIDA').AsExtended := qBCProd;
                FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('BASE_CALCULO_COFINS').AsExtended := vBC;
                FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ALIQUOTA_COFINS_PERCENTUAL').AsExtended := pCOFINS;
                FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('ALIQUOTA_COFINS_REAIS').AsExtended := vAliqProd;
                FDataModuleNFe.CDSNfeImpostoCofins.FieldByName('VALOR_COFINS').AsExtended := vCOFINS;
                FDataModuleNFe.CDSNfeImpostoCofins.Post;
              end;
            end;
          end;

          { Declaração Importação }
          for j := 0 to Prod.DI.Count - 1 do begin
            if Prod.DI.Items[j].nDi <> '' then begin
              with Prod.DI.Items[j] do begin
                FDataModuleNFe.CDSNfeDeclaracaoImportacao.Append;
                // O ID será setado como "i" para facilitar a vinculação com as tabelas filhas no momento de uma inclusão e será zerado antes de subir para o servidor
                FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('ID').AsInteger := i + j;
                FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('ID_NFE_DETALHE').AsInteger := i;
                FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('NUMERO_DOCUMENTO').AsString := nDi;
                FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('DATA_REGISTRO').AsDateTime := dDi;
                FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('LOCAL_DESEMBARACO').AsString := xLocDesemb;
                FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('UF_DESEMBARACO').AsString := UFDesemb;
                FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('DATA_DESEMBARACO').AsDateTime := dDesemb;
                FDataModuleNFe.CDSNfeDeclaracaoImportacao.FieldByName('UF_DESEMBARACO').AsString := cExportador;
                FDataModuleNFe.CDSNfeDeclaracaoImportacao.Post;

                for k := 0 to adi.Count - 1 do begin
                  with adi.Items[k] do begin
                    FDataModuleNFe.CDSNfeImportacaoDetalhe.Append;
                    FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('ID_NFE_DECLARACAO_IMPORTACAO').AsInteger := i + j;
                    FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('NUMERO_ADICAO').AsInteger := nAdicao;
                    FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('NUMERO_SEQUENCIAL').AsInteger := nSeqAdi;
                    FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('CODIGO_FABRICANTE_ESTRANGEIRO').AsString := cFabricante;
                    FDataModuleNFe.CDSNfeImportacaoDetalhe.FieldByName('VALOR_DESCONTO').AsExtended := vDescDI;
                    FDataModuleNFe.CDSNfeImportacaoDetalhe.Post;
                  end;
                end;
              end;
            end
            else
              Break;
          end;

          { Detalhamento Específico de Veículos novos }
          if Prod.veicProd.Chassi <> '' then begin
            with Prod.veicProd do begin
              FDataModuleNFe.CDSNfeDetalheVeiculo.Append;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ID_NFE_DETALHE').AsInteger := i;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_OPERACAO').AsString := tpOPToStr(tpOP);
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CHASSI').AsString := Chassi;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('COR').AsString := cCor;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('DESCRICAO_COR').AsString := xCor;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('POTENCIA_MOTOR').AsString := pot;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CILINDRADAS').AsString := Cilin;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('PESO_LIQUIDO').AsString := pesoL;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('PESO_BRUTO').AsString := pesoB;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('NUMERO_SERIE').AsString := nSerie;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_COMBUSTIVEL').AsString := tpComb;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('NUMERO_MOTOR').AsString := nMotor;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CAPACIDADE_MAXIMA_TRACAO').AsString := CMT;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('DISTANCIA_EIXOS').AsString := dist;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ANO_MODELO').AsString := IntToStr(anoMod);
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ANO_FABRICACAO').AsString := IntToStr(anoFab);
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_PINTURA').AsString := tpPint;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('TIPO_VEICULO').AsString := IntToStr(tpVeic);
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('ESPECIE_VEICULO').AsString := IntToStr(espVeic);
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CONDICAO_VIN').AsString := VIN;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CONDICAO_VEICULO').AsString := condVeicToStr(condVeic);
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CODIGO_MARCA_MODELO').AsString := cMod;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('CODIGO_COR').AsString := cCorDENATRAN;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('LOTACAO').AsInteger := lota;
              FDataModuleNFe.CDSNfeDetalheVeiculo.FieldByName('RESTRICAO').AsInteger := tpRest;
              FDataModuleNFe.CDSNfeDetalheVeiculo.Post;
            end;
          end;

          { Detalhamento Específico de Medicamento }
          for j := 0 to Prod.med.Count - 1 do begin
            with Prod.med.Items[j] do begin
              FDataModuleNFe.CDSNfeDetalheMedicamento.Append;
              FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('ID_NFE_DETALHE').AsInteger := i;
              FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('NUMERO_LOTE').AsString := nLote;
              FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('QUANTIDADE_LOTE').AsExtended := qLote;
              FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('DATA_FABRICACAO').AsDateTime := dFab;
              FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('DATA_VALIDADE').AsDateTime := dVal;
              FDataModuleNFe.CDSNfeDetalheMedicamento.FieldByName('PRECO_MAXIMO_CONSUMIDOR').AsExtended := vPMC;
              FDataModuleNFe.CDSNfeDetalheMedicamento.Post;
            end;
          end;

          { Detalhamento Específico de Armamentos }
          for j := 0 to Prod.arma.Count - 1 do begin
            with Prod.arma.Items[j] do begin
              FDataModuleNFe.CDSNfeDetalheArmamento.Append;
              FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('ID_NFE_DETALHE').AsInteger := i;
              FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('TIPO_ARMA').AsString := tpArmaToStr(tpArma);
              FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('NUMERO_SERIE_ARMA').AsString := nSerie;
              FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('NUMERO_SERIE_CANO').AsString := nCano;
              FDataModuleNFe.CDSNfeDetalheArmamento.FieldByName('DESCRICAO').AsString := descr;
              FDataModuleNFe.CDSNfeDetalheArmamento.Post;
            end;
          end;

          { Detalhamento Específico de Combustíveis }
          if (Prod.comb.cProdANP > 0) then begin
            with Prod.comb do begin
              FDataModuleNFe.CDSNfeDetalheCombustivel.Append;
              FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('ID_NFE_DETALHE').AsInteger := i;
              FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('CODIGO_ANP').AsInteger := cProdANP;
              FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('CODIF').AsString := Codif;
              FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('QUANTIDADE_TEMP_AMBIENTE').AsExtended := qTemp;
              FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('UF_CONSUMO').AsString := UFCons;
              FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('BASE_CALCULO_CIDE').AsExtended := CIDE.qBCProd;
              FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('ALIQUOTA_CIDE').AsExtended := CIDE.vAliqProd;
              FDataModuleNFe.CDSNfeDetalheCombustivel.FieldByName('VALOR_CIDE').AsExtended := CIDE.vCIDE;
              FDataModuleNFe.CDSNfeDetalheCombustivel.Post;
            end;
          end;

          FDataModuleNFe.CDSNfeDetalhe.Post;
        end;
      end;

      { Grupo de informação das NF/NF-e referenciadas }
      FDataModuleNFe.CDSNfeReferenciada.EmptyDataSet;
      FDataModuleNFe.CDSNfReferenciada.EmptyDataSet;
      FDataModuleNFe.CDSNfRuralReferenciada.EmptyDataSet;
      FDataModuleNFe.CDSCteReferenciado.EmptyDataSet;
      FDataModuleNFe.CDSCupomReferenciado.EmptyDataSet;
      for i := 0 to Ide.NFref.Count - 1 do begin
        { NF-e Referenciadas }
        if Ide.NFref.Items[i].refNFe <> '' then begin
          FDataModuleNFe.CDSNfeReferenciada.Append;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('ID_NFE_CABECALHO').AsInteger := i;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('CHAVE_ACESSO').AsString := Ide.NFref.Items[i].refNFe;
          FDataModuleNFe.CDSNfeReferenciada.Post;
        end;

        { NF 1/1A Referenciadas }
        if Ide.NFref.Items[i].RefNF.Cnpj <> '' then begin
          FDataModuleNFe.CDSNfeReferenciada.Append;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('ID_NFE_CABECALHO').AsInteger := i;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('CODIGO_UF').AsInteger := Ide.NFref.Items[i].RefNF.cUF;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('ANO_MES').AsString := Ide.NFref.Items[i].RefNF.AAMM;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('CNPJ').AsString := Ide.NFref.Items[i].RefNF.Cnpj;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('MODELO').AsInteger := Ide.NFref.Items[i].RefNF.Modelo;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('SERIE').AsInteger := Ide.NFref.Items[i].RefNF.Serie;
          FDataModuleNFe.CDSNfeReferenciada.FieldByName('NUMERO_NF').AsInteger := Ide.NFref.Items[i].RefNF.nNF;
          FDataModuleNFe.CDSNfeReferenciada.Post;
        end;

        { NF de produtor rural referenciada }
        if Ide.NFref.Items[i].RefNFP.CNPJCPF <> '' then begin
          FDataModuleNFe.CDSNfRuralReferenciada.Append;
          FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('ID_NFE_CABECALHO').AsInteger := i;
          FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('CODIGO_UF').AsInteger := Ide.NFref.Items[i].RefNFP.cUF;
          FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('ANO_MES').AsString := Ide.NFref.Items[i].RefNFP.AAMM;
          FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('CNPJ').AsString := Ide.NFref.Items[i].RefNFP.CNPJCPF;
          FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('CPF').AsString := Ide.NFref.Items[i].RefNFP.CNPJCPF;
          FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('INSCRICAO_ESTADUAL').AsString := Ide.NFref.Items[i].RefNFP.Ie;
          FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('MODELO').AsString := Ide.NFref.Items[i].RefNFP.Modelo;
          FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('SERIE').AsInteger := Ide.NFref.Items[i].RefNFP.Serie;
          FDataModuleNFe.CDSNfRuralReferenciada.FieldByName('NUMERO_NF').AsInteger := Ide.NFref.Items[i].RefNFP.nNF;
          FDataModuleNFe.CDSNfRuralReferenciada.Post;
        end;

        { CTF-e Referenciados }
        if Ide.NFref.Items[i].refCTe <> '' then begin
          FDataModuleNFe.CDSCteReferenciado.Append;
          FDataModuleNFe.CDSCteReferenciado.FieldByName('ID_NFE_CABECALHO').AsInteger := i;
          FDataModuleNFe.CDSCteReferenciado.FieldByName('CHAVE_ACESSO').AsString := Ide.NFref.Items[i].refCTe;
          FDataModuleNFe.CDSCteReferenciado.Post;
        end;

        { Cupom Fiscal Referenciados }
        if Ide.NFref.Items[i].RefECF.nCOO <> '' then begin
          FDataModuleNFe.CDSCupomReferenciado.Append;
          FDataModuleNFe.CDSCupomReferenciado.FieldByName('ID_NFE_CABECALHO').AsInteger := i;
          FDataModuleNFe.CDSCupomReferenciado.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString := ECFModRefToStr(Ide.NFref.Items[i].RefECF.Modelo);
          FDataModuleNFe.CDSCupomReferenciado.FieldByName('NUMERO_ORDEM_ECF').AsInteger := StrToInt(Ide.NFref.Items[i].RefECF.nECF);
          FDataModuleNFe.CDSCupomReferenciado.FieldByName('COO').AsString := Ide.NFref.Items[i].RefECF.nCOO;
          FDataModuleNFe.CDSCupomReferenciado.Post;
        end;
      end;

      { Local Entrega }
      if Entrega.CNPJCPF <> '' then begin
        EditEntregaCpfCnpj.Text := Entrega.CNPJCPF;
        EditEntregaLogradouro.Text := Entrega.xLgr;
        EditEntregaNumero.Text := Entrega.nro;
        EditEntregaComplemento.Text := Entrega.xCpl;
        EditEntregaBairro.Text := Entrega.xBairro;
        EditEntregaIbge.AsInteger := Entrega.cMun;
        EditEntregaCidade.Text := Entrega.xMun;
        EditEntregaUf.Text := Entrega.Uf;
      end;

      { Local Retirada }
      if Retirada.CNPJCPF <> '' then begin
        EditRetiradaCpfCnpj.Text := Retirada.CNPJCPF;
        EditRetiradaLogradouro.Text := Retirada.xLgr;
        EditRetiradaNumero.Text := Retirada.nro;
        EditRetiradaComplemento.Text := Retirada.xCpl;
        EditRetiradaBairro.Text := Retirada.xBairro;
        EditRetiradaIbge.AsInteger := Retirada.cMun;
        EditRetiradaCidade.Text := Retirada.xMun;
        EditRetiradaUf.Text := Retirada.Uf;
      end;

      { Transporte }
      EditTransportadorId.Text := '';
      ComboModalidadeFrete.ItemIndex := StrToInt(modFreteToStr(Transp.modFrete));
      EditTransportadorCpfCnpj.Text := Transp.Transporta.CNPJCPF;
      EditTransportadorRazaoSocial.Text := Transp.Transporta.xNome;
      EditTransportadorIE.Text := Transp.Transporta.Ie;
      EditTransportadorLogradouro.Text := Transp.Transporta.xEnder;
      EditTransportadorCidade.Text := Transp.Transporta.xMun;
      EditTransportadorUF.Text := Transp.Transporta.Uf;
      EditRetencaoIcmsValorServico.Value := Transp.retTransp.vServ;
      EditRetencaoIcmsBaseCalculo.Value := Transp.retTransp.vBCRet;
      EditRetencaoIcmsAliquota.Value := Transp.retTransp.pICMSRet;
      EditRetencaoIcmsIcmsRetido.Value := Transp.retTransp.vICMSRet;
      EditRetencaoIcmsCfop.Text := Transp.retTransp.Cfop;
      EditRetencaoIcmsCidade.AsInteger := Transp.retTransp.cMunFG;
      EditVeiculoPlaca.Text := Transp.veicTransp.Placa;
      EditVeiculoUf.Text := Transp.veicTransp.Uf;
      EditVeiculoRntc.Text := Transp.veicTransp.Rntc;
      EditTransporteVagao.Text := Transp.Vagao;
      EditTransporteBalsa.Text := Transp.Balsa;

      FDataModuleNFe.CDSReboque.EmptyDataSet;
      for i := 0 to Transp.Reboque.Count - 1 do begin
        with Transp.Reboque.Items[i] do begin
          FDataModuleNFe.CDSReboque.Append;
          FDataModuleNFe.CDSReboque.FieldByName('PLACA').AsString := Transp.Reboque.Items[i].Placa;
          FDataModuleNFe.CDSReboque.FieldByName('UF').AsString := Transp.Reboque.Items[i].Uf;
          FDataModuleNFe.CDSReboque.FieldByName('RNTC').AsString := Transp.Reboque.Items[i].Rntc;
          FDataModuleNFe.CDSReboque.Post;
        end;
      end;

      FDataModuleNFe.CDSVolumes.EmptyDataSet;
      FDataModuleNFe.CDSVolumesLacres.EmptyDataSet;
      for i := 0 to Transp.Vol.Count - 1 do begin
        with Transp.Vol.Items[i] do begin
          FDataModuleNFe.CDSVolumes.Append;
          FDataModuleNFe.CDSVolumes.FieldByName('QUANTIDADE').AsExtended := qVol;
          FDataModuleNFe.CDSVolumes.FieldByName('ESPECIE').AsString := esp;
          FDataModuleNFe.CDSVolumes.FieldByName('MARCA').AsString := Marca;
          FDataModuleNFe.CDSVolumes.FieldByName('NUMERACAO').AsString := nVol;
          FDataModuleNFe.CDSVolumes.FieldByName('PESO_LIQUIDO').AsExtended := pesoL;
          FDataModuleNFe.CDSVolumes.FieldByName('PESO_BRUTO').AsExtended := pesoB;
          FDataModuleNFe.CDSVolumes.Post;

          for j := 0 to Lacres.Count - 1 do begin
            FDataModuleNFe.CDSVolumesLacres.Append;
            FDataModuleNFe.CDSVolumesLacres.FieldByName('NUMERO').AsString := Lacres.Items[j].nLacre;
            FDataModuleNFe.CDSVolumesLacres.Post;
          end;
        end;
      end;

      { Fatura }
      EditFaturaNumero.Text := Cobr.Fat.nFat;
      EditFaturaValorOriginal.Value := Cobr.Fat.vOrig;
      EditFaturaValorDesconto.Value := Cobr.Fat.vDesc;
      EditFaturaValorLiquido.Value := Cobr.Fat.vLiq;

      { Duplicatas }
      FDataModuleNFe.CDSDuplicata.EmptyDataSet;
      for i := 0 to Cobr.Dup.Count - 1 do begin
        with Cobr.Dup.Items[i] do begin
          FDataModuleNFe.CDSDuplicata.Append;
          FDataModuleNFe.CDSDuplicata.FieldByName('NUMERO').AsString := nDup;
          FDataModuleNFe.CDSDuplicata.FieldByName('DATA_VENCIMENTO').AsDateTime := dVenc;
          FDataModuleNFe.CDSDuplicata.FieldByName('VALOR').AsExtended := vDup;
          FDataModuleNFe.CDSDuplicata.Post;
        end;
      end;

      MemoInfComplementarContribuinte.Text := InfAdic.infCpl;
      MemoInfComplementarFisco.Text := InfAdic.infAdFisco;
    end;
    ActionSelecionarArquivo.Enabled := False;
  end;
end;

function TFEntradaNF.VerificarDadosFornecedor: Boolean;
var
  PessoaFornecedorVO: TViewPessoaFornecedorVO;
begin
  PessoaFornecedorVO := TViewPessoaFornecedorController.VO<TViewPessoaFornecedorVO>('CPF_CNPJ', QuotedStr(EditEmitenteCpfCnpj.Text));
  if Assigned(PessoaFornecedorVO) then
  begin
    EditEmitenteId.AsInteger := PessoaFornecedorVO.Id;
    Result := True;
  end
  else
    Result := False;
end;

function TFEntradaNF.VerificarDadosTransportadora: Boolean;
var
  PessoaTransportadoraVO: TViewPessoaTransportadoraVO;
begin
  PessoaTransportadoraVO := TViewPessoaTransportadoraController.VO<TViewPessoaTransportadoraVO>('CPF_CNPJ', QuotedStr(EditTransportadorCpfCnpj.Text));
  if Assigned(PessoaTransportadoraVO) then
  begin
    EditTransportadorId.AsInteger := PessoaTransportadoraVO.Id;
    Result := True;
  end
  else
    Result := False;
end;

function TFEntradaNF.VerificarProdutosCadatrados: Boolean;
var
  ProdutoVO: TProdutoVO;
  TodosCadastrados: Boolean;
begin
  TodosCadastrados := True;
  FDataModuleNFe.CDSNfeDetalhe.DisableControls;
  FDataModuleNFe.CDSNfeDetalhe.First;
  while not FDataModuleNFe.CDSNfeDetalhe.Eof do
  begin
    ProdutoVO := TProdutoController.VO<TProdutoVO>('GTIN', FDataModuleNFe.CDSNfeDetalhe.FieldByName('GTIN').AsString);
    FDataModuleNFe.CDSNfeDetalhe.Edit;
    if Assigned(ProdutoVO) then
    begin
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('CADASTRADO').AsString := 'S';
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('ID_PRODUTO').AsInteger := ProdutoVO.Id;
    end
    else
    begin
      FDataModuleNFe.CDSNfeDetalhe.FieldByName('CADASTRADO').AsString := 'N';
      TodosCadastrados := False;
    end;
    FDataModuleNFe.CDSNfeDetalhe.Post;
    FDataModuleNFe.CDSNfeDetalhe.Next;
  end;
  FDataModuleNFe.CDSNfeDetalhe.First;
  FDataModuleNFe.CDSNfeDetalhe.EnableControls;
  //
  Result := TodosCadastrados;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFEntradaNF.EditEmitenteIdExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditEmitenteId.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditEmitenteId.Text;
      LimparCamposEmitente;
      if not PopulaCamposTransientes(Filtro, TViewPessoaFornecedorVO, TViewPessoaFornecedorController) then
        PopulaCamposTransientesLookup(TViewPessoaFornecedorVO, TViewPessoaFornecedorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditEmitenteId.Text := CDSTransiente.FieldByName('ID').AsString;
        EditEmitenteCpfCnpj.Text := CDSTransiente.FieldByName('CPF_CNPJ').AsString;
        EditEmitenteRazao.Text := CDSTransiente.FieldByName('NOME').AsString;
        EditEmitenteFantasia.Text := CDSTransiente.FieldByName('NOME').AsString;
        EditEmitenteLogradouro.Text := CDSTransiente.FieldByName('LOGRADOURO').AsString;
        EditEmitenteNumero.Text := CDSTransiente.FieldByName('NUMERO').AsString;
        EditEmitenteComplemento.Text := CDSTransiente.FieldByName('COMPLEMENTO').AsString;
        EditEmitenteBairro.Text := CDSTransiente.FieldByName('BAIRRO').AsString;
        EditEmitenteCodigoIbge.AsInteger := CDSTransiente.FieldByName('MUNICIPIO_IBGE').AsInteger;
        EditEmitenteCidade.Text := CDSTransiente.FieldByName('MUNICIPIO_IBGE').AsString;
        EditEmitenteUF.Text := CDSTransiente.FieldByName('UF').AsString;
        EditEmitenteCEP.Text := CDSTransiente.FieldByName('CEP').AsString;
        EditEmitenteTelefone.Text := CDSTransiente.FieldByName('FONE').AsString;
        EditEmitenteEmail.Text := CDSTransiente.FieldByName('EMAIL').AsString;
      end
      else
      begin
        Exit;
        EditEmitenteId.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    LimparCamposEmitente;
  end;
end;

procedure TFEntradaNF.EditEmitenteIdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditEmitenteId.Value := -1;
    EditEmitenteCpfCnpj.SetFocus;
  end;
end;

procedure TFEntradaNF.EditEmitenteIdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditEmitenteCpfCnpj.SetFocus;
  end;
end;

procedure TFEntradaNF.EditTransportadorIdExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditTransportadorId.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditTransportadorId.Text;
      LimparCamposTransportadora;
      if not PopulaCamposTransientes(Filtro, TViewPessoaTransportadoraVO, TViewPessoaTransportadoraController) then
        PopulaCamposTransientesLookup(TViewPessoaTransportadoraVO, TViewPessoaTransportadoraController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditTransportadorId.Text := CDSTransiente.FieldByName('ID').AsString;
        EditTransportadorCpfCnpj.Text := CDSTransiente.FieldByName('CPF_CNPJ').AsString;
        EditTransportadorRazaoSocial.Text := CDSTransiente.FieldByName('NOME').AsString;
        EditTransportadorLogradouro.Text := CDSTransiente.FieldByName('LOGRADOURO').AsString;
        EditTransportadorCidade.Text := CDSTransiente.FieldByName('MUNICIPIO_IBGE').AsString;
        EditTransportadorUF.Text := CDSTransiente.FieldByName('UF').AsString;
      end
      else
      begin
        Exit;
        EditTransportadorId.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    LimparCamposTransportadora;
  end;
end;

procedure TFEntradaNF.EditTransportadorIdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditTransportadorId.Value := -1;
    EditTransportadorCpfCnpj.SetFocus;
  end;
end;

procedure TFEntradaNF.EditTransportadorIdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditTransportadorCpfCnpj.SetFocus;
  end;
end;
{$ENDREGION}

end.
