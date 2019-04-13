{*******************************************************************************
Title: T2Ti ERP
Description: Janela de cadastro do NCM

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
unit UNcm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, JvPageList,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, Rtti, TypInfo, DBCtrls;

type
  TFNcm = class(TForm)
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
    BtnFiltroRapido: TSpeedButton;
    ComboBoxCampos: TComboBox;
    Label1: TLabel;
    ActionConsultar: TAction;
    EditAliquotaPIS: TJvCalcEdit;
    Label2: TLabel;
    EditAliquotaCOFINS: TJvCalcEdit;
    Label3: TLabel;
    EditNcm: TEdit;
    Label4: TLabel;
    EditDescricao: TEdit;
    Label5: TLabel;
    EditCSTPIS: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    EditCSTCOFINS: TEdit;
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
    procedure ConfiguraGrid;
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
  FNcm: TFNcm;

implementation

uses
  NcmVO, NcmController, UDataModule, UFiltro, Constantes,
  Biblioteca, ULookup, UMenu, Atributos;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFNcm.FechaFormulario;
begin
    if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFNcm.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFNcm.FormCreate(Sender: TObject);
begin
  // Configurar o Grid
  ConfiguraGrid;

  Pagina := 0;
  VerificarPaginacao;
  FDataModule.CDSNcm.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
  panelgrid.BringToFront;
end;

procedure TFNcm.ConfiguraGrid;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  I: Integer;

begin
  try

    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(TNcmVO);

    //Configura ClientDataset
    FDataModule.CDSNcm.Close;
    FDataModule.CDSNcm.FieldDefs.Clear;
    FDataModule.CDSNcm.IndexDefs.Clear;

    //preenche os nomes dos campos do CDS
    FDataModule.CDSNcm.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
              FDataModule.CDSNcm.FieldDefs.add((Atributo as TColumn).Name, ftString, (Atributo as TColumn).Length)
            else
            if Propriedade.PropertyType.TypeKind in [tkFloat] then
              FDataModule.CDSNcm.FieldDefs.add((Atributo as TColumn).Name, ftFloat)
            else
            if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
              FDataModule.CDSNcm.FieldDefs.add((Atributo as TColumn).Name, ftInteger)
          end;
        end;
      end;
    end;
    FDataModule.CDSNcm.CreateDataSet;

    //Configura a Grid
    I := 1;
    Grid.Columns[0].Title.Caption := 'ID';
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            Grid.Columns[I].Title.Caption := (Atributo as TColumn).Caption;
            Inc(I);
          end;
        end;
      end;
    end;

    FDataModule.CDSNcm.GetFieldNames(ComboBoxCampos.Items);
    ComboBoxCampos.ItemIndex := 1;

    //ComboBoxCampos.SetFocus;
  finally
    Contexto.Free;

  end;
end;

procedure TFNcm.ActionInserirExecute(Sender: TObject);
begin
  PanelEdits.BringToFront;
  EditNcm.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
  LimparCampos;
end;

procedure TFNcm.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSNcm.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    EditNcm.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
  end;
end;

procedure TFNcm.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSNcm.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TNcmController.Exclui(FDataModule.CDSNcm.FieldByName('ID').AsInteger);
      TNcmController.Consulta(Filtro, Pagina, False);
    end;
  end;
end;

procedure TFNcm.ActionSairExecute(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TFNcm.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  Ncm : TNcmVO;
begin
  Ncm := TNcmVO.Create;
  Ncm.Ncm            := EditNcm.Text;
  Ncm.Descricao      := EditDescricao.Text;
  Ncm.AliquotaPis    := EditAliquotaPIS.Value;
  Ncm.CstPis         := EditCSTPIS.Text;
  Ncm.AliquotaCofins := EditAliquotaCOFINS.Value;
  Ncm.CstCofins      := EditCSTCOFINS.Text;

  if Operacao = 1 then
    TNcmController.Insere(Ncm)
  else if Operacao = 2 then
  begin
  	Ncm.ID := FDataModule.CDSNcm.FieldByName('ID').AsInteger;
    LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
    TNcmController.Altera(Ncm, Filtro, Pagina);
    BtnFiltroRapido.Click;
    Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
    Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
  end;

  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  Grid.SetFocus;
end;

procedure TFNcm.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFNcm.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  EditNcm.SetFocus;
  ActionToolBarGrid.Enabled := False;
  GridParaEdits;
  ActionSalvar.Enabled := False;
  Operacao := 3;
end;

procedure TFNcm.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
    EditCriterioRapido.Text := '*';

  Pagina := 0;
  Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
  TNcmController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;

  if not FDataModule.CDSNcm.IsEmpty then
  begin
    FDataModule.CDSNCM.First;
    Grid.SetFocus;
  end
  else
    EditCriterioRapido.SetFocus;
end;

procedure TFNcm.ActionFiltrarExecute(Sender: TObject);
var
  Ncm : TNcmVO;
  I : Integer;
begin
  Filtro := '';
  Ncm := TNcmVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSNcm;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TNcmController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFNcm.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSNcm.First;
end;

procedure TFNcm.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSNcm.Last;
end;

procedure TFNcm.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSNcm.Prior;
end;

procedure TFNcm.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSNcm.Next;
end;

procedure TFNcm.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TNcmController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFNcm.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TNcmController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFNcm.GridParaEdits;
begin
  EditNcm.Text             := FDataModule.CDSNcm.FieldByName('NCM').AsString;
  EditDescricao.Text       := FDataModule.CDSNcm.FieldByName('DESCRICAO').AsString;
  EditAliquotaPis.Value    := FDataModule.CDSNcm.FieldByName('ALIQUOTA_PIS').AsFloat;
  EditCSTPIS.Text          := FDataModule.CDSNcm.FieldByName('CST_PIS').AsString;
  EditAliquotaCOFINS.Value := FDataModule.CDSNcm.FieldByName('ALIQUOTA_COFINS').AsFloat;
  EditCSTCOFINS.Text       := FDataModule.CDSNcm.FieldByName('CST_COFINS').AsString;
end;

procedure TFNcm.LimparCampos;
begin
  EditNcm.Clear;
  EditDescricao.Clear;
  EditAliquotaPis.Clear;
  EditCSTPIS.Clear;
  EditAliquotaCOFINS.Clear;
  EditCSTCOFINS.Clear;
end;

procedure TFNcm.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSNcm.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFNcm.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    FDataModule.CDSNcm.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSNcm.IndexDefs.Update;
    FDataModule.CDSNcm.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFNcm.ActionExportarCSVExecute(Sender: TObject);
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

procedure TFNcm.ActionExportarExcelExecute(Sender: TObject);
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

procedure TFNcm.ActionExportarHTMLExecute(Sender: TObject);
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

procedure TFNcm.ActionExportarWordExecute(Sender: TObject);
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

procedure TFNcm.ActionExportarXMLExecute(Sender: TObject);
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

procedure TFNcm.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFNcm.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
