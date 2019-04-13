{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFe;

interface

uses
  Classes, Sysutils,
  pcnNFe, pcnConversao,
  {$IFDEF CLX} QDialogs,{$ELSE} Dialogs,{$ENDIF}
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes,
  ACBrNFeWebServices, ACBrNFeUtil,
  ACBrNFeDANFEClass;

const
  ACBRNFE_VERSAO = '0.3.1a';
  
type
 TACBrNFeAboutInfo = (ACBrNFeAbout);

 { Evento para gerar log das mensagens do Componente }
 TACBrNFeLog = procedure(const Mensagem : String) of object ;

  TACBrNFe = class(TComponent)
  private
    fsAbout: TACBrNFeAboutInfo;
    FDANFE : TACBrNFeDANFEClass;
    FNotasFiscais: TNotasFiscais;
    FWebServices: TWebServices;
    FConfiguracoes: TConfiguracoes;
    FStatus : TStatusACBrNFe;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog : TACBrNFeLog;
    procedure SetDANFE(const Value: TACBrNFeDANFEClass);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean; overload;
    function Enviar(ALote: String; Imprimir:Boolean = True): Boolean; overload;
    function Cancelamento(AJustificativa:WideString): Boolean;
    function Consultar: Boolean;
    property WebServices: TWebServices read FWebServices write FWebServices;
    property NotasFiscais: TNotasFiscais read FNotasFiscais write FNotasFiscais;
    property Status: TStatusACBrNFe read FStatus;
    procedure SetStatus( const stNewStatus : TStatusACBrNFe );
  published
    property Configuracoes: TConfiguracoes read FConfiguracoes write FConfiguracoes;
    property OnStatusChange: TNotifyEvent read FOnStatusChange write FOnStatusChange;
    property DANFE: TACBrNFeDANFEClass read FDANFE write SetDANFE ;
    property AboutACBrNFe : TACBrNFeAboutInfo read fsAbout write fsAbout
                          stored false ;
    property OnGerarLog : TACBrNFeLog read FOnGerarLog write FOnGerarLog ;                          
  end;

procedure ACBrAboutDialog ;

implementation

procedure ACBrAboutDialog ;
var Msg : String ;
begin
    Msg := 'Componente ACBrNFePCN'+#10+
           'Automação Comercial Brasil'+#10+#10+
           'http://acbr.sourceforge.net'+#10+#10+
           'Projeto Cooperar - PCN'+#10+#10+
           'http://www.projetocooperar.org/pcn/'+#10+#10+
           'Versão: '+ACBRNFE_VERSAO ;
     MessageDlg(Msg ,mtInformation ,[mbOk],0) ;
end;

{ TACBrNFe }

constructor TACBrNFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FConfiguracoes     := TConfiguracoes.Create( self );
  FConfiguracoes.Name:= 'Configuracoes' ;
  {$IFDEF COMPILER6_UP}
   FConfiguracoes.SetSubComponent( true );{ para gravar no DFM/XFM }
  {$ENDIF}

  FNotasFiscais      := TNotasFiscais.Create(Self,NotaFiscal);
  FNotasFiscais.Configuracoes := FConfiguracoes;
  FWebServices       := TWebServices.Create(Self);

  if FConfiguracoes.WebServices.Tentativas <= 0 then
     FConfiguracoes.WebServices.Tentativas := 5;
  {$IFDEF ACBrNFeOpenSSL}
     NotaUtil.InitXmlSec ;
  {$ENDIF}
  FOnGerarLog := nil ;
end;

destructor TACBrNFe.Destroy;
begin
  FConfiguracoes.Free;
  FNotasFiscais.Free;
  FWebServices.Free;
  {$IFDEF ACBrNFeOpenSSL}
     NotaUtil.ShutDownXmlSec ;
  {$ENDIF}
  inherited;
end;

procedure TACBrNFe.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDANFE <> nil) and (AComponent is TACBrNFeDANFEClass) then
     FDANFE := nil ;
end;

procedure TACBrNFe.SetDANFE(const Value: TACBrNFeDANFEClass);
 Var OldValue: TACBrNFeDANFEClass ;
begin
  if Value <> FDANFE then
  begin
     if Assigned(FDANFE) then
        FDANFE.RemoveFreeNotification(Self);

     OldValue  := FDANFE ;   // Usa outra variavel para evitar Loop Infinito
     FDANFE    := Value;    // na remoção da associação dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ACBrNFe) then
           OldValue.ACBrNFe := nil ;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ACBrNFe := self ;
     end ;
  end ;
end;

procedure TACBrNFe.SetStatus( const stNewStatus : TStatusACBrNFe );
begin
  if ( stNewStatus <> FStatus ) then
  begin
    FStatus := stNewStatus;
    if Assigned(fOnStatusChange) then
      FOnStatusChange(Self);
  end;
end;

function TACBrNFe.Cancelamento(
  AJustificativa: WideString): Boolean;
var
  i : Integer;
begin
  if Self.NotasFiscais.Count = 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhuma Nota Fiscal Eletrônica Informada!');
      raise Exception.Create('Nenhuma Nota Fiscal Eletrônica Informada!');
   end;

//  for i:= 0 to self.NotasFiscais.Count-1 do
//    self.NotasFiscais.Items[i].XML.NFeChave := self.NotasFiscais.Items[i].NFe.infNFe.ID;;

  for i:= 0 to self.NotasFiscais.Count-1 do
  begin
    WebServices.Cancelamento.NFeChave := copy(self.NotasFiscais.Items[i].NFe.infNFe.ID, (length(self.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
    WebServices.Consulta.NFeChave := WebServices.Cancelamento.NFeChave;
    WebServices.Cancela(AJustificativa);
  end;

  Result := true;
end;

function TACBrNFe.Consultar: Boolean;
var
  i : Integer;
begin
  if Self.NotasFiscais.Count = 0 then
   begin
     if Assigned(Self.OnGerarLog) then
        Self.OnGerarLog('ERRO: Nenhuma Nota Fiscal Eletrônica Informada!');
     raise Exception.Create('Nenhuma Nota Fiscal Eletrônica Informada!');
   end;

  for i := 0 to Self.NotasFiscais.Count-1 do
  begin
    WebServices.Consulta.NFeChave := copy(self.NotasFiscais.Items[i].NFe.infNFe.ID, (length(self.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
    WebServices.Consulta.Executar;
  end;
  Result := True;

end;

function TACBrNFe.Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean;
begin
  Result := Enviar(IntToStr(ALote), Imprimir);
end;

function TACBrNFe.Enviar(ALote: String; Imprimir: Boolean): Boolean;
var
  i: Integer;
begin
  NotasFiscais.Assinar;
  NotasFiscais.Valida;

  Result := WebServices.Envia(ALote);

  if DANFE <> nil then
  begin
     for i:= 0 to NotasFiscais.Count-1 do
     begin
       if NotasFiscais.Items[i].Confirmada and Imprimir then
       begin
          NotasFiscais.Items[i].Imprimir;
          if (DANFE.ClassName='TACBrNFeDANFERaveCB') then
            Break;
       end;
     end;
  end;
end;

end.
