{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Contador

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
unit UContador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ContadorVO,
  ContadorController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, UfController, UfVO;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Contador')]

  TFContador = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditPessoa: TLabeledEdit;
    EditComplemento: TLabeledEdit;
    EditUFCRC: TLabeledEdit;
    EditInscricaoCRC: TLabeledEdit;
    EditLogradouro: TLabeledEdit;
    EditNumero: TLabeledEdit;
    EditBairro: TLabeledEdit;
    EditMunicipioIbge: TLabeledEdit;
    EditUf: TLabeledEdit;
    EditFone1: TLabeledMaskEdit;
    EditEmail: TLabeledEdit;
    EditFax: TLabeledMaskEdit;
    EditCep: TLabeledMaskEdit;
    EditIdPessoa: TLabeledCalcEdit;
    procedure EditIdPessoaExit(Sender: TObject);
    procedure EditIdPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdPessoaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
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
  FContador: TFContador;

implementation

uses ULookup, Biblioteca, UDataModule, PessoaVO, PessoaController, ContabilContaVO, ContabilContaController,
  MunicipioController, MunicipioVO;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFContador.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContadorVO;
  ObjetoController := TContadorController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFContador.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdPessoa.SetFocus;
  end;
end;

function TFContador.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdPessoa.SetFocus;
  end;
end;

function TFContador.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TContadorController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TContadorController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFContador.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TContadorVO.Create;

      TContadorVO(ObjetoVO).IdPessoa := StrToInt(EditIdPessoa.Text);
      TContadorVO(ObjetoVO).PessoaNome := EditPessoa.Text;
      TContadorVO(ObjetoVO).InscricaoCrc := EditInscricaoCRC.Text;
      TContadorVO(ObjetoVO).UfCrc := EditUFCRC.Text;
      TContadorVO(ObjetoVO).Logradouro := EditLogradouro.Text;
      TContadorVO(ObjetoVO).Cep := EditCep.Text;
      TContadorVO(ObjetoVO).Complemento := EditComplemento.Text;
      TContadorVO(ObjetoVO).Numero := EditNumero.Text;
      TContadorVO(ObjetoVO).Bairro := EditBairro.Text;
      TContadorVO(ObjetoVO).MunicipioIbge := StrToInt(EditMunicipioIbge.Text);
      TContadorVO(ObjetoVO).Uf := EditUf.Text;
      TContadorVO(ObjetoVO).Fone := EditFone1.Text;
      TContadorVO(ObjetoVO).Fax := EditFax.Text;
      TContadorVO(ObjetoVO).Email := EditEmail.Text;

      if StatusTela = stInserindo then
        Result := TContadorController(ObjetoController).Insere(TContadorVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TContadorVO(ObjetoVO).ToJSONString <> TContadorVO(ObjetoOldVO).ToJSONString then
        begin
          TContadorVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TContadorController(ObjetoController).Altera(TContadorVO(ObjetoVO), TContadorVO(ObjetoOldVO));
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

{$REGION 'Controle de Grid'}
procedure TFContador.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TContadorVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdPessoa.Text := IntToStr(TContadorVO(ObjetoVO).IdPessoa);
    EditPessoa.Text := TContadorVO(ObjetoVO).PessoaNome;
    EditInscricaoCRC.Text := TContadorVO(ObjetoVO).InscricaoCrc;
    EditUFCRC.Text := TContadorVO(ObjetoVO).UfCrc;
    EditLogradouro.Text := TContadorVO(ObjetoVO).Logradouro;
    EditCep.Text := TContadorVO(ObjetoVO).Cep;
    EditComplemento.Text := TContadorVO(ObjetoVO).Complemento;
    EditNumero.Text := TContadorVO(ObjetoVO).Numero;
    EditBairro.Text := TContadorVO(ObjetoVO).Bairro;
    EditMunicipioIbge.Text := IntToStr(TContadorVO(ObjetoVO).MunicipioIbge);
    EditUf.Text := TContadorVO(ObjetoVO).Uf;
    EditFone1.Text := TContadorVO(ObjetoVO).Fone;
    EditFax.Text := TContadorVO(ObjetoVO).Fax;
    EditEmail.Text := TContadorVO(ObjetoVO).Email;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFContador.EditIdPessoaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdPessoa.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdPessoa.Text;
      EditIdPessoa.Clear;
      EditPessoa.Clear;
      if not PopulaCamposTransientes(Filtro, TPessoaVO, TPessoaController) then
        PopulaCamposTransientesLookup(TPessoaVO, TPessoaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdPessoa.Text := CDSTransiente.FieldByName('ID').AsString;
        EditPessoa.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdPessoa.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditPessoa.Clear;
  end;
end;

procedure TFContador.EditIdPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdPessoa.Value := -1;
    EditInscricaoCRC.SetFocus;
  end;
end;

procedure TFContador.EditIdPessoaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditInscricaoCRC.SetFocus;
  end;
end;
{$ENDREGION}

end.
