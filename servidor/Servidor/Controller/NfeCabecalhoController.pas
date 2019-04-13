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
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0
*******************************************************************************}
unit NfeCabecalhoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TNfeCabecalhoController = class(TController)
  protected
  public
    //consultar
    function NfeCabecalho(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptNfeCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateNfeCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelNfeCabecalho(pSessao: String; pId: Integer; pExcluirQuem: String; pIdProduto: Integer; pQuantidade: Extended): TJSONArray;
  end;

implementation

uses
  NfeCabecalhoVO, T2TiORM, SA,
  //
  NfeReferenciadaVO, NfeEmitenteVO, NfeLocalEntregaVO, NfeLocalRetiradaVO,
  NfeTransporteVO, NfeFaturaVO, NfeDuplicataVO, NfeDetalheVO, ProdutoLoteVO,
  NfeCupomFiscalReferenciadoVO, NfeDetalheImpostoCofinsVO, NfeDetalheImpostoIcmsVO,
  NfeDetalheImpostoPisVO, NfeDetalheImpostoIiVO, NfeDetalheImpostoIssqnVO,
  NfeDetalheImpostoIpiVO, NfeDeclaracaoImportacaoVO, NfeImportacaoDetalheVO,
  NfeDetEspecificoVeiculoVO, NfeDetEspecificoCombustivelVO, NfeDetEspecificoMedicamentoVO,
  NfeDetEspecificoArmamentoVO, NfeNfReferenciadaVO, NfeCteReferenciadoVO,
  NfeProdRuralReferenciadaVO, NfeTransporteReboqueVO, NfeTransporteVolumeVO,
  FiscalNotaFiscalEntradaVO, FiscalNotaFiscalSaidaVO,
  //
  ControleEstoqueController;

{ TNfeCabecalhoController }

var
  objNfeCabecalho: TNfeCabecalhoVO;
  Resultado: Boolean;

function TNfeCabecalhoController.NfeCabecalho(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TNfeCabecalhoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TNfeCabecalhoVO>(pFiltro, pPagina, False);
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

function TNfeCabecalhoController.AcceptNfeCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
  //
  ProdutoLote: TProdutoLoteVO;
  FiscalNotaFiscalSaidaVO: TFiscalNotaFiscalSaidaVO;
  //
  NfeReferenciada: TNfeReferenciadaVO;
  NfeNfReferenciada: TNfeNfReferenciadaVO;
  NfeCteReferenciado: TNfeCteReferenciadoVO;
  NfeCupomFiscalReferenciado: TNfeCupomFiscalReferenciadoVO;
  NfeRuralReferenciada: TNfeProdRuralReferenciadaVO;
  NfeTransporteReboque: TNfeTransporteReboqueVO;
  NfeTransporteVolume: TNfeTransporteVolumeVO;
  NfeDuplicata: TNfeDuplicataVO;
  //
  NfeDetalhe: TNfeDetalheVO;
  NfeDeclaracaoImportacao: TNfeDeclaracaoImportacaoVO;
  NfeImportacaoDetalhe: TNfeImportacaoDetalheVO;
  NfeDetalheEspecificoMedicamento: TNfeDetEspecificoMedicamentoVO;
  NfeDetalheEspecificoArmamento: TNfeDetEspecificoArmamentoVO;
  //
  NfeReferenciadaEnumerator: TEnumerator<TNfeReferenciadaVO>;
  NfReferenciadaEnumerator: TEnumerator<TNfeNfReferenciadaVO>;
  NfeRuralReferenciadaEnumerator: TEnumerator<TNfeProdRuralReferenciadaVO>;
  NfeCteReferenciadoEnumerator: TEnumerator<TNfeCteReferenciadoVO>;
  NfeCupomFiscalReferenciadoEnumerator: TEnumerator<TNfeCupomFiscalReferenciadoVO>;
  NfeTransporteReboqueEnumerator: TEnumerator<TNfeTransporteReboqueVO>;
  NfeTransporteVolumeEnumerator: TEnumerator<TNfeTransporteVolumeVO>;
  NfeDuplicataEnumerator: TEnumerator<TNfeDuplicataVO>;
  //
  NfeDetalheEnumerator: TEnumerator<TNfeDetalheVO>;
  NfeDeclaracaoImportacaoEnumerator: TEnumerator<TNfeDeclaracaoImportacaoVO>;
  NfeDetalheEspecificoMedicamentoEnumerator: TEnumerator<TNfeDetEspecificoMedicamentoVO>;
  NfeDetalheEspecificoArmamentoEnumerator: TEnumerator<TNfeDetEspecificoArmamentoVO>;
  NfeImportacaoDetalheEnumerator: TEnumerator<TNfeImportacaoDetalheVO>;
begin
  objNfeCabecalho := TNfeCabecalhoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objNfeCabecalho);

      { Destinatario }
      if Assigned(objNfeCabecalho.NfeDestinatarioVO) then
      begin
        objNfeCabecalho.NfeDestinatarioVO.IdNfeCabecalho := UltimoID;
        TT2TiORM.Inserir(objNfeCabecalho.NfeDestinatarioVO);
      end;

      { Emitente }
      if Assigned(objNfeCabecalho.NfeEmitenteVO) then
      begin
        objNfeCabecalho.NfeEmitenteVO.IdNfeCabecalho := UltimoID;
        TT2TiORM.Inserir(objNfeCabecalho.NfeEmitenteVO);
      end;

      { Escrituração Entrada }
      if Assigned(objNfeCabecalho.FiscalNotaFiscalEntradaVO) then
      begin
        objNfeCabecalho.FiscalNotaFiscalEntradaVO.IdNfeCabecalho := UltimoID;
        TT2TiORM.Inserir(objNfeCabecalho.FiscalNotaFiscalEntradaVO);
      end;

      { Escrituração Saida }
      if objNfeCabecalho.TipoOperacao = '1' then
      begin
        FiscalNotaFiscalSaidaVO := TFiscalNotaFiscalSaidaVO.Create;
        FiscalNotaFiscalSaidaVO.IdNfeCabecalho := UltimoID;
        FiscalNotaFiscalSaidaVO.Competencia := FormatDateTime('MM/YYYY', objNfeCabecalho.DataEntradaSaida);
        TT2TiORM.Inserir(FiscalNotaFiscalSaidaVO);
      end;

      (* Grupo de informação dos documentos referenciados *)
      {NF-e Referenciada}
      if Assigned(objNfeCabecalho.ListaNfeReferenciadaVO) then
      begin
        NfeReferenciadaEnumerator := objNfeCabecalho.ListaNfeReferenciadaVO.GetEnumerator;
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
      end;

      {NF Referenciada}
      if Assigned(objNfeCabecalho.ListaNfeNfReferenciadaVO) then
      begin
        NfReferenciadaEnumerator := objNfeCabecalho.ListaNfeNfReferenciadaVO.GetEnumerator;
        try
          with NfReferenciadaEnumerator do
          begin
            while MoveNext do
            begin
              NfeNfReferenciada := Current;
              NfeNfReferenciada.IdNfeCabecalho := UltimoID;
              TT2TiORM.Inserir(NfeNfReferenciada);
            end;
          end;
        finally
          NfReferenciadaEnumerator.Free;
        end;
      end;

      {NF Rural Referenciada}
      if Assigned(objNfeCabecalho.ListaNfeProdRuralReferenciadaVO) then
      begin
        NfeRuralReferenciadaEnumerator := objNfeCabecalho.ListaNfeProdRuralReferenciadaVO.GetEnumerator;
        try
          with NfeRuralReferenciadaEnumerator do
          begin
            while MoveNext do
            begin
              NfeRuralReferenciada := Current;
              NfeRuralReferenciada.IdNfeCabecalho := UltimoID;
              TT2TiORM.Inserir(NfeRuralReferenciada);
            end;
          end;
        finally
          NfeRuralReferenciadaEnumerator.Free;
        end;
      end;

      {CT-e Referenciado}
      if Assigned(objNfeCabecalho.ListaNfeCteReferenciadoVO) then
      begin
        NfeCteReferenciadoEnumerator := objNfeCabecalho.ListaNfeCteReferenciadoVO.GetEnumerator;
        try
          with NfeCteReferenciadoEnumerator do
          begin
            while MoveNext do
            begin
              NfeCteReferenciado := Current;
              NfeCteReferenciado.IdNfeCabecalho := UltimoID;
              TT2TiORM.Inserir(NfeCteReferenciado);
            end;
          end;
        finally
          NfeCteReferenciadoEnumerator.Free;
        end;
      end;

      {Cupom Fiscal Referenciado}
      if Assigned(objNfeCabecalho.ListaNfeCupomFiscalReferenciadoVO) then
      begin
        NfeCupomFiscalReferenciadoEnumerator := objNfeCabecalho.ListaNfeCupomFiscalReferenciadoVO.GetEnumerator;
        try
          with NfeCupomFiscalReferenciadoEnumerator do
          begin
            while MoveNext do
            begin
              NfeCupomFiscalReferenciado := Current;
              NfeCupomFiscalReferenciado.IdNfeCabecalho := UltimoID;
              TT2TiORM.Inserir(NfeCupomFiscalReferenciado);
            end;
          end;
        finally
          NfeCupomFiscalReferenciadoEnumerator.Free;
        end;
      end;
      (* Fim Grupo de informação dos documentos referenciados *)

      { Local Entrega }
      if Assigned(objNfeCabecalho.NfeLocalEntregaVO) then
      begin
        if objNfeCabecalho.NfeLocalEntregaVO.Id > 0 then
        begin
          objNfeCabecalho.NfeLocalEntregaVO.IdNfeCabecalho := UltimoID;
          TT2TiORM.Inserir(objNfeCabecalho.NfeLocalEntregaVO);
        end;
      end;

      { Local Retirada }
      if Assigned(objNfeCabecalho.NfeLocalRetiradaVO) then
      begin
        if objNfeCabecalho.NfeLocalRetiradaVO.Id > 0 then
        begin
          objNfeCabecalho.NfeLocalRetiradaVO.IdNfeCabecalho := UltimoID;
          TT2TiORM.Inserir(objNfeCabecalho.NfeLocalRetiradaVO);
        end;
      end;


      (* Grupo de Transporte *)
      { Transporte }
      if Assigned(objNfeCabecalho.NfeTransporteVO) then
      begin
        objNfeCabecalho.NfeTransporteVO.IdNfeCabecalho := UltimoID;
        objNfeCabecalho.NfeTransporteVO.Id := TT2TiORM.Inserir(objNfeCabecalho.NfeTransporteVO);

        { Transporte - Reboque }
        if Assigned(objNfeCabecalho.NfeTransporteVO.ListaNfeTransporteReboqueVO) then
        begin
          NfeTransporteReboqueEnumerator := objNfeCabecalho.NfeTransporteVO.ListaNfeTransporteReboqueVO.GetEnumerator;
          try
            with NfeTransporteReboqueEnumerator do
            begin
              while MoveNext do
              begin
                NfeTransporteReboque := Current;
                NfeTransporteReboque.IdNfeTransporte := objNfeCabecalho.NfeTransporteVO.Id;
                TT2TiORM.Inserir(NfeTransporteReboque);
              end;
            end;
          finally
            NfeTransporteReboqueEnumerator.Free;
          end;
        end;

        { Transporte - Volumes }
        if Assigned(objNfeCabecalho.NfeTransporteVO.ListaNfeTransporteVolumeVO) then
        begin
          NfeTransporteVolumeEnumerator := objNfeCabecalho.NfeTransporteVO.ListaNfeTransporteVolumeVO.GetEnumerator;
          try
            with NfeTransporteVolumeEnumerator do
            begin
              while MoveNext do
              begin
                NfeTransporteVolume := Current;
                NfeTransporteVolume.IdNfeTransporte := objNfeCabecalho.NfeTransporteVO.Id;
                TT2TiORM.Inserir(NfeTransporteVolume);
              end;
            end;
          finally
            NfeTransporteVolumeEnumerator.Free;
          end;
        end;
      end;
      (* Fim Grupo de Transporte *)


      (* Grupo de Cobrança *)
      { Fatura }
      if Assigned(objNfeCabecalho.NfeFaturaVO) then
      begin
        if objNfeCabecalho.NfeFaturaVO.Id > 0 then
        begin
          objNfeCabecalho.NfeFaturaVO.IdNfeCabecalho := UltimoID;
          TT2TiORM.Inserir(objNfeCabecalho.NfeFaturaVO);
        end;
      end;

      { Duplicatas }
      if Assigned(objNfeCabecalho.ListaNfeDuplicataVO) then
      begin
        NfeDuplicataEnumerator := objNfeCabecalho.ListaNfeDuplicataVO.GetEnumerator;
        try
          with NfeDuplicataEnumerator do
          begin
            while MoveNext do
            begin
              NfeDuplicata := Current;
              NfeDuplicata.IdNfeCabecalho := UltimoID;
              TT2TiORM.Inserir(NfeDuplicata);
            end;
          end;
        finally
          NfeDuplicataEnumerator.Free;
        end;
      end;
      (* Fim Grupo de Cobrança *)


      (* Grupo de Detalhes *)
      { NFeDetalhe }
      if Assigned(objNfeCabecalho.ListaNfeDetalheVO) then
      begin
        NFeDetalheEnumerator := objNfeCabecalho.ListaNfeDetalheVO.GetEnumerator;
        try
          with NFeDetalheEnumerator do
          begin
            while MoveNext do
            begin
              NFeDetalhe := Current;
              NFeDetalhe.IdNfeCabecalho := UltimoID;
              NFeDetalhe.Id := TT2TiORM.Inserir(NFeDetalhe);

              // Atualiza estoque
              TControleEstoqueController.Create().AtualizarEstoque(pSessao, NFeDetalhe.QuantidadeComercial, NFeDetalhe.IdProduto);

              { Detalhe - Imposto - ICMS }
              if Assigned(NFeDetalhe.NfeDetalheImpostoIcmsVO) then
              begin
                NFeDetalhe.NfeDetalheImpostoIcmsVO.IdNfeDetalhe := NFeDetalhe.Id;
                TT2TiORM.Inserir(NFeDetalhe.NfeDetalheImpostoIcmsVO);
              end;

              { Detalhe - Imposto - IPI }
              if Assigned(NFeDetalhe.NfeDetalheImpostoIpiVO) then
              begin
                NFeDetalhe.NfeDetalheImpostoIpiVO.IdNfeDetalhe := NFeDetalhe.Id;
                TT2TiORM.Inserir(NFeDetalhe.NfeDetalheImpostoIpiVO);
              end;

              { Detalhe - Imposto - II }
              if Assigned(NFeDetalhe.NfeDetalheImpostoIiVO) then
              begin
                NFeDetalhe.NfeDetalheImpostoIiVO.IdNfeDetalhe := NFeDetalhe.Id;
                TT2TiORM.Inserir(NFeDetalhe.NfeDetalheImpostoIiVO);
              end;

              { Detalhe - Imposto - PIS }
              if Assigned(NFeDetalhe.NfeDetalheImpostoPisVO) then
              begin
                NFeDetalhe.NfeDetalheImpostoPisVO.IdNfeDetalhe := NFeDetalhe.Id;
                TT2TiORM.Inserir(NFeDetalhe.NfeDetalheImpostoPisVO);
              end;

              { Detalhe - Imposto - COFINS }
              if Assigned(NFeDetalhe.NfeDetalheImpostoCofinsVO) then
              begin
                NFeDetalhe.NfeDetalheImpostoCofinsVO.IdNfeDetalhe := NFeDetalhe.Id;
                TT2TiORM.Inserir(NFeDetalhe.NfeDetalheImpostoCofinsVO);
              end;

              { Detalhe - Imposto - ISSQN }
              if Assigned(NFeDetalhe.NfeDetalheImpostoIssqnVO) then
              begin
                NFeDetalhe.NfeDetalheImpostoIssqnVO.IdNfeDetalhe := NFeDetalhe.Id;
                TT2TiORM.Inserir(NFeDetalhe.NfeDetalheImpostoIssqnVO);
              end;

              { Detalhe - Específico - Veículo }
              if Assigned(NFeDetalhe.NfeDetEspecificoVeiculoVO) then
              begin
                NFeDetalhe.NfeDetEspecificoVeiculoVO.IdNfeDetalhe := NFeDetalhe.Id;
                TT2TiORM.Inserir(NFeDetalhe.NfeDetEspecificoVeiculoVO);
              end;

              { Detalhe - Específico - Combustível }
              if Assigned(NFeDetalhe.NfeDetEspecificoCombustivelVO) then
              begin
                NFeDetalhe.NfeDetEspecificoCombustivelVO.IdNfeDetalhe := NFeDetalhe.Id;
                TT2TiORM.Inserir(NFeDetalhe.NfeDetEspecificoCombustivelVO);
              end;

              { Detalhe - Específico - Medicamento }
              if Assigned(NFeDetalhe.ListaNfeDetEspecificoMedicamentoVO) then
              begin
                NfeDetalheEspecificoMedicamentoEnumerator := NFeDetalhe.ListaNfeDetEspecificoMedicamentoVO.GetEnumerator;
                try
                  with NfeDetalheEspecificoMedicamentoEnumerator do
                  begin
                    while MoveNext do
                    begin
                      NfeDetalheEspecificoMedicamento := Current;
                      NfeDetalheEspecificoMedicamento.IdNfeDetalhe := NFeDetalhe.Id;
                      TT2TiORM.Inserir(NfeDetalheEspecificoMedicamento);

                      // Produto - Lote
                      ProdutoLote := TProdutoLoteVO.Create;
                      ProdutoLote.IdProduto := NFeDetalhe.IdProduto;
                      ProdutoLote.Codigo := NfeDetalheEspecificoMedicamento.NumeroLote;
                      ProdutoLote.DataCadastro := now;
                      ProdutoLote.DataCompra := objNfeCabecalho.DataEmissao;
                      ProdutoLote.DataFabricacao := NfeDetalheEspecificoMedicamento.DataFabricacao;
                      ProdutoLote.DataValidade := NfeDetalheEspecificoMedicamento.DataValidade;
                      ProdutoLote.Quantidade := NfeDetalheEspecificoMedicamento.QuantidadeLote;
                      ProdutoLote.PrecoMaximoConsumidor := NfeDetalheEspecificoMedicamento.PrecoMaximoConsumidor;
                      TT2TiORM.Inserir(ProdutoLote);
                    end;
                  end;
                finally
                  NfeDetalheEspecificoMedicamentoEnumerator.Free;
                end;
              end;

              { Detalhe - Específico - Armamento }
              if Assigned(NFeDetalhe.ListaNfeDetEspecificoArmamentoVO) then
              begin
                NfeDetalheEspecificoArmamentoEnumerator := NFeDetalhe.ListaNfeDetEspecificoArmamentoVO.GetEnumerator;
                try
                  with NfeDetalheEspecificoArmamentoEnumerator do
                  begin
                    while MoveNext do
                    begin
                      NfeDetalheEspecificoArmamento := Current;
                      NfeDetalheEspecificoArmamento.IdNfeDetalhe := NFeDetalhe.Id;
                      TT2TiORM.Inserir(NfeDetalheEspecificoArmamento);
                    end;
                  end;
                finally
                  NfeDetalheEspecificoArmamentoEnumerator.Free;
                end;
              end;

              { Detalhe - Declaração de Importação }
              if Assigned(NFeDetalhe.ListaNfeDeclaracaoImportacaoVO) then
              begin
                NfeDeclaracaoImportacaoEnumerator := NFeDetalhe.ListaNfeDeclaracaoImportacaoVO.GetEnumerator;
                try
                  with NfeDeclaracaoImportacaoEnumerator do
                  begin
                    while MoveNext do
                    begin
                      NfeDeclaracaoImportacao := Current;
                      NfeDeclaracaoImportacao.IdNfeDetalhe := NFeDetalhe.Id;
                      NfeDeclaracaoImportacao.Id := TT2TiORM.Inserir(NfeDeclaracaoImportacao);

                      { Detalhe - Declaração de Importação - Adições }
                      if Assigned(NfeDeclaracaoImportacao.ListaNfeImportacaoDetalheVO) then
                      begin
                        NfeImportacaoDetalheEnumerator := NfeDeclaracaoImportacao.ListaNfeImportacaoDetalheVO.GetEnumerator;
                        try
                          with NfeImportacaoDetalheEnumerator do
                          begin
                            while MoveNext do
                            begin
                              NfeImportacaoDetalhe := Current;
                              NfeImportacaoDetalhe.IdNfeDeclaracaoImportacao := NfeDeclaracaoImportacao.Id;
                              NfeImportacaoDetalhe.Id := TT2TiORM.Inserir(NfeImportacaoDetalhe);
                            end;
                          end;
                        finally
                          NfeImportacaoDetalheEnumerator.Free;
                        end;
                      end;
                    end;
                  end;
                finally
                  NfeDeclaracaoImportacaoEnumerator.Free;
                end;
              end;

            end;
          end;
        finally
          NFeDetalheEnumerator.Free;
        end;
      end;
      (* Fim Grupo de Detalhes *)

      Result := NfeCabecalho(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objNfeCabecalho.Free;
  end;
end;

function TNfeCabecalhoController.UpdateNfeCabecalho(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objNfeCabecalhoOld: TNfeCabecalhoVO;
  //
  NfeReferenciadaEnumerator: TEnumerator<TNfeReferenciadaVO>;
  NfReferenciadaEnumerator: TEnumerator<TNfeNfReferenciadaVO>;
  NfeRuralReferenciadaEnumerator: TEnumerator<TNfeProdRuralReferenciadaVO>;
  NfeCteReferenciadoEnumerator: TEnumerator<TNfeCteReferenciadoVO>;
  NfeCupomFiscalReferenciadoEnumerator: TEnumerator<TNfeCupomFiscalReferenciadoVO>;
  NfeTransporteReboqueEnumerator: TEnumerator<TNfeTransporteReboqueVO>;
  NfeTransporteVolumeEnumerator: TEnumerator<TNfeTransporteVolumeVO>;
  NfeDuplicataEnumerator: TEnumerator<TNfeDuplicataVO>;
  //
  NfeDetalheEnumerator: TEnumerator<TNfeDetalheVO>;
  NfeDetalheEnumeratorOld: TEnumerator<TNfeDetalheVO>;
  NfeDeclaracaoImportacaoEnumerator: TEnumerator<TNfeDeclaracaoImportacaoVO>;
  NfeDetalheEspecificoMedicamentoEnumerator: TEnumerator<TNfeDetEspecificoMedicamentoVO>;
  NfeDetalheEspecificoArmamentoEnumerator: TEnumerator<TNfeDetEspecificoArmamentoVO>;
  NfeImportacaoDetalheEnumerator: TEnumerator<TNfeImportacaoDetalheVO>;
begin
 //Objeto Novo
  objNfeCabecalho := TNfeCabecalhoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objNfeCabecalhoOld := TNfeCabecalhoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try

    // Verifica se houve alterações no objeto principal
    if objNfeCabecalho.MainObject.ToJSONString <> objNfeCabecalhoOld.MainObject.ToJSONString then
    begin
      try
        Resultado := TT2TiORM.Alterar(objNfeCabecalho, objNfeCabecalhoOld);
      except
        on E: Exception do
        begin
          Result.AddElement(TJSOnString.Create('ERRO'));
          Result.AddElement(TJSOnString.Create(E.Message));
        end;
      end;
    end;

    { Destinatario }
    if Assigned(objNfeCabecalho.NfeDestinatarioVO) then
    begin
      Resultado := TT2TiORM.Alterar(objNfeCabecalho.NfeDestinatarioVO);
    end;

    { Emitente }
    if Assigned(objNfeCabecalho.NfeEmitenteVO) then
    begin
      Resultado := TT2TiORM.Alterar(objNfeCabecalho.NfeEmitenteVO);
    end;


    { Escrituração Entrada }
    if Assigned(objNfeCabecalho.FiscalNotaFiscalEntradaVO) then
    begin
      if objNfeCabecalho.FiscalNotaFiscalEntradaVO.Id > 0 then
        Resultado := TT2TiORM.Alterar(objNfeCabecalho.FiscalNotaFiscalEntradaVO)
      else
      begin
        objNfeCabecalho.FiscalNotaFiscalEntradaVO.IdNfeCabecalho := objNfeCabecalho.Id;
        Resultado := TT2TiORM.Inserir(objNfeCabecalho.FiscalNotaFiscalEntradaVO) > 0;
      end;
    end;

    (* Grupo de informação dos documentos referenciados *)
    {NF-e Referenciada}
    if Assigned(objNfeCabecalho.ListaNfeReferenciadaVO) then
    begin
      NfeReferenciadaEnumerator := objNfeCabecalho.ListaNfeReferenciadaVO.GetEnumerator;
      try
        with NfeReferenciadaEnumerator do
        begin
          while MoveNext do
          begin
            if Current.Id > 0 then
              Resultado := TT2TiORM.Alterar(Current)
            else
              Resultado := TT2TiORM.Inserir(Current) > 0;
          end;
        end;
      finally
        NfeReferenciadaEnumerator.Free;
      end;
    end;

    {NF Referenciada}
    if Assigned(objNfeCabecalho.ListaNfeNfReferenciadaVO) then
    begin
      NfReferenciadaEnumerator := objNfeCabecalho.ListaNfeNfReferenciadaVO.GetEnumerator;
      try
        with NfReferenciadaEnumerator do
        begin
          while MoveNext do
          begin
            if Current.Id > 0 then
              Resultado := TT2TiORM.Alterar(Current)
            else
              Resultado := TT2TiORM.Inserir(Current) > 0;
          end;
        end;
      finally
        NfReferenciadaEnumerator.Free;
      end;
    end;

    {NF Rural Referenciada}
    if Assigned(objNfeCabecalho.ListaNfeProdRuralReferenciadaVO) then
    begin
      NfeRuralReferenciadaEnumerator := objNfeCabecalho.ListaNfeProdRuralReferenciadaVO.GetEnumerator;
      try
        with NfeRuralReferenciadaEnumerator do
        begin
          while MoveNext do
          begin
            if Current.Id > 0 then
              Resultado := TT2TiORM.Alterar(Current)
            else
              Resultado := TT2TiORM.Inserir(Current) > 0;
          end;
        end;
      finally
        NfeRuralReferenciadaEnumerator.Free;
      end;
    end;

    {CT-e Referenciado}
    if Assigned(objNfeCabecalho.ListaNfeCteReferenciadoVO) then
    begin
      NfeCteReferenciadoEnumerator := objNfeCabecalho.ListaNfeCteReferenciadoVO.GetEnumerator;
      try
        with NfeCteReferenciadoEnumerator do
        begin
          while MoveNext do
          begin
            if Current.Id > 0 then
              Resultado := TT2TiORM.Alterar(Current)
            else
              Resultado := TT2TiORM.Inserir(Current) > 0;
          end;
        end;
      finally
        NfeCteReferenciadoEnumerator.Free;
      end;
    end;

    {Cupom Fiscal Referenciado}
    if Assigned(objNfeCabecalho.ListaNfeCupomFiscalReferenciadoVO) then
    begin
      NfeCupomFiscalReferenciadoEnumerator := objNfeCabecalho.ListaNfeCupomFiscalReferenciadoVO.GetEnumerator;
      try
        with NfeCupomFiscalReferenciadoEnumerator do
        begin
          while MoveNext do
          begin
            if Current.Id > 0 then
              Resultado := TT2TiORM.Alterar(Current)
            else
              Resultado := TT2TiORM.Inserir(Current) > 0;
          end;
        end;
      finally
        NfeCupomFiscalReferenciadoEnumerator.Free;
      end;
    end;
    (* Fim Grupo de informação dos documentos referenciados *)

    { Local Entrega }
    if Assigned(objNfeCabecalho.NfeLocalEntregaVO) then
    begin
      if objNfeCabecalho.NfeLocalEntregaVO.Id > 0 then
        Resultado := TT2TiORM.Alterar(objNfeCabecalho.NfeLocalEntregaVO)
      else
      begin
        objNfeCabecalho.NfeLocalEntregaVO.IdNfeCabecalho := objNfeCabecalho.Id;
        Resultado := TT2TiORM.Inserir(objNfeCabecalho.NfeLocalEntregaVO) > 0;
      end;
    end;

    { Local Retirada }
    if Assigned(objNfeCabecalho.NfeLocalRetiradaVO) then
    begin
      if objNfeCabecalho.NfeLocalRetiradaVO.Id > 0 then
        Resultado := TT2TiORM.Alterar(objNfeCabecalho.NfeLocalRetiradaVO)
      else
      begin
        objNfeCabecalho.NfeLocalRetiradaVO.IdNfeCabecalho := objNfeCabecalho.Id;
        Resultado := TT2TiORM.Inserir(objNfeCabecalho.NfeLocalRetiradaVO) > 0;
      end;
    end;


    (* Grupo de Transporte *)
    { Transporte }
    if Assigned(objNfeCabecalho.NfeTransporteVO) then
    begin
      Resultado := TT2TiORM.Alterar(objNfeCabecalho.NfeTransporteVO);

      { Transporte - Reboque }
      if Assigned(objNfeCabecalho.NfeTransporteVO.ListaNfeTransporteReboqueVO) then
      begin
        NfeTransporteReboqueEnumerator := objNfeCabecalho.NfeTransporteVO.ListaNfeTransporteReboqueVO.GetEnumerator;
        try
          with NfeTransporteReboqueEnumerator do
          begin
            while MoveNext do
            begin
              if Current.Id > 0 then
                Resultado := TT2TiORM.Alterar(Current)
              else
                Resultado := TT2TiORM.Inserir(Current) > 0;
            end;
          end;
        finally
          NfeTransporteReboqueEnumerator.Free;
        end;
      end;

      { Transporte - Volumes }
      if Assigned(objNfeCabecalho.NfeTransporteVO.ListaNfeTransporteVolumeVO) then
      begin
        NfeTransporteVolumeEnumerator := objNfeCabecalho.NfeTransporteVO.ListaNfeTransporteVolumeVO.GetEnumerator;
        try
          with NfeTransporteVolumeEnumerator do
          begin
            while MoveNext do
            begin
              if Current.Id > 0 then
                Resultado := TT2TiORM.Alterar(Current)
              else
                Resultado := TT2TiORM.Inserir(Current) > 0;
            end;
          end;
        finally
          NfeTransporteVolumeEnumerator.Free;
        end;
      end;
    end;
    (* Fim Grupo de Transporte *)


    (* Grupo de Cobrança *)
    { Fatura }
    if Assigned(objNfeCabecalho.NfeFaturaVO) then
    begin
      if objNfeCabecalho.NfeFaturaVO.Id > 0 then
        Resultado := TT2TiORM.Alterar(objNfeCabecalho.NfeFaturaVO)
      else
      begin
        objNfeCabecalho.NfeFaturaVO.IdNfeCabecalho := objNfeCabecalho.Id;
        Resultado := TT2TiORM.Inserir(objNfeCabecalho.NfeFaturaVO) > 0;
      end;
    end;

    { Duplicatas }
    if Assigned(objNfeCabecalho.ListaNfeDuplicataVO) then
    begin
      NfeDuplicataEnumerator := objNfeCabecalho.ListaNfeDuplicataVO.GetEnumerator;
      try
        with NfeDuplicataEnumerator do
        begin
          while MoveNext do
          begin
            if Current.Id > 0 then
              Resultado := TT2TiORM.Alterar(Current)
            else
              Resultado := TT2TiORM.Inserir(Current) > 0;
          end;
        end;
      finally
        NfeDuplicataEnumerator.Free;
      end;
    end;
    (* Fim Grupo de Cobrança *)


    (* Grupo de Detalhes *)
    { NFeDetalhe }
    if Assigned(objNfeCabecalho.ListaNfeDetalheVO) then
    begin
      NFeDetalheEnumerator := objNfeCabecalho.ListaNfeDetalheVO.GetEnumerator;
      NFeDetalheEnumeratorOld := objNfeCabecalhoOld.ListaNfeDetalheVO.GetEnumerator;
      try
        with NFeDetalheEnumerator do
        begin
          while MoveNext do
          begin

            if Current.Id > 0 then
            begin
              Resultado := TT2TiORM.Alterar(Current);
            end
            else
              Resultado := TT2TiORM.Inserir(Current) > 0;

            // Atualiza estoque
            if NFeDetalheEnumeratorOld.MoveNext then
              TControleEstoqueController.Create().AtualizarEstoque(pSessao, Current.QuantidadeComercial - NFeDetalheEnumeratorOld.Current.QuantidadeComercial, Current.IdProduto)
            else
              TControleEstoqueController.Create().AtualizarEstoque(pSessao, Current.QuantidadeComercial, Current.IdProduto);

            { Detalhe - Imposto - ICMS }
            if Assigned(Current.NfeDetalheImpostoIcmsVO) then
            begin
              Resultado := TT2TiORM.Alterar(Current.NfeDetalheImpostoIcmsVO);
            end;

            { Detalhe - Imposto - IPI }
            if Assigned(Current.NfeDetalheImpostoIpiVO) then
            begin
              Resultado := TT2TiORM.Alterar(Current.NfeDetalheImpostoIpiVO);
            end;

            { Detalhe - Imposto - II }
            if Assigned(Current.NfeDetalheImpostoIiVO) then
            begin
              Resultado := TT2TiORM.Alterar(Current.NfeDetalheImpostoIiVO);
            end;

            { Detalhe - Imposto - PIS }
            if Assigned(Current.NfeDetalheImpostoPisVO) then
            begin
              Resultado := TT2TiORM.Alterar(Current.NfeDetalheImpostoPisVO);
            end;

            { Detalhe - Imposto - COFINS }
            if Assigned(Current.NfeDetalheImpostoCofinsVO) then
            begin
              Resultado := TT2TiORM.Alterar(Current.NfeDetalheImpostoCofinsVO);
            end;

            { Detalhe - Imposto - ISSQN }
            if Assigned(Current.NfeDetalheImpostoIssqnVO) then
            begin
              Resultado := TT2TiORM.Alterar(Current.NfeDetalheImpostoIssqnVO);
            end;

            { Detalhe - Específico - Veículo }
            if Assigned(Current.NfeDetEspecificoVeiculoVO) then
            begin
              Resultado := TT2TiORM.Alterar(Current.NfeDetEspecificoVeiculoVO);
            end;

            { Detalhe - Específico - Combustível }
            if Assigned(Current.NfeDetEspecificoCombustivelVO) then
            begin
              Resultado := TT2TiORM.Alterar(Current.NfeDetEspecificoCombustivelVO);
            end;

            { Detalhe - Específico - Medicamento }
            if Assigned(Current.ListaNfeDetEspecificoMedicamentoVO) then
            begin
              NfeDetalheEspecificoMedicamentoEnumerator := Current.ListaNfeDetEspecificoMedicamentoVO.GetEnumerator;
              try
                with NfeDetalheEspecificoMedicamentoEnumerator do
                begin
                  while MoveNext do
                  begin
                    if Current.Id > 0 then
                      Resultado := TT2TiORM.Alterar(Current)
                    else
                      Resultado := TT2TiORM.Inserir(Current) > 0;
                  end;
                end;
              finally
                NfeDetalheEspecificoMedicamentoEnumerator.Free;
              end;
            end;

            { Detalhe - Específico - Armamento }
            if Assigned(Current.ListaNfeDetEspecificoArmamentoVO) then
            begin
              NfeDetalheEspecificoArmamentoEnumerator := Current.ListaNfeDetEspecificoArmamentoVO.GetEnumerator;
              try
                with NfeDetalheEspecificoArmamentoEnumerator do
                begin
                  while MoveNext do
                  begin
                    if Current.Id > 0 then
                      Resultado := TT2TiORM.Alterar(Current)
                    else
                      Resultado := TT2TiORM.Inserir(Current) > 0;
                  end;
                end;
              finally
                NfeDetalheEspecificoArmamentoEnumerator.Free;
              end;
            end;

            { Detalhe - Declaração de Importação }
            if Assigned(Current.ListaNfeDeclaracaoImportacaoVO) then
            begin
              NfeDeclaracaoImportacaoEnumerator := Current.ListaNfeDeclaracaoImportacaoVO.GetEnumerator;
              try
                with NfeDeclaracaoImportacaoEnumerator do
                begin
                  while MoveNext do
                  begin
                    if Current.Id > 0 then
                      Resultado := TT2TiORM.Alterar(Current)
                    else
                      Resultado := TT2TiORM.Inserir(Current) > 0;

                    { Detalhe - Declaração de Importação - Adições }
                    if Assigned(Current.ListaNfeImportacaoDetalheVO) then
                    begin
                      NfeImportacaoDetalheEnumerator := Current.ListaNfeImportacaoDetalheVO.GetEnumerator;
                      try
                        with NfeImportacaoDetalheEnumerator do
                        begin
                          while MoveNext do
                          begin
                            if Current.Id > 0 then
                              Resultado := TT2TiORM.Alterar(Current)
                            else
                              Resultado := TT2TiORM.Inserir(Current) > 0;
                          end;
                        end;
                      finally
                        NfeImportacaoDetalheEnumerator.Free;
                      end;
                    end;
                  end;
                end;
              finally
                NfeDeclaracaoImportacaoEnumerator.Free;
              end;
            end;

          end;
        end;
      finally
        NFeDetalheEnumerator.Free;
      end;
    end;
    (* Fim Grupo de Detalhes *)

  finally
    objNfeCabecalho.Free;

    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TNfeCabecalhoController.CancelNfeCabecalho(pSessao: String; pId: Integer; pExcluirQuem: String; pIdProduto: Integer; pQuantidade: Extended): TJSONArray;
var
  IdRetornado: Integer;
begin
  objNfeCabecalho := TNfeCabecalhoVO.Create;
  Result := TJSONArray.Create;
  try
    try
      if pExcluirQuem = 'CABECALHO' then
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create('Não é permitido excluir notas fiscais nessa janela.'));
      end
      else if pExcluirQuem = 'DETALHE' then
      begin
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DETALHE_IMPOSTO_COFINS where ID_NFE_DETALHE = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DETALHE_IMPOSTO_PIS where ID_NFE_DETALHE = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DETALHE_IMPOSTO_ICMS where ID_NFE_DETALHE = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DETALHE_IMPOSTO_II where ID_NFE_DETALHE = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DETALHE_IMPOSTO_IPI where ID_NFE_DETALHE = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DETALHE_IMPOSTO_ISSQN where ID_NFE_DETALHE = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DET_ESPECIFICO_COMBUSTIVEL where ID_NFE_DETALHE = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DET_ESPECIFICO_VEICULO where ID_NFE_DETALHE = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DET_ESPECIFICO_ARMAMENTO where ID_NFE_DETALHE = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DET_ESPECIFICO_MEDICAMENTO where ID_NFE_DETALHE = ' + IntToStr(pId));

        IdRetornado := TT2TiORM.SelectMax('NFE_DECLARACAO_IMPORTACAO', 'ID_NFE_DETALHE= ' + IntToStr(pId));
        if IdRetornado <> -1 then
        begin
          Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_IMPORTACAO_DETALHE where ID_NFE_DECLARACAO_IMPORTACAO = ' + IntToStr(IdRetornado));
          Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DECLARACAO_IMPORTACAO where ID_NFE_DETALHE = ' + IntToStr(pId));
        end;

        // Atualiza estoque
        TControleEstoqueController.Create().AtualizarEstoque(pSessao, pQuantidade * -1, pIdProduto);

        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DETALHE where ID = ' + IntToStr(pId));
      end
      else if pExcluirQuem = 'REFERENCIADO' then
      begin
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_REFERENCIADA where ID_NFE_CABECALHO = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_NF_REFERENCIADA where ID_NFE_CABECALHO = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_CTE_REFERENCIADO where ID_NFE_CABECALHO = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_PROD_RURAL_REFERENCIADA where ID_NFE_CABECALHO = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_CUPOM_FISCAL_REFERENCIADO where ID_NFE_CABECALHO = ' + IntToStr(pId));
      end
      else if pExcluirQuem = 'ENTREGA_RETIRADA' then
      begin
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_LOCAL_ENTREGA where ID_NFE_CABECALHO = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_LOCAL_RETIRADA where ID_NFE_CABECALHO = ' + IntToStr(pId));
      end
      else if pExcluirQuem = 'TRANSPORTE' then
      begin
        IdRetornado := TT2TiORM.SelectMax('NFE_TRANSPORTE', 'ID_NFE_CABECALHO= ' + IntToStr(pId));
        if IdRetornado <> -1 then
        begin
          Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_TRANSPORTE_REBOQUE where ID_NFE_TRANSPORTE = ' + IntToStr(IdRetornado));

          IdRetornado := TT2TiORM.SelectMax('NFE_TRANSPORTE_VOLUME', 'ID_NFE_TRANSPORTE= ' + IntToStr(IdRetornado));
          if IdRetornado <> -1 then
          begin
            Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_TRANSPORTE_VOLUME_LACRE where ID_NFE_TRANSPORTE_VOLUME = ' + IntToStr(IdRetornado));
            Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_TRANSPORTE_VOLUME where ID = ' + IntToStr(IdRetornado));
          end;
          Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_TRANSPORTE where ID_NFE_CABECALHO = ' + IntToStr(pId));
        end;
      end
      else if pExcluirQuem = 'COBRANCA' then
      begin
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_FATURA where ID_NFE_CABECALHO = ' + IntToStr(pId));
        Resultado := TT2TiORM.ComandoSQL('DELETE FROM NFE_DUPLICATA where ID_NFE_CABECALHO = ' + IntToStr(pId));
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
    objNfeCabecalho.Free;
  end;
end;

end.
