////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org                                       //
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

unit pcnRetConsSitNFe;

interface uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor;

type

  //////////////////////////////////////////////////////////////////////////////
  //                                                                          //
  //    E M   D E S E N V O L V I M E N T O   -   N Ã O   T E S T A D O       //
  //                                                                          //
  //////////////////////////////////////////////////////////////////////////////

  TRetConsSitNFe = class(TPersistent)
  private
    FLeitor: TLeitor;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: string;
    FcStat: Integer;
    FxMotivo: string;
    FcUF: integer;
    FchNFe: string;
    FdhRecbto: TDateTime;
    FnProt: string;
    FdigVal: string;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb;
    property verAplic: string read FverAplic write FverAplic;
    property cStat: Integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;
    property cUF: integer read FcUF write FcUF;
    property chNFe: string read FchNFe write FchNFe;
    property dhRecbto: TDateTime read FdhRecbto write FdhRecbto;
    property nProt: string read FnProt write FnProt;
    property digVal: string read FdigVal write FdigVal;
  end;

implementation

{ TRetConsSitNFe }

constructor TRetConsSitNFe.Create;
begin
  FLeitor := TLeitor.Create;
end;

destructor TRetConsSitNFe.Destroy;
begin
  FLeitor.Free;
  inherited;
end;

function TRetConsSitNFe.LerXml: boolean;
var
  ok: boolean;
begin
  Result := False;
  try
    if leitor.rExtrai(1, 'infProt') <> '' then
    begin
      (*ER05 *)FtpAmb := StrToTpAmb(ok, leitor.rCampo(tcStr, 'tpAmb'));
      (*ER06 *)FverAplic := leitor.rCampo(tcStr, 'verAplic');
      (*ER07 *)FcStat := leitor.rCampo(tcInt, 'cStat');
      (*ER08 *)FxMotivo := leitor.rCampo(tcStr, 'xMotivo');
      (*ER08a*)FcUF := leitor.rCampo(tcInt, 'cUF');
      (*ER09 *)FchNFe := leitor.rCampo(tcStr, 'chNFe');
      (*ER10 *)FdhRecbto := leitor.rCampo(tcDatHor, 'dhRecbto');
      (*ER11 *)FnProt := leitor.rCampo(tcStr, 'nProt');
      (*ER12 *)FdigVal := leitor.rCampo(tcStr, 'digVal');
      Result := True;
    end;
  except
    Result := False;
  end;
end;

end.

