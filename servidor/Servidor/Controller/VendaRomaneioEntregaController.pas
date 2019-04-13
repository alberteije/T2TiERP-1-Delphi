{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [VENDA_ROMANEIO_ENTREGA] 
                                                                                
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
unit VendaRomaneioEntregaController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TVendaRomaneioEntregaController = class(TController)
  protected
  public
    //consultar
    function VendaRomaneioEntrega(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptVendaRomaneioEntrega(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateVendaRomaneioEntrega(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelVendaRomaneioEntrega(pSessao: String; pId: Integer): TJSONArray;
    function CancelVendaVinculada(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  VendaRomaneioEntregaVO, T2TiORM, SA, Biblioteca, VendaCabecalhoVO;

{ TVendaRomaneioEntregaController }

var
  objVendaRomaneioEntrega: TVendaRomaneioEntregaVO;
  Resultado: Boolean;

function TVendaRomaneioEntregaController.VendaRomaneioEntrega(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TVendaRomaneioEntregaVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TVendaRomaneioEntregaVO>(pFiltro, pPagina, False);
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

function TVendaRomaneioEntregaController.AcceptVendaRomaneioEntrega(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  VendasVinculadas: TStringList;
  I: Integer;
begin
  objVendaRomaneioEntrega := TVendaRomaneioEntregaVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objVendaRomaneioEntrega);

      // Vendas Vinculadas
      VendasVinculadas := TStringList.Create;
      Split('|', objVendaRomaneioEntrega.VendasVinculadas, VendasVinculadas);
      for I := 1 to VendasVinculadas.Count - 1 do
      begin
        TT2TiORM.ComandoSQL('update VENDA_CABECALHO set ID_VENDA_ROMANEIO_ENTREGA=' + IntToStr(UltimoID) + ' where ID= ' + VendasVinculadas[I]);
      end;

      Result := VendaRomaneioEntrega(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objVendaRomaneioEntrega.Free;
  end;
end;

function TVendaRomaneioEntregaController.UpdateVendaRomaneioEntrega(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objVendaRomaneioEntregaOld: TVendaRomaneioEntregaVO;
  VendasVinculadas: TStringList;
  I: Integer;
begin
 //Objeto Novo
  objVendaRomaneioEntrega := TVendaRomaneioEntregaVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objVendaRomaneioEntregaOld := TVendaRomaneioEntregaVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objVendaRomaneioEntrega, objVendaRomaneioEntregaOld);

      // Vendas Vinculadas
      VendasVinculadas := TStringList.Create;
      Split('|', objVendaRomaneioEntrega.VendasVinculadas, VendasVinculadas);
      for I := 0 to VendasVinculadas.Count - 1 do
      begin
        TT2TiORM.ComandoSQL('update VENDA_CABECALHO set ID_VENDA_ROMANEIO_ENTREGA=' + IntToStr(objVendaRomaneioEntrega.Id) + ' where ID= ' + VendasVinculadas[I]);
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
    objVendaRomaneioEntrega.Free;
  end;
end;

function TVendaRomaneioEntregaController.CancelVendaRomaneioEntrega(pSessao: String; pId: Integer): TJSONArray;
begin
  objVendaRomaneioEntrega := TVendaRomaneioEntregaVO.Create;
  Result := TJSONArray.Create;
  try
    objVendaRomaneioEntrega.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objVendaRomaneioEntrega);
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
    objVendaRomaneioEntrega.Free;
  end;
end;

function TVendaRomaneioEntregaController.CancelVendaVinculada(pSessao: String; pId: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    try
      TT2TiORM.ComandoSQL('update VENDA_CABECALHO set ID_VENDA_ROMANEIO_ENTREGA=null where ID= ' + IntToStr(pId));
      Resultado := True;
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
  end;
end;

end.
