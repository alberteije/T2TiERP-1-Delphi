{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [IMPOSTO_ICMS]
                                                                                
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
unit ImpostoIcmsVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('IMPOSTO_ICMS')]
  TImpostoIcmsVO = class
  private
    FID: Integer;
    FCFOP: Integer;
    FCST_B: String;
    FALIQUOTA_ICMS: Double;
    FREDUCAO_BASE_CALCULO: Double;
    FCST_B_ECF: String;
    FTIPO_TRIBUTACAO_ECF: String;
    FALIQUOTA_ICMS_ECF: Double;
    FTOTALIZADOR_PARCIAL: String;
    FDESCRICAO: String;
    FECF_ICMS_ST: String;

  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('CFOP', 'CFOP', ldGrid, 8, true)]
    property Cfop: Integer  read FCFOP write FCFOP;
    [TColumn('CST_B', 'CST B', ldGridLookup, 8, true)]
    property CstB: String  read FCST_B write FCST_B;
    [TColumn('ALIQUOTA_ICMS', 'Aliquota ICMS', ldGridLookup, 10, true)]
    property AliquotaIcms: Double  read FALIQUOTA_ICMS write FALIQUOTA_ICMS;
    [TColumn('REDUCAO_BASE_CALCULO', 'Redução Base Calculo', ldGridLookup, 15, true)]
    property ReducaoBaseCalculo: Double  read FREDUCAO_BASE_CALCULO write FREDUCAO_BASE_CALCULO;
    [TColumn('CST_B_ECF', 'CST B ECF', ldGrid, 10, true)]
    property CstBEcf: String  read FCST_B_ECF write FCST_B_ECF;
    [TColumn('TIPO_TRIBUTACAO_ECF', 'Tipo Tributação ECF', ldGridLookup, 15, true)]
    property TipoTributacaoEcf: String  read FTIPO_TRIBUTACAO_ECF write FTIPO_TRIBUTACAO_ECF;
    [TColumn('ALIQUOTA_ICMS_ECF', 'Aliquota ICMS ECF', ldGridLookup, 15, true)]
    property AliquotaIcmsEcf: Double  read FALIQUOTA_ICMS_ECF write FALIQUOTA_ICMS_ECF;
    [TColumn('TOTALIZADOR_PARCIAL', 'Totalizador Parcial', ldGridLookup, 15, true)]
    property TotalizadorParcial: String  read FTOTALIZADOR_PARCIAL write FTOTALIZADOR_PARCIAL;
    [TColumn('DESCRICAO', 'Descrição', ldGridLookup, 50, true)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('ECF_ICMS_ST', 'ECF_ICMS_ST', ldGridLookup, 10, true)]
    property EcfIcmsST: String  read FECF_ICMS_ST write FECF_ICMS_ST;

  end;

implementation

end.
