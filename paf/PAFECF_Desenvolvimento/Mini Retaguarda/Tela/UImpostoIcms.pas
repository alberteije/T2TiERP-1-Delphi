{*******************************************************************************
Title: T2Ti ERP
Description: Janela de cadastro do ImpostoIcms

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
unit UImpostoIcms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, JvPageList,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, Rtti, TypInfo, DBCtrls;

type
  TFImpostoIcms = class(TForm)
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
    ComboBoxCampos: TComboBox;
    Label1: TLabel;
    ActionConsultar: TAction;
    EditAliquotaICMS: TJvCalcEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    EditCST_B: TEdit;
    Label5: TLabel;
    EditREDUCAO_BASE_CALCULO: TJvCalcEdit;
    Label9: TLabel;
    EditCST_B_ECF: TEdit;
    Label3: TLabel;
    Label6: TLabel;
    EditALIQUOTA_ICMS_ECF: TJvCalcEdit;
    Label7: TLabel;
    EditTOTALIZADOR_PARCIAL: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    EditECF_ICMS_ST: TEdit;
    EditDESCRICAO: TMemo;
    EditCFOP: TEdit;
    BtnFiltroRapido: TSpeedButton;
    EditTributacao: TComboBox;
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
    procedure ConfiguraGrid;
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
    procedure LimparCampos;
    procedure GridParaEdits;
    procedure EditCFOPKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditECF_ICMS_STKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImpostoIcms: TFImpostoIcms;

implementation

uses
  ImpostoIcmsVO, ImpostoIcmsController, UDataModule, UFiltro, Constantes,
  Biblioteca, ULookup, UMenu, Atributos, CfopController, CfopVO;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFImpostoIcms.FechaFormulario;
begin
    if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFImpostoIcms.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFImpostoIcms.FormCreate(Sender: TObject);
begin
  // Configurar o Grid
  ConfiguraGrid;

  Pagina := 0;
  VerificarPaginacao;
  FDataModule.CDSImpostoIcms.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
  panelgrid.BringToFront;
end;

procedure TFImpostoIcms.ConfiguraGrid;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  I: Integer;

begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(TImpostoIcmsVO);

    //Configura ClientDataset
    FDataModule.CDSImpostoIcms.Close;
    FDataModule.CDSImpostoIcms.FieldDefs.Clear;
    FDataModule.CDSImpostoIcms.IndexDefs.Clear;

    //preenche os nomes dos campos do CDS
    FDataModule.CDSImpostoIcms.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
              FDataModule.CDSImpostoIcms.FieldDefs.add((Atributo as TColumn).Name, ftString, (Atributo as TColumn).Length)
            else
            if Propriedade.PropertyType.TypeKind in [tkFloat] then
              FDataModule.CDSImpostoIcms.FieldDefs.add((Atributo as TColumn).Name, ftFloat)
            else
            if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
              FDataModule.CDSImpostoIcms.FieldDefs.add((Atributo as TColumn).Name, ftInteger)
          end;
        end;
      end;
    end;
    FDataModule.CDSImpostoIcms.CreateDataSet;

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

  finally
    Contexto.Free;

  end;
end;

procedure TFImpostoIcms.EditCFOPKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F1:
    begin
      Application.CreateForm(TFLookup, FLookup);
      ULookup.ObjetoVO := TCfopVO.Create;
      ULookup.ObjetoController := TCfopController.Create;
      ULookup.CampoRetorno1 := 'ID';
      ULookup.CampoRetorno2 := 'CFOP';
      FLookup.ShowModal;
      EditCfop.Text := ULookup.CampoRetorno2;
      //EditNomeSituacaoPessoa.Text := ULookup.CampoRetorno2;
      EditCfop.SetFocus;
    end;
    VK_Return:
    begin
      if not TCfopController.ConsultaPeloCfop(StrToInt(EditCfop.Text)) then
      begin
        Application.MessageBox('Código não existe na tabela de Cfop.', 'Erro', MB_OK + MB_ICONERROR);
        EditCfop.SetFocus;
        exit;
      end;
    end;
  end;
end;

procedure TFImpostoIcms.EditECF_ICMS_STKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_Return:
    if EditTributacao.ItemIndex = 0 then
      EditEcf_Icms_St.Text := StrZero(StrToInt(EditEcf_Icms_St.Text),2,0);
  end;
end;

procedure TFImpostoIcms.ActionInserirExecute(Sender: TObject);
begin
  PanelEdits.BringToFront;
  EditCFOP.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
  LimparCampos;
  EditTributacao.ItemIndex  := 0;  // 'Tributado';
end;

procedure TFImpostoIcms.LimparCampos;
begin
  EditCFOP.Clear;
  EditCST_B.Clear;
  EditAliquotaICMS.Clear;
  EditREDUCAO_BASE_CALCULO.Clear;
  EditCST_B_ECF.Clear;
  EditALIQUOTA_ICMS_ECF.Clear;
  EditTOTALIZADOR_PARCIAL.Clear;
  EditECF_ICMS_ST.Clear;
  EditDESCRICAO.Clear;
end;

procedure TFImpostoIcms.GridParaEdits;
begin
  EditCFOP.Text                 := FDataModule.CDSImpostoIcms.FieldByName('CFOP').AsString;
  EditCST_B.Text                := FDataModule.CDSImpostoIcms.FieldByName('CST_B').AsString;
  EditAliquotaICMS.Text         := FDataModule.CDSImpostoIcms.FieldByName('ALIQUOTA_ICMS').AsString;
  EditREDUCAO_BASE_CALCULO.Text := FDataModule.CDSImpostoIcms.FieldByName('REDUCAO_BASE_CALCULO').AsString;
  EditCST_B_ECF.Text            := FDataModule.CDSImpostoIcms.FieldByName('CST_B_ECF').AsString;

  if FDataModule.CDSImpostoIcms.FieldByName('TIPO_TRIBUTACAO_ECF').AsString = 'T' then
    EditTributacao.ItemIndex  := 0;  // 'Tributado';
  if FDataModule.CDSImpostoIcms.FieldByName('TIPO_TRIBUTACAO_ECF').AsString = 'I' then
    EditTributacao.ItemIndex  := 1;  //   'Isento';
  if FDataModule.CDSImpostoIcms.FieldByName('TIPO_TRIBUTACAO_ECF').AsString = 'F' then
    EditTributacao.ItemIndex  := 2;  //   'Substituido';
  if FDataModule.CDSImpostoIcms.FieldByName('TIPO_TRIBUTACAO_ECF').AsString = 'N' then
    EditTributacao.ItemIndex  := 3;  //   'Não Tributado';

  EditALIQUOTA_ICMS_ECF.Text    := FDataModule.CDSImpostoIcms.FieldByName('ALIQUOTA_ICMS_ECF').AsString;
  EditTOTALIZADOR_PARCIAL.Text  := FDataModule.CDSImpostoIcms.FieldByName('TOTALIZADOR_PARCIAL').AsString;
  EditDESCRICAO.Text            := FDataModule.CDSImpostoIcms.FieldByName('DESCRICAO').AsString;
  EditECF_ICMS_ST.Text          := FDataModule.CDSImpostoIcms.FieldByName('ECF_ICMS_ST').AsString;
end;

procedure TFImpostoIcms.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSImpostoIcms.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    EditCFOP.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
  end;
end;

procedure TFImpostoIcms.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSImpostoIcms.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TImpostoIcmsController.Exclui(FDataModule.CDSImpostoIcms.FieldByName('ID').AsInteger);
      TImpostoIcmsController.Consulta(Filtro, Pagina, False);
    end;
  end;
end;

procedure TFImpostoIcms.ActionSairExecute(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TFImpostoIcms.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  ImpostoIcms : TImpostoIcmsVO;
begin
  ImpostoIcms := TImpostoIcmsVO.Create;
  ImpostoIcms.CFOP                 := StrToInt(EditCFOP.Text);
  ImpostoIcms.CstB                 := EditCST_B.Text;
  ImpostoIcms.AliquotaIcms         := EditAliquotaICMS.Value;
  ImpostoIcms.ReducaoBaseCalculo   := EditREDUCAO_BASE_CALCULO.Value;
  ImpostoIcms.CstBEcf              := EditCST_B_ECF.Text;

  if EditTributacao.ItemIndex = 0 then  // 'Tributado'
    ImpostoIcms.TipoTributacaoEcf  := 'T';
  if EditTributacao.ItemIndex = 1 then  // 'Isento'
    ImpostoIcms.TipoTributacaoEcf  := 'I';
  if EditTributacao.ItemIndex = 2 then  // 'Substituido'
    ImpostoIcms.TipoTributacaoEcf  := 'F';
  if EditTributacao.ItemIndex = 3 then  // 'Não Tributado'
    ImpostoIcms.TipoTributacaoEcf  := 'N';

  ImpostoIcms.AliquotaIcmsEcf      := EditALIQUOTA_ICMS_ECF.Value;
  ImpostoIcms.TotalizadorParcial   := EditTOTALIZADOR_PARCIAL.Text;
  ImpostoIcms.Descricao            := EditDESCRICAO.Text;
  ImpostoIcms.EcfIcmsST            := EditECF_ICMS_ST.Text;

  if Operacao = 1 then
    TImpostoIcmsController.Insere(ImpostoIcms)
  else if Operacao = 2 then
  begin
    ImpostoIcms.ID := FDataModule.CDSImpostoIcms.FieldByName('ID').AsInteger;
    LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
    TImpostoIcmsController.Altera(ImpostoIcms, Filtro, Pagina);
    BtnFiltroRapido.Click;
    Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
    Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
  end;

  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  Grid.SetFocus;
end;

procedure TFImpostoIcms.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFImpostoIcms.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  EditCFOP.SetFocus;
  ActionToolBarGrid.Enabled := False;
  GridParaEdits;
  ActionSalvar.Enabled := False;
  Operacao := 3;
end;

procedure TFImpostoIcms.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
    EditCriterioRapido.Text := '*';

  Pagina := 0;
  Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
  TImpostoIcmsController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;

  if not FDataModule.CDSImpostoIcms.IsEmpty then
  begin
    FDataModule.CDSImpostoIcms.First;
    Grid.SetFocus;
  end
  else
    EditCriterioRapido.SetFocus;
end;

procedure TFImpostoIcms.ActionFiltrarExecute(Sender: TObject);
var
  ImpostoIcms : TImpostoIcmsVO;
  I : Integer;
begin
  Filtro := '';
  ImpostoIcms := TImpostoIcmsVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSImpostoIcms;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TImpostoIcmsController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFImpostoIcms.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSImpostoIcms.First;
end;

procedure TFImpostoIcms.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSImpostoIcms.Last;
end;

procedure TFImpostoIcms.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSImpostoIcms.Prior;
end;

procedure TFImpostoIcms.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSImpostoIcms.Next;
end;

procedure TFImpostoIcms.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TImpostoIcmsController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFImpostoIcms.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TImpostoIcmsController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFImpostoIcms.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSImpostoIcms.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFImpostoIcms.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    FDataModule.CDSImpostoIcms.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSImpostoIcms.IndexDefs.Update;
    FDataModule.CDSImpostoIcms.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFImpostoIcms.ActionExportarCSVExecute(Sender: TObject);
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

procedure TFImpostoIcms.ActionExportarExcelExecute(Sender: TObject);
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

procedure TFImpostoIcms.ActionExportarHTMLExecute(Sender: TObject);
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

procedure TFImpostoIcms.ActionExportarWordExecute(Sender: TObject);
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

procedure TFImpostoIcms.ActionExportarXMLExecute(Sender: TObject);
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

procedure TFImpostoIcms.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFImpostoIcms.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
