{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [SINDICATO] 
                                                                                
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
                                                                                
@author Fernando Lúcio Oliveira (fsystem.br@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit SindicatoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  PessoaVO, ContabilContaVO;

type
  [TEntity]
  [TTable('SINDICATO')]
  TSindicatoVO = class(TJsonVO)
  private
    FID: Integer;
    FNOME: String;
    FCNPJ: String;
    FID_CONTABIL_CONTA: Integer;
    FCODIGO_BANCO: Integer;
    FCODIGO_AGENCIA: Integer;
    FCONTA_BANCO: String;
    FCODIGO_CEDENTE: String;
    FLOGRADOURO: String;
    FNUMERO: String;
    FBAIRRO: String;
    FMUNICIPIO_IBGE: Integer;
    FUF: String;
    FFONE1: String;
    FFONE2: String;
    FEMAIL: String;
    FTIPO_SINDICATO: String;
    FDATA_BASE: TDateTime;
    FPISO_SALARIAL: Extended;

    FContabilContaClassificacao: String;

    FContabilContaVO: TContabilContaVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('NOME','Nome',300,[ldGrid, ldLookup,ldComboBox], False)]
    property Nome: String  read FNOME write FNOME;

    [TColumn('CNPJ','Cnpj',200,[ldGrid, ldLookup],False)]
    [TFormatter(ftCnpj)]
    property Cnpj: String  read FCNPJ write FCNPJ;

    [TColumn('ID_CONTABIL_CONTA','Id Contábil Conta',80,[], False)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;
    [TColumn('CONTABIL_CONTA.CLASSIFICACAO','Conta Contábil',150,[ldGrid],True,'CONTABIL_CONTA','ID_CONTABIL_CONTA','ID')]
    property ContabilContaClassificacao: String read FContabilContaClassificacao write FContabilContaClassificacao;

    [TColumn('CODIGO_BANCO','Código Banco',80,[ldGrid, ldLookup,ldComboBox], False)]
    [TFormatter(ftZeroInvisivel, taCenter)]
    property CodigoBanco: Integer  read FCODIGO_BANCO write FCODIGO_BANCO;

    [TColumn('CODIGO_AGENCIA','Código Agencia',80,[ldGrid, ldLookup,ldComboBox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property CodigoAgencia: Integer  read FCODIGO_AGENCIA write FCODIGO_AGENCIA;


    [TColumn('CONTA_BANCO','Conta Banco',160,[ldGrid, ldLookup,ldComboBox], False)]
    property ContaBanco: String  read FCONTA_BANCO write FCONTA_BANCO;
    [TColumn('CODIGO_CEDENTE','Código Cedente',120,[ldGrid, ldLookup,ldComboBox], False)]
    property CodigoCedente: String  read FCODIGO_CEDENTE write FCODIGO_CEDENTE;
    [TColumn('LOGRADOURO','Logradouro',450,[ldGrid, ldLookup], False)]
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    [TColumn('NUMERO','Número',80,[ldGrid, ldLookup], False)]
    property Numero: String  read FNUMERO write FNUMERO;
    [TColumn('BAIRRO','Bairro',450,[ldGrid, ldLookup], False)]
    property Bairro: String  read FBAIRRO write FBAIRRO;
    [TColumn('MUNICIPIO_IBGE','Município Ibge',80,[], False)]
    property MunicipioIbge: Integer  read FMUNICIPIO_IBGE write FMUNICIPIO_IBGE;
    [TColumn('UF','Uf',16,[], False)]
    property Uf: String  read FUF write FUF;


    [TColumn('FONE1','Telefone 1',112,[ldGrid, ldLookup],False)]
    [TFormatter(ftTelefone,taCenter)]
    property Fone1: String  read FFONE1 write FFONE1;

    [TColumn('FONE2','Telefone 2',112,[ldGrid, ldLookup],False)]
    [TFormatter(ftTelefone,taLeftJustify)]
    property Fone2: String  read FFONE2 write FFONE2;

    [TColumn('EMAIL','E-mail',450,[ldGrid, ldLookup],False)]
    property Email: String  read FEMAIL write FEMAIL;
    [TColumn('TIPO_SINDICATO','Tipo Sindicato',120,[ldGrid, ldLookup,ldComboBox], False)]
    property TipoSindicato: String  read FTIPO_SINDICATO write FTIPO_SINDICATO;
    [TColumn('DATA_BASE','Data Base',80,[ldGrid, ldLookup,ldComboBox], False)]
    property DataBase: TDateTime  read FDATA_BASE write FDATA_BASE;

    [TColumn('PISO_SALARIAL','Piso Salarial',128,[ldGrid, ldLookup], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property PisoSalarial: Extended  read FPISO_SALARIAL write FPISO_SALARIAL;

    [TAssociation(False,'ID','ID_CONTABIL_CONTA','CONTABIL_CONTA')]
    property ContabilContaVO: TContabilContaVO read FContabilContaVO write FContabilContaVO;
  end;

implementation

destructor TSindicatoVO.Destroy;
begin
  if Assigned(FContabilContaVO) then
    FContabilContaVO.Free;
  inherited;
end;

function TSindicatoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ContabilContaVO) then
      Self.ContabilContaClassificacao := Self.ContabilContaVO.Classificacao;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;
end.
