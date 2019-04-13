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
|* 29/11/2010: Gutierres Santana da Costa
|*  - Implementado Registro Tipo C "Controle de Abastecimento e Encerrante"
*******************************************************************************}

{$I ACBr.inc}

unit ACBrPAF;

interface

uses
   SysUtils, Classes, DateUtils,
   {$IFDEF FPC}
      LResources,
   {$ENDIF}
   {$IFDEF CLX}QForms, {$ELSE} Forms, {$ENDIF}
   ACBrTXTClass, ACBrUtil, ACBrEAD, ACBrAAC,
   ACBrPAF_D, ACBrPAF_D_Class,
   ACBrPAF_E, ACBrPAF_E_Class,
   ACBrPAF_P, ACBrPAF_P_Class,
   ACBrPAF_R, ACBrPAF_R_Class,
   ACBrPAF_T, ACBrPAF_T_Class,
   ACBrPAF_C, ACBrPAF_C_Class,
   ACBrPAF_N, ACBrPAF_N_Class;

const
   CACBrPAF_Versao = '0.09' ;

type

  // DECLARANDO O COMPONENTE - PAF-ECF:

  { TACBrPAF }

  TACBrPAF = class(TComponent)
  private
    FOnError: TErrorEvent;

    fsEADInterno : TACBrEAD ;
    fsEAD : TACBrEAD ;       /// Componente usado para AssinarArquivo com assinatura EAD.
    fsAAC : TACBrAAC ;       /// Componente usado para manter o Arq.Auxiliar Criptografado

    FPath: String;            // Path do arquivo a ser gerado
    FDelimitador: String;     // Caracter delimitador de campos
    FTrimString: boolean;     // Retorna a string sem espaços em branco iniciais e finais
    FCurMascara: String;      // Mascara para valores tipo currency
    FAssinar : Boolean;       // Define se o arquivo gerado deve ser assinado

    FPAF_D: TPAF_D;
    FPAF_E: TPAF_E;
    FPAF_P: TPAF_P;
    FPAF_R: TPAF_R;
    FPAF_T: TPAF_T;
    FPAF_C: TPAF_C;
    FPAF_N: TPAF_N;
    fsOnPAFCalcEAD: TACBrEADCalc;
    fsOnPAFGetKeyRSA : TACBrEADGetChave ;

    function GetAbout: String;
    function GetDelimitador: String;
    function GetTrimString: boolean;
    function GetCurMascara: String;
    procedure SetDelimitador(const Value: String);
    procedure SetTrimString(const Value: boolean);
    procedure SetCurMascara(const Value: String);

    function GetOnError: TErrorEvent; // Método do evento OnError
    procedure SetOnError(const Value: TErrorEvent); // Método SetError

    procedure SetEAD(const AValue: TACBrEAD);
    procedure SetAAC(const AValue: TACBrAAC);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override; // Create
    destructor Destroy; override; // Destroy

    function SaveFileTXT_C(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_D(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_E(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_N(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_P(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_R(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_T(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro

    property PAF_C: TPAF_C read FPAF_C write FPAF_C;
    property PAF_D: TPAF_D read FPAF_D write FPAF_D;
    property PAF_E: TPAF_E read FPAF_E write FPAF_E;
    property PAF_N: TPAF_N read FPAF_N write FPAF_N;
    property PAF_P: TPAF_P read FPAF_P write FPAF_P;
    property PAF_R: TPAF_R read FPAF_R write FPAF_R;
    property PAF_T: TPAF_T read FPAF_T write FPAF_T;

    Function GetACBrEAD : TACBrEAD ;
    function AssinaArquivoComEAD(Arquivo: String): Boolean;
  published
    property About : String   read GetAbout stored False ;
    property Path  : String   read FPath write FPath ;
    property EAD   : TACBrEAD read fsEAD write SetEAD ;
    property AAC   : TACBrAAC read fsAAC write SetAAC ;

    property Delimitador: String read GetDelimitador write SetDelimitador;
    property TrimString: Boolean read GetTrimString write SetTrimString
       default True ;
    property CurMascara: String read GetCurMascara write SetCurMascara;
    property AssinarArquivo : Boolean read FAssinar write FAssinar
      default True ;

    property OnError: TErrorEvent  read GetOnError write SetOnError;
    property OnPAFCalcEAD: TACBrEADCalc read fsOnPAFCalcEAD
       write fsOnPAFCalcEAD;
    property OnPAFGetKeyRSA: TACBrEADGetChave read fsOnPAFGetKeyRSA
       write fsOnPAFGetKeyRSA;
  end;

  procedure Register;

implementation

Uses
  {$IFDEF COMPILER6_UP} StrUtils {$ELSE} ACBrD5 {$ENDIF} ;

{$IFNDEF FPC}
 {$R ACBrPAF.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrPAF]);
end;

constructor TACBrPAF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPAF_D := TPAF_D.Create;
  FPAF_E := TPAF_E.Create;
  FPAF_P := TPAF_P.Create;
  FPAF_R := TPAF_R.Create;
  FPAF_T := TPAF_T.Create;
  FPAF_C := TPAF_C.Create;
  FPAF_N := TPAF_N.Create( Self );
  // Define o delimitador com o padrão PAF
  SetDelimitador('');
  // Define a mascara dos campos numéricos com o padrão PAF
  SetCurMascara('');

  fsEADInterno     := nil;
  fsEAD            := nil;
  fsOnPAFGetKeyRSA := nil;
  fsOnPAFCalcEAD   := nil;

  FPath := ExtractFilePath( ParamStr(0) );
  FDelimitador := '';
  FCurMascara  := '';
  FTrimString  := True;
  FAssinar     := True;
end;

destructor TACBrPAF.Destroy;
begin
  FPAF_D.Free;
  FPAF_E.Free;
  FPAF_P.Free;
  FPAF_R.Free;
  FPAF_T.Free;
  FPAF_C.Free;
  FPAF_N.Free;

  if Assigned( fsEADInterno ) then
     FreeAndNil( fsEADInterno );

  inherited;
end;

function TACBrPAF.GetAbout: String;
begin
  Result := 'ACBrPAF Ver: ' + CACBrPAF_Versao;
end;

function TACBrPAF.GetDelimitador: String;
begin
  Result := FDelimitador;
end;

procedure TACBrPAF.SetDelimitador(const Value: String);
begin
  FDelimitador := Value;

  FPAF_D.Delimitador := Value;
  FPAF_E.Delimitador := Value;
  FPAF_P.Delimitador := Value;
  FPAF_R.Delimitador := Value;
  FPAF_T.Delimitador := Value;
  FPAF_C.Delimitador := Value;
  FPAF_N.Delimitador := Value;
end;

function TACBrPAF.GetCurMascara: String;
begin
  Result := FCurMascara;
end;

procedure TACBrPAF.SetCurMascara(const Value: String);
begin
  FCurMascara := Value;

  FPAF_C.CurMascara := Value;
  FPAF_D.CurMascara := Value;
  FPAF_E.CurMascara := Value;
  FPAF_N.CurMascara := Value;
  FPAF_P.CurMascara := Value;
  FPAF_R.CurMascara := Value;
  FPAF_T.CurMascara := Value;
end;

function TACBrPAF.GetTrimString: boolean;
begin
  Result := FTrimString;
end;

procedure TACBrPAF.SetTrimString(const Value: boolean);
begin
  FTrimString := Value;

  FPAF_C.TrimString := Value;
  FPAF_D.TrimString := Value;
  FPAF_E.TrimString := Value;
  FPAF_N.TrimString := Value;
  FPAF_P.TrimString := Value;
  FPAF_R.TrimString := Value;
  FPAF_T.TrimString := Value;
end;

function TACBrPAF.GetOnError: TErrorEvent;
begin
  Result := FOnError;
end;

procedure TACBrPAF.SetOnError(const Value: TErrorEvent);
begin
  FOnError := Value;

  FPAF_C.OnError := Value;
  FPAF_D.OnError := Value;
  FPAF_E.OnError := Value;
  FPAF_N.OnError := Value;
  FPAF_P.OnError := Value;
  FPAF_R.OnError := Value;
  FPAF_T.OnError := Value;
end;

procedure TACBrPAF.SetEAD(const AValue : TACBrEAD) ;
begin
  if AValue <> fsEAD then
  begin
     if Assigned(fsEAD) then
        fsEAD.RemoveFreeNotification(Self);

     fsEAD := AValue;

     if AValue <> nil then
     begin
        AValue.FreeNotification(self);

        if Assigned( fsEADInterno ) then
           FreeAndNil( fsEADInterno );
     end ;
  end ;
end ;

procedure TACBrPAF.SetAAC(const AValue : TACBrAAC) ;
begin
  if AValue <> fsAAC then
  begin
     if Assigned(fsAAC) then
        fsAAC.RemoveFreeNotification( Self );

     fsAAC := AValue;

     if AValue <> nil then
        AValue.FreeNotification(self);
  end ;
end ;

function TACBrPAF.SaveFileTXT_D(Arquivo: String): Boolean;
var
  txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);
      Write(txtFile, FPAF_D.WriteRegistroD1);

      if FPAF_D.RegistroD2.Count > 0 then
         Write(txtFile, FPAF_D.WriteRegistroD2);

      Write(txtFile, FPAF_D.WriteRegistroD9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
       AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    FPAF_D.LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_E(Arquivo: String): Boolean;
var
  txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);
      Write(txtFile, FPAF_E.WriteRegistroE1);

      if FPAF_E.RegistroE2.Count > 0 then
        Write(txtFile, FPAF_E.WriteRegistroE2);

      Write(txtFile, FPAF_E.WriteRegistroE9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    FPAF_E.LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_P(Arquivo: String): Boolean;
var
txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);

      Write(txtFile, FPAF_P.WriteRegistroP1);
      if FPAF_P.RegistroP2.Count > 0 then
        Write(txtFile, FPAF_P.WriteRegistroP2);

      Write(txtFile, FPAF_P.WriteRegistroP9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    FPAF_P.LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_R(Arquivo: String): Boolean;
var
txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);

      Write(txtFile, FPAF_R.WriteRegistroR01);
      if FPAF_R.RegistroR02.Count > 0 then
        Write(txtFile, FPAF_R.WriteRegistroR02);

      if FPAF_R.RegistroR04.Count > 0 then
        Write(txtFile, FPAF_R.WriteRegistroR04);

      if FPAF_R.RegistroR06.Count > 0 then
        Write(txtFile, FPAF_R.WriteRegistroR06);

      if Trim(FPAF_R.RegistroR07) <> EmptyStr then
        Write(txtFile, FPAF_R.RegistroR07);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    FPAF_R.LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_T(Arquivo: String): Boolean;
var
txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);
      Write(txtFile, FPAF_T.WriteRegistroT1);

      if FPAF_T.RegistroT2.Count > 0 then
        Write(txtFile, FPAF_T.WriteRegistroT2);

      Write(txtFile, FPAF_T.WriteRegistroT9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    FPAF_T.LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;


function TACBrPAF.SaveFileTXT_C(Arquivo: String): Boolean;
var
txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);

      Write(txtFile, FPAF_C.WriteRegistroC1);

      if FPAF_C.RegistroC2.Count > 0 then
        Write(txtFile, FPAF_C.WriteRegistroC2);

      Write(txtFile, FPAF_C.WriteRegistroC9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    FPAF_C.LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_N(Arquivo: String): Boolean;
var
  txtFile: TextFile;
  PAF_MD5 : String ;
  iFor: Integer;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  if Assigned( fsAAC ) then
  begin
     // Copie do AAC campos não informados do N1 //
    with FPAF_N.RegistroN1 do
    begin
      CNPJ        := ifthen( CNPJ = '', fsAAC.IdentPAF.Empresa.CNPJ, CNPJ ) ;
      IE          := ifthen( IE = '', fsAAC.IdentPAF.Empresa.IE, IE ) ;
      IM          := ifthen( IM = '', fsAAC.IdentPAF.Empresa.IM, IM ) ;
      RAZAOSOCIAL := ifthen( RAZAOSOCIAL = '', fsAAC.IdentPAF.Empresa.RazaoSocial,
                             RAZAOSOCIAL ) ;
    end;

    // Copie do AAC campos não informados do N2 //
    with FPAF_N.RegistroN2 do
    begin
       LAUDO  := ifthen( LAUDO = '', fsAAC.IdentPAF.NumeroLaudo, LAUDO ) ;
       NOME   := ifthen( NOME = '', fsAAC.IdentPAF.paf.Nome, NOME ) ;
       VERSAO := ifthen( VERSAO = '', fsAAC.IdentPAF.Paf.Versao, VERSAO ) ;
    end;

    // Se informou os arquivos no ACBrAAC copie-os para o N3 //
    if fsAAC.IdentPAF.OutrosArquivos.Count > 0 then
    begin
      FPAF_N.RegistroN3.Clear;
      For iFor := 0 to fsAAC.IdentPAF.OutrosArquivos.Count-1 do
      begin
         with FPAF_N.RegistroN3.New do
         begin
            NOME_ARQUIVO := fsAAC.IdentPAF.OutrosArquivos[iFor].Nome;
	         MD5 := '' ; // MD5 será calculado em WriteRegistroN3
         end ;
      end;
    end;
  end ;

  // Gravando arquivo N //
  AssignFile(txtFile, fPath + Arquivo);
  try
    Rewrite(txtFile);
    Write(txtFile, FPAF_N.WriteRegistroN1);
    Write(txtFile, FPAF_N.WriteRegistroN2);

    if FPAF_N.RegistroN3.Count > 0 then
      Write(txtFile, FPAF_N.WriteRegistroN3);

    Write(txtFile, FPAF_N.WriteRegistroN9);
  finally
    CloseFile(txtFile);
  end;

  // Assinatura EAD
  if FAssinar then
    AssinaArquivoComEAD(fPath + Arquivo);

  // Sincronizando arquivos e MD5 do ACBrPAF com ACBrAAC //
  if Assigned( fsAAC ) then
  begin
    AAC.IdentPAF.OutrosArquivos.Clear ;

    // Alimenta a lista de arquivos autenticados no AAC, para que essa lista
    // possa ser usada na impressão do relatório "Identificação do PAF-ECF"
    for iFor := 0 to FPAF_N.RegistroN3.Count - 1 do
    begin
       with AAC.IdentPAF.OutrosArquivos.New do
       begin
          Nome := FPAF_N.RegistroN3.Items[iFor].NOME_ARQUIVO;
          MD5  := FPAF_N.RegistroN3.Items[iFor].MD5;
       end;
    end;

    // Gera o MD5 do arquivo
    PAF_MD5 := GetACBrEAD.MD5FromFile( fPath + Arquivo );

    // Informações do arquivo com a lista de arquivos autenticados
    AAC.IdentPAF.ArquivoListaAutenticados.Nome := Arquivo;
    // Atualiza AAC.IdentPAF.ArquivoListaAutenticados.MD5
    AAC.AtualizarMD5( PAF_MD5 );
  end ;

  // Limpa de todos os Blocos as listas de todos os registros.
  FPAF_N.LimpaRegistros;
end;

procedure TACBrPAF.Notification(AComponent : TComponent ; Operation : TOperation
   ) ;
begin
   inherited Notification(AComponent, Operation) ;

  if (Operation = opRemove) and (AComponent is TACBrEAD) and (fsEAD <> nil) then
     fsEAD := nil ;

  if (Operation = opRemove) and (AComponent is TACBrAAC) and (fsAAC <> nil) then
     fsAAC := nil ;
end ;

function TACBrPAF.GetACBrEAD : TACBrEAD ;
begin
  if Assigned(fsEAD) then
     Result := fsEAD
  else
   begin
     if not Assigned( fsEADInterno ) then
     begin
        fsEADInterno := TACBrEAD.Create(Self);
        fsEADInterno.OnGetChavePrivada := fsOnPAFGetKeyRSA;
     end ;
     Result := fsEADInterno;
   end ;
end ;

function TACBrPAF.AssinaArquivoComEAD(Arquivo: String): Boolean;
begin
  if Assigned( fsOnPAFCalcEAD ) then
     fsOnPAFCalcEAD( Arquivo )
  else
     GetACBrEAD.AssinarArquivoComEAD( Arquivo ) ;

  Result := True;
end;

{$ifdef FPC}
initialization
   {$I ACBrPAF.lrs}
{$endif}

end.
