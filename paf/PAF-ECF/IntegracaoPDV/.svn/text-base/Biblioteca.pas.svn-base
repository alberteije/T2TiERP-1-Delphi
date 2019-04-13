{*******************************************************************************
Title: T2Ti ERP
Description: Biblioteca de funções.

The MIT License

Copyright: Copyright (C) 2010 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           t2ti.com@gmail.com</p>

@author Albert Eije (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit Biblioteca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Dbtables, Inifiles, DBClient, DB, SqlExpr, DBXMySql, Grids, DBGrids,
  IdHashMessageDigest, Constantes, Math,
  {Clausqueller 12.07.2011} Rtti, TypInfo,
  {Daniel 24.08.2011} StdCtrls;

Function ValidaCNPJ(xCNPJ: String):Boolean;
Function ValidaCPF( xCPF:String ):Boolean;
Function ValidaEstado(Dado : string) : boolean;
Function MixCase(InString: String): String;
Function Hora_Seg( Horas:string ):LongInt;
Function Seg_Hora( Seg:LongInt ):string;
Function Minuscula(InString: String): String;
Function StrZero(Num:Real ; Zeros,Deci:integer): string;
Function OrdenaPinta(xGrid: DBGrids.TDBGrid; Column: DBGrids.TColumn; cds: TClientDataSet): boolean;
Procedure ZapFiles(vMasc:String);
Procedure SetTaskBar(Visible: Boolean);
function MD5File(const fileName: string): string;
function MD5String(const texto: string): string;
Function TruncaValor(Value:Extended;Casas:Integer):Extended;
Function ArredondaTruncaValor(Operacao:String;Value:Extended;Casas:Integer):Extended;
function UltimoDiaMes(Mdt: TDateTime) : String;
function FormataFloat(Tipo:String; Valor: Extended): string; //Tipo => 'Q'=Quantidade | 'V'=Valor
procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
function VersaoExe(exe, param : string): String;  // acrescentar
function DevolveConteudoDelimitado(Delimidador:string;var Linha:string):string;   // acrescentar
Function ColocaZerosEsquerda(S:String;vT:Integer):String;

//Clausqueller 12.07.2011
procedure ConfiguraCDSFromVO(CDS: TClientDataSet; pObj : TClass);
function TextoParaData(pData: string): TDate;
function DataParaTexto(pData: TDate): string;
function CriaGuidStr: string;
      function MessageYes(Msg: string): Boolean;
      procedure MessageInfo(Msg: string);
      procedure MessageErro(Msg: string);
      procedure MessageWarn(Msg: string);

//Daniel Wanderley 24.08.2011
procedure LimpaEdits(Form: TForm);

var
   InString : String;

implementation
   //Clausqueller 12.07.2011
   uses Atributos;

{ Valida o CNPJ digitado }
function ValidaCNPJ(xCNPJ: String):Boolean;
Var
d1,d4,xx,nCount,fator,resto,digito1,digito2 : Integer;
Check : String;
begin
d1 := 0;
d4 := 0;
xx := 1;
for nCount := 1 to Length( xCNPJ )-2 do
    begin
    if Pos( Copy( xCNPJ, nCount, 1 ), '/-.' ) = 0 then
       begin
       if xx < 5 then
          begin
          fator := 6 - xx;
          end
       else
          begin
          fator := 14 - xx;
          end;
       d1 := d1 + StrToInt( Copy( xCNPJ, nCount, 1 ) ) * fator;
       if xx < 6 then
          begin
          fator := 7 - xx;
          end
       else
          begin
          fator := 15 - xx;
          end;
       d4 := d4 + StrToInt( Copy( xCNPJ, nCount, 1 ) ) * fator;
       xx := xx+1;
       end;
    end;
    resto := (d1 mod 11);
    if resto < 2 then
       begin
       digito1 := 0;
       end
   else
       begin
       digito1 := 11 - resto;
       end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
      begin
      digito2 := 0;
      end
   else
      begin
      digito2 := 11 - resto;
      end;
   Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(xCNPJ,succ(length(xCNPJ)-2),2) then
      begin
      Result := False;
      end
   else
      begin
      Result := True;
      end;
end;

{ Valida o CPF digitado }
function ValidaCPF( xCPF:String ):Boolean;
Var
d1,d4,xx,nCount,resto,digito1,digito2 : Integer;
Check : String;
Begin
d1 := 0; d4 := 0; xx := 1;
for nCount := 1 to Length( xCPF )-2 do
    begin
    if Pos( Copy( xCPF, nCount, 1 ), '/-.' ) = 0 then
       begin
       d1 := d1 + ( 11 - xx ) * StrToInt( Copy( xCPF, nCount, 1 ) );
       d4 := d4 + ( 12 - xx ) * StrToInt( Copy( xCPF, nCount, 1 ) );
       xx := xx+1;
       end;
    end;
resto := (d1 mod 11);
if resto < 2 then
   begin
   digito1 := 0;
   end
else
   begin
   digito1 := 11 - resto;
   end;
d4 := d4 + 2 * digito1;
resto := (d4 mod 11);
if resto < 2 then
   begin
   digito2 := 0;
   end
else
   begin
   digito2 := 11 - resto;
   end;
Check := IntToStr(Digito1) + IntToStr(Digito2);
if Check <> copy(xCPF,succ(length(xCPF)-2),2) then
   begin
   Result := False;
   end
else
   begin
   Result := True;
   end;
end;

{ Valida a UF digitada }
function ValidaEstado(Dado : string) : boolean;
const
  Estados = 'SPMGRJRSSCPRESDFMTMSGOTOBASEALPBPEMARNCEPIPAAMAPFNACRRRO';
var
  Posicao : integer;
begin
Result := true;
if Dado <> '' then
   begin
   Posicao := Pos(UpperCase(Dado),Estados);
   if (Posicao = 0) or ((Posicao mod 2) = 0) then
      begin
      Result := false;
      end;
    end;
end;

{ Corrige a string que contenha caracteres maiusculos
  inseridos no meio dela para tudo minusculo e com a
  primeira letra maiuscula}
Function  MixCase(InString: String): String;
Var I: Integer;
Begin
  Result := LowerCase(InString);
  Result[1] := UpCase(Result[1]);
  For I := 1 To Length(InString) - 1 Do Begin
    If (Result[I] = ' ') Or (Result[I] = '''') Or (Result[I] = '"')
    Or (Result[I] = '-') Or (Result[I] = '.')  Or (Result[I] = '(') Then
      Result[I + 1] := UpCase(Result[I + 1]);
    if Result[I] = 'Ç' then
      Result[I] := 'ç';
    if Result[I] = 'Ã' then
      Result[I] := 'ã';
    if Result[I] = 'Á' then
      Result[I] := 'á';
    if Result[I] = 'É' then
      Result[I] := 'é';
    if Result[I] = 'Í' then
      Result[I] := 'í';
    if Result[I] = 'Õ' then
      Result[I] := 'õ';
    if Result[I] = 'Ó' then
      Result[I] := 'ó';
    if Result[I] = 'Ú' then
      Result[I] := 'ú';
    if Result[I] = 'Â' then
      Result[I] := 'â';
    if Result[I] = 'Ê' then
      Result[I] := 'ê';
    if Result[I] = 'Ô' then
      Result[I] := 'ô';
  End;
End;

{Apaga arquivos usando mascaras tipo: c:\Temp\*.zip, c:\Temp\*.*
 Obs: Requer o Path dos arquivos a serem deletados}
Procedure ZapFiles(vMasc:String);
Var Dir : TsearchRec;
    Erro: Integer;
Begin
   Erro := FindFirst(vMasc,faArchive,Dir);
   While Erro = 0 do Begin
      DeleteFile( ExtractFilePAth(vMasc)+Dir.Name );
      Erro := FindNext(Dir);
   End;
   FindClose(Dir);
End;

{Converte de hora para segundos}
function Hora_Seg( Horas:string ):LongInt;
Var Hor,Min,Seg:LongInt;
begin
   Horas[Pos(':',Horas)]:= '[';
   Horas[Pos(':',Horas)]:= ']';
   Hor := StrToInt(Copy(Horas,1,Pos('[',Horas)-1));
   Min := StrToInt(Copy(Horas,Pos('[',Horas)+1,(Pos(']',Horas)-Pos('[',Horas)-1)));
   if Pos(':',Horas) > 0 then
      Seg := StrToInt(Copy(Horas,Pos(']',Horas)+1,(Pos(':',Horas)-Pos(']',Horas)-1)))
   else
      Seg := StrToInt(Copy(Horas,Pos(']',Horas)+1,2));
   Result := Seg + (Hor*3600) + (Min*60);
end;

{Converte de segundos para hora}
function Seg_Hora( Seg:LongInt ):string;
Var Hora,Min:LongInt;
    Tmp : Double;
begin
   Tmp := Seg / 3600;
   Hora := Round(Int(Tmp));
   Seg :=  Round(Seg - (Hora*3600));
   Tmp := Seg / 60;
   Min := Round(Int(Tmp));
   Seg :=  Round(Seg - (Min*60));
   Result := StrZero(Hora,2,0)+':'+StrZero(Min,2,0)+':'+StrZero(Seg,2,0);
end;

{converte tudo para minuscula}
Function  Minuscula(InString: String): String;
Var I: Integer;
Begin
  Result := LowerCase(InString);
  For I := 1 To Length(InString) - 1 Do Begin
    If (Result[I] = ' ') Or (Result[I] = '''') Or (Result[I] = '"')
    Or (Result[I] = '-') Or (Result[I] = '.')  Or (Result[I] = '(') Then
      Result[I] := UpCase(Result[I]);
    if Result[I] = 'Ç' then
      Result[I] := 'ç';
    if Result[I] = 'Ã' then
      Result[I] := 'ã';
    if Result[I] = 'Á' then
      Result[I] := 'á';
    if Result[I] = 'É' then
      Result[I] := 'é';
    if Result[I] = 'Í' then
      Result[I] := 'í';
    if Result[I] = 'Õ' then
      Result[I] := 'õ';
    if Result[I] = 'Ó' then
      Result[I] := 'ó';
    if Result[I] = 'Ú' then
      Result[I] := 'ú';
    if Result[I] = 'Â' then
      Result[I] := 'â';
    if Result[I] = 'Ê' then
      Result[I] := 'ê';
    if Result[I] = 'Ô' then
      Result[I] := 'ô';
  End;
End;

{esconde|exibe a barra do Windows}
procedure SetTaskBar(Visible: Boolean);
var
  wndHandle : THandle;
  wndClass : array[0..50] of Char;
begin
  StrPCopy(@wndClass[0],'Shell_TrayWnd');
  wndHandle := FindWindow(@wndClass[0], nil);
  If Visible = True then
    ShowWindow(wndHandle, SW_RESTORE)
  else ShowWindow(wndHandle, SW_HIDE);
end;

function StrZero(Num:Real ; Zeros,Deci:integer): string;
var Tam,Z:integer;
    Res,Zer:string;
begin
   Str(Num:Zeros:Deci,Res);
   Res := Trim(Res);
   Tam := Length(Res);
   Zer := '';
   for z := 01 to (Zeros-Tam) do
      Zer := Zer + '0';
   Result := Zer+Res;
end;

Function OrdenaPinta(xGrid: DBGrids.TDBGrid; Column: DBGrids.TColumn; cds: TClientDataSet): boolean;
const
  idxDefault = 'DEFAULT_ORDER';
var
  strColumn: string;
  bolUsed: boolean;
  idOptions: TIndexOptions;
  i: integer;
  VDescendField: string;
  coluna : String;
begin
{
  result := False;
  if not cds.Active then
    exit;

  strColumn := idxDefault;

  // não faz nada caso seja um campo calculado
  if (Column.Field.FieldKind = fkCalculated) then
    exit;

  // índice já está sendo utilizado
  bolUsed := (Column.Field.FieldName = cds.IndexName);

  // seta o nome da coluna na variavel para carga de dados e pesquisa
  coluna := Column.Field.FieldName;

  // verifica a existência do índice e propriedades
  cds.IndexDefs.Update;
  idOptions := [];
  for i := 0 to cds.IndexDefs.Count - 1 do
  begin
    if cds.IndexDefs.Items[i].Name = Column.Field.FieldName then
    begin
      strColumn := Column.Field.FieldName;
      // determina como deve ser criado o índice, inverte a condição ixDescending
      case (ixDescending in cds.IndexDefs.Items[i].Options) of
        True:
          begin
            idOptions := [];
            VDescendField := '';
          end;
        False:
          begin
            idOptions := [ixDescending];
            VDescendField := strColumn;
          end;
      end;
    end;
  end;

  // caso não encontre o índice ou o mesmo esteja em uso
  if (strColumn = idxDefault) or bolUsed then
  begin
    if bolUsed then
      cds.DeleteIndex(Column.Field.FieldName);
    try
      cds.AddIndex(Column.Field.FieldName, Column.Field.FieldName, idOptions,
        VDescendField, '', 0);
      strColumn := Column.Field.FieldName;
    except
      // se índice indeterminado, seta o padrão
      if bolUsed then
        strColumn := idxDefault;
    end;
  end;

  // pinta todas as outras colunas com a cor padrão e a coluna clicada com a cor Azul
  for i := 0 to xGrid.Columns.Count - 1 do
  begin
    if Pos(strColumn, xGrid.Columns[i].Field.FieldName) <> 0 then
      xGrid.Columns[i].Title.Font.Color := clBlue
    else
      xGrid.Columns[i].Title.Font.Color := clWindowText;
  end;

  // tenta setar o índice, caso ocorra algum erro seta o padrão
  try
    cds.IndexName := strColumn;
  except
    cds.IndexName := idxDefault;
  end;
}
  result := True;
end;

function MD5File(const fileName: string): string;
var
  idmd5 : TIdHashMessageDigest5;
  fs : TFileStream;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  fs := TFileStream.Create(fileName, fmOpenRead OR fmShareDenyWrite) ;
  try
    result := idmd5.HashStreamAsHex(fs);
  finally
    fs.Free;
    idmd5.Free;
  end;
end;

function MD5String(const texto: string): string;
var
  idmd5: TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    result := LowerCase(idmd5.HashStringAsHex(texto));
  finally
  idmd5.Free;
  end;
end;

Function TruncaValor(Value:Extended;Casas:Integer):Extended;
Var sValor:String;
    nPos:Integer;
begin
   //Transforma o valor em string
   sValor := FloatToStr(Value);

   //Verifica se possui ponto decimal
   nPos := Pos(DecimalSeparator,sValor);
   If ( nPos > 0 ) Then begin
      sValor := Copy(sValor,1,nPos+Casas);
   End;

   Result := StrToFloat(sValor);
end;

Function ArredondaTruncaValor(Operacao:String;Value:Extended;Casas:Integer):Extended;
Var
  sValor:String;
  nPos:Integer;
begin
  if Operacao = 'A' then
    result := SimpleRoundTo(Value,Casas*-1)
  else
  begin
    //Transforma o valor em string
    sValor := FloatToStr(Value);

    //Verifica se possui ponto decimal
    nPos := Pos(DecimalSeparator,sValor);
    If ( nPos > 0 ) Then begin
      sValor := Copy(sValor,1,nPos+Casas);
    End;

    Result := StrToFloat(sValor);
  end;
end;

function UltimoDiaMes(Mdt: TDateTime) : String;
var
  ano, mes, dia : word;
  mDtTemp : TDateTime;
begin
  Decodedate(mDt, ano, mes, dia);
  mDtTemp := (mDt - dia) + 33;
  Decodedate(mDtTemp, ano, mes, dia);
  mDtTemp := mDtTemp - dia;
  Decodedate(mDtTemp, ano, mes, dia);
  Result := IntToStr(dia)
end;

function FormataFloat(Tipo:String; Valor: Extended): string; //Tipo => 'Q'=Quantidade | 'V'=Valor
var
  i:integer;
  Mascara:String;
begin
  Mascara := '0.';

  if Tipo = 'Q' then
  begin
    for i := 1 to Constantes.TConstantes.DECIMAIS_QUANTIDADE do
      Mascara := Mascara + '0';
  end
  else if Tipo = 'V' then
  begin
    for i := 1 to Constantes.TConstantes.DECIMAIS_VALOR do
      Mascara := Mascara + '0';
  end;

  Result := FormatFloat(Mascara, Valor);
end;

procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings)) ;
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

function VersaoExe(exe, param : string): String;   // acrescentar
type
   PFFI = ^vs_FixedFileInfo;
var
  F : PFFI;
  Handle : Dword;
  Len : Longint;
  Data : Pchar;
  Buffer : Pointer;
  Tamanho : Dword;
  Parquivo: Pchar;

begin

  Parquivo := StrAlloc(Length(Exe) + 1);
  StrPcopy(Parquivo, Exe);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data:=StrAlloc(Len+1);
    if GetFileVersionInfo(Parquivo,Handle,Len,Data) then
    begin
      VerQueryValue(Data, '\',Buffer,Tamanho);
      F := PFFI(Buffer);
      if param = 'N' then
      begin
        Result := Format('%d%d%d%d',
        [HiWord(F^.dwFileVersionMs),
        LoWord(F^.dwFileVersionMs),
        HiWord(F^.dwFileVersionLs),
        Loword(F^.dwFileVersionLs)]);
      end else if param = 'V' then
      begin
        Result := Format('%d.%d.%d.%d',
        [HiWord(F^.dwFileVersionMs),
        LoWord(F^.dwFileVersionMs),
        HiWord(F^.dwFileVersionLs),
        Loword(F^.dwFileVersionLs)]);
      end
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;


function DevolveConteudoDelimitado(Delimidador:string;var Linha:string):string;   // acrescentar
var
  PosBarra: integer;
begin
  PosBarra:=Pos(Delimidador,Linha);
  Result:=Copy(Linha,1,PosBarra-1);
  Delete(Linha,1,PosBarra);
end;

 procedure ConfiguraCDSFromVO(CDS: TClientDataSet; pObj : TClass);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  I: Integer;
begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(pObj);

    //Configura ClientDataset
    CDS.Close;
    CDS.FieldDefs.Clear;
    CDS.IndexDefs.Clear;

    //Preenche os nomes dos campos do CDS
    CDS.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is Atributos.TColumn then
        begin
          if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
            CDS.FieldDefs.add((Atributo as Atributos.TColumn).Name, ftString, 50)
          else
          if Propriedade.PropertyType.TypeKind in [tkFloat] then
            CDS.FieldDefs.add((Atributo as Atributos.TColumn).Name, ftFloat)
          else
          if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
            CDS.FieldDefs.add((Atributo as Atributos.TColumn).Name, ftInteger)
        end;
      end;
    end;
    CDS.CreateDataSet;
  finally
    Contexto.Free;
  end;
end;

function TextoParaData(pData: string): TDate;
var
  Dia, Mes, Ano: Integer;
begin
  if (pData <> '') AND (pData <> '0000-00-00') then
  begin
    Dia := StrToInt(Copy(pData,9,2));
    Mes := StrToInt(Copy(pData,6,2));
    Ano := StrToInt(Copy(pData,1,4));
    Result := EncodeDate(Ano,Mes,Dia);
  end
  else
  begin
    Result := 0;
  end;
end;

function DataParaTexto(pData: TDate): string;
begin
  if pData > 0 then
    Result := FormatDateTime('YYYY-MM-DD',pData)
  else
    Result := '0000-00-00';
end;

function CriaGuidStr: string;
var
  Guid: TGUID;
begin
  CreateGUID(Guid);
  Result := GUIDToString(Guid);
end;

function  MessageYes(Msg: string): Boolean;
begin
  Result := Application.MessageBox(PChar(Msg),
  PChar(Application.Title),
  MB_YESNO + MB_ICONINFORMATION) = IDYES;
end;

procedure MessageInfo(Msg: string);
begin
  Application.MessageBox(PChar(Msg), PChar(Application.Title),
  MB_OK + MB_ICONINFORMATION);
end;

procedure MessageErro(Msg: string);
begin
  Application.MessageBox(PChar(Msg), PChar(Application.Title),
  MB_OK + MB_ICONERROR);
end;

procedure MessageWarn(Msg: string);
begin
  Application.MessageBox(PChar(Msg), PChar(Application.Title),
  MB_OK + MB_ICONWARNING);
end;

procedure LimpaEdits(Form: TForm);
var
 i: Integer;
begin
  for I := 0 to Form.ComponentCount - 1 do
  begin
    if form.Components[i] is TCustomEdit then
      (form.Components[i] as TCustomEdit).Text := '';
  end;

end;

Function ColocaZerosEsquerda(S:String;vT:Integer):String;
Var X : Integer;
    H : String;
begin
  case vT of
    2: H := '00';
    3: H := '000';
    4: H := '0000';
    5: H := '00000';
    6: H := '000000';
    7: H := '0000000';
    8: H := '00000000';
    9: H := '000000000';
    10: H := '0000000000';
    11: H := '00000000000';
    12: H := '000000000000';
    13: H := '0000000000000';
  end;
  X := Length(S);
  Delete(H,1,X);
  Result := H + S;
end;

end.
