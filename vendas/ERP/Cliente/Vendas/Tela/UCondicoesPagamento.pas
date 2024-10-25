{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Cadastro das Condi��es de Pagamento

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

  @author Albert Eije
  @version 1.0
  ******************************************************************************* }
unit UCondicoesPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos, Constantes,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, DB, DBClient, Generics.Collections;

type
  [TFormDescription(TConstantes.MODULO_VENDAS, 'Condi��es de Pagamento')]

  TFCondicoesPagamento = class(TFTelaCadastro)
    EditNome: TLabeledEdit;
    BevelEdits: TBevel;
    MemoDescricao: TLabeledMemo;
    EditFaturamentoMinimo: TLabeledCalcEdit;
    EditFaturamentoMaximo: TLabeledCalcEdit;
    EditDiasTolerancia: TLabeledCalcEdit;
    EditValorTolerancia: TLabeledCalcEdit;
    EditPrazoMedio: TLabeledCalcEdit;
    EditIndiceCorrecao: TLabeledCalcEdit;
    CDSCondicoesParcelas: TClientDataSet;
    DSCondicoesParcelas: TDataSource;
    GroupBoxParcelas: TGroupBox;
    GridParcelas: TJvDBUltimGrid;
    CDSCondicoesParcelasID: TIntegerField;
    CDSCondicoesParcelasID_CONDICOES_PAGAMENTO: TIntegerField;
    CDSCondicoesParcelasPARCELA: TIntegerField;
    CDSCondicoesParcelasDIAS: TIntegerField;
    CDSCondicoesParcelasTAXA: TFloatField;
    CDSCondicoesParcelasPERSISTE: TStringField;
    PopupMenuParcelas: TPopupMenu;
    ExcluirParcela1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure CDSCondicoesParcelasAfterEdit(DataSet: TDataSet);
    procedure ExcluirParcela1Click(Sender: TObject);
    function VerificarParcelas: Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FCondicoesPagamento: TFCondicoesPagamento;

implementation

uses UDataModule, VendaCondicoesPagamentoController, VendaCondicoesPagamentoVO,
  VendaCondicoesParcelasVO, VendaCondicoesParcelasController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFCondicoesPagamento.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TVendaCondicoesPagamentoVO;
  ObjetoController := TVendaCondicoesPagamentoController.Create;

  inherited;
end;

procedure TFCondicoesPagamento.LimparCampos;
begin
  inherited;
  // Condi��es Parcelas
  CDSCondicoesParcelas.EmptyDataSet;
end;

procedure TFCondicoesPagamento.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFCondicoesPagamento.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFCondicoesPagamento.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

procedure TFCondicoesPagamento.CDSCondicoesParcelasAfterEdit(DataSet: TDataSet);
begin
  CDSCondicoesParcelasPERSISTE.AsString := 'S';
end;

function TFCondicoesPagamento.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFCondicoesPagamento.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TVendaCondicoesPagamentoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TVendaCondicoesPagamentoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFCondicoesPagamento.DoSalvar: Boolean;
var
  CondicoesParcelas: TVendaCondicoesParcelasVO;
begin
  if not VerificarParcelas then begin
    Application.MessageBox('Os valores informados nas taxas n�o fecham em 100%.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    GridParcelas.SetFocus;
    Exit(False);
  end;

  DecimalSeparator := '.';
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TVendaCondicoesPagamentoVO.Create;

      TVendaCondicoesPagamentoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TVendaCondicoesPagamentoVO(ObjetoVO).Nome := EditNome.Text;
      TVendaCondicoesPagamentoVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TVendaCondicoesPagamentoVO(ObjetoVO).FaturamentoMinimo := EditFaturamentoMinimo.Value;
      TVendaCondicoesPagamentoVO(ObjetoVO).FaturamentoMaximo := EditFaturamentoMaximo.Value;
      TVendaCondicoesPagamentoVO(ObjetoVO).IndiceCorrecao := EditIndiceCorrecao.Value;
      TVendaCondicoesPagamentoVO(ObjetoVO).DiasTolerancia := EditDiasTolerancia.AsInteger;
      TVendaCondicoesPagamentoVO(ObjetoVO).ValorTolerancia := EditValorTolerancia.Value;
      TVendaCondicoesPagamentoVO(ObjetoVO).PrazoMedio := EditPrazoMedio.AsInteger;

      if StatusTela = stEditando then
        TVendaCondicoesPagamentoVO(ObjetoVO).Id := IdRegistroSelecionado;

      // Condi��es - Parcelas
      TVendaCondicoesPagamentoVO(ObjetoVO).ListaVendaCondicoesParcelasVO := TObjectList<TVendaCondicoesParcelasVO>.Create;
      CDSCondicoesParcelas.DisableControls;
      CDSCondicoesParcelas.First;
      while not CDSCondicoesParcelas.Eof do
      begin
        if (CDSCondicoesParcelasPERSISTE.AsString = 'S') or (CDSCondicoesParcelasID.AsInteger = 0) then
        begin
          CondicoesParcelas := TVendaCondicoesParcelasVO.Create;
          CondicoesParcelas.Id := CDSCondicoesParcelasID.AsInteger;
          CondicoesParcelas.IdVendaCondicoesPagamento := TVendaCondicoesPagamentoVO(ObjetoVO).Id;
          CondicoesParcelas.Parcela := CDSCondicoesParcelasPARCELA.AsInteger;
          CondicoesParcelas.Dias := CDSCondicoesParcelasDIAS.AsInteger;
          CondicoesParcelas.Taxa := CDSCondicoesParcelasTAXA.AsFloat;

          TVendaCondicoesPagamentoVO(ObjetoVO).ListaVendaCondicoesParcelasVO.Add(CondicoesParcelas);
        end;
        CDSCondicoesParcelas.Next;
      end;
      CDSCondicoesParcelas.EnableControls;

      if StatusTela = stInserindo then
        Result := TVendaCondicoesPagamentoController(ObjetoController).Insere(TVendaCondicoesPagamentoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TVendaCondicoesPagamentoVO(ObjetoVO).ToJSONString <> TVendaCondicoesPagamentoVO(ObjetoOldVO).ToJSONString then
        begin
          TVendaCondicoesPagamentoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TVendaCondicoesPagamentoController(ObjetoController).Altera(TVendaCondicoesPagamentoVO(ObjetoVO), TVendaCondicoesPagamentoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
  DecimalSeparator := ',';
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFCondicoesPagamento.GridParaEdits;
var
  CondicoesParcelasEnumerator: TEnumerator<TVendaCondicoesParcelasVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TVendaCondicoesPagamentoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TVendaCondicoesPagamentoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditNome.Text := TVendaCondicoesPagamentoVO(ObjetoVO).Nome;
    MemoDescricao.Text := TVendaCondicoesPagamentoVO(ObjetoVO).Descricao;
    EditFaturamentoMinimo.Value := TVendaCondicoesPagamentoVO(ObjetoVO).FaturamentoMinimo;
    EditFaturamentoMaximo.Value := TVendaCondicoesPagamentoVO(ObjetoVO).FaturamentoMaximo;
    EditIndiceCorrecao.Value := TVendaCondicoesPagamentoVO(ObjetoVO).IndiceCorrecao;
    EditDiasTolerancia.AsInteger := TVendaCondicoesPagamentoVO(ObjetoVO).DiasTolerancia;
    EditValorTolerancia.Value := TVendaCondicoesPagamentoVO(ObjetoVO).ValorTolerancia;
    EditPrazoMedio.AsInteger := TVendaCondicoesPagamentoVO(ObjetoVO).PrazoMedio;

    // Condi��es Parcelas
    CondicoesParcelasEnumerator := TVendaCondicoesPagamentoVO(ObjetoVO).ListaVendaCondicoesParcelasVO.GetEnumerator;
    try
      with CondicoesParcelasEnumerator do
      begin
        while MoveNext do
        begin
          CDSCondicoesParcelas.Append;

          CDSCondicoesParcelasID.AsInteger := Current.Id;
          CDSCondicoesParcelasID_CONDICOES_PAGAMENTO.AsInteger := Current.IdVendaCondicoesPagamento;
          CDSCondicoesParcelasPARCELA.AsInteger := Current.Parcela;
          CDSCondicoesParcelasDIAS.AsInteger := Current.Dias;
          CDSCondicoesParcelasTAXA.AsFloat := Current.Taxa;

          CDSCondicoesParcelas.Post;
        end;
      end;
    finally
      CondicoesParcelasEnumerator.Free;
    end;
    TVendaCondicoesPagamentoVO(ObjetoVO).ListaVendaCondicoesParcelasVO := Nil;
    if Assigned(TVendaCondicoesPagamentoVO(ObjetoOldVO)) then
      TVendaCondicoesPagamentoVO(ObjetoOldVO).ListaVendaCondicoesParcelasVO := Nil;
  end;
end;

procedure TFCondicoesPagamento.ExcluirParcela1Click(Sender: TObject);
begin
  if CDSCondicoesParcelas.IsEmpty then
    Application.MessageBox('N�o existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      if StatusTela = stInserindo then
        CDSCondicoesParcelas.Delete
      else if StatusTela = stEditando then
      begin
        if TVendaCondicoesParcelasController.Exclui(CDSCondicoesParcelasID.AsInteger) then
          CDSCondicoesParcelas.Delete;
      end;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Actions'}
function TFCondicoesPagamento.VerificarParcelas: Boolean;
var
  TotalPorcento: Double;
  ListaDiasParcela: TStringList;
  i: Integer;
  PrazoMedio: Integer;
begin
  Result := False;
  //
  if CDSCondicoesParcelas.IsEmpty then
    exit(True);

  ListaDiasParcela := TStringList.Create;
  TotalPorcento := 0;
  PrazoMedio := 0;
  //
  CDSCondicoesParcelas.DisableControls;
  CDSCondicoesParcelas.First;
  while not CDSCondicoesParcelas.Eof do
  begin
    TotalPorcento := TotalPorcento + CDSCondicoesParcelasTAXA.AsFloat;
    ListaDiasParcela.Add(CDSCondicoesParcelasDIAS.AsString);
    CDSCondicoesParcelas.Next;
  end;
  CDSCondicoesParcelas.First;
  CDSCondicoesParcelas.EnableControls;

  //Calcula o prazo m�dio
  for i := 0 to ListaDiasParcela.Count - 1 do
  begin
    if i = 0 then
      PrazoMedio := StrToInt(ListaDiasParcela[i])
    else
      PrazoMedio := PrazoMedio + (StrToInt(ListaDiasParcela[i]) - StrToInt(ListaDiasParcela[i-1]));
  end;
  EditPrazoMedio.AsInteger := Trunc(PrazoMedio / ListaDiasParcela.Count);

  //
  if (TotalPorcento = 100) or (CDSCondicoesParcelas.IsEmpty) then
    Result := True;
end;
{$ENDREGION}

end.
