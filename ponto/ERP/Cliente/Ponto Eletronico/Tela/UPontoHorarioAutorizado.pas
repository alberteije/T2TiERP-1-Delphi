{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Hor�rios Autorizados para o Ponto Eletr�nico

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
unit UPontoHorarioAutorizado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, PontoHorarioAutorizadoVO,
  PontoHorarioAutorizadoController, Tipos, Atributos, Constantes, LabeledCtrls, Mask,
  JvExMask, JvToolEdit, JvBaseEdits, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_PONTO_ELETRONICO, 'Ponto Hor�rio Autorizado')]

  TFPontoHorarioAutorizado = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditCargaHoraria: TLabeledMaskEdit;
    EditHoraFechamentoDia: TLabeledMaskEdit;
    ComboboxTipo: TLabeledComboBox;
    GroupBoxRegistros: TGroupBox;
    EditEntrada01: TLabeledMaskEdit;
    EditEntrada02: TLabeledMaskEdit;
    EditEntrada03: TLabeledMaskEdit;
    EditEntrada04: TLabeledMaskEdit;
    EditEntrada05: TLabeledMaskEdit;
    EditSaida01: TLabeledMaskEdit;
    EditSaida02: TLabeledMaskEdit;
    EditSaida03: TLabeledMaskEdit;
    EditSaida04: TLabeledMaskEdit;
    EditSaida05: TLabeledMaskEdit;
    EditIdColaborador: TLabeledCalcEdit;
    EditColaborador: TLabeledEdit;
    EditDataHorario: TLabeledDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdColaboradorExit(Sender: TObject);
    procedure EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
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
  FPontoHorarioAutorizado: TFPontoHorarioAutorizado;

implementation

uses ColaboradorVO, ColaboradorController;

{$R *.dfm}

{$REGION 'Infra'}
procedure TFPontoHorarioAutorizado.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TPontoHorarioAutorizadoVO;
  ObjetoController := TPontoHorarioAutorizadoController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFPontoHorarioAutorizado.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFPontoHorarioAutorizado.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFPontoHorarioAutorizado.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TPontoHorarioAutorizadoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TPontoHorarioAutorizadoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFPontoHorarioAutorizado.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TPontoHorarioAutorizadoVO.Create;

      TPontoHorarioAutorizadoVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TPontoHorarioAutorizadoVO(ObjetoVO).DataHorario := EditDataHorario.Date;
      TPontoHorarioAutorizadoVO(ObjetoVO).Tipo := Copy(ComboboxTipo.Text, 1, 1);
      TPontoHorarioAutorizadoVO(ObjetoVO).CargaHoraria := EditCargaHoraria.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).Entrada01 := EditEntrada01.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).Entrada02 := EditEntrada02.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).Entrada03 := EditEntrada03.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).Entrada04 := EditEntrada04.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).Entrada05 := EditEntrada05.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).Saida01 := EditSaida01.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).Saida02 := EditSaida02.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).Saida03 := EditSaida03.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).Saida04 := EditSaida04.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).Saida05 := EditSaida05.Text;
      TPontoHorarioAutorizadoVO(ObjetoVO).HoraFechamentoDia := EditHoraFechamentoDia.Text;

      if StatusTela = stInserindo then
        Result := TPontoHorarioAutorizadoController(ObjetoController).Insere(TPontoHorarioAutorizadoVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TPontoHorarioAutorizadoVO(ObjetoVO).ToJSONString <> TPontoHorarioAutorizadoVO(ObjetoOldVO).ToJSONString then
        begin
          TPontoHorarioAutorizadoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TPontoHorarioAutorizadoController(ObjetoController).Altera(TPontoHorarioAutorizadoVO(ObjetoVO), TPontoHorarioAutorizadoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFPontoHorarioAutorizado.EditIdColaboradorExit(Sender: TObject);
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

procedure TFPontoHorarioAutorizado.EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdColaborador.Value := -1;
    EditDataHorario.SetFocus;
  end;
end;

procedure TFPontoHorarioAutorizado.EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDataHorario.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFPontoHorarioAutorizado.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TPontoHorarioAutorizadoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TPontoHorarioAutorizadoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    case AnsiIndexStr(TPontoHorarioAutorizadoVO(ObjetoVO).Tipo, ['F', 'D', 'S', 'M']) of
      0:
        ComboboxTipo.ItemIndex := 0;
      1:
        ComboboxTipo.ItemIndex := 1;
      2:
        ComboboxTipo.ItemIndex := 2;
      3:
        ComboboxTipo.ItemIndex := 3;
    end;

    EditIdColaborador.AsInteger := TPontoHorarioAutorizadoVO(ObjetoVO).IdColaborador;
    EditColaborador.Text := TPontoHorarioAutorizadoVO(ObjetoVO).ColaboradorNome;
    EditDataHorario.Date := TPontoHorarioAutorizadoVO(ObjetoVO).DataHorario;
    EditCargaHoraria.Text := TPontoHorarioAutorizadoVO(ObjetoVO).CargaHoraria;
    EditEntrada01.Text := TPontoHorarioAutorizadoVO(ObjetoVO).Entrada01;
    EditEntrada02.Text := TPontoHorarioAutorizadoVO(ObjetoVO).Entrada02;
    EditEntrada03.Text := TPontoHorarioAutorizadoVO(ObjetoVO).Entrada03;
    EditEntrada04.Text := TPontoHorarioAutorizadoVO(ObjetoVO).Entrada04;
    EditEntrada05.Text := TPontoHorarioAutorizadoVO(ObjetoVO).Entrada05;
    EditSaida01.Text := TPontoHorarioAutorizadoVO(ObjetoVO).Saida01;
    EditSaida02.Text := TPontoHorarioAutorizadoVO(ObjetoVO).Saida02;
    EditSaida03.Text := TPontoHorarioAutorizadoVO(ObjetoVO).Saida03;
    EditSaida04.Text := TPontoHorarioAutorizadoVO(ObjetoVO).Saida04;
    EditSaida05.Text := TPontoHorarioAutorizadoVO(ObjetoVO).Saida05;
    EditHoraFechamentoDia.Text := TPontoHorarioAutorizadoVO(ObjetoVO).HoraFechamentoDia;
  end;
end;
{$ENDREGION}

end.
