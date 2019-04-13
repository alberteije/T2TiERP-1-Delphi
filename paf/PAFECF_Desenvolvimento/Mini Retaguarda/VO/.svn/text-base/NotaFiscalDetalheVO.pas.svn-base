{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [NOTA_FISCAL_DETALHE]
                                                                                
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
unit NotaFiscalDetalheVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('NOTA_FISCAL_DETALHE')]
  TNotaFiscalDetalheVO = class
  private
    FID: Integer;
    FID_NOTA_FISCAL_CABECALHO: Integer;
    FID_PRODUTO: Integer;
    FCFOP: Integer;
    FCST_A: String;
    FCST_B: String;
    FQUANTIDADE: Extended;
    FVALOR_TOTAL_ITEM: Extended;
    FVALOR_ICMS: Extended;
    FALIQUOTA_ICMS: Extended;
    FVALOR_BC_ICMS: Extended;
    FVALOR_BC_ICMS_ST: Extended;
    FVALOR_ICMS_ST: Extended;
    FMVA_ALIQUOTA: Extended;
    FVALOR_PAUTA: Extended;
    FMVA_AJUSTADA: Extended;
    FALIQUOTA_IPI: Extended;
    FVALOR_IPI_ITEM: Extended;
    FVALOR_FRETE_ITEM: Extended;
    FVALOR_SEGURO_ITEM: Extended;
    FVALOR_DESCONTO_ITEM: Extended;
    FCST_PIS: String;
    FCST_COFINS: String;
    FCST_IPI: String;
    FBASE_PIS: Extended;
    FBASE_COFINS: Extended;
    FVALOR_OUTRAS_ITEM: Extended;
    FMOVIMENTA_ESTOQUE: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_NOTA_FISCAL_CABECALHO')]
    property IdNotaFiscalCabecalho: Integer  read FID_NOTA_FISCAL_CABECALHO write FID_NOTA_FISCAL_CABECALHO;
    [TColumn('ID_PRODUTO','Codigo',ldGridLookup,5)]
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    [TColumn('CFOP','CFOP',ldGrid,5)]
    property Cfop: Integer  read FCFOP write FCFOP;
    [TColumn('CST_A','',ldNone,1)]
    property CstA: String  read FCST_A write FCST_A;
    [TColumn('CST_B','',ldNone,3)]
    property CstB: String  read FCST_B write FCST_B;
    [TColumn('QUANTIDADE','Qtd',ldGridLookup,10)]
    property Quantidade: Extended  read FQUANTIDADE write FQUANTIDADE;
    [TColumn('VALOR_TOTAL_ITEM','Total Item',ldGridLookup,10)]
    property ValorTotalItem: Extended  read FVALOR_TOTAL_ITEM write FVALOR_TOTAL_ITEM;
    [TColumn('VALOR_ICMS','VL.ICMS',ldGrid,10)]
    property ValorIcms: Extended  read FVALOR_ICMS write FVALOR_ICMS;
    [TColumn('ALIQUOTA_ICMS','Aliq.ICMS',ldGrid,10)]
    property AliquotaIcms: Extended  read FALIQUOTA_ICMS write FALIQUOTA_ICMS;
    [TColumn('VALOR_BC_ICMS','Base Cálculo',ldGrid,10)]
    property ValorBcIcms: Extended  read FVALOR_BC_ICMS write FVALOR_BC_ICMS;
    [TColumn('VALOR_BC_ICMS_ST','BC Subst.',ldGrid,10)]
    property ValorBcIcmsSt: Extended  read FVALOR_BC_ICMS_ST write FVALOR_BC_ICMS_ST;
    [TColumn('VALOR_ICMS_ST')]
    property ValorIcmsSt: Extended  read FVALOR_ICMS_ST write FVALOR_ICMS_ST;
    [TColumn('MVA_ALIQUOTA')]
    property MvaAliquota: Extended  read FMVA_ALIQUOTA write FMVA_ALIQUOTA;
    [TColumn('VALOR_PAUTA')]
    property ValorPauta: Extended  read FVALOR_PAUTA write FVALOR_PAUTA;
    [TColumn('MVA_AJUSTADA')]
    property MvaAjustada: Extended  read FMVA_AJUSTADA write FMVA_AJUSTADA;
    [TColumn('ALIQUOTA_IPI','Aliq. IPI',ldGrid,10)]
    property AliquotaIpi: Extended  read FALIQUOTA_IPI write FALIQUOTA_IPI;
    [TColumn('VALOR_IPI_ITEM','IPI',ldGrid,10)]
    property ValorIpiItem: Extended  read FVALOR_IPI_ITEM write FVALOR_IPI_ITEM;
    [TColumn('VALOR_FRETE_ITEM')]
    property ValorFreteItem: Extended  read FVALOR_FRETE_ITEM write FVALOR_FRETE_ITEM;
    [TColumn('VALOR_SEGURO_ITEM')]
    property ValorSeguroItem: Extended  read FVALOR_SEGURO_ITEM write FVALOR_SEGURO_ITEM;
    [TColumn('VALOR_DESCONTO_ITEM')]
    property ValorDescontoItem: Extended  read FVALOR_DESCONTO_ITEM write FVALOR_DESCONTO_ITEM;
    [TColumn('CST_PIS')]
    property CstPis: String  read FCST_PIS write FCST_PIS;
    [TColumn('CST_COFINS')]
    property CstCofins: String  read FCST_COFINS write FCST_COFINS;
    [TColumn('CST_IPI')]
    property CstIpi: String  read FCST_IPI write FCST_IPI;
    [TColumn('BASE_PIS')]
    property BasePis: Extended  read FBASE_PIS write FBASE_PIS;
    [TColumn('BASE_COFINS')]
    property BaseCofins: Extended  read FBASE_COFINS write FBASE_COFINS;
    [TColumn('VALOR_OUTRAS_ITEM')]
    property ValorOutrasItem: Extended  read FVALOR_OUTRAS_ITEM write FVALOR_OUTRAS_ITEM;
    [TColumn('MOVIMENTA_ESTOQUE')]
    property MovimentaEstoque: String  read FMOVIMENTA_ESTOQUE write FMOVIMENTA_ESTOQUE;

  end;

implementation



end.
