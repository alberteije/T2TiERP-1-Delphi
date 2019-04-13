{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do cliente.

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
unit ClienteController;

interface

uses
  Classes, SQLExpr, SysUtils, ClienteVO, Generics.Collections;

type
  TClienteController = class
  protected
  public
    class Function ConsultaCPFCNPJ(pCPFouCNPJ: String): TClienteVO;
    class function ConsultaIdCliente(pId: Integer): Boolean;
    class function ConsultaPeloID(pId: Integer): TClienteVO;
    class Function ConsultaClienteSPED(pDataInicial, pDataFinal: String): TObjectList<TClienteVO>;
    class function GravaCargaCliente(vTupla: String): Boolean;
 end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TClienteController.ConsultaCPFCNPJ(pCPFouCNPJ: String): TClienteVO;
var
  Cliente : TClienteVO;
begin
  ConsultaSQL := 'select * from CLIENTE where CPF_CNPJ='+QuotedStr(pCPFouCNPJ);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Cliente := TClienteVO.Create;
      Cliente.Id := Query.FieldByName('ID').AsInteger;
      Cliente.IdSituacaoCliente := Query.FieldByName('ID_SITUACAO_CLIENTE').AsInteger;
      Cliente.Nome := Query.FieldByName('NOME').AsString;
      Cliente.Fantasia := Query.FieldByName('FANTASIA').AsString;
      Cliente.Email := Query.FieldByName('EMAIL').AsString;
      Cliente.CPFOuCNPJ := Query.FieldByName('CPF_CNPJ').AsString;
      Cliente.Rg := Query.FieldByName('RG').AsString;
      Cliente.OrgaoRg := Query.FieldByName('ORGAO_RG').AsString;
      Cliente.DataEmissaoRg := Query.FieldByName('DATA_EMISSAO_RG').AsString;
      Cliente.Sexo := Query.FieldByName('SEXO').AsString;
      Cliente.InscricaoEstadual := Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
      Cliente.InscricaoMunicipal := Query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      Cliente.TipoPessoa := Query.FieldByName('TIPO_PESSOA').AsString;
      Cliente.DataCadastro := Query.FieldByName('DATA_CADASTRO').AsString;
      Cliente.Contato := Query.FieldByName('CONTATO').AsString;
      Cliente.Logradouro := Query.FieldByName('LOGRADOURO').AsString;
      Cliente.Numero := Query.FieldByName('NUMERO').AsString;
      Cliente.Complemento := Query.FieldByName('COMPLEMENTO').AsString;
      Cliente.Cep := Query.FieldByName('CEP').AsString;
      Cliente.Bairro := Query.FieldByName('BAIRRO').AsString;
      Cliente.Cidade := Query.FieldByName('CIDADE').AsString;
      Cliente.Uf := Query.FieldByName('UF').AsString;
      Cliente.Fone1 := Query.FieldByName('FONE1').AsString;
      Cliente.Fone2 := Query.FieldByName('FONE2').AsString;
      Cliente.Celular := Query.FieldByName('CELULAR').AsString;
      Cliente.CodigoIbgeCidade := Query.FieldByName('CODIGO_IBGE_CIDADE').AsInteger;
      Cliente.CodigoIbgeUf := Query.FieldByName('CODIGO_IBGE_UF').AsInteger;

      result := Cliente;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TClienteController.ConsultaIdCliente(pId: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from Cliente where (ID = :pID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger := pId;
      Query.Open;
      if not Query.IsEmpty then
        result := true
      else
        result := false;
    except

    end;
  finally
    Query.Free;
  end;

end;

class function TClienteController.ConsultaPeloID(pId: Integer): TClienteVO;
var
  Cliente : TClienteVO;
begin
  ConsultaSQL := 'select * from CLIENTE where ID='+IntToStr(pId);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Cliente := TClienteVO.Create;

      Cliente.Id := Query.FieldByName('ID').AsInteger;
      Cliente.IdSituacaoCliente := Query.FieldByName('ID_SITUACAO_CLIENTE').AsInteger;
      Cliente.Nome := Query.FieldByName('NOME').AsString;
      Cliente.Fantasia := Query.FieldByName('FANTASIA').AsString;
      Cliente.Email := Query.FieldByName('EMAIL').AsString;
      Cliente.CPFOuCNPJ := Query.FieldByName('CPF_CNPJ').AsString;
      Cliente.Rg := Query.FieldByName('RG').AsString;
      Cliente.OrgaoRg := Query.FieldByName('ORGAO_RG').AsString;
      Cliente.DataEmissaoRg := Query.FieldByName('DATA_EMISSAO_RG').AsString;
      Cliente.Sexo := Query.FieldByName('SEXO').AsString;
      Cliente.InscricaoEstadual := Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
      Cliente.InscricaoMunicipal := Query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      Cliente.TipoPessoa := Query.FieldByName('TIPO_PESSOA').AsString;
      Cliente.DataCadastro := Query.FieldByName('DATA_CADASTRO').AsString;
      Cliente.Contato := Query.FieldByName('CONTATO').AsString;
      Cliente.Logradouro := Query.FieldByName('LOGRADOURO').AsString;
      Cliente.Numero := Query.FieldByName('NUMERO').AsString;
      Cliente.Complemento := Query.FieldByName('COMPLEMENTO').AsString;
      Cliente.Cep := Query.FieldByName('CEP').AsString;
      Cliente.Bairro := Query.FieldByName('BAIRRO').AsString;
      Cliente.Cidade := Query.FieldByName('CIDADE').AsString;
      Cliente.Uf := Query.FieldByName('UF').AsString;
      Cliente.Fone1 := Query.FieldByName('FONE1').AsString;
      Cliente.Fone2 := Query.FieldByName('FONE2').AsString;
      Cliente.Celular := Query.FieldByName('CELULAR').AsString;
      Cliente.CodigoIbgeCidade := Query.FieldByName('CODIGO_IBGE_CIDADE').AsInteger;
      Cliente.CodigoIbgeUf := Query.FieldByName('CODIGO_IBGE_UF').AsInteger;

      result := Cliente;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TClienteController.ConsultaClienteSPED(pDataInicial, pDataFinal: String): TObjectList<TClienteVO>;
var
  ListaCliente: TObjectList<TClienteVO>;
  Cliente: TClienteVO;
  TotalRegistros: Integer;
  DataInicio, DataFim : String ;
begin
  try
    try
      DataInicio := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial)));
      DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal)));

      ConsultaSQL := ' select count(*) as total from NFE_CABECALHO where DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaCliente := TObjectList<TClienteVO>.Create;
        ConsultaSQL :=  ' select '+
                        ' c.nome, '+
                        ' c.rg, '+
                        ' c.orgao_rg, '+
                        ' c.cpf_cnpj, '+
                        ' c.tipo, '+
                        ' c.inscricao_estadual, '+
                        ' c.inscricao_municipal, '+
                        ' c.data_cadastro, '+
                        ' p.codigo_ibge_cidade, '+
                        ' p.logradouro, '+
                        ' p.numero, '+
                        ' p.complemento, '+
                        ' p.bairro, '+
                        ' p.uf '+
                        ' from '+
                        ' pessoa c, pessoa_endereco p '+
                        ' where '+
                        ' c.id in (select ID  from NFE_CABECALHO where DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim)+')';

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;

        while not Query.Eof do
        begin
          Cliente := TClienteVO.Create;
          Cliente.Id := Query.FieldByName('PID').AsInteger;
          Cliente.TipoPessoa := Query.FieldByName('TIPO_PESSOA').AsString;
          Cliente.Nome := Query.FieldByName('NOME').AsString;
          Cliente.CPFOuCNPJ := Query.FieldByName('CPF_CNPJ').AsString;
          Cliente.Rg := Query.FieldByName('RG').AsString;
          Cliente.OrgaoRg := Query.FieldByName('ORGAO_RG').AsString;
          Cliente.InscricaoEstadual := Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
          Cliente.InscricaoMunicipal := Query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
          Cliente.DataCadastro := Query.FieldByName('DATA_CADASTRO').AsString;
          Cliente.Logradouro := Query.FieldByName('LOGRADOURO').AsString;
          Cliente.Numero := Query.FieldByName('NUMERO').AsString;
          Cliente.Complemento := Query.FieldByName('COMPLEMENTO').AsString;
          Cliente.Cep := Query.FieldByName('CEP').AsString;
          Cliente.Bairro := Query.FieldByName('BAIRRO').AsString;
          Cliente.Cidade := Query.FieldByName('CIDADE').AsString;
          Cliente.Uf := Query.FieldByName('UF').AsString;
          Cliente.CodigoIbgeCidade := Query.FieldByName('CODIGO_IBGE_CIDADE').AsInteger;
          ListaCliente.Add(Cliente);
          Query.next;
        end;
        result := ListaCliente;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TClienteController.GravaCargaCliente(vTupla: String): Boolean;
var
  ID: integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL:= ' UPDATE OR INSERT INTO CLIENTE '+
          '(ID, '+                            //  ID                   INTEGER NOT NULL,
          'ID_SITUACAO_CLIENTE, '+            //  ID_SITUACAO_CLIENTE  INTEGER NOT NULL,
          'NOME, '+                           //  NOME                 VARCHAR(150),
          'FANTASIA, '+                       //  FANTASIA             VARCHAR(150),
          'EMAIL, '+                          //  EMAIL                VARCHAR(250),
          'CPF_CNPJ, '+                       //  CPF_CNPJ             VARCHAR(14),
          'RG, '+                             //  RG                   VARCHAR(20),
          'ORGAO_RG, '+                       //  ORGAO_RG             VARCHAR(20),
          'DATA_EMISSAO_RG, '+                //  DATA_EMISSAO_RG      DATE,
          'SEXO, '+                           //  SEXO                 CHAR(1),
          'INSCRICAO_ESTADUAL, '+             //  INSCRICAO_ESTADUAL   VARCHAR(30),
          'INSCRICAO_MUNICIPAL, '+            //  INSCRICAO_MUNICIPAL  VARCHAR(30),
          'TIPO_PESSOA, '+                    //  TIPO_PESSOA          CHAR(1),
          'DATA_CADASTRO, '+                  //  DATA_CADASTRO        DATE,
          'LOGRADOURO, '+                     //  LOGRADOURO           VARCHAR(250),
          'NUMERO, '+                         //  NUMERO               VARCHAR(6),
          'COMPLEMENTO, '+                    //  COMPLEMENTO          VARCHAR(50),
          'CEP, '+                            //  CEP                  VARCHAR(8),
          'BAIRRO, '+                         //  BAIRRO               VARCHAR(100),
          'CIDADE, '+                         //  CIDADE               VARCHAR(100),
          'UF, '+                             //  UF                   CHAR(2),
          'FONE1, '+                          //  FONE1                VARCHAR(10),
          'FONE2, '+                          //  FONE2                VARCHAR(10),
          'CELULAR, '+                        //  CELULAR              VARCHAR(10),
          'CONTATO, '+                        //  CONTATO              VARCHAR(50),
          'CODIGO_IBGE_CIDADE, '+             //  CODIGO_IBGE_CIDADE   INTEGER,
          'CODIGO_IBGE_UF) '+                 //  CODIGO_IBGE_UF       INTEGER

{CLIENTE
|1
|1
|'jose'
|NULL
|NULL
|'11111111111'
|NULL
|NULL
|NULL
|NULL
|NULL
|NULL
|'1000-01-01'
|NULL
|'N'
|'2011-09-10'
|'Rua da Amargura'
|'25'
|NULL
|'19470000'
|'Bairro da Luz'
|'São Paulo'
|'SP'
|NULL
|NULL
|NULL
|NULL
|19470
|777
|   }


       ' values ('+
          DevolveConteudoDelimitado('|',vTupla)+','+  //  ID                   INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+','+  //  ID_SITUACAO_CLIENTE  INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+','+  //  NOME                 VARCHAR(150),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  FANTASIA             VARCHAR(150),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  EMAIL                VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  CPF_CNPJ             VARCHAR(14),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  RG                   VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  ORGAO_RG             VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  DATA_EMISSAO_RG      DATE,
          DevolveConteudoDelimitado('|',vTupla)+','+  //  SEXO                 CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  INSCRICAO_ESTADUAL   VARCHAR(30),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  INSCRICAO_MUNICIPAL  VARCHAR(30),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  TIPO_PESSOA          CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  DATA_CADASTRO        DATE,
          DevolveConteudoDelimitado('|',vTupla)+','+  //  LOGRADOURO           VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  NUMERO               VARCHAR(6),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  COMPLEMENTO          VARCHAR(50),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  CEP                  VARCHAR(8),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  BAIRRO               VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  CIDADE               VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  UF                   CHAR(2),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  FONE1                VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  FONE2                VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  CELULAR              VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  CONTATO              VARCHAR(50),
          DevolveConteudoDelimitado('|',vTupla)+','+  //  CODIGO_IBGE_CIDADE   INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+')';  //  CODIGO_IBGE_UF       INTEGER


      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));                        //    ID              INTEGER NOT NULL,
        if not ConsultaIdCliente(ID) then
           ConsultaSQL := ' INSERT INTO CLIENTE '+
          '(ID, '+
          'ID_SITUACAO_CLIENTE, '+
          'NOME, '+
          'FANTASIA, '+
          'EMAIL, '+
          'CPF_CNPJ, '+
          'RG, '+
          'ORGAO_RG, '+
          'DATA_EMISSAO_RG, '+
          'SEXO, '+
          'INSCRICAO_ESTADUAL, '+
          'INSCRICAO_MUNICIPAL, '+
          'TIPO_PESSOA, '+
          'DATA_CADASTRO, '+
          'LOGRADOURO, '+
          'NUMERO, '+
          'COMPLEMENTO, '+
          'CEP, '+
          'BAIRRO, '+
          'CIDADE, '+
          'UF, '+
          'FONE1, '+
          'FONE2, '+
          'CELULAR, '+
          'CONTATO, '+
          'CODIGO_IBGE_CIDADE, '+
          'CODIGO_IBGE_UF) '+
       ' values ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+','+    //   ID_SITUACAO_CLIENTE  INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+','+    //   NOME                 VARCHAR(150),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   FANTASIA             VARCHAR(150),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   EMAIL                VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   CPF_CNPJ             VARCHAR(14),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   RG                   VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   ORGAO_RG             VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   DATA_EMISSAO_RG      DATE,
          DevolveConteudoDelimitado('|',vTupla)+','+    //   SEXO                 CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   INSCRICAO_ESTADUAL   VARCHAR(30),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   INSCRICAO_MUNICIPAL  VARCHAR(30),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   TIPO_PESSOA          CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   DATA_CADASTRO        DATE,
          DevolveConteudoDelimitado('|',vTupla)+','+    //   LOGRADOURO           VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   NUMERO               VARCHAR(6),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   COMPLEMENTO          VARCHAR(50),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   CEP                  VARCHAR(8),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   BAIRRO               VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   CIDADE               VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   UF                   CHAR(2),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   FONE1                VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   FONE2                VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   CELULAR              VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   CONTATO              VARCHAR(50),
          DevolveConteudoDelimitado('|',vTupla)+','+    //   CODIGO_IBGE_CIDADE   INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+')'     //   CODIGO_IBGE_UF       INTEGER
        else
          ConsultaSQL := ' update CLIENTE set '+
          'ID_SITUACAO_CLIENTE ='+ DevolveConteudoDelimitado('|',vTupla)+','+  //   ID_SITUACAO_CLIENTE  INTEGER NOT NULL,
          'NOME ='+                DevolveConteudoDelimitado('|',vTupla)+','+  //   NOME                 VARCHAR(150),
          'FANTASIA ='+            DevolveConteudoDelimitado('|',vTupla)+','+  //   FANTASIA             VARCHAR(150),
          'EMAIL ='+               DevolveConteudoDelimitado('|',vTupla)+','+  //   EMAIL                VARCHAR(250),
          'CPF_CNPJ ='+            DevolveConteudoDelimitado('|',vTupla)+','+  //   CPF_CNPJ             VARCHAR(14),
          'RG ='+                  DevolveConteudoDelimitado('|',vTupla)+','+  //   RG                   VARCHAR(20),
          'ORGAO_RG ='+            DevolveConteudoDelimitado('|',vTupla)+','+  //   ORGAO_RG             VARCHAR(20),
          'DATA_EMISSAO_RG ='+     DevolveConteudoDelimitado('|',vTupla)+','+  //   DATA_EMISSAO_RG      DATE,
          'SEXO ='+                DevolveConteudoDelimitado('|',vTupla)+','+  //   SEXO                 CHAR(1),
          'INSCRICAO_ESTADUAL ='+  DevolveConteudoDelimitado('|',vTupla)+','+  //   INSCRICAO_ESTADUAL   VARCHAR(30),
          'INSCRICAO_MUNICIPAL ='+ DevolveConteudoDelimitado('|',vTupla)+','+  //   INSCRICAO_MUNICIPAL  VARCHAR(30),
          'TIPO_PESSOA ='+         DevolveConteudoDelimitado('|',vTupla)+','+  //   TIPO_PESSOA          CHAR(1),
          'DATA_CADASTRO ='+       DevolveConteudoDelimitado('|',vTupla)+','+  //   DATA_CADASTRO        DATE,
          'LOGRADOURO ='+          DevolveConteudoDelimitado('|',vTupla)+','+  //   LOGRADOURO           VARCHAR(250),
          'NUMERO ='+              DevolveConteudoDelimitado('|',vTupla)+','+  //   NUMERO               VARCHAR(6),
          'COMPLEMENTO ='+         DevolveConteudoDelimitado('|',vTupla)+','+  //   COMPLEMENTO          VARCHAR(50),
          'CEP ='+                 DevolveConteudoDelimitado('|',vTupla)+','+  //   CEP                  VARCHAR(8),
          'BAIRRO ='+              DevolveConteudoDelimitado('|',vTupla)+','+  //   BAIRRO               VARCHAR(100),
          'CIDADE ='+              DevolveConteudoDelimitado('|',vTupla)+','+  //   CIDADE               VARCHAR(100),
          'UF ='+                  DevolveConteudoDelimitado('|',vTupla)+','+  //   UF                   CHAR(2),
          'FONE1 ='+               DevolveConteudoDelimitado('|',vTupla)+','+  //   FONE1                VARCHAR(10),
          'FONE2 ='+               DevolveConteudoDelimitado('|',vTupla)+','+  //   FONE2                VARCHAR(10),
          'CELULAR ='+             DevolveConteudoDelimitado('|',vTupla)+','+  //   CELULAR              VARCHAR(10),
          'CONTATO ='+             DevolveConteudoDelimitado('|',vTupla)+','+  //   CONTATO              VARCHAR(50),
          'CODIGO_IBGE_CIDADE ='+  DevolveConteudoDelimitado('|',vTupla)+','+  //   CODIGO_IBGE_CIDADE   INTEGER,
          'CODIGO_IBGE_UF ='+      DevolveConteudoDelimitado('|',vTupla)+      //   CODIGO_IBGE_UF       INTEGER
          ' where ID ='+IntToStr(ID);
      end;


      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ExecSQL();

      result := true;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

end.

