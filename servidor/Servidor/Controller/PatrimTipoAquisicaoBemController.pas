{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PATRIM_TIPO_AQUISICAO_BEM] 
                                                                                
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
unit PatrimTipoAquisicaoBemController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPatrimTipoAquisicaoBemController = class(TController)
  protected
  public
    //consultar
    function PatrimTipoAquisicaoBem(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPatrimTipoAquisicaoBem(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePatrimTipoAquisicaoBem(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPatrimTipoAquisicaoBem(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  PatrimTipoAquisicaoBemVO, T2TiORM, SA;

{ TPatrimTipoAquisicaoBemController }

var
  objPatrimTipoAquisicaoBem: TPatrimTipoAquisicaoBemVO;
  Resultado: Boolean;

function TPatrimTipoAquisicaoBemController.PatrimTipoAquisicaoBem(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TPatrimTipoAquisicaoBemVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TPatrimTipoAquisicaoBemVO>(pFiltro, pPagina, False);
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

function TPatrimTipoAquisicaoBemController.AcceptPatrimTipoAquisicaoBem(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objPatrimTipoAquisicaoBem := TPatrimTipoAquisicaoBemVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPatrimTipoAquisicaoBem);
      Result := PatrimTipoAquisicaoBem(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPatrimTipoAquisicaoBem.Free;
  end;
end;

function TPatrimTipoAquisicaoBemController.UpdatePatrimTipoAquisicaoBem(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objPatrimTipoAquisicaoBemOld: TPatrimTipoAquisicaoBemVO;
begin
 //Objeto Novo
  objPatrimTipoAquisicaoBem := TPatrimTipoAquisicaoBemVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objPatrimTipoAquisicaoBemOld := TPatrimTipoAquisicaoBemVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objPatrimTipoAquisicaoBem, objPatrimTipoAquisicaoBemOld);
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
    objPatrimTipoAquisicaoBem.Free;
  end;
end;

function TPatrimTipoAquisicaoBemController.CancelPatrimTipoAquisicaoBem(pSessao: String; pId: Integer): TJSONArray;
begin
  objPatrimTipoAquisicaoBem := TPatrimTipoAquisicaoBemVO.Create;
  Result := TJSONArray.Create;
  try
    objPatrimTipoAquisicaoBem.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPatrimTipoAquisicaoBem);
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
    objPatrimTipoAquisicaoBem.Free;
  end;
end;

end.
