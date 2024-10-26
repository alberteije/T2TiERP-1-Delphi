{*******************************************************************************
Title: T2Ti ERP
Description: VO transiente que representa o registro 321 do Sped Fiscal.

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
unit SpedFiscalC321VO;

interface

type
  TSpedFiscalC321VO = class
  private
    FIdProduto: Integer;
    FSomaQuantidade: Extended;
    FDescricaoUnidade: String;
    FSomaValor: Extended;
    FSomaDesconto: Extended;
    FSomaBaseICMS: Extended;
    FSomaICMS: Extended;
    FSomaPIS: Extended;
    FSomaCOFINS: Extended;

  published

    property IdProduto: Integer read FIDProduto write FIDProduto;
    property SomaQuantidade: Extended read FSomaQuantidade write FSomaQuantidade;
    property DescricaoUnidade: String read FDescricaoUnidade write FDescricaoUnidade;
    property SomaValor: Extended read FSomaValor write FSomaValor;
    property SomaDesconto: Extended read FSomaDesconto write FSomaDesconto;
    property SomaBaseICMS: Extended read FSomaBaseICMS write FSomaBaseICMS;
    property SomaICMS: Extended read FSomaICMS write FSomaICMS;
    property SomaPIS: Extended read FSomaPIS write FSomaPIS;
    property SomaCOFINS: Extended read FSomaCOFINS write FSomaCOFINS;

end;

implementation

end.
