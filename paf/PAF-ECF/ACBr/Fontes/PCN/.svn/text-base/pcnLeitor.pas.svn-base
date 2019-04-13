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

unit pcnLeitor;

interface uses

  SysUtils, Classes, StrUtils, 
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao;

type

  TLeitor = class(TPersistent)
  private
    FArquivo: AnsiString;
    FGrupo: AnsiString;
    FNivel: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    function rExtrai(const nivel: integer; const TagInicio: string; TagFim: string = ''; const item: integer = 1): AnsiString;
    function rCampo(const Tipo: TpcnTipoCampo; TAG: string): variant;
    function rCampoCNPJCPF: string;
    function rAtributo(Atributo: string): variant;
    function CarregarArquivo(const CaminhoArquivo: string): boolean; overload;
    function CarregarArquivo(const Stream: TStringStream): boolean; overload;
    function PosLast(const SubStr, S: AnsiString ): Integer;
  published
    property Arquivo: AnsiString read FArquivo write FArquivo;
    property Grupo: AnsiString read FGrupo write FGrupo;
  end;

implementation

{ TLeitor }

constructor TLeitor.Create;
var
  i: integer;
begin
  inherited Create;
  FNivel := TStringList.Create;
  for i := 1 to 10 do
    FNivel.add('');
end;

destructor TLeitor.Destroy;
begin
  FNivel.Free;
  inherited;
end;

function TLeitor.CarregarArquivo(const CaminhoArquivo: string): boolean;
var
  ArquivoXML: TStringList;
begin
  //NOTA: Carrega o arquivo xml na memória para posterior leitura de sua tag's
  ArquivoXML := TStringList.Create;
  try
    try
      ArquivoXML.LoadFromFile(CaminhoArquivo);
      FArquivo := ArquivoXML.Text;
      Result := True;
    except
      Result := False;
      raise;
    end;
  finally
    ArquivoXML.Free;
  end;
end;

function TLeitor.CarregarArquivo(const Stream: TStringStream): boolean;
begin
  //NOTA: Carrega o arquivo xml na memória para posterior leitura de sua tag's
  try
    FArquivo := Stream.DataString;
    Result := True;
  except
    Result := False;
    raise;
  end;
end;

function TLeitor.rExtrai(const nivel: integer; const TagInicio: string; TagFim: string = ''; const item: integer = 1): AnsiString;
var
  Texto: AnsiString;
  i: integer;
begin
  //NOTA: Extrai um grupo de dentro do nivel informado
  FNivel.strings[0] := FArquivo;
  if Trim(TagFim) = '' then
    TagFim := TagInicio;
  Texto := FNivel.Strings[nivel - 1];
  Result := '';
  FGrupo := '';
  for i := 1 to item do
    if i < item then
      Texto := copy(Texto, pos('</' + Trim(TagFim) + '>', Texto) + length(Trim(TagFim)) + 3, maxInt);
  i := pos('<' + Trim(TagInicio) + '>', Texto);
  if i = 0 then
    i := pos('<' + Trim(TagInicio) + ' ', Texto);
  if i = 0 then
    exit;
  Texto := copy(Texto, i, maxInt);
  Result := TrimRight(copy(Texto, 1, pos('</' + Trim(TagFim) + '>', Texto) - 1));
  FNivel.strings[nivel] := Result;
  FGrupo := result;
end;

function TLeitor.rCampoCNPJCPF: string;
begin
  result := rCampo(tcStr, 'CNPJ');
  if trim(result) = '' then
    result := rCampo(tcStr, 'CPF');
end;

function TLeitor.rCampo(const Tipo: TpcnTipoCampo; TAG: string): variant;
var
  ConteudoTag: string;
  inicio, fim: integer;
begin
  Tag := Trim(TAG);
  inicio := pos('<' + Tag + '>', FGrupo);
  if inicio = 0 then
    ConteudoTag := ''
  else
  begin
    inicio := inicio + Length(Tag) + 2;
    fim := pos('</' + Tag + '>', FGrupo) - inicio;
    ConteudoTag := trim(copy(FGrupo, inicio, fim));
  end;
  try
     if Tipo = tcStr then
       result := ReverterFiltroTextoXML(ConteudoTag)
     else if Tipo = tcDat then
      begin
         if length(ConteudoTag)>0 then
            result := EncodeDate(StrToInt(copy(ConteudoTag, 01, 4)), StrToInt(copy(ConteudoTag, 06, 2)), StrToInt(copy(ConteudoTag, 09, 2)))
         else
            result:=0;
      end
     else if Tipo = tcDatHor then
      begin
         if length(ConteudoTag)>0 then
            result := EncodeDate(StrToInt(copy(ConteudoTag, 01, 4)), StrToInt(copy(ConteudoTag, 06, 2)), StrToInt(copy(ConteudoTag, 09, 2))) +
                     EncodeTime(StrToInt(copy(ConteudoTag, 12, 2)), StrToInt(copy(ConteudoTag, 15, 2)), StrToInt(copy(ConteudoTag, 18, 2)), 0)
         else
            result:=0;
      end
     else if (Tipo = tcDe2) or (Tipo = tcDe3) or (Tipo = tcDe4) or (tipo = tcDe6) then  // tcDe6, Incluido por Italo em 30/09/2010
       result := StrToFloat(StringReplace('0' + ConteudoTag, '.', DecimalSeparator, []))
     else if Tipo = tcEsp then
       result := ConteudoTag
     else if Tipo = tcInt then
       result := StrToInt('0' + Trim(SomenteNumeros(ConteudoTag)));
  except
     raise Exception.Create('Tag <' + Tag + '> com conteúdo inválido. '+ConteudoTag);
  end;

end;

function TLeitor.rAtributo(Atributo: string): variant;
var
  ConteudoTag: string;
  inicio, fim: integer;
begin
  Atributo := Trim(Atributo);
  inicio := pos(Atributo, FGrupo) + Length(Atributo);
  ConteudoTag := trim(copy(FGrupo, inicio, maxInt));
  inicio := pos('"', ConteudoTag) + 1;
  ConteudoTag := trim(copy(ConteudoTag, inicio, maxInt));
  fim := pos('"', ConteudoTag) - 1;
  ConteudoTag := copy(ConteudoTag, 1, fim);
  result := ReverterFiltroTextoXML(ConteudoTag)
end;

function TLeitor.PosLast(const SubStr, S: AnsiString ): Integer;
Var P : Integer ;
begin
  Result := 0 ;
  P := Pos( SubStr, S) ;
  while P <> 0 do
  begin
     Result := P ;
     P := RetornarPosEx( SubStr, S, P+1) ;
  end ;
end ;

end.

