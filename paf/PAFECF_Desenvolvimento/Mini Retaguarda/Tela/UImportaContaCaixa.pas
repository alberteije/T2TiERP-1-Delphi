{*******************************************************************************
Title: T2Ti ERP
Description: Janela para importação de dados de um Caixa ou Banco

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
unit UImportaContaCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, StdCtrls,
  ExtCtrls, Buttons, Rtti, DB, DBClient, TypInfo, Mask, Biblioteca, pngimage;

type
  TFImportaContaCaixa = class(TForm)
    PanelFiltroRapido: TPanel;
    Label1: TLabel;
    Grid: TJvDBUltimGrid;
    EditMesAno: TMaskEdit;
    Image1: TImage;
    Label2: TLabel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EditMesAnoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImportaContaCaixa: TFImportaContaCaixa;

implementation

uses UDataModule, ContaCaixaController, UMenu, UMovimentoCaixaBanco,
MovimentoCaixaBancoController;

{$R *.dfm}

procedure TFImportaContaCaixa.EditMesAnoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    Grid.SetFocus;
end;

procedure TFImportaContaCaixa.FormCreate(Sender: TObject);
begin
  //Grid principal - dos lançamentos
  FDataModule.CDSContaCaixa.Close;
  FDataModule.CDSContaCaixa.FieldDefs.Clear;
  FDataModule.CDSContaCaixa.FieldDefs.add('CODIGO', ftString, 20);
  FDataModule.CDSContaCaixa.FieldDefs.add('NOME', ftString, 50);
  FDataModule.CDSContaCaixa.FieldDefs.add('TIPO', ftString, 1);
  FDataModule.CDSContaCaixa.FieldDefs.add('DESCRICAO', ftMemo);
  FDataModule.CDSContaCaixa.FieldDefs.add('NOME_AGENCIA', ftString, 100);
  FDataModule.CDSContaCaixa.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSContaCaixa.FieldDefs.add('ID_AGENCIA', ftInteger);
  FDataModule.CDSContaCaixa.CreateDataSet;

  // Definição dos títulos dos cabeçalhos e largura das colunas
  Grid.Columns[0].Title.Caption := 'Código';
  Grid.Columns[1].Title.Caption := 'Nome';
  Grid.Columns[2].Title.Caption := 'Tipo';
  Grid.Columns[3].Title.Caption := 'Descrição';
  Grid.Columns[4].Title.Caption := 'Agência';
  Grid.Columns[0].Width := 100;
  Grid.Columns[1].Width := 250;
  Grid.Columns[2].Width := 50;
  Grid.Columns[3].Width := 300;
  Grid.Columns[5].Visible := False;
  Grid.Columns[6].Visible := False;
end;

procedure TFImportaContaCaixa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TFImportaContaCaixa.FormShow(Sender: TObject);
begin
  TContaCaixaController.Consulta('1=1',0,False);
  FDataModule.CDSContaCaixa.First;
  EditMesAno.SetFocus;
end;

procedure TFImportaContaCaixa.GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Mes, MesAnterior, Ano, UltimoDia, DataInicial, DataFinal, Filtro, FiltroFechamento: String;

begin
  if key = VK_RETURN then
  begin
    Mes := Copy(EditMesAno.Text,1,2);
    Ano := Copy(EditMesAno.Text,4,4);

    MesAnterior := IntToStr(StrToInt(Mes) - 1);
    MesAnterior := StringOfChar('0',2-Length(MesAnterior)) + MesAnterior;

    DataInicial := '01/' + EditMesAno.Text;
    UltimoDia := UltimoDiaMes(StrToDate(DataInicial));
    DataInicial := Copy(EditMesAno.Text,4,4) + '-' + Copy(EditMesAno.Text,1,2) + '-01';
    DataFinal := Copy(EditMesAno.Text,4,4) + '-' + Copy(EditMesAno.Text,1,2) + '-' + UltimoDia;

    Filtro := 'ID_CONTA_CAIXA = '+FDataModule.CDSContaCaixa.FieldByName('ID').AsString + ' and (DATA_PAGAMENTO BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal)+')';
    FiltroFechamento := 'ID_CONTA_CAIXA = '+FDataModule.CDSContaCaixa.FieldByName('ID').AsString + ' and MES = ' + QuotedStr(MesAnterior) + ' and ANO = ' + QuotedStr(Ano);

    FMenu.NovaPagina(TFMovimentoCaixaBanco, 45);
    TMovimentoCaixaBancoController.Consulta(Filtro,FiltroFechamento,0);
    Close;
  end;
end;

end.
