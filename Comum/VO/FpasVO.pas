{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FPAS] 
                                                                                
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
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit FpasVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('FPAS')]
  TFpasVO = class(TJsonVO)
  private
    FID: Integer;
    FCODIGO: Integer;
    FCNAE: String;
    FALIQUOTA_SAT: Integer;
    FDESCRICAO: String;
    FPERCENTUAL_INSS_PATRONAL: Extended;
    FCODIGO_TERCEIRO: Integer;
    FPERCENTUAL_TERCEIROS: Extended;

  public 
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer  read FID write FID;
    [TColumn('CODIGO','Código',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Codigo: Integer  read FCODIGO write FCODIGO;
    [TColumn('CNAE','Cnae',112,[ldGrid, ldLookup, ldCombobox], False)]
    property Cnae: String  read FCNAE write FCNAE;
    [TColumn('ALIQUOTA_SAT','Alíquota Sat',80,[ldGrid, ldLookup, ldCombobox], False)]
    property AliquotaSat: Integer  read FALIQUOTA_SAT write FALIQUOTA_SAT;
    [TColumn('DESCRICAO','Descrição',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('PERCENTUAL_INSS_PATRONAL','Percentual Inss Patronal',128,[ldGrid, ldLookup, ldCombobox], False)]
    property PercentualInssPatronal: Extended  read FPERCENTUAL_INSS_PATRONAL write FPERCENTUAL_INSS_PATRONAL;
    [TColumn('CODIGO_TERCEIRO','Código Terceiro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoTerceiro: Integer  read FCODIGO_TERCEIRO write FCODIGO_TERCEIRO;
    [TColumn('PERCENTUAL_TERCEIROS','Percentual Terceiros',128,[ldGrid, ldLookup, ldCombobox], False)]
    property PercentualTerceiros: Extended  read FPERCENTUAL_TERCEIROS write FPERCENTUAL_TERCEIROS;

  end;

implementation



end.
