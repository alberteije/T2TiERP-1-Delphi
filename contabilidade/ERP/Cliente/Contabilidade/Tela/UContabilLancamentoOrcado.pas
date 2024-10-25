{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Lan�amento Or�ado para o m�dulo Contabilidade

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
unit UContabilLancamentoOrcado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ContabilLancamentoOrcadoVO,
  ContabilLancamentoOrcadoController, Tipos, Atributos, Constantes, LabeledCtrls, Mask,
  JvExMask, JvToolEdit, JvBaseEdits, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_CONTABILIDADE, 'Lan�amento Or�ado')]

  TFContabilLancamentoOrcado = class(TFTelaCadastro)
    BevelEdits: TBevel;
    PageControlItens: TPageControl;
    tsMeses: TTabSheet;
    PanelContas: TPanel;
    GridMeses: TJvDBUltimGrid;
    CDSMeses: TClientDataSet;
    DSMeses: TDataSource;
    EditIdContabilConta: TLabeledCalcEdit;
    EditContabilConta: TLabeledEdit;
    EditAno: TLabeledMaskEdit;
    CDSMesesMES: TStringField;
    CDSMesesVALOR: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure CDSMesesAfterPost(DataSet: TDataSet);
    procedure EditIdContabilContaExit(Sender: TObject);
    procedure EditIdContabilContaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure PopularGridMeses;
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
  FContabilLancamentoOrcado: TFContabilLancamentoOrcado;

implementation

uses ContabilContaVO, ContabilContaController;

{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFContabilLancamentoOrcado.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContabilLancamentoOrcadoVO;
  ObjetoController := TContabilLancamentoOrcadoController.Create;

  inherited;
end;

procedure TFContabilLancamentoOrcado.LimparCampos;
begin
  inherited;
  CDSMeses.EmptyDataSet;
end;

procedure TFContabilLancamentoOrcado.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFContabilLancamentoOrcado.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFContabilLancamentoOrcado.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    PopularGridMeses;
    EditIdContabilConta.SetFocus;
  end;
end;

function TFContabilLancamentoOrcado.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    PopularGridMeses;
    EditIdContabilConta.SetFocus;
  end;
end;

function TFContabilLancamentoOrcado.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TContabilLancamentoOrcadoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TContabilLancamentoOrcadoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFContabilLancamentoOrcado.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    DecimalSeparator := '.';
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TContabilLancamentoOrcadoVO.Create;

      TContabilLancamentoOrcadoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TContabilLancamentoOrcadoVO(ObjetoVO).IdContabilConta := EditIdContabilConta.AsInteger;
      TContabilLancamentoOrcadoVO(ObjetoVO).ContabilConta := EditContabilConta.Text;
      TContabilLancamentoOrcadoVO(ObjetoVO).Ano := EditAno.Text;

      // Meses
      CDSMeses.DisableControls;
      CDSMeses.First;
      while not CDSMeses.Eof do
      begin
        TContabilLancamentoOrcadoVO(ObjetoVO).Janeiro := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Fevereiro := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Marco := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Abril := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Maio := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Junho := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Julho := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Agosto := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Setembro := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Outubro := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Novembro := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
        TContabilLancamentoOrcadoVO(ObjetoVO).Dezembro := CDSMesesVALOR.AsExtended;
        CDSMeses.Next;
      end;
      CDSMeses.First;
      CDSMeses.EnableControls;

      if StatusTela = stInserindo then
        Result := TContabilLancamentoOrcadoController(ObjetoController).Insere(TContabilLancamentoOrcadoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TContabilLancamentoOrcadoVO(ObjetoVO).ToJSONString <> TContabilLancamentoOrcadoVO(ObjetoOldVO).ToJSONString then
        begin
          TContabilLancamentoOrcadoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TContabilLancamentoOrcadoController(ObjetoController).Altera(TContabilLancamentoOrcadoVO(ObjetoVO), TContabilLancamentoOrcadoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
    DecimalSeparator := ',';
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFContabilLancamentoOrcado.EditIdContabilContaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdContabilConta.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdContabilConta.Text;
      EditIdContabilConta.Clear;
      EditContabilConta.Clear;
      if not PopulaCamposTransientes(Filtro, TContabilContaVO, TContabilContaController) then
        PopulaCamposTransientesLookup(TContabilContaVO, TContabilContaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdContabilConta.Text := CDSTransiente.FieldByName('ID').AsString;
        EditContabilConta.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditIdContabilConta.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContabilConta.Clear;
  end;
end;

procedure TFContabilLancamentoOrcado.EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContabilConta.Value := -1;
    EditAno.SetFocus;
  end;
end;

procedure TFContabilLancamentoOrcado.EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditAno.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFContabilLancamentoOrcado.GridDblClick(Sender: TObject);
begin
  inherited;
  PopularGridMeses;
end;

procedure TFContabilLancamentoOrcado.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TContabilLancamentoOrcadoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TContabilLancamentoOrcadoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdContabilConta.AsInteger := TContabilLancamentoOrcadoVO(ObjetoVO).IdContabilConta;
    EditContabilConta.Text := TContabilLancamentoOrcadoVO(ObjetoVO).ContabilConta;
    EditAno.Text := TContabilLancamentoOrcadoVO(ObjetoVO).Ano;
  end;
end;

procedure TFContabilLancamentoOrcado.PopularGridMeses;
var
  i: Integer;
begin
  for i := 1 to 12 do
  begin
    CDSMeses.Append;
    case i of
      1:
        begin
          CDSMesesMES.AsString := 'Janeiro';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Janeiro;
          end;
        end;
      2:
        begin
          CDSMesesMES.AsString := 'Fevereiro';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Fevereiro;
          end;
        end;
      3:
        begin
          CDSMesesMES.AsString := 'Mar�o';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Marco;
          end;
        end;
      4:
        begin
          CDSMesesMES.AsString := 'Abril';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Abril;
          end;
        end;
      5:
        begin
          CDSMesesMES.AsString := 'Maio';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Maio;
          end;
        end;
      6:
        begin
          CDSMesesMES.AsString := 'Junho';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Junho;
          end;
        end;
      7:
        begin
          CDSMesesMES.AsString := 'Julho';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Julho;
          end;
        end;
      8:
        begin
          CDSMesesMES.AsString := 'Agosto';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Agosto;
          end;
        end;
      9:
        begin
          CDSMesesMES.AsString := 'Setembro';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Setembro;
          end;
        end;
      10:
        begin
          CDSMesesMES.AsString := 'Outubro';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Outubro;
          end;
        end;
      11:
        begin
          CDSMesesMES.AsString := 'Novembro';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Novembro;
          end;
        end;
      12:
        begin
          CDSMesesMES.AsString := 'Dezembro';
          if (StatusTela = stEditando) or (StatusTela = stNavegandoEdits) then
          begin
            CDSMesesVALOR.AsExtended := TContabilLancamentoOrcadoVO(ObjetoVO).Dezembro;
          end;
        end;
    end;
    CDSMeses.Post;
  end;
  CDSMeses.First;
end;

procedure TFContabilLancamentoOrcado.CDSMesesAfterPost(DataSet: TDataSet);
begin
  if CDSMesesMES.AsString = '' then
    CDSMeses.Delete;
end;
{$ENDREGION}

end.
