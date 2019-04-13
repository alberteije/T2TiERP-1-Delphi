{ *******************************************************************************
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

  @author Albert Eije (T2Ti.COM)
  @version 1.0
  ******************************************************************************* }

unit UPAF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Dbtables, Inifiles, PreVendaDetalheVO, Generics.Collections, Biblioteca,
  PreVendaController, ProdutoController, UCaixa, ACBrPAF, ACBrPAF_D, ACBrPAF_E,
  ACBrPAF_P, ACBrPAF_R, ACBrPAF_T, ACBrPAFRegistros, Math, SWSystem, ImpressoraVO;

procedure PreencherHeader(Header: TRegistroX1);
procedure GeraTabelaProdutos;
procedure GeraArquivoEstoque;
procedure GeraMovimentoECF(DataInicio:String; DataFim:String; Impressora: TImpressoraVO);
procedure GravaR02R03;
procedure Grava60M60A;
procedure MeiosPagamento(DataIni:String; DataFim:String);
procedure IdentificacaoPafEcf;
function GeraMD5: String;
function ECFAutorizado: Boolean;
function ConfereGT: Boolean;
procedure AtualizaGT;

implementation

uses
R02VO, R03VO, R04VO, R05VO, R06VO, R07VO, RegistroRController, EmpresaController,
EmpresaVO, UDataModule, ProdutoVO, ImpressoraController, TotalTipoPagamentoController,
MeiosPagamentoVO, SintegraController, Sintegra60MVO, Sintegra60AVO, EAD_Class, R01VO,
  strutils;

procedure PreencherHeader(Header: TRegistroX1);
var
  Empresa : TEmpresaVO;
begin
  Empresa := TEmpresaController.PegaEmpresa(UCaixa.Configuracao.IdEmpresa);
  Header.UF          := Empresa.UF;
  Header.CNPJ        := Empresa.CNPJ;
  Header.IE          := Empresa.InscricaoEstadual;
  Header.IM          := Empresa.InscricaoMunicipal;
  Header.RAZAOSOCIAL := Empresa.RazaoSocial;
end;

procedure GeraTabelaProdutos;
var
  P2: TRegistroP2;
  i: integer;
  ListaProduto: TObjectList<TProdutoVO>;
  mensagem, Tripa: String;
begin
  ListaProduto := TProdutoController.TabelaProduto;
  if Assigned(ListaProduto) then
  begin
    // registro P1
    PreencherHeader(FDataModule.ACBrPAF.PAF_P.RegistroP1); // preencher header do arquivo
    // registro P2
    FDataModule.ACBrPAF.PAF_P.RegistroP2.Clear;
    for i := 0 to ListaProduto.Count - 1 do
    begin
      Tripa :=  TProdutoVO(ListaProduto.Items[i]).GTIN +
                TProdutoVO(ListaProduto.Items[i]).Descricao +
                TProdutoVO(ListaProduto.Items[i]).DescricaoPDV +
                FormataFloat('Q',TProdutoVO(ListaProduto.Items[i]).QtdeEstoque) +
                TProdutoVO(ListaProduto.Items[i]).DataEstoque +
                TProdutoVO(ListaProduto.Items[i]).SituacaoTributaria +
                FormataFloat('V',TProdutoVO(ListaProduto.Items[i]).AliquotaICMS) +
                FormataFloat('V',TProdutoVO(ListaProduto.Items[i]).ValorVenda);

      P2                := FDataModule.ACBrPAF.PAF_P.RegistroP2.New;
      P2.COD_MERC_SERV  := TProdutoVO(ListaProduto.Items[i]).GTIN;
      P2.DESC_MERC_SERV := TProdutoVO(ListaProduto.Items[i]).DescricaoPDV;

      if MD5String(Tripa) <> TProdutoVO(ListaProduto.Items[i]).Hash then
        P2.UN_MED   := StringOfChar('?',6)
      else
        P2.UN_MED    := TProdutoVO(ListaProduto.Items[i]).UnidadeProduto;

      P2.IAT            := TProdutoVO(ListaProduto.Items[i]).IAT;
      P2.IPPT           := TProdutoVO(ListaProduto.Items[i]).IPPT;
      P2.ST             := TProdutoVO(ListaProduto.Items[i]).SituacaoTributaria;
      P2.ALIQ           := TProdutoVO(ListaProduto.Items[i]).AliquotaICMS;
      P2.VL_UNIT        := TProdutoVO(ListaProduto.Items[i]).ValorVenda;
    end;
    FDataModule.ACBrPAF.SaveFileTXT_P('PAF_P.txt');
    TEAD_Class.SingEAD('PAF_P.txt');

    mensagem := 'Arquivo armazenado em: ' + gsAppPath + 'PAF_P.txt';
    Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Não existem produtos na tabela.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure GeraArquivoEstoque;
var
  E2: TRegistroE2;
  i: integer;
  ListaProduto: TObjectList<TProdutoVO>;
  mensagem, Tripa: String;
begin
  ListaProduto := TProdutoController.TabelaProduto;
  if Assigned(ListaProduto) then
  begin
    // registro E1
    PreencherHeader(FDataModule.ACBrPAF.PAF_E.RegistroE1); // preencher header do arquivo
    // registro E2
    FDataModule.ACBrPAF.PAF_E.RegistroE2.Clear;
    for i := 0 to ListaProduto.Count - 1 do
    begin
      Tripa :=  TProdutoVO(ListaProduto.Items[i]).GTIN +
                TProdutoVO(ListaProduto.Items[i]).Descricao +
                TProdutoVO(ListaProduto.Items[i]).DescricaoPDV +
                FormataFloat('Q',TProdutoVO(ListaProduto.Items[i]).QtdeEstoque) +
                TProdutoVO(ListaProduto.Items[i]).DataEstoque +
                TProdutoVO(ListaProduto.Items[i]).SituacaoTributaria +
                FormataFloat('V',TProdutoVO(ListaProduto.Items[i]).AliquotaICMS) +
                FormataFloat('V',TProdutoVO(ListaProduto.Items[i]).ValorVenda);

      E2           := FDataModule.ACBrPAF.PAF_E.RegistroE2.New;
      E2.COD_MERC  := TProdutoVO(ListaProduto.Items[i]).GTIN;
      E2.DESC_MERC := TProdutoVO(ListaProduto.Items[i]).DescricaoPDV;

      if MD5String(Tripa) <> TProdutoVO(ListaProduto.Items[i]).Hash then
        E2.UN_MED   := StringOfChar('?',6)
      else
        E2.UN_MED    := TProdutoVO(ListaProduto.Items[i]).UnidadeProduto;

      E2.QTDE_EST  := TProdutoVO(ListaProduto.Items[i]).QtdeEstoque;
      E2.DT_EST    := StrToDateTime(TProdutoVO(ListaProduto.Items[i]).DataEstoque);
    end;
    FDataModule.ACBrPAF.SaveFileTXT_E('PAF_E.txt');
    TEAD_Class.SingEAD('PAF_E.txt');

    mensagem := 'Arquivo armazenado em: ' + gsAppPath + 'PAF_E.txt';
    Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end
  else
    Application.MessageBox('Não existem produtos na tabela.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure GravaR02R03;
var
  R02: TR02VO;
  R03: TR03VO;
  ListaR03: TObjectList<TR03VO>;
  i: Integer;
  Indice, Aliquota: String;
begin
  ListaR03 := TObjectList<TR03VO>.Create;
  //Dados para o registro R02
  R02 := TR02VO.Create;
  R02.IdCaixa := UCaixa.Movimento.IdCaixa;
  R02.IdOperador := UCaixa.Movimento.IdOperador;
  R02.IdImpressora := UCaixa.Movimento.IdImpressora;

  FDataModule.ACBrECF.DadosReducaoZ;
  with FDataModule.ACBrECF.DadosReducaoZClass do
  begin
    R02.CRZ := CRZ + 1; //Incrementa 1 = ta pegando o CRZ antes da emissão
    R02.COO := COO + 1; //Incrementa 1 = ta pegando o COO antes da emissão
    R02.CRO := CRO;
    R02.DataMovimento := FormatDateTime('yyyy-mm-dd', DataDoMovimento);
    R02.DataEmissao := FormatDateTime('yyyy-mm-dd', Date);
    R02.HoraEmissao := TimeToStr(Time);
    R02.VendaBruta := ValorVendaBruta;
    R02.GrandeTotal := ValorGrandeTotal;
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
end;

procedure GeraMovimentoECF(DataInicio:String; DataFim:String; Impressora: TImpressoraVO);
var
  i,j: integer;
  Empresa : TEmpresaVO;
  R01: TR01VO;
  ListaR02: TObjectList<TR02VO>;
  ListaR03: TObjectList<TR03VO>;
  ListaR04: TObjectList<TR04VO>;
  ListaR05: TObjectList<TR05VO>;
  ListaR06: TObjectList<TR06VO>;
  ListaR07: TObjectList<TR07VO>;
  mensagem, NomeArquivo, SerieECF, CNPJUsuario, CNPJSH, NomePAF,
  MD5PrincipalEXE, TripaR02, TripaR03, TripaR04, TripaR05, TripaR06: String;
	ini:TIniFile;
begin
  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
    SerieECF := ini.ReadString('ECF','SERIE','');
    CNPJUsuario := ini.ReadString('ESTABELECIMENTO','CNPJ','');
    CNPJSH := ini.ReadString('SHOUSE','CNPJ','');
    NomePAF := ini.ReadString('SHOUSE','NOME_PAF','');
    MD5PrincipalEXE := ini.ReadString('SHOUSE','MD5PrincipalEXE','');
  finally
    ini.Free;
  end;

  //dados da empresa
  Empresa := TEmpresaController.PegaEmpresa(UCaixa.Configuracao.IdEmpresa);
  //dados software house e demais do R01
  R01 := TRegistroRController.RegistroR01;
  // Registro R1 - Identificação do ECF, do Usuário, do PAF-ECF e da Empresa Desenvolvedora e Dados do Arquivo
  with FDataModule.ACBrPAF.PAF_R.RegistroR01 do
  begin
    NUM_FAB      := Impressora.Serie;
    MF_ADICIONAL := Impressora.MFD;
    TIPO_ECF     := Impressora.Tipo;
    MARCA_ECF    := Impressora.Marca;

    if (SerieECF <> MD5String(Impressora.Serie)) or
       (CNPJUsuario <> MD5String(Empresa.CNPJ)) or
       (CNPJSH <> MD5String(R01.CnpjSh)) or
       (NomePAF <> MD5String(R01.NomePafEcf)) or
       (MD5PrincipalEXE <> MD5String(R01.Md5PafEcf))
     then
       RegistroValido := False;

    MODELO_ECF   := Impressora.Modelo;
    VERSAO_SB    := FDataModule.ACBrECF.NumVersao;
    DT_INST_SB   := FDataModule.ACBrECF.DataHoraSB;
    HR_INST_SB   := FDataModule.ACBrECF.DataHoraSB;
    NUM_SEQ_ECF  := Impressora.Id;
    CNPJ         := Empresa.CNPJ;
    IE           := Empresa.InscricaoEstadual;
    CNPJ_SH      := R01.CnpjSh;
    IE_SH        := R01.InscricaoEstadualSh;
    IM_SH        := R01.InscricaoMunicipalSh;
    NOME_SH      := R01.DenominacaoSh;
    NOME_PAF     := R01.NomePafEcf;
    VER_PAF      := R01.VersaoPafEcf;
    COD_MD5      := R01.Md5PafEcf;
    DT_INI       := StrToDateTime(R01.DataInicial);
    DT_FIN       := StrToDateTime(R01.DataFinal);
    ER_PAF_ECF   := R01.VersaoEr;
  end;
  // Registro R02 e R03
  ListaR02 := TRegistroRController.TabelaR02(DataInicio, DataFim, Impressora.Id);
  if Assigned(ListaR02) then
  begin
    for i := 0 to ListaR02.Count - 1 do
    begin

      TripaR02 :=  IntToStr(TR02VO(ListaR02.Items[i]).Id) +
                IntToStr(TR02VO(ListaR02.Items[i]).CRZ) +
                IntToStr(TR02VO(ListaR02.Items[i]).COO) +
                IntToStr(TR02VO(ListaR02.Items[i]).CRO) +
                TR02VO(ListaR02.Items[i]).DataMovimento +
                TR02VO(ListaR02.Items[i]).DataEmissao +
                TR02VO(ListaR02.Items[i]).HoraEmissao +
                FormataFloat('V',TR02VO(ListaR02.Items[i]).VendaBruta);

     with FDataModule.ACBrPAF.PAF_R.RegistroR02.New do
     begin
        if (MD5String(TripaR02) <> TR02VO(ListaR02.Items[i]).Hash) or
           (SerieECF <> MD5String(Impressora.Serie))
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
                      FormataFloat('V',TR03VO(ListaR03.Items[j]).ValorAcumulado);

            with RegistroR03.New do
            begin
              if (MD5String(TripaR02) <> TR02VO(ListaR02.Items[i]).Hash) or
                 (MD5String(TripaR03) <> TR03VO(ListaR03.Items[j]).Hash) or
                 (SerieECF <> MD5String(Impressora.Serie))
                 then
                  RegistroValido := False;

               TOT_PARCIAL := TR03VO(ListaR03.Items[j]).TotalizadorParcial;
               VL_ACUM     := TR03VO(ListaR03.Items[j]).ValorAcumulado;
            end;
          end;
        end;
     end;
    end;
  end;

  // Registro R04 e R05
  ListaR04 := TRegistroRController.TabelaR04(DataInicio, DataFim, Impressora.Id);
  if Assigned(ListaR04) then
  begin
    for i := 0 to ListaR04.Count - 1 do
    begin

      TripaR04 := IntToStr(TR04VO(ListaR04.Items[i]).Id) +
               IntToStr(TR04VO(ListaR04.Items[i]).CCF) +
               IntToStr(TR04VO(ListaR04.Items[i]).COO) +
               FormataFloat('V',TR04VO(ListaR04.Items[i]).ValorLiquido);
      if TR04VO(ListaR04.Items[i]).Cancelado = 'S' then
        TripaR04 := TripaR04 + 'C'
      else
        TripaR04 := TripaR04 + 'F';

      with FDataModule.ACBrPAF.PAF_R.RegistroR04.New do
      begin
        if (SerieECF <> MD5String(Impressora.Serie)) or
           (MD5String(TripaR04) <> TR04VO(ListaR04.Items[i]).Hash)
        then
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
        ListaR05 := TRegistroRController.TabelaR05(TR04VO(ListaR04.Items[i]).Id);
        if Assigned(ListaR05) then
        begin
          for j := 0 to ListaR05.Count - 1 do
          begin

            TripaR05 := TR05VO(ListaR05.Items[j]).GTIN +
                       FormataFloat('Q',TR05VO(ListaR05.Items[j]).Quantidade) +
                       FormataFloat('V',TR05VO(ListaR05.Items[j]).ValorUnitario) +
                       FormataFloat('V',TR05VO(ListaR05.Items[j]).TotalItem) +
                       TR05VO(ListaR05.Items[j]).TotalizadorParcial +
                       TR05VO(ListaR05.Items[j]).IndicadorCancelamento;

            with RegistroR05.New do
            begin

              if (MD5String(TripaR05) <> TR05VO(ListaR05.Items[j]).Hash) or
              (MD5String(TripaR04) <> TR04VO(ListaR04.Items[i]).Hash) or
              (SerieECF <> MD5String(Impressora.Serie))
                 then
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
            end;
          end;//fim do for do R05
        end;//fim do if do R05


        // Registro R07 - MEIOS DE PAGAMENTO
        ListaR07 := TRegistroRController.TabelaR07IdR04(TR04VO(ListaR04.Items[i]).Id);
        if Assigned(ListaR07) then
        begin
          for j := 0 to ListaR07.Count - 1 do
          begin
            with RegistroR07.New do
            begin

              if (SerieECF <> MD5String(Impressora.Serie)) or
              (MD5String(TripaR04) <> TR04VO(ListaR04.Items[i]).Hash)
              then
                RegistroValido := False;

               CCF         := TR07VO(ListaR07.Items[j]).CCF;
               MP          := TR07VO(ListaR07.Items[j]).MeioPagamento;
               VL_PAGTO    := TR07VO(ListaR07.Items[j]).ValorPagamento;
               IND_EST     := TR07VO(ListaR07.Items[j]).IndicadorEstorno;
               VL_EST      := TR07VO(ListaR07.Items[j]).ValorEstorno;
            end;
          end;//fim do for do R07
        end;//fim do if do R07

      end;
    end;//fim do for do R04
  end;//fim do if do R04

  // Registro R06 e R07
  ListaR06 := TRegistroRController.TabelaR06(DataInicio, DataFim, Impressora.Id);
  if Assigned(ListaR06) then
  begin
    for i := 0 to ListaR06.Count - 1 do
    begin

      TripaR06 := IntToStr(TR06VO(ListaR06.Items[i]).COO) +
               IntToStr(TR06VO(ListaR06.Items[i]).GNF) +
               IntToStr(TR06VO(ListaR06.Items[i]).CDC) +
               TR06VO(ListaR06.Items[i]).Denominacao +
               TR06VO(ListaR06.Items[i]).DataEmissao;

     with FDataModule.ACBrPAF.PAF_R.RegistroR06.New do
     begin
        if (SerieECF <> MD5String(Impressora.Serie)) or
        (MD5String(TripaR06) <> TR06VO(ListaR06.Items[i]).Hash)
        then
          RegistroValido := False;

        NUM_USU     := TR06VO(ListaR06.Items[i]).IdOperador;
        COO         := TR06VO(ListaR06.Items[i]).COO;
        GNF         := TR06VO(ListaR06.Items[i]).GNF;
        GRG         := TR06VO(ListaR06.Items[i]).GRG;
        CDC         := TR06VO(ListaR06.Items[i]).CDC;
        DENOM       := TR06VO(ListaR06.Items[i]).Denominacao;
        DT_FIN      := StrToDateTime(TR06VO(ListaR06.Items[i]).DataEmissao);
        HR_FIN      := StrToDateTime(TR06VO(ListaR06.Items[i]).HoraEmissao);
        // Registro R07 - MEIOS DE PAGAMENTO
        ListaR07 := TRegistroRController.TabelaR07IdR06(TR06VO(ListaR06.Items[i]).Id);
        if Assigned(ListaR07) then
        begin
          for j := 0 to ListaR07.Count - 1 do
          begin
            with RegistroR07.New do
            begin

              if (SerieECF <> MD5String(Impressora.Serie)) or
              (MD5String(TripaR06) <> TR06VO(ListaR06.Items[i]).Hash)
              then
                RegistroValido := False;

               CCF         := TR07VO(ListaR07.Items[j]).CCF;
               MP          := TR07VO(ListaR07.Items[j]).MeioPagamento;
               VL_PAGTO    := TR07VO(ListaR07.Items[j]).ValorPagamento;
               IND_EST     := TR07VO(ListaR07.Items[j]).IndicadorEstorno;
               VL_EST      := TR07VO(ListaR07.Items[j]).ValorEstorno;
            end;
          end;
        end;
     end;
    end;
  end;

  NomeArquivo := Impressora.Codigo;

  if length(Impressora.Serie) > 14 then
    NomeArquivo := NomeArquivo + RightStr(Impressora.Serie, 14)
  else
    NomeArquivo := NomeArquivo + StringOfChar('0',14-length(Impressora.Serie)) + Impressora.Serie;

  NomeArquivo := NomeArquivo + FormatDateTime('ddmmyyyy',Date);
  NomeArquivo := NomeArquivo + '.txt';

  FDataModule.ACBrPAF.SaveFileTXT_R(NomeArquivo);
  TEAD_Class.SingEAD(NomeArquivo);

  mensagem := 'Arquivo armazenado em: ' + gsAppPath + NomeArquivo;
  Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure MeiosPagamento(DataIni:String; DataFim:String);
var
  ListaMeiosPagamento: TObjectList<TMeiosPagamentoVO>;
  i:integer;
  Meio,TipoDoc,Valor,Data, DataAnterior:String;
begin
  if Application.MessageBox('Deseja imprimir o relatório MEIOS DE PAGAMENTOS?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
  begin
    ListaMeiosPagamento := TTotalTipoPagamentoController.MeiosPagamento(DataIni, DataFim, UCaixa.Movimento.IdImpressora);

    FDataModule.ACBrECF.AbreRelatorioGerencial();
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
  end;
end;

procedure IdentificacaoPafEcf;
var
  R01: TR01VO;
begin
  R01 := TRegistroRController.RegistroR01;

  FDataModule.ACBrECF.AbreRelatorioGerencial();
  FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
  FDataModule.ACBrECF.LinhaRelatorioGerencial('IDENTIFICACAO DO PAF-ECF');
  FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
  FDataModule.ACBrECF.LinhaRelatorioGerencial('NU. LAUDO.........: ' + R01.NumeroLaudoPaf);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('C.N.P.J. .........: ' + R01.CnpjSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('EMPRESA...........: ' + R01.RazaoSocialSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('ENDERECO..........: ' + R01.EnderecoSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('NUMERO............: ' + R01.NumeroSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('COMPLEMENTO.......: ' + R01.ComplementoSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('BAIRRO............: ' + R01.BairroSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('CIDADE............: ' + R01.CidadeSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('CEP...............: ' + R01.CepSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('UF................: ' + R01.UfSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('FONE..............: ' + R01.TelefoneSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('RESPONSAVEL.......: ' + R01.ContatoSh);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('NOME COMERCIAL....: ' + R01.NomePafEcf);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('VERSAO............: ' + R01.VersaoPafEcf);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('PRINCIPAL ARQUIVO.: ' + R01.PrincipalExecutavel);
  FDataModule.ACBrECF.LinhaRelatorioGerencial('MD5...............: ' + UCaixa.MD5);
  FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
  FDataModule.ACBrECF.FechaRelatorio;
  {
  Albert: é pra gente imprimir o caminho completo do arquivo ou apenas o nome do arquivo e o hash???
  c5) A relação dos arquivos a que se refere o requisito IX, com os respectivos códigos MD-5;

  É pra imprimir o número criptografado (como está no arquivo) ou descriptografado?
  d) Relação contendo número de fabricação dos ECF autorizados para funcionar com este PAF-ECF,
  cadastrados no arquivo auxiliar de que trata o item 4 do requisito XXII.
  }
end;

procedure Grava60M60A;
var
  i:integer;
  Sintegra60M: TSintegra60MVO;
  Sintegra60A: TSintegra60AVO;
  Lista60A: TObjectList<TSintegra60AVO>;
  Impressora: TImpressoraVO;
begin
  Impressora := TImpressoraController.PegaImpressora(UCaixa.Movimento.IdImpressora);

  Sintegra60M := TSintegra60MVO.Create;
  Lista60A := TObjectList<TSintegra60AVO>.Create;

  Sintegra60M.DataEmissao := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataMovimento);
  Sintegra60M.SerieImpressora := FDataModule.ACBrECF.NumSerie;
  Sintegra60M.NumeroEquipamento := StrToInt(FDataModule.ACBrECF.NumECF);
  Sintegra60M.ModeloDocumentoFiscal := Impressora.ModeloDocumentoFiscal;
  Sintegra60M.COOInicial := StrToInt(FDataModule.ACBrECF.NumCOOInicial);
  Sintegra60M.COOFinal := StrToInt(FDataModule.ACBrECF.NumCOO) + 1; //Incrementa 1 = ta pegando o COO antes da emissão
  Sintegra60M.CRZ := StrToInt(FDataModule.ACBrECF.NumCRZ) + 1; //Incrementa 1 = ta pegando o CRZ antes da emissão
  Sintegra60M.CRO := StrToInt(FDataModule.ACBrECF.NumCRO);
  Sintegra60M.VendaBruta := FDataModule.ACBrECF.VendaBruta;
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
end;

function GeraMD5: String;
var
  Arquivo: TextFile;
  NomeArquivo, ArquivoTexto, MD5Executaveis, MD5ArquivoMD5 : String;
  F: TSearchRec;
  Ret: Integer;
	ini:TIniFile;
begin
  Result := '';
  try
    // Apaga arquivo anterior
    ArquivoTexto := ExtractFilePath(Application.ExeName)+'ArquivoMD5.txt';
    if FileExists(ArquivoTexto) then
       DeleteFile(ArquivoTexto);

    // cria o arquivo TXT na mesma pasta do sistema
    AssignFile(Arquivo,ArquivoTexto);
    ReWrite(Arquivo);

    // lista todos os arquivo exe da pasta do aplicativo e gera o MD5
    Ret := FindFirst(ExtractFilePath(Application.ExeName)+'\*.exe', faAnyFile, F);
    try
      while Ret = 0 do
      begin
        if F.Attr and faDirectory <> faDirectory then
        begin
          NomeArquivo := ExtractFilePath(Application.ExeName)+F.Name;
          MD5Executaveis := MD5File(NomeArquivo);
          WriteLn(Arquivo,NomeArquivo+' - ' + MD5Executaveis);
        end;
        Ret := FindNext(F);
      end;
    finally
      FindClose(F);
    end;
    Closefile(Arquivo);

    MD5ArquivoMD5 := MD5File(ArquivoTexto);

  	ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
    ini.WriteString('MD5','ARQUIVOS',MD5ArquivoMD5);

  finally
    ini.Free;
    Result := MD5ArquivoMD5;
  end;
end;

function ECFAutorizado: Boolean;
var
  MD5Serie:String;
	ini:TIniFile;
begin
  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
    Result := False;
    MD5Serie := MD5String(FDataModule.ACBrECF.NumSerie);
    if ini.ReadString('ECF','SERIE','') = MD5Serie then
      Result := True;
  finally
    ini.Free;
  end;
end;

function ConfereGT: Boolean;
var
	ini:TIniFile;
begin
  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
    Result := False;
    if ini.ReadString('ECF','GT','') = MD5String(FloatToStr(FDataModule.ACBrECF.GrandeTotal)) then
      Result := True;
  finally
    ini.Free;
  end;
end;

procedure AtualizaGT;
var
	ini:TIniFile;
begin
  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
    ini.WriteString('ECF','GT',MD5String(FloatToStr(FDataModule.ACBrECF.GrandeTotal)));
  finally
    ini.Free;
  end;
end;

end.
