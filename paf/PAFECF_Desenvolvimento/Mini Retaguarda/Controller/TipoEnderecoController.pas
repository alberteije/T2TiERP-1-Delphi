{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela TIPO_ENDERECO

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
unit TipoEnderecoController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, TipoEnderecoVO, DBXCommon;

type
  TTipoEnderecoController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pTipoEndereco: TTipoEnderecoVO);
    class Procedure Altera(pTipoEndereco: TTipoEnderecoVO; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM;

var
  TipoEndereco: TTipoEnderecoVO;

class procedure TTipoEnderecoController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TTipoEnderecoVO.Create, pFiltro, pPagina);

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
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSTipoEndereco.DisableControls;
        FDataModule.CDSTipoEndereco.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSTipoEndereco.Append;
          FDataModule.CDSTipoEndereco.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSTipoEndereco.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSTipoEndereco.FieldByName('DESCRICAO').AsString := ResultSet.Value['DESCRICAO'].AsString;
          FDataModule.CDSTipoEndereco.Post;
        end;
        FDataModule.CDSTipoEndereco.Open;
        FDataModule.CDSTipoEndereco.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TTipoEnderecoController.Insere(pTipoEndereco: TTipoEnderecoVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pTipoEndereco);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TTipoEnderecoController.Altera(pTipoEndereco: TTipoEnderecoVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pTipoEndereco);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TTipoEnderecoController.Exclui(pId: Integer);
begin
  try
    try
      TipoEndereco := TTipoEnderecoVO.Create;
      TipoEndereco.Id := pId;
      TT2TiORM.Excluir(TipoEndereco);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
