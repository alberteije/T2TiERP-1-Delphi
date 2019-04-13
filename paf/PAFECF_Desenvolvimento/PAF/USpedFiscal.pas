{*******************************************************************************
Title: T2Ti ERP
Description: Funções e procedimentos do SPED Fiscal;

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

@author Albert Eije (T2Ti.COM) | Clausqueler
@version 1.0
******************************************************************************* }

unit USpedFiscal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ACBrEFDBlocos, Generics.Collections, ACBrSpedFiscal;

procedure GerarBloco0;
procedure GerarBlocoC;
procedure GerarBlocoE;
procedure GerarBlocoH;
procedure GerarArquivoSpedFiscal(pDataIni: String; pDataFim: String; pVersao: Integer; pFinalidade:Integer; pPerfil: Integer);

implementation

uses
  UDataModule, UCaixa, EmpresaController, EmpresaVO, UnidadeController,
  UnidadeProdutoVO, ContadorController, ContadorVO, ProdutoController, ProdutoVO, ImpressoraController, ImpressoraVO, R02VO,
  RegistroRController, SpedFiscalC390VO, SpedFiscalC321VO, R03VO, SpedFiscalController,
  SpedFiscalC425VO, R04VO, R05VO, SpedFiscalC490VO, MeiosPagamentoVO,
  EAD_Class, SWSystem, ClienteVO, ClienteController,
  NfeController, NfeDetalheVO, NfeCupomFiscalVO, NotaFiscalController, NotaFiscalDetalheVO,
  NotaFiscalCabecalhoVO, NFeCabecalhoVO, SpedFiscalC370VO;

var
  Empresa: TEmpresaVO;
  VersaoLeiaute, FinalidadeArquivo, PerfilApresentacao: Integer;
  DataInicial, DataFinal: String;

// Bloco 0
procedure GerarBloco0;
var
  Contador: TContadorVO;
  ListaUnidade: TObjectList<TUnidadeProdutoVO>;
  ListaProduto: TObjectList<TProdutoVO>;
  ListaCliente: TObjectList<TClienteVO>;
  i: integer;
begin
  Empresa := TEmpresaController.PegaEmpresa(UCaixa.Configuracao.IdEmpresa);
  Contador := TContadorController.PegaContador;
  ListaUnidade := TUnidadeController.UnidadeSPED(DataInicial, DataFinal);
  ListaProduto := TProdutoController.ConsultaProdutoSPED(DataInicial, DataFinal, PerfilApresentacao);

  ListaCliente := TClienteController.ConsultaClienteSPED(DataInicial, DataFinal);

  if (not Assigned(ListaUnidade)) or (not Assigned(ListaProduto))then
  begin
    Application.MessageBox('Não há venda no período selecionado'+#13+'e ou a data informada é inválida', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;

  with FDataModule.ACBrSpedFiscal.Bloco_0 do
  begin
    // Dados da Empresa
    with Registro0000New do
    begin
      case VersaoLeiaute of
        0:COD_VER := vlVersao100;
        1:COD_VER := vlVersao101;
        2:COD_VER := vlVersao102;
        3:COD_VER := vlVersao103;
      end;

      case FinalidadeArquivo of
        0:COD_FIN := raOriginal;
        1:COD_FIN := raSubstituto;
      end;

      case PerfilApresentacao of
        0:IND_PERFIL := pfPerfilA;
        1:IND_PERFIL := pfPerfilB;
        2:IND_PERFIL := pfPerfilC;
      end;

      NOME := Empresa.RazaoSocial;
      CNPJ := Empresa.CNPJ;
      CPF := '';
      UF := Empresa.UF;
      IE := Empresa.InscricaoEstadual;
      COD_MUN := Empresa.CodigoIbgeCidade;
      IM := Empresa.InscricaoMunicipal;
      SUFRAMA := Empresa.Suframa;

      // 0 – Industrial ou equiparado a industrial;
      // 1 – Outros.
      IND_ATIV := atOutros;
    end;

    with Registro0001New do
    begin
      // Indicador de movimento:
      IND_MOV := imComDados;

      // FILHO - Dados complementares da Empresa
      with Registro0005New do
      begin
        FANTASIA := Empresa.NomeFantasia;
        CEP := Empresa.CEP;
        ENDERECO := Empresa.Logradouro;
        NUM := Empresa.Numero;
        COMPL := Empresa.Complemento;
        BAIRRO := Empresa.BAIRRO;
        FONE := Empresa.Fone;
        FAX := Empresa.Fax;
        EMAIL := Empresa.Email;
      end;//with Registro0005New do

      // FILHO - Dados do contador.
      with Registro0100New do
      begin
        NOME := Contador.NOME;
        CPF := Contador.CPF;
        CRC := Contador.CRC;
        CNPJ := Contador.CNPJ;
        CEP := Contador.CEP;
        ENDERECO := Contador.Logradouro;
        NUM := IntToStr(Contador.Numero);
        COMPL := Contador.Complemento;
        BAIRRO := Contador.BAIRRO;
        FONE := Contador.FONE;
        FAX := Contador.FAX;
        EMAIL := Contador.EMAIL;
        COD_MUN := Contador.CodigoMunicipio;
      end;//with Registro0100New do

      //Lista de cliente da nfe
      if assigned(ListaCliente) then
      begin
        for I := 0 to ListaCliente.Count - 1 do
        begin
          with Registro0150New do
          begin
            COD_PART := inttostr(TClienteVO(ListaCliente.Items[i]).Id);
            NOME := TClienteVO(ListaCliente.Items[i]).Nome;
            COD_PAIS := '01058';
            if TClienteVO(ListaCliente.Items[i]).TipoPessoa = 'F'  then
                CPF := TClienteVO(ListaCliente.Items[i]).CPFOuCNPJ
            else
                CNPJ := TClienteVO(ListaCliente.Items[i]).CPFOuCNPJ;
            IE := TClienteVO(ListaCliente.Items[i]).InscricaoEstadual;
            COD_MUN := TClienteVO(ListaCliente.Items[i]).CodigoIbgeCidade;
            SUFRAMA := '';
            ENDERECO := TClienteVO(ListaCliente.Items[i]).Logradouro;
            NUM := TClienteVO(ListaCliente.Items[i]).Numero;
            COMPL := TClienteVO(ListaCliente.Items[i]).Complemento;
            BAIRRO := TClienteVO(ListaCliente.Items[i]).Bairro;
          end;//with Registro0150New do
        end;//for I := 0 to ListaCliente.Count - 1 do
      end;//if assigned(ListaCliente) then

      // FILHO - Identificação das unidades de medida
      for i := 0 to ListaUnidade.Count - 1 do
      begin
        with Registro0190New do
        begin
          UNID := IntToStr(TUnidadeProdutoVO(ListaUnidade.Items[i]).Id);
          DESCR := TUnidadeProdutoVO(ListaUnidade.Items[i]).Nome;
        end;
      end;

      // FILHO - Tabela de Identificação do Item (Produtos e Serviços)
      for i := 0 to ListaProduto.Count - 1 do
      begin
        with Registro0200New do
        begin
          COD_ITEM := IntToStr(TProdutoVO(ListaProduto.Items[i]).Id);
          DESCR_ITEM := TProdutoVO(ListaProduto.Items[i]).NOME;
          COD_BARRA := TProdutoVO(ListaProduto.Items[i]).GTIN;
          COD_ANT_ITEM := '';
          UNID_INV := InttoStr(TProdutoVO(ListaProduto.Items[i]).IdUnidade);

          case StrToInt(TProdutoVO(ListaProduto.Items[i]).TipoItemSped) of
            0:TIPO_ITEM := tiMercadoriaRevenda;
            1:TIPO_ITEM := tiMateriaPrima;
            2:TIPO_ITEM := tiEmbalagem;
            3:TIPO_ITEM := tiProdutoProcesso;
            4:TIPO_ITEM := tiProdutoAcabado;
            5:TIPO_ITEM := tiSubproduto;
            6:TIPO_ITEM := tiProdutoIntermediario;
            7:TIPO_ITEM := tiMaterialConsumo;
            8:TIPO_ITEM := tiAtivoImobilizado;
            9:TIPO_ITEM := tiServicos;
            10:TIPO_ITEM := tiOutrosInsumos;
            99:TIPO_ITEM := tiOutras;
          end;

          COD_NCM := TProdutoVO(ListaProduto.Items[i]).NCM;
          EX_IPI := '';
          COD_GEN := Copy(TProdutoVO(ListaProduto.Items[i]).NCM,1,2);
          COD_LST := '';
          ALIQ_ICMS := TProdutoVO(ListaProduto.Items[i]).AliquotaICMS;
        end;//with Registro0200New do
      end;//for i := 0 to ListaProduto.Count - 1 do
    end;//with Registro0001New do
  end;//if (not Assigned(ListaUnidade)) or (not Assigned(ListaProduto))then
end;

procedure GerarBlocoC;
var
  ListaImpressora             : TObjectList<TImpressoraVO>;
  ListaNF2Cabecalho           : TObjectList<TNotaFiscalCabecalhoVO>;
  ListaNF2CabecalhoCanceladas : TObjectList<TNotaFiscalCabecalhoVO>;
//  ListaNF2Detalhe             : TObjectList<TNotaFiscalDetalheVO>;
  ListaNFeCabecalho           : TObjectList<TNfeCabecalhoVO>;
  ListaNFeAnalitico           : TObjectList<TNfeDetalheVO>;
  ListaCupomNFe               : TObjectList<TNfeCupomFiscalVO>;
  ListaC390                   : TObjectList<TSpedFiscalC390VO>;
  ListaC321                   : TObjectList<TSpedFiscalC321VO>;
  ListaC370                   : TObjectList<TSpedFiscalC370VO>;
  ListaC425                   : TObjectList<TSpedFiscalC425VO>;
  ListaC490                   : TObjectList<TSpedFiscalC490VO>;
  ListaR02                    : TObjectList<TR02VO>;
  ListaR03                    : TObjectList<TR03VO>;
  ListaR04                    : TObjectList<TR04VO>;
  ListaR05                    : TObjectList<TR05VO>;
  i, j, k, l, m, g: Integer;
begin
  with FDataModule.ACBrSpedFiscal.Bloco_C do
  begin
    with RegistroC001New do
    begin
      IND_MOV := imComDados;

      ListaNF2Cabecalho := TNotaFiscalController.ConsultaNFCabecalhoSPED(DataInicial, DataFinal);
      ListaNF2CabecalhoCanceladas := TNotaFiscalController.ConsultaNFCabecalhoCanceladasSPED(DataInicial, DataFinal);

      if FDataModule.ConectaBalcao then
        ListaNFeCabecalho := TNfeController.NfeSPED(DataInicial, DataFinal);

      //////////////
      //Perfil A  //
      //////////////
      if PerfilApresentacao = 0 then
      begin
        if Assigned(ListaNFeCabecalho) then
        begin
          for i := 0 to ListaNFeCabecalho.Count - 1 do
          begin
            //c100
            with RegistroC100New do
            begin
              IND_OPER     := tpSaidaPrestacao;
              IND_EMIT     := edEmissaoPropria;
              COD_PART     := intToStr(TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).IdCliente);
              COD_MOD      :=  TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).CodigoModelo;
              if TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).SituacaoNota = 'E' then
                COD_SIT      := sdRegular
              else
                COD_SIT      := sdCancelado;

              SER          := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).Serie;
              NUM_DOC      := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).Numero;
              CHV_NFE      := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ChaveAcesso;
              DT_DOC       := strtoDate(TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).DataEmissao);
              DT_E_S       := strtoDate(TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).DataEntradaSaida);
              VL_DOC       := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorTotal;
              IND_PGTO     := tpSemPagamento;
              VL_DESC      := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorDesconto;
              VL_ABAT_NT   := 0;
              VL_MERC      := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorTotalProdutos;
              IND_FRT      := tfSemCobrancaFrete;
              VL_FRT       := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorFrete;
              VL_SEG       := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorSeguro;
              VL_OUT_DA    := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorDespesasAcessorias;
              VL_BC_ICMS   := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).BaseCalculoIcms;
              VL_ICMS      := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorIcms;
              VL_BC_ICMS_ST:= TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).BaseCalculoIcmsSt;
              VL_ICMS_ST   := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorIcmsSt;
              VL_IPI       := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorIpi;
              VL_PIS       := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorPis;
              VL_COFINS    := TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).ValorCofins;
              VL_PIS_ST    := 0;
              VL_COFINS_ST := 0;

              // C114
              if FDataModule.ConectaBalcao then
                ListaCupomNFe := TNfeController.CupomNfeSPED(IntToStr(TNfeCupomFiscalVO(ListaNFeCabecalho.Items[i]).Id));

              if Assigned(ListaCupomNFe) then
              begin
                for j := 0 to ListaCupomNFe.Count - 1 do
                begin
                  with RegistroC114New do
                  begin
                    COD_MOD      := TNfeCupomFiscalVO(ListaCupomNFe.Items[j]).ModeloDocumentoFiscal;
                    ECF_FAB          := TNfeCupomFiscalVO(ListaCupomNFe.Items[j]).NumeroSerieEcf;
                    ECF_CX     := IntTostr(TNfeCupomFiscalVO(ListaCupomNFe.Items[j]).NumeroCaixa);
                    NUM_DOC        := IntTostr(TNfeCupomFiscalVO(ListaCupomNFe.Items[j]).Coo);
                    DT_DOC    := StrToDate(TNfeCupomFiscalVO(ListaCupomNFe.Items[j]).DataEmissaoCupom);
                  end;//with RegistroC114New do
                end;//for j := 0 to ListaCupomNFe.Count - 1 do
              end;//if Assigned(ListaCupomNFe) then

              // C190
              if FDataModule.ConectaBalcao then
                 ListaNFeAnalitico := TNfeController.NfeAnaliticoSPED(IntToStr(TNfeCabecalhoVO(ListaNFeCabecalho.Items[i]).Id));

              if Assigned(ListaNFeAnalitico) then
              begin
                for j := 0 to ListaNFeAnalitico.Count - 1 do
                begin
                  with RegistroC190New do
                  begin
                    CST_ICMS      := TNfeDetalheVO(ListaNFeAnalitico.Items[j]).CstA;
                    CFOP          := IntToStr(TNfeDetalheVO(ListaNFeAnalitico.Items[j]).Cfop);
                    ALIQ_ICMS     := TNfeDetalheVO(ListaNFeAnalitico.Items[j]).AliquotaIcms;
                    VL_OPR        := TNfeDetalheVO(ListaNFeAnalitico.Items[j]).ValorTotal;
                    VL_BC_ICMS    := TNfeDetalheVO(ListaNFeAnalitico.Items[j]).BaseCalculoIcms;
                    VL_ICMS       := TNfeDetalheVO(ListaNFeAnalitico.Items[j]).ValorIcms;
                    VL_BC_ICMS_ST := TNfeDetalheVO(ListaNFeAnalitico.Items[j]).BaseCalculoIcmsSt;
                    VL_ICMS_ST    := TNfeDetalheVO(ListaNFeAnalitico.Items[j]).ValorIcmsSt;
                    VL_RED_BC     := TNfeDetalheVO(ListaNFeAnalitico.Items[j]).ValNaoTributadoBaseIcms;
                    VL_IPI        := TNfeDetalheVO(ListaNFeAnalitico.Items[j]).ValorIpi;
                    COD_OBS       := '';
                  end;//with RegistroC190New do
                end;//for j := 0 to ListaNFeAnalitico.Count - 1 do
              end;//if Assigned(ListaNFeAnalitico) then
            end;//with RegistroC100New do
          end;//for i := 0 to ListaNFeCabecalho.Count - 1 do
        end;//if Assigned(ListaNFeCabecalho) then

        if Assigned(ListaNF2Cabecalho) then
        begin
          for i := 0 to ListaNF2Cabecalho.Count - 1 do
          begin
            with RegistroC350New do
            begin
              SER := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).Serie;
              SUB_SER := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).SubSerie;
              NUM_DOC := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).Numero;
              DT_DOC := StrToDate(TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).DataEmissao);
              CNPJ_CPF := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).CpfCnpjCliente;
              VL_MERC := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).TotalProdutos;
              VL_DOC := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).TotalNF;
              VL_DESC := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).Desconto;
              VL_PIS := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).PIS;
              VL_COFINS := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).COFINS;
              COD_CTA := '';

              // C370
              ListaC370 := TSpedFiscalController.TabelaC370(TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).id);
              if Assigned(ListaC370) then
              begin
                for j := 0 to ListaC370.Count - 1 do
                begin
                  with RegistroC370New do
                  begin
                    NUM_ITEM := IntToStr(TSpedFiscalC370VO(ListaC370.Items[j]).Item);
                    COD_ITEM := IntToStr(TSpedFiscalC370VO(ListaC370.Items[j]).IdProduto);
                    QTD := TSpedFiscalC370VO(ListaC370.Items[j]).Quantidade;
                    UNID := IntToStr(TSpedFiscalC370VO(ListaC370.Items[j]).IdUnidade);
                    VL_ITEM := TSpedFiscalC370VO(ListaC370.Items[j]).Valor;
                    VL_DESC := TSpedFiscalC370VO(ListaC370.Items[j]).Desconto;
                  end;//with RegistroC370New do
                end;//for j := 0 to ListaNF2Detalhe.Count - 1 do
              end;//if Assigned(ListaNF2Detalhe) then
//          end;//with RegistroC350New do

              // C390
              ListaC390 := TSpedFiscalController.TabelaC390(TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).id);
              if Assigned(ListaC390) then
              begin
                for l := 0 to ListaC390.Count - 1 do
                begin
                  with RegistroC390New do
                  begin
                    CST_ICMS := TSpedFiscalC390VO(ListaC390.Items[l]).CST;
                    CFOP := IntToStr(TSpedFiscalC390VO(ListaC390.Items[l]).CFOP);
                    ALIQ_ICMS := TSpedFiscalC390VO(ListaC390.Items[l]).TaxaICMS;
                    VL_OPR := TSpedFiscalC390VO(ListaC390.Items[l]).SomaValor;
                    VL_BC_ICMS := TSpedFiscalC390VO(ListaC390.Items[l]).SomaBaseICMS;
                    VL_ICMS := TSpedFiscalC390VO(ListaC390.Items[l]).SomaICMS;
                    VL_RED_BC := TSpedFiscalC390VO(ListaC390.Items[l]).SomaICMSOutras;
                  end;//with RegistroC390New do
                end;//for i := 0 to ListaC390.Count - 1 do
              end;//if Assigned(ListaC390) then
            end;//with RegistroC350New do
          end;//for i := 0 to ListaNF2Cabecalho.Count - 1 do
        end;//if Assigned(ListaNF2Cabecalho) then
      end;//if PerfilApresentacao = 0 then


      //////////////
      //Perfil B  //
      //////////////
      if PerfilApresentacao = 1 then
      begin
        if Assigned(ListaNF2Cabecalho) then
        begin
          for i := 0 to ListaNF2Cabecalho.Count - 1 do
          begin
            // C300
            with RegistroC300New do
            begin
              COD_MOD := '02';
              SER := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).Serie;
              SUB := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).SubSerie;
              DT_DOC := StrToDate(TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).DataEmissao);
              VL_DOC := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).TotalNF;
              VL_PIS := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).PIS;
              VL_COFINS := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).COFINS;
              COD_CTA := '';
            end;//with RegistroC300New do
          end;//for i := 0 to ListaNF2Cabecalho.Count - 1 do
        end;//if Assigned(ListaNF2Cabecalho) then

        if Assigned(ListaNF2CabecalhoCanceladas) then
        begin
          for i := 0 to ListaNF2CabecalhoCanceladas.Count - 1 do
          begin
            // C310
            with RegistroC310New do
            begin
              NUM_DOC_CANC := TNotaFiscalCabecalhoVO(ListaNF2CabecalhoCanceladas.Items[i]).Numero;
            end;//with RegistroC310New do
          end;//for i := 0 to ListaNF2CabecalhoCanceladas.Count - 1 do
        end;//if Assigned(ListaNF2CabecalhoCanceladas) then

        // C320 ---> igual ao C390
        ListaC390 := TSpedFiscalController.TabelaC390(TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).id);
        if Assigned(ListaC390) then
        begin
          for i := 0 to ListaC390.Count - 1 do
          begin
            with RegistroC320New do
            begin
              CST_ICMS := TSpedFiscalC390VO(ListaC390.Items[i]).CST;
              CFOP := IntToStr(TSpedFiscalC390VO(ListaC390.Items[i]).CFOP);
              ALIQ_ICMS := TSpedFiscalC390VO(ListaC390.Items[i]).TaxaICMS;
              VL_OPR := TSpedFiscalC390VO(ListaC390.Items[i]).SomaValor;
              VL_BC_ICMS := TSpedFiscalC390VO(ListaC390.Items[i]).SomaBaseICMS;
              VL_ICMS := TSpedFiscalC390VO(ListaC390.Items[i]).SomaICMS;
              VL_RED_BC := TSpedFiscalC390VO(ListaC390.Items[i]).SomaICMSOutras;
            end;//with RegistroC320New do
          end;//for i := 0 to ListaC390.Count - 1 do
        end;//if Assigned(ListaC390) then

        // C321
        ListaC321 := TSpedFiscalController.TabelaC321(DataInicial, DataFinal);
        if Assigned(ListaC321) then
        begin
          for i := 0 to ListaC321.Count - 1 do
          begin
            with RegistroC321New do
            begin
              COD_ITEM := IntToStr(TSpedFiscalC321VO(ListaC321.Items[i]).IdProduto);
              QTD := TSpedFiscalC321VO(ListaC321.Items[i]).SomaQuantidade;
              UNID := TSpedFiscalC321VO(ListaC321.Items[i]).DescricaoUnidade;
              VL_ITEM := TSpedFiscalC321VO(ListaC321.Items[i]).SomaValor;
              VL_DESC := TSpedFiscalC321VO(ListaC321.Items[i]).SomaDesconto;
              VL_BC_ICMS := TSpedFiscalC321VO(ListaC321.Items[i]).SomaBaseICMS;
              VL_ICMS := TSpedFiscalC321VO(ListaC321.Items[i]).SomaICMS;
              VL_PIS := TSpedFiscalC321VO(ListaC321.Items[i]).SomaPIS;
              VL_COFINS := TSpedFiscalC321VO(ListaC321.Items[i]).SomaCOFINS;
            end;//with RegistroC321New do
          end;//for i := 0 to ListaC321.Count - 1 do
        end;//if Assigned(ListaC321) then

      end;//if PerfilApresentacao = 1 then

      /////////////////////
      //Ambos os Perfis  //
      /////////////////////
      ListaImpressora := TImpressoraController.TabelaImpressora;
      if Assigned(ListaImpressora) then
      begin
        for i := 0 to ListaImpressora.Count - 1 do
        begin
          //verifica se existe movimento no periodo para aquele ECF
          ListaR02 := TRegistroRController.TabelaR02(DataInicial, DataFinal, TImpressoraVO(ListaImpressora.Items[i]).Id);
          if Assigned(ListaR02) then
          begin
            with RegistroC400New do
            begin
              COD_MOD := TImpressoraVO(ListaImpressora.Items[i]).ModeloDocumentoFiscal;
              ECF_MOD := TImpressoraVO(ListaImpressora.Items[i]).Modelo;
              ECF_FAB := TImpressoraVO(ListaImpressora.Items[i]).Serie;
              ECF_CX := IntToStr(TImpressoraVO(ListaImpressora.Items[i]).Numero);

              // C405
              for j := 0 to ListaR02.Count - 1 do
              begin
                with RegistroC405New do
                begin
                  DT_DOC := StrToDateTime(TR02VO(ListaR02.Items[j]).DataMovimento);
                  CRO := TR02VO(ListaR02.Items[j]).CRO;
                  CRZ := TR02VO(ListaR02.Items[j]).CRZ;
                  NUM_COO_FIN := TR02VO(ListaR02.Items[j]).COO;
                  GT_FIN := TR02VO(ListaR02.Items[j]).GrandeTotal;
                  VL_BRT := TR02VO(ListaR02.Items[j]).VendaBruta;

                  // C420
                  ListaR03 := TRegistroRController.TabelaR03(TR02VO(ListaR02.Items[j]).Id);
                  if Assigned(ListaR03) then
                  begin
                    for k := 0 to ListaR03.Count - 1 do
                    begin
                      with RegistroC420New do
                      begin
                        if length(TR03VO(ListaR03.Items[k]).TotalizadorParcial) = 8{T01T1700} then
                          COD_TOT_PAR := copy(TR03VO(ListaR03.Items[k]).TotalizadorParcial, 2, length(TR03VO(ListaR03.Items[k]).TotalizadorParcial))
                        else
                          COD_TOT_PAR := TR03VO(ListaR03.Items[k]).TotalizadorParcial;
                        VLR_ACUM_TOT := TR03VO(ListaR03.Items[k]).ValorAcumulado;
                        if length(trim(COD_TOT_PAR)) = 7 then
                          NR_TOT := StrToInt(Copy(COD_TOT_PAR,1,2))
                        else
                          NR_TOT := 0;
                      end;//with RegistroC420New do

                      if PerfilApresentacao = 1 then
                      begin
                        // C425
                        ListaC425 := TSpedFiscalController.TabelaC425(TR02VO(ListaR02.Items[j]).DataMovimento, TR02VO(ListaR02.Items[j]).DataMovimento, TR03VO(ListaR03.Items[k]).TotalizadorParcial);
                        if Assigned(ListaC425) then
                        begin
                          for l := 0 to ListaC425.Count - 1 do
                          begin
                            with RegistroC425New do
                            begin
                              COD_ITEM := IntToStr(TSpedFiscalC425VO(ListaC425.Items[l]).IdProduto);
                              UNID := IntToStr(TSpedFiscalC425VO(ListaC425.Items[l]).IdUnidade);
                              QTD := TSpedFiscalC425VO(ListaC425.Items[l]).SomaQuantidade;
                              VL_ITEM := TSpedFiscalC425VO(ListaC425.Items[l]).SomaValor;
                              VL_PIS := TSpedFiscalC425VO(ListaC425.Items[l]).SomaPIS;
                              VL_COFINS := TSpedFiscalC425VO(ListaC425.Items[l]).SomaCOFINS;
                            end;//with RegistroC425New do
                          end;//for l := 0 to ListaC425.Count - 1 do
                        end;//if Assigned(ListaC425) then
                      end;//if PerfilApresentacao = 1 then
                    end;//for k := 0 to ListaR03.Count - 1 do
                  end;//if Assigned(ListaR03) then

                  //se tiver o perfil A, gera o C460 com C470
                  if PerfilApresentacao = 0 then
                  begin
                    // C460
                    ListaR04 := TRegistroRController.TabelaR04(TR02VO(ListaR02.Items[j]).DataMovimento, TR02VO(ListaR02.Items[j]).DataMovimento, TImpressoraVO(ListaImpressora.Items[i]).Id);
                    if Assigned(ListaR04) then
                    begin
                      for l := 0 to ListaR04.Count - 1 do
                      begin
                        with RegistroC460New do
                        begin
                          COD_MOD := '2D';
                          if TR04VO(ListaR04.Items[l]).Cancelado = 'S' then
                            COD_SIT := sdCancelado
                          else
                            COD_SIT := sdRegular;

                          if COD_SIT = sdRegular then
                          begin
                            DT_DOC := StrToDateTime(TR04VO(ListaR04.Items[l]).DataEmissao);
                            VL_DOC := TR04VO(ListaR04.Items[l]).ValorLiquido;
                            VL_PIS := TR04VO(ListaR04.Items[l]).PIS;
                            VL_PIS := TR04VO(ListaR04.Items[l]).COFINS;
                            CPF_CNPJ := TR04VO(ListaR04.Items[l]).CPFCNPJ;
                            NOM_ADQ := TR04VO(ListaR04.Items[l]).Cliente;
                          end;//if COD_SIT = sdRegular then

                          NUM_DOC := IntToStr(TR04VO(ListaR04.Items[l]).COO);

                          if COD_SIT = sdRegular then
                          begin
                            // C470
                            ListaR05 := TRegistroRController.TabelaR05(TR04VO(ListaR04.Items[l]).Id, 'Sped');
                            if Assigned(ListaR05) then
                            begin
                              for m := 0 to ListaR05.Count - 1 do
                              begin
                                with RegistroC470New do
                                begin
                                  COD_MOD := '2D';
                                  COD_ITEM := IntToStr(TR05VO(ListaR05.Items[m]).IdProduto);
                                  QTD := TR05VO(ListaR05.Items[m]).Quantidade;
                                  QTD_CANC := TR05VO(ListaR05.Items[m]).QuantidadeCancelada;
                                  UNID := inttostr(TR05VO(ListaR05.Items[m]).idUnidade);
                                  VL_ITEM := TR05VO(ListaR05.Items[m]).TotalItem;
                                  CST_ICMS := TR05VO(ListaR05.Items[m]).CST;
                                  CFOP := IntToStr(TR05VO(ListaR05.Items[m]).CFOP);
                                  ALIQ_ICMS := TR05VO(ListaR05.Items[m]).AliquotaICMS;
                                  VL_PIS  := TR05VO(ListaR05.Items[m]).PIS;
                                  VL_COFINS  := TR05VO(ListaR05.Items[m]).COFINS;
                                end;//with RegistroC470New do
                              end;//for m := 0 to ListaR05.Count - 1 do
                            end;//if Assigned(ListaR05) then
                          end;//if COD_SIT = sdRegular then
                        end;//with RegistroC460New do
                      end;//for l := 0 to ListaR04.Count - 1 do
                    end;//if Assigned(ListaR04) then
                  end;//if PerfilApresentacao = 0 then

                  // C490
                  ListaC490 := TSpedFiscalController.TabelaC490(DateToStr(DT_DOC), DataFinal);
                  if Assigned(ListaC490) then
                  begin
                    for g := 0 to ListaC490.Count - 1 do
                    begin
                      with RegistroC490New do
                      begin
                        CST_ICMS := TSpedFiscalC490VO(ListaC490.Items[g]).CST;
                        CFOP := IntToStr(TSpedFiscalC490VO(ListaC490.Items[g]).CFOP);
                        ALIQ_ICMS := TSpedFiscalC490VO(ListaC490.Items[g]).TaxaICMS;
                        VL_OPR := TSpedFiscalC490VO(ListaC490.Items[g]).SomaValor;
                        VL_BC_ICMS := TSpedFiscalC490VO(ListaC490.Items[g]).SomaBaseICMS;
                        VL_ICMS := TSpedFiscalC490VO(ListaC490.Items[g]).SomaICMS;
                      end;//with RegistroC490New do
                    end;//for g := 0 to ListaC490.Count - 1 do
                  end;//if Assigned(ListaC490) then
                end;//with RegistroC405New do
              end;//for j := 0 to ListaR02.Count - 1 do
            end;//with RegistroC400New do
          end;//if Assigned(ListaR02) then
        end;//for i := 0 to ListaImpressora.Count - 1 do
      end;//if Assigned(ListaImpressora) then
    end;//with RegistroC001New do
  end;//with FDataModule.ACBrSpedFiscal.Bloco_C do
end;

// Bloco E
procedure GerarBlocoE;
var
  i: Integer;
  ListaE110: TObjectList<TMeiosPagamentoVO>;
begin
  with FDataModule.ACBrSpedFiscal.Bloco_E do
  begin
    // Abertura do Bloco E
    with RegistroE001New do
    begin
      IND_MOV := imComDados;

      with RegistroE100New do
      begin
        DT_INI := StrToDateTime(DataInicial);
        DT_FIN := StrToDateTime(DataFinal);
      end;
      end;//with RegistroE100New do

      ListaE110 := TSpedFiscalController.TabelaE110(DataInicial, DataFinal);
      if Assigned(ListaE110) then
      begin
        for i := 0 to ListaE110.Count - 1 do
        begin
          with RegistroE110New do
          begin
            VL_TOT_DEBITOS := TMeiosPagamentoVO(ListaE110.Items[i]).Total;
            VL_AJ_DEBITOS := 0;
            VL_TOT_AJ_DEBITOS := 0;
            VL_ESTORNOS_CRED := 0;
            VL_TOT_CREDITOS := 0;
            VL_AJ_CREDITOS := 0;
            VL_TOT_AJ_CREDITOS := 0;
            VL_ESTORNOS_DEB := 0;
            VL_SLD_CREDOR_ANT := 0;
            VL_SLD_APURADO := TMeiosPagamentoVO(ListaE110.Items[i]).Total;
            VL_TOT_DED := 0;
            VL_ICMS_RECOLHER := TMeiosPagamentoVO(ListaE110.Items[i]).Total;
            VL_SLD_CREDOR_TRANSPORTAR := 0;
            DEB_ESP := 0;

            with RegistroE116New do
            begin
              COD_OR := '000';
              VL_OR  := TMeiosPagamentoVO(ListaE110.Items[i]).Total;
              DT_VCTO := StrToDateTime(DataFinal);
              COD_REC := '1';
              NUM_PROC := '';
              IND_PROC := opNenhum;
              PROC := '';
              TXT_COMPL := '';
              MES_REF := Copy(TMeiosPagamentoVO(ListaE110.Items[i]).DataHora,6,2) +
                         Copy(TMeiosPagamentoVO(ListaE110.Items[i]).DataHora,1,4); //'092011';
            end;//with RegistroE116New do
          end;//with RegistroE110New do
        end;//for i := 0 to ListaE110.Count - 1 do
      end;//if Assigned(ListaE110) then
    end;//with RegistroE100New do
  end;//with FDataModule.ACBrSpedFiscal.Bloco_E do

// Bloco H
procedure GerarBlocoH;
var
  i: Integer;
  ListaE110: TObjectList<TMeiosPagamentoVO>;
begin
  with FDataModule.ACBrSpedFiscal.Bloco_H do
  begin
    // Abertura do Bloco H
    with RegistroH001New do
    begin
      IND_MOV := imSemDados;
    end;
  end;
end;

procedure GerarArquivoSpedFiscal(pDataIni: String; pDataFim: String; pVersao: Integer; pFinalidade: Integer; pPerfil: Integer);
var
  Mensagem, Arquivo : String;
begin
  VersaoLeiaute := pVersao;
  FinalidadeArquivo := pFinalidade;
  PerfilApresentacao := pPerfil;
  DataInicial := pDataIni;
  DataFinal := pDataFim;

  with FDataModule.ACBrSpedFiscal do
  begin
    DT_INI := StrToDate(pDataIni);
    DT_FIN := StrToDate(pDataFim);
  end;

  GerarBloco0;
  GerarBlocoC;
  GerarBlocoE;
  GerarBlocoH;

  Arquivo := Configuracao.Laudo+FormatDateTime('DDMMYYYYhhmmss',Now)+'.txt';

  FDataModule.ACBrSpedFiscal.Arquivo := Arquivo;

  FDataModule.ACBrSpedFiscal.SaveFileTXT;
  TEAD_Class.SingEAD(Arquivo);
  Mensagem := 'Arquivo armazenado em: ' + gsAppPath + Arquivo;
  Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

end.
