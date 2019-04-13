{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da empresa.

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
unit EmpresaController;

interface

uses
  Classes, SQLExpr, SysUtils, EmpresaVO;

type
  TEmpresaController = class
  protected
  public
    class function PegaEmpresa(Id:Integer): TEmpresaVO;
    class function ConsultaIdEmpresa(Id: Integer): Boolean;
    class function GravaCargaEmpresa(vTupla: String): Boolean;

  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TEmpresaController.PegaEmpresa(Id:Integer): TEmpresaVO;

var
  Empresa: TEmpresaVO;
begin
  ConsultaSQL := 'select * from ECF_EMPRESA where ID=' + IntToStr(Id);

  Empresa := TEmpresaVO.Create;

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Empresa.Id                     := Query.FieldByName('ID').AsInteger;
      Empresa.IdEmpresa              := Query.FieldByName('ID_EMPRESA').AsInteger;
      Empresa.RazaoSocial            := Query.FieldByName('RAZAO_SOCIAL').AsString;
      Empresa.NomeFantasia           := Query.FieldByName('NOME_FANTASIA').AsString;
      Empresa.Cnpj                   := Query.FieldByName('CNPJ').AsString;
      Empresa.InscricaoEstadual      := Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
      Empresa.InscricaoEstadualSt    := Query.FieldByName('INSCRICAO_ESTADUAL_ST').AsString;
      Empresa.InscricaoMunicipal     := Query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      Empresa.InscricaoJuntaComercial:= Query.FieldByName('INSCRICAO_JUNTA_COMERCIAL').AsString;
      Empresa.DataInscJuntaComercial := Query.FieldByName('DATA_INSC_JUNTA_COMERCIAL').AsString;
      Empresa.MatrizFilial           := Query.FieldByName('MATRIZ_FILIAL').AsString;
      Empresa.DataCadastro           := Query.FieldByName('DATA_CADASTRO').AsString;
      Empresa.DataInicioAtividades   := Query.FieldByName('DATA_INICIO_ATIVIDADES').AsString;
      Empresa.Suframa                := Query.FieldByName('SUFRAMA').AsString;
      Empresa.Email                  := Query.FieldByName('EMAIL').AsString;
      Empresa.ImagemLogotipo         := Query.FieldByName('IMAGEM_LOGOTIPO').AsString;
      Empresa.Crt                    := Query.FieldByName('CRT').AsString;
      Empresa.TipoRegime             := Query.FieldByName('TIPO_REGIME').AsString;
      Empresa.AliquotaPis            := Query.FieldByName('ALIQUOTA_PIS').AsFloat;
      Empresa.AliquotaCofins         := Query.FieldByName('ALIQUOTA_COFINS').AsFloat;
      Empresa.Logradouro             := Query.FieldByName('LOGRADOURO').AsString;
      Empresa.Numero                 := Query.FieldByName('NUMERO').AsString;
      Empresa.Complemento            := Query.FieldByName('COMPLEMENTO').AsString;
      Empresa.Cep                    := Query.FieldByName('CEP').AsString;
      Empresa.Bairro                 := Query.FieldByName('BAIRRO').AsString;
      Empresa.Cidade                 := Query.FieldByName('CIDADE').AsString;
      Empresa.Uf                     := Query.FieldByName('UF').AsString;
      Empresa.Fone                   := Query.FieldByName('FONE').AsString;
      Empresa.Fax                    := Query.FieldByName('FAX').AsString;
      Empresa.Contato                := Query.FieldByName('CONTATO').AsString;
      Empresa.CodigoIbgeCidade       := Query.FieldByName('CODIGO_IBGE_CIDADE').AsInteger;
      Empresa.CodigoIbgeUf           := Query.FieldByName('CODIGO_IBGE_UF').AsInteger;

      result := Empresa;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TEmpresaController.ConsultaIdEmpresa(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from ECF_EMPRESA where (ID = :pID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger:=Id;
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

class function TEmpresaController.GravaCargaEmpresa(vTupla: String): Boolean;
var
  ID: integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL := 'UPDATE OR INSERT INTO ECF_EMPRESA ' +
        ' (ID, '+
        'ID_EMPRESA, '+
        'RAZAO_SOCIAL, '+
        'NOME_FANTASIA, '+
        'CNPJ, '+
        'INSCRICAO_ESTADUAL, '+
        'INSCRICAO_ESTADUAL_ST, '+
        'INSCRICAO_MUNICIPAL, '+
        'INSCRICAO_JUNTA_COMERCIAL, '+
        'DATA_INSC_JUNTA_COMERCIAL, '+
        'MATRIZ_FILIAL, '+
        'DATA_CADASTRO, '+
        'DATA_INICIO_ATIVIDADES, '+
        'SUFRAMA, '+
        'EMAIL, '+
        'IMAGEM_LOGOTIPO, '+
        'CRT, '+
        'TIPO_REGIME, '+
        'ALIQUOTA_PIS, '+
        'ALIQUOTA_COFINS, '+
        'LOGRADOURO, '+
        'NUMERO, '+
        'COMPLEMENTO, '+
        'CEP, '+
        'BAIRRO, '+
        'CIDADE, '+
        'UF, '+
        'FONE, '+
        'FAX, '+
        'CONTATO, '+
        'CODIGO_IBGE_CIDADE, '+
        'CODIGO_IBGE_UF) '+


        ' values ('+

        DevolveConteudoDelimitado('|',vTupla)+','+  //   ID                         INTEGER NOT NULL,    //  1
        DevolveConteudoDelimitado('|',vTupla)+','+  //   ID_EMPRESA                 INTEGER              //  1
        DevolveConteudoDelimitado('|',vTupla)+','+  //   RAZAO_SOCIAL               VARCHAR(150),        //  'T2TI.COM TECNOLOGIA DA INFORMACAO LTDA'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   NOME_FANTASIA              VARCHAR(150),        //  'T2TI.COM'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   CNPJ                       VARCHAR(14),         //  '10793118000178'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   INSCRICAO_ESTADUAL         VARCHAR(30),         //  '0751990400114'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   INSCRICAO_ESTADUAL_ST      VARCHAR(30),         //  'ISENTO'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   INSCRICAO_MUNICIPAL        VARCHAR(30),         //  'ISENTO'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   INSCRICAO_JUNTA_COMERCIAL  VARCHAR(30),         //  NULL
        DevolveConteudoDelimitado('|',vTupla)+','+  //   DATA_INSC_JUNTA_COMERCIAL  DATE,                //  NULL
        DevolveConteudoDelimitado('|',vTupla)+','+  //   MATRIZ_FILIAL              CHAR(1),             //  '01/01/2007'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   DATA_CADASTRO              DATE,                //  '01/01/2007'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   DATA_INICIO_ATIVIDADES     DATE,                //  NULL
        DevolveConteudoDelimitado('|',vTupla)+','+  //   SUFRAMA                    VARCHAR(9),          //  't2ti.com@gmail.com'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   EMAIL                      VARCHAR(250),        //  NULL
        DevolveConteudoDelimitado('|',vTupla)+','+  //   IMAGEM_LOGOTIPO            VARCHAR(250),        //  '3'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   CRT                        CHAR(1),             //  '1'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   TIPO_REGIME                CHAR(1),             //  NULL
        DevolveConteudoDelimitado('|',vTupla)+','+  //   ALIQUOTA_PIS               DECIMAL(18,6),       //  NULL
        DevolveConteudoDelimitado('|',vTupla)+','+  //   ALIQUOTA_COFINS            DECIMAL(18,6),       //  'RUA DAS CARNAUBAS'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   LOGRADOURO                 VARCHAR(250),        //  '4'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   NUMERO                     VARCHAR(6),          //  'PLAZZA'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   COMPLEMENTO                VARCHAR(100),        //  '71904540'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   CEP                        VARCHAR(8),          //  'AGUAS CLARAS'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   BAIRRO                     VARCHAR(100),        //  'BRASILIA'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   CIDADE                     VARCHAR(100),        //  'DF'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   UF                         CHAR(2),             //  '30425277'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   FONE                       VARCHAR(10),         //  NULL
        DevolveConteudoDelimitado('|',vTupla)+','+  //   FAX                        VARCHAR(10),         //  'ALBERT'
        DevolveConteudoDelimitado('|',vTupla)+','+  //   CONTATO                    VARCHAR(30),         //  5300108
        DevolveConteudoDelimitado('|',vTupla)+','+  //   CODIGO_IBGE_CIDADE         INTEGER,             //  53
        DevolveConteudoDelimitado('|',vTupla)+')';  //   CODIGO_IBGE_UF             INTEGER,

      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));            //    ID              INTEGER NOT NULL,

        if not ConsultaIdEmpresa(ID) then
          ConsultaSQL :=  'UPDATE  ECF_EMPRESA set '+
        'ID_EMPRESA ='+                         DevolveConteudoDelimitado('|',vTupla)+','+  //   ID_EMPRESA                 INTEGER
        'RAZAO_SOCIAL ='+                       DevolveConteudoDelimitado('|',vTupla)+','+  //   RAZAO_SOCIAL               VARCHAR(150),
        'NOME_FANTASIA ='+                      DevolveConteudoDelimitado('|',vTupla)+','+  //   NOME_FANTASIA              VARCHAR(150),
        'CNPJ ='+                               DevolveConteudoDelimitado('|',vTupla)+','+  //   CNPJ                       VARCHAR(14),
        'INSCRICAO_ESTADUAL ='+                 DevolveConteudoDelimitado('|',vTupla)+','+  //   INSCRICAO_ESTADUAL         VARCHAR(30),
        'INSCRICAO_ESTADUAL_ST ='+              DevolveConteudoDelimitado('|',vTupla)+','+  //   INSCRICAO_ESTADUAL_ST      VARCHAR(30),
        'INSCRICAO_MUNICIPAL ='+                DevolveConteudoDelimitado('|',vTupla)+','+  //   INSCRICAO_MUNICIPAL        VARCHAR(30),
        'INSCRICAO_JUNTA_COMERCIAL ='+          DevolveConteudoDelimitado('|',vTupla)+','+  //   INSCRICAO_JUNTA_COMERCIAL  VARCHAR(30),
        'DATA_INSC_JUNTA_COMERCIAL ='+          DevolveConteudoDelimitado('|',vTupla)+','+  //   DATA_INSC_JUNTA_COMERCIAL  DATE,
        'MATRIZ_FILIAL ='+                      DevolveConteudoDelimitado('|',vTupla)+','+  //   MATRIZ_FILIAL              CHAR(1),
        'DATA_CADASTRO ='+                      DevolveConteudoDelimitado('|',vTupla)+','+  //   DATA_CADASTRO              DATE,
        'DATA_INICIO_ATIVIDADES ='+             DevolveConteudoDelimitado('|',vTupla)+','+  //   DATA_INICIO_ATIVIDADES     DATE,
        'SUFRAMA ='+                            DevolveConteudoDelimitado('|',vTupla)+','+  //   SUFRAMA                    VARCHAR(9),
        'EMAIL ='+                              DevolveConteudoDelimitado('|',vTupla)+','+  //   EMAIL                      VARCHAR(250),
        'IMAGEM_LOGOTIPO ='+                    DevolveConteudoDelimitado('|',vTupla)+','+  //   IMAGEM_LOGOTIPO            VARCHAR(250),
        'CRT ='+                                DevolveConteudoDelimitado('|',vTupla)+','+  //   CRT                        CHAR(1),
        'TIPO_REGIME ='+                        DevolveConteudoDelimitado('|',vTupla)+','+  //   TIPO_REGIME                CHAR(1),
        'ALIQUOTA_PIS ='+                       DevolveConteudoDelimitado('|',vTupla)+','+  //   ALIQUOTA_PIS               DECIMAL(18,6),
        'ALIQUOTA_COFINS ='+                    DevolveConteudoDelimitado('|',vTupla)+','+  //   ALIQUOTA_COFINS            DECIMAL(18,6),
        'LOGRADOURO ='+                         DevolveConteudoDelimitado('|',vTupla)+','+  //   LOGRADOURO                 VARCHAR(250),
        'NUMERO ='+                             DevolveConteudoDelimitado('|',vTupla)+','+  //   NUMERO                     VARCHAR(6),
        'COMPLEMENTO ='+                        DevolveConteudoDelimitado('|',vTupla)+','+  //   COMPLEMENTO                VARCHAR(100),
        'CEP ='+                                DevolveConteudoDelimitado('|',vTupla)+','+  //   CEP                        VARCHAR(8),
        'BAIRRO ='+                             DevolveConteudoDelimitado('|',vTupla)+','+  //   BAIRRO                     VARCHAR(100),
        'CIDADE ='+                             DevolveConteudoDelimitado('|',vTupla)+','+  //   CIDADE                     VARCHAR(100),
        'UF ='+                                 DevolveConteudoDelimitado('|',vTupla)+','+  //   UF                         CHAR(2),
        'FONE ='+                               DevolveConteudoDelimitado('|',vTupla)+','+  //   FONE                       VARCHAR(10),
        'FAX ='+                                DevolveConteudoDelimitado('|',vTupla)+','+  //   FAX                        VARCHAR(10),
        'CONTATO ='+                            DevolveConteudoDelimitado('|',vTupla)+','+  //   CONTATO                    VARCHAR(30),
        'CODIGO_IBGE_CIDADE ='+                 DevolveConteudoDelimitado('|',vTupla)+','+  //   CODIGO_IBGE_CIDADE         INTEGER,
        'CODIGO_IBGE_UF ='+                     DevolveConteudoDelimitado('|',vTupla)+')'+  //   CODIGO_IBGE_UF             INTEGER,

        ' where ID ='+IntToStr(ID);
      end;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ExecSQL();

      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

end.
