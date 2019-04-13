{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PATRIM_INDICE_ATUALIZACAO] 
                                                                                
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
           t2ti.com@gmail.com</p>                                               
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit PatrimIndiceAtualizacaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPatrimIndiceAtualizacaoController = class(TController)
  protected
  public
    //consultar
    function PatrimIndiceAtualizacao(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPatrimIndiceAtualizacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePatrimIndiceAtualizacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPatrimIndiceAtualizacao(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  PatrimIndiceAtualizacaoVO, T2TiORM, SA;

{ TPatrimIndiceAtualizacaoController }

var
  objPatrimIndiceAtualizacao: TPatrimIndiceAtualizacaoVO;
  Resultado: Boolean;

function TPatrimIndiceAtualizacaoController.PatrimIndiceAtualizacao(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    Result := TT2TiORM.Consultar<TPatrimIndiceAtualizacaoVO>(pFiltro, pPagina);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;
end;

function TPatrimIndiceAtualizacaoController.AcceptPatrimIndiceAtualizacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objPatrimIndiceAtualizacao := TPatrimIndiceAtualizacaoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPatrimIndiceAtualizacao);
      Result := PatrimIndiceAtualizacao(pSessao, 'ID = ' + IntToStr(UltimoID),0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPatrimIndiceAtualizacao.Free;
  end;
end;

function TPatrimIndiceAtualizacaoController.UpdatePatrimIndiceAtualizacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
begin
  objPatrimIndiceAtualizacao := TPatrimIndiceAtualizacaoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objPatrimIndiceAtualizacao);
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
    objPatrimIndiceAtualizacao.Free;
  end;
end;

function TPatrimIndiceAtualizacaoController.CancelPatrimIndiceAtualizacao(pSessao: String; pId: Integer): TJSONArray;
begin
  objPatrimIndiceAtualizacao := TPatrimIndiceAtualizacaoVO.Create;
  Result := TJSONArray.Create;
  try
    objPatrimIndiceAtualizacao.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPatrimIndiceAtualizacao);
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
    objPatrimIndiceAtualizacao.Free;
  end;
end;

end.
