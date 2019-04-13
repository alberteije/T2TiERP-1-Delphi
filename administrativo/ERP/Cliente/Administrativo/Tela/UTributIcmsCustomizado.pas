{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Tributação - ICMS Customizado

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

unit UTributIcmsCustomizado;

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
  [TFormDescription(TConstantes.MODULO_ADMINISTRATIVO, 'ICMS Customizado')]

  TFTributIcmsCustomizado = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    PageControlDadosTributIcmsCustomizado: TPageControl;
    tsIcms: TTabSheet;
    PanelIcms: TPanel;
    GridIcms: TJvDBUltimGrid;
    CDSIcms: TClientDataSet;
    DSIcms: TDataSource;
    ActionManager1: TActionManager;
    ActionUf: TAction;
    CDSIcmsUF_DESTINO: TStringField;
    CDSIcmsCFOP: TIntegerField;
    CDSIcmsCSOSN_B: TStringField;
    CDSIcmsCST_B: TStringField;
    CDSIcmsMVA: TFMTBCDField;
    CDSIcmsPERSISTE: TStringField;
    ActionToolBar3: TActionToolBar;
    CDSIcmsID: TIntegerField;
    ActionExcluirItem: TAction;
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
    EditDescricao: TLabeledEdit;
    BevelEdits: TBevel;
    CDSIcmsID_TRIBUT_ICMS_CUSTOM_CAB: TIntegerField;
    ComboboxOrigemMercadoria: TLabeledComboBox;
    procedure FormCreate(Sender: TObject);
    procedure GridIcmsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSIcmsAfterEdit(DataSet: TDataSet);
    procedure GridDblClick(Sender: TObject);
    procedure ActionUfExecute(Sender: TObject);
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
  FTributIcmsCustomizado: TFTributIcmsCustomizado;
  FormEditor: TForm;

implementation

uses UDataModule, ULookup, TributIcmsCustomCabVO, TributIcmsCustomCabController,
     TributIcmsCustomDetVO, TributIcmsCustomDetController, UfVO, UfController,
     CfopVO, CfopController, CsosnBVO, CsosnBController, CstIcmsBVO, CstIcmsBController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFTributIcmsCustomizado.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TTributIcmsCustomCabVO;
  ObjetoController := TTributIcmsCustomCabController.Create;

  inherited;
end;

procedure TFTributIcmsCustomizado.LimparCampos;
begin
  inherited;
  CDSIcms.EmptyDataSet;
end;

procedure TFTributIcmsCustomizado.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;
  PageControlDadosTributIcmsCustomizado.ActivePageIndex := 0;

  if StatusTela = stNavegandoEdits then
  begin
    GridIcms.ReadOnly := True;
  end
  else
  begin
    GridIcms.ReadOnly := False;
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFTributIcmsCustomizado.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditDescricao.SetFocus;
  end;
end;

function TFTributIcmsCustomizado.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditDescricao.SetFocus;
  end;
end;

function TFTributIcmsCustomizado.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TTributIcmsCustomCabController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TTributIcmsCustomCabController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFTributIcmsCustomizado.DoSalvar: Boolean;
var
  TributIcmsCustomDet: TTributIcmsCustomDetVO;
begin
  if Trim(EditDescricao.Text) = '' then
  begin
    Application.MessageBox('Descrição não podem ficar em branco.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditDescricao.SetFocus;
    Exit(False);
  end;

  Result := inherited DoSalvar;

  DecimalSeparator := '.';

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TTributIcmsCustomCabVO.Create;

      { Cabeçalho }
      TTributIcmsCustomCabVO(ObjetoVO).Descricao := EditDescricao.Text;
      TTributIcmsCustomCabVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TTributIcmsCustomCabVO(ObjetoVO).OrigemMercadoria := Copy(ComboboxOrigemMercadoria.Text, 1, 1);

      if StatusTela = stEditando then
        TTributIcmsCustomCabVO(ObjetoVO).Id := IdRegistroSelecionado;

      { Detalhe }
      TTributIcmsCustomCabVO(ObjetoVO).ListaTributIcmsCustomDetVO := TObjectList<TTributIcmsCustomDetVO>.Create;
      CDSIcms.DisableControls;
      CDSIcms.First;
      while not CDSIcms.Eof do
      begin
        if (CDSIcmsPERSISTE.AsString = 'S') or (CDSIcmsID.AsInteger = 0) then
        begin
          TributIcmsCustomDet := TTributIcmsCustomDetVO.Create;

          TributIcmsCustomDet.Id := CDSIcmsID.AsInteger;
          TributIcmsCustomDet.IdTributIcmsCustomCab := TTributIcmsCustomCabVO(ObjetoVO).Id;
          TributIcmsCustomDet.UfDestino := CDSIcmsUF_DESTINO.AsString;
          TributIcmsCustomDet.Cfop := CDSIcmsCFOP.AsInteger;
          TributIcmsCustomDet.CsosnB := CDSIcmsCSOSN_B.AsString;
          TributIcmsCustomDet.CstB := CDSIcmsCST_B.AsString;
          TributIcmsCustomDet.ModalidadeBc := CDSIcmsMODALIDADE_BC.AsString;
          TributIcmsCustomDet.Aliquota := CDSIcmsALIQUOTA.AsExtended;
          TributIcmsCustomDet.ValorPauta := CDSIcmsVALOR_PAUTA.AsExtended;
          TributIcmsCustomDet.ValorPrecoMaximo := CDSIcmsVALOR_PRECO_MAXIMO.AsExtended;
          TributIcmsCustomDet.Mva := CDSIcmsMVA.AsExtended;
          TributIcmsCustomDet.PorcentoBc := CDSIcmsPORCENTO_BC.AsExtended;
          TributIcmsCustomDet.ModalidadeBcSt := CDSIcmsMODALIDADE_BC_ST.AsString;
          TributIcmsCustomDet.AliquotaInternaSt := CDSIcmsALIQUOTA_INTERNA_ST.AsExtended;
          TributIcmsCustomDet.AliquotaInterestadualSt := CDSIcmsALIQUOTA_INTERESTADUAL_ST.AsExtended;
          TributIcmsCustomDet.PorcentoBcSt := CDSIcmsPORCENTO_BC_ST.AsExtended;
          TributIcmsCustomDet.AliquotaIcmsSt := CDSIcmsALIQUOTA_ICMS_ST.AsExtended;
          TributIcmsCustomDet.ValorPautaSt := CDSIcmsVALOR_PAUTA_ST.AsExtended;
          TributIcmsCustomDet.ValorPrecoMaximoSt := CDSIcmsVALOR_PRECO_MAXIMO_ST.AsExtended;

          TTributIcmsCustomCabVO(ObjetoVO).ListaTributIcmsCustomDetVO.Add(TributIcmsCustomDet);
        end;

        CDSIcms.Next;
      end;
      CDSIcms.First;
      CDSIcms.EnableControls;

      if StatusTela = stInserindo then
        Result := TTributIcmsCustomCabController(ObjetoController).Insere(TTributIcmsCustomCabVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TTributIcmsCustomCabVO(ObjetoVO).ToJSONString <> TTributIcmsCustomCabVO(ObjetoOldVO).ToJSONString then
        begin
          TTributIcmsCustomCabVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TTributIcmsCustomCabController(ObjetoController).Altera(TTributIcmsCustomCabVO(ObjetoVO), TTributIcmsCustomCabVO(ObjetoOldVO));
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
procedure TFTributIcmsCustomizado.GridParaEdits;
var
  TributIcmsCustomDetVOEnumerator: TEnumerator<TTributIcmsCustomDetVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TTributIcmsCustomCabVO>(IdRegistroSelecionado);
     if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TTributIcmsCustomCabVO>(IdRegistroSelecionado);
 end;

  if Assigned(ObjetoVO) then
  begin

    { Cabeçalho }
    EditDescricao.Text := TTributIcmsCustomCabVO(ObjetoVO).Descricao;
    ComboboxOrigemMercadoria.ItemIndex := AnsiIndexStr(TTributIcmsCustomCabVO(ObjetoVO).OrigemMercadoria, ['0', '1', '2']);

    { Detalhe }
    TributIcmsCustomDetVOEnumerator := TTributIcmsCustomCabVO(ObjetoVO).ListaTributIcmsCustomDetVO.GetEnumerator;
    try
      with TributIcmsCustomDetVOEnumerator do
      begin
        while MoveNext do
        begin
          CDSIcms.Append;

          CDSIcmsID.AsInteger := Current.Id;
          CDSIcmsID_TRIBUT_ICMS_CUSTOM_CAB.AsInteger := Current.IdTributIcmsCustomCab;
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
      TributIcmsCustomDetVOEnumerator.Free;
    end;

    TTributIcmsCustomCabVO(ObjetoVO).ListaTributIcmsCustomDetVO := Nil;
    if Assigned(TTributIcmsCustomCabVO(ObjetoOldVO)) then
      TTributIcmsCustomCabVO(ObjetoOldVO).ListaTributIcmsCustomDetVO := Nil;

  end;
  ConfigurarLayoutTela;
end;

procedure TFTributIcmsCustomizado.GridIcmsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFTributIcmsCustomizado.CDSIcmsAfterEdit(DataSet: TDataSet);
begin
  CDSIcmsPERSISTE.AsString := 'S';
end;

procedure TFTributIcmsCustomizado.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFTributIcmsCustomizado.ActionUfExecute(Sender: TObject);
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

procedure TFTributIcmsCustomizado.ActionExcluirItemExecute(Sender: TObject);
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
        if TTributIcmsCustomDetController.Exclui(CDSIcmsID.AsInteger) then
          CDSIcms.Delete;
      end;
    end;
  end;
end;
{$ENDREGION}

end.
