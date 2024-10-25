{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de concilia��o dos clientes - M�dulo Concilia��o Cont�bil

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

  t2ti.com@gmail.com
  @author Albert Eije (T2Ti.COM)
  @version 1.0
  ******************************************************************************* }
unit UConciliacaoCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ClienteVO,
  ClienteController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, CheckLst, ActnList, ToolWin,
  ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls, JvExExtCtrls,
  JvNetscapeSplitter;

type
  [TFormDescription(TConstantes.MODULO_CONCILIACAO_CONTABIL, 'Concilia��o Cliente')]

  TFConciliacaoCliente = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditIdContabilConta: TLabeledCalcEdit;
    EditContabilConta: TLabeledEdit;
    CDSParcelaRecebimento: TClientDataSet;
    DSParcelaRecebimento: TDataSource;
    CDSContabilLancamento: TClientDataSet;
    CDSContabilLancamentoID: TIntegerField;
    CDSContabilLancamentoID_CONTABIL_CONTA: TIntegerField;
    CDSContabilLancamentoID_CONTABIL_HISTORICO: TIntegerField;
    CDSContabilLancamentoID_CONTABIL_LANCAMENTO_CAB: TIntegerField;
    CDSContabilLancamentoHISTORICO: TStringField;
    CDSContabilLancamentoTIPO: TStringField;
    CDSContabilLancamentoVALOR: TFMTBCDField;
    DSContabilLancamento: TDataSource;
    GroupBox4: TGroupBox;
    JvDBUltimGrid2: TJvDBUltimGrid;
    CDSLancamentoConciliado: TClientDataSet;
    DSLancamentoConciliado: TDataSource;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActionListarLancamentos: TAction;
    ActionConciliacao: TAction;
    EditIdCliente: TLabeledCalcEdit;
    EditCliente: TLabeledEdit;
    CDSLancamentoConciliadoDATA_RECEBIMENTO: TDateField;
    CDSLancamentoConciliadoDATA_BALANCETE: TDateField;
    CDSLancamentoConciliadoHISTORICO_RECEBIMENTO: TStringField;
    CDSLancamentoConciliadoVALOR_RECEBIMENTO: TFMTBCDField;
    CDSLancamentoConciliadoCLASSIFICACAO: TStringField;
    CDSLancamentoConciliadoHISTORICO_CONTA: TStringField;
    CDSLancamentoConciliadoTIPO: TStringField;
    CDSLancamentoConciliadoVALOR_CONTA: TFMTBCDField;
    CDSContabilLancamentoCONTABIL_CONTACLASSIFICACAO: TStringField;
    PanelLancamentos: TPanel;
    GroupBox2: TGroupBox;
    GridDetalhe: TJvDBUltimGrid;
    GroupBox3: TGroupBox;
    JvDBUltimGrid1: TJvDBUltimGrid;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    CDSParcelaRecebimentoID: TIntegerField;
    CDSParcelaRecebimentoID_FIN_TIPO_RECEBIMENTO: TIntegerField;
    CDSParcelaRecebimentoID_FIN_PARCELA_RECEBER: TIntegerField;
    CDSParcelaRecebimentoID_CONTA_CAIXA: TIntegerField;
    CDSParcelaRecebimentoDATA_RECEBIMENTO: TDateField;
    CDSParcelaRecebimentoTAXA_JURO: TFMTBCDField;
    CDSParcelaRecebimentoTAXA_MULTA: TFMTBCDField;
    CDSParcelaRecebimentoTAXA_DESCONTO: TFMTBCDField;
    CDSParcelaRecebimentoVALOR_JURO: TFMTBCDField;
    CDSParcelaRecebimentoVALOR_MULTA: TFMTBCDField;
    CDSParcelaRecebimentoVALOR_DESCONTO: TFMTBCDField;
    CDSParcelaRecebimentoVALOR_RECEBIDO: TFMTBCDField;
    CDSParcelaRecebimentoHISTORICO: TStringField;
    CDSParcelaRecebimentoID_CLIENTE: TIntegerField;
    EditPeriodoInicial: TLabeledDateEdit;
    EditPeriodoFinal: TLabeledDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure ActionListarLancamentosExecute(Sender: TObject);
    procedure ActionConciliacaoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
    procedure LimparCampos; override;
  end;

var
  FConciliacaoCliente: TFConciliacaoCliente;

implementation

uses ULookup, Biblioteca, UDataModule, ContabilContaVO, ContabilLancamentoDetalheController,
ViewConciliaClienteController;
{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFConciliacaoCliente.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TClienteVO;
  ObjetoController := TClienteController.Create;

  inherited;
end;

procedure TFConciliacaoCliente.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoAlterar.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoSalvar.Visible := False;
end;

procedure TFConciliacaoCliente.LimparCampos;
begin
  inherited;
  CDSParcelaRecebimento.EmptyDataSet;
  CDSContabilLancamento.EmptyDataSet;
  CDSLancamentoConciliado.EmptyDataSet;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFConciliacaoCliente.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TClienteVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdContabilConta.AsInteger := TClienteVO(ObjetoVO).IdContabilConta;
    EditContabilConta.Text := TClienteVO(ObjetoVO).ContabilContaClassificacao;
    EditIdCliente.AsInteger := TClienteVO(ObjetoVO).Id;
    EditCliente.Text := TClienteVO(ObjetoVO).PessoaNome;
  end;
end;

procedure TFConciliacaoCliente.GridDblClick(Sender: TObject);
begin
  inherited;
  PanelEdits.Enabled := True;
  EditPeriodoInicial.SetFocus;
  if TClienteVO(ObjetoVO).IdContabilConta = 0 then
  begin
    Application.MessageBox('Cliente sem conta cont�bil vinculada.', 'Informa��o do Sistema', MB_OK + MB_IconInformation);
    BotaoCancelar.Click;
  end
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFConciliacaoCliente.ActionListarLancamentosExecute(Sender: TObject);
begin
  // Contas Recebidas
  TViewConciliaClienteController.SetDataSet(CDSParcelaRecebimento);
  TViewConciliaClienteController.Consulta('ID_CLIENTE=' + IntToStr(TClienteVO(ObjetoVO).Id) + ' and (DATA_RECEBIMENTO BETWEEN ' + QuotedStr(DataParaTexto(EditPeriodoInicial.Date)) + ' and ' + QuotedStr(DataParaTexto(EditPeriodoFinal.Date)) + ')', 0);

  // Lan�amentos Cont�beis
  TContabilLancamentoDetalheController.SetDataSet(CDSContabilLancamento);
  TContabilLancamentoDetalheController.Consulta('ID_CONTABIL_CONTA=' + IntToStr(TClienteVO(ObjetoVO).IdContabilConta), 0);
end;

procedure TFConciliacaoCliente.ActionConciliacaoExecute(Sender: TObject);
begin
  CDSParcelaRecebimento.DisableControls;
  CDSContabilLancamento.DisableControls;

  CDSParcelaRecebimento.First;
  while not CDSParcelaRecebimento.Eof do
  begin

    CDSContabilLancamento.First;
    while not CDSContabilLancamento.Eof do
    begin

      if CDSParcelaRecebimentoVALOR_RECEBIDO.AsExtended = CDSContabilLancamentoVALOR.AsExtended then
      begin
        CDSLancamentoConciliado.Append;
        CDSLancamentoConciliadoDATA_RECEBIMENTO.AsDateTime := CDSParcelaRecebimentoDATA_RECEBIMENTO.AsDateTime;
        CDSLancamentoConciliadoDATA_BALANCETE.AsDateTime := CDSParcelaRecebimentoDATA_RECEBIMENTO.AsDateTime;
        CDSLancamentoConciliadoHISTORICO_RECEBIMENTO.AsString := CDSParcelaRecebimentoHISTORICO.AsString;
        CDSLancamentoConciliadoVALOR_RECEBIMENTO.AsExtended := CDSParcelaRecebimentoVALOR_RECEBIDO.AsExtended;
        CDSLancamentoConciliadoCLASSIFICACAO.AsString := CDSContabilLancamentoCONTABIL_CONTACLASSIFICACAO.AsString;
        CDSLancamentoConciliadoHISTORICO_CONTA.AsString := CDSContabilLancamentoHISTORICO.AsString;
        CDSLancamentoConciliadoTIPO.AsString := CDSContabilLancamentoTIPO.AsString;
        CDSLancamentoConciliadoVALOR_CONTA.AsExtended := CDSContabilLancamentoVALOR.AsExtended;
        CDSLancamentoConciliado.Post;
      end;

      CDSContabilLancamento.Next;
    end;
    CDSParcelaRecebimento.Next;
  end;

  CDSParcelaRecebimento.EnableControls;
  CDSContabilLancamento.EnableControls;
end;

{$ENDREGION}

end.
