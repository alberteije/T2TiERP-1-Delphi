{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do vendedor.

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
unit VendedorController;

interface

uses
  Classes, SQLExpr, SysUtils, FuncionarioVO;

type
  TVendedorController = class
  protected
  public
    class Function ConsultaVendedor(Id: Integer): TFuncionarioVO;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class Function TVendedorController.ConsultaVendedor(Id: Integer): TFuncionarioVO;
var
  Vendedor: TFuncionarioVO;
begin
  ConsultaSQL := 'select * from ECF_FUNCIONARIO where '+
                 'ID=' + IntToStr(Id);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Vendedor := TFuncionarioVO.Create;
      Vendedor.Id := Query.FieldByName('ID').AsInteger;
      Vendedor.Nome := Query.FieldByName('NOME').AsString;

      result := Vendedor;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
