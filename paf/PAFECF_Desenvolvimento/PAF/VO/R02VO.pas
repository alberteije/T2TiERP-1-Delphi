{*******************************************************************************
Title: T2Ti ERP
Description: VO da tabela do PAF: R02.

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
unit R02VO;

interface

type
  TR02VO = class
  private
    FID: Integer;
    FID_OPERADOR: Integer;
    FID_IMPRESSORA: Integer;
    FID_ECF_CAIXA: Integer;
    FSERIE_ECF: String;
    FCRZ: Integer;
    FCOO: Integer;
    FCRO: Integer;
    FDATA_MOVIMENTO: String;
    FDATA_EMISSAO: String;
    FHORA_EMISSAO: String;
    FVENDA_BRUTA: Extended;
    FGRANDE_TOTAL: Extended;
    FSINCRONIZADO: String;
    FHASH_TRIPA: String;
    FHASH_INCREMENTO: Integer;

  published

    property Id: Integer read FID write FID;
    property IdOperador: Integer read FID_OPERADOR write FID_OPERADOR;
    property IdImpressora: Integer read FID_IMPRESSORA write FID_IMPRESSORA;
    property IdCaixa: Integer read FID_ECF_CAIXA write FID_ECF_CAIXA;
    property SerieEcf: String  read FSERIE_ECF write FSERIE_ECF;
    property CRZ: Integer read FCRZ write FCRZ;
    property COO: Integer read FCOO write FCOO;
    property CRO: Integer read FCRO write FCRO;
    property DataMovimento: String read FDATA_MOVIMENTO write FDATA_MOVIMENTO;
    property DataEmissao: String read FDATA_EMISSAO write FDATA_EMISSAO;
    property HoraEmissao: String read FHORA_EMISSAO write FHORA_EMISSAO;
    property VendaBruta: Extended read FVENDA_BRUTA write FVENDA_BRUTA;
    property GrandeTotal: Extended read FGRANDE_TOTAL write FGRANDE_TOTAL;
    property Sincronizado: String read FSINCRONIZADO write FSINCRONIZADO;
    property HashTripa: String read FHASH_TRIPA write FHASH_TRIPA;
    property HashIncremento: Integer read FHASH_INCREMENTO write FHASH_INCREMENTO;

end;

implementation

end.