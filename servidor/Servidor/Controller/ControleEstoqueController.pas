{ *******************************************************************************
  Title: T2Ti ERP
  Description: Unit que controla o estoque (incremento e decremento)

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
  ******************************************************************************* }
unit ControleEstoqueController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon,
  SWSystem;

type
  TControleEstoqueController = class(TController)
  protected
  public
    function AtualizarEstoque(pSessao: String; pQuantidade: Extended; pIdProduto: Integer): TJSONArray;
  end;

implementation

uses
  T2TiORM, SA;

function TControleEstoqueController.AtualizarEstoque(pSessao: String; pQuantidade: Extended; pIdProduto: Integer): TJSONArray;
var
  ComandoSQL: String;
begin
  try
    try
      Result := TJSONArray.Create;

      //atualiza tabela PRODUTO
      ComandoSQL := 'update PRODUTO set QUANTIDADE_ESTOQUE = QUANTIDADE_ESTOQUE + ' + FloatToStr(pQuantidade) + ' where ID= ' + IntToStr(pIdProduto);
      TT2TiORM.ComandoSQL(ComandoSQL);

      //atualiza tabela PRODUTO_LOTE
      (*
        Cada participante deve avaliar como atualizar essa tabela de acordo com sua necessidade.
      *)

      Result.AddElement(TJSONTrue.Create);
    except
      on E: Exception do
      begin
        result.AddElement(TJSONString.Create('ERRO'));
        result.AddElement(TJSONString.Create(E.Message));
      end;
    end;
  finally
  end;
end;

end.
