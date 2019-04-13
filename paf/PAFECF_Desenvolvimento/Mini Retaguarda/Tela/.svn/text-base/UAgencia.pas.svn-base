{*******************************************************************************
Title: T2Ti ERP
Description: Janela de cadastro das Agências Bancárias

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
unit UAgencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Mask, JvPageList;

type
  TFAgencia = class(TForm)
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
    EditNomeBanco: TLabeledEdit;
    EditIdBanco: TJvValidateEdit;
    Label6: TLabel;
    EditNome: TLabeledEdit;
    EditCodigo: TLabeledEdit;
    EditNumero: TJvValidateEdit;
    Label2: TLabel;
    EditEndereco: TLabeledEdit;
    EditBairro: TLabeledEdit;
    EditCidade: TLabeledEdit;
    EditUf: TLabeledEdit;
    EditGerente: TLabeledEdit;
    EditFone01: TMaskEdit;
    Label3: TLabel;
    EditFone02: TMaskEdit;
    Label4: TLabel;
    MemoObservacao: TMemo;
    Label5: TLabel;
    Label7: TLabel;
    EditCep: TMaskEdit;
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
    procedure EditIdBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAgencia: TFAgencia;

implementation

uses
  AgenciaVO, AgenciaController, UDataModule, UFiltro, Constantes,
  Biblioteca, ULookup, BancoVO, BancoController, UMenu;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFAgencia.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFAgencia.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFAgencia.FormCreate(Sender: TObject);
begin
  FDataModule.CDSAgencia.Close;
  FDataModule.CDSAgencia.FieldDefs.Clear;
  FDataModule.CDSAgencia.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSAgencia.FieldDefs.add('CODIGO', ftString, 10);
  FDataModule.CDSAgencia.FieldDefs.add('NOME', ftString, 100);
  FDataModule.CDSAgencia.FieldDefs.add('NOME_BANCO', ftString, 100);
  FDataModule.CDSAgencia.FieldDefs.add('ENDERECO', ftString, 150);
  FDataModule.CDSAgencia.FieldDefs.add('NUMERO', ftInteger);
  FDataModule.CDSAgencia.FieldDefs.add('CEP', ftString, 8);
  FDataModule.CDSAgencia.FieldDefs.add('BAIRRO', ftString, 100);
  FDataModule.CDSAgencia.FieldDefs.add('CIDADE', ftString, 100);
  FDataModule.CDSAgencia.FieldDefs.add('UF', ftString, 2);
  FDataModule.CDSAgencia.FieldDefs.add('GERENTE', ftString, 20);
  FDataModule.CDSAgencia.FieldDefs.add('TELEFONE1', ftString, 10);
  FDataModule.CDSAgencia.FieldDefs.add('TELEFONE2', ftString, 10);
  FDataModule.CDSAgencia.FieldDefs.add('OBSERVACAO', ftMemo);
  FDataModule.CDSAgencia.FieldDefs.add('ID_BANCO', ftInteger);
  FDataModule.CDSAgencia.CreateDataSet;

  // Definição dos títulos dos cabeçalhos e largura das colunas
  Grid.Columns[0].Title.Caption := 'Id';
  Grid.Columns[1].Title.Caption := 'Código';
  Grid.Columns[2].Title.Caption := 'Nome';
  Grid.Columns[3].Title.Caption := 'Banco';
  Grid.Columns[4].Title.Caption := 'Endereço';
  Grid.Columns[5].Title.Caption := 'Número';
  Grid.Columns[6].Title.Caption := 'CEP';
  Grid.Columns[7].Title.Caption := 'Bairro';
  Grid.Columns[8].Title.Caption := 'Cidade';
  Grid.Columns[9].Title.Caption := 'UF';
  Grid.Columns[10].Title.Caption := 'Gerente';
  Grid.Columns[11].Title.Caption := 'Fone 01';
  Grid.Columns[12].Title.Caption := 'Fone 02';
  Grid.Columns[13].Title.Caption := 'Observação';
  Grid.Columns[1].Width := 50;
  Grid.Columns[2].Width := 200;
  Grid.Columns[3].Width := 200;
  Grid.Columns[4].Width := 200;

  //Colunas invisíveis
  Grid.Columns[14].Visible := False;
  //
  Pagina := 0;
  VerificarPaginacao;
  //
  FDataModule.CDSAgencia.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
end;

procedure TFAgencia.ActionInserirExecute(Sender: TObject);
begin
  PanelEdits.BringToFront;
  EditIdBanco.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
end;

procedure TFAgencia.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSAgencia.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    EditIdBanco.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
  end;
end;

procedure TFAgencia.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSAgencia.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TAgenciaController.Exclui(FDataModule.CDSAgencia.FieldByName('ID').AsInteger);
      TAgenciaController.Consulta(Filtro, Pagina, False);
    end;
  end;
end;

procedure TFAgencia.ActionSairExecute(Sender: TObject);
begin
FechaFormulario;
end;

procedure TFAgencia.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  Agencia : TAgenciaVO;
begin
  Agencia := TAgenciaVO.Create;
  Agencia.IdBanco := EditIdBanco.AsInteger;
  Agencia.Codigo := EditCodigo.Text;
  Agencia.Nome := EditNome.Text;
  Agencia.Cep := EditCep.Text;
  Agencia.Endereco := EditEndereco.Text;
  Agencia.Numero := EditNumero.AsInteger;
  Agencia.Bairro := EditBairro.Text;
  Agencia.Cidade := EditCidade.Text;
  Agencia.Uf := EditUf.Text;
  Agencia.Telefone1 := EditFone01.Text;
  Agencia.Telefone2 := EditFone02.Text;
  Agencia.Gerente := EditGerente.Text;
  Agencia.Observacao := MemoObservacao.Text;

  if Operacao = 1 then
    TAgenciaController.Insere(Agencia)
  else if Operacao = 2 then
  begin
  	Agencia.ID := FDataModule.CDSAgencia.FieldByName('ID').AsInteger;
    LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
    TAgenciaController.Altera(Agencia, Filtro, Pagina);
    Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
    Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
  end;

  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  Grid.SetFocus;
end;

procedure TFAgencia.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFAgencia.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  EditIdBanco.SetFocus;
  ActionToolBarGrid.Enabled := False;
  GridParaEdits;
  ActionSalvar.Enabled := False;
  Operacao := 3;
end;

procedure TFAgencia.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    Application.MessageBox('Não existe critério para consulta.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TAgenciaController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end;
end;

procedure TFAgencia.EditIdBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TBancoVO.Create;
    ULookup.ObjetoController := TBancoController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'NOME';
    FLookup.ShowModal;
    EditIdBanco.Text := ULookup.CampoRetorno1;
    EditNomeBanco.Text := ULookup.CampoRetorno2;
    EditIdBanco.SetFocus;
  end;
end;

procedure TFAgencia.ActionFiltrarExecute(Sender: TObject);
var
  Agencia : TAgenciaVO;
  I : Integer;
begin
  Filtro := '';
  Agencia := TAgenciaVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSAgencia;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TAgenciaController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFAgencia.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSAgencia.First;
end;

procedure TFAgencia.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSAgencia.Last;
end;

procedure TFAgencia.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSAgencia.Prior;
end;

procedure TFAgencia.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSAgencia.Next;
end;

procedure TFAgencia.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TAgenciaController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFAgencia.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TAgenciaController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFAgencia.GridParaEdits;
begin
  EditIdBanco.Text := FDataModule.CDSAgencia.FieldByName('ID_BANCO').AsString;
  EditNomeBanco.Text := FDataModule.CDSAgencia.FieldByName('NOME_BANCO').AsString;
  EditCodigo.Text := FDataModule.CDSAgencia.FieldByName('CODIGO').AsString;
  EditNome.Text := FDataModule.CDSAgencia.FieldByName('NOME').AsString;
  EditCep.Text := FDataModule.CDSAgencia.FieldByName('CEP').AsString;
  EditEndereco.Text := FDataModule.CDSAgencia.FieldByName('ENDERECO').AsString;
  EditNumero.Text := FDataModule.CDSAgencia.FieldByName('NUMERO').AsString;
  EditBairro.Text := FDataModule.CDSAgencia.FieldByName('BAIRRO').AsString;
  EditCidade.Text := FDataModule.CDSAgencia.FieldByName('CIDADE').AsString;
  EditUf.Text := FDataModule.CDSAgencia.FieldByName('UF').AsString;
  EditFone01.Text := FDataModule.CDSAgencia.FieldByName('TELEFONE1').AsString;
  EditFone02.Text := FDataModule.CDSAgencia.FieldByName('TELEFONE2').AsString;
  EditGerente.Text := FDataModule.CDSAgencia.FieldByName('GERENTE').AsString;
  MemoObservacao.Text := FDataModule.CDSAgencia.FieldByName('OBSERVACAO').AsString;
end;

procedure TFAgencia.LimparCampos;
begin
  EditIdBanco.Clear;
  EditNomeBanco.Clear;
  EditCodigo.Clear;
  EditNome.Clear;
  EditCep.Clear;
  EditEndereco.Clear;
  EditNumero.Clear;
  EditBairro.Clear;
  EditCidade.Clear;
  EditUf.Clear;
  EditFone01.Clear;
  EditFone02.Clear;
  EditGerente.Clear;
  MemoObservacao.Clear;
end;

procedure TFAgencia.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSAgencia.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFAgencia.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    FDataModule.CDSAgencia.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSAgencia.IndexDefs.Update;
    FDataModule.CDSAgencia.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFAgencia.ActionExportarCSVExecute(Sender: TObject);
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

procedure TFAgencia.ActionExportarExcelExecute(Sender: TObject);
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

procedure TFAgencia.ActionExportarHTMLExecute(Sender: TObject);
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

procedure TFAgencia.ActionExportarWordExecute(Sender: TObject);
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

procedure TFAgencia.ActionExportarXMLExecute(Sender: TObject);
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

procedure TFAgencia.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFAgencia.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
