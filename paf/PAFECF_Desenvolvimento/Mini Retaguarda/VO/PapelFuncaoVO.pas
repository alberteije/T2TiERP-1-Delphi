{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [PAPEL_FUNCAO]
                                                                                
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
unit PapelFuncaoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('PAPEL_FUNCAO')]
  TPapelFuncaoVO = class
  private
    FID: Integer;
    FID_PAPEL: Integer;
    FPODE_CONSULTAR: String;
    FPODE_INSERIR: String;
    FPODE_ALTERAR: String;
    FPODE_EXCLUIR: String;
    FFORMULARIO: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_PAPEL')]
    property IdPapel: Integer  read FID_PAPEL write FID_PAPEL;
    [TColumn('PODE_CONSULTAR')]
    property PodeConsultar: String  read FPODE_CONSULTAR write FPODE_CONSULTAR;
    [TColumn('PODE_INSERIR')]
    property PodeInserir: String  read FPODE_INSERIR write FPODE_INSERIR;
    [TColumn('PODE_ALTERAR')]
    property PodeAlterar: String  read FPODE_ALTERAR write FPODE_ALTERAR;
    [TColumn('PODE_EXCLUIR')]
    property PodeExcluir: String  read FPODE_EXCLUIR write FPODE_EXCLUIR;
    [TColumn('FORMULARIO')]
    property Formulario: String  read FFORMULARIO write FFORMULARIO;

  end;

implementation



end.
