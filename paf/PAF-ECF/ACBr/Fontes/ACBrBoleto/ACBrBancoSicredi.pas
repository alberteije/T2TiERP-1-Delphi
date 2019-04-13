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

unit ACBrBancoSicredi;

interface

uses
  Classes, SysUtils,ACBrBoleto,
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type

  { TACBrBancoSicredi }

  TACBrBancoSicredi = class(TACBrBancoClass)
  protected
  public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo:TACBrTitulo): String; override;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroHeader400(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler400(ARemessa:TStringList): String;  override;
  end;

implementation

uses ACBrUtil, StrUtils;

{ TACBrBancoSicredi }


constructor TACBrBancoSicredi.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 10;
   fpNome   := 'Sicredi';
   fpNumero:= 748;
   fpTamanhoMaximoNossoNum := 8;
   fpTamanhoAgencia := 4;
   fpTamanhoConta   := 5;
   fpTamanhoCarteira:= 1;
end;

function TACBrBancoSicredi.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal := 7;
   Modulo.Documento := ACBrTitulo.ACBrBoleto.Cedente.Agencia +
                       ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito +
                       ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente +
                       ACBrTitulo.NossoNumero;
   Modulo.Calcular;

   if Modulo.ModuloFinal = 1 then
      Result := '1'
   else
      if Modulo.DigitoFinal > 9 then
         result := '0'
      else
         Result := IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoSicredi.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras, CampoLivre, Modalidade:String;
  DigitoNum: Integer;
begin
   with ACBrTitulo.ACBrBoleto do
   begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);
      Modalidade := IfThen(Cedente.Modalidade='','1',Cedente.Modalidade);

      { Monta o campo livre }
      CampoLivre :=   Modalidade                            + { 1-Sem registro ou 3-Com registro. Por enquanto vou deixar 1 mais tenho que tratar menhor essa informação }
                      '1'                                   + { 1-Carteira simples }
                      padR(ACBrTitulo.NossoNumero,8,'0')    + { Nosso número }
                      CalcularDigitoVerificador(ACBrTitulo) + { Dígito verificador do nosso número }
                      Cedente.Agencia                       + { Código agência (cooperativa) }
                      padR(Cedente.AgenciaDigito,2,'0')     + { Dígito da agência (posto da cooperativa) }
                      Cedente.Conta                         + { Código cedente = Número da conta }
                      '1'                                   + { Filler - zero. Obs: Será 1 quando o valor do documento for diferente se zero }
                      '0';                                    { Filler - zero }
      { Calcula o dígito do campo livre }
      Modulo.CalculoPadrao;
      Modulo.MultiplicadorFinal := 9;
      Modulo.Documento := CampoLivre;
      Modulo.Calcular;
      CampoLivre := CampoLivre + IntToStr(Modulo.DigitoFinal);

      { Monta o código de barras }
      CodigoBarras := IntToStr( Numero )                                     + { Código do banco 748 }
                      '9'                                                    + { Fixo '9' }
                      FatorVencimento                                        + { Fator de vencimento, não obrigatório }
                      IntToStrZero(Round(ACBrTitulo.ValorDocumento*100),10)  + { valor do documento }
                      CampoLivre;                                              { Campo Livre }



      DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
      DigitoNum := StrToIntDef(DigitoCodBarras,0);

      if (DigitoNum = 0) or (DigitoNum > 9) then
          DigitoCodBarras:= '1';
   end;

   Result:= IntToStr(Numero) + '9'+ DigitoCodBarras + Copy(CodigoBarras,5,39);
end;

function TACBrBancoSicredi.MontarCampoNossoNumero (const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result:= copy(ACBrTitulo.NossoNumero,1,2)+'/'+copy(ACBrTitulo.NossoNumero,3,6)+'-'+CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoSicredi.MontarCampoCodigoCedente (const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'.'+
             ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'.'+
             ACBrTitulo.ACBrBoleto.Cedente.Conta;
end;

function TACBrBancoSicredi.GerarRegistroHeader400(NumeroRemessa : Integer): String;
begin
   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      Result:= '0'                               + // ID do Registro
               '1'                               + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                         + // Literal de Remessa
               '01'                              + // Código do Tipo de Serviço
               padL( 'COBRANCA', 15 )            + // Descrição do tipo de serviço
               padR( CodigoCedente, 5, '0')      + // Codigo da Empresa no Banco
               padR( OnlyNumber(CNPJCPF), 14, '0')           + // CNPJ do Cedente
               Space(31)                         + // Fillers - Branco
               '748'                             + // Número do banco
               padL('SICREDI', 15)               + // Código e Nome do Banco(237 - Bradesco)
               FormatDateTime('yyyymmdd',Now)    + // Data de geração do arquivo
               Space(8)                          + // Filler - Brancos
               IntToStrZero(NumeroRemessa,7)     + // Nr. Sequencial de Remessa + brancos
               Space(273)                        + // Filler - Brancos
               '2.00'                            + // Versão do sistema
               IntToStrZero(1,6);                  // Nr. Sequencial de Remessa + brancos + Contador

      Result:= UpperCase(Result);
   end;
end;

function TACBrBancoSicredi.GerarRegistroTransacao400(ACBrTitulo :TACBrTitulo): String;
var
  DigitoNossoNumero, Ocorrencia, Protesto: String;
  TipoSacado: String;
  TipoBoleto: Char;
begin

   with ACBrTitulo do
   begin
      DigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

      {Pegando Código da Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                        : Ocorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento            : Ocorrencia := '04'; {Concessão de Abatimento}
         toRemessaCancelarAbatimento            : Ocorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento             : Ocorrencia := '06'; {Alteração de vencimento}
         //toRemessaAlterarNumeroControle         : Ocorrencia := '08'; {Alteração de seu número}
         toRemessaProtestar                     : Ocorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarIntrucaoProtestoBaixa : Ocorrencia := '18'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto     : Ocorrencia := '19'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias             : Ocorrencia := '31'; {Alteração de Outros Dados}
      else
         Ocorrencia := '01';                                          {Remessa}
      end;

      {Pegando Tipo de Boleto}
      case ACBrBoleto.Cedente.ResponEmissao of
         tbCliEmite : TipoBoleto := '2';
      else
         TipoBoleto := '1';
      end;

      {Pegando campo Intruções}
      if (DataProtesto > 0) and (DataProtesto > Vencimento) then
          Protesto := '06' + IntToStrZero(DaysBetween(DataProtesto,Vencimento),2)
      else if Ocorrencia = '31' then
         Protesto := '9999'
      else
         Protesto := padR(trim(Instrucao1),2,'0')+padR(trim(Instrucao2),2,'0');

      {Pegando Tipo de Sacado}
      case Sacado.Pessoa of
         pFisica   : TipoSacado := '01';
         pJuridica : TipoSacado := '02';
      else
         TipoSacado := '99';
      end;

      with ACBrBoleto do
      begin
         Result:= '1'                                                     +  // ID Registro
                  'A'                                                     +  // Tipo de cobrança = "A" SICREDI com registro
                  'A'                                                     +  // Tipo de carteira = "A" Simples
                  'A'                                                     +  // Tipo de impressão = "A" Normal "B" Carnê
                  Space(12)                                               +  // Filler
                  'A'                                                     +  // Tipo de moeda = "A" Real
                  'A'                                                     +  // Tipo de desconto: "A" Valor "B" percentual
                  'A'                                                     +  // Tipo de juro: "A" Valor "B" percentual
                  Space(28)                                               +  // Filler - Brancos
                  padR(NossoNumero+DigitoNossoNumero,9,'0')               +  // Nosso número sem edição YYXNNNNND - YY=Ano, X-Emissao, NNNNN-Sequência, D-Dígito
                  Space(6)                                                +  // Brancos
                  FormatDateTime( 'yyyymmdd', date)                       +  // Data da instrução
                  padR( Cedente.Conta, 7, '0')                            +
                  Cedente.ContaDigito                                     +
                  padL( SeuNumero,25,' ') +'000'                          +  // Numero de Controle do Participante
                  IfThen( PercentualMulta > 0, '2', '0')                  +  // Indica se exite Multa ou não
                  IntToStrZero( round( PercentualMulta * 100 ), 4)        +  // Percentual de Multa formatado com 2 casas decimais
                  IntToStrZero( round( ValorDesconto * 100), 10)          +
                  TipoBoleto + 'N' + Space(10)                            +  // Tipo Boleto(Quem emite) + 'N'= Nao registrar p/ Débito automático
                  ' ' + '0' + '  ' + Ocorrencia                           +  // Ind. Rateio de Credito + Aviso de Debito Aut. + Ocorrência
                  padL( NumeroDocumento,  10)                             +
                  FormatDateTime( 'ddmmyy', Vencimento)                   +
                  IntToStrZero( Round( ValorDocumento * 100 ), 13)        +
                  StringOfChar('0',8) + EspecieDoc + 'N'                  +  // Zeros + Especie do documento + Idntificação(valor fixo N)
                  FormatDateTime( 'ddmmyy', DataDocumento )               +  // Data de Emissão
                  Protesto                                                +
                  IntToStrZero( round(ValorMoraJuros * 100 ), 13)         +
                  IfThen(DataDesconto < EncodeDate(2000,01,01),'000000',FormatDateTime( 'ddmmyy', DataDesconto)) +
                  IntToStrZero( round( ValorDesconto * 100 ), 13)         +
                  IntToStrZero( round( ValorIOF * 100 ), 13)              +
                  IntToStrZero( round( ValorAbatimento * 100 ), 13)       +
                  TipoSacado + padR(OnlyNumber(Sacado.CNPJCPF),14,'0')    +
                  padL( Sacado.NomeSacado, 40, ' ')                       +
                  padL( Sacado.Logradouro + Sacado.Numero              +
                           Sacado.Bairro + Sacado.Cidade + Sacado.UF, 40) +
                  space(12) + padL( Sacado.CEP, 8 )                       +
                  padl( Mensagem.Text, 60 )                               +
                  IntToStrZero( ListadeBoletos.IndexOf(ACBrTitulo)+2, 6 );

         Result:= UpperCase(Result);
      end;
   end;
end;

function TACBrBancoSicredi.GerarRegistroTrailler400( ARemessa:TStringList ): String;
begin
   Result:= '9' + Space(393)                     + // ID Registro
            IntToStrZero( ARemessa.Count + 1, 6);  // Contador de Registros
   Result:= UpperCase(Result);
end;


end.

