{*******************************************************}
{                                                       }
{       Rpwriter                                         }
{       Utilities to write, read convert reports        }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpwriter;

interface

{$I rpconf.inc}

uses Classes,
{$IFDEF USEZLIB}
{$IFDEF DELPHI2009UP}
 zlib,
{$ENDIF}
{$IFNDEF DELPHI2009UP}
 rpmzlib,
{$ENDIF}
{$ENDIF}
SysUtils,rptypes;


procedure FileReportToPlainText (reportfile,plainfile:string);
procedure PlainTextToFileReport (plainfile,reportfile:string);

implementation

procedure FileReportToPlainText(reportfile,plainfile:string);
var
 deststream:TStream;
 stream,astream:TMemoryStream;
{$IFDEF USEZLIB}
 memstream:TMemoryStream;
 zlibs:TDeCompressionStream;
 buf:pointer;
 readed:LongInt;
{$ENDIF}
 theformat:integer;
 firstchar:char;
begin
 stream:=TMemoryStream.Create;
 try
  if Length(reportfile)>0 then
   stream.LoadFromFile(reportfile)
  else
  begin
   stream.free;
   stream:=nil;
   stream:=ReadFromStdInputStream;
  end;
  stream.Seek(0,soFromBeginning);
  // Looks stream type
  if (stream.size<1) then
   Raise Exception.Create('Invalid stream format');
  firstchar:=PChar(stream.memory)^;
  if firstchar='x' then
   theformat:=0
  else
   if firstchar='o' then
    theformat:=1
   else
    theformat:=2;
{$IFNDEF USEZLIB}
  if theformat=0 then
   Raise Exception.Create('ZLib not supported');
{$ENDIF}
{$IFDEF USEZLIB}
  if theformat=0 then
  begin
   memstream:=TMemoryStream.Create;
   try
    zlibs:=TDeCompressionStream.Create(Stream);
    try
     buf:=AllocMem(120000);
     try
      repeat
       readed:=zlibs.Read(buf^,120000);
       memstream.Write(buf^,readed);
      until readed<120000;
     finally
      freemem(buf);
     end;
     memstream.Seek(0,soFrombeginning);
     if Length(plainfile)>0 then
      deststream:=TFileStream.Create(plainfile,fmCreate)
     else
      deststream:=TMemoryStream.Create;
     try
      ObjectBinaryToText(memstream,deststream);
      if Length(plainfile)<1 then
      begin
       deststream.Seek(0,soFromBeginning);
       WriteStreamToStdOutput(deststream);
      end;
     finally
      deststream.Free;
     end;
    finally
     zlibs.free;
    end;
   finally
    memstream.free;
   end;
  end
  else
{$ENDIF}
  if theformat=1 then
  begin
   if Length(plainfile)>0 then
   begin
    deststream:=TFileStream.Create(plainfile,fmCreate);
    try
     stream.SaveToStream(deststream);
    finally
     deststream.Free;
    end;
   end
   else
    WriteStreamToStdOutput(stream);
  end
  else
  begin
   astream:=TMemoryStream.Create;
   try
    ObjectBinaryToText(stream,astream);
    astream.Seek(0,soFromBeginning);
    if Length(plainfile)>0 then
    begin
     astream.SaveToFile(plainfile);
    end
    else
    begin
     WriteStreamToStdOutput(astream);
    end;
   finally
    astream.Free;
   end;
  end;
 finally
  stream.free;
 end;
end;

procedure PlainTextToFileReport(plainfile,reportfile:string);
var
 sourcestream,deststream:TStream;
{$IFDEF USEZLIB}
 zstream:TCompressionStream;
{$ENDIF}
begin
 if Length(plainfile)>0 then
  sourcestream:=TFileStream.Create(plainfile,fmOpenRead or fmShareDenyWrite)
 else
 begin
  sourcestream:=ReadFromStdInputStream;
 end;
 try
  if Length(reportfile)>0 then
   deststream:=TFileStream.Create(reportfile,fmCreate)
  else
   deststream:=TMemoryStream.Create;
  try
{$IFDEF USEZLIB}
   zstream:=TCompressionStream.Create(clDefault,deststream);
   try
    ObjectTextToBinary(sourcestream,zstream);
   finally
    zstream.free;
   end;
{$ENDIF}
{$IFNDEF USEZLIB}
   ObjectTextToBinary(sourcestream,deststream);
{$ENDIF}
   if Length(reportfile)<1 then
   Begin
    deststream.Seek(0,soFromBeginning);
    WriteStreamToStdOutput(deststream);
   end;
  finally
   deststream.Free;
  end;
 finally
  sourcestream.free;
 end;
end;

end.
