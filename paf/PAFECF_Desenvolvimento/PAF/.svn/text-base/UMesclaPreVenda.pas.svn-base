{*******************************************************************************
Title: T2Ti ERP
Description: Mescla duas ou mais Pre-Vendas.

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
unit UMesclaPreVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, FMTBcd,
  Provider, DBClient, DB, SqlExpr, DBCtrls,Generics.Collections;

type
  TFMesclaPreVenda = class(TForm)
    Image1: TImage;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    QMestre: TSQLQuery;
    DSMestre: TDataSource;
    CDSMestre: TClientDataSet;
    DSPMestre: TDataSetProvider;
    DSDetalhe: TDataSource;
    CDSDetalhe: TClientDataSet;
    QDetalhe: TSQLQuery;
    DSPDetalhe: TDataSetProvider;
    CDSMestreX: TStringField;
    GroupBox2: TGroupBox;
    GridMestre: TJvDBGrid;
    GroupBox1: TGroupBox;
    GridDetalhe: TJvDBGrid;
    CDSMestreID: TIntegerField;
    CDSMestreSITUACAO: TStringField;
    CDSMestreCCF: TIntegerField;
    CDSDetalheID: TIntegerField;
    CDSDetalheID_PRODUTO: TIntegerField;
    CDSDetalheDESCRICAO_PDV: TStringField;
    CDSMestreVALOR: TFMTBCDField;
    CDSDetalheQUANTIDADE: TFMTBCDField;
    CDSDetalheVALOR_UNITARIO: TFMTBCDField;
    CDSDetalheVALOR_TOTAL: TFMTBCDField;
    CDSMestreDATA_PV: TDateField;
    CDSMestreHORA_PV: TStringField;
    CDSDetalheID_PRE_VENDA_CABECALHO: TIntegerField;
    CDSMestreID_PESSOA: TIntegerField;
    CDSMestreNOME_DESTINATARIO: TStringField;
    CDSMestreCPF_CNPJ_DESTINATARIO: TStringField;
    CDSMestreSUBTOTAL: TFMTBCDField;
    CDSMestreACRESCIMO: TFMTBCDField;
    CDSMestreID_EMPRESA: TIntegerField;
    CDSMestreDESCONTO: TFMTBCDField;
    CDSMestreTAXA_ACRESCIMO: TFMTBCDField;
    CDSMestreTAXA_DESCONTO: TFMTBCDField;
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure GridMestreKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMesclaPreVenda: TFMesclaPreVenda;

implementation

uses
  UCaixa, PreVendaController, PrevendaCabecalhoVO, PreVendaDetalheVO,
  UDataModule;

{$R *.dfm}

procedure TFMesclaPreVenda.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFMesclaPreVenda.Confirma;
var
  ListaPreVendaCabecalho: TObjectList<TPrevendaCabecalhoVO>;
  ListaPreVendaDetalhe: TObjectList<TPreVendaDetalheVO>;
  PreVendaCabecalho: TPrevendaCabecalhoVO;
  PreVendaDetalhe: TPreVendaDetalheVO;
begin
  if Application.MessageBox('Tem certeza que deseja mesclar as Pré-Vendas selecionadas?', 'Mesclar Pré-Venda', Mb_YesNo + Mb_IconQuestion) = IdYes then
  begin
    FCaixa.labelMensagens.Caption := 'Aguarde. Mesclando Pré-Venda!';
    ListaPreVendaCabecalho := TObjectList<TPrevendaCabecalhoVO>.Create;
    ListaPreVendaDetalhe := TObjectList<TPreVendaDetalheVO>.Create;

    CDSMestre.DisableControls;
    CDSMestre.First;
    while not CDSMestre.Eof do
    begin
      if CDSMestre.FieldByName('X').AsString = 'X' then
      begin
        PreVendaCabecalho := TPrevendaCabecalhoVO.Create;
        PreVendaCabecalho.Id := CDSMestre.FieldByName('ID').AsInteger;
        PreVendaCabecalho.Valor := CDSMestre.FieldByName('VALOR').AsFloat;
        PreVendaCabecalho.NomeDestinatario := CDSMestre.FieldByName('NOME_DESTINATARIO').AsString;
        PreVendaCabecalho.CpfCnpjDestinatario := CDSMestre.FieldByName('CPF_CNPJ_DESTINATARIO').AsString;
        PreVendaCabecalho.SubTotal := CDSMestre.FieldByName('SUBTOTAL').AsFloat;
        ListaPreVendaCabecalho.Add(PreVendaCabecalho);

        QDetalhe.Active := False;
        QDetalhe.SQL.Clear;
        QDetalhe.SQL.Add('SELECT * FROM PRE_VENDA_DETALHE WHERE ID_PRE_VENDA_CABECALHO='+QuotedStr(CDSMestre.FieldByName('ID').AsString));
        QDetalhe.Active := True;

        QDetalhe.First;
        while not QDetalhe.Eof do
        begin
          PreVendaDetalhe := TPreVendaDetalheVO.Create;
          PreVendaDetalhe.IdPreVenda := QDetalhe.FieldByName('ID_PRE_VENDA_CABECALHO').AsInteger;
          PreVendaDetalhe.IdProduto := QDetalhe.FieldByName('ID_PRODUTO').AsInteger;
          PreVendaDetalhe.GtinProduto := QDetalhe.FieldByName('GTIN_PRODUTO').AsString;
          PreVendaDetalhe.NomeProduto := QDetalhe.FieldByName('NOME_PRODUTO').AsString;
          PreVendaDetalhe.UnidadeProduto := QDetalhe.FieldByName('UNIDADE_PRODUTO').AsString;
          PreVendaDetalhe.ECFICMS := QDetalhe.FieldByName('ECF_ICMS_ST').AsString;
          PreVendaDetalhe.Quantidade := QDetalhe.FieldByName('QUANTIDADE').AsFloat;
          PreVendaDetalhe.ValorUnitario := QDetalhe.FieldByName('VALOR_UNITARIO').AsFloat;
          PreVendaDetalhe.ValorTotal := QDetalhe.FieldByName('VALOR_TOTAL').AsFloat;
          ListaPreVendaDetalhe.Add(PreVendaDetalhe);
          QDetalhe.Next;
        end;
      end;
      CDSMestre.Next;
    end;
    TPreVendaController.MesclaPreVenda(ListaPreVendaCabecalho,ListaPreVendaDetalhe);
    FCaixa.labelMensagens.Caption := 'Venda em andamento.';
    Close;
  end;
end;

procedure TFMesclaPreVenda.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  GridMestre.SetFocus;
end;

procedure TFMesclaPreVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFMesclaPreVenda.FormCreate(Sender: TObject);
begin
  QMestre.SQLConnection  := FDataModule.ConexaoBalcao;
  QDetalhe.SQLConnection := FDataModule.ConexaoBalcao;
  QMestre.ParamByName('SITUACAO').AsString := 'P';
  CDSDetalhe.MasterSource := DSMestre;
  CDSDetalhe.MasterFields := 'ID';
  CDSDetalhe.IndexFieldNames := 'ID_PRE_VENDA_CABECALHO';
  CDSMestre.Active := True;
  CDSDetalhe.Active := True;
end;

procedure TFMesclaPreVenda.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 123 then
    Confirma;
end;

procedure TFMesclaPreVenda.GridMestreKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_SPACE then
  begin
    CDSMestre.Edit;
    if CDSMestre.FieldByName('X').AsString = '' then
      CDSMestre.FieldByName('X').AsString := 'X'
    else
      CDSMestre.FieldByName('X').AsString := '';
    CDSMestre.Post;
  end;
end;

end.
