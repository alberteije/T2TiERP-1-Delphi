{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [CONTABIL_ENCERRAMENTO_EXE_CAB] 
                                                                                
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
unit ContabilEncerramentoExeCabController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TContabilEncerramentoExeCabController = class(TController)
  protected
  public
    //consultar
    function ContabilEncerramentoExeCab(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptContabilEncerramentoExeCab(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateContabilEncerramentoExeCab(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelContabilEncerramentoExeCab(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ContabilEncerramentoExeCabVO, ContabilEncerramentoExeDetVO, T2TiORM, SA;

{ TContabilEncerramentoExeCabController }

var
  objContabilEncerramentoExeCab: TContabilEncerramentoExeCabVO;
  Resultado: Boolean;

function TContabilEncerramentoExeCabController.ContabilEncerramentoExeCab(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TContabilEncerramentoExeCabVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TContabilEncerramentoExeCabVO>(pFiltro, pPagina, False);
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

function TContabilEncerramentoExeCabController.AcceptContabilEncerramentoExeCab(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  ContabilEncerramentoExeDetVO: TContabilEncerramentoExeDetVO;
  ContabilEncerramentoExeDetEnumerator: TEnumerator<TContabilEncerramentoExeDetVO>;
begin
  objContabilEncerramentoExeCab := TContabilEncerramentoExeCabVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objContabilEncerramentoExeCab);

      // Detalhes
      ContabilEncerramentoExeDetEnumerator := objContabilEncerramentoExeCab.ListaContabilEncerramentoExeDetVO.GetEnumerator;
      try
        with ContabilEncerramentoExeDetEnumerator do
        begin
          while MoveNext do
          begin
            ContabilEncerramentoExeDetVO := Current;
            ContabilEncerramentoExeDetVO.IdContabilEncerramentoExe := UltimoID;
            TT2TiORM.Inserir(ContabilEncerramentoExeDetVO);
          end;
        end;
      finally
        ContabilEncerramentoExeDetEnumerator.Free;
      end;

      Result := ContabilEncerramentoExeCab(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objContabilEncerramentoExeCab.Free;
  end;
end;

function TContabilEncerramentoExeCabController.UpdateContabilEncerramentoExeCab(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objContabilEncerramentoExeCabOld: TContabilEncerramentoExeCabVO;
  ContabilEncerramentoExeDetEnumerator: TEnumerator<TContabilEncerramentoExeDetVO>;
begin
 //Objeto Novo
  objContabilEncerramentoExeCab := TContabilEncerramentoExeCabVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objContabilEncerramentoExeCabOld := TContabilEncerramentoExeCabVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objContabilEncerramentoExeCab.MainObject.ToJSONString <> objContabilEncerramentoExeCabOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objContabilEncerramentoExeCab, objContabilEncerramentoExeCabOld);
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
      ContabilEncerramentoExeDetEnumerator := objContabilEncerramentoExeCab.ListaContabilEncerramentoExeDetVO.GetEnumerator;
      with ContabilEncerramentoExeDetEnumerator do
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
    ContabilEncerramentoExeDetEnumerator.Free;
    objContabilEncerramentoExeCab.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TContabilEncerramentoExeCabController.CancelContabilEncerramentoExeCab(pSessao: String; pId: Integer): TJSONArray;
begin
  objContabilEncerramentoExeCab := TContabilEncerramentoExeCabVO.Create;
  Result := TJSONArray.Create;
  try
    objContabilEncerramentoExeCab.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objContabilEncerramentoExeCab);
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
    objContabilEncerramentoExeCab.Free;
  end;
end;

end.

