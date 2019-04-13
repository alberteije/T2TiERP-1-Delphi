unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  rpreportmanapi, StdCtrls;

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
 index:integer;
 aresult:integer;
begin
 // Gets
 index:=rp_open('c:\prog\toni\cvsroot\reportman\reportman\repman\repsamples\sample2.rep');
 if index=0 then
  Raise Exception.Create(rp_lasterror);
 showmessage(intToStr(index));
 aresult:=rp_preview(index,'Hello');
 if aresult=0 then
  Raise Exception.Create(rp_lasterror);
// aresult:=rp_print(index,'pp',1,1);
// if aresult=0 then
//  Raise Exception.Create(rp_lasterror);
 rp_close(index);
 // aresult:=rp_execute(index,'c:\prog\toni\reportman\repman\repsamples\sample2.pdf',0,1);
// if aresult=0 then
//  Raise Exception.Create(rp_lasterror);
end;

end.
