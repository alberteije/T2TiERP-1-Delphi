{*******************************************************************************
Title: T2Ti ERP
Description: Janela de Lançamentos para o Contas a Pagar

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
unit ULancamentoPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Mask,
  JvExMask, JvToolEdit, Generics.Collections, ShellAPI, JvPageList;

type
  TFLancamentoPagar = class(TForm)
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
    procedure EditIdClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActionSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLancamentoPagar: TFLancamentoPagar;

implementation

uses
  ContasPagarReceberVO, LancamentoPagarController, UDataModule, UFiltro, Constantes,
  Biblioteca, ContasParcelasVO, ULookup, TipoDocumentoVO, TipoDocumentoController,
  PlanoContasVO, PlanoContasController, ParcelaPagarController,
  PessoaVO, PessoaController, EmpresaVO, EmpresaController, UMenu;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFLancamentoPagar.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFLancamentoPagar.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFLancamentoPagar.FormCreate(Sender: TObject);
begin
  //Grid principal - dos lançamentos
  FDataModule.CDSLancamentoPagar.Close;
  FDataModule.CDSLancamentoPagar.FieldDefs.Clear;
  FDataModule.CDSLancamentoPagar.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('DESCRICAO_PLANO_CONTA', ftString, 50);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('NOME_TIPO_DOCUMENTO', ftString, 30);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('NOME_PESSOA', ftString, 150);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('NUMERO_DOCUMENTO', ftString, 20);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('QUANTIDADE_PARCELA', ftInteger);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('VALOR', ftFloat);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('DATA_LANCAMENTO', ftString, 10);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('PRIMEIRO_VENCIMENTO', ftString, 10);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('TIPO', ftString, 1);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('NATUREZA_LANCAMENTO', ftString, 1);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('ID_PLANO_CONTAS', ftInteger);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('ID_TIPO_DOCUMENTO', ftInteger);
  FDataModule.CDSLancamentoPagar.FieldDefs.add('ID_PESSOA', ftInteger);
  FDataModule.CDSLancamentoPagar.CreateDataSet;
  TFloatField(FDataModule.CDSLancamentoPagar.FieldByName('VALOR')).displayFormat := '#,###,###,##0.00';

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
  FDataModule.CDSParcelaPagar.Close;
  FDataModule.CDSParcelaPagar.FieldDefs.Clear;
  FDataModule.CDSParcelaPagar.FieldDefs.add('NUMERO_PARCELA', ftInteger);
  FDataModule.CDSParcelaPagar.FieldDefs.add('DATA_EMISSAO', ftString, 10);
  FDataModule.CDSParcelaPagar.FieldDefs.add('DATA_VENCIMENTO', ftString, 10);
  FDataModule.CDSParcelaPagar.FieldDefs.add('VALOR', ftFloat);
  FDataModule.CDSParcelaPagar.FieldDefs.add('SITUACAO', ftString, 1);
  FDataModule.CDSParcelaPagar.FieldDefs.add('PERSISTE', ftString, 1);
  FDataModule.CDSParcelaPagar.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSParcelaPagar.FieldDefs.add('ID_CONTAS_PAGAR_RECEBER', ftInteger);
  FDataModule.CDSParcelaPagar.FieldDefs.add('DATA_PAGAMENTO', ftString, 10);
  FDataModule.CDSParcelaPagar.FieldDefs.add('TAXA_JUROS', ftFloat);
  FDataModule.CDSParcelaPagar.FieldDefs.add('TAXA_MULTA', ftFloat);
  FDataModule.CDSParcelaPagar.FieldDefs.add('TAXA_DESCONTO', ftFloat);
  FDataModule.CDSParcelaPagar.FieldDefs.add('VALOR_JUROS', ftFloat);
  FDataModule.CDSParcelaPagar.FieldDefs.add('VALOR_MULTA', ftFloat);
  FDataModule.CDSParcelaPagar.FieldDefs.add('VALOR_DESCONTO', ftFloat);
  FDataModule.CDSParcelaPagar.FieldDefs.add('TOTAL_PARCELA', ftFloat);
  FDataModule.CDSParcelaPagar.FieldDefs.add('HISTORICO', ftMemo);
  FDataModule.CDSParcelaPagar.CreateDataSet;
  TFloatField(FDataModule.CDSParcelaPagar.FieldByName('VALOR')).displayFormat := '#,###,###,##0.00';
  //Definição dos títulos dos cabeçalhos e largura das colunas
  GridParcelas.Columns[0].Title.Caption := 'Parcela';
  GridParcelas.Columns[1].Title.Caption := 'Data de Emissão';
  GridParcelas.Columns[2].Title.Caption := 'Data de Vencimento';
  GridParcelas.Columns[3].Title.Caption := 'Valor';
  //Colunas nao visiveis
  GridParcelas.Columns.Items[4].Visible := False;
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
  //
  Pagina := 0;
  VerificarPaginacao;
  //
  FDataModule.CDSLancamentoPagar.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
end;

procedure TFLancamentoPagar.ActionInserirExecute(Sender: TObject);
begin
  PanelEdits.BringToFront;
  EditIdCliente.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
end;

procedure TFLancamentoPagar.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSLancamentoPagar.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    EditIdCliente.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
    //Carrega parcelas
    FiltroLocal := 'ID_CONTAS_PAGAR_RECEBER = '+ FDataModule.CDSLancamentoPagar.FieldByName('ID').AsString;
    TParcelaPagarController.Consulta(trim(FiltroLocal));
  end;
end;

procedure TFLancamentoPagar.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSLancamentoPagar.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TLancamentoPagarController.Exclui(FDataModule.CDSLancamentoPagar.FieldByName('ID').AsInteger);
      TLancamentoPagarController.Consulta(Filtro, Pagina, False);
    end;
  end;
end;

procedure TFLancamentoPagar.ActionSairExecute(Sender: TObject);
begin
FechaFormulario;
end;

procedure TFLancamentoPagar.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  LancamentoPagar : TContasPagarReceberVO;
  ParcelaPagar: TContasParcelasVO;
  ListaParcelas: TObjectList<TContasParcelasVO>;
begin
  if not ConferirValores then
  begin
    Application.MessageBox('Valor das parcelas não confere com o valor a receber.', 'Erro', MB_OK + MB_ICONERROR);
    GridParcelas.SetFocus;
  end
  else
  begin
    LancamentoPagar := TContasPagarReceberVO.Create;
    LancamentoPagar.IdPessoa := EditIdCliente.AsInteger;
    LancamentoPagar.IdTipoDocumento := EditIdTipoDocumento.AsInteger;
    LancamentoPagar.IdPlanoContas := EditIdConta.AsInteger;
    LancamentoPagar.NumeroDocumento := EditNumeroDocumento.Text;
    LancamentoPagar.QuantidadeParcela := EditQuantidadeParcelas.AsInteger;
    LancamentoPagar.Valor := EditValor.AsFloat;
    LancamentoPagar.DataLancamento := FormatDateTime('yyyy-mm-dd', Now());
    LancamentoPagar.PrimeiroVencimento := FormatDateTime('yyyy-mm-dd', EditPrimeiroVencimento.Date);
    LancamentoPagar.Tipo := 'P';
    LancamentoPagar.NaturezaLancamento := 'S';

    //popula a lista com as parcelas
    ListaParcelas := TObjectList<TContasParcelasVO>.Create(True);
    FDataModule.CDSParcelaPagar.First;
    while not FDataModule.CDSParcelaPagar.Eof do
    begin
      if FDataModule.CDSParcelaPagar.FieldByName('PERSISTE').AsString = 'S' then
      begin
        ParcelaPagar := TContasParcelasVO.Create;
        ParcelaPagar.Id := FDataModule.CDSParcelaPagar.FieldByName('ID').AsInteger;
        ParcelaPagar.IdContasPagarReceber := FDataModule.CDSLancamentoPagar.FieldByName('ID').AsInteger;
        ParcelaPagar.NumeroParcela := FDataModule.CDSParcelaPagar.FieldByName('NUMERO_PARCELA').AsInteger;
        ParcelaPagar.DataEmissao := FormatDateTime('yyyy-mm-dd', StrToDate(FDataModule.CDSParcelaPagar.FieldByName('DATA_EMISSAO').AsString));
        ParcelaPagar.DataVencimento := FormatDateTime('yyyy-mm-dd', StrToDate(FDataModule.CDSParcelaPagar.FieldByName('DATA_VENCIMENTO').AsString));
        ParcelaPagar.DataPagamento := '0000-00-00';
        ParcelaPagar.Valor := FDataModule.CDSParcelaPagar.FieldByName('VALOR').AsFloat;
        ParcelaPagar.Situacao := FDataModule.CDSParcelaPagar.FieldByName('SITUACAO').AsString;
        ListaParcelas.Add(ParcelaPagar);
      end;
      FDataModule.CDSParcelaPagar.Next;
    end;

    if Operacao = 1 then
      TLancamentoPagarController.Insere(LancamentoPagar, ListaParcelas)
    else if Operacao = 2 then
    begin
      LancamentoPagar.ID := FDataModule.CDSLancamentoPagar.FieldByName('ID').AsInteger;
      LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
      TLancamentoPagarController.Altera(LancamentoPagar, ListaParcelas, Filtro, Pagina);
      Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
      Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
    end;

    PanelGrid.BringToFront;
    ActionToolBarGrid.Enabled := True;
    LimparCampos;
    Grid.SetFocus;
  end;
end;

procedure TFLancamentoPagar.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFLancamentoPagar.ActionConsultarExecute(Sender: TObject);
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
  FiltroLocal := 'ID_CONTAS_PAGAR_RECEBER = '+ FDataModule.CDSLancamentoPagar.FieldByName('ID').AsString;
  TParcelaPagarController.Consulta(trim(FiltroLocal));
end;

procedure TFLancamentoPagar.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    Application.MessageBox('Não existe critério para consulta.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TLancamentoPagarController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end;
end;

procedure TFLancamentoPagar.ActionFiltrarExecute(Sender: TObject);
var
  LancamentoPagar: TContasPagarReceberVO;
  I : Integer;
begin
  Filtro := '';
  LancamentoPagar := TContasPagarReceberVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSLancamentoPagar;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TLancamentoPagarController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFLancamentoPagar.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoPagar.First;
end;

procedure TFLancamentoPagar.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoPagar.Last;
end;

procedure TFLancamentoPagar.EditIdTipoDocumentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFLancamentoPagar.EditIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFLancamentoPagar.EditIdContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFLancamentoPagar.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoPagar.Prior;
end;

procedure TFLancamentoPagar.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSLancamentoPagar.Next;
end;

procedure TFLancamentoPagar.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TLancamentoPagarController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFLancamentoPagar.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TLancamentoPagarController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFLancamentoPagar.GridParaEdits;
begin
  EditIdCliente.Text := FDataModule.CDSLancamentoPagar.FieldByName('ID_PESSOA').AsString;
  EditNomeCliente.Text := FDataModule.CDSLancamentoPagar.FieldByName('NOME_PESSOA').AsString;
  EditIdConta.Text := FDataModule.CDSLancamentoPagar.FieldByName('ID_PLANO_CONTAS').AsString;
  EditDescricaoConta.Text := FDataModule.CDSLancamentoPagar.FieldByName('DESCRICAO_PLANO_CONTA').AsString;
  EditIdTipoDocumento.Text := FDataModule.CDSLancamentoPagar.FieldByName('ID_TIPO_DOCUMENTO').AsString;
  EditNomeTipoDocumento.Text := FDataModule.CDSLancamentoPagar.FieldByName('NOME_TIPO_DOCUMENTO').AsString;
  EditNumeroDocumento.Text := FDataModule.CDSLancamentoPagar.FieldByName('NUMERO_DOCUMENTO').AsString;
  EditQuantidadeParcelas.Text := FDataModule.CDSLancamentoPagar.FieldByName('QUANTIDADE_PARCELA').AsString;
  EditValor.Text := FDataModule.CDSLancamentoPagar.FieldByName('VALOR').AsString;

  EditPrimeiroVencimento.Text := Copy(FDataModule.CDSLancamentoPagar.FieldByName('PRIMEIRO_VENCIMENTO').AsString,9,2) + '/' +
                                 Copy(FDataModule.CDSLancamentoPagar.FieldByName('PRIMEIRO_VENCIMENTO').AsString,6,2) + '/' +
                                 Copy(FDataModule.CDSLancamentoPagar.FieldByName('PRIMEIRO_VENCIMENTO').AsString,1,4);
end;

procedure TFLancamentoPagar.LimparCampos;
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
  FDataModule.CDSParcelaPagar.EmptyDataSet;
end;

procedure TFLancamentoPagar.ActionGerarParcelarExecute(Sender: TObject);
var
  i:integer;
  Vencimento: TDate;
  SomaParcelas, Residuo: Extended;
begin
  FDataModule.CDSParcelaPagar.EmptyDataSet;

  if EditQuantidadeParcelas.AsInteger <= 0 then
    EditQuantidadeParcelas.AsInteger := 1;

  if EditPrimeiroVencimento.Text = '  /  /    ' then
    EditPrimeiroVencimento.Date := Date;

  Vencimento := EditPrimeiroVencimento.Date;
  SomaParcelas := 0;
  Residuo := 0;

  for i := 0 to EditQuantidadeParcelas.AsInteger -1 do
  begin
    FDataModule.CDSParcelaPagar.Append;
    FDataModule.CDSParcelaPagar.FieldByName('NUMERO_PARCELA').AsInteger := i+1;
    FDataModule.CDSParcelaPagar.FieldByName('DATA_EMISSAO').AsString := DateToStr(Date);
    FDataModule.CDSParcelaPagar.FieldByName('DATA_VENCIMENTO').AsString := DateToStr(Vencimento + (30*i));
    FDataModule.CDSParcelaPagar.FieldByName('VALOR').AsFloat := ArredondaTruncaValor('A', EditValor.AsFloat / EditQuantidadeParcelas.AsInteger, Constantes.TConstantes.DECIMAIS_VALOR);
    FDataModule.CDSParcelaPagar.FieldByName('SITUACAO').AsString := 'A';
    FDataModule.CDSParcelaPagar.FieldByName('PERSISTE').AsString := 'S';

    FDataModule.CDSParcelaPagar.Post;

    SomaParcelas := SomaParcelas + FDataModule.CDSParcelaPagar.FieldByName('VALOR').AsFloat;
  end;

  //calcula o resíduo e lança na última parcela
  Residuo := EditValor.AsFloat - SomaParcelas;
  FDataModule.CDSParcelaPagar.Edit;
  FDataModule.CDSParcelaPagar.FieldByName('VALOR').AsFloat := FDataModule.CDSParcelaPagar.FieldByName('VALOR').AsFloat + Residuo;
  FDataModule.CDSParcelaPagar.Post;
end;

function TFLancamentoPagar.ConferirValores: Boolean;
var
  SomaParcelas: Extended;
begin
  Result := True;
  SomaParcelas := 0;

  FDataModule.CDSParcelaPagar.DisableControls;
  FDataModule.CDSParcelaPagar.First;
  while not FDataModule.CDSParcelaPagar.Eof do
  begin
    SomaParcelas := SomaParcelas + FDataModule.CDSParcelaPagar.FieldByName('VALOR').AsFloat;
    FDataModule.CDSParcelaPagar.Next;
  end;
  FDataModule.CDSParcelaPagar.First;
  FDataModule.CDSParcelaPagar.EnableControls;

  if SomaParcelas <> EditValor.AsFloat then
    Result := False;
end;

procedure TFLancamentoPagar.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSLancamentoPagar.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFLancamentoPagar.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    FDataModule.CDSLancamentoPagar.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSLancamentoPagar.IndexDefs.Update;
    FDataModule.CDSLancamentoPagar.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFLancamentoPagar.ActionExportarCSVExecute(Sender: TObject);
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

procedure TFLancamentoPagar.ActionExportarExcelExecute(Sender: TObject);
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

procedure TFLancamentoPagar.ActionExportarHTMLExecute(Sender: TObject);
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

procedure TFLancamentoPagar.ActionExportarWordExecute(Sender: TObject);
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

procedure TFLancamentoPagar.ActionExportarXMLExecute(Sender: TObject);
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

procedure TFLancamentoPagar.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFLancamentoPagar.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
