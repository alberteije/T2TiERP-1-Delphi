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
unit ACBrDANFeCBRave;

interface

uses Graphics, Forms, Windows, SysUtils, Classes,
     Variants, DBClient, Math, StdCtrls, DB, Dialogs,
     Controls, ExtCtrls, Mask, jpeg, MaskUtils,
     RpDefine, RpBase, RpSystem, RpBars, RpMemo,
     RpRenderText, RpRenderRTF, RpRenderHTML, RpRender, RpRenderPDF,
     ACBrNFe, ACBrNFeUtil, pcnConversao, pcnNFe;

const aHeigthPadrao:Double=5.7;
      FontSizeIdentDoc_DANFE:Integer=12;
      FontSizeIdentDoc_TipoOperacao:Integer=8;
      FontSizeEmit_Nome:Integer=12;
      FontSizeEmit_Outros:Integer=8;
      FontSizeItens:Integer=6;
      FontSizeInfComplementares:Integer=6;

      ColsTitle:array[1..17] of String=('CÓDIGO','DESCRIÇÃO DO PRODUTO / SERVIÇO','NCM/SH','CST','CFOP','UNID','QUANT.','VALOR','VALOR','VALOR','B.CÁLC.','B.CÁLC.ICMS','VAL.ICMS','VALOR','VALOR','ALÍQ.','ALÍQ.');
      ColsTitleAux:array[1..17] of String=('','','','','','','','UNITÁRIO','TOTAL','DESC.','DO ICMS','SUBST.TRIB.','SUBST.TRIB.','ICMS','IPI','ICMS','IPI');
      ColsAlingment:array[1..17] of TPrintJustify=(pjCenter,pjLeft,pjCenter,pjCenter,pjCenter,pjCenter,pjRight,pjRight,pjRight,pjRight,pjRight,pjRight,pjRight,pjRight,pjRight,pjCenter,pjCenter);

type
  TTipoSaida=(tsPrint,tsPreview,tsPDF,tsText,tsHTML,tsRTF);
  TFlagsShowLine=Set of (fsTop,fsBottom,fsLeft,fsRigth);

  TDANFeRave = class(TRvSystem)
     procedure RaveBeforePrint(Sender: TObject);
     procedure RaveDecodeImage(Sender: TObject; ImageStream: TStream;
                  ImageType: String; Bitmap: Graphics.TBitmap);
     procedure RavePrint(Sender: TObject);
  private
     FACBrNFe:TACBrNFe;
     FEmail:String;
     FSite:string;
     FFax:String;
     FSistema:String;
     FUsuario:String;
     FLogoMarca:TJPEGImage;
     FImpressora:String;
     FProtocoloNFe:String;
     FCasasDecimais_qCom:integer;
     FCasasDecimais_vUnCom:integer;
     FMask_qCom:String;
     FMask_UnCom:String;
     FExibirResumoCanhoto:boolean;
     FExibirResumoCanhoto_Texto:string;
     FImprimirDescPorc: boolean;
     FImprimirValorLiquido: boolean;
     FImprimirDetalhamentoEspecifico: boolean;
     FTamanhoCampoCodigo:integer;
     FTamanhoFonte_DemaisCampos:integer;
     FTamanhoFonte_ANTT:integer;
     FLinhasPorPagina: Integer;
     FEspessuraBorda:integer;
     FFormularioContinuo: boolean;
     FExpandirLogoMarca: boolean;
     FMostrarStatus: Boolean;
     FNFeCancelada: Boolean;
  public
     FCurrentPage, FPageNum, FNFIndex, FNumNFe:Integer;
     FChaveNFe, FNumeroNF, FSerie: String;
     FEspelho:Boolean;
     FMemoInfCpl:TMemoBuf;
     FDetIndex:Integer;
     FLastItens:Double;
     FFirstX,FFirstY,FLastX,FLastY:double;
     FontNameUsed : String;
     FontSizeIdentDoc_Outros : Integer;
     FColorBorders:TColor;
     constructor Create(AOwner:TComponent); override;
     destructor Destroy; override;
     function GetFontHeigh:Double;
     procedure SetFontTitle;
     procedure SetFontText;
     procedure Box(FlagsHideLine:TFlagsShowLine;aX,aY:Double; aWith,aHeight:Double;aTitle:String='';aText:String='';aAlignment:TAlignment=taLeftJustify;PositionNewLine:Boolean=False;Zebrado:Boolean=False;LarguraAutomatica:Boolean=True);
     function IsPrintAllProd:boolean;
     function IsPrintAllInfCpl:boolean;
     property ACBrNFe:TACBrNFe read FACBrNFe write FACBrNFe;
     property EmailDoEmitente:String read FEmail write FEmail;
     property SiteDoEmitente:String read FSite write FSite;
     property FaxDoEmitente:String read FFax write FFax;
     property NomeDoERP:String read FSistema write FSistema;
     property NomeDoUsuario:String read FUsuario write FUsuario;
     property LogoMarca:TJPEGImage read FLogoMarca write FLogoMarca;
     property NomeDaImpressora:String read FImpressora write FImpressora;
     property ProtocoloNFe:String read FProtocoloNFe write FProtocoloNFe;
     property CasasDecimais_qCom:integer read FCasasDecimais_qCom write FCasasDecimais_qCom;
     property CasasDecimais_vUnCom:integer read FCasasDecimais_vUnCom write FCasasDecimais_vUnCom;
     property Mask_qCom:String read FMask_qCom write FMask_qCom;
     property Mask_vUnCom:String read FMask_UnCom write FMask_UnCom;
     property ExibirResumoCanhoto:boolean read FExibirResumoCanhoto write FExibirResumoCanhoto;
     property ExibirResumoCanhoto_Texto:string read FExibirResumoCanhoto_Texto write FExibirResumoCanhoto_Texto;
     property ImprimirDescPorc:boolean read FImprimirDescPorc write FImprimirDescPorc;
     property ImprimirValorLiquido:boolean read FImprimirValorLiquido write FImprimirValorLiquido;
     property ImprimirDetalhamentoEspecifico:boolean read FImprimirDetalhamentoEspecifico write FImprimirDetalhamentoEspecifico;
     property TamanhoCampoCodigo:integer read FTamanhoCampoCodigo write FTamanhoCampoCodigo;
     property TamanhoFonte_DemaisCampos:integer read FTamanhoFonte_DemaisCampos write FTamanhoFonte_DemaisCampos;
     property TamanhoFonte_ANTT:integer read FTamanhoFonte_ANTT write FTamanhoFonte_ANTT;
     property LinhasPorPagina:integer read FLinhasPorPagina write FLinhasPorPagina;
     property EspessuraBorda:integer read FEspessuraBorda write FEspessuraBorda;
     property FormularioContinuo:boolean read FFormularioContinuo write FFormularioContinuo;
     property ExpandirLogoMarca:boolean read FExpandirLogoMarca write FExpandirLogoMarca default false;
     property MostrarStatus:boolean read FMostrarStatus write FMostrarStatus default true;
     property NFeCancelada:boolean read FNFeCancelada write FNFeCancelada default false;
  end;

procedure ImprimirDANFeRave(aACBrNFe:TACBrNFe;
                            aSite,
                            aEmail,
                            aFax,
                            aNomeDoERP,
                            aNomeDoUsuario:String;
                            aProtocoloNFe:String;
                            aLogoMarca:TJPEGImage;
                            aOrientacaoPapel:TOrientation;
                            aOpcaoDeSaida:TTipoSaida=tsPreview;
                            aMostrarStatus:boolean=true;
                            aNumeroDeCopias:Integer=1;
                            aNomeImpressora:string='';
                            aArquivoSaida:String='';
                            aMargemInferior:double=8;
                            aMargemSuperior:double=8;
                            aMargemEsquerda:double=6;
                            aMargemDireita:double=5.1;
                            aCasasDecimais_qCom:integer=2;
                            aCasasDecimais_vUnCom:integer=2;
                            aMask_qCom:String='';
                            aMask_vUnCom:String='';
                            aTamanhoCampoCodigo:integer=0;
                            aTamanhoFonte_DemaisCampos:integer=10;
                            aTamanhoFonte_ANTT:integer=10;
                            aProdutosPorPagina:integer=0;
                            aEspessuraBorda:integer=2;
                            aExibirResumoCanhoto:boolean=false;
                            aExibirResumoCanhoto_Texto:string='';
                            aImprimirDescPorc:boolean=false;
                            aImprimirValorLiquido:boolean=false;
                            aImprimirDetalhamentoEspecifico:boolean=true;
                            aFormularioContinuo:boolean=false;
                            aExpadirLogoMarca:boolean=false;
                            aNFeCancelada:boolean=false;
                            NFE : TNFe = nil);

var DANFeRave:TDANFeRave;

implementation

uses ACBrDANFeCBRavePaisagem, ACBrDANFeCBRaveRetrato, ACBrNFeDANFERaveCB;

procedure ImprimirDANFeRave(aACBrNFe:TACBrNFe;
                            aSite,
                            aEmail,
                            aFax,
                            aNomeDoERP,
                            aNomeDoUsuario:String;
                            aProtocoloNFe:String;
                            aLogoMarca:TJPEGImage;
                            aOrientacaoPapel:TOrientation;
                            aOpcaoDeSaida:TTipoSaida=tsPreview;
                            aMostrarStatus:boolean=true;
                            aNumeroDeCopias:Integer=1;
                            aNomeImpressora:string='';
                            aArquivoSaida:String='';
                            aMargemInferior:double=8;
                            aMargemSuperior:double=8;
                            aMargemEsquerda:double=6;
                            aMargemDireita:double=5.1;
                            aCasasDecimais_qCom:integer=2;
                            aCasasDecimais_vUnCom:integer=2;
                            aMask_qCom:String='';
                            aMask_vUnCom:String='';
                            aTamanhoCampoCodigo:integer=0;
                            aTamanhoFonte_DemaisCampos:integer=10;
                            aTamanhoFonte_ANTT:integer=10;
                            aProdutosPorPagina:integer=0;
                            aEspessuraBorda:integer=2;
                            aExibirResumoCanhoto:boolean=false;
                            aExibirResumoCanhoto_Texto:string='';
                            aImprimirDescPorc:boolean=false;
                            aImprimirValorLiquido:boolean=false;
                            aImprimirDetalhamentoEspecifico:boolean=true;
                            aFormularioContinuo:boolean=false;
                            aExpadirLogoMarca:boolean=false;
                            aNFeCancelada:boolean=false;
                            NFE : TNFe = nil);
var DANFeRave:TDANFeRave;
    rvPDF:TRvRenderPDF;
    rvTXT:TRvRenderText;
    rvHTML:TRvRenderHTML;
    rvRTF:TRvRenderRTF;
    i : Integer;
begin
  DANFeRave:=TDANFeRave.Create(nil);
  DANFeRave.ACBrNFe := aACBrNFe;
  DANFeRave.FNumNFe := -1;

  if NFE <> nil then
   begin
     for i:=0 to TACBrNFe(aACBrNFe).NotasFiscais.count-1 do
      begin
         if TACBrNFe(aACBrNFe).NotasFiscais.Items[i].NFe.infNFe.ID = NFE.infNFe.ID then
            DANFeRave.FNumNFe := i;
      end;
   end;

  if TACBrNFeDANFERaveCB(aACBrNFe.DANFE).Fonte = ftCourier then
     DANFeRave.FontNameUsed := 'Courier New'
  else
     DANFeRave.FontNameUsed := 'Times New Roman';
  DANFeRave.FontSizeIdentDoc_Outros := NotaUtil.SeSenao(Pos('Courier',DANFeRave.FontNameUsed)>0,9,10);

  rvPDF:=TRvRenderPDF.Create(DANFeRave);
  rvPDF.OnDecodeImage:=DANFeRave.RaveDecodeImage;
  rvTXT:=TRvRenderText.Create(DANFeRave);
  rvHTML:=TRvRenderHTML.Create(DANFeRave);
  rvHTML.OnDecodeImage:=DANFeRave.RaveDecodeImage;
  rvRTF:=TRvRenderRTF.Create(DANFeRave);
  rvRTF.OnDecodeImage:=DANFeRave.RaveDecodeImage;
  try
    rvPDF.EmbedFonts:=False;
    rvPDF.ImageQuality:=90;
    rvPDF.MetafileDPI:=300;
    rvPDF.UseCompression:=False;
    rvPDF.Active:=True;
    DANFeRave.EmailDoEmitente:=aEmail;
    DANFeRave.SiteDoEmitente:=aSite;
    DANFeRave.FaxDoEmitente:=aFax;
    DANFeRave.NomeDoERP:=aNomeDoERP;
    DANFeRave.NomeDoUsuario:=aNomeDoUsuario;
    DANFeRave.ProtocoloNFe:=aProtocoloNFe;
    DANFeRave.SystemPrinter.MarginTop:=aMargemSuperior;
    DANFeRave.SystemPrinter.MarginBottom:=aMargemInferior;
    DANFeRave.SystemPrinter.MarginLeft:=aMargemEsquerda;
    DANFeRave.SystemPrinter.MarginRight:=aMargemDireita;
    DANFeRave.CasasDecimais_qCom:=aCasasDecimais_qCom;
    DANFeRave.CasasDecimais_vUnCom:=aCasasDecimais_vUnCom;
    DANFeRave.Mask_qCom:=aMask_qCom;
    DANFeRave.Mask_vUnCom:=aMask_vUnCom;
    DANFeRave.TamanhoCampoCodigo:=aTamanhoCampoCodigo;
    DANFeRave.TamanhoFonte_DemaisCampos:=aTamanhoFonte_DemaisCampos;
    DANFeRave.TamanhoFonte_ANTT:=aTamanhoFonte_ANTT;
    DANFeRave.LinhasPorPagina:=aProdutosPorPagina;
    DANFeRave.EspessuraBorda:=aEspessuraBorda;
    DANFeRave.ExibirResumoCanhoto:=aExibirResumoCanhoto;
    DANFeRave.ExibirResumoCanhoto_Texto:=aExibirResumoCanhoto_Texto;
    DANFeRave.ImprimirDescPorc:=aImprimirDescPorc;
    DANFeRave.ImprimirValorLiquido:=aImprimirValorLiquido;
    DANFeRave.ImprimirDetalhamentoEspecifico:=aImprimirDetalhamentoEspecifico;
    DANFeRave.FormularioContinuo:=aFormularioContinuo;
    if aFormularioContinuo then
       DANFeRave.FColorBorders:=clWhite
      else
       DANFeRave.FColorBorders:=clBlack;
    DANFeRave.ExpandirLogoMarca:=aExpadirLogoMarca;
    DANFeRave.NFeCancelada:=aNFeCancelada;

    if aLogoMarca<>nil then
     begin
       DANFeRave.LogoMarca:=TJPEGImage.Create;
       DANFeRave.LogoMarca.Assign(aLogoMarca);
     end;
    DANFeRave.NomeDaImpressora:=aNomeImpressora;
    DANFeRave.TitlePreview:='Visualizar DANFE';
    DANFeRave.TitleSetup:='Configurações';
    DANFeRave.TitleStatus:='Status da Impressão';
    DANFeRave.SystemFiler.StatusFormat:='Gerando página %p';
    DANFeRave.SystemFiler.StreamMode:=smTempFile;
    DANFeRave.SystemOptions:=[soShowStatus,soAllowPrintFromPreview,{soAllowSaveFromPreview,}soPreviewModal];
    if not aMostrarStatus then
       DANFeRave.SystemOptions:=DANFeRave.SystemOptions - [soShowStatus];
    DANFeRave.SystemPreview.FormState:=wsMaximized;
    DANFeRave.SystemPreview.ZoomFactor:=100;
    DANFeRave.SystemPrinter.Copies:=aNumeroDeCopias;
    DANFeRave.SystemPrinter.LinesPerInch:=20;
    DANFeRave.SystemPrinter.StatusFormat:='Imprimindo página %p';
    DANFeRave.SystemPrinter.Title:='NFe - Impressão do DANFE';
    DANFeRave.SystemPrinter.Units:=unMM;
    //DANFeRave.SystemPrinter.Collate := True;
    DANFeRave.SystemPrinter.UnitsFactor:=25.4;
    DANFeRave.SystemPrinter.Orientation:=aOrientacaoPapel;
    DANFeRave.SystemSetups:=[ssAllowCopies,ssAllowCollate,ssAllowDuplex,ssAllowDestPreview,ssAllowDestPrinter,ssAllowDestFile,ssAllowPrinterSetup,ssAllowPreviewSetup];
    case aOpcaoDeSaida of
       tsPrint: DANFeRave.DefaultDest:=rdPrinter;
       tsPreview: DANFeRave.DefaultDest:=rdPreview;
      else begin
       DANFeRave.DefaultDest:=rdFile;
       DANFeRave.DoNativeOutput:= False;
       DANFeRave.OutputFileName:= aArquivoSaida;
       case aOpcaoDeSaida of
          tsPDF: DANFeRave.RenderObject:=rvPDF;
          tsText: DANFeRave.RenderObject:=rvTXT;
          tsHTML: DANFeRave.RenderObject:=rvHTML;
          tsRTF: DANFeRave.RenderObject:=rvRTF;
       end;
      end
    end;
    DANFeRave.Execute;
  finally
    FreeAndNil(rvPDF);
    FreeAndNil(rvTXT);
    FreeAndNil(rvHTML);
    FreeAndNil(rvRTF);
    FreeAndNil(DANFeRave);
  end;
end;

{ TDANFeRave }

function TDANFeRave.GetFontHeigh: Double;
var X,Y:Double;
begin
  with BaseReport do begin
    X:=XPos;Y:=YPos;
    GotoXY(PageWidth+PageWidth,PageHeight+PageHeight);
    FontColor:=clWhite;
    Print('A');
    Result:=FontHeight;
    FontColor:=clBlack;
    GotoXY(X,Y);
  end;
end;

procedure TDANFeRave.Box(FlagsHideLine:TFlagsShowLine;aX, aY, aWith, aHeight: Double; aTitle,
  aText: String; aAlignment: TAlignment; PositionNewLine,
  Zebrado, LarguraAutomatica: Boolean);
var XX,YY:Double;
    printAlingment:TPrintJustify;
begin
  with BaseReport do begin
    XX:=aX; YY:=aY;
    if (PositionNewLine) and (LarguraAutomatica) then
       aWith:=FLastX-XX;
    if not (fsTop in FlagsHideLine) then begin
       MoveTo(aX,aY);
       LineTo(aX+aWith,aY);
    end;
    if not (fsBottom in FlagsHideLine) then begin
       MoveTo(aX,aY+aHeight);
       LineTo(aX+aWith,aY+aHeight);
    end;
    if not (fsLeft in FlagsHideLine) then begin
       MoveTo(aX,aY+0.05);
       LineTo(aX,aY+aHeight-0.05);
    end;
    if not (fsRigth in FlagsHideLine) then begin
       MoveTo(aX+aWith,aY+0.05);
       LineTo(aX+aWith,aY+aHeight-0.05);
    end;

    if aTitle<>'' then begin
       SetFontTitle;
       GotoXY(XX,YY);
       NewLine;
       PrintXY(XX+1,YPos-0.4,NotaUtil.UpperCase2(aTitle)); //deixa maiusculo
       NewLine;
       SetFontText;
       GotoXY(XPos,YPos+0.4);
       case aAlignment of
         taRightJustify : printAlingment:=pjRight;
         taCenter       : printAlingment:=pjCenter;
        else
         printAlingment:=pjLeft;
       end;
       ClearAllTabs;
       SetTab(XX+1,printAlingment,aWith-2,0,0,NotaUtil.SeSenao(Zebrado,15,0));
       aText:=Trim(aText);
       PrintTab(aText);
       Bold:=False;
    end;
    if PositionNewLine then
       GotoXY(aX+aWith-aDiferentWidth,aY+aHeight-aDiferentHeigth)
      else
       GotoXY(aX+aWith-aDiferentWidth,aY);
  end;
end;

constructor TDANFeRave.Create(AOwner: TComponent);
begin
  inherited;
  FMemoInfCpl:=TMemoBuf.Create;
  OnPrint:=RavePrint;
  OnBeforePrint:=RaveBeforePrint;
  OnDecodeImage:=RaveDecodeImage;
end;

destructor TDANFeRave.Destroy;
begin
  FLogoMarca.Free;
  FMemoInfCpl.Free;
  inherited;
end;

procedure TDANFeRave.RaveBeforePrint(Sender: TObject);
begin
  with BaseReport do begin
    if Trim(FImpressora)<>'' then
       SelectPrinter(FImpressora);
    SelectPaper('A4');
    SetPaperSize(DMPAPER_A4,0,0);
    Orientation:=SystemPrinter.Orientation;
    FFirstX:=SystemPrinter.MarginLeft;
    FLastX:=BaseReport.PageWidth-SystemPrinter.MarginRight;
    FFirstY:=SystemPrinter.MarginTop;
    FLastY:=BaseReport.PageHeight-SystemPrinter.MarginBottom;
  end;
end;

procedure TDANFeRave.RaveDecodeImage(Sender: TObject; ImageStream: TStream;
  ImageType: String; Bitmap: Graphics.TBitmap);
var Image: TJPEGImage;
begin
  If ImageType = 'JPG' then begin
    Image := TJPEGImage.Create; // Create a TJPEGImage class
    try
      Image.LoadFromStream(ImageStream); // Load up JPEG image from ImageStream
      Image.DIBNeeded; // Convert JPEG to bitmap format
      Bitmap.Assign(Image);
    finally
      Image.Free;
    end;
  end;
end;

procedure TDANFeRave.RavePrint(Sender: TObject);
var i:Integer;
    VarNumPage:String;
begin
  with BaseReport  do begin
    FNFIndex:=0;
    FCurrentPage:=0;
    if FNumNFe > -1 then
       FNFIndex := FNumNFe;
    while FNFIndex<FACBrNFe.NotasFiscais.Count do
     begin
       FPageNum:=0;
       FMemoInfCpl.Text:='';

       if (FNFIndex>0) and (FNumNFe=-1) then
          NewPage;

       if Orientation=poLandScape then
          ImprimirPaisagem(Self)
       else
          ImprimirRetrato(Self);

       for i:=FPageNum downto 1 do
        begin
          VarNumPage:='PAGE'+FormatFloat('000000',FCurrentPage-(FPageNum-i));
          SetPIVar(VarNumPage,IntToStr(i)+'/'+IntToStr(FPageNum));
        end;
       if FNumNFe > -1 then
          FNFIndex := FACBrNFe.NotasFiscais.Count;

       Inc(FNFIndex);
     end;
  end;
end;

procedure TDANFeRave.SetFontText;
begin
  if FontSizeText = 0 then
     FontSizeText := TamanhoFonte_DemaisCampos;
  BaseReport.SetFont(FontNameUsed,FontSizeText);
end;

procedure TDANFeRave.SetFontTitle;
begin
  BaseReport.SetFont(FontNameUsed,FontSizeTitle)
end;

function TDANFeRave.IsPrintAllProd: boolean;
begin
  Result:=FDetIndex>=ACBrNFe.NotasFiscais.Items[FNFIndex].NFe.Det.Count;
end;

function TDANFeRave.IsPrintAllInfCpl: boolean;
begin
  Result:=FMemoInfCpl.Empty;
end;

end.

