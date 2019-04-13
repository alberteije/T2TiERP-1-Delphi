{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da EcfAliquotas.

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
unit AliquotasController;

interface

uses
  Classes, SQLExpr, SysUtils, AliquotasVO, Generics.Collections;

type
  TAliquotasController = class
  protected
  public

    class function ConsultaAliquota(icms,situacao: string): string;
    class function LocalizaAliquota(icms: string): Boolean;
    class function GravaAliquota(ID:integer;icms,situacao,totalizador: String): Boolean;
    class function DeletaAliquota: Boolean;

  end;
implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TAliquotasController.ConsultaAliquota(icms,situacao: string): string;
begin
  ConsultaSQL := 'select TOTALIZADOR_PARCIAL  from ECF_Aliquotas where (ECF_ICMS_ST = :pICMS) and ( PAF_P_ST = :pSituacao)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pICMS').AsString:=icms;
      Query.ParamByName('pSituacao').AsString:=situacao;
      Query.Open;
      if not Query.IsEmpty then
        result := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString
      else
        result := '';
    except
      result := '';
    end;
  finally
    Query.Free;
  end;
end;



class function TAliquotasController.DeletaAliquota: Boolean;
begin
  try
    try
      ConsultaSQL := 'delete from ECF_Aliquotas';

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

class function TAliquotasController.GravaAliquota(ID:integer;icms,situacao,totalizador: String): Boolean;
var Posicao, Tipo, parcial :string;
begin
  try

    Tipo := situacao;
    Posicao := DevolveInteiro(totalizador);
    parcial := icms;

    if (icms <> 'NN') and (icms <> 'II') and (icms <> 'FF')  then
    begin
      while Length(parcial)< 4 do
        parcial := parcial+'0';
    end else
    begin
      Posicao := '';
      tipo := '';
    end;

    try
      ConsultaSQL := 'insert into ECF_Aliquotas ('+
                        'ID, '+
                        'TOTALIZADOR_PARCIAL, '+
                        'ECF_ICMS_ST, '+
                        'PAF_P_ST)'+
                      'values ('+
                        ':pID, '+
                        ':pTOTALIZADOR_PARCIAL, '+
                        ':pECF_ICMS_ST, '+
                        ':pPAF_P_ST)';


      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger:=ID;
      Query.ParamByName('pTOTALIZADOR_PARCIAL').AsString:=Posicao+tipo+parcial;
      Query.ParamByName('pECF_ICMS_ST').AsString:=icms;
      Query.ParamByName('pPAF_P_ST').AsString:=situacao;


      Query.ExecSQL();
      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;

end;



class function TAliquotasController.LocalizaAliquota(icms: string): Boolean;
begin
  ConsultaSQL := 'select * from ECF_Aliquotas where (ECF_ICMS_ST = :pICMS) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pICMS').AsString:=icms;

      Query.Open;
      if not Query.IsEmpty then
        result := True
      else
        result := False;
    except
      result := False;
    end;
  finally
    Query.Free;
  end;

end;

end.
