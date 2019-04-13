program Integracao;

uses
  Forms,Windows,
  UIntegracaoPDV in 'UIntegracaoPDV.pas' {FIntegracaoPDV},
  UDataModule in 'UDataModule.pas' {FDataModule: TDataModule},
  ImportaController in 'Controller\ImportaController.pas',
  LogImportacaoController in 'Controller\LogImportacaoController.pas',
  LogImportacaoVO in 'VO\LogImportacaoVO.pas',
  Constantes in 'Constantes.pas',
  Biblioteca in 'Biblioteca.pas',
  Atributos in 'Atributos.pas';

{$R *.res}
 var
  Instancia: THandle;
begin
  // ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Instancia:= CreateMutex(nil, false, 'IntegracaoPDV');
  if not (WaitForSingleObject(Instancia, 0) = wait_Timeout) then
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TFIntegracaoPDV, FIntegracaoPDV);
    Application.CreateForm(TFDataModule, FDataModule);
    Application.Run;
  end;

end.
