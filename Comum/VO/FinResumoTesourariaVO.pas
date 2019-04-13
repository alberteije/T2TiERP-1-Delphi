{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à view [FIN_RESUMO_TESOURARIA] 
                                                                                
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
unit FinResumoTesourariaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('FIN_RESUMO_TESOURARIA')]
  TFinResumoTesourariaVO = class(TJsonVO)
  private
    FID_CONTA_CAIXA: Integer;
    FNOME_CONTA_CAIXA: String;
    FNOME: String;
    FDATA_PAGO_RECEBIDO: TDateTime;
    FHISTORICO: String;
    FVALOR_PAGO: Extended;
    FDATA_LANCAMENTO: TDateTime;
    FDESCRICAO_NATUREZA_FINANCEIRA: String;
    FDESCRICAO_DOCUMENTO_ORIGEM: String;
    FOPERACAO: String;

  public 
    [TColumn('ID_CONTA_CAIXA','Id Conta Caixa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    [TColumn('NOME_CONTA_CAIXA','Nome Conta Caixa',400,[ldGrid, ldLookup, ldCombobox], False)]
    property NomeContaCaixa: String  read FNOME_CONTA_CAIXA write FNOME_CONTA_CAIXA;
    [TColumn('NOME','Nome',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DATA_PAGO_RECEBIDO','Data Pago Recebido',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataPagoRecebido: TDateTime  read FDATA_PAGO_RECEBIDO write FDATA_PAGO_RECEBIDO;
    [TColumn('HISTORICO','Historico',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Historico: String  read FHISTORICO write FHISTORICO;
    [TColumn('VALOR_PAGO','Valor Pago',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorPago: Extended  read FVALOR_PAGO write FVALOR_PAGO;
    [TColumn('DATA_LANCAMENTO','Data Lancamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataLancamento: TDateTime  read FDATA_LANCAMENTO write FDATA_LANCAMENTO;
    [TColumn('DESCRICAO_NATUREZA_FINANCEIRA','Descricao Natureza Financeira',450,[ldGrid, ldLookup, ldCombobox], False)]
    property DescricaoNaturezaFinanceira: String  read FDESCRICAO_NATUREZA_FINANCEIRA write FDESCRICAO_NATUREZA_FINANCEIRA;
    [TColumn('DESCRICAO_DOCUMENTO_ORIGEM','Descricao Documento Origem',450,[ldGrid, ldLookup, ldCombobox], False)]
    property DescricaoDocumentoOrigem: String  read FDESCRICAO_DOCUMENTO_ORIGEM write FDESCRICAO_DOCUMENTO_ORIGEM;
    [TColumn('OPERACAO','Operacao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Operacao: String  read FOPERACAO write FOPERACAO;

  end;

implementation



end.
