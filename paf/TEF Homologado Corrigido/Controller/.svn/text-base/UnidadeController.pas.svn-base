{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da unidade.

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
unit UnidadeController;

interface

uses
  Classes, SQLExpr, SysUtils, UnidadeVO, Generics.Collections;

type
  TUnidadeController = class
  protected
  public
    class Function TabelaUnidade: TObjectList<TUnidadeVO>;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TUnidadeController.TabelaUnidade: TObjectList<TUnidadeVO>;
var
  ListaUnidade: TObjectList<TUnidadeVO>;
  Unidade: TUnidadeVO;
begin
  try
    try
      ConsultaSQL := 'select * from UNIDADE_PRODUTO';
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaUnidade := TObjectList<TUnidadeVO>.Create;

      Query.First;
      while not Query.Eof do
      begin
        Unidade := TUnidadeVO.Create;
        Unidade.Id := Query.FieldByName('ID').AsInteger;
        Unidade.Nome := Query.FieldByName('NOME').AsString;
        Unidade.Descricao := Query.FieldByName('DESCRICAO').AsString;
        ListaUnidade.Add(Unidade);
        Query.next;
      end;
      result := ListaUnidade;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
