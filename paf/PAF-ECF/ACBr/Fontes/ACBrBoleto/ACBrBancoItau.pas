{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   Juliana Rodrigues Prado                       }
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
{$I ACBr.inc}

unit ACBrBancoItau;

interface

uses
  Classes, SysUtils, ACBrBoleto,
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type
  { TACBrBancoItau}

  TACBrBancoItau = class(TACBrBancoClass)
   protected
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override ;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoNossoNumero ( const ACBrTitulo: TACBrTitulo) : String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroHeader240(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa : TStringList): String;  override;
    function GerarRegistroHeader400(NumeroRemessa : Integer): String; override;     //Implementado por Carlos Fitl - 22/12/2010
    function GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo): String; override; //Implementado por Carlos Fitl - 22/12/2010
    function GerarRegistroTrailler400(ARemessa : TStringList): String;  override;   //Implementado por Carlos Fitl - 22/12/2010
    Procedure LerRetorno400(ARetorno:TStringList); override;                        //Implementado por Carlos Fitl - 22/12/2010

    function TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia) : String; override;
    function CodOcorrenciaToTipo(const CodOcorrencia:Integer): TACBrTipoOcorrencia; override;
    function TipoOCorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia):String; override;
    function CodMotivoRejeicaoToDescricao(const TipoOcorrencia:TACBrTipoOcorrencia; CodMotivo:Integer): String; override;
   end;

implementation

uses ACBrUtil, StrUtils, Variants,ACBrValidador;

constructor TACBrBancoItau.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 7;
   fpNome   := 'Banco Itau';
   fpNumero:= 341;
   fpTamanhoMaximoNossoNum := 8;
   fpTamanhoAgencia := 4;
   fpTamanhoConta   := 5;
   fpTamanhoCarteira:= 3;
end;

function TACBrBancoItau.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
var
  Docto: String;
begin
   Result := '0';
   Docto := '';

   with ACBrTitulo do
   begin
      Docto := Carteira + padR(NossoNumero,TamanhoMaximoNossoNum,'0');
      if not ((Carteira = '126') or (Carteira = '131') or (Carteira = '146') or
             (Carteira = '150') or (Carteira = '168')) then
         Docto := ACBrBoleto.Cedente.Agencia + ACBrBoleto.Cedente.Conta + docto
      else
         Docto := ACBrTitulo.ACBrBoleto.Cedente.Agencia +
                  ACBrTitulo.ACBrBoleto.Cedente.Conta +
                  ACBrTitulo.Carteira +
                  padR(ACBrTitulo.NossoNumero,TamanhoMaximoNossoNum,'0')
   end;

   Modulo.MultiplicadorInicial := 1;
   Modulo.MultiplicadorFinal   := 2;
   Modulo.MultiplicadorAtual   := 2;
   Modulo.FormulaDigito := frModulo10;
   Modulo.Documento:= Docto;
   Modulo.Calcular;
   Result := IntToStr(Modulo.DigitoFinal);
 
end;

function TACBrBancoItau.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras :String;
  ANossoNumero, aAgenciaCC : string;
begin
    {Codigo de Barras}
    with ACBrTitulo.ACBrBoleto do
    begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      ANossoNumero := ACBrTitulo.Carteira +
                      padR(ACBrTitulo.NossoNumero,8,'0') +
                      CalcularDigitoVerificador(ACBrTitulo);

      aAgenciaCC   := Cedente.Agencia +
                      Cedente.Conta   +
                      Cedente.ContaDigito;

      CodigoBarras := IntToStr( Numero ) +
                      '9' +
                      FatorVencimento +
                      IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                      ANossoNumero +
                      aAgenciaCC +
                      '000';

     DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
    end;
    Result:= copy( CodigoBarras, 1, 4) + DigitoCodBarras + copy( CodigoBarras, 5, 39) ;
end;

function TACBrBancoItau.MontarCampoNossoNumero ( const ACBrTitulo: TACBrTitulo
   ) : String;
var
  NossoNr: String;
begin
  with ACBrTitulo do
  begin
    NossoNr := Carteira + padR(NossoNumero,TamanhoMaximoNossoNum,'0');
  end;
  Insert('/',NossoNr,4);  Insert('-',NossoNr,13);
  Result := NossoNr + CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoItau.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'/'+
            ACBrTitulo.ACBrBoleto.Cedente.Conta+'-'+
            ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBancoItau.GerarRegistroHeader240(NumeroRemessa : Integer): String;
var
  ATipoInscricao: string;
begin

   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      case TipoInscricao of
         pFisica  : ATipoInscricao := '1';
         pJuridica: ATipoInscricao := '2';
         pOutras  : ATipoInscricao := '3';
      end;

          { GERAR REGISTRO-HEADER DO ARQUIVO }

      Result:= IntToStrZero(ACBrBanco.Numero, 3)        + //1 a 3 - Código do banco
               '0000'                                   + //4 a 7 - Lote de serviço
               '0'                                      + //8 - Tipo de registro - Registro header de arquivo
               space(9)                                 + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                           + //18 - Tipo de inscrição do cedente
               padR(OnlyNumber(CNPJCPF), 14, '0')                   + //19 a 32 -Número de inscrição do cedente
               space(20)                                + // 33 a 52 - Brancos
               '0'                                      + // 53 - Zeros
               padR(Agencia, 4, '0')                    + //54 a 57 - Código da agência do cedente
               ' '                                      + // 58 - Brancos
               '0000000'                                + // 59 a 65 - Zeros
               padR(Conta, 5, '0')                      + // 66 a 70 - Número da conta do cedente
               ' '                                      + // 71 - Branco
               padR(ContaDigito, 1, '0')                + // 72 - Dígito da conta do cedente
               padL(Nome, 30, ' ')                      + // 73 a 102 - Nome do cedente
               padL('BANCO ITAU SA', 30, ' ')           + // 103 a 132 - Nome do banco
               space(10)                                + // 133 A 142 - Brancos
               '1'                                      + // 143 - Código de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)          + // 144 a 151 - Data do de geração do arquivo
               FormatDateTime('hhmmss', Now)            + // 152 a 157 - Hora de geração do arquivo
               '000000'                                 + // 158 a 163 - Número sequencial do arquivo retorno
               '040'                                    + // 164 a 166 - Número da versão do layout do arquivo
               '00000'                                  + // 167 a 171 - Zeros
               space(54)                                + // 172 a 225 - 54 Brancos
               '000'                                    + // 226 a 228 - zeros
               space(12);                                 // 229 a 240 - Brancos

     { GERAR REGISTRO HEADER DO LOTE }

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
               '0001'                                  + //4 a 7 - Lote de serviço
               '1'                                     + //8 - Tipo de registro - Registro header de arquivo
               'R'                                     + //9 - Tipo de operação: R (Remessa) ou T (Retorno)
               '01'                                    + //10 a 11 - Tipo de serviço: 01 (Cobrança)
               '00'                                    + //12 a 13 - Forma de lançamento: preencher com ZEROS no caso de cobrança
               '030'                                   + //14 a 16 - Número da versão do layout do lote
               ' '                                     + //17 - Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscrição do cedente
               padR(OnlyNumber(CNPJCPF), 15, '0')      + //19 a 33 -Número de inscrição do cedente
               space(20)                               + //34 a 53 - Brancos
               '0'                                     + // 54 - Zeros
               padR(Agencia, 4, '0')                   + //55 a 58 - Código da agência do cedente
               ' '                                     + // 59
               '0000000'                               + // 60 a 66
               padR(Conta, 5, '0')                     + //67 a 71 - Número da conta do cedente
               ' '                                     + // 72
               ContaDigito                             + // 73 - Dígito verificador da agência / conta
               padL(Nome, 30, ' ')                     + //74 a 103 - Nome do cedente
               space(80)                               + // 104 a 183 - Brancos
               '00000000'                              + // 184 a 191 - Número sequência do arquivo retorno.
               FormatDateTime('ddmmyyyy', Now)         + //192 a 199 - Data de geração do arquivo
               padR('', 8, '0')                        + //200 a 207 - Data do crédito - Só para arquivo retorno
               space(33);                                //208 a 240 - Uso exclusivo FEBRABAN/CNAB
   end;
end;

function TACBrBancoItau.GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String;
var ATipoInscricao, ATipoOcorrencia, ATipoBoleto, ADataMoraJuros, 
    ADataDesconto,ATipoAceite : string;
begin
   with ACBrTitulo do
   begin
         {SEGMENTO P}

         {Pegando o Tipo de Ocorrencia}
         case OcorrenciaOriginal.Tipo of
            toRemessaBaixar                    : ATipoOcorrencia := '02';
            toRemessaConcederAbatimento        : ATipoOcorrencia := '04';
            toRemessaCancelarAbatimento        : ATipoOcorrencia := '05';
            toRemessaAlterarVencimento         : ATipoOcorrencia := '06';
          //  toRemessaConcederDesconto          : ATipoOcorrencia := '07';
          //  toRemessaCancelarDesconto          : ATipoOcorrencia := '08';
            toRemessaSustarProtesto            : ATipoOcorrencia := '18';
            toRemessaCancelarInstrucaoProtesto : ATipoOcorrencia := '10';
          //  toRemessaAlterarNomeEnderecoSacado : ATipoOcorrencia := '12';

          //  toRemessaDispensarJuros            : ATipoOcorrencia := '31';
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
              tbCliEmite        : ATipoBoleto := '1' + '1';
              tbBancoEmite      : ATipoBoleto := '2' + '2';
              tbBancoReemite    : ATipoBoleto := '4' + '1';
              tbBancoNaoReemite : ATipoBoleto := '5' + '2';
         end;

         {Mora Juros}
         if (ValorMoraJuros > 0) then
         begin
             if   (DataMoraJuros <> Null) then
                  ADataMoraJuros := FormatDateTime('ddmmyyyy', DataMoraJuros)
             else ADataMoraJuros := padR('', 8, '0');
         end else ADataMoraJuros := padR('', 8, '0');

         {Descontos}
         if (ValorDesconto > 0) then
         begin
            if    (DataDesconto <> Null) then
                  ADataDesconto := FormatDateTime('ddmmyyyy', DataDesconto)
            else  ADataDesconto := padR('', 8, '0');
         end else ADataDesconto := padR('', 8, '0');

      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - Código do banco
               '0001'                                                     + //4 a 7 - Lote de serviço
               '3'                                                        + //8 - Tipo do registro: Registro detalhe
               IntToStrZero(ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)+ 1 ,5) + //9 a 13 - Número seqüencial do registro no lote - Cada registro possui dois segmentos
               'P'                                                        + //14 - Código do segmento do registro detalhe
               ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //16 a 17 - Código de movimento
               '0'                                                        + // 18
               ACBrBoleto.Cedente.Agencia                                 + //19 a 22 - Agência mantenedora da conta
               ' '                                                        + // 23
               '0000000'                                                  + //24 a 30 - Complemento de Registro
               ACBrBoleto.Cedente.Conta                                   + //31 a 35 - Número da Conta Corrente
               ' '                                                        + // 36
               ACBrBoleto.Cedente.ContaDigito                             + //37 - Dígito verificador da agência / conta
               Carteira                                                   + // 38 a 40 - Carteira
               padR(NossoNumero, 8, '0')                                  + // 41 a 48 - Nosso número - identificação do título no banco
               CalcularDigitoVerificador(ACBrTitulo)                      + // 49 - Dígito verificador da agência / conta preencher somente em cobrança sem registro
               space(8)                                                   + // 50 a 57 - Brancos
               padL('', 5, '0')                                           + // 58 a 62 - Complemento
               padL(NumeroDocumento, 10, ' ')                             + // 63 a 72 - Número que identifica o título na empresa [ Alterado conforme instruções da CSO Brasília ] {27-07-09}

               space(5)                                                   + // 73 a 77 - Brancos
               FormatDateTime('ddmmyyyy', Vencimento)                     + // 78 a 85 - Data de vencimento do título
               IntToStrZero( round( ValorDocumento * 100), 15)            + // 86 a 100 - Valor nominal do título
               '00000'                                                    + // 101 a 105 - Agência cobradora. // Ficando com Zeros o Itaú definirá a agência cobradora pelo CEP do sacado
               ' '                                                        + // 106 - Dígito da agência cobradora
               padL(EspecieDoc,2)                                                 + // 107 a 108 - Espécie do documento
               ATipoAceite                             + // 109 - Identificação de título Aceito / Não aceito
               FormatDateTime('ddmmyyyy', DataDocumento)                  + // 110 a 117 - Data da emissão do documento
               '0'                                                        + // 118 - Zeros
               ADataMoraJuros                                             + //119 a 126 - Data a partir da qual serão cobrados juros
               IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15),
                padR('', 15, '0'))                                        + //127 a 141 - Valor de juros de mora por dia
//               ValorMoraJuros                                             + //127 a 141 - Valor de Mora por dia de atraso
               '0'                                                        + // 142 - Zeros
               ADataDesconto                                             + // 143 a 150 - Data limite para desconto
               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),
               padR('', 15, '0'))                                         + //151 a 165 - Valor do desconto por dia
               IntToStrZero( round(ValorIOF * 100), 15)                   + //166 a 180 - Valor do IOF a ser recolhido
               IntToStrZero( round(ValorAbatimento * 100), 15)            + //181 a 195 - Valor do abatimento
               padL(SeuNumero, 25, ' ')                                   + //196 a 220 - Identificação do título na empresa
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento), '1', '3') + //221 - Código de protesto: Protestar em XX dias corridos
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                    padR(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00') + //222 a 223 - Prazo para protesto (em dias corridos)
               '0'                                                        + // 224 - Código de Baixa
               '00'                                                       + // 225 A 226 - Dias para baixa
               '0000000000000 ';

      {SEGMENTO Q}

         {Pegando tipo de pessoa do Sacado}
         case Sacado.Pessoa of
            pFisica  : ATipoInscricao := '1';
            pJuridica: ATipoInscricao := '2';
            pOutras  : ATipoInscricao := '9';
         end;

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '0001'                                                     + //Número do lote
               '3'                                                        + //Tipo do registro: Registro detalhe
               IntToStrZero((ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 1 ,5) + //Número seqüencial do registro no lote - Cada registro possui dois segmentos
               'Q'                                                        + //Código do segmento do registro detalhe
               ' '                                                        + //Uso exclusivo FEBRABAN/CNAB: Branco
               '01'                                                       + // 16 a 17
                        {Dados do sacado}
               ATipoInscricao                                             + // 18 a 18 Tipo inscricao
               padR(OnlyNumber(Sacado.CNPJCPF), 15, '0')                  + // 19 a 33
               padL(Sacado.NomeSacado, 30, ' ')                           + // 34 a 63
               space(10)                                                  + // 64 a 73
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') + // 74 a 113
               padL(Sacado.Bairro, 15, ' ')                               +  // 114 a 128
               padR(Sacado.CEP, 8, '0')                                   +  // 129 a 136
               padL(Sacado.Cidade, 15, ' ')                               +  // 137 a 151
               padL(Sacado.UF, 2, ' ')                                    +  // 152 a 153
                        {Dados do sacador/avalista}
               '0'                                                        + //Tipo de inscrição: Não informado
               padR('', 15, '0')                                          + //Número de inscrição
               padL('', 30, ' ')                                          + //Nome do sacador/avalista
               space(10)                                                  + //Uso exclusivo FEBRABAN/CNAB
               padL('0',3, '0')                                           + //Uso exclusivo FEBRABAN/CNAB
               space(28);                                            //Uso exclusivo FEBRABAN/CNAB
      end;
end;

function TACBrBancoItau.GerarRegistroTrailler240( ARemessa : TStringList ): String;
begin
          {REGISTRO TRAILER DO LOTE}
      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '0001'                                                     + //Número do lote
               '5'                                                        + //Tipo do registro: Registro trailer do lote
               Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
               IntToStrZero(ARemessa.Count, 6)                            + //Quantidade de Registro da Remessa
               padR('', 6, '0')                                           + // Quantidade de títulos em cobrança simples
               padR('',17, '0')                                           + //Valor dos títulos em cobrança simples
               padR('', 6, '0')                                           + //Quantidade títulos em cobrança vinculada
               padR('',17, '0')                                           + //Valor dos títulos em cobrança vinculada
               padR('',46, '0')                                           + //Complemento
               padL('', 8, ' ')                                           + //Referencia do aviso bancario
               space(117);

          {GERAR REGISTRO TRAILER DO ARQUIVO}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '9999'                                                     + //Lote de serviço
               '9'                                                        + //Tipo do registro: Registro trailer do arquivo
               space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB}
               '000001'                                                   + //Quantidade de lotes do arquivo}
               IntToStrZero(ARemessa.Count, 6)                            + //Quantidade de registros do arquivo, inclusive este registro que está sendo criado agora}
               padR('', 6, '0')                                           + //Complemento
               space(205);
//      Result := Result + #13#10;
end;

function TACBrBancoItau.GerarRegistroHeader400(
  NumeroRemessa: Integer): String;
var
  ATipoInscricao: string;
begin
   with ACBrBanco.ACBrBoleto.Cedente do
   begin

      { GERAR REGISTRO-HEADER DO ARQUIVO }
      Result:=    '0'                                  + // 1 a 1     - IDENTIFICAÇÃO DO REGISTRO HEADER
                  '1'                                  + // 2 a 2     - TIPO DE OPERAÇÃO - REMESSA
                  'REMESSA'                            + // 3 a 9     - IDENTIFICAÇÃO POR EXTENSO DO MOVIMENTO
                  '01'                                 + // 10 a 11   - IDENTIFICAÇÃO DO TIPO DE SERVIÇO
                  padL('COBRANCA',15, ' ')             + // 12 a 26   - IDENTIFICAÇÃO POR EXTENSO DO TIPO DE SERVIÇO
                  padR(Agencia, 4, '0')                + // 27 a 30   - AGÊNCIA MANTENEDORA DA CONTA
                  '00'                                 + // 31 a 32   - COMPLEMENTO DE REGISTRO
                  padR(Conta, 5, '0')                  + // 33 a 37   - NÚMERO DA CONTA CORRENTE DA EMPRESA
                  padR(ContaDigito, 1, '0')            + // 38 a 38   - DÍGITO DE AUTO CONFERÊNCIA AG/CONTA EMPRESA
                  space(8)                             + // 39 a 46   - COMPLEMENTO DO REGISTRO
                  padL(Nome, 30, ' ')                  + // 47 a 76   - NOME POR EXTENSO DA "EMPRESA MÃE"
                  IntToStrZero(ACBrBanco.Numero, 3)    + // 77 a 79   - Nº DO BANCO NA CÂMARA DE COMPENSAÇÃO
                  padL('BANCO ITAU SA', 15, ' ')       + // 80 a 94   - NOME POR EXTENSO DO BANCO COBRADOR
                  FormatDateTime('ddmmyy', Now)        + // 95 a 100  - DATA DE GERAÇÃO DO ARQUIVO
                  space(294)                           + // 101 a 394 - COMPLEMENTO DO REGISTRO
                  IntToStrZero(1,6);                     // 395 a 400 - NÚMERO SEQÜENCIAL DO REGISTRO NO ARQUIVO
      Result:= UpperCase(Result);
   end;
end;

//Implementado por Carlos Fitl - 22/12/2010
function TACBrBancoItau.GerarRegistroTransacao400(
  ACBrTitulo: TACBrTitulo): String;
var
ATipoCedente,
ATipoSacado,
ATipoOcorrencia,
ATipoBoleto ,
ADataMoraJuros,
ADataDesconto,
ATipoAceite,
ATipoEspecieDoc : string;
ANossoNumero: String;
  function DoMontaInstrucoes1(const AStr: string): string;
  begin
    Result := '';
    with ACBrTitulo, ACBrBoleto do
    begin
      if Mensagem.Count = 0 then
        Exit; // Nenhum mensagem especificada. Registro não será necessário gerar o registro

      Result := AStr + #13#10 +
                '6'                                     +                 // IDENTIFICAÇÃO DO REGISTRO
                '2'                                     +                 // IDENTIFICAÇÃO DO LAYOUT PARA O REGISTRO
                Copy(padL(Mensagem[0], 69, ' '), 1, 69);                  // CONTEÚDO DA 1ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES” DO BOLETO

      if Mensagem.Count >= 2 then
        Result := Result +
                  Copy(padL(Mensagem[1], 69, ' '), 1, 69)                 // CONTEÚDO DA 2ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES” DO BOLETO
      else
        Result := Result +
                  padL('', 69, ' ');                                      // CONTEÚDO DO RESTANTE DAS LINHAS

      if Mensagem.Count >= 3 then
        Result := Result +
                  Copy(padL(Mensagem[2], 69, ' '), 1, 69)                 // CONTEÚDO DA 3ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES” DO BOLETO
      else
        Result := Result +
                  padL('', 69, ' ');                                      // CONTEÚDO DO RESTANTE DAS LINHAS

      if Mensagem.Count >= 4 then
        Result := Result +
                  Copy(padL(Mensagem[3], 69, ' '), 1, 69)                 // CONTEÚDO DA 4ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES” DO BOLETO
      else
        Result := Result +
                  padL('', 69, ' ');                                      // CONTEÚDO DO RESTANTE DAS LINHAS

      if Mensagem.Count >= 5 then
        Result := Result +
                  Copy(padL(Mensagem[4], 69, ' '), 1, 69)                 // CONTEÚDO DA 5ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES” DO BOLETO
      else
        Result := Result +
                  padL('', 69, ' ');                                      // CONTEÚDO DO RESTANTE DAS LINHAS

      Result := Result +
                space(47) +                                               // COMPLEMENTO DO REGISTRO
                IntToStrZero(ListadeBoletos.IndexOf(ACBrTitulo)+
                             ListadeBoletos.IndexOf(ACBrTitulo)+ 3, 6);   // Nº SEQÜENCIAL DO REGISTRO NO ARQUIVO
    end;              
  end;

  function DoMontaInstrucoes2(const AStr: string): string;
  begin
    // Implementado, mas opcional.
    // Ao utilizarmos a impressão do boleto pelo componente, apenas 5 linhas
    // são impressas.
    // Por padrão, essa rotina não será chamada
    
    Result := '';
    with ACBrTitulo, ACBrBoleto do
    begin
      if Mensagem.Count <= 5 then
        Exit; // Nenhum mensagem especificada. Registro não será necessário gerar o registro

      Result := AStr + #13#10 +
                '6'                                     +                 // IDENTIFICAÇÃO DO REGISTRO
                '3'                                     +                 // IDENTIFICAÇÃO DO LAYOUT PARA O REGISTRO
                Copy(padL(Mensagem[5], 69, ' '), 1, 69);                  // CONTEÚDO DA 6ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES” DO BOLETO

      if Mensagem.Count >= 7 then
        Result := Result +
                  Copy(padL(Mensagem[6], 69, ' '), 1, 69)                 // CONTEÚDO DA 7ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES” DO BOLETO
      else
        Result := Result +
                  padL('', 69, ' ');                                      // CONTEÚDO DO RESTANTE DAS LINHAS

      if Mensagem.Count >= 8 then
        Result := Result +
                  Copy(padL(Mensagem[7], 69, ' '), 1, 69)                 // CONTEÚDO DA 8ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES” DO BOLETO
      else
        Result := Result +
                  padL('', 69, ' ');                                      // CONTEÚDO DO RESTANTE DAS LINHAS

      if Mensagem.Count >= 9 then
        Result := Result +
                  Copy(padL(Mensagem[8], 69, ' '), 1, 69)                 // CONTEÚDO DA 9ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES” DO BOLETO
      else
        Result := Result +
                  padL('', 69, ' ');                                      // CONTEÚDO DO RESTANTE DAS LINHAS

      Result := Result +
                space(116)                               +                 // COMPLEMENTO DO REGISTRO
                IntToStrZero(ListadeBoletos.IndexOf(ACBrTitulo)+
                             ListadeBoletos.IndexOf(ACBrTitulo)+ 4, 6);   // Nº SEQÜENCIAL DO REGISTRO NO ARQUIVO
    end;
  end;

begin
  with ACBrTitulo do
  begin
    {Pegando o Tipo de Ocorrencia}
    case OcorrenciaOriginal.Tipo of
      toRemessaBaixar                       : ATipoOcorrencia := '02';
      toRemessaConcederAbatimento           : ATipoOcorrencia := '04';
      toRemessaCancelarAbatimento           : ATipoOcorrencia := '05';
      toRemessaAlterarVencimento            : ATipoOcorrencia := '06';
      toRemessaAlterarUsoEmpresa            : ATipoOcorrencia := '07';
      toRemessaAlterarSeuNumero             : ATipoOcorrencia := '08';
      toRemessaProtestar                    : ATipoOcorrencia := '09';
      toRemessaNaoProtestar                 : ATipoOcorrencia := '10';
      toRemessaProtestoFinsFalimentares     : ATipoOcorrencia := '11';
      toRemessaSustarProtesto               : ATipoOcorrencia := '18';
      toRemessaOutrasAlteracoes             : ATipoOcorrencia := '31';
      toRemessaBaixaporPagtoDiretoCedente   : ATipoOcorrencia := '34';
      toRemessaCancelarInstrucao            : ATipoOcorrencia := '35';
      toRemessaAlterarVencSustarProtesto    : ATipoOcorrencia := '37';
      toRemessaCedenteDiscordaSacado        : ATipoOcorrencia := '38';
      toRemessaCedenteSolicitaDispensaJuros : ATipoOcorrencia := '47';
    else
      ATipoOcorrencia := '01';
    end;

    { Pegando o Aceite do Titulo }
    case Aceite of
      atSim :  ATipoAceite := 'A';
      atNao :  ATipoAceite := 'N';
    end;

    {Pegando o tipo de EspecieDoc }
    if trim(EspecieDoc) = 'DM' then
       ATipoEspecieDoc:= '01'
    else if trim(EspecieDoc) = 'NP' then
       ATipoEspecieDoc:= '02'
    else if trim(EspecieDoc) = 'NS' then
       ATipoEspecieDoc:= '03'
    else if trim(EspecieDoc) = 'ME' then
       ATipoEspecieDoc:= '04'
    else if trim(EspecieDoc) = 'RC' then
       ATipoEspecieDoc:= '05'
    else if trim(EspecieDoc) = 'CT' then
       ATipoEspecieDoc:= '06'
    else if trim(EspecieDoc) = 'CS' then
       ATipoEspecieDoc:= '07'
    else if trim(EspecieDoc) = 'DS' then
       ATipoEspecieDoc:= '08'
    else if trim(EspecieDoc) = 'LC' then
       ATipoEspecieDoc:= '09'
    else if trim(EspecieDoc) = 'ND' then
       ATipoEspecieDoc:= '13'
    else if trim(EspecieDoc) = 'DD' then
       ATipoEspecieDoc:= '15'
    else if trim(EspecieDoc) = 'EC' then
       ATipoEspecieDoc:= '16'
    else if trim(EspecieDoc) = 'PS' then
       ATipoEspecieDoc:= '17'
    else if trim(EspecieDoc) = 'DV' then
       ATipoEspecieDoc:= '99';

    {Pegando Tipo de Boleto} //Quem emite e quem distribui o boleto?
    case ACBrBoleto.Cedente.ResponEmissao of
      tbCliEmite        : ATipoBoleto := '1' + '1';
      tbBancoEmite      : ATipoBoleto := '2' + '2';
      tbBancoReemite    : ATipoBoleto := '4' + '1';
      tbBancoNaoReemite : ATipoBoleto := '5' + '2';
    end;

    {Mora Juros}
    if (ValorMoraJuros > 0) then
    begin
      if (DataMoraJuros <> Null) then
        ADataMoraJuros := FormatDateTime('ddmmyy', DataMoraJuros)
      else
        ADataMoraJuros := padR('', 6, '0');
    end
    else
      ADataMoraJuros := padR('', 6, '0');

    {Descontos}
    if (ValorDesconto > 0) then
    begin
      if (DataDesconto <> Null) then
        ADataDesconto := FormatDateTime('ddmmyy', DataDesconto)
      else
        ADataDesconto := padR('', 6, '0');
    end
    else
      ADataDesconto := padR('', 6, '0');

      {Pegando Tipo de Cedente}
    case ACBrBoleto.Cedente.TipoInscricao of
      pFisica   : ATipoCedente := '01';
      pJuridica : ATipoCedente := '02';
    end;

    {Pegando Tipo de Sacado}
    case Sacado.Pessoa of
      pFisica   : ATipoSacado := '01';
      pJuridica : ATipoSacado := '02';
    else
      ATipoSacado := '99';
    end;
    
    with ACBrBoleto do
    begin // Cobrança sem registro com opção de envio de arquivo remessa
      if (Trim(Carteira) = '102') or
         (Trim(Carteira) = '103') or
         (Trim(Carteira) = '107') or
         (Trim(Carteira) = '172') or
         (Trim(Carteira) = '173') or
         (Trim(Carteira) = '196') then
      begin // by Jéter Rabelo Ferreira (27/05/2011)
        ANossoNumero := MontarCampoNossoNumero(ACBrTitulo);
        Result:= '6'                                                                          + // 6 - FIXO
               '1'                                                                            + // 1 - FIXO
               padR(OnlyNumber(Cedente.Agencia), 4, '0')                                      + // AGÊNCIA MANTENEDORA DA CONTA
               '00'                                                                           + // COMPLEMENTO DE REGISTRO
               padR(Cedente.Conta, 5, '0')                                                    + // NÚMERO DA CONTA CORRENTE DA EMPRESA
               padL(Cedente.ContaDigito, 1)                                                   + // DÍGITO DE AUTO CONFERÊNCIA AG/CONTA EMPRESA
               Carteira                                                                       + // NÚMERO DA CARTEIRA NO BANCO
               padR(NossoNumero, 8, '0')                                                      + // IDENTIFICAÇÃO DO TÍTULO NO BANCO
               Copy(ANossoNumero, Length(ANossoNumero), 1)                                    + // DAC DO NOSSO NÚMERO
               '0'                                                                            + // 0 - R$
               padL('R$', 4, ' ')                                                             + // LITERAL DE MOEDA
               IntToStrZero( round( ValorDocumento * 100), 13)                                + // VALOR NOMINAL DO TÍTULO
               padL(SeuNumero, 10, ' ')                                                       + // IDENTIFICAÇÃO DO TÍTULO NA EMPRESA
               FormatDateTime('ddmmyy', Vencimento)                                           + // DATA DE VENCIMENTO DO TÍTULO
               padR(ATipoEspecieDoc, 2, '0')                                                  + // ESPÉCIE DO TÍTULO
               ATipoAceite                                                                    + // IDENTIFICAÇÃO DE TITILO ACEITO OU NÃO ACEITO
               FormatDateTime('ddmmyy', DataDocumento)                                        + // DATA DE EMISSÃO
               {Dados do sacado}
               ATipoSacado                                                                    + // IDENTIFICAÇÃO DO TIPO DE INSCRIÇÃO/SACADO
               padR(OnlyNumber(Sacado.CNPJCPF), 15, '0')                                      + // Nº DE INSCRIÇÃO DO SACADO  (CPF/CGC)
               padL(Sacado.NomeSacado, 30, ' ')                                               + // NOME DO SACADO
               space(9)                                                                       + // BRANCOS(COMPLEMENTO DE REGISTRO)
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') + // RUA, NÚMERO E COMPLEMENTO DO SACADO
               padL(Sacado.Bairro, 12, ' ')                                                   + // BAIRRO DO SACADO
               padR(OnlyNumber(Sacado.CEP), 8, '0')                                           + // CEP DO SACADO
               padL(Sacado.Cidade, 15, ' ')                                                   + // CIDADE DO SACADO
               padL(Sacado.UF, 2, ' ')                                                        + // UF DO SACADO
               {Dados do sacador/avalista}
               padL('', 30, ' ')                                                              + // NOME DO SACADOR/AVALISTA
               space(4)                                                                       + // COMPLEMENTO DO REGISTRO
               padL(LocalPagamento, 55, ' ')                                                  + // LOCAL PAGAMENTO
               padL('', 55, ' ')                                                              + // LOCAL PAGAMENTO 2
               '01'                                                                           + // IDENTIF. TIPO DE INSCRIÇÃO DO SACADOR/AVALISTA
               padL('0', 15, '0')                                                             + // NÚMERO DE INSCRIÇÃO DO SACADOR/AVALISTA
               space(31)                                                                      + // COMPLEMENTO DO REGISTRO
               IntToStrZero(ListadeBoletos.IndexOf(ACBrTitulo) +
                            ListadeBoletos.IndexOf(ACBrTitulo) + 2, 6);                         // Nº SEQÜENCIAL DO REGISTRO NO ARQUIVO

        Result := DoMontaInstrucoes1(Result);
        //Result := DoMontaInstrucoes2(Result);               // opcional
      end
      else
      begin // Carteira com registro
      Result:= '1'                                                                            + // 1 a 1 - IDENTIFICAÇÃO DO REGISTRO TRANSAÇÃO
               ATipoCedente                                                                   + // TIPO DE INSCRIÇÃO DA EMPRESA
               padR(OnlyNumber(Cedente.CNPJCPF),14,'0')                                                   + // Nº DE INSCRIÇÃO DA EMPRESA (CPF/CGC)
               padR(OnlyNumber(Cedente.Agencia), 4, '0')                                                  + // AGÊNCIA MANTENEDORA DA CONTA
               '00'                                                                           + // COMPLEMENTO DE REGISTRO
               padR(Cedente.Conta, 5, '0')                                                    + // NÚMERO DA CONTA CORRENTE DA EMPRESA
               padL(Cedente.ContaDigito, 1)                                                   + // DÍGITO DE AUTO CONFERÊNCIA AG/CONTA EMPRESA
               space(4)                                                                       + // COMPLEMENTO DE REGISTRO
               '0000'                                                                         + // CÓD.INSTRUÇÃO/ALEGAÇÃO A SER CANCELADA
               padL(SeuNumero, 25, ' ')                                                       + // IDENTIFICAÇÃO DO TÍTULO NA EMPRESA
               padR(NossoNumero, 8, '0')                                                      + // IDENTIFICAÇÃO DO TÍTULO NO BANCO
               '0000000000000'                                                                + // QUANTIDADE DE MOEDA VARIÁVEL
               Carteira                                                                       + // NÚMERO DA CARTEIRA NO BANCO
               space(21)                                                                      + // IDENTIFICAÇÃO DA OPERAÇÃO NO BANCO
               'I'                                                                            + // CÓDIGO DA CARTEIRA
               ATipoOcorrencia                                                                + // IDENTIFICAÇÃO DA OCORRÊNCIA
               padL(NumeroDocumento, 10, ' ')                                                 + // Nº DO DOCUMENTO DE COBRANÇA (DUPL.,NP ETC.)
               FormatDateTime('ddmmyy', Vencimento)                                           + // DATA DE VENCIMENTO DO TÍTULO
               IntToStrZero( round( ValorDocumento * 100), 13)                                + // VALOR NOMINAL DO TÍTULO
               IntToStrZero(ACBrBanco.Numero, 3)                                              + // Nº DO BANCO NA CÂMARA DE COMPENSAÇÃO
               '00000'                                                                        + // AGÊNCIA ONDE O TÍTULO SERÁ COBRADO
               padR(ATipoEspecieDoc, 2, '0')                                                  + // ESPÉCIE DO TÍTULO
               ATipoAceite                                                                    + // IDENTIFICAÇÃO DE TITILO ACEITO OU NÃO ACEITO
               FormatDateTime('ddmmyy', DataDocumento)                                        + // DATA DA EMISSÃO DO TÍTULO
               padR(trim(Instrucao1), 2, '0')                                                       + // 1ª INSTRUÇÃO
               padR(trim(Instrucao2), 2, '0')                                                       + // 2ª INSTRUÇÃO
               IntToStrZero( round(ValorMoraJuros * 100 ), 13)                                + // VALOR DE MORA POR DIA DE ATRASO
               ADataDesconto                                                                  + // DATA LIMITE PARA CONCESSÃO DE DESCONTO
               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 13),
               padR('', 13, '0'))                                                             + // VALOR DO DESCONTO A SER CONCEDIDO
               IntToStrZero( round(ValorIOF * 100), 13)                                       + // VALOR DO I.O.F. RECOLHIDO P/ NOTAS SEGURO
               IntToStrZero( round(ValorAbatimento * 100), 13)                                + // VALOR DO ABATIMENTO A SER CONCEDIDO

               {Dados do sacado}
               ATipoSacado                                                                    + // IDENTIFICAÇÃO DO TIPO DE INSCRIÇÃO/SACADO
               padR(OnlyNumber(Sacado.CNPJCPF), 14, '0')                                                  + // Nº DE INSCRIÇÃO DO SACADO  (CPF/CGC)
               padL(Sacado.NomeSacado, 30, ' ')                                               + // NOME DO SACADO
               space(10)                                                                      + // BRANCOS(COMPLEMENTO DE REGISTRO)
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') + // RUA, NÚMERO E COMPLEMENTO DO SACADO
               padL(Sacado.Bairro, 12, ' ')                                                   + // BAIRRO DO SACADO
               padR(OnlyNumber(Sacado.CEP), 8, '0')                                           + // CEP DO SACADO
               padL(Sacado.Cidade, 15, ' ')                                                   + // CIDADE DO SACADO
               padL(Sacado.UF, 2, ' ')                                                        + // UF DO SACADO

               {Dados do sacador/avalista}
               padL('', 30, ' ')                                                              + // NOME DO SACADOR/AVALISTA
               space(4)                                                                       + // COMPLEMENTO DO REGISTRO
               ADataMoraJuros                                                                 + // DATA DE MORA
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                    padR(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00')      + // PRAZO
               space(1)                                                                       + // BRANCOS
               IntToStrZero(ListadeBoletos.IndexOf(ACBrTitulo)+ 2, 6);                          // Nº SEQÜENCIAL DO REGISTRO NO ARQUIVO
      end;

      Result:= UpperCase(Result);
    end;
  end;
end;

function TACBrBancoItau.GerarRegistroTrailler400(
  ARemessa: TStringList): String;
begin
  Result:= '9' + Space(393)            + // TIPO DE REGISTRO
  IntToStrZero( ARemessa.Count + 1, 6);  // NÚMERO SEQÜENCIAL DO REGISTRO NO ARQUIVO
  Result:= UpperCase(Result);
end;

//Implementado por Carlos Fitl - 22/12/2010
procedure TACBrBancoItau.LerRetorno400(ARetorno: TStringList);
var
  ContLinha: Integer;
  Titulo   : TACBrTitulo;

  Linha,rCedente: String ;
  rCNPJCPF,rAgencia,rConta,rDigitoConta: String;

  CodOCorrencia: Integer;
  i, MotivoLinha : Integer;
begin
   ContLinha := 0;

   if StrToIntDef(copy(ARetorno.Strings[0],77,3),-1) <> Numero then
      raise Exception.Create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
                             'não é um arquivo de retorno do '+ Nome));

   rCedente := trim(Copy(ARetorno[0],47,30));
   rAgencia := trim(Copy(ARetorno[0],27,4));
   rConta   := trim(Copy(ARetorno[0],33,5));
   rDigitoConta := Copy(ARetorno[0],38,1);

   ACBrBanco.ACBrBoleto.NumeroArquivo := StrToIntDef(Copy(ARetorno[0],109,5),0);

   ACBrBanco.ACBrBoleto.DataArquivo   := StringToDateTimeDef(Copy(ARetorno[0],95,2)+'/'+            //|
                                                             Copy(ARetorno[0],97,2)+'/'+            //|Implementado por Carlos Fitl - 27/12/2010
                                                             Copy(ARetorno[0],99,2),0, 'DD/MM/YY' );//|

   ACBrBanco.ACBrBoleto.DataCreditoLanc := StringToDateTimeDef(Copy(ARetorno[0],114,2)+'/'+            //|
                                                               Copy(ARetorno[0],116,2)+'/'+            //|Implementado por Carlos Fitl - 27/12/2010
                                                               Copy(ARetorno[0],118,2),0, 'DD/MM/YY' );//|

   case StrToIntDef(Copy(ARetorno[1],2,2),0) of
      1 : rCNPJCPF:= Copy(ARetorno[1],04,14);
      2 : rCNPJCPF:= Copy(ARetorno[1],07,11);
   else
      rCNPJCPF:= Copy(ARetorno[1],4,14);
   end;

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

      case StrToIntDef(Copy(ARetorno[1],2,2),0) of
         01: Cedente.TipoInscricao:= pFisica;
         02: Cedente.TipoInscricao:= pJuridica;
         else
            Cedente.TipoInscricao := pOutras;
      end;

      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha] ;

      if Copy(Linha,1,1)<> '1' then
         Continue;

      Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin
         SeuNumero                   := copy(Linha,38,25);
         NumeroDocumento             := copy(Linha,117,10);
         Carteira                    := copy(Linha,83,3);

         OcorrenciaOriginal.Tipo     := CodOcorrenciaToTipo(StrToIntDef(copy(Linha,109,2),0));

         MotivoLinha := 378;
         for i := 0 to 3 do
         begin
           //MotivoRejeicaoComando.Add(copy(Linha,MotivoLinha,2));
           MotivoRejeicaoComando.Add(IfThen(copy(Linha,MotivoLinha,2) = '  ',
                                             '00',copy(Linha,MotivoLinha,2)));

           if MotivoRejeicaoComando[i] <> '00' then
           begin
              CodOCorrencia:= StrToIntDef(MotivoRejeicaoComando[i],0) ;
              DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao(
                                                OcorrenciaOriginal.Tipo,CodOCorrencia));
           end;

           MotivoLinha := MotivoLinha + 2;
         end;

         DataOcorrencia := StringToDateTimeDef( Copy(Linha,111,2)+'/'+
                                                Copy(Linha,113,2)+'/'+
                                                Copy(Linha,115,2),0, 'DD/MM/YY' );

         {Espécie do documento}
         if Trim(Copy(Linha,174,2)) = '' then
            EspecieDoc := '99'
         else
            case StrToIntDef(Copy(Linha,174,2),0) of
               01 : EspecieDoc := 'DM';
               02 : EspecieDoc := 'NP';
               03 : EspecieDoc := 'NS';
               04 : EspecieDoc := 'ME';
               05 : EspecieDoc := 'RC';
               06 : EspecieDoc := 'CT';
               07 : EspecieDoc := 'CS';
               08 : EspecieDoc := 'DS';
               09 : EspecieDoc := 'LC';
               13 : EspecieDoc := 'ND';
               15 : EspecieDoc := 'DD';
               16 : EspecieDoc := 'EC';
               17 : EspecieDoc := 'PS';
               99 : EspecieDoc := 'DV';
            else
               EspecieDoc := 'DV';
            end;

         Vencimento := StringToDateTimeDef( Copy(Linha,147,2)+'/'+
                                            Copy(Linha,149,2)+'/'+
                                            Copy(Linha,151,2),0, 'DD/MM/YY' );

         ValorDocumento       := StrToFloatDef(Copy(Linha,153,13),0)/100;
         ValorIOF             := StrToFloatDef(Copy(Linha,215,13),0)/100;
         ValorAbatimento      := StrToFloatDef(Copy(Linha,228,13),0)/100;
         ValorDesconto        := StrToFloatDef(Copy(Linha,241,13),0)/100;
         ValorMoraJuros       := StrToFloatDef(Copy(Linha,267,13),0)/100;
         ValorOutrosCreditos  := StrToFloatDef(Copy(Linha,280,13),0)/100;
         ValorRecebido        := StrToFloatDef(Copy(Linha,254,13),0)/100;
         NossoNumero          := Copy(Linha,63,8);
         Carteira             := Copy(Linha,83,3);
         ValorDespesaCobranca := StrToFloatDef(Copy(Linha,176,13),0)/100;

         if StrToIntDef(Copy(Linha,296,6),0) <> 0 then
            DataCredito:= StringToDateTimeDef( Copy(Linha,296,2)+'/'+
                                               Copy(Linha,298,2)+'/'+
                                               Copy(Linha,300,2),0, 'DD/MM/YY' );

         if StrToIntDef(Copy(Linha,111,6),0) <> 0 then
            DataBaixa := StringToDateTimeDef(Copy(Linha,111,2)+'/'+
                         Copy(Linha,113,2)+'/'+
                         Copy(Linha,115,2),0,'DD/MM/YY');

      end;
   end;
end;

//Implementado por Carlos Fitl - 22/12/2010
function TACBrBancoItau.TipoOcorrenciaToDescricao(
  const TipoOcorrencia: TACBrTipoOcorrencia): String;
var
 CodOcorrencia: Integer;
begin

  CodOcorrencia := StrToIntDef(TipoOCorrenciaToCod(TipoOcorrencia),0);

  case CodOcorrencia of
    02: Result:='02-Entrada Confirmada' ;
    03: Result:='03-Entrada Rejeitada' ;
    04: Result:='04-Alteração de Dados - Nova Entrada' ;
    05: Result:='05-Alteração de Dados - Baixa' ;
    06: Result:='06-Liquidação Normal' ;
    07: Result:='07-Liquidação Parcial - Cobrança Inteligente (B2b)' ;
    08: Result:='08-Liquidação Em Cartório' ;
    09: Result:='09-Baixa Simples' ;
    10: Result:='10-Baixa Por Ter Sido Liquidado' ;
    11: Result:='11-Em Ser' ;
    12: Result:='12-Abatimento Concedido' ;
    13: Result:='13-Abatimento Cancelado' ;
    14: Result:='14-Vencimento Alterado' ;
    15: Result:='15-Baixas Rejeitadas' ;
    16: Result:='16-Instruções Rejeitadas' ;
    17: Result:='17-Alteração de Dados Rejeitados' ;
    18: Result:='18-Cobrança Contratual - Instruções/Alterações Rejeitadas/Pendentes' ;
    19: Result:='19-Confirma Recebimento de Instrução de Protesto' ;
    20: Result:='20-Confirma Recebimento de Instrução de Sustação de Protesto /Tarifa' ;
    21: Result:='21-Confirma Recebimento de Instrução de Não Protestar' ;
    23: Result:='23-Título Enviado A Cartório/Tarifa' ;
    24: Result:='24-Instrução de Protesto Rejeitada / Sustada / Pendente' ;
    25: Result:='25-Alegações do Sacado' ;
    26: Result:='26-Tarifa de Aviso de Cobrança' ;
    27: Result:='27-Tarifa de Extrato Posição (B40x)' ;
    28: Result:='28-Tarifa de Relação das Liquidações' ;
    29: Result:='29-Tarifa de Manutenção de Títulos Vencidos' ;
    30: Result:='30-Débito Mensal de Tarifas (Para Entradas e Baixas)' ;
    32: Result:='32-Baixa por ter sido Protestado' ;
    33: Result:='33-Custas de Protesto' ;
    34: Result:='34-Custas de Sustação' ;
    35: Result:='35-Custas de Cartório Distribuidor' ;
    36: Result:='36-Custas de Edital' ;
    37: Result:='37-Tarifa de Emissão de Boleto/Tarifa de Envio de Duplicata' ;
    38: Result:='38-Tarifa de Instrução' ;
    39: Result:='39-Tarifa de Ocorrências' ;
    40: Result:='40-Tarifa Mensal de Emissão de Boleto/Tarifa Mensal de Envio De Duplicata' ;
    41: Result:='41-Débito Mensal de Tarifas - Extrato de Posição (B4ep/B4ox)' ;
    42: Result:='42-Débito Mensal de Tarifas - Outras Instruções' ;
    43: Result:='43-Débito Mensal de Tarifas - Manutenção de Títulos Vencidos' ;
    44: Result:='44-Débito Mensal de Tarifas - Outras Ocorrências' ;
    45: Result:='45-Débito Mensal de Tarifas - Protesto' ;
    46: Result:='46-Débito Mensal de Tarifas - Sustação de Protesto' ;
    47: Result:='47-Baixa com Transferência para Desconto' ;
    48: Result:='48-Custas de Sustação Judicial' ;
    51: Result:='51-Tarifa Mensal Ref a Entradas Bancos Correspondentes na Carteira' ;
    52: Result:='52-Tarifa Mensal Baixas na Carteira' ;
    53: Result:='53-Tarifa Mensal Baixas em Bancos Correspondentes na Carteira' ;
    54: Result:='54-Tarifa Mensal de Liquidações na Carteira' ;
    55: Result:='55-Tarifa Mensal de Liquidações em Bancos Correspondentes na Carteira' ;
    56: Result:='56-Custas de Irregularidade' ;
    57: Result:='57-Instrução Cancelada' ;
    59: Result:='59-Baixa por Crédito em C/C Através do Sispag' ;
    60: Result:='60-Entrada Rejeitada Carnê' ;
    61: Result:='61-Tarifa Emissão Aviso de Movimentação de Títulos (2154)' ;
    62: Result:='62-Débito Mensal de Tarifa - Aviso de Movimentação de Títulos (2154)' ;
    63: Result:='63-Título Sustado Judicialmente' ;
    64: Result:='64-Entrada Confirmada com Rateio de Crédito' ;
    69: Result:='69-Cheque Devolvido' ;
    71: Result:='71-Entrada Registrada, Aguardando Avaliação' ;
    72: Result:='72-Baixa por Crédito em C/C Através do Sispag sem Título Correspondente' ;
    73: Result:='73-Confirmação de Entrada na Cobrança Simples - Entrada não Aceita na Cobrança Contratual' ;
    76: Result:='76-Cheque Compensado' ;
  end;
end;

//Implementado por Carlos Fitl - 22/12/2010
function TACBrBancoItau.CodOcorrenciaToTipo(
  const CodOcorrencia: Integer): TACBrTipoOcorrencia;
begin
  case CodOcorrencia of
      02: Result := toRetornoRegistroConfirmado;
      03: Result := toRetornoRegistroRecusado;
      04: Result := toRetornoAlteracaoDadosNovaEntrada;
      05: Result := toRetornoAlteracaoDadosBaixa;
      06: Result := toRetornoLiquidado;
      07: Result := toRetornoLiquidadoParcialmente;
      08: Result := toRetornoLiquidadoEmCartorio;
      09: Result := toRetornoBaixaSimples;
      10: Result := toRetornoBaixaPorTerSidoLiquidado;
      11: Result := toRetornoTituloEmSer;
      12: Result := toRetornoAbatimentoConcedido;
      13: Result := toRetornoAbatimentoCancelado;
      14: Result := toRetornoVencimentoAlterado;
      15: Result := toRetornoBaixaRejeitada;
      16: Result := toRetornoInstrucaoRejeitada;
      17: Result := toRetornoAlteracaoDadosRejeitados;
      18: Result := toRetornoCobrancaContratual;
      19: Result := toRetornoRecebimentoInstrucaoProtestar;
      20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
      21: Result := toRetornoRecebimentoInstrucaoNaoProtestar;
      23: Result := toRetornoEncaminhadoACartorio;
      24: Result := toRetornoInstrucaoProtestoRejeitadaSustadaOuPendente;
      25: Result := toRetornoAlegacaoDoSacado;
      26: Result := toRetornoTarifaAvisoCobranca;
      27: Result := toRetornoTarifaExtratoPosicao;
      28: Result := toRetornoTarifaDeRelacaoDasLiquidacoes;
      29: Result := toRetornoTarifaDeManutencaoDeTitulosVencidos;
      30: Result := toRetornoDebitoTarifas;
      32: Result := toRetornoBaixaPorProtesto;
      33: Result := toRetornoCustasProtesto;
      34: Result := toRetornoCustasSustacao;
      35: Result := toRetornoCustasCartorioDistribuidor;
      36: Result := toRetornoCustasEdital;
      37: Result := toRetornoTarifaEmissaoBoletoEnvioDuplicata;
      38: Result := toRetornoTarifaInstrucao;
      39: Result := toRetornoTarifaOcorrencias;
      40: Result := toRetornoTarifaMensalEmissaoBoletoEnvioDuplicata;
      41: Result := toRetornoDebitoMensalTarifasExtradoPosicao;
      42: Result := toRetornoDebitoMensalTarifasOutrasInstrucoes;
      43: Result := toRetornoDebitoMensalTarifasManutencaoTitulosVencidos;
      44: Result := toRetornoDebitoMensalTarifasOutrasOcorrencias;
      45: Result := toRetornoDebitoMensalTarifasProtestos;
      46: Result := toRetornoDebitoMensalTarifasSustacaoProtestos;
      47: Result := toRetornoBaixaTransferenciaParaDesconto;
      48: Result := toRetornoCustasSustacaoJudicial;
      51: Result := toRetornoTarifaMensalRefEntradasBancosCorrespCarteira;
      52: Result := toRetornoTarifaMensalBaixasCarteira;
      53: Result := toRetornoTarifaMensalBaixasBancosCorrespCarteira;
      54: Result := toRetornoTarifaMensalLiquidacoesCarteira;
      55: Result := toRetornoTarifaMensalLiquidacoesBancosCorrespCarteira;
      56: Result := toRetornoCustasIrregularidade;
      57: Result := toRetornoInstrucaoCancelada;
      59: Result := toRetornoBaixaCreditoCCAtravesSispag;
      60: Result := toRetornoEntradaRejeitadaCarne;
      61: Result := toRetornoTarifaEmissaoAvisoMovimentacaoTitulos;
      62: Result := toRetornoDebitoMensalTarifaAvisoMovimentacaoTitulos;
      63: Result := toRetornoTituloSustadoJudicialmente;
      64: Result := toRetornoEntradaConfirmadaRateioCredito;
      69: Result := toRetornoChequeDevolvido;
      71: Result := toRetornoEntradaRegistradaAguardandoAvaliacao;
      72: Result := toRetornoBaixaCreditoCCAtravesSispagSemTituloCorresp;
      73: Result := toRetornoConfirmacaoEntradaCobrancaSimples;
      76: Result := toRetornoChequeCompensado;
   else
      Result := toRetornoOutrasOcorrencias;
   end;
end;

//Implementado por Carlos Fitl - 22/12/2010
function TACBrBancoItau.TipoOCorrenciaToCod(
  const TipoOcorrencia: TACBrTipoOcorrencia): String;
begin
  case TipoOcorrencia of
      toRetornoRegistroConfirmado                           : Result:='02';
      toRetornoRegistroRecusado                             : Result:='03';
      toRetornoAlteracaoDadosNovaEntrada                    : Result:='04';
      toRetornoAlteracaoDadosBaixa                          : Result:='05';
      toRetornoLiquidado                                    : Result:='06';
      toRetornoLiquidadoParcialmente                        : Result:='07';
      toRetornoLiquidadoEmCartorio                          : Result:='08';
      toRetornoBaixaSimples                                 : Result:='09';
      toRetornoBaixaPorTerSidoLiquidado                     : Result:='10';
      toRetornoTituloEmSer                                  : Result:='11';
      toRetornoAbatimentoConcedido                          : Result:='12';
      toRetornoAbatimentoCancelado                          : Result:='13';
      toRetornoVencimentoAlterado                           : Result:='14';
      toRetornoBaixaRejeitada                               : Result:='15';
      toRetornoInstrucaoRejeitada                           : Result:='16';
      toRetornoAlteracaoDadosRejeitados                     : Result:='17';
      toRetornoCobrancaContratual                           : Result:='18';
      toRetornoRecebimentoInstrucaoProtestar                : Result:='19';
      toRetornoRecebimentoInstrucaoSustarProtesto           : Result:='20';
      toRetornoRecebimentoInstrucaoNaoProtestar             : Result:='21';
      toRetornoEncaminhadoACartorio                         : Result:='23';
      toRetornoInstrucaoProtestoRejeitadaSustadaOuPendente  : Result:='24';
      toRetornoAlegacaoDoSacado                             : Result:='25';
      toRetornoTarifaAvisoCobranca                          : Result:='26';
      toRetornoTarifaExtratoPosicao                         : Result:='27';
      toRetornoTarifaDeRelacaoDasLiquidacoes                : Result:='28';
      toRetornoTarifaDeManutencaoDeTitulosVencidos          : Result:='29';
      toRetornoDebitoTarifas                                : Result:='30';
      toRetornoBaixaPorProtesto                             : Result:='32';
      toRetornoCustasProtesto                               : Result:='33';
      toRetornoCustasSustacao                               : Result:='34';
      toRetornoCustasCartorioDistribuidor                   : Result:='35';
      toRetornoCustasEdital                                 : Result:='36';
      toRetornoTarifaEmissaoBoletoEnvioDuplicata            : Result:='37';
      toRetornoTarifaInstrucao                              : Result:='38';
      toRetornoTarifaOcorrencias                            : Result:='39';
      toRetornoTarifaMensalEmissaoBoletoEnvioDuplicata      : Result:='40';
      toRetornoDebitoMensalTarifasExtradoPosicao            : Result:='41';
      toRetornoDebitoMensalTarifasOutrasInstrucoes          : Result:='42';
      toRetornoDebitoMensalTarifasManutencaoTitulosVencidos : Result:='43';
      toRetornoDebitoMensalTarifasOutrasOcorrencias         : Result:='44';
      toRetornoDebitoMensalTarifasProtestos                 : Result:='45';
      toRetornoDebitoMensalTarifasSustacaoProtestos         : Result:='46';
      toRetornoBaixaTransferenciaParaDesconto               : Result:='47';
      toRetornoCustasSustacaoJudicial                       : Result:='48';
      toRetornoTarifaMensalRefEntradasBancosCorrespCarteira : Result:='51';
      toRetornoTarifaMensalBaixasCarteira                   : Result:='52';
      toRetornoTarifaMensalBaixasBancosCorrespCarteira      : Result:='53';
      toRetornoTarifaMensalLiquidacoesCarteira              : Result:='54';
      toRetornoTarifaMensalLiquidacoesBancosCorrespCarteira : Result:='55';
      toRetornoCustasIrregularidade                         : Result:='56';
      toRetornoInstrucaoCancelada                           : Result:='57';
      toRetornoBaixaCreditoCCAtravesSispag                  : Result:='59';
      toRetornoEntradaRejeitadaCarne                        : Result:='60';
      toRetornoTarifaEmissaoAvisoMovimentacaoTitulos        : Result:='61';
      toRetornoDebitoMensalTarifaAvisoMovimentacaoTitulos   : Result:='62';
      toRetornoTituloSustadoJudicialmente                   : Result:='63';
      toRetornoEntradaConfirmadaRateioCredito               : Result:='64';
      toRetornoChequeDevolvido                              : Result:='69';
      toRetornoEntradaRegistradaAguardandoAvaliacao         : Result:='71';
      toRetornoBaixaCreditoCCAtravesSispagSemTituloCorresp  : Result:='72';
      toRetornoConfirmacaoEntradaCobrancaSimples            : Result:='73';
      toRetornoChequeCompensado                             : Result:='76';
   else
      Result:= '02';
   end;
end;

//Implementado por Carlos Fitl - 22/12/2010
function TACBrBancoItau.CodMotivoRejeicaoToDescricao(
  const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: Integer): String;
begin
  case TipoOcorrencia of
  
      //Tabela 1
      toRetornoRegistroRecusado, toRetornoEntradaRejeitadaCarne:
      case CodMotivo  of
         03: Result := 'AG. COBRADORA -NÃO FOI POSSÍVEL ATRIBUIR A AGÊNCIA PELO CEP OU CEP INVÁLIDO';
         04: Result := 'ESTADO -SIGLA DO ESTADO INVÁLIDA';
         05: Result := 'DATA VENCIMENTO -PRAZO DA OPERAÇÃO MENOR QUE PRAZO MÍNIMO OU MAIOR QUE O MÁXIMO';
         07: Result := 'VALOR DO TÍTULO -VALOR DO TÍTULO MAIOR QUE 10.000.000,00';
         08: Result := 'NOME DO SACADO -NÃO INFORMADO OU DESLOCADO';
         09: Result := 'AGENCIA/CONTA -AGÊNCIA ENCERRADA';
         10: Result := 'LOGRADOURO -NÃO INFORMADO OU DESLOCADO';
         11: Result := 'CEP -CEP NÃO NUMÉRICO';
         12: Result := 'SACADOR / AVALISTA -NOME NÃO INFORMADO OU DESLOCADO (BANCOS CORRESPONDENTES)';
         13: Result := 'ESTADO/CEP -CEP INCOMPATÍVEL COM A SIGLA DO ESTADO';
         14: Result := 'NOSSO NÚMERO -NOSSO NÚMERO JÁ REGISTRADO NO CADASTRO DO BANCO OU FORA DA FAIXA';
         15: Result := 'NOSSO NÚMERO -NOSSO NÚMERO EM DUPLICIDADE NO MESMO MOVIMENTO';
         18: Result := 'DATA DE ENTRADA -DATA DE ENTRADA INVÁLIDA PARA OPERAR COM ESTA CARTEIRA';
         19: Result := 'OCORRÊNCIA -OCORRÊNCIA INVÁLIDA';
         21: Result := 'AG. COBRADORA - CARTEIRA NÃO ACEITA DEPOSITÁRIA CORRESPONDENTE/'+
                       'ESTADO DA AGÊNCIA DIFERENTE DO ESTADO DO SACADO/'+
                       'AG. COBRADORA NÃO CONSTA NO CADASTRO OU ENCERRANDO';
         22: Result := 'CARTEIRA -CARTEIRA NÃO PERMITIDA (NECESSÁRIO CADASTRAR FAIXA LIVRE)';
         26: Result := 'AGÊNCIA/CONTA -AGÊNCIA/CONTA NÃO LIBERADA PARA OPERAR COM COBRANÇA';
         27: Result := 'CNPJ INAPTO -CNPJ DO CEDENTE INAPTO';
         29: Result := 'CÓDIGO EMPRESA -CATEGORIA DA CONTA INVÁLIDA';
         30: Result := 'ENTRADA BLOQUEADA -ENTRADAS BLOQUEADAS, CONTA SUSPENSA EM COBRANÇA';
         31: Result := 'AGÊNCIA/CONTA -CONTA NÃO TEM PERMISSÃO PARA PROTESTAR (CONTATE SEU GERENTE)';
         35: Result := 'VALOR DO IOF -IOF MAIOR QUE 5%';
         36: Result := 'QTDADE DE MOEDA -QUANTIDADE DE MOEDA INCOMPATÍVEL COM VALOR DO TÍTULO';
         37: Result := 'CNPJ/CPF DO SACADO -NÃO NUMÉRICO OU IGUAL A ZEROS';
         42: Result := 'NOSSO NÚMERO -NOSSO NÚMERO FORA DE FAIXA';
         52: Result := 'AG. COBRADORA -EMPRESA NÃO ACEITA BANCO CORRESPONDENTE';
         53: Result := 'AG. COBRADORA -EMPRESA NÃO ACEITA BANCO CORRESPONDENTE - COBRANÇA MENSAGEM';
         54: Result := 'DATA DE VENCTO -BANCO CORRESPONDENTE - TÍTULO COM VENCIMENTO INFERIOR A 15 DIAS';
         55: Result := 'DEP/BCO CORRESP -CEP NÃO PERTENCE À DEPOSITÁRIA INFORMADA';
         56: Result := 'DT VENCTO/BCO CORRESP -VENCTO SUPERIOR A 180 DIAS DA DATA DE ENTRADA';
         57: Result := 'DATA DE VENCTO -CEP SÓ DEPOSITÁRIA BCO DO BRASIL COM VENCTO INFERIOR A 8 DIAS';
         60: Result := 'ABATIMENTO -VALOR DO ABATIMENTO INVÁLIDO';
         61: Result := 'JUROS DE MORA -JUROS DE MORA MAIOR QUE O PERMITIDO';
         63: Result := 'DESCONTO DE ANTECIPAÇÃO -VALOR DA IMPORTÂNCIA POR DIA DE DESCONTO (IDD) NÃO PERMITIDO';
         64: Result := 'DATA DE EMISSÃO -DATA DE EMISSÃO DO TÍTULO INVÁLIDA';
         65: Result := 'TAXA FINANCTO -TAXA INVÁLIDA (VENDOR)';
         66: Result := 'DATA DE VENCTO -INVALIDA/FORA DE PRAZO DE OPERAÇÃO (MÍNIMO OU MÁXIMO)';
         67: Result := 'VALOR/QTIDADE -VALOR DO TÍTULO/QUANTIDADE DE MOEDA INVÁLIDO';
         68: Result := 'CARTEIRA -CARTEIRA INVÁLIDA';
         69: Result := 'CARTEIRA -CARTEIRA INVÁLIDA PARA TÍTULOS COM RATEIO DE CRÉDITO';
         70: Result := 'AGÊNCIA/CONTA -CEDENTE NÃO CADASTRADO PARA FAZER RATEIO DE CRÉDITO';
         78: Result := 'AGÊNCIA/CONTA -DUPLICIDADE DE AGÊNCIA/CONTA BENEFICIÁRIA DO RATEIO DE CRÉDITO';
         80: Result := 'AGÊNCIA/CONTA -QUANTIDADE DE CONTAS BENEFICIÁRIAS DO RATEIO MAIOR DO QUE O PERMITIDO (MÁXIMO DE 30 CONTAS POR TÍTULO)';
         81: Result := 'AGÊNCIA/CONTA -CONTA PARA RATEIO DE CRÉDITO INVÁLIDA / NÃO PERTENCE AO ITAÚ';
         82: Result := 'DESCONTO/ABATI-MENTO -DESCONTO/ABATIMENTO NÃO PERMITIDO PARA TÍTULOS COM RATEIO DE CRÉDITO';
         83: Result := 'VALOR DO TÍTULO -VALOR DO TÍTULO MENOR QUE A SOMA DOS VALORES ESTIPULADOS PARA RATEIO';
         84: Result := 'AGÊNCIA/CONTA -AGÊNCIA/CONTA BENEFICIÁRIA DO RATEIO É A CENTRALIZADORA DE CRÉDITO DO CEDENTE';
         85: Result := 'AGÊNCIA/CONTA -AGÊNCIA/CONTA DO CEDENTE É CONTRATUAL / RATEIO DE CRÉDITO NÃO PERMITIDO';
         86: Result := 'TIPO DE VALOR -CÓDIGO DO TIPO DE VALOR INVÁLIDO / NÃO PREVISTO PARA TÍTULOS COM RATEIO DE CRÉDITO';
         87: Result := 'AGÊNCIA/CONTA -REGISTRO TIPO 4 SEM INFORMAÇÃO DE AGÊNCIAS/CONTAS BENEFICIÁRIAS DO RATEIO';
         90: Result := 'NRO DA LINHA -COBRANÇA MENSAGEM - NÚMERO DA LINHA DA MENSAGEM INVÁLIDO';
         97: Result := 'SEM MENSAGEM -COBRANÇA MENSAGEM SEM MENSAGEM (SÓ DE CAMPOS FIXOS), PORÉM COM REGISTRO DO TIPO 7 OU 8';
         98: Result := 'FLASH INVÁLIDO -REGISTRO MENSAGEM SEM FLASH CADASTRADO OU FLASH INFORMADO DIFERENTE DO CADASTRADO';
         99: Result := 'FLASH INVÁLIDO -CONTA DE COBRANÇA COM FLASH CADASTRADO E SEM REGISTRO DE MENSAGEM CORRESPONDENTE';
         91: Result := 'DAC -DAC AGÊNCIA / CONTA CORRENTE INVÁLIDO';
         92: Result := 'DAC -DAC AGÊNCIA/CONTA/CARTEIRA/NOSSO NÚMERO INVÁLIDO';
         93: Result := 'ESTADO -SIGLA ESTADO INVÁLIDA';
         94: Result := 'ESTADO -SIGLA ESTADA INCOMPATÍVEL COM CEP DO SACADO';
         95: Result := 'CEP -CEP DO SACADO NÃO NUMÉRICO OU INVÁLIDO';
         96: Result := 'ENDEREÇO -ENDEREÇO / NOME / CIDADE SACADO INVÁLIDO';
      else
         Result := IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      //Tabela 2
      toRetornoAlteracaoDadosRejeitados:
      case CodMotivo of
         02: Result := 'AGÊNCIA COBRADORA INVÁLIDA OU COM O MESMO CONTEÚDO';
         04: Result := 'SIGLA DO ESTADO INVÁLIDA';
         05: Result := 'DATA DE VENCIMENTO INVÁLIDA OU COM O MESMO CONTEÚDO';
         06: Result := 'VALOR DO TÍTULO COM OUTRA ALTERAÇÃO SIMULTÂNEA';
         08: Result := 'NOME DO SACADO COM O MESMO CONTEÚDO';
         09: Result := 'AGÊNCIA/CONTA INCORRETA';
         11: Result := 'CEP INVÁLIDO';
         13: Result := 'SEU NÚMERO COM O MESMO CONTEÚDO';
         16: Result := 'ABATIMENTO/ALTERAÇÃO DO VALOR DO TÍTULO OU SOLICITAÇÃO DE BAIXA BLOQUEADA';
         21: Result := 'AGÊNCIA COBRADORA NÃO CONSTA NO CADASTRO DE DEPOSITÁRIA OU EM ENCERRAMENTO';
         53: Result := 'INSTRUÇÃO COM O MESMO CONTEÚDO';
         54: Result := 'DATA VENCIMENTO PARA BANCOS CORRESPONDENTES INFERIOR AO ACEITO PELO BANCO';
         55: Result := 'ALTERAÇÕES IGUAIS PARA O MESMO CONTROLE (AGÊNCIA/CONTA/CARTEIRA/NOSSO NÚMERO)';
         56: Result := 'CGC/CPF INVÁLIDO NÃO NUMÉRICO OU ZERADO';
         57: Result := 'PRAZO DE VENCIMENTO INFERIOR A 15 DIAS';
         60: Result := 'VALOR DE IOF - ALTERAÇÃO NÃO PERMITIDA PARA CARTEIRAS DE N.S. - MOEDA VARIÁVEL';
         61: Result := 'TÍTULO JÁ BAIXADO OU LIQUIDADO OU NÃO EXISTE TÍTULO CORRESPONDENTE NO SISTEMA';
         66: Result := 'ALTERAÇÃO NÃO PERMITIDA PARA CARTEIRAS DE NOTAS DE SEGUROS - MOEDA VARIÁVEL';
         81: Result := 'ALTERAÇÃO BLOQUEADA - TÍTULO COM PROTESTO';
      else
         Result := IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      //Tabela 3
      toRetornoInstrucaoRejeitada:
      case CodMotivo of
         01: Result := 'INSTRUÇÃO/OCORRÊNCIA NÃO EXISTENTE';
         06: Result := 'NOSSO NÚMERO IGUAL A ZEROS';
         09: Result := 'CGC/CPF DO SACADOR/AVALISTA INVÁLIDO';
         10: Result := 'VALOR DO ABATIMENTO IGUAL OU MAIOR QUE O VALOR DO TÍTULO';
         14: Result := 'REGISTRO EM DUPLICIDADE';
         15: Result := 'CGC/CPF INFORMADO SEM NOME DO SACADOR/AVALISTA';
         21: Result := 'TÍTULO NÃO REGISTRADO NO SISTEMA';
         22: Result := 'TÍTULO BAIXADO OU LIQUIDADO';
         23: Result := 'INSTRUÇÃO NÃO ACEITA POR TER SIDO EMITIDO ÚLTIMO AVISO AO SACADO';
         24: Result := 'INSTRUÇÃO INCOMPATÍVEL - EXISTE INSTRUÇÃO DE PROTESTO PARA O TÍTULO';
         25: Result := 'INSTRUÇÃO INCOMPATÍVEL - NÃO EXISTE INSTRUÇÃO DE PROTESTO PARA O TÍTULO';
         26: Result := 'INSTRUÇÃO NÃO ACEITA POR TER SIDO EMITIDO ÚLTIMO AVISO AO SACADO';
         27: Result := 'INSTRUÇÃO NÃO ACEITA POR NÃO TER SIDO EMITIDA A ORDEM DE PROTESTO AO CARTÓRIO';
         28: Result := 'JÁ EXISTE UMA MESMA INSTRUÇÃO CADASTRADA ANTERIORMENTE PARA O TÍTULO';
         29: Result := 'VALOR LÍQUIDO + VALOR DO ABATIMENTO DIFERENTE DO VALOR DO TÍTULO REGISTRADO, OU VALOR'+
                       'DO ABATIMENTO MAIOR QUE 90% DO VALOR DO TÍTULO';
         30: Result := 'EXISTE UMA INSTRUÇÃO DE NÃO PROTESTAR ATIVA PARA O TÍTULO';
         31: Result := 'EXISTE UMA OCORRÊNCIA DO SACADO QUE BLOQUEIA A INSTRUÇÃO';
         32: Result := 'DEPOSITÁRIA DO TÍTULO = 9999 OU CARTEIRA NÃO ACEITA PROTESTO';
         33: Result := 'ALTERAÇÃO DE VENCIMENTO IGUAL À REGISTRADA NO SISTEMA OU QUE TORNA O TÍTULO VENCIDO';
         34: Result := 'INSTRUÇÃO DE EMISSÃO DE AVISO DE COBRANÇA PARA TÍTULO VENCIDO ANTES DO VENCIMENTO';
         35: Result := 'SOLICITAÇÃO DE CANCELAMENTO DE INSTRUÇÃO INEXISTENTE';
         36: Result := 'TÍTULO SOFRENDO ALTERAÇÃO DE CONTROLE (AGÊNCIA/CONTA/CARTEIRA/NOSSO NÚMERO)';
         37: Result := 'INSTRUÇÃO NÃO PERMITIDA PARA A CARTEIRA';
      else
         Result := IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      //Tabela 4
      toRetornoBaixaRejeitada:
      case CodMotivo of
         01: Result := 'CARTEIRA/Nº NÚMERO NÃO NUMÉRICO';
         04: Result := 'NOSSO NÚMERO EM DUPLICIDADE NUM MESMO MOVIMENTO';
         05: Result := 'SOLICITAÇÃO DE BAIXA PARA TÍTULO JÁ BAIXADO OU LIQUIDADO';
         06: Result := 'SOLICITAÇÃO DE BAIXA PARA TÍTULO NÃO REGISTRADO NO SISTEMA';
         07: Result := 'COBRANÇA PRAZO CURTO - SOLICITAÇÃO DE BAIXA P/ TÍTULO NÃO REGISTRADO NO SISTEMA';
         08: Result := 'SOLICITAÇÃO DE BAIXA PARA TÍTULO EM FLOATING';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      //Tabela 5
      toRetornoCobrancaContratual:
         case CodMotivo of
            16: Result:= 'ABATIMENTO/ALTERAÇÃO DO VALOR DO TÍTULO OU SOLICITAÇÃO DE BAIXA BLOQUEADOS';
            40: Result:= 'NÃO APROVADA DEVIDO AO IMPACTO NA ELEGIBILIDADE DE GARANTIAS';
            41: Result:= 'AUTOMATICAMENTE REJEITADA';
            42: Result:= 'CONFIRMA RECEBIMENTO DE INSTRUÇÃO – PENDENTE DE ANÁLISE';
         else
            Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
         end;

      //Tabela 6
      toRetornoAlegacaoDoSacado:
      case CodMotivo of
         1313: Result := 'SOLICITA A PRORROGAÇÃO DO VENCIMENTO PARA';
         1321: Result := 'SOLICITA A DISPENSA DOS JUROS DE MORA';
         1339: Result := 'NÃO RECEBEU A MERCADORIA';
         1347: Result := 'A MERCADORIA CHEGOU ATRASADA';
         1354: Result := 'A MERCADORIA CHEGOU AVARIADA';
         1362: Result := 'A MERCADORIA CHEGOU INCOMPLETA';
         1370: Result := 'A MERCADORIA NÃO CONFERE COM O PEDIDO';
         1388: Result := 'A MERCADORIA ESTÁ À DISPOSIÇÃO';
         1396: Result := 'DEVOLVEU A MERCADORIA';
         1404: Result := 'NÃO RECEBEU A FATURA';
         1412: Result := 'A FATURA ESTÁ EM DESACORDO COM A NOTA FISCAL';
         1420: Result := 'O PEDIDO DE COMPRA FOI CANCELADO';
         1438: Result := 'A DUPLICATA FOI CANCELADA';
         1446: Result := 'QUE NADA DEVE OU COMPROU';
         1453: Result := 'QUE MANTÉM ENTENDIMENTOS COM O SACADOR';
         1461: Result := 'QUE PAGARÁ O TÍTULO EM:';
         1479: Result := 'QUE PAGOU O TÍTULO DIRETAMENTE AO CEDENTE EM:';
         1487: Result := 'QUE PAGARÁ O TÍTULO DIRETAMENTE AO CEDENTE EM:';
         1495: Result := 'QUE O VENCIMENTO CORRETO É:';
         1503: Result := 'QUE TEM DESCONTO OU ABATIMENTO DE:';
         1719: Result := 'SACADO NÃO FOI LOCALIZADO; CONFIRMAR ENDEREÇO';
         1727: Result := 'SACADO ESTÁ EM REGIME DE CONCORDATA';
         1735: Result := 'SACADO ESTÁ EM REGIME DE FALÊNCIA';
         1750: Result := 'SACADO SE RECUSA A PAGAR JUROS BANCÁRIOS';
         1768: Result := 'SACADO SE RECUSA A PAGAR COMISSÃO DE PERMANÊNCIA';
         1776: Result := 'NÃO FOI POSSÍVEL A ENTREGA DO BLOQUETO AO SACADO';
         1784: Result := 'BLOQUETO NÃO ENTREGUE, MUDOU-SE/DESCONHECIDO';
         1792: Result := 'BLOQUETO NÃO ENTREGUE, CEP ERRADO/INCOMPLETO';
         1800: Result := 'BLOQUETO NÃO ENTREGUE, NÚMERO NÃO EXISTE/ENDEREÇO INCOMPLETO';
         1818: Result := 'BLOQUETO NÃO RETIRADO PELO SACADO. REENVIADO PELO CORREIO';
         1826: Result := 'ENDEREÇO DE E-MAIL INVÁLIDO. BLOQUETO ENVIADO PELO CORREIO';
      else
         Result := IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      //Tabela 7
      toRetornoInstrucaoProtestoRejeitadaSustadaOuPendente:
      case CodMotivo of
         1610: Result := 'DOCUMENTAÇÃO SOLICITADA AO CEDENTE';
         3111: Result := 'SUSTAÇÃO SOLICITADA AG. CEDENTE';
         3228: Result := 'ATOS DA CORREGEDORIA ESTADUAL';
         3244: Result := 'PROTESTO SUSTADO / CEDENTE NÃO ENTREGOU A DOCUMENTAÇÃO';
         3269: Result := 'DATA DE EMISSÃO DO TÍTULO INVÁLIDA/IRREGULAR';
         3301: Result := 'CGC/CPF DO SACADO INVÁLIDO/INCORRETO';
         3319: Result := 'SACADOR/AVALISTA E PESSOA FÍSICA';
         3327: Result := 'CEP DO SACADO INCORRETO';
         3335: Result := 'DEPOSITÁRIA INCOMPATÍVEL COM CEP DO SACADO';
         3343: Result := 'CGC/CPF SACADOR INVALIDO/INCORRETO';
         3350: Result := 'ENDEREÇO DO SACADO INSUFICIENTE';
         3368: Result := 'PRAÇA PAGTO INCOMPATÍVEL COM ENDEREÇO';
         3376: Result := 'FALTA NÚMERO/ESPÉCIE DO TÍTULO';
         3384: Result := 'TÍTULO ACEITO S/ ASSINATURA DO SACADOR';
         3392: Result := 'TÍTULO ACEITO S/ ENDOSSO CEDENTE OU IRREGULAR';
         3400: Result := 'TÍTULO SEM LOCAL OU DATA DE EMISSÃO';
         3418: Result := 'TÍTULO ACEITO COM VALOR EXTENSO DIFERENTE DO NUMÉRICO';
         3426: Result := 'TÍTULO ACEITO DEFINIR ESPÉCIE DA DUPLICATA';
         3434: Result := 'DATA EMISSÃO POSTERIOR AO VENCIMENTO';
         3442: Result := 'TÍTULO ACEITO DOCUMENTO NÃO PROSTESTÁVEL';
         3459: Result := 'TÍTULO ACEITO EXTENSO VENCIMENTO IRREGULAR';
         3467: Result := 'TÍTULO ACEITO FALTA NOME FAVORECIDO';
         3475: Result := 'TÍTULO ACEITO FALTA PRAÇA DE PAGAMENTO';
         3483: Result := 'TÍTULO ACEITO FALTA CPF ASSINANTE CHEQUE';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      //Tabela 8
      toRetornoInstrucaoCancelada:
      case CodMotivo of
         1156: Result := 'NÃO PROTESTAR';
         2261: Result := 'DISPENSAR JUROS/COMISSÃO DE PERMANÊNCIA';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      //Tabela 9
      toRetornoChequeDevolvido:
      case CodMotivo of
         11: Result:= 'CHEQUE SEM FUNDOS - PRIMEIRA APRESENTAÇÃO - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         12: Result:= 'CHEQUE SEM FUNDOS - SEGUNDA APRESENTAÇÃO - PASSÍVEL DE REAPRESENTAÇÃO: NÃO ';
         13: Result:= 'CONTA ENCERRADA - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         14: Result:= 'PRÁTICA ESPÚRIA - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         20: Result:= 'FOLHA DE CHEQUE CANCELADA POR SOLICITAÇÃO DO CORRENTISTA - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         21: Result:= 'CONTRA-ORDEM (OU REVOGAÇÃO) OU OPOSIÇÃO (OU SUSTAÇÃO) AO PAGAMENTO PELO EMITENTE OU PELO ' +
                      'PORTADOR - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         22: Result:= 'DIVERGÊNCIA OU INSUFICIÊNCIA DE ASSINATURAb - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         23: Result:= 'CHEQUES EMITIDOS POR ENTIDADES E ÓRGÃOS DA ADMINISTRAÇÃO PÚBLICA FEDERAL DIRETA E INDIRETA, ' +
                      'EM DESACORDO COM OS REQUISITOS CONSTANTES DO ARTIGO 74, § 2º, DO DECRETO-LEI Nº 200, DE 25.02.1967. - ' +
                      'PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         24: Result:= 'BLOQUEIO JUDICIAL OU DETERMINAÇÃO DO BANCO CENTRAL DO BRASIL - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         25: Result:= 'CANCELAMENTO DE TALONÁRIO PELO BANCO SACADO - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         28: Result:= 'CONTRA-ORDEM (OU REVOGAÇÃO) OU OPOSIÇÃO (OU SUSTAÇÃO) AO PAGAMENTO OCASIONADA POR FURTO OU ROUBO - ' +
                      'PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         29: Result:= 'CHEQUE BLOQUEADO POR FALTA DE CONFIRMAÇÃO DO RECEBIMENTO DO TALONÁRIO PELO CORRENTISTA - ' +
                      'PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         30: Result:= 'FURTO OU ROUBO DE MALOTES - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         31: Result:= 'ERRO FORMAL (SEM DATA DE EMISSÃO, COM O MÊS GRAFADO NUMERICAMENTE, AUSÊNCIA DE ASSINATURA, ' +
                      'NÃO-REGISTRO DO VALOR POR EXTENSO) - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         32: Result:= 'AUSÊNCIA OU IRREGULARIDADE NA APLICAÇÃO DO CARIMBO DE COMPENSAÇÃO - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         33: Result:= 'DIVERGÊNCIA DE ENDOSSO - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         34: Result:= 'CHEQUE APRESENTADO POR ESTABELECIMENTO BANCÁRIO QUE NÃO O INDICADO NO CRUZAMENTO EM PRETO, SEM O ' +
                      'ENDOSSO-MANDATO - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         35: Result:= 'CHEQUE FRAUDADO, EMITIDO SEM PRÉVIO CONTROLE OU RESPONSABILIDADE DO ESTABELECIMENTO BANCÁRIO ' +
                      '("CHEQUE UNIVERSAL"), OU AINDA COM ADULTERAÇÃO DA PRAÇA SACADA - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         36: Result:= 'CHEQUE EMITIDO COM MAIS DE UM ENDOSSO - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         40: Result:= 'MOEDA INVÁLIDA - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         41: Result:= 'CHEQUE APRESENTADO A BANCO QUE NÃO O SACADO - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         42: Result:= 'CHEQUE NÃO-COMPENSÁVEL NA SESSÃO OU SISTEMA DE COMPENSAÇÃO EM QUE FOI APRESENTADO - ' +
                      'PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         43: Result:= 'CHEQUE, DEVOLVIDO ANTERIORMENTE PELOS MOTIVOS 21, 22, 23, 24, 31 OU 34, NÃO-PASSÍVEL ' +
                      'DE REAPRESENTAÇÃO EM VIRTUDE DE PERSISTIR O MOTIVO DA DEVOLUÇÃO - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         44: Result:= 'CHEQUE PRESCRITO - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         45: Result:= 'CHEQUE EMITIDO POR ENTIDADE OBRIGADA A REALIZAR MOVIMENTAÇÃO E UTILIZAÇÃO DE RECURSOS FINANCEIROS ' +
                      'DO TESOURO NACIONAL MEDIANTE ORDEM BANCÁRIA - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
         48: Result:= 'CHEQUE DE VALOR SUPERIOR AO ESTABELECIDO, EMITIDO SEM A IDENTIFICAÇÃO DO BENEFICIÁRIO, DEVENDO SER ' +
                      'DEVOLVIDO A QUALQUER TEMPO - PASSÍVEL DE REAPRESENTAÇÃO: SIM';
         49: Result:= 'REMESSA NULA, CARACTERIZADA PELA REAPRESENTAÇÃO DE CHEQUE DEVOLVIDO PELOS MOTIVOS 12, 13, 14, 20, ' +
                      '25, 28, 30, 35, 43, 44 E 45, PODENDO A SUA DEVOLUÇÃO OCORRER A QUALQUER TEMPO - PASSÍVEL DE REAPRESENTAÇÃO: NÃO';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
   else
      Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
   end;
end;

end.
