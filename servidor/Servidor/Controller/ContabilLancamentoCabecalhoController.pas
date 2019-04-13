{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [CONTABIL_LANCAMENTO_CABECALHO] 
                                                                                
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
unit ContabilLancamentoCabecalhoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TContabilLancamentoCabecalhoController = class(TController)
  protected
  public
    //consultar
    function ContabilLancamentoCabecalho(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptContabilLancamentoCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateContabilLancamentoCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelContabilLancamentoCabecalho(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ContabilLancamentoCabecalhoVO, ContabilLancamentoDetalheVO, T2TiORM, SA;

{ TContabilLancamentoCabecalhoController }

var
  objContabilLancamentoCabecalho: TContabilLancamentoCabecalhoVO;
  Resultado: Boolean;

function TContabilLancamentoCabecalhoController.ContabilLancamentoCabecalho(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TContabilLancamentoCabecalhoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TContabilLancamentoCabecalhoVO>(pFiltro, pPagina, False);
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

function TContabilLancamentoCabecalhoController.AcceptContabilLancamentoCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  ContabilLancamentoDetalheVO: TContabilLancamentoDetalheVO;
  ContabilLancamentoDetalheEnumerator: TEnumerator<TContabilLancamentoDetalheVO>;
begin
  objContabilLancamentoCabecalho := TContabilLancamentoCabecalhoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objContabilLancamentoCabecalho);

      // Detalhes
      ContabilLancamentoDetalheEnumerator := objContabilLancamentoCabecalho.ListaContabilLancamentoDetalheVO.GetEnumerator;
      try
        with ContabilLancamentoDetalheEnumerator do
        begin
          while MoveNext do
          begin
            ContabilLancamentoDetalheVO := Current;
            ContabilLancamentoDetalheVO.IdContabilLancamentoCab := UltimoID;
            TT2TiORM.Inserir(ContabilLancamentoDetalheVO);
          end;
        end;
      finally
        ContabilLancamentoDetalheEnumerator.Free;
      end;

      Result := ContabilLancamentoCabecalho(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objContabilLancamentoCabecalho.Free;
  end;
end;

function TContabilLancamentoCabecalhoController.UpdateContabilLancamentoCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objContabilLancamentoCabecalhoOld: TContabilLancamentoCabecalhoVO;
  ContabilLancamentoDetalheEnumerator: TEnumerator<TContabilLancamentoDetalheVO>;
begin
 //Objeto Novo
  objContabilLancamentoCabecalho := TContabilLancamentoCabecalhoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objContabilLancamentoCabecalhoOld := TContabilLancamentoCabecalhoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objContabilLancamentoCabecalho.MainObject.ToJSONString <> objContabilLancamentoCabecalhoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objContabilLancamentoCabecalho, objContabilLancamentoCabecalhoOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Detalhes
    try
      ContabilLancamentoDetalheEnumerator := objContabilLancamentoCabecalho.ListaContabilLancamentoDetalheVO.GetEnumerator;
      with ContabilLancamentoDetalheEnumerator do
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
    ContabilLancamentoDetalheEnumerator.Free;
    objContabilLancamentoCabecalho.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TContabilLancamentoCabecalhoController.CancelContabilLancamentoCabecalho(pSessao: String; pId: Integer): TJSONArray;
begin
  objContabilLancamentoCabecalho := TContabilLancamentoCabecalhoVO.Create;
  Result := TJSONArray.Create;
  try
    objContabilLancamentoCabecalho.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objContabilLancamentoCabecalho);
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
    objContabilLancamentoCabecalho.Free;
  end;
end;

end.
