{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [CHEQUE_EMITIDO]
                                                                                
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
unit ChequeEmitidoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('CHEQUE_EMITIDO')]
  TChequeEmitidoVO = class
  private
    FID: Integer;
    FID_CHEQUE: Integer;
    FDATA_EMISSAO: String;
    FDATA_COMPENSACAO: String;
    FVALOR: Extended;
    FNOMINAL_A: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_CHEQUE')]
    property IdCheque: Integer  read FID_CHEQUE write FID_CHEQUE;
    [TColumn('DATA_EMISSAO')]
    property DataEmissao: String  read FDATA_EMISSAO write FDATA_EMISSAO;
    [TColumn('DATA_COMPENSACAO')]
    property DataCompensacao: String  read FDATA_COMPENSACAO write FDATA_COMPENSACAO;
    [TColumn('VALOR')]
    property Valor: Extended  read FVALOR write FVALOR;
    [TColumn('NOMINAL_A')]
    property NominalA: String  read FNOMINAL_A write FNOMINAL_A;

  end;

implementation



end.
