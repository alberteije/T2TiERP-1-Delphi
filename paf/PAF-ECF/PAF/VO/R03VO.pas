{*******************************************************************************
Title: T2Ti ERP
Description: VO da tabela do PAF: R03.

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
unit R03VO;

interface

type
  TR03VO = class
  private
    FID: Integer;
    FID_R02: Integer;
    FSERIE_ECF: String;
    FTOTALIZADOR_PARCIAL: String;
    FVALOR_ACUMULADO: Extended;
    FCRZ: Integer;
    FSINCRONIZADO: String;
    FHASH_TRIPA: String;
    FHASH_INCREMENTO: Integer;

  published

    property Id: Integer read FID write FID;
    property IdR02: Integer read FID_R02 write FID_R02;
    property SerieEcf: String  read FSERIE_ECF write FSERIE_ECF;
    property TotalizadorParcial: String read FTOTALIZADOR_PARCIAL write FTOTALIZADOR_PARCIAL;
    property ValorAcumulado: Extended read FVALOR_ACUMULADO write FVALOR_ACUMULADO;
    property CRZ: Integer read FCRZ write FCRZ;
    property Sincronizado: String read FSINCRONIZADO write FSINCRONIZADO;
    property HashTripa: String read FHASH_TRIPA write FHASH_TRIPA;
    property HashIncremento: Integer read FHASH_INCREMENTO write FHASH_INCREMENTO;

end;

implementation

end.