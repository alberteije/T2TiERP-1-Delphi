{*******************************************************************************
Title: T2Ti ERP
Description: VO dos detalhes da NF2.

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
unit NF2DetalheVO;

interface

type
  TNF2DetalheVO = class
  private
    FID: Integer;
    FCFOP: Integer;
    FID_PRODUTO: Integer;
    FID_NF2_CABECALHO: Integer;
    FITEM: Integer;
    FQUANTIDADE: Extended;
    FVALOR_UNITARIO: Extended;
    FVALOR_TOTAL: Extended;
    FBASE_ICMS: Extended;
    FTAXA_ICMS: Extended;
    FICMS: Extended;
    FICMS_OUTRAS: Extended;
    FICMS_ISENTO: Extended;
    FTAXA_DESCONTO: Extended;
    FDESCONTO: Extended;
    FTAXA_ISSQN: Extended;
    FISSQN: Extended;
    FTAXA_PIS: Extended;
    FPIS: Extended;
    FTAXA_COFINS: Extended;
    FCOFINS: Extended;
    FTAXA_ACRESCIMO: Extended;
    FACRESCIMO: Extended;
    FTAXA_IPI: Extended;
    FIPI: Extended;
    FCANCELADO: String;
	  FMOVIMENTA_ESTOQUE: String;
    FDescricaoUnidade: String;

  published

    property Id: Integer read FID write FID;
    property CFOP: Integer read FCFOP write FCFOP;
    property IdProduto: Integer read FID_PRODUTO write FID_PRODUTO;
    property IdNF2Cabecalho: Integer read FID_NF2_CABECALHO write FID_NF2_CABECALHO;
    property Item: Integer read FITEM write FITEM;
    property Quantidade: Extended read FQUANTIDADE write FQUANTIDADE;
    property ValorUnitario: Extended read FVALOR_UNITARIO write FVALOR_UNITARIO;
    property ValorTotal: Extended read FVALOR_TOTAL write FVALOR_TOTAL;
    property BaseICMS: Extended read FBASE_ICMS write FBASE_ICMS;
    property TaxaICMS: Extended read FTAXA_ICMS write FTAXA_ICMS;
    property ICMS: Extended read FICMS write FICMS;
    property ICMSOutras: Extended read FICMS_OUTRAS write FICMS_OUTRAS;
    property ICMSIsento: Extended read FICMS_ISENTO write FICMS_ISENTO;
    property TaxaDesconto: Extended read FTAXA_DESCONTO write FTAXA_DESCONTO;
    property Desconto: Extended read FDESCONTO write FDESCONTO;
    property TaxaISSQN: Extended read FTAXA_ISSQN write FTAXA_ISSQN;
    property ISSQN: Extended read FISSQN write FISSQN;
    property TaxaPIS: Extended read FTAXA_PIS write FTAXA_PIS;
    property PIS: Extended read FPIS write FPIS;
    property TaxaCOFINS: Extended read FTAXA_COFINS write FTAXA_COFINS;
    property COFINS: Extended read FCOFINS write FCOFINS;
    property TaxaAcrescimo: Extended read FTAXA_ACRESCIMO write FTAXA_ACRESCIMO;
    property Acrescimo: Extended read FACRESCIMO write FACRESCIMO;
    property TaxaIPI: Extended read FTAXA_IPI write FTAXA_IPI;
    property IPI: Extended read FIPI write FIPI;
    property Cancelado: String read FCANCELADO write FCANCELADO;
    property MovimentaEstoque: String read FMOVIMENTA_ESTOQUE write FMOVIMENTA_ESTOQUE;	
    property DescricaoUnidade: String read FDescricaoUnidade write FDescricaoUnidade;

end;

implementation

end.