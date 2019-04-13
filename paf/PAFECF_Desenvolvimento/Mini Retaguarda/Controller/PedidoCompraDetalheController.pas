{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela PEDIDO_COMPRA_DETALHE

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
unit PedidoCompraDetalheController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, PedidoCompraDetalheVO, DBXCommon;

type
  TPedidoCompraDetalheController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer);
  end;

implementation

uses UDataModule, T2TiORM;

var
  PedidoCompraDetalhe: TPedidoCompraDetalheVO;

class procedure TPedidoCompraDetalheController.Consulta(pFiltro: String; pPagina: Integer);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      pFiltro := 'PCD.' + pFiltro;

      ConsultaSQL :=
          'select '+
          ' PCD.ID, PCD.ID_PRODUTO, PCD.ID_PEDIDO_COMPRA, PCD.QUANTIDADE, PCD.VALOR_UNITARIO, '+
          ' PCD.VALOR_SUBTOTAL, PCD.TAXA_DESCONTO, PCD.VALOR_DESCONTO, PCD.VALOR_TOTAL, P.NOME '+
          'from '+
          ' PEDIDO_COMPRA_DETALHE PCD, PRODUTO P '+
          'where '+
          ' PCD.ID_PRODUTO = P.ID';

      resultSet := TT2TiORM.Consultar(ConsultaSQL, pFiltro, pPagina);

      FDataModule.CDSPedidoCompraDetalhe.DisableControls;
      FDataModule.CDSPedidoCompraDetalhe.EmptyDataSet;
      while ResultSet.Next do
      begin
        FDataModule.CDSPedidoCompraDetalhe.Append;
        FDataModule.CDSPedidoCompraDetalhe.FieldByName('ID').AsInteger := resultSet.Value['ID'].AsInt32;
        FDataModule.CDSPedidoCompraDetalhe.FieldByName('ID_PRODUTO').AsInteger := resultSet.Value['ID_PRODUTO'].AsInt32;
        FDataModule.CDSPedidoCompraDetalhe.FieldByName('ID_PEDIDO_COMPRA').AsInteger := resultSet.Value['ID_PEDIDO_COMPRA'].AsInt32;
        FDataModule.CDSPedidoCompraDetalhe.FieldByName('QUANTIDADE').AsFloat := resultSet.Value['QUANTIDADE'].AsDouble;
        FDataModule.CDSPedidoCompraDetalhe.FieldByName('NOME').AsString := resultSet.Value['NOME'].AsString;
        FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_UNITARIO').AsFloat := resultSet.Value['VALOR_UNITARIO'].AsDouble;
        FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_SUBTOTAL').AsFloat := resultSet.Value['VALOR_SUBTOTAL'].AsDouble;
        FDataModule.CDSPedidoCompraDetalhe.FieldByName('TAXA_DESCONTO').AsFloat := resultSet.Value['TAXA_DESCONTO'].AsDouble;
        FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_DESCONTO').AsFloat := resultSet.Value['VALOR_DESCONTO'].AsDouble;
        FDataModule.CDSPedidoCompraDetalhe.FieldByName('VALOR_TOTAL').AsFloat := resultSet.Value['VALOR_TOTAL'].AsDouble;
        FDataModule.CDSPedidoCompraDetalhe.Post;
      end;
      FDataModule.CDSPedidoCompraDetalhe.Open;
      FDataModule.CDSPedidoCompraDetalhe.EnableControls;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

end.
