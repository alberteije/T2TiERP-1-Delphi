{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [NCM]
                                                                                
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
unit NcmVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('NCM')]
  TNcmVO = class
  private
    FID: Integer;
    FNCM: String;
    FDESCRICAO: String;
    FALIQUOTA_PIS: Extended;
    FCST_PIS: String;
    FALIQUOTA_COFINS: Extended;
    FCST_COFINS: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer read FID write FID;
    [TColumn('NCM', 'NCM', ldGridLookup, 8)]
    property Ncm: String read FNCM write FNCM;
    [TColumn('DESCRICAO', 'Descrição',ldGridLookup, 50)]
    property Descricao: String read FDESCRICAO write FDESCRICAO;
    [TColumn('ALIQUOTA_PIS','Alicota PIS',ldGrid,8)]
    property AliquotaPis: Extended read FALIQUOTA_PIS write FALIQUOTA_PIS;
    [TColumn('CST_PIS','CST PIS',ldGrid,8)]
    property CstPis: String read FCST_PIS write FCST_PIS;
    [TColumn('ALIQUOTA_COFINS','Alicota Cofins',ldGrid,8)]
    property AliquotaCofins: Extended read FALIQUOTA_COFINS write FALIQUOTA_COFINS;
    [TColumn('CST_COFINS','CST COFINS',ldGrid,8)]
    property CstCofins: String read FCST_COFINS write FCST_COFINS;

  end;

implementation



end.
