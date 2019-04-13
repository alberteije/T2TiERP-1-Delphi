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

@author Albert Eije (T2Ti.COM)
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
Constantes;

type
  TFCaixa = class(TForm)
    panelPrincipal: TPanel;
    imagePrincipal: TImage;
    labelDescricaoProduto: TJvLabel;
    labelTotalGeral: TJvLabel;
    labelMensagens: TJvLabel;
    imageProduto: TImage;
    editCodigo: TJvValidateEdit;
    editQuantidade: TJvValidateEdit;
    editUnitario: TJvValidateEdit;
    editTotalItem: TJvValidateEdit;
    editSubTotal: TJvValidateEdit;
    Bobina: TJvListBox;
    panelMenuPrincipal: TPanel;
    imagePanelMenuPrincipal: TImage;
    labelMenuPrincipal: TJvLabel;
    listaMenuPrincipal: TJvgListBox;
    panelMenuOperacoes: TPanel;
    imagePanelMenuOperacoes: TImage;
    labelMenuOperacoes: TJvLabel;
    listaMenuOperacoes: TJvgListBox;
    panelMenuFiscal: TPanel;
    imagePanelMenuFiscal: TImage;
    labelMenuFiscal: TJvLabel;
    listaMenuFiscal: TJvgListBox;
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
    procedure FechaMenuOperacoes;
    procedure CarregaPreVenda(Numero:String);
    procedure CarregaDAV(Numero:String);
    procedure VerificaEstadoImpressora;
    procedure TrataExcecao(Sender: TObject; E: Exception);
    procedure ConfiguraACBr;
    procedure CompoeItemParaVenda;
    procedure ParametrosIniciaisVenda;
    procedure ConsultaProduto(Codigo:String);
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
    procedure CancelaItem;
    procedure CancelaCupom;
    procedure Suprimento;
    procedure Sangria;
    procedure DescontoOuAcrescimo;
    procedure TelaPadrao;
    procedure IniciaVenda;
    procedure IniciaEncerramentoVenda;
    procedure ConcluiEncerramentoVenda;
    procedure VendeItem;
    procedure AtualizaTotais;
    procedure MenuSetaAcima(indice: Integer; lista: TJvgListBox);
    procedure MenuSetaAbaixo(indice: Integer; lista: TJvgListBox);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaMenuPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaMenuOperacoesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaMenuFiscalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaGerenteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure listaSupervisorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure editCodigoExit(Sender: TObject);
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
    procedure HabilitaControlesVenda;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer2Timer(Sender: TObject);
  private
    procedure ShowHint(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FCaixa: TFCaixa;
  MenuAberto: Integer; // 0-não | 1-sim
  StatusCaixa: Integer; // 0-aberto | 1-venda em andamento | 2-venda em recuperação ou importação de PV/DAV | 3-So Consulta | 4-Usuario cancelou a tela Movimento Aberto
  ItemCupom: Integer;
  SubTotal, TotalGeral, Desconto, Acrescimo: Extended;
  MD5: String;
  ProblemaNoPagamento: Boolean;

  Movimento: TMovimentoVO;
  Configuracao: TConfiguracaoVO;
  Cliente: TClienteVO;
  VendaCabecalho: TVendaCabecalhoVO;

implementation

uses UPaf, UImportaNumero, UMesclaPreVenda, UEcf, UMesclaDAV, ULmfc, ULmfs,
  UEspelhoMfd, UArquivoMfd, UMeiosPagamento, UDavEmitidos,
  UVendasPeriodo, UIdentificaCliente, UValorReal, UDescontoAcrescimo,
  ProdutoController, ProdutoVO, UIniciaMovimento, VendaController, MovimentoController,
  UDataModule, UEfetuaPagamento, UEncerraMovimento, UImportaCliente,
  UConfiguracao, ConfiguracaoController, PosicaoComponentesVO, UImportaProduto,
  UMovimentoAberto, VendedorController, FuncionarioVO, SuprimentoVO, SangriaVO,
  PreVendaController, PreVendaDetalheVO, DAVDetalheVO, DAVController,
  RegistroRController, ULoginGerenteSupervisor, UMovimentoECF, ACBrTEFDClass;
var
  Produto: TProdutoVO;
  VendaDetalhe: TVendaDetalheVO;
  ListaVendaDetalhe : TObjectList<TVendaDetalheVO>;
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
  Application.CreateForm(TFDataModule, FDataModule);
  Application.OnException := TrataExcecao;
  DesabilitaControlesVenda;
  Movimento := TMovimentoController.VerificaMovimento;
  MenuAberto := 0;
  StatusCaixa := 0;
  Application.OnHint := ShowHint;
//  SetTaskBar(false);
  pegaConfiguracao;
  ConfiguraConstantes;
  panelTitulo.Caption := Configuracao.TituloTelaCaixa;
  {imagePrincipal.Picture.LoadFromFile(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemTela);
  imagePanelMenuPrincipal.Picture.LoadFromFile(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemMenu);
  imagePanelMenuOperacoes.Picture.LoadFromFile(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemMenu);
  imagePanelMenuFiscal.Picture.LoadFromFile(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemMenu);
  imagePanelSubMenu.Picture.LoadFromFile(Configuracao.CaminhoImagensLayout + Configuracao.ResolucaoVO.ImagemSubMenu);}

  imagePrincipal.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'imgLayout\' + Configuracao.ResolucaoVO.ImagemTela);
  imagePanelMenuPrincipal.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'imgLayout\' + Configuracao.ResolucaoVO.ImagemMenu);
  imagePanelMenuOperacoes.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'imgLayout\' + Configuracao.ResolucaoVO.ImagemMenu);
  imagePanelMenuFiscal.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'imgLayout\' + Configuracao.ResolucaoVO.ImagemMenu);
  imagePanelSubMenu.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'imgLayout\' + Configuracao.ResolucaoVO.ImagemSubMenu);

  setResolucao;
  ConfiguraACBr;
  Application.ProcessMessages;

  Timer2.Enabled := True;
end;

procedure TFCaixa.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  VerificaEstadoImpressora;

  Application.CreateForm(TFEfetuaPagamento, FEfetuaPagamento);
  try
    FEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(1));
    FEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(2));
    FEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(3));
  except
  end;
  FEfetuaPagamento.Free;

  MD5 := UPAF.GeraMD5;
  FCaixa.Show;
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

{    if not UPAF.ECFAutorizado then
    begin
      Application.MessageBox('ECF não autorizado - aplicação aberta apenas para consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      StatusCaixa := 3;
      labelMensagens.Caption := 'Terminal em Estado Somente Consulta';
    end;
}
    if not VerificaVendaAberta then
    begin
      {if not UPAF.ConfereGT then
      begin
        Application.MessageBox('Grande total inválido - entre em contato com a Software House.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        StatusCaixa := 3;
        labelMensagens.Caption := 'Terminal em Estado Somente Consulta';
      end;}
    end;

    if StatusCaixa = 0 then
    begin
      VerificaVendaComProblemas;
    end;

    ProblemaNoPagamento := False;
  end;

  EditCodigo.SetFocus;
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
var
  Mensagem: String;
begin
{  Application.MessageBox(PChar(E.Message), 'Erro do Sistema', MB_OK + MB_ICONERROR);
  if UEfetuaPagamento.TransacaoComTef then
    FEfetuaPagamento.ComboTipoPagamento.Enabled := False;
    FEfetuaPagamento.EditValorPago.Enabled := False;
    FEfetuaPagamento.PanelConfirmaValores.Enabled := False;
    FEfetuaPagamento.GridValores.Enabled := False;
    FEfetuaPagamento.BotaoConfirma.Enabled := False;
    FEfetuaPagamento.BotaoCancela.Enabled := False;
    Mensagem := 'Impressora não responde'#$D#$A'Tentar novamente ?';
    while not FDataModule.ACBrECF.EmLinha(7) do
    begin
      if Application.MessageBox(PChar(Mensagem), 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
      begin
        if FDataModule.ACBrECF.EmLinha(0) then
          FEFetuaPagamento.FinalizaVenda;
      end
      else
      begin
        FEFetuaPagamento.FechaVendaComProblemas;
        UEfetuaPagamento.PodeFechar := True;
        FEFetuaPagamento.Close;
        if not FDataModule.ACBrECF.EmLinha(0) then
          UCaixa.StatusCaixa := 3;
        TelaPadrao;
        Break;
      end;
    end;}
  if E.Message <> 'Erro. Impressora com pouco ou sem papel' then
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
begin
  FDataModule.ACBrECF.Modelo := TACBrECFModelo(GetEnumValue(TypeInfo(TACBrECFModelo), Configuracao.ModeloImpressora));
  FDataModule.ACBrECF.Porta := Configuracao.PortaECF;
  FDataModule.ACBrECF.TimeOut := Configuracao.TimeOutECF;
  FDataModule.ACBrECF.IntervaloAposComando := Configuracao.IntervaloECF;
  FDataModule.ACBrECF.Device.Baud := Configuracao.BitsPorSegundo;
  try
    FDataModule.ACBrECF.Ativar;
  except
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
  end;
  FDataModule.ACBrECF.CarregaFormasPagamento;
  //
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

procedure TFCaixa.SetResolucao;
var
	i,j:integer;
  ListaPosicoes : TObjectList<TPosicaoComponentesVO>;
  PosicaoComponente : TPosicaoComponentesVO;
  NomeComponente : String;
begin
  ListaPosicoes := TObjectList<TPosicaoComponentesVO>.Create(True);
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
      UEcf.AbreCupom(Cliente.CPFOuCNPJ,'');
      NovoCupom := True;
    end;

    ImprimeCabecalhoBobina;
    ParametrosIniciaisVenda;

    StatusCaixa := 2;
    VendaCabecalho := TVendaCabecalhoVO.Create;
    VendaCabecalho.IdMovimento := Movimento.Id;
    VendaCabecalho.Id := TVendaDetalheVO(ListaVendaDetalhe.Items[0]).IdVendaCabecalho;

    labelMensagens.Caption := 'Venda recuperada em andamento..';

    for i := 0 to ListaVendaDetalhe.Count-1 do
    begin
      VendaDetalhe := ListaVendaDetalhe.Items[i];
      ConsultaProduto(VendaDetalhe.GTIN);
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
var
  i: Integer;
  ListaVendaDetalheLocal : TObjectList<TVendaDetalheVO>;
begin
  ListaVendaDetalheLocal := TVendaController.VendaComProblemas;
  {
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
  labelMensagens.Caption := Application.Hint;
end;

procedure TFCaixa.TelaPadrao;
begin
  if Movimento.Id = 0 then
    labelMensagens.Caption := 'CAIXA FECHADO'
  else
    if Movimento.Status = 'T' then
      labelMensagens.Caption := 'SAIDA TEMPORÁRIA'
    else
      labelMensagens.Caption := 'CAIXA ABERTO';

  if StatusCaixa = 1 then
    labelMensagens.Caption := 'Venda em andamento...';

  if StatusCaixa = 3 then
    labelMensagens.Caption := 'Terminal em Estado Somente Consulta';

  editQuantidade.Text := '1';
  editCodigo.Text := '';
  editUnitario.Text := '0';
  editTotalItem.Text := '0';
  editSubTotal.Text := '0';
  labelTotalGeral.Caption := '0,00';
  labelDescricaoProduto.Caption := '';
  LabelDescontoAcrescimo.Caption := '';

  SubTotal := 0;
  TotalGeral := 0;
  Desconto := 0;
  Acrescimo := 0;

  Bobina.Clear;
  if Configuracao.MarketingAtivo = 'S' then
    Timer1.Enabled := True
  else
    imageProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'imgProdutos\' + 'padrao.png');
  Cliente := nil;
end;

procedure TFCaixa.Timer1Timer(Sender: TObject);
var
  aleatorio: Integer;
begin
  if StatusCaixa = 0 then
  begin
    aleatorio := 1 + Random(5);
    imageProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'imgMarketing\' + IntToStr(aleatorio) + '.jpg')
  end;
end;

procedure TFCaixa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  begin
  // F1 - Identifica Cliente
  if Key = 112 then
    IdentificaCliente;
  // F2 - Menu Principal
  if Key = 113 then
    AcionaMenuPrincipal;
  // F3 - Menu Operações
  if Key = 114 then
    AcionaMenuOperacoes;
  // F4 - Menu Fiscal
  if Key = 115 then
    AcionaMenuFiscal;
  // F5 - Calculadora
  if Key = 116 then
    Calculadora.Execute;
  // F6 - Localiza Produto
  if Key = 117 then
    LocalizaProduto;
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
  if Key = 122 then
    IdentificaVendedor;
  // F12 - Sai do Caixa
  if Key = 123 then
    close;
end;

procedure TFCaixa.AcionaMenuPrincipal;
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

procedure TFCaixa.AcionaMenuFiscal;
begin
  if StatusCaixa <> 1 then
  begin
    if MenuAberto = 0 then
    begin
      MenuAberto := 1;
      panelMenuFiscal.Visible := True;
      listaMenuFiscal.SetFocus;
      listaMenuFiscal.ItemIndex := 0;
      DesabilitaControlesVenda;
    end;
  end
  else
    Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
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
    labelMensagens.Caption := '';
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
        UECF.ReducaoZ;
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
        UECF.ReducaoZ;
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
  end;
end;

procedure TFCaixa.IniciaMovimento;
begin
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

procedure TFCaixa.Suprimento;
var
  Suprimento: TSuprimentoVO;
  ValorSuprimento : Extended;
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
    end;
  end;
end;

procedure TFCaixa.Sangria;
var
  Sangria : TSangriaVO;
  ValorSangria : Extended;
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
    end;
  end;
end;

procedure TFCaixa.DescontoOuAcrescimo;
var
  Operacao: integer;
  {
  0-Desconto em Dinheiro
  1-Desconto Percentual
  2-Acréscimo em Dinheiro
  3-Acréscimo Percentual
  5-Cancela o Desconto ou Acréscimo
  }
  Valor: Extended;
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
          FDescontoAcrescimo.Caption := 'Desconto em Dinheiro';
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
                    Desconto := Valor;
                    VendaCabecalho.TaxaAcrescimo := 0;
                    Acrescimo := 0;
                    AtualizaTotais;
                  end;
                end;
              end;

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
                    VendaCabecalho.TaxaDesconto := Valor;
                    Desconto := TruncaValor(SubTotal * (Valor/100),Constantes.TConstantes.DECIMAIS_VALOR);
                    VendaCabecalho.TaxaAcrescimo := 0;
                    Acrescimo := 0;
                    AtualizaTotais;
                  end;
                end;
              end;

              //acrescimo em valor
              if Operacao = 2 then
              begin
                if Valor <= 0 then
                  Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  Acrescimo := Valor;
                  VendaCabecalho.TaxaDesconto := 0;
                  Desconto := 0;
                  AtualizaTotais;
                end;
              end;

              //acrescimo em taxa
              if Operacao = 3 then
              begin
                if Valor <= 0 then
                  Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  VendaCabecalho.TaxaAcrescimo := Valor;
                  Acrescimo := TruncaValor(SubTotal * (Valor/100),Constantes.TConstantes.DECIMAIS_VALOR);
                  VendaCabecalho.TaxaDesconto := 0;
                  Desconto := 0;
                  AtualizaTotais;
                end;
              end;

              //cancela desconto ou acrescimo
              if Operacao = 5 then
              begin
                VendaCabecalho.TaxaAcrescimo := 0;
                VendaCabecalho.TaxaDesconto := 0;
                Acrescimo := 0;
                Desconto := 0;
                AtualizaTotais;
              end;

            end;
          finally
            if Assigned(FDescontoAcrescimo) then
              FDescontoAcrescimo.Free;
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

//****************************************************************************//
// Procedimentos referentes ao Menu Operações e seus SubMenus                 //
//****************************************************************************//

procedure TFCaixa.listaMenuOperacoesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
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

    // carrega pre-venda
    if listaMenuOperacoes.ItemIndex = 0 then
    begin
      if StatusCaixa = 0 then
      begin
        Application.CreateForm(TFImportaNumero, FImportaNumero);
        FImportaNumero.Caption := 'Carrega Pré-Venda';
        FImportaNumero.LabelEntrada.Caption := 'Informe o número da Pré-Venda';
        try
          if (FImportaNumero.ShowModal = MROK) then
          begin
            FechaMenuOperacoes;
            CarregaPreVenda(FImportaNumero.EditEntrada.Text);
          end;
        finally
          if Assigned(FImportaNumero) then
            FImportaNumero.Free;
        end;
      end
      else
        Application.MessageBox('Já existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;

    // mesclar pre-venda
    if listaMenuOperacoes.ItemIndex = 1 then
    begin
      Application.CreateForm(TFMesclaPreVenda, FMesclaPreVenda);
      FMesclaPreVenda.ShowModal;
    end;

    // carrega dav
    if listaMenuOperacoes.ItemIndex = 2 then
    begin
      if StatusCaixa = 0 then
      begin
        Application.CreateForm(TFImportaNumero, FImportaNumero);
        FImportaNumero.Caption := 'Carrega DAV (Orçamento)';
        FImportaNumero.LabelEntrada.Caption := 'Informe o número do DAV (Orçamento)';
        try
          if (FImportaNumero.ShowModal = MROK) then
            begin
              FechaMenuOperacoes;
              CarregaDAV(FImportaNumero.EditEntrada.Text);
            end;
        finally
          if Assigned(FImportaNumero) then
            FImportaNumero.Free;
        end;
      end
      else
        Application.MessageBox('Já existe uma venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;

    // mesclar DAVs
    if listaMenuOperacoes.ItemIndex = 3 then
    begin
      Application.CreateForm(TFMesclaDAV, FMesclaDAV);
      FMesclaDAV.ShowModal;
    end;
  end;
end;

procedure TFCaixa.FechaMenuOperacoes;
begin
  panelMenuOperacoes.Visible := False;
  labelMensagens.Caption := '';
  MenuAberto := 0;
  HabilitaControlesVenda;
  editCodigo.SetFocus;
end;

procedure TFCaixa.CarregaPreVenda(Numero:String);
var
  ListaPreVenda: TObjectList<TPreVendaDetalheVO>;
  PreVendaDetalhe: TPreVendaDetalheVO;
  I:Integer;
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
      SubTotal := SubTotal + VendaDetalhe.ValorTotal;
      TotalGeral := TotalGeral + VendaDetalhe.ValorTotal;
      AtualizaTotais;
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
  I:Integer;
begin
  ListaDAV := TDAVController.CarregaDAV(StrToInt(Numero));
  if Assigned(ListaDAV) then
  begin
    IniciaVenda;
    StatusCaixa := 2;
    VendaCabecalho.IdDAV := TDAVDetalheVO(ListaDAV.Items[0]).IdDAV;
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
    end;
    Bobina.ItemIndex := Bobina.Items.Count -1;
    editCodigo.SetFocus;
    StatusCaixa := 1;
  end
  else
    Application.MessageBox('DAV inexistente ou já efetivado/mesclado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

//****************************************************************************//
// Procedimentos referentes ao Menu Fiscal e seus SubMenus                    //
//****************************************************************************//

procedure TFCaixa.listaMenuFiscalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    panelMenuFiscal.Visible := False;
    labelMensagens.Caption := '';
    MenuAberto := 0;
    HabilitaControlesVenda;
    editCodigo.SetFocus;
  end;

  if Key = VK_UP then
    MenuSetaAcima(listaMenuFiscal.ItemIndex, listaMenuFiscal);

  if Key = VK_DOWN then
    MenuSetaAbaixo(listaMenuFiscal.ItemIndex, listaMenuFiscal);

  if Key = VK_RETURN then
  begin
    // Leitura X
    if listaMenuFiscal.ItemIndex = 0 then
    begin
      if Application.MessageBox('Confirma a emissão da Leitura X?', 'Emissão de Leitura X', Mb_YesNo + Mb_IconQuestion) = IdYes then
        UECF.LeituraX;
    end;
    // LMFC
    if listaMenuFiscal.ItemIndex = 1 then
    begin
      Application.CreateForm(TFLmfc, FLmfc);
      FLmfc.ShowModal;
    end;
    // LMFS
    if listaMenuFiscal.ItemIndex = 2 then
    begin
      Application.CreateForm(TFLmfs, FLmfs);
      FLmfs.ShowModal;
    end;
    // Espelho MFD
    if listaMenuFiscal.ItemIndex = 3 then
    begin
      Application.CreateForm(TFEspelhoMfd, FEspelhoMfd);
      FEspelhoMfd.ShowModal;
    end;
    // Arquivo MFD
    if listaMenuFiscal.ItemIndex = 4 then
    begin
      Application.CreateForm(TFArquivoMfd, FArquivoMfd);
      FArquivoMfd.ShowModal;
    end;
    // Tabela de Produtos
    if listaMenuFiscal.ItemIndex = 5 then
      if Application.MessageBox('Deseja gerar o arquivo da Tabela de Produtos?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
        UPAF.GeraTabelaProdutos;
    // Estoque
    if listaMenuFiscal.ItemIndex = 6 then
      if Application.MessageBox('Deseja gerar o arquivo do Estoque?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
        UPAF.GeraArquivoEstoque;
    // Movimento ECF
    if listaMenuFiscal.ItemIndex = 7 then
    begin
      Application.CreateForm(TFMovimentoECF, FMovimentoECF);
      FMovimentoECF.ShowModal;
    end;
    // Meios de Pagamento
    if listaMenuFiscal.ItemIndex = 8 then
    begin
      Application.CreateForm(TFMeiosPagamento, FMeiosPagamento);
      FMeiosPagamento.ShowModal;
    end;
    // DAV Emitidos
    if listaMenuFiscal.ItemIndex = 9 then
    begin
      Application.CreateForm(TFDavEmitidos, FDavEmitidos);
      FDavEmitidos.ShowModal;
    end;
    // Identificacao PAF-ECF
    if listaMenuFiscal.ItemIndex = 10 then
      if Application.MessageBox('Deseja imprimir o relatório IDENTIFICAÇÃO DO PAF-ECF?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
        UPAF.IdentificacaoPafEcf;
    // Vendas no Período
    if listaMenuFiscal.ItemIndex = 11 then
    begin
      Application.CreateForm(TFVendasPeriodo, FVendasPeriodo);
      FVendasPeriodo.ShowModal;
    end;
  end;
end;

//****************************************************************************//
// Procedimentos para controle da venda                                       //
//****************************************************************************//

procedure TFCaixa.LocalizaProduto;
begin
  Application.CreateForm(TFImportaProduto, FImportaProduto);
  FImportaProduto.ShowModal;
  if StatusCaixa = 1 then
    Perform(Wm_NextDlgCtl,0,0);
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
    Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.IdentificaVendedor;
var
  Vendedor : TFuncionarioVO;
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
            Vendedor := TFuncionarioVO.Create;
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
  if Movimento.Id = 0 then
    Application.MessageBox('Não existe um movimento aberto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
  else
  begin

{    if not UPAF.ECFAutorizado then
    begin
      Application.MessageBox('ECF não autorizado - aplicação aberta apenas para consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      StatusCaixa := 3;
    end
    else if not UPAF.ConfereGT then
    begin
      Application.MessageBox('Grande total inválido - entre em contato com a Software House.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      StatusCaixa := 3;
    end
    else
    begin
}      try
        FDataModule.ACBrECF.TestaPodeAbrirCupom;
      except
        TelaPadrao;
        editCodigo.SetFocus;
      end;
      //instancia venda e detalhe
      VendaCabecalho := TVendaCabecalhoVO.Create;
      ListaVendaDetalhe := TObjectList<TVendaDetalheVO>.Create(True);

      //atribui dados do cliente abre o cupom
      if Assigned(Cliente) then
      begin
        VendaCabecalho.IdCliente := Cliente.Id;
        VendaCabecalho.NomeCliente := Cliente.Nome;
        VendaCabecalho.CPFouCNPJCliente := Cliente.CPFOuCNPJ;
        UECF.AbreCupom(Cliente.CPFOuCNPJ, Cliente.Nome);
      end
      else
        UECF.AbreCupom('','');

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
      VendaCabecalho.CCF := StrToInt(FDataModule.ACBrECF.NumCCF);

      VendaCabecalho := TVendaController.IniciaVenda(VendaCabecalho);
      editCodigo.SetFocus;
      editCodigo.SelectAll;
    //end;
  end;
end;

procedure TFCaixa.ParametrosIniciaisVenda;
begin
  Timer1.Enabled := False;
  imageProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'imgProdutos\' + 'padrao.png');
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

procedure TFCaixa.editCodigoExit(Sender: TObject);
var
  Unitario, Quantidade, Total: Extended;
begin
  if StatusCaixa <> 3 then
  begin
    if UECF.ImpressoraOK then
    begin
      if MenuAberto = 0 then
      begin
        if StatusCaixa = 0 then
          IniciaVenda;
        if editCodigo.Text <> '' then
        begin
          //pega dados do produto
          ConsultaProduto(editCodigo.Text);
          if Produto.Id <> 0 then
          begin
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
              if FileExists(ExtractFilePath(Application.ExeName) + 'imgProdutos\' + editCodigo.Text + '.jpg') then
                imageProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'imgProdutos\' + editCodigo.Text + '.jpg')
              else
                imageProduto.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'imgProdutos\' + 'padrao.png');

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
            end;
          end
          else
          begin
            Application.MessageBox('Código não encontrado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
            editUnitario.Text := '0';
            editTotalItem.Text := '0';
            editQuantidade.Text := '1';
            labelDescricaoProduto.Caption := '';
            editCodigo.SetFocus;
          end;
        end;
      end;
    end;
  end
end;

procedure TFCaixa.ConsultaProduto(Codigo:String);
begin
  Produto := TProdutoController.Consulta(Codigo);
end;

procedure TFCaixa.VendeItem;
begin
  CompoeItemParaVenda;
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
  VendaDetalhe.CST := Produto.SituacaoTributaria;
  VendaDetalhe.ECFICMS := Produto.ECFICMS;
  VendaDetalhe.TaxaICMS := Produto.AliquotaICMS;
  VendaDetalhe.TotalizadorParcial := Produto.TotalizadorParcial;
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
  Quantidade,Unitario,Total,Unidade:String;
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
begin
  VendaCabecalho.ValorVenda := SubTotal;
  VendaCabecalho.Desconto := Desconto;
  VendaCabecalho.Acrescimo := Acrescimo;

  VendaCabecalho.ValorFinal := TotalGeral - Desconto + Acrescimo;

  if Desconto >  0 then
  begin
    LabelDescontoAcrescimo.Caption := 'Desconto: R$ ' + FormatFloat('0.00',VendaCabecalho.Desconto);
    LabelDescontoAcrescimo.Font.Color := clRed;
  end
  else if Acrescimo >  0 then
  begin
    LabelDescontoAcrescimo.Caption := 'Acréscimo: R$ ' + FormatFloat('0.00',VendaCabecalho.Acrescimo);
    LabelDescontoAcrescimo.Font.Color := clBlue;
  end
  else
    LabelDescontoAcrescimo.Caption := '';

  editSubTotal.Text := FormatFloat('0.00', VendaCabecalho.ValorVenda);
  labelTotalGeral.Caption := FormatFloat('0.00', VendaCabecalho.ValorFinal);
end;

procedure TFCaixa.IniciaEncerramentoVenda;
begin
  if StatusCaixa = 1 then
  begin
    if ListaVendaDetalhe.Count > 0 then
    begin
      VendaCabecalho.CupomFoiCancelado := 'N';
      ProblemaNoPagamento := False;
      Application.CreateForm(TFEfetuaPagamento, FEfetuaPagamento);
      FEfetuaPagamento.ShowModal;
      if ProblemaNoPagamento then
        VerificaVendaComProblemas;
    end
    else
      Application.MessageBox('A venda não contém itens.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCaixa.ConcluiEncerramentoVenda;
begin
  TVendaController.EncerraVenda(VendaCabecalho);
  TelaPadrao;
end;

procedure TFCaixa.editCodigoKeyPress(Sender: TObject; var Key: Char);
var
  Quantidade: Extended;
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  End;

  If key = '*' then
  Begin
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
var
  Quantidade : Double;
begin
  Quantidade := StrToFloat(editQuantidade.Text);
  if (Quantidade <= 0) or (Quantidade > 999) then
  begin
    Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
    editQuantidade.Text := '1';
  end;
end;

procedure TFCaixa.editQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  End;
end;

procedure TFCaixa.CancelaCupom;
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
                    Application.MessageBox('Cupom cancelado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
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
end;

procedure TFCaixa.CancelaItem;
var
  cancela: Integer;
begin
  if StatusCaixa = 1 then
  begin
    Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
    try
      if (FLoginGerenteSupervisor.ShowModal = MROK) then
      begin
        if FLoginGerenteSupervisor.LoginOK then
        begin

          Application.CreateForm(TFImportaNumero, FImportaNumero);
          FImportaNumero.Caption := 'Cancela Item do Cupom';
          FImportaNumero.LabelEntrada.Caption := 'Informe o número do item:';
          try
            if (FImportaNumero.ShowModal = MROK) then
            begin
              cancela := strtoint(FImportaNumero.EditEntrada.Text);
              if cancela > 0 then
              begin
                if cancela <= ListaVendaDetalhe.Count then
                begin
                  VendaDetalhe := ListaVendaDetalhe.Items[cancela-1];

                  if VendaDetalhe.Cancelado <> 'S' then
                  begin

                    try
                      UECF.CancelaItem(cancela);
                    finally
                    end;

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
            if Assigned(FImportaNumero) then
              FImportaNumero.Free;
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
  Calculadora.Execute;
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

end.
