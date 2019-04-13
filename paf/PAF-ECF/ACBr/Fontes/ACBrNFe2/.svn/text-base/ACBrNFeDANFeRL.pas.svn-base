{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }
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
|*  - Acréscimo dos parâmetros "AMargemSuperior", "AMargemInferior",
|*    "AMargemEsqurda", "AMargemDireita" e "AFonteDANFE"
|* 13/04/2010: Peterson de Cerqueira Matos
|*  - Adequação à NF-e 2.0, Manual de Integração do Contribuinte 4.0.1NT2009.006
|*  - Tratamento das casas decimais em "ACBrNFeDANFeClass"
|*  - Acréscimo dos parâmetros "ACasasDecimaisqCom" e "ACasasDecimaisvUnCom"
|* 06/07/2010: Peterson de Cerqueira Matos
|*  - Tratamento do formato de impressão e da quantidade de produtos por
|*  - página em "ACBrNFeDANFeClass"
|*  - Acréscimo dos parâmetros "ATipoDANFE" e "AProdutosPorPagina"
|* 20/07/2010: Peterson de Cerqueira Matos
|*  - Permite enviar o DANFe para a impressora informada em "Impressora"
|*  - Acréscimo do parâmetro "AImpressora"
|* 10/08/2010: Peterson de Cerqueira Matos
|*  - Acréscimo do parâmetro "ATamanhoFonte_RazaoSocial"
|* 25/11/2010: Peterson de Cerqueira Matos
|*  - Acréscimo do parâmetro "AExibirEAN"
|* 01/03/2011: Fernando Emiliano David Nunes
|*  - Acréscimo do parâmetro "AProtocoloNFe"
|* 20/05/2011: Peterson de Cerqueira Matos
|*  - Acréscimo do parâmetro "AResumoCanhoto_Texto"
|* 23/05/2011: Waldir Paim
|*  - Início da preparação para Lazarus: Somente utiliza TClientDataSet quando
|*    estiver no Delphi. Obrigatória a utilização da versão 3.70B ou superior
|*    do Fortes Report. Download disponível em
|*    http://sourceforge.net/projects/fortesreport/files/
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
  RLReport, pcnNFe, pcnConversao, ACBrNFe, RLFilters, MaskUtils, RLPrinters,
  RLPDFFilter, DB, {$IFDEF BORLAND} DBClient{$ELSE} DBClient{$ENDIF},RLConsts;
    
type
  TPosCanhoto = (pcCabecalho, pcRodape);
  TFonteDANFE = (fdTimesNewRoman, fdCourierNew, fdArial);
type
  TfrlDANFeRL = class(TForm)
    RLNFe: TRLReport;
    DataSource1: TDataSource;
    RLPDFFilter1: TRLPDFFilter;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    FProdutosPorPagina: Integer;
    FImpressora: String;
    FTamanhoFonte_RazaoSocial: Integer;
    FExibirEAN: Boolean;
    FProtocoloNFe : String;
    FResumoCanhoto_Texto: String;
    cdsItens: TClientDataSet;
    procedure ConfigDataSet;
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
                    ACasasDecimaisvUncCom: Integer = 4;
                    AProdutosPorPagina: Integer = 0;
                    AImpressora: String = '';
                    ATamanhoFonte_RazaoSocial: Integer = 8;
                    AExibirEAN: Boolean = False;
                    AProtocoloNFe: String = '';
                    AResumoCanhoto_Texto: String = '');

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
                    ACasasDecimaisvUncCom: Integer = 4;
                    AProdutosPorPagina: Integer = 0;
                    ATamanhoFonte_RazaoSocial: Integer = 8;
                    AExibirEAN: Boolean = False;
                    AProtocoloNFe: String = '';
                    AResumoCanhoto_Texto: String = '');
  end;

   const
    sDisplayFormat = '###,###,###,##0.%.*d';

implementation


{$R *.dfm}

procedure TfrlDANFeRL.ConfigDataSet;
begin
 if not Assigned( cdsItens ) then
 cdsItens:=  {$IFDEF BORLAND}  TClientDataSet.create(nil)  {$ELSE}  TClientDataSet.create(nil) {$ENDIF};

  if cdsItens.Active then
 begin
 {$IFDEF BORLAND}
  if cdsItens is TClientDataSet then
  TClientDataSet(cdsItens).EmptyDataSet;
 {$ENDIF}
  cdsItens.Active := False;
 end;

 {$IFDEF BORLAND}
 if cdsItens is TClientDataSet then
  begin
  TClientDataSet(cdsItens).StoreDefs := False;
  TClientDataSet(cdsItens).IndexDefs.Clear;
  TClientDataSet(cdsItens).IndexFieldNames := '';
  TClientDataSet(cdsItens).IndexName := '';
  TClientDataSet(cdsItens).Aggregates.Clear;
  TClientDataSet(cdsItens).AggFields.Clear;
  end;
 {$ENDIF}


 with cdsItens do
  if FieldCount = 0 then
  begin
    FieldDefs.Clear;
    Fields.Clear;
    FieldDefs.Add('CODIGO',ftString,60);
    FieldDefs.Add('EAN',ftString,14);
    FieldDefs.Add('DESCRICAO',ftString,120);
    FieldDefs.Add('NCM',ftString,8);
    FieldDefs.Add('CFOP',ftString,4);
    FieldDefs.Add('UNIDADE',ftString,6);
    FieldDefs.Add('QTDE',ftString,18);
    FieldDefs.Add('VALOR',ftString,18);
    FieldDefs.Add('VALORDESC',ftString,18);
    FieldDefs.Add('TOTAL',ftString,18);
    FieldDefs.Add('CST',ftString,3);
    FieldDefs.Add('CSOSN',ftString,4);
    FieldDefs.Add('BICMS',ftString,18);
    FieldDefs.Add('ALIQICMS',ftString,6);
    FieldDefs.Add('VALORICMS',ftString,18);
    FieldDefs.Add('ALIQIPI',ftString,6);
    FieldDefs.Add('VALORIPI',ftString,18);

   {$IFDEF BORLAND}
    if cdsItens is TClientDataSet then
    TClientDataSet(cdsItens).CreateDataSet;
   {$ENDIF}

   end;

 {$IFDEF BORLAND}
  if cdsItens is TClientDataSet then
  TClientDataSet(cdsItens).StoreDefs := False;
 {$ENDIF}

   if not cdsItens.Active then
   cdsItens.Active := True;

  {$IFDEF BORLAND}
   if cdsItens is TClientDataSet then
   if cdsItens.Active then
   TClientDataSet(cdsItens).LogChanges := False;
 {$ENDIF}

 DataSource1.dataset := cdsItens;
 
end;

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
                ACasasDecimaisvUncCom: Integer = 4;
                AProdutosPorPagina: Integer = 0;
                AImpressora: String = '';
                ATamanhoFonte_RazaoSocial: Integer = 8;
                AExibirEAN: Boolean = False;
                AProtocoloNFe: String = '';
                AResumoCanhoto_Texto: String = '');

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
      FProdutosPorPagina := AProdutosPorPagina;
      FImpressora := AImpressora;
      FTamanhoFonte_RazaoSocial := ATamanhoFonte_RazaoSocial;
      FExibirEAN := AExibirEAN;
      FProtocoloNFe := AProtocoloNFe;
      FResumoCanhoto_Texto := AResumoCanhoto_Texto;

      if FImpressora > '' then
        RLPrinter.PrinterName := FImpressora;

      if FNumCopias > 0 then
        RLPrinter.Copies := FNumCopias
      else
        RLPrinter.Copies := 1;

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
                    ACasasDecimaisvUncCom: Integer = 4;
                    AProdutosPorPagina: Integer = 0;
                    ATamanhoFonte_RazaoSocial: Integer = 8;
                    AExibirEAN: Boolean = False;
                    AProtocoloNFe: String = '';
                    AResumoCanhoto_Texto: String = '');
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
      FProdutosPorPagina := AProdutosPorPagina;
      FTamanhoFonte_RazaoSocial := ATamanhoFonte_RazaoSocial;
      FExibirEAN := AExibirEAN;
      FProtocoloNFe := AProtocoloNFe;
      FResumoCanhoto_Texto := AResumoCanhoto_Texto;

      with RLPDFFilter1.DocumentInfo do
        begin
          Title := 'DANFE - Nota fiscal nº ' +
                                      FormatFloat('000,000,000', FNFe.Ide.nNF);
          KeyWords := 'Número:' + FormatFloat('000,000,000', FNFe.Ide.nNF) +
                      '; Data de emissão: ' + FormatDateTime('dd/mm/yyyy', FNFe.Ide.dEmi) +
                      '; Destinatário: ' + FNFe.Dest.xNome +
                      '; CNPJ: ' + FNFe.Dest.CNPJCPF +
                      '; Valor total: ' + FormatFloat('###,###,###,###,##0.00', FNFe.Total.ICMSTot.vNF);
        end;

      RLNFe.SaveToFile(AFile);
    finally
      Free ;
    end ;
end;

procedure TfrlDANFeRL.FormDestroy(Sender: TObject);
begin
  FreeAndNil( cdsItens );
end;

procedure TfrlDANFeRL.FormCreate(Sender: TObject);
begin
  ConfigDataSet;
end;

end.
