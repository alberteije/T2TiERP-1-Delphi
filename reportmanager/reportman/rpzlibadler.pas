{*******************************************************}
{                                                       }
{       Zlib compression library                        }
{                                                       }
{*******************************************************}


unit rpzlibadler;


interface

{$I zconf.inc}

uses
  rpzlibzutil;

function adler32(adler : uLong; buf : pBytef; len : uInt) : uLong;

{    Update a running Adler-32 checksum with the bytes buf[0..len-1] and
   return the updated checksum. If buf is NIL, this function returns
   the required initial value for the checksum.
   An Adler-32 checksum is almost as reliable as a CRC32 but can be computed
   much faster. Usage example:

   var
     adler : uLong;
   begin
     adler := adler32(0, Z_NULL, 0);

     while (read_buffer(buffer, length) <> EOF) do
       adler := adler32(adler, buffer, length);

     if (adler <> original_adler) then
       error();
   end;
}

implementation

const
  BASE = uLong(65521); { largest prime smaller than 65536 }
  {NMAX = 5552; original code with unsigned 32 bit integer }
  { NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1 }
  NMAX = 3854;        { code with signed 32 bit integer }
  { NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^31-1 }
  { The penalty is the time loss in the extra MOD-calls. }


{ ========================================================================= }

function adler32(adler : uLong; buf : pBytef; len : uInt) : uLong;
var
  s1, s2 : uLong;
  k : inti;
begin
  s1 := adler and $ffff;
  s2 := (adler shr 16) and $ffff;

  if not Assigned(buf) then
  begin
    adler32 := uLong(1);
    exit;
  end;

  while (len > 0) do
  begin
    if len < NMAX then
      k := len
    else
      k := NMAX;
    Dec(len, k);
    while (k > 0) do
    begin
      Inc(s1, buf^);
      Inc(s2, s1);
      Inc(buf);
      Dec(k);
    end;
    s1 := s1 mod BASE;
    s2 := s2 mod BASE;
  end;
  adler32 := (s2 shl 16) or s1;
end;

end.

