{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela PESSOA

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
unit PessoaController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, PessoaVO, DBXCommon,
  Generics.Collections, PessoaEnderecoVO;

type
  TPessoaController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure ConsultaCARGA(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pPessoa: TPessoaVO; pListaEndereco: TObjectList<TPessoaEnderecoVO>);
    class Procedure Altera(pPessoa: TPessoaVO; pListaEndereco: TObjectList<TPessoaEnderecoVO>; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM, Biblioteca;

var
  Pessoa: TPessoaVO;

class procedure TPessoaController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      pFiltro := 'P.' + pFiltro;

      ConsultaSQL :=
          'select '+
          '  p.ID, P.ID_SITUACAO_PESSOA, P.NOME, P.FANTASIA, P.EMAIL, P.TIPO, P.CPF_CNPJ, '+
          '  P.INSCRICAO_ESTADUAL, P.INSCRICAO_MUNICIPAL, P.CONTATO, P.FONE1, P.FONE2, P.CELULAR, '+
          '  P.RG, P.ORGAO_RG, P.DATA_EMISSAO_RG, P.SEXO, P.DATA_CADASTRO, S.NOME AS NOME_SITUACAO_PESSOA '+
          'from '+
          '  PESSOA P, SITUACAO_PESSOA S '+
          'where '+
          '  P.ID_SITUACAO_PESSOA = S.ID';

      resultSet := TT2TiORM.Consultar(ConsultaSQL, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSLookup.FieldByName('TIPO').AsString := ResultSet.Value['TIPO'].AsString;
          FDataModule.CDSLookup.FieldByName('FISICA_JURIDICA').AsString := ResultSet.Value['FISICA_JURIDICA'].AsString;
          FDataModule.CDSLookup.FieldByName('CPF_CNPJ').AsString := ResultSet.Value['CPF_CNPJ'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSPessoa.DisableControls;
        FDataModule.CDSPessoa.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSPessoa.Append;
          FDataModule.CDSPessoa.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSPessoa.FieldByName('ID_SITUACAO_PESSOA').AsInteger := ResultSet.Value['ID_SITUACAO_PESSOA'].AsInt32;
          FDataModule.CDSPessoa.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSPessoa.FieldByName('FANTASIA').AsString := ResultSet.Value['FANTASIA'].AsString;
          FDataModule.CDSPessoa.FieldByName('EMAIL').AsString := ResultSet.Value['EMAIL'].AsString;
          FDataModule.CDSPessoa.FieldByName('TIPO').AsString := ResultSet.Value['TIPO'].AsString;
          //FDataModule.CDSPessoa.FieldByName('FISICA_JURIDICA').AsString := ResultSet.Value['FISICA_JURIDICA'].AsString;
          FDataModule.CDSPessoa.FieldByName('CPF_CNPJ').AsString := ResultSet.Value['CPF_CNPJ'].AsString;
          FDataModule.CDSPessoa.FieldByName('INSCRICAO_ESTADUAL').AsString := ResultSet.Value['INSCRICAO_ESTADUAL'].AsString;
          FDataModule.CDSPessoa.FieldByName('INSCRICAO_MUNICIPAL').AsString := ResultSet.Value['INSCRICAO_MUNICIPAL'].AsString;
          FDataModule.CDSPessoa.FieldByName('CONTATO').AsString := ResultSet.Value['CONTATO'].AsString;
          FDataModule.CDSPessoa.FieldByName('FONE1').AsString := ResultSet.Value['FONE1'].AsString;
          FDataModule.CDSPessoa.FieldByName('FONE2').AsString := ResultSet.Value['FONE2'].AsString;
          FDataModule.CDSPessoa.FieldByName('CELULAR').AsString := ResultSet.Value['CELULAR'].AsString;
          FDataModule.CDSPessoa.FieldByName('RG').AsString := ResultSet.Value['RG'].AsString;
          FDataModule.CDSPessoa.FieldByName('ORGAO_RG').AsString := ResultSet.Value['ORGAO_RG'].AsString;
          FDataModule.CDSPessoa.FieldByName('DATA_EMISSAO_RG').AsDateTime := ResultSet.Value['DATA_EMISSAO_RG'].GetDate;
          FDataModule.CDSPessoa.FieldByName('SEXO').AsString := ResultSet.Value['SEXO'].AsString;
          FDataModule.CDSPessoa.FieldByName('DATA_CADASTRO').AsDateTime := ResultSet.Value['DATA_CADASTRO'].GetDate;
          FDataModule.CDSPessoa.FieldByName('NOME_SITUACAO_PESSOA').AsString := ResultSet.Value['NOME_SITUACAO_PESSOA'].AsString;
          FDataModule.CDSPessoa.Post;
        end;
        FDataModule.CDSPessoa.Open;
        FDataModule.CDSPessoa.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class procedure TPessoaController.ConsultaCARGA(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
  i: integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
    //  pFiltro := 'P.' + pFiltro;

      ConsultaSQL :=
          'select '+
            'P.ID, '+                                         //  ID                   INTEGER NOT NULL,
            'P.ID_SITUACAO_PESSOA  as ID_SITUACAO_CLIENTE, '+ //  ID_SITUACAO_CLIENTE  INTEGER NOT NULL,
            'P.NOME, '+                                       //  NOME                 VARCHAR(150),
            'P.FANTASIA, '+                                   //  FANTASIA             VARCHAR(150),
            'P.EMAIL, '+                                      //  EMAIL                VARCHAR(250),
            'P.CPF_CNPJ, '+                                   //  CPF_CNPJ             VARCHAR(14),
            'P.RG, '+                                         //  RG                   VARCHAR(20),
            'P.ORGAO_RG, '+                                   //  ORGAO_RG             VARCHAR(20),
            'P.DATA_EMISSAO_RG, '+                            //  DATA_EMISSAO_RG      DATE,
            'P.SEXO, '+                                       //  SEXO                 CHAR(1),
            'P.INSCRICAO_ESTADUAL, '+                         //  INSCRICAO_ESTADUAL   VARCHAR(30),
            'P.INSCRICAO_MUNICIPAL, '+                        //  INSCRICAO_MUNICIPAL  VARCHAR(30),
                                                              //  DESDE                DATE,
            'P.TIPO as TIPO_PESSOA, '+                        //  TIPO_PESSOA          CHAR(1),
                                                              //  EXCLUIDO             CHAR(1),
            'P.DATA_CADASTRO, '+                              //  DATA_CADASTRO        DATE,
            'E.LOGRADOURO, '+                                 //  LOGRADOURO           VARCHAR(250),
            'E.NUMERO, '+                                     //  NUMERO               VARCHAR(6),
            'E.COMPLEMENTO, '+                                //  COMPLEMENTO          VARCHAR(50),
            'E.CEP, '+                                        //  CEP                  VARCHAR(8),
            'E.BAIRRO, '+                                     //  BAIRRO               VARCHAR(100),
            'E.CIDADE, '+                                     //  CIDADE               VARCHAR(100),
            'E.UF, '+                                         //  UF                   CHAR(2),
            'P.FONE1, '+                                      //  FONE1                VARCHAR(10),
            'P.FONE2, '+                                      //  FONE2                VARCHAR(10),
            'P.CELULAR, '+                                    //  CELULAR              VARCHAR(10),
            'P.CONTATO, '+                                    //  CONTATO              VARCHAR(50),
            'E.CODIGO_IBGE_CIDADE, '+                         //  CODIGO_IBGE_CIDADE   INTEGER,
            'E.CODIGO_IBGE_UF '+                              //  CODIGO_IBGE_UF       INTEGER

            ' from PESSOA P,  PESSOA_ENDERECO E where  (P.ID = E.ID_PESSOA) ';




      resultSet := TT2TiORM.Consultar(ConsultaSQL, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSLookup.FieldByName('TIPO').AsString := ResultSet.Value['TIPO'].AsString;
          FDataModule.CDSLookup.FieldByName('FISICA_JURIDICA').AsString := ResultSet.Value['FISICA_JURIDICA'].AsString;
          FDataModule.CDSLookup.FieldByName('CPF_CNPJ').AsString := ResultSet.Value['CPF_CNPJ'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSPessoa.DisableControls;
        FDataModule.CDSPessoa.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSPessoa.Append;
          for I := 0 to FDataModule.CDSPessoa.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSPessoa.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
             if ResultSet.Value[FDataModule.CDSPessoa.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSPessoa.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSPessoa.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSPessoa.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSResolucao.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSPessoa.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSPessoa.FieldDefList[i].Name].AsDouble;
              end
              else FDataModule.CDSPessoa.Fields[i].AsFloat := 0;
            end
            else
            if ResultSet.Value[FDataModule.CDSPessoa.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSPessoa.Fields[i].AsString := ResultSet.Value[FDataModule.CDSPessoa.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSPessoa.Post;
          {
          FDataModule.CDSPessoa.Append;
          FDataModule.CDSPessoa.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSPessoa.FieldByName('ID_SITUACAO_PESSOA').AsInteger := ResultSet.Value['ID_SITUACAO_PESSOA'].AsInt32;
          FDataModule.CDSPessoa.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSPessoa.FieldByName('FANTASIA').AsString := ResultSet.Value['FANTASIA'].AsString;
          FDataModule.CDSPessoa.FieldByName('EMAIL').AsString := ResultSet.Value['EMAIL'].AsString;
          FDataModule.CDSPessoa.FieldByName('TIPO').AsString := ResultSet.Value['TIPO'].AsString;
          //FDataModule.CDSPessoa.FieldByName('FISICA_JURIDICA').AsString := ResultSet.Value['FISICA_JURIDICA'].AsString;
          FDataModule.CDSPessoa.FieldByName('CPF_CNPJ').AsString := ResultSet.Value['CPF_CNPJ'].AsString;
          FDataModule.CDSPessoa.FieldByName('INSCRICAO_ESTADUAL').AsString := ResultSet.Value['INSCRICAO_ESTADUAL'].AsString;
          FDataModule.CDSPessoa.FieldByName('INSCRICAO_MUNICIPAL').AsString := ResultSet.Value['INSCRICAO_MUNICIPAL'].AsString;
          FDataModule.CDSPessoa.FieldByName('CONTATO').AsString := ResultSet.Value['CONTATO'].AsString;
          FDataModule.CDSPessoa.FieldByName('FONE1').AsString := ResultSet.Value['FONE1'].AsString;
          FDataModule.CDSPessoa.FieldByName('FONE2').AsString := ResultSet.Value['FONE2'].AsString;
          FDataModule.CDSPessoa.FieldByName('CELULAR').AsString := ResultSet.Value['CELULAR'].AsString;
          FDataModule.CDSPessoa.FieldByName('RG').AsString := ResultSet.Value['RG'].AsString;
          FDataModule.CDSPessoa.FieldByName('ORGAO_RG').AsString := ResultSet.Value['ORGAO_RG'].AsString;
          FDataModule.CDSPessoa.FieldByName('DATA_EMISSAO_RG').AsString := ResultSet.Value['DATA_EMISSAO_RG'].AsString;
          FDataModule.CDSPessoa.FieldByName('SEXO').AsString := ResultSet.Value['SEXO'].AsString;
          FDataModule.CDSPessoa.FieldByName('DATA_CADASTRO').AsString := ResultSet.Value['DATA_CADASTRO'].AsString;
          FDataModule.CDSPessoa.FieldByName('NOME_SITUACAO_PESSOA').AsString := ResultSet.Value['NOME_SITUACAO_PESSOA'].AsString;
          FDataModule.CDSPessoa.FieldByName('LOGRADOURO').AsString := ResultSet.Value['LOGRADOURO'].AsString;
          FDataModule.CDSPessoa.FieldByName('NUMERO').AsString := ResultSet.Value['NUMERO'].AsString;
          FDataModule.CDSPessoa.FieldByName('COMPLEMENTO').AsString := ResultSet.Value['COMPLEMENTO'].AsString;
          FDataModule.CDSPessoa.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSPessoa.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSPessoa.FieldByName('CIDADE').AsString := ResultSet.Value['CIDADE'].AsString;
          FDataModule.CDSPessoa.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSPessoa.FieldByName('CODIGO_IBGE_CIDADE').AsString := ResultSet.Value['CODIGO_IBGE_CIDADE'].AsString;
          FDataModule.CDSPessoa.FieldByName('CODIGO_IBGE_UF').AsString := ResultSet.Value['CODIGO_IBGE_UF'].AsString;
          FDataModule.CDSPessoa.Post;
          }
        end;
        //FDataModule.CDSPessoa.Open;
        FDataModule.CDSPessoa.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TPessoaController.Insere(pPessoa: TPessoaVO; pListaEndereco: TObjectList<TPessoaEnderecoVO>);
var
  I, UltimoID:Integer;
  PessoaEndereco: TPessoaEnderecoVO;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pPessoa);

      for I := 0 to pListaEndereco.Count - 1 do
      begin
        PessoaEndereco := pListaEndereco.Items[i];
        PessoaEndereco.IdPessoa := UltimoID;
        TT2TiORM.Inserir(PessoaEndereco);
      end;

      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TPessoaController.Altera(pPessoa: TPessoaVO; pListaEndereco: TObjectList<TPessoaEnderecoVO>; pFiltro: String; pPagina: Integer);
var
  I:Integer;
  PessoaEndereco: TPessoaEnderecoVO;
begin
  try
    try
      TT2TiORM.Alterar(pPessoa);

      for I := 0 to pListaEndereco.Count - 1 do
      begin
        PessoaEndereco := pListaEndereco.Items[i];
        TT2TiORM.Alterar(PessoaEndereco);
      end;

      Consulta(pFiltro, pPagina, False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TPessoaController.Exclui(pId: Integer);
begin
  try
    try
      Pessoa := TPessoaVO.Create;
      Pessoa.Id := pId;
      TT2TiORM.Excluir(Pessoa);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
