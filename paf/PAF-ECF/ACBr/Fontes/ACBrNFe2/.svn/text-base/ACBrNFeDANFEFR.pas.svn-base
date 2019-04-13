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
|* 11/08/2010: Itamar Luiz Bermond
|*  - Inicio do desenvolvimento
|* 24/08/2010: Régys Silveira
|*  - Acerto da exportação para PDF
|*  - Acerto para checar se o relatório foi realmente preparado
|     antes de continuar a imprir ou gerar o PDF
|*  - Acerto nas propriedades do arquivo PDF
|* 26/08/2010: Régys Silveira / Itamar Bermond
|*  - Acerto na propriedade "PreparedReport"
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeDANFEFR;

interface

uses
  Forms, SysUtils, Classes, Graphics, ACBrNFeDANFEClass, ACBrNFeDANFEFRDM,
  pcnNFe, pcnConversao, frxClass;

type
  EACBrNFeDANFEFR = class(Exception);

  TACBrNFeDANFEFR = class( TACBrNFeDANFEClass )
   private
    FdmDanfe: TdmACBrNFeFR;
    FFastFile: String;
    FEspessuraBorda: Integer;
    function GetPreparedReport: TfrxReport;
    function PrepareReport(NFE: TNFe = nil): Boolean;
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE: TNFe = nil); override;
    procedure ImprimirDANFEPDF(NFE: TNFe = nil); override;
  published
    property FastFile: String read FFastFile write FFastFile;
    property dmDanfe: TdmACBrNFeFR read FdmDanfe write FdmDanfe;
    property EspessuraBorda: Integer read FEspessuraBorda write FEspessuraBorda;
    property PreparedReport: TfrxReport read GetPreparedReport;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil, StrUtils, Dialogs;

constructor TACBrNFeDANFEFR.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
  FdmDanfe := TdmACBrNFeFR.Create(Self);
  FFastFile := '' ;
  FEspessuraBorda := 1;
end;

destructor TACBrNFeDANFEFR.Destroy;
begin
  dmDanfe.Free;
  inherited Destroy;
end;

function TACBrNFeDANFEFR.GetPreparedReport: TfrxReport;
begin
  if Trim(FFastFile) = '' then
    Result := nil
  else
  begin
    if PrepareReport(nil) then
      Result := dmDanfe.frxReport
    else
      Result := nil;
  end;
end;

procedure TACBrNFeDANFEFR.ImprimirDANFE(NFE: TNFe);
begin
  if PrepareReport(NFE) then
  begin
    if MostrarPreview then
      dmDanfe.frxReport.ShowPreparedReport
    else
      dmDanfe.frxReport.Print;
  end;
end;

procedure TACBrNFeDANFEFR.ImprimirDANFEPDF(NFE: TNFe);
const
  TITULO_PDF = 'Nota Fiscal Eletrônica';
var
  I: Integer;
begin
  if PrepareReport(NFE) then
  begin
    dmDanfe.frxPDFExport.Author     := Sistema;
    dmDanfe.frxPDFExport.Creator    := Sistema;
    dmDanfe.frxPDFExport.Producer   := Sistema;
    dmDanfe.frxPDFExport.Title      := TITULO_PDF;
    dmDanfe.frxPDFExport.Subject    := TITULO_PDF;
    dmDanfe.frxPDFExport.Keywords   := TITULO_PDF;
    dmDanfe.frxPDFExport.ShowDialog := False;

    for I := 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count - 1 do
    begin
      dmDanfe.frxPDFExport.FileName := PathPDF + dmDanfe.NFe.procNFe.chNFe + '.pdf';
      dmDanfe.frxReport.Export(dmDanfe.frxPDFExport);
    end;
  end;
end;

function TACBrNFeDANFEFR.PrepareReport(NFE: TNFe): Boolean;
var
  i: Integer;
begin
  Result := False;

  if Trim(FastFile) <> '' then
  begin
    if FileExists(FastFile) then
      dmDanfe.frxReport.LoadFromFile(FastFile)
    else
      raise EACBrNFeDANFEFR.CreateFmt('Caminho do arquivo de impressão do DANFE "%s" inválido.', [FastFile]);
  end
  else
    raise EACBrNFeDANFEFR.Create('Caminho do arquivo de impressão do DANFE não assinalado.');

  if Assigned(NFE) then
  begin
    dmDanfe.NFe := NFE;
    dmDanfe.CarregaDados;

    Result := dmDanfe.frxReport.PrepareReport;
  end
  else
  begin
    if Assigned(ACBrNFe) then
    begin
      for i := 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count - 1 do
      begin
        dmDanfe.NFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe;
        dmDanfe.CarregaDados;

        if (i > 0) then
          Result := dmDanfe.frxReport.PrepareReport(False)
        else
          Result := dmDanfe.frxReport.PrepareReport;
      end;
    end
    else
      raise EACBrNFeDANFEFR.Create('Propriedade ACBrNFe não assinalada.');
  end;
end;

end.
