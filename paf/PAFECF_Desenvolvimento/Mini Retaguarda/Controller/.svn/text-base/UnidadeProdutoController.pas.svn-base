{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela UNIDADE_PRODUTO

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
unit UnidadeProdutoController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, UnidadeProdutoVO, DBXCommon;

type
  TUnidadeProdutoController = class
  private
      class var FDataSet: TClientDataSet;
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pUnidadeProduto: TUnidadeProdutoVO);
    class Procedure Altera(pUnidadeProduto: TUnidadeProdutoVO; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
    class function GetDataSet: TClientDataSet;
    class procedure SetDataSet(pDataSet: TClientDataSet);

  end;

implementation

uses UDataModule, T2TiORM, Biblioteca;

var
  UnidadeProduto: TUnidadeProdutoVO;

class procedure TUnidadeProdutoController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
  I: Integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TUnidadeProdutoVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSLookup.FieldByName('DESCRICAO').AsString := ResultSet.Value['DESCRICAO'].AsString;
          FDataModule.CDSLookup.FieldByName('PODE_FRACIONAR').AsString := ResultSet.Value['PODE_FRACIONAR'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSUnidadeProduto.DisableControls;
        FDataModule.CDSUnidadeProduto.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSUnidadeProduto.Append;
          for I := 0 to FDataModule.CDSUnidadeProduto.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSUnidadeProduto.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
             if ResultSet.Value[FDataModule.CDSUnidadeProduto.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSUnidadeProduto.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSUnidadeProduto.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSUnidadeProduto.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSUnidadeProduto.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSUnidadeProduto.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSUnidadeProduto.FieldDefList[i].Name].AsDouble;
              end
              else FDataModule.CDSUnidadeProduto.Fields[i].AsFloat := 0;
            end
            else
            if ResultSet.Value[FDataModule.CDSUnidadeProduto.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSUnidadeProduto.Fields[i].AsString := ResultSet.Value[FDataModule.CDSUnidadeProduto.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSUnidadeProduto.Post;

        end;
        //FDataModule.CDSUnidadeProduto.Open;
        FDataModule.CDSUnidadeProduto.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TUnidadeProdutoController.Insere(pUnidadeProduto: TUnidadeProdutoVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pUnidadeProduto);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class procedure TUnidadeProdutoController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class Procedure TUnidadeProdutoController.Altera(pUnidadeProduto: TUnidadeProdutoVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pUnidadeProduto);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TUnidadeProdutoController.Exclui(pId: Integer);
begin
  try
    try
      UnidadeProduto := TUnidadeProdutoVO.Create;
      UnidadeProduto.Id := pId;
      TT2TiORM.Excluir(UnidadeProduto);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class function TUnidadeProdutoController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

end.
