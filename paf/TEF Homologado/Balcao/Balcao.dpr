program Balcao;

uses
  Forms,
  UDataModule in 'UDataModule.pas' {FDataModule: TDataModule},
  ULogin in 'ULogin.pas' {FLogin},
  UMenu in 'UMenu.pas' {FMenu},
  UDAV in 'UDAV.pas' {FDAV},
  UImportaProduto in 'UImportaProduto.pas' {FImportaProduto},
  Biblioteca in '..\Biblioteca.pas',
  DAVController in 'DAVController.pas',
  DAVDetalheVO in '..\VO\DAVDetalheVO.pas',
  DAVVO in '..\VO\DAVVO.pas',
  UNF2 in 'UNF2.pas' {FNF2},
  PreVendaController in 'PreVendaController.pas',
  UPreVenda in 'UPreVenda.pas' {FPreVenda},
  PreVendaVO in '..\VO\PreVendaVO.pas',
  PreVendaDetalheVO in '..\VO\PreVendaDetalheVO.pas',
  ProdutoVO in '..\VO\ProdutoVO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TFDataModule, FDataModule);
  Application.CreateForm(TFLogin, FLogin);
  FMenu.Show;
  FLogin.ShowModal;
  Application.Run;
end.
