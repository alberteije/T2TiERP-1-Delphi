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
unit ACBrFolha_Caged_Class;

interface

uses
  SysUtils, Classes, DateUtils, ACBrTXTClass, ACBrFolha_Caged, ACBrFolhaUtils;
type

/// Folha_Caged
  TFolha_Caged = class(TACBrTXTClass)

  private
    FRegistroTipoA: TRegistroTipoA; // REGISTRO TIPO A – Identifica Autorização.
    FRegistroTipoB: TRegistroTipoB; // REGISTRO TIPO B – Identifica o Estabelecimento )
    FRegistroTipoC: TRegistroTipoCList; // Lista REGISTRO TIPO C - Movimentação
    FRegistroTipoX: TRegistroTipoXList; // Lista REGISTRO TIPO X – Alteração e acertos

    FNSR:   Integer;
    FNSRCX: Integer;
    FNSRB : Integer;
    procedure CriaRegistros;
    procedure LiberaRegistros;
  protected
  public
    constructor Create;           /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    // funções para escrever os arquivos
    function WriteRegistroTipoA: String;
    function WriteRegistroTipoB: String;
    function WriteRegistroTipoC: String;
    function WriteRegistroTipoX: String;

    property RegistroTipoA: TRegistroTipoA read FRegistroTipoA write FRegistroTipoA;
    property RegistroTipoB: TRegistroTipoB read FRegistroTipoB write FRegistroTipoB;
    property RegistroTipoC: TRegistroTipoCList read FRegistroTipoC write FRegistroTipoC;
    property RegistroTipoX: TRegistroTipoXList read FRegistroTipoX write FRegistroTipoX;

  end;
implementation

{ TFolha_Sefip }

constructor TFolha_Caged.Create;
begin
  CriaRegistros;
  FNSR   := 0;
  FNSRCX := 0;
  FNSRB  := 0;
end;

procedure TFolha_Caged.CriaRegistros;
begin
  FRegistroTipoA := TRegistroTipoA.Create;
  FRegistroTipoB := TRegistroTipoB.Create;
  FRegistroTipoC := TRegistroTipoCList.Create;
  FRegistroTipoX := TRegistroTipoXList.Create;

end;

destructor TFolha_Caged.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TFolha_Caged.LiberaRegistros;
begin
  FRegistroTipoA.Free;
  FRegistroTipoB.Free;
  FRegistroTipoC.Free;
  FRegistroTipoX.Free;
end;

procedure TFolha_Caged.LimpaRegistros;
begin
  LiberaRegistros;
  CriaRegistros;
end;

function TFolha_Caged.WriteRegistroTipoA: String;
begin
  Result := '';
  if Assigned(FRegistroTipoA) then
  begin
    with FRegistroTipoA do
    begin
      Check(((TipoIdentificador = '1') or (TipoIdentificador = '2') ), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ) ou 2 (CEI), para o código de recolhimento 418.', [TipoIdentificador]);
      if TipoIdentificador = '1' then
        Check(ValidarCnpjCeiCpf(NumeroIdentificadorDoAutorizado), '(0-0000) O CNPJ "%s" digitado é inválido!', [NumeroIdentificadorDoAutorizado])
      else if TipoIdentificador = '2' then
        Check(ValidarCnpjCeiCpf(NumeroIdentificadorDoAutorizado), '(0-0000) O O CPF "%s" digitado é inválido!', [NumeroIdentificadorDoAutorizado]);
      Check(ValidarUF(UF), '(0-0000) A UF "%s" digitada é inválida!', [UF]);
      Check(ValidarCEP(CEP, UF), '(0-0000) O Cep "%s" digitado é inválido!', [CEP]);
      inc(FNSR);
      ///
      Result := LFill('A') +
                LFill('L2009',5) +
                RFill(' ', 2) +
                LFill(Competencia, 6) +
                LFill(Alteracao, 1) +
                LFill(FNSR, 5) +
                LFill(TipoIdentificador, 1) +
                LFill(NumeroIdentificadorDoAutorizado, 14) +
                RFill(TratarString(NomeRazaoSocialDoAutorizado), 35) +
                RFill(TratarString(Endereco), 40) +
                LFill(Cep, 8)+
                RFill(UF, 2)+
                LFill(DDD, 4) +
                LFill(ApenasNumeros(Telefone), 8) +
                LFill(Ramal, 5) +
                LFill(FNSRB, 5) +
                LFill(FNSRCX, 5) +
                RFill(' ', 92) +
                sLineBreak;
     end;
  end;
end;

function TFolha_Caged.WriteRegistroTipoB: String;
begin
  Result := '';

  if Assigned(FRegistroTipoB) then
  begin
     with FRegistroTipoB do
     begin
       Check(((TipoIdentificador = '1') or (TipoIdentificador = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI).', [TipoIdentificador]);
       if TipoIdentificador = '1' then
         Check(ValidarCnpjCeiCpf(NumeroIdentificadorDoEstabelecimento), '(0-0000) O CNPJ "%s" digitado é inválido!', [NumeroIdentificadorDoEstabelecimento])
       else
       if TipoIdentificador = '2' then
         Check(ValidarCnpjCeiCpf(NumeroIdentificadorDoEstabelecimento), '(0-0000) O CEI "%s" digitado é inválido!', [NumeroIdentificadorDoEstabelecimento]);
       Check(ValidarUF(UF), '(0-0000) A UF "%s" digitada é inválida!', [UF]);
       Check(ValidarCEP(CEP, UF), '(0-0000) O Cep "%s" digitado é inválido para a UF!', [CEP]);
       Check(((PrimeiraDeclaracao = '1') or (PrimeiraDeclaracao = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (primeira declaração), 2 (já informou o CAGED anteriormente).', [PrimeiraDeclaracao]);
       Check(((Alteracao = '1') or (Alteracao = '2') or (Alteracao = '3')), '(0-0000) O indicador "%s" Só pode ser 1 (nada a atualizar), 2 (alterar dados cadastrais) ou 3 (encerramento das atividades).', [Alteracao]);
       Check((((PorteDoEstabelecimento = '1') or (PorteDoEstabelecimento = '2') or (PorteDoEstabelecimento = '3') or (PorteDoEstabelecimento = '4'))), '(0-0000) O indicador "%s" Só pode ser 1 (micro empresa), 2 (pequeno porte), 3 (não classificada) ou 4 (microempreendedor individual).', [PorteDoEstabelecimento]);
       Check(ValidarEmail(Email), '(0-0000) O E-mail "%s" digitado é inválido!', [Email]);
       inc(FNSR);
       ///
       Result := LFill('B') +
                 LFill(TipoIdentificador, 1) +
                 LFill(NumeroIdentificadorDoEstabelecimento, 14) +
                 LFill(FNSR, 5) +
                 LFill(PrimeiraDeclaracao, 1) +
                 LFill(Alteracao, 1) +
                 RFill(Cep, 8) +
                 RFill(TratarString(NomeRazaoSocialDoEstabelecimento), 40) +
                 RFill(Endereco, 40)+
                 RFill(Bairro, 20)+
                 RFill(UF, 2) +
                 LFill(TotalDeEmpregadosExistentesNoPrimeiroDia, 5) +
                 RFill(PorteDoEstabelecimento, 1) +
                 LFill(Cnae2ComSubClasse, 7) +
                 LFill(DDD, 4) +
                 LFill(ApenasNumeros(Telefone), 8) +
                 LFill(Email, 50) +
                 sLineBreak;
     end;
  end;
end;


function TFolha_Caged.WriteRegistroTipoC: String;
var
  intFor: integer;
  strRegistroTipoC: String;
begin
  strRegistroTipoC := '';

  if Assigned(FRegistroTipoC) then
  begin
     for intFor := 0 to FRegistroTipoC.Count - 1 do
     begin
       with FRegistroTipoC.Items[intFor] do
       begin
         Check(((TipoIdentificador = '1') or (TipoIdentificador = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI).', [TipoIdentificador]);
         if TipoIdentificador = '1' then
           Check(ValidarCnpjCeiCpf(NumeroIdentificadorDoEstabelecimento), '(0-0000) O CNPJ "%s" digitado é inválido!', [NumeroIdentificadorDoEstabelecimento])
         else
         if TipoIdentificador = '2' then
           Check(ValidarCnpjCeiCpf(NumeroIdentificadorDoEstabelecimento), '(0-0000) O CEI "%s" digitado é inválido!', [NumeroIdentificadorDoEstabelecimento]);
         Check(ValidarCnpjCeiCpf(Cpf), '(0-0000 O Cfp "%s" digitado é invalido!', [Cpf]);
         Check((((TipoDeficienciaBeneficiarioReabilitado = '1') or (TipoDeficienciaBeneficiarioReabilitado = '2') or (TipoDeficienciaBeneficiarioReabilitado = '3') or (TipoDeficienciaBeneficiarioReabilitado = '4') or (TipoDeficienciaBeneficiarioReabilitado = '5') or (TipoDeficienciaBeneficiarioReabilitado = '6'))), '(0-0000) O indicador "%s" Só pode ser 1 (fisica), 2 (auditiva), 3 (visual), 4 (mental), 5 (multipla) ou 6 (reabilitado).', [TipoDeficienciaBeneficiarioReabilitado]);
         Check(ValidarPis(PisPasep), '(0-0000) O Pis/Pasep "%s" digitado é inválido!', [PisPasep]);
         Check(((Sexo = '1') or (Sexo = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (Masculino), 2 (Feminino).', [Sexo]);
         Check(((PessaoComDeficiencia = '1') or (PessaoComDeficiencia = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (SIM), 2 (NÃO).', [TipoIdentificador]);
         inc(FNSR);
         ///
         strRegistroTipoC := strRegistroTipoC +
                             LFill('C') +
                             LFill(TipoIdentificador, 1) +
                             LFill(NumeroIdentificadorDoEstabelecimento, 14) +
                             LFill(FNSR, 5) +
                             LFill(PisPasep, 11) +
                             LFill(Sexo, 1) +
                             RFill(FormatDateTime('DDMMYYYY', Nascimento), 8) +
                             LFill(GrauInstrucao, 2) +
                             RFill(SalarioMensal, 8) +
                             RFill(HorasTrabalhadas, 2)+
                             RFill(FormatDateTime('DDMMYYYY', Admissao), 8)+
                             LFill(TipoMovimento, 2) +
                             LFill(DiaDeDesligamento, 2) +
                             RFill(TratarString(NomeDoEmpregado), 40) +
                             LFill(NumeroCarteiraTrabalho, 8) +
                             LFill(SerieCarteiraTrabalho, 4) +
                             LFill(RacaCor, 1) +
                             LFill(PessaoComDeficiencia, 1) +
                             LFill(CBO2000, 6) +
                             LFill(Aprendiz, 1) +
                             LFill(UFCarteiraDeTrabalho, 8) +
                             LFill(TipoDeficienciaBeneficiarioReabilitado, 1) +
                             LFill(Cpf, 11) +
                             RFill(Cep, 8) +
                             sLineBreak;
       end;
     end;
  end;
  Result := strRegistroTipoC;
end;

function TFolha_Caged.WriteRegistroTipoX: String;
var
  intFor: integer;
  strRegistroTipoX: String;
begin
  strRegistroTipoX := '';

  if Assigned(FRegistroTipoX) then
  begin
    for intFor := 0 to FRegistroTipoX.Count - 1 do
    begin
      with FRegistroTipoX.Items[intFor] do
      begin
        Check(((TipoIdentificador = '1') or (TipoIdentificador = '2')), '(0-0000) O indicador "%s" Só pode ser 1 (CNPJ), 2 (CEI).', [TipoIdentificador]);
        if TipoIdentificador = '1' then
          Check(ValidarCnpjCeiCpf(NumeroIdentificadorDoEstabelecimento), '(0-0000) O CNPJ "%s" digitado é inválido!', [NumeroIdentificadorDoEstabelecimento])
        else
        if TipoIdentificador = '2' then
          Check(ValidarCnpjCeiCpf(NumeroIdentificadorDoEstabelecimento), '(0-0000) O CEI "%s" digitado é inválido!', [NumeroIdentificadorDoEstabelecimento]);
        Check(ValidarUF(UFCarteiraDeTrabalho), '(0-0000) A UF "%s" digitada é inválida!', [UFCarteiraDeTrabalho]);
        Check(ValidarCEP(CEP, CEP), '(0-0000) O Cep "%s" digitado é inválido para a UF!', [CEP]);
        inc(FNSR);
        ///
        strRegistroTipoX :=   strRegistroTipoX +
                              LFill('X') +
                              LFill(TipoIdentificador, 1) +
                              LFill(NumeroIdentificadorDoEstabelecimento, 14) +
                              LFill(FNSR, 5) +
                              LFill(PisPasep, 11) +
                              LFill(Sexo, 1) +
                              RFill(FormatDateTime('DDMMYYYY', Nascimento), 8) +
                              LFill(GrauInstrucao, 2) +
                              RFill(SalarioMensal, 8) +
                              RFill(HorasTrabalhadas, 2)+
                              RFill(FormatDateTime('DDMMYYYY', Admissao), 8)+
                              LFill(TipoMovimento, 2) +
                              LFill(DiaDeDesligamento, 2) +
                              RFill(TratarString(NomeDoEmpregado), 40) +
                              LFill(NumeroCarteiraTrabalho, 8) +
                              LFill(SerieCarteiraTrabalho, 4) +
                              LFill(Atualizacao, 1) +
                              LFill(Competencia, 6) +
                              LFill(RacaCor, 1) +
                              LFill(PessaoComDeficiencia, 1) +
                              LFill(CBO2000, 6) +
                              LFill(Aprendiz, 1) +
                              LFill(UFCarteiraDeTrabalho, 8) +
                              LFill(TipoDeficienciaBeneficiarioReabilitado, 1) +
                              LFill(Cpf, 11) +
                              RFill(Cep, 8) +
                              sLineBreak;
      end;
    end;
  end;
  Result := strRegistroTipoX;
end;

end.

