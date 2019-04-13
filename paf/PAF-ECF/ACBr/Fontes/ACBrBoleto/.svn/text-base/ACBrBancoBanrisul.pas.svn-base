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

unit ACBrBancoBanrisul;

interface

uses
  Classes, SysUtils, ACBrBoleto,
{$IFDEF COMPILER6_UP}dateutils{$ELSE}ACBrD5{$ENDIF};

type

  { TACBrBancoBanrisul }

  TACBrBanrisul=class(TACBrBancoClass)
  Protected
  Public
    constructor create(AOwner: TACBrBanco);
    function MontarCodigoBarras(const ACBrTitulo: TACBrTitulo): string; Override;
    function MontarCampoNossoNumero(const ACBrTitulo: TACBrTitulo): string; Override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): string; Override;
    function GerarRegistroHeader400(NumeroRemessa: Integer): string; Override;
    function GerarRegistroTransacao400(ACBrTitulo: TACBrTitulo): string; Override;
    function GerarRegistroTrailler400(ARemessa: TStringList): string; Override;
    function CalculaDigitosChaveASBACE(ChaveASBACESemDigito: string): string;
    procedure LerRetorno400(ARetorno: TStringList); override;
    function GerarRegistroHeader240(NumeroRemessa: Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa: TStringList): String; override;
    procedure LerRetorno240(ARetorno: TStringList); override;

    function CodOcorrenciaToTipo(const CodOcorrencia: String): TACBrTipoOcorrencia; overload;
    function CodMotivoRejeicaoToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: String): String; overload;
  end;

implementation

uses ACBrUtil, StrUtils, ACBrValidador;

var
  aTotal: Extended;

{ TACBrBancoBanrisul }

constructor TACBrBanrisul.create(AOwner: TACBrBanco);
begin
  inherited create(AOwner);
  fpDigito:=8;
  fpNome:='Banrisul';
  fpNumero:= 041;
  fpTamanhoMaximoNossoNum:=8;

  fpTamanhoAgencia:= 4;
  fpTamanhoConta  := 7;
  fpTamanhoCarteira:= 2;
end;

function Modulo11(Valor: string; Base: Integer=9; Resto: boolean=false): string;
var
  Soma: integer;
  Contador, Peso, Digito: integer;
begin
  Soma:=0;
  Peso:=2;
  for Contador:=Length(Valor)downto 1 do
  begin
    Soma:=Soma+(StrToInt(Valor[Contador])*Peso);
    if Peso<Base then
      Peso:=Peso+1
    else
      Peso:=2;
  end;

  if Resto then
    Result:=IntToStr(Soma mod 11)
  else
  begin
    Digito:=11-(Soma mod 11);
    if (Digito>9) then
      Digito:=0;
    Result:=IntToStr(Digito);
  end
end;

function TACBrBanrisul.CalculaDigitosChaveASBACE(ChaveASBACESemDigito: string): string;
{Calcula os 2 dígitos usados na CHAVE ASBACE - Código usado por bancos estaduais}
var
  Digito1, Digito2: integer;

  function CalcularDigito1(ChaveASBACESemDigito: string): integer;
   {
    Calcula o primeiro dígito.
    O cálculo é parecido com o da rotina Modulo10. Porém, não faz diferença o
    número de dígitos de cada subproduto.
    Se o resultado da operação for 0 (ZERO) o dígito será 0 (ZERO). Caso contrário,
    o dígito será igual a 10 - Resultado.
   }
  var
    Auxiliar, Soma, Contador, Peso, Digito1: integer;
  begin
    Soma:=0;
    Peso:=2;
    for Contador:=Length(ChaveASBACESemDigito)downto 1 do
    begin
      Auxiliar:=(StrToInt(ChaveASBACESemDigito[Contador])*Peso);
      if Auxiliar>9 then
        Auxiliar:=Auxiliar-9;
      Soma:=Soma+Auxiliar;
      if Peso=1 then
        Peso:=2
      else
        Peso:=1;
    end;

    Digito1:=Soma mod 10;
    if (Digito1=0) then
      Result:=Digito1
    else
      Result:=10-Digito1;
  end;

  function CalcularDigito2(ChaveASBACESemDigito: string; var Digito1: integer):
      integer;
   {Calcula o segundo dígito}
  var
    Digito2: integer;
    ChaveASBACEComDigito1: string;
  begin
    ChaveASBACEComDigito1:=ChaveASBACESemDigito+IntToStr(Digito1);
    Digito2:=StrToInt(Modulo11(ChaveASBACEComDigito1, 7, true));
    {Se dígito2 = 1, deve-se incrementar o dígito1 e recalcular o dígito2}
    if Digito2=1 then
    begin
      Digito1:=Digito1+1;
         {Se, após incrementar o dígito1, ele ficar maior que 9, deve-se
          substituí-lo por 0}
      if Digito1>9 then
        Digito1:=0;
      Digito2:=CalcularDigito2(ChaveASBACESemDigito, Digito1);
    end
    else if Digito2>1 then
    begin
      Digito2:=11-Digito2;
    end;

    Result:=Digito2;
  end;

begin
  Digito1:=CalcularDigito1(ChaveASBACESemDigito);
  Digito2:=CalcularDigito2(ChaveASBACESemDigito, Digito1);

  Result:=IntToStr(Digito1)+IntToStr(Digito2);
end;

function TACBrBanrisul.MontarCodigoBarras(const ACBrTitulo: TACBrTitulo): string;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras, CampoLivre, Modalidade: string;
  DigitoNum: Integer;
begin
  with ACBrTitulo do
  begin
     if ACBrBoleto.Cedente.ResponEmissao = tbCliEmite then
        Modalidade:='2'
     else
        Modalidade:='1';

     FatorVencimento:=CalcularFatorVencimento(ACBrTitulo.Vencimento);

     CampoLivre:= Modalidade +'1'+
                  padR(copy(ACBrBoleto.Cedente.Agencia,2,3), 3, '0')+{ Código agência (cooperativa) }
                  padR(ACBrBoleto.Cedente.Conta, 7, '0')+{ Código cedente = Número da conta }
                  padR(NossoNumero, 8, '0')+{ Nosso número }
                  '041';

     {Calculando Módulo 10}
     Modulo.MultiplicadorInicial:= 1;
     Modulo.MultiplicadorFinal:= 2;
     Modulo.MultiplicadorAtual:= 2;
     Modulo.FormulaDigito := frModulo10;
     Modulo.Documento := CampoLivre;
     Modulo.Calcular;
     CampoLivre := CampoLivre +  IntToStr(Modulo.DigitoFinal);

     {Calculando Módulo 11}
     Modulo.CalculoPadrao;
     Modulo.MultiplicadorFinal:= 7;
     Modulo.Documento:= CampoLivre;
     Modulo.Calcular;

     if (Modulo.ModuloFinal >= 10) or (Modulo.ModuloFinal < 1) then
        CampoLivre := CampoLivre +'1'
     else
        CampoLivre := CampoLivre + IntToStr(Modulo.DigitoFinal);

     CodigoBarras:= PadR(IntToStr(Numero), 3, '0')+'9'+
                    FatorVencimento+{ Fator de vencimento, não obrigatório }
                    IntToStrZero(Round(ACBrTitulo.ValorDocumento*100), 10)+{ valor do documento }
                    CampoLivre; { Campo Livre }

     DigitoCodBarras:=CalcularDigitoCodigoBarras(CodigoBarras);
     DigitoNum:=StrToIntDef(DigitoCodBarras, 0);

     if (DigitoNum = 0) or (DigitoNum > 9) then
        DigitoCodBarras:='1';
  end;

  Result:=PadR(IntToStr(Numero), 3, '0')+'9'+DigitoCodBarras+Copy(CodigoBarras, 5, 39);
end;

function TACBrBanrisul.MontarCampoNossoNumero(const ACBrTitulo: TACBrTitulo): string;
begin
  Result:=PadR(ACBrTitulo.NossoNumero, 8, '0');
  result:=Result+'.'+CalculaDigitosChaveASBACE(Result);
end;

function TACBrBanrisul.MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): string;
begin
  Result:=copy(ACBrTitulo.ACBrBoleto.Cedente.Agencia, 1, 4)+'-'+
    copy(ACBrTitulo.ACBrBoleto.Cedente.Agencia, 5, 1)+
    ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
    ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente;
end;

function TACBrBanrisul.GerarRegistroHeader400(NumeroRemessa: Integer): string;
var
  cd: string;
begin
  aTotal:=0;
  with ACBrBanco.ACBrBoleto.Cedente do
  begin
    cd:= OnlyNumber(CodigoCedente);

    Result:= '0'                                   + // ID do Registro
             '1'                                   + // ID do Arquivo( 1 - Remessa)
             'REMESSA'                             + // Literal de Remessa
             space(17)                             + // brancos 17
             padR(copy(Agencia, 1, 4)+cd, 13, '0') + // Codigo da Empresa no Banco
             space(7)                              +
             padR(Nome, 30, ' ')                   + // nome do Cedente
             '041'                                 + // Número do banco
             padL('BANRISUL', 8)                   + // Código e Nome do Banco(041 - Banrisul)
             space(7)                              + //brancos
             FormatDateTime('ddmmyy', Now)         + // Data de geração do arquivo
             Space(9)                              + // Filler - Brancos
             space(4)                              + //8808 teste carteira R S X ou 0808 producao carteira R S X
             ' '                                   +
             space(1)                              + //teste X producao P para carteiras R S X
             ' '                                   +
            space(10)                              +
            Space(268)                             + // Filler - Brancos
            IntToStrZero(NumeroRemessa, 6);          // Nr. Sequencial de Remessa + brancos + Contador

    Result:=UpperCase(Result);
  end;
end;

function TACBrBanrisul.GerarRegistroTransacao400(ACBrTitulo: TACBrTitulo): string;
var
  Ocorrencia, Protesto, cd: string;
  TipoSacado, aTipoAceite: string;
  TipoBoleto: Char;
begin
  Protesto := '';
  with ACBrTitulo do
  begin

      {Pegando Código da Ocorrencia}
    case OcorrenciaOriginal.Tipo of
      toRemessaBaixar            : Ocorrencia:='02'; {Pedido de Baixa}
      toRemessaConcederAbatimento: Ocorrencia:='04'; {Concessão de Abatimento}
      toRemessaCancelarAbatimento: Ocorrencia:='05'; {Cancelamento de Abatimento concedido}
      toRemessaAlterarVencimento : Ocorrencia:='06'; {Alteração de vencimento}
      //toRemessaAlterarNumeroControle         : Ocorrencia := '08'; {Alteração de seu número}
      toRemessaProtestar                    : Ocorrencia :='09'; {Pedido de protesto}
      toRemessaCancelarIntrucaoProtestoBaixa: Ocorrencia:='18'; {Sustar protesto e baixar}
      toRemessaCancelarInstrucaoProtesto    : Ocorrencia:='19'; {Sustar protesto e manter na carteira}
      toRemessaOutrasOcorrencias: Ocorrencia:='31'; {Alteração de Outros Dados}
    else
      Ocorrencia:='01'; {Remessa}
    end;

      {Pegando Tipo de Boleto}
    if (ACBrBoleto.Cedente.ResponEmissao = tbCliEmite) then
      TipoBoleto:='2'
    else
      TipoBoleto:='1';

    { Pegando o Aceite do Titulo }
    case Aceite of
      atSim: ATipoAceite:='A';
      atNao: ATipoAceite:='N';
    end;

    {Pegando Tipo de Sacado}
    case Sacado.Pessoa of
      pFisica  : TipoSacado := '01';
      pJuridica: TipoSacado := '02';
    else
      TipoSacado:='99';
    end;

    with ACBrBoleto do
    begin
      cd:= OnlyNumber(Cedente.CodigoCedente);

      Result:= '1'                                                              + // ID Registro
               space(16)                                                        +
               padL(copy(Cedente.Agencia, 1, 4)+cd, 13, '0')                    + // Codigo da Empresa no Banco
               space(7)                                                         +
               space(25)                                                        +
               PadL(NossoNumero, 8, '0')+CalculaDigitosChaveASBACE(NossoNumero) +
               space(32)                                                        +
               space(3)                                                         +
               '1'                                                              +
               '01'                                                             +
               padR(NumeroDocumento, 10)                                        +
               FormatDateTime('ddmmyy', Vencimento)                             +
               IntToStrZero(Round(ValorDocumento*100), 13)                      +
               '041'                                                            +
               space(5)                                                         +
               Carteira                                                         +
               aTipoAceite                                                      +
               FormatDateTime('ddmmyy', DataDocumento)                          +// Data de Emissão
               PadR(Instrucao1, 2)                                              +
               PadR(Instrucao2, 2)                                              +
               '1'                                                              +
               FormatCurr('000000000000', ValorMoraJuros*100)                   +
               '000000'                                                         +
               '0000000000000'                                                  +
               '0000000000000'                                                  +
               '0000000000000'                                                  +
               TipoSacado                                                       +
               PadL(OnlyNumber(Sacado.CNPJCPF), 14, '0')                        +
               PadL(Sacado.NomeSacado, 35)                                      +
               space(5)                                                         +
               PadL(Sacado.Logradouro+' '+
                    Sacado.Numero+' '+
                    Sacado.Complemento, 40)                                     +
               space(7)                                                         +
               '000'                                                            +
               '00'                                                             +
               PadL(OnlyNumber(Sacado.CEP), 8, '0')                             +
               PadL(Sacado.Cidade, 15)                                          +
               PadL(Sacado.UF, 2)                                               +
               '0000'+
               space(1)+
               '0000000000000'                                                  +
               PadR(Protesto, 2, '0')                                           +
               space(23)                                                        +
               IntToStrZero(ListadeBoletos.IndexOf(ACBrTitulo)+2, 6);

      aTotal:=aTotal+ValorDocumento;

      Result:=UpperCase(Result);
    end;
  end;
end;

function TACBrBanrisul.GerarRegistroTrailler400(ARemessa: TStringList): string;
begin
  Result:='9'+
    space(26)+
    FormatCurr('0000000000000', aTotal*100)+
    space(354)+
    IntToStrZero(ARemessa.Count+1, 6); // Contador de Registros

  Result:=UpperCase(Result);
end;

function TACBrBanrisul.GerarRegistroHeader240(
  NumeroRemessa: Integer): String;
var TipoInsc: String;
begin
  case ACBrBanco.ACBrBoleto.Cedente.TipoInscricao of
     pFisica:   TipoInsc := '1';
     pJuridica: TipoInsc := '2';
  else 
     TipoInsc := '9';
  end;

  with ACBrBanco.ACBrBoleto.Cedente do 
  begin
     Result := '041'+                                             //   1 -   3   Código do banco
               DupeString('0', 4) +                               //   4 -   7   Lote de serviço
               '0' +                                              //   8 -   8   Registro header de arquivo
               Space(9) +                                         //   9 -  17   Uso exclusivo FEBRABAN/CNAB
               TipoInsc +                                         //  18 -  18   Tipo de inscrição
               OnlyNumber(CNPJCPF) +                              //  19 -  32   Número de inscrição da empresa (Não considerado)
               padR(OnlyNumber(Convenio), 13, '0') +              //  33 -  45   Código do convênio
               Space(7) +                                         //  46 -  52   Brancos
               '00'+                                              //  53 -  54   Zeros
               padR(OnlyNumber(Agencia), 3, '0') +                //  55 -  57   Agência (Não considerado)
               AgenciaDigito +                                    //  58 -  58   Dígito agência (Não considerado)
               padR(OnlyNumber(Conta), 12, '0') +                 //  59 -  70   Número da conta (Não considerado)
               ContaDigito +                                      //  71 -  71   Dígito da conta (Não considerado)
               Space(1) +                                         //  72 -  72   Dígito verificador da agência/conta (Não considerado)
               padL(Nome, 30) +                                   //  73 - 102   Nome do cedente
               padL(UpperCase(ACBrBanco.Nome), 30) +           // 103 - 132   Nome do banco
               Space(10) +                                        // 133 - 142   Uso exclusivo FEBRABAN/CNAB
               '1'+                                               // 143 - 143   Código remessa
               FormatDateTime('ddmmyyyyhhnnss', Now) +            // 144 - 157   Data e hora da geração do arquivo
               IntToStrZero(NumeroRemessa, 6) +                   // 158 - 163   Número sequencial do arquivo
               '040'+                                             // 164 - 166   Número da versão do layout do arquivo
               DupeString('0', 5) +                               // 167 - 171   Densidade de gravação do arquivo
               Space(69);                                         // 172 - 240   Outros campos

     Result := Result + #13#10 +
               '041' +                                            //   1 -   3   Código do banco
               '0001' +                                           //   4 -   7   Lote de serviço
               '1'+                                               //   8 -   8   Registro header de lote
               'R'+                                               //   9 -   9   Tipo de operação
               '01'+                                              //  10 -  11   Tipo de serviço
               '00'+                                              //  12 -  13   Forma de lançamento
               '020'+                                             //  14 -  16   Número da versão do layout do lote
               Space(1) +                                         //  17 -  17   Uso exclusivo FEBRABAN/CNAB
               TipoInsc +                                         //  18 -  18   Tipo de inscrição da empresa
               padR(OnlyNumber(CNPJCPF), 15, '0') +               //  19 -  33   Número de inscrição da empresa
               padR(OnlyNumber(Convenio), 13, '0') +              //  34 -  46   Código do convênio
               Space(7) +                                         //  47 -  53   Brancos
               padR(OnlyNumber(Agencia), 5, '0') +                //  54 -  58   Agência
               AgenciaDigito +                                    //  59 -  59   Dígito da agência
               padR(OnlyNumber(Conta), 12, '0') +                 //  60 -  71   Número da conta
               ContaDigito +                                      //  72 -  72   Dígito da conta
               Space(1) +                                         //  73 -  73   Dígito verificador da agência/conta
               padR(Nome, 30) +                                   //  74 - 103   Nome da empresa
               Space(80) +                                        // 104 - 183   Mensagens
               IntToStrZero(NumeroRemessa, 8) +                   // 184 - 191   Número sequencial do arquivo
               FormatDateTime('ddmmyyyy', Now) +                  // 192 - 199   Data de geração do arquivo
               DupeString('0', 8) +                               // 200 - 207   Data do crédito
               DupeString(' ', 33);                               // 208 - 240   Uso exclusivo FEBRABAN/CNAB
  end;
end;

function TACBrBanrisul.GerarRegistroTrailler240(
  ARemessa: TStringList): String;
var Valor: Currency;
    i, Ps: Integer;
begin
   Valor := 0.00;
   Ps := 1;
   for i := 0 to ARemessa.Count - 1 do 
   begin
      if (ARemessa.Strings[i][14] = 'P') then
         Valor := Valor + (StrToCurr(Copy(ARemessa.Strings[i], 86, 15)) / 100);

      while (Pos('*****', ARemessa.Strings[i]) > 0) do 
      begin
         ARemessa.Strings[i] := StringReplace(ARemessa.Strings[i], '*****', IntToStrZero(Ps, 5), []);
         Inc(Ps);
      end;
   end;
   Result := '04100015'+
             DupeString(' ', 9) +
             IntToStrZero(ARemessa.Count * 2, 6) +
             IntToStrZero(((ARemessa.Count * 2) - 2) div 2, 6) +
             padR(StringReplace(FormatFloat('#####0.00', Valor), ',', '', []), 17, '0') +
             DupeString('0', 77) +
             DupeString(' ', 117);

   Result := Result + #13#10 +
             '04199999' +
             DupeString(' ', 9) +
             '000001' +
             IntToStrZero((ARemessa.Count + 1) * 2, 6) +
             DupeString('0', 6) +
             DupeString(' ', 205);
end;

function TACBrBanrisul.GerarRegistroTransacao240(
  ACBrTitulo: TACBrTitulo): String;
var
    aAceite, DiasProt, Juros, TipoInscSacado, Ocorrencia: String;
begin
   with ACBrTitulo do begin
      case Aceite of
         atSim: aAceite := 'S';
         atNao: aAceite := 'N';
      end;

      DiasProt := '00';

      if (DataProtesto > 0) then
         DiasProt := padR(IntToStr(DaysBetween(Vencimento, DataProtesto)), 2, '0');
       
      if (DiasProt = '00') then
         DiasProt := '0'+ DiasProt
      else 
         DiasProt := '1'+ DiasProt;

      if (DataMoraJuros > 0) then
         Juros := '1'+ FormatDateTime('ddmmyyyy', DataMoraJuros) + padR(StringReplace(FormatFloat('#####0.00', ValorMoraJuros), ',', '', []), 15, '0')
      else
         Juros := DupeString('0', 24);

      case Sacado.Pessoa of
         pFisica:   TipoInscSacado := '1';
         pJuridica: TipoInscSacado := '2';
      end;

      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar:          Ocorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento: Ocorrencia := '04'; {Concessão de Abatimento}
         toRemessaCancelarAbatimento: Ocorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento:  Ocorrencia := '06'; {Alteração de vencimento}
         toRemessaProtestar:          Ocorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarIntrucaoProtestoBaixa: Ocorrencia := '18'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto:     Ocorrencia := '19'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias:  Ocorrencia := '31'; {Alteração de Outros Dados}
      else
         Ocorrencia := '01'; {Remessa}
      end;

      Result := '04100013' +
                DupeString('*', 5) +
                'P ' +
                Ocorrencia +
                DupeString(' ', 20) +
                padR(OnlyNumber(MontarCampoNossoNumero(ACBrTitulo)), 10, '0') +
                DupeString(' ', 10) +
                Carteira +
                '1020' +
                padL(NumeroDocumento, 15) +
                FormatDateTime('ddmmyyyy', Vencimento) +
                padR(StringReplace(FormatFloat('#####0.00', ValorDocumento), ',', '', []), 15, '0') +
                '00000002' +
                aAceite +
                FormatDateTime('ddmmyyyy', DataProcessamento) +
                Juros +
                DupeString('0', 39) +
                DupeString(' ', 15) +
                padL(NumeroDocumento, 15) +
                DupeString(' ', 10) +
                DiasProt +
                '110009' +
                DupeString('0', 10) +' ';

      Result := Result + #13#10 +
                '04100013' +
                DupeString('*', 5) +
                'Q ' +
                Ocorrencia +
                TipoInscSacado +
                padR(OnlyNumber(Sacado.CNPJCPF), 15, '0') +
                padL(Sacado.NomeSacado, 40) +
                padL(Sacado.Logradouro, 40) +
                padL(Sacado.Bairro, 15) +
                StringReplace(Sacado.CEP, '-', '', []) +
                padL(Sacado.Cidade, 15) +
                Sacado.UF +
                DupeString('0', 16) +
                DupeString(' ', 40) +
                '000' +
                DupeString(' ', 28);

      if (PercentualMulta > 0) then
         Result := Result + #13#10 +
                   '04100013' +
                   DupeString('*', 5) +
                   'R ' +
                   Ocorrencia +
                   DupeString('0', 48) +
                   '1' +
                   FormatDateTime('ddmmyyyy', Vencimento) +
                   padR(StringReplace(FormatFloat('#####0.00', PercentualMulta * ValorDocumento / 100), ',', '', []), 15, '0') +
                   DupeString(' ', 90) +
                   DupeString('0', 28) +
                   DupeString(' ', 33);
   end;
end;

procedure TACBrBanrisul.LerRetorno240(ARetorno: TStringList);
var Titulo: TACBrTitulo;
    FSegT, FSegU: String;
    FTituloErro: TStringList;
    Index, IdxMotivo: Integer;
    rCNPJCPF,rCedente,rConvenio: String;
    rAgencia,rAgenciaDigito: String;
    rConta,rContaDigito: String;
begin
  if (StrToInt(Copy(ARetorno.Strings[0], 1, 3)) <> Numero) then
      raise Exception.Create(ACBrStr('"'+ ACBrBanco.ACBrBoleto.NomeArqRetorno +
                                     '" não é um arquivo de retorno do(a) '+ UpperCase(Nome)));

  rCedente := trim(copy(ARetorno[0], 73, 30));
  rConvenio      := Copy(ARetorno.Strings[1], 34, 13);
  rAgencia       := Copy(ARetorno.Strings[1], 54,  5);
  rAgenciaDigito := Copy(ARetorno.Strings[1], 59,  1);
  rConta         := Copy(ARetorno.Strings[1], 60, 12);
  rContaDigito   := Copy(ARetorno.Strings[1], 72,  1);

  ACBrBanco.ACBrBoleto.NumeroArquivo := StrToIntDef(Copy(ARetorno.Strings[0], 158, 6), 0);

  ACBrBanco.ACBrBoleto.DataArquivo   := StringToDateTimeDef(Copy(ARetorno.Strings[0], 144, 2) +'/'+
                                                            Copy(ARetorno.Strings[0], 146, 2) +'/'+
                                                            Copy(ARetorno.Strings[0], 148, 4),
                                                            0, 'dd/mm/yyyy');

  ACBrBanco.ACBrBoleto. DataCreditoLanc := StringToDateTimeDef(Copy(ARetorno.Strings[1], 200, 2) +'/'+
                                                               Copy(ARetorno.Strings[1], 202, 2) +'/'+
                                                               Copy(ARetorno.Strings[1], 204, 4),
                                                               0, 'dd/mm/yyyy');

  rCNPJCPF := OnlyNumber( copy(ARetorno[1], 19, 14) );

  try
    with ACBrBanco.ACBrBoleto do
    begin
      if (not LeCedenteRetorno) and (rCNPJCPF <> Cedente.CNPJCPF) then
         raise Exception.create(ACBrStr('CNPJ\CPF do arquivo inválido'));

      if (not LeCedenteRetorno) and ((rAgencia <> OnlyNumber(Cedente.Agencia)) or
         (rConta <> OnlyNumber(Cedente.Conta))) then
          raise Exception.Create(ACBrStr('Agencia\Conta do arquivo inválido'));

      Cedente.Nome   := rCedente;
      Cedente.CNPJCPF:= rCNPJCPF;

      case StrToIntDef(Copy(ARetorno.Strings[0], 18, 1),0) of
        1:
         Cedente.TipoInscricao := pFisica;
        2:
         Cedente.TipoInscricao := pJuridica;
        else
         Cedente.TipoInscricao := pOutras;
      end;

      Cedente.Convenio      := rConvenio;
      Cedente.Agencia       := rAgencia;
      Cedente.AgenciaDigito := rAgenciaDigito;
      Cedente.Conta         := rConta;
      Cedente.ContaDigito   := rContaDigito;

      ListadeBoletos.Clear;
    end;

    FTituloErro := TStringList.Create;
    try
      Index := 2;
      while Index < ARetorno.Count - 3 do
      begin
        FSegT := ARetorno.Strings[Index];
        FSegU := ARetorno.Strings[Index + 1];
        if (FSegT[14] <> 'T') then
        begin
          Inc(Index);
          Continue;
        end;

        try
          Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;
          with Titulo do
          begin
            if (FSegT[133] = '1') then
              Sacado.Pessoa := pFisica
            else if (FSegT[133] = '2') then
              Sacado.Pessoa := pJuridica
            else
              Sacado.Pessoa := pOutras;
            case Sacado.Pessoa of
              pFisica:   Sacado.CNPJCPF := Copy(FSegT, 138, 11);
              pJuridica: Sacado.CNPJCPF := Copy(FSegT, 135, 14);
              else
                Sacado.CNPJCPF := Copy(FSegT, 134, 15);
            end;
            Sacado.NomeSacado := Trim(Copy(FSegT, 149, 40));

            NumeroDocumento      := Trim(Copy(FSegT, 59, 15));
            SeuNumero            := NumeroDocumento;
            Carteira             := Copy(FSegT, 58, 1);
            NossoNumero          := Trim(Copy(FSegT, 38, 20));
            Vencimento           := StringToDateTimeDef(Copy(FSegT, 74, 2) +'/'+
                                                        Copy(FSegT, 76, 2) +'/'+
                                                        Copy(FSegT, 78, 4), 0, 'dd/mm/yyyy');
            ValorDocumento       := StrToInt64Def(Copy(FSegT,  82, 15), 0) / 100;
            ValorDespesaCobranca := StrToInt64Def(Copy(FSegT, 199, 15), 0) / 100;
            ValorMoraJuros       := StrToInt64Def(Copy(FSegU,  18, 15), 0) / 100;
            ValorDesconto        := StrToInt64Def(Copy(FSegU,  33, 15), 0) / 100;
            ValorAbatimento      := StrToInt64Def(Copy(FSegU,  48, 15), 0) / 100;
            ValorIOF             := StrToInt64Def(Copy(FSegU,  63, 15), 0) / 100;
            ValorRecebido        := StrToInt64Def(Copy(FSegU,  93, 15), 0) / 100;
            ValorOutrasDespesas  := StrToInt64Def(Copy(FSegU, 108, 15), 0) / 100;
            ValorOutrosCreditos  := StrToInt64Def(Copy(FSegU, 123, 15), 0) / 100;
            DataOcorrencia       := StringToDateTimeDef(Copy(FSegU, 138, 2) +'/'+
                                                        Copy(FSegU, 140, 2) +'/'+
                                                        Copy(FSegU, 142, 4), 0, 'dd/mm/yyyy');
            DataCredito          := StringToDateTimeDef(Copy(FSegU, 146, 2) +'/'+
                                                        Copy(FSegU, 148, 2) +'/'+
                                                        Copy(FSegU, 150, 4), 0, 'dd/mm/yyyy');

            OcorrenciaOriginal.Tipo := CodOcorrenciaToTipo(StrToIntDef(Copy(FSegT, 16, 2), 0));

            IdxMotivo := 214;
            while (IdxMotivo < 223) do
            begin
              if (Copy(FSegT, IdxMotivo, 2) <> '  ') then begin
                Titulo.MotivoRejeicaoComando.Add(Copy(FSegT, IdxMotivo, 2));
                Titulo.DescricaoMotivoRejeicaoComando.Add(
                   CodMotivoRejeicaoToDescricao(Titulo.OcorrenciaOriginal.Tipo, StrToIntDef(Copy(FSegT, IdxMotivo, 2), 0)));
              end;
              Inc(IdxMotivo, 2);
            end;
          end;
        except
          FTituloErro.Add(' - Linhas '+ IntToStr(Index) +' e '+ IntToStr(Index + 1));
        end;

        Inc(Index);
      end;

      if (FTituloErro.Count > 0) then
      begin
        raise Exception.Create(ACBrStr('No arquivo de retorno "'+ ACBrBanco.ACBrBoleto.NomeArqRetorno +
                           '", não foi possível realizar a leitura do(s) seguinte(s) título(s):'+ #13#10 +
                           FTituloErro.Text));
      end;
    finally
      FTituloErro.Free;
    end;
  except
    raise Exception.Create(ACBrStr('Não foi possível realizar a leitura do arquivo de retorno "'+
                       ACBrBanco.ACBrBoleto.NomeArqRetorno +'" do(a) '+ UpperCase(Nome)));
  end;
end;

procedure TACBrBanrisul.LerRetorno400(ARetorno: TStringList);
begin
  inherited;

end;

function TACBrBanrisul.CodMotivoRejeicaoToDescricao(
  const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: String): String;
begin
  case TipoOcorrencia of

    toRetornoRegistroConfirmado:
    begin
      if (CodMotivo = 'A4') then
        Result := 'Sacado DDA'
      else Result := IntToStrZero(StrToIntDef(CodMotivo, 0), 2) +' - Outros Motivos';
    end;

    toRetornoLiquidado,
    toRetornoLiquidadoAposBaixaouNaoRegistro:
    begin
      case StrToIntDef(CodMotivo, 0) of
        01: Result := 'Por saldo - Reservado';
        02: Result := 'Por conta (parcial)';
        03: Result := 'No próprio banco';
        04: Result := 'Compensação Eletrônica';
        05: Result := 'Compensação Convencional';
        06: Result := 'Por meio Eletrônico';
        07: Result := 'Reservado';
        08: Result := 'Em Cartório';
        else Result := IntToStrZero(StrToIntDef(CodMotivo, 0), 2) +' - Outros Motivos';
      end;
    end;

    toRetornoBaixado:
    begin
      case StrToIntDef(CodMotivo, 0) of
        0:
        begin
          if (CodMotivo = 'AA') then
            Result := 'Baixa por pagamento'
          else Result := '00 - Outros Motivos';
        end;
        09: Result := 'Comandado Banco';
        10: Result := 'Comandado cliente Arquivo';
        11: Result := 'Comandado cliente On-Line';
        12: Result := 'Decurso prazo - cliente';
        else Result := IntToStrZero(StrToIntDef(CodMotivo, 0), 2) +' - Outros Motivos';
      end;
    end;

    toRetornoTituloEmSer:
    begin
      case StrToIntDef(CodMotivo, 0) of
        70: Result := 'Título não selecionado por erro no CNPJ/CPF ou endereço';
        76: Result := 'Banco aguarda cópia autenticada do documento';
        77: Result := 'Título selecionado falta seu número';
        78: Result := 'Título rejeitado pelo cartório por estar irregular';
        79: Result := 'Título não selecionado - praça não atendida';
        80: Result := 'Cartório aguarda autorização para protestar por edital';
        90: Result := 'Protesto sustado por solicitação do cedente';
        91: Result := 'Protesto sustado por alteração no vencimento';
        92: Result := 'Aponte cobrado de título sustado';
        93: Result := 'Protesto sustado por alteração no prazo do protesto';
        95: Result := 'Entidade Pública';
        97: Result := 'Título em cartório';
        else Result := IntToStrZero(StrToIntDef(CodMotivo, 0), 2) +' - Outros Motivos';
      end;
    end;

    toRetornoDebitoTarifas:
    begin
      case StrToIntDef(CodMotivo, 0) of
        00:
        begin
          if (CodMotivo = 'AA') then
            Result := 'Tarifa de formulário Pré-Impresso'
          else Result := '00 - Outros Motivos';
        end;
        01: Result := 'Tarifa de extrato de posição';
        02: Result := 'Tarifa de manutenção de título vencido';
        03: Result := 'Tarifa de sustação e envio para cartório';
        04: Result := 'Tarifa de protesto';
        05: Result := 'Tarifa de outras instruções';
        06: Result := 'Tarifa de outras ocorrências(Registro/Liquidação)';
        07: Result := 'Tarifa de envio de duplicata ao sacado';
        08: Result := 'Custas de protesto';
        09: Result := 'Custas de Sustação de Protesto';
        10: Result := 'Custas do cartório distribuidor';
        11: Result := 'Reservado';
        else Result := IntToStrZero(StrToIntDef(CodMotivo, 0), 2) +' - Outros Motivos';
      end;
    end;

    else Result := IntToStrZero(StrToIntDef(CodMotivo, 0), 2) +' - Outros Motivos';
  end;
end;

function TACBrBanrisul.CodOcorrenciaToTipo(
  const CodOcorrencia: String): TACBrTipoOcorrencia;
begin
  case StrToIntDef(CodOcorrencia, 0) of
    00:
    begin
      if (CodOcorrencia = 'AA') then
        Result :=  toRetornoOutrasOcorrencias                             //---> Devolução, Liquidado Anteriormente (CCB)
      else if (CodOcorrencia = 'AB') then
        Result := toRetornoOutrasOcorrencias                              //---> Cobrança a Creditar
      else if (CodOcorrencia = 'AC') then
        Result := toRetornoOutrasOcorrencias                              //---> Situação do Título - Cartório
      else Result := toRetornoOutrasOcorrencias;
    end;
    02: Result := toRetornoRegistroConfirmado;
    03: Result := toRetornoRegistroRecusado;
//    04: Result :=                                                         ---> Reembolso e Transf. (Desconto-Vendor) ou Transf. de Carteira (Garantia)
//    05: Result :=                                                         ---> Reembolso e Devolução Desconto e Vendor.
    06: Result := toRetornoLiquidado;
    09: Result := toRetornoBaixado;
    11: Result := toRetornoTituloEmSer;
    12: Result := toRetornoRecebimentoInstrucaoConcederAbatimento;
    13: Result := toRetornoRecebimentoInstrucaoCancelarAbatimento;
    14: Result := toRetornoRecebimentoInstrucaoAlterarVencimento;
//    15: Result :=                                                         ---> Confirmação de Protesto Imediato por Falência.
    17: Result := toRetornoLiquidadoAposBaixaouNaoRegistro;
    19: Result := toRetornoRecebimentoInstrucaoProtestar;
    20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
    23: Result := toRetornoEncaminhadoACartorio;
//    24: Result :=                                                         ---> Reservado.
    25: Result := toRetornoBaixaPorProtesto;
    26: Result := toRetornoInstrucaoRejeitada;
//    27: Result :=                                                         ---> Confirmação do pedido de alteração de outros dados.
    28: Result := toRetornoDebitoTarifas;
    30: Result := toRetornoAlteracaoDadosRejeitados;
    else Result := toRetornoOutrasOcorrencias;
  end;
end;

end.

