{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FIN_PARCELA_PAGAR] 
                                                                                
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
unit FinParcelaPagarVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ContaCaixaVO;

type
  [TEntity]
  [TTable('FIN_PARCELA_PAGAR')]
  TFinParcelaPagarVO = class(TJsonVO)
  private
    FID: Integer;
    FID_CONTA_CAIXA: Integer;
    FID_FIN_LANCAMENTO_PAGAR: Integer;
    FID_FIN_STATUS_PARCELA: Integer;
    FNUMERO_PARCELA: Integer;
    FDATA_EMISSAO: TDateTime;
    FDATA_VENCIMENTO: TDateTime;
    FDESCONTO_ATE: TDateTime;
    FSOFRE_RETENCAO: String;
    FVALOR: Extended;
    FTAXA_JURO: Extended;
    FTAXA_MULTA: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_JURO: Extended;
    FVALOR_MULTA: Extended;
    FVALOR_DESCONTO: Extended;

    FContaCaixaNome: String;

    FContaCaixaVO: TContaCaixaVO;

  public 
    destructor Destroy; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_CONTA_CAIXA','Id Conta Caixa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    [TColumn('CONTA_CAIXA.NOME', 'Conta Caixa Nome', 100, [ldGrid, ldLookup, ldComboBox], True, 'CONTA_CAIXA', 'ID_CONTA_CAIXA', 'ID')]
    property ContaCaixaNome: String read FContaCaixaNome write FContaCaixaNome;

    [TColumn('ID_FIN_LANCAMENTO_PAGAR','Id Fin Lancamento Pagar',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFinLancamentoPagar: Integer  read FID_FIN_LANCAMENTO_PAGAR write FID_FIN_LANCAMENTO_PAGAR;
    [TColumn('ID_FIN_STATUS_PARCELA','Id Fin Status Parcela',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFinStatusParcela: Integer  read FID_FIN_STATUS_PARCELA write FID_FIN_STATUS_PARCELA;
    [TColumn('NUMERO_PARCELA','Numero Parcela',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property NumeroParcela: Integer  read FNUMERO_PARCELA write FNUMERO_PARCELA;
    [TColumn('DATA_EMISSAO','Data Emissao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataEmissao: TDateTime  read FDATA_EMISSAO write FDATA_EMISSAO;
    [TColumn('DATA_VENCIMENTO','Data Vencimento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataVencimento: TDateTime  read FDATA_VENCIMENTO write FDATA_VENCIMENTO;
    [TColumn('DESCONTO_ATE','Desconto Ate',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DescontoAte: TDateTime  read FDESCONTO_ATE write FDESCONTO_ATE;
    [TColumn('SOFRE_RETENCAO','Sofre Retencao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property SofreRetencao: String  read FSOFRE_RETENCAO write FSOFRE_RETENCAO;
    [TColumn('VALOR','Valor',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Valor: Extended  read FVALOR write FVALOR;
    [TColumn('TAXA_JURO','Taxa Juro',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaJuro: Extended  read FTAXA_JURO write FTAXA_JURO;
    [TColumn('TAXA_MULTA','Taxa Multa',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaMulta: Extended  read FTAXA_MULTA write FTAXA_MULTA;
    [TColumn('TAXA_DESCONTO','Taxa Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    [TColumn('VALOR_JURO','Valor Juro',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorJuro: Extended  read FVALOR_JURO write FVALOR_JURO;
    [TColumn('VALOR_MULTA','Valor Multa',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorMulta: Extended  read FVALOR_MULTA write FVALOR_MULTA;
    [TColumn('VALOR_DESCONTO','Valor Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;

    [TAssociation(False, 'ID', 'ID_CONTA_CAIXA', 'CONTA_CAIXA')]
    property ContaCaixaVO: TContaCaixaVO read FContaCaixaVO write FContaCaixaVO;

  end;

implementation

destructor TFinParcelaPagarVO.Destroy;
begin
  if Assigned(FContaCaixaVO) then
    FContaCaixaVO.Free;

  inherited;
end;

end.
