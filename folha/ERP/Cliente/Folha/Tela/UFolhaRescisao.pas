{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Rescis�o para o m�dulo Folha de Pagamento

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

  @author Albert Eije
  @version 1.0
  ******************************************************************************* }

unit UFolhaRescisao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FolhaRescisaoVO, 
  FolhaRescisaoController, Atributos, Constantes, LabeledCtrls, Mask, 
  JvExMask, JvToolEdit, JvBaseEdits, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_FOLHA_PAGAMENTO, 'Folha Rescis�o')]

  TFFolhaRescisao = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditIdColaborador: TLabeledCalcEdit;
    EditColaborador: TLabeledEdit;
    EditDataDemissao: TLabeledDateEdit;
    EditDataPagamento: TLabeledDateEdit;
    EditDiasAvisoPrevio: TLabeledCalcEdit;
    EditDataAvisoPrevio: TLabeledDateEdit;
    ComboBoxComprovouNovoEmprego: TLabeledComboBox;
    ComboBoxDispensouEmpregado: TLabeledComboBox;
    EditMotivo: TLabeledEdit;
    EditPensaoAlimenticia: TLabeledCalcEdit;
    EditPensaoAlimenticiaFgts: TLabeledCalcEdit;
    GroupBox2: TGroupBox;
    EditFgtsValorRescisao: TLabeledCalcEdit;
    EditFgtsSaldoBanco: TLabeledCalcEdit;
    EditFgtsComplementoSaldo: TLabeledCalcEdit;
    EditFgtsCodigoAfastamento: TLabeledEdit;
    EditFgtsCodigoSaque: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdColaboradorExit(Sender: TObject);
    procedure EditIdColaboradorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
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
  FFolhaRescisao: TFFolhaRescisao;

implementation

uses ColaboradorVO, ColaboradorController;

{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFFolhaRescisao.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFolhaRescisaoVO;
  ObjetoController := TFolhaRescisaoController.Create;

  inherited;
end;

procedure TFFolhaRescisao.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFFolhaRescisao.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFolhaRescisao.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaRescisao.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaRescisao.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFolhaRescisaoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFolhaRescisaoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFolhaRescisao.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      DecimalSeparator := '.';
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFolhaRescisaoVO.Create;

      TFolhaRescisaoVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TFolhaRescisaoVO(ObjetoVO).ColaboradorPessoaNome := EditColaborador.Text;
      TFolhaRescisaoVO(ObjetoVO).DataDemissao := EditDataDemissao.Date;
      TFolhaRescisaoVO(ObjetoVO).DataPagamento := EditDataPagamento.Date;
      TFolhaRescisaoVO(ObjetoVO).Motivo := EditMotivo.Text;
      TFolhaRescisaoVO(ObjetoVO).DataAvisoPrevio := EditDataAvisoPrevio.Date;
      TFolhaRescisaoVO(ObjetoVO).DiasAvisoPrevio := EditDiasAvisoPrevio.AsInteger;
      TFolhaRescisaoVO(ObjetoVO).ComprovouNovoEmprego := IfThen(ComboBoxComprovouNovoEmprego.ItemIndex = 0, 'S', 'N');
      TFolhaRescisaoVO(ObjetoVO).DispensouEmpregado := IfThen(ComboBoxDispensouEmpregado.ItemIndex = 0, 'S', 'N');
      TFolhaRescisaoVO(ObjetoVO).PensaoAlimenticia := EditPensaoAlimenticia.Value;
      TFolhaRescisaoVO(ObjetoVO).PensaoAlimenticiaFgts := EditPensaoAlimenticiaFgts.Value;
      TFolhaRescisaoVO(ObjetoVO).FgtsValorRescisao := EditFgtsValorRescisao.Value;
      TFolhaRescisaoVO(ObjetoVO).FgtsSaldoBanco := EditFgtsSaldoBanco.Value;
      TFolhaRescisaoVO(ObjetoVO).FgtsComplementoSaldo := EditFgtsComplementoSaldo.Value;
      TFolhaRescisaoVO(ObjetoVO).FgtsCodigoAfastamento := EditFgtsCodigoAfastamento.Text;
      TFolhaRescisaoVO(ObjetoVO).FgtsCodigoSaque := EditFgtsCodigoSaque.Text;

      if StatusTela = stInserindo then
        Result := TFolhaRescisaoController(ObjetoController).Insere(TFolhaRescisaoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFolhaRescisaoVO(ObjetoVO).ToJSONString <> TFolhaRescisaoVO(ObjetoOldVO).ToJSONString then
        begin
          TFolhaRescisaoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TFolhaRescisaoController(ObjetoController).Altera(TFolhaRescisaoVO(ObjetoVO), TFolhaRescisaoVO(ObjetoOldVO));
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
procedure TFFolhaRescisao.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFolhaRescisaoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFolhaRescisaoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdColaborador.AsInteger := TFolhaRescisaoVO(ObjetoVO).IdColaborador;
    EditColaborador.Text := TFolhaRescisaoVO(ObjetoVO).ColaboradorPessoaNome;
    EditDataDemissao.Date := TFolhaRescisaoVO(ObjetoVO).DataDemissao;
    EditDataPagamento.Date := TFolhaRescisaoVO(ObjetoVO).DataPagamento;
    EditMotivo.Text := TFolhaRescisaoVO(ObjetoVO).Motivo;
    EditDataAvisoPrevio.Date := TFolhaRescisaoVO(ObjetoVO).DataAvisoPrevio;
    EditDiasAvisoPrevio.AsInteger := TFolhaRescisaoVO(ObjetoVO).DiasAvisoPrevio;
    ComboBoxComprovouNovoEmprego.ItemIndex := AnsiIndexStr(TFolhaRescisaoVO(ObjetoVO).ComprovouNovoEmprego, ['S', 'N']);
    ComboBoxDispensouEmpregado.ItemIndex := AnsiIndexStr(TFolhaRescisaoVO(ObjetoVO).DispensouEmpregado, ['S', 'N']);
    EditPensaoAlimenticia.Value := TFolhaRescisaoVO(ObjetoVO).PensaoAlimenticia;
    EditPensaoAlimenticiaFgts.Value := TFolhaRescisaoVO(ObjetoVO).PensaoAlimenticiaFgts;
    EditFgtsValorRescisao.Value := TFolhaRescisaoVO(ObjetoVO).FgtsValorRescisao;
    EditFgtsSaldoBanco.Value := TFolhaRescisaoVO(ObjetoVO).FgtsSaldoBanco;
    EditFgtsComplementoSaldo.Value := TFolhaRescisaoVO(ObjetoVO).FgtsComplementoSaldo;
    EditFgtsCodigoAfastamento.Text := TFolhaRescisaoVO(ObjetoVO).FgtsCodigoAfastamento;
    EditFgtsCodigoSaque.Text := TFolhaRescisaoVO(ObjetoVO).FgtsCodigoSaque;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFolhaRescisao.EditIdColaboradorExit(Sender: TObject);
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

procedure TFFolhaRescisao.EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdColaborador.Value := -1;
    EditMotivo.SetFocus;
  end;
end;

procedure TFFolhaRescisao.EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditMotivo.SetFocus;
  end;
end;
{$ENDREGION}

end.
