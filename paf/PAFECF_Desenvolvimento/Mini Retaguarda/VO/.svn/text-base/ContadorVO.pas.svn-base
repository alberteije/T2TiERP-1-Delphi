{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [CONTADOR]
                                                                                
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
unit ContadorVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('CONTADOR')]
  TContadorVO = class
  private
    FID: Integer;
    FCPF: String;
    FCNPJ: String;
    FNOME: String;
    FINSCRICAO_CRC: String;
    FFONE: String;
    FFAX: String;
    FLOGRADOURO: String;
    FNUMERO: Integer;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCEP: String;
    FCODIGO_MUNICIPIO: Integer;
    FUF: String;
    FEMAIL: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('CPF')]
    property Cpf: String  read FCPF write FCPF;
    [TColumn('CNPJ')]
    property Cnpj: String  read FCNPJ write FCNPJ;
    [TColumn('NOME')]
    property Nome: String  read FNOME write FNOME;
    [TColumn('INSCRICAO_CRC')]
    property InscricaoCrc: String  read FINSCRICAO_CRC write FINSCRICAO_CRC;
    [TColumn('FONE')]
    property Fone: String  read FFONE write FFONE;
    [TColumn('FAX')]
    property Fax: String  read FFAX write FFAX;
    [TColumn('LOGRADOURO')]
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    [TColumn('NUMERO')]
    property Numero: Integer  read FNUMERO write FNUMERO;
    [TColumn('COMPLEMENTO')]
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    [TColumn('BAIRRO')]
    property Bairro: String  read FBAIRRO write FBAIRRO;
    [TColumn('CEP')]
    property Cep: String  read FCEP write FCEP;
    [TColumn('CODIGO_MUNICIPIO')]
    property CodigoMunicipio: Integer  read FCODIGO_MUNICIPIO write FCODIGO_MUNICIPIO;
    [TColumn('UF')]
    property Uf: String  read FUF write FUF;
    [TColumn('EMAIL')]
    property Email: String  read FEMAIL write FEMAIL;

  end;

implementation



end.
