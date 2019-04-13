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
|*  - Acréscimo dos parâmetros "ALarguraCodProd" nas Class procedures
|*    "Imprimir" e "SavePDF"
|* 05/02/2010: Peterson de Cerqueira Matos
|*  - Tratamento das propriedades "Email", "ResumoCanhoto", "Fax", "NumCopias",
|*    "Ssitema", "Site", "Usuario" em "ACBrNFeDANFeClass"
|*  - Acréscimo dos parâmetros "AEmail", "AResumoCanhoto", "AFax", "ANumCopias",
|*    "ASsitema", "ASite", "AUsuario" nas Class procedures
|*    "Imprimir" e "SavePDF"
|* 13/02/2010: Peterson de Cerqueira Matos
|*  - Correção na exibição do 'Preview' para modo 'PREVIEWMODAL'
|* 15/03/2010: Felipe Feltes
|*  - Adequação na seção 'USES' para ser utilizado em CLX
|* 19/03/2010: Peterson de Cerqueira Matos
|*  - Tratamento das propriedades "FormularioContinuo", "ExpandirLogoMarca" e
|*    "MostrarPreview" de "ACBrNFeDANFeClass"
|*  - Acréscimo dos parâmetros "APosCanhoto", "AFormularioContinuo",
|*    "AExpandirLogoMarca" e "AMostrarPreview" nas Class procedures
|*    "Imprimir" e "SavePDF" (esta última sem o "AMostrarPreview")
|* 22/03/2010: Peterson de Cerqueira Matos
|*  - Tratamento das margens em "ACBrNFeDANFeClass"
|*  - Acréscimo dos parâmetros "AMargemSuperior, AMargemInferior,
|*    AMargemEsqurda, AMargemDireita" e "AFonteDANFE"
|* 13/04/2010: Peterson de Cerqueira Matos
|*  - Tratamento das casas decimais em "ACBrNFeDANFeClass"
|*  - Acréscimo dos parâmetros "FCasasDecimaisqCom" e "FCasasDecimaisvUnCom"
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeRL;

interface

uses
  SysUtils, Variants, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QExtCtrls, Qt,
  {$ELSE}
  Windows, Messages, Graphics, Controls, Forms, Dialogs, ExtCtrls,
  {$ENDIF}
  RLReport, pcnNFe, ACBrNFe, RLFilters, MaskUtils;

type
  TPosCanhoto = (pcCabecalho, pcRodape);
  TFonteDANFE = (fdTimesNewRoman, fdCourierNew, fdArial);
type
  TfrlDANFeRL = class(TForm)
    RLNFe: TRLReport;

  private
    { Private declarations }
  protected
    FACBrNFe: TACBrNFe;
    FNFe: TNFe;
    FLogo: String;
    FMarcaDagua: String;
    FLarguraCodProd: Integer;
    FEmail: String;
    FResumoCanhoto: Boolean;
    FFax: String;
    FNumCopias: Integer;
    FSsitema: String;
    FSite: String;
    FUsuario: String;
    FPosCanhoto: TPosCanhoto;
    FFormularioContinuo: Boolean;
    FExpandirLogoMarca: Boolean;
    FMostrarPreview: Boolean;
    FFonteDANFE: TFonteDANFE;
    FMargemSuperior: Double;
    FMargemInferior: Double;
    FMargemEsquerda: Double;
    FMargemDireita: Double;
    FCasasDecimaisqCom: Integer;
    FCasasDecimaisvUnCom: Integer;

  public
    { Public declarations }
    class procedure Imprimir(ANFe: TNFe; ALogo: String = '';
                    AMarcaDagua: String = ''; ALarguraCodProd: Integer = 54;
                    AEmail: String = ''; AResumoCanhoto: Boolean = False;
                    AFax: String = ''; ANumCopias: Integer = 1;
                    ASistema: String = ''; ASite: String = '';
                    AUsuario: String = '';
                    APosCanhoto: TPosCanhoto = pcCabecalho;
                    AFormularioContinuo: Boolean = False;
                    AExpandirLogoMarca: Boolean = False;
                    AMostrarPreview: Boolean = True;
                    AFonteDANFE: TFonteDANFE = fdTimesNewRoman;
                    AMargemSuperior: Double = 0.7;
                    AMargemInferior: Double = 0.7;
                    AMargemEsquerda: Double = 0.7;
                    AMargemDireita: Double = 0.7;
                    ACasasDecimaisqCom: Integer = 4;
                    ACasasDecimaisvUncCom: Integer = 4);

    class procedure SavePDF(ANFe: TNFe; ALogo: String = '';
                    AMarcaDagua: String = ''; ALarguraCodProd: Integer = 54;
                    AEmail: String = ''; AResumoCanhoto: Boolean = False;
                    AFax: String = ''; ANumCopias: Integer = 1;
                    ASistema: String = ''; ASite: String = '';
                    AUsuario: String = ''; AFile: String = '';
                    APosCanhoto: TPosCanhoto = pcCabecalho;
                    AFormularioContinuo: Boolean = False;
                    AExpandirLogoMarca: Boolean = False;
                    AFonteDANFE: TFonteDANFE = fdTimesNewRoman;
                    AMargemSuperior: Double = 0.7;
                    AMargemInferior: Double = 0.7;
                    AMargemEsquerda: Double = 0.7;
                    AMargemDireita: Double = 0.7;
                    ACasasDecimaisqCom: Integer = 4;
                    ACasasDecimaisvUncCom: Integer = 4);
  end;

implementation

var iCopias: Integer;

{$R *.dfm}

class procedure TfrlDANFeRL.Imprimir(ANFe: TNFe; ALogo: String = '';
                AMarcaDagua: String = ''; ALarguraCodProd: Integer = 54;
                AEmail: String = ''; AResumoCanhoto: Boolean = False;
                AFax: String = ''; ANumCopias: Integer = 1;
                ASistema: String = ''; ASite: String = '';
                AUsuario: String = '';
                APosCanhoto: TPosCanhoto = pcCabecalho;
                AFormularioContinuo: Boolean = False;
                AExpandirLogoMarca: Boolean = False;
                AMostrarPreview: Boolean = True;
                AFonteDANFE: TFonteDANFE = fdTimesNewRoman;
                AMargemSuperior: Double = 0.7;
                AMargemInferior: Double = 0.7;
                AMargemEsquerda: Double = 0.7;
                AMargemDireita: Double = 0.7;
                ACasasDecimaisqCom: Integer = 4;
                ACasasDecimaisvUncCom: Integer = 4);
begin
  with Create ( nil ) do
    try
      FNFe := ANFe;
      FLogo := ALogo;
      FMarcaDagua := AMarcaDagua;
      FLarguraCodProd := ALarguraCodProd;
      FEmail := AEmail;
      FResumoCanhoto := AResumoCanhoto;
      FFax := AFax;
      FNumCopias := ANumCopias;
      FSsitema := ASistema;
      FSite := ASite;
      FUsuario := AUsuario;
      FPosCanhoto := APosCanhoto;
      FFormularioContinuo := AFormularioContinuo;
      FExpandirLogoMarca := AExpandirLogoMarca;
      FMostrarPreview := AMostrarPreview;
      FFonteDANFE := AFonteDANFE;
      FMargemSuperior := AMargemSuperior;
      FMargemInferior := AMargemInferior;
      FMargemEsquerda := AMargemEsquerda;
      FMargemDireita := AMargemDireita;
      FCasasDecimaisqCom := ACasasDecimaisqCom;
      FCasasDecimaisvUnCom := ACasasDecimaisvUncCom;

      for iCopias := 1 to FNumCopias do
        if FMostrarPreview = True then
          RLNFe.PreviewModal
        else
          RLNFe.Print;

    finally
      Free ;
    end ;
end;

class procedure TfrlDANFeRL.SavePDF(ANFe: TNFe; ALogo: String = '';
                    AMarcaDagua: String = ''; ALarguraCodProd: Integer = 54;
                    AEmail: String = ''; AResumoCanhoto: Boolean = False;
                    AFax: String = ''; ANumCopias: Integer = 1;
                    ASistema: String = ''; ASite: String = '';
                    AUsuario: String = '' ; AFile: String = '';
                    APosCanhoto: TPosCanhoto = pcCabecalho;
                    AFormularioContinuo: Boolean = False;
                    AExpandirLogoMarca: Boolean = False;
                    AFonteDANFE: TFonteDANFE = fdTimesNewRoman;
                    AMargemSuperior: Double = 0.7;
                    AMargemInferior: Double = 0.7;
                    AMargemEsquerda: Double = 0.7;
                    AMargemDireita: Double = 0.7;
                    ACasasDecimaisqCom: Integer = 4;
                    ACasasDecimaisvUncCom: Integer = 4);

begin
  with Create ( nil ) do
    try
      FNFe := ANFe;
      FLogo := ALogo;
      FMarcaDagua := AMarcaDagua;
      FLarguraCodProd := ALarguraCodProd;
      FEmail := AEmail;
      FResumoCanhoto := AResumoCanhoto;
      FFax := AFax;
      FNumCopias := ANumCopias;
      FSsitema := ASistema;
      FSite := ASite;
      FUsuario := AUsuario;
      FPosCanhoto := APosCanhoto;
      FFormularioContinuo := AFormularioContinuo;
      FExpandirLogoMarca := AExpandirLogoMarca;
      FFonteDANFE := AFonteDANFE;
      FMargemSuperior := AMargemSuperior;
      FMargemInferior := AMargemInferior;
      FMargemEsquerda := AMargemEsquerda;
      FMargemDireita := AMargemDireita;
      FCasasDecimaisqCom := ACasasDecimaisqCom;
      FCasasDecimaisvUnCom := ACasasDecimaisvUncCom;
      RLNFe.SaveToFile(AFile);
    finally
      Free ;
    end ;
end;

end.
