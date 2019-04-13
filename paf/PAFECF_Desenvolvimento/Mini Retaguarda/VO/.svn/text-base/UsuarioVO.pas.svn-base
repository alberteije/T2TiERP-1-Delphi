{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [USUARIO]
                                                                                
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
unit UsuarioVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('USUARIO')]
  TUsuarioVO = class
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FID_PAPEL: Integer;
    FLOGIN: String;
    FSENHA: String;
    FDATA_CADASTRO: String;
    FNome: string;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_COLABORADOR')]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('ID_PAPEL')]
    property IdPapel: Integer  read FID_PAPEL write FID_PAPEL;
    [TColumn('NOME','Nome',ldGridLookup,True)]
    property Nome: string read FNome write FNome;
    [TColumn('LOGIN','Login',ldGridLookup,False)]
    property Login: String  read FLOGIN write FLOGIN;
    [TColumn('SENHA')]
    property Senha: String  read FSENHA write FSENHA;
    [TColumn('DATA_CADASTRO','Data do Cadastro',ldGrid,False)]
    property DataCadastro: String  read FDATA_CADASTRO write FDATA_CADASTRO;

  end;

implementation



end.
