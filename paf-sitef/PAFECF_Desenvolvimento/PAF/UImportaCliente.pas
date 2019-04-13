{*******************************************************************************
Title: T2Ti ERP
Description: Pesquisa por cliente e importação para a venda.

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
@version 1.0
*******************************************************************************}
unit UImportaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, JvDBSearchEdit, DB, Provider, DBClient, FMTBcd,
  SqlExpr, JvEnterTab, JvComponentBase;

type
  TFImportaCliente = class(TForm)
    Image1: TImage;
    GridPrincipal: TJvDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    JvEnterAsTab1: TJvEnterAsTab;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    QCliente: TSQLQuery;
    DSCliente: TDataSource;
    CDSCliente: TClientDataSet;
    EditLocaliza: TEdit;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    DSPCliente: TDataSetProvider;
    CDSClienteID: TIntegerField;
    CDSClienteID_SITUACAO_CLIENTE: TIntegerField;
    CDSClienteNOME: TStringField;
    CDSClienteCPF_CNPJ: TStringField;
    CDSClienteRG: TStringField;
    CDSClienteORGAO_RG: TStringField;
    CDSClienteINSCRICAO_ESTADUAL: TStringField;
    CDSClienteINSCRICAO_MUNICIPAL: TStringField;
    CDSClienteDATA_CADASTRO: TDateField;
    CDSClienteID_1: TIntegerField;
    CDSClienteNOME_1: TStringField;
    procedure Localiza;
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure GridPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure botaoConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    CpfCnpjPassou, QuemChamou: string;
    IdClientePassou: Integer;
    { Public declarations }
  end;

var
  FImportaCliente: TFImportaCliente;

implementation

uses UDataModule, UCaixa, UIdentificaCliente, UNotaFiscal;
{$R *.dfm}

procedure TFImportaCliente.FormActivate(Sender: TObject);
begin
  EditLocaliza.SetFocus;
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
end;

procedure TFImportaCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFImportaCliente.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFImportaCliente.Confirma;
begin
  if UCaixa.MenuAberto = 0 then
  begin
    if CDSCliente.FieldByName('CPF_CNPJ').AsString = '' then
      Application.MessageBox('Cliente sem CPF ou CNPJ cadastrado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
    else
    begin
      if QuemChamou = 'NF' then
      begin
        FNotaFiscal.editCpfCnpj.Text := CDSCliente.FieldByName('CPF_CNPJ').AsString;
        FNotaFiscal.EditNome.Text := CDSCliente.FieldByName('NOME').AsString;
        FNotaFiscal.editCodigoCliente.asinteger := CDSCliente.FieldByName('ID').AsInteger;
      end else
      begin
        FIdentificaCliente.editCpfCnpj.Text := CDSCliente.FieldByName('CPF_CNPJ').AsString;
        FIdentificaCliente.editNome.Text := CDSCliente.FieldByName('NOME').AsString;
        FIdentificaCliente.editIDCliente.AsInteger:= CDSCliente.FieldByName('ID').AsInteger;
      end;
    end;
  end;
  Close;
end;

procedure TFImportaCliente.Localiza;
var
  ProcurePor, ConsultaSQL: String;
begin
  ProcurePor := '%' + EditLocaliza.Text + '%';
  ConsultaSQL :=
    'SELECT C.ID, C.ID_SITUACAO_CLIENTE, C.NOME, S.ID, S.NOME, C.CPF_CNPJ, ' +
    'C.RG, C.ORGAO_RG, C.INSCRICAO_ESTADUAL, C.INSCRICAO_MUNICIPAL, C.DATA_CADASTRO ' +
    'FROM CLIENTE C JOIN SITUACAO_CLIENTE S ON C.ID_SITUACAO_CLIENTE=S.ID ' +
    'WHERE C.NOME LIKE ' + QuotedStr(ProcurePor);

  CDSCliente.Active := False;
  QCliente.Active := False;
  QCliente.SQL.Clear;
  QCliente.SQL.Add(ConsultaSQL);
  QCliente.Active := True;
  CDSCliente.Active := True;
end;

procedure TFImportaCliente.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    Localiza;

  if Key = 123 then
    Confirma;
end;

procedure TFImportaCliente.GridPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    EditLocaliza.SetFocus;
end;

procedure TFImportaCliente.SpeedButton1Click(Sender: TObject);
begin
  Localiza;
end;

end.
