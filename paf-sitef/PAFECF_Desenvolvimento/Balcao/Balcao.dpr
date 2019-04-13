program Balcao;

uses
  Forms,
  UDataModule in 'UDataModule.pas' {FDataModule: TDataModule},
  ULogin in 'ULogin.pas' {FLogin},
  UMenu in 'UMenu.pas' {FMenu},
  UDAV in 'UDAV.pas' {FDAV},
  UImportaProduto in 'UImportaProduto.pas' {FImportaProduto},
  UPreVenda in 'UPreVenda.pas' {FPreVenda},
  PreVendaController in 'Controller\PreVendaController.pas',
  ProdutoController in 'Controller\ProdutoController.pas',
  ClienteController in 'Controller\ClienteController.pas',
  DAVController in 'Controller\DAVController.pas',
  OperadorController in 'Controller\OperadorController.pas',
  UDescontoAcrescimo in 'UDescontoAcrescimo.pas' {FDescontoAcrescimo},
  ULoginGerenteSupervisor in 'ULoginGerenteSupervisor.pas' {FLoginGerenteSupervisor},
  UProcuraCliente in 'UProcuraCliente.pas' {FProcuraCliente},
  UConfigConexao in 'UConfigConexao.pas' {FConfigConexao},
  Constantes in 'Constantes.pas',
  Biblioteca in 'Biblioteca.pas',
  UNFe in 'UNFe.pas' {FNFe},
  NFeController in 'Controller\NFeController.pas',
  EmpresaController in 'Controller\EmpresaController.pas',
  UProduto in 'UProduto.pas' {FProduto},
  DavCabecalhoVO in 'VO\DavCabecalhoVO.pas',
  DavDetalheVO in 'VO\DavDetalheVO.pas',
  EmpresaVO in 'VO\EmpresaVO.pas',
  NfeCabecalhoVO in 'VO\NfeCabecalhoVO.pas',
  NfeCupomFiscalVO in 'VO\NfeCupomFiscalVO.pas',
  NfeDetalheVO in 'VO\NfeDetalheVO.pas',
  PessoaVO in 'VO\PessoaVO.pas',
  PreVendaCabecalhoVO in 'VO\PreVendaCabecalhoVO.pas',
  PreVendaDetalheVO in 'VO\PreVendaDetalheVO.pas',
  ProdutoVO in 'VO\ProdutoVO.pas',
  UsuarioVO in 'VO\UsuarioVO.pas',
  PessoaEnderecoVO in 'VO\PessoaEnderecoVO.pas',
  UnidadeProdutoVO in 'VO\UnidadeProdutoVO.pas',
  NfeConfiguracaoVO in 'VO\NfeConfiguracaoVO.pas',
  NfeConfiguracaoController in 'Controller\NfeConfiguracaoController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFDataModule, FDataModule);
  end.
