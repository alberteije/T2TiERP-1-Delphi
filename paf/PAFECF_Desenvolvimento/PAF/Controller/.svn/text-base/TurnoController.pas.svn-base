{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do turno.

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
unit TurnoController;

interface

uses
  Classes, SQLExpr, SysUtils;

type
  TTurnoController = class
  protected
  public
    class function ConsultaIdTurno(Id: Integer): Boolean;
    class function GravaCargaTurno(vTupla: String): Boolean;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TTurnoController.ConsultaIdTurno(Id: Integer): boolean;
begin
  ConsultaSQL := 'select ID from ECF_TURNO where (ID = :pID) ';
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

class function TTurnoController.GravaCargaTurno(vTupla: String): Boolean;
var
  ID: Integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL :=
        ' UPDATE OR INSERT INTO ECF_TURNO '+
        ' (ID, '+
        'DESCRICAO, '+
        'HORA_INICIO, '+
        'HORA_FIM) '+
        'values ('+
        DevolveConteudoDelimitado('|',vTupla)+','+  //    ID           INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+','+  //    DESCRICAO    VARCHAR(10),
        DevolveConteudoDelimitado('|',vTupla)+','+  //    HORA_INICIO  VARCHAR(8),
        DevolveConteudoDelimitado('|',vTupla)+')';  //    HORA_FIM     VARCHAR(8)
      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdTurno(ID) then
          ConsultaSQL :=
          'INSERT INTO ECF_TURNO '+
          ' (ID, '+
          'DESCRICAO, '+
          'HORA_INICIO, '+
          'HORA_FIM) '+
          'values ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+','+  //    DESCRICAO    VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+','+  //    HORA_INICIO  VARCHAR(8),
          DevolveConteudoDelimitado('|',vTupla)+')'  //    HORA_FIM     VARCHAR(8)
        else
          ConsultaSQL := ' update ECF_TURNO set '+
          'DESCRICAO ='+     DevolveConteudoDelimitado('|',vTupla)+','+  //    DESCRICAO    VARCHAR(10),
          'HORA_INICIO ='+   DevolveConteudoDelimitado('|',vTupla)+','+  //    HORA_INICIO  VARCHAR(8),
          'HORA_FIM ='+      DevolveConteudoDelimitado('|',vTupla)+      //    HORA_FIM     VARCHAR(8)
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
