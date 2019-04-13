{*******************************************************************************
Title: T2Ti ERP
Description:  VO  relacionado à tabela [Empresa]

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

@author  ()
@version 1.0
*******************************************************************************}
unit EmpresaVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('EMPRESA')]
  TEmpresaVO = class
  private
    FID: Integer;
    FRAZAO_SOCIAL: String;
    FNOME_FANTASIA: String;
    FCNPJ: String;
    FINSCRICAO_ESTADUAL: String;
    FINSCRICAO_ESTADUAL_ST: String;
    FINSCRICAO_MUNICIPAL: String;
    FINSCRICAO_JUNTA_COMERCIAL: String;
    FDATA_INSC_JUNTA_COMERCIAL: String;
    FDATA_CADASTRO: String;
    FDATA_INICIO_ATIVIDADES: String;
    FSUFRAMA: String;
    FEMAIL: String;
    FIMAGEM_LOGOTIPO: String;
    FCRT: String;
    FTIPO_REGIME: String;
    FALIQUOTA_PIS: Double;
    FALIQUOTA_COFINS: Double;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FCEP: String;
    FBAIRRO: String;
    FCIDADE: String;
    FUF: String;
    FFONE: String;
    FFAX: String;
    FCONTATO: String;
    FCODIGO_IBGE_CIDADE: Integer;
    FCODIGO_IBGE_UF: Integer;

  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('RAZAO_SOCIAL','Razao Social',ldGridLookup ,150)]
    property RazaoSocial: String  read FRAZAO_SOCIAL write FRAZAO_SOCIAL;
    [TColumn('NOME_FANTASIA','Nome Fantasia',ldGridLookup ,150)]
    property NomeFantasia: String  read FNOME_FANTASIA write FNOME_FANTASIA;
    [TColumn('CNPJ','Cnpj',ldGridLookup ,14)]
    property Cnpj: String  read FCNPJ write FCNPJ;
    [TColumn('INSCRICAO_ESTADUAL','Inscricao Estadual',ldGridLookup ,30)]
    property InscricaoEstadual: String  read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;
    [TColumn('INSCRICAO_ESTADUAL_ST','Inscricao Estadual St',ldGridLookup ,30)]
    property InscricaoEstadualSt: String  read FINSCRICAO_ESTADUAL_ST write FINSCRICAO_ESTADUAL_ST;
    [TColumn('INSCRICAO_MUNICIPAL','Inscricao Municipal',ldGridLookup ,30)]
    property InscricaoMunicipal: String  read FINSCRICAO_MUNICIPAL write FINSCRICAO_MUNICIPAL;
    [TColumn('INSCRICAO_JUNTA_COMERCIAL','Inscricao Junta Comercial',ldGridLookup ,30)]
    property InscricaoJuntaComercial: String  read FINSCRICAO_JUNTA_COMERCIAL write FINSCRICAO_JUNTA_COMERCIAL;
    [TColumn('DATA_INSC_JUNTA_COMERCIAL','Data Insc Junta Comercial',ldGridLookup ,10)]
    property DataInscJuntaComercial: String  read FDATA_INSC_JUNTA_COMERCIAL write FDATA_INSC_JUNTA_COMERCIAL;
    [TColumn('DATA_CADASTRO','Data Cadastro',ldGridLookup ,10)]
    property DataCadastro: String  read FDATA_CADASTRO write FDATA_CADASTRO;
    [TColumn('DATA_INICIO_ATIVIDADES','Data Inicio Atividades',ldGridLookup ,10)]
    property DataInicioAtividades: String  read FDATA_INICIO_ATIVIDADES write FDATA_INICIO_ATIVIDADES;
    [TColumn('SUFRAMA','Suframa',ldGridLookup ,9)]
    property Suframa: String  read FSUFRAMA write FSUFRAMA;
    [TColumn('EMAIL','Email',ldGridLookup ,250)]
    property Email: String  read FEMAIL write FEMAIL;
    [TColumn('IMAGEM_LOGOTIPO','Imagem Logotipo',ldGridLookup ,1)]
    property ImagemLogotipo: String  read FIMAGEM_LOGOTIPO write FIMAGEM_LOGOTIPO;
    [TColumn('CRT','Crt',ldGridLookup ,1)]
    property Crt: String  read FCRT write FCRT;
    [TColumn('TIPO_REGIME','Tipo Regime',ldGridLookup ,1)]
    property TipoRegime: String  read FTIPO_REGIME write FTIPO_REGIME;
    [TColumn('ALIQUOTA_PIS','Aliquota Pis',ldGridLookup ,6)]
    property AliquotaPis: Double  read FALIQUOTA_PIS write FALIQUOTA_PIS;
    [TColumn('ALIQUOTA_COFINS','Aliquota Cofins',ldGridLookup ,6)]
    property AliquotaCofins: Double  read FALIQUOTA_COFINS write FALIQUOTA_COFINS;
    [TColumn('LOGRADOURO','Logradouro',ldGridLookup ,250)]
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    [TColumn('NUMERO','Numero',ldGridLookup ,6)]
    property Numero: String  read FNUMERO write FNUMERO;
    [TColumn('COMPLEMENTO','Complemento',ldGridLookup ,100)]
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    [TColumn('CEP','Cep',ldGridLookup ,8)]
    property Cep: String  read FCEP write FCEP;
    [TColumn('BAIRRO','Bairro',ldGridLookup ,100)]
    property Bairro: String  read FBAIRRO write FBAIRRO;
    [TColumn('CIDADE','Cidade',ldGridLookup ,100)]
    property Cidade: String  read FCIDADE write FCIDADE;
    [TColumn('UF','Uf',ldGridLookup ,2)]
    property Uf: String  read FUF write FUF;
    [TColumn('FONE','Fone',ldGridLookup ,10)]
    property Fone: String  read FFONE write FFONE;
    [TColumn('FAX','Fax',ldGridLookup ,10)]
    property Fax: String  read FFAX write FFAX;
    [TColumn('CONTATO','Contato',ldGridLookup ,50)]
    property Contato: String  read FCONTATO write FCONTATO;
    [TColumn('CODIGO_IBGE_CIDADE','Codigo Ibge Cidade',ldGridLookup ,8)]
    property CodigoIbgeCidade: Integer  read FCODIGO_IBGE_CIDADE write FCODIGO_IBGE_CIDADE;
    [TColumn('CODIGO_IBGE_UF','Codigo Ibge Uf',ldGridLookup ,8)]
    property CodigoIbgeUf: Integer  read FCODIGO_IBGE_UF write FCODIGO_IBGE_UF;

  end;

implementation



end.

