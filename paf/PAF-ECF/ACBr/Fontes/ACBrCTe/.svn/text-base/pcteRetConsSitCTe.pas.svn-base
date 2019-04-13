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

unit pcteRetConsSitCTe;

interface uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor, pcteProcCTe, pcteRetCancCTe;

type

  //////////////////////////////////////////////////////////////////////////////
  //                                                                          //
  //    E M   D E S E N V O L V I M E N T O   -   N Ã O   T E S T A D O       //
  //                                                                          //
  //////////////////////////////////////////////////////////////////////////////

  TRetConsSitCTe = class(TPersistent)
  private
    FLeitor: TLeitor;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: string;
    FcStat: Integer;
    FxMotivo: string;
    FcUF: integer;
    FchCTe: string;
    FprotCTe: TProcCTe;
    FretCancCTe: TRetCancCTe;
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
    property chCTe: string read FchCTe write FchCTe;
    property protCTe: TProcCTe read FprotCTe write FprotCTe;
    property retCancCTe: TRetCancCTe read FretCancCTe write FretCancCTe;
  end;

implementation

{ TRetConsSitCTe }

constructor TRetConsSitCTe.Create;
begin
  FLeitor := TLeitor.Create;
  FprotCTe := TProcCTe.create;
  FretCancCTe := TRetCancCTe.create;
end;

destructor TRetConsSitCTe.Destroy;
begin
  FLeitor.Free;
  FprotCTe.Free;
  FretCancCTe.Free;
  inherited;
end;

function TRetConsSitCTe.LerXml: boolean;
var
  ok: boolean;
begin
  Result := False;
  try
    if leitor.rExtrai(1, 'retConsSitCTe') <> '' then
    begin
      (*ER03 *)FtpAmb    := StrToTpAmb(ok, leitor.rCampo(tcStr, 'tpAmb'));
      (*ER04 *)FverAplic := leitor.rCampo(tcStr, 'verAplic');
      (*ER05 *)FcStat    := leitor.rCampo(tcInt, 'cStat');
      (*ER06 *)FxMotivo  := leitor.rCampo(tcStr, 'xMotivo');
      (*ER07 *)FcUF      := leitor.rCampo(tcInt, 'cUF');
//      (*ER07a*)FchCTe    := leitor.rCampo(tcStr, 'chCTe'); // Comentado por Italo em 28/08/2010

      if FcStat in  [100,101] then
       begin
         if (Leitor.rExtrai(1, 'protCTe') <> '') or (Leitor.rExtrai(1, 'infProt') <> '') then
          begin
            protCTe.tpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
            protCTe.verAplic := Leitor.rCampo(tcStr, 'verAplic');
            protCTe.chCTe    := Leitor.rCampo(tcStr, 'chCTe');
            protCTe.dhRecbto := Leitor.rCampo(tcDatHor, 'dhRecbto');
            protCTe.nProt    := Leitor.rCampo(tcStr, 'nProt');
            protCTe.digVal   := Leitor.rCampo(tcStr, 'digVal');
            protCTe.cStat    := Leitor.rCampo(tcInt, 'cStat');
            protCTe.xMotivo  := Leitor.rCampo(tcStr, 'xMotivo');

            // Incluido por Italo em 09/03/2011
            FchCTe           := protCTe.chCTe;
         end;
       end;

      if FcStat = 101 then
       begin
         if Leitor.rExtrai(1, 'infCanc') <> '' then
          begin
            retCancCTe.tpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
            retCancCTe.verAplic := Leitor.rCampo(tcStr, 'verAplic');
            retCancCTe.cStat    := Leitor.rCampo(tcInt, 'cStat');
            retCancCTe.xMotivo  := Leitor.rCampo(tcStr, 'xMotivo');
            retCancCTe.cUF      := Leitor.rCampo(tcInt, 'cUF');
            retCancCTe.chCTe    := Leitor.rCampo(tcStr, 'chCTe');
            retCancCTe.dhRecbto := Leitor.rCampo(tcDatHor, 'dhRecbto');
            retCancCTe.nProt    := Leitor.rCampo(tcStr, 'nProt');

            // Incluido por Italo em 09/03/2011
            FchCTe           := retCancCTe.chCTe;
         end;
       end;

      Result := True;
    end;
    
  except
    Result := False;
  end;
end;

end.

