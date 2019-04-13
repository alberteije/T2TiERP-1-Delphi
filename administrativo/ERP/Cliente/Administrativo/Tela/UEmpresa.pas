{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Empresas

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

@author Albert Eije (t2ti.com@gmail.com.br)
@version 1.0
*******************************************************************************}
unit UEmpresa;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Mask, JvExMask, JvToolEdit,
  JvCombobox, LabeledCtrls, DBCtrls, LabeledDBCtrls, DB, DBClient, StrUtils,
  Math, JSonVO, Generics.Collections, Atributos, Constantes, CheckLst, JvExCheckLst,
  JvCheckListBox, JvBaseEdits, Biblioteca, JvValidateEdit, EmpresaVO,
  EmpresaController, JvExStdCtrls, JvEdit;

type
  [TFormDescription(TConstantes.MODULO_ADMINISTRATIVO, 'Empresa')]

  TFEmpresa = class(TFTelaCadastro)
    PageControlDadosEmpresa: TPageControl;
    TabSheet1: TTabSheet;
    TabSheetContato: TTabSheet;
    PanelDadosGerais: TPanel;
    EditInicioAtividade: TLabeledDateEdit;
    EditCnpj: TLabeledMaskEdit;
    EditInscricaoEstadual: TLabeledMaskEdit;
    EditInscricaoEstadualST: TLabeledMaskEdit;
    EditInscricaoMunicipal: TLabeledMaskEdit;
    EditInscricaoJuntaComercial: TLabeledMaskEdit;
    EditDataInscricaoJuntaComercial: TLabeledDateEdit;
    EditContato: TLabeledEdit;
    ComboBoxCRT: TLabeledComboBox;
    EditSuframa: TLabeledEdit;
    ComboBoxTipo: TLabeledComboBox;
    ComboBoxTipoRegime: TLabeledComboBox;
    GroupBox1: TGroupBox;
    EditEmail: TLabeledEdit;
    GridContato: TJvDBUltimGrid;
    TabSheetEndereco: TTabSheet;
    GridEndereco: TJvDBUltimGrid;
    PanelPrincipal: TPanel;
    EditRazaoSocial: TLabeledEdit;
    EditNomeFantasia: TLabeledEdit;
    EditNomeMatriz: TLabeledEdit;
    EditNomeContador: TLabeledEdit;
    EditNomeSindicato: TLabeledEdit;
    EditDescricaoFpas: TLabeledEdit;
    CDSContato: TClientDataSet;
    CDSContatoID: TIntegerField;
    CDSContatoID_PESSOA: TIntegerField;
    CDSContatoID_EMPRESA: TIntegerField;
    CDSContatoNOME: TStringField;
    CDSContatoEMAIL: TStringField;
    CDSContatoFONE_COMERCIAL: TStringField;
    CDSContatoFONE_RESIDENCIAL: TStringField;
    CDSContatoFONE_CELULAR: TStringField;
    CDSContatoPERSISTE: TStringField;
    DSContato: TDataSource;
    CDSEndereco: TClientDataSet;
    CDSEnderecoID: TIntegerField;
    CDSEnderecoID_EMPRESA: TIntegerField;
    CDSEnderecoID_PESSOA: TIntegerField;
    CDSEnderecoLOGRADOURO: TStringField;
    CDSEnderecoNUMERO: TStringField;
    CDSEnderecoCOMPLEMENTO: TStringField;
    CDSEnderecoBAIRRO: TStringField;
    CDSEnderecoCIDADE: TStringField;
    CDSEnderecoCEP: TStringField;
    CDSEnderecoMUNICIPIO_IBGE: TIntegerField;
    CDSEnderecoUF: TStringField;
    CDSEnderecoFONE: TStringField;
    CDSEnderecoFAX: TStringField;
    CDSEnderecoPRINCIPAL: TStringField;
    CDSEnderecoENTREGA: TStringField;
    CDSEnderecoCOBRANCA: TStringField;
    CDSEnderecoCORRESPONDENCIA: TStringField;
    CDSEnderecoPERSISTE: TStringField;
    DSEndereco: TDataSource;
    EditIdMatriz: TLabeledCalcEdit;
    EditIdContador: TLabeledCalcEdit;
    EditIdSindicato: TLabeledCalcEdit;
    EditIdFpas: TLabeledCalcEdit;
    ImagemLogotipo: TImage;
    EditCei: TLabeledEdit;
    EditCodigoCnaePrincipal: TLabeledEdit;
    EditCodigoTerceiros: TLabeledCalcEdit;
    EditCodigoGps: TLabeledCalcEdit;
    EditAliquotaPis: TLabeledCalcEdit;
    EditAliquotaCofins: TLabeledCalcEdit;
    EditAliquotaSat: TLabeledCalcEdit;
    EditCodigoIbgeCidade: TLabeledCalcEdit;
    EditCodigoIbgeUf: TLabeledCalcEdit;
    PopupMenu1: TPopupMenu;
    CarregarImaem1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridEnderecoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridContatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSContatoAfterEdit(DataSet: TDataSet);
    procedure CDSEnderecoAfterEdit(DataSet: TDataSet);
    procedure CDSContatoBeforeDelete(DataSet: TDataSet);
    procedure CDSEnderecoBeforeDelete(DataSet: TDataSet);
    procedure ImagemLogotipoClick(Sender: TObject);
    procedure CarregarImaem1Click(Sender: TObject);
    procedure EditIdMatrizExit(Sender: TObject);
    procedure EditIdMatrizKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdMatrizKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdContadorExit(Sender: TObject);
    procedure EditIdContadorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContadorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdSindicatoExit(Sender: TObject);
    procedure EditIdSindicatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdSindicatoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdFpasExit(Sender: TObject);
    procedure EditIdFpasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdFpasKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure CarregarImagem;
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    procedure ConfiguraLayoutTela;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FEmpresa: TFEmpresa;

implementation

uses ULookup, UDataModule,
    //
    EnderecoController, ContatoController, ContadorController, SindicatoController,
    FpasController,
    //
    EnderecoVO, ContadorVO, ContatoVO, SindicatoVO, FpasVO;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFEmpresa.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TEmpresaVO;
  ObjetoController := TEmpresaController.Create;

  inherited;
end;

procedure TFEmpresa.ConfiguraLayoutTela;
begin
  PageControlDadosEmpresa.ActivePageIndex := 0;

  PanelEdits.Enabled := True;
  if StatusTela = stNavegandoEdits then
  begin
    PanelPrincipal.Enabled := False;
    PanelDadosGerais.Enabled := False;
  end
  else
  begin
    PanelPrincipal.Enabled := True;
    PanelDadosGerais.Enabled := True;
  end;
end;

procedure TFEmpresa.LimparCampos;
begin
  inherited;

  CDSContato.EmptyDataSet;
  CDSEndereco.EmptyDataSet;
  ConfiguraLayoutTela;
  FDataModule.ImagemPadrao.GetBitmap(0, ImagemLogotipo.Picture.Bitmap);
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFEmpresa.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditRazaoSocial.SetFocus;
  end;
end;

function TFEmpresa.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditRazaoSocial.SetFocus;
  end;
end;

function TFEmpresa.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TEmpresaController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TEmpresaController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFEmpresa.DoSalvar: Boolean;
var
  Contato: TContatoVO;
  Endereco: TEnderecoVO;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TEmpresaVO.Create;

      TEmpresaVO(ObjetoVO).IdMatriz := EditIdMatriz.AsInteger;
      TEmpresaVO(ObjetoVO).IdSindicatoPatronal := EditIdSindicato.AsInteger;
      TEmpresaVO(ObjetoVO).Sindicato := EditNomeSindicato.Text;
      TEmpresaVO(ObjetoVO).IdFpas := EditIdFPAS.AsInteger;
      TEmpresaVO(ObjetoVO).DescricaoFpas := EditDescricaoFpas.Text;
      TEmpresaVO(ObjetoVO).IdContador := EditIdContador.AsInteger;
      TEmpresaVO(ObjetoVO).Contador := EditNomeContador.Text;
      TEmpresaVO(ObjetoVO).RazaoSocial := EditRazaoSocial.Text;
      TEmpresaVO(ObjetoVO).NomeFantasia := EditNomeFantasia.Text;
      TEmpresaVO(ObjetoVO).Cnpj := EditCnpj.Text;
      TEmpresaVO(ObjetoVO).InscricaoEstadual := EditInscricaoEstadual.Text;
      TEmpresaVO(ObjetoVO).InscricaoEstadualSt := EditInscricaoEstadualST.Text;
      TEmpresaVO(ObjetoVO).InscricaoMunicipal := EditInscricaoMunicipal.Text;
      TEmpresaVO(ObjetoVO).InscricaoJuntaComercial := EditInscricaoJuntaComercial.Text;
      TEmpresaVO(ObjetoVO).DataInscJuntaComercial := EditDataInscricaoJuntaComercial.Date;
      TEmpresaVO(ObjetoVO).Tipo := Copy(ComboBoxTipo.Text, 1, 1);
      TEmpresaVO(ObjetoVO).DataCadastro := Now;
      TEmpresaVO(ObjetoVO).DataInicioAtividades := EditInicioAtividade.Date;
      TEmpresaVO(ObjetoVO).Suframa := EditSuframa.Text;
      TEmpresaVO(ObjetoVO).Email := EditEmail.Text;
      TEmpresaVO(ObjetoVO).Crt := Copy(ComboBoxCRT.Text, 1, 1);
      TEmpresaVO(ObjetoVO).TipoRegime := Copy(ComboBoxTipoRegime.Text, 1, 1);
      TEmpresaVO(ObjetoVO).AliquotaPis := EditAliquotaPis.Value;
      TEmpresaVO(ObjetoVO).Contato := EditContato.Text;
      TEmpresaVO(ObjetoVO).AliquotaCofins := EditAliquotaCofins.Value;
      TEmpresaVO(ObjetoVO).CodigoIbgeCidade := EditCodigoIbgeCidade.AsInteger;
      TEmpresaVO(ObjetoVO).CodigoIbgeUf := EditCodigoIbgeUf.AsInteger;
      TEmpresaVO(ObjetoVO).CodigoTerceiros := EditCodigoTerceiros.AsInteger;
      TEmpresaVO(ObjetoVO).CodigoGps := EditCodigoGps.AsInteger;
      TEmpresaVO(ObjetoVO).AliquotaSat := EditAliquotaSat.Value;
      TEmpresaVO(ObjetoVO).Cei := EditCei.Text;
      TEmpresaVO(ObjetoVO).CodigoCnaePrincipal := EditCodigoCnaePrincipal.Text;

      if TEmpresaVO(ObjetoVO).Imagem <> '' then
        TEmpresaVO(ObjetoVO).ImagemLogotipo := IntToStr(TEmpresaVO(ObjetoVO).Id) + TEmpresaVO(ObjetoVO).TipoImagem;

      if StatusTela = stEditando then
        TEmpresaVO(ObjetoVO).Id := IdRegistroSelecionado;


      // Contatos
      TEmpresaVO(ObjetoVO).ListaContatoVO := TObjectList<TContatoVO>.Create;
      CDSContato.DisableControls;
      CDSContato.First;
      while not CDSContato.Eof do
      begin
        if (CDSContatoPERSISTE.AsString = 'S') or (CDSContatoID.AsInteger = 0) then
        begin
          Contato := TContatoVO.Create;
          Contato.Id := CDSContatoID.AsInteger;
          Contato.IdEmpresa := TEmpresaVO(ObjetoVO).Id;
          Contato.Nome := CDSContatoNOME.AsString;
          Contato.Email := CDSContatoEMAIL.AsString;
          Contato.FoneComercial := CDSContatoFONE_COMERCIAL.AsString;
          Contato.FoneResidencial := CDSContatoFONE_RESIDENCIAL.AsString;
          Contato.FoneCelular := CDSContatoFONE_CELULAR.AsString;
          TEmpresaVO(ObjetoVO).ListaContatoVO.Add(Contato);
        end;
        CDSContato.Next;
      end;
      CDSContato.EnableControls;

      // Endereços
      TEmpresaVO(ObjetoVO).ListaEnderecoVO := TObjectList<TEnderecoVO>.Create;
      CDSEndereco.DisableControls;
      CDSEndereco.First;
      while not CDSEndereco.Eof do
      begin
        if (CDSEnderecoPERSISTE.AsString = 'S') or (CDSEnderecoID.AsInteger = 0) then
        begin
          Endereco := TEnderecoVO.Create;
          Endereco.Id := CDSEnderecoID.AsInteger;
          Endereco.IdEmpresa := TEmpresaVO(ObjetoVO).Id;
          Endereco.Logradouro := CDSEnderecoLOGRADOURO.AsString;
          Endereco.Numero := CDSEnderecoNUMERO.AsString;
          Endereco.Complemento := CDSEnderecoCOMPLEMENTO.AsString;
          Endereco.Bairro := CDSEnderecoBAIRRO.AsString;
          Endereco.Cidade := CDSEnderecoCIDADE.AsString;
          Endereco.Cep := CDSEnderecoCEP.AsString;
          Endereco.MunicipioIbge := CDSEnderecoMUNICIPIO_IBGE.AsInteger;
          Endereco.Uf := CDSEnderecoUF.AsString;
          Endereco.Fone := CDSEnderecoFONE.AsString;
          Endereco.Fax := CDSEnderecoFAX.AsString;
          Endereco.Principal := CDSEnderecoPRINCIPAL.AsString;
          Endereco.Entrega := CDSEnderecoENTREGA.AsString;
          Endereco.Cobranca := CDSEnderecoCOBRANCA.AsString;
          Endereco.Correspondencia := CDSEnderecoCORRESPONDENCIA.AsString;
          TEmpresaVO(ObjetoVO).ListaEnderecoVO.Add(Endereco);
        end;
        CDSEndereco.Next;
      end;
      CDSEndereco.EnableControls;

      if StatusTela = stInserindo then
        Result := TEmpresaController(ObjetoController).Insere(TEmpresaVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TEmpresaVO(ObjetoVO).ToJSONString <> TEmpresaVO(ObjetoOldVO).ToJSONString then
        begin
          TEmpresaVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TEmpresaController(ObjetoController).Altera(TEmpresaVO(ObjetoVO), TEmpresaVO(ObjetoOldVO));
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
procedure TFEmpresa.EditIdContadorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdContador.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdContador.Text;
      EditIdContador.Clear;
      EditNomeContador.Clear;
      if not PopulaCamposTransientes(Filtro, TContadorVO, TContadorController) then
        PopulaCamposTransientesLookup(TContadorVO, TContadorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdContador.Text := CDSTransiente.FieldByName('ID').AsString;
        EditNomeContador.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdContador.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditNomeContador.Clear;
  end;
end;

procedure TFEmpresa.EditIdContadorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContador.Value := -1;
    EditIdSindicato.SetFocus;
  end;
end;

procedure TFEmpresa.EditIdContadorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdSindicato.SetFocus;
  end;
end;

procedure TFEmpresa.EditIdFpasExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdFpas.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdFpas.Text;
      EditIdFpas.Clear;
      EditDescricaoFpas.Clear;
      if not PopulaCamposTransientes(Filtro, TFpasVO, TFpasController) then
        PopulaCamposTransientesLookup(TFpasVO, TFpasController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdFpas.Text := CDSTransiente.FieldByName('ID').AsString;
        EditDescricaoFpas.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditIdFpas.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditDescricaoFpas.Clear;
  end;
end;

procedure TFEmpresa.EditIdFpasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdFpas.Value := -1;
    EditInicioAtividade.SetFocus;
  end;
end;

procedure TFEmpresa.EditIdFpasKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditInicioAtividade.SetFocus;
  end;
end;

procedure TFEmpresa.EditIdMatrizExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdMatriz.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdMatriz.Text;
      EditIdMatriz.Clear;
      EditNomeMatriz.Clear;
      if not PopulaCamposTransientes(Filtro, TEmpresaVO, TEmpresaController) then
        PopulaCamposTransientesLookup(TEmpresaVO, TEmpresaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdMatriz.Text := CDSTransiente.FieldByName('ID').AsString;
        EditNomeMatriz.Text := CDSTransiente.FieldByName('RAZAO_SOCIAL').AsString;
      end
      else
      begin
        Exit;
        EditIdMatriz.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditNomeMatriz.Clear;
  end;
end;

procedure TFEmpresa.EditIdMatrizKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdMatriz.Value := -1;
    EditIdContador.SetFocus;
  end;
end;

procedure TFEmpresa.EditIdMatrizKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdContador.SetFocus;
  end;
end;

procedure TFEmpresa.EditIdSindicatoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdSindicato.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdSindicato.Text;
      EditIdSindicato.Clear;
      EditNomeSindicato.Clear;
      if not PopulaCamposTransientes(Filtro, TSindicatoVO, TSindicatoController) then
        PopulaCamposTransientesLookup(TSindicatoVO, TSindicatoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdSindicato.Text := CDSTransiente.FieldByName('ID').AsString;
        EditNomeSindicato.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdSindicato.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditNomeSindicato.Clear;
  end;
end;

procedure TFEmpresa.EditIdSindicatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdSindicato.Value := -1;
    EditIdFPAS.SetFocus;
  end;
end;

procedure TFEmpresa.EditIdSindicatoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdFPAS.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFEmpresa.CDSContatoAfterEdit(DataSet: TDataSet);
begin
  CDSContatoPERSISTE.AsString := 'S';
end;

procedure TFEmpresa.CDSContatoBeforeDelete(DataSet: TDataSet);
begin
  if CDSContatoID.AsInteger > 0 then
    TContatoController.Exclui(CDSContatoID.AsInteger);
end;

procedure TFEmpresa.CDSEnderecoAfterEdit(DataSet: TDataSet);
begin
  CDSEnderecoPERSISTE.AsString := 'S';
end;

procedure TFEmpresa.CDSEnderecoBeforeDelete(DataSet: TDataSet);
begin
  if CDSEnderecoID.AsInteger > 0 then
    TEnderecoController.Exclui(CDSEnderecoID.AsInteger);
end;

procedure TFEmpresa.GridContatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridContato.SelectedIndex := GridContato.SelectedIndex + 1;
end;

procedure TFEmpresa.GridEnderecoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridEndereco.SelectedIndex := GridEndereco.SelectedIndex + 1;
end;

procedure TFEmpresa.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfiguraLayoutTela;
end;

procedure TFEmpresa.GridParaEdits;
var
  ContatosEnumerator: TEnumerator<TContatoVO>;
  EnderecosEnumerator: TEnumerator<TEnderecoVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TEmpresaVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdMatriz.AsInteger := TEmpresaVO(ObjetoVO).IdMatriz;
    EditIdSindicato.AsInteger := TEmpresaVO(ObjetoVO).IdSindicatoPatronal;
    EditNomeSindicato.Text := TEmpresaVO(ObjetoVO).Sindicato;
    EditIdFPAS.AsInteger := TEmpresaVO(ObjetoVO).IdFpas;
    EditDescricaoFpas.Text := TEmpresaVO(ObjetoVO).DescricaoFpas;
    EditIdContador.AsInteger := TEmpresaVO(ObjetoVO).IdContador;
    EditNomeContador.Text := TEmpresaVO(ObjetoVO).Contador;
    EditRazaoSocial.Text := TEmpresaVO(ObjetoVO).RazaoSocial;
    EditNomeFantasia.Text := TEmpresaVO(ObjetoVO).NomeFantasia;
    EditCnpj.Text := TEmpresaVO(ObjetoVO).Cnpj;
    EditInscricaoEstadual.Text := TEmpresaVO(ObjetoVO).InscricaoEstadual;
    EditInscricaoEstadualST.Text := TEmpresaVO(ObjetoVO).InscricaoEstadualSt;
    EditInscricaoMunicipal.Text := TEmpresaVO(ObjetoVO).InscricaoMunicipal;
    EditInscricaoJuntaComercial.Text := TEmpresaVO(ObjetoVO).InscricaoJuntaComercial;
    EditDataInscricaoJuntaComercial.Date := TEmpresaVO(ObjetoVO).DataInscJuntaComercial;
    ComboBoxTipo.ItemIndex := AnsiIndexStr(TEmpresaVO(ObjetoVO).Tipo, ['M', 'F', 'D']);
    EditInicioAtividade.Date := TEmpresaVO(ObjetoVO).DataInicioAtividades;
    EditSuframa.Text := TEmpresaVO(ObjetoVO).Suframa;
    EditEmail.Text := TEmpresaVO(ObjetoVO).Email;
    ComboBoxCRT.ItemIndex := AnsiIndexStr(TEmpresaVO(ObjetoVO).Crt, ['1', '2', '3']);
    ComboBoxTipoRegime.ItemIndex := AnsiIndexStr(TEmpresaVO(ObjetoVO).TipoRegime, ['1', '2', '3']);
    EditAliquotaPis.Value := TEmpresaVO(ObjetoVO).AliquotaPis;
    EditContato.Text := TEmpresaVO(ObjetoVO).Contato;
    EditAliquotaCofins.Value := TEmpresaVO(ObjetoVO).AliquotaCofins;
    EditCodigoIbgeCidade.AsInteger := TEmpresaVO(ObjetoVO).CodigoIbgeCidade;
    EditCodigoIbgeUf.AsInteger := TEmpresaVO(ObjetoVO).CodigoIbgeUf;
    EditCodigoTerceiros.AsInteger := TEmpresaVO(ObjetoVO).CodigoTerceiros;
    EditCodigoGps.AsInteger := TEmpresaVO(ObjetoVO).CodigoGps;
    EditAliquotaSat.Value := TEmpresaVO(ObjetoVO).AliquotaSat;
    EditCei.Text := TEmpresaVO(ObjetoVO).Cei;
    EditCodigoCnaePrincipal.Text := TEmpresaVO(ObjetoVO).CodigoCnaePrincipal;

    // Contatos
    ContatosEnumerator := TEmpresaVO(ObjetoVO).ListaContatoVO.GetEnumerator;
    try
      with ContatosEnumerator do
      begin
        while MoveNext do
        begin
          CDSContato.Append;

          CDSContatoID.AsInteger := Current.Id;
          CDSContatoID_EMPRESA.AsInteger := Current.IdEmpresa;
          CDSContatoNOME.AsString := Current.Nome;
          CDSContatoEMAIL.AsString := Current.Email;
          CDSContatoFONE_COMERCIAL.AsString := Current.FoneComercial;
          CDSContatoFONE_RESIDENCIAL.AsString := Current.FoneResidencial;
          CDSContatoFONE_CELULAR.AsString := Current.FoneCelular;
          CDSContatoPERSISTE.AsString := 'N';

          CDSContato.Post;
        end;
      end;
    finally
      ContatosEnumerator.Free;
    end;
    TEmpresaVO(ObjetoVO).ListaContatoVO := Nil;
    if Assigned(TEmpresaVO(ObjetoOldVO)) then
      TEmpresaVO(ObjetoOldVO).ListaContatoVO := Nil;

    // Endereços
    EnderecosEnumerator := TEmpresaVO(ObjetoVO).ListaEnderecoVO.GetEnumerator;
    try
      with EnderecosEnumerator do
      begin
        while MoveNext do
        begin
          CDSEndereco.Append;

          CDSEnderecoID.AsInteger := Current.Id;
          CDSEnderecoID_EMPRESA.AsInteger := Current.IdEmpresa;
          CDSEnderecoLOGRADOURO.AsString := Current.Logradouro;
          CDSEnderecoNUMERO.AsString := Current.Numero;
          CDSEnderecoCOMPLEMENTO.AsString := Current.Complemento;
          CDSEnderecoBAIRRO.AsString := Current.Bairro;
          CDSEnderecoCIDADE.AsString := Current.Cidade;
          CDSEnderecoCEP.AsString := Current.Cep;
          CDSEnderecoMUNICIPIO_IBGE.AsInteger := Current.MunicipioIbge;
          CDSEnderecoUF.AsString := Current.Uf;
          CDSEnderecoFONE.AsString := Current.Fone;
          CDSEnderecoFAX.AsString := Current.Fax;
          CDSEnderecoPRINCIPAL.AsString := IfThen(Current.Principal = 'S', 'S', 'N');
          CDSEnderecoENTREGA.AsString := IfThen(Current.Entrega = 'S', 'S', 'N');
          CDSEnderecoCOBRANCA.AsString := IfThen(Current.Cobranca = 'S', 'S', 'N');
          CDSEnderecoCORRESPONDENCIA.AsString := IfThen(Current.Correspondencia = 'S', 'S', 'N');
          CDSEnderecoPERSISTE.AsString := 'N';

          CDSEndereco.Post;
        end;
      end;
    finally
      EnderecosEnumerator.Free;
    end;

    TEmpresaVO(ObjetoVO).ListaEnderecoVO := Nil;
    if Assigned(TEmpresaVO(ObjetoOldVO)) then
      TEmpresaVO(ObjetoOldVO).ListaEnderecoVO := Nil;
  end;
  ConfiguraLayoutTela;
end;
{$ENDREGION}

{$REGION 'Controle de Imagens'}
procedure TFEmpresa.ImagemLogotipoClick(Sender: TObject);
var
  ArquivoStream: TStringStream;
  ArquivoBytesString: String;
  i: Integer;
begin
  if StatusTela = stNavegandoEdits then
    Application.MessageBox('Não é permitido selecionar nova imagem em modo de consulta.', 'Informação do sistema.', MB_OK + MB_ICONINFORMATION)
  else
  begin
    if FDataModule.OpenDialog.Execute then
    begin
      try
        try
          ArquivoBytesString := '';
          ImagemLogotipo.Picture.LoadFromFile(FDataModule.OpenDialog.FileName);
          ArquivoStream := TStringStream.Create;
          ArquivoStream.LoadFromFile(FDataModule.OpenDialog.FileName);
          for i := 0 to ArquivoStream.Size - 1 do
          begin
            ArquivoBytesString := ArquivoBytesString + IntToStr(ArquivoStream.Bytes[i]) + ', ';
          end;
          // Tira a ultima virgula
          Delete(ArquivoBytesString, Length(ArquivoBytesString) - 1, 2);
          TEmpresaVO(ObjetoVO).Imagem := ArquivoBytesString;
          TEmpresaVO(ObjetoVO).TipoImagem := ExtractFileExt(FDataModule.OpenDialog.FileName);
        except
          Application.MessageBox('Arquivo de imagem com formato inválido.', 'Erro do sistema.', MB_OK + MB_ICONERROR);
        end;
      finally
        ArquivoStream.Free;
      end;
    end;
  end;
end;

procedure TFEmpresa.CarregarImaem1Click(Sender: TObject);
begin
  if TEmpresaVO(ObjetoVO).ImagemLogotipo <> '' then
    CarregarImagem;
end;

procedure TFEmpresa.CarregarImagem;
var
  Arquivo: String;
begin
  Arquivo := TEmpresaController.DownloadArquivo(TEmpresaVO(ObjetoVO).ImagemLogotipo, 'EMPRESA');
  if Arquivo <> '' then
    ImagemLogotipo.Picture.LoadFromFile(Arquivo);
end;
{$ENDREGION}

end.
