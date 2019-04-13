{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2010   Isaque Pinheiro                      }
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
|* 15/02/2011: Isaque Pinheiro e Fernando Amado
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrEPCBloco_F_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEPCBloco_F, ACBrEPCBlocos,
     ACBrTXTClass, ACBrEPCBloco_0_Class;

type
  /// TBloco_F -

  { TBloco_F }

  TBloco_F = class(TACBrSPED)
  private
    FRegistroF001                       : TRegistroF001;      /// BLOCO F - RegistroF001
    FRegistroF990                       : TRegistroF990;      /// BLOCO F - RegistroF990

    FRegistroF010Count                  : integer;
    FRegistroF100Count                  : integer;
    FRegistroF111Count                  : integer;
    FRegistroF120Count                  : integer;
    FRegistroF129Count                  : integer;
    FRegistroF130Count                  : integer;
    FRegistroF139Count                  : integer;
    FRegistroF150Count                  : integer;
    FRegistroF200Count                  : integer;
    FRegistroF205Count                  : integer;
    FRegistroF210Count                  : integer;
    FRegistroF211Count                  : integer;
    FRegistroF600Count                  : integer;
    FRegistroF700Count                  : integer;
    FRegistroF800Count                  : integer;
    FBloco_0                            : TBloco_0;

    procedure WriteRegistroF010(RegF001 : TRegistroF001);
    procedure WriteRegistroF100(RegF010 : TRegistroF010);
    procedure WriteRegistroF111(RegF100 : TRegistroF100);
    procedure WriteRegistroF120(RegF010 : TRegistroF010);
    procedure WriteRegistroF129(RegF120 : TRegistroF120);
    procedure WriteRegistroF130(RegF010 : TRegistroF010);
    procedure WriteRegistroF139(RegF130 : TRegistroF130);
    procedure WriteRegistroF150(RegF010 : TRegistroF010);
    procedure WriteRegistroF200(RegF010 : TRegistroF010);
    procedure WriteRegistroF205(RegF200 : TRegistroF200);
    procedure WriteRegistroF210(RegF200 : TRegistroF200);
    procedure WriteRegistroF211(RegF200 : TRegistroF200);
    procedure WriteRegistroF600(RegF010 : TRegistroF010);
    procedure WriteRegistroF700(RegF010 : TRegistroF010);
    procedure WriteRegistroF800(RegF010 : TRegistroF010);

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create ;                                      /// Create
    destructor Destroy; override;                             /// Destroy
    procedure LimpaRegistros;

    function RegistroF001New            : TRegistroF001;
    function RegistroF010New            : TRegistroF010;
    function RegistroF100New            : TRegistroF100;
    function RegistroF111New            : TRegistroF111;
    function RegistroF120New            : TRegistroF120;
    function RegistroF129New            : TRegistroF129;
    function RegistroF130New            : TRegistroF130;
    function RegistroF139New            : TRegistroF139;
    function RegistroF150New            : TRegistroF150;
    function RegistroF200New            : TRegistroF200;
    function RegistroF205New            : TRegistroF205;
    function RegistroF210New            : TRegistroF210;
    function RegistroF211New            : TRegistroF211;
    function RegistroF600New            : TRegistroF600;
    function RegistroF700New            : TRegistroF700;
    function RegistroF800New            : TRegistroF800;

    procedure WriteRegistroF001;
    procedure WriteRegistroF990;

    property Bloco_0                    : TBloco_0      read FBloco_0           write FBloco_0;
    property RegistroF001               : TRegistroF001 read FRegistroF001      write FRegistroF001;
    property RegistroF990               : TRegistroF990 read FRegistroF990      write FRegistroF990;

    property RegistroF010Count          : integer       read FRegistroF010Count write FRegistroF010Count;
    property RegistroF100Count          : integer       read FRegistroF100Count write FRegistroF100Count;
    property RegistroF111Count          : integer       read FRegistroF111Count write FRegistroF111Count;
    property RegistroF120Count          : integer       read FRegistroF120Count write FRegistroF120Count;
    property RegistroF129Count          : integer       read FRegistroF129Count write FRegistroF129Count;
    property RegistroF130Count          : integer       read FRegistroF130Count write FRegistroF130Count;
    property RegistroF139Count          : integer       read FRegistroF139Count write FRegistroF139Count;
    property RegistroF150Count          : integer       read FRegistroF150Count write FRegistroF150Count;
    property RegistroF200Count          : integer       read FRegistroF200Count write FRegistroF200Count;
    property RegistroF205Count          : integer       read FRegistroF205Count write FRegistroF205Count;
    property RegistroF210Count          : integer       read FRegistroF210Count write FRegistroF210Count;
    property RegistroF211Count          : integer       read FRegistroF211Count write FRegistroF211Count;
    property RegistroF600Count          : integer       read FRegistroF600Count write FRegistroF600Count;
    property RegistroF700Count          : integer       read FRegistroF700Count write FRegistroF700Count;
    property RegistroF800Count          : integer       read FRegistroF800Count write FRegistroF800Count;
  end;

implementation

uses ACBrSpedUtils;

{ TBloco_F }

constructor TBloco_F.Create;
begin
  inherited ;
  CriaRegistros;
end;

destructor TBloco_F.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_F.CriaRegistros;
begin
  FRegistroF001           := TRegistroF001.Create;
  FRegistroF990           := TRegistroF990.Create;

  FRegistroF010Count      := 0;
  FRegistroF100Count      := 0;
  FRegistroF111Count      := 0;
  FRegistroF120Count      := 0;
  FRegistroF129Count      := 0;
  FRegistroF130Count      := 0;
  FRegistroF139Count      := 0;
  FRegistroF150Count      := 0;
  FRegistroF200Count      := 0;
  FRegistroF205Count      := 0;
  FRegistroF210Count      := 0;
  FRegistroF211Count      := 0;
  FRegistroF600Count      := 0;
  FRegistroF700Count      := 0;
  FRegistroF800Count      := 0;

  FRegistroF990.QTD_LIN_F := 0;
end;

procedure TBloco_F.LiberaRegistros;
begin
  FRegistroF001.Free;
  FRegistroF990.Free;
end;

procedure TBloco_F.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  Conteudo.Clear;

  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_F.RegistroF001New: TRegistroF001;
begin
   Result := FRegistroF001;
end;

function TBloco_F.RegistroF010New: TRegistroF010;
begin
   Result := FRegistroF001.RegistroF010.New;
end;

function TBloco_F.RegistroF100New: TRegistroF100;
  var
    F010Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF100.New;
end;

function TBloco_F.RegistroF111New: TRegistroF111;
  var
    F010Count: integer;
    F100Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   F100Count := FRegistroF001.RegistroF010.Items[F010Count].RegistroF100.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF100.Items[F100Count].RegistroF111.New;
end;

function TBloco_F.RegistroF120New: TRegistroF120;
  var
    F010Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF120.New;
end;

function TBloco_F.RegistroF129New: TRegistroF129;
  var
    F010Count: integer;
    F120Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   F120Count := FRegistroF001.RegistroF010.Items[F010Count].RegistroF120.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF120.Items[F120Count].RegistroF129.New;
end;

function TBloco_F.RegistroF130New: TRegistroF130;
  var
    F010Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF130.New;
end;

function TBloco_F.RegistroF139New: TRegistroF139;
  var
    F010Count: integer;
    F130Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   F130Count := FRegistroF001.RegistroF010.Items[F010Count].RegistroF130.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF130.Items[F130Count].RegistroF139.New;
end;

function TBloco_F.RegistroF150New: TRegistroF150;
  var
    F010Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF150.New;
end;

function TBloco_F.RegistroF200New: TRegistroF200;
  var
    F010Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF200.New;
end;

function TBloco_F.RegistroF205New: TRegistroF205;
  var
    F010Count: integer;
    F200Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   F200Count := FRegistroF001.RegistroF010.Items[F010Count].RegistroF200.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF200.Items[F200Count].RegistroF205;
end;

function TBloco_F.RegistroF210New: TRegistroF210;
  var
    F010Count: integer;
    F200Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   F200Count := FRegistroF001.RegistroF010.Items[F010Count].RegistroF200.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF200.Items[F200Count].RegistroF210.New;
end;

function TBloco_F.RegistroF211New: TRegistroF211;
  var
    F010Count: integer;
    F200Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   F200Count := FRegistroF001.RegistroF010.Items[F010Count].RegistroF200.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF200.Items[F200Count].RegistroF211.New;
end;

function TBloco_F.RegistroF600New: TRegistroF600;
  var
    F010Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF600.New;
end;

function TBloco_F.RegistroF700New: TRegistroF700;
  var
    F010Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF700.New;
end;

function TBloco_F.RegistroF800New: TRegistroF800;
  var
    F010Count: integer;
begin
   F010Count := FRegistroF001.RegistroF010.Count -1;
   //
   Result    := FRegistroF001.RegistroF010.Items[F010Count].RegistroF800.New;
end;

procedure TBloco_F.WriteRegistroF001 ;
begin
  if Assigned(FRegistroF001) then
  begin
     with FRegistroF001 do
     begin
        Add( LFill( 'F001' ) +
             LFill( Integer(IND_MOV), 0 ) ) ;

        if IND_MOV = imComDados then
        begin
          WriteRegistroF010(FRegistroF001) ;
        end;
     end;

     RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
  end;
end;

procedure TBloco_F.WriteRegistroF010(RegF001: TRegistroF001) ;
  var
    intFor: Integer;
begin
  if Assigned(RegF001.RegistroF010) then
  begin
    for intFor := 0 to RegF001.RegistroF010.Count - 1 do
    begin
      with RegF001.RegistroF010.Items[intFor] do
      begin
        Check(funChecaCNPJ(CNPJ), '(F-010) ESTABELECIMENTO: O CNPJ "%s" digitado é inválido!', [CNPJ]);

        Add( LFill('F010') +
             LFill(CNPJ, 14) ) ;
      end;

      // Registros FILHOS
      WriteRegistroF100( RegF001.RegistroF010.Items[intFor] );
      WriteRegistroF120( RegF001.RegistroF010.Items[intFor] );
      WriteRegistroF130( RegF001.RegistroF010.Items[intFor] );
      WriteRegistroF150( RegF001.RegistroF010.Items[intFor] );
      WriteRegistroF200( RegF001.RegistroF010.Items[intFor] );
      WriteRegistroF600( RegF001.RegistroF010.Items[intFor] );
      WriteRegistroF700( RegF001.RegistroF010.Items[intFor] );
      WriteRegistroF800( RegF001.RegistroF010.Items[intFor] );
      //
      RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
    end;
    // Variavél para armazenar a quantidade de registro do tipo.
    FRegistroF010Count := FRegistroF010Count + RegF001.RegistroF010.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF100(RegF010: TRegistroF010) ;
  var
    intFor           : integer;
    strIND_OPER      : AnsiString;
    strIND_ORIG_CRED : AnsiString;
    strCST_PIS       : AnsiString;
    strCST_COFINS    : AnsiString;
    strNAT_BC_CRED   : AnsiString;    
begin
  if Assigned(RegF010.RegistroF100) then
  begin
     for intFor := 0 to RegF010.RegistroF100.Count - 1 do
     begin
        with RegF010.RegistroF100.Items[intFor] do
        begin

          case IND_OPER of
            indRepCustosDespesasEncargos : strIND_OPER := '0'; //0 – Operação Representativa de Aquisição, Custos, Despesa ou Encargos, Sujeita à Incidência de Crédito de PIS/Pasep ou Cofins (CST 50 a 66).
            indRepReceitaAuferida        : strIND_OPER := '1'; //1 – Operação Representativa de Receita Auferida Sujeita ao Pagamento da Contribuição para o PIS/Pasep e da Cofins (CST 01, 02, 03 ou 05).
            indRepReceitaNaoAuferida     : strIND_OPER := '2'; //2 - Operação Representativa de Receita Auferida Não Sujeita ao Pagamento da Contribuição para o PIS/Pasep e da Cofins (CST 04, 06, 07, 08, 09, 49 ou 99).

          end;

          case IND_ORIG_CRED of
            opcMercadoInterno : strIND_ORIG_CRED := '0';
            opcImportacao     : strIND_ORIG_CRED := '1';
          end;

          case CST_PIS of
            stpisValorAliquotaNormal                           : strCST_PIS := '01';
            stpisValorAliquotaDiferenciada                     : strCST_PIS := '02';
            stpisQtdeAliquotaUnidade                           : strCST_PIS := '03';
            stpisMonofaticaAliquotaZero                        : strCST_PIS := '04';
            stpisValorAliquotaPorST                            : strCST_PIS := '05';
            stpisAliquotaZero                                  : strCST_PIS := '06';
            stpisIsentaContribuicao                            : strCST_PIS := '07';
            stpisSemIncidenciaContribuicao                     : strCST_PIS := '08';
            stpisSuspensaoContribuicao                         : strCST_PIS := '09';
            stpisOutrasOperacoesSaida                          : strCST_PIS := '49';
            stpisOperCredExcRecTribMercInt                     : strCST_PIS := '50';
            stpisOperCredExcRecNaoTribMercInt                  : strCST_PIS := '51';
            stpisOperCredExcRecExportacao                      : strCST_PIS := '52';
            stpisOperCredRecTribNaoTribMercInt                 : strCST_PIS := '53';
            stpisOperCredRecTribMercIntEExportacao             : strCST_PIS := '54';
            stpisOperCredRecNaoTribMercIntEExportacao          : strCST_PIS := '55';
            stpisOperCredRecTribENaoTribMercIntEExportacao     : strCST_PIS := '56';
            stpisCredPresAquiExcRecTribMercInt                 : strCST_PIS := '60';
            stpisCredPresAquiExcRecNaoTribMercInt              : strCST_PIS := '61';
            stpisCredPresAquiExcExcRecExportacao               : strCST_PIS := '62';
            stpisCredPresAquiRecTribNaoTribMercInt             : strCST_PIS := '63';
            stpisCredPresAquiRecTribMercIntEExportacao         : strCST_PIS := '64';
            stpisCredPresAquiRecNaoTribMercIntEExportacao      : strCST_PIS := '65';
            stpisCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_PIS := '66';
            stpisOutrasOperacoes_CredPresumido                 : strCST_PIS := '67';
            stpisOperAquiSemDirCredito                         : strCST_PIS := '70';
            stpisOperAquiComIsensao                            : strCST_PIS := '71';
            stpisOperAquiComSuspensao                          : strCST_PIS := '72';
            stpisOperAquiAliquotaZero                          : strCST_PIS := '73';
            stpisOperAqui_SemIncidenciaContribuicao            : strCST_PIS := '74';
            stpisOperAquiPorST                                 : strCST_PIS := '75';
            stpisOutrasOperacoesEntrada                        : strCST_PIS := '98';
            stpisOutrasOperacoes                               : strCST_PIS := '99';
          end;

          case CST_COFINS of
            stcofinsValorAliquotaNormal                           : strCST_COFINS := '01';
            stcofinsValorAliquotaDiferenciada                     : strCST_COFINS := '02';
            stcofinsQtdeAliquotaUnidade                           : strCST_COFINS := '03';
            stcofinsMonofaticaAliquotaZero                        : strCST_COFINS := '04';
            stcofinsValorAliquotaPorST                            : strCST_COFINS := '05';
            stcofinsAliquotaZero                                  : strCST_COFINS := '06';
            stcofinsIsentaContribuicao                            : strCST_COFINS := '07';
            stcofinsSemIncidenciaContribuicao                     : strCST_COFINS := '08';
            stcofinsSuspensaoContribuicao                         : strCST_COFINS := '09';
            stcofinsOutrasOperacoesSaida                          : strCST_COFINS := '49';
            stcofinsOperCredExcRecTribMercInt                     : strCST_COFINS := '50';
            stcofinsOperCredExcRecNaoTribMercInt                  : strCST_COFINS := '51';
            stcofinsOperCredExcRecExportacao                      : strCST_COFINS := '52';
            stcofinsOperCredRecTribNaoTribMercInt                 : strCST_COFINS := '53';
            stcofinsOperCredRecTribMercIntEExportacao             : strCST_COFINS := '54';
            stcofinsOperCredRecNaoTribMercIntEExportacao          : strCST_COFINS := '55';
            stcofinsOperCredRecTribENaoTribMercIntEExportacao     : strCST_COFINS := '56';
            stcofinsCredPresAquiExcRecTribMercInt                 : strCST_COFINS := '60';
            stcofinsCredPresAquiExcRecNaoTribMercInt              : strCST_COFINS := '61';
            stcofinsCredPresAquiExcExcRecExportacao               : strCST_COFINS := '62';
            stcofinsCredPresAquiRecTribNaoTribMercInt             : strCST_COFINS := '63';
            stcofinsCredPresAquiRecTribMercIntEExportacao         : strCST_COFINS := '64';
            stcofinsCredPresAquiRecNaoTribMercIntEExportacao      : strCST_COFINS := '65';
            stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_COFINS := '66';
            stcofinsOutrasOperacoes_CredPresumido                 : strCST_COFINS := '67';
            stcofinsOperAquiSemDirCredito                         : strCST_COFINS := '70';
            stcofinsOperAquiComIsensao                            : strCST_COFINS := '71';
            stcofinsOperAquiComSuspensao                          : strCST_COFINS := '72';
            stcofinsOperAquiAliquotaZero                          : strCST_COFINS := '73';
            stcofinsOperAqui_SemIncidenciaContribuicao            : strCST_COFINS := '74';
            stcofinsOperAquiPorST                                 : strCST_COFINS := '75';
            stcofinsOutrasOperacoesEntrada                        : strCST_COFINS := '98';
            stcofinsOutrasOperacoes                               : strCST_COFINS := '99';
          end;

          case NAT_BC_CRED of
            bccAqBensRevenda                 : strNAT_BC_CRED := '01';
            bccAqBensUtiComoInsumo           : strNAT_BC_CRED := '02';
            bccAqServUtiComoInsumo           : strNAT_BC_CRED := '03';
            bccEnergiaEletricaTermica        : strNAT_BC_CRED := '04';
            bccAluguelPredios                : strNAT_BC_CRED := '05';
            bccAluguelMaqEquipamentos        : strNAT_BC_CRED := '06';
            bccArmazenagemMercadoria         : strNAT_BC_CRED := '07';
            bccConArrendamentoMercantil      : strNAT_BC_CRED := '08';
            bccMaqCredDepreciacao            : strNAT_BC_CRED := '09';
            bccMaqCredAquisicao              : strNAT_BC_CRED := '10';
            bccAmortizacaoDepreciacaoImoveis : strNAT_BC_CRED := '11';
            bccDevolucaoSujeita              : strNAT_BC_CRED := '12';
            bccOutrasOpeComDirCredito        : strNAT_BC_CRED := '13';
            bccAtTransporteSubcontratacao    : strNAT_BC_CRED := '14';
            bccAtImobCustoIncorrido          : strNAT_BC_CRED := '15';
            bccAtImobCustoOrcado             : strNAT_BC_CRED := '16';
            bccAtPresServ                    : strNAT_BC_CRED := '17';
            bccEstoqueAberturaBens           : strNAT_BC_CRED := '18';
          end;

          Add( LFill('F100')             +
               LFill( strIND_OPER )      +
               LFill( COD_PART )         +
               LFill( COD_ITEM )         +
               LFill( DT_OPER )          +
               LFill( VL_OPER,0,2 )      +
               LFill( strCST_PIS )       +
               LFill( VL_BC_PIS,0,2 )    +
               LFill( ALIQ_PIS,0,2 )     +
               LFill( VL_PIS,0,2 )       +
               LFill( strCST_COFINS )    +
               LFill( VL_BC_COFINS,0,2 ) +
               LFill( ALIQ_COFINS,0,2 )  +
               LFill( VL_COFINS,0,2 )    +
               LFill( strNAT_BC_CRED )   +
               LFill( strIND_ORIG_CRED ) +
               LFill( COD_CTA )          +
               LFill( COD_CCUS )         +
               LFill( DESC_DOC_OPER ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF111( RegF010.RegistroF100.Items[intFor] );
        ///
        RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroF100Count := FRegistroF100Count + RegF010.RegistroF100.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF111(RegF100: TRegistroF100) ;
  var
    intFor      : integer;
    strIND_PROC : AnsiString;
begin
  if Assigned(RegF100.RegistroF111) then
  begin
    for intFor := 0 to RegF100.RegistroF111.Count - 1 do
    begin
      with RegF100.RegistroF111.Items[intFor] do
      begin
        case IND_PROC of
          opJusticaFederal : strIND_PROC := '0';
          opSecexRFB       : strIND_PROC := '1';
          opOutros         : strIND_PROC := '9';
          opNenhum         : strIND_PROC := '';
        end;

        Add( LFill('F111')   +
             LFill(NUM_PROC) +
             LFill(strIND_PROC) ) ;
      end;

      RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
    end;
    /// Variavél para armazenar a quantidade de registro do tipo.
    FRegistroF111Count := FRegistroF111Count + RegF100.RegistroF111.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF120(RegF010: TRegistroF010) ;
  var
    intFor         : integer;
    strNAT_BC_CRED : AnsiString;
    strCST_PIS     : AnsiString;
    strCST_COFINS  : AnsiString;
begin
  if Assigned(RegF010.RegistroF120) then
  begin
     for intFor := 0 to RegF010.RegistroF120.Count - 1 do
     begin
        with RegF010.RegistroF120.Items[intFor] do
        begin

          case CST_PIS of
            stpisValorAliquotaNormal                           : strCST_PIS := '01';
            stpisValorAliquotaDiferenciada                     : strCST_PIS := '02';
            stpisQtdeAliquotaUnidade                           : strCST_PIS := '03';
            stpisMonofaticaAliquotaZero                        : strCST_PIS := '04';
            stpisValorAliquotaPorST                            : strCST_PIS := '05';
            stpisAliquotaZero                                  : strCST_PIS := '06';
            stpisIsentaContribuicao                            : strCST_PIS := '07';
            stpisSemIncidenciaContribuicao                     : strCST_PIS := '08';
            stpisSuspensaoContribuicao                         : strCST_PIS := '09';
            stpisOutrasOperacoesSaida                          : strCST_PIS := '49';
            stpisOperCredExcRecTribMercInt                     : strCST_PIS := '50';
            stpisOperCredExcRecNaoTribMercInt                  : strCST_PIS := '51';
            stpisOperCredExcRecExportacao                      : strCST_PIS := '52';
            stpisOperCredRecTribNaoTribMercInt                 : strCST_PIS := '53';
            stpisOperCredRecTribMercIntEExportacao             : strCST_PIS := '54';
            stpisOperCredRecNaoTribMercIntEExportacao          : strCST_PIS := '55';
            stpisOperCredRecTribENaoTribMercIntEExportacao     : strCST_PIS := '56';
            stpisCredPresAquiExcRecTribMercInt                 : strCST_PIS := '60';
            stpisCredPresAquiExcRecNaoTribMercInt              : strCST_PIS := '61';
            stpisCredPresAquiExcExcRecExportacao               : strCST_PIS := '62';
            stpisCredPresAquiRecTribNaoTribMercInt             : strCST_PIS := '63';
            stpisCredPresAquiRecTribMercIntEExportacao         : strCST_PIS := '64';
            stpisCredPresAquiRecNaoTribMercIntEExportacao      : strCST_PIS := '65';
            stpisCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_PIS := '66';
            stpisOutrasOperacoes_CredPresumido                 : strCST_PIS := '67';
            stpisOperAquiSemDirCredito                         : strCST_PIS := '70';
            stpisOperAquiComIsensao                            : strCST_PIS := '71';
            stpisOperAquiComSuspensao                          : strCST_PIS := '72';
            stpisOperAquiAliquotaZero                          : strCST_PIS := '73';
            stpisOperAqui_SemIncidenciaContribuicao            : strCST_PIS := '74';
            stpisOperAquiPorST                                 : strCST_PIS := '75';
            stpisOutrasOperacoesEntrada                        : strCST_PIS := '98';
            stpisOutrasOperacoes                               : strCST_PIS := '99';
          end;

          case CST_COFINS of
            stcofinsValorAliquotaNormal                           : strCST_COFINS := '01';
            stcofinsValorAliquotaDiferenciada                     : strCST_COFINS := '02';
            stcofinsQtdeAliquotaUnidade                           : strCST_COFINS := '03';
            stcofinsMonofaticaAliquotaZero                        : strCST_COFINS := '04';
            stcofinsValorAliquotaPorST                            : strCST_COFINS := '05';
            stcofinsAliquotaZero                                  : strCST_COFINS := '06';
            stcofinsIsentaContribuicao                            : strCST_COFINS := '07';
            stcofinsSemIncidenciaContribuicao                     : strCST_COFINS := '08';
            stcofinsSuspensaoContribuicao                         : strCST_COFINS := '09';
            stcofinsOutrasOperacoesSaida                          : strCST_COFINS := '49';
            stcofinsOperCredExcRecTribMercInt                     : strCST_COFINS := '50';
            stcofinsOperCredExcRecNaoTribMercInt                  : strCST_COFINS := '51';
            stcofinsOperCredExcRecExportacao                      : strCST_COFINS := '52';
            stcofinsOperCredRecTribNaoTribMercInt                 : strCST_COFINS := '53';
            stcofinsOperCredRecTribMercIntEExportacao             : strCST_COFINS := '54';
            stcofinsOperCredRecNaoTribMercIntEExportacao          : strCST_COFINS := '55';
            stcofinsOperCredRecTribENaoTribMercIntEExportacao     : strCST_COFINS := '56';
            stcofinsCredPresAquiExcRecTribMercInt                 : strCST_COFINS := '60';
            stcofinsCredPresAquiExcRecNaoTribMercInt              : strCST_COFINS := '61';
            stcofinsCredPresAquiExcExcRecExportacao               : strCST_COFINS := '62';
            stcofinsCredPresAquiRecTribNaoTribMercInt             : strCST_COFINS := '63';
            stcofinsCredPresAquiRecTribMercIntEExportacao         : strCST_COFINS := '64';
            stcofinsCredPresAquiRecNaoTribMercIntEExportacao      : strCST_COFINS := '65';
            stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_COFINS := '66';
            stcofinsOutrasOperacoes_CredPresumido                 : strCST_COFINS := '67';
            stcofinsOperAquiSemDirCredito                         : strCST_COFINS := '70';
            stcofinsOperAquiComIsensao                            : strCST_COFINS := '71';
            stcofinsOperAquiComSuspensao                          : strCST_COFINS := '72';
            stcofinsOperAquiAliquotaZero                          : strCST_COFINS := '73';
            stcofinsOperAqui_SemIncidenciaContribuicao            : strCST_COFINS := '74';
            stcofinsOperAquiPorST                                 : strCST_COFINS := '75';
            stcofinsOutrasOperacoesEntrada                        : strCST_COFINS := '98';
            stcofinsOutrasOperacoes                               : strCST_COFINS := '99';
          end;

          case NAT_BC_CRED of
            bccAqBensRevenda                 : strNAT_BC_CRED := '01';
            bccAqBensUtiComoInsumo           : strNAT_BC_CRED := '02';
            bccAqServUtiComoInsumo           : strNAT_BC_CRED := '03';
            bccEnergiaEletricaTermica        : strNAT_BC_CRED := '04';
            bccAluguelPredios                : strNAT_BC_CRED := '05';
            bccAluguelMaqEquipamentos        : strNAT_BC_CRED := '06';
            bccArmazenagemMercadoria         : strNAT_BC_CRED := '07';
            bccConArrendamentoMercantil      : strNAT_BC_CRED := '08';
            bccMaqCredDepreciacao            : strNAT_BC_CRED := '09';
            bccMaqCredAquisicao              : strNAT_BC_CRED := '10';
            bccAmortizacaoDepreciacaoImoveis : strNAT_BC_CRED := '11';
            bccDevolucaoSujeita              : strNAT_BC_CRED := '12';
            bccOutrasOpeComDirCredito        : strNAT_BC_CRED := '13';
            bccAtTransporteSubcontratacao    : strNAT_BC_CRED := '14';
            bccAtImobCustoIncorrido          : strNAT_BC_CRED := '15';
            bccAtImobCustoOrcado             : strNAT_BC_CRED := '16';
            bccAtPresServ                    : strNAT_BC_CRED := '17';
            bccEstoqueAberturaBens           : strNAT_BC_CRED := '18';
          end;


          Add( LFill('F120')                      +
               LFill( strNAT_BC_CRED )            +
               LFill( IDENT_BEM_IMOB )            +    //Verificar criação da tabela no ACBrEPCBlocos
               LFill( IND_ORIG_CRED )             +     //Verificar criação da tabela no ACBrEPCBlocos
               LFill( IND_UTIL_BEM_IMOB )         + //Verificar criação da tabela no ACBrEPCBlocos
               LFill( VL_OPER_DEP,0,2 )           +
               LFill( PARC_OPER_NAO_BC_CRED,0,2 ) +
               LFill( strCST_PIS )                +
               LFill( VL_BC_PIS,0,2 )             +
               LFill( ALIQ_PIS,0,2 )              +
               LFill( VL_PIS,0,2 )                +
               LFill( strCST_COFINS )             +
               LFill( VL_BC_COFINS,0,2 )          +
               LFill( ALIQ_COFINS,0,2 )           +
               LFill( VL_COFINS,0,2 )             +
               LFill( COD_CTA )                   +
               LFill( COD_CCUS )                  +
               LFill( DESC_BEM_IMOB ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF129( RegF010.RegistroF120.Items[intFor] );
        ///
        RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroF120Count := FRegistroF120Count + RegF010.RegistroF120.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF129(RegF120: TRegistroF120) ;
  var
    intFor      : integer;
    strIND_PROC : AnsiString;
begin
  if Assigned(RegF120.RegistroF129) then
  begin
    for intFor := 0 to RegF120.RegistroF129.Count - 1 do
    begin
      with RegF120.RegistroF129.Items[intFor] do
      begin
        case IND_PROC of
          opJusticaFederal : strIND_PROC := '0';
          opSecexRFB       : strIND_PROC := '1';
          opOutros         : strIND_PROC := '9';
          opNenhum         : strIND_PROC := '';
        end;

        Add( LFill('F129')   +
             LFill(NUM_PROC) +
             LFill(strIND_PROC) ) ;
      end;

      RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
    end;
    /// Variavél para armazenar a quantidade de registro do tipo.
    FRegistroF129Count := FRegistroF129Count + RegF120.RegistroF129.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF130(RegF010: TRegistroF010) ;
  var
    intFor         : integer;
    strNAT_BC_CRED : AnsiString;
    strCST_PIS     : AnsiString;
    strCST_COFINS  : AnsiString;
begin
  if Assigned(RegF010.RegistroF130) then
  begin
     for intFor := 0 to RegF010.RegistroF130.Count - 1 do
     begin
        with RegF010.RegistroF130.Items[intFor] do
        begin

          case CST_PIS of
            stpisValorAliquotaNormal                           : strCST_PIS := '01';
            stpisValorAliquotaDiferenciada                     : strCST_PIS := '02';
            stpisQtdeAliquotaUnidade                           : strCST_PIS := '03';
            stpisMonofaticaAliquotaZero                        : strCST_PIS := '04';
            stpisValorAliquotaPorST                            : strCST_PIS := '05';
            stpisAliquotaZero                                  : strCST_PIS := '06';
            stpisIsentaContribuicao                            : strCST_PIS := '07';
            stpisSemIncidenciaContribuicao                     : strCST_PIS := '08';
            stpisSuspensaoContribuicao                         : strCST_PIS := '09';
            stpisOutrasOperacoesSaida                          : strCST_PIS := '49';
            stpisOperCredExcRecTribMercInt                     : strCST_PIS := '50';
            stpisOperCredExcRecNaoTribMercInt                  : strCST_PIS := '51';
            stpisOperCredExcRecExportacao                      : strCST_PIS := '52';
            stpisOperCredRecTribNaoTribMercInt                 : strCST_PIS := '53';
            stpisOperCredRecTribMercIntEExportacao             : strCST_PIS := '54';
            stpisOperCredRecNaoTribMercIntEExportacao          : strCST_PIS := '55';
            stpisOperCredRecTribENaoTribMercIntEExportacao     : strCST_PIS := '56';
            stpisCredPresAquiExcRecTribMercInt                 : strCST_PIS := '60';
            stpisCredPresAquiExcRecNaoTribMercInt              : strCST_PIS := '61';
            stpisCredPresAquiExcExcRecExportacao               : strCST_PIS := '62';
            stpisCredPresAquiRecTribNaoTribMercInt             : strCST_PIS := '63';
            stpisCredPresAquiRecTribMercIntEExportacao         : strCST_PIS := '64';
            stpisCredPresAquiRecNaoTribMercIntEExportacao      : strCST_PIS := '65';
            stpisCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_PIS := '66';
            stpisOutrasOperacoes_CredPresumido                 : strCST_PIS := '67';
            stpisOperAquiSemDirCredito                         : strCST_PIS := '70';
            stpisOperAquiComIsensao                            : strCST_PIS := '71';
            stpisOperAquiComSuspensao                          : strCST_PIS := '72';
            stpisOperAquiAliquotaZero                          : strCST_PIS := '73';
            stpisOperAqui_SemIncidenciaContribuicao            : strCST_PIS := '74';
            stpisOperAquiPorST                                 : strCST_PIS := '75';
            stpisOutrasOperacoesEntrada                        : strCST_PIS := '98';
            stpisOutrasOperacoes                               : strCST_PIS := '99';
          end;

          case CST_COFINS of
            stcofinsValorAliquotaNormal                           : strCST_COFINS := '01';
            stcofinsValorAliquotaDiferenciada                     : strCST_COFINS := '02';
            stcofinsQtdeAliquotaUnidade                           : strCST_COFINS := '03';
            stcofinsMonofaticaAliquotaZero                        : strCST_COFINS := '04';
            stcofinsValorAliquotaPorST                            : strCST_COFINS := '05';
            stcofinsAliquotaZero                                  : strCST_COFINS := '06';
            stcofinsIsentaContribuicao                            : strCST_COFINS := '07';
            stcofinsSemIncidenciaContribuicao                     : strCST_COFINS := '08';
            stcofinsSuspensaoContribuicao                         : strCST_COFINS := '09';
            stcofinsOutrasOperacoesSaida                          : strCST_COFINS := '49';
            stcofinsOperCredExcRecTribMercInt                     : strCST_COFINS := '50';
            stcofinsOperCredExcRecNaoTribMercInt                  : strCST_COFINS := '51';
            stcofinsOperCredExcRecExportacao                      : strCST_COFINS := '52';
            stcofinsOperCredRecTribNaoTribMercInt                 : strCST_COFINS := '53';
            stcofinsOperCredRecTribMercIntEExportacao             : strCST_COFINS := '54';
            stcofinsOperCredRecNaoTribMercIntEExportacao          : strCST_COFINS := '55';
            stcofinsOperCredRecTribENaoTribMercIntEExportacao     : strCST_COFINS := '56';
            stcofinsCredPresAquiExcRecTribMercInt                 : strCST_COFINS := '60';
            stcofinsCredPresAquiExcRecNaoTribMercInt              : strCST_COFINS := '61';
            stcofinsCredPresAquiExcExcRecExportacao               : strCST_COFINS := '62';
            stcofinsCredPresAquiRecTribNaoTribMercInt             : strCST_COFINS := '63';
            stcofinsCredPresAquiRecTribMercIntEExportacao         : strCST_COFINS := '64';
            stcofinsCredPresAquiRecNaoTribMercIntEExportacao      : strCST_COFINS := '65';
            stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_COFINS := '66';
            stcofinsOutrasOperacoes_CredPresumido                 : strCST_COFINS := '67';
            stcofinsOperAquiSemDirCredito                         : strCST_COFINS := '70';
            stcofinsOperAquiComIsensao                            : strCST_COFINS := '71';
            stcofinsOperAquiComSuspensao                          : strCST_COFINS := '72';
            stcofinsOperAquiAliquotaZero                          : strCST_COFINS := '73';
            stcofinsOperAqui_SemIncidenciaContribuicao            : strCST_COFINS := '74';
            stcofinsOperAquiPorST                                 : strCST_COFINS := '75';
            stcofinsOutrasOperacoesEntrada                        : strCST_COFINS := '98';
            stcofinsOutrasOperacoes                               : strCST_COFINS := '99';
          end;

          case NAT_BC_CRED of
            bccAqBensRevenda                 : strNAT_BC_CRED := '01';
            bccAqBensUtiComoInsumo           : strNAT_BC_CRED := '02';
            bccAqServUtiComoInsumo           : strNAT_BC_CRED := '03';
            bccEnergiaEletricaTermica        : strNAT_BC_CRED := '04';
            bccAluguelPredios                : strNAT_BC_CRED := '05';
            bccAluguelMaqEquipamentos        : strNAT_BC_CRED := '06';
            bccArmazenagemMercadoria         : strNAT_BC_CRED := '07';
            bccConArrendamentoMercantil      : strNAT_BC_CRED := '08';
            bccMaqCredDepreciacao            : strNAT_BC_CRED := '09';
            bccMaqCredAquisicao              : strNAT_BC_CRED := '10';
            bccAmortizacaoDepreciacaoImoveis : strNAT_BC_CRED := '11';
            bccDevolucaoSujeita              : strNAT_BC_CRED := '12';
            bccOutrasOpeComDirCredito        : strNAT_BC_CRED := '13';
            bccAtTransporteSubcontratacao    : strNAT_BC_CRED := '14';
            bccAtImobCustoIncorrido          : strNAT_BC_CRED := '15';
            bccAtImobCustoOrcado             : strNAT_BC_CRED := '16';
            bccAtPresServ                    : strNAT_BC_CRED := '17';
            bccEstoqueAberturaBens           : strNAT_BC_CRED := '18';
          end;

          Add( LFill('F130')                      +
               LFill( strNAT_BC_CRED )            +
               LFill( IDENT_BEM_IMOB )            +    //Verificar criação da tabela no ACBrEPCBlocos
               LFill( IND_ORIG_CRED )             +     //Verificar criação da tabela no ACBrEPCBlocos
               LFill( IND_UTIL_BEM_IMOB )         + //Verificar criação da tabela no ACBrEPCBlocos
               LFill( MES_OPER_AQUIS )            +
               LFill( VL_OPER_AQUIS,0,2 )         +
               LFill( PARC_OPER_NAO_BC_CRED,0,2 ) +
               LFill( VL_BC_CRED,0,2 )            +
               LFill( IND_NR_PARC )               +
               LFill( strCST_PIS )                +
               LFill( VL_BC_PIS,0,2 )             +
               LFill( ALIQ_PIS,0,2 )              +
               LFill( VL_PIS,0,2 )                +
               LFill( strCST_COFINS )             +
               LFill( VL_BC_COFINS,0,2 )          +
               LFill( ALIQ_COFINS,0,2 )           +
               LFill( VL_COFINS,0,2 )             +
               LFill( COD_CTA )                   +
               LFill( COD_CCUS )                  +
               LFill( DESC_BEM_IMOB ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF139( RegF010.RegistroF130.Items[intFor] );
        ///
        RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroF130Count := FRegistroF130Count + RegF010.RegistroF130.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF139(RegF130: TRegistroF130) ;
  var
    intFor      : integer;
    strIND_PROC : AnsiString;
begin
  if Assigned(RegF130.RegistroF139) then
  begin
    for intFor := 0 to RegF130.RegistroF139.Count - 1 do
    begin
      with RegF130.RegistroF139.Items[intFor] do
      begin
        case IND_PROC of
          opJusticaFederal : strIND_PROC := '0';
          opSecexRFB       : strIND_PROC := '1';
          opOutros         : strIND_PROC := '9';
          opNenhum         : strIND_PROC := '';
        end;

        Add( LFill('F139')   +
             LFill(NUM_PROC) +
             LFill(strIND_PROC) ) ;
      end;

      RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
    end;
    /// Variavél para armazenar a quantidade de registro do tipo.
    FRegistroF139Count := FRegistroF139Count + RegF130.RegistroF139.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF150(RegF010: TRegistroF010) ;
  var
    intFor         : integer;
    strNAT_BC_CRED : AnsiString;
    strCST_PIS     : AnsiString;
    strCST_COFINS  : AnsiString;
begin
  if Assigned(RegF010.RegistroF150) then
  begin
     for intFor := 0 to RegF010.RegistroF150.Count - 1 do
     begin
        with RegF010.RegistroF150.Items[intFor] do
        begin

          case CST_PIS of
            stpisValorAliquotaNormal                           : strCST_PIS := '01';
            stpisValorAliquotaDiferenciada                     : strCST_PIS := '02';
            stpisQtdeAliquotaUnidade                           : strCST_PIS := '03';
            stpisMonofaticaAliquotaZero                        : strCST_PIS := '04';
            stpisValorAliquotaPorST                            : strCST_PIS := '05';
            stpisAliquotaZero                                  : strCST_PIS := '06';
            stpisIsentaContribuicao                            : strCST_PIS := '07';
            stpisSemIncidenciaContribuicao                     : strCST_PIS := '08';
            stpisSuspensaoContribuicao                         : strCST_PIS := '09';
            stpisOutrasOperacoesSaida                          : strCST_PIS := '49';
            stpisOperCredExcRecTribMercInt                     : strCST_PIS := '50';
            stpisOperCredExcRecNaoTribMercInt                  : strCST_PIS := '51';
            stpisOperCredExcRecExportacao                      : strCST_PIS := '52';
            stpisOperCredRecTribNaoTribMercInt                 : strCST_PIS := '53';
            stpisOperCredRecTribMercIntEExportacao             : strCST_PIS := '54';
            stpisOperCredRecNaoTribMercIntEExportacao          : strCST_PIS := '55';
            stpisOperCredRecTribENaoTribMercIntEExportacao     : strCST_PIS := '56';
            stpisCredPresAquiExcRecTribMercInt                 : strCST_PIS := '60';
            stpisCredPresAquiExcRecNaoTribMercInt              : strCST_PIS := '61';
            stpisCredPresAquiExcExcRecExportacao               : strCST_PIS := '62';
            stpisCredPresAquiRecTribNaoTribMercInt             : strCST_PIS := '63';
            stpisCredPresAquiRecTribMercIntEExportacao         : strCST_PIS := '64';
            stpisCredPresAquiRecNaoTribMercIntEExportacao      : strCST_PIS := '65';
            stpisCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_PIS := '66';
            stpisOutrasOperacoes_CredPresumido                 : strCST_PIS := '67';
            stpisOperAquiSemDirCredito                         : strCST_PIS := '70';
            stpisOperAquiComIsensao                            : strCST_PIS := '71';
            stpisOperAquiComSuspensao                          : strCST_PIS := '72';
            stpisOperAquiAliquotaZero                          : strCST_PIS := '73';
            stpisOperAqui_SemIncidenciaContribuicao            : strCST_PIS := '74';
            stpisOperAquiPorST                                 : strCST_PIS := '75';
            stpisOutrasOperacoesEntrada                        : strCST_PIS := '98';
            stpisOutrasOperacoes                               : strCST_PIS := '99';
          end;

          case CST_COFINS of
            stcofinsValorAliquotaNormal                           : strCST_COFINS := '01';
            stcofinsValorAliquotaDiferenciada                     : strCST_COFINS := '02';
            stcofinsQtdeAliquotaUnidade                           : strCST_COFINS := '03';
            stcofinsMonofaticaAliquotaZero                        : strCST_COFINS := '04';
            stcofinsValorAliquotaPorST                            : strCST_COFINS := '05';
            stcofinsAliquotaZero                                  : strCST_COFINS := '06';
            stcofinsIsentaContribuicao                            : strCST_COFINS := '07';
            stcofinsSemIncidenciaContribuicao                     : strCST_COFINS := '08';
            stcofinsSuspensaoContribuicao                         : strCST_COFINS := '09';
            stcofinsOutrasOperacoesSaida                          : strCST_COFINS := '49';
            stcofinsOperCredExcRecTribMercInt                     : strCST_COFINS := '50';
            stcofinsOperCredExcRecNaoTribMercInt                  : strCST_COFINS := '51';
            stcofinsOperCredExcRecExportacao                      : strCST_COFINS := '52';
            stcofinsOperCredRecTribNaoTribMercInt                 : strCST_COFINS := '53';
            stcofinsOperCredRecTribMercIntEExportacao             : strCST_COFINS := '54';
            stcofinsOperCredRecNaoTribMercIntEExportacao          : strCST_COFINS := '55';
            stcofinsOperCredRecTribENaoTribMercIntEExportacao     : strCST_COFINS := '56';
            stcofinsCredPresAquiExcRecTribMercInt                 : strCST_COFINS := '60';
            stcofinsCredPresAquiExcRecNaoTribMercInt              : strCST_COFINS := '61';
            stcofinsCredPresAquiExcExcRecExportacao               : strCST_COFINS := '62';
            stcofinsCredPresAquiRecTribNaoTribMercInt             : strCST_COFINS := '63';
            stcofinsCredPresAquiRecTribMercIntEExportacao         : strCST_COFINS := '64';
            stcofinsCredPresAquiRecNaoTribMercIntEExportacao      : strCST_COFINS := '65';
            stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_COFINS := '66';
            stcofinsOutrasOperacoes_CredPresumido                 : strCST_COFINS := '67';
            stcofinsOperAquiSemDirCredito                         : strCST_COFINS := '70';
            stcofinsOperAquiComIsensao                            : strCST_COFINS := '71';
            stcofinsOperAquiComSuspensao                          : strCST_COFINS := '72';
            stcofinsOperAquiAliquotaZero                          : strCST_COFINS := '73';
            stcofinsOperAqui_SemIncidenciaContribuicao            : strCST_COFINS := '74';
            stcofinsOperAquiPorST                                 : strCST_COFINS := '75';
            stcofinsOutrasOperacoesEntrada                        : strCST_COFINS := '98';
            stcofinsOutrasOperacoes                               : strCST_COFINS := '99';
          end;

          case NAT_BC_CRED of
            bccAqBensRevenda                 : strNAT_BC_CRED := '01';
            bccAqBensUtiComoInsumo           : strNAT_BC_CRED := '02';
            bccAqServUtiComoInsumo           : strNAT_BC_CRED := '03';
            bccEnergiaEletricaTermica        : strNAT_BC_CRED := '04';
            bccAluguelPredios                : strNAT_BC_CRED := '05';
            bccAluguelMaqEquipamentos        : strNAT_BC_CRED := '06';
            bccArmazenagemMercadoria         : strNAT_BC_CRED := '07';
            bccConArrendamentoMercantil      : strNAT_BC_CRED := '08';
            bccMaqCredDepreciacao            : strNAT_BC_CRED := '09';
            bccMaqCredAquisicao              : strNAT_BC_CRED := '10';
            bccAmortizacaoDepreciacaoImoveis : strNAT_BC_CRED := '11';
            bccDevolucaoSujeita              : strNAT_BC_CRED := '12';
            bccOutrasOpeComDirCredito        : strNAT_BC_CRED := '13';
            bccAtTransporteSubcontratacao    : strNAT_BC_CRED := '14';
            bccAtImobCustoIncorrido          : strNAT_BC_CRED := '15';
            bccAtImobCustoOrcado             : strNAT_BC_CRED := '16';
            bccAtPresServ                    : strNAT_BC_CRED := '17';
            bccEstoqueAberturaBens           : strNAT_BC_CRED := '18';
          end;

          Add( LFill('F150')               +
               LFill( strNAT_BC_CRED )     +
               LFill( VL_TOT_EST,0,2 )     +
               LFill( EST_IMP,0,2 )        +
               LFill( VL_BC_EST,0,2 )      +
               LFill( VL_BC_MEN_EST,0,2 )  +
               LFill( strCST_PIS )         +
               LFill( ALIQ_PIS,0,2 )       +
               LFill( VL_CRED_PIS,0,2 )    +
               LFill( strCST_COFINS )      +
               LFill( ALIQ_COFINS,0,2 )    +
               LFill( VL_CRED_COFINS,0,2 ) +
               LFill( DESC_EST )           +
               LFill( COD_CTA ) ) ;
        end;

        ///
        RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroF150Count := FRegistroF150Count + RegF010.RegistroF150.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF200(RegF010: TRegistroF010) ;
  var
    intFor         : integer;
    strIND_OPER    : AnsiString;
    strCST_PIS     : AnsiString;
    strCST_COFINS  : AnsiString;
begin
  if Assigned(RegF010.RegistroF200) then
  begin
     for intFor := 0 to RegF010.RegistroF200.Count - 1 do
     begin
        with RegF010.RegistroF200.Items[intFor] do
        begin
          case IND_OPER of
            itoContratado : strIND_OPER := '0';
            itoPrestado   : strIND_OPER := '1';
          end;

          case CST_PIS of
            stpisValorAliquotaNormal                           : strCST_PIS := '01';
            stpisValorAliquotaDiferenciada                     : strCST_PIS := '02';
            stpisQtdeAliquotaUnidade                           : strCST_PIS := '03';
            stpisMonofaticaAliquotaZero                        : strCST_PIS := '04';
            stpisValorAliquotaPorST                            : strCST_PIS := '05';
            stpisAliquotaZero                                  : strCST_PIS := '06';
            stpisIsentaContribuicao                            : strCST_PIS := '07';
            stpisSemIncidenciaContribuicao                     : strCST_PIS := '08';
            stpisSuspensaoContribuicao                         : strCST_PIS := '09';
            stpisOutrasOperacoesSaida                          : strCST_PIS := '49';
            stpisOperCredExcRecTribMercInt                     : strCST_PIS := '50';
            stpisOperCredExcRecNaoTribMercInt                  : strCST_PIS := '51';
            stpisOperCredExcRecExportacao                      : strCST_PIS := '52';
            stpisOperCredRecTribNaoTribMercInt                 : strCST_PIS := '53';
            stpisOperCredRecTribMercIntEExportacao             : strCST_PIS := '54';
            stpisOperCredRecNaoTribMercIntEExportacao          : strCST_PIS := '55';
            stpisOperCredRecTribENaoTribMercIntEExportacao     : strCST_PIS := '56';
            stpisCredPresAquiExcRecTribMercInt                 : strCST_PIS := '60';
            stpisCredPresAquiExcRecNaoTribMercInt              : strCST_PIS := '61';
            stpisCredPresAquiExcExcRecExportacao               : strCST_PIS := '62';
            stpisCredPresAquiRecTribNaoTribMercInt             : strCST_PIS := '63';
            stpisCredPresAquiRecTribMercIntEExportacao         : strCST_PIS := '64';
            stpisCredPresAquiRecNaoTribMercIntEExportacao      : strCST_PIS := '65';
            stpisCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_PIS := '66';
            stpisOutrasOperacoes_CredPresumido                 : strCST_PIS := '67';
            stpisOperAquiSemDirCredito                         : strCST_PIS := '70';
            stpisOperAquiComIsensao                            : strCST_PIS := '71';
            stpisOperAquiComSuspensao                          : strCST_PIS := '72';
            stpisOperAquiAliquotaZero                          : strCST_PIS := '73';
            stpisOperAqui_SemIncidenciaContribuicao            : strCST_PIS := '74';
            stpisOperAquiPorST                                 : strCST_PIS := '75';
            stpisOutrasOperacoesEntrada                        : strCST_PIS := '98';
            stpisOutrasOperacoes                               : strCST_PIS := '99';
          end;

          case CST_COFINS of
            stcofinsValorAliquotaNormal                           : strCST_COFINS := '01';
            stcofinsValorAliquotaDiferenciada                     : strCST_COFINS := '02';
            stcofinsQtdeAliquotaUnidade                           : strCST_COFINS := '03';
            stcofinsMonofaticaAliquotaZero                        : strCST_COFINS := '04';
            stcofinsValorAliquotaPorST                            : strCST_COFINS := '05';
            stcofinsAliquotaZero                                  : strCST_COFINS := '06';
            stcofinsIsentaContribuicao                            : strCST_COFINS := '07';
            stcofinsSemIncidenciaContribuicao                     : strCST_COFINS := '08';
            stcofinsSuspensaoContribuicao                         : strCST_COFINS := '09';
            stcofinsOutrasOperacoesSaida                          : strCST_COFINS := '49';
            stcofinsOperCredExcRecTribMercInt                     : strCST_COFINS := '50';
            stcofinsOperCredExcRecNaoTribMercInt                  : strCST_COFINS := '51';
            stcofinsOperCredExcRecExportacao                      : strCST_COFINS := '52';
            stcofinsOperCredRecTribNaoTribMercInt                 : strCST_COFINS := '53';
            stcofinsOperCredRecTribMercIntEExportacao             : strCST_COFINS := '54';
            stcofinsOperCredRecNaoTribMercIntEExportacao          : strCST_COFINS := '55';
            stcofinsOperCredRecTribENaoTribMercIntEExportacao     : strCST_COFINS := '56';
            stcofinsCredPresAquiExcRecTribMercInt                 : strCST_COFINS := '60';
            stcofinsCredPresAquiExcRecNaoTribMercInt              : strCST_COFINS := '61';
            stcofinsCredPresAquiExcExcRecExportacao               : strCST_COFINS := '62';
            stcofinsCredPresAquiRecTribNaoTribMercInt             : strCST_COFINS := '63';
            stcofinsCredPresAquiRecTribMercIntEExportacao         : strCST_COFINS := '64';
            stcofinsCredPresAquiRecNaoTribMercIntEExportacao      : strCST_COFINS := '65';
            stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_COFINS := '66';
            stcofinsOutrasOperacoes_CredPresumido                 : strCST_COFINS := '67';
            stcofinsOperAquiSemDirCredito                         : strCST_COFINS := '70';
            stcofinsOperAquiComIsensao                            : strCST_COFINS := '71';
            stcofinsOperAquiComSuspensao                          : strCST_COFINS := '72';
            stcofinsOperAquiAliquotaZero                          : strCST_COFINS := '73';
            stcofinsOperAqui_SemIncidenciaContribuicao            : strCST_COFINS := '74';
            stcofinsOperAquiPorST                                 : strCST_COFINS := '75';
            stcofinsOutrasOperacoesEntrada                        : strCST_COFINS := '98';
            stcofinsOutrasOperacoes                               : strCST_COFINS := '99';
          end;

          Add( LFill('F200')               +
               LFill( strIND_OPER )        +
               LFill( UNID_IMOB )          + //Verificar criação da tabela no ACBrEPCBlocos
               LFill( IDENT_EMP )          +
               LFill( DESC_UNID_IMOB )     +
               LFill( NUM_CONT )           +
               LFill( CPF_CNPJ_ADQU )      +
               LFill( DT_OPER )            +
               LFill( VL_TOT_VEND,0,2 )    +
               LFill( VL_REC_ACUM,0,2 )    +
               LFill( VL_TOT_REC,0,2 )     +
               LFill( strCST_PIS )         +
               LFill( VL_BC_PIS,0,2 )      +
               LFill( ALIQ_PIS,0,2 )       +
               LFill( VL_PIS,0,2 )         +
               LFill( strCST_COFINS )      +
               LFill( VL_BC_COFINS,0,2 )   +
               LFill( ALIQ_COFINS,0,2 )    +
               LFill( VL_COFINS,0,2 )      +
               LFill( PERC_REC_RECEB,0,2 ) +
               LFill( IND_NAT_EMP )        + //Verificar criação da tabela no ACBrEPCBlocos
               LFill( INF_COMP ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF205( RegF010.RegistroF200.Items[intFor] );
        WriteRegistroF210( RegF010.RegistroF200.Items[intFor] );
        WriteRegistroF211( RegF010.RegistroF200.Items[intFor] );
        ///
        RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroF200Count := FRegistroF200Count + RegF010.RegistroF200.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF205(RegF200: TRegistroF200) ;
  var
    strCST_PIS     : AnsiString;
    strCST_COFINS  : AnsiString;    
begin
  if Assigned(RegF200.RegistroF205) then
  begin
    with RegF200.RegistroF205 do
    begin

      case CST_PIS of
        stpisValorAliquotaNormal                           : strCST_PIS := '01';
        stpisValorAliquotaDiferenciada                     : strCST_PIS := '02';
        stpisQtdeAliquotaUnidade                           : strCST_PIS := '03';
        stpisMonofaticaAliquotaZero                        : strCST_PIS := '04';
        stpisValorAliquotaPorST                            : strCST_PIS := '05';
        stpisAliquotaZero                                  : strCST_PIS := '06';
        stpisIsentaContribuicao                            : strCST_PIS := '07';
        stpisSemIncidenciaContribuicao                     : strCST_PIS := '08';
        stpisSuspensaoContribuicao                         : strCST_PIS := '09';
        stpisOutrasOperacoesSaida                          : strCST_PIS := '49';
        stpisOperCredExcRecTribMercInt                     : strCST_PIS := '50';
        stpisOperCredExcRecNaoTribMercInt                  : strCST_PIS := '51';
        stpisOperCredExcRecExportacao                      : strCST_PIS := '52';
        stpisOperCredRecTribNaoTribMercInt                 : strCST_PIS := '53';
        stpisOperCredRecTribMercIntEExportacao             : strCST_PIS := '54';
        stpisOperCredRecNaoTribMercIntEExportacao          : strCST_PIS := '55';
        stpisOperCredRecTribENaoTribMercIntEExportacao     : strCST_PIS := '56';
        stpisCredPresAquiExcRecTribMercInt                 : strCST_PIS := '60';
        stpisCredPresAquiExcRecNaoTribMercInt              : strCST_PIS := '61';
        stpisCredPresAquiExcExcRecExportacao               : strCST_PIS := '62';
        stpisCredPresAquiRecTribNaoTribMercInt             : strCST_PIS := '63';
        stpisCredPresAquiRecTribMercIntEExportacao         : strCST_PIS := '64';
        stpisCredPresAquiRecNaoTribMercIntEExportacao      : strCST_PIS := '65';
        stpisCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_PIS := '66';
        stpisOutrasOperacoes_CredPresumido                 : strCST_PIS := '67';
        stpisOperAquiSemDirCredito                         : strCST_PIS := '70';
        stpisOperAquiComIsensao                            : strCST_PIS := '71';
        stpisOperAquiComSuspensao                          : strCST_PIS := '72';
        stpisOperAquiAliquotaZero                          : strCST_PIS := '73';
        stpisOperAqui_SemIncidenciaContribuicao            : strCST_PIS := '74';
        stpisOperAquiPorST                                 : strCST_PIS := '75';
        stpisOutrasOperacoesEntrada                        : strCST_PIS := '98';
        stpisOutrasOperacoes                               : strCST_PIS := '99';
      end;

      case CST_COFINS of
        stcofinsValorAliquotaNormal                           : strCST_COFINS := '01';
        stcofinsValorAliquotaDiferenciada                     : strCST_COFINS := '02';
        stcofinsQtdeAliquotaUnidade                           : strCST_COFINS := '03';
        stcofinsMonofaticaAliquotaZero                        : strCST_COFINS := '04';
        stcofinsValorAliquotaPorST                            : strCST_COFINS := '05';
        stcofinsAliquotaZero                                  : strCST_COFINS := '06';
        stcofinsIsentaContribuicao                            : strCST_COFINS := '07';
        stcofinsSemIncidenciaContribuicao                     : strCST_COFINS := '08';
        stcofinsSuspensaoContribuicao                         : strCST_COFINS := '09';
        stcofinsOutrasOperacoesSaida                          : strCST_COFINS := '49';
        stcofinsOperCredExcRecTribMercInt                     : strCST_COFINS := '50';
        stcofinsOperCredExcRecNaoTribMercInt                  : strCST_COFINS := '51';
        stcofinsOperCredExcRecExportacao                      : strCST_COFINS := '52';
        stcofinsOperCredRecTribNaoTribMercInt                 : strCST_COFINS := '53';
        stcofinsOperCredRecTribMercIntEExportacao             : strCST_COFINS := '54';
        stcofinsOperCredRecNaoTribMercIntEExportacao          : strCST_COFINS := '55';
        stcofinsOperCredRecTribENaoTribMercIntEExportacao     : strCST_COFINS := '56';
        stcofinsCredPresAquiExcRecTribMercInt                 : strCST_COFINS := '60';
        stcofinsCredPresAquiExcRecNaoTribMercInt              : strCST_COFINS := '61';
        stcofinsCredPresAquiExcExcRecExportacao               : strCST_COFINS := '62';
        stcofinsCredPresAquiRecTribNaoTribMercInt             : strCST_COFINS := '63';
        stcofinsCredPresAquiRecTribMercIntEExportacao         : strCST_COFINS := '64';
        stcofinsCredPresAquiRecNaoTribMercIntEExportacao      : strCST_COFINS := '65';
        stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_COFINS := '66';
        stcofinsOutrasOperacoes_CredPresumido                 : strCST_COFINS := '67';
        stcofinsOperAquiSemDirCredito                         : strCST_COFINS := '70';
        stcofinsOperAquiComIsensao                            : strCST_COFINS := '71';
        stcofinsOperAquiComSuspensao                          : strCST_COFINS := '72';
        stcofinsOperAquiAliquotaZero                          : strCST_COFINS := '73';
        stcofinsOperAqui_SemIncidenciaContribuicao            : strCST_COFINS := '74';
        stcofinsOperAquiPorST                                 : strCST_COFINS := '75';
        stcofinsOutrasOperacoesEntrada                        : strCST_COFINS := '98';
        stcofinsOutrasOperacoes                               : strCST_COFINS := '99';
      end;

      Add( LFill('F205')                        +
           LFill( VL_CUS_INC_ACUM_ANT,0,2 )     +
           LFill( VL_CUS_INC_PER_ESC,0,2 )      +
           LFill( VL_CUS_INC_ACUM,0,2 )         +
           LFill( VL_EXC_BC_CUS_INC_ACUM,0,2 )  +
           LFill( VL_BC_CUS_INC,0,2 )           +
           LFill( strCST_PIS )                  +
           LFill( ALIQ_PIS,0,2 )                +
           LFill( VL_CRED_PIS_ACUM,0,2 )        +
           LFill( VL_CRED_PIS_DESC_ANT,0,2 )    +
           LFill( VL_CRED_PIS_DESC,0,2 )        +
           LFill( VL_CRED_PIS_DESC_FUT,0,2 )    +
           LFill( strCST_COFINS )               +
           LFill( ALIQ_COFINS,0,2 )             +
           LFill( VL_CRED_COFINS_ACUM,0,2 )     +
           LFill( VL_CRED_COFINS_DESC_ANT,0,2 ) +
           LFill( VL_CRED_COFINS_DESC,0,2 )     +
           LFill( VL_CRED_COFINS_DESC_FUT,0,2 ) ) ;
      //
      RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
    end;
  end;
end;

procedure TBloco_F.WriteRegistroF210(RegF200: TRegistroF200) ;
  var
    intFor         : integer;
    strCST_PIS     : AnsiString;
    strCST_COFINS  : AnsiString;
begin
  if Assigned(RegF200.RegistroF210) then
  begin
    for intFor := 0 to RegF200.RegistroF210.Count - 1 do
    begin
      with RegF200.RegistroF210.Items[intFor] do
      begin

        case CST_PIS of
          stpisValorAliquotaNormal                           : strCST_PIS := '01';
          stpisValorAliquotaDiferenciada                     : strCST_PIS := '02';
          stpisQtdeAliquotaUnidade                           : strCST_PIS := '03';
          stpisMonofaticaAliquotaZero                        : strCST_PIS := '04';
          stpisValorAliquotaPorST                            : strCST_PIS := '05';
          stpisAliquotaZero                                  : strCST_PIS := '06';
          stpisIsentaContribuicao                            : strCST_PIS := '07';
          stpisSemIncidenciaContribuicao                     : strCST_PIS := '08';
          stpisSuspensaoContribuicao                         : strCST_PIS := '09';
          stpisOutrasOperacoesSaida                          : strCST_PIS := '49';
          stpisOperCredExcRecTribMercInt                     : strCST_PIS := '50';
          stpisOperCredExcRecNaoTribMercInt                  : strCST_PIS := '51';
          stpisOperCredExcRecExportacao                      : strCST_PIS := '52';
          stpisOperCredRecTribNaoTribMercInt                 : strCST_PIS := '53';
          stpisOperCredRecTribMercIntEExportacao             : strCST_PIS := '54';
          stpisOperCredRecNaoTribMercIntEExportacao          : strCST_PIS := '55';
          stpisOperCredRecTribENaoTribMercIntEExportacao     : strCST_PIS := '56';
          stpisCredPresAquiExcRecTribMercInt                 : strCST_PIS := '60';
          stpisCredPresAquiExcRecNaoTribMercInt              : strCST_PIS := '61';
          stpisCredPresAquiExcExcRecExportacao               : strCST_PIS := '62';
          stpisCredPresAquiRecTribNaoTribMercInt             : strCST_PIS := '63';
          stpisCredPresAquiRecTribMercIntEExportacao         : strCST_PIS := '64';
          stpisCredPresAquiRecNaoTribMercIntEExportacao      : strCST_PIS := '65';
          stpisCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_PIS := '66';
          stpisOutrasOperacoes_CredPresumido                 : strCST_PIS := '67';
          stpisOperAquiSemDirCredito                         : strCST_PIS := '70';
          stpisOperAquiComIsensao                            : strCST_PIS := '71';
          stpisOperAquiComSuspensao                          : strCST_PIS := '72';
          stpisOperAquiAliquotaZero                          : strCST_PIS := '73';
          stpisOperAqui_SemIncidenciaContribuicao            : strCST_PIS := '74';
          stpisOperAquiPorST                                 : strCST_PIS := '75';
          stpisOutrasOperacoesEntrada                        : strCST_PIS := '98';
          stpisOutrasOperacoes                               : strCST_PIS := '99';
        end;

        case CST_COFINS of
          stcofinsValorAliquotaNormal                           : strCST_COFINS := '01';
          stcofinsValorAliquotaDiferenciada                     : strCST_COFINS := '02';
          stcofinsQtdeAliquotaUnidade                           : strCST_COFINS := '03';
          stcofinsMonofaticaAliquotaZero                        : strCST_COFINS := '04';
          stcofinsValorAliquotaPorST                            : strCST_COFINS := '05';
          stcofinsAliquotaZero                                  : strCST_COFINS := '06';
          stcofinsIsentaContribuicao                            : strCST_COFINS := '07';
          stcofinsSemIncidenciaContribuicao                     : strCST_COFINS := '08';
          stcofinsSuspensaoContribuicao                         : strCST_COFINS := '09';
          stcofinsOutrasOperacoesSaida                          : strCST_COFINS := '49';
          stcofinsOperCredExcRecTribMercInt                     : strCST_COFINS := '50';
          stcofinsOperCredExcRecNaoTribMercInt                  : strCST_COFINS := '51';
          stcofinsOperCredExcRecExportacao                      : strCST_COFINS := '52';
          stcofinsOperCredRecTribNaoTribMercInt                 : strCST_COFINS := '53';
          stcofinsOperCredRecTribMercIntEExportacao             : strCST_COFINS := '54';
          stcofinsOperCredRecNaoTribMercIntEExportacao          : strCST_COFINS := '55';
          stcofinsOperCredRecTribENaoTribMercIntEExportacao     : strCST_COFINS := '56';
          stcofinsCredPresAquiExcRecTribMercInt                 : strCST_COFINS := '60';
          stcofinsCredPresAquiExcRecNaoTribMercInt              : strCST_COFINS := '61';
          stcofinsCredPresAquiExcExcRecExportacao               : strCST_COFINS := '62';
          stcofinsCredPresAquiRecTribNaoTribMercInt             : strCST_COFINS := '63';
          stcofinsCredPresAquiRecTribMercIntEExportacao         : strCST_COFINS := '64';
          stcofinsCredPresAquiRecNaoTribMercIntEExportacao      : strCST_COFINS := '65';
          stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao : strCST_COFINS := '66';
          stcofinsOutrasOperacoes_CredPresumido                 : strCST_COFINS := '67';
          stcofinsOperAquiSemDirCredito                         : strCST_COFINS := '70';
          stcofinsOperAquiComIsensao                            : strCST_COFINS := '71';
          stcofinsOperAquiComSuspensao                          : strCST_COFINS := '72';
          stcofinsOperAquiAliquotaZero                          : strCST_COFINS := '73';
          stcofinsOperAqui_SemIncidenciaContribuicao            : strCST_COFINS := '74';
          stcofinsOperAquiPorST                                 : strCST_COFINS := '75';
          stcofinsOutrasOperacoesEntrada                        : strCST_COFINS := '98';
          stcofinsOutrasOperacoes                               : strCST_COFINS := '99';
        end;

        Add( LFill('F210')                 +
             LFill( VL_CUS_ORC,0,2 )       +
             LFill( VL_EXC,0,2 )           +
             LFill( VL_CUS_ORC_AJU,0,2 )   +
             LFill( VL_BC_CRED,0,2 )       +
             LFill( strCST_PIS )           +
             LFill( ALIQ_PIS,0,2 )         +
             LFill( VL_CRED_PIS_UTIL,0,2 ) +
             LFill( strCST_COFINS )        +
             LFill( ALIQ_COFINS,0,2 )      +
             LFill( VL_CRED_COFINS_UTIL,0,2 ) ) ;
        //
        RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
      end;
    end;
    // Variavél para armazenar a quantidade de registro do tipo.
    FRegistroF210Count := FRegistroF210Count + RegF200.RegistroF210.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF211(RegF200: TRegistroF200) ;
  var
    intFor      : integer;
    strIND_PROC : AnsiString;
begin
  if Assigned(RegF200.RegistroF211) then
  begin
    for intFor := 0 to RegF200.RegistroF211.Count - 1 do
    begin
      with RegF200.RegistroF211.Items[intFor] do
      begin
        case IND_PROC of
          opJusticaFederal : strIND_PROC := '0';
          opSecexRFB       : strIND_PROC := '1';
          opOutros         : strIND_PROC := '9';
          opNenhum         : strIND_PROC := '';
        end;

        Add( LFill('F211')   +
             LFill(NUM_PROC) +
             LFill(strIND_PROC) ) ;
      end;

      RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
    end;
    /// Variavél para armazenar a quantidade de registro do tipo.
    FRegistroF211Count := FRegistroF211Count + RegF200.RegistroF211.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF600(RegF010: TRegistroF010) ;
  var
    intFor         : integer;
    strIND_NAT_REC, strIND_NAT_RET : AnsiString;
begin
  if Assigned(RegF010.RegistroF600) then
  begin
     for intFor := 0 to RegF010.RegistroF600.Count - 1 do
     begin
        with RegF010.RegistroF600.Items[intFor] do
        begin

          case IND_NAT_REC of
            inrNaoCumulativa : strIND_NAT_REC := '0' ; // 0 // Receita de Natureza Não Cumulativa
            inrCumulativa    : strIND_NAT_REC := '1' ; // 1 // Receita de Natureza Cumulativa
          end;

          case IND_NAT_RET of
            indRetOrgAutarquiasFundFederais : strIND_NAT_RET := '01' ; // 01 - Retenção por Órgãos, Autarquias e Fundações Federais
            indRetEntAdmPublicaFederal      : strIND_NAT_RET := '02' ; // 02 - Retenção por outras Entidades da Administração Pública Federal
            indRetPesJuridicasDireitoPri    : strIND_NAT_RET := '03' ; // 03 - Retenção por Pessoas Jurídicas de Direito Privado
            indRecolhimentoSociedadeCoop    : strIND_NAT_RET := '04' ; // 04 - Recolhimento por Sociedade Cooperativa
            indRetFabricanteMaqVeiculos     : strIND_NAT_RET := '05' ; // 05 - Retenção por Fabricante de Máquinas e Veículos
            indOutrasRetencoes              : strIND_NAT_RET := '99' ; // 99 - Outras Retenções
          end;

          Add( LFill('F600')               +
               LFill( strIND_NAT_RET )     +
               LFill( DT_RET )             +
               LFill( VL_BC_RET ,0,2 )     +
               LFill( VL_RET ,0,2 )        +
               LFill( COD_REC )            +
               LFill( strIND_NAT_REC )     +  
               LFill( CNPJ )               +
               LFill( VL_RET_PIS ,0,2 )    +
               LFill( VL_RET_COFINS ,0,2 ) +
               LFill( IND_DEC ) ) ;
        end;

        ///
        RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroF600Count := FRegistroF600Count + RegF010.RegistroF600.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF700(RegF010: TRegistroF010) ;
  var
    intFor: integer;
    strIND_ORI_DED, strIND_NAT_DED: AnsiString;
begin
  if Assigned(RegF010.RegistroF700) then
  begin
     for intFor := 0 to RegF010.RegistroF700.Count - 1 do
     begin
        with RegF010.RegistroF700.Items[intFor] do
        begin
        
          case IND_ORI_DED of
             indCredPreMed              : strIND_ORI_DED := '01' ; // 01 – Créditos Presumidos - Medicamentos
             indCredAdmRegCumulativoBeb : strIND_ORI_DED := '02' ; // 02 – Créditos Admitidos no Regime Cumulativo – Bebidas Frias
             indContribSTZFM            : strIND_ORI_DED := '03' ; // 03 – Contribuição Paga pelo Substituto Tributário - ZFM
             indSTNaoOCFatoGeradorPres  : strIND_ORI_DED := '04' ; // 04 – Substituição Tributária – Não Ocorrência do Fato Gerador Presumido
             indOutrasDeducoes          : strIND_ORI_DED := '99' ; // 99 - Outras Deduções
          end;

          case IND_NAT_DED of
            indNaoAcumulativa  : strIND_NAT_DED := '0' ;  // 0 – Dedução de Natureza Não Cumulativa
            indAcumulativa     : strIND_NAT_DED := '1' ;  // 1 – Dedução de Natureza Cumulativa
          end;

          Add( LFill('F700')               +
               LFill( strIND_ORI_DED )     +
               LFill( strIND_NAT_DED )     +
               LFill( VL_DED_PIS ,0,2 )    +
               LFill( VL_DED_COFINS ,0,2 ) +
               LFill( VL_BC_OPER ,0,2 )    +
               LFill( CNPJ )               +
               LFill( INF_COMP ) ) ;
        end;

        ///
        RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroF700Count := FRegistroF700Count + RegF010.RegistroF700.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF800(RegF010: TRegistroF010) ;
  var
    intFor      : integer;
    strCOD_CRED : AnsiString;
begin
  if Assigned(RegF010.RegistroF800) then
  begin
     for intFor := 0 to RegF010.RegistroF800.Count - 1 do
     begin
        with RegF010.RegistroF800.Items[intFor] do
        begin

          case COD_CRED of
                    //CÓDIGOS VINCULADOS À RECEITA TRIBUTADA NO MERCADO INTERNO - Grupo 100
                    ccRTMIAliqBasica         : strCOD_CRED := '101' ; // Crédito vinculado à receita tributada no mercado interno - Alíquota Básica
                    ccRTMIAliqDiferenciada   : strCOD_CRED := '102' ; // Crédito vinculado à receita tributada no mercado interno - Alíquotas Diferenciadas
                    ccRTMIAliqUnidProduto    : strCOD_CRED := '103' ; // Crédito vinculado à receita tributada no mercado interno - Alíquota por Unidade de Produto
                    ccRTMIEstAbertura        : strCOD_CRED := '104' ; // Crédito vinculado à receita tributada no mercado interno - Estoque de Abertura
                    ccRTMIAquiEmbalagem      : strCOD_CRED := '105' ; // Crédito vinculado à receita tributada no mercado interno - Aquisição Embalagens para revenda
                    ccRTMIPreAgroindustria   : strCOD_CRED := '106' ; // Crédito vinculado à receita tributada no mercado interno - Presumido da Agroindústria
                    ccRTMIImportacao         : strCOD_CRED := '108' ; // Crédito vinculado à receita tributada no mercado interno - Importação
                    ccRTMIAtivImobiliaria    : strCOD_CRED := '109' ; // Crédito vinculado à receita tributada no mercado interno - Atividade Imobiliária
                    ccRTMIOutros             : strCOD_CRED := '199' ; // Crédito vinculado à receita tributada no mercado interno - Outros
                    //CÓDIGOS VINCULADOS À RECEITA NÃO TRIBUTADA NO MERCADO INTERNO - Grupo 200
                    ccRNTMIAliqBasica        : strCOD_CRED := '201' ; // Crédito vinculado à receita não tributada no mercado interno - Alíquota Básica
                    ccRNTMIAliqDiferenciada  : strCOD_CRED := '202' ; // Crédito vinculado à receita não tributada no mercado interno - Alíquotas Diferenciadas
                    ccRNTMIAliqUnidProduto   : strCOD_CRED := '203' ; // Crédito vinculado à receita não tributada no mercado interno - Alíquota por Unidade de Produto
                    ccRNTMIEstAbertura       : strCOD_CRED := '204' ; // Crédito vinculado à receita não tributada no mercado interno - Estoque de Abertura
                    ccRNTMIAquiEmbalagem     : strCOD_CRED := '205' ; // Crédito vinculado à receita não tributada no mercado interno - Aquisição Embalagens para revenda
                    ccRNTMIPreAgroindustria  : strCOD_CRED := '206' ; // Crédito vinculado à receita não tributada no mercado interno - Presumido da Agroindústria
                    ccRNTMIImportacao        : strCOD_CRED := '208' ; // Crédito vinculado à receita não tributada no mercado interno - Importação
                    ccRNTMIOutros            : strCOD_CRED := '299' ; // Crédito vinculado à receita não tributada no mercado interno - Outros
                    //CÓDIGOS VINCULADOS À RECEITA DE EXPORTAÇÃO - Grupo 300
                    ccREAliqBasica           : strCOD_CRED := '301' ; // Crédito vinculado à receita de exportação - Alíquota Básica
                    ccREAliqDiferenciada     : strCOD_CRED := '302' ; // Crédito vinculado à receita de exportação - Alíquotas Diferenciadas
                    ccREAliqUnidProduto      : strCOD_CRED := '303' ; // Crédito vinculado à receita de exportação - Alíquota por Unidade de Produto
                    ccREEstAbertura          : strCOD_CRED := '304' ; // Crédito vinculado à receita de exportação - Estoque de Abertura
                    ccREAquiEmbalagem        : strCOD_CRED := '305' ; // Crédito vinculado à receita de exportação - Aquisição Embalagens para revenda
                    ccREPreAgroindustria     : strCOD_CRED := '306' ; // Crédito vinculado à receita de exportação - Presumido da Agroindústria
                    ccREPreAgroindustriaPCR  : strCOD_CRED := '307' ; // Crédito vinculado à receita de exportação - Presumido da Agroindústria – Passível de Compensação e/ou Ressarcimento
                    ccREImportacao           : strCOD_CRED := '308' ; // Crédito vinculado à receita de exportação - Importação
                    ccREOutros               : strCOD_CRED := '399' ; // Crédito vinculado à receita de exportação - Outros
          end;

          Add( LFill('F800')                +
               LFill( IND_NAT_EVEN )        +   //Verificar criação da tabela no ACBrEPCBlocos
               LFill( DT_EVEN )             +
               LFill( CNPJ_SUCED )          +
               LFill( PA_CONT_CRED )        +
               LFill( strCOD_CRED )         +   
               LFill( VL_CRED_PIS ,0,2 )    +
               LFill( VL_CRED_COFINS ,0,2 ) +
               LFill( VL_CRED_COFINS ,0,2 ) ) ;
        end;

        ///
        RegistroF990.QTD_LIN_F := RegistroF990.QTD_LIN_F + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroF800Count := FRegistroF800Count + RegF010.RegistroF800.Count;
  end;
end;

procedure TBloco_F.WriteRegistroF990 ;
begin
  if Assigned(RegistroF990) then
  begin
     with RegistroF990 do
     begin
       QTD_LIN_F := QTD_LIN_F + 1;
       ///
       Add( LFill('F990') +
            LFill(QTD_LIN_F,0) );
     end;
  end;
end;

end.
