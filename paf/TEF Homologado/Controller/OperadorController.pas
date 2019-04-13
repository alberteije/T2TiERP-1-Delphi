{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do operador.

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
unit OperadorController;

interface

uses
  Classes, SQLExpr, SysUtils, OperadorVO;

type
  TOperadorController = class
  protected
  public
    class Function ConsultaUsuario(Login: String; Senha: String): TOperadorVO;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class Function TOperadorController.ConsultaUsuario(Login: String; Senha: String): TOperadorVO;
var
  Operador: TOperadorVO;
begin
  ConsultaSQL := 'select O.ID,O.ID_ECF_FUNCIONARIO,O.LOGIN,O.SENHA,F.NIVEL_AUTORIZACAO '+
                 'from ECF_OPERADOR O, ECF_FUNCIONARIO F where O.ID_ECF_FUNCIONARIO=F.ID '+
                 'AND LOGIN=' + QuotedStr(Login) +' and SENHA='+QuotedStr(Senha);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Operador := TOperadorVO.Create;
      Operador.Id := Query.FieldByName('ID').AsInteger;
      Operador.IdFuncionario := Query.FieldByName('ID_ECF_FUNCIONARIO').AsInteger;
      Operador.Login := Query.FieldByName('LOGIN').AsString;
      Operador.Senha := Query.FieldByName('SENHA').AsString;
      Operador.Nivel := Query.FieldByName('NIVEL_AUTORIZACAO').AsString;

      result := Operador;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
