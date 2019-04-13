{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FIN_PARCELA_RECEBIMENTO] 
                                                                                
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
unit FinParcelaRecebimentoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ContaCaixaVO, FinTipoRecebimentoVO, FinChequeRecebidoVO;

type
  [TEntity]
  [TTable('FIN_PARCELA_RECEBIMENTO')]
  TFinParcelaRecebimentoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_FIN_PARCELA_RECEBER: Integer;
    FID_FIN_TIPO_RECEBIMENTO: Integer;
    FID_FIN_CHEQUE_RECEBIDO: Integer;
    FID_CONTA_CAIXA: Integer;
    FDATA_RECEBIMENTO: TDateTime;
    FTAXA_JURO: Extended;
    FTAXA_MULTA: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_JURO: Extended;
    FVALOR_MULTA: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_RECEBIDO: Extended;
    FHISTORICO: String;

    FContaCaixaNome: String;
    FFinTipoRecebimentoDescricao: String;
    FFinChequeRecebidoNumero: Integer;

    FContaCaixaVO: TContaCaixaVO;
    FFinTipoRecebimentoVO: TFinTipoRecebimentoVO;
    FFinChequeRecebidoVO: TFinChequeRecebidoVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_FIN_PARCELA_RECEBER','Id Parcela Receber',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFinParcelaReceber: Integer  read FID_FIN_PARCELA_RECEBER write FID_FIN_PARCELA_RECEBER;

    [TColumn('ID_FIN_CHEQUE_RECEBIDO','Id Cheque Recebido',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFinChequeRecebido: Integer  read FID_FIN_CHEQUE_RECEBIDO write FID_FIN_CHEQUE_RECEBIDO;
    [TColumn('CHEQUE.NUMERO', 'Número Cheque', 100, [ldGrid, ldLookup, ldComboBox], True, 'FIN_CHEQUE_RECEBIDO', 'ID_FIN_CHEQUE_RECEBIDO', 'ID')]
    property FinChequeRecebidoNumero: Integer read FFinChequeRecebidoNumero write FFinChequeRecebidoNumero;

    [TColumn('ID_FIN_TIPO_RECEBIMENTO','Id Tipo Recebimento',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFinTipoRecebimento: Integer  read FID_FIN_TIPO_RECEBIMENTO write FID_FIN_TIPO_RECEBIMENTO;
    [TColumn('TIPO_RECEBIMENTO.DESCRICAO', 'Tipo Recebimento Descrição', 100, [ldGrid, ldLookup, ldComboBox], True, 'FIN_TIPO_RECEBIMENTO', 'ID_FIN_TIPO_RECEBIMENTO', 'ID')]
    property FinTipoRecebimentoDescricao: String read FFinTipoRecebimentoDescricao write FFinTipoRecebimentoDescricao;

    [TColumn('ID_CONTA_CAIXA','Id Conta Caixa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    [TColumn('CONTA_CAIXA.NOME', 'Conta Caixa Nome', 100, [ldGrid, ldLookup, ldComboBox], True, 'CONTA_CAIXA', 'ID_CONTA_CAIXA', 'ID')]
    property ContaCaixaNome: String read FContaCaixaNome write FContaCaixaNome;

    [TColumn('DATA_RECEBIMENTO','Data Recebimento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataRecebimento: TDateTime  read FDATA_RECEBIMENTO write FDATA_RECEBIMENTO;
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
    [TColumn('VALOR_RECEBIDO','Valor Recebido',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorRecebido: Extended  read FVALOR_RECEBIDO write FVALOR_RECEBIDO;
    [TColumn('HISTORICO','Historico',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Historico: String  read FHISTORICO write FHISTORICO;

    [TAssociation(False, 'ID', 'ID_CONTA_CAIXA', 'CONTA_CAIXA')]
    property ContaCaixaVO: TContaCaixaVO read FContaCaixaVO write FContaCaixaVO;

    [TAssociation(False, 'ID', 'ID_FIN_TIPO_RECEBIMENTO', 'FIN_TIPO_RECEBIMENTO')]
    property FinTipoRecebimentoVO: TFinTipoRecebimentoVO read FFinTipoRecebimentoVO write FFinTipoRecebimentoVO;

    [TAssociation(False, 'ID', 'ID_FIN_CHEQUE_RECEBIDO', 'FIN_CHEQUE_RECEBIDO')]
    property FinChequeRecebidoVO: TFinChequeRecebidoVO read FFinChequeRecebidoVO write FFinChequeRecebidoVO;
  end;

implementation

destructor TFinParcelaRecebimentoVO.Destroy;
begin
  if Assigned(FContaCaixaVO) then
    FContaCaixaVO.Free;
  if Assigned(FFinTipoRecebimentoVO) then
    FFinTipoRecebimentoVO.Free;
  if Assigned(FFinChequeRecebidoVO) then
    FFinChequeRecebidoVO.Free;
  inherited;
end;

function TFinParcelaRecebimentoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ContaCaixaVO) then
      Self.ContaCaixaNome := Self.ContaCaixaVO.Nome;
    if Assigned(Self.FinTipoRecebimentoVO) then
      Self.FinTipoRecebimentoDescricao := Self.FinTipoRecebimentoVO.Descricao;
    if Assigned(Self.FinChequeRecebidoVO) then
      Self.FinChequeRecebidoNumero := Self.FinChequeRecebidoVO.Numero;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
