{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [NFE_CABECALHO] 
                                                                                
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
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit EntradaNFController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TEntradaNFController = class(TController)
  protected
  public
    //consultar
    function NfeCabecalho(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptNfeCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateNfeCabecalho(pSessao: String; pObjeto: TJSONValue): Boolean;
    //excluir
    function CancelNfeCabecalho(pSessao: String; pId: Integer): Boolean;
  end;

implementation

uses
  NfeCabecalhoVO, T2TiORM, SA, Biblioteca, NfeDestinatarioVO, NfeLocalEntregaVO,
  NfeLocalRetiradaVO, NfeTransporteVO, NfeFaturaVO, NfeCupomFiscalReferenciadoVO,
  NfeReferenciadaVO, NFeDetalheVO, NfeDuplicataVO, ProdutoLoteVO;

{ TEntradaNFController }

var
  objNfeCabecalho: TNfeCabecalhoVO;


function TEntradaNFController.NfeCabecalho(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TT2TiORM.Consultar<TNfeCabecalhoVO>(pFiltro, pPagina);
end;

function TEntradaNFController.AcceptNfeCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  NfeDestinatario : TNfeDestinatarioVO;
  NfeLocalEntrega : TNfeLocalEntregaVO;
  NfeLocalRetirada: TNfeLocalRetiradaVO;
  NfeTransporte:    TNfeTransporteVO;
  NfeFatura:        TNfeFaturaVO;
  NfeCupomFiscal:   TNfeCupomFiscalReferenciadoVO;
  NfeReferenciada:  TNfeReferenciadaVO;
  NFeDetalhe:       TNFeDetalheVO;
  NFeDuplicata:     TNFeDuplicataVO;
  ProdutoLote:      TProdutoLoteVO;

  NfeCupomFiscalEnumerator:   TEnumerator<TNfeCupomFiscalReferenciadoVO>;
  NfeReferenciadaEnumerator:  TEnumerator<TNfeReferenciadaVO>;
  NFeDetalheEnumerator:       TEnumerator<TNFeDetalheVO>;
  NFeDuplicataEnumerator:     TEnumerator<TNFeDuplicataVO>;
begin
  result := TJSONArray.Create;
  (*
  objNfeCabecalho := TNfeCabecalhoVO.Create(pObjeto);
  try
    try
      //NfeCabecalho
      UltimoID := TT2TiORM.Inserir(objNfeCabecalho);
      Result := NfeCabecalho(pSessao, 'ID = ' + IntToStr(UltimoID),0);

      //NfeDestinatario
      if Assigned(objNfeCabecalho.NfeDestinatario) then
      begin
        objNfeCabecalho.NfeDestinatario.IdNfeCabecalho := UltimoID;
        TT2TiORM.Inserir(objNfeCabecalho.NfeDestinatario);
      end;

      //NfeCupomFiscal
      NfeCupomFiscalEnumerator := objNfeCabecalho.NfeCupomFiscal.GetEnumerator;
      try
        with NfeCupomFiscalEnumerator do
        begin
          while MoveNext do
          begin
            NfeCupomFiscal := Current;
            NfeCupomFiscal.IdNfeCabecalho := UltimoID;
            TT2TiORM.Inserir(NfeCupomFiscal);
          end;
        end;
      finally
        NfeCupomFiscalEnumerator.Free;
      end;

      //NfeReferenciada
      NfeReferenciadaEnumerator := objNfeCabecalho.NfeReferenciada.GetEnumerator;
      try
        with NfeReferenciadaEnumerator do
        begin
          while MoveNext do
          begin
            NfeReferenciada := Current;
            NfeReferenciada.IdNfeCabecalho := UltimoID;
            TT2TiORM.Inserir(NfeReferenciada);
          end;
        end;
      finally
        NfeReferenciadaEnumerator.Free;
      end;

      //NfeLocalEntrega
      if Assigned(objNfeCabecalho.NfeLocalEntrega) then
      begin
        objNfeCabecalho.NfeLocalEntrega.IdNfeCabecalho := UltimoID;
        TT2TiORM.Inserir(objNfeCabecalho.NfeLocalEntrega);
      end;

      //NfeLocalRetirada
      if Assigned(objNfeCabecalho.NfeLocalRetirada) then
      begin
        objNfeCabecalho.NfeLocalRetirada.IdNfeCabecalho := UltimoID;
        TT2TiORM.Inserir(objNfeCabecalho.NfeLocalRetirada);
      end;

      //NfeTransporte
      if Assigned(objNfeCabecalho.NfeTransporte) then
      begin
        objNfeCabecalho.NfeTransporte.IdNfeCabecalho := UltimoID;
        TT2TiORM.Inserir(objNfeCabecalho.NfeTransporte);
      end;

      //NfeFatura
      if Assigned(objNfeCabecalho.NfeFatura) then
      begin
        objNfeCabecalho.NfeFatura.IdNfeCabecalho := UltimoID;
        TT2TiORM.Inserir(objNfeCabecalho.NfeFatura);
        {//NfeDuplicata
        NfeDuplicataEnumerator := objNfeCabecalho.NfeFatura.NfeDuplicata.GetEnumerator;
        try
          with NfeDuplicataEnumerator do
          begin
            while MoveNext do
            begin
              NfeDuplicata := Current;
              NfeDuplicata.IdNfeFatura    := Current.Id;
              NfeDuplicata.Numero         := Current.Numero;
              NfeDuplicata.DataVencimento := Current.DataVencimento;
              NfeDuplicata.Valor          := Current.Valor;
              TT2TiORM.Inserir(NfeDuplicata);
            end;
          end;
        finally
          NFeDetalheEnumerator.Free;
        end;}
      end;

      //NFeDetalhe
      NFeDetalheEnumerator := objNfeCabecalho.NFeDetalhe.GetEnumerator;
      try
        with NFeDetalheEnumerator do
        begin
          while MoveNext do
          begin
            NFeDetalhe := Current;
            NFeDetalhe.IdNfeCabecalho := UltimoID;
            TT2TiORM.Inserir(NFeDetalhe);
            //Atualiza o Estoque
            TT2TiORM.ComandoSQL('update PRODUTO set QUANTIDADE_ESTOQUE=QUANTIDADE_ESTOQUE+'+FloatToStr(current.QuantidadeComercial) + ' where GTIN='+ current.Gtin);
          end;
        end;
      finally
        NFeDetalheEnumerator.Free;
      end;

      //Lote do Produto
      if Assigned(objNfeCabecalho.ProdutoLote) then
      begin
        TT2TiORM.Inserir(objNfeCabecalho.ProdutoLote);
      end;

    except
      Result := TJSONArray.Create;
    end;
  finally
    objNfeCabecalho.Free;
  end;
  *)
end;

function TEntradaNFController.UpdateNfeCabecalho(pSessao: String; pObjeto: TJSONValue): Boolean;
begin
  objNfeCabecalho := TNfeCabecalhoVO.Create(pObjeto);
  try
    try
      Result := TT2TiORM.Alterar(objNfeCabecalho);
    except
      Result := False;
    end;
  finally
    objNfeCabecalho.Free;
  end;
end;

function TEntradaNFController.CancelNfeCabecalho(pSessao: String; pId: Integer): Boolean;
begin
  objNfeCabecalho := TNfeCabecalhoVO.Create;
  try
    objNfeCabecalho.Id := pId;
    try
      Result := TT2TiORM.Excluir(objNfeCabecalho);
    except
      Result := False;
    end;
  finally
    objNfeCabecalho.Free;
  end;
end;

end.
