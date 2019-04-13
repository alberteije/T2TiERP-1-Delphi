////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org                                       //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordenação: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
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

unit pcnNFe;

interface uses

  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnConversao, pcnSignature, pcnProcNFe;

type

  TNFe = class;
  TInfNFe = class;
  TIde = class;
  TNFrefCollection = class;
  TNFrefCollectionItem = class;
  TRefNF = class;
  TEmit = class;
  TAvulsa = class;
  TenderEmit = class;
  TDest = class;
  TenderDest = class;
  TRetirada = class;
  TEntrega = class;
  TDetCollection = class;
  TDetCollectionItem = class;
  TProd = class;
  TveicProd = class;
  TmedCollection = class;
  TmedCollectionItem = class;
  TarmaCollection = class;
  TarmaCollectionItem = class;
  TComb = class;
  TCIDE = class;
  TICMSComb = class;
  TICMSInter = class;
  TICMSCons = class;
  TDICollection = class;
  TDICollectionItem = class;
  TAdiCollection = class;
  TAdiCollectionItem = class;
  TImposto = class;
  TICMS = class;
  TIPI = class;
  TII = class;
  TPIS = class;
  TPISST = class;
  TCOFINS = class;
  TCOFINSST = class;
  TISSQN = class;
  TTotal = class;
  TICMSTot = class;
  TISSQNtot = class;
  TretTrib = class;
  TTransp = class;
  TTransporta = class;
  TveicTransp = class;
  TretTransp = class;
  TreboqueCollection = class;
  TreboqueCollectionItem = class;
  TVolCollection = class;
  TVolCollectionItem = class;
  TLacresCollection = class;
  TLacresCollectionItem = class;
  TCobr = class;
  TFat = class;
  TDupCollection = class;
  TDupCollectionItem = class;
  TInfAdic = class;
  TobsContCollection = class;
  TobsContCollectionItem = class;
  TobsFiscoCollection = class;
  TobsFiscoCollectionItem = class;
  TprocRefCollection = class;
  TprocRefCollectionItem = class;
  Texporta = class;
  Tcompra = class;

  TNFe = class(TPersistent)
  private
    FSchema: TpcnSchema;
    FinfNFe: TinfNFe;
    FIde: TIde;
    FEmit: TEmit;
    FAvulsa: TAvulsa;
    FDest: TDest;
    FRetirada: TRetirada;
    FEntrega: TEntrega;
    FDet: TDetCollection;
    FTotal: TTotal;
    FTransp: TTransp;
    FCobr: TCobr;
    FInfAdic: TInfAdic;
    Fexporta: Texporta;
    Fcompra: Tcompra;
    FSignature: TSignature;
    FProcNFe: TProcNFe;
    procedure SetDet(Value: TDetCollection);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property schema: TpcnSchema read Fschema write Fschema;
    //
    property infNFe: TinfNFe read FinfNFe write FinfNFe;
    property Ide: TIde read FIde write FIde;
    property Emit: TEmit read FEmit write FEmit;
    property Avulsa: TAvulsa read FAvulsa write FAvulsa;
    property Dest: TDest read FDest write FDest;
    property Retirada: TRetirada read FRetirada write FRetirada;
    property Entrega: TEntrega read FEntrega write FEntrega;
    property Det: TDetCollection read FDet write SetDet;
    property Total: TTotal read FTotal write FTotal;
    property Transp: TTransp read FTransp write FTransp;
    property Cobr: TCobr read FCobr write FCobr;
    property InfAdic: TInfAdic read FInfAdic write FInfAdic;
    property exporta: Texporta read Fexporta write Fexporta;
    property compra: Tcompra read Fcompra write Fcompra;
    property signature: Tsignature read Fsignature write Fsignature;
    property procNFe: TProcNFe read FProcNFe write FProcNFe;    
  end;

  TinfNFe = class(TPersistent)
  private
    FID: string;
  published
    property ID: string read FID write FID;
  end;

  TIde = class(TPersistent)
  private
    FcUF: integer;
    FcNF: integer;
    FnatOp: string;
    FindPag: TpcnIndicadorPagamento;
    Fmodelo: integer;
    Fserie: integer;
    FnNF: integer;
    FdEmi: TDateTime;
    FdSaiEnt: TDateTime;
    FtpNF: TpcnTipoNFe;
    FcMunFG: integer;
    FNFref: TNFrefCollection;
    FtpImp: TpcnTipoImpressao;
    FtpEmis: TpcnTipoEmissao;
    FcDV: integer;
    FtpAmb: TpcnTipoAmbiente;
    FfinNFe: TpcnFinalidadeNFe;
    FprocEmi: TpcnProcessoEmissao;
    FverProc: string;
    procedure SetNFref(Value: TNFrefCollection);
  public
    constructor Create(AOwner: TNFe);
    destructor Destroy; override;
  published
    property cUF: integer read FcUF write FcUF;
    property cNF: integer read FcNF write FcNF;
    property natOp: string read FnatOp write FnatOp;
    property indPag: TpcnIndicadorPagamento read FindPag write FindPag default ipPrazo;
    property modelo: integer read Fmodelo write Fmodelo;
    property serie: integer read Fserie write Fserie;
    property nNF: integer read FnNF write FnNF;
    property dEmi: TDateTime read FdEmi write FdEmi;
    property dSaiEnt: TDateTime read FdSaiEnt write FdSaiEnt;
    property tpNF: TpcnTipoNFe read FtpNF write FtpNF default tnSaida;
    property cMunFG: integer read FcMunFG write FcMunFG;
    property NFref: TNFrefCollection read FNFref write SetNFref;
    property tpImp: TpcnTipoImpressao read FtpImp write FtpImp default tiPaisagem;
    property tpEmis: TpcnTipoEmissao read FtpEmis write FtpEmis default teNormal;
    property cDV: integer read FcDV write FcDV;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb default taHomologacao;
    property finNFe: TpcnFinalidadeNFe read FfinNFe write FfinNFe default fnNormal;
    property procEmi: TpcnProcessoEmissao read FprocEmi write FprocEmi default peAplicativoContribuinte;
    property verProc: string read FverProc write FverProc;
  end;

  TNFrefCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TNFrefCollectionItem;
    procedure SetItem(Index: Integer; Value: TNFrefCollectionItem);
  public
    constructor Create(AOwner: TIde); reintroduce;
    function Add: TNFrefCollectionItem;
    property Items[Index: Integer]: TNFrefCollectionItem read GetItem write SetItem; default;
  end;

  TNFrefCollectionItem = class(TCollectionItem)
  private
    FRefNFe: string;
    FRefNF: TRefNF;
  public
    constructor Create; reintroduce;
    destructor destroy; override;
  published
    property refNFe: string read FrefNFe write FrefNFe;
    property RefNF: TRefNF read FRefNF write FRefNF;
  end;

  TRefNF = class(TPersistent)
  private
    FcUF: integer;
    FAAMM: string;
    FCNPJ: string;
    Fmodelo: integer;
    Fserie: integer;
    FnNF: integer;
  published
    property cUF: integer read FcUF write FcUF;
    property AAMM: string read FAAMM write FAAMM;
    property CNPJ: string read FCNPJ write FCNPJ;
    property modelo: integer read FModelo write Fmodelo;
    property serie: integer read FSerie write Fserie;
    property nNF: integer read FnNF write FnNF;
  end;

  TEmit = class(TPersistent)
  private
    FCNPJCPF: string;
    FxNome: string;
    FxFant: string;
    FenderEmit: TenderEmit;
    FIE: string;
    FIEST: string;
    FIM: string;
    FCNAE: string;
  public
    constructor Create(AOwner: TNFe);
    destructor Destroy; override;
  published
    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
    property xNome: string read FxNome write FxNome;
    property xFant: string read FxFant write FxFant;
    property EnderEmit: TEnderEmit read FEnderEmit write FEnderEmit;
    property IE: string read FIE write FIE;
    property IEST: string read FIEST write FIEST;
    property IM: string read FIM write FIM;
    property CNAE: string read FCNAE write FCNAE;
  end;

  TenderEmit = class(TPersistent)
  private
    FxLgr: string;
    Fnro: string;
    fxCpl: string;
    FxBairro: string;
    FcMun: integer;
    FxMun: string;
    FUF: string;
    FCEP: integer;
    FcPais: integer;
    FxPais: string;
    Ffone: string;
  published
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property UF: string read FUF write FUF;
    property CEP: integer read FCEP write FCEP;
    property cPais: integer read FcPais write FcPais ;
    property xPais: string read FxPais write FxPais ;
    property fone: string read Ffone write Ffone;
  end;

  TAvulsa = class(TPersistent)
  private
    FCNPJ: string;
    FxOrgao: string;
    Fmatr: string;
    FxAgente: string;
    Ffone: string;
    FUF: string;
    FnDAR: string;
    FdEmi: TDateTime;
    FvDAR: currency;
    FrepEmi: string;
    FdPag: TDateTime;
  published
    property CNPJ: string read FCNPJ write FCNPJ;
    property xOrgao: string read FxOrgao write FxOrgao;
    property matr: string read Fmatr write Fmatr;
    property xAgente: string read FxAgente write FxAgente;
    property fone: string read Ffone write Ffone;
    property UF: string read FUF write FUF;
    property nDAR: string read FnDAR write FnDAR;
    property dEmi: TDateTime read FdEmi write FdEmi;
    property vDAR: currency read FvDAR write FvDAR;
    property repEmi: string read FrepEmi write FrepEmi;
    property dPag: TDateTime read FdPag write FdPag;
  end;

  TDest = class(TPersistent)
  private
    FCNPJCPF: string;
    FxNome: string;
    FEnderDest: TEnderDest;
    FIE: string;
    FISUF: string;
  public
    constructor Create(AOwner: TNFe);
    destructor Destroy; override;
  published
    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
    property xNome: string read FxNome write FxNome;
    property EnderDest: TEnderDest read FEnderDest write FEnderDest;
    property IE: string read FIE write FIE;
    property ISUF: string read FISUF write FISUF;
  end;

  TEnderDest = class(TPersistent)
  private
    FxLgr: string;
    Fnro: string;
    fxCpl: string;
    FxBairro: string;
    FcMun: integer;
    FxMun: string;
    FUF: string;
    FCEP: integer;
    FcPais: integer;
    FxPais: string;
    Ffone: string;
  published
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property UF: string read FUF write FUF;
    property CEP: integer read FCEP write FCEP;
    property cPais: integer read FcPais write FcPais ;
    property xPais: string read FxPais write FxPais ;
    property fone: string read Ffone write Ffone;
  end;

  TRetirada = class(TPersistent)
  private
    FCNPJ: string;
    FxLgr: string;
    Fnro: string;
    fxCpl: string;
    FxBairro: string;
    FcMun: integer;
    FxMun: string;
    FUF: string;
  published
    property CNPJ: string read FCNPJ write FCNPJ;
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property UF: string read FUF write FUF;
  end;

  TEntrega = class(TPersistent)
  private
    FCNPJ: string;
    FxLgr: string;
    Fnro: string;
    fxCpl: string;
    FxBairro: string;
    FcMun: integer;
    FxMun: string;
    FUF: string;
  published
    property CNPJ: string read FCNPJ write FCNPJ;
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property UF: string read FUF write FUF;
  end;

  TDetCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TDetCollectionItem;
    procedure SetItem(Index: Integer; Value: TDetCollectionItem);
  public
    constructor Create(AOwner: TNFe);
    function Add: TDetCollectionItem;
    property Items[Index: Integer]: TDetCollectionItem read GetItem write SetItem; default;
  end;

  TDetCollectionItem = class(TCollectionItem)
  private
    FProd: TProd;
    FImposto: TImposto;
    FinfAdProd: string;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Prod: TProd read FProd write FProd;
    property Imposto: TImposto read FImposto write FImposto;
    property infAdProd: string read FinfAdProd write FinfAdProd;
  end;

  TProd = class(TPersistent)
  private
    FcProd: string;
    FnItem: integer;
    FcEAN: string;
    FxProd: string;
    FNCM: string;
    FEXTIPI: string;
    Fgenero: integer;
    FCFOP: string;
    FuCom: string;
    FqCom: currency;
    FvUnCom: currency;
    FvProd: currency;
    FcEANTrib: string;
    FuTrib: string;
    FqTrib: currency;
    FvUnTrib: currency;
    FvFrete: currency;
    FvSeg: currency;
    FvDesc: currency;
    FDI: TDICollection;
    FveicProd: TveicProd;
    Fmed: TMedCollection;
    Farma: TarmaCollection;
    Fcomb: Tcomb;
    procedure SetDI(Value: TDICollection);
    procedure SetMed(Value: TmedCollection);
    procedure SetArma(Value: TarmaCollection);
  public
    constructor Create(AOwner: TDetcollectionItem);
    destructor Destroy; override;
  published
    property cProd: string read FcProd write FcProd;
    property nItem: integer read FnItem write FnItem;
    property cEAN: string read FcEAN write FcEAN;
    property xProd: string read FxProd write FxProd;
    property NCM: string read FNCM write FNCM;
    property EXTIPI: string read FEXTIPI write FEXTIPI;
    property genero: integer read Fgenero write Fgenero;
    property CFOP: string read FCFOP write FCFOP;
    property uCom: string read FuCom write FuCom;
    property qCom: currency read FqCom write FqCom;
    property vUnCom: currency read FvUnCom write FvUnCom;
    property vProd: currency read FvProd write FvProd;
    property cEANTrib: string read FcEANTrib write FcEANTrib;
    property uTrib: string read FuTrib write FuTrib;
    property qTrib: currency read FqTrib write FqTrib;
    property vUnTrib: currency read FvUnTrib write FvUnTrib;
    property vFrete: currency read FvFrete write FvFrete;
    property vSeg: currency read FvSeg write FvSeg;
    property vDesc: currency read FvDesc write FvDesc;
    property DI: TDICollection read FDI write SetDI;
    property veicProd: TveicProd read FveicProd write FveicProd;
    property med: TMedCollection read Fmed write SetMed;
    property arma: TarmaCollection read Farma write SetArma;
    property comb: Tcomb read Fcomb write Fcomb;
  end;

  TveicProd = class(TPersistent)
  private
    FtpOP: TpcnTipoOperacao;
    Fchassi: string;
    FcCor: string;
    FxCor: string;
    Fpot: string;
    FCM3: string;
    FpesoL: string;
    FpesoB: string;
    FnSerie: string;
    FtpComb: string;
    FnMotor: string;
    FCMKG: string;
    Fdist: string;
    FRENAVAM: string;
    FanoMod: integer;
    FanoFab: integer;
    FtpPint: string;
    FtpVeic: integer;
    FespVeic: integer;
    FVIN: string;
    FcondVeic: TpcnCondicaoVeiculo;
    FcMod: string;
  published
    property tpOP: TpcnTipoOperacao read FtpOP write FtpOP;
    property chassi: string read Fchassi write Fchassi;
    property cCor: string read FcCor write FcCor;
    property xCor: string read FxCor write FxCor;
    property pot: string read Fpot write Fpot;
    property CM3: string read FCM3 write FCM3;
    property pesoL: string read FpesoL write FpesoL;
    property pesoB: string read FpesoB write FpesoB;
    property nSerie: string read FnSerie write FnSerie;
    property tpComb: string read FtpComb write FtpComb;
    property nMotor: string read FnMotor write FnMotor;
    property CMKG: string read FCMKG write FCMKG;
    property dist: string read Fdist write Fdist;
    property RENAVAM: string read FRENAVAM write FRENAVAM;
    property anoMod: integer read FanoMod write FanoMod;
    property anoFab: integer read FanoFab write FanoFab;
    property tpPint: string read FtpPint write FtpPint;
    property tpVeic: integer read FtpVeic write FtpVeic;
    property espVeic: integer read FespVeic write FespVeic;
    property VIN: string read FVIN write FVIN;
    property condVeic: TpcnCondicaoVeiculo read FcondVeic write FcondVeic;
    property cMod: string read FcMod write FcMod;
  end;

  TMedCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TMedCollectionItem;
    procedure SetItem(Index: Integer; Value: TMedCollectionItem);
  public
    constructor Create(AOwner: TProd);
    destructor Destroy; override;
    function Add: TMedCollectionItem;
    property Items[Index: Integer]: TMedCollectionItem read GetItem write SetItem; default;
  end;

  TMedCollectionItem = class(TCollectionItem)
  private
    FnLote: string;
    FqLote: currency;
    FdFab: TDateTime;
    FdVal: TDateTime;
    FvPMC: currency;
  published
    property nLote: string read FnLote write FnLote;
    property qLote: currency read FqLote write FqLote;
    property dFab: TDateTime read FdFab write FdFab;
    property dVal: TDateTime read FdVal write FdVal;
    property vPMC: currency read FvPMC write FvPMC;
  end;

  TArmaCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TArmaCollectionItem;
    procedure SetItem(Index: Integer; Value: TArmaCollectionItem);
  public
    constructor Create(AOwner: TProd);
    destructor Destroy; override;
    function Add: TArmaCollectionItem;
    property Items[Index: Integer]: TArmaCollectionItem read GetItem write SetItem; default;
  end;

  TArmaCollectionItem = class(TCollectionItem)
  private
    FtpArma: TpcnTipoArma;
    FnSerie: Integer;
    FnCano: Integer;
    Fdescr: string;
  published
    property tpArma: TpcnTipoArma read FtpArma write FtpArma default taUsoPermitido;
    property nSerie: Integer read FnSerie write FnSerie;
    property nCano: Integer read FnCano write FnCano;
    property descr: string read Fdescr write Fdescr;
  end;

  Tcomb = class(TPersistent)
  private
    FcProdANP: integer;
    FCODIF: string;
    FqTemp: currency;
    FCIDE: TCIDE;
    FICMS: TICMSComb;
    FICMSInter: TICMSInter;
    FICMSCons: TICMSCons;
  public
    constructor Create(AOwner: TProd);
    destructor Destroy; override;
  published
    property cProdANP: integer read FcProdANP write FcProdANP;
    property CODIF: string read FCODIF write FCODIF;
    property qTemp: currency read FqTemp write FqTemp;
    property CIDE: TCIDE read FCIDE write FCIDE;
    property ICMS: TICMSComb read FICMS write FICMS;
    property ICMSInter: TICMSInter read FICMSInter write FICMSInter;
    property ICMSCons: TICMSCons read FICMSCons write FICMSCons;
  end;

  TCIDE = class(TPersistent)
  private
    FqBCProd: currency;
    FvAliqProd: currency;
    FvCIDE: currency;
  published
    property qBCProd: currency read FqBCProd write FqBCProd;
    property vAliqProd: currency read FvAliqProd write FvAliqProd;
    property vCIDE: currency read FvCIDE write FvCIDE;
  end;

  TICMSComb = class(TPersistent)
  private
    FvBCICMS: currency;
    FvICMS: currency;
    FvBCICMSST: currency;
    FvICMSST: currency;
  published
    property vBCICMS: currency read FvBCICMS write FvBCICMS;
    property vICMS: currency read FvICMS write FvICMS;
    property vBCICMSST: currency read FvBCICMSST write FvBCICMSST;
    property vICMSST: currency read FvICMSST write FvICMSST;
  end;

  TICMSInter = class(TPersistent)
  private
    FvBCICMSSTDest: currency;
    FvICMSSTDest: currency;
  published
    property vBCICMSSTDest: currency read FvBCICMSSTDest write FvBCICMSSTDest;
    property vICMSSTDest: currency read FvICMSSTDest write FvICMSSTDest;
  end;

  TICMSCons = class(TPersistent)
  private
    FvBCICMSSTCons: currency;
    FvICMSSTCons: currency;
    FUFcons: string;
  published
    property vBCICMSSTCons: currency read FvBCICMSSTCons write FvBCICMSSTCons;
    property vICMSSTCons: currency read FvICMSSTCons write FvICMSSTCons;
    property UFcons: string read FUFcons write FUFcons;
  end;

  TDICollection = class(TCollection)
  private
    function GetItem(Index: Integer): TDICollectionItem;
    procedure SetItem(Index: Integer; Value: TDICollectionItem);
  public
    constructor Create(AOwner: TProd);
    function Add: TDICollectionItem;
    property Items[Index: Integer]: TDICollectionItem read GetItem write SetItem; default;
  end;

  TDICollectionItem = class(TCollectionItem)
  private
    FnDi: string;
    FdDi: TDateTime;
    FxLocDesemb: string;
    FUFDesemb: string;
    FdDesemb: TDateTime;
    FcExportador: string;
    Fadi: TadiCollection;
    procedure SetAdi(Value: TAdiCollection);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property nDi: string read FnDi write FnDi;
    property dDi: TDateTime read FdDi write FdDi;
    property xLocDesemb: string read FxLocDesemb write FxLocDesemb;
    property UFDesemb: string read FUFDesemb write FUFDesemb;
    property dDesemb: TDateTime read FdDesemb write FdDesemb;
    property cExportador: string read FcExportador write FcExportador;
    property adi: TAdiCollection read Fadi write SetAdi;
  end;

  TAdiCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TAdiCollectionItem;
    procedure SetItem(Index: Integer; Value: TAdiCollectionItem);
  public
    constructor Create(AOwner: TDICollectionItem);
    function Add: TAdiCollectionItem;
    property Items[Index: Integer]: TAdiCollectionItem read GetItem write SetItem; default;
  end;

  TAdiCollectionItem = class(TCollectionItem)
  private
    FnAdicao: integer;
    FnSeqAdi: integer;
    FcFabricante: string;
    FvDescDI: currency;
  published
    property nAdicao: integer read FnAdicao write FnAdicao;
    property nSeqAdi: integer read FnSeqAdi write FnSeqAdi;
    property cFabricante: string read FcFabricante write FcFabricante;
    property vDescDI: currency read FvDescDI write FvDescDI;
  end;

  TImposto = class(TPersistent)
  private
    FICMS: TICMS;
    FIPI: TIPI;
    FII: TII;
    FPIS: TPIS;
    FPISST: TPISST;
    FCOFINS: TCOFINS;
    FCOFINSST: TCOFINSST;
    FISSQN: TISSQN;
  public
    constructor Create(AOwner: TDetcollectionItem);
    destructor Destroy; override;
  published
    property ICMS: TICMS read FICMS write FICMS;
    property IPI: TIPI read FIPI write FIPI;
    property II: TII read FII write FII;
    property PIS: TPIS read FPIS write FPIS;
    property PISST: TPISST read FPISST write FPISST;
    property COFINS: TCOFINS read FCOFINS write FCOFINS;
    property COFINSST: TCOFINSST read FCOFINSST write FCOFINSST;
    property ISSQN: TISSQN read FISSQN write FISSQN;
  end;

  TICMS = class(TPersistent)
  private
    Forig: TpcnOrigemMercadoria;
    FCST: TpcnCSTIcms;
    FmodBC: TpcnDeterminacaoBaseIcms;
    FpRedBC: currency;
    FvBC: currency;
    FpICMS: currency;
    FvICMS: currency;
    FmodBCST: TpcnDeterminacaoBaseIcmsST;
    FpMVAST: currency;
    FpRedBCST: currency;
    FvBCST: currency;
    FpICMSST: currency;
    FvICMSST: currency;
  published
    property orig: TpcnOrigemMercadoria read Forig write Forig default oeNacional;
    property CST: TpcnCSTIcms read FCST write FCST default cst00;
    property modBC: TpcnDeterminacaoBaseIcms read FmodBC write FmodBC default dbiMargemValorAgregado;
    property pRedBC: currency read FpRedBC write FpRedBC;
    property vBC: currency read FvBC write FvBC;
    property pICMS: currency read FpICMS write FpICMS;
    property vICMS: currency read FvICMS write FvICMS;
    property modBCST: TpcnDeterminacaoBaseIcmsST read FmodBCST write FmodBCST default dbisPrecoTabelado;
    property pMVAST: currency read FpMVAST write FpMVAST;
    property pRedBCST: currency read FpRedBCST write FpRedBCST;
    property vBCST: currency read FvBCST write FvBCST;
    property pICMSST: currency read FpICMSST write FpICMSST;
    property vICMSST: currency read FvICMSST write FvICMSST;
  end;

  TIPI = class(TPersistent)
  private
    FclEnq: string;
    FCNPJProd: string;
    FcSelo: string;
    FqSelo: integer;
    FcEnq: string;
    FCST: TpcnCstIpi;
    FvBC: currency;
    FqUnid: currency;
    FvUnid: currency;
    FpIPI: currency;
    FvIPI: currency;
  published
    property clEnq: string read FclEnq write FclEnq;
    property CNPJProd: string read FCNPJProd write FCNPJProd;
    property cSelo: string read FcSelo write FcSelo;
    property qSelo: integer read FqSelo write FqSelo;
    property cEnq: string read FcEnq write FcEnq;
    property CST: TpcnCstIpi read FCST write FCST default ipi00;
    property vBC: currency read FvBC write FvBC;
    property qUnid: currency read FqUnid write FqUnid;
    property vUnid: currency read FvUnid write FvUnid;
    property pIPI: currency read FpIPI write FpIPI;
    property vIPI: currency read FvIPI write FvIPI;
  end;

  TII = class(TPersistent)
  private
    FvBc: currency;
    FvDespAdu: currency;
    FvII: currency;
    FvIOF: currency;
  published
    property vBc: currency read FvBC write FvBC;
    property vDespAdu: currency read FvDespAdu write FvDespAdu;
    property vII: currency read FvII write FvII;
    property vIOF: currency read FvIOF write FvIOF;
  end;

  TPIS = class(TPersistent)
  private
    FCST: TpcnCstPis;
    FvBC: currency;
    FpPIS: currency;
    FvPIS: currency;
    FqBCProd: currency;
    FvAliqProd: currency;
  published
    property CST: TpcnCstPis read FCST write FCST default pis01;
    property vBC: currency read FvBC write FvBC;
    property pPIS: currency read FpPIS write FpPIS;
    property vPIS: currency read FvPIS write FvPIS;
    property qBCProd: currency read FqBCProd write FqBCProd;
    property vAliqProd: currency read FvAliqProd write FvAliqProd;
  end;

  TPISST = class(TPersistent)
  private
    FvBc: currency;
    FpPis: currency;
    FqBCProd: currency;
    FvAliqProd: currency;
    FvPIS: currency;
  published
    property vBc: currency read FvBc write FvBc;
    property pPis: currency read FpPis write FpPis;
    property qBCProd: currency read FqBCProd write FqBCProd;
    property vAliqProd: currency read FvAliqProd write FvAliqProd;
    property vPIS: currency read FvPIS write FvPIS;
  end;

  TCOFINS = class(TPersistent)
  private
    FCST: TpcnCstCofins;
    FvBC: currency;
    FpCOFINS: currency;
    FvCOFINS: currency;
    FvBCProd: currency;
    FvAliqProd: currency;
    FqBCProd: currency;
  published
    property CST: TpcnCstCofins read FCST write FCST default cof01;
    property vBC: currency read FvBC write FvBC;
    property pCOFINS: currency read FpCOFINS write FpCOFINS;
    property vCOFINS: currency read FvCOFINS write FvCOFINS;
    property vBCProd: currency read FvBCProd write FvBCProd;
    property vAliqProd: currency read FvAliqProd write FvAliqProd;
    property qBCProd: currency read FqBCProd write FqBCProd;
  end;

  TTotal = class(TPersistent)
  private
    FICMSTot: TICMSTot;
    FISSQNtot: TISSQNtot;
    FretTrib: TretTrib;
  public
    constructor Create(AOwner: TNFe);
    destructor Destroy; override;
  published
    property ICMSTot: TICMSTot read FICMSTot write FICMSTot;
    property ISSQNtot: TISSQNtot read FISSQNtot write FISSQNtot;
    property retTrib: TretTrib read FretTrib write FretTrib;
  end;

  TICMSTot = class(TPersistent)
  private
    FvBC: Currency;
    FvICMS: Currency;
    FvBCST: Currency;
    FvST: Currency;
    FvProd: Currency;
    FvFrete: Currency;
    FvSeg: Currency;
    FvDesc: Currency;
    FvII: Currency;
    FvIPI: Currency;
    FvPIS: Currency;
    FvCOFINS: Currency;
    FvOutro: Currency;
    FvNF: Currency;
  published
    property vBC: Currency read FvBC write FvBC;
    property vICMS: Currency read FvICMS write FvICMS;
    property vBCST: Currency read FvBCST write FvBCST;
    property vST: Currency read FvST write FvST;
    property vProd: Currency read FvProd write FvProd;
    property vFrete: Currency read FvFrete write FvFrete;
    property vSeg: Currency read FvSeg write FvSeg;
    property vDesc: Currency read FvDesc write FvDesc;
    property vII: Currency read FvII write FvII;
    property vIPI: Currency read FvIPI write FvIPI;
    property vPIS: Currency read FvPIS write FvPIS;
    property vCOFINS: Currency read FvCOFINS write FvCOFINS;
    property vOutro: Currency read FvOutro write FvOutro;
    property vNF: Currency read FvNF write FvNF;
  end;

  TISSQNtot = class(TPersistent)
  private
    FvServ: Currency;
    FvBC: Currency;
    FvISS: Currency;
    FvPIS: Currency;
    FvCOFINS: Currency;
  published
    property vServ: Currency read FvServ write FvServ;
    property vBC: Currency read FvBC write FvBC;
    property vISS: Currency read FvISS write FvISS;
    property vPIS: Currency read FvPIS write FvPIS;
    property vCOFINS: Currency read FvCOFINS write FvCOFINS;
  end;

  TretTrib = class(TPersistent)
  private
    FvRetPIS: Currency;
    FvRetCOFINS: Currency;
    FvRetCSLL: Currency;
    FvBCIRRF: Currency;
    FvIRRF: Currency;
    FvBCRetPrev: Currency;
    FvRetPrev: Currency;
  public
  published
    property vRetPIS: Currency read FvRetPIS write FvRetPIS;
    property vRetCOFINS: Currency read FvRetCOFINS write FvRetCOFINS;
    property vRetCSLL: Currency read FvRetCSLL write FvRetCSLL;
    property vBCIRRF: Currency read FvBCIRRF write FvBCIRRF;
    property vIRRF: Currency read FvIRRF write FvIRRF;
    property vBCRetPrev: Currency read FvBCRetPrev write FvBCRetPrev;
    property vRetPrev: Currency read FvRetPrev write FvRetPrev;
  end;

  TCOFINSST = class(TPersistent)
  private
    FvBC: currency;
    FpCOFINS: currency;
    FqBCProd: currency;
    FvAliqProd: currency;
    FvCOFINS: currency;
  published
    property vBC: currency read FvBC write FvBC;
    property pCOFINS: currency read FpCOFINS write FpCOFINS;
    property qBCProd: currency read FqBCProd write FqBCProd;
    property vAliqProd: currency read FvAliqProd write FvAliqProd;
    property vCOFINS: currency read FvCOFINS write FvCOFINS;
  end;

  TISSQN = class(TPersistent)
  private
    FvBC: currency;
    FvAliq: currency;
    FvISSQN: currency;
    FcMunFG: integer;
    FcListServ: integer;
  public
  published
    property vBC: currency read FvBC write FvBC;
    property vAliq: currency read FvAliq write FvAliq;
    property vISSQN: currency read FvISSQN write FvISSQN;
    property cMunFG: integer read FcMunFG write FcMunFG;
    property cListServ: integer read FcListServ write FcListServ;
  end;

  TTransp = class(TPersistent)
  private
    FmodFrete: TpcnModalidadeFrete;
    FTransporta: TTransporta;
    FretTransp: TretTransp;
    FveicTransp: TveicTransp;
    FVol: TVolCollection;
    FReboque: TReboqueCollection;
    procedure SetVol(Value: TVolCollection);
    procedure SetReboque(Value: TReboqueCollection);
  public
    constructor Create(AOwner: TNFe);
    destructor Destroy; override;
  published
    property modFrete: TpcnModalidadeFrete read FmodFrete write FmodFrete;
    property Transporta: TTransporta read FTransporta write FTransporta;
    property retTransp: TretTransp read FretTransp write FretTransp;
    property veicTransp: TveicTransp read FveicTransp write FveicTransp;
    property Vol: TVolCollection read FVol write SetVol;
    property Reboque: TReboqueCollection read FReboque write SetReboque;
  end;

  TTransporta = class(TPersistent)
  private
    FCNPJCPF: string;
    FxNome: string;
    FIE: string;
    FxEnder: string;
    FxMun: string;
    FUF: string;
  published
    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
    property xNome: string read FxNome write FxNome;
    property IE: string read FIE write FIE;
    property xEnder: string read FxEnder write FxEnder;
    property xMun: string read FxMun write FxMun;
    property UF: string read FUF write FUF;
  end;

  TretTransp = class(TPersistent)
  private
    FvServ: currency;
    FvBCRet: currency;
    FpICMSRet: currency;
    FvICMSRet: currency;
    FCFOP: string;
    FcMunFG: integer;
  public
    constructor Create(AOwner: TTransp);
  published
    property vServ: currency read FvServ write FvServ;
    property vBCRet: currency read FvBCRet write FvBCRet;
    property pICMSRet: currency read FpICMSRet write FpICMSRet;
    property vICMSRet: currency read FvICMSRet write FvICMSRet;
    property CFOP: string read FCFOP write FCFOP;
    property cMunFG: integer read FcMunFG write FcMunFG;
  end;

  TveicTransp = class(TPersistent)
  private
    Fplaca: string;
    FUF: string;
    FRNTC: string;
  published
    property placa: string read Fplaca write Fplaca;
    property UF: string read FUF write FUF;
    property RNTC: string read FRNTC write FRNTC;
  end;

  TReboqueCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TReboqueCollectionItem;
    procedure SetItem(Index: Integer; Value: TReboqueCollectionItem);
  public
    constructor Create(AOwner: TTransp);
    function Add: TReboqueCollectionItem;
    property Items[Index: Integer]: TReboqueCollectionItem read GetItem write SetItem; default;
  end;

  TReboqueCollectionItem = class(TCollectionItem)
  private
    Fplaca: string;
    FUF: string;
    FRNTC: string;
  published
    property placa: string read Fplaca write Fplaca;
    property UF: string read FUF write FUF;
    property RNTC: string read FRNTC write FRNTC;
  end;

  TVolCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TVolCollectionItem;
    procedure SetItem(Index: Integer; Value: TVolCollectionItem);
  public
    constructor Create(AOwner: TTransp);
    function Add: TVolCollectionItem;
    property Items[Index: Integer]: TVolCollectionItem read GetItem write SetItem; default;
  end;

  TVolCollectionItem = class(TCollectionItem)
  private
    FqVol: integer;
    Fesp: string;
    Fmarca: string;
    FnVol: string;
    FpesoL: currency;
    FpesoB: currency;
    FLacres: TLacresCollection;
    procedure SetLacres(Value: TLacresCollection);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property qVol: integer read FqVol write FqVol;
    property esp: string read Fesp write Fesp;
    property marca: string read Fmarca write Fmarca;
    property nVol: string read FnVol write FnVol;
    property pesoL: currency read FpesoL write FpesoL;
    property pesoB: currency read FpesoB write FpesoB;
    property Lacres: TLacresCollection read FLacres write SetLacres;
  end;

  TLacresCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TLacresCollectionItem;
    procedure SetItem(Index: Integer; Value: TLacresCollectionItem);
  public
    constructor Create(AOwner: TVolCollectionItem);
    function Add: TLacresCollectionItem;
    property Items[Index: Integer]: TLacresCollectionItem read GetItem write SetItem; default;
  end;

  TLacresCollectionItem = class(TCollectionItem)
  private
    FnLacre: string;
  published
    property nLacre: string read FnLacre write FnLacre;
  end;

  TCobr = class(TPersistent)
  private
    FFat: TFat;
    FDup: TDupCollection;
    procedure SetDup(Value: TDupCollection);
  public
    constructor Create(AOwner: TNFe);
    destructor Destroy; override;
  published
    property Fat: TFat read FFat write FFat;
    property Dup: TDupCollection read FDup write SetDup;
  end;

  TFat = class(TPersistent)
  private
    FnFat: string;
    FvOrig: currency;
    FvDesc: currency;
    FvLiq: currency;
  published
    property nFat: string read FnFat write FnFat;
    property vOrig: currency read FvOrig write FvOrig;
    property vDesc: currency read FvDesc write FvDesc;
    property vLiq: currency read FvLiq write FvLiq;
  end;

  TDupCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TDupCollectionItem;
    procedure SetItem(Index: Integer; Value: TDupCollectionItem);
  public
    constructor Create(AOwner: TCobr);
    destructor Destroy; override;

    function Add: TDupCollectionItem;
    property Items[Index: Integer]: TDupCollectionItem read GetItem write SetItem; default;
  end;

  TDupCollectionItem = class(TCollectionItem)
  private
    FnDup: string;
    FdVenc: TDateTime;
    FvDup: currency;
  published
    property nDup: string read FnDup write FnDup;
    property dVenc: TDateTime read FdVenc write FdVenc;
    property vDup: currency read FvDup write FvDup;
  end;

  TInfAdic = class(TPersistent)
  private
    FinfAdFisco: string;
    FinfCpl: string;
    FobsCont: TobsContCollection;
    FobsFisco: TobsFiscoCollection;
    FprocRef: TprocRefCollection;
    procedure SetobsCont(Value: TobsContCollection);
    procedure SetobsFisco(Value: TobsFiscoCollection);
    procedure SetprocRef(Value: TprocRefCollection);
  public
    constructor Create(AOwner: TNFe);
    destructor Destroy; override;
  published
    property infAdFisco: string read FinfAdFisco write FinfAdFisco;
    property infCpl: string read FinfCpl write FinfCpl;
    property obsCont: TobsContCollection read FobsCont write SetobsCont;
    property obsFisco: TobsFiscoCollection read FobsFisco write SetobsFisco;
    property procRef: TprocRefCollection read FprocRef write SetprocRef;
  end;

  TobsContCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TobsContCollectionItem;
    procedure SetItem(Index: Integer; Value: TobsContCollectionItem);
  public
    constructor Create(AOwner: TinfAdic);
    function Add: TobsContCollectionItem;
    property Items[Index: Integer]: TobsContCollectionItem read GetItem write SetItem; default;
  end;

  TobsContCollectionItem = class(TCollectionItem)
  private
    FxCampo: string;
    FxTexto: string;
  published
    property xCampo: string read FxCampo write FxCampo;
    property xTexto: string read FxTexto write FxTexto;
  end;

  TobsFiscoCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TobsFiscoCollectionItem;
    procedure SetItem(Index: Integer; Value: TobsFiscoCollectionItem);
  public
    constructor Create(AOwner: TinfAdic);
    function Add: TobsFiscoCollectionItem;
    property Items[Index: Integer]: TobsFiscoCollectionItem read GetItem write SetItem; default;
  end;

  TobsFiscoCollectionItem = class(TCollectionItem)
  private
    FxCampo: string;
    FxTexto: string;
  published
    property xCampo: string read FxCampo write FxCampo;
    property xTexto: string read FxTexto write FxTexto;
  end;

  TprocRefCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TprocRefCollectionItem;
    procedure SetItem(Index: Integer; Value: TprocRefCollectionItem);
  public
    constructor Create(AOwner: TinfAdic);
    function Add: TprocRefCollectionItem;
    property Items[Index: Integer]: TprocRefCollectionItem read GetItem write SetItem; default;
  end;

  TprocRefCollectionItem = class(TCollectionItem)
  private
    FnProc: string;
    FindProc: TpcnIndicadorProcesso;
  published
    property nProc: string read FnProc write FnProc;
    property indProc: TpcnIndicadorProcesso read FindProc write FindProc default ipSEFAZ;
  end;

  TExporta = class(TPersistent)
  private
    FUFembarq: string;
    FxLocEmbarq: string;
  published
    property UFembarq: string read FUFembarq write FUFembarq;
    property xLocEmbarq: string read FxLocEmbarq write FxLocEmbarq;
  end;

  TCompra = class(TPersistent)
  private
    FxNEmp: string;
    FxPed: string;
    FxCont: string;
  published
    property xNEmp: string read FxNEmp write FxNEmp;
    property xPed: string read FxPed write FxPed;
    property xCont: string read FxCont write FxCont;
  end;

const

  CMUN_EXTERIOR: integer = 9999999;
  XMUN_EXTERIOR: string = 'EXTERIOR';
  UF_EXTERIOR: string = 'EX';

implementation

{ TNFe }

constructor TNFe.Create;
begin
  FinfNFe  := TinfNFe.Create;
  FIde     := TIde.Create(Self);
  FEmit    := TEmit.Create(Self);
  FAvulsa  := TAvulsa.Create;
  FDest    := TDest.Create(Self);
  FRetirada := TRetirada.Create;
  FEntrega := TEntrega.Create;
  FDet     := TDetCollection.Create(Self);
  FTotal   := TTotal.Create(self);
  FCobr    := TCobr.Create(Self);
  FTransp  := TTransp.Create(Self);
  FinfAdic := TinfAdic.Create(self);
  FExporta := TExporta.Create;
  FCompra  := TCompra.Create;
  Fsignature := Tsignature.create;
  FProcNFe := TProcNFe.create;

  FEmit.EnderEmit.xPais := 'BRASIL';
  FEmit.EnderEmit.cPais := 1058;
  FEmit.EnderEmit.nro   := 'SEM NUMERO';

  FDest.EnderDest.xPais := 'BRASIL';
  FDest.EnderDest.cPais := 1058;
  FDest.EnderDest.nro   := 'SEM NUMERO';
end;

destructor TNFe.Destroy;
begin
  FinfNFe.Free;
  FIde.Free;
  FEmit.Free;
  FAvulsa.Free;
  FDest.Free;
  FRetirada.Free;
  FEntrega.Free;
  FDet.Free;
  FTotal.Free;
  FCobr.Free;
  FTransp.Free;
  FinfAdic.Free;
  FExporta.Free;
  FCompra.Free;
  Fsignature.Free;
  FProcNFe.Free;
  inherited Destroy;
end;

procedure TNFe.SetDet(Value: TDetCollection);
begin
  FDet.Assign(Value);
end;

{ TDetCollection }

constructor TDetCollection.Create(AOwner: TNFe);
begin
  inherited Create(TDetCollectionItem);
end;

function TDetCollection.Add: TDetCollectionItem;
begin
  Result := TDetCollectionItem(inherited Add);
  Result.create;
end;

function TDetCollection.GetItem(Index: Integer): TDetCollectionItem;
begin
  Result := TDetCollectionItem(inherited GetItem(Index));
end;

procedure TDetCollection.SetItem(Index: Integer; Value: TDetCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TDetCollectionItem }

constructor TDetCollectionItem.Create;
begin
  FProd := TProd.Create(self);
  FImposto := TImposto.Create(self);
end;

{Ide}

constructor TIde.Create(AOwner: TNFe);
begin
  inherited Create;
  FNFref := TNFrefCollection.Create(Self);
end;

destructor TIde.Destroy;
begin
  FNFref.Free;
  inherited;
end;

procedure TIde.SetNFref(Value: TNFrefCollection);
begin
  FNFref.Assign(Value);
end;

{NFrefCollection}

constructor TNFrefCollection.Create(AOwner: TIde);
begin
  inherited Create(TNFrefCollectionItem);
end;

function TNFrefCollection.Add: TNFrefCollectionItem;
begin
  Result := TNFrefCollectionItem(inherited Add);
  Result.create;
end;

function TNFrefCollection.GetItem(Index: Integer): TNFrefCollectionItem;
begin
  Result := TNFrefCollectionItem(inherited GetItem(Index));
end;

procedure TNFrefCollection.SetItem(Index: Integer; Value: TNFrefCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

destructor TDetCollectionItem.Destroy;
begin
  FProd.Free;
  FImposto.Free;
  inherited;
end;

{ TNFrefCollectionItem }

constructor TNFrefCollectionItem.Create;
begin
  FRefNF := TRefNF.Create;
end;


destructor TNFrefCollectionItem.destroy;
begin
  FreeAndNil(FRefNF);
  inherited;
end;


{Emit}

constructor TEmit.Create(AOwner: TNFe);
begin
  inherited Create;
  FEnderEmit := TEnderEmit.Create;
end;

destructor TEmit.Destroy;
begin
  FEnderEmit.Free;
  inherited;
end;

{Dest}

constructor TDest.Create(AOwner: TNFe);
begin
  inherited Create;
  FEnderDest := TEnderDest.Create;
end;

destructor TDest.Destroy;
begin
  FEnderDest.Free;
  inherited;
end;

{Prod}

constructor TProd.Create(AOwner: TDetcollectionItem);
begin
  inherited Create;
  FDI := TDICollection.Create(Self);
  FveicProd := TveicProd.Create;
  FMed := TMedCollection.Create(Self);
  Farma := TArmaCollection.Create(Self);
  Fcomb := TComb.Create(Self);
end;

destructor TProd.Destroy;
begin
  FDI.Free;
  FveicProd.Free;
  FMed.Free;
  FArma.Free;
  Fcomb.Free;
  inherited;
end;

procedure TProd.SetDI(Value: TDICollection);
begin
  FDI.Assign(Value);
end;

procedure TProd.SetMed(Value: TMedCollection);
begin
  FMed.Assign(Value);
end;

procedure TProd.SetArma(Value: TArmaCollection);
begin
  FArma.Assign(Value);
end;

{MedCollection}

constructor TMedCollection.Create(AOwner: TProd);
begin
  inherited Create(TMedCollectionItem);
end;

function TMedCollection.Add: TMedCollectionItem;
begin
  Result := TMedCollectionItem(inherited Add);
end;

function TMedCollection.GetItem(Index: Integer): TMedCollectionItem;
begin
  Result := TMedCollectionItem(inherited GetItem(Index));
end;

procedure TMedCollection.SetItem(Index: Integer; Value: TMedCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ArmaCollection}

constructor TArmaCollection.Create(AOwner: TProd);
begin
  inherited Create(TArmaCollectionItem);
end;

function TArmaCollection.Add: TArmaCollectionItem;
begin
  Result := TArmaCollectionItem(inherited Add);
end;

function TArmaCollection.GetItem(Index: Integer): TArmaCollectionItem;
begin
  Result := TArmaCollectionItem(inherited GetItem(Index));
end;

procedure TArmaCollection.SetItem(Index: Integer; Value: TArmaCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{comb}

constructor Tcomb.Create(AOwner: TProd);
begin
  inherited Create;
  FCIDE := TCIDE.Create;
  FICMS := TICMSComb.Create;
  FICMSInter := TICMSInter.Create;
  FICMScons := TICMScons.Create;
end;

destructor Tcomb.Destroy;
begin
  FCIDE.Free;
  FICMS.Free;
  FICMSInter.Free;
  FICMScons.Free;
  inherited;
end;

{DICollection}

constructor TDICollection.Create(AOwner: TProd);
begin
  inherited Create(TDICollectionItem);
end;

function TDICollection.Add: TDICollectionItem;
begin
  Result := TDICollectionItem(inherited Add);
  Result.create;
end;

function TDICollection.GetItem(Index: Integer): TDICollectionItem;
begin
  Result := TDICollectionItem(inherited GetItem(Index));
end;

procedure TDICollection.SetItem(Index: Integer; Value: TDICollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{DICollectionItem}

constructor TDICollectionItem.Create;
begin
  FAdi := TadiCollection.Create(self);
end;

destructor TDICollectionItem.Destroy;
begin
  FAdi.Free;
  inherited;
end;

procedure TDICollectionItem.SetAdi(Value: TAdiCollection);
begin
  FAdi.Assign(Value);
end;

{AdiCollection}

constructor TAdiCollection.Create(AOwner: TDiCollectionItem);
begin
  inherited Create(TAdiCollectionItem);
end;

function TAdiCollection.Add: TAdiCollectionItem;
begin
  Result := TAdiCollectionItem(inherited Add);
end;

function TAdiCollection.GetItem(Index: Integer): TAdiCollectionItem;
begin
  Result := TAdiCollectionItem(inherited GetItem(Index));
end;

procedure TAdiCollection.SetItem(Index: Integer; Value: TAdiCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{Imposto}

constructor TImposto.Create(AOwner: TDetcollectionItem);
begin
  inherited Create;
  FICMS := TICMS.Create;
  FIPI := TIPI.Create;
  FII := TII.Create;
  FPIS := TPIS.Create;
  FPISST := TPISST.Create;
  FCOFINS := TCOFINS.Create;
  FCOFINSST := TCOFINSST.Create;
  FISSQN := TISSQN.create;
end;

destructor TImposto.Destroy;
begin
  FICMS.Free;
  FIPI.Free;
  FII.Free;
  FPIS.Free;
  FPISST.Free;
  FCOFINS.Free;
  FCOFINSST.Free;
  FISSQN.Free;
  inherited;
end;

{Total}

constructor TTotal.Create(AOwner: TNFe);
begin
  inherited Create;
  FICMSTot := TICMSTot.Create;
  FISSQNtot := TISSQNtot.create;
  FretTrib := TretTrib.create;
end;

destructor TTotal.Destroy;
begin
  FICMSTot.Free;
  FISSQNtot.Free;
  FretTrib.Free;
  inherited;
end;

{Transp}

constructor TTransp.Create(AOwner: TNFe);
begin
  inherited Create;
  FTransporta := TTransporta.Create;
  FretTransp := TretTransp.Create(self);
  FveicTransp := TveicTransp.Create;
  FVol := TVolCollection.Create(self);
  Freboque := TreboqueCollection.Create(self);
end;

destructor TTransp.Destroy;
begin
  FTransporta.Free;
  FretTransp.Free;
  FveicTransp.Free;
  FVol.Free;
  Freboque.Free;
  inherited;
end;

procedure TTransp.SetVol(Value: TVolCollection);
begin
  FVol.Assign(Value);
end;

procedure TTransp.SetReboque(Value: TReboqueCollection);
begin
  FReboque.Assign(Value);
end;

{VolCollection}

constructor TVolCollection.Create(AOwner: TTransp);
begin
  inherited Create(TVolCollectionItem);
end;

function TVolCollection.Add: TVolCollectionItem;
begin
  Result := TVolCollectionItem(inherited Add);
  Result.create;
end;

function TVolCollection.GetItem(Index: Integer): TVolCollectionItem;
begin
  Result := TVolCollectionItem(inherited GetItem(Index));
end;

procedure TVolCollection.SetItem(Index: Integer; Value: TVolCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{VolCollectionItem}

constructor TVolCollectionItem.Create;
begin
  FLacres := TLacresCollection.Create(self);
end;

destructor TVolCollectionItem.Destroy;
begin
  FLacres.Free;
  inherited;
end;

procedure TVolCollectionItem.SetLacres(Value: TLacresCollection);
begin
  FLacres.Assign(Value);
end;

{LacresCollection}

constructor TLacresCollection.Create(AOwner: TVolCollectionItem);
begin
  inherited Create(TLacresCollectionItem);
end;

function TLacresCollection.Add: TLacresCollectionItem;
begin
  Result := TLacresCollectionItem(inherited Add);
end;

function TLacresCollection.GetItem(Index: Integer): TLacresCollectionItem;
begin
  Result := TLacresCollectionItem(inherited GetItem(Index));
end;

procedure TLacresCollection.SetItem(Index: Integer; Value: TLacresCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{retTransp}

constructor TretTransp.Create(AOwner: TTransp);
begin
  inherited Create;
end;

{ReboqueCollection}

constructor TReboqueCollection.Create(AOwner: TTransp);
begin
  inherited Create(TReboqueCollectionItem);
end;

function TreboqueCollection.Add: TreboqueCollectionItem;
begin
  Result := TreboqueCollectionItem(inherited Add);
end;

function TreboqueCollection.GetItem(Index: Integer): TreboqueCollectionItem;
begin
  Result := TreboqueCollectionItem(inherited GetItem(Index));
end;

procedure TreboqueCollection.SetItem(Index: Integer; Value: TreboqueCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{Cobr}

constructor TCobr.Create(AOwner: TNFe);
begin
  inherited Create;
  FFat := TFat.Create;
  FDup := TDupCollection.Create(self);
end;

destructor TCobr.Destroy;
begin
  FFat.Free;
  FDup.Free;
  inherited;
end;

procedure TCobr.SetDup(Value: TDupCollection);
begin
  FDup.Assign(Value);
end;

{ TDupCollection }

constructor TDupCollection.Create(AOwner: TCobr);
begin
  inherited Create(TDupCollectionItem);
end;

function TDupCollection.Add: TDupCollectionItem;
begin
  Result := TDupCollectionItem(inherited Add);
end;

function TDupCollection.GetItem(Index: Integer): TDupCollectionItem;
begin
  Result := TDupCollectionItem(inherited GetItem(Index));
end;

procedure TDupCollection.SetItem(Index: Integer; Value: TDupCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{infAdic}

constructor TinfAdic.Create(AOwner: TNFe);
begin
  inherited Create;
  FobsCont := TobsContCollection.Create(Self);
  FobsFisco := TobsFiscoCollection.Create(Self);
  FprocRef := TprocRefCollection.Create(Self);
end;

destructor TinfAdic.Destroy;
begin
  FobsCont.Free;
  FobsFisco.Free;
  FprocRef.Free;
  inherited;
end;

procedure TinfAdic.SetobsCont(Value: TobsContCollection);
begin
  FobsCont.Assign(Value);
end;

procedure TinfAdic.SetobsFisco(Value: TobsFiscoCollection);
begin
  FobsFisco.Assign(Value);
end;

procedure TinfAdic.SetprocRef(Value: TprocRefCollection);
begin
  FprocRef.Assign(Value);
end;

{obsContCollection}

constructor TobsContCollection.Create(AOwner: TinfAdic);
begin
  inherited Create(TobsContCollectionItem);
end;

function TobsContCollection.Add: TobsContCollectionItem;
begin
  Result := TobsContCollectionItem(inherited Add);
end;

function TobsContCollection.GetItem(Index: Integer): TobsContCollectionItem;
begin
  Result := TobsContCollectionItem(inherited GetItem(Index));
end;

procedure TobsContCollection.SetItem(Index: Integer; Value: TobsContCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{obsFiscoCollection}

constructor TobsFiscoCollection.Create(AOwner: TinfAdic);
begin
  inherited Create(TobsFiscoCollectionItem);
end;

function TobsFiscoCollection.Add: TobsFiscoCollectionItem;
begin
  Result := TobsFiscoCollectionItem(inherited Add);
end;

function TobsFiscoCollection.GetItem(Index: Integer): TobsFiscoCollectionItem;
begin
  Result := TobsFiscoCollectionItem(inherited GetItem(Index));
end;

procedure TobsFiscoCollection.SetItem(Index: Integer; Value: TobsFiscoCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{procRefCollection}

constructor TprocRefCollection.Create(AOwner: TinfAdic);
begin
  inherited Create(TprocRefCollectionItem);
end;

function TprocRefCollection.Add: TprocRefCollectionItem;
begin
  Result := TprocRefCollectionItem(inherited Add);
end;

function TprocRefCollection.GetItem(Index: Integer): TprocRefCollectionItem;
begin
  Result := TprocRefCollectionItem(inherited GetItem(Index));
end;

procedure TprocRefCollection.SetItem(Index: Integer; Value: TprocRefCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

destructor TMedCollection.Destroy;
begin
  inherited;
end;

destructor TArmaCollection.Destroy;
begin
  inherited Destroy;
end;

destructor TDupCollection.Destroy;
begin
  inherited;
end;

end.

