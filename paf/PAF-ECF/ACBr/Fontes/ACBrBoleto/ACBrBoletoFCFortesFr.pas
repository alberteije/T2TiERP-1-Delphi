{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   http://www.produsys.com.br/          }
{                                                                              }
{ Colaboradores nesse arquivo:  Juliana Rodrigues Prado, Daniel Simoes Almeida }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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
|* 01/04/2010: Juliana Rodrigues Prado Tamizou
|*  - Adaptação do Boleto do Projeto RLBoleto  ( http://www.produsys.com.br/ )
******************************************************************************}
{$I ACBr.inc}

unit ACBrBoletoFCFortesFr;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, RLReport, RLBarcode,
  RLPDFFilter, RLHTMLFilter, RLPrintDialog, RLFilters, RLPrinters,
  {$IFDEF FPC}
    LResources, StdCtrls,
  {$ENDIF}
  ACBrBoleto ;

const
  CACBrBoletoFCFortes_Versao = '0.0.10a' ;

type

  { TACBrBoletoFCFortesFr }
  TACBrBoletoFCFortes = class(TACBrBoletoFCClass)
  private
    { Private declarations }
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;

    procedure Imprimir; override;
  end;

  TACBrBoletoFCFortesFr = class(TForm)
     BoletoCarne: TRLReport;
     imgBarrasCarne: TRLBarcode;
    imgCodigoBarra: TRLBarcode;
    ImgLoja: TRLImage;
    LayoutBoleto: TRLReport;
    RLDraw78: TRLDraw;
    RLLabel169: TRLLabel;
    RLLabel171: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel92: TRLLabel;
    RLLabel96: TRLLabel;
    txtDesconto5: TRLLabel;
    txtEndCedente: TRLLabel;
    txtMoraMulta4: TRLLabel;
    txtNumeroBanco: TRLLabel;
    txtTotPar: TRLLabel;
    mIntrucoes: TRLMemo;
    RLBand1: TRLBand;
    RLBand3: TRLBand;
    txtParcela: TRLLabel;
    txtCodCedenteCarne2: TRLLabel;
    txtCPFCarne2: TRLLabel;
    txtNomeSacadoCarne: TRLLabel;
    txtValorCar: TRLLabel;
    txtNossoNumCan: TRLLabel;
    txtVencCanhoto: TRLLabel;
    txtAceite: TRLLabel;
    txtCarteira: TRLLabel;
    txtCidadeSacado: TRLLabel;
    txtCodCedenteCarne: TRLLabel;
    txtCPF: TRLLabel;
    txtDataDocto: TRLLabel;
    txtDataProces: TRLLabel;
    txtEndSacado: TRLLabel;
    txtEspecieDoc: TRLLabel;
    txtLinhaDigitavelCarne: TRLLabel;
    RLDBText17: TRLDBText;
    RLDBText18: TRLDBText;
    txtLocal: TRLLabel;
    txtNomeCedente: TRLLabel;
    txtNomeSacado: TRLLabel;
    txtNossoNumeroCarne: TRLLabel;
    txtNumeroDocto: TRLLabel;
    txtValorCarne: TRLLabel;
    RLDraw29: TRLDraw;
    RLDraw30: TRLDraw;
    RLDraw31: TRLDraw;
    RLDraw32: TRLDraw;
    RLDraw39: TRLDraw;
    RLDraw38: TRLDraw;
    RLDraw37: TRLDraw;
    RLDraw34: TRLDraw;
    RLDraw28: TRLDraw;
    RLDraw27: TRLDraw;
    RLDraw26: TRLDraw;
    RLDraw25: TRLDraw;
    RLDraw24: TRLDraw;
    RLDraw21: TRLDraw;
    RLDraw23: TRLDraw;
    RLDraw22: TRLDraw;
    RLDraw20: TRLDraw;
    RLDraw19: TRLDraw;
    RLDraw18: TRLDraw;
    RLDraw17: TRLDraw;
    RLDraw16: TRLDraw;
    imgBanco2: TRLImage;
    RLDraw51: TRLDraw;
    RLDraw52: TRLDraw;
    RLDraw53: TRLDraw;
    RLDraw54: TRLDraw;
    RLDraw55: TRLDraw;
    RLDraw56: TRLDraw;
    RLDraw57: TRLDraw;
    RLDraw58: TRLDraw;
    RLDraw59: TRLDraw;
    RLDraw60: TRLDraw;
    RLDraw61: TRLDraw;
    RLDraw62: TRLDraw;
    RLDraw63: TRLDraw;
    RLDraw64: TRLDraw;
    RLDraw65: TRLDraw;
    RLDraw66: TRLDraw;
    RLDraw67: TRLDraw;
    RLDraw68: TRLDraw;
    RLDraw69: TRLDraw;
    RLDraw70: TRLDraw;
    RLDraw71: TRLDraw;
    RLHTMLFilter1: TRLHTMLFilter;
    imgBancoCarne: TRLImage;
    RLLabel1: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel101: TRLLabel;
    RLLabel103: TRLLabel;
    RLLabel105: TRLLabel;
    RLLabel107: TRLLabel;
    RLLabel109: TRLLabel;
    RLLabel111: TRLLabel;
    RLLabel113: TRLLabel;
    RLLabel115: TRLLabel;
    RLLabel117: TRLLabel;
    RLLabel119: TRLLabel;
    RLLabel121: TRLLabel;
    RLLabel123: TRLLabel;
    RLLabel124: TRLLabel;
    RLLabel126: TRLLabel;
    RLLabel128: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel130: TRLLabel;
    RLLabel132: TRLLabel;
    RLLabel135: TRLLabel;
    RLLabel138: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel36: TRLLabel;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    RLLabel42: TRLLabel;
    RLLabel43: TRLLabel;
    RLLabel44: TRLLabel;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    RLLabel48: TRLLabel;
    RLLabel49: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabel97: TRLLabel;
    RLLabel99: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    RLBand4: TRLBand;
    RLDraw14: TRLDraw;
    RLDraw8: TRLDraw;
    RLDraw12: TRLDraw;
    RLDraw6: TRLDraw;
    RLDraw9: TRLDraw;
    RLDraw7: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw73: TRLDraw;
    RLDraw13: TRLDraw;
    RLDraw10: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw5: TRLDraw;
    RLDraw11: TRLDraw;
    RLLabel2: TRLLabel;
    txtNomeCedente4: TRLLabel;
    RLLabel6: TRLLabel;
    txtCodigoCedente4: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel11: TRLLabel;
    txtNumeroDocumento4: TRLLabel;
    RLLabel14: TRLLabel;
    txtEspecie4: TRLLabel;
    RLLabel23: TRLLabel;
    txtNossoNumero4: TRLLabel;
    RLLabel33: TRLLabel;
    txtValorDocumento4: TRLLabel;
    imgBanco4: TRLImage;
    txtNumeroBanco4: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel51: TRLLabel;
    RLLabel52: TRLLabel;
    lblLocalPagto4: TRLLabel;
    RLLabel21: TRLLabel;
    txtDataVencimento4: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel25: TRLLabel;
    txtNomeSacado4: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel37: TRLLabel;
    RLLabel50: TRLLabel;
    RLLabel54: TRLLabel;
    RLLabel55: TRLLabel;
    RLLabel56: TRLLabel;
    RLLabel57: TRLLabel;
    RLDraw72: TRLDraw;
    RLDraw15: TRLDraw;
    RLLabel4: TRLLabel;
    txtDataProcessamento4: TRLLabel;

    txtNumeroBanco2: TRLLabel;
    RLLabel67: TRLLabel;
    RLLabel68: TRLLabel;
    lblLocalPagto: TRLLabel;
    RLLabel69: TRLLabel;
    txtNomeCedente2: TRLLabel;
    RLLabel70: TRLLabel;
    txtDataDocumento2: TRLLabel;
    RLLabel71: TRLLabel;
    txtNumeroDocumento2: TRLLabel;
    RLLabel72: TRLLabel;
    txtEspecieDoc2: TRLLabel;
    RLLabel73: TRLLabel;
    txtAceite2: TRLLabel;
    RLLabel74: TRLLabel;
    txtDataProcessamento2: TRLLabel;
    txtUsoBanco2: TRLLabel;
    RLLabel75: TRLLabel;
    txtCarteira2: TRLLabel;
    RLLabel76: TRLLabel;
    RLLabel77: TRLLabel;
    txtEspecie2: TRLLabel;
    RLLabel78: TRLLabel;
    txtQuantidade2: TRLLabel;
    RLLabel79: TRLLabel;
    txtValorMoeda2: TRLLabel;
    RLLabel80: TRLLabel;
    txtInstrucoes2: TRLMemo;
    RLLabel81: TRLLabel;
    txtDataVencimento2: TRLLabel;
    RLLabel82: TRLLabel;
    txtCodigoCedente2: TRLLabel;
    RLLabel83: TRLLabel;
    txtNossoNumero2: TRLLabel;
    RLLabel84: TRLLabel;
    txtValorDocumento2: TRLLabel;
    RLLabel85: TRLLabel;
    txtDesconto2: TRLLabel;
    RLLabel86: TRLLabel;
    txtMoraMulta2: TRLLabel;
    RLLabel87: TRLLabel;
    txtValorCobrado2: TRLLabel;
    RLLabel88: TRLLabel;
    txtNomeSacado2: TRLLabel;
    txtEnderecoSacado2: TRLLabel;
    txtCidadeSacado2: TRLLabel;
    RLLabel89: TRLLabel;
    txtCpfCnpjSacado2: TRLLabel;
    RLLabel90: TRLLabel;
    txtCodigoBaixa2: TRLLabel;
    RLMemo2: TRLMemo;
    RLLabel91: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel98: TRLLabel;
    RLLabel102: TRLLabel;
    txtSacadorAvalista2: TRLLabel;
    txtReferencia2: TRLLabel;
    RLBand2: TRLBand;
    RLDraw50: TRLDraw;
    RLDraw49: TRLDraw;
    RLDraw48: TRLDraw;
    RLDraw47: TRLDraw;
    RLDraw46: TRLDraw;
    RLDraw45: TRLDraw;
    RLDraw44: TRLDraw;
    RLDraw43: TRLDraw;
    RLDraw42: TRLDraw;
    RLDraw41: TRLDraw;
    RLDraw40: TRLDraw;
    RLDraw36: TRLDraw;
    RLDraw35: TRLDraw;
    RLDraw33: TRLDraw;
    imgBanco3: TRLImage;
    RLDraw81: TRLDraw;
    txtLinhaDigitavel: TRLLabel;
    RLDraw82: TRLDraw;
    txtNumeroBanco3: TRLLabel;
    RLLabel145: TRLLabel;
    txtLocalPagamento3: TRLLabel;
    txtDataVencimento3: TRLLabel;
    RLLabel146: TRLLabel;
    RLDraw83: TRLDraw;
    RLLabel147: TRLLabel;
    txtNomeCedente3: TRLLabel;
    RLLabel148: TRLLabel;
    txtCodigoCedente3: TRLLabel;
    RLLabel149: TRLLabel;
    txtDataDocumento3: TRLLabel;
    RLLabel150: TRLLabel;
    txtNumeroDocumento3: TRLLabel;
    RLLabel151: TRLLabel;
    txtEspecieDoc3: TRLLabel;
    RLLabel152: TRLLabel;
    txtAceite3: TRLLabel;
    RLLabel153: TRLLabel;
    txtDataProcessamento3: TRLLabel;
    RLLabel154: TRLLabel;
    txtNossoNumero3: TRLLabel;
    RLLabel155: TRLLabel;
    txtUsoBanco3: TRLLabel;
    RLLabel156: TRLLabel;
    txtCarteira3: TRLLabel;
    RLLabel157: TRLLabel;
    txtEspecie3: TRLLabel;
    RLLabel158: TRLLabel;
    txtQuantidade3: TRLLabel;
    RLLabel159: TRLLabel;
    txtValorMoeda3: TRLLabel;
    RLLabel160: TRLLabel;
    txtValorDocumento3: TRLLabel;
    RLLabel161: TRLLabel;
    txtInstrucoes3: TRLMemo;
    RLLabel162: TRLLabel;
    txtDesconto3: TRLLabel;
    RLLabel163: TRLLabel;
    txtMoraMulta3: TRLLabel;
    RLLabel164: TRLLabel;
    txtValorCobrado3: TRLLabel;
    RLLabel165: TRLLabel;
    txtNomeSacado3: TRLLabel;
    RLLabel166: TRLLabel;
    txtCpfCnpjSacado3: TRLLabel;
    txtEnderecoSacado3: TRLLabel;
    RLLabel167: TRLLabel;
    txtCidadeSacado3: TRLLabel;
    txtCodigoBaixa3: TRLLabel;
    RLLabel168: TRLLabel;
    RLLabel170: TRLLabel;
    RLLabel175: TRLLabel;
    txtSacadorAvalista3: TRLLabel;
    txtReferencia3: TRLLabel;
    txtSwHouse: TRLAngleLabel;
    txtVencCarne2: TRLLabel;
    RLLabel7: TRLLabel;
    RLDraw74: TRLDraw;
    RLDraw75: TRLDraw;
    RLDraw76: TRLDraw;
    RLDraw77: TRLDraw;
    procedure BoletoCarneBeforePrint ( Sender: TObject; var PrintIt: boolean ) ;
    procedure BoletoCarneDataCount ( Sender: TObject; var DataCount: integer ) ;
    procedure BoletoCarneDataRecord ( Sender: TObject; RecNo: integer;
       CopyNo: integer; var Eof: boolean; var RecordAction: TRLRecordAction ) ;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LayoutBoletoBeforePrint(Sender: TObject; var PrintIt: boolean);
    procedure LayoutBoletoDataCount(Sender: TObject; var DataCount: integer);
    procedure LayoutBoletoDataRecord(Sender: TObject; RecNo: integer;
       CopyNo: integer; var Eof: boolean; var RecordAction: TRLRecordAction);
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: boolean);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: boolean);
    procedure RLBand3BeforePrint ( Sender: TObject; var PrintIt: boolean ) ;
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
     MensagemPadrao: TStringList;
     fBoletoFC: TACBrBoletoFCFortes;
     fIndice: Integer;
     function GetACBrTitulo: TACBrTitulo;
    { Private declarations }
  public
    { Public declarations }
    property Indice   : Integer read fIndice ;
    property BoletoFC : TACBrBoletoFCFortes read fBoletoFC ;
    property Titulo   : TACBrTitulo read GetACBrTitulo ;
  end;

var
  ACBrBoletoFCFortesForm: TACBrBoletoFCFortesFr;

procedure Register;

implementation

Uses ACBrUtil, strutils, RLConsts ;

{$ifdef FPC}
  {$R *.lfm}
{$else}
  {$R *.dfm}
  {$R ACBrBoletoFCFortes.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr',[TACBrBoletoFCFortes]);
end;

{ TACBrBoletoFCFortes }

constructor TACBrBoletoFCFortes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fpAbout := 'ACBRBoletoFCFortes ver: '+CACBrBoletoFCFortes_Versao;
end;

procedure TACBrBoletoFCFortes.Imprimir;

var
  frACBrBoletoFortes : TACBRBoletoFCFortesFr;
  RLFiltro : TRLCustomSaveFilter;
  RLLayout: TRLReport;
begin
  inherited Imprimir;    // Executa verificações padroes

  {$IFDEF FPC}
   LoadPortugueseStrings;
  {$ELSE}
   // Para que serve esse método ?? //
   //SetVersion( CommercialVersion, ReleaseVersion, CommentVersion );
  {$ENDIF}

  frACBrBoletoFortes := TACBrBoletoFCFortesFr.Create(Self);
  try
     with frACBrBoletoFortes do
     begin
        case LayOut of
           lPadrao : RLLayout:= LayoutBoleto;
           lCarne  : RLLayout:= BoletoCarne;
        else
           RLLayout:= LayoutBoleto;
        end;

        RLPrinter.Copies     := NumCopias ;  // Aparentemente isso está errado... :(
        RLLayout.PrintDialog := MostrarSetup;

        if Filtro = fiNenhum then
         begin
           if MostrarPreview then
              RLLayout.PreviewModal
           else
              RLLayout.Print;
         end
        else
         begin
            if RLLayout.Prepare then
            begin
               case Filtro of
                 fiPDF  : RLFiltro := RLPDFFilter1;
                 fiHTML : RLFiltro := RLHTMLFilter1;
               else
                 exit ;
               end ;

              {$IFDEF FPC}
                RLFiltro.Copies := NumCopias ;
              {$ENDIF}
              RLFiltro.FileName := DirArqPDF_HTML +
                                   PathDelim +
                                   NomeArquivo ;

              {$IFDEF FPC}
                RLFiltro.Pages := RLLayout.Pages ;
                RLFiltro.Run;
              {$ELSE}
                RLFiltro.FilterPages( RLLayout.Pages );
              {$ENDIF}
            end;
         end;
     end;
  finally
     frACBrBoletoFortes.Free ;
  end;
end;


{ TACBrBoletoFCFortesFr }

procedure TACBrBoletoFCFortesFr.FormCreate(Sender: TObject);
begin
   fIndice   := 0 ;
   fBoletoFC := TACBrBoletoFCFortes(Owner) ;  // Link para o Pai
   MensagemPadrao := TStringList.Create;
   if (fBoletoFC.ACBrBoleto.ComprovanteEntrega = true)then
      RLBand4.Visible := true
   else
      RLBand4.Visible := false;
end;

procedure TACBrBoletoFCFortesFr.FormDestroy ( Sender: TObject ) ;
begin
   MensagemPadrao.Free;
end;

procedure TACBRBoletoFCFortesFr.BoletoCarneBeforePrint ( Sender: TObject;
   var PrintIt: boolean ) ;
begin

   fIndice := 0 ;
   txtSwHouse.Caption := BoletoFC.SoftwareHouse ;

end;

procedure TACBRBoletoFCFortesFr.BoletoCarneDataCount ( Sender: TObject;
   var DataCount: integer ) ;
begin
   DataCount := fBoletoFC.ACBrBoleto.ListadeBoletos.Count ;
end;

procedure TACBRBoletoFCFortesFr.BoletoCarneDataRecord ( Sender: TObject;
   RecNo: integer; CopyNo: integer; var Eof: boolean;
   var RecordAction: TRLRecordAction ) ;
begin
   fIndice := RecNo - 1 ;

   Eof := (RecNo > fBoletoFC.ACBrBoleto.ListadeBoletos.Count) ;
   RecordAction := raUseIt ;
end;


function TACBrBoletoFCFortesFr.GetACBrTitulo: TACBrTitulo;
begin
   Result := fBoletoFC.ACBrBoleto.ListadeBoletos[ fIndice ] ;
end;

procedure TACBrBoletoFCFortesFr.LayoutBoletoBeforePrint(Sender: TObject;
   var PrintIt: boolean);
begin
   fIndice := 0 ;
   txtSwHouse.Caption := BoletoFC.SoftwareHouse ;
end;

procedure TACBrBoletoFCFortesFr.LayoutBoletoDataCount(Sender: TObject;
   var DataCount: integer);
begin
   DataCount := fBoletoFC.ACBrBoleto.ListadeBoletos.Count ;
end;

procedure TACBrBoletoFCFortesFr.LayoutBoletoDataRecord(Sender: TObject;
   RecNo: integer; CopyNo: integer; var Eof: boolean;
   var RecordAction: TRLRecordAction);
begin
   fIndice := RecNo - 1 ;

   Eof := (RecNo > fBoletoFC.ACBrBoleto.ListadeBoletos.Count) ;
   RecordAction := raUseIt ;
end;

procedure TACBrBoletoFCFortesFr.RLBand1BeforePrint(Sender: TObject;
   var PrintIt: boolean);
Var
   NossoNum,CodCedente,TipoDoc : String;
begin
   with fBoletoFC.ACBrBoleto do
   begin
      NossoNum    := Banco.MontarCampoNossoNumero( Titulo );
      CodCedente  := Banco.MontarCampoCodigoCedente(titulo);

      case Cedente.TipoInscricao of
         pFisica   : TipoDoc:= 'CPF: ';
         pJuridica : TipoDoc:= 'CNPJ: ';
      else
         TipoDoc := 'DOC.: ';
      end;

      MensagemPadrao.Clear;
      MensagemPadrao.Text := Titulo.Mensagem.Text;
      ACBrBoletoFC.ACBrBoleto.AdicionarMensagensPadroes(Titulo,MensagemPadrao);

      fBoletoFC.CarregaLogo( imgBanco2.Picture, Banco.Numero );
      txtNumeroBanco2.Caption         := IntToStrZero(Banco.Numero, 3)+ '-' +
                                         IfThen(Banco.Digito >= 10,'X',
                                         IntToStrZero(Banco.Digito, 1));
      lblLocalPagto.Caption           := Titulo.LocalPagamento;
      txtDataVencimento2.Caption      := FormatDateTime('dd/mm/yyyy', Titulo.Vencimento);
      txtNomeCedente2.Caption         := Cedente.Nome+ ' - '+TipoDoc + Cedente.CNPJCPF;
      txtCodigoCedente2.Caption       := CodCedente;
      txtDataDocumento2.Caption       := FormatDateTime('dd/mm/yyyy', Titulo.DataDocumento);
      txtNumeroDocumento2.Caption     := Titulo.NumeroDocumento;
      txtEspecieDoc2.Caption          := Titulo.EspecieDoc;
      txtAceite2.Caption              := ifThen(Titulo.Aceite = atSim,'S','N');
      txtDataProcessamento2.Caption   := FormatDateTime('dd/mm/yyyy',Now);
      txtNossoNumero2.Caption         := NossoNum;
      txtUsoBanco2.Caption            := Titulo.UsoBanco;
      txtCarteira2.Caption            := Titulo.Carteira;
      txtEspecie2.Caption             := 'R$';
      txtValorDocumento2.Caption      := FormatFloat('###,###,##0.00',Titulo.ValorDocumento);
      txtNomeSacado2.Caption          := Titulo.Sacado.NomeSacado;
      txtEnderecoSacado2.Caption      := Titulo.Sacado.Logradouro + ' '+
                                         Titulo.Sacado.Numero + Titulo.Sacado.Complemento;
      txtCidadeSacado2.Caption        := Titulo.Sacado.CEP + ' '+Titulo.Sacado.Cidade +
                                         ' '+Titulo.Sacado.UF;
      txtCpfCnpjSacado2.Caption       := Titulo.Sacado.CNPJCPF;
      txtInstrucoes2.Lines.Text       := MensagemPadrao.Text;  //Titulo.Mensagem.Text;
      with Titulo.ACBrBoleto.Cedente do
      begin
         txtEndCedente.Caption := Logradouro+' '+NumeroRes+' '+Complemento+' '+
                                  Bairro+' '+Cidade+' '+ UF+' '+CEP;
      end;
   end;
end;

procedure TACBrBoletoFCFortesFr.RLBand2BeforePrint(Sender: TObject;
   var PrintIt: boolean);
Var
  CodBarras, LinhaDigitavel : String;
begin
  with fBoletoFC.ACBrBoleto do
  begin
     CodBarras      := Banco.MontarCodigoBarras( Titulo );
     LinhaDigitavel := Banco.MontarLinhaDigitavel( CodBarras );

     imgBanco3.Picture.Assign(imgBanco2.Picture);
     txtNumeroBanco3.Caption         := txtNumeroBanco2.Caption;
     txtLocalPagamento3.Caption      := lblLocalPagto.Caption;
     txtDataVencimento3.Caption      := txtDataVencimento2.Caption;
     txtNomeCedente3.Caption         := Cedente.Nome;
     txtCodigoCedente3.Caption       := txtCodigoCedente2.Caption;
     txtDataDocumento3.Caption       := txtDataDocumento2.Caption;
     txtNumeroDocumento3.Caption     := txtNumeroDocumento2.Caption;
     txtEspecie3.Caption             := txtEspecie2.Caption;
     txtAceite3.Caption              := txtAceite2.Caption;
     txtDataProcessamento3.Caption   := txtDataProcessamento2.Caption;
     txtNossoNumero3.Caption         := txtNossoNumero2.Caption;
     txtUsoBanco3.Caption            := txtUsoBanco2.Caption;
     txtCarteira3.Caption            := txtCarteira2.Caption;
     txtEspecieDoc3.Caption          := txtEspecieDoc2.Caption;
     txtValorDocumento3.Caption      := txtValorDocumento2.Caption;
     txtNomeSacado3.Caption          := txtNomeSacado2.Caption;
     txtEnderecoSacado3.Caption      := txtEnderecoSacado2.Caption;
     txtCidadeSacado3.Caption        := txtCidadeSacado2.Caption;
     txtCpfCnpjSacado3.Caption       := txtCpfCnpjSacado2.Caption;

     imgCodigoBarra.Caption          := CodBarras;
     txtLinhaDigitavel.Caption       := LinhaDigitavel;
     txtInstrucoes3.Lines.Text       := txtInstrucoes2.Lines.Text;
   end;
end;

procedure TACBRBoletoFCFortesFr.RLBand3BeforePrint ( Sender: TObject;
   var PrintIt: boolean ) ;
Var
   NossoNum,LinhaDigitavel,CodBarras,CodCedente: String;
begin
   with fBoletoFC.ACBrBoleto do
   begin
      NossoNum       := Banco.MontarCampoNossoNumero( Titulo );
      CodBarras      := Banco.MontarCodigoBarras( Titulo );
      LinhaDigitavel := Banco.MontarLinhaDigitavel( CodBarras );
      CodCedente     := Banco.MontarCampoCodigoCedente(Titulo);

      MensagemPadrao.Clear;
      MensagemPadrao.Text := Titulo.Mensagem.Text;
      ACBrBoletoFC.ACBrBoleto.AdicionarMensagensPadroes(Titulo,MensagemPadrao);

      fBoletoFC.CarregaLogo( ImgLoja.Picture, Banco.Numero );
      fBoletoFC.CarregaLogo( imgBancoCarne.Picture, Banco.Numero );
      txtNumeroBanco.Caption         := IntToStrZero(Banco.Numero, 3)+ '-' +
                                        ifthen(Banco.Digito >= 10,'X',IntToStrZero(Banco.Digito, 1));
      txtVencCanhoto.Caption          := FormatDateTime('dd/mm/yyyy',Titulo.Vencimento);
      txtVencCarne2.Caption           := txtVencCanhoto.Caption;
      txtCodCedenteCarne.Caption      := CodCedente;
      txtCodCedenteCarne2.Caption     := txtCodCedenteCarne.Caption;
      txtValorCarne.Caption           := FormatFloat('###,###,##0.00',Titulo.ValorDocumento);
      txtValorCar.Caption             := txtValorCarne.Caption;
      txtNossoNumeroCarne.Caption     := NossoNum;
      txtNossoNumCan.Caption          := NossoNum;
      txtNomeSacado.Caption           := Titulo.Sacado.NomeSacado;
      txtNomeSacadoCarne.Caption      := txtNomeSacado.Caption;

      txtLocal.Caption                := Titulo.LocalPagamento;
      txtNomeCedente.Caption          := Cedente.Nome;

      txtDataDocto.Caption            := FormatDateTime('dd/mm/yyyy', Titulo.DataDocumento);
      txtNumeroDocto.Caption          := Titulo.NumeroDocumento;
      txtEspecieDoc.Caption           := Titulo.EspecieDoc;
      txtAceite.Caption               := IfThen((atSim = Titulo.Aceite), 'S', 'N');
      txtDataProces.Caption           := FormatDateTime('dd/mm/yyyy',Now);

      txtUsoBanco2.Caption            := Titulo.UsoBanco;
      txtCarteira.Caption             := Titulo.Carteira;
      txtEspecie2.Caption             := 'R$';
      txtParcela.Caption              := IntToStrZero(Titulo.Parcela,2)+' /';
      txtTotPar.Caption               := IntToStrZero(Titulo.TotalParcelas,2);

      txtEndSacado.Caption            := Titulo.Sacado.Logradouro + ' '+
                                         Titulo.Sacado.Numero + Titulo.Sacado.Complemento;
      txtCidadeSacado.Caption         := Titulo.Sacado.CEP + ' '+Titulo.Sacado.Cidade +
                                         ' '+Titulo.Sacado.UF;
      txtCPF.Caption                  := Titulo.Sacado.CNPJCPF;
      txtCPFCarne2.Caption            := txtCPF.Caption;
      mIntrucoes.Lines.Text           := MensagemPadrao.Text;

      txtLinhaDigitavelCarne.Caption := LinhaDigitavel;
      imgBarrasCarne.Caption := CodBarras;
   end;



end;

procedure TACBrBoletoFCFortesFr.RLBand4BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
Var
   NossoNum,CodCedente,TipoDoc : String;
begin
   with fBoletoFC.ACBrBoleto do
   begin
      NossoNum    := Banco.MontarCampoNossoNumero( Titulo );
      CodCedente  := Banco.MontarCampoCodigoCedente(titulo);

      case Cedente.TipoInscricao of
         pFisica   : TipoDoc:= 'CPF: ';
         pJuridica : TipoDoc:= 'CNPJ: ';
      else
         TipoDoc := 'DOC.: ';
      end;

      fBoletoFC.CarregaLogo( imgBanco4.Picture, Banco.Numero );
      txtNumeroBanco4.Caption         := IntToStrZero(Banco.Numero, 3)+ '-' +
                                         IfThen(Banco.Digito >= 10,'X',
                                         IntToStrZero(Banco.Digito, 1));
      lblLocalPagto4.Caption           := Titulo.LocalPagamento;
      txtDataVencimento4.Caption      := FormatDateTime('dd/mm/yyyy', Titulo.Vencimento);
      txtNomeCedente4.Caption         := Cedente.Nome+ ' - '+TipoDoc + Cedente.CNPJCPF;
      txtCodigoCedente4.Caption       := Cedente.Agencia+'-'+Cedente.AgenciaDigito+'/'+ Cedente.Conta+'-'+Cedente.ContaDigito;

      txtNumeroDocumento4.Caption     := Titulo.NumeroDocumento;
      txtDataProcessamento4.Caption   := FormatDateTime('dd/mm/yyyy',Now);
      txtNossoNumero4.Caption         := NossoNum;
      txtEspecie4.Caption             := 'R$';
      txtValorDocumento4.Caption      := FormatFloat('###,###,##0.00',Titulo.ValorDocumento);
      txtNomeSacado4.Caption          := Titulo.Sacado.NomeSacado;
   end;
end;

{$ifdef FPC}
initialization
   {$I ACBrBoletoFCFortes.lrs}
{$endif}

end.

