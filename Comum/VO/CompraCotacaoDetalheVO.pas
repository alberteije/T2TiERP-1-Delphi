{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [COMPRA_COTACAO_DETALHE] 
                                                                                
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
unit CompraCotacaoDetalheVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ProdutoVO, CompraReqCotacaoDetalheVO;

type
  [TEntity]
  [TTable('COMPRA_COTACAO_DETALHE')]
  TCompraCotacaoDetalheVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COMPRA_FORNECEDOR_COTACAO: Integer;
    FID_PRODUTO: Integer;
    FQUANTIDADE: Extended;
    FQUANTIDADE_PEDIDA: Extended;
    FVALOR_UNITARIO: Extended;
    FVALOR_SUBTOTAL: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_TOTAL: Extended;

    FProdutoNome: String;

    FProdutoVO: TProdutoVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_COMPRA_FORNECEDOR_COTACAO','Id Compra Fornecedor Cotacao',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdCompraFornecedorCotacao: Integer  read FID_COMPRA_FORNECEDOR_COTACAO write FID_COMPRA_FORNECEDOR_COTACAO;

    [TColumn('ID_PRODUTO','Id Produto',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    [TColumn('PRODUTO.NOME', 'Produto Nome', 100, [ldGrid, ldLookup, ldComboBox], True, 'PRODUTO', 'ID_PRODUTO', 'ID')]
    property ProdutoNome: String read FProdutoNome write FProdutoNome;

    [TColumn('QUANTIDADE','Quantidade',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Quantidade: Extended  read FQUANTIDADE write FQUANTIDADE;
    [TColumn('QUANTIDADE_PEDIDA','Quantidade Pedida',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property QuantidadePedida: Extended  read FQUANTIDADE_PEDIDA write FQUANTIDADE_PEDIDA;
    [TColumn('VALOR_UNITARIO','Valor Unitario',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorUnitario: Extended  read FVALOR_UNITARIO write FVALOR_UNITARIO;
    [TColumn('VALOR_SUBTOTAL','Valor Subtotal',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorSubtotal: Extended  read FVALOR_SUBTOTAL write FVALOR_SUBTOTAL;
    [TColumn('TAXA_DESCONTO','Taxa Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    [TColumn('VALOR_DESCONTO','Valor Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('VALOR_TOTAL','Valor Total',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;

    [TAssociation(False, 'ID', 'ID_PRODUTO', 'PRODUTO')]
    property ProdutoVO: TProdutoVO read FProdutoVO write FProdutoVO;

  end;

implementation

destructor TCompraCotacaoDetalheVO.Destroy;
begin
  if Assigned(FProdutoVO) then
    FProdutoVO.Free;

  inherited;
end;

function TCompraCotacaoDetalheVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ProdutoVO) then
      Self.ProdutoNome := Self.ProdutoVO.Nome;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
