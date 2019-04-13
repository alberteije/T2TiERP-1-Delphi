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

@author Albert Eije (T2Ti.COM) | Gilson Santos Lima
@version 1.0
*******************************************************************************}
unit FichaTecnicaController;

interface

uses
  Classes, SQLExpr, SysUtils, FichaTecnicaVO;

type
  TFichaTecnicaController = class
  protected
  public
    class function GravaFichaTecnica(FichaTecnica: TFichaTecnicaVO): Boolean;
    class function ExcluiFichaTecnica(Id: Integer): Boolean;
    class function ConsultaIdFichaTecnica(Id: Integer): Boolean;
    class function GravaCargaFichaTecnica(vTupla: String): Boolean;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TFichaTecnicaController.GravaFichaTecnica(FichaTecnica:TFichaTecnicaVO): boolean;
begin

  ConsultaSQL :=  'insert into ficha_tecnica ( '+
                  'ID_PRODUTO,' +
                  'DESCRICAO,' +
                  'ID_PRODUTO_FILHO,' +
                  'QUANTIDADE) '+
                  ' values ('+
                  ':pID_PRODUTO,'+
                  ':pDESCRICAO,'+
                  ':pID_PRODUTO_FILHO,'+
                  ':pQUANTIDADE)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pID_PRODUTO').AsInteger := FichaTecnica.IdProduto;
      Query.ParamByName('pDESCRICAO').AsString   := FichaTecnica.Descricao;
      Query.ParamByName('pID_PRODUTO_FILHO').AsInteger := FichaTecnica.IdProdutoFilho;
      Query.ParamByName('pQUANTIDADE').AsFloat         := FichaTecnica.Quantidade;
      Query.ExecSQL();

      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;

end;

class function TFichaTecnicaController.ConsultaIdFichaTecnica(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from ficha_tecnica where (ID = :pID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger:=Id;
      Query.Open;
      if not Query.IsEmpty then
        result := true
      else
        result := false;
    except
       result := false;
    end;
  finally
    Query.Free;
  end;
end;

class function TFichaTecnicaController.ExcluiFichaTecnica(Id: Integer): Boolean;
begin
    ConsultaSQL :=  'delete from FICHA_TECNICA where id = :pID ';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger := Id;
      Query.ExecSQL();
      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;

end;

class function TFichaTecnicaController.GravaCargaFichaTecnica(vTupla:string): Boolean;
var
  ID: Integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
      ConsultaSQL := 'UPDATE OR INSERT INTO FICHA_TECNICA ' +
                    ' (ID, '+
                    'ID_PRODUTO, '+
                    'DESCRICAO, '+
                    'ID_PRODUTO_FILHO, '+
                    'QUANTIDADE )'+
                    ' VALUES ('+
                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID                INTEGER NOT NULL,
                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO        INTEGER NOT NULL,
                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO         VARCHAR(50),
                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO_FILHO  INTEGER,
                    DevolveConteudoDelimitado('|',vTupla)+')';   //    QUANTIDADE        DECIMAL(18,6)
      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdFichaTecnica(ID) then
          ConsultaSQL := 'INSERT INTO FICHA_TECNICA '+
          ' (ID, '+
          'ID_PRODUTO, '+
          'DESCRICAO, '+
          'ID_PRODUTO_FILHO, '+
          'QUANTIDADE )'+
          ' VALUES ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO        INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO         VARCHAR(50),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO_FILHO  INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+')'    //    QUANTIDADE        DECIMAL(18,6)
         else
          ConsultaSQL := ' update FICHA_TECNICA set '+
          'ID_PRODUTO ='+        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO        INTEGER NOT NULL,
          'DESCRICAO ='+         DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO         VARCHAR(50),
          'ID_PRODUTO_FILHO ='+  DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO_FILHO  INTEGER,
          'QUANTIDADE ='+        DevolveConteudoDelimitado('|',vTupla)+    //    QUANTIDADE        DECIMAL(18,6)
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
