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

@author Albert Eije (T2Ti.COM) | José Rodrigues
@version 1.0
*******************************************************************************}
unit UImportaProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls,
  JvEdit, JvValidateEdit, JvDBSearchEdit, DB, Provider, DBClient, FMTBcd,
  SqlExpr, JvEnterTab, JvComponentBase;

type
  TCustomDBGridCracker = class(TCustomDBGrid);

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
    QProdutoID: TIntegerField;
    QProdutoID_UNIDADE_PRODUTO: TIntegerField;
    QProdutoGTIN: TStringField;
    QProdutoCODIGO_INTERNO: TStringField;
    QProdutoNOME: TStringField;
    QProdutoDESCRICAO: TStringField;
    QProdutoDESCRICAO_PDV: TStringField;
    QProdutoVALOR_VENDA: TFMTBCDField;
    QProdutoQTD_ESTOQUE: TFMTBCDField;
    QProdutoESTOQUE_MIN: TFMTBCDField;
    QProdutoESTOQUE_MAX: TFMTBCDField;
    QProdutoIAT: TStringField;
    QProdutoIPPT: TStringField;
    QProdutoNCM: TStringField;
    QProdutoUNIDADE: TStringField;
    QProdutoPODE_FRACIONAR: TStringField;
    QProdutoECF_ICMS_ST: TStringField;
    QProdutoCST: TStringField;
    QProdutoTOTALIZADOR_PARCIAL: TStringField;
    QProdutoTAXA_ICMS: TFMTBCDField;
    QProdutoECF_ICMS_ST_1: TStringField;
    QProdutoCODIGO_BALANCA: TIntegerField;
    CDSProdutoID: TIntegerField;
    CDSProdutoID_UNIDADE_PRODUTO: TIntegerField;
    CDSProdutoGTIN: TStringField;
    CDSProdutoCODIGO_INTERNO: TStringField;
    CDSProdutoNOME: TStringField;
    CDSProdutoDESCRICAO: TStringField;
    CDSProdutoDESCRICAO_PDV: TStringField;
    CDSProdutoVALOR_VENDA: TFMTBCDField;
    CDSProdutoQTD_ESTOQUE: TFMTBCDField;
    CDSProdutoESTOQUE_MIN: TFMTBCDField;
    CDSProdutoESTOQUE_MAX: TFMTBCDField;
    CDSProdutoIAT: TStringField;
    CDSProdutoIPPT: TStringField;
    CDSProdutoNCM: TStringField;
    CDSProdutoUNIDADE: TStringField;
    CDSProdutoPODE_FRACIONAR: TStringField;
    CDSProdutoECF_ICMS_ST: TStringField;
    CDSProdutoCST: TStringField;
    CDSProdutoTOTALIZADOR_PARCIAL: TStringField;
    CDSProdutoTAXA_ICMS: TFMTBCDField;
    CDSProdutoECF_ICMS_ST_1: TStringField;
    CDSProdutoCODIGO_BALANCA: TIntegerField;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Localiza(Tipo:integer);
    procedure Confirma;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridPrincipalDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure EditLocalizaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditLocalizaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridPrincipalKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
    QuemChamou: String;
  end;

var
  FImportaProduto: TFImportaProduto;
  Coluna: String;

implementation

uses UDataModule, UCaixa, UNotaFiscal;

{$R *.dfm}

procedure TFImportaProduto.botaoConfirmaClick(Sender: TObject);
begin
  if GridPrincipal.DataSource.DataSet.Active then
     begin
         if GridPrincipal.DataSource.DataSet.RecordCount > 0 then
            Confirma
         else
           begin
              Application.MessageBox('Não produto para importação!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
              EditLocaliza.SetFocus;
           end;
     end
   else
      begin
          Application.MessageBox('Não produto para importação!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          EditLocaliza.SetFocus;
      end;
end;

procedure TFImportaProduto.Confirma;
begin
  if CDSProduto.FieldByName('VALOR_VENDA').AsFloat > 0 then
  begin
    if (UCaixa.StatusCaixa = 1) or (UCaixa.StatusCaixa = 2) then
    begin
      FCaixa.editCodigo.Text := CDSProduto.FieldByName('ID').AsString;
    end;

    if UCaixa.StatusCaixa = 5 then
    begin
      if QuemChamou = 'NF' then
      begin
        FNotaFiscal.editCodigo.Text := CDSProduto.FieldByName('ID').AsString;
        FNotaFiscal.editUnitario.Value := CDSProduto.FieldByName('VALOR_VENDA').AsFloat;
      end;

      Close;
    end;
    Close;
  end
  else
    Application.MessageBox('Produto não pode ser vendido com valor zerado ou negativo.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFImportaProduto.EditLocalizaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 13) or    // Pressionou <Enter>
     (Key = 38) or    // Seta pra cima
     (Key = 40) then  // Seta pra baixo
       GridPrincipal.SetFocus;
end;

procedure TFImportaProduto.EditLocalizaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Length(trim(EditLocaliza.Text)) > 1 then
    Localiza(1);
end;

procedure TFImportaProduto.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
end;

procedure TFImportaProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if UCaixa.StatusCaixa <> 5 then
    FCaixa.editCodigo.SetFocus;
  Action := caFree;
end;

procedure TFImportaProduto.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    Localiza(1);
  if Key = 123 then
    Confirma;
end;

procedure TFImportaProduto.FormShow(Sender: TObject);
begin
  if trim(EditLocaliza.Text) <> '' then
    Localiza(2);
end;

procedure TFImportaProduto.GridPrincipalDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with TCustomDBGridCracker(Sender) do
  begin
    if DataLink.ActiveRecord = Row - 1 then
    begin
      Canvas.Brush.Color := clInfoBk;
      Canvas.Font.Style := [fsBold];
      Canvas.Font.Color := clBlack;
      Canvas.Font.Name := 'Verdana';
      Canvas.Font.Size := 8;
    end
    else
      Canvas.Font.Color := clBlack;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFImportaProduto.GridPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    EditLocaliza.SetFocus;
end;

procedure TFImportaProduto.GridPrincipalKeyPress(Sender: TObject; var Key: Char);
begin
  if UpperCase(Key) = 'P' then
    EditLocaliza.SetFocus;
end;

procedure TFImportaProduto.localiza(Tipo: Integer);
var
  ProcurePor: String;
begin
  if Configuracao.PesquisaParte = '1' then
     ProcurePor := EditLocaliza.Text + '%'
  else
    ProcurePor := '%' + EditLocaliza.Text + '%';

  CDSProduto.Active := False;
  QProduto.Active := False;
  QProduto.SQL.Clear;

  QProduto.SQL.Add( 'select ' +
                    ' P.ID, P.ID_UNIDADE_PRODUTO, P.GTIN, P.CODIGO_INTERNO, ' +
                    ' P.NOME, P.DESCRICAO, P.DESCRICAO_PDV, P.VALOR_VENDA, P.QTD_ESTOQUE, ' +
                    ' P.ESTOQUE_MIN, P.ESTOQUE_MAX, P.IAT, P.IPPT, P.NCM, U.NOME AS UNIDADE, ' +
                    ' U.PODE_FRACIONAR, P.ECF_ICMS_ST, P.CST, P.TOTALIZADOR_PARCIAL, P.TAXA_ICMS, P.ECF_ICMS_ST, P.CODIGO_BALANCA ' +
                    ' from ' +
                    ' PRODUTO P, ' +
                    ' UNIDADE_PRODUTO U ' +
                    ' WHERE ((P.ID_UNIDADE_PRODUTO = U.ID) AND (P.NOME LIKE ' + QuotedStr(ProcurePor) + ')) ORDER BY P.NOME ');

  QProduto.Active := True;
  CDSProduto.Active := True;
  Label2.Caption := FloatToStrF(CDSProduto.RecordCount,ffNumber,15,0) + ' produtos localizados.';

  if (Tipo = 2) and (CDSProduto.RecordCount > 0) then
    GridPrincipal.SetFocus;
end;

procedure TFImportaProduto.SpeedButton1Click(Sender: TObject);
begin
  Localiza(1);
end;

end.
