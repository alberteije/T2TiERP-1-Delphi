{*******************************************************************************
Title: T2Ti ERP
Description: Tela para excluir produtos da venda.

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

@author Albert Eije (T2Ti.COM) | José Moacir Tavares Moreira
@version 1.0
*******************************************************************************}
unit UExcluiProdutoVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, Provider, DBClient, SqlExpr, Grids, DBGrids, JvExDBGrids,
  JvDBGrid, StdCtrls, ExtCtrls, pngimage, Buttons, JvExButtons, JvBitBtn, Generics.Collections;

type
  TCustomDBGridCracker = class(TCustomDBGrid);
  TFExcluiProdutoVenda = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EditLocaliza: TEdit;
    GridPrincipal: TJvDBGrid;
    QVendaDetalhe: TSQLQuery;
    dsVendaDetalhe: TDataSource;
    cdsVendaDetalhe: TClientDataSet;
    dspVendaDetalhe: TDataSetProvider;
    cdsVendaDetalheitem: TIntegerField;
    cdsVendaDetalhequantidade: TFMTBCDField;
    cdsVendaDetalhevalor_unitario: TFMTBCDField;
    cdsVendaDetalhevalor_total: TFMTBCDField;
    cdsVendaDetalhegtin: TStringField;
    cdsVendaDetalhenome: TStringField;
    btnConfirma: TJvBitBtn;
    Image1: TImage;
    GroupBox1: TGroupBox;
    btnGtin1: TSpeedButton;
    btnBalanca2: TSpeedButton;
    btnItem3: TSpeedButton;
    btnInterno4: TSpeedButton;
    btnID5: TSpeedButton;
    Bevel1: TBevel;
    procedure Localiza(Tipo: Integer);
    procedure EditLocalizaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridPrincipalDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGtin1Click(Sender: TObject);
    procedure MudaCorBotao;
    procedure EscolheComSetas(Tipo:integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FExcluiProdutoVenda: TFExcluiProdutoVenda;

implementation

uses UDataModule, UCaixa, VendaDetalheVO, Biblioteca,
  ConfiguracaoController, ConfiguracaoVO;

var
  VendaDetalhe: TVendaDetalheVO;
  ListaVendaDetalhe: TObjectList<TVendaDetalheVO>;

{$R *.dfm}

procedure TFExcluiProdutoVenda.btnGtin1Click(Sender: TObject);
begin
  Localiza(StrToInt(DevolveInteiro(TSpeedButton(sender).Name)));
end;

procedure TFExcluiProdutoVenda.EditLocalizaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 27 then
    Close;

  case key of
    VK_RETURN: localiza(UCaixa.Configuracao.UltimaExclusao);
  end;
end;

procedure TFExcluiProdutoVenda.EscolheComSetas(Tipo: Integer);
var
  Posicao: Integer;
begin
  Posicao := UCaixa.Configuracao.UltimaExclusao;
  if Tipo = 1 then
  begin
    case posicao of
      1: btnBalanca2.Click;
      2: btnItem3.Click;
      3: btnInterno4.Click;
      4: btnID5.Click;
      5: btnGtin1.Click;
    end;
  end
  else if Tipo = 0 then
  begin
    case posicao of
      1: btnID5.Click;
      2: btnGtin1.Click;
      3: btnBalanca2.Click;
      4: btnItem3.Click;
      5: btnInterno4.Click;
    end;
  end;
end;

procedure TFExcluiProdutoVenda.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (ssctrl in shift) and CharInSet(chr(Key),['A','a']) or (Key = VK_F1) then
    Localiza(1);

  If (ssctrl in shift) and CharInSet(chr(Key),['B','b']) or (Key = VK_F2) then
    Localiza(2);

  If (ssctrl in shift) and CharInSet(chr(Key),['C','c']) or (Key = VK_F3) then
    Localiza(3);

  If (ssctrl in shift) and CharInSet(chr(Key),['D','d']) or (Key = VK_F5) then
    Localiza(4);

  If (ssctrl in shift) and CharInSet(chr(Key),['E','e']) or (Key = VK_F6) then
    Localiza(5);

  if Key = 39  then
    EscolheComSetas(1);
  if Key = 37  then
    EscolheComSetas(0);
end;

procedure TFExcluiProdutoVenda.FormShow(Sender: TObject);
begin
  label2.Caption:='';
  MudaCorBotao;
end;

procedure TFExcluiProdutoVenda.GridPrincipalDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFExcluiProdutoVenda.GridPrincipalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Cancela: Integer;
begin
  if key = 27 then
    EditLocaliza.SetFocus;

  if (Shift = [ssCtrl]) and (Key = 46) then
  begin
    KEY := 0;
    Application.MessageBox('Pressione somente a tecla delete.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;

  if key = 46 then
    btnconfirma.Click;
end;

procedure TFExcluiProdutoVenda.localiza(Tipo:integer);
begin
  if Trim(EditLocaliza.Text) = '' then
  begin
    Application.MessageBox('Digite o codigo de barras ou'+#13+
                           'Item do Cupom ou'+#13+
                           'Código da balança ou'+#13+
                           'Código interno ou'+#13+
                           'ID do Produto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;

  if Tipo <> 4 then
  begin
    if Length(Trim(EditLocaliza.Text)) <> Length(DevolveInteiro(EditLocaliza.Text)) then
    begin
      Application.MessageBox('Para pesquisar GTIN, BALANCA, ITEM ou ID,'+#13+
                             'digite apenas números.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      Abort;
    end;
  end;

  if UCaixa.Configuracao.UltimaExclusao <> Tipo then
  begin
    TConfiguracaoController.GravaUltimaExclusao(Tipo);
    MudaCorBotao;
  end;

  cdsVendaDetalhe.Active := False;
  QVendaDetalhe.Active := False;
  QVendaDetalhe.SQL.Clear;

  QVendaDetalhe.SQL.Add('select vd.item, vd.quantidade, vd.valor_unitario, vd.valor_total,');
  QVendaDetalhe.SQL.Add('p.gtin, p.nome from ecf_venda_detalhe vd ');
  QVendaDetalhe.SQL.Add('inner join produto p on vd.id_ecf_produto = p.id');
  QVendaDetalhe.SQL.Add('where (vd.cancelado = ' + QuotedStr('N')+')');
  QVendaDetalhe.SQL.Add(' and (vd.id_ecf_venda_cabecalho = ' + QuotedStr(DevolveInteiro(FCaixa.edtNVenda.Caption))+')');

  case Tipo of
    1: QVendaDetalhe.SQL.Add(' and (p.gtin = ' + QuotedStr(Trim(EditLocaliza.Text))+')');
    2: QVendaDetalhe.SQL.Add(' and (p.codigo_balanca = ' + QuotedStr(Trim(EditLocaliza.Text))+')');
    3: QVendaDetalhe.SQL.Add(' and (vd.item = ' + QuotedStr(Trim(EditLocaliza.Text))+')');
    4: QVendaDetalhe.SQL.Add(' and (p.codigo_interno = ' + QuotedStr(Trim(EditLocaliza.Text))+')');
    5: QVendaDetalhe.SQL.Add(' and (p.id = ' + QuotedStr(Trim(EditLocaliza.Text))+')');
  end;

  QVendaDetalhe.Open;
  cdsVendaDetalhe.Active := True;
  Label2.Caption := FloatToStrF(cdsVendaDetalhe.RecordCount,ffNumber,15,0) + ' produtos localizados.';

  if cdsVendaDetalhe.RecordCount > 1 then
  begin
    btnConfirma.Enabled := True;
    GridPrincipal.SetFocus;
  end
  else if cdsVendaDetalhe.RecordCount > 0 then
    btnConfirma.Enabled := True;
end;

procedure TFExcluiProdutoVenda.MudaCorBotao;
begin
  btnGtin1.Font.Color := clBlack;
  btnBalanca2.Font.Color := clBlack;
  btnItem3.Font.Color := clBlack;
  btnInterno4.Font.Color := clBlack;
  btnID5.Font.Color := clBlack;
  FCaixa.PegaConfiguracao;
  case UCaixa.Configuracao.UltimaExclusao of
    1: btnGtin1.Font.Color := clRed;
    2: btnBalanca2.Font.Color := clRed;
    3: btnItem3.Font.Color := clRed;
    4: btnInterno4.Font.Color := clRed;
    5: btnID5.Font.Color := clRed;
  end;
end;

end.
