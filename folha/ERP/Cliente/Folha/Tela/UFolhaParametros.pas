{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Parâmetros para a Folha de Pagamento

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
unit UFolhaParametros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FolhaParametrosVO,
  FolhaParametrosController, Tipos, Atributos, Constantes, LabeledCtrls, Mask,
  JvExMask, JvToolEdit, JvBaseEdits, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_FOLHA_PAGAMENTO, 'Folha Parâmetros')]

  TFFolhaParametros = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditCompetencia: TLabeledMaskEdit;
    EditDiaPagamento: TLabeledCalcEdit;
    EditAliquotaPis: TLabeledCalcEdit;
    ComboBoxContribuiPis: TLabeledComboBox;
    ComboBoxDiscriminarDsr: TLabeledComboBox;
    ComboBoxCalculoProporcionalidade: TLabeledComboBox;
    GroupBox1: TGroupBox;
    ComboBoxDescontarFaltas13: TLabeledComboBox;
    ComboBoxPagarAdicionais13: TLabeledComboBox;
    ComboBoxPagarEstagiarios13: TLabeledComboBox;
    ComboBoxMesAdiantamento13: TLabeledComboBox;
    EditPercentualAdiantamento13: TLabeledCalcEdit;
    GroupBox2: TGroupBox;
    ComboBoxDescontarFaltasFerias: TLabeledComboBox;
    ComboBoxPagarAdicionaisFerias: TLabeledComboBox;
    ComboBoxPagarEstagiariosFerias: TLabeledComboBox;
    ComboBoxAdiantar13Ferias: TLabeledComboBox;
    ComboBoxCalculoJustaCausaFerias: TLabeledComboBox;
    ComboBoxMovimentoMensalFerias: TLabeledComboBox;
    procedure FormCreate(Sender: TObject);
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
  FFolhaParametros: TFFolhaParametros;

implementation

{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFFolhaParametros.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFolhaParametrosVO;
  ObjetoController := TFolhaParametrosController.Create;

  inherited;
end;

procedure TFFolhaParametros.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFFolhaParametros.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFolhaParametros.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditCompetencia.SetFocus;
  end;
end;

function TFFolhaParametros.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditCompetencia.SetFocus;
  end;
end;

function TFFolhaParametros.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFolhaParametrosController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFolhaParametrosController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFolhaParametros.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      DecimalSeparator := '.';
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFolhaParametrosVO.Create;

      TFolhaParametrosVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TFolhaParametrosVO(ObjetoVO).Competencia := EditCompetencia.Text;
      TFolhaParametrosVO(ObjetoVO).ContribuiPis := IfThen(ComboBoxContribuiPis.ItemIndex = 0, 'S', 'N');
      TFolhaParametrosVO(ObjetoVO).AliquotaPis := EditAliquotaPis.Value;
      TFolhaParametrosVO(ObjetoVO).DiscriminarDsr := IfThen(ComboBoxDiscriminarDsr.ItemIndex = 0, 'S', 'N');
      TFolhaParametrosVO(ObjetoVO).DiaPagamento := EditDiaPagamento.Text;
      TFolhaParametrosVO(ObjetoVO).CalculoProporcionalidade := IntToStr(ComboBoxCalculoProporcionalidade.ItemIndex);
      TFolhaParametrosVO(ObjetoVO).DescontarFaltas13 := IfThen(ComboBoxDescontarFaltas13.ItemIndex = 0, 'S', 'N');
      TFolhaParametrosVO(ObjetoVO).PagarAdicionais13 := IfThen(ComboBoxPagarAdicionais13.ItemIndex = 0, 'S', 'N');
      TFolhaParametrosVO(ObjetoVO).PagarEstagiarios13 := IfThen(ComboBoxPagarEstagiarios13.ItemIndex = 0, 'S', 'N');
      TFolhaParametrosVO(ObjetoVO).MesAdiantamento13 := Copy(ComboBoxMesAdiantamento13.Text, 1, 2);
      TFolhaParametrosVO(ObjetoVO).PercentualAdiantam13 := EditPercentualAdiantamento13.Value;
      TFolhaParametrosVO(ObjetoVO).FeriasDescontarFaltas := IfThen(ComboBoxDescontarFaltasFerias.ItemIndex = 0, 'S', 'N');
      TFolhaParametrosVO(ObjetoVO).FeriasPagarAdicionais := IfThen(ComboBoxPagarAdicionaisFerias.ItemIndex = 0, 'S', 'N');
      TFolhaParametrosVO(ObjetoVO).FeriasPagarEstagiarios := IfThen(ComboBoxPagarEstagiariosFerias.ItemIndex = 0, 'S', 'N');
      TFolhaParametrosVO(ObjetoVO).FeriasAdiantar13 := IfThen(ComboBoxAdiantar13Ferias.ItemIndex = 0, 'S', 'N');
      TFolhaParametrosVO(ObjetoVO).FeriasCalcJustaCausa := IfThen(ComboBoxCalculoJustaCausaFerias.ItemIndex = 0, 'S', 'N');
      TFolhaParametrosVO(ObjetoVO).FeriasMovimentoMensal := IfThen(ComboBoxMovimentoMensalFerias.ItemIndex = 0, 'S', 'N');

      if StatusTela = stInserindo then
        Result := TFolhaParametrosController(ObjetoController).Insere(TFolhaParametrosVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFolhaParametrosVO(ObjetoVO).ToJSONString <> TFolhaParametrosVO(ObjetoOldVO).ToJSONString then
        begin
          TFolhaParametrosVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TFolhaParametrosController(ObjetoController).Altera(TFolhaParametrosVO(ObjetoVO), TFolhaParametrosVO(ObjetoOldVO));
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
procedure TFFolhaParametros.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFolhaParametrosVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFolhaParametrosVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin

    EditCompetencia.Text := TFolhaParametrosVO(ObjetoVO).Competencia;
    ComboBoxContribuiPis.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).ContribuiPis, ['S', 'N']);
    EditAliquotaPis.Value := TFolhaParametrosVO(ObjetoVO).AliquotaPis;
    ComboBoxDiscriminarDsr.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).DiscriminarDsr, ['S', 'N']);
    EditDiaPagamento.Text := TFolhaParametrosVO(ObjetoVO).DiaPagamento;
    ComboBoxCalculoProporcionalidade.ItemIndex := StrToInt(TFolhaParametrosVO(ObjetoVO).CalculoProporcionalidade);
    ComboBoxDescontarFaltas13.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).DescontarFaltas13, ['S', 'N']);
    ComboBoxPagarAdicionais13.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).PagarAdicionais13, ['S', 'N']);
    ComboBoxPagarEstagiarios13.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).PagarEstagiarios13, ['S', 'N']);
    ComboBoxMesAdiantamento13.ItemIndex := StrToInt(TFolhaParametrosVO(ObjetoVO).MesAdiantamento13) - 1;
    EditPercentualAdiantamento13.Value := TFolhaParametrosVO(ObjetoVO).PercentualAdiantam13;
    ComboBoxDescontarFaltasFerias.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).FeriasDescontarFaltas, ['S', 'N']);
    ComboBoxPagarAdicionaisFerias.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).FeriasPagarAdicionais, ['S', 'N']);
    ComboBoxPagarEstagiariosFerias.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).FeriasPagarEstagiarios, ['S', 'N']);
    ComboBoxAdiantar13Ferias.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).FeriasAdiantar13, ['S', 'N']);
    ComboBoxCalculoJustaCausaFerias.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).FeriasCalcJustaCausa, ['S', 'N']);
    ComboBoxMovimentoMensalFerias.ItemIndex := AnsiIndexStr(TFolhaParametrosVO(ObjetoVO).FeriasMovimentoMensal, ['S', 'N']);
  end;
end;
{$ENDREGION}

end.
