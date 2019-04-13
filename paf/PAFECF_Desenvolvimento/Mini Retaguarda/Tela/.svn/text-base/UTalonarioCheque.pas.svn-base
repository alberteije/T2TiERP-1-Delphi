{*******************************************************************************
Title: T2Ti ERP
Description: Janela de Cadastro de Talonários e Cheques

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
unit UTalonarioCheque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Generics.Collections,JvPageList;

type
  TFTalonarioCheque = class(TForm)
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
    EditNomeConta: TLabeledEdit;
    GridCheques: TJvDBUltimGrid;
    EditIdConta: TJvValidateEdit;
    Label6: TLabel;
    EditNumero: TJvValidateEdit;
    Label2: TLabel;
    EditTalao: TLabeledEdit;
    ActionGerarCheques: TAction;
    EditPrimeiroCheque: TJvValidateEdit;
    Label3: TLabel;
    EditUltimoCheque: TJvValidateEdit;
    Label4: TLabel;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditIdContaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActionGerarChequesExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTalonarioCheque: TFTalonarioCheque;

implementation

uses
  TalonarioChequeVO, TalonarioChequeController, UDataModule, UFiltro, Constantes,
  Biblioteca, ChequeVO, ULookup, ChequeController, ContaCaixaVO, ContaCaixaController,
  UMenu;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFTalonarioCheque.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFTalonarioCheque.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFTalonarioCheque.FormCreate(Sender: TObject);
begin
  //Grid principal - dos talões
  FDataModule.CDSTalonarioCheque.Close;
  FDataModule.CDSTalonarioCheque.FieldDefs.Clear;
  FDataModule.CDSTalonarioCheque.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSTalonarioCheque.FieldDefs.add('NOME_CONTA_CAIXA', ftString, 50);
  FDataModule.CDSTalonarioCheque.FieldDefs.add('TALAO', ftString, 10);
  FDataModule.CDSTalonarioCheque.FieldDefs.add('NUMERO', ftInteger);
  FDataModule.CDSTalonarioCheque.FieldDefs.add('ID_CONTA_CAIXA', ftInteger);
  FDataModule.CDSTalonarioCheque.CreateDataSet;

  // Definição dos títulos dos cabeçalhos e largura das colunas
  Grid.Columns[0].Title.Caption := 'Id';
  Grid.Columns[1].Title.Caption := 'Conta';
  Grid.Columns[2].Title.Caption := 'Talão';
  Grid.Columns[3].Title.Caption := 'Número';
  //Colunas nao visiveis
  Grid.Columns[4].Visible := False;
  //
  //
  //Grid secundária - dos cheques
  FDataModule.CDSCheque.Close;
  FDataModule.CDSCheque.FieldDefs.Clear;
  FDataModule.CDSCheque.FieldDefs.add('NUMERO', ftInteger);
  FDataModule.CDSCheque.FieldDefs.add('STATUS_CHEQUE', ftString, 1);
  FDataModule.CDSCheque.FieldDefs.add('DATA_STATUS', ftString, 10);
  FDataModule.CDSCheque.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSCheque.FieldDefs.add('ID_TALONARIO_CHEQUE', ftInteger);
  FDataModule.CDSCheque.FieldDefs.add('PERSISTE', ftString, 1);
  FDataModule.CDSCheque.CreateDataSet;
  //Definição dos títulos dos cabeçalhos e largura das colunas
  GridCheques.Columns[0].Title.Caption := 'Número';
  GridCheques.Columns[1].Title.Caption := 'Status';
  GridCheques.Columns[2].Title.Caption := 'Data Status';
  //Colunas nao visiveis
  GridCheques.Columns.Items[3].Visible := False;
  GridCheques.Columns.Items[4].Visible := False;
  GridCheques.Columns.Items[5].Visible := False;
  //
  Pagina := 0;
  VerificarPaginacao;
  //
  FDataModule.CDSTalonarioCheque.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
end;

procedure TFTalonarioCheque.ActionInserirExecute(Sender: TObject);
begin
  PanelEdits.BringToFront;
  EditIdConta.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
end;

procedure TFTalonarioCheque.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSTalonarioCheque.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    EditIdConta.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
    //Carrega itens
    FiltroLocal := 'ID_TALONARIO_CHEQUE = '+ FDataModule.CDSTalonarioCheque.FieldByName('ID').AsString;
    TChequeController.Consulta(trim(FiltroLocal), 0, False);
  end;
end;

procedure TFTalonarioCheque.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSTalonarioCheque.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TTalonarioChequeController.Exclui(FDataModule.CDSTalonarioCheque.FieldByName('ID').AsInteger);
      TTalonarioChequeController.Consulta(Filtro, Pagina, False);
    end;
  end;
end;

procedure TFTalonarioCheque.ActionSairExecute(Sender: TObject);
begin
FechaFormulario;
end;

procedure TFTalonarioCheque.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  TalonarioCheque : TTalonarioChequeVO;
  Cheque: TChequeVO;
  ListaCheques: TObjectList<TChequeVO>;
begin
  TalonarioCheque := TTalonarioChequeVO.Create;
  TalonarioCheque.IdContaCaixa := EditIdConta.AsInteger;
  TalonarioCheque.Talao := EditTalao.Text;
  TalonarioCheque.Numero := EditNumero.AsInteger;

  //popula a lista com os cheques
  ListaCheques := TObjectList<TChequeVO>.Create(True);
  FDataModule.CDSCheque.First;
  while not FDataModule.CDSCheque.Eof do
  begin
    if FDataModule.CDSCheque.FieldByName('PERSISTE').AsString = 'S' then
    begin
      Cheque := TChequeVO.Create;
      Cheque.Id := FDataModule.CDSCheque.FieldByName('ID').AsInteger;
      Cheque.IdTalonarioCheque := FDataModule.CDSCheque.FieldByName('ID_TALONARIO_CHEQUE').AsInteger;
      Cheque.Numero := FDataModule.CDSCheque.FieldByName('NUMERO').AsInteger;
      Cheque.StatusCheque := FDataModule.CDSCheque.FieldByName('STATUS_CHEQUE').AsString;
      Cheque.DataStatus := FDataModule.CDSCheque.FieldByName('DATA_STATUS').AsString;
      ListaCheques.Add(Cheque);
    end;
    FDataModule.CDSCheque.Next;
  end;

  if Operacao = 1 then
    TTalonarioChequeController.Insere(TalonarioCheque, ListaCheques)
  else if Operacao = 2 then
  begin
  	TalonarioCheque.ID := FDataModule.CDSTalonarioCheque.FieldByName('ID').AsInteger;
    LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
    TTalonarioChequeController.Altera(TalonarioCheque, ListaCheques, Filtro, Pagina);
    Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
    Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
  end;

  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  Grid.SetFocus;
end;

procedure TFTalonarioCheque.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFTalonarioCheque.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  EditIdConta.SetFocus;
  ActionToolBarGrid.Enabled := False;
  GridParaEdits;
  ActionSalvar.Enabled := False;
  Operacao := 3;
  //Carrega itens
  FiltroLocal := 'ID_TALONARIO_CHEQUE = '+ FDataModule.CDSTalonarioCheque.FieldByName('ID').AsString;
  TChequeController.Consulta(trim(FiltroLocal), 0, False);
end;

procedure TFTalonarioCheque.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    Application.MessageBox('Não existe critério para consulta.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TTalonarioChequeController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end;
end;

procedure TFTalonarioCheque.ActionGerarChequesExecute(Sender: TObject);
var
  I: Integer;
begin
  for I := EditPrimeiroCheque.AsInteger to EditUltimoCheque.AsInteger - 1 do
  begin
    FDataModule.CDSCheque.Append;
    FDataModule.CDSCheque.FieldByName('ID_TALONARIO_CHEQUE').AsInteger := FDataModule.CDSTalonarioCheque.FieldByName('ID').AsInteger;
    FDataModule.CDSCheque.FieldByName('NUMERO').AsInteger := I;
    FDataModule.CDSCheque.FieldByName('STATUS_CHEQUE').AsString := 'E';
    FDataModule.CDSCheque.FieldByName('DATA_STATUS').AsString := FormatDateTime('yyyy-mm-dd', Now());
    FDataModule.CDSCheque.FieldByName('PERSISTE').AsString := 'S';
    FDataModule.CDSCheque.Post;
  end;
end;

procedure TFTalonarioCheque.ActionFiltrarExecute(Sender: TObject);
var
  TalonarioCheque : TTalonarioChequeVO;
  I : Integer;
begin
  Filtro := '';
  TalonarioCheque := TTalonarioChequeVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSTalonarioCheque;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TTalonarioChequeController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFTalonarioCheque.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSTalonarioCheque.First;
end;

procedure TFTalonarioCheque.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSTalonarioCheque.Last;
end;

procedure TFTalonarioCheque.EditIdContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TContaCaixaVO.Create;
    ULookup.ObjetoController := TContaCaixaController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'NOME';
    FLookup.ShowModal;
    EditIdConta.Text := ULookup.CampoRetorno1;
    EditNomeConta.Text := ULookup.CampoRetorno2;
    EditIdConta.SetFocus;
  end;
end;

procedure TFTalonarioCheque.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSTalonarioCheque.Prior;
end;

procedure TFTalonarioCheque.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSTalonarioCheque.Next;
end;

procedure TFTalonarioCheque.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TTalonarioChequeController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFTalonarioCheque.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TTalonarioChequeController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFTalonarioCheque.GridParaEdits;
begin
  EditIdConta.Text := FDataModule.CDSTalonarioCheque.FieldByName('ID_CONTA_CAIXA').AsString;
  EditNomeConta.Text := FDataModule.CDSTalonarioCheque.FieldByName('NOME_CONTA_CAIXA').AsString;
  EditTalao.Text := FDataModule.CDSTalonarioCheque.FieldByName('TALAO').AsString;
  EditNumero.Text := FDataModule.CDSTalonarioCheque.FieldByName('NUMERO').AsString;
end;

procedure TFTalonarioCheque.LimparCampos;
begin
  EditIdConta.Clear;
  EditNomeConta.Clear;
  EditTalao.Clear;
  EditNumero.Clear;
  EditPrimeiroCheque.Clear;
  EditUltimoCheque.Clear;
  FDataModule.CDSCheque.EmptyDataSet;
end;

procedure TFTalonarioCheque.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSTalonarioCheque.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFTalonarioCheque.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    FDataModule.CDSTalonarioCheque.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSTalonarioCheque.IndexDefs.Update;
    FDataModule.CDSTalonarioCheque.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFTalonarioCheque.ActionExportarCSVExecute(Sender: TObject);
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

procedure TFTalonarioCheque.ActionExportarExcelExecute(Sender: TObject);
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

procedure TFTalonarioCheque.ActionExportarHTMLExecute(Sender: TObject);
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

procedure TFTalonarioCheque.ActionExportarWordExecute(Sender: TObject);
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

procedure TFTalonarioCheque.ActionExportarXMLExecute(Sender: TObject);
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

procedure TFTalonarioCheque.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFTalonarioCheque.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
