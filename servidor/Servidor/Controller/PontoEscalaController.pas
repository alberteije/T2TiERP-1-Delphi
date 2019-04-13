{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [PONTO_ESCALA] 
                                                                                
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
                                                                                
@author Albert Eije
@version 1.0                                                                    
*******************************************************************************}
unit PontoEscalaController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon,
  PontoTurmaVO;

type
  TPontoEscalaController = class(TController)
  protected
  public
    //consultar
    function PontoEscala(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPontoEscala(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePontoEscala(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPontoEscala(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  PontoEscalaVO, T2TiORM, SA;

{ TPontoEscalaController }

var
  objPontoEscala: TPontoEscalaVO;
  Resultado: Boolean;

function TPontoEscalaController.PontoEscala(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TPontoEscalaVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TPontoEscalaVO>(pFiltro, pPagina, False);
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

function TPontoEscalaController.AcceptPontoEscala(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  PontoTurma: TPontoTurmaVO;
  PontoTurmaEnumerator: TEnumerator<TPontoTurmaVO>;
begin
  objPontoEscala := TPontoEscalaVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPontoEscala);

      // Turmas
      PontoTurmaEnumerator := objPontoEscala.ListaPontoTurmaVO.GetEnumerator;
      try
        with PontoTurmaEnumerator do
        begin
          while MoveNext do
          begin
            PontoTurma := Current;
            PontoTurma.IdPontoEscala := UltimoID;
            TT2TiORM.Inserir(PontoTurma);
          end;
        end;
      finally
        PontoTurmaEnumerator.Free;
      end;

      Result := PontoEscala(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPontoEscala.Free;
  end;
end;

function TPontoEscalaController.UpdatePontoEscala(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  PontoTurmaEnumerator: TEnumerator<TPontoTurmaVO>;
  objPontoEscalaOld: TPontoEscalaVO;
begin
 //Objeto Novo
  objPontoEscala := TPontoEscalaVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objPontoEscalaOld := TPontoEscalaVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objPontoEscala.MainObject.ToJSONString <> objPontoEscalaOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objPontoEscala, objPontoEscalaOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Turmas
    try
      PontoTurmaEnumerator := objPontoEscala.ListaPontoTurmaVO.GetEnumerator;
      with PontoTurmaEnumerator do
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
    objPontoEscala.Free;
    PontoTurmaEnumerator.Free;
  end;
end;

function TPontoEscalaController.CancelPontoEscala(pSessao: String; pId: Integer): TJSONArray;
begin
  objPontoEscala := TPontoEscalaVO.Create;
  Result := TJSONArray.Create;
  try
    objPontoEscala.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPontoEscala);
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
    objPontoEscala.Free;
  end;
end;

end.
