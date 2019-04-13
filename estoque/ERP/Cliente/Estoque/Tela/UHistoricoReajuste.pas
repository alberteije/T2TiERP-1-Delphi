{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Para Reajustar Preços de Mercadorias e Manter um Histórico

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
  t2ti.com@gmail.com

  @author Albert Eije (alberteije@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit UHistoricoReajuste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos, Constantes,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, DB, DBClient, Generics.Collections,
  ActnList, RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, Biblioteca,
  StrUtils;

type
  [TFormDescription(TConstantes.MODULO_ESTOQUE, 'Contagem de Estoque')]

  TFHistoricoReajuste = class(TFTelaCadastro)
    BevelEdits: TBevel;
    CDSEstoqueReajusteDetalhe: TClientDataSet;
    DSEstoqueReajusteDetalhe: TDataSource;
    GroupBoxParcelas: TGroupBox;
    GridItens: TJvDBUltimGrid;
    ActionManager: TActionManager;
    ActionSelecionarItens: TAction;
    ActionRealizarCalculos: TAction;
    ActionToolBarEdits: TActionToolBar;
    EditIdColaborador: TLabeledCalcEdit;
    EditColaborador: TLabeledEdit;
    EditDataReajuste: TLabeledDateEdit;
    EditPorcentagemReajuste: TLabeledCalcEdit;
    ComboBoxTipoReajuste: TLabeledComboBox;
    CDSEstoqueReajusteDetalheID: TIntegerField;
    CDSEstoqueReajusteDetalheID_PRODUTO: TIntegerField;
    CDSEstoqueReajusteDetalheVALOR_ORIGINAL: TFloatField;
    CDSEstoqueReajusteDetalheVALOR_REAJUSTE: TFloatField;
    CDSEstoqueReajusteDetalhePRODUTONOME: TStringField;
    CDSProduto: TClientDataSet;
    CDSProdutoID: TIntegerField;
    CDSProdutoNOME: TStringField;
    DSProduto: TDataSource;
    CDSEstoqueReajusteDetalheID_ESTOQUE_REAJUSTE_CABECALHO: TIntegerField;
    CDSProdutoVALOR_VENDA: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure ActionSelecionarItensExecute(Sender: TObject);
    procedure ActionRealizarCalculosExecute(Sender: TObject);
    procedure EditIdColaboradorExit(Sender: TObject);
    procedure EditIdColaboradorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
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
  end;

var
  FHistoricoReajuste: TFHistoricoReajuste;

implementation

uses EstoqueReajusteCabecalhoController, EstoqueReajusteCabecalhoVO,
  EstoqueReajusteDetalheVO, UDataModule, ProdutoVO, ProdutoController,
  ColaboradorVO, ColaboradorController, ProdutoSubGrupoVO, ProdutoSubGrupoController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFHistoricoReajuste.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TEstoqueReajusteCabecalhoVO;
  ObjetoController := TEstoqueReajusteCabecalhoController.Create;

  inherited;
end;

procedure TFHistoricoReajuste.LimparCampos;
begin
  inherited;
  CDSEstoqueReajusteDetalhe.EmptyDataSet;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFHistoricoReajuste.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFHistoricoReajuste.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFHistoricoReajuste.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TEstoqueReajusteCabecalhoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TEstoqueReajusteCabecalhoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFHistoricoReajuste.DoSalvar: Boolean;
var
  EstoqueReajusteDetalhe: TEstoqueReajusteDetalheVO;
begin
  DecimalSeparator := '.';
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      ObjetoVO := TEstoqueReajusteCabecalhoVO.Create;

      TEstoqueReajusteCabecalhoVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TEstoqueReajusteCabecalhoVO(ObjetoVO).ColaboradorPessoaNome := EditColaborador.Text;
      TEstoqueReajusteCabecalhoVO(ObjetoVO).DataReajuste := EditDataReajuste.Date;
      TEstoqueReajusteCabecalhoVO(ObjetoVO).Porcentagem := EditPorcentagemReajuste.Value;
      TEstoqueReajusteCabecalhoVO(ObjetoVO).TipoReajuste := Copy(ComboBoxTipoReajuste.Text, 1, 1);

      // Itens
      CDSEstoqueReajusteDetalhe.DisableControls;
      CDSEstoqueReajusteDetalhe.First;
      while not CDSEstoqueReajusteDetalhe.Eof do
      begin
        EstoqueReajusteDetalhe := TEstoqueReajusteDetalheVO.Create;
        EstoqueReajusteDetalhe.Id := CDSEstoqueReajusteDetalheID.AsInteger;
        EstoqueReajusteDetalhe.IdEstoqueReajusteCabecalho := TEstoqueReajusteCabecalhoVO(ObjetoVO).Id;
        EstoqueReajusteDetalhe.IdProduto := CDSEstoqueReajusteDetalheID_PRODUTO.AsInteger;
        EstoqueReajusteDetalhe.ProdutoNome := CDSEstoqueReajusteDetalhePRODUTONOME.AsString;
        EstoqueReajusteDetalhe.ValorOriginal := CDSEstoqueReajusteDetalheVALOR_ORIGINAL.AsFloat;
        EstoqueReajusteDetalhe.ValorReajuste := CDSEstoqueReajusteDetalheVALOR_REAJUSTE.AsFloat;

        TEstoqueReajusteCabecalhoVO(ObjetoVO).ListaEstoqueReajusteDetalheVO.Add(EstoqueReajusteDetalhe);

        CDSEstoqueReajusteDetalhe.Next;
      end;
      CDSEstoqueReajusteDetalhe.EnableControls;

      // ObjetoVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      TEstoqueReajusteCabecalhoVO(ObjetoVO).ColaboradorVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TEstoqueReajusteCabecalhoVO(ObjetoOldVO).ColaboradorVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TEstoqueReajusteCabecalhoController(ObjetoController).Insere(TEstoqueReajusteCabecalhoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TEstoqueReajusteCabecalhoVO(ObjetoVO).ToJSONString <> TEstoqueReajusteCabecalhoVO(ObjetoOldVO).ToJSONString then
        begin
          TEstoqueReajusteCabecalhoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TEstoqueReajusteCabecalhoController(ObjetoController).Altera(TEstoqueReajusteCabecalhoVO(ObjetoVO), TEstoqueReajusteCabecalhoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
      DecimalSeparator := ',';
      Result := True;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFHistoricoReajuste.EditIdColaboradorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdColaborador.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdColaborador.Text;
      EditIdColaborador.Clear;
      EditColaborador.Clear;
      if not PopulaCamposTransientes(Filtro, TColaboradorVO, TColaboradorController) then
        PopulaCamposTransientesLookup(TColaboradorVO, TColaboradorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdColaborador.Text := CDSTransiente.FieldByName('ID').AsString;
        EditColaborador.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
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
    EditColaborador.Clear;
  end;
end;

procedure TFHistoricoReajuste.EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdColaborador.Value := -1;
    ComboBoxTipoReajuste.SetFocus;
  end;
end;

procedure TFHistoricoReajuste.EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ComboBoxTipoReajuste.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFHistoricoReajuste.GridParaEdits;
var
  EstoqueReajusteDetalheEnumerator: TEnumerator<TEstoqueReajusteDetalheVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TEstoqueReajusteCabecalhoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TEstoqueReajusteCabecalhoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdColaborador.AsInteger := TEstoqueReajusteCabecalhoVO(ObjetoVO).IdColaborador;
    EditColaborador.Text := TEstoqueReajusteCabecalhoVO(ObjetoVO).ColaboradorPessoaNome;
    EditDataReajuste.Date := TEstoqueReajusteCabecalhoVO(ObjetoVO).DataReajuste;
    EditPorcentagemReajuste.Value := TEstoqueReajusteCabecalhoVO(ObjetoVO).Porcentagem;

    ComboBoxTipoReajuste.ItemIndex := AnsiIndexStr(TEstoqueReajusteCabecalhoVO(ObjetoVO).TipoReajuste, ['A', 'D']);

    // Itens
    EstoqueReajusteDetalheEnumerator := TEstoqueReajusteCabecalhoVO(ObjetoVO).ListaEstoqueReajusteDetalheVO.GetEnumerator;
    try
      with EstoqueReajusteDetalheEnumerator do
      begin
        while MoveNext do
        begin
          CDSEstoqueReajusteDetalhe.Append;

          CDSEstoqueReajusteDetalheID.AsInteger := Current.Id;
          CDSEstoqueReajusteDetalheID_PRODUTO.AsInteger := Current.IdProduto;
          CDSEstoqueReajusteDetalhePRODUTONOME.AsString := Current.ProdutoVO.Nome;
          CDSEstoqueReajusteDetalheID_ESTOQUE_REAJUSTE_CABECALHO.AsInteger := Current.IdEstoqueReajusteCabecalho;
          CDSEstoqueReajusteDetalheVALOR_ORIGINAL.AsFloat := Current.ValorOriginal;
          CDSEstoqueReajusteDetalheVALOR_REAJUSTE.AsFloat := Current.ValorReajuste;

          CDSEstoqueReajusteDetalhe.Post;
        end;
      end;
    finally
      EstoqueReajusteDetalheEnumerator.Free;
    end;
    TEstoqueReajusteCabecalhoVO(ObjetoVO).ListaEstoqueReajusteDetalheVO := Nil;
    if Assigned(TEstoqueReajusteCabecalhoVO(ObjetoOldVO)) then
      TEstoqueReajusteCabecalhoVO(ObjetoOldVO).ListaEstoqueReajusteDetalheVO := Nil;
  end;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFHistoricoReajuste.ActionSelecionarItensExecute(Sender: TObject);
var
  Filtro: String;
begin
  //Filtra os produtos por SubGrupo
  PopulaCamposTransientesLookup(TProdutoSubGrupoVO, TProdutoSubGrupoController);

  if CDSTransiente.RecordCount > 0 then
  begin
    Filtro := 'ID_SUB_GRUPO = ' + CDSTransiente.FieldByName('ID').AsString;

    TProdutoController.SetDataSet(CDSProduto);
    TProdutoController.Consulta(Filtro, 0);

    CDSProduto.First;
    while not CDSProduto.Eof do
    begin
      CDSEstoqueReajusteDetalhe.Append;

      CDSEstoqueReajusteDetalheID_PRODUTO.AsInteger := CDSProduto.FieldByName('ID').AsInteger;
      CDSEstoqueReajusteDetalhePRODUTONOME.AsString := CDSProduto.FieldByName('NOME').AsString;
      CDSEstoqueReajusteDetalheID_ESTOQUE_REAJUSTE_CABECALHO.AsInteger := 0;
      CDSEstoqueReajusteDetalheVALOR_ORIGINAL.AsFloat := CDSProduto.FieldByName('VALOR_VENDA').AsFloat;
      CDSEstoqueReajusteDetalheVALOR_REAJUSTE.AsFloat := 0;

      CDSEstoqueReajusteDetalhe.Post;
      CDSProduto.Next;
    end;
  end;
end;

procedure TFHistoricoReajuste.ActionRealizarCalculosExecute(Sender: TObject);
begin
  CDSEstoqueReajusteDetalhe.DisableControls;
  CDSEstoqueReajusteDetalhe.First;
  while not CDSEstoqueReajusteDetalhe.Eof do
  begin
    CDSEstoqueReajusteDetalhe.Edit;
    if ComboBoxTipoReajuste.ItemIndex = 0 then
      CDSEstoqueReajusteDetalheVALOR_REAJUSTE.AsFloat := CDSEstoqueReajusteDetalheVALOR_ORIGINAL.AsFloat * (1 + (EditPorcentagemReajuste.Value / 100))
    else
      CDSEstoqueReajusteDetalheVALOR_REAJUSTE.AsFloat := CDSEstoqueReajusteDetalheVALOR_ORIGINAL.AsFloat * (1 - (EditPorcentagemReajuste.Value / 100));

    CDSEstoqueReajusteDetalhe.Post;
    CDSEstoqueReajusteDetalhe.Next;
  end;
  CDSEstoqueReajusteDetalhe.First;
  CDSEstoqueReajusteDetalhe.EnableControls;
end;
{$ENDREGION}

end.
