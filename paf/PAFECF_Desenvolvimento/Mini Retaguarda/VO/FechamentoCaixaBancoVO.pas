{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [FECHAMENTO_CAIXA_BANCO]
                                                                                
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
unit FechamentoCaixaBancoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('FECHAMENTO_CAIXA_BANCO')]
  TFechamentoCaixaBancoVO = class
  private
    FID: Integer;
    FID_CONTA_CAIXA: Integer;
    FDATA_FECHAMENTO: String;
    FMES: String;
    FANO: String;
    FSALDO_ANTERIOR: Extended;
    FRECEBIMENTOS: Extended;
    FPAGAMENTOS: Extended;
    FSALDO_CONTA: Extended;
    FCHEQUE_NAO_COMPENSADO: Extended;
    FSALDO_DISPONIVEL: Extended;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_CONTA_CAIXA')]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    [TColumn('DATA_FECHAMENTO')]
    property DataFechamento: String  read FDATA_FECHAMENTO write FDATA_FECHAMENTO;
    [TColumn('MES')]
    property Mes: String  read FMES write FMES;
    [TColumn('ANO')]
    property Ano: String  read FANO write FANO;
    [TColumn('SALDO_ANTERIOR')]
    property SaldoAnterior: Extended  read FSALDO_ANTERIOR write FSALDO_ANTERIOR;
    [TColumn('RECEBIMENTOS')]
    property Recebimentos: Extended  read FRECEBIMENTOS write FRECEBIMENTOS;
    [TColumn('PAGAMENTOS')]
    property Pagamentos: Extended  read FPAGAMENTOS write FPAGAMENTOS;
    [TColumn('SALDO_CONTA')]
    property SaldoConta: Extended  read FSALDO_CONTA write FSALDO_CONTA;
    [TColumn('CHEQUE_NAO_COMPENSADO')]
    property ChequeNaoCompensado: Extended  read FCHEQUE_NAO_COMPENSADO write FCHEQUE_NAO_COMPENSADO;
    [TColumn('SALDO_DISPONIVEL')]
    property SaldoDisponivel: Extended  read FSALDO_DISPONIVEL write FSALDO_DISPONIVEL;

  end;

implementation



end.
