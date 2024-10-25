{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Bem - Patrim�nio

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

  @author Albert Eije (alberteije@gmail.com)
  @version 1.0
  ******************************************************************************* }

unit UPatrimBem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Mask, JvExMask, JvToolEdit,
  JvCombobox, LabeledCtrls, DBCtrls, LabeledDBCtrls, DB, DBClient, StrUtils,
  Math, JSonVO, Generics.Collections, Atributos, Constantes, CheckLst,
  JvExCheckLst, JvCheckListBox, JvBaseEdits, OleCtnrs, WideStrings, FMTBcd,
  Provider, SqlExpr, DBXMySql, PlatformDefaultStyleActnCtrls, ActnList, ActnMan,
  ToolWin, ActnCtrls, ShellApi, Biblioteca;

type
  [TFormDescription(TConstantes.MODULO_PATRIMONIO, 'Bem')]

  TFPatrimBem = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    EditNome: TLabeledEdit;
    EditNumero: TLabeledEdit;
    BevelEdits: TBevel;
    PageControlDadosPatrimBem: TPageControl;
    tsDadosComplementares: TTabSheet;
    tsDocumentoBem: TTabSheet;
    PanelDocumentacao: TPanel;
    GridDocumentacao: TJvDBUltimGrid;
    tsDepreciacaoBem: TTabSheet;
    PanelDepreciacao: TPanel;
    GridDepreciacao: TJvDBUltimGrid;
    EditIdTipoAquisicao: TLabeledCalcEdit;
    EditTipoAquisicaoNome: TLabeledEdit;
    EditIdSetor: TLabeledCalcEdit;
    EditSetorNome: TLabeledEdit;
    PanelDadosComplementares: TPanel;
    EditDataAquisicao: TLabeledDateEdit;
    MemoDescricao: TLabeledMemo;
    EditDataAceite: TLabeledDateEdit;
    EditDataCadastro: TLabeledDateEdit;
    EditValorOriginal: TLabeledCalcEdit;
    MemoFuncao: TLabeledMemo;
    CDSPatrimDocumentoBem: TClientDataSet;
    DSPatrimDocumentoBem: TDataSource;
    CDSPatrimDepreciacaoBem: TClientDataSet;
    DSPatrimDepreciacaoBem: TDataSource;
    tsMovimentacaoBem: TTabSheet;
    PanelMovimentacao: TPanel;
    GridMovimentacao: TJvDBUltimGrid;
    CDSPatrimMovimentacaoBem: TClientDataSet;
    DSPatrimMovimentacaoBem: TDataSource;
    CDSPatrimDepreciacaoBemID: TIntegerField;
    CDSPatrimDepreciacaoBemID_PATRIM_BEM: TIntegerField;
    CDSPatrimDepreciacaoBemDATA_DEPRECIACAO: TDateField;
    CDSPatrimDepreciacaoBemDIAS: TIntegerField;
    CDSPatrimDepreciacaoBemTAXA: TFMTBCDField;
    CDSPatrimDepreciacaoBemINDICE: TFMTBCDField;
    CDSPatrimDepreciacaoBemVALOR: TFMTBCDField;
    CDSPatrimDepreciacaoBemDEPRECIACAO_ACUMULADA: TFMTBCDField;
    CDSPatrimMovimentacaoBemID: TIntegerField;
    CDSPatrimMovimentacaoBemID_PATRIM_BEM: TIntegerField;
    CDSPatrimMovimentacaoBemID_PATRIM_TIPO_MOVIMENTACAO: TIntegerField;
    CDSPatrimMovimentacaoBemDATA_MOVIMENTACAO: TDateField;
    CDSPatrimMovimentacaoBemRESPONSAVEL: TStringField;
    EditGrupoBemNome: TLabeledEdit;
    EditIdGrupoBem: TLabeledCalcEdit;
    EditIdColaborador: TLabeledCalcEdit;
    EditColaboradorNome: TLabeledEdit;
    EditIdFornecedor: TLabeledCalcEdit;
    EditFornecedorNome: TLabeledEdit;
    EditIdEstadoConservacao: TLabeledCalcEdit;
    EditEstadoConservacaoNome: TLabeledEdit;
    EditNumeroSerie: TLabeledEdit;
    EditDataContabilizado: TLabeledDateEdit;
    EditDataVistoria: TLabeledDateEdit;
    EditDataMarcacao: TLabeledDateEdit;
    EditDataBaixa: TLabeledDateEdit;
    EditDataVencimentoGarantia: TLabeledDateEdit;
    EditNumeroNF: TLabeledEdit;
    EditChaveNFe: TLabeledEdit;
    EditValorCompra: TLabeledCalcEdit;
    EditValorAtualizado: TLabeledCalcEdit;
    GroupBoxDepreciacao: TGroupBox;
    EditValorBaixa: TLabeledCalcEdit;
    ComboDeprecia: TLabeledComboBox;
    ComboMetodoDepreciacao: TLabeledComboBox;
    ComboTipoDepreciacao: TLabeledComboBox;
    EditInicioDepreciacao: TLabeledDateEdit;
    EditUltimaDepreciacao: TLabeledDateEdit;
    EditTaxaAnualDepreciacao: TLabeledCalcEdit;
    EditTaxaMensalDepreciacao: TLabeledCalcEdit;
    EditTaxaDepreciacaoAcelerada: TLabeledCalcEdit;
    EditTaxaDepreciacaoIncentivada: TLabeledCalcEdit;
    ActionToolBarDepreciacao: TActionToolBar;
    ActionManagerBem: TActionManager;
    ActionCalcularDepreciacao: TAction;
    CDSPatrimDocumentoBemID: TIntegerField;
    CDSPatrimDocumentoBemID_PATRIM_BEM: TIntegerField;
    CDSPatrimDocumentoBemNOME: TStringField;
    CDSPatrimDocumentoBemDESCRICAO: TStringField;
    CDSPatrimDocumentoBemIMAGEM: TStringField;
    CDSPatrimDocumentoBemPERSISTE: TStringField;
    CDSPatrimDepreciacaoBemPERSISTE: TStringField;
    CDSPatrimMovimentacaoBemPATRIM_TIPO_MOVIMENTACAONOME: TStringField;
    CDSPatrimMovimentacaoBemPERSISTE: TStringField;
    ActionToolBar1: TActionToolBar;
    ActionAcionarGed: TAction;
    procedure FormCreate(Sender: TObject);
    procedure GridDocumentacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridDepreciacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridMovimentacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdTipoAquisicaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdSetorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionCalcularDepreciacaoExecute(Sender: TObject);
    procedure CDSPatrimDocumentoBemAfterEdit(DataSet: TDataSet);
    procedure CDSPatrimDepreciacaoBemAfterEdit(DataSet: TDataSet);
    procedure CDSPatrimMovimentacaoBemAfterEdit(DataSet: TDataSet);
    procedure EditIdSetorExit(Sender: TObject);
    procedure EditIdSetorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdColaboradorExit(Sender: TObject);
    procedure EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdFornecedorExit(Sender: TObject);
    procedure EditIdGrupoBemExit(Sender: TObject);
    procedure EditIdGrupoBemKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdTipoAquisicaoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdTipoAquisicaoExit(Sender: TObject);
    procedure EditIdEstadoConservacaoExit(Sender: TObject);
    procedure EditIdEstadoConservacaoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdEstadoConservacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdGrupoBemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridDocumentacaoUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure GridDepreciacaoUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure GridMovimentacaoUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure ActionAcionarGedExecute(Sender: TObject);
  private
    { Private declarations }
    IdTipoPatrimBem: Integer;
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
  end;

var
  FPatrimBem: TFPatrimBem;

implementation

uses NotificationService, PatrimBemVO, PatrimBemController, PatrimDocumentoBemVO,
  PatrimDepreciacaoBemVO, PatrimMovimentacaoBemVO, ULookup, UDataModule,
  PatrimTipoAquisicaoBemVO, PatrimTipoAquisicaoBemController, ColaboradorVO,
  ColaboradorController, PatrimEstadoConservacaoVO, PatrimEstadoConservacaoController,
  FornecedorVO, FornecedorController, PatrimGrupoBemVO, PatrimGrupoBemController,
  SetorVO, SetorController, PatrimTipoMovimentacaoVO, PatrimTipoMovimentacaoController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFPatrimBem.FormCreate(Sender: TObject);
var
  Form: TForm;
begin
  ClasseObjetoGridVO := TPatrimBemVO;
  ObjetoController := TPatrimBemController.Create;

  inherited;
end;

procedure TFPatrimBem.LimparCampos;
var
  i: Integer;
begin
  inherited;

  CDSPatrimDocumentoBem.EmptyDataSet;
  CDSPatrimDepreciacaoBem.EmptyDataSet;
  CDSPatrimMovimentacaoBem.EmptyDataSet;

  ConfigurarLayoutTela;
end;

procedure TFPatrimBem.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;
  PageControlDadosPatrimBem.ActivePageIndex := 0;

  if StatusTela = stNavegandoEdits then
  begin
    PanelDadosComplementares.Enabled := False;
    GridDocumentacao.ReadOnly := True;
    GridDepreciacao.ReadOnly := True;
    GridMovimentacao.ReadOnly := True;
  end
  else
  begin
    PanelDadosComplementares.Enabled := True;
    GridDocumentacao.ReadOnly := False;
    GridDepreciacao.ReadOnly := False;
    GridMovimentacao.ReadOnly := False;
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFPatrimBem.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdSetor.SetFocus;
  end;
end;

function TFPatrimBem.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdSetor.SetFocus;
  end;
end;

function TFPatrimBem.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TPatrimBemController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TPatrimBemController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFPatrimBem.DoSalvar: Boolean;
var
  DocumentoBemVO: TPatrimDocumentoBemVO;
  DepreciacaoBemVO: TPatrimDepreciacaoBemVO;
  MovimentacaoBemVO: TPatrimMovimentacaoBemVO;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TPatrimBemVO.Create;

      TPatrimBemVO(ObjetoVO).IdPatrimTipoAquisicaoBem := EditIdTipoAquisicao.AsInteger;
      TPatrimBemVO(ObjetoVO).PatrimTipoAquisicaoBemNome := EditTipoAquisicaoNome.Text;
      TPatrimBemVO(ObjetoVO).IdPatrimEstadoConservacao := EditIdEstadoConservacao.AsInteger;
      TPatrimBemVO(ObjetoVO).PatrimEstadoConservacaoNome := EditEstadoConservacaoNome.Text;
      TPatrimBemVO(ObjetoVO).IdPatrimGrupoBem := EditIdGrupoBem.AsInteger;
      TPatrimBemVO(ObjetoVO).PatrimGrupoBemNome := EditGrupoBemNome.Text;
      TPatrimBemVO(ObjetoVO).IdSetor := EditIdSetor.AsInteger;
      TPatrimBemVO(ObjetoVO).SetorNome := EditSetorNome.Text;
      TPatrimBemVO(ObjetoVO).IdFornecedor := EditIdFornecedor.AsInteger;
      TPatrimBemVO(ObjetoVO).FornecedorPessoaNome := EditFornecedorNome.Text;
      TPatrimBemVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TPatrimBemVO(ObjetoVO).ColaboradorPessoaNome := EditColaboradorNome.Text;
      TPatrimBemVO(ObjetoVO).NumeroNb := EditNumero.Text;
      TPatrimBemVO(ObjetoVO).Nome := EditNome.Text;
      TPatrimBemVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TPatrimBemVO(ObjetoVO).NumeroSerie := EditNumeroSerie.Text;
      TPatrimBemVO(ObjetoVO).DataAquisicao := EditDataAquisicao.Date;
      TPatrimBemVO(ObjetoVO).DataAceite := EditDataAceite.Date;
      TPatrimBemVO(ObjetoVO).DataCadastro := EditDataCadastro.Date;
      TPatrimBemVO(ObjetoVO).DataContabilizado := EditDataContabilizado.Date;
      TPatrimBemVO(ObjetoVO).DataVistoria := EditDataVistoria.Date;
      TPatrimBemVO(ObjetoVO).DataMarcacao := EditDataMarcacao.Date;
      TPatrimBemVO(ObjetoVO).DataBaixa := EditDataBaixa.Date;
      TPatrimBemVO(ObjetoVO).VencimentoGarantia := EditDataVencimentoGarantia.Date;
      TPatrimBemVO(ObjetoVO).NumeroNotaFiscal := EditNumeroNF.Text;
      TPatrimBemVO(ObjetoVO).ChaveNfe := EditChaveNFe.Text;
      TPatrimBemVO(ObjetoVO).ValorOriginal := EditValorOriginal.Value;
      TPatrimBemVO(ObjetoVO).ValorCompra := EditValorCompra.Value;
      TPatrimBemVO(ObjetoVO).ValorAtualizado := EditValorAtualizado.Value;
      TPatrimBemVO(ObjetoVO).ValorBaixa := EditValorBaixa.Value;
      TPatrimBemVO(ObjetoVO).Deprecia := Copy(ComboDeprecia.Text, 1, 1);
      TPatrimBemVO(ObjetoVO).MetodoDepreciacao := Copy(ComboMetodoDepreciacao.Text, 1, 1);
      TPatrimBemVO(ObjetoVO).InicioDepreciacao := EditInicioDepreciacao.Date;
      TPatrimBemVO(ObjetoVO).UltimaDepreciacao := EditUltimaDepreciacao.Date;
      TPatrimBemVO(ObjetoVO).TipoDepreciacao := Copy(ComboTipoDepreciacao.Text, 1, 1);
      TPatrimBemVO(ObjetoVO).TaxaAnualDepreciacao := EditTaxaAnualDepreciacao.Value;
      TPatrimBemVO(ObjetoVO).TaxaMensalDepreciacao := EditTaxaMensalDepreciacao.Value;
      TPatrimBemVO(ObjetoVO).TaxaDepreciacaoAcelerada := EditTaxaDepreciacaoAcelerada.Value;
      TPatrimBemVO(ObjetoVO).TaxaDepreciacaoIncentivada := EditTaxaDepreciacaoIncentivada.Value;
      TPatrimBemVO(ObjetoVO).Funcao := MemoFuncao.Text;

      // Documento
      CDSPatrimDocumentoBem.DisableControls;
      CDSPatrimDocumentoBem.First;
      while not CDSPatrimDocumentoBem.Eof do
      begin
        if (CDSPatrimDocumentoBemPERSISTE.AsString = 'S') or (CDSPatrimDocumentoBemID.AsInteger = 0) then
        begin
          DocumentoBemVO := TPatrimDocumentoBemVO.Create;
          DocumentoBemVO.Id := CDSPatrimDocumentoBemID.AsInteger;
          DocumentoBemVO.IdPatrimBem := TPatrimBemVO(ObjetoVO).Id;
          DocumentoBemVO.Nome := CDSPatrimDocumentoBemNOME.AsString;
          DocumentoBemVO.Descricao := CDSPatrimDocumentoBemDESCRICAO.AsString;
          DocumentoBemVO.Imagem := CDSPatrimDocumentoBemIMAGEM.AsString;
          TPatrimBemVO(ObjetoVO).ListaPatrimDocumentoBemVO.Add(DocumentoBemVO);
        end;
        CDSPatrimDocumentoBem.Next;
      end;
      CDSPatrimDocumentoBem.First;
      CDSPatrimDocumentoBem.EnableControls;

      // Deprecia��o
      CDSPatrimDepreciacaoBem.DisableControls;
      CDSPatrimDepreciacaoBem.First;
      while not CDSPatrimDepreciacaoBem.Eof do
      begin
        if (CDSPatrimDepreciacaoBemPERSISTE.AsString = 'S') or (CDSPatrimDepreciacaoBemID.AsInteger = 0) then
        begin
          DepreciacaoBemVO := TPatrimDepreciacaoBemVO.Create;
          DepreciacaoBemVO.Id := CDSPatrimDepreciacaoBemID.AsInteger;
          DepreciacaoBemVO.IdPatrimBem := TPatrimBemVO(ObjetoVO).Id;
          DepreciacaoBemVO.DataDepreciacao := CDSPatrimDepreciacaoBemDATA_DEPRECIACAO.AsDateTime;
          DepreciacaoBemVO.Dias := CDSPatrimDepreciacaoBemDIAS.AsInteger;
          DepreciacaoBemVO.Taxa := CDSPatrimDepreciacaoBemTAXA.AsExtended;
          DepreciacaoBemVO.Indice := CDSPatrimDepreciacaoBemINDICE.AsExtended;
          DepreciacaoBemVO.Valor := CDSPatrimDepreciacaoBemVALOR.AsExtended;
          DepreciacaoBemVO.DepreciacaoAcumulada := CDSPatrimDepreciacaoBemDEPRECIACAO_ACUMULADA.AsExtended;
          TPatrimBemVO(ObjetoVO).ListaPatrimDepreciacaoBemVO.Add(DepreciacaoBemVO);
        end;
        CDSPatrimDepreciacaoBem.Next;
      end;
      CDSPatrimDepreciacaoBem.First;
      CDSPatrimDepreciacaoBem.EnableControls;

      // Movimenta��o
      CDSPatrimMovimentacaoBem.DisableControls;
      CDSPatrimMovimentacaoBem.First;
      while not CDSPatrimMovimentacaoBem.Eof do
      begin
        if (CDSPatrimMovimentacaoBemPERSISTE.AsString = 'S') or (CDSPatrimMovimentacaoBemID.AsInteger = 0) then
        begin
          MovimentacaoBemVO := TPatrimMovimentacaoBemVO.Create;
          MovimentacaoBemVO.Id := CDSPatrimMovimentacaoBemID.AsInteger;
          MovimentacaoBemVO.IdPatrimBem := TPatrimBemVO(ObjetoVO).Id;
          MovimentacaoBemVO.IdPatrimTipoMovimentacao := CDSPatrimMovimentacaoBemID_PATRIM_TIPO_MOVIMENTACAO.AsInteger;
          MovimentacaoBemVO.PatrimTipoMovimentacaoNome := CDSPatrimMovimentacaoBemPATRIM_TIPO_MOVIMENTACAONOME.AsString;
          MovimentacaoBemVO.DataMovimentacao := CDSPatrimMovimentacaoBemDATA_MOVIMENTACAO.AsDateTime;
          MovimentacaoBemVO.Responsavel := CDSPatrimMovimentacaoBemRESPONSAVEL.AsString;
          TPatrimBemVO(ObjetoVO).ListaPatrimMovimentacaoBemVO.Add(MovimentacaoBemVO);
        end;
        CDSPatrimMovimentacaoBem.Next;
      end;
      CDSPatrimMovimentacaoBem.First;
      CDSPatrimMovimentacaoBem.EnableControls;

      // ObjetoVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
      TPatrimBemVO(ObjetoVO).ColaboradorVO := Nil;
      TPatrimBemVO(ObjetoVO).FornecedorVO := Nil;
      TPatrimBemVO(ObjetoVO).SetorVO := Nil;
      TPatrimBemVO(ObjetoVO).PatrimEstadoConservacaoVO := Nil;
      TPatrimBemVO(ObjetoVO).PatrimGrupoBemVO := Nil;
      TPatrimBemVO(ObjetoVO).PatrimTipoAquisicaoBemVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TPatrimBemVO(ObjetoOldVO).ColaboradorVO := Nil;
        TPatrimBemVO(ObjetoOldVO).FornecedorVO := Nil;
        TPatrimBemVO(ObjetoOldVO).SetorVO := Nil;
        TPatrimBemVO(ObjetoOldVO).PatrimEstadoConservacaoVO := Nil;
        TPatrimBemVO(ObjetoOldVO).PatrimGrupoBemVO := Nil;
        TPatrimBemVO(ObjetoOldVO).PatrimTipoAquisicaoBemVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TPatrimBemController(ObjetoController).Insere(TPatrimBemVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TPatrimBemVO(ObjetoVO).ToJSONString <> TPatrimBemVO(ObjetoOldVO).ToJSONString then
        begin
          TPatrimBemVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TPatrimBemController(ObjetoController).Altera(TPatrimBemVO(ObjetoVO), TPatrimBemVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'Campos Transientes'}

procedure TFPatrimBem.EditIdTipoAquisicaoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdTipoAquisicao.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdTipoAquisicao.Text;
      EditIdTipoAquisicao.Clear;
      EditTipoAquisicaoNome.Clear;
      if not PopulaCamposTransientes(Filtro, TPatrimTipoAquisicaoBemVO, TPatrimTipoAquisicaoBemController) then
        PopulaCamposTransientesLookup(TPatrimTipoAquisicaoBemVO, TPatrimTipoAquisicaoBemController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdTipoAquisicao.Text := CDSTransiente.FieldByName('ID').AsString;
        EditTipoAquisicaoNome.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdTipoAquisicao.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditTipoAquisicaoNome.Clear;
  end;
end;

procedure TFPatrimBem.EditIdTipoAquisicaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdTipoAquisicao.Value := -1;
    EditIdEstadoConservacao.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdTipoAquisicaoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdEstadoConservacao.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdColaboradorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdColaborador.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdColaborador.Text;
      EditIdColaborador.Clear;
      EditColaboradorNome.Clear;
      if not PopulaCamposTransientes(Filtro, TColaboradorVO, TColaboradorController) then
        PopulaCamposTransientesLookup(TColaboradorVO, TColaboradorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdColaborador.Text := CDSTransiente.FieldByName('ID').AsString;
        EditColaboradorNome.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdColaborador.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditColaboradorNome.Clear;
  end;
end;

procedure TFPatrimBem.EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdColaborador.Value := -1;
    EditIdFornecedor.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdFornecedor.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdEstadoConservacaoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdEstadoConservacao.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdEstadoConservacao.Text;
      EditIdEstadoConservacao.Clear;
      EditEstadoConservacaoNome.Clear;
      if not PopulaCamposTransientes(Filtro, TPatrimEstadoConservacaoVO, TPatrimEstadoConservacaoController) then
        PopulaCamposTransientesLookup(TPatrimEstadoConservacaoVO, TPatrimEstadoConservacaoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdEstadoConservacao.Text := CDSTransiente.FieldByName('ID').AsString;
        EditEstadoConservacaoNome.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdEstadoConservacao.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditEstadoConservacaoNome.Clear;
  end;
end;

procedure TFPatrimBem.EditIdEstadoConservacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdEstadoConservacao.Value := -1;
    EditNumero.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdEstadoConservacaoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditNumero.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdFornecedorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdFornecedor.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdFornecedor.Text;
      EditIdFornecedor.Clear;
      EditFornecedorNome.Clear;
      if not PopulaCamposTransientes(Filtro, TFornecedorVO, TFornecedorController) then
        PopulaCamposTransientesLookup(TFornecedorVO, TFornecedorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdFornecedor.Text := CDSTransiente.FieldByName('ID').AsString;
        EditFornecedorNome.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdFornecedor.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditFornecedorNome.Clear;
  end;
end;

procedure TFPatrimBem.EditIdFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdFornecedor.Value := -1;
    EditIdGrupoBem.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdGrupoBem.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdGrupoBemExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdGrupoBem.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdGrupoBem.Text;
      EditIdGrupoBem.Clear;
      EditGrupoBemNome.Clear;
      if not PopulaCamposTransientes(Filtro, TPatrimGrupoBemVO, TPatrimGrupoBemController) then
        PopulaCamposTransientesLookup(TPatrimGrupoBemVO, TPatrimGrupoBemController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdGrupoBem.Text := CDSTransiente.FieldByName('ID').AsString;
        EditGrupoBemNome.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdGrupoBem.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditGrupoBemNome.Clear;
  end;
end;

procedure TFPatrimBem.EditIdGrupoBemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdGrupoBem.Value := -1;
    EditIdTipoAquisicao.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdGrupoBemKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdTipoAquisicao.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdSetorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdSetor.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdSetor.Text;
      EditIdSetor.Clear;
      EditSetorNome.Clear;
      if not PopulaCamposTransientes(Filtro, TSetorVO, TSetorController) then
        PopulaCamposTransientesLookup(TSetorVO, TSetorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdSetor.Text := CDSTransiente.FieldByName('ID').AsString;
        EditSetorNome.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdSetor.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditSetorNome.Clear;
  end;
end;

procedure TFPatrimBem.EditIdSetorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdSetor.Value := -1;
    EditIdColaborador.SetFocus;
  end;
end;

procedure TFPatrimBem.EditIdSetorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdColaborador.SetFocus;
  end;
end;
{$ENDREGION}
{$REGION 'Controle de Grid'}

procedure TFPatrimBem.GridParaEdits;
var
  DocumentoBemEnumerator: TEnumerator<TPatrimDocumentoBemVO>;
  DepreciacaoBemEnumerator: TEnumerator<TPatrimDepreciacaoBemVO>;
  MovimentacaoBemEnumerator: TEnumerator<TPatrimMovimentacaoBemVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TPatrimBemVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TPatrimBemVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin

    EditIdTipoAquisicao.AsInteger := TPatrimBemVO(ObjetoVO).IdPatrimTipoAquisicaoBem;
    EditIdEstadoConservacao.AsInteger := TPatrimBemVO(ObjetoVO).IdPatrimEstadoConservacao;
    EditIdGrupoBem.AsInteger := TPatrimBemVO(ObjetoVO).IdPatrimGrupoBem;
    EditIdSetor.AsInteger := TPatrimBemVO(ObjetoVO).IdSetor;
    EditIdFornecedor.AsInteger := TPatrimBemVO(ObjetoVO).IdFornecedor;
    EditIdColaborador.AsInteger := TPatrimBemVO(ObjetoVO).IdColaborador;
    EditTipoAquisicaoNome.Text := TPatrimBemVO(ObjetoVO).PatrimTipoAquisicaoBemNome;
    EditEstadoConservacaoNome.Text := TPatrimBemVO(ObjetoVO).PatrimEstadoConservacaoNome;
    EditGrupoBemNome.Text := TPatrimBemVO(ObjetoVO).PatrimGrupoBemNome;
    EditSetorNome.Text := TPatrimBemVO(ObjetoVO).SetorNome;
    EditFornecedorNome.Text := TPatrimBemVO(ObjetoVO).FornecedorPessoaNome;
    EditColaboradorNome.Text := TPatrimBemVO(ObjetoVO).ColaboradorPessoaNome;
    EditNumero.Text := TPatrimBemVO(ObjetoVO).NumeroNb;
    EditNome.Text := TPatrimBemVO(ObjetoVO).Nome;
    MemoDescricao.Text := TPatrimBemVO(ObjetoVO).Descricao;
    EditNumeroSerie.Text := TPatrimBemVO(ObjetoVO).NumeroSerie;
    EditDataAquisicao.Date := TPatrimBemVO(ObjetoVO).DataAquisicao;
    EditDataAceite.Date := TPatrimBemVO(ObjetoVO).DataAceite;
    EditDataCadastro.Date := TPatrimBemVO(ObjetoVO).DataCadastro;
    EditDataContabilizado.Date := TPatrimBemVO(ObjetoVO).DataContabilizado;
    EditDataVistoria.Date := TPatrimBemVO(ObjetoVO).DataVistoria;
    EditDataMarcacao.Date := TPatrimBemVO(ObjetoVO).DataMarcacao;
    EditDataBaixa.Date := TPatrimBemVO(ObjetoVO).DataBaixa;
    EditDataVencimentoGarantia.Date := TPatrimBemVO(ObjetoVO).VencimentoGarantia;
    EditNumeroNF.Text := TPatrimBemVO(ObjetoVO).NumeroNotaFiscal;
    EditChaveNFe.Text := TPatrimBemVO(ObjetoVO).ChaveNfe;
    EditValorOriginal.Value := TPatrimBemVO(ObjetoVO).ValorOriginal;
    EditValorCompra.Value := TPatrimBemVO(ObjetoVO).ValorCompra;
    EditValorAtualizado.Value := TPatrimBemVO(ObjetoVO).ValorAtualizado;
    EditValorBaixa.Value := TPatrimBemVO(ObjetoVO).ValorBaixa;

    case AnsiIndexStr(TPatrimBemVO(ObjetoVO).Deprecia, ['S', 'N']) of
      0:
        ComboDeprecia.ItemIndex := 0;
      1:
        ComboDeprecia.ItemIndex := 1;
    else
      ComboDeprecia.ItemIndex := -1;
    end;

    case AnsiIndexStr(TPatrimBemVO(ObjetoVO).MetodoDepreciacao, ['1', '2', '3', '4']) of
      0:
        ComboMetodoDepreciacao.ItemIndex := 0;
      1:
        ComboMetodoDepreciacao.ItemIndex := 1;
      2:
        ComboMetodoDepreciacao.ItemIndex := 2;
      3:
        ComboMetodoDepreciacao.ItemIndex := 3;
    else
      ComboMetodoDepreciacao.ItemIndex := -1;
    end;

    EditInicioDepreciacao.Date := TPatrimBemVO(ObjetoVO).InicioDepreciacao;
    EditUltimaDepreciacao.Date := TPatrimBemVO(ObjetoVO).UltimaDepreciacao;

    case AnsiIndexStr(TPatrimBemVO(ObjetoVO).TipoDepreciacao, ['N', 'A', 'I']) of
      0:
        ComboTipoDepreciacao.ItemIndex := 0;
      1:
        ComboTipoDepreciacao.ItemIndex := 1;
      2:
        ComboTipoDepreciacao.ItemIndex := 2;
    else
      ComboTipoDepreciacao.ItemIndex := -1;
    end;

    EditTaxaAnualDepreciacao.Value := TPatrimBemVO(ObjetoVO).TaxaAnualDepreciacao;
    EditTaxaMensalDepreciacao.Value := TPatrimBemVO(ObjetoVO).TaxaMensalDepreciacao;
    EditTaxaDepreciacaoAcelerada.Value := TPatrimBemVO(ObjetoVO).TaxaDepreciacaoAcelerada;
    EditTaxaDepreciacaoIncentivada.Value := TPatrimBemVO(ObjetoVO).TaxaDepreciacaoIncentivada;
    MemoFuncao.Text := TPatrimBemVO(ObjetoVO).Funcao;

    // Documento
    DocumentoBemEnumerator := TPatrimBemVO(ObjetoVO).ListaPatrimDocumentoBemVO.GetEnumerator;
    try
      with DocumentoBemEnumerator do
      begin
        while MoveNext do
        begin
          CDSPatrimDocumentoBem.Append;

          CDSPatrimDocumentoBemID.AsInteger := Current.Id;
          CDSPatrimDocumentoBemID_PATRIM_BEM.AsInteger := Current.IdPatrimBem;
          CDSPatrimDocumentoBemNOME.AsString := Current.Nome;
          CDSPatrimDocumentoBemDESCRICAO.AsString := Current.Descricao;
          CDSPatrimDocumentoBemIMAGEM.AsString := Current.Imagem;

          CDSPatrimDocumentoBem.Post;
        end;
      end;
    finally
      DocumentoBemEnumerator.Free;
    end;

    // Deprecia��o
    DepreciacaoBemEnumerator := TPatrimBemVO(ObjetoVO).ListaPatrimDepreciacaoBemVO.GetEnumerator;
    try
      with DepreciacaoBemEnumerator do
      begin
        while MoveNext do
        begin
          CDSPatrimDepreciacaoBem.Append;

          CDSPatrimDepreciacaoBemID.AsInteger := Current.Id;
          CDSPatrimDepreciacaoBemID_PATRIM_BEM.AsInteger := Current.IdPatrimBem;
          CDSPatrimDepreciacaoBemDATA_DEPRECIACAO.AsDateTime := Current.DataDepreciacao;
          CDSPatrimDepreciacaoBemDIAS.AsInteger := Current.Dias;
          CDSPatrimDepreciacaoBemTAXA.AsExtended := Current.Taxa;
          CDSPatrimDepreciacaoBemINDICE.AsExtended := Current.Indice;
          CDSPatrimDepreciacaoBemVALOR.AsExtended := Current.Valor;
          CDSPatrimDepreciacaoBemDEPRECIACAO_ACUMULADA.AsExtended := Current.DepreciacaoAcumulada;

          CDSPatrimDepreciacaoBem.Post;
        end;
      end;
    finally
      DepreciacaoBemEnumerator.Free;
    end;

    // Movimenta��o
    MovimentacaoBemEnumerator := TPatrimBemVO(ObjetoVO).ListaPatrimMovimentacaoBemVO.GetEnumerator;
    try
      with MovimentacaoBemEnumerator do
      begin
        while MoveNext do
        begin
          CDSPatrimMovimentacaoBem.Append;

          CDSPatrimMovimentacaoBemID.AsInteger := Current.Id;
          CDSPatrimMovimentacaoBemID_PATRIM_BEM.AsInteger := Current.IdPatrimBem;
          CDSPatrimMovimentacaoBemID_PATRIM_TIPO_MOVIMENTACAO.AsInteger := Current.IdPatrimTipoMovimentacao;
          CDSPatrimMovimentacaoBemPATRIM_TIPO_MOVIMENTACAONOME.AsString := Current.PatrimTipoMovimentacaoVO.Nome;
          CDSPatrimMovimentacaoBemDATA_MOVIMENTACAO.AsDateTime := Current.DataMovimentacao;
          CDSPatrimMovimentacaoBemRESPONSAVEL.AsString := Current.Responsavel;

          CDSPatrimMovimentacaoBem.Post;
        end;
      end;
    finally
      MovimentacaoBemEnumerator.Free;
    end;

    ConfigurarLayoutTela;
  end;
end;

procedure TFPatrimBem.GridDocumentacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridDocumentacao.SelectedIndex := GridDocumentacao.SelectedIndex + 1;
end;

procedure TFPatrimBem.GridDocumentacaoUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
begin
  //
end;

procedure TFPatrimBem.GridDepreciacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridDepreciacao.SelectedIndex := GridDepreciacao.SelectedIndex + 1;
end;

procedure TFPatrimBem.GridDepreciacaoUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
begin
  //
end;

procedure TFPatrimBem.GridMovimentacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    try
      PopulaCamposTransientesLookup(TPatrimTipoMovimentacaoVO, TPatrimTipoMovimentacaoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        CDSPatrimMovimentacaoBem.Append;
        CDSPatrimMovimentacaoBemID_PATRIM_TIPO_MOVIMENTACAO.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
        CDSPatrimMovimentacaoBemPATRIM_TIPO_MOVIMENTACAONOME.AsString := CDSTransiente.FieldByName('NOME').AsString;
        CDSPatrimMovimentacaoBemDATA_MOVIMENTACAO.AsDateTime := Now;
        CDSPatrimMovimentacaoBem.Post;
      end;
    finally
      CDSTransiente.Close;
    end;
  end;
  If Key = VK_RETURN then
    GridMovimentacao.SelectedIndex := GridMovimentacao.SelectedIndex + 1;
end;

procedure TFPatrimBem.GridMovimentacaoUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
begin
  //
end;

procedure TFPatrimBem.CDSPatrimDepreciacaoBemAfterEdit(DataSet: TDataSet);
begin
  CDSPatrimDepreciacaoBemPERSISTE.AsString := 'S';
end;

procedure TFPatrimBem.CDSPatrimDocumentoBemAfterEdit(DataSet: TDataSet);
begin
  CDSPatrimDocumentoBemPERSISTE.AsString := 'S';
end;

procedure TFPatrimBem.CDSPatrimMovimentacaoBemAfterEdit(DataSet: TDataSet);
begin
  CDSPatrimMovimentacaoBemPERSISTE.AsString := 'S';
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFPatrimBem.ActionAcionarGedExecute(Sender: TObject);
var
  Parametros: String;
begin
  if not CDSPatrimDocumentoBem.IsEmpty then
  begin
    {
      Parametros
      1 - Login
      2 - Senha
      3 - Aplica��o que chamou
      4 - Nome do arquivo (Aplicacao que chamou + Tela que chamou + Numero Ap�lice
      }

    try
      CDSPatrimDocumentoBem.Edit;
      CDSPatrimDocumentoBemIMAGEM.AsString := 'PATRIMONIO_BEM_' + EditNumero.Text + '_' + MD5String(CDSPatrimDocumentoBemNOME.AsString);
      CDSPatrimDocumentoBem.Post;

      Parametros := Sessao.Usuario.Login + ' ' +
                    Sessao.Usuario.Senha + ' ' +
                    'PATRIMONIO' + ' ' +
                    'PATRIMONIO_BEM_' + EditNumero.Text + '_' + MD5String(CDSPatrimDocumentoBemNOME.AsString);
      ShellExecute(
            Handle,
            'open',
            'T2TiERPGed.exe',
            PChar(Parametros),
            '',
            SW_SHOWNORMAL
            );
    except
      Application.MessageBox('Erro ao tentar executar o m�dulo.', 'Erro do Sistema', MB_OK + MB_ICONERROR);
    end;
  end
  else
  begin
    Application.MessageBox('� preciso adicionar os dados de um documento ao bem.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    GridDocumentacao.SetFocus;
    GridDocumentacao.SelectedIndex := 1;
  end;
end;

procedure TFPatrimBem.ActionCalcularDepreciacaoExecute(Sender: TObject);
begin
  CDSPatrimDepreciacaoBem.Append;
  CDSPatrimDepreciacaoBemDATA_DEPRECIACAO.AsDateTime := Date;
  CDSPatrimDepreciacaoBemDIAS.AsInteger := StrToInt(FormatDateTime('dd', Date));

  //Normal
  if ComboTipoDepreciacao.ItemIndex = 0 then
  begin
    CDSPatrimDepreciacaoBemTAXA.AsExtended := EditTaxaMensalDepreciacao.Value;
    CDSPatrimDepreciacaoBemINDICE.AsExtended := (CDSPatrimDepreciacaoBemDIAS.AsInteger / 30) * EditTaxaMensalDepreciacao.Value;
  end;

  //Acelerada
  if ComboTipoDepreciacao.ItemIndex = 1 then
  begin
    CDSPatrimDepreciacaoBemTAXA.AsExtended := EditTaxaDepreciacaoAcelerada.Value;
    CDSPatrimDepreciacaoBemINDICE.AsExtended := (CDSPatrimDepreciacaoBemDIAS.AsInteger / 30) * EditTaxaDepreciacaoAcelerada.Value;
  end;

  //Incentivada
  if ComboTipoDepreciacao.ItemIndex = 2 then
  begin
    CDSPatrimDepreciacaoBemTAXA.AsExtended := EditTaxaDepreciacaoIncentivada.Value;
    CDSPatrimDepreciacaoBemINDICE.AsExtended := (CDSPatrimDepreciacaoBemDIAS.AsInteger / 30) * EditTaxaDepreciacaoIncentivada.Value;
  end;

  CDSPatrimDepreciacaoBemVALOR.AsExtended := EditValorOriginal.Value * CDSPatrimDepreciacaoBemINDICE.AsExtended;
  CDSPatrimDepreciacaoBemDEPRECIACAO_ACUMULADA.AsExtended := EditValorOriginal.Value - CDSPatrimDepreciacaoBemVALOR.AsExtended;
  CDSPatrimDepreciacaoBem.Post;
end;
{$ENDREGION}

end.
