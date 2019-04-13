
{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Conhecimen-}
{ to de Transporte eletrônico - CTe - http://www.cte.fazenda.gov.br            }
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
|*  - Doação units para geração do DACTe via QuickReport
|* 06/04/2010: Italo Jurisato Junior
|*  - Acréscimo dos parâmetros "FEmail", "FResumoCanhoto", "FFax", "FNumCopias",
|*    "FSistema", "FUsuario", "FImprimeHoraSaida", "FHoraSaida",
|*    "FMargemSuperior", "FMargemInferior", "FMargemEsquerda", "FMargemDireita",
|*    nas Class procedures "Imprimir" e "SavePDF"
|*  - Habilitada a funcionalidade da procedure "SavePDF";
******************************************************************************}

{$I ACBr.inc}

unit ACBrCTeDACTeQR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls,
  {$IFDEF QReport_PDF}
     QRPDFFilt,
     // Incluido por Italo em 13/01/2011
     QRPrntr,
  {$ENDIF}
  ACBrCTeQRCodeBar, pcteCTe, ACBrCTe, ACBrCTeUtil, Printers, pcnConversao;

type

  TfrmDACTeQR = class(TForm)
    QRCTe: TQuickRep;
  private

  protected
    //BarCode : TBarCode128c;
    FACBrCTe            : TACBrCTe;
    FCTe                : TCTe;
    FLogo               : String;
    FEmail              : String;
    FImprimeHoraSaida   : Boolean;
    FHoraSaida          : String;
    FResumoCanhoto      : Boolean;
    FFax                : String;
    FNumCopias          : Integer;
    FSistema            : String;
    FUrl                : String;
    FUsuario            : String;
    AfterPreview        : Boolean;
    FExpandirLogoMarca  : Boolean;
    ChangedPos          : Boolean;
    FSemValorFiscal     : Boolean;
    FMargemSuperior     : double;
    FMargemInferior     : double;
    FMargemEsquerda     : double;
    FMargemDireita      : double;
    FImpressora         : String;  // Incluido por Italo em 27/12/2010
    FPosRecibo          : TPosRecibo;   // Incluido por Italo em 27/04/2011

    procedure qrlSemValorFiscalPrint(sender: TObject; var Value: string);
    procedure SetBarCodeImage(ACode: string; QRImage: TQRImage);
  public
    class procedure Imprimir(ACTe                : TCTe;
                             ALogo               : String    = '';
                             AEmail              : String    = '';
                             AImprimeHoraSaida   : Boolean   = False;
                             AExpandirLogoMarca  : Boolean   = False;
                             AHoraSaida          : String    = '';
                             AResumoCanhoto      : Boolean   = False;
                             AFax                : String    = '';
                             ANumCopias          : Integer   = 1;
                             ASistema            : String    = '';
                             AUrl                : String    = '';
                             AUsuario            : String    = '';
                             APreview            : Boolean   = True;
                             AMargemSuperior     : Double    = 0.8;
                             AMargemInferior     : Double    = 0.8;
                             AMargemEsquerda     : Double    = 0.6;
                             AMargemDireita      : Double    = 0.51;
                             AImpressora         : String    = '';
                             APosRecibo          : TPosRecibo = prCabecalho);

    class procedure SavePDF(AFile: String;
                            ACTe                : TCTe;
                            ALogo               : String    = '';
                            AEmail              : String    = '';
                            AImprimeHoraSaida   : Boolean   = False;
                            AExpandirLogoMarca  : Boolean   = False;
                            AHoraSaida          : String    = '';
                            AResumoCanhoto      : Boolean   = False;
                            AFax                : String    = '';
                            ANumCopias          : Integer   = 1;
                            ASistema            : String    = '';
                            AUrl                : String    = '';
                            AUsuario            : String    = '';
                            AMargemSuperior     : Double    = 0.8;
                            AMargemInferior     : Double    = 0.8;
                            AMargemEsquerda     : Double    = 0.6;
                            AMargemDireita      : Double    = 0.51;
                            APosRecibo          : TPosRecibo = prCabecalho);

  end;

implementation

uses MaskUtils;

var
  Printer: TPrinter;

{$R *.dfm}

class procedure TfrmDACTeQR.Imprimir(ACTe               : TCTe;
                                    ALogo               : String    = '';
                                    AEmail              : String    = '';
                                    AImprimeHoraSaida   : Boolean   = False;
                                    AExpandirLogoMarca  : Boolean   = False;
                                    AHoraSaida          : String    = '';
                                    AResumoCanhoto      : Boolean   = False;
                                    AFax                : String    = '';
                                    ANumCopias          : Integer   = 1;
                                    ASistema            : String    = '';
                                    AUrl                : String    = '';
                                    AUsuario            : String    = '';
                                    APreview            : Boolean   = True;
                                    AMargemSuperior     : Double    = 0.8;
                                    AMargemInferior     : Double    = 0.8;
                                    AMargemEsquerda     : Double    = 0.6;
                                    AMargemDireita      : Double    = 0.51;
                                    AImpressora         : String    = '';
                                    APosRecibo          : TPosRecibo = prCabecalho);
begin
  with Create ( nil ) do
     try
        FCTe                := ACTe;
        FLogo               := ALogo;
        FEmail              := AEmail;
        FImprimeHoraSaida   := AImprimeHoraSaida;
        FExpandirLogoMarca  := AExpandirLogoMarca;
        FHoraSaida          := AHoraSaida;
        FResumoCanhoto      := AResumoCanhoto;
        FFax                := AFax;
        FNumCopias          := ANumCopias;
        FSistema            := ASistema;
        FUrl                := AUrl;
        FUsuario            := AUsuario;
        FMargemSuperior     := AMargemSuperior;
        FMargemInferior     := AMargemInferior;
        FMargemEsquerda     := AMargemEsquerda;
        FMargemDireita      := AMargemDireita;
        FImpressora         := AImpressora;
        FPosRecibo          := APosRecibo;

        Printer := TPrinter.Create;

        if FImpressora > '' then
          QRCTe.PrinterSettings.PrinterIndex := Printer.Printers.IndexOf(FImpressora);

        if APreview then
         begin
           QRCTe.PrinterSettings.Copies := FNumCopias; // Incluido por Italo em 15/10/2010

          // Incluido por Italo em 13/01/2011
         {$IFDEF QReport_PDF}
           QRCTe.PrevShowSearch      := False;
           QRCTe.PrevShowThumbs      := False;
           QRCTe.PreviewInitialState := wsMaximized;
           QRCTe.PrevInitialZoom     := qrZoomToWidth;
         {$ENDIF}

           QRCTe.Prepare;
           QRCTe.Preview;
         end else
         begin
           AfterPreview := True;
           QRCTe.PrinterSettings.Copies := FNumCopias; // Incluido por Italo em 15/10/2010
           QRCTe.Prepare;
           QRCTe.Print;
         end;
     finally
        Free;
     end;
end;

class procedure TfrmDACTeQR.SavePDF(AFile               : String;
                                    ACTe                : TCTe;
                                    ALogo               : String    = '';
                                    AEmail              : String    = '';
                                    AImprimeHoraSaida   : Boolean   = False;
                                    AExpandirLogoMarca  : Boolean   = False;
                                    AHoraSaida          : String    = '';
                                    AResumoCanhoto      : Boolean   = False;
                                    AFax                : String    = '';
                                    ANumCopias          : Integer   = 1;
                                    ASistema            : String    = '';
                                    AUrl                : String    = '';
                                    AUsuario            : String    = '';
                                    AMargemSuperior     : Double    = 0.8;
                                    AMargemInferior     : Double    = 0.8;
                                    AMargemEsquerda     : Double    = 0.6;
                                    AMargemDireita      : Double    = 0.51;
                                    APosRecibo          : TPosRecibo = prCabecalho);
{$IFDEF QReport_PDF}
 var
  qf : TQRPDFDocumentFilter;
  i  : Integer;
{$ENDIF}
begin
{$IFDEF QReport_PDF}
  with Create ( nil ) do
     try
        FCTe                := ACTe;
        FLogo               := ALogo;
        FEmail              := AEmail;
        FImprimeHoraSaida   := AImprimeHoraSaida;
        FHoraSaida          := AHoraSaida;
        FResumoCanhoto      := AResumoCanhoto;
        FFax                := AFax;
        FNumCopias          := ANumCopias;
        FSistema            := ASistema;
        FUrl                := AUrl;
        FUsuario            := AUsuario;
        FMargemSuperior     := AMargemSuperior;
        FMargemInferior     := AMargemInferior;
        FMargemEsquerda     := AMargemEsquerda;
        FMargemDireita      := AMargemDireita;
        FExpandirLogoMarca  := AExpandirLogoMarca;
        FPosRecibo          := APosRecibo;

        for i := 0 to ComponentCount -1 do
          begin
            if (Components[i] is TQRShape) and (TQRShape(Components[i]).Shape = qrsRoundRect) then
              begin
                TQRShape(Components[i]).Shape := qrsRectangle;
                TQRShape(Components[i]).Pen.Width := 1;
              end;
          end;
        AfterPreview := True;
        QRCTe.Prepare;
        qf := TQRPDFDocumentFilter.Create(AFile);
        qf.CompressionOn := False;
        QRCTe.QRPrinter.ExportToFilter( qf );
        qf.Free;
     finally
        Free;
     end;
{$ENDIF}
end;

procedure TfrmDACTeQR.qrlSemValorFiscalPrint(sender: TObject;  var Value: string);
begin
  inherited;

  if FSemValorFiscal then
    Value := '';
end;

procedure TfrmDACTeQR.SetBarCodeImage(ACode: string; QRImage: TQRImage);
var
  b : TBarCode128c;
begin
  b := TBarCode128c.Create;
  //      Width  := QRImage.Width;
  b.Code := ACode;
  b.PaintCodeToCanvas(ACode, QRImage.Canvas, QRImage.ClientRect);
  b.free;
end;

end.

