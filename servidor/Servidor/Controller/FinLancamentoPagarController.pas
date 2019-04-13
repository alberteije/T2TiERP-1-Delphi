{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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
unit FinLancamentoPagarController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFinLancamentoPagarController = class(TController)
  protected
  public
    //consultar
    function FinLancamentoPagar(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFinLancamentoPagar(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFinLancamentoPagar(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFinLancamentoPagar(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FinLancamentoPagarVO, T2TiORM, SA, FinParcelaPagarVO, FinLctoPagarNtFinanceiraVO;

{ TFinLancamentoPagarController }

var
  objFinLancamentoPagar: TFinLancamentoPagarVO;
  Resultado: Boolean;

function TFinLancamentoPagarController.FinLancamentoPagar(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFinLancamentoPagarVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFinLancamentoPagarVO>(pFiltro, pPagina, False);
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

function TFinLancamentoPagarController.AcceptFinLancamentoPagar(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  ParcelaPagar: TFinParcelaPagarVO;
  ParcelaPagarEnumerator: TEnumerator<TFinParcelaPagarVO>;
  LancamentoNaturezaFinanceira: TFinLctoPagarNtFinanceiraVO;
  LancamentoNaturezaFinanceiraEnumerator: TEnumerator<TFinLctoPagarNtFinanceiraVO>;
begin
  objFinLancamentoPagar := TFinLancamentoPagarVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFinLancamentoPagar);

      // Parcela Pagar
      ParcelaPagarEnumerator := objFinLancamentoPagar.ListaParcelaPagarVO.GetEnumerator;
      try
        with ParcelaPagarEnumerator do
        begin
          while MoveNext do
          begin
            ParcelaPagar := Current;
            ParcelaPagar.IdFinLancamentoPagar := UltimoID;
            TT2TiORM.Inserir(ParcelaPagar);
          end;
        end;
      finally
        ParcelaPagarEnumerator.Free;
      end;

      // Natureza Financeira
      LancamentoNaturezaFinanceiraEnumerator := objFinLancamentoPagar.ListaLancPagarNatFinanceiraVO.GetEnumerator;
      try
        with LancamentoNaturezaFinanceiraEnumerator do
        begin
          while MoveNext do
          begin
            LancamentoNaturezaFinanceira := Current;
            LancamentoNaturezaFinanceira.IdFinLancamentoPagar := UltimoID;
            TT2TiORM.Inserir(LancamentoNaturezaFinanceira);
          end;
        end;
      finally
        LancamentoNaturezaFinanceiraEnumerator.Free;
      end;

      Result := FinLancamentoPagar(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFinLancamentoPagar.Free;
  end;
end;

function TFinLancamentoPagarController.UpdateFinLancamentoPagar(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objFinLancamentoPagarOld: TFinLancamentoPagarVO;
  ParcelaPagarEnumerator: TEnumerator<TFinParcelaPagarVO>;
  LancamentoNaturezaFinanceiraEnumerator: TEnumerator<TFinLctoPagarNtFinanceiraVO>;
begin
 //Objeto Novo
  objFinLancamentoPagar := TFinLancamentoPagarVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objFinLancamentoPagarOld := TFinLancamentoPagarVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objFinLancamentoPagar.MainObject.ToJSONString <> objFinLancamentoPagarOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objFinLancamentoPagar, objFinLancamentoPagarOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Parcela Pagar
    try
      ParcelaPagarEnumerator := objFinLancamentoPagar.ListaParcelaPagarVO.GetEnumerator;
      with ParcelaPagarEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
          begin
            Current.IdFinLancamentoPagar := objFinLancamentoPagar.Id;
            Resultado := TT2TiORM.Inserir(Current) > 0;
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

    // Natureza Financeira
    try
      LancamentoNaturezaFinanceiraEnumerator := objFinLancamentoPagar.ListaLancPagarNatFinanceiraVO.GetEnumerator;
      with LancamentoNaturezaFinanceiraEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
          begin
            Current.IdFinLancamentoPagar := objFinLancamentoPagar.Id;
            Resultado := TT2TiORM.Inserir(Current) > 0;
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
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    ParcelaPagarEnumerator.Free;
    LancamentoNaturezaFinanceiraEnumerator.Free;
    objFinLancamentoPagar.Free;
  end;
end;

function TFinLancamentoPagarController.CancelFinLancamentoPagar(pSessao: String; pId: Integer): TJSONArray;
begin
  objFinLancamentoPagar := TFinLancamentoPagarVO.Create;
  Result := TJSONArray.Create;
  try
    objFinLancamentoPagar.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFinLancamentoPagar);
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
    objFinLancamentoPagar.Free;
  end;
end;

end.
