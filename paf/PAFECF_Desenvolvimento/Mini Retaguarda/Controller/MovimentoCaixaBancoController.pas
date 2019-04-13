{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da view MOVIMENTO_CAIXA_BANCO 

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
unit MovimentoCaixaBancoController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, MovimentoCaixaBancoVO,
  DBXCommon, FechamentoCaixaBancoVO;

type
  TMovimentoCaixaBancoController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pFiltroFechamento: String; pPagina: Integer);
  end;

implementation

uses UDataModule, T2TiORM, UMovimentoCaixaBanco;

var
  MovimentoCaixaBanco: TMovimentoCaixaBancoVO;
  FechamentoCaixaBanco: TFechamentoCaixaBancoVO;

class procedure TMovimentoCaixaBancoController.Consulta(pFiltro: String; pFiltroFechamento: String; pPagina: Integer);
var
  ResultSet : TDBXReader;
begin
  try
    try
      //pega os dados do fechamento anterior
      resultSet := TT2TiORM.Consultar(TFechamentoCaixaBancoVO.Create, pFiltroFechamento, pPagina);
      FechamentoCaixaBanco := TFechamentoCaixaBancoVO.Create;
      if resultSet.Next then
      begin
        FechamentoCaixaBanco.Id := resultSet.Value['ID'].AsInt32;
        FechamentoCaixaBanco.IdContaCaixa := resultSet.Value['ID_CONTA_CAIXA'].AsInt32;
        FechamentoCaixaBanco.DataFechamento := resultSet.Value['DATA_FECHAMENTO'].AsString;
        FechamentoCaixaBanco.Mes := resultSet.Value['MES'].AsString;
        FechamentoCaixaBanco.Ano := resultSet.Value['ANO'].AsString;
        FechamentoCaixaBanco.SaldoAnterior := resultSet.Value['SALDO_ANTERIOR'].AsDouble;
        FechamentoCaixaBanco.Recebimentos := resultSet.Value['RECEBIMENTOS'].AsDouble;
        FechamentoCaixaBanco.Pagamentos := resultSet.Value['PAGAMENTOS'].AsDouble;
        FechamentoCaixaBanco.SaldoConta := resultSet.Value['SALDO_CONTA'].AsDouble;
        FechamentoCaixaBanco.ChequeNaoCompensado := resultSet.Value['CHEQUE_NAO_COMPENSADO'].AsDouble;
        FechamentoCaixaBanco.SaldoDisponivel := resultSet.Value['SALDO_DISPONIVEL'].AsDouble;
      end;
      UMovimentoCaixaBanco.FechamentoCaixaBancoAnterior := FechamentoCaixaBanco;
      FechamentoCaixaBanco.Free;


      //pega os dados do movimento
      resultSet := TT2TiORM.Consultar(TMovimentoCaixaBancoVO.Create, pFiltro, pPagina);
      FDataModule.CDSMovimentoCaixaBanco.DisableControls;
      FDataModule.CDSMovimentoCaixaBanco.EmptyDataSet;
      while resultSet.Next do
      begin
        FDataModule.CDSMovimentoCaixaBanco.Append;
        FDataModule.CDSMovimentoCaixaBanco.FieldByName('DATA_PAGAMENTO').AsString := resultSet.Value['DATA_PAGAMENTO'].AsString;
        FDataModule.CDSMovimentoCaixaBanco.FieldByName('NOME').AsString := resultSet.Value['NOME'].AsString;
        FDataModule.CDSMovimentoCaixaBanco.FieldByName('TOTAL_PARCELA').AsFloat := resultSet.Value['TOTAL_PARCELA'].AsDouble;
        FDataModule.CDSMovimentoCaixaBanco.FieldByName('DESCRICAO_PLANO_CONTAS').AsString := resultSet.Value['DESCRICAO_PLANO_CONTAS'].AsString;
        FDataModule.CDSMovimentoCaixaBanco.FieldByName('NOME_TIPO_DOCUMENTO').AsString := resultSet.Value['NOME_TIPO_DOCUMENTO'].AsString;
        FDataModule.CDSMovimentoCaixaBanco.FieldByName('DATA_LANCAMENTO').AsString := resultSet.Value['DATA_LANCAMENTO'].AsString;
        FDataModule.CDSMovimentoCaixaBanco.FieldByName('NATUREZA_LANCAMENTO').AsString := resultSet.Value['NATUREZA_LANCAMENTO'].AsString;
        FDataModule.CDSMovimentoCaixaBanco.FieldByName('HISTORICO').AsString := resultSet.Value['HISTORICO'].AsString;
        FDataModule.CDSMovimentoCaixaBanco.Post;
      end;
      FDataModule.CDSMovimentoCaixaBanco.Open;
      FDataModule.CDSMovimentoCaixaBanco.EnableControls;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

end.
