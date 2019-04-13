{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [VIEW_PONTO_ESCALA_TURMA] 
                                                                                
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
unit ViewPontoEscalaTurmaController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TViewPontoEscalaTurmaController = class(TController)
  protected
  public
    //consultar
    function ViewPontoEscalaTurma(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptViewPontoEscalaTurma(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateViewPontoEscalaTurma(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelViewPontoEscalaTurma(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ViewPontoEscalaTurmaVO, T2TiORM, SA;

{ TViewPontoEscalaTurmaController }

var
  objViewPontoEscalaTurma: TViewPontoEscalaTurmaVO;
  Resultado: Boolean;

function TViewPontoEscalaTurmaController.ViewPontoEscalaTurma(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TViewPontoEscalaTurmaVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TViewPontoEscalaTurmaVO>(pFiltro, pPagina, False);
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

function TViewPontoEscalaTurmaController.AcceptViewPontoEscalaTurma(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objViewPontoEscalaTurma := TViewPontoEscalaTurmaVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objViewPontoEscalaTurma);
      Result := ViewPontoEscalaTurma(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objViewPontoEscalaTurma.Free;
  end;
end;

function TViewPontoEscalaTurmaController.UpdateViewPontoEscalaTurma(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objViewPontoEscalaTurmaOld: TViewPontoEscalaTurmaVO;
begin
 //Objeto Novo
  objViewPontoEscalaTurma := TViewPontoEscalaTurmaVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objViewPontoEscalaTurmaOld := TViewPontoEscalaTurmaVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objViewPontoEscalaTurma, objViewPontoEscalaTurmaOld);
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
    objViewPontoEscalaTurma.Free;
  end;
end;

function TViewPontoEscalaTurmaController.CancelViewPontoEscalaTurma(pSessao: String; pId: Integer): TJSONArray;
begin
  objViewPontoEscalaTurma := TViewPontoEscalaTurmaVO.Create;
  Result := TJSONArray.Create;
  try
    objViewPontoEscalaTurma.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objViewPontoEscalaTurma);
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
    objViewPontoEscalaTurma.Free;
  end;
end;

end.
