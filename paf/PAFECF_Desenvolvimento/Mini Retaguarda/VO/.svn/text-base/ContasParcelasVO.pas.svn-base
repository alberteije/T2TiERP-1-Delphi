{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [CONTAS_PARCELAS]
                                                                                
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
unit ContasParcelasVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('CONTAS_PARCELAS')]
  TContasParcelasVO = class
  private
    FID: Integer;
    FID_CHEQUE_EMITIDO: Integer;
    FID_CONTA_CAIXA: Integer;
    FID_MEIOS_PAGAMENTO: Integer;
    FID_CONTAS_PAGAR_RECEBER: Integer;
    FDATA_EMISSAO: String;
    FDATA_VENCIMENTO: String;
    FDATA_PAGAMENTO: String;
    FNUMERO_PARCELA: Integer;
    FVALOR: Extended;
    FTAXA_JUROS: Extended;
    FTAXA_MULTA: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_JUROS: Extended;
    FVALOR_MULTA: Extended;
    FVALOR_DESCONTO: Extended;
    FTOTAL_PARCELA: Extended;
    FHISTORICO: String;
    FSITUACAO: String;
    FIDENTIFICA: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_CHEQUE_EMITIDO')]
    property IdChequeEmitido: Integer  read FID_CHEQUE_EMITIDO write FID_CHEQUE_EMITIDO;
    [TColumn('ID_CONTA_CAIXA')]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    [TColumn('ID_MEIOS_PAGAMENTO')]
    property IdMeiosPagamento: Integer  read FID_MEIOS_PAGAMENTO write FID_MEIOS_PAGAMENTO;
    [TColumn('ID_CONTAS_PAGAR_RECEBER')]
    property IdContasPagarReceber: Integer  read FID_CONTAS_PAGAR_RECEBER write FID_CONTAS_PAGAR_RECEBER;
    [TColumn('DATA_EMISSAO')]
    property DataEmissao: String  read FDATA_EMISSAO write FDATA_EMISSAO;
    [TColumn('DATA_VENCIMENTO')]
    property DataVencimento: String  read FDATA_VENCIMENTO write FDATA_VENCIMENTO;
    [TColumn('DATA_PAGAMENTO')]
    property DataPagamento: String  read FDATA_PAGAMENTO write FDATA_PAGAMENTO;
    [TColumn('NUMERO_PARCELA')]
    property NumeroParcela: Integer  read FNUMERO_PARCELA write FNUMERO_PARCELA;
    [TColumn('VALOR')]
    property Valor: Extended  read FVALOR write FVALOR;
    [TColumn('TAXA_JUROS')]
    property TaxaJuros: Extended  read FTAXA_JUROS write FTAXA_JUROS;
    [TColumn('TAXA_MULTA')]
    property TaxaMulta: Extended  read FTAXA_MULTA write FTAXA_MULTA;
    [TColumn('TAXA_DESCONTO')]
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    [TColumn('VALOR_JUROS')]
    property ValorJuros: Extended  read FVALOR_JUROS write FVALOR_JUROS;
    [TColumn('VALOR_MULTA')]
    property ValorMulta: Extended  read FVALOR_MULTA write FVALOR_MULTA;
    [TColumn('VALOR_DESCONTO')]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('TOTAL_PARCELA')]
    property TotalParcela: Extended  read FTOTAL_PARCELA write FTOTAL_PARCELA;
    [TColumn('HISTORICO')]
    property Historico: String  read FHISTORICO write FHISTORICO;
    [TColumn('SITUACAO')]
    property Situacao: String  read FSITUACAO write FSITUACAO;
    [TColumn('IDENTIFICA')]
    property Identifica: String  read FIDENTIFICA write FIDENTIFICA;


  end;

implementation



end.
