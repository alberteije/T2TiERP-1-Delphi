{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [PEDIDO_COMPRA]
                                                                                
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
unit PedidoCompraVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('PEDIDO_COMPRA')]
  TPedidoCompraVO = class
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FID_PESSOA: Integer;
    FDATA_PEDIDO: String;
    FDATA_PREVISTA_ENTREGA: String;
    FDATA_PREVISAO_PAGAMENTO: String;
    FLOCAL_ENTREGA: String;
    FLOCAL_COBRANCA: String;
    FCONTATO: String;
    FVALOR_SUBTOTAL: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_TOTAL_PEDIDO: Extended;
    FTIPO_FRETE: String;
    FFORMA_PAGAMENTO: String;
    FBASE_CALCULO_ICMS: Extended;
    FVALOR_ICMS: Extended;
    FBASE_CALCULO_ICMS_ST: Extended;
    FVALOR_ICMS_ST: Extended;
    FVALOR_TOTAL_PRODUTOS: Extended;
    FVALOR_FRETE: Extended;
    FVALOR_SEGURO: Extended;
    FVALOR_OUTRAS_DESPESAS: Extended;
    FVALOR_IPI: Extended;
    FVALOR_TOTAL_NF: Extended;

    FFornecedor: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_COLABORADOR')]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('ID_PESSOA')]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [TColumn('DATA_PEDIDO')]
    property DataPedido: String  read FDATA_PEDIDO write FDATA_PEDIDO;
    [TColumn('DATA_PREVISTA_ENTREGA')]
    property DataPrevistaEntrega: String  read FDATA_PREVISTA_ENTREGA write FDATA_PREVISTA_ENTREGA;
    [TColumn('DATA_PREVISAO_PAGAMENTO')]
    property DataPrevisaoPagamento: String  read FDATA_PREVISAO_PAGAMENTO write FDATA_PREVISAO_PAGAMENTO;
    [TColumn('LOCAL_ENTREGA')]
    property LocalEntrega: String  read FLOCAL_ENTREGA write FLOCAL_ENTREGA;
    [TColumn('LOCAL_COBRANCA')]
    property LocalCobranca: String  read FLOCAL_COBRANCA write FLOCAL_COBRANCA;
    [TColumn('CONTATO')]
    property Contato: String  read FCONTATO write FCONTATO;
    [TColumn('VALOR_SUBTOTAL')]
    property ValorSubtotal: Extended  read FVALOR_SUBTOTAL write FVALOR_SUBTOTAL;
    [TColumn('TAXA_DESCONTO')]
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    [TColumn('VALOR_DESCONTO')]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('VALOR_TOTAL_PEDIDO')]
    property ValorTotalPedido: Extended  read FVALOR_TOTAL_PEDIDO write FVALOR_TOTAL_PEDIDO;
    [TColumn('TIPO_FRETE')]
    property TipoFrete: String  read FTIPO_FRETE write FTIPO_FRETE;
    [TColumn('FORMA_PAGAMENTO')]
    property FormaPagamento: String  read FFORMA_PAGAMENTO write FFORMA_PAGAMENTO;
    [TColumn('BASE_CALCULO_ICMS')]
    property BaseCalculoIcms: Extended  read FBASE_CALCULO_ICMS write FBASE_CALCULO_ICMS;
    [TColumn('VALOR_ICMS')]
    property ValorIcms: Extended  read FVALOR_ICMS write FVALOR_ICMS;
    [TColumn('BASE_CALCULO_ICMS_ST')]
    property BaseCalculoIcmsSt: Extended  read FBASE_CALCULO_ICMS_ST write FBASE_CALCULO_ICMS_ST;
    [TColumn('VALOR_ICMS_ST')]
    property ValorIcmsSt: Extended  read FVALOR_ICMS_ST write FVALOR_ICMS_ST;
    [TColumn('VALOR_TOTAL_PRODUTOS')]
    property ValorTotalProdutos: Extended  read FVALOR_TOTAL_PRODUTOS write FVALOR_TOTAL_PRODUTOS;
    [TColumn('VALOR_FRETE')]
    property ValorFrete: Extended  read FVALOR_FRETE write FVALOR_FRETE;
    [TColumn('VALOR_SEGURO')]
    property ValorSeguro: Extended  read FVALOR_SEGURO write FVALOR_SEGURO;
    [TColumn('VALOR_OUTRAS_DESPESAS')]
    property ValorOutrasDespesas: Extended  read FVALOR_OUTRAS_DESPESAS write FVALOR_OUTRAS_DESPESAS;
    [TColumn('VALOR_IPI')]
    property ValorIpi: Extended  read FVALOR_IPI write FVALOR_IPI;
    [TColumn('VALOR_TOTAL_NF')]
    property ValorTotalNf: Extended  read FVALOR_TOTAL_NF write FVALOR_TOTAL_NF;

    [TColumn('FORNECEDOR','',False,True)]
    property Fornecedor: String  read FFornecedor write FFornecedor;

  end;

implementation



end.
