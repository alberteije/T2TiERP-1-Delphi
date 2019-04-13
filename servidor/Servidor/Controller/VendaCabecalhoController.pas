{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [VENDA_CABECALHO] 
                                                                                
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
unit VendaCabecalhoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TVendaCabecalhoController = class(TController)
  protected
  public
    // consultar
    function VendaCabecalho(pSessao: string; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptVendaCabecalho(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateVendaCabecalho(pSessao: string; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelVendaCabecalho(pSessao: string; pId: Integer): TJSONArray;
  end;

implementation

uses
  VendaCabecalhoVO, T2TiORM, Biblioteca, VendaDetalheVO, SA, VendaComissaoVO;

{ TVendaCabecalhoController }

var
  objVendaCabecalho: TVendaCabecalhoVO;
  Resultado: Boolean;

function TVendaCabecalhoController.VendaCabecalho(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TVendaCabecalhoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TVendaCabecalhoVO>(pFiltro, pPagina, False);
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

function TVendaCabecalhoController.AcceptVendaCabecalho(pSessao: string; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  VendaDetalhe: TVendaDetalheVO;
  VendaDetalheEnumerator: TEnumerator<TVendaDetalheVO>;
  VendaComissaoVO: TVendaComissaoVO;
begin
  objVendaCabecalho := TVendaCabecalhoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objVendaCabecalho);

      // Comissão
      VendaComissaoVO := TVendaComissaoVO.Create;
      VendaComissaoVO.IdVendaCabecalho := UltimoID;
      VendaComissaoVO.IdVendedor := objVendaCabecalho.IdVendedor;
      VendaComissaoVO.ValorVenda := objVendaCabecalho.ValorSubtotal - objVendaCabecalho.ValorDesconto;
      VendaComissaoVO.TipoContabil := 'C';
      VendaComissaoVO.ValorComissao := objVendaCabecalho.ValorComissao;
      VendaComissaoVO.Situacao := 'A';
      VendaComissaoVO.DataLancamento := now;
      TT2TiORM.Inserir(VendaComissaoVO);

      // Lista Venda Detalhe
      VendaDetalheEnumerator := objVendaCabecalho.ListaVendaDetalheVO.GetEnumerator;
      try
        with VendaDetalheEnumerator do
        begin
          while MoveNext do
          begin
            VendaDetalhe := Current;
            VendaDetalhe.IdVendaCabecalho := UltimoID;
            TT2TiORM.Inserir(VendaDetalhe);
          end;
        end;
      finally
        VendaDetalheEnumerator.Free;
      end;


    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

  finally
    objVendaCabecalho.Free;
  end;

  Result := VendaCabecalho(pSessao, 'ID=' + IntToStr(UltimoID), 0);
end;

function TVendaCabecalhoController.UpdateVendaCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  VendaDetalheEnumerator: TEnumerator<TVendaDetalheVO>;
  objVendaCabecalhoOld: TVendaCabecalhoVO;
begin
  // Objeto Novo
  objVendaCabecalho := TVendaCabecalhoVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objVendaCabecalhoOld := TVendaCabecalhoVO.Create((pObjeto as TJSONArray).Get(1));

  Result := TJSONArray.Create;
  try
    // Verifica se houve alterações no objeto principal
    if objVendaCabecalho.MainObject.ToJSONString <> objVendaCabecalhoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objVendaCabecalho, objVendaCabecalhoOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    // Comissão
    objVendaCabecalho.VendaComissaoVO.IdVendaCabecalho := objVendaCabecalho.Id;
    objVendaCabecalho.VendaComissaoVO.IdVendedor := objVendaCabecalho.IdVendedor;
    objVendaCabecalho.VendaComissaoVO.ValorVenda := objVendaCabecalho.ValorSubtotal - objVendaCabecalho.ValorDesconto;
    objVendaCabecalho.VendaComissaoVO.TipoContabil := 'C';
    objVendaCabecalho.VendaComissaoVO.ValorComissao := objVendaCabecalho.ValorComissao;
    objVendaCabecalho.VendaComissaoVO.Situacao := 'A';
    objVendaCabecalho.VendaComissaoVO.DataLancamento := now;
    if objVendaCabecalho.VendaComissaoVO.Id > 0 then
      TT2TiORM.Alterar(objVendaCabecalho.VendaComissaoVO)
    else
      TT2TiORM.Inserir(objVendaCabecalho.VendaComissaoVO);

    // Lista Orçamento Pedido Detalhe
    try
      VendaDetalheEnumerator := objVendaCabecalho.ListaVendaDetalheVO.GetEnumerator;
      with VendaDetalheEnumerator do
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
    VendaDetalheEnumerator.Free;
    objVendaCabecalho.Free;

    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TVendaCabecalhoController.CancelVendaCabecalho(pSessao: string; pId: Integer): TJSONArray;
begin
  objVendaCabecalho := TVendaCabecalhoVO.Create;
  Result := TJSONArray.Create;
  try
    objVendaCabecalho.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objVendaCabecalho);
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
    objVendaCabecalho.Free;
  end;
end;

end.
