{*******************************************************************************
Title: T2Ti ERP
Description: VO relacionado à tabela [R01]

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
unit R01VO;

interface

type
  TR01VO = class
  private
    FID: Integer;
    FSERIE_ECF: String;
    FCNPJ_EMPRESA: String;
    FCNPJ_SH: String;
    FINSCRICAO_ESTADUAL_SH: String;
    FINSCRICAO_MUNICIPAL_SH: String;
    FDENOMINACAO_SH: String;
    FNOME_PAF_ECF: String;
    FVERSAO_PAF_ECF: String;
    FMD5_PAF_ECF: String;
    FDATA_INICIAL: String;
    FDATA_FINAL: String;
    FVERSAO_ER: String;
    FNUMERO_LAUDO_PAF: String;
    FRAZAO_SOCIAL_SH: String;
    FENDERECO_SH: String;
    FNUMERO_SH: String;
    FCOMPLEMENTO_SH: String;
    FBAIRRO_SH: String;
    FCIDADE_SH: String;
    FCEP_SH: String;
    FUF_SH: String;
    FTELEFONE_SH: String;
    FCONTATO_SH: String;
    FPRINCIPAL_EXECUTAVEL: String;
    FHASH_TRIPA: String;
    FHASH_INCREMENTO: Integer;

  public
    property Id: Integer  read FID write FID;
    property SerieEcf: String  read FSERIE_ECF write FSERIE_ECF;
    property CnpjEmpresa: String  read FCNPJ_EMPRESA write FCNPJ_EMPRESA;
    property CnpjSh: String  read FCNPJ_SH write FCNPJ_SH;
    property InscricaoEstadualSh: String  read FINSCRICAO_ESTADUAL_SH write FINSCRICAO_ESTADUAL_SH;
    property InscricaoMunicipalSh: String  read FINSCRICAO_MUNICIPAL_SH write FINSCRICAO_MUNICIPAL_SH;
    property DenominacaoSh: String  read FDENOMINACAO_SH write FDENOMINACAO_SH;
    property NomePafEcf: String  read FNOME_PAF_ECF write FNOME_PAF_ECF;
    property VersaoPafEcf: String  read FVERSAO_PAF_ECF write FVERSAO_PAF_ECF;
    property Md5PafEcf: String  read FMD5_PAF_ECF write FMD5_PAF_ECF;
    property DataInicial: String  read FDATA_INICIAL write FDATA_INICIAL;
    property DataFinal: String  read FDATA_FINAL write FDATA_FINAL;
    property VersaoEr: String  read FVERSAO_ER write FVERSAO_ER;
    property NumeroLaudoPaf: String  read FNUMERO_LAUDO_PAF write FNUMERO_LAUDO_PAF;
    property RazaoSocialSh: String  read FRAZAO_SOCIAL_SH write FRAZAO_SOCIAL_SH;
    property EnderecoSh: String  read FENDERECO_SH write FENDERECO_SH;
    property NumeroSh: String  read FNUMERO_SH write FNUMERO_SH;
    property ComplementoSh: String  read FCOMPLEMENTO_SH write FCOMPLEMENTO_SH;
    property BairroSh: String  read FBAIRRO_SH write FBAIRRO_SH;
    property CidadeSh: String  read FCIDADE_SH write FCIDADE_SH;
    property CepSh: String  read FCEP_SH write FCEP_SH;
    property UfSh: String  read FUF_SH write FUF_SH;
    property TelefoneSh: String  read FTELEFONE_SH write FTELEFONE_SH;
    property ContatoSh: String  read FCONTATO_SH write FCONTATO_SH;
    property PrincipalExecutavel: String  read FPRINCIPAL_EXECUTAVEL write FPRINCIPAL_EXECUTAVEL;
    property HashTripa: String read FHASH_TRIPA write FHASH_TRIPA;
    property HashIncremento: Integer read FHASH_INCREMENTO write FHASH_INCREMENTO;

  end;

implementation

end.

