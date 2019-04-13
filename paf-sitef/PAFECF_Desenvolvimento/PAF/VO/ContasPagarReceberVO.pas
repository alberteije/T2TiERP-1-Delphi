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

type
  TContasPagarReceberVO = class
  private
    FID: Integer;
    FID_ECF_VENDA_CABECALHO: Integer;
    FID_PLANO_CONTAS: Integer;
    FID_TIPO_DOCUMENTO: Integer;
    FID_PESSOA: Integer;
    FTIPO: String;
    FNUMERO_DOCUMENTO: String;
    FVALOR: Extended;
    FDATA_LANCAMENTO: String;
    FPRIMEIRO_VENCIMENTO: String;
    FNATUREZA_LANCAMENTO: String;
    FQUANTIDADE_PARCELA: Integer;
    FDescricaoPlanoConta: String;
    FNomePessoa: String;
    FNomeTipoDocumento: String;

  public
    property Id: Integer  read FID write FID;
    property IdEcfVendaCabecalho: Integer  read FID_ECF_VENDA_CABECALHO write FID_ECF_VENDA_CABECALHO;
    property IdPlanoContas: Integer  read FID_PLANO_CONTAS write FID_PLANO_CONTAS;
    property IdTipoDocumento: Integer  read FID_TIPO_DOCUMENTO write FID_TIPO_DOCUMENTO;
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    property Tipo: String  read FTIPO write FTIPO;
    property NumeroDocumento: String  read FNUMERO_DOCUMENTO write FNUMERO_DOCUMENTO;
    property Valor: Extended  read FVALOR write FVALOR;
    property DataLancamento: String  read FDATA_LANCAMENTO write FDATA_LANCAMENTO;
    property PrimeiroVencimento: String  read FPRIMEIRO_VENCIMENTO write FPRIMEIRO_VENCIMENTO;
    property NaturezaLancamento: String  read FNATUREZA_LANCAMENTO write FNATUREZA_LANCAMENTO;
    property QuantidadeParcela: Integer  read FQUANTIDADE_PARCELA write FQUANTIDADE_PARCELA;
    property DescricaoPlanoConta: String  read FDescricaoPlanoConta write FDescricaoPlanoConta;
    property NomePessoa: String  read FNomePessoa write FNomePessoa;
    property NomeTipoDocumento: String  read FNomeTipoDocumento write FNomeTipoDocumento;

  end;

implementation



end.
