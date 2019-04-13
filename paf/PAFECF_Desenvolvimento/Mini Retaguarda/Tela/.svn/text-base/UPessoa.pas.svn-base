{*******************************************************************************
Title: T2Ti ERP
Description: Janela de cadastro das Pessoas

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

@author Albert Eije (T2Ti.COM)
@version 1.1
*******************************************************************************}
unit UPessoa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Mask,
  JvExMask, JvToolEdit, Generics.Collections, JvPageList;

type
  TFPessoa = class(TForm)
    ActionManager: TActionManager;
    ActionInserir: TAction;
    ActionAlterar: TAction;
    ActionExcluir: TAction;
    ActionFiltroRapido: TAction;
    PanelToolBar: TPanel;
    ActionToolBarGrid: TActionToolBar;
    ActionCancelar: TAction;
    ActionSalvar: TAction;
    ActionImprimir: TAction;
    ActionPrimeiro: TAction;
    ActionUltimo: TAction;
    ActionAnterior: TAction;
    ActionProximo: TAction;
    ActionSair: TAction;
    ActionExportar: TAction;
    ActionFiltrar: TAction;
    PanelGrid: TPanel;
    PanelEdits: TPanel;
    BevelEdits: TBevel;
    Grid: TJvDBUltimGrid;
    ActionToolBarEdits: TActionToolBar;
    ActionExportarWord: TAction;
    ActionExportarExcel: TAction;
    ActionExportarXML: TAction;
    ActionExportarCSV: TAction;
    ActionExportarHTML: TAction;
    ActionPaginaAnterior: TAction;
    ActionPaginaProxima: TAction;
    ScreenTipsManagerCadastro: TScreenTipsManager;
    PanelFiltroRapido: TPanel;
    EditCriterioRapido: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    ComboBoxCampos: TComboBox;
    Label1: TLabel;
    ActionConsultar: TAction;
    EditNomeSituacaoPessoa: TLabeledEdit;
    EditIdSituacaoPessoa: TJvValidateEdit;
    Label6: TLabel;
    EditNome: TLabeledEdit;
    EditCpfCnpj: TLabeledEdit;
    EditFone01: TMaskEdit;
    Label3: TLabel;
    EditFone02: TMaskEdit;
    Label4: TLabel;
    EditFantasia: TLabeledEdit;
    EditEMail: TLabeledEdit;
    RadioFisicaJuridica: TRadioGroup;
    EditInscricaoEstadual: TLabeledEdit;
    EditInscricaoMunicipal: TLabeledEdit;
    EditContato: TLabeledEdit;
    EditCelular: TMaskEdit;
    LabelCelular: TLabel;
    EditRg: TLabeledEdit;
    EditOrgaoRg: TLabeledEdit;
    EditDataEmissaoRg: TJvDateEdit;
    Label2: TLabel;
    RadioSexo: TRadioGroup;
    GridEnderecos: TJvDBUltimGrid;
    RadioTipoPessoa: TRadioGroup;
    procedure ActionInserirExecute(Sender: TObject);
    procedure ActionAlterarExecute(Sender: TObject);
    procedure ActionExcluirExecute(Sender: TObject);
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionSalvarExecute(Sender: TObject);
    procedure ActionImprimirExecute(Sender: TObject);
    procedure ActionFiltrarExecute(Sender: TObject);
    procedure ActionPrimeiroExecute(Sender: TObject);
    procedure ActionUltimoExecute(Sender: TObject);
    procedure ActionAnteriorExecute(Sender: TObject);
    procedure ActionProximoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FechaFormulario;
    procedure LimparCampos;
    procedure GridParaEdits;
    procedure GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure ActionExportarWordExecute(Sender: TObject);
    procedure ActionExportarExecute(Sender: TObject);
    procedure ActionPaginaAnteriorExecute(Sender: TObject);
    procedure ActionPaginaProximaExecute(Sender: TObject);
    procedure VerificarPaginacao;
    procedure ActionExportarHTMLExecute(Sender: TObject);
    procedure ActionExportarCSVExecute(Sender: TObject);
    procedure ActionExportarXMLExecute(Sender: TObject);
    procedure ActionExportarExcelExecute(Sender: TObject);
    procedure ActionFiltroRapidoExecute(Sender: TObject);
    procedure ActionConsultarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditIdSituacaoPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridEnderecosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActionSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPessoa: TFPessoa;

implementation

uses
  PessoaVO, PessoaController, UDataModule, UFiltro, Constantes,
  Biblioteca, ULookup, PessoaEnderecoVO, PessoaEnderecoController,
  SituacaoPessoaVO, SituacaoPessoaController, TipoEnderecoVO,
  TipoEnderecoController, UMenu;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFPessoa.FechaFormulario;
begin
    if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFPessoa.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFPessoa.FormCreate(Sender: TObject);
begin
  // Grid Principal
  FDataModule.CDSPessoa.Close;
  FDataModule.CDSPessoa.FieldDefs.Clear;
  FDataModule.CDSPessoa.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSPessoa.FieldDefs.add('NOME', ftString, 150);
  FDataModule.CDSPessoa.FieldDefs.add('FANTASIA', ftString, 150);
  FDataModule.CDSPessoa.FieldDefs.add('EMAIL', ftString, 250);
  FDataModule.CDSPessoa.FieldDefs.add('TIPO', ftString, 1);
  FDataModule.CDSPessoa.FieldDefs.add('FISICA_JURIDICA', ftString, 1);
  FDataModule.CDSPessoa.FieldDefs.add('CPF_CNPJ', ftString, 14);
  FDataModule.CDSPessoa.FieldDefs.add('INSCRICAO_ESTADUAL', ftString, 14);
  FDataModule.CDSPessoa.FieldDefs.add('INSCRICAO_MUNICIPAL', ftString, 14);
  FDataModule.CDSPessoa.FieldDefs.add('CONTATO', ftString, 50);
  FDataModule.CDSPessoa.FieldDefs.add('FONE1', ftString, 10);
  FDataModule.CDSPessoa.FieldDefs.add('FONE2', ftString, 10);
  FDataModule.CDSPessoa.FieldDefs.add('CELULAR', ftString, 10);
  FDataModule.CDSPessoa.FieldDefs.add('RG', ftString, 30);
  FDataModule.CDSPessoa.FieldDefs.add('ORGAO_RG', ftString, 30);
  FDataModule.CDSPessoa.FieldDefs.add('DATA_EMISSAO_RG', ftString, 10);
  FDataModule.CDSPessoa.FieldDefs.add('SEXO', ftString, 1);
  FDataModule.CDSPessoa.FieldDefs.add('DATA_CADASTRO', ftString, 10);
  FDataModule.CDSPessoa.FieldDefs.add('NOME_SITUACAO_PESSOA', ftString, 150);
  FDataModule.CDSPessoa.FieldDefs.add('ID_SITUACAO_PESSOA', ftInteger);
  FDataModule.CDSPessoa.CreateDataSet;

  // Definição dos títulos dos cabeçalhos e largura das colunas
  Grid.Columns[0].Title.Caption := 'Id';
  Grid.Columns[1].Title.Caption := 'Nome';
  Grid.Columns[2].Title.Caption := 'Fantasia';
  Grid.Columns[3].Title.Caption := 'E-Mail';
  Grid.Columns[4].Title.Caption := 'Tipo';
  Grid.Columns[5].Title.Caption := 'Fis ou Jur';
  Grid.Columns[6].Title.Caption := 'CPF / CNPJ';
  Grid.Columns[7].Title.Caption := 'Inscrição Estadual';
  Grid.Columns[8].Title.Caption := 'Inscrição Municipal';
  Grid.Columns[9].Title.Caption := 'Contato';
  Grid.Columns[10].Title.Caption := 'Fone 01';
  Grid.Columns[11].Title.Caption := 'Fone 02';
  Grid.Columns[12].Title.Caption := 'Celular';
  Grid.Columns[13].Title.Caption := 'RG';
  Grid.Columns[14].Title.Caption := 'Órgão RG';
  Grid.Columns[15].Title.Caption := 'Data Emissão RG';
  Grid.Columns[16].Title.Caption := 'Sexo';
  Grid.Columns[17].Title.Caption := 'Data Cadastro';
  Grid.Columns[18].Title.Caption := 'Situação';
  Grid.Columns[1].Width := 300;
  Grid.Columns[2].Width := 300;
  Grid.Columns[3].Width := 300;
  //Colunas invisíveis
  Grid.Columns[19].Visible := False;
  //
  //Grid secundária - dos endereços
  FDataModule.CDSPessoaEndereco.Close;
  FDataModule.CDSPessoaEndereco.FieldDefs.Clear;
  FDataModule.CDSPessoaEndereco.FieldDefs.add('LOGRADOURO', ftString, 250);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('NUMERO', ftString, 6);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('COMPLEMENTO', ftString, 50);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('CEP', ftString, 8);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('BAIRRO', ftString, 100);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('CIDADE', ftString, 100);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('UF', ftString, 2);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('CODIGO_IBGE_CIDADE', ftInteger);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('CODIGO_IBGE_UF', ftInteger);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('ID_TIPO_ENDERECO', ftInteger);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('ID_PESSOA', ftInteger);
  FDataModule.CDSPessoaEndereco.FieldDefs.add('PERSISTE', ftString, 1);
  FDataModule.CDSPessoaEndereco.CreateDataSet;
  //Definição dos títulos dos cabeçalhos e largura das colunas
  GridEnderecos.Columns[0].Title.Caption := 'Logradouro';
  GridEnderecos.Columns[1].Title.Caption := 'Número';
  GridEnderecos.Columns[2].Title.Caption := 'Complemento';
  GridEnderecos.Columns[3].Title.Caption := 'CEP';
  GridEnderecos.Columns[4].Title.Caption := 'Bairro';
  GridEnderecos.Columns[5].Title.Caption := 'Cidade';
  GridEnderecos.Columns[6].Title.Caption := 'UF';
  GridEnderecos.Columns[7].Title.Caption := 'IBGE Cidade';
  GridEnderecos.Columns[8].Title.Caption := 'IBGE UF';
  GridEnderecos.Columns[9].Title.Caption := 'Id Tipo Endereço';
  GridEnderecos.Columns[0].Width := 250;
  GridEnderecos.Columns[2].Width := 200;
  GridEnderecos.Columns[4].Width := 200;
  GridEnderecos.Columns[5].Width := 200;
  GridEnderecos.Columns[6].Width := 20;
  //Colunas nao visiveis
  GridEnderecos.Columns.Items[10].Visible := False;
  GridEnderecos.Columns.Items[11].Visible := False;
  GridEnderecos.Columns.Items[12].Visible := False;
  //
  Pagina := 0;
  VerificarPaginacao;
  //
  FDataModule.CDSPessoa.GetFieldNames(ComboBoxCampos.Items);
  ComboBoxCampos.ItemIndex := 0;
end;

procedure TFPessoa.ActionInserirExecute(Sender: TObject);
begin
  PanelEdits.BringToFront;
  EditIdSituacaoPessoa.SetFocus;
  ActionToolBarGrid.Enabled := False;
  Operacao := 1;
end;

procedure TFPessoa.ActionAlterarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  if Trim(FDataModule.CDSPessoa.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    PanelEdits.BringToFront;
    EditIdSituacaoPessoa.SetFocus;
    ActionToolBarGrid.Enabled := False;
    GridParaEdits;
    Operacao := 2;
    //Carrega itens
    FiltroLocal := 'ID_PESSOA = '+ FDataModule.CDSPessoa.FieldByName('ID').AsString;
    TPessoaEnderecoController.Consulta(trim(FiltroLocal), 0, False);
  end;
end;

procedure TFPessoa.ActionExcluirExecute(Sender: TObject);
begin
  if Trim(FDataModule.CDSPessoa.FieldByName('ID').AsString) = '' then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      TPessoaController.Exclui(FDataModule.CDSPessoa.FieldByName('ID').AsInteger);
      TPessoaController.Consulta(Filtro, Pagina, False);
    end;
  end;
end;

procedure TFPessoa.ActionSairExecute(Sender: TObject);
begin
FechaFormulario;
end;

procedure TFPessoa.ActionSalvarExecute(Sender: TObject);
var
  LinhaAtual : TBookMark;
  Pessoa : TPessoaVO;
  PessoaEndereco: TPessoaEnderecoVO;
  ListaEndereco: TObjectList<TPessoaEnderecoVO>;
begin
  Pessoa := TPessoaVO.Create;
  Pessoa.IdSituacaoPessoa := EditIdSituacaoPessoa.AsInteger;
  Pessoa.Nome := EditNome.Text;
  Pessoa.Fantasia := EditFantasia.Text;
  Pessoa.Email := EditEMail.Text;

  if RadioTipoPessoa.ItemIndex = 0 then
    Pessoa.Tipo := 'C'
  else if RadioTipoPessoa.ItemIndex = 1 then
    Pessoa.Tipo := 'F';

  if RadioFisicaJuridica.ItemIndex = 0 then
    Pessoa.Tipo := 'F'
  else if RadioFisicaJuridica.ItemIndex = 1 then
    Pessoa.Tipo := 'J';

  if RadioSexo.ItemIndex = 0 then
    Pessoa.Tipo := 'M'
  else if RadioSexo.ItemIndex = 1 then
    Pessoa.Tipo := 'F';

  Pessoa.CpfCnpj := EditCpfCnpj.Text;
  Pessoa.InscricaoEstadual := EditInscricaoEstadual.Text;
  Pessoa.InscricaoMunicipal := EditInscricaoMunicipal.Text;
  Pessoa.Contato := EditContato.Text;
  Pessoa.Fone1 := EditFone01.Text;
  Pessoa.Fone2 := EditFone02.Text;
  Pessoa.Celular := EditCelular.Text;
  Pessoa.Rg := EditRg.Text;
  Pessoa.OrgaoRg := EditOrgaoRg.Text;
  Pessoa.DataEmissaoRg := FormatDateTime('yyyy-mm-dd', EditDataEmissaoRg.Date);
  Pessoa.DataCadastro := FormatDateTime('yyyy-mm-dd', Now);

  //popula a lista com os endereços
  ListaEndereco := TObjectList<TPessoaEnderecoVO>.Create(True);
  FDataModule.CDSPessoaEndereco.First;
  while not FDataModule.CDSPessoaEndereco.Eof do
  begin
    if FDataModule.CDSPessoaEndereco.FieldByName('PERSISTE').AsString = 'S' then
    begin
      PessoaEndereco := TPessoaEnderecoVO.Create;
      PessoaEndereco.Id := FDataModule.CDSPessoaEndereco.FieldByName('ID').AsInteger;
      PessoaEndereco.IdPessoa := FDataModule.CDSPessoa.FieldByName('ID').AsInteger;
      PessoaEndereco.IdTipoEndereco := FDataModule.CDSPessoaEndereco.FieldByName('ID_TIPO_ENDERECO').AsInteger;
      PessoaEndereco.Logradouro := FDataModule.CDSPessoaEndereco.FieldByName('LOGRADOURO').AsString;
      PessoaEndereco.Numero := FDataModule.CDSPessoaEndereco.FieldByName('NUMERO').AsString;
      PessoaEndereco.Complemento := FDataModule.CDSPessoaEndereco.FieldByName('COMPLEMENTO').AsString;
      PessoaEndereco.Cep := FDataModule.CDSPessoaEndereco.FieldByName('CEP').AsString;
      PessoaEndereco.Bairro := FDataModule.CDSPessoaEndereco.FieldByName('BAIRRO').AsString;
      PessoaEndereco.Cidade := FDataModule.CDSPessoaEndereco.FieldByName('CIDADE').AsString;
      PessoaEndereco.Uf := FDataModule.CDSPessoaEndereco.FieldByName('UF').AsString;
      PessoaEndereco.CodigoIbgeCidade := FDataModule.CDSPessoaEndereco.FieldByName('CODIGO_IBGE_CIDADE').AsInteger;
      PessoaEndereco.CodigoIbgeUf := FDataModule.CDSPessoaEndereco.FieldByName('CODIGO_IBGE_UF').AsInteger;
      ListaEndereco.Add(PessoaEndereco);
    end;
    FDataModule.CDSPessoaEndereco.Next;
  end;

  if Operacao = 1 then
    TPessoaController.Insere(Pessoa, ListaEndereco)
  else if Operacao = 2 then
  begin
  	Pessoa.ID := FDataModule.CDSPessoa.FieldByName('ID').AsInteger;
    LinhaAtual := Grid.DataSource.DataSet.GetBookmark;
    TPessoaController.Altera(Pessoa, ListaEndereco, Filtro, Pagina);
    Grid.DataSource.DataSet.GotoBookmark(LinhaAtual);
    Grid.DataSource.DataSet.FreeBookmark(LinhaAtual);
  end;

  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  Grid.SetFocus;
end;

procedure TFPessoa.ActionCancelarExecute(Sender: TObject);
begin
  PanelGrid.BringToFront;
  ActionToolBarGrid.Enabled := True;
  LimparCampos;
  ActionSalvar.Enabled := True;
  Grid.SetFocus;
end;

procedure TFPessoa.ActionConsultarExecute(Sender: TObject);
var
  FiltroLocal: String;
begin
  PanelEdits.BringToFront;
  EditIdSituacaoPessoa.SetFocus;
  ActionToolBarGrid.Enabled := False;
  GridParaEdits;
  ActionSalvar.Enabled := False;
  Operacao := 3;
  //Carrega itens
  FiltroLocal := 'ID_PESSOA = '+ FDataModule.CDSPessoa.FieldByName('ID').AsString;
  TPessoaEnderecoController.Consulta(trim(FiltroLocal), 0, False);
end;

procedure TFPessoa.ActionFiltroRapidoExecute(Sender: TObject);
begin
  if Trim(EditCriterioRapido.Text) = '' then
  begin
    Application.MessageBox('Não existe critério para consulta.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    Pagina := 0;
    Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
    TPessoaController.Consulta(trim(Filtro), Pagina, False);
    VerificarPaginacao;
  end;
end;

procedure TFPessoa.EditIdSituacaoPessoaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TSituacaoPessoaVO.Create;
    ULookup.ObjetoController := TSituacaoPessoaController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'NOME';
    FLookup.ShowModal;
    EditIdSituacaoPessoa.Text := ULookup.CampoRetorno1;
    EditNomeSituacaoPessoa.Text := ULookup.CampoRetorno2;
    EditIdSituacaoPessoa.SetFocus;
  end;
end;

procedure TFPessoa.GridEnderecosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.ObjetoVO := TTipoEnderecoVO.Create;
    ULookup.ObjetoController := TTipoEnderecoController.Create;
    ULookup.CampoRetorno1 := 'ID';
    ULookup.CampoRetorno2 := 'NOME';
    FLookup.ShowModal;
    FDataModule.CDSPessoaEndereco.Edit;
    FDataModule.CDSPessoaEndereco.FieldByName('ID_TIPO_ENDERECO').AsString := ULookup.CampoRetorno1;
    FDataModule.CDSPessoaEndereco.Post;
    GridEnderecos.SetFocus;
  end;
end;

procedure TFPessoa.ActionFiltrarExecute(Sender: TObject);
var
  Pessoa : TPessoaVO;
  I : Integer;
begin
  Filtro := '';
  Pessoa := TPessoaVO.Create;
  Application.CreateForm(TFFiltro, FFiltro);
  FFiltro.QuemChamou := Self.Name;
  FFiltro.CDSUtilizado := FDataModule.CDSPessoa;
  try
    if (FFiltro.ShowModal = MROK) then
    begin
      for I := 0 to FFiltro.MemoSQL.Lines.Count - 1 do
        Filtro := Filtro + FFiltro.MemoSQL.Lines.Strings[I];
      if trim(Filtro) <> '' then
        TPessoaController.Consulta(trim(Filtro), Pagina, False);
    end;
  finally
    Pagina := 0;
    VerificarPaginacao;
    if Assigned(FFiltro) then
      FFiltro.Free;
  end;
end;

procedure TFPessoa.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSPessoa.First;
end;

procedure TFPessoa.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSPessoa.Last;
end;

procedure TFPessoa.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSPessoa.Prior;
end;

procedure TFPessoa.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSPessoa.Next;
end;

procedure TFPessoa.ActionPaginaAnteriorExecute(Sender: TObject);
begin
  Pagina := Pagina - TConstantes.QUANTIDADE_POR_PAGINA;
  TPessoaController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFPessoa.ActionPaginaProximaExecute(Sender: TObject);
begin
  Pagina := Pagina + TConstantes.QUANTIDADE_POR_PAGINA;
  TPessoaController.Consulta(trim(Filtro), Pagina, False);
  VerificarPaginacao;
end;

procedure TFPessoa.GridParaEdits;
begin
  EditIdSituacaoPessoa.Text := FDataModule.CDSPessoa.FieldByName('ID_SITUACAO_PESSOA').AsString;
  EditNomeSituacaoPessoa.Text := FDataModule.CDSPessoa.FieldByName('NOME_SITUACAO_PESSOA').AsString;
  EditNome.Text := FDataModule.CDSPessoa.FieldByName('NOME').AsString;
  EditFantasia.Text := FDataModule.CDSPessoa.FieldByName('FANTASIA').AsString;
  EditEMail.Text := FDataModule.CDSPessoa.FieldByName('EMAIL').AsString;

  if FDataModule.CDSPessoa.FieldByName('TIPO').AsString = 'C' then
    RadioTipoPessoa.ItemIndex := 0
  else
    RadioTipoPessoa.ItemIndex := 1;

  if FDataModule.CDSPessoa.FieldByName('FISICA_JURIDICA').AsString = 'F' then
    RadioFisicaJuridica.ItemIndex := 0
  else
    RadioFisicaJuridica.ItemIndex := 1;

  EditCpfCnpj.Text := FDataModule.CDSPessoa.FieldByName('CPF_CNPJ').AsString;
  EditInscricaoEstadual.Text := FDataModule.CDSPessoa.FieldByName('INSCRICAO_ESTADUAL').AsString;
  EditInscricaoMunicipal.Text := FDataModule.CDSPessoa.FieldByName('INSCRICAO_MUNICIPAL').AsString;
  EditContato.Text := FDataModule.CDSPessoa.FieldByName('CONTATO').AsString;
  EditFone01.Text := FDataModule.CDSPessoa.FieldByName('FONE1').AsString;
  EditFone02.Text := FDataModule.CDSPessoa.FieldByName('FONE2').AsString;
  EditCelular.Text := FDataModule.CDSPessoa.FieldByName('CELULAR').AsString;
  EditRg.Text := FDataModule.CDSPessoa.FieldByName('RG').AsString;
  EditOrgaoRg.Text := FDataModule.CDSPessoa.FieldByName('ORGAO_RG').AsString;
  EditDataEmissaoRg.Text := FDataModule.CDSPessoa.FieldByName('DATA_EMISSAO_RG').AsString;

  if FDataModule.CDSPessoa.FieldByName('SEXO').AsString = 'M' then
    RadioSexo.ItemIndex := 0
  else
    RadioSexo.ItemIndex := 1;
end;

procedure TFPessoa.LimparCampos;
begin
  EditIdSituacaoPessoa.Clear;
  EditNomeSituacaoPessoa.Clear;
  EditNome.Clear;
  EditFantasia.Clear;
  EditEMail.Clear;
  EditCpfCnpj.Clear;
  EditInscricaoEstadual.Clear;
  EditInscricaoMunicipal.Clear;
  EditContato.Clear;
  EditFone01.Clear;
  EditFone02.Clear;
  EditCelular.Clear;
  EditRg.Clear;
  EditOrgaoRg.Clear;
  EditDataEmissaoRg.Clear;
  FDataModule.CDSPessoaEndereco.EmptyDataSet;
end;

procedure TFPessoa.VerificarPaginacao;
begin
  if Pagina = 0 then
    ActionPaginaAnterior.Enabled := False
  else
    ActionPaginaAnterior.Enabled := True;
  //
  if FDataModule.CDSPessoa.RecordCount < TConstantes.QUANTIDADE_POR_PAGINA then
    ActionPaginaProxima.Enabled := False
  else
    ActionPaginaProxima.Enabled := True;
end;

procedure TFPessoa.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
var
  IxDName: string;
  i: integer;
  Fields, DescFields: string;
begin
  try
    Fields := '';
    DescFields := '';
    for i := 0 to Length(FieldsToSort) - 1 do
    begin
      Fields := Fields + FieldsToSort[i].Name + ';';
      if not FieldsToSort[i].Order then
        DescFields := DescFields + FieldsToSort[i].Name + ';';
    end;
    Fields := Copy(Fields, 1, Length(Fields)-1);
    DescFields := Copy(DescFields, 1, Length(DescFields)-1);

    IxDName := IntToStr(Length(FieldsToSort)) + '_' + FormatDateTime('hhmmssz',Now);
    FDataModule.CDSPessoa.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSPessoa.IndexDefs.Update;
    FDataModule.CDSPessoa.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFPessoa.ActionExportarCSVExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos CSV (Valores Separados por Vírgula) (*.CSV)|*.CSV';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarCSV.FileName := NomeArquivo + '.csv';
      FDataModule.ExportarCSV.Grid := Grid;
      FDataModule.ExportarCSV.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFPessoa.ActionExportarExcelExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos do Excel (*.XLS)|*.XLS';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarExcel.FileName := NomeArquivo + '.xls';
      FDataModule.ExportarExcel.Grid := Grid;
      FDataModule.ExportarExcel.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFPessoa.ActionExportarHTMLExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos HTML (*.HTML)|*.HTML';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarHTML.FileName := NomeArquivo + '.html';
      FDataModule.ExportarHTML.Grid := Grid;
      FDataModule.ExportarHTML.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFPessoa.ActionExportarWordExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos do Word (*.DOC)|*.DOC';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarWord.FileName := NomeArquivo + '.doc';
      FDataModule.ExportarWord.Grid := Grid;
      FDataModule.ExportarWord.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR)
  end;
end;

procedure TFPessoa.ActionExportarXMLExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos XML (*.XML)|*.XML';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := ExtractFileName(FDataModule.SaveDialog.FileName);
      FDataModule.ExportarXML.FileName := NomeArquivo + '.xml';
      FDataModule.ExportarXML.Grid := Grid;
      FDataModule.ExportarXML.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFPessoa.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFPessoa.ActionImprimirExecute(Sender: TObject);
begin
//
end;

end.
