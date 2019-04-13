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
  Classes, SQLExpr, SysUtils, UsuarioVO, Generics.Collections, PessoaVO;

type
  TOperadorController = class
  protected
  public
    class Function ConsultaUsuario(Login: String; Senha: String): TUsuarioVO;
    class function RetornaFuncionario: TObjectList<TPessoaVO>;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class Function TOperadorController.ConsultaUsuario(Login: String; Senha: String): TUsuarioVO;
var
  Usuario: TUsuarioVO;
begin
  ConsultaSQL := 'select * '+
                 'from USUARIO O where '+
                 'LOGIN= '+QuotedStr(Login)+' and SENHA='+QuotedStr(Senha);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Usuario := TUsuarioVO.Create;
      Usuario.Id := Query.FieldByName('ID').AsInteger;
      Usuario.Login := Query.FieldByName('LOGIN').AsString;
      Usuario.Senha := Query.FieldByName('SENHA').AsString;
      Usuario.NivelAutorizacaoEcf := Query.FieldByName('NIVEL_AUTORIZACAO_ECF').AsString;

      result := Usuario;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TOperadorController.RetornaFuncionario: TObjectList<TPessoaVO>;
var
  ListaFuncionario: TObjectList<TPessoaVO>;
  Funcionario: TPessoaVO;
  temp:string;
begin

  ConsultaSQL :=
    'select ID, NOME  from PESSOA where COLABORADOR= ' + QuotedStr('S') + ' order by NOME';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      if Query.IsEmpty then
      begin
        Result := nil;
      end
      else
      begin
        ListaFuncionario := TObjectList<TPessoaVO>.Create;
        Query.First;

        while not Query.Eof do
        begin
          Funcionario := TPessoaVO.Create;

          Funcionario.Id := Query.FieldByName('ID').AsInteger;
          Funcionario.Nome := Query.FieldByName('NOME').Asstring;

          ListaFuncionario.Add(Funcionario);
          Query.next;
        end;
        result := ListaFuncionario;
      end;
    except
      Result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
