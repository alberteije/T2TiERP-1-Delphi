{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [NFE_CUPOM_FISCAL]
                                                                                
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
unit NfeCupomFiscalVO;

interface

type
  TNfeCupomFiscalVO = class
  private
    FID: Integer;
    FID_NFE_CABECALHO: Integer;
    FMODELO_DOCUMENTO_FISCAL: String;
    FDATA_EMISSAO_CUPOM: String;
    FNUMERO_ORDEM_ECF: Integer;
    FCOO: Integer;
    FNUMERO_CAIXA: Integer;
    FNUMERO_SERIE_ECF: String;

  public
    property Id: Integer  read FID write FID;
    property IdNfeCabecalho: Integer  read FID_NFE_CABECALHO write FID_NFE_CABECALHO;
    property ModeloDocumentoFiscal: String  read FMODELO_DOCUMENTO_FISCAL write FMODELO_DOCUMENTO_FISCAL;
    property DataEmissaoCupom: String  read FDATA_EMISSAO_CUPOM write FDATA_EMISSAO_CUPOM;
    property NumeroOrdemEcf: Integer  read FNUMERO_ORDEM_ECF write FNUMERO_ORDEM_ECF;
    property Coo: Integer  read FCOO write FCOO;
    property NumeroCaixa: Integer  read FNUMERO_CAIXA write FNUMERO_CAIXA;
    property NumeroSerieEcf: String  read FNUMERO_SERIE_ECF write FNUMERO_SERIE_ECF;

  end;

implementation



end.
