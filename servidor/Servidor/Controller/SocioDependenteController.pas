{*******************************************************************************
Title: SOMAR ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [SOCIO_DEPENDENTE] 
                                                                                
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
                                                                                
@author Antonio Luiz Arantes (alaran@terra.com.br)                    
@version 1.0                                                                    
*******************************************************************************}
unit SocioDependenteController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TSocioDependenteController = class(TController)
  protected
  public
    //consultar
    function SocioDependente(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptSocioDependente(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateSocioDependente(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelSocioDependente(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  SocioDependenteVO, T2TiORM, SA;

{ TSocioDependenteController }

var
  objSocioDependente: TSocioDependenteVO;
  Resultado: Boolean;


function TSocioDependenteController.SocioDependente(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    Result := TT2TiORM.Consultar<TSocioDependenteVO>(pFiltro, pPagina);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;
end;

function TSocioDependenteController.AcceptSocioDependente(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objSocioDependente := TSocioDependenteVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objSocioDependente);
      Result := SocioDependente(pSessao, 'ID = ' + IntToStr(UltimoID),0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objSocioDependente.Free;
  end;
end;

function TSocioDependenteController.UpdateSocioDependente(pSessao: String; pObjeto: TJSONValue): TJSONArray;
begin
  objSocioDependente := TSocioDependenteVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objSocioDependente);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    if Resultado then
      Result.AddElement(TJSOnString.Create);
    objSocioDependente.Free;
  end;
end;

function TSocioDependenteController.CancelSocioDependente(pSessao: String; pId: Integer): TJSONArray;
begin
  objSocioDependente := TSocioDependenteVO.Create;
  Result := TJSONArray.Create;
  try
    objSocioDependente.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objSocioDependente);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    if Resultado then
      Result.AddElement(TJSOnString.Create);
    objSocioDependente.Free;
  end;
end;

end.
