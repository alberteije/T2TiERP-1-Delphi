{*******************************************************************************
Title: T2Ti ERP
Description: Tabela Índice Técnico de Produção
utilizados.

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

@author Albert Eije (T2Ti.COM)  | Gilson Santos Lima
@version 1.0
*******************************************************************************}

unit UFichaTecnica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, pngimage, JvComponentBase, JvEnterTab, StdCtrls,
  JvExStdCtrls, JvButton, JvCtrls, JvExButtons, JvBitBtn, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, Mask, JvExMask, JvToolEdit, JvBaseEdits,
  FMTBcd, DB, DBClient, Provider, SqlExpr;

type
  TFFichaTecnica = class(TForm)
    btnAdicionar: TBitBtn;
    btnRemover: TBitBtn;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    Image1: TImage;
    GridPrincipal: TJvDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    editQuantidade: TJvCalcEdit;
    GridProducao: TJvDBGrid;
    GridComposicao: TJvDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    EditLocaliza: TEdit;
    Panel4: TPanel;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    editLocalizaProducao: TEdit;
    QProduto: TSQLQuery;
    DSPProduto: TDataSetProvider;
    CDSProduto: TClientDataSet;
    CDSProdutoID: TIntegerField;
    CDSProdutoGTIN: TStringField;
    CDSProdutoCODIGO_INTERNO: TStringField;
    CDSProdutoDESCRICAO_PDV: TStringField;
    CDSProdutoVALOR_VENDA: TFMTBCDField;
    CDSProdutoQTD_ESTOQUE: TFMTBCDField;
    CDSProdutoESTOQUE_MIN: TFMTBCDField;
    CDSProdutoESTOQUE_MAX: TFMTBCDField;
    CDSProdutoIAT: TStringField;
    CDSProdutoIPPT: TStringField;
    CDSProdutoNCM: TStringField;
    CDSProdutoECF_ICMS_ST: TStringField;
    CDSProdutoUNIDADE: TStringField;
    DSProduto: TDataSource;
    QProducao: TSQLQuery;
    QComposicao: TSQLQuery;
    DSProducao: TDataSource;
    DSPProducao: TDataSetProvider;
    DSPComposicao: TDataSetProvider;
    CDSProducao: TClientDataSet;
    CDSComposicao: TClientDataSet;
    DSComposicao: TDataSource;
    CDSProducaoID: TIntegerField;
    CDSProducaoUNIDADE: TStringField;
    CDSComposicaoDESCRICAO: TStringField;
    CDSComposicaoID_PRODUTO_FILHO: TIntegerField;
    CDSComposicaoQUANTIDADE: TFMTBCDField;
    CDSComposicaoID: TIntegerField;
    CDSProdutoID_UNIDADE_PRODUTO: TIntegerField;
    CDSProdutoNOME: TStringField;
    QProdutoID: TIntegerField;
    QProdutoGTIN: TStringField;
    QProdutoID_UNIDADE_PRODUTO: TIntegerField;
    QProdutoNOME: TStringField;
    QProdutoVALOR_VENDA: TFMTBCDField;
    QProdutoDESCRICAO_PDV: TStringField;
    QProdutoCODIGO_INTERNO: TStringField;
    QProdutoQTD_ESTOQUE: TFMTBCDField;
    QProdutoESTOQUE_MIN: TFMTBCDField;
    QProdutoNCM: TStringField;
    QProdutoESTOQUE_MAX: TFMTBCDField;
    QProdutoIPPT: TStringField;
    QProdutoIAT: TStringField;
    QProdutoECF_ICMS_ST: TStringField;
    QProdutoUNIDADE: TStringField;
    QProducaoID: TIntegerField;
    QProducaoNOME: TStringField;
    QProducaoUNIDADE: TStringField;
    CDSProducaoNOME: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure EditLocalizaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DSProdutoDataChange(Sender: TObject; Field: TField);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure editLocalizaProducaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure LocalizaPrincipal;
    procedure LocalizaProducao;
    procedure MostraDados;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFichaTecnica: TFFichaTecnica;

implementation

uses UDataModule, FichaTecnicaVO, FichaTecnicaController, UCaixa;

{$R *.dfm}

procedure TFFichaTecnica.btnAdicionarClick(Sender: TObject);
var
  Ficha: TFichaTecnicaVO;
begin
  if not (cdsProduto.IsEmpty) and not (CDSProducao.IsEmpty) then
  begin
  try
    Ficha := TFichaTecnicaVO.Create;
    Ficha.IdProduto := CDSProdutoID.AsInteger;
    Ficha.Descricao := CDSProducaoNOME.AsString;
    Ficha.IdProdutoFilho := CDSProducaoID.AsInteger;
    Ficha.Quantidade := editQuantidade.Value;
    if TFichaTecnicaController.GravaFichaTecnica(Ficha) then
    begin
      MostraDados;
      LocalizaProducao;
    end;
  finally
    FreeAndNil(Ficha);
  end;
  end
  else
    Application.MessageBox('Selecione um Produto para ser Produzido e um Outro para Compor a Produção!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFFichaTecnica.btnRemoverClick(Sender: TObject);
begin
  if not CDSComposicao.IsEmpty then
  begin
    if TFichaTecnicaController.ExcluiFichaTecnica(CDSComposicaoID.AsInteger) then
    begin
      MostraDados;
      LocalizaProducao;
    end;
  end;
end;

procedure TFFichaTecnica.DSProdutoDataChange(Sender: TObject; Field: TField);
begin
  MostraDados;
end;

procedure TFFichaTecnica.MostraDados;
begin
  if not (CDSProduto.IsEmpty) then
  begin
    CDSComposicao.Close;
    CDSComposicao.FetchParams;
    CDSComposicao.Params.ParamByName('ID_PRODUTO').AsInteger := CDSProdutoID.AsInteger;
    CDSComposicao.Open;
  end;
end;

procedure TFFichaTecnica.SpeedButton1Click(Sender: TObject);
begin
  LocalizaPrincipal;
end;

procedure TFFichaTecnica.SpeedButton2Click(Sender: TObject);
begin
  LocalizaProducao;
end;

procedure TFFichaTecnica.editLocalizaProducaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    LocalizaProducao;
end;

procedure TFFichaTecnica.EditLocalizaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    LocalizaPrincipal;
end;

procedure TFFichaTecnica.LocalizaPrincipal;
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
  QProduto.SQL.Add('SELECT P.ID, P.GTIN, P.ID_UNIDADE_PRODUTO, P.NOME, P.VALOR_VENDA, P.DESCRICAO_PDV, P.CODIGO_INTERNO, P.QTD_ESTOQUE, '+
                   'P.ESTOQUE_MIN, P.NCM, P.ESTOQUE_MAX, P.IPPT, P.IAT, P.ECF_ICMS_ST, U.NOME AS UNIDADE FROM PRODUTO P, UNIDADE_PRODUTO U '+
                   'WHERE (P.ID_UNIDADE_PRODUTO = U.ID) AND P.NOME LIKE ' + QuotedStr(ProcurePor) + ' ORDER BY NOME');
  QProduto.Active := True;
  CDSProduto.Active := True;
  GridPrincipal.SetFocus;
end;

procedure TFFichaTecnica.LocalizaProducao;
var
  ProcurePor: String;
begin
  if Configuracao.PesquisaParte = '1' then
    ProcurePor := editLocalizaProducao.Text + '%'
  else
    ProcurePor := '%' + editLocalizaProducao.Text + '%';

  CDSProducao.Active := False;
  QProducao.Active := False;
  QProducao.SQL.Clear;
  QProducao.SQL.Add('select P.ID, P.NOME, U. NOME AS UNIDADE from '+
                    'PRODUTO P, UNIDADE_PRODUTO U '+
                    'WHERE (P.ID_UNIDADE_PRODUTO = U.ID) and '+
                    'P.NOME LIKE ' + QuotedStr(ProcurePor) + ' and '+
                    'P.ID NOT IN (select ID_PRODUTO_FILHO from FICHA_TECNICA where ID_PRODUTO = '+CDSProdutoID.AsString+') ORDER BY NOME');
  QProducao.Active := True;
  CDSProducao.Active := True;
  editLocalizaProducao.SetFocus;
end;


procedure TFFichaTecnica.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  EditLocaliza.SetFocus;
end;

procedure TFFichaTecnica.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  FFichaTecnica:=nil;
end;

end.
