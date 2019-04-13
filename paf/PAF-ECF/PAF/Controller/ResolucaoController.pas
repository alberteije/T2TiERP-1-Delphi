{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da Resolução

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
unit ResolucaoController;

interface

uses
  Classes, SQLExpr, SysUtils;

type
  TResolucaoController = class
  protected
  public
    class function ConsultaIdResolucao(Id: Integer): Boolean;
    class function GravaCargaResolucao(vTupla: String): Boolean;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TResolucaoController.ConsultaIdResolucao(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from ECF_RESOLUCAO where (ID = :pID) ';
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

class function TResolucaoController.GravaCargaResolucao(vTupla: String): Boolean;
var
  ID: Integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL := 'UPDATE OR INSERT INTO ECF_RESOLUCAO ' +
        ' (ID, '+
        'RESOLUCAO_TELA, '+
        'LARGURA, '+
        'ALTURA, '+
        'IMAGEM_TELA, '+
        'IMAGEM_MENU, '+
        'IMAGEM_SUBMENU, '+
        'HOTTRACK_COLOR, '+
        'ITEM_STYLE_FONT_NAME, '+
        'ITEM_STYLE_FONT_COLOR, '+
        'ITEM_SEL_STYLE_COLOR, '+
        'LABEL_TOTAL_GERAL_FONT_COLOR, '+
        'ITEM_STYLE_FONT_STYLE, '+
        'EDITS_COLOR, '+
        'EDITS_FONT_COLOR, '+
        'EDITS_DISABLED_COLOR, '+
        'EDITS_FONT_NAME, '+
        'EDITS_FONT_STYLE) '+
        ' values ('+
        DevolveConteudoDelimitado('|',vTupla)+', '+   //   ID                            INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    RESOLUCAO_TELA                VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    LARGURA                       INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    ALTURA                        INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    IMAGEM_TELA                   VARCHAR(50),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    IMAGEM_MENU                   VARCHAR(50),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    IMAGEM_SUBMENU                VARCHAR(50),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    HOTTRACK_COLOR                VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_STYLE_FONT_NAME          VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_STYLE_FONT_COLOR         VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_SEL_STYLE_COLOR          VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    LABEL_TOTAL_GERAL_FONT_COLOR  VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_STYLE_FONT_STYLE         VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_COLOR                   VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_FONT_COLOR              VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_DISABLED_COLOR          VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_FONT_NAME               VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+')';    //    EDITS_FONT_STYLE              VARCHAR(20)
      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdResolucao(ID) then
          ConsultaSQL := 'INSERT INTO ECF_RESOLUCAO '+
          ' (ID, '+
          'RESOLUCAO_TELA, '+
          'LARGURA, '+
          'ALTURA, '+
          'IMAGEM_TELA, '+
          'IMAGEM_MENU, '+
          'IMAGEM_SUBMENU, '+
          'HOTTRACK_COLOR, '+
          'ITEM_STYLE_FONT_NAME, '+
          'ITEM_STYLE_FONT_COLOR, '+
          'ITEM_SEL_STYLE_COLOR, '+
          'LABEL_TOTAL_GERAL_FONT_COLOR, '+
          'ITEM_STYLE_FONT_STYLE, '+
          'EDITS_COLOR, '+
          'EDITS_FONT_COLOR, '+
          'EDITS_DISABLED_COLOR, '+
          'EDITS_FONT_NAME, '+
          'EDITS_FONT_STYLE) '+
          ' values ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    RESOLUCAO_TELA                VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    LARGURA                       INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    ALTURA                        INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    IMAGEM_TELA                   VARCHAR(50),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    IMAGEM_MENU                   VARCHAR(50),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    IMAGEM_SUBMENU                VARCHAR(50),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    HOTTRACK_COLOR                VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_STYLE_FONT_NAME          VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_STYLE_FONT_COLOR         VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_SEL_STYLE_COLOR          VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    LABEL_TOTAL_GERAL_FONT_COLOR  VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_STYLE_FONT_STYLE         VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_COLOR                   VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_FONT_COLOR              VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_DISABLED_COLOR          VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_FONT_NAME               VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+')'    //    EDITS_FONT_STYLE              VARCHAR(20)
        else
          ConsultaSQL := ' update ECF_RESOLUCAO set '+
          'RESOLUCAO_TELA ='+               DevolveConteudoDelimitado('|',vTupla)+', '+   //    RESOLUCAO_TELA                VARCHAR(20),
          'LARGURA ='+                      DevolveConteudoDelimitado('|',vTupla)+', '+   //    LARGURA                       INTEGER,
          'ALTURA ='+                       DevolveConteudoDelimitado('|',vTupla)+', '+   //    ALTURA                        INTEGER,
          'IMAGEM_TELA ='+                  DevolveConteudoDelimitado('|',vTupla)+', '+   //    IMAGEM_TELA                   VARCHAR(50),
          'IMAGEM_MENU ='+                  DevolveConteudoDelimitado('|',vTupla)+', '+   //    IMAGEM_MENU                   VARCHAR(50),
          'IMAGEM_SUBMENU ='+               DevolveConteudoDelimitado('|',vTupla)+', '+   //    IMAGEM_SUBMENU                VARCHAR(50),
          'HOTTRACK_COLOR ='+               DevolveConteudoDelimitado('|',vTupla)+', '+   //    HOTTRACK_COLOR                VARCHAR(20),
          'ITEM_STYLE_FONT_NAME ='+         DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_STYLE_FONT_NAME          VARCHAR(20),
          'ITEM_STYLE_FONT_COLOR ='+        DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_STYLE_FONT_COLOR         VARCHAR(20),
          'ITEM_SEL_STYLE_COLOR ='+         DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_SEL_STYLE_COLOR          VARCHAR(20),
          'LABEL_TOTAL_GERAL_FONT_COLOR ='+ DevolveConteudoDelimitado('|',vTupla)+', '+   //    LABEL_TOTAL_GERAL_FONT_COLOR  VARCHAR(20),
          'ITEM_STYLE_FONT_STYLE ='+        DevolveConteudoDelimitado('|',vTupla)+', '+   //    ITEM_STYLE_FONT_STYLE         VARCHAR(20),
          'EDITS_COLOR ='+                  DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_COLOR                   VARCHAR(20),
          'EDITS_FONT_COLOR ='+             DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_FONT_COLOR              VARCHAR(20),
          'EDITS_DISABLED_COLOR ='+         DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_DISABLED_COLOR          VARCHAR(20),
          'EDITS_FONT_NAME ='+              DevolveConteudoDelimitado('|',vTupla)+', '+   //    EDITS_FONT_NAME               VARCHAR(20),
          'EDITS_FONT_STYLE ='+             DevolveConteudoDelimitado('|',vTupla)+    //    EDITS_FONT_STYLE              VARCHAR(20)
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
