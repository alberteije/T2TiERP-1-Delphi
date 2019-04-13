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
  Classes, SQLExpr, SysUtils, OperadorVO, FuncionarioVO, Generics.Collections;

type
  TOperadorController = class
  protected
  public
    class function ConsultaFuncionario(Id: Integer): String;
    class function ConsultaUsuario(Login: String; Senha: String): TOperadorVO;
    class function RetornaFuncionario: TObjectList<TFuncionarioVO>;
    class function ConsultaIdOperador(Id: Integer): Boolean;
    class function GravaCargaOperador(vTupla: String): Boolean;

  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TOperadorController.ConsultaFuncionario(Id: Integer): String;
begin

  ConsultaSQL :=
    'select ID, NOME  from ECF_FUNCIONARIO where ID ='+IntToStr(ID);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Result:= Query.FieldByName('NOME').Asstring;
    except
      Result := '';
    end;
  finally
    Query.Free;
  end;
end;

class function TOperadorController.ConsultaIdOperador(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from ECF_FUNCIONARIO where (ID = :pID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger:=Id;
      Query.Open;
      if not Query.IsEmpty then
        result := true
      else
        result := false;
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TOperadorController.ConsultaUsuario(Login: String; Senha: String): TOperadorVO;
var
  Operador: TOperadorVO;
begin
  ConsultaSQL := 'select '+
                 ' O.ID, '+
                 ' O.ID_ECF_FUNCIONARIO, '+
                 ' O.LOGIN, '+
                 ' O.SENHA, '+
                 ' F.NIVEL_AUTORIZACAO '+
                 'from '+
                 ' ECF_OPERADOR O, ECF_FUNCIONARIO F '+
                 'where '+
                 ' O.ID_ECF_FUNCIONARIO=F.ID '+
                 ' and LOGIN=' + QuotedStr(Login) +
                 ' and SENHA=' + QuotedStr(Senha);
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

class function TOperadorController.RetornaFuncionario: TObjectList<TFuncionarioVO>;
var
  ListaFuncionario: TObjectList<TFuncionarioVO>;
  Funcionario: TFuncionarioVO;
begin

  ConsultaSQL := 'select ID, NOME from ECF_FUNCIONARIO order by NOME ';

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
        ListaFuncionario := TObjectList<TFuncionarioVO>.Create;
        Query.First;

        while not Query.Eof do
        begin
          Funcionario := TFuncionarioVO.Create;
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

class function TOperadorController.GravaCargaOperador(vTupla:string):boolean;
var
  ID: integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL:= ' UPDATE OR INSERT INTO ECF_OPERADOR '+
        ' (ID, '+
        'ID_ECF_FUNCIONARIO, '+
        'LOGIN, '+
        'SENHA )'+
        ' VALUES ('+
        DevolveConteudoDelimitado('|',vTupla)+', '+  //     ID                  INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //     ID_ECF_FUNCIONARIO  INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //     LOGIN               VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+')';  //     SENHA               VARCHAR(20)
      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdOperador(ID) then
          ConsultaSQL := 'INSERT INTO ECF_OPERADOR '+
          ' (ID, '+
          'ID_ECF_FUNCIONARIO, '+
          'LOGIN, '+
          'SENHA )'+
          ' VALUES ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //     ID_ECF_FUNCIONARIO  INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //     LOGIN               VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+')'  //     SENHA               VARCHAR(20)
        else
          ConsultaSQL := ' update ECF_OPERADOR set '+
          'ID_ECF_FUNCIONARIO ='+ DevolveConteudoDelimitado('|',vTupla)+', '+  //     ID_ECF_FUNCIONARIO  INTEGER NOT NULL,
          'LOGIN ='+              DevolveConteudoDelimitado('|',vTupla)+', '+  //     LOGIN               VARCHAR(20),
          'SENHA ='+              DevolveConteudoDelimitado('|',vTupla)+  //     SENHA               VARCHAR(20)
          ' where ID ='+IntToStr(ID);
      end;
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
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
