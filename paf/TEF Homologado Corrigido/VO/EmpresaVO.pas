{*******************************************************************************
Title: T2Ti ERP
Description: VO da empresa.

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
unit EmpresaVO;

interface

type
  TEmpresaVO = class
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FRAZAO_SOCIAL: String;
    FNOME_FANTASIA: String;
    FCNPJ: String;
    FINSCRICAO_ESTADUAL: String;
    FINSCRICAO_MUNICIPAL: String;
    FMATRIZ_FILIAL: String;
    FDATA_CADASTRO: String;
    FENDERECO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCIDADE: String;
    FCODIGO_MUNICIPIO_IBGE: Integer;
    FCEP: String;
    FFONE1: String;
    FFONE2: String;
    FCONTATO: String;
    FUF: String;
    FSUFRAMA: String;
    FEMAIL: String;

  published

    property Id: Integer read FID write FID;
    property IdEmpresa: Integer read FID_EMPRESA write FID_EMPRESA;
    property RazaoSocial: String read FRAZAO_SOCIAL write FRAZAO_SOCIAL;
    property NomeFantasia: String read FNOME_FANTASIA write FNOME_FANTASIA;
    property CNPJ: String read FCNPJ write FCNPJ;
    property InscricaoEstadual: String read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;
    property InscricaoMunicipal: String read FINSCRICAO_MUNICIPAL write FINSCRICAO_MUNICIPAL;
    property MatrizOuFilial: String read FMATRIZ_FILIAL write FMATRIZ_FILIAL;
    property DataCadastro: String read FDATA_CADASTRO write FDATA_CADASTRO;
    property Endereco: String read FENDERECO write FENDERECO;
    property Numero: String read FNUMERO write FNUMERO;
    property Complemento: String read FCOMPLEMENTO write FCOMPLEMENTO;
    property Bairro: String read FBAIRRO write FBAIRRO;
    property Cidade: String read FCIDADE write FCIDADE;
    property CodigoMunicipioIBGE: Integer read FCODIGO_MUNICIPIO_IBGE write FCODIGO_MUNICIPIO_IBGE;
    property CEP: String read FCEP write FCEP;
    property Fone1: String read FFONE1 write FFONE1;
    property Fone2: String read FFONE2 write FFONE2;
    property Contato: String read FCONTATO write FCONTATO;
    property UF: String read FUF write FUF;
    property Suframa: String read FSUFRAMA write FSUFRAMA;
    property Email: String read FEMAIL write FEMAIL;

  end;

implementation

end.
