{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [Uf]
                                                                                
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
unit UfVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  PaisVO;

type
  [TEntity]
  [TTable('UF')]
  TUfVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PAIS: Integer;
    FSIGLA: String;
    FNOME: String;
    FCODIGO_IBGE: Integer;

    FPaisNomePtbr: String;
    FPaisVO: TPaisVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_PAIS','Id País',[ldGrid,ldLookup],False)]
    property IdPais: Integer  read FID_PAIS write FID_PAIS;
    [TColumn('PAIS','Pais',350,[ldGrid,ldLookup],True,'PAIS','ID_PAIS','ID')]
    property PaisNomePtbr: string read FPaisNomePtbr write FPaisNomePtbr;

    [TColumn('SIGLA','Sigla',35,[ldGrid,ldLookup, ldComboBox],False)]
    property Sigla: String  read FSIGLA write FSIGLA;
    [TColumn('NOME','Nome',[ldGrid,ldLookup, ldComboBox],False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('CODIGO_IBGE','Código Ibge',[ldGrid,ldLookup],False)]
    property CodigoIbge: Integer  read FCODIGO_IBGE write FCODIGO_IBGE;

    [TAssociation(False,'ID','ID_PAIS','PAIS')]
    property PaisVO: TPaisVO read FPaisVO write FPaisVO;


  end;

implementation

destructor TUfVO.Destroy;
begin
  if Assigned(FPaisVO) then
    FPaisVO.Free;
  inherited;
end;

function TUfVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.PaisVO) then
      Self.PaisNomePtbr := Self.PaisVO.NomePtbr;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
