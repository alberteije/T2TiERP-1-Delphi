{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [VENDA_CABECALHO]
                                                                                
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
unit VendaCabecalhoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('VENDA_CABECALHO')]
  TVendaCabecalhoVO = class
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FID_PESSOA: Integer;
    FDATA_VENDA: String;
    FDATA_SAIDA: String;
    FHORA_SAIDA: String;
    FNUMERO_FATURA: Integer;
    FNUMERO_DUPLICATA: Integer;
    FLOCAL_ENTREGA: String;
    FLOCAL_COBRANCA: String;
    FVALOR_SUB_TOTAL: Extended;
    FTAXA_COMISSAO: Extended;
    FVALOR_COMISSAO: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_TOTAL: Extended;
    FTIPO_FRETE: String;
    FFORMA_PAGAMENTO: String;
    FBASE_CALCULO_ICMS_ST: Extended;
    FVALOR_ICMS_ST: Extended;
    FVALOR_FRETE: Extended;
    FVALOR_SEGURO: Extended;
    FVALOR_IPI: Extended;
    FOBSERVACOES: Extended;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_COLABORADOR')]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('ID_PESSOA')]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [TColumn('DATA_VENDA')]
    property DataVenda: String  read FDATA_VENDA write FDATA_VENDA;
    [TColumn('DATA_SAIDA')]
    property DataSaida: String  read FDATA_SAIDA write FDATA_SAIDA;
    [TColumn('HORA_SAIDA')]
    property HoraSaida: String  read FHORA_SAIDA write FHORA_SAIDA;
    [TColumn('NUMERO_FATURA')]
    property NumeroFatura: Integer  read FNUMERO_FATURA write FNUMERO_FATURA;
    [TColumn('NUMERO_DUPLICATA')]
    property NumeroDuplicata: Integer  read FNUMERO_DUPLICATA write FNUMERO_DUPLICATA;
    [TColumn('LOCAL_ENTREGA')]
    property LocalEntrega: String  read FLOCAL_ENTREGA write FLOCAL_ENTREGA;
    [TColumn('LOCAL_COBRANCA')]
    property LocalCobranca: String  read FLOCAL_COBRANCA write FLOCAL_COBRANCA;
    [TColumn('VALOR_SUB_TOTAL')]
    property ValorSubTotal: Extended  read FVALOR_SUB_TOTAL write FVALOR_SUB_TOTAL;
    [TColumn('TAXA_COMISSAO')]
    property TaxaComissao: Extended  read FTAXA_COMISSAO write FTAXA_COMISSAO;
    [TColumn('VALOR_COMISSAO')]
    property ValorComissao: Extended  read FVALOR_COMISSAO write FVALOR_COMISSAO;
    [TColumn('TAXA_DESCONTO')]
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    [TColumn('VALOR_DESCONTO')]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('VALOR_TOTAL')]
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    [TColumn('TIPO_FRETE')]
    property TipoFrete: String  read FTIPO_FRETE write FTIPO_FRETE;
    [TColumn('FORMA_PAGAMENTO')]
    property FormaPagamento: String  read FFORMA_PAGAMENTO write FFORMA_PAGAMENTO;
    [TColumn('BASE_CALCULO_ICMS_ST')]
    property BaseCalculoIcmsSt: Extended  read FBASE_CALCULO_ICMS_ST write FBASE_CALCULO_ICMS_ST;
    [TColumn('VALOR_ICMS_ST')]
    property ValorIcmsSt: Extended  read FVALOR_ICMS_ST write FVALOR_ICMS_ST;
    [TColumn('VALOR_FRETE')]
    property ValorFrete: Extended  read FVALOR_FRETE write FVALOR_FRETE;
    [TColumn('VALOR_SEGURO')]
    property ValorSeguro: Extended  read FVALOR_SEGURO write FVALOR_SEGURO;
    [TColumn('VALOR_IPI')]
    property ValorIpi: Extended  read FVALOR_IPI write FVALOR_IPI;
    [TColumn('OBSERVACOES')]
    property Observacoes: Extended  read FOBSERVACOES write FOBSERVACOES;

  end;

implementation



end.
