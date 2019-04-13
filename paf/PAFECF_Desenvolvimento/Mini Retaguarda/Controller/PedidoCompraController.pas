{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela PEDIDO_COMPRA

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
unit PedidoCompraController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, PedidoCompraVO,
  PedidoCompraDetalheVO, DBXCommon, Generics.Collections;

type
  TPedidoCompraController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer);
    class Procedure Insere(pPedidoCompra: TPedidoCompraVO; pListaPedido: TObjectList<TPedidoCompraDetalheVO>);
    class Procedure Altera(pPedidoCompra: TPedidoCompraVO; pListaPedido: TObjectList<TPedidoCompraDetalheVO>; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM;

var
  PedidoCompra: TPedidoCompraVO;

class procedure TPedidoCompraController.Consulta(pFiltro: String; pPagina: Integer);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      pFiltro := 'P.' + pFiltro;

      ConsultaSQL :=
          'select '+
          ' P.ID, P.ID_PESSOA, P.ID_COLABORADOR, P.DATA_PEDIDO, '+
          ' P.DATA_PREVISTA_ENTREGA, P.DATA_PREVISAO_PAGAMENTO, P.LOCAL_ENTREGA, P.LOCAL_COBRANCA, '+
          ' P.CONTATO, P.VALOR_SUBTOTAL, P.TAXA_DESCONTO, P.VALOR_DESCONTO, '+
          ' P.VALOR_TOTAL_PEDIDO, P.TIPO_FRETE, P.FORMA_PAGAMENTO, '+
          ' PE.NOME AS FORNECEDOR '+
          'from '+
          ' PEDIDO_COMPRA P, PESSOA PE, COLABORADOR COL '+
          'where '+
          ' P.ID_PESSOA = PE.ID and P.ID_COLABORADOR = COL.ID';

      resultSet := TT2TiORM.Consultar(ConsultaSQL, pFiltro, pPagina);

			FDataModule.CDSPedidoCompra.DisableControls;
			FDataModule.CDSPedidoCompra.EmptyDataSet;
			while ResultSet.Next do
			begin
				FDataModule.CDSPedidoCompra.Append;
        FDataModule.CDSPedidoCompra.FieldByName('ID').AsInteger := resultSet.Value['ID'].AsInt32;
        FDataModule.CDSPedidoCompra.FieldByName('ID_COLABORADOR').AsInteger := resultSet.Value['ID_COLABORADOR'].AsInt32;
        FDataModule.CDSPedidoCompra.FieldByName('ID_PESSOA').AsInteger := resultSet.Value['ID_PESSOA'].AsInt32;
        try
          FDataModule.CDSPedidoCompra.FieldByName('DATA_PEDIDO').AsString := resultSet.Value['DATA_PEDIDO'].AsString;
        except
          FDataModule.CDSPedidoCompra.FieldByName('DATA_PEDIDO').AsString := '';
        end;
        FDataModule.CDSPedidoCompra.FieldByName('FORNECEDOR').AsString := resultSet.Value['FORNECEDOR'].AsString;
        try
          FDataModule.CDSPedidoCompra.FieldByName('DATA_PREVISTA_ENTREGA').AsString := resultSet.Value['DATA_PREVISTA_ENTREGA'].AsString;
        except
          FDataModule.CDSPedidoCompra.FieldByName('DATA_PREVISTA_ENTREGA').AsString := '';
        end;
        try
          FDataModule.CDSPedidoCompra.FieldByName('DATA_PREVISAO_PAGAMENTO').AsString := resultSet.Value['DATA_PREVISAO_PAGAMENTO'].AsString;
        except
          FDataModule.CDSPedidoCompra.FieldByName('DATA_PREVISAO_PAGAMENTO').AsString := '';
        end;
        FDataModule.CDSPedidoCompra.FieldByName('FORNECEDOR').AsString := resultSet.Value['FORNECEDOR'].AsString;
        FDataModule.CDSPedidoCompra.FieldByName('LOCAL_ENTREGA').AsString := resultSet.Value['LOCAL_ENTREGA'].AsString;
        FDataModule.CDSPedidoCompra.FieldByName('LOCAL_COBRANCA').AsString := resultSet.Value['LOCAL_COBRANCA'].AsString;
        FDataModule.CDSPedidoCompra.FieldByName('CONTATO').AsString := resultSet.Value['CONTATO'].AsString;
        FDataModule.CDSPedidoCompra.FieldByName('TIPO_FRETE').AsString := resultSet.Value['TIPO_FRETE'].AsString;
        FDataModule.CDSPedidoCompra.FieldByName('FORMA_PAGAMENTO').AsString := resultSet.Value['FORMA_PAGAMENTO'].AsString;
        FDataModule.CDSPedidoCompra.FieldByName('VALOR_SUBTOTAL').AsFloat := resultSet.Value['VALOR_SUBTOTAL'].AsDouble;
        FDataModule.CDSPedidoCompra.FieldByName('TAXA_DESCONTO').AsFloat := resultSet.Value['TAXA_DESCONTO'].AsDouble;
        FDataModule.CDSPedidoCompra.FieldByName('VALOR_DESCONTO').AsFloat := resultSet.Value['VALOR_DESCONTO'].AsDouble;
        FDataModule.CDSPedidoCompra.FieldByName('VALOR_TOTAL_PEDIDO').AsFloat := resultSet.Value['VALOR_TOTAL_PEDIDO'].AsDouble;
				FDataModule.CDSPedidoCompra.Post;
			end;
			FDataModule.CDSPedidoCompra.Open;
			FDataModule.CDSPedidoCompra.EnableControls;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TPedidoCompraController.Insere(pPedidoCompra: TPedidoCompraVO; pListaPedido: TObjectList<TPedidoCompraDetalheVO>);
var
  I, UltimoID:Integer;
  PedidoDetalhe: TPedidoCompraDetalheVO;
begin
  try
    try
      DecimalSeparator := '.';
      UltimoID := TT2TiORM.Inserir(pPedidoCompra);

      for I := 0 to pListaPedido.Count - 1 do
      begin
        PedidoDetalhe := pListaPedido.Items[i];
        PedidoDetalhe.IdPedidoCompra := UltimoID;
        TT2TiORM.Inserir(PedidoDetalhe);
      end;

      DecimalSeparator := ',';
      Consulta('ID='+IntToStr(UltimoID),0);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TPedidoCompraController.Altera(pPedidoCompra: TPedidoCompraVO; pListaPedido: TObjectList<TPedidoCompraDetalheVO>; pFiltro: String; pPagina: Integer);
var
  I: Integer;
  PedidoDetalhe: TPedidoCompraDetalheVO;
begin
  try
    try
      DecimalSeparator := '.';
      TT2TiORM.Alterar(pPedidoCompra);

      for I := 0 to pListaPedido.Count - 1 do
      begin
        PedidoDetalhe := pListaPedido.Items[i];
        TT2TiORM.Alterar(PedidoDetalhe);
      end;

      DecimalSeparator := ',';
      Consulta(pFiltro, pPagina);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TPedidoCompraController.Exclui(pId: Integer);
begin
  try
    try
      PedidoCompra := TPedidoCompraVO.Create;
      PedidoCompra.Id := pId;
      TT2TiORM.Excluir(PedidoCompra);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
