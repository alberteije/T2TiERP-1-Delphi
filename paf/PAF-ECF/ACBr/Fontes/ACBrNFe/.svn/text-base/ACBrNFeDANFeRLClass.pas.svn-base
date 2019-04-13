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
|* 20/08/2009: Caique Rodrigues
|*  - Doação units para geração do Danfe via QuickReport
|* 20/11/2009: Peterson de Cerqueira Matos
|*             E-mail: peterson161@yahoo.com - Tel: (11) 7197-1474 / 8059-4055
|*  - Componente e Units do QuickReport clonados
|*    e transformados em FORTES REPORT
|* 27/01/2010: Peterson de Cerqueira Matos
|*  - Acréscimo da propriedade "LarguraCodProd", que definirá a largura da
|*    "Código do Produto" no DANFE
|* 15/03/2010: Felipe Feltes
|*  - Adequação na seção 'USES' para ser utilizado em CLX
|* 19/03/2010: Peterson de Cerqueira Matos
|*  - Tratamento das propriedades "FormularioContinuo", "ExpandirLogoMarca" e
|*    "MostrarPreview" de "ACBrNFeDANFeClass"
|*  - Acréscimo da propriedade "PosCanhoto", que permite ao usuário escolher
|*    entre "pcCabecalho" e "pcRodape"
|* 22/03/2010: Peterson de Cerqueira Matos
|*  - Tratamento das margens em "ACBrNFeDANFeClass"
|*  - Acréscimo da propriedade "FonteDANFE", que permite ao usuário escolher
|*    entre "fdArial", "fdTimesNewRoman" e "fdCourierNew"
|* 13/04/2010: Peterson de Cerqueira Matos
|*  - Tratamento das casas decimais em "ACBrNFeDANFeClass"
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeRLClass;

interface

uses SysUtils, Classes,
  {$IFDEF CLX}
  QForms, QDialogs,
  {$ELSE}
  Forms, Dialogs,
  {$ENDIF}
  ACBrNFeDANFEClass, ACBrNFeDANFeRL, ACBrNFeDANFeRLRetrato, pcnNFe,
  pcnConversao, StrUtils;

type
  TACBrNFeDANFeRL = class( TACBrNFeDANFEClass )
  private
    FMarcadagua: string;
    FLarguraCodProd: Integer;
    FPosCanhoto: TPosCanhoto;
    FFonteDANFE: TFonteDANFE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override ;
    procedure SetPosCanhoto(Value: TPosCanhoto); virtual;
    procedure SetFonteDANFE(Value: TFonteDANFE); virtual;
  published
    property MarcadAgua : String read FMarcadagua write FMarcadagua ;
    property LarguraCodProd: Integer read FLarguraCodProd write FLarguraCodProd;
    property PosCanhoto: TPosCanhoto read FPosCanhoto write SetPosCanhoto
                                                          default pcCabecalho;
    property FonteDANFE: TFonteDANFE read FFonteDANFE write SetFonteDANFE
                                                      default fdTimesNewRoman;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil;

var
  i : Integer;
  frlDANFeRLRetrato : TfrlDANFeRLRetrato;

constructor TACBrNFeDANFeRL.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
  FLarguraCodProd := 54;
  FMargemSuperior := 0.70;
  FMargemInferior := 0.70;
  FMargemEsquerda := 0.70;
  FMargemDireita := 0.70;
  
end;

destructor TACBrNFeDANFeRL.Destroy;
begin
  inherited Destroy ;
end;


procedure TACBrNFeDANFeRL.ImprimirDANFE(NFE : TNFe = nil);
begin
  frlDANFeRLRetrato := TfrlDANFeRLRetrato.Create(Self);

  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        frlDANFeRLRetrato.Imprimir(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe,
        Logo, MarcaDagua, LarguraCodProd, Email, ExibirResumoCanhoto, Fax,
        NumCopias, Sistema, Site, Usuario, PosCanhoto, FormularioContinuo,
        ExpandirLogoMarca, MostrarPreview, FonteDANFE, MargemSuperior,
        MargemInferior, MargemEsquerda, MargemDireita, CasasDecimais._qCom,
        CasasDecimais._vUnCom);
      end;
   end
  else
    frlDANFeRLRetrato.Imprimir(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe,
    Logo, MarcaDagua, LarguraCodProd, Email, ExibirResumoCanhoto, Fax,
    NumCopias, Sistema, Site, Usuario, PosCanhoto, FormularioContinuo,
    ExpandirLogoMarca, MostrarPreview, FonteDANFE, MargemSuperior,
    MargemInferior, MargemEsquerda, MargemDireita, CasasDecimais._qCom,
    CasasDecimais._vUnCom);

  frlDANFeRLRetrato.Free;
end;

procedure TACBrNFeDANFeRL.ImprimirDANFEPDF(NFE : TNFe = nil);
var sFile: String;
begin
  frlDANFeRLRetrato := TfrlDANFeRLRetrato.Create(Self);

  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        sFile := TACBrNFe(ACBrNFe).DANFE.PathPDF +
                 Copy(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe.infNFe.ID,
                 4, 44) + '-nfe.pdf';
        frlDANFeRLRetrato.SavePDF(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe,
        Logo, MarcaDagua, LarguraCodProd, Email,
        ExibirResumoCanhoto, Fax, NumCopias, Sistema, Site, Usuario, sFile,
        PosCanhoto, FormularioContinuo, ExpandirLogoMarca, FonteDANFE,
        MargemSuperior, MargemInferior, MargemEsquerda, MargemDireita,
        CasasDecimais._qCom, CasasDecimais._vUnCom);
      end;
   end;

  frlDANFeRLRetrato.Free;
end;

procedure TACBrNFeDANFeRL.SetPosCanhoto(Value: TPosCanhoto);
begin
  FPosCanhoto := Value;
end;

procedure TACBrNFeDANFeRL.SetFonteDANFE(Value: TFonteDANFE);
begin
  FFonteDANFE := Value;
end;

end.
