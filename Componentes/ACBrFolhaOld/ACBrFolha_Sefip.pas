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

unit ACBrFolha_Sefip;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils;
{******************************************************************************
|*  Descrição dos valores de campos.
|* A  = String
|* AN = String
|* N  = String
|* V  = Double
|* D  = DateTime
|* Trata as situações com valores e datas.
|* Nota: Todas as registros devem conter 360 caracteres
*******************************************************************************}

type
  // REGISTRO TIPO 00 – Informações do Responsável (Cabeçalho do arquivo)

  { A competência 13 destina-se exclusivamente à geração de informações à Previdência Social.
    A competência 13 admite as categorias de trabalhador 01, 04, 05, 07, 11, 12, 19, 20, 21 e 26.
    Os códigos de recolhimento 418 e 604, a ausência de fato gerador e a exclusão de informações devem
    ser utilizados exclusivamente na Entrada de dados do SEFIP. }

  TRegistroTipo00 = class
  private
    FTipoRegistro: String; // 2 N - Campo obrigatório. Sempre “00”.
    /// Brancos. 51 AN - Campo obrigatório. Preencher com brancos Tratar dele no momento de gerar o registro.
    FTipoRemessa: String; { 1 N - (Para indicar se o arquivo referese a recolhimento mensal ou recolhimento específico do FGTS). Campo obrigatório.
      Só pode ser 1 (GFIP), ou 3 (DERF). A opção 3 será implementada futuramente e somente deverá ser utilizada quando autorizada pela CAIXA. }
    FTipoInscricaoResponsavel: String; { 1 N - Campo obrigatório. Só pode ser 1 (CNPJ), 2 (CEI) ou 3 (CPF) Só pode ser igual a 3 (CPF), para o
      código de recolhimento 418. }
    FInscricaoResponsavel: String; { 14 N - Campo obrigatório. Deve ser informada a inscrição (CNPJ/CEI) do certificado responsável pela transmissão
      do arquivo pelo Conectividade. Se Tipo Inscrição = 1, então número esperado CNPJ válido.
      Se Tipo Inscrição = 2, então número esperado CEI válido.
      Se Tipo Inscrição = 3, então número esperado CPF válido. }
    FNomeResponsavelRazaoSocial: String; { 30 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FNomePessoaContato: String; { 20 A - Campo obrigatório. Não pode conter número. Não pode conter caracteres especiais.Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos.
      A primeira posição não pode ser branco. Pode conter apenas caracteres de A a Z. }
    FLogradouro: String; { 50 AN - Rua, nº, andar,apartamento. Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FBairro: String; { 20 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FCep: String; // 8 N - Campo obrigatório. Número de CEP válido. Permitido apenas, números diferentes de 20000000, 30000000, 70000000 ou 80000000.
    FCidade: String; { 20 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FUnidadeFederacao: String; // 2 A - Campo obrigatório. Deve constar da tabela de unidades da federação
    FTelefoneContato: String; // 12 N - Campo obrigatório. Deve conter no mínimo 02 dígitos válidos no DDD e 07 dígitos no telefone.
    FEnderecoInternetContato: String; // 60 AN - Campo opcional. Endereço INTERNET válido.
    FCompetencia: TDateTime; { 6 D -  Campo obrigatório. Formato AAAAMM, onde AAAA indica o ano e MM o mês da competência. O mês informado deve ser de 1 a 13
      O ano informado deve maior ou igual a 1967. Acatar o mês de competência 13 para ano maior ou igual a 1999.
      Não pode ser informado competência 13 para os códigos de recolhimento 130, 135, 145, 211, 307,317, 327, 337, 345, 640, 650 e 660.
      Acatar apenas competência maior ou igual a 03/2000 para código de recolhimento 211.
      Acatar apenas competência menor que 10/1988 para o código de recolhimento 640.
      Acatar apenas competência maior ou igual a 03/2000 para empregador doméstico. }
    FCodigoRecolhimento: String; { 3 N - Campo obrigatório. Os códigos de recolhimento 418 e 604 são utilizados exclusivamente na Entrada de Dados do SEFIP.
      Informação deve estar contida na tabela de Código de Recolhimento. }
    FIndicadorRecolhimentoFGTS: String; { 1 N - (Para identificar se o recolhimento será realizado no prazo, em atraso, se mediante ação fiscal ou ainda se refere-se à
      individualização de valores já recolhidos). Pode ser 1 (GRF no prazo), 2 (GRF em atraso), 3 (GRF em atraso – Ação Fiscal),5 (Individualização) 6 (Individualização – Ação Fiscal) ou branco.
      Campo obrigatório para os códigos de recolhimento 115, 130, 135, 145, 150, 155, 307, 317, 327,337, 345, 608, 640, 650 e 660.
      Os códigos de recolhimento 145, 307, 317, 327, 337, 345 e 640 não aceitam indicador igual a 1(GRF no prazo).
      Não pode ser informado para o código de recolhimento 211. Não pode ser informado na competência 13.
      Sempre que não informado o campo deve ficar em branco. }
    FModalidadeArquivo: String; { 1 N - (Para identificar a que tipo de modalidade o arquivo se refere) Pode ser: Branco – Recolhimento ao FGTS e Declaração à Previdência. 1 - Declaração ao FGTS e à Previdência
      9 - Confirmação Informações anteriores – Rec/Decl ao FGTS e Decl à Previdência. Para competência anterior a 10/1998 deve ser igual a branco ou 1.
      A modalidade 9 não pode ser informada para competências anteriores a 10/1998. Para os códigos 145, 307, 317, 327, 337, 345 e 640 deve ser igual a branco.
      Para o código 211 deve ser igual a 1 ou 9. Para o FPAS 868 deve igual a branco ou 9. Para a competência 13, deve ser igual a 1 ou 9.
      Serão acatadas até três cargas consecutivas de SEFIP.RE. Deverá existir apenas um arquivo SEFIP.RE para cada modalidade. }
    FDataRecolhimentoFGTS: TDateTime; { 8 D - (Indicar a data efetiva de recolhimento do FGTS, sempre que o recolhimento for realizado em atraso (Indicador 2 e 3) e no caso de
      individualização (Indicador 5 e 6)) Obs.: Os campos Código de Recolhimento e Indicador de Recolhimento FGTS determinam a
      obrigatoriedade desta data. Formato DDMMAAAA. A tabela contendo o edital para recolhimento em atraso, é disponibilizada em arquivo, nas agências
      da Caixa ou no site www.caixa.gov.br. Não pode ser informado quando o indicador de recolhimento do FGTS for igual a 1 (GRF no prazo).
      Sempre que não informado o campo deve ficar em branco. }
    FIndicadorRecolhimentoPrevidenciaSocial: String; { 1 N -(Para identificar se o recolhimento da Previdência Social será realizado no prazo ou em atraso)Campo obrigatório. Só pode ser 1 (no prazo), 2 (em atraso) ou 3 (não gera GPS).
      Deve ser igual a 3, para competência anterior a 10/1998 e para os códigos de recolhimento exclusivos do FGTS (145, 307, 317, 327, 337, 345, 640 e 660). }
    FDataRecolhimentoPrevidenciaSocial: TDateTime; { 8 D - (Indicar a data efetiva de recolhimento da Previdência Social, sempre que o recolhimento for realizado em atraso)
      Obs.: O Indicador de Recolhimento da Previdência Social determina a obrigatoriedade desta data. Formato DDMMAAAA.
      Só pode ser informado se Indicador de Recolhimento Previdência Social for igual a 2 e a data informada for posterior ao dia 10 do mês seguinte ao da competência.
      Para código de recolhimento 650 deve ser posterior ao dia 02 do mês seguinte ao da competência. Para competência 13, deve ser posterior a 20/12/AAAA, onde AAAA é o ano a que se refere a
      competência. Sempre que não informado o campo deve ficar em branco. }
    FIndiceRecolhimentoAtrasoPrevidenciaSocial: String; { 7 N - (Para recolhimentos efetuados a partir do 2º mês seguinte ao do vencimento.
      Referente à taxa SELIC + 2%). Campo deve ficar em branco. A tabela para recolhimento de GPS em atraso (SELIC) será disponibilizada, mensalmente, no site
      www.caixa.gov.br e www.previdenciasocial.gov.br. }
    FTipoInscricaoFornecedorFolhaPagamento: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ), 2 (CEI) ou 3 (CPF).
    FInscricaoFornecedorFolhaPagamento: String; { 14 N - Campo obrigatório.
      Se Tipo Inscrição = 1, então número esperado CNPJ válido. Se Tipo Inscrição = 2, então número esperado CEI válido.
      Se Tipo Inscrição = 3, então número esperado CPF válido. }
    /// Brancos. 18 AN - Campo obrigatório. Preencher com brancos Tratar dele no momento de gerar o registro.
    /// Final de Linha 1 AN - Deve ser uma constante “*” para marcar fim de linha. Tratar dele no momento de gerar o registro.

    FRegistroValido: Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read FRegistroValido write FRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    /// property Brancos. Campo obrigatório. Preencher com brancos Tratar dele no momento de gerar o registro.
    property TipoRemessa: String read FTipoRemessa write FTipoRemessa;
    property TipoInscricaoResponsavel: String read FTipoInscricaoResponsavel write  FTipoInscricaoResponsavel;
    property InscricaoResponsavel: String read FInscricaoResponsavel write FInscricaoResponsavel;
    property NomeResponsavelRazaoSocial: String read FNomeResponsavelRazaoSocial write FNomeResponsavelRazaoSocial;
    property NomePessoaContato: String read FNomePessoaContato write FNomePessoaContato;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Bairro: String read FBairro write FBairro;
    property Cep: String read FCep write FCep;
    property Cidade: String read FCidade write FCidade;
    property UnidadeFederacao: String read FUnidadeFederacao write FUnidadeFederacao;
    property TelefoneContato: String read FTelefoneContato write FTelefoneContato;
    property EnderecoInternetContato: String read FEnderecoInternetContato write FEnderecoInternetContato;
    property Competencia: TDateTime read FCompetencia write FCompetencia;
    property CodigoRecolhimento: String read FCodigoRecolhimento write FCodigoRecolhimento;
    property IndicadorRecolhimentoFGTS: String read FIndicadorRecolhimentoFGTS write FIndicadorRecolhimentoFGTS;
    property ModalidadeArquivo: String read FModalidadeArquivo write FModalidadeArquivo;
    property DataRecolhimentoFGTS: TDateTime read FDataRecolhimentoFGTS write FDataRecolhimentoFGTS;
    property IndicadorRecolhimentoPrevidenciaSocial: String read FIndicadorRecolhimentoPrevidenciaSocial write FIndicadorRecolhimentoPrevidenciaSocial;
    property DataRecolhimentoPrevidenciaSocial: TDateTime read FDataRecolhimentoPrevidenciaSocial write FDataRecolhimentoPrevidenciaSocial;
    property IndiceRecolhimentoAtrasoPrevidenciaSocial: String read FIndiceRecolhimentoAtrasoPrevidenciaSocial write FIndiceRecolhimentoAtrasoPrevidenciaSocial;
    property TipoInscricaoFornecedorFolhaPagamento: String read FTipoInscricaoFornecedorFolhaPagamento write FTipoInscricaoFornecedorFolhaPagamento;
    property InscricaoFornecedorFolhaPagamento: String read FInscricaoFornecedorFolhaPagamento write FInscricaoFornecedorFolhaPagamento;
    /// property Brancos. Campo obrigatório. Preencher com brancos Tratar dele no momento de gerar o registro.
    /// property Final de Linha Deve ser uma constante “*” para marcar fim de linha. Tratar dele no momento de gerar o registro.
  end;


  // REGISTRO TIPO 10 – Informações da Empresa (Cabeçalho da empresa )

  TRegistroTipo10 = class
  private
    FTipoRegistro: String; // 2 N - Campo obrigatório. Sempre “10”.
    FTipoInscricaoEmpresa: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI). Para empregador doméstico só pode ser 2(CEI).
    FInscricaoEmpresa: String; { 14 N - Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido.
      Se Tipo Inscrição = 2, então número esperado CEI válido. Para empregador doméstico só pode acatar 2 (CEI). }
    /// Zeros. 36 N - Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    FNomeEmpresaRazaoSocial: String; { 40 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos.
      A primeira posição não pode ser branco. Permitido apenas caracteres de A a Z e números de 0 a 9. }
    FLogradouro: String; { 50 AN - Rua, nº, andar,apartamento. Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FBairro: String; { 20 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FCep: String; // 8 N - Campo obrigatório. Número de CEP válido. Permitido apenas, números diferentes de 20000000, 30000000, 70000000 ou 80000000.
    FCidade: String; { 20 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FUnidadeFederacao: String; // 2 A - Campo obrigatório. Deve constar da tabela de unidades da federação
    FTelefoneContato: String; // 12 N - Campo obrigatório. Deve conter no mínimo 02 dígitos válidos no DDD e 07 dígitos no telefone.
    FIndicadorAlteracaoEndereco: String; { 1 A - Campo obrigatório. Só pode ser “S” ou “s” quando a empresa desejar alterar o endereço e “N” ou “n” quando não
      desejar modificá-lo. Para a competência 13, preencher com “N” ou “n”. }
    FCNAE: String; // 7 N - Campo obrigatório. Número válido de CNAE. Para empregador doméstico utilizar o número 9700500.
    FIndicadorAlteracaoCNAE: String; { 1 A - Campo obrigatório. Para os códigos 145, 307, 317, 327, 337, 345, e 660 e competências até 05/2008 pode ser:
      - “S” ou “s” se desejar alterar o CNAE - “N” ou “n” se não desejar alterar .
      · Para competências a partir de 06/2008 pode ser: - “S” ou “s” se desejar alterar o CNAE - “N” ou “n” se não desejar alterar .
      - “A” ou “a” se desejar alterar e for CNAE preponderante. - “P” ou “p” se não desejar alterar e for CNAE preponderante.
      Para a competência 13, preencher com “N” ou “n”. }
    FAliquotaRAT: String; { 2 N - (Informar alíquota para o cálculo da contribuição destinada ao financiamento dos benefícios concedidos em razão de
      incidência de incapacidade laborativa decorrente dos riscos ambientais do trabalho – RAT). Campo obrigatório.
      Campo com uma posição inteira e uma decimal. Campo obrigatório para competência maior ou igual a 10/1998.
      Não pode ser informado para competências anteriores a 10/1998.
      Não pode ser informado para competências anteriores a 04/99 quando o FPAS for 639.
      Não pode ser informado para os códigos de recolhimento 145, 307, 317, 327, 337, 345, 640 e 660.
      Será zeros para FPAS 604, 647, 825, 833 e 868 (empregador doméstico) e para a empresa optante pelo SIMPLES.
      Não pode ser informado para FPAS 604 com recolhimento de código 150 em competências posteriores a 10/2001.
      Sempre que não informado o campo deve ficar em branco. }
    FCodigoCentralizacao: String; { 1 N - (Para indicar as empresas que centralizam o recolhimento do FGTS ). Campo obrigatório.
      Só pode ser 0 (não centraliza), 1 (centralizadora) ou 2 (centralizada).
      Deve ser igual a zero (0), para os códigos de recolhimento 130, 135, 150, 155, 211, 317, 337, 608 e para empregador doméstico (FPAS 868).
      Quando existir empresa centralizadora deve existir, no mínimo, uma empresa centralizada e viceversa. Quando existir centralização,
      as oito primeiras posições do CNPJ da centralizadora e da centralizada devem ser iguais. Empresa com inscrição CEI não possui centralização. }
    FSIMPLES: String; { 1 N -(Para indicar se a empresa é ou não optante pelo SIMPLES - Lei n° 9.317, de 05/12/96 e para determinar a isenção da Contribuição Social).
      Campo obrigatório. Só pode ser 1 - Não Optante; 2 – Optante; 3 – Optante - faturamento anual superior a R$1.200.000,00 ;
      4 – Não Optante - Produtor Rural Pessoa Física (CEI e FPAS 604 ) com faturamento anual superior a R$1.200.000,00.
      5 – Não Optante – Empresa com Liminar para não recolhimento da Contribuição Social – Lei Complementar 110/01, de 26/06/2001.
      6 – Optante - faturamento anual superior a R$1.200.000,00 - Empresa com Liminar para não recolhimento da Contribuição Social – Lei Complementar 110/01, de 26/06/2001.
      Deve sempre ser igual a 1ou 5 para FPAS 582, 639, 663, 671, 680 e 736. Deve sempre ser igual a 1 para o FPAS 868 (empregador doméstico).
      Não pode ser informado para o código de recolhimento 640. Não pode ser informado para competência anterior a 12/1996.
      Os códigos 3, 4, 5 e 6 não podem ser informados a partir da competência 01/2007. Sempre que não informado o campo deve ficar em branco. }
    FFPAS: String; { 3 N - (Informar o código referente à atividade econômica principal do empregador/contribuinte que identifica as contribuições ao FPAS e a outras entidades e fundos - terceiros)
      Campo obrigatório. Deve ser um FPAS válido. Deve ser diferente de 744 e 779, pois as GPS desses códigos serão geradas automaticamente,
      sempre que forem informados os respectivos fatos geradores dessas contribuições. Deve ser diferente de 620, pois a informação das categorias 15, 16, 18, 23 e 25 indica os
      respectivos fatos geradores dessas contribuições. Deve ser diferente de 663 e 671 a partir da competência 04/2004. Deve ser igual a 868 para empregador doméstico. }
    FCodigoOutrasEntidades: String; { 4 N - (Informar o código de outras entidades e fundos para as quais a empresa está obrigada a contribuir)
      Campo obrigatório para os códigos de recolhimento 115, 130, 135, 150, 155, 211, 608 e 650, Não pode ser informado para os códigos de recolhimento 145, 307, 317, 327, 337, 345, 640 e 660.
      Não pode ser informado para competências anteriores a 10/1998. Não pode ser informado para competências anteriores a 04/99 para o código FPAS 639.
      Deve estar contido na tabela de terceiros, inclusive zeros se SIMPLES for igual a 1, 4 ou 5. Deve ficar em branco quando o SIMPLES for igual a 2 , 3 ou 6.
      Sempre que não informado o campo deve ficar em branco. }
    FCodigoPagamentoGPS: String; { 4 N - (Informar o código de pagamento da GPS, conforme tabela divulgada pelo INSS). Campo obrigatório para competência maior ou igual a 10/1998.
      Acatar apenas para os códigos de recolhimento 115, 150, 211 e 650. Não pode ser informado para os códigos de recolhimento 145, 307, 327, 345, 640 e 660.
      Para FPAS 868 (empregador doméstico) acatar apenas os códigos GPS 1600 e 1651. Sempre que não informado o campo deve ficar em branco. }
    FPercentualIsencaoFilantropia: String; { 5 N - (Informar o percentual de isenção conforme Lei 9.732/98) Valor deve ser composto de três inteiros e duas decimais.
      Só pode ser informado quando o FPAS for igual a 639. Sempre que não informado o campo deve ficar em branco. }
    FSalarioFamilia: Double; { 15 V - (Informar o total pago pela empresa a título de saláriofamília.O valor informado será deduzido na GPS) Opcional para os códigos de recolhimento 115 e 211.
      Não pode ser informado para os códigos de recolhimento 145, 307, 327, 345, 640, 650, 660 e FPAS 868 (empregador doméstico).
      Não pode ser informado para a competência 13. Não pode ser informado para competências anteriores a 10/1998. Sempre que não informado preencher com zeros. }
    FSalarioMaternidade: Double; { 15 V - (Indicar o total pago pela empresa a título de salário-maternidade no mês em referência. O valor será deduzido na GPS).
      Opcional para o código de recolhimento 115. Opcional para os códigos de recolhimento 150, 155 e 608, quando o CNPJ da empresa for igual ao CNPJ do tomador.
      Não pode ser informado para os códigos de recolhimento 130, 135, 145, 211, 307, 317, 327, 337, 345, 640, 650, 660 e para empregador doméstico (FPAS 868).
      Não pode ser informado para competências anteriores a 10/1998. Não pode ser informado para as competências 06/2000 a 08/2003.
      Não pode ser informado para licença maternidade iniciada a partir de 01.12.1999 e com benefícios requeridos até 31/08/2003.
      Não pode ser informado para a competência 13. Sempre que não informado preencher com zeros. }
    FContribDescEmpregadoReferenteCompetencia13: Double; { 15 V - (Informar o valor total da contribuição descontada dos segurados na competência 13).
      Não deverá ser informado Preencher com zeros. }
    FIndicadorValorNegativoPositivo: Double; { 1 V - (Para indicar se o valor devido à Previdência Social - campo 26 - é(0) positivo ou (1) negativo).
      Não deverá ser informado. Preencher com zeros. }
    FValorDevidoPrevidenciaSocialReferenteComp13: Double; { 14 V - (Informar o valor total devido à Previdência Social, na competência 13).
      Não deverá ser informado. Preencher com zeros. }
    FBanco: String; // 3 N - “Para débito em conta corrente. Implementação futura” Campo opcional. Se informado, deve ser válido. Sempre que não informado o campo deve ficar em branco.
    FAgencia: String; // 4 N - “Para débito em conta corrente. Implementação futura” Campo opcional. Se informado, deve ser válido. Sempre que não informado o campo deve ficar em branco.
    FContaCorrente: String; // 9 AN - “Para débito em conta corrente. Implementação futura” Campo opcional. Se informado, deve ser válido. Sempre que não informado o campo deve ficar em branco.
    /// Zeros 45 V - Para implementação futura. Tratar dele no momento de gerar o registro.
    /// Brancos 4 AN -  Preencher com brancos. Tratar dele no momento de gerar o registro.
    /// Final de Linha 1 AN Deve ser uma constante “*” para marcar fim de linha. Tratar dele no momento de gerar o registro.

    FRegistroValido: Boolean;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read FRegistroValido write FRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property TipoInscricaoEmpresa: String read FTipoInscricaoEmpresa write FTipoInscricaoEmpresa;
    property InscricaoEmpresa: String read FInscricaoEmpresa write FInscricaoEmpresa;
    /// Zeros. Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    property NomeEmpresaRazaoSocial: String read FNomeEmpresaRazaoSocial write FNomeEmpresaRazaoSocial;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Bairro: String read FBairro write FBairro;
    property Cep: String read FCep write FCep;
    property Cidade: String read FCidade write FCidade;
    property UnidadeFederacao: String read FUnidadeFederacao write FUnidadeFederacao;
    property TelefoneContato: String read FTelefoneContato write FTelefoneContato;
    property IndicadorAlteracaoEndereco: String read FIndicadorAlteracaoEndereco write FIndicadorAlteracaoEndereco;
    property CNAE: String read FCNAE write FCNAE;
    property IndicadorAlteracaoCNAE: String read FIndicadorAlteracaoCNAE write FIndicadorAlteracaoCNAE;
    property AliquotaRAT: String read FAliquotaRAT write FAliquotaRAT;
    property CodigoCentralizacao: String read FCodigoCentralizacao write FCodigoCentralizacao;
    property SIMPLES: String read FSIMPLES write FSIMPLES;
    property FPAS: String read FFPAS write FFPAS;
    property CodigoOutrasEntidades: String read FCodigoOutrasEntidades write FCodigoOutrasEntidades;
    property CodigoPagamentoGPS: String read FCodigoPagamentoGPS write FCodigoPagamentoGPS;
    property PercentualIsencaoFilantropia: String read FPercentualIsencaoFilantropia write FPercentualIsencaoFilantropia;
    property SalarioFamilia: Double read FSalarioFamilia write FSalarioFamilia;
    property SalarioMaternidade: Double read FSalarioMaternidade write FSalarioMaternidade;
    property ContribDescEmpregadoReferenteCompetencia13: Double read FContribDescEmpregadoReferenteCompetencia13 write FContribDescEmpregadoReferenteCompetencia13;
    property IndicadorValorNegativoPositivo: Double read FIndicadorValorNegativoPositivo write FIndicadorValorNegativoPositivo;
    property ValorDevidoPrevidenciaSocialReferenteComp13: Double read FValorDevidoPrevidenciaSocialReferenteComp13 write FValorDevidoPrevidenciaSocialReferenteComp13;
    property Banco: String read FBanco write FBanco;
    property Agencia: String read FAgencia write FAgencia;
    property ContaCorrente: String read FContaCorrente write FContaCorrente;
    /// Zeros Para implementação futura. Tratar dele no momento de gerar o registro.
    /// Brancos. Preencher com brancos. Tratar dele no momento de gerar o registro.
    /// Final de Linha Deve ser uma constante “*” para marcar fim de linha. Tratar dele no momento de gerar o registro.

  end;


  // REGISTRO TIPO 12 – Informações Adicionais do Recolhimento da Empresa
  // Obrigatório para os códigos de recolhimento 650 e 660.

  TRegistroTipo12 = class
  private
    FTipoRegistro: String; // 2 N -  Campo obrigatório. Sempre “12”.
    FTipoInscricaoEmpresa: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI). Para empregador doméstico só pode ser 2(CEI).
    FInscricaoEmpresa: String; { 14 N - Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido.
      Se Tipo Inscrição = 2, então número esperado CEI válido. A inscrição esperada deve ser igual à do registro tipo 10 imediatamente anterior. }
    /// Zeros 36 N - Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    FDeducao13SalarioLicencaMaternidade: Double; { 15 V - (Informar o valor da parcela de 13º salário referente ao período em que a trabalhadora esteve em
      licença maternidade, nos casos em que o empregador/contribuinte for responsável pelo pagamento do salário-maternidade. A informação deve ser prestada
      nas seguintes situações: - na competência 13, referente ao valor pago durante o ano.
      - na competência da rescisão do contrato de trabalho (exceto rescisão por justa causa), aposentadoria sem continuidade de vínculo ou falecimento )
      Opcional para a competência 13. Opcional para o código de recolhimento 115.
      Opcional para os códigos de recolhimento 150, 155 e 608, quando o CNPJ da empresa for igual ao CNPJ do tomador.
      Deve ser informado quando houver movimentação por rescisão de contrato de trabalho (exceto rescisão com justa causa), aposentadoria sem continuidade de vínculo, aposentadoria por invalidez
      ou falecimento, para empregada que possuir afastamento por motivo de licença maternidade no ano. Não pode ser informado para os códigos de recolhimento 130, 135, 145, 211, 307, 317, 327, 337,
      345, 640, 650, 660 e para empregador doméstico (FPAS 868). Não pode ser informado para licença maternidade iniciada a partir de 01/12/1999 e com benefícios
      requeridos até 31/08/2003. Não pode ser informado para competências anteriores a 10/1998. Não pode ser informado para as competências 01/2001 a 08/2003.
      Sempre que não informado preencher com zeros. }
    FReceitaEventoDesportivoPatrocinio: Double; { 15 v - (Informar o valor total da receita bruta de espetáculos desportivos em qualquer modalidade,
      realizado com qualquer associação desportiva que mantenha equipe de futebol profissional ou valor total pago a título de patrocínio, licenciamento
      de marcas e símbolos, publicidade, propaganda e transmissão de espetáculos celebrados com essas associações desportivas)
      Campo opcional para código de recolhimento 115 Campo opcional para os códigos de recolhimento 150 e 155, quando o CNPJ da empresa for igual ao CNPJ do tomador.
      Não pode ser informado para os códigos de recolhimento 130, 135, 145, 211, 307, 317, 327, 337,345, 608, 640, 650, 660 e para empregador doméstico (FPAS 868).
      Não pode ser informado para a competência 13. Sempre que não informado preencher com zeros. }
    FIndicativoOrigemReceita: String; { 1 AN - (Indicar a origem da receita de evento desportivo/patrocínio). Deve ser preenchido se o valor da Receita de Evento Desportivo/Patrocínio for informada. Se
      informado, só pode ser: “E” (receita referente a arrecadação de eventos); “P” (receita referente a patrocínio); “A” (receita referente à arrecadação de eventos e patrocínio).
      Sempre que o campo for “P” será gerada automaticamente a GPS com código de pagamento 2500. Não pode ser informado para a competência 13.
      Sempre que não informado o campo deve ficar em branco. }
    FComercializacaoProducaoPessoaFisica: Double; { 15 V - (Informar o valor da comercialização da produção no mês de competência, realizada com produtor rural pessoa física)
      Campo opcional para código de recolhimento 115. Campo opcional para os códigos de recolhimento 150 e 155, quando o CNPJ da empresa for igual ao CNPJ do tomador.
      Não pode ser informado para os códigos de recolhimento 130, 135, 145, 211, 307, 317, 327, 337,345, 608, 640, 650, 660 e para empregador doméstico (FPAS 868).
      Não pode ser informado quando FPAS for 604 e código de recolhimento 150, em competências posteriores a 10/2001.
      Não pode ser informado para a competência 13. Sempre que informado, será gerada GPS com os códigos de pagamento 2607, 2704 ou 2437,conforme o caso.
      Não pode ser informado para competência anterior a OUT de 1998. Sempre que não informado preencher com zeros. }
    FComercializacaoProducaoPessoaJuridica: Double; { 15 V - (Informar o valor da comercialização da produção realizada no mês de competência por produtor pessoa jurídica)
      Campo opcional para os códigos de recolhimento 115. Campo opcional para os códigos de recolhimento 150 e 155, quando o CNPJ da empresa for igual ao CNPJ do tomador.
      Não pode ser informado para os códigos de recolhimento 130, 135,145, 211, 307, 317, 327, 337,345, 608, 640, 650, 660 e para empregador doméstico (FPAS 868).
      Não pode ser informado quando FPAS for 604 e código de recolhimento for 150, em competências posteriores a 10/2001.
      Não pode ser informado para a competência 13. Não pode ser informado para empresa optante pelo SIMPLES. Sempre que informado,
      será gerada GPS com os códigos de pagamento 2607 ou 2704, conforme o caso. Não pode ser informado para competência anterior a 10/1998.
      Sempre que não informado preencher com zeros. }
    FOutrasInformacoesProcesso: String; { 11 N - Campo obrigatório para os códigos de recolhimento 650 e 660.  Não pode ser informado para os demais códigos.
      Sempre que não informado o campo deve ficar em branco. }
    FOutrasInformacoesProcessoAno: String; { 4 N - Formato AAAA. Campo obrigatório para o código de recolhimento 650 e 660. Não pode ser informado para os demais códigos.
      Sempre que não informado o campo deve ficar em branco. }
    FOutrasInformacoesVaraJCJ: String; { 5 N - Campo obrigatório para os códigos de recolhimento 650 e 660 .  Não pode ser informado para os demais códigos.
      Sempre que não informado o campo deve ficar em branco. }
    FOutrasInformacoesPeriodoInicio: TDateTime; { 6 D - Formato AAAAMM. Campo obrigatório para os códigos de recolhimento 650 e 660. Não pode ser informado para os demais códigos.
      Sempre que não informado o campo deve ficar em branco. }
    FOutrasInformacoesPeriodoFim: TDateTime; { 6 D - Formato AAAAMM.  Campo obrigatório, para os códigos de recolhimento 650 e 660. Período Fim deve ser posterior ou igual ao Período Início.
      Não pode ser informado para os demais códigos. Sempre que não informado o campo deve ficar em branco. }
    FCompensacaoValorCorrigido: Double; { 15 V - (Informar o valor corrigido, recolhido indevidamente ou a maior em competências anteriores e que a empresa deseja
      compensar na atual GPS - Guia da Previdência Social). Campo opcional para códigos de recolhimento 115 e 650. Não pode ser informado para os códigos de recolhimento 145, 211, 307, 327, 345, 640 e 660.
      Só deve ser informado se Indicador de Recolhimento da Previdência Social (campo 20 do registro 00) for igual a 1 (GPS no prazo).
      Não pode ser informado para competência anterior a outubro de 1998. Sempre que não informado preencher com zeros. }
    FCompensacaoPeriodoInicio: TDateTime; { 6 D - (Para informação AAAAMM de início das competências recolhidas indevidamente ou a maior) Formato AAAAMM.
      Só deve ser informado se o campo “Compensação - Valor Corrigido” for diferente de zero. Não pode ser informado para competência anterior a outubro de 1998.
      Não pode ser informado para os códigos de recolhimento 145, 211, 307, 327, 345, 640 e 660. Opcional para os códigos de recolhimento 115 e 650.
      Deve ser menor ou igual à competência informada. Sempre que não informado o campo deve ficar em branco. }
    FCompensacaoPeriodoFim: TDateTime; { 6 D - (Para informação do AAAAMM final das competências recolhidas indevidamente ou a maior) Formato AAAAMM.
      Só deve ser informado se o campo “Compensação - Valor Corrigido” for diferente de zero. Obrigatório caso o campo “Compensação – Período início” estiver preenchido.
      Período Fim deve ser maior ou igual ao Período Início e menor ou igual que o mês de competência. Não pode ser informado para competência anterior a outubro de 1998.
      Não pode ser informado para os códigos de recolhimento 145, 211, 307, 327, 345, 640 e 660. Opcional para os códigos de recolhimento 115 e 650.
      Sempre que não informado o campo deve ficar em branco. }
    FRecolhimentoCompetenciasAnterioresValorINSSFolhaPagamento: Double; { 15 V - (Informar os valores de contribuições de competências anteriores não recolhidas por não
      terem atingido o valor mínimo estabelecido pela Previdência Social. Neste campo informar o total do campo 6 da GPS) Campo opcional para códigos de recolhimento 115, 211e 650.
      Não pode ser informado para os códigos de recolhimento 145, 307, 327, 345, 640 e 660. Só deve ser informado se
      Indicador de Recolhimento da Previdência Social (campo 20 do registro 00) for igual a 1 (GPS no prazo) ou 2 (GPS em atraso).
      Não pode ser informado para competência anterior a outubro de 1998. Sempre que não informado preencher com zeros. }
    FRecolhimentoCompetenciasAnterioresOutrasEntidadesFolhaPagamento: Double; { 15 V - (Informar os valores de contribuições de competências anteriores não recolhidas por não
      terem atingido o valor mínimo estabelecido pela Previdência Social. Neste campo informar o total do campo 9 da GPS)
      Campo opcional para códigos de recolhimento 115, 211e 650. Não pode ser informado para os códigos de recolhimento 145, 307, 327, 345, 640 e 660.
      Só deve ser informado se Indicador de Recolhimento da Previdência Social (campo 20 do registro 00) for igual a 1 (GPS no prazo) ou 2 (GPS em atraso).
      Não pode ser informado para competência anterior a outubro de 1998. Sempre que não informado preencher com zeros. }
    FRecolhimentoCompetenciasAnterioresComercializacaoProducaoValorINSS: Double; { 15 V - (informação os valores de contribuições de competências anteriores não recolhidas por não
      terem atingido o valor mínimo estabelecido pela Previdência Social. Neste campo informar o total do campo 6 da GPS de códigos de pagamento 2607, 2704 ou 2437).
      Campo opcional para código de recolhimento 115. Campo opcional para os códigos de recolhimento 150 e 155, quando o CNPJ da empresa for igual ao CNPJ do tomador.
      Não pode ser informado para os códigos de recolhimento 130, 135, 145, 211, 307, 317, 327, 337, 345, 608, 640, 650 e 660.
      Não pode ser informado quando o FPAS for 868 (empregador doméstico).
      Só deve ser informado se Indicador de Recolhimento da Previdência Social (campo 20 do registro 00) for igual a 1 (GPS no prazo) ou 2 (GPS em atraso).
      Não pode ser informado na competência 13. Não pode ser informado para competência anterior a outubro de 1998.
      Sempre que não informado preencher com zeros. }
    FRecolhimentoCompetenciasAnterioresComercializacaoProducaoOutrasEntidades: Double; { 15 V -  (Informar os valores de contribuições de competências anteriores não recolhidas por não
      terem atingido o valor mínimo estabelecido pela Previdência Social. Neste campo informar o total do campo 9 da GPS de códigos de pagamento 2607 , 2704 ou 2437).
      Campo opcional para códigos de recolhimento 115. Campo opcional para os códigos de recolhimento 150 e 155, quando o CNPJ da empresa for igual ao CNPJ do tomador.
      Não pode ser informado para os códigos de recolhimento 130, 135, 145, 211, 307, 317, 327, 337,345, 608, 640, 650 e 660.
      Não pode ser informado quando o FPAS for 868 (empregador doméstico).
      Só deve ser informado se Indicador de Recolhimento da Previdência Social (campo 20 do registro 00) for igual a 1 (GPS no prazo) ou 2 (GPS em atraso).
      Não pode ser informado na competência 13. Não pode ser informado para competência anterior a outubro de 1998.
      Sempre que não informado preencher com zeros. }
    FRecolhimentoCompetenciasAnterioresReceitaEventoDesportivoPatrocínioValorINSS: Double; { 15 V -  (Informar os valores de contribuições de competências anteriores não recolhidas por não
      terem atingido o valor mínimo estabelecido pela Previdência Social. Neste campo informar o total do campo 6 da GPS de código de pagamento 2500).
      Campo opcional para código de recolhimento 115. Campo opcional para os códigos de recolhimento 150 e 155, quando o CNPJ da empresa for igual ao CNPJ do tomador.
      Não pode ser informado para os códigos de recolhimento 130, 135, 145, 211, 307, 317, 327, 337,345, 608, 640, 650 e 660. Não deve ser informado quando o FPAS for 868 (empregador doméstico).
      Só deve ser informado se Indicador de Recolhimento da Previdência Social (campo 20 do registro 00) for igual a 1 (GPS no prazo) ou 2 (GPS em atraso).
      Não pode ser informado na competência 13. Não pode ser informado para competência anterior a outubro de 1998.
      Sempre que não informado preencher com.zeros. }
    FParcelamentoFGTSSomatorioRemuneracoesCategorias0102030506: Double; { 15 V -  (Informar o valor total das remunerações das categorias 01,02, 03, 05 e 06)
      Para implementação futura. Campo obrigatório para os códigos de recolhimento 307 e 327. Até autorização da CAIXA preencher com zeros. }
    FParcelamentoFGTSSomatorioRemuneracaoCategorias0407: Double; { 15 V -  (Informar o valor total das remunerações das categorias 04 e 07)
      Para implementação futura. Campo obrigatório para os códigos de recolhimento 307 e 327, quando possuir trabalhador categoria 04 ou 07.
      Até autorização da CAIXA preencher com zeros. }
    FParcelamentoFGTSValorRecolhido: Double; {  15 V -  Informar o valor total recolhido ao FGTS (Depósito + JAM + Multa) Para implementação futura.
      Campo obrigatório para os códigos de recolhimento 307 e 327. Até autorização da CAIXA preencher com zeros. }
    FValoresPagosCooperativasTrabalhoServicosPrestados: Double; {  15 V -  (Informar o montante dos valores brutos das notas fiscais ou faturas de prestação de serviços emitidas
      pelas cooperativas no decorrer do mês, que é base de cálculo da contribuição). Campo opcional para os código de recolhimento 115.
      Campo opcional para os códigos de recolhimento 150 e 155, quando o CNPJ da empresa for igual ao CNPJ do tomador.
      Não pode ser informado para FPAS 604 no código de recolhimento 150, quando competência posterior a 10/2001.
      Não pode ser informado para os códigos de recolhimento 130, 135, 145, 211, 307, 317, 327, 337, 345, 608, 640, 650 e 660.
      Não pode ser informado para competências anteriores a 03/2000. Não pode ser informado na competência 13.
      Não pode ser informado para os códigos de recolhimento 150 e 155 quando for exclusivo de retenção.
      Não pode ser informado para o código de recolhimento 115 quando for exclusivo de Receita de Comercialização de Produção/Patrocínio e Eventos desportivo.
      Não pode ser informado se FPAS da empresa for igual a 868 (empregador doméstico).
      Sempre que não informado preencher com zeros. }

    /// Implementação futura  45 V - Para implementação futura. Até autorização da CAIXA, preencher com zeros.
    /// Brancos 6 AN - Preencher com brancos.
    /// Final de Linha  1 AN - Deve ser uma constante “*” para marcar fim de linha.

    FRegistroValido: Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read FRegistroValido write FRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property TipoInscricaoEmpresa: String read FTipoInscricaoEmpresa write FTipoInscricaoEmpresa;
    property InscricaoEmpresa: String read FInscricaoEmpresa write FInscricaoEmpresa;
    /// Zeros. Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    property Deducao13SalarioLicencaMaternidade: Double read FDeducao13SalarioLicencaMaternidade write FDeducao13SalarioLicencaMaternidade;
    property ReceitaEventoDesportivoPatrocinio: Double read FReceitaEventoDesportivoPatrocinio write FReceitaEventoDesportivoPatrocinio;
    property IndicativoOrigemReceita: String read FIndicativoOrigemReceita write FIndicativoOrigemReceita;
    property ComercializacaoProducaoPessoaFisica: Double read FComercializacaoProducaoPessoaFisica write FComercializacaoProducaoPessoaFisica;
    property ComercializacaoProducaoPessoaJuridica: Double read FComercializacaoProducaoPessoaJuridica write FComercializacaoProducaoPessoaJuridica;
    property OutrasInformacoesProcesso: String read FOutrasInformacoesProcesso write FOutrasInformacoesProcesso;
    property OutrasInformacoesProcessoAno: String read FOutrasInformacoesProcessoAno write FOutrasInformacoesProcessoAno;
    property OutrasInformacoesVaraJCJ: String read FOutrasInformacoesVaraJCJ write FOutrasInformacoesVaraJCJ;
    property OutrasInformacoesPeriodoInicio: TDateTime read FOutrasInformacoesPeriodoInicio write FOutrasInformacoesPeriodoInicio;
    property OutrasInformacoesPeriodoFim: TDateTime read FOutrasInformacoesPeriodoFim write FOutrasInformacoesPeriodoFim;
    property CompensacaoValorCorrigido: Double read FCompensacaoValorCorrigido write FCompensacaoValorCorrigido;
    property CompensacaoPeriodoInicio: TDateTime read FCompensacaoPeriodoInicio write FCompensacaoPeriodoInicio;
    property CompensacaoPeriodoFim: TDateTime read FCompensacaoPeriodoFim write FCompensacaoPeriodoFim;
    property RecolhimentoCompetenciasAnterioresValorINSSFolhaPagamento: Double read FRecolhimentoCompetenciasAnterioresValorINSSFolhaPagamento write FRecolhimentoCompetenciasAnterioresValorINSSFolhaPagamento;
    property RecolhimentoCompetenciasAnterioresOutrasEntidadesFolhaPagamento: Double read FRecolhimentoCompetenciasAnterioresOutrasEntidadesFolhaPagamento write FRecolhimentoCompetenciasAnterioresOutrasEntidadesFolhaPagamento;
    property RecolhimentoCompetenciasAnterioresComercializacaoProducaoValorINSS: Double read FRecolhimentoCompetenciasAnterioresComercializacaoProducaoValorINSS write FRecolhimentoCompetenciasAnterioresComercializacaoProducaoValorINSS;
    property RecolhimentoCompetenciasAnterioresComercializacaoProducaoOutrasEntidades: Double read FRecolhimentoCompetenciasAnterioresComercializacaoProducaoOutrasEntidades write FRecolhimentoCompetenciasAnterioresComercializacaoProducaoOutrasEntidades;
    property RecolhimentoCompetenciasAnterioresReceitaEventoDesportivoPatrocínioValorINSS: Double read FRecolhimentoCompetenciasAnterioresReceitaEventoDesportivoPatrocínioValorINSS write FRecolhimentoCompetenciasAnterioresReceitaEventoDesportivoPatrocínioValorINSS;
    property ParcelamentoFGTSSomatorioRemuneracoesCategorias0102030506: Double read FParcelamentoFGTSSomatorioRemuneracoesCategorias0102030506 write FParcelamentoFGTSSomatorioRemuneracoesCategorias0102030506;
    property ParcelamentoFGTSSomatorioRemuneracaoCategorias0407: Double read FParcelamentoFGTSSomatorioRemuneracaoCategorias0407 write FParcelamentoFGTSSomatorioRemuneracaoCategorias0407;
    property ParcelamentoFGTSValorRecolhido: Double read FParcelamentoFGTSValorRecolhido write FParcelamentoFGTSValorRecolhido;
    property ValoresPagosCooperativasTrabalhoServicosPrestados: Double read FValoresPagosCooperativasTrabalhoServicosPrestados write FValoresPagosCooperativasTrabalhoServicosPrestados;
    /// Implementação futura Para implementação futura. Até autorização da CAIXA, preencher com zeros.
    /// Brancos Preencher com brancos.
    /// Final de Linha Deve ser uma constante “*” para marcar fim de linha.
  end;

  // Registro Tipo 12 - Lista
  TRegistroTipo12List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipo12;
    procedure SetItem(Index: Integer; const Value: TRegistroTipo12);
  public
    function New: TRegistroTipo12;
    property Items[Index: Integer]: TRegistroTipo12 read GetItem write SetItem;
  end;

  // REGISTRO TIPO 13 – Alteração Cadastral Trabalhador
  { Não pode ser informado para a competência 13.
    Não serão acatadas 03 ou mais alterações cadastrais para o mesmo trabalhador em campos sensíveis: Nome, CTPS, PIS e Data de Admissão.
    Deve existir somente 01 registro 13 por trabalhador (PIS + Data de Admissão + Categoria + Empresa) por código de alteração cadastral.
    Não pode ser informado para as categorias 11, 12, 13, 14, 15, 16, 17 , 18, 19, 20, 21, 22, 23, 24 , 25 e 26.
    Não pode ser informado para os códigos de recolhimento 130, 135, 150, 155, 317, 337, 608, se houver somente alteração cadastral no arquivo. }

  TRegistroTipo13 = class
  private
    FTipoRegistro: String; //  2 N -  Campo obrigatório. Sempre “13”.
    FTipoInscricao: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI).
    FInscricaoEmpresa: String; { 14 N - Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido. Se Tipo Inscrição = 2,
      então número esperado CEI válido. }
    /// Zeros 36 N -  Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    FPISPASEPCI: String; // 11 N - Campo obrigatório. O número informado deve ser válido.
    FDataAdmissao: TDateTime; { 8 D - Formato DDMMAAAA. Deve ser informado para as categorias de trabalhadores 01, 03, 04, 05, 06 e 07. Deve conter uma data válida.
      Não pode ser informado para a categoria 02. Deve ser menor ou igual a competência informada. Deve ser maior ou igual a 22/01/1998 para a categoria de trabalhador 04.
      Deve ser maior ou igual a 20/12/2000 para a categoria de trabalhador 07. }
    FCategoriaTrabalhador: String; // 2 N - (Código deve estar contido na tabela categoria do trabalhador). Campo obrigatório. Acatar somente as categorias 01, 02, 03, 04, 05, 06 e 07.
    FMatriculaTrabalhador: String; { 11 N - Número de matrícula atribuído pela empresa ao trabalhador, quando houver. Não pode ser informado para a categoria 06.
      Sempre que não informado o campo deve ficar em branco. }
    FNumeroCTPS: String; { 7 N - Obrigatório para as categorias de trabalhadores 01, 03, 04, 06 e 07. Opcional para a categoria de trabalhador 02.
      Não pode ser informado para a categoria 05. Sempre que não informado o campo deve ficar em branco. }
    FSerieCTPS: String; { 5 N - Obrigatório para as categorias de trabalhadores 01, 03, 04, 06 e 07. Opcional para a categoria de trabalhador 02.
      Não pode ser informado para a categoria 05. Sempre que não informado o campo deve ficar em branco. }
    FNomeTrabalhador: String; { 70 A - Campo obrigatório. Não pode conter número. Não pode conter caracteres especiais. Não pode haver caracteres acentuados. Não é permitido mais de um espaço entre os nomes.
      Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco. Pode conter apenas caracteres de A a Z. }
    FCodigoEmpresaCaixa: String; { 14 N - Campo opcional. Se informado deverá ser válido, fornecido pela CAIXA, e pertencer à empresa em questão.
      Se informado o campo 13 (registro 13) deve ser preenchido. Sempre que não informado o campo deve ficar em branco. }
    FCodigoTrabalhadorCaixa: String; { 11 N - Campo opcional. Se informado deverá ser válido, fornecido pela CAIXA, e pertencer ao empregado em questão.
      Sempre que não informado o campo deve ficar em branco. }
    FCodigoAlteracaoCadastral: String; // 3 N - Campo obrigatório. Deve estar contido na tabela de tipos de alteração do trabalhador.
    FNovoConteudoCampo: String; // 70 AN - Campo obrigatório. Critica conforme as regras estabelecidas para os campos alterados.
    /// Brancos  94 AN - Preencher com brancos.
    /// Final de Linha 1 AN - Deve ser uma constante “*” para marcar fim de linha.

    FRegistroValido: Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read FRegistroValido write FRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property TipoInscricao: String read FTipoInscricao write FTipoInscricao;
    property InscricaoEmpresa: String read FInscricaoEmpresa write FInscricaoEmpresa;
    /// Zeros. Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    property PISPASEPCI: String read FPISPASEPCI write FPISPASEPCI;
    property DataAdmissao: TDateTime read FDataAdmissao write FDataAdmissao;
    property CategoriaTrabalhador: String read FCategoriaTrabalhador write FCategoriaTrabalhador;
    property MatriculaTrabalhador: String read FMatriculaTrabalhador write FMatriculaTrabalhador;
    property NumeroCTPS: String read FNumeroCTPS write FNumeroCTPS;
    property SerieCTPS: String read FSerieCTPS write FSerieCTPS;
    property NomeTrabalhador: String read FNomeTrabalhador write FNomeTrabalhador;
    property CodigoEmpresaCaixa: String read FCodigoEmpresaCaixa write FCodigoEmpresaCaixa;
    property CodigoTrabalhadorCaixa: String read FCodigoTrabalhadorCaixa write FCodigoTrabalhadorCaixa;
    property CodigoAlteracaoCadastral: String read FCodigoAlteracaoCadastral write FCodigoAlteracaoCadastral;
    property NovoConteudoCampo: String read FNovoConteudoCampo write FNovoConteudoCampo;
    /// Brancos Preencher com brancos.
    /// Final de Linha Deve ser uma constante “*” para marcar fim de linha.

  end;

  // REGISTRO TIPO 13  - Lista
  TRegistroTipo13List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipo13;
    procedure SetItem(Index: Integer; const Value: TRegistroTipo13);
  public
    function New: TRegistroTipo13;
    property Items[Index: Integer]: TRegistroTipo13 read GetItem write SetItem;
  end;

  // REGISTRO TIPO 14 – Inclusão/Alteração Endereço do Trabalhador
  { Categorias permitidas: 01, 02, 03, 04, 05, 06 e 07.
   Para as demais categorias não há registro tipo 14.
   Não pode ser informado para a competência 13.
   Só deve existir um registro tipo 14 por trabalhador (PIS + Data de Admissão + Categoria + Empresa).
   Não pode ser informado para os códigos de recolhimento 130, 135, 150, 155, 317, 337 e 608, se houver somente informação de endereço no arquivo.}

  TRegistroTipo14 = class
  private
    FTipoRegistro: String; // 2 N -  Campo obrigatório. Sempre “14”.
    FTipoInscricaoEmpresa: String;  // 1 N - Campo obrigatório. Código informado só pode ser 1 (CNPJ) ou 2 (CEI).
    FInscricaoEmpresa: String; { 14 N - Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido.
      Se Tipo Inscrição = 2, então número esperado CEI válido. A inscrição esperada deve ser igual a do registro 10 imediatamente anterior. }
    /// Zeros 36 N - Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    FPISPASEPCI: String; // 11 N - Campo obrigatório. O número informado deve ser válido.
    FDataAdmissao: TDateTime; { 8 D - Formato DDMMAAAA. Campo obrigatório para as categorias de trabalhadores 01, 03, 04, 05, 06, 07. Deve conter uma data válida.
      Deve ser maior ou igual a 22/01/1998 para a categoria de trabalhador 04. Deve ser maior ou igual a 20/12/2000 para a categoria de trabalhador 07.
      Não pode ser informado para categoria 02. Deve ser menor ou igual a competência informada.
      Sempre que não informado o campo deve ficar em branco. }
    FCategoriaTrabalhador: String; // 2 N - (Código deve estar contido na tabela categoria do trabalhador). Campo obrigatório para as categorias de trabalhadores 01, 02, 03, 04, 05, 06 e 07.
    FNomeTrabalhador: String; { 70 A - Campo obrigatório. Não pode conter número. Não pode conter caracteres especiais. Não pode haver caracteres acentuados. Não é permitido mais de um espaço entre os nomes.
      Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco. Pode conter apenas caracteres de A a Z. }
    FNumeroCTPS: String; { 7 N - Obrigatório para as categorias de trabalhadores 01, 03, 04, 06 e 07. Opcional para a categoria de trabalhador 02.
      Não pode ser informado para a categoria 05. Sempre que não informado o campo deve ficar em branco. }
    FSerieCTPS: String; { 5 N - Obrigatório para as categorias de trabalhadores 01, 03, 04, 06 e 07. Opcional para a categoria de trabalhador 02.
      Não pode ser informado para a categoria 05. Sempre que não informado o campo deve ficar em branco. }
    FLogradouro: String; { 50 AN - Rua, nº, andar,apartamento. Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FBairro: String; { 20 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FCep: String; // 8 N - Campo obrigatório. Número de CEP válido. Permitido apenas, números diferentes de 20000000, 30000000, 70000000 ou 80000000.
    FCidade: String; { 20 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FUnidadeFederacao: String; // 2 A - Campo obrigatório. Deve constar da tabela de unidades da federação
    /// Brancos 103 AN - Preencher com brancos.
    /// Final de Linha  1 AN - Deve ser uma constante “*” para marcar fim de linha.

    FRegistroValido: Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read FRegistroValido write FRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property TipoInscricaoEmpresa: String read FTipoInscricaoEmpresa write FTipoInscricaoEmpresa;
    property InscricaoEmpresa: String read FInscricaoEmpresa write FInscricaoEmpresa;
    /// Zeros. Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    property PISPASEPCI: String read FPISPASEPCI write FPISPASEPCI;
    property DataAdmissao: TDateTime read FDataAdmissao write FDataAdmissao;
    property CategoriaTrabalhador: String read FCategoriaTrabalhador write FCategoriaTrabalhador;
    property NomeTrabalhador: String read FNomeTrabalhador write FNomeTrabalhador;
    property NumeroCTPS: String read FNumeroCTPS write FNumeroCTPS;
    property SerieCTPS: String read FSerieCTPS write FSerieCTPS;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Bairro: String read FBairro write FBairro;
    property Cep: String read FCep write FCep;
    property Cidade: String read FCidade write FCidade;
    property UnidadeFederacao: String read FUnidadeFederacao write FUnidadeFederacao;
    /// Brancos Preencher com brancos.
    /// Final de Linha Deve ser uma constante “*” para marcar fim de linha.
  end;

  // REGISTRO TIPO 14  - Lista
  TRegistroTipo14List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipo14;
    procedure SetItem(Index: Integer; const Value: TRegistroTipo14);
  public
    function New: TRegistroTipo14;
    property Items[Index: Integer]: TRegistroTipo14 read GetItem write SetItem;
  end;

  // REGISTRO TIPO 20 – Registro do Tomador de Serviço/Obra de Construção Civil
  { Obrigatório para os códigos de recolhimento:130, 135, 150, 155 , 211, 317, 337, 608.
   Para o código de recolhimento 608 só deve existir um tomador}

  TRegistroTipo20 = class
  private
    FTipoRegistro: String; //  2 N -  Campo obrigatório. Sempre “20”.
    FTipoInscricaoEmpresa: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI).
    FInscricaoEmpresa: String; { 14 N -  Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido.Se Tipo Inscrição = 2,
      então número esperado CEI válido. A inscrição da empresa deve ser a mesma do registro 10, imediatamente anterior. }
    FTipoInscricaoTomadorObraConstCivil: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI).
    FInscricaoTomadorObraConstCivil: String; { 14 N - (Destinado à informação da inscrição da empresa tomadora de serviço nos recolhimentos de
      trabalhadores avulsos, prestação de serviços, obra de construção civil e dirigente sindical).
      Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido. Se Tipo Inscrição = 2, então número esperado CEI válido. }
    // Zeros 21 AN - Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    FNomeTomadorObraConstCivil: String; { 40 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos.
      A primeira posição não pode ser branco. Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FLogradouro: String; { 50 AN - Rua, nº, andar,apartamento. Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FBairro: String; { 20 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FCep: String; // 8 N - Campo obrigatório. Número de CEP válido. Permitido apenas, números diferentes de 20000000, 30000000, 70000000 ou 80000000.
    FCidade: String; { 20 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FUnidadeFederacao: String; // 2 A - Campo obrigatório. Deve constar da tabela de unidades da federação
    FCodigoPagamentoGPS: String; { 4 N - (Informar o código de pagamento da GPS, conforme tabela divulgada pelo INSS.)
      Campo obrigatório para competência maior ou igual a 10/1998. Acatar apenas para os códigos de recolhimento130, 135, 155 e 608.
      Não pode ser informado para os códigos de recolhimento 211, 317e 337. Sempre que não informado o campo deve ficar em branco. }
    FSalarioFamilia: Double; { 15 V - (Indicar o total pago pela empresa a título de salário família. O valor informado será deduzido na GPS.)
      Campo opcional. Não pode ser informado para competência anterior a outubro de 1998. Não pode ser informado para a competência 13.
      Não pode ser informado quando o FPAS for 868 (empregador doméstico). Só pode ser informado para os códigos de recolhimento 150, 155 e 608.
      Não pode ser informado para os códigos de recolhimento 130, 135, 211, 317 e 337. Sempre que não informado preencher com zeros. }
    FContribDescEmpregadoReferentecompetencia13: Double;{ 15 V - (Informar o valor total da contribuição descontada dos segurados na competência 13.)
      Não deverá ser informado. Preencher com zeros. }
    FIndicadorValorNegativoPositivo: Double; { 15 V - (Para indicar se o valor devido à Previdência Social - campo 17 - é (0) positivo) ou (1) negativo.)
      Não deverá ser informado· Preencher com zero. }
    FValorDevidoPrevidenciaSocialReferenteCompetencia13: Double; { 15 V - (Informar o valor total devido à Previdência Social, na competência 13.)
      Não deverá ser informado. Preencher com zeros. }
    FValorRetencaoLei971198: Double; { 15 V - (informar o valor correspondente ao montante das retenções (Lei n° 9.711/98) ocorridas durante o mês,
      incluindo o acréscimo de 2%, 3% ou 4%, correspondente aos serviços prestados em condições que permitam a concessão de aposentadoria
      especial (art. 6° da Lei n° 10.666, de 08/05/2003). O valor informado será deduzido na GPS.)
      Campo opcional para os códigos de recolhimento 150 e 155. Só deve ser informado para competência maior ou igual a 02/1999.
      Não pode ser informado para o código 155 quando for recolhimento de pessoal administrativo. Não pode ser informado para empresa de FPAS 604
      no recolhimento 150 em competências posteriores a outubro de 2001. Não pode ser informado para os demais códigos de recolhimento.
      Sempre que não informado preencher com zeros. }
    FValorFaturasEmitidasTomador: Double; { 15 V - (Informar o montante dos valores brutos das notas fiscais ou faturas de prestação de serviços emitidas
      a cada contratante no decorrer do mês, em razão da contribuição instituída pelo art. 22, inciso IV, da Lei n° 8.212/91, com a redação
      dada pela Lei n° 9.876/99). Campo obrigatório para o código de recolhimento 211. Não pode ser informado para os demais códigos de recolhimento.
      Não pode ser informado para competências anteriores a 03/2000. Sempre que não informado preencher com zeros. }
    /// Zeros 45 V - Para implementação futura. Até autorização da CAIXA preencher com zeros.
    /// Brancos  42 AN - Campo obrigatório. Preencher com brancos.
    /// Final de Linha 1 AN - Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

    FRegistroValido: boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read fRegistroValido write fRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property TipoInscricaoEmpresa: String read FTipoInscricaoEmpresa write FTipoInscricaoEmpresa;
    property InscricaoEmpresa: String read FInscricaoEmpresa write FInscricaoEmpresa;
    /// Zeros. Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    property TipoInscricaoTomadorObraConstCivil: String read FTipoInscricaoTomadorObraConstCivil write FTipoInscricaoTomadorObraConstCivil;
    property InscricaoTomadorObraConstCivil: String read FInscricaoTomadorObraConstCivil write FInscricaoTomadorObraConstCivil;
    property NomeTomadorObraConstCivil: String read FNomeTomadorObraConstCivil write FNomeTomadorObraConstCivil;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Bairro: String read FBairro write FBairro;
    property Cep: String read FCep write FCep;
    property Cidade: String read FCidade write FCidade;
    property UnidadeFederacao: String read FUnidadeFederacao write FUnidadeFederacao;
    property CodigoPagamentoGPS: String read FCodigoPagamentoGPS write FCodigoPagamentoGPS;
    property SalarioFamilia: Double read FSalarioFamilia write FSalarioFamilia;
    property ContribDescEmpregadoReferentecompetencia13: Double read FContribDescEmpregadoReferentecompetencia13 write FContribDescEmpregadoReferentecompetencia13;
    property IndicadorValorNegativoPositivo: Double read FIndicadorValorNegativoPositivo write FIndicadorValorNegativoPositivo;
    property ValorDevidoPrevidenciaSocialReferenteCompetencia13: Double read FValorDevidoPrevidenciaSocialReferenteCompetencia13 write FValorDevidoPrevidenciaSocialReferenteCompetencia13;
    property ValorRetencaoLei971198: Double read FValorRetencaoLei971198 write FValorRetencaoLei971198;
    property ValorFaturasEmitidasTomador: Double read FValorFaturasEmitidasTomador write FValorFaturasEmitidasTomador;
    /// Zeros Para implementação futura. Até autorização da CAIXA preencher com zeros.
    /// Brancos Campo obrigatório. Preencher com brancos.
    /// Final de Linha. Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

  end;

  // REGISTRO TIPO 20 – Lista
  TRegistroTipo20List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipo20;
    procedure SetItem(Index: Integer; const Value: TRegistroTipo20);
  public
    function New: TRegistroTipo20;
    property Items[Index: Integer]: TRegistroTipo20 read GetItem write SetItem;
  end;


  // REGISTRO TIPO 21 - Registro de informações adicionais do Tomador de Serviço/Obra de Const. Civil
  // Opcional para os códigos de recolhimento:130, 135, 150, 155, 211, 317, 337 e 608.

  TRegistroTipo21 = class
  private
    FTipoRegistro: String; //  2 N - Campo obrigatório. Sempre “21”.
    FTipoInscricaoEmpresa: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI).
    FInscricaoEmpresa: String; { 14 N - Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido. Se Tipo Inscrição = 2, então número esperado CEI válido.
      A inscrição da empresa deve ser a mesma do registro 10, imediatamente anterior. }
    FTipoInscricaoTomadorObraConstCivil: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI).
    FInscricaoTomadorObraConstCivil: String; { 14 N - (Destinado à informação da inscrição da empresa tomadora de serviço nos recolhimentos de
      trabalhadores avulsos, prestação de serviços, obra de construção civil e dirigente sindical).
      Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido. Se Tipo Inscrição = 2, então número esperado CEI válido. }
    // Zeros 21 N - Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    FCompensacaoValorCorrigido: Double; { 15 V - (Informar o valor corrigido a compensar , na hipótese de pagamento ou recolhimento indevido ao INSS em competências anteriores e que a
      empresa deseja compensar na atual GPS - Guia de Recolhimento da Previdência Social ). 54 68 15 V · Campo opcional para os códigos de recolhimento 130, 135, 150, 155, 211 e 608.
      Não pode ser informado para os código de recolhimento 317 e 337. Não pode ser informado na competência 13. Só deve ser informado se o Indicador de Recolhimento
      da Previdência Social (campo 20 do registro 00) for igual a 1 (GPS no prazo). Não pode ser informado para competência anterior a outubro de 1998.
      Sempre que não informado preencher com zeros. }
    FCompensacaoPeriodoInicio: TDateTime; { 6 D -(Para informação AAAAMM de início das competências recolhidas indevidamente ou a maior). Formato AAAAMM.
      Não pode ser informado na competência 13. Só deve ser informado se o campo “Compensação - Valor Corrigido” for diferente de zero.
      Não pode ser informado para competência anterior a outubro de 1998. Não pode ser informado para os códigos de recolhimento 317 e 337.
      Opcional para os códigos de recolhimento 130, 135, 150, 155, 211 e 608. Deve ser menor ou igual à competência informada.
      Sempre que não informado o campo deve ficar em branco.  }
    FCompensacaoPeriodoFim: TDateTime; { 6 D - (Para informação do AAAAMM final das competências recolhidas indevidamente ou a maior). Formato AAAAMM.
      Só deve ser informado se o campo “Compensação - Valor Corrigido” for diferente de zero.
      Obrigatório caso o campo “Compensação – Período início” estiver preenchido. Deve ser posterior ou igual ao período início da compensação
      Período Fim deve ser maior ou igual ao Período Início e menor ou igual que o mês de competência. Não pode ser informado para competência 13.
      Não pode ser informado para competência anterior a outubro de 1998. Não pode ser informado para os códigos de recolhimento 317 e 337.
      Opcional para os códigos de recolhimento 130, 135, 150, 155, 211 e 608. Sempre que não informado o campo deve ficar em branco. }
    FRecolhimentoCompetenciasAnterioresValorINSSFolhaPagamento: Double; { 15 V - (Informar os valores de contribuições de competências anteriores não recolhidas por não
      terem atingido o valor mínimo estabelecido pela Previdência Social.Neste campo informar o total do campo 6 da GPS.)
      Campo opcional para os códigos de recolhimento 130, 135, 150, 155 e 608. Não pode ser informado para código de recolhimento 211, 317 e 337.
      Só deve ser informado quando o Indicador de Recolhimento da Previdência Social(campo 20 do registro 00) for igual a 1 (GPS no prazo) ou 2 (GPS em atraso).
      Sempre que não informado preencher com zeros. }
    FRecolhimentoCompetenciasAnterioresOutrasEntidadesFolhaPagamento: Double; { 15 V - (Informar os valores de contribuições de competências anteriores não recolhidas por não
      terem atingido o valor mínimo estabelecido pela Previdência Social. Neste campo informar o total do campo 9 da GPS.)
      Campo opcional para os códigos de recolhimento 130, 135, 150, 155 e 608. Não pode ser informado para código de recolhimento 211, 317 e 337.
      Só deve ser informado quando o Indicador de Recolhimento da Previdência Social(campo 20 do registro 00) for igual a 1 (GPS no prazo) ou 2 (GPS em atraso).
      Sempre que não informado preencher com zeros. }
    FParcelamentoFGTSSomatorioRemuneracoesCategorias0102030506: Double; { 15 V - Para implementação futura. Campo obrigatório para os códigos de recolhimento 317 e 337.
      Até autorização da CAIXA preencher com zeros. }
    FParcelamentoFGTSSomatorioRemuneracoesCategorias0407: Double; { 15 V - Para implementação futura. Campo obrigatório para os códigos de recolhimento 317 e 337.
      Até autorização da CAIXA preencher com zeros. }
    FParcelamentoFGTSValorRecolhido: Double; { 15 V -  Para implementação futura. Campo obrigatório para os códigos de recolhimento 317 e 337.
      Até autorização da CAIXA preencher com zeros. }
    /// Brancos 204 AN - Campo obrigatório. Preencher com brancos.
    /// Final de Linha 1 AN - Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

    FRegistroValido: boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read fRegistroValido write fRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property TipoInscricaoEmpresa: String read FTipoInscricaoEmpresa write FTipoInscricaoEmpresa;
    property InscricaoEmpresa: String read FInscricaoEmpresa write FInscricaoEmpresa;
    property TipoInscricaoTomadorObraConstCivil: String read FTipoInscricaoTomadorObraConstCivil write FTipoInscricaoTomadorObraConstCivil;
    property InscricaoTomadorObraConstCivil: String read FInscricaoTomadorObraConstCivil write FInscricaoTomadorObraConstCivil;
    /// Zeros. Campo obrigatório. Preencher com zeros. Tratar dele no momento de gerar o registro.
    property CompensacaoValorCorrigido: Double read FCompensacaoValorCorrigido write FCompensacaoValorCorrigido;
    property CompensacaoPeriodoInicio: TDateTime read FCompensacaoPeriodoInicio write FCompensacaoPeriodoInicio;
    property CompensacaoPeriodoFim: TDateTime read FCompensacaoPeriodoFim write FCompensacaoPeriodoFim;
    property RecolhimentoCompetenciasAnterioresValorINSSFolhaPagamento: Double read FRecolhimentoCompetenciasAnterioresValorINSSFolhaPagamento write FRecolhimentoCompetenciasAnterioresValorINSSFolhaPagamento;
    property RecolhimentoCompetenciasAnterioresOutrasEntidadesFolhaPagamento: Double read FRecolhimentoCompetenciasAnterioresOutrasEntidadesFolhaPagamento write FRecolhimentoCompetenciasAnterioresOutrasEntidadesFolhaPagamento;
    property ParcelamentoFGTSSomatorioRemuneracoesCategorias0102030506: Double read FParcelamentoFGTSSomatorioRemuneracoesCategorias0102030506 write FParcelamentoFGTSSomatorioRemuneracoesCategorias0102030506;
    property ParcelamentoFGTSSomatorioRemuneracoesCategorias0407: Double read FParcelamentoFGTSSomatorioRemuneracoesCategorias0407 write FParcelamentoFGTSSomatorioRemuneracoesCategorias0407;
    property ParcelamentoFGTSValorRecolhido: Double read FParcelamentoFGTSValorRecolhido write FParcelamentoFGTSValorRecolhido;
    /// Brancos Campo obrigatório. Preencher com brancos.
    /// Final de Linha. Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

  end;

  // REGISTRO TIPO 21 - Lista
  TRegistroTipo21List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipo21;
    procedure SetItem(Index: Integer; const Value: TRegistroTipo21);
  public
    function New: TRegistroTipo21;
    property Items[Index: Integer]: TRegistroTipo21 read GetItem write SetItem;
  end;

  // REGISTRO TIPO 30 - Registro do Trabalhador
  { Acatar categoria 14 e 16 apenas para competências anteriores a 03/2000.
   Acatar categoria 17, 18, 24 e 25 apenas para código de recolhimento 211.
   Acatar categoria 06 apenas para competência maior ou igual a 03/2000.
   Acatar categoria 07 apenas para competência maior ou igual a 12/2000.}

  TRegistroTipo30 = class
  private
    FTipoRegistro: String; // 2 N -  Campo obrigatório. Sempre “30”.
    FTipoInscricaoEmpresa: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI).
    FInscricaoEmpresa: String; { 14 N - Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido.
      Se Tipo Inscrição = 2, então número esperado CEI válido. }
    FTipoInscricaoTomadorObraConstCivil: String; { 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI). Obrigatório para os códigos de recolhimento 130, 135, 211, 150, 155, 317, 337 e 608.
      Sempre que não informado, campo deve ficar em branco. }
    FInscricaoTomadorObraConstCivil: String; { 14 N - (Destinado à informação da inscrição da empresa tomadora de serviço nos recolhimentos de trabalhadores avulsos, prestação
      de serviços, obra de construção civil e dirigente sindical). Campo obrigatório. Obrigatório para os códigos de recolhimento 130, 135, 150, 155, 211, 317, 337 e 608.
      Se Tipo Inscrição = 1, então número esperado CNPJ válido. Se Tipo Inscrição = 2, então número esperado CEI válido.
      Sempre que não informado, campo deve ficar em branco. }
    FPISPASEPCI: String; // 11 N - Campo obrigatório. O número informado deve ser válido.
    FDataAdmissao: TDateTime; { 8 D - Formato DDMMAAAA. Obrigatório para as categorias de trabalhadores 01, 03, 04, 05, 06, 07, 11, 12, 19, 20, 21 e 26.
      Deve conter uma data válida. Não pode ser informado para as demais categorias. Deve ser menor ou igual a competência informada.
      Deve ser maior ou igual a 22/01/1998 para a categoria de trabalhador 04. Deve ser maior ou igual a 20/12/2000 para a categoria de trabalhador 07.
      Sempre que não informado o campo deve ficar em branco. }
    FCategoriaTrabalhador: String; // 2 N - Código deve estar na tabela categoria do trabalhador. Campo obrigatório.
    FNomeTrabalhador: String; { 70 A - Campo obrigatório. Não pode conter número. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos.
      A primeira posição não pode ser branco. Pode conter apenas caracteres de A a Z. }
    FMatriculaEmpregado: String; { 11 N - Número de matrícula atribuído pela empresa ao trabalhador, quando houver. Não pode ser informado para as categorias 06, 13, 14, 15, 16 , 17, 18, 22, 23, 24 ou 25.
      Sempre que não informado o campo deve ficar em branco. }
    FNumeroCTPS: String; { 7 N - Obrigatório para as categorias de trabalhadores 01, 03 , 04, 06, 07 e 26. Opcional para a categoria de trabalhador 02.
      Não pode ser informado para as demais categorias. Sempre que não informado o campo deve ficar em branco. }
    FSerieCTPS: String; { 5 N - Obrigatório para as categorias de trabalhadores 01, 03 , 04, 06, 07 e 26. Opcional para a categoria de trabalhador 02.
      Não pode ser informado para as demais categorias. Sempre que não informado o campo deve ficar em branco. }
    FDataOpcao: TDateTime; { 8 D - (Indicar a data em que o trabalhador optou pelo FGTS). Formato DDMMAAAA. Obrigatório para as
      categorias de trabalhadores 01, 03, 04 , 05, 06 e 07 e deve conter uma data válida. Não pode ser informado para as demais categorias.
      Deve ser maior ou igual a data de admissão e limitada a 05/10/1988 quando a data de admissão for menor que 05/10/1988, para as categorias 1 e 3.
      Deve ser igual a data de admissão quando a mesma for maior ou igual a 05/10/1988, para as categorias 1 e 3.
      Deve ser maior ou igual a 22/01/1998 para a categoria de trabalhador 04. Deve ser maior ou igual a 02/06/1981 para a categoria de trabalhador 05.
      Deve ser maior ou igual a 01/03/2000 para a categoria de trabalhador 06. Deve ser maior ou igual a 20/12/2000 e igual a data de admissão para categoria de trabalhador 07.
      Não pode ser informado para o código de recolhimento 640. Não pode ser menor que 01/01/1967. Sempre que não informado o campo deve ficar em branco. }
    FDataNascimento: TDateTime; { 8 D - Formato DDMMAAAA. Campo obrigatório para as categorias de trabalhadores 01, 02, 03, 04, 05, 06, 07, 12, 19, 20, 21 e 26
      deve conter uma data válida. Não pode ser informado para as demais categorias. Deve ser menor que a data de admissão.
      Deve ser maior a 01/01/1900. Sempre que não informado o campo deve ficar em branco. }
    FCBO: String; { 5 AN - Código Brasileiro de Ocupação. Campo Obrigatório. Utilizar os quatro primeiros dígitos do grupo “Família” do novo CBO,
      acrescentando zero a esquerda.(0 + XXXX onde XXXX é o código da família do novo CBO a qual pertence o trabalhador).
      Deve ser igual a 05121 para empregado doméstico (categoria 06). Código “família” deve estar contido na tabela do novo CBO. }
    FRemuneracaoSem13: Double; { 15 V - (Destinado à informação da remuneração paga, devida ou creditada ao trabalhador no mês, conforme base de incidência.
      Excluir do valor da remuneração o 13º salário pago no mês). Campo obrigatório para as categorias 05, 11, 13, 14, 15, 16, 17, 18, 22, 23, 24 e 25.
      Opcional para as categorias 01, 02, 03, 04, 06, 07, 12, 19, 20, 21 e 26. As remunerações pagas após rescisão do contrato de trabalho e
      conforme determinação do Art. 466 da CLT, não devem vir acompanhadas das respectivas movimentações. Se informado deve ter 2 casas decimais válidas.
      Não pode ser informado para a competência 13. Sempre que não informado preencher com zeros. }
    FRemuneracao13: Double; { 15 V - (Destinado à informação da parcela de 13º salário pago no mês ao trabalhador). Não pode ser informado para a competência 13.
      Campo obrigatório para categoria 02. Campo opcional para as categorias de trabalhadores 01, 03, 04, 06, 07, 12, 19, 20, 21 e 26.
      As remunerações pagas após rescisão do contrato de trabalho e conforme determinação do Art. 466 da CLT, não devem vir acompanhadas
      das respectivas movimentações. Sempre que não informado preencher com zeros. }
    FClasseContribuicao: String; { 2 N - (Indicar a classe de contribuição do autônomo, quando a empresa opta por contribuir sobre seu salário-base e os
      classifica como categoria 14 ou 16. A classe deve estar compreendida em tabela fornecida pelo INSS).
      Campo obrigatório para as categorias 14 e 16 (apenas em recolhimentos de competências anteriores a 03/2000). Não pode ser informado para as demais categorias.
      Não pode ser informado para a competência 13. Sempre que não informado o campo deve ficar em branco. }
    FOcorrencia: String; { 2 N - (Destinado à informação de exposição do trabalhador a agente nocivo e/ou para indicação de multiplicidade de vínculos para
      um mesmo trabalhador). Campo opcional para as categorias 01, 03, 04, 06, 07, 12, 19, 20 e 21.
      Campo opcional para as categorias 05, 11, 13,15, 17, 18, 22, 23, 24 e 25 a partir da competência 04/2003.
      Campo opcional para a categoria 02 a partir da competência 04/1999. Deve ficar em branco se trabalhador não esteve exposto a agente nocivo
      e não possui mais de um vínculo empregatício. Para empregado doméstico (Cat 06) e diretor não empregado (Cat 05) permitido apenas branco ou 05.
      Para as categorias 02, 22 e 23 permitido apenas branco, 01, 02, 03 e 04. Obrigatório para categoria 26, devendo ser informado 05, 06, 07 ou 08.
      Não pode ser informado para as demais categorias. Deve ser uma ocorrência válida (ver tabela).
      Sempre que não informado o campo deve ficar em branco. }
    FValorDescontadoSegurado: Double; { 15 V - (Destinado à informação do valor da contribuição do trabalhador com mais de um vínculo empregatício;
      ou quando tratarse de recolhimento de trabalhador avulso, dissídio coletivo ou reclamatória trabalhista, ou, ainda nos meses de afastamento e
      retorno de licença maternidade) O valor informado será considerado como contribuição do segurado.
      Campo opcional para as ocorrências 05, 06, 07 e 08.
      Campo opcional para as categorias de trabalhadores igual a 01, 02, 04, 06, 07, 12, 19, 20, 21 e 26.
      Campo opcional para as categorias de trabalhadores igual a 05, 11, 13, 15, 17, 18, 24 e 25 a partir da competência 04/2003.
      Campo opcional para os códigos de recolhimento 130, 135 e 650.
      Campo opcional para competência maior ou igual a 12/1999 para afastamentos por motivo de licença-maternidade
      iniciada a partir de 01/12/1999 e com benefícios requeridos até 31/08/2003.
      Não pode ser informado para competência anterior a outubro de 1998. Sempre que não informado preencher com zeros. }
    FRemuneracaoBaseCalculoContribuicaoPrevidenciaria: Double; { 15 V -  (Destinado à informação da parcela de remuneração sobre a qual incide
      contribuição previdenciária, quando o trabalhador estiver afastado por motivo de acidente de trabalho e/ou prestação de serviço militar
      obrigatório ou na informação de Recolhimento Complementar de FGTS). Campo obrigatório para as movimentações (registro 32) por O1, O2, R, Z2, Z3 e Z4.
      Campo obrigatório quando o Indicativo “C” de Recolhimento Complementar de FGTS for informado (registro Tipo 32 – campo 12).
      Campo opcional para as categorias 01, 02, 04, 05, 06, 07,11, 12, 19, 20, 21 e 26. Não pode ser informado na competência 13.
      Não pode ser informado para competência anterior a outubro de 1998. Não pode ser informado para os códigos de recolhimento
      145, 307, 317, 327, 337, 345, 640 e 660. Sempre que não informado preencher com zeros. }
    FBaseCalculo13SalarioPrevidenciaSocialReferenteCompetenciaMovimento: Double; {  15 V -  (Na competência em que ocorreu o afastamento definitivo –
      informar o valor total do 13º pago no ano ao trabalhador. Na competência 12 – Indicar eventuais diferenças de gratificação
      natalina de empregados que recebem remuneração variável – Art. 216, Parágrafo 25, Decreto 3.265 de 29.11.1999) Na competência 13,
      para a geração da GPS, indicar o valor total do 13º salário pago no ano ao trabalhador). Obrigatório para a competência 13.
      Obrigatório no mês de rescisão para quem trabalhou mais de 15 dias no ano e possui código de
      movimentação por motivo rescisão (exceto rescisão com justa causa), aposentadoria com quebra de vínculo ou falecimento.
      Obrigatório para os códigos de recolhimento 130 e 135. Obrigatório para os códigos de recolhimento 608 quando houver trabalhador
      da categoria 02 no arquivo. Opcional para os códigos de recolhimento 650.
      Só pode ser informado para as categorias 01, 02, 04 ,06 , 07, 12, 19, 20, 21 e 26. Campo opcional para as categorias 01, 04 , 06 , 07, 12, 19,
      20, 21 e 26 na competência 12. Sempre que não informado preencher com zeros. }
    FBaseCalculo13SalarioPrevidenciaReferenteGPSCompetencia13: Double; { 15 V -  Deve ser utilizado apenas na competência 12, informando o valor
      da base de cálculo do 13º dos empregados que recebem remuneração variável, em relação a remuneração apurada até 20/12 sobre
      a qual já houve recolhimento em GPS). Campo opcional para a competência 12. Não pode ser informado nas demais competências.
      Campo opcional para as categorias 01, 04 , 06, 07, 12, 19, 20, 21 e 26. Se informado o campo 22 (registro 30) deve ser diferente de zeros.
      Sempre que não informado preencher com zeros. }
    /// Brancos Campo obrigatório. Preencher com brancos.
    /// Final de Linha. Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

    FRegistroValido: Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read FRegistroValido write FRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property TipoInscricaoEmpresa: String read FTipoInscricaoEmpresa write FTipoInscricaoEmpresa;
    property InscricaoEmpresa: String read FInscricaoEmpresa write FInscricaoEmpresa;
    property TipoInscricaoTomadorObraConstCivil: String read FTipoInscricaoTomadorObraConstCivil write FTipoInscricaoTomadorObraConstCivil;
    property InscricaoTomadorObraConstCivil: String read FInscricaoTomadorObraConstCivil write FInscricaoTomadorObraConstCivil;
    property PISPASEPCI: String read FPISPASEPCI write FPISPASEPCI;
    property DataAdmissao: TDateTime read FDataAdmissao write FDataAdmissao;
    property CategoriaTrabalhador: String read FCategoriaTrabalhador write FCategoriaTrabalhador;
    property NomeTrabalhador: String read FNomeTrabalhador write FNomeTrabalhador;
    property MatriculaEmpregado: String read FMatriculaEmpregado write FMatriculaEmpregado;
    property NumeroCTPS: String read FNumeroCTPS write FNumeroCTPS;
    property SerieCTPS: String read FSerieCTPS write FSerieCTPS;
    property DataOpcao: TDateTime read FDataOpcao write FDataOpcao;
    property DataNascimento: TDateTime read FDataNascimento write FDataNascimento;
    property CBO: String read FCBO write FCBO;
    property RemuneracaoSem13: Double read FRemuneracaoSem13 write FRemuneracaoSem13;
    property Remuneracao13: Double read FRemuneracao13 write FRemuneracao13;
    property ClasseContribuicao: String read FClasseContribuicao write FClasseContribuicao;
    property Ocorrencia: String read FOcorrencia write FOcorrencia;
    property ValorDescontadoSegurado: Double read FValorDescontadoSegurado write FValorDescontadoSegurado;
    property RemuneracaoBaseCalculoContribuicaoPrevidenciaria: Double read FRemuneracaoBaseCalculoContribuicaoPrevidenciaria write FRemuneracaoBaseCalculoContribuicaoPrevidenciaria;
    property BaseCalculo13SalarioPrevidenciaSocialReferenteCompetenciaMovimento: Double read FBaseCalculo13SalarioPrevidenciaSocialReferenteCompetenciaMovimento write FBaseCalculo13SalarioPrevidenciaSocialReferenteCompetenciaMovimento;
    property BaseCalculo13SalarioPrevidenciaReferenteGPSCompetencia13: Double read FBaseCalculo13SalarioPrevidenciaReferenteGPSCompetencia13 write FBaseCalculo13SalarioPrevidenciaReferenteGPSCompetencia13;
    /// Brancos 98 AN - Campo obrigatório. Preencher com brancos.
    /// Final de Linha 1 AN - Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

  end;

  // REGISTRO TIPO 30 - Lista
  TRegistroTipo30List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipo30;
    procedure SetItem(Index: Integer; const Value: TRegistroTipo30);
  public
    function New: TRegistroTipo30;
    property Items[Index: Integer]: TRegistroTipo30 read GetItem write SetItem;
  end;

  // REGISTRO TIPO 32 – Movimentação do Trabalhador
  { Permitido para as categorias de trabalhador 01, 02, 03, 04 , 05, 06, 07, 11 , 12, 19, 20, 21 e 26
   Não pode ser informado para competência 13
   Obrigatório informar as movimentações I1, I2, I3, I4 e L , no mês anterior a rescisão e no mês da rescisão com a remuneração devida no respectivo mês.
   Os códigos de recolhimento 145, 307, 317, 327, 337 e 345 acatam apenas o código de movimentaçãoV3.}

  TRegistroTipo32 = class
  private
    FTipoRegistro: String; // 2 N -  Campo obrigatório. Sempre “32”.
    FTipoInscricaoEmpresa: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI).
    FInscricaoEmpresa: String; { 14 N - Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido.
      Se Tipo Inscrição = 2, então número esperado CEI válido. }
    FTipoInscricaoTomadorObraConstCivil: String; { 1 N - Campo obrigatório. Para os códigos de recolhimento 130, 135, 150, 155 e 608 tipo informado só pode
      ser 1 (CNPJ) ou 2 (CEI). Para os demais códigos de recolhimento, campo deve ficar em branco. }
    FInscricaoTomadorObraConstCivil: String; { 14 N - (Destinado à informação da inscrição da empresa tomadora de serviço nos recolhimentos de trabalhadores avulsos, prestação
      de serviços, obra de construção civil e dirigente sindical). Campo obrigatório. Obrigatório para os códigos de recolhimento 130, 135, 150, 155, 211, 317, 337 e 608.
      Se Tipo Inscrição = 1, então número esperado CNPJ válido. Se Tipo Inscrição = 2, então número esperado CEI válido.
      Sempre que não informado, campo deve ficar em branco. }
    FPISPASEPCI: String; // 11 N - Campo obrigatório. O número informado deve ser válido.
    FDataAdmissao: TDateTime; { 8 D - Formato DDMMAAAA. Obrigatório para as categorias de trabalhadores 01, 03, 04, 05, 06, 07, 11, 12, 19, 20, 21 e 26.
      Deve conter uma data válida. Não pode ser informado para as demais categorias. Deve ser menor ou igual a competência informada.
      Deve ser maior ou igual a 22/01/1998 para a categoria de trabalhador 04. Deve ser maior ou igual a 20/12/2000 para a categoria de trabalhador 07.
      Sempre que não informado o campo deve ficar em branco. }
    FCategoriaTrabalhador: String; // 2 N - Código deve estar na tabela categoria do trabalhador. Campo obrigatório.
    FNomeTrabalhador: String; { Campo obrigatório. Não pode conter número. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos.
      A primeira posição não pode ser branco. Pode conter apenas caracteres de A a Z. }
    FCodigoMovimentacao: String; { 2 AN - Campo obrigatório para as categorias trabalhador 01, 02, 03, 04, 05, 06, 07, 11, 12, 19,20, 21 e 26.
      Não pode ser informado mais de uma movimentação definitiva por trabalhador. Deve ser informado o código e a data do afastamento sempre que houver
      a informação de uma movimentação de retorno. Devem ser informadas as movimentações H, I1, I2, I3, J, K, L, O1, O2, Q1, Q2, Q3, Q4, Q5, Q6, R,
      Z1, Z2, Z3 e Z4 em todos os tomadores (códigos de recolhimento 150 e 155,) em que o trabalhador estiver alocado, quando ocorrer a movimentação.
      Os códigos de recolhimento 145, 307, 317, 327, 337 e 345 acatam apenas o código de movimentação V3. O código de movimentação V3 não permite a
      informação de outra movimentação para o mesmo trabalhador. }
    FDataMovimentacao: TDateTime; { 8 D - Campo obrigatório para movimentação do trabalhador. Formato DDMMAAAA. Deve ser uma data válida. Deve ser maior que data de admissão.
      Para movimentação temporária, informar como data de afastamento o dia imediatamente anterior ao efetivo afastamento e como data de retorno o último dia do afastamento.
      Para movimentação definitiva (rescisão, falecimento e aposentadoria sem continuidade de vínculo), informar como data de afastamento o último dia trabalhado.
      Deve estar compreendida no mês imediatamente anterior ou no mês da competência, para os códigos de movimentação H, J, K, M, N1, N2, S2, S3 e U1.
      Deve estar compreendida no mês da competência, se o código de movimentação for Z1, Z2, Z3, Z4, Z5 e Z6. Deve estar compreendida no mês anterior,
      no mês da competência ou no mês posterior (se o recolhimento do FGTS já tiver sido efetuado) e o código de movimentação for I1, I2, I3 , I4 ou L.
      Deve ser menor ou igual ao mês de competência , para códigos de movimentação O1, O2, O3, P1, P2, Q1, Q2, Q3, Q4, Q5, Q6, R, U3. W, X e Y.
      Deve ser informada para os códigos de movimentação O1, O2, O3, Q1, Q2, Q3, Q4, Q5, Q6 e R, mensalmente, até que se dê o efetivo retorno.
      Sempre que informado o código de movimentação V3 a data de movimentação a ser informada é a do afastamento definitivo. }
    FIndicativoRecolhimentoFGTS: String; { 1 AN - (Utiliza-se “S” ou “N” para indicar se o empregador já efetuou arrecadação FGTS na Guia de Recolhimento
      Rescisório para trabalhadores com movimentação código I1, I2, I3, I4 ou L. Se indicativo for igual a “S” o valor da remuneração será considerado
      apenas para cálculo da contribuição previdenciária. Utiliza-se “C” para indicar a Remuneração Complementar do FGTS, sendo que a base de cálculo da
      Previdência Social deverá ser diferente da remuneração para cálculo do FGTS.). Caracteres possíveis: “S” ou “s”, “N” ou “n”, “C” ou “c” e “Branco”.
      Só deve ser informado “S’ ou “N” para competência maior que 01/1998. Obrigatório “S’ ou “N” para códigos de movimentação I1, I2, I3, I4 ou L.
      Não pode ser informado “S’ ou “N” para os demais códigos de movimentação. Deve ser informado “S” apenas para as categorias 01, 03, 04, 05, 06 e 07.
      Só deve ser informado “C’ para competência maior ou igual a 10/1998. Não deve ser informado “C” para os códigos 640 e 660.
      Deve ser informado “C” apenas para as categorias 01, 02, 03, 04, 05, 06 e 07. Não pode ser informado “S”, “N” ou “C para a competência 13.
      Sempre que não informado campo deve ficar em branco. }
    /// Brancos 225 AN - Campo obrigatório. Preencher com brancos.
    /// Final de Linha 1 AN - Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

    FRegistroValido: Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read FRegistroValido write FRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property TipoInscricaoEmpresa: String read FTipoInscricaoEmpresa write FTipoInscricaoEmpresa;
    property InscricaoEmpresa: String read FInscricaoEmpresa write FInscricaoEmpresa;
    property TipoInscricaoTomadorObraConstCivil: String read FTipoInscricaoTomadorObraConstCivil write FTipoInscricaoTomadorObraConstCivil;
    property InscricaoTomadorObraConstCivil: String read FInscricaoTomadorObraConstCivil write FInscricaoTomadorObraConstCivil;
    property PISPASEPCI: String read FPISPASEPCI write FPISPASEPCI;
    property DataAdmissao: TDateTime read FDataAdmissao write FDataAdmissao;
    property CategoriaTrabalhador: String read FCategoriaTrabalhador write FCategoriaTrabalhador;
    property NomeTrabalhador: String read FNomeTrabalhador write FNomeTrabalhador;
    property CodigoMovimentacao: String read FCodigoMovimentacao write FCodigoMovimentacao;
    property DataMovimentacao: TDateTime read FDataMovimentacao write FDataMovimentacao;
    property IndicativoRecolhimentoFGTS: String read FIndicativoRecolhimentoFGTS write FIndicativoRecolhimentoFGTS;
    /// Brancos Campo obrigatório. Preencher com brancos.
    /// Final de Linha. Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

  end;

  // REGISTRO TIPO 32 - Lista
  TRegistroTipo32List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipo32;
    procedure SetItem(Index: Integer; const Value: TRegistroTipo32);
  public
    function New: TRegistroTipo32;
    property Items[Index: Integer]: TRegistroTipo32 read GetItem write SetItem;
  end;


  // REGISTRO TIPO 50– Empresa Com Recolhimento pelos códigos 027, 046, 604 e 736 (Header da empresa )
  //(PARA IMPLEMENTAÇÃO FUTURA)

  TRegistroTipo50 = class
  private
    FTipoRegistro: String; // 2 N -  Campo obrigatório. Sempre “50”.
    FTipoInscricaoEmpresa: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI).
    FInscricaoEmpresa: String; { 14 N - Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido.
      Se Tipo Inscrição = 2, então número esperado CEI válido. }
    /// Zeros 36 N - (Campo obrigatório.  Preencher com zeros.
    FNomeEmpresaRazaoSocial: String; // 40 AN - Campo obrigatório. A primeira posição não pode ser branco. Permitido apenas caracteres de A a Z e números de 0 a 9.
    FTipoInscricaoTomador: String; // 1 N - Só pode ser 1 (CNPJ) ou 2 (CEI). Para os demais códigos de recolhimento, campo deve ficar em branco.
    FInscricaoTomador: String; { 14 N - (Destinado à informação da inscrição da empresa tomadora de serviço nos recolhimentos de trabalhadores avulsos,
      prestação de serviços, obra de construção civil e dirigente sindical). 95 108 14 N · Se Tipo Inscrição = 1, então número esperado CNPJ válido.
      Se Tipo Inscrição = 2, então número esperado CEI válido. CNPJ do tomador não pode ser igual ao da empresa. }
    FNomeTomadorServicoObraConstCivil: String; { 40 AN -  Não pode conter caracteres especiais. Não pode haver caracteres acentuados. Não é permitido mais de um espaço entre os nomes.
      Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FLogradouro: String; { 50 AN - Rua, nº, andar,apartamento. Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FBairro: String; { 20 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FCep: String; // 8 N - Campo obrigatório. Número de CEP válido. Permitido apenas, números diferentes de 20000000, 30000000, 70000000 ou 80000000.
    FCidade: String; { 20 AN - Campo obrigatório. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser branco.
      Pode conter apenas caracteres de A a Z e números de 0 a 9. }
    FUnidadeFederacao: String; // 2 AN - Campo obrigatório. Deve constar da tabela de unidades da federação
    FTelefone: String; // 12 N - Campo obrigatório. Deve conter no mínimo 02 dígitos válidos no DDD e 06 dígitos no telefone.
    FCNAE: String; // 7 N - Campo obrigatório. Número válido de CNAE.
    FCodigoCentralizacao: String; { 1 N - (Para indicar as empresas que centralizam o recolhimento do FGTS ). Campo obrigatório. Só pode ser 0 (não centraliza), 1 (centralizadora) ou 2 (centralizada).
      Quando existir empresa centralizadora deve existir, no mínimo, uma empresa centralizada e viceversa.
      Quando existir centralização, as oito primeiras posições do CNPJ da centralizadora e da centralizada devem ser iguais.
      Empresa com inscrição CEI não possui centralização. }
    FValorMulta: Double; // 15 V - Informar o valor total da multa a ser recolhida. Campo opcional. Sempre que não informado preencher com zeros.
    /// Brancos 76 AN - Campo obrigatório. Preencher com brancos.
    /// Final de Linha 1 AN -  Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

    FRegistroValido: Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read FRegistroValido write FRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property TipoInscricaoEmpresa: String read FTipoInscricaoEmpresa write FTipoInscricaoEmpresa;
    property InscricaoEmpresa: String read FInscricaoEmpresa write FInscricaoEmpresa;
    /// Zeros (Campo obrigatório.  Preencher com zeros.
    property TipoInscricaoTomador: String read FTipoInscricaoTomador write FTipoInscricaoTomador;
    property InscricaoTomador: String read FInscricaoTomador write FInscricaoTomador;
    property NomeTomadorServicoObraConstCivil: String read FNomeTomadorServicoObraConstCivil write FNomeTomadorServicoObraConstCivil;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Bairro: String read FBairro write FBairro;
    property Cep: String read FCep write FCep;
    property Cidade: String read FCidade write FCidade;
    property UnidadeFederacao: String read FUnidadeFederacao write FUnidadeFederacao;
    property Telefone: String read FTelefone write FTelefone;
    property CNAE: String read FCNAE write FCNAE;
    property CodigoCentralizacao: String read FCodigoCentralizacao write FCodigoCentralizacao;
    property ValorMulta: Double read FValorMulta write FValorMulta;
    /// Brancos Campo obrigatório. Preencher com brancos.
    /// Final de Linha. Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

  end;

  // REGISTRO TIPO 50 - Lista
  TRegistroTipo50List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipo50;
    procedure SetItem(Index: Integer; const Value: TRegistroTipo50);
  public
    function New: TRegistroTipo50;
    property Items[Index: Integer]: TRegistroTipo50 read GetItem write SetItem;
  end;

  // REGISTRO TIPO 51 - Registro de Individualização de valores recolhidos pelos códigos 027, 046, 604 e 736
  //(PARA IMPLEMENTAÇÃO FUTURA)

  TRegistroTipo51 = class
  private
    FTipoRegistro: String; // 2 N -  Campo obrigatório. Sempre “51”.
    FTipoInscricaoEmpresa: String; // 1 N - Campo obrigatório. Só pode ser 1 (CNPJ) ou 2 (CEI).
    FInscricaoEmpresa: String; { 14 N - Campo obrigatório. Se Tipo Inscrição = 1, então número esperado CNPJ válido.
      Se Tipo Inscrição = 2, então número esperado CEI válido. }
    FTipoInscricaoTomador: String; // 1 N - Só pode ser 1 (CNPJ) ou 2 (CEI). Para os demais códigos de recolhimento, campo deve ficar em branco.
    FInscricaoTomador: String; { 14 N - (Destinado à informação da inscrição da empresa tomadora de serviço nos recolhimentos de trabalhadores avulsos,
      prestação de serviços, obra de construção civil e dirigente sindical). 95 108 14 N · Se Tipo Inscrição = 1, então número esperado CNPJ válido.
      Se Tipo Inscrição = 2, então número esperado CEI válido. CNPJ do tomador não pode ser igual ao da empresa. }
    FPISPASEP: String; // 11 N - Campo obrigatório. O número informado deve ser válido
    FDataAdmissao: TDateTime; { 8 D - Formato DDMMAAAA. Obrigatório para as categorias de trabalhadores 01, 03, 04 e 05 e deve conter uma data válida.
      Não pode ser informado para a categoria 02. Deve ser menor ou igual a competência informada. Deve ser maior ou igual a 22/01/1998 para a
      categoria de trabalhador 04. Sempre que não informado o campo deve ficar em branco. }
    FCategoriaTrabalhador: String; // 2 N - Código deve estar na tabela categoria do trabalhador. Campo obrigatório.
    FNomeTrabalhador: String; { 70 A - Campo obrigatório. Não pode conter número. Não pode conter caracteres especiais. Não pode haver caracteres acentuados.
      Não é permitido mais de um espaço entre os nomes. Não é permitido três ou mais caracteres iguais consecutivos. A primeira posição não pode ser
      branco. Pode conter apenas caracteres de A a Z. }
    FMatriculaEmpregado: String; // 11 N - Número de matrícula atribuído pela empresa ao trabalhador, quando houver.
    FNumeroCTPS: String; { 7 N - Obrigatório para as categorias de trabalhadores 01, 03 e 04. Opcional para a categoria de trabalhador 02.
      Não pode ser informado para a categoria 05. Sempre que não informado o campo deve ficar em branco. }
    FSerieCTPS: String; { 5 N - Obrigatório para as categorias de trabalhadores 01, 03 e 04. Opcional para a categoria de trabalhador 02.
      Não pode ser informado para a categoria 05. Sempre que não informado o campo deve ficar em branco. }
    FDataOpcao: TDateTime; { 8 D - (Indicar a data em que o trabalhador optou pelo FGTS). Formato DDMMAAAA. Obrigatório para as categorias de trabalhadores
      optantes 01, 03, 04, 05, 06 e 07 e deve conter uma data válida. · Não pode ser informado para a categoria 02. Deve ser maior ou igual que a data
      de admissão. Deve ser maior ou igual que a data de admissão e limitada a 05/10/1988 quando a data de admissão for menor que 05/10/1988.
      Deve ser igual a admissão quando a data de admissão for maior ou igual a 05/10/1988. Deve ser maior ou igual a data de admissão, para a categoria
      de trabalhador 05. Não pode ser informado para o código de recolhimento 046. Não pode ser menor que 01/01/1967.
      Sempre que não informado o campo deve ficar em branco. }
    FDataNascimento: TDateTime; { 8 D - Formato DDMMAAAA. Deve ser informado para as categorias de trabalhadores 01, 02, 03, 04 e 05 e deve conter uma data
      válida. Deve ser menor que a data de admissão. Deve ser maior a 01/01/1900. }
    FCBO: String; { 5 AN - Código Brasileiro de Ocupação. Campo Obrigatório. Utilizar os quatro primeiros dígitos do grupo “Família” do novo CBO,
      acrescentando zero a esquerda.(0 + XXXX onde XXXX é o código da família do novo CBO a qual pertence o trabalhador).
      Deve ser igual a 05121 para empregado doméstico (categoria 06). Código “família” deve estar contido na tabela do novo CBO. }
    FValorDepositoSem13Salario: Double; { 15 V - (Destinado à informação do valor do depósito efetuado, sem a parcela do 13º . 168 182 15 V · Campo opcional.
      Se informado deve ter 2 casas decimais válidas. Sempre que não informado preencher com zeros. }
    FValorDepositoSobre13Salario: Double; { 15 V - (Destinado à informação do valor do depósito sobre a parcela do 13º 173 197 15 V · Campo opcional.
      Sempre que não informado preencher com zeros. }
    FValorJAM: Double; // 15 V - (Informar o valor de juros e atualização monetária ). Campo opcional. Sempre que não informado preencher com zeros.
    /// Brancos 147 AN - Campo obrigatório. Preencher com brancos.
    /// Final de Linha 1 AN - Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

    FRegistroValido: Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read FRegistroValido write FRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property TipoInscricaoEmpresa: String read FTipoInscricaoEmpresa write FTipoInscricaoEmpresa;
    property InscricaoEmpresa: String read FInscricaoEmpresa write FInscricaoEmpresa;
    property TipoInscricaoTomador: String read FTipoInscricaoTomador write FTipoInscricaoTomador;
    property InscricaoTomador: String read FInscricaoTomador write FInscricaoTomador;
    property PISPASEP: String read FPISPASEP write FPISPASEP;
    property DataAdmissao: TDateTime read FDataAdmissao write FDataAdmissao;
    property CategoriaTrabalhador: String read FCategoriaTrabalhador write FCategoriaTrabalhador;
    property NomeTrabalhador: String read FNomeTrabalhador write FNomeTrabalhador;
    property MatriculaEmpregado: String read FMatriculaEmpregado write FMatriculaEmpregado;
    property NumeroCTPS: String read FNumeroCTPS write FNumeroCTPS;
    property SerieCTPS: String read FSerieCTPS write FSerieCTPS;
    property DataOpcao: TDateTime read FDataOpcao write FDataOpcao;
    property DataNascimento: TDateTime read FDataNascimento write FDataNascimento;
    property CBO: String read FCBO write FCBO;
    property ValorDepositoSem13Salario: Double read FValorDepositoSem13Salario write FValorDepositoSem13Salario;
    property ValorDepositoSobre13Salario: Double read FValorDepositoSobre13Salario write FValorDepositoSobre13Salario;
    property ValorJAM: Double read FValorJAM write FValorJAM;
    /// Brancos Campo obrigatório. Preencher com brancos.
    /// Final de Linha. Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

  end;

  // REGISTRO TIPO 51 - Lista
  TRegistroTipo51List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroTipo51;
    procedure SetItem(Index: Integer; const Value: TRegistroTipo51);
  public
    function New: TRegistroTipo51;
    property Items[Index: Integer]: TRegistroTipo51 read GetItem write SetItem;
  end;

  // REGISTRO TIPO 90 – Registro Totalizador do Arquivo
  TRegistroTipo90 = class
  private
    FTipoRegistro: String; // 2 N -  Campo obrigatório.  Sempre “90”.
    FMarcaFinalRegistro: String ; // 51 AN - Campo obrigatório. De 3 a 53 deve ser “9”.
    /// Brancos 306 AN - Campo obrigatório. Preencher com brancos.
   /// Final de Linha 1 AN - Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

    FRegistroValido: Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property RegistroValido: Boolean read FRegistroValido write FRegistroValido default True;
    property TipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property MarcaFinalRegistro: String read FMarcaFinalRegistro write FMarcaFinalRegistro;
    /// Brancos. Campo obrigatório. Preencher com brancos.
    /// Final de Linha. Campo obrigatório. Deve ser uma constante “*” para marcar fim de linha.

  end;

implementation

{ TRegistroTipo00 }

constructor TRegistroTipo00.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo00.Destroy;
begin
  inherited;
end;

{ TRegistroTipo10 }

constructor TRegistroTipo10.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo10.Destroy;
begin
  inherited;
end;

{ TRegistroTipo12List }

function TRegistroTipo12List.GetItem(Index: Integer): TRegistroTipo12;
begin
  Result := TRegistroTipo12(inherited Items[Index]);
end;

function TRegistroTipo12List.New: TRegistroTipo12;
begin
  Result := TRegistroTipo12.Create;
  Add(Result);
end;

procedure TRegistroTipo12List.SetItem(Index: Integer; const Value: TRegistroTipo12);
begin
  Put(Index, Value);
end;

{ TRegistroTipo12 }

constructor TRegistroTipo12.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo12.Destroy;
begin
  inherited;
end;

{ TRegistroTipo13List }

function TRegistroTipo13List.GetItem(Index: Integer): TRegistroTipo13;
begin
  Result := TRegistroTipo13(inherited Items[Index]);
end;

function TRegistroTipo13List.New: TRegistroTipo13;
begin
  Result := TRegistroTipo13.Create;
  Add(Result);
end;

procedure TRegistroTipo13List.SetItem(Index: Integer; const Value: TRegistroTipo13);
begin
  Put(Index, Value);
end;

{ TRegistroTipo13 }

constructor TRegistroTipo13.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo13.Destroy;
begin
  inherited;
end;

{ TRegistroTipo14List }

function TRegistroTipo14List.GetItem(Index: Integer): TRegistroTipo14;
begin
  Result := TRegistroTipo14( inherited Items[Index]);
end;

function TRegistroTipo14List.New: TRegistroTipo14;
begin
  Result := TRegistroTipo14.Create;
  Add(Result);
end;

procedure TRegistroTipo14List.SetItem(Index: Integer; const Value: TRegistroTipo14);
begin
  Put(Index, Value);
end;

{ TRegistroTipo14 }

constructor TRegistroTipo14.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo14.Destroy;
begin
  inherited;
end;

{ TRegistroTipo20List }

function TRegistroTipo20List.GetItem(Index: Integer): TRegistroTipo20;
begin
  Result := TRegistroTipo20(inherited Items[Index]);
end;

function TRegistroTipo20List.New: TRegistroTipo20;
begin
  Result := TRegistroTipo20.Create;
  Add(Result);
end;

procedure TRegistroTipo20List.SetItem(Index: Integer; const Value: TRegistroTipo20);
begin
  Put(Index, Value);
end;

{ TRegistroTipo20 }

constructor TRegistroTipo20.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo20.Destroy;
begin
  inherited;
end;

{ TRegistroTipo21List }

function TRegistroTipo21List.GetItem(Index: Integer): TRegistroTipo21;
begin
  Result := TRegistroTipo21(inherited Items[Index]);
end;

function TRegistroTipo21List.New: TRegistroTipo21;
begin
  Result := TRegistroTipo21.Create;
  Add(Result);
end;

procedure TRegistroTipo21List.SetItem(Index: Integer; const Value: TRegistroTipo21);
begin
  Put(Index, Value);
end;

{ TRegistroTipo21 }

constructor TRegistroTipo21.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo21.Destroy;
begin
  inherited;
end;

{ TRegistroTipo30List }

function TRegistroTipo30List.GetItem(Index: Integer): TRegistroTipo30;
begin
  Result := TRegistroTipo30(inherited Items[Index]);
end;

function TRegistroTipo30List.New: TRegistroTipo30;
begin
  Result := TRegistroTipo30.Create;
  Add(Result);
end;

procedure TRegistroTipo30List.SetItem(Index: Integer; const Value: TRegistroTipo30);
begin
  Put(Index, Value);
end;

{ TRegistroTipo30 }

constructor TRegistroTipo30.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo30.Destroy;
begin
  inherited;
end;

{ TRegistroTipo32List }

function TRegistroTipo32List.GetItem(Index: Integer): TRegistroTipo32;
begin
  Result := TRegistroTipo32(inherited Items[Index]);
end;

function TRegistroTipo32List.New: TRegistroTipo32;
begin
  Result := TRegistroTipo32.Create;
  Add(Result);
end;

procedure TRegistroTipo32List.SetItem(Index: Integer; const Value: TRegistroTipo32);
begin
  Put(Index, Value);
end;

{ TRegistroTipo32 }

constructor TRegistroTipo32.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo32.Destroy;
begin
  inherited;
end;

{ TRegistroTipo50List }

function TRegistroTipo50List.GetItem(Index: Integer): TRegistroTipo50;
begin
  Result := TRegistroTipo50(inherited Items[Index]);
end;

function TRegistroTipo50List.New: TRegistroTipo50;
begin
  Result := TRegistroTipo50.Create;
  Add(Result);
end;

procedure TRegistroTipo50List.SetItem(Index: Integer; const Value: TRegistroTipo50);
begin
  Put(Index, Value);
end;

{ TRegistroTipo50 }

constructor TRegistroTipo50.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo50.Destroy;
begin
  inherited;
end;

{ TRegistroTipo51List }

function TRegistroTipo51List.GetItem(Index: Integer): TRegistroTipo51;
begin
  Result := TRegistroTipo51(inherited Items[Index]);
end;

function TRegistroTipo51List.New: TRegistroTipo51;
begin
  Result := TRegistroTipo51.Create;
  Add(Result);
end;

procedure TRegistroTipo51List.SetItem(Index: Integer; const Value: TRegistroTipo51);
begin
  Put(Index, Value);
end;

{ TRegistroTipo51 }

constructor TRegistroTipo51.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo51.Destroy;
begin
  inherited;
end;

{ TRegistroTipo90 }

constructor TRegistroTipo90.Create;
begin
  FRegistroValido := True;
end;

destructor TRegistroTipo90.Destroy;
begin
  inherited;
end;

end.
