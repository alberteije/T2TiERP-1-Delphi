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
|* 11/12/2009: Emerson Crema
|*  - Implementado fqrDACTeQRRetrato.ProtocoloNFE( sProt ).
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 20/08/2009: Caique Rodrigues
|*  - Doação units para geração do DANFe via QuickReport
******************************************************************************}

{$I ACBr.inc}

unit ACBrCTeDACTeQRClass;

interface

uses
 Forms, SysUtils, Classes,
 pcteCTe, ACBrCTeDACTeQR, ACBrCTeDACTeClass, ACBrCTeDACTeQRRetrato, pcnConversao;

type
  TACBrCTeDACTeQR = class(TACBrCTeDACTeClass)
  private
    FPosRecibo: TPosRecibo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDACTe(CTe: TCTe = nil); override;
    procedure ImprimirDACTePDF(CTe: TCTe = nil); override;
  published
    property PosRecibo: TPosRecibo read FPosRecibo write FPosRecibo default prCabecalho;
  end;

implementation

uses StrUtils, Dialogs, ACBrUtil, ACBrCTe, ACBrCteUtil;

constructor TACBrCTeDACTeQR.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
end;

destructor TACBrCTeDACTeQR.Destroy;
begin
  inherited Destroy;
end;

procedure TACBrCTeDACTeQR.ImprimirDACTe(CTe: TCTe = nil);
var
  i     : Integer;
  sProt : string;

  frmDACTeQRRetrato : TfrmDACTeQRRetrato;
begin

  frmDACTeQRRetrato := TfrmDACTeQRRetrato.Create(Self);
  sProt := TACBrCTe(ACBrCTe).DACTe.ProtocoloCTe;
  frmDACTeQRRetrato.ProtocoloCTe(sProt);

  if CTe = nil then
  begin
    for i := 0 to TACBrCTe(ACBrCTe).Conhecimentos.Count - 1 do
      frmDACTeQRRetrato.Imprimir(TACBrCTe(ACBrCTe).Conhecimentos.Items[i].CTe
                                    , Logo
                                    , Email
                                    , ImprimirHoraSaida
                                    , ExpandirLogoMarca
                                    , ImprimirHoraSaida_Hora
                                    , false
                                    , Fax
                                    , NumCopias
                                    , Sistema
                                    , Site
                                    , Usuario
                                    , MostrarPreview
                                    , MargemSuperior
                                    , MargemInferior
                                    , MargemEsquerda
                                    , MargemDireita
                                    , Impressora
                                    , PosRecibo);
  end
  else
    frmDACTeQRRetrato.Imprimir(CTe
                                , Logo
                                , Email
                                , ImprimirHoraSaida
                                , ExpandirLogoMarca
                                , ImprimirHoraSaida_Hora
                                , False
                                , Fax
                                , NumCopias
                                , Sistema
                                , Site
                                , Usuario
                                , MostrarPreview
                                , MargemSuperior
                                , MargemInferior
                                , MargemEsquerda
                                , MargemDireita
                                , Impressora
                                , PosRecibo);

  frmDACTeQRRetrato.Free;
end;

procedure TACBrCTeDACTeQR.ImprimirDACTePDF(CTe: TCTe = nil);
var
  i       : Integer;
  sProt   : String;
  NomeArq : string;

  frmDACTeQRRetrato : TfrmDACTeQRRetrato;
begin

  frmDACTeQRRetrato := TfrmDACTeQRRetrato.Create(Self);
  sProt := TACBrCTe(ACBrCTe).DACTe.ProtocoloCTe ;
  frmDACTeQRRetrato.ProtocoloCTe( sProt ) ;

  if CTe = nil then
   begin
     for i:= 0 to TACBrCTe(ACBrCTe).Conhecimentos.Count-1 do
      begin
        NomeArq := StringReplace(TACBrCTe(ACBrCTe).Conhecimentos.Items[i].CTe.infCTe.ID,'CTe', '', [rfIgnoreCase]);
        NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';

        frmDACTeQRRetrato.SavePDF(  NomeArq
                                    ,TACBrCTe(ACBrCTe).Conhecimentos.Items[i].CTe
                                    , Logo
                                    , Email
                                    , ImprimirHoraSaida
                                    , ExpandirLogoMarca
                                    , ImprimirHoraSaida_Hora
                                    , false
                                    , Fax
                                    , NumCopias
                                    , Sistema
                                    , Site
                                    , Usuario
                                    , MargemSuperior
                                    , MargemInferior
                                    , MargemEsquerda
                                    , MargemDireita
                                    , PosRecibo);
      end;
   end
  else
  begin
     NomeArq := StringReplace(CTe.infCTe.ID,'CTe', '', [rfIgnoreCase]);
     NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';
     frmDACTeQRRetrato.SavePDF( NomeArq
                                , CTe
                                , Logo
                                , Email
                                , ImprimirHoraSaida
                                , ExpandirLogoMarca
                                , ImprimirHoraSaida_Hora
                                , False
                                , Fax
                                , NumCopias
                                , Sistema
                                , Site
                                , Usuario
                                , MargemSuperior
                                , MargemInferior
                                , MargemEsquerda
                                , MargemDireita
                                , PosRecibo);
  end;

  frmDACTeQRRetrato.Free;

end;

end.

