{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de OperadoraPlanoSaude

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
unit UOperadoraPlanoSaude;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, OperadoraPlanoSaudeVO,
  OperadoraPlanoSaudeController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Operadora Plano Saúde')]

  TFOperadoraPlanoSaude = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditRegistroAns: TLabeledEdit;
    EditContabilConta: TLabeledEdit;
    EditIdContabilConta: TLabeledCalcEdit;
    EditNome: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContabilContaExit(Sender: TObject);
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
  FOperadoraPlanoSaude: TFOperadoraPlanoSaude;

implementation

uses ULookup, Biblioteca, UDataModule, PessoaVO, PessoaController, ContabilContaVO, ContabilContaController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFOperadoraPlanoSaude.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TOperadoraPlanoSaudeVO;
  ObjetoController := TOperadoraPlanoSaudeController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFOperadoraPlanoSaude.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdContabilConta.SetFocus;
  end;
end;

function TFOperadoraPlanoSaude.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdContabilConta.SetFocus;
  end;
end;

function TFOperadoraPlanoSaude.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TOperadoraPlanoSaudeController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TOperadoraPlanoSaudeController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFOperadoraPlanoSaude.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TOperadoraPlanoSaudeVO.Create;

      TOperadoraPlanoSaudeVO(ObjetoVO).IdContabilConta := EditIdContabilConta.AsInteger;
      TOperadoraPlanoSaudeVO(ObjetoVO).ContabilContaClassificacao := EditContabilConta.Text;
      TOperadoraPlanoSaudeVO(ObjetoVO).RegistroAns := EditRegistroAns.Text;
      TOperadoraPlanoSaudeVO(ObjetoVO).Nome := EditNome.Text;

      // ObjetoVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      TOperadoraPlanoSaudeVO(ObjetoVO).ContabilContaVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TOperadoraPlanoSaudeVO(ObjetoOldVO).ContabilContaVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TOperadoraPlanoSaudeController(ObjetoController).Insere(TOperadoraPlanoSaudeVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TOperadoraPlanoSaudeVO(ObjetoVO).ToJSONString <> TOperadoraPlanoSaudeVO(ObjetoOldVO).ToJSONString then
        begin
          TOperadoraPlanoSaudeVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TOperadoraPlanoSaudeController(ObjetoController).Altera(TOperadoraPlanoSaudeVO(ObjetoVO), TOperadoraPlanoSaudeVO(ObjetoOldVO));
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
procedure TFOperadoraPlanoSaude.EditIdContabilContaExit(Sender: TObject);
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

procedure TFOperadoraPlanoSaude.EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContabilConta.Value := -1;
    EditRegistroAns.SetFocus;
  end;
end;

procedure TFOperadoraPlanoSaude.EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditRegistroAns.SetFocus;
  end;
end;

{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFOperadoraPlanoSaude.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TOperadoraPlanoSaudeVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdContabilConta.AsInteger := TOperadoraPlanoSaudeVO(ObjetoVO).IdContabilConta;
    EditContabilConta.Text := TOperadoraPlanoSaudeVO(ObjetoVO).ContabilContaClassificacao;
    EditRegistroAns.Text := TOperadoraPlanoSaudeVO(ObjetoVO).RegistroAns;
    EditNome.Text := TOperadoraPlanoSaudeVO(ObjetoVO).Nome;
  end;
end;
{$ENDREGION}

end.
