{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de ContaCaixa

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
unit UContaCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ContaCaixaVO,
  ContaCaixaController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'ContaCaixa')]

  TFContaCaixa = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditContabilConta: TLabeledEdit;
    EditCodigo: TLabeledEdit;
    EditNome: TLabeledEdit;
    EditAgenciaBanco: TLabeledEdit;
    MemoDescricao: TLabeledMemo;
    EditIdContabilConta: TLabeledCalcEdit;
    EditIdAgenciaBanco: TLabeledCalcEdit;
    ComboboxTipo: TLabeledComboBox;
    EditDigito: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdAgenciaBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdAgenciaBancoExit(Sender: TObject);
    procedure EditIdContabilContaExit(Sender: TObject);
    procedure EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdAgenciaBancoKeyPress(Sender: TObject; var Key: Char);
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
  FContaCaixa: TFContaCaixa;

implementation

uses ULookup, Biblioteca, UDataModule, AgenciaBancoVO, AgenciaBancoController, ContabilContaVO, ContabilContaController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFContaCaixa.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContaCaixaVO;
  ObjetoController := TContaCaixaController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFContaCaixa.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdContabilConta.SetFocus;
  end;
end;

function TFContaCaixa.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdContabilConta.SetFocus;
  end;
end;

function TFContaCaixa.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TContaCaixaController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TContaCaixaController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFContaCaixa.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TContaCaixaVO.Create;

      TContaCaixaVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TContaCaixaVO(ObjetoVO).IdContabilConta := EditIdContabilConta.AsInteger;
      TContaCaixaVO(ObjetoVO).ContabilContaClassificacao := EditContabilConta.Text;;
      TContaCaixaVO(ObjetoVO).IdAgenciaBanco := EditIdAgenciaBanco.AsInteger;
      TContaCaixaVO(ObjetoVO).AgenciaBancoNome := EditAgenciaBanco.Text;
      TContaCaixaVO(ObjetoVO).Codigo := EditCodigo.Text;
      TContaCaixaVO(ObjetoVO).Digito := EditDigito.Text;
      TContaCaixaVO(ObjetoVO).Nome := EditNome.Text;
      TContaCaixaVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TContaCaixaVO(ObjetoVO).Tipo := Copy(ComboboxTipo.Text, 1, 1);

      if StatusTela = stInserindo then
        Result := TContaCaixaController(ObjetoController).Insere(TContaCaixaVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TContaCaixaVO(ObjetoVO).ToJSONString <> TContaCaixaVO(ObjetoOldVO).ToJSONString then
        begin
          TContaCaixaVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TContaCaixaController(ObjetoController).Altera(TContaCaixaVO(ObjetoVO), TContaCaixaVO(ObjetoOldVO));
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
procedure TFContaCaixa.EditIdContabilContaExit(Sender: TObject);
var
  Filtro: string;
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

procedure TFContaCaixa.EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContabilConta.Value := -1;
    EditIdAgenciaBanco.SetFocus;
  end;
end;

procedure TFContaCaixa.EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdAgenciaBanco.SetFocus;
  end;
end;

procedure TFContaCaixa.EditIdAgenciaBancoExit(Sender: TObject);
var
  Filtro: string;
begin
  if EditIdAgenciaBanco.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdAgenciaBanco.Text;
      EditIdAgenciaBanco.Clear;
      EditAgenciaBanco.Clear;
      if not PopulaCamposTransientes(Filtro, TAgenciaBancoVO, TAgenciaBancoController) then
        PopulaCamposTransientesLookup(TAgenciaBancoVO, TAgenciaBancoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdAgenciaBanco.Text := CDSTransiente.FieldByName('ID').AsString;
        EditAgenciaBanco.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdAgenciaBanco.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditAgenciaBanco.Clear;
  end;
end;

procedure TFContaCaixa.EditIdAgenciaBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdAgenciaBanco.Value := -1;
    EditCodigo.SetFocus;
  end;
end;

procedure TFContaCaixa.EditIdAgenciaBancoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditCodigo.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFContaCaixa.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TContaCaixaVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdContabilConta.AsInteger := TContaCaixaVO(ObjetoVO).IdContabilConta;
    EditContabilConta.Text := TContaCaixaVO(ObjetoVO).ContabilContaClassificacao;
    EditIdAgenciaBanco.AsInteger := TContaCaixaVO(ObjetoVO).IdAgenciaBanco;
    EditAgenciaBanco.Text := TContaCaixaVO(ObjetoVO).AgenciaBancoNome;
    EditCodigo.Text := TContaCaixaVO(ObjetoVO).Codigo;
    EditDigito.Text := TContaCaixaVO(ObjetoVO).Digito;
    EditNome.Text := TContaCaixaVO(ObjetoVO).Nome;
    MemoDescricao.Text := TContaCaixaVO(ObjetoVO).Descricao;
    ComboboxTipo.ItemIndex := AnsiIndexStr(TContaCaixaVO(ObjetoVO).Tipo, ['C', 'P', 'I', 'X']);
  end;
end;
{$ENDREGION}

end.
