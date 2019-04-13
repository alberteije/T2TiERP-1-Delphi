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
unit OperadorFuncionarioController;

interface

uses
  Classes, SQLExpr, SysUtils, OperadorVO, FuncionarioVO, Generics.Collections;

type
  TOperadorFuncionarioController = class
  protected
  public
    class Function ConsultaOperador(): TObjectList<TOperadorVO>;
    class Function ConsultaFuncinario(): TObjectList<TFuncionarioVO>;
    class Function GravaCargaOperador(Operador:TOperadorVO; Funcionario: TFuncionarioVO):boolean;
    class Function ConsultaUsuario(Login: String; Senha: String): TOperadorVO;
    class function ConsultaIdOperador(Id: Integer): Integer;
    class function ConsultaIdVendedor(Id: Integer): Integer;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;
  Operador: TOperadorVO;
  Funcionario: TFuncionarioVO;

class Function TOperadorFuncionarioController.ConsultaOperador(): TObjectList<TOperadorVO>;
var
  ConsultaOperador: TObjectList<TOperadorVO>;
begin
  ConsultaSQL := 'select O.ID,O.ID_ECF_FUNCIONARIO,O.LOGIN,O.SENHA '+
                 'from ECF_OPERADOR O, ECF_FUNCIONARIO F where O.ID_ECF_FUNCIONARIO=F.ID';
  try
    try
      ConsultaOperador := TObjectList<TOperadorVO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        Operador := TOperadorVO.Create;
        Operador.Id := Query.FieldByName('ID').AsInteger;
        Operador.IdFuncionario := Query.FieldByName('ID_ECF_FUNCIONARIO').AsInteger;
        Operador.Login := Query.FieldByName('LOGIN').AsString;
        Operador.Senha := Query.FieldByName('SENHA').AsString;
        ConsultaOperador.Add(Operador);
        Query.Next;
      end;
      result := ConsultaOperador;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class Function TOperadorFuncionarioController.ConsultaFuncinario(): TObjectList<TFuncionarioVO>;
var
  ConsultaFuncionario: TObjectList<TFuncionarioVO>;
begin
  ConsultaSQL := 'select * from ECF_FUNCIONARIO';
  try
    try
      ConsultaFuncionario := TObjectList<TFuncionarioVO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        Funcionario := TFuncionarioVO.Create;
        Funcionario.Id := Query.FieldByName('ID').AsInteger;
        Funcionario.Nome := Query.FieldByName('NOME').AsString;
        Funcionario.Telefone := Query.FieldByName('TELEFONE').AsString;
        Funcionario.Celular := Query.FieldByName('CELULAR').AsString;
        Funcionario.Email := Query.FieldByName('EMAIL').AsString;
        Funcionario.ComissaoVista := Query.FieldByName('COMISSAO_VISTA').AsFloat;
        Funcionario.ComissaoPrazo := Query.FieldByName('COMISSAO_PRAZO').AsFloat;
        Funcionario.NivelAutorizacao := Query.FieldByName('NIVEL_AUTORIZACAO').AsString;
        ConsultaFuncionario.Add(Funcionario);
        Query.Next;
      end;

      result := ConsultaFuncionario;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TOperadorFuncionarioController.GravaCargaOperador(Operador: TOperadorVO; Funcionario: TFuncionarioVO): boolean;
var
  ID, IDF: integer;
begin
  try
    try

        ID := Funcionario.Id;

        if ID = 0 then
        begin
          ID := ConsultaIdVendedor(ID)+1 ;
          ConsultaSQL := 'INSERT INTO ECF_FUNCIONARIO ' +
          ' (ID, '+
          'NOME, '+
          'TELEFONE, '+
          'CELULAR, '+
          'EMAIL, '+
          'COMISSAO_VISTA, '+
          'COMISSAO_PRAZO, '+
          'NIVEL_AUTORIZACAO) '+
          ' VALUES ('+
          IntToStr(ID)+', '+                                     //    ID                    INTEGER NOT NULL,
          QuotedStr(Funcionario.Nome)+', '+                      //    NOME               VARCHAR(100),
          QuotedStr(Funcionario.Telefone)+', '+                  //    TELEFONE           VARCHAR(10),
          QuotedStr(Funcionario.Celular)+', '+                   //    CELULAR            VARCHAR(10),
          QuotedStr(Funcionario.Email)+', '+                     //    EMAIL              VARCHAR(250),
          FloatToStr(Funcionario.ComissaoVista)+', '+            //    COMISSAO_VISTA     DECIMAL(18,6),
          FloatToStr(Funcionario.ComissaoPrazo)+', '+            //    COMISSAO_PRAZO     DECIMAL(18,6),
          QuotedStr(Funcionario.NivelAutorizacao)+')';           //    NIVEL_AUTORIZACAO  CHAR(1)
        end else
        begin
          ConsultaSQL := ' update ECF_FUNCIONARIO set '+
          'NOME ='+              QuotedStr(Funcionario.Nome)+', '+              //    NOME               VARCHAR(100),
          'TELEFONE ='+          QuotedStr(Funcionario.Telefone)+', '+          //    TELEFONE           VARCHAR(10),
          'CELULAR ='+           QuotedStr(Funcionario.Celular)+', '+           //    CELULAR            VARCHAR(10),
          'EMAIL ='+             QuotedStr(Funcionario.Email)+', '+             //    EMAIL              VARCHAR(250),
          'COMISSAO_VISTA ='+    FloatToStr(Funcionario.ComissaoVista)+', '+    //    COMISSAO_VISTA     DECIMAL(18,6),
          'COMISSAO_PRAZO ='+    FloatToStr(Funcionario.ComissaoPrazo)+', '+    //    COMISSAO_PRAZO     DECIMAL(18,6),
          'NIVEL_AUTORIZACAO ='+ QuotedStr(Funcionario.NivelAutorizacao)+       //    NIVEL_AUTORIZACAO  CHAR(1)
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

  try
    try
        if ID = 0 then
        begin
          IDF := ConsultaIdVendedor(ID)+1;
          ConsultaSQL := 'INSERT INTO ECF_OPERADOR '+
          ' (ID, '+
          'ID_ECF_FUNCIONARIO, '+
          'LOGIN, '+
          'SENHA )'+
          ' VALUES ('+
          IntToStr(ID)+', '+                   //    ID                    INTEGER NOT NULL,
          IntToStr(Funcionario.Id)+', '+       //     ID_ECF_FUNCIONARIO  INTEGER NOT NULL,
          QuotedStr(Operador.Login)+', '+      //     LOGIN               VARCHAR(20),
          QuotedStr(Operador.Senha)+')';       //     SENHA               VARCHAR(20)
        end else
        begin
          ConsultaSQL := ' update ECF_OPERADOR set '+
          'ID_ECF_FUNCIONARIO ='+ IntToStr(Funcionario.Id)+', '+   //     ID_ECF_FUNCIONARIO  INTEGER NOT NULL,
          'LOGIN ='+              QuotedStr(Operador.Login)+', '+  //     LOGIN               VARCHAR(20),
          'SENHA ='+              QuotedStr(Operador.Senha)+       //     SENHA               VARCHAR(20)
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

class Function TOperadorFuncionarioController.ConsultaUsuario(Login: String; Senha: String): TOperadorVO;
begin
  // somento o administrador terá acesso
  ConsultaSQL := 'select O.ID,O.ID_ECF_FUNCIONARIO,O.LOGIN,O.SENHA,F.NIVEL_AUTORIZACAO '+
                 'from ECF_OPERADOR O, ECF_FUNCIONARIO F where F.NIVEL_AUTORIZACAO=''A'' AND O.ID_ECF_FUNCIONARIO=F.ID '+
                 'AND LOGIN=' + QuotedStr(Login) +' and SENHA='+QuotedStr(Senha);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Operador := TOperadorVO.Create;
      Operador.Id := Query.FieldByName('ID').AsInteger;
      Operador.IdFuncionario := 0 ;
      Operador.Login := Query.FieldByName('LOGIN').AsString;
      Operador.Senha := Query.FieldByName('SENHA').AsString;

      result := Operador;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TOperadorFuncionarioController.ConsultaIdVendedor(Id: Integer): Integer;
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
      begin
        result := Query.FieldByName('ID').AsInteger;
      end else
      begin
        ConsultaSQL := 'select max(ID) as ID from ECF_FUNCIONARIO';
        Query.Close;
        Query.sql.Clear;
        Query.sql.Text := ConsultaSQL;
        Query.Open;

        if not Query.IsEmpty then
        begin
          result := Query.FieldByName('ID').AsInteger;
        end else
        begin
          result := 0;
        end;
      end;
    except
      result := 0;
    end;
  finally
    Query.Free;
  end;
end;

class function TOperadorFuncionarioController.ConsultaIdOperador(Id: Integer): Integer;
begin
  ConsultaSQL := 'select ID from ECF_OPERADOR where (ID = :pID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger:=Id;
      Query.Open;
      if not Query.IsEmpty then
      begin
        result := Query.FieldByName('ID').AsInteger;
      end else
      begin
        ConsultaSQL := 'select max(ID) as ID from ECF_OPERADOR';
        Query.Close;
        Query.sql.Clear;
        Query.sql.Text := ConsultaSQL;
        Query.Open;

        if not Query.IsEmpty then
        begin
          result := Query.FieldByName('ID').AsInteger;
        end else
        begin
          result := 0;
        end;
      end;
    except
      result := 0;
    end;
  finally
    Query.Free;
  end;
end;

end.
