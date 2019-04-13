{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [CONTABIL_DRE_CABECALHO] 
                                                                                
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
unit ContabilDreCabecalhoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TContabilDreCabecalhoController = class(TController)
  protected
  public
    //consultar
    function ContabilDreCabecalho(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptContabilDreCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateContabilDreCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelContabilDreCabecalho(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ContabilDreCabecalhoVO, ContabilDreDetalheVO, T2TiORM, SA;

{ TContabilDreCabecalhoController }

var
  objContabilDreCabecalho: TContabilDreCabecalhoVO;
  Resultado: Boolean;

function TContabilDreCabecalhoController.ContabilDreCabecalho(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TContabilDreCabecalhoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TContabilDreCabecalhoVO>(pFiltro, pPagina, False);
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

function TContabilDreCabecalhoController.AcceptContabilDreCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  ContabilDreDetalheVO: TContabilDreDetalheVO;
  ContabilDreDetalheEnumerator: TEnumerator<TContabilDreDetalheVO>;
begin
  objContabilDreCabecalho := TContabilDreCabecalhoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objContabilDreCabecalho);

      // Detalhes
      ContabilDreDetalheEnumerator := objContabilDreCabecalho.ListaContabilDreDetalheVO.GetEnumerator;
      try
        with ContabilDreDetalheEnumerator do
        begin
          while MoveNext do
          begin
            ContabilDreDetalheVO := Current;
            ContabilDreDetalheVO.IdContabilDreCabecalho := UltimoID;
            TT2TiORM.Inserir(ContabilDreDetalheVO);
          end;
        end;
      finally
        ContabilDreDetalheEnumerator.Free;
      end;

      Result := ContabilDreCabecalho(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objContabilDreCabecalho.Free;
  end;
end;

function TContabilDreCabecalhoController.UpdateContabilDreCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objContabilDreCabecalhoOld: TContabilDreCabecalhoVO;
  ContabilDreDetalheEnumerator: TEnumerator<TContabilDreDetalheVO>;
begin
 //Objeto Novo
  objContabilDreCabecalho := TContabilDreCabecalhoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objContabilDreCabecalhoOld := TContabilDreCabecalhoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objContabilDreCabecalho.MainObject.ToJSONString <> objContabilDreCabecalhoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objContabilDreCabecalho, objContabilDreCabecalhoOld);
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
      ContabilDreDetalheEnumerator := objContabilDreCabecalho.ListaContabilDreDetalheVO.GetEnumerator;
      with ContabilDreDetalheEnumerator do
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
    ContabilDreDetalheEnumerator.Free;
    objContabilDreCabecalho.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TContabilDreCabecalhoController.CancelContabilDreCabecalho(pSessao: String; pId: Integer): TJSONArray;
begin
  objContabilDreCabecalho := TContabilDreCabecalhoVO.Create;
  Result := TJSONArray.Create;
  try
    objContabilDreCabecalho.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objContabilDreCabecalho);
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
    objContabilDreCabecalho.Free;
  end;
end;

end.
