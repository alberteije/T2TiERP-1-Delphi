{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpmdbarcode                                     }
{       TRpBarcode printable component                  }
{       Barcode implementation                          }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{       The component is based in Barcode component     }
{       Barcode Component                               }
{       Version 1.3                                     }
{       Copyright 1998-99 Andreas Schmidt and friends   }
{       mailto:shmia@bizerba.de or                      }
{       a_j_schmidt@rocketmail.com                      }
{       Lisenced as Freeware                            }
{                                                       }
{       It has been revised added properties and        }
{       implementation for 128C optimized codebar       }
{                                                       }
{       September 2004 Added PDF417 2D barcode support  }
{       based on Turbo Power Systools codebase          }
{                                                       }
{                                                       }
{*******************************************************}

unit rpmdbarcode;

interface

{$I rpconf.inc}

uses
 SysUtils, Classes,rpmdconsts,rptypes,rpeval,rpmetafile,
{$IFDEF USEVARIANTS}
 Types,Variants,
{$ENDIF}
{$IFDEF MSWINDOWS}
 Windows,
{$ENDIF}
 rpprintitem,rpbarcodecons,math;

const
 MAX_DIGITS_NUM=2000;
type
 TRpBarcodeType = (bcCode_2_5_interleaved,
		bcCode_2_5_industrial,
		bcCode_2_5_matrix,
		bcCode39,
		bcCode39Extended,
		bcCode128A,
		bcCode128B,
		bcCode128C,
                bcCode128,
		bcCode93,
		bcCode93Extended,
		bcCodeMSI,
		bcCodePostNet,
		bcCodeCodabar,
		bcCodeEAN8,
        	bcCodeEAN13,
                bcCodePDF417
				);

 TRpDigit='0'..'9';

 TSPDF417CodewordList = array [0..2700] of Word;
 TSPDF417ECCLevels = (ecAuto, ecLevel0, ecLevel1, ecLevel2, ecLevel3,
                        ecLevel4, ecLevel5, ecLevel6, ecLevel7, ecLevel8);


 TRpBarcode = class(TRpCommonPosComponent)
  private
   FDisplayFormat:Widestring;
   FExpression:widestring;
   FValue:Variant;
   FModul:integer;
   FRatio:double;
   FTyp:TRpBarcodeType;
   FCheckSum:boolean;
   FUpdated:boolean;
   FRotation:SmallInt;
   FBColor:integer;
   FECCLevel,FNumRows,FNumColumns:Integer;
   FTruncated:Boolean;
   FCodewords:TSPDF417CodewordList;
   FNumCodewords:Integer;
   FUsedCodewords:Integer;
   FUsedECCCodewords:Integer;
   FFreeCodewords:Integer;
   FTotalCodewords:Integer;
   FNewTextCodeword : Boolean;
   FPDFLeft,FPDFTop:Integer;
   FPDFMeta:TRpMetafileReport;
   modules:array[0..3] of integer;
   function Code_2_5_interleaved: AnsiString;
   function Code_2_5_industrial: AnsiString;
   function Code_2_5_matrix: AnsiString;
   function Code_39: AnsiString;
   function Code_39Extended: AnsiString;
   function Code_128: AnsiString;
   function Code_93: AnsiString;
   function Code_93Extended: AnsiString;
   function Code_MSI: AnsiString;
   function Code_PostNet: AnsiString;
   function Code_Codabar: AnsiString;
   function Code_EAN8: AnsiString;
   function Code_EAN13: AnsiString;
   procedure MakeModules;
   procedure SetModul(v:integer);
   procedure Evaluate;
   procedure WriteExpression(Writer:TWriter);
   procedure ReadExpression(Reader:TReader);
   function GetRealErrorLevel : Integer;
   procedure GenerateCodewords;
   procedure TextToCodewords;
   procedure SetECCLevel(NValue:Integer);
   procedure CalculateSize (var XSize : Integer;
                            var YSize : Integer);
   procedure CalculateECC (NumCodewords:Integer;ECCLen:Integer);
   procedure EncodeBinary (var Position : Integer; CodeLen : Integer);
   procedure EncodeNumeric (var Position : Integer; CodeLen : Integer);
   procedure EncodeText (var Position : Integer; CodeLen : Integer);
   procedure ConvertBytesToBase900 (const S : array of byte;
                                       var A : array of integer);
   procedure ConvertToBase900 (const S : AnsiString;
                                  var A : array of integer;
                                  var LenA : integer);
   procedure GetNextCharacter (var NewChar  : Integer;
                                             var Codeword : Boolean;
                                             var Position : Integer;
                                             CodeLen      : Integer);
   function IsNumericString (const S : AnsiString) : boolean;
   procedure Draw2DBarcode(FLeft,FTop:integer;meta:TRpMetaFileReport);
   procedure DrawStartPattern (RowNumber     : Integer;
                                             WorkBarHeight : Integer);
   procedure DrawStopPattern (RowNumber     : Integer;
                                            ColNumber     : Integer;
                                            WorkBarHeight : Integer);
   procedure DrawLeftRowIndicator (RowNumber     : Integer;
                                                 WorkBarHeight : Integer;
                                                 NumRows       : Integer;
                                                 NumCols       : Integer);
   procedure DrawRightRowIndicator (RowNumber     : Integer;
                                                  ColNumber     : Integer;
                                                  WorkBarHeight : Integer;
                                                  NumRows       : Integer;
                                                  NumCols       : Integer);
   procedure DrawCodeword (RowNumber     : Integer;
                                         ColNumber     : Integer;
                                         WorkBarHeight : Integer;
                                         Pattern       : AnsiString);
   procedure DrawCodewordBitmask (RowNumber     : Integer;
                                                ColNumber     : Integer;
                                                WorkBarHeight : Integer;
                                                Bitmask       : DWord);
   function CodewordToBitmask (RowNumber : Integer;
                                             Codeword  : Integer) : DWord;
   procedure WriteDispFormat(Writer:TWriter);
   procedure ReadDispFormat(Reader:TReader);
  protected
   procedure DoPrint(adriver:TRpPrintDriver;aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);override;
   procedure DefineProperties(Filer:TFiler);override;
   function  GoodForNumericCompaction (Position : Integer;
                                          CodeLen : Integer;
                                          var Count : Integer) : Boolean;
   function  GoodForTextCompaction (Position : Integer;
                                       CodeLen : Integer;
                                       var Count : Integer) : Boolean;
   procedure AddCodeword (Value : Word);
  public
   CurrentText: AnsiString;
   function  CalculateBarcode: AnsiString;
   procedure DoLines(data: AnsiString;FLeft,FTop:integer;meta:TRpMetafileReport);
   function GetText:widestring;
   function GetTypText: AnsiString;
   procedure SubReportChanged(newstate:TRpReportChanged;newgroup: String='');override;
   constructor Create(Owner:TComponent); override;
//   procedure DrawText(Canvas:TCanvas);
   property Expression:widestring read FExpression write FExpression;
  published
    // Width of the smallest line in a Barcode
   property Modul:integer read FModul  write SetModul;
   property Ratio:double  read FRatio  write FRatio;
   property Typ:TRpBarcodeType read FTyp write FTyp default bcCodeEAN13;
   // build CheckSum ?
   property Checksum:boolean read FCheckSum write FCheckSum default false;
   property DisplayFormat:Widestring read FDisplayformat write FDisplayFormat;
   property Rotation:smallint read FRotation write FRotation default 0;
   property BColor:integer read FBColor write FBColor default $0;
   // PDF417
   property NumColumns:Integer read FNumColumns write FNumColumns default 0;
   property NumRows:Integer read FNumRows write FNumRows default 0;
   property ECCLevel : Integer read FECCLevel write SetECCLevel default -1;
   property Truncated : Boolean read FTruncated write FTruncated
           default False;
  end;

 const BarcodeTypeStrings:array[bcCode_2_5_interleaved..bcCodePDF417] of string=
  ('2_5_interleaved','2_5_industrial',
   '2_5_matrix','Code39','Code39Extended',
   '128A','128B','128C','128',
   'Code93','Code93Ex','MSI',
   'PostNet','Codabar','EAN8','EAN13','PDF417');

 function StringBarcodeToBarCodeType(value: AnsiString):TRpBarCodeType;
 function StringECCToInteger(value: AnsiString):Integer;
 function ECCToString(value:integer): AnsiString;
 procedure FillECCValues(alist:TRpWideStrings);

implementation

uses rpbasereport;

procedure TRpBarcode.WriteDispFormat(Writer:TWriter);
begin
 WriteWideString(Writer, FDisplayFormat);
end;

procedure TRpBarcode.ReadDispFormat(Reader:TReader);
begin
 FDisplayFormat:=ReadWideString(Reader);
end;


function StringBarcodeToBarCodeType(value: AnsiString):TRpBarCodeType;
var
 i:TRpBarCodeType;
begin
 Result:=bcCodeEAN13;
 for i:=bcCode_2_5_interleaved to bcCodePDF417 do
 begin
  if (value=BarcodeTypeStrings[i]) then
  begin
   Result:=i;
   break;
  end;
 end;
end;


{
	converts a string from '321' to the internal representation '715'
	i need this function because some pattern tables have a different
	format :

	'00111'
	converts to '05161'

}
function Convert(s: AnsiString): AnsiString;
var
	i, v : integer;
	t : AnsiString;
begin
	t := '';
	for i:=1 to Length(s) do
	begin
		v := ord(s[i]) - 1;

		if odd(i) then
			Inc(v, 5);
		t := t + Chr(v);
	end;
	Convert := t;
end;

(*
 * Berechne die Quersumme aus einer Zahl x
 * z.B.: Quersumme von 1234 ist 10
 *)
function quersumme(x:integer):integer;
var
	sum:integer;
begin
	sum := 0;

	while x > 0 do
	begin
		sum := sum + (x mod 10);
		x := x div 10;
	end;
	result := sum;
end;


{
	Rotate a Point by Angle 'alpha'
}
function Rotate2D(p:TPoint; alpha:double): TPoint;
var
	sinus, cosinus : Double;
begin
	sinus   := sin(alpha);
	cosinus := cos(alpha);
	result.x := Round(p.x*cosinus + p.y*sinus);
	result.y := Round(-p.x*sinus + p.y*cosinus);
end;

{
	Move Point a by Vector b
}
function Translate2D(a, b:TPoint): TPoint;
begin
	result.x := a.x + b.x;
	result.y := a.y + b.y;
end;


constructor TRpBarcode.Create(Owner:TComponent);
begin
	inherited Create(owner);
  FBColor:=0;
  FRatio := 2.0;
  FModul := 10;
  FTyp   := bcCodeEAN13;
  FCheckSum := false;
  FRotation := 0;
  FExpression:=QuotedStr(SRpSampleBarCode);
  FECCLevel:=-1;
  FNumRows:=0;
  FNumColumns:=0;
  FTruncated:=false;
end;




function TRpBarcode.GetTypText: AnsiString;

const bcNames:array[bcCode_2_5_interleaved..bcCodeEAN13] of string =
	(
		('2_5_interleaved'),
		('2_5_industrial'),
		('2_5_matrix'),
		('Code39'),
		('Code39 Extended'),
		('Code128A'),
		('Code128B'),
		('Code128C'),
		('Code128'),
		('Code93'),
		('Code93 Extended'),
		('MSI'),
		('PostNet'),
		('Codebar'),
		('EAN8'),
		('EAN13')
	);

begin
	Result := bcNames[FTyp];
end;



// set Modul Width
procedure TRpBarcode.SetModul(v:integer);
begin
 if (v<1) then
  v:=1;
 FModul := v;
end;

////////////////////////////// EAN /////////////////////////////////////////

function getEAN(Nr : AnsiString) : AnsiString;
   var i,fak,sum : Integer;
       tmp   : AnsiString;
begin
     sum := 0;
     tmp := copy(nr,1,Length(Nr)-1);
     fak := Length(tmp);
     for i:=1 to length(tmp) do
         begin
         if (fak mod 2) = 0 then
            sum := sum + (StrToInt(tmp[i])*1)
         else
            sum := sum + (StrToInt(tmp[i])*3);
         dec(fak);
         end;
     if (sum mod 10) = 0 then
        result := tmp+'0'
     else
        result := tmp+IntToStr(10-(sum mod 10));
end;

////////////////////////////// EAN8 /////////////////////////////////////////

// Pattern for Barcode EAN Zeichensatz A
//       L1   S1   L2   S2
const tabelle_EAN_A:array['0'..'9', 1..4] of char =
	(
	('2', '6', '0', '5'),    // 0
	('1', '6', '1', '5'),    // 1
	('1', '5', '1', '6'),    // 2
	('0', '8', '0', '5'),    // 3
	('0', '5', '2', '6'),    // 4
	('0', '6', '2', '5'),    // 5
	('0', '5', '0', '8'),    // 6
	('0', '7', '0', '6'),    // 7
	('0', '6', '0', '7'),    // 8
	('2', '5', '0', '6')     // 9
	);

// Pattern for Barcode EAN Zeichensatz C
//       S1   L1   S2   L2
const tabelle_EAN_C:array['0'..'9', 1..4] of char =
	(
	('7', '1', '5', '0' ),    // 0
	('6', '1', '6', '0' ),    // 1
	('6', '0', '6', '1' ),    // 2
	('5', '3', '5', '0' ),    // 3
	('5', '0', '7', '1' ),    // 4
	('5', '1', '7', '0' ),    // 5
	('5', '0', '5', '3' ),    // 6
	('5', '2', '5', '1' ),    // 7
	('5', '1', '5', '2' ),    // 8
	('7', '0', '5', '1' )     // 9
	);


function TRpBarcode.Code_EAN8: AnsiString;
var
	i, j: integer;
        tmp : AnsiString;
begin
	if FCheckSum then
           begin
           tmp := '00000000'+string(CurrentText);
           tmp := getEAN(copy(tmp,length(tmp)-6,7)+'0');
           end
        else
           tmp := string(CurrentText);

	result := '505';   // Startcode

	for i:=1 to 4 do
            for j:= 1 to 4 do
                begin
                result := result + tabelle_EAN_A[TRpDigit(tmp[i]), j] ;
                end;

 	result := result + '05050';   // Trennzeichen

	for i:=5 to 8 do
            for j:= 1 to 4 do
                begin
                result := result + tabelle_EAN_C[TRpDigit(tmp[i]), j] ;
                end;

        result := result + '505';   // Stopcode
end;

////////////////////////////// EAN13 ///////////////////////////////////////

// Pattern for Barcode EAN Zeichensatz B
//       L1   S1   L2   S2
const tabelle_EAN_B:array['0'..'9', 1..4] of char =
	(
	('0', '5', '1', '7'),    // 0
	('0', '6', '1', '6'),    // 1
	('1', '6', '0', '6'),    // 2
	('0', '5', '3', '5'),    // 3
	('1', '7', '0', '5'),    // 4
	('0', '7', '1', '5'),    // 5
	('3', '5', '0', '5'),    // 6
	('1', '5', '2', '5'),    // 7
	('2', '5', '1', '5'),    // 8
	('1', '5', '0', '7')     // 9
	);

// Zuordung der Paraitaetsfolgen für EAN13
const tabelle_ParityEAN13:array[0..9, 1..6] of char =
	(
	('A', 'A', 'A', 'A', 'A', 'A'),    // 0
	('A', 'A', 'B', 'A', 'B', 'B'),    // 1
	('A', 'A', 'B', 'B', 'A', 'B'),    // 2
	('A', 'A', 'B', 'B', 'B', 'A'),    // 3
	('A', 'B', 'A', 'A', 'B', 'B'),    // 4
	('A', 'B', 'B', 'A', 'A', 'B'),    // 5
	('A', 'B', 'B', 'B', 'A', 'A'),    // 6
	('A', 'B', 'A', 'B', 'A', 'B'),    // 7
	('A', 'B', 'A', 'B', 'B', 'A'),    // 8
	('A', 'B', 'B', 'A', 'B', 'A')     // 9
	);

function TRpBarcode.Code_EAN13: AnsiString;
var
	i, j, LK: integer;
        tmp : AnsiString;
begin
	if FCheckSum then
	begin
		tmp := '0000000000000'+String(CurrentText);
		tmp := getEAN(copy(tmp,length(tmp)-11,12)+'0');
	end
	else
		tmp := string(CurrentText);

	LK := StrToInt(tmp[1]);
	tmp := copy(tmp,2,12);

	result := '505';   // Startcode

	for i:=1 to 6 do
	begin
		case tabelle_ParityEAN13[LK,i] of
			'A' : for j:= 1 to 4 do
						result := result + tabelle_EAN_A[TRpDigit(tmp[i]), j] ;
			'B' : for j:= 1 to 4 do
						result := result + tabelle_EAN_B[TRpDigit(tmp[i]), j] ;
			'C' : for j:= 1 to 4 do
						result := result + tabelle_EAN_C[TRpDigit(tmp[i]), j] ;
	end;
	end;

	result := result + '05050';   // Trennzeichen

	for i:=7 to 12 do
		for j:= 1 to 4 do
		begin
			result := result + tabelle_EAN_C[TRpDigit(tmp[i]), j] ;
		end;

	result := result + '505';   // Stopcode
end;

// Pattern for Barcode 2 of 5
const tabelle_2_5:array['0'..'9', 1..5] of char =
	(
	('0', '0', '1', '1', '0'),    // 0
	('1', '0', '0', '0', '1'),    // 1
	('0', '1', '0', '0', '1'),    // 2
	('1', '1', '0', '0', '0'),    // 3
	('0', '0', '1', '0', '1'),    // 4
	('1', '0', '1', '0', '0'),    // 5
	('0', '1', '1', '0', '0'),    // 6
	('0', '0', '0', '1', '1'),    // 7
	('1', '0', '0', '1', '0'),    // 8
	('0', '1', '0', '1', '0')     // 9
	);

function TRpBarcode.Code_2_5_interleaved: AnsiString;
var
	i, j: integer;
	c : char;
        FText: AnsiString;
begin
        FText:=string(CurrentText);
	result := '5050';   // Startcode

	for i:=1 to Length(FText) div 2 do
	begin
		for j:= 1 to 5 do
		begin
			if tabelle_2_5[TRpDigit(FText[i*2-1]), j] = '1' then
				c := '6'
			else
				c := '5';
			result := result + c;
			if tabelle_2_5[TRpDigit(FText[i*2]), j] = '1' then
				c := '1'
			else
				c := '0';
			result := result + c;
		end;
	end;

	result := result + '605';    // Stopcode
end;


function TRpBarcode.Code_2_5_industrial: AnsiString;
var
	i, j: integer;
        FText: AnsiString;
begin
	result := '606050';   // Startcode
        FText:=CurrentText;
	for i:=1 to Length(FText) do
	begin
		for j:= 1 to 5 do
		begin
		if tabelle_2_5[TRpDigit(FText[i]), j] = '1' then
			result := result + '60'
		else
			result := result + '50';
		end;
	end;

	result := result + '605060';   // Stopcode
end;

function TRpBarcode.Code_2_5_matrix: AnsiString;
var
	i, j: integer;
	c :char;
        FText: AnsiString;
begin
	result := '705050';   // Startcode
        FText:=CurrentText;
	for i:=1 to Length(FText) do
	begin
		for j:= 1 to 5 do
		begin
			if tabelle_2_5[TRpDigit(FText[i]), j] = '1' then
				c := '1'
			else
				c := '0';

			// Falls i ungerade ist dann mache Lücke zu Strich
			if odd(j) then
				c := chr(ord(c)+5);
			result := result + c;
		end;
		result := result + '0';   // Lücke zwischen den Zeichen
	end;

	result := result + '70505';   // Stopcode
end;


function TRpBarcode.Code_39: AnsiString;

type TCode39 =
	record
		c : AnsiChar;
		data : array[0..9] of AnsiChar;
		chk: shortint;
	end;

const tabelle_39: array[0..43] of TCode39 = (
	( c:'0'; data:'505160605'; chk:0 ),
	( c:'1'; data:'605150506'; chk:1 ),
	( c:'2'; data:'506150506'; chk:2 ),
	( c:'3'; data:'606150505'; chk:3 ),
	( c:'4'; data:'505160506'; chk:4 ),
	( c:'5'; data:'605160505'; chk:5 ),
	( c:'6'; data:'506160505'; chk:6 ),
	( c:'7'; data:'505150606'; chk:7 ),
	( c:'8'; data:'605150605'; chk:8 ),
	( c:'9'; data:'506150605'; chk:9 ),
	( c:'A'; data:'605051506'; chk:10),
	( c:'B'; data:'506051506'; chk:11),
	( c:'C'; data:'606051505'; chk:12),
	( c:'D'; data:'505061506'; chk:13),
	( c:'E'; data:'605061505'; chk:14),
	( c:'F'; data:'506061505'; chk:15),
	( c:'G'; data:'505051606'; chk:16),
	( c:'H'; data:'605051605'; chk:17),
//	( c:'I'; data:'506051600'; chk:18),
//      Fixed By Wim Vandersmissen
        (  c:'I'; data:'506051605'; chk:18),
	( c:'J'; data:'505061605'; chk:19),
	( c:'K'; data:'605050516'; chk:20),
	( c:'L'; data:'506050516'; chk:21),
	( c:'M'; data:'606050515'; chk:22),
	( c:'N'; data:'505060516'; chk:23),
	( c:'O'; data:'605060515'; chk:24),
	( c:'P'; data:'506060515'; chk:25),
	( c:'Q'; data:'505050616'; chk:26),
	( c:'R'; data:'605050615'; chk:27),
	( c:'S'; data:'506050615'; chk:28),
	( c:'T'; data:'505060615'; chk:29),
	( c:'U'; data:'615050506'; chk:30),
	( c:'V'; data:'516050506'; chk:31),
	( c:'W'; data:'616050505'; chk:32),
	( c:'X'; data:'515060506'; chk:33),
	( c:'Y'; data:'615060505'; chk:34),
	( c:'Z'; data:'516060505'; chk:35),
	( c:'-'; data:'515050606'; chk:36),
	( c:'.'; data:'615050605'; chk:37),
	( c:' '; data:'516050605'; chk:38),
	( c:'*'; data:'515060605'; chk:0 ),
	( c:'$'; data:'515151505'; chk:39),
	( c:'/'; data:'515150515'; chk:40),
	( c:'+'; data:'515051515'; chk:41),
	( c:'%'; data:'505151515'; chk:42)
	);


function FindIdx(z:AnsiChar):integer;
var
	i:integer;
begin
	for i:=0 to High(tabelle_39) do
	begin
		if z = tabelle_39[i].c then
		begin
			result := i;
			exit;
		end;
	end;
	result := -1;
end;

var
	i, idx : integer;
	checksum:integer;
        FText:Ansistring;
 zstring:AnsiString;
begin
  zstring:='0';
	checksum := 0;
	// Startcode
	result := tabelle_39[FindIdx('*')].data + zstring;

        FText:=CurrentText;
	for i:=1 to Length(FText) do
	begin
		idx := FindIdx(FText[i]);
		if idx < 0 then
			continue;
		result := result + tabelle_39[idx].data + zstring;
		Inc(checksum, tabelle_39[idx].chk);
	end;

	// Calculate Checksum Data
	if FCheckSum then
		begin
		checksum := checksum mod 43;
		for i:=0 to High(tabelle_39) do
			if checksum = tabelle_39[i].chk then
			begin
				result := result + tabelle_39[i].data + AnsiChar('0');
				exit;
			end;
		end;

	// Stopcode
	result := result + tabelle_39[FindIdx('*')].data;
end;

function TRpBarcode.Code_39Extended: AnsiString;

const code39x : array[0..127] of string[2] =
	(
	('%U'), ('$A'), ('$B'), ('$C'), ('$D'), ('$E'), ('$F'), ('$G'),
	('$H'), ('$I'), ('$J'), ('$K'), ('$L'), ('$M'), ('$N'), ('$O'),
	('$P'), ('$Q'), ('$R'), ('$S'), ('$T'), ('$U'), ('$V'), ('$W'),
	('$X'), ('$Y'), ('$Z'), ('%A'), ('%B'), ('%C'), ('%D'), ('%E'),
	 (' '), ('/A'), ('/B'), ('/C'), ('/D'), ('/E'), ('/F'), ('/G'),
	('/H'), ('/I'), ('/J'), ('/K'), ('/L'), ('/M'), ('/N'), ('/O'),
	( '0'),  ('1'),  ('2'),  ('3'),  ('4'),  ('5'),  ('6'),  ('7'),
	 ('8'),  ('9'), ('/Z'), ('%F'), ('%G'), ('%H'), ('%I'), ('%J'),
	('%V'),  ('A'),  ('B'),  ('C'),  ('D'),  ('E'),  ('F'),  ('G'),
	 ('H'),  ('I'),  ('J'),  ('K'),  ('L'),  ('M'),  ('N'),  ('O'),
	 ('P'),  ('Q'),  ('R'),  ('S'),  ('T'),  ('U'),  ('V'),  ('W'),
	 ('X'),  ('Y'),  ('Z'), ('%K'), ('%L'), ('%M'), ('%N'), ('%O'),
	('%W'), ('+A'), ('+B'), ('+C'), ('+D'), ('+E'), ('+F'), ('+G'),
	('+H'), ('+I'), ('+J'), ('+K'), ('+L'), ('+M'), ('+N'), ('+O'),
	('+P'), ('+Q'), ('+R'), ('+S'), ('+T'), ('+U'), ('+V'), ('+W'),
	('+X'), ('+Y'), ('+Z'), ('%P'), ('%Q'), ('%R'), ('%S'), ('%T')
	);


var
	save: AnsiString;
	i : integer;
        FText: AnsiString;
begin
        FText:=CurrentText;
	save := FText;
	FText := '';

	for i:=1 to Length(save) do
	begin
		if ord(save[i]) <= 127 then
			FText := FText + code39x[ord(save[i])];
	end;
        CurrentText:=FText;
        try
         result := Code_39;
        finally
         CurrentText := save;
        end;
end;



{
Code 128
}
function TRpBarcode.Code_128: AnsiString;
type TCode128 =
	record
		a, b : AnsiChar;
		c : AnsiString;
		data : AnsiString;
	end;

const tabelle_128: array[0..102] of TCode128 = (
	( a:' '; b:' '; c:'00'; data:'212222'; ),
	( a:'!'; b:'!'; c:'01'; data:'222122'; ),
	( a:'"'; b:'"'; c:'02'; data:'222221'; ),
	( a:'#'; b:'#'; c:'03'; data:'121223'; ),
	( a:'$'; b:'$'; c:'04'; data:'121322'; ),
	( a:'%'; b:'%'; c:'05'; data:'131222'; ),
	( a:'&'; b:'&'; c:'06'; data:'122213'; ),
	( a:''''; b:''''; c:'07'; data:'122312'; ),
	( a:'('; b:'('; c:'08'; data:'132212'; ),
	( a:')'; b:')'; c:'09'; data:'221213'; ),
	( a:'*'; b:'*'; c:'10'; data:'221312'; ),
	( a:'+'; b:'+'; c:'11'; data:'231212'; ),
{$IFDEF DOTNETD}
	( a:''''; b:''''; c:'12'; data:'112232'; ),
{$ENDIF}
{$IFNDEF DOTNETD}
	( a:'´'; b:'´'; c:'12'; data:'112232'; ),
{$ENDIF}
	( a:'-'; b:'-'; c:'13'; data:'122132'; ),
	( a:'.'; b:'.'; c:'14'; data:'122231'; ),
	( a:'/'; b:'/'; c:'15'; data:'113222'; ),
	( a:'0'; b:'0'; c:'16'; data:'123122'; ),
	( a:'1'; b:'1'; c:'17'; data:'123221'; ),
	( a:'2'; b:'2'; c:'18'; data:'223211'; ),
	( a:'3'; b:'3'; c:'19'; data:'221132'; ),
	( a:'4'; b:'4'; c:'20'; data:'221231'; ),
	( a:'5'; b:'5'; c:'21'; data:'213212'; ),
	( a:'6'; b:'6'; c:'22'; data:'223112'; ),
	( a:'7'; b:'7'; c:'23'; data:'312131'; ),
	( a:'8'; b:'8'; c:'24'; data:'311222'; ),
	( a:'9'; b:'9'; c:'25'; data:'321122'; ),
	( a:':'; b:':'; c:'26'; data:'321221'; ),
	( a:';'; b:';'; c:'27'; data:'312212'; ),
	( a:'<'; b:'<'; c:'28'; data:'322112'; ),
	( a:'='; b:'='; c:'29'; data:'322211'; ),
	( a:'>'; b:'>'; c:'30'; data:'212123'; ),
	( a:'?'; b:'?'; c:'31'; data:'212321'; ),
	( a:'@'; b:'@'; c:'32'; data:'232121'; ),
	( a:'A'; b:'A'; c:'33'; data:'111323'; ),
	( a:'B'; b:'B'; c:'34'; data:'131123'; ),
	( a:'C'; b:'C'; c:'35'; data:'131321'; ),
	( a:'D'; b:'D'; c:'36'; data:'112313'; ),
	( a:'E'; b:'E'; c:'37'; data:'132113'; ),
	( a:'F'; b:'F'; c:'38'; data:'132311'; ),
	( a:'G'; b:'G'; c:'39'; data:'211313'; ),
	( a:'H'; b:'H'; c:'40'; data:'231113'; ),
	( a:'I'; b:'I'; c:'41'; data:'231311'; ),
	( a:'J'; b:'J'; c:'42'; data:'112133'; ),
	( a:'K'; b:'K'; c:'43'; data:'112331'; ),
	( a:'L'; b:'L'; c:'44'; data:'132131'; ),
	( a:'M'; b:'M'; c:'45'; data:'113123'; ),
	( a:'N'; b:'N'; c:'46'; data:'113321'; ),
	( a:'O'; b:'O'; c:'47'; data:'133121'; ),
	( a:'P'; b:'P'; c:'48'; data:'313121'; ),
	( a:'Q'; b:'Q'; c:'49'; data:'211331'; ),
	( a:'R'; b:'R'; c:'50'; data:'231131'; ),
	( a:'S'; b:'S'; c:'51'; data:'213113'; ),
	( a:'T'; b:'T'; c:'52'; data:'213311'; ),
	( a:'U'; b:'U'; c:'53'; data:'213131'; ),
	( a:'V'; b:'V'; c:'54'; data:'311123'; ),
	( a:'W'; b:'W'; c:'55'; data:'311321'; ),
	( a:'X'; b:'X'; c:'56'; data:'331121'; ),
	( a:'Y'; b:'Y'; c:'57'; data:'312113'; ),
	( a:'Z'; b:'Z'; c:'58'; data:'312311'; ),
	( a:'['; b:'['; c:'59'; data:'332111'; ),
	( a:'\'; b:'\'; c:'60'; data:'314111'; ),
	( a:']'; b:']'; c:'61'; data:'221411'; ),
	( a:'^'; b:'^'; c:'62'; data:'431111'; ),
	( a:'_'; b:'_'; c:'63'; data:'111224'; ),
	( a:' '; b:'`'; c:'64'; data:'111422'; ),
	( a:' '; b:'a'; c:'65'; data:'121124'; ),
	( a:' '; b:'b'; c:'66'; data:'121421'; ),
	( a:' '; b:'c'; c:'67'; data:'141122'; ),
	( a:' '; b:'d'; c:'68'; data:'141221'; ),
	( a:' '; b:'e'; c:'69'; data:'112214'; ),
	( a:' '; b:'f'; c:'70'; data:'112412'; ),
	( a:' '; b:'g'; c:'71'; data:'122114'; ),
	( a:' '; b:'h'; c:'72'; data:'122411'; ),
	( a:' '; b:'i'; c:'73'; data:'142112'; ),
	( a:' '; b:'j'; c:'74'; data:'142211'; ),
	( a:' '; b:'k'; c:'75'; data:'241211'; ),
	( a:' '; b:'l'; c:'76'; data:'221114'; ),
	( a:' '; b:'m'; c:'77'; data:'413111'; ),
	( a:' '; b:'n'; c:'78'; data:'241112'; ),
	( a:' '; b:'o'; c:'79'; data:'134111'; ),
	( a:' '; b:'p'; c:'80'; data:'111242'; ),
	( a:' '; b:'q'; c:'81'; data:'121142'; ),
	( a:' '; b:'r'; c:'82'; data:'121241'; ),
	( a:' '; b:'s'; c:'83'; data:'114212'; ),
	( a:' '; b:'t'; c:'84'; data:'124112'; ),
	( a:' '; b:'u'; c:'85'; data:'124211'; ),
	( a:' '; b:'v'; c:'86'; data:'411212'; ),
	( a:' '; b:'w'; c:'87'; data:'421112'; ),
	( a:' '; b:'x'; c:'88'; data:'421211'; ),
	( a:' '; b:'y'; c:'89'; data:'212141'; ),
	( a:' '; b:'z'; c:'90'; data:'214121'; ),
	( a:' '; b:'{'; c:'91'; data:'412121'; ),
	( a:' '; b:'|'; c:'92'; data:'111143'; ),
	( a:' '; b:'}'; c:'93'; data:'111341'; ),
	( a:' '; b:'~'; c:'94'; data:'131141'; ),
	( a:' '; b:' '; c:'95'; data:'114113'; ),
	( a:' '; b:' '; c:'96'; data:'114311'; ),
	( a:' '; b:' '; c:'97'; data:'411113'; ),
	( a:' '; b:' '; c:'98'; data:'411311'; ),
	( a:' '; b:' '; c:'99'; data:'113141'; ),
	( a:' '; b:' '; c:'  '; data:'114131'; ),
	( a:' '; b:' '; c:'  '; data:'311141'; ),
{$IFDEF DOTNETD}
	( a:'?'; b:'?'; c:'  '; data:'411131'; )
{$ENDIF}
{$IFNDEF DOTNETD}
	( a:'¿'; b:'¿'; c:'  '; data:'411131'; )
{$ENDIF}
	);

StartA = '211412';
StartB = '211214';
StartC = '211232';
Stop   = '2331112';




// find Code 128 Codeset A or B
function Find_Code128AB(c:AnsiChar):integer;
var
	i:integer;
	v:Ansichar;
begin
	for i:=0 to High(tabelle_128) do
	begin
		if FTyp = bcCode128A then
			v := tabelle_128[i].a
		else
			v := tabelle_128[i].b;
		if c = v then
		begin
			result := i;
			exit;
		end;
	end;
	result := -1;
end;

// find Code 128 Codeset A or B
function Find_Code128C(c: AnsiString):integer;
var
 i:integer;
 v: AnsiString;
begin
 for i:=0 to High(tabelle_128) do
 begin
  v:= tabelle_128[i].c;
  if c = v then
  begin
   result := i;
   exit;
  end;
 end;
 result := -1;
end;

function FindNewType(FText: AnsiString;i:integer):TRpBarcodeType;
var
 acopy: AnsiString;
 isalpha:boolean;
 index:integer;
begin
 if FText[i]='¿' then
  inc(i);
 acopy:=Copy(ftext,i,Length(FText));
 index:=Pos('¿',acopy);
 if index>0 then
  acopy:=copy(acopy,1,index-1);
 if (length(acopy) mod 2)<>0 then
 begin
  Result:=bcCode128B;
  exit;
 end;
 isalpha:=false;
 index:=1;
 While index<=Length(acopy) do
 begin
  if Not (acopy[index] in ['0'..'9']) then
  begin
   isalpha:=True;
   break;
  end;
  inc(index);
 end;
 if isalpha then
  Result:=bcCode128B
 else
  Result:=bcCode128C;
end;

var i, idx: integer;
	startcode: AnsiString;
	checksum : integer;
        newtyp:TRpBarcodeType;
//        isalphanum:boolean;
//        isean:boolean;
//        newtext: AnsiString;
        cadc: AnsiString;
//        index,numint:integer;
        FText: AnsiString;

begin
 checksum:=0;
 Result:='';
 i:=1;
 FText:=CurrentText;

 While i<=Length(FText) do
 begin
  // Determine what type of code is
  newTyp:=FTyp;
  if FTyp=bcCode128 then
  begin
   newTyp:=FindNewType(FText,i);
  end;
  case newtyp of
   bcCode128A: begin checksum := 103; startcode:= StartA; end;
   bcCode128B: begin checksum := 104; startcode:= StartB; end;
   bcCode128C: begin checksum := 105; startcode:= StartC; end;
  end;
  if i=1 then
   result := result+Convert(startcode);    // Startcode
//  numint:=0;
  // Look for EAN control
  if FText[i]='¿' then
  begin
   result:=Result+Convert('411131');
   Inc(checksum, 102*i);
   inc(i);
   if i>Length(FText) then
    break;
  end;

  case newtyp of
   bccode128A,bccode128B:
    begin
     While i<=Length(FText) do
     begin
      idx := Find_Code128AB(FText[i]);
      if idx < 0 then
      	idx := Find_Code128AB(' ');
      result := result + Convert(tabelle_128[idx].data);
      Inc(checksum, idx*(i));
      inc(i);
      if Length(FText)>=i then
       if FText[i]='¿' then
       begin
        result:=Result+Convert('411131');
        Inc(checksum, 102*i);
        inc(i);
        break;
       end;
     end;
    end;
   bccode128C:
    begin
     cadc:='';
     While i<=Length(FText) do
     begin
      cadc:=cadc+FText[i];
      if length(cadc)>1 then
      begin
       idx := Find_Code128C(cadc);
       if idx < 0 then
	idx := Find_Code128C('00');
// Fix by Chris Gradussen
// first pair of 2 digits multiply by 1 instead of 2
// second pair of 2 digits multiply by 2 instead of 4...
//       Inc(checksum, (idx*i)); Original line
       Inc(checksum,(idx*(i div 2)));
       result := result + Convert(tabelle_128[idx].data);
       cadc:='';
      end;
      inc(i);
      if Length(FText)>=i then
       if FText[i]='¿' then
       begin
        result:=Result+Convert('411131');
        Inc(checksum, 102*i);
        inc(i);
        break;
       end;
     end;
    end;
  end;
 end;
 checksum := checksum mod 103;
 result := result + Convert(tabelle_128[checksum].data);
 result := result + Convert(Stop);      // Stopcode
        (*
 // Look if it's Code128 it can be optimized
	case newtyp of
		bcCode128A: begin checksum := 103; startcode:= StartA; end;
		bcCode128B: begin checksum := 104; startcode:= StartB; end;
		bcCode128C: begin checksum := 105; startcode:= StartC; end;
	end;

	result := Convert(startcode);    // Startcode

	if newTyp = bcCode128C then
		for i:=1 to Length(FText) div 2 do
		begin
			// not implemented !!!
		end
	else
		for i:=1 to Length(FText) do
		begin
			idx := Find_Code128AB(FText[i]);
			if idx < 0 then
				idx := Find_Code128AB(' ');
			result := result + Convert(tabelle_128[idx].data);
			Inc(checksum, idx*i);
		end;

	checksum := checksum mod 103;
	result := result + Convert(tabelle_128[checksum].data);

 	result := result + Convert(Stop);      // Stopcode
*)end;





function TRpBarcode.Code_93: AnsiString;
type TCode93 =
	record
		c : Ansichar;
		data : array[0..5] of Ansichar;
	end;

const tabelle_93: array[0..46] of TCode93 = (
	( c:'0'; data:'131112'  ),
	( c:'1'; data:'111213'  ),
	( c:'2'; data:'111312'  ),
	( c:'3'; data:'111411'  ),
	( c:'4'; data:'121113'  ),
	( c:'5'; data:'121212'  ),
	( c:'6'; data:'121311'  ),
	( c:'7'; data:'111114'  ),
	( c:'8'; data:'131211'  ),
	( c:'9'; data:'141111'  ),
	( c:'A'; data:'211113'  ),
	( c:'B'; data:'211212'  ),
	( c:'C'; data:'211311'  ),
	( c:'D'; data:'221112'  ),
	( c:'E'; data:'221211'  ),
	( c:'F'; data:'231111'  ),
	( c:'G'; data:'112113'  ),
	( c:'H'; data:'112212'  ),
	( c:'I'; data:'112311'  ),
	( c:'J'; data:'122112'  ),
	( c:'K'; data:'132111'  ),
	( c:'L'; data:'111123'  ),
	( c:'M'; data:'111222'  ),
	( c:'N'; data:'111321'  ),
	( c:'O'; data:'121122'  ),
	( c:'P'; data:'131121'  ),
	( c:'Q'; data:'212112'  ),
	( c:'R'; data:'212211'  ),
	( c:'S'; data:'211122'  ),
	( c:'T'; data:'211221'  ),
	( c:'U'; data:'221121'  ),
	( c:'V'; data:'222111'  ),
	( c:'W'; data:'112122'  ),
	( c:'X'; data:'112221'  ),
	( c:'Y'; data:'122121'  ),
	( c:'Z'; data:'123111'  ),
	( c:'-'; data:'121131'  ),
	( c:'.'; data:'311112'  ),
	( c:' '; data:'311211'  ),
	( c:'$'; data:'321111'  ),
	( c:'/'; data:'112131'  ),
	( c:'+'; data:'113121'  ),
	( c:'%'; data:'211131'  ),
	( c:'['; data:'121221'  ),   // only used for Extended Code 93
	( c:']'; data:'312111'  ),   // only used for Extended Code 93
	( c:'{'; data:'311121'  ),   // only used for Extended Code 93
	( c:'}'; data:'122211'  )    // only used for Extended Code 93
	);


// find Code 93
function Find_Code93(c:AnsiChar):integer;
var
	i:integer;
begin
	for i:=0 to High(tabelle_93) do
	begin
		if c = tabelle_93[i].c then
		begin
			result := i;
			exit;
		end;
	end;
	result := -1;
end;




var
	i, idx : integer;
	checkC, checkK,   // Checksums
	weightC, weightK : integer;
  FText: AnsiString;
begin
        FText:=CurrentText;

	result := Convert('111141');   // Startcode

	for i:=1 to Length(FText) do
	begin
		idx := Find_Code93(FText[i]);
		if idx < 0 then
			raise Exception.CreateFmt('%s:Code93 bad Data <%s>', [self.ClassName,FText]);
		result := result + Convert(tabelle_93[idx].data);
	end;

	checkC := 0;
	checkK := 0;

	weightC := 1;
	weightK := 2;

	for i:=Length(FText) downto 1 do
	begin
		idx := Find_Code93(FText[i]);

		Inc(checkC, idx*weightC);
		Inc(checkK, idx*weightK);

		Inc(weightC);
		if weightC > 20 then weightC := 1;
		Inc(weightK);
		if weightK > 15 then weightC := 1;
	end;

	Inc(checkK, checkC);

	checkC := checkC mod 47;
	checkK := checkK mod 47;

	result := result + Convert(tabelle_93[checkC].data) +
		Convert(tabelle_93[checkK].data);

	result := result + Convert('1111411');   // Stopcode
end;





function TRpBarcode.Code_93Extended: AnsiString;
const code93x : array[0..127] of string[2] =
	(
	(']U'), ('[A'), ('[B'), ('[C'), ('[D'), ('[E'), ('[F'), ('[G'),
	('[H'), ('[I'), ('[J'), ('[K'), ('[L'), ('[M'), ('[N'), ('[O'),
	('[P'), ('[Q'), ('[R'), ('[S'), ('[T'), ('[U'), ('[V'), ('[W'),
	('[X'), ('[Y'), ('[Z'), (']A'), (']B'), (']C'), (']D'), (']E'),
	 (' '), ('{A'), ('{B'), ('{C'), ('{D'), ('{E'), ('{F'), ('{G'),
	('{H'), ('{I'), ('{J'), ('{K'), ('{L'), ('{M'), ('{N'), ('{O'),
	( '0'),  ('1'),  ('2'),  ('3'),  ('4'),  ('5'),  ('6'),  ('7'),
	 ('8'),  ('9'), ('{Z'), (']F'), (']G'), (']H'), (']I'), (']J'),
	(']V'),  ('A'),  ('B'),  ('C'),  ('D'),  ('E'),  ('F'),  ('G'),
	 ('H'),  ('I'),  ('J'),  ('K'),  ('L'),  ('M'),  ('N'),  ('O'),
	 ('P'),  ('Q'),  ('R'),  ('S'),  ('T'),  ('U'),  ('V'),  ('W'),
	 ('X'),  ('Y'),  ('Z'), (']K'), (']L'), (']M'), (']N'), (']O'),
	(']W'), ('}A'), ('}B'), ('}C'), ('}D'), ('}E'), ('}F'), ('}G'),
	('}H'), ('}I'), ('}J'), ('}K'), ('}L'), ('}M'), ('}N'), ('}O'),
	('}P'), ('}Q'), ('}R'), ('}S'), ('}T'), ('}U'), ('}V'), ('}W'),
	('}X'), ('}Y'), ('}Z'), (']P'), (']Q'), (']R'), (']S'), (']T')
	);

var
//	save:array[0..254] of char;
//	old: AnsiString;
	save : AnsiString;
	i : integer;
        FText: AnsiString;
begin
//	CharToOem(PChar(FText), save);
        FText:=CurrentText;



	save := FText;
	FText := '';


	for i:=0 to Length(save)-1 do
	begin
		if ord(save[i]) <= 127 then
			FText := FText + code93x[ord(save[i])];
	end;

//RpShowmessage(Format('Text: <%s>', [FText]));
        CurrentText:=FText;
        try
         result := Code_93;
        finally
         CurrentText := save;
        end;
end;



function TRpBarcode.Code_MSI: AnsiString;
const tabelle_MSI:array['0'..'9'] of string[8] =
	(
	( '51515151' ),    // '0'
	( '51515160' ),    // '1'
	( '51516051' ),    // '2'
	( '51516060' ),    // '3'
	( '51605151' ),    // '4'
	( '51605160' ),    // '5'
	( '51606051' ),    // '6'
	( '51606060' ),    // '7'
	( '60515151' ),    // '8'
	( '60515160' )     // '9'
	);

var
	i:integer;
	check_even, check_odd, checksum:integer;
        FText: AnsiString;
begin
        FText:=CurrentText;
	result := '60';    // Startcode
	check_even := 0;
	check_odd  := 0;

	for i:=1 to Length(FText) do
	begin
		if odd(i-1) then
			check_odd := check_odd*10+ord(FText[i])
		else
			check_even := check_even+ord(FText[i]);

		result := result + tabelle_MSI[TRpDigit(FText[i])];
	end;

	checksum := quersumme(check_odd*2) + check_even;

	checksum := checksum mod 10;
	if checksum > 0 then
		checksum := 10-checksum;

	result := result + tabelle_MSI[TRpDigit(chr(ord('0')+checksum))];

	result := result + '515'; // Stopcode
end;



function TRpBarcode.Code_PostNet: AnsiString;
const tabelle_PostNet:array['0'..'9'] of string[10] =
	(
	( '5151A1A1A1' ),    // '0'
	( 'A1A1A15151' ),    // '1'
	( 'A1A151A151' ),    // '2'
	( 'A1A15151A1' ),    // '3'
	( 'A151A1A151' ),    // '4'
	( 'A151A151A1' ),    // '5'
	( 'A15151A1A1' ),    // '6'
	( '51A1A1A151' ),    // '7'
	( '51A1A151A1' ),    // '8'
	( '51A151A1A1' )     // '9'
	);
var
	i:integer;
        FText: AnsiString;
begin
        FText:=CurrentText;
	result := '51';

	for i:=1 to Length(FText) do
	begin
		result := result + tabelle_PostNet[TRpDigit(FText[i])];
	end;
	result := result + '5';
end;


function TRpBarcode.Code_Codabar: AnsiString;
type TCodabar =
	record
		c : AnsiChar;
		data : array[0..6] of AnsiChar;
	end;

const tabelle_cb: array[0..19] of TCodabar = (
	( c:'1'; data:'5050615'  ),
	( c:'2'; data:'5051506'  ),
	( c:'3'; data:'6150505'  ),
	( c:'4'; data:'5060515'  ),
	( c:'5'; data:'6050515'  ),
	( c:'6'; data:'5150506'  ),
	( c:'7'; data:'5150605'  ),
	( c:'8'; data:'5160505'  ),
	( c:'9'; data:'6051505'  ),
	( c:'0'; data:'5050516'  ),
	( c:'-'; data:'5051605'  ),
	( c:'$'; data:'5061505'  ),
	( c:':'; data:'6050606'  ),
	( c:'/'; data:'6060506'  ),
	( c:'.'; data:'6060605'  ),
	( c:'+'; data:'5060606'  ),
	( c:'A'; data:'5061515'  ),
	( c:'B'; data:'5151506'  ),
	( c:'C'; data:'5051516'  ),
	( c:'D'; data:'5051615'  )
	);



// find Codabar
function Find_Codabar(c:AnsiChar):integer;
var
	i:integer;
begin
	for i:=0 to High(tabelle_cb) do
	begin
		if c = tabelle_cb[i].c then
		begin
			result := i;
			exit;
		end;
	end;
	result := -1;
end;

var
	i, idx : integer;
        FText: AnsiString;
  zstring:AnsiString;
begin
  zstring:='0';
	result := tabelle_cb[Find_Codabar('A')].data + zstring;
        FText:=CurrentText;
	for i:=1 to Length(FText) do
	begin
		idx := Find_Codabar(FText[i]);
		result := result + tabelle_cb[idx].data + zstring;
	end;
	result := result + tabelle_cb[Find_Codabar('B')].data;
end;

procedure TRpBarcode.MakeModules;
begin
	case Typ of
		bcCode_2_5_interleaved,
		bcCode_2_5_industrial,
		bcCode39,
		bcCodeEAN8,
		bcCodeEAN13,
		bcCode39Extended,
		bcCodeCodabar:
		begin
			if Ratio < 2.0 then Ratio := 2.0;
			if Ratio > 3.0 then Ratio := 3.0;
		end;

		bcCode_2_5_matrix:
		begin
			if Ratio < 2.25 then Ratio := 2.25;
			if Ratio > 3.0 then Ratio := 3.0;
		end;
		bcCode128A,
		bcCode128B,
		bcCode128C,bcCode128,
		bcCode93,
		bcCode93Extended,
		bcCodeMSI,
		bcCodePostNet:    ;
	end;


	modules[0] := FModul;
	modules[1] := Round(FModul*FRatio);
	modules[2] := modules[1] * 3 div 2;
	modules[3] := modules[1] * 2;
end;





{
Print the Barcode

Parameter :

data holds the pattern for a Barcode.
A barcode begins always with a black line and
ends with a black line.

The white Lines builds the space between the black Lines.

A black line must always followed by a white Line and vica versa.

Examples:
	'50505'   // 3 thin black Lines with 2 thin white Lines
	'606'     // 2 fat black Lines with 1 thin white Line

	'5605015' // Error


data[] :

			Line-Color      Width               Height
------------------------------------------------------------------
	'0'   white           100%                full
	'1'   white           100%*Ratio          full
	'2'   white           150%*Ratio          full
	'3'   white           200%*Ratio          full
	'5'   black           100%                full
	'6'   black           100%*Ratio          full
	'7'   black           150%*Ratio          full
	'8'   black           200%*Ratio          full
	'A'   black           100%                2/5  (used for PostNet)
	'B'   black           100%*Ratio          2/5  (used for PostNet)
	'C'   black           150%*Ratio          2/5  (used for PostNet)
	'D'   black           200%*Ratio          2/5  (used for PostNet)
}
procedure TRpBarcode.DoLines(data: AnsiString; FLeft,FTop:integer;meta:TRpMetaFileReport);

type
	TLineType = (white, black, black_half);
	// black_half means a black line with 2/5 height (used for PostNet)

var i:integer;
	lt : TLineType;
	xadd:integer;   //
	awidth, aheight:integer;
	a,b,c,d,     // Edges of a line (we need 4 Point because the line
					 // is a recangle
	orgin : TPoint;
	alpha:double;
        PenWidth:integer;
        PenColor:integer;
        BrushColor:integer;
begin
  if typ=bcCodePDF417 then
  begin
   Draw2DBarcode(FLeft,FTop,meta);
   exit;
  end;

	xadd := 0;
	orgin.x := FLeft;
	orgin.y := FTop;
	alpha := Rotation/10*pi / 180.0;

        PenWidth := 0;
        for i:=1 to Length(data) do  // examine the pattern string
	begin
		case data[i] of
			'0': begin awidth := modules[0]; lt := white; end;
			'1': begin awidth := modules[1]; lt := white; end;
			'2': begin awidth := modules[2]; lt := white; end;
			'3': begin awidth := modules[3]; lt := white; end;

			'5': begin awidth := modules[0]; lt := black; end;
			'6': begin awidth := modules[1]; lt := black; end;
			'7': begin awidth := modules[2]; lt := black; end;
			'8': begin awidth := modules[3]; lt := black; end;
			'A': begin awidth := modules[0]; lt := black_half; end;
        		'B': begin awidth := modules[1]; lt := black_half; end;
			'C': begin awidth := modules[2]; lt := black_half; end;
			'D': begin awidth := modules[3]; lt := black_half; end;
               		else
			begin
	        		// something went wrong
				// mistyped pattern table
				raise Exception.Create(SRpWrongBarcodeType+':'+data);
				end;
			end;
			if (lt = black) or (lt = black_half) then
			begin
				PenColor := BColor;
			end
			else
			begin
				PenColor := $FFFFFF;
			end;
			BrushColor := PenColor;

			if lt = black_half then
				aheight := PrintHeight * 2 div 5
			else
				aheight := PrintHeight;





			a.x := xadd;
			a.y := 0;

			b.x := xadd;
			b.y := aheight;

			c.x := xadd+awidth;
			c.y := aheight;

			d.x := xadd+awidth;
			d.y := 0;

			// a,b,c,d builds the rectangle we want to draw


			// rotate the rectangle
			a := Translate2D(Rotate2D(a, alpha), orgin);
			b := Translate2D(Rotate2D(b, alpha), orgin);
			c := Translate2D(Rotate2D(c, alpha), orgin);
			d := Translate2D(Rotate2D(d, alpha), orgin);

			// draw the rectangle
  meta.Pages[meta.CurrentPage].NewDrawObject(a.y,a.x,c.x-a.x,c.y-a.y,
  integer(rpsRectangle),0,BrushColor,0,PenWidth,PenColor);
//			Polygon([a,b,c,d]);


			xadd := xadd + awidth;
  	end;
end;




procedure TRpBarcode.Evaluate;
var
 fevaluator:TRpEvaluator;
begin
 if FUpdated then
  exit;
 try
  fevaluator:=TRpBaseReport(GetReport).Evaluator;
  fevaluator.Expression:=FExpression;
  fevaluator.Evaluate;
  FValue:=fevaluator.EvalResult;
  FUpdated:=true;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SRpSExpression+' '+Name,self,SRpSExpression);
  end;
 end;
end;


function TRpBarcode.GetText:widestring;
var
 expre:WideString;
begin
 expre:=Trim(FExpression);
 if Length(expre)<1 then
 begin
  Result:='';
  exit;
 end;
 Evaluate;
 Result:=FormatVariant(displayformat,FValue,rpParamUnknown,true);
end;

procedure TRpBarcode.SubReportChanged(newstate:TRpReportChanged;newgroup:String='');
begin
 inherited SubReportChanged(newstate,newgroup);
 case newstate of
  rpReportStart:
   begin
    FUpdated:=false;
   end;
  rpDataChange:
   begin
    FUpdated:=false;
   end;
 end;
end;


function TRpBarcode.CalculateBarcode: AnsiString;
var
 data: AnsiString;
begin
 if typ=bcCodePDF417 then
 begin
  GenerateCodewords;
  REsult:=CurrentText;
  exit;
 end;
 // calculate the with of the different lines (modules)
 MakeModules;

 // get the pattern of the barcode
 case Typ of
 	bcCode_2_5_interleaved: data := Code_2_5_interleaved;
 	bcCode_2_5_industrial:  data := Code_2_5_industrial;
 	bcCode_2_5_matrix:      data := Code_2_5_matrix;
 	bcCode39:               data := Code_39;
 	bcCode39Extended:       data := Code_39Extended;
 	bcCode128A,
 	bcCode128B,
 	bcCode128C,bcCode128:					data := Code_128;
 	bcCode93:               data := Code_93;
 	bcCode93Extended:       data := Code_93Extended;
 	bcCodeMSI:              data := Code_MSI;
 	bcCodePostNet:          data := Code_PostNet;
 	bcCodeCodabar:          data := Code_Codabar;
 	bcCodeEAN8:             data := Code_EAN8;
 	bcCodeEAN13:            data := Code_EAN13;
 else
 	raise Exception.Create(SRpWrongBarcodeType);
 end;
 Result:=data;
end;



procedure TRpBarcode.WriteExpression(Writer:TWriter);
begin
 WriteWideString(Writer, FExpression);
end;

procedure TRpBarcode.ReadExpression(Reader:TReader);
begin
 FExpression:=ReadWideString(Reader);
end;

procedure TRpBarcode.DefineProperties(Filer:TFiler);
begin
 inherited;

 Filer.DefineProperty('DisplayFormat',ReadDispFormat,WriteDispFormat,True);
 Filer.DefineProperty('Expression',ReadExpression,WriteExpression,True);
end;


function TRpBarcode.GetRealErrorLevel : Integer;
begin
  if (FECCLevel < 0) then begin
    if FNumCodeWords < 41 then
      Result := 2
    else if FNumCodeWords < 161 then
      Result := 3
    else if FNumCodeWords < 321 then
      Result := 4
    else
      Result := 5;
  end else
    Result := FECCLevel
end;


procedure TRpBarcode.GenerateCodewords;
var
  ErrorLevel        : Integer;
  NumErrorCodewords : Integer;
  XSize             : Integer;
  YSize             : Integer;

begin
  TextToCodewords;

  ErrorLevel := GetRealErrorLevel;

  NumErrorCodewords := Trunc (Power (2, ErrorLevel + 1));

  CalculateSize (XSize, YSize);

  FUsedCodewords := FNumCodewords;
  FUsedECCCodewords := NumErrorCodewords;
  FFreeCodewords := FTotalCodewords - FUsedCodewords;

  { The first codewords is always the length }
  if FNumCodewords +
     (XSize * YSize - FNumCodewords - NumErrorCodewords) < 0 then
    raise Exception.Create (SRpBarcodeCodeTooLarge);
  FCodewords[0] := FNumCodewords +
                  (XSize * YSize - FNumCodewords - NumErrorCodewords);

  if NumErrorCodeWords + FNumCodeWords <= XSize * YSize then
    CalculateECC (XSize * YSize - NumErrorCodeWords, NumErrorCodewords)
  else
    raise Exception.Create (SRpBarcodeCodeTooLarge);
end;

procedure TRpBarcode.TextToCodewords;
var
  i                  : Integer;
  CodeLen            : Integer;
  CurrentMode        : TStDataMode;
  Count              : Integer;
  Code: AnsiString;

const
  TextCompaction     = 900;
  PadCodeword        = 900;
  BinaryCompaction     = 901;
  NumericCompaction     = 902;
begin
  Code:=CurrentText;
  for i := 0 to 2700 do
    FCodewords[i] := PadCodeword;
  FNumCodewords := 1; { There will always be a length codeword }
  i := 1;

  CodeLen := Length (Code);
  if CodeLen = 0 then
    Exit;

  if GoodForNumericCompaction (i, CodeLen, Count) then
  begin
    CurrentMode := dmNumeric;
    AddCodeword (NumericCompaction);
  end
  else
  if GoodForTextCompaction (i, CodeLen, Count) then
  begin
    CurrentMode := dmText
  end
  else
  begin
    CurrentMode := dmBinary;
    AddCodeword (BinaryCompaction);
  end;

  while i < CodeLen do begin
    case CurrentMode of
      dmBinary :
        EncodeBinary (i, CodeLen);
      dmText :
        EncodeText (i, CodeLen);
      dmNumeric :
        EncodeNumeric (i, CodeLen);
    end;

    if GoodForNumericCompaction (i, CodeLen, Count) then
    begin
     if CurrentMode<>dmNumeric then
     begin
      CurrentMode := dmNumeric;
      AddCodeword (NumericCompaction);
     end;
    end
    else
    if GoodForTextCompaction (i, CodeLen, Count) then
    begin
     if CurrentMode<>dmText then
     begin
       AddCodeword (TextCompaction);
       CurrentMode := dmText;
     end;
    end
    else
    begin
     if CurrentMode<>dmBinary then
     begin
      AddCodeword (BinaryCompaction);
      CurrentMode := dmBinary;
     end;
    end;
  end;
end;

procedure TRpBarcode.CalculateSize (var XSize : Integer;
                                          var YSize : Integer);
var
  i                 : Integer;
  NumErrorCodewords : Integer;
  ErrorLevel        : Integer;
  j                 : Integer;
                                            
begin
  { Set the error correction level automatically if needed }
  ErrorLevel := GetRealErrorLevel;

  NumErrorCodewords := Trunc (Power (2, ErrorLevel + 1));

  XSize := NumColumns;
  YSize := NumRows;

  FTotalCodewords := XSize * YSize;

  { Adjust the size if necessary }
  if (NumRows <= 0) or (NumColumns <= 0) then begin
    if NumRows > 0 then begin
      i := 1;
      while i <= 30 do begin
        if i * NumRows - NumErrorCodewords > FNumCodewords then
          Break;
        Inc (i);
      end;
      FTotalCodewords := YSize * 30;
      XSize := i;
    end else if NumColumns > 0 then begin
      i := 3;
      while i <= 90 do begin
        if i * NumColumns - NumErrorCodewords > FNumCodewords then
          Break;
        Inc (i);
      end;
      YSize := i;
      FTotalCodewords := XSize * 90;
    end else begin
      i := 1;
      j := 3;
      while (i * j - NumErrorCodewords < FNumCodewords) do begin
        if j < 90 then
          Inc (j);
        if (i < 30) and (i * j - NumErrorCodewords < FNumCodewords) then
          Inc (i);
        if (j >= 90) and (i >= 30) then
          Break;
      end;
      XSize := i;
      YSize := J;
      FTotalCodewords := 900;
    end;
  end;
end;

procedure TRpBarcode.CalculateECC (NumCodewords:Integer;ECCLen:Integer);
var
  BaseReg  : array [0..800] of DWord;
  CoeffReg : array [0..800] of DWord;
  i        : Integer;
  j        : Integer;
  TInt     : Integer;
  Temp     : DWord;
  Wrap     : DWord;

begin
  if ECClen < 128 then
    for i := 0 to ECCLen - 1 do
      CoeffReg[i] := StMods[ECClen][i]
  else begin
    if ECClen = 128 then
      for i := 0 to ECCLen - 1 do
        CoeffReg[i] := StMods128[i]
    else if ECClen = 256 then
      for i := 0 to ECCLen - 1 do
        CoeffReg[i] := StMods256[i]
    else if ECClen = 512 then
      for i := 0 to ECCLen - 1 do
        CoeffReg[i] := StMods512[i];
  end;

  for i := 0 to ECCLen - 1 do
    BaseReg[i] := 0;

  for i := NumCodewords to NumCodewords + ECCLen - 1 do
    FCodewords[i] := 0;

  for i := 0 to NumCodewords - 1 do begin
    wrap := (BaseReg[ECClen - 1] + FCodewords[i]) mod 929;
    for j := ECCLen - 1 downto 1 do begin
      temp := (CoeffReg[ECClen - 1 - j] * wrap) mod 929;
      temp := (929 - temp) mod 929;
      BaseReg[j] := (BaseReg[j - 1] + temp) mod 929;
    end;
    temp := (CoeffReg[ECClen - 1] * wrap) mod 929;      
    temp := (929 - temp) mod 929;
    BaseReg[0]:= temp;
  end;

  for j := 0 to ECCLen - 1 do
    BaseReg[j] := (929 - BaseReg[j]) mod 929;

  for j := 0 to ECCLen - 1 do begin
    tint := BaseReg[ECClen - 1 - j];
    FCodewords [NumCodewords + j] := tint;
  end;
end;


function TRpBarcode.GoodForNumericCompaction (
                                               Position  : Integer;
                                               CodeLen   : Integer;
                                               var Count : Integer) : Boolean;
var
 code: AnsiString;
const
  BytesNeeded = 13;

begin
  code:=CurrentText;
  Result := False;
  Count := 0;
  while (Position + Count < CodeLen) and
        (Code[Position + Count] >= '0') and
        (Code[Position + Count] <= '9') do
    Inc (Count);
  if Count > BytesNeeded then
    Result := True;
end;

function TRpBarcode.GoodForTextCompaction (
                                             Position  : Integer;
                                             CodeLen   : Integer;
                                             var Count : Integer) : Boolean;

var
 code: AnsiString;
  function IsGoodTextValue (const v : AnsiChar) : Boolean;                 {!!.01}
  begin                                                                {!!.01}
    if v > #127 then                                                   {!!.01}
      Result := False                                                  {!!.01}
    else if TSPDF417TextCompaction[Integer (v)].Value >= 0 then       {!!.01}
      Result := True                                                   {!!.01}
    else                                                               {!!.01}
      Result := False;                                                 {!!.01}
  end;                                                                 {!!.01}

const
  BytesNeeded = 5;

begin
  code:=CurrentText;
  Result := False;
  Count := 0;
  while (Position + Count < CodeLen) and                               {!!.01}
        (IsGoodTextValue (Code[Position + Count])) and                 {!!.01}
        (Count <= BytesNeeded) do                                      {!!.01}
    Inc (Count);
  if (Count > BytesNeeded) or
     ((Position + Count >= CodeLen) and (Count > 0)) then
    Result := True;
  if (Count=1) then
   Result:=false;
end;

procedure TRpBarcode.EncodeBinary (var Position : Integer;
                                         CodeLen      : Integer);

  function CountBytes (Position : Integer; CodeLen : Integer) : Integer;
  var
    Done  : Boolean;
    Dummy : Integer;

  begin
    Result := 0;
    Done := False;
    while not done do begin
//    Bugfix 29 Sept 2004
      if (Result+Position <= CodeLen) and
//      if (Result < CodeLen) and
         (not GoodForNumericCompaction (Position + Result, CodeLen, Dummy)) and
         (not GoodForTextCompaction (Position + Result, CodeLen, Dummy)) then
        Inc (Result)
      else
        Done := True;
    end;
  end;

var
  MultipleOfSix  : Boolean;
  BinaryDataSize : Integer;
  i              : Integer;
  j              : Integer;
  A              : array [0..6] of Integer;
  code: AnsiString;
const
  Even6Bytes = 924;
  Odd6Bytes  = 901;

begin
  code:=CurrentText;
  BinaryDataSize := CountBytes (Position, CodeLen);
  if BinaryDataSize mod 6 = 0 then
    MultipleOfSix := True
  else
    MultipleOfSix := False;
  if MultipleOfSix then
    AddCodeword (Even6Bytes)
  else
    AddCodeword (Odd6Bytes);

  i := 0;
  while i < BinaryDataSize do
    if BinaryDataSize - i < 6 then begin
      AddCodeword (Word (Code[Position + i]));
      Inc (i);
    end else begin
      ConvertBytesToBase900 ([Byte (Code[Position + i]),
                              Byte (Code[Position + i + 1]),
                              Byte (Code[Position + i + 2]),
                              Byte (Code[Position + i + 3]),
                              Byte (Code[Position + i + 4]),
                              Byte (Code[Position + i + 5])], A);
      for j := 1 to 5 do
        AddCodeword (A[j - 1]);                                        {!!.dg}
      Inc (i, 6);
    end;
  Inc (Position, BinaryDataSize);                                      {!!.dg}
end;

procedure TRpBarcode.EncodeNumeric (var Position : Integer;
                                          CodeLen      : Integer);

var
 code: AnsiString;
  function CollectDigits (var Position : Integer;
                          CodeLen      : Integer) : AnsiString;
  var
    StartPos : Integer;

  const
    // Bugfix 27 Sept 2004
    MaxDigitChunk = 38;
//    MaxDigitChunk = 44;
  begin
    Result := '';
    StartPos := Position;
    while (Position <= CodeLen) and (Position - StartPos < MaxDigitChunk) and
          (Code[Position] >= '0') and (Code[Position] <= '9') do begin
      Inc (Position);
    end;
    if Position - StartPos > 0 then
      Result := '1' + Copy (Code, StartPos, Position - StartPos);
  end;

var
  NumericString : AnsiString;
  A             : array [0..MAX_DIGITS_NUM] of Integer;
  LenA          : Integer;
  i             : Integer;


begin
  code:=CurrentTexT;
  repeat
    NumericString := CollectDigits (Position, CodeLen);
    if NumericString <> '' then begin
      ConvertToBase900 (NumericString, A, LenA);
      for i := 0 to LenA-1 do
        AddCodeword (A[i]);
    end;
  until NumericString = '';
end;

procedure TRpBarcode.EncodeText (var Position : Integer;
                                       CodeLen      : Integer);
var
 Code: AnsiString;
  function SelectBestTextMode (
        CurChar : TSPDF417TextCompactionData) : TSPDF417TextCompactionMode;
  begin
    if cmAlpha in CurChar.Mode then
      Result := cmAlpha
    else if cmLower in CurChar.Mode then
      Result := cmLower
    else if cmMixed in CurChar.Mode then
      Result := cmMixed
    else if cmPunctuation in CurChar.Mode then
      Result := cmPunctuation
    else
      Result := cmNone;
  end;

  procedure AddTextCharacter (Value : Word);
  begin
    if FNewTextCodeword then
      FCodewords[FNumCodewords] := 30 * Value
    else begin
      FCodewords[FNumCodewords] := FCodewords[FNumCodewords] + Value;
      Inc (FNumCodewords);
    end;
    FNewTextCodeword := not FNewTextCodeword;
  end;

  function ChangeTextSubmode (CurrentMode : TSPDF417TextCompactionMode;
                              NewMode : TSPDF417TextCompactionMode;
                              UseShift : Boolean) : TSPDF417TextCompactionMode;
  const
    LatchAlphaToLower       = 27;
    LatchAlphaToMixed       = 28;
    ShiftAlphaToPunctuation = 29;
    ShiftLowerToAlpha       = 27;
    LatchLowerToMixed       = 28;
    ShiftLowertoPunctuation = 29;
    LatchMixedToPunctuation = 25;
    LatchMixedToLower       = 27;
    LatchMixedToAlpha       = 28;
    ShiftMixedToPunctuation = 29;
    LatchPunctuationToAlpha = 29;

  begin
    if UseShift then
      Result := CurrentMode
    else
      Result := NewMode;

    case CurrentMode of
      cmAlpha :
        case NewMode of
          cmLower :
            begin
              { Alpha to Lower.  No shift }
              AddTextCharacter (LatchAlphaToLower);
              if UseShift then
                Result := NewMode;
             end;
          cmMixed :
            begin
              { Alpha to Numeric.  No shift }
              AddTextCharacter (LatchAlphaToMixed);
              if UseShift then
                Result := NewMode;
            end;
          cmPunctuation :
            { Alpha to Punctuation }
            if UseShift then
              AddTextCharacter (ShiftAlphaToPunctuation)
            else begin
              AddTextCharacter (LatchAlphaToMixed);
              AddTextCharacter (LatchMixedToPunctuation);
            end;
        end;

      cmLower :
        case NewMode of
          cmAlpha :
            { Lower to Alpha }
            if UseShift then
              AddTextCharacter (ShiftLowerToAlpha)
            else begin
              AddTextCharacter (LatchLowerToMixed);
              AddTextCharacter (LatchMixedToAlpha);
            end;
          cmMixed :
            begin
              { Lower to Mixed.  No shift }
              AddTextCharacter (LatchLowerToMixed);
              if UseShift then
                Result := NewMode;
            end;
          cmPunctuation :
            { Lower to Punctuation }
            if UseShift then
              AddTextCharacter (ShiftLowerToPunctuation)
            else begin
              AddTextCharacter (LatchLowerToMixed);
              AddTextCharacter (LatchMixedToPunctuation);
            end;
        end;

      cmMixed :
        case NewMode of
          cmAlpha :
            begin
              { Mixed to Alpha.  No shift }
              AddTextCharacter (LatchMixedToAlpha);
              if UseShift then
                Result := NewMode;
            end;
          cmLower :
            begin
              { Mixed to Lower.  No shift }
              AddTextCharacter (LatchMixedToLower);
              if UseShift then
                Result := NewMode;
            end;
          cmPunctuation :
            { Mixed to Punctuation }
            if UseShift then
              AddTextCharacter (ShiftMixedToPunctuation)
            else
              AddTextCharacter (LatchMixedToPunctuation);
        end;
      cmPunctuation :
        case NewMode of
          cmAlpha :
            begin
              { Punctuation to Alpha.  No shift }
              AddTextCharacter (LatchPunctuationToAlpha);
              if UseShift then
                Result := NewMode;
            end;
          cmLower :
            begin
              { Punctuation to Lower.  No shift }
              AddTextCharacter (LatchPunctuationToAlpha);
              AddTextCharacter (LatchAlphaToLower);
              if UseShift then
                Result := NewMode;
            end;
          cmMixed :
            begin
              { Punctuation to Mixed.  No shift }
              AddTextCharacter (LatchPunctuationToAlpha);
              AddTextCharacter (LatchAlphaToMixed);
              if UseShift then
                Result := NewMode;
            end;
        end;
    end;
  end;

var
  CurrentTextSubmode : TSPDF417TextCompactionMode;
  CurChar            : TSPDF417TextCompactionData;
  UseShift           : Boolean;
  Done               : Boolean;
  Dummy              : Integer;
  NewChar            : Integer;
  Codeword           : Boolean;
  validtext:boolean;

const
  EndingPadChar      = 29;

begin
  Code:=CurrentText;
  { Initialize and get the first character }
  FNewTextCodeword := True;
  CurrentTextSubmode := cmAlpha;
  Done := False;

  { get characters until it is necessary to step out of text mode }
  while (Position <= CodeLen) and (CurChar.Value >= 0) and
        (not Done) do begin
    if (Position <= CodeLen) then
    begin
      GetNextCharacter (NewChar, Codeword, Position, CodeLen);
      if NewChar>127 then
       validtext:=false
      else
      begin
       validtext:=(TSPDF417TextCompaction[NewChar].Value>=0);
      end;
      if (not validtext) then
      begin
       Position:=Position-2;
       break;
      end
      else
       CurChar := TSPDF417TextCompaction[NewChar];
    end;

    if Codeword then
    begin
      { If the text contains an odd number of letters, follow it with a
        trailing 29 }
      if not FNewTextCodeword then
        AddTextCharacter (EndingPadChar);
      FNewTextCodeword := True;
      { Add the codeword }
      AddCodeword (NewChar)
    end else begin
      { Check if the text submode for the current character is different than
        the current text submode }
      if not (CurrentTextSubmode in CurChar.Mode) then begin
        { if the text submode is different, see if it remains different.  If
          it does, use a latch, otherwise just shift }
        if Position < CodeLen then begin
          if not (CurrentTextSubmode in
             TSPDF417TextCompaction[Integer (Code[Position + 1])].Mode) then
            UseShift := False
          else
            UseShift := True;
        end else
          UseShift := True;

        { Add the shift or latch to the text codewords }
        CurrentTextSubmode := ChangeTextSubmode (CurrentTextSubmode,
                                                 SelectBestTextMode (CurChar),
                                                 UseShift);
      end;

      { Add the character to the codeword array }
      AddTextCharacter (CurChar.Value);
    end;
    { If this is a digit and it looks like a good time to switch to
      numeric mode, do so }
    if GoodForNumericCompaction (Position, CodeLen, Dummy) then
      Done := True;
  end;

  { If the text contains an odd number of letters, follow it with a
    trailing 29 }
  if not FNewTextCodeword then
    AddTextCharacter (EndingPadChar);
end;

procedure TRpBarcode.AddCodeword (Value : Word);
begin
  FCodewords[FNumCodewords] := Value;
  Inc (FNumCodewords);
end;

procedure TRpBarcode.ConvertBytesToBase900 (const S : array of Byte;
                                                  var A   : array of Integer);
var
  i        : Integer;
  D        : array [0..5] of Byte;
  Dividend : Integer;
  Digits   : array [0..4] of Integer;
  SP       : Integer;

begin
//  Assert(length(S) = 6,
//    'ConvertBytesToBase900: there should be 6 bytes in the input byte array');
//  Assert(length(A) = 5,
//    'ConvertBytesToBase900: there should be 5 elements in the output digit array');

  {copy the array of bytes}
  for i := 0 to 5 do
    D[i] := S[i];

  {loop until the entire base 256 value has been converted to an array
   of base 900 digits (6 base 256 digits will convert to 5 base 900
   digits)}
  SP := 0;
  while (SP < 5) do begin
    Dividend := 0;
    for i := 0 to 5 do begin
     {notes: at the start of the loop, Dividend will always be in the
               range 0..899--it starts out as zero and the final
               statement in the loop forces it into that range
             the first calculation sets Dividend to 0..230399
             the second calc sets D[i] to 0..255 (with no possibility
               of overflow)
             the third calc sets Dividend to 0..899 again}
      Dividend := (Dividend shl 8) + D[i];
      D[i] := Dividend div 900;
      Dividend := Dividend mod 900;
    end;

    Digits[SP] := Dividend;
    inc(SP);
  end;

  {pop the base 900 digits and enter them into the array of integers}
  i := 0;
  while (SP > 0) do begin
    dec(SP);
    A[i] := Digits[SP];
    inc(i);
  end;
end;

procedure TRpBarcode.ConvertToBase900 (const S  : AnsiString;
                                             var A    : array of Integer;
                                             var LenA : Integer);
var
  D          : AnsiString;
  i          : Integer;
  LenD       : Integer;
  Dividend   : Integer;
  Rem        : Integer;
  Done       : Boolean;
  FirstDigit : Integer;
  Digits     : array [0..MAX_DIGITS_NUM] of Integer;
                             // 15 base 900 digits = 45 base 10 digits
  SP         : Integer;
  
begin
  {Assert: S must be non-empty
           it must contain just the ASCII characters '0' to '9' (so no
             leading/trailing spaces either)
           it must have a maximum length of 45}
  Assert(IsNumericString(S), 'ConvertToBase900: S should be a numeric string');

  {grab the string and calculate its length}
  D := S;
  LenD := length(D);

  {convert the string from ASCII characters into binary digits and in
   the process calculate the first non-zero digit}
  FirstDigit := 0;
  for i := LenD downto 1 do begin
    D[i] := Ansichar(ord(D[i]) - ord('0'));
    if (D[i] <> #0) then
      FirstDigit := i;
  end;

  {if the input string comprises just zero digits, return}
  if (FirstDigit = 0) then begin
    LenA := 0;
    Exit;
  end;

  {prepare the stack of base 900 digits}
  SP := 0;

  {loop until the entire base 10 string has been converted to an array
   of base 900 digits}
  Done := false;
  while not Done do begin

    {if we can switch to using standard integer arithmetic, do so}
    if ((LenD - FirstDigit) <= 8) then begin

      {convert the remaining digits to a binary integer}
      Dividend := 0;
      for i := FirstDigit to LenD do
        Dividend := (Dividend * 10) + ord(D[i]);

      {calculate the remaining base 900 digits using the standard
       radix conversion algorithm; push onto the digit stack}
      while (Dividend <> 0) do begin
        Digits[SP] := Dividend mod 900;
        inc(SP);
        Dividend := Dividend div 900;
      end;

      {we've finished}
      Done := true;
    end

    {otherwise operate directly on the base 10 string}
    else begin

      {calculate the remainder base 100}
      Rem := ord(D[LenD]);
      dec(LenD);
      Rem := Rem + (ord(D[LenD]) * 10);
      dec(LenD);

      {calculate the quotient and remainder of the remaining digits,
       dividing by 9}
      Dividend := 0;
      for i := FirstDigit to LenD do begin
        Dividend := (Dividend * 10) + ord(D[i]);
        D[i] := Ansichar(Dividend div 9);
        Dividend := Dividend mod 9;
      end;

      {push the base 900 digit onto the stack: it's the remainder base
       9 multiplied by 100, plus the remainder base 100}
      Digits[SP] := (Dividend * 100) + Rem;
      inc(SP);

      {if the first digit is now zero, advance the index to the first
       non-zero digit}
      if (D[FirstDigit] = '0') then
        inc(FirstDigit);
    end;
  end;

  {pop the base 900 digits and enter them into the array of integers}
  i := 0;
  while (SP > 0) do begin
    dec(SP);
    A[i] := Digits[SP];
    inc(i);
  end;
  LenA := i;
end;

procedure TRpBarcode.GetNextCharacter (var NewChar  : Integer;
                                             var Codeword : Boolean;
                                             var Position : Integer;
                                             CodeLen      : Integer);
var
  WorkNum : Integer;
  FCode: AnsiString;
begin
  FCode:=CurrentText;
  NewChar := 0;
  Codeword := False;

  if Position <= CodeLen then begin
    if (FCode[Position] = '\') and
       (Position < CodeLen) then begin 
      case FCode[Position + 1] of
        '0'..'9' : begin
          try
            NewChar := StrToInt (Copy (FCode, Position + 1, 3));
            Inc (Position, 4);
          except
            NewChar := 0;
            Inc (Position, 4);
          end;
        end;
        'C', 'c' : begin
          try
            Codeword := True;
            NewChar := StrToInt (Copy (FCode, Position + 2, 3));
            Inc (Position, 5);
          except
            NewChar := 0;
            Inc (Position, 5);
          end;
        end;
        'G', 'g' : begin
          WorkNum := StrToInt (Copy (FCode, Position + 1, 6));
          Inc (Position, 8);
          if (WorkNum >= 0) and (WorkNum <= 899) then begin
            AddCodeword (927);
            Codeword := True;
            NewChar := WorkNum;
          end else if (WorkNum >= 900) and (WorkNum < 810900) then begin
            AddCodeword (926);
            AddCodeword ((WorkNum div 900) - 1);
            Codeword := True;
            NewChar := WorkNum mod 900;
          end else if (WorkNum >= 810900) and (WorkNum < 811800) then begin
            AddCodeword (925);
            Codeword := True;
            NewChar := WorkNum;
          end else
            raise Exception.Create (SRpGLIOutOfRangeBarcode);
        end;
        'X', 'x' : begin
          try
            NewChar := StrToInt ('$' + Copy (FCode, Position + 2, 2));
            Inc (Position, 4);
          except
            NewChar := 0;
            Inc (Position, 4);
          end;
        end;
        '\' : begin
          NewChar := Byte (FCode[Position]);
          Inc (Position, 2);
        end;
        else begin
          NewChar := Byte (FCode[Position]);
          Inc (Position);
        end;
      end;   
    end else begin
      NewChar := Byte (FCode[Position]);
      Inc (Position);
    end;
  end;
end;

function TRpBarcode.IsNumericString (const S : AnsiString) : boolean;
var
  i      : integer;
  LenS : integer;

begin
  {note: an assertion test for ConvertToBase900}
  Result := false;
  LenS := length(S);
  if (LenS = 0) or (LenS > 45) then
    Exit;
  for i := 1 to LenS do
    if not (('0' <= S[i]) and (S[i] <= '9')) then
      Exit;
  Result := true;
end;


procedure TRpBarCode.DoPrint(adriver:TRpPrintDriver;
    aposx,aposy,newwidth,newheight:integer;metafile:TRpMetafileReport;
    MaxExtent:TPoint;var PartialPrint:Boolean);
var
 data: AnsiString;
begin
 inherited DoPrint(adriver,aposx,aposy,newwidth,newheight,metafile,MaxExtent,PartialPrint);
 CurrentText:=GetText;
 try
  data:=Calculatebarcode;
 except
  on E:Exception do
  begin
   Raise TRpReportException.Create(E.Message+':'+SrpSCalculatingBarcode+' '+Name,self,SRpSBarcode);
  end;
 end;
 // Draws Barcode
//RpShowmessage(Format('Data <%s>', [data]));
 DoLines(data, aposx,aposy,metafile);    // draw the barcode

end;

procedure TRpBarcode.DrawStartPattern (RowNumber     : Integer;
                                             WorkBarHeight : Integer);
begin
  DrawCodeword (RowNumber, 0, WorkBarHeight, '81111113');
end;

procedure TRpBarcode.DrawStopPattern (RowNumber     : Integer;
                                            ColNumber     : Integer;
                                            WorkBarHeight : Integer);
begin
  if Truncated then
    DrawCodeWord (RowNumber, ColNumber, WorkBarHeight, '1')
  else
    DrawCodeWord (RowNumber, ColNumber, WorkBarHeight, '711311121');
end;

procedure TRpBarcode.DrawLeftRowIndicator (RowNumber     : Integer;
                                                 WorkBarHeight : Integer;
                                                 NumRows       : Integer;
                                                 NumCols       : Integer);
var
  CodeWord   : Integer;
  ErrorLevel : Integer;

begin
  ErrorLevel := GetRealErrorLevel;
  CodeWord := 0;
  if RowNumber mod 3 = 0 then
    CodeWord := ((RowNumber div 3) * 30) + ((NumRows - 1) div 3)
  else if RowNumber mod 3 = 1 then
    CodeWord := ((RowNumber div 3) * 30) + ((NumRows - 1) mod 3) +
                 (3 * ErrorLevel)
  else if RowNumber mod 3 = 2 then
    CodeWord := (( RowNumber div 3) * 30) + (NumCols - 1);
  DrawCodeWordBitmask (RowNumber, 1, WorkBarHeight,
                       CodewordToBitmask (RowNumber, Codeword));
end;

procedure TRpBarcode.DrawRightRowIndicator (RowNumber     : Integer;
                                                  ColNumber     : Integer;
                                                  WorkBarHeight : Integer;
                                                  NumRows       : Integer;
                                                  NumCols       : Integer);
var
  Codeword   : Integer;
  ErrorLevel : Integer;
  
begin
  ErrorLevel := GetRealErrorLevel;
  CodeWord := 0;
  if RowNumber mod 3 = 0 then
    Codeword := ((RowNumber div 3) * 30) + (NumCols - 1)
  else if RowNumber mod 3 = 1 then
    Codeword := ((RowNumber div 3) * 30) + ((NumRows - 1) div 3)
  else if RowNumber mod 3 = 2 then
    Codeword := ((RowNumber div 3) * 30) + ((NumRows - 1) mod 3) +
                (3 * ErrorLevel);
  DrawCodeWordBitmask (RowNumber, ColNumber, WorkBarHeight,
                       CodewordToBitmask (RowNumber, Codeword));
end;



procedure TRpBarcode.Draw2DBarcode(FLeft,FTop:integer;meta:TRpMetaFileReport);
var
  XSize             : Integer;
  YSize             : Integer;
  i                 : Integer;
  j                 : Integer;
  WorkBarHeight     : Integer;
  CodewordPos       : Integer;
  ErrorLevel        : Integer;
  NumErrorCodewords : Integer;

const
  SymbolPadding = 900;

begin
  FPDFLeft:=FLeft;
  FPDFTop:=FTop;
  FPDFMeta:=meta;
  { Set the error correction level automatically if needed }
  ErrorLevel := GetRealErrorLevel;

  NumErrorCodewords := Trunc (Power (2, ErrorLevel + 1));

  CalculateSize (XSize, YSize);

  { The first codewords is always the length }
  if FNumCodewords +
     (XSize * YSize - FNumCodewords - NumErrorCodewords) < 0 then
    raise Exception.Create (SRpBarcodeCodeTooLarge);
  FCodewords[0] := FNumCodewords +
                  (XSize * YSize - FNumCodewords - NumErrorCodewords);

  CodewordPos := 1; { The first codeword is always the length }

//  WorkBarHeight := (BarCodeRect.Bottom - BarCodeRect.Top) div YSize;
  WorkBarHeight := (Height) div YSize;

  for i := 0 to YSize - 1 do begin
//    if FHighlight then
//      FBitmap.Canvas.Brush.Color := $ffbbff;
    DrawStartPattern (i, WorkBarHeight);
//    if FHighlight then
//      FBitmap.Canvas.Brush.Color := $ffffbb;
    DrawLeftRowIndicator (i, WorkBarHeight, YSize, XSize);
    for j := 0 to XSize - 1 do begin
      if (i = 0) and (j = 0) then begin
//        if FHighlight then
//          FBitmap.Canvas.Brush.Color := $bbffff;
        { Length }
        DrawCodeWordBitmask (i, j + 2, WorkBarHeight,
                             CodeWordToBitmask (i, FNumCodewords +
                      (XSize * YSize - FNumCodewords - NumErrorCodewords)))
      end else if CodewordPos < FNumCodewords then begin
//        if FHighlight then
//          FBitmap.Canvas.Brush.Color := $bbbbff;
        { Data }
        DrawCodeWordBitmask (i, j + 2, WorkBarHeight,
                             CodewordToBitmask (i, FCodewords[CodewordPos]));
        Inc (CodewordPos);
      end else if CodewordPos >= XSize * YSize - NumErrorCodeWords then begin
//        if FHighlight then
//          FBitmap.Canvas.Brush.Color := $ffbbbb;
        { Error Correction Codes }
        DrawCodeWordBitmask (i, j + 2, WorkBarHeight,
                             CodewordToBitmask (i, FCodewords[CodewordPos]));
        Inc (CodewordPos);
      end else begin
//        if FHighlight then
//          FBitmap.Canvas.Brush.Color := $bbffbb;
        { Padding }
        DrawCodewordBitmask (i, j + 2, WorkBarHeight,
                             CodewordToBitmask (i, SymbolPadding));
        Inc (CodewordPos);
      end;
    end;
//    if FHighlight then
//      FBitmap.Canvas.Brush.Color := $bbddff;
    if Truncated then
      DrawStopPattern (i, XSize + 2, WorkBarHeight)
    else begin
      DrawRightRowIndicator (i, XSize + 2, WorkBarHeight, YSize, XSize);
//      if FHighlight then
//        FBitmap.Canvas.Brush.Color := $ddaaff;
      DrawStopPattern (i, XSize + 3, WorkBarHeight);
    end;
  end;
end;

procedure TRpBarcode.DrawCodeword (RowNumber     : Integer;
                                         ColNumber     : Integer;
                                         WorkBarHeight : Integer;
                                         Pattern       : AnsiString);

  function GetColumnPosition (ColNumber : Integer) : Integer;
  begin
    Result := ColNumber * SPDF417CellWidth * Modul;
  end;

var
  i         : Integer;
  CurPos    : Integer;
  NewPos    : Integer;
  DrawBlock : Boolean;
  aleft,atop,awidth,aheight:integer;
  a,b,c,d,orgin:TPoint;
  alpha:double;
begin
//  if FHighlight then begin
//    FBitmap.Canvas.FillRect (
//        Rect (BarCodeRect.Left + (GetColumnPosition (ColNumber)),
//              BarCodeRect.Top + RowNumber * WorkBarHeight,
//              BarCodeRect.Left + 17 * BarWidth + GetColumnPosition (ColNumber),
//              BarCodeRect.Top + (RowNumber + 1) * WorkBarHeight));
//    FBitmap.Canvas.Brush.Color := Color;
//  end;

  orgin.x := FPDFLeft;
  orgin.y := FPDFTop;
  alpha := Rotation/10*pi / 180.0;

  CurPos := 0;
  DrawBlock := True;
  for i := 1 to Length (Pattern) do begin
    NewPos := StrToInt (Copy (Pattern, i, 1)) * Modul;
    if DrawBlock then
    begin
     aleft:=CurPos + GetColumnPosition (ColNumber);
     atop:=RowNumber * WorkBarHeight;
//     awidth:=CurPos + NewPos + GetColumnPosition (ColNumber);
     awidth:=NewPos;
     aheight:=WorkBarHeight+1;

     a.y:=atop;
     a.x:=aleft;
     c.x:=aleft+awidth;
     c.y:=atop+aheight;
     b.x:=aleft+awidth;
     b.y:=atop;
     d.x:=aleft;
     d.y:=atop+aheight;

     a := Translate2D(Rotate2D(a, alpha), orgin);
     b := Translate2D(Rotate2D(b, alpha), orgin);
     c := Translate2D(Rotate2D(c, alpha), orgin);
     d := Translate2D(Rotate2D(d, alpha), orgin);

     FPDFmeta.Pages[FPDFmeta.CurrentPage].NewDrawObject(a.y,a.x,c.x-a.x,c.y-a.y,
       integer(rpsRectangle),0,BColor,0,0,BColor);


//     FPDFmeta.Pages[FPDFMeta.CurrentPage].NewDrawObject(
//     atop,aleft,awidth,aheight,
//     integer(rpsRectangle),0,BColor,0,0,BColor);
    end;
//      FBitmap.Canvas.Rectangle (
//          BarCodeRect.Left + CurPos + GetColumnPosition (ColNumber),
//          BarCodeRect.Top + RowNumber * WorkBarHeight,
//          BarCodeRect.Left + CurPos + NewPos + GetColumnPosition (ColNumber),
//          BarCodeRect.Top + (RowNumber + 1) * WorkBarHeight);
    CurPos := CurPos + NewPos;
    DrawBlock := not DrawBlock;
  end;
end;

procedure TRpBarcode.DrawCodewordBitmask (RowNumber     : Integer;
                                                ColNumber     : Integer;
                                                WorkBarHeight : Integer;
                                                Bitmask       : DWord);

  function GetColumnPosition (ColNumber : Integer) : Integer;
  begin
    Result := ColNumber * SPDF417CellWidth * Modul;
  end;

var
  i : Integer;
  aleft,atop,awidth,aheight:integer;
  a,b,c,d,orgin:TPoint;
  alpha:double;
begin
//  if FHighlight then begin
//    FBitmap.Canvas.FillRect (
//        Rect (BarCodeRect.Left + (GetColumnPosition (ColNumber)),
//              BarCodeRect.Top + RowNumber * WorkBarHeight,
//              BarCodeRect.Left + 17 * BarWidth + GetColumnPosition (ColNumber),
//              BarCodeRect.Top + (RowNumber + 1) * WorkBarHeight));
 //   FBitmap.Canvas.Brush.Color := Color;
//  end;

  orgin.x := FPDFLeft;
  orgin.y := FPDFTop;
  alpha := Rotation/10*pi / 180.0;

			// draw the rectangle


  for i := 16 downto 0 do
    if ((BitMask shr i) and $00001) <> 0 then
    begin
     aleft:=(16 - i) * Modul + GetColumnPosition (ColNumber);
     atop:=RowNumber * WorkBarHeight;
//     awidth:=(17 - i) * Modul +GetColumnPosition (ColNumber);
     awidth:=Modul;
     aheight:=WorkBarHeight+1;
//     FPDFmeta.Pages[FPDFMeta.CurrentPage].NewDrawObject(
//      atop,aleft,awidth,aheight,
//     integer(rpsRectangle),0,BColor,0,0,BColor);
     a.y:=atop;
     a.x:=aleft;
     c.x:=aleft+awidth;
     c.y:=atop+aheight;
     b.x:=aleft+awidth;
     b.y:=atop;
     d.x:=aleft;
     d.y:=atop+aheight;

     a := Translate2D(Rotate2D(a, alpha), orgin);
     b := Translate2D(Rotate2D(b, alpha), orgin);
     c := Translate2D(Rotate2D(c, alpha), orgin);
     d := Translate2D(Rotate2D(d, alpha), orgin);

     FPDFmeta.Pages[FPDFmeta.CurrentPage].NewDrawObject(a.y,a.x,c.x-a.x,c.y-a.y,
       integer(rpsRectangle),0,BColor,0,0,BColor);

//      FBitmap.Canvas.Rectangle (
//          BarCodeRect.Left + (16 - i) * BarWidth +
//          GetColumnPosition (ColNumber),
//          BarCodeRect.Top + RowNumber * WorkBarHeight,
//          BarCodeRect.Left + (17 - i) * BarWidth +
//          GetColumnPosition (ColNumber),
//          BarCodeRect.Top + (RowNumber + 1) * WorkBarHeight);
    end;
end;

function TRpBarcode.CodewordToBitmask (RowNumber : Integer;
                                             Codeword  : Integer) : DWord;
begin
  if (Codeword < 0) or (CodeWord > 929) then
    raise Exception.Create (SRpInvalidCodeword);
  Result := SPDF417Codewords[RowNumber mod 3][Codeword];
end;

procedure TRpBarcode.SetECCLevel(NValue:Integer);
begin
 if NValue>8 then
  NValue:=8;
 if NValue<-1 then
  NValue:=-1;
 FECCLEvel:=NValue;
end;


function StringECCToInteger(value: AnsiString):Integer;
begin
 if value='Auto' then
  Result:=-1
 else
  Result:=StrToInt(value[6]);
end;

function ECCToString(value:integer): AnsiString;
begin
 Result:='Auto';
 if (value in [0..8]) then
  Result:='Level'+IntToStr(value);
end;

procedure FillECCValues(alist:TRpWideStrings);
var
 i:integer;
begin
 alist.clear;
 alist.Add('Auto');
 for i:=0 to 8 do
 begin
  alist.Add('Level'+IntToStr(i));
 end;
end;

end.
