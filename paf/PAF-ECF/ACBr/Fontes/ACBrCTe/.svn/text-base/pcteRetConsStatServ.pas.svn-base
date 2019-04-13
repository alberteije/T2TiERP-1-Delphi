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

unit pcteRetConsStatServ;

interface uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor;

type

  //////////////////////////////////////////////////////////////////////////////
  //                                                                          //
  //    E M   D E S E N V O L V I M E N T O   -   N Ã O   T E S T A D O       //
  //                                                                          //
  //////////////////////////////////////////////////////////////////////////////

  TRetConsStatServ = class(TPersistent)
  private
    FLeitor: TLeitor;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: string;
    FcStat: integer;
    FxMotivo: string;
    FcUF: integer;
    FdhRecbto: TDateTime;
    FtMed: integer;
    FdhRetorno: TDateTime;
    FxObs: string;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb;
    property verAplic: string read FverAplic write FverAplic;
    property cStat: integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;
    property cUF: integer read FcUF write FcUF;
    property dhRecbto: TDateTime read FdhRecbto write FdhRecbto;
    property tMed: integer read FtMed write FtMed;
    property dhRetorno: TDateTime read FdhRetorno write FdhRetorno;
    property xObs: string read FxObs write FxObs;
  end;

implementation

{ TRetConsStatServ }

constructor TRetConsStatServ.Create;
begin
  FLeitor := TLeitor.Create;
end;

destructor TRetConsStatServ.Destroy;
begin
  FLeitor.Free;
  inherited;
end;

function TRetConsStatServ.LerXml: boolean;
var
  ok: boolean;
begin
  Result := False;
  try
    Leitor.Grupo := Leitor.Arquivo;

    if leitor.rExtrai(1, 'retConsStatServCte') <> '' then
    begin
      (*FR03*)FtpAmb     := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
      (*FR04*)FverAplic  := Leitor.rCampo(tcStr, 'verAplic');
      (*FR05*)FcStat     := Leitor.rCampo(tcInt, 'cStat');
      (*FR06*)FxMotivo   := Leitor.rCampo(tcStr, 'xMotivo');
      (*FR07*)FcUF       := Leitor.rCampo(tcInt, 'cUF');
      (*FR08*)FdhRecbto  := Leitor.rCampo(tcDatHor, 'dhRecbto');
      (*FR09*)FtMed      := Leitor.rCampo(tcInt, 'tMed');
      (*FR08*)FdhRetorno := Leitor.rCampo(tcDatHor, 'dhRetorno');
      (*FR11*)FxObs      := Leitor.rCampo(tcStr, 'xObs');

      Result := True;
    end;

  except
    Result := False;
  end;
end;

end.

