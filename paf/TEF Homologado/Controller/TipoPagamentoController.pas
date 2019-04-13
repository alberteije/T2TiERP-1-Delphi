{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do tipo de pagamento.

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
unit TipoPagamentoController;

interface

uses
  Classes, SQLExpr, SysUtils, TipoPagamentoVO, Generics.Collections;

type
  TTipoPagamentoController = class
  protected
  public
    class function ConsultaPeloID(pId: Integer): TTipoPagamentoVO;
    class function TabelaTipoPagamento: TObjectList<TTipoPagamentoVO>;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TTipoPagamentoController.ConsultaPeloID(pId: Integer): TTipoPagamentoVO;
var
  TipoPagamento : TTipoPagamentoVO;
begin
  ConsultaSQL :=
    'select * from ECF_TIPO_PAGAMENTO where id=' + QuotedStr(IntToStr(pId));

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      TipoPagamento := TTipoPagamentoVO.Create;
      TipoPagamento.Id := Query.FieldByName('ID').AsInteger;
      TipoPagamento.Codigo := Query.FieldByName('CODIGO').AsString;
      TipoPagamento.Descricao := Query.FieldByName('DESCRICAO').AsString;
      TipoPagamento.TEF := Query.FieldByName('TEF').AsString;
      TipoPagamento.ImprimeVinculado := Query.FieldByName('IMPRIME_VINCULADO').AsString;
      TipoPagamento.PermiteTroco := Query.FieldByName('PERMITE_TROCO').AsString;
      TipoPagamento.TipoGP := Query.FieldByName('TEF_Tipo_GP').AsString;

      result := TipoPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TTipoPagamentoController.TabelaTipoPagamento: TObjectList<TTipoPagamentoVO>;
var
  ListaTipoPagamento: TObjectList<TTipoPagamentoVO>;
  TipoPagamento: TTipoPagamentoVO;
begin
  try
    try
      ConsultaSQL := 'select * from ECF_TIPO_PAGAMENTO';

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaTipoPagamento := TObjectList<TTipoPagamentoVO>.Create;

      Query.First;
      while not Query.Eof do
      begin
        TipoPagamento := TTipoPagamentoVO.Create;
        TipoPagamento.Id := Query.FieldByName('ID').AsInteger;
        TipoPagamento.Codigo := Query.FieldByName('CODIGO').AsString;
        TipoPagamento.Descricao := Query.FieldByName('DESCRICAO').AsString;
        TipoPagamento.TEF := Query.FieldByName('TEF').AsString;
        TipoPagamento.ImprimeVinculado := Query.FieldByName('IMPRIME_VINCULADO').AsString;
        TipoPagamento.PermiteTroco := Query.FieldByName('PERMITE_TROCO').AsString;
        TipoPagamento.TipoGP := Query.FieldByName('TEF_Tipo_GP').AsString;
        ListaTipoPagamento.Add(TipoPagamento);
        Query.next;
      end;
      result := ListaTipoPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;


end.
