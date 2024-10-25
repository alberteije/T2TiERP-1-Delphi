{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado � tabela [FOLHA_PPP] 
                                                                                
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
unit FolhaPppController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFolhaPppController = class(TController)
  protected
  public
    //consultar
    function FolhaPpp(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFolhaPpp(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFolhaPpp(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFolhaPpp(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FolhaPppVO, FolhaPppCatVO, FolhaPppAtividadeVO, FolhaPppFatorRiscoVO, FolhaPppExameMedicoVO,
  T2TiORM, SA;

{ TFolhaPppController }

var
  objFolhaPpp: TFolhaPppVO;
  Resultado: Boolean;

function TFolhaPppController.FolhaPpp(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFolhaPppVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFolhaPppVO>(pFiltro, pPagina, False);
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

function TFolhaPppController.AcceptFolhaPpp(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  FolhaPppCatVO: TFolhaPppCatVO;
  FolhaPppCatEnumerator: TEnumerator<TFolhaPppCatVO>;
  FolhaPppAtividadeVO: TFolhaPppAtividadeVO;
  FolhaPppAtividadeEnumerator: TEnumerator<TFolhaPppAtividadeVO>;
  FolhaPppFatorRiscoVO: TFolhaPppFatorRiscoVO;
  FolhaPppFatorRiscoEnumerator: TEnumerator<TFolhaPppFatorRiscoVO>;
  FolhaPppExameMedicoVO: TFolhaPppExameMedicoVO;
  FolhaPppExameMedicoEnumerator: TEnumerator<TFolhaPppExameMedicoVO>;
begin
  objFolhaPpp := TFolhaPppVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFolhaPpp);

      // CAT
      FolhaPppCatEnumerator := objFolhaPpp.ListaFolhaPppCatVO.GetEnumerator;
      try
        with FolhaPppCatEnumerator do
        begin
          while MoveNext do
          begin
            FolhaPppCatVO := Current;
            FolhaPppCatVO.IdFolhaPpp := UltimoID;
            TT2TiORM.Inserir(FolhaPppCatVO);
          end;
        end;
      finally
        FolhaPppCatEnumerator.Free;
      end;

      // Atividade
      FolhaPppAtividadeEnumerator := objFolhaPpp.ListaFolhaPppAtividadeVO.GetEnumerator;
      try
        with FolhaPppAtividadeEnumerator do
        begin
          while MoveNext do
          begin
            FolhaPppAtividadeVO := Current;
            FolhaPppAtividadeVO.IdFolhaPpp := UltimoID;
            TT2TiORM.Inserir(FolhaPppAtividadeVO);
          end;
        end;
      finally
        FolhaPppAtividadeEnumerator.Free;
      end;

      // Fator Risco
      FolhaPppFatorRiscoEnumerator := objFolhaPpp.ListaFolhaPppFatorRiscoVO.GetEnumerator;
      try
        with FolhaPppFatorRiscoEnumerator do
        begin
          while MoveNext do
          begin
            FolhaPppFatorRiscoVO := Current;
            FolhaPppFatorRiscoVO.IdFolhaPpp := UltimoID;
            TT2TiORM.Inserir(FolhaPppFatorRiscoVO);
          end;
        end;
      finally
        FolhaPppFatorRiscoEnumerator.Free;
      end;

      // Exame M�dico
      FolhaPppExameMedicoEnumerator := objFolhaPpp.ListaFolhaPppExameMedicoVO.GetEnumerator;
      try
        with FolhaPppExameMedicoEnumerator do
        begin
          while MoveNext do
          begin
            FolhaPppExameMedicoVO := Current;
            FolhaPppExameMedicoVO.IdFolhaPpp := UltimoID;
            TT2TiORM.Inserir(FolhaPppExameMedicoVO);
          end;
        end;
      finally
        FolhaPppExameMedicoEnumerator.Free;
      end;

      Result := FolhaPpp(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFolhaPpp.Free;
  end;
end;

function TFolhaPppController.UpdateFolhaPpp(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objFolhaPppOld: TFolhaPppVO;
  FolhaPppCatEnumerator: TEnumerator<TFolhaPppCatVO>;
  FolhaPppAtividadeEnumerator: TEnumerator<TFolhaPppAtividadeVO>;
  FolhaPppFatorRiscoEnumerator: TEnumerator<TFolhaPppFatorRiscoVO>;
  FolhaPppExameMedicoEnumerator: TEnumerator<TFolhaPppExameMedicoVO>;
begin
 //Objeto Novo
  objFolhaPpp := TFolhaPppVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objFolhaPppOld := TFolhaPppVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve altera��es no objeto principal
    if objFolhaPpp.MainObject.ToJSONString <> objFolhaPppOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objFolhaPpp, objFolhaPppOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // CAT
    try
      FolhaPppCatEnumerator := objFolhaPpp.ListaFolhaPppCatVO.GetEnumerator;
      with FolhaPppCatEnumerator do
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

    // Atividade
    try
      FolhaPppAtividadeEnumerator := objFolhaPpp.ListaFolhaPppAtividadeVO.GetEnumerator;
      with FolhaPppAtividadeEnumerator do
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

    // Fator Risco
    try
      FolhaPppFatorRiscoEnumerator := objFolhaPpp.ListaFolhaPppFatorRiscoVO.GetEnumerator;
      with FolhaPppFatorRiscoEnumerator do
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

    // Exame M�dico
    try
      FolhaPppExameMedicoEnumerator := objFolhaPpp.ListaFolhaPppExameMedicoVO.GetEnumerator;
      with FolhaPppExameMedicoEnumerator do
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
    objFolhaPpp.Free;
    FolhaPppCatEnumerator.Free;
    FolhaPppAtividadeEnumerator.Free;
    FolhaPppFatorRiscoEnumerator.Free;
    FolhaPppExameMedicoEnumerator.Free;
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TFolhaPppController.CancelFolhaPpp(pSessao: String; pId: Integer): TJSONArray;
begin
  objFolhaPpp := TFolhaPppVO.Create;
  Result := TJSONArray.Create;
  try
    objFolhaPpp.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFolhaPpp);
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
    objFolhaPpp.Free;
  end;
end;

end.
