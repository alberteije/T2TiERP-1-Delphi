{*******************************************************************************
Title: T2Ti ERP
Description: Janela Consulta Endereços

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
unit UCep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvPageList;

type
  TFCep = class(TForm)
    ActionManager: TActionManager;
    ActionConsultar: TAction;
    PanelToolBar: TPanel;
    ActionToolBarGrid: TActionToolBar;
    ActionImprimir: TAction;
    ActionPrimeiro: TAction;
    ActionUltimo: TAction;
    ActionAnterior: TAction;
    ActionProximo: TAction;
    ActionSair: TAction;
    ActionExportar: TAction;
    ActionFiltrar: TAction;
    PanelGrid: TPanel;
    Grid: TJvDBUltimGrid;
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
    procedure ActionImprimirExecute(Sender: TObject);
    procedure ActionFiltrarExecute(Sender: TObject);
    procedure ActionPrimeiroExecute(Sender: TObject);
    procedure ActionUltimoExecute(Sender: TObject);
    procedure ActionAnteriorExecute(Sender: TObject);
    procedure ActionProximoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FechaFormulario;
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
    procedure ActionConsultarExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCep: TFCep;

implementation

uses
  CepVO, CepController, UDataModule, UFiltro, Constantes, UMenu;

var
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFCep.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFCep.FormCreate(Sender: TObject);
begin
  FDataModule.CDSCep.Close;
  FDataModule.CDSCep.FieldDefs.Clear;
  FDataModule.CDSCep.FieldDefs.add('CEP', ftString, 8);
  FDataModule.CDSCep.FieldDefs.add('LOGRADOURO', ftString, 100);
  FDataModule.CDSCep.FieldDefs.add('COMPLEMENTO', ftString, 100);
  FDataModule.CDSCep.FieldDefs.add('BAIRRO', ftString, 100);
  FDataModule.CDSCep.FieldDefs.add('CIDADE', ftString, 100);
  FDataModule.CDSCep.FieldDefs.add('UF', ftString, 2);
  FDataModule.CDSCep.FieldDefs.add('IBGE', ftInteger);
  FDataModule.CDSCep.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSCep.CreateDataSet;
  //
  // Definição dos títulos dos cabeçalhos e largura das colunas
  Grid.Columns[0].Title.Caption := 'CEP';
  Grid.Columns[1].Title.Caption := 'Logradouro';
  Grid.Columns[2].Title.Caption := 'Complemento';
  Grid.Columns[3].Title.Caption := 'Bairro';
  Grid.Columns[4].Title.Caption := 'Cidade';
  Grid.Columns[5].Title.Caption := 'UF';
  Grid.Columns[6].Title.Caption := 'IBGE';
  Grid.Columns[1].Width := 300;
  Grid.Columns[2].Width := 300;
  Grid.Columns[3].Width := 300;
  Grid.Columns[4].Width := 300;
  Grid.Columns[5].Width := 50;

  //Colunas invisíveis
  Grid.Columns[7].Visible := False;
  //
  Pagina := 0;
  VerificarPaginacao;
  //
  FDataModule.CDSCep.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
end;

procedure TFCep.ActionConsultarExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    Application.MessageBox('Não existe critério para consulta.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TCepController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end;
end;

procedure TFCep.ActionFiltrarExecute(Sender: TObject);
var
  Cep : TCepVO;
  I : Integer;
begin
  Filtro := '';
  Cep := TCepVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSCep;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TCepController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFCep.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSCep.First;
end;

procedure TFCep.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSCep.Last;
end;

procedure TFCep.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSCep.Prior;
end;

procedure TFCep.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSCep.Next;
end;

procedure TFCep.ActionSairExecute(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TFCep.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TCepController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFCep.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TCepController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFCep.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSCep.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFCep.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    FDataModule.CDSCep.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSCep.IndexDefs.Update;
    FDataModule.CDSCep.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFCep.ActionExportarCSVExecute(Sender: TObject);
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

procedure TFCep.ActionExportarExcelExecute(Sender: TObject);
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

procedure TFCep.ActionExportarHTMLExecute(Sender: TObject);
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

procedure TFCep.ActionExportarWordExecute(Sender: TObject);
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

procedure TFCep.ActionExportarXMLExecute(Sender: TObject);
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

procedure TFCep.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFCep.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
