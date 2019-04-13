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

unit ACBrFolha_Caged;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils;

type

  {******************************************************************************
  |*  Descrição dos valores de campos.                                          *
  |* A  = String                                                                *
  |* AN = String                                                                *
  |* N  = String                                                                *
  |* V  = Double                                                                *
  |* D  = DateTime                                                              *
  |* Trata as situações com valores e datas.                                    *
  |* Nota: Todas as registros devem conter 360 caracteres                       *
  *******************************************************************************}

  {Registro A (AUTORIZADO)
  Registro do estabelecimento responsável pela informação no meio magnético (autorizado).
  Neste registro, informe o meio físico utilizado, a competência (mês e ano de referência das informações prestadas), dados cadastrais do
  estabelecimento responsável, telefone para contato, total de estabelecimentos e total de movimentações informadas no arquivo.}
  TRegistroTipoA = class
  private
    FTipoRegistro:                      String; // 1 A. Define o registro a ser informado. Obrigatoriamente o conteúdo é A.
    FTipoLayOut:                        String; // 5 A. Informe qual o layout do arquivo CAGED. Obrigatoriamente o conteúdo é L2009.
    // FFiller1:                        String; // 2 A. Deixar em branco. Tratar na geração do arquivo
    FCompetencia:                       String; // 6 N. Mês e ano de referência das informações do CAGED. Informar sem máscara(/.\-,).
    FAlteracao:                         String;  { 1 N. Define se os dados cadastrais informados irão ou não atualizar o Cadastro de
      Autorizados do CAGED Informatizado. 1. Nada a alterar - 2. Alterar dados cadastrais}
    FSequencia:                         String; // 5 N. Número seqüencial no arquivo.
    FTipoIdentificador:                 String; // 1 N. Define o tipo de identificador do estabelecimento a informar. 1. CNPJ - 2. CEI
    FNumeroIdentificadorDoAutorizado:   String; { 14 N. Número identificador do estabelecimento. Não havendo inscrição do estabelecimento
      no Cadastro Nacional de Pessoa Jurídica (CNPJ), informar o número de registro no CEI (Código Específico do INSS).
      O número do CEI tem 12 posições, preencher este campo com 00(zeros) à esquerda.}
    FNomeRazaoSocialDoAutorizado:       String; // 35 A.Nome/Razão Social do estabelecimento autorizado.
    FEndereco:                          String; // 40 A.Informar o Endereço do estabelecimento / autorizado (Rua, Av, Trav, Pç) com número e complemento.
    FCep:                               String; {8  N. Informar o Código de Endereçamento Postal do estabelecimento conforme a tabela da
      Empresa de Correios e Telégrafos-ECT. Informar sem  máscara (/.\-,).}
    FUF:                                String; // 2 A. Informar a Unidade de Federação.
    FDDD:                               String; // 4 N. Informar DDD do telefone para contato para contato com o Ministério do Trabalho e Emprego.
    FTelefone:                          String; // 8 N. Informar o número do telefone para contato com o responsável pelas informações contidas no arquivo CAGED.
    FRamal:                             String; // 5 N. Informar o ramal se houver complemento do telefone informado.
    FTotalDeEstabelecimentosInformados: String; // 5 N. Quantidade de registros tipo B (Estabelecimento) informados no arquivo.
    FTotalDeMovimentacoesInformadas:    String; // 5 N. Quantidade de registros tipo C e/ou X (Empregado) informados no arquivo.
    // Filler2:                         String; // 92 A. Deixar em branco. Tratar na geração do arquivo.

    FRegistroValido:                    Boolean;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido:                    Boolean read FRegistroValido                    write FRegistroValido;
    property TipoRegistro:                      String  read FTipoRegistro                      write FTipoRegistro;
    property TipoLayOut:                        String  read FTipoLayOut                        write  FTipoLayOut;
    /// property FFiller1. Campo obrigatório. Preencher com brancos Tratar dele no momento de gerar o registro.
    property Competencia:                       String  read FCompetencia                       write FCompetencia;
    property Alteracao:                         String  read FAlteracao                         write FAlteracao;
    property Sequencia:                         String  read FSequencia                         write FSequencia;
    property TipoIdentificador:                 String  read FTipoIdentificador                 write FTipoIdentificador;
    property NumeroIdentificadorDoAutorizado:   String  read FNumeroIdentificadorDoAutorizado   write FNumeroIdentificadorDoAutorizado;
    property NomeRazaoSocialDoAutorizado:       String  read FNomeRazaoSocialDoAutorizado       write FNomeRazaoSocialDoAutorizado;
    property Endereco:                          String  read FEndereco                          write FEndereco;
    property Cep:                               String  read FCep                               write FCep;
    property UF:                                String  read FUF                                write FUF;
    property DDD:                               String  read FDDD                               write FDDD;
    property Telefone:                          String  read FTelefone                          write FTelefone;
    property Ramal:                             String  read FRamal                             write FRamal;
    property TotalDeEstabelecimentosInformados: String  read FTotalDeEstabelecimentosInformados write FTotalDeEstabelecimentosInformados;
    property TotalDeMovimentacoesInformadas:    String  read FTotalDeMovimentacoesInformadas    write FTotalDeMovimentacoesInformadas;
    /// property FFiller2. Campo obrigatório. Preencher com brancos Tratar dele no momento de gerar o registro.
  end;

  {REGISTRO B (ESTABELECIMENTO)
  Registro de estabelecimento informado.
  Informe neste registro os dados cadastrais do estabelecimento que teve movimentação (admissões e/ou desligamentos) e total de empregados existentes
  no início do primeiro dia do mês informado (estoque de funcionários).}
  TRegistroTipoB = class
  private
    FTipoRegistro:                             String; // 1 A. Define o registro a ser informado. Obrigatoriamente o conteúdo é B.
    FTipoIdentificador:                        String; // 1 N. Define o tipo de identificador do estabelecimento a informar. 1. CNPJ - 2. CEI
    FNumeroIdentificadorDoEstabelecimento:     String; { 14 N. Número identificador do estabelecimento. Não havendo inscrição
      do estabelecimento no Cadastro Nacional de Pessoa Jurídica (CNPJ), informar o número de registro no CEI (Código Específico do INSS).
      O número do CEI tem 12 posições, preencher este campo com 00 zeros à esquerda.}
    FSequencia:                                String; // 5 N. Número seqüencial no arquivo.
    FPrimeiraDeclaracao:                       String; {  1 N. Define se é ou não a primeira declaração do estabelecimento ao Cadastro
      Geral de Empregados e Desempregados-CAGED-Lei nº 4.923/65. 1. primeira declaração 2. já informou ao CAGED anteriormente.}
    FAlteracao:                                String;  { 1 N. Define se os dados cadastrais informados irão ou não atualizar o Cadastro de
      Autorizados do CAGED Informatizado.
      1. Nada a atualizar
      2. Alterar dados cadastrais do estabelecimento (Razão Social, Endereço, CEP, Bairro, UF, ou Atividade Econômica).
      3. Encerramento de Atividades (Fechamento do estabelecimento);}
    FCep:                                      String; {8  N. Informar o Código de Endereçamento Postal do estabelecimento conforme a tabela da
      Empresa de Correios e Telégrafos-ECT. Informar sem  máscara (/.\-,).}
    // FFiller1, 5 A. Deixar em branco. Tratar na geração do arquivo. Obrigatorio
    FNomeRazaoSocialDoEstabelecimento:         String; // 40 A.Nome/Razão Social do estabelecimento.
    FEndereco:                                 String; // 40 A.Informar o Endereço do estabelecimento / autorizado (Rua, Av, Trav, Pç) com número e complemento.
    FBairro:                                   String; // 20 A.Informar o bairro correspondente.
    FUF:                                       String; // 2 A. Informar a Unidade de Federação.
    FTotalDeEmpregadosExistentesNoPrimeiroDia: String; // 5 N. Total de empregados existentes na empresa no início do primeiro dia do mês de referência (competência).
    FPorteDoEstabelecimento:                   String; {  1 N.Informe se o estabelecimento se enquadra como microempresa, empresa de pequeno porte,
      empresa/órgão não classificados ou microempreendedor individual, de acordo com a lei Complementar nº . 123, de 14 de dezembro de 2006,
      alterada pela lei Complementar nº. 128, de 19 de dezembro de 2008, utilizando:
      1. Microempresa para a pessoa jurídica, ou a ela equiparada, que auferir, em cada ano-calendário, receita bruta igual ou inferior a
         R$240.000,00 (duzentos e quarenta mil reais).
      2. Empresa de Pequeno Porte para a pessoa jurídica, ou a ela equiparada, que auferir, em cada ano-calendário, receita bruta
         superior a R$240.000,00 (duzentos e quarenta mil reais) e igual ou inferior a R$ 2.400.000,00 (dois milhões e quatrocentos mil
         reais).
      3. Empresa/Órgão não classificados este campo só deve ser selecionado se o estabelecimento não se enquadrar como microempreendedor
        individual, microempresa ou empresa de pequeno porte.
      4. Microempreendedor Individual para o empresário individual que tenha auferido receita bruta, no ano-calendário anterior, de até
         R$36.000,00 (trinta e seis mil reais).}
    FCnae2ComSubClasse:                        String; { 7 N. Informar os primeiros 7algarísmos do CNAE 2.0 conforme exemplo:
      01 - Divisão
      011 - Grupo
      01113 - Classe
      01113xx - Subclasse.}
    FDDD:                                      String; // 4 N. Informar DDD do telefone para contato para contato com o Ministério do Trabalho e Emprego.
    FTelefone:                                 String; // 8 N. Informar o número do telefone para contato com o responsável pelas informações contidas no arquivo CAGED.
    FEmail:                                    String; { 50 A. Endereço eletrônico do estabelecimento ou do responsável, utilizado para
      eventuais contatos, todos os caracteres serão transformados em minúsculos.}
    // Filler2:                         String; // 27 A. Deixar em branco. Tratar na geração do arquivo. Obrigatorio

    FRegistroValido:                    Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido:                           Boolean read FRegistroValido                           write FRegistroValido;
    property TipoIdentificador:                        String  read FTipoRegistro                             write FTipoRegistro;
    property NumeroIdentificadorDoEstabelecimento:     String  read FNumeroIdentificadorDoEstabelecimento     write FNumeroIdentificadorDoEstabelecimento;
    property Sequencia:                                String  read FSequencia                                write FSequencia;
    property PrimeiraDeclaracao:                       String  read FPrimeiraDeclaracao                       write FPrimeiraDeclaracao;
    property Alteracao:                                String  read FAlteracao                                write FAlteracao;
    property Cep:                                      String  read FCep                                      write FCep;
    // property FFiller1, 5 A. Deixar em branco. Tratar na geração do arquivo. Obrigatorio
    property NomeRazaoSocialDoEstabelecimento:         String  read FNomeRazaoSocialDoEstabelecimento         write FNomeRazaoSocialDoEstabelecimento;
    property Endereco:                                 String  read FEndereco                                 write FEndereco;
    property Bairro:                                   String  read FBairro                                   write FBairro;
    property UF:                                       String  read FUF                                       write FUF;
    property TotalDeEmpregadosExistentesNoPrimeiroDia: String  read FTotalDeEmpregadosExistentesNoPrimeiroDia write FTotalDeEmpregadosExistentesNoPrimeiroDia;
    property PorteDoEstabelecimento:                   String  read FPorteDoEstabelecimento                   write FPorteDoEstabelecimento;
    property Cnae2ComSubClasse:                        String  read FCnae2ComSubClasse                        write FCnae2ComSubClasse;
    property DDD:                                      String  read FDDD                                      write FDDD;
    property Telefone:                                 String  read FTelefone                                 write FTelefone;
    property Email:                                    String  read FEmail                                    write FEmail;
    /// property FFiller2. Campo obrigatório. Preencher com brancos Tratar dele no momento de gerar o registro.

  end;

  { REGISTRO C (MOVIMENTAÇÃO)
    Registro da movimentação de empregado para atualizar. Informe a identificação do estabelecimento, os dados cadastrais do empregado com a
    respectiva movimentação, o tipo de acerto a efetuar e a competência (mês e ano de referência da informação).}
  TRegistroTipoC = class
  private
    FTipoRegistro:                             String; // 1 A. Define o registro a ser informado. Obrigatoriamente o conteúdo é X.
    FTipoIdentificador:                        String; // 1 N. Define o tipo de identificador do estabelecimento a informar. 1. CNPJ - 2. CEI
    FNumeroIdentificadorDoEstabelecimento:     String; { 14 N. Número identificador do estabelecimento. Não havendo inscrição
      do estabelecimento no Cadastro Nacional de Pessoa Jurídica (CNPJ), informar o número de registro no CEI (Código Específico do INSS).
      O número do CEI tem 12 posições, preencher este campo com 00 zeros à esquerda.}
    FSequencia:                                String; // 5 N. Número seqüencial no arquivo.
    FPisPasep:                                 String;  {11 N. Número do PIS/PASEP do empregado movimentado. Informar sem máscara (/.\-,).}
    FSexo:                                     String; { 1  N. Define o sexo do empregado. 1 - Masculino 2 - Feminino.}
    FNascimento:                               TDateTime; // 8 N. Dia, mês e ano de nascimento do empregado. Informar a data do nascimento sem máscara (/.\-,).
    FGrauInstrucao:                            String; { 2 N. Define o grau de instrução do empregado.
      1. Analfabeto inclusive o que, embora tenha recebido instrução, não se alfabetizou.
      2. Até o 5º ano incompleto do Ensino Fundamental (antigo 1º grau ou primário) que se tenha alfabetizado sem ter freqüentado escola
      regular.
      3. 5º ano completo do Ensino Fundamental (antigo 1º grau ou primário).
      4. Do 6º ao 9º ano de Ensino Fundamental (antigo 1º grau ou ginásio).
      5. Ensino Fundamental completo (antigo 1º grau ou primário e ginasial).
      6. Ensino Médio incompleto (antigo 2º grau, secundário ou colegial).
      7. Ensino Médio completo (antigo 2º grau, secundário ou colegial).
      8. Educação Superior incompleta.
      9. Educação Superior completa.
      10.Mestrado
      11.Doutorado.}
    // FILLER, caracter, 4 posições. Deixar em branco. Obrigatório. Tratar quando gerar o arquivo.
    FSalarioMensal:                            String; { 8 N.Informar o salário recebido, ou a receber. Informar com centavos sem
      pontos e sem vírgulas. Ex: R$ 134,60 informar: 13460.}
    FHorasTrabalhadas:                         String; // 2 N. Informar a quantidade de horas trabalhadas por semana (de 1 até 44 horas).
    FAdmissao:                                 TDateTime; // 8 N. Dia, mês e ano de admissão do empregado. Informar a data de admissão sem máscara (/.\-,).
    FTipoMovimento:                            String; {  2 N.Define o tipo de movimento.
      ADMISSÃO
        10 - Primeiro emprego
        20 - Reemprego
        25 - Contrato por prazo determinado
        35 - Reintegração
        70 - Transferência de entrada
      DESLIGAMENTO
        31 - Dispensa sem justa causa
        32 - Dispensa por justa causa
        40 - A pedido (espontâneo)
        43 - Término de contrato por prazo determinado
        45 - Término de contrato
        50 - Aposentado
        60 - Morte
        80 - Transferência de saída.}
    FDiaDeDesligamento:                        String; { 2 N. Se o tipo de movimento for desligamento, informar o dia da saída do empregado se for admissão deixar em branco.}
    FNomeDoEmpregado:                          String; // 40 A. Informar o nome do empregado movimentado.
    FNumeroCarteiraTrabalho:                   String; // 8 N. Informar o número da carteira de trabalho e previdência social do empregado.
    FSerieCarteiraTrabalho:                    String; // 4 N. Informar o número de série da carteira de trabalho e previdência social do empregado.
    FRacaCor:                                  String; { 1 N. Informe a raça ou cor do empregado, utilizando o código:
      1 - Indígena
      2 - Branca
      4 - Preta
      6 - Amarela
      8 - Parda
      9 - Não informado}
    FPessaoComDeficiencia:                     String; { 1 N. Informe se o empregado é portador de deficiência, utilizando:
      1. Para indicar SIM
      2. Para indicar NÃO.}
    FCBO2000:                                  String; { 6 N. Informe o código de ocupação conforme a Classificação Brasileira de
      Ocupação - CBO. Informar sem máscara (/.\-,). Veja o site da CBO.}
    FAprendiz:                                 String; // 1 N. Informar se o empregado é Aprendiz ou não. 1. SIM 2. NÃO.
    FUFCarteiraDeTrabalho:                     String; { 2 A. Informar a Unidade de Federação da carteira de trabalho e previdência
      social do empregado. OBS: Quando se tratar de carteira de trabalho, novo modelo, para o campo série deve ser utilizado uma
      posição do campo uf, ficando obrigatoriamente a última em branco.}
    FTipoDeficienciaBeneficiarioReabilitado:   String; {1 A. Informe o tipo de deficiência do empregado, conforme as categorias abaixo,
      ou se o mesmo é beneficiário reabilitado da Previdência Social.
      1. Física
      2. Auditiva
      3. Visual
      4. Mental
      5. Múltipla
      6. Reabilitado.}
    FCpf:                                      String; //11 N, obrigatório. Código Pessoa Física da Receita Federal.
    FCep:                                      String; {8  N. Informar o Código de Endereçamento Postal do estabelecimento conforme a tabela da
      Empresa de Correios e Telégrafos-ECT. Informar sem  máscara (/.\-,).}
    // Filler2:                         String; // 81 A. Deixar em branco. Tratar na geração do arquivo. Obrigatorio

    FRegistroValido:                    Boolean;


  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido:                           Boolean   read FRegistroValido                           write FRegistroValido;
    property TipoIdentificador:                        String    read FTipoRegistro                             write FTipoRegistro;
    property NumeroIdentificadorDoEstabelecimento:     String    read FNumeroIdentificadorDoEstabelecimento     write FNumeroIdentificadorDoEstabelecimento;
    property Sequencia:                                String    read FSequencia                                write FSequencia;
    property PisPasep:                                 String    read FPisPasep                                 write FPisPasep;
    property Sexo:                                     String    read FSexo                                     write FSexo;
    property Nascimento:                               TDateTime read FNascimento                               write FNascimento;
    property GrauInstrucao:                            String    read FGrauInstrucao                            write FGrauInstrucao;
    // property FFiller1, 4 A. Deixar em branco. Tratar na geração do arquivo. Obrigatorio
    property SalarioMensal:                            String    read FSalarioMensal                            write FSalarioMensal;
    property HorasTrabalhadas:                         String    read FHorasTrabalhadas                         write FHorasTrabalhadas;
    property Admissao:                                 TDateTime read FAdmissao                                 write FAdmissao;
    property TipoMovimento:                            String    read FTipoMovimento                            write FTipoMovimento;
    property DiaDeDesligamento:                        String    read FDiaDeDesligamento                        write FDiaDeDesligamento;
    property NomeDoEmpregado:                          String    read FNomeDoEmpregado                          write FNomeDoEmpregado;
    property NumeroCarteiraTrabalho:                   String    read FNumeroCarteiraTrabalho                   write FNumeroCarteiraTrabalho;
    property SerieCarteiraTrabalho:                    String    read FSerieCarteiraTrabalho                    write FSerieCarteiraTrabalho;
    property RacaCor:                                  String    read FRacaCor                                  write FRacaCor;
    property PessaoComDeficiencia:                     String    read FPessaoComDeficiencia                     write FPessaoComDeficiencia;
    property CBO2000:                                  String    read FCBO2000                                  write FCBO2000;
    property Aprendiz:                                 String    read FAprendiz                                 write FAprendiz;
    property UFCarteiraDeTrabalho:                     String    read FUFCarteiraDeTrabalho                     write FUFCarteiraDeTrabalho;
    property TipoDeficienciaBeneficiarioReabilitado:   String    read FTipoDeficienciaBeneficiarioReabilitado   write FTipoDeficienciaBeneficiarioReabilitado;
    property Cpf:                                      String    read FCpf                                      write FCpf;
    property Cep:                                      String    read FCep                                      write FCep;
    /// property FFiller2, 81 A. Campo obrigatório. Preencher com brancos Tratar dele no momento de gerar o registro.

  end;

  // REGISTRO C - Lista
  TRegistroTipoCList = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipoC;
    procedure SetItem(Index: Integer; const Value: TRegistroTipoC);
  public
    function New: TRegistroTipoC;
    property Items[Index: Integer]: TRegistroTipoC read GetItem write SetItem;
  end;


  {REGISTRO X (ACERTO)
  Registro da movimentação de empregado para atualizar. Informe a identificação do estabelecimento, os dados cadastrais do empregado com a
  respectiva movimentação, o tipo de acerto a efetuar e a competência (mês e ano de referência da informação).}
  TRegistroTipoX = class
  private
    FTipoRegistro:                             String; // 1 A. Define o registro a ser informado. Obrigatoriamente o conteúdo é X.
    FTipoIdentificador:                        String; // 1 N. Define o tipo de identificador do estabelecimento a informar. 1. CNPJ - 2. CEI
    FNumeroIdentificadorDoEstabelecimento:     String; { 14 N. Número identificador do estabelecimento. Não havendo inscrição
      do estabelecimento no Cadastro Nacional de Pessoa Jurídica (CNPJ), informar o número de registro no CEI (Código Específico do INSS).
      O número do CEI tem 12 posições, preencher este campo com 00 zeros à esquerda.}
    FSequencia:                                String; // 5 N. Número seqüencial no arquivo.
    FPisPasep:                                 String;  {11 N. Número do PIS/PASEP do empregado movimentado. Informar sem máscara (/.\-,).}
    FSexo:                                     String; { 1  N. Define o sexo do empregado. 1 - Masculino 2 - Feminino.}
    FNascimento:                               TDateTime; // 8 N. Dia, mês e ano de nascimento do empregado. Informar a data do nascimento sem máscara (/.\-,).
    FGrauInstrucao:                            String; { 2 N. Define o grau de instrução do empregado.
      1. Analfabeto inclusive o que, embora tenha recebido instrução, não se alfabetizou.
      2. Até o 5º ano incompleto do Ensino Fundamental (antigo 1º grau ou primário) que se tenha alfabetizado sem ter freqüentado escola
      regular.
      3. 5º ano completo do Ensino Fundamental (antigo 1º grau ou primário).
      4. Do 6º ao 9º ano de Ensino Fundamental (antigo 1º grau ou ginásio).
      5. Ensino Fundamental completo (antigo 1º grau ou primário e ginasial).
      6. Ensino Médio incompleto (antigo 2º grau, secundário ou colegial).
      7. Ensino Médio completo (antigo 2º grau, secundário ou colegial).
      8. Educação Superior incompleta.
      9. Educação Superior completa.
      10.Mestrado
      11.Doutorado.}
    // FILLER, caracter, 4 posições. Deixar em branco. Obrigatório. Tratar quando gerar o arquivo.
    FSalarioMensal:                            String; { 8 N.Informar o salário recebido, ou a receber. Informar com centavos sem
      pontos e sem vírgulas. Ex: R$ 134,60 informar: 13460.}
    FHorasTrabalhadas:                         String; // 2 N. Informar a quantidade de horas trabalhadas por semana (de 1 até 44 horas).
    FAdmissao:                                 TDateTime; // 8 N. Dia, mês e ano de admissão do empregado. Informar a data de admissão sem máscara (/.\-,).
    FTipoMovimento:                            String; {  2 N.Define o tipo de movimento.
      ADMISSÃO
        10 - Primeiro emprego
        20 - Reemprego
        25 - Contrato por prazo determinado
        35 - Reintegração
        70 - Transferência de entrada
      DESLIGAMENTO
        31 - Dispensa sem justa causa
        32 - Dispensa por justa causa
        40 - A pedido (espontâneo)
        43 - Término de contrato por prazo determinado
        45 - Término de contrato
        50 - Aposentado
        60 - Morte
        80 - Transferência de saída.}
    FDiaDeDesligamento:                        String; { 2 N. Se o tipo de movimento for desligamento, informar o dia da saída do empregado se for admissão deixar em branco.}
    FNomeDoEmpregado:                          String; // 40 A. Informar o nome do empregado movimentado.
    FNumeroCarteiraTrabalho:                   String; // 8 N. Informar o número da carteira de trabalho e previdência social do empregado.
    FSerieCarteiraTrabalho:                    String; // 4 N. Informar o número de série da carteira de trabalho e previdência social do empregado.
    FAtualizacao:                              String; { 1 N. Informar o procedimento a ser seguido: 1. Exclusão de registro
      2. Inclusão de registro}
    FCompetencia:                              String; // 6 N. Mês e ano de referência das informações do registro. Informar sem máscara (/.\-,).
    FRacaCor:                                  String; { 1 N. Informe a raça ou cor do empregado, utilizando o código:
      1 - Indígena
      2 - Branca
      4 - Preta
      6 - Amarela
      8 - Parda
      9 - Não informado}
    FPessaoComDeficiencia:                     String; { 1 N. Informe se o empregado é portador de deficiência, utilizando:
      1. Para indicar SIM
      2. Para indicar NÃO.}
    FCBO2000:                                  String; { 6 N. Informe o código de ocupação conforme a Classificação Brasileira de
      Ocupação - CBO. Informar sem máscara (/.\-,). Veja o site da CBO.}
    FAprendiz:                                 String; // 1 N. Informar se o empregado é Aprendiz ou não. 1. SIM 2. NÃO.
    FUFCarteiraDeTrabalho:                     String; { 2 A. Informar a Unidade de Federação da carteira de trabalho e previdência
      social do empregado. OBS: Quando se tratar de carteira de trabalho, novo modelo, para o campo série deve ser utilizado uma
      posição do campo uf, ficando obrigatoriamente a última em branco.}
    FTipoDeficienciaBeneficiarioReabilitado:   String; {1 A. Informe o tipo de deficiência do empregado, conforme as categorias abaixo,
      ou se o mesmo é beneficiário reabilitado da Previdência Social.
      1. Física
      2. Auditiva
      3. Visual
      4. Mental
      5. Múltipla
      6. Reabilitado.}
    FCpf:                                      String; //11 N, obrigatório. Código Pessoa Física da Receita Federal.
    FCep:                                      String; {8  N. Informar o Código de Endereçamento Postal do estabelecimento conforme a tabela da
      Empresa de Correios e Telégrafos-ECT. Informar sem  máscara (/.\-,).}
    // Filler2:                         String; // 81 A. Deixar em branco. Tratar na geração do arquivo. Obrigatorio

    FRegistroValido:                    Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido:                           Boolean   read FRegistroValido                           write FRegistroValido;
    property TipoIdentificador:                        String    read FTipoRegistro                             write FTipoRegistro;
    property NumeroIdentificadorDoEstabelecimento:     String    read FNumeroIdentificadorDoEstabelecimento     write FNumeroIdentificadorDoEstabelecimento;
    property Sequencia:                                String    read FSequencia                                write FSequencia;
    property PisPasep:                                 String    read FPisPasep                                 write FPisPasep;
    property Sexo:                                     String    read FSexo                                     write FSexo;
    property Nascimento:                               TDateTime read FNascimento                               write FNascimento;
    property GrauInstrucao:                            String    read FGrauInstrucao                            write FGrauInstrucao;
    // property FFiller1, 4 A. Deixar em branco. Tratar na geração do arquivo. Obrigatorio
    property SalarioMensal:                            String    read FSalarioMensal                            write FSalarioMensal;
    property HorasTrabalhadas:                         String    read FHorasTrabalhadas                         write FHorasTrabalhadas;
    property Admissao:                                 TDateTime read FAdmissao                                 write FAdmissao;
    property TipoMovimento:                            String    read FTipoMovimento                            write FTipoMovimento;
    property DiaDeDesligamento:                        String    read FDiaDeDesligamento                        write FDiaDeDesligamento;
    property NomeDoEmpregado:                          String    read FNomeDoEmpregado                          write FNomeDoEmpregado;
    property NumeroCarteiraTrabalho:                   String    read FNumeroCarteiraTrabalho                   write FNumeroCarteiraTrabalho;
    property SerieCarteiraTrabalho:                    String    read FSerieCarteiraTrabalho                    write FSerieCarteiraTrabalho;
    property RacaCor:                                  String    read FRacaCor                                  write FRacaCor;
    property PessaoComDeficiencia:                     String    read FPessaoComDeficiencia                     write FPessaoComDeficiencia;
    property Atualizacao:                              String    read FAtualizacao                              write FAtualizacao;
    property Competencia:                              String    read FCompetencia                              write FCompetencia;
    property CBO2000:                                  String    read FCBO2000                                  write FCBO2000;
    property Aprendiz:                                 String    read FAprendiz                                 write FAprendiz;
    property UFCarteiraDeTrabalho:                     String    read FUFCarteiraDeTrabalho                     write FUFCarteiraDeTrabalho;
    property TipoDeficienciaBeneficiarioReabilitado:   String    read FTipoDeficienciaBeneficiarioReabilitado   write FTipoDeficienciaBeneficiarioReabilitado;
    property Cpf:                                      String    read FCpf                                      write FCpf;
    property Cep:                                      String    read FCep                                      write FCep;
    /// property FFiller2, 81 A. Campo obrigatório. Preencher com brancos Tratar dele no momento de gerar o registro.
  end;

  // REGISTRO X - Lista
  TRegistroTipoXList = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipoX;
    procedure SetItem(Index: Integer; const Value: TRegistroTipoX);
  public
    function New: TRegistroTipoX;
    property Items[Index: Integer]: TRegistroTipoX read GetItem write SetItem;
  end;

implementation

{ TRegistroTipoA }

constructor TRegistroTipoA.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipoA.Destroy;
begin

  inherited;
end;

{ TRegistroTipoB }

constructor TRegistroTipoB.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipoB.Destroy;
begin

  inherited;
end;

{ TRegistroTipoC }

constructor TRegistroTipoC.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipoC.Destroy;
begin

  inherited;
end;

{ TRegistroTipoX }

constructor TRegistroTipoX.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipoX.Destroy;
begin

  inherited;
end;

{ TRegistroTipoCList }

function TRegistroTipoCList.GetItem(Index: Integer): TRegistroTipoC;
begin
  Result := TRegistroTipoC(inherited Items[Index]);
end;

function TRegistroTipoCList.New: TRegistroTipoC;
begin
  Result := TRegistroTipoC.Create;
  Add(Result);
end;

procedure TRegistroTipoCList.SetItem(Index: Integer; const Value: TRegistroTipoC);
begin
  Put(Index, Value);
end;

{ TRegistroTipoXList }

function TRegistroTipoXList.GetItem(Index: Integer): TRegistroTipoX;
begin
  Result := TRegistroTipoX(inherited Items[Index]);
end;

function TRegistroTipoXList.New: TRegistroTipoX;
begin
  Result := TRegistroTipoX.Create;
  Add(Result);
end;

procedure TRegistroTipoXList.SetItem(Index: Integer; const Value: TRegistroTipoX);
begin
  Put(Index, Value);
end;

end.
