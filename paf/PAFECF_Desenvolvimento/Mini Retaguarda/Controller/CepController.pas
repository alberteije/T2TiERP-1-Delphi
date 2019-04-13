{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela CEP

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
unit CepController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, CepVO, DBXCommon;

type
  TCepController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
  end;

implementation

uses UDataModule, T2TiORM;

var
  Cep: TCepVO;

class procedure TCepController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet : TDBXReader;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TCepVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('IBGE').AsInteger := ResultSet.Value['IBGE'].AsInt32;
          FDataModule.CDSLookup.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSLookup.FieldByName('LOGRADOURO').AsString := ResultSet.Value['LOGRADOURO'].AsString;
          FDataModule.CDSLookup.FieldByName('COMPLEMENTO').AsString := ResultSet.Value['COMPLEMENTO'].AsString;
          FDataModule.CDSLookup.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSLookup.FieldByName('CIDADE').AsString := ResultSet.Value['CIDADE'].AsString;
          FDataModule.CDSLookup.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSCep.DisableControls;
        FDataModule.CDSCep.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSCep.Append;
          FDataModule.CDSCep.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSCep.FieldByName('IBGE').AsInteger := ResultSet.Value['IBGE'].AsInt32;
          FDataModule.CDSCep.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSCep.FieldByName('LOGRADOURO').AsString := ResultSet.Value['LOGRADOURO'].AsString;
          FDataModule.CDSCep.FieldByName('COMPLEMENTO').AsString := ResultSet.Value['COMPLEMENTO'].AsString;
          FDataModule.CDSCep.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSCep.FieldByName('CIDADE').AsString := ResultSet.Value['CIDADE'].AsString;
          FDataModule.CDSCep.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSCep.Post;
        end;
        FDataModule.CDSCep.Open;
        FDataModule.CDSCep.EnableControls;
      end;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

end.
