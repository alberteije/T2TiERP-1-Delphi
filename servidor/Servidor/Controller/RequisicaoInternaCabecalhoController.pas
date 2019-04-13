{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [REQUISICAO_INTERNA_CABECALHO] 
                                                                                
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
unit RequisicaoInternaCabecalhoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TRequisicaoInternaCabecalhoController = class(TController)
  protected
  public
    //consultar
    function RequisicaoInternaCabecalho(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptRequisicaoInternaCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateRequisicaoInternaCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelRequisicaoInternaCabecalho(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  RequisicaoInternaCabecalhoVO, T2TiORM, SA, RequisicaoInternaDetalheVO, ControleEstoqueController;

{ TRequisicaoInternaCabecalhoController }

var
  objRequisicaoInternaCabecalho: TRequisicaoInternaCabecalhoVO;
  Resultado: Boolean;

function TRequisicaoInternaCabecalhoController.RequisicaoInternaCabecalho(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TRequisicaoInternaCabecalhoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TRequisicaoInternaCabecalhoVO>(pFiltro, pPagina, False);
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

function TRequisicaoInternaCabecalhoController.AcceptRequisicaoInternaCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  RequisicaoInternaDetalhe: TRequisicaoInternaDetalheVO;
  RequisicaoInternaDetalheEnumerator: TEnumerator<TRequisicaoInternaDetalheVO>;
begin
  objRequisicaoInternaCabecalho := TRequisicaoInternaCabecalhoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objRequisicaoInternaCabecalho);

      RequisicaoInternaDetalheEnumerator := objRequisicaoInternaCabecalho.ListaRequisicaoInterna.GetEnumerator;
      try
        with RequisicaoInternaDetalheEnumerator do
        begin
          while MoveNext do
          begin
            RequisicaoInternaDetalhe := Current;
            RequisicaoInternaDetalhe.IdReqInternaCabecalho := UltimoID;
            TT2TiORM.Inserir(RequisicaoInternaDetalhe);
          end;
        end;
      finally
        RequisicaoInternaDetalheEnumerator.Free;
      end;

      Result := RequisicaoInternaCabecalho(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objRequisicaoInternaCabecalho.Free;
  end;
end;

function TRequisicaoInternaCabecalhoController.UpdateRequisicaoInternaCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  RequisicaoInternaDetalheEnumerator: TEnumerator<TRequisicaoInternaDetalheVO>;
  objRequisicaoInternaCabecalhoOld: TRequisicaoInternaCabecalhoVO;
begin
 //Objeto Novo
  objRequisicaoInternaCabecalho := TRequisicaoInternaCabecalhoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objRequisicaoInternaCabecalhoOld := TRequisicaoInternaCabecalhoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objRequisicaoInternaCabecalho.MainObject.ToJSONString <> objRequisicaoInternaCabecalhoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objRequisicaoInternaCabecalho, objRequisicaoInternaCabecalhoOld);
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
      RequisicaoInternaDetalheEnumerator := objRequisicaoInternaCabecalho.ListaRequisicaoInterna.GetEnumerator;
      with RequisicaoInternaDetalheEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
            Resultado := TT2TiORM.Inserir(Current) > 0;

          // Atualiza estoque
          if objRequisicaoInternaCabecalho.Situacao = 'D' then
          begin
            TControleEstoqueController.Create().AtualizarEstoque(pSessao, Current.Quantidade * -1, Current.IdProduto);
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
    objRequisicaoInternaCabecalho.Free;
    RequisicaoInternaDetalheEnumerator.Free;
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TRequisicaoInternaCabecalhoController.CancelRequisicaoInternaCabecalho(pSessao: String; pId: Integer): TJSONArray;
begin
  objRequisicaoInternaCabecalho := TRequisicaoInternaCabecalhoVO.Create;
  Result := TJSONArray.Create;
  try
    objRequisicaoInternaCabecalho.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objRequisicaoInternaCabecalho);
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
    objRequisicaoInternaCabecalho.Free;
  end;
end;

end.
