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
///
unit pcnRetCCeNFe;

interface uses

  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnLeitor;

type
  TRetDetEvento = class ;
  TRetInfEvento = class ;
  TRetInfEventoCollection  = class ;
  TRetInfEventoCollectionItem = class ;
  TRetCCeNFe = class ;

  TRetDetEvento = class
  private
    FVersao: String;
    FDescEvento: String;
    FCorrecao: String;
    FCondUso: String;
    procedure setCondUso(const Value: String);
  public
    property versao: string           read FVersao      write FVersao;
    property descEvento: string       read FDescEvento  write FDescEvento;
    property xCorrecao: String        read FCorrecao    write FCorrecao;
    property xCondUso: String         read FCondUso     write setCondUso;
  end;

  TRetInfEvento = class
  private
    FId: String;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcOrgao: Integer;
    FcStat: Integer;
    FxMotivo: String;
    FchNFe: String;
    FtpEvento: Integer;
    FxEvento: String;
    FnSeqEvento: Integer;
    FCNPJDest: String;
    FemailDest: String;
    FdhRegEvento: TDateTime;
    FnProt: String;
  public
  published
    property Id: string  read FId write FId;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb;
    property verAplic: string  read FverAplic write FverAplic;
    property cOrgao: Integer read FcOrgao write FcOrgao;
    property cStat: integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;
    property chNFe: String read FchNFe write FchNFe;
    property tpEvento: Integer read FtpEvento write FtpEvento;
    property xEvento: String read FxEvento write FxEvento;
    property nSeqEvento: Integer read FnSeqEvento write FnSeqEvento;
    property CNPJDest: string read FCNPJDest write FCNPJDest;
    property emailDest: String read FemailDest write FemailDest;
    property dhRegEvento: TDateTime read FdhRegEvento write FdhRegEvento;
    property nProt: String read FnProt write FnProt;
  end;

  TRetInfEventoCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TRetInfEventoCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetInfEventoCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TRetInfEventoCollectionItem;
    property Items[Index: Integer]: TRetInfEventoCollectionItem read GetItem write SetItem; default;
  end;

  TRetInfEventoCollectionItem = class(TCollectionItem)
  private
    FRetInfEvento: TRetInfEvento;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property RetInfEvento: TRetInfEvento read FRetInfEvento write FRetInfEvento;
  end;

  TRetCCeNFe = class(TPersistent)
  private
    FidLote : integer;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: string;
    FLeitor: TLeitor;
    FcStat: integer;
    FcOrgao: Integer;
    FxMotivo: string;
    FretEvento: TRetInfEventoCollection;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property idLote: integer read FidLote write FidLote;
    property Leitor: TLeitor read FLeitor write FLeitor;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb;
    property verAplic: string read FverAplic write FverAplic;
    property cOrgao: integer read FcOrgao write FcOrgao;
    property cStat: integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;
    property retEvento: TRetInfEventoCollection read FretEvento write FretEvento;
  end;


implementation

{ TRetDetEvento }

procedure TRetDetEvento.setCondUso(const Value: String);
begin
  FCondUso := Value;

  if FCondUso = '' then
    FCondUso := 'A Carta de Correcao e disciplinada pelo paragrafo 1o-A do' +
                ' art. 7o do Convenio S/N, de 15 de dezembro de 1970 e' +
                ' pode ser utilizada para regularizacao de erro ocorrido na' +
                ' emissao de documento fiscal, desde que o erro nao esteja' +
                ' relacionado com: I - as variaveis que determinam o valor' +
                ' do imposto tais como: base de calculo, aliquota, diferenca' +
                ' de preco, quantidade, valor da operacao ou da prestacao;' +
                ' II - a correcao de dados cadastrais que implique mudanca' +
                ' do remetente ou do destinatario; III - a data de emissao ou' +
                ' de saida.'
{    FCondUso := 'A Carta de Correção é disciplinada pelo § 1º-A do art. 7º' +
                ' do Convênio S/N, de 15 de dezembro de 1970 e pode ser' +
                ' utilizada para regularização de erro ocorrido na emissão de' +
                ' documento fiscal, desde que o erro não esteja relacionado' +
                ' com: I - as variáveis que determinam o valor do imposto' +
                ' tais como: base de cálculo, alíquota, diferença de preço,' +
                ' quantidade, valor da operação ou da prestação; II - a' +
                ' correção de dados cadastrais que implique mudança do' +
                ' remetente ou do destinatário; III - a data de emissão ou de' +
                ' saída.';    }
end;

{ TRetInfEventoCollection }

function TRetInfEventoCollection. Add: TRetInfEventoCollectionItem;
begin
  Result := TRetInfEventoCollectionItem(inherited Add);
  Result.create;
end;

constructor TRetInfEventoCollection.Create(AOwner: TPersistent);
begin
  inherited Create(TRetInfEventoCollectionItem);
end;

function TRetInfEventoCollection.GetItem(
  Index: Integer): TRetInfEventoCollectionItem;
begin
  Result := TRetInfEventoCollectionItem(inherited GetItem(Index));
end;

procedure TRetInfEventoCollection.SetItem(Index: Integer;
  Value: TRetInfEventoCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRetInfEventoCollectionItem }

constructor TRetInfEventoCollectionItem.Create;
begin
  FRetInfEvento := TRetInfEvento.Create;
end;

destructor TRetInfEventoCollectionItem.Destroy;
begin
  FRetInfEvento.Free;
  inherited;
end;

{ TRetCCeNFe }
constructor TRetCCeNFe.Create;
begin
  FLeitor := TLeitor.Create;
  FretEvento := TRetInfEventoCollection.Create(Self);
end;

destructor TRetCCeNFe.Destroy;
begin
  FLeitor.Free;
  FretEvento.Free;
  inherited;
end;

function TRetCCeNFe.LerXml: boolean;
var
  ok: boolean;
  i : integer;
begin
  Result := False;
  try
    if Leitor.rExtrai(1, 'retEnvEvento') <> '' then
    begin
      (*HR03 *)FidLote   := Leitor.rCampo(tcInt, 'idLote');
      (*HR04 *)FtpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
      (*HR05 *)FverAplic := Leitor.rCampo(tcStr, 'verAplic');
      (*HR06 *)FcOrgao   := Leitor.rCampo(tcInt, 'cOrgao');
      (*HR07 *)FcStat    := Leitor.rCampo(tcInt, 'cStat');
      (*HR08 *)FxMotivo  := Leitor.rCampo(tcStr, 'xMotivo');
      i := 0;
      while Leitor.rExtrai(2, 'infEvento', '', i + 1) <> '' do
       begin
         FretEvento.Add;
//         (*HR10 *)FretEvento.versao               := Leitor.rCampo(tcStr, 'versao');
         (*HR12 *)FretEvento.Items[i].FRetInfEvento.FId       := Leitor.rCampo(tcStr, 'Id');
         (*HR13 *)FretEvento.Items[i].FRetInfEvento.FtpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
         (*HR14 *)FretEvento.Items[i].FRetInfEvento.FverAplic := Leitor.rCampo(tcStr, 'verAplic');
         (*HR15 *)FretEvento.Items[i].FRetInfEvento.FcOrgao   := Leitor.rCampo(tcInt, 'cOrgao');
         (*HR16 *)FretEvento.Items[i].FRetInfEvento.FcStat    := Leitor.rCampo(tcInt, 'cStat');
         (*HR17 *)FretEvento.Items[i].FRetInfEvento.FxMotivo  := Leitor.rCampo(tcStr, 'xMotivo');
         (*HR18 *)FretEvento.Items[i].FRetInfEvento.FchNFe    := Leitor.rCampo(tcStr, 'chNFe');
         (*HR19 *)FretEvento.Items[i].FRetInfEvento.FtpEvento := Leitor.rCampo(tcInt, 'tpEvento');
         (*HR20 *)FretEvento.Items[i].FRetInfEvento.FxEvento  := Leitor.rCampo(tcStr, 'xEvento');
         (*HR21 *)FretEvento.Items[i].FRetInfEvento.FnSeqEvento := Leitor.rCampo(tcInt, 'nSeqEvento');
         (*HR22 *)FretEvento.Items[i].FRetInfEvento.FCNPJDest   := Leitor.rCampo(tcStr, 'CNPJDest');
         if FretEvento.Items[i].FRetInfEvento.FCNPJDest = '' then
           (*HR23 *)FretEvento.Items[i].FRetInfEvento.FCNPJDest  := Leitor.rCampo(tcStr, 'CPFDest');
         (*HR24 *)FretEvento.Items[i].FRetInfEvento.FemailDest   := Leitor.rCampo(tcStr, 'emailDest');
         // Tipo alterado de tcStr para tcDatHor por Italo em 25/08/2011
         (*HR25 *)FretEvento.Items[i].FRetInfEvento.FdhRegEvento := Leitor.rCampo(tcDatHor, 'dhRegEvento');
         (*HR26 *)FretEvento.Items[i].FRetInfEvento.FnProt       := Leitor.rCampo(tcStr, 'nProt');
         inc(i);
       end;
      Result := True;
    end;
  except
    result := False;
  end;
end;

end.
