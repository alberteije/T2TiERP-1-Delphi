////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org/nfe                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordenação: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//      Versão: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licença: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa é software livre; você pode redistribuí-lo    //
//              e/ou modificá-lo sob os termos da Licença Pública Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              versão 2 da Licença como (a seu critério) qualquer versão     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa é distribuído na expectativa de ser útil,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia implícita de  //
//              COMERCIALIZAÇÃO ou de ADEQUAÇÃO A QUALQUER PROPÓSITO EM       //
//              PARTICULAR. Consulte a Licença Pública Geral GNU para obter   //
//              mais detalhes. Você deve ter recebido uma cópia da Licença    //
//              Pública Geral GNU junto com este programa; se não, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licença oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licença  não  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  NFe", não  podendo o mesmo ser    //
//              utilizado sem previa autorização.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manutenção deste cabeçalho junto ao código     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{$I ACBr.inc}

unit pcteProcCTe;

interface uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnGerador, pcnLeitor;

type

  TPcnPadraoNomeProcCTe = (tpnPublico, tpnPrivado);

  TProcCTe = class(TPersistent)
  private
    FGerador: TGerador;
    FSchema: TpcnSchema;
    FPathCTe: string;
    FPathRetConsReciCTe: string;
    FPathRetConsSitCTe: string;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: string;
    FchCTe: string;
    FdhRecbto: TDateTime;
    FnProt: string;
    FdigVal: string;
    FcStat: integer;
    FxMotivo: string;
  public
    constructor Create;
    destructor Destroy; override;
    function GerarXML: boolean;
    function ObterNomeArquivo(const PadraoNome: TPcnPadraoNomeProcCTe = tpnPrivado): string;
  published
    property Gerador: TGerador read FGerador write FGerador;
    property Schema: TpcnSchema read Fschema write Fschema;
    property PathCTe: string read FPathCTe write FPathCTe;
    property PathRetConsReciCTe: string read FPathRetConsReciCTe write FPathRetConsReciCTe;
    property PathRetConsSitCTe: string read FPathRetConsSitCTe write FPathRetConsSitCTe;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb;
    property verAplic: string read FverAplic write FverAplic;
    property chCTe: string read FchCTe write FchCTe;
    property dhRecbto: TDateTime read FdhRecbto write FdhRecbto;
    property nProt: string read FnProt write FnProt;
    property digVal: string read FdigVal write FdigVal;
    property cStat: integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;
  end;

implementation

{ TProcCTe }

constructor TProcCTe.Create;
begin
  FGerador := TGerador.Create;
end;

destructor TProcCTe.Destroy;
begin
  FGerador.Free;
  inherited;
end;

function TProcCTe.ObterNomeArquivo(const PadraoNome: TPcnPadraoNomeProcCTe = tpnPrivado): string;
var
  s: string;
begin
  Result := FchCTe + '-procCTe.xml';
  if PadraoNome = tpnPublico then
  begin
    s := '00' + retornarVersaoLayout(FSchema, tlProcCTe);
    Result := FnProt + '_v' + copy(s, length(s) - 4, 5) + '-procCTe.xml';
  end;
end;

function TProcCTe.GerarXML: boolean;

function PreencherTAG(const TAG: string; Texto: string): string;
begin
  result := '<' + TAG + '>' + RetornarConteudoEntre(Texto, '<' + TAG + '>', '</' + TAG + '>') + '</' + TAG + '>';
end;

var
  XMLCTe: TstringList;
  XMLinfProt: TstringList;
  XMLinfProt2: TstringList;
  wCstat: string;
  xProtCTe: string;
  LocLeitor: TLeitor;
  i : Integer;
  ProtLido : Boolean; // Protocolo lido do Arquivo
begin
  Result := False;
  ProtLido := False;

//  if retornarVersaoLayout(FSchema, tlProcCTe) = '1.03'
//   then begin
    XMLCTe := TStringList.Create;
    XMLinfProt := TStringList.Create;
    XMLinfProt2 := TStringList.Create;
    xProtCTe := '';
    FnProt := '';

    // Arquivo CTe
    if not FileExists(FPathCTe)
     then Gerador.wAlerta('XR04', 'CTe', 'CTe', ERR_MSG_ARQUIVO_NAO_ENCONTRADO)
     else XMLCTe.LoadFromFile(FPathCTe);

    FchCTe := RetornarConteudoEntre(XMLCTe.Text, 'Id="CTe', '"');
    if trim(FchCTe) = ''
     then Gerador.wAlerta('XR01', 'ID/CTe', 'Numero da chave do CTe', ERR_MSG_VAZIO);

    if (FPathRetConsReciCTe = '') and (FPathRetConsSitCTe = '')
     then begin
      if (FchCTe = '') and (FnProt = '')
       then Gerador.wAlerta('XR06', 'RECIBO/SITUAÇÃO', 'RECIBO/SITUAÇÃO', ERR_MSG_ARQUIVO_NAO_ENCONTRADO)
       else ProtLido := True;
     end;

    // Gerar arquivo pelo Recibo do CTe
    if (FPathRetConsReciCTe <> '') and (FPathRetConsSitCTe = '') and (not ProtLido)
     then  begin
      if not FileExists(FPathRetConsReciCTe)
       then Gerador.wAlerta('XR06', 'PROTOCOLO', 'PROTOCOLO', ERR_MSG_ARQUIVO_NAO_ENCONTRADO)
       else begin
        // XMLinfProt.LoadFromFile(FPathRetConsReciCTe);
        I := 0;
        LocLeitor := TLeitor.Create;
        LocLeitor.CarregarArquivo(FPathRetConsReciCTe);
        while LocLeitor.rExtrai(1, 'protCTe', '', i + 1) <> '' do
         begin
           if LocLeitor.rCampo(tcStr, 'chCTe') = FchCTe
            then FnProt := LocLeitor.rCampo(tcStr, 'nProt');
           if trim(FnProt) = ''
            then Gerador.wAlerta('XR01', 'PROTOCOLO/CTe', 'Numero do protocolo', ERR_MSG_VAZIO)
            else begin
             xProtCTe := LocLeitor.rExtrai(1, 'protCTe', '', i + 1)+'</protCTe>';
             Gerador.ListaDeAlertas.Clear;
             break;
            end;
            I := I + 1;
         end;
         LocLeitor.Free;
       end;
    end;

    // Gerar arquivo pelo arquivo de consulta da situação do CTe              //
    if (FPathRetConsReciCTe = '') and (FPathRetConsSitCTe <> '') and (not ProtLido)
     then begin
      if not FileExists(FPathRetConsSitCTe)
       then Gerador.wAlerta('XR06', 'SITUAÇÃO', 'SITUAÇÃO', ERR_MSG_ARQUIVO_NAO_ENCONTRADO)
       else begin
        XMLinfProt.LoadFromFile(FPathRetConsSitCTe);

        wCstat:=RetornarConteudoEntre(XMLinfProt.text, '<cStat>', '</cStat>');
        if trim(wCstat) = '101' then //esta cancelada
           XMLinfProt2.Text:=RetornarConteudoEntre(XMLinfProt.text, '<infCanc>', '</infCanc>')
        else
           XMLinfProt2.Text:=RetornarConteudoEntre(XMLinfProt.text, '<infProt>', '</infProt>');

        xProtCTe :=
           {$IFDEF PL_103}
              '<protCTe ' + V1_03 +'>' +
           {$ENDIF}
           {$IFDEF PL_104}
              '<protCTe ' + V1_04 +'>' +
           {$ENDIF}
                '<infProt>' +
                  PreencherTAG('tpAmb', XMLinfProt.text) +
                  PreencherTAG('verAplic', XMLinfProt.text) +
                  PreencherTAG('chCTe', XMLinfProt.text) +
                  PreencherTAG('dhRecbto', XMLinfProt2.text) +
                  PreencherTAG('nProt', XMLinfProt2.text) +
                  PreencherTAG('digVal', XMLinfProt.text) +
                  PreencherTAG('cStat', XMLinfProt.text) +
                  PreencherTAG('xMotivo', XMLinfProt.text) +
                '</infProt>' +
              '</protCTe>';
      end;
    end;

    if ProtLido
     then begin
      xProtCTe :=
           {$IFDEF PL_103}
            '<protCTe ' + V1_03 + '>' +
           {$ENDIF}
           {$IFDEF PL_104}
            '<protCTe ' + V1_04 + '>' +
           {$ENDIF}
              '<infProt>' +
                '<tpAmb>'+TpAmbToStr(FtpAmb)+'</tpAmb>'+
                '<verAplic>'+FverAplic+'</verAplic>'+
                '<chCTe>'+FchCTe+'</chCTe>'+
                '<dhRecbto>'+FormatDateTime('yyyy-mm-dd"T"hh:nn:ss',FdhRecbto)+'</dhRecbto>'+
                '<nProt>'+FnProt+'</nProt>'+
                '<digVal>'+FdigVal+'</digVal>'+
                '<cStat>'+IntToStr(FcStat)+'</cStat>'+
                '<xMotivo>'+FxMotivo+'</xMotivo>'+
              '</infProt>'+
            '</protCTe>';
     end;

    // Gerar arquivo
    if Gerador.ListaDeAlertas.Count = 0 then
    begin
      Gerador.ArquivoFormatoXML := '';
      Gerador.wGrupo(ENCODING_UTF8, '', False);
    {$IFDEF PL_103}
      Gerador.wGrupo('cteProc ' + V1_03 + ' ' + NAME_SPACE_CTE, '');
    {$ENDIF}
    {$IFDEF PL_104}
      Gerador.wGrupo('cteProc ' + V1_04 + ' ' + NAME_SPACE_CTE, '');
    {$ENDIF}
      Gerador.wTexto('<CTe xmlns' + RetornarConteudoEntre(XMLCTe.Text, '<CTe xmlns', '</CTe>') + '</CTe>');
      Gerador.wTexto(xProtCTe);
      Gerador.wGrupo('/cteProc');
    end;

    XMLCTe.Free;
    XMLinfProt.Free;
    XMLinfProt2.Free;
    Result := (Gerador.ListaDeAlertas.Count = 0);

//  end;
end;

end.

