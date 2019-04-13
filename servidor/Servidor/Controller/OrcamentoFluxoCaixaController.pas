{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [ORCAMENTO_FLUXO_CAIXA] 
                                                                                
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
unit OrcamentoFluxoCaixaController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TOrcamentoFluxoCaixaController = class(TController)
  protected
  public
    //consultar
    function OrcamentoFluxoCaixa(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptOrcamentoFluxoCaixa(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateOrcamentoFluxoCaixa(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelOrcamentoFluxoCaixa(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  OrcamentoFluxoCaixaVO, T2TiORM, SA, OrcamentoFluxoCaixaDetalheVO;

{ TOrcamentoFluxoCaixaController }

var
  objOrcamentoFluxoCaixa: TOrcamentoFluxoCaixaVO;
  Resultado: Boolean;

function TOrcamentoFluxoCaixaController.OrcamentoFluxoCaixa(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TOrcamentoFluxoCaixaVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TOrcamentoFluxoCaixaVO>(pFiltro, pPagina, False);
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

function TOrcamentoFluxoCaixaController.AcceptOrcamentoFluxoCaixa(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  OrcamentoDetalhe: TOrcamentoFluxoCaixaDetalheVO;
  OrcamentoDetalheEnumerator: TEnumerator<TOrcamentoFluxoCaixaDetalheVO>;
begin
  objOrcamentoFluxoCaixa := TOrcamentoFluxoCaixaVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objOrcamentoFluxoCaixa);

      // Detalhe do orçamento
      OrcamentoDetalheEnumerator := objOrcamentoFluxoCaixa.ListaOrcamentoDetalheVO.GetEnumerator;
      try
        with OrcamentoDetalheEnumerator do
        begin
          while MoveNext do
          begin
            OrcamentoDetalhe := Current;
            OrcamentoDetalhe.IdOrcamentoFluxoCaixa := UltimoID;
            TT2TiORM.Inserir(OrcamentoDetalhe);
          end;
        end;
      finally
        OrcamentoDetalheEnumerator.Free;
      end;

      Result := OrcamentoFluxoCaixa(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objOrcamentoFluxoCaixa.Free;
  end;
end;

function TOrcamentoFluxoCaixaController.UpdateOrcamentoFluxoCaixa(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objOrcamentoFluxoCaixaOld: TOrcamentoFluxoCaixaVO;
  OrcamentoDetalheEnumerator: TEnumerator<TOrcamentoFluxoCaixaDetalheVO>;
begin
 //Objeto Novo
  objOrcamentoFluxoCaixa := TOrcamentoFluxoCaixaVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objOrcamentoFluxoCaixaOld := TOrcamentoFluxoCaixaVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objOrcamentoFluxoCaixa.MainObject.ToJSONString <> objOrcamentoFluxoCaixaOld.MainObject.ToJSONString then
    begin
    try
      Resultado := TT2TiORM.Alterar(objOrcamentoFluxoCaixa, objOrcamentoFluxoCaixaOld);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
     end;
    end;

    // Detalhe do orçamento
    try
      OrcamentoDetalheEnumerator := objOrcamentoFluxoCaixa.ListaOrcamentoDetalheVO.GetEnumerator;
      with OrcamentoDetalheEnumerator do
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
    objOrcamentoFluxoCaixa.Free;
  end;
end;

function TOrcamentoFluxoCaixaController.CancelOrcamentoFluxoCaixa(pSessao: String; pId: Integer): TJSONArray;
begin
  objOrcamentoFluxoCaixa := TOrcamentoFluxoCaixaVO.Create;
  Result := TJSONArray.Create;
  try
    objOrcamentoFluxoCaixa.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objOrcamentoFluxoCaixa);
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
    objOrcamentoFluxoCaixa.Free;
  end;
end;

end.
