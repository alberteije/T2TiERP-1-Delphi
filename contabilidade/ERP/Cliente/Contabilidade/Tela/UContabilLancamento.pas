{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Lan�amentos para o m�dulo Contabilidade

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
unit UContabilLancamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ContabilLancamentoCabecalhoVO,
  ContabilLancamentoCabecalhoController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls;

type
  [TFormDescription(TConstantes.MODULO_CONTABILIDADE, 'Lan�amento Cont�bil')]

  TFContabilLancamento = class(TFTelaCadastro)
    DSContabilLancamentoDetalhe: TDataSource;
    CDSContabilLancamentoDetalhe: TClientDataSet;
    PanelMestre: TPanel;
    EditIdLote: TLabeledCalcEdit;
    EditLote: TLabeledEdit;
    PageControlItens: TPageControl;
    tsItens: TTabSheet;
    PanelItens: TPanel;
    GridDetalhe: TJvDBUltimGrid;
    ComboBoxTipo: TLabeledComboBox;
    CDSContabilLancamentoDetalheID: TIntegerField;
    CDSContabilLancamentoDetalheID_CONTABIL_CONTA: TIntegerField;
    CDSContabilLancamentoDetalheID_CONTABIL_HISTORICO: TIntegerField;
    CDSContabilLancamentoDetalheID_CONTABIL_LANCAMENTO_CAB: TIntegerField;
    CDSContabilLancamentoDetalheHISTORICO: TStringField;
    CDSContabilLancamentoDetalheTIPO: TStringField;
    CDSContabilLancamentoDetalheVALOR: TFMTBCDField;
    EditDataLancamento: TLabeledDateEdit;
    EditDataInclusao: TLabeledDateEdit;
    ComboBoxLiberado: TLabeledComboBox;
    CDSContabilLancamentoDetalhePERSISTE: TStringField;
    CDSContabilLancamentoDetalheCONTABIL_CONTACLASSIFICACAO: TStringField;
    EditValor: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdLoteExit(Sender: TObject);
    procedure EditIdLoteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSContabilLancamentoDetalheAfterEdit(DataSet: TDataSet);
    procedure EditIdLoteKeyPress(Sender: TObject; var Key: Char);
    procedure GridDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    function VerificarLancamentos: Boolean;
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

    procedure ConfigurarLayoutTela;
  end;

var
  FContabilLancamento: TFContabilLancamento;

implementation

uses ULookup, Biblioteca, UDataModule, ContabilLancamentoDetalheVO, ContabilLoteVO,
ContabilLoteController, ContabilContaVO, ContabilContaController, ContabilHistoricoVO,
ContabilHistoricoController;
{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFContabilLancamento.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContabilLancamentoCabecalhoVO;
  ObjetoController := TContabilLancamentoCabecalhoController.Create;

  inherited;
end;

procedure TFContabilLancamento.LimparCampos;
begin
  inherited;
  CDSContabilLancamentoDetalhe.EmptyDataSet;
end;

procedure TFContabilLancamento.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;

  if StatusTela = stNavegandoEdits then
  begin
    PanelMestre.Enabled := False;
    PanelItens.Enabled := False;
  end
  else
  begin
    PanelMestre.Enabled := True;
    PanelItens.Enabled := True;
  end;
end;

procedure TFContabilLancamento.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFContabilLancamento.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFContabilLancamento.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdLote.SetFocus;
  end;
end;

function TFContabilLancamento.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdLote.SetFocus;
  end;
end;

function TFContabilLancamento.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TContabilLancamentoCabecalhoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TContabilLancamentoCabecalhoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFContabilLancamento.DoSalvar: Boolean;
var
  ContabilLancamentoDetalhe: TContabilLancamentoDetalheVO;
begin
  if VerificarLancamentos then
  begin
    DecimalSeparator := '.';

    Result := inherited DoSalvar;

    if Result then
    begin
      try
        if not Assigned(ObjetoVO) then
          ObjetoVO := TContabilLancamentoCabecalhoVO.Create;

        TContabilLancamentoCabecalhoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
        TContabilLancamentoCabecalhoVO(ObjetoVO).IdContabilLote := EditIdLote.AsInteger;
        TContabilLancamentoCabecalhoVO(ObjetoVO).LoteDescricao := EditLote.Text;
        TContabilLancamentoCabecalhoVO(ObjetoVO).DataLancamento := EditDataLancamento.Date;
        TContabilLancamentoCabecalhoVO(ObjetoVO).DataInclusao := EditDataInclusao.Date;
        TContabilLancamentoCabecalhoVO(ObjetoVO).Liberado := IfThen(ComboBoxLiberado.ItemIndex = 0, 'S', 'N');
        TContabilLancamentoCabecalhoVO(ObjetoVO).Valor := EditValor.Value;
        TContabilLancamentoCabecalhoVO(ObjetoVO).Tipo := Copy(ComboBoxTipo.Text, 1, 4);

        // Detalhes
        TContabilLancamentoCabecalhoVO(ObjetoVO).ListaContabilLancamentoDetalheVO := TObjectList<TContabilLancamentoDetalheVO>.Create;
        CDSContabilLancamentoDetalhe.DisableControls;
        CDSContabilLancamentoDetalhe.First;
        while not CDSContabilLancamentoDetalhe.Eof do
        begin
          if (CDSContabilLancamentoDetalhePERSISTE.AsString = 'S') or (CDSContabilLancamentoDetalheID.AsInteger = 0) then
          begin
            ContabilLancamentoDetalhe := TContabilLancamentoDetalheVO.Create;
            ContabilLancamentoDetalhe.Id := CDSContabilLancamentoDetalheID.AsInteger;
            ContabilLancamentoDetalhe.IdContabilLancamentoCab := TContabilLancamentoCabecalhoVO(ObjetoVO).Id;
            ContabilLancamentoDetalhe.IdContabilConta := CDSContabilLancamentoDetalheID_CONTABIL_CONTA.AsInteger;
            ContabilLancamentoDetalhe.IdContabilHistorico := CDSContabilLancamentoDetalheID_CONTABIL_HISTORICO.AsInteger;
            ContabilLancamentoDetalhe.Historico := CDSContabilLancamentoDetalheHISTORICO.AsString;
            ContabilLancamentoDetalhe.Tipo := CDSContabilLancamentoDetalheTIPO.AsString;
            ContabilLancamentoDetalhe.Valor := CDSContabilLancamentoDetalheVALOR.AsFloat;
            TContabilLancamentoCabecalhoVO(ObjetoVO).ListaContabilLancamentoDetalheVO.Add(ContabilLancamentoDetalhe);
          end;
          CDSContabilLancamentoDetalhe.Next;
        end;
        CDSContabilLancamentoDetalhe.EnableControls;

        TContabilLancamentoCabecalhoVO(ObjetoVO).ContabilLoteVO := Nil;
        if Assigned(ObjetoOldVO) then
        begin
          TContabilLancamentoCabecalhoVO(ObjetoOldVO).ContabilLoteVO := Nil;
        end;

        if StatusTela = stInserindo then
          Result := TContabilLancamentoCabecalhoController(ObjetoController).Insere(TContabilLancamentoCabecalhoVO(ObjetoVO))
        else if StatusTela = stEditando then
        begin
          if TContabilLancamentoCabecalhoVO(ObjetoVO).ToJSONString <> TContabilLancamentoCabecalhoVO(ObjetoOldVO).ToJSONString then
          begin
            Result := TContabilLancamentoCabecalhoController(ObjetoController).Altera(TContabilLancamentoCabecalhoVO(ObjetoVO), TContabilLancamentoCabecalhoVO(ObjetoOldVO));
          end
          else
            Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
        end;
      except
        Result := False;
      end;
    end;
    DecimalSeparator := ',';
  end
  else
    Exit(False);
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFContabilLancamento.CDSContabilLancamentoDetalheAfterEdit(DataSet: TDataSet);
begin
  CDSContabilLancamentoDetalhePERSISTE.AsString := 'S';
end;

procedure TFContabilLancamento.GridDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    try
      if GridDetalhe.Columns[GridDetalhe.SelectedIndex].Field.FieldName = 'ID_CONTABIL_CONTA' then
      begin
        PopulaCamposTransientesLookup(TContabilContaVO, TContabilContaController);
        if CDSTransiente.RecordCount > 0 then
        begin
          CDSContabilLancamentoDetalhe.Edit;
          CDSContabilLancamentoDetalheID_CONTABIL_CONTA.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
          CDSContabilLancamentoDetalheCONTABIL_CONTACLASSIFICACAO.AsString := CDSTransiente.FieldByName('CLASSIFICACAO').AsString;
          CDSContabilLancamentoDetalheTIPO.AsString := CDSTransiente.FieldByName('NATUREZA').AsString;
          CDSContabilLancamentoDetalhe.Post;
        end;
      end
      else if GridDetalhe.Columns[GridDetalhe.SelectedIndex].Field.FieldName = 'HISTORICO' then
      begin
        PopulaCamposTransientesLookup(TContabilHistoricoVO, TContabilHistoricoController);
        if CDSTransiente.RecordCount > 0 then
        begin
          CDSContabilLancamentoDetalhe.Edit;
          CDSContabilLancamentoDetalheID_CONTABIL_HISTORICO.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
          CDSContabilLancamentoDetalheHISTORICO.AsString := CDSTransiente.FieldByName('HISTORICO').AsString;
          CDSContabilLancamentoDetalhe.Post;
        end;
      end;
    finally
      CDSTransiente.Close;
    end;
  end;
  If Key = VK_RETURN then
    EditIdLote.SetFocus;
end;

procedure TFContabilLancamento.GridParaEdits;
var
  ContabilLancamentoDetalheEnumerator: TEnumerator<TContabilLancamentoDetalheVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TContabilLancamentoCabecalhoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TContabilLancamentoCabecalhoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdLote.AsInteger := TContabilLancamentoCabecalhoVO(ObjetoVO).IdContabilLote;
    EditLote.Text := TContabilLancamentoCabecalhoVO(ObjetoVO).LoteDescricao;
    EditDataLancamento.Date := TContabilLancamentoCabecalhoVO(ObjetoVO).DataLancamento;
    EditDataInclusao.Date := TContabilLancamentoCabecalhoVO(ObjetoVO).DataInclusao;
    ComboBoxLiberado.ItemIndex := AnsiIndexStr(TContabilLancamentoCabecalhoVO(ObjetoVO).Liberado, ['S', 'N']);
    EditValor.Value := TContabilLancamentoCabecalhoVO(ObjetoVO).Valor;
    ComboBoxTipo.ItemIndex := AnsiIndexStr(TContabilLancamentoCabecalhoVO(ObjetoVO).Tipo, ['UDVC', 'UCVD', 'UDUC', 'VDVC']);

    // Detalhes
    ContabilLancamentoDetalheEnumerator := TContabilLancamentoCabecalhoVO(ObjetoVO).ListaContabilLancamentoDetalheVO.GetEnumerator;
    try
      with ContabilLancamentoDetalheEnumerator do
      begin
        while MoveNext do
        begin
          CDSContabilLancamentoDetalhe.Append;
          CDSContabilLancamentoDetalheID.AsInteger := Current.id;
          CDSContabilLancamentoDetalheID_CONTABIL_LANCAMENTO_CAB.AsInteger := Current.IdContabilLancamentoCab;
          CDSContabilLancamentoDetalheID_CONTABIL_CONTA.AsInteger := Current.IdContabilConta;
          CDSContabilLancamentoDetalheCONTABIL_CONTACLASSIFICACAO.AsString := Current.ContabilContaVO.Classificacao;
          CDSContabilLancamentoDetalheID_CONTABIL_HISTORICO.AsInteger := Current.IdContabilHistorico;
          CDSContabilLancamentoDetalheHISTORICO.AsString := Current.Historico;
          CDSContabilLancamentoDetalheTIPO.AsString := Current.Tipo;
          CDSContabilLancamentoDetalheVALOR.AsExtended := Current.Valor;
          CDSContabilLancamentoDetalhe.Post;
        end;
      end;
    finally
      ContabilLancamentoDetalheEnumerator.Free;
    end;

    TContabilLancamentoCabecalhoVO(ObjetoVO).ListaContabilLancamentoDetalheVO := Nil;
    if Assigned(TContabilLancamentoCabecalhoVO(ObjetoOldVO)) then
      TContabilLancamentoCabecalhoVO(ObjetoOldVO).ListaContabilLancamentoDetalheVO := Nil;
  end;

  ConfigurarLayoutTela;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFContabilLancamento.EditIdLoteExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdLote.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdLote.Text;
      EditIdLote.Clear;
      EditLote.Clear;
      if not PopulaCamposTransientes(Filtro, TContabilLoteVO, TContabilLoteController) then
        PopulaCamposTransientesLookup(TContabilLoteVO, TContabilLoteController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdLote.Text := CDSTransiente.FieldByName('ID').AsString;
        EditLote.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditIdLote.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditLote.Clear;
  end;
end;

procedure TFContabilLancamento.EditIdLoteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdLote.Value := -1;
    EditDataLancamento.SetFocus;
  end;
end;

procedure TFContabilLancamento.EditIdLoteKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDataLancamento.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Actions'}
function TFContabilLancamento.VerificarLancamentos: Boolean;
var
  Creditos, Debitos: Extended;
  QuantidadeCreditos, QuantidadeDebitos: Integer;
  Mensagem: String;
begin
  Creditos := 0;
  Debitos := 0;
  QuantidadeCreditos := 0;
  QuantidadeDebitos := 0;
  Result := False;
  //
  CDSContabilLancamentoDetalhe.DisableControls;
  CDSContabilLancamentoDetalhe.First;
  while not CDSContabilLancamentoDetalhe.Eof do
  begin
    if CDSContabilLancamentoDetalheTIPO.AsString = 'C' then
    begin
      Inc(QuantidadeCreditos);
      Creditos := Creditos + CDSContabilLancamentoDetalheVALOR.AsExtended;
    end
    else if CDSContabilLancamentoDetalheTIPO.AsString = 'D' then
    begin
      Inc(QuantidadeDebitos);
      Debitos := Debitos + CDSContabilLancamentoDetalheVALOR.AsExtended;
    end;
    CDSContabilLancamentoDetalhe.Next;
  end;
  CDSContabilLancamentoDetalhe.First;
  CDSContabilLancamentoDetalhe.EnableControls;

  { Verifica os totais }
  if Creditos <> Debitos then
    Mensagem := Mensagem + #13 + 'Total de cr�ditos difere do total de d�bitos.';

  { Verifica os tipos de lan�amento }
  // UDVC - Um D�bito para V�rios Cr�ditos
  if ComboBoxTipo.ItemIndex = 0 then
  begin
    if QuantidadeDebitos > 1  then
      Mensagem := Mensagem + #13 + 'UDVC - Mais do que um d�bito informado.';
    if QuantidadeDebitos < 1  then
      Mensagem := Mensagem + #13 + 'UDVC - Nenhum d�bito informado.';
    if QuantidadeCreditos < 1  then
      Mensagem := Mensagem + #13 + 'UDVC - Nenhum cr�dito informado.';
    if QuantidadeCreditos = 1  then
      Mensagem := Mensagem + #13 + 'UDVC - Apenas um cr�dito informado.';
  end;

  // UCVD - Um Cr�dito para V�rios D�bitos
  if ComboBoxTipo.ItemIndex = 1 then
  begin
    if QuantidadeCreditos > 1  then
      Mensagem := Mensagem + #13 + 'UCVD - Mais do que um cr�dito informado.';
    if QuantidadeCreditos < 1  then
      Mensagem := Mensagem + #13 + 'UCVD - Nenhum cr�dito informado.';
    if QuantidadeDebitos < 1  then
      Mensagem := Mensagem + #13 + 'UCVD - Nenhum d�bito informado.';
    if QuantidadeDebitos = 1  then
      Mensagem := Mensagem + #13 + 'UCVD - Apenas um d�bito informado.';
  end;

  // UDUC - Um D�bito para Um Cr�dito
  if ComboBoxTipo.ItemIndex = 2 then
  begin
    if QuantidadeCreditos > 1  then
      Mensagem := Mensagem + #13 + 'UDUC - Mais do que um cr�dito informado.';
    if QuantidadeDebitos > 1  then
      Mensagem := Mensagem + #13 + 'UDUC - Mais do que um cr�dito informado.';
    if QuantidadeCreditos < 1  then
      Mensagem := Mensagem + #13 + 'UDUC - Nenhum cr�dito informado.';
    if QuantidadeDebitos < 1  then
      Mensagem := Mensagem + #13 + 'UDUC - Nenhum d�bito informado.';
  end;

  // VDVC - V�rios D�bitos para V�rios Cr�ditos
  if ComboBoxTipo.ItemIndex = 3 then
  begin
    if QuantidadeCreditos < 1  then
      Mensagem := Mensagem + #13 + 'VDVC - Nenhum cr�dito informado.';
    if QuantidadeDebitos < 1  then
      Mensagem := Mensagem + #13 + 'VDVC - Nenhum d�bito informado.';
    if QuantidadeCreditos = 1  then
      Mensagem := Mensagem + #13 + 'VDVC - Apenas um cr�dito informado.';
    if QuantidadeDebitos = 1  then
      Mensagem := Mensagem + #13 + 'VDVC - Apenas um d�bito informado.';
  end;

  if Mensagem <> '' then
  begin
    Application.MessageBox(PChar('Ocorreram erros na valida��o dos dados informados. Lista de erros abaixo: ' + #13 + Mensagem), 'Erro do sistema', MB_OK + MB_ICONERROR);
    Result := False;
  end
  else
    Result := True;
end;
{$ENDREGION}

end.
