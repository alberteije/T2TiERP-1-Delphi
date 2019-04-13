{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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
|* 10/04/2009: Isaque Pinheiro
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrEFDBloco_H;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils, ACBrEFDBlocos;

type
  TRegistroH005List = class;
  TRegistroH010List = class;

  /// Registro H001 - ABERTURA DO BLOCO H

  TRegistroH001 = class(TOpenBlocos)
  private
    FRegistroH005: TRegistroH005List;
    FRegistroH010: TRegistroH010List;
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property RegistroH005: TRegistroH005List read FRegistroH005 write FRegistroH005;
    property RegistroH010: TRegistroH010List read FRegistroH010 write FRegistroH010;
  end;

  /// Registro H005 - TOTAIS DO INVENTÁRIO

  TRegistroH005 = class
  private
    fDT_INV: TDateTime;    /// Data do inventário:
    fVL_INV: currency;     /// Valor total do estoque:

    FRegistroH010: TRegistroH010List;  /// BLOCO C - Lista de RegistroH010 (FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property DT_INV: TDateTime read FDT_INV write FDT_INV;
    property VL_INV: currency read FVL_INV write FVL_INV;
    /// Registros FILHOS
    property RegistroH010: TRegistroH010List read FRegistroH010 write FRegistroH010;
  end;

  /// Registro H005 - Lista

  TRegistroH005List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroH005; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroH005); /// SetItem
  public
    function New: TRegistroH005;
    property Items[Index: Integer]: TRegistroH005 read GetItem write SetItem;
  end;

  /// Registro H010 - INVENTÁRIO

  TRegistroH010 = class
  private
    fCOD_ITEM: String;         /// Código do item (campo 02 do Registro 0200)
    fUNID: String;             /// Unidade do item
    fQTD: Double;              /// Quantidade do item
    fVL_UNIT: Double;          /// Valor unitário do item
    fVL_ITEM: currency;        /// Valor do item
    fIND_PROP: TACBrPosseItem; /// Indicador de propriedade/posse do item: 0- Item de propriedade do informante e em seu poder, 1- Item de propriedade do informante em posse de terceiros, 2- Item de propriedade de terceiros em posse do informante
    fCOD_PART: String;         /// Código do participante (campo 02 do Registro 0150): proprietário/possuidor que não seja o informante do arquivo
    fTXT_COMPL: String;        /// Descrição complementar
    fCOD_CTA: String;          /// Código da conta analítica contábil debitada/creditada
  public
    property COD_ITEM: String read FCOD_ITEM write FCOD_ITEM;
    property UNID: String read FUNID write FUNID;
    property QTD: Double read FQTD write FQTD;
    property VL_UNIT: Double read FVL_UNIT write FVL_UNIT;
    property VL_ITEM: currency read FVL_ITEM write FVL_ITEM;
    property IND_PROP: TACBrPosseItem read FIND_PROP write FIND_PROP;
    property COD_PART: String read FCOD_PART write FCOD_PART;
    property TXT_COMPL: String read FTXT_COMPL write FTXT_COMPL;
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro H010 - Lista

  TRegistroH010List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroH010; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroH010); /// SetItem
  public
    function New: TRegistroH010;
    property Items[Index: Integer]: TRegistroH010 read GetItem write SetItem;
  end;

  /// Registro H990 - ENCERRAMENTO DO BLOCO H

  TRegistroH990 = class
  private
    fQTD_LIN_H: Integer;    /// Quantidade total de linhas do Bloco H
  public
    property QTD_LIN_H: Integer read FQTD_LIN_H write FQTD_LIN_H;
  end;

implementation

{ TRegistroH010List }

function TRegistroH010List.GetItem(Index: Integer): TRegistroH010;
begin
  Result := TRegistroH010(Inherited Items[Index]);
end;

function TRegistroH010List.New: TRegistroH010;
begin
  Result := TRegistroH010.Create;
  Add(Result);
end;

procedure TRegistroH010List.SetItem(Index: Integer; const Value: TRegistroH010);
begin
  Put(Index, Value);
end;

{ TRegistroH005List }

function TRegistroH005List.GetItem(Index: Integer): TRegistroH005;
begin
  Result := TRegistroH005(Inherited Items[Index]);
end;

function TRegistroH005List.New: TRegistroH005;
begin
  Result := TRegistroH005.Create;
  Add(Result);
end;

procedure TRegistroH005List.SetItem(Index: Integer; const Value: TRegistroH005);
begin
  Put(Index, Value);
end;

{ TRegistroH005 }

constructor TRegistroH005.Create;
begin
  FRegistroH010 := TRegistroH010List.Create;
end;

destructor TRegistroH005.Destroy;
begin
  FRegistroH010.Free;
  inherited;
end;

{ TRegistroH001 }

constructor TRegistroH001.Create;
begin
   FRegistroH005 := TRegistroH005List.Create;
   FRegistroH010 := TRegistroH010List.Create;
   //
   IND_MOV := imSemDados;
end;

destructor TRegistroH001.Destroy;
begin
  FRegistroH005.Free;
  FRegistroH010.Free;
  inherited;
end;

end.
