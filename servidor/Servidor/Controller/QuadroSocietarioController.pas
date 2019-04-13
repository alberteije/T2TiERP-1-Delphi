{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [QUADRO_SOCIETARIO] 
                                                                                
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
                                                                                
       t2ti.com@gmail.com
@author Albert Eije
@version 1.0                                                                    
*******************************************************************************}
unit QuadroSocietarioController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TQuadroSocietarioController = class(TController)
  protected
  public
    //consultar
    function QuadroSocietario(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptQuadroSocietario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateQuadroSocietario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelQuadroSocietario(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  QuadroSocietarioVO, T2TiORM, SA;

{ TQuadroSocietarioController }

var
  objQuadroSocietario: TQuadroSocietarioVO;
  Resultado: Boolean;

function TQuadroSocietarioController.QuadroSocietario(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TQuadroSocietarioVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TQuadroSocietarioVO>(pFiltro, pPagina, False);
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

function TQuadroSocietarioController.AcceptQuadroSocietario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objQuadroSocietario := TQuadroSocietarioVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objQuadroSocietario);
      Result := QuadroSocietario(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objQuadroSocietario.Free;
  end;
end;

function TQuadroSocietarioController.UpdateQuadroSocietario(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objQuadroSocietarioOld: TQuadroSocietarioVO;
begin
 //Objeto Novo
  objQuadroSocietario := TQuadroSocietarioVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objQuadroSocietarioOld := TQuadroSocietarioVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objQuadroSocietario, objQuadroSocietarioOld);
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
    objQuadroSocietario.Free;
  end;
end;

function TQuadroSocietarioController.CancelQuadroSocietario(pSessao: String; pId: Integer): TJSONArray;
begin
  objQuadroSocietario := TQuadroSocietarioVO.Create;
  Result := TJSONArray.Create;
  try
    objQuadroSocietario.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objQuadroSocietario);
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
    objQuadroSocietario.Free;
  end;
end;

end.
