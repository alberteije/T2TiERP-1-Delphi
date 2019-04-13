{*******************************************************************************
Title: T2Ti ERP
Description: VO da tabela de produtos em promoção.

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
unit ProdutoPromocaoVO;

interface

type
  TProdutoPromocaoVO = class
  private
    FID: Integer;
    FID_PRODUTO: Integer;
    FDATA_INICIO: String;
    FDATA_FIM: String;
    FQUANTIDADE_EM_PROMOCAO: Extended;
    QUANTIDADE_MAXIMA_CLIENTE: Extended;
    FVALOR: Extended;

  published

    property Id: Integer read FID write FID;
    property IdProduto: Integer read FID_PRODUTO write FID_PRODUTO;
    property DataInicio: String read FDATA_INICIO write FDATA_INICIO;
    property DataFim: String read FDATA_FIM write FDATA_FIM;
    property QuantidadeEmPromocao: Extended read FQUANTIDADE_EM_PROMOCAO write FQUANTIDADE_EM_PROMOCAO;
    property QuantidadeMaximaPorCliente: Extended read QUANTIDADE_MAXIMA_CLIENTE write QUANTIDADE_MAXIMA_CLIENTE;
    property Valor: Extended read FVALOR write FVALOR;

end;

implementation

end.
