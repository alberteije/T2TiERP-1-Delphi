{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Agência Bancária

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

@author Fernando L Oliveira
@version 1.0   |   Fernando  @version 1.0.0.10
*******************************************************************************}
unit UAgenciaBanco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, AgenciaBancoVO,
  AgenciaBancoController, Tipos, Atributos, Constantes, LabeledCtrls, Mask,
  JvExMask, JvToolEdit, JvBaseEdits;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Agência Bancária')]
  TFAgenciaBanco = class(TFTelaCadastro)
    EditCodigo: TLabeledEdit;
    EditBanco: TLabeledEdit;
    EditNome: TLabeledEdit;
    EditLogradouro: TLabeledEdit;
    EditNumero: TLabeledEdit;
    EditBairro: TLabeledEdit;
    EditMunicipio: TLabeledEdit;
    EditUf: TLabeledEdit;
    EditGerente: TLabeledEdit;
    EditContato: TLabeledEdit;
    EditCEP: TLabeledMaskEdit;
    EditTelefone: TLabeledMaskEdit;
    BevelEdits: TBevel;
    MemoObservacao: TLabeledMemo;
    EditIdBanco: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditIdBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdBancoExit(Sender: TObject);
    procedure EditIdBancoKeyPress(Sender: TObject; var Key: Char);
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
  FAgenciaBanco: TFAgenciaBanco;

implementation

uses ULookup, BancoController, BancoVO, Biblioteca;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFAgenciaBanco.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TAgenciaBancoVO;
  ObjetoController := TAgenciaBancoController.Create;
  inherited;
end;

procedure TFAgenciaBanco.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(ComboBoxCampos) then
    ComboBoxCampos.ItemIndex := 3;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFAgenciaBanco.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditCodigo.SetFocus;
  end;
end;

function TFAgenciaBanco.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditCodigo.SetFocus;
  end;
end;

function TFAgenciaBanco.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TAgenciaBancoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TAgenciaBancoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFAgenciaBanco.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TAgenciaBancoVO.Create;

      TAgenciaBancoVO(ObjetoVO).Codigo := EditCodigo.Text;
      TAgenciaBancoVO(ObjetoVO).IdBanco := StrToInt(EditIdBanco.Text);
      TAgenciaBancoVO(ObjetoVO).BancoNome := EditBanco.Text;
      TAgenciaBancoVO(ObjetoVO).Nome := EditNome.Text;
      TAgenciaBancoVO(ObjetoVO).Logradouro := EditLogradouro.Text;
      TAgenciaBancoVO(ObjetoVO).Numero := EditNumero.Text;
      TAgenciaBancoVO(ObjetoVO).Bairro := EditBairro.Text;
      TAgenciaBancoVO(ObjetoVO).Cep := EditCEP.Text;
      TAgenciaBancoVO(ObjetoVO).Municipio := EditMunicipio.Text;
      TAgenciaBancoVO(ObjetoVO).Uf := EditUf.Text;
      TAgenciaBancoVO(ObjetoVO).Telefone := EditTelefone.Text;
      TAgenciaBancoVO(ObjetoVO).Contato := EditContato.Text;
      TAgenciaBancoVO(ObjetoVO).Gerente := EditGerente.Text;
      TAgenciaBancoVO(ObjetoVO).Observacao := MemoObservacao.Text;

      TAgenciaBancoVO(ObjetoVO).BancoVO := Nil;
      if Assigned(ObjetoOldVO) then
      begin
        TAgenciaBancoVO(ObjetoOldVO).BancoVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TAgenciaBancoController(ObjetoController).Insere(TAgenciaBancoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TAgenciaBancoVO(ObjetoVO).ToJSONString <> TAgenciaBancoVO(ObjetoOldVO).ToJSONString then
        begin
          TAgenciaBancoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TAgenciaBancoController(ObjetoController).Altera(TAgenciaBancoVO(ObjetoVO), TAgenciaBancoVO(ObjetoOldVO));
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

{$REGION 'Controles de Grid'}
procedure TFAgenciaBanco.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TAgenciaBancoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCodigo.Text := TAgenciaBancoVO(ObjetoVO).Codigo;
    EditIdBanco.Text := IntToStr(TAgenciaBancoVO(ObjetoVO).IdBanco);
    EditBanco.Text := TAgenciaBancoVO(ObjetoVO).BancoNome;
    EditNome.Text := TAgenciaBancoVO(ObjetoVO).Nome;
    EditLogradouro.Text := TAgenciaBancoVO(ObjetoVO).Logradouro;
    EditNumero.Text := TAgenciaBancoVO(ObjetoVO).Numero;
    EditBairro.Text := TAgenciaBancoVO(ObjetoVO).Bairro;
    EditCEP.Text := TAgenciaBancoVO(ObjetoVO).Cep;
    EditMunicipio.Text := TAgenciaBancoVO(ObjetoVO).Municipio;
    EditUf.Text := TAgenciaBancoVO(ObjetoVO).Uf;
    EditTelefone.Text := TAgenciaBancoVO(ObjetoVO).Telefone;
    EditContato.Text := TAgenciaBancoVO(ObjetoVO).Contato;
    EditGerente.Text := TAgenciaBancoVO(ObjetoVO).Gerente;
    MemoObservacao.Text := TAgenciaBancoVO(ObjetoVO).Observacao;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFAgenciaBanco.EditIdBancoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdBanco.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdBanco.Text;
      EditIdBanco.Clear;
      EditBanco.Clear;
      if not PopulaCamposTransientes(Filtro, TBancoVO, TBancoController) then
        PopulaCamposTransientesLookup(TBancoVO, TBancoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdBanco.Text := CDSTransiente.FieldByName('ID').AsString;
        EditBanco.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdBanco.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditBanco.Clear;
  end;
end;

procedure TFAgenciaBanco.EditIdBancoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdBanco.Value := -1;
    EditNome.SetFocus;
  end;
end;

procedure TFAgenciaBanco.EditIdBancoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditNome.SetFocus;
  end;
end;
{$ENDREGION}

end.