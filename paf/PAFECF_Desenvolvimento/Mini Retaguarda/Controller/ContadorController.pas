{*******************************************************************************
Title: T2Ti ERP
Description: Controller do lado Cliente relacionado à tabela [Contador]

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

@author  ()
@version 1.0
*******************************************************************************}
unit ContadorController;

interface

uses
 Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, ContadorVO, DBXCommon;


type
  TContadorController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pContador: TContadorVO);
    class Procedure Altera(pContador: TContadorVO; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM, Biblioteca;


var
  Contador: TContadorVO;

class procedure TContadorController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
  I: INTEGER;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TContadorVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('CPF').AsString := ResultSet.Value['CPF'].AsString;
          FDataModule.CDSLookup.FieldByName('CNPJ').AsString := ResultSet.Value['CNPJ'].AsString;
          FDataModule.CDSLookup.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSLookup.FieldByName('INSCRICAO_CRC').AsString := ResultSet.Value['INSCRICAO_CRC'].AsString;
          FDataModule.CDSLookup.FieldByName('FONE').AsString := ResultSet.Value['FONE'].AsString;
          FDataModule.CDSLookup.FieldByName('FAX').AsString := ResultSet.Value['FAX'].AsString;
          FDataModule.CDSLookup.FieldByName('LOGRADOURO').AsString := ResultSet.Value['LOGRADOURO'].AsString;
          FDataModule.CDSLookup.FieldByName('COMPLEMENTO').AsString := ResultSet.Value['COMPLEMENTO'].AsString;
          FDataModule.CDSLookup.FieldByName('NUMERO').AsString := ResultSet.Value['NUMERO'].AsString;
          FDataModule.CDSLookup.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSLookup.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSLookup.FieldByName('CODIGO_MUNICIPIO').AsString := ResultSet.Value['CODIGO_MUNICIPIO'].AsString;
          FDataModule.CDSLookup.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSLookup.FieldByName('EMAIL').AsString := ResultSet.Value['EMAIL'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSContador.DisableControls;
        FDataModule.CDSContador.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSContador.Append;
          for I := 0 to FDataModule.CDSContador.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSContador.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
             if ResultSet.Value[FDataModule.CDSContador.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSContador.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSContador.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSContador.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSContador.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSContador.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSContador.FieldDefList[i].Name].AsDouble;
              end
              else FDataModule.CDSContador.Fields[i].AsFloat := 0;
            end
            else
            if ResultSet.Value[FDataModule.CDSContador.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSContador.Fields[i].AsString := ResultSet.Value[FDataModule.CDSContador.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSContador.Post;
          {
          FDataModule.CDSContador.Append;
          FDataModule.CDSContador.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSContador.FieldByName('CPF').AsString := ResultSet.Value['CPF'].AsString;
          FDataModule.CDSContador.FieldByName('CNPJ').AsString := ResultSet.Value['CNPJ'].AsString;
          FDataModule.CDSContador.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSContador.FieldByName('INSCRICAO_CRC').AsString := ResultSet.Value['INSCRICAO_CRC'].AsString;
          FDataModule.CDSContador.FieldByName('FONE').AsString := ResultSet.Value['FONE'].AsString;
          FDataModule.CDSContador.FieldByName('FAX').AsString := ResultSet.Value['FAX'].AsString;
          FDataModule.CDSContador.FieldByName('LOGRADOURO').AsString := ResultSet.Value['LOGRADOURO'].AsString;
          FDataModule.CDSContador.FieldByName('COMPLEMENTO').AsString := ResultSet.Value['COMPLEMENTO'].AsString;
          FDataModule.CDSContador.FieldByName('NUMERO').AsString := ResultSet.Value['NUMERO'].AsString;
          FDataModule.CDSContador.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSContador.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSContador.FieldByName('CODIGO_MUNICIPIO').AsString := ResultSet.Value['CODIGO_MUNICIPIO'].AsString;
          FDataModule.CDSContador.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSContador.FieldByName('EMAIL').AsString := ResultSet.Value['EMAIL'].AsString;
          FDataModule.CDSContador.Post;
          }
        end;
        //FDataModule.CDSContador.Open;
        FDataModule.CDSContador.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TContadorController.Insere(pContador: TContadorVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pContador);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TContadorController.Altera(pContador: TContadorVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pContador);
      //Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;


class Procedure TContadorController.Exclui(pId: Integer);
begin
  try
    try
      Contador := TContadorVO.Create;
      Contador.Id := pId;
      TT2TiORM.Excluir(Contador);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
