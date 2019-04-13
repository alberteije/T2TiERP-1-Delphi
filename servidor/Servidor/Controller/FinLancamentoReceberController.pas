{*******************************************************************************
Title: T2Ti ERP
Description: Controller do lado Servidor relacionado à tabela [FIN_LANCAMENTO_RECEBER]

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
unit FinLancamentoReceberController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFinLancamentoReceberController = class(TController)
  protected
  public
    //consultar
    function FinLancamentoReceber(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFinLancamentoReceber(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFinLancamentoReceber(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFinLancamentoReceber(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FinLancamentoReceberVO, T2TiORM, SA, FinParcelaReceberVO, FinLctoReceberNtFinanceiraVO;

{ TFinLancamentoReceberController }

var
  objFinLancamentoReceber: TFinLancamentoReceberVO;
  Resultado: Boolean;

function TFinLancamentoReceberController.FinLancamentoReceber(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFinLancamentoReceberVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFinLancamentoReceberVO>(pFiltro, pPagina, False);
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

function TFinLancamentoReceberController.AcceptFinLancamentoReceber(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  ParcelaReceber: TFinParcelaReceberVO;
  ParcelaReceberEnumerator: TEnumerator<TFinParcelaReceberVO>;
  LancamentoNaturezaFinanceira: TFinLctoReceberNtFinanceiraVO;
  LancamentoNaturezaFinanceiraEnumerator: TEnumerator<TFinLctoReceberNtFinanceiraVO>;
begin
  objFinLancamentoReceber := TFinLancamentoReceberVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFinLancamentoReceber);

      // Parcela Receber
      ParcelaReceberEnumerator := objFinLancamentoReceber.ListaParcelaReceberVO.GetEnumerator;
      try
        with ParcelaReceberEnumerator do
        begin
          while MoveNext do
          begin
            ParcelaReceber := Current;
            ParcelaReceber.IdFinLancamentoReceber := UltimoID;
            TT2TiORM.Inserir(ParcelaReceber);
          end;
        end;
      finally
        ParcelaReceberEnumerator.Free;
      end;

      // Natureza Financeira
      LancamentoNaturezaFinanceiraEnumerator := objFinLancamentoReceber.ListaLancReceberNatFinanceiraVO.GetEnumerator;
      try
        with LancamentoNaturezaFinanceiraEnumerator do
        begin
          while MoveNext do
          begin
            LancamentoNaturezaFinanceira := Current;
            LancamentoNaturezaFinanceira.IdFinLancamentoReceber := UltimoID;
            TT2TiORM.Inserir(LancamentoNaturezaFinanceira);
          end;
        end;
      finally
        LancamentoNaturezaFinanceiraEnumerator.Free;
      end;

      Result := FinLancamentoReceber(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFinLancamentoReceber.Free;
  end;
end;

function TFinLancamentoReceberController.UpdateFinLancamentoReceber(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objFinLancamentoReceberOld: TFinLancamentoReceberVO;
  ParcelaReceberEnumerator: TEnumerator<TFinParcelaReceberVO>;
  LancamentoNaturezaFinanceiraEnumerator: TEnumerator<TFinLctoReceberNtFinanceiraVO>;
begin
 //Objeto Novo
  objFinLancamentoReceber := TFinLancamentoReceberVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objFinLancamentoReceberOld := TFinLancamentoReceberVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objFinLancamentoReceber.MainObject.ToJSONString <> objFinLancamentoReceberOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objFinLancamentoReceber, objFinLancamentoReceberOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Parcela Receber
    try
      ParcelaReceberEnumerator := objFinLancamentoReceber.ListaParcelaReceberVO.GetEnumerator;
      with ParcelaReceberEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
          begin
            Current.IdFinLancamentoReceber := objFinLancamentoReceber.Id;
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
      LancamentoNaturezaFinanceiraEnumerator := objFinLancamentoReceber.ListaLancReceberNatFinanceiraVO.GetEnumerator;
      with LancamentoNaturezaFinanceiraEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
          begin
            Current.IdFinLancamentoReceber := objFinLancamentoReceber.Id;
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
    ParcelaReceberEnumerator.Free;
    LancamentoNaturezaFinanceiraEnumerator.Free;
    objFinLancamentoReceber.Free;
  end;
end;

function TFinLancamentoReceberController.CancelFinLancamentoReceber(pSessao: String; pId: Integer): TJSONArray;
begin
  objFinLancamentoReceber := TFinLancamentoReceberVO.Create;
  Result := TJSONArray.Create;
  try
    objFinLancamentoReceber.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFinLancamentoReceber);
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
    objFinLancamentoReceber.Free;
  end;
end;

end.
