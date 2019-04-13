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
unit ParcelaRecebimentoController;

interface

uses
  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB, Windows, Forms,
  ContasParcelasVO, Generics.Collections, Biblioteca, DBXCommon;

type
  TParcelaRecebimentoController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String);
    class Procedure Altera(pParcela: TContasParcelasVO);
  end;

implementation

uses UDataModule, T2TiORM;

var
  ParcelaRecebimento: TContasParcelasVO;

class procedure TParcelaRecebimentoController.Consulta(pFiltro: String);
var
  ResultSet : TDBXReader;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TContasParcelasVO.Create, pFiltro, 0);

      FDataModule.CDSParcelaRecebimento.DisableControls;
      FDataModule.CDSParcelaRecebimento.EmptyDataSet;
      while ResultSet.Next do
      begin
        FDataModule.CDSParcelaRecebimento.Append;
        FDataModule.CDSParcelaRecebimento.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
        FDataModule.CDSParcelaRecebimento.FieldByName('NUMERO_PARCELA').AsInteger := ResultSet.Value['NUMERO_PARCELA'].AsInt32;
        FDataModule.CDSParcelaRecebimento.FieldByName('DATA_EMISSAO').AsString := ResultSet.Value['DATA_EMISSAO'].AsString;
        FDataModule.CDSParcelaRecebimento.FieldByName('DATA_VENCIMENTO').AsString := ResultSet.Value['DATA_VENCIMENTO'].AsString;
        FDataModule.CDSParcelaRecebimento.FieldByName('SITUACAO').AsString := ResultSet.Value['SITUACAO'].AsString;
        FDataModule.CDSParcelaRecebimento.FieldByName('BOLETO').AsString := 'X';
        FDataModule.CDSParcelaRecebimento.FieldByName('ID_CONTAS_PAGAR_RECEBER').AsInteger := ResultSet.Value['ID_CONTAS_PAGAR_RECEBER'].AsInt32;
        FDataModule.CDSParcelaRecebimento.FieldByName('VALOR').AsFloat := ResultSet.Value['VALOR'].AsDouble;
        try
          FDataModule.CDSParcelaRecebimento.FieldByName('DATA_PAGAMENTO').AsString := ResultSet.Value['DATA_PAGAMENTO'].AsString;
        except
          FDataModule.CDSParcelaRecebimento.FieldByName('DATA_PAGAMENTO').AsString := '';
        end;
        FDataModule.CDSParcelaRecebimento.FieldByName('TAXA_JUROS').AsFloat := ResultSet.Value['TAXA_JUROS'].AsDouble;
        FDataModule.CDSParcelaRecebimento.FieldByName('TAXA_MULTA').AsFloat := ResultSet.Value['TAXA_MULTA'].AsDouble;
        FDataModule.CDSParcelaRecebimento.FieldByName('TAXA_DESCONTO').AsFloat := ResultSet.Value['TAXA_DESCONTO'].AsDouble;
        FDataModule.CDSParcelaRecebimento.FieldByName('VALOR_JUROS').AsFloat := ResultSet.Value['VALOR_JUROS'].AsDouble;
        FDataModule.CDSParcelaRecebimento.FieldByName('VALOR_MULTA').AsFloat := ResultSet.Value['VALOR_MULTA'].AsDouble;
        FDataModule.CDSParcelaRecebimento.FieldByName('VALOR_DESCONTO').AsFloat := ResultSet.Value['VALOR_DESCONTO'].AsDouble;
        FDataModule.CDSParcelaRecebimento.FieldByName('TOTAL_PARCELA').AsFloat := ResultSet.Value['TOTAL_PARCELA'].AsDouble;
        FDataModule.CDSParcelaRecebimento.FieldByName('HISTORICO').AsString := ResultSet.Value['HISTORICO'].AsString;
        FDataModule.CDSParcelaRecebimento.Post;
      end;
      FDataModule.CDSParcelaRecebimento.Open;
      FDataModule.CDSParcelaRecebimento.EnableControls;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TParcelaRecebimentoController.Altera(pParcela: TContasParcelasVO);
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
