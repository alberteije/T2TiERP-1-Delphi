{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [VIEW_FIN_LANCAMENTO_RECEBER] 
                                                                                
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
unit ViewFinLancamentoReceberVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('VIEW_FIN_LANCAMENTO_RECEBER')]
  TViewFinLancamentoReceberVO = class(TJsonVO)
  private
    FEmitirCheque: String;
    FID: Integer;
    FID_LANCAMENTO_RECEBER: Integer;
    FQUANTIDADE_PARCELA: Integer;
    FVALOR_LANCAMENTO: Extended;
    FDATA_LANCAMENTO: TDateTime;
    FNUMERO_DOCUMENTO: String;
    FID_PARCELA_RECEBER: Integer;
    FNUMERO_PARCELA: Integer;
    FDATA_VENCIMENTO: TDateTime;
    FVALOR_PARCELA: Extended;
    FTAXA_JURO: Extended;
    FVALOR_JURO: Extended;
    FTAXA_MULTA: Extended;
    FVALOR_MULTA: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_DESCONTO: Extended;
    FSIGLA_DOCUMENTO: String;
    FNOME_CLIENTE: String;
    FSITUACAO_PARCELA: String;
    FDESCRICAO_SITUACAO_PARCELA: String;
    FID_CONTA_CAIXA: Integer;
    FNOME_CONTA_CAIXA: String;

  public 
    [TColumn('CheckBox',' ',16,[ldGrid], True)]
    [TColumn('EmitirCheque','Emitir',16,[], True)]
    property EmitirCheque: String  read FEmitirCheque write FEmitirCheque;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('NOME_CLIENTE','Cliente',250,[ldGrid, ldLookup, ldCombobox], False)]
    property NomeCliente: String  read FNOME_CLIENTE write FNOME_CLIENTE;
    [TColumn('NOME_CONTA_CAIXA','Conta Caixa',250,[ldGrid, ldLookup, ldCombobox], False)]
    property NomeContaCaixa: String  read FNOME_CONTA_CAIXA write FNOME_CONTA_CAIXA;
    [TColumn('ID_LANCAMENTO_RECEBER','Id Lançamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdLancamentoReceber: Integer  read FID_LANCAMENTO_RECEBER write FID_LANCAMENTO_RECEBER;
    [TColumn('QUANTIDADE_PARCELA','Qtde. Parcelas',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property QuantidadeParcela: Integer  read FQUANTIDADE_PARCELA write FQUANTIDADE_PARCELA;
    [TColumn('NUMERO_PARCELA','Número Parcela',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property NumeroParcela: Integer  read FNUMERO_PARCELA write FNUMERO_PARCELA;
    [TColumn('VALOR_LANCAMENTO','Valor Lançamento',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorLancamento: Extended  read FVALOR_LANCAMENTO write FVALOR_LANCAMENTO;
    [TColumn('VALOR_PARCELA','Valor Parcela',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorParcela: Extended  read FVALOR_PARCELA write FVALOR_PARCELA;
    [TColumn('DATA_LANCAMENTO','Data Lançamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataLancamento: TDateTime  read FDATA_LANCAMENTO write FDATA_LANCAMENTO;
    [TColumn('DATA_VENCIMENTO','Data Vencimento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataVencimento: TDateTime  read FDATA_VENCIMENTO write FDATA_VENCIMENTO;
    [TColumn('NUMERO_DOCUMENTO','Numero Documento',400,[ldGrid, ldLookup, ldCombobox], False)]
    property NumeroDocumento: String  read FNUMERO_DOCUMENTO write FNUMERO_DOCUMENTO;
    [TColumn('SIGLA_DOCUMENTO','Tipo Documento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property SiglaDocumento: String  read FSIGLA_DOCUMENTO write FSIGLA_DOCUMENTO;
    [TColumn('ID_PARCELA_RECEBER','Id Parcela Receber',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdParcelaReceber: Integer  read FID_PARCELA_RECEBER write FID_PARCELA_RECEBER;
    [TColumn('TAXA_JURO','Taxa Juro',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaJuro: Extended  read FTAXA_JURO write FTAXA_JURO;
    [TColumn('VALOR_JURO','Valor Juro',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorJuro: Extended  read FVALOR_JURO write FVALOR_JURO;
    [TColumn('TAXA_MULTA','Taxa Multa',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaMulta: Extended  read FTAXA_MULTA write FTAXA_MULTA;
    [TColumn('VALOR_MULTA','Valor Multa',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorMulta: Extended  read FVALOR_MULTA write FVALOR_MULTA;
    [TColumn('TAXA_DESCONTO','Taxa Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    [TColumn('VALOR_DESCONTO','Valor Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('SITUACAO_PARCELA','Cód. Situação',16,[ldGrid, ldLookup, ldCombobox], False)]
    property SituacaoParcela: String  read FSITUACAO_PARCELA write FSITUACAO_PARCELA;
    [TColumn('DESCRICAO_SITUACAO_PARCELA','Situação',240,[ldGrid, ldLookup, ldCombobox], False)]
    property DescricaoSituacaoParcela: String  read FDESCRICAO_SITUACAO_PARCELA write FDESCRICAO_SITUACAO_PARCELA;
    [TColumn('ID_CONTA_CAIXA','Id Conta Caixa',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;

  end;

implementation



end.
