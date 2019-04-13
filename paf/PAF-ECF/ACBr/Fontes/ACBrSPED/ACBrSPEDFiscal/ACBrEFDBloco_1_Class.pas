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

unit ACBrEFDBloco_1_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEFDBloco_1,
     ACBrEFDBloco_0_Class, ACBrEFDBlocos, ACBrUtil;

type
  /// TBLOCO_1 -
  TBloco_1 = class(TACBrSPED)
  private
    FBloco_0: TBloco_0;

    FRegistro1001: TRegistro1001;      /// BLOCO 1 - Registro1001
    FRegistro1990: TRegistro1990;      /// BLOCO 1 - Registro1990

    FRegistro1100Count: Integer;
    FRegistro1105Count: Integer;
    FRegistro1110Count: Integer;
    FRegistro1200Count: Integer;
    FRegistro1210Count: Integer;
    FRegistro1300Count: Integer;
    FRegistro1310Count: Integer;
    FRegistro1320Count: Integer;
    FRegistro1350Count: Integer;
    FRegistro1360Count: Integer;
    FRegistro1370Count: Integer;
    FRegistro1400Count: Integer;
    FRegistro1500Count: Integer;
    FRegistro1510Count: Integer;
    FRegistro1600Count: Integer;
    FRegistro1700Count: Integer;
    FRegistro1710Count: Integer;
    FRegistro1800Count: Integer;

    procedure WriteRegistro1100(Reg1001: TRegistro1001) ;
    procedure WriteRegistro1105(Reg1100: TRegistro1100) ;
    procedure WriteRegistro1110(Reg1105: TRegistro1105) ;
    procedure WriteRegistro1200(Reg1001: TRegistro1001) ;
    procedure WriteRegistro1210(Reg1200: TRegistro1200) ;
    procedure WriteRegistro1300(Reg1001: TRegistro1001) ;
    procedure WriteRegistro1310(Reg1300: TRegistro1300) ;
    procedure WriteRegistro1320(Reg1310: TRegistro1310) ;
    procedure WriteRegistro1350(Reg1001: TRegistro1001) ;
    procedure WriteRegistro1360(Reg1350: TRegistro1350) ;
    procedure WriteRegistro1370(Reg1350: TRegistro1350) ;
    procedure WriteRegistro1400(Reg1001: TRegistro1001) ;
    procedure WriteRegistro1500(Reg1001: TRegistro1001) ;
    procedure WriteRegistro1510(Reg1500: TRegistro1500) ;
    procedure WriteRegistro1600(Reg1001: TRegistro1001) ;
    procedure WriteRegistro1700(Reg1001: TRegistro1001) ;
    procedure WriteRegistro1710(Reg1700: TRegistro1700) ;
    procedure WriteRegistro1800(Reg1001: TRegistro1001) ;

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create;           /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function Registro1001New: TRegistro1001;
    function Registro1100New: TRegistro1100;
    function Registro1105New: TRegistro1105;
    function Registro1110New: TRegistro1110;
    function Registro1200New: TRegistro1200;
    function Registro1210New: TRegistro1210;
    function Registro1300New: TRegistro1300;
    function Registro1310New: TRegistro1310;
    function Registro1320New: TRegistro1320;
    function Registro1350New: TRegistro1350;
    function Registro1360New: TRegistro1360;
    function Registro1370New: TRegistro1370;
    function Registro1400New: TRegistro1400;
    function Registro1500New: TRegistro1500;
    function Registro1510New: TRegistro1510;
    function Registro1600New: TRegistro1600;
    function Registro1700New: TRegistro1700;
    function Registro1710New: TRegistro1710;
    function Registro1800New: TRegistro1800;

    procedure WriteRegistro1001 ;
    procedure WriteRegistro1990 ;

    property Bloco_0: TBloco_0 read FBloco_0 write FBloco_0;
    property Registro1001: TRegistro1001 read FRegistro1001 write FRegistro1001;
    property Registro1990: TRegistro1990 read FRegistro1990 write FRegistro1990;

    property Registro1100Count: Integer read FRegistro1100Count write FRegistro1100Count;
    property Registro1105Count: Integer read FRegistro1105Count write FRegistro1105Count;
    property Registro1110Count: Integer read FRegistro1110Count write FRegistro1110Count;
    property Registro1200Count: Integer read FRegistro1200Count write FRegistro1200Count;
    property Registro1210Count: Integer read FRegistro1210Count write FRegistro1210Count;
    property Registro1300Count: Integer read FRegistro1300Count write FRegistro1300Count;
    property Registro1310Count: Integer read FRegistro1310Count write FRegistro1310Count;
    property Registro1320Count: Integer read FRegistro1320Count write FRegistro1320Count;
    property Registro1350Count: Integer read FRegistro1350Count write FRegistro1350Count;
    property Registro1360Count: Integer read FRegistro1360Count write FRegistro1360Count;
    property Registro1370Count: Integer read FRegistro1370Count write FRegistro1370Count;
    property Registro1400Count: Integer read FRegistro1400Count write FRegistro1400Count;
    property Registro1500Count: Integer read FRegistro1500Count write FRegistro1500Count;
    property Registro1510Count: Integer read FRegistro1510Count write FRegistro1510Count;
    property Registro1600Count: Integer read FRegistro1600Count write FRegistro1600Count;
    property Registro1700Count: Integer read FRegistro1700Count write FRegistro1700Count;
    property Registro1710Count: Integer read FRegistro1710Count write FRegistro1710Count;
    property Registro1800Count: Integer read FRegistro1800Count write FRegistro1800Count;
  end;

implementation

{ TBloco_1 }

constructor TBloco_1.Create;
begin
  inherited ;
  CriaRegistros;
end;

destructor TBloco_1.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_1.CriaRegistros;
begin
  FRegistro1001 := TRegistro1001.Create;
  FRegistro1990 := TRegistro1990.Create;

  Registro1100Count := 0;
  Registro1105Count := 0;
  Registro1110Count := 0;
  Registro1200Count := 0;
  Registro1210Count := 0;
  Registro1300Count := 0;
  Registro1310Count := 0;
  Registro1320Count := 0;
  Registro1350Count := 0;
  Registro1360Count := 0;
  Registro1370Count := 0;
  Registro1400Count := 0;
  Registro1500Count := 0;
  Registro1510Count := 0;
  Registro1600Count := 0;
  Registro1700Count := 0;
  Registro1710Count := 0;
  Registro1800Count := 0;

  FRegistro1990.QTD_LIN_1 := 0;
end;

procedure TBloco_1.LiberaRegistros;
begin
  FRegistro1001.Free;
  FRegistro1990.Free;
end;

procedure TBloco_1.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  Conteudo.Clear;

  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_1.Registro1001New: TRegistro1001;
begin
   Result := FRegistro1001;
end;

function TBloco_1.Registro1100New: TRegistro1100;
begin
   Result := FRegistro1001.Registro1100.New;
end;

function TBloco_1.Registro1105New: TRegistro1105;
begin
   Result := FRegistro1001.Registro1100.Items[FRegistro1001.Registro1100.Count -1].Registro1105.New;
end;

function TBloco_1.Registro1110New: TRegistro1110;
var
U100Count: integer;
U105Count: integer;
begin
   U100Count := FRegistro1001.Registro1100.Count -1;
   U105Count := FRegistro1001.Registro1100.Items[U100Count].Registro1105.Count -1;
   //
   Result := FRegistro1001.Registro1100.Items[U100Count].Registro1105.Items[U105Count].Registro1110.New;
end;

function TBloco_1.Registro1200New: TRegistro1200;
begin
   Result := FRegistro1001.Registro1200.New;
end;

function TBloco_1.Registro1210New: TRegistro1210;
begin
   Result := FRegistro1001.Registro1200.Items[FRegistro1001.Registro1200.Count -1].Registro1210.New;
end;

function TBloco_1.Registro1300New: TRegistro1300;
begin
   Result := FRegistro1001.Registro1300.New;
end;

function TBloco_1.Registro1310New: TRegistro1310;
begin
   Result := FRegistro1001.Registro1300.Items[FRegistro1001.Registro1300.Count -1].Registro1310.New;
end;

function TBloco_1.Registro1320New: TRegistro1320;
var
U300Count: integer;
U310Count: integer;
begin
   U300Count := FRegistro1001.Registro1300.Count -1;
   U310Count := FRegistro1001.Registro1300.Items[U300Count].Registro1310.Count -1;
   //
   Result := FRegistro1001.Registro1300.Items[U300Count].Registro1310.Items[U310Count].Registro1320.New;
end;

function TBloco_1.Registro1350New: TRegistro1350;
begin
   Result := FRegistro1001.Registro1350.New;
end;

function TBloco_1.Registro1360New: TRegistro1360;
begin
   Result := FRegistro1001.Registro1350.Items[FRegistro1001.Registro1350.Count -1].Registro1360.New;
end;

function TBloco_1.Registro1370New: TRegistro1370;
begin
   Result := FRegistro1001.Registro1350.Items[FRegistro1001.Registro1350.Count -1].Registro1370.New;
end;

function TBloco_1.Registro1400New: TRegistro1400;
begin
   Result := FRegistro1001.Registro1400.New;
end;

function TBloco_1.Registro1500New: TRegistro1500;
begin
   Result := FRegistro1001.Registro1500.New;
end;

function TBloco_1.Registro1510New: TRegistro1510;
begin
   Result := FRegistro1001.Registro1500.Items[FRegistro1001.Registro1500.Count -1].Registro1510.New;
end;

function TBloco_1.Registro1600New: TRegistro1600;
begin
   Result := FRegistro1001.Registro1600.New;
end;

function TBloco_1.Registro1700New: TRegistro1700;
begin
   Result := FRegistro1001.Registro1700.New;
end;

function TBloco_1.Registro1710New: TRegistro1710;
begin
   Result := FRegistro1001.Registro1700.Items[FRegistro1001.Registro1700.Count -1].Registro1710.New;
end;

function TBloco_1.Registro1800New: TRegistro1800;
begin
   Result := FRegistro1001.Registro1800.New;
end;

procedure TBloco_1.WriteRegistro1001 ;
begin
  if Assigned(Registro1001) then
  begin
     with Registro1001 do
     begin
       Add( LFill( '1001' ) +
            LFill( Integer(IND_MOV), 0 ) ) ;

       if IND_MOV = imComDados then
       begin
         WriteRegistro1100(Registro1001) ;
         WriteRegistro1200(Registro1001) ;
         WriteRegistro1300(Registro1001) ;
         WriteRegistro1350(Registro1001) ;
         WriteRegistro1400(Registro1001) ;
         WriteRegistro1500(Registro1001) ;
         WriteRegistro1600(Registro1001) ;
         WriteRegistro1700(Registro1001) ;
         WriteRegistro1800(Registro1001) ;
       end;
     end;

     Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
  end;
end;

procedure TBloco_1.WriteRegistro1100(Reg1001: TRegistro1001) ;
var
  intFor: integer;
  strTP_CHC: AnsiString;
begin
  if Assigned( Reg1001.Registro1100 ) then
  begin
     for intFor := 0 to Reg1001.Registro1100.Count - 1 do
     begin
        with Reg1001.Registro1100.Items[intFor] do
        begin
          case TP_CHC of
           ceAWB:            strTP_CHC := '01';
           ceMAWB:           strTP_CHC := '02';
           ceHAWB:           strTP_CHC := '03';
           ceCOMAT:          strTP_CHC := '04';
           ceRExpressas:     strTP_CHC := '06';
           ceEtiqREspressas: strTP_CHC := '07';
           ceHrExpressas:    strTP_CHC := '08';
           ceAV7:            strTP_CHC := '09';
           ceBL:             strTP_CHC := '10';
           ceMBL:            strTP_CHC := '11';
           ceHBL:            strTP_CHC := '12';
           ceCTR:            strTP_CHC := '13';
           ceDSIC:           strTP_CHC := '14';
           ceComatBL:        strTP_CHC := '16';
           ceRWB:            strTP_CHC := '17';
           ceHRWB:           strTP_CHC := '18';
           ceTifDta:         strTP_CHC := '19';
           ceCP2:            strTP_CHC := '20';
           ceNaoIATA:        strTP_CHC := '91';
           ceMNaoIATA:       strTP_CHC := '92';
           ceHNaoIATA:       strTP_CHC := '93';
           ceCOutros:        strTP_CHC := '99';
          end;

          Add( LFill('1100') +
               LFill( Integer(IND_DOC), 0 ) +
               LFill( NRO_DE ) +
               LFill( DT_DE ) +
               LFill( Integer(NAT_EXP), 0 ) +
               LFill( NRO_RE ) +
               LFill( DT_RE ) +
               LFill( CHC_EMB ) +
               LFill( DT_CHC ) +
               LFill( DT_AVB ) +
               LFill( strTP_CHC ) +
               LFill( PAIS ) ) ;
        end;
        // Registros - FILHO
        WriteRegistro1105( Reg1001.Registro1100.Items[intFor] );

        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1100Count := FRegistro1100Count + Reg1001.Registro1100.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1105(Reg1100: TRegistro1100) ;
var
  intFor: integer;
begin
  if Assigned( Reg1100.Registro1105 ) then
  begin
     for intFor := 0 to Reg1100.Registro1105.Count - 1 do
     begin
        with Reg1100.Registro1105.Items[intFor] do
        begin
          Add( LFill('1105') +
               LFill( COD_MOD ) +
               LFill( SERIE ) +
               LFill( NUM_DOC ) +
               LFill( CHV_NFE ) +
               LFill( DT_DOC ) +
               LFill( COD_ITEM ) ) ;
        end;
        // Registros - FILHO
        WriteRegistro1110( Reg1100.Registro1105.Items[intFor] );

        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1105Count := FRegistro1105Count + Reg1100.Registro1105.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1110(Reg1105: TRegistro1105) ;
var
  intFor: integer;
begin
  if Assigned( Reg1105.Registro1110 ) then
  begin
     for intFor := 0 to Reg1105.Registro1110.Count - 1 do
     begin
        with Reg1105.Registro1110.Items[intFor] do
        begin
          Add( LFill('1110') +
               LFill( COD_PART ) +
               LFill( COD_MOD ) +
               LFill( SER ) +
               LFill( NUM_DOC ) +
               LFill( DT_DOC ) +
               LFill( CHV_NFE ) +
               LFill( NR_MEMO ) +
               DFill( QTD,3 ) +
               LFill( UNID ) ) ;
        end;
        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1110Count := FRegistro1110Count + Reg1105.Registro1110.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1200(Reg1001: TRegistro1001) ;
var
  intFor: integer;
begin
  if Assigned( Reg1001.Registro1200 ) then
  begin
     for intFor := 0 to Reg1001.Registro1200.Count - 1 do
     begin
        with Reg1001.Registro1200.Items[intFor] do
        begin
          Add( LFill('1200') +
               LFill( COD_AJ_APUR ) +
               LFill( SLD_CRED,0 ) +
               LFill( CRED_APR,0 ) +
               LFill( CRED_RECEB,0 ) +
               LFill( CRED_UTIL,0 ) +
               LFill( SLD_CRED_FIM,0 ) ) ;
        end;
        // Registros - FILHO
        WriteRegistro1210( Reg1001.Registro1200.Items[intFor] );

        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1200Count := FRegistro1200Count + Reg1001.Registro1200.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1210(Reg1200: TRegistro1200) ;
var
  intFor: integer;
begin
  if Assigned( Reg1200.Registro1210 ) then
  begin
     for intFor := 0 to Reg1200.Registro1210.Count - 1 do
     begin
        with Reg1200.Registro1210.Items[intFor] do
        begin
          Add( LFill('1210') +
               LFill( TIPO_UTIL ) +
               LFill( NR_DOC ) +
               LFill( VL_CRED_UTIL,0 ) ) ;
        end;
        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1210Count := FRegistro1210Count + Reg1200.Registro1210.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1300(Reg1001: TRegistro1001) ;
var
  intFor: integer;
begin
  if Assigned( Reg1001.Registro1300 ) then
  begin
     for intFor := 0 to Reg1001.Registro1300.Count - 1 do
     begin
        with Reg1001.Registro1300.Items[intFor] do
        begin
          Add( LFill('1300') +
               LFill( COD_ITEM ) +
               LFill( DT_FECH ) +
               DFill( ESTQ_ABERT,3 ) +
               DFill( VOL_ENTR,3 ) +
               DFill( VOL_DISP,3 ) +
               DFill( VOL_SAIDAS,3 ) +
               DFill( ESTQ_ESCR,3 ) +
               DFill( VAL_AJ_PERDA,3 ) +
               DFill( VAL_AJ_GANHO,3 ) +
               DFill( FECH_FISICO,3 ) ) ;
        end;
        /// Registro FILHOS
        WriteRegistro1310( Reg1001.Registro1300.Items[intFor] );

        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1300Count := FRegistro1300Count + Reg1001.Registro1300.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1310(Reg1300: TRegistro1300) ;
var
  intFor: integer;
begin
  if Assigned( Reg1300.Registro1310 ) then
  begin
     for intFor := 0 to Reg1300.Registro1310.Count - 1 do
     begin
        with Reg1300.Registro1310.Items[intFor] do
        begin
          Add( LFill('1310') +
               LFill( NUM_TANQUE ) +
               DFill( ESTQ_ABERT,3 ) +
               DFill( VOL_ENTR,3 ) +
               DFill( VOL_DISP,3 ) +
               DFill( VOL_SAIDAS,3 ) +
               DFill( ESTQ_ESCR,3 ) +
               DFill( VAL_AJ_PERDA,3 ) +
               DFill( VAL_AJ_GANHO,3 ) +
               DFill( FECH_FISICO,3 ) ) ;
        end;
        /// Registro FILHOS do FILHO
        WriteRegistro1320( Reg1300.Registro1310.Items[intFor] );

        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1310Count := FRegistro1310Count + Reg1300.Registro1310.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1320(Reg1310: TRegistro1310) ;
var
  intFor: integer;
begin
  if Assigned( Reg1310.Registro1320 ) then
  begin
     for intFor := 0 to Reg1310.Registro1320.Count - 1 do
     begin
        with Reg1310.Registro1320.Items[intFor] do
        begin
          Add( LFill('1320') +
               LFill( NUM_BICO ) +
               LFill( NR_INTERV ) +
               LFill( MOT_INTERV ) +
               LFill( NOM_INTERV ) +
               LFill( CNPJ_INTERV ) +
               LFill( CPF_INTERV ) +
               DFill( VAL_FECHA,3 ) +
               DFill( VAL_ABERT,3 ) +
               DFill( VOL_AFERI,3 ) +
               DFill( VOL_VENDAS,3 ) ) ;
        end;
        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1320Count := FRegistro1320Count + Reg1310.Registro1320.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1350(Reg1001: TRegistro1001) ;
var
  intFor: integer;
begin
  if Assigned( Reg1001.Registro1350 ) then
  begin
     for intFor := 0 to Reg1001.Registro1350.Count - 1 do
     begin
        with Reg1001.Registro1350.Items[intFor] do
        begin
          Add( LFill('1350') +
               LFill( SERIE ) +
               LFill( FABRICANTE ) +
               LFill( MODELO ) +
               LFill( Integer(TIPO_MEDICAO), 0 ) ) ;
        end;
        /// Registro FILHOS do FILHO
        WriteRegistro1360( Reg1001.Registro1350.Items[intFor] ) ;
        WriteRegistro1370( Reg1001.Registro1350.Items[intFor] ) ;

        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1350Count := FRegistro1350Count + Reg1001.Registro1350.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1360(Reg1350: TRegistro1350) ;
var
  intFor: integer;
begin
  if Assigned( Reg1350.Registro1360 ) then
  begin
     for intFor := 0 to Reg1350.Registro1360.Count - 1 do
     begin
        with Reg1350.Registro1360.Items[intFor] do
        begin
          Add( LFill('1360') +
               LFill( NUM_LACRE ) +
               LFill( DT_APLICACAO ) ) ;
        end;
        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1360Count := FRegistro1360Count + Reg1350.Registro1360.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1370(Reg1350: TRegistro1350) ;
var
  intFor: integer;
begin
  if Assigned( Reg1350.Registro1370 ) then
  begin
     for intFor := 0 to Reg1350.Registro1370.Count - 1 do
     begin
        with Reg1350.Registro1370.Items[intFor] do
        begin
          Add( LFill('1370') +
               LFill( NUM_BICO ) +
               LFill( COD_ITEM ) +
               LFill( NUM_TANQUE ) ) ;
        end;
        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1370Count := FRegistro1370Count + Reg1350.Registro1370.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1400(Reg1001: TRegistro1001) ;
var
  intFor: integer;
begin
  if Assigned( Reg1001.Registro1400 ) then
  begin
     for intFor := 0 to Reg1001.Registro1400.Count - 1 do
     begin
        with Reg1001.Registro1400.Items[intFor] do
        begin
          Add( LFill('1400') +
               LFill( COD_ITEM ) +
               LFill( MUN ) +
               LFill( VALOR,0,2 ) ) ;
        end;
        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1400Count := FRegistro1400Count + Reg1001.Registro1400.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1500(Reg1001: TRegistro1001) ;
var
  intFor: integer;
  intTP_LIGACAO: integer;
  strCOD_SIT: AnsiString;
  strCOD_GRUPO_TENSAO: AnsiString;
  strCOD_CONS: AnsiString;
begin
  if Assigned( Reg1001.Registro1500 ) then
  begin
     for intFor := 0 to Reg1001.Registro1500.Count - 1 do
     begin
        with Reg1001.Registro1500.Items[intFor] do
        begin
          case COD_SIT of
           sdRegular:               strCOD_SIT := '00';
           sdExtempRegular:         strCOD_SIT := '01';
           sdCancelado:             strCOD_SIT := '02';
           sdCanceladoExtemp:       strCOD_SIT := '03';
           sdDoctoDenegado:         strCOD_SIT := '04';
           sdDoctoNumInutilizada:   strCOD_SIT := '05';
           sdFiscalCompl:           strCOD_SIT := '06';
           sdExtempCompl:           strCOD_SIT := '07';
           sdRegimeEspecNEsp:       strCOD_SIT := '08';
          end;
          case COD_GRUPO_TENSAO of
           gtA1:           strCOD_GRUPO_TENSAO := '01';
           gtA2:           strCOD_GRUPO_TENSAO := '02';
           gtA3:           strCOD_GRUPO_TENSAO := '03';
           gtA3a:          strCOD_GRUPO_TENSAO := '04';
           gtA4:           strCOD_GRUPO_TENSAO := '05';
           gtAS:           strCOD_GRUPO_TENSAO := '06';
           gtB107:         strCOD_GRUPO_TENSAO := '07';
           gtB108:         strCOD_GRUPO_TENSAO := '08';
           gtB209:         strCOD_GRUPO_TENSAO := '09';
           gtB2Rural:      strCOD_GRUPO_TENSAO := '10';
           gtB2Irrigacao:  strCOD_GRUPO_TENSAO := '11';
           gtB3:           strCOD_GRUPO_TENSAO := '12';
           gtB4a:          strCOD_GRUPO_TENSAO := '13';
           gtB4b:          strCOD_GRUPO_TENSAO := '14';
          end;
          case COD_CONS of
           ccComercial:         strCOD_CONS := '01';
           ccConsumoProprio:    strCOD_CONS := '02';
           ccIluminacaoPublica: strCOD_CONS := '03';
           ccIndustrial:        strCOD_CONS := '04';
           ccPoderPublico:      strCOD_CONS := '05';
           ccResidencial:       strCOD_CONS := '06';
           ccRural:             strCOD_CONS := '07';
           ccServicoPublico:    strCOD_CONS := '08';
          end;
          case TP_LIGACAO of
           tlMonofasico: intTP_LIGACAO := 1;
           tlBifasico:   intTP_LIGACAO := 2;
           tlTrifasico:  intTP_LIGACAO := 3;
          end;

          Add( LFill('1500') +
               LFill( IND_OPER ) +
               LFill( IND_EMIT ) +
               LFill( COD_PART ) +
               LFill( COD_MOD ) +
               LFill( strCOD_SIT ) +
               LFill( SER ) +
               LFill( SUB ) +
               LFill( strCOD_CONS ) +
               LFill( NUM_DOC ) +
               LFill( DT_DOC ) +
               LFill( DT_E_S ) +
               LFill( VL_DESC,0,2 ) +
               LFill( VL_DESC,0,2 ) +
               LFill( VL_FORN,0,2 ) +
               LFill( VL_SERV_NT,0,2 ) +
               LFill( VL_TERC,0,2 ) +
               LFill( VL_DA,0,2 ) +
               LFill( VL_BC_ICMS,0,2 ) +
               LFill( VL_ICMS,0,2 ) +
               LFill( VL_BC_ICMS_ST,0,2 ) +
               LFill( VL_ICMS_ST,0,2 ) +
               LFill( COD_INF ) +
               LFill( VL_PIS,0,2 ) +
               LFill( VL_COFINS,0,2 ) +
               LFill( intTP_LIGACAO, 0 ) +
               LFill( strCOD_GRUPO_TENSAO ) ) ;
        end;
        WriteRegistro1510( Reg1001.Registro1500.Items[intFor] );

        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1500Count := FRegistro1500Count + Reg1001.Registro1500.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1510(Reg1500: TRegistro1500) ;
var
  intFor: integer;
begin
  if Assigned( Reg1500.Registro1510 ) then
  begin
     for intFor := 0 to Reg1500.Registro1510.Count - 1 do
     begin
        with Reg1500.Registro1510.Items[intFor] do
        begin
          Add( LFill('1510') +
               LFill( NUM_ITEM ) +
               LFill( COD_ITEM ) +
               LFill( COD_CLASS ) +
               DFill( QTD,3 ) +
               LFill( UNID ) +
               LFill( VL_ITEM,0,2 ) +
               LFill( VL_DESC,0,2 ) +
               LFill( CST_ICMS,3 ) +
               LFill( CFOP,4 ) +
               LFill( VL_BC_ICMS,0,2 ) +
               LFill( ALIQ_ICMS,0,2 ) +
               LFill( VL_ICMS,0,2 ) +
               LFill( VL_BC_ICMS_ST,0,2 ) +
               LFill( ALIQ_ST,0,2 ) +
               LFill( VL_ICMS_ST,0,2 ) +
               LFill( Integer(IND_REC), 0 ) +
               LFill( COD_PART ) +
               LFill( VL_PIS,0,2 ) +
               LFill( VL_COFINS,0,2 ) +
               LFill( COD_CTA ) ) ;
        end;
        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1510Count := FRegistro1510Count + Reg1500.Registro1510.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1600(Reg1001: TRegistro1001) ;
var
  intFor: integer;
begin
  if Assigned( Reg1001.Registro1600 ) then
  begin
     for intFor := 0 to Reg1001.Registro1600.Count - 1 do
     begin
        with Reg1001.Registro1600.Items[intFor] do
        begin
          Add( LFill('1600') +
               LFill( COD_PART ) +
               LFill( TOT_CREDITO, 0, 2) +
               LFill( TOT_DEBITO, 0, 2) );
        end;
        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1600Count := FRegistro1600Count + Reg1001.Registro1600.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1700(Reg1001: TRegistro1001) ;
var
  intFor: integer;
  strCOD_DISP: AnsiString;
begin
  if Assigned( Reg1001.Registro1700 ) then
  begin
     for intFor := 0 to Reg1001.Registro1700.Count - 1 do
     begin
        with Reg1001.Registro1700.Items[intFor] do
        begin
          case COD_DISP of
           cdaFormSeguranca: strCOD_DISP := '00';
           cdaFSDA:          strCOD_DISP := '01';
           cdaNFe:           strCOD_DISP := '02';
           cdaFormContinuo:  strCOD_DISP := '03';
           cdaBlocos:        strCOD_DISP := '04';
           cdaJogosSoltos:   strCOD_DISP := '05';
          end;

          Check(StrIsNumber(Trim(NUM_DOC_INI)), '(1-1700) Documento Fiscal: Numeração incorreta "%s" para Documento Inicial', [NUM_DOC_INI]);
          Check(StrIsNumber(Trim(NUM_DOC_FIN)), '(1-1700) Documento Fiscal: Numeração incorreta "%s" para Documento Final', [NUM_DOC_FIN]);
          Check(StrIsNumber(Trim((NUM_AUT))), '(1-1700) Documento Fiscal: Numeração incorreta "%s" para Número Autorização', [NUM_AUT]);

          Add( LFill('1700') +
               LFill( strCOD_DISP, 2 ) +
               LFill( COD_MOD, 2 ) +
               LFill( SER, 4 ) +
               LFill( SUB, 3 ) +
               LFill( NUM_DOC_INI, 12 ) +
               LFill( NUM_DOC_FIN, 12 ) +
               LFill( NUM_AUT, 60 ));
        end;
        WriteRegistro1710( Reg1001.Registro1700.Items[intFor] );

        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1700Count := FRegistro1700Count + Reg1001.Registro1700.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1710(Reg1700: TRegistro1700) ;
var
  intFor: integer;
begin
  if Assigned( Reg1700.Registro1710 ) then
  begin
     for intFor := 0 to Reg1700.Registro1710.Count - 1 do
     begin
        with Reg1700.Registro1710.Items[intFor] do
        begin
          Check(StrIsNumber(Trim(NUM_DOC_INI)), '(1-1710) Documento Fiscal Cancelado: Numeração incorreta "%s" para Documento Inicial', [NUM_DOC_INI]);
          Check(StrIsNumber(Trim(NUM_DOC_FIN)), '(1-1710) Documento Fiscal Cancelado: Numeração incorreta "%s" para Documento Final', [NUM_DOC_FIN]);

          Add( LFill('1710') +
               LFill( NUM_DOC_INI, 12) +
               LFill( NUM_DOC_FIN, 12) ) ;
        end;
        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1710Count := FRegistro1710Count + Reg1700.Registro1710.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1800(Reg1001: TRegistro1001) ;
var
  intFor: integer;
begin
  if Assigned( Reg1001.Registro1800 ) then
  begin
     for intFor := 0 to Reg1001.Registro1800.Count - 1 do
     begin
        with Reg1001.Registro1800.Items[intFor] do
        begin
          Add( LFill('1800') +
               LFill( VL_CARGA, 0, 2, True ) +
               LFill( VL_PASS, 0, 2, True ) +
               LFill( VL_FAT, 0, 2, True ) +
               LFill( IND_RAT, 6, 2, True ) +
               LFill( VL_ICMS_ANT, 0, 2, True ) +
               LFill( VL_BC_ICMS, 0, 2, True ) +
               LFill( VL_ICMS_APUR, 0, 2, True ) +
               LFill( VL_BC_ICMS_APUR, 0, 2, True ) +
               LFill( VL_DIF, 0, 2, True ) ) ;
        end;
        Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro1800Count := FRegistro1800Count + Reg1001.Registro1800.Count;
  end;
end;

procedure TBloco_1.WriteRegistro1990 ;
begin
  if Assigned(Registro1990) then
  begin
     with Registro1990 do
     begin
       QTD_LIN_1 := QTD_LIN_1 + 1;
       ///
       Add( LFill('1990') +
            LFill(QTD_LIN_1,0) ) ;
     end;
  end;
end;

end.
