{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [SIMPLES_NACIONAL_CABECALHO] 
                                                                                
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
unit SimplesNacionalCabecalhoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TSimplesNacionalCabecalhoController = class(TController)
  protected
  public
    //consultar
    function SimplesNacionalCabecalho(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptSimplesNacionalCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateSimplesNacionalCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelSimplesNacionalCabecalho(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  SimplesNacionalCabecalhoVO, SimplesNacionalDetalheVO, T2TiORM, SA;

{ TSimplesNacionalCabecalhoController }

var
  objSimplesNacionalCabecalho: TSimplesNacionalCabecalhoVO;
  Resultado: Boolean;

function TSimplesNacionalCabecalhoController.SimplesNacionalCabecalho(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TSimplesNacionalCabecalhoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TSimplesNacionalCabecalhoVO>(pFiltro, pPagina, False);
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

function TSimplesNacionalCabecalhoController.AcceptSimplesNacionalCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  SimplesNacionalDetalheVO: TSimplesNacionalDetalheVO;
  SimplesNacionalDetalheEnumerator: TEnumerator<TSimplesNacionalDetalheVO>;
begin
  objSimplesNacionalCabecalho := TSimplesNacionalCabecalhoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objSimplesNacionalCabecalho);

      // Detalhes
      SimplesNacionalDetalheEnumerator := objSimplesNacionalCabecalho.ListaSimplesNacionalDetalheVO.GetEnumerator;
      try
        with SimplesNacionalDetalheEnumerator do
        begin
          while MoveNext do
          begin
            SimplesNacionalDetalheVO := Current;
            SimplesNacionalDetalheVO.IdSimplesNacionalCabecalho := UltimoID;
            TT2TiORM.Inserir(SimplesNacionalDetalheVO);
          end;
        end;
      finally
        SimplesNacionalDetalheEnumerator.Free;
      end;

      Result := SimplesNacionalCabecalho(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objSimplesNacionalCabecalho.Free;
  end;
end;

function TSimplesNacionalCabecalhoController.UpdateSimplesNacionalCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objSimplesNacionalCabecalhoOld: TSimplesNacionalCabecalhoVO;
  SimplesNacionalDetalheEnumerator: TEnumerator<TSimplesNacionalDetalheVO>;
begin
 //Objeto Novo
  objSimplesNacionalCabecalho := TSimplesNacionalCabecalhoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objSimplesNacionalCabecalhoOld := TSimplesNacionalCabecalhoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objSimplesNacionalCabecalho.MainObject.ToJSONString <> objSimplesNacionalCabecalhoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objSimplesNacionalCabecalho, objSimplesNacionalCabecalhoOld);
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
      SimplesNacionalDetalheEnumerator := objSimplesNacionalCabecalho.ListaSimplesNacionalDetalheVO.GetEnumerator;
      with SimplesNacionalDetalheEnumerator do
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
    SimplesNacionalDetalheEnumerator.Free;
    objSimplesNacionalCabecalho.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TSimplesNacionalCabecalhoController.CancelSimplesNacionalCabecalho(pSessao: String; pId: Integer): TJSONArray;
begin
  objSimplesNacionalCabecalho := TSimplesNacionalCabecalhoVO.Create;
  Result := TJSONArray.Create;
  try
    objSimplesNacionalCabecalho.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objSimplesNacionalCabecalho);
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
    objSimplesNacionalCabecalho.Free;
  end;
end;

end.
