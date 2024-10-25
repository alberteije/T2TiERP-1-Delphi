{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Cadastro de �ndices para o m�dulo Contabilidade

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
unit UContabilIndice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ContabilIndiceVO,
  ContabilIndiceController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls;

type
  [TFormDescription(TConstantes.MODULO_CONTABILIDADE, '�ndices')]

  TFContabilIndice = class(TFTelaCadastro)
    DSContabilIndiceValor: TDataSource;
    CDSContabilIndiceValor: TClientDataSet;
    PanelMestre: TPanel;
    PageControlItens: TPageControl;
    tsItens: TTabSheet;
    PanelItens: TPanel;
    GridDetalhe: TJvDBUltimGrid;
    ComboBoxPeriodicidade: TLabeledComboBox;
    CDSContabilIndiceValorID: TIntegerField;
    CDSContabilIndiceValorID_CONTABIL_INDICE: TIntegerField;
    CDSContabilIndiceValorDATA_INDICE: TDateField;
    CDSContabilIndiceValorVALOR: TFMTBCDField;
    EditMensalMesAno: TLabeledMaskEdit;
    EditDiarioAPartirDe: TLabeledDateEdit;
    EditIdIndiceEconomico: TLabeledCalcEdit;
    EditIndiceEconomico: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdIndiceEconomicoExit(Sender: TObject);
    procedure EditIdIndiceEconomicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridDblClick(Sender: TObject);
    procedure EditIdIndiceEconomicoKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
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

    procedure ConfigurarLayoutTela;
  end;

var
  FContabilIndice: TFContabilIndice;

implementation

uses ULookup, Biblioteca, UDataModule, ContabilIndiceValorVO, IndiceEconomicoVO,
IndiceEconomicoController;
{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFContabilIndice.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContabilIndiceVO;
  ObjetoController := TContabilIndiceController.Create;

  inherited;
end;

procedure TFContabilIndice.LimparCampos;
begin
  inherited;
  CDSContabilIndiceValor.EmptyDataSet;
end;

procedure TFContabilIndice.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;

  if StatusTela = stNavegandoEdits then
  begin
    PanelMestre.Enabled := False;
    PanelItens.Enabled := False;
  end
  else
  begin
    PanelMestre.Enabled := True;
    PanelItens.Enabled := True;
  end;
end;

procedure TFContabilIndice.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFContabilIndice.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFContabilIndice.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdIndiceEconomico.SetFocus;
  end;
end;

function TFContabilIndice.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdIndiceEconomico.SetFocus;
  end;
end;

function TFContabilIndice.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TContabilIndiceController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TContabilIndiceController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFContabilIndice.DoSalvar: Boolean;
var
  ContabilIndiceValor: TContabilIndiceValorVO;
begin
  DecimalSeparator := '.';
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TContabilIndiceVO.Create;

      TContabilIndiceVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TContabilIndiceVO(ObjetoVO).IdIndiceEconomico := EditIdIndiceEconomico.AsInteger;
      TContabilIndiceVO(ObjetoVO).Periodicidade := IfThen(ComboBoxPeriodicidade.ItemIndex = 0, 'D', 'M');
      TContabilIndiceVO(ObjetoVO).MensalMesAno := EditMensalMesAno.Text;
      TContabilIndiceVO(ObjetoVO).DiarioAPartirDe := EditDiarioAPartirDe.Date;

      // Valores
      TContabilIndiceVO(ObjetoVO).ListaContabilIndiceValorVO := TObjectList<TContabilIndiceValorVO>.Create;
      CDSContabilIndiceValor.DisableControls;
      CDSContabilIndiceValor.First;
      while not CDSContabilIndiceValor.Eof do
      begin
        ContabilIndiceValor := TContabilIndiceValorVO.Create;
        ContabilIndiceValor.Id := CDSContabilIndiceValorID.AsInteger;
        ContabilIndiceValor.IdContabilIndice := TContabilIndiceVO(ObjetoVO).Id;
        ContabilIndiceValor.DataIndice := CDSContabilIndiceValorDATA_INDICE.AsDateTime;
        ContabilIndiceValor.Valor := CDSContabilIndiceValorVALOR.AsFloat;
        TContabilIndiceVO(ObjetoVO).ListaContabilIndiceValorVO.Add(ContabilIndiceValor);
        CDSContabilIndiceValor.Next;
      end;
      CDSContabilIndiceValor.EnableControls;

      TContabilIndiceVO(ObjetoVO).IndiceEconomicoVO := Nil;
      if Assigned(ObjetoOldVO) then
      begin
        TContabilIndiceVO(ObjetoOldVO).IndiceEconomicoVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TContabilIndiceController(ObjetoController).Insere(TContabilIndiceVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TContabilIndiceVO(ObjetoVO).ToJSONString <> TContabilIndiceVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TContabilIndiceController(ObjetoController).Altera(TContabilIndiceVO(ObjetoVO), TContabilIndiceVO(ObjetoOldVO));
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
procedure TFContabilIndice.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;

procedure TFContabilIndice.GridParaEdits;
var
  ContabilIndiceValorEnumerator: TEnumerator<TContabilIndiceValorVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TContabilIndiceVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TContabilIndiceVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdIndiceEconomico.AsInteger := TContabilIndiceVO(ObjetoVO).IdIndiceEconomico;
    EditIndiceEconomico.Text := TContabilIndiceVO(ObjetoVO).IndiceEconomicoSigla;
    ComboBoxPeriodicidade.ItemIndex := StrToInt(IfThen(TContabilIndiceVO(ObjetoVO).Periodicidade = 'D', '0', '1'));
    EditMensalMesAno.Text := TContabilIndiceVO(ObjetoVO).MensalMesAno;
    EditDiarioAPartirDe.Date := TContabilIndiceVO(ObjetoVO).DiarioAPartirDe;

    // Valores
    ContabilIndiceValorEnumerator := TContabilIndiceVO(ObjetoVO).ListaContabilIndiceValorVO.GetEnumerator;
    try
      with ContabilIndiceValorEnumerator do
      begin
        while MoveNext do
        begin
          CDSContabilIndiceValor.Append;
          CDSContabilIndiceValorID.AsInteger := Current.id;
          CDSContabilIndiceValorID_CONTABIL_INDICE.AsInteger := Current.IdContabilIndice;
          CDSContabilIndiceValorDATA_INDICE.AsDateTime := Current.DataIndice;
          CDSContabilIndiceValorVALOR.AsFloat := Current.Valor;
          CDSContabilIndiceValor.Post;
        end;
      end;
    finally
      ContabilIndiceValorEnumerator.Free;
    end;

    TContabilIndiceVO(ObjetoVO).ListaContabilIndiceValorVO := Nil;
    if Assigned(TContabilIndiceVO(ObjetoOldVO)) then
      TContabilIndiceVO(ObjetoOldVO).ListaContabilIndiceValorVO := Nil;
  end;

  ConfigurarLayoutTela;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFContabilIndice.EditIdIndiceEconomicoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdIndiceEconomico.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdIndiceEconomico.Text;
      EditIdIndiceEconomico.Clear;
      EditIndiceEconomico.Clear;
      if not PopulaCamposTransientes(Filtro, TIndiceEconomicoVO, TIndiceEconomicoController) then
        PopulaCamposTransientesLookup(TIndiceEconomicoVO, TIndiceEconomicoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdIndiceEconomico.Text := CDSTransiente.FieldByName('ID').AsString;
        EditIndiceEconomico.Text := CDSTransiente.FieldByName('SIGLA').AsString;
      end
      else
      begin
        Exit;
        EditIdIndiceEconomico.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIndiceEconomico.Clear;
  end;
end;

procedure TFContabilIndice.EditIdIndiceEconomicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdIndiceEconomico.Value := -1;
    ComboBoxPeriodicidade.SetFocus;
  end;
end;

procedure TFContabilIndice.EditIdIndiceEconomicoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ComboBoxPeriodicidade.SetFocus;
  end;
end;

{$ENDREGION}

end.
