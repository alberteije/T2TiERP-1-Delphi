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
    class Function PegaImpressora(Id:Integer): TImpressoraVO;
    class Function TabelaImpressora: TObjectList<TImpressoraVO>;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class Function TImpressoraController.PegaImpressora(Id:Integer): TImpressoraVO;
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

      Impressora.Serie := Query.FieldByName('SERIE').AsString;
      Impressora.Tipo := Query.FieldByName('TIPO').AsString;
      Impressora.Marca := Query.FieldByName('MARCA').AsString;
      Impressora.Modelo := Query.FieldByName('MODELO').AsString;
      Impressora.MFD := Query.FieldByName('MFD').AsString;
      Impressora.ModeloDocumentoFiscal := Query.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString;

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
        Impressora.Serie := Query.FieldByName('SERIE').AsString;
        Impressora.Tipo := Query.FieldByName('TIPO').AsString;
        Impressora.Marca := Query.FieldByName('MARCA').AsString;
        Impressora.Modelo := Query.FieldByName('MODELO').AsString;
        Impressora.MFD := Query.FieldByName('MFD').AsString;
        Impressora.Identificacao := Query.FieldByName('IDENTIFICACAO').AsString;
        Impressora.ModeloDocumentoFiscal := Query.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString;
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

end.
