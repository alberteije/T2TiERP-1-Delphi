{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Tributação - ISS

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

unit UTributIss;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Mask, JvExMask, JvToolEdit,
  JvCombobox, LabeledCtrls, DBCtrls, LabeledDBCtrls, DB, DBClient, StrUtils,
  Math, JSonVO, Generics.Collections, Atributos, Constantes, CheckLst,
  JvExCheckLst, JvCheckListBox, JvBaseEdits, OleCtnrs, WideStrings, FMTBcd,
  Provider, SqlExpr, ActnList, ToolWin, ActnMan, ActnCtrls, ShellApi,
  PlatformDefaultStyleActnCtrls;

type
  [TFormDescription(TConstantes.MODULO_ADMINISTRATIVO, 'Tributação - ISS')]

  TFTributIss = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    BevelEdits: TBevel;
    PageControlDadosTributIss: TPageControl;
    EditIdOperacaoFiscal: TLabeledCalcEdit;
    EditOperacaoFiscal: TLabeledEdit;
    tsIss: TTabSheet;
    PanelIss: TPanel;
    EditPorcentoBaseCalculoIss: TLabeledCalcEdit;
    ComboboxModalidadeBcIss: TLabeledComboBox;
    EditAliquotaPorcentoIss: TLabeledCalcEdit;
    EditAliquotaUnidadeIss: TLabeledCalcEdit;
    EditValorPrecoMaximoIss: TLabeledCalcEdit;
    EditValorPautaFiscalIss: TLabeledCalcEdit;
    EditItemListaServico: TLabeledCalcEdit;
    ComboboxCodigoTributacao: TLabeledComboBox;
    procedure FormCreate(Sender: TObject);
    procedure EditIdOperacaoFiscalExit(Sender: TObject);
    procedure EditIdOperacaoFiscalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdOperacaoFiscalKeyPress(Sender: TObject; var Key: Char);
    procedure GridDblClick(Sender: TObject);
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

    procedure ConfigurarLayoutTela;
  end;

var
  FTributIss: TFTributIss;
  FormEditor: TForm;

implementation

uses UDataModule, ULookup, TributIssVO, TributIssController, TributOperacaoFiscalVO,
  TributOperacaoFiscalController;

{$R *.dfm}

{$REGION 'Infra'}
procedure TFTributIss.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TTributIssVO;
  ObjetoController := TTributIssController.Create;

  inherited;
end;

procedure TFTributIss.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;
  PageControlDadosTributIss.ActivePageIndex := 0;

  if StatusTela = stNavegandoEdits then
  begin
    PanelIss.Enabled := False;
  end
  else
  begin
    PanelIss.Enabled := True;
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFTributIss.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdOperacaoFiscal.SetFocus;
  end;
end;

function TFTributIss.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdOperacaoFiscal.SetFocus;
  end;
end;

function TFTributIss.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TTributIssController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TTributIssController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFTributIss.DoSalvar: Boolean;
begin
  if EditIdOperacaoFiscal.AsInteger <= 0 then
  begin
    Application.MessageBox('Operação Fiscal não pode ficar em branco.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdOperacaoFiscal.SetFocus;
    Exit(False);
  end;

  Result := inherited DoSalvar;

  DecimalSeparator := '.';

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TTributIssVO.Create;

      TTributIssVO(ObjetoVO).IdTributOperacaoFiscal := EditIdOperacaoFiscal.AsInteger;
      TTributIssVO(ObjetoVO).TributOperacaoFiscalDescricao := EditOperacaoFiscal.Text;
      TTributIssVO(ObjetoVO).ModalidadeBaseCalculo := Copy(ComboboxModalidadeBcIss.Text, 1, 1);
      TTributIssVO(ObjetoVO).PorcentoBaseCalculo := EditPorcentoBaseCalculoIss.Value;
      TTributIssVO(ObjetoVO).AliquotaPorcento := EditAliquotaPorcentoIss.Value;
      TTributIssVO(ObjetoVO).AliquotaUnidade := EditAliquotaUnidadeIss.Value;
      TTributIssVO(ObjetoVO).ValorPrecoMaximo := EditValorPrecoMaximoIss.Value;
      TTributIssVO(ObjetoVO).ValorPautaFiscal := EditValorPautaFiscalIss.Value;
      TTributIssVO(ObjetoVO).ItemListaServico := EditItemListaServico.AsInteger;
      TTributIssVO(ObjetoVO).CodigoTributacao := Copy(ComboboxCodigoTributacao.Text, 1, 1);

      // ObjetoVO - libera objetos vinculados (TAssociation) que não tem necessidade de subir
      TTributIssVO(ObjetoVO).TributOperacaoFiscalVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) que não tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TTributIssVO(ObjetoOldVO).TributOperacaoFiscalVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TTributIssController(ObjetoController).Insere(TTributIssVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TTributIssVO(ObjetoVO).ToJSONString <> TTributIssVO(ObjetoOldVO).ToJSONString then
        begin
          TTributIssVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TTributIssController(ObjetoController).Altera(TTributIssVO(ObjetoVO), TTributIssVO(ObjetoOldVO));
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

{$REGION 'Campos Transientes'}
procedure TFTributIss.EditIdOperacaoFiscalExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdOperacaoFiscal.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdOperacaoFiscal.Text;
      EditIdOperacaoFiscal.Clear;
      EditOperacaoFiscal.Clear;
      if not PopulaCamposTransientes(Filtro, TTributOperacaoFiscalVO, TTributOperacaoFiscalController) then
        PopulaCamposTransientesLookup(TTributOperacaoFiscalVO, TTributOperacaoFiscalController);

      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdOperacaoFiscal.Text := CDSTransiente.FieldByName('ID').AsString;
        EditOperacaoFiscal.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditIdOperacaoFiscal.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditOperacaoFiscal.Clear;
  end;
end;

procedure TFTributIss.EditIdOperacaoFiscalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdOperacaoFiscal.Value := -1;
    PageControlDadosTributIss.SetFocus;
  end;
end;

procedure TFTributIss.EditIdOperacaoFiscalKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    PageControlDadosTributIss.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFTributIss.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TTributIssVO>(IdRegistroSelecionado);
     if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TTributIssVO>(IdRegistroSelecionado);
 end;

  if Assigned(ObjetoVO) then
  begin

    { Cabeçalho - Configura }
    EditIdOperacaoFiscal.AsInteger := TTributIssVO(ObjetoVO).IdTributOperacaoFiscal;
    EditOperacaoFiscal.Text := TTributIssVO(ObjetoVO).TributOperacaoFiscalDescricao;
    ComboboxModalidadeBcIss.ItemIndex := AnsiIndexStr(TTributIssVO(ObjetoVO).ModalidadeBaseCalculo, ['0', '9']);
    EditPorcentoBaseCalculoIss.Value := TTributIssVO(ObjetoVO).PorcentoBaseCalculo;
    EditAliquotaPorcentoIss.Value := TTributIssVO(ObjetoVO).AliquotaPorcento;
    EditAliquotaUnidadeIss.Value := TTributIssVO(ObjetoVO).AliquotaUnidade;
    EditValorPrecoMaximoIss.Value := TTributIssVO(ObjetoVO).ValorPrecoMaximo;
    EditValorPautaFiscalIss.Value := TTributIssVO(ObjetoVO).ValorPautaFiscal;
    EditItemListaServico.AsInteger := TTributIssVO(ObjetoVO).ItemListaServico;
    ComboboxCodigoTributacao.ItemIndex := AnsiIndexStr(TTributIssVO(ObjetoVO).CodigoTributacao, ['N', 'R', 'S', 'I']);

  end;
  ConfigurarLayoutTela;
end;

procedure TFTributIss.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;
{$ENDREGION}

end.
