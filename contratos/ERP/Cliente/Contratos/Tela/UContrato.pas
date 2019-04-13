{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Contratos

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

  @author Albert Eije (alberteije@gmail.com)
  @version 1.0
  ******************************************************************************* }

unit UContrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Mask, JvExMask, JvToolEdit,
  JvCombobox, LabeledCtrls, DBCtrls, LabeledDBCtrls, DB, DBClient, StrUtils,
  Math, JSonVO, Generics.Collections, Atributos, Constantes, CheckLst,
  JvExCheckLst, JvCheckListBox, JvBaseEdits, OleCtnrs, WideStrings, FMTBcd,
  Provider, SqlExpr, ActnList, ToolWin, ActnMan, ActnCtrls, ShellApi,
  PlatformDefaultStyleActnCtrls;

type
  [TFormDescription(TConstantes.MODULO_CONTRATOS, 'Contrato')]

  TFContrato = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    EditNome: TLabeledEdit;
    EditNumero: TLabeledEdit;
    BevelEdits: TBevel;
    PageControlDadosContrato: TPageControl;
    tsDadosComplementares: TTabSheet;
    tsHistoricoFaturamento: TTabSheet;
    PanelHistoricoFaturamento: TPanel;
    GridHistoricoFaturamento: TJvDBUltimGrid;
    tsHistoricoReajuste: TTabSheet;
    PanelHistoricoReajuste: TPanel;
    GridHistoricoReajuste: TJvDBUltimGrid;
    EditIdTipoContrato: TLabeledCalcEdit;
    EditTipoContrato: TLabeledEdit;
    EditIdContaContabil: TLabeledCalcEdit;
    EditContaContabil: TLabeledEdit;
    PanelDadosComplementares: TPanel;
    EditDataCadastro: TLabeledDateEdit;
    MemoDescricao: TLabeledMemo;
    EditDataInicioVigencia: TLabeledDateEdit;
    EditDataFimVigencia: TLabeledDateEdit;
    EditDiaFaturamento: TLabeledMaskEdit;
    EditValor: TLabeledCalcEdit;
    EditQuantidadeParcelas: TLabeledCalcEdit;
    EditIntervaloEntreParcelas: TLabeledCalcEdit;
    MemoObservacao: TLabeledMemo;
    CDSHistoricoFaturamento: TClientDataSet;
    DSHistoricoFaturamento: TDataSource;
    CDSHistoricoReajuste: TClientDataSet;
    DSHistoricoReajuste: TDataSource;
    tsPrevisaoFaturamento: TTabSheet;
    PanelPrevisaoFaturamento: TPanel;
    GridPrevisaoFaturamento: TJvDBUltimGrid;
    CDSPrevisaoFaturamento: TClientDataSet;
    DSPrevisaoFaturamento: TDataSource;
    EditIdSolicitacaoServico: TLabeledCalcEdit;
    EditDescricaoSolicitacao: TLabeledEdit;
    CDSHistoricoFaturamentoID: TIntegerField;
    CDSHistoricoFaturamentoID_CONTRATO: TIntegerField;
    CDSHistoricoFaturamentoDATA_FATURA: TDateField;
    CDSHistoricoFaturamentoVALOR: TFMTBCDField;
    CDSHistoricoFaturamentoPERSISTE: TStringField;
    CDSHistoricoReajusteID: TIntegerField;
    CDSHistoricoReajusteID_CONTRATO: TIntegerField;
    CDSHistoricoReajusteINDICE: TFMTBCDField;
    CDSHistoricoReajusteVALOR_ANTERIOR: TFMTBCDField;
    CDSHistoricoReajusteVALOR_ATUAL: TFMTBCDField;
    CDSHistoricoReajusteDATA_REAJUSTE: TDateField;
    CDSHistoricoReajustePERSISTE: TStringField;
    CDSPrevisaoFaturamentoID: TIntegerField;
    CDSPrevisaoFaturamentoID_CONTRATO: TIntegerField;
    CDSPrevisaoFaturamentoDATA_PREVISTA: TDateField;
    CDSPrevisaoFaturamentoVALOR: TFMTBCDField;
    CDSPrevisaoFaturamentoPERSISTE: TStringField;
    CDSHistoricoReajusteOBSERVACAO: TStringField;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActionGerarPrevisaoFaturamento: TAction;
    ActionContratoDoTemplate: TAction;
    ActionToolBar2: TActionToolBar;
    ActionGed: TAction;
    procedure FormCreate(Sender: TObject);
    procedure GridHistoricoFaturamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridHistoricoReajusteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridPrevisaoFaturamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSHistoricoFaturamentoAfterEdit(DataSet: TDataSet);
    procedure CDSHistoricoReajusteAfterEdit(DataSet: TDataSet);
    procedure CDSPrevisaoFaturamentoAfterEdit(DataSet: TDataSet);
    procedure EditIdTipoContratoExit(Sender: TObject);
    procedure EditIdTipoContratoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdTipoContratoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdContaContabilExit(Sender: TObject);
    procedure EditIdContaContabilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContaContabilKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdSolicitacaoServicoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdSolicitacaoServicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdSolicitacaoServicoExit(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure ActionGerarPrevisaoFaturamentoExecute(Sender: TObject);
    procedure ActionContratoDoTemplateExecute(Sender: TObject);
    procedure ActionGedExecute(Sender: TObject);
  private
    { Private declarations }
    procedure DeletarArquivoTemporario;
    procedure UploadArquivo;
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
  end;

var
  FContrato: TFContrato;
  FormEditor: TForm;

implementation

uses NotificationService, ContratoVO, ContratoController, ContratoHistFaturamentoVO,
  ContratoHistoricoReajusteVO, ContratoPrevFaturamentoVO, ULookup, TipoContratoVO,
  TipoContratoController, ContabilContaVO, ContabilContaController, UDataModule,
  ContratoSolicitacaoServicoController, ContratoSolicitacaoServicoVO,
  UDocumentoWord, ContratoTemplateController, ContratoTemplateVO, ViewContratoDadosContratanteVO,
  ViewContratoDadosContratanteController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFContrato.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContratoVO;
  ObjetoController := TContratoController.Create;
  DeletarArquivoTemporario;

  {
  Quem desejar utilizar um editor próprio pode aproveitar o código abaixo
  Já existe um Editor anexo ao projeto, o mesmo que vem nos Demos do Delphi

  FormEditor := TFEditor.Create(PanelEditor);
  with FormEditor do
  begin
    Align := alClient;
    BorderStyle := bsNone;
    Parent := PanelEditor;
  end;
  FormEditor.Show;
  }
  inherited;
end;

procedure TFContrato.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFContrato.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;

procedure TFContrato.LimparCampos;
var
  i: Integer;
begin
  inherited;
  CDSHistoricoFaturamento.EmptyDataSet;
  CDSHistoricoReajuste.EmptyDataSet;
  CDSPrevisaoFaturamento.EmptyDataSet;
end;

procedure TFContrato.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;
  PageControlDadosContrato.ActivePageIndex := 0;

  if StatusTela = stNavegandoEdits then
  begin
    PanelDadosComplementares.Enabled := False;
    GridHistoricoFaturamento.ReadOnly := True;
    GridHistoricoReajuste.ReadOnly := True;
    GridPrevisaoFaturamento.ReadOnly := True;
  end
  else
  begin
    PanelDadosComplementares.Enabled := True;
    GridHistoricoFaturamento.ReadOnly := False;
    GridHistoricoReajuste.ReadOnly := False;
    GridPrevisaoFaturamento.ReadOnly := False;
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFContrato.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    DeletarArquivoTemporario;
    EditIdTipoContrato.SetFocus;
  end;
end;

function TFContrato.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdTipoContrato.SetFocus;
  end;
end;

function TFContrato.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TContratoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TContratoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFContrato.DoSalvar: Boolean;
var
  HistoricoFaturamento: TContratoHistFaturamentoVO;
  HistoricoReajuste: TContratoHistoricoReajusteVO;
  PrevisaoFaturamento: TContratoPrevFaturamentoVO;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TContratoVO.Create;

      TContratoVO(ObjetoVO).IdTipoContrato := EditIdTipoContrato.AsInteger;
      TContratoVO(ObjetoVO).TipoContratoNome := EditTipoContrato.Text;
      TContratoVO(ObjetoVO).IdContabilConta := EditIdContaContabil.AsInteger;
      TContratoVO(ObjetoVO).ContabilContaClassificacao := EditContaContabil.Text;
      TContratoVO(ObjetoVO).IdSolicitacaoServico := EditIdSolicitacaoServico.AsInteger;
      TContratoVO(ObjetoVO).ContratoSolicitacaoServicoDescricao := EditDescricaoSolicitacao.Text;
      TContratoVO(ObjetoVO).Numero := EditNumero.Text;
      TContratoVO(ObjetoVO).Nome := EditNome.Text;
      TContratoVO(ObjetoVO).DataCadastro := EditDataCadastro.Date;
      TContratoVO(ObjetoVO).DataInicioVigencia := EditDataInicioVigencia.Date;
      TContratoVO(ObjetoVO).DataFimVigencia := EditDataFimVigencia.Date;
      TContratoVO(ObjetoVO).DiaFaturamento := EditDiaFaturamento.Text;
      TContratoVO(ObjetoVO).Valor := EditValor.Value;
      TContratoVO(ObjetoVO).QuantidadeParcelas := EditQuantidadeParcelas.AsInteger;
      TContratoVO(ObjetoVO).IntervaloEntreParcelas := EditIntervaloEntreParcelas.AsInteger;
      TContratoVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TContratoVO(ObjetoVO).Observacao := MemoObservacao.Text;

      UploadArquivo;

      // Histórico Faturamento
      {
        Deve ser enviado pelo Financeiro. O usuário também poderá impostar manualmente.
      }
      CDSHistoricoFaturamento.DisableControls;
      CDSHistoricoFaturamento.First;
      while not CDSHistoricoFaturamento.Eof do
      begin
        if (CDSHistoricoFaturamentoPERSISTE.AsString = 'S') or (CDSHistoricoFaturamentoID.AsInteger = 0) then
        begin
          HistoricoFaturamento := TContratoHistFaturamentoVO.Create;
          HistoricoFaturamento.Id := CDSHistoricoFaturamentoID.AsInteger;
          HistoricoFaturamento.IdContrato := TContratoVO(ObjetoVO).Id;
          HistoricoFaturamento.DataFatura := CDSHistoricoFaturamentoDATA_FATURA.AsDateTime;
          HistoricoFaturamento.Valor := CDSHistoricoFaturamentoVALOR.AsExtended;
          TContratoVO(ObjetoVO).ListaContratoHistFaturamentoVO.Add(HistoricoFaturamento);
        end;

        CDSHistoricoFaturamento.Next;
      end;
      CDSHistoricoFaturamento.EnableControls;

      // Histórico Reajuste
      {
        Cadastro manual realizado pelo usuário.
      }
      CDSHistoricoReajuste.DisableControls;
      CDSHistoricoReajuste.First;
      while not CDSHistoricoReajuste.Eof do
      begin
        if (CDSHistoricoReajustePERSISTE.AsString = 'S') or (CDSHistoricoReajusteID.AsInteger = 0) then
        begin
          HistoricoReajuste := TContratoHistoricoReajusteVO.Create;
          HistoricoReajuste.Id := CDSHistoricoReajusteID.AsInteger;
          HistoricoReajuste.IdContrato := TContratoVO(ObjetoVO).Id;
          HistoricoReajuste.Indice := CDSHistoricoReajusteINDICE.AsExtended;
          HistoricoReajuste.ValorAnterior := CDSHistoricoReajusteVALOR_ANTERIOR.AsExtended;
          HistoricoReajuste.ValorAtual := CDSHistoricoReajusteVALOR_ATUAL.AsExtended;
          HistoricoReajuste.DataReajuste := CDSHistoricoReajusteDATA_REAJUSTE.AsDateTime;
          HistoricoReajuste.Observacao := CDSHistoricoReajusteOBSERVACAO.AsString;
          TContratoVO(ObjetoVO).ListaContratoHistoricoReajusteVO.Add(HistoricoReajuste);
        end;

        CDSHistoricoReajuste.Next;
      end;
      CDSHistoricoReajuste.EnableControls;

      // Previsão Faturamento
      CDSPrevisaoFaturamento.DisableControls;
      CDSPrevisaoFaturamento.First;
      while not CDSPrevisaoFaturamento.Eof do
      begin
        if (CDSPrevisaoFaturamentoPERSISTE.AsString = 'S') or (CDSPrevisaoFaturamentoID.AsInteger = 0) then
        begin
          PrevisaoFaturamento := TContratoPrevFaturamentoVO.Create;
          PrevisaoFaturamento.Id := CDSPrevisaoFaturamentoID.AsInteger;
          PrevisaoFaturamento.IdContrato := TContratoVO(ObjetoVO).Id;
          PrevisaoFaturamento.DataPrevista := CDSPrevisaoFaturamentoDATA_PREVISTA.AsDateTime;
          PrevisaoFaturamento.Valor := CDSPrevisaoFaturamentoVALOR.AsExtended;
          TContratoVO(ObjetoVO).ListaContratoPrevFaturamentoVO.Add(PrevisaoFaturamento);
        end;

        CDSPrevisaoFaturamento.Next;
      end;
      CDSPrevisaoFaturamento.EnableControls;

      // ObjetoVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      TContratoVO(ObjetoVO).ContabilContaVO := Nil;
      TContratoVO(ObjetoVO).TipoContratoVO := Nil;
      TContratoVO(ObjetoVO).ContratoSolicitacaoServicoVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TContratoVO(ObjetoOldVO).ContabilContaVO := Nil;
        TContratoVO(ObjetoOldVO).TipoContratoVO := Nil;
        TContratoVO(ObjetoOldVO).ContratoSolicitacaoServicoVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TContratoController(ObjetoController).Insere(TContratoVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TContratoVO(ObjetoVO).ToJSONString <> TContratoVO(ObjetoOldVO).ToJSONString then
        begin
          TContratoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TContratoController(ObjetoController).Altera(TContratoVO(ObjetoVO), TContratoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
  DeletarArquivoTemporario;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFContrato.EditIdContaContabilExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdContaContabil.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdContaContabil.Text;
      EditIdContaContabil.Clear;
      EditContaContabil.Clear;
      if not PopulaCamposTransientes(Filtro, TContabilContaVO, TContabilContaController) then
        PopulaCamposTransientesLookup(TContabilContaVO, TContabilContaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdContaContabil.Text := CDSTransiente.FieldByName('ID').AsString;
        EditContaContabil.Text := CDSTransiente.FieldByName('CLASSIFICACAO').AsString;
      end
      else
      begin
        Exit;
        EditIdContaContabil.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContaContabil.Clear;
  end;
end;

procedure TFContrato.EditIdContaContabilKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContaContabil.Value := -1;
    EditIdSolicitacaoServico.SetFocus;
  end;
end;

procedure TFContrato.EditIdContaContabilKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdSolicitacaoServico.SetFocus;
  end;
end;

procedure TFContrato.EditIdSolicitacaoServicoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdSolicitacaoServico.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdSolicitacaoServico.Text;
      EditIdSolicitacaoServico.Clear;
      EditDescricaoSolicitacao.Clear;
      if not PopulaCamposTransientes(Filtro, TContratoSolicitacaoServicoVO, TContratoSolicitacaoServicoController) then
        PopulaCamposTransientesLookup(TContratoSolicitacaoServicoVO, TContratoSolicitacaoServicoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdSolicitacaoServico.Text := CDSTransiente.FieldByName('ID').AsString;
        EditDescricaoSolicitacao.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditIdSolicitacaoServico.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditDescricaoSolicitacao.Clear;
  end;
end;

procedure TFContrato.EditIdSolicitacaoServicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdSolicitacaoServico.Value := -1;
    EditNumero.SetFocus;
  end;
end;

procedure TFContrato.EditIdSolicitacaoServicoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditNumero.SetFocus;
  end;
end;

procedure TFContrato.EditIdTipoContratoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdTipoContrato.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdTipoContrato.Text;
      EditIdTipoContrato.Clear;
      EditTipoContrato.Clear;
      if not PopulaCamposTransientes(Filtro, TTipoContratoVO, TTipoContratoController) then
        PopulaCamposTransientesLookup(TTipoContratoVO, TTipoContratoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdTipoContrato.Text := CDSTransiente.FieldByName('ID').AsString;
        EditTipoContrato.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdTipoContrato.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditTipoContrato.Clear;
  end;
end;

procedure TFContrato.EditIdTipoContratoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdTipoContrato.Value := -1;
    EditIdContaContabil.SetFocus;
  end;
end;

procedure TFContrato.EditIdTipoContratoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdContaContabil.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFContrato.GridParaEdits;
var
  HistoricoFaturamentoEnumerator: TEnumerator<TContratoHistFaturamentoVO>;
  HistoricoReajusteEnumerator: TEnumerator<TContratoHistoricoReajusteVO>;
  PrevisaoFaturamentoEnumerator: TEnumerator<TContratoPrevFaturamentoVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TContratoVO>(IdRegistroSelecionado);
     if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TContratoVO>(IdRegistroSelecionado);
 end;

  if Assigned(ObjetoVO) then
  begin

    EditIdTipoContrato.AsInteger := TContratoVO(ObjetoVO).IdTipoContrato;
    EditTipoContrato.Text := TContratoVO(ObjetoVO).TipoContratoNome;
    EditIdContaContabil.AsInteger := TContratoVO(ObjetoVO).IdContabilConta;
    EditContaContabil.Text := TContratoVO(ObjetoVO).ContabilContaClassificacao;
    EditIdSolicitacaoServico.AsInteger := TContratoVO(ObjetoVO).IdSolicitacaoServico;
    EditDescricaoSolicitacao.Text := TContratoVO(ObjetoVO).ContratoSolicitacaoServicoDescricao;
    EditNumero.Text := TContratoVO(ObjetoVO).Numero;
    EditNome.Text := TContratoVO(ObjetoVO).Nome;
    EditDataCadastro.Date := TContratoVO(ObjetoVO).DataCadastro;
    EditDataInicioVigencia.Date := TContratoVO(ObjetoVO).DataInicioVigencia;
    EditDataFimVigencia.Date := TContratoVO(ObjetoVO).DataFimVigencia;
    EditDiaFaturamento.Text := TContratoVO(ObjetoVO).DiaFaturamento;
    EditValor.Value := TContratoVO(ObjetoVO).Valor;
    EditQuantidadeParcelas.AsInteger := TContratoVO(ObjetoVO).QuantidadeParcelas;
    EditIntervaloEntreParcelas.AsInteger := TContratoVO(ObjetoVO).IntervaloEntreParcelas;
    MemoDescricao.Text := TContratoVO(ObjetoVO).Descricao;
    MemoObservacao.Text := TContratoVO(ObjetoVO).Observacao;

    // Histórico Faturamento
    HistoricoFaturamentoEnumerator := TContratoVO(ObjetoVO).ListaContratoHistFaturamentoVO.GetEnumerator;
    try
      with HistoricoFaturamentoEnumerator do
      begin
        while MoveNext do
        begin
          CDSHistoricoFaturamento.Append;
          CDSHistoricoFaturamentoID.AsInteger := Current.Id;
          CDSHistoricoFaturamentoID_CONTRATO.AsInteger := Current.IdContrato;
          CDSHistoricoFaturamentoDATA_FATURA.AsDateTime := Current.DataFatura;
          CDSHistoricoFaturamentoVALOR.AsExtended := Current.Valor;
          CDSHistoricoFaturamento.Post;
        end;
      end;
    finally
      HistoricoFaturamentoEnumerator.Free;
    end;

    // Histórico Reajuste
    HistoricoReajusteEnumerator := TContratoVO(ObjetoVO).ListaContratoHistoricoReajusteVO.GetEnumerator;
    try
      with HistoricoReajusteEnumerator do
      begin
        while MoveNext do
        begin
          CDSHistoricoReajuste.Append;
          CDSHistoricoReajusteID.AsInteger := Current.Id;
          CDSHistoricoReajusteID_CONTRATO.AsInteger := Current.IdContrato;
          CDSHistoricoReajusteINDICE.AsExtended := Current.Indice;
          CDSHistoricoReajusteVALOR_ANTERIOR.AsExtended := Current.ValorAnterior;
          CDSHistoricoReajusteVALOR_ATUAL.AsExtended := Current.ValorAtual;
          CDSHistoricoReajusteDATA_REAJUSTE.AsDateTime := Current.DataReajuste;
          CDSHistoricoReajusteOBSERVACAO.AsString := Current.Observacao;
          CDSHistoricoReajuste.Post;
        end;
      end;
    finally
      HistoricoReajusteEnumerator.Free;
    end;

    // Previsão Faturamento
    PrevisaoFaturamentoEnumerator := TContratoVO(ObjetoVO).ListaContratoPrevFaturamentoVO.GetEnumerator;
    try
      with PrevisaoFaturamentoEnumerator do
      begin
        while MoveNext do
        begin
          CDSPrevisaoFaturamento.Append;
          CDSPrevisaoFaturamentoID.AsInteger := Current.Id;
          CDSPrevisaoFaturamentoID_CONTRATO.AsInteger := Current.IdContrato;
          CDSPrevisaoFaturamentoDATA_PREVISTA.AsDateTime := Current.DataPrevista;
          CDSPrevisaoFaturamentoVALOR.AsExtended := Current.Valor;
          CDSPrevisaoFaturamento.Post;
        end;
      end;
    finally
      PrevisaoFaturamentoEnumerator.Free;
    end;
  end;
  ConfigurarLayoutTela;
end;

procedure TFContrato.GridHistoricoFaturamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridHistoricoFaturamento.SelectedIndex := GridHistoricoFaturamento.SelectedIndex + 1;
end;

procedure TFContrato.GridHistoricoReajusteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridHistoricoReajuste.SelectedIndex := GridHistoricoReajuste.SelectedIndex + 1;
end;

procedure TFContrato.GridPrevisaoFaturamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridPrevisaoFaturamento.SelectedIndex := GridPrevisaoFaturamento.SelectedIndex + 1;
end;

procedure TFContrato.CDSHistoricoFaturamentoAfterEdit(DataSet: TDataSet);
begin
  CDSHistoricoFaturamentoPERSISTE.AsString := 'S';
end;

procedure TFContrato.CDSHistoricoReajusteAfterEdit(DataSet: TDataSet);
begin
  CDSHistoricoReajustePERSISTE.AsString := 'S';
end;

procedure TFContrato.CDSPrevisaoFaturamentoAfterEdit(DataSet: TDataSet);
begin
  CDSPrevisaoFaturamentoPERSISTE.AsString := 'S';
end;

procedure TFContrato.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFContrato.ActionGedExecute(Sender: TObject);
var
  Parametros: String;
begin
  if EditNumero.Text <> '' then
  begin
    {
      Parametros
      1 - Login
      2 - Senha
      3 - Aplicação que chamou
      4 - Nome do arquivo (Aplicacao que chamou + Tela que chamou + Numero Contrato
    }

    try
      Parametros := Sessao.Usuario.Login + ' ' +
                    Sessao.Usuario.Senha + ' ' +
                    'CONTRATOS' + ' ' +
                    'CONTRATOS_CONTRATO_' + EditNumero.Text;
      ShellExecute(
            Handle,
            'open',
            'T2TiERPGed.exe',
            PChar(Parametros),
            '',
            SW_SHOWNORMAL
            );
    except
      Application.MessageBox('Erro ao tentar executar o módulo.', 'Erro do Sistema', MB_OK + MB_ICONERROR);
    end;
  end
  else
  begin
    Application.MessageBox('É preciso informar o número do contrato.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditNumero.SetFocus;
  end;
end;

procedure TFContrato.ActionGerarPrevisaoFaturamentoExecute(Sender: TObject);
var
  i: Integer;
  DataBase: TDateTime;
begin
  CDSPrevisaoFaturamento.EmptyDataSet;
  DataBase := StrToDateTime(EditDiaFaturamento.Text + Copy(EditDataInicioVigencia.Text, 3, 8));
  for i := 0 to EditQuantidadeParcelas.AsInteger - 1 do
  begin
    CDSPrevisaoFaturamento.Append;
    CDSPrevisaoFaturamentoID_CONTRATO.AsInteger := IdRegistroSelecionado;

    {
      Se o usuário preencher o EditIntervaloEntreParcelas, o sistema vai ignorar o Dia do Faturamento
    }
    if EditIntervaloEntreParcelas.AsInteger = 0 then
      CDSPrevisaoFaturamentoDATA_PREVISTA.AsDateTime := StrToDateTime(EditDiaFaturamento.Text + Copy(DateToStr(DataBase + (i * 30)), 3, 8))
    else
      CDSPrevisaoFaturamentoDATA_PREVISTA.AsDateTime := DataBase + (i * EditIntervaloEntreParcelas.AsInteger);

    CDSPrevisaoFaturamentoVALOR.AsExtended := EditValor.Value;
    CDSPrevisaoFaturamento.Post;
  end;
end;

procedure TFContrato.ActionContratoDoTemplateExecute(Sender: TObject);
var
  Arquivo: String;
  AbrirArquivo: Boolean;
  DadosContratante: TViewContratoDadosContratanteVO;
begin
  if EditIdSolicitacaoServico.AsInteger <> 0 then
  begin
    try
      try
        DadosContratante := TViewContratoDadosContratanteController.ViewContratoDadosContratante('ID_SOLICITACAO = ' + EditIdSolicitacaoServico.Text);
        if Assigned(DadosContratante) then
        begin
          AbrirArquivo := False;
          DeletarArquivoTemporario;
          // Se o usuário estiver inserindo um novo contrato, deixa ele fazer a consulta pelo template
          if StatusTela = stInserindo then
          begin
            PopulaCamposTransientesLookup(TContratoTemplateVO, TContratoTemplateController);
            if CDSTransiente.RecordCount > 0 then
            begin
              TContratoTemplateController.DownloadArquivo(CDSTransiente.FieldByName('ID').AsString + '.doc', 'CONTRATOS_TEMPLATE');
              AbrirArquivo := True;
            end;
          end
          else if StatusTela = stEditando then
          begin
            // Se o usuário estiver editando um Contrato, verifica se já existe um arquivo no servidor
            Arquivo := TContratoController.DownloadArquivo(IntToStr(TContratoVO(ObjetoVO).Id) + '.doc', 'CONTRATOS');
            // Caso não exista um arquivo de contrato, desce um Template
            if Arquivo = '' then
            begin
              TContratoTemplateController.DownloadArquivo(CDSTransiente.FieldByName('ID').AsString + '.doc', 'CONTRATOS_TEMPLATE');
              AbrirArquivo := True;
            end
            else
              AbrirArquivo := True;
          end;

          if AbrirArquivo then
          begin
            Application.CreateForm(TFDocumentoWord, FDocumentoWord);
            FDocumentoWord.Operacao := 'Alterar';

            {Substituições}
            // Contratada
            FDocumentoWord.ListaSubstituicoes.Add('<CONTRATADA>|' + Sessao.Empresa.RazaoSocial);
            FDocumentoWord.ListaSubstituicoes.Add('<CNPJ_CONTRATADA>|' + Sessao.Empresa.Cnpj);
            FDocumentoWord.ListaSubstituicoes.Add('<ENDERECO_CONTRATADA>|' + Sessao.Empresa.ListaEnderecoVO[0].Logradouro + Sessao.Empresa.ListaEnderecoVO[0].Numero + Sessao.Empresa.ListaEnderecoVO[0].Complemento);
            FDocumentoWord.ListaSubstituicoes.Add('<CIDADE_CONTRATADA>|' + Sessao.Empresa.ListaEnderecoVO[0].Cidade);
            FDocumentoWord.ListaSubstituicoes.Add('<UF_CONTRATADA>|' + Sessao.Empresa.ListaEnderecoVO[0].Uf);
            FDocumentoWord.ListaSubstituicoes.Add('<BAIRRO_CONTRATADA>|' + Sessao.Empresa.ListaEnderecoVO[0].Bairro);
            FDocumentoWord.ListaSubstituicoes.Add('<CEP_CONTRATADA>|' + Sessao.Empresa.ListaEnderecoVO[0].Cep);
            // Contratante
            FDocumentoWord.ListaSubstituicoes.Add('<CONTRATANTE>|' + DadosContratante.Nome);
            FDocumentoWord.ListaSubstituicoes.Add('<CNPJ_CONTRATANTE>|' + DadosContratante.CpfCnpj);
            FDocumentoWord.ListaSubstituicoes.Add('<ENDERECO_CONTRATANTE>|' + DadosContratante.Logradouro + DadosContratante.Numero + DadosContratante.Complemento);
            FDocumentoWord.ListaSubstituicoes.Add('<CIDADE_CONTRATANTE>|' + DadosContratante.Cidade);
            FDocumentoWord.ListaSubstituicoes.Add('<UF_CONTRATANTE>|' + DadosContratante.Uf);
            FDocumentoWord.ListaSubstituicoes.Add('<BAIRRO_CONTRATANTE>|' + DadosContratante.Bairro);
            FDocumentoWord.ListaSubstituicoes.Add('<CEP_CONTRATANTE>|' + DadosContratante.Cep);
            // Outros
            FDocumentoWord.ListaSubstituicoes.Add('<VALOR_MENSAL>|' + (FloatToStrf(EditValor.Value, ffNumber, 18, 2)));
            FDocumentoWord.ListaSubstituicoes.Add('<DATA_EXTENSO>|' + FormatDateTime('dddddd', EditDataInicioVigencia.Date));
            FDocumentoWord.ShowModal;
          end;
        end
        else
          Application.MessageBox('Um template só pode ser utilizado para serviços prestados.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      except
        on E: Exception do
          Application.MessageBox(PChar('Ocorreu um erro no acesso ao template. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    Application.MessageBox('É preciso informar a solicitação.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdSolicitacaoServico.SetFocus;
  end;
end;

procedure TFContrato.DeletarArquivoTemporario;
begin
  if FileExists(ExtractFilePath(Application.ExeName)+'temp.doc') then
    DeleteFile(ExtractFilePath(Application.ExeName)+'temp.doc');
end;

procedure TFContrato.UploadArquivo;
var
  ArquivoStream: TStringStream;
  ArquivoBytesString: String;
  i: Integer;
begin
  if FileExists(ExtractFilePath(Application.ExeName)+'temp.doc') then
  begin
    try
      try
        ArquivoBytesString := '';
        ArquivoStream := TStringStream.Create;
        ArquivoStream.LoadFromFile(ExtractFilePath(Application.ExeName)+'temp.doc');
        for i := 0 to ArquivoStream.Size - 1 do
        begin
          ArquivoBytesString := ArquivoBytesString + IntToStr(ArquivoStream.Bytes[i]) + ', ';
        end;
        // Tira a ultima virgula
        Delete(ArquivoBytesString, Length(ArquivoBytesString) - 1, 2);
        TContratoVO(ObjetoVO).Arquivo := ArquivoBytesString;
        TContratoVO(ObjetoVO).TipoArquivo := '.doc';
      except
        Application.MessageBox('Arquivo de imagem com formato inválido.', 'Erro do sistema.', MB_OK + MB_ICONERROR);
      end;
    finally
      ArquivoStream.Free;
    end;
  end;
end;
{$ENDREGION}

end.
