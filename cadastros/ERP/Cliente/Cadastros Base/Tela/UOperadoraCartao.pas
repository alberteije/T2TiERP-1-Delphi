{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de OperadoraCartao

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

  t2ti.com@gmail.com | fernandololiver@gmail.com
  @author Albert Eije (T2Ti.COM) | Fernando L Oliveira
  @version 1.0
  ******************************************************************************* }
unit UOperadoraCartao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, OperadoraCartaoVO,
  OperadoraCartaoController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Operadora de Cart�o')]

  TFOperadoraCartao = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditContaCaixa: TLabeledEdit;
    EditContabilConta: TLabeledEdit;
    EditBandeira: TLabeledEdit;
    EditNome: TLabeledEdit;
    EditFone1: TLabeledMaskEdit;
    EditFone2: TLabeledMaskEdit;
    EditTaxaAdm: TLabeledCalcEdit;
    EditTaxaAdmDebito: TLabeledCalcEdit;
    EditValorAluguelPosPin: TLabeledCalcEdit;
    EditVencimentoAluguel: TLabeledCalcEdit;
    EditIdContaCaixa: TLabeledCalcEdit;
    EditIdContabilConta: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdContaCaixaExit(Sender: TObject);
    procedure EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContabilContaExit(Sender: TObject);
    procedure EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
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
  FOperadoraCartao: TFOperadoraCartao;

implementation

uses ULookup, Biblioteca, UDataModule, ContaCaixaVO, ContaCaixaController, ContabilContaVO, ContabilContaController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFOperadoraCartao.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TOperadoraCartaoVO;
  ObjetoController := TOperadoraCartaoController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFOperadoraCartao.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdContaCaixa.SetFocus;
  end;
end;

function TFOperadoraCartao.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdContaCaixa.SetFocus;
  end;
end;

function TFOperadoraCartao.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TOperadoraCartaoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TOperadoraCartaoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFOperadoraCartao.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TOperadoraCartaoVO.Create;

      TOperadoraCartaoVO(ObjetoVO).IdContaCaixa := EditIdContaCaixa.AsInteger;
      TOperadoraCartaoVO(ObjetoVO).ContaCaixaNome := EditContaCaixa.Text;
      TOperadoraCartaoVO(ObjetoVO).IdContabilConta := EditIdContabilConta.AsInteger;
      TOperadoraCartaoVO(ObjetoVO).ContabilContaClassificacao := EditContabilConta.Text;
      TOperadoraCartaoVO(ObjetoVO).Bandeira := EditBandeira.Text;
      TOperadoraCartaoVO(ObjetoVO).Nome := EditNome.Text;
      TOperadoraCartaoVO(ObjetoVO).TaxaAdm := EditTaxaAdm.Value;
      TOperadoraCartaoVO(ObjetoVO).TaxaAdmDebito := EditTaxaAdmDebito.Value;
      TOperadoraCartaoVO(ObjetoVO).ValorAluguelPosPin := EditValorAluguelPosPin.Value;
      TOperadoraCartaoVO(ObjetoVO).VencimentoAluguel := EditVencimentoAluguel.AsInteger;
      TOperadoraCartaoVO(ObjetoVO).Fone1 := EditFone1.Text;
      TOperadoraCartaoVO(ObjetoVO).Fone2 := EditFone2.Text;

      // ObjetoVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
      TOperadoraCartaoVO(ObjetoVO).ContaCaixaVO := Nil;
      TOperadoraCartaoVO(ObjetoVO).ContabilContaVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TOperadoraCartaoVO(ObjetoOldVO).ContaCaixaVO := Nil;
        TOperadoraCartaoVO(ObjetoOldVO).ContabilContaVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TOperadoraCartaoController(ObjetoController).Insere(TOperadoraCartaoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TOperadoraCartaoVO(ObjetoVO).ToJSONString <> TOperadoraCartaoVO(ObjetoOldVO).ToJSONString then
        begin
          TOperadoraCartaoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TOperadoraCartaoController(ObjetoController).Altera(TOperadoraCartaoVO(ObjetoVO), TOperadoraCartaoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFOperadoraCartao.EditIdContaCaixaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdContaCaixa.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdContaCaixa.Text;
      EditIdContaCaixa.Clear;
      EditContaCaixa.Clear;
      if not PopulaCamposTransientes(Filtro, TContaCaixaVO, TContaCaixaController) then
        PopulaCamposTransientesLookup(TContaCaixaVO, TContaCaixaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdContaCaixa.Text := CDSTransiente.FieldByName('ID').AsString;
        EditContaCaixa.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdContaCaixa.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContaCaixa.Clear;
  end;
end;

procedure TFOperadoraCartao.EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContaCaixa.Value := -1;
    EditIdContabilConta.SetFocus;
  end;
end;

procedure TFOperadoraCartao.EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdContabilConta.SetFocus;
  end;
end;

procedure TFOperadoraCartao.EditIdContabilContaExit(Sender: TObject);
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
        EditContabilConta.Text := CDSTransiente.FieldByName('CLASSIFICACAO').AsString;
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

procedure TFOperadoraCartao.EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContabilConta.Value := -1;
    EditBandeira.SetFocus;
  end;
end;

procedure TFOperadoraCartao.EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditBandeira.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFOperadoraCartao.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TOperadoraCartaoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdContaCaixa.AsInteger := TOperadoraCartaoVO(ObjetoVO).IdContaCaixa;
    EditContaCaixa.Text := TOperadoraCartaoVO(ObjetoVO).ContaCaixaNome;
    EditIdContabilConta.AsInteger := TOperadoraCartaoVO(ObjetoVO).IdContabilConta;
    EditContabilConta.Text := TOperadoraCartaoVO(ObjetoVO).ContabilContaClassificacao;
    EditBandeira.Text := TOperadoraCartaoVO(ObjetoVO).Bandeira;
    EditNome.Text := TOperadoraCartaoVO(ObjetoVO).Nome;
    EditTaxaAdm.Value := TOperadoraCartaoVO(ObjetoVO).TaxaAdm;
    EditTaxaAdmDebito.Value := TOperadoraCartaoVO(ObjetoVO).TaxaAdmDebito;
    EditValorAluguelPosPin.Value := TOperadoraCartaoVO(ObjetoVO).ValorAluguelPosPin;
    EditVencimentoAluguel.AsInteger := TOperadoraCartaoVO(ObjetoVO).VencimentoAluguel;
    EditFone1.Text := TOperadoraCartaoVO(ObjetoVO).Fone1;
    EditFone2.Text := TOperadoraCartaoVO(ObjetoVO).Fone2;
  end;
end;
{$ENDREGION}

end.
