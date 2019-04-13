program sample;

{$APPTYPE CONSOLE}

uses
  SysUtils,Unit2 in 'Unit2.pas' {datamod: TDataModule};

{$R *.res}

var
 datamod:Tdatamod;
begin
  try
   datamod:=Tdatamod.Create(nil);
   try
    datamod.PDFReport1.Execute;
   finally
    datamod.free;
   end;
  except
   on E:Exception do
   begin
    WriteLn('Error: '+E.Message);
   end;
  end;
end.
