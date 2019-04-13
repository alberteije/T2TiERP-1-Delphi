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
  Dialogs, Menus, ComCtrls, StdCtrls, ExtCtrls, ImgList, XPMan,
  JvExControls, JvComponent, JvPageList, JvTabBar, RibbonLunaStyleActnCtrls,
  Ribbon, ToolWin, ActnMan, ActnCtrls, ActnList, RibbonSilverStyleActnCtrls,
  JvExComCtrls, JvStatusBar, ActnMenus, RibbonActnMenus, JvOutlookBar, JvLookOut,
  ScreenTips, ACBrBase, ACBrEnterTab, ULogin, DB;

type
  TFMenu = class(TForm)
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
    RibbonGrupoGeral: TRibbonGroup;
    ActionManager: TActionManager;
    JvStatusBar1: TJvStatusBar;
    RibbonGrupoDiversos: TRibbonGroup;
    Image48: TImageList;
    ActionCliente: TAction;
    ActionColaborador: TAction;
    Image32: TImageList;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    ActionSituacao: TAction;
    ActionCargo: TAction;
    ActionProduto: TAction;
    ActionProdutoICMS: TAction;
    ActionNCM: TAction;
    ActionUnidade: TAction;
    ActionPais: TAction;
    ActionUF: TAction;
    ActionMunicipio: TAction;
    ActionBairro: TAction;
    ActionCEP: TAction;
    ActionBanco: TAction;
    ActionAgencia: TAction;
    ActionConta: TAction;
    ActionTalonario: TAction;
    ActionContador: TAction;
    ActionSetor: TAction;
    ActionCFOP: TAction;
    ScreenTipsManager: TScreenTipsManager;
    ActionEnderecos: TAction;
    ActionSair: TAction;
    ACBrEnterTab: TACBrEnterTab;
    RibbonPage2: TRibbonPage;
    RibbonGroup2: TRibbonGroup;
    RibbonGroup3: TRibbonGroup;
    ActionPlanoConta: TAction;
    ActionTipoDocumento: TAction;
    ActionLancamentoPagar: TAction;
    ActionPagamento: TAction;
    RibbonGroup4: TRibbonGroup;
    ActionLancamentoReceber: TAction;
    ActionRecebimento: TAction;
    RibbonGroup5: TRibbonGroup;
    ActionMovimentoCaixaBanco: TAction;
    RibbonPage3: TRibbonPage;
    RibbonGroup6: TRibbonGroup;
    ActionPedidoCompra: TAction;
    ActionEmissaoCheque: TAction;
    ActionResumoDiario: TAction;
    ActionConciliacaoBancaria: TAction;
    ActionTipoEndereco: TAction;
    ActionMeiosPagamento: TAction;
    ActionVenda: TAction;
    ActionNotaFiscal: TAction;
    ActionImportaExporta: TAction;
    Empresa: TAction;
    procedure ChangeControl(Sender: TObject);
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
    procedure ActionNivelFormacaoColaboradorExecute(Sender: TObject);
    procedure ActionProdutoExecute(Sender: TObject);
    procedure ActionProdutoICMSExecute(Sender: TObject);
    procedure ActionNCMExecute(Sender: TObject);
    procedure ActionUnidadeExecute(Sender: TObject);
    procedure ActionBairroExecute(Sender: TObject);
    procedure ActionCEPExecute(Sender: TObject);
    procedure ActionBancoExecute(Sender: TObject);
    procedure ActionAgenciaExecute(Sender: TObject);
    procedure ActionContaExecute(Sender: TObject);
    procedure ActionTalonarioExecute(Sender: TObject);
    procedure ActionChequeExecute(Sender: TObject);
    procedure ActionConvenioExecute(Sender: TObject);
    procedure ActionContadorExecute(Sender: TObject);
    procedure ActionAlmoxarifadoExecute(Sender: TObject);
    procedure ActionSetorExecute(Sender: TObject);
    procedure ActionOperadoraCartaoExecute(Sender: TObject);
    procedure ActionCFOPExecute(Sender: TObject);
    procedure ActionIndiceEconomicoExecute(Sender: TObject);
    procedure ActionEstadoCivilExecute(Sender: TObject);
    procedure ActionEnderecosExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionTipoDocumentoExecute(Sender: TObject);
    procedure ActionDocumentoGedExecute(Sender: TObject);
    procedure ActionCentroResultadoExecute(Sender: TObject);
    procedure ActionPlanoContaExecute(Sender: TObject);
    procedure ActionDocumentoOrigemExecute(Sender: TObject);
    procedure ActionStatusParcelaPagarExecute(Sender: TObject);
    procedure ActionTipoPagamentoExecute(Sender: TObject);
    procedure ActionLancamentoPagarExecute(Sender: TObject);
    procedure ActionPagamentoExecute(Sender: TObject);
    procedure ActionStatusParcelaReceberExecute(Sender: TObject);
    procedure ActionLancamentoReceberExecute(Sender: TObject);
    procedure ActionRecebimentoExecute(Sender: TObject);
    procedure ActionTipoRecebimentoExecute(Sender: TObject);
    procedure ActionMovimentoCaixaBancoExecute(Sender: TObject);
    procedure ActionTipoRequisicaoCompraExecute(Sender: TObject);
    procedure ActionRequisicaoCompraExecute(Sender: TObject);
    procedure ActionCotacaoCompraExecute(Sender: TObject);
    procedure ActionConfirmaCotacaoCompraExecute(Sender: TObject);
    procedure ActionMapaComparativoExecute(Sender: TObject);
    procedure ActionPedidoCompraExecute(Sender: TObject);
    procedure ActionCompraSugeridaExecute(Sender: TObject);
    procedure ActionEmissaoChequeExecute(Sender: TObject);
    procedure ActionResumoDiarioExecute(Sender: TObject);
    procedure ActionConciliarChequesExecute(Sender: TObject);
    procedure ActionConciliarLancamentosExecute(Sender: TObject);
    procedure ActionTipoEnderecoExecute(Sender: TObject);
    procedure ActionMeiosPagamentoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionImportaExportaExecute(Sender: TObject);
    procedure ActionNotaFiscalExecute(Sender: TObject);
    procedure ActionVendaExecute(Sender: TObject);
    procedure EmpresaExecute(Sender: TObject);
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
    procedure SepararAba(Pagina: TJvCustomPage);
    var FormAtual: TForm;

  end;

var
  FMenu: TFMenu;
  FormAtivo: String;
  FCorFocado :TColor =$BDECF2;
implementation

uses UCep, UBanco, UTipoEndereco, UAgencia, UContaCaixa, UCfop, UTalonarioCheque,
USituacaoPessoa, USetor, UCargo, UTipoDocumento, UMeiosPagamento, UPlanoContas,
UUnidadeProduto, UPessoa, ULancamentoReceber, UParcelaRecebimento,
ULancamentoPagar, UParcelaPagamento, UImportaContaCaixa, UPedidoCompra,
  Biblioteca, UPDVCarga, UProduto, UColaborador, UNFe, UNcm, UImpostoIcms,
  UContador, UEmpresa;


{$R *.dfm}

{ TFMenu }

{$Region: 'Infra'}
// rodrigues
// isto faz com que mude a cor do edit que tenha o foco, é declarado aqui e usado em todo o aplicatvo
var
  _FAlterado : Boolean = False;
  _FCorAntiga : TColor;
  _FControleAtivo : TWinControl = nil;
procedure SetCtrlFocado(Focar : Boolean);
begin
  if (_FControleAtivo <> nil) then
  try
    if (_FControleAtivo is TCustomEdit) or (_FControleAtivo is TCustomComboBox) then
    begin
      if Focar then
      begin
        _FCorAntiga := TEdit(_FControleAtivo).Color;
        _FAlterado := True;
        TEdit(_FControleAtivo).Color := FCorFocado;
      end
      else
      begin
        TEdit(_FControleAtivo).Color := _FCorAntiga;
        _FAlterado := False;
      end;
    end;
  except
    //vai q o individuo já foi destruido!!!
  end;
end;


procedure TFMenu.ChangeControl(Sender: TObject);
begin
if Application.Terminated then
    Exit;
  if Screen.ActiveControl <> _FControleAtivo then
  begin
      if _FAlterado then
        SetCtrlFocado(False);

      _FControleAtivo := Screen.ActiveControl;
      SetCtrlFocado(True);
  end;
end;
// rodrigues
// fim



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
  FormAtual := Form;

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

procedure TFMenu.EmpresaExecute(Sender: TObject);
begin
  NovaPagina(TFEmpresa, (Sender as TAction).ImageIndex);
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

procedure TFMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja Realmente Sair?', 'Sair do Sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
    Application.Run;
end;

procedure TFMenu.FormCreate(Sender: TObject);
begin
  // rodrigues
  // isto faz com que mude a cor do edit que tenha o foco, é declarado aqui e usado em todo o aplicatvo
  Screen.OnActiveControlChange := ChangeControl;


  Ribbon.Caption:= 'T2Ti Mini Retaguarda [T2Ti Tecnologia da Informação Ltda | Suporte: +55 61 3042.5277]    '+VersaoExe(Application.ExeName,'V');
  if not doLogin then
    Application.Terminate;
  self.WindowState := wsMaximized; // Adicionei esta linha, pois esta sempre voltando para wsNormal
end;

//separa a aba (formulário)
procedure TFMenu.SepararAba(Pagina: TJvCustomPage);
begin
  with Pagina.Components[0] as TForm do
  begin
    Align       := alNone;
    BorderStyle := bsSizeable;
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

function TFMenu.ObterPagina(Aba: TJvTabBarItem): TJvCustomPage;
begin
  Result := JvPageList.Pages[Aba.Index];
end;
{$EndRegion}

{$Region: 'Actions'}
procedure TFMenu.ActionClienteExecute(Sender: TObject);
begin
  NovaPagina(TFPessoa, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionFornecedorExecute(Sender: TObject);
begin
  //NovaPagina(TFFornecedor, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionProdutoExecute(Sender: TObject);
begin
 // ShowMessage('Alterador por Clausqueller,'+#13+' Iniciada por Zenilton'+#13+'Por favor Verificar Funcionalidade!!!');
  NovaPagina(TFProduto, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionRecebimentoExecute(Sender: TObject);
begin
  NovaPagina(TFParcelaRecebimento, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionRequisicaoCompraExecute(Sender: TObject);
begin
//  NovaPagina(TFRequisicaoCompra, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionResumoDiarioExecute(Sender: TObject);
begin
//  NovaPagina(TFResumoTesouraria, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionAgenciaExecute(Sender: TObject);
begin
  NovaPagina(TFAgencia, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionAlmoxarifadoExecute(Sender: TObject);
begin
  ShowMessage('almoxarifado');
end;

procedure TFMenu.ActionAtividadeExecute(Sender: TObject);
begin
  ShowMessage('atividade');
end;

procedure TFMenu.ActionBairroExecute(Sender: TObject);
begin
  ShowMessage('bairro');
end;

procedure TFMenu.ActionBancoExecute(Sender: TObject);
begin
  NovaPagina(TFBanco, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCargoExecute(Sender: TObject);
begin
  NovaPagina(TFCargo, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionCentroResultadoExecute(Sender: TObject);
begin
  ShowMessage('cadastro do centro de resultado');
end;

procedure TFMenu.ActionCEPExecute(Sender: TObject);
begin
  ShowMessage('cep');
end;

procedure TFMenu.ActionCFOPExecute(Sender: TObject);
begin
  NovaPagina(TFCfop, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionChequeExecute(Sender: TObject);
begin
  ShowMessage('cheque');
end;

procedure TFMenu.ActionColaboradorExecute(Sender: TObject);
begin
   NovaPagina(TFColaborador, (Sender as TAction).ImageIndex);
  //ShowMessage('colaborador');
end;

procedure TFMenu.ActionCompraSugeridaExecute(Sender: TObject);
begin
  //Application.CreateForm(TFCriterioCompraSugerida, FCriterioCompraSugerida);
  //FCriterioCompraSugerida.ShowModal;
end;

procedure TFMenu.ActionConciliarChequesExecute(Sender: TObject);
begin
  ShowMessage('conciliar cheque');
end;

procedure TFMenu.ActionConciliarLancamentosExecute(Sender: TObject);
begin
  ShowMessage('conciliar lancamento');
end;

procedure TFMenu.ActionConfirmaCotacaoCompraExecute(Sender: TObject);
begin
//  NovaPagina(TFConfirmaCotacaoCompra, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionContadorExecute(Sender: TObject);
begin
  NovaPagina(TFContador, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionContaExecute(Sender: TObject);
begin
  NovaPagina(TFContaCaixa, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionConvenioExecute(Sender: TObject);
begin
  ShowMessage('convenio');
end;

procedure TFMenu.ActionCotacaoCompraExecute(Sender: TObject);
begin
 // NovaPagina(TFCotacaoCompra, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionDocumentoGedExecute(Sender: TObject);
begin
//  NovaPagina(TFDocumento, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionDocumentoOrigemExecute(Sender: TObject);
begin
  NovaPagina(TFTipoDocumento, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionEmissaoChequeExecute(Sender: TObject);
begin
//  NovaPagina(TFEmissaoCheque, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionEnderecosExecute(Sender: TObject);
begin
  NovaPagina(TFCep, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionEstadoCivilExecute(Sender: TObject);
begin
  ShowMessage('estado civil');
end;

procedure TFMenu.ActionImportaExportaExecute(Sender: TObject);
begin
//  ShowMessage('Rotina em desenvolvimento'+#13+'Jose Rodrigues de Oliveira Junior');
  NovaPagina(TFPDVCarga, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionIndiceEconomicoExecute(Sender: TObject);
begin
  ShowMessage('indice economico');
end;

procedure TFMenu.ActionLancamentoPagarExecute(Sender: TObject);
begin
  NovaPagina(TFLancamentoPagar, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionLancamentoReceberExecute(Sender: TObject);
begin
  NovaPagina(TFLancamentoReceber, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionMapaComparativoExecute(Sender: TObject);
begin
  //NovaPagina(TFMapaComparativo, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionMeiosPagamentoExecute(Sender: TObject);
begin
  NovaPagina(TFMeiosPagamento, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionProdutoICMSExecute(Sender: TObject);
begin
//  ShowMessage('marca');
  NovaPagina(TFImpostoIcms, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionMovimentoCaixaBancoExecute(Sender: TObject);
begin
  Application.CreateForm(TFImportaContaCaixa, FImportaContaCaixa);
  FImportaContaCaixa.ShowModal;
end;

procedure TFMenu.ActionPlanoContaExecute(Sender: TObject);
begin
  NovaPagina(TFPlanoContas, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionNCMExecute(Sender: TObject);
begin
  NovaPagina(TFNcm, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionNivelFormacaoColaboradorExecute(Sender: TObject);
begin
  ShowMessage('nivel de formação do colaborador');
end;

procedure TFMenu.ActionNotaFiscalExecute(Sender: TObject);
begin
  NovaPagina(TFNFe, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionOperadoraCartaoExecute(Sender: TObject);
begin
  ShowMessage('operadora cartao');
end;

procedure TFMenu.ActionPagamentoExecute(Sender: TObject);
begin
  NovaPagina(TFParcelaPagamento, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionPedidoCompraExecute(Sender: TObject);
begin
  NovaPagina(TFPedidoCompra, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFMenu.ActionSetorExecute(Sender: TObject);
begin
  NovaPagina(TFSetor, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionSituacaoExecute(Sender: TObject);
begin
  NovaPagina(TFSituacaoPessoa, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionStatusParcelaPagarExecute(Sender: TObject);
begin
//  NovaPagina(TFStatusParcelaPagar, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionStatusParcelaReceberExecute(Sender: TObject);
begin
//  NovaPagina(TFStatusParcelaReceber, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTalonarioExecute(Sender: TObject);
begin
  NovaPagina(TFTalonarioCheque, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoColaboradorExecute(Sender: TObject);
begin
  ShowMessage('tipo de colaborador');
end;

procedure TFMenu.ActionTipoDocumentoExecute(Sender: TObject);
begin
//  NovaPagina(TFTipoDocumento, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoEnderecoExecute(Sender: TObject);
begin
  NovaPagina(TFTipoEndereco, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoPagamentoExecute(Sender: TObject);
begin
//  NovaPagina(TFTipoPagamento, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoRecebimentoExecute(Sender: TObject);
begin
//  NovaPagina(TFTipoRecebimento, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTipoRequisicaoCompraExecute(Sender: TObject);
begin
 // NovaPagina(TFTipoRequisicaoCompra, (Sender as TAction).ImageIndex);
end;

procedure TFMenu.ActionTransportadoraExecute(Sender: TObject);
begin
  ShowMessage('transportadora');
end;

procedure TFMenu.ActionUnidadeExecute(Sender: TObject);
begin
  NovaPagina(TFUnidadeProduto, (Sender as TAction).ImageIndex);
end;
procedure TFMenu.ActionVendaExecute(Sender: TObject);
begin

end;

{$EndRegion}

{$Region: 'PopupMenu'}
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
