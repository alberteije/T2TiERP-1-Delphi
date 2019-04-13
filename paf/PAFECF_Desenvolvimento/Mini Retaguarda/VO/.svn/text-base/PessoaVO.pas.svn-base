{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [PESSOA]
                                                                                
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
unit PessoaVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('PESSOA')]
  TPessoaVO = class
  private
    FID: Integer;
    FID_SITUACAO_PESSOA: Integer;
    FNOME: String;
    FFANTASIA: String;
    FEMAIL: String;
    FCLIENTE: String;
    FFORNECEDOR: String;
    FCOLABORADOR: String;
    FTIPO: String;
    FFISICA_JURIDICA: String;
    FCPF_CNPJ: String;
    FINSCRICAO_ESTADUAL: String;
    FINSCRICAO_MUNICIPAL: String;
    FCONTATO: String;
    FFONE1: String;
    FFONE2: String;
    FCELULAR: String;
    FRG: String;
    FORGAO_RG: String;
    FDATA_EMISSAO_RG: String;
    FSEXO: String;
    FDATA_CADASTRO: String;

    //FSituacaoPessoa: String;


  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID; //ID                   INTEGER NOT NULL,
    [TColumn('ID_SITUACAO_PESSOA')]
    property IdSituacaoPessoa: Integer  read FID_SITUACAO_PESSOA write FID_SITUACAO_PESSOA; //ID_SITUACAO_PESSOA   INTEGER NOT NULL,
    [TColumn('NOME','Nome',True,False)]
    property Nome: String  read FNOME write FNOME; //NOME                 VARCHAR(150),
    [TColumn('FANTASIA')]
    property Fantasia: String  read FFANTASIA write FFANTASIA; //FANTASIA             VARCHAR(150),
    [TColumn('EMAIL')]
    property Email: String  read FEMAIL write FEMAIL; //EMAIL                VARCHAR(250),
    [TColumn('CLIENTE','Cliente',ldGrid,1)]
    property CLIENTE: String  read FCLIENTE write FCLIENTE; //CLIENTE              CHAR(1),
    [TColumn('FORNECEDOR','Fornecedor',ldGrid,1)]
    property FORNECDOR: String  read FFORNECEDOR write FFORNECEDOR; //FORNECEDOR           CHAR(1),
    [TColumn('COLABORADOR','Colaborador',ldGrid,1)]
    property COLABORADOR: String  read FCOLABORADOR write FCOLABORADOR; //COLABORADOR          CHAR(1),
    [TColumn('TIPO','Tipo',True,False)]
    property Tipo: String  read FTIPO write FTIPO; // TIPO                 CHAR(1),
    //[TColumn('FISICA_JURIDICA','Física / Jurídica',True,False)]
    //property FisicaJuridica: String  read FFISICA_JURIDICA write FFISICA_JURIDICA;
    [TColumn('CPF_CNPJ','CFP / CNPJ',True,False)]
    property CpfCnpj: String  read FCPF_CNPJ write FCPF_CNPJ; //CPF_CNPJ             VARCHAR(14),
    [TColumn('INSCRICAO_ESTADUAL')]
    property InscricaoEstadual: String  read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL; //INSCRICAO_ESTADUAL   VARCHAR(30),
    [TColumn('INSCRICAO_MUNICIPAL')]
    property InscricaoMunicipal: String  read FINSCRICAO_MUNICIPAL write FINSCRICAO_MUNICIPAL; // INSCRICAO_MUNICIPAL  VARCHAR(30),
    [TColumn('CONTATO')]
    property Contato: String  read FCONTATO write FCONTATO; //CONTATO              VARCHAR(50),
    [TColumn('FONE1')]
    property Fone1: String  read FFONE1 write FFONE1; //FONE1                VARCHAR(10),
    [TColumn('FONE2')]
    property Fone2: String  read FFONE2 write FFONE2; //FONE2                VARCHAR(10),
    [TColumn('CELULAR')]
    property Celular: String  read FCELULAR write FCELULAR; //CELULAR              VARCHAR(10),
    [TColumn('RG')]
    property Rg: String  read FRG write FRG; //RG                   VARCHAR(20),
    [TColumn('ORGAO_RG')]
    property OrgaoRg: String  read FORGAO_RG write FORGAO_RG; //ORGAO_RG             VARCHAR(20),
    [TColumn('DATA_EMISSAO_RG')]
    property DataEmissaoRg: String  read FDATA_EMISSAO_RG write FDATA_EMISSAO_RG; //DATA_EMISSAO_RG      DATE,
    [TColumn('SEXO')]
    property Sexo: String  read FSEXO write FSEXO; //SEXO                 CHAR(1),
    [TColumn('DATA_CADASTRO')]
    property DataCadastro: String  read FDATA_CADASTRO write FDATA_CADASTRO; //DATA_CADASTRO        DATE

    //[TColumn('NOME_SITUACAO_PESSOA','Situação Pessoa',True,True)]
    //property SituacaoPessoa: String  read FSituacaoPessoa write FSituacaoPessoa;

  end;

implementation



end.
