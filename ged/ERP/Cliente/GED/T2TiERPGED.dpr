program T2TiERPGED;

uses
  Forms,
  SysUtils,
  UBase in '..\Comum\Tela\UBase.pas' {FBase},
  UDataModule in '..\Comum\Tela\UDataModule.pas' {FDataModule: TDataModule},
  UFiltro in '..\Comum\Tela\UFiltro.pas' {FFiltro},
  ULogin in '..\Comum\Tela\ULogin.pas' {FLogin},
  ULookup in '..\Comum\Tela\ULookup.pas' {FLookup},
  UTela in '..\Comum\Tela\UTela.pas' {FTela},
  UTelaCadastro in '..\Comum\Tela\UTelaCadastro.pas' {FTelaCadastro},
  Controller in '..\Comum\Controller\Controller.pas',
  Atributos in '..\..\Comum\Atributos.pas',
  Biblioteca in '..\..\Comum\Biblioteca.pas',
  Constantes in '..\..\Comum\Constantes.pas',
  UMenu in 'Tela\UMenu.pas' {FMenu},
  SessaoUsuario in '..\Comum\SessaoUsuario.pas',
  Tipos in '..\Comum\Tipos.pas',
  JSonVO in '..\..\Comum\VO\JSonVO.pas',
  UsuarioVO in '..\..\Comum\VO\UsuarioVO.pas',
  UGedTipoDocumento in 'Tela\UGedTipoDocumento.pas' {FGedTipoDocumento},
  CAPICOM_TLB in 'Lib\CAPICOM_TLB.pas',
  NotificationService in '..\Comum\NotificationService.pas',
  Conversor in '..\Comum\Conversor.pas',
  FuncaoVO in '..\..\Comum\VO\FuncaoVO.pas',
  PapelFuncaoVO in '..\..\Comum\VO\PapelFuncaoVO.pas',
  PapelVO in '..\..\Comum\VO\PapelVO.pas',
  FuncaoController in '..\Comum\Controller\FuncaoController.pas',
  PapelController in '..\Comum\Controller\PapelController.pas',
  PapelFuncaoController in '..\Comum\Controller\PapelFuncaoController.pas',
  UsuarioController in '..\Comum\Controller\UsuarioController.pas',
  ColaboradorController in '..\Comum\Controller\ColaboradorController.pas',
  ColaboradorVO in '..\..\Comum\VO\ColaboradorVO.pas',
  ContabilContaVO in '..\..\Comum\VO\ContabilContaVO.pas',
  SindicatoVO in '..\..\Comum\VO\SindicatoVO.pas',
  PessoaVO in '..\..\Comum\VO\PessoaVO.pas',
  EnderecoVO in '..\..\Comum\VO\EnderecoVO.pas',
  ContatoVO in '..\..\Comum\VO\ContatoVO.pas',
  PessoaFisicaVO in '..\..\Comum\VO\PessoaFisicaVO.pas',
  PessoaJuridicaVO in '..\..\Comum\VO\PessoaJuridicaVO.pas',
  TipoAdmissaoVO in '..\..\Comum\VO\TipoAdmissaoVO.pas',
  SituacaoColaboradorVO in '..\..\Comum\VO\SituacaoColaboradorVO.pas',
  SituacaoForCliVO in '..\..\Comum\VO\SituacaoForCliVO.pas',
  TipoColaboradorVO in '..\..\Comum\VO\TipoColaboradorVO.pas',
  NivelFormacaoVO in '..\..\Comum\VO\NivelFormacaoVO.pas',
  CargoVO in '..\..\Comum\VO\CargoVO.pas',
  SetorVO in '..\..\Comum\VO\SetorVO.pas',
  EmpresaVO in '..\..\Comum\VO\EmpresaVO.pas',
  UfVO in '..\..\Comum\VO\UfVO.pas',
  PaisVO in '..\..\Comum\VO\PaisVO.pas',
  ContadorVO in '..\..\Comum\VO\ContadorVO.pas',
  FpasVO in '..\..\Comum\VO\FpasVO.pas',
  GedTipoDocumentoController in 'Controller\GedTipoDocumentoController.pas',
  GedTipoDocumentoVO in '..\..\Comum\VO\GedTipoDocumentoVO.pas',
  GedDocumentoController in 'Controller\GedDocumentoController.pas',
  GedDocumentoVO in '..\..\Comum\VO\GedDocumentoVO.pas',
  GedVersaoDocumentoVO in '..\..\Comum\VO\GedVersaoDocumentoVO.pas',
  EmpresaSessaoVO in '..\..\Comum\VO\EmpresaSessaoVO.pas',
  UGedDocumento in 'Tela\UGedDocumento.pas' {FDataModule: TFGedDocumento},
  ViewSessaoEmpresaVO in '..\..\Comum\VO\ViewSessaoEmpresaVO.pas',
  EmpresaController in '..\Comum\Controller\EmpresaController.pas',
  ViewSessaoEmpresaController in '..\Comum\Controller\ViewSessaoEmpresaController.pas',
  AdministrativoFormularioVO in '..\..\Comum\VO\AdministrativoFormularioVO.pas',
  PlanoContaRefSpedVO in '..\..\Comum\VO\PlanoContaRefSpedVO.pas',
  PlanoContaVO in '..\..\Comum\VO\PlanoContaVO.pas';

{$R *.res}
var
  Formulario: TForm;

begin
  Application.Initialize;

  {
    Parametros
    1 - Login
    2 - Senha
    3 - Aplicação que chamou
    4 - Nome do arquivo (Aplicacao que chamou + Tela que chamou + Identificador
  }

  //se o GED foi chamado por outra aplicação
  if ParamStr(1) <> '' then
  begin
    FLogin := TFLogin.Create(nil);
    FLogin.EditLogin.Text := Trim(ParamStr(1));
    FLogin.EditSenha.Text := Trim(ParamStr(2));
    FLogin.BotaoConfirma.Click;
    try
      if FLogin.Logado then
      begin
        Application.CreateForm(TFDataModule, FDataModule);
        Application.CreateForm(TForm, Formulario);
        (Formulario as TFGedDocumento).MREnter.EnterEnabled := True;
        (Formulario as TFGedDocumento).MREnter.FocusEnabled := True;
        (Formulario as TFGedDocumento).WindowState := wsMaximized;
        (Formulario as TFGedDocumento).Caption := 'GED - Chamado pelo aplicativo ' + Trim(ParamStr(3));
        (Formulario as TFGedDocumento).Show;

        (Formulario as TFGedDocumento).EditCriterioRapido.Text := Trim(ParamStr(4));
        (Formulario as TFGedDocumento).BotaoConsultar.Click;

        if (Formulario as TFGedDocumento).CDSGrid.IsEmpty then
          (Formulario as TFGedDocumento).BotaoInserir.Click
        else
        begin
          (Formulario as TFGedDocumento).BotaoAlterar.Click;
        end;

        (Formulario as TFGedDocumento).CheckPodeAlterar.Enabled := False;
        (Formulario as TFGedDocumento).CheckPodeExcluir.Enabled := False;
        (Formulario as TFGedDocumento).EditNome.ReadOnly := True;
        (Formulario as TFGedDocumento).EditNome.Text := ParamStr(4);
      end;
    finally
      FLogin.Free;
    end;

  end
  else
  begin
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TFMenu, FMenu);
    Application.CreateForm(TFDataModule, FDataModule);
   end;

  Application.Run;
end.
