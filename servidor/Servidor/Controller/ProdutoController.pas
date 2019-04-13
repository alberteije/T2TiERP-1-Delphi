{ *******************************************************************************
  Title: T2Ti ERP
  Description: Controller do lado Servidor relacionado à tabela [PRODUTO]

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

  @author Albert Eije (t2ti.com@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit ProdutoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon,
  Biblioteca, SWSystem;

type
  TProdutoController = class(TController)
  private
    procedure ArmazenarImagem;
  protected
  public
    // consultar
    function Produto(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptProduto(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateProduto(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelProduto(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ProdutoVO, T2TiORM, SA;

{ TProdutoController }

var
  objProduto: TProdutoVO;
  Resultado: Boolean;

function TProdutoController.Produto(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TProdutoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TProdutoVO>(pFiltro, pPagina, False);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(Result.ToString);
end;

function TProdutoController.AcceptProduto(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objProduto := TProdutoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objProduto);
      Result := Produto(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objProduto.Free;
  end;
end;

function TProdutoController.UpdateProduto(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objProdutoOld: TProdutoVO;
begin
  // Objeto Novo
  objProduto := TProdutoVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objProdutoOld := TProdutoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      // Se subiu uma imagem, armazena
      if objProduto.Imagem <> '' then
        ArmazenarImagem;

      // Limpa a imagem para saber se há mais alterações para efetuar no banco de dados
      objProduto.Imagem := '';
      objProduto.TipoImagem := '';

      // Se os objetos forem diferentes, realiza a alteração
      if TProdutoVO(objProduto).ToJSONString <> TProdutoVO(objProdutoOld).ToJSONString then
        Resultado := TT2TiORM.Alterar(objProduto, objProdutoOld);
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
    objProduto.Free;
  end;
end;

function TProdutoController.CancelProduto(pSessao: String; pId: Integer): TJSONArray;
begin
  objProduto := TProdutoVO.Create;
  Result := TJSONArray.Create;
  try
    objProduto.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objProduto);
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
    objProduto.Free;
  end;
end;

procedure TProdutoController.ArmazenarImagem;
var
  ArrayStringsArquivo: TStringList;
  ArquivoBytes: TBytes;
  ArquivoStream: TStringStream;
  i: Integer;
begin
  try
    ArrayStringsArquivo := TStringList.Create;
    Split(',', objProduto.Imagem, ArrayStringsArquivo);
    SetLength(ArquivoBytes, ArrayStringsArquivo.Count);
    for i := 0 to ArrayStringsArquivo.Count - 1 do
    begin
      ArquivoBytes[i] := StrToInt(ArrayStringsArquivo[i]);
    end;
    ArquivoStream := TStringStream.Create(ArquivoBytes);
    if not DirectoryExists(gsAppPath + 'Arquivos\Imagens')then
      CreateDir(gsAppPath + 'Arquivos\Imagens');
    if not DirectoryExists(gsAppPath + 'Arquivos\Imagens\Produtos')then
      CreateDir(gsAppPath + 'Arquivos\Imagens\Produtos');
    ArquivoStream.SaveToFile(gsAppPath + 'Arquivos\Imagens\Produtos\' + objProduto.Gtin + objProduto.TipoImagem);
  finally
    ArrayStringsArquivo.Free;
    ArquivoStream.Free;
  end;
end;

end.
