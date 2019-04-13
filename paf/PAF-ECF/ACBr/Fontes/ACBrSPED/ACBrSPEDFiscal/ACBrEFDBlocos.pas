{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
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
|* 10/04/2009: Isaque Pinheiro
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrEFDBlocos;

interface

uses
  SysUtils, Classes, DateUtils, ACBrTXTClass;

Const
  /// Código da Situação Tributária referente ao IPI.
  ipiEntradaRecuperacaoCredito = '00' ; // Entrada com recuperação de crédito
  ipiEntradaTributradaZero     = '01' ; // Entrada tributada com alíquota zero
  ipiEntradaIsenta             = '02' ; // Entrada isenta
  ipiEntradaNaoTributada       = '03' ; // Entrada não-tributada
  ipiEntradaImune              = '04' ; // Entrada imune
  ipiEntradaComSuspensao       = '05' ; // Entrada com suspensão
  ipiOutrasEntradas            = '49' ; // Outras entradas
  ipiSaidaTributada            = '50' ; // Saída tributada
  ipiSaidaTributadaZero        = '51' ; // Saída tributada com alíquota zero
  ipiSaidaIsenta               = '52' ; // Saída isenta
  ipiSaidaNaoTributada         = '53' ; // Saída não-tributada
  ipiSaidaImune                = '54' ; // Saída imune
  ipiSaidaComSuspensao         = '55' ; // Saída com suspensão
  ipiOutrasSaidas              = '99' ; // Outras saídas

  /// Código da Situação Tributária referente ao PIS.
  pisValorAliquotaNormal        = '01' ; // Operação Tributável (base de cálculo = valor da operação alíquota normal (cumulativo/não cumulativo)).
  pisValorAliquotaDiferenciada  = '02' ; // Operação Tributável (base de cálculo = valor da operação (alíquota diferenciada)).
  pisQtdeAliquotaUnidade        = '03' ; // Operação Tributável (base de cálculo = quantidade vendida x alíquota por unidade de produto).
  pisMonofaticaAliquotaZero     = '04' ; // Operação Tributável (tributação monofásica (alíquota zero)).
  pisAliquotaZero               = '06' ; // Operação Tributável (alíquota zero).
  pisIsentaContribuicao         = '07' ; // Operação Isenta da Contribuição.
  pisSemIncidenciaContribuicao  = '08' ; // Operação Sem Incidência da Contribuição.
  pisSuspensaoContribuicao      = '09' ; // Operação com Suspensão da Contribuição.
  pisOutrasOperacoes            = '99' ; // Outras Operações,

  /// Código da Situação Tributária referente ao COFINS.
  cofinsValorAliquotaNormal       = '01' ; // Operação Tributável (base de cálculo = valor da operação alíquota normal (cumulativo/não cumulativo)).
  cofinsValorAliquotaDiferenciada = '02' ; // Operação Tributável (base de cálculo = valor da operação (alíquota diferenciada)).
  cofinsQtdeAliquotaUnidade       = '03' ; // Operação Tributável (base de cálculo = quantidade vendida x alíquota por unidade de produto).
  cofinsMonofaticaAliquotaZero    = '04' ; // Operação Tributável (tributação monofásica (alíquota zero)).
  cofinsAliquotaZero              = '06' ; // Operação Tributável (alíquota zero).
  cofinsIsentaContribuicao        = '07' ; // Operação Isenta da Contribuição.
  cofinsSemIncidenciaContribuicao = '08' ; // Operação Sem Incidência da Contribuição.
  cofinsSuspensaoContribuicao     = '09' ; // Operação com Suspensão da Contribuição.
  cofinsOutrasOperacoes           = '99' ; // Outras Operações,

type
  /// Indicador de movimento - TOpenBlocos
  TACBrIndicadorMovimento = (imComDados, // 0- Bloco com dados informados;
                             imSemDados  // 1- Bloco sem dados informados.
                             );
  /// Perfil de apresentação do arquivo fiscal - TRegistro0000
  TACBrPerfil             = (pfPerfilA, // A – Perfil A
                             pfPerfilB, // B – Perfil B
                             pfPerfilC  // C – Perfil C
                             );
  /// Indicador de tipo de atividade - TRegistro0000
  TACBrAtividade          = (atIndustrial, // 0 – Industrial ou equiparado a industrial
                             atOutros      // 1 – Outros.
                             );
  /// Versão do Leiaute do arquivo - TRegistro0000
  TACBrVersaoLeiaute      = (vlVersao100,  // Código 001 - Versão 100 Ato COTEPE 01/01/2008
                             vlVersao101,  // Código 002 - Versão 101 Ato COTEPE 01/01/2009
                             vlVersao102,  // Código 003 - Versão 102 Ato COTEPE 01/01/2010
                             vlVersao103   // Código 004 - Versão 103 Ato COTEPE 01/01/2011
                             );
  /// Código da finalidade do arquivo - TRegistro0000
  TACBrCodFinalidade      = (raOriginal,     // 0 - Remessa do arquivo original
                             raSubstituto    // 1 - Remessa do arquivo substituto
                             );
  /// Tipo do item – Atividades Industriais, Comerciais e Serviços:
  TACBrTipoItem = (tiMercadoriaRevenda,    // 00 – Mercadoria para Revenda
                   tiMateriaPrima,         // 01 – Matéria-Prima;
                   tiEmbalagem,            // 02 – Embalagem;
                   tiProdutoProcesso,      // 03 – Produto em Processo;
                   tiProdutoAcabado,       // 04 – Produto Acabado;
                   tiSubproduto,           // 05 – Subproduto;
                   tiProdutoIntermediario, // 06 – Produto Intermediário;
                   tiMaterialConsumo,      // 07 – Material de Uso e Consumo;
                   tiAtivoImobilizado,     // 08 – Ativo Imobilizado;
                   tiServicos,             // 09 – Serviços;
                   tiOutrosInsumos,        // 10 – Outros Insumos;
                   tiOutras                // 99 – Outras
                   );
  /// Indicador do tipo de operação:
  TACBrTipoOperacao = (tpEntradaAquisicao, // 0 - Entrada
                       tpSaidaPrestacao    // 1 - Saída
                       );
  /// Indicador do emitente do documento fiscal
  TACBrEmitente = (edEmissaoPropria,         // 0 - Emissão própria
                   edTerceiros               // 1 - Terceiro
                   );
  /// Indicador do tipo de pagamento
  TACBrTipoPagamento = (tpVista,             // 0 - À Vista
                        tpPrazo,             // 1 - A Prazo
                        tpSemPagamento,      // 9 - Sem pagamento
                        tpNenhum             // Preencher vazio
                        );
  /// Indicador do tipo do frete
  TACBrTipoFrete = (tfPorContaTerceiros,     // 0 - Por conta de terceiros
                    tfPorContaEmitente,      // 1 - Por conta do emitente
                    tfPorContaDestinatario,  // 2 - Por conta do destinatário
                    tfSemCobrancaFrete,      // 9 - Sem cobrança de frete
                    tfNenhum                 // Preencher vazio
                    );

  /// Indicador do tipo do frete da operação de redespacho
  TACBrTipoFreteRedespacho = (frSemRedespacho,         // 0 – Sem redespacho
                              frPorContaEmitente,      // 1 - Por conta do emitente
                              frPorContaDestinatario,  // 2 - Por conta do destinatário
                              frOutros,                // 9 – Outros
                              frNenhum                 // Preencher vazio
                              );
  /// Indicador da origem do processo
  TACBrOrigemProcesso = (opSefaz,            // 0 - Sefaz
                         opJusticaFederal,   // 1 - Justiça Federal
                         opJusticaEstadual,  // 2 - Justiça Estadual
                         opSecexRFB,         // 3 - Secex/RFB
                         opOutros,           // 9 - Outros
                         opNenhum           // Preencher vazio
                         );
  ///
  TACBrDoctoArrecada = (daEstadualArrecadacao,  // 0 - Documento Estadual de Arrecadação
                        daGNRE                  // 1 - GNRE
                        );
  /// Indicador do tipo de transporte
  TACBrTipoTransporte = (ttRodoviario,         // 0 – Rodoviário
                         ttFerroviario,        // 1 – Ferroviário
                         ttRodoFerroviario,    // 2 – Rodo-Ferroviário
                         ttAquaviario,         // 3 – Aquaviário
                         ttDutoviario,         // 4 – Dutoviário
                         ttAereo,              // 5 – Aéreo
                         ttOutros              // 9 – Outros
                         );
  /// Documento de importação
  TACBrDoctoImporta = (diImportacao,           // 0 – Declaração de Importação
                       diSimplificadaImport    // 1 – Declaração Simplificada de Importação
                       );
  /// Indicador do tipo de título de crédito
  TACBrTipoTitulo = (tcDuplicata,             // 00- Duplicata
                     tcCheque,                // 01- Cheque
                     tcPromissoria,           // 02- Promissória
                     tcRecibo,                // 03- Recibo
                     tcOutros                 // 99- Outros (descrever)
                     );

  /// Movimentação física do ITEM/PRODUTO:
  TACBrMovimentacaoFisica = (mfSim,           // 0 - Sim
                             mfNao            // 1 - Não
                             );
  /// Indicador de período de apuração do IPI
  TACBrApuracaoIPI = (iaMensal,               // 0 - Mensal
                      iaDecendial             // 1 - Decendial
                      );
  /// Indicador de tipo de referência da base de cálculo do ICMS (ST) do produto farmacêutico
  TACBrTipoBaseMedicamento = (bmCalcTabeladoSugerido,           // 0 - Base de cálculo referente ao preço tabelado ou preço máximo sugerido;
                              bmCalMargemAgregado,              // 1 - Base cálculo – Margem de valor agregado;
                              bmCalListNegativa,                // 2 - Base de cálculo referente à Lista Negativa;
                              bmCalListaPositiva,               // 3 - Base de cálculo referente à Lista Positiva;
                              bmCalListNeutra                   // 4 - Base de cálculo referente à Lista Neutra
                              );
  /// Tipo Produto
  TACBrTipoProduto = (tpSimilar,   // 0 - Similar
                      tpGenerico,  // 1 - Genérico
                      tpMarca      // 2 - Ético ou de Marca
                      );
  /// Indicador do tipo da arma de fogo
  TACBrTipoArmaFogo = (tafPermitido,     // 0 - Permitido
                       tafRestrito       // 1 - Restrito
                       );
  /// Indicador do tipo de operação com veículo
  TACBrTipoOperacaoVeiculo = (tovVendaPConcess,   // 0 - Venda para concessionária
                              tovFaturaDireta,    // 1 - Faturamento direto
                              tovVendaDireta,     // 2 - Venda direta
                              tovVendaDConcess,   // 3 - Venda da concessionária
                              tovVendaOutros      // 9 - Outros
                              );
  /// Indicador do tipo de receita
  TACBrTipoReceita = (trPropria,   // 0 - Receita própria
                      trTerceiro   // 1 - Receita de terceiros
                      );
  /// Indicador do tipo do veículo transportador
  TACBrTipoVeiculo = (tvEmbarcacao,
                      tvEmpuradorRebocador
                      );
  /// Indicador do tipo da navegação
  TACBrTipoNavegacao = (tnInterior,
                        tnCabotagem
                        );
  /// Situação do Documento
  TACBrSituacaoDocto = (sdRegular,                 // 00 - Documento regular
                        sdExtempRegular,           // 01 - Escrituração extemporânea de documento regular
                        sdCancelado,               // 02 - Documento cancelado
                        sdCanceladoExtemp,         // 03 - Escrituração extemporânea de documento cancelado
                        sdDoctoDenegado,           // 04 - NF-e ou CT-e - denegado
                        sdDoctoNumInutilizada,     // 05 - NF-e ou CT-e - Numeração inutilizada
                        sdFiscalCompl,             // 06 - Documento Fiscal Complementar
                        sdExtempCompl,             // 07 - Escrituração extemporânea de documento complementar
                        sdRegimeEspecNEsp          // 08 - Documento Fiscal emitido com base em Regime Especial ou Norma Específica
                        );
  /// Indicador do tipo de tarifa aplicada:
  TACBrTipoTarifa = (tipExp,     // 0 - Exp
                     tipEnc,     // 1 - Enc
                     tipCI,      // 2 - CI
                     tipOutra    // 9 - Outra
                     );
  /// Indicador da natureza do frete
  TACBrNaturezaFrete = (nfNegociavel,      // 0 - Negociavel
                        nfNaoNegociavel    // 1 - Não Negociavel
                        );
  /// Indicador do tipo de receita
  TACBrIndTipoReceita = (recServicoPrestado,          // 0 - Receita própria - serviços prestados;
                         recCobrancaDebitos,          // 1 - Receita própria - cobrança de débitos;
                         recVendaMerc,                // 2 - Receita própria - venda de mercadorias;
                         recServicoPrePago,           // 3 - Receita própria - venda de serviço pré-pago;
                         recOutrasProprias,           // 4 - Outras receitas próprias;
                         recTerceiroCoFaturamento,    // 5 - Receitas de terceiros (co-faturamento);
                         recTerceiroOutras            // 9 - Outras receitas de terceiros
                         );
  /// Indicador do tipo de serviço prestado
  TACBrServicoPrestado = (spTelefonia,                // 0- Telefonia;
                          spComunicacaoDados,         // 1- Comunicação de dados;
                          spTVAssinatura,             // 2- TV por assinatura;
                          spAcessoInternet,           // 3- Provimento de acesso à Internet;
                          spMultimidia,               // 4- Multimídia;
                          spOutros                    // 9- Outros
                          );
  /// Indicador de movimento
  TACBrMovimentoST = (mstSemOperacaoST,   // 0 - Sem operações com ST
                      mstComOperacaoST    // 1 - Com operações de ST
                      );
  /// Indicador do tipo de ajuste
  TACBrTipoAjuste = (ajDebito,            // 0 - Ajuste a débito;
                     ajCredito            // 1- Ajuste a crédito
                     );
  /// Indicador da origem do documento vinculado ao ajuste
  TACBrOrigemDocto = (odPorcessoJudicial, // 0 - Processo Judicial;
                      odProcessoAdminist, // 1 - Processo Administrativo;
                      odPerDcomp,         // 2 - PER/DCOMP;
                      odOutros            //9 – Outros.
                      );
  /// Indicador de propriedade/posse do item
  TACBrPosseItem = (piInformante,           // 0- Item de propriedade do informante e em seu poder;
                    piInformanteNoTerceiro, // 1- Item de propriedade do informante em posse de terceiros;
                    piTerceiroNoInformante  // 2- Item de propriedade de terceiros em posse do informante
                    );
  /// Informe o tipo de documento
  TACBrTipoDocto = (docDeclaracaoExportacao,           // 0 - Declaração de Exportação;
                    docDeclaracaoSimplesExportacao     // 1 - Declaração Simplificada de Exportação.
                    );
  /// Preencher com
  TACBrExportacao = (exDireta,             // 0 - Exportação Direta
                     exIndireta            // 1 - Exportação Indireta
                     );
  /// Informação do tipo de conhecimento de embarque
  TACBrConhecEmbarque = (ceAWB,            //01 – AWB;
                         ceMAWB,           //02 – MAWB;
                         ceHAWB,           //03 – HAWB;
                         ceCOMAT,          //04 – COMAT;
                         ceRExpressas,     //06 – R. EXPRESSAS;
                         ceEtiqREspressas, //07 – ETIQ. REXPRESSAS;
                         ceHrExpressas,    //08 – HR. EXPRESSAS;
                         ceAV7,            //09 – AV7;
                         ceBL,             //10 – BL;
                         ceMBL,            //11 – MBL;
                         ceHBL,            //12 – HBL;
                         ceCTR,            //13 – CRT;
                         ceDSIC,           //14 – DSIC;
                         ceComatBL,        //16 – COMAT BL;
                         ceRWB,            //17 – RWB;
                         ceHRWB,           //18 – HRWB;
                         ceTifDta,         //19 – TIF/DTA;
                         ceCP2,            //20 – CP2;
                         ceNaoIATA,        //91 – NÂO IATA;
                         ceMNaoIATA,       //92 – MNAO IATA;
                         ceHNaoIATA,       //93 – HNAO IATA;
                         ceCOutros         //99 – OUTROS.
                         );
  /// Identificador de medição
  TACBrMedicao = (medAnalogico,            // 0 - analógico;
                  medDigital               // 1 – digital
                  );
  /// Tipo de movimentação do bem ou componente
  TACBrMovimentoBens = (mbcSI,             // SI = Saldo inicial de bens imobilizados
                        mbcIM,             // IM = Imobilização de bem individual
                        mbcIA,             // IA = Imobilização em Andamento - Componente
                        mbcCI,             // CI = Conclusão de Imobilização em Andamento – Bem Resultante
                        mbcMC,             // MC = Imobilização oriunda do Ativo Circulante
                        mbcBA,             // BA = Baixa do Saldo de ICMS - Fim do período de apropriação
                        mbcAT,             // AT = Alienação ou Transferência
                        mbcPE,             // PE = Perecimento, Extravio ou Deterioração
                        mbcOT              // OT = Outras Saídas do Imobilizado
                        );
  /// Código de grupo de tensão
  TACBrGrupoTensao = (gtA1,          // 01 - A1 - Alta Tensão (230kV ou mais)
                      gtA2,          // 02 - A2 - Alta Tensão (88 a 138kV)
                      gtA3,          // 03 - A3 - Alta Tensão (69kV)
                      gtA3a,         // 04 - A3a - Alta Tensão (30kV a 44kV)
                      gtA4,          // 05 - A4 - Alta Tensão (2,3kV a 25kV)
                      gtAS,          // 06 - AS - Alta Tensão Subterrâneo 06
                      gtB107,        // 07 - B1 - Residencial 07
                      gtB108,        // 08 - B1 - Residencial Baixa Renda 08
                      gtB209,        // 09 - B2 - Rural 09
                      gtB2Rural,     // 10 - B2 - Cooperativa de Eletrificação Rural
                      gtB2Irrigacao, // 11 - B2 - Serviço Público de Irrigação
                      gtB3,          // 12 - B3 - Demais Classes
                      gtB4a,         // 13 - B4a - Iluminação Pública - rede de distribuição
                      gtB4b          // 14 - B4b - Iluminação Pública - bulbo de lâmpada
                      );
  /// Código de classe de consumo de energia elétrica ou gás
  TACBrClasseConsumo = (ccComercial,         // 01 - Comercial
                        ccConsumoProprio,    // 02 - Consumo Próprio
                        ccIluminacaoPublica, // 03 - Iluminação Pública
                        ccIndustrial,        // 04 - Industrial
                        ccPoderPublico,      // 05 - Poder Público
                        ccResidencial,       // 06 - Residencial
                        ccRural,             // 07 - Rural
                        ccServicoPublico     // 08 -Serviço Público
                        );
  /// Código de tipo de Ligação
  TACBrTipoLigacao = (tlMonofasico,          // 1 - Monofásico
                      tlBifasico,            // 2 - Bifásico
                      tlTrifasico            // 3 - Trifásico
                      );
  /// Código dispositivo autorizado
  TACBrDispositivo = (cdaFormSeguranca,  // 00 - Formulário de Segurança
                      cdaFSDA,           // 01 - FS-DA – Formulário de Segurança para Impressão de DANFE
                      cdaNFe,            // 02 – Formulário de segurança - NF-e
                      cdaFormContinuo,   // 03 - Formulário Contínuo
                      cdaBlocos,         // 04 – Blocos
                      cdaJogosSoltos     // 05 - Jogos Soltos
                      );
  /// Código do Tipo de Assinante
  TACBrTipoAssinante = (assComercialIndustrial,    // 1 - Comercial/Industrial
                        assPodrPublico,            // 2 - Poder Público
                        assResidencial,            // 3 - Residencial/Pessoa física
                        assPublico,                // 4 - Público
                        assSemiPublico,            // 5 - Semi-Público
                        assOutros                  // 6 - Outros
                        );



  TOpenBlocos = class
  private
    FIND_MOV: TACBrIndicadorMovimento;    /// Indicador de movimento: 0- Bloco com dados informados, 1- Bloco sem dados informados.
  public
    property IND_MOV: TACBrIndicadorMovimento read FIND_MOV write FIND_MOV;
  end;

implementation

{ TOpenBlocos }

end.
