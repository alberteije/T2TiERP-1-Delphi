{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2005 Anderson Rogerio Bejatto               }
{                                                                              }
{ Colaboradores nesse arquivo:          Daniel Simoes de Almeida               }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 19/09/2011: Régys Borges da Silveira
|*  - Primeira Versao ACBrCargaBal
******************************************************************************}

unit ACBrCargaBal;

{$I ACBr.inc}

interface

uses
  ACBrBase,
  SysUtils , Classes, Contnrs;

type
  EACBrCargaBal = class(Exception);
  TACBrCargaBalTipoVenda = (tpvPeso, tpvUnidade, tpvEAN13);
  TACBrCargaBalModelo = (modFilizola, modToledo, modUrano);
  TACBrCargaBalProgresso = procedure(Mensagem: String; ProgressoAtual, ProgressoTotal: Integer) of object;

  TACBrCargaBalSetor = class
  private
    FCodigo: Smallint;
    FDescricao: String;
  public
    constructor Create;
    property Codigo: Smallint read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
  end;

  TACBrCargaBalItem = class
  private
    FTecla: Integer;
    FReceita: String;
    FValorVenda: Currency;
    FModeloEtiqueta: Smallint;
    FDescricao: String;
    FCodigo: Smallint;
    FTipo: TACBrCargaBalTipoVenda;
    FValidade: Smallint;
    FSetor: TACBrCargaBalSetor;
  public
    constructor Create;
    destructor Destroy; override;
    property Setor: TACBrCargaBalSetor read FSetor write FSetor;
    property ModeloEtiqueta: Smallint read FModeloEtiqueta write FModeloEtiqueta;
    property Tipo: TACBrCargaBalTipoVenda read FTipo write FTipo;
    property Codigo: Smallint read FCodigo write FCodigo;
    property ValorVenda: Currency read FValorVenda write FValorVenda;
    property Validade: Smallint read FValidade write FValidade;
    property Descricao: String read FDescricao write FDescricao;
    property Receita: String read FReceita write FReceita;
    property Tecla: Integer read FTecla write FTecla;
  end;

  TACBrCargaBalItens = class(TObjectList)
  private
    function GetItem(Index: Integer): TACBrCargaBalItem;
    procedure SetItem(Index: Integer; const Value: TACBrCargaBalItem);
  public
    function New: TACBrCargaBalItem;
    property Items[Index: Integer]: TACBrCargaBalItem read GetItem write SetItem; Default;
  end;

  TACBrCargaBal = class( TACBrComponent )
  private
    FOnProgresso: TACBrCargaBalProgresso;
    FProdutos: TACBrCargaBalItens;
    FModelo: TACBrCargaBalModelo;
    procedure Progresso(const AMensagem: String; const AContAtual, AContTotal: Integer);
    function GetNomeArquivoNutricional: String;
    function GetNomeArquivoProduto: String;
    function GetNomeArquivoReceita: String;
    function GetNomeArquivoSetor: String;
    function RFill(Str: string; Tamanho: Integer = 0; Caracter: Char = ' '): string; overload;
    function LFIll(Str: string; Tamanho: Integer = 0; Caracter: Char = '0'): string; overload;
    function LFIll(Valor: Currency; Tamanho: Integer; Decimais: Integer = 2; Caracter: Char = '0'): string; overload;
    function LFIll(Valor: Integer; Tamanho: Integer; Caracter: Char = '0'): string; overload;
    procedure PreencherFilizola(Arquivo, Setor: TStringList);
    procedure PreencherToledo(Arquivo, Nutricional: TStringList);
    procedure PreencherUrano(Arquivo: TStringList);
    function GetTipoProdutoFilizola(Tipo: TACBrCargaBalTipoVenda): String;
    function GetTipoProdutoToledo(Tipo: TACBrCargaBalTipoVenda): String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GerarArquivo(const ADiretorio: String);
  published
    property Modelo: TACBrCargaBalModelo read FModelo write FModelo;
    property Produtos: TACBrCargaBalItens read FProdutos write FProdutos;
    property OnProgresso: TACBrCargaBalProgresso read FOnProgresso write FOnProgresso;
  end;

implementation

{ TACBrCargaBalSetor }

constructor TACBrCargaBalSetor.Create;
begin
  FCodigo    := 0;
  FDescricao := EmptyStr;
end;

{ TACBrCargaBalItem }

constructor TACBrCargaBalItem.Create;
begin
  // Criacao da propriedade Setor
  FSetor := TACBrCargaBalSetor.Create;

  // Iniciar os campos de valores
  FCodigo          := 0;
  FDescricao       := EmptyStr;
  FTipo            := tpvPeso;
  FValorVenda      := 0.00;
  FModeloEtiqueta  := 0;
  FReceita         := EmptyStr;
  FValidade        := 0;
end;

destructor TACBrCargaBalItem.Destroy;
begin
  FSetor.Free;
  inherited;
end;

{ TACBrCargaBalItens }

function TACBrCargaBalItens.GetItem(Index: Integer): TACBrCargaBalItem;
begin
  Result := TACBrCargaBalItem(inherited Items[Index]);
end;

function TACBrCargaBalItens.New: TACBrCargaBalItem;
begin
  Result := TACBrCargaBalItem.Create;
  Add(Result);
end;

procedure TACBrCargaBalItens.SetItem(Index: Integer;
  const Value: TACBrCargaBalItem);
begin
  Put(Index, Value);
end;

{ TACBrCargaBal }

constructor TACBrCargaBal.Create(AOwner: TComponent);
begin
  inherited;
  FProdutos := TACBrCargaBalItens.Create;
end;

destructor TACBrCargaBal.Destroy;
begin
  FProdutos.Free;
  inherited;
end;

function TACBrCargaBal.RFill(Str: string; Tamanho: Integer = 0;
  Caracter: Char = ' '): string;
begin
  if (Tamanho > 0) and (Length(Str) > Tamanho) then
    Result := Copy(Str, 1, Tamanho)
  else
    Result := Str + StringOfChar(Caracter, Tamanho - Length(Str));
end;

function TACBrCargaBal.LFill(Str: string; Tamanho: Integer = 0;
  Caracter: Char = '0'): string;
begin
  if (Tamanho > 0) and (Length(Str) > Tamanho) then
    Result := Copy(Str, 1, Tamanho)
  else
    Result := StringOfChar(Caracter, Tamanho - length(Str)) + Str;
end;

function TACBrCargaBal.LFill(Valor: Currency; Tamanho: Integer;
  Decimais: Integer = 2; Caracter: Char = '0'): string;
var
  i, p: Integer;
begin
  p := 1;

  for i := 1 to Decimais do
    p := p * 10;

  Result := LFill(Trunc(Valor * p), Tamanho, Caracter);
end;

function TACBrCargaBal.LFill(Valor: Integer; Tamanho: Integer;
  Caracter: Char = '0'): string;
begin
  Result := LFill(IntToStr(Valor), Tamanho, Caracter);
end;

function TACBrCargaBal.GetNomeArquivoProduto: String;
begin
  case FModelo of
    modFilizola : Result := 'CADTXT.TXT';
    modToledo   : Result := 'TXITENS.TXT';
    modUrano    : Result := 'NomeArquivoUrano.TXT';
  end;
end;

function TACBrCargaBal.GetTipoProdutoToledo(Tipo: TACBrCargaBalTipoVenda): String;
begin
  case Tipo of
    tpvPeso    : Result := '0';
    tpvUnidade : Result := '1';
    tpvEAN13   : Result := '2';
  end;
end;

function TACBrCargaBal.GetTipoProdutoFilizola(Tipo: TACBrCargaBalTipoVenda): String;
begin
  case Tipo of
    tpvPeso    : Result := 'P';
    tpvUnidade : Result := 'U';
  end;
end;

function TACBrCargaBal.GetNomeArquivoSetor: String;
begin
  // Toledo nao possui arquivo de setor a parte
  case FModelo of
    modFilizola : Result := 'SETORTXT.TXT';
    modUrano    : Result := 'NomeArquivoUrano.TXT';
  end;
end;

function TACBrCargaBal.GetNomeArquivoReceita: String;
begin
  // Toledo nao possui arquivo de Receita a parte
  case FModelo of
    modFilizola : Result := 'REC_ASS.TXT';
    modUrano    : Result := 'NomeArquivoUrano.TXT';
  end;
end;

function TACBrCargaBal.GetNomeArquivoNutricional: String;
begin
  // A filizola nao possui arquivo nutricional a parte das informações
  // são incluídas no mesmo arquivo de itens.
  case FModelo of
    modToledo   : Result := 'INFNUTRI.TXT';
    modUrano    : Result := 'NomeArquivoUrano.TXT';
  end;
end;

procedure TACBrCargaBal.PreencherFilizola(Arquivo, Setor: TStringList);
var
  i, Total: Integer;
begin
  Total := Produtos.Count;

  for i := 0 to Total - 1 do
  begin
    Arquivo.Add(
      LFIll(Produtos[i].Codigo, 6) +
      GetTipoProdutoFilizola(Produtos[i].Tipo) +
      RFIll(Produtos[i].Descricao, 22) +
      LFIll(Produtos[i].ValorVenda, 7, 2) +
      LFIll(Produtos[i].Validade, 3)
    );

    Setor.Add(
      RFill(Produtos[i].Setor.Descricao, 12) +
      LFIll(Produtos[i].Codigo, 6) +
      LFIll(i + 1, 4) +
      LFill(Produtos[i].Tecla, 3)
    );

    Progresso(Format('Gerando produto %6.6d %s', [Produtos[i].Codigo, Produtos[i].Descricao]), i, Total);
  end;
end;

procedure TACBrCargaBal.PreencherToledo(Arquivo, Nutricional: TStringList);
var
  i, Total: Integer;
begin
  Total := Produtos.Count;

  for i := 0 to Total - 1 do
  begin
    Arquivo.Add(
      LFIll(Produtos[i].Setor.Codigo, 2) +
      LFIll(Produtos[i].ModeloEtiqueta, 2) +
      GetTipoProdutoToledo(Produtos[i].Tipo) +
      LFIll(Produtos[i].Codigo, 6) +
      LFIll(Produtos[i].ValorVenda, 6, 2) +
      LFIll(Produtos[i].Validade, 3) +
      RFIll(Produtos[i].Descricao, 50) +
      RFIll(Produtos[i].Receita, 250)
    );

    Progresso(Format('Gerando produto %6.6d %s', [Produtos[i].Codigo, Produtos[i].Descricao]), i, Total);
  end;
end;

procedure TACBrCargaBal.PreencherUrano(Arquivo: TStringList);
begin
  raise EACBrCargaBal.Create('Geração de arquivo do Modelo Urano não implementado!');
end;

procedure TACBrCargaBal.Progresso(const AMensagem: String; const AContAtual,
  AContTotal: Integer);
begin
  if Assigned(FOnProgresso) then
    FOnProgresso(AMensagem, AContAtual, AContTotal);
end;

procedure TACBrCargaBal.GerarArquivo(const ADiretorio: String);
var
  Produto, Setor, Receita, Nutricional: TStringList;
  NomeArquivo: TFileName;
  Total: integer;
begin
  if Trim(ADiretorio) = EmptyStr then
    raise EACBrCargaBal.Create('Informe o diretório onde serão gerados os arquivos de carga!');

  if not DirectoryExists(ADiretorio) then
    raise EACBrCargaBal.Create('Diretorio informado não existe!');

  if Self.Produtos.Count = 0 then
    raise EACBrCargaBal.Create('Não foram informados os produtos para a geração!');

  Produto := TStringList.Create;
  Produto.Clear;

  Setor := TStringList.Create;
  Setor.Clear;

  Receita := TStringList.Create;
  Receita.Clear;

  Nutricional := TStringList.Create;
  Nutricional.Clear;

  try
    Total := Self.Produtos.Count;
    Progresso('Iniciando a geração dos arquivos', 0, Total);

    // Varre os registros gerando o arquivo em lista
    case FModelo of
      modFilizola: PreencherFilizola(Produto, Setor);
      modToledo  : PreencherToledo(Produto, Nutricional);
      modUrano   : PreencherUrano(Produto);
    end;

    // Monta o nome do arquivo de produtos seguindo o padrao da balanca
    if Produto.Count > 0 then
    begin
      NomeArquivo := IncludeTrailingPathDelimiter(ADiretorio) + GetNomeArquivoProduto;
      Produto.SaveToFile(NomeArquivo);
    end;

    // Gerar arquivo de setores se houverem dados e o arquivo for separado
    if Setor.Count > 0 then
    begin
      NomeArquivo := IncludeTrailingPathDelimiter(ADiretorio) + GetNomeArquivoSetor;
      Setor.SaveToFile(NomeArquivo);
    end;

    // Gerar arquivo de receitas se houverem dados e o arquivo for separado
    if Receita.Count > 0 then
    begin
      NomeArquivo := IncludeTrailingPathDelimiter(ADiretorio) + GetNomeArquivoReceita;
      Receita.SaveToFile(NomeArquivo);
    end;

    // Gerar arquivo de Nutricionais se houverem dados e o arquivo for separado
    if Nutricional.Count > 0 then
    begin
      NomeArquivo := IncludeTrailingPathDelimiter(ADiretorio) + GetNomeArquivoNutricional;
      Nutricional.SaveToFile(NomeArquivo);
    end;

    Progresso('Terminado', Total, Total);
  finally
    FreeAndNil(Produto);
    FreeAndNil(Setor);
    FreeAndNil(Receita);
    FreeAndNil(Nutricional);
  end;
end;

end.
