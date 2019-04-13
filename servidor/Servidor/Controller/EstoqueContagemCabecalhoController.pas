{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [ESTOQUE_CONTAGEM_CABECALHO] 
                                                                                
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
unit EstoqueContagemCabecalhoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TEstoqueContagemCabecalhoController = class(TController)
  protected
  public
    //consultar
    function EstoqueContagemCabecalho(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptEstoqueContagemCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateEstoqueContagemCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelEstoqueContagemCabecalho(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  EstoqueContagemCabecalhoVO, T2TiORM, SA, EstoqueContagemDetalheVO, ProdutoVO;

{ TEstoqueContagemCabecalhoController }

var
  objEstoqueContagemCabecalho: TEstoqueContagemCabecalhoVO;
  Resultado: Boolean;

function TEstoqueContagemCabecalhoController.EstoqueContagemCabecalho(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TEstoqueContagemCabecalhoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TEstoqueContagemCabecalhoVO>(pFiltro, pPagina, False);
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

function TEstoqueContagemCabecalhoController.AcceptEstoqueContagemCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  EstoqueContagemDetalhe: TEstoqueContagemDetalheVO;
  EstoqueContagemDetalheEnumerator: TEnumerator<TEstoqueContagemDetalheVO>;
begin
  objEstoqueContagemCabecalho := TEstoqueContagemCabecalhoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objEstoqueContagemCabecalho);

      EstoqueContagemDetalheEnumerator := objEstoqueContagemCabecalho.ListaEstoqueContagemDetalheVO.GetEnumerator;
      try
        with EstoqueContagemDetalheEnumerator do
        begin
          while MoveNext do
          begin
            EstoqueContagemDetalhe := Current;
            EstoqueContagemDetalhe.IdEstoqueContagemCabecalho := UltimoID;
            TT2TiORM.Inserir(EstoqueContagemDetalhe);
          end;
        end;
      finally
        EstoqueContagemDetalheEnumerator.Free;
      end;

      Result := EstoqueContagemCabecalho(pSessao, 'ID = ' + IntToStr(UltimoID),0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objEstoqueContagemCabecalho.Free;
  end;
end;

function TEstoqueContagemCabecalhoController.UpdateEstoqueContagemCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  EstoqueContagemDetalheEnumerator: TEnumerator<TEstoqueContagemDetalheVO>;
  objEstoqueContagemCabecalhoOld: TEstoqueContagemCabecalhoVO;
  Produto: TProdutoVO;
begin
 //Objeto Novo
  objEstoqueContagemCabecalho := TEstoqueContagemCabecalhoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objEstoqueContagemCabecalhoOld := TEstoqueContagemCabecalhoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objEstoqueContagemCabecalho.MainObject.ToJSONString <> objEstoqueContagemCabecalhoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objEstoqueContagemCabecalho, objEstoqueContagemCabecalhoOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Detalhe
    try
      EstoqueContagemDetalheEnumerator := objEstoqueContagemCabecalho.ListaEstoqueContagemDetalheVO.GetEnumerator;
      with EstoqueContagemDetalheEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
            Resultado := TT2TiORM.Inserir(Current) > 0;

          // Atualiza Estoque
          if objEstoqueContagemCabecalho.EstoqueAtualizado = 'S' then
          begin
            Produto := TProdutoVO.Create;
            Produto.Id := Current.IdProduto;
            Produto.QuantidadeEstoque := Current.QuantidadeContada;
            Resultado := TT2TiORM.Alterar(Produto);
          end;
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
    objEstoqueContagemCabecalho.Free;
    EstoqueContagemDetalheEnumerator.Free;
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TEstoqueContagemCabecalhoController.CancelEstoqueContagemCabecalho(pSessao: String; pId: Integer): TJSONArray;
begin
  objEstoqueContagemCabecalho := TEstoqueContagemCabecalhoVO.Create;
  Result := TJSONArray.Create;
  try
    objEstoqueContagemCabecalho.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objEstoqueContagemCabecalho);
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
    objEstoqueContagemCabecalho.Free;
  end;
end;

end.
