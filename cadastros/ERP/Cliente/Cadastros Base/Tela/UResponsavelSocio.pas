{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Respons�vel S�cio

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

@author F�bio Thomaz (fabio_thz@yahoo.com.br)
@version 1.0   |   Fernando  @version 1.0.0.10
*******************************************************************************}
unit UResponsavelSocio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ResponsavelSocioVO,
  ResponsavelSocioController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits,Math,StrUtils, UfController, UfVO;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'ResponsavelSocio')]
  TFResponsavelSocio = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditIdPessoa: TLabeledEdit;
    EditPessoa: TLabeledEdit;
    EditComplemento: TLabeledEdit;
    EditPisNit: TLabeledEdit;
    EditLogradouro: TLabeledEdit;
    EditNumero: TLabeledEdit;
    EditBairro: TLabeledEdit;
    EditMunicipioIbge: TLabeledEdit;
    EditUf: TLabeledEdit;
    EditFone1: TLabeledMaskEdit;
    EditEmail: TLabeledEdit;
    EditFax: TLabeledMaskEdit;
    EditCep: TLabeledMaskEdit;
    EditIdContabilConta: TLabeledEdit;
    EditContabilConta: TLabeledEdit;
    procedure PopulaEditContabilConta(Sender: TObject);
    procedure PopulaUF(Sender: TObject);
    procedure ConsisteMunicipioIBGE(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditIdPessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdPessoaExit(Sender: TObject);
    procedure EditMunicipioIbgeExit(Sender: TObject);
    procedure EditMunicipioIbgeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdContabilContaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;

    //Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure PopulaEditPessoa(Sender: TObject);

  end;

var
  FResponsavelSocio: TFResponsavelSocio;

implementation

uses ULookup,  Biblioteca, UDataModule, PessoaVO, PessoaController, ContabilContaVO, ContabilContaController,
  MunicipioController, MunicipioVO;

{$R *.dfm}

procedure TFResponsavelSocio.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TResponsavelSocioVO;
  ObjetoController := TResponsavelSocioController.Create;

  inherited;
end;

procedure TFResponsavelSocio.FormShow(Sender: TObject);
begin
  inherited;

end;

{$REGION 'Controles CRUD'}
function TFResponsavelSocio.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdPessoa.SetFocus;
  end;
end;

procedure TFResponsavelSocio.ConsisteMunicipioIBGE(Sender: TObject);
var
  Filtro: String;
begin
  Filtro := 'CODIGO_IBGE = '+EditMunicipioIBGE.Text;

  ConfiguraCDSFromVO(FDataModule.CDSLookup, TMunicipioVO);

  TMunicipioController.SetDataSet(FDataModule.CDSLookup);
  TMunicipioController.Consulta(Filtro,0);
  try
    if (FDataModule.CDSLookup.FieldByName('ID').AsString <> '') then
    begin
      EditMunicipioIBGE.Text := FDataModule.CDSLookup.FieldByName('CODIGO_IBGE').AsString;
    end
    else
    begin
      EditMunicipioIBGE.SetFocus;
      keybd_event(VK_F1, 0, 0, 0);
    end;
  finally
    FDataModule.CDSLookup.Close;
  end;
end;

function TFResponsavelSocio.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdPessoa.SetFocus;
  end;
end;

function TFResponsavelSocio.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TResponsavelSocioController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TResponsavelSocioController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFResponsavelSocio.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TResponsavelSocioVO.Create;

      TResponsavelSocioVO(ObjetoVO).IdPessoa        := StrToInt(EditIdPessoa.Text);
      if (EditIdContabilConta.Text <> '') AND (EditIdContabilConta.Text <> '0') then
        TResponsavelSocioVO(ObjetoVO).IdContabilConta := StrToInt(EditIdContabilConta.Text);
      TResponsavelSocioVO(ObjetoVO).Logradouro      := EditLogradouro.Text;
      TResponsavelSocioVO(ObjetoVO).Cep             := EditCep.Text;
      TResponsavelSocioVO(ObjetoVO).Complemento     := EditComplemento.Text;
      TResponsavelSocioVO(ObjetoVO).Numero          := EditNumero.Text;
      TResponsavelSocioVO(ObjetoVO).Bairro          := EditBairro.Text;
      if (EditMunicipioIBGE.Text <> '') AND (EditMunicipioIBGE.Text <> '0') then
        TResponsavelSocioVO(ObjetoVO).MunicipioIbge   := StrToInt(EditMunicipioIbge.Text);
      TResponsavelSocioVO(ObjetoVO).Uf              := EditUf.Text;
      TResponsavelSocioVO(ObjetoVO).Fone            := EditFone1.Text;
      TResponsavelSocioVO(ObjetoVO).Fax             := EditFax.Text;
      TResponsavelSocioVO(ObjetoVO).Email           := EditEmail.Text;
      if (EditPisNit.Text <> '') AND (EditPisNit.Text <> '0') then
        TResponsavelSocioVO(ObjetoVO).PisNit          := StrToInt(EditPisNit.Text);

      if StatusTela = stInserindo then
        TResponsavelSocioController(ObjetoController).Insere(TResponsavelSocioVO(ObjetoVO))
      else
      if StatusTela = stEditando then
      begin
        TResponsavelSocioVO(ObjetoVO).ID := IdRegistroSelecionado;
        TResponsavelSocioController(ObjetoController).Altera(TResponsavelSocioVO(ObjetoVO));
      end;

      Result := True;
    except
      Result := False;
    end;
  end;
end;

procedure TFResponsavelSocio.EditIdContabilContaExit(Sender: TObject);
begin
  if (EditIdContabilConta.Text <> '') and (EditIdContabilConta.Text <> '0') then
   PopulaEditContabilConta(Self)
  else
  if (EditIdContabilConta.Text = '0') then
   begin
     EditIdContabilConta.Clear;
     EditIdContabilConta.SetFocus;
   end;
end;

procedure TFResponsavelSocio.EditIdPessoaExit(Sender: TObject);
begin
  inherited;
  if (EditIdPessoa.Text <> '') and (EditIdPessoa.Text <> '0') then
   PopulaEditPessoa(Self)
  else
  if (EditIdPessoa.Text = '0') then
   begin
     EditIdPessoa.Clear;
     EditIdPessoa.SetFocus;
   end;
end;

procedure TFResponsavelSocio.EditIdPessoaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.FLookup.ObjetoVO:= TPessoaVO.Create;
    ULookup.FLookup.ObjetoController := TPessoaController.Create;
    FLookup.ShowModal;
    EditIdPessoa.Text := IntToStr(ULookup.FLookup.CDSLookup.FieldByName('ID').AsInteger);
    EditPessoa.Text := ULookup.FLookup.CDSLookup.FieldByName('NOME').AsString;
  end;
  if key = VK_RETURN then
    EditIdContabilConta.SetFocus;

end;

procedure TFResponsavelSocio.EditMunicipioIbgeExit(Sender: TObject);
begin
  if EditMunicipioIBGE.Text <> '' then
    ConsisteMunicipioIBGE(Self);
end;

procedure TFResponsavelSocio.EditMunicipioIbgeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.FLookup.ObjetoVO := TMunicipioVO.Create;
    ULookup.FLookup.ObjetoController := TMunicipioController.Create;
    FLookup.ShowModal;
    EditMunicipioIBGE.Text := IntToStr(ULookup.FLookup.CDSLookup.FieldByName('CODIGO_IBGE').AsInteger);
    if ULookup.FLookup.CDSLookup.FieldByName('ID_UF').AsInteger <> 0 then
    begin
      PopulaUF(Self);
      EditFone1.SetFocus;
    end
    else
      EditUf.SetFocus;
  end;
  if Key = VK_RETURN then
    EditUf.SetFocus;
end;

{$ENDREGION}

procedure TFResponsavelSocio.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TResponsavelSocioVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdPessoa.Text        := IntToStr(TResponsavelSocioVO(ObjetoVO).IdPessoa);
    EditPessoa.Text          := TResponsavelSocioVO(ObjetoVO).PessoaNome;
    EditIdContabilConta.Text := IntToStr(TResponsavelSocioVO(ObjetoVO).IdContabilConta);
    EditContabilConta.Text   := TResponsavelSocioVO(ObjetoVO).ContabilConta;
    EditLogradouro.Text      := TResponsavelSocioVO(ObjetoVO).Logradouro;
    EditCep.Text             := TResponsavelSocioVO(ObjetoVO).Cep;
    EditComplemento.Text     := TResponsavelSocioVO(ObjetoVO).Complemento;
    EditNumero.Text          := TResponsavelSocioVO(ObjetoVO).Numero;
    EditBairro.Text          := TResponsavelSocioVO(ObjetoVO).Bairro;
    EditMunicipioIbge.Text   := IntToStr(TResponsavelSocioVO(ObjetoVO).MunicipioIbge);
    EditUf.Text              := TResponsavelSocioVO(ObjetoVO).Uf;
    EditFone1.Text           := TResponsavelSocioVO(ObjetoVO).Fone;
    EditFax.Text             := TResponsavelSocioVO(ObjetoVO).Fax;
    EditEmail.Text           := TResponsavelSocioVO(ObjetoVO).Email;
    EditPisNit.Text          := IntToStr(TResponsavelSocioVO(ObjetoVO).PisNit);
  end;

end;

procedure TFResponsavelSocio.PopulaEditContabilConta(Sender: TObject);
var
  Filtro: String;
begin

  Filtro := 'ID = ' + EditIdPessoa.Text;

  ConfiguraCDSFromVO(FDataModule.CDSLookup, TContabilContaVO);

  TContabilContaController.SetDataSet(FDataModule.CDSLookup);
  TContabilContaController.Consulta(Filtro,0);
  try
    if (FDataModule.CDSLookup.FieldByName('ID').AsString <> '') then
    begin
      EditIdContabilConta.Text := FDataModule.CDSLookup.FieldByName('ID').AsString;
      EditContabilConta.Text   := FDataModule.CDSLookup.FieldByName('NOME').AsString;
    end
    else
    begin
      EditIdContabilConta.SetFocus;
      keybd_event(VK_F1, 0, 0, 0);
    end;
  finally
    FDataModule.CDSLookup.Close;
  end;
end;

procedure TFResponsavelSocio.PopulaEditPessoa(Sender: TObject);
var
  Filtro: String;
begin

  Filtro := 'ID = ' + EditIdPessoa.Text;

  ConfiguraCDSFromVO(FDataModule.CDSLookup, TPessoaVO);

  TPessoaController.SetDataSet(FDataModule.CDSLookup);
  TPessoaController.Consulta(Filtro,0);
  try
    if (FDataModule.CDSLookup.FieldByName('ID').AsString <> '') then
    begin
      EditIdPessoa.Text := FDataModule.CDSLookup.FieldByName('ID').AsString;
      EditPessoa.Text := FDataModule.CDSLookup.FieldByName('NOME').AsString;
    end
    else
    begin
      EditIdPessoa.SetFocus;
      keybd_event(VK_F1, 0, 0, 0);
    end;
  finally
    FDataModule.CDSLookup.Close;
  end;
end;


procedure TFResponsavelSocio.PopulaUF(Sender: TObject);
var
  Filtro: String;
begin

  Filtro := 'ID = ' + ULookup.FLookup.CDSLookup.FieldByName('ID_UF').AsString;

  ConfiguraCDSFromVO(FDataModule.CDSLookup, TUFVO);

  TUFController.SetDataSet(FDataModule.CDSLookup);
  TUFController.Consulta(Filtro,0);
  try
    if (FDataModule.CDSLookup.FieldByName('ID').AsString <> '') then
    begin
      EditUf.Text := FDataModule.CDSLookup.FieldByName('SIGLA').AsString;
    end;
  finally
    FDataModule.CDSLookup.Close;
  end;
end;

end.
