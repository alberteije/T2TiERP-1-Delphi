{*******************************************************************************
Title: T2Ti ERP
Description: VO da tabela do PAF: R07.

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
unit R07VO;

interface

type
  TR07VO = class
  private
    FID: Integer;
    FID_R06: Integer;
    FCCF: Integer;
    FMEIO_PAGAMENTO: String;
    FVALOR_PAGAMENTO: Extended;
    FESTORNO: String;
    FVALOR_ESTORNO: Extended;

  published

    property Id: Integer read FID write FID;
    property IdR06: Integer read FID_R06 write FID_R06;
    property CCF: Integer read FCCF write FCCF;
    property MeioPagamento: String read FMEIO_PAGAMENTO write FMEIO_PAGAMENTO;
    property ValorPagamento: Extended read FVALOR_PAGAMENTO write FVALOR_PAGAMENTO;
    property IndicadorEstorno: String read FESTORNO write FESTORNO;
    property ValorEstorno: Extended read FVALOR_ESTORNO write FVALOR_ESTORNO;

end;

implementation

end.