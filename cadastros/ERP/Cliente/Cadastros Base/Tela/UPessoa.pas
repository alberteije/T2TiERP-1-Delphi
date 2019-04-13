{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Pessoas

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

unit UPessoa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Mask, JvExMask, JvToolEdit,
  JvCombobox, LabeledCtrls, DBCtrls, LabeledDBCtrls, DB, DBClient, StrUtils,
  Math, JSonVO, PessoaFisicaVO, PessoaJuridicaVO, Generics.Collections,
  Atributos, Constantes, CheckLst, JvExCheckLst, JvCheckListBox, JvBaseEdits;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Pessoa')]
  TFPessoa = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    PageControlDadosPessoa: TPageControl;
    tsTipoPessoa: TTabSheet;
    PanelDadosPessoa: TPanel;
    PageControlTipoPessoa: TPageControl;
    tsPessoaFisica: TTabSheet;
    PanelPessoaFisica: TPanel;
    EditCPF: TLabeledMaskEdit;
    GroupBoxRG: TGroupBox;
    EditRGNumero: TLabeledEdit;
    EditRGEmissao: TLabeledDateEdit;
    EditRGOrgaoEmissor: TLabeledEdit;
    EditNascimento: TLabeledDateEdit;
    RadioGroupSexo: TRadioGroup;
    LComboBoxEstadoCivil: TLabeledDBLookupComboBox;
    tsPessoaJuridica: TTabSheet;
    PanelPessoaJuridica: TPanel;
    EditFantasia: TLabeledEdit;
    EditCNPJ: TLabeledMaskEdit;
    EditInscricaoMunicipal: TLabeledEdit;
    EditDataConstituicao: TLabeledDateEdit;
    TabSheetContatos: TTabSheet;
    PanelContatos: TPanel;
    GridContato: TJvDBUltimGrid;
    EditNomeMae: TLabeledEdit;
    EditNaturalidade: TLabeledEdit;
    EditNacionalidade: TLabeledEdit;
    ComboBoxRaca: TLabeledComboBox;
    ComboBoxTipoSangue: TLabeledComboBox;
    GroupBoxCNH: TGroupBox;
    EditCNHNumero: TLabeledEdit;
    EditCNHVencimento: TLabeledDateEdit;
    ComboBoxCNHCategoria: TLabeledComboBox;
    GroupBoxTituloEleitoral: TGroupBox;
    EditTituloNumero: TLabeledEdit;
    EditTituloZona: TLabeledCalcEdit;
    EditTituloSecao: TLabeledCalcEdit;
    EditNomePai: TLabeledEdit;
    GroupBoxReservista: TGroupBox;
    EditReservistaNumero: TLabeledEdit;
    ComboBoxReservistaCategoria: TLabeledComboBox;
    EditInscricaoEstadual: TLabeledEdit;
    EditSuframa: TLabeledEdit;
    ComboBoxTipoRegime: TLabeledComboBox;
    ComboBoxCRT: TLabeledComboBox;
    TabSheetEnderecos: TTabSheet;
    PanelEnderecos: TPanel;
    GridEndereco: TJvDBUltimGrid;
    PanelPessoaDadosBase: TPanel;
    EditEmail: TLabeledEdit;
    EditNome: TLabeledEdit;
    ComboboxTipoPessoa: TLabeledComboBox;
    CheckListBoxPessoa: TJvCheckListBox;
    EditSite: TLabeledEdit;
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
    CDSEstadoCivil: TClientDataSet;
    DSEstadoCivil: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridContatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridEnderecoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridDblClick(Sender: TObject);
    procedure ComboboxTipoPessoaChange(Sender: TObject);
    procedure CDSContatoAfterEdit(DataSet: TDataSet);
    procedure CDSEnderecoAfterEdit(DataSet: TDataSet);
    procedure CDSEnderecoBeforeDelete(DataSet: TDataSet);
    procedure CDSContatoBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
    IdTipoPessoa: Integer;
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ExibirDadosTipoPessoa;
    procedure ConfigurarLayoutTela;
    procedure PopulaComboEstadoCivil(Sender: TObject);
  end;

var
  FPessoa: TFPessoa;

implementation

uses EstadoCivilController, Biblioteca, EstadoCivilVO, NotificationService,
  PessoaVO, PessoaController, ContatoVO, EnderecoVO, ContatoController,
  EnderecoController;
{$R *.dfm}
{ TFPessoa }

{$REGION 'Infra'}
procedure TFPessoa.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TPessoaVO;
  ObjetoController := TPessoaController.Create;

  inherited;

  PopulaComboEstadoCivil(Self);
  GetNotificationService.Subscribe(PopulaComboEstadoCivil, TConstantes.IF_EstadoCivil);
end;

procedure TFPessoa.FormDestroy(Sender: TObject);
begin
  GetNotificationService.UnSubscribe(PopulaComboEstadoCivil);
  inherited;
end;

procedure TFPessoa.LimparCampos;
var
  i: Integer;
begin
  inherited;

  ComboboxTipoPessoa.ItemIndex := 0;

  RadioGroupSexo.ItemIndex := -1;
  LComboBoxEstadoCivil.KeyValue := Null;

  CDSContato.EmptyDataSet;
  CDSEndereco.EmptyDataSet;

  for i := 0 to CheckListBoxPessoa.Items.Count - 1 do
    CheckListBoxPessoa.Checked[i] := False;
end;

procedure TFPessoa.ComboboxTipoPessoaChange(Sender: TObject);
begin
  ExibirDadosTipoPessoa;
end;

procedure TFPessoa.ConfigurarLayoutTela;
begin
  PageControlDadosPessoa.ActivePageIndex := 0;
  PanelEdits.Enabled := True;

  if StatusTela = stNavegandoEdits then
  begin
    PanelDadosPessoa.Enabled := False;
    PanelContatos.Enabled := False;
    PanelEnderecos.Enabled := False;
    PanelPessoaDadosBase.Enabled := False;
  end
  else
  begin
    PanelDadosPessoa.Enabled := True;
    PanelContatos.Enabled := True;
    PanelEnderecos.Enabled := True;
    PanelPessoaDadosBase.Enabled := True;
  end;
  ExibirDadosTipoPessoa;
end;

procedure TFPessoa.ExibirDadosTipoPessoa;
begin
  case ComboboxTipoPessoa.ItemIndex of
    0:
      begin
        PanelPessoaFisica.Parent := PanelDadosPessoa;
        PanelPessoaFisica.Visible := True;
        PanelPessoaJuridica.Visible := False;
      end;
    1:
      begin
        PanelPessoaJuridica.Parent := PanelDadosPessoa;
        PanelPessoaFisica.Visible := False;
        PanelPessoaJuridica.Visible := True;
      end;
  end;
end;

procedure TFPessoa.PopulaComboEstadoCivil(Sender: TObject);
begin
  ConfiguraCDSFromVO(CDSEstadoCivil, TEstadoCivilVO);

  TEstadoCivilController.SetDataSet(CDSEstadoCivil);
  TEstadoCivilController.Consulta('ID > 0', 0);

  LComboBoxEstadoCivil.ListField := 'NOME';
  LComboBoxEstadoCivil.KeyField := 'ID'
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFPessoa.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    IdTipoPessoa := 0;
    EditNome.SetFocus;
    ComboboxTipoPessoa.Enabled := True;
    ExibirDadosTipoPessoa;
  end;
end;

function TFPessoa.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
    ComboboxTipoPessoa.Enabled := False;
  end;
end;

function TFPessoa.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TPessoaController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TPessoaController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFPessoa.DoSalvar: Boolean;
var
  Contato: TContatoVO;
  Endereco: TEnderecoVO;
begin
  if EditNome.Text = '' then
  begin
    Application.MessageBox('Informe o nome da pessoa.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditNome.SetFocus;
    Exit(False);
  end
  else if ComboboxTipoPessoa.ItemIndex = 0 then
  begin
    if EditCPF.Text = '' then
    begin
      Application.MessageBox('Informe o CPF da pessoa.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      EditCPF.SetFocus;
      Exit(False);
    end
    else if EditNomeMae.Text = '' then
    begin
      Application.MessageBox('Informe o nome da mãe.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      EditNomeMae.SetFocus;
      Exit(False);
    end
    else if LComboBoxEstadoCivil.KeyValue = Null then
    begin
      Application.MessageBox('Selecione o estado civil.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      LComboBoxEstadoCivil.SetFocus;
      Exit(False);
    end
  end
  else if ComboboxTipoPessoa.ItemIndex = 1 then
  begin
    if EditCNPJ.Text = '' then
    begin
      Application.MessageBox('Informe o CNPJ da pessoa.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      EditCNPJ.SetFocus;
      Exit(False);
    end;
  end;

  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TPessoaVO.Create;

      TPessoaVO(ObjetoVO).Nome := EditNome.Text;
      TPessoaVO(ObjetoVO).Tipo := IfThen(ComboboxTipoPessoa.ItemIndex = 0, 'F', 'J');
      TPessoaVO(ObjetoVO).Email := EditEmail.Text;
      TPessoaVO(ObjetoVO).Site := EditSite.Text;
      TPessoaVO(ObjetoVO).Cliente := IfThen(CheckListBoxPessoa.Checked[0], 'S', 'N');
      TPessoaVO(ObjetoVO).Fornecedor := IfThen(CheckListBoxPessoa.Checked[1], 'S', 'N');
      TPessoaVO(ObjetoVO).Colaborador := IfThen(CheckListBoxPessoa.Checked[2], 'S', 'N');
      TPessoaVO(ObjetoVO).Convenio := IfThen(CheckListBoxPessoa.Checked[3], 'S', 'N');
      TPessoaVO(ObjetoVO).Contador := IfThen(CheckListBoxPessoa.Checked[4], 'S', 'N');
      TPessoaVO(ObjetoVO).Transportadora := IfThen(CheckListBoxPessoa.Checked[5], 'S', 'N');

      if StatusTela = stEditando then
        TPessoaVO(ObjetoVO).Id := IdRegistroSelecionado;

      // Tipo de Pessoa
      if TPessoaVO(ObjetoVO).Tipo = 'F' then
      begin
        TPessoaVO(ObjetoVO).PessoaFisicaVO := TPessoaFisicaVO.Create;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.Id := IdTipoPessoa;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.IdPessoa := TPessoaVO(ObjetoVO).Id;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.CPF := EditCPF.Text;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.DataNascimento := EditNascimento.Date;
        if LComboBoxEstadoCivil.KeyValue <> Null then
          TPessoaVO(ObjetoVO).PessoaFisicaVO.IdEstadoCivil := LComboBoxEstadoCivil.KeyValue;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.Raca := Copy(ComboBoxRaca.Text, 1, 1);
        TPessoaVO(ObjetoVO).PessoaFisicaVO.TipoSangue := Copy(ComboBoxTipoSangue.Text, 1, 1);
        TPessoaVO(ObjetoVO).PessoaFisicaVO.Naturalidade := EditNaturalidade.Text;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.Nacionalidade := EditNacionalidade.Text;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.NomePai := EditNomePai.Text;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.NomeMae := EditNomeMae.Text;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.RG := EditRGNumero.Text;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.DataEmissaoRg := EditRGEmissao.Date;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.OrgaoRg := EditRGOrgaoEmissor.Text;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.ReservistaNumero := EditReservistaNumero.Text;
        if ComboBoxReservistaCategoria.Text <> '' then
          TPessoaVO(ObjetoVO).PessoaFisicaVO.ReservistaCategoria := StrToInt(ComboBoxReservistaCategoria.Text);
        case RadioGroupSexo.ItemIndex of
          0:
            TPessoaVO(ObjetoVO).PessoaFisicaVO.Sexo := 'F';
          1:
            TPessoaVO(ObjetoVO).PessoaFisicaVO.Sexo := 'M';
        else
          TPessoaVO(ObjetoVO).PessoaFisicaVO.Sexo := '';
        end;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.CnhNumero := EditCNHNumero.Text;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.CnhVencimento := EditRGEmissao.Date;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.CnhCategoria := ComboBoxCNHCategoria.Text;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.TituloEleitoralNumero := EditTituloNumero.Text;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.TituloEleitoralZona := EditTituloZona.AsInteger;
        TPessoaVO(ObjetoVO).PessoaFisicaVO.TituloEleitoralSecao := EditTituloSecao.AsInteger;
      end
      else if TPessoaVO(ObjetoVO).Tipo = 'J' then
      begin
        TPessoaVO(ObjetoVO).PessoaJuridicaVO := TPessoaJuridicaVO.Create;
        TPessoaVO(ObjetoVO).PessoaJuridicaVO.Id := IdTipoPessoa;
        TPessoaVO(ObjetoVO).PessoaJuridicaVO.IdPessoa := TPessoaVO(ObjetoVO).Id;
        TPessoaVO(ObjetoVO).PessoaJuridicaVO.Fantasia := EditFantasia.Text;
        TPessoaVO(ObjetoVO).PessoaJuridicaVO.Cnpj := EditCNPJ.Text;
        TPessoaVO(ObjetoVO).PessoaJuridicaVO.InscricaoEstadual := EditInscricaoEstadual.Text;
        TPessoaVO(ObjetoVO).PessoaJuridicaVO.InscricaoMunicipal := EditInscricaoMunicipal.Text;
        TPessoaVO(ObjetoVO).PessoaJuridicaVO.DataConstituicao := EditDataConstituicao.Date;
        TPessoaVO(ObjetoVO).PessoaJuridicaVO.Suframa := EditSuframa.Text;
        TPessoaVO(ObjetoVO).PessoaJuridicaVO.TipoRegime := Copy(ComboBoxTipoRegime.Text, 1, 1);
        TPessoaVO(ObjetoVO).PessoaJuridicaVO.Crt := Copy(ComboBoxCRT.Text, 1, 1);
      end;

      // Contatos
      TPessoaVO(ObjetoVO).ListaContatoVO := TObjectList<TContatoVO>.Create;
      CDSContato.DisableControls;
      CDSContato.First;
      while not CDSContato.Eof do
      begin
        if (CDSContatoPERSISTE.AsString = 'S') or (CDSContatoID.AsInteger = 0) then
        begin
          Contato := TContatoVO.Create;
          Contato.Id := CDSContatoID.AsInteger;
          Contato.IdPessoa := TPessoaVO(ObjetoVO).Id;
          Contato.Nome := CDSContatoNOME.AsString;
          Contato.Email := CDSContatoEMAIL.AsString;
          Contato.FoneComercial := CDSContatoFONE_COMERCIAL.AsString;
          Contato.FoneResidencial := CDSContatoFONE_RESIDENCIAL.AsString;
          Contato.FoneCelular := CDSContatoFONE_CELULAR.AsString;
          TPessoaVO(ObjetoVO).ListaContatoVO.Add(Contato);
        end;

        CDSContato.Next;
      end;
      CDSContato.EnableControls;

      // Endereços
      TPessoaVO(ObjetoVO).ListaEnderecoVO := TObjectList<TEnderecoVO>.Create;
      CDSEndereco.DisableControls;
      CDSEndereco.First;
      while not CDSEndereco.Eof do
      begin
        if (CDSEnderecoPERSISTE.AsString = 'S') or (CDSEnderecoID.AsInteger = 0) then
        begin
          Endereco := TEnderecoVO.Create;
          Endereco.Id := CDSEnderecoID.AsInteger;
          Endereco.IdPessoa := TPessoaVO(ObjetoVO).Id;
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
          Endereco.Principal := IfThen(CDSEnderecoPRINCIPAL.AsString = 'True', 'S', 'N');
          Endereco.Entrega := IfThen(CDSEnderecoENTREGA.AsString = 'True', 'S', 'N');
          Endereco.Cobranca := IfThen(CDSEnderecoCOBRANCA.AsString = 'True', 'S', 'N');
          Endereco.Correspondencia := IfThen(CDSEnderecoCORRESPONDENCIA.AsString = 'True', 'S', 'N');
          TPessoaVO(ObjetoVO).ListaEnderecoVO.Add(Endereco);
        end;

        CDSEndereco.Next;
      end;
      CDSEndereco.EnableControls;

      if StatusTela = stInserindo then
        Result := TPessoaController(ObjetoController).Insere(TPessoaVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TPessoaVO(ObjetoVO).ToJSONString <> TPessoaVO(ObjetoOldVO).ToJSONString then
        begin
          TPessoaVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TPessoaController(ObjetoController).Altera(TPessoaVO(ObjetoVO), TPessoaVO(ObjetoOldVO));
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
procedure TFPessoa.GridContatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = Vk_Return then
    GridContato.SelectedIndex := GridContato.SelectedIndex + 1;
end;

procedure TFPessoa.GridEnderecoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = Vk_Return then
    GridEndereco.SelectedIndex := GridEndereco.SelectedIndex + 1;
end;

procedure TFPessoa.CDSContatoAfterEdit(DataSet: TDataSet);
begin
  CDSContatoPERSISTE.AsString := 'S';
end;

procedure TFPessoa.CDSEnderecoAfterEdit(DataSet: TDataSet);
begin
  CDSEnderecoPERSISTE.AsString := 'S';
end;

procedure TFPessoa.CDSContatoBeforeDelete(DataSet: TDataSet);
begin
  if CDSContatoID.AsInteger > 0 then
    TContatoController.Exclui(CDSContatoID.AsInteger);
end;

procedure TFPessoa.CDSEnderecoBeforeDelete(DataSet: TDataSet);
begin
  if CDSEnderecoID.AsInteger > 0 then
    TEnderecoController.Exclui(CDSEnderecoID.AsInteger);
end;

procedure TFPessoa.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;

procedure TFPessoa.GridParaEdits;
var
  ContatosEnumerator: TEnumerator<TContatoVO>;
  EnderecosEnumerator: TEnumerator<TEnderecoVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TPessoaVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    // Pessoa
    EditNome.Text := TPessoaVO(ObjetoVO).Nome;
    ComboboxTipoPessoa.ItemIndex := IfThen(TPessoaVO(ObjetoVO).Tipo = 'F', 0, 1);
    EditEmail.Text := TPessoaVO(ObjetoVO).Email;
    EditSite.Text := TPessoaVO(ObjetoVO).Site;
    if TPessoaVO(ObjetoVO).Cliente = 'S' then
      CheckListBoxPessoa.Checked[0] := True;
    if TPessoaVO(ObjetoVO).Fornecedor = 'S' then
      CheckListBoxPessoa.Checked[1] := True;
    if TPessoaVO(ObjetoVO).Colaborador = 'S' then
      CheckListBoxPessoa.Checked[2] := True;
    if TPessoaVO(ObjetoVO).Convenio = 'S' then
      CheckListBoxPessoa.Checked[3] := True;
    if TPessoaVO(ObjetoVO).Contador = 'S' then
      CheckListBoxPessoa.Checked[4] := True;
    if TPessoaVO(ObjetoVO).Transportadora = 'S' then
      CheckListBoxPessoa.Checked[5] := True;

    // Tipo Pessoa
    if (TPessoaVO(ObjetoVO).Tipo = 'F') and (Assigned(TPessoaVO(ObjetoVO).PessoaFisicaVO)) then // Pessoa Física
    begin
      IdTipoPessoa := TPessoaVO(ObjetoVO).PessoaFisicaVO.Id;
      EditCPF.Text := TPessoaVO(ObjetoVO).PessoaFisicaVO.CPF;
      EditNascimento.Date := TPessoaVO(ObjetoVO).PessoaFisicaVO.DataNascimento;

      if TPessoaVO(ObjetoVO).PessoaFisicaVO.IdEstadoCivil > 0 then
        LComboBoxEstadoCivil.KeyValue := TPessoaVO(ObjetoVO).PessoaFisicaVO.IdEstadoCivil;

      ComboBoxRaca.ItemIndex := AnsiIndexStr(TPessoaVO(ObjetoVO).PessoaFisicaVO.Raca, ['B', 'N', 'P', 'I']);
      ComboBoxTipoSangue.ItemIndex := AnsiIndexStr(TPessoaVO(ObjetoVO).PessoaFisicaVO.TipoSangue, ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']);
      RadioGroupSexo.ItemIndex := AnsiIndexStr(TPessoaVO(ObjetoVO).PessoaFisicaVO.Sexo, ['F', 'M']);
      ComboBoxCNHCategoria.ItemIndex := AnsiIndexStr(TPessoaVO(ObjetoVO).PessoaFisicaVO.CnhCategoria, ['A', 'B', 'C', 'D', 'E']);
      ComboBoxReservistaCategoria.ItemIndex := TPessoaVO(ObjetoVO).PessoaFisicaVO.ReservistaCategoria - 1;

      EditNaturalidade.Text := TPessoaVO(ObjetoVO).PessoaFisicaVO.Naturalidade;
      EditNacionalidade.Text := TPessoaVO(ObjetoVO).PessoaFisicaVO.Nacionalidade;
      EditNomePai.Text := TPessoaVO(ObjetoVO).PessoaFisicaVO.NomePai;
      EditNomeMae.Text := TPessoaVO(ObjetoVO).PessoaFisicaVO.NomeMae;
      EditRGNumero.Text := TPessoaVO(ObjetoVO).PessoaFisicaVO.RG;
      EditRGEmissao.Date := TPessoaVO(ObjetoVO).PessoaFisicaVO.DataEmissaoRg;
      EditRGOrgaoEmissor.Text := TPessoaVO(ObjetoVO).PessoaFisicaVO.OrgaoRg;
      EditReservistaNumero.Text := TPessoaVO(ObjetoVO).PessoaFisicaVO.ReservistaNumero;
      EditCNHNumero.Text := TPessoaVO(ObjetoVO).PessoaFisicaVO.CnhNumero;
      EditCNHVencimento.Date := TPessoaVO(ObjetoVO).PessoaFisicaVO.CnhVencimento;
      EditTituloNumero.Text := TPessoaVO(ObjetoVO).PessoaFisicaVO.TituloEleitoralNumero;
      EditTituloZona.AsInteger := TPessoaVO(ObjetoVO).PessoaFisicaVO.TituloEleitoralZona;
      EditTituloSecao.AsInteger := TPessoaVO(ObjetoVO).PessoaFisicaVO.TituloEleitoralSecao;
    end
    else if (TPessoaVO(ObjetoVO).Tipo = 'J') and (Assigned(TPessoaVO(ObjetoVO).PessoaJuridicaVO)) then // Pessoa Jurídica
    begin
      IdTipoPessoa := TPessoaVO(ObjetoVO).PessoaJuridicaVO.Id;

      EditFantasia.Text := TPessoaVO(ObjetoVO).PessoaJuridicaVO.Fantasia;
      EditCNPJ.Text := TPessoaVO(ObjetoVO).PessoaJuridicaVO.Cnpj;
      EditInscricaoEstadual.Text := TPessoaVO(ObjetoVO).PessoaJuridicaVO.InscricaoEstadual;
      EditInscricaoMunicipal.Text := TPessoaVO(ObjetoVO).PessoaJuridicaVO.InscricaoMunicipal;
      EditDataConstituicao.Date := TPessoaVO(ObjetoVO).PessoaJuridicaVO.DataConstituicao;
      EditSuframa.Text := TPessoaVO(ObjetoVO).PessoaJuridicaVO.Suframa;

      ComboBoxTipoRegime.ItemIndex := AnsiIndexStr(TPessoaVO(ObjetoVO).PessoaJuridicaVO.TipoRegime, ['1', '2', '3']);
      ComboBoxCRT.ItemIndex := AnsiIndexStr(TPessoaVO(ObjetoVO).PessoaJuridicaVO.Crt, ['1', '2', '3']);
    end;

    // Contatos
    ContatosEnumerator := TPessoaVO(ObjetoVO).ListaContatoVO.GetEnumerator;
    try
      with ContatosEnumerator do
      begin
        while MoveNext do
        begin
          CDSContato.Append;

          CDSContatoID.AsInteger := Current.Id;
          CDSContatoID_PESSOA.AsInteger := Current.IdPessoa;
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
    TPessoaVO(ObjetoVO).ListaContatoVO := Nil;
    if Assigned(TPessoaVO(ObjetoOldVO)) then
      TPessoaVO(ObjetoOldVO).ListaContatoVO := Nil;

    // Endereços
    EnderecosEnumerator := TPessoaVO(ObjetoVO).ListaEnderecoVO.GetEnumerator;
    try
      with EnderecosEnumerator do
      begin
        while MoveNext do
        begin
          CDSEndereco.Append;

          CDSEnderecoID.AsInteger := Current.Id;
          CDSEnderecoID_PESSOA.AsInteger := Current.IdPessoa;
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
          CDSEnderecoPRINCIPAL.AsString := IfThen(Current.Principal = 'S', 'True', 'False');
          CDSEnderecoENTREGA.AsString := IfThen(Current.Entrega = 'S', 'True', 'False');
          CDSEnderecoCOBRANCA.AsString := IfThen(Current.Cobranca = 'S', 'True', 'False');
          CDSEnderecoCORRESPONDENCIA.AsString := IfThen(Current.Correspondencia = 'S', 'True', 'False');
          CDSEnderecoPERSISTE.AsString := 'N';

          CDSEndereco.Post;
        end;
      end;
    finally
      EnderecosEnumerator.Free;
    end;
    TPessoaVO(ObjetoVO).ListaEnderecoVO := Nil;
    TPessoaVO(ObjetoVO).ListaContatoVO := Nil;

    if Assigned(TPessoaVO(ObjetoOldVO)) then
    begin
      TPessoaVO(ObjetoOldVO).ListaEnderecoVO := Nil;
      TPessoaVO(ObjetoOldVO).ListaContatoVO := Nil;
    end;
  end;
  ConfigurarLayoutTela;
end;

{$ENDREGION}


end.
