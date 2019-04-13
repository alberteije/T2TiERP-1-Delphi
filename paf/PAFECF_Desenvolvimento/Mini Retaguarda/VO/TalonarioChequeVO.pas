{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [TALONARIO_CHEQUE]
                                                                                
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
unit TalonarioChequeVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('TALONARIO_CHEQUE')]
  TTalonarioChequeVO = class
  private
    FID: Integer;
    FID_CONTA_CAIXA: Integer;
    FTALAO: String;
    FNUMERO: Integer;

    FNomeContaCaixa: String;

  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_CONTA_CAIXA')]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    [TColumn('TALAO')]
    property Talao: String  read FTALAO write FTALAO;
    [TColumn('NUMERO')]
    property Numero: Integer  read FNUMERO write FNUMERO;

    [TColumn('NOME_CONTA_CAIXA','',True,True)]
    property NomeContaCaixa: String  read FNomeContaCaixa write FNomeContaCaixa;

  end;

implementation



end.
