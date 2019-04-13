{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PATRIM_BEM] 
                                                                                
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
unit PatrimBemController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPatrimBemController = class(TController)
  protected
  public
    //consultar
    function PatrimBem(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPatrimBem(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePatrimBem(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPatrimBem(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  SA, PatrimBemVO, T2TiORM, PatrimDocumentoBemVO, PatrimDepreciacaoBemVO, PatrimMovimentacaoBemVO;

{ TPatrimBemController }

var
  objPatrimBem: TPatrimBemVO;
  Resultado: Boolean;

function TPatrimBemController.PatrimBem(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TPatrimBemVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TPatrimBemVO>(pFiltro, pPagina, False);
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

function TPatrimBemController.AcceptPatrimBem(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  DocumentoBemVO: TPatrimDocumentoBemVO;
  DepreciacaoBemVO: TPatrimDepreciacaoBemVO;
  MovimentacaoBemVO: TPatrimMovimentacaoBemVO;
  DocumentoBemEnumerator: TEnumerator<TPatrimDocumentoBemVO>;
  DepreciacaoBemEnumerator: TEnumerator<TPatrimDepreciacaoBemVO>;
  MovimentacaoBemEnumerator: TEnumerator<TPatrimMovimentacaoBemVO>;
begin
  objPatrimBem := TPatrimBemVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPatrimBem);

      // Documento
      DocumentoBemEnumerator := objPatrimBem.ListaPatrimDocumentoBemVO.GetEnumerator;
      try
        with DocumentoBemEnumerator do
        begin
          while MoveNext do
          begin
            DocumentoBemVO := Current;
            DocumentoBemVO.IdPatrimBem := UltimoID;
            TT2TiORM.Inserir(DocumentoBemVO);
          end;
        end;
      finally
        DocumentoBemEnumerator.Free;
      end;

      // Depreciação
      DepreciacaoBemEnumerator := objPatrimBem.ListaPatrimDepreciacaoBemVO.GetEnumerator;
      try
        with DepreciacaoBemEnumerator do
        begin
          while MoveNext do
          begin
            DepreciacaoBemVO := Current;
            DepreciacaoBemVO.IdPatrimBem := UltimoID;
            TT2TiORM.Inserir(DepreciacaoBemVO);
          end;
        end;
      finally
        DepreciacaoBemEnumerator.Free;
      end;

      // Movimentação
      MovimentacaoBemEnumerator := objPatrimBem.ListaPatrimMovimentacaoBemVO.GetEnumerator;
      try
        with MovimentacaoBemEnumerator do
        begin
          while MoveNext do
          begin
            MovimentacaoBemVO := Current;
            MovimentacaoBemVO.IdPatrimBem := UltimoID;
            TT2TiORM.Inserir(MovimentacaoBemVO);
          end;
        end;
      finally
        MovimentacaoBemEnumerator.Free;
      end;

      Result := PatrimBem(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPatrimBem.Free;
  end;
end;

function TPatrimBemController.UpdatePatrimBem(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objPatrimBemOld: TPatrimBemVO;
  DocumentoBemEnumerator: TEnumerator<TPatrimDocumentoBemVO>;
  DepreciacaoBemEnumerator: TEnumerator<TPatrimDepreciacaoBemVO>;
  MovimentacaoBemEnumerator: TEnumerator<TPatrimMovimentacaoBemVO>;
begin
 //Objeto Novo
  objPatrimBem := TPatrimBemVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objPatrimBemOld := TPatrimBemVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    // Verifica se houve alterações no objeto principal
    if objPatrimBem.MainObject.ToJSONString <> objPatrimBemOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objPatrimBem, objPatrimBemOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Documento
    try
      DocumentoBemEnumerator := objPatrimBem.ListaPatrimDocumentoBemVO.GetEnumerator;
      with DocumentoBemEnumerator do
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

    // Depreciação
    try
      DepreciacaoBemEnumerator := objPatrimBem.ListaPatrimDepreciacaoBemVO.GetEnumerator;
      with DepreciacaoBemEnumerator do
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

    // Movimentação
    try
      MovimentacaoBemEnumerator := objPatrimBem.ListaPatrimMovimentacaoBemVO.GetEnumerator;
      with MovimentacaoBemEnumerator do
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
    DocumentoBemEnumerator.Free;
    DepreciacaoBemEnumerator.Free;
    MovimentacaoBemEnumerator.Free;
    objPatrimBem.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TPatrimBemController.CancelPatrimBem(pSessao: String; pId: Integer): TJSONArray;
begin
  objPatrimBem := TPatrimBemVO.Create;
  Result := TJSONArray.Create;
  try
    objPatrimBem.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPatrimBem);
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
    objPatrimBem.Free;
  end;
end;

end.

