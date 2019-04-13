{*******************************************************************************
Title: T2Ti ERP
Description: VO transiente. Montará os dados necessários para o registro R04.

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
unit R04VO;

interface

type
  TR04VO = class
  private

    FId: Integer;
    FIdOperador: Integer;
    FCCF: Integer;
    FCOO: Integer;
    FDataEmissao: String;
    FSubTotal: Extended;
    FDesconto: Extended;
    FIndicadorDesconto: String;
    FAcrescimo: Extended;
    FIndicadorAcrescimo: String;
    FValorLiquido: Extended;
    FCancelado: String;
    FCancelamentoAcrescimo: Extended;
    FOrdemDescontoAcrescimo: String;
    FCliente: String;
    FCPFCNPJ: String;
    FHASH_TRIPA: String;

    //Utilizados pelo Sped Fiscal
    FPIS: Extended;
    FCOFINS: Extended;

  published

    property Id: Integer read FID write FID;
    property IdOperador: Integer read FIdOperador write FIdOperador;
    property CCF: Integer read FCCF write FCCF;
    property COO: Integer read FCOO write FCOO;
    property DataEmissao: String read FDataEmissao write FDataEmissao;
    property SubTotal: Extended read FSubTotal write FSubTotal;
    property Desconto: Extended read FDesconto write FDesconto;
    property IndicadorDesconto: String read FIndicadorDesconto write FIndicadorDesconto;
    property Acrescimo: Extended read FAcrescimo write FAcrescimo;
    property IndicadorAcrescimo: String read FIndicadorAcrescimo write FIndicadorAcrescimo;
    property ValorLiquido: Extended read FValorLiquido write FValorLiquido;
    property Cancelado: String read FCancelado write FCancelado;
    property CancelamentoAcrescimo: Extended read FCancelamentoAcrescimo write FCancelamentoAcrescimo;
    property OrdemDescontoAcrescimo: String read FOrdemDescontoAcrescimo write FOrdemDescontoAcrescimo;
    property Cliente: String read FCliente write FCliente;
    property CPFCNPJ: String read FCPFCNPJ write FCPFCNPJ;
    property Hash: String read FHASH_TRIPA write FHASH_TRIPA;

    //Utilizados pelo Sped Fiscal
    property PIS: Extended read FPIS write FPIS;
    property COFINS: Extended read FCOFINS write FCOFINS;

end;

implementation

end.
