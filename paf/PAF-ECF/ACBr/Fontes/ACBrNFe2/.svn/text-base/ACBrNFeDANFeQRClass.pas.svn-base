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
|*  - Implementado fqrDANFeQRRetrato.ProtocoloNFE( sProt ).
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 20/08/2009: Caique Rodrigues
|*  - Doação units para geração do Danfe via QuickReport
|* 23/11/2010: Peterson de Cerqueira Matos
|*  - Tratamento das propriedades "CasasDecimais._qCom", "CasasDecimais._vUnCom",
|*    "Impressora"
|* 20/05/2011: Peterson de Cerqueira Matos
|*  - Tratamento da propriedade "ExibirResumoCanhoto_Texto"
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeQRClass;

interface

uses Forms, SysUtils, Classes,
     ACBrNFeDANFEClass, pcnNFe;

type
  TACBrNFeDANFEQR = class( TACBrNFeDANFEClass )
   private
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override ;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil, StrUtils, Dialogs, ACBrNFeDANFeQRRetrato;

constructor TACBrNFeDANFEQR.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
end;

destructor TACBrNFeDANFEQR.Destroy;
begin
  inherited Destroy ;
end;


procedure TACBrNFeDANFEQR.ImprimirDANFE(NFE : TNFe = nil);
var
  i : Integer;
  fqrDANFeQRRetrato : TfqrDANFeQRRetrato;
  sProt     : String ;
begin
  fqrDANFeQRRetrato := TfqrDANFeQRRetrato.Create(Self);

  sProt := TACBrNFe(ACBrNFe).DANFE.ProtocoloNFe ;
  fqrDANFeQRRetrato.ProtocoloNFE( sProt ) ;

  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        fqrDANFeQRRetrato.Imprimir(   TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe
                                    , Logo
                                    , Email
                                    , ExibirResumoCanhoto
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
                                    , CasasDecimais._qCom
                                    , CasasDecimais._vUnCom
                                    , Impressora
                                    , ExibirResumoCanhoto_Texto);
      end;
   end
  else
     fqrDANFeQRRetrato.Imprimir(  NFe
                                , Logo
                                , Email
                                , ExibirResumoCanhoto
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
                                , CasasDecimais._qCom
                                , CasasDecimais._vUnCom
                                , Impressora
                                , ExibirResumoCanhoto_Texto);

  fqrDANFeQRRetrato.Free;
end;

procedure TACBrNFeDANFEQR.ImprimirDANFEPDF(NFE : TNFe = nil);
var
    NomeArq : String;
    i : Integer;
    fqrDANFeQRRetrato : TfqrDANFeQRRetrato;
    sProt     : String ;
begin
    fqrDANFeQRRetrato := TfqrDANFeQRRetrato.Create(Self);

    sProt := TACBrNFe(ACBrNFe).DANFE.ProtocoloNFe ;
    fqrDANFeQRRetrato.ProtocoloNFE( sProt ) ;
      if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        NomeArq := StringReplace(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe.infNFe.ID,'NFe', '', [rfIgnoreCase]);
        NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';

        fqrDANFeQRRetrato.SavePDF(  NomeArq
                                    ,TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe
                                    , Logo
                                    , Email
                                    , ExibirResumoCanhoto
                                    , Fax
                                    , NumCopias
                                    , Sistema
                                    , Site
                                    , Usuario
                                    , MargemSuperior
                                    , MargemInferior
                                    , MargemEsquerda
                                    , MargemDireita
                                    , CasasDecimais._qCom
                                    , CasasDecimais._vUnCom
                                    , ExibirResumoCanhoto_Texto);
      end;
   end
  else
  begin
     NomeArq := StringReplace(NFe.infNFe.ID,'NFe', '', [rfIgnoreCase]);
     NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';
     fqrDANFeQRRetrato.SavePDF( NomeArq
                                , NFe
                                , Logo
                                , Email
                                , ExibirResumoCanhoto
                                , Fax
                                , NumCopias
                                , Sistema
                                , Site
                                , Usuario
                                , MargemSuperior
                                , MargemInferior
                                , MargemEsquerda
                                , MargemDireita
                                , CasasDecimais._qCom
                                , CasasDecimais._vUnCom
                                , ExibirResumoCanhoto_Texto);
  end;

  fqrDANFeQRRetrato.Free;

end;


end.
