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

unit ACBrBancoBrasil;

interface

uses
  Classes, SysUtils, ACBrBoleto,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrBancoBrasil}

  TACBrBancoBrasil = class(TACBrBancoClass)
   protected
   private
    function FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function GerarRegistroHeader240(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa : TStringList): String;  override;
    function GerarRegistroHeader400(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler400(ARemessa : TStringList): String;  override;
    Procedure LerRetorno240(ARetorno:TStringList); override;
   end;

implementation

uses ACBrUtil, StrUtils, Variants;

constructor TACBrBancoBrasil.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 9;
   fpNome   := 'Banco do Brasil';
   fpNumero := 001;
   fpTamanhoMaximoNossoNum := 10;
   fpTamanhoConta   := 5;
   fpTamanhoAgencia := 4;
   fpTamanhoCarteira:= 2;

end;

function TACBrBancoBrasil.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Result := '0';

   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal   := 2;
   Modulo.MultiplicadorInicial := 9;
   Modulo.Documento := FormataNossoNumero(ACBrTitulo);
   Modulo.Calcular;

   if Modulo.ModuloFinal >= 10 then
      Result:= 'X'
   else
      Result:= IntToStr(Modulo.ModuloFinal);
end;

function TACBrBancoBrasil.FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
var
  ANossoNumero, AConvenio : string;
  aCarteira: LongInt;
begin
   with ACBrTitulo do
   begin
      AConvenio := ACBrBoleto.Cedente.Convenio;
      ANossoNumero := OnlyNumber(NossoNumero);
      aCarteira    := StrToIntDef(Carteira,0);
      if (aCarteira = 16) or (aCarteira = 17) or (aCarteira = 18) then
       begin
         if (ACBrTitulo.Carteira = '18') and (Length(AConvenio) = 6) then
           ANossoNumero := padR(ANossoNumero, 17, '0')
         else if Length(AConvenio) <= 4 then
            ANossoNumero := padR(AConvenio, 4, '0') + padR(ANossoNumero, 7, '0')
         else if (Length(AConvenio) > 4) and (Length(AConvenio) <= 6) then
            ANossoNumero := padR(AConvenio, 6, '0') + padR(ANossoNumero, 5, '0')
         else if Length(AConvenio) = 7 then
            ANossoNumero := padR(AConvenio, 7, '0') + padR(ANossoNumero, 10, '0');
       end
      else 
         ANossoNumero :=   padR(AConvenio, 7, '0')+ padR(ANossoNumero, 11, '0');
   end;
   Result := ANossoNumero;
end;


function TACBrBancoBrasil.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras :String;
  ANossoNumero, AConvenio: string;
begin
    AConvenio := ACBrTitulo.ACBrBoleto.Cedente.Convenio;
    ANossoNumero := FormataNossoNumero(ACBrTitulo);

    {Codigo de Barras}
    with ACBrTitulo.ACBrBoleto do
    begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      if ((ACBrTitulo.Carteira = '18') or (ACBrTitulo.Carteira = '16')) and
         (Length(AConvenio) = 6) then
       begin
        CodigoBarras := IntToStrZero(Banco.Numero, 3) +
                        '9' +
                        FatorVencimento +
                        IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                        AConvenio + ANossoNumero + '21';
       end
      else
       begin
         CodigoBarras := IntToStrZero(Banco.Numero, 3) +
                         '9' +
                         FatorVencimento +
                         IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                         IfThen((Length(AConvenio) = 7), '000000', '') +
                         ANossoNumero +
                         IfThen((Length(AConvenio) < 7), padR(Cedente.Agencia, 4, '0'), '') +
                         IfThen((Length(AConvenio) < 7), padR(Cedente.Conta, 8, '0'), '') +
                         ACBrTitulo.Carteira;
      end;

      DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
    end;


    Result:= copy( CodigoBarras, 1, 4) + DigitoCodBarras + copy( CodigoBarras, 5, 44) ;
end;

function TACBrBancoBrasil.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
             ACBrTitulo.ACBrBoleto.Cedente.Conta+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBancoBrasil.MontarCampoNossoNumero (const ACBrTitulo: TACBrTitulo ) : String;
var ANossoNumero : string;
begin
    ANossoNumero := FormataNossoNumero(ACBrTitulo);
    if (Length(ACBrBanco.ACBrBoleto.Cedente.Convenio) = 7) or
       ((Length(ACBrBanco.ACBrBoleto.Cedente.Convenio) = 6) and
        (Length(ANossoNumero) = 17) and
        ((StrToInt(ACBrTitulo.Carteira)= 16) or
        (StrToInt(ACBrTitulo.Carteira)= 18))) then
       Result:= ANossoNumero
    else
       Result := ANossoNumero + '-' + CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoBrasil.GerarRegistroHeader240(NumeroRemessa : Integer): String;
var
  ATipoInscricao,CNPJCIC: string;
  aAgencia: String;
  aConta: String;
  aModalidade: String;
begin

   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      case TipoInscricao of
         pFisica  : ATipoInscricao := '1';
         pJuridica: ATipoInscricao := '2';
         pOutras  : ATipoInscricao := '3';
      end;

      CNPJCIC := OnlyNumber(CNPJCPF);

      aAgencia:= IntToStrZero(StrToIntDef(trim(Agencia),0),5);
      aConta  := IntToStrZero(StrToIntDef(trim(Conta),0),12);
      aModalidade := IntToStrZero(StrToIntDef(trim(Modalidade),0),3);

          { GERAR REGISTRO-HEADER DO ARQUIVO }

      Result:= IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
               '0000'                                  + //4 a 7 - Lote de serviço
               '0'                                     + //8 - Tipo de registro - Registro header de arquivo
               padL('', 9, ' ')                        + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscrição do cedente
               padR(CNPJCIC, 14, '0')                  + //19 a 32 -Número de inscrição do cedente
               padR(CodigoCedente, 9, '0') + '0014'    + //33 a 45 - Código do convênio no banco [ Alterado conforme instruções da CSO Brasília ] 27-07-09
               ACBrBanco.ACBrBoleto.ListadeBoletos[0].Carteira + //46 a 47 - Carteira
               aModalidade+'  '                        + //48 a 52 - Variacao Carteira
               aAgencia                                + //53 a 57 - Código da agência do cedente
               padL(AgenciaDigito, 1 , '0')            + //58 - Dígito da agência do cedente
               aConta                                  + //59 a 70 - Número da conta do cedente
               padL(ContaDigito, 1, '0')               + //71 - Dígito da conta do cedente
               ' '                                     + //72 - Dígito verificador da agência / conta
               padR(Nome, 30, ' ')                     + //73 a 102 - Nome do cedente
               padL('BANCO DO BRASIL', 30, ' ')        + //103 a 132 - Nome do banco
               padL('', 10, ' ')                       + //133 a 142 - Uso exclusivo FEBRABAN/CNAB
               '1'                                     + //143 - Código de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)         + //144 a 151 - Data do de geração do arquivo
               FormatDateTime('hhmmss', Now)           + //152 a 157 - Hora de geração do arquivo
               padL(IntToStr(NumeroRemessa), 6, '0')   + //158 a 163 - Número seqüencial do arquivo
               '030'                                   + //164 a 166 - Número da versão do layout do arquivo
               padL('',  5, '0')                       + //167 a 171 - Densidade de gravação do arquivo (BPI)
               padL('', 20, ' ')                       + // 172 a 191 - Uso reservado do banco
               padL('', 20, '0')                       + // 192 a 211 - Uso reservado da empresa
               padL('', 11, ' ')                       + // 212 a 222 - 11 brancos
               'CSP'                                   + // 223 a 225 - 'CSP'
               padL('',  3, '0')                       + // 226 a 228 - Uso exclusivo de Vans
               padL('',  2, ' ')                       + // 229 a 230 - Tipo de servico
               padL('', 10, ' ');                        //231 a 240 - titulo em carteira de cobranca

          { GERAR REGISTRO HEADER DO LOTE }

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
               '0001'                                  + //4 a 7 - Lote de serviço
               '1'                                     + //8 - Tipo de registro - Registro header de arquivo
               'R'                                     + //9 - Tipo de operação: R (Remessa) ou T (Retorno)
               '01'                                    + //10 a 11 - Tipo de serviço: 01 (Cobrança)
               '00'                                    + //12 a 13 - Forma de lançamento: preencher com ZEROS no caso de cobrança
               '020'                                   + //14 a 16 - Número da versão do layout do lote
               ' '                                     + //17 - Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscrição do cedente
               padR(CNPJCIC, 15, '0')                  + //19 a 32 -Número de inscrição do cedente
               padR(CodigoCedente, 9, '0') + '0014'    + //33 a 45 - Código do convênio no banco [ Alterado conforme instruções da CSO Brasília ] 27-07-09
               ACBrBanco.ACBrBoleto.ListadeBoletos[0].Carteira + //46 a 47 - Carteira
               aModalidade+'  '                        + //48 a 52 - Variacao Carteira
               aAgencia                                + //53 a 57 - Código da agência do cedente
               padL(AgenciaDigito, 1 , '0')            + //58 - Dígito da agência do cedente
               aConta                                  + //59 a 70 - Número da conta do cedente
               padL(ContaDigito, 1, '0')               + //71 - Dígito da conta do cedente
               ' '                                     + //72 - Dígito verificador da agência / conta
               padR(Nome, 30, ' ')                     + //73 a 102 - Nome do cedente
               padL('', 40, ' ')                       + //104 a 143 - Mensagem 1 para todos os boletos do lote
               padL('', 40, ' ')                       + //144 a 183 - Mensagem 2 para todos os boletos do lote
               padL(IntToStr(NumeroRemessa), 8, '0')   + //184 a 191 - Número do arquivo
               FormatDateTime('ddmmyyyy', Now)         + //192 a 199 - Data de geração do arquivo
               padL('', 8, '0')                        + //200 a 207 - Data do crédito - Só para arquivo retorno
               padL('', 33, ' ');                        //208 a 240 - Uso exclusivo FEBRABAN/CNAB
   end;
end;

function TACBrBancoBrasil.GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String;
var
   ATipoInscricao, ATipoOcorrencia, ATipoBoleto: String;
   ADataMoraJuros, ADataDesconto, ANossoNumero : String;
   ATipoAceite, aAgencia, aConta               : String;
begin
   with ACBrTitulo do
   begin
      ANossoNumero := FormataNossoNumero(ACBrTitulo);

      aAgencia:= IntToStrZero(StrToIntDef(trim(ACBrBoleto.Cedente.Agencia),0),5);
      aConta  := IntToStrZero(StrToIntDef(trim(ACBrBoleto.Cedente.Conta),0),12);

      {SEGMENTO P}

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
         toRemessaAlterarNomeEnderecoSacado : ATipoOcorrencia := '12';
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
         tbCliEmite        : ATipoBoleto := '2' + '2';
         tbBancoEmite      : ATipoBoleto := '1' + '1';
         tbBancoReemite    : ATipoBoleto := '4' + '1';
         tbBancoNaoReemite : ATipoBoleto := '5' + '2';
      end;

      {Mora Juros}
      if (ValorMoraJuros > 0) then
       begin
         if (DataMoraJuros <> Null) then
            ADataMoraJuros := FormatDateTime('ddmmyyyy', DataMoraJuros)
         else
            ADataMoraJuros := padL('', 8, '0');
       end
      else
         ADataMoraJuros := padL('', 8, '0');

      {Descontos}
      if (ValorDesconto > 0) then
       begin
         if (DataDesconto <> Null) then
            ADataDesconto := FormatDateTime('ddmmyyyy', DataDesconto)
         else
            ADataDesconto := padL('', 8, '0');
       end
      else
         ADataDesconto := padL('', 8, '0');

      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - Código do banco
               '0001'                                                     + //4 a 7 - Lote de serviço
               '3'                                                        + //8 - Tipo do registro: Registro detalhe
               IntToStrZero(ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)+ 1 ,5) + //9 a 13 - Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'P'                                                        + //14 - Código do segmento do registro detalhe
               ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //16 a 17 - Código de movimento
               aAgencia                                                   + //18 a 22 - Agência mantenedora da conta
               padL(ACBrBoleto.Cedente.AgenciaDigito, 1 , '0')            + //23 -Dígito verificador da agência
               aConta                                                     + //24 a 35 - Número da conta corrente
               padL(ACBrBoleto.Cedente.ContaDigito, 1, '0')               + //36 - Dígito verificador da conta
               ' '                                                        + //37 - Dígito verificador da agência / conta
               padL(ANossoNumero, 20, ' ')                                + //38 a 57 - Nosso número - identificação do título no banco
               '1'                                                        + //58 - Cobrança Simples
               '1'                                                        + //59 - Forma de cadastramento do título no banco: com cadastramento
               '1'                                                        + //60 - Tipo de documento: Tradicional
               ATipoBoleto                                                + //61 a 62 - Quem emite e quem distribui o boleto?
               padL(NumeroDocumento, 10, '0') + '00000'                   + //63 a 72 - Número que identifica o título na empresa [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
               FormatDateTime('ddmmyyyy', Vencimento)                     + //78 a 85 - Data de vencimento do título
               IntToStrZero( round( ValorDocumento * 100), 15)            + //86 a 100 - Valor nominal do título
               '000000'                                                   + //101 a 105 - Agência cobradora + Digito. Se ficar em branco, a caixa determina automaticamente pelo CEP do sacado
               padL(EspecieDoc,2)                                                 + //107 a 108 - Espécie do documento
               ATipoAceite                             + //109 - Identificação de título Aceito / Não aceito
               FormatDateTime('ddmmyyyy', DataDocumento)                  + //110 a 117 - Data da emissão do documento
               IfThen(ValorMoraJuros > 0, '1', '0')                       + //118 - Código de juros de mora: Valor por dia
               ADataMoraJuros                                             + //119 a 126 - Data a partir da qual serão cobrados juros

               IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15),
                    padL('', 15, '0'))                                    + //127 a 141 - Valor de juros de mora por dia

               IfThen(ValorDesconto > 0, IfThen(DataDesconto > 0, '1','4'), '0')  + //142 - Código de desconto: 1 - Valor fixo até a data informada 4-Desconto por dia de antecipacao 0 - Sem desconto
               ADataDesconto                                              + //143 a 150 - Data do desconto

               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),
               padL('', 15, '0'))                                         + //151 a 165 - Valor do desconto por dia
               IntToStrZero( round(ValorIOF * 100), 15)                   + //166 a 180 - Valor do IOF a ser recolhido
               IntToStrZero( round(ValorAbatimento * 100), 15)            + //181 a 195 - Valor do abatimento
               padL(SeuNumero, 25, ' ')                                   + //196 a 220 - Identificação do título na empresa
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento), '1', '3') + //221 - Código de protesto: Protestar em XX dias corridos
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                    padL(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00') + //222 a 223 - Prazo para protesto (em dias corridos)
               '2'                                                        + //224 - Campo não tratado pelo BB [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
               '000'                                                      + //225 a 227 - Campo não tratado pelo BB [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
               '09'                                                       + //228 a 229 - Código da moeda: Real 
               padL('', 10 , '0')                                         + //230 a 239 - Uso exclusivo FEBRABAN/CNAB
               ' ';                                                         //240 - Uso exclusivo FEBRABAN/CNAB

      {SEGMENTO Q}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '0001'                                                     + //Número do lote
               '3'                                                        + //Tipo do registro: Registro detalhe
               IntToStrZero((2 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 2 ,5) + //Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'Q'                                                        + //Código do segmento do registro detalhe
               ' '                                                        + //Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //Tipo Ocorrencia
                   {Dados do sacado}
               IfThen(Sacado.Pessoa = pJuridica,'2','1')                  + //Tipo inscricao
               padR(OnlyNumber(Sacado.CNPJCPF), 15, '0')                              +
               padL(Sacado.NomeSacado, 40, ' ')                                 +
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') +
               padL(Sacado.Bairro, 15, ' ')                               +
               //padR(Sacado.CEP, 8, '0')                                   +
               padR(OnlyNumber(Sacado.CEP), 8, '0')                                   +
               //padR(Sacado.Cidade, 15, ' ')                               +
               padL(Sacado.Cidade, 15, ' ')                               +
               padL(Sacado.UF, 2, ' ')                                    +
                        {Dados do sacador/avalista}
               '0'                                                        + //Tipo de inscrição: Não informado
               padL('', 15, '0')                                          + //Número de inscrição
               padL('', 40, ' ')                                          + //Nome do sacador/avalista
               padL('', 3, '0')                                           + //Uso exclusivo FEBRABAN/CNAB
               padL('',20, ' ')                                           + //Uso exclusivo FEBRABAN/CNAB
               padL('', 8, ' ');                                            //Uso exclusivo FEBRABAN/CNAB
      end; 
end;

function TACBrBancoBrasil.GerarRegistroTrailler240( ARemessa : TStringList ): String;
begin
   {REGISTRO TRAILER DO LOTE}
   Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
            '0001'                                                     + //Número do lote
            '5'                                                        + //Tipo do registro: Registro trailer do lote
            Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
            //IntToStrZero(ARemessa.Count-1, 6)                        + //Quantidade de Registro da Remessa
            IntToStrZero(((2 * ARemessa.Count-1) + 1), 6)              + //Quantidade de Registro da Remessa
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            Space(8)                                                   + //Uso exclusivo FEBRABAN/CNAB}
            padL('',117,' ')                                           ;

   {GERAR REGISTRO TRAILER DO ARQUIVO}
   Result:= Result + #13#10 +
            IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
            '9999'                                                     + //Lote de serviço
            '9'                                                        + //Tipo do registro: Registro trailer do arquivo
            space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB}
            '000001'                                                   + //Quantidade de lotes do arquivo}
            IntToStrZero(((ARemessa.Count-1)* 2)+4, 6)                 + //Quantidade de registros do arquivo, inclusive este registro que está sendo criado agora}
            space(6)                                                   + //Uso exclusivo FEBRABAN/CNAB}
            space(205);                                                  //Uso exclusivo FEBRABAN/CNAB}
end;


function TACBrBancoBrasil.GerarRegistroHeader400(NumeroRemessa: Integer): String;
var
  TamConvenioMaior6 :Boolean;
  aAgencia, aConta  :String;
begin

   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      TamConvenioMaior6:= Length(trim(Convenio)) > 6;
      aAgencia:= IntToStrZero(StrToIntDef(trim(Agencia),0),4);
      aConta  := IntToStrZero(StrToIntDef(trim(Conta),0),8);

      Result:= '0'                            + // ID do Registro
               '1'                            + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                      + // Literal de Remessa
               '01'                           + // Código do Tipo de Serviço
               padL( 'COBRANCA', 15 )         + // Descrição do tipo de serviço
               aAgencia                       + // Prefixo da agência/ onde esta cadastrado o convenente lider do cedente
               padL( AgenciaDigito, 1, ' ')   + // DV-prefixo da agencia
               aConta                         + // Codigo do cedente/nr. da conta corrente que está cadastro o convenio lider do cedente
               padL( ContaDigito, 1, ' ');      // DV-código do cedente


      if TamConvenioMaior6 then
         Result:= Result + '000000'                         // Complemento
      else
         Result:= Result + padR(trim(Convenio),6,'0');      //Convenio;

      Result:= Result + padL( Nome, 30)                      + // Nome da Empresa
               IntToStrZero( Numero, 3)                      + // Código do Banco
               padL('BANCO DO BRASIL', 15)                   + // Nome do Banco(BANCO DO BRASIL)
               FormatDateTime('ddmmyy',Now)                  + // Data de geração do arquivo
               IntToStrZero(NumeroRemessa,7);                  // Numero Remessa

      if TamConvenioMaior6 then
         Result:= Result + Space(22)                                     + // Nr. Sequencial de Remessa + brancos
                  padR(trim(ACBrBanco.ACBrBoleto.Cedente.Convenio),7,'0')+ //Nr. Convenio
                  space(258)                                               //Brancos
      else
         Result:= Result + Space(287);

      Result:= Result + IntToStrZero(1,6); // Nr. Sequencial do registro-informar 000001

      Result:= UpperCase(Result);
   end;
end;

function TACBrBancoBrasil.GerarRegistroTransacao400(
  ACBrTitulo: TACBrTitulo): String;
var
  ANossoNumero, ADigitoNossoNumero :String;
  ATipoOcorrencia, AInstrucao      :String;
  ATipoSacado, ATipoCendente       :String;
  ATipoAceite, ATipoEspecieDoc     :String;
  AMensagem, DiasProtesto          :String;
  aDataDesconto, aAgencia, aConta  :String;
  aModalidade :String;
  NumRegT, NumRegM, incNumReg      :Integer;
  ATipoBoleto                      :Char;
  TamConvenioMaior6                :Boolean;

begin

   with ACBrTitulo do
   begin
      TamConvenioMaior6:= Length(trim(ACBrBoleto.Cedente.Convenio)) > 6;

      ANossoNumero := FormataNossoNumero(ACBrTitulo);
      ADigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

      aAgencia:= IntToStrZero(StrToIntDef(trim(ACBrBoleto.Cedente.Agencia),0),4);
      aConta  := IntToStrZero(StrToIntDef(trim(ACBrBoleto.Cedente.Conta),0),8);
      aModalidade := IntToStrZero(StrToIntDef(trim(ACBrBoleto.Cedente.Modalidade),0),3);

      {Pegando Código da Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                        : ATipoOcorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento            : ATipoOcorrencia := '04'; {Concessão de Abatimento}
         toRemessaCancelarAbatimento            : ATipoOcorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento             : ATipoOcorrencia := '06'; {Alteração de vencimento}
         toRemessaAlterarNumeroControle         : ATipoOcorrencia := '08'; {Alteração de seu número}
         toRemessaProtestar                     : ATipoOcorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarIntrucaoProtestoBaixa : ATipoOcorrencia := '10'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto     : ATipoOcorrencia := '10'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias             : ATipoOcorrencia := '31'; {Alteração de Outros Dados}
      else
         ATipoOcorrencia := '01';                                      {Remessa}
      end;

      { Pegando o Aceite do Titulo }
      case Aceite of
         atSim :  ATipoAceite := 'A';
         atNao :  ATipoAceite := 'N';
      end;

      { Pegando o tipo de EspecieDoc }
      if EspecieDoc = 'DM' then
         ATipoEspecieDoc   := '01'
      else if EspecieDoc = 'RC' then
         ATipoEspecieDoc   := '05';

      {Pegando Tipo de Boleto}
      case ACBrBoleto.Cedente.ResponEmissao of
         tbCliEmite : ATipoBoleto := '2';
      else
         ATipoBoleto := '1';
      end;

      {Pegando campo Intruções}
      if (DataProtesto > 0) and (DataProtesto > Vencimento) then
       begin
         if (trim(Instrucao1) = '') or (trim(Instrucao1) = '06') then
            AInstrucao := '06'+ padR(trim(Instrucao2),2,'0')
         else if(trim(Instrucao2) = '') or (trim(Instrucao2) = '06') then
            AInstrucao := padR(trim(Instrucao2),2,'0')+ '06';

         DiasProtesto:=  IntToStrZero(DaysBetween(DataProtesto,Vencimento),2);
       end
      else
       begin
         AInstrucao := padR(trim(Instrucao1),2,'0') + padR(trim(Instrucao2),2,'0');
         DiasProtesto:= '00';
      end;

      aDataDesconto:= '000000';

      if ValorDesconto > 0 then
      begin
         if DataDesconto > EncodeDate(2000,01,01) then
            aDataDesconto := FormatDateTime('ddmmyy',DataDesconto)
         else
            aDataDesconto := '777777';
      end;


      {Pegando Tipo de Sacado}
      case Sacado.Pessoa of
         pFisica   : ATipoSacado := '01';
         pJuridica : ATipoSacado := '02';
      else
         ATipoSacado := '00';
      end;

      {Pegando Tipo de Cedente}
      case ACBrBoleto.Cedente.TipoInscricao of
         pFisica   : ATipoCendente := '01';
         pJuridica : ATipoCendente := '02';
      end;

      AMensagem   := '';
      if Mensagem.Text <> '' then
         AMensagem   := Mensagem.Strings[0];


      with ACBrBoleto do
      begin
         incNumReg:= 2 + ListadeBoletos.IndexOf(ACBrTitulo);
         NumRegT:= ListadeBoletos.IndexOf(ACBrTitulo)+ incNumReg;
         NumRegM:= NumRegT+1;

         if TamConvenioMaior6 then
            Result:= '7'
         else
            Result:= '1';

         Result:= Result                                                  + // ID Registro
                  ATipoCendente + padR(OnlyNumber(Cedente.CNPJCPF),14,'0')+ // Tipo de inscrição da empresa 01-CPF / 02-CNPJ  + Inscrição da empresa
                  aAgencia                                                + // Prefixo da agencia
                  padL( Cedente.AgenciaDigito, 1)                         + // DV-prefixo da agencia
                  aConta                                                  + // Código do cendete/nr. conta corrente da empresa
                  padL( Cedente.ContaDigito, 1);                            // DV-código do cedente

         if TamConvenioMaior6 then
            Result:= Result + padR( trim(Cedente.Convenio), 7)              // Número do convenio
         else
            Result:= Result + padR( trim(Cedente.Convenio), 6);             // Número do convenio

         Result:= Result + padL( SeuNumero, 25 );                           // Numero de Controle do Participante

         if TamConvenioMaior6 then
            Result:= Result + padR( ANossoNumero, 17, '0')                  // Nosso numero
         else
            Result:= Result + padR( ANossoNumero,11)+ ADigitoNossoNumero;


         Result:= Result +
                  '0000' + Space(7) + aModalidade;                          // Zeros + Brancos + Prefixo do titulo + Variação da carteira

         if TamConvenioMaior6  then
            Result:= Result + IntToStrZero(0,7)                             // Zero + Zeros + Zero + Zeros
         else
            Result:= Result + IntToStrZero(0,13);

         Result:= Result +
                  '     '                                                 + // Tipo de cobrança
                  Carteira                                                + // Carteira
                  ATipoOcorrencia                                         + // Ocorrência "Comando"
                  padL( NumeroDocumento, 10, ' ')                         + // Seu Numero - Nr. titulo dado pelo cedente
                  FormatDateTime( 'ddmmyy', Vencimento )                  + // Data de vencimento
                  IntToStrZero( Round( ValorDocumento * 100 ), 13)        + // Valor do titulo
                  '001' + '0000' + ' '                                    + // Numero do Banco - 001 + Prefixo da agencia cobradora + DV-pref. agencia cobradora
                  padR(ATipoEspecieDoc, 2, '0') + ATipoAceite             + // Especie de titulo + Aceite
                  FormatDateTime( 'ddmmyy', DataDocumento )               + // Data de Emissão
                  AInstrucao                                              + // 1ª e 2ª instrução codificada
                  IntToStrZero( round(ValorMoraJuros * 100 ), 13)         + // Juros de mora por dia
                  aDataDesconto                                           + // Data limite para concessao de desconto
                  IntToStrZero( round( ValorDesconto * 100), 13)          + // Valor do desconto
                  IntToStrZero( round( ValorIOF * 100 ), 13)              + // Valor do IOF
                  IntToStrZero( round( ValorAbatimento * 100 ), 13)       + // Valor do abatimento permitido
                  ATipoSacado + padR(OnlyNumber(Sacado.CNPJCPF),14,'0')   + // Tipo de inscricao do sacado + CNPJ ou CPF do sacado
                  padL( Sacado.NomeSacado, 37) + '   '                    + // Nome do sacado + Brancos
                  padL(trim(Sacado.Logradouro) +
                        ', ' +
                        trim(Sacado.Numero) + ' '+ trim(Sacado.Bairro), 52)          + // Endereço do sacado
                  padR( OnlyNumber(Sacado.CEP), 8 )                       + // CEP do endereço do sacado
                  padL( trim(Sacado.Cidade), 15)                          + // Cidade do sacado
                  padL( Sacado.UF, 2 )                                    + // UF da cidade do sacado
                  padL( AMensagem, 40)                                    + // Observações
                  DiasProtesto + ' '                                      + // Número de dias para protesto + Branco
                  IntToStrZero( NumRegT, 6 );


         Result:= Result + #13#10                                  +
                  '5'                                              + //Tipo Registro
                  '99'                                             + //Tipo de Serviço (Cobrança de Multa)
                  IfThen(PercentualMulta > 0, '2','9')             + //Cod. Multa 2- Percentual 9-Sem Multa
                  IfThen(PercentualMulta > 0,FormatDateTime('ddmmyy', DataMoraJuros),'000000') + //Data Multa
                  IntToStrZero( round( PercentualMulta * 100), 12) + //Perc. Multa
                  Space(372)                                       + //Brancos
                  IntToStrZero(NumRegM,6);

         Result:= UpperCase(Result);
      end;
   end;
end;

function TACBrBancoBrasil.GerarRegistroTrailler400(
  ARemessa: TStringList): String;
begin
   Result:= '9' + Space(393)                     + // ID Registro
            IntToStrZero( (ARemessa.Count * 2), 6);  // Contador de Registros
   Result:= UpperCase(Result);
end;

procedure TACBrBancoBrasil.LerRetorno240(ARetorno: TStringList);
var
  Titulo: TACBrTitulo;
  TempData, Linha, rCedente, rCNPJCPF: String;
  ContLinha : Integer;
begin
   ContLinha := 0;

   // informação do Header
   // Verifica se o arquivo pertence ao banco
   if StrToIntDef(copy(ARetorno.Strings[0], 1, 3),-1) <> Numero then
      raise Exception.create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
            'não' + 'é um arquivo de retorno do ' + Nome));

   rCedente := trim(copy(ARetorno[0], 73, 30));
   rCNPJCPF := OnlyNumber( copy(ARetorno[0], 19, 14) );

   with ACBrBanco.ACBrBoleto do
   begin
      if (not LeCedenteRetorno) and (rCNPJCPF <> Cedente.CNPJCPF) then
        raise Exception.create(ACBrStr('CNPJ\CPF do arquivo inválido'));

      Cedente.Nome := rCedente;
      Cedente.CNPJCPF := rCNPJCPF;

      case StrToIntDef(copy(ARetorno[0], 18, 1), 0) of
        01:
          Cedente.TipoInscricao := pFisica;
        02:
          Cedente.TipoInscricao := pJuridica;
        else
          Cedente.TipoInscricao := pOutras;
      end;

      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha];

      if copy(Linha, 8, 1) <> '3' then // verifica se o registro (linha) é um registro detalhe (segmento J)
        Continue;

      if copy(Linha, 14, 1) = 'T' then // se for segmento T cria um novo titulo
         Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin

         {OcorrenciaOriginal.Tipo := CodOcorrenciaToTipo
         (StrToIntDef(copy(Linha, 214, 2), 0));

         MotivoLinha := 214;
         for i := 0 to 3 do
         begin
         MotivoRejeicaoComando.Add(IfThen(copy(Linha, MotivoLinha, 2) = '  ',
         '00', copy(Linha, MotivoLinha, 2)));

         if MotivoRejeicaoComando[i] <> '00' then
         begin
         CodOCorrencia := StrToIntDef(MotivoRejeicaoComando[i], 0);
         DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao
         (OcorrenciaOriginal.Tipo, CodOCorrencia));
         end;

         MotivoLinha := MotivoLinha + 2;
         end; }

         { Espécie do documento }
         { if Trim(Copy(Linha,174,2)) = '' then
          EspecieDoc := '99'
          else
          case StrToInt(Copy(Linha,174,2)) of
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
          }
         if copy(Linha, 14, 1) = 'T' then
         begin
           SeuNumero := copy(Linha, 106, 25);
           NumeroDocumento := copy(Linha, 59, 15);
           Carteira := copy(Linha, 58, 1);

           TempData := copy(Linha, 74, 2) + '/'+copy(Linha, 76, 2)+'/'+copy(Linha, 78, 4);
           if TempData<>'00/00/0000' then
               Vencimento := StringToDateTimeDef(TempData, 0, 'DDMMYY');

           ValorDocumento := StrToFloatDef(copy(Linha, 82, 15), 0) / 100;

           NossoNumero := copy(Linha, 38, 20);
           ValorDespesaCobranca := StrToFloatDef(copy(Linha, 199, 15), 0) / 100;

         end
         else // segmento U
         begin
            ValorIOF := StrToFloatDef(copy(Linha, 63, 15), 0) / 100;
            ValorAbatimento := StrToFloatDef(copy(Linha, 48, 15), 0) / 100;
            ValorDesconto := StrToFloatDef(copy(Linha, 33, 15), 0) / 100;
            ValorMoraJuros := StrToFloatDef(copy(Linha, 18, 15), 0) / 100;
            ValorOutrosCreditos := StrToFloatDef(copy(Linha, 108, 15), 0) / 100;
            ValorRecebido := StrToFloatDef(copy(Linha, 78, 15), 0) / 100;
            TempData := copy(Linha, 138, 2)+'/'+copy(Linha, 140, 2)+'/'+copy(Linha, 142, 4);
            if TempData<>'00/00/0000' then
                DataOcorrencia := StringToDateTimeDef(TempData, 0, 'DDMMYY');
            TempData := copy(Linha, 146, 2)+'/'+copy(Linha, 148, 2)+'/'+copy(Linha, 150, 4);
            if TempData<>'00/00/0000' then            
                DataCredito := StringToDateTimeDef(TempData, 0, 'DDMMYYYY');
         end;
      end;
   end;
end;

end.
