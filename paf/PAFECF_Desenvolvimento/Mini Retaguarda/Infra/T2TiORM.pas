{*******************************************************************************
Title: T2Ti ERP
Description: Framework ORM da T2Ti

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
unit T2TiORM;

interface

uses Atributos, Rtti, SysUtils, SQLExpr, DBClient, DB, TypInfo, Generics.Collections, DBXCommon,
     Dialogs;

type
  TT2TiORM = class
  private
  public
    class function Inserir(pObjeto: TObject): Integer;
    class function Alterar(pObjeto: TObject): Boolean;
    class function Excluir(pObjeto: TObject): Boolean;
    class function Consultar(pObjeto: TObject; pFiltro: String; pPagina: Integer): TDBXReader; Overload;
    class function Consultar(pConsulta: String; pFiltro: String; pPagina: Integer): TDBXReader; Overload;
  end;

implementation

uses
  ConexaoBD, Constantes;

var
  Conexao: TSQLConnection;
  Query: TSQLQuery;

{ TT2TiORM }

class function TT2TiORM.Inserir(pObjeto: TObject): Integer;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, CamposSQL, ValoresSQL, Campo, Valor: String;
  UltimoID:Integer;
  // Params: TParams;
  Tabela: string; // Variavel adicionada para montar sql para obter max(ID) da tabela

begin
  DecimalSeparator:= '.';
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(pObjeto.ClassType);

    //localiza o nome da tabela
    for Atributo in Tipo.GetAttributes do
    begin
      if Atributo is TTable then
      begin
        Tabela      := (Atributo as TTable).Name;
        ConsultaSQL := 'INSERT INTO ' + (Atributo as TTable).Name;
      end;
    end;

    //preenche os nomes dos campos e valores
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if not (Atributo as TColumn).Transiente then
          begin
            Campo := (Atributo as TColumn).Name;
            Valor := Propriedade.GetValue(pObjeto).ToString;
            if valor = '' then
              Valor := 'NULL';
            if TDBExpress.getBanco = 'Firebird' then
            begin
              if Propriedade.PropertyType.TypeKind in [tkFloat]  then
                Valor := StringReplace(Valor,',','.',[rfReplaceAll]);
            end;

            if (Copy(Campo,1,2) = 'ID') and (Valor = '0') then
              Break
            else
            begin
              CamposSQL := CamposSQL + Campo + ',';

             if Valor <> 'NULL' then
             begin
               if TDBExpress.getBanco = 'Firebird' then
               begin
                if Propriedade.PropertyType.TypeKind in [tkFloat, tkInteger]  then
                  ValoresSQL := ValoresSQL + Valor + ','
                else if Pos('/',Valor) = 3 then // "Gambi"... Não encontrei o tipo para data em RTTI, se existir, alterar tipo dos campos data nos VO's
                  ValoresSQL := ValoresSQL + QuotedStr( StringReplace(Valor,'/','.',[rfReplaceAll]) ) + ','
                else
                  ValoresSQL := ValoresSQL + QuotedStr(Valor) + ',';
               end
               else
                 ValoresSQL := ValoresSQL + QuotedStr(Valor) + ',';
             end
             else
                ValoresSQL := ValoresSQL + Valor + ',';
            end;
          end;
        end;
      end;
    end;

    //retirando as vírgulas que sobraram no final
    Delete(CamposSQL, Length(CamposSQL), 1);
    Delete(ValoresSQL, Length(ValoresSQL), 1);

    ConsultaSQL := ConsultaSQL + '(' + CamposSQL + ') VALUES (' + ValoresSQL + ')';

    if TDBExpress.getBanco = 'Firebird' then
    begin
      // Funciona com a versão Firebird-2.5.1.26351_1_Win32
      ConsultaSQL := ConsultaSQL + ' RETURNING ID ';
    end;

    Query := TSQLQuery.Create(nil);
    Query.SQLConnection := TDBExpress.getConexao;
    Query.SQL.Text := ConsultaSQL;

    UltimoID := 0;
    if TDBExpress.getBanco = 'MySQl' then
    begin
      Query.ExecSQL();
      Query.CommandText := 'select LAST_INSERT_ID() as id';
      Query.Open();
      UltimoID := Query.FieldByName('id').AsInteger;
    end
    else
    if TDBExpress.getBanco = 'Firebird' then
    begin
      // Funciona com a versão Firebird-2.5.1.26351_1_Win32
      Query.Open;
      UltimoID :=  Query.FieldByName('ID').AsInteger;
      query.close;
    end;

    Result := UltimoID;
  finally
    //Params.Free;
    query.free;
    Contexto.Free;
    DecimalSeparator:= ',';
  end;
end;

class function TT2TiORM.Alterar(pObjeto: TObject): Boolean;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, CamposSQL, FiltroSQL, Campo, Valor: String;
begin
  DecimalSeparator:= '.';
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(pObjeto.ClassType);

    //localiza o nome da tabela
    for Atributo in Tipo.GetAttributes do
    begin
      if Atributo is TTable then
        ConsultaSQL := 'UPDATE ' + (Atributo as TTable).Name + ' SET ';
    end;

    //preenche os nomes dos campos e filtro
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if not (Atributo as TColumn).Transiente then
          begin
            Campo := (Atributo as TColumn).Name;
            Valor := Propriedade.GetValue(pObjeto).ToString;
            if Valor = '' then
              Valor := 'NULL';

            if TDBExpress.getBanco = 'Firebird' then
            begin
              if Propriedade.PropertyType.TypeKind in [tkFloat]  then
                Valor := StringReplace(Valor,',','.',[rfReplaceAll]);
            end;

            if (Copy(Campo,1,2) = 'ID') and (Valor = '0') then
              Break
            else
            begin

              if Propriedade.GetValue(pObjeto).ToString <> '' then
              begin
                if TDBExpress.getBanco = 'Firebird' then
                begin
                  if Propriedade.PropertyType.TypeKind in [tkFloat, tkInteger] then
                    CamposSQL := CamposSQL + (Atributo as TColumn).Name + ' = ' + Propriedade.GetValue(pObjeto).ToString + ','
                  else
                  if pos('/',Valor) = 3 then // "Gambi"... Não encontrei o tipo para data em RTTI, se existir, alterar tipo dos campos data nos VO's
                    CamposSQL := CamposSQL + (Atributo as TColumn).Name + ' = ' + QuotedStr(StringReplace(Propriedade.GetValue(pObjeto).ToString,'/','.',[rfReplaceAll])) + ','
                  else
                    CamposSQL := CamposSQL + (Atributo as TColumn).Name + ' = ' + QuotedStr(Propriedade.GetValue(pObjeto).ToString) + ','

                end
                else
                  CamposSQL := CamposSQL + (Atributo as TColumn).Name + ' = ' + QuotedStr(Propriedade.GetValue(pObjeto).ToString) + ','
              end;
            end;
          end;
        end
        else if Atributo is TId then
          FiltroSQL := ' WHERE ' + (Atributo as TId).NameField + ' = ' + QuotedStr(Propriedade.GetValue(pObjeto).ToString);
      end;
    end;

    //retirando as vírgulas que sobraram no final
    Delete(CamposSQL, Length(CamposSQL), 1);

    ConsultaSQL := ConsultaSQL + CamposSQL + FiltroSQL;

    Conexao := TDBExpress.getConexao;
    Query := TSQLQuery.Create(nil);
    Query.SQLConnection := Conexao;
    Query.sql.Text := ConsultaSQL;
    Query.ExecSQL();

    Result := True;
  finally
    query.free;
    Contexto.Free;
  end;
end;

class function TT2TiORM.Excluir(pObjeto: TObject): Boolean;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, FiltroSQL: String;
begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(pObjeto.ClassType);

    //localiza o nome da tabela
    for Atributo in Tipo.GetAttributes do
    begin
      if Atributo is TTable then
        ConsultaSQL := 'DELETE FROM ' + (Atributo as TTable).Name;
    end;

    //preenche o filtro
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TId then
        begin
          FiltroSQL := ' WHERE ' + (Atributo as TId).NameField + ' = ' + QuotedStr(Propriedade.GetValue(pObjeto).ToString);
        end;
      end;
    end;

    ConsultaSQL := ConsultaSQL + FiltroSQL;

    Conexao := TDBExpress.getConexao;
    Query := TSQLQuery.Create(nil);
    Query.SQLConnection := Conexao;
    Query.sql.Text := ConsultaSQL;
    Query.ExecSQL();

    Result := True;
  finally
    query.free;
    Contexto.Free;
    DecimalSeparator:= ',';
  end;
end;

class function TT2TiORM.Consultar(pObjeto: TObject; pFiltro: String; pPagina: Integer): TDBXReader;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, FiltroSQL: String;
  DBXConnection: TDBXConnection;
  DBXCommand: TDBXCommand;
  DBXReader: TDBXReader;
begin
  try
    try
      Contexto := TRttiContext.Create;
      Tipo := Contexto.GetType(pObjeto.ClassType);

      //localiza o nome da tabela
      for Atributo in Tipo.GetAttributes do
      begin
        if Atributo is TTable then
          ConsultaSQL := 'SELECT * FROM ' + (Atributo as TTable).Name;
      end;

      if TDBExpress.getBanco = 'Firebird' then
         pFiltro := StringReplace(pFiltro,'"','''',[rfReplaceAll]);

      if pFiltro <> '' then
        FiltroSQL := ' WHERE ' + pFiltro;

      ConsultaSQL := ConsultaSQL + FiltroSQL;

      if TDBExpress.getBanco = 'MySQL' then
      begin
        ConsultaSQL := ConsultaSQL + ' limit ' + IntToStr(pPagina) + ',' + IntToStr(TConstantes.QUANTIDADE_POR_PAGINA);
      end;

      DBXConnection := TDBExpress.getConexao.DBXConnection;
      DBXCommand := DBXConnection.CreateCommand;
      DBXCommand.Text := ConsultaSQL;
      DBXCommand.Prepare;
      DBXReader := DBXCommand.ExecuteQuery;

      result := DBXReader;
    except
      result := nil;
    end;
  finally
    Contexto.Free;
  end;
end;

class function TT2TiORM.Consultar(pConsulta: String; pFiltro: String; pPagina: Integer): TDBXReader;
var
  FiltroSQL: String;
  DBXConnection: TDBXConnection;
  DBXCommand: TDBXCommand;
  DBXReader: TDBXReader;
begin
  try
    try
      if TDBExpress.getBanco = 'MySQL' then
      begin
        FiltroSQL := ' and ' + pFiltro + ' limit ' + IntToStr(pPagina) + ',' + IntToStr(TConstantes.QUANTIDADE_POR_PAGINA);
      end else
      if TDBExpress.getBanco = 'Firebird' then
      begin
        pConsulta := StringReplace(pConsulta,'select','select first '+IntToStr(TConstantes.QUANTIDADE_POR_PAGINA)+' skip '+ IntToStr(pPagina),[rfReplaceAll]);
        pConsulta := StringReplace(pConsulta,'"','''',[rfReplaceAll]);
        FiltroSQL := ' and '+pFiltro;
        FiltroSQL := StringReplace(FiltroSQL,'"','''',[rfReplaceAll]);
      end;

      DBXConnection := TDBExpress.getConexao.DBXConnection;
      DBXCommand := DBXConnection.CreateCommand;
      DBXCommand.Text := pConsulta + FiltroSQL;
      DBXCommand.Prepare;
      DBXReader := DBXCommand.ExecuteQuery;

      result := DBXReader;
    except
      result := nil;
    end;
  finally
  end;
end;

end.
