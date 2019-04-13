{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [FIN_EXTRATO_CONTA_BANCO] 
                                                                                
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
unit FinExtratoContaBancoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TFinExtratoContaBancoController = class(TController)
  protected
  public
    //consultar
    function FinExtratoContaBanco(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptFinExtratoContaBanco(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateFinExtratoContaBanco(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelFinExtratoContaBanco(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  FinExtratoContaBancoVO, T2TiORM, SA;

{ TFinExtratoContaBancoController }

var
  objFinExtratoContaBanco: TFinExtratoContaBancoVO;
  Resultado: Boolean;

function TFinExtratoContaBancoController.FinExtratoContaBanco(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TFinExtratoContaBancoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TFinExtratoContaBancoVO>(pFiltro, pPagina, False);
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

function TFinExtratoContaBancoController.AcceptFinExtratoContaBanco(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objFinExtratoContaBanco := TFinExtratoContaBancoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objFinExtratoContaBanco);
      Result := FinExtratoContaBanco(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFinExtratoContaBanco.Free;
  end;
end;

function TFinExtratoContaBancoController.UpdateFinExtratoContaBanco(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  ListaExtratoJson: TJSONValue;
  i: Integer;
begin
  ListaExtratoJson := (pObjeto as TJSONArray).Get(0);

  Result := TJSONArray.Create;
  try
    try
      for i := 0 to (ListaExtratoJson as TJSONArray).Size - 1 do
      begin
        objFinExtratoContaBanco := TFinExtratoContaBancoVO.Create((ListaExtratoJson as TJSONArray).Get(i));

        if objFinExtratoContaBanco.Id > 0 then
          Resultado := TT2TiORM.Alterar(objFinExtratoContaBanco)
        else
          Resultado := TT2TiORM.Inserir(objFinExtratoContaBanco) > 0;
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
    objFinExtratoContaBanco.Free;
  end;
end;

function TFinExtratoContaBancoController.CancelFinExtratoContaBanco(pSessao: String; pId: Integer): TJSONArray;
begin
  objFinExtratoContaBanco := TFinExtratoContaBancoVO.Create;
  Result := TJSONArray.Create;
  try
    objFinExtratoContaBanco.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objFinExtratoContaBanco);
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
    objFinExtratoContaBanco.Free;
  end;
end;

end.
