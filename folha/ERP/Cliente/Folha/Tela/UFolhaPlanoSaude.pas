{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Plano de Sa�de para o m�dulo Folha de Pagamento

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

unit UFolhaPlanoSaude;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FolhaPlanoSaudeVO, FolhaPlanoSaudeController,
  Atributos, Constantes, LabeledCtrls, Mask, JvExMask, JvToolEdit, JvBaseEdits,
  StrUtils;

type
  [TFormDescription(TConstantes.MODULO_FOLHA_PAGAMENTO, 'Plano de Sa�de')]

  TFFolhaPlanoSaude = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditIdColaborador: TLabeledCalcEdit;
    EditColaborador: TLabeledEdit;
    EditDataInicio: TLabeledDateEdit;
    ComboBoxBeneficiario: TLabeledComboBox;
    EditIdOperadoraPlanoSaude: TLabeledCalcEdit;
    EditOperadoraPlanoSaude: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdColaboradorExit(Sender: TObject);
    procedure EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdOperadoraPlanoSaudeExit(Sender: TObject);
    procedure EditIdOperadoraPlanoSaudeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdOperadoraPlanoSaudeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FFolhaPlanoSaude: TFFolhaPlanoSaude;

implementation

uses ColaboradorVO, ColaboradorController, OperadoraPlanoSaudeVO, OperadoraPlanoSaudeController;

{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFFolhaPlanoSaude.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFolhaPlanoSaudeVO;
  ObjetoController := TFolhaPlanoSaudeController.Create;

  inherited;
end;

procedure TFFolhaPlanoSaude.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFFolhaPlanoSaude.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFolhaPlanoSaude.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaPlanoSaude.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaPlanoSaude.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFolhaPlanoSaudeController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFolhaPlanoSaudeController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFolhaPlanoSaude.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFolhaPlanoSaudeVO.Create;

      TFolhaPlanoSaudeVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TFolhaPlanoSaudeVO(ObjetoVO).ColaboradorPessoaNome := EditColaborador.Text;
      TFolhaPlanoSaudeVO(ObjetoVO).IdOperadoraPlanoSaude := EditIdOperadoraPlanoSaude.AsInteger;
      TFolhaPlanoSaudeVO(ObjetoVO).OperadoraNome := EditOperadoraPlanoSaude.Text;
      TFolhaPlanoSaudeVO(ObjetoVO).DataInicio := EditDataInicio.Date;
      TFolhaPlanoSaudeVO(ObjetoVO).Beneficiario := IntToStr(ComboBoxBeneficiario.ItemIndex + 1);

      if StatusTela = stInserindo then
        Result := TFolhaPlanoSaudeController(ObjetoController).Insere(TFolhaPlanoSaudeVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFolhaPlanoSaudeVO(ObjetoVO).ToJSONString <> TFolhaPlanoSaudeVO(ObjetoOldVO).ToJSONString then
        begin
          TFolhaPlanoSaudeVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TFolhaPlanoSaudeController(ObjetoController).Altera(TFolhaPlanoSaudeVO(ObjetoVO), TFolhaPlanoSaudeVO(ObjetoOldVO));
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
procedure TFFolhaPlanoSaude.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFolhaPlanoSaudeVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFolhaPlanoSaudeVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdColaborador.AsInteger := TFolhaPlanoSaudeVO(ObjetoVO).IdColaborador;
    EditColaborador.Text := TFolhaPlanoSaudeVO(ObjetoVO).ColaboradorPessoaNome;
    EditIdOperadoraPlanoSaude.AsInteger := TFolhaPlanoSaudeVO(ObjetoVO).IdOperadoraPlanoSaude;
    EditOperadoraPlanoSaude.Text := TFolhaPlanoSaudeVO(ObjetoVO).OperadoraNome;
    EditDataInicio.Date := TFolhaPlanoSaudeVO(ObjetoVO).DataInicio;
    ComboBoxBeneficiario.ItemIndex := StrToInt(TFolhaPlanoSaudeVO(ObjetoVO).Beneficiario) - 1;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFolhaPlanoSaude.EditIdColaboradorExit(Sender: TObject);
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

procedure TFFolhaPlanoSaude.EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdColaborador.Value := -1;
    EditIdOperadoraPlanoSaude.SetFocus;
  end;
end;

procedure TFFolhaPlanoSaude.EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdOperadoraPlanoSaude.SetFocus;
  end;
end;

procedure TFFolhaPlanoSaude.EditIdOperadoraPlanoSaudeExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdOperadoraPlanoSaude.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdOperadoraPlanoSaude.Text;
      EditIdOperadoraPlanoSaude.Clear;
      EditOperadoraPlanoSaude.Clear;
      if not PopulaCamposTransientes(Filtro, TOperadoraPlanoSaudeVO, TOperadoraPlanoSaudeController) then
        PopulaCamposTransientesLookup(TOperadoraPlanoSaudeVO, TOperadoraPlanoSaudeController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdOperadoraPlanoSaude.Text := CDSTransiente.FieldByName('ID').AsString;
        EditOperadoraPlanoSaude.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdOperadoraPlanoSaude.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditOperadoraPlanoSaude.Clear;
  end;
end;

procedure TFFolhaPlanoSaude.EditIdOperadoraPlanoSaudeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdOperadoraPlanoSaude.Value := -1;
    EditDataInicio.SetFocus;
  end;
end;

procedure TFFolhaPlanoSaude.EditIdOperadoraPlanoSaudeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDataInicio.SetFocus;
  end;
end;
{$ENDREGION}

end.
