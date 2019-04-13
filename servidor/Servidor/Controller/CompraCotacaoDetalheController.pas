{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [COMPRA_COTACAO_DETALHE] 
                                                                                
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
unit CompraCotacaoDetalheController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TCompraCotacaoDetalheController = class(TController)
  protected
  public
    //consultar
    function CompraCotacaoDetalhe(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    function CompraCotacaoDetalheDaCotacao(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptCompraCotacaoDetalhe(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateCompraCotacaoDetalhe(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelCompraCotacaoDetalhe(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  CompraCotacaoDetalheVO, T2TiORM, SA;

{ TCompraCotacaoDetalheController }

var
  objCompraCotacaoDetalhe: TCompraCotacaoDetalheVO;
  Resultado: Boolean;

function TCompraCotacaoDetalheController.CompraCotacaoDetalhe(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TCompraCotacaoDetalheVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TCompraCotacaoDetalheVO>(pFiltro, pPagina, False);
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

function TCompraCotacaoDetalheController.CompraCotacaoDetalheDaCotacao(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
var
  ConsultaSQL: String;
begin
  Result := TJSONArray.Create;
  try
    //para evitar essa consulta, pode-se criar uma view e criar o VO correspondente
    ConsultaSQL := 'select ' +
                   ' C.ID as ID_COTACAO, D.*, P.NOME AS "PRODUTO.NOME" ' +
                   'from ' +
                   ' COMPRA_COTACAO C ' +
                   ' INNER JOIN COMPRA_FORNECEDOR_COTACAO CF  ON (CF.ID_COMPRA_COTACAO = C.ID) ' +
                   ' INNER JOIN COMPRA_COTACAO_DETALHE D ON (D.ID_COMPRA_FORNECEDOR_COTACAO = CF.ID) ' +
                   ' INNER JOIN PRODUTO P ON (D.ID_PRODUTO = P.ID)';

    Result := TT2TiORM.Consultar<TCompraCotacaoDetalheVO>(ConsultaSQL, pFiltro, 0);

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

function TCompraCotacaoDetalheController.AcceptCompraCotacaoDetalhe(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objCompraCotacaoDetalhe := TCompraCotacaoDetalheVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objCompraCotacaoDetalhe);
      Result := CompraCotacaoDetalhe(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objCompraCotacaoDetalhe.Free;
  end;
end;

function TCompraCotacaoDetalheController.UpdateCompraCotacaoDetalhe(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objCompraCotacaoDetalheOld: TCompraCotacaoDetalheVO;
begin
 //Objeto Novo
  objCompraCotacaoDetalhe := TCompraCotacaoDetalheVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objCompraCotacaoDetalheOld := TCompraCotacaoDetalheVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objCompraCotacaoDetalhe, objCompraCotacaoDetalheOld);
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
    objCompraCotacaoDetalhe.Free;
  end;
end;

function TCompraCotacaoDetalheController.CancelCompraCotacaoDetalhe(pSessao: String; pId: Integer): TJSONArray;
begin
  objCompraCotacaoDetalhe := TCompraCotacaoDetalheVO.Create;
  Result := TJSONArray.Create;
  try
    objCompraCotacaoDetalhe.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objCompraCotacaoDetalhe);
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
    objCompraCotacaoDetalhe.Free;
  end;
end;

end.
