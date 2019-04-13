{ *******************************************************************************
  Title: T2Ti ERP
  Description: Unit criada pelo DataSnap - Contem os componentes do SA

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

  @author Fábio Thomaz | Albert Eije (T2Ti.COM)
  @version 1.1
  ******************************************************************************* }
unit ServerContainer;

interface

uses
  SysUtils, Classes, DSTCPServerTransport, DSHTTPCommon, DSHTTP, DSServer,
  DSCommonServer, Windows, WideStrings, DB, SqlExpr, ConexaoBD, DBXJSON,
  UsuarioVO, SessaoUsuario, FuncaoController, ListaFuncaoController,
  ListaPapelFuncaoController, PapelFuncaoController;

type
  TFServerContainer = class(TDataModule)
    DSServer: TDSServer;
    DSHTTPService: TDSHTTPService;
    DSHTTPServiceAuthenticationManager: TDSHTTPServiceAuthenticationManager;
    procedure DSHTTPServiceAuthenticationManagerHTTPAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean);
  private
    FLOG: TStrings;
    Modulo: String;

    procedure RegistrarClasse(pClasse: TPersistentClass);
    function GetUsuario(pSessao, pLogin, pSenha: string): TUsuarioVO;
    function Sessao: TListaSessaoUsuario;
  public
    property Log: TStrings read FLOG write FLOG;

    procedure RegistrarClasses;
    procedure GravaLog(Valor: String);
    procedure ConectarBD;

  end;

var
  FServerContainer: TFServerContainer;

implementation

uses
  DSServerClass,

  // Infra
  ViewSessaoEmpresaController, ViewColaboradorPisController,

  // Cadastros
  BancoController, PaisController, UfController, MunicipioController,
  ColaboradorController, UnidadeProdutoController, TipoRelacionamentoController,
  ProdutoMarcaController, SetorController, AgenciaBancoController,
  ProdutoGrupoController, ProdutoSubGrupoController, AlmoxarifadoController,
  EstadoCivilController, PessoaController, NcmController, TipoAdmissaoController,
  NivelFormacaoController, CfopController, CboController, CargoController,
  AtividadeForCliController, SituacaoForCliController, ClienteController,
  FornecedorController, EmpresaController, EnderecoController, ProdutoController,
  BaseCreditoPisController, CepController, ChequeController, TalonarioChequeController,
  ContaCaixaController, ConvenioController, OperadoraCartaoController,
  OperadoraPlanoSaudeController, SindicatoController, SituacaoColaboradorController,
  TipoColaboradorController,SalarioMinimoController,CodigoGpsController,TipoDesligamentoController, 
  SefipCodigoMovimentacaoController,SefipCodigoRecolhimentoController,SefipCategoriaTrabalhoController,
  TipoItemSpedController,SpedPis4310Controller, SpedPis4313Controller, SpedPis4314Controller,
  SpedPis4315Controller,SpedPis4316Controller, SpedPis439Controller, TipoCreditoPisController,
  SituacaoDocumentoController,CsosnAController, CsosnBController, CstCofinsController, CstIcmsAController,
  CstIcmsBController,CstIpiController, CstPisController, FeriadosController, ContadorController,
  ContatoController, TransportadoraController, ViewPessoaFornecedorController,
  IndiceEconomicoController, CodigoApuracaoEfdController, TipoReceitaDipiController,
  ViewPessoaTransportadoraController, ViewPessoaClienteController, ViewPessoaContadorController,
  FPasController, CnaeController,

  // Administrativo
  UsuarioController, PapelController, AuditoriaController, AdmParametroController,
  EmpresaCnaeController, QuadroSocietarioController, SocioController,

  // Tributação
  TributOperacaoFiscalController, TributGrupoTributarioController,
  TributConfiguraOfGtController, TributIcmsUfController, TributIcmsCustomCabController,
  TributIcmsCustomDetController, TributIssController, ViewTributacaoIssController,
  ViewTributacaoIcmsController, ViewTributacaoPisController, ViewTributacaoCofinsController,
  ViewTributacaoIpiController, ViewTributacaoIcmsCustomController,


  // GED
  GedTipoDocumentoController, GedDocumentoController, DownloadArquivoController,

  // Tesouraria
  ViewFinResumoTesourariaController,

  // Financeiro
  FinDocumentoOrigemController, NaturezaFinanceiraController, CentroResultadoController,
  PlanoNaturezaFinanceiraController, PlanoCentroResultadoController, FinStatusParcelaController,
  ViewFinTotalRecebimentosDiaController, ViewFinTotalPagamentosDiaController,

  // Contas a Pagar
  FinLancamentoPagarController, FinParcelaPagamentoController, FinParcelaPagarController,
  FinTipoPagamentoController, ViewFinLancamentoPagarController, ViewFinChequesEmSerController,

  // Contas a Receber
  FinParcelaRecebimentoController, FinTipoRecebimentoController, FinLancamentoReceberController,
  FinParcelaReceberController, ViewFinLancamentoReceberController, FinConfiguracaoBoletoController,

  // Caixa e Bancos
  ViewFinMovimentoCaixaBancoController, FinFechamentoCaixaBancoController,
  ViewFinChequeNaoCompensadoController,

  // Conciliação Bancária
  FinExtratoContaBancoController, ViewFinChequeEmitidoController,

  // Fluxo de Caixa
  ViewFinFluxoCaixaController,

  // Orçamentos
  OrcamentoEmpresarialController, OrcamentoPeriodoController, OrcamentoDetalheController,
  OrcamentoFluxoCaixaController, OrcamentoFluxoCaixaDetalheController, OrcamentoFluxoCaixaPeriodoController,

  // Compras
  CompraTipoRequisicaoController, CompraRequisicaoController, CompraRequisicaoDetalheController,
  CompraTipoPedidoController, CompraPedidoController, CompraPedidoDetalheController,
  CompraCotacaoController, CompraFornecedorCotacaoController, CompraCotacaoDetalheController,
  ViewCompraRequisicaoItemCotadoController, ViewCompraMapaComparativoController,

  // Vendas
  TipoNotaFiscalController, VendaCondicoesPagamentoController,
  VendaOrcamentoCabecalhoController, VendedorController, VendaCabecalhoController,
  VendaFreteController, VendaRomaneioEntregaController, VendaDetalheController,
  VendaOrcamentoDetalheController,

  // Gestão de Contratos
  ContratoTipoServicoController, TipoContratoController, ContratoTemplateController,
  ContratoSolicitacaoServicoController, ContratoController, ViewContratoDadosContratanteController,

  // NFe
  NFeCabecalhoController, NFeNumeroController, NFeDetalheController, NFeConfiguracaoController,
  NFeDetEspecificoMedicamentoController, NFeDetEspecificoArmamentoController,
  NFeDeclaracaoImportacaoController,

  // Controle de Estoque
  EntradaNFController, RequisicaoInternaCabecalhoController, RequisicaoInternaDetalheController,
  EstoqueContagemCabecalhoController, EstoqueReajusteCabecalhoController, ControleEstoqueController,

  // Controle Patrimonial
  PatrimIndiceAtualizacaoController, PatrimTaxaDepreciacaoController,
  PatrimTipoAquisicaoBemController, PatrimTipoMovimentacaoController,
  PatrimEstadoConservacaoController, PatrimGrupoBemController, SeguradoraController,
  PatrimApoliceSeguroController, PatrimBemController,

  // Ponto Eletrônico
  PontoParametroController, PontoHorarioController, PontoRelogioController,
  PontoClassificacaoJornadaController, PontoAbonoController, PontoAbonoUtilizacaoController,
  PontoEscalaController, PontoBancoHorasController, PontoHorarioAutorizadoController,
  PontoMarcacaoController, ViewPontoMarcacaoController, ViewPontoEscalaTurmaController,
  PontoFechamentoJornadaController,

  // Folha de Pagamento
  FolhaParametrosController, GuiasAcumuladasController, FolhaPlanoSaudeController,
  FolhaEventoController, FolhaTipoAfastamentoController, FolhaAfastamentoController,
  FolhaFeriasColetivasController, FeriasPeriodoAquisitivoController, FolhaFechamentoController,
  FolhaLancamentoCabecalhoController, FolhaHistoricoSalarialController,
  FolhaValeTransporteController, FolhaRescisaoController, FolhaPppController,
  FolhaInssServicoController, FolhaInssController, EmpresaTransporteItinerarioController,
  ViewPessoaColaboradorController,

  // Contabilidade
  RegistroCartorioController, ContabilParametrosController, ContabilIndiceController,
  ContabilHistoricoController, AidfAimdfController, FapController, PlanoContaController,
  PlanoContaRefSpedController, ContabilContaController, ContabilLancamentoPadraoController,
  ContabilLoteController, ContabilLancamentoOrcadoController, ContabilLancamentoCabecalhoController,
  ContabilFechamentoController, ContabilDreCabecalhoController, ContabilEncerramentoExeCabController,
  ContabilLivroController,

  // Conciliação Contábil
  ContabilLancamentoDetalheController, ViewConciliaClienteController,
  ViewConciliaFornecedorController,

  // Escrita Fiscal
  FiscalLivroController, SimplesNacionalCabecalhoController,
  FiscalParametrosController, FiscalApuracaoIcmsController,

  // Sintegra
  SintegraController,

  // Sped
  SpedFiscalController, SpedContabilController;
  //
{$R *.dfm}
procedure TFServerContainer.RegistrarClasses;
begin
  // Infra
  Modulo := 'Infra';
  RegistrarClasse(TViewSessaoEmpresaController);
  RegistrarClasse(TViewColaboradorPisController);

  // Administrativo
  Modulo :='Administrativo';
  RegistrarClasse(TUsuarioController);
  RegistrarClasse(TPapelController);
  RegistrarClasse(TFuncaoController);
  RegistrarClasse(TListaFuncaoController);
  RegistrarClasse(TPapelFuncaoController);
  RegistrarClasse(TListaPapelFuncaoController);
  RegistrarClasse(TAuditoriaController);
  RegistrarClasse(TAdmParametroController);
  RegistrarClasse(TEmpresaCnaeController);
  RegistrarClasse(TQuadroSocietarioController);
  RegistrarClasse(TSocioController);

  // Cadastros
  Modulo := 'Cadastros';
  RegistrarClasse(TBancoController);
  RegistrarClasse(TPaisController);
  RegistrarClasse(TColaboradorController);
  RegistrarClasse(TUnidadeProdutoController);
  RegistrarClasse(TEstadoCivilController);
  RegistrarClasse(TPessoaController);
  RegistrarClasse(TProdutoMarcaController);
  RegistrarClasse(TSetorController);
  RegistrarClasse(TAgenciaBancoController);
  RegistrarClasse(TProdutoGrupoController);
  RegistrarClasse(TProdutoSubGrupoController);
  RegistrarClasse(TAlmoxarifadoController);
  RegistrarClasse(TNcmController);
  RegistrarClasse(TUfController);
  RegistrarClasse(TMunicipioController);
  RegistrarClasse(TTipoRelacionamentoController);
  RegistrarClasse(TTipoAdmissaoController);
  RegistrarClasse(TNivelFormacaoController);
  RegistrarClasse(TCfopController);
  RegistrarClasse(TCboController);
  RegistrarClasse(TCargoController);
  RegistrarClasse(TAtividadeForCliController);
  RegistrarClasse(TSituacaoForCliController);
  RegistrarClasse(TClienteController);
  RegistrarClasse(TFornecedorController);
  RegistrarClasse(TEmpresaController);
  RegistrarClasse(TEnderecoController);
  RegistrarClasse(TContatoController);
  RegistrarClasse(TProdutoController);
  RegistrarClasse(TBaseCreditoPisController);
  RegistrarClasse(TCepController);
  RegistrarClasse(TChequeController);
  RegistrarClasse(TTalonarioChequeController);
  RegistrarClasse(TContaCaixaController);
  RegistrarClasse(TConvenioController);
  RegistrarClasse(TOperadoraCartaoController);
  RegistrarClasse(TOperadoraPlanoSaudeController);
  RegistrarClasse(TSindicatoController);
  RegistrarClasse(TSituacaoColaboradorController);
  RegistrarClasse(TTipoColaboradorController);
  RegistrarClasse(TSalarioMinimoController);
  RegistrarClasse(TCodigoGpsController);
  RegistrarClasse(TTipoDesligamentoController);
  RegistrarClasse(TSefipCodigoMovimentacaoController);
  RegistrarClasse(TSefipCodigoRecolhimentoController);
  RegistrarClasse(TSefipCategoriaTrabalhoController);
  RegistrarClasse(TTipoItemSpedController);
  RegistrarClasse(TSpedPis4310Controller);
  RegistrarClasse(TSpedPis4313Controller);
  RegistrarClasse(TSpedPis4314Controller);
  RegistrarClasse(TSpedPis4315Controller);
  RegistrarClasse(TSpedPis4316Controller);
  RegistrarClasse(TSpedPis439Controller);
  RegistrarClasse(TTipoCreditoPisController);
  RegistrarClasse(TSituacaoDocumentoController);
  RegistrarClasse(TCsosnAController);
  RegistrarClasse(TCsosnBController);
  RegistrarClasse(TCstCofinsController);
  RegistrarClasse(TCstIcmsAController);
  RegistrarClasse(TCstIcmsBController);
  RegistrarClasse(TCstIpiController);
  RegistrarClasse(TCstPisController);
  RegistrarClasse(TFeriadosController);
  RegistrarClasse(TContadorController);
  RegistrarClasse(TTransportadoraController);
  RegistrarClasse(TIndiceEconomicoController);
  RegistrarClasse(TCodigoApuracaoEfdController);
  RegistrarClasse(TTipoReceitaDipiController);
  RegistrarClasse(TViewPessoaFornecedorController);
  RegistrarClasse(TViewPessoaTransportadoraController);
  RegistrarClasse(TViewPessoaClienteController);
  RegistrarClasse(TViewPessoaContadorController);
  RegistrarClasse(TFPasController);
  RegistrarClasse(TCnaeController);

  // Tributação
  Modulo :='Tributação';
  RegistrarClasse(TTributOperacaoFiscalController);
  RegistrarClasse(TTributGrupoTributarioController);
  RegistrarClasse(TTributConfiguraOfGtController);
  RegistrarClasse(TTributIcmsUfController);
  RegistrarClasse(TTributIcmsCustomCabController);
  RegistrarClasse(TTributIcmsCustomDetController);
  RegistrarClasse(TTributIssController);
  RegistrarClasse(TViewTributacaoIssController);
  RegistrarClasse(TViewTributacaoIcmsController);
  RegistrarClasse(TViewTributacaoPisController);
  RegistrarClasse(TViewTributacaoCofinsController);
  RegistrarClasse(TViewTributacaoIpiController);

  // GED
  Modulo := 'GED';
  RegistrarClasse(TGedTipoDocumentoController);
  RegistrarClasse(TGedDocumentoController);
  RegistrarClasse(TDownloadArquivoController);

  // Tesouraria
  Modulo := 'Tesouraria';
  RegistrarClasse(TViewFinResumoTesourariaController);

  // Financeiro
  Modulo := 'Financeiro';
  RegistrarClasse(TFinDocumentoOrigemController);
  RegistrarClasse(TNaturezaFinanceiraController);
  RegistrarClasse(TCentroResultadoController);
  RegistrarClasse(TPlanoNaturezaFinanceiraController);
  RegistrarClasse(TPlanoCentroResultadoController);
  RegistrarClasse(TFinStatusParcelaController);
  RegistrarClasse(TViewFinTotalRecebimentosDiaController);
  RegistrarClasse(TViewFinTotalPagamentosDiaController);

  // Contas a Pagar
  Modulo := 'Contas a Pagar';
  RegistrarClasse(TFinTipoPagamentoController);
  RegistrarClasse(TFinLancamentoPagarController);
  RegistrarClasse(TFinParcelaPagarController);
  RegistrarClasse(TFinParcelaPagamentoController);
  RegistrarClasse(TViewFinLancamentoPagarController);
  RegistrarClasse(TViewFinChequesEmSerController);

  // Contas a Receber
  Modulo := 'Contas a Receber';
  RegistrarClasse(TFinTipoRecebimentoController);
  RegistrarClasse(TFinLancamentoReceberController);
  RegistrarClasse(TFinParcelaReceberController);
  RegistrarClasse(TFinParcelaRecebimentoController);
  RegistrarClasse(TViewFinLancamentoReceberController);
  RegistrarClasse(TFinConfiguracaoBoletoController);

  // Caixa e Bancos
  Modulo := 'Caixa e Bancos';
  RegistrarClasse(TViewFinMovimentoCaixaBancoController);
  RegistrarClasse(TFinFechamentoCaixaBancoController);
  RegistrarClasse(TViewFinChequeNaoCompensadoController);

  // Conciliação Bancária
  Modulo := 'Conciliação Bancária';
  RegistrarClasse(TFinExtratoContaBancoController);
  RegistrarClasse(TViewFinChequeEmitidoController);

  //Fluxo de Caixa
  Modulo := 'Fluxo de Caixa';
  RegistrarClasse(TViewFinFluxoCaixaController);

  //Orçamentos
  Modulo := 'Orçamentos';
  RegistrarClasse(TOrcamentoEmpresarialController);
  RegistrarClasse(TOrcamentoPeriodoController);
  RegistrarClasse(TOrcamentoDetalheController);
  RegistrarClasse(TOrcamentoFluxoCaixaController);
  RegistrarClasse(TOrcamentoFluxoCaixaDetalheController);
  RegistrarClasse(TOrcamentoFluxoCaixaPeriodoController);

  // Compras
  Modulo := 'Compras';
  RegistrarClasse(TCompraTipoRequisicaoController);
  RegistrarClasse(TCompraRequisicaoController);
  RegistrarClasse(TCompraRequisicaoDetalheController);
  RegistrarClasse(TCompraTipoPedidoController);
  RegistrarClasse(TCompraPedidoController);
  RegistrarClasse(TCompraPedidoDetalheController);
  RegistrarClasse(TCompraCotacaoController);
  RegistrarClasse(TCompraCotacaoDetalheController);
  RegistrarClasse(TCompraFornecedorCotacaoController);
  RegistrarClasse(TViewCompraRequisicaoItemCotadoController);
  RegistrarClasse(TViewCompraMapaComparativoController);

  // Vendas
  Modulo := 'Vendas';
  RegistrarClasse(TTipoNotaFiscalController);
  RegistrarClasse(TVendaCondicoesPagamentoController);
  RegistrarClasse(TVendaOrcamentoCabecalhoController);
  RegistrarClasse(TVendaOrcamentoDetalheController);
  RegistrarClasse(TVendedorController);
  RegistrarClasse(TVendaCabecalhoController);
  RegistrarClasse(TVendaDetalheController);
  RegistrarClasse(TVendaFreteController);
  RegistrarClasse(TVendaRomaneioEntregaController);

  // Gestão de Contratos
  Modulo := ' Gestão de Contratos';
  RegistrarClasse(TContratoTipoServicoController);
  RegistrarClasse(TTipoContratoController);
  RegistrarClasse(TContratoSolicitacaoServicoController);
  RegistrarClasse(TContratoController);
  RegistrarClasse(TContratoTemplateController);
  RegistrarClasse(TViewContratoDadosContratanteController);

  //NFe
  Modulo := 'NFe';
  RegistrarClasse(TNFeCabecalhoController);
  RegistrarClasse(TNFeDetalheController);
  RegistrarClasse(TNFeNumeroController);
  RegistrarClasse(TNFeConfiguracaoController);
  RegistrarClasse(TNFeDetEspecificoMedicamentoController);
  RegistrarClasse(TNFeDetEspecificoArmamentoController);
  RegistrarClasse(TNFeDeclaracaoImportacaoController);

  //Controle de Estoque
  Modulo := 'Controle de Estoque';
  RegistrarClasse(TEntradaNFController);
  RegistrarClasse(TRequisicaoInternaCabecalhoController);
  RegistrarClasse(TRequisicaoInternaDetalheController);
  RegistrarClasse(TEstoqueContagemCabecalhoController);
  RegistrarClasse(TEstoqueReajusteCabecalhoController);
  RegistrarClasse(TControleEstoqueController);

  //Controle Patrimonial
  Modulo := 'Controle Patrimonial';
  RegistrarClasse(TPatrimIndiceAtualizacaoController);
  RegistrarClasse(TPatrimTaxaDepreciacaoController);
  RegistrarClasse(TPatrimTipoAquisicaoBemController);
  RegistrarClasse(TPatrimTipoMovimentacaoController);
  RegistrarClasse(TPatrimEstadoConservacaoController);
  RegistrarClasse(TPatrimGrupoBemController);
  RegistrarClasse(TSeguradoraController);
  RegistrarClasse(TPatrimApoliceSeguroController);
  RegistrarClasse(TPatrimBemController);

  //Ponto Eletrônico
  RegistrarClasse(TPontoParametroController);
  RegistrarClasse(TPontoHorarioController);
  RegistrarClasse(TPontoRelogioController);
  RegistrarClasse(TPontoClassificacaoJornadaController);
  RegistrarClasse(TPontoAbonoController);
  RegistrarClasse(TPontoAbonoUtilizacaoController);
  RegistrarClasse(TPontoEscalaController);
  RegistrarClasse(TPontoBancoHorasController);
  RegistrarClasse(TPontoHorarioAutorizadoController);
  RegistrarClasse(TPontoMarcacaoController);
  RegistrarClasse(TViewPontoMarcacaoController);
  RegistrarClasse(TViewPontoEscalaTurmaController);
  RegistrarClasse(TPontoFechamentoJornadaController);

  //Folha de Pagamento
  RegistrarClasse(TFolhaParametrosController);
  RegistrarClasse(TGuiasAcumuladasController);
  RegistrarClasse(TFolhaPlanoSaudeController);
  RegistrarClasse(TFolhaEventoController);
  RegistrarClasse(TFolhaTipoAfastamentoController);
  RegistrarClasse(TFolhaAfastamentoController);
  RegistrarClasse(TFolhaFeriasColetivasController);
  RegistrarClasse(TFeriasPeriodoAquisitivoController);
  RegistrarClasse(TFolhaFechamentoController);
  RegistrarClasse(TFolhaLancamentoCabecalhoController);
  RegistrarClasse(TFolhaHistoricoSalarialController);
  RegistrarClasse(TFolhaValeTransporteController);
  RegistrarClasse(TFolhaRescisaoController);
  RegistrarClasse(TFolhaPppController);
  RegistrarClasse(TFolhaInssServicoController);
  RegistrarClasse(TFolhaInssController);
  RegistrarClasse(TEmpresaTransporteItinerarioController);
  RegistrarClasse(TViewPessoaColaboradorController);

  //Contabilidade
  Modulo := 'Contabilidade';
  RegistrarClasse(TRegistroCartorioController);
  RegistrarClasse(TContabilParametrosController);
  RegistrarClasse(TContabilIndiceController);
  RegistrarClasse(TContabilHistoricoController);
  RegistrarClasse(TAidfAimdfController);
  RegistrarClasse(TFapController);
  RegistrarClasse(TPlanoContaController);
  RegistrarClasse(TPlanoContaRefSpedController);
  RegistrarClasse(TContabilContaController);
  RegistrarClasse(TContabilLancamentoPadraoController);
  RegistrarClasse(TContabilLoteController);
  RegistrarClasse(TContabilLancamentoOrcadoController);
  RegistrarClasse(TContabilLancamentoCabecalhoController);
  RegistrarClasse(TContabilFechamentoController);
  RegistrarClasse(TContabilDreCabecalhoController);
  RegistrarClasse(TContabilEncerramentoExeCabController);
  RegistrarClasse(TContabilLivroController);

  //Conciliação Contábil
  Modulo := 'Conciliação Contábil';
  RegistrarClasse(TContabilLancamentoDetalheController);
  RegistrarClasse(TViewConciliaClienteController);
  RegistrarClasse(TViewConciliaFornecedorController);

  //Escrita Fiscal
  Modulo := 'Escrita Fiscal';
  RegistrarClasse(TFiscalLivroController);
  RegistrarClasse(TSimplesNacionalCabecalhoController);
  RegistrarClasse(TFiscalParametrosController);
  RegistrarClasse(TFiscalApuracaoIcmsController);

  //Sintegra
  Modulo := 'Sintegra';
  RegistrarClasse(TSintegraController);

  //Sped Contábil e Fiscal
  Modulo := 'Sped Contábil e Fiscal';
  RegistrarClasse(TSpedFiscalController);
  RegistrarClasse(TSpedContabilController);
end;

function TFServerContainer.Sessao: TListaSessaoUsuario;
begin
  Result := TListaSessaoUsuario.Instance;
end;

procedure TFServerContainer.ConectarBD;
begin
  try
    TDBExpress.Conectar('MySQL');
    // TDBExpress.Conectar('Firebird');
    GravaLog('Banco de dados conectado.');
  finally
  end;
end;

procedure TFServerContainer.DSHTTPServiceAuthenticationManagerHTTPAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean);
var
  loUsuario: TUsuarioVO;
  Login, IdSessao: string;
  I: Integer;
  loSessaoUsuario: TSessaoUsuario;
begin
  valid := False;

  // Separa Login e IdSessao do parâmetro "User"
  I := Pos('|', User);
  Login := Copy(User, 1, I - 1);
  IdSessao := Copy(User, I + 1, Length(User));

  // Verifica se já existe uma sessão para o usuário
  loSessaoUsuario := TListaSessaoUsuario.Instance.GetSessao(IdSessao);

  // Se a sessão existir
  if Assigned(loSessaoUsuario) then
  begin
    // Confere se o usuário e senha são os mesmos da sessão
    if (loSessaoUsuario.Usuario.Login = Login) and (loSessaoUsuario.Usuario.Senha = Password) then
    begin
      valid := True;
    end;
  end
  else
  begin
    // Verifica se o usuário existe
    loUsuario := GetUsuario(IdSessao, Login, Password);
    if Assigned(loUsuario) then
    begin
      valid := True;
      loUsuario.Senha := Password;
      Sessao.AdicionaSessao(IdSessao, loUsuario);
    end;
  end;
end;

function TFServerContainer.GetUsuario(pSessao, pLogin, pSenha: string): TUsuarioVO;
var
  UsuarioController: TUsuarioController;
  JSONArray: TJSONArray;
begin
  UsuarioController := TUsuarioController.Create;
  try
    JSONArray := UsuarioController.Usuario(pSessao, 'LOGIN = ' + QuotedStr(pLogin) + ' AND SENHA = ' + QuotedStr(pSenha), 0);
    try
      if JSONArray.Size = 1 then
        Result := TUsuarioVO.JSONToObject<TUsuarioVO>(JSONArray.Get(0))
      else
        Result := nil;
    finally
      JSONArray.Free;
    end;
  finally
    UsuarioController.Free;
  end;
end;

procedure TFServerContainer.GravaLog(Valor: String);
begin
  if Assigned(Log) then
    Log.Add(Valor);
end;

procedure TFServerContainer.RegistrarClasse(pClasse: TPersistentClass);
var
  DSServerClass: TServerClassPadrao;
begin
  DSServerClass := TServerClassPadrao.Create(Self);
  DSServerClass.RegisterClass := pClasse;
  DSServerClass.Server := DSServer;
  GravaLog('Classe ' + pClasse.ClassName + ' registrada. '+Modulo+'.');
end;

end.
