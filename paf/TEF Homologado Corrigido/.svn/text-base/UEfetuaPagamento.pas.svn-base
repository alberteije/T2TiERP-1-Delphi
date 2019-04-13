{*******************************************************************************
Title: T2Ti ERP
Description: Ao finalizar a venda, deve-se informar os meios de pagamento
utilizados.

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

{*******************************************************************************
  Operações TEF Discado:

	ATV		Verifica se o Gerenciador Padrão está ativo
	ADM		Permite o acionamento da Solução TEF Discado para execução das funções administrativas
	CHQ		Pedido de autorização para transação por meio de cheque
	CRT		Pedido de autorização para transação por meio de cartão
	CNC		Cancelamento de venda efetuada por qualquer meio de pagamento
	CNF		Confirmação da venda e impressão de cupom
	NCN		Não confirmação da venda e/ou da impressão.
*******************************************************************************}

unit UEfetuaPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, JvExForms, JvScrollBox, Generics.Collections, Biblioteca,
  JvExControls, JvEnterTab, DB, DBClient, UECF, ACBrTEFD, ACBrTEFDClass,
  TotalTipoPagamentoVO, TipoPagamentoVO, JvCombobox, JvExMask, JvToolEdit, Constantes,
  ACBrDevice, ACBrBase, ACBrECF, ACBrUtil, dateutils;

type
  TFEfetuaPagamento = class(TForm)
    Image1: TImage;
    JvEnterAsTab1: TJvEnterAsTab;
    CDSValores: TClientDataSet;
    DSValores: TDataSource;
    ACBrTEFD: TACBrTEFD;
    PanelEfetuaPagamento: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    JvScrollBox1: TJvScrollBox;
    GridValores: TJvDBGrid;
    botaoConfirma: TJvBitBtn;
    GroupBox2: TGroupBox;
    Bevel7: TBevel;
    Bevel6: TBevel;
    Bevel5: TBevel;
    Bevel4: TBevel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    labelDescricaoTotalVenda: TLabel;
    labelTotalVenda: TLabel;
    labelDescricaoDesconto: TLabel;
    labelDesconto: TLabel;
    labelDescricaoAcrescimo: TLabel;
    labelAcrescimo: TLabel;
    labelTotalReceber: TLabel;
    labelDescricaoTotalReceber: TLabel;
    labelTotalRecebido: TLabel;
    labelDescricaoTotalRecebido: TLabel;
    labelTroco: TLabel;
    labelDescricaoTroco: TLabel;
    labelDescricaoAindaFalta: TLabel;
    labelAindaFalta: TLabel;
    GroupBox3: TGroupBox;
    ComboTipoPagamento: TComboBox;
    EditValorPago: TJvValidateEdit;
    BotaoCancela: TJvBitBtn;
    PanelConfirmaValores: TPanel;
    LabelConfirmaValores: TLabel;
    botaoNao: TBitBtn;
    botaoSim: TBitBtn;
    procedure FechamentoRapido;
    procedure TelaPadrao;
    procedure FechaVendaComProblemas;
    procedure OrdenaLista;
    procedure GravaR06;
    procedure SubTotalizaCupom;
    procedure FormActivate(Sender: TObject);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoSimClick(Sender: TObject);
    procedure botaoNaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditValorPagoExit(Sender: TObject);
    procedure VerificaSaldoRestante;
    procedure FinalizaVenda;
    procedure AtualizaLabelsValores;
    procedure CancelaOperacao;
    procedure BotaoCancelaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GridValoresKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure ACBrTEFDAguardaResp(Arquivo: string; SegundosTimeOut: Integer;  var Interromper: Boolean);
    procedure ACBrTEFDAntesCancelarTransacao(RespostaPendente: TACBrTEFDResp);
    procedure ACBrTEFDAntesFinalizarRequisicao(Req: TACBrTEFDReq);
    procedure ACBrTEFDBloqueiaMouseTeclado(Bloqueia: Boolean; var Tratado: Boolean);
    procedure ACBrTEFDComandaECF(Operacao: TACBrTEFDOperacaoECF;  Resp: TACBrTEFDResp; var RetornoECF: Integer);
    procedure ACBrTEFDComandaECFAbreVinculado(COO, IndiceECF: string; Valor: Double; var RetornoECF: Integer);
    procedure ACBrTEFDComandaECFImprimeVia(TipoRelatorio: TACBrTEFDTipoRelatorio; Via: Integer; ImagemComprovante: TStringList; var RetornoECF: Integer);
    procedure ACBrTEFDComandaECFPagamento(IndiceECF: string; Valor: Double; var RetornoECF: Integer);
    procedure ACBrTEFDExibeMsg(Operacao: TACBrTEFDOperacaoMensagem; Mensagem: string; var AModalResult: TModalResult);
    procedure ACBrTEFDInfoECF(Operacao: TACBrTEFDInfoECF; var RetornoECF: string);
    procedure ACBrTEFDRestauraFocoAplicacao(var Tratado: Boolean);
  private
    { Private declarations }
  public
    IdVenda: Integer;
    { Public declarations }
  end;

var
  FEfetuaPagamento: TFEfetuaPagamento;
  ListaTipoPagamento: TObjectList<TTipoPagamentoVO>;
  ListaTotalTipoPagamento: TObjectList<TTotalTipoPagamentoVO>;
  SaldoRestante, TotalVenda, Desconto, Acrescimo, TotalReceber, TotalRecebido, ValorDinheiro, Troco: Extended;
  TransacaoComTef, ImpressaoOK, CupomCancelado, PodeFechar, StatusTransacao, SegundoCartaoCancelado: Boolean;
  TransacaoConsultaCheque: boolean;
  IndiceTransacaoTef, QuantidadeCartao: Integer;

implementation

uses UDataModule, TipoPagamentoController, UCaixa,  TotalTipoPagamentoController,
     R06VO, RegistroRController, TypInfo;

{$R *.dfm}

procedure TFEfetuaPagamento.FormActivate(Sender: TObject);
begin
  TotalVenda := 0;
  Desconto := 0;
  Acrescimo := 0;
  TotalReceber := 0;
  TotalRecebido := 0;
  ValorDinheiro := 0;
  Troco := 0;
  QuantidadeCartao := 0;

  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);

  if UCaixa.VendaCabecalho.TaxaAcrescimo > 0 then
    UCaixa.VendaCabecalho.Acrescimo := TruncaValor(UCaixa.VendaCabecalho.TaxaAcrescimo/100*UCaixa.VendaCabecalho.ValorVenda,Constantes.TConstantes.DECIMAIS_VALOR);
  if UCaixa.VendaCabecalho.TaxaDesconto > 0 then
    UCaixa.VendaCabecalho.Desconto := TruncaValor(UCaixa.VendaCabecalho.TaxaDesconto/100*UCaixa.VendaCabecalho.ValorVenda,Constantes.TConstantes.DECIMAIS_VALOR);

  //preenche valores nas variaveis
  TotalVenda := UCaixa.VendaCabecalho.ValorVenda;
  Acrescimo := UCaixa.VendaCabecalho.Acrescimo;
  Desconto := UCaixa.VendaCabecalho.Desconto;
  TotalReceber := TruncaValor(TotalVenda + Acrescimo - Desconto,Constantes.TConstantes.DECIMAIS_VALOR);
  SaldoRestante := TotalReceber;

  SegundoCartaoCancelado := False;
  TransacaoComTef := False;
  TransacaoConsultaCheque := false;
  CupomCancelado := False;
  PodeFechar := True;
  IndiceTransacaoTef := -1;

  AtualizaLabelsValores;
  EditValorPago.Text := FormatFloat('0.00',SaldoRestante);

  IdVenda := UCaixa.VendaCabecalho.Id;
  ComboTipoPagamento.SetFocus;

  //lista que vai acumular os meios de pagamento
  ListaTotalTipoPagamento := TObjectList<TTotalTipoPagamentoVO>.Create(True);

  //tela padrão
  TelaPadrao;
end;

procedure TFEfetuaPagamento.AtualizaLabelsValores;
begin
  labelTotalVenda.Caption := FormatFloat('#,###,###,##0.00', TotalVenda);
  labelAcrescimo.Caption := FormatFloat('#,###,###,##0.00', Acrescimo);
  labelDesconto.Caption := FormatFloat('#,###,###,##0.00', Desconto);
  labelTotalReceber.Caption :=  FormatFloat('#,###,###,##0.00', TotalReceber);
  labelTotalRecebido.Caption :=  FormatFloat('#,###,###,##0.00', TotalRecebido);
  if SaldoRestante > 0 then
    labelAindaFalta.Caption :=  FormatFloat('#,###,###,##0.00', SaldoRestante)
  else
    labelAindaFalta.Caption :=  FormatFloat('#,###,###,##0.00', 0);
  labelTroco.Caption :=  FormatFloat('#,###,###,##0.00', Troco);
end;

procedure TFEfetuaPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CDSValores.Close;
  Action := caFree;
end;

procedure TFEfetuaPagamento.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := PodeFechar;
end;

procedure TFEfetuaPagamento.TelaPadrao;
var
  i: Integer;
begin
  ListaTipoPagamento := TTipoPagamentoController.TabelaTipoPagamento;
  for i := 0 to ListaTipoPagamento.Count - 1 do
    ComboTipoPagamento.Items.Add(TTipoPagamentoVO(ListaTipoPagamento.Items[i]).Descricao);
  ComboTipoPagamento.ItemIndex := 0;

  //configura ClientDataset
  CDSValores.Close;
  CDSValores.FieldDefs.Clear;

  CDSValores.FieldDefs.add('DESCRICAO', ftString, 20);
  CDSValores.FieldDefs.add('VALOR', ftFloat);
  CDSValores.FieldDefs.add('ID', ftInteger);
  //os campos abaixo serão utilizados caso seja necessario cancelar uma transacao TEF
  CDSValores.FieldDefs.add('TEF', ftString, 1);
  CDSValores.FieldDefs.add('NSU', ftString, 50);
  CDSValores.FieldDefs.add('REDE', ftString, 50);
  CDSValores.FieldDefs.add('DATA_HORA_TRANSACAO', ftString, 50);
  CDSValores.FieldDefs.add('INDICE_TRANSACAO', ftInteger);
  CDSValores.FieldDefs.add('INDICE_LISTA', ftInteger);
  CDSValores.FieldDefs.add('FINALIZACAO', ftString, 30);
  CDSValores.CreateDataSet;
  TFloatField(CDSValores.FieldByName('VALOR')).displayFormat:='#,###,###,##0.00';
  //definimos os cabeçalhos da Grid
  GridValores.Columns[0].Title.Caption := 'Descrição';
  GridValores.Columns[0].Width := 130;
  GridValores.Columns[1].Title.Caption := 'Valor';
  //nao exibe as colunas abaixo
  GridValores.Columns.Items[2].Visible := False;
  GridValores.Columns.Items[3].Visible := False;
  GridValores.Columns.Items[4].Visible := False;
  GridValores.Columns.Items[5].Visible := False;
  GridValores.Columns.Items[6].Visible := False;
  GridValores.Columns.Items[7].Visible := False;
  GridValores.Columns.Items[8].Visible := False;
  GridValores.Columns.Items[9].Visible := False;
end;

procedure TFEfetuaPagamento.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if key = 113 then
  begin
    if CDSValores.RecordCount = 0 then
    begin
      if Application.MessageBox('Confirma valores e encerra venda por fechamento rápido?', 'Finalizar venda', Mb_YesNo + Mb_IconQuestion) = IdYes then
      begin
        FechamentoRapido;
      end;
    end
    else
    begin
      Application.MessageBox('Já existem valores informados. Impossível utilizar Fechamento Rápido.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      ComboTipoPagamento.SetFocus;
    end;
  end;

  if key = 123 then
    botaoConfirma.Click;

  if key = 27 then
    BotaoCancela.Click;

  if key = 116 then
  begin
    if CDSValores.RecordCount > 0 then
      GridValores.SetFocus
    else
    begin
      Application.MessageBox('Não existem valores informados para serem removidos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      ComboTipoPagamento.SetFocus;
    end;
  end;
end;

procedure TFEfetuaPagamento.FechamentoRapido;
begin
  StatusTransacao := True;
  botaoSim.Click;
end;

//controle das teclas digitadas na Grid
procedure TFEfetuaPagamento.GridValoresKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_DELETE then
  begin
    if CDSValores.FieldByName('TEF').AsString = 'S' then
      Application.MessageBox('Operação não permitida.', 'Informação do Sistema', Mb_OK + MB_ICONINFORMATION)
    else
    begin
      if Application.MessageBox('Deseja remover o valor selecionado?', 'Remover ', Mb_YesNo + Mb_IconQuestion) = IdYes then
      begin
        TotalRecebido := TruncaValor(TotalRecebido - CDSValores.FieldByName('VALOR').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        Troco := TruncaValor(TotalRecebido - TotalReceber,Constantes.TConstantes.DECIMAIS_VALOR);
        if Troco < 0 then
          Troco := 0;

        ListaTotalTipoPagamento.Delete(CDSValores.FieldByName('INDICE_LISTA').AsInteger);

        CDSValores.Delete;
        VerificaSaldoRestante;
        EditValorPago.Text := FormatFloat('0.00',SaldoRestante);
      end;
      ComboTipoPagamento.SetFocus;
    end;
  end;

  if key = 13 then
    ComboTipoPagamento.SetFocus;
end;

procedure TFEfetuaPagamento.BotaoCancelaClick(Sender: TObject);
begin
  CancelaOperacao;
end;

procedure TFEfetuaPagamento.botaoConfirmaClick(Sender: TObject);
begin
  VerificaSaldoRestante;
  //se não houver mais saldo no ECF é porque já devemos finalizar a venda
  if SaldoRestante <= 0 then
  begin
    if Application.MessageBox('Deseja finalizar a venda?', 'Finalizar venda', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      FinalizaVenda;
    end
    else
    begin
      if TransacaoComTef then
      begin
        ACBrTEFD.CancelarTransacoesPendentes;
        UCaixa.ProblemaNoPagamento := True;
        UCaixa.VendaCabecalho.CupomFoiCancelado := 'S';
        UCaixa.StatusCaixa := 0;
        FechaVendaComProblemas;
        PodeFechar := True;
        Close;
      end;
    end;
  end
  else
  begin
    Application.MessageBox('Valores informados não são suficientes para finalizar a venda.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    ComboTipoPagamento.SetFocus;
  end;
end;

procedure TFEfetuaPagamento.EditValorPagoExit(Sender: TObject);
begin
  if EditValorPago.Value > 0 then
  begin
    VerificaSaldoRestante;
    //se ainda tem saldo no ECF para pagamento
    if SaldoRestante > 0 then
    begin
      PanelConfirmaValores.Visible := True;
      PanelConfirmaValores.BringToFront;
      LabelConfirmaValores.Caption := 'Confirma forma de pagamento e valor?';
      BotaoSim.SetFocus;
    end
    else
      Application.MessageBox('Todos os valores já foram recebidos. Finalize a venda.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
  begin
    Application.MessageBox('Valor não pode ser menor ou igual a zero.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    ComboTipoPagamento.SetFocus;
  end;
end;

procedure TFEfetuaPagamento.VerificaSaldoRestante;
var
  RecebidoAteAgora: Extended;
begin
  RecebidoAteAgora := 0;

  CDSValores.DisableControls;
  CDSValores.First;
  while Not CDSValores.Eof do
  begin
    RecebidoAteAgora := TruncaValor(RecebidoAteAgora + CDSValores.FieldByName('VALOR').AsFloat, Constantes.TConstantes.DECIMAIS_VALOR);
    CDSValores.Next;
  end;
  CDSValores.EnableControls;

  SaldoRestante := TruncaValor(TotalReceber - RecebidoAteAgora, Constantes.TConstantes.DECIMAIS_VALOR);

  AtualizaLabelsValores;
end;

procedure TFEfetuaPagamento.botaoNaoClick(Sender: TObject);
var
  i:integer;
begin
  PanelConfirmaValores.Visible := False;
  ComboTipoPagamento.SetFocus;
end;

procedure TFEfetuaPagamento.botaoSimClick(Sender: TObject);
Var
  TipoPagamento : TTipoPagamentoVO;
  TotalTipoPagamento: TTotalTipoPagamentoVO;
  TotalTipoPagamentoControl: TTotalTipoPagamentoController;
  ValorInformado: Extended;
  Mensagem: String;
  transacaoAtualCheque, transacaoAtualCRT: boolean;
begin
  TipoPagamento := TTipoPagamentoVO(ListaTipoPagamento.Items[ComboTipoPagamento.ItemIndex]);
  ValorInformado := TruncaValor(EditValorPago.Value,Constantes.TConstantes.DECIMAIS_VALOR);

  if (TipoPagamento.Descricao = 'CONSULTA CHEQUE') or (TipoPagamento.Descricao = 'CONSULTA CHQ TECBAN') then
    begin
      transacaoAtualCheque := true;
      transacaoAtualCRT := false;
    end
  else if (TipoPagamento.TEF = 'S' ) then
    begin
      transacaoAtualCheque := false;
      transacaoAtualCRT := true;
    end;

  if (TransacaoConsultaCheque and transacaoAtualCRT) or (TransacaoComTef and transacaoAtualCheque) then
  begin
    Application.MessageBox('Compra com Cartão e Cheque não permitida.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    ComboTipoPagamento.SetFocus;
    PanelConfirmaValores.Visible := False;
    PanelConfirmaValores.SendToBack;
  end
  else
  begin
    TotalTipoPagamento := TTotalTipoPagamentoVO.Create;

    if ((TransacaoComTef) or (TipoPagamento.TEF = 'S')) and (ValorInformado > SaldoRestante) then
    begin
      Application.MessageBox('Compra não permite troco.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      ComboTipoPagamento.SetFocus;
      PanelConfirmaValores.Visible := False;
      PanelConfirmaValores.SendToBack;
    end
    else if (TipoPagamento.TEF = 'S') and (QuantidadeCartao >= UCaixa.Configuracao.QuantidadeMaximaCartoes) then
    begin
      Application.MessageBox('Já foi utilizada a quantidade máxima de cartões para efetuar pagamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      ComboTipoPagamento.SetFocus;
      PanelConfirmaValores.Visible := False;
      PanelConfirmaValores.SendToBack;
    end
    else if (TipoPagamento.TEF = 'S') and (QuantidadeCartao >= UCaixa.Configuracao.QuantidadeMaximaCartoes-1) and (ValorInformado <> SaldoRestante) then
    begin
      Mensagem := 'Múltiplos Cartões. Transação suporta até ' + IntToStr(UCaixa.Configuracao.QuantidadeMaximaCartoes) + ' cartões.'#$D#$A' Informe o valor exato para fechar a venda.';
      Application.MessageBox(PChar(Mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      ComboTipoPagamento.SetFocus;
      PanelConfirmaValores.Visible := False;
      PanelConfirmaValores.SendToBack;
    end
    else
    begin
      GroupBox3.Enabled := False;
      StatusTransacao := True;
      if TipoPagamento.TEF = 'S' then
      begin
        PanelEfetuaPagamento.Enabled := False;
        try
          try
            ACBrTEFD.Inicializar(TACBrTEFDTipo(StrToInt(TipoPagamento.TipoGP)));
          except
            Application.MessageBox('GP para tipo de pagamento solicitado não instalado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
            StatusTransacao := False;
          end;
          if (transacaoAtualCheque) then
            StatusTransacao := ACBrTEFD.CHQ(ValorInformado, TipoPagamento.Codigo, FDataModule.ACBrECF.NumCOO)
          else
            StatusTransacao := ACBrTEFD.CRT(ValorInformado, TipoPagamento.Codigo, FDataModule.ACBrECF.NumCOO);

          if StatusTransacao then
          begin
            Inc(IndiceTransacaoTef);
            TotalTipoPagamento.NSU := ACBrTEFD.RespostasPendentes[IndiceTransacaoTef].NSU;
            TotalTipoPagamento.Rede := ACBrTEFD.RespostasPendentes[IndiceTransacaoTef].Rede;
            TotalTipoPagamento.DataHoraTransacao := DateTimeToStr(ACBrTEFD.RespostasPendentes[IndiceTransacaoTef].DataHoraTransacaoHost);
            TotalTipoPagamento.Finalizacao := ACBrTEFD.RespostasPendentes[IndiceTransacaoTef].Finalizacao;

            if (ACBrTEFD.RespostasPendentes[IndiceTransacaoTef].TipoTransacao >= 10)
              and (ACBrTEFD.RespostasPendentes[IndiceTransacaoTef].TipoTransacao <= 12) then
                TotalTipoPagamento.CartaoDebitoOuCredito := 'C';
            if (ACBrTEFD.RespostasPendentes[IndiceTransacaoTef].TipoTransacao >= 20)
              and (ACBrTEFD.RespostasPendentes[IndiceTransacaoTef].TipoTransacao <= 25) then
                TotalTipoPagamento.CartaoDebitoOuCredito := 'D';

            Inc(QuantidadeCartao);
            TransacaoComTef := True;

            if(transacaoAtualCheque)then
            begin
              TransacaoConsultaCheque := true;
            end;

            PodeFechar := False;
          end;
        except
        end;
        PanelEfetuaPagamento.Enabled := True;
      end;

      if StatusTransacao then
      begin

        CDSValores.Append;
        CDSValores.Fields[0].AsString := ComboTipoPagamento.Text;
        CDSValores.Fields[1].AsString := EditValorPago.Text;
        if TipoPagamento.TEF = 'S' then
        begin
          CDSValores.Fields[3].AsString := 'S';
          CDSValores.Fields[4].AsString := TotalTipoPagamento.NSU;
          CDSValores.Fields[5].AsString := TotalTipoPagamento.Rede;
          CDSValores.Fields[6].AsString := TotalTipoPagamento.DataHoraTransacao;
          CDSValores.Fields[7].AsInteger := IndiceTransacaoTef;
          CDSValores.Fields[9].AsString := TotalTipoPagamento.Finalizacao;
        end;
        CDSValores.Post;

        TotalRecebido := TruncaValor(TotalRecebido + StrToFloat(EditValorPago.Value),Constantes.TConstantes.DECIMAIS_VALOR);
        Troco := TruncaValor(TotalRecebido - TotalReceber,Constantes.TConstantes.DECIMAIS_VALOR);
        if Troco < 0 then
          Troco := 0;
        VerificaSaldoRestante;

        TotalTipoPagamento.IdVenda := IdVenda;
        TotalTipoPagamento.IdTipoPagamento := TipoPagamento.Id;
        TotalTipoPagamento.Valor := TruncaValor(StrToFloat(EditValorPago.Text),Constantes.TConstantes.DECIMAIS_VALOR);
        TotalTipoPagamento.CodigoPagamento := TipoPagamento.Codigo;
        TotalTipoPagamento.Estorno := 'N';
        TotalTipoPagamento.TemTEF := TipoPagamento.TEF;

        ListaTotalTipoPagamento.Add(TotalTipoPagamento);

        //guarda o índice da lista
        CDSValores.Edit;
        CDSValores.Fields[8].AsInteger := ListaTotalTipoPagamento.Count-1;
        CDSValores.Post;
      end;
      PanelConfirmaValores.Visible := False;
      PanelConfirmaValores.SendToBack;
      EditValorPago.Text := FormatFloat('0.00',SaldoRestante);
      GroupBox3.Enabled := True;
      ComboTipoPagamento.SetFocus;
    end;

    VerificaSaldoRestante;
    if SaldoRestante <= 0 then
      FinalizaVenda;

    if SegundoCartaoCancelado then
    begin
      Application.MessageBox('Cupom fiscal cancelado. Será aberto novo cupom e deve-se informar novamente os pagamentos.', 'Informação do Sistema', Mb_OK + MB_ICONINFORMATION);
      UCaixa.ProblemaNoPagamento := True;
      UCaixa.VendaCabecalho.CupomFoiCancelado := 'S';
      UCaixa.StatusCaixa := 0;
      FechaVendaComProblemas;
      PodeFechar := True;
      Close;
    end;
  end;
end;

procedure TFEfetuaPagamento.FinalizaVenda;
var
  i:Integer;
  TotalTipoPagamento:TTotalTipoPagamentoVO;
begin
  ImpressaoOK := True;

  //subtotaliza o cupom
  SubTotalizaCupom;

  //manda os pagamentos para o ECF
  if TransacaoComTef then
    OrdenaLista;

  TotalTipoPagamento := TTotalTipoPagamentoVO.Create;
  for i := 0 to ListaTotalTipoPagamento.Count - 1 do
  begin
    TotalTipoPagamento := ListaTotalTipoPagamento.Items[i];
    if TotalTipoPagamento.TemTEF <> 'S' then
      FDataModule.ACBrECF.EfetuaPagamento(TotalTipoPagamento.CodigoPagamento, TotalTipoPagamento.Valor);
  end;

  BlockInput(True);

  //finaliza o cupom
  ACBrTEFD.FinalizarCupom;

  //imprime as transacoes pendentes - comprovantes nao fiscais vinculados
  ACBrTEFD.ImprimirTransacoesPendentes;

  BlockInput(False);

  if ImpressaoOK then
  begin
    //grava os pagamentos no banco de dados
    TTotalTipoPagamentoController.GravaTotaisVenda(ListaTotalTipoPagamento);

    //conclui o encerramento da venda - grava dados de cabecalho no banco
    UCaixa.VendaCabecalho.ValorFinal := TotalReceber;
    UCaixa.VendaCabecalho.ValorRecebido := TotalRecebido;
    UCaixa.VendaCabecalho.Troco := Troco;
    UCaixa.VendaCabecalho.StatusVenda := 'F';
    UCaixa.StatusCaixa := 0;
    FCaixa.ConcluiEncerramentoVenda;

    FDataModule.ACBrECF.AbreGaveta;

    PodeFechar := True;
    Close;
  end
  else
  begin
    if CupomCancelado then
    {
      ocorreu problema na impressao do comprovante do TEF. ECF Desligado.
      Sistema pergunta ao usuário se o mesmo quer tentar novamente. Usuário responde Não.
      ECF agora está ligado e o sistema consegue cancelar o cupom.
    }
    begin
      Application.MessageBox('Problemas no ECF. Cupom Fiscal Cancelado.', 'Informação do Sistema', Mb_OK + MB_ICONINFORMATION);
      UCaixa.ProblemaNoPagamento := True;
      UCaixa.VendaCabecalho.CupomFoiCancelado := 'S';
      UCaixa.StatusCaixa := 0;
      FechaVendaComProblemas;
      PodeFechar := True;
      Close;
    end
    else

    {
      ocorreu problema na impressao do comprovante do TEF. ECF Desligado.
      Sistema pergunta ao usuário se o mesmo quer tentar novamente. Usuário responde Não.
      ECF continua desligado e o sistema não consegue cancelar o cupom.
    }
    begin
      Application.MessageBox('Problemas no ECF. Aplicação funcionará apenas para consulta.', 'Informação do Sistema', Mb_OK + MB_ICONINFORMATION);
      UCaixa.StatusCaixa := 3;
      FechaVendaComProblemas;
      PodeFechar := True;
      Close;
    end;
  end;
end;

procedure TFEfetuaPagamento.FechaVendaComProblemas;
var
  i:Integer;
begin
  //altera o status da venda para C
  UCaixa.VendaCabecalho.StatusVenda := 'C';
  FCaixa.ConcluiEncerramentoVenda;

  //grava os pagamentos no banco de dados com o indicador de estorno
  for i := 0 to ListaTotalTipoPagamento.Count - 1 do
    TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Estorno := 'S';
  TTotalTipoPagamentoController.GravaTotaisVenda(ListaTotalTipoPagamento);
end;

procedure TFEfetuaPagamento.CancelaOperacao;
begin
  if TransacaoComTef then
  begin
    if Application.MessageBox('Existem pagamentos no cartão. O cupom fiscal será cancelado. Deseja continuar?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      ACBrTEFD.CancelarTransacoesPendentes;
      if CupomCancelado then
      begin
        UCaixa.ProblemaNoPagamento := True;
        UCaixa.VendaCabecalho.CupomFoiCancelado := 'S';
        UCaixa.StatusCaixa := 0;
        FechaVendaComProblemas;
        Application.MessageBox('Transação com cartão cancelada. Cupom Fiscal Cancelado.', 'Informação do Sistema', Mb_OK + MB_ICONINFORMATION);
      end
      else
      begin
        UCaixa.StatusCaixa := 3;
        FechaVendaComProblemas;
        Application.MessageBox('Problemas no ECF. Aplicação funcionará apenas para consulta.', 'Informação do Sistema', Mb_OK + MB_ICONINFORMATION);
      end;
      PodeFechar := True;
      Close;
    end;
  end
  else
    Close;
end;

procedure TFEfetuaPagamento.SubTotalizaCupom;
begin
  try
    if VendaCabecalho.Desconto > 0 then
      UECF.SubTotalizaCupom(VendaCabecalho.Desconto * -1)
    else if VendaCabecalho.Acrescimo > 0 then
      UECF.SubTotalizaCupom(VendaCabecalho.Acrescimo)
    else
      UECF.SubTotalizaCupom(0);
  except
    if Application.MessageBox('Impressora não responde, tentar novamente?', 'Informação do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      SubTotalizaCupom;
    end
    else
      raise
  end;
end;

procedure TFEfetuaPagamento.GravaR06;
var
  R06: TR06VO;
begin
  R06 := TR06VO.Create;
  R06.IdCaixa := UCaixa.Movimento.IdCaixa;
  R06.IdOperador := UCaixa.Movimento.IdOperador;
  R06.IdImpressora := UCaixa.Movimento.IdImpressora;
  R06.COO := StrToInt(FDataModule.ACBrECF.NumCOO);
  R06.GNF := StrToInt(FDataModule.ACBrECF.NumGNF);
  R06.CDC := StrToInt(FDataModule.ACBrECF.NumCDC);
  R06.Denominacao := 'CC';
  R06.DataEmissao := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
  R06.HoraEmissao := FormatDateTime('hh:nn:ss', FDataModule.ACBrECF.DataHora);
  TRegistroRController.GravaR06(R06);
end;

//pode ser muito melhorado
//verificar o método Sort de Generics.Collections juntamente com utilização de TComparer
procedure TFEfetuaPagamento.OrdenaLista;
var
  i:Integer;
  ListaTotalTipoPagamentoLocal: TObjectList<TTotalTipoPagamentoVO>;
begin
  ListaTotalTipoPagamentoLocal := ListaTotalTipoPagamento;
  ListaTotalTipoPagamento := TObjectList<TTotalTipoPagamentoVO>.Create(True);

  //no primeiro laço insere na lista só quem nao tem TEF
  for i := 0 to ListaTotalTipoPagamentoLocal.Count - 1 do
  begin
    if TTotalTipoPagamentoVO(ListaTotalTipoPagamentoLocal.Items[i]).TemTEF = 'N' then
      ListaTotalTipoPagamento.Add(TTotalTipoPagamentoVO(ListaTotalTipoPagamentoLocal.Items[i]));
  end;

  //no segundo laço insere os pagamentos que tem tef
  for i := 0 to ListaTotalTipoPagamentoLocal.Count - 1 do
    if TTotalTipoPagamentoVO(ListaTotalTipoPagamentoLocal.Items[i]).TemTEF = 'S' then
      ListaTotalTipoPagamento.Add(TTotalTipoPagamentoVO(ListaTotalTipoPagamentoLocal.Items[i]));
end;




////////////////////////////////////////////////////////////////////////////////
///  Métodos do Componente ACBrTEFD
////////////////////////////////////////////////////////////////////////////////

procedure TFEfetuaPagamento.ACBrTEFDAguardaResp(Arquivo: string; SegundosTimeOut: Integer; var Interromper: Boolean);
var
  Msg : String ;
begin
  Msg := '' ;
  if (ACBrTEFD.GPAtual in [gpCliSiTef, gpVeSPague]) then //É TEF dedicado?
  begin
    if Arquivo = '23' then  //Está aguardando Pin-Pad ?
    begin
      if ACBrTEFD.TecladoBloqueado then
      begin
        ACBrTEFD.BloquearMouseTeclado(False);  //Desbloqueia o Teclado
      end ;
      Msg := 'Tecle "ESC" para cancelar.';
     end;
   end
  else
     Msg := 'Aguardando: '+Arquivo+' '+IntToStr(SegundosTimeOut) ;

  if Msg <> '' then
     FCaixa.labelMensagens.Caption := Msg;
  Application.ProcessMessages;
end;

procedure TFEfetuaPagamento.ACBrTEFDAntesCancelarTransacao(RespostaPendente: TACBrTEFDResp);
var
   Est: TACBrECFEstado;
begin
  Est := FDataModule.ACBrECF.Estado;
  case Est of
    estVenda, estPagamento :
    begin
      UECF.CancelaCupom;
      CupomCancelado := True;
    end;
    estRelatorio: FDataModule.ACBrECF.FechaRelatorio;
  else
  if not (Est in [estLivre, estDesconhecido, estNaoInicializada] ) then
    FDataModule.ACBrECF.CorrigeEstadoErro(False);
  end;
end;

procedure TFEfetuaPagamento.ACBrTEFDAntesFinalizarRequisicao(Req: TACBrTEFDReq);
begin
  if Req.Header = 'CRT' then
    Req.GravaInformacao(777,777,'REDECARD');
end;

procedure TFEfetuaPagamento.ACBrTEFDBloqueiaMouseTeclado(Bloqueia: Boolean; var Tratado: Boolean);
begin
  FCaixa.Enabled := not Bloqueia;
  Tratado := False ;  { Se "False" --> Deixa executar o código de Bloqueio do ACBrTEFD }
end;

procedure TFEfetuaPagamento.ACBrTEFDComandaECF(Operacao: TACBrTEFDOperacaoECF; Resp: TACBrTEFDResp; var RetornoECF: Integer);
var
  Mensagem: String;
begin
  Mensagem := '';

  try
    case Operacao of
      opeAbreGerencial:
        FDataModule.ACBrECF.AbreRelatorioGerencial ;

      opeCancelaCupom:
        begin
          ImpressaoOK := False;
          try
            UECF.CancelaCupom;
            CupomCancelado := True;
          except
            CupomCancelado := False;
          end;
        end;

      opeFechaCupom:
        begin
          if UCaixa.VendaCabecalho.IdPreVenda > 0 then
            Mensagem := 'PV' + StringOfChar('0',10-Length(IntToStr(UCaixa.VendaCabecalho.IdPreVenda))) + IntToStr(UCaixa.VendaCabecalho.IdPreVenda);
          if UCaixa.VendaCabecalho.IdDAV > 0 then
            Mensagem := Mensagem + 'DAV' + StringOfChar('0',10-Length(IntToStr(UCaixa.VendaCabecalho.IdDAV))) + IntToStr(UCaixa.VendaCabecalho.IdDAV);
          Mensagem := Mensagem + #13 + #10 + UCaixa.MD5 + #13 + #10;
          UECF.FechaCupom(Mensagem + UCaixa.Configuracao.MensagemCupom);
        end;

      opeSubTotalizaCupom:
        FDataModule.ACBrECF.SubtotalizaCupom(0);

      opeFechaGerencial, opeFechaVinculado:
        begin
          FDataModule.ACBrECF.FechaRelatorio;
          GravaR06;
        end;

      opePulaLinhas:
        begin
          FDataModule.ACBrECF.PulaLinhas(FDataModule.ACBrECF.LinhasEntreCupons);
          FDataModule.ACBrECF.CortaPapel(True);
          Sleep(200);
        end;
    end;

    RetornoECF := 1 ;
  except
    RetornoECF := 0 ;
  end;
end;

procedure TFEfetuaPagamento.ACBrTEFDComandaECFAbreVinculado(COO, IndiceECF: string; Valor: Double; var RetornoECF: Integer);
begin
  try
    FDataModule.ACBrECF.AbreCupomVinculado(COO, IndiceECF, Valor);
    RetornoECF := 1 ;
  except
    RetornoECF := 0 ;
  end;
end;

procedure TFEfetuaPagamento.ACBrTEFDComandaECFImprimeVia(TipoRelatorio: TACBrTEFDTipoRelatorio; Via: Integer;ImagemComprovante: TStringList; var RetornoECF: Integer);
begin
  { *** Se estiver usando ACBrECF... Lembre-se de configurar ***
    ACBrECF1.MaxLinhasBuffer   := 3; // Os homologadores permitem no máximo
                                     // Impressao de 3 em 3 linhas
    ACBrECF1.LinhasEntreCupons := 7; // (ajuste conforme o seu ECF)
    NOTA: ACBrECF nao possui comando para imprimir a 2a via do CCD }
  try
    case TipoRelatorio of
     trGerencial :
       FDataModule.ACBrECF.LinhaRelatorioGerencial(ImagemComprovante.Text) ;
     trVinculado :
       FDataModule.ACBrECF.LinhaCupomVinculado(ImagemComprovante.Text)
    end;

    RetornoECF := 1 ;
  except
    RetornoECF := 0 ;
  end;
end;

procedure TFEfetuaPagamento.ACBrTEFDComandaECFPagamento(IndiceECF: string; Valor: Double; var RetornoECF: Integer);
begin
  try
    FDataModule.ACBrECF.EfetuaPagamento(IndiceECF, Valor);
    RetornoECF := 1 ;
  except
    RetornoECF := 0 ;
  end;
end;

procedure TFEfetuaPagamento.ACBrTEFDExibeMsg(Operacao: TACBrTEFDOperacaoMensagem; Mensagem: string; var AModalResult: TModalResult);
var
  Fim : TDateTime;
  OldMensagem : String;
begin
  case Operacao of
    opmOK :
      AModalResult := Application.MessageBox(PChar(Mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);

    opmYesNo :
    begin
      if not FDataModule.ACBrECF.Ativo then
      begin
        FDataModule.ACBrECF.Modelo := TACBrECFModelo(GetEnumValue(TypeInfo(TACBrECFModelo), UCaixa.Configuracao.ModeloImpressora));
        FDataModule.ACBrECF.Porta := UCaixa.Configuracao.PortaECF;
        FDataModule.ACBrECF.TimeOut := UCaixa.Configuracao.TimeOutECF;
        FDataModule.ACBrECF.IntervaloAposComando := UCaixa.Configuracao.IntervaloECF;
        FDataModule.ACBrECF.Device.Baud := UCaixa.Configuracao.BitsPorSegundo;
        try
          FDataModule.ACBrECF.Ativar;
        except
        end;
        FDataModule.ACBrECF.CarregaAliquotas;
        FDataModule.ACBrECF.CarregaFormasPagamento;
      end;
      AModalResult := Application.MessageBox(PChar(Mensagem), 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion);
    end;

    opmExibirMsgOperador, opmRemoverMsgOperador :
      FCaixa.labelMensagens.Caption := Mensagem;

    opmExibirMsgCliente, opmRemoverMsgCliente :
      FCaixa.labelMensagens.Caption := Mensagem;

    opmDestaqueVia :
      begin
        OldMensagem := FCaixa.labelMensagens.Caption;
        try
          FCaixa.labelMensagens.Caption := Mensagem ;

          { Aguardando 3 segundos }
          Fim := IncSecond( now, 3)  ;
          repeat
            sleep(200) ;
            FCaixa.labelMensagens.Caption := Mensagem + ' ' + IntToStr(SecondsBetween(Fim,now));
            Application.ProcessMessages;
          until (now > Fim) ;

         finally
           FCaixa.labelMensagens.Caption := OldMensagem ;
         end;
       end;
  end;

  if (AModalResult = 7) and (Mensagem = 'Gostaria de continuar a transação com outra(s) forma(s) de pagamento ?') then
  begin
    SegundoCartaoCancelado := True;
  end;

  Application.ProcessMessages;
end;


procedure TFEfetuaPagamento.ACBrTEFDInfoECF(Operacao: TACBrTEFDInfoECF; var RetornoECF: string);
begin
  case Operacao of
    ineSubTotal:
      RetornoECF := FormatFloat('0.00',FDataModule.ACBrECF.Subtotal-FDataModule.ACBrECF.TotalPago);

    ineEstadoECF :
      begin
        Case FDataModule.ACBrECF.Estado of
          estLivre     : RetornoECF := 'L' ;
          estVenda     : RetornoECF := 'V' ;
          estPagamento : RetornoECF := 'P' ;
          estRelatorio : RetornoECF := 'R' ;
        else
          RetornoECF := 'O' ;
        end;
      end;
  end;
end;

procedure TFEfetuaPagamento.ACBrTEFDRestauraFocoAplicacao(var Tratado: Boolean);
begin
  Application.BringToFront;
  Tratado := False ;  { Deixa executar o código de Foco do ACBrTEFD }
end;

function BlockInput(fBlockInput: Boolean): DWORD; stdcall; external 'user32.DLL';

end.
