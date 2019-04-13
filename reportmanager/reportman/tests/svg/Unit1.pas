unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  rpmetafile,rptypes,rpsvgdriver,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
 meta:TRpMetafileReport;
 memstream:TMemoryStream;
begin
 meta:=TRpMetafileReport.Create(Application);
 try
  meta.LoadFromFile('c:\test2.rpmf');
  memstream:=TMemoryStream.Create;
  try
   rpsvgdriver.MetafilePageToSVG(meta,0,memstream,'Test','c:\copia\test.svg');
   memstream.Seek(0,soFrombeginning);
   memstream.SaveToFile('c:\copia\test.svg');
  finally
   memstream.free;
  end;
 finally
  meta.free;
 end;
end;

end.
