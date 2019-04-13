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
unit TurnoController;

interface

uses
  Classes, SQLExpr, SysUtils, TurnoVO;

type
  TTurnoController = class
  protected
  public
    class Function GravaCargaTurno(Turno:TTurnoVO):boolean;
    class function ConsultaIdTurno(Id: Integer): Integer;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TTurnoController.GravaCargaTurno(Turno: TTurnoVO): boolean;
var ID : integer;
begin

  try
    try

        ID := Turno.Id;
        if ID = 0 then
        begin
          ID := ConsultaIdTurno(ID)+1;
          ConsultaSQL := 'INSERT INTO ECF_TURNO '+
          ' (ID, '+
          'DESCRICAO, '+
          'HORA_INICIO, '+
          'HORA_FIM )'+
          ' VALUES ('+
          IntToStr(ID)+', '+
          QuotedStr(Turno.Descricao)+', '+
          QuotedStr(Turno.HoraInicio)+', '+
          QuotedStr(Turno.HoraFim)+')';
        end else
        begin
          ConsultaSQL := ' update ECF_TURNO set '+
          'DESCRICAO ='+     QuotedStr(Turno.Descricao)+', '+
          'HORA_INICIO ='+   QuotedStr(Turno.HoraInicio)+', '+
          'HORA_FIM ='+      QuotedStr(Turno.HoraFim)+
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

class function TTurnoController.ConsultaIdTurno(Id: Integer): Integer;
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
      begin
        result := Query.FieldByName('ID').AsInteger;
      end else
      begin
        ConsultaSQL := 'select max(ID) as ID from ECF_TURNO';
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

