program ConfiguraPAFECF;

uses
  Forms,
  UConfiguracao in 'UConfiguracao.pas' {FConfiguracao},
  UDataModule in 'UDataModule.pas' {FDataModule: TDataModule},
  UConfigConexao in 'UConfigConexao.pas' {FConfigConexao},
  Biblioteca in 'Biblioteca.pas',
  Constantes in 'Constantes.pas',
  UTurno in 'UTurno.pas' {FTurno},
  TotalTipoPagamentoController in 'Controller\TotalTipoPagamentoController.pas',
  MeiosPagamentoVO in 'VO\MeiosPagamentoVO.pas',
  TipoPagamentoVO in 'VO\TipoPagamentoVO.pas',
  TotalTipoPagamentoVO in 'VO\TotalTipoPagamentoVO.pas',
  TurnoVO in 'VO\TurnoVO.pas',
  TurnoController in 'Controller\TurnoController.pas',
  ConfiguracaoController in 'Controller\ConfiguracaoController.pas',
  ConfiguracaoVO in 'VO\ConfiguracaoVO.pas',
  ResolucaoVO in 'VO\ResolucaoVO.pas',
  PosicaoComponentesVO in 'VO\PosicaoComponentesVO.pas',
  USplash in 'USplash.pas' {FSplash},
  UUsuario in 'UUsuario.pas' {FUsuario},
  OperadorVO in 'VO\OperadorVO.pas',
  FuncionarioVO in 'VO\FuncionarioVO.pas',
  OperadorFuncionarioController in 'Controller\OperadorFuncionarioController.pas',
  ULogin in 'ULogin.pas' {FLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFConfiguracao, FConfiguracao);
  Application.Run;
end.
