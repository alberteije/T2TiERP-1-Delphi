{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela AGENCIA

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
unit AgenciaController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, AgenciaVO, DBXCommon;

type
  TAgenciaController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pAgencia: TAgenciaVO);
    class Procedure Altera(pAgencia: TAgenciaVO; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM;

var
  Agencia: TAgenciaVO;

class procedure TAgenciaController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      pFiltro := 'A.' + pFiltro;

      ConsultaSQL :=
          'select '+
          '  A.ID, A.ID_BANCO, A.NUMERO, A.CODIGO, A.NOME, A.ENDERECO, A.CEP, A.BAIRRO, '+
          '  A.CIDADE, A.UF, A.GERENTE, A.TELEFONE1, A.TELEFONE2, A.OBSERVACAO, B.NOME AS NOME_BANCO '+
          'from '+
          '  AGENCIA A, BANCO B '+
          'where '+
          '  A.ID_BANCO = B.ID';

      resultSet := TT2TiORM.Consultar(ConsultaSQL, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NOME_BANCO').AsString := ResultSet.Value['NOME_BANCO'].AsString;
          FDataModule.CDSLookup.FieldByName('NUMERO').AsInteger := ResultSet.Value['NUMERO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('CODIGO').AsString := ResultSet.Value['CODIGO'].AsString;
          FDataModule.CDSLookup.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSLookup.FieldByName('ENDERECO').AsString := ResultSet.Value['ENDERECO'].AsString;
          FDataModule.CDSLookup.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSLookup.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSLookup.FieldByName('CIDADE').AsString := ResultSet.Value['CIDADE'].AsString;
          FDataModule.CDSLookup.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSLookup.FieldByName('GERENTE').AsString := ResultSet.Value['GERENTE'].AsString;
          FDataModule.CDSLookup.FieldByName('TELEFONE1').AsString := ResultSet.Value['TELEFONE1'].AsString;
          FDataModule.CDSLookup.FieldByName('TELEFONE2').AsString := ResultSet.Value['TELEFONE2'].AsString;
          FDataModule.CDSLookup.FieldByName('OBSERVACAO').AsString := ResultSet.Value['OBSERVACAO'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSAgencia.DisableControls;
        FDataModule.CDSAgencia.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSAgencia.Append;
          FDataModule.CDSAgencia.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSAgencia.FieldByName('ID_BANCO').AsInteger := ResultSet.Value['ID_BANCO'].AsInt32;
          FDataModule.CDSAgencia.FieldByName('NOME_BANCO').AsString := ResultSet.Value['NOME_BANCO'].AsString;
          FDataModule.CDSAgencia.FieldByName('NUMERO').AsInteger := ResultSet.Value['NUMERO'].AsInt32;
          FDataModule.CDSAgencia.FieldByName('CODIGO').AsString := ResultSet.Value['CODIGO'].AsString;
          FDataModule.CDSAgencia.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSAgencia.FieldByName('ENDERECO').AsString := ResultSet.Value['ENDERECO'].AsString;
          FDataModule.CDSAgencia.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSAgencia.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSAgencia.FieldByName('CIDADE').AsString := ResultSet.Value['CIDADE'].AsString;
          FDataModule.CDSAgencia.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSAgencia.FieldByName('GERENTE').AsString := ResultSet.Value['GERENTE'].AsString;
          FDataModule.CDSAgencia.FieldByName('TELEFONE1').AsString := ResultSet.Value['TELEFONE1'].AsString;
          FDataModule.CDSAgencia.FieldByName('TELEFONE2').AsString := ResultSet.Value['TELEFONE2'].AsString;
          FDataModule.CDSAgencia.FieldByName('OBSERVACAO').AsString := ResultSet.Value['OBSERVACAO'].AsString;
          FDataModule.CDSAgencia.Post;
        end;
        FDataModule.CDSAgencia.Open;
        FDataModule.CDSAgencia.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TAgenciaController.Insere(pAgencia: TAgenciaVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pAgencia);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TAgenciaController.Altera(pAgencia: TAgenciaVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pAgencia);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TAgenciaController.Exclui(pId: Integer);
begin
  try
    try
      Agencia := TAgenciaVO.Create;
      Agencia.Id := pId;
      TT2TiORM.Excluir(Agencia);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
