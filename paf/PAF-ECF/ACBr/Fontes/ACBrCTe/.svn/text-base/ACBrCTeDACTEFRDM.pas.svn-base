{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{ Biblioteca multiplataforma de componentes Delphi para emissão de Conhecimento}
{ Transporte eletrônica - CTe - http://www.cte.fazenda.gov.br                  }
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
|* 30/03/2011: Jeickson Gobeti
|*  - Inicio do desenvolvimento Dacte FastReport
******************************************************************************}
{$I ACBr.inc}

unit ACBrCTeDACTEFRDM;

interface

uses
  SysUtils, Classes, ACBrCTeDACTEClass, pcteCTe, frxClass, frxExportPDF, DB,
  DBClient, frxDBSet, pcnConversao, frxBarcode;

type
  TdmACBrCTeFR = class(TDataModule)
    frxPDFExport: TfrxPDFExport;
    cdsIdentificacao: TClientDataSet;
    cdsEmitente: TClientDataSet;
    cdsDestinatario: TClientDataSet;
    cdsDadosNotasFiscais: TClientDataSet;
    cdsParametros: TClientDataSet;
    cdsInformacoesAdicionais: TClientDataSet;
    cdsVolumes: TClientDataSet;
    frxIdentificacao: TfrxDBDataset;
    frxEmitente: TfrxDBDataset;
    frxDestinatario: TfrxDBDataset;
    frxDadosNotasFiscais: TfrxDBDataset;
    frxParametros: TfrxDBDataset;
    frxVolumes: TfrxDBDataset;
    frxInformacoesAdicionais: TfrxDBDataset;
    frxBarCodeObject: TfrxBarCodeObject;
    frxReport: TfrxReport;
    cdsTomador: TClientDataSet;
    frxTomador: TfrxDBDataset;
    cdsExpedidor: TClientDataSet;
    frxExpedidor: TfrxDBDataset;
    cdsRecebedor: TClientDataSet;
    frxRecebedor: TfrxDBDataset;
    cdsRemetente: TClientDataSet;
    frxRemetente: TfrxDBDataset;
    cdsCalculoImposto: TClientDataSet;
    frxCalculoImposto: TfrxDBDataset;
    cdsComponentesPrestacao: TClientDataSet;
    frxComponentesPrestacao: TfrxDBDataset;
    cdsSeguro: TClientDataSet;
    frxSeguro: TfrxDBDataset;
    cdsModalRodoviario: TClientDataSet;
    frxModalRodoviario: TfrxDBDataset;
    constructor Create(AOwner: TComponent); override;
  private
    { Private declarations }
    FDACTEClassOwner: TACBrCTeDACTEClass;
    FCTe: TCTe;
    procedure CarregaIdentificacao;
    procedure CarregaTomador;
    procedure CarregaEmitente;
    procedure CarregaRemetente;
    procedure CarregaDestinatario;
    procedure CarregaExpedidor;
    procedure CarregaRecebedor;
    procedure CarregaDadosNotasFiscais;
    procedure CarregaCalculoImposto;
    procedure CarregaParametros;
    procedure CarregaVolumes;
    procedure CarregaComponentesPrestacao;
    procedure CarregaSeguro;
    procedure CarregaModalRodoviario;
    procedure CarregaInformacoesAdicionais;



  public
    { Public declarations }
    property  CTe: TCTe read FCTe write FCTe;
    property  DACTEClassOwner: TACBrCTeDACTEClass read FDACTEClassOwner;
    procedure CarregaDados;
  end;

var
  dmACBrCTeFR: TdmACBrCTeFR;

implementation

uses ACBrCTe, ACBrCTeUtil, StrUtils, Math;

{$R *.dfm}

type
  ArrOfStr = Array of String;
  TSplitResult = array of string;

{ TdmACBrNFeFR }

function SubstrCount(const ASubString, AString: string): Integer;
var
  i: integer;
begin
  Result := -1;
  i := 0;
  repeat
    Inc(Result);
    i := PosEx(ASubString, AString, i + 1);
  until i = 0;
end;

function Split(const ADelimiter, AString: string): TSplitResult;
var
  Step: ^String;
  Chr: PChar;
  iPos, iLast, iDelLen, iLen, x: integer;
label
  EndLoop;
begin
  SetLength(Result, SubstrCount(ADelimiter, AString) + 1);
  if High(Result) = 0 then
    Result[0] := AString
  else
  begin
    iDelLen := PCardinal(Cardinal(ADelimiter) - SizeOf(Cardinal))^;
    iLen := PCardinal(Cardinal(AString) - SizeOf(Cardinal))^;
    Step := @Result[0];
    iLast := 0;
    iPos := 0;
    repeat
      if iPos + iDelLen > iLen then
      begin
        if iLast <> iPos then
          iPos := iLen;
      end else
        for x := 1 to iDelLen do
          if AString[iPos + x] <> ADelimiter[x] then
            goto EndLoop;

      if iPos - iLast > 0 then
      begin
        SetLength(Step^, iPos - iLast);
        Chr := PChar(Step^);
        for x := 1 to PCardinal(Cardinal(Step^) - SizeOf(Cardinal))^ do
        begin
          Chr^ := AString[iLast + x];
          Inc(Chr);
        end;
      end else
        Step^ := '';

      Cardinal(Step) := Cardinal(Step) + SizeOf(Cardinal);
      iLast := iPos + iDelLen;

      EndLoop:
        Inc(iPos);
    until iLast >= iLen;
  end;
end;

function Explode(sPart, sInput: String): ArrOfStr;
begin
  while Pos(sPart, sInput) <> 0 do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1] := Copy(sInput, 0, Pos(sPart, sInput) - 1);
      Delete(sInput, 1, Pos(sPart, sInput));
    end;

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := sInput;
end;

function CollateBr(Str: String): String;
var
  Resultado,Temp: string;
  vChar: Char;
  Tamanho, i: integer;
begin
  Result := '';
  Tamanho := Length(str);
  i := 1;
  while i <= Tamanho do
  begin
    Temp := Copy(str,i,1);
    vChar := Temp[1];
    case vChar of
      'á', 'â', 'ã', 'à', 'ä', 'å', 'Á', 'Â', 'Ã', 'À', 'Ä', 'Å': Resultado := 'A';
      'é', 'ê', 'è', 'ë', 'É', 'Ê', 'È', 'Ë': Resultado := 'E';
      'í', 'î', 'ì', 'ï', 'Í', 'Î', 'Ì', 'Ï': Resultado := 'I';
      'ó', 'ô', 'õ', 'ò', 'ö', 'Ó', 'Ô', 'Õ', 'Ò', 'Ö': Resultado := 'O';
      'ú', 'û', 'ù', 'ü', 'Ú', 'Û', 'Ù', 'Ü': Resultado := 'U';
      'ç', 'Ç': Resultado := 'C';
      'ñ', 'Ñ': Resultado := 'N';
      'ý', 'ÿ', 'Ý', 'Y': Resultado := 'Y';
    else
      if vChar > #127 then Resultado := #32
      {$IFDEF DELPHI12_UP}
      else if CharInset(vChar, ['a'..'z','A'..'Z','0'..'9','-',' ']) then
      {$ELSE}
      else if vChar in ['a'..'z','A'..'Z','0'..'9','-',' '] then
      {$ENDIF}
        Resultado := UpperCase(vCHAR);
    end;
    Result := Result + Resultado;
    i := i + 1;
  end;
end;

procedure TdmACBrCTeFR.CarregaCalculoImposto;
begin
  with cdsCalculoImposto do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('TXTSITTRIB', ftString,60);
    FieldDefs.Add('VBC', ftFloat);
    FieldDefs.Add('PICMS', ftFloat);
    FieldDefs.Add('VICMS', ftFloat);
    FieldDefs.Add('pRedBC', ftFloat);
    FieldDefs.Add('VICMSST', ftFloat);


    CreateDataSet;
    Append;

    case FCTe.Imp.ICMS.SituTrib of
     cst00 : begin
               FieldByName('TXTSITTRIB').AsString :=   CSTICMSToStr(cst00)+'-'+ CSTICMSToStrTagPosText(cst00);
               FieldByName('vBC').AsFloat   := FCTe.Imp.ICMS.CST00.vBC;
               FieldByName('pICMS').AsFloat := FCTe.Imp.ICMS.CST00.pICMS;
               FieldByName('vICMS').AsFloat := FCTe.Imp.ICMS.CST00.VICMS;
             end;
      cst45: begin
               FieldByName('TXTSITTRIB').AsString :=   CSTICMSToStr(cst00)+'-'+ CSTICMSToStrTagPosText(cst00);
             end;


    end;
   Post;
  end;
end;

procedure TdmACBrCTeFR.CarregaComponentesPrestacao;
var
  I : Integer;
begin
  with cdsComponentesPrestacao do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Nome', ftString, 60);
    FieldDefs.Add('Valor', ftFloat);
    FieldDefs.Add('TotalServico', ftFloat);
    FieldDefs.Add('TotalReceber', ftFloat);
    CreateDataSet;
    Append;

    if CTe.vPrest.comp.Count > 0 then
    begin
       for I := 0 to CTe.vPrest.comp.Count - 1 do
       begin
          FieldByName('Nome').AsString  :=  CTe.vPrest.comp.Items[I].xNome;
          FieldByName('Valor').AsFloat  :=  CTe.vPrest.comp.Items[I].vComp;
          FieldByName('TotalServico').AsFloat  := CTe.vPrest.vTPrest;
          FieldByName('TotalReceber').AsFloat  := CTe.vPrest.vRec;
       end;
    end
    else
    begin
       FieldByName('Nome').AsString  :=  '';
       FieldByName('Valor').AsFloat  :=  0;
       FieldByName('TotalServico').AsFloat  := 0;
       FieldByName('TotalReceber').AsFloat  := 0;
    end;
   Post;
  end;

end;

procedure TdmACBrCTeFR.CarregaDados;
begin
  CarregaIdentificacao;
  CarregaTomador;
  CarregaEmitente;
  CarregaRemetente;
  CarregaDestinatario;
  CarregaExpedidor;
  CarregaRecebedor;
  CarregaDadosNotasFiscais;
  CarregaParametros;
  CarregaCalculoImposto;
  CarregaVolumes;
  CarregaComponentesPrestacao;
  CarregaInformacoesAdicionais;
  CarregaSeguro;
  CarregaModalRodoviario;



end;

procedure TdmACBrCTeFR.CarregaDadosNotasFiscais;
var
  i: Integer;
  vTemp2: TStringList;
  IndexCampo2: Integer;
  Campos2: TSplitResult;
  BufferXInfProd: String;
  TmpStr: String;
  j: Integer;
  wInfAdProd: String;
begin
  { dados das Notas Fiscais }

  with cdsDadosNotasFiscais do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('tpDoc', ftString, 5); //Tipo Documento
    FieldDefs.Add('CNPJCPF', ftString, 18); //CNPJCPF
    FieldDefs.Add('Serie', ftString, 3); // Serie
    FieldDefs.Add('ChaveAcesso', ftString, 44); // Chave Acesso
    FieldDefs.Add('NotaFiscal', ftString, 9); // Numero Nota Fiscal
    FieldDefs.Add('TextoImpressao', ftString,100); // Texto Impressao no Relatorio
    CreateDataSet;

    for i := 0 to CTe.Rem.InfNF.Count - 1 do
    begin
       Append;
       with FCTe.Rem.InfNF.Items[i] do
       begin
          FieldByName('tpDoc').AsString := 'NF';
          FieldByName('CNPJCPF').AsString := FCTe.Rem.CNPJCPF;
          FieldByName('Serie').AsString := serie;
          FieldByName('ChaveAcesso').AsString := '';
          FieldByName('NotaFiscal').AsString := nDoc;
          FieldByName('TextoImpressao').AsString := 'NF                   '+FCTe.Rem.CNPJCPF+'                                                 '+serie+'  /  '+nDoc;
       end;
      Post;
    end;

    for i := 0 to CTe.Rem.InfNFE.Count - 1 do
    begin
      Append;
      with FCTe.Rem.InfNFE.Items[i] do
      begin
         FieldByName('tpDoc').AsString := 'NFe';
         FieldByName('CNPJCPF').AsString := FCTe.Rem.CNPJCPF;
         FieldByName('Serie').AsString := '';
         FieldByName('ChaveAcesso').AsString := chave;
         FieldByName('NotaFiscal').AsString := '';
         FieldByName('TextoImpressao').AsString := 'NFe   '+chave;
      end;
      Post;
    end;
    //
    cdsDadosNotasFiscais.RecordCount;
  end;

end;

procedure TdmACBrCTeFR.CarregaDestinatario;
begin
  { destinatário }
  with cdsDestinatario do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CNPJCPF', ftString, 18);
    FieldDefs.Add('XNome', ftString, 60);
    FieldDefs.Add('XLgr', ftString, 60);
    FieldDefs.Add('Nro', ftString, 60);
    FieldDefs.Add('XCpl', ftString, 60);
    FieldDefs.Add('XBairro', ftString, 60);
    FieldDefs.Add('CMun', ftString, 7);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);
    FieldDefs.Add('CEP', ftString, 9);
    FieldDefs.Add('CPais', ftString, 4);
    FieldDefs.Add('XPais', ftString, 60);
    FieldDefs.Add('Fone', ftString, 15);
    FieldDefs.Add('IE', ftString, 14);

    CreateDataSet;
    Append;

    with FCTe.Dest do
    begin
      if CTEUtil.NaoEstaVazio(CNPJCPF) then
       begin
         if Length(CNPJCPF) > 11 then
            FieldByName('CNPJCPF').AsString := CTeUtil.FormatarCNPJ(CNPJCPF)
         else
            FieldByName('CNPJCPF').AsString := CTeUtil.FormatarCPF(CNPJCPF);
       end
      else
         FieldByName('CNPJCPF').AsString := '';

      FieldByName('XNome').AsString := XNome;
      with EnderDest do
      begin
        FieldByName('XLgr').AsString := XLgr;
        FieldByName('Nro').AsString := Nro;
        FieldByName('XCpl').AsString := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString := IntToStr(CMun);
        FieldByName('XMun').AsString := CollateBr(XMun);
        FieldByName('UF').AsString := UF;
        FieldByName('CEP').AsString := CTeUtil.FormatarCEP(CTeUtil.Poem_Zeros(CEP, 8));
        FieldByName('CPais').AsString := IntToStr(CPais);
        FieldByName('XPais').AsString := XPais;
        FieldByName('Fone').AsString := CTeUtil.FormatarFone(Fone);
      end;
      FieldByName('IE').AsString := IE;
    end;
    Post;
  end;
end;


procedure TdmACBrCTeFR.CarregaEmitente;
begin
  { emitente }
  with cdsEmitente do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CNPJ', ftString, 18);
    FieldDefs.Add('XNome', ftString, 60);
    FieldDefs.Add('XFant', ftString, 60);
    FieldDefs.Add('XLgr', ftString, 60);
    FieldDefs.Add('Nro', ftString, 60);
    FieldDefs.Add('XCpl', ftString, 60);
    FieldDefs.Add('XBairro', ftString, 60);
    FieldDefs.Add('CMun', ftString, 7);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);
    FieldDefs.Add('CEP', ftString, 9);
    FieldDefs.Add('CPais', ftString, 4);
    FieldDefs.Add('XPais', ftString, 60);
    FieldDefs.Add('Fone', ftString, 15);
    FieldDefs.Add('IE', ftString, 14);
    FieldDefs.Add('IM', ftString, 15);
    FieldDefs.Add('IEST', ftString, 15);
    FieldDefs.Add('CRT', ftString, 1);

    CreateDataSet;
    Append;

    with FCTE.Emit do
    begin
      FieldByName('CNPJ').AsString := CTeUtil.FormatarCNPJ(CNPJ);
      FieldByName('XNome').AsString := XNome;
      FieldByName('XFant').AsString := XFant;
      with EnderEmit do
      begin
        FieldByName('Xlgr').AsString := XLgr;
        FieldByName('Nro').AsString := Nro;
        FieldByName('XCpl').AsString := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString := IntToStr(CMun);
        FieldByName('XMun').AsString := CollateBr(XMun);
        FieldByName('UF').AsString := UF;
        FieldByName('CEP').AsString := CTeUtil.FormatarCEP(CTeUtil.Poem_Zeros(CEP, 8));
        FieldByName('CPais').AsString := IntToStr(CPais);
        FieldByName('XPais').AsString := XPais;
        FieldByName('Fone').AsString := CTeUtil.FormatarFone(Fone);
      end;
      FieldByName('IE').AsString := IE;
    end;

    Post;
  end;
end;

procedure TdmACBrCTeFR.CarregaExpedidor;
begin
  { Expedidor }
  with cdsExpedidor do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CNPJ', ftString, 18);
    FieldDefs.Add('XNome', ftString, 60);
    FieldDefs.Add('XFant', ftString, 60);
    FieldDefs.Add('XLgr', ftString, 60);
    FieldDefs.Add('Nro', ftString, 60);
    FieldDefs.Add('XCpl', ftString, 60);
    FieldDefs.Add('XBairro', ftString, 60);
    FieldDefs.Add('CMun', ftString, 7);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);
    FieldDefs.Add('CEP', ftString, 9);
    FieldDefs.Add('CPais', ftString, 4);
    FieldDefs.Add('XPais', ftString, 60);
    FieldDefs.Add('Fone', ftString, 15);
    FieldDefs.Add('IE', ftString, 14);
    FieldDefs.Add('IM', ftString, 15);
    FieldDefs.Add('IEST', ftString, 15);
    FieldDefs.Add('CRT', ftString, 1);

    CreateDataSet;
    Append;

    with FCTE.Exped do
    begin
      FieldByName('CNPJ').AsString := CTeUtil.FormatarCNPJ(CNPJCPF);
      FieldByName('XNome').AsString := XNome;
      with EnderExped do
      begin
        FieldByName('Xlgr').AsString := XLgr;
        FieldByName('Nro').AsString := Nro;
        FieldByName('XCpl').AsString := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString := IntToStr(CMun);
        FieldByName('XMun').AsString := CollateBr(XMun);
        FieldByName('UF').AsString := UF;
        FieldByName('CEP').AsString := CTeUtil.FormatarCEP(CTeUtil.Poem_Zeros(CEP, 8));
        FieldByName('CPais').AsString := IntToStr(CPais);
        FieldByName('XPais').AsString := XPais;
        FieldByName('Fone').AsString := CTeUtil.FormatarFone(Fone);
      end;
      FieldByName('IE').AsString := IE;
    end;

    Post;
  end;

end;


procedure TdmACBrCTeFR.CarregaIdentificacao;
begin
  with cdsIdentificacao do
  begin
    Close;
    FieldDefs.Clear;
    //FieldDefs.Add('Versao', ftString, 4);
    FieldDefs.Add('Id', ftString, 44);
    FieldDefs.Add('Chave', ftString, 60);
    FieldDefs.Add('CUF', ftString, 2);
    FieldDefs.Add('CCT', ftString, 9);
    FieldDefs.Add('CFOP', ftString, 4);
    FieldDefs.Add('NatOp', ftString, 60);
    FieldDefs.Add('forPag', ftString, 50);
    FieldDefs.Add('Mod_', ftString, 2);
    FieldDefs.Add('Serie', ftString, 3);
    FieldDefs.Add('NCT', ftString, 9);
    FieldDefs.Add('dhEmi', ftString, 19);
    FieldDefs.Add('TpImp', ftString, 1);
    FieldDefs.Add('TpEmis', ftString, 50);
    FieldDefs.Add('CDV', ftString, 1);
    FieldDefs.Add('TpAmb', ftString, 1);
    FieldDefs.Add('TpCT', ftString, 50);
    FieldDefs.Add('ProcEmi', ftString, 1);
    FieldDefs.Add('VerProc', ftString, 20);
    FieldDefs.Add('cMunEmi', ftString, 7);
    FieldDefs.Add('xMunEmi', ftString, 60);
    FieldDefs.Add('UFEmi', ftString, 2);
    FieldDefs.Add('modal', ftString, 1);
    FieldDefs.Add('tpServ', ftString, 50);
    FieldDefs.Add('cMunIni', ftString, 7);
    FieldDefs.Add('xMunIni', ftString, 60);
    FieldDefs.Add('UFIni', ftString, 2);
    FieldDefs.Add('cMunFim', ftString, 7);
    FieldDefs.Add('xMunFim', ftString, 60);
    FieldDefs.Add('UFFim', ftString, 2);
    FieldDefs.Add('retira', ftString, 1);
    FieldDefs.Add('xDetRetira', ftString, 160);
    FieldDefs.Add('toma', ftString, 50);
    CreateDataSet;
    Append;

    with FCTe.infCTe do
    begin
      //FieldByName('Versao').AsString := IntToStr(Versao);
      FieldByName('Id').AsString := CTeUtil.LimpaNumero(Id);
      FieldByName('Chave').AsString := CTeUtil.FormatarChaveAcesso(Id);
    end;

    with FCTe.Ide do
    begin
      FieldByName('CUF').AsString := IntToStr(CUF);
      FieldByName('CCT').AsString := IntToStr(CCT);
      FieldByName('CFOP').AsString := IntToStr(CFOP);
      FieldByName('NatOp').AsString := NatOp;
      case forPag of
        fpPago: FieldByName('forPag').AsString := 'PAGO';
        fpAPagar: FieldByName('forPag').AsString := 'A PAGAR';
        fpOutros: FieldByName('forPag').AsString := 'OUTROS';
      end;
      FieldByName('Mod_').AsString := modelo;
      FieldByName('Serie').AsString := IntToStr(Serie);
      FieldByName('NCT').AsString := CTeUtil.FormatarNumCTe(nCT);
      FieldByName('dhEmi').AsString := CTeUtil.FormatDate(DateToStr(dhEmi));
      case tpCTe of
        tcNormal: FieldByName('TpCT').AsString := 'NORMAL';
        tcComplemento: FieldByName('TpCT').AsString := 'COMPLEMENTO';
        tcAnulacao: FieldByName('TpCT').AsString := 'ANULAÇÃO';
        tcSubstituto: FieldByName('TpCT').AsString := 'SUBSTITUTO';
      end;
      FieldByName('cMunEmi').AsString := IntToStr(cMunEmi);
      FieldByName('xMunEmi').AsString := xMunEmi;
      FieldByName('UFEmi').AsString   := UFEmi;
      FieldByName('modal').AsString := CTeUtil.SeSenao(modal = mdRodoviario, '0', '0');
      case tpServ of
        tsNormal: FieldByName('tpServ').AsString := 'NORMAL';
        tsSubcontratacao: FieldByName('tpServ').AsString := 'SUBCONTRATAÇÃO';
        tsRedespacho: FieldByName('tpServ').AsString := 'REDESPACHO';
        tsIntermediario: FieldByName('tpServ').AsString := 'INTERMEDIARIO';
      end;
      FieldByName('cMunIni').AsString := IntToStr(cMunIni);
      FieldByName('xMunIni').AsString := xMunIni;
      FieldByName('UFIni').AsString   := UFIni;
      FieldByName('cMunFim').AsString := IntToStr(cMunFim);
      FieldByName('xMunFim').AsString := xMunFim;
      FieldByName('UFFim').AsString   := UFFim;
      FieldByName('TpImp').AsString := CTeUtil.SeSenao(TpImp = tiRetrato, '1', '2');
      FieldByName('TpEmis').AsString := CTeUtil.SeSenao(TpEmis = teNormal, '1', '5');
      FieldByName('CDV').AsString := IntToStr(CDV);
      FieldByName('TpAmb').AsString := CTeUtil.SeSenao(TpAmb = taHomologacao, '2', '1');
      FieldByName('ProcEmi').AsString := CTeUtil.SeSenao(ProcEmi = peAplicativoContribuinte, '0', '');
      FieldByName('VerProc').AsString := VerProc;

      case Toma03.Toma of
       tmRemetente    : FieldByName('Toma').AsString := 'REMETENTE';
       tmDestinatario : FieldByName('Toma').AsString := 'DESTINATARIO';
       tmExpedidor    : FieldByName('Toma').AsString := 'EXPEDIDOR';
       tmRecebedor    : FieldByName('Toma').AsString := 'RECEBEDOR';
      end;

      case Toma4.Toma of
       tmOutros       : FieldByName('Toma').AsString := 'OUTROS';
      end;



    end;

    Post;
  end;
end;

procedure TdmACBrCTeFR.CarregaInformacoesAdicionais;
var
  i: Integer;
  vTemp: TStringList;
  IndexCampo:Integer;
  Campos: TSplitResult;
  BufferObs: String;
  TmpStr: String;
  wContingencia: string;
  wObs:string;
  wLinhasObs: integer;
begin

  with cdsInformacoesAdicionais do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('OBS', ftString, 2000);
    CreateDataSet;
    Append;
    with FCTe.compl do
    begin
       wObs := xObs;

       //Contingencia
       if FCTe.Ide.tpEmis=teNORMAL then
          wContingencia := ''
       else
       begin
          if (FCTe.Ide.tpEmis = teContingencia) or (FCTe.Ide.tpEmis = teFSDA) or (FCTe.Ide.tpEmis = teSCAN) then
            wContingencia := 'DACTE EM CONTINGÊNCIA, IMPRESSO EM DECORRÊNCIA DE PROBLEMAS TÉCNICOS'
          else if FCTe.Ide.tpEmis = teDPEC then
            wContingencia := 'DACTE IMPRESSO EM CONTINGÊNCIA - DPEC REGULARMENTE RECEBIDA PELA RECEITA FEDERAL DO BRASIL';

      //            wContingencia := wContingencia + ';' +
//                             'DATA/HORA INÍCIO: ' + CTeUtil.SeSenao(FCTe.ide.dhCont = 0, ' ', DateTimeToStr(FCTe.ide.dhCont)) + ';'+
//                             'MOTIVO CONTINGÊNCIA: ' + CTeUtil.SeSenao(CTeUtil.EstaVazio(FCTe.ide.xJust), ' ', FCTe.ide.xJust);
       end;
       if Length(wObs) > 0 then
         wObs := wObs + ';';
        wObs := wObs + wContingencia;

       vTemp := TStringList.Create;
       try
         if Trim(wObs) <> '' then
         begin
           Campos := Split(';', wObs);
           for IndexCampo := 0 to Length(Campos) - 1 do
               vTemp.Add(Campos[IndexCampo]);

           wLinhasObs := 1; //TotalObS(vTemp.Text);
           TmpStr := vTemp.Text;
           BufferObs := TmpStr;
        end
        else
           BufferObs := '';

      finally
        vTemp.Free;
      end;
    end;
    FieldByName('OBS').AsString        := BufferObs;

    Post;
  end;

end;




procedure TdmACBrCTeFR.CarregaModalRodoviario;
begin
   with cdsModalRodoviario do
   begin
      Close;
      FieldDefs.Clear;
      FieldDefs.Add('RNTRC',       ftString, 60);
      FieldDefs.Add('DATAPREVISTA',ftString, 60);
      FieldDefs.Add('LOTACAO',     ftString, 60);
      CreateDataSet;
      Append;
      //
      case CTe.Rodo.Lota of
        ltNao :   FieldByName('LOTACAO').AsString  := 'NAO';
        ltSim :   FieldByName('LOTACAO').AsString  := 'SIM';
      end;
      FieldByName('RNTRC').AsString   := CTe.Rodo.RNTRC;
      FieldByName('DATAPREVISTA').AsString    := DateToStr(CTe.Rodo.dPrev);

   Post;
   end;
end;

procedure TdmACBrCTeFR.CarregaParametros;
var
  vChave_Contingencia: String;
  vResumo: String;
begin
  { parâmetros }
  with cdsParametros do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('ResumoCanhoto', ftString, 200);
    FieldDefs.Add('Mensagem0', ftString, 60);
    FieldDefs.Add('Imagem', ftString, 256);
    FieldDefs.Add('Sistema', ftString, 60);
    FieldDefs.Add('Usuario', ftString, 60);
    FieldDefs.Add('Fax', ftString, 60);
    FieldDefs.Add('Site', ftString, 60);
    FieldDefs.Add('Email', ftString, 60);
    FieldDefs.Add('Desconto', ftString, 60);
    FieldDefs.Add('ChaveAcesso_Descricao', ftString, 90);
    FieldDefs.Add('Contingencia_ID', ftString, 36);
    FieldDefs.Add('Contingencia_Descricao', ftString, 60);
    FieldDefs.Add('Contingencia_Valor', ftString, 60);
    FieldDefs.Add('LinhasPorPagina', ftInteger);

    CreateDataSet;
    Append;

    vResumo := '';
//    if DACTEClassOwner.ExibirResumoCanhoto then
//    begin
//       if NotaUtil.EstaVazio(DANFEClassOwner.ExibirResumoCanhoto_Texto) then
//          vResumo := 'Emissão: ' + NotaUtil.FormatDate(DateToStr(FNFe.Ide.DEmi)) + '  Dest/Reme: ' + FNFe.Dest.XNome + '  Valor Total: ' + NotaUtil.FormatFloat(FNFe.Total.ICMSTot.VNF)
//       else
//          vResumo := DANFEClassOwner.ExibirResumoCanhoto_Texto;
//    end;
    FieldByName('ResumoCanhoto').AsString := vResumo;

    if (FCTe.Ide.TpAmb = taHomologacao) then
      FieldByName('Mensagem0').AsString := 'CTe sem Valor Fiscal - HOMOLOGAÇÃO'
    else
    begin
      if not (FCTe.Ide.tpEmis in [teContingencia, teFSDA]) then
      begin
        if ((CTeUtil.EstaVazio(FDACTEClassOwner.ProtocoloCTE)) and
            (CTeUtil.EstaVazio(FCTe.procCTe.nProt))) then
          FieldByName('Mensagem0').AsString := 'CTe sem Autorização de Uso da SEFAZ'
        else
        if (not ((CTeUtil.EstaVazio(FDACTEClassOwner.ProtocoloCTE)) and
           (CTeUtil.EstaVazio(FCTe.procCTe.nProt)))) and
           (FCTe.procCTe.cStat = 101) then
          FieldByName('Mensagem0').AsString := 'CTe Cancelada'
        else
        begin
          if FDACTEClassOwner.CTeCancelada then
            FieldByName('Mensagem0').AsString := 'CTe Cancelada'
          else
            FieldByName('Mensagem0').AsString := '';
        end;
      end
      else
        FieldByName('Mensagem0').AsString := '';
    end;

    // Carregamento da imagem
    if DACTEClassOwner.Logo <> '' then
      FieldByName('Imagem').AsString := DACTEClassOwner.Logo;

    if FDACTEClassOwner.Sistema <> '' then
      FieldByName('Sistema').AsString := FDACTEClassOwner.Sistema
    else
      FieldByName('Sistema').AsString := 'Projeto ACBr - http://acbr.sf.net';

    if FDACTEClassOwner.Usuario <> '' then
      FieldByName('Usuario').AsString := ' - ' + FDACTEClassOwner.Usuario
    else
      FieldByName('Usuario').AsString := '';

    if FDACTEClassOwner.Fax <> '' then
      FieldByName('Fax').AsString := ' - FAX ' + FDACTEClassOwner.Fax
    else
      FieldByName('Fax').AsString := '';

    FieldByName('Site').AsString := FDACTEClassOwner.Site;
    FieldByName('Email').AsString := FDACTEClassOwner.Email;

    if FDACTEClassOwner.ImprimirDescPorc then
      FieldByName('Desconto').AsString := 'DESC %'
    else
      FieldByName('Desconto').AsString := 'V.DESC.';

    if ((FCTe.Ide.tpEmis=teNormal) or (FCTe.Ide.tpEmis = teSCAN)) then
    begin
      FieldByName('ChaveAcesso_Descricao').AsString := 'CHAVE DE ACESSO';
      FieldByName('Contingencia_ID').AsString := '';

      if ((FDACTEClassOwner.CTeCancelada) or (FCTe.procCTe.cStat=101)) then
        FieldByName('Contingencia_Descricao').AsString := 'PROTOCOLO DE HOMOLOGAÇÃO DO CANCELAMENTO'
      else
        FieldByName('Contingencia_Descricao').AsString := 'PROTOCOLO DE AUTORIZAÇÃO DE USO';

      if CTeUtil.EstaVazio(FDACTEClassOwner.ProtocoloCTE) then
      begin
        if not (FCTe.Ide.tpEmis in [teContingencia, teFSDA]) and CTeUtil.EstaVazio(FCTe.procCTe.nProt) then
          FieldByName('Contingencia_Valor').AsString := 'CTe sem Autorização de Uso da SEFAZ'
        else
          FieldByName('Contingencia_Valor').AsString := FCTe.procCTe.nProt + ' ' + CTeUtil.SeSenao(FCTe.procCTe.dhRecbto <> 0, DateTimeToStr(FCTe.procCTe.dhRecbto), '');
      end
      else
        FieldByName('Contingencia_Valor').AsString := FDACTEClassOwner.ProtocoloCTE;
    end
    else
    begin
      vChave_Contingencia := CTeUtil.GerarChaveContingencia(FCTe);
      FieldByName('ChaveAcesso_Descricao').AsString := 'CHAVE DE ACESSO';
      FieldByName('Contingencia_ID').AsString := vChave_Contingencia;

      if ((FCTe.Ide.tpEmis = teContingencia) or (FCTe.Ide.tpEmis = teFSDA)) then
      begin
        FieldByName('Contingencia_Descricao').AsString := 'DADOS DA CT-E';
        FieldByName('Contingencia_Valor').AsString := CTeUtil.FormatarChaveContingencia(vChave_Contingencia);
      end
      else
      if (FCTe.Ide.tpEmis = teDPEC) then
      begin
        FieldByName('Contingencia_Descricao').AsString := 'NÚMERO DE REGISTRO DPEC';

        //precisa testar
//        if CTeUtil.EstaVazio(FDACTEClassOwner.ProtocoloCTE) then
//          raise EACBrCTeException.Create('Protocolo de Registro no DPEC não informado.')
//        else
//          FieldByName('Contingencia_Valor').AsString := FDACTEClassOwner.ProtocoloCTe;
      end;
    end;

//    FieldByName('LinhasPorPagina').AsInteger := FDACTEClassOwner.ProdutosPorPagina;
    Post;
  end;
end;

procedure TdmACBrCTeFR.CarregaRecebedor;
begin
  { Recebedor }
  with cdsRecebedor do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CNPJ', ftString, 18);
    FieldDefs.Add('XNome', ftString, 60);
    FieldDefs.Add('XFant', ftString, 60);
    FieldDefs.Add('XLgr', ftString, 60);
    FieldDefs.Add('Nro', ftString, 60);
    FieldDefs.Add('XCpl', ftString, 60);
    FieldDefs.Add('XBairro', ftString, 60);
    FieldDefs.Add('CMun', ftString, 7);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);
    FieldDefs.Add('CEP', ftString, 9);
    FieldDefs.Add('CPais', ftString, 4);
    FieldDefs.Add('XPais', ftString, 60);
    FieldDefs.Add('Fone', ftString, 15);
    FieldDefs.Add('IE', ftString, 14);
    FieldDefs.Add('IM', ftString, 15);
    FieldDefs.Add('IEST', ftString, 15);
    FieldDefs.Add('CRT', ftString, 1);

    CreateDataSet;
    Append;

    with FCTE.Receb do
    begin
      FieldByName('CNPJ').AsString := CTeUtil.FormatarCNPJ(CNPJCPF);
      FieldByName('XNome').AsString := XNome;
      with EnderReceb do
      begin
        FieldByName('Xlgr').AsString := XLgr;
        FieldByName('Nro').AsString := Nro;
        FieldByName('XCpl').AsString := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString := IntToStr(CMun);
        FieldByName('XMun').AsString := CollateBr(XMun);
        FieldByName('UF').AsString := UF;
        FieldByName('CEP').AsString := CTeUtil.FormatarCEP(CTeUtil.Poem_Zeros(CEP, 8));
        FieldByName('CPais').AsString := IntToStr(CPais);
        FieldByName('XPais').AsString := XPais;
        FieldByName('Fone').AsString := CTeUtil.FormatarFone(Fone);
      end;
      FieldByName('IE').AsString := IE;
    end;

    Post;
  end;

end;

procedure TdmACBrCTeFR.CarregaRemetente;
begin
  { Remetente }
  with cdsRemetente do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CNPJ', ftString, 18);
    FieldDefs.Add('XNome', ftString, 60);
    FieldDefs.Add('XFant', ftString, 60);
    FieldDefs.Add('XLgr', ftString, 60);
    FieldDefs.Add('Nro', ftString, 60);
    FieldDefs.Add('XCpl', ftString, 60);
    FieldDefs.Add('XBairro', ftString, 60);
    FieldDefs.Add('CMun', ftString, 7);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);
    FieldDefs.Add('CEP', ftString, 9);
    FieldDefs.Add('CPais', ftString, 4);
    FieldDefs.Add('XPais', ftString, 60);
    FieldDefs.Add('Fone', ftString, 15);
    FieldDefs.Add('IE', ftString, 14);
    FieldDefs.Add('IM', ftString, 15);
    FieldDefs.Add('IEST', ftString, 15);
    FieldDefs.Add('CRT', ftString, 1);

    CreateDataSet;
    Append;
    with FCTE.Rem do
    begin
      FieldByName('CNPJ').AsString := CTeUtil.FormatarCNPJ(CNPJCPF);
      FieldByName('XNome').AsString := XNome;
      FieldByName('XFant').AsString := XFant;
      with EnderReme do
      begin
        FieldByName('Xlgr').AsString := XLgr;
        FieldByName('Nro').AsString := Nro;
        FieldByName('XCpl').AsString := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString := IntToStr(CMun);
        FieldByName('XMun').AsString := CollateBr(XMun);
        FieldByName('UF').AsString := UF;
        FieldByName('CEP').AsString := CTeUtil.FormatarCEP(CTeUtil.Poem_Zeros(CEP, 8));
        FieldByName('CPais').AsString := IntToStr(CPais);
        FieldByName('XPais').AsString := XPais;
        FieldByName('Fone').AsString := CTeUtil.FormatarFone(Fone);
      end;
      FieldByName('IE').AsString := IE;
    end;
    Post;
  end;
end;

procedure TdmACBrCTeFR.CarregaSeguro;
var
  i: Integer;
begin
  with cdsSeguro do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('RESPONSAVEL',    ftString, 60);
    FieldDefs.Add('NOMESEGURADORA', ftString, 60);
    FieldDefs.Add('NUMEROAPOLICE',  ftString, 60);
    FieldDefs.Add('NUMEROAVERBACAO',ftString, 60);
    CreateDataSet;
    Append;
    //
   if CTe.InfSeg.Count > 0 then
   begin
     for I := 0 to CTe.InfSeg.Count - 1 do
     begin
        case CTe.InfSeg.Items[I].respSeg of
          rsRemetente :      FieldByName('RESPONSAVEL').AsString  := 'REMETENTE';
          rsExpedidor :      FieldByName('RESPONSAVEL').AsString  := 'EXPEDIDOR';
          rsRecebedor :      FieldByName('RESPONSAVEL').AsString  := 'RECEBEDOR';
          rsDestinatario :   FieldByName('RESPONSAVEL').AsString  := 'DESTINATARIO';
          rsEmitenteCTe :    FieldByName('RESPONSAVEL').AsString  := 'EMITENTE';
          rsTomadorServico : FieldByName('RESPONSAVEL').AsString  := 'TOMADOR';
        end;
        FieldByName('NOMESEGURADORA').AsString   := CTe.InfSeg.Items[I].xSeg;
        FieldByName('NUMEROAPOLICE').AsString    := CTe.InfSeg.Items[I].nApol;
        FieldByName('NUMEROAVERBACAO').AsString  := CTe.InfSeg.Items[I].nAver;
        Post;
     end;
   end
   else
   begin
       FieldByName('RESPONSAVEL').AsString  := '';
       FieldByName('NOMESEGURADORA').AsString   := '';
       FieldByName('NUMEROAPOLICE').AsString    := '';
       FieldByName('NUMEROAVERBACAO').AsString  := '';
      Post;
   end;

  end;

end;

procedure TdmACBrCTeFR.CarregaTomador;
begin
  { Tomador Outros }
  with cdsTomador do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CNPJ', ftString, 18);
    FieldDefs.Add('IE', ftString, 14);
    FieldDefs.Add('XNome', ftString, 60);
    FieldDefs.Add('XFant', ftString, 60);
    FieldDefs.Add('Fone', ftString, 12);
    FieldDefs.Add('XLgr', ftString, 255);
    FieldDefs.Add('XCpl', ftString, 60);
    FieldDefs.Add('XBairro', ftString, 60);
    FieldDefs.Add('CMun', ftString, 7);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);
    FieldDefs.Add('CEP', ftString, 9);
    FieldDefs.Add('CPais', ftString, 4);
    FieldDefs.Add('XPais', ftString, 60);
    CreateDataSet;
    Append;

   case FCTe.Ide.Toma03.Toma of
     tmRemetente :
     begin
        FieldByName('CNPJ').AsString := FCTe.Rem.CNPJCPF;
        FieldByName('XNome').AsString := FCTe.Rem.xNome;
        FieldByName('XFant').AsString := FCTe.Rem.xFant;
        FieldByName('IE').AsString := FCTe.Rem.IE;
        //
        FieldByName('Xlgr').AsString := FCTe.Rem.EnderReme.xLgr;
        FieldByName('XCpl').AsString := FCTe.Rem.EnderReme.xCpl;
        FieldByName('XBairro').AsString := FCTe.Rem.EnderReme.xBairro;
        FieldByName('CMun').AsString := IntToStr(FCTe.Rem.EnderReme.cMun);
        FieldByName('XMun').AsString := FCTe.Rem.EnderReme.xMun;
        FieldByName('UF').AsString := FCTe.Rem.EnderReme.UF;
        FieldByName('CEP').AsString := IntToStr(FCTe.Rem.EnderReme.CEP);
        FieldByName('CPais').AsString := IntToStr(FCTe.Rem.EnderReme.cPais);
        FieldByName('XPais').AsString := FCTe.Rem.EnderReme.xPais;
        FieldByName('Fone').AsString := '';
     end;

     tmDestinatario :
     begin
        FieldByName('CNPJ').AsString := FCTe.Dest.CNPJCPF;
        FieldByName('XNome').AsString := FCTe.Dest.xNome;
        FieldByName('IE').AsString := FCTe.Dest.IE;
        //
        FieldByName('Xlgr').AsString := FCTe.Dest.EnderDest.xLgr;
        FieldByName('XCpl').AsString := FCTe.Dest.EnderDest.xCpl;
        FieldByName('XBairro').AsString := FCTe.Dest.EnderDest.xBairro;
        FieldByName('CMun').AsString := IntToStr(FCTe.Dest.EnderDest.cMun);
        FieldByName('XMun').AsString := FCTe.Dest.EnderDest.xMun;
        FieldByName('UF').AsString := FCTe.Dest.EnderDest.UF;
        FieldByName('CEP').AsString := IntToStr(FCTe.Dest.EnderDest.CEP);
        FieldByName('CPais').AsString := IntToStr(FCTe.Dest.EnderDest.cPais);
        FieldByName('XPais').AsString := FCTe.Dest.EnderDest.xPais;
        FieldByName('Fone').AsString := '';
     end;

     tmExpedidor :
     begin
        FieldByName('CNPJ').AsString := FCTe.Exped.CNPJCPF;
        FieldByName('XNome').AsString := FCTe.Exped.xNome;
        FieldByName('IE').AsString := FCTe.Exped.IE;
        //
        FieldByName('Xlgr').AsString := FCTe.Exped.EnderExped.xLgr;
        FieldByName('XCpl').AsString := FCTe.Exped.EnderExped.xCpl;
        FieldByName('XBairro').AsString := FCTe.Exped.EnderExped.xBairro;
        FieldByName('CMun').AsString := IntToStr(FCTe.Exped.EnderExped.cMun);
        FieldByName('XMun').AsString := FCTe.Exped.EnderExped.xMun;
        FieldByName('UF').AsString := FCTe.Exped.EnderExped.UF;
        FieldByName('CEP').AsString := IntToStr(FCTe.Exped.EnderExped.CEP);
        FieldByName('CPais').AsString := IntToStr(FCTe.Exped.EnderExped.cPais);
        FieldByName('XPais').AsString := FCTe.Exped.EnderExped.xPais;
        FieldByName('Fone').AsString := '';
     end;

     tmRecebedor :
     begin
        FieldByName('CNPJ').AsString := FCTe.Receb.CNPJCPF;
        FieldByName('XNome').AsString := FCTe.Receb.xNome;
        FieldByName('IE').AsString := FCTe.Receb.IE;
        //
        FieldByName('Xlgr').AsString := FCTe.Receb.EnderReceb.xLgr;
        FieldByName('XCpl').AsString := FCTe.Receb.EnderReceb.xCpl;
        FieldByName('XBairro').AsString := FCTe.Receb.EnderReceb.xBairro;
        FieldByName('CMun').AsString := IntToStr(FCTe.Receb.EnderReceb.cMun);
        FieldByName('XMun').AsString := FCTe.Receb.EnderReceb.xMun;
        FieldByName('UF').AsString := FCTe.Receb.EnderReceb.UF;
        FieldByName('CEP').AsString := IntToStr(FCTe.Receb.EnderReceb.CEP);
        FieldByName('CPais').AsString := IntToStr(FCTe.Receb.EnderReceb.cPais);
        FieldByName('XPais').AsString := FCTe.Receb.EnderReceb.xPais;
        FieldByName('Fone').AsString := '';
     end;
   end;

   case FCTe.Ide.Toma4.Toma of
     tmOutros :
     begin
        FieldByName('CNPJ').AsString := FCTe.Ide.Toma4.CNPJCPF;
        FieldByName('XNome').AsString := FCTe.Ide.Toma4.xNome;
        FieldByName('IE').AsString := FCTe.Ide.Toma4.IE;
        //
        FieldByName('Xlgr').AsString := FCTe.Ide.Toma4.EnderToma.xLgr;
        FieldByName('XCpl').AsString := FCTe.Ide.Toma4.EnderToma.xCpl;
        FieldByName('XBairro').AsString := FCTe.Ide.Toma4.EnderToma.xBairro;
        FieldByName('CMun').AsString := IntToStr(FCTe.Ide.Toma4.EnderToma.cMun);
        FieldByName('XMun').AsString := FCTe.Ide.Toma4.EnderToma.xMun;
        FieldByName('UF').AsString := FCTe.Ide.Toma4.EnderToma.UF;
        FieldByName('CEP').AsString := IntToStr(FCTe.Ide.Toma4.EnderToma.CEP);
        FieldByName('CPais').AsString := IntToStr(FCTe.Ide.Toma4.EnderToma.cPais);
        FieldByName('XPais').AsString := FCTe.Ide.Toma4.EnderToma.xPais;
        FieldByName('Fone').AsString := '';
     end;
    end;
    Post;
  end;

end;



procedure TdmACBrCTeFR.CarregaVolumes;
var
  I : Integer;
begin
  with cdsVolumes do
  begin
    Close;
    FieldDefs.Clear;

    FieldDefs.Add('Produto', ftString, 100);
    FieldDefs.Add('CaracteristicaCarga', ftString, 100);
    FieldDefs.Add('ValorServico', ftFloat);

    FieldDefs.Add('Esp', ftString, 60);
    FieldDefs.Add('ValorEsp', ftFloat);
    FieldDefs.Add('PesoA', ftFloat);
    FieldDefs.Add('PesoB', ftFloat);
    FieldDefs.Add('QVol', ftFloat);

    CreateDataSet;
    Append;
    for I := 0 to CTe.InfCarga.InfQ.Count - 1 do
    begin
       FieldByName('Produto').AsString :=             CTe.InfCarga.proPred;
       FieldByName('CaracteristicaCarga').AsString := CTe.InfCarga.xOutCat;
       FieldByName('ValorServico').AsFloat :=  CTe.InfCarga.vMerc;

       case CTe.InfCarga.InfQ.Items[I].cUnid of
          uM3   : begin
                     FieldByName('Esp').AsString := 'M3';
                     FieldByName('ValorEsp').AsFloat  := CTe.InfCarga.InfQ.Items[I].qCarga;
                     FieldByName('PesoA').AsFloat := 0;
                     FieldByName('PesoB').AsFloat := 0;
                  end;
          uKG   : begin
                     FieldByName('Esp').AsString := '';
                     FieldByName('ValorEsp').AsFloat  := 0;
                     //
                     FieldByName('PesoA').AsFloat := CTe.InfCarga.InfQ.Items[I].qCarga;
                     FieldByName('PesoB').AsFloat := CTe.InfCarga.InfQ.Items[I].qCarga
                  end;
          uTON  : begin
                     FieldByName('Esp').AsString := 'TON';
                     FieldByName('ValorEsp').AsFloat  := CTe.InfCarga.InfQ.Items[I].qCarga;
                     //
                     FieldByName('QVol').AsFloat  := 0;
                     FieldByName('PesoA').AsFloat := 0;
                     FieldByName('PesoB').AsFloat := 0;
                  end;
          uUNIDADE : begin
                        FieldByName('Esp').AsString := '';
                        FieldByName('ValorEsp').AsFloat  := 0;
                        //
                        FieldByName('QVol').AsFloat  := CTe.InfCarga.InfQ.Items[I].qCarga;
                     end;
          uLITROS  : begin
                        FieldByName('Esp').AsString := 'LT';
                        FieldByName('ValorEsp').AsFloat  := CTe.InfCarga.InfQ.Items[I].qCarga;
                        //
                        FieldByName('QVol').AsFloat  := 0;
                        FieldByName('PesoA').AsFloat := 0;
                        FieldByName('PesoB').AsFloat := 0;
                     end;
        end;
    end;
    Post;
  end;

end;

constructor TdmACBrCTeFR.Create(AOwner: TComponent);
begin
  inherited;
  FDACTEClassOwner := TACBrCteDACTEClass(AOwner);
end;

end.
