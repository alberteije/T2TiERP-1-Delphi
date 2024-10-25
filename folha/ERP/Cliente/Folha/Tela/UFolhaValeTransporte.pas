{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Vale Transporte para o m�dulo Folha de Pagamento

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

unit UFolhaValeTransporte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FolhaValeTransporteVO, FolhaValeTransporteController,
  Atributos, Constantes, LabeledCtrls, Mask, JvExMask, JvToolEdit, JvBaseEdits,
  StrUtils;

type
  [TFormDescription(TConstantes.MODULO_FOLHA_PAGAMENTO, 'Vale Transporte')]

  TFFolhaValeTransporte = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditIdColaborador: TLabeledCalcEdit;
    EditColaborador: TLabeledEdit;
    EditIdItinerario: TLabeledCalcEdit;
    EditItinerario: TLabeledEdit;
    EditQuantidade: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdColaboradorExit(Sender: TObject);
    procedure EditIdColaboradorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdItinerarioExit(Sender: TObject);
    procedure EditIdItinerarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdItinerarioKeyPress(Sender: TObject; var Key: Char);
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
  FFolhaValeTransporte: TFFolhaValeTransporte;

implementation

uses ColaboradorVO, ColaboradorController, EmpresaTransporteItinerarioVO,
EmpresaTransporteItinerarioController;

{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFFolhaValeTransporte.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFolhaValeTransporteVO;
  ObjetoController := TFolhaValeTransporteController.Create;

  inherited;
end;

procedure TFFolhaValeTransporte.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFFolhaValeTransporte.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFolhaValeTransporte.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaValeTransporte.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaValeTransporte.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFolhaValeTransporteController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFolhaValeTransporteController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFolhaValeTransporte.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      DecimalSeparator := '.';
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFolhaValeTransporteVO.Create;

      TFolhaValeTransporteVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TFolhaValeTransporteVO(ObjetoVO).ColaboradorPessoaNome := EditColaborador.Text;
      TFolhaValeTransporteVO(ObjetoVO).IdEmpresaTranspItin := EditIdItinerario.AsInteger;
      TFolhaValeTransporteVO(ObjetoVO).EmpresaTransporteItinerarioNome := EditItinerario.Text;
      TFolhaValeTransporteVO(ObjetoVO).Quantidade := EditQuantidade.AsInteger;

      if StatusTela = stInserindo then
        Result := TFolhaValeTransporteController(ObjetoController).Insere(TFolhaValeTransporteVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFolhaValeTransporteVO(ObjetoVO).ToJSONString <> TFolhaValeTransporteVO(ObjetoOldVO).ToJSONString then
        begin
          TFolhaValeTransporteVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TFolhaValeTransporteController(ObjetoController).Altera(TFolhaValeTransporteVO(ObjetoVO), TFolhaValeTransporteVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
      DecimalSeparator := ',';
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFFolhaValeTransporte.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFolhaValeTransporteVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFolhaValeTransporteVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdColaborador.AsInteger := TFolhaValeTransporteVO(ObjetoVO).IdColaborador;
    EditColaborador.Text := TFolhaValeTransporteVO(ObjetoVO).ColaboradorPessoaNome;
    EditIdItinerario.AsInteger := TFolhaValeTransporteVO(ObjetoVO).IdEmpresaTranspItin;
    EditItinerario.Text := TFolhaValeTransporteVO(ObjetoVO).EmpresaTransporteItinerarioNome;
    EditQuantidade.AsInteger := TFolhaValeTransporteVO(ObjetoVO).Quantidade;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFolhaValeTransporte.EditIdColaboradorExit(Sender: TObject);
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

procedure TFFolhaValeTransporte.EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdColaborador.Value := -1;
    EditIdItinerario.SetFocus;
  end;
end;

procedure TFFolhaValeTransporte.EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdItinerario.SetFocus;
  end;
end;

procedure TFFolhaValeTransporte.EditIdItinerarioExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdItinerario.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdItinerario.Text;
      EditIdItinerario.Clear;
      EditItinerario.Clear;
      if not PopulaCamposTransientes(Filtro, TEmpresaTransporteItinerarioVO, TEmpresaTransporteItinerarioController) then
        PopulaCamposTransientesLookup(TEmpresaTransporteItinerarioVO, TEmpresaTransporteItinerarioController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdItinerario.Text := CDSTransiente.FieldByName('ID').AsString;
        EditItinerario.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdItinerario.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditItinerario.Clear;
  end;
end;

procedure TFFolhaValeTransporte.EditIdItinerarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdItinerario.Value := -1;
    EditQuantidade.SetFocus;
  end;
end;

procedure TFFolhaValeTransporte.EditIdItinerarioKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditQuantidade.SetFocus;
  end;
end;
{$ENDREGION}

end.
