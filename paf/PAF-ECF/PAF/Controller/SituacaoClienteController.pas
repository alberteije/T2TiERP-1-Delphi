{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da situação do cliente.

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

@author  (T2Ti.COM) | Jose Rodrigues de Oliveira Junior
@version 1.0
*******************************************************************************}
unit SituacaoClienteController;

interface

uses
  Classes, SQLExpr, SysUtils, SituacaoClienteVO, Generics.Collections;

type
  TSituacaoClienteController = class
  protected
  public
    class function TabelaSituacaoCliente: TObjectList<TSituacaoClienteVO>;
    class function ConsultaIdSituacaoCliente(Id: Integer): Boolean;
    class function GravaCargaSituacaoCliente(vTupla: String): Boolean;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;


class function TSituacaoClienteController.TabelaSituacaoCliente: TObjectList<TSituacaoClienteVO>;
var
  ListaSituacaoCliente: TObjectList<TSituacaoClienteVO>;
  SituacaoCliente: TSituacaoClienteVO;
begin
  try
    try
      ConsultaSQL := 'select * from SITUACAO_CLIENTE';
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaSituacaoCliente := TObjectList<TSituacaoClienteVO>.Create;

      Query.First;
      while not Query.Eof do
      begin
        SituacaoCliente := TSituacaoClienteVO.Create;
        SituacaoCliente.Id := Query.FieldByName('ID').AsInteger;
        SituacaoCliente.Nome := Query.FieldByName('NOME').AsString;
        SituacaoCliente.Descricao := Query.FieldByName('DESCRICAO').AsString;
        ListaSituacaoCliente.Add(SituacaoCliente);
        Query.next;
      end;
      result := ListaSituacaoCliente;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSituacaoClienteController.ConsultaIdSituacaoCliente(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from SITUACAO_CLIENTE where (ID = :pID) ';
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

class function TSituacaoClienteController.GravaCargaSituacaoCliente(vTupla: String): Boolean;
var
  ID: Integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL := 'UPDATE OR INSERT INTO SITUACAO_CLIENTE '+
        ' (ID, '+
        'NOME, '+
        'DESCRICAO)'+
        ' values ('+
        DevolveConteudoDelimitado('|',vTupla)+','+  //   ID         INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+','+  //   NOME       VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+')';  //   DESCRICAO  VARCHAR(250)
      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));
        if not ConsultaIdSituacaoCliente(ID) then
          ConsultaSQL := ' INSERT INTO SITUACAO_CLIENTE '+
          ' (ID, '+
          'NOME, '+
          'DESCRICAO)'+
          ' values ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+','+  //   NOME       VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+')'  //   DESCRICAO  VARCHAR(250)
        else
          ConsultaSQL := ' update SITUACAO_CLIENTE set '+
          ' NOME ='     + DevolveConteudoDelimitado('|',vTupla)+','+
          'DESCRICAO =' + DevolveConteudoDelimitado('|',vTupla)+')'+
          ' where ID ='+IntToStr(ID);
      end;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ExecSQL();

      result := true;

    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

end.
