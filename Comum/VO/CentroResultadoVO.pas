{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CENTRO_RESULTADO] 
                                                                                
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
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit CentroResultadoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, PlanoCentroResultadoVO;

type
  [TEntity]
  [TTable('CENTRO_RESULTADO')]
  TCentroResultadoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PLANO_CENTRO_RESULTADO: Integer;
    FCLASSIFICACAO: String;
    FDESCRICAO: String;
    FSOFRE_RATEIRO: String;

    FPlanoCentroResultadoNome: String;
    FPlanoCentroResultadoVO: TPlanoCentroResultadoVO;

  public 
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_PLANO_CENTRO_RESULTADO','Id Plano Centro Resultado',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPlanoCentroResultado: Integer  read FID_PLANO_CENTRO_RESULTADO write FID_PLANO_CENTRO_RESULTADO;

    [TColumn('PLANO_CENTRO_RESULTADO.NOME', 'Plano Centro Resultado', 300, [ldGrid, ldLookup, ldComboBox], True, 'PLANO_CENTRO_RESULTADO', 'ID_PLANO_CENTRO_RESULTADO', 'ID')]
    property PlanoCentroResultadoNome: String read FPlanoCentroResultadoNome write FPlanoCentroResultadoNome;

    [TColumn('CLASSIFICACAO','Classificacao',240,[ldGrid, ldLookup, ldCombobox], False)]
    property Classificacao: String  read FCLASSIFICACAO write FCLASSIFICACAO;
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('SOFRE_RATEIRO','Sofre Rateiro',8,[ldGrid, ldLookup, ldCombobox], False)]
    property SofreRateiro: String  read FSOFRE_RATEIRO write FSOFRE_RATEIRO;

    [TAssociation(False, 'ID', 'ID_PLANO_CENTRO_RESULTADO', 'PLANO_CENTRO_RESULTADO')]
    property PlanoCentroResultadoVO: TPlanoCentroResultadoVO read FPlanoCentroResultadoVO write FPlanoCentroResultadoVO;

  end;

implementation

destructor TCentroResultadoVO.Destroy;
begin
  if Assigned(FPlanoCentroResultadoVO) then
    FPlanoCentroResultadoVO.Free;

  inherited;
end;

function TCentroResultadoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.PlanoCentroResultadoVO) then
      Self.PlanoCentroResultadoNome := Self.PlanoCentroResultadoVO.Nome + ' [' + Self.PlanoCentroResultadoVO.Mascara + ']';;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
