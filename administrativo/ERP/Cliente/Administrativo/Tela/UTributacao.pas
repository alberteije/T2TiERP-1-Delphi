{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Tributação

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

unit UTributacao;

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
  [TFormDescription(TConstantes.MODULO_ADMINISTRATIVO, 'Tributação')]

  TFTributacao = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    BevelEdits: TBevel;
    PageControlDadosTributacao: TPageControl;
    tsPis: TTabSheet;
    tsIcms: TTabSheet;
    PanelIcms: TPanel;
    GridIcms: TJvDBUltimGrid;
    tsCofins: TTabSheet;
    PanelCofins: TPanel;
    EditIdOperacaoFiscal: TLabeledCalcEdit;
    EditOperacaoFiscal: TLabeledEdit;
    EditIdGrupoTributario: TLabeledCalcEdit;
    EditGrupoTributario: TLabeledEdit;
    PanelPis: TPanel;
    EditPorcentoBaseCalculoPis: TLabeledCalcEdit;
    CDSIcms: TClientDataSet;
    DSIcms: TDataSource;
    tsIpi: TTabSheet;
    PanelIpi: TPanel;
    ActionManager1: TActionManager;
    ActionUf: TAction;
    CDSIcmsUF_DESTINO: TStringField;
    CDSIcmsCFOP: TIntegerField;
    CDSIcmsCSOSN_B: TStringField;
    CDSIcmsCST_B: TStringField;
    CDSIcmsMVA: TFMTBCDField;
    CDSIcmsPERSISTE: TStringField;
    ActionToolBar3: TActionToolBar;
    EditCodigoCstPis: TLabeledCalcEdit;
    EditCstPis: TLabeledEdit;
    EditCodigoApuracaoEfdPis: TLabeledCalcEdit;
    EditDescricaoCodigoApuracaoEfdPis: TLabeledEdit;
    ComboboxModalidadeBcPis: TLabeledComboBox;
    EditAliquotaPorcentoPis: TLabeledCalcEdit;
    EditAliquotaUnidadePis: TLabeledCalcEdit;
    EditValorPrecoMaximoPis: TLabeledCalcEdit;
    EditValorPautaFiscalPis: TLabeledCalcEdit;
    EditPorcentoBaseCalculoCofins: TLabeledCalcEdit;
    EditCodigoCstCofins: TLabeledCalcEdit;
    EditCstCofins: TLabeledEdit;
    EditCodigoApuracaoEfdCofins: TLabeledCalcEdit;
    EditDescricaoCodigoApuracaoEfdCofins: TLabeledEdit;
    ComboboxModalidadeBcCofins: TLabeledComboBox;
    EditAliquotaPorcentoCofins: TLabeledCalcEdit;
    EditAliquotaUnidadeCofins: TLabeledCalcEdit;
    EditValorPrecoMaximoCofins: TLabeledCalcEdit;
    EditValorPautaFiscalCofins: TLabeledCalcEdit;
    EditPorcentoBaseCalculoIpi: TLabeledCalcEdit;
    EditCodigoCstIpi: TLabeledCalcEdit;
    EditCstIpi: TLabeledEdit;
    EditIdTipoReceitaDipi: TLabeledCalcEdit;
    EditTipoReceitaDipi: TLabeledEdit;
    ComboboxModalidadeBcIpi: TLabeledComboBox;
    EditAliquotaPorcentoIpi: TLabeledCalcEdit;
    EditAliquotaUnidadeIpi: TLabeledCalcEdit;
    EditValorPrecoMaximoIpi: TLabeledCalcEdit;
    EditValorPautaFiscalIpi: TLabeledCalcEdit;
    CDSIcmsID: TIntegerField;
    ActionExcluirItem: TAction;
    CDSIcmsID_TRIBUT_CONFIGURA_OF_GT: TIntegerField;
    CDSIcmsMODALIDADE_BC: TStringField;
    CDSIcmsALIQUOTA: TFMTBCDField;
    CDSIcmsVALOR_PAUTA: TFMTBCDField;
    CDSIcmsVALOR_PRECO_MAXIMO: TFMTBCDField;
    CDSIcmsPORCENTO_BC: TFMTBCDField;
    CDSIcmsMODALIDADE_BC_ST: TStringField;
    CDSIcmsALIQUOTA_INTERNA_ST: TFMTBCDField;
    CDSIcmsALIQUOTA_INTERESTADUAL_ST: TFMTBCDField;
    CDSIcmsPORCENTO_BC_ST: TFMTBCDField;
    CDSIcmsALIQUOTA_ICMS_ST: TFMTBCDField;
    CDSIcmsVALOR_PAUTA_ST: TFMTBCDField;
    CDSIcmsVALOR_PRECO_MAXIMO_ST: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure GridIcmsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSIcmsAfterEdit(DataSet: TDataSet);
    procedure EditIdOperacaoFiscalExit(Sender: TObject);
    procedure EditIdOperacaoFiscalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdOperacaoFiscalKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdGrupoTributarioExit(Sender: TObject);
    procedure EditIdGrupoTributarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdGrupoTributarioKeyPress(Sender: TObject; var Key: Char);
    procedure GridDblClick(Sender: TObject);
    procedure ActionUfExecute(Sender: TObject);
    procedure EditCodigoCstPisExit(Sender: TObject);
    procedure EditCodigoCstPisKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditCodigoCstPisKeyPress(Sender: TObject; var Key: Char);
    procedure EditCodigoApuracaoEfdPisExit(Sender: TObject);
    procedure EditCodigoApuracaoEfdPisKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditCodigoApuracaoEfdPisKeyPress(Sender: TObject; var Key: Char);
    procedure EditCodigoCstCofinsExit(Sender: TObject);
    procedure EditCodigoCstCofinsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditCodigoCstCofinsKeyPress(Sender: TObject; var Key: Char);
    procedure EditCodigoApuracaoEfdCofinsExit(Sender: TObject);
    procedure EditCodigoApuracaoEfdCofinsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditCodigoApuracaoEfdCofinsKeyPress(Sender: TObject; var Key: Char);
    procedure EditCodigoCstIpiExit(Sender: TObject);
    procedure EditCodigoCstIpiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditCodigoCstIpiKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdTipoReceitaDipiExit(Sender: TObject);
    procedure EditIdTipoReceitaDipiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdTipoReceitaDipiKeyPress(Sender: TObject; var Key: Char);
    procedure ActionExcluirItemExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
  end;

var
  FTributacao: TFTributacao;
  FormEditor: TForm;

implementation

uses UDataModule, ULookup, TributConfiguraOfGtVO, TributConfiguraOfGtController,
  TributGrupoTributarioVO, TributOperacaoFiscalVO, TributPisCodApuracaoVO,
  TributCofinsCodApuracaoVO, TributIpiDipiVO, TributIcmsUfVO, TributOperacaoFiscalController,
  TributGrupoTributarioController, UfVO, UfController, CfopVO, CfopController,
  CsosnBVO, CsosnBController, CstIcmsBVO, CstIcmsBController, CstPisVO, CstPisController,
  CstCofinsVO, CstCofinsController, CodigoApuracaoEfdVO, CodigoApuracaoEfdController,
  CstIpiVO, CstIpiController, TipoReceitaDipiVO, TipoReceitaDipiController,
  TributIcmsUfController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFTributacao.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TTributConfiguraOfGtVO;
  ObjetoController := TTributConfiguraOfGtController.Create;

  inherited;
end;

procedure TFTributacao.LimparCampos;
begin
  inherited;
  CDSIcms.EmptyDataSet;
end;

procedure TFTributacao.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;
  PageControlDadosTributacao.ActivePageIndex := 0;

  if StatusTela = stNavegandoEdits then
  begin
    GridIcms.ReadOnly := True;
    PanelPis.Enabled := False;
    PanelCofins.Enabled := False;
    PanelIpi.Enabled := False;
  end
  else
  begin
    GridIcms.ReadOnly := False;
    PanelPis.Enabled := True;
    PanelCofins.Enabled := True;
    PanelIpi.Enabled := True;
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFTributacao.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdOperacaoFiscal.SetFocus;
  end;
end;

function TFTributacao.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdOperacaoFiscal.SetFocus;
  end;
end;

function TFTributacao.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TTributConfiguraOfGtController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TTributConfiguraOfGtController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFTributacao.DoSalvar: Boolean;
var
  TributIcmsUf: TTributIcmsUfVO;
begin
  if (EditIdOperacaoFiscal.AsInteger <= 0) or (EditIdGrupoTributario.AsInteger <= 0) then
  begin
    Application.MessageBox('Operação Fiscal ou Grupo Tributário não podem ficar em branco.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdOperacaoFiscal.SetFocus;
    Exit(False);
  end;

  Result := inherited DoSalvar;

  DecimalSeparator := '.';

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TTributConfiguraOfGtVO.Create;

      { Cabeçalho - Configura }
      TTributConfiguraOfGtVO(ObjetoVO).IdTributOperacaoFiscal := EditIdOperacaoFiscal.AsInteger;
      TTributConfiguraOfGtVO(ObjetoVO).TributOperacaoFiscalDescricao := EditOperacaoFiscal.Text;
      TTributConfiguraOfGtVO(ObjetoVO).IdTributGrupoTributario := EditIdGrupoTributario.AsInteger;
      TTributConfiguraOfGtVO(ObjetoVO).TributGrupoTributarioDescricao := EditGrupoTributario.Text;

      if StatusTela = stEditando then
        TTributConfiguraOfGtVO(ObjetoVO).Id := IdRegistroSelecionado;

      { Pis }
      if (EditCodigoCstPis.AsInteger > 0) and (EditCodigoApuracaoEfdPis.AsInteger > 0) then
      begin
        if StatusTela = stInserindo then
          TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO := TTributPisCodApuracaoVO.Create;

        TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.CstPis := StringOfChar('0', 2 - Length(EditCodigoCstPis.Text)) + EditCodigoCstPis.Text;
        TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.CodigoApuracaoEfd := StringOfChar('0', 2 - Length(EditCodigoApuracaoEfdPis.Text)) + EditCodigoApuracaoEfdPis.Text;
        TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.ModalidadeBaseCalculo := IntToStr(ComboboxModalidadeBcPis.ItemIndex);
        TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.PorcentoBaseCalculo := EditPorcentoBaseCalculoPis.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.AliquotaPorcento := EditAliquotaPorcentoPis.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.AliquotaUnidade := EditAliquotaUnidadePis.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.ValorPrecoMaximo := EditValorPrecoMaximoPis.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.ValorPautaFiscal := EditValorPautaFiscalPis.Value;

        if StatusTela = stEditando then
        begin
          if TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.ToJSONString = TTributConfiguraOfGtVO(ObjetoOldVO).TributPisCodApuracaoVO.ToJSONString then
          begin
            TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO := Nil;
            TTributConfiguraOfGtVO(ObjetoOldVO).TributPisCodApuracaoVO := Nil;
          end
          else
            TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.IdTributConfiguraOfGt := TTributConfiguraOfGtVO(ObjetoVO).Id;
        end;
      end;

      { Cofins }
      if (EditCodigoCstCofins.AsInteger > 0) and (EditCodigoApuracaoEfdCofins.AsInteger > 0) then
      begin
        if StatusTela = stInserindo then
          TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO := TTributCofinsCodApuracaoVO.Create;

        TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.CstCofins := StringOfChar('0', 2 - Length(EditCodigoCstCofins.Text)) + EditCodigoCstCofins.Text;
        TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.CodigoApuracaoEfd := StringOfChar('0', 2 - Length(EditCodigoApuracaoEfdCofins.Text)) + EditCodigoApuracaoEfdCofins.Text;
        TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.ModalidadeBaseCalculo := IntToStr(ComboboxModalidadeBcCofins.ItemIndex);
        TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.PorcentoBaseCalculo := EditPorcentoBaseCalculoCofins.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.AliquotaPorcento := EditAliquotaPorcentoCofins.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.AliquotaUnidade := EditAliquotaUnidadeCofins.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.ValorPrecoMaximo := EditValorPrecoMaximoCofins.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.ValorPautaFiscal := EditValorPautaFiscalCofins.Value;

        if StatusTela = stEditando then
        begin
          if TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.ToJSONString = TTributConfiguraOfGtVO(ObjetoOldVO).TributCofinsCodApuracaoVO.ToJSONString then
          begin
            TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO := Nil;
            TTributConfiguraOfGtVO(ObjetoOldVO).TributCofinsCodApuracaoVO := Nil;
          end
          else
            TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.IdTributConfiguraOfGt := TTributConfiguraOfGtVO(ObjetoVO).Id;
        end;
      end;

      { Ipi }
      if Trim(EditCstIpi.Text) <> '' then
      begin
        if StatusTela = stInserindo then
          TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO := TTributIpiDipiVO.Create;

        TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.CstIpi := StringOfChar('0', 2 - Length(EditCodigoCstIpi.Text)) + EditCodigoCstIpi.Text;
        TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.IdTipoReceitaDipi := EditIdTipoReceitaDipi.AsInteger;
        TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.ModalidadeBaseCalculo := IntToStr(ComboboxModalidadeBcIpi.ItemIndex);
        TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.PorcentoBaseCalculo := EditPorcentoBaseCalculoIpi.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.AliquotaPorcento := EditAliquotaPorcentoIpi.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.AliquotaUnidade := EditAliquotaUnidadeIpi.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.ValorPrecoMaximo := EditValorPrecoMaximoIpi.Value;
        TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.ValorPautaFiscal := EditValorPautaFiscalIpi.Value;

        if StatusTela = stEditando then
        begin
          if TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.ToJSONString = TTributConfiguraOfGtVO(ObjetoOldVO).TributIpiDipiVO.ToJSONString then
          begin
            TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO := Nil;
            TTributConfiguraOfGtVO(ObjetoOldVO).TributIpiDipiVO := Nil;
          end
          else
            TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.IdTributConfiguraOfGt := TTributConfiguraOfGtVO(ObjetoVO).Id;
        end;
      end;

      { ICMS por UF }
      TTributConfiguraOfGtVO(ObjetoVO).ListaTributIcmsUfVO := TObjectList<TTributIcmsUfVO>.Create;
      CDSIcms.DisableControls;
      CDSIcms.First;
      while not CDSIcms.Eof do
      begin
        if (CDSIcmsPERSISTE.AsString = 'S') or (CDSIcmsID.AsInteger = 0) then
        begin
          TributIcmsUf := TTributIcmsUfVO.Create;

          TributIcmsUf.Id := CDSIcmsID.AsInteger;
          TributIcmsUf.IdTributConfiguraOfGt := TTributConfiguraOfGtVO(ObjetoVO).Id;
          TributIcmsUf.UfDestino := CDSIcmsUF_DESTINO.AsString;
          TributIcmsUf.Cfop := CDSIcmsCFOP.AsInteger;
          TributIcmsUf.CsosnB := CDSIcmsCSOSN_B.AsString;
          TributIcmsUf.CstB := CDSIcmsCST_B.AsString;
          TributIcmsUf.ModalidadeBc := CDSIcmsMODALIDADE_BC.AsString;
          TributIcmsUf.Aliquota := CDSIcmsALIQUOTA.AsExtended;
          TributIcmsUf.ValorPauta := CDSIcmsVALOR_PAUTA.AsExtended;
          TributIcmsUf.ValorPrecoMaximo := CDSIcmsVALOR_PRECO_MAXIMO.AsExtended;
          TributIcmsUf.Mva := CDSIcmsMVA.AsExtended;
          TributIcmsUf.PorcentoBc := CDSIcmsPORCENTO_BC.AsExtended;
          TributIcmsUf.ModalidadeBcSt := CDSIcmsMODALIDADE_BC_ST.AsString;
          TributIcmsUf.AliquotaInternaSt := CDSIcmsALIQUOTA_INTERNA_ST.AsExtended;
          TributIcmsUf.AliquotaInterestadualSt := CDSIcmsALIQUOTA_INTERESTADUAL_ST.AsExtended;
          TributIcmsUf.PorcentoBcSt := CDSIcmsPORCENTO_BC_ST.AsExtended;
          TributIcmsUf.AliquotaIcmsSt := CDSIcmsALIQUOTA_ICMS_ST.AsExtended;
          TributIcmsUf.ValorPautaSt := CDSIcmsVALOR_PAUTA_ST.AsExtended;
          TributIcmsUf.ValorPrecoMaximoSt := CDSIcmsVALOR_PRECO_MAXIMO_ST.AsExtended;

          TTributConfiguraOfGtVO(ObjetoVO).ListaTributIcmsUfVO.Add(TributIcmsUf);
        end;

        CDSIcms.Next;
      end;
      CDSIcms.First;
      CDSIcms.EnableControls;


      // ObjetoVO - libera objetos vinculados (TAssociation) que não tem necessidade de subir
      TTributConfiguraOfGtVO(ObjetoVO).TributOperacaoFiscalVO := Nil;
      TTributConfiguraOfGtVO(ObjetoVO).TributGrupoTributarioVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) que não tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TTributConfiguraOfGtVO(ObjetoOldVO).TributOperacaoFiscalVO := Nil;
        TTributConfiguraOfGtVO(ObjetoOldVO).TributGrupoTributarioVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TTributConfiguraOfGtController(ObjetoController).Insere(TTributConfiguraOfGtVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TTributConfiguraOfGtVO(ObjetoVO).ToJSONString <> TTributConfiguraOfGtVO(ObjetoOldVO).ToJSONString then
        begin
          TTributConfiguraOfGtVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TTributConfiguraOfGtController(ObjetoController).Altera(TTributConfiguraOfGtVO(ObjetoVO), TTributConfiguraOfGtVO(ObjetoOldVO));
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
procedure TFTributacao.EditIdOperacaoFiscalExit(Sender: TObject);
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

procedure TFTributacao.EditIdOperacaoFiscalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdOperacaoFiscal.Value := -1;
    EditIdGrupoTributario.SetFocus;
  end;
end;

procedure TFTributacao.EditIdOperacaoFiscalKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdGrupoTributario.SetFocus;
  end;
end;

procedure TFTributacao.EditIdTipoReceitaDipiExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdTipoReceitaDipi.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdTipoReceitaDipi.Text;
      EditIdTipoReceitaDipi.Clear;
      EditTipoReceitaDipi.Clear;
      if not PopulaCamposTransientes(Filtro, TTipoReceitaDipiVO, TTipoReceitaDipiController) then
        PopulaCamposTransientesLookup(TTipoReceitaDipiVO, TTipoReceitaDipiController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdTipoReceitaDipi.Text := CDSTransiente.FieldByName('ID').AsString;
        EditTipoReceitaDipi.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditIdTipoReceitaDipi.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditTipoReceitaDipi.Clear;
  end;
end;

procedure TFTributacao.EditIdTipoReceitaDipiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdTipoReceitaDipi.Value := -1;
    ComboboxModalidadeBcIpi.SetFocus;
  end;
end;

procedure TFTributacao.EditIdTipoReceitaDipiKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ComboboxModalidadeBcIpi.SetFocus;
  end;
end;

procedure TFTributacao.EditCodigoApuracaoEfdCofinsExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditCodigoApuracaoEfdCofins.Value <> 0 then
  begin
    try
      Filtro := 'CODIGO = ' + EditCodigoApuracaoEfdCofins.Text;
      EditCodigoApuracaoEfdCofins.Clear;
      EditDescricaoCodigoApuracaoEfdCofins.Clear;
      if not PopulaCamposTransientes(Filtro, TCodigoApuracaoEfdVO, TCodigoApuracaoEfdController) then
        PopulaCamposTransientesLookup(TCodigoApuracaoEfdVO, TCodigoApuracaoEfdController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditCodigoApuracaoEfdCofins.Text := CDSTransiente.FieldByName('CODIGO').AsString;
        EditDescricaoCodigoApuracaoEfdCofins.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditCodigoApuracaoEfdCofins.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCodigoApuracaoEfdCofins.Clear;
  end;
end;

procedure TFTributacao.EditCodigoApuracaoEfdCofinsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditCodigoApuracaoEfdCofins.Value := -1;
    ComboboxModalidadeBcCofins.SetFocus;
  end;
end;

procedure TFTributacao.EditCodigoApuracaoEfdCofinsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ComboboxModalidadeBcCofins.SetFocus;
  end;
end;

procedure TFTributacao.EditCodigoApuracaoEfdPisExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditCodigoApuracaoEfdPis.Value <> 0 then
  begin
    try
      Filtro := 'CODIGO = ' + EditCodigoApuracaoEfdPis.Text;
      EditCodigoApuracaoEfdPis.Clear;
      EditDescricaoCodigoApuracaoEfdPis.Clear;
      if not PopulaCamposTransientes(Filtro, TCodigoApuracaoEfdVO, TCodigoApuracaoEfdController) then
        PopulaCamposTransientesLookup(TCodigoApuracaoEfdVO, TCodigoApuracaoEfdController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditCodigoApuracaoEfdPis.Text := CDSTransiente.FieldByName('CODIGO').AsString;
        EditDescricaoCodigoApuracaoEfdPis.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditCodigoApuracaoEfdPis.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCodigoApuracaoEfdPis.Clear;
  end;
end;

procedure TFTributacao.EditCodigoApuracaoEfdPisKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditCodigoApuracaoEfdPis.Value := -1;
    ComboboxModalidadeBcPis.SetFocus;
  end;
end;

procedure TFTributacao.EditCodigoApuracaoEfdPisKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ComboboxModalidadeBcPis.SetFocus;
  end;
end;

procedure TFTributacao.EditCodigoCstCofinsExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditCodigoCstCofins.Value <> 0 then
  begin
    try
      Filtro := 'CODIGO = ' + EditCodigoCstCofins.Text;
      EditCodigoCstCofins.Clear;
      EditCstCofins.Clear;
      if not PopulaCamposTransientes(Filtro, TCstCofinsVO, TCstCofinsController) then
        PopulaCamposTransientesLookup(TCstCofinsVO, TCstCofinsController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditCodigoCstCofins.Text := CDSTransiente.FieldByName('CODIGO').AsString;
        EditCstCofins.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditCodigoCstCofins.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCodigoCstCofins.Clear;
  end;
end;

procedure TFTributacao.EditCodigoCstCofinsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditCodigoCstCofins.Value := -1;
    EditCodigoApuracaoEfdCofins.SetFocus;
  end;
end;

procedure TFTributacao.EditCodigoCstCofinsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditCodigoApuracaoEfdCofins.SetFocus;
  end;
end;

procedure TFTributacao.EditCodigoCstIpiExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditCodigoCstIpi.Value <> 0 then
  begin
    try
      Filtro := 'CODIGO = ' + EditCodigoCstIpi.Text;
      EditCodigoCstIpi.Clear;
      EditCstIpi.Clear;
      if not PopulaCamposTransientes(Filtro, TCstIpiVO, TCstIpiController) then
        PopulaCamposTransientesLookup(TCstIpiVO, TCstIpiController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditCodigoCstIpi.Text := CDSTransiente.FieldByName('CODIGO').AsString;
        EditCstIpi.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditCodigoCstIpi.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCodigoCstIpi.Clear;
  end;
end;

procedure TFTributacao.EditCodigoCstIpiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditCodigoCstIpi.Value := -1;
    EditIdTipoReceitaDipi.SetFocus;
  end;
end;

procedure TFTributacao.EditCodigoCstIpiKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdTipoReceitaDipi.SetFocus;
  end;
end;

procedure TFTributacao.EditCodigoCstPisExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditCodigoCstPis.Value <> 0 then
  begin
    try
      Filtro := 'CODIGO = ' + EditCodigoCstPis.Text;
      EditCodigoCstPis.Clear;
      EditCstPis.Clear;
      if not PopulaCamposTransientes(Filtro, TCstPisVO, TCstPisController) then
        PopulaCamposTransientesLookup(TCstPisVO, TCstPisController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditCodigoCstPis.Text := CDSTransiente.FieldByName('CODIGO').AsString;
        EditCstPis.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditCodigoCstPis.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCodigoCstPis.Clear;
  end;
end;

procedure TFTributacao.EditCodigoCstPisKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditCodigoCstPis.Value := -1;
    EditCodigoApuracaoEfdPis.SetFocus;
  end;
end;

procedure TFTributacao.EditCodigoCstPisKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditCodigoApuracaoEfdPis.SetFocus;
  end;
end;

procedure TFTributacao.EditIdGrupoTributarioExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdGrupoTributario.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdGrupoTributario.Text;
      EditIdGrupoTributario.Clear;
      EditGrupoTributario.Clear;
      if not PopulaCamposTransientes(Filtro, TTributGrupoTributarioVO, TTributGrupoTributarioController) then
        PopulaCamposTransientesLookup(TTributGrupoTributarioVO, TTributGrupoTributarioController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdGrupoTributario.Text := CDSTransiente.FieldByName('ID').AsString;
        EditGrupoTributario.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditIdGrupoTributario.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdGrupoTributario.Clear;
  end;
end;

procedure TFTributacao.EditIdGrupoTributarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdGrupoTributario.Value := -1;
    PageControlDadosTributacao.SetFocus;
  end;
end;

procedure TFTributacao.EditIdGrupoTributarioKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    PageControlDadosTributacao.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFTributacao.GridParaEdits;
var
  TributIcmsUfVOEnumerator: TEnumerator<TTributIcmsUfVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TTributConfiguraOfGtVO>(IdRegistroSelecionado);
     if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TTributConfiguraOfGtVO>(IdRegistroSelecionado);
 end;

  if Assigned(ObjetoVO) then
  begin

    { Cabeçalho - Configura }
    EditIdOperacaoFiscal.AsInteger := TTributConfiguraOfGtVO(ObjetoVO).IdTributOperacaoFiscal;
    EditOperacaoFiscal.Text := TTributConfiguraOfGtVO(ObjetoVO).TributOperacaoFiscalDescricao;
    EditIdGrupoTributario.AsInteger := TTributConfiguraOfGtVO(ObjetoVO).IdTributGrupoTributario;
    EditGrupoTributario.Text := TTributConfiguraOfGtVO(ObjetoVO).TributGrupoTributarioDescricao;

    { Pis }
    EditCodigoCstPis.Text := TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.CstPis;
    if Assigned(TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.CstPisVO) then
      EditCstPis.Text := TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.CstPisVO.Descricao;
    EditCodigoApuracaoEfdPis.Text := TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.CodigoApuracaoEfd;
    if Assigned(TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.CodigoApuracaoEfdVO) then
      EditDescricaoCodigoApuracaoEfdPis.Text := TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.CodigoApuracaoEfdVO.Descricao;
    ComboboxModalidadeBcPis.ItemIndex := AnsiIndexStr(TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.ModalidadeBaseCalculo, ['0', '1']);
    EditPorcentoBaseCalculoPis.Value := TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.PorcentoBaseCalculo;
    EditAliquotaPorcentoPis.Value := TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.AliquotaPorcento;
    EditAliquotaUnidadePis.Value := TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.AliquotaUnidade;
    EditValorPrecoMaximoPis.Value := TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.ValorPrecoMaximo;
    EditValorPautaFiscalPis.Value := TTributConfiguraOfGtVO(ObjetoVO).TributPisCodApuracaoVO.ValorPautaFiscal;

    { Cofins }
    EditCodigoCstCofins.Text := TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.CstCofins;
    if Assigned(TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.CstCofinsVO) then
      EditCstCofins.Text := TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.CstCofinsVO.Descricao;
    EditCodigoApuracaoEfdCofins.Text := TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.CodigoApuracaoEfd;
    if Assigned(TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.CodigoApuracaoEfdVO) then
      EditDescricaoCodigoApuracaoEfdCofins.Text := TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.CodigoApuracaoEfdVO.Descricao;
    ComboboxModalidadeBcCofins.ItemIndex := AnsiIndexStr(TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.ModalidadeBaseCalculo, ['0', '1']);
    EditPorcentoBaseCalculoCofins.Value := TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.PorcentoBaseCalculo;
    EditAliquotaPorcentoCofins.Value := TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.AliquotaPorcento;
    EditAliquotaUnidadeCofins.Value := TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.AliquotaUnidade;
    EditValorPrecoMaximoCofins.Value := TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.ValorPrecoMaximo;
    EditValorPautaFiscalCofins.Value := TTributConfiguraOfGtVO(ObjetoVO).TributCofinsCodApuracaoVO.ValorPautaFiscal;

    { Ipi }
    EditCodigoCstIpi.Text := TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.CstIpi;
    if Assigned(TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.CstIpiVO) then
      EditCstIpi.Text:= TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.CstIpiVO.Descricao;
    if EditIdTipoReceitaDipi.AsInteger > 0 then
    begin
      EditIdTipoReceitaDipi.AsInteger := TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.IdTipoReceitaDipi;
      EditTipoReceitaDipi.Text := TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.TipoReceitaDipiVO.Descricao;
    end;
    ComboboxModalidadeBcIpi.ItemIndex := AnsiIndexStr(TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.ModalidadeBaseCalculo, ['0', '1']);
    EditPorcentoBaseCalculoIpi.Value := TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.PorcentoBaseCalculo;
    EditAliquotaPorcentoIpi.Value := TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.AliquotaPorcento;
    EditAliquotaUnidadeIpi.Value := TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.AliquotaUnidade;
    EditValorPrecoMaximoIpi.Value := TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.ValorPrecoMaximo;
    EditValorPautaFiscalIpi.Value := TTributConfiguraOfGtVO(ObjetoVO).TributIpiDipiVO.ValorPautaFiscal;

    { ICMS por UF }
    TributIcmsUfVOEnumerator := TTributConfiguraOfGtVO(ObjetoVO).ListaTributIcmsUfVO.GetEnumerator;
    try
      with TributIcmsUfVOEnumerator do
      begin
        while MoveNext do
        begin
          CDSIcms.Append;

          CDSIcmsID.AsInteger := Current.Id;
          CDSIcmsID_TRIBUT_CONFIGURA_OF_GT.AsInteger := Current.IdTributConfiguraOfGt;
          CDSIcmsUF_DESTINO.AsString := Current.UfDestino;
          CDSIcmsCFOP.AsInteger := Current.Cfop;
          CDSIcmsCSOSN_B.AsString := Current.CsosnB;
          CDSIcmsCST_B.AsString := Current.CstB;
          CDSIcmsMODALIDADE_BC.AsString := Current.ModalidadeBc;
          CDSIcmsALIQUOTA.AsExtended := Current.Aliquota;
          CDSIcmsVALOR_PAUTA.AsExtended := Current.ValorPauta;
          CDSIcmsVALOR_PRECO_MAXIMO.AsExtended := Current.ValorPrecoMaximo;
          CDSIcmsMVA.AsExtended := Current.Mva;
          CDSIcmsPORCENTO_BC.AsExtended := Current.PorcentoBc;
          CDSIcmsMODALIDADE_BC_ST.AsString := Current.ModalidadeBcSt;
          CDSIcmsALIQUOTA_INTERNA_ST.AsExtended := Current.AliquotaInternaSt;
          CDSIcmsALIQUOTA_INTERESTADUAL_ST.AsExtended := Current.AliquotaInterestadualSt;
          CDSIcmsPORCENTO_BC_ST.AsExtended := Current.PorcentoBcSt;
          CDSIcmsALIQUOTA_ICMS_ST.AsExtended := Current.AliquotaIcmsSt;
          CDSIcmsVALOR_PAUTA_ST.AsExtended := Current.ValorPautaSt;
          CDSIcmsVALOR_PRECO_MAXIMO_ST.AsExtended := Current.ValorPrecoMaximoSt;

          CDSIcms.Post;
        end;
      end;
    finally
      TributIcmsUfVOEnumerator.Free;
    end;

    TTributConfiguraOfGtVO(ObjetoVO).ListaTributIcmsUfVO := Nil;
    if Assigned(TTributConfiguraOfGtVO(ObjetoOldVO)) then
      TTributConfiguraOfGtVO(ObjetoOldVO).ListaTributIcmsUfVO := Nil;

  end;
  ConfigurarLayoutTela;
end;

procedure TFTributacao.GridIcmsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    if CDSIcms.IsEmpty then
    begin
      CDSIcms.Append;
      CDSIcms.Post;
    end;

    { UF }
    if GridIcms.SelectedIndex = 0 then
    begin
      try
        PopulaCamposTransientesLookup(TUfVO, TUfController);
        if CDSTransiente.RecordCount > 0 then
        begin
          CDSIcms.Edit;
          CDSIcmsUF_DESTINO.AsString := CDSTransiente.FieldByName('SIGLA').AsString;
          CDSIcms.Post;
        end;
      finally
        CDSTransiente.Close;
      end;
    end;

    { CFOP }
    if GridIcms.SelectedIndex = 1 then
    begin
      try
        PopulaCamposTransientesLookup(TCfopVO, TCfopController);
        if CDSTransiente.RecordCount > 0 then
        begin
          CDSIcms.Edit;
          CDSIcmsCFOP.AsString := CDSTransiente.FieldByName('CFOP').AsString;
          CDSIcms.Post;
        end;
      finally
        CDSTransiente.Close;
      end;
    end;

    { CSOSN }
    if GridIcms.SelectedIndex = 2 then
    begin
      try
        PopulaCamposTransientesLookup(TCsosnBVO, TCsosnBController);
        if CDSTransiente.RecordCount > 0 then
        begin
          CDSIcms.Edit;
          CDSIcmsCSOSN_B.AsString := CDSTransiente.FieldByName('CODIGO').AsString;
          CDSIcms.Post;
        end;
      finally
        CDSTransiente.Close;
      end;
    end;

    { CST }
    if GridIcms.SelectedIndex = 3 then
    begin
      try
        PopulaCamposTransientesLookup(TCstIcmsBVO, TCstIcmsBController);
        if CDSTransiente.RecordCount > 0 then
        begin
          CDSIcms.Edit;
          CDSIcmsCST_B.AsString := CDSTransiente.FieldByName('CODIGO').AsString;
          CDSIcms.Post;
        end;
      finally
        CDSTransiente.Close;
      end;
    end;

  end;
  //
  If Key = VK_RETURN then
    GridIcms.SelectedIndex := GridIcms.SelectedIndex + 1;
end;

procedure TFTributacao.CDSIcmsAfterEdit(DataSet: TDataSet);
begin
  CDSIcmsPERSISTE.AsString := 'S';
end;

procedure TFTributacao.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFTributacao.ActionUfExecute(Sender: TObject);
var
  Filtro: String;
begin
  if Application.MessageBox('Deseja Importar as UFs? [os dados atuais serão excluídos]', 'Pergunta do Sistema', MB_YesNo + MB_IconQuestion) = IdYes then
  begin
    CDSIcms.DisableControls;
    CDSIcms.EmptyDataSet;
    Filtro := 'ID > 0';
    PopulaCamposTransientes(Filtro, TUfVO, TUfController);
    CDSTransiente.First;
    while not CDSTransiente.eof do
    begin
      CDSIcms.Append;
      CDSIcmsUF_DESTINO.AsString := CDSTransiente.FieldByName('SIGLA').AsString;
      CDSIcms.Post;
      CDSTransiente.Next;
    end;
    CDSIcms.First;
    CDSIcms.EnableControls;
  end;
end;

procedure TFTributacao.ActionExcluirItemExecute(Sender: TObject);
begin
  if CDSIcms.IsEmpty then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      if StatusTela = stInserindo then
        CDSIcms.Delete
      else if StatusTela = stEditando then
      begin
        if TTributIcmsUfController.Exclui(CDSIcmsID.AsInteger) then
          CDSIcms.Delete;
      end;
    end;
  end;
end;
{$ENDREGION}

end.
