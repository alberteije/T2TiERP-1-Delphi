{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [Municipio]
                                                                                
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
unit MunicipioVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  UfVO;

type
  [TEntity]
  [TTable('MUNICIPIO')]
  TMunicipioVO = class(TJsonVO)
  private
    FID: Integer;
    FID_UF: Integer;
    FNOME: String;
    FCODIGO_IBGE: Integer;
    FCODIGO_RECEITA_FEDERAL: Integer;
    FCODIGO_ESTADUAL: Integer;

    FUfNome: String;
    FUfSigla: String;
    FUfVO: TUfVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;


    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda,taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('NOME','Nome Município',450,[ldGrid,ldLookup, ldComboBox],False)]
    property Nome: String  read FNOME write FNOME;

    [TColumn('UF.NOME','Unidade Federal',260,[ldGrid,ldLookup, ldComboBox],True,'UF','ID_UF','ID')]
    property UfNome: string read FUfNome write FUfNome;
    [TColumn('UF.SIGLA','Sigla',40,[ldGrid,ldLookup, ldComboBox],True,'UF','ID_UF','ID')]
    [TFormatter(taCenter)]
    property UfSigla: string read FUfSigla write FUfSigla;

    [TColumn('ID_UF','Id Uf',[ldGrid,ldLookup],False)]
    property IdUf: Integer  read FID_UF write FID_UF;

    [TColumn('CODIGO_IBGE','Código Ibge',[ldGrid,ldLookup],False)]
    property CodigoIbge: Integer  read FCODIGO_IBGE write FCODIGO_IBGE;
    [TColumn('CODIGO_RECEITA_FEDERAL','Código Receita Federal',[ldGrid,ldLookup],False)]
    property CodigoReceitaFederal: Integer  read FCODIGO_RECEITA_FEDERAL write FCODIGO_RECEITA_FEDERAL;
    [TColumn('CODIGO_ESTADUAL','Código Estadual',[ldGrid,ldLookup],False)]
    property CodigoEstadual: Integer  read FCODIGO_ESTADUAL write FCODIGO_ESTADUAL;

   [TAssociation(False,'ID','ID_UF','UF')]
    property UfVO: TUfVO read FUfVO write FUfVO;

  end;

implementation

destructor TMunicipioVO.Destroy;
begin
  if Assigned(FUfVO) then
    FUfVO.Free;
  inherited;
end;

function TMunicipioVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.UfVO) then
    begin
      Self.UfNome  := Self.UfVO.Nome;
      Self.UfSigla := Self.UfVO.Sigla;
    end;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
