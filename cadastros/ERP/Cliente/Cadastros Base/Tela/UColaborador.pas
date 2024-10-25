{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Colaboradores

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

  @author S�rgio
  @version 1.0   |   Fernando  @version 1.0.0.10
  ******************************************************************************* }
unit UColaborador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ColaboradorVO,
  ColaboradorController, Tipos, Atributos, Constantes, LabeledCtrls, Mask, JvExMask,
  JvToolEdit, JvMaskEdit, JvExStdCtrls, JvEdit, JvValidateEdit, JvBaseEdits,
  StrUtils;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Colaborador')]

  TFColaborador = class(TFTelaCadastro)
    EditIdContabilConta: TLabeledCalcEdit;
    EditContabilConta: TLabeledEdit;
    EditIdPessoa: TLabeledCalcEdit;
    EditIdNivelFormacao: TLabeledCalcEdit;
    EditIdSindicato: TLabeledCalcEdit;
    EditNivelFormacao: TLabeledEdit;
    EditSindicato: TLabeledEdit;
    EditNomePessoa: TLabeledEdit;
    EditIdTipoColaborador: TLabeledCalcEdit;
    EditTipoColaborador: TLabeledEdit;
    EditIdSituacaoColaborador: TLabeledCalcEdit;
    EditSituacaoColaborador: TLabeledEdit;
    EditIdCargo: TLabeledCalcEdit;
    EditCargo: TLabeledEdit;
    EditIdSetor: TLabeledCalcEdit;
    EditSetor: TLabeledEdit;
    EditMatricula: TLabeledEdit;
    MemoObservacao: TLabeledMemo;
    GroupBoxFinanceiro: TGroupBox;
    ComboBoxFormaPagamento: TLabeledComboBox;
    EditBancoPagamento: TLabeledEdit;
    EditAgenciaPagamento: TLabeledEdit;
    EditAgenciaDigitoPagamento: TLabeledEdit;
    EditContaPagamento: TLabeledEdit;
    EditDigitoContaPagamento: TLabeledEdit;
    GroupBox2: TGroupBox;
    ComboBoxOptanteFgts: TLabeledComboBox;
    EditDataOpcaoFgts: TLabeledDateEdit;
    EditContaFgts: TLabeledCalcEdit;
    GroupBox3: TGroupBox;
    EditDataCadastroPis: TLabeledDateEdit;
    EditBancoPis: TLabeledEdit;
    EditNumeroPis: TLabeledEdit;
    EditAgenciaPis: TLabeledEdit;
    EditDigitoAgenciaPis: TLabeledEdit;
    GroupBox4: TGroupBox;
    EditVencimentoExame: TLabeledDateEdit;
    EditDataUltimoExame: TLabeledDateEdit;
    GroupBox5: TGroupBox;
    EditNumeroCtps: TLabeledEdit;
    EditSerieCtps: TLabeledEdit;
    EditUfCtps: TLabeledEdit;
    EditDataExpedicaoCtps: TLabeledDateEdit;
    GroupBox6: TGroupBox;
    EditCodigoAdmissaoCaged: TLabeledCalcEdit;
    EditCodigoDemissaoCaged: TLabeledCalcEdit;
    ComboBoxDescontoPlanoSaude: TLabeledComboBox;
    ComboBoxSainaRais: TLabeledComboBox;
    GroupBox7: TGroupBox;
    EditCategoriaSefip: TLabeledEdit;
    EditOcorrenciaSefip: TLabeledCalcEdit;
    EditCodigoDemissaoSefip: TLabeledCalcEdit;
    EditCodigoTurma: TLabeledEdit;
    EditDataDemissao: TLabeledDateEdit;
    EditDataTransferencia: TLabeledDateEdit;
    EditDataVencimentoFerias: TLabeledDateEdit;
    EditDataAdmissao: TLabeledDateEdit;
    EditDataCadastro: TLabeledDateEdit;
    BevelEdits: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure EditIdPessoaExit(Sender: TObject);
    procedure EditIdPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdPessoaKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdContabilContaExit(Sender: TObject);
    procedure EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdTipoColaboradorExit(Sender: TObject);
    procedure EditIdTipoColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdTipoColaboradorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdSituacaoColaboradorExit(Sender: TObject);
    procedure EditIdSituacaoColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdSituacaoColaboradorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdSindicatoExit(Sender: TObject);
    procedure EditIdSindicatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdSindicatoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdNivelFormacaoExit(Sender: TObject);
    procedure EditIdNivelFormacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdNivelFormacaoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdCargoExit(Sender: TObject);
    procedure EditIdCargoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdCargoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdSetorExit(Sender: TObject);
    procedure EditIdSetorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdSetorKeyPress(Sender: TObject; var Key: Char);
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
  FColaborador: TFColaborador;

implementation

uses ULookup, Biblioteca, UDataModule, PessoaVO, PessoaController,
ContabilContaVO, ContabilContaController, TipoColaboradorVO, TipoColaboradorController,
SituacaoColaboradorVO, SituacaoColaboradorController, SindicatoVO, SindicatoController,
NivelFormacaoVO, NivelFormacaoController, CargoVO, CargoController,
SetorVO, SetorController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFColaborador.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TColaboradorVO;
  ObjetoController := TColaboradorController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFColaborador.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdPessoa.SetFocus;
  end;
end;

function TFColaborador.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdPessoa.SetFocus;
  end;
end;

function TFColaborador.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TColaboradorController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TColaboradorController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFColaborador.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      ObjetoVO := TColaboradorVO.Create;

      TColaboradorVO(ObjetoVO).IdPessoa := EditIdPessoa.AsInteger;
      TColaboradorVO(ObjetoVO).PessoaNome := EditNomePessoa.Text;
      TColaboradorVO(ObjetoVO).IdTipoColaborador := EditIdTipoColaborador.AsInteger;
      TColaboradorVO(ObjetoVO).TipoColaboradorNome := EditTipoColaborador.Text;
      TColaboradorVO(ObjetoVO).IdSituacaoColaborador := EditIdSituacaoColaborador.AsInteger;
      TColaboradorVO(ObjetoVO).SituacaoColaboradorNome := EditSituacaoColaborador.Text;
      TColaboradorVO(ObjetoVO).IdContabilConta := EditIdContabilConta.AsInteger;
      TColaboradorVO(ObjetoVO).ContabilContaClassificacao := EditContabilConta.Text;
      TColaboradorVO(ObjetoVO).IdSindicato := EditIdSindicato.AsInteger;
      TColaboradorVO(ObjetoVO).SindicatoNome := EditSindicato.Text;
      TColaboradorVO(ObjetoVO).IdCargo := EditIdCargo.AsInteger;
      TColaboradorVO(ObjetoVO).CargoNome := EditCargo.Text;
      TColaboradorVO(ObjetoVO).IdSetor := EditIdSetor.AsInteger;
      TColaboradorVO(ObjetoVO).SetorNome := EditSetor.Text;
      TColaboradorVO(ObjetoVO).IdNivelFormacao := EditIdNivelFormacao.AsInteger;
      TColaboradorVO(ObjetoVO).NivelFormacaoNome := EditNivelFormacao.Text;
      TColaboradorVO(ObjetoVO).Matricula := EditMatricula.Text;
      TColaboradorVO(ObjetoVO).DataCadastro := EditDataCadastro.Date;
      TColaboradorVO(ObjetoVO).DataAdmissao := EditDataAdmissao.Date;
      TColaboradorVO(ObjetoVO).VencimentoFerias := EditDataVencimentoFerias.Date;
      TColaboradorVO(ObjetoVO).DataTransferencia := EditDataTransferencia.Date;
      TColaboradorVO(ObjetoVO).DataDemissao := EditDataDemissao.Date;
      TColaboradorVO(ObjetoVO).CodigoTurmaPonto := EditCodigoTurma.Text;
      TColaboradorVO(ObjetoVO).Observacao := MemoObservacao.Text;
      TColaboradorVO(ObjetoVO).DescontoPlanoSaude := Copy(ComboBoxDescontoPlanoSaude.Text, 1, 1);
      TColaboradorVO(ObjetoVO).SaiNaRais := Copy(ComboBoxSainaRais.Text, 1, 1);
      TColaboradorVO(ObjetoVO).ExameMedicoUltimo := EditDataUltimoExame.Date;
      TColaboradorVO(ObjetoVO).ExameMedicoVencimento := EditVencimentoExame.Date;
      TColaboradorVO(ObjetoVO).CategoriaSefip := EditCategoriaSefip.Text;
      TColaboradorVO(ObjetoVO).OcorrenciaSefip := EditOcorrenciaSefip.AsInteger;
      TColaboradorVO(ObjetoVO).CodigoDemissaoSefip := EditCodigoDemissaoSefip.AsInteger;
      TColaboradorVO(ObjetoVO).FgtsOptante := Copy(ComboBoxOptanteFgts.Text, 1, 1);
      TColaboradorVO(ObjetoVO).FgtsDataOpcao := EditDataOpcaoFgts.Date;
      TColaboradorVO(ObjetoVO).FgtsConta := EditContaFgts.AsInteger;
      TColaboradorVO(ObjetoVO).CodigoAdmissaoCaged := EditCodigoAdmissaoCaged.AsInteger;
      TColaboradorVO(ObjetoVO).CodigoDemissaoCaged := EditCodigoDemissaoCaged.AsInteger;
      TColaboradorVO(ObjetoVO).PagamentoForma := Copy(ComboBoxFormaPagamento.Text, 1, 1);
      TColaboradorVO(ObjetoVO).PagamentoBanco := EditBancoPagamento.Text;
      TColaboradorVO(ObjetoVO).PagamentoAgencia := EditAgenciaPagamento.Text;
      TColaboradorVO(ObjetoVO).PagamentoAgenciaDigito := EditAgenciaDigitoPagamento.Text;
      TColaboradorVO(ObjetoVO).PagamentoConta := EditContaPagamento.Text;
      TColaboradorVO(ObjetoVO).PagamentoContaDigito := EditDigitoContaPagamento.Text;
      TColaboradorVO(ObjetoVO).PisDataCadastro := EditDataCadastroPis.Date;
      TColaboradorVO(ObjetoVO).PisNumero := EditNumeroPis.Text;
      TColaboradorVO(ObjetoVO).PisBanco := EditBancoPis.Text;
      TColaboradorVO(ObjetoVO).PisAgencia := EditAgenciaPis.Text;
      TColaboradorVO(ObjetoVO).PisAgenciaDigito := EditDigitoAgenciaPis.Text;
      TColaboradorVO(ObjetoVO).CtpsNumero := EditNumeroCtps.Text;
      TColaboradorVO(ObjetoVO).CtpsSerie := EditSerieCtps.Text;
      TColaboradorVO(ObjetoVO).CtpsUf := EditUfCtps.Text;
      TColaboradorVO(ObjetoVO).CtpsDataExpedicao := EditDataExpedicaoCtps.Date;

      if StatusTela = stInserindo then
        Result := TColaboradorController(ObjetoController).Insere(TColaboradorVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TColaboradorVO(ObjetoVO).ToJSONString <> TColaboradorVO(ObjetoOldVO).ToJSONString then
        begin
          TColaboradorVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TColaboradorController(ObjetoController).Altera(TColaboradorVO(ObjetoVO), TColaboradorVO(ObjetoOldVO));
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
procedure TFColaborador.EditIdCargoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdCargo.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdCargo.Text;
      EditIdCargo.Clear;
      EditCargo.Clear;
      if not PopulaCamposTransientes(Filtro, TCargoVO, TCargoController) then
        PopulaCamposTransientesLookup(TCargoVO, TCargoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdCargo.Text := CDSTransiente.FieldByName('ID').AsString;
        EditCargo.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdCargo.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCargo.Clear;
  end;
end;

procedure TFColaborador.EditIdCargoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdCargo.Value := -1;
    EditIdContabilConta.SetFocus;
  end;
end;

procedure TFColaborador.EditIdCargoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdContabilConta.SetFocus;
  end;
end;

procedure TFColaborador.EditIdContabilContaExit(Sender: TObject);
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

procedure TFColaborador.EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContabilConta.Value := -1;
    EditIdSetor.SetFocus;
  end;
end;

procedure TFColaborador.EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdSetor.SetFocus;
  end;
end;

procedure TFColaborador.EditIdNivelFormacaoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdNivelFormacao.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdNivelFormacao.Text;
      EditIdNivelFormacao.Clear;
      EditNivelFormacao.Clear;
      if not PopulaCamposTransientes(Filtro, TNivelFormacaoVO, TNivelFormacaoController) then
        PopulaCamposTransientesLookup(TNivelFormacaoVO, TNivelFormacaoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdNivelFormacao.Text := CDSTransiente.FieldByName('ID').AsString;
        EditNivelFormacao.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdNivelFormacao.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditNivelFormacao.Clear;
  end;
end;

procedure TFColaborador.EditIdNivelFormacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdNivelFormacao.Value := -1;
    EditIdCargo.SetFocus;
  end;
end;

procedure TFColaborador.EditIdNivelFormacaoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdCargo.SetFocus;
  end;
end;

procedure TFColaborador.EditIdPessoaExit(Sender: TObject);
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

procedure TFColaborador.EditIdPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdPessoa.Value := -1;
    EditIdTipoColaborador.SetFocus;
  end;
end;

procedure TFColaborador.EditIdPessoaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdTipoColaborador.SetFocus;
  end;
end;

procedure TFColaborador.EditIdSetorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdSetor.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdSetor.Text;
      EditIdSetor.Clear;
      EditSetor.Clear;
      if not PopulaCamposTransientes(Filtro, TSetorVO, TSetorController) then
        PopulaCamposTransientesLookup(TSetorVO, TSetorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdSetor.Text := CDSTransiente.FieldByName('ID').AsString;
        EditSetor.Text := CDSTransiente.FieldByName('NOME').AsString;
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
    EditSetor.Clear;
  end;
end;

procedure TFColaborador.EditIdSetorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdSetor.Value := -1;
    EditMatricula.SetFocus;
  end;
end;

procedure TFColaborador.EditIdSetorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditMatricula.SetFocus;
  end;
end;

procedure TFColaborador.EditIdSindicatoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdSindicato.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdSindicato.Text;
      EditIdSindicato.Clear;
      EditSindicato.Clear;
      if not PopulaCamposTransientes(Filtro, TSindicatoVO, TSindicatoController) then
        PopulaCamposTransientesLookup(TSindicatoVO, TSindicatoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdSindicato.Text := CDSTransiente.FieldByName('ID').AsString;
        EditSindicato.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdSindicato.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditSindicato.Clear;
  end;
end;

procedure TFColaborador.EditIdSindicatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdSindicato.Value := -1;
    EditIdNivelFormacao.SetFocus;
  end;
end;

procedure TFColaborador.EditIdSindicatoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdNivelFormacao.SetFocus;
  end;
end;

procedure TFColaborador.EditIdSituacaoColaboradorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdSituacaoColaborador.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdSituacaoColaborador.Text;
      EditIdSituacaoColaborador.Clear;
      EditSituacaoColaborador.Clear;
      if not PopulaCamposTransientes(Filtro, TSituacaoColaboradorVO, TSituacaoColaboradorController) then
        PopulaCamposTransientesLookup(TSituacaoColaboradorVO, TSituacaoColaboradorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdSituacaoColaborador.Text := CDSTransiente.FieldByName('ID').AsString;
        EditSituacaoColaborador.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdSituacaoColaborador.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditSituacaoColaborador.Clear;
  end;
end;

procedure TFColaborador.EditIdSituacaoColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdSituacaoColaborador.Value := -1;
    EditIdSindicato.SetFocus;
  end;
end;

procedure TFColaborador.EditIdSituacaoColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdSindicato.SetFocus;
  end;
end;

procedure TFColaborador.EditIdTipoColaboradorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdTipoColaborador.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdTipoColaborador.Text;
      EditIdTipoColaborador.Clear;
      EditTipoColaborador.Clear;
      if not PopulaCamposTransientes(Filtro, TTipoColaboradorVO, TTipoColaboradorController) then
        PopulaCamposTransientesLookup(TTipoColaboradorVO, TTipoColaboradorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdTipoColaborador.Text := CDSTransiente.FieldByName('ID').AsString;
        EditTipoColaborador.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdTipoColaborador.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditTipoColaborador.Clear;
  end;
end;

procedure TFColaborador.EditIdTipoColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdTipoColaborador.Value := -1;
    EditSituacaoColaborador.SetFocus;
  end;
end;

procedure TFColaborador.EditIdTipoColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditSituacaoColaborador.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFColaborador.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TColaboradorVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdPessoa.AsInteger := TColaboradorVO(ObjetoVO).IdPessoa;
    EditNomePessoa.Text := TColaboradorVO(ObjetoVO).PessoaNome;
    EditIdTipoColaborador.AsInteger := TColaboradorVO(ObjetoVO).IdTipoColaborador;
    EditTipoColaborador.Text := TColaboradorVO(ObjetoVO).TipoColaboradorNome;
    EditIdSituacaoColaborador.AsInteger := TColaboradorVO(ObjetoVO).IdSituacaoColaborador;
    EditSituacaoColaborador.Text := TColaboradorVO(ObjetoVO).SituacaoColaboradorNome;
    EditIdContabilConta.AsInteger := TColaboradorVO(ObjetoVO).IdContabilConta;
    EditContabilConta.Text := TColaboradorVO(ObjetoVO).ContabilContaClassificacao;
    EditIdSindicato.AsInteger := TColaboradorVO(ObjetoVO).IdSindicato;
    EditSindicato.Text := TColaboradorVO(ObjetoVO).SindicatoNome;
    EditIdCargo.AsInteger := TColaboradorVO(ObjetoVO).IdCargo;
    EditCargo.Text := TColaboradorVO(ObjetoVO).CargoNome;
    EditIdSetor.AsInteger := TColaboradorVO(ObjetoVO).IdSetor;
    EditSetor.Text := TColaboradorVO(ObjetoVO).SetorNome;
    EditIdNivelFormacao.AsInteger := TColaboradorVO(ObjetoVO).IdNivelFormacao;
    EditNivelFormacao.Text := TColaboradorVO(ObjetoVO).NivelFormacaoNome;
    EditMatricula.Text := TColaboradorVO(ObjetoVO).Matricula;
    EditDataCadastro.Date := TColaboradorVO(ObjetoVO).DataCadastro;
    EditDataAdmissao.Date := TColaboradorVO(ObjetoVO).DataAdmissao;
    EditDataVencimentoFerias.Date := TColaboradorVO(ObjetoVO).VencimentoFerias;
    EditDataTransferencia.Date := TColaboradorVO(ObjetoVO).DataTransferencia;
    EditDataDemissao.Date := TColaboradorVO(ObjetoVO).DataDemissao;
    EditCodigoTurma.Text := TColaboradorVO(ObjetoVO).CodigoTurmaPonto;
    MemoObservacao.Text := TColaboradorVO(ObjetoVO).Observacao;
    ComboBoxDescontoPlanoSaude.ItemIndex := AnsiIndexStr(TColaboradorVO(ObjetoVO).DescontoPlanoSaude, ['S', 'N']);
    ComboBoxSainaRais.ItemIndex := AnsiIndexStr(TColaboradorVO(ObjetoVO).SaiNaRais, ['S', 'N']);
    EditDataUltimoExame.Date := TColaboradorVO(ObjetoVO).ExameMedicoUltimo;
    EditVencimentoExame.Date := TColaboradorVO(ObjetoVO).ExameMedicoVencimento;
    EditCategoriaSefip.Text := TColaboradorVO(ObjetoVO).CategoriaSefip;
    EditOcorrenciaSefip.AsInteger := TColaboradorVO(ObjetoVO).OcorrenciaSefip;
    EditCodigoDemissaoSefip.AsInteger := TColaboradorVO(ObjetoVO).CodigoDemissaoSefip;
    ComboBoxOptanteFgts.ItemIndex := AnsiIndexStr(TColaboradorVO(ObjetoVO).FgtsOptante, ['S', 'N']);
    EditDataOpcaoFgts.Date := TColaboradorVO(ObjetoVO).FgtsDataOpcao;
    EditContaFgts.AsInteger := TColaboradorVO(ObjetoVO).FgtsConta;
    EditCodigoAdmissaoCaged.AsInteger := TColaboradorVO(ObjetoVO).CodigoAdmissaoCaged;
    EditCodigoDemissaoCaged.AsInteger := TColaboradorVO(ObjetoVO).CodigoDemissaoCaged;
    ComboBoxFormaPagamento.ItemIndex := AnsiIndexStr(TColaboradorVO(ObjetoVO).PagamentoForma, ['1', '2', '3']);
    EditBancoPagamento.Text := TColaboradorVO(ObjetoVO).PagamentoBanco;
    EditAgenciaPagamento.Text := TColaboradorVO(ObjetoVO).PagamentoAgencia;
    EditAgenciaDigitoPagamento.Text := TColaboradorVO(ObjetoVO).PagamentoAgenciaDigito;
    EditContaPagamento.Text := TColaboradorVO(ObjetoVO).PagamentoConta;
    EditDigitoContaPagamento.Text := TColaboradorVO(ObjetoVO).PagamentoContaDigito;
    EditDataCadastroPis.Date := TColaboradorVO(ObjetoVO).PisDataCadastro;
    EditNumeroPis.Text := TColaboradorVO(ObjetoVO).PisNumero;
    EditBancoPis.Text := TColaboradorVO(ObjetoVO).PisBanco;
    EditAgenciaPis.Text := TColaboradorVO(ObjetoVO).PisAgencia;
    EditDigitoAgenciaPis.Text := TColaboradorVO(ObjetoVO).PisAgenciaDigito;
    EditNumeroCtps.Text := TColaboradorVO(ObjetoVO).CtpsNumero;
    EditSerieCtps.Text := TColaboradorVO(ObjetoVO).CtpsSerie;
    EditUfCtps.Text := TColaboradorVO(ObjetoVO).CtpsUf;
    EditDataExpedicaoCtps.Date := TColaboradorVO(ObjetoVO).CtpsDataExpedicao;
  end;
end;
{$ENDREGION}

end.
