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

unit ACBrFContBloco_I_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrFContBloco_I;

type
  /// TBLOCO_I -
  TBLOCO_I = class(TACBrSPED)
  private
    FRegistroI001: TRegistroI001;      /// BLOCO I - RegistroI001
    FRegistroI050: TRegistroI050List;  /// BLOCO I - Lista de RegistroI050
    FRegistroI075: TRegistroI075List;  /// BLOCO I - Lista de RegistroI075
    FRegistroI100: TRegistroI100List;  /// BLOCO I - Lista de RegistroI100
    FRegistroI150: TRegistroI150List;  /// BLOCO I - Lista de RegistroI150
    FRegistroI200: TRegistroI200List;
    FRegistroI350: TRegistroI350List;  /// BLOCO I - Lista de RegistroI350
    FRegistroI990: TRegistroI990;      /// BLOCO I - FRegistroI990

    FRegistroI051Count: Integer;
    FRegistroI155Count: Integer;
    FRegistroI250Count: Integer;
    FRegistroI355Count: Integer;

    function WriteRegistroI051(RegI050: TRegistroI050): AnsiString;
    function WriteRegistroI155(RegI150: TRegistroI150): AnsiString;
    function WriteRegistroI250(RegI200: TRegistroI200): AnsiString;
    function WriteRegistroI355(RegI350: TRegistroI350): AnsiString;
  public
    constructor Create; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroI001: AnsiString;
    function WriteRegistroI050: AnsiString;
    function WriteRegistroI075: AnsiString;
    function WriteRegistroI100: AnsiString;
    function WriteRegistroI150: AnsiString;
    function WriteRegistroI200: AnsiString;
    function WriteRegistroI350: AnsiString;
    function WriteRegistroI990: AnsiString;

    property RegistroI001: TRegistroI001     read FRegistroI001 write FRegistroI001;
    property RegistroI050: TRegistroI050List read fRegistroI050 write fRegistroI050;
    property RegistroI075: TRegistroI075List read fRegistroI075 write fRegistroI075;
    property RegistroI100: TRegistroI100List read fRegistroI100 write fRegistroI100;
    property RegistroI150: TRegistroI150List read fRegistroI150 write fRegistroI150;
    property RegistroI200: TRegistroI200List read fRegistroI200 write fRegistroI200;
    property RegistroI350: TRegistroI350List read fRegistroI350 write fRegistroI350;
    property RegistroI990: TRegistroI990     read FRegistroI990 write FRegistroI990;

    property RegistroI051Count: Integer read FRegistroI051Count write FRegistroI051Count;
    property RegistroI155Count: Integer read FRegistroI155Count write FRegistroI155Count;
    property RegistroI250Count: Integer read FRegistroI250Count write FRegistroI250Count;
    property RegistroI355Count: Integer read FRegistroI355Count write FRegistroI355Count;
  end;

implementation

{ TBLOCO_I }

constructor TBLOCO_I.Create;
begin
  FRegistroI001 := TRegistroI001.Create;
  FRegistroI050 := TRegistroI050List.Create;
  FRegistroI075 := TRegistroI075List.Create;
  FRegistroI100 := TRegistroI100List.Create;
  FRegistroI150 := TRegistroI150List.Create;
  FRegistroI200 := TRegistroI200List.Create;
  FRegistroI350 := TRegistroI350List.Create;
  FRegistroI990 := TRegistroI990.Create;

  FRegistroI051Count := 0;
  FRegistroI155Count := 0;
  FRegistroI250Count := 0;
  FRegistroI355Count := 0;

  FRegistroI990.QTD_LIN_I := 0;
end;

destructor TBLOCO_I.Destroy;
begin
  FRegistroI001.Free;
  FRegistroI050.Free;
  FRegistroI075.Free;
  FRegistroI100.Free;
  FRegistroI150.Free;
  FRegistroI200.Free;
  FRegistroI350.Free;

  FRegistroI990.Free;
  inherited;
end;

procedure TBLOCO_I.LimpaRegistros;
begin
  FRegistroI050.Clear;
  FRegistroI075.Clear;
  FRegistroI100.Clear;
  FRegistroI150.Clear;
  FRegistroI200.Clear;
  FRegistroI350.Clear;

  FRegistroI990.QTD_LIN_I := 0;
end;

function TBLOCO_I.WriteRegistroI001: AnsiString;
begin
  Result := '';

  if Assigned(FRegistroI001) then
  begin
     with FRegistroI001 do
     begin
       Check(((IND_DAD = 0) or (IND_DAD = 1)), '(I-I001) Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('I001') +
                 LFill(IND_DAD, 1) +
                 Delimitador +
                 #13#10;
       ///
       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
  end;
end;

function TBloco_I.WriteRegistroI050: AnsiString;
var
intFor: integer;
strRegistroI050: AnsiString;
begin
  strRegistroI050 := '';

  if Assigned(FRegistroI050) then
  begin
     for intFor := 0 to FRegistroI050.Count - 1 do
     begin
        with FRegistroI050.Items[intFor] do
        begin
           ///
           strRegistroI050 :=  strRegistroI050 + LFill('I050') +
                                                 LFill(DT_ALT) +
                                                 LFill(COD_NAT, 2) +
                                                 LFill(IND_CTA, 1) +
                                                 LFill(NIVEL) +
                                                 LFill(COD_CTA) +
                                                 LFill(COD_CTA_SUP) +
                                                 LFill(CTA) +
                                                 Delimitador +
                                                 #13#10;
        end;
        // Registros Filhos
        strRegistroI050 := strRegistroI050 +
                           WriteRegistroI051(FRegistroI050.Items[intFor] );

       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI050;
end;

function TBloco_I.WriteRegistroI051(RegI050: TRegistroI050): AnsiString;
var
intFor: integer;
strRegistroI051: AnsiString;
begin
  strRegistroI051 := '';

  if Assigned(RegI050.RegistroI051) then
  begin
     for intFor := 0 to RegI050.RegistroI051.Count - 1 do
     begin
        with RegI050.RegistroI051.Items[intFor] do
        begin
           ///
           strRegistroI051 :=  strRegistroI051 + LFill('I051') +
                                                 LFill(COD_ENT_REF, 2) +
                                                 LFill(COD_CCUS) +
                                                 LFill(COD_CTA_REF) +
                                                 Delimitador +
                                                 #13#10;
        end;
       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
     FRegistroI051Count := FRegistroI051Count + RegI050.RegistroI051.Count;
  end;
  Result := strRegistroI051;
end;

function TBloco_I.WriteRegistroI075: AnsiString;
var
intFor: integer;
strRegistroI075: AnsiString;
begin
  strRegistroI075 := '';

  if Assigned(RegistroI075) then
  begin
     for intFor := 0 to RegistroI075.Count - 1 do
     begin
        with RegistroI075.Items[intFor] do
        begin
           ///
           strRegistroI075 :=  strRegistroI075 + LFill('I075') +
                                                 LFill(COD_HIST) +
                                                 LFill(DESCR_HIST) +
                                                 Delimitador +
                                                 #13#10;
        end;
       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI075;
end;

function TBloco_I.WriteRegistroI100: AnsiString;
var
intFor: integer;
strRegistroI100: AnsiString;
begin
  strRegistroI100 := '';

  if Assigned(RegistroI100) then
  begin
     for intFor := 0 to RegistroI100.Count - 1 do
     begin
        with RegistroI100.Items[intFor] do
        begin
           ///
           strRegistroI100 :=  strRegistroI100 + LFill('I100') +
                                                 LFill(DT_ALT) +
                                                 LFill(COD_CCUS) +
                                                 LFill(CCUS) +
                                                 Delimitador +
                                                 #13#10;
        end;
       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI100;
end;

function TBloco_I.WriteRegistroI150: AnsiString;
var
intFor: integer;
strRegistroI150: AnsiString;
begin
  strRegistroI150 := '';

  if Assigned(RegistroI150) then
  begin
     for intFor := 0 to RegistroI150.Count - 1 do
     begin
        with RegistroI150.Items[intFor] do
        begin
           ///
           strRegistroI150 :=  strRegistroI150 + LFill('I150') +
                                                 LFill(DT_INI) +
                                                 LFill(DT_FIN) +
                                                 Delimitador +
                                                 #13#10;
        end;
        // Registro Filho
        strRegistroI150 := strRegistroI150 +
                           WriteRegistroI155(RegistroI150.Items[intFor] );

       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI150;
end;

function TBloco_I.WriteRegistroI155(RegI150: TRegistroI150): AnsiString;
var
intFor: integer;
strRegistroI155: AnsiString;
begin
  strRegistroI155 := '';

  if Assigned(RegI150.RegistroI155) then
  begin
     for intFor := 0 to RegI150.RegistroI155.Count - 1 do
     begin
        with RegI150.RegistroI155.Items[intFor] do
        begin
           Check(((IND_DC_INI = 'D') or (IND_DC_INI = 'C') or (IND_DC_INI = '')), '(I-I155) No Indicador da situação do saldo inicial, deve ser informado: D ou C ou nulo!');
           Check(((IND_DC_FIN = 'D') or (IND_DC_FIN = 'C') or (IND_DC_FIN = '')), '(I-I155) No Indicador da situação do saldo inicial, deve ser informado: D ou C ou nulo!');
           ///
           strRegistroI155 :=  strRegistroI155 + LFill('I155') +
                                                 LFill(COD_CTA) +
                                                 LFill(COD_CCUS) +
                                                 LFill(VL_SLD_INI, 19, 2) +
                                                 LFill(IND_DC_INI, 0) +
                                                 LFill(VL_DEB, 19, 2) +
                                                 LFill(VL_CRED, 19, 2) +
                                                 LFill(VL_SLD_FIN, 19, 2) +
                                                 LFill(IND_DC_FIN, 0) +
                                                 Delimitador +
                                                 #13#10;
        end;
       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
     FRegistroI155Count := FRegistroI155Count + RegI150.RegistroI155.Count;
  end;
  Result := strRegistroI155;
end;

function TBloco_I.WriteRegistroI200: AnsiString;
var
intFor: integer;
strRegistroI200: AnsiString;
begin
  strRegistroI200 := '';

  if Assigned(FRegistroI200) then
  begin
     for intFor := 0 to FRegistroI200.Count - 1 do
     begin
        with FRegistroI200.Items[intFor] do
        begin
           ///
           strRegistroI200 :=  strRegistroI200 + LFill('I200') +
                                                 LFill(NUM_LCTO) +
                                                 LFill(DT_LCTO) +
                                                 LFill(VL_LCTO, 19, 2) +
                                                 LFill(IND_LCTO) +
                                                 Delimitador +
                                                 #13#10;
        end;
        // Registro Filho
        strRegistroI200 := strRegistroI200 +
                           WriteRegistroI250(FRegistroI200.Items[intFor] );

       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI200;
end;

function TBloco_I.WriteRegistroI250(RegI200: TRegistroI200): AnsiString;
var
intFor: integer;
strRegistroI250: AnsiString;
begin
  strRegistroI250 := '';

  if Assigned(RegI200.RegistroI250) then
  begin
     for intFor := 0 to RegI200.RegistroI250.Count - 1 do
     begin
        with RegI200.RegistroI250.Items[intFor] do
        begin
           /// Checagem das informações que formarão o registro
           Check(((IND_DC = 'D') or (IND_DC = 'C')), '(I-I250) Indicador da natureza da partida, deve ser informado: D ou C!');
           ///
           strRegistroI250 :=  strRegistroI250 + LFill('I250') +
                                                 LFill(COD_CTA) +
                                                 LFill(COD_CCUS) +
                                                 LFill(VL_DC, 19, 2) +
                                                 LFill(IND_DC) +
                                                 LFill(NUM_ARQ) +
                                                 LFill(COD_HIST_PAD) +
                                                 LFill(HIST) +
                                                 LFill(COD_PART) +
                                                 Delimitador +
                                                 #13#10;
        end;
       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
     FRegistroI250Count := FRegistroI250Count + RegI200.RegistroI250.Count;
  end;
  Result := strRegistroI250;
end;

function TBloco_I.WriteRegistroI350: AnsiString;
var
intFor: integer;
strRegistroI350: AnsiString;
begin
  strRegistroI350 := '';

  if Assigned(FRegistroI350) then
  begin
     for intFor := 0 to FRegistroI350.Count - 1 do
     begin
        with FRegistroI350.Items[intFor] do
        begin
           ///
           strRegistroI350 :=  strRegistroI350 + LFill('I350') +
                                                 LFill(DT_RES) +
                                                 Delimitador +
                                                 #13#10;
        end;
        // Registro Filho
        strRegistroI350 := strRegistroI350 +
                           WriteRegistroI355(FRegistroI350.Items[intFor] );

       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI350;
end;

function TBloco_I.WriteRegistroI355(RegI350: TRegistroI350): AnsiString;
var
intFor: integer;
strRegistroI355: AnsiString;
begin
  strRegistroI355 := '';

  if Assigned(RegI350.RegistroI355) then
  begin
     for intFor := 0 to RegI350.RegistroI355.Count - 1 do
     begin
        with RegI350.RegistroI355.Items[intFor] do
        begin
           /// Checagem das informações que formarão o registro
           Check(((IND_DC = 'D') or (IND_DC = 'C') or (IND_DC = '')), '(I-I355) No Indicador da situação do saldo inicial, deve ser informado: D ou C ou nulo!');
           Check(((IND_DC = 'D') or (IND_DC = 'C') or (IND_DC = '')), '(I-I355) No Indicador da situação do saldo inicial, deve ser informado: D ou C ou nulo!');
           ///
           strRegistroI355 :=  strRegistroI355 + LFill('I355') +
                                                 LFill(COD_CTA) +
                                                 LFill(COD_CCUS) +
                                                 LFill(VL_CTA, 19, 2) +
                                                 LFill(IND_DC, 0) +
                                                 Delimitador +
                                                 #13#10;
        end;
       FRegistroI990.QTD_LIN_I := FRegistroI990.QTD_LIN_I + 1;
     end;
     FRegistroI355Count := FRegistroI355Count + RegI350.RegistroI355.Count;
  end;
  Result := strRegistroI355;
end;

function TBLOCO_I.WriteRegistroI990: AnsiString;
begin
  Result := '';

  if Assigned(FRegistroI990) then
  begin
     with FRegistroI990 do
     begin
       QTD_LIN_I := QTD_LIN_I + 1;
       ///
       Result := LFill('I990') +
                 LFill(QTD_LIN_I, 0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
