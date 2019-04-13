{*******************************************************************************
Title: T2Ti ERP
Description: Controller do lado Servidor relacionado à tabela [VIEW_COMPRA_MAPA_COMPARATIVO] 
                                                                                
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
unit ViewCompraMapaComparativoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TViewCompraMapaComparativoController = class(TController)
  protected
  public
    //consultar
    function ViewCompraMapaComparativo(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //alterar
    function UpdateGerarPedidos(pSessao: String; pObjeto: TJSONValue): TJSONArray;
  end;

implementation

uses
  ViewCompraMapaComparativoVO, CompraPedidoVO, CompraPedidoDetalheVO, CompraCotacaoVO,
  CompraCotacaoPedidoDetalheVO, CompraCotacaoDetalheVO, T2TiORM, SA;

{ TViewCompraMapaComparativoController }

var
  objViewCompraMapaComparativo: TViewCompraMapaComparativoVO;
  Resultado: Boolean;

function TViewCompraMapaComparativoController.ViewCompraMapaComparativo(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TViewCompraMapaComparativoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TViewCompraMapaComparativoVO>(pFiltro, pPagina, False);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(result.ToString);
end;

function TViewCompraMapaComparativoController.UpdateGerarPedidos(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  i: Integer;
  FornecedorAtual: Integer;
  ListaCompraMapaComparativoJson: TJSONValue;
  //
  CompraCotacao: TCompraCotacaoVO;
  CompraPedido: TCompraPedidoVO;
  CompraPedidoDetalhe: TCompraPedidoDetalheVO;
  CompraCotacaoPedidoDetalhe: TCompraCotacaoPedidoDetalheVO;
  CompraCotacaoDetalhe: TCompraCotacaoDetalheVO;
  //
  ListaCompraPedido: TObjectDictionary<Integer, TCompraPedidoVO>;
  CompraPedidoEnumerator: TEnumerator<TPair<Integer, TCompraPedidoVO>>;
  CompraPedidoDetalheEnumerator: TEnumerator<TCompraPedidoDetalheVO>;
  CompraCotacaoPedidoDetalheEnumerator: TEnumerator<TCompraCotacaoPedidoDetalheVO>;
begin
  // O primeiro item traz a lista de itens do mapa comparativo
  ListaCompraMapaComparativoJson := (pObjeto as TJSONArray).Get(0);

  Result := TJSONArray.Create;
  try
    try
      ListaCompraPedido := TObjectDictionary<Integer, TCompraPedidoVO>.Create;
      for i := 0 to (ListaCompraMapaComparativoJson as TJSONArray).Size - 1 do
      begin
        objViewCompraMapaComparativo := TViewCompraMapaComparativoVO.Create((ListaCompraMapaComparativoJson as TJSONArray).Get(i));
        // Se não existir o fornecedor atual no dicionário, insere e cria um novo pedido. Se existir, pega o pedido e insere o seu item
        if not ListaCompraPedido.ContainsKey(objViewCompraMapaComparativo.IdFornecedor) then
        begin
          CompraPedido := TCompraPedidoVO.Create;
          CompraPedido.ListaCompraPedidoDetalheVO := TObjectList<TCompraPedidoDetalheVO>.Create;
          CompraPedido.ListaCompraCotacaoPedidoDetalheVO := TObjectList<TCompraCotacaoPedidoDetalheVO>.Create;
          // Pedido vindo de cotação sempre será marcado como Normal
          CompraPedido.IdCompraTipoPedido := 1;
          CompraPedido.IdFornecedor := objViewCompraMapaComparativo.IdFornecedor;
          CompraPedido.DataPedido := Now;

          // Insere o item no pedido
          CompraPedidoDetalhe := TCompraPedidoDetalheVO.Create;
          CompraPedidoDetalhe.IdProduto := objViewCompraMapaComparativo.IdProduto;
          CompraPedidoDetalhe.Quantidade := objViewCompraMapaComparativo.QuantidadePedida;
          CompraPedidoDetalhe.ValorUnitario := objViewCompraMapaComparativo.ValorUnitario;
          CompraPedidoDetalhe.ValorSubtotal := objViewCompraMapaComparativo.ValorSubtotal;
          CompraPedidoDetalhe.TaxaDesconto := objViewCompraMapaComparativo.TaxaDesconto;
          CompraPedidoDetalhe.ValorDesconto := objViewCompraMapaComparativo.ValorDesconto;
          CompraPedidoDetalhe.ValorTotal := objViewCompraMapaComparativo.ValorTotal;
          CompraPedido.ListaCompraPedidoDetalheVO.Add(CompraPedidoDetalhe);

          // Insere o item da cotação que foi utilizado no pedido
          CompraCotacaoPedidoDetalhe := TCompraCotacaoPedidoDetalheVO.Create;
          CompraCotacaoPedidoDetalhe.IdCompraCotacaoDetalhe := objViewCompraMapaComparativo.IdCompraCotacaoDetalhe;
          CompraCotacaoPedidoDetalhe.QuantidadePedida := objViewCompraMapaComparativo.QuantidadePedida;
          CompraPedido.ListaCompraCotacaoPedidoDetalheVO.Add(CompraCotacaoPedidoDetalhe);

          // Insere o pedido no dicionário
          ListaCompraPedido.Add(objViewCompraMapaComparativo.IdFornecedor, CompraPedido);
        end
        else
        begin
          //Insere o item no pedido
          CompraPedidoDetalhe := TCompraPedidoDetalheVO.Create;
          CompraPedidoDetalhe.IdProduto := objViewCompraMapaComparativo.IdProduto;
          CompraPedidoDetalhe.Quantidade := objViewCompraMapaComparativo.QuantidadePedida;
          CompraPedidoDetalhe.ValorUnitario := objViewCompraMapaComparativo.ValorUnitario;
          CompraPedidoDetalhe.ValorSubtotal := objViewCompraMapaComparativo.ValorSubtotal;
          CompraPedidoDetalhe.TaxaDesconto := objViewCompraMapaComparativo.TaxaDesconto;
          CompraPedidoDetalhe.ValorDesconto := objViewCompraMapaComparativo.ValorDesconto;
          CompraPedidoDetalhe.ValorTotal := objViewCompraMapaComparativo.ValorTotal;
          //
          ListaCompraPedido.Items[objViewCompraMapaComparativo.IdFornecedor].ListaCompraPedidoDetalheVO.Add(CompraPedidoDetalhe);

          // Insere o item da cotação que foi utilizado no pedido
          CompraCotacaoPedidoDetalhe := TCompraCotacaoPedidoDetalheVO.Create;
          CompraCotacaoPedidoDetalhe.IdCompraCotacaoDetalhe := objViewCompraMapaComparativo.IdCompraCotacaoDetalhe;
          CompraCotacaoPedidoDetalhe.QuantidadePedida := objViewCompraMapaComparativo.QuantidadePedida;
          CompraPedido.ListaCompraCotacaoPedidoDetalheVO.Add(CompraCotacaoPedidoDetalhe);
        end;

        // Atualiza o detalhe da cotação no banco de dados
        CompraCotacaoDetalhe := TCompraCotacaoDetalheVO.Create;
        CompraCotacaoDetalhe.Id := objViewCompraMapaComparativo.IdCompraCotacaoDetalhe;
        CompraCotacaoDetalhe.QuantidadePedida := objViewCompraMapaComparativo.QuantidadePedida;
        TT2TiORM.Alterar(CompraCotacaoDetalhe);
      end;

      // Insere os pedidos no banco de dados
      CompraPedidoEnumerator := ListaCompraPedido.GetEnumerator;
      try
        with CompraPedidoEnumerator do
        begin
          while MoveNext do
          begin
            CompraPedido := Current.Value;
            UltimoID := TT2TiORM.Inserir(CompraPedido);

            // Insere os itens do pedido no banco de dados
            CompraPedidoDetalheEnumerator := CompraPedido.ListaCompraPedidoDetalheVO.GetEnumerator;
            with CompraPedidoDetalheEnumerator do
            begin
              while MoveNext do
              begin
                CompraPedidoDetalhe := Current;
                CompraPedidoDetalhe.IdCompraPedido := UltimoID;
                TT2TiORM.Inserir(CompraPedidoDetalhe);
              end;
            end;

            // Insere os items em COMPRA_COTACAO_PEDIDO_DETALHE
            CompraCotacaoPedidoDetalheEnumerator := CompraPedido.ListaCompraCotacaoPedidoDetalheVO.GetEnumerator;
            with CompraCotacaoPedidoDetalheEnumerator do
            begin
              while MoveNext do
              begin
                CompraCotacaoPedidoDetalhe := Current;
                CompraCotacaoPedidoDetalhe.IdCompraPedido := UltimoID;
                TT2TiORM.Inserir(CompraCotacaoPedidoDetalhe);
              end;
            end;
          end;
        end;
      finally
        CompraPedidoEnumerator.Free;
        CompraPedidoDetalheEnumerator.Free;
        CompraCotacaoPedidoDetalheEnumerator.Free;
      end;

      // Atualiza o campo SITUACAO da cotação para F - Fechada
      CompraCotacao := TCompraCotacaoVO.Create;
      CompraCotacao.Id := objViewCompraMapaComparativo.IdCompraCotacao;
      CompraCotacao.Situacao := 'F';
      Resultado := TT2TiORM.Alterar(CompraCotacao);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objViewCompraMapaComparativo.Free;
    CompraPedido.Free;
    ListaCompraPedido.Free;
  end;
end;

end.
