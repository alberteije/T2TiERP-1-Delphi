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
begin
  // talvez tenha que colocar if para Firebird, else if MYSQL

  // Para FIREBIRD  esta ok
   try
    FDataModule.StoredProcedure.StoredProcName:= 'CARGA_ECF_FUNCIONARIO';
    FDataModule.StoredProcedure.SQLConnection:= FDataModule.Conexao;

    if Funcionario.Id <> 0 then
      FDataModule.StoredProcedure.ParamByName('ID').AsInteger := Funcionario.Id;
    FDataModule.StoredProcedure.ParamByName('NOME').AsString := Funcionario.Nome;
    FDataModule.StoredProcedure.ParamByName('TELEFONE').AsString := Funcionario.Telefone;
    FDataModule.StoredProcedure.ParamByName('CELULAR').AsString := Funcionario.Celular;
    FDataModule.StoredProcedure.ParamByName('EMAIL').AsString := Funcionario.Email;
    FDataModule.StoredProcedure.ParamByName('COMISSAO_VISTA').AsFloat := Funcionario.ComissaoVista;
    FDataModule.StoredProcedure.ParamByName('COMISSAO_PRAZO').AsFloat := Funcionario.ComissaoPrazo;
    FDataModule.StoredProcedure.ParamByName('NIVEL_AUTORIZACAO').AsString := Funcionario.NivelAutorizacao;

    FDataModule.StoredProcedure.ExecProc;

    result := True;
  except
    result := false;
  end;

  try
    FDataModule.StoredProcedure.StoredProcName:= 'CARGA_ECF_OPERADOR';
    FDataModule.StoredProcedure.SQLConnection:= FDataModule.Conexao;

    if Operador.Id <> 0 then
      FDataModule.StoredProcedure.ParamByName('ID').AsInteger := Funcionario.Id;
    FDataModule.StoredProcedure.ParamByName('ID_ECF_FUNCIONARIO').AsInteger := Funcionario.Id;
    FDataModule.StoredProcedure.ParamByName('LOGIN').AsString := Operador.Login;
    FDataModule.StoredProcedure.ParamByName('SENHA').AsString := Operador.Senha;

    FDataModule.StoredProcedure.ExecProc;

    result := True;
  except
    result := false;
  end;
end;

class Function TOperadorFuncionarioController.ConsultaUsuario(Login: String; Senha: String): TOperadorVO;
begin
//  ConsultaSQL := 'select O.ID,O.ID_ECF_FUNCIONARIO,O.LOGIN,O.SENHA,F.NIVEL_AUTORIZACAO '+
//                 'from ECF_OPERADOR O, ECF_FUNCIONARIO F where O.ID_ECF_FUNCIONARIO=F.ID '+
//                 'AND LOGIN=' + QuotedStr(Login) +' and SENHA='+QuotedStr(Senha);
//  ConsultaSQL := 'select O.ID,O.LOGIN,O.SENHA '+
//                                   'from ECF_OPERADOR O where '+
//                                   'LOGIN= '+QuotedStr(Login)+' and SENHA='+QuotedStr(Senha);

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
      Operador.IdFuncionario := 0 ;//Query.FieldByName('ID_ECF_FUNCIONARIO').AsInteger;
      Operador.Login := Query.FieldByName('LOGIN').AsString;
      Operador.Senha := Query.FieldByName('SENHA').AsString;
//      Funcionario.NivelAutorizacao := Query.FieldByName('NIVEL_AUTORIZACAO').AsString;

      result := Operador;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
