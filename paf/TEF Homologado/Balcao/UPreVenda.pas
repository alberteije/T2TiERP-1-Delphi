{*******************************************************************************
Title: T2Ti ERP
Description: Tela utilizada para emissão de Pré-Venda.

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
unit UPreVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Generics.Collections, DB, DBClient, DBGrids, FMTBcd,
  SqlExpr, JvExControls, JvExDBGrids, JvDBGrid, Buttons, JvGradient, ExtCtrls,
  ComCtrls, Mask, JvEnterTab;

type
  TFPreVenda = class(TForm)
    JvEnterAsTab1: TJvEnterAsTab;
    panGrid: TPanel;
    GridItens: TJvDBGrid;
    PanelEdits: TPanel;
    PanelBotoes: TPanel;
    JvGradient2: TJvGradient;
    BotaoImprimir: TBitBtn;
    BotaoSair: TBitBtn;
    BotaoInserir: TBitBtn;
    BotaoConfirmar: TBitBtn;
    BotaoExcluir: TBitBtn;
    BotaoConsultarItem: TBitBtn;
    JvGradient1: TJvGradient;
    LabelTotal: TLabel;
    procedure Soma;
    procedure ConfiguraCDSGrid;
    procedure Limpa;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BotaoInserirClick(Sender: TObject);
    procedure BotaoExcluirClick(Sender: TObject);
    procedure BotaoConsultarItemClick(Sender: TObject);
    procedure BotaoSairClick(Sender: TObject);
    procedure BotaoConfirmarClick(Sender: TObject);
    procedure BotaoImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPreVenda: TFPreVenda;

implementation

uses UDataModule, UImportaProduto, PreVendaController, PreVendaVO, PreVendaDetalheVO;

var
  opcao: String; // i-inserindo | c-consultando | a-alterando
  total: Double;
{$R *.dfm}

{ TODO : O que está faltando neste formulário? }
{ TODO : Como melhorar a aparência do formulário? }

{
********************************************************************************
Procedimentos do formulário
********************************************************************************
}
procedure TFPreVenda.FormCreate(Sender: TObject);
begin
  ConfiguraCDSGrid;
  Total := 0;
end;

procedure TFPreVenda.ConfiguraCDSGrid;
begin
  // Configuramos o ClientDataSet da PV Detalhe
  FDataModule.CDSPV.Close;
  FDataModule.CDSPV.FieldDefs.Clear;
  FDataModule.CDSPV.FieldDefs.add('DESCRICAO_PDV', ftString, 30);
  FDataModule.CDSPV.FieldDefs.add('QUANTIDADE', ftFloat);
  FDataModule.CDSPV.FieldDefs.add('VALOR_UNITARIO', ftFloat);
  FDataModule.CDSPV.FieldDefs.add('VALOR_TOTAL', ftFloat);
  FDataModule.CDSPV.FieldDefs.add('ID_PRODUTO', ftInteger);
  FDataModule.CDSPV.CreateDataSet;
  TFloatField(FDataModule.CDSPV.FieldByName('QUANTIDADE')).displayFormat:='#########0.00';
  TFloatField(FDataModule.CDSPV.FieldByName('VALOR_UNITARIO')).displayFormat:='#########0.00';
  TFloatField(FDataModule.CDSPV.FieldByName('VALOR_TOTAL')).displayFormat:='#########0.00';
  // Definimos os cabeçalhos da Grid Principal
  GridItens.Columns[0].Title.Caption := 'Descrição';
  GridItens.Columns[0].Width := 300;
  GridItens.Columns[1].Title.Caption := 'Quantidade';
  GridItens.Columns[2].Title.Caption := 'Unitário';
  GridItens.Columns[3].Title.Caption := 'Total';
  //Valores inacessíveis para alteração
  GridItens.Columns[0].ReadOnly := True;
  GridItens.Columns[2].ReadOnly := True;
  GridItens.Columns[3].ReadOnly := True;
  //nao exibe a coluna do ID_PRODUTO
  GridItens.Columns.Items[4].Visible := False;
end;

procedure TFPreVenda.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 112 then
    BotaoInserirClick(Sender);
  if key = 115 then
    BotaoConsultarItemClick(Sender);
  if key = 116 then
    BotaoExcluirClick(Sender);
  if key = 121 then
    BotaoImprimirClick(Sender);
  if key = 122 then
    BotaoConfirmarClick(Sender);
  if key = 123 then
    Close;
end;

procedure TFPreVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

{ TODO : O que podemos melhorar nesse procedimento? }
procedure TFPreVenda.Limpa;
begin
  Total := 0;
  LabelTotal.Caption := '0,00';
  FDataModule.CDSPV.EmptyDataSet;
end;

{ TODO : O que está incorreto neste procedimento? }
procedure TFPreVenda.Soma;
begin
  Total := Total + FDataModule.CDSPV.FieldByName('VALOR_TOTAL').AsFloat;
  LabelTotal.Caption := FloatToStrF(Total,ffNumber,15,2);
end;

{
********************************************************************************
Eventos dos botões
********************************************************************************
}

{ TODO : O que pode dar errado neste método? }
procedure TFPreVenda.BotaoConfirmarClick(Sender: TObject);
var
  PreVendaControl : TPreVendaController;
  PreVendaCabecalho : TPreVendaVO;
  PreVendaDetalhe: TPreVendaDetalheVO;
  ListaPreVendaDetalhe: TObjectList<TPreVendaDetalheVO>;
  NumeroPV: Integer;
begin
  PreVendaControl := TPreVendaController.Create;
  PreVendaCabecalho := TPreVendaVO.Create;
  ListaPreVendaDetalhe := TObjectList<TPreVendaDetalheVO>.Create;
  //
  PreVendaCabecalho.Valor := Total;
  FDataModule.CDSPV.DisableControls;
  FDataModule.CDSPV.First;
  while not FDataModule.CDSPV.Eof do
  begin
    PreVendaDetalhe := TPreVendaDetalheVO.Create;
    PreVendaDetalhe.IdProduto := FDataModule.CDSPV.FieldByName('ID_PRODUTO').AsInteger;
    PreVendaDetalhe.Quantidade := FDataModule.CDSPV.FieldByName('QUANTIDADE').AsFloat;
    PreVendaDetalhe.ValorUnitario := FDataModule.CDSPV.FieldByName('VALOR_UNITARIO').AsFloat;
    PreVendaDetalhe.ValorTotal := FDataModule.CDSPV.FieldByName('VALOR_TOTAL').AsFloat;
    ListaPreVendaDetalhe.Add(PreVendaDetalhe);
    FDataModule.CDSPV.Next;
  end;
  NumeroPV := PreVendaControl.InserePreVenda(PreVendaCabecalho, ListaPreVendaDetalhe);
  ShowMessage('Pré-Venda inserida com sucesso. Número: ' + IntToStr(NumeroPV));
  Limpa;
  FDataModule.CDSPV.EnableControls;
end;

procedure TFPreVenda.BotaoConsultarItemClick(Sender: TObject);
begin
  Application.CreateForm(TFImportaProduto, FImportaProduto);
  UImportaProduto.QuemChamou := 'PV';
  FImportaProduto.ShowModal;
end;

procedure TFPreVenda.BotaoExcluirClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    try
      FDataModule.CDSPV.Delete;
    except
      Application.MessageBox('Ocorreu um erro. Exclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TFPreVenda.BotaoImprimirClick(Sender: TObject);
begin
  ShowMessage('Existe relatório na Pre-Venda?');
end;

procedure TFPreVenda.BotaoInserirClick(Sender: TObject);
begin
  GridItens.SetFocus;
  opcao := 'I';
end;

procedure TFPreVenda.BotaoSairClick(Sender: TObject);
begin
  Close;
end;

end.
