{*******************************************************************************
Title: T2Ti ERP
Description: Tela utilizada para emissão de DAV.

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
unit UDAV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Generics.Collections, DB, DBClient, DBGrids, FMTBcd,
  SqlExpr, JvExControls, JvExDBGrids, JvDBGrid, Buttons, JvGradient, ExtCtrls,
  ComCtrls, Mask, JvEnterTab, COMObj;

type
  TFDAV = class(TForm)
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
    EditCPFCNPJ: TLabeledEdit;
    EditNome: TLabeledEdit;
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
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDAV: TFDAV;

implementation

uses UDataModule, UImportaProduto, DAVController, DAVVO, DAVDetalheVO;

var
  total: Double;
  CodigoDAV: Integer;
{$R *.dfm}

{ TODO : O que está faltando neste formulário? }

{
********************************************************************************
Procedimentos do formulário
********************************************************************************
}
procedure TFDAV.FormCreate(Sender: TObject);
begin
  ConfiguraCDSGrid;
  Total := 0;
  CodigoDAV := 0;
end;

procedure TFDAV.ConfiguraCDSGrid;
begin
  // Configuramos o ClientDataSet do DAV Detalhe
  FDataModule.CDSDAV.Close;
  FDataModule.CDSDAV.FieldDefs.Clear;
  FDataModule.CDSDAV.FieldDefs.add('DESCRICAO_PDV', ftString, 30);
  FDataModule.CDSDAV.FieldDefs.add('QUANTIDADE', ftFloat);
  FDataModule.CDSDAV.FieldDefs.add('VALOR_UNITARIO', ftFloat);
  FDataModule.CDSDAV.FieldDefs.add('VALOR_TOTAL', ftFloat);
  FDataModule.CDSDAV.FieldDefs.add('ID_PRODUTO', ftInteger);
  FDataModule.CDSDAV.CreateDataSet;
  TFloatField(FDataModule.CDSDAV.FieldByName('QUANTIDADE')).displayFormat:='#########0.00';
  TFloatField(FDataModule.CDSDAV.FieldByName('VALOR_UNITARIO')).displayFormat:='#########0.00';
  TFloatField(FDataModule.CDSDAV.FieldByName('VALOR_TOTAL')).displayFormat:='#########0.00';
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

procedure TFDAV.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFDAV.FormActivate(Sender: TObject);
begin
  EditNome.SetFocus;
end;

procedure TFDAV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

{ TODO : O que podemos melhorar nesse procedimento? }
procedure TFDAV.Limpa;
begin
  EditNome.Clear;
  EditCPFCNPJ.Clear;
  EditNome.SetFocus;
  Total := 0;
  LabelTotal.Caption := '0,00';
  FDataModule.CDSDAV.EmptyDataSet;
end;

{ TODO : O que está incorreto neste procedimento? }
procedure TFDAV.Soma;
begin
  Total := Total + FDataModule.CDSDAV.FieldByName('VALOR_TOTAL').AsFloat;
  LabelTotal.Caption := FloatToStrF(Total,ffNumber,15,2);
end;

{
********************************************************************************
Eventos dos botões
********************************************************************************
}

{ TODO : O que pode dar errado neste método? }
procedure TFDAV.BotaoConfirmarClick(Sender: TObject);
var
  DAVControl : TDAVController;
  DAVCabecalho : TDAVVO;
  DAVDetalhe: TDAVDetalheVO;
  ListaDAVDetalhe: TObjectList<TDAVDetalheVO>;
begin
  if (EditNome.Text <> '') and (EditCPFCNPJ.Text <> '') then
  begin
    DAVControl := TDAVController.Create;
    DAVCabecalho := TDAVVO.Create;
    ListaDAVDetalhe := TObjectList<TDAVDetalheVO>.Create;
    //
    DAVCabecalho.NomeDestinatario := EditNome.Text;
    DAVCabecalho.CpfCnpjDestinatario := EditCPFCNPJ.Text;
    DAVCabecalho.Valor := Total;
    FDataModule.CDSDAV.DisableControls;
    FDataModule.CDSDAV.First;
    while not FDataModule.CDSDAV.Eof do
    begin
      DAVDetalhe := TDAVDetalheVO.Create;
      DAVDetalhe.IdProduto := FDataModule.CDSDAV.FieldByName('ID_PRODUTO').AsInteger;
      DAVDetalhe.Quantidade := FDataModule.CDSDAV.FieldByName('QUANTIDADE').AsFloat;
      DAVDetalhe.ValorUnitario := FDataModule.CDSDAV.FieldByName('VALOR_UNITARIO').AsFloat;
      DAVDetalhe.ValorTotal := FDataModule.CDSDAV.FieldByName('VALOR_TOTAL').AsFloat;
      ListaDAVDetalhe.Add(DAVDetalhe);
      FDataModule.CDSDAV.Next;
    end;
    CodigoDAV := DAVControl.InsereDAV(DAVCabecalho, ListaDAVDetalhe);
    Application.MessageBox('DAV inserido com sucesso.', 'Informação do sistema', MB_OK + MB_ICONINFORMATION);
    if Application.MessageBox('Deseja Imprimir o DAV?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
      BotaoImprimir.Click;
    Limpa;
    FDataModule.CDSDAV.EnableControls;
  end
  else
  begin
    Application.MessageBox('Nome e CPF/CNPJ do destinatário são obrigatórios.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    EditNome.SetFocus;
  end;
end;

procedure TFDAV.BotaoConsultarItemClick(Sender: TObject);
begin
  Application.CreateForm(TFImportaProduto, FImportaProduto);
  UImportaProduto.QuemChamou := 'DAV';
  FImportaProduto.ShowModal;
end;

procedure TFDAV.BotaoExcluirClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    try
      FDataModule.CDSDAV.Delete;
    except
      Application.MessageBox('Ocorreu um erro. Exclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TFDAV.BotaoImprimirClick(Sender: TObject);
var
  ReportManager: Variant;
begin
  if CodigoDAV <> 0 then
  begin
    ReportManager := CreateOleObject('ReportMan.ReportManX');
    ReportManager.Preview := true;
    ReportManager.ShowProgress := true;
    ReportManager.ShowPrintDialog := true;
    ReportManager.Filename := 'DAV.rep';
    ReportManager.SetParamValue('ID',CodigoDAV);
    ReportManager.execute;
  end
  else
    Application.MessageBox('DAV ainda não gravado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFDAV.BotaoInserirClick(Sender: TObject);
begin
  Limpa;
  EditNome.SetFocus;
end;

procedure TFDAV.BotaoSairClick(Sender: TObject);
begin
  Close;
end;

end.
