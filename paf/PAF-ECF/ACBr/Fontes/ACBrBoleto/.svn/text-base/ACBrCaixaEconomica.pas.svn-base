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

{Convênio SIGCB Carteira 1 ou 2 Registrada ou Sem Registro} 

{$I ACBr.inc}

unit ACBrCaixaEconomica;

interface

uses
  Classes, SysUtils, ACBrBoleto,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type

  { TACBrCaixaEconomica}

  TACBrCaixaEconomica = class(TACBrBancoClass)
   protected
   private
    function FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
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
   end;

implementation

uses ACBrUtil, StrUtils, Variants;

constructor TACBrCaixaEconomica.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 9;
   fpNome   := 'Caixa Economica Federal';
   fpNumero:= 104;
   fpTamanhoMaximoNossoNum := 15;
end;

function TACBrCaixaEconomica.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
var
  Num, ACarteira, ANossoNumero, Res :String;
begin
   Result := '0';
   if (ACBrTitulo.Carteira = 'RG') then
      ACarteira := '1'
   else if (ACBrTitulo.Carteira = 'SR')then
      ACarteira := '2'
   else
      raise Exception.Create( ACBrStr('Carteira Inválida.'+sLineBreak+'Utilize "RG" ou "SR"') ) ;

   ANossoNumero := OnlyNumber(ACBrTitulo.NossoNumero);
   
   Num := ACarteira + '4' + PadR(ANossoNumero, 15, '0');
   
   
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

function TACBrCaixaEconomica.CalcularDVCedente(const ACBrTitulo: TACBrTitulo): String;
var
  Num, Res: string;
begin 
    Num := ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente;
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

function TACBrCaixaEconomica.FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
var
  ANossoNumero, AConvenio : string;
begin
   with ACBrTitulo do
   begin
      AConvenio := ACBrBoleto.Cedente.Convenio;
      ANossoNumero := OnlyNumber(NossoNumero);

      if (ACBrTitulo.Carteira = 'RG') then         {carterira registrada}
          ANossoNumero := '14' + padR(ANossoNumero, 15, '0')
      else if (ACBrTitulo.Carteira = 'SR')then     {carteira 2 sem registro}
          ANossoNumero := '24'+padR(ANossoNumero, 15, '0')
      else
        raise Exception.Create( ACBrStr('Carteira Inválida.'+sLineBreak+'Utilize "RG" ou "SR"') ) ;
      
      
   end;

    Result := ANossoNumero;
end;

function TACBrCaixaEconomica.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras, ANossoNumero :String;
  CampoLivre,DVCampoLivre : String;
begin

    FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);
    
    ANossoNumero := FormataNossoNumero(ACBrTitulo);

    {Montando Campo Livre}
    CampoLivre   := ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente + CalcularDVCedente(ACBrTitulo) +
                	Copy(ANossoNumero,3,3) + Copy(ANossoNumero,1,1) +	Copy(ANossoNumero,6,3) +
                    '4' + Copy(ANossoNumero,9,9);
    Modulo.CalculoPadrao;
    Modulo.MultiplicadorFinal   := 2;
    Modulo.MultiplicadorInicial := 9;
    Modulo.Documento := CampoLivre;
    Modulo.Calcular;
    DVCampoLivre := intTostr(Modulo.ModuloFinal);

    if Length(DVCampoLivre) > 1 then
       DVCampoLivre := '0';

    CampoLivre := CampoLivre + DVCampoLivre;
    


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

function TACBrCaixaEconomica.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
  Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia + '/'+
            ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente+'-'+
                CalcularDVCedente(ACBrTitulo);
end;

function TACBrCaixaEconomica.MontarCampoNossoNumero (const ACBrTitulo: TACBrTitulo ) : String;
var ANossoNumero : string;
begin
    ANossoNumero := FormataNossoNumero(ACBrTitulo);

    Result := ANossoNumero + '-' + CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrCaixaEconomica.GerarRegistroHeader240(NumeroRemessa : Integer): String;
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

      Result:= IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
               '0000'                                  + //4 a 7 - Lote de serviço
               '0'                                     + //8 - Tipo de registro - Registro header de arquivo
               padL('', 9, ' ')                        + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscrição do cedente
               padL(CNPJCPF, 14, '0')                  + //19 a 32 -Número de inscrição do cedente
               //padL(CodigoCedente, 18, '0') + '  '     + //33 a 52 - Código do convênio no banco [ Alterado conforme instruções da CSO Brasília ] 27-07-09
               padL('',20, '0')                        +  //33 a 52 - Código do convênio no banco
               padR(Agencia, 5, '0')                   + //53 a 57 - Código da agência do cedente
               padL(AgenciaDigito, 1 , '0')            + //58 - Dígito da agência do cedente
               padL(CodigoCedente, 6, ' ')             + //59 a 64 - Código Cedente (Código do Convênio no Banco)
               padL('', 7, '0')                        + //65 a 71 - Uso Exclusivo CAIXA
               '0'                                     + //72 - Uso Exclusivo CAIXA
               padR(Nome, 30, ' ')                     + //73 a 102 - Nome do cedente
               padR('CAIXA ECONOMICA FEDERAL', 30, ' ') + //103 a 132 - Nome do banco
               padL('', 10, ' ')                       + //133 a 142 - Uso exclusivo FEBRABAN/CNAB
               '1'                                     + //143 - Código de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)         + //144 a 151 - Data do de geração do arquivo
               FormatDateTime('hhmmss', Now)           + //152 a 157 - Hora de geração do arquivo
               padR(IntToStr(NumeroRemessa), 6, '0')   + //158 a 163 - Número seqüencial do arquivo
               '050'                                   + //164 a 166 - Número da versão do layout do arquivo
               padL('',  5, '0')                       + //167 a 171 - Densidade de gravação do arquivo (BPI)
               padL('', 20, '0')                       + // 172 a 191 - Uso reservado do banco
               padL('REMESSA-PRODUCAO', 20, ' ')       + // 192 a 211 - Uso reservado da empresa
               padL('', 4, ' ')                        + // 212 a 215 - Versao Aplicativo Caixa
               padL('', 25, ' ');                        // 216 a 240 - Uso Exclusivo FEBRABAN / CNAB

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
               padL(OnlyNumber(CNPJCPF), 15, '0')      + //19 a 33 -Número de inscrição do cedente
               padL(CodigoCedente, 6, '0')             + //34 a 39 - Código do convênio no banco (código do cedente)
               padL('', 14, '0')                       + //40 a 53 - Uso Exclusivo Caixa
               padR(Agencia, 5 , '0')                  + //54 a 58 - Dígito da agência do cedente
               padL(AgenciaDigito, 1 , '0')            + //59 - Dígito da agência do cedente
               padL(CodigoCedente, 6, '0')             + //60 a 65 - Código do convênio no banco (código do cedente)
               padL('',7,'0')                          + //66 a 72 - Código do Modelo Personalizado (Código fornecido pela CAIXA/gráfica, utilizado somente quando o modelo do bloqueto for personalizado)
               '0'                                     + //73 - Uso Exclusivo Caixa
               padR(Nome, 30, ' ')                     + //74 a 103 - Nome do cedente
               padL('', 40, ' ')                       + //104 a 143 - Mensagem 1 para todos os boletos do lote
               padL('', 40, ' ')                       + //144 a 183 - Mensagem 2 para todos os boletos do lote
               padR(IntToStr(NumeroRemessa), 8, '0')   + //184 a 191 - Número do arquivo
               FormatDateTime('ddmmyyyy', Now)         + //192 a 199 - Data de geração do arquivo
               padL('', 8, '0')                        + //200 a 207 - Data do crédito - Só para arquivo retorno
               padL('', 33, ' ');                        //208 a 240 - Uso exclusivo FEBRABAN/CNAB
   end;
end;

function TACBrCaixaEconomica.GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String;
var
   ATipoInscricao,
   ATipoOcorrencia,
   ATipoBoleto,
   ADataMoraJuros,
   ADataDesconto,
   ANossoNumero,
   ATipoAceite : String;
begin
   with ACBrTitulo do
   begin
      ANossoNumero := FormataNossoNumero(ACBrTitulo);

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
         tbBancoEmite      : ATipoBoleto := '1' + '1';
         tbCliEmite        : ATipoBoleto := '2' + '0';
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
               IntToStrZero((2*ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+1,5) + //9 a 13 - Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'P'                                                        + //14 - Código do segmento do registro detalhe
               ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //16 a 17 - Código de movimento
               padR(ACBrBoleto.Cedente.Agencia, 5, '0')                   + //18 a 22 - Agência mantenedora da conta
               padL(ACBrBoleto.Cedente.AgenciaDigito, 1 , '0')            + //23 -Dígito verificador da agência
               padL(ACBrBoleto.Cedente.CodigoCedente, 6, '0')             + //24 a 29 - Código do Convênio no Banco (Codigo do cedente)
               padL('', 11, '0')                                          + //30 a 40 - Uso Exclusivo da CAIXA
               '14'                                                       + //41 a 42 - Modalidade da Carteira
               padR(Copy(ANossoNumero,3,17), 15, '0')                     + //43 a 57 - Nosso número - identificação do título no banco
               '1'                                                        + //58 - Cobrança Simples
               '1'                                                        + //59 - Forma de cadastramento do título no banco: com cadastramento  1-cobrança Registrada
               '2'                                                        + //60 - Tipo de documento: Tradicional
               ATipoBoleto                                                + //61 e 62(juntos)- Quem emite e quem distribui o boleto?
               //padL(NumeroDocumento, 10, '0')                             + //63 a 73 - Número que identifica o título na empresa [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
               padL(NumeroDocumento, 11, '0')                             + //63 a 73 - Número que identifica o título na empresa
               padL('', 4, ' ')                                           + //74 a 77 - Uso Exclusivo Caixa
               FormatDateTime('ddmmyyyy', Vencimento)                     + //78 a 85 - Data de vencimento do título
               IntToStrZero( round( ValorDocumento * 100), 15)            + //86 a 100 - Valor nominal do título
               padL('', 5, '0')                                           + //101 a 105 - Agência cobradora. Se ficar em branco, a caixa determina automaticamente pelo CEP do sacado
               '0'                                                        + //106 - Dígito da agência cobradora
               padL(EspecieDoc,2)                                         + //107 a 108 - Espécie do documento
               ATipoAceite                                                + //109 - Identificação de título Aceito / Não aceito
               FormatDateTime('ddmmyyyy', DataDocumento)                  + //110 a 117 - Data da emissão do documento
               IfThen(ValorMoraJuros > 0, '1', '0')                       + //118 - Código de juros de mora: Valor por dia
               ADataMoraJuros                                             + //119 a 126 - Data a partir da qual serão cobrados juros
               IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15), padL('', 15, '0')) + //127 a 141 - Valor de juros de mora por dia
               IfThen(ValorDesconto > 0, '1', '0')                        + //142 - Código de desconto: Valor fixo até a data informada
               ADataDesconto                                              + //143 a 150 - Data do desconto
               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),padL('', 15, '0'))+ //151 a 165 - Valor do desconto por dia
               IntToStrZero( round(ValorIOF * 100), 15)                   + //166 a 180 - Valor do IOF a ser recolhido
               IntToStrZero( round(ValorAbatimento * 100), 15)            + //181 a 195 - Valor do abatimento
               padL(SeuNumero, 25, ' ')                                   + //196 a 220 - Identificação do título na empresa
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento), '1', '3') + //221 - Código de protesto: Protestar em XX dias corridos
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                    padL(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00') + //222 a 223 - Prazo para protesto (em dias corridos)
               '2'                                                        + //224 - Código para baixa/devolução: Não baixar/não devolver
               padL('',3,'0')                                             + //225 a 227 - Prazo para baixa/devolução (em dias corridos)
               '09'                                                       + //228 a 229 - Código da moeda: Real
               padL('', 10 , '0')                                         + //230 a 239 - Uso Exclusivo CAIXA
               ' ';                                                         //240 - Uso exclusivo FEBRABAN/CNAB

      {SEGMENTO Q}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - Código do banco
               '0001'                                                     + //4 a 7 - Número do lote
               '3'                                                        + //8 - Tipo do registro: Registro detalhe
               IntToStrZero((2 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 2 ,5) + //9 a 13 - Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'Q'                                                        + //14 - Código do segmento do registro detalhe
               ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //16 a 17 - Código de movimento
                   {Dados do sacado}
               ATipoInscricao                                             + //18 - Tipo inscricao
               padL(OnlyNumber(Sacado.CNPJCPF), 15, '0')                  + //19 a 33 - Número de Inscrição
               padL(Sacado.NomeSacado, 40, ' ')                           + //34 a 73 - Nome sacado
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') + //74 a 113 - Endereço
               padL(Sacado.Bairro, 15, ' ')                               + // 114 a 128 - bairro sacado
               padR(Sacado.CEP, 8, '0')                                   + // 129 a 133 e 134 a 136- cep sacado prefixo e sufixo sem o traço"-" somente numeros
               padR(Sacado.Cidade, 15, ' ')                               + // 137 a 151 - cidade sacado
               padL(Sacado.UF, 2, ' ')                                    + // 152 a 153 - UF sacado
                        {Dados do sacador/avalista}
               '0'                                                        + //154 - Tipo de inscrição: Não informado
               padL('', 15, '0')                                          + //155 a 169 - Número de inscrição
               padL('', 40, ' ')                                          + //170 a 209 - Nome do sacador/avalista
               padL('', 3, ' ')                                           + //210 a 212 - Uso exclusivo FEBRABAN/CNAB
               padL('',20, ' ')                                           + //213 a 232 - Uso exclusivo FEBRABAN/CNAB
               padL('', 8, ' ');                                            //233 a 240 - Uso exclusivo FEBRABAN/CNAB
      end;
end;

function TACBrCaixaEconomica.GerarRegistroTrailler240( ARemessa : TStringList ): String;
begin
   {REGISTRO TRAILER DO LOTE}
   Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
            '9999'                                                     + //Lote de Serviço
            '5'                                                        + //Tipo do registro: Registro trailer do lote
            Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
            IntToStrZero((2*ARemessa.Count), 6)                      + //Quantidade de Registro no Lote
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            padL('',6,  '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Quantidade de Títulos em Carteiras
            padL('',31, ' ')                                           + //Uso exclusivo FEBRABAN/CNAB
            padL('',117,' ')                                           ; //Uso exclusivo FEBRABAN/CNAB}

   {GERAR REGISTRO TRAILER DO ARQUIVO}
   Result:= Result + #13#10 +
            IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
            '9999'                                                     + //Lote de serviço
            '9'                                                        + //Tipo do registro: Registro trailer do arquivo
            padL('',9,' ')                                             + //Uso exclusivo FEBRABAN/CNAB}
            '000001'                                                   + //Quantidade de lotes do arquivo}
            IntToStrZero((2*ARemessa.Count)+2, 6)                      + //Quantidade de registros do arquivo, inclusive este registro que está sendo criado agora}
            padL('',6,' ')                                             + //Uso exclusivo FEBRABAN/CNAB}
            padL('',205,' ');                                            //Uso exclusivo FEBRABAN/CNAB}
end;
procedure TACBrCaixaEconomica.LerRetorno240(ARetorno: TStringList);
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

   rCedente := trim(Copy(ARetorno[0],73,30));
   rAgencia := trim(Copy(ARetorno[0],53,5));
   rConta   := trim(Copy(ARetorno[0],59,5));
   rDigitoConta := Copy(ARetorno[0],64,1);


   ACBrBanco.ACBrBoleto.DataArquivo   := StringToDateTimeDef(Copy(ARetorno[1],192,2)+'/'+
                                                             Copy(ARetorno[1],194,2)+'/'+
                                                             Copy(ARetorno[1],198,2),0, 'DD/MM/YY' );

   ACBrBanco.ACBrBoleto.DataCreditoLanc := StringToDateTimeDef(Copy(ARetorno[1],200,2)+'/'+
                                                               Copy(ARetorno[1],202,2)+'/'+
                                                               Copy(ARetorno[1],204,2),0, 'DD/MM/YY' );
   rCNPJCPF := trim( Copy(ARetorno[0],19,14)) ;

   case StrToIntDef(Copy(ARetorno[1],18,1),0) of
      1 : rCNPJCPF:= trim( Copy(ARetorno[1],19,14));
      2 : rCNPJCPF:= trim( Copy(ARetorno[0],19,14));
   else
      rCNPJCPF:= trim( Copy(ARetorno[0],19,14));
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

      case StrToIntDef(Copy(ARetorno[1],18,1),0) of
         1: Cedente.TipoInscricao:= pFisica;
         2: Cedente.TipoInscricao:= pJuridica;
         else
            Cedente.TipoInscricao := pOutras;
      end;

      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
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
         NumeroDocumento             := copy(Linha,48,9);
         OcorrenciaOriginal.Tipo     := CodOcorrenciaToTipo(StrToIntDef(
                                        copy(Linha,16,2),0));
         //05 = Liquidação Sem Registro
         Vencimento := StringToDateTimeDef( Copy(Linha,74,2)+'/'+
                                            Copy(Linha,76,2)+'/'+
                                            Copy(Linha,78,2),0, 'DD/MM/YY' );

         ValorDocumento       := StrToFloatDef(Copy(Linha,82,15),0)/100;
         ValorRecebido        := StrToFloatDef(Copy(Linha,82,15),0)/100;
         NossoNumero          := copy( Copy(Linha,48,9),Length( Copy(Linha,48,9) )-TamanhoMaximoNossoNum  ,TamanhoMaximoNossoNum);
         Carteira             := Copy(Linha,40,2);

         end //if segmento
         else
      if Copy(Linha,14,1)= 'U' then //segmento U
        begin

         if StrToIntDef(Copy(Linha,138,6),0) <> 0 then
            DataOcorrencia := StringToDateTimeDef( Copy(Linha,138,2)+'/'+
                                                Copy(Linha,140,2)+'/'+
                                                Copy(Linha,142,4),0, 'DD/MM/YYYY' );

         if StrToIntDef(Copy(Linha,146,6),0) <> 0 then
            DataCredito:= StringToDateTimeDef( Copy(Linha,146,2)+'/'+
                                               Copy(Linha,148,2)+'/'+
                                               Copy(Linha,150,4),0, 'DD/MM/YYYY' );


         ValorIOF             := StrToFloatDef(Copy(Linha,63,15),0)/100;
         ValorAbatimento      := StrToFloatDef(Copy(Linha,48,15),0)/100;
         ValorDesconto        := StrToFloatDef(Copy(Linha,33,15),0)/100;
         ValorMoraJuros       := StrToFloatDef(Copy(Linha,18,15),0)/100;
         ValorOutrosCreditos  := StrToFloatDef(Copy(Linha,123,15),0)/100;
         ValorDespesaCobranca := StrToFloatDef(Copy(Linha,108,15),0)/100;
         ValorOutrasDespesas  := StrToFloatDef(Copy(Linha,108,15),0)/100;

        end;//if Copy(Linha,14,1)= 'U' then //segmento U


      end; //with


   end; //for

end;

end.
