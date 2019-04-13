////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org/nfe                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordenação: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
// Desenvolvimento                                                            //
//         de Cte: Wiliam Zacarias da Silva Rosa                              //
//                                                                            //
//      Versão: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licença: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa é software livre; você pode redistribuí-lo    //
//              e/ou modificá-lo sob os termos da Licença Pública Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              versão 2 da Licença como (a seu critério) qualquer versão     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa é distribuído na expectativa de ser útil,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia implícita de  //
//              COMERCIALIZAÇÃO ou de ADEQUAÇÃO A QUALQUER PROPÓSITO EM       //
//              PARTICULAR. Consulte a Licença Pública Geral GNU para obter   //
//              mais detalhes. Você deve ter recebido uma cópia da Licença    //
//              Pública Geral GNU junto com este programa; se não, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licença oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licença  não  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  NFe", não  podendo o mesmo ser    //
//              utilizado sem previa autorização.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manutenção deste cabeçalho junto ao código     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

unit pcnConversao;

interface uses

  SysUtils,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  Classes;

type

  TStatusACBrNFe = ( stIdle, stNFeStatusServico, stNFeRecepcao, stNFeRetRecepcao, stNFeConsulta, stNFeCancelamento, stNFeInutilizacao, stNFeRecibo, stNFeCadastro, stNFeEmail, stNFeEnvDPEC, stNFeConsultaDPEC );
  TStatusACBrCTe = ( stCTeIdle, stCTeStatusServico, stCTeRecepcao, stCTeRetRecepcao, stCTeConsulta, stCTeCancelamento, stCTeInutilizacao, stCTeRecibo, stCTeCadastro, stCTeEmail );
  (* IMPORTANTE - Sempre que alterar um Tipo efetuar a atualização das funções de conversão correspondentes *)
  TLayOut = (LayNfeRecepcao,LayNfeRetRecepcao,LayNfeCancelamento,LayNfeInutilizacao,LayNfeConsulta,LayNfeStatusServico,LayNfeCadastro, LayNfeEnvDPEC, LayNfeConsultaDPEC,
             LayCTeRecepcao,LayCTeRetRecepcao,LayCTeCancelamento,LayCTeInutilizacao,LayCTeConsultaCT,LayCTeStatusServico,LayCTeCadastro );

  TpcnSchema = (TsPL005c);
  // Incluido tlConsStatServCTe para o CTe por possuir versão diferente da NFe
  TpcnTipoLayout = (tlAtuCadEmiDFe, tlCadEmiDFe, tlCancNFe, tlConsCad, tlConsReciNFe, tlConsSitNFe, tlConsStatServ,
    tlInutNFe, tlNFe, tlProcNFe, tlProcInutNFe, tlRetAtuCadEmiDFe, tlRetCancNFe, tlRetConsCad, tlRetConsReciNFe,
    tlRetConsStatServ, tlRetConsSitNFe, tlRetEnvNFe, tlRetInutNFe, tlEnvNFe, tlProcCancNFe,
                    tlCancCTe, tlConsReciCTe, tlConsSitCTe,
    tlInutCTe, tlCTe, tlProcCTe, tlProcInutCTe, tlRetCancCTe, tlRetConsReciCTe,
    tlRetConsSitCTe, tlRetEnvCTe, tlRetInutCTe, tlEnvCTe, tlProcCancCTe, tlEnvDPEC, tlConsDPEC, tlConsStatServCTe);

  // Tipo tcDe6 incluido por Italo em 30/09/2010 (usado no CTe campo 435: vTar = valor da tarifa do modal Dutoviário)
  TpcnTipoCampo = (tcStr, tcInt, tcDat, tcDatHor, tcEsp, tcDe2, tcDe3, tcDe4, tcDe6 ); // tcEsp = String: somente numeros;
  TpcnFormatoGravacao = (fgXML, fgTXT);
  TpcnTagAssinatura = (taSempre, taNunca, taSomenteSeAssinada, taSomenteParaNaoAssinada);

  TpcnIndicadorPagamento = (ipVista, ipPrazo, ipOutras);
  TpcnTipoNFe = (tnEntrada, tnSaida);
  TpcnTipoImpressao = (tiRetrato, tiPaisagem);
  TpcnTipoEmissao = (teNormal, teContingencia, teSCAN, teDPEC, teFSDA);
  TpcnTipoAmbiente = (taProducao, taHomologacao);
  TpcnSituacaoEmissor = (seHomologacao, seProducao);
  TpcnFinalidadeNFe = (fnNormal, fnComplementar, fnAjuste);
  TpcnProcessoEmissao = (peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco);
  TpcnTipoOperacao = (toVendaConcessionaria, toFaturamentoDireto, toVendaDireta, toOutros);
  TpcnCondicaoVeiculo = (cvAcabado, cvInacabado, cvSemiAcabado);
  TpcnTipoArma = (taUsoPermitido, taUsoRestrito);
  TpcnOrigemMercadoria = (oeNacional, oeEstrangeiraImportacaoDireta, oeEstrangeiraAdquiridaBrasil);
  TpcnCSTIcms = (cst00, cst10, cst20, cst30, cst40, cst41, cst45, cst50, cst51, cst60, cst70, cst80, cst81, cst90); //80 e 81 apenas para CTe
  TpcnDeterminacaoBaseIcms = (dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao);
  TpcnDeterminacaoBaseIcmsST = (dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra, dbisMargemValorAgregado, dbisPauta);
  TpcnCstIpi = (ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55);
  TpcnCstPis = (pis01, pis02, pis03, pis04, pis06, pis07, pis08, pis09, pis99);
  TpcnCstCofins = (cof01, cof02, cof03, cof04, cof06, cof07, cof08, cof09, cof99);
  TpcnModalidadeFrete = (mfContaEmitente, mfContaDestinatario);
  TpcnIndicadorProcesso = (ipSEFAZ, ipJusticaFederal, ipJusticaEstadual, ipSecexRFB, ipOutros);

  TpcteFormaPagamento = (fpPago, fpAPagar, fpOutros);
  TpcteTipoCTe = (tcNormal, tcComplemento, tcAnulacao, tcSubstituto);
  TpcteModal = (mdRodoviario, mdAereo, mdAquaviario, mdFerroviario, mdDutoviario);
  TpcteTipoServico = (tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario);
  TpcteRetira = (rtSim, rtNao);
  TpcteTomador = ( tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros);
  TpcteRspSeg = (rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario, rsEmitenteCTe, rsTomadorServico);
  TpcteLotacao = (ltNao, ltSim);
  TpcteProp = (tpTACAgregado, tpTACIndependente, tpOutros);
  TpcteMask = (msk4x2, msk7x2, msk9x2, msk10x2, msk13x2, msk15x2, msk6x3, mskAliq);
  UnidMed = (uM3,uKG, uTON, uUNIDADE, uLITROS);

  // Incluido por Italo em 31/09/2010
  TpcteDirecao = (drNorte, drLeste, drSul, drOeste);
  TpcteTipoNavegacao = (tnInterior, tnCabotagem);
  // Incluido por Italo em 19/11/2010
  TpcteTipoTrafego = (ttProprio, ttMutuo, ttRodoferroviario, ttRodoviario);
  // Incluido por Italo em 24/01/2011
  TpcteTipoDataPeriodo = (tdSemData, tdNaData, tdAteData, tdApartirData, tdNoPeriodo);
  TpcteTipoHorarioIntervalo = (thSemHorario, thNoHorario, thAteHorario, thApartirHorario, thNoIntervalo);
  TpcteTipoDocumento = (tdDeclaracao, tdOutros);
  TpcteTipoDocumentoAnterior = (daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN, daCTMC, daATRE, daDTA, daCAI, daCCPI, daCA, daTIF, daOutros);
  TpcteRspPagPedagio = (rpEmitente, rpRemetente, rpExpedidor, rpRecebedor, rpDestinatario, rpTomadorServico);
  TpcteTipoDispositivo = (tdCartaoMagnetico, tdTAG, tdTicket);
  TpcteTipoPropriedade = (tpProprio, tpTerceiro);
  TpcteTipoVeiculo = (tvTracao, tvReboque);
  TpcteTipoRodado = (trNaoAplicavel, trTruck, trToco, trCavaloMecanico, trVAN, trUtilitario, trOutros);
  TpcteTipoCarroceria = (tcNaoAplicavel, tcAberta, tcFechada, tcGraneleira, tcPortaContainer, tcSider);
  // Incluido por Italo em 28/04/2011
  TPosRecibo = (prCabecalho, prRodape);

const
  NFeUF: array[0..26] of String =
  ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA',
   'PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO');
  NFeUFCodigo: array[0..26] of Integer =
  (12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17);
  
  NfVersao        = '1.0.0.0';
  NFecabMsg       = '1.02';
  NFeconsStatServ = '1.07';
  NFenviNFe       = '1.10';
  NFeconsReciNFe  = '1.10';
  NFeconsSitNFe   = '1.07';
  NFecancNFe      = '1.07';
  NFeinutNFe      = '1.07';
  NFeconsCad      = '1.01';
  NFeEnvDPEC      = '1.01';
  NFeConsDPEC     = '1.01';  

  CTecabMsg       = '1.02';//1.02
  CTeconsStatServ = '1.03';//1.01
  CTeenviCTe      = '1.03';//1.02  // Nome da constante corrigita por Italo em 21/03/2011
  CTeconsReciCTe  = '1.03';//1.02
  CTeconsSitCTe   = '1.03';//1.02
  CTecancCTe      = '1.03';//1.01
  CTeinutCTe      = '1.03';//1.01
  CTeconsCad      = '1.01';        // Incluido por Italo em 21/03/2011
//  CTeEnvDPEC      = '1.01';
//  CTeConsDPEC     = '1.01';

  LineBreak = #13#10;

function StrToEnumerado(var ok: boolean; const s: string; const AString: array of string;
  const AEnumerados: array of variant): variant;
function EnumeradoToStr(const t: variant; const AString:
  array of string; const AEnumerados: array of variant): variant;

function SchemaToStr(const t: TpcnSchema): string;
function StrToSchema(var ok: boolean; const s: string): TpcnSchema;
function TipoLayoutToStr(const t: TpcnTipoLayout): string;
function StrToTipoLayout(var ok: boolean; const s: string): TpcnTipoLayout;
function IndpagToStr(const t: TpcnIndicadorPagamento): string;
function StrToIndpag(var ok: boolean; const s: string): TpcnIndicadorPagamento;
function tpNFToStr(const t: TpcnTipoNFe): string;
function StrToTpNF(var ok: boolean; const s: string): TpcnTipoNFe;
function TpImpToStr(const t: TpcnTipoImpressao): string;
function StrToTpImp(var ok: boolean; const s: string): TpcnTipoImpressao;
function TpEmisToStr(const t: TpcnTipoEmissao): string;
function StrToTpEmis(var ok: boolean; const s: string): TpcnTipoEmissao;
function TpAmbToStr(const t: TpcnTipoAmbiente): string;
function StrToTpAmb(var ok: boolean; const s: string): TpcnTipoAmbiente;
function TpSitToStr(const t: TpcnSituacaoEmissor): string;
function StrToTpSit(var ok: boolean; const s: string): TpcnSituacaoEmissor;
function FinNFeToStr(const t: TpcnFinalidadeNFe): string;
function StrToFinNFe(var ok: boolean; const s: string): TpcnFinalidadeNFe;
function procEmiToStr(const t: TpcnProcessoEmissao): string;
function StrToprocEmi(var ok: boolean; const s: string): TpcnProcessoEmissao;
function tpOPToStr(const t: TpcnTipoOperacao): string;
function StrTotpOP(var ok: boolean; const s: string): TpcnTipoOperacao;
function condVeicToStr(const t: TpcnCondicaoVeiculo): string;
function StrTocondVeic(var ok: boolean; const s: string): TpcnCondicaoVeiculo;
function tpArmaToStr(const t: TpcnTipoArma): string;
function StrTotpArma(var ok: boolean; const s: string): TpcnTipoArma;
function OrigToStr(const t: TpcnOrigemMercadoria): string;
function StrToOrig(var ok: boolean; const s: string): TpcnOrigemMercadoria;
function CSTICMSToStr(const t: TpcnCSTIcms): string;
function StrToCSTICMS(var ok: boolean; const s: string): TpcnCSTIcms;
function CSTICMSToStrTagPos(const t: TpcnCSTIcms): string;
function CSTICMSToStrTagPosText(const t: TpcnCSTIcms): string;

function modBCToStr(const t: TpcnDeterminacaoBaseIcms): string;
function StrTomodBC(var ok: boolean; const s: string): TpcnDeterminacaoBaseIcms;
function modBCSTToStr(const t: TpcnDeterminacaoBaseIcmsST): string;
function StrTomodBCST(var ok: boolean; const s: string): TpcnDeterminacaoBaseIcmsST;
function CSTIPIToStr(const t: TpcnCstIpi): string;
function StrToCSTIPI(var ok: boolean; const s: string): TpcnCstIpi;
function CSTPISToStr(const t: TpcnCstPIS): string;
function StrToCSTPIS(var ok: boolean; const s: string): TpcnCstPIS;
function CSTCOFINSToStr(const t: TpcnCstCOFINS): string;
function StrToCSTCOFINS(var ok: boolean; const s: string): TpcnCstCOFINS;
function modFreteToStr(const t: TpcnModalidadeFrete): string;
function StrTomodFrete(var ok: boolean; const s: string): TpcnModalidadeFrete;
function indProcToStr(const t: TpcnIndicadorProcesso): string;
function StrToindProc(var ok: boolean; const s: string): TpcnIndicadorProcesso;
function tpforPagToStr(const t: TpcteFormaPagamento): string;
function tpforPagToStrText(const t: TpcteFormaPagamento): string;
function StrTotpforPag(var ok: boolean; const s: string): TpcteFormaPagamento;
function tpCTePagToStr(const t: TpcteTipoCTe): string;
function tpCTToStr(const t: TpcteTipoCTe): string;
function tpCTToStrText(const t: TpcteTipoCTe): string;
function StrTotpCTe(var ok: boolean; const s: string): TpcteTipoCTe;
function TpModalToStr(const t: TpcteModal): string;
function TpModalToStrText(const t: TpcteModal): string;
function StrToTpModal(var ok: boolean; const s: string): TpcteModal;
function TpServPagToStr(const t: TpcteTipoServico): string;
function TpServToStrText(const t: TpcteTipoServico): string;
function StrToTpServ(var ok: boolean; const s: string): TpcteTipoServico;
function TpRetiraPagToStr(const t: TpcteRetira): string;
function StrToTpRetira(var ok: boolean; const s: string): TpcteRetira;
function TpTomadorPagToStr(const t: TpcteTomador): string;
function TpTomadorToStr(const t: TpcteTomador): String;
function TpTomadorToStrText(const t: TpcteTomador): String;
function TpRspSeguroToStr(const t: TpcteRspSeg): String;
function TpRspSeguroToStrText(const t: TpcteRspSeg): String;
function TpLotacaoToStr(const t: TpcteLotacao): string;
function TpPropToStr(const t: TpcteProp): String;
function UnidMedToStr(const t: UnidMed): string;
function StrToTpTomador(var ok: boolean; const s: String ): TpcteTomador;
function StrToTpRspSeguro(var ok: boolean; const s: String ): TpcteRspSeg;
function StrToTpLotacao(var ok: boolean; const s: String ): TpcteLotacao;
function StrToTpProp(var ok: boolean; const s: String ): TpcteProp;
function StrToUnidMed(var ok: boolean; const s: String ): UnidMed;
function TpMaskToStrText(const t: TpcteMask): string;
function StrToTpMask(var ok: boolean; const s: string): TpcteMask;

  // Incluido por Italo em 31/09/2010
function TpDirecaoToStr(const t: TpcteDirecao): string;
function StrToTpDirecao(var ok: boolean; const s: string): TpcteDirecao;
function TpNavegacaoToStr(const t: TpcteTipoNavegacao): string;
function StrToTpNavegacao(var ok: boolean; const s: string): TpcteTipoNavegacao;

  // Incluido por Italo em 19/11/2010
function TpTrafegoToStr(const t: TpcteTipoTrafego): string;
function StrToTpTrafego(var ok: boolean; const s: string): TpcteTipoTrafego;

  // Incluido por Italo em 25/01/2011
function TpDataPeriodoToStr(const t: TpcteTipoDataPeriodo): string;
function StrToTpDataPeriodo(var ok: boolean; const s: string): TpcteTipoDataPeriodo;
function TpHorarioIntervaloToStr(const t: TpcteTipoHorarioIntervalo): string;
function StrToTpHorarioIntervalo(var ok: boolean; const s: string): TpcteTipoHorarioIntervalo;
function TpDocumentoToStr(const t: TpcteTipoDocumento): string;
function StrToTpDocumento(var ok: boolean; const s: string): TpcteTipoDocumento;
function TpDocumentoAnteriorToStr(const t: TpcteTipoDocumentoAnterior): string;
function StrToTpDocumentoAnterior(var ok: boolean; const s: string): TpcteTipoDocumentoAnterior;
function RspPagPedagioToStr(const t: TpcteRspPagPedagio): string;
function StrToRspPagPedagio(var ok: boolean; const s: string): TpcteRspPagPedagio;
function TpDispositivoToStr(const t: TpcteTipoDispositivo): string;
function StrToTpDispositivo(var ok: boolean; const s: string): TpcteTipoDispositivo;
function TpPropriedadeToStr(const t: TpcteTipoPropriedade): string;
function StrToTpPropriedade(var ok: boolean; const s: string): TpcteTipoPropriedade;
function TpVeiculoToStr(const t: TpcteTipoVeiculo): string;
function StrToTpVeiculo(var ok: boolean; const s: string): TpcteTipoVeiculo;
function TpRodadoToStr(const t: TpcteTipoRodado): string;
function StrToTpRodado(var ok: boolean; const s: string): TpcteTipoRodado;
function TpCarroceriaToStr(const t: TpcteTipoCarroceria): string;
function StrToTpCarroceria(var ok: boolean; const s: string): TpcteTipoCarroceria;

implementation

function StrToEnumerado(var ok: boolean; const s: string; const AString:
  array of string; const AEnumerados: array of variant): variant;
var
  i: integer;
begin
  result := -1;
  for i := Low(AString) to High(AString) do
    if AnsiSameText(s, AString[i]) then
      result := AEnumerados[i];
  ok := result <> -1;
  if not ok then
    result := AEnumerados[0];
end;

function EnumeradoToStr(const t: variant; const AString:
  array of string; const AEnumerados: array of variant): variant;
var
  i: integer;
begin
  result := '';
  for i := Low(AEnumerados) to High(AEnumerados) do
    if t = AEnumerados[i] then
      result := AString[i];
end;

// Tipo de Schema **************************************************************

function SchemaToStr(const t: TpcnSchema): string;
begin
  result := EnumeradoToStr(t, ['PL005C'], [TsPL005c]);
end;

function StrToSchema(var ok: boolean; const s: string): TpcnSchema;
begin
  result := StrToEnumerado(ok, s, ['PL005C'], [TsPL005c]);
end;

// Tipo do Layout **************************************************************

function TipoLayoutToStr(const t: TpcnTipoLayout): string;
begin
  result := EnumeradoToStr(t, ['AtuCadEmiDFe', 'CadEmiDFe', 'CancNFe', 'ConsCad', 'ConsReciNFe', 'ConsSitNFe', 'ConsStatServ',
    'InutNFe', 'NFe', 'ProcNFe', 'ProcInutNFe', 'RetAtuCadEmiDFe', 'RetCancNFe', 'RetConsCad', 'RetConsReciNFe',
      'RetConsStatServ', 'RetConsSitNFe', 'RetEnvNFe', 'RetInutNFe', 'EnvNFe', 'ProcCancNFe', 'ConsStatServ'],
      [tlAtuCadEmiDFe, tlCadEmiDFe, tlCancCTe, tlConsCad, tlConsReciCTe, tlConsSitCTe, tlConsStatServ,
    tlInutCTe, tlCTe, tlProcCTe, tlProcInutCTe, tlRetAtuCadEmiDFe, tlRetCancCTe, tlRetConsCad, tlRetConsReciCTe,
      tlRetConsStatServ, tlRetConsSitCTe, tlRetEnvCTe, tlRetInutCTe, tlEnvCTe, tlProcCancCTe, tlConsStatServCTe]);
end;

function StrToTipoLayout(var ok: boolean; const s: string): TpcnTipoLayout;
begin
  result := StrToEnumerado(ok, s, ['AtuCadEmiDFe', 'CadEmiDFe', 'CancNFe', 'ConsCad', 'ConsReciNFe', 'ConsSitNFe', 'ConsStatServ',
    'InutNFe', 'NFe', 'ProcNFe', 'ProcInutNFe', 'RetAtuCadEmiDFe', 'RetCancNFe', 'RetConsCad', 'RetConsReciNFe',
      'RetConsStatServ', 'RetConsSitNFe', 'RetEnvNFe', 'RetInutNFe', 'EnvNFe', 'ConsStatServ'],
      [tlAtuCadEmiDFe, tlCadEmiDFe, tlCancCTe, tlConsCad, tlConsReciCTe, tlConsSitCTe, tlConsStatServ,
    tlInutCTe, tlCTe, tlProcCTe, tlProcInutCTe, tlRetAtuCadEmiDFe, tlRetCancCTe, tlRetConsCad, tlRetConsReciCTe,
      tlRetConsStatServ, tlRetConsSitCTe, tlRetEnvCTe, tlRetInutCTe, tlEnvCTe, tlConsStatServCTe]);
end;

// Indicador do Tipo de pagamento **********************************************

function IndpagToStr(const t: TpcnIndicadorPagamento): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2'], [ipVista, ipPrazo, ipOutras]);
end;

function StrToIndpag(var ok: boolean; const s: string): TpcnIndicadorPagamento;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'], [ipVista, ipPrazo, ipOutras]);
end;

// B11 - Tipo do Documento Fiscal **********************************************

function tpNFToStr(const t: TpcnTipoNFe): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [tnEntrada, tnSaida]);
end;

function tpCTToStr(const t: TpcteTipoCTe): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3'], [tcNormal, tcComplemento, tcAnulacao, tcSubstituto]);
end;

function tpCTToStrText(const t: TpcteTipoCTe): string;
begin
  result := EnumeradoToStr(t, ['NORMAL', 'COMPLEMENTO', 'ANULAÇÃO', 'SUBSTITUTO'], [tcNormal, tcComplemento, tcAnulacao, tcSubstituto]);
end;

function StrToTpNF(var ok: boolean; const s: string): TpcnTipoNFe;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [tnEntrada, tnSaida]);
end;

// B21 - Formato de Impressão do DANFE *****************************************

function TpImpToStr(const t: TpcnTipoImpressao): string;
begin
  result := EnumeradoToStr(t, ['1', '2'], [tiRetrato, tiPaisagem]);
end;

function TpMaskToStrText(const t: TpcteMask): string;
begin
  result := EnumeradoToStr(t, ['#,##0.00', '#,###,##0.00', '###,###,##0.00', '#,###,###,##0.00', '#,###,###,###,##0.00', '###,###,###,###,##0.00', '###,##0.000', '#00%'],
    [msk4x2, msk7x2, msk9x2, msk10x2, msk13x2, msk15x2, msk6x3, mskAliq]);
end;

function StrToTpMask(var ok: boolean; const s: string): TpcteMask;
begin
  result := StrToEnumerado(ok, s, ['#,##0.00', '#,###,##0.00', '#,###,###,##0.00', '#,###,###,###,##0.00', '###,###,###,###,##0.00', '###,##0.000', '#00%'],
    [msk4x2, msk7x2, msk10x2, msk13x2, msk15x2, msk6x3, mskAliq]);
end;

function StrToTpImp(var ok: boolean; const s: string): TpcnTipoImpressao;
begin
  result := StrToEnumerado(ok, s, ['1', '2'], [tiRetrato, tiPaisagem]);
end;

// B22 - Forma de Emissão da NF-e **********************************************

function TpEmisToStr(const t: TpcnTipoEmissao): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5'], [teNormal, teContingencia, teSCAN, teDPEC, teFSDA]);
end;

function StrToTpEmis(var ok: boolean; const s: string): TpcnTipoEmissao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5'], [teNormal, teContingencia, teSCAN, teDPEC, teFSDA]);
end;

// B24 - Identificação do Ambiente *********************************************

function TpAmbToStr(const t: TpcnTipoAmbiente): string;
begin
  result := EnumeradoToStr(t, ['1', '2'], [taProducao, taHomologacao]);
end;

function StrToTpAmb(var ok: boolean; const s: string): TpcnTipoAmbiente;
begin
  result := StrToEnumerado(ok, s, ['1', '2'], [taProducao, taHomologacao]);
end;

// *** - Situacao Emissor ******************************************************

function TpSitToStr(const t: TpcnSituacaoEmissor): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [seHomologacao, seProducao]);
end;

function StrToTpSit(var ok: boolean; const s: string): TpcnSituacaoEmissor;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [seHomologacao, seProducao]);
end;

// B25 - Finalidade de emissão da NF-e *****************************************

function FinNFeToStr(const t: TpcnFinalidadeNFe): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'], [fnNormal, fnComplementar, fnAjuste]);
end;

function StrToFinNFe(var ok: boolean; const s: string): TpcnFinalidadeNFe;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'], [fnNormal, fnComplementar, fnAjuste]);
end;

// B26 - Processo de emissão da NF-e *******************************************

function procEmiToStr(const t: TpcnProcessoEmissao): string;
begin
  // 0 - emissão de NF-e com aplicativo do contribuinte;
  // 1 - emissão de NF-e avulsa pelo Fisco;
  // 2 - emissão de NF-e avulsa, pelo contribuinte com seu certificado digital, através do site do Fisco;
  // 3 - emissão NF-e pelo contribuinte com aplicativo fornecido pelo Fisco.
  result := EnumeradoToStr(t, ['0', '1', '2', '3'], [peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco]);
end;

function StrToprocEmi(var ok: boolean; const s: string): TpcnProcessoEmissao;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3'], [peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco]);
end;

// J02 - Tipo da operação ******************************************************

function tpOPToStr(const t: TpcnTipoOperacao): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '0'], [toVendaConcessionaria, toFaturamentoDireto, toVendaDireta, toOutros]);
end;

function StrTotpOP(var ok: boolean; const s: string): TpcnTipoOperacao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '0'], [toVendaConcessionaria, toFaturamentoDireto, toVendaDireta, toOutros]);
end;

// J22 - Condição do Veículo ***************************************************

function condVeicToStr(const t: TpcnCondicaoVeiculo): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'], [cvAcabado, cvInacabado, cvSemiAcabado]);
end;

function StrTocondVeic(var ok: boolean; const s: string): TpcnCondicaoVeiculo;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'], [cvAcabado, cvInacabado, cvSemiAcabado]);
end;

// L02 - Indicador do tipo de arma de fogo *************************************

function tpArmaToStr(const t: TpcnTipoArma): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [taUsoPermitido, taUsoRestrito]);
end;

function StrTotpArma(var ok: boolean; const s: string): TpcnTipoArma;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [taUsoPermitido, taUsoRestrito]);
end;

// N11 - Origem da mercadoria **************************************************

function OrigToStr(const t: TpcnOrigemMercadoria): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2'], [oeNacional, oeEstrangeiraImportacaoDireta, oeEstrangeiraAdquiridaBrasil]);
end;

function StrToOrig(var ok: boolean; const s: string): TpcnOrigemMercadoria;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'], [oeNacional, oeEstrangeiraImportacaoDireta, oeEstrangeiraAdquiridaBrasil]);
end;

// CST ICMS ********************************************************************

function CSTICMSToStr(const t: TpcnCSTIcms): string;
begin
  // ID -> N02 - Tributada integralmente
  // ID -> N03 - Tributada e com cobrança do ICMS por substituição tributária
  // ID -> N04 - Com redução de base de cálculo
  // ID -> N05 - Isenta ou não tributada e com cobrança do ICMS por substituição tributária
  // ID -> N06 - Isenta
  // ID -> N06 - Não tributada
  // ID -> N06 - Suspensão
  // ID -> N07 - Diferimento A exigência do preenchimento das informações do ICMS diferido fica à critério de cada UF.
  // ID -> N08 - ICMS cobrado anteriormente por substituição
  // ID -> N09 - Com redução de base de cálculo e cobrança do ICMS por substituição tributária
  // ID -> N10 - ICMS pagto atribuído ao tomador ou ao terceiro previsto na legislação p/ ST
  // ID -> N11 - ICMS devido para outras UF
  // ID -> N12 - Outros
  result := EnumeradoToStr(t, ['00', '10', '20', '30', '40', '41', '50', '51', '60', '70', '80', '81', '90'],
    [cst00, cst10, cst20, cst30, cst40, cst41, cst50, cst51, cst60, cst70, cst80, cst81, cst90]);
end;

// A função abaixo foi alterada em 13/05/2010 por: Italo Jurisato Junior
// Foi incluido '80', '81', e cst80, cst81,
// Para ficar compativel com a função: CSTICMSToStr, logo acima
function StrToCSTICMS(var ok: boolean; const s: string): TpcnCSTIcms;
begin
  result := StrToEnumerado(ok, s, ['00', '10', '20', '30', '40', '41', '50', '51', '60', '70', '80', '81', '90'],
    [cst00, cst10, cst20, cst30, cst40, cst41, cst50, cst51, cst60, cst70, cst80, cst81, cst90]);
end;

// A função abaixo foi alterada em 13/05/2010 por: Italo Jurisato Junior
// Foi incluido '11', '12', e cst80, cst81,
// Para ficar compativel com a função: CSTICMSToStr, logo acima
function CSTICMSToStrTagPos(const t: TpcnCSTIcms): string;
begin
  result := EnumeradoToStr(t, ['02', '03', '04', '05', '06', '06', '06', '07', '08', '09', '10', '11', '12'],
    [cst00, cst10, cst20, cst30, cst40, cst41, cst50, cst51, cst60, cst70, cst80, cst81, cst90]);
end;

// A função abaixo foi alterada em 13/05/2010 por: Italo Jurisato Junior
// As linhas alteradas estão comentadas
function CSTICMSToStrTagPosText(const t: TpcnCSTIcms): string;
begin
  result := EnumeradoToStr(t, ['PRESTAÇÃO SUJEITO À TRIBUTAÇÃO NORMAL ICMS',
    '10',
    'PRESTAÇÃO SUJEITO À TRIBUTAÇÃO COM BC REDUZIDA DO ICMS',
    '30',
    'ICMS ISENTO, NÃO TRIBUTADO OU DEFERIDO',
    'ICMS ISENTO, NÃO TRIBUTADO OU DEFERIDO',
    'ICMS ISENTO, NÃO TRIBUTADO OU DEFERIDO',
    '50',
    'ICMS ISENTO, NÃO TRIBUTADO OU DEFERIDO', // '51' alterado para o CT-e
    '60',                                     // foi incluido pois esta faltando
    '70',
    'RESPONSABILIDADE DO RECOLHIMENTO DO ICMS ATRIBUÍDO AO TOMADOR OU 3° POR ST',
    'ICMS DEVICO À OUTRA UF',
    'ICMS OUTROS'],
    [cst00, cst10, cst20, cst30, cst40, cst41, cst45, cst50, cst51, cst60, cst70, cst80, cst81, cst90]);
end;

// N13 - Modalidade de determinação da BC do ICMS ******************************

function modBCToStr(const t: TpcnDeterminacaoBaseIcms): string;
begin
  // 0 - Margem Valor Agregado (%);
  // 1 - Pauta (Valor);
  // 2 - Preço Tabelado Máx. (valor);
  // 3 - valor da operação.
  result := EnumeradoToStr(t, ['0', '1', '2', '3'],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao]);
end;

function StrTomodBC(var ok: boolean; const s: string): TpcnDeterminacaoBaseIcms;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3'],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao]);
end;

// N18 - Modalidade de determinação da BC do ICMS ST ***************************

function modBCSTToStr(const t: TpcnDeterminacaoBaseIcmsST): string;
begin
  // 0 – Preço tabelado ou máximo sugerido;
  // 1 - Lista Negativa (valor);
  // 2 - Lista Positiva (valor);
  // 3 - Lista Neutra (valor);
  // 4 - Margem Valor Agregado (%);
  // 5 - Pauta (valor);
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5'],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra, dbisMargemValorAgregado, dbisPauta]);
end;

function StrTomodBCST(var ok: boolean; const s: string): TpcnDeterminacaoBaseIcmsST;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5'],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra, dbisMargemValorAgregado, dbisPauta]);
end;

// CST IPI *********************************************************************

function CSTIPIToStr(const t: TpcnCstIpi): string;
begin
  result := EnumeradoToStr(t, ['00', '49', '50', '99', '01', '02', '03', '04', '05', '51', '52', '53', '54', '55'],
    [ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55]);
end;

function StrToCSTIPI(var ok: boolean; const s: string): TpcnCstIpi;
begin
  result := StrToEnumerado(ok, s, ['00', '49', '50', '99', '01', '02', '03', '04', '05', '51', '52', '53', '54', '55'],
    [ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55]);
end;

// CST PIS *********************************************************************

function CSTPISToStr(const t: TpcnCstPIS): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '06', '07', '08', '09', '99'],
    [pis01, pis02, pis03, pis04, pis06, pis07, pis08, pis09, pis99]);
end;

function StrToCSTPIS(var ok: boolean; const s: string): TpcnCstPIS;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '06', '07', '08', '09', '99'],
    [pis01, pis02, pis03, pis04, pis06, pis07, pis08, pis09, pis99]);
end;

// CST COFINS ******************************************************************

function CSTCOFINSToStr(const t: TpcnCstCOFINS): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '06', '07', '08', '09', '99'],
    [cof01, cof02, cof03, cof04, cof06, cof07, cof08, cof09, cof99]);
end;

function StrToCSTCOFINS(var ok: boolean; const s: string): TpcnCstCOFINS;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '06', '07', '08', '09', '99'],
    [cof01, cof02, cof03, cof04, cof06, cof07, cof08, cof09, cof99]);
end;

// ??? - Modalidade do frete ***************************************************

function modFreteToStr(const t: TpcnModalidadeFrete): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [mfContaEmitente, mfContaDestinatario]);
end;

function StrTomodFrete(var ok: boolean; const s: string): TpcnModalidadeFrete;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [mfContaEmitente, mfContaDestinatario]);
end;

// 401i - Indicador da origem do processo **************************************

function indProcToStr(const t: TpcnIndicadorProcesso): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4'], [ipSEFAZ, ipJusticaFederal, ipJusticaEstadual, ipSecexRFB, ipOutros]);
end;

function StrToindProc(var ok: boolean; const s: string): TpcnIndicadorProcesso;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4'], [ipSEFAZ, ipJusticaFederal, ipJusticaEstadual, ipSecexRFB, ipOutros]);
end;

function tpforPagToStr(const t: TpcteFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2'], [fpPago, fpAPagar, fpOutros]);
end;

function tpforPagToStrText(const t: TpcteFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['PAGO','A PAGAR', 'OUTROS'], [fpPago, fpAPagar, fpOutros]);
end;

function StrTotpforPag(var ok: boolean; const s: string): TpcteFormaPagamento;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'], [fpPago, fpAPagar, fpOutros]);
end;

function tpCTePagToStr(const t: TpcteTipoCTe): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2', '3'], [tcNormal, tcComplemento, tcAnulacao, tcSubstituto]);
end;

function StrTotpCTe(var ok: boolean; const s: string): TpcteTipoCTe;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3'], [tcNormal, tcComplemento, tcAnulacao, tcSubstituto]);
end;

function TpModalToStr(const t: TpcteModal): string;
begin
  result := EnumeradoToStr(t, ['01','02', '03', '04', '05'], [mdRodoviario, mdAereo, mdAquaviario, mdFerroviario, mdDutoviario]);
end;

function TpModalToStrText(const t: TpcteModal): string;
begin
  result := EnumeradoToStr(t, ['RODOVIÁRIO','AÉREO', 'AQUAVIÁRIO', 'FERROVIÁRIO', 'DUTOVIÁRIO'], [mdRodoviario, mdAereo, mdAquaviario, mdFerroviario, mdDutoviario]);
end;

function StrToTpModal(var ok: boolean; const s: string): TpcteModal;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05'], [mdRodoviario, mdAereo, mdAquaviario, mdFerroviario, mdDutoviario]);
end;

function TpServPagToStr(const t: TpcteTipoServico): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2', '3'], [tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario]);
end;

function TpServToStrText(const t: TpcteTipoServico): string;
begin
  result := EnumeradoToStr(t, ['NORMAL','SUBCONTRATAÇÃO', 'REDESPACHO', 'REDESP. INTERMEDIÁRIO'], [tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario]);
end;

function StrToTpServ(var ok: boolean; const s: string): TpcteTipoServico;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3'], [tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario]);
end;

function TpRetiraPagToStr(const t: TpcteRetira): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [rtSim, rtNao]);
end;

function StrToTpRetira(var ok: boolean; const s: string): TpcteRetira;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [rtSim, rtNao]);
end;

function TpTomadorPagToStr(const t: TpcteTomador): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2', '3', '4'], [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpTomadorToStr(const t: TpcteTomador): String;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4'], [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpTomadorToStrText(const t: TpcteTomador): String;
begin
  result := EnumeradoToStr(t, ['REMETENTE', 'EXPEDIDOR', 'RECEBEDOR', 'DESTINATARIO', 'OUTROS'],
    [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpRspSeguroToStr(const t: TpcteRspSeg): String;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5'], [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario, rsEmitenteCTe, rsTomadorServico]);
end;

function TpRspSeguroToStrText(const t: TpcteRspSeg): String;
begin
  result := EnumeradoToStr(t, ['REMETENTE', 'EXPEDIDOR', 'RECEBEDOR', 'DESTINATARIO', 'EMITENTE', 'TOMADOR SERVICO'],
    [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario, rsEmitenteCTe, rsTomadorServico]);
end;

function TpLotacaoToStr(const t: TpcteLotacao): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [ltNao, ltSim]);
end;

function TpPropToStr(const t: TpcteProp): String;
begin
  result := EnumeradoToStr(t, ['0', '1', '2'], [tpTACAgregado, tpTACIndependente, tpOutros]);
end;

function StrToTpTomador(var ok: boolean; const s: String ): TpcteTomador;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4'], [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function StrToTpRspSeguro(var ok: boolean; const s: String ): TpcteRspSeg;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5'], [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario, rsEmitenteCTe, rsTomadorServico]);
end;

function StrToTpLotacao(var ok: boolean; const s: String ): TpcteLotacao;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [ltNao, ltSim]);
end;

function StrToTpProp(var ok: boolean; const s: String ): TpcteProp;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'], [tpTACAgregado, tpTACIndependente, tpOutros]);
end;

function UnidMedToStr(const t: UnidMed): string;
begin
  result := EnumeradoToStr(t, ['00', '01', '02', '03', '04'], [uM3,uKG, uTON, uUNIDADE, uLITROS]);
end;

function StrToUnidMed(var ok: boolean; const s: String ): UnidMed;
begin
  result := StrToEnumerado(ok, s, ['00', '01', '02', '03', '04'], [uM3,uKG, uTON, uUNIDADE, uLITROS]);
end;

  // Incluido por Italo em 31/09/2010
function TpDirecaoToStr(const t: TpcteDirecao): string;
begin
  result := EnumeradoToStr(t, ['N','L','S','O'], [drNorte , drLeste, drSul, drOeste]);
end;

function StrToTpDirecao(var ok: boolean; const s: string): TpcteDirecao;
begin
  result := StrToEnumerado(ok, s, ['N','L','S','O'], [drNorte , drLeste, drSul, drOeste]);
end;

function TpNavegacaoToStr(const t: TpcteTipoNavegacao): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [tnInterior , tnCabotagem]);
end;

function StrToTpNavegacao(var ok: boolean; const s: string): TpcteTipoNavegacao;
begin
  result := StrToEnumerado(ok, s, ['0','1'], [tnInterior , tnCabotagem]);
end;

  // Incluido por Italo em 19/11/2010
function TpTrafegoToStr(const t: TpcteTipoTrafego): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3'], [ttProprio , ttMutuo, ttRodoferroviario, ttRodoviario]);
end;

function StrToTpTrafego(var ok: boolean; const s: string): TpcteTipoTrafego;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3'], [ttProprio , ttMutuo, ttRodoferroviario, ttRodoviario]);
end;

  // Incluido por Italo em 25/01/2011
function TpDataPeriodoToStr(const t: TpcteTipoDataPeriodo): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4'], [tdSemData, tdNaData, tdAteData, tdApartirData, tdNoPeriodo]);
end;

function StrToTpDataPeriodo(var ok: boolean; const s: string): TpcteTipoDataPeriodo;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4'], [tdSemData, tdNaData, tdAteData, tdApartirData, tdNoPeriodo]);
end;

function TpHorarioIntervaloToStr(const t: TpcteTipoHorarioIntervalo): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4'], [thSemHorario, thNoHorario, thAteHorario, thApartirHorario, thNoIntervalo]);
end;

function StrToTpHorarioIntervalo(var ok: boolean; const s: string): TpcteTipoHorarioIntervalo;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4'], [thSemHorario, thNoHorario, thAteHorario, thApartirHorario, thNoIntervalo]);
end;

function TpDocumentoToStr(const t: TpcteTipoDocumento): string;
begin
  result := EnumeradoToStr(t, ['00','99'], [tdDeclaracao, tdOutros]);
end;

function StrToTpDocumento(var ok: boolean; const s: string): TpcteTipoDocumento;
begin
  result := StrToEnumerado(ok, s, ['00','99'], [tdDeclaracao, tdOutros]);
end;

function TpDocumentoAnteriorToStr(const t: TpcteTipoDocumentoAnterior): string;
begin
  result := EnumeradoToStr(t, ['00','01','02','03','04','05','06','07','08','09','10','11','12','99'],
   [daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN, daCTMC, daATRE, daDTA, daCAI, daCCPI, daCA, daTIF, daOutros]);
end;

function StrToTpDocumentoAnterior(var ok: boolean; const s: string): TpcteTipoDocumentoAnterior;
begin
  result := StrToEnumerado(ok, s, ['00','01','02','03','04','05','06','07','08','09','10','11','12','99'],
   [daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN, daCTMC, daATRE, daDTA, daCAI, daCCPI, daCA, daTIF, daOutros]);
end;

function RspPagPedagioToStr(const t: TpcteRspPagPedagio): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4','5'], [rpEmitente, rpRemetente, rpExpedidor, rpRecebedor, rpDestinatario, rpTomadorServico]);
end;

function StrToRspPagPedagio(var ok: boolean; const s: string): TpcteRspPagPedagio;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4','5'], [rpEmitente, rpRemetente, rpExpedidor, rpRecebedor, rpDestinatario, rpTomadorServico]);
end;

function TpDispositivoToStr(const t: TpcteTipoDispositivo): string;
begin
  result := EnumeradoToStr(t, ['1','2','3'], [tdCartaoMagnetico, tdTAG, tdTicket]);
end;

function StrToTpDispositivo(var ok: boolean; const s: string): TpcteTipoDispositivo;
begin
  result := StrToEnumerado(ok, s, ['1','2','3'], [tdCartaoMagnetico, tdTAG, tdTicket]);
end;

function TpPropriedadeToStr(const t: TpcteTipoPropriedade): string;
begin
  result := EnumeradoToStr(t, ['P','T'], [tpProprio, tpTerceiro]);
end;

function StrToTpPropriedade(var ok: boolean; const s: string): TpcteTipoPropriedade;
begin
  result := StrToEnumerado(ok, s, ['P','T'], [tpProprio, tpTerceiro]);
end;

function TpVeiculoToStr(const t: TpcteTipoVeiculo): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [tvTracao, tvReboque]);
end;

function StrToTpVeiculo(var ok: boolean; const s: string): TpcteTipoVeiculo;
begin
  result := StrToEnumerado(ok, s, ['0','1'], [tvTracao, tvReboque]);
end;

function TpRodadoToStr(const t: TpcteTipoRodado): string;
begin
  result := EnumeradoToStr(t, ['00','01','02','03','04','05','06'],
   [trNaoAplicavel, trTruck, trToco, trCavaloMecanico, trVAN, trUtilitario, trOutros]);
end;

function StrToTpRodado(var ok: boolean; const s: string): TpcteTipoRodado;
begin
  result := StrToEnumerado(ok, s, ['00','01','02','03','04','05','06'],
   [trNaoAplicavel, trTruck, trToco, trCavaloMecanico, trVAN, trUtilitario, trOutros]);
end;

function TpCarroceriaToStr(const t: TpcteTipoCarroceria): string;
begin
  result := EnumeradoToStr(t, ['00','01','02','03','04','05'],
   [tcNaoAplicavel, tcAberta, tcFechada, tcGraneleira, tcPortaContainer, tcSider]);
end;

function StrToTpCarroceria(var ok: boolean; const s: string): TpcteTipoCarroceria;
begin
  result := StrToEnumerado(ok, s, ['00','01','02','03','04','05'],
   [tcNaoAplicavel, tcAberta, tcFechada, tcGraneleira, tcPortaContainer, tcSider]);
end;

end.

