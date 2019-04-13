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

unit pcteConsCad;

interface uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnGerador;

type

  //////////////////////////////////////////////////////////////////////////////
  //                                                                          //
  //    E M   D E S E N V O L V I M E N T O   -   N Ã O   T E S T A D O       //
  //                                                                          //
  //////////////////////////////////////////////////////////////////////////////

  TConsCad = class(TPersistent)
  private
    FGerador: TGerador;
    FSchema: TpcnSchema;
    FUF: string;
    FIE: string;
    FCNPJ: string;
    FCPF: string;
  public
    constructor Create;
    destructor Destroy; override;
    function GerarXML: boolean;
  published
    property Gerador: TGerador read FGerador write FGerador;
    property schema: TpcnSchema read Fschema write Fschema;
    property UF: string read FUF write FUF;
    property IE: string read FIE write FIE;
    property CNPJ: string read FCNPJ write FCNPJ;
    property CPF: string read FCPF write FCPF;
  end;

implementation

{ TConsCad }

constructor TConsCad.Create;
begin
  FGerador := TGerador.Create;
end;

destructor TConsCad.Destroy;
begin
  FGerador.Free;
  inherited;
end;

function TConsCad.GerarXML: boolean;
var
  i: integer;
begin
  Gerador.ArquivoFormatoXML := '';

  if retornarVersaoLayout(Fschema, tlConsCad) = '1.01' then
   begin
    Gerador.wGrupo(ENCODING_UTF8, '', False);
    Gerador.wGrupo('ConsCad ' + NAME_SPACE + ' ' + V1_01);
   end;
  if retornarVersaoLayout(Fschema, tlConsCad) = '2.00' then
   begin
    Gerador.wGrupo('ConsCad ' + NAME_SPACE + ' ' + V2_00);
   end;

  Gerador.wGrupo('infCons');
  Gerador.wCampo(tcStr, 'GP04', 'xServ ', 008, 008, 1, 'CONS-CAD', DSC_XSERV);
  Gerador.wCampo(tcStr, 'GP05', 'UF    ', 002, 002, 1, FUF, DSC_UF);
  i := 0;
  if FIE <> EmptyStr then
   begin
    i := 1;
    Gerador.wCampo(tcStr, 'GP06', 'IE  ', 002, 014, 1, FIE, DSC_IE);
   end;
  if (FCNPJ <> EmptyStr) and (i = 0) then
   begin
    i := 1;
    Gerador.wCampoCNPJCPF('GP07', 'CNPJ', FCNPJ, CODIGO_BRASIL);
   end;
  if (FCPF <> EmptyStr) and (i = 0) then
    Gerador.wCampoCNPJCPF('GP08', 'CPF ', FCPF, CODIGO_BRASIL);
  Gerador.wGrupo('/infCons');
  Gerador.wGrupo('/ConsCad');

  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

end.

