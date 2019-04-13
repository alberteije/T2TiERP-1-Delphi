{*******************************************************************************
Title: T2Ti ERP
Description: VO transiente. Montará os dados necessários para o registro R05.

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
unit R05VO;

interface

type
  TR05VO = class
  private

    FID: Integer;
    FCOO: Integer;
    FCCF: Integer;
    FSERIE_ECF: String;
    FItem: Integer;
    FGTIN: String;
    FDescricaoPDV: String;
    FQuantidade: Extended;
    FSiglaUnidade: String;
    FValorUnitario: Extended;
    FDesconto: Extended;
    FAcrescimo: Extended;
    FTotalItem: Extended;
    FTotalizadorParcial: String;
    FIndicadorCancelamento: String;
    FQuantidadeCancelada: Extended;
    FValorCancelado: Extended;
    FCancelamentoAcrescimo: Extended;
    FIAT: String;
    FIPPT: String;
    FCasasDecimaisQuantidade: Integer;
    FCasasDecimaisValor: Integer;
    FHASH_TRIPA: String;
    FHASH_INCREMENTO: Integer;
    
    //Utilizados pelo Sped Fiscal
   	FIdProduto: Integer;
    FIdUnidade : Integer;
    FCST: String;
    FCFOP: Integer;
    FAliquotaICMS: Extended;
    FPIS: Extended;
    FCOFINS: Extended;

  published

    property Id: Integer read FID write FID;
    property COO: Integer read FCOO write FCOO;
    property CCF: Integer read FCCF write FCCF;
    property Item: Integer read FItem write FItem;
    property SerieEcf: String  read FSERIE_ECF write FSERIE_ECF;
    property GTIN: String read FGTIN write FGTIN;
    property DescricaoPDV: String read FDescricaoPDV write FDescricaoPDV;
    property Quantidade: Extended read FQuantidade write FQuantidade;
    property SiglaUnidade: String read FSiglaUnidade write FSiglaUnidade;
    property ValorUnitario: Extended read FValorUnitario write FValorUnitario;
    property Desconto: Extended read FDesconto write FDesconto;
    property Acrescimo: Extended read FAcrescimo write FAcrescimo;
    property TotalItem: Extended read FTotalItem write FTotalItem;
    property TotalizadorParcial: String read FTotalizadorParcial write FTotalizadorParcial;
    property IndicadorCancelamento: String read FIndicadorCancelamento write FIndicadorCancelamento;
    property QuantidadeCancelada: Extended read FQuantidadeCancelada write FQuantidadeCancelada;
    property ValorCancelado: Extended read FValorCancelado write FValorCancelado;
    property CancelamentoAcrescimo: Extended read FCancelamentoAcrescimo write FCancelamentoAcrescimo;
    property IAT: String read FIAT write FIAT;
    property IPPT: String read FIPPT write FIPPT;
    property CasasDecimaisQuantidade: Integer read FCasasDecimaisQuantidade write FCasasDecimaisQuantidade;
    property CasasDecimaisValor: Integer read FCasasDecimaisValor write FCasasDecimaisValor;
    property HashTripa: String read FHASH_TRIPA write FHASH_TRIPA;
    property HashIncremento: Integer read FHASH_INCREMENTO write FHASH_INCREMENTO;


    //Utilizados pelo Sped Fiscal
    property IdProduto: Integer read FIdProduto write FIdProduto;
    property IdUnidade: Integer read FIdUnidade write FIdUnidade;
    property CST: String read FCST write FCST;
    property CFOP: Integer read FCFOP write FCFOP;
    property AliquotaICMS: Extended read FAliquotaICMS write FAliquotaICMS;
    property PIS: Extended read FPIS write FPIS;
    property COFINS: Extended read FCOFINS write FCOFINS;

end;

implementation

end.
