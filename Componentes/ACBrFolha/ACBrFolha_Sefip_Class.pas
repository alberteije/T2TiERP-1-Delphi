{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2012   Albert Eije                          }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 01/05/2013: Albert Eije
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}
unit ACBrFolha_Sefip_Class;

interface

uses
  SysUtils, Classes, DateUtils, ACBrTXTClass, ACBrFolha_Sefip, ACBrFolhaUtils;

type

  /// Folha_Sefip
  TFolha_Sefip = class(TACBrTXTClass)

  private
    FRegistroTipo00: TRegistroTipo00;     // REGISTRO TIPO 00 – Informações do Responsável (Cabeçalho do arquivo)
    FRegistroTipo10: TRegistroTipo10;     // REGISTRO TIPO 10 – Informações da Empresa (Cabeçalho da empresa )
    FRegistroTipo12: TRegistroTipo12List; // LISTA DE REGISTRO TIPO 12 – Informações Adicionais do Recolhimento da Empresa
    FRegistroTipo13: TRegistroTipo13List; // LISTA DE REGISTRO TIPO 13 – Alteração Cadastral Trabalhador
    FRegistroTipo14: TRegistroTipo14List; // LISTA DE REGISTRO TIPO 14 – Inclusão/Alteração Endereço do Trabalhador
    FRegistroTipo20: TRegistroTipo20List; // LISTA DE REGISTRO TIPO 20 – Registro do Tomador de Serviço/Obra de Construção Civil
    FRegistroTipo21: TRegistroTipo21List; // LISTA DE REGISTRO TIPO 21 - Registro de informações adicionais do Tomador de Serviço/Obra de Const. Civil
    FRegistroTipo30: TRegistroTipo30List; // LISTA DE REGISTRO TIPO 30 - Registro do Trabalhador
    FRegistroTipo32: TRegistroTipo32List; // LISTA DE REGISTRO TIPO 32 – Movimentação do Trabalhador
    FRegistroTipo50: TRegistroTipo50List; // LISTA DE REGISTRO TIPO 50 – Empresa Com Recolhimento pelos códigos 027, 046, 604 e 736 (Header da empresa )
    FRegistroTipo51: TRegistroTipo51List; // LISTA DE REGISTRO TIPO 51 - Registro de Individualização de valores recolhidos pelos códigos 027, 046, 604 e 736
    FRegistroTipo90: TRegistroTipo90;     // REGISTRO TIPO 90 – Registro Totalizador do Arquivo

    procedure CriaRegistros;
    procedure LiberaRegistros;
  protected
  public
    constructor Create;           /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    // funções para escrever os arquivos
    function WriteRegistroTipo00: String;
    function WriteRegistroTipo10: String;
    function WriteRegistroTipo12: String;
    function WriteRegistroTipo13: String;
    function WriteRegistroTipo14: String;
    function WriteRegistroTipo20: String;
    function WriteRegistroTipo21: String;
    function WriteRegistroTipo30: String;
    function WriteRegistroTipo32: String;
    function WriteRegistroTipo50: String;
    function WriteRegistroTipo51: String;
    function WriteRegistroTipo90: String;

    property RegistroTipo00: TRegistroTipo00     read FRegistroTipo00 write FRegistroTipo00;
    property RegistroTipo10: TRegistroTipo10     read FRegistroTipo10 write FRegistroTipo10;
    property RegistroTipo12: TRegistroTipo12List read FRegistroTipo12 write FRegistroTipo12;
    property RegistroTipo13: TRegistroTipo13List read FRegistroTipo13 write FRegistroTipo13;
    property RegistroTipo14: TRegistroTipo14List read FRegistroTipo14 write FRegistroTipo14;
    property RegistroTipo20: TRegistroTipo20List read FRegistroTipo20 write FRegistroTipo20;
    property RegistroTipo21: TRegistroTipo21List read FRegistroTipo21 write FRegistroTipo21;
    property RegistroTipo30: TRegistroTipo30List read FRegistroTipo30 write FRegistroTipo30;
    property RegistroTipo32: TRegistroTipo32List read FRegistroTipo32 write FRegistroTipo32;
    property RegistroTipo50: TRegistroTipo50List read FRegistroTipo50 write FRegistroTipo50;
    property RegistroTipo51: TRegistroTipo51List read FRegistroTipo51 write FRegistroTipo51;
    property RegistroTipo90: TRegistroTipo90     read FRegistroTipo90 write FRegistroTipo90;
  end;
implementation

{ TFolha_Sefip }

constructor TFolha_Sefip.Create;
begin
  CriaRegistros;
end;

procedure TFolha_Sefip.CriaRegistros;
begin
  FRegistroTipo00 := TRegistroTipo00.Create;
  FRegistroTipo10 := TRegistroTipo10.Create;
  FRegistroTipo12 := TRegistroTipo12List.Create;
  FRegistroTipo13 := TRegistroTipo13List.Create;
  FRegistroTipo14 := TRegistroTipo14List.Create;
  FRegistroTipo20 := TRegistroTipo20List.Create;
  FRegistroTipo21 := TRegistroTipo21List.Create;
  FRegistroTipo30 := TRegistroTipo30List.Create;
  FRegistroTipo32 := TRegistroTipo32List.Create;
  FRegistroTipo50 := TRegistroTipo50List.Create;
  FRegistroTipo51 := TRegistroTipo51List.Create;
  FRegistroTipo90 := TRegistroTipo90.Create;
end;

destructor TFolha_Sefip.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TFolha_Sefip.LiberaRegistros;
begin
  FRegistroTipo00.Free;
  FRegistroTipo10.Free;
  FRegistroTipo12.Free;
  FRegistroTipo13.Free;
  FRegistroTipo14.Free;
  FRegistroTipo20.Free;
  FRegistroTipo21.Free;
  FRegistroTipo30.Free;
  FRegistroTipo32.Free;
  FRegistroTipo50.Free;
  FRegistroTipo51.Free;
  FRegistroTipo90.Free;
end;

procedure TFolha_Sefip.LimpaRegistros;
begin
  LiberaRegistros;
  CriaRegistros;
end;

function TFolha_Sefip.WriteRegistroTipo00: String;
begin
  Result := '';
  if Assigned(FRegistroTipo00) then
  begin
    with FRegistroTipo00 do
    begin
      Check(((TipoRemessa = '1') or (TipoRemessa = '3')), '(0-0000) O indicador "%s" Só pode ser 1 (GFIP), ou 3 (DERF).', [TipoRemessa]);
      Check(((TipoInscricaoResponsavel = '1') or (TipoInscricaoResponsavel = '2') or (TipoInscricaoResponsavel = '3')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI) ou 3 (CPF) Só pode ser igual a 3 (CPF), para o código de recolhimento 418.', [TipoInscricaoResponsavel]);
      if TipoInscricaoResponsavel = '1' then
        Check(ValidarCnpjCeiCpf(InscricaoResponsavel), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoResponsavel])
      else if TipoInscricaoResponsavel = '2' then
        Check(ValidarCnpjCeiCpf(InscricaoResponsavel), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoResponsavel])
      else if TipoInscricaoResponsavel = '3' then
        Check(ValidarCnpjCeiCpf(InscricaoResponsavel), '(0-0000) O CPF "%s" digitado é inválido!', [InscricaoResponsavel]);
      Check(ValidarUF(UnidadeFederacao), '(0-0000) A UF "%s" digitada é inválida!', [UnidadeFederacao]);
      Check(ValidarCEP(CEP, Cep), '(0-0000) O Cep "%s" digitada é inválida!', [CEP]);
      Check(ValidarEmail(EnderecoInternetContato), '(0-0000) O E-mail "%s" digitado é inválido!', [EnderecoInternetContato]);
      ///
      Result := LFill('00') +
                RFill(' ',51) +
                LFill(TipoRemessa, 1) +
                LFill(TipoInscricaoResponsavel, 1) +
                LFill(InscricaoResponsavel, 14) +
                RFill(TratarString(NomeResponsavel), 30) +
                RFill(TratarString(NomePessoaContato, True), 20) +
                RFill(TratarString(Logradouro), 50) +
                RFill(TratarString(Bairro), 20) +
                RFill(Cep, 8)+
                RFill(TratarString(Cidade), 20)+
                RFill(UnidadeFederacao, 2) +
                LFill(ApenasNumeros(TelefoneContato), 12) +
                RFill(EnderecoInternetContato, 60) +
                RFill(Competencia, 6) +
                LFill(CodigoRecolhimento, 3) +
                LFill(IndicadorRecolhimentoFGTS, 1) +
                LFill(ModalidadeArquivo, 1) +
                RFill(FormatDateTime('DDMMYYYY', DataRecolhimentoFGTS), 8) +
                LFill(IndicadorRecolhimentoPrevidenciaSocial, 1) +
                RFill(FormatDateTime('DDMMYYYY', DataRecolhimentoPrevidenciaSocial), 8) +
                RFill(IndiceRecolhimentoAtrasoPrevidenciaSocial, 7) +
                LFill(TipoInscricaoFornecedorFolhaPagamento, 1) +
                LFill(InscricaoFornecedorFolhaPagamento, 14)  +
                RFill(' ', 18) +
                LFill('*') +
                sLineBreak;
     end;
  end;
end;

function TFolha_Sefip.WriteRegistroTipo10: String;
begin
  Result := '';

  if Assigned(FRegistroTipo10) then
  begin
     with FRegistroTipo10 do
     begin
       Check(((TipoInscricaoEmpresa = '1') or (TipoInscricaoEmpresa = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoEmpresa]);
       if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
         Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoEmpresa])
       else
       if TipoInscricaoEmpresa = '2' then
         Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoEmpresa]);
       Check(ValidarUF(UnidadeFederacao), '(0-0000) A UF "%s" digitada é inválida!', [UnidadeFederacao]);
       Check(ValidarCEP(CEP, UnidadeFederacao), '(0-0000) O Cep "%s" digitada é inválida!', [CEP]);
       ///
       Result := LFill('10') +
                 LFill(TipoInscricaoEmpresa, 1) +
                 LFill(InscricaoEmpresa, 14) +
                 LFill('0', 36) +
                 RFill(TratarString(NomeEmpresaRazaoSocial), 40) +
                 RFill(TratarString(Logradouro), 50) +
                 RFill(TratarString(Bairro), 20) +
                 RFill(Cep, 8) +
                 RFill(TratarString(Cidade), 20) +
                 RFill(UnidadeFederacao, 2)+
                 LFill(TelefoneContato, 12)+
                 RFill(IndicadorAlteracaoEndereco, 1) +
                 LFill(CNAE, 7) +
                 RFill(IndicadorAlteracaoCNAE, 1) +
                 LFill(AliquotaRAT, 2) +
                 LFill(CodigoCentralizacao, 1) +
                 LFill(SIMPLES, 1) +
                 LFill(FPAS, 3) +
                 LFill(CodigoOutrasEntidades, 4) +
                 LFill(CodigoPagamentoGPS, 4) +
                 LFill(PercentualIsencaoFilantropia, 5) +
                 LFill(SalarioFamilia, 15) +
                 LFill(SalarioMaternidade, 15) +
                 LFill(ContribDescEmpregadoReferenteCompetencia13, 15) +
                 LFill(IndicadorValorNegativoPositivo, 1) +
                 LFill(ValorDevidoPrevidenciaSocialReferenteComp13, 14) +
                 LFill(Banco, 3) +
                 RFill(Agencia, 4) +
                 RFill(ContaCorrente, 9) +
                 LFill('0', 45) +
                 RFill(' ', 4)+
                 RFill('*', 1) +
                 sLineBreak;
     end;
  end;
end;

function TFolha_Sefip.WriteRegistroTipo12: String;
var
  intFor: integer;
  strRegistroTipo12: String;
begin
  strRegistroTipo12 := '';

  if Assigned(FRegistroTipo12) then
  begin
     for intFor := 0 to FRegistroTipo12.Count - 1 do
     begin
        with FRegistroTipo12.Items[intFor] do
        begin
          Check(((TipoInscricaoEmpresa = '1') and (TipoInscricaoEmpresa = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoEmpresa]);
          if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
            Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoEmpresa])
          else
            if TipoInscricaoEmpresa = '2' then
           Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoEmpresa]);
           Check(((IndicativoOrigemReceita = 'E') or (IndicativoOrigemReceita = 'A') or (IndicativoOrigemReceita = 'P')), '(0-0000) O Indicador só pode ser: “E” (receita referente a arrecadação de eventos); “P” (receita referente a patrocínio); “A” (receita referente à arrecadação de eventos e patrocínio).');
           ///
          strRegistroTipo12 :=  strRegistroTipo12 +
                                LFill('12')+
                                LFill(TipoInscricaoEmpresa,1) +
                                LFill(InscricaoEmpresa, 14) +
                                LFill('0', 36) +
                                LFill(Deducao13SalarioLicencaMaternidade, 15) +
                                LFill(ReceitaEventoDesportivoPatrocinio, 15) +
                                RFill(IndicativoOrigemReceita, 1) +
                                LFill(ComercializacaoProducaoPessoaFisica, 15) +
                                LFill(ComercializacaoProducaoPessoaJuridica, 15) +
                                RFill(OutrasInformacoesProcesso, 11) +
                                RFill(OutrasInformacoesProcessoAno, 4) +
                                LFill(OutrasInformacoesVaraJCJ, 5) +
                                RFill(FormatDateTime('YYYYMM', OutrasInformacoesPeriodoInicio), 6) +
                                RFill(FormatDateTime('YYYYMM', OutrasInformacoesPeriodoFim), 6) +
                                LFill(CompensacaoValorCorrigido, 15) +
                                RFILL(FormatDateTime('YYYYMM', CompensacaoPeriodoInicio), 6) +
                                RFill(FormatDateTime('YYYYMM',CompensacaoPeriodoFim), 6)+
                                LFill(RecolhimentoCompetenciasAnterioresValorINSSFolhaPagamento, 15) +
                                LFill(RecolhimentoCompetenciasAnterioresOutrasEntidadesFolhaPagamento, 15) +
                                LFill(RecolhimentoCompetenciasAnterioresComercializacaoProducaoValorINSS, 15) +
                                LFill(RecolhimentoCompetenciasAnterioresComercializacaoProducaoOutrasEntidades, 15) +
                                LFill(RecolhimentoCompetenciasAnterioresReceitaEventoDesportivoPatrocínioValorINSS, 15) +
                                LFill(ParcelamentoFGTSSomatorioRemuneracoesCategorias0102030506, 15) +
                                LFill(ParcelamentoFGTSValorRecolhido, 15)+
                                LFill(ValoresPagosCooperativasTrabalhoServicosPrestados, 15) +
                                /// Implementação futura  45 V - Para implementação futura. Até autorização da CAIXA, preencher com zeros.
                                LFill('0', 45) +
                                RFill(' ', 6) +
                                RFill('*', 1) +
                                sLineBreak;

        end;
        // Contador de registro se necessário, ou validar inserir aqui
     end;
  end;
  Result := strRegistroTipo12;
end;

function TFolha_Sefip.WriteRegistroTipo13: String;
var
  intFor: integer;
  strRegistroTipo13: String;
begin
  strRegistroTipo13 := '';

  if Assigned(FRegistroTipo13) then
  begin
     for intFor := 0 to FRegistroTipo13.Count - 1 do
     begin
        with FRegistroTipo13.Items[intFor] do
        begin
          Check(((TipoInscricao = '1') or (TipoInscricao = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricao]);
          if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
            Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoEmpresa])
          else
            if TipoInscricao = '2' then
            Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoEmpresa]);
            Check(ValidarPis(PISPASEPCI), '(0-0000) O PIS - PASEP - CI "%s" digitado é inválido!', [PISPASEPCI]);
            Check((StrToInt(CategoriaTrabalhador) > 0) and (StrToInt(CategoriaTrabalhador) < 8),'(0-0000) Acatar somente as categorias 01, 02, 03, 04, 05, 06 e 07.',[CategoriaTrabalhador]);
            ///
            strRegistroTipo13 :=  strRegistroTipo13 +
                                  LFill('13') +
                                  LFill(TipoInscricao, 1) +
                                  LFill(InscricaoEmpresa, 14) +
                                  LFill('0', 36) +
                                  LFill(PISPASEPCI, 11) +
                                  RFill(FormatDateTime('DDMMYYYY',DataAdmissao), 8) +
                                  LFill(CategoriaTrabalhador, 2) +
                                  RFill(MatriculaTrabalhador, 11) +
                                  RFill(NumeroCTPS, 7) +
                                  RFill(SerieCTPS, 5) +
                                  RFill(TratarString(NomeTrabalhador,True), 70) +
                                  RFill(CodigoEmpresaCaixa, 14) +
                                  RFill(CodigoTrabalhadorCaixa, 11) +
                                  LFill(CodigoAlteracaoCadastral, 3) +
                                  RFill(TratarString(NovoConteudoCampo, True), 70) +
                                  RFill(' ', 94) +
                                  RFill('*', 1) +
                                  sLineBreak;
        end;
        // Contador de registro se necessário, ou validar inserir aqui
     end;
  end;
  Result := strRegistroTipo13;
end;

function TFolha_Sefip.WriteRegistroTipo14: String;
var
intFor: integer;
strRegistroTipo14: String;
begin
  strRegistroTipo14 := '';

  if Assigned(FRegistroTipo14) then
  begin
     for intFor := 0 to FRegistroTipo14.Count - 1 do
     begin
        with FRegistroTipo14.Items[intFor] do
        begin
          Check(((TipoInscricaoEmpresa = '1') or (TipoInscricaoEmpresa = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoEmpresa]);
          if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
            Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoEmpresa])
          else
            if TipoInscricaoEmpresa = '2' then
            Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoEmpresa]);
            Check(ValidarPis(PISPASEPCI), '(0-0000) O PIS - PASEP - CI "%s" digitado é inválido!', [PISPASEPCI]);
            Check(ValidarUF(UnidadeFederacao), '(0-0000) A UF "%s" digitada é inválida!', [UnidadeFederacao]);
            Check(ValidarCEP(CEP, UnidadeFederacao), '(0-0000) O Cep "%s" digitada é inválida!', [CEP]);
            ///
            strRegistroTipo14 := strRegistroTipo14 +
                                 LFill('14') +
                                 LFill(TipoInscricaoEmpresa, 1) +
                                 LFill(InscricaoEmpresa, 14) +
                                 LFill('0', 36) +
                                 LFill(PISPASEPCI, 11) +
                                 RFill(FormatDateTime('DDMMYYYY',DataAdmissao), 8) +
                                 LFill(CategoriaTrabalhador, 2) +
                                 RFill(TratarString(NomeTrabalhador, True), 70) +
                                 RFill(NumeroCTPS, 7) +
                                 RFill(SerieCTPS, 5) +
                                 RFill(TratarString(Logradouro), 50) +
                                 RFill(TratarString(Bairro), 20) +
                                 LFill(Cep, 8) +
                                 RFill(TratarString(Cidade), 20) +
                                 RFill(UnidadeFederacao, 2) +
                                 LFill('0', 103) +
                                 RFill('*', 1) +
                                 sLineBreak;
        end;
        // Contador de registro se necessário, ou validar inserir aqui
     end;
  end;
  Result := strRegistroTipo14;
end;

function TFolha_Sefip.WriteRegistroTipo20: String;
var
intFor: integer;
strRegistroTipo20: String;
begin
  strRegistroTipo20 := '';

  if Assigned(FRegistroTipo20) then
  begin
     for intFor := 0 to FRegistroTipo20.Count - 1 do
     begin
        with FRegistroTipo20.Items[intFor] do
        begin
          Check(((TipoInscricaoEmpresa = '1') or (TipoInscricaoEmpresa = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoEmpresa]);
          if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
            Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoEmpresa])
          else
            if TipoInscricaoEmpresa = '2' then
           Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoEmpresa]);

          Check(((TipoInscricaoTomadorObraConstCivil = '1') or (TipoInscricaoTomadorObraConstCivil = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoTomadorObraConstCivil]);
          if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
            Check(ValidarCnpjCeiCpf(InscricaoTomadorObraConstCivil), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoTomadorObraConstCivil])
          else
            if TipoInscricaoTomadorObraConstCivil = '2' then
           Check(ValidarCnpjCeiCpf(InscricaoTomadorObraConstCivil), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoTomadorObraConstCivil]);

           Check(ValidarUF(UnidadeFederacao), '(0-0000) A UF "%s" digitada é inválida!', [UnidadeFederacao]);
           Check(ValidarCEP(CEP, UnidadeFederacao), '(0-0000) O Cep "%s" digitada é inválida!', [CEP]);
           ///
           strRegistroTipo20 := strRegistroTipo20 +
                                LFill('20') +
                                LFill(TipoInscricaoEmpresa, 1) +
                                LFill(InscricaoEmpresa, 14) +
                                LFill(TipoInscricaoTomadorObraConstCivil, 1) +
                                LFill(InscricaoTomadorObraConstCivil, 14) +
                                LFill('0', 21) +
                                RFill(TratarString(NomeTomadorObraConstCivil), 40) +
                                RFill(TratarString(Logradouro), 50) +
                                RFill(TratarString(Bairro), 20) +
                                LFill(Cep, 8) +
                                RFill(TratarString(Cidade), 20) +
                                RFill(UnidadeFederacao, 2) +
                                LFill(CodigoPagamentoGPS, 4) +
                                LFill(SalarioFamilia, 15) +
                                LFill(ContribDescEmpregadoReferentecompetencia13, 15) +
                                LFill(IndicadorValorNegativoPositivo, 15) +
                                LFill(ValorDevidoPrevidenciaSocialReferenteCompetencia13, 15) +
                                LFill(ValorRetencaoLei971198, 15) +
                                LFill(ValorFaturasEmitidasTomador, 15) +
                                LFill('0', 45) +
                                RFill(' ', 42) +
                                RFill('*', 1) +
                                sLineBreak;
        end;
        // Contador de registro se necessário, ou validar inserir aqui
     end;
  end;
  Result := strRegistroTipo20;
end;



function TFolha_Sefip.WriteRegistroTipo21: String;
var
  intFor: integer;
  strRegistroTipo21: String;
begin
  strRegistroTipo21 := '';

  if Assigned(FRegistroTipo21) then
  begin
    for intFor := 0 to FRegistroTipo21.Count - 1 do
    begin
      with FRegistroTipo21.Items[intFor] do
      begin
        Check(((TipoInscricaoEmpresa = '1') or (TipoInscricaoEmpresa = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoEmpresa]);
        if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
          Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoEmpresa])
        else
          if TipoInscricaoEmpresa = '2' then
            Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoEmpresa]);

        Check(((TipoInscricaoTomadorObraConstCivil = '1') or (TipoInscricaoTomadorObraConstCivil = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoTomadorObraConstCivil]);
        if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
          Check(ValidarCnpjCeiCpf(InscricaoTomadorObraConstCivil), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoTomadorObraConstCivil])
        else
          if TipoInscricaoTomadorObraConstCivil = '2' then
            Check(ValidarCnpjCeiCpf(InscricaoTomadorObraConstCivil), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoTomadorObraConstCivil]);
        ///
        strRegistroTipo21 := strRegistroTipo21 +
                             LFill('21') +
                             LFill(TipoInscricaoEmpresa, 1) +
                             LFill(InscricaoEmpresa, 14) +
                             LFill(TipoInscricaoTomadorObraConstCivil, 1) +
                             LFill(InscricaoTomadorObraConstCivil, 14) +
                             LFill('0', 21) +
                             LFill(CompensacaoValorCorrigido, 15) +
                             RFill(FormatDateTime('YYYYMM', CompensacaoPeriodoInicio), 6) +
                             RFill(FormatDateTime('YYYYMM', CompensacaoPeriodoFim), 6) +
                             LFill(RecolhimentoCompetenciasAnterioresValorINSSFolhaPagamento, 15) +
                             LFill(RecolhimentoCompetenciasAnterioresOutrasEntidadesFolhaPagamento, 15) +
                             LFill(ParcelamentoFGTSSomatorioRemuneracoesCategorias0102030506, 15) +
                             LFill(ParcelamentoFGTSSomatorioRemuneracoesCategorias0407, 15) +
                             LFill(ParcelamentoFGTSValorRecolhido, 15) +
                             RFill(' ', 204) +
                             RFill('*', 1) +
                             sLineBreak;
      end;
      // Contador de registro se necessário, ou validar inserir aqui
    end;
  end;
  Result := strRegistroTipo21;
end;

function TFolha_Sefip.WriteRegistroTipo30: String;
var
  intFor: integer;
  strRegistroTipo30: String;
begin
  strRegistroTipo30 := '';

  if Assigned(FRegistroTipo30) then
  begin
    for intFor := 0 to FRegistroTipo30.Count - 1 do
    begin
      with FRegistroTipo30.Items[intFor] do
      begin
        Check(((TipoInscricaoEmpresa = '1') or (TipoInscricaoEmpresa = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoEmpresa]);
        if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
          Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoEmpresa])
        else
          if TipoInscricaoEmpresa = '2' then
            Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoEmpresa]);

        Check(((TipoInscricaoTomadorObraConstCivil = '1') or (TipoInscricaoTomadorObraConstCivil = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoTomadorObraConstCivil]);
        if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
          Check(ValidarCnpjCeiCpf(InscricaoTomadorObraConstCivil), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoTomadorObraConstCivil])
        else
          if TipoInscricaoTomadorObraConstCivil = '2' then
            Check(ValidarCnpjCeiCpf(InscricaoTomadorObraConstCivil), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoTomadorObraConstCivil]);
        Check(ValidarPis(PISPASEPCI), '(0-0000) O PIS - PASEP - CI "%s" digitado é inválido!', [PISPASEPCI]);
        ///
        strRegistroTipo30 := strRegistroTipo30 +
                             LFill('30') +
                             LFill(TipoInscricaoEmpresa, 1) +
                             LFill(InscricaoEmpresa, 14) +
                             LFill(TipoInscricaoTomadorObraConstCivil, 1) +
                             LFill(InscricaoTomadorObraConstCivil, 14) +
                             LFill(PISPASEPCI, 11) +
                             RFill(FormatDateTime('DDMMYYYY',DataAdmissao), 8) +
                             LFill(CategoriaTrabalhador, 2) +
                             RFill(TratarString(NomeTrabalhador, True), 70) +
                             RFill(MatriculaEmpregado, 11) +
                             RFill(NumeroCTPS, 7) +
                             RFill(SerieCTPS, 5) +
                             RFill(FormatDateTime('DDMMYYYY', DataOpcao), 8) +
                             RFill(FormatDateTime('DDMMYYYY', DataNascimento), 8) +
                             RFill(CBO, 5) +
                             LFill(RemuneracaoSem13, 15) +
                             LFill(Remuneracao13, 15) +
                             RFill(ClasseContribuicao, 2) +
                             RFill(Ocorrencia, 2) +
                             LFill(ValorDescontadoSegurado, 15) +
                             LFill(RemuneracaoBaseCalculoContribuicaoPrevidenciaria, 15) +
                             LFill(BaseCalculo13SalarioPrevidenciaSocialReferenteCompetenciaMovimento, 15) +
                             LFill(BaseCalculo13SalarioPrevidenciaReferenteGPSCompetencia13, 15) +
                             RFill(' ', 98) +
                             RFill('*', 1) +
                             sLineBreak;
      end;
      // Contador de registro se necessário, ou validar inserir aqui
    end;
  end;
  Result := strRegistroTipo30;
end;


function TFolha_Sefip.WriteRegistroTipo32: String;
var
  intFor: integer;
  strRegistroTipo32: String;
begin
  strRegistroTipo32 := '';

  if Assigned(FRegistroTipo32) then
  begin
    for intFor := 0 to FRegistroTipo32.Count - 1 do
    begin
      with FRegistroTipo32.Items[intFor] do
      begin
        Check(((TipoInscricaoEmpresa = '1') or (TipoInscricaoEmpresa = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoEmpresa]);
        if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
          Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoEmpresa])
        else
          if TipoInscricaoEmpresa = '2' then
            Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoEmpresa]);

        Check(((TipoInscricaoTomadorObraConstCivil = '1') or (TipoInscricaoTomadorObraConstCivil = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoTomadorObraConstCivil]);
        if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
          Check(ValidarCnpjCeiCpf(InscricaoTomadorObraConstCivil), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoTomadorObraConstCivil])
        else
          if TipoInscricaoTomadorObraConstCivil = '2' then
            Check(ValidarCnpjCeiCpf(InscricaoTomadorObraConstCivil), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoTomadorObraConstCivil]);
        Check(ValidarPis(PISPASEPCI), '(0-0000) O PIS - PASEP - CI "%s" digitado é inválido!', [PISPASEPCI]);
        ///
        strRegistroTipo32 := strRegistroTipo32 +
                             LFill('32') +
                             LFill(TipoInscricaoEmpresa, 1) +
                             LFill(InscricaoEmpresa, 14) +
                             LFill(TipoInscricaoTomadorObraConstCivil, 1) +
                             LFill(InscricaoTomadorObraConstCivil, 14) +
                             LFill(PISPASEPCI, 11) +
                             RFill(FormatDateTime('DDMMYYYYA',DataAdmissao), 8) +
                             LFill(CategoriaTrabalhador, 2) +
                             RFill(TratarString(NomeTrabalhador, True), 70) +
                             RFill(CodigoMovimentacao, 2) +
                             RFIll(FormatDateTime('DDMMYYYY', DataMovimentacao), 8 ) +
                             RFill(IndicativoRecolhimentoFGTS, 1) +
                             RFill(' ', 255) +
                             RFill('*', 1) +
                             sLineBreak;
      end;
      // Contador de registro se necessário, ou validar inserir aqui
    end;
  end;
  Result := strRegistroTipo32;
end;


function TFolha_Sefip.WriteRegistroTipo50: String;
var
intFor: integer;
strRegistroTipo50: String;
begin
  strRegistroTipo50 := '';

  if Assigned(FRegistroTipo50) then
  begin
    for intFor := 0 to FRegistroTipo50.Count - 1 do
    begin
      with FRegistroTipo50.Items[intFor] do
      begin
        Check(((TipoInscricaoEmpresa = '1') or (TipoInscricaoEmpresa = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoEmpresa]);
        if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
          Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoEmpresa])
        else
          if TipoInscricaoEmpresa = '2' then
         Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoEmpresa]);

        Check(((TipoInscricaoTomador = '1') or (TipoInscricaoTomador = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoTomador]);
        if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
          Check(ValidarCnpjCeiCpf(InscricaoTomador), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoTomador])
        else
          if TipoInscricaoTomador = '2' then
         Check(ValidarCnpjCeiCpf(InscricaoTomador), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoTomador]);

        Check(ValidarUF(UnidadeFederacao), '(0-0000) A UF "%s" digitada é inválida!', [UnidadeFederacao]);
        Check(ValidarCEP(CEP, UnidadeFederacao), '(0-0000) O Cep "%s" digitada é inválida!', [CEP]);
        Check(ValidarTelefone(Telefone),'0-0000) O Telefone %s% digitado é inválido', [Telefone]);
        Check(((CodigoCentralizacao = '0') or (CodigoCentralizacao = '1') or (CodigoCentralizacao = '2')), '(0-0000) Campo obrigatório.  Só pode ser 0 (não centraliza), 1 (centralizadora) ou 2 (centralizada).', [TipoInscricaoEmpresa]);

        ///
        strRegistroTipo50 := strRegistroTipo50 +
                             LFill('50') +
                             LFill(TipoInscricaoEmpresa, 1) +
                             LFill(InscricaoEmpresa, 14) +
                             LFill('0', 36) +
                             RFill(TratarString(FRegistroTipo10.NomeEmpresaRazaoSocial), 40) +
                             LFill(TipoInscricaoTomador, 1) +
                             LFill(InscricaoTomador, 14) +
                             RFill(TratarString(NomeTomadorServicoObraConstCivil), 40) +
                             RFill(TratarString(Logradouro), 50) +
                             RFill(TratarString(Bairro), 20) +
                             LFill(Cep, 8) +
                             RFill(TratarString(Cidade), 20) +
                             RFill(UnidadeFederacao, 2) +
                             LFill(Telefone, 12) +
                             LFill(CNAE, 7) +
                             LFill(CodigoCentralizacao, 1) +
                             LFill(ValorMulta, 15) +
                             RFill(' ', 76) +
                             RFill('*', 1) +
                             sLineBreak;
      end;
      // Contador de registro se necessário, ou validar inserir aqui
    end;
  end;
  Result := strRegistroTipo50;
end;



function TFolha_Sefip.WriteRegistroTipo51: String;
var
  intFor: integer;
  strRegistroTipo51: String;
begin
  strRegistroTipo51 := '';

  if Assigned(FRegistroTipo51) then
  begin
    for intFor := 0 to FRegistroTipo51.Count - 1 do
    begin
      with FRegistroTipo51.Items[intFor] do
      begin
        Check(((TipoInscricaoEmpresa = '1') or (TipoInscricaoEmpresa = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoEmpresa]);
        if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
          Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoEmpresa])
        else
          if TipoInscricaoEmpresa = '2' then
            Check(ValidarCnpjCeiCpf(InscricaoEmpresa), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoEmpresa]);

        Check(((TipoInscricaoTomador = '1') or (TipoInscricaoTomador = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI). Para empregador doméstico só pode acatar 2 (CEI).', [TipoInscricaoTomador]);
        if FRegistroTipo00.TipoInscricaoResponsavel = '1' then
           Check(ValidarCnpjCeiCpf(InscricaoTomador), '(0-0000) O CNPJ "%s" digitado é inválido!', [InscricaoTomador])
        else
          if TipoInscricaoTomador = '2' then
            Check(ValidarCnpjCeiCpf(InscricaoTomador), '(0-0000) O CEI "%s" digitado é inválido!', [InscricaoTomador]);

        Check(ValidarPis(PISPASEP), '(0-0000) O PIS - PASEP - CI "%s" digitado é inválido!', [PISPASEP]);
        Check((StrToInt(CategoriaTrabalhador) < 1) and (StrToInt(CategoriaTrabalhador) > 7),'(0-0000) Acatar somente as categorias 01, 02, 03, 04, 05, 06 e 07.',[CategoriaTrabalhador]);
        ///
        strRegistroTipo51 := strRegistroTipo51 +
                             LFill('51') +
                             LFill(TipoInscricaoEmpresa, 1) +
                             LFill(InscricaoEmpresa, 14) +
                             LFill(TipoInscricaoTomador, 1) +
                             LFill(InscricaoTomador, 14) +
                             LFill(PISPASEP, 11) +
                             RFill(FormatDateTime('DDMMYYYY',DataAdmissao), 8) +
                             LFill(CategoriaTrabalhador, 2) +
                             RFill(TratarString(NomeTrabalhador, True), 70) +
                             RFill(MatriculaEmpregado, 11) +
                             RFill(NumeroCTPS, 7) +
                             RFill(SerieCTPS, 5) +
                             RFill(FormatDateTime('DDMMYYYY', DataOpcao), 8) +
                             RFill(FormatDateTime('DDMMYYYY', DataNascimento), 8) +
                             LFill(CBO, 5) +
                             LFill(ValorDepositoSem13Salario, 15) +
                             LFill(ValorDepositoSobre13Salario, 15) +
                             LFill(ValorJAM, 15)+
                             RFill(' ', 147) +
                             RFill('*', 1) +
                             sLineBreak;
      end;
      // Contador de registro se necessário, ou validar inserir aqui
    end;
  end;
  Result := strRegistroTipo51;
end;

function TFolha_Sefip.WriteRegistroTipo90: String;
begin
  Result := '';

  if Assigned(FRegistroTipo90) then
  begin
    with FRegistroTipo90 do
    begin
      Result := LFill('90') +
                RFill(MarcaFinalRegistro, 51) +
                RFill(' ', 306) +
                RFill('*', 1);
    end;
  end;
end;

end.

