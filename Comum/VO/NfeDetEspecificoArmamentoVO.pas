{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [NFE_DET_ESPECIFICO_ARMAMENTO] 
                                                                                
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
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit NfeDetEspecificoArmamentoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('NFE_DET_ESPECIFICO_ARMAMENTO')]
  TNfeDetEspecificoArmamentoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_NFE_DETALHE: Integer;
    FTIPO_ARMA: String;
    FNUMERO_SERIE_ARMA: String;
    FNUMERO_SERIE_CANO: String;
    FDESCRICAO: String;

  public 
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_NFE_DETALHE','Id Nfe Detalhe',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdNfeDetalhe: Integer  read FID_NFE_DETALHE write FID_NFE_DETALHE;
    [TColumn('TIPO_ARMA','Tipo Arma',8,[ldGrid, ldLookup, ldCombobox], False)]
    property TipoArma: String  read FTIPO_ARMA write FTIPO_ARMA;
    [TColumn('NUMERO_SERIE_ARMA','Numero Serie Arma',72,[ldGrid, ldLookup, ldCombobox], False)]
    property NumeroSerieArma: String  read FNUMERO_SERIE_ARMA write FNUMERO_SERIE_ARMA;
    [TColumn('NUMERO_SERIE_CANO','Numero Serie Cano',72,[ldGrid, ldLookup, ldCombobox], False)]
    property NumeroSerieCano: String  read FNUMERO_SERIE_CANO write FNUMERO_SERIE_CANO;
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;

  end;

implementation



end.
