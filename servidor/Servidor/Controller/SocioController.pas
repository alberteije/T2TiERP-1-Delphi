{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [SOCIO] 
                                                                                
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
                                                                                
       t2ti.com@gmail.com
@author Albert Eije
@version 1.0                                                                    
*******************************************************************************}
unit SocioController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TSocioController = class(TController)
  protected
  public
    //consultar
    function Socio(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptSocio(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateSocio(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelSocio(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  SocioVO, T2TiORM, SA, SocioDependenteVO, SocioParticipacaoSocietariaVO;

{ TSocioController }

var
  objSocio: TSocioVO;
  Resultado: Boolean;

function TSocioController.Socio(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TSocioVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TSocioVO>(pFiltro, pPagina, False);
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

function TSocioController.AcceptSocio(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  SocioDependente : TSocioDependenteVO;
  SocioDependenteEnumerator: TEnumerator<TSocioDependenteVO>;
  SocioParticipacaoSocietaria : TSocioParticipacaoSocietariaVO;
  SocioParticipacaoSocietariaEnumerator: TEnumerator<TSocioParticipacaoSocietariaVO>;
begin
  objSocio := TSocioVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objSocio);

      // Dependentes
      SocioDependenteEnumerator := objSocio.ListaSocioDependenteVO.GetEnumerator;
      try
        with SocioDependenteEnumerator do
        begin
          while MoveNext do
          begin
            SocioDependente := Current;
            SocioDependente.IdSocio := UltimoID;
            TT2TIORM.Inserir(SocioDependente);
          end;
        end;
      finally
        SocioDependenteEnumerator.Free;
      end;

      // Participacao societaria
      SocioParticipacaoSocietariaEnumerator := objSocio.ListaSocioParticipacaoSocietariaVO.GetEnumerator;
      try
        with SocioParticipacaoSocietariaEnumerator do
        begin
          while MoveNext do
          begin
            SocioParticipacaoSocietaria := Current;
            SocioParticipacaoSocietaria.IdSocio := UltimoID;
            TT2TIORM.Inserir(SocioParticipacaoSocietaria);
          end;
        end;
      finally
        SocioParticipacaoSocietariaEnumerator.Free;
      end;

      Result := Socio(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objSocio.Free;
  end;
end;

function TSocioController.UpdateSocio(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objSocioOld: TSocioVO;
  SocioDependenteEnumerator: TEnumerator<TSocioDependenteVO>;
  SocioParticipacaoSocietariaEnumerator: TEnumerator<TSocioParticipacaoSocietariaVO>;
begin
 //Objeto Novo
  objSocio := TSocioVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objSocioOld := TSocioVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    // Verifica se houve alterações no objeto principal
    if objSocio.MainObject.ToJSONString <> objSocioOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objSocio, objSocioOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Dependentes
    try
      SocioDependenteEnumerator := objSocio.ListaSocioDependenteVO.GetEnumerator;
      with SocioDependenteEnumerator do
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

    // Participacao societaria
    try
      SocioParticipacaoSocietariaEnumerator := objSocio.ListaSocioParticipacaoSocietariaVO.GetEnumerator;
      with SocioParticipacaoSocietariaEnumerator do
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
    objSocio.Free;
  end;
end;

function TSocioController.CancelSocio(pSessao: String; pId: Integer): TJSONArray;
begin
  objSocio := TSocioVO.Create;
  Result := TJSONArray.Create;
  try
    objSocio.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objSocio);
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
    objSocio.Free;
  end;
end;

end.
