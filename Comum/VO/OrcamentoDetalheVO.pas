{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [ORCAMENTO_DETALHE] 
                                                                                
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
                                                                                
fernandololiver@gmail.com
@author @author Fernando L Oliveira
@version 1.0                                                                    
*******************************************************************************}
unit OrcamentoDetalheVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  NaturezaFinanceiraVO;

type
  [TEntity]
  [TTable('ORCAMENTO_DETALHE')]
  TOrcamentoDetalheVO = class(TJsonVO)
  private
    FID: Integer;
    FID_NATUREZA_FINANCEIRA: Integer;
    FID_ORCAMENTO_EMPRESARIAL: Integer;
    FPERIODO: String;
    FVALOR_ORCADO: Extended;
    FVALOR_REALIZADO: Extended;
    FTAXA_VARIACAO: Extended;
    FVALOR_VARIACAO: Extended;

    FNaturezaFinanceiraClassificacao: String;
    FNaturezaFinanceiraDescricao: String;

    FNaturezaFinanceiraVO: TNaturezaFinanceiraVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    // Natureza Financeira
    [TColumn('ID_NATUREZA_FINANCEIRA','Id Natureza Financeira',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdNaturezaFinanceira: Integer  read FID_NATUREZA_FINANCEIRA write FID_NATUREZA_FINANCEIRA;
    [TColumn('NATUREZA_FINANCEIRA.CLASSIFICACAO','Classificação',100,[ldGrid,ldLookup,ldComboBox],True,'NATUREZA_FINANCEIRA','ID_NATUREZA_FINANCEIRA','ID')]
    property NaturezaFinanceiraClassificacao: string read FNaturezaFinanceiraClassificacao write FNaturezaFinanceiraClassificacao;
    [TColumn('NATUREZA_FINANCEIRA.DESCRICAO','Descrição',300,[ldGrid,ldLookup,ldComboBox],True,'NATUREZA_FINANCEIRA','ID_NATUREZA_FINANCEIRA','ID')]
    property NaturezaFinanceiraDescricao: string read FNaturezaFinanceiraDescricao write FNaturezaFinanceiraDescricao;

    [TColumn('ID_ORCAMENTO_EMPRESARIAL','Id Orcamento Empresarial',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdOrcamentoEmpresarial: Integer  read FID_ORCAMENTO_EMPRESARIAL write FID_ORCAMENTO_EMPRESARIAL;
    [TColumn('PERIODO','Periodo',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(taCenter)]
    property Periodo: String  read FPERIODO write FPERIODO;
    [TColumn('VALOR_ORCADO','Valor Orcado',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorOrcado: Extended  read FVALOR_ORCADO write FVALOR_ORCADO;
    [TColumn('VALOR_REALIZADO','Valor Realizado',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorRealizado: Extended  read FVALOR_REALIZADO write FVALOR_REALIZADO;
    [TColumn('TAXA_VARIACAO','Taxa Variacao',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaVariacao: Extended  read FTAXA_VARIACAO write FTAXA_VARIACAO;
    [TColumn('VALOR_VARIACAO','Valor Variacao',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorVariacao: Extended  read FVALOR_VARIACAO write FVALOR_VARIACAO;

    [TAssociation(True,'ID','ID_NATUREZA_FINANCEIRA','NATUREZA_FINANCEIRA')]
    property NaturezaFinanceiraVO: TNaturezaFinanceiraVO read FNaturezaFinanceiraVO write FNaturezaFinanceiraVO;

  end;

implementation

{ TOrcamentoDetalheVO }

destructor TOrcamentoDetalheVO.Destroy;
begin
  if Assigned(FNaturezaFinanceiraVO) then
    FNaturezaFinanceiraVO.Free;
  inherited;
end;

function TOrcamentoDetalheVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.NaturezaFinanceiraVO) then
      begin
        Self.NaturezaFinanceiraClassificacao := Self.NaturezaFinanceiraVO.Classificacao;
        Self.NaturezaFinanceiraDescricao := Self.NaturezaFinanceiraVO.Descricao;
      end;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
