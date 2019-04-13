{ *******************************************************************************
  Title: T2Ti ERP
  Description: Controller do lado Servidor relacionado à tabela [Funcao]

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

  t2ti.com@gmail.com
  @author Fábio Thomaz (fabio_thz@yahoo.com.br) | Albert Eije (T2Ti.COM)
  @version 1.0
  ******************************************************************************* }
unit ListaPapelFuncaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon,
  PapelFuncaoVO;

type
  TListaPapelFuncaoController = class(TController)
  public
    function UpdateListaPapelFuncao(pSessao: String; pPapelFuncao: TJSONArray): TJSONArray;
  end;

implementation

uses
  T2TiORM, SA;

{ TFuncaoController }

var
  objPapelFuncao: TPapelFuncaoVO;

function TListaPapelFuncaoController.UpdateListaPapelFuncao(pSessao: String; pPapelFuncao: TJSONArray): TJSONArray;
var
  I: Integer;
  Filtro: String;
  ListaPapelFuncao: TObjectList<TPapelFuncaoVO>;
  FuncaoLista: TPapelFuncaoVO;
begin
  Result := TJSONArray.Create;

  try
    for I := 0 to pPapelFuncao.Size - 1 do
    begin
      objPapelFuncao := TPapelFuncaoVO.JSONToObject<TPapelFuncaoVO>(pPapelFuncao.Get(I));
      try
        Filtro := 'ID_PAPEL = ' + IntToStr(objPapelFuncao.IdPapel) + ' and ID_FUNCAO = ' + IntToStr(objPapelFuncao.IdFuncao);

        ListaPapelFuncao := TT2TiORM.Consultar<TPapelFuncaoVO>(Filtro, False);
        try
          if ListaPapelFuncao.Count = 0 then
          begin
            TT2TiORM.Inserir(objPapelFuncao);
          end
          else
          begin
            FuncaoLista := ListaPapelFuncao.Items[0];
            FuncaoLista.Habilitado := objPapelFuncao.Habilitado;
            TT2TiORM.Alterar(FuncaoLista);
          end;

          Result.AddElement(TJSOnString.Create('OK'));
        finally
          ListaPapelFuncao.Free;
        end;
      finally
        objPapelFuncao.Free;
      end;
    end;
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;
end;

end.
