{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à view [MOVIMENTO_CAIXA_BANCO]
                                                                                
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
                                                                                
@author Albert Eije (T2Ti.COM)                                                  
@version 1.0                                                                    
*******************************************************************************}
unit MovimentoCaixaBancoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('MOVIMENTO_CAIXA_BANCO')]
  TMovimentoCaixaBancoVO = class
  private
    FID_CONTA_CAIXA: Integer;
    FNOME: String;
    FDATA_PAGAMENTO: String;
    FHISTORICO: String;
    FTOTAL_PARCELA: Extended;
    FDATA_LANCAMENTO: String;
    FDESCRICAO_PLANO_CONTAS: String;
    FNOME_TIPO_DOCUMENTO: String;
    FNATUREZA_LANCAMENTO: String;

  public 
    [TColumn('ID_CONTA_CAIXA')]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    [TColumn('NOME')]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DATA_PAGAMENTO')]
    property DataPagoRecebido: String  read FDATA_PAGAMENTO write FDATA_PAGAMENTO;
    [TColumn('HISTORICO')]
    property Historico: String  read FHISTORICO write FHISTORICO;
    [TColumn('VALOR_PAGO')]
    property ValorPago: Extended  read FTOTAL_PARCELA write FTOTAL_PARCELA;
    [TColumn('DATA_LANCAMENTO')]
    property DataLancamento: String  read FDATA_LANCAMENTO write FDATA_LANCAMENTO;
    [TColumn('DESCRICAO_PLANO_CONTAS')]
    property DescricaoPlanoContas: String  read FDESCRICAO_PLANO_CONTAS write FDESCRICAO_PLANO_CONTAS;
    [TColumn('NOME_TIPO_DOCUMENTO')]
    property DescricaoTipoDocumento: String  read FNOME_TIPO_DOCUMENTO write FNOME_TIPO_DOCUMENTO;
    [TColumn('NATUREZA_LANCAMENTO')]
    property NaturezaLancamento: String  read FNATUREZA_LANCAMENTO write FNATUREZA_LANCAMENTO;
  end;

implementation



end.
