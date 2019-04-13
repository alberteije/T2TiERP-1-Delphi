{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [CONTABIL_INDICE] 
                                                                                
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
unit ContabilIndiceController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TContabilIndiceController = class(TController)
  protected
  public
    //consultar
    function ContabilIndice(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptContabilIndice(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateContabilIndice(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelContabilIndice(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ContabilIndiceVO, ContabilIndiceValorVO, T2TiORM, SA;

{ TContabilIndiceController }

var
  objContabilIndice: TContabilIndiceVO;
  Resultado: Boolean;

function TContabilIndiceController.ContabilIndice(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TContabilIndiceVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TContabilIndiceVO>(pFiltro, pPagina, False);
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

function TContabilIndiceController.AcceptContabilIndice(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  ContabilIndiceValorVO: TContabilIndiceValorVO;
  ContabilIndiceValorEnumerator: TEnumerator<TContabilIndiceValorVO>;
begin
  objContabilIndice := TContabilIndiceVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objContabilIndice);

      // Detalhes
      ContabilIndiceValorEnumerator := objContabilIndice.ListaContabilIndiceValorVO.GetEnumerator;
      try
        with ContabilIndiceValorEnumerator do
        begin
          while MoveNext do
          begin
            ContabilIndiceValorVO := Current;
            ContabilIndiceValorVO.IdContabilIndice := UltimoID;
            TT2TiORM.Inserir(ContabilIndiceValorVO);
          end;
        end;
      finally
        ContabilIndiceValorEnumerator.Free;
      end;

      Result := ContabilIndice(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objContabilIndice.Free;
  end;
end;

function TContabilIndiceController.UpdateContabilIndice(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objContabilIndiceOld: TContabilIndiceVO;
  ContabilIndiceValorEnumerator: TEnumerator<TContabilIndiceValorVO>;
begin
 //Objeto Novo
  objContabilIndice := TContabilIndiceVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objContabilIndiceOld := TContabilIndiceVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objContabilIndice.MainObject.ToJSONString <> objContabilIndiceOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objContabilIndice, objContabilIndiceOld);
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
      ContabilIndiceValorEnumerator := objContabilIndice.ListaContabilIndiceValorVO.GetEnumerator;
      with ContabilIndiceValorEnumerator do
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
    ContabilIndiceValorEnumerator.Free;
    objContabilIndice.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TContabilIndiceController.CancelContabilIndice(pSessao: String; pId: Integer): TJSONArray;
begin
  objContabilIndice := TContabilIndiceVO.Create;
  Result := TJSONArray.Create;
  try
    objContabilIndice.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objContabilIndice);
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
    objContabilIndice.Free;
  end;
end;

end.
