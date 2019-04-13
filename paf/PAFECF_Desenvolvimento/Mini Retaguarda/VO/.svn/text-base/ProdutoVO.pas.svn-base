{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [PRODUTO]
                                                                                
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
unit ProdutoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('PRODUTO')]
  TProdutoVO = class
  private
    FID: Integer;
    FID_UNIDADE_PRODUTO: Integer;
    FGTIN: String;
    FCODIGO_INTERNO: String;
    FNOME: String;
    FDESCRICAO: String;
    FDESCRICAO_PDV: String;
    FVALOR_VENDA: Double;
    FQTD_ESTOQUE: Double;
    FQTD_ESTOQUE_ANTERIOR: Double;
    FESTOQUE_MIN: Double;
    FESTOQUE_MAX: Double;
    FIAT: String;
    FIPPT: String;
    FNCM: String;
    FTIPO_ITEM_SPED: String;
    FDATA_ESTOQUE: String;
    FTAXA_IPI: Double;
    FTAXA_ISSQN: Double;
    FTAXA_PIS: Double;
    FTAXA_COFINS: Double;
    FTAXA_ICMS: Double;
    FCST: String;
    FCSOSN: String;
    FTOTALIZADOR_PARCIAL: String;
    FECF_ICMS_ST: String;
    FCODIGO_BALANCA: Integer;
    FPAF_P_ST: String;
    FHASH_TRIPA: String;
    FID_IMPOSTO_ICMS: Integer;
    FDATA_ALTERACAO: String;
    FID_CST_A: Integer;
    FID_CST_B: Integer;
    FVALIDADE: Integer;
    FCUSTO_MEDIO: Double;
    FPRECO_CUSTO: Double;
    FPERCENTUAL_LUCRO: Double;
    FPERCENTUAL_DESCONTO: Double;
    FPERCENTUAL_COMISSAO: Double;
    FDATA_ULTIMA_NF: String;
    FNUMERO_ULTIMA_NF: String;
    FCNPJ_ULTIMO: String;
    FFORNECEDOR_ULTIMO: String;
    FVALOR_UN_NF: Double;
    FUNIDADE_COMPRA: String;
    FID_ITEM_SPED: Integer;

  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('ID_UNIDADE_PRODUTO','Id Unidade Produto',ldGrid ,10)]
    property IdUnidadeProduto: Integer  read FID_UNIDADE_PRODUTO write FID_UNIDADE_PRODUTO;
    [TColumn('GTIN','Gtin',ldGrid ,14)]
    property Gtin: String  read FGTIN write FGTIN;
    [TColumn('CODIGO_INTERNO','Codigo Interno',ldGrid ,20)]
    property CodigoInterno: String  read FCODIGO_INTERNO write FCODIGO_INTERNO;
    [TColumn('NOME','Nome',ldGrid ,30)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DESCRICAO','Descricao',ldGrid ,30)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('DESCRICAO_PDV','Descricao Pdv',ldGrid ,30)]
    property DescricaoPdv: String  read FDESCRICAO_PDV write FDESCRICAO_PDV;
    [TColumn('VALOR_VENDA','Valor Venda',ldGrid ,10)]
    property ValorVenda: Double  read FVALOR_VENDA write FVALOR_VENDA;
    [TColumn('QTD_ESTOQUE','Qtd Estoque',ldGrid ,10)]
    property QtdEstoque: Double  read FQTD_ESTOQUE write FQTD_ESTOQUE;
    [TColumn('QTD_ESTOQUE_ANTERIOR','Qtd Estoque Anterior',ldGrid ,10)]
    property QtdEstoqueAnterior: Double  read FQTD_ESTOQUE_ANTERIOR write FQTD_ESTOQUE_ANTERIOR;
    [TColumn('ESTOQUE_MIN','Estoque Min',ldGrid ,10)]
    property EstoqueMin: Double  read FESTOQUE_MIN write FESTOQUE_MIN;
    [TColumn('ESTOQUE_MAX','Estoque Max',ldGrid ,10)]
    property EstoqueMax: Double  read FESTOQUE_MAX write FESTOQUE_MAX;
    [TColumn('IAT','Iat',ldGrid ,10)]
    property Iat: String  read FIAT write FIAT;
    [TColumn('IPPT','Ippt',ldGrid ,10)]
    property Ippt: String  read FIPPT write FIPPT;
    [TColumn('NCM','Ncm',ldGrid ,10)]
    property Ncm: String  read FNCM write FNCM;
    [TColumn('TIPO_ITEM_SPED','Tipo Item Sped',ldGrid ,10)]
    property TipoItemSped: String  read FTIPO_ITEM_SPED write FTIPO_ITEM_SPED;
    [TColumn('DATA_ESTOQUE','Data Estoque',ldGrid ,10)]
    property DataEstoque: String  read FDATA_ESTOQUE write FDATA_ESTOQUE;
    [TColumn('TAXA_IPI','Taxa Ipi',ldGrid ,10)]
    property TaxaIpi: Double  read FTAXA_IPI write FTAXA_IPI;
    [TColumn('TAXA_ISSQN','Taxa Issqn',ldGrid ,10)]
    property TaxaIssqn: Double  read FTAXA_ISSQN write FTAXA_ISSQN;
    [TColumn('TAXA_PIS','Taxa Pis',ldGrid ,10)]
    property TaxaPis: Double  read FTAXA_PIS write FTAXA_PIS;
    [TColumn('TAXA_COFINS','Taxa Cofins',ldGrid ,10)]
    property TaxaCofins: Double  read FTAXA_COFINS write FTAXA_COFINS;
    [TColumn('TAXA_ICMS','Taxa Icms',ldGrid ,10)]
    property TaxaIcms: Double  read FTAXA_ICMS write FTAXA_ICMS;
    [TColumn('CST','Cst',ldGrid ,10)]
    property Cst: String  read FCST write FCST;
    [TColumn('CSOSN','Csosn',ldGrid ,10)]
    property Csosn: String  read FCSOSN write FCSOSN;
    [TColumn('TOTALIZADOR_PARCIAL','Totalizador Parcial',ldGrid ,10)]
    property TotalizadorParcial: String  read FTOTALIZADOR_PARCIAL write FTOTALIZADOR_PARCIAL;
    [TColumn('ECF_ICMS_ST','Ecf Icms St',ldGrid ,10)]
    property EcfIcmsSt: String  read FECF_ICMS_ST write FECF_ICMS_ST;
    [TColumn('CODIGO_BALANCA','Codigo Balanca',ldGrid ,10)]
    property CodigoBalanca: Integer  read FCODIGO_BALANCA write FCODIGO_BALANCA;
    [TColumn('PAF_P_ST','Paf P St',ldGrid ,10)]
    property PafPSt: String  read FPAF_P_ST write FPAF_P_ST;
    [TColumn('HASH_TRIPA','Hash Tripa',ldGrid ,10)]
    property HashTripa: String  read FHASH_TRIPA write FHASH_TRIPA;
    [TColumn('ID_IMPOSTO_ICMS','Id Imposto Icms',ldGrid ,10)]
    property IdImpostoIcms: Integer  read FID_IMPOSTO_ICMS write FID_IMPOSTO_ICMS;
    [TColumn('DATA_ALTERACAO','Data Alteracao',ldGrid ,10)]
    property DataAlteracao: String  read FDATA_ALTERACAO write FDATA_ALTERACAO;
    [TColumn('ID_CST_A','Id Cst A',ldGrid ,10)]
    property IdCstA: Integer  read FID_CST_A write FID_CST_A;
    [TColumn('ID_CST_B','Id Cst B',ldGrid ,10)]
    property IdCstB: Integer  read FID_CST_B write FID_CST_B;
    [TColumn('VALIDADE','Validade',ldGrid ,10)]
    property Validade: Integer  read FVALIDADE write FVALIDADE;
    [TColumn('CUSTO_MEDIO','Custo Medio',ldGrid ,10)]
    property CustoMedio: Double  read FCUSTO_MEDIO write FCUSTO_MEDIO;
    [TColumn('PRECO_CUSTO','Preco Custo',ldGrid ,10)]
    property PrecoCusto: Double  read FPRECO_CUSTO write FPRECO_CUSTO;
    [TColumn('PERCENTUAL_LUCRO','Percentual Lucro',ldGrid ,10)]
    property PercentualLucro: Double  read FPERCENTUAL_LUCRO write FPERCENTUAL_LUCRO;
    [TColumn('PERCENTUAL_DESCONTO','Percentual Desconto',ldGrid ,10)]
    property PercentualDesconto: Double  read FPERCENTUAL_DESCONTO write FPERCENTUAL_DESCONTO;
    [TColumn('PERCENTUAL_COMISSAO','Percentual Comissao',ldGrid ,10)]
    property PercentualComissao: Double  read FPERCENTUAL_COMISSAO write FPERCENTUAL_COMISSAO;
    [TColumn('DATA_ULTIMA_NF','Data Ultima Nf',ldGrid ,10)]
    property DataUltimaNf: String  read FDATA_ULTIMA_NF write FDATA_ULTIMA_NF;
    [TColumn('NUMERO_ULTIMA_NF','Numero Ultima Nf',ldGrid ,10)]
    property NumeroUltimaNf: String  read FNUMERO_ULTIMA_NF write FNUMERO_ULTIMA_NF;
    [TColumn('CNPJ_ULTIMO','Cnpj Ultimo',ldGrid ,10)]
    property CnpjUltimo: String  read FCNPJ_ULTIMO write FCNPJ_ULTIMO;
    [TColumn('FORNECEDOR_ULTIMO','Fornecedor Ultimo',ldGrid ,10)]
    property FornecedorUltimo: String  read FFORNECEDOR_ULTIMO write FFORNECEDOR_ULTIMO;
    [TColumn('VALOR_UN_NF','Valor Un Nf',ldGrid ,10)]
    property ValorUnNf: Double  read FVALOR_UN_NF write FVALOR_UN_NF;
    [TColumn('UNIDADE_COMPRA','Unidade Compra',ldGrid ,10)]
    property UnidadeCompra: String  read FUNIDADE_COMPRA write FUNIDADE_COMPRA;
    [TColumn('ID_ITEM_SPED','Id Item Sped',ldGrid ,10)]
    property IdItemSped: Integer  read FID_ITEM_SPED write FID_ITEM_SPED;

  end;



implementation



end.
