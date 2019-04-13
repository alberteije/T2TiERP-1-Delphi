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
  Classes, SQLExpr, SysUtils, PessoaVO, PessoaEnderecoVO;

type
  TClienteController = class
  private

  protected
  public
    class function ConsultaCPFCNPJ(CPFouCNPJ:String): TPessoaVO;
    class function ConsultaPeloID(pId: Integer): TPessoaVO;

  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TClienteController.ConsultaCPFCNPJ(CPFouCNPJ:String): TPessoaVO;
var
  Cliente : TPessoaVO;
begin
  ConsultaSQL := 'select ID, NOME, CPF_CNPJ from PESSOA where CPF_CNPJ='+QuotedStr(CPFouCNPJ);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Cliente := TPessoaVO.Create;
      Cliente.Id := Query.FieldByName('ID').AsInteger;
      Cliente.Nome := Query.FieldByName('NOME').AsString;
      Cliente.CpfCnpj := Query.FieldByName('CPF_CNPJ').AsString;

      result := Cliente;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TClienteController.ConsultaPeloID(pId: Integer): TPessoaVO;
var
  Cliente: TPessoaVO;
begin
  ConsultaSQL := 'select ' +
                 'P.ID, ' +
                 'P.ID_SITUACAO_PESSOA, ' +
                 'P.NOME, ' +
                 'P.FANTASIA, ' +
                 'P.EMAIL, ' +
                 'P.CLIENTE, ' +
                 'P.FORNECEDOR, ' +
                 'P.COLABORADOR, ' +
                 'P.TIPO, ' +
                 'P.CPF_CNPJ, ' +
                 'P.INSCRICAO_ESTADUAL, ' +
                 'P.INSCRICAO_MUNICIPAL, ' +
                 'P.CONTATO, ' +
                 'P.FONE1, ' +
                 'P.FONE2, ' +
                 'P.CELULAR, ' +
                 'P.RG, ' +
                 'P.ORGAO_RG, ' +
                 'P.DATA_EMISSAO_RG, ' +
                 'P.SEXO, ' +
                 'P.DATA_CADASTRO, ' +
                 'E.LOGRADOURO, ' +
                 'E.NUMERO, ' +
                 'E.COMPLEMENTO, ' +
                 'E.CEP, ' +
                 'E.BAIRRO, ' +
                 'E.CIDADE, ' +
                 'E.UF, ' +
                 'E.CODIGO_IBGE_CIDADE, ' +
                 'E.CODIGO_IBGE_UF ' +
                 'FROM PESSOA P left JOIN PESSOA_ENDERECO E ON E.ID_PESSOA = P.ID ' +
                 'where P.ID='+IntToStr(pId);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Cliente := TPessoaVO.Create;
      Cliente.PessoaEndereco := TPessoaEnderecoVO.Create;

      Cliente.Id := Query.FieldByName('ID').AsInteger;
      Cliente.IdSituacaoPessoa := Query.FieldByName('ID_SITUACAO_PESSOA').AsInteger;
      Cliente.Nome := Query.FieldByName('NOME').AsString;
      Cliente.Fantasia := Query.FieldByName('FANTASIA').AsString;
      Cliente.Email := Query.FieldByName('EMAIL').AsString;
      Cliente.Cliente := Query.FieldByName('CLIENTE').AsString;
      Cliente.Fornecedor := Query.FieldByName('FORNECEDOR').AsString;
      Cliente.Colaborador := Query.FieldByName('COLABORADOR').AsString;
      Cliente.Tipo := Query.FieldByName('TIPO').AsString;
      Cliente.CpfCnpj := Query.FieldByName('CPF_CNPJ').AsString;
      Cliente.InscricaoEstadual := Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
      Cliente.InscricaoMunicipal := Query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      Cliente.Contato := Query.FieldByName('CONTATO').AsString;
      Cliente.Fone1 := Query.FieldByName('FONE1').AsString;
      Cliente.Fone2 := Query.FieldByName('FONE2').AsString;
      Cliente.Celular := Query.FieldByName('CELULAR').AsString;
      Cliente.Rg := Query.FieldByName('RG').AsString;
      Cliente.OrgaoRg := Query.FieldByName('ORGAO_RG').AsString;
      Cliente.DataEmissaoRg := Query.FieldByName('DATA_EMISSAO_RG').AsString;
      Cliente.Sexo := Query.FieldByName('SEXO').AsString;
      Cliente.DataCadastro := Query.FieldByName('DATA_CADASTRO').AsString;

      Cliente.PessoaEndereco.Logradouro := Query.FieldByName('LOGRADOURO').AsString;
      Cliente.PessoaEndereco.Numero := Query.FieldByName('NUMERO').AsString;
      Cliente.PessoaEndereco.Complemento := Query.FieldByName('COMPLEMENTO').AsString;
      Cliente.PessoaEndereco.Cep := Query.FieldByName('CEP').AsString;
      Cliente.PessoaEndereco.Bairro := Query.FieldByName('BAIRRO').AsString;
      Cliente.PessoaEndereco.Cidade := Query.FieldByName('CIDADE').AsString;
      Cliente.PessoaEndereco.Uf := Query.FieldByName('UF').AsString;
      Cliente.PessoaEndereco.CodigoIbgeCidade := Query.FieldByName('CODIGO_IBGE_CIDADE').AsInteger;
      Cliente.PessoaEndereco.CodigoIbgeUf := Query.FieldByName('CODIGO_IBGE_UF').AsInteger;

      result := Cliente;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
