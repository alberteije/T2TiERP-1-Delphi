{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Quadro Societário

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

@author Albert Eije (t2ti.com@gmail.com)
@version 1.0
*******************************************************************************}
unit UQuadroSocietario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, QuadroSocietarioVO,
  QuadroSocietarioController, Tipos, Atributos, Constantes,
  LabeledCtrls, Mask, JvExMask, JvToolEdit, JvBaseEdits, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_ADMINISTRATIVO, 'QuadroSocietario')]

  TFQuadroSocietario = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditDataRegistro: TLabeledDateEdit;
    EditCapitalSocial: TLabeledCalcEdit;
    EditValorQuota: TLabeledCalcEdit;
    EditQuantidadeQuota: TLabeledCalcEdit;
    EditIdEmpresa: TLabeledCalcEdit;
    EditEmpresa: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdEmpresaExit(Sender: TObject);
    procedure EditIdEmpresaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdEmpresaKeyPress(Sender: TObject; var Key: Char);

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
  FQuadroSocietario: TFQuadroSocietario;

implementation

uses ULookup, EmpresaVO, EmpresaController, Biblioteca, UDataModule,
  SessaoUsuario;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFQuadroSocietario.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TQuadroSocietarioVO;
  ObjetoController := TQuadroSocietarioController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFQuadroSocietario.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdEmpresa.SetFocus;
  end;
end;

function TFQuadroSocietario.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdEmpresa.SetFocus;
  end;
end;

function TFQuadroSocietario.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TQuadroSocietarioController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TQuadroSocietarioController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFQuadroSocietario.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TQuadroSocietarioVO.Create;

      TQuadroSocietarioVO(ObjetoVO).IdEmpresa := EditIdEmpresa.AsInteger;
      TQuadroSocietarioVO(ObjetoVO).RazaoSocial := EditEmpresa.Text;
      TQuadroSocietarioVO(ObjetoVO).DataRegistro := EditDataRegistro.Date;
      TQuadroSocietarioVO(ObjetoVO).CapitalSocial := EditCapitalSocial.Value;
      TQuadroSocietarioVO(ObjetoVO).ValorQuota := EditValorQuota.Value;
      TQuadroSocietarioVO(ObjetoVO).QuantidadeCotas := EditQuantidadeQuota.AsInteger;

      if StatusTela = stInserindo then
        Result := TQuadroSocietarioController(ObjetoController).Insere(TQuadroSocietarioVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TQuadroSocietarioVO(ObjetoVO).ToJSONString <> TQuadroSocietarioVO(ObjetoOldVO).ToJSONString then
        begin
          TQuadroSocietarioVO(ObjetoVO).ID := IdRegistroSelecionado;
          Result := TQuadroSocietarioController(ObjetoController).Altera(TQuadroSocietarioVO(ObjetoVO), TQuadroSocietarioVO(ObjetoOldVO));
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

{$REGION 'Campos transientes'}
procedure TFQuadroSocietario.EditIdEmpresaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdEmpresa.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdEmpresa.Text;
      EditIdEmpresa.Clear;
      EditEmpresa.Clear;
      if not PopulaCamposTransientes(Filtro, TEmpresaVO, TEmpresaController) then
        PopulaCamposTransientesLookup(TEmpresaVO, TEmpresaController);

      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdEmpresa.Text := CDSTransiente.FieldByName('ID').AsString;
        EditEmpresa.Text := CDSTransiente.FieldByName('RAZAO_SOCIAL').AsString;
      end
      else
      begin
        Exit;
        EditIdEmpresa.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditEmpresa.Clear;
  end;
end;

procedure TFQuadroSocietario.EditIdEmpresaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdEmpresa.Value := -1;
    EditDataRegistro.SetFocus;
  end;
end;

procedure TFQuadroSocietario.EditIdEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDataRegistro.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de GRID'}
procedure TFQuadroSocietario.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TQuadroSocietarioVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdEmpresa.AsInteger := TQuadroSocietarioVO(ObjetoVO).IdEmpresa;
    EditEmpresa.Text := TQuadroSocietarioVO(ObjetoVO).RazaoSocial;
    EditDataRegistro.Date := TQuadroSocietarioVO(ObjetoVO).DataRegistro;
    EditCapitalSocial.Value := TQuadroSocietarioVO(ObjetoVO).CapitalSocial;
    EditValorQuota.Value := TQuadroSocietarioVO(ObjetoVO).ValorQuota;
    EditQuantidadeQuota.AsInteger := TQuadroSocietarioVO(ObjetoVO).QuantidadeCotas;
  end;
end;
{$ENDREGION}

end.
