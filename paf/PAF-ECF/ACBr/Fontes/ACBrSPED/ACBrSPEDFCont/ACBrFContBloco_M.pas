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
*******************************************************************************}

unit ACBrFContBloco_M;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils, ACBrFContBlocos;

type
  /// Registro M001 - ABERTURA DO BLOCO M

  TRegistroM001 = class(TOpenBlocos)
  private
  public
  end;

  ///Registro M020 - QUALIFICAÇÃO DA PESSOA JURÍDICA E RETIFICAÇÃO

  TRegistroM020 = class
  private
    fQUALI_PJ        : String;    /// Qualificação da Pessoa Jurídica.
    fTIPO_ESCRIT     : String;    /// Tipo de Escrituração: 0-Original, 1-Retificadora
    fNRO_REC_ANTERIOR: String;    /// Número do recibo da escrituração anterior a ser retificada.
  public
    property QUALI_PJ: String read fQUALI_PJ write fQUALI_PJ;
    property TIPO_ESCRIT: String read fTIPO_ESCRIT write fTIPO_ESCRIT;
    property NRO_REC_ANTERIOR: String read fNRO_REC_ANTERIOR write fNRO_REC_ANTERIOR;
  end;

  /// Registro M030 – IDENTIFICAÇÃO DO PERÍODO DE APURAÇÃO

  TRegistroM030 = class
  private
    fIND_PER        : String;    /// Período Apuração
    fIND_CALC_ESTIM : String;    /// Não preencher
    fFORM_TRIB_TRI  : String;    /// Não preencher
    fVL_LUC_LIQ     : Currency;  /// Resultado do Período - Valor do lucro líquido (ou do prejuízo) contábil do período
    fIND_LUC_LIQ    : String;    /// Situação do Resultado do Período
  public
    property IND_PER        : String read fIND_PER        write fIND_PER;
    property IND_CALC_ESTIM : String read fIND_CALC_ESTIM write fIND_CALC_ESTIM;
    property FORM_TRIB_TRI  : String read fFORM_TRIB_TRI  write fFORM_TRIB_TRI;
    property VL_LUC_LIQ     : Currency read fVL_LUC_LIQ     write fVL_LUC_LIQ;
    property IND_LUC_LIQ    : String read fIND_LUC_LIQ    write fIND_LUC_LIQ;
  end;

  /// Registro M030 - Lista

  TRegistroM030List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroM030;
    procedure SetItem(Index: Integer; const Value: TRegistroM030);
  public
    function New: TRegistroM030;
    property Items[Index: Integer]: TRegistroM030 read GetItem write SetItem;
  end;

  /// Registro M990 - ENCERRAMENTO DO BLOCO M

  TRegistroM990 = class
  private
    fQTD_LIN_M: Integer;    /// Quantidade total de linhas do Bloco M
  public
    property QTD_LIN_M: Integer read FQTD_LIN_M write FQTD_LIN_M;
  end;

implementation

{ TRegistroM030List }

function TRegistroM030List.GetItem(Index: Integer): TRegistroM030;
begin
  Result := TRegistroM030(Inherited Items[Index]);
end;

function TRegistroM030List.New: TRegistroM030;
begin
  Result := TRegistroM030.Create;
  Add(Result);
end;

procedure TRegistroM030List.SetItem(Index: Integer; const Value: TRegistroM030);
begin
  Put(Index, Value);
end;

end.
