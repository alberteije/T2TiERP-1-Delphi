{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro PPP - Perfil Profissiográfico Previdenciário

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

unit UFolhaPpp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Mask, JvExMask, JvToolEdit,
  JvCombobox, LabeledCtrls, DBCtrls, LabeledDBCtrls, DB, DBClient, StrUtils,
  Math, JSonVO, Generics.Collections, Atributos, Constantes, CheckLst,
  JvExCheckLst, JvCheckListBox, JvBaseEdits, OleCtnrs, WideStrings, FMTBcd,
  Provider, SqlExpr, DBXMySql, PlatformDefaultStyleActnCtrls, ActnList, ActnMan,
  ToolWin, ActnCtrls;

type
  [TFormDescription(TConstantes.MODULO_FOLHA_PAGAMENTO, 'PPP')]

  TFFolhaPpp = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    BevelEdits: TBevel;
    PageControlDadosFolhaPpp: TPageControl;
    tsCat: TTabSheet;
    PanelCat: TPanel;
    GridCat: TJvDBUltimGrid;
    tsAtividade: TTabSheet;
    PanelAtividade: TPanel;
    GridAtividade: TJvDBUltimGrid;
    CDSFolhaPppCat: TClientDataSet;
    DSFolhaPppCat: TDataSource;
    CDSFolhaPppAtividade: TClientDataSet;
    DSFolhaPppAtividade: TDataSource;
    tsMovimentacaoBem: TTabSheet;
    PanelFatorRisco: TPanel;
    GridFatorRisco: TJvDBUltimGrid;
    CDSFolhaPppFatorRisco: TClientDataSet;
    DSFolhaPppFatorRisco: TDataSource;
    EditIdColaborador: TLabeledCalcEdit;
    EditColaborador: TLabeledEdit;
    MemoObservacao: TLabeledMemo;
    CDSFolhaPppCatID: TIntegerField;
    CDSFolhaPppCatID_FOLHA_PPP: TIntegerField;
    CDSFolhaPppCatNUMERO_CAT: TIntegerField;
    CDSFolhaPppCatDATA_AFASTAMENTO: TDateField;
    CDSFolhaPppCatDATA_REGISTRO: TDateField;
    CDSFolhaPppAtividadeID: TIntegerField;
    CDSFolhaPppAtividadeID_FOLHA_PPP: TIntegerField;
    CDSFolhaPppAtividadeDATA_INICIO: TDateField;
    CDSFolhaPppAtividadeDATA_FIM: TDateField;
    CDSFolhaPppAtividadeDESCRICAO: TStringField;
    tsExameMedico: TTabSheet;
    PanelExameMedico: TPanel;
    GridExameMedico: TJvDBUltimGrid;
    DSFolhaPppExameMedico: TDataSource;
    CDSFolhaPppExameMedico: TClientDataSet;
    CDSFolhaPppFatorRiscoID: TIntegerField;
    CDSFolhaPppFatorRiscoID_FOLHA_PPP: TIntegerField;
    CDSFolhaPppFatorRiscoDATA_INICIO: TDateField;
    CDSFolhaPppFatorRiscoDATA_FIM: TDateField;
    CDSFolhaPppFatorRiscoTIPO: TStringField;
    CDSFolhaPppFatorRiscoFATOR_RISCO: TStringField;
    CDSFolhaPppFatorRiscoINTENSIDADE: TStringField;
    CDSFolhaPppFatorRiscoTECNICA_UTILIZADA: TStringField;
    CDSFolhaPppFatorRiscoEPC_EFICAZ: TStringField;
    CDSFolhaPppFatorRiscoEPI_EFICAZ: TStringField;
    CDSFolhaPppFatorRiscoCA_EPI: TIntegerField;
    CDSFolhaPppFatorRiscoATENDIMENTO_NR06_1: TStringField;
    CDSFolhaPppFatorRiscoATENDIMENTO_NR06_2: TStringField;
    CDSFolhaPppFatorRiscoATENDIMENTO_NR06_3: TStringField;
    CDSFolhaPppFatorRiscoATENDIMENTO_NR06_4: TStringField;
    CDSFolhaPppFatorRiscoATENDIMENTO_NR06_5: TStringField;
    CDSFolhaPppExameMedicoID: TIntegerField;
    CDSFolhaPppExameMedicoID_FOLHA_PPP: TIntegerField;
    CDSFolhaPppExameMedicoDATA_ULTIMO: TDateField;
    CDSFolhaPppExameMedicoTIPO: TStringField;
    CDSFolhaPppExameMedicoNATUREZA: TStringField;
    CDSFolhaPppExameMedicoEXAME: TStringField;
    CDSFolhaPppExameMedicoINDICACAO_RESULTADOS: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure GridCatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridAtividadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridFatorRiscoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridExameMedicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdColaboradorExit(Sender: TObject);
    procedure EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    IdTipoFolhaPpp: Integer;
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

  end;

var
  FFolhaPpp: TFFolhaPpp;

implementation

uses FolhaPppVO, FolhaPppController, FolhaPppCatVO, FolhaPppAtividadeVO, FolhaPppFatorRiscoVO,
FolhaPppExameMedicoVO, ColaboradorVO, ColaboradorController;
{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFFolhaPpp.FormCreate(Sender: TObject);
var
  Form: TForm;
begin
  ClasseObjetoGridVO := TFolhaPppVO;
  ObjetoController := TFolhaPppController.Create;

  inherited;
end;

procedure TFFolhaPpp.LimparCampos;
var
  i: Integer;
begin
  inherited;

  CDSFolhaPppCat.EmptyDataSet;
  CDSFolhaPppAtividade.EmptyDataSet;
  CDSFolhaPppFatorRisco.EmptyDataSet;
  CDSFolhaPppExameMedico.EmptyDataSet;
end;

procedure TFFolhaPpp.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFFolhaPpp.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFolhaPpp.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaPpp.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaPpp.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFolhaPppController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFolhaPppController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFolhaPpp.DoSalvar: Boolean;
var
  FolhaPppCatVO: TFolhaPppCatVO;
  FolhaPppAtividadeVO: TFolhaPppAtividadeVO;
  FolhaPppFatorRiscoVO: TFolhaPppFatorRiscoVO;
  FolhaPppExameMedicoVO: TFolhaPppExameMedicoVO;
begin
  DecimalSeparator := '.';
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFolhaPppVO.Create;

      TFolhaPppVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TFolhaPppVO(ObjetoVO).ColaboradorNome := EditColaborador.Text;
      TFolhaPppVO(ObjetoVO).Observacao := MemoObservacao.Text;

      // CAT
      TFolhaPppVO(ObjetoVO).ListaFolhaPppCatVO := TObjectList<TFolhaPppCatVO>.Create;
      CDSFolhaPppCat.DisableControls;
      CDSFolhaPppCat.First;
      while not CDSFolhaPppCat.Eof do
      begin
        FolhaPppCatVO := TFolhaPppCatVO.Create;
        FolhaPppCatVO.Id := CDSFolhaPppCatID.AsInteger;
        FolhaPppCatVO.IdFolhaPpp := TFolhaPppVO(ObjetoVO).Id;
        FolhaPppCatVO.NumeroCat := CDSFolhaPppCatNUMERO_CAT.AsInteger;
        FolhaPppCatVO.DataAfastamento := CDSFolhaPppCatDATA_AFASTAMENTO.AsDateTime;
        FolhaPppCatVO.DataRegistro := CDSFolhaPppCatDATA_REGISTRO.AsDateTime;
        TFolhaPppVO(ObjetoVO).ListaFolhaPppCatVO.Add(FolhaPppCatVO);
        CDSFolhaPppCat.Next;
      end;
      CDSFolhaPppCat.EnableControls;

      // Atividade
      TFolhaPppVO(ObjetoVO).ListaFolhaPppAtividadeVO := TObjectList<TFolhaPppAtividadeVO>.Create;
      CDSFolhaPppAtividade.DisableControls;
      CDSFolhaPppAtividade.First;
      while not CDSFolhaPppAtividade.Eof do
      begin
        FolhaPppAtividadeVO := TFolhaPppAtividadeVO.Create;
        FolhaPppAtividadeVO.Id := CDSFolhaPppAtividadeID.AsInteger;
        FolhaPppAtividadeVO.IdFolhaPpp := TFolhaPppVO(ObjetoVO).Id;
        FolhaPppAtividadeVO.DataInicio := CDSFolhaPppAtividadeDATA_INICIO.AsDateTime;
        FolhaPppAtividadeVO.DataFim := CDSFolhaPppAtividadeDATA_FIM.AsDateTime;
        FolhaPppAtividadeVO.Descricao := CDSFolhaPppAtividadeDESCRICAO.AsString;
        TFolhaPppVO(ObjetoVO).ListaFolhaPppAtividadeVO.Add(FolhaPppAtividadeVO);
        CDSFolhaPppAtividade.Next;
      end;
      CDSFolhaPppAtividade.EnableControls;

      // Fator Risco
      TFolhaPppVO(ObjetoVO).ListaFolhaPppFatorRiscoVO := TObjectList<TFolhaPppFatorRiscoVO>.Create;
      CDSFolhaPppFatorRisco.DisableControls;
      CDSFolhaPppFatorRisco.First;
      while not CDSFolhaPppFatorRisco.Eof do
      begin
        FolhaPppFatorRiscoVO := TFolhaPppFatorRiscoVO.Create;
        FolhaPppFatorRiscoVO.Id := CDSFolhaPppFatorRiscoID.AsInteger;
        FolhaPppFatorRiscoVO.IdFolhaPpp := TFolhaPppVO(ObjetoVO).Id;
        FolhaPppFatorRiscoVO.DataInicio := CDSFolhaPppFatorRiscoDATA_INICIO.AsDateTime;
        FolhaPppFatorRiscoVO.DataFim := CDSFolhaPppFatorRiscoDATA_FIM.AsDateTime;
        FolhaPppFatorRiscoVO.Tipo := CDSFolhaPppFatorRiscoTIPO.AsString;
        FolhaPppFatorRiscoVO.FatorRisco := CDSFolhaPppFatorRiscoFATOR_RISCO.AsString;
        FolhaPppFatorRiscoVO.Intensidade := CDSFolhaPppFatorRiscoINTENSIDADE.AsString;
        FolhaPppFatorRiscoVO.TecnicaUtilizada := CDSFolhaPppFatorRiscoTECNICA_UTILIZADA.AsString;
        FolhaPppFatorRiscoVO.EpcEficaz := CDSFolhaPppFatorRiscoEPC_EFICAZ.AsString;
        FolhaPppFatorRiscoVO.EpiEficaz := CDSFolhaPppFatorRiscoEPI_EFICAZ.AsString;
        FolhaPppFatorRiscoVO.CaEpi := CDSFolhaPppFatorRiscoCA_EPI.AsInteger;
        FolhaPppFatorRiscoVO.AtendimentoNr061 := CDSFolhaPppFatorRiscoATENDIMENTO_NR06_1.AsString;
        FolhaPppFatorRiscoVO.AtendimentoNr062 := CDSFolhaPppFatorRiscoATENDIMENTO_NR06_2.AsString;
        FolhaPppFatorRiscoVO.AtendimentoNr063 := CDSFolhaPppFatorRiscoATENDIMENTO_NR06_3.AsString;
        FolhaPppFatorRiscoVO.AtendimentoNr064 := CDSFolhaPppFatorRiscoATENDIMENTO_NR06_4.AsString;
        FolhaPppFatorRiscoVO.AtendimentoNr065 := CDSFolhaPppFatorRiscoATENDIMENTO_NR06_5.AsString;
        TFolhaPppVO(ObjetoVO).ListaFolhaPppFatorRiscoVO.Add(FolhaPppFatorRiscoVO);
        CDSFolhaPppFatorRisco.Next;
      end;
      CDSFolhaPppFatorRisco.EnableControls;

      // Exame Médico
      TFolhaPppVO(ObjetoVO).ListaFolhaPppExameMedicoVO := TObjectList<TFolhaPppExameMedicoVO>.Create;
      CDSFolhaPppExameMedico.DisableControls;
      CDSFolhaPppExameMedico.First;
      while not CDSFolhaPppExameMedico.Eof do
      begin
        FolhaPppExameMedicoVO := TFolhaPppExameMedicoVO.Create;
        FolhaPppExameMedicoVO.Id := CDSFolhaPppExameMedicoID.AsInteger;
        FolhaPppExameMedicoVO.IdFolhaPpp := TFolhaPppVO(ObjetoVO).Id;
        FolhaPppExameMedicoVO.DataUltimo := CDSFolhaPppExameMedicoDATA_ULTIMO.AsDateTime;
        FolhaPppExameMedicoVO.Tipo := CDSFolhaPppExameMedicoTIPO.AsString;
        FolhaPppExameMedicoVO.Natureza := CDSFolhaPppExameMedicoNATUREZA.AsString;
        FolhaPppExameMedicoVO.Exame := CDSFolhaPppExameMedicoEXAME.AsString;
        FolhaPppExameMedicoVO.IndicacaoResultados := CDSFolhaPppExameMedicoINDICACAO_RESULTADOS.AsString;
        TFolhaPppVO(ObjetoVO).ListaFolhaPppExameMedicoVO.Add(FolhaPppExameMedicoVO);
        CDSFolhaPppExameMedico.Next;
      end;
      CDSFolhaPppExameMedico.EnableControls;

      TFolhaPppVO(ObjetoVO).ColaboradorVO := Nil;
      if Assigned(ObjetoOldVO) then
      begin
        TFolhaPppVO(ObjetoOldVO).ColaboradorVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TFolhaPppController(ObjetoController).Insere(TFolhaPppVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFolhaPppVO(ObjetoVO).ToJSONString <> TFolhaPppVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TFolhaPppController(ObjetoController).Altera(TFolhaPppVO(ObjetoVO), TFolhaPppVO(ObjetoOldVO));
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
procedure TFFolhaPpp.GridParaEdits;
var
  FolhaPppCatEnumerator: TEnumerator<TFolhaPppCatVO>;
  FolhaPppAtividadeEnumerator: TEnumerator<TFolhaPppAtividadeVO>;
  FolhaPppFatorRiscoEnumerator: TEnumerator<TFolhaPppFatorRiscoVO>;
  FolhaPppExameMedicoEnumerator: TEnumerator<TFolhaPppExameMedicoVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFolhaPppVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFolhaPppVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin

    EditIdColaborador.AsInteger := TFolhaPppVO(ObjetoVO).IdColaborador;
    EditColaborador.Text := TFolhaPppVO(ObjetoVO).ColaboradorNome;
    MemoObservacao.Text := TFolhaPppVO(ObjetoVO).Observacao;

    // CAT
    FolhaPppCatEnumerator := TFolhaPppVO(ObjetoVO).ListaFolhaPppCatVO.GetEnumerator;
    try
      with FolhaPppCatEnumerator do
      begin
        while MoveNext do
        begin
          CDSFolhaPppCat.Append;
          CDSFolhaPppCatID.AsInteger := Current.Id;
          CDSFolhaPppCatID_FOLHA_PPP.AsInteger := Current.IdFolhaPpp;
          CDSFolhaPppCatNUMERO_CAT.AsInteger := Current.NumeroCat;
          CDSFolhaPppCatDATA_AFASTAMENTO.AsDateTime := Current.DataAfastamento;
          CDSFolhaPppCatDATA_REGISTRO.AsDateTime := Current.DataRegistro;
          CDSFolhaPppCat.Post;
        end;
      end;
    finally
      FolhaPppCatEnumerator.Free;
    end;

    // Atividade
    FolhaPppAtividadeEnumerator := TFolhaPppVO(ObjetoVO).ListaFolhaPppAtividadeVO.GetEnumerator;
    try
      with FolhaPppAtividadeEnumerator do
      begin
        while MoveNext do
        begin
          CDSFolhaPppAtividade.Append;
          CDSFolhaPppAtividadeID.AsInteger := Current.Id;
          CDSFolhaPppAtividadeID_FOLHA_PPP.AsInteger := Current.IdFolhaPpp;
          CDSFolhaPppAtividadeDATA_INICIO.AsDateTime := Current.DataInicio;
          CDSFolhaPppAtividadeDATA_FIM.AsDateTime := Current.DataFim;
          CDSFolhaPppAtividadeDESCRICAO.AsString := Current.Descricao;
          CDSFolhaPppAtividade.Post;
        end;
      end;
    finally
      FolhaPppAtividadeEnumerator.Free;
    end;

    // Fator Risco
    FolhaPppFatorRiscoEnumerator := TFolhaPppVO(ObjetoVO).ListaFolhaPppFatorRiscoVO.GetEnumerator;
    try
      with FolhaPppFatorRiscoEnumerator do
      begin
        while MoveNext do
        begin
          CDSFolhaPppFatorRisco.Append;
          CDSFolhaPppFatorRiscoID.AsInteger := Current.Id;
          CDSFolhaPppFatorRiscoID_FOLHA_PPP.AsInteger := Current.IdFolhaPpp;
          CDSFolhaPppFatorRiscoDATA_INICIO.AsDateTime := Current.DataInicio;
          CDSFolhaPppFatorRiscoDATA_FIM.AsDateTime := Current.DataFim;
          CDSFolhaPppFatorRiscoTIPO.AsString := Current.Tipo;
          CDSFolhaPppFatorRiscoFATOR_RISCO.AsString := Current.FatorRisco;
          CDSFolhaPppFatorRiscoINTENSIDADE.AsString := Current.Intensidade;
          CDSFolhaPppFatorRiscoTECNICA_UTILIZADA.AsString := Current.TecnicaUtilizada;
          CDSFolhaPppFatorRiscoEPC_EFICAZ.AsString := Current.EpcEficaz;
          CDSFolhaPppFatorRiscoEPI_EFICAZ.AsString := Current.EpiEficaz;
          CDSFolhaPppFatorRiscoCA_EPI.AsInteger := Current.CaEpi;
          CDSFolhaPppFatorRiscoATENDIMENTO_NR06_1.AsString := Current.AtendimentoNr061;
          CDSFolhaPppFatorRiscoATENDIMENTO_NR06_2.AsString := Current.AtendimentoNr062;
          CDSFolhaPppFatorRiscoATENDIMENTO_NR06_3.AsString := Current.AtendimentoNr063;
          CDSFolhaPppFatorRiscoATENDIMENTO_NR06_4.AsString := Current.AtendimentoNr064;
          CDSFolhaPppFatorRiscoATENDIMENTO_NR06_5.AsString := Current.AtendimentoNr065;
          CDSFolhaPppFatorRisco.Post;
        end;
      end;
    finally
      FolhaPppFatorRiscoEnumerator.Free;
    end;

    // Exame Médico
    FolhaPppExameMedicoEnumerator := TFolhaPppVO(ObjetoVO).ListaFolhaPppExameMedicoVO.GetEnumerator;
    try
      with FolhaPppExameMedicoEnumerator do
      begin
        while MoveNext do
        begin
          CDSFolhaPppExameMedico.Append;
          CDSFolhaPppExameMedicoID.AsInteger := Current.Id;
          CDSFolhaPppExameMedicoID_FOLHA_PPP.AsInteger := Current.IdFolhaPpp;
          CDSFolhaPppExameMedicoDATA_ULTIMO.AsDateTime := Current.DataUltimo;
          CDSFolhaPppExameMedicoTIPO.AsString := Current.Tipo;
          CDSFolhaPppExameMedicoNATUREZA.AsString := Current.Natureza;
          CDSFolhaPppExameMedicoEXAME.AsString := Current.Exame;
          CDSFolhaPppExameMedicoINDICACAO_RESULTADOS.AsString := Current.IndicacaoResultados;
          CDSFolhaPppExameMedico.Post;
        end;
      end;
    finally
      FolhaPppExameMedicoEnumerator.Free;
    end;
  end;
end;

procedure TFFolhaPpp.GridCatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridCat.SelectedIndex := GridCat.SelectedIndex + 1;
end;

procedure TFFolhaPpp.GridAtividadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridAtividade.SelectedIndex := GridAtividade.SelectedIndex + 1;
end;

procedure TFFolhaPpp.GridFatorRiscoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridFatorRisco.SelectedIndex := GridFatorRisco.SelectedIndex + 1;
end;

procedure TFFolhaPpp.GridExameMedicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridExameMedico.SelectedIndex := GridExameMedico.SelectedIndex + 1;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFolhaPpp.EditIdColaboradorExit(Sender: TObject);
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

procedure TFFolhaPpp.EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdColaborador.Value := -1;
    MemoObservacao.SetFocus;
  end;
end;

procedure TFFolhaPpp.EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    MemoObservacao.SetFocus;
  end;
end;
{$ENDREGION}

end.
