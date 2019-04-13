{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela CFOP

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
unit CfopController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, CfopVO, DBXCommon,
  SQLExpr;

type
  TCfopController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class function ConsultaPeloCfop(pCfop: Integer): Boolean;
  end;

implementation

uses UDataModule, T2TiORM, Biblioteca;

var
  Cfop: TCfopVO;
  ConsultaSQL: String;
  Query: TSQLQuery;

class procedure TCfopController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet : TDBXReader;
  i: integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TCfopVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('CFOP').AsString := ResultSet.Value['CFOP'].AsString;
          FDataModule.CDSLookup.FieldByName('DESCRICAO').AsString := ResultSet.Value['DESCRICAO'].AsString;
          FDataModule.CDSLookup.FieldByName('APLICACAO').AsString := ResultSet.Value['APLICACAO'].AsString;
          FDataModule.CDSLookup.FieldByName('MOVIMENTA_ESTOQUE').AsString := ResultSet.Value['MOVIMENTA_ESTOQUE'].AsString;
          FDataModule.CDSLookup.FieldByName('MOVIMENTA_FINANCEIRO').AsString := ResultSet.Value['MOVIMENTA_FINANCEIRO'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSCfop.DisableControls;
        FDataModule.CDSCfop.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSCfop.Append;
          for I := 0 to FDataModule.CDSCfop.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSCfop.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
             if ResultSet.Value[FDataModule.CDSCfop.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSCfop.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSCfop.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSCfop.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSCfop.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSCfop.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSCfop.FieldDefList[i].Name].AsDouble;
              end
              else FDataModule.CDSCfop.Fields[i].AsFloat := 0;
            end
            else
            if ResultSet.Value[FDataModule.CDSCfop.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSCfop.Fields[i].AsString := ResultSet.Value[FDataModule.CDSCfop.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSCfop.Post;
          {
          FDataModule.CDSCfop.Append;
          FDataModule.CDSCfop.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSCfop.FieldByName('CFOP').AsString := ResultSet.Value['CFOP'].AsString;
          FDataModule.CDSCfop.FieldByName('DESCRICAO').AsString := ResultSet.Value['DESCRICAO'].AsString;
          FDataModule.CDSCfop.FieldByName('APLICACAO').AsString := ResultSet.Value['APLICACAO'].AsString;
          FDataModule.CDSCfop.FieldByName('MOVIMENTA_ESTOQUE').AsString := ResultSet.Value['MOVIMENTA_ESTOQUE'].AsString;
          FDataModule.CDSCfop.FieldByName('MOVIMENTA_FINANCEIRO').AsString := ResultSet.Value['MOVIMENTA_FINANCEIRO'].AsString;
          FDataModule.CDSCfop.Post;
          }
        end;
        FDataModule.CDSCfop.Open;
        FDataModule.CDSCfop.EnableControls;
      end;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class function TCFopController.ConsultaPeloCfop(pCfop: Integer): Boolean;
begin
  ConsultaSQL := 'select Cfop from Cfop where Cfop='+IntToStr(pCfop);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      if not Query.Eof then
        result := True;
    except
      result := False;
    end;
  finally
    Query.Free;
  end;
end;

end.
