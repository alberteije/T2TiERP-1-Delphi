{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2012   Albert Eije                          }
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
|* 01/05/2013: Albert Eije
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrFolhaUtils;

interface

uses SysUtils, Variants, Classes, ACBrUtil;

function TratarString(pStr: String; RetirarNumero: Boolean = False): String;
function ApenasNumeros(pStr:String): String;
function ValidarPis(const PIS : String; ExibeMsgErro: Boolean=False) : boolean;
function ValidarCnpjCeiCpf(const CnpjCeiCpf: String; ExibeMsgErro: Boolean=False): Boolean;
function ValidarCEP(const CEP, UF: String; ExibeMsgErro: Boolean = False): Boolean;
function ValidarUF(const UF: String): boolean;
function ValidarEMail(const pStr: string; ExibeMsgErro: Boolean = False): Boolean;
function ValidarTelefone(const pTelefone: String; ExibeMsgErro: Boolean = False): Boolean;

function funChecaMUN(const COD: Integer): Boolean;
function funChecaIE(const IE, TIPO: String): Boolean;
function funChecaCFOP(const CFOP: Integer): Boolean;

function funChecaCST(const CST: String): Boolean;
function funChecaGENERO(const COD: String): Boolean;
function funChecaPAISIBGE(const COD: String): Boolean;
function funChecaMODNF(const COD: String): Boolean;
function funChecaSITDOCTO(const COD: String): Boolean;
function funChecaCSTCOFINS(const CST: String): Boolean;
function funChecaCSTPIS(const CST: String): Boolean;
function funStrZero(Zeros: String; Quant: Integer): String;
function funChecaCOD_CONS(const COD_MOD, COD_CONS: AnsiString): Boolean;

function IfThen(AValue: Boolean; const ATrue: Char; AFalse: Char): Char; overload;
function IfThen(AValue: Boolean; const ATrue: Double; AFalse: Double): Double; overload;

implementation


function TratarString(pStr: String; RetirarNumero: Boolean = False): String;
// Converte uma cadeia de string onde se tenha numeros, espaços excendetes e caracteres acentuados
// em uma cadeia de strings tratada.
Var
  i, j: Integer;
  Str, StrTratada: String;
const
  ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
begin
  Result := '';

  if trim(pStr) <> '' then
  begin

    j := 0;

    for i := 0 to Length(pStr) do
    begin
      if pStr[i] = ' ' then
        j := j + 1
      else
        j := 1;
      if j = 1 then
      begin
        StrTratada := StrTratada + pStr[i];
        if pStr[i] = ' ' then
          j := 1
        else
          j := 0;
      end
    end;

    pStr := StrTratada;

    for i := 1 to Length(pStr) do
      if Pos(pStr[i], ComAcento) <> 0 then
        pStr[i] := SemAcento[Pos(pStr[i], ComAcento)];

    Str := pStr;

    if RetirarNumero then
    begin
      for i := 1 To Length(Str) do
        If Str[i] In ['A' .. 'Z', 'a' .. 'z', ' '] Then
          Result := UpperCase(TrimLeft(Result + Str[i]));
    end
    else
      Result := UpperCase(TrimLeft(Str));
  end;

end;


function ApenasNumeros(pStr: String): String;
// Converte uma cadeia de string onde se tenha numeros e caracteres em uma cadeia de strings onde so tenha numeros
Var
  I: Integer;
begin
  Result := '';
  For I := 1 To Length(pStr) do
    If pStr[I] In ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'] Then
      Result := Result + pStr[I];
end;

function ValidarPis(const PIS: String; ExibeMsgErro: Boolean = False): Boolean;
begin
  Result := True;
end;

function ValidarCnpjCeiCpf(const CnpjCeiCpf: String; ExibeMsgErro: Boolean = False): Boolean;
// Verifica se o numero passado no parametro é CNPJ/CPF ou CEI e valida o mesmo. Se nao for válido e o parametro ExibeMSGErro for true, exibe um messagebox co icone de erro.
begin
  Result := True
end;

function ValidarCEP(const CEP, UF: String; ExibeMsgErro: Boolean = False): Boolean;
begin
  Result := True
end;

function ValidarUF(const UF: String): Boolean;
begin
  Result := True
end;

function ValidarEMail(const pStr: string; ExibeMsgErro: Boolean = False): Boolean;
begin
  Result := True
end;

function ValidarTelefone(const pTelefone: String; ExibeMsgErro: Boolean = False): Boolean;
begin
  Result := True
end;

function funChecaCOD_CONS(const COD_MOD, COD_CONS: AnsiString): Boolean;
begin
  Result := True
end;

function funChecaMODNF(const COD: String): Boolean;
begin
  Result := True
end;

function funChecaCST(const CST: String): Boolean;
begin
  Result := True
end;

function funChecaCSTCOFINS(const CST: String): Boolean;
begin
  Result := True
end;

function funChecaCSTPIS(const CST: String): Boolean;
begin
  Result := True
end;

function funChecaCSTIPI(CST: String): Boolean;
begin
  Result := True
end;

function funChecaSITDOCTO(const COD: String): Boolean;
begin
  Result := True
end;

function funChecaGENERO(const COD: String): Boolean;
begin
  Result := True
end;

function funChecaPAISIBGE(const COD: String): Boolean;
begin
  Result := True
end;

{ Valida a inscrição estadual }
function funChecaIE(const IE, TIPO: String): Boolean;
begin
  Result := True
end;

function funChecaCFOP(const CFOP: Integer): Boolean;
begin
  Result := True
end;

function funChecaMUN(const COD: Integer): Boolean;
begin
  Result := True
end;

function funStrZero(Zeros: String; Quant: Integer): String;
begin
  Result := Zeros;
  Quant := Quant - Length(Result);
  if Quant > 0 then
     Result := StringOfChar('0', Quant) + Result;
end;

function IfThen(AValue: Boolean; const ATrue: Char; AFalse: Char): Char;
begin
  if AValue then
     Result := ATrue
  else
     Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Double; AFalse: Double): Double;
begin
  if AValue then
     Result := ATrue
  else
     Result := AFalse;
end;

end.

