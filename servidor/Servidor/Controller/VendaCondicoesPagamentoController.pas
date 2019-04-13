{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [VENDA_CONDICOES_PAGAMENTO] 
                                                                                
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
unit VendaCondicoesPagamentoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TVendaCondicoesPagamentoController = class(TController)
  protected
  public
    //consultar
    function VendaCondicoesPagamento(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptVendaCondicoesPagamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateVendaCondicoesPagamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelVendaCondicoesPagamento(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  VendaCondicoesPagamentoVO, T2TiORM, SA, VendaCondicoesParcelasVO;

{ TVendaCondicoesPagamentoController }

var
  objVendaCondicoesPagamento: TVendaCondicoesPagamentoVO;
  Resultado: Boolean;

function TVendaCondicoesPagamentoController.VendaCondicoesPagamento(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TVendaCondicoesPagamentoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TVendaCondicoesPagamentoVO>(pFiltro, pPagina, False);
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

function TVendaCondicoesPagamentoController.AcceptVendaCondicoesPagamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  CondicoesParcelas: TVendaCondicoesParcelasVO;
  CondicoesParcelassEnumerator: TEnumerator<TVendaCondicoesParcelasVO>;
begin
  objVendaCondicoesPagamento := TVendaCondicoesPagamentoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objVendaCondicoesPagamento);

      // Condições Parcela
      CondicoesParcelassEnumerator := objVendaCondicoesPagamento.ListaVendaCondicoesParcelasVO.GetEnumerator;
      try
        with CondicoesParcelassEnumerator do
        begin
          while MoveNext do
          begin
            CondicoesParcelas := Current;
            CondicoesParcelas.IdVendaCondicoesPagamento := UltimoID;
            TT2TiORM.Inserir(CondicoesParcelas);
          end;
        end;
      finally
        CondicoesParcelassEnumerator.Free;
      end;

      Result := VendaCondicoesPagamento(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objVendaCondicoesPagamento.Free;
  end;
end;

function TVendaCondicoesPagamentoController.UpdateVendaCondicoesPagamento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  CondicoesParcelasEnumerator: TEnumerator<TVendaCondicoesParcelasVO>;
  objVendaCondicoesPagamentoOld: TVendaCondicoesPagamentoVO;
begin
 //Objeto Novo
  objVendaCondicoesPagamento := TVendaCondicoesPagamentoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objVendaCondicoesPagamentoOld := TVendaCondicoesPagamentoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    // Verifica se houve alterações no objeto principal
    if objVendaCondicoesPagamento.MainObject.ToJSONString <> objVendaCondicoesPagamentoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objVendaCondicoesPagamento, objVendaCondicoesPagamentoOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Condicoes Parcela
    try
      CondicoesParcelasEnumerator := objVendaCondicoesPagamento.ListaVendaCondicoesParcelasVO.GetEnumerator;
      with CondicoesParcelasEnumerator do
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
    CondicoesParcelasEnumerator.Free;
    objVendaCondicoesPagamento.Free;

    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
 end;

function TVendaCondicoesPagamentoController.CancelVendaCondicoesPagamento(pSessao: String; pId: Integer): TJSONArray;
begin
  objVendaCondicoesPagamento := TVendaCondicoesPagamentoVO.Create;
  Result := TJSONArray.Create;
  try
    objVendaCondicoesPagamento.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objVendaCondicoesPagamento);
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
    objVendaCondicoesPagamento.Free;
  end;
end;

end.
