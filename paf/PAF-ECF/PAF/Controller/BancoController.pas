{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da Ficha Técnica.

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

@author Albert Eije (T2Ti.COM) | Jose Rodrigues de Oliveira Junior
@version 1.0
*******************************************************************************}
unit BancoController;

interface

uses
  Classes, SQLExpr, SysUtils;

type
  TBancoController = class
  protected
  public
    class function ConsultaIDBanco(pId: Integer): Integer;
    class function GravaCargaBanco(vTupla: String): Boolean;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TBancoController.ConsultaIDBanco(pId: Integer): Integer;
begin
   ConsultaSQL := 'select id from banco where id = :pId ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pId').AsInteger := pId;
      Query.Open;
      if not Query.IsEmpty then
        result := Query.fieldByName('id').AsInteger
      else
        result := 0;
    except

    end;
  finally
    Query.Free;
  end;
end;

class function TBancoController.GravaCargaBanco(vTupla: String): Boolean;
var
  ID: integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL:= 'UPDATE OR INSERT INTO BANCO '+
        ' (ID, '+
        'CODIGO, '+
        'NOME, '+
        'URL )'+
        ' VALUES ('+
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID      INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    CODIGO  VARCHAR(10),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    NOME    VARCHAR(100),
        DevolveConteudoDelimitado('|',vTupla)+')';   //    URL     VARCHAR(250)
      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if ConsultaIDBanco(ID) = 0 then
          ConsultaSQL := 'INSERT INTO BANCO '+
          ' (ID, '+
          'CODIGO, '+
          'NOME, '+
          'URL )'+
          ' VALUES ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    CODIGO  VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    NOME    VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+')'    //    URL     VARCHAR(250)
        else
          ConsultaSQL := ' update BANCO set '+
          'CODIGO ='+DevolveConteudoDelimitado('|',vTupla)+', '+  //    CODIGO  VARCHAR(10),
          'NOME ='+DevolveConteudoDelimitado('|',vTupla)+', '+    //    NOME    VARCHAR(100),
          'URL ='+DevolveConteudoDelimitado('|',vTupla)+          //    URL     VARCHAR(250)
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
