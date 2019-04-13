{*******************************************************************************
Title: T2Ti ERP
Description: Janela Padrão

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
           fabio_thz@yahoo.com.br | t2ti.com@gmail.com</p>

@author Fábio Thomaz | Albert Eije (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit UTela;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UBase, StdCtrls, Buttons, Grids, DBGrids, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid, ToolWin, ActnMan, ActnCtrls, ExtCtrls, ScreenTips, ActnList,
  RibbonSilverStyleActnCtrls, ComCtrls, JvExControls, JvArrowButton, Rtti,
  DB, DBClient, Menus, Tipos,  Atributos, TypInfo, UFiltro;

const
  TagBotao: array [Boolean] of Integer = (0, 1);

type
  TPanelExibir = (peGrid, peEdits);

  TClasseObjetoGridVO = class of TObject;

  TFTela = class(TFBase)
    PanelEdits: TPanel;
    PanelGrid: TPanel;
    Grid: TJvDBUltimGrid;
    PanelFiltroRapido: TPanel;
    BotaoConsultar: TSpeedButton;
    LabelCampoFiltro: TLabel;
    EditCriterioRapido: TLabeledEdit;
    ComboBoxCampos: TComboBox;
    PageControl: TPageControl;
    PaginaGrid: TTabSheet;
    PaginaEdits: TTabSheet;
    PanelToolBarGrid: TPanel;
    BotaoPaginaAnterior: TSpeedButton;
    BotaoPrimeiroRegistro: TSpeedButton;
    BotaoRegistroAnterior: TSpeedButton;
    BotaoProximoRegistro: TSpeedButton;
    BotaoUltimoRegistro: TSpeedButton;
    BotaoProximaPagina: TSpeedButton;
    BotaoSeparador1: TSpeedButton;
    BotaoFiltrar: TSpeedButton;
    BotaoExportar: TSpeedButton;
    BotaoImprimir: TSpeedButton;
    BotaoSair: TSpeedButton;
    PopupMenuExportar: TPopupMenu;
    menuParaWord: TMenuItem;
    menuParaExcel: TMenuItem;
    menuParaXML: TMenuItem;
    menuParaCSV: TMenuItem;
    menuParaHTML: TMenuItem;
    BotaoSeparador2: TSpeedButton;
    BotaoSeparador3: TSpeedButton;
    PanelToolBarEdits: TPanel;
    CDSGrid: TClientDataSet;
    DSGrid: TDataSource;
    BotaoSeparador4: TSpeedButton;
    procedure menuParaWordClick(Sender: TObject);
    procedure menuParaExcelClick(Sender: TObject);
    procedure menuParaXMLClick(Sender: TObject);
    procedure menuParaCSVClick(Sender: TObject);
    procedure menuParaHTMLClick(Sender: TObject);
    procedure BotaoPaginaAnteriorClick(Sender: TObject);
    procedure BotaoProximaPaginaClick(Sender: TObject);
    procedure BotaoPrimeiroRegistroClick(Sender: TObject);
    procedure BotaoProximoRegistroClick(Sender: TObject);
    procedure BotaoRegistroAnteriorClick(Sender: TObject);
    procedure BotaoUltimoRegistroClick(Sender: TObject);
    procedure BotaoConsultarClick(Sender: TObject);
    procedure CDSGridAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BotaoSairClick(Sender: TObject);
    procedure BotaoExportarClick(Sender: TObject);
    procedure BotaoFiltrarClick(Sender: TObject);
    procedure BotaoImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure AlteraTagBotoes;
  public
    { Public declarations }
    Operacao:Integer; //1-Inserir | 2-Alterar
    Filtro: String;
    Pagina: Integer;
    Lookup : Boolean;
    ClasseObjetoGridVO: TClasseObjetoGridVO;
    ObjetoController: TObject;
    ObjetoVO: TOBject;
    PanelVisivel: TPanelExibir;

    //Paginação e Navegação
    procedure ControlaBotoes; virtual;
    procedure ControlaBotoesNavegacao;
    procedure ControlaBotoesNavegacaoPagina;

    //Grid e Edits
    procedure ExibePanel(pPanelExibir: TPanelExibir);
    procedure ConfiguraGrid;
    procedure LimparCampos; virtual;
    procedure GridParaEdits; virtual;
    function IdRegistroSelecionado: Integer;
    function BotaoHabilitado(pBotao: TSpeedButton): Boolean;
  published
    procedure GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields;
      SortString: string; var SortOK: Boolean);
  end;

var
  FTela: TFTela;

implementation


uses Constantes, UDataModule;

{$R *.dfm}

{ TFCadastro }

procedure TFTela.AlteraTagBotoes;
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TSpeedButton then
    begin
      (Self.Components[I] as TSpeedButton).Tag := -1;
    end;
  end;
end;

procedure TFTela.FormCreate(Sender: TObject);
begin
  inherited;

  AlteraTagBotoes;

  ExibePanel(peGrid);

  IconeBotao(BotaoConsultar,iConsultar,siHabilitada,ti16);
  IconeBotao(BotaoFiltrar,iLocalizar,siHabilitada,ti16);
  IconeBotao(BotaoSair,iSair,siHabilitada,ti16);

  BotaoConsultar.Flat := True;
  BotaoFiltrar.Flat := True;
  BotaoExportar.Flat := True;
  BotaoImprimir.Flat := True;
  BotaoSair.Flat := True;

  BotaoPaginaAnterior.Flat := True;
  BotaoPrimeiroRegistro.Flat := True;
  BotaoRegistroAnterior.Flat := True;
  BotaoProximoRegistro.Flat := True;
  BotaoUltimoRegistro.Flat := True;
  BotaoProximaPagina.Flat := True;


  ConfiguraGrid;
  {TODO: Verificar necessidade dessa linha de comando, criar Classe TControle}
 // ObjetoController.SetDataSet(CDSGrid);

  Pagina := 0;
  ControlaBotoesNavegacao;
  ControlaBotoesNavegacaoPagina;
end;

procedure TFTela.FormDestroy(Sender: TObject);
begin
  if Assigned(ObjetoController) then
    ObjetoController.Free;
  if Assigned(ObjetoVO) then
    ObjetoVO.Free;

  inherited;
end;

procedure TFTela.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F5: BotaoFiltrarClick(Sender);
    VK_F6: BotaoExportarClick(Sender);
    VK_F7: BotaoImprimirClick(Sender);
    VK_F8: BotaoSairClick(Sender);
    VK_F9: BotaoConsultarClick(Sender);
  end;
end;

procedure TFTela.FormShow(Sender: TObject);
begin
  inherited;

  if ComboBoxCampos.CanFocus then
    ComboBoxCampos.SetFocus;
end;

{$REGION 'Grid e Edits'}
procedure TFTela.ExibePanel(pPanelExibir: TPanelExibir);
begin
  PanelVisivel := pPanelExibir;

  case pPanelExibir of
    peGrid:
      begin
        PanelEdits.Visible := False;
        PanelGrid.Parent := Self;
        PanelGrid.Visible := True;
      end;
    peEdits:
      begin
        PanelGrid.Visible := False;
        PanelEdits.Parent := Self;
        PanelEdits.Visible := True;
      end;
  end;
end;

procedure TFTela.GridParaEdits;
begin
  //Deve ser implementado nos formulários filhos
end;

procedure TFTela.GridUserSort(Sender: TJvDBUltimGrid;
  var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
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
    CDSGrid.AddIndex(IxDName, Fields, [], DescFields);
    CDSGrid.IndexDefs.Update;
    CDSGrid.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

function TFTela.IdRegistroSelecionado: Integer;
begin
  if CDSGrid.IsEmpty then
    Result := 0
  else
    Result := CDSGrid.FieldByName('ID').AsInteger;
end;

procedure TFTela.LimparCampos;
begin
  //Deve ser implementado nos formulários filhos
end;
{$ENDREGION}

{$REGION 'Exportações'}
procedure TFTela.menuParaCSVClick(Sender: TObject);
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

procedure TFTela.menuParaExcelClick(Sender: TObject);
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

procedure TFTela.menuParaHTMLClick(Sender: TObject);
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

procedure TFTela.menuParaWordClick(Sender: TObject);
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

procedure TFTela.menuParaXMLClick(Sender: TObject);
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

{$ENDREGION}

{$REGION 'Paginação e Navegação'}
procedure TFTela.BotaoConsultarClick(Sender: TObject);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
begin
  if Trim(EditCriterioRapido.Text) = '' then
    EditCriterioRapido.Text := '*';

  Pagina := 0;
  Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] +
    ' LIKE "*' + EditCriterioRapido.Text + '*"';

  Contexto := TRttiContext.Create;
  try
    Tipo := Contexto.GetType(ObjetoController.ClassType);
    Tipo.GetMethod('Consulta').Invoke(ObjetoController.ClassType, [Trim(Filtro), Pagina, Lookup]);
    ControlaBotoesNavegacaoPagina;
  finally
    Contexto.Free;
  end;
end;

procedure TFTela.BotaoExportarClick(Sender: TObject);
begin
  if BotaoHabilitado(BotaoExportar) then
  begin
    PopupMenuExportar.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
  end;
end;

procedure TFTela.BotaoFiltrarClick(Sender: TObject);
var
  I : Integer;
  Contexto: TRttiContext;
  Tipo: TRttiType;
begin
  if BotaoHabilitado(BotaoFiltrar) then
  begin
    Filtro := '';
    Application.CreateForm(TFFiltro, FFiltro);
    FFiltro.QuemChamou := Self.Name;
    FFiltro.CDSUtilizado := CDSGrid;
    try
      if (FFiltro.ShowModal = MROK) then
      begin
        for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
          Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
        if Trim(Filtro) <> '' then
        begin
          Contexto := TRttiContext.Create;
          try
            Tipo := Contexto.GetType(ObjetoController.ClassType);
            Tipo.GetMethod('Consulta').Invoke(ObjetoController.ClassType, [Trim(Filtro), Pagina]);
            ControlaBotoesNavegacaoPagina;
          finally
            Contexto.Free;
          end;
        end;
      end;
    finally
      Pagina := 0;
      ControlaBotoesNavegacao;
      ControlaBotoesNavegacaoPagina;

      if Assigned(FFiltro) then
        FFiltro.Free;
    end;
  end;
end;

function TFTela.BotaoHabilitado(pBotao: TSpeedButton): Boolean;
begin
  //Tag = 0 -> Botão Desabilitado
  Result := (pBotao.Tag <> 0);

  //Se tiver habilitado verifica aba
  if Result then
  begin
    if (pBotao.Parent = PanelToolBarEdits) and (PanelVisivel <> peEdits) then
      Result := False
    else
    if (pBotao.Parent = PanelToolBarGrid) and (PanelVisivel <> peGrid) then
      Result := False;
  end;
end;

procedure TFTela.BotaoImprimirClick(Sender: TObject);
begin
  if BotaoHabilitado(BotaoImprimir) then
  begin
    //
  end;
end;

procedure TFTela.BotaoPaginaAnteriorClick(Sender: TObject);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
begin
  if BotaoPaginaAnterior.Tag = 1 then
  begin
    try
      Contexto := TRttiContext.Create;
      Tipo := Contexto.GetType(ObjetoController.ClassType);

      Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
      Tipo.GetMethod('Consulta').Invoke(ObjetoController.ClassType, [Trim(Filtro), Pagina]);
      ControlaBotoesNavegacaoPagina;
    finally
      Contexto.Free;
    end;
  end;
end;

procedure TFTela.BotaoProximaPaginaClick(Sender: TObject);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
begin
  if BotaoProximaPagina.Tag = 1 then
  begin
    try
      Contexto := TRttiContext.Create;
      Tipo := Contexto.GetType(ObjetoController.ClassType);

      Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
      Tipo.GetMethod('Consulta').Invoke(ObjetoController.ClassType, [Trim(Filtro), Pagina]);
      ControlaBotoesNavegacaoPagina;
    finally
      Contexto.Free;
    end;
  end;
end;

procedure TFTela.BotaoPrimeiroRegistroClick(Sender: TObject);
begin
  CDSGrid.First;
end;

procedure TFTela.BotaoProximoRegistroClick(Sender: TObject);
begin
  CDSGrid.Next;
end;

procedure TFTela.BotaoRegistroAnteriorClick(Sender: TObject);
begin
  CDSGrid.Prior;
end;

procedure TFTela.BotaoSairClick(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TFTela.BotaoUltimoRegistroClick(Sender: TObject);
begin
  CDSGrid.Last;
end;

procedure TFTela.CDSGridAfterScroll(DataSet: TDataSet);
begin
  if not CDSGrid.ControlsDisabled then
  begin
    ControlaBotoesNavegacao;
  end;
end;

procedure TFTela.ConfiguraGrid;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  I: Integer;
begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(ClasseObjetoGridVO);

    //Configura ClientDataset
    CDSGrid.Close;
    CDSGrid.FieldDefs.Clear;
    CDSGrid.IndexDefs.Clear;

    //preenche os nomes dos campos do CDS
    CDSGrid.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
              CDSGrid.FieldDefs.add((Atributo as TColumn).Name, ftString, (Atributo as TColumn).length)
            else
            if Propriedade.PropertyType.TypeKind in [tkFloat] then
              CDSGrid.FieldDefs.add((Atributo as TColumn).Name, ftFloat)
            else
            if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
              CDSGrid.FieldDefs.add((Atributo as TColumn).Name, ftInteger)
          end;
        end;
      end;
    end;
    CDSGrid.CreateDataSet;

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

    CDSGrid.GetFieldNames(ComboBoxCampos.Items);
    ComboBoxCampos.ItemIndex := 1;

    //ComboBoxCampos.SetFocus;
  finally
    Contexto.Free;
  end;
end;

procedure TFTela.ControlaBotoes;
var
  NovaTag: Integer;
begin
  //Também será implementado nos forms filhos

  //Botão Exportar
  NovaTag := TagBotao[not CDSGrid.IsEmpty];
  if NovaTag <> BotaoExportar.Tag then
  begin
    BotaoExportar.Tag := NovaTag;
    IconeBotao(BotaoExportar,iExportar,TStatusImagem(NovaTag),ti16);
  end;

  //Botão Imprimir
  NovaTag := TagBotao[not CDSGrid.IsEmpty];
  if NovaTag <> BotaoImprimir.Tag then
  begin
    BotaoImprimir.Tag := NovaTag;
    IconeBotao(BotaoImprimir,iImprimir,TStatusImagem(NovaTag),ti16);
  end;
end;

procedure TFTela.ControlaBotoesNavegacao;
var
  NovaTag: Integer;
begin
  //Botão Registro Anterior
  NovaTag := TagBotao[CDSGrid.RecNo > 1];
  if NovaTag <> BotaoRegistroAnterior.Tag then
  begin
    BotaoRegistroAnterior.Tag := NovaTag;
    IconeBotao(BotaoRegistroAnterior,iAnterior,TStatusImagem(NovaTag),ti16);
  end;

  //Botão Primeiro Registro
  NovaTag := TagBotao[CDSGrid.RecNo > 1];
  if NovaTag <> BotaoPrimeiroRegistro.Tag then
  begin
    BotaoPrimeiroRegistro.Tag := NovaTag;
    IconeBotao(BotaoPrimeiroRegistro,iPrimeiro,TStatusImagem(NovaTag),ti16);
  end;

  //Botão Proximo Registro
  NovaTag := TagBotao[(CDSGrid.RecNo < CDSGrid.RecordCount) and (CDSGrid.RecNo >= 0)];
  if NovaTag <> BotaoProximoRegistro.Tag then
  begin
    BotaoProximoRegistro.Tag := NovaTag;
    IconeBotao(BotaoProximoRegistro,iProximo,TStatusImagem(NovaTag),ti16);
  end;

  //Botão Ultimo Registro
  NovaTag := TagBotao[(CDSGrid.RecNo < CDSGrid.RecordCount) and (CDSGrid.RecNo >= 0)];
  if NovaTag <> BotaoUltimoRegistro.Tag then
  begin
    BotaoUltimoRegistro.Tag := NovaTag;
    IconeBotao(BotaoUltimoRegistro,iUltimo,TStatusImagem(NovaTag),ti16);
  end;

  ControlaBotoes;
end;

procedure TFTela.ControlaBotoesNavegacaoPagina;
var
  NovaTag: Integer;
begin
  //Botão Pagina Anterior
  NovaTag := TagBotao[(Pagina > 0)];
  if NovaTag <> BotaoPaginaAnterior.Tag then
  begin
    BotaoPaginaAnterior.Tag := NovaTag;
    IconeBotao(BotaoPaginaAnterior,iPaginaAnterior,TStatusImagem(NovaTag),ti16);
  end;

  //Botão Proxima Página
  NovaTag := TagBotao[CDSGrid.RecordCount >= TConstantes.QUANTIDADE_POR_PAGINA];
  if NovaTag <> BotaoProximaPagina.Tag then
  begin
    BotaoProximaPagina.Tag := NovaTag;
    IconeBotao(BotaoProximaPagina,iProximaPagina,TStatusImagem(NovaTag),ti16);
  end;

  ControlaBotoesNavegacao;
end;
{$ENDREGION}

end.
