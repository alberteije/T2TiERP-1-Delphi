{*******************************************************************************
Title: T2Ti ERP
Description: Funções e procedimentos do PAF;

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

@author Albert Eije (T2Ti.COM) | Gilson Lima | FC Costa
@version 1.0
*******************************************************************************}

unit UPAF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Inifiles, Generics.Collections, Biblioteca,
  ProdutoController, UCaixa, ACBrPAF, ACBrPAF_E,SQLExpr,
  ACBrPAF_P, ACBrPAF_N, ACBrPAF_R, ACBrPAFRegistros, SWSystem,
  ImpressoraVO, ProdutoVO;

procedure PreencherHeader(Header: TRegistroX1);
procedure GeraTabelaProdutos;
procedure GeraArquivoEstoque; overload;
procedure GeraArquivoEstoque(CodigoInicio: Integer; CodigoFim: Integer); overload;
procedure GeraArquivoEstoque(NomeInicio: String; NomeFim: String); overload;
procedure GeraEstoque(ListaProduto: TObjectList<TProdutoVO>);
procedure GeraMovimentoECF(DataInicio: String; DataFim: String; DataMovimento: String; Impressora: TImpressoraVO);
procedure GravaR02R03;
procedure Grava60M60A(IdImpressora: Integer);
procedure GravaR06(Simbolo: String);
procedure MeiosPagamento(DataIni: String; DataFim: String);
procedure IdentificacaoPafEcf;
procedure ParametrodeConfiguracao;
function GeraMD5: String;
function ECFAutorizado: Boolean;
function ConfereGT: Boolean;
procedure AtualizaGT;

implementation

uses
R02VO, R03VO, R04VO, R05VO, R06VO, R07VO, RegistroRController, EmpresaController,
EmpresaVO, UDataModule, ImpressoraController, TotalTipoPagamentoController,
MeiosPagamentoVO, SintegraController, Sintegra60MVO, Sintegra60AVO, EAD_Class, R01VO, strutils;

procedure PreencherHeader(Header: TRegistroX1);
var
  Empresa: TEmpresaVO;
begin
  try
    Empresa := TEmpresaController.PegaEmpresa(UCaixa.Configuracao.IdEmpresa);
    Header.UF          := Empresa.UF;
    Header.CNPJ        := Empresa.CNPJ;
    Header.IE          := Empresa.InscricaoEstadual;
    Header.IM          := Empresa.InscricaoMunicipal;
    Header.RAZAOSOCIAL := Empresa.RazaoSocial;
  finally
    if Assigned(Empresa) then
      FreeAndNil(Empresa);
  end;
end;

procedure GeraTabelaProdutos;
var
  P2: TRegistroP2;
  i: Integer;
  ListaProduto: TObjectList<TProdutoVO>;
  Mensagem, Tripa: String;
begin
  try
    ListaProduto := TProdutoController.TabelaProduto;
    if Assigned(ListaProduto) then
    begin
      // registro P1
      PreencherHeader(FDataModule.ACBrPAF.PAF_P.RegistroP1);
      // registro P2
      FDataModule.ACBrPAF.PAF_P.RegistroP2.Clear;
      for i := 0 to ListaProduto.Count - 1 do
      begin
        DecimalSeparator := '.';
        Tripa :=  TProdutoVO(ListaProduto.Items[i]).GTIN +
                  TProdutoVO(ListaProduto.Items[i]).Descricao +
                  TProdutoVO(ListaProduto.Items[i]).DescricaoPDV +
                  FormataFloat('Q',TProdutoVO(ListaProduto.Items[i]).QtdeEstoqueAnterior) +
                  TProdutoVO(ListaProduto.Items[i]).DataEstoque +
                  TProdutoVO(ListaProduto.Items[i]).Cst +
                  FormataFloat('V',TProdutoVO(ListaProduto.Items[i]).AliquotaICMS) +
                  FormataFloat('V',TProdutoVO(ListaProduto.Items[i]).ValorVenda) +
                  IntToStr(TProdutoVO(ListaProduto.Items[i]).HashIncremento);
        DecimalSeparator := ',';

        P2                := FDataModule.ACBrPAF.PAF_P.RegistroP2.New;
        P2.COD_MERC_SERV  := TProdutoVO(ListaProduto.Items[i]).GTIN;
        P2.DESC_MERC_SERV := TProdutoVO(ListaProduto.Items[i]).DescricaoPDV;

        if MD5String(Tripa) <> TProdutoVO(ListaProduto.Items[i]).HashTripa then
          P2.UN_MED   := StringOfChar('?',6)
        else
          P2.UN_MED    := TProdutoVO(ListaProduto.Items[i]).UnidadeProduto;

        P2.IAT            := TProdutoVO(ListaProduto.Items[i]).IAT;
        P2.IPPT           := TProdutoVO(ListaProduto.Items[i]).IPPT;
        P2.ST             := TProdutoVO(ListaProduto.Items[i]).PafProdutoST;  // Gilson
        P2.ALIQ           := TProdutoVO(ListaProduto.Items[i]).AliquotaICMS;
        P2.VL_UNIT        := TProdutoVO(ListaProduto.Items[i]).ValorVenda;
      end;
      FDataModule.ACBrPAF.SaveFileTXT_P('PAF_P.txt');
      TEAD_Class.SingEAD('PAF_P.txt');

      Mensagem := 'Arquivo armazenado em: ' + gsAppPath + 'PAF_P.txt';
      Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end
    else
      Application.MessageBox('Não existem produtos na tabela.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  finally
    if Assigned(ListaProduto) then
      FreeAndNil(ListaProduto);
  end;
end;

procedure GeraArquivoEstoque;
var
  ListaProduto: TObjectList<TProdutoVO>;
begin
  try
    ListaProduto := TProdutoController.TabelaProduto;
    if Assigned(ListaProduto) then
      GeraEstoque(ListaProduto)
    else
      Application.MessageBox('Não existem produtos na tabela.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  finally
    if Assigned(ListaProduto) then
    FreeAndNil(ListaProduto);
  end;
end;

procedure GeraArquivoEstoque(CodigoInicio: Integer; CodigoFim: Integer);
var
  ListaProduto: TObjectList<TProdutoVO>;
begin
  try
    ListaProduto := TProdutoController.TabelaProduto(CodigoInicio,CodigoFim);
    if Assigned(ListaProduto) then
      GeraEstoque(ListaProduto)
    else
      Application.MessageBox('Não existem produtos na tabela.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  finally
    if Assigned(ListaProduto) then
    FreeAndNil(ListaProduto);
  end;
end;

procedure GeraArquivoEstoque(NomeInicio: String; NomeFim: String);
var
  ListaProduto: TObjectList<TProdutoVO>;
begin
  try
    ListaProduto := TProdutoController.TabelaProduto(NomeInicio, NomeFim);
    if Assigned(ListaProduto) then
      GeraEstoque(ListaProduto)
    else
      Application.MessageBox('Não existem produtos na tabela.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  finally
    if Assigned(ListaProduto) then
    FreeAndNil(ListaProduto);
  end;
end;

procedure GeraEstoque(ListaProduto: TObjectList<TProdutoVO>);
var
  E2: TRegistroE2;
  i: Integer;
  Mensagem, Tripa: String;
begin
  // registro E1
  PreencherHeader(FDataModule.ACBrPAF.PAF_E.RegistroE1); // preencher header do arquivo
  // registro E2
  FDataModule.ACBrPAF.PAF_E.RegistroE2.Clear;
  for i := 0 to ListaProduto.Count - 1 do
  begin
    DecimalSeparator := '.';
    Tripa :=  TProdutoVO(ListaProduto.Items[i]).GTIN +
              TProdutoVO(ListaProduto.Items[i]).Descricao +
              TProdutoVO(ListaProduto.Items[i]).DescricaoPDV +
              FormataFloat('Q',TProdutoVO(ListaProduto.Items[i]).QtdeEstoqueAnterior) +
              TProdutoVO(ListaProduto.Items[i]).DataEstoque +
              TProdutoVO(ListaProduto.Items[i]).Cst +
              FormataFloat('V',TProdutoVO(ListaProduto.Items[i]).AliquotaICMS) +
              FormataFloat('V',TProdutoVO(ListaProduto.Items[i]).ValorVenda) +
              IntToStr(TProdutoVO(ListaProduto.Items[i]).HashIncremento);
    DecimalSeparator := ',';

    E2           := FDataModule.ACBrPAF.PAF_E.RegistroE2.New;
    E2.COD_MERC  := TProdutoVO(ListaProduto.Items[i]).GTIN;
    E2.DESC_MERC := TProdutoVO(ListaProduto.Items[i]).DescricaoPDV;

    if MD5String(Tripa) <> TProdutoVO(ListaProduto.Items[i]).HashTripa then
      E2.UN_MED   := StringOfChar('?',6)
    else
      E2.UN_MED    := TProdutoVO(ListaProduto.Items[i]).UnidadeProduto;

    E2.QTDE_EST  := TProdutoVO(ListaProduto.Items[i]).QtdeEstoqueAnterior;
    E2.DT_EST    := StrToDateTime(TProdutoVO(ListaProduto.Items[i]).DataEstoque);
  end;
  FDataModule.ACBrPAF.SaveFileTXT_E('PAF_E.txt');
  TEAD_Class.SingEAD('PAF_E.txt');

  Mensagem := 'Arquivo armazenado em: ' + gsAppPath + 'PAF_E.txt';
  Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure GravaR02R03;
var
  R02: TR02VO;
  R03: TR03VO;
  ListaR03: TObjectList<TR03VO>;
  i: Integer;
  Indice, Aliquota: String;
begin
  try
    ListaR03 := TObjectList<TR03VO>.Create;
    //Dados para o registro R02
    R02 := TR02VO.Create;
    R02.IdCaixa := UCaixa.Movimento.IdCaixa;
    R02.IdOperador := UCaixa.Movimento.IdOperador;
    R02.IdImpressora := UCaixa.Movimento.IdImpressora;

    FDataModule.ACBrECF.DadosReducaoZ;
    with FDataModule.ACBrECF.DadosReducaoZClass do
    begin
      R02.CRZ := CRZ + 1;
      R02.COO := StrtoInt(FDataModule.ACBrECF.NumCOO) + 1;
      R02.CRO := CRO;
      R02.DataMovimento := FormatDateTime('yyyy-mm-dd', DataDoMovimento);
      R02.DataEmissao   := FormatDateTime('yyyy-mm-dd', DataDaImpressora);
      R02.HoraEmissao   := FormatDateTime('hh:mm:ss'  , DataDaImpressora);;
      R02.VendaBruta    := ValorVendaBruta;
      R02.GrandeTotal   := ValorGrandeTotal;
    end;

    R02 := TRegistroRController.GravaR02(R02);

    //Dados para o registro R03
    with FDataModule.ACBrECF.DadosReducaoZClass do
    begin
      //Dados ICMS
      for i := 0 to ICMS.Count -1 do
      begin
        R03 := TR03VO.Create;
        R03.IdR02 := R02.Id;
        R03.CRZ := CRZ + 1;
        //Completa com zeros a esquerda
        Indice := StringOfChar('0',2-Length(ICMS[i].Indice)) + ICMS[i].Indice;
        //Tira as virgulas
        Aliquota := StringReplace(FloatToStr(ICMS[i].Aliquota * 100), ',', '', [rfReplaceAll]);
        //Completa com zeros a esquerda e a direita
        Aliquota := StringOfChar('0',4-Length(Aliquota)) + Aliquota;
        R03.TotalizadorParcial := Indice + 'T' + Aliquota;
        R03.ValorAcumulado := ICMS[i].Total;
        ListaR03.Add(R03);
      end;
      //Dados ISSQN
      for i := 0 to ISSQN.Count -1 do
      begin
        R03 := TR03VO.Create;
        R03.IdR02 := R02.Id;
        //Completa com zeros a esquerda
        Indice := StringOfChar('0',2-Length(ISSQN[i].Indice)) + ISSQN[i].Indice;
        //Tira as virgulas
        Aliquota := StringReplace(FloatToStr(ISSQN[i].Aliquota * 100), ',', '', [rfReplaceAll]);
        //Completa com zeros a esquerda
        Aliquota := StringOfChar('0',4-Length(Aliquota)) + Aliquota;
        R03.TotalizadorParcial := Indice + 'S' + Aliquota;
        R03.ValorAcumulado := ISSQN[i].Total;
        ListaR03.Add(R03);
      end;
      //Substituição Tributária - ICMS
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'F1';
      R03.ValorAcumulado := SubstituicaoTributariaICMS;
      ListaR03.Add(R03);

      //Isento - ICMS
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'I1';
      R03.ValorAcumulado := IsentoICMS;
      ListaR03.Add(R03);

      //Não-incidência - ICMS
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'N1';
      R03.ValorAcumulado := NaoTributadoICMS;
      ListaR03.Add(R03);

      //Substituição Tributária - ISSQN
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'FS1';
      R03.ValorAcumulado := SubstituicaoTributariaISSQN;
      ListaR03.Add(R03);

      //Isento - ISSQN
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'IS1';
      R03.ValorAcumulado := IsentoISSQN;
      ListaR03.Add(R03);

      //Não-incidência - ISSQN
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'NS1';
      R03.ValorAcumulado := NaoTributadoISSQN;
      ListaR03.Add(R03);

      //Operações Não Fiscais
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'OPNF';
      R03.ValorAcumulado := TotalOperacaoNaoFiscal;
      ListaR03.Add(R03);

      //Desconto - ICMS
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'DT';
      R03.ValorAcumulado := DescontoICMS;
      ListaR03.Add(R03);

      //Desconto - ISSQN
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'DS';
      R03.ValorAcumulado := DescontoISSQN;
      ListaR03.Add(R03);

      //Acréscimo - ICMS
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'AT';
      R03.ValorAcumulado := AcrescimoICMS;
      ListaR03.Add(R03);

      //Acréscimo - ISSQN
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'AS';
      R03.ValorAcumulado := AcrescimoISSQN;
      ListaR03.Add(R03);

      //Cancelamento - ICMS
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'Can-T';
      R03.ValorAcumulado := CancelamentoICMS;
      ListaR03.Add(R03);

      //Cancelamento - ISSQN
      R03 := TR03VO.Create;
      R03.IdR02 := R02.Id;
      R03.TotalizadorParcial := 'Can-S';
      R03.ValorAcumulado := CancelamentoISSQN;
      ListaR03.Add(R03);
    end;
    TRegistroRController.GravaR03(ListaR03);

    Grava60M60A(R02.IdImpressora);

  finally
  if Assigned(R02) then
    FreeAndNil(R02);
  if Assigned(ListaR03) then
    FreeAndNil(ListaR03);
  end;
end;

procedure GeraMovimentoECF(DataInicio: String; DataFim: String; DataMovimento: String; Impressora: TImpressoraVO);
var
  i,j: Integer;
  Empresa: TEmpresaVO;
  R01: TR01VO;
  ListaR02: TObjectList<TR02VO>;
  ListaR03: TObjectList<TR03VO>;
  ListaR04: TObjectList<TR04VO>;
  ListaR05: TObjectList<TR05VO>;
  ListaR06: TObjectList<TR06VO>;
  ListaR07: TObjectList<TR07VO>;
  Mensagem, NomeArquivo, TripaR01, TripaR02, TripaR03, TripaR04, TripaR05, TripaR06, TripaR07: String;
begin
  try
    //dados da empresa
    Empresa := TEmpresaController.PegaEmpresa(UCaixa.Configuracao.IdEmpresa);
    //dados software house e demais do R01
    R01 := TRegistroRController.RegistroR01;

    // Registro R1 - Identificação do ECF, do Usuário, do PAF-ECF e da Empresa Desenvolvedora e Dados do Arquivo
    with FDataModule.ACBrPAF.PAF_R.RegistroR01 do
    begin
      TripaR01 := R01.SerieEcf +
                  R01.CnpjEmpresa +
                  IntToStr(R01.HashIncremento);
      if (MD5String(TripaR01) <> R01.HashTripa) then
        RegistroValido := False;

      NUM_FAB      := R01.SerieEcf;
      MF_ADICIONAL := Impressora.MFD;
      TIPO_ECF     := Impressora.Tipo;
      MARCA_ECF    := Impressora.Marca;
      MODELO_ECF   := Impressora.Modelo;
      VERSAO_SB    := Impressora.Versao;
      DT_INST_SB   := StrToDateTime(Impressora.DataInstalacaoSb);
      HR_INST_SB   := StrToDateTime(Impressora.HoraInstalacaoSb);
      NUM_SEQ_ECF  := StrToInt(Impressora.NumeroEcf);
      CNPJ         := R01.CnpjEmpresa;
      IE           := Empresa.InscricaoEstadual;
      CNPJ_SH      := R01.CnpjSh;
      IE_SH        := R01.InscricaoEstadualSh;
      IM_SH        := R01.InscricaoMunicipalSh;
      NOME_SH      := R01.DenominacaoSh;
      NOME_PAF     := R01.NomePafEcf;
      VER_PAF      := R01.VersaoPafEcf;
      COD_MD5      := R01.Md5PafEcf;
      DT_INI 		 := StrToDateTime(DataInicio);
      DT_FIN 		 := StrToDateTime(DataFim);
      ER_PAF_ECF   := R01.VersaoEr;
    end;

    // Registro R02 e R03
    ListaR02 := TRegistroRController.TabelaR02(DataInicio, DataFim, Impressora.Id);
    if Assigned(ListaR02) then
    begin
      for i := 0 to ListaR02.Count - 1 do
      begin

        TripaR02 :=  IntToStr(TR02VO(ListaR02.Items[i]).Id) +
                  IntToStr(TR02VO(ListaR02.Items[i]).IdOperador) +
                  IntToStr(TR02VO(ListaR02.Items[i]).IdImpressora) +
                  IntToStr(TR02VO(ListaR02.Items[i]).IdCaixa) +
                  IntToStr(TR02VO(ListaR02.Items[i]).CRZ) +
                  IntToStr(TR02VO(ListaR02.Items[i]).COO) +
                  IntToStr(TR02VO(ListaR02.Items[i]).CRO) +
                  FormatDateTime('yyyy-mm-dd',StrToDate(TR02VO(ListaR02.Items[i]).DataMovimento)) +
                  FormatDateTime('yyyy-mm-dd',StrToDate(TR02VO(ListaR02.Items[i]).DataEmissao)) +
                  TR02VO(ListaR02.Items[i]).HoraEmissao +
                  FormataFloat('V',TR02VO(ListaR02.Items[i]).VendaBruta) +
                  FormataFloat('V',TR02VO(ListaR02.Items[i]).GrandeTotal) +
                  TR02VO(ListaR02.Items[i]).SerieEcf +
                  IntToStr(TR02VO(ListaR02.Items[i]).HashIncremento);

        with FDataModule.ACBrPAF.PAF_R.RegistroR02.New do
        begin
          if (MD5String(TripaR02) <> TR02VO(ListaR02.Items[i]).HashTripa)
          then
            RegistroValido := False;

          NUM_USU     := TR02VO(ListaR02.Items[i]).IdOperador;
          CRZ         := TR02VO(ListaR02.Items[i]).CRZ;
          COO         := TR02VO(ListaR02.Items[i]).COO;
          CRO         := TR02VO(ListaR02.Items[i]).CRO;
          DT_MOV      := StrToDateTime(TR02VO(ListaR02.Items[i]).DataMovimento);
          DT_EMI      := StrToDateTime(TR02VO(ListaR02.Items[i]).DataEmissao);
          HR_EMI      := StrToDateTime(TR02VO(ListaR02.Items[i]).HoraEmissao);
          VL_VBD      := TR02VO(ListaR02.Items[i]).VendaBruta;
          PAR_ECF     := '';

          // Registro R03 - FILHO
          ListaR03 := TRegistroRController.TabelaR03(TR02VO(ListaR02.Items[i]).Id);
          if Assigned(ListaR03) then
          begin
            for j := 0 to ListaR03.Count - 1 do
            begin
              TripaR03 :=  TR03VO(ListaR03.Items[j]).TotalizadorParcial +
                        FormataFloat('V',TR03VO(ListaR03.Items[j]).ValorAcumulado) +
                        IntToStr(TR03VO(ListaR03.Items[j]).CRZ) +
                        TR03VO(ListaR03.Items[j]).SerieEcf +
                        IntToStr(TR03VO(ListaR03.Items[j]).HashIncremento);

              with RegistroR03.New do
              begin
                if (MD5String(TripaR03) <> TR03VO(ListaR03.Items[j]).HashTripa) then
                  RegistroValido := False;

                TOT_PARCIAL := TR03VO(ListaR03.Items[j]).TotalizadorParcial;
                VL_ACUM     := TR03VO(ListaR03.Items[j]).ValorAcumulado;
              end;//with RegistroR03.New do
            end;//for j := 0 to ListaR03.Count - 1 do
          end;//if Assigned(ListaR03) then
        end;//with FDataModule.ACBrPAF.PAF_R.RegistroR02.New do
      end;//for i := 0 to ListaR02.Count - 1 do
    end;//if Assigned(ListaR02) then

    // Registro R04 e R05
    ListaR04 := TRegistroRController.TabelaR04(DataInicio, DataFim, Impressora.Id);
    if Assigned(ListaR04) then
    begin
      for i := 0 to ListaR04.Count - 1 do
      begin

        TripaR04 := IntToStr(TR04VO(ListaR04.Items[i]).Id) +
                 IntToStr(TR04VO(ListaR04.Items[i]).CCF) +
                 IntToStr(TR04VO(ListaR04.Items[i]).COO) +
                 FormataFloat('V',TR04VO(ListaR04.Items[i]).ValorLiquido) +
                 TR04VO(ListaR04.Items[i]).SerieEcf +
                 TR04VO(ListaR04.Items[i]).StatusVenda +
                 TR04VO(ListaR04.Items[i]).Cancelado +
                 IntToStr(TR04VO(ListaR04.Items[i]).HashIncremento);

        with FDataModule.ACBrPAF.PAF_R.RegistroR04.New do
        begin
          if (MD5String(TripaR04) <> TR04VO(ListaR04.Items[i]).HashTripa) then
            RegistroValido := False;

          NUM_USU     := TR04VO(ListaR04.Items[i]).IdOperador;
          NUM_CONT    := TR04VO(ListaR04.Items[i]).CCF;
          COO         := TR04VO(ListaR04.Items[i]).COO;
          DT_INI      := StrToDateTime(TR04VO(ListaR04.Items[i]).DataEmissao);
          SUB_DOCTO   := TR04VO(ListaR04.Items[i]).SubTotal;
          SUB_DESCTO  := TR04VO(ListaR04.Items[i]).Desconto;
          TP_DESCTO   := TR04VO(ListaR04.Items[i]).IndicadorDesconto;
          SUB_ACRES   := TR04VO(ListaR04.Items[i]).Acrescimo;
          TP_ACRES    := TR04VO(ListaR04.Items[i]).IndicadorAcrescimo;
          VL_TOT      := TR04VO(ListaR04.Items[i]).ValorLiquido;
          CANC        := TR04VO(ListaR04.Items[i]).Cancelado;
          VL_CA       := TR04VO(ListaR04.Items[i]).CancelamentoAcrescimo;
          ORDEM_DA    := TR04VO(ListaR04.Items[i]).OrdemDescontoAcrescimo;
          NOME_CLI    := TR04VO(ListaR04.Items[i]).Cliente;
          CNPJ_CPF    := TR04VO(ListaR04.Items[i]).CPFCNPJ;

          //Registro R05 - FILHO
          ListaR05 := TRegistroRController.TabelaR05(TR04VO(ListaR04.Items[i]).Id, 'Paf');
          if Assigned(ListaR05) then
          begin
            for j := 0 to ListaR05.Count - 1 do
            begin

              TripaR05 :=
                          TR05VO(ListaR05.Items[j]).SerieEcf +
                          IntToStr(TR05VO(ListaR05.Items[j]).Coo) +
                          IntToStr(TR05VO(ListaR05.Items[j]).Ccf) +
                          TR05VO(ListaR05.Items[j]).GTIN +
                          FormataFloat('Q',TR05VO(ListaR05.Items[j]).Quantidade) +
                          FormataFloat('V',TR05VO(ListaR05.Items[j]).ValorUnitario) +
                          FormataFloat('V',TR05VO(ListaR05.Items[j]).TotalItem) +
                          TR05VO(ListaR05.Items[j]).TotalizadorParcial +
                          TR05VO(ListaR05.Items[j]).IndicadorCancelamento +
                          IntToStr(TR05VO(ListaR05.Items[j]).HashIncremento);

              with RegistroR05.New do
              begin
                if (MD5String(TripaR05) <> TR05VO(ListaR05.Items[j]).HashTripa) then
                  RegistroValido := False;

                NUM_ITEM     := TR05VO(ListaR05.Items[j]).Item;
                COD_ITEM     := TR05VO(ListaR05.Items[j]).GTIN;
                DESC_ITEM    := TR05VO(ListaR05.Items[j]).DescricaoPDV;
                QTDE_ITEM    := TR05VO(ListaR05.Items[j]).Quantidade;
                UN_MED       := TR05VO(ListaR05.Items[j]).SiglaUnidade;
                VL_UNIT      := TR05VO(ListaR05.Items[j]).ValorUnitario;
                DESCTO_ITEM  := TR05VO(ListaR05.Items[j]).Desconto;
                ACRES_ITEM   := TR05VO(ListaR05.Items[j]).Acrescimo;
                VL_TOT_ITEM  := TR05VO(ListaR05.Items[j]).TotalItem;
                COD_TOT_PARC := TR05VO(ListaR05.Items[j]).TotalizadorParcial;
                IND_CANC     := TR05VO(ListaR05.Items[j]).IndicadorCancelamento;
                QTDE_CANC    := TR05VO(ListaR05.Items[j]).QuantidadeCancelada;
                VL_CANC      := TR05VO(ListaR05.Items[j]).ValorCancelado;
                VL_CANC_ACRES:= TR05VO(ListaR05.Items[j]).CancelamentoAcrescimo;
                IAT          := TR05VO(ListaR05.Items[j]).IAT;
                IPPT         := TR05VO(ListaR05.Items[j]).IPPT;
                QTDE_DECIMAL := TR05VO(ListaR05.Items[j]).CasasDecimaisQuantidade;
                VL_DECIMAL   := TR05VO(ListaR05.Items[j]).CasasDecimaisValor;
              end;//with RegistroR05.New do
            end;//for j := 0 to ListaR05.Count - 1 do
          end;//if Assigned(ListaR05) then

          // Registro R07 - MEIOS DE PAGAMENTO
          ListaR07 := TRegistroRController.TabelaR07IdR04(TR04VO(ListaR04.Items[i]).Id);
          if Assigned(ListaR07) then
          begin
            for j := 0 to ListaR07.Count - 1 do
            begin

              TripaR07 :=
                          TR07VO(ListaR07.Items[j]).SerieEcf +
                          IntToStr(TR07VO(ListaR07.Items[j]).Coo) +
                          IntToStr(TR07VO(ListaR07.Items[j]).Ccf) +
                          IntToStr(TR07VO(ListaR07.Items[j]).Gnf) +
                          IntToStr(TR07VO(ListaR07.Items[j]).HashIncremento);

              with RegistroR07.New do
              begin

                if (MD5String(TripaR07) <> TR07VO(ListaR07.Items[j]).HashTripa) then
                  RegistroValido := False;

                 CCF         := TR07VO(ListaR07.Items[j]).CCF;
                 GNF         := TR07VO(ListaR07.Items[j]).Gnf;
                 MP          := TR07VO(ListaR07.Items[j]).MeioPagamento;
                 VL_PAGTO    := TR07VO(ListaR07.Items[j]).ValorPagamento;
                 IND_EST     := TR07VO(ListaR07.Items[j]).IndicadorEstorno;
                 VL_EST      := TR07VO(ListaR07.Items[j]).ValorEstorno;
              end;//with RegistroR07.New do
            end;//for j := 0 to ListaR07.Count - 1 do
          end;//if Assigned(ListaR07) then
        end;//with FDataModule.ACBrPAF.PAF_R.RegistroR04.New do
      end;//for i := 0 to ListaR04.Count - 1 do
    end;//if Assigned(ListaR04) then

    // Registro R06 e R07
    ListaR06 := TRegistroRController.TabelaR06(DataInicio, DataFim, Impressora.Id);
    if Assigned(ListaR06) then
    begin
      for i := 0 to ListaR06.Count - 1 do
      begin

        TripaR06 :=
                 IntToStr(TR06VO(ListaR06.Items[i]).COO) +
                 IntToStr(TR06VO(ListaR06.Items[i]).GNF) +
                 IntToStr(TR06VO(ListaR06.Items[i]).GRG) +
                 IntToStr(TR06VO(ListaR06.Items[i]).CDC) +
                 TR06VO(ListaR06.Items[i]).Denominacao +
                 TR06VO(ListaR06.Items[i]).DataEmissao +
                 TR06VO(ListaR06.Items[i]).HoraEmissao +
                 TR06VO(ListaR06.Items[i]).SerieEcf +
                 IntToStr(TR06VO(ListaR06.Items[i]).HashIncremento);

        with FDataModule.ACBrPAF.PAF_R.RegistroR06.New do
        begin
          if (MD5String(TripaR06) <> TR06VO(ListaR06.Items[i]).HashTripa) then
            RegistroValido := False;

          NUM_USU     := TR06VO(ListaR06.Items[i]).IdOperador;
          COO         := TR06VO(ListaR06.Items[i]).COO;
          GNF         := TR06VO(ListaR06.Items[i]).GNF;
          GRG         := TR06VO(ListaR06.Items[i]).GRG;
          CDC         := TR06VO(ListaR06.Items[i]).CDC;
          DENOM       := TR06VO(ListaR06.Items[i]).Denominacao;
          DT_FIN      := TextoParaData(TR06VO(ListaR06.Items[i]).DataEmissao);
          HR_FIN      := StrToDateTime(TR06VO(ListaR06.Items[i]).HoraEmissao);

          // Registro R07 - MEIOS DE PAGAMENTO
          ListaR07 := TRegistroRController.TabelaR07IdR06(TR06VO(ListaR06.Items[i]).Id);
          if Assigned(ListaR07) then
          begin
            for j := 0 to ListaR07.Count - 1 do
            begin
              with RegistroR07.New do
              begin
                if (MD5String(TripaR07) <> TR07VO(ListaR07.Items[j]).HashTripa) then
                  RegistroValido := False;

                 CCF         := TR07VO(ListaR07.Items[j]).CCF;
                 GNF         := TR07VO(ListaR07.Items[j]).Gnf;
                 MP          := TR07VO(ListaR07.Items[j]).MeioPagamento;
                 VL_PAGTO    := TR07VO(ListaR07.Items[j]).ValorPagamento;
                 IND_EST     := TR07VO(ListaR07.Items[j]).IndicadorEstorno;
                 VL_EST      := TR07VO(ListaR07.Items[j]).ValorEstorno;
              end;//with RegistroR07.New do
            end;//for j := 0 to ListaR07.Count - 1 do
          end;//if Assigned(ListaR07) then
        end;//with FDataModule.ACBrPAF.PAF_R.RegistroR06.New do
      end;//for i := 0 to ListaR06.Count - 1 do
    end;//if Assigned(ListaR06) then

    NomeArquivo := Impressora.Codigo;

    if length(Impressora.Serie) > 14 then
      NomeArquivo := NomeArquivo + RightStr(Impressora.Serie, 14)
    else
      NomeArquivo := NomeArquivo + StringOfChar('0',14-length(Impressora.Serie)) + Impressora.Serie;

    NomeArquivo := NomeArquivo + FormatDateTime('ddmmyyyy',StrToDateTime(DataMovimento));
    NomeArquivo := NomeArquivo + '.txt';

    FDataModule.ACBrPAF.SaveFileTXT_R(NomeArquivo);
    TEAD_Class.SingEAD(NomeArquivo);

    Mensagem := 'Arquivo armazenado em: ' + gsAppPath + NomeArquivo;
    Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);

  finally
    if Assigned(Empresa) then
      FreeAndNil(Empresa);
    if Assigned(R01) then
      FreeAndNil(R01);
    if Assigned(ListaR02) then
      FreeAndNil(ListaR02);
    if Assigned(ListaR03) then
      FreeAndNil(ListaR03);
    if Assigned(ListaR04) then
      FreeAndNil(ListaR04);
    if Assigned(ListaR05) then
      FreeAndNil(ListaR05);
    if Assigned(ListaR06) then
      FreeAndNil(ListaR06);
    if Assigned(ListaR07) then
      FreeAndNil(ListaR07);
  end;
end;

procedure MeiosPagamento(DataIni: String; DataFim: String);
var
  ListaMeiosPagamento: TObjectList<TMeiosPagamentoVO>;
  i: Integer;
  Meio, TipoDoc, Valor, Data, DataAnterior: String;
begin
  if Application.MessageBox('Deseja imprimir o relatório MEIOS DE PAGAMENTOS?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
  begin
   try
    ListaMeiosPagamento := TTotalTipoPagamentoController.MeiosPagamento(DataIni, DataFim, UCaixa.Movimento.IdImpressora);

    FDataModule.ACBrECF.AbreRelatorioGerencial(UCaixa.Configuracao.MeiosDePagamento);
    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    FDataModule.ACBrECF.LinhaRelatorioGerencial('MEIOS DE PAGAMENTO');
    FDataModule.ACBrECF.LinhaRelatorioGerencial('PERIODO: ' + DataIni + ' A ' + DataFim);
    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    FDataModule.ACBrECF.LinhaRelatorioGerencial('DT.ACUMUL. MEIO DE PGTO.   TIPO DOC. VLR.ACUMUL.');
    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    for i := 0 to ListaMeiosPagamento.Count - 1 do
    begin
      Data := TMeiosPagamentoVO(ListaMeiosPagamento.Items[I]).DataHora;
      if Data <> DataAnterior then
        FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('-',48));
      Meio := TMeiosPagamentoVO(ListaMeiosPagamento.Items[I]).Descricao;
      Meio := ' ' +Meio + StringOfChar(' ', 15 - Length(Meio));
      if TMeiosPagamentoVO(ListaMeiosPagamento.Items[I]).Descricao <> 'SUPRIMENTO' then
        TipoDoc := ' FISCAL  '
      else
        TipoDoc := ' NAO FISC';
      Valor := FloatToStrF(TMeiosPagamentoVO(ListaMeiosPagamento.Items[I]).Total,ffNumber,13,2);
      Valor := StringOfChar(' ', 13 - Length(Valor)) + Valor;
      FDataModule.ACBrECF.LinhaRelatorioGerencial(Data+Meio+TipoDoc+Valor);
      DataAnterior := Data;
    end;
    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    FDataModule.ACBrECF.LinhaRelatorioGerencial('TOTAIS ACUMULADOS NO PERIODO:');
    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));

    ListaMeiosPagamento := TTotalTipoPagamentoController.MeiosPagamentoTotal(DataIni, DataFim, UCaixa.Movimento.IdImpressora);

    for i := 0 to ListaMeiosPagamento.Count - 1 do
    begin
      Meio := TMeiosPagamentoVO(ListaMeiosPagamento.Items[I]).Descricao;
      Meio := Meio + StringOfChar(' ', 18 - Length(Meio));
      Valor := FloatToStrF(TMeiosPagamentoVO(ListaMeiosPagamento.Items[I]).Total,ffNumber,15,2);
      Valor := StringOfChar(' ', 30 - Length(Valor)) + Valor;
      FDataModule.ACBrECF.LinhaRelatorioGerencial(Meio+Valor);
    end;

    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    FDataModule.ACBrECF.FechaRelatorio;
    GravaR06('RG');
   finally
     if Assigned(ListaMeiosPagamento) then
     FreeAndNil(ListaMeiosPagamento);
   end;
  end;
end;

procedure ParametrodeConfiguracao;
var
	ini:TIniFile;
begin
  try
    try
      ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');

      FDataModule.ACBrECF.AbreRelatorioGerencial(UCaixa.Configuracao.ParametrosDeConfiguracao);
      FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('***********PARAMETROS DE CONFIGURACAO***********');
      FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('<n>CONFIGURAÇÃO:</n>');
      FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));

      FDataModule.ACBrECF.LinhaRelatorioGerencial('<s><n>Funcionalidades:</n></s>');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('TIPO DE FUNCIONAMENTO: ......... ' + (Codifica('D',trim(ini.ReadString('FUNCIONALIDADES','FUN1','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('TIPO DE DESENVOLVIMENTO: ....... ' + (Codifica('D',trim(ini.ReadString('FUNCIONALIDADES','FUN2','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('INTEGRACAO DO PAF-ECF: ......... ' + (Codifica('D',trim(ini.ReadString('FUNCIONALIDADES','FUN3','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));

      FDataModule.ACBrECF.LinhaRelatorioGerencial('<s><n>Parâmetros Para Não Concomitância:</n></s>');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('PRÉ-VENDA: ................................. ' + (Codifica('D',trim(ini.ReadString('PARAMETROSPARANAOCONCOMITANCIA','PAR1','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('DAV POR ECF: ............................... ' + (Codifica('D',trim(ini.ReadString('PARAMETROSPARANAOCONCOMITANCIA','PAR2','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('DAV IMPRESSORA NÃO FISCAL: ................. ' + (Codifica('D',trim(ini.ReadString('PARAMETROSPARANAOCONCOMITANCIA','PAR3','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('DAV-OS: .................................... ' + (Codifica('D',trim(ini.ReadString('PARAMETROSPARANAOCONCOMITANCIA','PAR4','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));

      FDataModule.ACBrECF.LinhaRelatorioGerencial('<s><n>Aplicações Especiais:</n></s>');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('TAB. ÍNDICE TÉCNICO DE PRODUÇÃO: ........... ' + (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL1','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('POSTO REVENDEDOR DE COMBUSTÍVEIS: .......... ' + (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL2','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('Bar, Restaurante e Similar - ECF-Restaurante:' + (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL3','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('Bar, Restaurante e Similar - ECF-Comum: .... ' + (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL4','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('FARMÁCIA DE MANIPULAÇÃO: ................... ' + (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL5','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('OFICINA DE CONSERTO: ....................... ' + (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL6','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('TRANSPORTE DE PASSAGEIROS: ................. ' + (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL7','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));

      FDataModule.ACBrECF.LinhaRelatorioGerencial('<s><n>Critérios por Unidade Federada:</n></s>');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('<n>REQUISITO XVIII - Tela Consulta de Preço:</n>');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('TOTALIZAÇÃO DOS VALORES DA LISTA: .......... ' + (Codifica('D',trim(ini.ReadString('CRITERIOSPORUNIDADEFEDERADA','CRI1','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('TRANSFORMAÇÃO DAS INFORMÇÕES EM PRÉ-VENDA: . ' + (Codifica('D',trim(ini.ReadString('CRITERIOSPORUNIDADEFEDERADA','CRI2','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial('TRANSFORMAÇÃO DAS INFORMÇÕES EM DAV: ....... ' + (Codifica('D',trim(ini.ReadString('CRITERIOSPORUNIDADEFEDERADA','CRI3','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));

      FDataModule.ACBrECF.LinhaRelatorioGerencial('<s><n>REQUISITO XXII - PAF-ECF Integrado ao ECF:</n></s>');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('NÃO COINCIDÊNCIA GT(ECF) x ARQUIVO CRIPTOGRAFADO');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('RECOMPOE VALOR DO GT ARQUIVO CRIPTOGRAFADO:  ' + (Codifica('D',trim(ini.ReadString('XXIIREQUISITO','XXII1','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));

      FDataModule.ACBrECF.LinhaRelatorioGerencial('<s><n>REQUISITO XXXVI - A - PAF-ECF Combustível:</n></s>');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('Impedir Registro de Venda com Valor Zero ou');
      FDataModule.ACBrECF.LinhaRelatorioGerencial('Negativo: .................................. ' + (Codifica('D',trim(ini.ReadString('XXXVIREQUISITO','XXXVI1','')))));
      FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));

      FDataModule.ACBrECF.FechaRelatorio;
    except
      Application.MessageBox('Não foi possível carregar dados do ArquivoAuxiliar.ini.', 'Informação do Sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    ini.Free;
  end;
end;

procedure IdentificacaoPafEcf;
var
	ini: TIniFile;
  R01: TR01VO;
  sQtd, sSerie, sMD5: String;
  iQtd, x: Integer;
begin
  iQtd := FDataModule.QuantidadeECF;
  try
    R01 := TRegistroRController.RegistroR01;

    FDataModule.ACBrECF.AbreRelatorioGerencial(UCaixa.Configuracao.IdentificacaoPaf);
    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    FDataModule.ACBrECF.LinhaRelatorioGerencial('************IDENTIFICACAO DO PAF-ECF************');
    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    FDataModule.ACBrECF.LinhaRelatorioGerencial('NUMERO DO LAUDO...: ' + R01.NumeroLaudoPaf);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('*****IDENTIFICACAO DA EMPRESA DESENVOLVEDORA****');
    FDataModule.ACBrECF.LinhaRelatorioGerencial('C.N.P.J. .........: ' + R01.CnpjSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('RAZAO SOCIAL......: ' + R01.RazaoSocialSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('ENDERECO..........: ' + R01.EnderecoSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('NUMERO............: ' + R01.NumeroSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('COMPLEMENTO.......: ' + R01.ComplementoSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('BAIRRO............: ' + R01.BairroSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('CIDADE............: ' + R01.CidadeSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('CEP...............: ' + R01.CepSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('UF................: ' + R01.UfSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('TELEFONE..........: ' + R01.TelefoneSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('CONTATO...........: ' + R01.ContatoSh);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('************IDENTIFICACAO DO PAF-ECF************');
    FDataModule.ACBrECF.LinhaRelatorioGerencial('NOME COMERCIAL....: ' + R01.NomePafEcf);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('VERSAO DO PAF-ECF.: ' + R01.VersaoPafEcf);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('**********PRINCIPAL ARQUIVO EXECUTAVEL**********');
    FDataModule.ACBrECF.LinhaRelatorioGerencial('NOME..............: ' + R01.PrincipalExecutavel);
    sMD5:= MD5File(ExtractFilePath(Application.ExeName)+R01.PrincipalExecutavel);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('MD5.: ' + sMD5);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('****************DEMAIS ARQUIVOS*****************');
    FDataModule.ACBrECF.LinhaRelatorioGerencial('NOME..............: ' + 'Balcao.exe');
    sMD5:= MD5File(ExtractFilePath(Application.ExeName)+'Balcao.exe');
    FDataModule.ACBrECF.LinhaRelatorioGerencial('MD5.: ' + sMD5);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('**************NOME DO ARQUIVO TEXTO*************');
    FDataModule.ACBrECF.LinhaRelatorioGerencial('NOME..............: ' + 'ArquivoMD5.txt');

    try
      ini  := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
      sMD5 :=  Codifica('D',ini.ReadString('MD5','ARQUIVOS',''));
    finally
      ini.Free;
    end;

    FDataModule.ACBrECF.LinhaRelatorioGerencial('MD5.: ' + sMD5);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('VERSAO ER PAF-ECF.: ' + R01.VersaoEr);
    FDataModule.ACBrECF.LinhaRelatorioGerencial('**********RELACAO DOS ECF AUTORIZADOS***********');
    try
      ini  := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
      for x := 1 to iQtd do
      begin
        sSerie := ini.ReadString('ECF','SERIE'+IntToStr(x),'');
        FDataModule.ACBrECF.LinhaRelatorioGerencial(Codifica('D',sSerie));
      end;
    finally
      ini.Free;
    end;
    FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    FDataModule.ACBrECF.FechaRelatorio;
    GravaR06('RG');
  finally
    if Assigned(R01) then
      FreeAndNil(R01);
  end;
end;

procedure Grava60M60A(IdImpressora : Integer);
var
  i: Integer;
  Sintegra60M: TSintegra60MVO;
  Sintegra60A: TSintegra60AVO;
  Lista60A: TObjectList<TSintegra60AVO>;
  Impressora: TImpressoraVO;
begin
  try
    Impressora := TImpressoraController.PegaImpressora(IdImpressora);

    Sintegra60M := TSintegra60MVO.Create;
    Lista60A := TObjectList<TSintegra60AVO>.Create;
    Sintegra60M.DataEmissao := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
    Sintegra60M.SerieImpressora := FDataModule.ACBrECF.NumSerie;
    Sintegra60M.NumeroEquipamento := StrToInt(FDataModule.ACBrECF.NumECF);
    Sintegra60M.ModeloDocumentoFiscal := Impressora.ModeloDocumentoFiscal;
    Sintegra60M.COOInicial := StrToInt(FDataModule.ACBrECF.NumCOOInicial);
    Sintegra60M.COOFinal := StrToInt(FDataModule.ACBrECF.NumCOO) + 1;
    Sintegra60M.CRZ := StrToInt(FDataModule.ACBrECF.NumCRZ) + 1;
    Sintegra60M.CRO := StrToInt(FDataModule.ACBrECF.NumCRO);
    Sintegra60M.VendaBruta  := FDataModule.ACBrECF.VendaBruta;
    Sintegra60M.GrandeTotal := FDataModule.ACBrECF.GrandeTotal;

    TSintegraController.Grava60M(Sintegra60M);

    //Dados para o registro R03
    with FDataModule.ACBrECF.DadosReducaoZClass do
    begin
      //Dados ICMS
      for i := 0 to ICMS.Count -1 do
      begin
        Sintegra60A := TSintegra60AVO.Create;
        Sintegra60A.Id60M := Sintegra60M.Id;
        Sintegra60A.SituacaoTributaria := StringReplace(FloatToStr(ICMS[i].Aliquota), ',', '', [rfReplaceAll]);
        Sintegra60A.Valor := ICMS[i].Total;
        Lista60A.Add(Sintegra60A);
      end;

      //Dados ISSQN
      for i := 0 to ISSQN.Count -1 do
      begin
        Sintegra60A := TSintegra60AVO.Create;
        Sintegra60A.Id60M := Sintegra60M.Id;
        Sintegra60A.SituacaoTributaria := StringReplace(FloatToStr(ISSQN[i].Aliquota), ',', '', [rfReplaceAll]);
        Sintegra60A.Valor := ISSQN[i].Total;
        Lista60A.Add(Sintegra60A);
      end;

      //Substituição Tributária - ICMS
      Sintegra60A := TSintegra60AVO.Create;
      Sintegra60A.Id60M := Sintegra60M.Id;
      Sintegra60A.SituacaoTributaria := 'F';
      Sintegra60A.Valor := SubstituicaoTributariaICMS;
      Lista60A.Add(Sintegra60A);

      //Isento - ICMS
      Sintegra60A := TSintegra60AVO.Create;
      Sintegra60A.Id60M := Sintegra60M.Id;
      Sintegra60A.SituacaoTributaria := 'I';
      Sintegra60A.Valor := IsentoICMS;
      Lista60A.Add(Sintegra60A);

      //Não-incidência - ICMS
      Sintegra60A := TSintegra60AVO.Create;
      Sintegra60A.Id60M := Sintegra60M.Id;
      Sintegra60A.SituacaoTributaria := 'N';
      Sintegra60A.Valor := NaoTributadoICMS;
      Lista60A.Add(Sintegra60A);

      //Desconto - ICMS
      Sintegra60A := TSintegra60AVO.Create;
      Sintegra60A.Id60M := Sintegra60M.Id;
      Sintegra60A.SituacaoTributaria := 'DESC';
      Sintegra60A.Valor := DescontoICMS;
      Lista60A.Add(Sintegra60A);

      //Cancelamento - ICMS
      Sintegra60A := TSintegra60AVO.Create;
      Sintegra60A.Id60M := Sintegra60M.Id;
      Sintegra60A.SituacaoTributaria := 'CANC';
      Sintegra60A.Valor := CancelamentoICMS;
      Lista60A.Add(Sintegra60A);
    end;
    TSintegraController.Grava60A(Lista60A);
  finally
    if Assigned(Sintegra60M) then
      FreeAndNil(Sintegra60M);
    if Assigned(Lista60A) then
      FreeAndNil(Lista60A);
    if Assigned(Impressora) then
      FreeAndNil(Impressora);
  end;
end;

function ECFAutorizado: Boolean;
var
  MD5Serie, Serie: String;
	ini: TIniFile;
  I, Quantidade: Integer;
  ConsultaSQL: String;
  Query: TSQLQuery;
  nID: Integer;
begin
  if not FileExists(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini') then
    Result := False
  else
  begin
    try
      Result := False;
      ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
      Quantidade := FDataModule.QuantidadeECF;
      if ini.ValueExists('ECF','SERIE1') then
      begin
        MD5Serie:= FDataModule.ACBrECF.NumSerie;
        if Quantidade > 0 then
        begin
          for I := 1 to Quantidade do
          begin
            Serie:= 'SERIE'+IntToStr(I);
            if Codifica('D',ini.ReadString('ECF',pchar(Serie),'')) = MD5Serie then
            begin
              Result := True;
              Break;
            end;
          end;
        end;
      end
      else
      begin
        try
          ConsultaSQL := 'select max(ID) as ID from R02';
          Query := TSQLQuery.Create(nil);
          Query.SQLConnection := FDataModule.Conexao;
          Query.sql.Text := ConsultaSQL;
          Query.Open;
          nID := Query.FieldByName('ID').AsInteger;

          ConsultaSQL := 'select CRZ, CRO, GRANDE_TOTAL from R02 where ID ='+IntToStr(nID);
          Query.Close;
          Query.sql.Text := ConsultaSQL;
          Query.Open;

          if (Query.FieldByName('CRZ').AsInteger = StrtoInt(FDataModule.ACBrECF.NumCRZ)) and
             (Query.FieldByName('CRO').AsInteger = StrtoInt(FDataModule.ACBrECF.NumCRO)) and
             (Query.FieldByName('GRANDE_TOTAL').AsFloat = FDataModule.ACBrECF.GrandeTotal) then
          begin
            ini.WriteString('ECF','SERIE1',Codifica('C',FDataModule.ACBrECF.NumSerie));
            Result := True;
          end
          else
            Result := False;
        finally
          FreeAndNil(Query);
        end;
      end;//if ini.ValueExists('ECF','SERIE1') then
    finally
      ini.Free;
    end;
  end;//if not FileExists(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini') then
end;

function ConfereGT: Boolean;
var
	ini: TIniFile;
  ConsultaSQL, sGT: String;
  Query: TSQLQuery;
  nID, nCRO: Integer;
begin
  if not FileExists(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini') then
    Result := False
  else
  begin
    try
      ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
      sGT := Codifica('D',ini.ReadString('ECF','GT',''));
      if sGT = FloatToStr(FDataModule.ACBrECF.GrandeTotal) then
        Result := True
      else
      begin
        if ini.ValueExists('ECF','GT') then
        begin
          Result := False;
          sGT := Codifica('D',ini.ReadString('XXIIREQUISITO','XXII2',''));
          if (sGT = 'SIM') then
          begin
            ConsultaSQL := 'select max(CRO) as CRO from R02';
            try
              Query := TSQLQuery.Create(nil);
              Query.SQLConnection := FDataModule.Conexao;
              Query.sql.Text := ConsultaSQL;
              Query.Open();
              nCRO := Query.FieldByName('CRO').AsInteger;
              if (StrToInt(FDataModule.ACBrECF.NumCRO) > nCRO) then
              begin
                ini.WriteString('ECF','GT',Codifica('C',FloatToStr(FDataModule.ACBrECF.GrandeTotal)));
                Result := True;
              end;
            finally
              FreeAndNil(Query);
            end;
          end;//if (sGT = 'SIM') then
        end
        else
        begin
          try
            ConsultaSQL := 'select max(ID) as ID from R02';
            Query := TSQLQuery.Create(nil);
            Query.SQLConnection := FDataModule.Conexao;
            Query.sql.Text := ConsultaSQL;
            Query.Open;
            nID := Query.FieldByName('ID').AsInteger;

            ConsultaSQL := 'select CRZ, CRO, GRANDE_TOTAL from R02 where ID ='+IntToStr(nID);
            Query.Close;
            Query.sql.Text := ConsultaSQL;
            Query.Open;

            if (Query.FieldByName('CRZ').AsInteger = StrtoInt(FDataModule.ACBrECF.NumCRZ)) and
               (Query.FieldByName('CRO').AsInteger = StrtoInt(FDataModule.ACBrECF.NumCRO)) and
               (Query.FieldByName('GRANDE_TOTAL').AsFloat = FDataModule.ACBrECF.GrandeTotal) then
            begin
              ini.WriteString('ECF','GT',Codifica('C',FloatToStr(FDataModule.ACBrECF.GrandeTotal)));
              Result := True;
            end
            else
              Result := False;
          finally
            FreeAndNil(Query);
          end;
        end;//if ini.ValueExists('ECF','GT') then
      end;//if sGT = FloatToStr(FDataModule.ACBrECF.GrandeTotal) then
    finally
      ini.Free;
    end;
  end;//if not FileExists(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini') then
end;

procedure AtualizaGT;
var
	ini:TIniFile;
begin
  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
    ini.WriteString('ECF','GT',Codifica('C',FloatToStr(FDataModule.ACBrECF.GrandeTotal)));
  finally
    ini.Free;
  end;
end;

function GeraMD5: String;
var
  R01: TR01VO;
  NomeArquivo, Mensagem, MD5ArquivoMD5 : String;
  Ini:TIniFile;
begin
  PreencherHeader(FDataModule.ACBrPAF.PAF_N.RegistroN1); // preencher header do arquivo
  // registro N2
  try
    R01 := TRegistroRController.RegistroR01;

    FDataModule.ACBrPAF.PAF_N.RegistroN2.LAUDO  := R01.NumeroLaudoPaf;
    FDataModule.ACBrPAF.PAF_N.RegistroN2.NOME   := R01.NomePafEcf;
    FDataModule.ACBrPAF.PAF_N.RegistroN2.VERSAO := R01.VersaoPafEcf;

    FDataModule.ACBrPAF.PAF_N.RegistroN3.Clear;

    NomeArquivo := ExtractFilePath(Application.ExeName)+'PafEcf.exe';
    with FDataModule.ACBrPAF.PAF_N.RegistroN3.New do
    begin
      NOME_ARQUIVO := R01.PrincipalExecutavel;
      MD5          := MD5File(NomeArquivo);
    end;

    NomeArquivo := ExtractFilePath(Application.ExeName)+'Balcao.exe';
    with FDataModule.ACBrPAF.PAF_N.RegistroN3.New do
    begin
      NOME_ARQUIVO := 'Balcao.exe';
      MD5          := MD5File(NomeArquivo);
    end;

    FDataModule.ACBrPAF.SaveFileTXT_N('ArquivoMD5.txt');
    TEAD_Class.SingEAD('ArquivoMD5.txt');

    MD5ArquivoMD5 := MD5File(ExtractFilePath(Application.ExeName)+'ArquivoMD5.txt');

    try
      ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
      ini.WriteString('MD5','ARQUIVOS',Codifica('C',MD5ArquivoMD5));
    finally
      ini.Free;
    end;

    Mensagem := 'Arquivo armazenado em: ' + gsAppPath + 'ArquivoMD5.txt';
    Application.MessageBox(PWideChar(Mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  finally
    if Assigned(R01) then
      FreeAndNil(R01);
  end;
  Result := MD5ArquivoMD5;
end;

procedure GravaR06(Simbolo : String);
var
  R06: TR06VO;
begin
  try
    R06 := TR06VO.Create;
    R06.IdCaixa := UCaixa.Movimento.IdCaixa;
    R06.IdOperador := UCaixa.Movimento.IdOperador;
    R06.IdImpressora := UCaixa.Movimento.IdImpressora;
    R06.COO := StrToInt(FDataModule.ACBrECF.NumCOO);
    R06.GNF := StrToInt(FDataModule.ACBrECF.NumGNF);
    R06.GRG := StrToInt(FDataModule.ACBrECF.NumGRG);

    if FDataModule.ACBrECF.MFD then
      R06.CDC := StrToInt(FDataModule.ACBrECF.NumCDC)
    else
      R06.CDC := 0;

    R06.Denominacao := Simbolo; // Gilson;
    {       Relação do Símbolos Possíveis
      Documento                        Símbolo
      ========================================
      Conferência de Mesa                 - CM
      Registro de Venda                   - RV
      Comprovante de Crédito ou Débito    - CC
      Comprovante Não-Fiscal              - CN
      Comprovante Não-Fiscal Cancelamento - NC
      Relatório Gerencial                 - RG }
    R06.DataEmissao := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
    R06.HoraEmissao := FormatDateTime('hh:nn:ss', FDataModule.ACBrECF.DataHora);
    TRegistroRController.GravaR06(R06);
  finally
    FreeAndNil(R06);
  end;
end;
end.
