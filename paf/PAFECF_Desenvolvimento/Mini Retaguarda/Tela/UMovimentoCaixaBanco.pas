{*******************************************************************************
Title: T2Ti ERP
Description: Janela do Movimento de Caixa e Banco

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
@version 1.1
*******************************************************************************}
unit UMovimentoCaixaBanco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, JvDBUltimGrid, ExtCtrls, ComCtrls, JvSpeedbar,
  JvExExtCtrls, StdActns, ActnList, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  Buttons, DB, JvEnterTab, SWSystem, ScreenTips, RibbonSilverStyleActnCtrls,
  JvExDBGrids, JvDBGrid, ToolWin, JvExStdCtrls, JvEdit, JvValidateEdit, Mask,
  Generics.Collections, FechamentoCaixaBancoVO, Biblioteca, JvPageList;

type
  TFMovimentoCaixaBanco = class(TForm)
    ActionManager: TActionManager;
    PanelToolBar: TPanel;
    ActionToolBarGrid: TActionToolBar;
    ActionImprimir: TAction;
    ActionPrimeiro: TAction;
    ActionUltimo: TAction;
    ActionAnterior: TAction;
    ActionProximo: TAction;
    ActionSair: TAction;
    ActionExportar: TAction;
    PanelGrid: TPanel;
    Grid: TJvDBUltimGrid;
    ActionExportarWord: TAction;
    ActionExportarExcel: TAction;
    ActionExportarXML: TAction;
    ActionExportarCSV: TAction;
    ActionExportarHTML: TAction;
    ActionPaginaAnterior: TAction;
    ActionPaginaProxima: TAction;
    ScreenTipsManagerCadastro: TScreenTipsManager;
    PanelFiltroRapido: TPanel;
    Label1: TLabel;
    ActionFechamento: TAction;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LabelSaldoAnterior: TLabel;
    LabelRecebimentos: TLabel;
    LabelPagamentos: TLabel;
    LabelSaldoConta: TLabel;
    LabelNaoCompensado: TLabel;
    LabelSaldoDisponivel: TLabel;
    ActionInformacoes: TAction;
    procedure ActionPrimeiroExecute(Sender: TObject);
    procedure ActionUltimoExecute(Sender: TObject);
    procedure ActionAnteriorExecute(Sender: TObject);
    procedure ActionProximoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure ActionExportarWordExecute(Sender: TObject);
    procedure ActionExportarExecute(Sender: TObject);
    procedure ActionExportarHTMLExecute(Sender: TObject);
    procedure ActionExportarCSVExecute(Sender: TObject);
    procedure ActionExportarXMLExecute(Sender: TObject);
    procedure ActionExportarExcelExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure ActionFechamentoExecute(Sender: TObject);
    procedure ActionInformacoesExecute(Sender: TObject);
    procedure FechaFormulario;
    procedure ActionSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMovimentoCaixaBanco: TFMovimentoCaixaBanco;
  FechamentoCaixaBancoAnterior, FechamentoCaixaBanco: TFechamentoCaixaBancoVO;

implementation

uses
  MovimentoCaixaBancoVO, MovimentoCaixaBancoController, UDataModule,
  UImportaContaCaixa, FechamentoCaixaBancoController, UMenu;

var
  Mes, Ano: String;
  IdContaCaixa: Integer;

{$R *.dfm}

procedure TFMovimentoCaixaBanco.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

procedure TFMovimentoCaixaBanco.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Release;
end;

procedure TFMovimentoCaixaBanco.FormCreate(Sender: TObject);
begin
  //Configura CDS do CaixaBanco
  FDataModule.CDSMovimentoCaixaBanco.Close;
  FDataModule.CDSMovimentoCaixaBanco.FieldDefs.Clear;
  FDataModule.CDSMovimentoCaixaBanco.FieldDefs.add('DATA_PAGAMENTO', ftString, 10);
  FDataModule.CDSMovimentoCaixaBanco.FieldDefs.add('NATUREZA_LANCAMENTO', ftString, 1);
  FDataModule.CDSMovimentoCaixaBanco.FieldDefs.add('NOME', ftString, 150);
  FDataModule.CDSMovimentoCaixaBanco.FieldDefs.add('TOTAL_PARCELA', ftFloat);
  FDataModule.CDSMovimentoCaixaBanco.FieldDefs.add('DESCRICAO_PLANO_CONTAS', ftString, 50);
  FDataModule.CDSMovimentoCaixaBanco.FieldDefs.add('NOME_TIPO_DOCUMENTO', ftString, 30);
  FDataModule.CDSMovimentoCaixaBanco.FieldDefs.add('DATA_LANCAMENTO', ftString, 10);
  FDataModule.CDSMovimentoCaixaBanco.FieldDefs.add('HISTORICO', ftMemo);
  FDataModule.CDSMovimentoCaixaBanco.CreateDataSet;
  TFloatField(FDataModule.CDSMovimentoCaixaBanco.FieldByName('TOTAL_PARCELA')).displayFormat := '#,###,###,##0.00';

  // Definição dos títulos dos cabeçalhos e largura das colunas
  Grid.Columns[0].Title.Caption := 'Data E/S';
  Grid.Columns[1].Title.Caption := 'Natureza Lançamento';
  Grid.Columns[2].Title.Caption := 'Cliente / Fornecedor';
  Grid.Columns[3].Title.Caption := 'Valor';
  Grid.Columns[4].Title.Caption := 'Plano Conta';
  Grid.Columns[5].Title.Caption := 'Tipo Documento';
  Grid.Columns[6].Title.Caption := 'Data Lançamento';
  Grid.Columns[7].Title.Caption := 'Histórico';
  Grid.Columns[2].Width := 200;
  Grid.Columns[7].Width := 400;
end;

procedure TFMovimentoCaixaBanco.FormPaint(Sender: TObject);
begin
  if Assigned(FechamentoCaixaBancoAnterior) then
  begin
    Mes := Copy(FImportaContaCaixa.EditMesAno.Text,1,2);
    Ano := Copy(FImportaContaCaixa.EditMesAno.Text,4,4);

    FechamentoCaixaBanco := TFechamentoCaixaBancoVO.Create;

    FechamentoCaixaBanco.IdContaCaixa := FDataModule.CDSContaCaixa.FieldByName('ID').AsInteger;
    FechamentoCaixaBanco.DataFechamento := FormatDateTime('yyyy-mm-dd', Now());
    FechamentoCaixaBanco.Mes := Mes;
    FechamentoCaixaBanco.Ano := Ano;
    FechamentoCaixaBanco.SaldoAnterior := FechamentoCaixaBancoAnterior.SaldoDisponivel;
    FechamentoCaixaBanco.ChequeNaoCompensado := 0;

    //
    FDataModule.CDSMovimentoCaixaBanco.DisableControls;
    FDataModule.CDSMovimentoCaixaBanco.First;
    while not FDataModule.CDSMovimentoCaixaBanco.Eof do
    begin
      if FDataModule.CDSMovimentoCaixaBanco.FieldByName('NATUREZA_LANCAMENTO').AsString = 'E' then
        FechamentoCaixaBanco.Recebimentos := FechamentoCaixaBanco.Recebimentos + FDataModule.CDSMovimentoCaixaBanco.FieldByName('TOTAL_PARCELA').AsFloat;

      if FDataModule.CDSMovimentoCaixaBanco.FieldByName('NATUREZA_LANCAMENTO').AsString = 'S' then
        FechamentoCaixaBanco.Pagamentos := FechamentoCaixaBanco.Pagamentos + FDataModule.CDSMovimentoCaixaBanco.FieldByName('TOTAL_PARCELA').AsFloat;

      FDataModule.CDSMovimentoCaixaBanco.Next;
    end;
    FDataModule.CDSMovimentoCaixaBanco.EnableControls;
    //
    FechamentoCaixaBanco.SaldoConta := FechamentoCaixaBanco.SaldoAnterior + FechamentoCaixaBanco.Recebimentos - FechamentoCaixaBanco.Pagamentos;
    FechamentoCaixaBanco.SaldoDisponivel := FechamentoCaixaBanco.SaldoConta - FechamentoCaixaBanco.ChequeNaoCompensado;
    //
    LabelSaldoAnterior.Caption := FloatToStrF(FechamentoCaixaBanco.SaldoAnterior, ffNumber, 10, 2);
    LabelRecebimentos.Caption := FloatToStrF(FechamentoCaixaBanco.Recebimentos, ffNumber, 10, 2);
    LabelPagamentos.Caption := FloatToStrF(FechamentoCaixaBanco.Pagamentos, ffNumber, 10, 2);
    LabelSaldoConta.Caption := FloatToStrF(FechamentoCaixaBanco.SaldoConta, ffNumber, 10, 2);
    LabelNaoCompensado.Caption := FloatToStrF(FechamentoCaixaBanco.ChequeNaoCompensado, ffNumber, 10, 2);
    LabelSaldoDisponivel.Caption := FloatToStrF(FechamentoCaixaBanco.SaldoDisponivel, ffNumber, 10, 2);

    ActionInformacoes.Caption := 'Conta/Caixa: ' + FDataModule.CDSContaCaixa.FieldByName('NOME').AsString + ' | Período: ' + FImportaContaCaixa.EditMesAno.Text;

    IdContaCaixa := FDataModule.CDSContaCaixa.FieldByName('ID').AsInteger;
  end;
end;

procedure TFMovimentoCaixaBanco.ActionFechamentoExecute(Sender: TObject);
begin
  if Application.MessageBox('Deseja realizar o fechamento para o mês/ano selecionado?', 'Realizar Fechamento', Mb_YesNo + Mb_IconQuestion) = IdYes then
  begin
    try
      TFechamentoCaixaBancoController.RealizaFechamento(FechamentoCaixaBanco);
      Application.MessageBox('Fechamento realizado com sucesso.', 'Informação do sistema', MB_OK + MB_ICONINFORMATION);
    except
    end;
  end;
end;

procedure TFMovimentoCaixaBanco.ActionPrimeiroExecute(Sender: TObject);
begin
  FDataModule.CDSMovimentoCaixaBanco.First;
end;

procedure TFMovimentoCaixaBanco.ActionUltimoExecute(Sender: TObject);
begin
  FDataModule.CDSMovimentoCaixaBanco.Last;
end;

procedure TFMovimentoCaixaBanco.ActionAnteriorExecute(Sender: TObject);
begin
  FDataModule.CDSMovimentoCaixaBanco.Prior;
end;

procedure TFMovimentoCaixaBanco.ActionProximoExecute(Sender: TObject);
begin
  FDataModule.CDSMovimentoCaixaBanco.Next;
end;

procedure TFMovimentoCaixaBanco.ActionSairExecute(Sender: TObject);
begin
FechaFormulario;
end;

procedure TFMovimentoCaixaBanco.GridUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
var
  IxDName: string;
  i: integer;
  Fields, DescFields: string;
begin
  try
    Fields := '';
    DescFields := '';
    for i := 0 to Length(FieldsToSort) - 1 do
    begin
      Fields := Fields + FieldsToSort[i].Name + ';';
      if not FieldsToSort[i].Order then
        DescFields := DescFields + FieldsToSort[i].Name + ';';
    end;
    Fields := Copy(Fields, 1, Length(Fields)-1);
    DescFields := Copy(DescFields, 1, Length(DescFields)-1);

    IxDName := IntToStr(Length(FieldsToSort)) + '_' + FormatDateTime('hhmmssz',Now);
    FDataModule.CDSMovimentoCaixaBanco.AddIndex(IxDName, Fields, [], DescFields);
    FDataModule.CDSMovimentoCaixaBanco.IndexDefs.Update;
    FDataModule.CDSMovimentoCaixaBanco.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFMovimentoCaixaBanco.ActionExportarCSVExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos CSV (Valores Separados por Vírgula) (*.CSV)|*.CSV';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarCSV.FileName := NomeArquivo + '.csv';
      FDataModule.ExportarCSV.Grid := Grid;
      FDataModule.ExportarCSV.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFMovimentoCaixaBanco.ActionExportarExcelExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos do Excel (*.XLS)|*.XLS';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarExcel.FileName := NomeArquivo + '.xls';
      FDataModule.ExportarExcel.Grid := Grid;
      FDataModule.ExportarExcel.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFMovimentoCaixaBanco.ActionExportarHTMLExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos HTML (*.HTML)|*.HTML';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarHTML.FileName := NomeArquivo + '.html';
      FDataModule.ExportarHTML.Grid := Grid;
      FDataModule.ExportarHTML.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFMovimentoCaixaBanco.ActionExportarWordExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos do Word (*.DOC)|*.DOC';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := FDataModule.SaveDialog.FileName;
      FDataModule.ExportarWord.FileName := NomeArquivo + '.doc';
      FDataModule.ExportarWord.Grid := Grid;
      FDataModule.ExportarWord.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR)
  end;
end;

procedure TFMovimentoCaixaBanco.ActionExportarXMLExecute(Sender: TObject);
var
  NomeArquivo: String;
begin
  try
    FDataModule.SaveDialog.Filter := 'Arquivos XML (*.XML)|*.XML';
    if FDataModule.SaveDialog.Execute then
    begin
      NomeArquivo := ExtractFileName(FDataModule.SaveDialog.FileName);
      FDataModule.ExportarXML.FileName := NomeArquivo + '.xml';
      FDataModule.ExportarXML.Grid := Grid;
      FDataModule.ExportarXML.ExportGrid;
      Application.MessageBox('Arquivo exportado com sucesso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  except
    Application.MessageBox('Ocorreu um erro na exportação dos dados.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFMovimentoCaixaBanco.ActionExportarExecute(Sender: TObject);
begin
//
end;

procedure TFMovimentoCaixaBanco.ActionInformacoesExecute(Sender: TObject);
begin
//
end;

end.
