{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FOLHA_HISTORICO_SALARIAL] 
                                                                                
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
unit FolhaHistoricoSalarialVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ColaboradorPessoaVO;

type
  [TEntity]
  [TTable('FOLHA_HISTORICO_SALARIAL')]
  TFolhaHistoricoSalarialVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FCOMPETENCIA: String;
    FSALARIO_ATUAL: Extended;
    FPERCENTUAL_AUMENTO: Extended;
    FSALARIO_NOVO: Extended;
    FVALIDO_A_PARTIR: String;
    FMOTIVO: String;

    FColaboradorPessoaNome: String;

    FColaboradorVO: TColaboradorVO;

  public 
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_COLABORADOR','Id Colaborador',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADOR.PESSOA.NOME', 'Requisitante', 250, [ldGrid, ldLookup, ldComboBox], True, 'COLABORADOR.PESSOA', 'ID_COLABORADOR', 'ID')]
    property ColaboradorPessoaNome: String read FColaboradorPessoaNome write FColaboradorPessoaNome;

    [TColumn('COMPETENCIA','Competencia',56,[ldGrid, ldLookup, ldCombobox], False)]
    property Competencia: String  read FCOMPETENCIA write FCOMPETENCIA;
    [TColumn('SALARIO_ATUAL','Salario Atual',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property SalarioAtual: Extended  read FSALARIO_ATUAL write FSALARIO_ATUAL;
    [TColumn('PERCENTUAL_AUMENTO','Percentual Aumento',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property PercentualAumento: Extended  read FPERCENTUAL_AUMENTO write FPERCENTUAL_AUMENTO;
    [TColumn('SALARIO_NOVO','Salario Novo',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property SalarioNovo: Extended  read FSALARIO_NOVO write FSALARIO_NOVO;
    [TColumn('VALIDO_A_PARTIR','Valido A Partir',56,[ldGrid, ldLookup, ldCombobox], False)]
    property ValidoAPartir: String  read FVALIDO_A_PARTIR write FVALIDO_A_PARTIR;
    [TColumn('MOTIVO','Motivo',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Motivo: String  read FMOTIVO write FMOTIVO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR', 'COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

  end;

implementation

destructor TFolhaHistoricoSalarialVO.Destroy;
begin
  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;
  inherited;
end;

function TFolhaHistoricoSalarialVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    // Campos Transientes
     if Assigned(Self.ColaboradorVO) then
       Self.ColaboradorPessoaNome := Self.ColaboradorVO.PessoaVO.Nome;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
