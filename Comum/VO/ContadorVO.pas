{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTADOR] 
                                                                                
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
unit ContadorVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  PessoaVO;

type
  [TEntity]
  [TTable('CONTADOR')]
  TContadorVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FINSCRICAO_CRC: String;
    FFONE: String;
    FFAX: String;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCEP: String;
    FMUNICIPIO_IBGE: Integer;
    FUF: String;
    FEMAIL: String;
    FUF_CRC: String;

    FPessoaNome: String;
    FPessoaVO: TPessoaVO;

    public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_PESSOA','Id Pessoa',80,[ldGrid, ldLookup, ldCombobox], False)]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [TColumn('PESSOA.NOME','Nome',350,[ldGrid, ldLookup], True,'PESSOA','ID_PESSOA','ID')]
    property PessoaNome: String  read FPessoaNome write FPessoaNome;

    [TColumn('INSCRICAO_CRC','Inscrição Crc',120,[ldGrid, ldLookup, ldCombobox], False)]
    property InscricaoCrc: String  read FINSCRICAO_CRC write FINSCRICAO_CRC;
    [TColumn('FONE','Telefone',112,[ldGrid, ldLookup, ldCombobox], False)]
    property Fone: String  read FFONE write FFONE;
    [TColumn('FAX','Fax',112,[ldGrid, ldLookup, ldCombobox], False)]
    property Fax: String  read FFAX write FFAX;
    [TColumn('LOGRADOURO','Logradouro',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    [TColumn('NUMERO','Número',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Numero: String  read FNUMERO write FNUMERO;
    [TColumn('COMPLEMENTO','Complemento',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    [TColumn('BAIRRO','Bairro',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Bairro: String  read FBAIRRO write FBAIRRO;
    [TColumn('CEP','Cep',64,[ldGrid, ldLookup, ldCombobox], False)]
    property Cep: String  read FCEP write FCEP;
    [TColumn('MUNICIPIO_IBGE','Município Ibge',80,[ldGrid, ldLookup, ldCombobox], False)]
    property MunicipioIbge: Integer  read FMUNICIPIO_IBGE write FMUNICIPIO_IBGE;
    [TColumn('UF','Uf',16,[ldGrid, ldLookup, ldCombobox], False)]
    property Uf: String  read FUF write FUF;
    [TColumn('EMAIL','E-mail',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Email: String  read FEMAIL write FEMAIL;
    [TColumn('UF_CRC','Uf Crc',16,[ldGrid, ldLookup, ldCombobox], False)]
    property UfCrc: String  read FUF_CRC write FUF_CRC;

    [TAssociation(False, 'ID','ID_PESSOA','PESSOA')]
    property PessoaVO: TPessoaVO read FPessoaVO write FPessoaVO;

  end;

implementation

destructor TContadorVO.Destroy;
begin
  if Assigned(FPessoaVO) then
    FPessoaVO.Free;

  inherited;
end;

function TContadorVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.PessoaVO) then
      Self.PessoaNome := Self.PessoaVO.Nome;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
