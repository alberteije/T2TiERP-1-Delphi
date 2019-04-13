{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [CONTAS_PAGAR_RECEBER]
                                                                                
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
unit ContasPagarReceberVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('CONTAS_PAGAR_RECEBER')]
  TContasPagarReceberVO = class
  private
    FID: Integer;
    FID_PLANO_CONTAS: Integer;
    FID_PESSOA: Integer;
    FID_TIPO_DOCUMENTO: Integer;
    FTIPO: String;
    FNUMERO_DOCUMENTO: String;
    FVALOR: Extended;
    FDATA_LANCAMENTO: String;
    FPRIMEIRO_VENCIMENTO: String;
    FNATUREZA_LANCAMENTO: String;
    FQUANTIDADE_PARCELA: Integer;
    FIDENTIFICA: String;
    FID_CPR_ECF: Integer;

    FDescricaoPlanoConta: String;
    FNomePessoa: String;
    FNomeTipoDocumento: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_PLANO_CONTAS')]
    property IdPlanoContas: Integer  read FID_PLANO_CONTAS write FID_PLANO_CONTAS;
    [TColumn('ID_PESSOA')]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [TColumn('ID_TIPO_DOCUMENTO')]
    property IdTipoDocumento: Integer  read FID_TIPO_DOCUMENTO write FID_TIPO_DOCUMENTO;
    [TColumn('TIPO')]
    property Tipo: String  read FTIPO write FTIPO;
    [TColumn('NUMERO_DOCUMENTO')]
    property NumeroDocumento: String  read FNUMERO_DOCUMENTO write FNUMERO_DOCUMENTO;
    [TColumn('VALOR')]
    property Valor: Extended  read FVALOR write FVALOR;
    [TColumn('DATA_LANCAMENTO')]
    property DataLancamento: String  read FDATA_LANCAMENTO write FDATA_LANCAMENTO;
    [TColumn('PRIMEIRO_VENCIMENTO')]
    property PrimeiroVencimento: String  read FPRIMEIRO_VENCIMENTO write FPRIMEIRO_VENCIMENTO;
    [TColumn('NATUREZA_LANCAMENTO')]
    property NaturezaLancamento: String  read FNATUREZA_LANCAMENTO write FNATUREZA_LANCAMENTO;
    [TColumn('QUANTIDADE_PARCELA')]
    property QuantidadeParcela: Integer  read FQUANTIDADE_PARCELA write FQUANTIDADE_PARCELA;
    [TColumn('IDENTIFICA')]
    property Identifica: String  read FIDENTIFICA write FIDENTIFICA;
    [TColumn('ID_CPR_ECF')]
    property Idcprecf: Integer  read FID_CPR_ECF write FID_CPR_ECF;


    [TColumn('DESCRICAO_PLANO_CONTA','',True,True)]
    property DescricaoPlanoConta: String  read FDescricaoPlanoConta write FDescricaoPlanoConta;
    [TColumn('NOME_PESSOA','',True,True)]
    property NomePessoa: String  read FNomePessoa write FNomePessoa;
    [TColumn('NOME_TIPO_DOCUMENTO','',True,True)]
    property NomeTipoDocumento: String  read FNomeTipoDocumento write FNomeTipoDocumento;

  end;

implementation



end.
