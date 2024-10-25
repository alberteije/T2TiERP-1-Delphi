{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Hor�rios para o Ponto Eletr�nico

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
unit UPontoHorario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, PontoHorarioVO,
  PontoHorarioController, Tipos, Atributos, Constantes, LabeledCtrls, Mask,
  JvExMask, JvToolEdit, JvBaseEdits, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_PONTO_ELETRONICO, 'Ponto Hor�rio')]

  TFPontoHorario = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditCargaHoraria: TLabeledMaskEdit;
    ComboboxTipo: TLabeledComboBox;
    EditCodigo: TLabeledEdit;
    EditNome: TLabeledEdit;
    ComboboxTipoTrabalho: TLabeledComboBox;
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
    EditHoraInicioJornada: TLabeledMaskEdit;
    EditHoraFimJornada: TLabeledMaskEdit;
    procedure FormCreate(Sender: TObject);
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
  FPontoHorario: TFPontoHorario;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFPontoHorario.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TPontoHorarioVO;
  ObjetoController := TPontoHorarioController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFPontoHorario.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    ComboboxTipo.SetFocus;
  end;
end;

function TFPontoHorario.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    ComboboxTipo.SetFocus;
  end;
end;

function TFPontoHorario.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TPontoHorarioController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TPontoHorarioController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFPontoHorario.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TPontoHorarioVO.Create;

      TPontoHorarioVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TPontoHorarioVO(ObjetoVO).Tipo := Copy(ComboboxTipo.Text, 1, 1);
      TPontoHorarioVO(ObjetoVO).Codigo := EditCodigo.Text;
      TPontoHorarioVO(ObjetoVO).Nome := EditNome.Text;
      TPontoHorarioVO(ObjetoVO).TipoTrabalho := Copy(ComboboxTipoTrabalho.Text, 1, 1);
      TPontoHorarioVO(ObjetoVO).CargaHoraria := EditCargaHoraria.Text;
      TPontoHorarioVO(ObjetoVO).Entrada01 := EditEntrada01.Text;
      TPontoHorarioVO(ObjetoVO).Entrada02 := EditEntrada02.Text;
      TPontoHorarioVO(ObjetoVO).Entrada03 := EditEntrada03.Text;
      TPontoHorarioVO(ObjetoVO).Entrada04 := EditEntrada04.Text;
      TPontoHorarioVO(ObjetoVO).Entrada05 := EditEntrada05.Text;
      TPontoHorarioVO(ObjetoVO).Saida01 := EditSaida01.Text;
      TPontoHorarioVO(ObjetoVO).Saida02 := EditSaida02.Text;
      TPontoHorarioVO(ObjetoVO).Saida03 := EditSaida03.Text;
      TPontoHorarioVO(ObjetoVO).Saida04 := EditSaida04.Text;
      TPontoHorarioVO(ObjetoVO).Saida05 := EditSaida05.Text;
      TPontoHorarioVO(ObjetoVO).HoraInicioJornada := EditHoraInicioJornada.Text;
      TPontoHorarioVO(ObjetoVO).HoraFimJornada := EditHoraFimJornada.Text;

      if StatusTela = stInserindo then
        Result := TPontoHorarioController(ObjetoController).Insere(TPontoHorarioVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TPontoHorarioVO(ObjetoVO).ToJSONString <> TPontoHorarioVO(ObjetoOldVO).ToJSONString then
        begin
          TPontoHorarioVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TPontoHorarioController(ObjetoController).Altera(TPontoHorarioVO(ObjetoVO), TPontoHorarioVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFPontoHorario.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TPontoHorarioVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TPontoHorarioVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    case AnsiIndexStr(TPontoHorarioVO(ObjetoVO).Tipo, ['F', 'D', 'S', 'M']) of
      0:
        ComboboxTipo.ItemIndex := 0;
      1:
        ComboboxTipo.ItemIndex := 1;
      2:
        ComboboxTipo.ItemIndex := 2;
      3:
        ComboboxTipo.ItemIndex := 3;
    end;

    EditCodigo.Text := TPontoHorarioVO(ObjetoVO).Codigo;
    EditNome.Text := TPontoHorarioVO(ObjetoVO).Nome;

    case AnsiIndexStr(TPontoHorarioVO(ObjetoVO).TipoTrabalho, ['N', 'C', 'F']) of
      0:
        ComboboxTipoTrabalho.ItemIndex := 0;
      1:
        ComboboxTipoTrabalho.ItemIndex := 1;
      2:
        ComboboxTipoTrabalho.ItemIndex := 2;
    end;

    EditCargaHoraria.Text := TPontoHorarioVO(ObjetoVO).CargaHoraria;
    EditEntrada01.Text := TPontoHorarioVO(ObjetoVO).Entrada01;
    EditEntrada02.Text := TPontoHorarioVO(ObjetoVO).Entrada02;
    EditEntrada03.Text := TPontoHorarioVO(ObjetoVO).Entrada03;
    EditEntrada04.Text := TPontoHorarioVO(ObjetoVO).Entrada04;
    EditEntrada05.Text := TPontoHorarioVO(ObjetoVO).Entrada05;
    EditSaida01.Text := TPontoHorarioVO(ObjetoVO).Saida01;
    EditSaida02.Text := TPontoHorarioVO(ObjetoVO).Saida02;
    EditSaida03.Text := TPontoHorarioVO(ObjetoVO).Saida03;
    EditSaida04.Text := TPontoHorarioVO(ObjetoVO).Saida04;
    EditSaida05.Text := TPontoHorarioVO(ObjetoVO).Saida05;
    EditHoraInicioJornada.Text := TPontoHorarioVO(ObjetoVO).HoraInicioJornada;
    EditHoraFimJornada.Text := TPontoHorarioVO(ObjetoVO).HoraFimJornada;
  end;
end;
{$ENDREGION}

end.
