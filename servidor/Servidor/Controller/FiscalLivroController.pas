{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [FISCAL_LIVRO] 
                                                                                
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
unit FiscalLivroController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFiscalLivroController = class(TController)
  protected
  public
    //consultar
    function FiscalLivro(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFiscalLivro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFiscalLivro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFiscalLivro(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FiscalLivroVO, FiscalTermoVO, T2TiORM, SA;

{ TFiscalLivroController }

var
  objFiscalLivro: TFiscalLivroVO;
  Resultado: Boolean;

function TFiscalLivroController.FiscalLivro(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFiscalLivroVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFiscalLivroVO>(pFiltro, pPagina, False);
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

function TFiscalLivroController.AcceptFiscalLivro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  FiscalTermoVO: TFiscalTermoVO;
  FiscalTermoEnumerator: TEnumerator<TFiscalTermoVO>;
begin
  objFiscalLivro := TFiscalLivroVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFiscalLivro);

      // Detalhes
      FiscalTermoEnumerator := objFiscalLivro.ListaFiscalTermoVO.GetEnumerator;
      try
        with FiscalTermoEnumerator do
        begin
          while MoveNext do
          begin
            FiscalTermoVO := Current;
            FiscalTermoVO.IdFiscalLivro := UltimoID;
            TT2TiORM.Inserir(FiscalTermoVO);
          end;
        end;
      finally
        FiscalTermoEnumerator.Free;
      end;

      Result := FiscalLivro(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFiscalLivro.Free;
  end;
end;

function TFiscalLivroController.UpdateFiscalLivro(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objFiscalLivroOld: TFiscalLivroVO;
  FiscalTermoEnumerator: TEnumerator<TFiscalTermoVO>;
begin
 //Objeto Novo
  objFiscalLivro := TFiscalLivroVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objFiscalLivroOld := TFiscalLivroVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objFiscalLivro.MainObject.ToJSONString <> objFiscalLivroOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objFiscalLivro, objFiscalLivroOld);
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
      FiscalTermoEnumerator := objFiscalLivro.ListaFiscalTermoVO.GetEnumerator;
      with FiscalTermoEnumerator do
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
    FiscalTermoEnumerator.Free;
    objFiscalLivro.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TFiscalLivroController.CancelFiscalLivro(pSessao: String; pId: Integer): TJSONArray;
begin
  objFiscalLivro := TFiscalLivroVO.Create;
  Result := TJSONArray.Create;
  try
    objFiscalLivro.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFiscalLivro);
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
    objFiscalLivro.Free;
  end;
end;

end.

