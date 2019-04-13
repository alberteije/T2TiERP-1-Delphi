{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [COMPRA_PEDIDO] 
                                                                                
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
                                                                                
t2ti.com@gmail.com | fernandololiver@gmail.com
@author Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0
*******************************************************************************}
unit CompraPedidoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TCompraPedidoController = class(TController)
  protected
  public
    // consultar
    function CompraPedido(pSessao: string; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptCompraPedido(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateCompraPedido(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelCompraPedido(pSessao: string; pId: Integer): TJSONArray;
  end;

implementation

uses
  CompraPedidoVO, T2TiORM, Biblioteca, CompraPedidoDetalheVO, SA;

{ TCompraPedidoController }

var
  objCompraPedido: TCompraPedidoVO;
  Resultado: Boolean;

function TCompraPedidoController.CompraPedido(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TCompraPedidoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TCompraPedidoVO>(pFiltro, pPagina, False);
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

function TCompraPedidoController.AcceptCompraPedido(pSessao: string; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  CompraPedidoDetalhe: TCompraPedidoDetalheVO;
  CompraPedidoDetalheEnumerator: TEnumerator<TCompraPedidoDetalheVO>;
begin
  objCompraPedido := TCompraPedidoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objCompraPedido);

      // Pedido Detalhe
      CompraPedidoDetalheEnumerator := objCompraPedido.ListaCompraPedidoDetalheVO.GetEnumerator;
      try
        with CompraPedidoDetalheEnumerator do
        begin
          while MoveNext do
          begin
            CompraPedidoDetalhe := Current;
            CompraPedidoDetalhe.IdCompraPedido := UltimoID;
            TT2TiORM.Inserir(CompraPedidoDetalhe);
          end;
        end;
      finally
        CompraPedidoDetalheEnumerator.Free;
      end;

    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

  finally
    objCompraPedido.Free;
  end;

  Result := CompraPedido(pSessao, 'ID=' + IntToStr(UltimoID), 0);
end;

function TCompraPedidoController.UpdateCompraPedido(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  CompraPedidoDetalheEnumerator: TEnumerator<TCompraPedidoDetalheVO>;
  objCompraPedidoOld: TCompraPedidoVO;
begin
  // Objeto Novo
  objCompraPedido := TCompraPedidoVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objCompraPedidoOld := TCompraPedidoVO.Create((pObjeto as TJSONArray).Get(1));

  Result := TJSONArray.Create;
  try
    // Verifica se houve alterações no objeto principal
    if objCompraPedido.MainObject.ToJSONString <> objCompraPedidoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objCompraPedido, objCompraPedidoOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Pedido Detalhe
    try
      CompraPedidoDetalheEnumerator := objCompraPedido.ListaCompraPedidoDetalheVO.GetEnumerator;
      with CompraPedidoDetalheEnumerator do
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
    CompraPedidoDetalheEnumerator.Free;
    objCompraPedido.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TCompraPedidoController.CancelCompraPedido(pSessao: string; pId: Integer): TJSONArray;
begin
  objCompraPedido := TCompraPedidoVO.Create;
  Result := TJSONArray.Create;
  try
    objCompraPedido.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objCompraPedido);
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
    objCompraPedido.Free;
  end;
end;

end.
