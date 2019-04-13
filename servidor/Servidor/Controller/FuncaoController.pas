{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [Funcao]
                                                                                
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
                                                                                
@author Fábio Thomaz (fabio_thz@yahoo.com.br)                            
@version 1.0                                                                    
*******************************************************************************}
unit FuncaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFuncaoController = class(TController)
  protected
  public
    //consultar
    function Funcao (pSessao: string; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFuncao(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFuncao(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFuncao(pSessao: string; pId: Integer): Boolean;
  end;

implementation

uses
  FuncaoVO, T2TiORM, SA;

{ TFuncaoController}

var
  objFuncao: TFuncaoVO;

function TFuncaoController.Funcao(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TT2TiORM.Consultar<TFuncaoVO>(pFiltro,pPagina);
end;

function TFuncaoController.AcceptFuncao(pSessao: string; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  try
    try
      objFuncao := TFuncaoVO.JSONToObject<TFuncaoVO>(pObjeto);
      UltimoID := TT2TiORM.Inserir(objFuncao);
      result := Funcao(pSessao, 'ID = ' + IntToStr(UltimoID),0);
    except
      result := TJSONArray.Create;
      raise;
    end;
  finally

  end;
end;

function TFuncaoController.UpdateFuncao(pSessao: string; pObjeto: TJSONValue): TJSONArray;
var
  Filtro : String;
  Pagina : Integer;
begin
  try
    try
      objFuncao := TFuncaoVO.JSONToObject<TFuncaoVO>((pObjeto as TJSONArray).Get(0));
      TT2TiORM.Alterar(objFuncao);
      Filtro := (pObjeto as TJSONArray).Get(1).ToString;

      //retira as aspas do JSON
      Delete(Filtro, Length(Filtro), 1);
      Delete(Filtro, 1, 1);

      Pagina := StrToInt((pObjeto as TJSONArray).Get(2).ToString);

      result := Funcao(pSessao, Filtro,Pagina);
    except
      result := TJSONArray.Create;
      raise;
    end;
  finally

  end;
end;

function TFuncaoController.CancelFuncao(pSessao: string; pId: Integer): Boolean;
begin
  try
    try
      objFuncao := TFuncaoVO.Create;
      objFuncao.Id := pId;
      TT2TiORM.Excluir(objFuncao);
      result := True;
    except
      result := False;
      raise;
    end;
  finally
    objFuncao.Free;
  end;
end;

end.
