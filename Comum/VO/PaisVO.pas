{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [PAIS]
                                                                                
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
unit PaisVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('PAIS')]
  TPaisVO = class(TJsonVO)
  private
    FID: Integer;
    FCODIGO: Integer;
    FNOME_EN: String;
    FNOME_PTBR: String;
    FSIGLA2: String;
    FSIGLA3: String;

  public 
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter('000',taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('CODIGO','Código',[ldGrid, ldLookup, ldComboBox],False)]
    property Codigo: Integer  read FCODIGO write FCODIGO;
    [TColumn('NOME_PTBR','Nome',[ldGrid, ldLookup, ldComboBox],False)]
    property NomePtbr: String  read FNOME_PTBR write FNOME_PTBR;
    [TColumn('NOME_EN','Nome Inglês',400,[ldGrid],False)]
    property NomeEn: String  read FNOME_EN write FNOME_EN;
    [TColumn('SIGLA2','Sigla',45,[ldGrid, ldLookup],False)]
    [TFormatter(taCenter)]
    property Sigla2: String  read FSIGLA2 write FSIGLA2;
    [TColumn('SIGLA3')]
    property Sigla3: String  read FSIGLA3 write FSIGLA3;

  end;

implementation



end.
