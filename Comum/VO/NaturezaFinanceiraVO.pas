{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [NATUREZA_FINANCEIRA] 
                                                                                
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
unit NaturezaFinanceiraVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, PlanoNaturezaFinanceiraVO, ContabilContaVO;

type
  [TEntity]
  [TTable('NATUREZA_FINANCEIRA')]
  TNaturezaFinanceiraVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PLANO_NATUREZA_FINANCEIRA: Integer;
    FID_CONTABIL_CONTA: Integer;
    FCLASSIFICACAO: String;
    FDESCRICAO: String;
    FTIPO: String;
    FAPLICACAO: String;
    FAPARECE_A_PAGAR: String;
    FAPARECE_A_RECEBER: String;

    FPlanoNaturezaFinanceiraNome: String;
    FContabilContaClassificacao: String;

    FPlanoNaturezaFinanceiraVO: TPlanoNaturezaFinanceiraVO;
    FContabilContaVO:  TContabilContaVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_PLANO_NATUREZA_FINANCEIRA','Id Plano Natureza Financeira',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPlanoNaturezaFinanceira: Integer  read FID_PLANO_NATUREZA_FINANCEIRA write FID_PLANO_NATUREZA_FINANCEIRA;
    [TColumn('PLANO_NATUREZA_FINANCEIRA.NOME', 'Plano Natureza Financeira', 300, [ldGrid, ldLookup, ldComboBox], True, 'PLANO_NATUREZA_FINANCEIRA', 'ID_PLANO_NATUREZA_FINANCEIRA', 'ID')]
    property PlanoNaturezaFinanceiraNome: String read FPlanoNaturezaFinanceiraNome write FPlanoNaturezaFinanceiraNome;

    [TColumn('ID_CONTABIL_CONTA','Id Contabil Conta',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;
    [TColumn('CONTABIL_CONTA.CLASSIFICACAO','Conta Contábil',150,[ldGrid],True,'CONTABIL_CONTA','ID_CONTABIL_CONTA','ID')]
    property ContabilContaClassificacao: String read FContabilContaClassificacao write FContabilContaClassificacao;

    [TColumn('CLASSIFICACAO','Classificacao',240,[ldGrid, ldLookup, ldCombobox], False)]
    property Classificacao: String  read FCLASSIFICACAO write FCLASSIFICACAO;
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('TIPO','Tipo',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Tipo: String  read FTIPO write FTIPO;
    [TColumn('APLICACAO','Aplicacao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Aplicacao: String  read FAPLICACAO write FAPLICACAO;
    [TColumn('APARECE_A_PAGAR','Aparece A Pagar',8,[ldGrid, ldLookup, ldCombobox], False)]
    property ApareceAPagar: String  read FAPARECE_A_PAGAR write FAPARECE_A_PAGAR;
    [TColumn('APARECE_A_RECEBER','Aparece A Receber',8,[ldGrid, ldLookup, ldCombobox], False)]
    property ApareceAReceber: String  read FAPARECE_A_RECEBER write FAPARECE_A_RECEBER;

    [TAssociation(False,'ID','ID_PLANO_NATUREZA_FINANCEIRA','PLANO_NATUREZA_FINANCEIRA')]
    property PlanoNaturezaFinanceiraVO: TPlanoNaturezaFinanceiraVO read FPlanoNaturezaFinanceiraVO write FPlanoNaturezaFinanceiraVO;

    [TAssociation(False,'ID','ID_CONTABIL_CONTA','CONTABIL_CONTA')]
    property ContabilContaVO: TContabilContaVO read FContabilContaVO write FContabilContaVO;
  end;

implementation

destructor TNaturezaFinanceiraVO.Destroy;
begin
  if Assigned(FPlanoNaturezaFinanceiraVO) then
    FPlanoNaturezaFinanceiraVO.Free;
  if Assigned(FContabilContaVO) then
    FContabilContaVO.Free;
  inherited;
end;

function TNaturezaFinanceiraVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.PlanoNaturezaFinanceiraVO) then
      Self.PlanoNaturezaFinanceiraNome := Self.PlanoNaturezaFinanceiraVO.Nome + ' [' + Self.PlanoNaturezaFinanceiraVO.Mascara + ']';
    if Assigned(Self.ContabilContaVO) then
      Self.ContabilContaClassificacao := Self.ContabilContaVO.Classificacao;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
