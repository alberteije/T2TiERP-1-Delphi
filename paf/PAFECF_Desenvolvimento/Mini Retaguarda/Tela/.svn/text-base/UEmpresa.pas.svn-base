{*******************************************************************************
Title: T2Ti ERP
Description: Janela de Cadastro de Talonários e Cheques

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
unit UEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Generics.Collections,JvPageList,
  Mask, JvExMask, JvToolEdit;

type
  TFEmpresa = class(TForm)
    ActionManager: TActionManager;
    ActionInserir: TAction;
    ActionAlterar: TAction;
    ActionExcluir: TAction;
    ActionFiltroRapido: TAction;
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
    PanelEdits: TPanel;
    ActionToolBarEdits: TActionToolBar;
    ActionExportarWord: TAction;
    ActionExportarExcel: TAction;
    ActionExportarXML: TAction;
    ActionExportarCSV: TAction;
    ActionExportarHTML: TAction;
    ActionPaginaAnterior: TAction;
    ActionPaginaProxima: TAction;
    ScreenTipsManagerCadastro: TScreenTipsManager;
    ActionConsultar: TAction;
    ActionGerarCheques: TAction;
    editCNPJ: TMaskEdit;
    editTelefone: TMaskEdit;
    editFax: TMaskEdit;
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    editRazaoSocial: TLabeledEdit;
    editInscricaoEstadual: TLabeledEdit;
    editLogradouro: TLabeledEdit;
    editNumero: TJvValidateEdit;
    editBairro: TLabeledEdit;
    editComplemento: TLabeledEdit;
    editEmail: TLabeledEdit;
    editCEP: TMaskEdit;
    editCodigoIBGEMunicipio: TJvValidateEdit;
    editNomeFantasia: TLabeledEdit;
    editInscricaoEstadualST: TLabeledEdit;
    editInscricaoJuntaComercial: TLabeledEdit;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    editCRT: TLabeledEdit;
    editTipoRegime: TLabeledEdit;
    editAliquotaPIS: TMaskEdit;
    editAliquotaCOFINS: TMaskEdit;
    Label10: TLabel;
    Label11: TLabel;
    editContato: TLabeledEdit;
    Label12: TLabel;
    editCodigoIBGEUF: TJvValidateEdit;
    Label13: TLabel;
    editInscricaoMunicipal: TLabeledEdit;
    editSuframa: TLabeledEdit;
    editDataCadastro: TJvDateEdit;
    editDataInicioAtividades: TJvDateEdit;
    editDataInscricaoJuntaComercial: TJvDateEdit;
    procedure ActionCancelarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FechaFormulario;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionSalvarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEmpresa: TFEmpresa;

implementation

uses
  EmpresaVO, EmpresaController, UDataModule, UFiltro, Constantes,
  Biblioteca, ChequeVO, ULookup, ChequeController, ContaCaixaVO, ContaCaixaController,
  UMenu;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFEmpresa.ActionSalvarExecute(Sender: TObject);
var
  Empresa: TEmpresaVO;
begin
  Empresa := TEmpresaVO.create;
  Empresa.Id := FDataModule.CDSEmpresa.FieldByName('ID').AsInteger;
  Empresa.RazaoSocial := editRazaoSocial.Text;
  Empresa.NomeFantasia :=  editNomeFantasia.Text;
  Empresa.Cnpj :=  editCNPJ.Text;
  Empresa.InscricaoEstadual := editInscricaoEstadual.Text;
  Empresa.InscricaoEstadualSt := editInscricaoEstadualST.Text;
  Empresa.InscricaoMunicipal := editInscricaoMunicipal.Text;
  Empresa.InscricaoJuntaComercial := editInscricaoJuntaComercial.Text;
  Empresa.DataInscJuntaComercial := FormatDateTime('yyyy-mm-dd', editDataInscricaoJuntaComercial.Date);
  Empresa.DataCadastro := FormatDateTime('yyyy-mm-dd', editDataCadastro.Date);
  Empresa.DataInicioAtividades := FormatDateTime('yyyy-mm-dd', editDataInicioAtividades.Date);
  Empresa.Suframa := editSuframa.Text;
  Empresa.Email := editEmail.Text;
  Empresa.Crt := editCRT.Text;
  Empresa.TipoRegime := editTipoRegime.Text;
  Empresa.AliquotaPis := StrToFloat(editAliquotaPIS.Text);
  Empresa.AliquotaCofins := StrToFloat( editAliquotaCOFINS.Text);
  Empresa.Logradouro := editLogradouro.Text;
  Empresa.Numero := editNumero.Text;
  Empresa.Complemento := editComplemento.Text;
  Empresa.Cep := editCEP.Text;
  Empresa.Bairro := editBairro.Text;
  Empresa.CodigoIbgeCidade := StrToInt( editCodigoIBGEMunicipio.Text);
  Empresa.CodigoIbgeUf := strtoint( editCodigoIBGEUF.Text) ;
  Empresa.Fone := editTelefone.Text;
  Empresa.Fax := editFax.Text;
  Empresa.Contato := editContato.Text;

  TEmpresaController.Altera(Empresa);

  ShowMessage('Registro alterado!');
end;

procedure TFEmpresa.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFEmpresa.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFEmpresa.FormCreate(Sender: TObject);
begin
  //Grid principal - dos talões
  FDataModule.CDSEmpresa.Close;
  FDataModule.CDSEmpresa.FieldDefs.Clear;
  FDataModule.CDSEmpresa.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSEmpresa.FieldDefs.add('RAZAO_SOCIAL', ftString, 150);
  FDataModule.CDSEmpresa.FieldDefs.add('NOME_FANTASIA', ftString, 150);
  FDataModule.CDSEmpresa.FieldDefs.add('CNPJ', ftString, 14);
  FDataModule.CDSEmpresa.FieldDefs.add('INSCRICAO_ESTADUAL', ftString, 30);
  FDataModule.CDSEmpresa.FieldDefs.add('INSCRICAO_ESTADUAL_ST', ftString, 30);
  FDataModule.CDSEmpresa.FieldDefs.add('INSCRICAO_MUNICIPAL', ftString, 30);
  FDataModule.CDSEmpresa.FieldDefs.add('INSCRICAO_JUNTA_COMERCIAL', ftString, 30);
  FDataModule.CDSEmpresa.FieldDefs.add('DATA_INSC_JUNTA_COMERCIAL', ftString, 10);
  FDataModule.CDSEmpresa.FieldDefs.add('DATA_CADASTRO', ftString, 10);
  FDataModule.CDSEmpresa.FieldDefs.add('DATA_INICIO_ATIVIDADES', ftString, 10);
  FDataModule.CDSEmpresa.FieldDefs.add('SUFRAMA', ftString, 9);
  FDataModule.CDSEmpresa.FieldDefs.add('EMAIL', ftString, 250);
  FDataModule.CDSEmpresa.FieldDefs.add('IMAGEM_LOGOTIPO', ftString, 100);
  FDataModule.CDSEmpresa.FieldDefs.add('CRT', ftInteger);
  FDataModule.CDSEmpresa.FieldDefs.add('TIPO_REGIME', ftString, 1);
  FDataModule.CDSEmpresa.FieldDefs.add('ALIQUOTA_PIS', ftFloat);
  FDataModule.CDSEmpresa.FieldDefs.add('ALIQUOTA_COFINS', ftFloat);
  FDataModule.CDSEmpresa.FieldDefs.add('LOGRADOURO', ftString, 250);
  FDataModule.CDSEmpresa.FieldDefs.add('NUMERO', ftString, 6);
  FDataModule.CDSEmpresa.FieldDefs.add('COMPLEMENTO', ftString, 100);
  FDataModule.CDSEmpresa.FieldDefs.add('BAIRRO', ftString, 100);
  FDataModule.CDSEmpresa.FieldDefs.add('CEP', ftString, 8);
  FDataModule.CDSEmpresa.FieldDefs.add('CIDADE', ftString, 100);
  FDataModule.CDSEmpresa.FieldDefs.add('UF', ftString, 2);
  FDataModule.CDSEmpresa.FieldDefs.add('FONE', ftString, 10);
  FDataModule.CDSEmpresa.FieldDefs.add('FAX', ftString, 10);
  FDataModule.CDSEmpresa.FieldDefs.add('CONTATO', ftString, 50);
  FDataModule.CDSEmpresa.FieldDefs.add('CODIGO_IBGE_CIDADE', ftInteger);
  FDataModule.CDSEmpresa.FieldDefs.add('CODIGO_IBGE_UF', ftInteger);
  FDataModule.CDSEmpresa.CreateDataSet;

  TEmpresaController.Consulta('', 0, false);

  editRazaoSocial.Text := FDataModule.CDSEmpresa.FieldByName('RAZAO_SOCIAL').AsString;
  editNomeFantasia.Text := FDataModule.CDSEmpresa.FieldByName('NOME_FANTASIA').AsString;
  editCNPJ.Text := FDataModule.CDSEmpresa.FieldByName('CNPJ').AsString;
  editInscricaoEstadual.Text := FDataModule.CDSEmpresa.FieldByName('INSCRICAO_ESTADUAL').AsString;
  editInscricaoEstadualST.Text := FDataModule.CDSEmpresa.FieldByName('INSCRICAO_ESTADUAL_ST').AsString;
  editInscricaoMunicipal.Text := FDataModule.CDSEmpresa.FieldByName('INSCRICAO_MUNICIPAL').AsString;
  editInscricaoJuntaComercial.Text := FDataModule.CDSEmpresa.FieldByName('INSCRICAO_JUNTA_COMERCIAL').AsString;
  editDataInscricaoJuntaComercial.Text := FDataModule.CDSEmpresa.FieldByName('DATA_INSC_JUNTA_COMERCIAL').AsString;
  editDataCadastro.Text := FDataModule.CDSEmpresa.FieldByName('DATA_CADASTRO').AsString;
  editDataInicioAtividades.Text := FDataModule.CDSEmpresa.FieldByName('DATA_INICIO_ATIVIDADES').AsString;
  editSuframa.Text := FDataModule.CDSEmpresa.FieldByName('SUFRAMA').AsString;
  editEmail.Text := FDataModule.CDSEmpresa.FieldByName('EMAIL').AsString;
  editCRT.Text := FDataModule.CDSEmpresa.FieldByName('CRT').AsString;
  editTipoRegime.Text := FDataModule.CDSEmpresa.FieldByName('TIPO_REGIME').AsString ;
  editAliquotaPIS.Text := FloatToStr(FDataModule.CDSEmpresa.FieldByName('ALIQUOTA_PIS').AsFloat);
  editAliquotaCOFINS.Text := FloatToStr(FDataModule.CDSEmpresa.FieldByName('ALIQUOTA_COFINS').AsFloat);
  editLogradouro.Text := FDataModule.CDSEmpresa.FieldByName('LOGRADOURO').AsString;
  editNumero.Text := FDataModule.CDSEmpresa.FieldByName('NUMERO').AsString;
  editComplemento.Text := FDataModule.CDSEmpresa.FieldByName('COMPLEMENTO').AsString;
  editCEP.Text := FDataModule.CDSEmpresa.FieldByName('CEP').AsString;
  editBairro.Text := FDataModule.CDSEmpresa.FieldByName('BAIRRO').AsString;
  editCodigoIBGEMunicipio.Text := FDataModule.CDSEmpresa.FieldByName('CODIGO_IBGE_CIDADE').AsString;
  editCodigoIBGEUF.Text := FDataModule.CDSEmpresa.FieldByName('CODIGO_IBGE_UF').AsString;
  editTelefone.Text := FDataModule.CDSEmpresa.FieldByName('FONE').AsString;
  editFax.Text := FDataModule.CDSEmpresa.FieldByName('FAX').AsString;
  editContato.Text := FDataModule.CDSEmpresa.FieldByName('CONTATO').AsString;

end;

procedure TFEmpresa.ActionCancelarExecute(Sender: TObject);
begin
FechaFormulario;
end;

end.
