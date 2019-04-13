{ *******************************************************************************
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

  @author Fábio Thomaz | Albert Eije (T2Ti.COM) | Fernando Lucio de Oliveira
  @version 1.0
  ******************************************************************************* }
unit UTela;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UBase, StdCtrls, Buttons, Grids, DBGrids, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid, ToolWin, ActnMan, ActnCtrls, ExtCtrls, ScreenTips, ActnList,
  RibbonSilverStyleActnCtrls, ComCtrls, JvExControls, JvArrowButton, Rtti,
  Controller, DB, DBClient, Menus, Tipos, JSonVO, Atributos, TypInfo, UFiltro, LabeledCtrls;

type
  TClasseObjetoGridVO = class of TJSonVO;

  TItemComboBox = class
  private
    FDescricao: string;
    FCampo: string;
  public
    property Campo: string read FCampo write FCampo;
    property Descricao: string read FDescricao write FDescricao;
  end;

  TFTela = class(TFBase)
    PanelGrid: TPanel;
    Grid: TJvDBUltimGrid;
    PanelFiltroRapido: TPanel;
    PageControl: TPageControl;
    PaginaGrid: TTabSheet;
    PopupMenuExportar: TPopupMenu;
    menuParaWord: TMenuItem;
    menuParaExcel: TMenuItem;
    menuParaXML: TMenuItem;
    menuParaCSV: TMenuItem;
    menuParaHTML: TMenuItem;
    PanelToolBar: TPanel;
    BotaoSair: TSpeedButton;
    PanelNavegacao: TPanel;
    BotaoPaginaAnterior: TSpeedButton;
    BotaoPrimeiroRegistro: TSpeedButton;
    BotaoRegistroAnterior: TSpeedButton;
    BotaoProximoRegistro: TSpeedButton;
    BotaoUltimoRegistro: TSpeedButton;
    BotaoProximaPagina: TSpeedButton;
    BotaoExportar: TSpeedButton;
    BotaoImprimir: TSpeedButton;
    BotaoSeparador1: TSpeedButton;
    PopupMenuAtalhosBotoesTela: TPopupMenu;
    menuSair: TMenuItem;
    menuImprimir: TMenuItem;
    menuExportar: TMenuItem;
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
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BotaoSairClick(Sender: TObject);
    procedure BotaoExportarClick(Sender: TObject);
    procedure BotaoImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure AlteraTagBotoes;
    procedure AlteraTagPopupMenu;

  public
    { Public declarations }
    Filtro: string;
    Pagina: Integer;
    ClasseObjetoGridVO: TClasseObjetoGridVO;
    ObjetoController: TController;
    ObjetoVO: TJSonVO;
    ObjetoOldVO: TJSonVO;
    PanelVisivel: TPanelExibir;
    ControllerTransiente, ControllerGenerico: TController;
    VOTransiente: TJsonVO;
    CDSTransiente, CDSConsultaGenerica: TClientDataSet;

    function VO<T: class>: T;

    // Paginação e Navegação
    procedure ControlaBotoes; virtual;

    procedure ControlaPopupMenu; virtual;
    function PopupMenuHabilitado(pMenu: TMenuItem): Boolean;

    procedure ControlaBotoesNavegacao; virtual;
    procedure ControlaBotoesNavegacaoPagina; virtual;

    // Grid e Edits
    procedure ExibePanel(pPanelExibir: TPanelExibir); virtual;
    procedure ConfiguraGrid;
    procedure LimparCampos; virtual;
    procedure GridParaEdits; virtual;
    function IdRegistroSelecionado: Integer;

    function BotaoHabilitado(pBotao: TSpeedButton): Boolean;

    function MontaFiltro: string; virtual;
    procedure PopulaComboBoxComVO(pComboBox: TCustomCombo; pVO: TJSonVO);
  published
    CDSGrid: TClientDataSet;
    DSGrid: TDataSource;
    procedure CDSGridAfterScroll(DataSet: TDataSet); virtual;
    procedure GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
  end;

var
  FTela: TFTela;

implementation

uses Constantes, UDataModule, Biblioteca;
{$R *.dfm}
{ TFCadastro }

{$REGION 'Infra'}
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

  // Gria DataSet e DataSource
  CDSGrid := TClientDataSet.Create(Self);
  DSGrid := TDataSource.Create(Self);
  DSGrid.DataSet := CDSGrid;
  Grid.DataSource := DSGrid;
  CDSGrid.AfterScroll := CDSGridAfterScroll;
  CDSTransiente:= TClientDataSet.Create(Self);
  CDSConsultaGenerica:= TClientDataSet.Create(Self);

  AlteraTagBotoes;

  AlteraTagPopupMenu;
  ExibePanel(peGrid);

  IconeBotao(BotaoSair, iSair, siHabilitada, ti16);

  IconePopupMenu(menuSair, iSair, siHabilitada, ti16);
  IconePopupMenu(menuExportar, iExportar, siHabilitada, ti16);
  IconePopupMenu(menuImprimir, iImprimir, siHabilitada, ti16);

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

  Pagina := 0;
  ControlaBotoesNavegacao;
  ControlaBotoesNavegacaoPagina;
end;

procedure TFTela.FormDestroy(Sender: TObject);
begin
  if Assigned(ObjetoController) then
    ObjetoController.Free;
  if Assigned(ObjetoVO) then
    FreeAndNil(ObjetoVO);
  if Assigned(ObjetoOldVO) then
    FreeAndNil(ObjetoOldVO);

  inherited;
end;

function TFTela.MontaFiltro: string;
begin
  Result := '';
end;

procedure TFTela.PopulaComboBoxComVO(pComboBox: TCustomCombo; pVO: TJSonVO);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  Item: TItemComboBox;
  Idx, I : Integer;
begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(pVO.ClassType);

    while pComboBox.Items.Count > 0 do
    begin
      Item := TItemComboBox(pComboBox.Items.Objects[0]);
      Item.Free;
      pComboBox.Items.Delete(0);
    end;
    // Código adaptado por Fernando Lúcio Oliveira
    Idx := 0;

    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TId then
        begin
          Item := TItemComboBox.Create;
          Item.Campo := 'ID';
          Item.Descricao := 'ID';
          pComboBox.AddItem(Item.Descricao, Item);
          // Código adaptado por Fernando Lúcio Oliveira
          I := 0;
        end
        else if Atributo is Atributos.TColumn then
        begin
          if (Atributo as TColumn).LocalDisplayContainsOneTheseItems([ldComboBox]) then
          begin
            // Código adaptado por Fernando Lúcio Oliveira
            I := I + 1;
            Item := TItemComboBox.Create;
            Item.Campo := (Atributo as Atributos.TColumn).Name;
            Item.Descricao := (Atributo as Atributos.TColumn).Caption;
            pComboBox.AddItem(Item.Descricao, Item);
            // Código adaptado por Fernando Lúcio Oliveira
            if Item.Campo = 'NOME' then
              Idx := I
            else if (Item.Campo = 'DESCRICAO') and (Idx = 0) then
              Idx := I;
          end;
        end;
      end;
    end;
  finally
    Contexto.Free;
    // Código adaptado por Fernando Lúcio Oliveira
    pComboBox.ItemIndex := Idx;
  end;
end;

function TFTela.PopupMenuHabilitado(pMenu: TMenuItem): Boolean;
begin
  // Tag = 0 -> PopupMenuItem Desabilitado
  Result := (pMenu.Tag <> 0);

  if Result then
  begin
    Result := (pMenu.Visible and pMenu.Enabled);
  end;
end;

function TFTela.VO<T>: T;
begin
  if Assigned(ObjetoVO) then
    Result := T(ObjetoVO);
end;

procedure TFTela.AlteraTagPopupMenu;
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TMenuItem then
    begin (Self.Components[I] as TMenuItem)
      .Tag := -1;
    end;
  end;
end;

procedure TFTela.BotaoExportarClick(Sender: TObject);
begin
  if BotaoHabilitado(BotaoExportar) then
  begin
    PopupMenuExportar.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  end;
end;

function TFTela.BotaoHabilitado(pBotao: TSpeedButton): Boolean;
begin
  // Tag = 0 -> Botão Desabilitado
  Result := (pBotao.Tag <> 0);

  if Result then
  begin
    Result := (pBotao.Visible and pBotao.Enabled);
  end;
end;

procedure TFTela.BotaoImprimirClick(Sender: TObject);
var
  RemoteDataInfo: TStringList;
  ConsultaSQL, OrderBy, FiltroLocal, TabelaPrincipal, ElementoSelecionado, NomeArquivo: String;
  i: Integer;
begin
  if BotaoHabilitado(BotaoImprimir) then
  begin
    try
      try
        NomeArquivo := Copy(Self.ClassName, 3, Length(Self.ClassName)) +'.rep';

        FDataModule.VCLReport.GetRemoteParams(Sessao.ServidorImpressao.Servidor, Sessao.ServidorImpressao.Porta, Sessao.ServidorImpressao.Usuario, Sessao.ServidorImpressao.Senha, Sessao.ServidorImpressao.Alias, NomeArquivo);
        FDataModule.VCLReport.Report.Params.ParamByName('TITULORELATORIO').Value := 'Relatório - ' + Self.Caption;
        FDataModule.VCLReport.Report.Params.ParamByName('TITULOSOFTHOUSE').Value := 'T2Ti.COM';
        FDataModule.VCLReport.Report.Params.ParamByName('TITULORODAPE').Value := 'T2Ti Tecnologia da Informação Ltda. - (61)3042.5277';
        //
        FDataModule.VCLReport.GetRemoteDataInfo(Sessao.ServidorImpressao.Servidor, Sessao.ServidorImpressao.Porta, Sessao.ServidorImpressao.Usuario, Sessao.ServidorImpressao.Senha, Sessao.ServidorImpressao.Alias, NomeArquivo);
        RemoteDataInfo := FDataModule.VCLReport.Report.RemoteDataInfo;
        //
        ConsultaSQL := '';

        FiltroLocal := Filtro;
        FiltroLocal := StringReplace(FiltroLocal, '*', '%', [rfReplaceAll]);
        FiltroLocal := StringReplace(FiltroLocal, '[', '', [rfReplaceAll]);
        FiltroLocal := StringReplace(FiltroLocal, ']', '', [rfReplaceAll]);
        for i := 1 to RemoteDataInfo.Count - 1 do
        begin
          ElementoSelecionado := RemoteDataInfo[i];
          ElementoSelecionado := LowerCase(ElementoSelecionado);
          //
          if trim(Copy(ElementoSelecionado, 1, 8)) <> 'order by' then
            ConsultaSQL := ConsultaSQL + ' ' + ElementoSelecionado
          else
            OrderBy := ' ' + ElementoSelecionado;
          //
          if trim(Copy(ElementoSelecionado, 1, 4)) = 'from' then
          begin
            System.Delete(ElementoSelecionado, 1, 5);
            TabelaPrincipal := Trim(ElementoSelecionado);
            if Pos(' ', TabelaPrincipal) > 0 then
              TabelaPrincipal := Trim(Copy(TabelaPrincipal, Pos(' ', TabelaPrincipal) + 1, Length(TabelaPrincipal)));
          end;
        end;
        if UpperCase(Copy(FiltroLocal, 1, 7)) = 'EXTRACT' then
          ConsultaSQL := ConsultaSQL + ' WHERE ' + FiltroLocal + OrderBy
        else
          ConsultaSQL := ConsultaSQL + ' WHERE ' + TabelaPrincipal + '.' + FiltroLocal + OrderBy;

        FDataModule.VCLReport.ExecuteRemote(Sessao.ServidorImpressao.Servidor, Sessao.ServidorImpressao.Porta, Sessao.ServidorImpressao.Usuario, Sessao.ServidorImpressao.Senha, Sessao.ServidorImpressao.Alias, NomeArquivo, ConsultaSQL);
      except
        on E: Exception do
          Application.MessageBox(PChar('Ocorreu um erro na construção do relatório. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
      end;
    finally
    end;
  end;
end;

procedure TFTela.ConfiguraGrid;
begin
  ConfiguraCDSFromVO(CDSGrid, ClasseObjetoGridVO);
  ConfiguraGridFromVO(Grid, ClasseObjetoGridVO);
end;

procedure TFTela.FormShow(Sender: TObject);
begin
  inherited;
end;
{$ENDREGION}

{$REGION 'Grid e Edits'}
procedure TFTela.ExibePanel(pPanelExibir: TPanelExibir);
begin
  PanelVisivel := pPanelExibir;

  if pPanelExibir = peGrid then
  begin
    PanelGrid.Parent := Self;
    PanelGrid.Visible := True;
  end
  else
  begin
    PanelGrid.Visible := False;
  end;
end;

procedure TFTela.GridParaEdits;
begin
  LimparCampos;
  // Deve ser implementado nos formulários filhos
end;

procedure TFTela.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
var
  IxDName: string;
  I: Integer;
  Fields, DescFields: string;
begin
  try
    Fields := '';
    DescFields := '';
    for I := 0 to Length(FieldsToSort) - 1 do
    begin
      Fields := Fields + FieldsToSort[I].Name + ';';
      if not FieldsToSort[I].Order then
        DescFields := DescFields + FieldsToSort[I].Name + ';';
    end;
    Fields := Copy(Fields, 1, Length(Fields) - 1);
    DescFields := Copy(DescFields, 1, Length(DescFields) - 1);

    IxDName := IntToStr(Length(FieldsToSort)) + '_' + FormatDateTime('hhmmssz', Now);
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
var
  I: Integer;
begin
  if Assigned(ObjetoVO) then
    FreeAndNil(ObjetoVO);
  if Assigned(ObjetoOldVO) then
    FreeAndNil(ObjetoOldVO);

  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TLabeledEdit) then
      (Components[I] as TLabeledEdit).Text := '';
    if (Components[I] is TMemo) then
      (Components[I] as TMemo).Lines.Clear;
    if (Components[I] is TLabeledCalcEdit) then
      (Components[I] as TLabeledCalcEdit).Value := 0;
    if (Components[I] is TLabeledMaskEdit) then
      (Components[I] as TLabeledMaskEdit).Text := '';
    if (Components[I] is TLabeledDateEdit) then
      (Components[I] as TLabeledDateEdit).Clear;
  end;
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
      ObjetoController.SetDataSet(CDSGrid);
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
      ObjetoController.SetDataSet(CDSGrid);
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

procedure TFTela.ControlaBotoes;
var
  NovaTag: Integer;
begin
  // Também será implementado nos forms filhos

  // Botão Exportar
  NovaTag := TConstantes.TagBotao[not CDSGrid.IsEmpty];
  if NovaTag <> BotaoExportar.Tag then
  begin
    BotaoExportar.Tag := NovaTag;
    IconeBotao(BotaoExportar, iExportar, TStatusImagem(NovaTag), ti16);
  end;

  // Botão Imprimir
  NovaTag := TConstantes.TagBotao[not CDSGrid.IsEmpty];
  if NovaTag <> BotaoImprimir.Tag then
  begin
    BotaoImprimir.Tag := NovaTag;
    IconeBotao(BotaoImprimir, iImprimir, TStatusImagem(NovaTag), ti16);
  end;
end;

procedure TFTela.ControlaBotoesNavegacao;
var
  NovaTag: Integer;
begin
  // Botão Registro Anterior
  NovaTag := TConstantes.TagBotao[CDSGrid.RecNo > 1];
  if NovaTag <> BotaoRegistroAnterior.Tag then
  begin
    BotaoRegistroAnterior.Tag := NovaTag;
    IconeBotao(BotaoRegistroAnterior, iAnterior, TStatusImagem(NovaTag), ti16);
  end;

  // Botão Primeiro Registro
  NovaTag := TConstantes.TagBotao[CDSGrid.RecNo > 1];
  if NovaTag <> BotaoPrimeiroRegistro.Tag then
  begin
    BotaoPrimeiroRegistro.Tag := NovaTag;
    IconeBotao(BotaoPrimeiroRegistro, iPrimeiro, TStatusImagem(NovaTag), ti16);
  end;

  // Botão Proximo Registro
  NovaTag := TConstantes.TagBotao[(CDSGrid.RecNo < CDSGrid.RecordCount) and (CDSGrid.RecNo >= 0)];
  if NovaTag <> BotaoProximoRegistro.Tag then
  begin
    BotaoProximoRegistro.Tag := NovaTag;
    IconeBotao(BotaoProximoRegistro, iProximo, TStatusImagem(NovaTag), ti16);
  end;

  // Botão Ultimo Registro
  NovaTag := TConstantes.TagBotao[(CDSGrid.RecNo < CDSGrid.RecordCount) and (CDSGrid.RecNo >= 0)];
  if NovaTag <> BotaoUltimoRegistro.Tag then
  begin
    BotaoUltimoRegistro.Tag := NovaTag;
    IconeBotao(BotaoUltimoRegistro, iUltimo, TStatusImagem(NovaTag), ti16);
  end;

  ControlaBotoes;
  ControlaPopupMenu;
end;

procedure TFTela.ControlaBotoesNavegacaoPagina;
var
  NovaTag: Integer;
begin
  // Botão Pagina Anterior
  NovaTag := TConstantes.TagBotao[(Pagina > 0)];
  if NovaTag <> BotaoPaginaAnterior.Tag then
  begin
    BotaoPaginaAnterior.Tag := NovaTag;
    IconeBotao(BotaoPaginaAnterior, iPaginaAnterior, TStatusImagem(NovaTag), ti16);
  end;

  // Botão Proxima Página
  NovaTag := TConstantes.TagBotao[CDSGrid.RecordCount >= TConstantes.QUANTIDADE_POR_PAGINA];
  if NovaTag <> BotaoProximaPagina.Tag then
  begin
    BotaoProximaPagina.Tag := NovaTag;
    IconeBotao(BotaoProximaPagina, iProximaPagina, TStatusImagem(NovaTag), ti16);
  end;

  ControlaBotoesNavegacao;
end;

procedure TFTela.ControlaPopupMenu;
var
  NovaTag: Integer;
begin
  // Também será implementado nos forms filhos

  // Botão Exportar
  NovaTag := TConstantes.TagPopupMenu[not CDSGrid.IsEmpty];
  if NovaTag <> menuExportar.Tag then
  begin
    menuExportar.Tag := NovaTag;
    IconePopupMenu(menuExportar, iExportar, TStatusImagem(NovaTag), ti16);
  end;

  // Botão Imprimir
  NovaTag := TConstantes.TagPopupMenu[not CDSGrid.IsEmpty];
  if NovaTag <> menuImprimir.Tag then
  begin
    menuImprimir.Tag := NovaTag;
    IconePopupMenu(menuImprimir, iImprimir, TStatusImagem(NovaTag), ti16);
  end;
end;
{$ENDREGION}

end.
