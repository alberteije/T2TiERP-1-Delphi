{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [VIEW_SPED_I155] 
                                                                                
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
unit ViewSpedI155VO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('VIEW_SPED_I155')]
  TViewSpedI155VO = class(TJsonVO)
  private
    FMES_ANO: String;
    FID_CONTABIL_CONTA: Integer;
    FCLASSIFICACAO: String;
    FTIPO: String;
    FSOMA_VALOR: Extended;

  public 
    [TColumn('MES_ANO','Mes Ano',56,[ldGrid, ldLookup, ldCombobox], False)]
    property MesAno: String  read FMES_ANO write FMES_ANO;
    [TColumn('ID_CONTABIL_CONTA','Id Contabil Conta',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;
    [TColumn('CLASSIFICACAO','Classificacao',240,[ldGrid, ldLookup, ldCombobox], False)]
    property Classificacao: String  read FCLASSIFICACAO write FCLASSIFICACAO;
    [TColumn('TIPO','Tipo',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Tipo: String  read FTIPO write FTIPO;
    [TColumn('SOMA_VALOR','Soma Valor',264,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property SomaValor: Extended  read FSOMA_VALOR write FSOMA_VALOR;

  end;

implementation



end.
