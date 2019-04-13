{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [CONTABIL_LANCAMENTO_DETALHE] 
                                                                                
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
unit ContabilLancamentoDetalheController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TContabilLancamentoDetalheController = class(TController)
  protected
  public
    //consultar
    function ContabilLancamentoDetalhe(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptContabilLancamentoDetalhe(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateContabilLancamentoDetalhe(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelContabilLancamentoDetalhe(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ContabilLancamentoDetalheVO, T2TiORM, SA;

{ TContabilLancamentoDetalheController }

var
  objContabilLancamentoDetalhe: TContabilLancamentoDetalheVO;
  Resultado: Boolean;

function TContabilLancamentoDetalheController.ContabilLancamentoDetalhe(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TContabilLancamentoDetalheVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TContabilLancamentoDetalheVO>(pFiltro, pPagina, False);
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

function TContabilLancamentoDetalheController.AcceptContabilLancamentoDetalhe(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objContabilLancamentoDetalhe := TContabilLancamentoDetalheVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objContabilLancamentoDetalhe);
      Result := ContabilLancamentoDetalhe(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objContabilLancamentoDetalhe.Free;
  end;
end;

function TContabilLancamentoDetalheController.UpdateContabilLancamentoDetalhe(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objContabilLancamentoDetalheOld: TContabilLancamentoDetalheVO;
begin
 //Objeto Novo
  objContabilLancamentoDetalhe := TContabilLancamentoDetalheVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objContabilLancamentoDetalheOld := TContabilLancamentoDetalheVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objContabilLancamentoDetalhe, objContabilLancamentoDetalheOld);
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
    objContabilLancamentoDetalhe.Free;
  end;
end;

function TContabilLancamentoDetalheController.CancelContabilLancamentoDetalhe(pSessao: String; pId: Integer): TJSONArray;
begin
  objContabilLancamentoDetalhe := TContabilLancamentoDetalheVO.Create;
  Result := TJSONArray.Create;
  try
    objContabilLancamentoDetalhe.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objContabilLancamentoDetalhe);
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
    objContabilLancamentoDetalhe.Free;
  end;
end;

end.
