{*******************************************************************************
Title: T2Ti ERP
Description: VO do total de tipos de pagamento.

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
unit TotalTipoPagamentoVO;

interface

type
  TTotalTipoPagamentoVO = class
  private
    FID: Integer;
    FID_ECF_VENDA_CABECALHO: Integer;
    FID_ECF_TIPO_PAGAMENTO: Integer;
    FVALOR: Extended;
    FNSU: String;
    FESTORNO: String;
    FCodigoPagamento: String;
    FTef: String;
    FVinculado: String;
    FDescricao: String;
    FREDE: String;
    FCARTAO_DC: String;
    FDataHoraTransacao: String;
    FFinalizacao: String;

  published

    property Id: Integer read FID write FID;
    property IdVenda: Integer read FID_ECF_VENDA_CABECALHO write FID_ECF_VENDA_CABECALHO;
    property IdTipoPagamento: Integer read FID_ECF_TIPO_PAGAMENTO write FID_ECF_TIPO_PAGAMENTO;
    property Valor: Extended read FVALOR write FVALOR;
    property NSU: String read FNSU write FNSU;
    property Estorno: String read FESTORNO write FESTORNO;
    property CodigoPagamento: String read FCodigoPagamento write FCodigoPagamento;
    property TemTEF: String read FTef write FTef;
    property ImprimeVinculado: String read FVinculado write FVinculado;
    property Descricao: String read FDescricao write FDescricao;
    property Rede: String read FREDE write FREDE;
    property CartaoDebitoOuCredito: String read FCARTAO_DC write FCARTAO_DC;
    property DataHoraTransacao: String read FDataHoraTransacao write FDataHoraTransacao;
    property Finalizacao: String read FFinalizacao write FFinalizacao;

end;

implementation

end.
