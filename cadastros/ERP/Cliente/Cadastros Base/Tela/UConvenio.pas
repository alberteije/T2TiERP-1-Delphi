{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Convenio

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

  t2ti.com@gmail.com | fernandololiver@gmail.com
  @author Albert Eije (T2Ti.COM) | Fernando L Oliveira
  @version 1.0
  ******************************************************************************* }
unit UConvenio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ConvenioVO,
  ConvenioController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Conv�nio')]

  TFConvenio = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditLogradouro: TLabeledEdit;
    EditContato: TLabeledEdit;
    EditBairro: TLabeledEdit;
    EditPessoa: TLabeledEdit;
    EditContabilConta: TLabeledEdit;
    EditDesconto: TLabeledCalcEdit;
    EditVencimento: TLabeledDateEdit;
    EditUf: TLabeledEdit;
    EditTelefone: TLabeledMaskEdit;
    EditDataCadastro: TLabeledDateEdit;
    MemoDescricao: TLabeledMemo;
    EditIdContabilConta: TLabeledCalcEdit;
    EditIdPessoa: TLabeledCalcEdit;
    EditNumero: TLabeledEdit;
    EditMunicipioIbge: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdPessoaExit(Sender: TObject);
    procedure EditIdPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdPessoaKeyPress(Sender: TObject; var Key: Char);
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
  FConvenio: TFConvenio;

implementation

uses ULookup, Biblioteca, UDataModule, PessoaVO, PessoaController, ContabilContaVO,
  ContabilContaController, MunicipioVO, MunicipioController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFConvenio.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TConvenioVO;
  ObjetoController := TConvenioController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFConvenio.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdPessoa.SetFocus;
  end;
end;

function TFConvenio.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdPessoa.SetFocus;
  end;
end;

function TFConvenio.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TConvenioController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TConvenioController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFConvenio.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TConvenioVO.Create;

      TConvenioVO(ObjetoVO).IdEmpresa := sessao.IdEmpresa;
      TConvenioVO(ObjetoVO).IdPessoa := EditIdPessoa.AsInteger;
      TConvenioVO(ObjetoVO).PessoaNome := EditPessoa.Text;
      TConvenioVO(ObjetoVO).IdContabilConta := EditIdContabilConta.AsInteger;
      TConvenioVO(ObjetoVO).ContabilContaClassificacao := EditContabilConta.Text;
      TConvenioVO(ObjetoVO).Desconto := EditDesconto.Value;
      TConvenioVO(ObjetoVO).DataVencimento := EditVencimento.Date;
      TConvenioVO(ObjetoVO).Logradouro := EditLogradouro.Text;
      TConvenioVO(ObjetoVO).Numero := EditNumero.Text;
      TConvenioVO(ObjetoVO).Bairro := EditBairro.Text;
      TConvenioVO(ObjetoVO).MunicipioIbge := StrToInt(EditMunicipioIbge.Text);
      TConvenioVO(ObjetoVO).Uf := EditUf.Text;
      TConvenioVO(ObjetoVO).Contato := EditContato.Text;
      TConvenioVO(ObjetoVO).Telefone := EditTelefone.Text;
      TConvenioVO(ObjetoVO).DataCadastro := EditDataCadastro.Date;
      TConvenioVO(ObjetoVO).Descricao := MemoDescricao.Text;

      TConvenioVO(ObjetoVO).PessoaVO := Nil;
      TConvenioVO(ObjetoVO).ContabilContaVO := Nil;
      if Assigned(ObjetoOldVO) then
      begin
        TConvenioVO(ObjetoOldVO).PessoaVO := Nil;
        TConvenioVO(ObjetoOldVO).ContabilContaVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TConvenioController(ObjetoController).Insere(TConvenioVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TConvenioVO(ObjetoVO).ToJSONString <> TConvenioVO(ObjetoOldVO).ToJSONString then
        begin
          TConvenioVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TConvenioController(ObjetoController).Altera(TConvenioVO(ObjetoVO), TConvenioVO(ObjetoOldVO));
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

{$REGION 'Controle de Grid'}
procedure TFConvenio.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TConvenioVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin

    EditIdPessoa.AsInteger := TConvenioVO(ObjetoVO).IdPessoa;
    EditPessoa.Text := TConvenioVO(ObjetoVO).PessoaNome;
    EditIdContabilConta.AsInteger := TConvenioVO(ObjetoVO).IdContabilConta;
    EditContabilConta.Text := TConvenioVO(ObjetoVO).ContabilContaClassificacao;
    EditDesconto.Value := TConvenioVO(ObjetoVO).Desconto;
    EditVencimento.Date := TConvenioVO(ObjetoVO).DataVencimento;
    EditLogradouro.Text := TConvenioVO(ObjetoVO).Logradouro;
    EditNumero.Text := TConvenioVO(ObjetoVO).Numero;
    EditBairro.Text := TConvenioVO(ObjetoVO).Bairro;
    EditMunicipioIbge.AsInteger := TConvenioVO(ObjetoVO).MunicipioIbge;
    EditUf.Text := TConvenioVO(ObjetoVO).Uf;
    EditContato.Text := TConvenioVO(ObjetoVO).Contato;
    EditTelefone.Text := TConvenioVO(ObjetoVO).Telefone;
    EditDataCadastro.Date := TConvenioVO(ObjetoVO).DataCadastro;
    MemoDescricao.Text := TConvenioVO(ObjetoVO).Descricao;
  end;
end;
{$ENDREGION}


{$REGION 'Campos Transientes'}
procedure TFConvenio.EditIdContabilContaExit(Sender: TObject);
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

procedure TFConvenio.EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContabilConta.Value := -1;
    EditDesconto.SetFocus;
  end;
end;

procedure TFConvenio.EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDesconto.SetFocus;
  end;
end;

procedure TFConvenio.EditIdPessoaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdPessoa.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdPessoa.Text;
      EditIdPessoa.Clear;
      EditPessoa.Clear;
      if not PopulaCamposTransientes(Filtro, TPessoaVO, TPessoaController) then
        PopulaCamposTransientesLookup(TPessoaVO, TPessoaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdPessoa.Text := CDSTransiente.FieldByName('ID').AsString;
        EditPessoa.Text := CDSTransiente.FieldByName('NOME').AsString;
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
    EditPessoa.Clear;
  end;
end;

procedure TFConvenio.EditIdPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdPessoa.Value := -1;
    EditIdContabilConta.SetFocus;
  end;
end;

procedure TFConvenio.EditIdPessoaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdContabilConta.SetFocus;
  end;
end;
{$ENDREGION}

end.
