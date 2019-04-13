{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [ORCAMENTO_EMPRESARIAL] 
                                                                                
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
           t2ti.com@gmail.com</p>                                               
                                                                                
fernandololiver@gmail.com
@author @author Fernando L Oliveira
@version 1.0                                                                    
*******************************************************************************}
unit OrcamentoEmpresarialController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TOrcamentoEmpresarialController = class(TController)
  protected
  public
    // consultar
    function OrcamentoEmpresarial(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptOrcamentoEmpresarial(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateOrcamentoEmpresarial(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelOrcamentoEmpresarial(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  OrcamentoEmpresarialVO, OrcamentoDetalheVO, T2TiORM, SA;

{ TOrcamentoEmpresarialController }

var
  objOrcamentoEmpresarial: TOrcamentoEmpresarialVO;
  Resultado: Boolean;

function TOrcamentoEmpresarialController.OrcamentoEmpresarial(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TOrcamentoEmpresarialVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TOrcamentoEmpresarialVO>(pFiltro, pPagina, False);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(Result.ToString);
end;

function TOrcamentoEmpresarialController.AcceptOrcamentoEmpresarial(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  OrcamentoDetalhe: TOrcamentoDetalheVO;
  OrcamentoDetalheEnumerator: TEnumerator<TOrcamentoDetalheVO>;
begin
  objOrcamentoEmpresarial := TOrcamentoEmpresarialVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objOrcamentoEmpresarial);

      // Detalhe do orçamento
      OrcamentoDetalheEnumerator := objOrcamentoEmpresarial.ListaOrcamentoDetalheVO.GetEnumerator;
      try
        with OrcamentoDetalheEnumerator do
        begin
          while MoveNext do
          begin
            OrcamentoDetalhe := Current;
            OrcamentoDetalhe.IdOrcamentoEmpresarial := UltimoID;
            TT2TiORM.Inserir(OrcamentoDetalhe);
          end;
        end;
      finally
        OrcamentoDetalheEnumerator.Free;
      end;

      Result := OrcamentoEmpresarial(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objOrcamentoEmpresarial.Free;
  end;
end;

function TOrcamentoEmpresarialController.UpdateOrcamentoEmpresarial(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  OrcamentoDetalheEnumerator: TEnumerator<TOrcamentoDetalheVO>;
  objOrcamentoEmpresarialOld: TOrcamentoEmpresarialVO;
begin
  // Objeto Novo
  objOrcamentoEmpresarial := TOrcamentoEmpresarialVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objOrcamentoEmpresarialOld := TOrcamentoEmpresarialVO.Create((pObjeto as TJSONArray).Get(1));

  Result := TJSONArray.Create;
  try
    // Verifica se houve alterações no objeto principal
    if objOrcamentoEmpresarial.MainObject.ToJSONString <> objOrcamentoEmpresarialOld.MainObject.ToJSONString then
    begin
    try
      Resultado := TT2TiORM.Alterar(objOrcamentoEmpresarial, objOrcamentoEmpresarialOld);
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
      OrcamentoDetalheEnumerator := objOrcamentoEmpresarial.ListaOrcamentoDetalheVO.GetEnumerator;
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
    objOrcamentoEmpresarial.Free;
  end;
end;

function TOrcamentoEmpresarialController.CancelOrcamentoEmpresarial(pSessao: String; pId: Integer): TJSONArray;
begin
  objOrcamentoEmpresarial := TOrcamentoEmpresarialVO.Create;
  Result := TJSONArray.Create;
  try
    objOrcamentoEmpresarial.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objOrcamentoEmpresarial);
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
    objOrcamentoEmpresarial.Free;
  end;
end;

end.
