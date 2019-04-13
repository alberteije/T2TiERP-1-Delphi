{*******************************************************}
{                                                       }
{       Report Manager Server                           }
{                                                       }
{       Report server console application               }
{                                                       }
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

program reportservercon;

{$APPTYPE CONSOLE}


uses
  SysUtils,
{$IFDEF MSWINDOWS}
  midaslib,
{$ENDIF}
  urepserver in 'urepserver.pas' {modserver: TDataModule};

type
 TRpLogObject=class(TObject)
 private
  procedure OnLog(Sender:TObject;aMessage:WideString);
 public
 end;

 procedure TRpLogObject.OnLog(Sender:TObject;aMessage:WideString);
 begin
  Writeln(aMessage);
 end;


var
 amod:TModServer;
 logobject:TRpLogObject;
begin
  IsMultiThread:=True;
  { TODO -oUser -cConsole Main : Insert code here }
  logobject:=TRpLogObject.Create;
  try
   amod:=StartServer(logobject.OnLog);
   try
    while true do
    begin
     sleep(5000);
//    WriteLn('Server Running');
    end;
   finally
    StopServer(amod);
   end;
  finally
   logobject.free;
  end;
end.
