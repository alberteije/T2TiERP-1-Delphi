{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [PESSOA_ENDERECO]
                                                                                
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
unit PessoaEnderecoVO;

interface

type
  TPessoaEnderecoVO = class
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FID_TIPO_ENDERECO: Integer;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FCEP: String;
    FBAIRRO: String;
    FCIDADE: String;
    FUF: String;
    FCODIGO_IBGE_CIDADE: Integer;
    FCODIGO_IBGE_UF: Integer;

  public
    property Id: Integer  read FID write FID;
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    property IdTipoEndereco: Integer  read FID_TIPO_ENDERECO write FID_TIPO_ENDERECO;
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    property Numero: String  read FNUMERO write FNUMERO;
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    property Cep: String  read FCEP write FCEP;
    property Bairro: String  read FBAIRRO write FBAIRRO;
    property Cidade: String  read FCIDADE write FCIDADE;
    property Uf: String  read FUF write FUF;
    property CodigoIbgeCidade: Integer  read FCODIGO_IBGE_CIDADE write FCODIGO_IBGE_CIDADE;
    property CodigoIbgeUf: Integer  read FCODIGO_IBGE_UF write FCODIGO_IBGE_UF;

  end;

implementation



end.
