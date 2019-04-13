{*******************************************************************************
Title: T2Ti ERP
Description: Unit vinculada à tela Menu da aplicação

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

@author Albert Eije (T2Ti.COM)
@version 1.1
*******************************************************************************}
unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, ExtCtrls, ImgList, JvExControls, JvComponent,
  JvPageList, JvTabBar, RibbonLunaStyleActnCtrls, Ribbon, ToolWin, ActnMan,
  ActnCtrls, ActnList, RibbonSilverStyleActnCtrls, JvExComCtrls, JvStatusBar,
  ActnMenus, RibbonActnMenus, JvOutlookBar, JvLookOut,  ScreenTips, WideStrings,
  DB, JvComponentBase, Atributos, Enter, XPMan, ShellApi,
  //
  UPais, UUnidadeProduto, UBase, UBanco, ULogin, UEstadoCivil,
  UPessoa, UMarcaProduto, USetor, UAgenciaBanco, UGrupoProduto, USubGrupoProduto,
  UAlmoxarifado, UNcm, UUf, UMunicipio, UTipoRelacionamento, UTipoAdmissao,
  UNivelFormacao, UCfop, UCbo, UCargo, UAtividadeForCli, USituacaoForCli, Uproduto,
  UBaseCreditoPis, UCep, UCheque, UTalonarioCheque, UContaCaixa, UConvenio,
  UOperadoraCartao, UOperadoraPlanoSaude, USindicato, USituacaoColaborador,
  UTipoColaborador, USalarioMinimo, UCodigoGps, UTipoDesligamento, USefipCodigoMovimentacao,
  USefipCodigoRecolhimento, USefipCategoriaTrabalho, UTipoItemSped, USpedPis4310,
  USpedPis4313, USpedPis4314, USpedPis4315, USpedPis4316, USpedPis439, UTipoCreditoPis,
  USituacaoDocumento, UCsosnA, UCsosnB, UCstIcmsA, UCstIcmsB, UCstPis, UCstCofins,UCstIpi,
  UFeriados, UContador, UEmpresa;

type
  [TFormDescription('Menu','Menu')]
  TFMenu = class(TFBase)
    //actions
    [TComponentDescription('Habilita Formulário',TFUnidadeProduto)]
    ActionUnidade: TAction;
    [TComponentDescription('Habilita Formulário',TFBanco)]
    ActionBanco: TAction;
    [TComponentDescription('Habilita Formulário',TFEstadoCivil)]
    ActionEstadoCivil: TAction;
    [TComponentDescription('Habilita Formulário',TFPais)]
    ActionPais: TAction;
    [TComponentDescription('Habilita Formulário',TFMarcaProduto)]
    ActionMarca: TAction;
    [TComponentDescription('Habilita Formulário',TFPessoa)]
    ActionPessoa: TAction;
    [TComponentDescription('Habilita Formulário',TFSetor)]
    ActionSetor: TAction;
    [TComponentDescription('Habilita Formulário',TFAgenciaBanco)]
    ActionAgencia: TAction;
    [TComponentDescription('Habilita Formulário',TFGrupoProduto)]
    ActionGrupoProduto: TAction;
    [TComponentDescription('Habilita Formulário',TFSubGrupoProduto)]
    ActionSubGrupoProduto: TAction;
    [TComponentDescription('Habilita Formulário',TFAlmoxarifado)]
    ActionAlmoxarifado: TAction;
    [TComponentDescription('Habilita Formulário',TFNcm)]
    ActionNCM: TAction;
    [TComponentDescription('Habilita Formulário',TFUf)]
    ActionUf: TAction;
    [TComponentDescription('Habilita Formulário',TFMunicipio)]
    ActionMunicipio: TAction;
    [TComponentDescription('Habilita Formulário',TFTipoRelacionamento)]
    ActionTipoRelacionamento: TAction;
    [TComponentDescription('Habilita Formulário',TFTipoAdmissao)]
    ActionTipoAdmissao: TAction;
    [TComponentDescription('Habilita Formulário',TFNivelFormacao)]
    ActionNivelFormacao: TAction;
    [TComponentDescription('Habilita Formulário',TFCfop)]
    ActionCfop: TAction;
    [TComponentDescription('Habilita Formulário',TFCbo)]
    ActionCbo: TAction;
    [TComponentDescription('Habilita Formulário',TFCargo)]
    ActionCargo: TAction;
    [TComponentDescription('Habilita Formulário',TFAtividadeForCli)]
    ActionAtividade: TAction;
    [TComponentDescription('Habilita Formulário',TFSituacaoForCli)]
    ActionSituacao: TAction;
    [TComponentDescription('Habilita Formulário',TFProduto)]
    ActionProduto: TAction;
    [TComponentDescription('Habilita Formulário',TFBaseCreditoPis)]
    ActionBaseCreditoPis: TAction;
    [TComponentDescription('Habilita Formulário',TFCep)]
    ActionCep: TAction;
    [TComponentDescription('Habilita Formulário',TFCheque)]
    ActionCheque: TAction;
    [TComponentDescription('Habilita Formulário',TFTalonarioCheque)]
    ActionTalonarioCheque: TAction;
    [TComponentDescription('Habilita Formulário',TFContaCaixa)]
    ActionContaCaixa: TAction;
    [TComponentDescription('Habilita Formulário',TFConvenio)]
    ActionConvenio: TAction;
    [TComponentDescription('Habilita Formulário',TFOperadoraCartao)]
    ActionOperadoraCartao: TAction;
    [TComponentDescription('Habilita Formulário',TFOperadoraPlanoSaude)]
    ActionOperadoraPlanoSaude: TAction;
    [TComponentDescription('Habilita Formulário',TFSindicato)]
    ActionSindicato: TAction;
    [TComponentDescription('Habilita Formulário',TFSituacaoColaborador)]
    ActionSituacaoColaborador: TAction;
    [TComponentDescription('Habilita Formulário',TFTipoColaborador)]
    ActionTipoColaborador: TAction;
    [TComponentDescription('Habilita Formulário',TFSalarioMinimo)]
    ActionSalarioMinimo: TAction;
    [TComponentDescription('Habilita Formulário',TFCodigoGps)]
    ActionCodigoGps: TAction;
    [TComponentDescription('Habilita Formulário',TFTipoDesligamento)]
    ActionTipoDesligamento: TAction;
    [TComponentDescription('Habilita Formulário',TFSefipCodigoMovimentacao)]
    ActionSefipCodigoMovimentacao: TAction;
    [TComponentDescription('Habilita Formulário',TFSefipCodigoRecolhimento)]
    ActionSefipCodigoRecolhimento: TAction;
    [TComponentDescription('Habilita Formulário',TFSefipCategoriaTrabalho)]
    ActionSefipCategoriaTrabalho: TAction;
    [TComponentDescription('Habilita Formulário',TFTipoItemSped)]
    ActionTipoItemSped: TAction;
    [TComponentDescription('Habilita Formulário',TFSpedPis4310)]
    ActionSpedPis4310: TAction;
    [TComponentDescription('Habilita Formulário',TFSpedPis4313)]
    ActionSpedPis4313: TAction;
    [TComponentDescription('Habilita Formulário',TFSpedPis4314)]
    ActionSpedPis4314: TAction;
    [TComponentDescription('Habilita Formulário',TFSpedPis4315)]
    ActionSpedPis4315: TAction;
    [TComponentDescription('Habilita Formulário',TFSpedPis4316)]
    ActionSpedPis4316: TAction;
    [TComponentDescription('Habilita Formulário',TFSpedPis439)]
    ActionSpedPis439: TAction;
    [TComponentDescription('Habilita Formulário',TFTipoCreditoPis)]
    ActionTipoCreditoPis: TAction;
    [TComponentDescription('Habilita Formulário',TFSituacaoDocumento)]
    ActionSituacaoDocumento: TAction;
    [TComponentDescription('Habilita Formulário',TFCsosnA)]
    ActionCsosnA: TAction;
    [TComponentDescription('Habilita Formulário',TFCsosnB)]
    ActionCsosnB: TAction;
    [TComponentDescription('Habilita Formulário',TFCstIcmsA)]
    ActionCstIcmsA: TAction;
    [TComponentDescription('Habilita Formulário',TFCstIcmsB)]
    ActionCstIcmsB: TAction;
    [TComponentDescription('Habilita Formulário',TFCstPis)]
    ActionCstPis: TAction;
    [TComponentDescription('Habilita Formulário',TFCstCofins)]
    ActionCstCofins: TAction;
    [TComponentDescription('Habilita Formulário',TFCstIpi)]
    ActionCstIpi: TAction;
    [TComponentDescription('Habilita Formulário',TFFeriados)]
    ActionFeriados: TAction;
    //
    [TComponentDescription('Acesso ao Módulo Vendas')]
    ActionVendas: TAction;
    //
    Image16: TImageList;
    PopupMenu: TPopupMenu;
    menuFechar: TMenuItem;
    menuFecharTodasExcetoEssa: TMenuItem;
    menuSepararAba: TMenuItem;
    N2: TMenuItem;
    JvTabBar: TJvTabBar;
    JvModernTabBarPainter: TJvModernTabBarPainter;
    JvPageList: TJvPageList;
    Ribbon: TRibbon;
    RibbonPageCadastros: TRibbonPage;
    RibbonGroupGeral: TRibbonGroup;
    ActionManager: TActionManager;
    JvStatusBar1: TJvStatusBar;
    RibbonGroupDiversos: TRibbonGroup;
    Image48: TImageList;
    ActionCliente: TAction;
    ActionFornecedor: TAction;
    ActionTransportadora: TAction;
    ActionColaborador: TAction;
    Image32: TImageList;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    ActionContador: TAction;
    ActionIndiceEconomico: TAction;
    ScreenTipsManager1: TScreenTipsManager;
    ActionEndereco: TAction;
    ActionSair: TAction;
    MREnter: TMREnter;
    RibbonPage1: TRibbonPage;
    RibbonGroup1: TRibbonGroup;
    RibbonGroup: TRibbonGroup;
    RibbonGroupSair: TRibbonGroup;
    ActionSped: TAction;
    ActionSefip: TAction;
    ActionPis: TAction;
    ActionCst: TAction;
    ActionEmpresa: TAction;

    procedure PageControlDrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure PageControlChange(Sender: TObject);
    procedure menuFecharClick(Sender: TObject);
    procedure menuFecharTodasExcetoEssaClick(Sender: TObject);
    procedure menuSepararAbaClick(Sender: TObject);
    procedure JvPageListChange(Sender: TObject);
    procedure JvTabBarTabClosing(Sender: TObject; Item: TJvTabBarItem; var AllowClose: Boolean);
    procedure ActionClienteExecute(Sender: TObject);
    procedure ActionFornecedorExecute(Sender: TObject);
    procedure ActionTransportadoraExecute(Sender: TObject);
    procedure ActionColaboradorExecute(Sender: TObject);
    procedure ActionAtividadeExecute(Sender: TObject);
    procedure ActionSituacaoExecute(Sender: TObject);
    procedure ActionCargoExecute(Sender: TObject);
    procedure ActionTipoColaboradorExecute(Sender: TObject);
    procedure ActionNivelFormacaoExecute(Sender: TObject);
    procedure ActionProdutoExecute(Sender: TObject);
    procedure ActionMarcaExecute(Sender: TObject);
    procedure ActionNCMExecute(Sender: TObject);
    procedure ActionUnidadeExecute(Sender: TObject);
    procedure ActionPaisExecute(Sender: TObject);
    procedure ActionUfExecute(Sender: TObject);
    procedure ActionMunicipioExecute(Sender: TObject);
    procedure ActionCepExecute(Sender: TObject);
    procedure ActionBancoExecute(Sender: TObject);
    procedure ActionAgenciaExecute(Sender: TObject);
    procedure ActionContaCaixaExecute(Sender: TObject);
    procedure ActionTalonarioChequeExecute(Sender: TObject);
    procedure ActionChequeExecute(Sender: TObject);
    procedure ActionConvenioExecute(Sender: TObject);
    procedure ActionContadorExecute(Sender: TObject);
    procedure ActionAlmoxarifadoExecute(Sender: TObject);
    procedure ActionSetorExecute(Sender: TObject);
    procedure ActionOperadoraCartaoExecute(Sender: TObject);
    procedure ActionCfopExecute(Sender: TObject);
    procedure ActionIndiceEconomicoExecute(Sender: TObject);
    procedure ActionEstadoCivilExecute(Sender: TObject);
    procedure ActionEnderecoExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure JvTabBarTabMoved(Sender: TObject; Item: TJvTabBarItem);
    procedure JvTabBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionPessoaExecute(Sender: TObject);
    procedure ActionGrupoProdutoExecute(Sender: TObject);
    procedure ActionSubGrupoProdutoExecute(Sender: TObject);
    procedure ActionVendasExecute(Sender: TObject);
    procedure ActionTipoRelacionamentoExecute(Sender: TObject);
    procedure ActionTipoAdmissaoExecute(Sender: TObject);
    procedure ActionCboExecute(Sender: TObject);
    procedure ActionBaseCreditoPisExecute(Sender: TObject);
    procedure ActionOperadoraPlanoSaudeExecute(Sender: TObject);
    procedure ActionSindicatoExecute(Sender: TObject);
    procedure ActionSituacaoColaboradorExecute(Sender: TObject);
    procedure ActionSalarioMinimoExecute(Sender: TObject);
    procedure ActionCodigoGpsExecute(Sender: TObject);
    procedure ActionTipoDesligamentoExecute(Sender: TObject);
    procedure ActionSefipCodigoMovimentacaoExecute(Sender: TObject);
    procedure ActionSefipCodigoRecolhimentoExecute(Sender: TObject);
    procedure ActionSefipCategoriaTrabalhoExecute(Sender: TObject);
    procedure ActionTipoItemSpedExecute(Sender: TObject);
    procedure ActionSpedPis4310Execute(Sender: TObject);
    procedure ActionSpedPis4313Execute(Sender: TObject);
    procedure ActionSpedPis4314Execute(Sender: TObject);
    procedure ActionSpedPis4315Execute(Sender: TObject);
    procedure ActionSpedPis4316Execute(Sender: TObject);
    procedure ActionSpedPis439Execute(Sender: TObject);
    procedure ActionTipoCreditoPisExecute(Sender: TObject);
    procedure ActionSpedExecute(Sender: TObject);
    procedure ActionSefipExecute(Sender: TObject);
    procedure ActionPisExecute(Sender: TObject);
    procedure ActionSituacaoDocumentoExecute(Sender: TObject);
    procedure ActionCsosnAExecute(Sender: TObject);
    procedure ActionCsosnBExecute(Sender: TObject);
    procedure ActionCstIcmsAExecute(Sender: TObject);
    procedure ActionCstIcmsBExecute(Sender: TObject);
    procedure ActionCstPisExecute(Sender: TObject);
    procedure ActionCstCofinsExecute(Sender: TObject);
    procedure ActionCstIpiExecute(Sender: TObject);
    procedure ActionFeriadosExecute(Sender: TObject);
    procedure ActionCstExecute(Sender: TObject);
    procedure ActionEmpresaExecute(Sender: TObject);
    procedure RibbonHelpButtonClick(Sender: TObject);
  private
    function doLogin: Boolean;

    function PodeAbrirFormulario(ClasseForm: TFormClass; var Pagina: TJvCustomPage): Boolean;
    function TotalFormsAbertos(ClasseForm: TFormClass): Integer;
    procedure AjustarCaptionAbas(ClasseForm: TFormClass);
    function ObterAba(Pagina: TJvCustomPage): TJvTabBarItem;
    function ObterPagina(Aba: TJvTabBarItem): TJvCustomPage;
  public
    procedure NovaPagina(ClasseForm: TFormClass; IndiceImagem: Integer);
    function FecharPagina(Pagina: TJvCustomPage): Boolean; overload;
    function FecharPagina(Pagina: TJvCustomPage; TodasExcetoEssa: Boolean): Boolean; overload;
    function FecharPaginas: Boolean;
    procedure SepararAba(Pagina: TJvCustomPage);

  end;

var
  FMenu: TFMenu;
  FormAtivo: String;

implementation

uses SessaoUsuario;

{$R *.dfm}

var
  IdxTabSelected: Integer = -1;

{$Region 'Infra'}
procedure TFMenu.NovaPagina(ClasseForm: TFormClass;  IndiceImagem: Integer);
var
  Aba    : TJvTabBarItem;
  Pagina : TJvCustomPage;
  Form   : TForm;
begin

  //verifica se pode abrir o form
  if not PodeAbrirFormulario(ClasseForm, Pagina) then
  begin
    JvPageList.ActivePage := Pagina;
    Exit;
  end;

  //cria uma nova aba
  Aba := JvTabBar.AddTab('');

  //instancia uma página padrão
  Pagina := TJvStandardPage.Create(Self);

  //seta a PageList da nova página para aquela que já está no form principal
  Pagina.PageList := JvPageList;

  //cria um form passando a página para o seu construtor, que recebe um TComponent
  Form := ClasseForm.Create(Pagina);

  //Propriedades do Form
  with Form do
  begin
    Align       := alClient;
    BorderStyle := bsNone;
    Parent      := Pagina;
  end;

  //Propriedades da Aba
  with Aba do
  begin
    Caption := Form.Caption;
    ImageIndex := IndiceImagem;
    PopupMenu := Self.PopupMenu;
  end;

  //ajusta o título (caption) das abas
  AjustarCaptionAbas(ClasseForm);

  //ativa a página
  JvPageList.ActivePage := Pagina;

  FormAtivo := Form.Name;

  //exibe o formulário
  Form.Show;
end;

function TFMenu.PodeAbrirFormulario(ClasseForm: TFormClass; var Pagina: TJvCustomPage): Boolean;
var
  I: Integer;
begin
  Result := True;
  //varre a JvPageList para saber se já existe um Form aberto
  for I := 0 to JvPageList.PageCount - 1 do
    //se achou um form
    if JvPageList.Pages[I].Components[0].ClassType = ClasseForm then
    begin
      Pagina := JvPageList.Pages[I];
      //permite abrir o form novamente caso a Tag tenha o valor zero
      Result := (Pagina.Components[0] as TForm).Tag = 0;
      Break;
    end;
end;

//verifica o total de formulários abertos
function TFMenu.TotalFormsAbertos(ClasseForm: TFormClass): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to JvPageList.PageCount - 1 do
  begin
    if JvPageList.Pages[I].Components[0].ClassType = ClasseForm then
      Inc(Result);
  end;
end;

//ajusta o título (caption) das abas
procedure TFMenu.AjustarCaptionAbas(ClasseForm: TFormClass);
var
  I, Indice, TotalForms: Integer;
  NovoCaption: string;
begin
  TotalForms := TotalFormsAbertos(ClasseForm);

  if TotalForms > 1 then
  begin
    Indice := 1;
    for I := 0 to JvPageList.PageCount - 1 do
    begin
      with JvPageList do
      begin
        if Pages[I].Components[0].ClassType = ClasseForm then
        begin
          NovoCaption := (Pages[I].Components[0] as TForm).Caption + ' (' + IntToStr(Indice) + ')';
          (Pages[I] as TJvStandardPage).Caption := NovoCaption;
          ObterAba(Pages[I]).Caption := NovoCaption;
          Inc(Indice);
        end;
      end;
    end;
  end;
end;

function TFMenu.doLogin: Boolean;
var
  FormLogin: TFLogin;
begin
  FormLogin := TFLogin.Create(Self);
  try
    FormLogin.ShowModal;
    Result := FormLogin.Logado;
  finally
    FormLogin.Free;
  end;
end;

//desenha a aba
procedure TFMenu.PageControlDrawTab(Control: TCustomTabControl;  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  CaptionAba, CaptionForm, CaptionContador: string;
  I: Integer;
begin
  with JvPageList do
  begin
    // Separa o caption da aba e o contador de forms
    CaptionAba := (Pages[TabIndex] as TJvStandardPage).Caption;

    CaptionForm := Trim(Copy(CaptionAba, 1, Pos('(', CaptionAba))) + ' ';

    CaptionContador := Copy(CaptionAba, Pos('(', CaptionAba), Length(CaptionAba));
    CaptionContador := Copy(CaptionContador, 1, Pos(')', CaptionContador));

    Canvas.FillRect(Rect);

    Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, CaptionForm);
    I := Canvas.TextWidth(CaptionForm);

    Canvas.Font.Style := [fsBold];
    Canvas.TextOut(Rect.Left + 3 + I, Rect.Top + 3, CaptionContador);
  end;
end;

procedure TFMenu.PageControlChange(Sender: TObject);
begin
  Caption := JvTabBar.SelectedTab.Caption;
  Application.Title := Caption;

  with (JvPageList.ActivePage.Components[0] as TForm) do
  begin
    if not Assigned(Parent) then
      Show;
  end;
end;

//controla o fechamento da página
function TFMenu.FecharPagina(Pagina: TJvCustomPage): Boolean;
var
  Form: TForm;
  PaginaEsquerda: TJvCustomPage;
begin
  PaginaEsquerda := nil;
  Form := Pagina.Components[0] as TForm;

  Result := Form.CloseQuery;

  if Result then
  begin
    if Pagina.PageIndex > 0 then
    begin
      PaginaEsquerda := JvPageList.Pages[Pagina.PageIndex - 1];
    end;

    Form.Close;
    ObterAba(Pagina).Free;
    Pagina.Free;

    JvPageList.ActivePage := PaginaEsquerda;
  end;
end;

//controla o fechamento da página - todas exceto a selecionada
function TFMenu.FecharPagina(Pagina: TJvCustomPage; TodasExcetoEssa: Boolean): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := JvPageList.PageCount - 1 downto 0 do
    if JvPageList.Pages[I] <> Pagina then
    begin
      Result := FecharPagina(JvPageList.Pages[I]);
      if not Result then
        Exit;
    end;
end;

function TFMenu.FecharPaginas: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := JvPageList.PageCount - 1 downto 0 do
  begin
    Result := FecharPagina(JvPageList.Pages[I]);
    if not Result then
      Exit;
  end;
end;

procedure TFMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja Realmente Sair?', 'Sair do Sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
    Application.Run;

  Sessao.Free;

  FecharPaginas;
end;

procedure TFMenu.FormCreate(Sender: TObject);
begin
  if not doLogin then
    Application.Terminate
  else
    inherited;
end;

procedure TFMenu.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (shift=[ssCtrl]) and (key=VK_TAB) then
  begin
    JvPageList.NextPage;
  end;

  if (shift=[ssShift]) and (key=VK_TAB) then
  begin
    JvPageList.PrevPage;
  end;
end;

//separa a aba (formulário)
procedure TFMenu.SepararAba(Pagina: TJvCustomPage);
begin
  with Pagina.Components[0] as TForm do
  begin
    Align       := alNone;
    BorderStyle := bsSizeable;
    Left := (((JvPageList.Width )- Width) div 2)+JvPageList.Left;
    Top := (((JvPageList.ClientHeight)-Height) div 2 )+(JvPageList.Top)-18;
    Parent      := nil;
  end;
  ObterAba(Pagina).Visible := False;
end;

function TFMenu.ObterAba(Pagina: TJvCustomPage): TJvTabBarItem;
var
  Form: TForm;
begin
  Result := nil;

  Form := Pagina.Components[0] as TForm;

  FormAtivo := Form.Name;

  if Assigned(Pagina) then
    Result := JvTabBar.Tabs[Pagina.PageIndex];

  //força o foco no form
  Form.Hide;
  Form.Show;
end;

procedure TFMenu.JvPageListChange(Sender: TObject);
begin
  ObterAba(JvPageList.ActivePage).Selected := True;
end;

procedure TFMenu.JvTabBarTabClosing(Sender: TObject; Item: TJvTabBarItem;
  var AllowClose: Boolean);
begin
  AllowClose := FecharPagina(ObterPagina(Item));
end;

procedure TFMenu.JvTabBarTabMoved(Sender: TObject; Item: TJvTabBarItem);
begin
  if IdxTabSelected >= 0 then
  begin
    JvPageList.Pages[IdxTabSelected].PageIndex := Item.Index;
  end;
end;

procedure TFMenu.JvTabBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
begin
  if Assigned(Item) then
    IdxTabSelected := Item.Index
  else
    IdxTabSelected := -1;
end;

function TFMenu.ObterPagina(Aba: TJvTabBarItem): TJvCustomPage;
begin
  Result := JvPageList.Pages[Aba.Index];
end;
{$ENDREGION}

{$Region 'Actions'}
procedure TFMenu.ActionClienteExecute(Sender: TObject);
begin
  //NovaPagina(TFCliente, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionFeriadosExecute(Sender: TObject);
begin
  NovaPagina(TFFeriados,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionFornecedorExecute(Sender: TObject);
begin
  //NovaPagina(TFFornecedor, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionGrupoProdutoExecute(Sender: TObject);
begin
  NovaPagina(TFGrupoProduto,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionProdutoExecute(Sender: TObject);
begin
  NovaPagina(TFProduto, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionAgenciaExecute(Sender: TObject);
begin
  NovaPagina(TFAgenciaBanco,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionAlmoxarifadoExecute(Sender: TObject);
begin
  NovaPagina(TFAlmoxarifado, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionAtividadeExecute(Sender: TObject);
begin
  NovaPagina(TFAtividadeForCli, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionBancoExecute(Sender: TObject);
begin
  NovaPagina(TFBanco, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionBaseCreditoPisExecute(Sender: TObject);
begin
  NovaPagina(TFBaseCreditoPis, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCargoExecute(Sender: TObject);
begin
  NovaPagina(TFCargo, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCboExecute(Sender: TObject);
begin
  NovaPagina(TFCbo, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCepExecute(Sender: TObject);
begin
  NovaPagina(TFCep, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCfopExecute(Sender: TObject);
begin
  NovaPagina(TFCfop, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionChequeExecute(Sender: TObject);
begin
  NovaPagina(TFCheque, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCodigoGpsExecute(Sender: TObject);
begin
  NovaPagina(TFCodigoGps,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionColaboradorExecute(Sender: TObject);
begin
  ShowMessage('Colaborador');
end;

procedure TFMenu.ActionContadorExecute(Sender: TObject);
begin
  NovaPagina(TFContador,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionContaCaixaExecute(Sender: TObject);
begin
  NovaPagina(TFContaCaixa,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionConvenioExecute(Sender: TObject);
begin
  NovaPagina(TFConvenio,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCsosnAExecute(Sender: TObject);
begin
  NovaPagina(TFCsosnA,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCsosnBExecute(Sender: TObject);
begin
  NovaPagina(TFCsosnB,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCstCofinsExecute(Sender: TObject);
begin
  NovaPagina(TFCstCofins,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCstExecute(Sender: TObject);
begin
//
end;

procedure TFMenu.ActionCstIcmsAExecute(Sender: TObject);
begin
  NovaPagina(TFCstIcmsA,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCstIcmsBExecute(Sender: TObject);
begin
  NovaPagina(TFCstIcmsB,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCstIpiExecute(Sender: TObject);
begin
  NovaPagina(TFCstIpi,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCstPisExecute(Sender: TObject);
begin
  NovaPagina(TFCstPis,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionEmpresaExecute(Sender: TObject);
begin
  NovaPagina(TFEmpresa,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionEnderecoExecute(Sender: TObject);
begin
//
end;

procedure TFMenu.ActionEstadoCivilExecute(Sender: TObject);
begin
  NovaPagina(TFEstadoCivil,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionIndiceEconomicoExecute(Sender: TObject);
begin
  ShowMessage('indice economico');
end;

procedure TFMenu.ActionMarcaExecute(Sender: TObject);
begin
  NovaPagina(TFMarcaProduto, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionMunicipioExecute(Sender: TObject);
begin
  NovaPagina(TFMunicipio, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionNCMExecute(Sender: TObject);
begin
  NovaPagina(TFNcm, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionNivelFormacaoExecute(Sender: TObject);
begin
  NovaPagina(TFNivelFormacao, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionOperadoraCartaoExecute(Sender: TObject);
begin
  NovaPagina(TFOperadoraCartao, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionOperadoraPlanoSaudeExecute(Sender: TObject);
begin
  NovaPagina(TFOperadoraPlanoSaude, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionPaisExecute(Sender: TObject);
begin
  NovaPagina(TFPais, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionPessoaExecute(Sender: TObject);
begin
  NovaPagina(TFPessoa,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionPisExecute(Sender: TObject);
begin
//
end;

procedure TFMenu.ActionSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFMenu.ActionSalarioMinimoExecute(Sender: TObject);
begin
  NovaPagina(TFSalarioMinimo,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSefipCategoriaTrabalhoExecute(Sender: TObject);
begin
  NovaPagina(TFSefipCategoriaTrabalho,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSefipCodigoMovimentacaoExecute(Sender: TObject);
begin
  NovaPagina(TFSefipCodigoMovimentacao,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSefipCodigoRecolhimentoExecute(Sender: TObject);
begin
  NovaPagina(TFSefipCodigoRecolhimento,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSefipExecute(Sender: TObject);
begin
//
end;

procedure TFMenu.ActionSetorExecute(Sender: TObject);
begin
  NovaPagina(TFSetor,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSindicatoExecute(Sender: TObject);
begin
  NovaPagina(TFSindicato,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSituacaoColaboradorExecute(Sender: TObject);
begin
  NovaPagina(TFSituacaoColaborador,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSituacaoDocumentoExecute(Sender: TObject);
begin
 NovaPagina(TFSituacaoDocumento,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSituacaoExecute(Sender: TObject);
begin
 NovaPagina(TFSituacaoForCli,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSpedExecute(Sender: TObject);
begin
  //
end;

procedure TFMenu.ActionSpedPis4310Execute(Sender: TObject);
begin
  NovaPagina(TFSpedPis4310,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSpedPis4313Execute(Sender: TObject);
begin
  NovaPagina(TFSpedPis4313,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSpedPis4314Execute(Sender: TObject);
begin
  NovaPagina(TFSpedPis4314,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSpedPis4315Execute(Sender: TObject);
begin
  NovaPagina(TFSpedPis4315,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSpedPis4316Execute(Sender: TObject);
begin
  NovaPagina(TFSpedPis4316,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSpedPis439Execute(Sender: TObject);
begin
  NovaPagina(TFSpedPis439,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSubGrupoProdutoExecute(Sender: TObject);
begin
  NovaPagina(TFSubGrupoProduto,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTalonarioChequeExecute(Sender: TObject);
begin
  NovaPagina(TFTalonarioCheque,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoAdmissaoExecute(Sender: TObject);
begin
  NovaPagina(TFTipoAdmissao,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoColaboradorExecute(Sender: TObject);
begin
  NovaPagina(TFTipoColaborador,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoCreditoPisExecute(Sender: TObject);
begin
  NovaPagina(TFTipoCreditoPis,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoDesligamentoExecute(Sender: TObject);
begin
  NovaPagina(TFTipoDesligamento,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoItemSpedExecute(Sender: TObject);
begin
  NovaPagina(TFTipoItemSped,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoRelacionamentoExecute(Sender: TObject);
begin
  NovaPagina(TFTipoRelacionamento,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTransportadoraExecute(Sender: TObject);
begin
  ShowMessage('transportadora');
end;

procedure TFMenu.ActionUfExecute(Sender: TObject);
begin
  NovaPagina(TFUf,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionUnidadeExecute(Sender: TObject);
begin
  NovaPagina(TFUnidadeProduto,(Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionVendasExecute(Sender: TObject);
var
  Parametros: String;
begin
  try
    Parametros := ' ' + Sessao.Usuario.Login + ' ' + Sessao.Usuario.Senha;

    ShellExecute(
          Handle,
          'open',
          'C:\Documents and Settings\Eije\Desktop\T2Ti ERP\Fontes\ERP\Cliente\Vendas\T2TiERPVendas.exe',
          PChar(Parametros),
          '',
          SW_SHOWNORMAL
          );
  except
    Application.MessageBox('Erro ao tentar executar o módulo.', 'Erro do Sistema', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFMenu.RibbonHelpButtonClick(Sender: TObject);
var
  Parametros: String;
begin
  try
    Parametros := ' ' + IntToStr(Sessao.Usuario.Id) + ' "'
                      + Sessao.Usuario.ColaboradorNome + '" '
                      + IntToStr(Sessao.Empresa.Id) + ' "'
                      + Sessao.Empresa.RazaoSocial + '" '
                      + 'MODULO_CADASTROS' + ' '
                      + FormAtivo
                      ;

    ShellExecute(
          Handle,
          'open',
          'C:\Documents and Settings\Eije\Desktop\T2Ti ERP\Fontes\ERP\Cliente\Suporte\T2TiSuporte.exe',
          PChar(Parametros),
          '',
          SW_SHOWNORMAL
          );
  except
    Application.MessageBox('Erro ao tentar executar o módulo.', 'Erro do Sistema', MB_OK + MB_ICONERROR);
  end;
end;
{$EndRegion}

{$Region 'PopupMenu'}
procedure TFMenu.menuFecharClick(Sender: TObject);
begin
  FecharPagina(JvPageList.ActivePage);
end;

procedure TFMenu.menuFecharTodasExcetoEssaClick(Sender: TObject);
begin
  FecharPagina(JvPageList.ActivePage, True);
end;

procedure TFMenu.menuSepararAbaClick(Sender: TObject);
begin
  SepararAba(JvPageList.ActivePage);
end;
{$EndRegion}

end.
