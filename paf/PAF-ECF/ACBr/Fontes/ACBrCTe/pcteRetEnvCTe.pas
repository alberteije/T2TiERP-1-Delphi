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

unit pcteRetEnvCTe;

interface uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor;

type

  //////////////////////////////////////////////////////////////////////////////
  //                                                                          //
  //    E M   D E S E N V O L V I M E N T O   -   N Ã O   T E S T A D O       //
  //                                                                          //
  //////////////////////////////////////////////////////////////////////////////

  TInfREC = class
  private
    FnRec: string;
    FdhRecbto: TDateTime;
    FtMed: integer;
  public
    property nRec: string read FnRec write FnRec;
    property dhRecbto: TDateTime read FdhRecbto write FdhRecbto;
    property tMed: integer read FtMed write FtMed;
  end;

  TretEnvCTe = class(TPersistent)
  private
    FtpAmb: TpcnTipoAmbiente;
    FcStat: integer;
    FLeitor: TLeitor;
    FcUF: integer;
    FverAplic: string;
    FxMotivo: string;
    FinfRec: TInfREC;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb; //default taHomologacao;
    property verAplic: string read FverAplic write FverAplic;
    property cStat: integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;
    property cUF: integer read FcUF write FcUF;
    property infRec: TInfREC read FinfRec write FinfRec;
  end;

implementation

{ TretEnvCTe }

constructor TretEnvCTe.Create;
begin
  FLeitor := TLeitor.Create;
  FinfRec := TInfREC.Create
end;

destructor TretEnvCTe.Destroy;
begin
  FLeitor.Free;
  FinfRec.Free;
  inherited;
end;

function TretEnvCTe.LerXml: boolean;
var
  ok: boolean;
begin
  result := False;
  try
    Leitor.Grupo := Leitor.Arquivo;
    if leitor.rExtrai(1, 'retEnviCte') <> '' then
    begin
      (*AR03 *)FtpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
      (*AR03a*)FcUF      := Leitor.rCampo(tcInt, 'cUF');
      (*AR04 *)FverAplic := Leitor.rCampo(tcStr, 'verAplic');
      (*AR05 *)FcStat    := Leitor.rCampo(tcInt, 'cStat');
      (*AR06 *)FxMotivo  := Leitor.rCampo(tcStr, 'xMotivo');

      //       Grupo infRec - Dados do Recibo do Lote (Só é gerado se o Lote for aceito)
      (*AR08 *)infRec.nRec      := Leitor.rCampo(tcStr, 'nRec');
      (*AR09 *)infRec.FdhRecbto := Leitor.rCampo(tcDatHor, 'dhRecbto');
      (*AR10 *)infRec.FtMed     := Leitor.rCampo(tcInt, 'tMed');

      Result := True;
    end;

  except
    result := false;
  end;
end;

end.

