program T2TiSped;

uses
  Forms,
  Windows,
  Dialogs,
  Tipos in '..\Comum\Tipos.pas',
  Conversor in '..\Comum\Conversor.pas',
  NotificationService in '..\Comum\NotificationService.pas',
  SessaoUsuario in '..\Comum\SessaoUsuario.pas',
  UsuarioController in '..\Comum\Controller\UsuarioController.pas',
  Controller in '..\Comum\Controller\Controller.pas',
  FuncaoController in '..\Comum\Controller\FuncaoController.pas',
  PapelController in '..\Comum\Controller\PapelController.pas',
  PapelFuncaoController in '..\Comum\Controller\PapelFuncaoController.pas',
  UTelaCadastro in '..\Comum\Tela\UTelaCadastro.pas' {FTelaCadastro},
  UTela in '..\Comum\Tela\UTela.pas' {FTela},
  ULookup in '..\Comum\Tela\ULookup.pas' {FLookup},
  UBase in '..\Comum\Tela\UBase.pas' {FBase},
  UDataModule in '..\Comum\Tela\UDataModule.pas' {FDataModule: TDataModule},
  UFiltro in '..\Comum\Tela\UFiltro.pas' {FFiltro},
  ULogin in '..\Comum\Tela\ULogin.pas' {FLogin},
  UMenu in 'Tela\UMenu.pas' {FMenu},
  Atributos in '..\..\Comum\Atributos.pas',
  Biblioteca in '..\..\Comum\Biblioteca.pas',
  Constantes in '..\..\Comum\Constantes.pas',
  FuncaoVO in '..\..\Comum\VO\FuncaoVO.pas',
  JSonVO in '..\..\Comum\VO\JSonVO.pas',
  UsuarioVO in '..\..\Comum\VO\UsuarioVO.pas',
  PapelVO in '..\..\Comum\VO\PapelVO.pas',
  PapelFuncaoVO in '..\..\Comum\VO\PapelFuncaoVO.pas',
  PessoaVO in '..\..\Comum\VO\PessoaVO.pas',
  EnderecoVO in '..\..\Comum\VO\EnderecoVO.pas',
  ContatoVO in '..\..\Comum\VO\ContatoVO.pas',
  PessoaFisicaVO in '..\..\Comum\VO\PessoaFisicaVO.pas',
  PessoaJuridicaVO in '..\..\Comum\VO\PessoaJuridicaVO.pas',
  ColaboradorVO in '..\..\Comum\VO\ColaboradorVO.pas',
  SetorVO in '..\..\Comum\VO\SetorVO.pas',
  CargoVO in '..\..\Comum\VO\CargoVO.pas',
  EmpresaVO in '..\..\Comum\VO\EmpresaVO.pas',
  UfVO in '..\..\Comum\VO\UfVO.pas',
  PaisVO in '..\..\Comum\VO\PaisVO.pas',
  ContadorVO in '..\..\Comum\VO\ContadorVO.pas',
  FpasVO in '..\..\Comum\VO\FpasVO.pas',
  SindicatoVO in '..\..\Comum\VO\SindicatoVO.pas',
  NivelFormacaoVO in '..\..\Comum\VO\NivelFormacaoVO.pas',
  TipoColaboradorVO in '..\..\Comum\VO\TipoColaboradorVO.pas',
  ContabilContaVO in '..\..\Comum\VO\ContabilContaVO.pas',
  SituacaoColaboradorVO in '..\..\Comum\VO\SituacaoColaboradorVO.pas',
  TipoAdmissaoVO in '..\..\Comum\VO\TipoAdmissaoVO.pas',
  USpedFiscal in 'Tela\USpedFiscal.pas' {FSpedFiscal},
  SpedFiscalController in 'Controller\SpedFiscalController.pas',
  UPreview in 'Tela\UPreview.pas' {FPreview},
  USpedContabil in 'Tela\USpedContabil.pas' {FSpedContabil},
  SpedContabilController in 'Controller\SpedContabilController.pas',
  EmpresaController in '..\Comum\Controller\EmpresaController.pas',
  ViewSessaoEmpresaController in '..\Comum\Controller\ViewSessaoEmpresaController.pas',
  ViewSessaoEmpresaVO in '..\..\Comum\VO\ViewSessaoEmpresaVO.pas',
  AdministrativoFormularioVO in '..\..\Comum\VO\AdministrativoFormularioVO.pas',
  EmpresaSessaoVO in '..\..\Comum\VO\EmpresaSessaoVO.pas',
  ViewPessoaContadorController in 'Controller\ViewPessoaContadorController.pas',
  ViewPessoaContadorVO in '..\..\Comum\VO\ViewPessoaContadorVO.pas',
  PlanoContaVO in '..\..\Comum\VO\PlanoContaVO.pas',
  PlanoContaRefSpedVO in '..\..\Comum\VO\PlanoContaRefSpedVO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TFDataModule, FDataModule);
  Application.Run;
end.
