{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela PESSOA_ENDERECO

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
unit PessoaEnderecoController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, PessoaEnderecoVO, DBXCommon;

type
  TPessoaEnderecoController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pPessoaEndereco: TPessoaEnderecoVO);
    class Procedure Altera(pPessoaEndereco: TPessoaEnderecoVO; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM;

var
  PessoaEndereco: TPessoaEnderecoVO;

class procedure TPessoaEnderecoController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TPessoaEnderecoVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_PESSOA').AsInteger := ResultSet.Value['ID_PESSOA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_TIPO_ENDERECO').AsInteger := ResultSet.Value['ID_TIPO_ENDERECO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('LOGRADOURO').AsString := ResultSet.Value['LOGRADOURO'].AsString;
          FDataModule.CDSLookup.FieldByName('NUMERO').AsString := ResultSet.Value['NUMERO'].AsString;
          FDataModule.CDSLookup.FieldByName('COMPLEMENTO').AsString := ResultSet.Value['COMPLEMENTO'].AsString;
          FDataModule.CDSLookup.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSLookup.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSLookup.FieldByName('CIDADE').AsString := ResultSet.Value['CIDADE'].AsString;
          FDataModule.CDSLookup.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSLookup.FieldByName('CODIGO_IBGE_CIDADE').AsInteger := ResultSet.Value['CODIGO_IBGE_CIDADE'].AsInt32;
          FDataModule.CDSLookup.FieldByName('CODIGO_IBGE_UF').AsInteger := ResultSet.Value['CODIGO_IBGE_UF'].AsInt32;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSPessoaEndereco.DisableControls;
        FDataModule.CDSPessoaEndereco.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSPessoaEndereco.Append;
          FDataModule.CDSPessoaEndereco.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSPessoaEndereco.FieldByName('ID_PESSOA').AsInteger := ResultSet.Value['ID_PESSOA'].AsInt32;
          FDataModule.CDSPessoaEndereco.FieldByName('ID_TIPO_ENDERECO').AsInteger := ResultSet.Value['ID_TIPO_ENDERECO'].AsInt32;
          FDataModule.CDSPessoaEndereco.FieldByName('LOGRADOURO').AsString := ResultSet.Value['LOGRADOURO'].AsString;
          FDataModule.CDSPessoaEndereco.FieldByName('NUMERO').AsString := ResultSet.Value['NUMERO'].AsString;
          FDataModule.CDSPessoaEndereco.FieldByName('COMPLEMENTO').AsString := ResultSet.Value['COMPLEMENTO'].AsString;
          FDataModule.CDSPessoaEndereco.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSPessoaEndereco.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSPessoaEndereco.FieldByName('CIDADE').AsString := ResultSet.Value['CIDADE'].AsString;
          FDataModule.CDSPessoaEndereco.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSPessoaEndereco.FieldByName('CODIGO_IBGE_CIDADE').AsInteger := ResultSet.Value['CODIGO_IBGE_CIDADE'].AsInt32;
          FDataModule.CDSPessoaEndereco.FieldByName('CODIGO_IBGE_UF').AsInteger := ResultSet.Value['CODIGO_IBGE_UF'].AsInt32;
          FDataModule.CDSPessoaEndereco.Post;
        end;
        FDataModule.CDSPessoaEndereco.Open;
        FDataModule.CDSPessoaEndereco.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TPessoaEnderecoController.Insere(pPessoaEndereco: TPessoaEnderecoVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pPessoaEndereco);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TPessoaEnderecoController.Altera(pPessoaEndereco: TPessoaEnderecoVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pPessoaEndereco);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TPessoaEnderecoController.Exclui(pId: Integer);
begin
  try
    try
      PessoaEndereco := TPessoaEnderecoVO.Create;
      PessoaEndereco.Id := pId;
      TT2TiORM.Excluir(PessoaEndereco);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
