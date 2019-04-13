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

unit ACBrSpedContabil;

interface

uses
  SysUtils, Classes, DateUtils,
  {$IFDEF FPC}
    LResources,
  {$ENDIF}
  ACBrSped, ACBrTXTClass,
  ACBrECDBloco_0_Class, ACBrECDBloco_9_Class, ACBrECDBloco_I_Class,
  ACBrECDBloco_J_Class;

const
   CACBrSpedContabil_Versao = '0.04a' ;

type
  TACBrSPEDPrected = class(TACBrSPED);

  /// ACBrSpedContabil - Sitema Publico de Escrituração Digital Contabil

  { TACBrSPEDContabil }

  TACBrSPEDContabil = class(TComponent)
  private
    FACBrTXT: TACBrTXTClass;
    FOnError: TErrorEvent;

    FDT_INI: TDateTime;           /// Data inicial das informações contidas no arquivo
    FDT_FIN: TDateTime;           /// Data final das informações contidas no arquivo

    FPath: AnsiString;            /// Path do arquivo a ser gerado
    FDelimitador: AnsiString;     /// Caracter delimitador de campos
    FTrimString: boolean;         /// Retorna a string sem espaços em branco iniciais e finais
    FCurMascara: AnsiString;      /// Mascara para valores tipo currency

    FBloco_0: TBloco_0;
    FBloco_9: TBloco_9;
    FBloco_I: TBloco_I;
    FBloco_J: TBloco_J;

    function GetAbout: AnsiString;
    function GetDelimitador: AnsiString;
    function GetTrimString: boolean;
    function GetCurMascara: AnsiString;
    function GetDT_FIN: TDateTime;
    function GetDT_INI: TDateTime;
    procedure SetAbout(const Value: AnsiString);
    procedure SetDelimitador(const Value: AnsiString);
    procedure SetTrimString(const Value: boolean);
    procedure SetCurMascara(const Value: AnsiString);
    procedure SetDT_FIN(const Value: TDateTime);
    procedure SetDT_INI(const Value: TDateTime);

    function GetOnError: TErrorEvent; /// Método do evento OnError
    procedure SetOnError(const Value: TErrorEvent); /// Método SetError

    procedure LimpaRegistros;
    procedure TotalizaTermos(AStringList : TStringList);
  protected
    /// BLOCO 0
    function WriteRegistro0000: AnsiString;
    function WriteRegistro0001: AnsiString;
    function WriteRegistro0007: AnsiString;
    function WriteRegistro0020: AnsiString;
    function WriteRegistro0150: AnsiString;
    function WriteRegistro0180: AnsiString;
    function WriteRegistro0990: AnsiString;
    /// BLOCO I
    function WriteRegistroI001: AnsiString;
    function WriteRegistroI010: AnsiString;
    function WriteRegistroI012: AnsiString;
    function WriteRegistroI015: AnsiString;
    function WriteRegistroI020: AnsiString;
    function WriteRegistroI030: AnsiString;
    function WriteRegistroI050: AnsiString;
    function WriteRegistroI075: AnsiString;
    function WriteRegistroI100: AnsiString;
    function WriteRegistroI150: AnsiString;
    function WriteRegistroI200: AnsiString;
    function WriteRegistroI300: AnsiString;
    function WriteRegistroI350: AnsiString;
    function WriteRegistroI500: AnsiString;
    function WriteRegistroI510: AnsiString;
    function WriteRegistroI550: AnsiString;

    function WriteRegistroI990: AnsiString;
    /// BLOCO J
    function WriteRegistroJ001: AnsiString;
    function WriteRegistroJ005: AnsiString;
    function WriteRegistroJ800: AnsiString;
    function WriteRegistroJ900: AnsiString;
    function WriteRegistroJ930: AnsiString;
    function WriteRegistroJ990: AnsiString;
    /// BLOCO 9
    function WriteRegistro9001: AnsiString;
    function WriteRegistro9900: AnsiString;
    function WriteRegistro9990: AnsiString;
    function WriteRegistro9999: AnsiString;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

    function SaveFileTXT(Arquivo: AnsiString): Boolean; /// Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveStringList(AStringList: TStringList): Boolean; /// Método que escreve o arquivo texto em um AnsiStringList

    property DT_INI: TDateTime read GetDT_INI write SetDT_INI;
    property DT_FIN: TDateTime read GetDT_FIN write SetDT_FIN;
    //
    property Bloco_0: TBloco_0 read FBloco_0 write FBloco_0;
    property Bloco_9: TBloco_9 read FBloco_9 write FBloco_9;
    property Bloco_I: TBloco_I read FBloco_I write FBloco_I;
    property Bloco_J: TBloco_J read FBloco_J write FBloco_J;
  published
    property About: AnsiString read GetAbout write SetAbout stored False ;
    property Path: AnsiString read FPath write FPath;
    ///
    property Delimitador: AnsiString read GetDelimitador write SetDelimitador;
    property TrimString: boolean read GetTrimString write SetTrimString;
    property CurMascara: AnsiString read GetCurMascara write SetCurMascara;

    property OnError: TErrorEvent  read GetOnError write SetOnError;
  end;

procedure Register;

implementation

Uses ACBrUtil ;

{$IFNDEF FPC}
 {$R ACBr_SPEDContabil.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrSPEDContabil]);
end;

(* TACBrSPEDContabil *)

constructor TACBrSPEDContabil.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FACBrTXT := TACBrTXTClass.Create;

  FBloco_0 := TBloco_0.Create;
  FBloco_I := TBloco_I.Create;
  FBloco_J := TBloco_J.Create;
  FBloco_9 := TBloco_9.Create;

  FPath := ExtractFilePath( ParamStr(0) );
  FDelimitador := '|';
  FCurMascara  := '#0.00';
  FTrimString  := True;
end;

destructor TACBrSPEDContabil.Destroy;
begin
  FACBrTXT.Free;

  FBloco_0.Free;
  FBloco_I.Free;
  FBloco_J.Free;
  FBloco_9.Free;
  inherited;
end;

procedure TACBrSPEDContabil.LimpaRegistros;
begin
  FBloco_0.LimpaRegistros;
  FBloco_I.LimpaRegistros;
  FBloco_J.LimpaRegistros;
  FBloco_9.LimpaRegistros;
end;

function TACBrSPEDContabil.GetDelimitador: AnsiString;
begin
   Result := FDelimitador;
end;

procedure TACBrSPEDContabil.SetDelimitador(const Value: AnsiString);
begin
  FDelimitador := Value;
  //
  FBloco_0.Delimitador := Value;
  FBloco_I.Delimitador := Value;
  FBloco_J.Delimitador := Value;
  FBloco_9.Delimitador := Value;
end;

function TACBrSPEDContabil.GetCurMascara: AnsiString;
begin
   Result := FCurMascara;
end;

procedure TACBrSPEDContabil.SetCurMascara(const Value: AnsiString);
begin
  FCurMascara := Value;
  //
  FBloco_0.CurMascara := Value;
  FBloco_I.CurMascara := Value;
  FBloco_J.CurMascara := Value;
  FBloco_9.CurMascara := Value;
end;

function TACBrSPEDContabil.GetTrimString: boolean;
begin
   Result := FTrimString;
end;

procedure TACBrSPEDContabil.SetTrimString(const Value: boolean);
begin
  FTrimString := Value;
  //
  FBloco_0.TrimString := Value;
  FBloco_I.TrimString := Value;
  FBloco_J.TrimString := Value;
  FBloco_9.TrimString := Value;
end;

function TACBrSPEDContabil.GetDT_INI: TDateTime;
begin
   Result := FDT_INI;
end;

procedure TACBrSPEDContabil.SetDT_INI(const Value: TDateTime);
begin
  FDT_INI := Value;
  //
  FBloco_0.DT_INI := Value;
  FBloco_I.DT_INI := Value;
  FBloco_J.DT_INI := Value;
  FBloco_9.DT_INI := Value;
  //
  if Assigned(FBloco_0) then
  begin
     FBloco_0.Registro0000.DT_INI := Value;
  end;
end;

function TACBrSPEDContabil.GetDT_FIN: TDateTime;
begin
   Result := FDT_FIN;
end;

procedure TACBrSPEDContabil.SetDT_FIN(const Value: TDateTime);
begin
  FDT_FIN := Value;
  //
  FBloco_0.DT_FIN := Value;
  FBloco_I.DT_FIN := Value;
  FBloco_J.DT_FIN := Value;
  FBloco_9.DT_FIN := Value;
  //
  if Assigned(FBloco_0) then
  begin
     FBloco_0.Registro0000.DT_FIN := Value;
  end;
end;

function TACBrSPEDContabil.GetOnError: TErrorEvent;
begin
   Result := FOnError;
end;

procedure TACBrSPEDContabil.SetOnError(const Value: TErrorEvent);
begin
  FOnError := Value;

  FBloco_0.OnError := Value;
  FBloco_I.OnError := Value;
  FBloco_J.OnError := Value;
  FBloco_9.OnError := Value;
end;

function TACBrSPEDContabil.SaveFileTXT(Arquivo: AnsiString): Boolean;
var
   SL : TStringList ;
begin
  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
     raise Exception.Create( ACBrStr('Caminho ou nome do arquivo não informado!'));

  SL := TStringList.Create;
  try
     SaveStringList( SL );
     SL.SaveToFile( fPath + Arquivo );
     Result := True ;
  finally
     SL.Free;
  end;
end;

function TACBrSPEDContabil.SaveStringList(AStringList: TStringList): Boolean;
var
  intFor: integer;
begin
  Result := True;

//  Check(DT_INI > 0,        'CHECAGEM INICIAL: Informe a data inicial das informações contidas no arquivo!');
//  Check(DT_FIN > 0,        'CHECAGEM INICIAL: Informe a data final das informações contidas no arquivo!');
//  Check(DayOf(DT_INI) = 1, 'CHECAGEM INICIAL: A data inicial deve corresponder ao primeiro dia do mês informado!');
//  Check(DT_FIN >= DT_INI,  'CHECAGEM INICIAL: A data final deve se maior que a data inicial!');
//  Check(DT_FIN <= Date,    'CHECAGEM INICIAL: A data final "%s" não pode ser superior a data atual "%s"!', [DateToStr(DT_FIN), DateToStr(Date)]);
//  Check(DateOf(EndOfTheMonth(DT_FIN)) = DateOf(DT_FIN), 'CHECAGEM INICIAL: A data final deve corresponder ao último dia do mês informado!');

  /// Preparação para totalizações de registros.
  Bloco_0.Registro0990.QTD_LIN_0 := 0;
  Bloco_I.RegistroI990.QTD_LIN_I := 0;
  Bloco_J.RegistroJ990.QTD_LIN_J := 0;
  Bloco_9.Registro9990.QTD_LIN_9 := 0;
  Bloco_9.Registro9999.QTD_LIN   := 0;
  ///
  for intFor := 0 to Bloco_9.Registro9900.Count - 1 do
  begin
     Bloco_9.Registro9900.Items[intFor].Free;
  end;
  Bloco_9.Registro9900.Clear;

  try
    /// BLOCO 0
    AStringList.Add(Trim(WriteRegistro0000));
    AStringList.Add(Trim(WriteRegistro0001));
    if Bloco_0.Registro0007.Count > 0 then AStringList.Add(Trim(WriteRegistro0007));
    if Bloco_0.Registro0020.Count > 0 then AStringList.Add(Trim(WriteRegistro0020));
    if Bloco_0.Registro0150.Count > 0 then AStringList.Add(Trim(WriteRegistro0150));
    if Bloco_0.Registro0180.Count > 0 then AStringList.Add(Trim(WriteRegistro0180));
    AStringList.Add(Trim(WriteRegistro0990));

    /// BLOCO I
    AStringList.Add(Trim(WriteRegistroI001));
    AStringList.Add(Trim(WriteRegistroI010));
    if Bloco_I.RegistroI012.Count > 0 then AStringList.Add(Trim(WriteRegistroI012));
    if Bloco_I.RegistroI015.Count > 0 then AStringList.Add(Trim(WriteRegistroI015));
    if Bloco_I.RegistroI020.Count > 0 then AStringList.Add(Trim(WriteRegistroI020));
    AStringList.Add(Trim(WriteRegistroI030));
    if Bloco_I.RegistroI050.Count > 0 then AStringList.Add(Trim(WriteRegistroI050));
    if Bloco_I.RegistroI075.Count > 0 then AStringList.Add(Trim(WriteRegistroI075));
    if Bloco_I.RegistroI100.Count > 0 then AStringList.Add(Trim(WriteRegistroI100));
    if Bloco_I.RegistroI150.Count > 0 then AStringList.Add(Trim(WriteRegistroI150));
    if Bloco_I.RegistroI200.Count > 0 then AStringList.Add(Trim(WriteRegistroI200));
    if Bloco_I.RegistroI300.Count > 0 then AStringList.Add(Trim(WriteRegistroI300));
    if Bloco_I.RegistroI350.Count > 0 then AStringList.Add(Trim(WriteRegistroI350));
    if Bloco_I.RegistroI500.Count > 0 then AStringList.Add(Trim(WriteRegistroI500));
    if Bloco_I.RegistroI510.Count > 0 then AStringList.Add(Trim(WriteRegistroI510));
    if Bloco_I.RegistroI550.Count > 0 then AStringList.Add(Trim(WriteRegistroI550));

    AStringList.Add(Trim(WriteRegistroI990));

   /// BLOCO J
    AStringList.Add(Trim(WriteRegistroJ001));
    if Bloco_J.RegistroJ005.Count > 0 then AStringList.Add(Trim(WriteRegistroJ005));
    if Bloco_J.RegistroJ800.Count > 0 then AStringList.Add(Trim(WriteRegistroJ800));
    AStringList.Add(Trim(WriteRegistroJ900));
    if Bloco_J.RegistroJ930.Count > 0 then AStringList.Add(Trim(WriteRegistroJ930));
    AStringList.Add(Trim(WriteRegistroJ990));

    /// BLOCO 9
    AStringList.Add(Trim(WriteRegistro9001));
    AStringList.Add(Trim(WriteRegistro9900));
    AStringList.Add(Trim(WriteRegistro9990));
    AStringList.Add(Trim(WriteRegistro9999));

    /// Atualiza os totais de registros nos termos de abertura e fechamento
    /// I030 e J900
    TotalizaTermos( AStringList );

  finally
    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  end;
end;

function TACBrSPEDContabil.WriteRegistro0000: AnsiString;
begin
   Result := Bloco_0.WriteRegistro0000;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0000';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistro0001: AnsiString;
begin
   Result := Bloco_0.WriteRegistro0001;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0001';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistro0007: AnsiString;
begin
   Result := Bloco_0.WriteRegistro0007;

   if Bloco_0.Registro0007.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := '0007';
         QTD_REG_BLC := Bloco_0.Registro0007.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistro0020: AnsiString;
begin
   Result := Bloco_0.WriteRegistro0020;

   if Bloco_0.Registro0020.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := '0020';
         QTD_REG_BLC := Bloco_0.Registro0020.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistro0150: AnsiString;
begin
   Result := Bloco_0.WriteRegistro0150;

   if Bloco_0.Registro0150.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := '0150';
         QTD_REG_BLC := Bloco_0.Registro0150.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistro0180: AnsiString;
begin
   Result := Bloco_0.WriteRegistro0180;

   if Bloco_0.Registro0180.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := '0180';
         QTD_REG_BLC := Bloco_0.Registro0180.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistro0990: AnsiString;
begin
   Result := Bloco_0.WriteRegistro0990;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0990';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI001: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI001;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I001';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI010: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI010;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I010';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI012: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI012;

   if Bloco_I.RegistroI012.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I012';
         QTD_REG_BLC := Bloco_I.RegistroI012.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI015: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI015;

   if Bloco_I.RegistroI015.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I015';
         QTD_REG_BLC := Bloco_I.RegistroI015.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI020: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI020;

   if Bloco_I.RegistroI020.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I020';
         QTD_REG_BLC := Bloco_I.RegistroI020.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI030: AnsiString;
begin
   // Total de linhas do arquivo
   Bloco_I.RegistroI030.QTD_LIN := Bloco_0.Registro0990.QTD_LIN_0 +
                                   Bloco_I.RegistroI990.QTD_LIN_I +
                                   Bloco_J.RegistroJ990.QTD_LIN_J +
                                   Bloco_9.Registro9990.QTD_LIN_9;
   Result := Bloco_I.WriteRegistroI030;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I030';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI050: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI050;

   if Bloco_I.RegistroI050.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I050';
         QTD_REG_BLC := Bloco_I.RegistroI050.Count;
      end;
   end;
   if Bloco_I.RegistroI051Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I051';
         QTD_REG_BLC := Bloco_I.RegistroI051Count;
      end;
   end;
   if Bloco_I.RegistroI052Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I052';
         QTD_REG_BLC := Bloco_I.RegistroI052Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI075: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI075;

   if Bloco_I.RegistroI075.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I075';
         QTD_REG_BLC := Bloco_I.RegistroI075.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI100: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI100;

   if Bloco_I.RegistroI100.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I100';
         QTD_REG_BLC := Bloco_I.RegistroI100.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI150: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI150;

   if Bloco_I.RegistroI150.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I150';
         QTD_REG_BLC := Bloco_I.RegistroI150.Count;
      end;
   end;
   if Bloco_I.RegistroI151Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I151';
         QTD_REG_BLC := Bloco_I.RegistroI151Count;
      end;
   end;
   if Bloco_I.RegistroI155Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I155';
         QTD_REG_BLC := Bloco_I.RegistroI155Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI200: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI200;

   if Bloco_I.RegistroI200.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I200';
         QTD_REG_BLC := Bloco_I.RegistroI200.Count;
      end;
   end;
   if Bloco_I.RegistroI250Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I250';
         QTD_REG_BLC := Bloco_I.RegistroI250Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI300: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI300;

   if Bloco_I.RegistroI300.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I300';
         QTD_REG_BLC := Bloco_I.RegistroI300.Count;
      end;
   end;
   if Bloco_I.RegistroI310Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I310';
         QTD_REG_BLC := Bloco_I.RegistroI310Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI350: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI350;

   if Bloco_I.RegistroI350.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I350';
         QTD_REG_BLC := Bloco_I.RegistroI350.Count;
      end;
   end;
   if Bloco_I.RegistroI355Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I355';
         QTD_REG_BLC := Bloco_I.RegistroI355Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI500: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI500;

   if Bloco_I.RegistroI500.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I500';
         QTD_REG_BLC := Bloco_I.RegistroI500.Count;
      end;
   end;
end;


function TACBrSPEDContabil.WriteRegistroI510: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI510;

   if Bloco_I.RegistroI510.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I510';
         QTD_REG_BLC := Bloco_I.RegistroI510.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI550: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI550;

   if Bloco_I.RegistroI550.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I550';
         QTD_REG_BLC := Bloco_I.RegistroI550.Count;
      end;
   end;
   if Bloco_I.RegistroI555Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'I555';
         QTD_REG_BLC := Bloco_I.RegistroI555Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI990: AnsiString;
begin
   Result := Bloco_I.WriteRegistroI990;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I990';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistroJ001: AnsiString;
begin
   Result := Bloco_J.WriteRegistroJ001;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J001';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistroJ005: AnsiString;
begin
   Result := Bloco_J.WriteRegistroJ005;

   if Bloco_J.RegistroJ005.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'J005';
         QTD_REG_BLC := Bloco_J.RegistroJ005.Count;
      end;
   end;
   if Bloco_J.RegistroJ100Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'J100';
         QTD_REG_BLC := Bloco_J.RegistroJ100Count;
      end;
   end;
   if Bloco_J.RegistroJ150Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'J150';
         QTD_REG_BLC := Bloco_J.RegistroJ150Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroJ800: AnsiString;
begin
   Result := Bloco_J.WriteRegistroJ800;

   if Bloco_J.RegistroJ800.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'J800';
         QTD_REG_BLC := Bloco_J.RegistroJ800.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroJ900: AnsiString;
begin
   Result := Bloco_J.WriteRegistroJ900;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J900';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistroJ930: AnsiString;
begin
   Result := Bloco_J.WriteRegistroJ930;

   if Bloco_J.RegistroJ930.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := 'J930';
         QTD_REG_BLC := Bloco_J.RegistroJ930.Count;
      end;
   end;
end;

function TACBrSPEDContabil.WriteRegistroJ990: AnsiString;
begin
   Result := Bloco_J.WriteRegistroJ990;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J990';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistro9001: AnsiString;
begin
   Result := Bloco_9.WriteRegistro9001;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '9001';
      QTD_REG_BLC := 1;
   end;
end;

function TACBrSPEDContabil.WriteRegistro9900: AnsiString;
begin
   with Bloco_9.Registro9900 do
   begin
      with New do
      begin
         REG_BLC := '9900';
         QTD_REG_BLC := Bloco_9.Registro9900.Count + 2;
      end;
      with New do
      begin
         REG_BLC := '9990';
         QTD_REG_BLC := 1;
      end;
      with New do
      begin
         REG_BLC := '9999';
         QTD_REG_BLC := 1;
      end;
   end;
   Result := Bloco_9.WriteRegistro9900;
end;

function TACBrSPEDContabil.WriteRegistro9990: AnsiString;
begin
   Result := Bloco_9.WriteRegistro9990;
end;

function TACBrSPEDContabil.WriteRegistro9999: AnsiString;
begin
   Bloco_9.Registro9999.QTD_LIN := Bloco_9.Registro9999.QTD_LIN + Bloco_0.Registro0990.QTD_LIN_0 +
                                                                  Bloco_I.RegistroI990.QTD_LIN_I +
                                                                  Bloco_J.RegistroJ990.QTD_LIN_J +
                                                                  Bloco_9.Registro9990.QTD_LIN_9;
   Result := Bloco_9.WriteRegistro9999;
end;

function TACBrSPEDContabil.GetAbout: AnsiString;
begin
   Result := 'ACBrSpedContabil Ver: ' + CACBrSpedContabil_Versao;
end;

procedure TACBrSPEDContabil.SetAbout(const Value: AnsiString);
begin
 {}
end;

procedure TACBrSPEDContabil.TotalizaTermos(AStringList : TStringList);
var
intLine: Integer;
begin
  with AStringList do
  begin
     for intLine := 0 to Count -1 do
     begin
        if Copy(Strings[intLine], 2, 4) = 'I030' then
        begin
           Strings[intLine] := StringReplace(Strings[intLine], '[*******]', FACBrTXT.LFill(Bloco_9.Registro9999.QTD_LIN, 9, false), []);
        end
        else
        if Copy(Strings[intLine], 2, 4) = 'J900' then
        begin
           Strings[intLine] := StringReplace(Strings[intLine], '[*******]', FACBrTXT.LFill(Bloco_9.Registro9999.QTD_LIN, 9, false), []);
           Break;
        end;
     end;
  end;
end;

{$ifdef FPC}
initialization
   {$I ACBrSpedContabil.lrs}
{$endif}

end.
