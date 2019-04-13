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

unit ACBrEFDBloco_H_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEFDBloco_H,
     ACBrEFDBloco_0_Class, ACBrEFDBlocos;

type
  /// TBLOCO_H -
  TBloco_H = class(TACBrSPED)
  private
    FBloco_0: TBloco_0;

    FRegistroH001: TRegistroH001;      /// BLOCO H - RegistroH001
    FRegistroH990: TRegistroH990;      /// BLOCO H - RegistroH990

    FRegistroH005Count: Integer;
    FRegistroH010Count: Integer;

    procedure WriteRegistroH005(RegH001: TRegistroH001);
    procedure WriteRegistroH010(RegH005: TRegistroH005);

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create;           /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function RegistroH001New: TRegistroH001;
    function RegistroH005New: TRegistroH005;
    function RegistroH010New: TRegistroH010;

    procedure WriteRegistroH001;
    procedure WriteRegistroH990;

    property Bloco_0: TBloco_0 read FBloco_0 write FBloco_0;
    property RegistroH001: TRegistroH001 read FRegistroH001 write FRegistroH001;
    property RegistroH990: TRegistroH990 read FRegistroH990 write FRegistroH990;

    property RegistroH005Count: Integer read FRegistroH005Count write FRegistroH005Count;
    property RegistroH010Count: Integer read FRegistroH010Count write FRegistroH010Count;
  end;

implementation

{ TBloco_H }

constructor TBloco_H.Create;
begin
  inherited ;
  CriaRegistros;
end;

destructor TBloco_H.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_H.CriaRegistros;
begin
  FRegistroH001 := TRegistroH001.Create;
  FRegistroH990 := TRegistroH990.Create;

  FRegistroH005Count := 0;
  FRegistroH010Count := 0;

  FRegistroH990.QTD_LIN_H := 0;
end;

procedure TBloco_H.LiberaRegistros;
begin
  FRegistroH001.Free;
  FRegistroH990.Free;
end;

procedure TBloco_H.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  Conteudo.Clear;

  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_H.RegistroH001New: TRegistroH001;
begin
   Result := FRegistroH001;
end;

function TBloco_H.RegistroH005New: TRegistroH005;
begin
   Result := FRegistroH001.RegistroH005.New;
end;

function TBloco_H.RegistroH010New: TRegistroH010;
begin
   Result := FRegistroH001.RegistroH005.Items[FRegistroH001.RegistroH005.Count -1].RegistroH010.New;
end;

procedure TBloco_H.WriteRegistroH001;
begin
  if Assigned(RegistroH001) then
  begin
     with RegistroH001 do
     begin
       Add( LFill( 'H001' ) +
            LFill( Integer(IND_MOV), 0 ) ) ;

       if IND_MOV = imComDados then
       begin
          WriteRegistroH005(FRegistroH001);
       end;
     end;

     RegistroH990.QTD_LIN_H := RegistroH990.QTD_LIN_H + 1;
  end;
end;

procedure TBloco_H.WriteRegistroH005(RegH001: TRegistroH001);
var
  intFor: integer;
begin
  if Assigned( RegH001.RegistroH005 ) then
  begin
     for intFor := 0 to RegH001.RegistroH005.Count - 1 do
     begin
        with RegH001.RegistroH005.Items[intFor] do
        begin
          Add( LFill('H005') +
               LFill( DT_INV ) +
               LFill( VL_INV, 0) ) ;
        end;
        /// Registros FILHOS
        WriteRegistroH010( RegH001.RegistroH005.Items[intFor] );

        RegistroH990.QTD_LIN_H := RegistroH990.QTD_LIN_H + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroH005Count := FRegistroH005Count + RegH001.RegistroH005.Count;
  end;
end;

procedure TBloco_H.WriteRegistroH010(RegH005: TRegistroH005);
var
  intFor: integer;
begin
  if Assigned( RegH005.RegistroH010 ) then
  begin
     for intFor := 0 to RegH005.RegistroH010.Count - 1 do
     begin
        with RegH005.RegistroH010.Items[intFor] do
        begin
          Add( LFill('H010') +
               LFill( COD_ITEM ) +
               LFill( UNID ) +
               LFill( QTD, 0, 3 ) +
               LFill( VL_UNIT, 0, 6 ) +
               LFill( VL_ITEM, 0, 2 ) +
               LFill( Integer(IND_PROP), 0 ) +
               LFill( COD_PART ) +
               LFill( TXT_COMPL ) +
               LFill( COD_CTA ) ) ;
        end;
        RegistroH990.QTD_LIN_H := RegistroH990.QTD_LIN_H + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroH010Count := FRegistroH010Count + RegH005.RegistroH010.Count;
  end;
end;

procedure TBloco_H.WriteRegistroH990;
begin
  if Assigned(RegistroH990) then
  begin
     with RegistroH990 do
     begin
       QTD_LIN_H := QTD_LIN_H + 1;
       ///
       Add( LFill('H990') +
            LFill(QTD_LIN_H,0) ) ;
     end;
  end;
end;

end.
