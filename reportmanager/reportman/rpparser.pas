{*******************************************************}
{                                                       }
{       Rptparser                                       }
{       Expression parser for TRpEvaluator              }
{       Report Manager                                  }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpparser;

{$I rpconf.inc}

interface


uses Classes,sysutils,
 rpmdconsts,rptypeval;
type


  TRpParser = class(TObject)
  private
    FNewExpression:AnsiString;
    FStream: TStream;
    FOrigin: Longint;
    FBuffer: array of Byte;
    FBufPtr: Integer;
    FBufEnd: Integer;
    FSourcePtr: Integer;
    FSourceEnd: Integer;
    FTokenPtr: Integer;
    FStringPtr: Integer;
    FSourceLine: Integer;
    FSaveChar: Byte;
    FToken: Char;
    FFloatType: Char;
    FWideStr: WideString;
    ParseBufSize :integer;
    procedure ReadBuffer;
    procedure SkipBlanks;
    procedure SetExpression(Value:AnsiString);
  public
    constructor Create;
    destructor Destroy;override;
    procedure CheckToken(T: Char);
    procedure CheckTokenSymbol(const S: Ansistring);
    procedure Error(MessageID:WideString);
    procedure HexToBinary(Stream: TStream);
    function NextToken: Char;
    function SourcePos: Longint;
    function TokenComponentIdent: Ansistring;
    function TokenFloat: Double;
//    function TokenInt: Int64;
    function TokenInt: Integer;
    function TokenString: Ansistring;
    function TokenWideString: WideString;
    function TokenSymbolIs(const S: Ansistring): Boolean;
    // Ask for the next token
    function NextTokenIs(Value:Ansistring):Boolean;
    property FloatType: Char read FFloatType;
    property SourceLine: Integer read FSourceLine;
    property Token: Char read FToken;
    property Expression:AnsiString read FNewExpression write SetExpression;
  end;

var
 ParserSetChars:set of Char=
{$IFDEF DOTNETD}
  ['A'..'Z', 'a'..'z','0'..'9', '_','.'];
{$ENDIF}
{$IFNDEF DOTNETD}
  ['A'..'Z', 'a'..'z','á','à','é','è','í','ó','ò','ú', 'Ñ','ñ','0'..'9','_','.',
         'ä','Ä','ö','Ö','ü','Ü','Á','À','É','È','Í','Ó','Ò','Ú','ß'];
{$ENDIF}

implementation

function SameText(const S1, S2: string): Boolean;
begin
  Result := CompareText(S1, S2) = 0;
end;



const
  H2BConvert: array['0'..'f'] of SmallInt =
    ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15);

function HexToBin(const Text: array of Byte; TextOffset: Integer;
  Buffer: array of Byte; BufOffset: Integer; Count: Integer): Integer;
var
  I, C: Integer;
begin
  C := 0;
  for I := 0 to Count - 1 do
  begin
    if not (AnsiChar(Text[TextOffset + I * 2]) in [AnsiChar('0')..AnsiChar('f')]) or
       not (AnsiChar(Text[TextOffset + 1 + I * 2]) in [AnsiChar('0')..AnsiChar('f')]) then
      Break;
    Buffer[BufOffset + I] :=
      (H2BConvert[AnsiChar(Text[TextOffset + I * 2])] shl 4) or
       H2BConvert[AnsiChar(Text[TextOffset + 1 + I * 2])];
    Inc(C);
  end;
  Result := C;
end;

function ALineStart(Buffer: array of Byte; BufPos: Integer): Integer;
begin
  while (BufPos > 0) and (Buffer[BufPos] <> 10) do
    Dec(BufPos);
  if Buffer[BufPos] = 10 then
    Inc(BufPos);
  Result := BufPos;
end;


constructor TRpParser.Create;
begin
  inherited Create;
  ParseBufSize := 4096;
  SetLength(FBuffer, ParseBufSize);
end;


procedure TRpParser.CheckToken(T: Char);
begin
  if Token <> T then
    case T of
      toSymbol:
        Error(SRpIdentifierExpected);
      tkString:
        Error(SRpstringExpected);
      toWString:
        Error(SRpstringExpected);
      toInteger, toFloat:
        Error(SRpNumberExpected);
      toOperator:
        Error(SRpOperatorExpected);
    end;
end;

procedure TRpParser.Error(MessageID: WideString);
begin
  Raise TRpEvalException.Create(MessageID,Tokenstring,SourceLine,SourcePos);
end;


procedure TRpParser.CheckTokenSymbol(const S: Ansistring);
begin
  if not TokenSymbolIs(S) then
   Raise TRpEvalException.Create(Format(SRpExpected, [S]),'',SourceLine,SourcePos);
end;


procedure TRpParser.HexToBinary(Stream: TStream);
var
  Count: Integer;
  Buffer: array[0..255] of Byte;
begin
  SkipBlanks;
  while Char(FBuffer[FSourcePtr]) <> '}' do
  begin
    Count := HexToBin(FBuffer, FSourcePtr, Buffer, 0, SizeOf(Buffer));
    if Count = 0 then
      Error(SRpEvalSyntax);
    Stream.Write(Buffer, Count);
    Inc(FSourcePtr, Count * 2);
    SkipBlanks;
  end;
  NextToken;
end;

function TRpParser.NextToken: Char;
var
  I, J: Integer;
  IsWideStr: Boolean;
  P, S: Integer;
  achar:AnsiChar;
  operadors:string;
  operador:Char;
begin
  SkipBlanks;
  P := FSourcePtr;
  FTokenPtr := P;
  case AnsiChar(FBuffer[P]) of
    // Identifiers
{$IFDEF DOTNETD}
    'A'..'Z', 'a'..'z','_':
{$ENDIF}
{$IFNDEF DOTNETD}
    'A'..'Z', 'a'..'z','á','à','é','è','í','ó','ò','ú', 'Ñ','ñ','_',
     'ä','Ä','ö','Ö','ü','Ü','Á','À','É','È','Í','Ó','Ò','Ú','ß':
{$ENDIF}
      begin
        Inc(P);
{$IFDEF DOTNETD}
        while AnsiChar(FBuffer[P]) in ['A'..'Z', 'a'..'z','0'..'9', '_','.'] do
{$ENDIF}
{$IFNDEF DOTNETD}
        while AnsiChar(FBuffer[P]) in ['A'..'Z', 'a'..'z','á','à','é','è','í','ó','ò','ú', 'Ñ','ñ','0'..'9','_','.',
         'ä','Ä','ö','Ö','ü','Ü','Á','À','É','È','Í','Ó','Ò','Ú','ß'] do
{$ENDIF}
          Inc(P);
        Result := toSymbol;
      end;
    // Identifiers with blanks into brackets
    '[':
      begin
        Inc(P);
        achar:=AnsiChar(FBuffer[P]);
        while ((achar<>AnsiChar(0)) AND (achar<>']')) do
        begin
         Inc(P);
         achar:=AnsiChar(FBuffer[P]);
        end;
        // Finish?
        if achar<>']' then
         Raise Exception.Create(Format(SRpExpected,[']']));
        Inc(P);
        Result := toSymbol;
      end;
    // Operators
    '*','+','-','/','(',')',',','=','>','<',':',';':
      begin
       Result:=toOperator;
       operador:=Char(FBuffer[P]);
       Inc(P);
       case Char(FBuffer[P]) of
        '=':
         if operador in [':','!','<','>','='] then
          Inc(P);
        '<':
         if operador='>' then
          Inc(P);
        '>':
         if operador='<' then
          Inc(p);
       end;
      end;
    // Strings and chars
    '#', '''':
      begin
        IsWideStr := False;
        J := 0;
        S := P;
        while True do
          case Char(FBuffer[P]) of
            '#':
              begin
                Inc(P);
                I := 0;
                while AnsiChar(FBuffer[P]) in ['0'..'9'] do
                begin
                  I := I * 10 + (FBuffer[P] - Ord('0'));
                  Inc(P);
                end;
                if (I > 127) then
                  IsWideStr := True;
                Inc(J);
              end;
            '''':
              begin
                Inc(P);
                while True do
                begin
                  case AnsiChar(FBuffer[P]) of
                    #0, #10, #13:
                      Error(SRpEvalSyntax);
                    '''':
                      begin
                        Inc(P);
                        if Char(FBuffer[P]) <> '''' then
                          Break;
                      end;
                  end;
                  Inc(J);
                  Inc(P);
                end;
              end;
          else
            Break;
          end;
        P := S;
        if IsWideStr then
          SetLength(FWideStr, J);
        J := 1;
        while True do
          case Char(FBuffer[P]) of
            '#':
              begin
                Inc(P);
                I := 0;
                while AnsiChar(FBuffer[P]) in ['0'..'9'] do
                begin
                  I := I * 10 + (FBuffer[P] - Ord('0'));
                  Inc(P);
                end;
                if IsWideStr then
                begin
                  FWideStr[J] := WideChar(SmallInt(I));
                  Inc(J);
                end
                else
                begin
                  FBuffer[S] := I;
                  Inc(S);
                end;
              end;
            '''':
              begin
                Inc(P);
                while True do
                begin
                  case FBuffer[P] of
                    0, 10, 13:
                      Error(SRpEvalSyntax);
                    Ord(''''):
                      begin
                        Inc(P);
                        if Char(FBuffer[P]) <> '''' then
                          Break;
                      end;
                  end;
                  if IsWideStr then
                  begin
                    FWideStr[J] := WideChar(FBuffer[P]);
                    Inc(J);
                  end
                  else
                  begin
                    FBuffer[S] := FBuffer[P];
                    Inc(S);
                  end;
                  Inc(P);
                end;
              end;
          else
            Break;
          end;
        FStringPtr := S;
        if IsWideStr then
          Result := toWString
        else
          Result := tkString;
      end;
    // Hex numbers
    '$':
      begin
        Inc(P);
        while AnsiChar(FBuffer[P]) in ['0'..'9', 'A'..'F', 'a'..'f'] do
          Inc(P);
        Result := toInteger;
      end;
    // Numbers
    '0'..'9':
      begin
        Inc(P);
        while AnsiChar(FBuffer[P]) in ['0'..'9'] do
          Inc(P);
        Result := toInteger;
        while AnsiChar(FBuffer[P]) in ['0'..'9', '.', 'e', 'E'] do
        begin
          if AnsiChar(FBuffer[P])='.' then
          begin
{$IFNDEF DOTNETD}
           FBuffer[P]:=Byte(DecimalSeparator);
{$ENDIF}
{$IFDEF DOTNETD}
           FBuffer[P]:=Byte(DecimalSeparator[1]);
{$ENDIF}
          end;
          Inc(P);
          Result := toFloat;
        end;
        if (AnsiChar(FBuffer[P]) in ['c', 'C', 'd', 'D', 's', 'S', 'f', 'F']) then
        begin
          Result := toFloat;
          FFloatType := Char(FBuffer[P]);
          Inc(P);
        end
        else
          FFloatType := #0;
      end;
  else
    Result := Char(FBuffer[P]);
    if Result <> toEOF then
    begin
     Result:=toSymbol;
     Inc(P);
    end;
  end;
  FSourcePtr := P;
  FToken := Result;
  // Symbols
  if FToken=toSymbol then
  begin
   OperadorS:=UpperCase(TokenString);
   if ((OperadorS='OR') OR (OperadorS='NOT')
        OR (OperadorS='AND') OR (OperadorS='IIF')) then
   begin
    Result:=toOperator;
    FToken:=toOperator;
   end;
  end;
end;

procedure TRpParser.ReadBuffer;
var
  Count: Integer;
begin
  Inc(FOrigin, FSourcePtr);
  FBuffer[FSourceEnd] := FSaveChar;
  Count := FBufPtr - FSourcePtr;
  if Count <> 0 then
  begin
{$IFDEF DOTNETD}
    System.Array.Copy(FBuffer, FSourcePtr, FBuffer, 0, Count);
{$ENDIF}
{$IFNDEF DOTNETD}
   Move(FBuffer[FSourcePtr],FBuffer[0],Count);
{$ENDIF}
  end;
  FBufPtr := Count;
{$IFDEF DOTNETD}
  Inc(FBufPtr, FStream.Read(FBuffer, FBufPtr, FBufEnd - FBufPtr));
{$ENDIF}
{$IFNDEF DOTNETD}
  Inc(FBufPtr, FStream.Read(FBuffer[FBufPtr], FBufEnd - FBufPtr));
{$ENDIF}
  FSourcePtr := 0;
  FSourceEnd := FBufPtr;
  if FSourceEnd = FBufEnd then
  begin
    FSourceEnd := ALineStart(FBuffer, FSourceEnd - 2);
    if FSourceEnd = 0 then
      Error(SRpLineTooLong);
  end;
  FSaveChar := FBuffer[FSourceEnd];
  FBuffer[FSourceEnd] := 0;
end;

procedure TRpParser.SkipBlanks;
begin
  while True do
  begin
    case FBuffer[FSourcePtr] of
      0:
        begin
          ReadBuffer;
          if FBuffer[FSourcePtr] = 0 then
            Exit;
          Continue;
        end;
      10:
        Inc(FSourceLine);
      33..255:
        Exit;
    end;
    Inc(FSourcePtr);
  end;
end;

function TRpParser.SourcePos: Longint;
begin
  Result := FOrigin + FTokenPtr;
end;

function TRpParser.TokenFloat: Double;
begin
  if FFloatType <> #0 then
    Dec(FSourcePtr);
  Result := StrToFloat(TokenString);
  if FFloatType <> #0 then
    Inc(FSourcePtr);
end;

function TRpParser.TokenInt: Integer;
begin
  Result := StrToInt64(TokenString);
end;

function TRpParser.TokenString: Ansistring;
var
  L: Integer;
begin
  if FToken = tkString then
    L := FStringPtr - FTokenPtr
  else
    L := FSourcePtr - FTokenPtr;
{$IFDEF DOTNETD}
  Result := AnsiEncoding.GetString(FBuffer, FTokenPtr, L);
{$ENDIF}
{$IFNDEF DOTNETD}
  SetString(Result,PAnsichar(@FBuffer[FTokenPtr]),L);
{$ENDIF}
  // Brackets out
  if FToken=toSymbol then
  begin
   if Length(Result)>0 then
   begin
    if Result[1]='[' then
     if Result[Length(Result)]=']' then
      Result:=Copy(Result,2,Length(Result)-2);
   end;
  end;
end;

function TRpParser.TokenWideString: WideString;
begin
  if FToken = tkString then
    Result := TokenString
  else
    Result := FWideStr;
end;

function TRpParser.TokenSymbolIs(const S: Ansistring): Boolean;
begin
  Result := (Token = toSymbol) and SameText(S, TokenString);
end;

function TRpParser.TokenComponentIdent: Ansistring;
var
  P: Integer;
begin
  CheckToken(toSymbol);
  P := FSourcePtr;
  while AnsiChar(FBuffer[P]) = '.' do
  begin
    Inc(P);
    if not (AnsiChar(FBuffer[P]) in ['A'..'Z', 'a'..'z', '_']) then
      Error(SRpIdentifierexpected);
    repeat
      Inc(P)
    until not (AnsiChar(FBuffer[P]) in ['A'..'Z', 'a'..'z', '0'..'9', '_']);
  end;
  FSourcePtr := P;
  Result := TokenString;
end;





function TRpParser.NextTokenIs(Value:Ansistring):Boolean;
var NewParser:TRpParser;
    Apuntador:Integer;
begin
  // A new parser must be create for checking the next token
  Apuntador:=FSourcePtr;
  NewParser:=TRpParser.Create;
  try
   NewParser.Expression:=Copy(Expression,Apuntador+1,Length(Expression));
   Result:=False;
   if NewParser.Token in [toSymbol,toOperator] then
    if NewParser.TokenString=Value then
     Result:=True;
  finally
   NewParser.free;
  end;
end;

procedure TRpParser.SetExpression(Value:AnsiString);
begin
  if Assigned(FStream) then
   FStream.free;
  FStream := TMemoryStream.Create;
  if Length(Value)>0 then
   FStream.Write(Value[1],Length(Value));
  FStream.Seek(0,soFromBeginning);
  FNewExpression:=Value;
  if (Length(Value)>(ParseBufSize-1)) then
  begin
   ParseBufSize:=Length(Value)*2;
   SetLength(FBuffer, ParseBufSize);
  end;
  FBuffer[0] := 0;
  FBufPtr := 0;
  FBufEnd := ParseBufSize;
  FSourcePtr := 0;
  FSourceEnd := 0;
  FTokenPtr := 0;
  FSourceLine := 1;
  NextToken;
end;

destructor TRpParser.Destroy;
begin
  if Assigned(FStream) then
   FStream.free;

 inherited destroy;
end;

end.
