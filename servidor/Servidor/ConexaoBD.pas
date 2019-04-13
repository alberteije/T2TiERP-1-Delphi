{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle de conexões ao SGBD

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
@version 1.1
*******************************************************************************}
unit ConexaoBD;

interface

uses Classes, SQLExpr, WideStrings, DB, SysUtils, DBXMySql, DBXFirebird,
     DBXInterbase, DBXMsSQL, DBXOracle, DbxDb2, SWSystem;

type

  TDBExpress = class(TSQLConnection)
  private
    class var Banco: String;
    class var Conexao: TSQLConnection;
    class procedure ConfigurarConexao(var pConexao: TSQLConnection; pBD: String);
  public
    class procedure Conectar(BD: String);
    class procedure Desconectar;
    class function getConexao: TSQLConnection;
    class function getBanco: String;
  end;

implementation


class procedure TDBExpress.Conectar(BD: String);
begin
  Conexao := TSQLConnection.Create(nil);
  ConfigurarConexao(Conexao, BD);
  Conexao.KeepConnection := True;
  Conexao.AutoClone := False;
  Conexao.Connected := True;
  Banco := BD;
end;

class procedure TDBExpress.Desconectar;
begin
  Conexao.Connected := False;
end;

class function TDBExpress.getBanco: String;
begin
  Result := Banco;
end;

class function TDBExpress.getConexao: TSQLConnection;
begin
  try
    try
      {
        Previne o erro "MySQL Server has gone away"
        
        "DO 1" é o equivalente a "Select 1", mas sem retorno. Envia um pacote ínfimo.

        Para evitar fazer isso a cada solicitação de conexão pode-se colocar o 
        comando num timmer, que será executando a cada tempo equivalente ao 
        "wait_timeout" do MySQL, que é de 8 horas por padrão.

        No segundo ciclo veremos algo sobre pool de conexão, além de adicionar
        Zeos e Firedac ao servidor.
      }
      Conexao.Execute('DO 1',nil);
    except
      Conexao.Close;
      Conexao.Open;
    end;
  finally
    Result := Conexao;
  end;
end;

class procedure TDBExpress.ConfigurarConexao(var pConexao: TSQLConnection; pBD: String);
var
  Arquivo: String;
  Parametros: TStrings;
begin
  if pBD = 'Oracle' then
  begin
    //carrega o arquivo de parametros (neste caso o do MySQL)
    Arquivo := gsAppPath + 'Oracle_DBExpress_conn.txt';

    Conexao.DriverName     := 'Oracle';
    Conexao.ConnectionName := 'OracleConnection';
    Conexao.GetDriverFunc  := 'getSQLDriverORACLE';
    Conexao.LibraryName    := 'dbxora.dll';
    Conexao.VendorLib      := 'oci.dll';
  end
  else 
  if pBD = 'MSSQL' then
  begin
    //carrega o arquivo de parametros (neste caso o do MySQL)
    Arquivo := gsAppPath + 'MSSQL_DBExpress_conn.txt';

    Conexao.DriverName     := 'MSSQL';
    Conexao.ConnectionName := 'MSSQLCONNECTION';
    Conexao.GetDriverFunc  := 'getSQLDriverMSSQL';
    Conexao.LibraryName    := 'dbxmss.dll';
    Conexao.VendorLib      := 'oledb';
  end
  else 
  if pBD = 'Firebird' then
  begin
    //carrega o arquivo de parametros (neste caso o do MySQL)
    Arquivo := gsAppPath + 'Firebird_DBExpress_conn.txt';

    Conexao.DriverName     := 'Firebird';
    Conexao.ConnectionName := 'FBConnection';
    Conexao.GetDriverFunc  := 'getSQLDriverINTERBASE';
    Conexao.LibraryName    := 'dbxfb.dll';
    Conexao.VendorLib      := 'fbclient.dll';
  end
  else 
  if pBD = 'Interbase' then
  begin
    //carrega o arquivo de parametros (neste caso o do MySQL)
    Arquivo := gsAppPath + 'Interbase_DBExpress_conn.txt';

    Conexao.DriverName     := 'Interbase';
    Conexao.ConnectionName := 'IBConnection';
    Conexao.GetDriverFunc  := 'getSQLDriverINTERBASE';
    Conexao.LibraryName    := 'dbxint.dll';
    Conexao.VendorLib      := 'gds32.dll';
  end
  else 
  if pBD = 'MySQL' then
  begin
    //carrega o arquivo de parametros (neste caso o do MySQL)
    Arquivo := gsAppPath + 'MySQL_DBExpress_conn.txt';

    Conexao.DriverName     := 'MySQL';
    Conexao.ConnectionName := 'MySQLConnection';
    Conexao.GetDriverFunc  := 'getSQLDriverMYSQL';
    Conexao.LibraryName    := 'dbxmys.dll';
    Conexao.VendorLib      := 'libmysql.dll';
  end
  else 
  if pBD = 'DB2' then
  begin
    //carrega o arquivo de parametros (neste caso o do MySQL)
    Arquivo := gsAppPath + 'DB2_DBExpress_conn.txt';

    Conexao.DriverName     := 'Db2';
    Conexao.ConnectionName := 'DB2Connection';
    Conexao.GetDriverFunc  := 'getSQLDriverDB2';
    Conexao.LibraryName    := 'dbxdb2.dll';
    Conexao.VendorLib      := 'db2cli.dll';
  end
  else 
  if pBD = 'Postgres' then
  begin
    //carrega o arquivo de parametros (neste caso o do Postgres)
    Arquivo := gsAppPath + 'Postgres_DBExpress_conn.txt';

    Conexao.DriverName     := 'DevartPostgreSQL';
    Conexao.ConnectionName := 'PostgreConnection';
    Conexao.GetDriverFunc  := 'getSQLDriverPostgreSQL';
    Conexao.LibraryName    := 'dbexppgsql40.dll';
    Conexao.VendorLib      := 'not used';
  end;
  //variável para carregar os parametros do banco
  Parametros := TStringList.Create;
  try
    Parametros.LoadFromFile(Arquivo);
    Conexao.Params.Text := Parametros.Text;
  finally
    Parametros.Free;
  end;
  Conexao.LoginPrompt := False;
  Conexao.Name := 'Conexao';
end;

end.
