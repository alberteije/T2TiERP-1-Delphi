{*******************************************************************************
Title: T2Ti ERP
Description: Pesquisa por produto e importação para a venda.

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
unit UImportaProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, JvDBSearchEdit, DB, Provider, DBClient, FMTBcd,
  SqlExpr, Biblioteca, JvExControls, JvEnterTab;

type
  TFImportaProduto = class(TForm)
    Image1: TImage;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    GridPrincipal: TJvDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    EditLocaliza: TEdit;
    SpeedButton1: TSpeedButton;
    QProduto: TSQLQuery;
    DSProduto: TDataSource;
    CDSProduto: TClientDataSet;
    DSPProduto: TDataSetProvider;
    Label2: TLabel;
    JvEnterAsTab1: TJvEnterAsTab;
    CDSProdutoID: TIntegerField;
    CDSProdutoID_UNIDADE_PRODUTO: TIntegerField;
    CDSProdutoGTIN: TStringField;
    CDSProdutoCODIGO_INTERNO: TStringField;
    CDSProdutoNOME: TStringField;
    CDSProdutoDESCRICAO: TMemoField;
    CDSProdutoDESCRICAO_PDV: TStringField;
    CDSProdutoVALOR_VENDA: TFMTBCDField;
    CDSProdutoQTD_ESTOQUE: TFMTBCDField;
    CDSProdutoESTOQUE_MIN: TFMTBCDField;
    CDSProdutoESTOQUE_MAX: TFMTBCDField;
    CDSProdutoIAT: TStringField;
    CDSProdutoIPPT: TStringField;
    CDSProdutoNCM: TStringField;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure localiza;
    procedure confirma;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImportaProduto: TFImportaProduto;
  coluna: String;

implementation

uses UDataModule, UCaixa;

{$R *.dfm}

procedure TFImportaProduto.botaoConfirmaClick(Sender: TObject);
begin
  confirma;
end;

procedure TFImportaProduto.confirma;
begin
  if CDSProduto.FieldByName('VALOR_VENDA').AsFloat > 0 then
  begin
    if (UCaixa.StatusCaixa = 1) or (UCaixa.StatusCaixa = 2) then
    begin
      FCaixa.editCodigo.Text := CDSProduto.FieldByName('GTIN').AsString;
      FCaixa.editCodigo.SetFocus;
    end;
    close;
  end
  else
    Application.MessageBox('Produto não pode ser vendido com valor zerado ou negativo.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFImportaProduto.FormActivate(Sender: TObject);
begin
  EditLocaliza.SetFocus;
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
end;

procedure TFImportaProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFImportaProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 113 then
    localiza;
  if Key = 123 then
    confirma;
end;

procedure TFImportaProduto.GridPrincipalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    EditLocaliza.SetFocus;
end;

procedure TFImportaProduto.localiza;
var
  ProcurePor: String;
begin
  ProcurePor := '%' + EditLocaliza.Text + '%';
  CDSProduto.Active := False;
  QProduto.Active := False;
  QProduto.SQL.Clear;
  QProduto.SQL.Add('SELECT * FROM PRODUTO WHERE NOME LIKE ' + QuotedStr(ProcurePor) + ' ORDER BY NOME');
  QProduto.Active := True;
  CDSProduto.Active := True;
  Label2.Caption := FloatToStrF(QProduto.RecordCount,ffNumber,15,0) + ' produtos localizados.';
end;

procedure TFImportaProduto.SpeedButton1Click(Sender: TObject);
begin
  localiza;
end;

end.
