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

@author Albert Eije (T2Ti.COM)
@version 1.0
******************************************************************************* }

unit USpedFiscal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ACBrEFDBlocos, Dbtables, Inifiles, Generics.Collections, ACBrSpedFiscal,
  ACBrUtil, ACBrTXTClass;

procedure GerarBloco0;
procedure GerarBlocoC;
procedure GerarBlocoE;
procedure GerarBlocoH;
procedure GerarArquivoSpedFiscal(pDataIni: String; pDataFim: String; pVersao: Integer; pFinalidade:Integer; pPerfil: Integer);

implementation

uses
  UDataModule, UCaixa, EmpresaController, EmpresaVO, UnidadeController,
  UnidadeVO, ContadorController, ContadorVO, ProdutoController, ProdutoVO, NF2Controller,
  NF2CabecalhoVO, NF2DetalheVO, ImpressoraController, ImpressoraVO, R02VO,
  RegistroRController, SpedFiscalC390VO, SpedFiscalC321VO, R03VO, SpedFiscalController,
  SpedFiscalC425VO, R04VO, R05VO, SpedFiscalC490VO, MeiosPagamentoVO,
  EAD_Class, SWSystem;

var
  Empresa: TEmpresaVO;
  VersaoLeiaute, FinalidadeArquivo, PerfilApresentacao: Integer;
  DataInicial, DataFinal: String;

// Bloco 0
procedure GerarBloco0;
var
  Contador: TContadorVO;
  ListaUnidade: TObjectList<TUnidadeVO>;
  ListaProduto: TObjectList<TProdutoVO>;
  i: integer;
begin
  Empresa := TEmpresaController.PegaEmpresa(UCaixa.Configuracao.IdEmpresa);
  Contador := TContadorController.PegaContador;
  ListaUnidade := TUnidadeController.TabelaUnidade;
  ListaProduto := TProdutoController.TabelaProduto;

  with FDataModule.ACBrSpedFiscal.Bloco_0 do
  begin
    // Dados da Empresa
    with Registro0000New do
    begin
      case VersaoLeiaute of
        0:COD_VER := vlVersao100;
        1:COD_VER := vlVersao101;
        2:COD_VER := vlVersao102;
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
      COD_MUN := Empresa.CodigoMunicipioIBGE;
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
        ENDERECO := Empresa.ENDERECO;
        NUM := Empresa.Numero;
        COMPL := Empresa.Complemento;
        BAIRRO := Empresa.BAIRRO;
        FONE := Empresa.Fone1;
        FAX := Empresa.Fone2;
        EMAIL := Empresa.Email;
      end;
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
      end;
      // FILHO - Identificação das unidades de medida
      for i := 0 to ListaUnidade.Count - 1 do
      begin
        with Registro0190New do
        begin
          UNID := TUnidadeVO(ListaUnidade.Items[i]).NOME;
          DESCR := TUnidadeVO(ListaUnidade.Items[i]).Descricao;
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
          UNID_INV := TProdutoVO(ListaProduto.Items[i]).UnidadeProduto;

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
        end;
      end;
    end;
  end;
end;

procedure GerarBlocoC;
var
  ListaImpressora: TObjectList<TImpressoraVO>;
  ListaNF2Cabecalho: TObjectList<TNF2CabecalhoVO>;
  ListaNF2CabecalhoCanceladas: TObjectList<TNF2CabecalhoVO>;
  ListaNF2Detalhe: TObjectList<TNF2DetalheVO>;
  ListaC390: TObjectList<TSpedFiscalC390VO>;
  ListaC321: TObjectList<TSpedFiscalC321VO>;
  ListaC425: TObjectList<TSpedFiscalC425VO>;
  ListaC490: TObjectList<TSpedFiscalC490VO>;
  ListaR02: TObjectList<TR02VO>;
  ListaR03: TObjectList<TR03VO>;
  ListaR04: TObjectList<TR04VO>;
  ListaR05: TObjectList<TR05VO>;
  i, j, k, l, m: integer;
begin
  with FDataModule.ACBrSpedFiscal.Bloco_C do
  begin
    with RegistroC001New do
    begin
      IND_MOV := imComDados;

      ListaNF2Cabecalho := TNF2Controller.TabelaNF2Cabecalho(DataInicial, DataFinal);
      ListaNF2CabecalhoCanceladas := TNF2Controller.TabelaNF2CabecalhoCanceladas(DataInicial, DataFinal);

      //////////////
      //Perfil A  //
      //////////////
      if PerfilApresentacao = 0 then
      begin
        if Assigned(ListaNF2Cabecalho) then
        begin
          for i := 0 to ListaNF2Cabecalho.Count - 1 do
          begin
            with RegistroC350New do
            begin
              SER := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).Serie;
              SUB_SER := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).SubSerie;
              NUM_DOC := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).Numero;
              DT_DOC := StrToDate(TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).DataEmissao);
              CNPJ_CPF := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).CPFCNPJCliente;
              VL_MERC := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).TotalProdutos;
              VL_DOC := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).TotalNF;
              VL_DESC := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).Desconto;
              VL_PIS := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).PIS;
              VL_COFINS := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).COFINS;
              COD_CTA := '';

              // C370
              ListaNF2Detalhe := TNF2Controller.TabelaNF2Detalhe(TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).Id);
              if Assigned(ListaNF2Detalhe) then
              begin
                for j := 0 to ListaNF2Detalhe.Count - 1 do
                begin
                  with RegistroC370New do
                  begin
                    NUM_ITEM := IntToStr(TNF2DetalheVO(ListaNF2Detalhe.Items[j]).Item);
                    COD_ITEM := IntToStr(TNF2DetalheVO(ListaNF2Detalhe.Items[j]).IdProduto);
                    QTD := TNF2DetalheVO(ListaNF2Detalhe.Items[j]).Quantidade;
                    UNID := TNF2DetalheVO(ListaNF2Detalhe.Items[j]).DescricaoUnidade;
                    VL_ITEM := TNF2DetalheVO(ListaNF2Detalhe.Items[j]).ValorTotal;
                    VL_DESC := TNF2DetalheVO(ListaNF2Detalhe.Items[j]).Desconto;
                  end; // Fim dos Itens;
                end; // fim do for dos itens
              end; // fim do teste se voltou lista de itens
            end; // fim do registro 350
          end; // fim do laço na lista cabecalho
        end;

        // C390
        ListaC390 := TSpedFiscalController.TabelaC390(DataInicial, DataFinal);
        if Assigned(ListaC390) then
        begin
          for i := 0 to ListaC390.Count - 1 do
          begin
            with RegistroC390New do
            begin
              CST_ICMS := TSpedFiscalC390VO(ListaC390.Items[i]).CST;
              CFOP := IntToStr(TSpedFiscalC390VO(ListaC390.Items[i]).CFOP);
              ALIQ_ICMS := TSpedFiscalC390VO(ListaC390.Items[i]).TaxaICMS;
              VL_OPR := TSpedFiscalC390VO(ListaC390.Items[i]).SomaValor;
              VL_BC_ICMS := TSpedFiscalC390VO(ListaC390.Items[i]).SomaBaseICMS;
              VL_ICMS := TSpedFiscalC390VO(ListaC390.Items[i]).SomaICMS;
              VL_RED_BC := TSpedFiscalC390VO(ListaC390.Items[i]).SomaICMSOutras;
            end; // fim do registro 390
          end; // fim do laço na lista cabecalho
        end;
      end;//Fim do perfil A

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
              SER := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).Serie;
              SUB := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).SubSerie;
              DT_DOC := StrToDate(TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).DataEmissao);
              VL_DOC := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).TotalNF;
              VL_PIS := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).PIS;
              VL_COFINS := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).COFINS;
              COD_CTA := '';
            end; // fim do registro 300
          end; // fim do laço na lista cabecalho
        end;

        if Assigned(ListaNF2CabecalhoCanceladas) then
        begin
          for i := 0 to ListaNF2CabecalhoCanceladas.Count - 1 do
          begin
            // C310
            with RegistroC310New do
            begin
              NUM_DOC_CANC := TNF2CabecalhoVO(ListaNF2CabecalhoCanceladas.Items[i]).Numero;
            end; // fim do registro 300
          end; // fim do laço na lista cabecalho
        end;

        // C320 ---> igual ao C390
        ListaC390 := TSpedFiscalController.TabelaC390(DataInicial, DataFinal);
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
            end; // fim do registro 320
          end; // fim do laço na lista cabecalho
        end;

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
            end; // fim do registro 321
          end; // fim do laço na lista cabecalho
        end;

      end;//Fim do perfil B


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
                        COD_TOT_PAR := TR03VO(ListaR03.Items[k]).TotalizadorParcial;
                        VLR_ACUM_TOT := TR03VO(ListaR03.Items[k]).ValorAcumulado;
                        if length(trim(COD_TOT_PAR)) = 7 then
                          NR_TOT := StrToInt(Copy(COD_TOT_PAR,1,2))
                        else
                          NR_TOT := 0;
                      end;//fim with
                    end;//fim do for k
                  end;//fim do if C420

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
                            COD_SIT := sdRegular
                          else
                            COD_SIT := sdCancelado;
                          NUM_DOC := IntToStr(TR04VO(ListaR04.Items[l]).COO);
                          DT_DOC := StrToDateTime(TR04VO(ListaR04.Items[l]).DataEmissao);
                          VL_DOC := TR04VO(ListaR04.Items[l]).ValorLiquido;
                          VL_PIS := TR04VO(ListaR04.Items[l]).PIS;
                          VL_PIS := TR04VO(ListaR04.Items[l]).COFINS;
                          CPF_CNPJ := TR04VO(ListaR04.Items[l]).CPFCNPJ;
                          NOM_ADQ := TR04VO(ListaR04.Items[l]).Cliente;


                          // C470
                          ListaR05 := TRegistroRController.TabelaR05(TR04VO(ListaR04.Items[l]).Id);
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
                                UNID := TR05VO(ListaR05.Items[m]).SiglaUnidade;
                                VL_ITEM := TR05VO(ListaR05.Items[m]).ValorUnitario;
                                CST_ICMS := TR05VO(ListaR05.Items[m]).CST;
                                CFOP := IntToStr(TR05VO(ListaR05.Items[m]).CFOP);
                                ALIQ_ICMS := TR05VO(ListaR05.Items[m]).AliquotaICMS;
                                VL_PIS  := TR05VO(ListaR05.Items[m]).PIS;
                                VL_COFINS  := TR05VO(ListaR05.Items[m]).COFINS;
                              end;//fim with
                            end;//fim for
                          end;//fim if C470

                        end;//fim with
                      end;//fim for
                    end;//fim if C425
                  end;//fim perfil A


                  //se tiver o perfil B, gera o C425
                  if PerfilApresentacao = 1 then
                  begin
                    // C425
                    ListaC425 := TSpedFiscalController.TabelaC425(TR02VO(ListaR02.Items[j]).DataMovimento, TR02VO(ListaR02.Items[j]).DataMovimento);
                    if Assigned(ListaC425) then
                    begin
                      for l := 0 to ListaC425.Count - 1 do
                      begin
                        with RegistroC425New do
                        begin
                          COD_ITEM := IntToStr(TSpedFiscalC425VO(ListaC425.Items[l]).IdProduto);
                          UNID := TSpedFiscalC425VO(ListaC425.Items[l]).DescricaoUnidade;
                          QTD := TSpedFiscalC425VO(ListaC425.Items[l]).SomaQuantidade;
                          VL_ITEM := TSpedFiscalC425VO(ListaC425.Items[l]).SomaValor;
                          VL_PIS := TSpedFiscalC425VO(ListaC425.Items[l]).SomaPIS;
                          VL_COFINS := TSpedFiscalC425VO(ListaC425.Items[l]).SomaCOFINS;
                        end;//fim with
                      end;//fim for
                    end;//fim if C425
                  end;//fim perfil B

                end; // Fim dos Itens;
              end; // fim do for dos itens 405
            end; // fim do registro 400

            // C490
            ListaC490 := TSpedFiscalController.TabelaC490(DataInicial, DataFinal);
            if Assigned(ListaC490) then
            begin
              for j := 0 to ListaC490.Count - 1 do
              begin
                with RegistroC490New do
                begin
                  CST_ICMS := TSpedFiscalC490VO(ListaC490.Items[j]).CST;
                  CFOP := IntToStr(TSpedFiscalC490VO(ListaC490.Items[j]).CFOP);
                  ALIQ_ICMS := TSpedFiscalC490VO(ListaC490.Items[j]).TaxaICMS;
                  VL_OPR := TSpedFiscalC490VO(ListaC490.Items[j]).SomaValor;
                  VL_BC_ICMS := TSpedFiscalC490VO(ListaC490.Items[j]).SomaBaseICMS;
                  VL_ICMS := TSpedFiscalC490VO(ListaC490.Items[j]).SomaICMS;
                end; // fim do with
              end; // fim do for
            end; //fim do registro C490

          end; // fim do if R02
        end; // fim do laço na lista cabecalho da impressora
      end;

    end; // fim do registro C0001
  end; // fim do bloco C
end;

// Bloco E
procedure GerarBlocoE;
var
  i: integer;
  ListaE110: TObjectList<TMeiosPagamentoVO>;
begin
  with FDataModule.ACBrSpedFiscal.Bloco_E do
  begin
    // Abertura do Bloco E
    with RegistroE100New do
    begin
      DT_INI := StrToDateTime(DataInicial);
      DT_FIN := StrToDateTime(DataFinal);
    end;

    // E110 - Estamos usando o VO MeiosPagamentoVO por causa da estrutura dele
    ListaE110 := TSpedFiscalController.TabelaE110(DataInicial, DataFinal);
    if Assigned(ListaE110) then
    begin
      for i := 0 to ListaE110.Count - 1 do
      begin
        with RegistroE110New do
        begin
          VL_TOT_CREDITOS := TMeiosPagamentoVO(ListaE110.Items[i]).Total;
        end; // fim do with
      end; // fim do for
    end; //fim do registro E110
  end;
end;

// Bloco H
procedure GerarBlocoH;
var
  i: integer;
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

procedure GerarArquivoSpedFiscal(pDataIni: String; pDataFim: String; pVersao: Integer; pFinalidade:Integer; pPerfil: Integer);
var
  mensagem : String;
begin
  VersaoLeiaute := pVersao;
  FinalidadeArquivo := pFinalidade;
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

  FDataModule.ACBrSpedFiscal.SaveFileTXT;

  TEAD_Class.SingEAD('SpedFiscal.txt');

  mensagem := 'Arquivo armazenado em: ' + gsAppPath + 'SpedFiscal.txt';
  Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

end.
