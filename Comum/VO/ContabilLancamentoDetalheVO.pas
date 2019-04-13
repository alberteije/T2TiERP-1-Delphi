{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTABIL_LANCAMENTO_DETALHE] 
                                                                                
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
unit ContabilLancamentoDetalheVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ContabilContaVO;

type
  [TEntity]
  [TTable('CONTABIL_LANCAMENTO_DETALHE')]
  TContabilLancamentoDetalheVO = class(TJsonVO)
  private
    FID: Integer;
    FID_CONTABIL_CONTA: Integer;
    FID_CONTABIL_HISTORICO: Integer;
    FID_CONTABIL_LANCAMENTO_CAB: Integer;
    FHISTORICO: String;
    FVALOR: Extended;
    FTIPO: String;

    FContabilContaClassificacao: String;

    FContabilContaVO: TContabilContaVO;

  public 
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_CONTABIL_CONTA','Id Contabil Conta',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;
    [TColumn('CONTABIL_CONTA.CLASSIFICACAO', 'Classificação Conta', 100, [ldGrid, ldLookup, ldComboBox], True, 'CONTABIL_CONTA', 'ID_CONTABIL_CONTA', 'ID')]
    property ContabilContaClassificacao: String read FContabilContaClassificacao write FContabilContaClassificacao;

    [TColumn('ID_CONTABIL_HISTORICO','Id Contabil Historico',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilHistorico: Integer  read FID_CONTABIL_HISTORICO write FID_CONTABIL_HISTORICO;
    [TColumn('ID_CONTABIL_LANCAMENTO_CAB','Id Contabil Lancamento Cab',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilLancamentoCab: Integer  read FID_CONTABIL_LANCAMENTO_CAB write FID_CONTABIL_LANCAMENTO_CAB;
    [TColumn('HISTORICO','Historico',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Historico: String  read FHISTORICO write FHISTORICO;
    [TColumn('VALOR','Valor',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Valor: Extended  read FVALOR write FVALOR;
    [TColumn('TIPO','Tipo',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Tipo: String  read FTIPO write FTIPO;

    [TAssociation(False, 'ID', 'ID_CONTABIL_CONTA', 'CONTABIL_CONTA')]
    property ContabilContaVO: TContabilContaVO read FContabilContaVO write FContabilContaVO;

  end;

implementation

destructor TContabilLancamentoDetalheVO.Destroy;
begin
  if Assigned(FContabilContaVO) then
    FContabilContaVO.Free;

  inherited;
end;

function TContabilLancamentoDetalheVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.FContabilContaVO) then
      Self.ContabilContaClassificacao := Self.FContabilContaVO.Classificacao;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
