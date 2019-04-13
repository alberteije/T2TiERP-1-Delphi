{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [VENDA_DETALHE]
                                                                                
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
unit VendaDetalheVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('VENDA_DETALHE')]
  TVendaDetalheVO = class
  private
    FID: Integer;
    FID_VENDA_CABECALHO: Integer;
    FID_PRODUTO: Integer;
    FQUANTIDADE: Extended;
    FVALOR_UNITARIO: Extended;
    FVALOR_SUBTOTAL: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_TOTAL: Extended;
    FTAXA_COMISSAO: Extended;
    FVALOR_COMISSAO: Extended;
    FCST_CSOSN: String;
    FCFOP: Integer;
    FBASE_CALCULO_ICMS_ST: Extended;
    FVALOR_ICMS_ST: Extended;
    FALIQUOTA_IPI: Extended;
    FVALOR_IPI: Extended;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_VENDA_CABECALHO')]
    property IdVendaCabecalho: Integer  read FID_VENDA_CABECALHO write FID_VENDA_CABECALHO;
    [TColumn('ID_PRODUTO')]
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
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
    [TColumn('TAXA_COMISSAO')]
    property TaxaComissao: Extended  read FTAXA_COMISSAO write FTAXA_COMISSAO;
    [TColumn('VALOR_COMISSAO')]
    property ValorComissao: Extended  read FVALOR_COMISSAO write FVALOR_COMISSAO;
    [TColumn('CST_CSOSN')]
    property CstCsosn: String  read FCST_CSOSN write FCST_CSOSN;
    [TColumn('CFOP')]
    property Cfop: Integer  read FCFOP write FCFOP;
    [TColumn('BASE_CALCULO_ICMS_ST')]
    property BaseCalculoIcmsSt: Extended  read FBASE_CALCULO_ICMS_ST write FBASE_CALCULO_ICMS_ST;
    [TColumn('VALOR_ICMS_ST')]
    property ValorIcmsSt: Extended  read FVALOR_ICMS_ST write FVALOR_ICMS_ST;
    [TColumn('ALIQUOTA_IPI')]
    property AliquotaIpi: Extended  read FALIQUOTA_IPI write FALIQUOTA_IPI;
    [TColumn('VALOR_IPI')]
    property ValorIpi: Extended  read FVALOR_IPI write FVALOR_IPI;

  end;

implementation



end.
