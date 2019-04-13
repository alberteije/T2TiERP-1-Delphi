{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela CONTAS_PARCELAS

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
unit ParcelaPagamentoController;

interface

uses
  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB, Windows, Forms,
  ContasParcelasVO, Generics.Collections, Biblioteca, DBXCommon;

type
  TParcelaPagamentoController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String);
    class Procedure Altera(pParcela: TContasParcelasVO);
  end;

implementation

uses UDataModule, T2TiORM;

var
  ParcelaPagamento: TContasParcelasVO;

class procedure TParcelaPagamentoController.Consulta(pFiltro: String);
var
  ResultSet : TDBXReader;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TContasParcelasVO.Create, pFiltro, 0);

      FDataModule.CDSParcelaPagamento.DisableControls;
      FDataModule.CDSParcelaPagamento.EmptyDataSet;
      while ResultSet.Next do
      begin
        FDataModule.CDSParcelaPagamento.Append;
        FDataModule.CDSParcelaPagamento.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
        FDataModule.CDSParcelaPagamento.FieldByName('NUMERO_PARCELA').AsInteger := ResultSet.Value['NUMERO_PARCELA'].AsInt32;
        FDataModule.CDSParcelaPagamento.FieldByName('DATA_EMISSAO').AsString := ResultSet.Value['DATA_EMISSAO'].AsString;
        FDataModule.CDSParcelaPagamento.FieldByName('DATA_VENCIMENTO').AsString := ResultSet.Value['DATA_VENCIMENTO'].AsString;
        FDataModule.CDSParcelaPagamento.FieldByName('SITUACAO').AsString := ResultSet.Value['SITUACAO'].AsString;
        FDataModule.CDSParcelaPagamento.FieldByName('ID_CONTAS_PAGAR_RECEBER').AsInteger := ResultSet.Value['ID_CONTAS_PAGAR_RECEBER'].AsInt32;
        FDataModule.CDSParcelaPagamento.FieldByName('VALOR').AsFloat := ResultSet.Value['VALOR'].AsDouble;
        try
          FDataModule.CDSParcelaPagamento.FieldByName('DATA_PAGAMENTO').AsString := ResultSet.Value['DATA_PAGAMENTO'].AsString;
        except
          FDataModule.CDSParcelaPagamento.FieldByName('DATA_PAGAMENTO').AsString := '';
        end;
        FDataModule.CDSParcelaPagamento.FieldByName('TAXA_JUROS').AsFloat := ResultSet.Value['TAXA_JUROS'].AsDouble;
        FDataModule.CDSParcelaPagamento.FieldByName('TAXA_MULTA').AsFloat := ResultSet.Value['TAXA_MULTA'].AsDouble;
        FDataModule.CDSParcelaPagamento.FieldByName('TAXA_DESCONTO').AsFloat := ResultSet.Value['TAXA_DESCONTO'].AsDouble;
        FDataModule.CDSParcelaPagamento.FieldByName('VALOR_JUROS').AsFloat := ResultSet.Value['VALOR_JUROS'].AsDouble;
        FDataModule.CDSParcelaPagamento.FieldByName('VALOR_MULTA').AsFloat := ResultSet.Value['VALOR_MULTA'].AsDouble;
        FDataModule.CDSParcelaPagamento.FieldByName('VALOR_DESCONTO').AsFloat := ResultSet.Value['VALOR_DESCONTO'].AsDouble;
        FDataModule.CDSParcelaPagamento.FieldByName('TOTAL_PARCELA').AsFloat := ResultSet.Value['TOTAL_PARCELA'].AsDouble;
        FDataModule.CDSParcelaPagamento.FieldByName('HISTORICO').AsString := ResultSet.Value['HISTORICO'].AsString;
        FDataModule.CDSParcelaPagamento.Post;
      end;
      FDataModule.CDSParcelaPagamento.Open;
      FDataModule.CDSParcelaPagamento.EnableControls;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TParcelaPagamentoController.Altera(pParcela: TContasParcelasVO);
begin
  try
    try
      DecimalSeparator := '.';
      TT2TiORM.Alterar(pParcela);
      DecimalSeparator := ',';
      Consulta('ID_CONTAS_PAGAR_RECEBER = '+ IntToStr(pParcela.IdContasPagarReceber));
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
