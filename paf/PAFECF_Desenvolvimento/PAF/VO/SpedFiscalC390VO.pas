{*******************************************************************************
Title: T2Ti ERP
Description: VO transiente que representa o registro 390 do Sped Fiscal.

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
unit SpedFiscalC390VO;

interface

type
  TSpedFiscalC390VO = class
  private
    FCST: String;
    FCFOP: Integer;
    FTaxaICMS: Extended;
    FSomaValor: Extended;
    FSomaBaseICMS: Extended;
    FSomaICMS: Extended;
    FSomaICMSOutras: Extended;

  published

    property CST: String read FCST write FCST;
    property CFOP: Integer read FCFOP write FCFOP;
    property TaxaICMS: Extended read FTaxaICMS write FTaxaICMS;
    property SomaValor: Extended read FSomaValor write FSomaValor;
    property SomaBaseICMS: Extended read FSomaBaseICMS write FSomaBaseICMS;
    property SomaICMS: Extended read FSomaICMS write FSomaICMS;
    property SomaICMSOutras: Extended read FSomaICMSOutras write FSomaICMSOutras;

end;

implementation

end.
