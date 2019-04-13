{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da impressora.

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
unit ImpressoraController;

interface

uses
  Classes, SQLExpr, SysUtils, ImpressoraVO, Generics.Collections;

type
  TImpressoraController = class
  protected
  public
    class function PegaImpressora(Id:Integer): TImpressoraVO;
    class function TabelaImpressora: TObjectList<TImpressoraVO>;
    class function ConsultaIdImpressora(Id: Integer): Boolean;
    class function GravaCargaImpressora(vTupla: String): Boolean;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TImpressoraController.PegaImpressora(Id:Integer): TImpressoraVO;
var
  Impressora: TImpressoraVO;
begin
  ConsultaSQL := 'select * from ECF_IMPRESSORA where ID=' + IntToStr(Id);

  Impressora := TImpressoraVO.Create;

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Impressora.Numero := Query.FieldByName('NUMERO').AsInteger;
      Impressora.Codigo := Query.FieldByName('CODIGO').AsString;
      Impressora.Serie := Query.FieldByName('SERIE').AsString;
      Impressora.Identificacao := Query.FieldByName('IDENTIFICACAO').AsString;
      Impressora.Mc := Query.FieldByName('MC').AsString;
      Impressora.Md := Query.FieldByName('MD').AsString;
      Impressora.Vr := Query.FieldByName('VR').AsString;
      Impressora.Tipo := Query.FieldByName('TIPO').AsString;
      Impressora.Marca := Query.FieldByName('MARCA').AsString;
      Impressora.Modelo := Query.FieldByName('MODELO').AsString;
      Impressora.ModeloAcbr := Query.FieldByName('MODELO_ACBR').AsString;
      Impressora.ModeloDocumentoFiscal := Query.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString;
      Impressora.Versao := Query.FieldByName('VERSAO').AsString;
      Impressora.Le := Query.FieldByName('LE').AsString;
      Impressora.Lef := Query.FieldByName('LEF').AsString;
      Impressora.MFD := Query.FieldByName('MFD').AsString;
      Impressora.LacreNaMfd := Query.FieldByName('LACRE_NA_MFD').AsString;
      Impressora.Docto := Query.FieldByName('DOCTO').AsString;
      Impressora.NumeroEcf := Query.FieldByName('ECF_IMPRESSORA').AsString;
      Impressora.DataInstalacaoSb := Query.FieldByName('DATA_INSTALACAO_SB').AsString;
      Impressora.HoraInstalacaoSb := Query.FieldByName('HORA_INSTALACAO_SB').AsString;

      result := Impressora;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TImpressoraController.TabelaImpressora: TObjectList<TImpressoraVO>;
var
  ListaImpressora: TObjectList<TImpressoraVO>;
  Impressora: TImpressoraVO;
begin
  try
    try
      ConsultaSQL := 'select * from ECF_IMPRESSORA';

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaImpressora := TObjectList<TImpressoraVO>.Create;

      Query.First;
      while not Query.Eof do
      begin
        Impressora := TImpressoraVO.Create;
        Impressora.Id := Query.FieldByName('ID').AsInteger;
        Impressora.Numero := Query.FieldByName('NUMERO').AsInteger;
        Impressora.Codigo := Query.FieldByName('CODIGO').AsString;
        Impressora.Serie := Query.FieldByName('SERIE').AsString;
        Impressora.Identificacao := Query.FieldByName('IDENTIFICACAO').AsString;
        Impressora.Mc := Query.FieldByName('MC').AsString;
        Impressora.Md := Query.FieldByName('MD').AsString;
        Impressora.Vr := Query.FieldByName('VR').AsString;
        Impressora.Tipo := Query.FieldByName('TIPO').AsString;
        Impressora.Marca := Query.FieldByName('MARCA').AsString;
        Impressora.Modelo := Query.FieldByName('MODELO').AsString;
        Impressora.ModeloAcbr := Query.FieldByName('MODELO_ACBR').AsString;
        Impressora.ModeloDocumentoFiscal := Query.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString;
        Impressora.Versao := Query.FieldByName('VERSAO').AsString;
        Impressora.Le := Query.FieldByName('LE').AsString;
        Impressora.Lef := Query.FieldByName('LEF').AsString;
        Impressora.MFD := Query.FieldByName('MFD').AsString;
        Impressora.LacreNaMfd := Query.FieldByName('LACRE_NA_MFD').AsString;
        Impressora.Docto := Query.FieldByName('DOCTO').AsString;
        Impressora.NumeroEcf := Query.FieldByName('ECF_IMPRESSORA').AsString;
        Impressora.DataInstalacaoSb := Query.FieldByName('DATA_INSTALACAO_SB').AsString;
        Impressora.HoraInstalacaoSb := Query.FieldByName('HORA_INSTALACAO_SB').AsString;
        ListaImpressora.Add(Impressora);
        Query.next;
      end;
      result := ListaImpressora;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TImpressoraController.ConsultaIdImpressora(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from ECF_IMPRESSORA where (ID = :pID) ';
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

class function TImpressoraController.GravaCargaImpressora(vTupla: String): Boolean;
var
  ID: integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL:= ' UPDATE OR INSERT INTO ECF_IMPRESSORA '+
        ' (ID, '+
        'NUMERO, '+
        'CODIGO, '+
        'SERIE, '+
        'IDENTIFICACAO, '+
        'MC, '+
        'MD, '+
        'VR, '+
        'TIPO, '+
        'MARCA, '+
        'MODELO, '+
        'MODELO_ACBR, '+
        'MODELO_DOCUMENTO_FISCAL, '+
        'VERSAO, '+
        'LE, '+
        'LEF, '+
        'MFD, '+
        'LACRE_NA_MFD, '+
        'DOCTO, '+
        'DATA_INSTALACAO_SB, '+
        'HORA_INSTALACAO_SB, '+
        'ECF_IMPRESSORA)'+
        'values ('+
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID                       INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    NUMERO                   INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    CODIGO                   VARCHAR(10),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    SERIE                    VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    IDENTIFICACAO            VARCHAR(250),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    MC                       CHAR(2),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    MD                       CHAR(2),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    VR                       CHAR(2),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TIPO                     VARCHAR(7),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    MARCA                    VARCHAR(30),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    MODELO                   VARCHAR(30),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    MODELO_ACBR              VARCHAR(30),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    MODELO_DOCUMENTO_FISCAL  CHAR(2),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    VERSAO                   VARCHAR(30),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    LE                       CHAR(1),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    LEF                      CHAR(1),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    MFD                      CHAR(1),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    LACRE_NA_MFD             CHAR(1),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    DOCTO                    VARCHAR(60),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    DATA_INSTALACAO_SB       date
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    HORA_INSTALACAO_SB       varchar(8)
        DevolveConteudoDelimitado('|',vTupla)+')';   //    ECF_IMPRESSORA           VARCHAR(3)

























      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdImpressora(ID) then
          ConsultaSQL := 'INSERT INTO ECF_IMPRESSORA '+
          ' (ID, '+
          'NUMERO, '+
          'CODIGO, '+
          'SERIE, '+
          'IDENTIFICACAO, '+
          'MC, '+
          'MD, '+
          'VR, '+
          'TIPO, '+
          'MARCA, '+
          'MODELO, '+
          'MODELO_ACBR, '+
          'MODELO_DOCUMENTO_FISCAL, '+
          'VERSAO, '+
          'LE, '+
          'LEF, '+
          'MFD, '+
          'LACRE_NA_MFD, '+
          'DOCTO, '+
          'DATA_INSTALACAO_SB, '+
          'HORA_INSTALACAO_SB)'+
          'values ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    NUMERO                   INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    CODIGO                   VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    SERIE                    VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    IDENTIFICACAO            VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    MC                       CHAR(2),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    MD                       CHAR(2),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    VR                       CHAR(2),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TIPO                     VARCHAR(7),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    MARCA                    VARCHAR(30),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    MODELO                   VARCHAR(30),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    MODELO_ACBR              VARCHAR(30),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    MODELO_DOCUMENTO_FISCAL  CHAR(2),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    VERSAO                   VARCHAR(30),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    LE                       CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    LEF                      CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    MFD                      CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    LACRE_NA_MFD             CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    DOCTO                    VARCHAR(60),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    DATA_INSTALACAO_SB       date
          DevolveConteudoDelimitado('|',vTupla)+')'   //    HORA_INSTALACAO_SB       varchar(8)
        else
          ConsultaSQL := ' update ECF_IMPRESSORA set '+
          'NUMERO ='+                   DevolveConteudoDelimitado('|',vTupla)+', '+  //    NUMERO                   INTEGER,
          'CODIGO ='+                   DevolveConteudoDelimitado('|',vTupla)+', '+  //    CODIGO                   VARCHAR(10),
          'SERIE ='+                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    SERIE                    VARCHAR(20),
          'IDENTIFICACAO ='+            DevolveConteudoDelimitado('|',vTupla)+', '+  //    IDENTIFICACAO            VARCHAR(250),
          'MC ='+                       DevolveConteudoDelimitado('|',vTupla)+', '+  //    MC                       CHAR(2),
          'MD ='+                       DevolveConteudoDelimitado('|',vTupla)+', '+  //    MD                       CHAR(2),
          'VR ='+                       DevolveConteudoDelimitado('|',vTupla)+', '+  //    VR                       CHAR(2),
          'TIPO ='+                     DevolveConteudoDelimitado('|',vTupla)+', '+  //    TIPO                     VARCHAR(7),
          'MARCA ='+                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    MARCA                    VARCHAR(30),
          'MODELO ='+                   DevolveConteudoDelimitado('|',vTupla)+', '+  //    MODELO                   VARCHAR(30),
          'MODELO_ACBR ='+              DevolveConteudoDelimitado('|',vTupla)+', '+  //    MODELO_ACBR              VARCHAR(30),
          'MODELO_DOCUMENTO_FISCAL ='+  DevolveConteudoDelimitado('|',vTupla)+', '+  //    MODELO_DOCUMENTO_FISCAL  CHAR(2),
          'VERSAO ='+                   DevolveConteudoDelimitado('|',vTupla)+', '+  //    VERSAO                   VARCHAR(30),
          'LE ='+                       DevolveConteudoDelimitado('|',vTupla)+', '+  //    LE                       CHAR(1),
          'LEF ='+                      DevolveConteudoDelimitado('|',vTupla)+', '+  //    LEF                      CHAR(1),
          'MFD ='+                      DevolveConteudoDelimitado('|',vTupla)+', '+  //    MFD                      CHAR(1),
          'LACRE_NA_MFD ='+             DevolveConteudoDelimitado('|',vTupla)+', '+  //    LACRE_NA_MFD             CHAR(1),
          'DOCTO ='+                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    DOCTO                    VARCHAR(60)
          'DATA_INSTALACAO_SB ='+       DevolveConteudoDelimitado('|',vTupla)+', '+  //    DATA_INSTALACAO_SB       date
          'HORA_INSTALACAO_SB ='+       DevolveConteudoDelimitado('|',vTupla)+       //    HORA_INSTALACAO_SB       varchar(8)
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
