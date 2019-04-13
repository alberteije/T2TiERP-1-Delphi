{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [FOLHA_INSS] 
                                                                                
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
unit FolhaInssController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFolhaInssController = class(TController)
  protected
  public
    //consultar
    function FolhaInss(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFolhaInss(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFolhaInss(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFolhaInss(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FolhaInssVO, FolhaInssRetencaoVO, T2TiORM, SA;

{ TFolhaInssController }

var
  objFolhaInss: TFolhaInssVO;
  Resultado: Boolean;

function TFolhaInssController.FolhaInss(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFolhaInssVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFolhaInssVO>(pFiltro, pPagina, False);
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

function TFolhaInssController.AcceptFolhaInss(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  FolhaInssRetencaoVO: TFolhaInssRetencaoVO;
  FolhaFolhaInssRetencaoEnumerator: TEnumerator<TFolhaInssRetencaoVO>;
begin
  objFolhaInss := TFolhaInssVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFolhaInss);

      // Retenções
      FolhaFolhaInssRetencaoEnumerator := objFolhaInss.ListaFolhaInssRetencaoVO.GetEnumerator;
      try
        with FolhaFolhaInssRetencaoEnumerator do
        begin
          while MoveNext do
          begin
            FolhaInssRetencaoVO := Current;
            FolhaInssRetencaoVO.IdFolhaInss := UltimoID;
            TT2TiORM.Inserir(FolhaInssRetencaoVO);
          end;
        end;
      finally
        FolhaFolhaInssRetencaoEnumerator.Free;
      end;

      Result := FolhaInss(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFolhaInss.Free;
  end;
end;

function TFolhaInssController.UpdateFolhaInss(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objFolhaInssOld: TFolhaInssVO;
  FolhaFolhaInssRetencaoEnumerator: TEnumerator<TFolhaInssRetencaoVO>;
begin
 //Objeto Novo
  objFolhaInss := TFolhaInssVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objFolhaInssOld := TFolhaInssVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objFolhaInss.MainObject.ToJSONString <> objFolhaInssOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objFolhaInss, objFolhaInssOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Retenções
    try
      FolhaFolhaInssRetencaoEnumerator := objFolhaInss.ListaFolhaInssRetencaoVO.GetEnumerator;
      with FolhaFolhaInssRetencaoEnumerator do
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
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objFolhaInss.Free;
  end;
end;

function TFolhaInssController.CancelFolhaInss(pSessao: String; pId: Integer): TJSONArray;
begin
  objFolhaInss := TFolhaInssVO.Create;
  Result := TJSONArray.Create;
  try
    objFolhaInss.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFolhaInss);
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
    objFolhaInss.Free;
  end;
end;

end.
