{ *******************************************************************************
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

  @author Albert Eije (T2Ti.COM) | Eri Brito
  @version 1.0
  ******************************************************************************* }
unit UProcuraCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, JvDBSearchEdit, DB, Provider, DBClient, FMTBcd,
  SqlExpr, JvExControls, Biblioteca, JvComponentBase, JvDBUltimGrid;

type
  TFProcuraCliente = class(TForm)
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    QCliente: TSQLQuery;
    DSCliente: TDataSource;
    CDSCliente: TClientDataSet;
    Label2: TLabel;
    DSPCliente: TDataSetProvider;
    GroupBox6: TGroupBox;
    GridPrincipal: TJvDBUltimGrid;
    GroupBox3: TGroupBox;
    Image1: TImage;
    EditLocaliza: TEdit;
    procedure Localiza;
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure GridPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditLocalizaChange(Sender: TObject);
    procedure EditLocalizaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditLocalizaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridPrincipalDblClick(Sender: TObject);
  private
    { Private declarations }
  public
  CpfCnpjPassou: string;
  IdClientePassou: Integer;
  NomePassou : String;
  end;

var
  FProcuraCliente: TFProcuraCliente;

implementation

uses UDataModule;
{$R *.dfm}

procedure TFProcuraCliente.FormActivate(Sender: TObject);
begin
  EditLocaliza.SetFocus;
end;

procedure TFProcuraCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFProcuraCliente.FormCreate(Sender: TObject);
begin
  QCliente.SQLConnection := FDataModule.Conexao;
end;

procedure TFProcuraCliente.botaoConfirmaClick(Sender: TObject);
begin
  if GridPrincipal.DataSource.DataSet.RecordCount > 0 then
    Confirma
  else
  begin
    ShowMessage('Você deve pesquisar um cliente!!!');
    EditLocaliza.SetFocus;
  end;
end;

procedure TFProcuraCliente.Confirma;
begin
  CpfCnpjPassou   :=  CDSCliente.FieldByName('CPF_CNPJ').AsString;
  IdClientePassou :=  CDSCliente.FieldByName('ID').AsInteger;
  NomePassou      :=  CDSCliente.FieldByName('NOME').AsString;
  Close;
end;

procedure TFProcuraCliente.EditLocalizaChange(Sender: TObject);
begin
  Localiza;
end;

procedure TFProcuraCliente.EditLocalizaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN then
    GridPrincipal.SetFocus;
  if Key = VK_UP then
    Perform(WM_NEXTDLGCTL, 1, 0);
  if Key = VK_ESCAPE then
    Close;
  if Key = 13 then
    confirma;
end;

procedure TFProcuraCliente.EditLocalizaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // F2 Chama procedure Localiza
  if Key = 113 then
    Localiza;
end;

procedure TFProcuraCliente.Localiza;
var
  ProcurePor, ConsultaSQL: String;
begin
  ProcurePor := EditLocaliza.Text + '%';
  ConsultaSQL :=
    'SELECT P.ID_SITUACAO_PESSOA, P.ID, P.NOME, S.ID, S.NOME, P.CPF_CNPJ, '+
    'P.RG, P.ORGAO_RG, P.INSCRICAO_ESTADUAL, P.INSCRICAO_MUNICIPAL '+
    'FROM PESSOA P JOIN SITUACAO_PESSOA S ON P.ID_SITUACAO_PESSOA=S.ID '+
    'WHERE P.NOME LIKE ' + QuotedStr(ProcurePor);

  CDSCliente.Active := False;
  QCliente.Active := False;
  QCliente.SQL.Clear;
  QCliente.SQL.Text := ConsultaSQL;
  QCliente.Open;
  CDSCliente.Active := True;
end;

procedure TFProcuraCliente.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // F2 - Localiza
  if Key = 113 then
    localiza;

  // F12 - Confirma
  if Key = 123 then
    confirma;

  if Key = 13 then
    confirma;

  // ESC - Sair
  if Key = VK_ESCAPE then
      Close;

  // F1 - Vai para o Edit Localiza
  if Key = VK_F1 then
      EditLocaliza.SetFocus;
end;

procedure TFProcuraCliente.GridPrincipalDblClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFProcuraCliente.GridPrincipalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Enter seleciona o fbn e lança no no formulario de espera
  if Key = 123 then
    confirma;
  if Key = 13 then
    confirma;
    // ESC Sair
  if Key = VK_ESCAPE then
      Close;
end;

end.
