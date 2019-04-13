{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [ENDERECO]
                                                                                
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
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                            
@version 1.0                                                                    
*******************************************************************************}
unit EnderecoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('ENDERECO')]
  TEnderecoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FID_PESSOA: Integer;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCIDADE: String;
    FCEP: String;
    FMUNICIPIO_IBGE: Integer;
    FUF: String;
    FFONE: String;
    FFAX: String;
    FPRINCIPAL: String;
    FENTREGA: String;
    FCOBRANCA: String;
    FCORRESPONDENCIA: String;

  public 
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_EMPRESA','Id Empresa',[ldGrid, ldLookup],False)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('ID_PESSOA','Id Pessoa',[ldGrid, ldLookup],False)]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [TColumn('LOGRADOURO','Logradouro',[ldGrid, ldLookup],False)]
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    [TColumn('NUMERO','Número',[ldGrid, ldLookup],False)]
    property Numero: String  read FNUMERO write FNUMERO;
    [TColumn('COMPLEMENTO','Complemento',[ldGrid, ldLookup],False)]
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    [TColumn('BAIRRO','Bairro',[ldGrid, ldLookup],False)]
    property Bairro: String  read FBAIRRO write FBAIRRO;
    [TColumn('CIDADE','Cidade',[ldGrid, ldLookup],False)]
    property Cidade: String  read FCIDADE write FCIDADE;
    [TColumn('CEP','Cep',[ldGrid, ldLookup],False)]
    property Cep: String  read FCEP write FCEP;
    [TColumn('MUNICIPIO_IBGE','Município Ibge',[ldGrid, ldLookup],False)]
    property MunicipioIbge: Integer  read FMUNICIPIO_IBGE write FMUNICIPIO_IBGE;
    [TColumn('UF','Uf',[ldGrid, ldLookup],False)]
    property Uf: String  read FUF write FUF;
    [TColumn('FONE','Telefone',[ldGrid, ldLookup],False)]
    property Fone: String  read FFONE write FFONE;
    [TColumn('FAX','Fax',[ldGrid, ldLookup],False)]
    property Fax: String  read FFAX write FFAX;
    [TColumn('PRINCIPAL','Principal',[ldGrid, ldLookup],False)]
    property Principal: String  read FPRINCIPAL write FPRINCIPAL;
    [TColumn('ENTREGA','Entrega',[ldGrid, ldLookup],False)]
    property Entrega: String  read FENTREGA write FENTREGA;
    [TColumn('COBRANCA','Cobrança',[ldGrid, ldLookup],False)]
    property Cobranca: String  read FCOBRANCA write FCOBRANCA;
    [TColumn('CORRESPONDENCIA','Correspondência',[ldGrid, ldLookup],False)]
    property Correspondencia: String  read FCORRESPONDENCIA write FCORRESPONDENCIA;

  end;

implementation



end.
