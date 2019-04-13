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

unit pcnRetDPEC;

interface uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor;

type

  //////////////////////////////////////////////////////////////////////////////
  //                                                                          //
  //    E M   D E S E N V O L V I M E N T O   -   N Ã O   T E S T A D O       //
  //                                                                          //
  //////////////////////////////////////////////////////////////////////////////

  TRetDPEC = class(TPersistent)
  private
    FLeitor: TLeitor;
    FId: string;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: string;
    FcStat: integer;
    FxMotivo: string;
    FdhRegDPEC: TDateTime;
    FnRegDPEC: string;
    FchNFE: string;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property Id: string read FId write FId;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb;
    property verAplic: string read FverAplic write FverAplic;
    property cStat: integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;
    property dhRegDPEC: TDateTime read FdhRegDPEC write FdhRegDPEC;
    property nRegDPEC: string read FnRegDPEC write FnRegDPEC;
    property chNFE: string read FchNFE write FchNFE;
  end;

implementation

{ TRetDPEC }

constructor TRetDPEC.Create;
begin
  FLeitor := TLeitor.Create;
end;

destructor TRetDPEC.Destroy;
begin
  FLeitor.Free;
  inherited;
end;

function TRetDPEC.LerXml: boolean;
var
  ok: boolean;
begin
  Result := False;
  try
    if Leitor.rExtrai(1, 'infDPECReg') <> '' then
    begin
      (*AR04 *)FId := Leitor.rAtributo('infDPECReg Id=');
      (*AR05 *)FtpAmb := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
      (*AR06 *)FverAplic := Leitor.rCampo(tcStr, 'verAplic');
      (*AR07 *)FcStat := Leitor.rCampo(tcInt, 'cStat');
      (*AR08 *)FxMotivo := Leitor.rCampo(tcStr, 'xMotivo');
      if cStat = 124 then
      begin
        (*AR09 *)FdhRegDPEC := Leitor.rCampo(tcDatHor, 'dhRegDPEC');
        (*AR10 *)nRegDPEC := Leitor.rCampo(tcStr, 'nRegDPEC');
        
        (*AR10 *)FchNFe := Leitor.rCampo(tcStr, 'chNFe');
      end;
      Result := True;
    end;
  except
    Result := False;
  end;
end;

end.

