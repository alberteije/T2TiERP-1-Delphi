{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [AGENCIA_BANCO]
                                                                                
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
                                                                                
@author Fernando Lúcio de Oliveira (fsystem.br@gmail.com.br)                            
@version 1.0                                                                    
*******************************************************************************}
unit AgenciaBancoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  BancoVO;
type
  [TEntity]
  [TTable('AGENCIA_BANCO')]
  TAgenciaBancoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_BANCO: Integer;
    FCODIGO: String;
    FDIGITO: String;
    FNOME: String;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCEP: String;
    FBAIRRO: String;
    FMUNICIPIO: String;
    FUF: String;
    FTELEFONE: String;
    FGERENTE: String;
    FCONTATO: String;
    FOBSERVACAO: String;

    FBancoNome : String;

    FBancoVO: TBancoVO;


  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_BANCO','Id Banco',64,[ldGrid,ldLookup],False)]
    property IdBanco: Integer  read FID_BANCO write FID_BANCO;
    [TColumn('BANCO.NOME','Banco',300,[ldGrid,ldLookup,ldComboBox],True,'BANCO','ID_BANCO','ID')]
    property BancoNome: string read FBancoNome write FBancoNome;

    [TColumn('CODIGO','Código',45,[ldGrid,ldLookup],False)]
    property Codigo: String  read FCODIGO write FCODIGO;
    [TColumn('DIGITO','Digito',45,[ldGrid,ldLookup],False)]
    property Digito: String  read FDIGITO write FDIGITO;
    [TColumn('NOME','Nome',300,[ldGrid,ldLookup,ldComboBox],False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('LOGRADOURO','Logradouro',300,[ldGrid,ldLookup],False)]
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    [TColumn('NUMERO','Número',30,[ldGrid,ldLookup],False)]
    property Numero: String  read FNUMERO write FNUMERO;
    [TColumn('CEP','Cep',75,[ldGrid,ldLookup],False)]
    property Cep: String  read FCEP write FCEP;
    [TColumn('BAIRRO','Bairro',200,[ldGrid,ldLookup],False)]
    property Bairro: String  read FBAIRRO write FBAIRRO;
    [TColumn('MUNICIPIO','Município',200,[ldGrid,ldLookup],False)]
    property Municipio: String  read FMUNICIPIO write FMUNICIPIO;
    [TColumn('UF','Uf',32,[ldGrid,ldLookup],False)]
    property Uf: String  read FUF write FUF;
    [TColumn('TELEFONE','Telefone',65,[ldGrid,ldLookup],False)]
    property Telefone: String  read FTELEFONE write FTELEFONE;
    [TColumn('GERENTE','Gerente',200,[ldGrid,ldLookup],False)]
    property Gerente: String  read FGERENTE write FGERENTE;
    [TColumn('CONTATO','Contato',200,[ldGrid,ldLookup],False)]
    property Contato: String  read FCONTATO write FCONTATO;
    [TColumn('OBSERVACAO','Observação',[],False)]
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;

    [TAssociation(True,'ID','ID_BANCO','BANCO')]
    property BancoVO: TBancoVO read FBancoVO write FBancoVO;
  end;

implementation

destructor TAgenciaBancoVO.Destroy;
begin
  if Assigned(FBancoVO) then
    FBancoVO.Free;

  inherited;
end;

function TAgenciaBancoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.BancoVO) then
     Self.BancoNome := Self.BancoVO.Nome;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
