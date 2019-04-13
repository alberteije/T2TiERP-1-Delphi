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

unit pcteConsSitCTe;

interface uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnGerador;

type

  //////////////////////////////////////////////////////////////////////////////
  //                                                                          //
  //    E M   D E S E N V O L V I M E N T O   -   N Ã O   T E S T A D O       //
  //                                                                          //
  //////////////////////////////////////////////////////////////////////////////

  TConsSitCTe = class(TPersistent)
  private
    FGerador: TGerador;
    FSchema: TpcnSchema;
    FtpAmb: TpcnTipoAmbiente;
    FchCTe: string;
  public
    constructor Create;
    destructor Destroy; override;
    function GerarXML: boolean;
    function ObterNomeArquivo: string;
  published
    property Gerador: TGerador read FGerador write FGerador;
    property schema: TpcnSchema read Fschema write Fschema;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb;
    property chCTe: string read FchCTe write FchCTe;
  end;

implementation

{ TConsSitCTe }

constructor TConsSitCTe.Create;
begin
  FGerador := TGerador.Create;
end;

destructor TConsSitCTe.Destroy;
begin
  FGerador.Free;
  inherited;
end;

function TConsSitCTe.ObterNomeArquivo: string;
begin
  Result := SomenteNumeros(FchCTe) + '-ped-sit.xml';
end;

function TConsSitCTe.GerarXML: boolean;
begin
  Result := False;
//  if retornarVersaoLayout(Fschema, tlConsSitCTe) = '1.03' then
//  begin
    Gerador.ArquivoFormatoXML := '';

//    Gerador.wGrupo(ENCODING_UTF8, '', False);
 {$IFDEF PL_103}
    Gerador.wGrupo('consSitCTe ' + NAME_SPACE_CTE + ' ' + V1_03);
 {$ENDIF}
 {$IFDEF PL_104}
    Gerador.wGrupo('consSitCTe ' + NAME_SPACE_CTE + ' ' + V1_04);
 {$ENDIF}
    Gerador.wCampo(tcStr, 'EP03', 'tpAmb', 001, 001, 1, tpAmbToStr(FtpAmb), DSC_TPAMB);
    Gerador.wCampo(tcStr, 'EP04', 'xServ', 009, 009, 1, 'CONSULTAR', DSC_XSERV);
    Gerador.wCampo(tcEsp, 'EP05', 'chCTe', 044, 044, 1, SomenteNumeros(FchCTe), DSC_CHCTe);
    if not ValidarChave('CTe' + SomenteNumeros(FchCTe)) then
      Gerador.wAlerta('EP05', 'chCTe', '', 'Chave do CTe inválida');
    Gerador.wGrupo('/consSitCTe');

    Result := (Gerador.ListaDeAlertas.Count = 0);
//  end;
end;

end.

