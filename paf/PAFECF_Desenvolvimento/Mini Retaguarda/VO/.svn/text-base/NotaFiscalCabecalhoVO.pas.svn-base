{*******************************************************************************
Title: T2Ti ERP
Description: VO relacionado à tabela [NOTA_FISCAL_CABECALHO]

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
unit NotaFiscalCabecalhoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('NOTA_FISCAL_CABECALHO')]
  TNotaFiscalCabecalhoVO = class
  private
    FID: Integer;
    FID_PEDIDO_COMPRA: Integer;
    FID_VENDA_CABECALHO: Integer;
    FTIPO_OPERACAO: String;
    FTIPO_DOCUMENTO: String;
    FSERIE: String;
    FSUBSERIE: String;
    FNUMERO: String;
    FDATA_EMISSAO: String;
    FDATA_ENTRADA_SAIDA: String;
    FVALOR_TOTAL: Extended;
    FVALOR_FRETE: Extended;
    FVALOR_SEGURO: Extended;
    FVALOR_DESCONTO_ACRESCIMO: Extended;
    FVALOR_IPI: Extended;
    FVALOR_BASE_ST: Extended;
    FVALOR_ST: Extended;
    FVALOR_OUTRAS: Extended;
    FVALOR_ISS: Extended;
    FVALOR_PRESTACAO_SERVICO: Extended;
    FISS_RETIDO: String;
    FNUMERO_ECF: Integer;
    FNUMERO_CUPOM_FISCAL: Integer;
    FCHAVE_NFE: String;
    FCFOP: Integer;
    FSITUACAO: String;
    FRECIBO_CANCELAMENTO: String;
    FDATA_CANCELAMENTO: String;
    FRECIBO_NFE: String;
    FPROTOCOLO_CANCELAMENTO: String;
    FDATA_TRANSMISSAO: String;
    FPROTOCO_NFE: String;

  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_PEDIDO_COMPRA','Pedido Compra',ldGridLookup, 10)]
    property IdPedidoCompra: Integer  read FID_PEDIDO_COMPRA write FID_PEDIDO_COMPRA;
    [TColumn('ID_VENDA_CABECALHO','Venda',ldGridLookup,10)]
    property IdVendaCabecalho: Integer  read FID_VENDA_CABECALHO write FID_VENDA_CABECALHO;
    [TColumn('TIPO_OPERACAO','Tipo Operacao',ldGrid,10)]
    property TipoOperacao: String  read FTIPO_OPERACAO write FTIPO_OPERACAO;
    [TColumn('TIPO_DOCUMENTO','Tipo Doc',ldGrid,10)]
    property TipoDocumento: String  read FTIPO_DOCUMENTO write FTIPO_DOCUMENTO;
    [TColumn('SERIE','Serie',ldGrid,10)]
    property Serie: String  read FSERIE write FSERIE;
    [TColumn('SUBSERIE','Sub-Serie',ldGrid,10)]
    property Subserie: String  read FSUBSERIE write FSUBSERIE;
    [TColumn('NUMERO','Número',ldGrid,10)]
    property Numero: String  read FNUMERO write FNUMERO;
    [TColumn('DATA_EMISSAO','Emissao',ldGridLookup,12)]
    property DataEmissao: String  read FDATA_EMISSAO write FDATA_EMISSAO;
    [TColumn('DATA_ENTRADA_SAIDA','Entrada/Saída',ldGrid,12)]
    property DataEntradaSaida: String  read FDATA_ENTRADA_SAIDA write FDATA_ENTRADA_SAIDA;
    [TColumn('VALOR_TOTAL','Valor Total',ldGridLookup,10)]
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    [TColumn('VALOR_FRETE','Frete',ldGrid,10)]
    property ValorFrete: Extended  read FVALOR_FRETE write FVALOR_FRETE;
    [TColumn('VALOR_SEGURO','Seguro',ldGrid,10)]
    property ValorSeguro: Extended  read FVALOR_SEGURO write FVALOR_SEGURO;
    [TColumn('VALOR_DESCONTO_ACRESCIMO','Desconto/Acrescimo',ldGrid,10)]
    property ValorDescontoAcrescimo: Extended  read FVALOR_DESCONTO_ACRESCIMO write FVALOR_DESCONTO_ACRESCIMO;
    [TColumn('VALOR_IPI','IPI',ldGrid,10)]
    property ValorIpi: Extended  read FVALOR_IPI write FVALOR_IPI;
    [TColumn('VALOR_BASE_ST','Valor BC ST',ldGrid,10)]
    property ValorBaseSt: Extended  read FVALOR_BASE_ST write FVALOR_BASE_ST;
    [TColumn('VALOR_ST','Valor ST',ldGrid,10)]
    property ValorSt: Extended  read FVALOR_ST write FVALOR_ST;
    [TColumn('VALOR_OUTRAS','Valor Outros',ldGrid,10)]
    property ValorOutras: Extended  read FVALOR_OUTRAS write FVALOR_OUTRAS;
    [TColumn('VALOR_ISS','Valor ISS',ldGrid,10)]
    property ValorIss: Extended  read FVALOR_ISS write FVALOR_ISS;
    [TColumn('VALOR_PRESTACAO_SERVICO','Valor Servico',ldGrid,10)]
    property ValorPrestacaoServico: Extended  read FVALOR_PRESTACAO_SERVICO write FVALOR_PRESTACAO_SERVICO;
    [TColumn('ISS_RETIDO','ISS Retido',ldGrid,10)]
    property IssRetido: String  read FISS_RETIDO write FISS_RETIDO;
    [TColumn('NUMERO_ECF', 'Numero ECF',ldGrid,10)]
    property NumeroEcf: Integer  read FNUMERO_ECF write FNUMERO_ECF;
    [TColumn('NUMERO_CUPOM_FISCAL','Cupom Fiscal',ldGridLookup,10)]
    property NumeroCupomFiscal: Integer  read FNUMERO_CUPOM_FISCAL write FNUMERO_CUPOM_FISCAL;
    [TColumn('CHAVE_NFE','Chave Acesso',ldGridLookup,10)]
    property ChaveNfe: String  read FCHAVE_NFE write FCHAVE_NFE;
    [TColumn('CFOP','CFOP',ldGrid,10)]
    property Cfop: Integer  read FCFOP write FCFOP;
    [Tcolumn('SITUACAO','Situacao',ldGridLookup,15)]
    property Situacao: String  read FSITUACAO write FSITUACAO;
    [Tcolumn('RECIBONFE','Recibo NFe',ldGridLookup,15)]
    property ReciboNFe: String  read FRECIBO_NFE write FRECIBO_NFE;
    [Tcolumn('PROTOCONFE','Recibo NFe',ldGridLookup,15)]
    property ProtocoNFe: String  read FPROTOCO_NFE write FPROTOCO_NFE;
    [Tcolumn('DATATRANSMISSAO','Data Transmissão',ldGridLookup,12)]
    property DataTransmissao: String  read FDATA_TRANSMISSAO write FDATA_TRANSMISSAO;
    [Tcolumn('RECIBOCANCELAMENTO','Recibo Cancelamento',ldGridLookup,15)]
    property ReciboCancelamento: String  read FRECIBO_CANCELAMENTO write FRECIBO_CANCELAMENTO;
    [Tcolumn('PROTOCOLOCANCELAMENTO','Protocolo Cancelamento',ldGridLookup,15)]
    property ProtocoloCancelamento: String  read FPROTOCOLO_CANCELAMENTO write FPROTOCOLO_CANCELAMENTO;
    [Tcolumn('DATACANCELAMENTO','Data Cancelamento',ldGridLookup,12)]
    property DataCancelamento: String  read FDATA_CANCELAMENTO write FDATA_CANCELAMENTO;


  end;

implementation



end.
