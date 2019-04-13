{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [COMPRA_REQUISICAO] 
                                                                                
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
                                                                                
t2ti.com@gmail.com | fernandololiver@gmail.com
@author Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0
*******************************************************************************}
unit CompraRequisicaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TCompraRequisicaoController = class(TController)
  protected
  public
    // consultar
    function CompraRequisicao(pSessao: string; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptCompraRequisicao(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateCompraRequisicao(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelCompraRequisicao(pSessao: string; pId: Integer): TJSONArray;
  end;

implementation

uses
  CompraRequisicaoVO, T2TiORM, Biblioteca, CompraRequisicaoDetalheVO, SA;

{ TCompraRequisicaoController }

var
  objCompraRequisicao: TCompraRequisicaoVO;
  Resultado: Boolean;

function TCompraRequisicaoController.CompraRequisicao(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TCompraRequisicaoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TCompraRequisicaoVO>(pFiltro, pPagina, False);
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

function TCompraRequisicaoController.AcceptCompraRequisicao(pSessao: string; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  CompraRequisicaoDetalhe: TCompraRequisicaoDetalheVO;
  CompraRequisicaoDetalheEnumerator: TEnumerator<TCompraRequisicaoDetalheVO>;
begin
  objCompraRequisicao := TCompraRequisicaoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objCompraRequisicao);

      // Requisição Detalhe
      CompraRequisicaoDetalheEnumerator := objCompraRequisicao.ListaCompraRequisicaoDetalheVO.GetEnumerator;
      try
        with CompraRequisicaoDetalheEnumerator do
        begin
          while MoveNext do
          begin
            CompraRequisicaoDetalhe := Current;
            CompraRequisicaoDetalhe.IdCompraRequisicao := UltimoID;
            TT2TiORM.Inserir(CompraRequisicaoDetalhe);
          end;
        end;
      finally
        CompraRequisicaoDetalheEnumerator.Free;
      end;

    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

  finally
    objCompraRequisicao.Free;
  end;

  Result := CompraRequisicao(pSessao, 'ID=' + IntToStr(UltimoID), 0);
end;

function TCompraRequisicaoController.UpdateCompraRequisicao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  CompraRequisicaoDetalheEnumerator: TEnumerator<TCompraRequisicaoDetalheVO>;
  objCompraRequisicaoOld: TCompraRequisicaoVO;
begin
  // Objeto Novo
  objCompraRequisicao := TCompraRequisicaoVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objCompraRequisicaoOld := TCompraRequisicaoVO.Create((pObjeto as TJSONArray).Get(1));

  Result := TJSONArray.Create;
  try
    // Verifica se houve alterações no objeto principal
    if objCompraRequisicao.MainObject.ToJSONString <> objCompraRequisicaoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objCompraRequisicao, objCompraRequisicaoOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Requisição Detalhe
    try
      CompraRequisicaoDetalheEnumerator := objCompraRequisicao.ListaCompraRequisicaoDetalheVO.GetEnumerator;
      with CompraRequisicaoDetalheEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
            Resultado := TT2TiORM.Inserir(Current) > 0;
        end;
      end;
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

  finally
    CompraRequisicaoDetalheEnumerator.Free;
    objCompraRequisicao.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TCompraRequisicaoController.CancelCompraRequisicao(pSessao: string; pId: Integer): TJSONArray;
begin
  objCompraRequisicao := TCompraRequisicaoVO.Create;
  Result := TJSONArray.Create;
  try
    objCompraRequisicao.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objCompraRequisicao);
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
    objCompraRequisicao.Free;
  end;
end;

end.
