{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [SEFIP_CODIGO_RECOLHIMENTO] 
                                                                                
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
                                                                                
@author Fernando Lúcio Oliveira (fsystem.br@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit SefipCodigoRecolhimentoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('SEFIP_CODIGO_RECOLHIMENTO')]
  TSefipCodigoRecolhimentoVO = class(TJsonVO)
  private
    FID: Integer;
    FCODIGO: Integer;
    FDESCRICAO: String;
    FAPLICACAO: String;

  public 
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter('0000', taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('CODIGO','Código',80,[ldGrid, ldLookup, ldComboBox], False)]
    property Codigo: Integer  read FCODIGO write FCODIGO;
    [TColumn('DESCRICAO','Descrição',800,[ldGrid, ldLookup, ldComboBox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('APLICACAO','Aplicação',400,[ldGrid, ldLookup], False)]
    property Aplicacao: String  read FAPLICACAO write FAPLICACAO;

  end;

implementation



end.
