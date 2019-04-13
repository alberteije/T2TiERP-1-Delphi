{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle dos Componentes

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
unit ComponentesController;

interface

uses
  Classes, SQLExpr, SysUtils;

type
  TComponentesController = class
  protected
  public
    class function ConsultaIdComponentes(Id:Integer): Boolean;
    class function GravaCargaComponentes(vTupla: String): Boolean;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TComponentesController.ConsultaIdComponentes(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from ECF_POSICAO_COMPONENTES where (ID = :pID) ';
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

class function TComponentesController.GravaCargaComponentes(vTupla: String): Boolean;
var
  ID: integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL:= ' UPDATE OR INSERT INTO ECF_POSICAO_COMPONENTES '+
        ' (ID, '+
        'ID_ECF_RESOLUCAO, '+
        'NOME, '+
        'ALTURA, '+
        'LARGURA, '+
        'TOPO, '+
        'ESQUERDA, '+
        'TAMANHO_FONTE, '+
        'TEXTO)'+
        'values ('+
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID                INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_RESOLUCAO  INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    NOME              VARCHAR(100),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ALTURA            INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    LARGURA           INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TOPO              INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ESQUERDA          INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TAMANHO_FONTE     INTEGER DEFAULT 0,
        DevolveConteudoDelimitado('|',vTupla)+')';   //    TEXTO             VARCHAR(250)
      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdComponentes(ID) then
          ConsultaSQL := 'INSERT INTO ECF_POSICAO_COMPONENTES '+
          ' (ID, '+
          'ID_ECF_RESOLUCAO, '+
          'NOME, '+
          'ALTURA, '+
          'LARGURA, '+
          'TOPO, '+
          'ESQUERDA, '+
          'TAMANHO_FONTE, '+
          'TEXTO)'+
          'values ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_RESOLUCAO  INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    NOME              VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ALTURA            INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    LARGURA           INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TOPO              INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ESQUERDA          INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TAMANHO_FONTE     INTEGER DEFAULT 0,
          DevolveConteudoDelimitado('|',vTupla)+')'   //    TEXTO             VARCHAR(250)
        else
          ConsultaSQL := ' update ECF_POSICAO_COMPONENTES set '+
          'ID_ECF_RESOLUCAO ='+  DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_RESOLUCAO  INTEGER NOT NULL,
          'NOME ='+              DevolveConteudoDelimitado('|',vTupla)+', '+  //    NOME              VARCHAR(100),
          'ALTURA ='+            DevolveConteudoDelimitado('|',vTupla)+', '+  //    ALTURA            INTEGER,
          'LARGURA ='+           DevolveConteudoDelimitado('|',vTupla)+', '+  //    LARGURA           INTEGER,
          'TOPO ='+              DevolveConteudoDelimitado('|',vTupla)+', '+  //    TOPO              INTEGER,
          'ESQUERDA ='+          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ESQUERDA          INTEGER,
          'TAMANHO_FONTE ='+     DevolveConteudoDelimitado('|',vTupla)+', '+  //    TAMANHO_FONTE     INTEGER DEFAULT 0,
          'TEXTO ='+             DevolveConteudoDelimitado('|',vTupla)+   //    TEXTO             VARCHAR(250)
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
