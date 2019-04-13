{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Parâmetros para o módulo Escrita Fiscal

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
unit UFiscalParametros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FiscalParametrosVO,
  FiscalParametrosController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, WideStrings,
  DBXMySql, FMTBcd, SqlExpr, Provider;

type
  [TFormDescription(TConstantes.MODULO_ESCRITA_FISCAL, 'Parâmetros')]

  TFFiscalParametros = class(TFTelaCadastro)
    PanelMestre: TPanel;
    PageControlItens: TPageControl;
    tsFederal: TTabSheet;
    PanelFederal: TPanel;
    EditVigencia: TLabeledMaskEdit;
    EditDescricaoVigencia: TLabeledEdit;
    tsEstadual: TTabSheet;
    PanelEstadual: TPanel;
    tsMunicipal: TTabSheet;
    PanelMunicipal: TPanel;
    ComboBoxApuracao: TLabeledComboBox;
    ComboBoxMicroempreendedorIndividual: TLabeledComboBox;
    ComboBoxCalcPisCofinsEfd: TLabeledComboBox;
    EditSimplesCodigoAcesso: TLabeledEdit;
    ComboBoxSimplesTabela: TLabeledComboBox;
    ComboBoxSimplesAtividade: TLabeledComboBox;
    ComboBoxPerfilSped: TLabeledComboBox;
    ComboBoxApuracaoConsolidada: TLabeledComboBox;
    ComboBoxSubstituicaoTributaria: TLabeledComboBox;
    ComboBoxFormaCalculoIss: TLabeledComboBox;
    ComboBoxCriterioLancamento: TLabeledComboBox;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;


    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
  end;

var
  FFiscalParametros: TFFiscalParametros;

implementation

uses ULookup, Biblioteca, UDataModule;
{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFFiscalParametros.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFiscalParametrosVO;
  ObjetoController := TFiscalParametrosController.Create;

  inherited;
end;

procedure TFFiscalParametros.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;

  if StatusTela = stNavegandoEdits then
  begin
    PanelMestre.Enabled := False;
    PanelFederal.Enabled := False;
    PanelEstadual.Enabled := False;
    PanelMunicipal.Enabled := False;
  end
  else
  begin
    PanelMestre.Enabled := True;
    PanelFederal.Enabled := True;
    PanelEstadual.Enabled := True;
    PanelMunicipal.Enabled := True;
  end;
end;

procedure TFFiscalParametros.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFiscalParametros.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditVigencia.SetFocus;
  end;
end;

function TFFiscalParametros.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditVigencia.SetFocus;
  end;
end;

function TFFiscalParametros.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFiscalParametrosController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFiscalParametrosController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFiscalParametros.DoSalvar: Boolean;
begin
  DecimalSeparator := '.';
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFiscalParametrosVO.Create;

      TFiscalParametrosVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TFiscalParametrosVO(ObjetoVO).Vigencia := EditVigencia.Text;
      TFiscalParametrosVO(ObjetoVO).DescricaoVigencia := EditDescricaoVigencia.Text;
      TFiscalParametrosVO(ObjetoVO).CriterioLancamento := Copy(ComboBoxCriterioLancamento.Text, 1, 1);
      // Federal
      TFiscalParametrosVO(ObjetoVO).Apuracao := IntToStr(ComboBoxApuracao.ItemIndex + 1);
      TFiscalParametrosVO(ObjetoVO).MicroempreeIndividual := IfThen(ComboBoxMicroempreendedorIndividual.ItemIndex = 0, 'S', 'N');
      TFiscalParametrosVO(ObjetoVO).CalcPisCofinsEfd := Copy(ComboBoxCalcPisCofinsEfd.Text, 1, 2);
      TFiscalParametrosVO(ObjetoVO).SimplesCodigoAcesso := EditSimplesCodigoAcesso.Text;
      TFiscalParametrosVO(ObjetoVO).SimplesTabela := IntToStr(ComboBoxSimplesTabela.ItemIndex + 1);
      TFiscalParametrosVO(ObjetoVO).SimplesAtividade := Copy(ComboBoxSimplesAtividade.Text, 1, 2);
      // Estadual
      TFiscalParametrosVO(ObjetoVO).PerfilSped := Copy(ComboBoxPerfilSped.Text, 1, 1);
      TFiscalParametrosVO(ObjetoVO).ApuracaoConsolidada := IfThen(ComboBoxApuracaoConsolidada.ItemIndex = 0, 'S', 'N');
      TFiscalParametrosVO(ObjetoVO).SubstituicaoTributaria := IfThen(ComboBoxSubstituicaoTributaria.ItemIndex = 0, 'S', 'N');
      // Municipal
      TFiscalParametrosVO(ObjetoVO).FormaCalculoIss := Copy(ComboBoxFormaCalculoIss.Text, 1, 2);

      if StatusTela = stInserindo then
        Result := TFiscalParametrosController(ObjetoController).Insere(TFiscalParametrosVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFiscalParametrosVO(ObjetoVO).ToJSONString <> TFiscalParametrosVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TFiscalParametrosController(ObjetoController).Altera(TFiscalParametrosVO(ObjetoVO), TFiscalParametrosVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
  DecimalSeparator := ',';
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFFiscalParametros.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFiscalParametrosVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFiscalParametrosVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditVigencia.Text := TFiscalParametrosVO(ObjetoVO).Vigencia;
    EditDescricaoVigencia.Text := TFiscalParametrosVO(ObjetoVO).DescricaoVigencia;
    ComboBoxCriterioLancamento.ItemIndex := AnsiIndexStr(TFiscalParametrosVO(ObjetoVO).CriterioLancamento, ['L', 'A', 'N']);
    // Federal
    ComboBoxApuracao.ItemIndex := AnsiIndexStr(TFiscalParametrosVO(ObjetoVO).Apuracao, ['1', '2']);
    ComboBoxMicroempreendedorIndividual.ItemIndex := AnsiIndexStr(TFiscalParametrosVO(ObjetoVO).MicroempreeIndividual, ['S', 'N']);
    ComboBoxCalcPisCofinsEfd.ItemIndex := AnsiIndexStr(TFiscalParametrosVO(ObjetoVO).CalcPisCofinsEfd, ['AB', 'AD', 'UP']);
    EditSimplesCodigoAcesso.Text := TFiscalParametrosVO(ObjetoVO).SimplesCodigoAcesso;
    ComboBoxSimplesTabela.ItemIndex := AnsiIndexStr(TFiscalParametrosVO(ObjetoVO).SimplesTabela, ['1', '2']);
    ComboBoxSimplesAtividade.ItemIndex := AnsiIndexStr(TFiscalParametrosVO(ObjetoVO).SimplesAtividade, ['CO', 'IN', 'S1', 'S2', 'S3']);
    // Estadual
    ComboBoxPerfilSped.ItemIndex := AnsiIndexStr(TFiscalParametrosVO(ObjetoVO).PerfilSped, ['A', 'B', 'C']);
    ComboBoxApuracaoConsolidada.ItemIndex := AnsiIndexStr(TFiscalParametrosVO(ObjetoVO).ApuracaoConsolidada, ['S', 'N']);
    ComboBoxSubstituicaoTributaria.ItemIndex := AnsiIndexStr(TFiscalParametrosVO(ObjetoVO).SubstituicaoTributaria, ['S', 'N']);
    // Municipal
    ComboBoxFormaCalculoIss.ItemIndex := AnsiIndexStr(TFiscalParametrosVO(ObjetoVO).FormaCalculoIss, ['NO', 'PH', 'VF']);
  end;

  ConfigurarLayoutTela;
end;
{$ENDREGION}

end.
