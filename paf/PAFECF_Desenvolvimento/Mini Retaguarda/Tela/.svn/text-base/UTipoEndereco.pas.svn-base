{*******************************************************************************
Title: T2Ti ERP
Description: Janela de cadastro dos Tipos de Endereço

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
unit UTipoEndereco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, JvPageList;

type
  TFTipoEndereco = class(TForm)
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
    EditNome: TLabeledEdit;
    Label2: TLabel;
    MemoDescricao: TMemo;
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
    procedure ActionSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoEndereco: TFTipoEndereco;

implementation

uses
  TipoEnderecoVO, TipoEnderecoController, UDataModule, UFiltro, Constantes,
  Biblioteca, ULookup, UMenu;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFTipoEndereco.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFTipoEndereco.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFTipoEndereco.FormCreate(Sender: TObject);
begin
  FDataModule.CDSTipoEndereco.Close;
  FDataModule.CDSTipoEndereco.FieldDefs.Clear;
  FDataModule.CDSTipoEndereco.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSTipoEndereco.FieldDefs.add('NOME', ftString, 30);
  FDataModule.CDSTipoEndereco.FieldDefs.add('DESCRICAO', ftMemo);
  FDataModule.CDSTipoEndereco.CreateDataSet;

  // Definição dos títulos dos cabeçalhos e largura das colunas
  Grid.Columns[0].Title.Caption := 'Id';
  Grid.Columns[1].Title.Caption := 'Nome';
  Grid.Columns[2].Title.Caption := 'Descrição';
  Grid.Columns[1].Width := 300;
  Grid.Columns[2].Width := 400;
  //
  Pagina := 0;
  VerificarPaginacao;
  //
  FDataModule.CDSTipoEndereco.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
end;

procedure TFTipoEndereco.ActionInserirExecute(Sender: TObject);
begin
  PanelEdits.BringToFront;
  EditNome.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
end;

procedure TFTipoEndereco.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSTipoEndereco.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    EditNome.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
  end;
end;

procedure TFTipoEndereco.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSTipoEndereco.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TTipoEnderecoController.Exclui(FDataModule.CDSTipoEndereco.FieldByName('ID').AsInteger);
      TTipoEnderecoController.Consulta(Filtro, Pagina, False);
    end;
  end;
end;

procedure TFTipoEndereco.ActionSairExecute(Sender: TObject);
begin
FechaFormulario;
end;

procedure TFTipoEndereco.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  TipoEndereco : TTipoEnderecoVO;
begin
  TipoEndereco := TTipoEnderecoVO.Create;
  TipoEndereco.Nome := EditNome.Text;
  TipoEndereco.Descricao := MemoDescricao.Text;

  if Operacao = 1 then
    TTipoEnderecoController.Insere(TipoEndereco)
  else if Operacao = 2 then
  begin
  	TipoEndereco.ID := FDataModule.CDSTipoEndereco.FieldByName('ID').AsInteger;
    LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
    TTipoEnderecoController.Altera(TipoEndereco, Filtro, Pagina);
    Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
    Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
  end;

  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  Grid.SetFocus;
end;

procedure TFTipoEndereco.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFTipoEndereco.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  EditNome.SetFocus;
  ActionToolBarGrid.Enabled := False;
  GridParaEdits;
  ActionSalvar.Enabled := False;
  Operacao := 3;
end;

procedure TFTipoEndereco.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    Application.MessageBox('Não existe critério para consulta.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TTipoEnderecoController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end;
end;

procedure TFTipoEndereco.ActionFiltrarExecute(Sender: TObject);
var
  TipoEndereco : TTipoEnderecoVO;
  I : Integer;
begin
  Filtro := '';
  TipoEndereco := TTipoEnderecoVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSTipoEndereco;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TTipoEnderecoController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFTipoEndereco.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSTipoEndereco.First;
end;

procedure TFTipoEndereco.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSTipoEndereco.Last;
end;

procedure TFTipoEndereco.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSTipoEndereco.Prior;
end;

procedure TFTipoEndereco.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSTipoEndereco.Next;
end;

procedure TFTipoEndereco.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TTipoEnderecoController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFTipoEndereco.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TTipoEnderecoController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFTipoEndereco.GridParaEdits;
begin
  EditNome.Text := FDataModule.CDSTipoEndereco.FieldByName('NOME').AsString;
  MemoDescricao.Text := FDataModule.CDSTipoEndereco.FieldByName('DESCRICAO').AsString;
end;

procedure TFTipoEndereco.LimparCampos;
begin
  EditNome.Clear;
  MemoDescricao.Clear;
end;

procedure TFTipoEndereco.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSTipoEndereco.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFTipoEndereco.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    FDataModule.CDSTipoEndereco.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSTipoEndereco.IndexDefs.Update;
    FDataModule.CDSTipoEndereco.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFTipoEndereco.ActionExportarCSVExecute(Sender: TObject);
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

procedure TFTipoEndereco.ActionExportarExcelExecute(Sender: TObject);
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

procedure TFTipoEndereco.ActionExportarHTMLExecute(Sender: TObject);
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

procedure TFTipoEndereco.ActionExportarWordExecute(Sender: TObject);
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

procedure TFTipoEndereco.ActionExportarXMLExecute(Sender: TObject);
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

procedure TFTipoEndereco.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFTipoEndereco.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
