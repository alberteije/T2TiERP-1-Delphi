{*******************************************************************************
Title: T2Ti ERP
Description: VO da tabela do Sintegra: SINTEGRA_60A.

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
unit Sintegra60AVO;

interface

type
  TSintegra60AVO = class
  private
    FID: Integer;
    FID_SINTEGRA_60M: Integer;
    FSITUACAO_TRIBUTARIA: String;
    FVALOR: Extended;

  published

    property Id: Integer read FID write FID;
    property Id60M: Integer read FID_SINTEGRA_60M write FID_SINTEGRA_60M;
    property SituacaoTributaria: String read FSITUACAO_TRIBUTARIA write FSITUACAO_TRIBUTARIA;
    property Valor: Extended read FVALOR write FVALOR;

end;

implementation

end.
