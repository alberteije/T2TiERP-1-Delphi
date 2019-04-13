{*******************************************************************************
Title: T2Ti ERP
Description: Cancela Pre-Venda.

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
unit UCancelaPreVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, FMTBcd,
  Provider, DBClient, DB, SqlExpr, Math, DBCtrls,Generics.Collections;

type
  TFCancelaPreVenda = class(TForm)
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
    GroupBox2: TGroupBox;
    GridMestre: TJvDBGrid;
    GroupBox1: TGroupBox;
    GridDetalhe: TJvDBGrid;
    CDSMestreID: TIntegerField;
    CDSMestreID_PESSOA: TIntegerField;
    CDSMestreID_EMPRESA: TIntegerField;
    CDSMestreDATA_PV: TDateField;
    CDSMestreHORA_PV: TStringField;
    CDSMestreSITUACAO: TStringField;
    CDSMestreCCF: TIntegerField;
    CDSMestreVALOR: TFMTBCDField;
    CDSMestreNOME_DESTINATARIO: TStringField;
    CDSMestreCPF_CNPJ_DESTINATARIO: TStringField;
    CDSMestreSUBTOTAL: TFMTBCDField;
    CDSMestreDESCONTO: TFMTBCDField;
    CDSMestreACRESCIMO: TFMTBCDField;
    CDSMestreTAXA_ACRESCIMO: TFMTBCDField;
    CDSMestreTAXA_DESCONTO: TFMTBCDField;
    CDSDetalheID: TIntegerField;
    CDSDetalheID_PRODUTO: TIntegerField;
    CDSDetalheID_PRE_VENDA_CABECALHO: TIntegerField;
    CDSDetalheQUANTIDADE: TFMTBCDField;
    CDSDetalheVALOR_UNITARIO: TFMTBCDField;
    CDSDetalheVALOR_TOTAL: TFMTBCDField;
    CDSDetalheDESCRICAO_PDV: TStringField;
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridMestreKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCancelaPreVenda: TFCancelaPreVenda;

implementation

uses
  UCaixa, PreVendaController, UDataModule;

{$R *.dfm}

procedure TFCancelaPreVenda.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFCancelaPreVenda.Confirma;
var
  PVSelecionada: Integer;
begin
  if CDSMestre.RecordCount > 0 then
  begin
    PVSelecionada := CDSMestre.FieldByName('ID').AsInteger;
    if Application.MessageBox('Tem certeza que deseja cancelar a Pré-Venda selecionada?' , 'Cancelar Pré-Venda', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      FCaixa.labelMensagens.Caption := 'Aguarde. Cancelando Pré-Venda!';
      CDSMestre.DisableControls;
      FCaixa.labelMensagens.Caption := 'Cancela Pré-Venda em andamento.';
      TPreVendaController.CancelaPreVendasPendentes(PVSelecionada);
      Close;
    end;
  end
  else
    Application.MessageBox('Não existem Pré-Vendas disponíveis para cancelamento?' , 'Informação do Sistema', Mb_Ok);
end;

procedure TFCancelaPreVenda.FormActivate(Sender: TObject);
begin
  if CDSMestre.RecordCount < 1 then
    Application.MessageBox('Não existem Pré-Vendas disponíveis para cancelamento?' , 'Informação do Sistema', Mb_Ok);

  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  GridMestre.SetFocus;
end;

procedure TFCancelaPreVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFCancelaPreVenda.FormCreate(Sender: TObject);
begin
  QMestre.SQLConnection  := FDataModule.ConexaoBalcao;
  QDetalhe.SQLConnection := FDataModule.ConexaoBalcao;
  CDSDetalhe.MasterSource := DSMestre;
  CDSDetalhe.MasterFields := 'ID';
  CDSDetalhe.IndexFieldNames := 'ID_PRE_VENDA_CABECALHO';
  CDSMestre.Active := True;
  CDSDetalhe.Active := True;
end;

procedure TFCancelaPreVenda.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 123 then
    Confirma;
end;

procedure TFCancelaPreVenda.GridMestreKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if key = VK_DELETE then
    Confirma;
end;

end.
