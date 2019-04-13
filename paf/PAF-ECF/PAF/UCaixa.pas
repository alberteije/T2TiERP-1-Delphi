{*******************************************************************************
Title: T2Ti ERP
Description: Tela principal do PAF-ECF - Caixa.

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

@author Albert Eije (T2Ti.COM) | Jose Rodrigues de Oliveira Junior
@version 1.0
*******************************************************************************}

unit UCaixa;

interface

uses
Windows, Dialogs, pngimage, ExtCtrls, Classes, Messages, SysUtils, Variants,
Generics.Collections, Graphics, Controls, Forms, jpeg, StdCtrls, Buttons, Biblioteca,
JvLabel, JvValidateEdit, JvgListBox, JvListBox, JvBaseDlg, JvCalc, JvExExtCtrls,
JvExtComponent, JvClock, JvExStdCtrls, JvEdit, JvExControls, VendaCabecalhoVO,
VendaDetalheVO, MovimentoVO, ConfiguracaoVO, ClienteVO, ACBrBase, ACBrECF, TypInfo,
Constantes, ACBrBAL, ACBrDevice, ACBrInStore, JvAnimatedImage, JvGIFCtrl, Mask,
  jvExMask, JvToolEdit, JvBaseEdits, ACBrLCB, inifiles,
  AppEvnts;

type
  TFCaixa = class(TForm)
    panelPrincipal: TPanel;
    imagePrincipal: TImage;
    labelDescricaoProduto: TJvLabel;
    labelTotalGeral: TJvLabel;
    labelMensagens: TJvLabel;
    imageProduto: TImage;
    Bobina: TJvListBox;
    panelMenuPrincipal: TPanel;
    imagePanelMenuPrincipal: TImage;
    labelMenuPrincipal: TJvLabel;
    listaMenuPrincipal: TJvgListBox;
    panelMenuOperacoes: TPanel;
    imagePanelMenuOperacoes: TImage;
    labelMenuOperacoes: TJvLabel;
    listaMenuOperacoes: TJvgListBox;
    panelSubMenu: TPanel;
    imagePanelSubMenu: TImage;
    listaSupervisor: TJvgListBox;
    listaGerente: TJvgListBox;
    Timer1: TTimer;
    panelTitulo: TPanel;
    panelBotoes: TPanel;
    panelF1: TPanel;
    labelF1: TLabel;
    imageF1: TImage;
    panelF7: TPanel;
    labelF7: TLabel;
    imageF7: TImage;
    panelF2: TPanel;
    labelF2: TLabel;
    imageF2: TImage;
    panelF3: TPanel;
    labelF3: TLabel;
    imageF3: TImage;
    panelF4: TPanel;
    labelF4: TLabel;
    imageF4: TImage;
    panelF5: TPanel;
    labelF5: TLabel;
    imageF5: TImage;
    panelF6: TPanel;
    labelF6: TLabel;
    imageF6: TImage;
    panelF8: TPanel;
    labelF8: TLabel;
    imageF8: TImage;
    panelF9: TPanel;
    labelF9: TLabel;
    imageF9: TImage;
    panelF10: TPanel;
    labelF10: TLabel;
    imageF10: TImage;
    panelF11: TPanel;
    labelF11: TLabel;
    imageF11: TImage;
    panelF12: TPanel;
    labelF12: TLabel;
    imageF12: TImage;
    Calculadora: TJvCalculator;
    Relogio: TJvClock;
    labelOperador: TLabel;
    labelCaixa: TLabel;
    LabelDescontoAcrescimo: TLabel;
    Timer2: TTimer;
    editCodigo: TEdit;
    ACBrBAL1: TACBrBAL;
    ACBrInStore1: TACBrInStore;
    TimeIntegracao: TTimer;
    edtNVenda: TLabel;
    edtCOO: TLabel;
    GifAnimadoRede: TJvGIFAnimator;
    editQuantidade: TJvCalcEdit;
    editUnitario: TJvCalcEdit;
    editTotalItem: TJvCalcEdit;
    editSubTotal: TJvCalcEdit;
    ACBrLCB1: TACBrLCB;
    GifAnimadoLogErro: TJvGIFAnimator;
    ApplicationEvents1: TApplicationEvents;
    procedure EntradaDadosNF;
    procedure DesmembraCodigoDigitado(CodigoDeBarraOuDescricaoOuIdProduto: String);
    procedure MensagemDeProdutoNaoEncontrado;
    procedure FechaMenuOperacoes;
    procedure CarregaPreVenda(Numero: String);
    procedure CarregaDAV(Numero: String);
    procedure VerificaEstadoImpressora;
    procedure TrataExcecao(Sender: TObject; E: Exception);
    procedure ConfiguraACBr;
    procedure CompoeItemParaVenda;
    procedure ParametrosIniciaisVenda;
    procedure ConsultaProduto(Codigo: String; Tipo: Integer);
    procedure ImprimeCabecalhoBobina;
    procedure ImprimeItemBobina;
    function VerificaVendaAberta: Boolean;
    procedure VerificaVendaComProblemas;
    procedure LocalizaProduto;
    procedure AcionaMenuPrincipal;
    procedure AcionaMenuOperacoes;
    procedure AcionaMenuFiscal;
    procedure IdentificaCliente;
    procedure IdentificaVendedor;
    procedure PegaConfiguracao;
    procedure ConfiguraConstantes;
    procedure SetResolucao;
    procedure IniciaMovimento;
    procedure EncerraMovimento;
    procedure CancelaCupom;
    procedure Suprimento;
    procedure Sangria;
    procedure DescontoOuAcrescimo;
    procedure TelaPadrao(Tipo: Integer = 1);
    procedure IniciaVenda;
    procedure IniciaEncerramentoVenda;
    procedure ConcluiEncerramentoVenda;
    procedure VendeItem;
    procedure IniciaVendaDeItens;
    procedure AtualizaTotais;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaMenuPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaMenuOperacoesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaGerenteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaSupervisorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure panelF1MouseLeave(Sender: TObject);
    procedure panelF1MouseEnter(Sender: TObject);
    procedure panelF7MouseEnter(Sender: TObject);
    procedure panelF7MouseLeave(Sender: TObject);
    procedure panelF2MouseEnter(Sender: TObject);
    procedure panelF2MouseLeave(Sender: TObject);
    procedure panelF3MouseEnter(Sender: TObject);
    procedure panelF3MouseLeave(Sender: TObject);
    procedure panelF4MouseLeave(Sender: TObject);
    procedure panelF5MouseEnter(Sender: TObject);
    procedure panelF5MouseLeave(Sender: TObject);
    procedure panelF6MouseEnter(Sender: TObject);
    procedure panelF6MouseLeave(Sender: TObject);
    procedure panelF8MouseEnter(Sender: TObject);
    procedure panelF8MouseLeave(Sender: TObject);
    procedure panelF9MouseEnter(Sender: TObject);
    procedure panelF9MouseLeave(Sender: TObject);
    procedure panelF10MouseEnter(Sender: TObject);
    procedure panelF10MouseLeave(Sender: TObject);
    procedure panelF11MouseEnter(Sender: TObject);
    procedure panelF11MouseLeave(Sender: TObject);
    procedure panelF12MouseEnter(Sender: TObject);
    procedure panelF12MouseLeave(Sender: TObject);
    procedure panelF4MouseEnter(Sender: TObject);
    procedure panelF12Click(Sender: TObject);
    procedure panelF1Click(Sender: TObject);
    procedure panelF2Click(Sender: TObject);
    procedure panelF3Click(Sender: TObject);
    procedure panelF4Click(Sender: TObject);
    procedure panelF5Click(Sender: TObject);
    procedure panelF6Click(Sender: TObject);
    procedure panelF7Click(Sender: TObject);
    procedure panelF8Click(Sender: TObject);
    procedure panelF9Click(Sender: TObject);
    procedure panelF10Click(Sender: TObject);
    procedure panelF11Click(Sender: TObject);
    procedure editCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure editQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure editQuantidadeExit(Sender: TObject);
    procedure DesabilitaControlesVenda;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer2Timer(Sender: TObject);
    procedure editCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ConectaComBalanca;
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
    procedure FormShow(Sender: TObject);
    procedure ConfiguraCores;
    procedure TimeIntegracaoTimer(Sender: TObject);
    procedure RecebeCarga;
    procedure ACBrLCB1LeCodigo(Sender: TObject);
    procedure ConectaComLeitorSerial;
    procedure GifAnimadoLogErroClick(Sender: TObject);
    procedure ExportaParaRetaguarda(Arquivo: String; Tipo: Integer);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
  private
    BalancaLePeso: Boolean;
    procedure ShowHint(Sender: TObject);
    procedure CancelaItem; overload;
    procedure CancelaItem(cancela: Integer); overload;
    { Private declarations }
  public
    Pathlocal, PathCarga, PathSemaforo: String;
    procedure MenuSetaAcima(Indice: Integer; Lista: TJvgListBox);
    procedure MenuSetaAbaixo(Indice: Integer; Lista: TJvgListBox);
    procedure HabilitaControlesVenda;
    { Public declarations }
  end;


var
  FCaixa: TFCaixa;
  MenuAberto: Integer; // 0-não | 1-sim
  StatusCaixa: Integer; // 0-aberto | 1-venda em andamento | 2-venda em recuperação ou importação de PV/DAV | 3-So Consulta | 4-Usuario cancelou a tela Movimento Aberto | 5-Informando dados de NF
  ItemCupom: Integer;
  SubTotal, TotalGeral, Desconto, Acrescimo: Extended;
  MD5: String;
  ProblemaNoPagamento: Boolean;
  MensagemPersistente: String;
  CargaOK, AcionaMenu: Boolean;
  AtualizarEstoque: Integer;

  Movimento: TMovimentoVO;
  Configuracao: TConfiguracaoVO;
  Cliente: TClienteVO;
  VendaCabecalho: TVendaCabecalhoVO;
  ArrayAliquotas: Array [0..50] of String;

implementation

uses UPaf, UImportaNumero, UMesclaPreVenda, UEcf, UMesclaDAV,

  UIdentificaCliente, UValorReal, UDescontoAcrescimo,
  ProdutoController, ProdutoVO, UIniciaMovimento, VendaController, MovimentoController,
  UDataModule, UEfetuaPagamento, UEncerraMovimento, UImportaCliente,
  UConfiguracao, ConfiguracaoController, PosicaoComponentesVO, UImportaProduto,
  UMovimentoAberto, VendedorController, FuncionarioVO, SuprimentoVO, SangriaVO,
  PreVendaController, PreVendaDetalheVO, DAVDetalheVO, DAVController,
  ULoginGerenteSupervisor, ACBrTEFDClass,
  UCancelaPreVenda, UCargaPDV, UExcluiProdutoVenda,
  ULocaliza,USplash , UCheques, ULogImportacao, UNotaFiscal, UPenDrive,
  UMenuFiscal, UCarregaDav;
var
  Produto: TProdutoVO;
  VendaDetalhe: TVendaDetalheVO;
  ListaVendaDetalhe: TObjectList<TVendaDetalheVO>;
  {$R *.dfm}


//****************************************************************************//
// Procedimentos principais e de infra                                        //
//****************************************************************************//

procedure TFCaixa.FormActivate(Sender: TObject);
begin
  FCaixa.Repaint;
end;

procedure TFCaixa.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (StatusCaixa = 0) or (StatusCaixa = 3) then
  begin
    if Application.MessageBox('Tem Certeza Que Deseja Sair do Sistema?', 'Sair do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      SetTaskBar(true);
      FDataModule.ACBrECF.Desativar;
      Application.Terminate;
    end
    else
      CanClose := False;
  end
  else
  begin
    Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    CanClose := False;
  end;
end;

procedure TFCaixa.FormCreate(Sender: TObject);
begin
  ConfiguraAmbiente; // gilson e jose

  AcionaMenu := False;
  Application.CreateForm(TFSplash, FSplash);
  FSplash.Show;
  FSplash.BringToFront;

  Application.CreateForm(TFDataModule, FDataModule);
  Application.OnException := TrataExcecao;
  DesabilitaControlesVenda;
  Movimento := TMovimentoController.VerificaMovimento;
  MenuAberto := 0;
  StatusCaixa := 0;
  Application.OnHint := ShowHint;
  PegaConfiguracao;
  ConfiguraConstantes;
  panelTitulo.Caption := Configuracao.TituloTelaCaixa+'   '+VersaoExe(Application.ExeName,'V');

  if FileExists(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemTela) then
    imagePrincipal.Picture.LoadFromFile(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemTela)
  else
    Configuracao.CaminhoImagensLayout := 'imgLayout\';

  imagePrincipal.Picture.LoadFromFile(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemTela);
  imagePanelMenuPrincipal.Picture.LoadFromFile(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemMenu);
  imagePanelMenuOperacoes.Picture.LoadFromFile(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemMenu);
  imagePanelSubMenu.Picture.LoadFromFile(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemSubMenu);

  SetResolucao;
  ConfiguraCores;

  try
    try
      ConfiguraACBr;
    except
    end;
  finally
    Application.ProcessMessages;
    Timer2.Enabled := True;
    FreeAndNil(FSplash);
  end;
end;

procedure TFCaixa.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  try
    VerificaEstadoImpressora;
    Application.CreateForm(TFEfetuaPagamento, FEfetuaPagamento);
    FEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(1));
    FEfetuaPagamento.Free;
    Application.ProcessMessages;
  except
  end;

  MD5 := 'MD-5:' +UPAF.GeraMD5;

  TelaPadrao;

  if Movimento.Id <> 0 then
  begin
    Application.CreateForm(TFMovimentoAberto, FMovimentoAberto);
    FMovimentoAberto.ShowModal;
  end
  else
    StatusCaixa := 3;

  //só continua o procedimento caso o usuário não cancele a tela FMovimentoAberto
  if StatusCaixa <> 4 then
  begin
    HabilitaControlesVenda;
    editCodigo.SetFocus;
    try
      if not UPAF.ECFAutorizado then
      begin
        Application.MessageBox('ECF não autorizado - aplicação aberta apenas para consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        StatusCaixa := 3;
        labelMensagens.Caption := 'Terminal em Estado Somente Consulta';
        MensagemPersistente := labelMensagens.Caption;
      end;

      if not VerificaVendaAberta then
      begin
        if not UPAF.ConfereGT then
        begin
          Application.MessageBox('Grande total inválido - entre em contato com a Software House.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          StatusCaixa := 3;
          labelMensagens.Caption := 'Terminal em Estado Somente Consulta';
          MensagemPersistente := labelMensagens.Caption;
        end;
      end;
    except
      labelMensagens.Caption := 'Terminal em Estado Somente Consulta';
      MensagemPersistente := labelMensagens.Caption;
    end;
    if StatusCaixa = 0 then
      VerificaVendaComProblemas;

    ProblemaNoPagamento := False;
  end;

  if Configuracao.BalancaModelo > 0 then
  try
    ConectaComBalanca;
  except
    Application.MessageBox('Balança não conectada ou desligada!',
                            'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;

  if Configuracao.UsaLeitorSerial = 1 then
  try
    ConectaComLeitorSerial;
  except
    Application.MessageBox('Leitor de Código de Barras Serial não conectado ou está desligado!'+#13+'Verifique os cabos e reveja as configurações do dispositivo!' ,
                            'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;

  if (Configuracao.TecladoReduzido = 1) then
  begin
    labelF6.Caption:= 'F6 - Localizar';
    panelF1.Visible:= false;
    panelF11.Visible:= false;
  end;

  try
    if Date <> StrToDate(FormatDateTime('dd/mm/yyyy',FDataModule.ACBrECF.DataHora)) then
    begin
      Application.MessageBox('Data do ECF diferente da data do computador - aplicação aberta apenas para consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      StatusCaixa := 3;
      labelMensagens.Caption := 'Data do ECF diferente da data do computador. Terminal em Estado Somente Consulta';
      MensagemPersistente := labelMensagens.Caption;
    end;
  except
  end;

  if Configuracao.NumSerieECF <> FDataModule.ACBrECF.NumSerie then
  begin
    Application.MessageBox('Número de Série do ECF diferente do cadastrado no computador - aplicação aberta apenas para consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    StatusCaixa := 3;
    labelMensagens.Caption := 'Número de Série do ECF diferente do cadastrado na base. Terminal em Estado Somente Consulta';
    MensagemPersistente := labelMensagens.Caption;
  end;

end;

procedure TFCaixa.TimeIntegracaoTimer(Sender: TObject);
begin
  TimeIntegracao.Enabled := False;
  if Configuracao.UsaIntegracao = 1 then
  begin
    RecebeCarga;
  end;
end;

procedure TFCaixa.VerificaEstadoImpressora;
var
  Estado: String;
begin
  Estado := UECF.Estados[FDataModule.ACBrECF.Estado];
  if (Estado = 'Não Inicializada') then
  begin
    Application.MessageBox('Estado da impressora fiscal: Não Inicializada. Aplicação será aberta para somente consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    StatusCaixa := 3;
  end;
  if (Estado = 'Desconhecido') then
  begin
    Application.MessageBox('Estado da impressora fiscal: Desconhecido. Aplicação será aberta para somente consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    StatusCaixa := 3;
  end;
  if (Estado = 'Venda') or (Estado = 'Pagamento') then
  begin
    if not TVendaController.VendaAberta('') then
    begin
      //se por um acaso ocorrer de existir um cupom aberto no ecf e nenhuma venda com status 'A' no BD
      Application.MessageBox('Existe um cupom aberto inconsistente. Cupom fiscal será cancelado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      UEcf.CancelaCupom;
    end;
  end;
  if Estado = 'Requer X' then
  begin
    if Application.MessageBox('É necessário emitir uma Leitura X. Deseja fazer isso agora?', 'Leitura X', Mb_YesNo + Mb_IconQuestion) = IdYes then
      UEcf.LeituraX;
  end;
  if Estado = 'Requer Z' then
  begin
    if Application.MessageBox('É necessário emitir uma Redução Z. Deseja fazer isso agora?', 'Leitura Z', Mb_YesNo + Mb_IconQuestion) = IdYes then
      UEcf.ReducaoZ;
  end;
end;

Procedure TFCaixa.TrataExcecao(Sender: TObject; E: Exception);
begin
  Application.MessageBox(PChar(E.Message), 'Erro do Sistema', MB_OK + MB_ICONERROR);
  if UEfetuaPagamento.TransacaoComTef then
  begin
    FEFetuaPagamento.ACBrTEFD.CancelarTransacoesPendentes;
    FEFetuaPagamento.FechaVendaComProblemas;
    UEfetuaPagamento.PodeFechar := True;
    FEFetuaPagamento.Close;
    if not FDataModule.ACBrECF.EmLinha(0) then
      UCaixa.StatusCaixa := 3
    else
    begin
      try
        UEcf.CancelaCupom;
      except
      end;
      TVendaController.CancelaVenda(VendaCabecalho, ListaVendaDetalhe);
      StatusCaixa := 0;
    end;
    TelaPadrao;
    Application.MessageBox('ECF com problemas ou desligado. Venda cancelada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TFCaixa.ConfiguraACBr;
var
  i: Integer;
begin
  FDataModule.ACBrECF.Modelo := TACBrECFModelo(GetEnumValue(TypeInfo(TACBrECFModelo), Configuracao.ModeloImpressora));
  FDataModule.ACBrECF.Porta := Configuracao.PortaECF;
  FDataModule.ACBrECF.TimeOut := Configuracao.TimeOutECF;
  FDataModule.ACBrECF.IntervaloAposComando := Configuracao.IntervaloECF;
  FDataModule.ACBrECF.Device.Baud := Configuracao.BitsPorSegundo;
  try
    FSplash.lbMensagem.caption := 'Conectando ao ECF...';
    FSplash.lbMensagem.Refresh;
    FDataModule.ACBrECF.Ativar;
    FSplash.lbMensagem.caption := 'ECF conectado!';
    FSplash.lbMensagem.Refresh;
    FSplash.imgECF.Visible := True;
    FSplash.imgTEF.Visible := True;
  except
    FSplash.lbMensagem.caption := 'Falha ao tentar conectar ECF!';
    FSplash.lbMensagem.Refresh;
    Application.MessageBox('ECF com problemas ou desligado. Aplicação será aberta para somente consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    FCaixa.Show;
    DesabilitaControlesVenda;

    Application.CreateForm(TFEfetuaPagamento, FEfetuaPagamento);
    try
      FEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(1));
      FEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(2));
      FEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(3));
    except
    end;
    FEfetuaPagamento.Free;

    StatusCaixa := 3;
    TelaPadrao;
  end;
  FDataModule.ACBrECF.CarregaAliquotas;
  if FDataModule.ACBrECF.Aliquotas.Count <= 0 then
  begin
    Application.MessageBox('ECF sem alíquotas cadastradas. Aplicação será aberta para somente consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    StatusCaixa := 3;
  end
  else
  begin
    for i := 0 to FDataModule.ACBrECF.Aliquotas.Count -1 do
    begin
      ArrayAliquotas[i] := FloatToStr(FDataModule.ACBrECF.Aliquotas[i].Aliquota);
    end;
  end;
  FDataModule.ACBrECF.CarregaFormasPagamento;

  if FDataModule.ACBrECF.FormasPagamento.Count <= 0 then
  begin
    Application.MessageBox('ECF sem formas de pagamento cadastradas. Aplicação será aberta para somente consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    StatusCaixa := 3;
  end;
end;

procedure TFCaixa.PegaConfiguracao;
begin
  Configuracao := TConfiguracaoController.PegaConfiguracao;
end;

procedure TFCaixa.ConfiguraConstantes;
begin
  Constantes.TConstantes.DECIMAIS_QUANTIDADE := Configuracao.DecimaisQuantidade;
  Constantes.TConstantes.DECIMAIS_VALOR := Configuracao.DecimaisValor;
end;

procedure TFCaixa.ConfiguraCores;
begin
  listaMenuPrincipal.HotTrackColor := StringToColor(Configuracao.ResolucaoVO.HotTrackColor);
  listaMenuPrincipal.ItemStyle.Font.Name := Configuracao.ResolucaoVO.ItemStyleFontName;
  listaMenuPrincipal.ItemStyle.Font.Color := StringToColor(Configuracao.ResolucaoVO.ItemStyleFontColor);
  listaMenuPrincipal.ItemSelStyle.Color := StringToColor(Configuracao.ResolucaoVO.ItemSelStyleColor);

  listaMenuOperacoes.HotTrackColor := StringToColor(Configuracao.ResolucaoVO.HotTrackColor);
  listaMenuOperacoes.ItemStyle.Font.Name := Configuracao.ResolucaoVO.ItemStyleFontName;
  listaMenuOperacoes.ItemStyle.Font.Color := StringToColor(Configuracao.ResolucaoVO.ItemStyleFontColor);
  listaMenuOperacoes.ItemSelStyle.Color := StringToColor(Configuracao.ResolucaoVO.ItemSelStyleColor);

  listaGerente.HotTrackColor := StringToColor(Configuracao.ResolucaoVO.HotTrackColor);
  listaGerente.ItemStyle.Font.Name := Configuracao.ResolucaoVO.ItemStyleFontName;
  listaGerente.ItemStyle.Font.Color := StringToColor(Configuracao.ResolucaoVO.ItemStyleFontColor);
  listaGerente.ItemSelStyle.Color := StringToColor(Configuracao.ResolucaoVO.ItemSelStyleColor);

  listaSupervisor.HotTrackColor := StringToColor(Configuracao.ResolucaoVO.HotTrackColor);
  listaSupervisor.ItemStyle.Font.Name := Configuracao.ResolucaoVO.ItemStyleFontName;
  listaSupervisor.ItemStyle.Font.Color := StringToColor(Configuracao.ResolucaoVO.ItemStyleFontColor);
  listaSupervisor.ItemSelStyle.Color := StringToColor(Configuracao.ResolucaoVO.ItemSelStyleColor);

  if trim(Configuracao.ResolucaoVO.ItemStyleFontStyle) = '' then
  begin
    listaMenuPrincipal.ItemStyle.Font.Style   := [];
    listaMenuOperacoes.ItemStyle.Font.Style   := [];
    listaGerente.ItemStyle.Font.Style         := [];
    listaSupervisor.ItemStyle.Font.Style      := [];
  end;
  if trim(Configuracao.ResolucaoVO.ItemStyleFontStyle) = 'NEGRITO' then
  begin
    listaMenuPrincipal.ItemStyle.Font.Style   := [fsBold];
    listaMenuOperacoes.ItemStyle.Font.Style   := [fsBold];
    listaGerente.ItemStyle.Font.Style         := [fsBold];
    listaSupervisor.ItemStyle.Font.Style      := [fsBold];
  end;
  if trim(Configuracao.ResolucaoVO.ItemStyleFontStyle) = 'ITALICO' then
  begin
    listaMenuPrincipal.ItemStyle.Font.Style   := [fsItalic];
    listaMenuOperacoes.ItemStyle.Font.Style   := [fsItalic];
    listaGerente.ItemStyle.Font.Style         := [fsItalic];
    listaSupervisor.ItemStyle.Font.Style      := [fsItalic];
  end;
  if trim(Configuracao.ResolucaoVO.ItemStyleFontStyle) = 'SUBLINHADO' then
  begin
    listaMenuPrincipal.ItemStyle.Font.Style   := [fsUnderLine];
    listaMenuOperacoes.ItemStyle.Font.Style   := [fsUnderLine];
    listaGerente.ItemStyle.Font.Style         := [fsUnderLine];
    listaSupervisor.ItemStyle.Font.Style      := [fsUnderLine];
  end;

  if trim(Configuracao.ResolucaoVO.EditColor) <> '' then
  begin
    editCodigo.Color    := StringToColor(Configuracao.ResolucaoVO.EditColor);
    editQuantidade.Color:= StringToColor(Configuracao.ResolucaoVO.EditColor);
    editUnitario.Color  := StringToColor(Configuracao.ResolucaoVO.EditColor);
    editTotalItem.Color := StringToColor(Configuracao.ResolucaoVO.EditColor);
    editSubTotal.Color  := StringToColor(Configuracao.ResolucaoVO.EditColor);
  end;

  if trim(Configuracao.ResolucaoVO.EditFontColor) <> '' then
  begin
    editCodigo.Font.Color     := StringToColor(Configuracao.ResolucaoVO.EditFontColor);
    editQuantidade.Font.Color := StringToColor(Configuracao.ResolucaoVO.EditFontColor);
    editUnitario.Font.Color   := StringToColor(Configuracao.ResolucaoVO.EditFontColor);
    editTotalItem.Font.Color  := StringToColor(Configuracao.ResolucaoVO.EditFontColor);
    editSubTotal.Font.Color   := StringToColor(Configuracao.ResolucaoVO.EditFontColor);
  end;

  if trim(Configuracao.ResolucaoVO.EditDisabledColor) <> '' then
  begin
    editQuantidade.DisabledColor := StringToColor(Configuracao.ResolucaoVO.EditDisabledColor);
    editUnitario.DisabledColor   := StringToColor(Configuracao.ResolucaoVO.EditDisabledColor);
    editTotalItem.DisabledColor  := StringToColor(Configuracao.ResolucaoVO.EditDisabledColor);
    editSubTotal.DisabledColor   := StringToColor(Configuracao.ResolucaoVO.EditDisabledColor);
  end;

  if trim(Configuracao.ResolucaoVO.EditFontName) <> ''then
  begin
    editCodigo.Font.Name     := Configuracao.ResolucaoVO.EditFontName;
    editQuantidade.Font.Name := Configuracao.ResolucaoVO.EditFontName;
    editUnitario.Font.Name   := Configuracao.ResolucaoVO.EditFontName;
    editTotalItem.Font.Name  := Configuracao.ResolucaoVO.EditFontName;
    editSubTotal.Font.Name   := Configuracao.ResolucaoVO.EditFontName;
  end;

  if trim(Configuracao.ResolucaoVO.EditFontStyle) = '' then
  begin
    editCodigo.Font.Style     := [];
    editQuantidade.Font.Style := [];
    editUnitario.Font.Style   := [];
    editTotalItem.Font.Style  := [];
    editSubTotal.Font.Style   := [];
  end;
  if Configuracao.ResolucaoVO.EditFontStyle = 'NEGRITO' then
  begin
    editCodigo.Font.Style     := [fsBold];
    editQuantidade.Font.Style := [fsBold];
    editUnitario.Font.Style   := [fsBold];
    editTotalItem.Font.Style  := [fsBold];
    editSubTotal.Font.Style   := [fsBold];
  end;
  if Configuracao.ResolucaoVO.EditFontStyle = 'ITALICO' then
  begin
    editCodigo.Font.Style     := [fsItalic];
    editQuantidade.Font.Style := [fsItalic];
    editUnitario.Font.Style   := [fsItalic];
    editTotalItem.Font.Style  := [fsItalic];
    editSubTotal.Font.Style   := [fsItalic];
  end;
  if Configuracao.ResolucaoVO.EditFontStyle = 'SUBLINHADO' then
  begin
    editCodigo.Font.Style     := [fsUnderLine];
    editQuantidade.Font.Style := [fsUnderLine];
    editUnitario.Font.Style   := [fsUnderLine];
    editTotalItem.Font.Style  := [fsUnderLine];
    editSubTotal.Font.Style   := [fsUnderLine];
  end;

  labelTotalGeral.Font.Color := StringToColor(Configuracao.ResolucaoVO.LabelTotalGeralFontColor);
end;

procedure TFCaixa.SetResolucao;
var
	i,j: Integer;
  ListaPosicoes: TObjectList<TPosicaoComponentesVO>;
  PosicaoComponente: TPosicaoComponentesVO;
  NomeComponente: String;
begin
  ListaPosicoes := TConfiguracaoController.VerificaPosicaoTamanho;

  for j := 0 to componentcount - 1 do
  begin
    NomeComponente := components[j].Name;
    for i := 0 to listaPosicoes.Count-1 do
    begin
      PosicaoComponente := listaPosicoes.Items[i];
      if PosicaoComponente.NomeComponente = NomeComponente then begin
        (components[j] as TControl).Height := PosicaoComponente.Altura;
        (components[j] as TControl).Left := PosicaoComponente.Esquerda;
        (components[j] as TControl).Top := PosicaoComponente.Topo;
        (components[j] as TControl).Width := PosicaoComponente.Largura;
        if PosicaoComponente.TamanhoFonte <> 0 then
        begin
          if (components[j] is TEdit) then
             (components[j] as TEdit).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TJVListBox) then
             (components[j] as TJVListBox).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TJVLabel) then
             (components[j] as TJVLabel).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TPanel) then
             (components[j] as TPanel).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TJvCalcEdit) then
             (components[j] as TJvCalcEdit).Font.Size := PosicaoComponente.TamanhoFonte;
        end;
        if (components[j] is TLabel) then
           (components[j] as TLabel).Caption := PosicaoComponente.TextoComponente;
        break;
      end;
    end;
  end;
  FCaixa.Left := 0;
  FCaixa.Top := 0;
  FCaixa.Width := Configuracao.ResolucaoVO.Largura;
  FCaixa.Height := Configuracao.ResolucaoVO.Altura;

  FCaixa.AutoSize := True;
end;

function TFCaixa.VerificaVendaAberta: Boolean;
var
  i: Integer;
  NovoCupom: Boolean;
begin
  NovoCupom := False;
  ListaVendaDetalhe := TVendaController.VendaAberta;
  if Assigned(ListaVendaDetalhe) then
  begin

    if UECF.Estados[FDataModule.ACBrECF.Estado] = 'Livre' then
    begin
      Cliente := TClienteVO.Create;
      Cliente.CPFOuCNPJ := TVendaDetalheVO(ListaVendaDetalhe.Items[0]).IdentificacaoCliente;
      UEcf.AbreCupom(Cliente.CPFOuCNPJ,'','');
      NovoCupom := True;
    end;

    ImprimeCabecalhoBobina;
    ParametrosIniciaisVenda;

    StatusCaixa := 2;
    VendaCabecalho := TVendaCabecalhoVO.Create;
    VendaCabecalho := TVendaController.RetornaCabecalhoDaUltimaVenda;

    labelMensagens.Caption := 'Venda recuperada em andamento..';

    for i := 0 to ListaVendaDetalhe.Count-1 do
    begin
      VendaDetalhe := ListaVendaDetalhe.Items[i];
      ConsultaProduto(VendaDetalhe.GTIN,2);
      CompoeItemParaVenda;
      ImprimeItemBobina;
      SubTotal := SubTotal + VendaDetalhe.ValorTotal;
      TotalGeral := TotalGeral + VendaDetalhe.ValorTotal;
      AtualizaTotais;
      if NovoCupom then
        UECF.VendeItem(VendaDetalhe);
    end;

    Bobina.ItemIndex := Bobina.Items.Count -1;
    editCodigo.SetFocus;
    StatusCaixa := 1;
    result := True;
  end
  else
    result := False;
end;

procedure TFCaixa.VerificaVendaComProblemas;
//var
//  i: Integer;
//  ListaVendaDetalheLocal : TObjectList<TVendaDetalheVO>;
begin
{  ListaVendaDetalheLocal := TVendaController.VendaComProblemas;

  Albert Eije:
  comentado porque a regra do TEF Discado não permite recuperar uma venda
  com problemas.

  if Assigned(ListaVendaDetalheLocal) then
  begin
    Cliente := TClienteVO.Create;
    Cliente.CPFOuCNPJ := TVendaDetalheVO(ListaVendaDetalheLocal.Items[0]).IdentificacaoCliente;
    IniciaVenda;
    ListaVendaDetalhe := ListaVendaDetalheLocal;
    StatusCaixa := 2;
    for i := 0 to ListaVendaDetalhe.Count-1 do
    begin
      Produto := TProdutoController.ConsultaId(TVendaDetalheVO(ListaVendaDetalhe.Items[i]).IdProduto);
      VendaDetalhe := TVendaDetalheVO.Create;
      VendaDetalhe := ListaVendaDetalhe.Items[i];
      VendeItem;
      SubTotal := SubTotal + VendaDetalhe.ValorTotal;
      TotalGeral := TotalGeral + VendaDetalhe.ValorTotal;
      AtualizaTotais;
    end;
    Bobina.ItemIndex := Bobina.Items.Count -1;
    editCodigo.SetFocus;
    StatusCaixa := 1;
  end;}
end;

procedure TFCaixa.ShowHint(Sender: TObject);
begin
  if Application.Hint <> '' then
    labelMensagens.Caption := Application.Hint
  else
    labelMensagens.Caption := MensagemPersistente;
end;

procedure TFCaixa.TelaPadrao(Tipo : Integer = 1);
begin
  Movimento := nil;
  Movimento := TMovimentoController.VerificaMovimento;
  if Movimento.Id = 0 then
  begin
    labelMensagens.Caption := 'CAIXA FECHADO';
    if Tipo = 1 then
      IniciaMovimento;  //se o caixa estiver fechado abre o iniciaMovimento
  end
  else
    if Movimento.Status = 'T' then
      labelMensagens.Caption := 'SAIDA TEMPORÁRIA'
    else
      labelMensagens.Caption := 'CAIXA ABERTO';

  if StatusCaixa = 1 then
    labelMensagens.Caption := 'Venda em andamento...';

  if StatusCaixa = 3 then
    labelMensagens.Caption := 'Terminal em Estado Somente Consulta';

  MensagemPersistente := labelMensagens.Caption;

  editQuantidade.Text := '1';
  editCodigo.Text := '';
  editUnitario.Text := '0';
  editTotalItem.Text := '0';
  editSubTotal.Text := '0';
  labelTotalGeral.Caption := '0,00';
  labelDescricaoProduto.Caption := '';
  LabelDescontoAcrescimo.Caption := '';
  edtNVenda.Caption := '';
  edtCOO.Caption := '';

  SubTotal := 0;
  TotalGeral := 0;
  Desconto := 0;
  Acrescimo := 0;

  Bobina.Clear;
  if Configuracao.MarketingAtivo = 'S' then
    Timer1.Enabled := True
  else
  begin
    if FileExists(Configuracao.CaminhoImagensProdutos + 'padrao.png') then
      imageProduto.Picture.LoadFromFile(Configuracao.CaminhoImagensProdutos + 'padrao.png')
    else
      imageProduto.Picture.LoadFromFile('imgProdutos\padrao.png')
  end;
  Cliente := nil;
end;

procedure TFCaixa.Timer1Timer(Sender: TObject);
var
  Aleatorio: Integer;
begin
  if StatusCaixa = 0 then
  begin
    Aleatorio := 1 + Random(5);
    if FileExists(Configuracao.CaminhoImagensMarketing + IntToStr(aleatorio) + '.jpg') then
      imageProduto.Picture.LoadFromFile(Configuracao.CaminhoImagensMarketing + IntToStr(aleatorio) + '.jpg')
    else
      imageProduto.Picture.LoadFromFile('imgMarketing\' + IntToStr(aleatorio) + '.jpg')
  end;
end;

procedure TFCaixa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if AcionaMenu then
  begin
    // F2 - Menu Principal
    if Key = 113 then
      AcionaMenuPrincipal;

    // F3 - Menu Operações
    if Key = 114 then
      AcionaMenuOperacoes;

    // F4 - Menu Fiscal
    //chamado pelo ApplicationEvents

    // F7 - Encerra Venda
    if Key = 118 then
      IniciaEncerramentoVenda;

    // F8 - Cancela Item
    if Key = 119 then
      CancelaItem;

    // F9 - Cancela Cupom
    if Key = 120 then
      CancelaCupom;

    // F10 - Concede Desconto
    if Key = 121 then
      DescontoOuAcrescimo;

    // F11 - Identifica Vendedor
    if (Key = 122 ) and (Configuracao.TecladoReduzido = 0) then
      IdentificaVendedor; //liberar para outra função  }

    if (ssctrl in shift) and CharInSet(chr(Key),['C','c']) then
    begin
      Application.CreateForm(TFCheques, FCheques);
      FCheques.ShowModal;
    end;

    if (ssctrl in shift) and CharInSet(chr(Key),['B','b']) then
    begin
      if Configuracao.BalancaModelo > 0 then
      begin
        try
          BalancaLePeso:=true;
          ACBrBAL1.LePeso(Configuracao.BalancaTimeOut);
          editCodigo.Text:='';
          editCodigo.SetFocus;
        except
          Application.MessageBox('Balança não conectada ou desligada!',
                                 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      end;
    end;
  end;//if AcionaMenu then

  // F1 - Identifica Cliente
  if (Key = 112) and (Configuracao.TecladoReduzido = 0) then
    IdentificaCliente;  // liberar para outra função  }

  // F5 - Entrada de Dados de NF
  if Key = 116 then
    EntradaDadosNF;

  // F6 - Localiza Produto
  if Key = 117 then
    LocalizaProduto;   // se aprovado, mudar de nome

  // F12 - Sai do Caixa
  if Key = 123 then
    close;
end;

procedure TFCaixa.FormShow(Sender: TObject);
begin
  BalancaLePeso := false;
end;

procedure TFCaixa.GifAnimadoLogErroClick(Sender: TObject);
begin
  Application.CreateForm(TFLogImportacao, FLogImportacao);
  FLogImportacao.ShowModal;
end;

procedure TFCaixa.AcionaMenuPrincipal;
begin
  if StatusCaixa <> 3 then
  begin
    if StatusCaixa <> 1 then
    begin
      if MenuAberto = 0 then
      begin
        MenuAberto := 1;
        panelMenuPrincipal.Visible := True;
        listaMenuPrincipal.SetFocus;
        listaMenuPrincipal.ItemIndex := 0;
        DesabilitaControlesVenda;
      end
    end
    else
     Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

// O Codigo abaixo a para fazer a chamada do Menu Fiscal a partir de qualquer lugar do sistema. Gilson
procedure TFCaixa.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
var
   Key : Word;
begin
  case Msg.Message Of
    WM_KeyDown, WM_SysKeyDown :
    begin
      Key := Msg.wParam;
      if (Key = VK_F4) Then
      begin
        AcionaMenuFiscal;
      end;
    end;
  end;
end;

procedure TFCaixa.AcionaMenuOperacoes;
begin
  if StatusCaixa <> 3 then
  begin
    if StatusCaixa <> 1 then
    begin
      if MenuAberto = 0 then
      begin
        MenuAberto := 1;
        panelMenuOperacoes.Visible := True;
        listaMenuOperacoes.SetFocus;
        listaMenuOperacoes.ItemIndex := 0;
        DesabilitaControlesVenda;
      end;
    end
    else
      Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.ACBrLCB1LeCodigo(Sender: TObject);
begin
  if editCodigo.Focused then  // Para evitar que ponha o codigo no campo quantidade por exemplo
  begin
    editCodigo.Text := ACBrLCB1.UltimoCodigo;    // Preenche o edit com o codigo lido
    keybd_event(VK_RETURN, 0, 0, 0);            // Simula o acionamento da tecla ENTER
  end;
end;

procedure TFCaixa.AcionaMenuFiscal;
var
  GuardaMenu: Integer;
begin
  GuardaMenu := MenuAberto;
  try
    if StatusCaixa <> 1 then
    begin
      MenuAberto := 1;
      if not Assigned(FMenuFiscal) then
      begin
        Application.CreateForm(TFMenuFiscal, FMenuFiscal);
        FMenuFiscal.ShowModal;
      end
      else
        FMenuFiscal.BringToFront;
    end
    else
      Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  finally
    MenuAberto := GuardaMenu;
  end;
end;

procedure TFCaixa.MenuSetaAbaixo(indice: Integer; lista: TJvgListBox);
begin
  if indice = lista.Count - 1 then
    labelMensagens.Caption := lista.Items[lista.ItemIndex]
  else
    labelMensagens.Caption := lista.Items[lista.ItemIndex + 1];
end;

procedure TFCaixa.MenuSetaAcima(indice: Integer; lista: TJvgListBox);
begin
  if indice = 0 then
    labelMensagens.Caption := lista.Items[lista.ItemIndex]
  else
    labelMensagens.Caption := lista.Items[lista.ItemIndex - 1];
end;

//****************************************************************************//
// Procedimentos referentes ao Menu Principal e seus SubMenus                  //
//****************************************************************************//

procedure TFCaixa.listaMenuPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    panelMenuPrincipal.Visible := False;
    labelMensagens.Caption := MensagemPersistente;
    MenuAberto := 0;
    panelSubMenu.Visible := False;
    //
    HabilitaControlesVenda;
    editCodigo.SetFocus;
  end;

  if Key = VK_UP then
    MenuSetaAcima(listaMenuPrincipal.ItemIndex, listaMenuPrincipal);

  if Key = VK_DOWN then
    MenuSetaAbaixo(listaMenuPrincipal.ItemIndex, listaMenuPrincipal);

  if Key = VK_RETURN then
  begin
    //chama submenu do supervisor
    if listaMenuPrincipal.ItemIndex = 0 then
    begin
      Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
      try
        FLoginGerenteSupervisor.ComboCargo.ItemIndex := 1;
        if (FLoginGerenteSupervisor.ShowModal = MROK) then
        begin
          if FLoginGerenteSupervisor.LoginOK then
          begin
            panelSubMenu.Visible := True;
            listaSupervisor.BringToFront;
            listaSupervisor.SetFocus;
            listaSupervisor.ItemIndex := 0;
          end
          else
            Application.MessageBox('Supervisor - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      finally
        if Assigned(FLoginGerenteSupervisor) then
          FLoginGerenteSupervisor.Free;
      end;
    end;

    //chama submenu do gerente
    if listaMenuPrincipal.ItemIndex = 1 then
    begin
      Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
      try
        FLoginGerenteSupervisor.ComboCargo.ItemIndex := 0;
        if (FLoginGerenteSupervisor.ShowModal = MROK) then
        begin
          if FLoginGerenteSupervisor.LoginOK then
          begin
            panelSubMenu.Visible := True;
            listaGerente.BringToFront;
            listaGerente.SetFocus;
            listaGerente.ItemIndex := 0;
          end
          else
            Application.MessageBox('Gerente - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      finally
        if Assigned(FLoginGerenteSupervisor) then
          FLoginGerenteSupervisor.Free;
      end;
    end;

    //saida temporária
    if listaMenuPrincipal.ItemIndex = 2 then
    begin
      if StatusCaixa = 0 then
      begin
        if Application.MessageBox('Deseja fechar o caixa temporariamente?', 'Fecha o caixa temporariamente', Mb_YesNo + Mb_IconQuestion) = IdYes then
        begin
          TMovimentoController.SaidaTemporaria(Movimento);
          Application.CreateForm(TFMovimentoAberto, FMovimentoAberto);
          FMovimentoAberto.ShowModal;
        end;
      end
      else
        Application.MessageBox('Status do caixa não permite saída temporária.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;

    //atualiza estoque
    if listaMenuPrincipal.ItemIndex = 3 then
    begin
     if FDataModule.ConectaBalcao then
      begin
        try
          TimeIntegracao.Enabled := false;
          labelMensagens.Caption := 'Aguarde, Importando Dados';
          Application.CreateForm(TFCargaPDV, FCargaPDV);
          FCargaPDV.Left := Self.Left;
          FCargaPDV.Width := Self.Left;
          FCargaPDV.Tipo := 5;
          FCargaPDV.ShowModal;
        finally
          TimeIntegracao.Enabled := True;
        end;
      end
      else
        Application.MessageBox('Não foi possível conectar ao Servidor, tente mais tarde!','Informação do Sistema',MB_OK+ MB_ICONERROR);
    end;
  end;
end;

procedure TFCaixa.listaSupervisorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    panelSubMenu.Visible := False;
    listaMenuPrincipal.SetFocus;
    listaMenuPrincipal.ItemIndex := 0;
  end;

  if Key = VK_UP then
    MenuSetaAcima(listaSupervisor.ItemIndex, listaSupervisor);

  if Key = VK_DOWN then
    MenuSetaAbaixo(listaSupervisor.ItemIndex, listaSupervisor);

  if Key = VK_RETURN then
  begin
    // inicia movimento
    if listaSupervisor.ItemIndex = 0 then
      IniciaMovimento;
    // encerra movimento
    if listaSupervisor.ItemIndex = 1 then
      EncerraMovimento;
    // suprimento
    if listaSupervisor.ItemIndex = 3 then
      Suprimento;
    // sangria
    if listaSupervisor.ItemIndex = 4 then
      Sangria;
    // Redução Z
    if listaSupervisor.ItemIndex = 6 then
    begin
      if Application.MessageBox('Tem Certeza Que Deseja Executar a Redução Z?'+#13+#13+'O Movimento da Impressora Será Suspenso no dia de Hoje.', 'Redução Z', Mb_YesNo + Mb_IconQuestion) = IdYes then
      begin
        try
          UECF.ReducaoZ;
        finally
          panelSubMenu.Visible := False;
          panelMenuPrincipal.Visible := False;
          MenuAberto := 0;
          HabilitaControlesVenda;
          TelaPadrao(2);
          editCodigo.SetFocus;
        end;
      end;
    end;
  end;
end;

procedure TFCaixa.listaGerenteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    panelSubMenu.Visible := False;
    listaMenuPrincipal.SetFocus;
    listaMenuPrincipal.ItemIndex := 0;
  end;

  if Key = VK_UP then
    MenuSetaAcima(listaGerente.ItemIndex, listaGerente);

  if Key = VK_DOWN then
    MenuSetaAbaixo(listaGerente.ItemIndex, listaGerente);

  if Key = VK_RETURN then
  begin
    // inicia movimento
    if listaGerente.ItemIndex = 0 then
      IniciaMovimento;
    // encerra movimento
    if listaGerente.ItemIndex = 1 then
      EncerraMovimento;
    // suprimento
    if listaGerente.ItemIndex = 3 then
      Suprimento;
    // sangria
    if listaGerente.ItemIndex = 4 then
      Sangria;
    // Redução Z
    if listaGerente.ItemIndex = 6 then
    begin
      if Application.MessageBox('Tem Certeza Que Deseja Executar a Redução Z?'+#13+#13+'O Movimento da Impressora Será Suspenso no dia de Hoje.', 'Redução Z', Mb_YesNo + Mb_IconQuestion) = IdYes then
      begin
        try
          UECF.ReducaoZ;
        finally
          panelSubMenu.Visible := False;
          panelMenuPrincipal.Visible := False;
          MenuAberto := 0;
          HabilitaControlesVenda;
          TelaPadrao(2);
          editCodigo.SetFocus;
        end;
      end;
    end;
    // consultar cliente
    if listaGerente.ItemIndex = 8 then
    begin
      Application.CreateForm(TFImportaCliente, FImportaCliente);
      FImportaCliente.ShowModal;
    end;
    // configuração do sistema
    if listaGerente.ItemIndex = 10 then
    begin
      Application.CreateForm(TFConfiguracao, FConfiguracao);
      FConfiguracao.ShowModal;
      PegaConfiguracao;
    end;
    // funções administrativas do TEF Discado
    if listaGerente.ItemIndex = 12 then
    begin
      Application.CreateForm(TFEfetuaPagamento, FEfetuaPagamento);
      try
        FEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(1));
        FEfetuaPagamento.ACBrTEFD.ADM(TACBrTEFDTipo(1));
      except
        Application.MessageBox('Problemas no GP TEFDIAL.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
      FEfetuaPagamento.Free;
    end;
    // funções administrativas do TECBAN
    if listaGerente.ItemIndex = 13 then
    begin
      Application.CreateForm(TFEfetuaPagamento, FEfetuaPagamento);
      try
        FEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(2));
        FEfetuaPagamento.ACBrTEFD.ADM(TACBrTEFDTipo(2));
      except
        Application.MessageBox('Problemas no GP TECBAN.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
      FEfetuaPagamento.Free;
    end;
    // funções administrativas do HIPER
    if listaGerente.ItemIndex = 14 then
    begin
      Application.CreateForm(TFEfetuaPagamento, FEfetuaPagamento);
      try
        FEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(3));
        FEfetuaPagamento.ACBrTEFD.ADM(TACBrTEFDTipo(3));
      except
        Application.MessageBox('Problemas no GP HIPER.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
      FEfetuaPagamento.Free;
    end;

    // Importar Tabelas com Dispositivo (pen-drive)
    if listaGerente.ItemIndex = 16 then
    begin
      TimeIntegracao.Enabled := False;
      Application.CreateForm(TFPenDrive, FPenDrive);
      FPenDrive.Rotina := 'IMPORTA';
      FPenDrive.ShowModal;
      TimeIntegracao.Enabled := True;
    end;

    // Exportar Tabelas com Dispositivo (pen-drive)
    if listaGerente.ItemIndex = 17 then
    begin
      TimeIntegracao.Enabled := False;
      Application.CreateForm(TFPenDrive, FPenDrive);
      FPenDrive.Rotina := 'EXPORTA';
      FPenDrive.ShowModal;
      TimeIntegracao.Enabled := True;
    end;
  end;
end;

procedure TFCaixa.IniciaMovimento;
begin
  TimeIntegracao.Enabled := false;
  try
    Movimento := TMovimentoController.VerificaMovimento;
    if Movimento.Id = 0 then
    begin
      Application.CreateForm(TFIniciaMovimento, FIniciaMovimento);
      FIniciaMovimento.ShowModal;
    end
    else
    begin
      Application.MessageBox('Já existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
    end;
  finally
    TimeIntegracao.Enabled := True;
  end;
end;

procedure TFCaixa.EncerraMovimento;
begin
  Movimento := TMovimentoController.VerificaMovimento;
  if Movimento.Id = 0 then
    Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  else
  begin
    Application.CreateForm(TFEncerraMovimento, FEncerraMovimento);
    FEncerraMovimento.ShowModal;
  end;
end;

procedure TFCaixa.RecebeCarga;
begin
  TimeIntegracao.Enabled:=False;
  try
    if ExecutaPing(Configuracao.IpServidor) then
    begin
      PathCarga := FDataModule.RemoteAppPath+'Caixa'+IntToStr(Configuracao.IdCaixa)+'\carga.txt';
      PathSemaforo := FDataModule.RemoteAppPath+'Caixa'+IntToStr(Configuracao.IdCaixa)+'\semaforo';

      if (FileExists(PathCarga)) and (FileExists(PathSemaforo)) then
      begin
        labelMensagens.Caption := 'Aguarde, Importando Dados';
        if FCargaPDV = nil then
          Application.CreateForm(TFCargaPDV, FCargaPDV);
        FCargaPDV.Left := Self.Left;
        FCargaPDV.Width := Self.Left;
        FCargaPDV.Tipo := 0;
        FCargaPDV.ShowModal;
      end
      else
      if (FileExists(PathCarga))then
      begin
        Pathlocal:=ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini';
        CopyFile(PChar(Pathlocal), PChar(PathSemaforo), False);
      end;
      GifAnimadoRede.Animate:=true;
    end
    else
      GifAnimadoRede.Animate:=false;
  finally
    TimeIntegracao.Enabled:=True;
    Application.ProcessMessages;
  end;
end;

procedure TFCaixa.Suprimento;
var
  Suprimento: TSuprimentoVO;
  ValorSuprimento: Extended;
begin
  Movimento := TMovimentoController.VerificaMovimento;
  if Movimento.Id = 0 then
    Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  else
  begin
    Application.CreateForm(TFValorReal, FValorReal);
    FValorReal.Caption := 'Suprimento';
    FValorReal.LabelEntrada.Caption := 'Informe o valor do suprimento:';
    try
      if (FValorReal.ShowModal = MROK) then
      begin
        ValorSuprimento := StrToFloat(FValorReal.EditEntrada.Text);

        try
          UEcf.Suprimento(ValorSuprimento, Configuracao.DescricaoSuprimento);
        finally
        end;
        Suprimento := TSuprimentoVO.Create;
        Suprimento.IdMovimento := Movimento.Id;
        Suprimento.DataSuprimento := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
        Suprimento.Valor := ValorSuprimento;
        TMovimentoController.Suprimento(Suprimento);
        Movimento.TotalSuprimento := Movimento.TotalSuprimento + ValorSuprimento;
      end;
    finally
      ExportaParaRetaguarda('Suprimento.txt',3);
    end;
  end;
end;

procedure TFCaixa.Sangria;
var
  Sangria: TSangriaVO;
  ValorSangria: Extended;
begin
  Movimento := TMovimentoController.VerificaMovimento;
  if Movimento.Id = 0 then
    Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  else
  begin
    Application.CreateForm(TFValorReal, FValorReal);
    FValorReal.Caption := 'Sangria';
    FValorReal.LabelEntrada.Caption := 'Informe o valor da sangria:';
    try
      if (FValorReal.ShowModal = MROK) then
      begin
        ValorSangria := StrToFloat(FValorReal.EditEntrada.Text);

        try
          UECF.Sangria(ValorSangria, Configuracao.DescricaoSangria);
        finally
        end;

        Sangria := TSangriaVO.Create;
        Sangria.IdMovimento := Movimento.Id;
        Sangria.DataSangria := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
        Sangria.Valor := ValorSangria;
        TMovimentoController.Sangria(Sangria);
        Movimento.TotalSuprimento := Movimento.TotalSuprimento + ValorSangria;
      end;
    finally
      ExportaParaRetaguarda('Sangria.txt',3);
    end;
  end;
end;

procedure TFCaixa.DescontoOuAcrescimo;
var
  //0-Desconto em Dinheiro
  //1-Desconto Percentual
  //2-Acréscimo em Dinheiro
  //3-Acréscimo Percentual
  //5-Cancela o Desconto ou Acréscimo

  Operacao: Integer;
  Valor: Extended;
begin
  if StatusCaixa <> 3 then
  begin
    if StatusCaixa = 1 then
    begin
      Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
      try
        if (FLoginGerenteSupervisor.ShowModal = MROK) then
        begin
          if FLoginGerenteSupervisor.LoginOK then
          begin
            Application.CreateForm(TFDescontoAcrescimo, FDescontoAcrescimo);
            FDescontoAcrescimo.Caption := 'Desconto ou Acréscimo';
            try
              if (FDescontoAcrescimo.ShowModal = MROK) then
              begin
                Operacao := FDescontoAcrescimo.ComboOperacao.ItemIndex;
                Valor := StrToFloat(FDescontoAcrescimo.EditEntrada.Text);

                //desconto em valor
                if Operacao = 0 then
                begin
                  if Valor >= VendaCabecalho.ValorVenda then
                    Application.MessageBox('Desconto não pode ser superior ou igual ao valor da venda.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                  else
                  begin
                    if Valor <= 0 then
                      Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                    else
                    begin
                      Desconto := Desconto + Valor;
                      AtualizaTotais;
                    end;
                  end;
                end;//if Operacao = 0 then

                //desconto em taxa
                if Operacao = 1 then
                begin
                  if Valor > 99 then
                    Application.MessageBox('Desconto não pode ser superior a 100%.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                  else
                  begin
                    if Valor <= 0 then
                      Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                    else
                    begin
                      VendaCabecalho.TaxaDesconto := 100-(((100-VendaCabecalho.TaxaDesconto)/100)*((100-Valor)/100))*100;

                      Desconto := Desconto + TruncaValor(SubTotal * (Valor/100),Constantes.TConstantes.DECIMAIS_VALOR);
                      AtualizaTotais;
                    end;
                  end;
                end;//if Operacao = 1 then

                //acrescimo em valor
                if Operacao = 2 then
                begin
                  if Valor <= 0 then
                    Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                  else
                  if Valor >=  VendaCabecalho.ValorVenda then
                    Application.MessageBox('Valor do acréscimo não pode ser igual ou superior ao valor da venda!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                  else
                  begin
                    Acrescimo := Acrescimo + Valor;
                    AtualizaTotais;
                  end;
                end;//if Operacao = 2 then

                //acrescimo em taxa
                if Operacao = 3 then
                begin
                  if Valor <= 0 then
                    Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                  else
                  if Valor > 99 then
                    Application.MessageBox('Acréscimo não pode ser superior a 100%!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                  else
                  begin
                    VendaCabecalho.TaxaAcrescimo := (((100+Valor)/100)*((100+VendaCabecalho.TaxaAcrescimo)/100))/100;
                    Acrescimo := Acrescimo + TruncaValor(SubTotal * (Valor/100),Constantes.TConstantes.DECIMAIS_VALOR);
                    AtualizaTotais;
                  end;
                end;//if Operacao = 3 then

                //cancela desconto ou acrescimo
                if Operacao = 5 then
                begin
                  VendaCabecalho.TaxaAcrescimo := 0;
                  VendaCabecalho.TaxaDesconto := 0;
                  Acrescimo := 0;
                  Desconto := 0;
                  AtualizaTotais;
                end;//if Operacao = 5 then

              end;
            finally
              if Assigned(FDescontoAcrescimo) then
                FDescontoAcrescimo.Free;
            end;
          end
          else
            Application.MessageBox('Login - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        end;//if (FLoginGerenteSupervisor.ShowModal = MROK) then
      finally
        if Assigned(FLoginGerenteSupervisor) then
          FLoginGerenteSupervisor.Free;
      end;
    end
    else
      Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
 end
 else
    Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;



//****************************************************************************//
// Procedimentos referentes ao Menu Operações e seus SubMenus                 //
//****************************************************************************//

procedure TFCaixa.listaMenuOperacoesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
	ini: TIniFile;
  RegistraPreVenda: String;
begin

  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
    RegistraPreVenda := UpperCase(Codifica('D', ini.ReadString('ESTABELECIMENTO','REGISTRAPREVENDA','')));
  finally
    ini.Free;
  end;

  if Key = VK_ESCAPE then
  begin
    FechaMenuOperacoes;
  end;

  if Key = VK_UP then
    MenuSetaAcima(listaMenuOperacoes.ItemIndex, listaMenuOperacoes);

  if Key = VK_DOWN then
    MenuSetaAbaixo(listaMenuOperacoes.ItemIndex, listaMenuOperacoes);

  if Key = VK_RETURN then
  begin

    if RegistraPreVenda = 'REGISTRA' then
    begin
      //carrega pre-venda
      if listaMenuOperacoes.ItemIndex = 0 then
      begin
        if StatusCaixa = 0 then
        begin
          if FDataModule.ConectaBalcao then
          begin
            Application.CreateForm(TFImportaNumero, FImportaNumero);
            FImportaNumero.Caption := 'Carrega Pré-Venda';
            FImportaNumero.LabelEntrada.Caption := 'Informe o número da Pré-Venda';
            try
              if (FImportaNumero.ShowModal = MROK) then
              begin
                FechaMenuOperacoes;
                CarregaPreVenda(FImportaNumero.EditEntrada.Text);
                FDataModule.ConexaoBalcao.Close;
              end;
            finally
              if Assigned(FImportaNumero) then
                FImportaNumero.Free;
            end;
          end//if FDataModule.ConectaBalcao then
          else
            Application.MessageBox('Não foi possível conectar ao Balcão, tente mais tarde!','Informação do Sistema',MB_OK+ MB_ICONERROR);
        end//if StatusCaixa = 0 then
        else
          Application.MessageBox('Já existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end;//if listaMenuOperacoes.ItemIndex = 0 then

      //mesclar pre-venda
      if listaMenuOperacoes.ItemIndex = 1 then
      begin
        if FDataModule.ConectaBalcao then
        begin
          Application.CreateForm(TFMesclaPreVenda, FMesclaPreVenda);
          FMesclaPreVenda.ShowModal;
          FDataModule.ConexaoBalcao.Close;
        end
        else
          Application.MessageBox('Não foi possível conectar ao Balcão, tente mais tarde!','Informação do Sistema',MB_OK+ MB_ICONERROR);
      end;//if listaMenuOperacoes.ItemIndex = 1 then

      //cancela pre-venda
      if listaMenuOperacoes.ItemIndex = 2 then
      begin
        if FDataModule.ConectaBalcao then
        begin
          Application.CreateForm(TFCancelaPreVenda, FCancelaPreVenda);
          FCancelaPreVenda.ShowModal;
          FDataModule.ConexaoBalcao.Close;
        end
        else
          Application.MessageBox('Não foi possível conectar ao Balcão, tente mais tarde!','Informação do Sistema',MB_OK+ MB_ICONERROR);
      end;

    end;//if RegistraPreVenda = 'REGISTRA' then

    // carrega dav
    if listaMenuOperacoes.ItemIndex = 3 then
    begin
      if StatusCaixa = 0 then
      begin
        if FDataModule.ConectaBalcao then
        begin
          Application.CreateForm(TFCarregaDAV, FCarregaDAV);
          try
            if (FCarregaDAV.ShowModal = MROK) then
            begin
              FechaMenuOperacoes;
              CarregaDAV(FCarregaDAV.CDSMestre.FieldByName('ID').AsString);
              FDataModule.ConexaoBalcao.Close;
            end;
          finally
            if Assigned(FCarregaDAV) then
              FCarregaDAV.Free;
          end;
        end
        else
          Application.MessageBox('Não foi possível conectar ao Balcão, tente mais tarde!','Informação do Sistema',MB_OK+ MB_ICONERROR);
      end
      else
        Application.MessageBox('Já existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;


    // mesclar DAVs
    if listaMenuOperacoes.ItemIndex = 4 then
    begin
      if FDataModule.ConectaBalcao then
      begin
        Application.CreateForm(TFMesclaDAV, FMesclaDAV);
        FMesclaDAV.ShowModal;
        FDataModule.ConexaoBalcao.Close;
      end
      else
        Application.MessageBox('Não foi possível conectar ao Balcão, tente mais tarde!','Informação do Sistema',MB_OK+ MB_ICONERROR);
    end;

  end;//if Key = VK_RETURN then
end;

procedure TFCaixa.FechaMenuOperacoes;
begin
  panelMenuOperacoes.Visible := False;
  labelMensagens.Caption := MensagemPersistente;
  MenuAberto := 0;
  HabilitaControlesVenda;
  editCodigo.SetFocus;
end;

procedure TFCaixa.CarregaPreVenda(Numero:String);
var
  ListaPreVenda: TObjectList<TPreVendaDetalheVO>;
  PreVendaDetalhe: TPreVendaDetalheVO;
  i: Integer;
begin
  ListaPreVenda := TPreVendaController.CarregaPreVenda(StrToInt(Numero));
  if Assigned(ListaPreVenda) then
  begin
    IniciaVenda;
    StatusCaixa := 2;
    VendaCabecalho.IdPreVenda := TPreVendaDetalheVO(ListaPreVenda.Items[0]).IdPreVenda;
    for i := 0 to ListaPreVenda.Count-1 do
    begin
      PreVendaDetalhe := ListaPreVenda.Items[i];
      Produto := TProdutoController.ConsultaId(PreVendaDetalhe.IdProduto);
      VendaDetalhe := TVendaDetalheVO.Create;
      VendaDetalhe.Quantidade := PreVendaDetalhe.Quantidade;
      VendaDetalhe.ValorUnitario := PreVendaDetalhe.ValorUnitario;
      VendaDetalhe.ValorTotal := PreVendaDetalhe.ValorTotal;
      VendeItem;
      SubTotal   := SubTotal   + VendaDetalhe.ValorTotal;
      TotalGeral := TotalGeral + VendaDetalhe.ValorTotal;
      AtualizaTotais;
      if PreVendaDetalhe.Cancelado = 'S' then
      begin
        UECF.CancelaItem(ItemCupom);
        TVendaController.CancelaItem(VendaDetalhe);

        Bobina.Items.Add(StringOfChar('*', 48));
        Bobina.Items.Add(
            StringOfChar('0', 3 - Length(IntToStr(ItemCupom))) + IntToStr(ItemCupom)
            + '  '
            + VendaDetalhe.GTIN + StringOfChar(' ', 14 - Length(VendaDetalhe.GTIN))
            + ' ' + Copy(VendaDetalhe.DescricaoPDV, 1, 28));

        Bobina.Items.Add('ITEM CANCELADO');
        Bobina.Items.Add(StringOfChar('*', 48));

        SubTotal := SubTotal - VendaDetalhe.ValorTotal;
        TotalGeral := TotalGeral - VendaDetalhe.ValorTotal;

        //cancela possíveis descontos ou acrescimos
        Bobina.ItemIndex := Bobina.Items.Count -1;
        AtualizaTotais;
      end;
    end;
    Bobina.ItemIndex := Bobina.Items.Count -1;
    editCodigo.SetFocus;
    StatusCaixa := 1;
  end
  else
    Application.MessageBox('Pré-Venda inexistente ou já efetivada/mesclada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.CarregaDAV(Numero: String);
var
  ListaDAV: TObjectList<TDAVDetalheVO>;
  DAVDetalhe: TDAVDetalheVO;
  i: Integer;
begin
  ListaDAV := TDAVController.CarregaDAV(StrToInt(Numero));
  if Assigned(ListaDAV) then
  begin
    IniciaVenda;
    StatusCaixa := 2;
    VendaCabecalho.IdDAV := TDAVDetalheVO(ListaDAV.Items[0]).IdDavCabecalho;
    for i := 0 to ListaDAV.Count-1 do
    begin
      DAVDetalhe := ListaDAV.Items[i];
      Produto := TProdutoController.ConsultaId(DAVDetalhe.IdProduto);
      VendaDetalhe := TVendaDetalheVO.Create;
      VendaDetalhe.Quantidade := DAVDetalhe.Quantidade;
      VendaDetalhe.ValorUnitario := DAVDetalhe.ValorUnitario;
      VendaDetalhe.ValorTotal := DAVDetalhe.ValorTotal;
      VendeItem;
      SubTotal := SubTotal + VendaDetalhe.ValorTotal;
      TotalGeral := TotalGeral + VendaDetalhe.ValorTotal;
      AtualizaTotais;

      if DAVDetalhe.Cancelado = 'S' then
      begin
        UECF.CancelaItem(ItemCupom);
        TVendaController.CancelaItem(VendaDetalhe);

        Bobina.Items.Add(StringOfChar('*', 48));
        Bobina.Items.Add(
            StringOfChar('0', 3 - Length(IntToStr(ItemCupom))) + IntToStr(ItemCupom)
            + '  '
            + VendaDetalhe.GTIN + StringOfChar(' ', 14 - Length(VendaDetalhe.GTIN))
            + ' ' + Copy(VendaDetalhe.DescricaoPDV, 1, 28));

        Bobina.Items.Add('ITEM CANCELADO');
        Bobina.Items.Add(StringOfChar('*', 48));

        SubTotal := SubTotal - VendaDetalhe.ValorTotal;
        TotalGeral := TotalGeral - VendaDetalhe.ValorTotal;

        //cancela possíveis descontos ou acrescimos
        Bobina.ItemIndex := Bobina.Items.Count -1;   // Quando o item é cancelado, a "bobina" do aplicativo não avançava
        AtualizaTotais;
      end;

    end;
    Bobina.ItemIndex := Bobina.Items.Count -1;
    editCodigo.SetFocus;
    StatusCaixa := 1;
  end
  else
    Application.MessageBox('DAV inexistente ou já efetivado/mesclado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

//****************************************************************************//
// Procedimentos para controle da venda                                       //
//****************************************************************************//

procedure TFCaixa.LocalizaProduto;
begin
  if Configuracao.TecladoReduzido = 1 then
  begin
    Application.CreateForm(TFLocaliza, FLocaliza);
    FLocaliza.ShowModal;
  end
  else
  begin
    Application.CreateForm(TFImportaProduto, FImportaProduto);
    FImportaProduto.ShowModal;
    if (StatusCaixa = 1) and (trim(editCodigo.Text)<>'') then
    begin
      editCodigo.SetFocus;
      IniciaVendaDeItens;
    end;
  end;
end;

procedure TFCaixa.IdentificaCliente;
begin
  if StatusCaixa <> 3 then
  begin
    Cliente := TClienteVO.Create;
    if Movimento.Id <> 0 then
    begin
      if StatusCaixa = 0 then
      begin
        Application.CreateForm(TFIdentificaCliente, FIdentificaCliente);
        FIdentificaCliente.ShowModal;
        if Cliente.CPFOuCNPJ <> '' then
          IniciaVenda
        else
          Cliente := nil;
      end
      else
        Application.MessageBox('Já existe venda em andamento. Cancele o cupom e inicie nova venda.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end
    else
      Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  end
  else
  begin
    Application.CreateForm(TFImportaCliente, FImportaCliente);
    FImportaCliente.ShowModal;
  end;
end;

procedure TFCaixa.IdentificaVendedor;
var
  Vendedor: TFuncionarioVO;
begin
  if StatusCaixa <> 3 then
  begin
    if StatusCaixa = 1 then
    begin
      Application.CreateForm(TFImportaNumero, FImportaNumero);
      FImportaNumero.Caption := 'Identifica Vendedor';
      FImportaNumero.LabelEntrada.Caption := 'Informe o código do vendedor';
      try
        try
          if (FImportaNumero.ShowModal = MROK) then
          begin
            Vendedor := TVendedorController.ConsultaVendedor(StrToInt(FImportaNumero.EditEntrada.Text));
            if Vendedor.Id <> 0 then
              VendaCabecalho.IdVendedor := Vendedor.Id
            else
              Application.MessageBox('Vendedor: código inválido ou inexistente.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          end;
        except
        end;
      finally
      end;
    end
    else
      Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.IniciaVenda;
begin
  Bobina.Items.Text := '';

  if Movimento.Id = 0 then
    Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  else
  begin
    if not UPAF.ECFAutorizado then
    begin
      Application.MessageBox('ECF não autorizado - aplicação aberta apenas para consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      StatusCaixa := 3;
      labelMensagens.Caption := 'Terminal em Estado Somente Consulta';
      MensagemPersistente := labelMensagens.Caption;
      Abort;
    end
    else if not UPAF.ConfereGT then
    begin
      Application.MessageBox('Grande total inválido - entre em contato com a Software House.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      StatusCaixa := 3;
      labelMensagens.Caption := 'Terminal em Estado Somente Consulta';
      MensagemPersistente := labelMensagens.Caption;
      Abort;
    end
    else
    begin
      try
        FDataModule.ACBrECF.TestaPodeAbrirCupom;
      except
        TelaPadrao;
        editCodigo.SetFocus;
      end;
      //instancia venda e detalhe
      VendaCabecalho := TVendaCabecalhoVO.Create;
      ListaVendaDetalhe := TObjectList<TVendaDetalheVO>.Create(True);

      //parametro para identificar o cliente na abertura do cupom (nota paulista)
      if (Configuracao.PedeCPFCupom = 1) and (not Assigned(Cliente)) then
      begin
        Application.CreateForm(TFIdentificaCliente, FIdentificaCliente);
        FIdentificaCliente.ShowModal;
      end;

      //atribui dados do cliente abre o cupom
      if Assigned(Cliente) then
      begin
        VendaCabecalho.IdCliente := Cliente.Id;
        VendaCabecalho.NomeCliente := Cliente.Nome;
        VendaCabecalho.CPFouCNPJCliente := Cliente.CPFOuCNPJ;
        UECF.AbreCupom(Cliente.CPFOuCNPJ, Cliente.Nome, Cliente.Logradouro);
      end
      else
        UECF.AbreCupom('','','');

      ImprimeCabecalhoBobina;
      ParametrosIniciaisVenda;
      StatusCaixa := 1;
      labelMensagens.Caption := 'Venda em andamento...';
      VendaCabecalho.IdMovimento := Movimento.Id;
      VendaCabecalho.DataVenda := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
      VendaCabecalho.HoraVenda := FormatDateTime('hh:nn:ss', FDataModule.ACBrECF.DataHora);
      VendaCabecalho.StatusVenda := 'A';
      VendaCabecalho.CFOP := Configuracao.CFOPECF;
      VendaCabecalho.COO := StrToInt(FDataModule.ACBrECF.NumCOO);
      VendaCabecalho.CCF := StrToIntDef(FDataModule.ACBrECF.NumCCF,0);   // para resolver problemas com impressoras matricias que devolvem NULL

      VendaCabecalho := TVendaController.IniciaVenda(VendaCabecalho);
      editCodigo.SetFocus;
      editCodigo.SelectAll;

      edtNVenda.Caption := 'VENDA nº '+IntToStr(VendaCabecalho.Id);
      edtCOO.Caption := 'CUPOM nº '+IntToStr(VendaCabecalho.COO);
    end;
  end;
end;

procedure TFCaixa.ParametrosIniciaisVenda;
begin
  Timer1.Enabled := False;

  if FileExists(Configuracao.CaminhoImagensProdutos + 'padrao.png')then
    imageProduto.Picture.LoadFromFile(Configuracao.CaminhoImagensProdutos + 'padrao.png')
  else
    imageProduto.Picture.LoadFromFile('imgProdutos\padrao.png');

  ItemCupom := 0;
  SubTotal := 0;
  TotalGeral := 0;
end;

procedure TFCaixa.ImprimeCabecalhoBobina;
begin
  Bobina.Items.Add(StringOfChar('-', 48));
  Bobina.Items.Add('               ** CUPOM FISCAL **               ');
  Bobina.Items.Add(StringOfChar('-', 48));
  Bobina.Items.Add('ITEM CÓDIGO         DESCRIÇÃO                   ');
  Bobina.Items.Add('QTD.     UN      VL.UNIT.(R$) ST    VL.ITEM(R$)');
  Bobina.Items.Add(StringOfChar('-', 48));
  if Assigned(Cliente) then
  begin
    Bobina.Items.Add('CNPJ/CPF do Consumidor: ' + Cliente.CPFOuCNPJ);
    Bobina.Items.Add(StringOfChar('-', 48));
  end;
end;

procedure TFCaixa.IniciaVendaDeItens;
var
  Unitario, Quantidade, Total: Extended;
  Estado: String;
begin
  TimeIntegracao.Enabled := False;
  if StatusCaixa <> 3 then
  begin

    try
      Estado := UECF.Estados[FDataModule.ACBrECF.Estado];
      if (Estado = 'Requer Z') or (Estado = 'Bloqueada') then
      begin
        StatusCaixa := 3;
        labelMensagens.Caption := 'Terminal em Estado Somente Consulta';
        MensagemPersistente := labelMensagens.Caption;
        if (Estado = 'Requer Z') then
          Application.MessageBox('Impressora Requer Redução Z!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
        else
          Application.MessageBox('Impressora Bloqueada Até o Final do Dia!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        TelaPadrao(2);
        editCodigo.SetFocus;
        Exit;
      end;
    except
      StatusCaixa := 3;
      labelMensagens.Caption := 'Terminal em Estado Somente Consulta';
      MensagemPersistente := labelMensagens.Caption;
      Application.MessageBox('Impressora Bloqueada ou Desligada  ou  Sem Papel  ou Fora de Linha!'+#13+'Caso a Impressora esteja ligada, com Papel e Em Linha'+#13+ 'Verifique se os cabos  estão  devidamente  conectados.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      TelaPadrao(2);
      editCodigo.SetFocus;
      Exit;
    end;

    if UECF.ImpressoraOK then
    begin
      if Movimento.Id = 0 then
      begin
        labelMensagens.Caption := 'CAIXA FECHADO';
        IniciaMovimento;  //se o caixa estiver fechado abre o iniciaMovimento
        Abort;
      end;

      if MenuAberto = 0 then
      begin
        if StatusCaixa = 0 then
        begin
          IniciaVenda;
        end;
        if trim(editCodigo.Text) <> '' then
        begin
          DesmembraCodigoDigitado(trim(editCodigo.Text));
          Application.ProcessMessages;

          if Produto.Id <> 0 then
          begin
            if Produto.ValorVenda <= 0 then
            begin
              Application.MessageBox('Produto não pode ser vendido com valor Zerado ou negativo!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
              editCodigo.SetFocus;
              editCodigo.SelectAll;
              abort;
            end;

            labelMensagens.Caption:='Venda em andamento...';
            MensagemPersistente := labelMensagens.Caption;

            if ACBrInStore1.Peso > 0  then
               editQuantidade.Value:= ACBrInStore1.Peso;

            if ACBrInStore1.Total > 0 then
               editQuantidade.Text:= FormataFloat('Q',(ACBrInStore1.Total/Produto.ValorVenda));

            if (Produto.PodeFracionarUnidade = 'N') and (Frac(StrToFloat(EditQuantidade.Text))>0) then
            begin
              Application.MessageBox('Produto não pode ser vendido com quantidade fracionada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
              editUnitario.Text := '0';
              editTotalItem.Text := '0';
              editQuantidade.Text := '1';
              labelDescricaoProduto.Caption := '';
              editCodigo.Text := '';
              editCodigo.SetFocus;
            end
            else
            begin
              editUnitario.Text := FormataFloat('V',Produto.ValorVenda);
              labelDescricaoProduto.Caption := Produto.DescricaoPDV;
              //carrega imagem do produto
              if FileExists(Configuracao.CaminhoImagensProdutos + Produto.GTIN + '.jpg') then                    // modificar
                imageProduto.Picture.LoadFromFile(Configuracao.CaminhoImagensProdutos + Produto.GTIN + '.jpg')   // modificar
              else
                imageProduto.Picture.LoadFromFile('imgProdutos\padrao.png');            // modificar

              Unitario := StrToFloat(editUnitario.Text);
              Quantidade := StrToFloat(editQuantidade.Text);

              Total := TruncaValor(Unitario * Quantidade, Constantes.TConstantes.DECIMAIS_VALOR);
              editTotalItem.Text := FormataFloat('V', Total);

              VendaDetalhe := TVendaDetalheVO.Create;
              VendeItem;
              SubTotal := SubTotal + VendaDetalhe.ValorTotal;
              TotalGeral := TotalGeral + VendaDetalhe.ValorTotal;
              AtualizaTotais;
              editCodigo.Clear;
              editCodigo.SetFocus;
              editQuantidade.Text := '1';
              Application.ProcessMessages;
            end;//if (Produto.PodeFracionarUnidade = 'N') and (Frac(StrToFloat(EditQuantidade.Text))>0) then
          end
          else
          begin
             MensagemDeProdutoNaoEncontrado;
          end;//if Produto.Id <> 0 then
        end;//if trim(editCodigo.Text) <> '' then
      end;//if MenuAberto = 0 then
    end;//if UECF.ImpressoraOK then
  end;//if StatusCaixa <> 3 then
end;

procedure TFCaixa.ConsultaProduto(Codigo:String;Tipo:integer);
begin
  Produto := TProdutoController.Consulta(Codigo,Tipo);
end;

procedure TFCaixa.MensagemDeProdutoNaoEncontrado;
begin
  Application.MessageBox('Código não encontrado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  editUnitario.Text := '0';
  editTotalItem.Text := '0';
  editQuantidade.Text := '1';
  labelDescricaoProduto.Caption := '';
  editCodigo.SetFocus;
  editCodigo.SelectAll;
end;

procedure TFCaixa.DesmembraCodigoDigitado(CodigoDeBarraOuDescricaoOuIdProduto: string);
var 
  IdentificadorBalanca, vCodDescrId: String;
  LengthInteiro, LengthCodigo: Integer;
begin

  IdentificadorBalanca := Configuracao.BalancaIdentificadorBalanca;
  vCodDescrId := CodigoDeBarraOuDescricaoOuIdProduto;
  LengthInteiro := Length(DevolveInteiro(vCodDescrId));
  LengthCodigo := Length(vCodDescrId);
  ACBrInStore1.ZerarDados;

  try
    if (LengthInteiro = LengthCodigo) and (LengthCodigo <= 4) and (BalancaLePeso = True) then
    begin
      ConsultaProduto(vCodDescrId,1);
      if Produto.Id <> 0 then
        Exit;
    end;
  finally
    BalancaLePeso := false;
  end;

  if ((LengthInteiro = 13) and (LengthCodigo= 13))  or  ((LengthInteiro = 14) and (LengthCodigo = 14)) then
  begin
    if (LengthInteiro = 13) and (IdentificadorBalanca = Copy(vCodDescrId,1,1)) then
    begin
      ACBrInStore1.Codificacao := trim(Configuracao.BalancaTipoConfiguracaoBalanca);
      ACBrInStore1.Desmembrar(trim(vCodDescrId));
      ConsultaProduto(ACBrInStore1.Codigo,1);
      if Produto.Id <> 0 then
        Exit
      else
        ACBrInStore1.ZerarDados;
    end;
    ConsultaProduto(vCodDescrId,2);
    if Produto.Id <> 0 then
      Exit;
  end;
  ConsultaProduto(vCodDescrId,3);
  if Produto.Id <> 0 then
    Exit;
  if LengthInteiro = LengthCodigo then
  begin
    ConsultaProduto(copy(vCodDescrId,1,14),4);
    if Produto.Id <> 0 then
      Exit;
  end
  else
  begin
    Application.CreateForm(TFImportaProduto, FImportaProduto);
    FImportaProduto.EditLocaliza.Text:= vCodDescrId;
    FImportaProduto.ShowModal;
    if (Length(DevolveInteiro(editCodigo.text))) = (Length(trim(editCodigo.text))) then
    begin
      Produto.Id :=0;
      ConsultaProduto(trim(editCodigo.text),4);
    end
    else
    begin
      MensagemDeProdutoNaoEncontrado;
      Abort;
    end;
  end;
end;

procedure TFCaixa.editCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_RETURN :
      if trim(editCodigo.Text) <> '' then
        IniciaVendaDeItens;
  end;
end;

procedure TFCaixa.VendeItem;
var
  i: Integer;
  Aliquota: String;
  Existe: Boolean;
begin
  CompoeItemParaVenda;

  Existe := False;
  Aliquota := VendaDetalhe.ECFICMS;
  if copy(VendaDetalhe.ECFICMS,1,1) = '0' then
  Aliquota := Copy(VendaDetalhe.ECFICMS,2,1);

  if (Aliquota = 'II') or (Aliquota = 'NN') or (Aliquota = 'FF') then
    Existe := True
  else
  begin
    //for i := 0 to 50 do
    for i := 0 to high(ArrayAliquotas) do
    begin
      if Aliquota = ArrayAliquotas[i] Then
      begin
        Existe := True;
        Break;
      end;
    end;
  end;

  if not Existe then
  begin
    Application.MessageBox('Produto com ICMS Não Definido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    editUnitario.Text  := '0';
    editTotalItem.Text := '0';
    editSubTotal.Text  := '0';
    editCodigo.SetFocus;
    editCodigo.SelectAll;
    Dec(ItemCupom);
    Abort;
  end;

  if VendaDetalhe.ECFICMS = '' then
  begin
    Application.MessageBox('Produto com ICMS Não Cadastrado na Impressora!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    editUnitario.Text  := '0';
    editTotalItem.Text := '0';
    editSubTotal.Text  := '0';
    editCodigo.SetFocus;
    editCodigo.SelectAll;
    Dec(ItemCupom);
    Abort;
  end;

  if VendaDetalhe.GTIN = '' then
  begin
    Application.MessageBox('Produto com Código ou GTIN Não Definido!' , 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    editUnitario.Text  := '0';
    editTotalItem.Text := '0';
    editSubTotal.Text  := '0';
    editCodigo.SetFocus;
    editCodigo.SelectAll;
    Dec(ItemCupom);
    Abort;
  end;

  if VendaDetalhe.DescricaoPDV = '' then
  begin
    Application.MessageBox('Produto com Descrição Não Definida!' , 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    editUnitario.Text  := '0';
    editTotalItem.Text := '0';
    editSubTotal.Text  := '0';
    editCodigo.SetFocus;
    editCodigo.SelectAll;
    Dec(ItemCupom);
    Abort;
  end;

  if VendaDetalhe.UnidadeProduto = '' then
  begin
    Application.MessageBox('Produto com Unidade Não Definida!' , 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    editUnitario.Text  := '0';
    editTotalItem.Text := '0';
    editSubTotal.Text  := '0';
    editCodigo.SetFocus;
    editCodigo.SelectAll;
    Dec(ItemCupom);
    Abort;
  end;

  //vende item
  UECF.VendeItem(VendaDetalhe);
  VendaDetalhe := TVendaController.InserirItem(VendaDetalhe);
  ListaVendaDetalhe.Add(VendaDetalhe);
  ImprimeItemBobina;
  Bobina.ItemIndex := Bobina.Items.Count -1;
end;

procedure TFCaixa.CompoeItemParaVenda;
begin
  inc(ItemCupom);
  VendaDetalhe.IdProduto := Produto.Id;
  VendaDetalhe.CFOP := Configuracao.CFOPECF;
  VendaDetalhe.IdVendaCabecalho := VendaCabecalho.Id;
  VendaDetalhe.DescricaoPDV := Produto.DescricaoPDV;
  VendaDetalhe.UnidadeProduto := Produto.UnidadeProduto;
  VendaDetalhe.CST := Produto.Cst;
  VendaDetalhe.ECFICMS := Produto.ECFICMS;
  VendaDetalhe.TaxaICMS := Produto.AliquotaICMS;
  VendaDetalhe.TotalizadorParcial := Produto.TotalizadorParcial;

  if trim(Produto.GTIN)= '' then
    VendaDetalhe.GTIN := IntToStr(Produto.Id)
  else
    VendaDetalhe.GTIN := Produto.GTIN;

  VendaDetalhe.Item := ItemCupom;
  if Produto.IPPT = 'T' then
    VendaDetalhe.MovimentaEstoque := 'S'
  else
    VendaDetalhe.MovimentaEstoque := 'N';
  if StatusCaixa = 1 then
  begin
    VendaDetalhe.Quantidade := StrToFloat(editQuantidade.Text);
    VendaDetalhe.ValorUnitario := StrToFloat(editUnitario.Text);
    VendaDetalhe.ValorTotal := StrToFloat(editTotalItem.Text);
    VendaDetalhe.TotalItem := StrToFloat(editTotalItem.Text);
  end;
end;

procedure TFCaixa.ImprimeItemBobina;
var
  Quantidade, Unitario, Total, Unidade: String;
begin
  Quantidade := FloatToStrF(VendaDetalhe.Quantidade,ffNumber,8,3);
  Unitario := FloatToStrF(VendaDetalhe.ValorUnitario,ffNumber,13,2);
  Total := FloatToStrF(VendaDetalhe.ValorTotal,ffNumber,14,2);
  Bobina.Items.Add(
      StringOfChar('0', 3 - Length(IntToStr(ItemCupom))) + IntToStr(ItemCupom)
      + '  '
      + VendaDetalhe.GTIN + StringOfChar(' ', 14 - Length(VendaDetalhe.GTIN))
      + ' ' + Copy(VendaDetalhe.DescricaoPDV, 1, 28));

  Unidade := Trim(Copy(VendaDetalhe.UnidadeProduto,1,3));

  Bobina.Items.Add(
      StringOfChar(' ', 8 - Length(Quantidade)) + Quantidade
      + ' '
      + StringOfChar(' ', 3 - Length(Unidade)) + Unidade
      + ' x '
      + StringOfChar(' ', 13 - Length(Unitario)) + Unitario
      + ' '
      + StringOfChar(' ', 5 - Length(VendaDetalhe.ECFICMS)) + VendaDetalhe.ECFICMS
      + StringOfChar(' ', 14 - Length(Total)) + Total);
end;

procedure TFCaixa.AtualizaTotais;
var
  DescontoAcrescimo: Extended;
begin
  VendaCabecalho.ValorVenda := SubTotal;
  VendaCabecalho.Desconto := Desconto;
  VendaCabecalho.Acrescimo := Acrescimo;

  VendaCabecalho.ValorFinal := TotalGeral - Desconto + Acrescimo;
  DescontoAcrescimo := Acrescimo - Desconto;

  if DescontoAcrescimo < 0 then
  begin
    LabelDescontoAcrescimo.Caption := 'Desconto: R$ ' + FormatFloat('0.00',-DescontoAcrescimo);
    LabelDescontoAcrescimo.Font.Color := clRed;
    VendaCabecalho.Desconto := -DescontoAcrescimo;
    VendaCabecalho.Acrescimo := 0;
  end
  else if DescontoAcrescimo > 0 then
  begin
    LabelDescontoAcrescimo.Caption := 'Acréscimo: R$ ' + FormatFloat('0.00',DescontoAcrescimo);
    LabelDescontoAcrescimo.Font.Color := clBlue;
    VendaCabecalho.Desconto := 0;
    VendaCabecalho.Acrescimo := DescontoAcrescimo;
  end
  else
  begin
    LabelDescontoAcrescimo.Caption := '';
    VendaCabecalho.TaxaAcrescimo := 0;
    VendaCabecalho.TaxaDesconto := 0;
    Acrescimo := 0;
    Desconto := 0;
  end;

  if ((VendaCabecalho.ValorFinal < VendaCabecalho.ValorVenda) and
     (VendaCabecalho.TaxaDesconto <> 0) and
     (Desconto <> ((1-(VendaCabecalho.ValorFinal/VendaCabecalho.ValorVenda))*100)) ) then
  begin
    VendaCabecalho.TaxaDesconto := (1-(VendaCabecalho.ValorFinal/VendaCabecalho.ValorVenda))*100;
    VendaCabecalho.TaxaAcrescimo := 0;
  end;

  if ((VendaCabecalho.ValorFinal > VendaCabecalho.ValorVenda) and
     (VendaCabecalho.TaxaAcrescimo <> 0) and
     (Acrescimo <> ((VendaCabecalho.ValorFinal/VendaCabecalho.ValorVenda)*100)-100) ) then
  begin
    VendaCabecalho.TaxaAcrescimo := ((VendaCabecalho.ValorFinal/VendaCabecalho.ValorVenda)*100)-100;
    VendaCabecalho.TaxaDesconto := 0;
  end;

  editSubTotal.Text := FormatFloat('0.00', VendaCabecalho.ValorVenda);
  labelTotalGeral.Caption :=Format('%18.2n',[VendaCabecalho.ValorFinal]);
end;

procedure TFCaixa.IniciaEncerramentoVenda;
begin
  if StatusCaixa <> 3 then
  begin
    if StatusCaixa = 1 then
    begin
      if ListaVendaDetalhe.Count > 0 then
      begin
        VendaCabecalho.CupomFoiCancelado := 'N';
        if VendaCabecalho.ValorFinal <=0 then
        begin
          if Application.MessageBox('Todos os itens foram cancelados.'+
                                    #13+#13+'Deseja cancelar o cupom?',
                                    'Cancelar o cupom', Mb_YesNo + Mb_IconQuestion) = IdYes then
            CancelaCupom;
          Abort;
        end;

        ProblemaNoPagamento := False;
        Application.CreateForm(TFEfetuaPagamento, FEfetuaPagamento);
        FEfetuaPagamento.ShowModal;
        edtNVenda.Caption := '';
        edtCOO.Caption := '';
        if ProblemaNoPagamento then
          VerificaVendaComProblemas;
      end
      else
        Application.MessageBox('A venda não contém itens.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end
    else
      Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.ConcluiEncerramentoVenda;
begin
  try
    TVendaController.EncerraVenda(VendaCabecalho);
  finally
    FreeAndNil(VendaCabecalho);
    FreeAndNil(ListaVendaDetalhe);
    FreeAndNil(Produto);
    TelaPadrao;
  end;
end;

procedure TFCaixa.editCodigoKeyPress(Sender: TObject; var Key: Char);
var
  Quantidade: Extended;
begin
  if Key = '.' then
    Key := DecimalSeparator;

  if (key = #13) and (trim(editCodigo.Text) = '') then
  begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;

  if key = '*' then
  begin
    Key := #0;
    try
      Quantidade:=StrToFloat(editCodigo.Text);
      if (Quantidade <= 0) or (Quantidade > 999) then
      begin
        Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
        editCodigo.Text := '';
        editQuantidade.Text := '1';
      end
      else
      begin
        editQuantidade.Text := editCodigo.Text;
        editCodigo.Text := '';
      end;
    except
      Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
      editCodigo.Text := '';
      editQuantidade.Text := '1';
    end;
  end;
end;

procedure TFCaixa.editQuantidadeExit(Sender: TObject);
begin
  if (editQuantidade.Value <= 0) or (editQuantidade.Value > 999) then
  begin
    Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
    editQuantidade.Value := 1;
  end;
end;

procedure TFCaixa.editQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TFCaixa.CancelaCupom;
begin
  if StatusCaixa <> 3 then
  begin
    if Movimento.Id = 0 then
      Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
    else
    begin
      if (StatusCaixa = 0) or (StatusCaixa = 1) then
      begin
        Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
        try
          if (FLoginGerenteSupervisor.ShowModal = MROK) then
          begin
            if FLoginGerenteSupervisor.LoginOK then
            begin
              if (StatusCaixa = 1) then
              begin
                if Application.MessageBox('Deseja cancelar o cupom atual?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
                begin
                  UEcf.CancelaCupom;
                  TVendaController.CancelaVenda(VendaCabecalho, ListaVendaDetalhe);
                  StatusCaixa := 0;
                  TelaPadrao;
                end;
              end
              else if (StatusCaixa = 0) then
              begin
                if Application.MessageBox('Deseja cancelar o cupom anterior?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
                begin
                  //verifica se a ultima venda já teve o seu cupom cancelado
                  if TVendaController.CupomJaFoiCancelado then
                  begin
                    Application.MessageBox('O cupom referente à última venda já foi cancelado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
                  end
                  else
                  begin
                    if TVendaController.CancelaVendaAnterior then
                    begin
                      ExportaParaRetaguarda('',2);
                      Application.MessageBox('Cupom cancelado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
                    end
                    else
                      Application.MessageBox('Problemas ao cancelar cupom anterior.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
                  end;
                end;
              end;
            end
            else
              Application.MessageBox('Login - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          end;
        finally
          if Assigned(FLoginGerenteSupervisor) then
             FLoginGerenteSupervisor.Free;
        end;
      end
      else
        Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  end
  else
    Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.CancelaItem;
var
  Cancela: Integer;
begin
  if StatusCaixa <> 3 then
  begin
    if StatusCaixa = 1 then
    begin
      Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
      try
        if (FLoginGerenteSupervisor.ShowModal = MROK) then
        begin
          if FLoginGerenteSupervisor.LoginOK then
          begin

            Application.CreateForm(TFExcluiProdutoVenda, FExcluiProdutoVenda);
            try
              if (FExcluiProdutoVenda.ShowModal = MROK) then
              begin
                Cancela := FExcluiProdutovenda.cdsVendaDetalheitem.Value;
                if cancela > 0 then
                begin
                  if cancela <= ListaVendaDetalhe.Count then
                  begin
                    VendaDetalhe := ListaVendaDetalhe.Items[cancela-1];

                    if VendaDetalhe.Cancelado <> 'S' then
                    begin
                      UECF.CancelaItem(cancela);

                      VendaDetalhe.Cancelado := 'S';
                      TVendaController.CancelaItem(VendaDetalhe);

                      Bobina.Items.Add(StringOfChar('*', 48));
                      Bobina.Items.Add(
                          StringOfChar('0', 3 - Length(IntToStr(cancela))) + IntToStr(cancela)
                          + '  '
                          + VendaDetalhe.GTIN + StringOfChar(' ', 14 - Length(VendaDetalhe.GTIN))
                          + ' ' + Copy(VendaDetalhe.DescricaoPDV, 1, 28));

                      Bobina.Items.Add('ITEM CANCELADO');
                      Bobina.Items.Add(StringOfChar('*', 48));

                      SubTotal := SubTotal - VendaDetalhe.ValorTotal;
                      TotalGeral := TotalGeral - VendaDetalhe.ValorTotal;

                      //cancela possíveis descontos ou acrescimos
                      Desconto := 0;
                      Acrescimo := 0;
                      VendaCabecalho.TaxaAcrescimo := 0;
                      VendaCabecalho.TaxaDesconto := 0;
                      Bobina.ItemIndex := Bobina.Items.Count -1;   // Quando o item é cancelado, a "bobina" do aplicativo não avançava
                      AtualizaTotais;
                    end
                    else
                      Application.MessageBox('O item solicitado já foi cancelado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
                  end
                  else
                    Application.MessageBox('O item solicitado não existe na venda atual.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
                end
                else
                  Application.MessageBox('Informe um número de item válido.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
              end;
            finally
              if Assigned(FExcluiProdutovenda) then
                FExcluiProdutovenda.Free;
            end;
          end
          else
            Application.MessageBox('Login - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      finally
          if Assigned(FLoginGerenteSupervisor) then
            FLoginGerenteSupervisor.Free;
      end;
    end
    else
      Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.CancelaItem(Cancela: Integer);
begin
  try
    if Cancela > 0 then
    begin
      if cancela <= ListaVendaDetalhe.Count then
      begin
        VendaDetalhe := ListaVendaDetalhe.Items[cancela-1];

        if VendaDetalhe.Cancelado <> 'S' then
        begin

          UEcf.CancelaItem(cancela);

          VendaDetalhe.Cancelado := 'S';
          TVendaController.CancelaItem(VendaDetalhe);

          Bobina.Items.Add(StringOfChar('*', 48));
          Bobina.Items.Add
            (StringOfChar('0', 3 - Length(IntToStr(cancela))) + IntToStr
              (cancela) + '  ' + VendaDetalhe.GTIN + StringOfChar
              (' ', 14 - Length(VendaDetalhe.GTIN)) + ' ' + Copy
              (VendaDetalhe.DescricaoPDV, 1, 28));

          Bobina.Items.Add('ITEM CANCELADO');
          Bobina.Items.Add(StringOfChar('*', 48));

          SubTotal := SubTotal - VendaDetalhe.ValorTotal;
          TotalGeral := TotalGeral - VendaDetalhe.ValorTotal;

          // cancela possíveis descontos ou acrescimos
          Desconto := 0;
          Acrescimo := 0;
          VendaCabecalho.TaxaAcrescimo := 0;
          VendaCabecalho.TaxaDesconto := 0;

          AtualizaTotais;
        end
        else
          Application.MessageBox('O item solicitado já foi cancelado.',
            'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end
      else
        Application.MessageBox(
          'O item solicitado não existe na venda atual.',
          'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  finally
  end;
end;

procedure TFCaixa.DesabilitaControlesVenda;
begin
  EditCodigo.Enabled := False;
  EditQuantidade.Enabled := False;
  EditUnitario.Enabled := False;
  EditTotalItem.Enabled := False;
  EditSubTotal.Enabled := False;
  Bobina.Enabled := False;
  panelBotoes.Enabled := False;
  FCaixa.KeyPreview := False;
  TimeIntegracao.Enabled := False;
end;

procedure TFCaixa.HabilitaControlesVenda;
begin
  EditCodigo.Enabled := True;
  EditQuantidade.Enabled := True;
  EditUnitario.Enabled := True;
  EditTotalItem.Enabled := True;
  EditSubTotal.Enabled := True;
  Bobina.Enabled := True;
  panelBotoes.Enabled := True;
  FCaixa.KeyPreview := True;

  if Configuracao.UsaIntegracao = 1 then
  begin
    if Configuracao.TimerIntegracao > 0 then
      TimeIntegracao.Interval:= Configuracao.TimerIntegracao*1000;
    TimeIntegracao.Enabled:=True;
  end;
end;

procedure TFCaixa.EntradaDadosNF;
var
  GuardaStatus: Integer;
begin
  if (Configuracao.LancamentoNotasManuais <> 1) then
  begin
    Application.MessageBox('Lançamento de notas manuais não disponivel.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  if (StatusCaixa <> 1)  then
  begin
    try
      GuardaStatus := StatusCaixa;
      StatusCaixa := 5;
      TimeIntegracao.Enabled := False;
      Application.CreateForm(TFNotaFiscal, FNotaFiscal);
      FNotaFiscal.ShowModal;
      Application.OnHint := ShowHint;
    finally

      ExportaParaRetaguarda('NF2.txt',3);
      StatusCaixa := GuardaStatus;
    end;
  end
  else
    Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.ExportaParaRetaguarda(Arquivo: String; Tipo: Integer);
begin
  TimeIntegracao.Enabled := False;
  try
    if (Arquivo <> '') and (not(FileExists(ExtractFilePath(Application.ExeName)+'Script\'+Arquivo))) then
      exit;
    if (Configuracao.UsaIntegracao = 1) then
    begin
      FCaixa.labelMensagens.Caption:='Aguarde..., Exportando Dados';
      Application.ProcessMessages;
      if FCargaPDV = nil then
         Application.CreateForm(TFCargaPDV, FCargaPDV);
      FCargaPDV.Tipo := Tipo;
      FCargaPDV.NomeArquivo := Arquivo;
      FCargaPDV.ShowModal;
      Application.ProcessMessages;
    end;
  finally
    TimeIntegracao.Enabled := True;
  end;
end;

//****************************************************************************//
// Aparência e controle dos painéis com as funções do programa - F1 a F12     //
//****************************************************************************//
procedure TFCaixa.panelF1MouseEnter(Sender: TObject);
begin
  panelF1.BevelOuter := bvRaised;
  panelF1.BevelWidth := 2;
end;

procedure TFCaixa.panelF1MouseLeave(Sender: TObject);
begin
  panelF1.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF1Click(Sender: TObject);
begin
  IdentificaCliente;
end;

procedure TFCaixa.panelF2MouseEnter(Sender: TObject);
begin
  panelF2.BevelOuter := bvRaised;
  panelF2.BevelWidth := 2;
end;

procedure TFCaixa.panelF2MouseLeave(Sender: TObject);
begin
  panelF2.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF2Click(Sender: TObject);
begin
  AcionaMenuPrincipal;
end;

procedure TFCaixa.panelF3MouseEnter(Sender: TObject);
begin
  panelF3.BevelOuter := bvRaised;
  panelF3.BevelWidth := 2;
end;

procedure TFCaixa.panelF3MouseLeave(Sender: TObject);
begin
  panelF3.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF3Click(Sender: TObject);
begin
  AcionaMenuOperacoes;
end;

procedure TFCaixa.panelF4MouseEnter(Sender: TObject);
begin
  panelF4.BevelOuter := bvRaised;
  panelF4.BevelWidth := 2;
end;

procedure TFCaixa.panelF4MouseLeave(Sender: TObject);
begin
  panelF4.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF4Click(Sender: TObject);
begin
  AcionaMenuFiscal;
end;

procedure TFCaixa.panelF5MouseEnter(Sender: TObject);
begin
  panelF5.BevelOuter := bvRaised;
  panelF5.BevelWidth := 2;
end;

procedure TFCaixa.panelF5MouseLeave(Sender: TObject);
begin
  panelF5.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF5Click(Sender: TObject);
begin
  EntradaDadosNF;
end;

procedure TFCaixa.panelF6MouseEnter(Sender: TObject);
begin
  panelF6.BevelOuter := bvRaised;
  panelF6.BevelWidth := 2;
end;

procedure TFCaixa.panelF6MouseLeave(Sender: TObject);
begin
  panelF6.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF6Click(Sender: TObject);
begin
  LocalizaProduto;
end;

procedure TFCaixa.panelF7MouseEnter(Sender: TObject);
begin
  panelF7.BevelOuter := bvRaised;
  panelF7.BevelWidth := 2;
end;

procedure TFCaixa.panelF7MouseLeave(Sender: TObject);
begin
  panelF7.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF7Click(Sender: TObject);
begin
  IniciaEncerramentoVenda;
end;

procedure TFCaixa.panelF8MouseEnter(Sender: TObject);
begin
  panelF8.BevelOuter := bvRaised;
  panelF8.BevelWidth := 2;
end;

procedure TFCaixa.panelF8MouseLeave(Sender: TObject);
begin
  panelF8.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF8Click(Sender: TObject);
begin
  CancelaItem;
end;

procedure TFCaixa.panelF9MouseEnter(Sender: TObject);
begin
  panelF9.BevelOuter := bvRaised;
  panelF9.BevelWidth := 2;
end;

procedure TFCaixa.panelF9MouseLeave(Sender: TObject);
begin
  panelF9.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF9Click(Sender: TObject);
begin
  CancelaCupom;
end;

procedure TFCaixa.panelF10MouseEnter(Sender: TObject);
begin
  panelF10.BevelOuter := bvRaised;
  panelF10.BevelWidth := 2;
end;

procedure TFCaixa.panelF10MouseLeave(Sender: TObject);
begin
  panelF10.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF10Click(Sender: TObject);
begin
  DescontoOuAcrescimo;
end;

procedure TFCaixa.panelF11MouseEnter(Sender: TObject);
begin
  panelF11.BevelOuter := bvRaised;
  panelF11.BevelWidth := 2;
end;

procedure TFCaixa.panelF11MouseLeave(Sender: TObject);
begin
  panelF11.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF11Click(Sender: TObject);
begin
  IdentificaVendedor;
end;

procedure TFCaixa.panelF12MouseEnter(Sender: TObject);
begin
  panelF12.BevelOuter := bvRaised;
  panelF12.BevelWidth := 2;
end;

procedure TFCaixa.panelF12MouseLeave(Sender: TObject);
begin
  panelF12.BevelOuter := bvNone;
end;

procedure TFCaixa.panelF12Click(Sender: TObject);
begin
  Close;
end;


//****************************************************************************//
// Procedimentos para ler peso direto das balanças componente ACBrBal         //
//****************************************************************************//
procedure TFCaixa.ConectaComBalanca;    // novo procedimento balança
begin
  // se houver conecção aberta, Fecha a conecção
  if ACBrBAL1.Ativo then
    ACBrBAL1.Desativar;

  // configura porta de comunicação
  ACBrBAL1.Modelo             := TACBrBALModelo(Configuracao.BalancaModelo);
  ACBrBAL1.Device.HandShake   := TACBrHandShake(Configuracao.BalancaHandShaking);
  ACBrBAL1.Device.Parity      := TACBrSerialParity(Configuracao.BalancaParity);
  ACBrBAL1.Device.Stop        := TACBrSerialStop(Configuracao.BalancaStopBits);
  ACBrBAL1.Device.Data        := Configuracao.BalancaDataBits;
  ACBrBAL1.Device.Baud        := Configuracao.BalancaBaudRate;
  ACBrBAL1.Device.Porta       := Configuracao.BalancaPortaSerial;
  // Conecta com a balança
  ACBrBAL1.Ativar;
end;

procedure TFCaixa.ConectaComLeitorSerial;
begin
  // se houver conecção aberta, Fecha a conecção
  if ACBrLCB1.Ativo then
    ACBrBAL1.Desativar;

  // configura porta de comunicação
  ACBrLCB1.Porta  := Configuracao.PortaLeitorSerial;
  ACBrLCB1.Device.Baud  := StrToInt(Configuracao.BaudLeitorSerial);
  ACBrLCB1.Sufixo  := Configuracao.SufixoLeitorSerial;
  ACBrLCB1.Intervalo := StrToInt(Configuracao.IntervaloLeitorSerial);
  ACBrLCB1.Device.Data  := StrToInt(Configuracao.DataLeitorSerial);
  ACBrLCB1.Device.Parity  := TACBrSerialParity(Configuracao.ParidadeLeitorSerial);
  if Configuracao.HardFlowLeitorSerial = 0 then
    ACBrLCB1.Device.HardFlow := False
  else
    ACBrLCB1.Device.HardFlow := True;
  if Configuracao.SoftFlowLeitorSerial = 0 then
    ACBrLCB1.Device.SoftFlow := False
  else
    ACBrLCB1.Device.SoftFlow := True;

  ACBrLCB1.Device.HandShake  := TACBrHandShake(Configuracao.HandShakeLeitorSerial);
  ACBrLCB1.Device.Stop  :=  TACBrSerialStop(Configuracao.StopLeitorSerial);

  if Configuracao.FilaLeitorSerial = 1 Then
    ACBrLCB1.UsarFila  := True
  else
    ACBrLCB1.UsarFila  := False;

  if Configuracao.ExcluiSufixoLeitorSerial = 1 then
    ACBrLCB1.ExcluirSufixo  :=  True
  else
    ACBrLCB1.ExcluirSufixo  :=  False;

  ACBrLCB1.Ativar;
end;

procedure TFCaixa.ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
var
  valid: Integer;
begin
   editCodigo.Text:=   formatFloat('##0.000', Peso )+'*';
   if Peso > 0 then
   begin
     labelMensagens.Caption := 'Leitura da Balança OK !' ;
     editQuantidade.Text:=   formatFloat('##0.000', Peso );
     editCodigo.SetFocus;
   end
   else
   begin
     valid := Trunc(ACBrBAL1.UltimoPesoLido);
     case valid of
       0   : labelMensagens.Caption := 'Coloque o produto sobre a Balança!';
       -1  : labelMensagens.Caption := 'Tente Nova Leitura';
       -2  : labelMensagens.Caption := 'Peso Negativo !' ;
       -10 : labelMensagens.Caption := 'Sobrepeso !' ;
     end;
  end;
end;

end.
