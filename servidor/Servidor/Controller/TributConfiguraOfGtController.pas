{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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
unit TributConfiguraOfGtController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TTributConfiguraOfGtController = class(TController)
  protected
  public
    //consultar
    function TributConfiguraOfGt(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptTributConfiguraOfGt(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateTributConfiguraOfGt(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelTributConfiguraOfGt(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  TributConfiguraOfGtVO, T2TiORM, SA,
  //
  TributPisCodApuracaoVO, TributCofinsCodApuracaoVO, TributIpiDipiVO, TributIcmsUfVO;

{ TTributConfiguraOfGtController }

var
  objTributConfiguraOfGt: TTributConfiguraOfGtVO;
  Resultado: Boolean;

function TTributConfiguraOfGtController.TributConfiguraOfGt(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TTributConfiguraOfGtVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TTributConfiguraOfGtVO>(pFiltro, pPagina, False);
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

function TTributConfiguraOfGtController.AcceptTributConfiguraOfGt(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  //
  TributIcmsUf: TTributIcmsUfVO;
  TributIcmsUfVOEnumerator: TEnumerator<TTributIcmsUfVO>;
begin
  objTributConfiguraOfGt := TTributConfiguraOfGtVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objTributConfiguraOfGt);

      { Pis }
      if Assigned(objTributConfiguraOfGt.TributPisCodApuracaoVO) then
      begin
        objTributConfiguraOfGt.TributPisCodApuracaoVO.IdTributConfiguraOfGt := UltimoID;
        TT2TiORM.Inserir(objTributConfiguraOfGt.TributPisCodApuracaoVO);
      end;

      { Cofins }
      if Assigned(objTributConfiguraOfGt.TributCofinsCodApuracaoVO) then
      begin
        objTributConfiguraOfGt.TributCofinsCodApuracaoVO.IdTributConfiguraOfGt := UltimoID;
        TT2TiORM.Inserir(objTributConfiguraOfGt.TributCofinsCodApuracaoVO);
      end;

      { Ipi }
      if Assigned(objTributConfiguraOfGt.TributIpiDipiVO) then
      begin
        objTributConfiguraOfGt.TributIpiDipiVO.IdTributConfiguraOfGt := UltimoID;
        TT2TiORM.Inserir(objTributConfiguraOfGt.TributIpiDipiVO);
      end;

      {Icms por Uf}
      TributIcmsUfVOEnumerator := objTributConfiguraOfGt.ListaTributIcmsUfVO.GetEnumerator;
      try
        with TributIcmsUfVOEnumerator do
        begin
          while MoveNext do
          begin
            TributIcmsUf := Current;
            TributIcmsUf.IdTributConfiguraOfGt := UltimoID;
            TT2TiORM.Inserir(TributIcmsUf);
          end;
        end;
      finally
        TributIcmsUfVOEnumerator.Free;
      end;

      Result := TributConfiguraOfGt(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objTributConfiguraOfGt.Free;
  end;
end;

function TTributConfiguraOfGtController.UpdateTributConfiguraOfGt(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objTributConfiguraOfGtOld: TTributConfiguraOfGtVO;
  TributIcmsUfVOEnumerator: TEnumerator<TTributIcmsUfVO>;
begin
 //Objeto Novo
  objTributConfiguraOfGt := TTributConfiguraOfGtVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objTributConfiguraOfGtOld := TTributConfiguraOfGtVO.Create((pObjeto as TJSONArray).Get(1));

  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objTributConfiguraOfGt.MainObject.ToJSONString <> objTributConfiguraOfGtOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objTributConfiguraOfGt, objTributConfiguraOfGtOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    { Pis }
    if Assigned(objTributConfiguraOfGt.TributPisCodApuracaoVO) then
    begin
      Resultado := TT2TiORM.Alterar(objTributConfiguraOfGt.TributPisCodApuracaoVO);
    end;

    { Cofins }
    if Assigned(objTributConfiguraOfGt.TributCofinsCodApuracaoVO) then
    begin
      Resultado := TT2TiORM.Alterar(objTributConfiguraOfGt.TributCofinsCodApuracaoVO);
    end;

    { Ipi }
    if Assigned(objTributConfiguraOfGt.TributIpiDipiVO) then
    begin
      Resultado := TT2TiORM.Alterar(objTributConfiguraOfGt.TributIpiDipiVO);
    end;

    {Icms por Uf}
    try
      TributIcmsUfVOEnumerator := objTributConfiguraOfGt.ListaTributIcmsUfVO.GetEnumerator;
      with TributIcmsUfVOEnumerator do
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
    TributIcmsUfVOEnumerator.Free;
    objTributConfiguraOfGt.Free;

    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TTributConfiguraOfGtController.CancelTributConfiguraOfGt(pSessao: String; pId: Integer): TJSONArray;
begin
  objTributConfiguraOfGt := TTributConfiguraOfGtVO.Create;
  Result := TJSONArray.Create;
  try
    objTributConfiguraOfGt.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objTributConfiguraOfGt);
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
    objTributConfiguraOfGt.Free;
  end;
end;

end.
