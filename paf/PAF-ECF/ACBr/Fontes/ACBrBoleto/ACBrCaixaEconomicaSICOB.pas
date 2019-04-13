{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   João Elson                                    }
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

{
  Somente para SICOB
  by Jéter Rabelo Ferreira - 07/2011
}

{$I ACBr.inc}

unit ACBrCaixaEconomicaSICOB;

interface

uses
  Classes, SysUtils, ACBrBoleto,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type

  { TACBrCaixaEconomicaSICOB}

  TACBrCaixaEconomicaSICOB = class(TACBrBancoClass)
   protected
   private
    function FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
    function CalcularDVAgCD: string;
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override;
    function CalcularDVCedente(const ACBrTitulo: TACBrTitulo ): String;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function GerarRegistroHeader240(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa : TStringList): String;  override;
    procedure LerRetorno240(ARetorno:TStringList); override;

    function TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia) : String; override;
    function CodOcorrenciaToTipo(const CodOcorrencia:Integer): TACBrTipoOcorrencia; override;
    function TipoOCorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia):String; override;
    function CodMotivoRejeicaoToDescricao(const TipoOcorrencia:TACBrTipoOcorrencia; CodMotivo:Integer): String; override;
   end;

implementation

uses ACBrUtil, StrUtils, Variants;

constructor TACBrCaixaEconomicaSICOB.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 9;
   fpNome   := 'Caixa Economica Federal';
   fpNumero:= 104;
   fpTamanhoMaximoNossoNum := 15;
end;

function TACBrCaixaEconomicaSICOB.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
var
  Num, Res :String;
begin
   Result := '0';
   Num := OnlyNumber(ACBrTitulo.NossoNumero);
   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal   := 2;
   Modulo.MultiplicadorInicial := 9;
   Modulo.Documento := Num;
   Modulo.Calcular;

   Res:= IntToStr(Modulo.ModuloFinal);

   if Length(Res) > 1 then
    Result := '0'
  else
    Result := Res[1];
end;

function TACBrCaixaEconomicaSICOB.CalcularDVAgCD: string;
var
  Num, ACedente, Res :String;
begin
  Result := '0';
  with ACBrBanco.ACBrBoleto.Cedente do
  begin
    // Retirar o código da operácão do'código do cedetnet,
    // sempre com 3 digitos, ex: 870
    // Sem o DV
    ACedente := padL(Copy(CodigoCedente, 4, Length(CodigoCedente) -1), 8, '0');
    Num := Agencia + ACedente;

    Modulo.CalculoPadrao;
    Modulo.MultiplicadorFinal   := 2;
    Modulo.MultiplicadorInicial := 9;
    Modulo.Documento := Num;
    Modulo.Calcular;

    Res:= IntToStr(Modulo.ModuloFinal);
    if Length(Res) > 1 then
      Result := '0'
    else
      Result := Res[1];
  end;
end;

function TACBrCaixaEconomicaSICOB.CalcularDVCedente(const ACBrTitulo: TACBrTitulo): String;
var
  Num, Res: string;
begin 
  Num := ACBrTitulo.ACBrBoleto.Cedente.Agencia + ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente;

  Modulo.CalculoPadrao;
  Modulo.MultiplicadorFinal   := 2;
  Modulo.MultiplicadorInicial := 9;
  Modulo.Documento := Num;
  Modulo.Calcular;
  Res := intTostr(Modulo.ModuloFinal);

  if Length(Res) > 1 then
    Result := '0'
  else
    Result := Res[1];
end;

function TACBrCaixaEconomicaSICOB.CodMotivoRejeicaoToDescricao(
  const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: Integer): String;
begin
  case TipoOcorrencia of
    toRetornoRegistroConfirmado,
      toRetornoRegistroRecusado,
      toRetornoInstrucaoRejeitada,
      toRetornoALteracaoOutrosDadosRejeitada:
      case CodMotivo of
        01: Result := '01-Código do banco inválido';
        02: Result := '02-Código do registro inválido.';
        03: Result := '03-Código do segmento inválido.';
        05: Result := '05-Código de movimento inválido.';
        06: Result := '06-Tipo/número de inscrição do cedente inválido.';
        07: Result := '07-Agência/Conta/DV inválido.';
        08: Result := '08-Nosso número inválido.';
        09: Result := '09-Nosso número duplicado.';
        10: Result := '10-Carteira inválida.';
        11: Result := '11-Forma de cadastramento do título inválido.';
        12: Result := '12-Tipo de documento inválido.';
        13: Result := '13-Identificação da emissão do bloqueto inválida.';
        14: Result := '14-Identificação da distribuição do bloqueto inválida.';
        15: Result := '15-Características da cobrança incompatíveis.';
        16: Result := '16-Data de vencimento inválida.';
        20: Result := '20-Valor do título inválido.';
        21: Result := '21-Espécie do título inválida.';
        23: Result := '23-Aceite inválido.';
        24: Result := '24-Data da emissão inválida.';
        26: Result := '26-Código de juros de mora inválido.';
        27: Result := '27-Valor/Taxa de juros de mora inválido.';
        28: Result := '28-Código do desconto inválido.';
        29: Result := '29-Valor do desconto maior ou igual ao valor do título.';
        30: Result := '30-Desconto a conceder não confere.';
        32: Result := '32-Valor do IOF inválido.';
        33: Result := '33-Valor do abatimento inválido.';
        37: Result := '37-Código para protesto inválido.';
        38: Result := '38-Prazo para protesto inválido.';
        40: Result := '40-Título com ordem de protesto emitida.';
        42: Result := '42-Código para baixa/devolução inválido.';
        43: Result := '43-Prazo para baixa/devolução inválido.';
        44: Result := '44-Código da moeda inválido.';
        45: Result := '45-Nome do sacado não informado.';
        46: Result := '46-Tipo/número de inscrição do sacado inválido.';
        47: Result := '47-Endereço do sacado não informado.';
        48: Result := '48-CEP inválido.';
        49: Result := '49-CEP sem praça de cobrança (não localizado).';
        52: Result := '52-Unidade da federação inválida.';
        53: Result := '53-Tipo/número de inscrição do sacador/avalista inválido.';
        57: Result := '57-Código da multa inválido.';
        58: Result := '58-Data da multa inválida.';
        59: Result := '59-Valor/Percentual da multa inválido.';
        60: Result := '60-Movimento para título não cadastrado. Erro genérico para as situações:' + #13#10 +
                          '“Cedente não cadastrado” ou' + #13#10 +
                          '“Agência Cedente não cadastrada ou desativada”.';
        61: Result := '61-Agência cobradora inválida.';
        62: Result := '62-Tipo de impressão inválido.';
        63: Result := '63-Entrada para título já cadastrado.';
        68: Result := '68-Movimentação inválida para o título.';
        69: Result := '69-Alteração de dados inválida.';
        70: Result := '70-Apelido do cliente não cadastrado.';
        71: Result := '71-Erro na composição do arquivo.';
        72: Result := '72-Lote de serviço inválido.';
        73: Result := '73-Código do cedente inválido.';
        74: Result := '74-Cedente não pertence a cobrança eletrônica/apelido não confere com cedente.';
        75: Result := '75-Nome da empresa inválido.';
        76: Result := '76-Nome do banco inválido.';
        77: Result := '77-Código da remessa inválido';
        78: Result := '78-Data/Hora de geração do arquivo inválida.';
        79: Result := '79-Número seqüencial do arquivo inválido.';
        80: Result := '80-Número da versão do Layout do arquivo/lote inválido.';
        81: Result := '81-Literal ‘REMESSA-TESTE’ válida somente para fase de testes.';
        82: Result := '82-Literal ‘REMESSA-TESTE’ obrigatório para fase de testes.';
        83: Result := '83-Tipo/número de inscrição da empresa inválido.';
        84: Result := '84-Tipo de operação inválido.';
        85: Result := '85-Tipo de serviço inválido.';
        86: Result := '86-Forma de lançamento inválido.';
        87: Result := '87-Número da remessa inválido.';
        88: Result := '88-Número da remessa menor/igual que da remessa anterior.';
        89: Result := '89-Lote de serviço divergente.';
        90: Result := '90-Número seqüencial do registro inválido.';
        91: Result := '91-Erro na seqüência de segmento do registro detalhe.';
        92: Result := '92-Código de movimento divergente entre grupo de segmentos.';
        93: Result := '93-Quantidade de registros no lote inválido.';
        94: Result := '94-Quantidade de registros no lote divergente.';
        95: Result := '95-Quantidade de lotes do arquivo inválido.';
        96: Result := '96-Quantidade de lotes no arquivo divergente.';
        97: Result := '97-Quantidade de registros no arquivo inválido.';
        98: Result := '98-Quantidade de registros no arquivo divergente.';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
    toRetornoDebitoTarifas:
      case CodMotivo of
        01: Result := '01-Tarifa de Extrato de Posição';
        02: Result := '02-Tarifa de Manutenção de Título Vencido';
        03: Result := '03-Tarifa de Sustação';
        04: Result := '04-Tarifa de Protesto';
        05: Result := '05-Tarifa de Outras Instruções';
        06: Result := '06-Tarifa de Outras Ocorrências';
        07: Result := '07-Tarifa de Envio de Duplicata ao Sacado';
        08: Result := '08-Custas de Protesto';
        09: Result := '09-Custas de Sustação de Protesto';
        10: Result := '10-Custas de Cartório Distribuidor';
        11: Result := '11-Custas de Edital';
      end;
  end;
end;

function TACBrCaixaEconomicaSICOB.CodOcorrenciaToTipo(
  const CodOcorrencia: Integer): TACBrTipoOcorrencia;
begin
  case CodOcorrencia of
    02: Result := toRetornoRegistroConfirmado;
    03: Result := toRetornoRegistroRecusado;
//'04-Transferência de Carteira/Entrada
//'05-Transferência de Carteira/Baixa
    06: Result := toRetornoLiquidado;
    09: Result := toRetornoBaixadoViaArquivo;
    12: Result := toRetornoAbatimentoConcedido;
    13: Result := toRetornoAbatimentoCancelado;
    14: Result := toRetornoVencimentoAlterado;
    17: Result := toRetornoLiquidadoAposBaixaouNaoRegistro;
    19: Result := toRetornoRecebimentoInstrucaoProtestar;
    20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
    23: Result := toRetornoEncaminhadoACartorio;
    24: Result := toRetornoRetiradoDeCartorio;
    25: Result := toRetornoProtestado;
    26: Result := toRetornoInstrucaoRejeitada;
    27: Result := toRetornoAlteracaoDadosNovaEntrada;
    28: Result := toRetornoDebitoTarifas;
    30: Result := toRetornoALteracaoOutrosDadosRejeitada;
//'36-Confirmação de envio de e-mail/SMS
//'37-Envio de e-mail/SMS rejeitado
    43: Result := toRetornoProtestoSustado;
    44: Result := toRetornoProtestoSustado;
    45: Result := toRetornoAlteracaoDadosNovaEntrada;
//'51-Título DDA reconhecido pelo sacado
//'52-Título DDA não reconhecido pelo sacado
//'53-Título DDA recusado pela CIP  else
  else
    Result := toRetornoOutrasOcorrencias;
  end;
end;

function TACBrCaixaEconomicaSICOB.FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
var
  ANossoNumero: string;
begin
   with ACBrTitulo do
   begin
      ANossoNumero := OnlyNumber(NossoNumero);
      ANossoNumero:= Copy(ANossoNumero,Length(ANossoNumero)-9,15);
   end;
   Result := ANossoNumero;
end;

function TACBrCaixaEconomicaSICOB.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras, ANossoNumero :String;
  CampoLivre,DVCampoLivre : String;
begin
  FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

  ANossoNumero := FormataNossoNumero(ACBrTitulo);

  {Montando Campo Livre}
  CampoLivre   := ANossoNumero + ACBrTitulo.ACBrBoleto.Cedente.Agencia + ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente;

  {Codigo de Barras}
  with ACBrTitulo.ACBrBoleto do
  begin
    CodigoBarras := IntToStrZero(Banco.Numero, 3) +
                    '9' +
                    FatorVencimento +
                    IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                    CampoLivre;
  end;

  DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
  Result:= copy( CodigoBarras, 1, 4) + DigitoCodBarras + copy( CodigoBarras, 5, 44);
end;

function TACBrCaixaEconomicaSICOB.TipoOCorrenciaToCod(
  const TipoOcorrencia: TACBrTipoOcorrencia): String;
begin
  case TipoOcorrencia of
    toRetornoRegistroConfirmado                 : Result := '02';
    toRetornoRegistroRecusado                   : Result := '03';
    toRetornoLiquidado                          : Result := '06';
    toRetornoBaixadoViaArquivo                  : Result := '09';
    toRetornoAbatimentoConcedido                : Result := '12';
    toRetornoAbatimentoCancelado                : Result := '13';
    toRetornoVencimentoAlterado                 : Result := '14';
    toRetornoLiquidadoAposBaixaouNaoRegistro    : Result := '17';
    toRetornoRecebimentoInstrucaoProtestar      : Result := '19';
    toRetornoRecebimentoInstrucaoSustarProtesto : Result := '20';
    toRetornoEncaminhadoACartorio               : Result := '23';
    toRetornoRetiradoDeCartorio                 : Result := '24';
    toRetornoProtestado                         : Result := '25';
    toRetornoInstrucaoRejeitada                 : Result := '26';
    toRetornoAlteracaoDadosNovaEntrada          : Result := '27';
    toRetornoDebitoTarifas                      : Result := '28';
    toRetornoALteracaoOutrosDadosRejeitada      : Result := '30';
    toRetornoProtestoSustado                    : Result := '43';
  else
    Result := '02';  
  end;
end;

function TACBrCaixaEconomicaSICOB.TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia): String;
var
  CodOcorrencia: Integer;
begin
  CodOcorrencia := StrToIntDef(TipoOCorrenciaToCod(TipoOcorrencia),0);
  case CodOcorrencia of
    02: Result := '02-Entrada Confirmada';
    03: Result := '03-Entrada Rejeitada';
    04: Result := '04-Transferência de Carteira/Entrada';
    05: Result := '05-Transferência de Carteira/Baixa';
    06: Result := '06-Liquidação';
    09: Result := '09-Baixa';
    12: Result := '12-Confirmação Recebimento Instrução de Abatimento';
    13: Result := '13-Confirmação Recebimento Instrução de Cancelamento Abatimento';
    14: Result := '14-Confirmação Recebimento Instrução Alteração de Vencimento';
    17: Result := '17-Liquidação Após Baixa ou Liquidação Título Não Registrado';
    19: Result := '19-Confirmação Recebimento Instrução de Protesto';
    20: Result := '20-Confirmação Recebimento Instrução de Sustação/Cancelamento de Protesto';
    23: Result := '23-Remessa a Cartório (Aponte em Cartório)';
    24: Result := '24-Retirada de Cartório e Manutenção em Carteira';
    25: Result := '25-Protestado e Baixado (Baixa por Ter Sido Protestado)';
    26: Result := '26-Instrução Rejeitada';
    27: Result := '27-Confirmação do Pedido de Alteração de Outros Dados';
    28: Result := '28-Débito de Tarifas/Custas';
    30: Result := '30-Alteração de Dados Rejeitada';
    36: Result := '36-Confirmação de envio de e-mail/SMS';
    37: Result := '37-Envio de e-mail/SMS rejeitado';
    43: Result := '43-Estorno de Protesto/Sustação';
    44: Result := '44-Estorno de Baixa/Liquidação';
    45: Result := '45-Alteração de dados';
    51: Result := '51-Título DDA reconhecido pelo sacado';
    52: Result := '52-Título DDA não reconhecido pelo sacado';
    53: Result := '53-Título DDA recusado pela CIP';
  end;
end;

function TACBrCaixaEconomicaSICOB.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
  Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia + '/'+
            ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente+'-'+
            CalcularDVCedente(ACBrTitulo);
end;

function TACBrCaixaEconomicaSICOB.MontarCampoNossoNumero (const ACBrTitulo: TACBrTitulo ) : String;
var ANossoNumero : string;
begin
  ANossoNumero := FormataNossoNumero(ACBrTitulo);
  Result := ANossoNumero + '-' + CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrCaixaEconomicaSICOB.GerarRegistroHeader240(NumeroRemessa : Integer): String;
var
  ATipoInscricao: string;
  ACodConvenio: string;
  ACodCedenteDV: string;
begin
  with ACBrBanco.ACBrBoleto.Cedente do
  begin
    case TipoInscricao of
      pFisica  : ATipoInscricao := '1';
      pJuridica: ATipoInscricao := '2';
      pOutras  : ATipoInscricao := '3';
    end;

    ACodCedenteDV := CalcularDVCedente(ACBrBanco.ACBrBoleto.ListadeBoletos[0]);
    ACodConvenio := padl(Agencia, 4, '0') + padl(CodigoCedente, 11, '0') + ACodCedenteDV;

    { GERAR REGISTRO-HEADER DO ARQUIVO }
    Result:= IntToStrZero(ACBrBanco.Numero, 3)        + //   1 a   3 - Código do banco
             '0000'                                   + //   4 a   7 - Lote de serviço
             '0'                                      + //   8 a   8 - Tipo de registro - Registro header de arquivo
             space(9)                                 + //   9 a  17 - Uso exclusivo FEBRABAN/CNAB
             ATipoInscricao                           + //  18 a  18 - Tipo de inscrição do cedente
             padL(OnlyNumber(CNPJCPF), 14, '0')       + //  19 a  32 - Número de inscrição do cedente
             ACodConvenio                             + //  33 a  48 - Código do convênio no banco - Cedente
             space(4)                                 + //  49 a  52 - Uso Exclusivo CAIXA
             padR(Agencia, 5, '0')                    + //  53 a  57 - Agência Mantenedora Da Conta
             padR(AgenciaDigito, 1 , '0')             + //  58 a  58 - Dígito da agência do cedente
             padR(CodigoCedente, 12, '0')             + //  59 a  70 - Código do Cedente + DV Código Cedente
             ACodCedenteDV                            + //  71 a  71 - DV Codigo Cedente
             CalcularDVAgCD                           + //  72 a  72 - Dig. Verif. Ag + Ced.
             padL(Nome, 30, ' ')                      + //  73 a 102 - Nome da Empresa
             padL('CAIXA ECONOMICA FEDERAL', 30, ' ') + // 103 a 132 - Nome do Banco
             space(10)                                + // 133 a 142 - Uso exclusivo FEBRABAN/CNAB
             '1'                                      + // 143 a 143 - Código de Remessa (1) / Retorno (2)
             FormatDateTime('ddmmyyyy', Now)          + // 144 a 151 - Data do de geração do arquivo
             FormatDateTime('hhmmss', Now)            + // 152 a 157 - Hora de geração do arquivo
             padR(IntToStr(NumeroRemessa), 6, '0')    + // 158 a 163 - Número seqüencial do arquivo
             '030'                                    + // 164 a 166 - Número da versão do layout do arquivo
             padL('',  5, '0')                        + // 167 a 171 - Densidade de gravação do arquivo (BPI)
             space(20)                                + // 172 a 191 - Uso reservado do banco
             padL('REMESSA-TESTE', 20, ' ')           + // 192 a 211 - Uso reservado da empresa
//             padL('REMESSA-PRODUÇÃO', 20, ' ')        + // 192 a 211 - Uso reservado da empresa Quando for produção, desmarar essa linha e bloquear a linha anterior
             space(29);                                 // 212 a 240 - Uso Exclusivo FEBRABAN / CNAB

    { GERAR REGISTRO HEADER DO LOTE }
    Result:= Result + #13#10 +
             IntToStrZero(ACBrBanco.Numero, 3)        + //   1 a   3 - Código do banco
             '0000'                                   + //   4 a   7 - Lote de serviço
             '1'                                      + //   8 a   8 - Tipo de registro - Registro header de arquivo
             'R'                                      + //   9 a   9 - Tipo de operação: R (Remessa) ou T (Retorno)
             '01'                                     + //  10 a  11 - Tipo de serviço: 01 (Cobrança)
             Space(2)                                 + //  12 a  13 - Uso Exclusivo FEBRABAN/CNAB
             '020'                                    + //  14 a  16 - Número da versão do layout do lote
             Space(1)                                 + //  17 a  17 - Uso exclusivo FEBRABAN/CNAB
             ATipoInscricao                           + //  18 a  18 - Tipo de inscrição da Empresa
             padR(OnlyNumber(CNPJCPF), 15, '0')       + //  19 a  33 - Número de inscrição da Empresa
             ACodConvenio                             + //  34 a  39 - Código do convênio no banco (código do cedente)
             space(4)                                 + //  50 a  53 - Uso Exclusivo da CAIXA
             padR(Agencia, 5 , '0')                   + //  54 a  58 - Agência Mantenedora da Conta
             padR(AgenciaDigito, 1 , '0')             + //  59 a  59 - Dígito Verificador da Agência
             padR(CodigoCedente, 12, '0')             + //  60 a  71 - Cód. Cedente + Dígito Verificador do Cedente
             ACodCedenteDV                            + //  72 a  72 - DV Codigo Cedente
             CalcularDVAgCD                           + //  73 a  73 - Dig. Verif. Ag + Ced.
             padR(Nome, 30, ' ')                      + //  74 a 103 - Nome da Empresa
             space(40)                                + // 104 a 143 - Mensagem 1 para todos os boletos do lote
             space(40)                                + // 144 a 183 - Mensagem 2 para todos os boletos do lote
             padR(IntToStr(NumeroRemessa), 8, '0')    + // 184 a 191 - Número do arquivo
             FormatDateTime('ddmmyyyy', Now)          + // 192 a 199 - Data de geração do arquivo
             space(8)                                 + // 200 a 207 - Data do crédito - Só para arquivo retorno
             space(33);                                 // 208 a 240 - Uso exclusivo FEBRABAN/CNAB
  end;
end;

function TACBrCaixaEconomicaSICOB.GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String;
var
   ATipoInscricao,
   ATipoOcorrencia,
   ATipoBoleto,
   ADataMoraJuros,
   ADataDesconto,
   ANossoNumero,
   ATipoAceite,
   ACodCedenteDV : String;
begin
  with ACBrTitulo do
  begin
    ANossoNumero := FormataNossoNumero(ACBrTitulo);

    {SEGMENTO P}
    ACodCedenteDV := CalcularDVCedente(ACBrBanco.ACBrBoleto.ListadeBoletos[0]);

    {Pegando tipo de pessoa do Cendente}
    case ACBrBoleto.Cedente.TipoInscricao of
       pFisica  : ATipoInscricao := '1';
       pJuridica: ATipoInscricao := '2';
       pOutras  : ATipoInscricao := '9';
    end;

    {Pegando o Tipo de Ocorrencia}
    case OcorrenciaOriginal.Tipo of
       toRemessaBaixar                    : ATipoOcorrencia := '02';
       toRemessaConcederAbatimento        : ATipoOcorrencia := '04';
       toRemessaCancelarAbatimento        : ATipoOcorrencia := '05';
       toRemessaAlterarVencimento         : ATipoOcorrencia := '06';
       toRemessaConcederDesconto          : ATipoOcorrencia := '07';
       toRemessaCancelarDesconto          : ATipoOcorrencia := '08';
       toRemessaProtestar                 : ATipoOcorrencia := '09';
       toRemessaCancelarInstrucaoProtesto : ATipoOcorrencia := '10';
       toRemessaDispensarJuros            : ATipoOcorrencia := '31';
    else
       ATipoOcorrencia := '01';
    end;

    { Pegando o Aceite do Titulo }
    case Aceite of
       atSim :  ATipoAceite := 'A';
       atNao :  ATipoAceite := 'N';
    end;

    {Pegando Tipo de Boleto} //Quem emite e quem distribui o boleto?
    case ACBrBoleto.Cedente.ResponEmissao of
         tbBancoEmite      : ATipoBoleto := '1' + '1';
         tbCliEmite        : ATipoBoleto := '2' + '2';
         tbBancoReemite    : ATipoBoleto := '4' + '1';
         tbBancoNaoReemite : ATipoBoleto := '5' + '2';
    end;

    {Mora Juros}
    if (ValorMoraJuros > 0) then
     begin
       if (DataMoraJuros <> Null) then
          ADataMoraJuros := FormatDateTime('ddmmyyyy', DataMoraJuros)
       else
          ADataMoraJuros := padR('', 8, '0');
     end
    else
       ADataMoraJuros := padR('', 8, '0');

    {Descontos}
    if (ValorDesconto > 0) then
     begin
       if (DataDesconto <> Null) then
          ADataDesconto := FormatDateTime('ddmmyyyy', DataDesconto)
       else
          ADataDesconto := padR('', 8, '0');
     end
    else
       ADataDesconto := padR('', 8, '0');

    Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //   1 a   3 - Código do banco
             '0001'                                                     + //   4 a   7 - Lote de Serviço
             '3'                                                        + //   8 a   8 - Tipo do registro: Registro detalhe
             IntToStrZero(ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)+ 1 ,5) + //   9 a  13 - Nº Sequencial do Registro no Lote
             'P'                                                        + //  14 a  14 - Cód. Segmento do Registro Detalhe
             ' '                                                        + //  15 a  15 - Uso Exclusivo FEBRABAN/CNAB
             ATipoOcorrencia                                            + //  16 a  17 - Código de Movimento Remessa
             padR(ACBrBoleto.Cedente.Agencia, 5, '0')                   + //  18 a  22 - Agência mantenedora da conta
             padR(ACBrBoleto.Cedente.AgenciaDigito, 1 , '0')            + //  23 a  23 - Dígito verificador da agência
             padR(ACBrBoleto.Cedente.CodigoCedente, 12, '0')            + //  24 a  35 - Código do Cedente
             ACodCedenteDV                                              + //  36 a  36 - Digito Verificador do Cedente
             CalcularDVAgCD                                             + //  37 a  37 - Digito Verificador da Ag. + Cedente
             space(9)                                                   + //  38 a  46 - Uso Exclusivo da CAIXA
             padR(ANossoNumero, 11, '0')                                + //  47 a  57 - Nosso número - identificação do título no banco
             '1'                                                        + //  58 a  58 - Código da Carteira: 10Cobrança Simples; 3-Cobrança Caucionada; 4-Cobrança Descontada
             '1'                                                        + //  59 a  59 - Forma de cadastramento do título no banco:  1-cobrança Registrada | 2-Cobrança sem registro
             '2'                                                        + //  60 a  60 - Tipo de documento: 1-Tradicional; 2-Escritural (Padrão 2)
             ATipoBoleto                                                + //  61 a  62 - Identificação da Emissão do Bloqueto
             padL(NumeroDocumento, 11, ' ')                             + //  63 a  73 - Número do Documento de Cobrança
             space(4)                                                   + //  74 a  77 - Uso Exclusivo CAIXA
             FormatDateTime('ddmmyyyy', Vencimento)                     + //  78 a  85 - Data de vencimento do título
             IntToStrZero(Round(ValorDocumento * 100), 15)              + //  86 a 100 - Valor nominal do título
             space(5)                                                   + // 101 a 105 - Agência cobradora. Se ficar em branco, a caixa determina automaticamente pelo CEP do sacado
             ' '                                                        + // 106 a 106 - DV Agência cobradora
             padL(EspecieDoc,2)                                         + // 107 a 108 - Espécie do documento
             ATipoAceite                                                + // 109 a 109 - Identificação de título Aceito / Não aceito
             FormatDateTime('ddmmyyyy', DataDocumento)                  + // 110 a 117 - Data da Emissão do Título
             IfThen(ValorMoraJuros > 0, '1', '0')                       + // 118 a 118 - Código de juros de mora: Valor por dia
             ADataMoraJuros                                             + // 119 a 126 - Data a partir da qual serão cobrados juros
             IfThen(ValorMoraJuros > 0,
                    IntToStrZero( round(ValorMoraJuros * 100), 15),
                    padR('', 15, '0'))                                  + // 127 a 141 - Valor de juros de mora por dia
             IfThen(ValorDesconto > 0, '1', '0')                        + // 142 a 142 - Código de desconto: Valor fixo até a data informada
             ADataDesconto                                              + // 143 a 150 - Data do desconto
             IfThen(ValorDesconto > 0,
                    IntToStrZero( round(ValorDesconto * 100), 15),
                    padR('', 15, '0'))                                  + // 151 a 165 - Valor do desconto por dia
             IntToStrZero( round(ValorIOF * 100), 15)                   + // 166 a 180 - Valor do IOF a ser recolhido
             IntToStrZero( round(ValorAbatimento * 100), 15)            + // 181 a 195 - Valor do abatimento
             padL(SeuNumero, 25, ' ')                                   + // 196 a 220 - Identificação do título na empresa
             IfThen((DataProtesto <> null) and
                    (DataProtesto > Vencimento), '1', '3')              + // 221 a 221 - Código de protesto: Protestar em XX dias corridos
             IfThen((DataProtesto <> null) and
                    (DataProtesto > Vencimento),
                     padL(IntToStr(DaysBetween(DataProtesto,
                     Vencimento)), 2, '0'), '00')                       + // 222 a 223 - Prazo para protesto (em dias corridos)
             '2'                                                        + // 224 a 224 - Código para baixa/devolução: Não baixar/não devolver
             padL('',3,'0')                                             + // 225 a 227 - Prazo para baixa/devolução (em dias corridos)
             '09'                                                       + // 228 a 229 - Código da moeda: Real
             Space(10)                                                  + // 230 a 239 - Uso Exclusivo FEBRABAN/CNAB
             Space(1);                                                    // 240 a 240 - Uso exclusivo FEBRABAN/CNAB
    {SEGMENTO Q}
    Result:= Result + #13#10 +
             IntToStrZero(ACBrBanco.Numero, 3)                          + //   1 a   3 - Código do banco
             '0001'                                                     + // 4 a 7 - Lote de Serviço
             '3'                                                        + //   8 a   8 - Tipo do registro: Registro detalhe
             IntToStrZero((2 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 2 ,5) + //   9 a  13 - Número do lote
             'Q'                                                        + //  14 a  14 - Código do segmento do registro detalhe
             ' '                                                        + //  15 a  15 - Uso exclusivo FEBRABAN/CNAB: Branco
             ATipoOcorrencia                                            + //  16 a  17 - Código de movimento
             {Dados do sacado}
             ATipoInscricao                                             + //  18 a  18 - Tipo inscricao
             padR(OnlyNumber(Sacado.CNPJCPF), 15, '0')                  + //  19 a  33 - Número de Inscrição
             padL(Sacado.NomeSacado, 40, ' ')                           + //  34 a  73 - Nome sacado
             padL(Sacado.Logradouro +' '+
                  Sacado.Numero +' '+
                  Sacado.Complemento , 40, ' ')                         + //  74 a 113 - Endereço
             padL(Sacado.Bairro, 15, ' ')                               + // 114 a 128 - bairro sacado
             padR(OnlyNumber(Sacado.CEP), 8, '0')                       + // 129 a 133 e 134 a 136- cep sacado prefixo e sufixo sem o traço"-" somente numeros
             padL(Sacado.Cidade, 15, ' ')                               + // 137 a 151 - cidade sacado
             padL(Sacado.UF, 2, ' ')                                    + // 152 a 153 - UF sacado
             {Dados do sacador/avalista}
             '0'                                                        + // 154 a 154  - Tipo de inscrição: Não informado
             space(15)                                                  + // 155 a 169 - Número de inscrição
             space(40)                                                  + // 170 a 209 - Nome do sacador/avalista
             space(3)                                                   + // 210 a 212 - Uso exclusivo FEBRABAN/CNAB
             space(20)                                                  + // 213 a 232 - Uso exclusivo FEBRABAN/CNAB
             space(8);                                                    // 233 a 240 - Uso exclusivo FEBRABAN/CNAB
    end;
end;

function TACBrCaixaEconomicaSICOB.GerarRegistroTrailler240( ARemessa : TStringList ): String;
begin
   {REGISTRO TRAILER DO LOTE}
   Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //    1 a   3 - Código do banco
            '9999'                                                     + //    7 a   4 - Lote de Serviço
            '5'                                                        + //    8 a   8 - Tipo do registro: Registro trailer do lote
            Space(9)                                                   + //    9 a  17 - Uso exclusivo FEBRABAN/CNAB
            IntToStrZero(ARemessa.Count, 6)                            + //   18 a  23 - Quantidade de Registro no Lote
            // Totalização Cobrança Simples
            padR('', 6, '0')                                           + //   24 a  29 - Quantidade títulos em cobrança (Somente retorno)
            padR('',17, '0')                                           + //   30 a  46 - Valor dos títulos em carteiras (Somente retorno)
            // CNAB
            padR('', 6, '0')                                           + //   47 a  52 - Uso Exclusivo FEBRABAN/CNAB
            padR('',17, '0')                                           + //   53 a  69 - Uso Exclusivo FEBRABAN/CNAB
            // Totalização Cobrança Caucionada
            padR('', 6, '0')                                           + //   70 a  75 - Quantidade títulos em cobrança (Somente retorno)
            padR('',17, '0')                                           + //   76 a  92 - Valor dos títulos em carteiras (Somente retorno)
            // Totalização Cobrança Descontada
            padR('', 6, '0')                                           + //   93 a  98 - Quantidade títulos em cobrança (Somente retorno)
            padR('',17, '0')                                           + //   99 a 115 - Valor dos títulos em carteiras (Somente retorno)
            space(8)                                                   + //  116 a 123 - Uso exclusivo FEBRABAN/CNAB
            space(117);                                                  //  124 a 240 - Uso exclusivo FEBRABAN/CNAB

   {GERAR REGISTRO TRAILER DO ARQUIVO}
   Result:= Result + #13#10 +
            IntToStrZero(ACBrBanco.Numero, 3)                          + //    1 a   3 - Código do banco
            '9999'                                                     + //    4 a   7 - Lote de serviço
            '9'                                                        + //    8 a   8 - Tipo do registro: Registro trailer do arquivo
            space(9)                                                   + //    9 a  17 - Uso exclusivo FEBRABAN/CNAB}
            '000001'                                                   + //   18 a  23 - Quantidade de lotes do arquivo}
            IntToStrZero(ARemessa.Count, 6)                            + //   24 a  29 - Quantidade de registros do arquivo, inclusive este registro que está sendo criado agora}
            space(6)                                                   + //   30 a  35 - Uso exclusivo FEBRABAN/CNAB}
            space(205);                                                  //   36 a 240 - Uso exclusivo FEBRABAN/CNAB}
end;

procedure TACBrCaixaEconomicaSICOB.LerRetorno240(ARetorno: TStringList);
var
  ContLinha: Integer;
  Titulo   : TACBrTitulo;
  Linha,
  rCedente,
  rCNPJCPF,
  rAgencia, rConta,rDigitoConta: String;
begin
   ContLinha := 0;

   if (copy(ARetorno.Strings[0],143,1) <> '2') then
      raise Exception.Create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
                             'não é um arquivo de retorno do '+ Nome));

   rAgencia     := trim(Copy(ARetorno[0],53,5));
   rConta       := trim(Copy(ARetorno[0],59,12));
   rDigitoConta := Copy(ARetorno[0],72,1);
   rCedente     := trim(Copy(ARetorno[0],73,30));


   ACBrBanco.ACBrBoleto.DataArquivo   := StringToDateTimeDef(Copy(ARetorno[0],144,2)+'/'+
                                                             Copy(ARetorno[0],146,2)+'/'+
                                                             Copy(ARetorno[0],148,4),0, 'DD/MM/YYYY' );

   ACBrBanco.ACBrBoleto.DataCreditoLanc := StringToDateTimeDef(Copy(ARetorno[1],200,2)+'/'+
                                                               Copy(ARetorno[1],202,2)+'/'+
                                                               Copy(ARetorno[1],204,4),0, 'DD/MM/YYYY' );
   rCNPJCPF := trim( Copy(ARetorno[1],19,15)) ;

   with ACBrBanco.ACBrBoleto do
   begin
     if (not LeCedenteRetorno) and (rCNPJCPF <> OnlyNumber(Cedente.CNPJCPF)) then
        raise Exception.Create(ACBrStr('CNPJ\CPF do arquivo inválido'));

     if (not LeCedenteRetorno) and ((rAgencia <> OnlyNumber(Cedente.Agencia)) or
         (rConta <> OnlyNumber(Cedente.Conta))) then
        raise Exception.Create(ACBrStr('Agencia\Conta do arquivo inválido'));

     Cedente.Nome    := rCedente;
     Cedente.CNPJCPF := rCNPJCPF;
     Cedente.Agencia := rAgencia;
     Cedente.AgenciaDigito:= '0';
     Cedente.Conta   := rConta;
     Cedente.ContaDigito:= rDigitoConta;

     case StrToIntDef(Copy(ARetorno[1],18,1),0) of
       1: Cedente.TipoInscricao:= pFisica;
       2: Cedente.TipoInscricao:= pJuridica;
       else
          Cedente.TipoInscricao := pOutras;
     end;
     ListadeBoletos.Clear;
   end;

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha] ;

      if Copy(Linha,14,1)= 'T' then //segmento T - Só cria após passar pelo seguimento T depois U
        Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin
        if Copy(Linha,14,1)= 'T' then //segmento T
        begin
          SeuNumero                   := copy(Linha,59,11);
          // Nosso número com até 16 digitos
          NumeroDocumento             := copy(Linha,106,25);
          NossoNumero                 := Copy(Copy(Linha,47,10), // sem o DV
                                              Length(Copy(Linha,47,10))-TamanhoMaximoNossoNum ,
                                              TamanhoMaximoNossoNum);
          OcorrenciaOriginal.Tipo     := CodOcorrenciaToTipo(StrToIntDef(
                                                             copy(Linha,16,2),0));
          Vencimento := StringToDateTimeDef( Copy(Linha,74,2)+'/'+
                                             Copy(Linha,76,2)+'/'+
                                             Copy(Linha,78,4),0, 'DD/MM/YYYY' );
          ValorDocumento       := StrToFloatDef(Copy(Linha,82,15),0)/100;
          ValorRecebido        := StrToFloatDef(Copy(Linha,82,15),0)/100;
          ValorDespesaCobranca := StrToFloatDef(Copy(Linha,199,15),0)/100;
          // Carteira             := Copy(Linha,40,2);
          // No SICOB não retorna o numero da carteira. Retorna o seguinte:
          // 1 = Cobrança Simples
          // 3 = Cobrança Caucionada
          // 4 = Cobrança Descontada
        end
        else
        if Copy(Linha,14,1)= 'U' then //segmento U
        begin
          if StrToIntDef(Copy(Linha,138,8),0) <> 0 then
             DataOcorrencia := StringToDateTimeDef( Copy(Linha,138,2)+'/'+
                                                 Copy(Linha,140,2)+'/'+
                                                 Copy(Linha,142,4),0, 'DD/MM/YYYY' );

          if StrToIntDef(Copy(Linha,146,8),0) <> 0 then
             DataCredito:= StringToDateTimeDef( Copy(Linha,146,2)+'/'+
                                                Copy(Linha,148,2)+'/'+
                                                Copy(Linha,150,4),0, 'DD/MM/YYYY' );

          ValorMoraJuros       := StrToFloatDef(Copy(Linha,18,15),0)/100;
          ValorDesconto        := StrToFloatDef(Copy(Linha,33,15),0)/100;
          ValorAbatimento      := StrToFloatDef(Copy(Linha,48,15),0)/100;
          ValorIOF             := StrToFloatDef(Copy(Linha,63,15),0)/100;
          ValorOutrasDespesas  := StrToFloatDef(Copy(Linha,108,15),0)/100;
          ValorOutrosCreditos  := StrToFloatDef(Copy(Linha,123,15),0)/100;
        end;//if Copy(Linha,14,1)= 'U' then //segmento U
      end; //with
   end; //for
end;


end.
