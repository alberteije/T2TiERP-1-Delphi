{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Bancos

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

  @author Sérgio
  @version 1.0   |   Fernando  @version 1.0.0.10
  ******************************************************************************* }
unit UCargo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, CargoVO,
  CargoController, Tipos, Atributos, Constantes, LabeledCtrls, Mask, JvExMask,
  JvToolEdit, JvMaskEdit, JvExStdCtrls, JvEdit, JvValidateEdit, JvBaseEdits;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Cargo')]

  TFCargo = class(TFTelaCadastro)
    EditNome: TLabeledEdit;
    EditCbo1994: TLabeledEdit;
    BevelEdits: TBevel;
    MemoDescricao: TLabeledMemo;
    EditCbo2002: TLabeledEdit;
    EditSalario: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditCbo1994Exit(Sender: TObject);
    procedure EditCbo1994KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditCbo2002Exit(Sender: TObject);
    procedure EditCbo2002KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
  FCargo: TFCargo;

implementation

uses ULookup, Biblioteca, UDataModule, CboVO, CboController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFCargo.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TCargoVO;
  ObjetoController := TCargoController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFCargo.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFCargo.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFCargo.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TCargoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TCargoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFCargo.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      ObjetoVO := TCargoVO.Create;

      TCargoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TCargoVO(ObjetoVO).Nome := EditNome.Text;
      TCargoVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TCargoVO(ObjetoVO).Salario := EditSalario.Value;
      TCargoVO(ObjetoVO).Cbo1994 := EditCbo1994.Text;
      TCargoVO(ObjetoVO).Cbo2002 := EditCbo2002.Text;

      if StatusTela = stInserindo then
        Result := TCargoController(ObjetoController).Insere(TCargoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TCargoVO(ObjetoVO).ToJSONString <> TCargoVO(ObjetoOldVO).ToJSONString then
        begin
          TCargoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TCargoController(ObjetoController).Altera(TCargoVO(ObjetoVO), TCargoVO(ObjetoOldVO));
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
procedure TFCargo.EditCbo1994Exit(Sender: TObject);
var
  Filtro: String;
begin
  if EditCbo1994.Text <> '' then
  begin
    try
      Filtro := 'CODIGO_1994 = ' + QuotedStr(EditCbo1994.Text);
      EditCbo1994.Clear;
      if not PopulaCamposTransientes(Filtro, TCboVO, TCboController) then
        PopulaCamposTransientesLookup(TCboVO, TCboController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditCbo1994.Text := CDSTransiente.FieldByName('CODIGO_1994').AsString;
      end
      else
      begin
        Exit;
        EditCbo1994.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCbo1994.Clear;
  end;
end;

procedure TFCargo.EditCbo1994KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditCbo1994.Text := '-';
    EditCbo1994.OnExit(Sender);
    EditCbo2002.SetFocus;
  end;
  if Key = VK_RETURN then
    EditCbo2002.SetFocus;
end;

procedure TFCargo.EditCbo2002Exit(Sender: TObject);
var
  Filtro: String;
begin
  if EditCbo2002.Text <> '' then
  begin
    try
      Filtro := 'CODIGO = ' + QuotedStr(EditCbo2002.Text);
      EditCbo2002.Clear;
      if not PopulaCamposTransientes(Filtro, TCboVO, TCboController) then
        PopulaCamposTransientesLookup(TCboVO, TCboController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditCbo2002.Text := CDSTransiente.FieldByName('CODIGO').AsString;
      end
      else
      begin
        Exit;
        EditCbo2002.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCbo2002.Clear;
  end;
end;

procedure TFCargo.EditCbo2002KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditCbo2002.Text := '-';
    EditCbo2002.OnExit(Sender);
    EditNome.SetFocus;
  end;
  if Key = VK_RETURN then
    EditNome.SetFocus;
end;

{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFCargo.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TCargoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditNome.Text := TCargoVO(ObjetoVO).Nome;
    MemoDescricao.Text := TCargoVO(ObjetoVO).Descricao;
    EditSalario.Value := TCargoVO(ObjetoVO).Salario;
    EditCbo1994.Text := TCargoVO(ObjetoVO).Cbo1994;
    EditCbo2002.Text := TCargoVO(ObjetoVO).Cbo2002;
  end;
end;
{$ENDREGION}

end.
