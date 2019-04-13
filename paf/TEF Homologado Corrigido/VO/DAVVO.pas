{*******************************************************************************
Title: T2Ti ERP
Description: VO do DAV;

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
unit DAVVO;

interface

type
  TDAVVO = class
  private
    FID: Integer;
    FCCF: Integer;
    FCOO: Integer;
    FNOME_DESTINATARIO: String;
    FCPF_CNPJ_DESTINATARIO: String;
    FDATA_EMISSAO: String;
    FHORA_EMISSAO: String;
    FSITUACAO: String;
    FVALOR: Extended;
    FHASH_TRIPA: String;

  published

    property Id: Integer read FID write FID;
    property CCF: Integer read FCCF write FCCF;
    property COO: Integer read FCOO write FCOO;
    property NomeDestinatario: String read FNOME_DESTINATARIO write FNOME_DESTINATARIO;
    property CpfCnpjDestinatario: String read FCPF_CNPJ_DESTINATARIO write FCPF_CNPJ_DESTINATARIO;
    property DataEmissao: String read FDATA_EMISSAO write FDATA_EMISSAO;
    property HoraEmissao: String read FHORA_EMISSAO write FHORA_EMISSAO;
    property Situacao: String read FSITUACAO write FSITUACAO;
    property Valor: Extended read FVALOR write FVALOR;
    property Hash: String read FHASH_TRIPA write FHASH_TRIPA;
end;

implementation

end.