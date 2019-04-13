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

unit ACBrEFDBloco_1;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils, ACBrEFDBlocos;

type
  TRegistro1100List = class;
  TRegistro1105List = class;
  TRegistro1110List = class;
  TRegistro1200List = class;
  TRegistro1210List = class;
  TRegistro1300List = class;
  TRegistro1310List = class;
  TRegistro1320List = class;
  TRegistro1350List = class;
  TRegistro1360List = class;
  TRegistro1370List = class;
  TRegistro1400List = class;
  TRegistro1500List = class;
  TRegistro1510List = class;
  TRegistro1600List = class;
  TRegistro1700List = class;
  TRegistro1710List = class;
  TRegistro1800List = class;

  /// Registro 1001 - ABERTURA DO BLOCO 1

  TRegistro1001 = class(TOpenBlocos)
  private
    FRegistro1100: TRegistro1100List;
    FRegistro1200: TRegistro1200List;
    FRegistro1300: TRegistro1300List;
    FRegistro1350: TRegistro1350List;
    FRegistro1400: TRegistro1400List;
    FRegistro1500: TRegistro1500List;
    FRegistro1600: TRegistro1600List;
    FRegistro1700: TRegistro1700List;
    FRegistro1800: TRegistro1800List;
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property Registro1100: TRegistro1100List read FRegistro1100 write FRegistro1100;
    property Registro1200: TRegistro1200List read FRegistro1200 write FRegistro1200;
    property Registro1300: TRegistro1300List read FRegistro1300 write FRegistro1300;
    property Registro1350: TRegistro1350List read FRegistro1350 write FRegistro1350;
    property Registro1400: TRegistro1400List read FRegistro1400 write FRegistro1400;
    property Registro1500: TRegistro1500List read FRegistro1500 write FRegistro1500;
    property Registro1600: TRegistro1600List read FRegistro1600 write FRegistro1600;
    property Registro1700: TRegistro1700List read FRegistro1700 write FRegistro1700;
    property Registro1800: TRegistro1800List read FRegistro1800 write FRegistro1800;
  end;

  /// Registro 1100 - REGISTRO DE INFORMAÇÕES SOBRE EXPORTAÇÃO

  TRegistro1100 = class
  private
    fIND_DOC: TACBrTipoDocto;     /// Informe o tipo de documento: 0 - Declaração de Exportação, 1 - Declaração Simplificada de Exportação.
    fNRO_DE: String;              /// Número da declaração
    fDT_DE: TDateTime;            /// Data da declaração (DDMMAAAA)
    fNAT_EXP: TACBrExportacao;    /// Preencher com: 0 - Exportação Direta, 1 - Exportação Indireta
    fNRO_RE: String;              /// Nº do registro de Exportação
    fDT_RE: TDateTime;            /// Data do Registro de Exportação (DDMMAAAA)
    fCHC_EMB: String;             /// Nº do conhecimento de embarque
    fDT_CHC: TDateTime;           /// Data do conhecimento de embarque (DDMMAAAA)
    fDT_AVB: TDateTime;           /// Data da averbação da Declaração de exportação (ddmmaaaa)
    fTP_CHC: TACBrConhecEmbarque; /// Informação do tipo de conhecimento de transporte : 01 - AWB; 02 - MAWB; 03 - HAWB;04 - COMAT; 06 - R. EXPRESSAS; 07 - ETIQ. REXPRESSAS; 08 - HR. EXPRESSAS; 09 - AV7; 10 - BL; 11 - MBL; 12 - HBL; 13 - CRT; 14 - DSIC; 16 - COMAT BL; 17 - RWB; 18 - HRWB; 19 - TIF/DTA; 20 - CP2; 91 - NÂO IATA; 92 - MNAO IATA; 93 - HNAO IATA; 99 - OUTROS.
    fPAIS: String;                /// Código do país de destino da mercadoria (Preencher conforme tabela do SISCOMEX)

    fRegistro1105: TRegistro1105List;
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property IND_DOC: TACBrTipoDocto read FIND_DOC write FIND_DOC;
    property NRO_DE: String read FNRO_DE write FNRO_DE;
    property DT_DE: TDateTime read FDT_DE write FDT_DE;
    property NAT_EXP: TACBrExportacao read FNAT_EXP write FNAT_EXP;
    property NRO_RE: String read FNRO_RE write FNRO_RE;
    property DT_RE: TDateTime read FDT_RE write FDT_RE;
    property CHC_EMB: String read FCHC_EMB write FCHC_EMB;
    property DT_CHC: TDateTime read FDT_CHC write FDT_CHC;
    property DT_AVB: TDateTime read FDT_AVB write FDT_AVB;
    property TP_CHC: TACBrConhecEmbarque read FTP_CHC write FTP_CHC;
    property PAIS: String read FPAIS write FPAIS;
    //
    property Registro1105: TRegistro1105List read FRegistro1105 write FRegistro1105;
  end;

  /// Registro 1100 - Lista

  TRegistro1100List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1100;
    procedure SetItem(Index: Integer; const Value: TRegistro1100);
  public
    function New: TRegistro1100;
    property Items[Index: Integer]: TRegistro1100 read GetItem write SetItem;
  end;

  /// Registro 1105 - DOCUMENTOS FISCAIS DE EXPORTAÇÃO

  TRegistro1105 = class
  private
    fCOD_MOD: String;       /// Código do modelo da NF, conforme tabela 4.1.1
    fSERIE: String;         /// Série da Nota Fiscal
    fNUM_DOC: String;       /// Número de Nota Fiscal de Exportação emitida pelo Exportador
    fCHV_NFE: String;       /// Chave da Nota Fiscal Eletrônica
    fDT_DOC: TDateTime;        /// Data da emissão da NF de exportação
    fCOD_ITEM: String;      /// Código do item (campo 02 do Registro 0200)

    fRegistro1110: TRegistro1110List;
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property COD_MOD: String read FCOD_MOD write FCOD_MOD;
    property SERIE: String read FSERIE write FSERIE;
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    property CHV_NFE: String read FCHV_NFE write FCHV_NFE;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property COD_ITEM: String read FCOD_ITEM write FCOD_ITEM;
    //
    property Registro1110: TRegistro1110List read FRegistro1110 write FRegistro1110;
  end;

  /// Registro 1105 - Lista

  TRegistro1105List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1105;
    procedure SetItem(Index: Integer; const Value: TRegistro1105);
  public
    function New: TRegistro1105;
    property Items[Index: Integer]: TRegistro1105 read GetItem write SetItem;
  end;

  /// Registro 1110 - OPERAÇÕES DE EXPORTAÇÃO INDIRETA DE PRODUTOS NÃO INDUSTRIALIZADOS PELO ESTABELECIMENTO EMITENTE.

  TRegistro1110 = class
  private
    fCOD_PART: String;      /// Código do participante-Fornecedor da Mercadoria destinada à exportação (campo 02 do Registro 0150)
    fCOD_MOD: String;       /// Código do documento fiscal, conforme a Tabela 4.1.1
    fSER: String;           /// Série do documento fiscal recebido com fins específicos de exportação.
    fNUM_DOC: String;       /// Número do documento fiscal recebido com fins específicos de exportação.
    fDT_DOC: TDateTime;        /// Data da emissão do documento fiscal recebido com fins específicos de exportação
    fCHV_NFE: String;       /// Chave da Nota Fiscal Eletrônica
    fNR_MEMO: String;           /// Número do Memorando de Exportação
    fQTD: Double;           /// Quantidade do item efetivamente exportado.
    fUNID: String;          /// Unidade do item (Campo 02 do registro 0190)
  public
    property COD_PART: String read FCOD_PART write FCOD_PART;
    property COD_MOD: String read FCOD_MOD write FCOD_MOD;
    property SER: String read FSER write FSER;
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CHV_NFE: String read FCHV_NFE write FCHV_NFE;
    property NR_MEMO: String read FNR_MEMO write FNR_MEMO;
    property QTD: Double read FQTD write FQTD;
    property UNID: String read FUNID write FUNID;
  end;

  /// Registro 1110 - Lista

  TRegistro1110List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1110;
    procedure SetItem(Index: Integer; const Value: TRegistro1110);
  public
    function New: TRegistro1110;
    property Items[Index: Integer]: TRegistro1110 read GetItem write SetItem;
  end;

  /// Registro 1200 - OPERAÇÕES DE EXPORTAÇÃO INDIRETA DE PRODUTOS NÃO INDUSTRIALIZADOS PELO ESTABELECIMENTO EMITENTE.

  TRegistro1200 = class
  private
    fCOD_AJ_APUR : String;      /// Código de ajuste, conforme informado na Tabela indicada no item 5.1.1.
    fSLD_CRED    : Currency;        /// Saldo de créditos fiscais de períodos anteriores
    fCRED_APR    : Currency;        /// Total de crédito apropriado no mês
    fCRED_RECEB  : Currency;        /// Total de créditos recebidos por transferência
    fCRED_UTIL   : Currency;        /// Total de créditos utilizados no período
    fSLD_CRED_FIM: Currency;        /// Saldo de crédito fiscal acumulado a transportar para o período seguinte

    FRegistro1210: TRegistro1210List;
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property COD_AJ_APUR : String read FCOD_AJ_APUR  write FCOD_AJ_APUR;
    property SLD_CRED    : Currency   read FSLD_CRED     write FSLD_CRED;
    property CRED_APR    : Currency   read FCRED_APR     write FCRED_APR;
    property CRED_RECEB  : Currency   read FCRED_RECEB   write FCRED_RECEB;
    property CRED_UTIL   : Currency   read FCRED_UTIL    write FCRED_UTIL;
    property SLD_CRED_FIM: Currency   read FSLD_CRED_FIM write FSLD_CRED_FIM;
    //
    property Registro1210: TRegistro1210List read FRegistro1210 write FRegistro1210;
  end;

  /// Registro 1200 - Lista

  TRegistro1200List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1200;
    procedure SetItem(Index: Integer; const Value: TRegistro1200);
  public
    function New: TRegistro1200;
    property Items[Index: Integer]: TRegistro1200 read GetItem write SetItem;
  end;

  /// Registro 1210 - UTILIZAÇÃO DE CRÉDITOS FISCAIS - ICMS.

  TRegistro1210 = class
  private
    fTIPO_UTIL: String;        /// Tipo de utilização do crédito:
    fNR_DOC: String;           /// Número do documento utilizado na baixa de créditos
    fVL_CRED_UTIL: Currency;     /// Total de crédito utilizado
  public
    property TIPO_UTIL: String read FTIPO_UTIL write FTIPO_UTIL;
    property NR_DOC: String read FNR_DOC write FNR_DOC;
    property VL_CRED_UTIL: Currency read FVL_CRED_UTIL write FVL_CRED_UTIL;
  end;

  /// Registro 1210 - Lista

  TRegistro1210List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1210;
    procedure SetItem(Index: Integer; const Value: TRegistro1210);
  public
    function New: TRegistro1210;
    property Items[Index: Integer]: TRegistro1210 read GetItem write SetItem;
  end;

  /// Registro 1300 - MOVIMENTAÇÃO DE COMBUSTÍVEIS.

  TRegistro1300 = class
  private
    fCOD_ITEM: String;             /// Código do Produto constante do registro 0200
    fDT_FECH: TDateTime;               /// Data do fechamento da movimentação
    fESTQ_ABERT: Double;               /// Estoque no inicio do dia
    fVOL_ENTR: Double;                 /// Volume Total das Entradas
    fVOL_DISP: Double;                 /// Volume Disponível (05 + 06)
    fVOL_SAIDAS: Double;               /// Volume Total das Saídas (Somatório dos registros de Volume de Vendas)
    fESTQ_ESCR: Double;                /// Estoque Escritural (07 - 08)
    fVAL_AJ_PERDA: Double;             /// Valor da Perda
    fVAL_AJ_GANHO: Double;             /// Valor do ganho
    fFECH_FISICO:  Double;             /// Volume aferido no tanque, em litros. Estoque de fechamento físico do tanque

    FRegistro1310: TRegistro1310List;  /// BLOCO 1 - Lista de Registro1310 (FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property COD_ITEM: String       read FCOD_ITEM     write FCOD_ITEM;
    property DT_FECH: TDateTime     read FDT_FECH      write FDT_FECH;
    property ESTQ_ABERT: Double     read FESTQ_ABERT   write FESTQ_ABERT;
    property VOL_ENTR: Double       read FVOL_ENTR     write FVOL_ENTR;
    property VOL_DISP: Double       read FVOL_DISP     write FVOL_DISP;
    property VOL_SAIDAS: Double     read FVOL_SAIDAS   write FVOL_SAIDAS;
    property ESTQ_ESCR: Double      read FESTQ_ESCR    write FESTQ_ESCR;
    property VAL_AJ_PERDA: Double   read FVAL_AJ_PERDA write FVAL_AJ_PERDA;
    property VAL_AJ_GANHO: Double   read FVAL_AJ_GANHO write FVAL_AJ_GANHO;
    property FECH_FISICO : Double   read fFECH_FISICO  write fFECH_FISICO;

    property Registro1310: TRegistro1310List read FRegistro1310 write FRegistro1310;
  end;

  /// Registro 1300 - Lista

  TRegistro1300List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1300;
    procedure SetItem(Index: Integer; const Value: TRegistro1300);
  public
    function New: TRegistro1300;
    property Items[Index: Integer]: TRegistro1300 read GetItem write SetItem;
  end;

  /// Registro 1310 - VOLUME DE VENDAS.

  TRegistro1310 = class
  private
    fNUM_TANQUE:   String; /// Tanque onde foi armazenado o combustível
    fESTQ_ABERT:   Double;     /// Estoque no inicio do dia, em litros
    fVOL_ENTR:     Double;     /// Volume Recebido no dia (em litros)
    fVOL_DISP:     Double;     /// Volume Disponível (03 + 04), em litros
    fVOL_SAIDAS:   Double;     /// Volume Total das Saídas, em litros
    fESTQ_ESCR :   Double;     /// Estoque Escritural(05 – 06), litros
    fVAL_AJ_PERDA: Double;     /// Valor da Perda, em litros
    fVAL_AJ_GANHO: Double;     /// Valor do ganho, em litros
    fFECH_FISICO:  Double;     /// Volume aferido no tanque, em litros. Estoque de fechamento físico do tanque

    FRegistro1320: TRegistro1320List;  /// BLOCO 1 - Lista de Registro1320 (FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property NUM_TANQUE  : String   read fNUM_TANQUE   write fNUM_TANQUE;
    property ESTQ_ABERT  : Double       read fESTQ_ABERT   write fESTQ_ABERT;
    property VOL_ENTR    : Double       read fVOL_ENTR     write fVOL_ENTR;
    property VOL_DISP    : Double       read fVOL_DISP     write fVOL_DISP;
    property VOL_SAIDAS  : Double       read fVOL_SAIDAS   write fVOL_SAIDAS;
    property ESTQ_ESCR   : Double       read fESTQ_ESCR    write fESTQ_ESCR;
    property VAL_AJ_PERDA: Double       read fVAL_AJ_PERDA write fVAL_AJ_PERDA;
    property VAL_AJ_GANHO: Double       read fVAL_AJ_GANHO write fVAL_AJ_GANHO;
    property FECH_FISICO : Double       read fFECH_FISICO  write fFECH_FISICO;

    property Registro1320: TRegistro1320List read FRegistro1320 write FRegistro1320;
  end;

  /// Registro 1310 - Lista

  TRegistro1310List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1310;
    procedure SetItem(Index: Integer; const Value: TRegistro1310);
  public
    function New: TRegistro1310;
    property Items[Index: Integer]: TRegistro1310 read GetItem write SetItem;
  end;

  /// Registro 1320 - VOLUME DE VENDAS

  TRegistro1320 = class
  private
    fNUM_BICO   : String;       /// Bico Ligado à Bomba
    fNR_INTERV  : String;       /// Número da intervenção
    fMOT_INTERV : String;       /// Motivo da Intervenção
    fNOM_INTERV : String;       /// Nome do Interventor
    fCNPJ_INTERV: String;       /// CNPJ da empresa responsável pela intervenção
    fCPF_INTERV : String;       /// CPF do técnico responsável pela intervenção
    fVAL_FECHA  : Double;       /// Valor da leitura final do contador, no fechamento do bico
    fVAL_ABERT  : Double;       /// Valor da leitura inicial do contador, na abertura do bico
    fVOL_AFERI  : Double;       /// Aferições da Bomba, em litros
    fVOL_VENDAS : Double;       /// Vendas (08 – 09 - 10 ) do bico, em litros
  public
    property NUM_BICO:String       read fNUM_BICO    write fNUM_BICO    ;
    property NR_INTERV:String      read fNR_INTERV   write fNR_INTERV   ;
    property MOT_INTERV:String     read fMOT_INTERV  write fMOT_INTERV  ;
    property NOM_INTERV:String     read fNOM_INTERV  write fNOM_INTERV  ;
    property CNPJ_INTERV:String    read fCNPJ_INTERV write fCNPJ_INTERV ;
    property CPF_INTERV:String     read fCPF_INTERV  write fCPF_INTERV  ;
    property VAL_FECHA:Double          read fVAL_FECHA   write fVAL_FECHA   ;
    property VAL_ABERT:Double          read fVAL_ABERT   write fVAL_ABERT   ;
    property VOL_AFERI:Double          read fVOL_AFERI   write fVOL_AFERI   ;
    property VOL_VENDAS:Double         read fVOL_VENDAS  write fVOL_VENDAS  ;
  end;

  /// Registro 1320 - Lista

  TRegistro1320List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1320;
    procedure SetItem(Index: Integer; const Value: TRegistro1320);
  public
    function New: TRegistro1320;
    property Items[Index: Integer]: TRegistro1320 read GetItem write SetItem;
  end;


  /// Registro 1350 - BOMBAS

  TRegistro1350 = class
  private
    fSERIE: String;              /// Número de Série da Bomba
    fFABRICANTE: String;         /// Nome do Fabricante da Bomba
    fMODELO: String;             /// Modelo da Bomba
    fTIPO_MEDICAO: TACBrMedicao; /// Identificador de medição: [ 0 - analógico -  1 – digital ]

    FRegistro1360: TRegistro1360List;  /// BLOCO 1 - Lista de Registro1360 (FILHO)
    FRegistro1370: TRegistro1370List;  /// BLOCO 1 - Lista de Registro1360 (FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property SERIE:        String read fSERIE        write fSERIE       ;
    property FABRICANTE:   String read fFABRICANTE   write fFABRICANTE  ;
    property MODELO:       String read fMODELO       write fMODELO      ;
    property TIPO_MEDICAO: TACBrMedicao read fTIPO_MEDICAO write fTIPO_MEDICAO;

    property Registro1360: TRegistro1360List read FRegistro1360 write FRegistro1360;
    property Registro1370: TRegistro1370List read FRegistro1370 write FRegistro1370;
  end;

  /// Registro 1350 - Lista

  TRegistro1350List = class(TObjectList)
  private
    function  GetItem(Index: Integer): TRegistro1350;
    procedure SetItem(Index: Integer; const Value: TRegistro1350);
  public
    function New: TRegistro1350;
    property Items[Index: Integer]: TRegistro1350 read GetItem write SetItem;
  end;

  /// Registro 1360: LACRES DA BOMBA
  TRegistro1360 = class
  private
    fNUM_LACRE: String;         /// Número de Série da Bomba
    fDT_APLICACAO: TDateTime;   /// Nome do Fabricante da Bomba
  public
    property NUM_LACRE:    String    read fNUM_LACRE     write fNUM_LACRE    ;
    property DT_APLICACAO: TDateTime read fDT_APLICACAO  write fDT_APLICACAO ;
  end;

  /// Registro 1360 - Lista

  TRegistro1360List = class(TObjectList)
  private
    function  GetItem(Index: Integer): TRegistro1360;
    procedure SetItem(Index: Integer; const Value: TRegistro1360);
  public
    function New: TRegistro1360;
    property Items[Index: Integer]: TRegistro1360 read GetItem write SetItem;
  end;

  /// Registro 1370 - BICOS DA BOMBA

  TRegistro1370 = class
  private
      fNUM_BICO:String;    /// Número seqüencial do bico ligado a bomba N 003 - O
      fCOD_ITEM:String;    /// Código do Produto, constante do registro 0200 C 060 - O
      fNUM_TANQUE:String;  /// Tanque que armazena o combustível.
  public
    property   NUM_BICO  :String read fNUM_BICO   write fNUM_BICO  ;    /// Número seqüencial do bico ligado a bomba
    property   COD_ITEM  :String read fCOD_ITEM   write fCOD_ITEM  ;    /// Código do Produto, constante do registro
    property   NUM_TANQUE:String read fNUM_TANQUE write fNUM_TANQUE;  /// Tanque que armazena o combustível.
  end;

  /// Registro 1370  - Lista

  TRegistro1370List = class(TObjectList)
  private
    function  GetItem(Index: Integer): TRegistro1370 ;
    procedure SetItem(Index: Integer; const Value: TRegistro1370 );
  public
    function New: TRegistro1370 ;
    property Items[Index: Integer]: TRegistro1370  read GetItem write SetItem;
  end;


  /// Registro 1400 - CINFORMAÇÃO SOBRE VALORES AGREGADOS.

  TRegistro1400 = class
  private
    fCOD_ITEM: String;      /// Código do item (campo 02 do Registro 0200)
    fMUN: String;           /// Código do Município de origem
    fVALOR: Currency;      /// Valor mensal correspondente ao município
  public
    property COD_ITEM: String read FCOD_ITEM write FCOD_ITEM;
    property MUN: String read FMUN write FMUN;
    property VALOR: Currency read FVALOR write FVALOR;
  end;

  /// Registro 1400 - Lista

  TRegistro1400List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1400;
    procedure SetItem(Index: Integer; const Value: TRegistro1400);
  public
    function New: TRegistro1400;
    property Items[Index: Integer]: TRegistro1400 read GetItem write SetItem;
  end;

  /// Registro 1500 - NOTA FISCAL/CONTA DE ENERGIA ELÉTRICA (CÓDIGO 06) - OPERAÇÕES INTERESTADUAIS.

  TRegistro1500 = class
  private
    fIND_OPER: String;                   /// Indicador do tipo de operação:
    fIND_EMIT: String;                   /// Indicador do emitente do documento fiscal:
    fCOD_PART: String;                   /// Código do participante (campo 02 do Registro 0150):
    fCOD_MOD: String;                    /// Código do modelo do documento fiscal conforme a Tabela 4.1.1
    fCOD_SIT: TACBrSituacaoDocto;        /// Código da situação do documento fiscal conforme a Tabela 4.1.2
    fSER: String;                        /// Série do documento fiscal
    fSUB: String;                        /// Subsérie do documento fiscal
    fCOD_CONS: TACBrClasseConsumo;       /// Código de classe de consumo de energia elétrica conforme a Tabela 4.4.5 ou Código da classe de consumo de gás canalizado conforme Tabela 4.4.3.
    fNUM_DOC: String;                    /// Número do documento fiscal
    fDT_DOC: TDateTime;                  /// Data da emissão do documento fiscal
    fDT_E_S: TDateTime;                  /// Data da entrada ou da saída
    fVL_DOC: currency;                   /// Valor total do documento fiscal
    fVL_DESC: currency;                  /// Valor total do desconto
    fVL_FORN: currency;                  /// Valor total fornecido/consumido
    fVL_SERV_NT: currency;               /// Valor total dos serviços não-tributados pelo ICMS
    fVL_TERC: currency;                  /// Valor total cobrado em nome de terceiros
    fVL_DA: currency;                    /// Valor total de despesas acessórias indicadas no documento fiscal
    fVL_BC_ICMS: currency;               /// Valor acumulado da base de cálculo do ICMS
    fVL_ICMS: currency;                  /// Valor acumulado do ICMS
    fVL_BC_ICMS_ST: currency;            /// Valor acumulado da base de cálculo do ICMS substituição tributária
    fVL_ICMS_ST: currency;               /// Valor acumulado do ICMS retido por substituição tributária
    fCOD_INF: String;                    /// Código da informação complementar do documento fiscal (campo 02 do Registro 0450)
    fVL_PIS: currency;                   /// Valor do PIS
    fVL_COFINS: currency;                /// Valor da COFINS
    fTP_LIGACAO: TACBrTipoLigacao;       /// Código de tipo de Ligação [ 1 - Monofásico 2 - Bifásico 3 - Trifásico ]
    fCOD_GRUPO_TENSAO: TACBrGrupoTensao; /// Código de grupo de tensão: Vide Manual Registro C500 Campo 27

    FRegistro1510: TRegistro1510List;
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property IND_OPER: String read FIND_OPER write FIND_OPER;
    property IND_EMIT: String read FIND_EMIT write FIND_EMIT;
    property COD_PART: String read FCOD_PART write FCOD_PART;
    property COD_MOD: String read FCOD_MOD write FCOD_MOD;
    property COD_SIT: TACBrSituacaoDocto read FCOD_SIT write FCOD_SIT;
    property SER: String read FSER write FSER;
    property SUB: String read FSUB write FSUB;
    property COD_CONS: TACBrClasseConsumo read FCOD_CONS write FCOD_CONS;
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_E_S: TDateTime read FDT_E_S write FDT_E_S;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_FORN: currency read FVL_FORN write FVL_FORN;
    property VL_SERV_NT: currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_TERC: currency read FVL_TERC write FVL_TERC;
    property VL_DA: currency read FVL_DA write FVL_DA;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property COD_INF: String read FCOD_INF write FCOD_INF;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property TP_LIGACAO:        TACBrTipoLigacao read fTP_LIGACAO       write fTP_LIGACAO;
    property COD_GRUPO_TENSAO:  TACBrGrupoTensao read fCOD_GRUPO_TENSAO write fCOD_GRUPO_TENSAO;
    //
    property Registro1510: TRegistro1510List read FRegistro1510 write FRegistro1510;
  end;

  /// Registro 1500 - Lista

  TRegistro1500List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1500;
    procedure SetItem(Index: Integer; const Value: TRegistro1500);
  public
    function New: TRegistro1500;
    property Items[Index: Integer]: TRegistro1500 read GetItem write SetItem;
  end;

  /// Registro 1510 - ITENS DO DOCUMENTO NOTA FISCAL/CONTA ENERGIA ELÉTRICA (CÓDIGO 06).

  TRegistro1510 = class
  private
    fNUM_ITEM: String;             /// Número seqüencial do item no documento fiscal
    fCOD_ITEM: String;             /// Código do item (campo 02 do Registro 0200)
    fCOD_CLASS: String;            /// Código de classificação do item de energia elétrica, conforme a Tabela 4.4.1
    fQTD: Double;                  /// Quantidade do item
    fUNID: String;                 /// Unidade do item (Campo 02 do registro 0190)
    fVL_ITEM: currency;            /// Valor do item
    fVL_DESC: currency;            /// Valor total do desconto
    fCST_ICMS: String;             /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1
    fCFOP: String;                 /// Código Fiscal de Operação e Prestação
    fVL_BC_ICMS: currency;         /// Valor da base de cálculo do ICMS
    fALIQ_ICMS: currency;          /// Alíquota do ICMS
    fVL_ICMS: currency;            /// Valor do ICMS creditado/debitado
    fVL_BC_ICMS_ST: currency;      /// Valor da base de cálculo referente à substituição tributária
    fALIQ_ST: currency;            /// Alíquota do ICMS da substituição tributária na unidade da federação de destino
    fVL_ICMS_ST: currency;         /// Valor do ICMS referente à substituição tributária
    fIND_REC: TACBrTipoReceita;    /// Indicador do tipo de receita:
    fCOD_PART: String;             /// Código do participante receptor da receita, terceiro da operação (campo 02 do Registro 0150)
    fVL_PIS: currency;             /// Valor do PIS
    fVL_COFINS: currency;          /// Valor da COFINS
    fCOD_CTA: String;              /// Código da conta analítica contábil debitada/creditada
  public
    property NUM_ITEM: String read FNUM_ITEM write FNUM_ITEM;
    property COD_ITEM: String read FCOD_ITEM write FCOD_ITEM;
    property COD_CLASS: String read FCOD_CLASS write FCOD_CLASS;
    property QTD: Double read FQTD write FQTD;
    property UNID: String read FUNID write FUNID;
    property VL_ITEM: currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property CST_ICMS: String read FCST_ICMS write FCST_ICMS;
    property CFOP: String read FCFOP write FCFOP;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property ALIQ_ST: currency read FALIQ_ST write FALIQ_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property IND_REC: TACBrTipoReceita read FIND_REC write FIND_REC;
    property COD_PART: String read FCOD_PART write FCOD_PART;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro 1510 - Lista

  TRegistro1510List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1510;
    procedure SetItem(Index: Integer; const Value: TRegistro1510);
  public
    function New: TRegistro1510;
    property Items[Index: Integer]: TRegistro1510 read GetItem write SetItem;
  end;

  /// Registro 1600 - TOTAL DAS OPERAÇÕES COM CARTÃO DE CRÉDITO E/OU DÉBITO

  TRegistro1600 = class
  private
    fCOD_PART: String;         /// Número seqüencial do item no documento fiscal
    fTOT_CREDITO: currency;    /// Valor do item
    fTOT_DEBITO: currency;     /// Valor total do desconto
  public
    property COD_PART: String read FCOD_PART write FCOD_PART;
    property TOT_CREDITO: currency read FTOT_CREDITO write FTOT_CREDITO;
    property TOT_DEBITO: currency read FTOT_DEBITO write FTOT_DEBITO;
  end;

  /// Registro 1600 - Lista

  TRegistro1600List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1600;
    procedure SetItem(Index: Integer; const Value: TRegistro1600);
  public
    function New: TRegistro1600;
    property Items[Index: Integer]: TRegistro1600 read GetItem write SetItem;
  end;

  /// Registro 1700 - DOCUMENTOS FISCAIS UTILIZADOS

  TRegistro1700 = class
  private
    fCOD_DISP: TACBrDispositivo;    /// Codigo Dispositivo autorizado
    fCOD_MOD: String;               /// Codigo Modelo Documento Fiscal
    fSER: String;                   /// Serie Documento Fiscal
    fSUB: String;                   /// SubSerie Documento Fiscal
    fNUM_DOC_INI: String;         /// Numero Documento Fiscal Inicial - deve ser String
    fNUM_DOC_FIN: String;         /// Numero Documento Fiscal Final - deve ser String
    fNUM_AUT: String;             /// Numero da Autorizacao - deve ser String

    FRegistro1710: TRegistro1710List;  /// BLOCO 1- Lista de Registro1710 (FILHO fo FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property COD_DISP: TACBrDispositivo read fCOD_DISP write fCOD_DISP;
    property COD_MOD: String read fCOD_MOD write fCOD_MOD;
    property SER: String read fSER write fSER;
    property SUB: String read fSUB write fSUB;
    property NUM_DOC_INI: String read fNUM_DOC_INI write fNUM_DOC_INI;
    property NUM_DOC_FIN: String read fNUM_DOC_FIN write fNUM_DOC_FIN;
    property NUM_AUT: String read fNUM_AUT write fNUM_AUT;

    property Registro1710: TRegistro1710List read FRegistro1710 write FRegistro1710;
  end;

  /// Registro 1700 - Lista

  TRegistro1700List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1700;
    procedure SetItem(Index: Integer; const Value: TRegistro1700);
  public
    function New: TRegistro1700;
    property Items[Index: Integer]: TRegistro1700 read GetItem write SetItem;
  end;

  /// Registro 1710 - DOCUMENTOS FISCAIS CANCELADOS/INUTILIZADOS

  TRegistro1710 = class
  private
    fNUM_DOC_INI: String;     /// Numero Documento Fiscal Inicial
    fNUM_DOC_FIN: String;     /// Numero Documento Fiscal Final
  public
    property NUM_DOC_INI: String read fNUM_DOC_INI write fNUM_DOC_INI;
    property NUM_DOC_FIN: String read fNUM_DOC_FIN write fNUM_DOC_FIN;
  end;

  /// Registro 1710 - Lista

  TRegistro1710List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1710;
    procedure SetItem(Index: Integer; const Value: TRegistro1710);
  public
    function New: TRegistro1710;
    property Items[Index: Integer]: TRegistro1710 read GetItem write SetItem;
  end;

  /// Registro 1800 - DEMONSTRATIVO CREDITO ICMS SOBRE TRANSPORTE AEREO

  TRegistro1800 = class
  private
    fVL_CARGA: Currency;        /// Valor Prestacoes Cargas Tributado
    fVL_PASS: Currency;         /// Valor Prestacoes Cargas Nao Tributado
    fVL_FAT: Currency;          /// Valor total do faturamento
    fIND_RAT: Currency;         /// Indice para rateio
    fVL_ICMS_ANT: Currency;     /// Valor Total Creditos ICMS
    fVL_BC_ICMS: Currency;      /// Valor Base Calculo ICMS
    fVL_ICMS_APUR: Currency;    /// Valor ICMS apurado no calculo
    fVL_BC_ICMS_APUR: Currency; /// Valor base ICMS apurada
    fVL_DIF: Currency;          /// Valor diferenca a estorno de credito na apuracao
  public
    property VL_CARGA:Currency read fVL_CARGA write fVL_CARGA ;
    property VL_PASS:Currency read fVL_PASS write fVL_PASS ;
    property VL_FAT:Currency read fVL_FAT write fVL_FAT ;
    property IND_RAT:Currency read fIND_RAT write fIND_RAT ;
    property VL_ICMS_ANT:Currency read fVL_ICMS_ANT write fVL_ICMS_ANT ;
    property VL_BC_ICMS:Currency read fVL_BC_ICMS write fVL_BC_ICMS ;
    property VL_ICMS_APUR:Currency read fVL_ICMS_APUR write fVL_ICMS_APUR ;
    property VL_BC_ICMS_APUR:Currency read fVL_BC_ICMS_APUR write fVL_BC_ICMS_APUR ;
    property VL_DIF:Currency read fVL_DIF write fVL_DIF ;
  end;

 /// Registro 1800 - Lista

 TRegistro1800List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1800;
    procedure SetItem(Index: Integer; const Value: TRegistro1800);
  public
    function New: TRegistro1800;
    property Items[Index: Integer]: TRegistro1800 read GetItem write SetItem;
  end;

  /// Registro 1990 - ENCERRAMENTO DO BLOCO 1

  TRegistro1990 = class
  private
    fQTD_LIN_1: Integer; /// Quantidade total de linhas do Bloco 1
  public
    property QTD_LIN_1: Integer read fQTD_LIN_1 write fQTD_LIN_1;
  end;

implementation

{ TRegistro1100List }

function TRegistro1100List.GetItem(Index: Integer): TRegistro1100;
begin
  Result := TRegistro1100(Inherited Items[Index]);
end;

function TRegistro1100List.New: TRegistro1100;
begin
  Result := TRegistro1100.Create;
  Add(Result);
end;

procedure TRegistro1100List.SetItem(Index: Integer; const Value: TRegistro1100);
begin
  Put(Index, Value);
end;

{ TRegistro1105List }

function TRegistro1105List.GetItem(Index: Integer): TRegistro1105;
begin
  Result := TRegistro1105(Inherited Items[Index]);
end;

function TRegistro1105List.New: TRegistro1105;
begin
  Result := TRegistro1105.Create;
  Add(Result);
end;

procedure TRegistro1105List.SetItem(Index: Integer; const Value: TRegistro1105);
begin
  Put(Index, Value);
end;

{ TRegistro1110List }

function TRegistro1110List.GetItem(Index: Integer): TRegistro1110;
begin
  Result := TRegistro1110(Inherited Items[Index]);
end;

function TRegistro1110List.New: TRegistro1110;
begin
  Result := TRegistro1110.Create;
  Add(Result);
end;

procedure TRegistro1110List.SetItem(Index: Integer; const Value: TRegistro1110);
begin
  Put(Index, Value);
end;

{ TRegistro1200List }

function TRegistro1200List.GetItem(Index: Integer): TRegistro1200;
begin
  Result := TRegistro1200(Inherited Items[Index]);
end;

function TRegistro1200List.New: TRegistro1200;
begin
  Result := TRegistro1200.Create;
  Add(Result);
end;

procedure TRegistro1200List.SetItem(Index: Integer; const Value: TRegistro1200);
begin
  Put(Index, Value);
end;

{ TRegistro1210List }

function TRegistro1210List.GetItem(Index: Integer): TRegistro1210;
begin
  Result := TRegistro1210(Inherited Items[Index]);
end;

function TRegistro1210List.New: TRegistro1210;
begin
  Result := TRegistro1210.Create;
  Add(Result);
end;

procedure TRegistro1210List.SetItem(Index: Integer; const Value: TRegistro1210);
begin
  Put(Index, Value);
end;

{ TRegistro1300 }

constructor TRegistro1300.Create;
begin
  FRegistro1310 := TRegistro1310List.Create;  /// BLOCO 1 - Lista de Registro1310 (FILHO)
end;

destructor TRegistro1300.Destroy;
begin
  FRegistro1310.Free;
  inherited;
end;

{ TRegistro1300List }

function TRegistro1300List.GetItem(Index: Integer): TRegistro1300;
begin
  Result := TRegistro1300(Inherited Items[Index]);
end;

function TRegistro1300List.New: TRegistro1300;
begin
  Result := TRegistro1300.Create;
  Add(Result);
end;

procedure TRegistro1300List.SetItem(Index: Integer; const Value: TRegistro1300);
begin
  Put(Index, Value);
end;

{ TRegistro1310 }

constructor TRegistro1310.Create;
begin
  FRegistro1320 := TRegistro1320List.Create;  /// BLOCO 1 - Lista de Registro1320 (FILHO)
end;

destructor TRegistro1310.Destroy;
begin
  FRegistro1320.Free;
  inherited;
end;

{ TRegistro1310List }

function TRegistro1310List.GetItem(Index: Integer): TRegistro1310;
begin
  Result := TRegistro1310(Inherited Items[Index]);
end;

function TRegistro1310List.New: TRegistro1310;
begin
  Result := TRegistro1310.Create;
  Add(Result);
end;

procedure TRegistro1310List.SetItem(Index: Integer; const Value: TRegistro1310);
begin
  Put(Index, Value);
end;

{ TRegistro1320List }

function TRegistro1320List.GetItem(Index: Integer): TRegistro1320;
begin
  Result := TRegistro1320(Inherited Items[Index]);
end;

function TRegistro1320List.New: TRegistro1320;
begin
  Result := TRegistro1320.Create;
  Add(Result);
end;

procedure TRegistro1320List.SetItem(Index: Integer; const Value: TRegistro1320);
begin
  Put(Index, Value);
end;

{ TRegistro1400List }

function TRegistro1400List.GetItem(Index: Integer): TRegistro1400;
begin
  Result := TRegistro1400(Inherited Items[Index]);
end;

function TRegistro1400List.New: TRegistro1400;
begin
  Result := TRegistro1400.Create;
  Add(Result);
end;

procedure TRegistro1400List.SetItem(Index: Integer; const Value: TRegistro1400);
begin
  Put(Index, Value);
end;

{ TRegistro1500List }

function TRegistro1500List.GetItem(Index: Integer): TRegistro1500;
begin
  Result := TRegistro1500(Inherited Items[Index]);
end;

function TRegistro1500List.New: TRegistro1500;
begin
  Result := TRegistro1500.Create;
  Add(Result);
end;

procedure TRegistro1500List.SetItem(Index: Integer; const Value: TRegistro1500);
begin
  Put(Index, Value);
end;

{ TRegistro1510List }

function TRegistro1510List.GetItem(Index: Integer): TRegistro1510;
begin
  Result := TRegistro1510(Inherited Items[Index]);
end;

function TRegistro1510List.New: TRegistro1510;
begin
  Result := TRegistro1510.Create;
  Add(Result);
end;

procedure TRegistro1510List.SetItem(Index: Integer; const Value: TRegistro1510);
begin
  Put(Index, Value);
end;

{ TRegistro1350List }

function TRegistro1350List.GetItem(Index: Integer): TRegistro1350;
begin
    Result := TRegistro1350(Inherited Items[Index]);
end;

function TRegistro1350List.New: TRegistro1350;
begin
  Result := TRegistro1350.Create;
  Add(Result);
end;

procedure TRegistro1350List.SetItem(Index: Integer; const Value: TRegistro1350);
begin
  Put(Index, Value);
end;

{ TRegistro1360List }

function TRegistro1360List.GetItem(Index: Integer): TRegistro1360;
begin
    Result := TRegistro1360(Inherited Items[Index]);
end;

function TRegistro1360List.New: TRegistro1360;
begin
  Result := TRegistro1360.Create;
  Add(Result);
end;

procedure TRegistro1360List.SetItem(Index: Integer; const Value: TRegistro1360);
begin
  Put(Index, Value);
end;


{ TRegistro1370List }

function TRegistro1370List.GetItem(Index: Integer): TRegistro1370;
begin
    Result := TRegistro1370(Inherited Items[Index]);
end;

function TRegistro1370List.New: TRegistro1370;
begin
  Result := TRegistro1370.Create;
  Add(Result);
end;

procedure TRegistro1370List.SetItem(Index: Integer; const Value: TRegistro1370);
begin
  Put(Index, Value);
end;

{ TRegistro1600List }

function TRegistro1600List.GetItem(Index: Integer): TRegistro1600;
begin
  Result := TRegistro1600(Inherited Items[Index]);
end;

function TRegistro1600List.New: TRegistro1600;
begin
  Result := TRegistro1600.Create;
  Add(Result);
end;

procedure TRegistro1600List.SetItem(Index: Integer; const Value: TRegistro1600);
begin
  Put(Index, Value);
end;

{ TRegistro1350 }

constructor TRegistro1350.Create;
begin
  FRegistro1360 := TRegistro1360List.Create;  /// BLOCO 1 - Lista de Registro1360 (FILHO)
  FRegistro1370 := TRegistro1370List.Create;  /// BLOCO 1 - Lista de Registro1370 (FILHO)
end;

destructor TRegistro1350.Destroy;
begin
  FRegistro1360.Free;
  FRegistro1370.Free;
  inherited;
end;

{ TRegistro1700 }

constructor TRegistro1700.Create;
begin
  FRegistro1710 := TRegistro1710List.Create;  /// BLOCO 1 - Lista de Registro1710 (FILHO)
end;

destructor TRegistro1700.Destroy;
begin
  FRegistro1710.Free;
  inherited;
end;

{ TRegistro1700List }

function TRegistro1700List.GetItem(Index: Integer): TRegistro1700;
begin
  Result := TRegistro1700(Inherited Items[Index]);
end;

function TRegistro1700List.New: TRegistro1700;
begin
  Result := TRegistro1700.Create;
  Add(Result);
end;

procedure TRegistro1700List.SetItem(Index: Integer; const Value: TRegistro1700);
begin
  Put(Index, Value);
end;

{ TRegistro1710 }

function TRegistro1710List.GetItem(Index: Integer): TRegistro1710;
begin
  Result := TRegistro1710(Inherited Items[Index]);
end;

function TRegistro1710List.New: TRegistro1710;
begin
  Result := TRegistro1710.Create;
  Add(Result);
end;

procedure TRegistro1710List.SetItem(Index: Integer; const Value: TRegistro1710);
begin
  Put(Index, Value);
end;

{ TRegistro1800List }

function TRegistro1800List.GetItem(Index: Integer): TRegistro1800;
begin
  Result := TRegistro1800(Inherited Items[Index]);
end;

function TRegistro1800List.New: TRegistro1800;
begin
  Result := TRegistro1800.Create;
  Add(Result);
end;

procedure TRegistro1800List.SetItem(Index: Integer; const Value: TRegistro1800);
begin
  Put(Index, Value);
end;

{ TRegistro1001 }

constructor TRegistro1001.Create;
begin
   FRegistro1100 := TRegistro1100List.Create;
   FRegistro1200 := TRegistro1200List.Create;
   FRegistro1300 := TRegistro1300List.Create;
   FRegistro1350 := TRegistro1350List.Create;
   FRegistro1400 := TRegistro1400List.Create;
   FRegistro1500 := TRegistro1500List.Create;
   FRegistro1600 := TRegistro1600List.Create;
   FRegistro1700 := TRegistro1700List.Create;
   FRegistro1800 := TRegistro1800List.Create;
   //
   IND_MOV := imSemDados;
end;

destructor TRegistro1001.Destroy;
begin
   FRegistro1100.Free;
   FRegistro1200.Free;
   FRegistro1300.Free;
   FRegistro1350.Free;
   FRegistro1400.Free;
   FRegistro1500.Free;
   FRegistro1600.Free;
   FRegistro1700.Free;
   FRegistro1800.Free;
  inherited;
end;

{ TRegistro1100 }

constructor TRegistro1100.Create;
begin
   fRegistro1105 := TRegistro1105List.Create;
end;

destructor TRegistro1100.Destroy;
begin
  fRegistro1105.Free;
  inherited;
end;

{ TRegistro1105 }

constructor TRegistro1105.Create;
begin
   fRegistro1110 := TRegistro1110List.Create;
end;

destructor TRegistro1105.Destroy;
begin
  fRegistro1110.Free;
  inherited;
end;

{ TRegistro1200 }

constructor TRegistro1200.Create;
begin
   FRegistro1210 := TRegistro1210List.Create;
end;

destructor TRegistro1200.Destroy;
begin
  FRegistro1210.Free;
  inherited;
end;

{ TRegistro1500 }

constructor TRegistro1500.Create;
begin
   FRegistro1510 := TRegistro1510List.Create;
end;

destructor TRegistro1500.Destroy;
begin
  FRegistro1510.Free;
  inherited;
end;

end.
