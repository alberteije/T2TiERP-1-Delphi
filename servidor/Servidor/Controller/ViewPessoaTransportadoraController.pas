{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [VIEW_PESSOA_TRANSPORTADORA] 
                                                                                
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
unit ViewPessoaTransportadoraController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TViewPessoaTransportadoraController = class(TController)
  protected
  public
    //consultar
    function ViewPessoaTransportadora(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptViewPessoaTransportadora(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateViewPessoaTransportadora(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelViewPessoaTransportadora(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ViewPessoaTransportadoraVO, T2TiORM, SA;

{ TViewPessoaTransportadoraController }

var
  objViewPessoaTransportadora: TViewPessoaTransportadoraVO;
  Resultado: Boolean;

function TViewPessoaTransportadoraController.ViewPessoaTransportadora(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TViewPessoaTransportadoraVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TViewPessoaTransportadoraVO>(pFiltro, pPagina, False);
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

function TViewPessoaTransportadoraController.AcceptViewPessoaTransportadora(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objViewPessoaTransportadora := TViewPessoaTransportadoraVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objViewPessoaTransportadora);
      Result := ViewPessoaTransportadora(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objViewPessoaTransportadora.Free;
  end;
end;

function TViewPessoaTransportadoraController.UpdateViewPessoaTransportadora(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objViewPessoaTransportadoraOld: TViewPessoaTransportadoraVO;
begin
 //Objeto Novo
  objViewPessoaTransportadora := TViewPessoaTransportadoraVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objViewPessoaTransportadoraOld := TViewPessoaTransportadoraVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objViewPessoaTransportadora, objViewPessoaTransportadoraOld);
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
    objViewPessoaTransportadora.Free;
  end;
end;

function TViewPessoaTransportadoraController.CancelViewPessoaTransportadora(pSessao: String; pId: Integer): TJSONArray;
begin
  objViewPessoaTransportadora := TViewPessoaTransportadoraVO.Create;
  Result := TJSONArray.Create;
  try
    objViewPessoaTransportadora.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objViewPessoaTransportadora);
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
    objViewPessoaTransportadora.Free;
  end;
end;

end.
