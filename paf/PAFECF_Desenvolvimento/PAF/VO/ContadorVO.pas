{ *******************************************************************************
  Title: T2Ti ERP
  Description: VO do contador.

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
  ******************************************************************************* }
unit ContadorVO;

interface

type
  TContadorVO = class
  private
    FID: Integer;
    ID_ECF_EMPRESA: Integer;
    FCPF: String;
    FCNPJ: String;
    FNOME: String;
    FINSCRICAO_CRC: String;
    FFONE: String;
    FFAX: String;
    FLOGRADOURO: String;
    FNUMERO: Integer;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCEP: String;
    FCODIGO_MUNICIPIO: Integer;
    FUF: String;
    FEMAIL: String;

  published

    property Id: Integer read FID write FID;
    property IdEmpresa: Integer read ID_ECF_EMPRESA write ID_ECF_EMPRESA;
    property CPF: String read FCPF write FCPF;
    property CNPJ: String read FCNPJ write FCNPJ;
    property Nome: String read FNOME write FNOME;
    property CRC: String read FINSCRICAO_CRC write FINSCRICAO_CRC;
    property Fone: String read FFONE write FFONE;
    property Fax: String read FFAX write FFAX;
    property Logradouro: String read FLOGRADOURO write FLOGRADOURO;
    property Numero: Integer read FNUMERO write FNUMERO;
    property Complemento: String read FCOMPLEMENTO write FCOMPLEMENTO;
    property Bairro: String read FBAIRRO write FBAIRRO;
    property CEP: String read FCEP write FCEP;
    property CodigoMunicipio: Integer read FCODIGO_MUNICIPIO write FCODIGO_MUNICIPIO;
    property UF: String read FUF write FUF;
    property Email: String read FEMAIL write FEMAIL;

  end;

implementation

end.
