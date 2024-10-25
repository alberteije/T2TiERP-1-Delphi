{ *******************************************************************************
  Title: T2Ti ERP
  Description:  VO  relacionado � tabela [Fornecedor]

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
  @version 1.0
  ******************************************************************************* }
unit UFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Mask, JvExMask, JvToolEdit,
  JvCombobox, LabeledCtrls, DBCtrls, LabeledDBCtrls, DB, DBClient, StrUtils,
  Math, JSonVO, Generics.Collections,
  Atributos, Constantes, CheckLst, JvExCheckLst, JvCheckListBox, JvBaseEdits,
  ULookup, PessoaVO, PessoaController;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Fornecedor')]

  TFFornecedor = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    BevelEdits: TBevel;
    EditDataDesde: TLabeledDateEdit;
    EditIdContabilConta: TLabeledCalcEdit;
    EditContabilConta: TLabeledEdit;
    EditAtividadeForCli: TLabeledEdit;
    EditSituacaoForCli: TLabeledEdit;
    EditNomePessoa: TLabeledEdit;
    EditIdPessoa: TLabeledCalcEdit;
    EditIdAtividadeForCli: TLabeledCalcEdit;
    EditIdSituacaoForCli: TLabeledCalcEdit;
    MemoObservacao: TLabeledMemo;
    ComboBoxGeraFaturamento: TLabeledComboBox;
    ComboBoxOptanteSimples: TLabeledComboBox;
    ComboBoxLocalizacao: TLabeledComboBox;
    EditContaRemetente: TLabeledEdit;
    ComboBoxSofreRetencao: TLabeledComboBox;
    EditPrazoMedioEntrega: TLabeledCalcEdit;
    EditChequeNominal: TLabeledEdit;
    EditNumDiasPrimeiroVencimento: TLabeledCalcEdit;
    EditNumDiasIntervalo: TLabeledCalcEdit;
    EditQuantidadeParcelas: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdPessoaExit(Sender: TObject);
    procedure EditIdPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdPessoaKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdSituacaoForCliExit(Sender: TObject);
    procedure EditIdSituacaoForCliKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdSituacaoForCliKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdAtividadeForCliExit(Sender: TObject);
    procedure EditIdAtividadeForCliKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdAtividadeForCliKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdContabilContaExit(Sender: TObject);
    procedure EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FFornecedor: TFFornecedor;

implementation

uses Biblioteca, FornecedorVO, FornecedorController, UDataModule, SituacaoForCliVO,
SituacaoForCliController, AtividadeForCliVO, AtividadeForCliController,
ContabilContaVO, ContabilContaController;

{$R *.dfm}

{$REGION 'Infra'}
procedure TFFornecedor.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFornecedorVO;
  ObjetoController := TFornecedorController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFornecedor.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditDataDesde.Date := Date();
    EditIdPessoa.SetFocus;
  end;
end;

function TFFornecedor.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdPessoa.SetFocus;
  end;
end;

function TFFornecedor.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TPessoaController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFornecedorController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFornecedor.DoSalvar: Boolean;
begin
  if EditIdPessoa.Text = '' then
  begin
    Application.MessageBox('Informe o C�digo da Pessoa.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdPessoa.SetFocus;
    Exit(False);
  end
  else if EditIdAtividadeForCli.Text = '' then
  begin
    Application.MessageBox('Informe o C�digo de Atividade do Fornecedor.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdAtividadeForCli.SetFocus;
    Exit(False);
  end
  else if EditIdSituacaoForCli.Text = '' then
  begin
    Application.MessageBox('Informe o C�digo da Situa��o do Fornecedor.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdSituacaoForCli.SetFocus;
    Exit(False);
  end;

  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFornecedorVO.Create;

      TFornecedorVO(ObjetoVO).DataCadastro := Date();
      TFornecedorVO(ObjetoVO).IdPessoa := EditIdPessoa.AsInteger;
      TFornecedorVO(ObjetoVO).PessoaNome := EditNomePessoa.Text;
      TFornecedorVO(ObjetoVO).IdSituacaoForCli := EditIdSituacaoForCli.AsInteger;
      TFornecedorVO(ObjetoVO).SituacaoForCliNome := EditSituacaoForCli.Text;
      TFornecedorVO(ObjetoVO).IdAtividadeForCli := EditIdAtividadeForCli.AsInteger;
      TFornecedorVO(ObjetoVO).AtividadeForCliNome := EditAtividadeForCli.Text;
      TFornecedorVO(ObjetoVO).IdContabilConta := EditIdContabilConta.AsInteger;
      TFornecedorVO(ObjetoVO).ContabilContaClassificacao := EditContabilConta.Text;
      TFornecedorVO(ObjetoVO).ContaRemetente := EditContaRemetente.Text;
      TFornecedorVO(ObjetoVO).PrazoMedioEntrega := EditPrazoMedioEntrega.AsInteger;
      TFornecedorVO(ObjetoVO).Desde := EditDataDesde.Date;
      TFornecedorVO(ObjetoVO).GeraFaturamento := Copy(ComboBoxGeraFaturamento.Text, 1, 1);
      TFornecedorVO(ObjetoVO).OptanteSimplesNacional := Copy(ComboBoxOptanteSimples.Text, 1, 1);
      TFornecedorVO(ObjetoVO).Localizacao := Copy(ComboBoxLocalizacao.Text, 1, 1);
      TFornecedorVO(ObjetoVO).SofreRetencao := Copy(ComboBoxSofreRetencao.Text, 1, 1);
      TFornecedorVO(ObjetoVO).Observacao := MemoObservacao.Text;
      TFornecedorVO(ObjetoVO).ChequeNominalA := EditChequeNominal.Text;
      TFornecedorVO(ObjetoVO).NumeroDiasPrimeiroVencimento := EditNumDiasPrimeiroVencimento.AsInteger;
      TFornecedorVO(ObjetoVO).NumeroDiasIntervalo := EditNumDiasIntervalo.AsInteger;
      TFornecedorVO(ObjetoVO).QuantidadeParcelas := EditQuantidadeParcelas.AsInteger;

      if StatusTela = stInserindo then
        Result := TFornecedorController(ObjetoController).Insere(TFornecedorVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFornecedorVO(ObjetoVO).ToJSONString <> TFornecedorVO(ObjetoOldVO).ToJSONString then
        begin
          TFornecedorVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TFornecedorController(ObjetoController).Altera(TFornecedorVO(ObjetoVO), TFornecedorVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFornecedor.EditIdAtividadeForCliExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdAtividadeForCli.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdAtividadeForCli.Text;
      EditIdAtividadeForCli.Clear;
      EditAtividadeForCli.Clear;
      if not PopulaCamposTransientes(Filtro, TAtividadeForCliVO, TAtividadeForCliController) then
        PopulaCamposTransientesLookup(TAtividadeForCliVO, TAtividadeForCliController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdAtividadeForCli.Text := CDSTransiente.FieldByName('ID').AsString;
        EditAtividadeForCli.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdAtividadeForCli.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditAtividadeForCli.Clear;
  end;
end;

procedure TFFornecedor.EditIdAtividadeForCliKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdAtividadeForCli.Value := -1;
    EditIdContabilConta.SetFocus;
  end;
end;

procedure TFFornecedor.EditIdAtividadeForCliKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdContabilConta.SetFocus;
  end;
end;

procedure TFFornecedor.EditIdContabilContaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdContabilConta.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdContabilConta.Text;
      EditIdContabilConta.Clear;
      EditContabilConta.Clear;
      if not PopulaCamposTransientes(Filtro, TContabilContaVO, TContabilContaController) then
        PopulaCamposTransientesLookup(TContabilContaVO, TContabilContaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdContabilConta.Text := CDSTransiente.FieldByName('ID').AsString;
        EditContabilConta.Text := CDSTransiente.FieldByName('CLASSIFICACAO').AsString;
      end
      else
      begin
        Exit;
        EditIdContabilConta.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContabilConta.Clear;
  end;
end;

procedure TFFornecedor.EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContabilConta.Value := -1;
    EditDataDesde.SetFocus;
  end;
end;

procedure TFFornecedor.EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDataDesde.SetFocus;
  end;
end;

procedure TFFornecedor.EditIdPessoaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdPessoa.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdPessoa.Text;
      EditIdPessoa.Clear;
      EditNomePessoa.Clear;
      if not PopulaCamposTransientes(Filtro, TPessoaVO, TPessoaController) then
        PopulaCamposTransientesLookup(TPessoaVO, TPessoaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdPessoa.Text := CDSTransiente.FieldByName('ID').AsString;
        EditNomePessoa.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdPessoa.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditNomePessoa.Clear;
  end;
end;

procedure TFFornecedor.EditIdPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdPessoa.Value := -1;
    EditIdSituacaoForCli.SetFocus;
  end;
end;

procedure TFFornecedor.EditIdPessoaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdSituacaoForCli.SetFocus;
  end;
end;


procedure TFFornecedor.EditIdSituacaoForCliExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdSituacaoForCli.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdSituacaoForCli.Text;
      EditIdSituacaoForCli.Clear;
      EditSituacaoForCli.Clear;
      if not PopulaCamposTransientes(Filtro, TSituacaoForCliVO, TSituacaoForCliController) then
        PopulaCamposTransientesLookup(TSituacaoForCliVO, TSituacaoForCliController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdSituacaoForCli.Text := CDSTransiente.FieldByName('ID').AsString;
        EditSituacaoForCli.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdSituacaoForCli.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditSituacaoForCli.Clear;
  end;
end;

procedure TFFornecedor.EditIdSituacaoForCliKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdSituacaoForCli.Value := -1;
    EditAtividadeForCli.SetFocus;
  end;
end;

procedure TFFornecedor.EditIdSituacaoForCliKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditAtividadeForCli.SetFocus;
  end;
end;

{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFFornecedor.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFornecedorVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    // Fornecedor
    EditDataDesde.Date := TFornecedorVO(ObjetoVO).Desde;
    EditIdPessoa.AsInteger := TFornecedorVO(ObjetoVO).IdPessoa;
    EditNomePessoa.Text := TFornecedorVO(ObjetoVO).PessoaNome;
    EditIdSituacaoForCli.AsInteger := TFornecedorVO(ObjetoVO).IdSituacaoForCli;
    EditSituacaoForCli.Text := TFornecedorVO(ObjetoVO).SituacaoForCliNome;
    EditIdAtividadeForCli.AsInteger := TFornecedorVO(ObjetoVO).IdAtividadeForCli;
    EditAtividadeForCli.Text := TFornecedorVO(ObjetoVO).AtividadeForCliNome;
    EditIdContabilConta.AsInteger := TFornecedorVO(ObjetoVO).IdContabilConta;
    EditContabilConta.Text := TFornecedorVO(ObjetoVO).ContabilContaClassificacao;
    EditContaRemetente.Text := TFornecedorVO(ObjetoVO).ContaRemetente;
    EditPrazoMedioEntrega.AsInteger := TFornecedorVO(ObjetoVO).PrazoMedioEntrega;
    ComboBoxGeraFaturamento.ItemIndex := AnsiIndexStr(TFornecedorVO(ObjetoVO).GeraFaturamento, ['S', 'N']);
    ComboBoxOptanteSimples.ItemIndex := AnsiIndexStr(TFornecedorVO(ObjetoVO).OptanteSimplesNacional, ['S', 'N']);
    ComboBoxLocalizacao.ItemIndex := AnsiIndexStr(TFornecedorVO(ObjetoVO).Localizacao, ['N', 'E']);
    ComboBoxSofreRetencao.ItemIndex := AnsiIndexStr(TFornecedorVO(ObjetoVO).SofreRetencao, ['S', 'N']);
    MemoObservacao.Text := TFornecedorVO(ObjetoVO).Observacao;
    EditChequeNominal.Text := TFornecedorVO(ObjetoVO).ChequeNominalA;
    EditNumDiasPrimeiroVencimento.AsInteger := TFornecedorVO(ObjetoVO).NumeroDiasPrimeiroVencimento;
    EditNumDiasIntervalo.AsInteger := TFornecedorVO(ObjetoVO).NumeroDiasIntervalo;
    EditQuantidadeParcelas.AsInteger := TFornecedorVO(ObjetoVO).QuantidadeParcelas;
  end;
end;
{$ENDREGION}

end.
