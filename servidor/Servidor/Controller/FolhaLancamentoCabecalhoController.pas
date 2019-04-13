{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [FOLHA_LANCAMENTO_CABECALHO] 
                                                                                
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
unit FolhaLancamentoCabecalhoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFolhaLancamentoCabecalhoController = class(TController)
  protected
  public
    //consultar
    function FolhaLancamentoCabecalho(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFolhaLancamentoCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFolhaLancamentoCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFolhaLancamentoCabecalho(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FolhaLancamentoCabecalhoVO, FolhaLancamentoDetalheVO, T2TiORM, SA;

{ TFolhaLancamentoCabecalhoController }

var
  objFolhaLancamentoCabecalho: TFolhaLancamentoCabecalhoVO;
  Resultado: Boolean;

function TFolhaLancamentoCabecalhoController.FolhaLancamentoCabecalho(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFolhaLancamentoCabecalhoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFolhaLancamentoCabecalhoVO>(pFiltro, pPagina, False);
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

function TFolhaLancamentoCabecalhoController.AcceptFolhaLancamentoCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  FolhaLancamentoDetalheVO: TFolhaLancamentoDetalheVO;
  FolhaLancamentoDetalheEnumerator: TEnumerator<TFolhaLancamentoDetalheVO>;
begin
  objFolhaLancamentoCabecalho := TFolhaLancamentoCabecalhoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFolhaLancamentoCabecalho);

      // Detalhes
      FolhaLancamentoDetalheEnumerator := objFolhaLancamentoCabecalho.ListaFolhaLancamentoDetalheVO.GetEnumerator;
      try
        with FolhaLancamentoDetalheEnumerator do
        begin
          while MoveNext do
          begin
            FolhaLancamentoDetalheVO := Current;
            FolhaLancamentoDetalheVO.IdFolhaLancamentoCabecalho := UltimoID;
            TT2TiORM.Inserir(FolhaLancamentoDetalheVO);
          end;
        end;
      finally
        FolhaLancamentoDetalheEnumerator.Free;
      end;

      Result := FolhaLancamentoCabecalho(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFolhaLancamentoCabecalho.Free;
  end;
end;

function TFolhaLancamentoCabecalhoController.UpdateFolhaLancamentoCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objFolhaLancamentoCabecalhoOld: TFolhaLancamentoCabecalhoVO;
  FolhaLancamentoDetalheEnumerator: TEnumerator<TFolhaLancamentoDetalheVO>;
begin
 //Objeto Novo
  objFolhaLancamentoCabecalho := TFolhaLancamentoCabecalhoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objFolhaLancamentoCabecalhoOld := TFolhaLancamentoCabecalhoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objFolhaLancamentoCabecalho.MainObject.ToJSONString <> objFolhaLancamentoCabecalhoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objFolhaLancamentoCabecalho, objFolhaLancamentoCabecalhoOld);
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
      FolhaLancamentoDetalheEnumerator := objFolhaLancamentoCabecalho.ListaFolhaLancamentoDetalheVO.GetEnumerator;
      with FolhaLancamentoDetalheEnumerator do
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
    FolhaLancamentoDetalheEnumerator.Free;
    objFolhaLancamentoCabecalho.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TFolhaLancamentoCabecalhoController.CancelFolhaLancamentoCabecalho(pSessao: String; pId: Integer): TJSONArray;
begin
  objFolhaLancamentoCabecalho := TFolhaLancamentoCabecalhoVO.Create;
  Result := TJSONArray.Create;
  try
    objFolhaLancamentoCabecalho.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFolhaLancamentoCabecalho);
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
    objFolhaLancamentoCabecalho.Free;
  end;
end;

end.
