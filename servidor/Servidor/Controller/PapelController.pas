{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela PAPEL - Lado Servidor

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
           fabio_thz@yahoo.com.br | t2ti.com@gmail.com</p>

@author Fábio Thomaz
@version 1.0
*******************************************************************************}
unit PapelController;

interface

uses Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON,
  DBXCommon;

type
  TPapelController = class(TController)
  public
	  function Papel(pSessao: string; pFiltro: String; pPagina: Integer): TJSONArray;
    function AcceptPapel(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    function UpdatePapel(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    function CancelPapel(pSessao: string; pId: Integer): Boolean;
  end;

implementation

uses
  PapelVO, T2TiORM;

{ TPapelController }

var
  objPapel: TPapelVO;

function TPapelController.Papel(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TT2TiORM.Consultar<TPapelVO>(pFiltro,pPagina);
end;

function TPapelController.AcceptPapel(pSessao: string;
  pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  try
    try
      objPapel := TPapelVO.JSONToObject<TPapelVO>(pObjeto);
      UltimoID := TT2TiORM.Inserir(objPapel);
      Result := Papel(pSessao, 'ID='+IntToStr(UltimoID),0);
    except
      Result := TJSONArray.Create;
      raise;
    end;
  finally
  end;
end;

function TPapelController.UpdatePapel(pSessao: string; pObjeto: TJSONValue): TJSONArray;
var
  Filtro : String;
  Pagina : Integer;
begin
  try
    try
      objPapel := TPapelVO.JSONToObject<TPapelVO>((pObjeto as TJSONArray).Get(0));
      TT2TiORM.Alterar(objPapel);
      Filtro := (pObjeto as TJSONArray).Get(1).ToString;

      //retira as aspas do JSON
      Delete(Filtro, Length(Filtro), 1);
      Delete(Filtro, 1, 1);

      Pagina := StrToInt((pObjeto as TJSONArray).Get(2).ToString);

      result := Papel(pSessao, Filtro,Pagina);
    except
      Result := TJSONArray.Create;
      raise;
    end;
  finally
  end;
end;

function TPapelController.CancelPapel(pSessao: string; pId: Integer): Boolean;
begin
  try
    try
      objPapel := TPapelVO.Create;
      objPapel.Id := pId;
      TT2TiORM.Excluir(objPapel);
      Result := True;
    except
      result := False;
      raise;
    end;
  finally
    objPapel.Free;
  end;
end;

end.
