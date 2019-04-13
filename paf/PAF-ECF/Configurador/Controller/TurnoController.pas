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
  end;

implementation

uses UDataModule;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TTurnoController.GravaCargaTurno(Turno: TTurnoVO): boolean;
begin
  // talvez tenha que colocar if para Firebird, else if MYSQL

  // Para FIREBIRD  esta ok
  try
    FDataModule.StoredProcedure.StoredProcName:= 'CARGA_ECF_TURNO';
    FDataModule.StoredProcedure.SQLConnection:= FDataModule.Conexao;

    FDataModule.StoredProcedure.ParamByName('ID').AsInteger := Turno.Id;
    FDataModule.StoredProcedure.ParamByName('DESCRICAO').AsString := Turno.Descricao;
    FDataModule.StoredProcedure.ParamByName('HORA_INICIO').AsString := Turno.HoraInicio;
    FDataModule.StoredProcedure.ParamByName('HORA_FIM').AsString := Turno.HoraFim;

    FDataModule.StoredProcedure.ExecProc;

    result := True;
  except
    result := false;
  end;


end;





end.

