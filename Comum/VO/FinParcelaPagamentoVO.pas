{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FIN_PARCELA_PAGAMENTO] 
                                                                                
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
unit FinParcelaPagamentoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ContaCaixaVO, FinTipoPagamentoVO, FinChequeEmitidoVO;

type
  [TEntity]
  [TTable('FIN_PARCELA_PAGAMENTO')]
  TFinParcelaPagamentoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_FIN_PARCELA_PAGAR: Integer;
    FID_FIN_CHEQUE_EMITIDO: Integer;
    FID_FIN_TIPO_PAGAMENTO: Integer;
    FID_CONTA_CAIXA: Integer;
    FDATA_PAGAMENTO: TDateTime;
    FTAXA_JURO: Extended;
    FTAXA_MULTA: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_JURO: Extended;
    FVALOR_MULTA: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_PAGO: Extended;
    FHISTORICO: String;

    FContaCaixaNome: String;
    FFinTipoPagamentoDescricao: String;
    FFinChequeEmitidoNumero: Integer;

    FContaCaixaVO: TContaCaixaVO;
    FFinTipoPagamentoVO: TFinTipoPagamentoVO;
    FFinChequeEmitidoVO: TFinChequeEmitidoVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_FIN_PARCELA_PAGAR','Id Parcela Pagar',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFinParcelaPagar: Integer  read FID_FIN_PARCELA_PAGAR write FID_FIN_PARCELA_PAGAR;

    [TColumn('ID_FIN_CHEQUE_EMITIDO','Id Cheque Emitido',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFinChequeEmitido: Integer  read FID_FIN_CHEQUE_EMITIDO write FID_FIN_CHEQUE_EMITIDO;
    [TColumn('CHEQUE.NUMERO', 'Número Cheque', 100, [ldGrid, ldLookup, ldComboBox], True, 'FIN_CHEQUE_EMITIDO', 'ID_FIN_CHEQUE_EMITIDO', 'ID')]
    property FinChequeEmitidoNumero: Integer read FFinChequeEmitidoNumero write FFinChequeEmitidoNumero;

    [TColumn('ID_FIN_TIPO_PAGAMENTO','Id Tipo Pagamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFinTipoPagamento: Integer  read FID_FIN_TIPO_PAGAMENTO write FID_FIN_TIPO_PAGAMENTO;
    [TColumn('TIPO_PAGAMENTO.DESCRICAO', 'Tipo Pagamento Descrição', 100, [ldGrid, ldLookup, ldComboBox], True, 'FIN_TIPO_PAGAMENTO', 'ID_FIN_TIPO_PAGAMENTO', 'ID')]
    property FinTipoPagamentoDescricao: String read FFinTipoPagamentoDescricao write FFinTipoPagamentoDescricao;

    [TColumn('ID_CONTA_CAIXA','Id Conta Caixa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    [TColumn('CONTA_CAIXA.NOME', 'Conta Caixa Nome', 100, [ldGrid, ldLookup, ldComboBox], True, 'CONTA_CAIXA', 'ID_CONTA_CAIXA', 'ID')]
    property ContaCaixaNome: String read FContaCaixaNome write FContaCaixaNome;

    [TColumn('DATA_PAGAMENTO','Data Pagamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataPagamento: TDateTime  read FDATA_PAGAMENTO write FDATA_PAGAMENTO;
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
    [TColumn('VALOR_PAGO','Valor Pago',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorPago: Extended  read FVALOR_PAGO write FVALOR_PAGO;
    [TColumn('HISTORICO','Historico',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Historico: String  read FHISTORICO write FHISTORICO;

    [TAssociation(False, 'ID', 'ID_CONTA_CAIXA', 'CONTA_CAIXA')]
    property ContaCaixaVO: TContaCaixaVO read FContaCaixaVO write FContaCaixaVO;

    [TAssociation(False, 'ID', 'ID_FIN_TIPO_PAGAMENTO', 'FIN_TIPO_PAGAMENTO')]
    property FinTipoPagamentoVO: TFinTipoPagamentoVO read FFinTipoPagamentoVO write FFinTipoPagamentoVO;

    [TAssociation(True, 'ID', 'ID_FIN_CHEQUE_EMITIDO', 'FIN_CHEQUE_EMITIDO')]
    property FinChequeEmitidoVO: TFinChequeEmitidoVO read FFinChequeEmitidoVO write FFinChequeEmitidoVO;
  end;

implementation

destructor TFinParcelaPagamentoVO.Destroy;
begin
  if Assigned(FContaCaixaVO) then
    FContaCaixaVO.Free;
  if Assigned(FFinTipoPagamentoVO) then
    FFinTipoPagamentoVO.Free;
  if Assigned(FFinChequeEmitidoVO) then
    FFinChequeEmitidoVO.Free;
  inherited;
end;

function TFinParcelaPagamentoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ContaCaixaVO) then
      Self.ContaCaixaNome := Self.ContaCaixaVO.Nome;
    if Assigned(Self.FinTipoPagamentoVO) then
      Self.FinTipoPagamentoDescricao := Self.FinTipoPagamentoVO.Descricao;
    if Assigned(Self.FinChequeEmitidoVO) then
      Self.FFinChequeEmitidoNumero := Self.FinChequeEmitidoVO.ChequeVO.Numero;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
