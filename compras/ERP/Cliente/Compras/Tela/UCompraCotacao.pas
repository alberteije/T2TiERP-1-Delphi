{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela para realizar a Cota��o de Compra

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

  @author Albert Eije
  @version 1.0   |   Fernando  @version 1.0.0.10
  ******************************************************************************* }
unit UCompraCotacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, CompraCotacaoVO,
  CompraCotacaoController, Tipos, Atributos, Constantes, LabeledCtrls, Mask,
  JvExMask, JvToolEdit, Generics.Collections, Spin, JvSpin,
  PlatformDefaultStyleActnCtrls, ActnList, ActnMan, ActnCtrls, ToolWin;

type
  [TFormDescription(TConstantes.MODULO_COMPRAS, 'Cota��o')]

  TFCompraCotacao = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditDescricao: TLabeledEdit;
    EditDataCotacao: TLabeledDateEdit;
    GroupBoxItensCotacao: TGroupBox;
    GridCompraCotacaoDetalhe: TJvDBUltimGrid;
    GroupBoxFornecedores: TGroupBox;
    GridCompraFornecedorCotacao: TJvDBUltimGrid;
    DSCompraFornecedorCotacao: TDataSource;
    DSCompraCotacaoDetalhe: TDataSource;
    CDSCompraFornecedorCotacao: TClientDataSet;
    CDSCompraFornecedorCotacaoID: TIntegerField;
    CDSCompraFornecedorCotacaoID_FORNECEDOR: TIntegerField;
    CDSCompraFornecedorCotacaoID_COMPRA_COTACAO: TIntegerField;
    CDSCompraFornecedorCotacaoPRAZO_ENTREGA: TStringField;
    CDSCompraFornecedorCotacaoCONDICOES_PAGAMENTO: TStringField;
    CDSCompraFornecedorCotacaoVALOR_SUBTOTAL: TFMTBCDField;
    CDSCompraFornecedorCotacaoTAXA_DESCONTO: TFMTBCDField;
    CDSCompraFornecedorCotacaoVALOR_DESCONTO: TFMTBCDField;
    CDSCompraFornecedorCotacaoTOTAL: TFMTBCDField;
    CDSCompraCotacaoDetalhe: TClientDataSet;
    CDSCompraCotacaoDetalheID: TIntegerField;
    CDSCompraCotacaoDetalheID_COMPRA_FORNECEDOR_COTACAO: TIntegerField;
    CDSCompraCotacaoDetalheID_PRODUTO: TIntegerField;
    CDSCompraCotacaoDetalheQUANTIDADE: TFMTBCDField;
    CDSCompraCotacaoDetalheVALOR_UNITARIO: TFMTBCDField;
    CDSCompraCotacaoDetalheVALOR_SUBTOTAL: TFMTBCDField;
    CDSCompraCotacaoDetalheTAXA_DESCONTO: TFMTBCDField;
    CDSCompraCotacaoDetalheVALOR_DESCONTO: TFMTBCDField;
    CDSCompraCotacaoDetalheVALOR_TOTAL: TFMTBCDField;
    CDSCompraCotacaoDetalheQUANTIDADE_PEDIDA: TFMTBCDField;
    CDSCompraFornecedorCotacaoPERSISTE: TStringField;
    CDSCompraCotacaoDetalhePERSISTE: TStringField;
    CDSCompraRequisicaoDetalhe: TClientDataSet;
    CDSCompraRequisicaoDetalheID: TIntegerField;
    CDSCompraRequisicaoDetalheID_PRODUTO: TIntegerField;
    CDSCompraRequisicaoDetalheID_COMPRA_REQUISICAO: TIntegerField;
    CDSCompraRequisicaoDetalheQUANTIDADE: TFMTBCDField;
    CDSCompraRequisicaoDetalheQUANTIDADE_COTADA: TFMTBCDField;
    DSCompraRequisicaoDetalhe: TDataSource;
    GroupBoxCompraRequisicaoDetalhe: TGroupBox;
    GridCompraRequisicaoDetalhe: TJvDBUltimGrid;
    CDSCompraRequisicaoDetalhePRODUTONOME: TStringField;
    PanelActions: TPanel;
    SpinEditQuantidade: TJvSpinEdit;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActionInserirCotacao: TAction;
    ActionToolBar2: TActionToolBar;
    ActionRetirarCotacao: TAction;
    CDSCompraCotacaoDetalhePRODUTONOME: TStringField;
    CDSCompraRequisicaoDetalheITEM_COTADO: TStringField;
    CDSCompraFornecedorCotacaoFORNECEDORPESSOANOME: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure GridCompraFornecedorCotacaoUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure GridCompraFornecedorCotacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSCompraFornecedorCotacaoAfterEdit(DataSet: TDataSet);
    procedure CDSCompraCotacaoDetalheAfterEdit(DataSet: TDataSet);
    procedure CDSCompraRequisicaoDetalheAfterScroll(DataSet: TDataSet);
    procedure ActionInserirCotacaoExecute(Sender: TObject);
    procedure ConfigurarSpinQuantidade;
    procedure ActionRetirarCotacaoExecute(Sender: TObject);
    procedure GridCompraRequisicaoDetalheUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure GridCompraCotacaoDetalheUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure GridDblClick(Sender: TObject);
  private
    { Private declarations }
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
  FCompraCotacao: TFCompraCotacao;

implementation

uses CompraFornecedorCotacaoVO, CompraCotacaoDetalheVO, ProdutoVO, ProdutoController,
  FornecedorVO, FornecedorController, CompraRequisicaoDetalheVO, CompraRequisicaoDetalheController,
  UDataModule, CompraReqCotacaoDetalheVO, CompraFornecedorCotacaoController,
  CompraCotacaoDetalheController, ViewCompraRequisicaoItemCotadoController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFCompraCotacao.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TCompraCotacaoVO;
  ObjetoController := TCompraCotacaoController.Create;
  inherited;
end;

procedure TFCompraCotacao.LimparCampos;
begin
  inherited;
  CDSCompraFornecedorCotacao.EmptyDataSet;
  CDSCompraCotacaoDetalhe.EmptyDataSet;
  CDSCompraRequisicaoDetalhe.EmptyDataSet;
end;

procedure TFCompraCotacao.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;
  if (StatusTela = stNavegandoEdits) or (StatusTela = stEditando) then
  begin
    PanelActions.Enabled := False;
  end
  else
  begin
    PanelActions.Enabled := True;
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFCompraCotacao.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditDataCotacao.SetFocus;
    EditDataCotacao.Date := Now;
    TCompraRequisicaoDetalheController.SetDataSet(CDSCompraRequisicaoDetalhe);
    TCompraRequisicaoDetalheController.Consulta('ITEM_COTADO=' + QuotedStr('N') + ' or ITEM_COTADO IS NULL', 0);
  end;
end;

function TFCompraCotacao.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;

  if Result then
  begin
    EditDataCotacao.SetFocus;
  end;
end;

function TFCompraCotacao.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TCompraCotacaoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TCompraCotacaoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFCompraCotacao.DoSalvar: Boolean;
var
  CompraFornecedorCotacao: TCompraFornecedorCotacaoVO;
  ListaCompraFornecedorCotacao: TObjectList<TCompraFornecedorCotacaoVO>;
  CompraCotacaoDetalhe: TCompraCotacaoDetalheVO;
  ListaCompraCotacaoDetalhe: TObjectList<TCompraCotacaoDetalheVO>;
  CompraReqCotacaoDetalhe: TCompraReqCotacaoDetalheVO;
begin
  if Application.MessageBox('Confirma a opera��o? Os fornecedores e os items n�o poder�o ser alterados depois.', 'Pergunta do sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin

    if Trim(EditDescricao.Text) = '' then
    begin
      Application.MessageBox('Informe a descri��o da cota��o.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      EditDescricao.SetFocus;
      Exit(False);
    end;
    if CDSCompraFornecedorCotacao.RecordCount = 0 then
    begin
      Application.MessageBox('� necess�rio informar pelo menos um fornecedor para a cota��o.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      GridCompraFornecedorCotacao.SetFocus;
      GridCompraFornecedorCotacao.SelectedIndex := 0;
      Exit(False);
    end;

    Result := inherited DoSalvar;

    if Result then
    begin
      try
        if not Assigned(ObjetoVO) then
          ObjetoVO := TCompraCotacaoVO.Create;

        TCompraCotacaoVO(ObjetoVO).DataCotacao := EditDataCotacao.Date;
        TCompraCotacaoVO(ObjetoVO).Descricao := EditDescricao.Text;
        TCompraCotacaoVO(ObjetoVO).Situacao := 'A';

        //As listas s� s�o levadas em conta no momento da inser��o. N�o � poss�vel alterar os dados da requisi��o
        if StatusTela = stInserindo then
        begin
          // Carrega os itens cotados na lista vinculada � cota��o
          TCompraCotacaoVO(ObjetoVO).ListaCompraReqCotacaoDetalheVO := TObjectList<TCompraReqCotacaoDetalheVO>.Create;
          CDSCompraRequisicaoDetalhe.DisableControls;
          CDSCompraRequisicaoDetalhe.First;
          while not CDSCompraRequisicaoDetalhe.Eof do
          begin
            if CDSCompraRequisicaoDetalheITEM_COTADO.AsString = 'S' then
            begin
              CompraReqCotacaoDetalhe := TCompraReqCotacaoDetalheVO.Create;
              CompraReqCotacaoDetalhe.IdCompraRequisicaoDetalhe := CDSCompraRequisicaoDetalheID.AsInteger;
              CompraReqCotacaoDetalhe.QuantidadeCotada := CDSCompraRequisicaoDetalheQUANTIDADE_COTADA.AsInteger;
              TCompraCotacaoVO(ObjetoVO).ListaCompraReqCotacaoDetalheVO.Add(CompraReqCotacaoDetalhe);
            end;
            CDSCompraRequisicaoDetalhe.Next;
          end;
          CDSCompraRequisicaoDetalhe.First;
          CDSCompraRequisicaoDetalhe.EnableControls;

          // Carrega os fornecedores numa lista
          ListaCompraFornecedorCotacao := TObjectList<TCompraFornecedorCotacaoVO>.Create;
          CDSCompraFornecedorCotacao.DisableControls;
          CDSCompraFornecedorCotacao.First;
          while not CDSCompraFornecedorCotacao.Eof do
          begin
            if (CDSCompraFornecedorCotacaoPERSISTE.AsString = 'S') or (CDSCompraFornecedorCotacaoID.AsInteger = 0) then
            begin
              CompraFornecedorCotacao := TCompraFornecedorCotacaoVO.Create;
              CompraFornecedorCotacao.Id := CDSCompraFornecedorCotacaoID.AsInteger;
              CompraFornecedorCotacao.IdFornecedor := CDSCompraFornecedorCotacaoID_FORNECEDOR.AsInteger;
              CompraFornecedorCotacao.IdCompraCotacao := TCompraCotacaoVO(ObjetoVO).Id;
              ListaCompraFornecedorCotacao.Add(CompraFornecedorCotacao);
            end;

            CDSCompraFornecedorCotacao.Next;
          end;
          CDSCompraFornecedorCotacao.First;
          CDSCompraFornecedorCotacao.EnableControls;

          // Carrega os produtos numa lista separada - nesse momento n�o existe necessidade de carregar os itens por fornecedor - no servidor � feito o devido tratamento
          ListaCompraCotacaoDetalhe := TObjectList<TCompraCotacaoDetalheVO>.Create;
          CDSCompraCotacaoDetalhe.DisableControls;
          CDSCompraCotacaoDetalhe.First;
          while not CDSCompraCotacaoDetalhe.Eof do
          begin
            if (CDSCompraCotacaoDetalhePERSISTE.AsString = 'S') or (CDSCompraCotacaoDetalheID.AsInteger = 0) then
            begin
              CompraCotacaoDetalhe := TCompraCotacaoDetalheVO.Create;
              CompraCotacaoDetalhe.Id := CDSCompraCotacaoDetalheID.AsInteger;
              CompraCotacaoDetalhe.IdCompraFornecedorCotacao := CompraFornecedorCotacao.Id;
              CompraCotacaoDetalhe.IdProduto := CDSCompraCotacaoDetalheID_PRODUTO.AsInteger;
              CompraCotacaoDetalhe.Quantidade := CDSCompraCotacaoDetalheQUANTIDADE.AsInteger;

              ListaCompraCotacaoDetalhe.Add(CompraCotacaoDetalhe);
            end;
            CDSCompraCotacaoDetalhe.Next;
          end;
          CDSCompraCotacaoDetalhe.First;
          CDSCompraCotacaoDetalhe.EnableControls;

          Result := TCompraCotacaoController(ObjetoController).Insere(TCompraCotacaoVO(ObjetoVO), ListaCompraFornecedorCotacao, ListaCompraCotacaoDetalhe);
        end
        else if StatusTela = stEditando then
          if TCompraCotacaoVO(ObjetoVO).ToJSONString <> TCompraCotacaoVO(ObjetoOldVO).ToJSONString then
          begin
            TCompraCotacaoVO(ObjetoVO).Id := IdRegistroSelecionado;
            Result := TCompraCotacaoController(ObjetoController).Altera(TCompraCotacaoVO(ObjetoVO), TCompraCotacaoVO(ObjetoOldVO));
          end
          else
            Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      except
        Result := False;
      end;
    end;
  end
  else
    Exit(False);
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFCompraCotacao.GridCompraFornecedorCotacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if StatusTela = stInserindo then
  begin
    if Key = VK_F1 then
    begin
      try
        PopulaCamposTransientesLookup(TFornecedorVO, TFornecedorController);
        if CDSTransiente.RecordCount > 0 then
        begin
          CDSCompraFornecedorCotacao.Append;
          CDSCompraFornecedorCotacaoID_FORNECEDOR.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
          CDSCompraFornecedorCotacaoFornecedorPessoaNome.AsString := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
          CDSCompraFornecedorCotacao.Post;
        end;
      finally
        CDSTransiente.Close;
      end;
    end;
  end;
end;

procedure TFCompraCotacao.GridCompraFornecedorCotacaoUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
begin
  //
end;

procedure TFCompraCotacao.GridCompraRequisicaoDetalheUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
begin
  //
end;

procedure TFCompraCotacao.GridCompraCotacaoDetalheUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
begin
  //
end;

procedure TFCompraCotacao.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TCompraCotacaoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TCompraCotacaoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditDataCotacao.Date := TCompraCotacaoVO(ObjetoVO).DataCotacao;
    EditDescricao.Text := TCompraCotacaoVO(ObjetoVO).Descricao;

    // Fornecedores da Cota��o
    TCompraFornecedorCotacaoController.SetDataSet(CDSCompraFornecedorCotacao);
    TCompraFornecedorCotacaoController.Consulta('ID_COMPRA_COTACAO=' + QuotedStr(IntToStr(TCompraCotacaoVO(ObjetoVO).Id)), 0);

    // Itens da Cota��o
    TCompraCotacaoDetalheController.SetDataSet(CDSCompraCotacaoDetalhe);
    TCompraCotacaoDetalheController.Consulta('ID_COMPRA_FORNECEDOR_COTACAO=' + QuotedStr(CDSCompraFornecedorCotacaoID.AsString), 0);

    // Carrega itens que foram cotados a partir da view
    TViewCompraRequisicaoItemCotadoController.SetDataSet(CDSCompraRequisicaoDetalhe);
    TViewCompraRequisicaoItemCotadoController.Consulta('ID_COTACAO=' + QuotedStr(IntToStr(TCompraCotacaoVO(ObjetoVO).Id)), 0);
  end;
end;

procedure TFCompraCotacao.CDSCompraFornecedorCotacaoAfterEdit(DataSet: TDataSet);
begin
  CDSCompraFornecedorCotacaoPERSISTE.AsString := 'S';
end;

procedure TFCompraCotacao.CDSCompraCotacaoDetalheAfterEdit(DataSet: TDataSet);
begin
  CDSCompraCotacaoDetalhePERSISTE.AsString := 'S';
end;

procedure TFCompraCotacao.CDSCompraRequisicaoDetalheAfterScroll(DataSet: TDataSet);
begin
  ConfigurarSpinQuantidade;
end;

procedure TFCompraCotacao.ConfigurarSpinQuantidade;
begin
  SpinEditQuantidade.MaxValue := CDSCompraRequisicaoDetalheQUANTIDADE.AsExtended - CDSCompraRequisicaoDetalheQUANTIDADE_COTADA.AsExtended;
  if CDSCompraRequisicaoDetalheQUANTIDADE.AsExtended - CDSCompraRequisicaoDetalheQUANTIDADE_COTADA.AsExtended = 0 then
  begin
    SpinEditQuantidade.Value := 0;
    SpinEditQuantidade.Enabled := False;
  end
  else
  begin
    SpinEditQuantidade.Enabled := True;
    SpinEditQuantidade.Value := CDSCompraRequisicaoDetalheQUANTIDADE.AsExtended - CDSCompraRequisicaoDetalheQUANTIDADE_COTADA.AsExtended;
  end;
end;

procedure TFCompraCotacao.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFCompraCotacao.ActionInserirCotacaoExecute(Sender: TObject);
begin
  if StatusTela = stInserindo then
  begin
    if not CDSCompraRequisicaoDetalhe.IsEmpty then
    begin
      if SpinEditQuantidade.Value = 0 then
      begin
        Application.MessageBox('Valor da quantidade deve ser maior que zero.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end
      else
      begin
        if CDSCompraRequisicaoDetalheITEM_COTADO.AsString = 'S' then
        begin
          Application.MessageBox('Esse item j� foi cotado nesta cota��o.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
        end
        else
        begin
          CDSCompraCotacaoDetalhe.Append;
          CDSCompraCotacaoDetalheID_PRODUTO.AsInteger := CDSCompraRequisicaoDetalheID_PRODUTO.AsInteger;
          CDSCompraCotacaoDetalhePRODUTONOME.AsString := CDSCompraRequisicaoDetalhePRODUTONOME.AsString;
          CDSCompraCotacaoDetalheQUANTIDADE.AsExtended := SpinEditQuantidade.Value;
          CDSCompraCotacaoDetalhe.Post;
          //
          CDSCompraRequisicaoDetalhe.Edit;
          CDSCompraRequisicaoDetalheQUANTIDADE_COTADA.AsExtended := CDSCompraRequisicaoDetalheQUANTIDADE_COTADA.AsExtended + SpinEditQuantidade.Value;
          CDSCompraRequisicaoDetalheITEM_COTADO.AsString := 'S';
          CDSCompraRequisicaoDetalhe.Post;
          //
          ConfigurarSpinQuantidade;
        end;
      end;
    end;
  end
  else
    Application.MessageBox('N�o � poss�vel alterar os dados da cota��o.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFCompraCotacao.ActionRetirarCotacaoExecute(Sender: TObject);
begin
  if StatusTela = stInserindo then
  begin
    if not CDSCompraCotacaoDetalhe.IsEmpty then
    begin
      CDSCompraRequisicaoDetalhe.DisableControls;
      CDSCompraRequisicaoDetalhe.First;
      while not CDSCompraRequisicaoDetalhe.Eof do
      begin
        if CDSCompraRequisicaoDetalheID_PRODUTO.AsInteger = CDSCompraCotacaoDetalheID_PRODUTO.AsInteger then
        begin
          CDSCompraRequisicaoDetalhe.Edit;
          CDSCompraRequisicaoDetalheQUANTIDADE_COTADA.AsExtended := CDSCompraRequisicaoDetalheQUANTIDADE_COTADA.AsExtended - CDSCompraCotacaoDetalheQUANTIDADE.AsExtended;
          CDSCompraRequisicaoDetalheITEM_COTADO.AsString := 'N';
          CDSCompraRequisicaoDetalhe.Post;
          Break;
        end;
        CDSCompraRequisicaoDetalhe.Next;
      end;
      CDSCompraCotacaoDetalhe.Delete;
      CDSCompraRequisicaoDetalhe.First;
      CDSCompraRequisicaoDetalhe.EnableControls;
    end;
  end
  else
    Application.MessageBox('N�o � poss�vel alterar os dados da cota��o.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
end;
{$ENDREGION}

end.
