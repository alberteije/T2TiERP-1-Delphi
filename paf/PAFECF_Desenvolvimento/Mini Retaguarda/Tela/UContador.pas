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
unit UContador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Generics.Collections,JvPageList,
  Mask;

type
  TFContador = class(TForm)
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
    Label5: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    editCPF: TMaskEdit;
    editNome: TLabeledEdit;
    editInscricaoCRC: TLabeledEdit;
    editLogradouro: TLabeledEdit;
    editNumero: TJvValidateEdit;
    editBairro: TLabeledEdit;
    editUF: TLabeledEdit;
    editComplemento: TLabeledEdit;
    editEmail: TLabeledEdit;
    editCEP: TMaskEdit;
    editMunicipio: TJvValidateEdit;
    Label7: TLabel;
    procedure ActionCancelarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FechaFormulario;
    procedure LimparCampos;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionSalvarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FContador: TFContador;

implementation

uses
  ContadorVO, ContadorController, UDataModule, UFiltro, Constantes,
  Biblioteca, ChequeVO, ULookup, ChequeController, ContaCaixaVO, ContaCaixaController,
  UMenu;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;

{$R *.dfm}

procedure TFContador.ActionSalvarExecute(Sender: TObject);
var
  Contador: TContadorVO;
begin
  Contador := TContadorVO.create;
  Contador.Id := FDataModule.CDSContador.FieldByName('ID').AsInteger;
  Contador.Nome := editNome.Text;
  Contador.Cpf := editCPF.Text;
  Contador.Cnpj := editCNPJ.Text;
  Contador.InscricaoCrc := editInscricaoCRC.Text;
  Contador.Fone := editTelefone.Text;
  Contador.Fax := editFax.Text;
  Contador.Logradouro := editLogradouro.Text;
  Contador.Numero := editNumero.Value;
  Contador.Complemento := editComplemento.Text;
  Contador.Bairro := editBairro.Text;
  Contador.Cep := editCEP.Text;
  Contador.Uf := editUF.Text;
  Contador.Email := editEmail.Text;
  Contador.CodigoMunicipio := editMunicipio.Value;

  TContadorController.Altera(Contador, ' ', 0);

  ShowMessage('Registro alterado!');
end;

procedure TFContador.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFContador.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFContador.FormCreate(Sender: TObject);
begin
  //Grid principal - dos talões
  FDataModule.CDSContador.Close;
  FDataModule.CDSContador.FieldDefs.Clear;
  FDataModule.CDSContador.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSContador.FieldDefs.add('CPF', ftString, 11);
  FDataModule.CDSContador.FieldDefs.add('CNPJ', ftString, 14);
  FDataModule.CDSContador.FieldDefs.add('NOME', ftString, 100);
  FDataModule.CDSContador.FieldDefs.add('INSCRICAO_CRC', ftString, 15);
  FDataModule.CDSContador.FieldDefs.add('FONE', ftString, 15);
  FDataModule.CDSContador.FieldDefs.add('FAX', ftString, 15);
  FDataModule.CDSContador.FieldDefs.add('LOGRADOURO', ftString, 100);
  FDataModule.CDSContador.FieldDefs.add('NUMERO', ftInteger);
  FDataModule.CDSContador.FieldDefs.add('COMPLEMENTO', ftString, 100);
  FDataModule.CDSContador.FieldDefs.add('BAIRRO', ftString, 30);
  FDataModule.CDSContador.FieldDefs.add('CEP', ftString, 8);
  FDataModule.CDSContador.FieldDefs.add('CODIGO_MUNICIPIO', ftInteger);
  FDataModule.CDSContador.FieldDefs.add('UF', ftString, 2);
  FDataModule.CDSContador.FieldDefs.add('EMAIL', ftString, 250);
  FDataModule.CDSContador.CreateDataSet;

  TContadorController.Consulta('', 0, false);

  editNome.Text := FDataModule.CDSContador.FieldByName('NOME').AsString;
  editCPF.Text := FDataModule.CDSContador.FieldByName('CPF').AsString;
  editInscricaoCRC.Text := FDataModule.CDSContador.FieldByName('INSCRICAO_CRC').AsString;
  editTelefone.Text := FDataModule.CDSContador.FieldByName('FONE').AsString;
  editFax.Text := FDataModule.CDSContador.FieldByName('FAX').AsString;
  editLogradouro.Text := FDataModule.CDSContador.FieldByName('LOGRADOURO').AsString;
  editNumero.Text := FDataModule.CDSContador.FieldByName('NUMERO').AsString;
  editComplemento.Text := FDataModule.CDSContador.FieldByName('COMPLEMENTO').AsString;
  editBairro.Text := FDataModule.CDSContador.FieldByName('BAIRRO').AsString;
  editCEP.Text := FDataModule.CDSContador.FieldByName('CEP').AsString;
  editMunicipio.Text := FDataModule.CDSContador.FieldByName('CODIGO_MUNICIPIO').AsString;
  editUF.Text := FDataModule.CDSContador.FieldByName('UF').AsString;
  editEmail.Text := FDataModule.CDSContador.FieldByName('EMAIL').AsString;

end;

procedure TFContador.ActionCancelarExecute(Sender: TObject);
begin
FechaFormulario;
end;

procedure TFContador.LimparCampos;
begin
  editCPF.Clear;
end;

end.
