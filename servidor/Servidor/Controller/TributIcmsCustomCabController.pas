{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [TRIBUT_ICMS_CUSTOM_CAB] 
                                                                                
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
unit TributIcmsCustomCabController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TTributIcmsCustomCabController = class(TController)
  protected
  public
    //consultar
    function TributIcmsCustomCab(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptTributIcmsCustomCab(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateTributIcmsCustomCab(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelTributIcmsCustomCab(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  TributIcmsCustomCabVO, T2TiORM, SA, TributIcmsCustomDetVO;

{ TTributIcmsCustomCabController }

var
  objTributIcmsCustomCab: TTributIcmsCustomCabVO;
  Resultado: Boolean;

function TTributIcmsCustomCabController.TributIcmsCustomCab(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TTributIcmsCustomCabVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TTributIcmsCustomCabVO>(pFiltro, pPagina, False);
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

function TTributIcmsCustomCabController.AcceptTributIcmsCustomCab(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  //
  TributIcmsCustomDet: TTributIcmsCustomDetVO;
  TributIcmsCustomDetVOEnumerator: TEnumerator<TTributIcmsCustomDetVO>;
begin
  objTributIcmsCustomCab := TTributIcmsCustomCabVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objTributIcmsCustomCab);

      { Detalhe }
      TributIcmsCustomDetVOEnumerator := objTributIcmsCustomCab.ListaTributIcmsCustomDetVO.GetEnumerator;
      try
        with TributIcmsCustomDetVOEnumerator do
        begin
          while MoveNext do
          begin
            TributIcmsCustomDet := Current;
            TributIcmsCustomDet.IdTributIcmsCustomCab := UltimoID;
            TT2TiORM.Inserir(TributIcmsCustomDet);
          end;
        end;
      finally
        TributIcmsCustomDetVOEnumerator.Free;
      end;

      Result := TributIcmsCustomCab(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objTributIcmsCustomCab.Free;
  end;
end;

function TTributIcmsCustomCabController.UpdateTributIcmsCustomCab(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objTributIcmsCustomCabOld: TTributIcmsCustomCabVO;
  TributIcmsCustomDetVOEnumerator: TEnumerator<TTributIcmsCustomDetVO>;
begin
 //Objeto Novo
  objTributIcmsCustomCab := TTributIcmsCustomCabVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objTributIcmsCustomCabOld := TTributIcmsCustomCabVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objTributIcmsCustomCab.MainObject.ToJSONString <> objTributIcmsCustomCabOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objTributIcmsCustomCab, objTributIcmsCustomCabOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    { Detalhe }
    try
      TributIcmsCustomDetVOEnumerator := objTributIcmsCustomCab.ListaTributIcmsCustomDetVO.GetEnumerator;
      with TributIcmsCustomDetVOEnumerator do
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
    TributIcmsCustomDetVOEnumerator.Free;
    objTributIcmsCustomCab.Free;

    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TTributIcmsCustomCabController.CancelTributIcmsCustomCab(pSessao: String; pId: Integer): TJSONArray;
begin
  objTributIcmsCustomCab := TTributIcmsCustomCabVO.Create;
  Result := TJSONArray.Create;
  try
    objTributIcmsCustomCab.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objTributIcmsCustomCab);
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
    objTributIcmsCustomCab.Free;
  end;
end;

end.
