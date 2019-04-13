{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [AGENCIA]
                                                                                
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
unit AgenciaVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('AGENCIA')]
  TAgenciaVO = class
  private
    FID: Integer;
    FID_BANCO: Integer;
    FCODIGO: String;
    FNOME: String;
    FENDERECO: String;
    FNUMERO: Integer;
    FCEP: String;
    FBAIRRO: String;
    FCIDADE: String;
    FUF: String;
    FGERENTE: String;
    FTELEFONE1: String;
    FTELEFONE2: String;
    FOBSERVACAO: String;
    FNomeBanco: String;

  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_BANCO','ID Banco',False,False)]
    property IdBanco: Integer  read FID_BANCO write FID_BANCO;

    [TColumn('CODIGO','Código',True,False)]
    property Codigo: String  read FCODIGO write FCODIGO;
    [TColumn('NOME','Nome',True,False)]
    property Nome: String  read FNOME write FNOME;

    [TColumn('NOME_BANCO','Nome Banco',True,True)]
    property NomeBanco: String  read FNomeBanco write FNomeBanco;

    [TColumn('ENDERECO','Endereço',True,False)]
    property Endereco: String  read FENDERECO write FENDERECO;
    [TColumn('NUMERO','Número',True,False)]
    property Numero: Integer  read FNUMERO write FNUMERO;
    [TColumn('CEP','CEP',True,False)]
    property Cep: String  read FCEP write FCEP;
    [TColumn('BAIRRO','Bairro',True,False)]
    property Bairro: String  read FBAIRRO write FBAIRRO;
    [TColumn('CIDADE','Cidade',True,False)]
    property Cidade: String  read FCIDADE write FCIDADE;
    [TColumn('UF','UF',True,False)]
    property Uf: String  read FUF write FUF;
    [TColumn('GERENTE','Gerente',True,False)]
    property Gerente: String  read FGERENTE write FGERENTE;
    [TColumn('TELEFONE1','Fone 02',True,False)]
    property Telefone1: String  read FTELEFONE1 write FTELEFONE1;
    [TColumn('TELEFONE2','Fone 03',True,False)]
    property Telefone2: String  read FTELEFONE2 write FTELEFONE2;
    [TColumn('OBSERVACAO','Observações',True,False)]
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;
  end;

implementation



end.
