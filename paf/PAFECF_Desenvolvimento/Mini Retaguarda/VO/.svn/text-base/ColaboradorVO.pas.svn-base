{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [COLABORADOR]
                                                                                
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
unit ColaboradorVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('COLABORADOR')]
  TColaboradorVO = class
  private
    FID: Integer;
    FID_CARGO: Integer;
    FID_DEPARTAMENTO: Integer;
    FID_PESSOA: Integer;
    FFOTO_34: Extended;
    FOBSERVACOES: Extended;
    FDATA_CADASTRO: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_CARGO')]
    property IdCargo: Integer  read FID_CARGO write FID_CARGO;
    [TColumn('ID_DEPARTAMENTO')]
    property IdDepartamento: Integer  read FID_DEPARTAMENTO write FID_DEPARTAMENTO;
    [TColumn('ID_PESSOA')]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [TColumn('FOTO_34')]
    property Foto34: Extended  read FFOTO_34 write FFOTO_34;
    [TColumn('OBSERVACOES')]
    property Observacoes: Extended  read FOBSERVACOES write FOBSERVACOES;
    [TColumn('DATA_CADASTRO')]
    property DataCadastro: String  read FDATA_CADASTRO write FDATA_CADASTRO;

  end;

implementation



end.
