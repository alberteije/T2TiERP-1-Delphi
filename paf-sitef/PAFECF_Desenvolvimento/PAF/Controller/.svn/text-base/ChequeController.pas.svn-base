{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do cheque do cliente.

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

@author Albert Eije (T2Ti.COM) | Gilson Santos Lima
@version 1.0
*******************************************************************************}
unit ChequeController;

interface

uses
  Classes, SQLExpr, SysUtils, ChequeClienteVO, Generics.Collections;

type
  TChequeController = class
  protected
  public
    class Function IncluirCheque(pListaCheque: TObjectList<TChequeClienteVO>): boolean;
    class Function ExcluiCheque(Id: Integer):boolean;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL : String;
  Query: TSQLQuery;


class function TChequeController.IncluirCheque(pListaCheque: TObjectList<TChequeClienteVO>): boolean;
var
  i : integer;
  Cheque : TChequeClienteVO;
begin
  ConsultaSQL :=  'insert into ECF_CHEQUE_CLIENTE ( '+
                  'ID_BANCO,' +
                  'ID_CLIENTE,' +
                  'ID_ECF_MOVIMENTO,' +
                  'NUMERO_CHEQUE,' +
                  'DATA_CHEQUE,' +
                  'AGENCIA,' +
                  'CONTA,' +
                  'OBSERVACOES,' +
                  'TIPO_CHEQUE,' +
                  'VALOR_CHEQUE) values ('+
                  ':pID_BANCO,' +
                  ':pID_CLIENTE,' +
                  ':pID_ECF_MOVIMENTO,' +
                  ':pNUMERO_CHEQUE,' +
                  ':pDATA_CHEQUE,' +
                  ':pAGENCIA,' +
                  ':pCONTA,' +
                  ':pOBSERVACOES,' +
                  ':pTIPO_CHEQUE,' +
                  ':pVALOR_CHEQUE)';


  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      for i := 0 to Pred(pListaCheque.Count) do
      begin
        Cheque := pListaCheque.Items[i];
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pID_BANCO').AsInteger         := cheque.IdBanco;
        Query.ParamByName('pID_CLIENTE').AsInteger       := cheque.IdCliente;
        Query.ParamByName('pID_ECF_MOVIMENTO').AsInteger := cheque.IdEcfMovimento;
        Query.ParamByName('pNUMERO_CHEQUE').AsInteger    := cheque.NumeroCheque;
        Query.ParamByName('pDATA_CHEQUE').AsString       := cheque.DataCheque;
        Query.ParamByName('pAGENCIA').AsString           := cheque.Agencia;
        Query.ParamByName('pCONTA').AsString             := cheque.Conta;
        Query.ParamByName('pOBSERVACOES').AsString       := cheque.Observacoes;
        Query.ParamByName('pTIPO_CHEQUE').AsString       := cheque.TipoCheque;
        Query.ParamByName('pVALOR_CHEQUE').AsFloat       := cheque.ValorCheque;

        Query.ExecSQL();
      end;

      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;

end;

class function TChequeController.ExcluiCheque(Id: Integer): boolean;
begin
  ConsultaSQL :=  'delete from ECF_CHEQUE_CLIENTE  where id = :pID ';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pID').AsInteger := Id;

      Query.ExecSQL();

      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

end.
