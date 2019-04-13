{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [PEDIDO_COMPRA_DETALHE]
                                                                                
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
unit PedidoCompraDetalheVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('PEDIDO_COMPRA_DETALHE')]
  TPedidoCompraDetalheVO = class
  private
    FID: Integer;
    FID_PRODUTO: Integer;
    FID_PEDIDO_COMPRA: Integer;
    FQUANTIDADE: Extended;
    FVALOR_UNITARIO: Extended;
    FVALOR_SUBTOTAL: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_TOTAL: Extended;
    FCFOP: Integer;
    FBASE_CALCULO_ICMS: Extended;
    FVALOR_ICMS: Extended;
    FVALOR_IPI: Extended;
    FALIQUOTA_ICMS: Extended;
    FALIQUOTA_IPI: Extended;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_PRODUTO')]
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    [TColumn('ID_PEDIDO_COMPRA')]
    property IdPedidoCompra: Integer  read FID_PEDIDO_COMPRA write FID_PEDIDO_COMPRA;
    [TColumn('QUANTIDADE')]
    property Quantidade: Extended  read FQUANTIDADE write FQUANTIDADE;
    [TColumn('VALOR_UNITARIO')]
    property ValorUnitario: Extended  read FVALOR_UNITARIO write FVALOR_UNITARIO;
    [TColumn('VALOR_SUBTOTAL')]
    property ValorSubtotal: Extended  read FVALOR_SUBTOTAL write FVALOR_SUBTOTAL;
    [TColumn('TAXA_DESCONTO')]
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    [TColumn('VALOR_DESCONTO')]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('VALOR_TOTAL')]
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    [TColumn('CFOP')]
    property Cfop: Integer  read FCFOP write FCFOP;
    [TColumn('BASE_CALCULO_ICMS')]
    property BaseCalculoIcms: Extended  read FBASE_CALCULO_ICMS write FBASE_CALCULO_ICMS;
    [TColumn('VALOR_ICMS')]
    property ValorIcms: Extended  read FVALOR_ICMS write FVALOR_ICMS;
    [TColumn('VALOR_IPI')]
    property ValorIpi: Extended  read FVALOR_IPI write FVALOR_IPI;
    [TColumn('ALIQUOTA_ICMS')]
    property AliquotaIcms: Extended  read FALIQUOTA_ICMS write FALIQUOTA_ICMS;
    [TColumn('ALIQUOTA_IPI')]
    property AliquotaIpi: Extended  read FALIQUOTA_IPI write FALIQUOTA_IPI;

  end;

implementation



end.
