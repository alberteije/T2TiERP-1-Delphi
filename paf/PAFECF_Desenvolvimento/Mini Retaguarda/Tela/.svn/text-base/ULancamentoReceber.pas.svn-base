{*******************************************************************************
Title: T2Ti ERP
Description: Janela de Lançamentos para o Contas a Receber

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
unit ULancamentoReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Mask,
  JvExMask, JvToolEdit, Generics.Collections, ACBrBase, ACBrBoleto, ACBrUtil, ShellAPI, JvPageList;

type
  TFLancamentoReceber = class(TForm)
    ActionManager: TActionManager;
    ActionInserir: TAction;
    ActionAlterar: TAction;
    ActionExcluir: TAction;
    ActionFiltroRapido: TAction;
    PanelToolBar: TPanel;
    ActionToolBarGrid: TActionToolBar;
    ActionCancelar: TAction;
    ActionSalvar: TAction;
    ActionImprimir: TAction;
    ActionPrimeiro: TAction;
    ActionUltimo: TAction;
    ActionAnterior: TAction;
    ActionProximo: TAction;
    ActionSair: TAction;
    ActionExportar: TAction;
    ActionFiltrar: TAction;
    PanelGrid: TPanel;
    PanelEdits: TPanel;
    BevelEdits: TBevel;
    Grid: TJvDBUltimGrid;
    ActionToolBarEdits: TActionToolBar;
    ActionExportarWord: TAction;
    ActionExportarExcel: TAction;
    ActionExportarXML: TAction;
    ActionExportarCSV: TAction;
    ActionExportarHTML: TAction;
    ActionPaginaAnterior: TAction;
    ActionPaginaProxima: TAction;
    ScreenTipsManagerCadastro: TScreenTipsManager;
    PanelFiltroRapido: TPanel;
    EditCriterioRapido: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    ComboBoxCampos: TComboBox;
    Label1: TLabel;
    ActionConsultar: TAction;
    EditNomeCliente: TLabeledEdit;
    EditNomeTipoDocumento: TLabeledEdit;
    EditQuantidadeParcelas: TJvValidateEdit;
    Label2: TLabel;
    EditValor: TJvValidateEdit;
    Label3: TLabel;
    GridParcelas: TJvDBUltimGrid;
    ActionGerarParcelar: TAction;
    Label5: TLabel;
    EditPrimeiroVencimento: TJvDateEdit;
    EditIdCliente: TJvValidateEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditIdTipoDocumento: TJvValidateEdit;
    EditIdConta: TJvValidateEdit;
    EditDescricaoConta: TLabeledEdit;
    ActionEmitirBoletos: TAction;
    EditNumeroDocumento: TLabeledEdit;
    function ConferirValores: Boolean;
    procedure ActionInserirExecute(Sender: TObject);
    procedure ActionAlterarExecute(Sender: TObject);
    procedure ActionExcluirExecute(Sender: TObject);
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionSalvarExecute(Sender: TObject);
    procedure ActionImprimirExecute(Sender: TObject);
    procedure ActionFiltrarExecute(Sender: TObject);
    procedure ActionPrimeiroExecute(Sender: TObject);
    procedure ActionUltimoExecute(Sender: TObject);
    procedure ActionAnteriorExecute(Sender: TObject);
    procedure ActionProximoExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FechaFormulario;
    procedure LimparCampos;
    procedure GridParaEdits;
    procedure GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure ActionExportarWordExecute(Sender: TObject);
    procedure ActionExportarExecute(Sender: TObject);
    procedure ActionPaginaAnteriorExecute(Sender: TObject);
    procedure ActionPaginaProximaExecute(Sender: TObject);
    procedure VerificarPaginacao;
    procedure ActionExportarHTMLExecute(Sender: TObject);
    procedure ActionExportarCSVExecute(Sender: TObject);
    procedure ActionExportarXMLExecute(Sender: TObject);
    procedure ActionExportarExcelExecute(Sender: TObject);
    procedure ActionFiltroRapidoExecute(Sender: TObject);
    procedure ActionConsultarExecute(Sender: TObject);
    procedure ActionGerarParcelarExecute(Sender: TObject);
    procedure EditIdTipoDocumentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionEmitirBoletosExecute(Sender: TObject);
    procedure EditIdClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLancamentoReceber: TFLancamentoReceber;

implementation

uses
  ContasPagarReceberVO, LancamentoReceberController, UDataModule, UFiltro, Constantes,
  Biblioteca, ContasParcelasVO, ULookup, TipoDocumentoVO, TipoDocumentoController,
  PlanoContasVO, PlanoContasController, ParcelaReceberController,
  PessoaVO, PessoaController, EmpresaVO, EmpresaController, UMenu;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFLancamentoReceber.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFLancamentoReceber.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFLancamentoReceber.FormCreate(Sender: TObject);
begin
  //Grid principal - dos lançamentos
  FDataModule.CDSLancamentoReceber.Close;
  FDataModule.CDSLancamentoReceber.FieldDefs.Clear;
  FDataModule.CDSLancamentoReceber.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('DESCRICAO_PLANO_CONTA', ftString, 50);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('NOME_TIPO_DOCUMENTO', ftString, 30);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('NOME_PESSOA', ftString, 150);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('NUMERO_DOCUMENTO', ftString, 20);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('QUANTIDADE_PARCELA', ftInteger);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('VALOR', ftFloat);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('DATA_LANCAMENTO', ftString, 10);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('PRIMEIRO_VENCIMENTO', ftString, 10);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('TIPO', ftString, 1);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('NATUREZA_LANCAMENTO', ftString, 1);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('ID_PLANO_CONTAS', ftInteger);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('ID_TIPO_DOCUMENTO', ftInteger);
  FDataModule.CDSLancamentoReceber.FieldDefs.add('ID_PESSOA', ftInteger);
  FDataModule.CDSLancamentoReceber.CreateDataSet;
  TFloatField(FDataModule.CDSLancamentoReceber.FieldByName('VALOR')).displayFormat := '#,###,###,##0.00';

  // Definição dos títulos dos cabeçalhos e largura das colunas
  Grid.Columns[0].Title.Caption := 'Id';
  Grid.Columns[1].Title.Caption := 'Conta';
  Grid.Columns[2].Title.Caption := 'Tipo Documento';
  Grid.Columns[3].Title.Caption := 'Cliente';
  Grid.Columns[4].Title.Caption := 'Documento';
  Grid.Columns[5].Title.Caption := 'Qtde. Parcelas';
  Grid.Columns[6].Title.Caption := 'Valor';
  Grid.Columns[7].Title.Caption := 'Data Lançamento';
  Grid.Columns[8].Title.Caption := 'Primeiro Vencimento';
  //
  Grid.Columns[9].Visible := False;
  Grid.Columns[10].Visible := False;
  Grid.Columns[11].Visible := False;
  Grid.Columns[12].Visible := False;
  Grid.Columns[13].Visible := False;
  //
  //Grid secundária - das parcelas
  FDataModule.CDSParcelaReceber.Close;
  FDataModule.CDSParcelaReceber.FieldDefs.Clear;
  FDataModule.CDSParcelaReceber.FieldDefs.add('NUMERO_PARCELA', ftInteger);
  FDataModule.CDSParcelaReceber.FieldDefs.add('DATA_EMISSAO', ftString, 10);
  FDataModule.CDSParcelaReceber.FieldDefs.add('DATA_VENCIMENTO', ftString, 10);
  FDataModule.CDSParcelaReceber.FieldDefs.add('VALOR', ftFloat);
  FDataModule.CDSParcelaReceber.FieldDefs.add('BOLETO', ftString, 1);
  FDataModule.CDSParcelaReceber.FieldDefs.add('SITUACAO', ftString, 1);
  FDataModule.CDSParcelaReceber.FieldDefs.add('PERSISTE', ftString, 1);
  FDataModule.CDSParcelaReceber.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSParcelaReceber.FieldDefs.add('ID_CONTAS_PAGAR_RECEBER', ftInteger);
  FDataModule.CDSParcelaReceber.FieldDefs.add('DATA_PAGAMENTO', ftString, 10);
  FDataModule.CDSParcelaReceber.FieldDefs.add('TAXA_JUROS', ftFloat);
  FDataModule.CDSParcelaReceber.FieldDefs.add('TAXA_MULTA', ftFloat);
  FDataModule.CDSParcelaReceber.FieldDefs.add('TAXA_DESCONTO', ftFloat);
  FDataModule.CDSParcelaReceber.FieldDefs.add('VALOR_JUROS', ftFloat);
  FDataModule.CDSParcelaReceber.FieldDefs.add('VALOR_MULTA', ftFloat);
  FDataModule.CDSParcelaReceber.FieldDefs.add('VALOR_DESCONTO', ftFloat);
  FDataModule.CDSParcelaReceber.FieldDefs.add('TOTAL_PARCELA', ftFloat);
  FDataModule.CDSParcelaReceber.FieldDefs.add('HISTORICO', ftMemo);
  FDataModule.CDSParcelaReceber.CreateDataSet;
  TFloatField(FDataModule.CDSParcelaReceber.FieldByName('VALOR')).displayFormat := '#,###,###,##0.00';
  //Definição dos títulos dos cabeçalhos e largura das colunas
  GridParcelas.Columns[0].Title.Caption := 'Parcela';
  GridParcelas.Columns[1].Title.Caption := 'Data de Emissão';
  GridParcelas.Columns[2].Title.Caption := 'Data de Vencimento';
  GridParcelas.Columns[3].Title.Caption := 'Valor';
  GridParcelas.Columns[4].Title.Caption := 'Emite Boleto';
  //Colunas nao visiveis
  GridParcelas.Columns.Items[5].Visible := False;
  GridParcelas.Columns.Items[6].Visible := False;
  GridParcelas.Columns.Items[7].Visible := False;
  GridParcelas.Columns.Items[8].Visible := False;
  GridParcelas.Columns.Items[9].Visible := False;
  GridParcelas.Columns.Items[10].Visible := False;
  GridParcelas.Columns.Items[11].Visible := False;
  GridParcelas.Columns.Items[12].Visible := False;
  GridParcelas.Columns.Items[13].Visible := False;
  GridParcelas.Columns.Items[14].Visible := False;
  GridParcelas.Columns.Items[15].Visible := False;
  GridParcelas.Columns.Items[16].Visible := False;
  GridParcelas.Columns.Items[17].Visible := False;
  //
  Pagina := 0;
  VerificarPaginacao;
  //
  FDataModule.CDSLancamentoReceber.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
end;

procedure TFLancamentoReceber.ActionInserirExecute(Sender: TObject);
begin
  PanelEdits.BringToFront;
  EditIdCliente.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
end;

procedure TFLancamentoReceber.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSLancamentoReceber.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    EditIdCliente.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
    //Carrega parcelas
    FiltroLocal := 'ID_CONTAS_PAGAR_RECEBER = '+ FDataModule.CDSLancamentoReceber.FieldByName('ID').AsString;
    TParcelaReceberController.Consulta(trim(FiltroLocal));
  end;
end;

procedure TFLancamentoReceber.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSLancamentoReceber.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TLancamentoReceberController.Exclui(FDataModule.CDSLancamentoReceber.FieldByName('ID').AsInteger);
      TLancamentoReceberController.Consulta(Filtro, Pagina, False);
    end;
  end;
end;

procedure TFLancamentoReceber.ActionSairExecute(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TFLancamentoReceber.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  LancamentoReceber : TContasPagarReceberVO;
  ParcelaReceber: TContasParcelasVO;
  ListaParcelas: TObjectList<TContasParcelasVO>;
begin
  if not ConferirValores then
  begin
    Application.MessageBox('Valor das parcelas não confere com o valor a receber.', 'Erro', MB_OK + MB_ICONERROR);
    GridParcelas.SetFocus;
  end
  else
  begin
    LancamentoReceber := TContasPagarReceberVO.Create;
    LancamentoReceber.IdPessoa := EditIdCliente.AsInteger;
    LancamentoReceber.IdTipoDocumento := EditIdTipoDocumento.AsInteger;
    LancamentoReceber.IdPlanoContas := EditIdConta.AsInteger;
    LancamentoReceber.NumeroDocumento := EditNumeroDocumento.Text;
    LancamentoReceber.QuantidadeParcela := EditQuantidadeParcelas.AsInteger;
    LancamentoReceber.Valor := EditValor.AsFloat;
    LancamentoReceber.DataLancamento := FormatDateTime('yyyy-mm-dd', Now());
    LancamentoReceber.PrimeiroVencimento := FormatDateTime('yyyy-mm-dd', EditPrimeiroVencimento.Date);
    LancamentoReceber.Tipo := 'R';
    LancamentoReceber.NaturezaLancamento := 'E';

    //popula a lista com as parcelas
    ListaParcelas := TObjectList<TContasParcelasVO>.Create(True);
    FDataModule.CDSParcelaReceber.First;
    while not FDataModule.CDSParcelaReceber.Eof do
    begin
      if FDataModule.CDSParcelaReceber.FieldByName('PERSISTE').AsString = 'S' then
      begin
        ParcelaReceber := TContasParcelasVO.Create;
        ParcelaReceber.Id := FDataModule.CDSParcelaReceber.FieldByName('ID').AsInteger;
        ParcelaReceber.IdContasPagarReceber := FDataModule.CDSLancamentoReceber.FieldByName('ID').AsInteger;
        ParcelaReceber.NumeroParcela := FDataModule.CDSParcelaReceber.FieldByName('NUMERO_PARCELA').AsInteger;
        ParcelaReceber.DataEmissao := FormatDateTime('yyyy-mm-dd', StrToDate(FDataModule.CDSParcelaReceber.FieldByName('DATA_EMISSAO').AsString));
        ParcelaReceber.DataVencimento := FormatDateTime('yyyy-mm-dd', StrToDate(FDataModule.CDSParcelaReceber.FieldByName('DATA_VENCIMENTO').AsString));
        ParcelaReceber.DataPagamento := '0000-00-00';
        ParcelaReceber.Valor := FDataModule.CDSParcelaReceber.FieldByName('VALOR').AsFloat;
        ParcelaReceber.Situacao := FDataModule.CDSParcelaReceber.FieldByName('SITUACAO').AsString;
        ListaParcelas.Add(ParcelaReceber);
      end;
      FDataModule.CDSParcelaReceber.Next;
    end;

    if Operacao = 1 then
      TLancamentoReceberController.Insere(LancamentoReceber, ListaParcelas)
    else if Operacao = 2 then
    begin
      LancamentoReceber.ID := FDataModule.CDSLancamentoReceber.FieldByName('ID').AsInteger;
      LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
      TLancamentoReceberController.Altera(LancamentoReceber, ListaParcelas, Filtro, Pagina);
      Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
      Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
    end;

    PanelGrid.BringToFront;
    ActionToolBarGrid.Enabled := True;
    LimparCampos;
    Grid.SetFocus;
  end;
end;

procedure TFLancamentoReceber.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFLancamentoReceber.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  EditIdCliente.SetFocus;
  ActionToolBarGrid.Enabled := False;
  GridParaEdits;
  ActionSalvar.Enabled := False;
  Operacao := 3;
  //Carrega parcelas
  FiltroLocal := 'ID_CONTAS_PAGAR_RECEBER = '+ FDataModule.CDSLancamentoReceber.FieldByName('ID').AsString;
  TParcelaReceberController.Consulta(trim(FiltroLocal));
end;

procedure TFLancamentoReceber.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    Application.MessageBox('Não existe critério para consulta.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TLancamentoReceberController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end;
end;

procedure TFLancamentoReceber.ActionFiltrarExecute(Sender: TObject);
var
  LancamentoReceber: TContasPagarReceberVO;
  I : Integer;
begin
  Filtro := '';
  LancamentoReceber := TContasPagarReceberVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSLancamentoReceber;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TLancamentoReceberController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFLancamentoReceber.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoReceber.First;
end;

procedure TFLancamentoReceber.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoReceber.Last;
end;

procedure TFLancamentoReceber.EditIdTipoDocumentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TTipoDocumentoVO.Create;
    ULookup.ObjetoController := TTipoDocumentoController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'NOME';
    FLookup.ShowModal;
    EditIdTipoDocumento.Text := ULookup.CampoRetorno1;
    EditNomeTipoDocumento.Text := ULookup.CampoRetorno2;
    EditIdTipoDocumento.SetFocus;
  end;
end;

procedure TFLancamentoReceber.EditIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TPessoaVO.Create;
    ULookup.ObjetoController := TPessoaController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'NOME';
    FLookup.ShowModal;
    EditIdCliente.Text := ULookup.CampoRetorno1;
    EditNomeCliente.Text := ULookup.CampoRetorno2;
    EditIdCliente.SetFocus;
  end;
end;

procedure TFLancamentoReceber.EditIdContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TPlanoContasVO.Create;
    ULookup.ObjetoController := TPlanoContasController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'DESCRICAO';
    FLookup.ShowModal;
    EditIdConta.Text := ULookup.CampoRetorno1;
    EditDescricaoConta.Text := ULookup.CampoRetorno2;
    EditIdConta.SetFocus;
  end;
end;

procedure TFLancamentoReceber.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoReceber.Prior;
end;

procedure TFLancamentoReceber.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoReceber.Next;
end;

procedure TFLancamentoReceber.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TLancamentoReceberController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFLancamentoReceber.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TLancamentoReceberController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFLancamentoReceber.GridParaEdits;
begin
  EditIdCliente.Text := FDataModule.CDSLancamentoReceber.FieldByName('ID_PESSOA').AsString;
  EditNomeCliente.Text := FDataModule.CDSLancamentoReceber.FieldByName('NOME_PESSOA').AsString;
  EditIdConta.Text := FDataModule.CDSLancamentoReceber.FieldByName('ID_PLANO_CONTAS').AsString;
  EditDescricaoConta.Text := FDataModule.CDSLancamentoReceber.FieldByName('DESCRICAO_PLANO_CONTA').AsString;
  EditIdTipoDocumento.Text := FDataModule.CDSLancamentoReceber.FieldByName('ID_TIPO_DOCUMENTO').AsString;
  EditNomeTipoDocumento.Text := FDataModule.CDSLancamentoReceber.FieldByName('NOME_TIPO_DOCUMENTO').AsString;
  EditNumeroDocumento.Text := FDataModule.CDSLancamentoReceber.FieldByName('NUMERO_DOCUMENTO').AsString;
  EditQuantidadeParcelas.Text := FDataModule.CDSLancamentoReceber.FieldByName('QUANTIDADE_PARCELA').AsString;
  EditValor.Text := FDataModule.CDSLancamentoReceber.FieldByName('VALOR').AsString;

  EditPrimeiroVencimento.Text := Copy(FDataModule.CDSLancamentoReceber.FieldByName('PRIMEIRO_VENCIMENTO').AsString,9,2) + '/' +
                                 Copy(FDataModule.CDSLancamentoReceber.FieldByName('PRIMEIRO_VENCIMENTO').AsString,6,2) + '/' +
                                 Copy(FDataModule.CDSLancamentoReceber.FieldByName('PRIMEIRO_VENCIMENTO').AsString,1,4);
end;

procedure TFLancamentoReceber.LimparCampos;
begin
  EditIdCliente.Text := '0';
  EditNomeCliente.Clear;
  EditIdConta.Text := '1';
  EditDescricaoConta.Clear;
  EditIdTipoDocumento.Text := '1';
  EditNomeTipoDocumento.Clear;
  EditNumeroDocumento.Clear;
  EditQuantidadeParcelas.Text := '1';
  EditValor.Text := '0,00';
  EditPrimeiroVencimento.Clear;
  FDataModule.CDSParcelaReceber.EmptyDataSet;
end;

procedure TFLancamentoReceber.ActionGerarParcelarExecute(Sender: TObject);
var
  i:integer;
  Vencimento: TDate;
  SomaParcelas, Residuo: Extended;
begin
  FDataModule.CDSParcelaReceber.EmptyDataSet;

  if EditQuantidadeParcelas.AsInteger <= 0 then
    EditQuantidadeParcelas.AsInteger := 1;

  if EditPrimeiroVencimento.Text = '  /  /    ' then
    EditPrimeiroVencimento.Date := Date;

  Vencimento := EditPrimeiroVencimento.Date;
  SomaParcelas := 0;
  Residuo := 0;

  for i := 0 to EditQuantidadeParcelas.AsInteger -1 do
  begin
    FDataModule.CDSParcelaReceber.Append;
    FDataModule.CDSParcelaReceber.FieldByName('NUMERO_PARCELA').AsInteger := i+1;
    FDataModule.CDSParcelaReceber.FieldByName('DATA_EMISSAO').AsString := DateToStr(Date);
    FDataModule.CDSParcelaReceber.FieldByName('DATA_VENCIMENTO').AsString := DateToStr(Vencimento + (30*i));
    FDataModule.CDSParcelaReceber.FieldByName('VALOR').AsFloat := ArredondaTruncaValor('A', EditValor.AsFloat / EditQuantidadeParcelas.AsInteger, Constantes.TConstantes.DECIMAIS_VALOR);
    FDataModule.CDSParcelaReceber.FieldByName('SITUACAO').AsString := 'A';
    FDataModule.CDSParcelaReceber.FieldByName('PERSISTE').AsString := 'S';
    FDataModule.CDSParcelaReceber.FieldByName('BOLETO').AsString := 'X';

    FDataModule.CDSParcelaReceber.Post;

    SomaParcelas := SomaParcelas + FDataModule.CDSParcelaReceber.FieldByName('VALOR').AsFloat;
  end;

  //calcula o resíduo e lança na última parcela
  Residuo := EditValor.AsFloat - SomaParcelas;
  FDataModule.CDSParcelaReceber.Edit;
  FDataModule.CDSParcelaReceber.FieldByName('VALOR').AsFloat := FDataModule.CDSParcelaReceber.FieldByName('VALOR').AsFloat + Residuo;
  FDataModule.CDSParcelaReceber.Post;
end;

function TFLancamentoReceber.ConferirValores: Boolean;
var
  SomaParcelas: Extended;
begin
  Result := True;
  SomaParcelas := 0;

  FDataModule.CDSParcelaReceber.DisableControls;
  FDataModule.CDSParcelaReceber.First;
  while not FDataModule.CDSParcelaReceber.Eof do
  begin
    SomaParcelas := SomaParcelas + FDataModule.CDSParcelaReceber.FieldByName('VALOR').AsFloat;
    FDataModule.CDSParcelaReceber.Next;
  end;
  FDataModule.CDSParcelaReceber.First;
  FDataModule.CDSParcelaReceber.EnableControls;

  if SomaParcelas <> EditValor.AsFloat then
    Result := False;
end;

procedure TFLancamentoReceber.ActionEmitirBoletosExecute(Sender: TObject);
var
  Titulo: TACBrTitulo;
  Pdir: Pchar;
  Empresa : TEmpresaVO;
begin
  FDataModule.ACBrBoleto.ListadeBoletos.Clear;
  FDataModule.ACBrBoleto.Banco.Numero := 1;

  //pega os dados da empresa
  TEmpresaController.ConsultaObjeto('ID=1');

  FDataModule.ACBrBoleto.Cedente.Nome := Empresa.RazaoSocial;

  FDataModule.CDSParcelaReceber.First;
  while not FDataModule.CDSParcelaReceber.Eof do
  begin
    if FDataModule.CDSParcelaReceber.FieldByName('BOLETO').AsString = 'X' then
    begin
     Titulo := FDataModule.ACBrBoleto.CriarTituloNaLista;

     with Titulo do
     begin
        //implementar procedimento para pegar dados do cliente
        LocalPagamento    := 'Pagar preferêncialmente em...';
        Vencimento        := FDataModule.CDSParcelaReceber.FieldByName('DATA_VENCIMENTO').AsDateTime;
        DataDocumento     := Now;
        NumeroDocumento   := '0001';
        EspecieDoc        := 'DM';
        Aceite            := atSim;
        DataProcessamento := Now;
        NossoNumero       := '0001';
        Carteira          := '09';
        ValorDocumento    := FDataModule.CDSParcelaReceber.FieldByName('VALOR').AsFloat;
        Sacado.NomeSacado := EditNomeCliente.Text;
        Sacado.CNPJCPF    := '12345678901';
        Sacado.Logradouro := 'Rua Teste';
        Sacado.Numero     := '1001';
        Sacado.Bairro     := 'Bairro Teste';
        Sacado.Cidade     := 'Cidade Teste';
        Sacado.UF         := 'DF';
        Sacado.CEP        := '71939720';
        ValorAbatimento   := 10;
        DataAbatimento    := Vencimento-5;
        Instrucao1        := 'Instrução 01';
        Instrucao2        := 'Instrução 02';

        FDataModule.ACBrBoleto.AdicionarMensagensPadroes(Titulo,Mensagem);
     end;
    end;
    FDataModule.CDSParcelaReceber.Next;
  end;
  FDataModule.ACBrBoleto.ACBrBoletoFC.NomeArquivo := ExtractFilePath(Application.ExeName)+'boleto.pdf';
  FDataModule.ACBrBoleto.GerarPDF;

  GetMem(pDir,256);
  StrPCopy(pDir, ExtractFilePath(Application.ExeName));
  ShellExecute(0, nil, 'boleto.pdf', nil, Pdir, SW_NORMAL);
  FreeMem(pdir,256);
end;

procedure TFLancamentoReceber.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSLancamentoReceber.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFLancamentoReceber.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
var
  IxDName: string;
  i: integer;
  Fields, DescFields: string;
begin
  try
    Fields := '';
    DescFields := '';
    for i := 0 to Length(FieldsToSort) - 1 do
    begin
      Fields := Fields + FieldsToSort[i].Name + ';';
      if not FieldsToSort[i].Order then
        DescFields := DescFields + FieldsToSort[i].Name + ';';
    end;
    Fields := Copy(Fields, 1, Length(Fields)-1);
    DescFields := Copy(DescFields, 1, Length(DescFields)-1);

    IxDName := IntToStr(Length(FieldsToSort)) + '_' + FormatDateTime('hhmmssz',Now);
    FDataModule.CDSLancamentoReceber.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSLancamentoReceber.IndexDefs.Update;
    FDataModule.CDSLancamentoReceber.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFLancamentoReceber.ActionExportarCSVExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos CSV (Valores Separados por Vírgula) (*.CSV)|*.CSV';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarCSV.FileName := NomeArquivo + '.csv';
      FDataModule.ExportarCSV.Grid := Grid;
      FDataModule.ExportarCSV.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFLancamentoReceber.ActionExportarExcelExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos do Excel (*.XLS)|*.XLS';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarExcel.FileName := NomeArquivo + '.xls';
      FDataModule.ExportarExcel.Grid := Grid;
      FDataModule.ExportarExcel.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFLancamentoReceber.ActionExportarHTMLExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos HTML (*.HTML)|*.HTML';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarHTML.FileName := NomeArquivo + '.html';
      FDataModule.ExportarHTML.Grid := Grid;
      FDataModule.ExportarHTML.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFLancamentoReceber.ActionExportarWordExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos do Word (*.DOC)|*.DOC';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarWord.FileName := NomeArquivo + '.doc';
      FDataModule.ExportarWord.Grid := Grid;
      FDataModule.ExportarWord.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR)
  end;
end;

procedure TFLancamentoReceber.ActionExportarXMLExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos XML (*.XML)|*.XML';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := ExtractFileName(FDataModule.SaveDialog.FileName);
      FDataModule.ExportarXML.FileName := NomeArquivo + '.xml';
      FDataModule.ExportarXML.Grid := Grid;
      FDataModule.ExportarXML.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFLancamentoReceber.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFLancamentoReceber.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
