{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela CONTA_CAIXA

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
unit ContaCaixaController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, ContaCaixaVO, DBXCommon;

type
  TContaCaixaController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pContaCaixa: TContaCaixaVO);
    class Procedure Altera(pContaCaixa: TContaCaixaVO; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM;

var
  ContaCaixa: TContaCaixaVO;

class procedure TContaCaixaController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      if pFiltro <> '1=1' then
        pFiltro := 'C.' + pFiltro;

      ConsultaSQL :=
          'select '+
          '  C.ID, C.ID_AGENCIA, C.CODIGO, C.NOME, C.DESCRICAO, C.TIPO, A.NOME AS NOME_AGENCIA '+
          'from '+
          '  CONTA_CAIXA C, AGENCIA A '+
          'where '+
          '  C.ID_AGENCIA = A.ID';

      resultSet := TT2TiORM.Consultar(ConsultaSQL, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NOME_AGENCIA').AsString := ResultSet.Value['NOME_AGENCIA'].AsString;
          FDataModule.CDSLookup.FieldByName('CODIGO').AsString := ResultSet.Value['CODIGO'].AsString;
          FDataModule.CDSLookup.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSLookup.FieldByName('TIPO').AsString := ResultSet.Value['TIPO'].AsString;
          FDataModule.CDSLookup.FieldByName('DESCRICAO').AsString := ResultSet.Value['DESCRICAO'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSContaCaixa.DisableControls;
        FDataModule.CDSContaCaixa.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSContaCaixa.Append;
          FDataModule.CDSContaCaixa.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSContaCaixa.FieldByName('ID_AGENCIA').AsInteger := ResultSet.Value['ID_AGENCIA'].AsInt32;
          FDataModule.CDSContaCaixa.FieldByName('NOME_AGENCIA').AsString := ResultSet.Value['NOME_AGENCIA'].AsString;
          FDataModule.CDSContaCaixa.FieldByName('CODIGO').AsString := ResultSet.Value['CODIGO'].AsString;
          FDataModule.CDSContaCaixa.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSContaCaixa.FieldByName('TIPO').AsString := ResultSet.Value['TIPO'].AsString;
          FDataModule.CDSContaCaixa.FieldByName('DESCRICAO').AsString := ResultSet.Value['DESCRICAO'].AsString;
          FDataModule.CDSContaCaixa.Post;
        end;
        FDataModule.CDSContaCaixa.Open;
        FDataModule.CDSContaCaixa.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TContaCaixaController.Insere(pContaCaixa: TContaCaixaVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pContaCaixa);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TContaCaixaController.Altera(pContaCaixa: TContaCaixaVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pContaCaixa);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TContaCaixaController.Exclui(pId: Integer);
begin
  try
    try
      ContaCaixa := TContaCaixaVO.Create;
      ContaCaixa.Id := pId;
      TT2TiORM.Excluir(ContaCaixa);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
