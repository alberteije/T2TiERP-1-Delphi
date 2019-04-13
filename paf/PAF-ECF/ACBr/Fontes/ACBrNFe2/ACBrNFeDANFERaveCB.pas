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
|* 20/08/2009: João Paulo
|*  - Doação units para geração do Danfe via código usando Rave
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFERaveCB;

interface

uses Forms, SysUtils, Classes,
  RpDefine, RpDevice, RVClass, RVProj, RVCsBars, RVCsStd, RVCsData,
  RvDirectDataView, RVDataField, jpeg,
  ACBrNFeDANFEClass, ACBrDANFeCBRave, pcnNFe, pcnConversao;

type
  TFont=(ftTimes,ftCourier);

  TACBrNFeDANFERaveCB = class( TACBrNFeDANFEClass )
   private
     FTamanhoCampoCodigo: integer;
     FTamanhoFonte_ANTT: integer;
     FFonte : TFont;
     FEspessuraBorda: Integer;

     function SeSenaoJPEG(ACondicao: Boolean; ATrue, AFalse: TJPEGImage): TJPEGImage;
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override ;
  published
     property TamanhoCampoCodigo:integer read FTamanhoCampoCodigo write FTamanhoCampoCodigo;
     property TamanhoFonte_ANTT:integer read FTamanhoFonte_ANTT write FTamanhoFonte_ANTT;
     property Fonte:TFont read FFonte write FFonte;
     property EspessuraBorda:Integer read FEspessuraBorda write FEspessuraBorda;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil, StrUtils, Dialogs;

constructor TACBrNFeDANFERaveCB.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  FTamanhoCampoCodigo:=0;
  FTamanhoFonte_ANTT:=10;
  FEspessuraBorda:=2;
end;

destructor TACBrNFeDANFERaveCB.Destroy;
begin
  inherited Destroy ;
end;


procedure TACBrNFeDANFERaveCB.ImprimirDANFE(NFE : TNFe = nil);
var
 LogoMarcaEmpresa:TJPEGImage;
 ExisteLogoMarca: Boolean;
 vStringStream: TStringStream;
begin
    ExisteLogoMarca:=True;
    LogoMarcaEmpresa:=TJPEGImage.Create;
    try
      if NotaUtil.NaoEstaVazio(Logo) then
       begin
         if FileExists(Logo) then
            LogoMarcaEmpresa.LoadFromFile(Logo)
         else
         begin
            vStringStream:= TStringStream.Create(Logo);
            try
               LogoMarcaEmpresa.LoadFromStream(vStringStream);
            finally
               vStringStream.Free;
            end;
         end;
       end
       else
        ExisteLogoMarca:=False;

      ImprimirDANFeRave(TACBrNFe(ACBrNFe),
                       Site,
                       Email,
                       Fax,
                       Sistema,
                       Usuario,
                       ProtocoloNFe,
                       SeSenaoJPEG(ExisteLogoMarca,LogoMarcaEmpresa,nil),
                       NotaUtil.SeSenao((TipoDANFE=tiRetrato),poPortrait,poLandScape),
                       NotaUtil.SeSenao(MostrarPreview,tsPreview,tsPrint),
                       MostrarStatus,
                       NumCopias,
                       Impressora,
                       '',
                       MargemInferior*10,
                       MargemSuperior*10,
                       MargemEsquerda*10,
                       MargemDireita*10,
                       CasasDecimais._qCom,
                       CasasDecimais._vUnCom,
                       CasasDecimais._Mask_qCom,
                       CasasDecimais._Mask_vUnCom,
                       TamanhoCampoCodigo,
                       TamanhoFonte_DemaisCampos,
                       TamanhoFonte_ANTT,
                       ProdutosPorPagina,
                       EspessuraBorda,
                       ExibirResumoCanhoto,
                       ExibirResumoCanhoto_Texto,
                       ImprimirDescPorc,
                       ImprimirTotalLiquido,
                       ImprimirDetalhamentoEspecifico,
                       FormularioContinuo,
                       ExpandirLogoMarca,
                       NFeCancelada,
                       NFe);
    finally
      LogoMarcaEmpresa.Free;
    end;
end;

procedure TACBrNFeDANFERaveCB.ImprimirDANFEPDF(NFE : TNFe = nil);
var
 LogoMarcaEmpresa:TJPEGImage;
 ExisteLogoMarca: Boolean;
 NomeArq : String;
 vStringStream: TStringStream;
begin
    ExisteLogoMarca:=True;
    LogoMarcaEmpresa:=TJPEGImage.Create;
    try
      if NotaUtil.NaoEstaVazio(Logo) then
       begin
         if FileExists(Logo) then
            LogoMarcaEmpresa.LoadFromFile(Logo)
         else
         begin
            vStringStream:= TStringStream.Create(Logo);
            try
               LogoMarcaEmpresa.LoadFromStream(vStringStream);
            finally
               vStringStream.Free;
            end;
         end;
       end
       else
         ExisteLogoMarca:=False;

      if NFE = nil then
         NomeArq := StringReplace(TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe.infNFe.ID,'NFe', '', [rfIgnoreCase])
      else
         NomeArq := StringReplace(NFE.infNFe.ID,'NFe', '', [rfIgnoreCase]);

      NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';

      ImprimirDANFeRave(TACBrNFe(ACBrNFe),
                       Site,
                       Email,
                       Fax,
                       Sistema,
                       Usuario,
                       ProtocoloNFe,
                       SeSenaoJPEG(ExisteLogoMarca,LogoMarcaEmpresa,nil),
                       NotaUtil.SeSenao((TipoDANFE=tiRetrato),poPortrait,poLandScape),
                       tsPDF,
                       MostrarStatus,
                       NumCopias,
                       Impressora,
                       NomeArq,
                       MargemInferior*10,
                       MargemSuperior*10,
                       MargemEsquerda*10,
                       MargemDireita*10,
                       CasasDecimais._qCom,
                       CasasDecimais._vUnCom,
                       CasasDecimais._Mask_qCom,
                       CasasDecimais._Mask_vUnCom,
                       TamanhoCampoCodigo,
                       TamanhoFonte_DemaisCampos,
                       TamanhoFonte_ANTT,
                       ProdutosPorPagina,
                       EspessuraBorda,
                       ExibirResumoCanhoto,
                       ExibirResumoCanhoto_Texto,
                       ImprimirDescPorc,
                       ImprimirTotalLiquido,
                       ImprimirDetalhamentoEspecifico,
                       FormularioContinuo,
                       ExpandirLogoMarca,
                       NFeCancelada,
                       NFE);
    finally
      LogoMarcaEmpresa.Free;
    end;
end;


function TACBrNFeDANFERaveCB.SeSenaoJPEG(ACondicao: Boolean; ATrue,
  AFalse: TJPEGImage): TJPEGImage;
begin
  Result := AFalse;
  if ACondicao then
    Result := ATrue;
end;

end.
