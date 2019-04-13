{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [ORCAMENTO_FLUXO_CAIXA_PERIODO] 
                                                                                
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
unit OrcamentoFluxoCaixaPeriodoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ContaCaixaVO;

type
  [TEntity]
  [TTable('ORCAMENTO_FLUXO_CAIXA_PERIODO')]
  TOrcamentoFluxoCaixaPeriodoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_CONTA_CAIXA: Integer;
    FPERIODO: String;
    FNOME: String;

    FContaCaixaNome: String;

    FContaCaixaVO: TContaCaixaVO;

  public 
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_CONTA_CAIXA','Id Conta Caixa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    [TColumn('CONTA_CAIXA.NOME', 'Conta Caixa Nome', 100, [ldGrid, ldLookup, ldComboBox], True, 'CONTA_CAIXA', 'ID_CONTA_CAIXA', 'ID')]
    property ContaCaixaNome: String read FContaCaixaNome write FContaCaixaNome;

    [TColumn('PERIODO','Periodo',16,[ldGrid, ldLookup, ldCombobox], False)]
    property Periodo: String  read FPERIODO write FPERIODO;
    [TColumn('NOME','Nome',240,[ldGrid, ldLookup, ldCombobox], False)]
    property Nome: String  read FNOME write FNOME;

    [TAssociation(False, 'ID', 'ID_CONTA_CAIXA', 'CONTA_CAIXA')]
    property ContaCaixaVO: TContaCaixaVO read FContaCaixaVO write FContaCaixaVO;

  end;

implementation

destructor TOrcamentoFluxoCaixaPeriodoVO.Destroy;
begin
  if Assigned(FContaCaixaVO) then
    FContaCaixaVO.Free;
  inherited;
end;

function TOrcamentoFluxoCaixaPeriodoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    if Assigned(Self.ContaCaixaVO) then
      Self.ContaCaixaNome := Self.ContaCaixaVO.Nome;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
