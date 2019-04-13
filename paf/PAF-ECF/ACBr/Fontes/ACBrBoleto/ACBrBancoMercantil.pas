{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   Juliana Rodrigues Prado                       }
{                            :   Agnaldo Pedroni                               }
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

unit ACBrBancoMercantil;

interface

uses
  Classes, SysUtils,ACBrBoleto,
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type

  { TACBrBancoMercantil }

  TACBrBancoMercantil = class(TACBrBancoClass)
  private
    function FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
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

uses ACBrUtil, StrUtils, ACBrValidador;

{ TACBrBancoMercantil }

constructor TACBrBancoMercantil.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 1;
   fpNome   := 'Banco Mercantil';
   fpNumero:= 389;
   fpTamanhoMaximoNossoNum := 6;
end;

function TACBrBancoMercantil.FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
var
  ANossoNumero: string;
begin
    ANossoNumero := padL(ACBrTitulo.ACBrBoleto.Cedente.Agencia,4,'0') + //4
                    '22'                                              + //6
                    ACBrTitulo.Carteira                               + //8
                    padL(ACBrTitulo.NossoNumero, 6, '0')              + //14
                    CalcularDigitoVerificador(ACBrTitulo);              //15

    Result := ANossoNumero;
end;

function TACBrBancoMercantil.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Modulo.CalculoPadrao;
   Modulo.MultiplicadorAtual   := 2;
   Modulo.Documento := ACBrTitulo.ACBrBoleto.Cedente.Agencia +
                       '22' +
                       ACBrTitulo.Carteira +
                       padL(ACBrTitulo.NossoNumero, 6, '0');

   Modulo.Calcular;
   Result:= IntToStr(Modulo.DigitoFinal);
   
end;

function TACBrBancoMercantil.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
var
  FatorVencimento, DigitoCodBarras:String;
  CpObrigatorio , CpLivre:String;
begin

   with ACBrTitulo.ACBrBoleto do
   begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      // comum a todos bancos
      CpObrigatorio := IntToStr( Numero )+  //4
                       '9'               +  //5
                       FatorVencimento   +  //9
                       IntToStrZero(Round(ACBrTitulo.ValorDocumento*100),10);//19

                       // AG+22+01+123456
      CpLivre       := FormataNossoNumero(ACBrTitulo)    + //34
                       padL(Cedente.CodigoCedente,9,'0') + //43
                       ifthen(ACBrTitulo.ValorDesconto > 0,'2','0') ;// ?? indicador Desconto 2-Sem 0-Com  // 44

      DigitoCodBarras := CalcularDigitoCodigoBarras(CpObrigatorio+CpLivre);

   end;

   Result:= IntToStr(Numero) +
            '9'+
            DigitoCodBarras +
            Copy( (CpObrigatorio + CpLivre),5,39);

end;

function TACBrBancoMercantil.MontarCampoNossoNumero (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := Copy(FormataNossoNumero(ACBrTitulo),5,11);
end;

// usado no carnê
function TACBrBancoMercantil.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
             ACBrTitulo.ACBrBoleto.Cedente.Conta+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBancoMercantil.GerarRegistroHeader400(NumeroRemessa : Integer): String;
begin
   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      Result:= '0'                                                          + // ID do Registro
               '1'                                                          + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                                                    + // Literal de Remessa
               '01'                                                         + // Código do Tipo de Serviço
               padL( 'COBRANCA', 15 )                                       + // Descrição do tipo de serviço
               padL( Agencia, 4)                                            + // agencia origem
			         padR( OnlyNumber(CNPJCPF),15,'0')          + // CNPJ/CPF CEDENTE
			         ' '                                        + // BRANCO
			         padL( Nome, 30)                            + // Nome da Empresa
			         '389'                                      + // ID BANCO
			         'BANCO MERCANTIL'                          + // nome banco
			         FormatDateTime('ddmmyy',Now)               + // data geração
               Space(281)                                                   + // espaços branco
			         '01600   '                                 + // densidade da gravação
			         IntToStrZero(NumeroRemessa,5)              + // nr. sequencial remessa
			         IntToStrZero(1,6);                           // Nr. Sequencial de Remessa

      Result:= UpperCase(Result);
   end;
end;

function TACBrBancoMercantil.GerarRegistroTransacao400(ACBrTitulo :TACBrTitulo): String;
var
  DigitoNossoNumero, Ocorrencia, Protesto: String;
  TipoSacado, ATipoAceite: String;
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
         toRemessaAlterarNumeroControle         : Ocorrencia := '08'; {Alteração de seu número}
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
         Protesto := padR(trim(Instrucao1),2,'0') + padR(trim(Instrucao2),2,'0');

      {Pegando Tipo de Sacado}
      case Sacado.Pessoa of
         pFisica   : TipoSacado := '01';
         pJuridica : TipoSacado := '02';
      else
         TipoSacado := '99';
      end;

      { Pegando o Aceite do Titulo }
      case Aceite of
        atSim :  ATipoAceite := 'S';
        atNao :  ATipoAceite := 'N';
      end;

      with ACBrBoleto do
      begin
        Result:= '1'                                              +  // ID Registro
          IfThen( PercentualMulta > 0, '092', '000')              +  // Indica se exite Multa ou não
				  IntToStrZero( round( PercentualMulta * 100 ), 13)       +  // Percentual de Multa formatado com 2 casas decimais
				  FormatDateTime( 'ddmmyy', Vencimento + 1)               +  // data Multa
				  Space(5)                                                +
				  padR( Cedente.CodigoCedente, 9, '0')                    +  // numero do contrato ???
				  padR( SeuNumero,25,'0')                                 +  // Numero de Controle do Participante
          FormataNossoNumero(ACBrTitulo)                          +
          Space(5)                                                +
          padR( OnlyNumber(Cedente.CNPJCPF), 15 , '0')                        +
          IntToStrZero( Round( ValorDocumento * 100 ), 10)        +  // qtde de moeda
          '1'                                                     +  // Codigo Operação 1- Cobrança Simples
          Ocorrencia                                              +
          padL( NumeroDocumento,  10)                             + // numero titulo atribuido pelo cliente
          FormatDateTime( 'ddmmyy', Vencimento)                   +
          IntToStrZero(Round( ValorDocumento * 100 ),13)          +  // valor nominal do titulo
          '389'                                                   +  // banco conbrador
          '00000'                                                 +  // agencia cobradora
          '01'                                                    +  // codigo da especie, duplicata mercantil
          ATipoAceite                                             +  // N
          FormatDateTime( 'ddmmyy', DataDocumento )               +  // Data de Emissão
          padL(Instrucao1,2,'0')                                  +  // instruçoes de cobrança
          padL(Instrucao2,2,'0')                                  +  // instruçoes de cobrança
          IntToStrZero(round(ValorMoraJuros * 100),13)            + // juros mora 11.2
          FormatDateTime( 'ddmmyy', DataDesconto)                 + // data limite desconto
          IntToStrZero(round(ValorDesconto * 100) ,13)            + // valor desconto
          StringOfChar( '0', 13)                                  + // iof - caso seguro
          StringOfChar( '0', 13)                                  + // valor abatimento ?????
          TipoSacado                                              +
          padR( OnlyNumber(Sacado.CNPJCPF),14,'0')                +
          padL( Sacado.NomeSacado, 40, ' ')                       +
          padL( Sacado.Logradouro + Sacado.Numero , 40)           +
          padL( Sacado.Bairro ,12)                                +
          padL( Sacado.CEP, 8 , '0' )                             +
          padL( Sacado.Cidade ,15)                                +
          padL( Sacado.UF, 2)                                     +
          padL( Sacado.Avalista, 30)                              + // Avalista
          Space(12)                                               +
          '1'                                                     + // codigo moeda
          IntToStrZero( ListadeBoletos.IndexOf(ACBrTitulo)+2, 6 );

         Result:= UpperCase(Result);
      end;
   end;
end;

function TACBrBancoMercantil.GerarRegistroTrailler400( ARemessa:TStringList ): String;
begin
   Result:= '9' + Space(393)                     + // ID Registro
            IntToStrZero( ARemessa.Count + 1, 6);  // Contador de Registros
   Result:= UpperCase(Result);
end;


end.

